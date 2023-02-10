package palaiologos.kamilalisp.repl;

import org.jline.utils.AttributedStringBuilder;
import org.jline.utils.AttributedStyle;

public class AttributedStringParser {
    public static AttributedStringBuilder parse(String a) {
        AttributedStringBuilder b = new AttributedStringBuilder();
        String[] data = a.split(",");
        for (String s : data) {
            if (s.isEmpty())
                b.append(",");
            else if (s.equals("%%"))
                b.append("%");
            else if (s.startsWith("%")) {
                AttributedStyle style = AttributedStyle.DEFAULT;
                String[] parts = s.substring(1).split(":");
                for (String part : parts) {
                    switch (part) {
                        case "bold" -> style = style.bold();
                        case "italic" -> style = style.italic();
                        case "underline" -> style = style.underline();
                        case "blink" -> style = style.blink();
                        case "faint" -> style = style.faint();
                        case "crossed-out" -> style = style.crossedOut();
                        case "inverse" -> style = style.inverse();
                        case "no-bold" -> style = style.boldOff();
                        case "no-italic" -> style = style.italicOff();
                        case "no-underline" -> style = style.underlineOff();
                        case "no-blink" -> style = style.blinkOff();
                        case "no-faint" -> style = style.faintOff();
                        case "no-crossed-out" -> style = style.crossedOutOff();
                        case "no-inverse" -> style = style.inverseOff();
                        case "reset" -> style = AttributedStyle.DEFAULT;
                        case "fgblack" -> style = style.foreground(AttributedStyle.BLACK);
                        case "fgred" -> style = style.foreground(AttributedStyle.RED);
                        case "fggreen" -> style = style.foreground(AttributedStyle.GREEN);
                        case "fgyellow" -> style = style.foreground(AttributedStyle.YELLOW);
                        case "fgblue" -> style = style.foreground(AttributedStyle.BLUE);
                        case "fgmagenta" -> style = style.foreground(AttributedStyle.MAGENTA);
                        case "fgcyan" -> style = style.foreground(AttributedStyle.CYAN);
                        case "fgwhite" -> style = style.foreground(AttributedStyle.WHITE);
                        case "bgblack" -> style = style.background(AttributedStyle.BLACK);
                        case "bgred" -> style = style.background(AttributedStyle.RED);
                        case "bggreen" -> style = style.background(AttributedStyle.GREEN);
                        case "bgyellow" -> style = style.background(AttributedStyle.YELLOW);
                        case "bgblue" -> style = style.background(AttributedStyle.BLUE);
                        case "bgmagenta" -> style = style.background(AttributedStyle.MAGENTA);
                        case "bgcyan" -> style = style.background(AttributedStyle.CYAN);
                        case "bgwhite" -> style = style.background(AttributedStyle.WHITE);
                        default -> {
                            if (part.startsWith("fg")) {
                                try {
                                    int color = Integer.parseInt(part.substring(2));
                                    style = style.foregroundRgb(color);
                                } catch (NumberFormatException ignored) {
                                }
                            } else if (part.startsWith("bg")) {
                                try {
                                    int color = Integer.parseInt(part.substring(2));
                                    style = style.backgroundRgb(color);
                                } catch (NumberFormatException ignored) {
                                }
                            } else {
                                throw new RuntimeException("Unknown style: " + part);
                            }
                        }
                    }
                }
            } else {
                b.append(s);
            }
        }
        return b;
    }
}
