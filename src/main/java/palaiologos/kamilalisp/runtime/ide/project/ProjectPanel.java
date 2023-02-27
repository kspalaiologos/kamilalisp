package palaiologos.kamilalisp.runtime.ide.project;

import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.runtime.ide.IDE;
import palaiologos.kamilalisp.runtime.ide.modal.*;
import palaiologos.kamilalisp.runtime.ide.TilingWMComponent;

import javax.swing.*;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyVetoException;
import java.io.*;
import java.util.Objects;
import java.util.function.Consumer;

public class ProjectPanel extends TilingWMComponent {
    public ProjectDataRegistry dataRegistry;
    public JList<String> projectTree;
    public DefaultListModel<String> projectTreeModel = new DefaultListModel<>();
    public boolean unsavedChanges = false;
    public JButton neu, open, save, export;

    private static JLabel makeSeparator() {
        JLabel separator = new JLabel(" | ");
        separator.setFont(IDE.apl333Font);
        separator.setOpaque(true);
        separator.setBackground(Color.decode("#10141C"));
        separator.setForeground(Color.decode("#FFFFFF"));
        return separator;
    }

    private static JLabel makeLabel(String caption) {
        JLabel label = new JLabel(caption);
        label.setFont(IDE.apl333Font);
        label.setOpaque(true);
        label.setBackground(Color.decode("#10141C"));
        label.setForeground(Color.decode("#FFFFFF"));
        return label;
    }

