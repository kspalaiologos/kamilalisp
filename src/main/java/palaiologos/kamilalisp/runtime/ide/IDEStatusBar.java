package palaiologos.kamilalisp.runtime.ide;

import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.MatteBorder;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;

public class IDEStatusBar extends JPanel {
    int noWorkspaces, selectedWorkspace;
    ArrayList<String> workspaceNames;
    JScrollPane workspaceScrollPane;
    JToolBar workspacePanel;
    ArrayList<JLabel> workspaceLabels;
    ArrayList<JComponent> workspaceComponents;
    private IDE parent;

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
        workspacePanel.setBackground(Color.decode("#10141C"));
        workspaceScrollPane = new JScrollPane(workspacePanel);
        workspaceScrollPane.setBorder(null);
        workspaceScrollPane.setBackground(Color.decode("#10141C"));
        workspaceScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
        workspaceScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
        workspaceScrollPane.setColumnHeaderView(workspaceScrollPane.getHorizontalScrollBar());
        add(workspaceScrollPane, BorderLayout.CENTER);
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
        lab.setBorder(new EmptyBorder(5, 5, 5, 5));
        lab.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent evt) {
                selectWorkspace(workspaceLabels.indexOf(lab));
            }
        });
        workspaceLabels.add(lab);
        workspacePanel.add(lab);
        TerminalPanel p = new TerminalPanel(parent);
        workspaceComponents.add(p);
        selectWorkspace(noWorkspaces - 1);
        p.start();
    }

    public void addWorkspace() {
        addWorkspace("");
    }

    public void deleteWorkspace(int number) {
        noWorkspaces--;
        workspaceNames.remove(number);
        workspacePanel.remove(workspaceLabels.get(number));
        workspacePanel.revalidate();
        workspacePanel.repaint();
        workspaceLabels.remove(number);
        workspaceComponents.remove(number);
        if(selectedWorkspace == 0 || workspaceNames.isEmpty()) {
            System.exit(1);
        }
        if (selectedWorkspace == number) {
            selectWorkspace(selectedWorkspace - 1);
        }
    }

    public void deleteWorkspace(String name) {
        int index = workspaceNames.indexOf(name);
        if(index == -1)
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
        JComponent comp1 = workspaceComponents.get(idx1);
        JComponent comp2 = workspaceComponents.get(idx2);
        workspaceComponents.set(idx1, comp2);
        workspaceComponents.set(idx2, comp1);
        if(selectedWorkspace == idx1)
            selectWorkspace(idx2);
        else if(selectedWorkspace == idx2)
            selectWorkspace(idx1);
    }

    public void renameWorkspace(int index, String name) {
        workspaceNames.set(index, name);
        JLabel currentLabel = workspaceLabels.get(index);
        if(index == selectedWorkspace)
            currentLabel.setText("\u2219 " + index + name);
        else
            currentLabel.setText("\u2218 " + index + name);
    }

    public void selectWorkspace(int index) {
        if(index <= -1)
            return;
        if(index > noWorkspaces - 1)
            throw new RuntimeException("ide:status-bar:select: workspace does not exist");
        if(selectedWorkspace != -1) {
            JLabel currentLabel = workspaceLabels.get(selectedWorkspace);
            currentLabel.setText("\u2218 " + selectedWorkspace + workspaceNames.get(selectedWorkspace));
            currentLabel.setBackground(Color.decode("#10141C"));
            parent.frame.remove(workspaceComponents.get(selectedWorkspace));
        }
        selectedWorkspace = index;
        JLabel newLabel = workspaceLabels.get(selectedWorkspace);
        newLabel.setText("\u2219 " + selectedWorkspace + workspaceNames.get(selectedWorkspace));
        newLabel.setBackground(Color.decode("#1E222A"));
        workspaceScrollPane.getViewport().scrollRectToVisible(newLabel.getBounds());
        parent.frame.add(workspaceComponents.get(selectedWorkspace), BorderLayout.CENTER);
        parent.frame.revalidate();
        parent.frame.repaint();
    }

    public void selectWorkspace(String name) {
        selectWorkspace(workspaceNames.indexOf(name));
    }
}
