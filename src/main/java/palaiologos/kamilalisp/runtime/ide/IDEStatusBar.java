package palaiologos.kamilalisp.runtime.ide;

import palaiologos.kamilalisp.atom.Pair;
import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.MatteBorder;
import javax.swing.plaf.basic.BasicInternalFrameUI;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.beans.PropertyVetoException;
import java.util.ArrayList;

public class IDEStatusBar extends JPanel {
    private final IDE parent;
    int noWorkspaces, selectedWorkspace;
    ArrayList<String> workspaceNames;
    JScrollPane workspaceScrollPane;
    JToolBar workspacePanel;
    ArrayList<JLabel> workspaceLabels;
    ArrayList<JDesktopPane> workspaceComponents;

    public IDEStatusBar(IDE parent) {
        super(new FlowLayout());
        this.parent = parent;
        setBorder(new MatteBorder(0, 0, 1, 0, Color.decode("#1E222A")));
        setBackground(Color.decode("#10141C"));
        setLayout(new BorderLayout());
        noWorkspaces = 0;
        selectedWorkspace = -1;
        workspaceNames = new ArrayList<>();
        workspaceLabels = new ArrayList<>();
        workspaceComponents = new ArrayList<>();
        workspacePanel = new JToolBar();
        workspacePanel.setBorder(null);
        workspacePanel.setFloatable(false);
        workspacePanel.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() % 2 == 0) {
                    addWorkspace();
                }
            }
        });
        workspacePanel.setBackground(Color.decode("#10141C"));
        workspaceScrollPane = new JScrollPane(workspacePanel);
        workspaceScrollPane.setBorder(null);
        workspaceScrollPane.setBackground(Color.decode("#10141C"));
        workspaceScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
        workspaceScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
        workspaceScrollPane.setColumnHeaderView(workspaceScrollPane.getHorizontalScrollBar());
        add(workspaceScrollPane, BorderLayout.CENTER);
    }

    public JDesktopPane getCurrentDesktopPane() {
        return workspaceComponents.get(selectedWorkspace);
    }

    public boolean hasWorkspace(String name) {
        return workspaceNames.contains(name);
    }

    public void addWorkspace(String name) {
        noWorkspaces++;
        workspaceNames.add(name);
        JLabel lab = new JLabel();
        lab.setFont(IDE.apl333Font);
        lab.setOpaque(true);
        lab.setForeground(Color.decode("#FFFFFF"));
        lab.setBorder(new EmptyBorder(5, 5, 5, 5));
        lab.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent evt) {
                selectWorkspace(workspaceLabels.indexOf(lab));
            }
        });
        workspaceLabels.add(lab);
        workspacePanel.add(lab);
        JDesktopPane pane = new JDesktopPane();
        pane.setBackground(Color.decode("#10141C"));
        pane.setBorder(null);
        pane.setOpaque(true);
        JInternalFrame frame = new JInternalFrame(name, true, false, true, false);
        frame.setLayout(new BorderLayout());
        frame.setBorder(null);
        ((BasicInternalFrameUI) frame.getUI()).setNorthPane(null);
        frame.putClientProperty("JInternalFrame.isPalette", Boolean.TRUE);
        frame.getRootPane().setWindowDecorationStyle(JRootPane.NONE);
        TerminalPanel p = new TerminalPanel(parent);
        frame.add(p, BorderLayout.CENTER);
        try {
            frame.setMaximum(true);
        } catch (PropertyVetoException e) {
            throw new RuntimeException(e);
        }
        pane.add(frame);
        frame.setVisible(true);
        workspaceComponents.add(pane);
        selectWorkspace(noWorkspaces - 1);
        p.start(null, 0);
    }

    public void addWorkspace() {
        addWorkspace("");
    }

    public void deleteWorkspace(int number) {
        noWorkspaces--;
        if (noWorkspaces == 0)
            System.exit(1);
        selectWorkspace(Math.min(number - 1, 0));
        workspaceNames.remove(number);
        workspacePanel.remove(workspaceLabels.get(number));
        workspacePanel.revalidate();
        workspacePanel.repaint();
        workspaceLabels.remove(number);
        workspaceComponents.remove(number);
    }

    public void deleteWorkspace(String name) {
        int index = workspaceNames.indexOf(name);
        if (index == -1)
            throw new RuntimeException("ide:status-bar:delete: workspace does not exist");
        deleteWorkspace(index);
    }

    public void swapWorkspaces(int idx1, int idx2) {
        String name1 = workspaceNames.get(idx1);
        String name2 = workspaceNames.get(idx2);
        workspaceNames.set(idx1, name2);
        workspaceNames.set(idx2, name1);
        JLabel lab1 = workspaceLabels.get(idx1);
        JLabel lab2 = workspaceLabels.get(idx2);
        String lab1Text = lab1.getText();
        String lab2Text = lab2.getText();
        lab1.setText(lab2Text);
        lab2.setText(lab1Text);
        JDesktopPane comp1 = workspaceComponents.get(idx1);
        JDesktopPane comp2 = workspaceComponents.get(idx2);
        workspaceComponents.set(idx1, comp2);
        workspaceComponents.set(idx2, comp1);
        if (selectedWorkspace == idx1)
            selectWorkspace(idx2);
        else if (selectedWorkspace == idx2)
            selectWorkspace(idx1);
    }

    public void renameWorkspace(int index, String name) {
        workspaceNames.set(index, name);
        JLabel currentLabel = workspaceLabels.get(index);
        if (index == selectedWorkspace)
            currentLabel.setText("∙ " + index + name);
        else
            currentLabel.setText("∘ " + index + name);
    }

    public void renameWorkspace(String oldName, String newName) {
        int index = workspaceNames.indexOf(oldName);
        if (index == -1)
            throw new RuntimeException("ide:status-bar:rename: workspace does not exist");
        renameWorkspace(index, newName);
    }

    public Pair<Integer, String> currentWorkspace() {
        return new Pair<>(selectedWorkspace, workspaceNames.get(selectedWorkspace));
    }

    public void selectWorkspace(int index) {
        if (index <= -1)
            return;
        if (index > noWorkspaces - 1)
            throw new RuntimeException("ide:status-bar:select: workspace does not exist");
        if (selectedWorkspace != -1) {
            JLabel currentLabel = workspaceLabels.get(selectedWorkspace);
            currentLabel.setText("∘ " + selectedWorkspace + workspaceNames.get(selectedWorkspace));
            currentLabel.setBackground(Color.decode("#10141C"));
        }
        selectedWorkspace = index;
        JLabel newLabel = workspaceLabels.get(selectedWorkspace);
        newLabel.setText("∙ " + selectedWorkspace + workspaceNames.get(selectedWorkspace));
        newLabel.setBackground(Color.decode("#1E222A"));
        workspaceScrollPane.getViewport().scrollRectToVisible(newLabel.getBounds());
        parent.splitPane.setRightComponent(workspaceComponents.get(selectedWorkspace));
        parent.splitPane.revalidate();
        parent.splitPane.repaint();
    }

    public void selectWorkspace(String name) {
        selectWorkspace(workspaceNames.indexOf(name));
    }
}
