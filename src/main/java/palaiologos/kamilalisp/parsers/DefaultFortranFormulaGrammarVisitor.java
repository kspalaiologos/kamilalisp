package palaiologos.kamilalisp.parsers;

import ch.obermuhlner.math.big.BigComplex;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Type;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class DefaultFortranFormulaGrammarVisitor extends FortranFormulaBaseVisitor<Atom> {
    private final static Atom assignment = new Atom("=", true);
    private final static Atom plus = new Atom("+", true);
    private final static Atom prod = new Atom("*", true);
    private static final Atom infty = new Atom("oo", true);
    private static final Atom neginfty = new Atom("-oo", true);
    private static final Atom sub = new Atom("-", true);
    private static final Atom exp = new Atom("**", true);
    private static final Atom div = new Atom("/", true);
    private static final Atom i = new Atom(BigComplex.I);
    private static final Atom pi = new Atom(List.of(new Atom("pi", true)));
    private static final Atom e = new Atom(List.of(new Atom("e", true)));
    private static final Atom r = new Atom("R");
    private static final Atom fabs = new Atom("abs", true);
    private static final Atom facos = new Atom("acos", true);
    private static final Atom fasin = new Atom("asin", true);
    private static final Atom fatan = new Atom("atan", true);
    private static final Atom fatan2 = new Atom("atan2", true);
    private static final Atom fcos = new Atom("cos", true);
    private static final Atom fexp = new Atom("exp", true);
    private static final Atom fln = new Atom("ln", true);
    private static final Atom flog10 = new Atom("log10", true);
    private static final Atom fsin = new Atom("sin", true);
    private static final Atom fsqrt = new Atom("sqrt", true);
    private static final Atom ftan = new Atom("tan", true);
    private static final Atom fcot = new Atom("cot", true);
    private static final Atom ferf = new Atom("erf", true);
    private static final Atom fsinh = new Atom("sinh", true);
    private static final Atom fcosh = new Atom("cosh", true);
    private static final Atom ftanh = new Atom("tanh", true);

    private BigDecimal parseNumber(String s) {
        s = s.replace('D', 'E').replace('d', 'e');
        return new BigDecimal(s);
    }

    private Atom fortranToKL(String s) {
        return switch (s) {
            case "ABS", "DABS" -> fabs;
            case "ACOS", "DACOS" -> facos;
            case "ASIN", "DASIN" -> fasin;
            case "ATAN", "DATAN" -> fatan;
            case "ATAN2", "DATAN2" -> fatan2;
            case "COS", "DCOS" -> fcos;
            case "EXP", "DEXP" -> fexp;
            case "LOG", "DLOG" -> fln;
            case "LOG10", "DLOG10" -> flog10;
            case "SIN", "DSIN" -> fsin;
            case "SQRT", "DSQRT" -> fsqrt;
            case "TAN", "DTAN" -> ftan;
            case "COTAN", "DCOTAN" -> fcot;
            case "ERF", "DERF" -> ferf;
            case "SINH", "DSINH" -> fsinh;
            case "COSH", "DCOSH" -> fcosh;
            case "TANH", "DTANH" -> ftanh;
            default -> new Atom(s.toLowerCase(), true);
        };
    }

    @Override
    public Atom visitMain(FortranFormulaParser.MainContext ctx) {
        HashMap<Atom, Atom> map = new HashMap<>();
        for (var toplevelRuleContext : ctx.toplevel_rule()) {
            Atom x = visit(toplevelRuleContext);
            map.put(x.getList().get(1), x.getList().get(2));
        }
        return new Atom(new HashMapUserData(HashTreePMap.from(map)));
    }

    @Override
    public Atom visitAssignRule(FortranFormulaParser.AssignRuleContext ctx) {
        String key = ctx.ID().getText();
        Atom value = visit(ctx.toplevel_rule());
        return new Atom(List.of(assignment, new Atom(key), value));
    }

    @Override
    public Atom visitAssignExpr(FortranFormulaParser.AssignExprContext ctx) {
        String key = ctx.ID().getText();
        Atom value = visit(ctx.expr());
        return new Atom(List.of(assignment, new Atom(key), value));
    }

    @Override
    public Atom visitToplevelExpr(FortranFormulaParser.ToplevelExprContext ctx) {
        Atom value = visit(ctx.expr());
        return new Atom(List.of(assignment, r, value));
    }

    @Override
    public Atom visitAssignExprWithIndex(FortranFormulaParser.AssignExprWithIndexContext ctx) {
        String key = ctx.ID().getText() + "(" + ctx.NUMBER().getText() + ")";
        Atom value = visit(ctx.expr());
        return new Atom(List.of(assignment, new Atom(key), value));
    }

    @Override
    public Atom visitAssignRuleWithIndex(FortranFormulaParser.AssignRuleWithIndexContext ctx) {
        String key = ctx.ID().getText() + "(" + ctx.NUMBER().getText() + ")";
        Atom value = visit(ctx.toplevel_rule());
        return new Atom(List.of(assignment, new Atom(key), value));
    }

    @Override
    public Atom visitComplexConstant(FortranFormulaParser.ComplexConstantContext ctx) {
        Atom left = visit(ctx.expr(0));
        Atom right = visit(ctx.expr(1));
        if (left.getType() == Type.REAL && right.getType() == Type.REAL) {
            return new Atom(BigComplex.valueOf(left.getReal(), right.getReal()));
        } else {
            return new Atom(List.of(plus, left, new Atom(List.of(prod, i, right))));
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
            result.add(prod);
            if (p1)
                result.addAll(expr1.getList().subList(1, expr1.getList().size()));
            else result.add(expr1);
            if (p2)
                result.addAll(expr2.getList().subList(1, expr2.getList().size()));
            else result.add(expr2);
            return new Atom(result);
        } else
            return new Atom(List.of(prod, expr1, expr2));
    }

    @Override
    public Atom visitAddition(FortranFormulaParser.AdditionContext ctx) {
        Atom expr1 = visit(ctx.expr(0));
        Atom expr2 = visit(ctx.expr(1));
        boolean p1 = expr1.getType() == Type.LIST && !expr1.getList().isEmpty() && expr1.getList().get(0).getType() == Type.IDENTIFIER && expr1.getList().get(0).getIdentifier().equals("+");
        boolean p2 = expr2.getType() == Type.LIST && !expr2.getList().isEmpty() && expr2.getList().get(0).getType() == Type.IDENTIFIER && expr2.getList().get(0).getIdentifier().equals("+");
        if (p1 || p2) {
            ArrayList<Atom> result = new ArrayList<>();
            result.add(plus);
            if (p1)
                result.addAll(expr1.getList().subList(1, expr1.getList().size()));
            else result.add(expr1);
            if (p2)
                result.addAll(expr2.getList().subList(1, expr2.getList().size()));
            else result.add(expr2);
            return new Atom(result);
        } else
            return new Atom(List.of(plus, expr1, expr2));
    }

    @Override
    public Atom visitInfinity(FortranFormulaParser.InfinityContext ctx) {
        return infty;
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
            return new Atom(List.of(sub, expr1, expr2));
        }
    }

    @Override
    public Atom visitExponent(FortranFormulaParser.ExponentContext ctx) {
        return new Atom(List.of(exp, visit(ctx.expr(0)), visit(ctx.expr(1))));
    }

    @Override
    public Atom visitConstant(FortranFormulaParser.ConstantContext ctx) {
        if (ctx.ID().getText().equals("infinity"))
            return infty;
        if (ctx.ID().getText().equals("%pi") || ctx.ID().getText().equals("pi"))
            return pi;
        if (ctx.ID().getText().equals("%e") || ctx.ID().getText().equals("e"))
            return e;
        if (ctx.ID().getText().equals("%i") || ctx.ID().getText().equals("i"))
            return i;
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
        return new Atom(List.of(plus, ch));
    }

    @Override
    public Atom visitNegativeInfinity(FortranFormulaParser.NegativeInfinityContext ctx) {
        return neginfty;
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
        return new Atom(List.of(sub, ch));
    }

    @Override
    public Atom visitDivision(FortranFormulaParser.DivisionContext ctx) {
        return new Atom(List.of(div, visit(ctx.expr(0)), visit(ctx.expr(1))));
    }

    @Override
    public Atom visitFunctionCall(FortranFormulaParser.FunctionCallContext ctx) {
        ArrayList<Atom> data = new ArrayList<>();
        data.add(fortranToKL(ctx.ID().getText()));
        for (FortranFormulaParser.ExprContext expr : ctx.expr())
            data.add(visit(expr));
        return new Atom(data);
    }
}
