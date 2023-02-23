package palaiologos.kamilalisp.runtime.ide.editor;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rtextarea.RTextScrollPane;
import palaiologos.kamilalisp.atom.Pair;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.runtime.ide.*;
import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;
import palaiologos.kamilalisp.runtime.remote.FixPacket;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent;
import java.awt.*;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

public class EditorPanel extends TilingWMComponent {
    private final TerminalPanel owner;
    private final RSyntaxTextArea area;
    private final RTextScrollPane scrollPane;
    private String objectName = null;
    private JLabel name;

    public EditorPanel(IDE parent, TerminalPanel owner) {
        super(parent);
        this.owner = owner;
        area = RSTAFactory.build(this);
        scrollPane = new RTextScrollPane(area);
        scrollPane.setBorder(null);
        scrollPane.getGutter().setBorderColor(Color.decode("#1E222A"));
        JPanel topPanel = new JPanel(new FlowLayout());
        topPanel.setBackground(Color.decode("#10141C"));
        topPanel.setBorder(null);
        name = new JLabel("Untitled");
        name.setForeground(Color.decode("#FFFFFF"));
        name.setBackground(Color.decode("#10141C"));
        name.setOpaque(true);
        name.setBorder(new EmptyBorder(5, 5, 5, 5));
        JButton fix = new JButton();
        fix.setIcon(new ImageIcon(getClass().getResource("/ui/hammer.png")));
        fix.setBackground(Color.decode("#10141C"));
        JButton save = new JButton();
        save.setIcon(new ImageIcon(getClass().getResource("/ui/floppy-disk.png")));
        save.setBackground(Color.decode("#10141C"));
        JButton open = new JButton();
        open.setIcon(new ImageIcon(getClass().getResource("/ui/folder-open.png")));
        open.setBackground(Color.decode("#10141C"));
        JButton neu = new JButton();
        neu.setIcon(new ImageIcon(getClass().getResource("/ui/file.png")));
        neu.setBackground(Color.decode("#10141C"));
        JButton close = new JButton();
        close.setIcon(new ImageIcon(getClass().getResource("/ui/circle-xmark.png")));
        close.setBackground(Color.decode("#10141C"));
        topPanel.add(name);
        topPanel.add(neu);
        topPanel.add(open);
        topPanel.add(save);
        topPanel.add(fix);
        topPanel.add(close);
        add(topPanel, BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);

        close.addActionListener(e -> tryQuit());

        area.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void insertUpdate(DocumentEvent e) {
                if(!name.getText().endsWith(" *")) {
                    name.setText(name.getText() + " *");
                }
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                if(!name.getText().endsWith(" *")) {
                    name.setText(name.getText() + " *");
                }
            }

            @Override
            public void changedUpdate(DocumentEvent e) {
                if(!name.getText().endsWith(" *")) {
                    name.setText(name.getText() + " *");
                }
            }
        });

        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_S, InputEvent.CTRL_DOWN_MASK), "fix");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_Q, InputEvent.CTRL_DOWN_MASK), "exit");

        getActionMap().put("exit", new AbstractAction() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent e) {
                tryQuit();
            }
        });

        getActionMap().put("fix", new AbstractAction() {
            private void doFix() {
                owner.auxiliaryPacketQueue.add(new Pair<>(new FixPacket(objectName, area.getText()), (recv, sent) -> {
                    IDEPacket packet = (IDEPacket) recv.get();
                    if (packet.kind.equals("fix:ok")) {
                        EditorPanel.setEnabled(EditorPanel.this, true);
                        if(name.getText().endsWith(" *")) {
                            name.setText(name.getText().substring(0, name.getText().length() - 2));
                        }
                    } else {
                        Throwable t = (Throwable) packet.data.get(0);
                        StringWriter sw = new StringWriter();
                        PrintWriter pw = new PrintWriter(sw);
                        t.printStackTrace(pw);
                        String errmsg = sw.toString();
                        pw.close();
                        try {
                            sw.close();
                        } catch (IOException e2) { /* Unreachable */ }
                        IDETextAreaErrorModal error = new IDETextAreaErrorModal(parent.statusBar.getCurrentDesktopPane(), "Fix failed:", errmsg);
                        error.display(() -> {
                            EditorPanel.setEnabled(EditorPanel.this, true);
                            area.requestFocusInWindow();
                        });
                    }
                }));
                synchronized (owner.auxiliaryPacketQueue) {
                    owner.auxiliaryPacketQueue.notify();
                }
            }

            @Override
            public void actionPerformed(java.awt.event.ActionEvent e) {
                if (objectName == null) {
                    IDEModal frame = new IDEModal(parent.statusBar.getCurrentDesktopPane());
                    frame.setTitle("Fix");
                    frame.setMaximizable(false);
                    frame.setResizable(false);
                    frame.setClosable(true);
                    frame.setIconifiable(false);
                    frame.setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
                    JPanel contentPane = new JPanel();
                    contentPane.setBorder(null);
                    contentPane.setBackground(Color.decode("#10141C"));
                    frame.setContentPane(contentPane);
                    GroupLayout layout = new GroupLayout(contentPane);
                    contentPane.setLayout(layout);
                    layout.setAutoCreateGaps(true);
                    layout.setAutoCreateContainerGaps(true);
                    JLabel label = new JLabel("Object name:");
                    JTextField field = new JTextField(15);
                    JButton button = new JButton("Fix");
                    JButton cancel = new JButton("Cancel");
                    // Horizontal layout: group 1 is only icon, group 2 is the rest of components.
                    GroupLayout.SequentialGroup hGroup = layout.createSequentialGroup();
                    hGroup.addGroup(layout.createParallelGroup()
                            .addComponent(label)
                            .addComponent(field)
                            .addGroup(layout.createSequentialGroup()
                                    .addComponent(button)
                                    .addComponent(cancel)));
                    layout.setHorizontalGroup(hGroup);
                    // Vertical: group 1 is label and field, group 2 is buttons.
                    GroupLayout.SequentialGroup vGroup = layout.createSequentialGroup();
                    vGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addGroup(layout.createSequentialGroup()
                                    .addComponent(label)
                                    .addComponent(field)));
                    vGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(button)
                            .addComponent(cancel));
                    layout.setVerticalGroup(vGroup);
                    button.addActionListener(e1 -> {
                        // Verify if objectName is a valid KamilaLisp identifier.
                        boolean valid = Parser.isValidIdentifier(field.getText());
                        if (!valid) {
                            IDEErrorModal error = new IDEErrorModal(parent.statusBar.getCurrentDesktopPane(), "Invalid object name - \"" + objectName + "\"");
                            EditorPanel.setEnabled(frame, false);
                            error.display(() -> {
                                EditorPanel.setEnabled(frame, true);
                                try {
                                    frame.setSelected(true);
                                } catch (PropertyVetoException e2) {
                                    e2.printStackTrace();
                                }
                            });
                        } else {
                            objectName = field.getText();
                            name.setText(objectName);
                            frame.dispose();
                            doFix();
                        }
                    });
                    cancel.addActionListener(e1 -> frame.dispose());
                    frame.addInternalFrameListener(new InternalFrameAdapter() {
                        @Override
                        public void internalFrameClosed(InternalFrameEvent e) {
                            EditorPanel.setEnabled(EditorPanel.this, true);
                            area.requestFocusInWindow();
                        }
                    });
                    frame.display();
                    EditorPanel.setEnabled(EditorPanel.this, false);
                } else {
                    doFix();
                }
            }
        });
    }

    private void tryQuit() {
        // Check if the symbol name ends with " *". If it does, it means that the symbol has been modified.
        // If it has, ask the user if they want to fix the changes.
        if (name.getText().endsWith(" *")) {
            IDEModal frame = new IDEModal(parent.statusBar.getCurrentDesktopPane());
            frame.setTitle("Fix");
            frame.setMaximizable(false);
            frame.setResizable(false);
            frame.setClosable(true);
            frame.setIconifiable(false);
            frame.setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
            JPanel contentPane = new JPanel();
            contentPane.setBorder(null);
            contentPane.setBackground(Color.decode("#10141C"));
            frame.setContentPane(contentPane);
            GroupLayout layout = new GroupLayout(contentPane);
            contentPane.setLayout(layout);
            layout.setAutoCreateGaps(true);
            layout.setAutoCreateContainerGaps(true);
            JLabel label = new JLabel("Do you want to fix the changes before quitting?");
            JButton button = new JButton("Fix");
            JButton cancel = new JButton("Quit");
            // Horizontal layout: group 1 is only icon, group 2 is the rest of components.
            GroupLayout.SequentialGroup hGroup = layout.createSequentialGroup();
            hGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.CENTER)
                    .addComponent(label));
            hGroup.addGroup(layout.createParallelGroup()
                    .addGroup(layout.createSequentialGroup()
                            .addComponent(button)
                            .addComponent(cancel)));
            layout.setHorizontalGroup(hGroup);
            // Vertical: group 1 is label and field, group 2 is buttons.
            GroupLayout.SequentialGroup vGroup = layout.createSequentialGroup();
            vGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(label));
            vGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(button)
                    .addComponent(cancel));
            layout.setVerticalGroup(vGroup);
            button.addActionListener(e1 -> {
                frame.dispose();
                getActionMap().get("fix").actionPerformed(null);
                quit();
            });
            cancel.addActionListener(e1 -> frame.dispose());
            frame.addInternalFrameListener(new InternalFrameAdapter() {
                @Override
                public void internalFrameClosed(InternalFrameEvent e) {
                    EditorPanel.setEnabled(EditorPanel.this, true);
                    area.requestFocusInWindow();
                }
            });
            frame.display();
            EditorPanel.setEnabled(EditorPanel.this, false);
        } else {
            quit();
        }
    }

    private static void setEnabled(Component component, boolean enabled) {
        component.setEnabled(enabled);
        if (component instanceof Container) {
            for (Component child : ((Container) component).getComponents()) {
                setEnabled(child, enabled);
            }
        }
    }
}
