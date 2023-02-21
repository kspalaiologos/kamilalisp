package palaiologos.kamilalisp.runtime.ide.terminal;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import palaiologos.kamilalisp.atom.Pair;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.ide.IDE;
import palaiologos.kamilalisp.runtime.ide.RSTAFactory;
import palaiologos.kamilalisp.runtime.ide.TilingWMComponent;
import palaiologos.kamilalisp.runtime.ide.editor.EditorPanel;
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
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.ReentrantLock;
import java.util.function.Consumer;

public class TerminalPanel extends TilingWMComponent {
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
            if(!readingInput.get() && !readingRawInput.get()) {
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

    private final ReentrantLock terminalIO = new ReentrantLock();

    public void print(String s) {
        try {
            terminalIO.lock();
            SwingUtilities.invokeAndWait(() -> {
                area.append(s);
            });
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        } finally {
            terminalIO.unlock();
        }
    }

    public void println(String s) {
        try {
            terminalIO.lock();
            SwingUtilities.invokeAndWait(() -> {
                area.append(s);
                area.append("\n");
            });
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        } finally {
            terminalIO.unlock();
        }
    }

    public String promptRaw() {
        terminalIO.lock();
        try {
            SwingUtilities.invokeAndWait(() -> {
                gutter.append("   \n");
                try {
                    r.byteOffset = area.getDocument().getLength();
                    r.start = area.getLineOfOffset(r.byteOffset);
                } catch (BadLocationException e) {
                    throw new RuntimeException(e);
                }
                readingRawInput.set(true);
            });
        } catch (InterruptedException | InvocationTargetException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        synchronized (readingRawInput) {
            while (readingRawInput.get()) {
                try {
                    readingRawInput.wait();
                } catch (InterruptedException e) {
                    terminalIO.unlock();
                    throw new RuntimeException(e);
                }
            }
        }

        try {
            SwingUtilities.invokeAndWait(() -> {
                // Count trailing spaces in document text.
                int trailingSpaces = 0;
                for(int i = area.getText().length() - 1; i >= 0; i--) {
                    if(area.getText().charAt(i) == ' ')
                        trailingSpaces++;
                    else
                        break;
                }
                // Remove trailing spaces.
                try {
                    area.getDocument().remove(area.getText().length() - trailingSpaces, trailingSpaces);
                } catch (BadLocationException e) {
                    throw new RuntimeException(e);
                }
            });
        } catch (InterruptedException | InvocationTargetException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        String text;
        try {
            text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
            r.byteOffset = 0;
            r.start = -1;
        } catch (BadLocationException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        if(text.endsWith("\n"))
            text = text.substring(0, text.length() - 1);

        terminalIO.unlock();
        return text;
    }

    public String prompt() {
        terminalIO.lock();
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
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        synchronized (readingInput) {
            while (readingInput.get()) {
                try {
                    readingInput.wait();
                } catch (InterruptedException e) {
                    terminalIO.unlock();
                    throw new RuntimeException(e);
                }
            }
        }

        try {
            SwingUtilities.invokeAndWait(() -> {
                // Count trailing spaces in document text.
                int trailingSpaces = 0;
                for(int i = area.getText().length() - 1; i >= 0; i--) {
                    if(area.getText().charAt(i) == ' ')
                        trailingSpaces++;
                    else
                        break;
                }
                // Remove trailing spaces.
                try {
                    area.getDocument().remove(area.getText().length() - trailingSpaces, trailingSpaces);
                } catch (BadLocationException e) {
                    throw new RuntimeException(e);
                }
            });
        } catch (InterruptedException | InvocationTargetException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        String text;
        try {
            text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
            synchronized (lines) {
                lines.add(text.substring(0, text.length() - 1));
            }
            r.byteOffset = 0;
            r.start = -1;
        } catch (BadLocationException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }
        terminalIO.unlock();
        return text;
    }

    private ConcurrentLinkedQueue<Packet> auxiliaryPacketQueue = new ConcurrentLinkedQueue<>();

    RSyntaxTextArea gutter;
    final AtomicBoolean readingInput = new AtomicBoolean(true);
    final AtomicBoolean readingRawInput = new AtomicBoolean(false);
    AllowedEditRange r;
    RSyntaxTextArea area;
    Thread t;
    final List<String> lines = new ArrayList<>();
    int lineIndex = 0;
    Process localProcess;

    public TerminalPanel(IDE parent) {
        super(parent);
        area = RSTAFactory.build();
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
                    int lastLine = area.getLineOfOffset(area.getDocument().getLength());
                    int lastLineStart = area.getLineStartOffset(lastLine);
                    int lastLineEnd = area.getLineEndOffset(lastLine);
                    String lastLineText = area.getText(lastLineStart, lastLineEnd - lastLineStart);
                    if(readingInput.get() && lastLineText.trim().isEmpty() && !(area.getDocument().getLength() == r.byteOffset)) {
                        // Maybe it's time to finish reading?
                        // Check if quotes are balanced.
                        String text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
                        // Ignore escapes.
                        String q = text.replace("\\\"", "");
                        long amount = q.chars().filter(ch -> ch == '"').count();
                        // Eek. Unbalanced quotes.
                        if(amount % 2 != 0)
                            { insertFixGutter(); return; }
                        // OK, quotes are balanced. Remove every instance of quotation in the input.
                        q = q.replaceAll("\"[^\"]*\"", "");
                        // Count open and closed parens.
                        long open = q.chars().filter(ch -> ch == '(').count();
                        long closed = q.chars().filter(ch -> ch == ')').count();
                        if(open != closed)
                            { insertFixGutter(); return; }
                        // Count open and closed braces.
                        open = q.chars().filter(ch -> ch == '{').count();
                        closed = q.chars().filter(ch -> ch == '}').count();
                        if(open != closed)
                            { insertFixGutter(); return; }
                        // Count open and closed brackets.
                        open = q.chars().filter(ch -> ch == '[').count();
                        closed = q.chars().filter(ch -> ch == ']').count();
                        if(open != closed)
                            { insertFixGutter(); return; }
                        // OK, it appears that we are done reading the input...
                        readingInput.set(false);
                        insertFixGutter();
                        synchronized (readingInput) {
                            readingInput.notify();
                        }
                    } else if(readingRawInput.get() && lastLineText.trim().isEmpty() && !(area.getDocument().getLength() == r.byteOffset)) {
                        readingRawInput.set(false);
                        insertFixGutter();
                        synchronized (readingRawInput) {
                            readingRawInput.notify();
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

            private final Map<String, Consumer<IDEPacket>> ideFunctions = Map.ofEntries(
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
                            if(ob instanceof String name) {
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
                            if(ob instanceof String name) {
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
                    }),
                    Map.entry("ide:split-h", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            if(o.data.isEmpty())
                                TerminalPanel.this.getActionMap().get("split-h").actionPerformed(null);
                            else {
                                String kind = (String) o.data.get(0);
                                switch(kind) {
                                    case "editor": {
                                        horizontalSplit(new EditorPanel(parent, TerminalPanel.this));
                                        break;
                                    }
                                    default: {
                                        throw new TypeError("Unknown split kind: " + kind);
                                    }
                                }
                            }
                        }
                    }),
                    Map.entry("ide:split-v", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            if(o.data.isEmpty())
                                TerminalPanel.this.getActionMap().get("split-v").actionPerformed(null);
                            else {
                                String kind = (String) o.data.get(0);
                                switch(kind) {
                                    case "editor": {
                                        verticalSplit(new EditorPanel(parent, TerminalPanel.this));
                                        break;
                                    }
                                    default: {
                                        throw new TypeError("Unknown split kind: " + kind);
                                    }
                                }
                            }
                        }
                    })
            );

            private final Map<String, Consumer<IDEPacket>> asyncIdeFunctions = Map.ofEntries(
                    Map.entry("io:readln", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            String s = promptRaw();
                            sendPacket(new IDEPacket("io:readln", List.of(s)));
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
                    localProcess = builder.start();
                    // Read the output.
                    BufferedReader reader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));
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
                            if(!auxiliaryPacketQueue.isEmpty()) {
                                Packet aux = auxiliaryPacketQueue.poll();
                                oos.writeObject(aux);
                            } else {
                                String code = TerminalPanel.this.prompt().trim();
                                oos.writeObject(new StringPacket(code));
                            }
                        } else if (p instanceof StringPacket) {
                            TerminalPanel.this.print(((StringPacket) p).data);
                        } else if (p instanceof IDEPacket ip) {
                            if(ideFunctions.containsKey(ip.kind)) {
                                IDE.invokeSwing(() -> {
                                    Throwable t = null;
                                    try {
                                        ideFunctions.get(ip.kind).accept(ip);
                                    } catch (Throwable e) {
                                        t = e;
                                    }
                                    if (t == null) {
                                        sendPacket(new IDEPacket("ide:ok", List.of()));
                                    } else {
                                        sendPacket(new IDEPacket("ide:err", List.of(t)));
                                    }
                                });
                            } else {
                                Throwable t = null;
                                try {
                                    asyncIdeFunctions.get(ip.kind).accept(ip);
                                } catch(Throwable e) {
                                    t = e;
                                }
                                if(t != null) {
                                    sendPacket(new IDEPacket("ide:err", List.of(t)));
                                } else {
                                    sendPacket(new IDEPacket("ide:ok", List.of()));
                                }
                            }
                        } else {
                            throw new RuntimeException("Unknown packet type: " + p.getClass().getName());
                        }
                    }
                } catch (Throwable t) {
                    quit();
                }
            }
        });

        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_BACK_SPACE, InputEvent.CTRL_DOWN_MASK | InputEvent.SHIFT_DOWN_MASK), "line-back");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, InputEvent.CTRL_DOWN_MASK | InputEvent.SHIFT_DOWN_MASK), "line-forward");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_H, InputEvent.CTRL_DOWN_MASK), "split-h");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_G, InputEvent.CTRL_DOWN_MASK), "split-v");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_Q, InputEvent.CTRL_DOWN_MASK), "kill");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_W, InputEvent.CTRL_DOWN_MASK), "version");

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

        getActionMap().put("split-h", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                horizontalSplit(new TerminalPanel(parent));
            }
        });

        getActionMap().put("split-v", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                verticalSplit(new TerminalPanel(parent));
            }
        });

        getActionMap().put("kill", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                localProcess.destroyForcibly();
                t.interrupt();
            }
        });

        getActionMap().put("version", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane pane = new JOptionPane("v0.2", JOptionPane.INFORMATION_MESSAGE, JOptionPane.DEFAULT_OPTION);
                JInternalFrame frame = pane.createInternalFrame(parent.statusBar.getCurrentDesktopPane(), "KamilaLisp Version");
                frame.setVisible(true);
            }
        });
    }

    public void start() {
        t.start();
    }
}
