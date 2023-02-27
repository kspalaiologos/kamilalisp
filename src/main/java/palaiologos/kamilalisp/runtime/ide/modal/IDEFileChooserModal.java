package palaiologos.kamilalisp.runtime.ide.modal;

import palaiologos.kamilalisp.runtime.ide.IDE;

import javax.swing.*;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.util.function.Consumer;

public class IDEFileChooserModal extends IDEModal {

    public IDEFileChooserModal(JDesktopPane parentComponent, IDE parentFrame, JFileChooser chooser, Consumer<ActionEvent> onConfirm) {
        super(parentComponent);
        setContentPane(chooser);
        chooser.setBorder(BorderFactory.createLineBorder(Color.decode("#23262D"), 5));
        setEnabled(parentFrame.project, false);
        setTitle("Choose");

        chooser.addActionListener(e -> {
            dispose();
            onConfirm.accept(e);
        });

        addInternalFrameListener(new InternalFrameAdapter() {
            @Override
            public void internalFrameClosed(InternalFrameEvent e) {
                setEnabled(parentFrame.project, true);
            }
        });
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
