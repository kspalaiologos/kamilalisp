package palaiologos.kamilalisp.parsers;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.collect.Streams;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Type;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Stream;

public class DefaultFortranFormulaGrammarVisitor extends FortranFormulaBaseVisitor<Atom> {
    private BigDecimal parseNumber(String s) {
        s = s.replace('D', 'E').replace('d', 'e');
        return new BigDecimal(s);
    }

    private String fortranToKL(String s) {
        switch (s) {
            case "ABS":
            case "DABS":
                return "abs";
            case "ACOS":
            case "DACOS":
                return "acos";
            case "ASIN":
            case "DASIN":
                return "asin";
            case "ATAN":
            case "DATAN":
                return "atan";
            case "ATAN2":
            case "DATAN2":
                return "atan2";
            case "COS":
            case "DCOS":
                return "cos";
            case "EXP":
            case "DEXP":
                return "exp";
            case "LOG":
            case "DLOG":
                return "ln";
            case "LOG10":
            case "DLOG10":
                return "log10";
            case "SIN":
            case "DSIN":
                return "sin";
            case "SQRT":
            case "DSQRT":
                return "sqrt";
            case "TAN":
            case "DTAN":
                return "tan";
            case "COTAN":
            case "DCOTAN":
                return "cot";
            case "ERF":
            case "DERF":
                return "erf";
            case "SINH":
            case "DSINH":
                return "sinh";
            case "COSH":
            case "DCOSH":
                return "cosh";
            case "TANH":
            case "DTANH":
                return "tanh";
            default:
                return s.toLowerCase();
        }
    }

    @Override
    public Atom visitMain(FortranFormulaParser.MainContext ctx) {
        HashMap<Atom, Atom> map = new HashMap();
        ctx.toplevel_rule().stream().map(this::visit).forEach(x -> map.put(x.getList().get(1), x.getList().get(2)));
        return new Atom(new HashMapUserData(HashTreePMap.from(map)));
    }

    @Override
    public Atom visitAssignRule(FortranFormulaParser.AssignRuleContext ctx) {
        String key = ctx.ID().getText();
        Atom value = visit(ctx.toplevel_rule());
        return new Atom(List.of(new Atom("=", true), new Atom(key), value));
    }

    @Override
    public Atom visitAssignExpr(FortranFormulaParser.AssignExprContext ctx) {
        String key = ctx.ID().getText();
        Atom value = visit(ctx.expr());
        return new Atom(List.of(new Atom("=", true), new Atom(key), value));
    }

    @Override
    public Atom visitToplevelExpr(FortranFormulaParser.ToplevelExprContext ctx) {
        Atom value = visit(ctx.expr());
        return new Atom(List.of(new Atom("=", true), new Atom("R"), value));
    }

    @Override
    public Atom visitAssignExprWithIndex(FortranFormulaParser.AssignExprWithIndexContext ctx) {
        String key = ctx.ID().getText() + "(" + ctx.NUMBER().getText() + ")";
        Atom value = visit(ctx.expr());
        return new Atom(List.of(new Atom("=", true), new Atom(key), value));
    }

    @Override
    public Atom visitAssignRuleWithIndex(FortranFormulaParser.AssignRuleWithIndexContext ctx) {
        String key = ctx.ID().getText() + "(" + ctx.NUMBER().getText() + ")";
        Atom value = visit(ctx.toplevel_rule());
        return new Atom(List.of(new Atom("=", true), new Atom(key), value));
    }

    @Override
    public Atom visitComplexConstant(FortranFormulaParser.ComplexConstantContext ctx) {
        Atom left = visit(ctx.expr(0));
        Atom right = visit(ctx.expr(1));
        if (left.getType() == Type.REAL && right.getType() == Type.REAL) {
            return new Atom(BigComplex.valueOf(left.getReal(), right.getReal()));
        } else {
            return new Atom(List.of(new Atom("+", true), left, new Atom(List.of(new Atom("*", true), new Atom(BigComplex.valueOf(BigDecimal.ZERO, BigDecimal.ONE)), right))));
        }
    }

    @Override
    public Atom visitParenthesis(FortranFormulaParser.ParenthesisContext ctx) {
        return visit(ctx.expr());
    }

    @Override
    public Atom visitMultiplication(FortranFormulaParser.MultiplicationContext ctx) {
        Atom expr1 = visit(ctx.expr(0));
        Atom expr2 = visit(ctx.expr(1));
        boolean p1 = expr1.getType() == Type.LIST && !expr1.getList().isEmpty() && expr1.getList().get(0).getType() == Type.IDENTIFIER && expr1.getList().get(0).getIdentifier().equals("*");
        boolean p2 = expr2.getType() == Type.LIST && !expr2.getList().isEmpty() && expr2.getList().get(0).getType() == Type.IDENTIFIER && expr2.getList().get(0).getIdentifier().equals("*");
        if (p1 || p2) {
            ArrayList<Atom> result = new ArrayList<>();
            result.add(new Atom("*", true));
            if (p1)
                result.addAll(expr1.getList().subList(1, expr1.getList().size()));
            else result.add(expr1);
            if (p2)
                result.addAll(expr2.getList().subList(1, expr2.getList().size()));
            else result.add(expr2);
            return new Atom(result);
        } else
            return new Atom(List.of(new Atom("*", true), expr1, expr2));
    }

