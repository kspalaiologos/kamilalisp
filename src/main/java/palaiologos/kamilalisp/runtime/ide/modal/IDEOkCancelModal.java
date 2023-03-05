package palaiologos.kamilalisp.runtime.ide.modal;

import palaiologos.kamilalisp.runtime.ide.IDETheme;

import javax.swing.*;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent;

public class IDEOkCancelModal extends IDEModal {
    public IDEOkCancelModal(JDesktopPane parentComponent, String title, String msg, String btn1, String btn2, Runnable btn1Action, Runnable btn2Action, Runnable closed) {
        super(parentComponent);
        setTitle(title);
        setMaximizable(false);
        setResizable(false);
        setClosable(true);
        setIconifiable(false);
        setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
        JPanel contentPane = new JPanel();
        contentPane.setBorder(null);
        contentPane.setBackground(IDETheme.background);
        setContentPane(contentPane);
        GroupLayout layout = new GroupLayout(contentPane);
        contentPane.setLayout(layout);
        layout.setAutoCreateGaps(true);
        layout.setAutoCreateContainerGaps(true);
        JLabel label = new JLabel(msg);
        JButton button = new JButton(btn1);
        JButton cancel = new JButton(btn2);
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
            dispose();
            btn1Action.run();
        });
        cancel.addActionListener(e1 -> {
            dispose();
            btn2Action.run();
        });
        addInternalFrameListener(new InternalFrameAdapter() {
            @Override
            public void internalFrameClosed(InternalFrameEvent e) {
                closed.run();
            }
        });
        display();
    }
}
