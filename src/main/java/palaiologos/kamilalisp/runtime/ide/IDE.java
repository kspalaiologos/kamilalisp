package palaiologos.kamilalisp.runtime.ide;

import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import java.awt.*;
import java.io.IOException;

public class IDE {
    JFrame frame;
    TerminalPanel root;
    public IDEStatusBar statusBar;

    public static final Font aplFont;
    public static final Font apl333Font;

    static {
        try {
            aplFont = Font.createFont(Font.TRUETYPE_FONT, IDE.class.getResourceAsStream("/APL385.ttf")).deriveFont(Font.BOLD, 15f);
            apl333Font = Font.createFont(Font.TRUETYPE_FONT, IDE.class.getResourceAsStream("/APL333.ttf")).deriveFont(Font.BOLD, 12f);
        } catch (FontFormatException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public IDE() {
        frame = new JFrame("KamilaLisp");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        frame.setLayout(new BorderLayout());
        statusBar = new IDEStatusBar();
        frame.add(statusBar, BorderLayout.NORTH);
        root = new TerminalPanel(this);
        frame.add(root, BorderLayout.CENTER);
        frame.setBackground(Color.decode("#10141C"));
        frame.setVisible(true);
        root.start();
    }
}
