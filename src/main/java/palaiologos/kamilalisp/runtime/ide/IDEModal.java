package palaiologos.kamilalisp.runtime.ide;

import javax.swing.*;
import java.awt.*;

public class IDEModal extends JInternalFrame {
    private final JDesktopPane parentComponent;

    public IDEModal(JDesktopPane parentComponent) {
        this.parentComponent = parentComponent;
        setFrameIcon(null);
    }

    public void display() {
        Dimension iFrameSize = getPreferredSize();
        Dimension rootSize = parentComponent.getSize();
        Dimension parentSize = parentComponent.getSize();
        setBounds((rootSize.width - iFrameSize.width) / 2,
                (rootSize.height - iFrameSize.height) / 2,
                iFrameSize.width, iFrameSize.height);
        Point iFrameCoord =
                SwingUtilities.convertPoint(parentComponent, 0, 0, parentComponent);
        int x = (parentSize.width - iFrameSize.width) / 2 + iFrameCoord.x;
        int y = (parentSize.height - iFrameSize.height) / 2 + iFrameCoord.y;
        int ovrx = x + iFrameSize.width - rootSize.width;
        int ovry = y + iFrameSize.height - rootSize.height;
        x = Math.max((ovrx > 0 ? x - ovrx : x), 0);
        y = Math.max((ovry > 0 ? y - ovry : y), 0);
        setBounds(x, y, iFrameSize.width, iFrameSize.height);
        parentComponent.validate();
        setVisible(true);
        parentComponent.add(this, JLayeredPane.MODAL_LAYER);
        try {
            setSelected(true);
        } catch (java.beans.PropertyVetoException ex) {
        }
    }
}
