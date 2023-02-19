package palaiologos.kamilalisp.runtime.ide;

import org.apache.commons.text.StringEscapeUtils;

import javax.swing.*;
import javax.swing.event.CaretEvent;
import javax.swing.event.CaretListener;
import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultCaret;
import javax.swing.text.html.HTML;
import javax.swing.text.html.HTMLDocument;
import javax.swing.text.html.HTMLEditorKit;
import java.awt.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class Terminal extends JEditorPane {
    HTMLDocument document;
    HTMLEditorKit ek;
    AtomicInteger inCounter = new AtomicInteger(0);
    AtomicInteger outCounter = new AtomicInteger(0);
    AtomicBoolean awaitsInput = new AtomicBoolean(false);

    public void appendOutput(String s) {
        String html = "<p style=\"color: #bfbdb6;\" id=\"out" + outCounter.getAndAdd(1) + "\">" + StringEscapeUtils.escapeHtml4(s).replace("\n", "<br>").replace(" ", "&nbsp;") + "</p>";
        try {
            document.insertBeforeEnd(document.getElement("body"), html);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String prompt() {
        String html = "<p style=\"color: #bfbdb6;\" id=\"in" + inCounter.get() + "\">" + StringEscapeUtils.escapeHtml4("-->") + "&nbsp;</p>";
        try {
            document.insertBeforeEnd(document.getElement("body"), html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        SwingUtilities.invokeLater(() -> setCaretPosition(document.getLength()));
        awaitsInput.set(true);
        try {
            synchronized (awaitsInput) {
                awaitsInput.wait();
            }
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        String elemName = "in" + (inCounter.get() - 1);
        int start = document.getElement(elemName).getStartOffset();
        int end = document.getElement(elemName).getEndOffset();
        String elemText = null;
        try {
            elemText = document.getText(start, end - start - 1);
        } catch (BadLocationException e) {
            throw new RuntimeException(e);
        }
        return elemText.substring(4);
    }

    public Terminal() {
        super();
        setBorder(null);
        setDoubleBuffered(true);
        setBackground(Color.decode("#10141C"));
        setContentType("text/html");
        setText("""
                <html>
                    <head>
                        <style>
                            body { font-family: "APL386 Unicode"; font-size: 15pt; background-color: #10141C; color: #bfbdb6; }
                            p { margin: 0; padding: 0; }
                        </style>
                    </head>
                    <body id="body"></body>
                </html>""");
        document = (HTMLDocument) getDocument();
        ek = (HTMLEditorKit) getEditorKit();
        setCaret(new TerminalCaret());
        getCaret().setVisible(true);
        ((DefaultCaret) getCaret()).setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);
        setCaretColor(Color.decode("#bfbdb6"));
        setEditable(false);
        addKeyListener(new KeyAdapter() {
            @Override
            public void keyTyped(KeyEvent e) {
                try {
                    if (awaitsInput.get()) {
                        String elemName = "in" + inCounter.get();
                        int start = document.getElement(elemName).getStartOffset();
                        int end = document.getElement(elemName).getEndOffset();
                        String elemText = document.getText(start, end - start - 1);
                        switch(e.getKeyChar()) {
                            case KeyEvent.VK_BACK_SPACE -> {
                                if (elemText.length() > 4) {
                                    document.setInnerHTML(document.getElement(elemName), elemText.substring(0, elemText.length() - 1));
                                }
                            }
                            case KeyEvent.VK_ENTER -> {
                                document.setInnerHTML(document.getElement(elemName), elemText + "<br>");
                                inCounter.getAndAdd(1);
                                awaitsInput.set(false);
                                synchronized (awaitsInput) {
                                    awaitsInput.notify();
                                }
                            }
                            case KeyEvent.VK_SPACE -> {
                                document.setInnerHTML(document.getElement(elemName), elemText + "&nbsp;");
                            }
                            default -> {
                                document.setInnerHTML(document.getElement(elemName), elemText + e.getKeyChar());
                            }
                        }
                    }
                } catch(Exception ex) {
                    throw new RuntimeException("Error while handling key event", ex);
                }
            }
        });
    }

    protected void paintComponent(Graphics g) {
        Graphics2D g2 = (Graphics2D) g;
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        super.paintComponent(g2);
    }
}
