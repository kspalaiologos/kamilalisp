package palaiologos.kamilalisp.runtime.ide;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rsyntaxtextarea.SyntaxScheme;
import org.fife.ui.rsyntaxtextarea.Token;

import javax.swing.*;
import java.awt.*;

public class RSTAFactory {
    public static RSyntaxTextArea build(JComponent parent) {
        RSyntaxTextArea area = new RSyntaxTextArea();
        area.setBackground(Color.decode("#10141C"));
        area.setCurrentLineHighlightColor(Color.decode("#1E222A"));
        area.setSyntaxEditingStyle("text/kamilalisp-term", parent);
        area.setAntiAliasingEnabled(true);
        area.setFont(IDE.aplFont);
        area.setCaretColor(Color.decode("#D5D5D5"));
        area.setForeground(Color.decode("#E6E6E6"));
        SyntaxScheme scheme = area.getSyntaxScheme();
        scheme.restoreDefaults(IDE.aplFont, false);
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
        return area;
    }
}
