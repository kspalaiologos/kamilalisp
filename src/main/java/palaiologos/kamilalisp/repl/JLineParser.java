package palaiologos.kamilalisp.repl;

import org.jline.reader.EOFError;
import org.jline.reader.ParsedLine;
import org.jline.reader.SyntaxError;
import org.jline.reader.impl.DefaultParser;

public class JLineParser extends DefaultParser {
    public JLineParser() {
        // XXX: None of this would be needed if it weren't for the fact that
        // JLine processes escapes *everywhere*, not just in strings. Clap clap.
        super();
        setEofOnUnclosedBracket(DefaultParser.Bracket.ROUND, DefaultParser.Bracket.SQUARE);
        setEscapeChars(new char[]{});
        setQuoteChars(new char[]{});
        eofOnUnclosedQuote(true);
    }

    public static boolean isTerminated(String text) {
        String q = text.replace("\\\"", "");
        long amount = q.chars().filter(ch -> ch == '"').count();
        // Eek. Unbalanced quotes.
        if (amount % 2 != 0)
            return false;
        // OK, quotes are balanced. Remove every instance of quotation in the input.
        q = q.replaceAll("\"[^\"]*\"", "");
        // Count open and closed parens.
        long open = q.chars().filter(ch -> ch == '(').count();
        long closed = q.chars().filter(ch -> ch == ')').count();
        if (open != closed)
            return false;
        open = q.chars().filter(ch -> ch == '{').count();
        closed = q.chars().filter(ch -> ch == '}').count();
        if (open != closed)
            return false;
        open = q.chars().filter(ch -> ch == '[').count();
        closed = q.chars().filter(ch -> ch == ']').count();
        return open == closed;
    }

    @Override
    public ParsedLine parse(String line, int cursor, ParseContext p) throws SyntaxError {
        // Replace '\"' with ' '. Count the amount of "s. If it's odd, throw eoferror.
        if (!isTerminated(line))
            throw new EOFError(0, 0, "EOF");
        return super.parse(line, cursor, p);
    }
}