    @Override
    public Atom visitAddition(FortranFormulaParser.AdditionContext ctx) {
        Atom expr1 = visit(ctx.expr(0));
        Atom expr2 = visit(ctx.expr(1));
        boolean p1 = expr1.getType() == Type.LIST && !expr1.getList().isEmpty() && expr1.getList().get(0).getType() == Type.IDENTIFIER && expr1.getList().get(0).getIdentifier().equals("+");
        boolean p2 = expr2.getType() == Type.LIST && !expr2.getList().isEmpty() && expr2.getList().get(0).getType() == Type.IDENTIFIER && expr2.getList().get(0).getIdentifier().equals("+");
        if (p1 || p2) {
            ArrayList<Atom> result = new ArrayList<>();
            result.add(new Atom("+", true));
            if (p1)
                result.addAll(expr1.getList().subList(1, expr1.getList().size()));
            else result.add(expr1);
            if (p2)
                result.addAll(expr2.getList().subList(1, expr2.getList().size()));
            else result.add(expr2);
            return new Atom(result);
        } else
            return new Atom(List.of(new Atom("+", true), expr1, expr2));
    }

    @Override
    public Atom visitInfinity(FortranFormulaParser.InfinityContext ctx) {
        return new Atom("oo", true);
    }

    @Override
    public Atom visitSubtraction(FortranFormulaParser.SubtractionContext ctx) {
        // (- (- a b) (- c d)) = (a - b) - (c - d) = a - b - (c - d) = (- a b (- c d))
        Atom expr1 = visit(ctx.expr(0));
        Atom expr2 = visit(ctx.expr(1));
        boolean p1 = expr1.getType() == Type.LIST && !expr1.getList().isEmpty() && expr1.getList().get(0).getType() == Type.IDENTIFIER && expr1.getList().get(0).getIdentifier().equals("+");
        if (p1) {
            ArrayList<Atom> result = new ArrayList<>(expr1.getList());
            result.add(expr2);
            return new Atom(result);
        } else {
            return new Atom(List.of(new Atom("-", true), expr1, expr2));
        }
    }

    @Override
    public Atom visitExponent(FortranFormulaParser.ExponentContext ctx) {
        return new Atom(List.of(new Atom("**", true), visit(ctx.expr(0)), visit(ctx.expr(1))));
    }

    @Override
    public Atom visitConstant(FortranFormulaParser.ConstantContext ctx) {
        if (ctx.ID().getText().equals("infinity"))
            return new Atom("oo", true);
        if (ctx.ID().getText().equals("%pi") || ctx.ID().getText().equals("pi"))
            return new Atom(List.of(new Atom("pi", true)));
        if (ctx.ID().getText().equals("%e") || ctx.ID().getText().equals("e"))
            return new Atom(List.of(new Atom("e", true)));
        if (ctx.ID().getText().equals("%i") || ctx.ID().getText().equals("i"))
            return new Atom(BigComplex.valueOf(BigDecimal.ZERO, BigDecimal.ONE));
        return new Atom(ctx.ID().getText(), true);
    }

    @Override
    public Atom visitNumber(FortranFormulaParser.NumberContext ctx) {
        return new Atom(parseNumber(ctx.NUMBER().getText()));
    }

    @Override
    public Atom visitFailed(FortranFormulaParser.FailedContext ctx) {
        return new Atom(ctx.getText().replace("\"", ""));
    }

    @Override
    public Atom visitUnaryPlus(FortranFormulaParser.UnaryPlusContext ctx) {
        Atom ch = visit(ctx.expr());
        if (ch.isNumeric())
            return ch;
        return new Atom(List.of(new Atom("+", true), ch));
    }

    @Override
    public Atom visitNegativeInfinity(FortranFormulaParser.NegativeInfinityContext ctx) {
        return new Atom("-oo", true);
    }

    @Override
    public Atom visitUnaryMinus(FortranFormulaParser.UnaryMinusContext ctx) {
        Atom ch = visit(ctx.expr());
        if (ch.isNumeric()) {
            if (ch.getType() == Type.REAL)
                return new Atom(ch.getReal().negate());
            else if (ch.getType() == Type.INTEGER)
                return new Atom(ch.getInteger().negate());
            else {
                return new Atom(BigComplex.valueOf(ch.getComplex().re.negate(), ch.getComplex().im));
            }
        }
        return new Atom(List.of(new Atom("-", true), ch));
    }

    @Override
    public Atom visitDivision(FortranFormulaParser.DivisionContext ctx) {
        return new Atom(List.of(new Atom("/", true), visit(ctx.expr(0)), visit(ctx.expr(1))));
    }

    @Override
    public Atom visitFunctionCall(FortranFormulaParser.FunctionCallContext ctx) {
        return new Atom(Streams.concat(Stream.of(new Atom(fortranToKL(ctx.ID().getText()), true)), ctx.expr().stream().map(this::visit)).toList());
    }
}
