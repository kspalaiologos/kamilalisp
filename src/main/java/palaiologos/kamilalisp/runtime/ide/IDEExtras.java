package palaiologos.kamilalisp.runtime.ide;

import javax.swing.*;
import javax.swing.border.MatteBorder;
import java.awt.*;

public class IDEExtras extends JPanel {
    public IDEExtras() {
        setLayout(new FlowLayout(FlowLayout.LEFT));
        setBorder(new MatteBorder(2, 0, 0, 0, Color.decode("#1E222A")));
        setBackground(Color.decode("#10141C"));

        JLabel networkStats = new JLabel();
        JLabel totalNetworkStats = new JLabel();
        JProgressBar memBar = new JProgressBar();
        memBar.setMaximum(100);
        memBar.setMinimum(0);
        memBar.setValue(0);
        memBar.setPreferredSize(new Dimension(100, 12));
        networkStats.setFont(IDE.apl333Font);
        totalNetworkStats.setFont(IDE.apl333Font);
        networkStats.setOpaque(true);
        totalNetworkStats.setOpaque(true);
        networkStats.setBackground(Color.decode("#10141C"));
        totalNetworkStats.setBackground(Color.decode("#10141C"));
        networkStats.setForeground(Color.decode("#FFFFFF"));
        totalNetworkStats.setForeground(Color.decode("#FFFFFF"));

        memBar.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                System.gc();
            }
        });

        new Thread(() -> {
            while (true) {
                long in = NetCounter.poolIn();
                long out = NetCounter.poolOut();
                long totalIn = NetCounter.getInTotal();
                long totalOut = NetCounter.getOutTotal();
                long totalMem = Runtime.getRuntime().totalMemory();
                long usedMem = totalMem - Runtime.getRuntime().freeMemory();
                IDE.invokeSwing(() -> {
                    networkStats.setText(String.format("∆↓ %s/s, ∆↑ %s/s", toHuman(in), toHuman(out)));
                    totalNetworkStats.setText(String.format("↓ %s, ↑ %s", toHuman(totalIn), toHuman(totalOut)));
                    memBar.setToolTipText(String.format("%s / %s", toHuman(usedMem), toHuman(totalMem)));
                    memBar.setValue((int) (usedMem * 100 / totalMem));
                });
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            }
        }).start();

        add(networkStats);
        add(makeSeparator());
        add(totalNetworkStats);
        add(makeSeparator());
        add(memBar);
    }

    private static String toHuman(long bytes) {
        if ((double) bytes < 1024) {
            return bytes + " B";
        } else if ((double) bytes < 1024 * 1024) {
            return String.format("%.2f kiB", (double) bytes / 1024);
        } else if ((double) bytes < 1024 * 1024 * 1024) {
            return String.format("%.2f MiB", (double) bytes / 1024 / 1024);
        } else {
            return String.format("%.2f GiB", (double) bytes / 1024 / 1024 / 1024);
        }
    }

    private static JLabel makeSeparator() {
        JLabel separator = new JLabel(" | ");
        separator.setFont(IDE.apl333Font);
        separator.setOpaque(true);
        separator.setBackground(Color.decode("#10141C"));
        separator.setForeground(Color.decode("#FFFFFF"));
        return separator;
    }
}
