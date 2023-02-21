package palaiologos.kamilalisp.runtime.ide.editor;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rtextarea.RTextScrollPane;
import palaiologos.kamilalisp.atom.Pair;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.parsers.GrammarLexer;
import palaiologos.kamilalisp.runtime.ide.*;
import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;
import palaiologos.kamilalisp.runtime.remote.FixPacket;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;

import javax.swing.*;
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

    private static void setEnabled(Component component, boolean enabled) {
        component.setEnabled(enabled);
        if (component instanceof Container) {
            for (Component child : ((Container) component).getComponents()) {
                setEnabled(child, enabled);
            }
        }
    }

    public EditorPanel(IDE parent, TerminalPanel owner) {
        super(parent);
        this.owner = owner;
        area = RSTAFactory.build(this);
        scrollPane = new RTextScrollPane(area);
        scrollPane.setBorder(null);
        scrollPane.getGutter().setBorderColor(Color.decode("#1E222A"));
        add(scrollPane, BorderLayout.CENTER);

        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_S, InputEvent.CTRL_DOWN_MASK), "fix");
        getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).put(KeyStroke.getKeyStroke(KeyEvent.VK_Q, InputEvent.CTRL_DOWN_MASK), "exit");

        getActionMap().put("exit", new AbstractAction() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent e) {
                quit();
            }
        });

        getActionMap().put("fix", new AbstractAction() {
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
                    JLabel icon = new JLabel();
                    icon.setIcon(UIManager.getIcon("OptionPane.questionIcon"));
                    JTextField field = new JTextField(15);
                    JButton button = new JButton("Fix");
                    JButton cancel = new JButton("Cancel");
                    // Horizontal layout: group 1 is only icon, group 2 is the rest of components.
                    GroupLayout.SequentialGroup hGroup = layout.createSequentialGroup();
                    hGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.CENTER)
                            .addComponent(icon));
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
                            .addComponent(icon)
                            .addGroup(layout.createSequentialGroup()
                                    .addComponent(label)
                                    .addComponent(field)));
                    vGroup.addGroup(layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(button)
                            .addComponent(cancel));
                    layout.setVerticalGroup(vGroup);
                    button.addActionListener(e1 -> {
                        objectName = field.getText();
                        // Verify if objectName is a valid KamilaLisp identifier.
                        boolean valid = Parser.isValidIdentifier(objectName);
                        if (!valid) {
                            IDEErrorModal error = new IDEErrorModal(parent.statusBar.getCurrentDesktopPane(), "Invalid object name" + objectName);
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
                            owner.auxiliaryPacketQueue.add(new Pair<>(new FixPacket(objectName, area.getText()), (recv, sent) -> {
                                IDEPacket packet = (IDEPacket) recv.get();
                                frame.dispose();
                                if(packet.kind.equals("fix:ok")) {
                                    EditorPanel.setEnabled(EditorPanel.this, true);
                                } else {
                                    Throwable t = (Throwable) packet.data.get(0);
                                    StringWriter sw = new StringWriter();
                                    PrintWriter pw = new PrintWriter(sw);
                                    t.printStackTrace(pw);
                                    String errmsg = sw.toString();
                                    pw.close();
                                    try { sw.close(); } catch (IOException e2) { /* Unreachable */ }
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
                }
            }
        });
    }

    public void start() {
    }
}