    public ProjectPanel(IDE parent) {
        super(parent);
        dataRegistry = new ProjectDataRegistry(parent);
        JPanel topPanel = new JPanel();
        topPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
        topPanel.setBorder(BorderFactory.createMatteBorder(2, 0, 0, 0, Color.decode("#1E222A")));
        topPanel.setBackground(Color.decode("#10141C"));
        JLabel projectLabel = makeLabel("Project");
        topPanel.add(projectLabel);
        JLabel projectNamespace = makeLabel("");
        topPanel.add(projectNamespace);
        neu = new JButton();
        neu.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/file.png"))));
        neu.setBackground(Color.decode("#10141C"));
        neu.setBorder(null);
        open = new JButton();
        open.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/folder-open.png"))));
        open.setBackground(Color.decode("#10141C"));
        open.setBorder(null);
        save = new JButton();
        save.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/floppy-disk.png"))));
        save.setBackground(Color.decode("#10141C"));
        save.setBorder(null);
        export = new JButton();
        export.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/hammer.png"))));
        export.setBackground(Color.decode("#10141C"));
        export.setBorder(null);
        topPanel.add(neu);
        topPanel.add(makeSeparator());
        topPanel.add(open);
        topPanel.add(makeSeparator());
        topPanel.add(save);
        topPanel.add(makeSeparator());
        topPanel.add(export);
        projectTree = new JList<>(projectTreeModel);
        projectTree.setBackground(Color.decode("#10141C"));
        projectTree.setFont(IDE.aplFont);
        setLayout(new BorderLayout());
        add(topPanel, BorderLayout.NORTH);
        add(projectTree, BorderLayout.CENTER);

        neu.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                tryReset(() -> { });
                IDEModal frame = new IDEModal(parent.statusBar.getCurrentDesktopPane());
                frame.setTitle("New project");
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
                JLabel label = new JLabel("Namespace:");
                JTextField field = new JTextField(15);
                JButton button = new JButton("Ok");
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
                        IDEErrorModal error = new IDEErrorModal(parent.statusBar.getCurrentDesktopPane(), "Invalid object name - \"" + field.getText() + "\"");
                        ProjectPanel.setEnabled(frame, false);
                        error.display(() -> {
                            ProjectPanel.setEnabled(frame, true);
                            try {
                                frame.setSelected(true);
                            } catch (PropertyVetoException e2) {
                                e2.printStackTrace();
                            }
                        });
                    } else {
                        dataRegistry.setNamespace(field.getText());
                        dataRegistry.clear();
                        frame.dispose();
                        unsavedChanges = true;
                    }
                });
                cancel.addActionListener(e1 -> frame.dispose());
                frame.addInternalFrameListener(new InternalFrameAdapter() {
                    @Override
                    public void internalFrameClosed(InternalFrameEvent e) {
                        ProjectPanel.setEnabled(ProjectPanel.this, true);
                    }
                });
                frame.display();
                ProjectPanel.setEnabled(ProjectPanel.this, false);
            }
        });

        open.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                tryReset(() -> {});
                JFileChooser jfc = new JFileChooser();
                jfc.setDialogType(JFileChooser.OPEN_DIALOG);
                FileNameExtensionFilter filter = new FileNameExtensionFilter("KamilaLisp project files", "kpr");
                jfc.setFileFilter(filter);
                IDEFileChooserModal modal = new IDEFileChooserModal(parent.statusBar.getCurrentDesktopPane(), parent, jfc, (evt) -> {
                    if (JFileChooser.APPROVE_SELECTION.equals(evt.getActionCommand())) {
                        File src = jfc.getSelectedFile().getAbsoluteFile();
                        if(!src.exists()) {
                            IDEErrorModal error = new IDEErrorModal(parent.statusBar.getCurrentDesktopPane(), "File does not exist.");
                            error.display(() -> { });
                        } else {
                            Throwable t = null;
                            try {
                                FileInputStream fis = new FileInputStream(src);
                                parent.project.dataRegistry.readFrom(fis);
                            } catch(IOException | ClassNotFoundException e1) {
                                t = e1;
                            }
                            if(t != null) {
                                IDETextAreaErrorModal error = new IDETextAreaErrorModal(parent.statusBar.getCurrentDesktopPane(), "Error while reading file.", t);
                                error.display(() -> { });
                            }
                        }
                    }
                });
                modal.display();
            }
        });

        save.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                tryReset(() -> {});
                JFileChooser jfc = new JFileChooser();
                jfc.setDialogType(JFileChooser.SAVE_DIALOG);
                FileNameExtensionFilter filter = new FileNameExtensionFilter("KamilaLisp project files", "kpr");
                jfc.setFileFilter(filter);
                IDEFileChooserModal modal = new IDEFileChooserModal(parent.statusBar.getCurrentDesktopPane(), parent, jfc, new Consumer<>() {
                    private void write(File src) {
                        Throwable t = null;
                        try {
                            FileOutputStream fos = new FileOutputStream(src);
                            parent.project.dataRegistry.writeTo(fos);
                        } catch(IOException e1) {
                            t = e1;
                        }
                        if(t != null) {
                            IDETextAreaErrorModal error = new IDETextAreaErrorModal(parent.statusBar.getCurrentDesktopPane(), "Error while writing file.", t);
                            error.display(() -> { });
                        }
                    }

                    @Override
                    public void accept(ActionEvent evt) {
                        if (JFileChooser.APPROVE_SELECTION.equals(evt.getActionCommand())) {
                            File src = jfc.getSelectedFile().getAbsoluteFile();
                            if(src.exists()) {
                                IDEOkCancelModal frame = new IDEOkCancelModal(parent.statusBar.getCurrentDesktopPane(), "Overwrite", "File exists. Overwrite?", "Overwrite", "Cancel", () -> {
                                    write(src);
                                }, () -> { }, () -> { });
                                frame.display();
                            } else {
                                write(src);
                            }
                        }
                    }
                });
                modal.display();
            }
        });

        export.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                tryReset(() -> {});
                JFileChooser jfc = new JFileChooser();
                jfc.setDialogType(JFileChooser.SAVE_DIALOG);
                FileNameExtensionFilter filter = new FileNameExtensionFilter("KamilaLisp project files", "kpr");
                jfc.setFileFilter(filter);
                IDEFileChooserModal modal = new IDEFileChooserModal(parent.statusBar.getCurrentDesktopPane(), parent, jfc, new Consumer<>() {
                    private void write(File src) {
                        Throwable t = null;
                        try {
                            FileOutputStream fos = new FileOutputStream(src);
                            parent.project.dataRegistry.serialiseTo(fos);
                        } catch(IOException e1) {
                            t = e1;
                        }
                        if(t != null) {
                            IDETextAreaErrorModal error = new IDETextAreaErrorModal(parent.statusBar.getCurrentDesktopPane(), "Error while exporting file.", t);
                            error.display(() -> { });
                        }
                    }

                    @Override
                    public void accept(ActionEvent evt) {
                        if (JFileChooser.APPROVE_SELECTION.equals(evt.getActionCommand())) {
                            File src = jfc.getSelectedFile().getAbsoluteFile();
                            if(src.exists()) {
                                IDEOkCancelModal frame = new IDEOkCancelModal(parent.statusBar.getCurrentDesktopPane(), "Overwrite", "File exists. Overwrite?", "Overwrite", "Cancel", () -> {
                                    write(src);
                                }, () -> { }, () -> { });
                                frame.display();
                            } else {
                                write(src);
                            }
                        }
                    }
                });
                modal.display();
            }
        });
    }

    private void tryReset(Runnable callback) {
        // Check if the symbol name ends with " *". If it does, it means that the symbol has been modified.
        // If it has, ask the user if they want to fix the changes.
        if (unsavedChanges) {
            IDEOkCancelModal frame = new IDEOkCancelModal(parent.statusBar.getCurrentDesktopPane(), "Fix", "Do you want to save the changes before proceeding?", "Save", "Quit", () -> {
                for(ActionListener a : save.getActionListeners())
                    a.actionPerformed(null);
                callback.run();
            }, () -> { }, () -> {
                ProjectPanel.setEnabled(ProjectPanel.this, true);
            });
            frame.display();
            ProjectPanel.setEnabled(ProjectPanel.this, false);
        } else {
            callback.run();
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
