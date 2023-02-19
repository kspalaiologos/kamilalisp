package palaiologos.kamilalisp.runtime.ide;

import org.fife.ui.rsyntaxtextarea.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;

public class IDE {
    JFrame frame;
    JComponent root;

    public IDE() throws Exception {
        frame = new JFrame("KamilaLisp");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        root = new JPanel();
        root.setBackground(Color.decode("#10141C"));
        root.setBorder(null);
        root.setLayout(new BorderLayout());
        RSyntaxTextArea area = new RSyntaxTextArea();
        area.setBackground(Color.decode("#10141C"));
        area.setCurrentLineHighlightColor(Color.decode("#1E222A"));
        AbstractTokenMakerFactory atmf = (AbstractTokenMakerFactory) TokenMakerFactory.getDefaultInstance();
        atmf.putMapping("text/kamilalisp", "palaiologos.kamilalisp.runtime.ide.KamilaLispTokenMaker");
        area.setSyntaxEditingStyle("text/kamilalisp");
        area.setAntiAliasingEnabled(true);
        area.setFont(Font.createFont(Font.TRUETYPE_FONT, IDE.class.getResourceAsStream("/APL386.ttf")).deriveFont(14f));
        area.setCaretColor(Color.decode("#D5D5D5"));
        area.setForeground(Color.decode("#E6E6E6"));
        SyntaxScheme scheme = area.getSyntaxScheme();
        scheme.getStyle(Token.COMMENT_EOL).foreground = Color.decode("#676B79");
        scheme.getStyle(Token.LITERAL_NUMBER_DECIMAL_INT).foreground = Color.decode("#FFB86C");
        scheme.getStyle(Token.LITERAL_NUMBER_FLOAT).foreground = Color.decode("#FFB86C");
        scheme.getStyle(Token.LITERAL_CHAR).foreground = Color.decode("#FFB86C");
        scheme.getStyle(Token.LITERAL_BOOLEAN).foreground = Color.decode("#45A9F9");
        scheme.getStyle(Token.VARIABLE).foreground = Color.decode("#E6E6E6");
        scheme.getStyle(Token.RESERVED_WORD).foreground = Color.decode("#FF75B5");
        scheme.getStyle(Token.OPERATOR).foreground = Color.decode("#B084EB");
        scheme.getStyle(Token.FUNCTION).foreground = Color.decode("#FFCC95");
        scheme.getStyle(Token.LITERAL_STRING_DOUBLE_QUOTE).foreground = Color.decode("#6FC1FF");
        JScrollPane sp = new JScrollPane(area);
        sp.setBorder(null);
        root.add(sp, BorderLayout.CENTER);
        frame.add(root);
        frame.setBackground(Color.decode("#10141C"));
        frame.setVisible(true);
    }
}
