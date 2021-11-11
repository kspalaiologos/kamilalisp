package kamilalisp.reader;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;
import com.google.common.collect.Lists;
import kamilalisp.data.*;
import org.antlr.v4.runtime.tree.AbstractParseTreeVisitor;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class DefaultVisitor extends AbstractParseTreeVisitor<Atom> implements GrammarVisitor<Atom> {
    @Override
    public Atom visitFile_(GrammarParser.File_Context ctx) {
        List<Atom> l = ctx.form().stream().map(this::visit).collect(LinkedList::new, List::add, List::addAll);
        return new Atom(l);
    }

    @Override
    public Atom visitForm(GrammarParser.FormContext ctx) {
        if(ctx.form_rem().size() > 1) {
            List<Atom> components = Lists.reverse(ctx.form_rem().stream().map(x -> visitChildren(x)).collect(Collectors.toList()));
            return new Atom(new Closure() {
                @Override
                public Atom apply(Executor env, List<Atom> arguments) {
                    return new Atom(new LbcSupplier<>(() -> {
                        Atom x = env.evaluate(components.get(0)).getCallable().get().apply(env, arguments);
                        for(int i = 1; i < components.size(); i++)
                            x = env.evaluate(components.get(i)).getCallable().get().apply(env, List.of(x));
                        return x.get().get();
                    }));
                }
            });
        } else {
            return visit(ctx.form_rem(0));
        }
    }

    @Override
    public Atom visitForm_rem(GrammarParser.Form_remContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public Atom visitForms(GrammarParser.FormsContext ctx) {
        return null;
    }

    @Override
    public Atom visitAny_list(GrammarParser.Any_listContext ctx) {
        return visitChildren(ctx);
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
    public Atom visitFork(GrammarParser.ForkContext ctx) {
        List<Atom> tmp = visit(ctx.any_list()).getList().get();
        if(tmp.size() < 2)
            throw new Error("a fork can't be created out of less than two functions.");
        return new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                // #(f g h) <=> (f (g ...) (h ...))
                // #(f g) <=> (f (g ...))
                return new Atom(new LbcSupplier<>(() -> {
                    Atom first = env.evaluate(tmp.get(0));
                    first.guardType("fork head", Type.CLOSURE, Type.MACRO);
                    List<Atom> forkData = tmp.subList(1, tmp.size()).stream().map(x -> {
                        Atom a = env.evaluate(x);
                        a.guardType("fork child", Type.CLOSURE, Type.MACRO);
                        return a.getCallable().get().apply(env, arguments);
                    }).collect(Collectors.toList());
                    return first.getCallable().get().apply(env, forkData).get().get();
                }));
            }
        });
    }

    @Override
    public Atom visitBind(GrammarParser.BindContext ctx) {
        List<Atom> tmp = visit(ctx.any_list()).getList().get();
        if(tmp.size() < 1)
            throw new Error("a bind can't be created out of less than one entity.");
        return new Atom(Stream.concat(Stream.of(new Atom("bind")), tmp.stream()).collect(Collectors.toList()));
    }

    @Override
    public Atom visitTack(GrammarParser.TackContext ctx) {
        return new Atom(new Closure() {
            @Override
            public String representation() {
                return "#" + ctx.getText().substring(1);
            }

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
        if(ctx.getText().contains("J")) {
            String[] parts = ctx.getText().split("J");
            return new Atom(BigComplex.valueOf(new BigDecimal(parts[0]), new BigDecimal(parts[1])));
        } else
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
