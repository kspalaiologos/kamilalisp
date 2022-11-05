package palaiologos.kamilalisp.parser;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class DefaultGrammarVisitor extends GrammarBaseVisitor<Atom> {
    private final int lineNumberOffset;
    
    public DefaultGrammarVisitor(int lineNumberOffset) {
        this.lineNumberOffset = lineNumberOffset;
    }

    @Override
    public Atom visitFile_(GrammarParser.File_Context ctx) {
        return new CodeAtom(ctx.children.stream().map(this::visit).filter(Objects::nonNull).collect(Collectors.toList())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitForm(GrammarParser.FormContext ctx) {
        if(ctx.form_rem().size() == 1) {
            return visit(ctx.form_rem().get(0));
        } else {
            return new CodeAtom(new Compose(
                    ctx.form_rem().stream().map(this::visit).collect(Collectors.toList()), ctx.start.getLine() + lineNumberOffset, ctx.start.getCharPositionInLine())
            ).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
        }
    }

    @Override
    public Atom visitForm_rem(GrammarParser.Form_remContext ctx) {
        return visit(ctx.children.get(0));
    }

    @Override
    public Atom visitAny_list(GrammarParser.Any_listContext ctx) {
        return visit(ctx.children.get(0));
    }

    public List<Atom> listFromContent(List<GrammarParser.List_formContext> ctx) {
        List<Atom> list = new ArrayList<>();
        for(int i = 0; i < ctx.size(); i++) {
            if(ctx.get(i).getText().equals("\\")) {
                list.add(new CodeAtom(listFromContent(ctx.subList(i + 1, ctx.size()))).setCol(ctx.get(i).start.getCharPositionInLine()).setLine(ctx.get(i).start.getLine() + lineNumberOffset));
                break;
            } else {
                list.add(visit(ctx.get(i)));
            }
        }
        return list;
    }

    @Override
    public Atom visitList_(GrammarParser.List_Context ctx) {
        if(ctx.isEmpty()) {
            return new Atom(List.of());
        }
        if(ctx.list_form(0).getText().equals("\\")) {
            throw new RuntimeException("List cannot start with a \\ partition.");
        }
        if(ctx.list_form(ctx.list_form().size() - 1).getText().equals("\\")) {
            throw new RuntimeException("List cannot end with a \\ partition.");
        }
        for(int i = 0; i < ctx.list_form().size() - 1; i++) {
            if(ctx.list_form(i).getText().equals("\\") && ctx.list_form(i + 1).getText().equals("\\")) {
                throw new RuntimeException("List cannot have multiple consecutive \\ partitions.");
            }
        }
        return new CodeAtom(listFromContent(ctx.list_form())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    public Fork forkFromForms(List<GrammarParser.List_formContext> ctx) {
        Atom reductor = visit(ctx.get(0));
        List<Atom> reductees = new ArrayList<>();
        for(int i = 0; i < ctx.size(); i++) {
            if(ctx.get(i).getText().equals("\\")) {
                // Fork partition. Everything that goes after is another fork.
                reductees.add(
                    new CodeAtom(
                        forkFromForms(ctx.subList(i + 1, ctx.size()))
                    ).setCol(ctx.get(i).start.getCharPositionInLine()).setLine(ctx.get(i).start.getLine() + lineNumberOffset));
                break;
            } else {
                reductees.add(visit(ctx.get(i)));
            }
        }
        return new Fork(reductor, reductees, ctx.get(0).start.getLine() + lineNumberOffset, ctx.get(0).start.getCharPositionInLine());
    }

    @Override
    public Atom visitSqlist(GrammarParser.SqlistContext ctx) {
        // [a b\c d] = [a b [c d]] (fork syntax).
        // Disallow leading, trailing or multiple \'s.
        if(ctx.isEmpty()) {
            throw new RuntimeException("Empty fork list.");
        }
        if(ctx.list_form(0).getText().equals("\\")) {
            throw new RuntimeException("Fork list cannot start with a \\ partition.");
        }
        if(ctx.list_form(ctx.list_form().size() - 1).getText().equals("\\")) {
            throw new RuntimeException("Fork list cannot end with a \\ partition.");
        }
        for(int i = 0; i < ctx.list_form().size() - 1; i++) {
            if(ctx.list_form(i).getText().equals("\\") && ctx.list_form(i + 1).getText().equals("\\")) {
                throw new RuntimeException("Fork list cannot have multiple consecutive \\ partitions.");
            }
        }
        return new CodeAtom(forkFromForms(ctx.list_form())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitReader_macro(GrammarParser.Reader_macroContext ctx) {
        return visit(ctx.children.get(0));
    }

    @Override
    public Atom visitQuote(GrammarParser.QuoteContext ctx) {
        return new CodeAtom(new Quote(visit(ctx.form()), ctx.start.getLine() + lineNumberOffset, ctx.start.getCharPositionInLine())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitMap(GrammarParser.MapContext ctx) {
        Atom form = visit(ctx.form_rem());

        return new CodeAtom(new Map(form, ctx.start.getLine() + lineNumberOffset, ctx.start.getCharPositionInLine())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitTack(GrammarParser.TackContext ctx) {
        int[] indices;
        if(ctx.number().size() == 1) {
            indices = new int[] {Integer.parseInt(ctx.number(0).getText())};
        } else {
            indices = new int[] {Integer.parseInt(ctx.number(0).getText()), Integer.parseInt(ctx.number(1).getText())};
        }
        return new CodeAtom(new Tack(indices, ctx.start.getLine() + lineNumberOffset, ctx.start.getCharPositionInLine())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitOver(GrammarParser.OverContext ctx) {
        Atom form = visit(ctx.form_rem());
        return new CodeAtom(new Over(form, ctx.start.getLine() + lineNumberOffset, ctx.start.getCharPositionInLine())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitBind(GrammarParser.BindContext ctx) {
        return new CodeAtom(new ParitalApplication(visit(ctx.any_list()), ctx.start.getLine() + lineNumberOffset, ctx.start.getCharPositionInLine())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitLiteral(GrammarParser.LiteralContext ctx) {
        return visit(ctx.children.get(0));
    }

    @Override
    public Atom visitString_(GrammarParser.String_Context ctx) {
        return new CodeAtom(ctx.getText().substring(1, ctx.getText().length() - 1)).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitHex_(GrammarParser.Hex_Context ctx) {
        return new CodeAtom(new BigDecimal(new BigInteger(ctx.getText().substring(2), 16))).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitBin_(GrammarParser.Bin_Context ctx) {
        return new CodeAtom(new BigDecimal(new BigInteger(ctx.getText().substring(2), 2))).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }

    @Override
    public Atom visitNumber(GrammarParser.NumberContext ctx) {
        String numberString = ctx.getText();
        if(numberString.contains("J")) {
            // Complex numbers.
            List<BigDecimal> components = Arrays.stream(numberString.split("J")).map(BigDecimal::new).toList();
            return new CodeAtom(BigComplex.valueOf(components.get(0), components.get(1))).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
        } else {
            // Real numbers.
            return new CodeAtom(new BigDecimal(numberString)).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
        }
    }

    @Override
    public Atom visitNil_(GrammarParser.Nil_Context ctx) {
        return Atom.NULL;
    }

    @Override
    public Atom visitSymbol(GrammarParser.SymbolContext ctx) {
        return new CodeAtom(Identifier.of(ctx.NAME().getText())).setCol(ctx.start.getCharPositionInLine()).setLine(ctx.start.getLine() + lineNumberOffset);
    }
}
