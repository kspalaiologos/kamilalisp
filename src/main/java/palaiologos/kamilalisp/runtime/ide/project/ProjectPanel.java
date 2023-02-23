package palaiologos.kamilalisp.runtime.ide.project;

import palaiologos.kamilalisp.runtime.ide.IDE;
import palaiologos.kamilalisp.runtime.ide.TilingWMComponent;
import palaiologos.kamilalisp.runtime.ide.editor.ProjectDataRegistry;

import javax.swing.*;
import java.awt.*;
import java.util.Objects;

public class ProjectPanel extends TilingWMComponent {
    public ProjectDataRegistry dataRegistry;
    public JList<String> projectTree;
    public DefaultListModel<String> projectTreeModel = new DefaultListModel<>();

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
        JButton neu = new JButton();
        neu.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/file.png"))));
        neu.setBackground(Color.decode("#10141C"));
        neu.setBorder(null);
        JButton open = new JButton();
        open.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/folder-open.png"))));
        open.setBackground(Color.decode("#10141C"));
        open.setBorder(null);
        JButton save = new JButton();
        save.setIcon(new ImageIcon(Objects.requireNonNull(getClass().getResource("/ui/floppy-disk.png"))));
        save.setBackground(Color.decode("#10141C"));
        save.setBorder(null);
        JButton export = new JButton();
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
        setLayout(new BorderLayout());
        add(topPanel, BorderLayout.NORTH);
        add(projectTree, BorderLayout.CENTER);
    }
}
