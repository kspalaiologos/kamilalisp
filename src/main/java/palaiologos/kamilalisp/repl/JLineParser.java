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
        setEofOnUnclosedBracket(null);
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
        // Count open and closed parens.
        q = q.replaceAll("\"[^\"]*\"", "");
        long openParen = 0, closeParen = 0, openBracket = 0, closeBracket = 0, openBrace = 0, closeBrace = 0;
        for(int i = 0; i < q.length(); i++) {
            char ch = q.charAt(i);
            if (ch == '(') openParen++;
            if (ch == ')') closeParen++;
            if (ch == '[') openBracket++;
            if (ch == ']') closeBracket++;
            if (ch == '{') openBrace++;
            if (ch == '}') closeBrace++;
        }
        return openParen == closeParen && openBrace == closeBrace && openBracket == closeBracket;
    }

    @Override
    public ParsedLine parse(String line, int cursor, ParseContext p) throws SyntaxError {
        // Replace '\"' with ' '. Count the amount of "s. If it's odd, throw eoferror.
        if (!isTerminated(line))
            throw new EOFError(0, 0, "EOF");
        return super.parse(line, cursor, p);
    }
}
