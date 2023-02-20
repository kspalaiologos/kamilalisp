package palaiologos.kamilalisp.runtime.ide.terminal;

import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.fife.ui.rsyntaxtextarea.*;
import org.fife.ui.rtextarea.RTextArea;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.ide.IDE;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;
import palaiologos.kamilalisp.runtime.remote.Packet;
import palaiologos.kamilalisp.runtime.remote.PromptPacket;
import palaiologos.kamilalisp.runtime.remote.StringPacket;

import javax.swing.*;
import javax.swing.border.MatteBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.AbstractDocument;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.DocumentFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.function.Consumer;

public class TerminalPanel extends JPanel {
    private static class AllowedEditRange {
        int start;
        int byteOffset;
        AllowedEditRange() {
            this.start = -1;
            this.byteOffset = 0;
        }
    }

    private class NonEditableLineDocumentFilter extends DocumentFilter {
        private final AllowedEditRange r;

        public NonEditableLineDocumentFilter(AllowedEditRange r) {
            this.r = r;
        }

        @Override
        public void insertString(DocumentFilter.FilterBypass fb, int offset, String string, AttributeSet attr) throws BadLocationException {
            if(string != null) {
                replace(fb, offset, 0, string, attr);
            }
        }

        @Override
        public void remove(DocumentFilter.FilterBypass fb, int offset, int length) throws BadLocationException {
            replace(fb, offset, length, "", null);
        }

        @Override
        public void replace(DocumentFilter.FilterBypass fb, int offset, int length, String text, AttributeSet attrs) throws BadLocationException {
            // Our goal: only allow edits that start on line r.start forward.
            // If the edit is not within the allowed range, we will not perform it.
            if(!readingInput.get()) {
                fb.replace(offset, length, text, attrs);
                return;
            }
            if(r.start == -1)
                return;
            if(fb.getDocument().getText(0, offset).chars().filter(x -> x == '\n').count() >= r.start) {
                fb.replace(offset, length, text, attrs);
            }
        }
    }

