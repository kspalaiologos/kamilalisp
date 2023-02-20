package palaiologos.kamilalisp.runtime.ide;

import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import java.awt.*;
import java.io.IOException;

public class IDE {
    JFrame frame;
    TerminalPanel root;

    public static final Font aplFont;

    static {
        try {
            aplFont = Font.createFont(Font.TRUETYPE_FONT, IDE.class.getResourceAsStream("/APL385.ttf")).deriveFont(Font.BOLD, 15f);
        } catch (FontFormatException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public IDE() {
        frame = new JFrame("KamilaLisp");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        root = new TerminalPanel();
        frame.add(root);
        frame.setBackground(Color.decode("#10141C"));
        frame.setVisible(true);
        root.start();
    }
}
