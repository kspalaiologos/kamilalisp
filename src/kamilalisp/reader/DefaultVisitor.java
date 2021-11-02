package kamilalisp.reader;

import kamilalisp.data.Atom;
import kamilalisp.data.Closure;
import kamilalisp.data.Executor;
import kamilalisp.data.StringConstant;
import org.antlr.v4.runtime.tree.AbstractParseTreeVisitor;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;

public class DefaultVisitor extends AbstractParseTreeVisitor<Atom> implements GrammarVisitor<Atom> {
    @Override
    public Atom visitFile_(GrammarParser.File_Context ctx) {
        List<Atom> l = ctx.form().stream().map(this::visit).collect(LinkedList::new, List::add, List::addAll);
        return new Atom(l);
    }

    @Override
    public Atom visitForm(GrammarParser.FormContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public Atom visitForms(GrammarParser.FormsContext ctx) {
        return null;
    }

    @Override
    public Atom visitList_(GrammarParser.List_Context ctx) {
        List<Atom> l = ctx.forms().form().stream().map(this::visit).collect(LinkedList::new, List::add, List::addAll);
        return new Atom(l);
    }

    @Override
    public Atom visitSqlist(GrammarParser.SqlistContext ctx) {
        List<Atom> l = ctx.forms().form().stream().map(this::visit).collect(LinkedList::new, List::add, List::addAll);
        if(l.size() >= 2) {
            Atom tmp = l.get(1);
            l.set(1, l.get(0));
            l.set(0, tmp);
        }
        return new Atom(l);
    }

    @Override
    public Atom visitReader_macro(GrammarParser.Reader_macroContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public Atom visitQuote(GrammarParser.QuoteContext ctx) {
        return new Atom(List.of(new Atom("quote"), visit(ctx.form())));
    }

    @Override
    public Atom visitTack(GrammarParser.TackContext ctx) {
        return new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                return arguments.get(Integer.valueOf(ctx.getText().substring(1)));
            }
        });
    }

    @Override
    public Atom visitLiteral(GrammarParser.LiteralContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public Atom visitString_(GrammarParser.String_Context ctx) {
        String text = ctx.getText();
        text = text.substring(1, text.length() - 1);
        text = text.replace("\\\"", "\"");
        return new Atom(new StringConstant(text));
    }

    @Override
    public Atom visitHex_(GrammarParser.Hex_Context ctx) {
        return new Atom(new BigDecimal(new BigInteger(ctx.getText(), 16)));
    }

    @Override
    public Atom visitBin_(GrammarParser.Bin_Context ctx) {
        return new Atom(new BigDecimal(new BigInteger(ctx.getText(), 2)));
    }

    @Override
    public Atom visitNumber(GrammarParser.NumberContext ctx) {
        return new Atom(new BigDecimal(ctx.getText()));
    }

    @Override
    public Atom visitNil_(GrammarParser.Nil_Context ctx) {
        return Atom.NULL;
    }

    @Override
    public Atom visitSymbol(GrammarParser.SymbolContext ctx) {
        return new Atom(ctx.getText());
    }
}
