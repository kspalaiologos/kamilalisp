package kamilalisp.reader;

import kamilalisp.data.Atom;
import kamilalisp.data.StringConstant;

import java.math.BigDecimal;
import java.util.LinkedList;
import java.util.List;

public class Parser {
    private List<Token> input;
    private int inputOffset = 0;

    public Parser(List<Token> input) {
        this.input = input;
    }

    private List<Atom> parseList(TokenType t) {
        List<Atom> data = new LinkedList<Atom>();
        while(input.get(inputOffset).type != t)
            data.add(parse());
        inputOffset++;
        return data;
    }

    public boolean hasMore() {
        return input.size() > inputOffset;
    }

    public Atom parse() {
        if(!hasMore())
            throw new Error("Unexpected end of input.");
        Token token = input.get(inputOffset++);
        switch(token.type) {
            case LP: return new Atom(parseList(TokenType.RP));
            case LS: {
                List<Atom> data = parseList(TokenType.RS);

                if(data.size() >= 2) {
                    Atom tmp = data.get(1);
                    data.set(1, data.get(0));
                    data.set(0, tmp);
                }

                return new Atom(data);
            }
            case NIL:
                return new Atom();
            case NUM:
                return new Atom(new BigDecimal(token.content));
            case QUOT:
                return new Atom(List.of(new Atom("quote"), parse()));
            case STR:
                return new Atom(new StringConstant(token.content));
            case ID:
                return new Atom(token.content);
            case TACK:
                return new Atom("$" + token.content);
            case NTH:
                return new Atom("#" + token.content);
        }

        return null;
    }
}
