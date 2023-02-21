package palaiologos.kamilalisp.runtime.ide.editor;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rtextarea.RTextScrollPane;
import palaiologos.kamilalisp.runtime.ide.RSTAFactory;
import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import java.awt.*;

public class EditorPanel extends JPanel {
    private final TerminalPanel owner;
    private final RSyntaxTextArea area;
    private final RTextScrollPane scrollPane;

    public EditorPanel(TerminalPanel owner) {
        this.owner = owner;
        setBackground(Color.decode("#10141C"));
        setBorder(null);
        setLayout(new BorderLayout());
        area = RSTAFactory.build();
        scrollPane = new RTextScrollPane(area);
        scrollPane.setBorder(null);
        scrollPane.getGutter().setBorderColor(Color.decode("#1E222A"));
        add(scrollPane, BorderLayout.CENTER);
    }
}