    public void print(String s) {
        try {
            SwingUtilities.invokeAndWait(() -> {
                area.append(s);
            });
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    public void println(String s) {
        try {
            SwingUtilities.invokeAndWait(() -> {
                area.append(s);
                area.append("\n");
            });
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    public String prompt() {
        try {
            SwingUtilities.invokeAndWait(() -> {
                // If last line is empty, then replace the last gutter marker to become -->.
                // Otherwise just add a new one.
                if(!area.getText().isEmpty() && area.getText().charAt(area.getText().length() - 1) == '\n') {
                    try {
                        gutter.getDocument().remove(gutter.getText().length() - 4, 4);
                    } catch (BadLocationException e) {
                        throw new RuntimeException(e);
                    }
                }
                gutter.append("-->\n");
                try {
                    r.byteOffset = area.getDocument().getLength();
                    r.start = area.getLineOfOffset(r.byteOffset);
                } catch (BadLocationException e) {
                    throw new RuntimeException(e);
                }
                readingInput.set(true);
            });
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }

        synchronized (readingInput) {
            while (readingInput.get()) {
                try {
                    readingInput.wait();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        try {
            String text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
            synchronized (lines) {
                lines.add(text.substring(0, text.length() - 1));
            }
            r.byteOffset = 0;
            r.start = -1;
            return text;
        } catch (BadLocationException e) {
            throw new RuntimeException(e);
        }
    }

    RSyntaxTextArea gutter;
    final AtomicBoolean readingInput = new AtomicBoolean(true);
    AllowedEditRange r;
    RSyntaxTextArea area;
    Thread t;
    final List<String> lines = new ArrayList<>();
    int lineIndex = 0;
    private IDE parent;

    public TerminalPanel(IDE parent) {
        this.parent = parent;
        setBackground(Color.decode("#10141C"));
        setBorder(null);
        setLayout(new BorderLayout());
        area = new RSyntaxTextArea();
        area.setBackground(Color.decode("#10141C"));
        area.setCurrentLineHighlightColor(Color.decode("#1E222A"));
        AbstractTokenMakerFactory atmf = (AbstractTokenMakerFactory) TokenMakerFactory.getDefaultInstance();
        atmf.putMapping("text/kamilalisp-term", "palaiologos.kamilalisp.runtime.ide.terminal.TerminalKamilaLispTokenMaker");
        area.setSyntaxEditingStyle("text/kamilalisp-term");
        area.setAntiAliasingEnabled(true);
        area.setFont(IDE.aplFont);
        area.setCaretColor(Color.decode("#D5D5D5"));
        area.setForeground(Color.decode("#E6E6E6"));
        SyntaxScheme scheme = area.getSyntaxScheme();
        scheme.getStyle(Token.COMMENT_EOL).foreground = Color.decode("#676B79");
        scheme.getStyle(Token.LITERAL_NUMBER_DECIMAL_INT).foreground = Color.decode("#FFB86C");
        scheme.getStyle(Token.LITERAL_NUMBER_FLOAT).foreground = Color.decode("#FFB86C");
        scheme.getStyle(Token.LITERAL_CHAR).foreground = Color.decode("#FFB86C");
        scheme.getStyle(Token.LITERAL_BOOLEAN).foreground = Color.decode("#45A9F9");
        scheme.getStyle(Token.VARIABLE).foreground = Color.decode("#E6E6E6");
        scheme.getStyle(Token.RESERVED_WORD).foreground = Color.decode("#FF75B5");
        scheme.getStyle(Token.OPERATOR).foreground = Color.decode("#B084EB");
        scheme.getStyle(Token.FUNCTION).foreground = Color.decode("#FFCC95");
        scheme.getStyle(Token.LITERAL_STRING_DOUBLE_QUOTE).foreground = Color.decode("#6FC1FF");
        r = new AllowedEditRange();
        ((AbstractDocument)area.getDocument()).setDocumentFilter(
                new NonEditableLineDocumentFilter(r));
        JScrollPane sp = new JScrollPane(area);
        sp.setBorder(null);
        add(sp, BorderLayout.CENTER);
        gutter = new RSyntaxTextArea(1,4);
        gutter.setSyntaxEditingStyle("text/plain");
        gutter.setBackground(Color.decode("#10141C"));
        gutter.setForeground(Color.decode("#E6E6E6"));
        gutter.setEditable(false);
        gutter.setCurrentLineHighlightColor(Color.decode("#10141C"));
        gutter.setFont(IDE.aplFont);
        gutter.setText("");
        gutter.setBorder(null);
        area.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void removeUpdate(DocumentEvent e) {
                try {
                    // Count the amount of lines in the document now.
                    int lines = area.getLineOfOffset(area.getDocument().getLength()) + 1;
                    // Remove last line from the gutter until the amount of lines in the document is equal to the amount of lines in the gutter.
                    while (gutter.getLineCount() - 1 > lines) {
                        gutter.getDocument().remove(gutter.getText().length() - 4, 4);
                    }
                } catch (BadLocationException e1) {
                    e1.printStackTrace();
                }
            }

            private void insertFixGutter() throws BadLocationException {
                // Count the amount of lines in the document now.
                int lines = area.getLineOfOffset(area.getDocument().getLength()) + 1;
                // Add a new line to the gutter until the amount of lines in the document is equal to the amount of lines in the gutter.
                while (gutter.getLineCount() - 1 < lines) {
                    gutter.getDocument().insertString(gutter.getDocument().getLength(), (readingInput.get() ? "..." : "   ") + System.lineSeparator(), null);
                }
            }

            @Override
            public void insertUpdate(DocumentEvent e) {
                try {
                    if(readingInput.get() && area.getDocument().getText(area.getDocument().getLength() - 1, 1).equals("\n")
                            && !(area.getDocument().getLength() == r.byteOffset)) {
                        // Maybe it's time to finish reading?
                        // Check if quotes are balanced.
                        String text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
                        // Ignore escapes.
                        String q = text.replace("\\\"", "");
                        long amount = q.chars().filter(ch -> ch == '"').count();
                        // Eek. Unbalanced quotes.
                        if(amount % 2 != 0)
                            insertFixGutter();
                        // OK, quotes are balanced. Remove every instance of quotation in the input.
                        q = q.replaceAll("\"[^\"]*\"", "");
                        // Count open and closed parens.
                        long open = q.chars().filter(ch -> ch == '(').count();
                        long closed = q.chars().filter(ch -> ch == ')').count();
                        if(open != closed)
                            insertFixGutter();
                        // Count open and closed braces.
                        open = q.chars().filter(ch -> ch == '{').count();
                        closed = q.chars().filter(ch -> ch == '}').count();
                        if(open != closed)
                            insertFixGutter();
                        // Count open and closed brackets.
                        open = q.chars().filter(ch -> ch == '[').count();
                        closed = q.chars().filter(ch -> ch == ']').count();
                        if(open != closed)
                            insertFixGutter();
                        // OK, it appears that we are done reading the input...
                        readingInput.set(false);
                        insertFixGutter();
                        synchronized (readingInput) {
                            readingInput.notify();
                        }
                    } else {
                        insertFixGutter();
                    }
                } catch (BadLocationException e1) {
                    e1.printStackTrace();
                }
            }

            @Override
            public void changedUpdate(DocumentEvent arg0) { }
        });

        JScrollPane jspGutter = new JScrollPane(gutter);
        jspGutter.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
        jspGutter.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        jspGutter.setBorder(null);
        jspGutter.getVerticalScrollBar().setModel(sp.getVerticalScrollBar().getModel());
        jspGutter.setBorder(new MatteBorder(0, 0, 0, 1, Color.decode("#1E222A")));
        add(jspGutter, BorderLayout.WEST);

        t = new Thread(new Runnable() {
            private ObjectInputStream ois;
            private ObjectOutputStream oos;

            private void sendPacket(Packet p) {
                try {
                    oos.writeObject(p);
                    oos.flush();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            private Map<String, Consumer<IDEPacket>> ideFunctions = Map.ofEntries(
                    Map.entry("term:clear", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            area.setText("");
                            gutter.setText("");
                        }
                    }),
                    Map.entry("ide:workspace:add", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            if (o.data.size() == 1) {
                                String name = (String) o.data.get(0);
                                if(parent.statusBar.hasWorkspace(name))
                                    throw new RuntimeException("Workspace already exists!");
                                parent.statusBar.addWorkspace(name);
                            } else {
                                parent.statusBar.addWorkspace();
                            }
                        }
                    }),
                    Map.entry("ide:workspace:has", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            String name = (String) o.data.get(0);
                            boolean r = parent.statusBar.hasWorkspace(name);
                            sendPacket(new IDEPacket("ide:workspace:has", List.of(r)));
                        }
                    }),
                    Map.entry("ide:workspace:delete", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            String name = (String) o.data.get(0);
                            parent.statusBar.deleteWorkspace(name);
                        }
                    }),
                    Map.entry("ide:workspace:select", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            Object ob = o.data.get(0);
                            if(ob instanceof String) {
                                String name = (String) ob;
                                parent.statusBar.selectWorkspace(name);
                            } else if(ob instanceof Integer) {
                                int index = (int) ob;
                                parent.statusBar.selectWorkspace(index);
                            } else {
                                throw new TypeError("Expected String or Integer, got " + ob.getClass().getName());
                            }
                        }
                    }),
                    Map.entry("ide:workspace:rename", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            Object ob = o.data.get(0);
                            if(ob instanceof String) {
                                String name = (String) ob;
                                String newName = (String) o.data.get(1);
                                parent.statusBar.renameWorkspace(name, newName);
                            } else if(ob instanceof Integer) {
                                int index = (int) ob;
                                String newName = (String) o.data.get(1);
                                parent.statusBar.renameWorkspace(index, newName);
                            } else {
                                throw new TypeError("Expected String or Integer, got " + ob.getClass().getName());
                            }
                        }
                    }),
                    Map.entry("ide:workspace:swap", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            int src = (int) o.data.get(0);
                            int dst = (int) o.data.get(1);
                            parent.statusBar.swapWorkspaces(src, dst);
                        }
                    }),
                    Map.entry("ide:workspace:current", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            Pair<Integer, String> p = parent.statusBar.currentWorkspace();
                            sendPacket(new IDEPacket("ide:workspace:current", List.of(p.fst(), p.snd())));
                        }
                    })
            );

            @Override
            public void run() {
                // TODO: Do.
                String javaHome = System.getProperty("java.home");
                String javaBin = javaHome + File.separator + "bin" + File.separator + "java";
                String classpath = System.getProperty("java.class.path");
                String className = Main.class.getName();
                List<String> command = new ArrayList<>();
                command.add(javaBin);
                command.add("-cp");
                command.add(classpath);
                command.add(className);
                command.add("--remote");
                ProcessBuilder builder = new ProcessBuilder(command);
                try {
                    Process process = builder.start();
                    // Read the output.
                    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                    int port = Integer.parseInt(reader.readLine());
                    // Close the reader.
                    reader.close();
                    // Connect to the remote.
                    Socket socket = new Socket("localhost", port);
                    // Create the streams.
                    oos = new ObjectOutputStream(socket.getOutputStream());
                    ois = new ObjectInputStream(socket.getInputStream());
                    while (true) {
                        Packet p = (Packet) ois.readObject();
                        if (p instanceof PromptPacket) {
                            String code = TerminalPanel.this.prompt().trim();
                            oos.writeObject(new StringPacket(code));
                        } else if (p instanceof StringPacket) {
                            TerminalPanel.this.print(((StringPacket) p).data);
                        } else if (p instanceof IDEPacket) {
                            IDEPacket idep = (IDEPacket) p;
                            IDE.invokeSwing(() -> {
                                Throwable t = null;
                                try {
                                    ideFunctions.get(idep.kind).accept(idep);
                                } catch (Throwable e) {
                                    t = e;
                                }
                                if(t == null) {
                                    sendPacket(new IDEPacket("ide:ok", List.of()));
                                } else {
                                    sendPacket(new IDEPacket("ide:err", List.of(t)));
                                }
                            });
                        } else {
                            throw new RuntimeException("Unknown packet type: " + p.getClass().getName());
                        }
                    }
                } catch (IOException | ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }
            }
        });

        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_BACK_SPACE, InputEvent.CTRL_DOWN_MASK | InputEvent.SHIFT_DOWN_MASK), "line-back");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, InputEvent.CTRL_DOWN_MASK | InputEvent.SHIFT_DOWN_MASK), "line-forward");

        getActionMap().put("line-back", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    if(readingInput.get()) {
                        if(lines.size() == lineIndex)
                            return;
                        lineIndex++;
                        // Remove everything from r.byteOffset to the end of the document.
                        area.getDocument().remove(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
                        // Append lines[lines.size() - 1 - lineIndex] to the document.
                        area.append(lines.get(lines.size() - lineIndex));
                    }
                } catch (BadLocationException e1) {
                    e1.printStackTrace();
                }
            }
        });

        getActionMap().put("line-forward", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    if(readingInput.get()) {
                        if(lines.size() + 1 != lineIndex)
                            return;
                        lineIndex--;
                        // Remove everything from r.byteOffset to the end of the document.
                        area.getDocument().remove(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
                        // Append lines[lines.size() - 1 - lineIndex] to the document.
                        area.append(lines.get(lines.size() - lineIndex));
                    }
                } catch (BadLocationException e1) {
                    e1.printStackTrace();
                }
            }
        });
    }

    public TerminalPanel start() {
        t.start();
        return this;
    }
}
