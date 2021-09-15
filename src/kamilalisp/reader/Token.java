package kamilalisp.reader;

public class Token {
    TokenType type;
    String content;

    public Token(TokenType t, String c) {
        this.content = c; this.type = t;
    }

    @Override
    public String toString() {
        return "Token{" +
                "type=" + type +
                ", content='" + content + '\'' +
                '}';
    }
}
