package palaiologos.kamilalisp.runtime.ide;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.MatteBorder;
import java.awt.*;
import java.util.ArrayList;

public class IDEStatusBar extends JPanel {
    int noWorkspaces, selectedWorkspace;
    ArrayList<String> workspaceNames;
    JScrollPane workspaceScrollPane;
    JToolBar workspacePanel;
    ArrayList<JLabel> workspaceLabels;

    public IDEStatusBar() {
        super(new FlowLayout());
        setBorder(new MatteBorder(0, 0, 1, 0, Color.decode("#1E222A")));
        setBackground(Color.decode("#10141C"));
        setLayout(new BorderLayout());
        noWorkspaces = 0;
        selectedWorkspace = -1;
        workspaceNames = new ArrayList<>();
        workspaceLabels = new ArrayList<>();
        workspacePanel = new JToolBar();
        workspacePanel.setBorder(null);
        workspacePanel.setBackground(Color.decode("#10141C"));
        workspaceScrollPane = new JScrollPane(workspacePanel);
        workspaceScrollPane.setBorder(null);
        workspaceScrollPane.setBackground(Color.decode("#10141C"));
        workspaceScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        workspaceScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
        add(workspaceScrollPane, BorderLayout.CENTER);
        addWorkspace("Main");
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
        workspaceLabels.add(lab);
        workspacePanel.add(lab);
        selectWorkspace(noWorkspaces - 1);
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
        if (selectedWorkspace == number) {
            selectedWorkspace--;
        }
        if(selectedWorkspace == -1 || workspaceNames.isEmpty()) {
            System.exit(1);
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
        }
        selectedWorkspace = index;
        JLabel newLabel = workspaceLabels.get(selectedWorkspace);
        newLabel.setText("\u2219 " + selectedWorkspace + workspaceNames.get(selectedWorkspace));
        newLabel.setBackground(Color.decode("#1E222A"));
        workspaceScrollPane.getViewport().scrollRectToVisible(newLabel.getBounds());
    }

    public void selectWorkspace(String name) {
        selectWorkspace(workspaceNames.indexOf(name));
    }
}
