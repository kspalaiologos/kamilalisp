package palaiologos.kamilalisp.runtime.ide;

import org.fife.ui.rsyntaxtextarea.*;

import javax.swing.*;
import javax.swing.border.MatteBorder;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicBoolean;

public class IDE {
    JFrame frame;
    JComponent root;
    AtomicBoolean readingInput = new AtomicBoolean(true);

    private class AllowedEditRange {
        int start;
        AllowedEditRange(int start) {
            this.start = start;
        }
    }

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
        Font aplFont = Font.createFont(Font.TRUETYPE_FONT, IDE.class.getResourceAsStream("/APL386.ttf")).deriveFont(14f);
        area.setFont(aplFont);
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
        AllowedEditRange r = new AllowedEditRange(0);
        ((AbstractDocument)area.getDocument()).setDocumentFilter(
                new NonEditableLineDocumentFilter(r));
        JScrollPane sp = new JScrollPane(area);
        sp.setBorder(null);
        root.add(sp, BorderLayout.CENTER);
        JTextArea gutter = new JTextArea(1,3);
        gutter.setBackground(Color.decode("#10141C"));
        gutter.setForeground(Color.decode("#E6E6E6"));
        gutter.setEditable(false);
        gutter.setFont(aplFont);
        gutter.setText("-->\n");
        gutter.setBorder(new MatteBorder(0, 0, 0, 1, Color.decode("#1E222A")));
        area.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void removeUpdate(DocumentEvent e) {
                try {
                    // Count the amount of lines in the document now.
                    int lines = area.getLineOfOffset(area.getDocument().getLength()) + 1;
                    // Remove last line from the gutter until the amount of lines in the document is equal to the amount of lines in the gutter.
                    while (gutter.getLineCount() - 1 > lines) {
                        gutter.getDocument().remove(gutter.getText().length() - 4, 4);
                    }
                } catch (BadLocationException e1) {
                    e1.printStackTrace();
                }
            }

            @Override
            public void insertUpdate(DocumentEvent e) {
                try {
                    // Count the amount of lines in the document now.
                    int lines = area.getLineOfOffset(area.getDocument().getLength()) + 1;
                    // Add a new line to the gutter until the amount of lines in the document is equal to the amount of lines in the gutter.
                    while (gutter.getLineCount() - 1 < lines) {
                        gutter.getDocument().insertString(gutter.getDocument().getLength(), (readingInput.get() ? "..." : "   ") + System.lineSeparator(), null);
                    }
                } catch (BadLocationException e1) {
                    e1.printStackTrace();
                }
            }

            @Override
            public void changedUpdate(DocumentEvent arg0) { }
        });

        root.add(gutter, BorderLayout.WEST);
        frame.add(root);
        frame.setBackground(Color.decode("#10141C"));
        frame.setVisible(true);
    }

    public class NonEditableLineDocumentFilter extends DocumentFilter {
        private AllowedEditRange r;

        public NonEditableLineDocumentFilter(IDE.AllowedEditRange r) {
            this.r = r;
        }

        @Override
        public void insertString(DocumentFilter.FilterBypass fb, int offset, String string, AttributeSet attr) throws BadLocationException {
            if(string != null) {
                replace(fb, offset, 0, string, attr);
            }
        }

        @Override
        public void remove(DocumentFilter.FilterBypass fb, int offset, int length) throws BadLocationException {
            replace(fb, offset, length, "", null);
        }

        @Override
        public void replace(DocumentFilter.FilterBypass fb, int offset, int length, String text, AttributeSet attrs) throws BadLocationException {
            // Our goal: only allow edits that start on line r.start forward.
            // If the edit is not within the allowed range, we will not perform it.
            if(r.start == -1)
                return;
            Document doc = fb.getDocument();
            if(fb.getDocument().getText(0, offset).chars().filter(x -> x == '\n').count() >= r.start) {
                fb.replace(offset, length, text, attrs);
            }
        }
    }
}
