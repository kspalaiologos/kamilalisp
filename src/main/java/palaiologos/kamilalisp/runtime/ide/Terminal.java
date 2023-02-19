package palaiologos.kamilalisp.runtime.ide;

import javax.swing.*;
import javax.swing.text.DefaultCaret;
import javax.swing.text.html.HTMLDocument;
import java.awt.*;

public class Terminal extends JEditorPane {
    public Terminal() {
        super();
        setBorder(null);
        setBackground(Color.decode("#10141C"));
        setContentType("text/html");
        String bodyRule = "body { font-family: \"APL386 Unicode\"; font-size: 20pt; background-color: #10141C; color: #bfbdb6; }";
        ((HTMLDocument)getDocument()).getStyleSheet().addRule(bodyRule);
        setText("");
        getCaret().setVisible(true);
        ((DefaultCaret) getCaret()).setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);
        setCaretColor(Color.decode("#bfbdb6"));
        setEditable(false);
    }

    protected void paintComponent(Graphics g) {
        Graphics2D g2 = (Graphics2D) g;
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        super.paintComponent(g2);
    }
}
