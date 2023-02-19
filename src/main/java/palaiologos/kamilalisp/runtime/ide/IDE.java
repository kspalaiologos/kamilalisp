package palaiologos.kamilalisp.runtime.ide;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;

public class IDE {
    JFrame frame;
    JComponent root;

    public IDE() {
        frame = new JFrame("KamilaLisp");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        root = new JPanel();
        root.setBackground(Color.decode("#10141C"));
        root.setBorder(null);
        root.setLayout(new BorderLayout());
        Terminal t = new Terminal();
        Session s = new Session(t);
        JScrollPane jsp = new JScrollPane(t);
        jsp.setBorder(null);
        root.add(jsp, BorderLayout.CENTER);
        frame.add(root);
        frame.setBackground(Color.decode("#10141C"));
        frame.setVisible(true);
        s.run();
    }
}
