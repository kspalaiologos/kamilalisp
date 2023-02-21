package palaiologos.kamilalisp.runtime.ide;

import org.fife.ui.rsyntaxtextarea.AbstractTokenMakerFactory;
import org.fife.ui.rsyntaxtextarea.TokenMakerFactory;

import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Supplier;

public class IDE {
    JFrame frame;
    public IDEStatusBar statusBar;
    public IDEExtras extras;

    public static final Font aplFont;
    public static final Font apl333Font;

    static {
        try {
            aplFont = Font.createFont(Font.TRUETYPE_FONT, Objects.requireNonNull(IDE.class.getResourceAsStream("/APL385.ttf"))).deriveFont(Font.BOLD, 15f);
            apl333Font = Font.createFont(Font.TRUETYPE_FONT, Objects.requireNonNull(IDE.class.getResourceAsStream("/APL333.ttf"))).deriveFont(Font.BOLD, 12f);
        } catch (FontFormatException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> T invokeSwing(Supplier<T> r) {
        try {
            AtomicReference<T> ref = new AtomicReference<>();
            AtomicReference<RuntimeException> ex = new AtomicReference<>();
            SwingUtilities.invokeAndWait(() -> {
                try {
                    ref.set(r.get());
                } catch (Throwable e) {
                    if (e instanceof RuntimeException) {
                        ex.set((RuntimeException) e);
                    } else {
                        ex.set(new RuntimeException(e));
                    }
                }
            });
            if(ex.get() != null)
                throw ex.get();
            return ref.get();
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    public static void invokeSwing(Runnable r) {
        try {
            AtomicReference<RuntimeException> ex = new AtomicReference<>();
            SwingUtilities.invokeAndWait(() -> {
                try {
                    r.run();
                } catch (Throwable e) {
                    if (e instanceof RuntimeException) {
                        ex.set((RuntimeException) e);
                    } else {
                        ex.set(new RuntimeException(e));
                    }
                }
            });
            if(ex.get() != null)
                throw ex.get();
        } catch (InterruptedException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    public IDE() {
        AbstractTokenMakerFactory atmf = (AbstractTokenMakerFactory) TokenMakerFactory.getDefaultInstance();
        atmf.putMapping("text/kamilalisp-term", "palaiologos.kamilalisp.runtime.ide.terminal.TerminalKamilaLispTokenMaker");
        atmf.putMapping("text/kamilalisp", "palaiologos.kamilalisp.runtime.ide.KamilaLispTokenMaker");

        frame = new JFrame("KamilaLisp IDE");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        frame.setIconImage(new ImageIcon(Objects.requireNonNull(IDE.class.getResource("/icon.png"))).getImage());
        frame.setLocationRelativeTo(null);
        frame.setLayout(new BorderLayout());
        statusBar = new IDEStatusBar(this);
        frame.add(statusBar, BorderLayout.NORTH);
        frame.setBackground(Color.decode("#10141C"));
        extras = new IDEExtras();
        frame.add(extras, BorderLayout.SOUTH);
        frame.setVisible(true);
        statusBar.addWorkspace("Main");
    }
}
