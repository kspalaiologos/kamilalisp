package palaiologos.kamilalisp.runtime.ide;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rsyntaxtextarea.SyntaxScheme;
import org.fife.ui.rsyntaxtextarea.Token;

import javax.swing.*;
import java.awt.*;

public class RSTAFactory {
    public static RSyntaxTextArea build(JComponent parent) {
        RSyntaxTextArea area = new RSyntaxTextArea();
        area.setBackground(IDETheme.background);
        area.setCurrentLineHighlightColor(IDETheme.lineHighlightColor);
        area.setSyntaxEditingStyle("text/kamilalisp-term", parent);
        area.setAntiAliasingEnabled(true);
        area.setFont(IDE.aplFont);
        area.setCaretColor(IDETheme.caretColor);
        area.setForeground(IDETheme.foregroundColor);
        SyntaxScheme scheme = area.getSyntaxScheme();
        scheme.restoreDefaults(IDE.aplFont, false);
        scheme.getStyle(Token.COMMENT_EOL).foreground = IDETheme.edComment;
        scheme.getStyle(Token.LITERAL_NUMBER_DECIMAL_INT).foreground = IDETheme.edNumLiteral;
        scheme.getStyle(Token.LITERAL_NUMBER_FLOAT).foreground = IDETheme.edNumLiteral;
        scheme.getStyle(Token.LITERAL_CHAR).foreground = IDETheme.edNumLiteral;
        scheme.getStyle(Token.LITERAL_BOOLEAN).foreground = IDETheme.edBoolLiteral;
        scheme.getStyle(Token.VARIABLE).foreground = IDETheme.edVariable;
        scheme.getStyle(Token.RESERVED_WORD).foreground = IDETheme.edKeywordLiteral;
        scheme.getStyle(Token.OPERATOR).foreground = IDETheme.edOperatorLiteral;
        scheme.getStyle(Token.FUNCTION).foreground = IDETheme.edFunctionLiteral;
        scheme.getStyle(Token.LITERAL_STRING_DOUBLE_QUOTE).foreground = IDETheme.edStringLiteral;
        return area;
    }
}
