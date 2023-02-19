package palaiologos.kamilalisp.runtime.ide;

import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.fife.ui.rsyntaxtextarea.*;
import org.jline.terminal.Terminal;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.InterruptionError;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.ide.terminal.TerminalPanel;

import javax.swing.*;
import javax.swing.border.MatteBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.*;
import java.awt.*;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

public class IDE {
    JFrame frame;
    JComponent root;

    public static final Font aplFont;

    static {
        try {
            aplFont = Font.createFont(Font.TRUETYPE_FONT, IDE.class.getResourceAsStream("/Apl385.ttf")).deriveFont(Font.BOLD, 15f);
        } catch (FontFormatException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public IDE() throws Exception {
        frame = new JFrame("KamilaLisp");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        root = new TerminalPanel();
        frame.add(root);
        frame.setBackground(Color.decode("#10141C"));
        frame.setVisible(true);
    }
}
