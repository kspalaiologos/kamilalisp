package palaiologos.kamilalisp.runtime.ide.editor;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rtextarea.RTextScrollPane;
import palaiologos.kamilalisp.runtime.ide.IDE;
import palaiologos.kamilalisp.runtime.ide.RSTAFactory;
import palaiologos.kamilalisp.runtime.ide.TilingWMComponent;
import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import java.awt.*;

public class EditorPanel extends TilingWMComponent {
    private final TerminalPanel owner;
    private final RSyntaxTextArea area;
    private final RTextScrollPane scrollPane;
    private String objectName = null;

    public EditorPanel(IDE parent, TerminalPanel owner) {
        super(parent);
        this.owner = owner;
        area = RSTAFactory.build();
        scrollPane = new RTextScrollPane(area);
        scrollPane.setBorder(null);
        scrollPane.getGutter().setBorderColor(Color.decode("#1E222A"));
        add(scrollPane, BorderLayout.CENTER);
    }

    public void start() {
    }
}
