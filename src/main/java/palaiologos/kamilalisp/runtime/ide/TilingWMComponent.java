package palaiologos.kamilalisp.runtime.ide;

import javax.swing.*;
import java.awt.*;

public abstract class TilingWMComponent extends JPanel {
    protected IDE parent;

    public TilingWMComponent(IDE parent) {
        super();
        this.parent = parent;
        setBackground(Color.decode("#10141C"));
        setBorder(null);
        setLayout(new BorderLayout());
    }

    // Call from swing thread.
    protected void quit() {
        // The remote has closed the connection. Close the terminal window.
        Container parentContainer = TilingWMComponent.this.getParent();
        if (parentContainer instanceof JSplitPane parentSplitPane) {
            // This was not the only window in the workspace.
            Container grandparentContainer = parentSplitPane.getParent();
            JComponent left = (JComponent) parentSplitPane.getLeftComponent();
            JComponent right = (JComponent) parentSplitPane.getRightComponent();
            if (grandparentContainer instanceof JSplitPane grandparentSplitPane) {
                // This was not the only window in the workspace.
                if (grandparentSplitPane.getLeftComponent() == parentSplitPane) {
                    if (TilingWMComponent.this == left) {
                        grandparentSplitPane.setLeftComponent(right);
                    } else {
                        grandparentSplitPane.setLeftComponent(left);
                    }
                } else {
                    if (TilingWMComponent.this == left) {
                        grandparentSplitPane.setRightComponent(right);
                    } else {
                        grandparentSplitPane.setRightComponent(left);
                    }
                }
            } else {
                // Remove the split pane.
                grandparentContainer.remove(parentSplitPane);
                // Add the other component.
                if (TilingWMComponent.this == left) {
                    grandparentContainer.add(right);
                } else {
                    grandparentContainer.add(left);
                }
            }
            grandparentContainer.revalidate();
            grandparentContainer.repaint();
        } else {
            // This was the only window in the workspace.
            // Delete the workspace.
            parent.statusBar.deleteWorkspace(parent.statusBar.currentWorkspace().fst());
        }
        parentContainer.revalidate();
        parentContainer.repaint();
    }

    protected void horizontalSplit(TilingWMComponent extra) {
        Container parentContainer = TilingWMComponent.this.getParent();
        if (parentContainer instanceof JSplitPane) {
            JComponent left = (JComponent) ((JSplitPane) parentContainer).getLeftComponent();
            parentContainer.remove(TilingWMComponent.this);
            JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, TilingWMComponent.this, extra);
            splitPane.setResizeWeight(0.5);
            splitPane.setDividerLocation(0.5);
            if (left == TilingWMComponent.this) {
                ((JSplitPane) parentContainer).setLeftComponent(splitPane);
            } else {
                ((JSplitPane) parentContainer).setRightComponent(splitPane);
            }
            extra.start();
        } else {
            JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, TilingWMComponent.this, extra);
            splitPane.setResizeWeight(0.5);
            splitPane.setDividerLocation(0.5);
            parentContainer.remove(TilingWMComponent.this);
            parentContainer.add(splitPane, BorderLayout.CENTER);
            extra.start();
        }
        parentContainer.revalidate();
        parentContainer.repaint();
    }

    protected void verticalSplit(TilingWMComponent extra) {
        Container parentContainer = TilingWMComponent.this.getParent();
        if (parentContainer instanceof JSplitPane) {
            JComponent left = (JComponent) ((JSplitPane) parentContainer).getLeftComponent();
            parentContainer.remove(TilingWMComponent.this);
            JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, TilingWMComponent.this, extra);
            splitPane.setResizeWeight(0.5);
            splitPane.setDividerLocation(0.5);
            if (left == TilingWMComponent.this) {
                ((JSplitPane) parentContainer).setLeftComponent(splitPane);
            } else {
                ((JSplitPane) parentContainer).setRightComponent(splitPane);
            }
            extra.start();
        } else {
            JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, TilingWMComponent.this, extra);
            splitPane.setResizeWeight(0.5);
            splitPane.setDividerLocation(0.5);
            parentContainer.remove(TilingWMComponent.this);
            parentContainer.add(splitPane, BorderLayout.CENTER);
            extra.start();
        }
        parentContainer.revalidate();
        parentContainer.repaint();
    }

    public abstract void start();
}
