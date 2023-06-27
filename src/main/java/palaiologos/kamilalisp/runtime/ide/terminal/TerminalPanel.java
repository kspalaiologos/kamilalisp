package palaiologos.kamilalisp.runtime.ide.terminal;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import palaiologos.kamilalisp.atom.Pair;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.repl.JLineParser;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.ide.*;
import palaiologos.kamilalisp.runtime.ide.editor.EditorPanel;
import palaiologos.kamilalisp.runtime.remote.packet.IDEPacket;
import palaiologos.kamilalisp.runtime.remote.packet.Packet;
import palaiologos.kamilalisp.runtime.remote.packet.PromptPacket;
import palaiologos.kamilalisp.runtime.remote.packet.StringPacket;

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
    public final ConcurrentLinkedQueue<Pair<Packet, AuxiliaryPacketCallback>> auxiliaryPacketQueue = new ConcurrentLinkedQueue<>();
    final AtomicBoolean readingInput = new AtomicBoolean(true);
    final AtomicBoolean readingRawInput = new AtomicBoolean(false);
    final List<String> lines = new ArrayList<>();
    private final ReentrantLock terminalIO = new ReentrantLock();
    public List<Pair<Integer, Integer>> allowedHighlightRanges = new ArrayList<>();
    RSyntaxTextArea gutter;
    AllowedEditRange r;
    RSyntaxTextArea area;
    Thread t;
    int lineIndex = 0;
    Process localProcess;

    public TerminalPanel(IDE parent) {
        super(parent);
        area = RSTAFactory.build(this);
        r = new AllowedEditRange();
        ((AbstractDocument) area.getDocument()).setDocumentFilter(
                new NonEditableLineDocumentFilter(r));
        JScrollPane sp = new JScrollPane(area);
        sp.setBorder(null);
        add(sp, BorderLayout.CENTER);
        gutter = new RSyntaxTextArea(1, 4);
        gutter.setSyntaxEditingStyle("text/plain", this);
        gutter.setBackground(IDETheme.background);
        gutter.setForeground(IDETheme.foregroundColor);
        gutter.setEditable(false);
        gutter.setCurrentLineHighlightColor(IDETheme.background);
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
                    gutter.getDocument().insertString(gutter.getDocument().getLength(), (readingInput.get() ? "..." : "   ") + "\n", null);
                }
            }

            @Override
            public void insertUpdate(DocumentEvent e) {
                try {
                    int lastLine = area.getLineOfOffset(area.getDocument().getLength());
                    int lastLineStart = area.getLineStartOffset(lastLine);
                    int lastLineEnd = area.getLineEndOffset(lastLine);
                    String lastLineText = area.getText(lastLineStart, lastLineEnd - lastLineStart);
                    if (readingInput.get() && lastLineText.trim().isEmpty() && !(area.getDocument().getLength() == r.byteOffset)) {
                        // Maybe it's time to finish reading?
                        // Check if quotes are balanced.
                        String text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
                        // Ignore escapes.
                        if (JLineParser.isTerminated(text)) {
                            readingInput.set(false);
                            insertFixGutter();
                            synchronized (readingInput) {
                                readingInput.notify();
                            }
                        } else {
                            insertFixGutter();
                        }
                    } else if (readingRawInput.get() && lastLineText.trim().isEmpty() && !(area.getDocument().getLength() == r.byteOffset)) {
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
            public void changedUpdate(DocumentEvent arg0) {
            }
        });

        JScrollPane jspGutter = new JScrollPane(gutter);
        jspGutter.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
        jspGutter.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        jspGutter.setBorder(null);
        jspGutter.getVerticalScrollBar().setModel(sp.getVerticalScrollBar().getModel());
        jspGutter.setBorder(new MatteBorder(0, 0, 0, 1, IDETheme.borderColor));
        add(jspGutter, BorderLayout.WEST);

        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_BACK_SPACE, InputEvent.CTRL_DOWN_MASK | InputEvent.SHIFT_DOWN_MASK), "line-back");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, InputEvent.CTRL_DOWN_MASK | InputEvent.SHIFT_DOWN_MASK), "line-forward");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_H, InputEvent.CTRL_DOWN_MASK), "split-h");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_G, InputEvent.CTRL_DOWN_MASK), "split-v");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_Q, InputEvent.CTRL_DOWN_MASK), "kill");

        getActionMap().put("line-back", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    if (readingInput.get()) {
                        if (lines.size() == lineIndex)
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
                    if (readingInput.get()) {
                        if (lineIndex == 0)
                            return;
                        if (lineIndex == 1) {
                            lineIndex--;
                            // Remove everything from r.byteOffset to the end of the document.
                            area.getDocument().remove(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
                            return;
                        }
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
                TerminalPanel tp = new TerminalPanel(parent);
                horizontalSplit(tp);
                tp.start(null, 0);
            }
        });

        getActionMap().put("split-v", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                TerminalPanel tp = new TerminalPanel(parent);
                verticalSplit(tp);
                tp.start(null, 0);
            }
        });

        getActionMap().put("kill", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                localProcess.destroyForcibly();
                t.interrupt();
            }
        });
    }

    public void print(String s) {
        try {
            terminalIO.lock();
            SwingUtilities.invokeAndWait(() -> area.append(s));
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
                area.undoManager.discardAllEdits();
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
                for (int i = area.getText().length() - 1; i >= 0; i--) {
                    if (area.getText().charAt(i) == ' ')
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

        if (text.endsWith("\n"))
            text = text.substring(0, text.length() - 1);

        terminalIO.unlock();
        return text;
    }

    public String prompt(ObjectInputStream ois, ObjectOutputStream oos) {
        terminalIO.lock();
        try {
            SwingUtilities.invokeAndWait(() -> {
                if(!area.getText().endsWith("\n"))
                    area.append("\n");
                // If last line is empty, then replace the last gutter marker to become -->.
                // Otherwise just add a new one.
                if (!area.getText().isEmpty() && area.getText().charAt(area.getText().length() - 1) == '\n') {
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
                area.undoManager.discardAllEdits();
            });
        } catch (InterruptedException | InvocationTargetException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        allowedHighlightRanges.add(new Pair<>(r.start, Integer.MAX_VALUE));

        synchronized (readingInput) {
            while (readingInput.get()) {
                try {
                    readingInput.wait(1L);
                } catch (InterruptedException e) {
                    terminalIO.unlock();
                    throw new RuntimeException(e);
                }
                if (!auxiliaryPacketQueue.isEmpty()) {
                    var aux = auxiliaryPacketQueue.poll();
                    try {
                        oos.writeObject(aux.fst());
                    } catch (IOException e) {
                        terminalIO.unlock();
                        throw new RuntimeException(e);
                    }
                    if (aux.snd() != null) {
                        aux.snd().onSent(() -> {
                            Packet pckt;
                            try {
                                pckt = (Packet) ois.readObject();
                            } catch (IOException | ClassNotFoundException e) {
                                throw new RuntimeException(e);
                            }
                            return pckt;
                        }, (pckt) -> {
                            try {
                                oos.writeObject(pckt);
                                oos.flush();
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                        });
                    }
                }
            }
        }

        try {
            SwingUtilities.invokeAndWait(() -> {
                // Count trailing spaces in document text.
                int trailingSpaces = 0;
                for (int i = area.getText().length() - 1; i >= 0; i--) {
                    if (area.getText().charAt(i) == ' ')
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

        try {
            allowedHighlightRanges.set(allowedHighlightRanges.size() - 1,
                    new Pair<>(allowedHighlightRanges.get(allowedHighlightRanges.size() - 1).fst(), area.getLineOfOffset(area.getDocument().getLength())));
        } catch (BadLocationException e) {
            terminalIO.unlock();
            throw new RuntimeException(e);
        }

        String text;
        try {
            text = area.getText(r.byteOffset, area.getDocument().getLength() - r.byteOffset);
            synchronized (lines) {
                lineIndex = 0;
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

    public void start(String host, int port) {
        t = new Thread(new Runnable() {
            private ObjectInputStream ois;
            private ObjectOutputStream oos;
            private final Map<String, Consumer<IDEPacket>> asyncIdeFunctions = Map.ofEntries(
                    Map.entry("io:readln", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            String s = promptRaw();
                            sendPacket(new IDEPacket("io:readln", List.of(s)));
                        }
                    })
            );            private final Map<String, Consumer<IDEPacket>> ideFunctions = Map.ofEntries(
                    Map.entry("term:clear", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            area.setText("");
                            gutter.setText("");
                            allowedHighlightRanges.clear();
                        }
                    }),
                    Map.entry("ide:workspace:add", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            if (o.data.size() == 1) {
                                String name = (String) o.data.get(0);
                                if (parent.statusBar.hasWorkspace(name))
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
                            if (ob instanceof String name) {
                                parent.statusBar.selectWorkspace(name);
                            } else if (ob instanceof Integer) {
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
                            if (ob instanceof String name) {
                                String newName = (String) o.data.get(1);
                                parent.statusBar.renameWorkspace(name, newName);
                            } else if (ob instanceof Integer) {
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
                            if (o.data.isEmpty())
                                TerminalPanel.this.getActionMap().get("split-h").actionPerformed(null);
                            else {
                                String kind = (String) o.data.get(0);
                                if (kind.equals("editor")) {
                                    horizontalSplit(new EditorPanel(parent, TerminalPanel.this));
                                } else if (kind.equals("remote")) {
                                    TerminalPanel tp = new TerminalPanel(parent);
                                    horizontalSplit(tp);
                                    tp.start((String) o.data.get(1), (int) o.data.get(2));
                                } else {
                                    throw new TypeError("Unknown split kind: " + kind);
                                }
                            }
                        }
                    }),
                    Map.entry("ide:split-v", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket o) {
                            if (o.data.isEmpty())
                                TerminalPanel.this.getActionMap().get("split-v").actionPerformed(null);
                            else {
                                String kind = (String) o.data.get(0);
                                if (kind.equals("editor")) {
                                    verticalSplit(new EditorPanel(parent, TerminalPanel.this));
                                } else if (kind.equals("remote")) {
                                    TerminalPanel tp = new TerminalPanel(parent);
                                    verticalSplit(tp);
                                    tp.start((String) o.data.get(1), (int) o.data.get(2));
                                } else {
                                    throw new TypeError("Unknown split kind: " + kind);
                                }
                            }
                        }
                    }),
                    Map.entry("ide:fix-project", new Consumer<IDEPacket>() {
                        @Override
                        public void accept(IDEPacket idePacket) {
                            ByteArrayOutputStream baos = new ByteArrayOutputStream();
                            try {
                                parent.project.dataRegistry.serialiseTo(baos);
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                            String code = baos.toString();
                            sendPacket(new StringPacket(code));
                        }
                    })
            );

            private void sendPacket(Packet p) {
                try {
                    oos.writeObject(p);
                    oos.flush();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void run() {
                // TODO: Do.
                String myHost = host;
                int myPort = port;
                if (myHost == null) {
                    try {
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
                        localProcess = builder.start();
                        BufferedReader reader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));
                        myPort = Integer.parseInt(reader.readLine());
                        myHost = "localhost";
                        reader.close();
                        Runtime.getRuntime().addShutdownHook(new Thread(localProcess::destroy));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    localProcess = null;
                }
                try {
                    // Connect to the remote.
                    Socket socket = new Socket(myHost, myPort);
                    // Create the streams.
                    oos = new ObjectOutputStream(new OutputStream() {
                        @Override
                        public void write(int b) throws IOException {
                            NetCounter.addOut(1);
                            socket.getOutputStream().write(b);
                        }

                        @Override
                        public void write(byte[] b, int off, int len) throws IOException {
                            NetCounter.addOut(len);
                            socket.getOutputStream().write(b, off, len);
                        }
                    });
                    ois = new ObjectInputStream(new InputStream() {
                        @Override
                        public int read() throws IOException {
                            NetCounter.addIn(1);
                            return socket.getInputStream().read();
                        }

                        @Override
                        public int read(byte[] b, int off, int len) throws IOException {
                            NetCounter.addIn(len);
                            return socket.getInputStream().read(b, off, len);
                        }
                    });
                    while (true) {
                        Packet p = (Packet) ois.readObject();
                        if (p instanceof PromptPacket) {
                            String code = TerminalPanel.this.prompt(ois, oos).trim();
                            oos.writeObject(new StringPacket(code));
                        } else if (p instanceof StringPacket) {
                            TerminalPanel.this.print(((StringPacket) p).data);
                        } else if (p instanceof IDEPacket ip) {
                            if (ideFunctions.containsKey(ip.kind)) {
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
                                } catch (Throwable e) {
                                    t = e;
                                }
                                if (t != null) {
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
                    t.printStackTrace();
                    if (localProcess != null && localProcess.isAlive())
                        localProcess.destroyForcibly();
                    SwingUtilities.invokeLater(() -> quit());
                }
            }


        });
        t.start();
    }

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
            if (string != null) {
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
            if (!readingInput.get() && !readingRawInput.get()) {
                fb.replace(offset, length, text, attrs);
                return;
            }
            if (r.start == -1)
                return;
            if (offset >= r.byteOffset) {
                fb.replace(offset, length, text, attrs);
            }
        }
    }
}
