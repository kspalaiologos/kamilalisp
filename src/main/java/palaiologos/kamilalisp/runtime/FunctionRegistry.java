package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.IO.GetFile;
import palaiologos.kamilalisp.runtime.IO.Writeln;
import palaiologos.kamilalisp.runtime.array.*;
import palaiologos.kamilalisp.runtime.math.*;
import palaiologos.kamilalisp.runtime.math.bit.*;
import palaiologos.kamilalisp.runtime.math.cmp.*;
import palaiologos.kamilalisp.runtime.math.hyperbolic.*;
import palaiologos.kamilalisp.runtime.math.trig.*;
import palaiologos.kamilalisp.runtime.meta.*;
import palaiologos.kamilalisp.runtime.string.Format;
import palaiologos.kamilalisp.runtime.string.Levenshtein;
import palaiologos.kamilalisp.runtime.string.Lines;
import palaiologos.kamilalisp.runtime.string.ToString;

import java.math.BigDecimal;
import java.util.Set;

public class FunctionRegistry {
    public static final Set<String> BUILTIN_BINDINGS = Set.of(
            "foldr", "**", "<=", "ln", "mod", "def", "range", "str-format", "tie", "lambda",
            "min", "car", "sqrt", "env-keys", "foldl", "str-lines", "foldl1", "exp", "foldr1",
            "if", "signum", "max", "e", "false", "*", "outer-product", "+", "reverse", "-",
            "/=", "/", "cdr", "true", "lift", "pi", "<", "=", ">", ">=", "levenshtein", "sin",
            "cos", "tan", "csc", "sec", "cot", "asin", "acos", "atan", "acot", "acsc", "asec",
            "sinh", "cosh", "tanh", "coth", "sech", "csch", "tally", "asinh", "acosh", "atanh",
            "acoth", "asech", "acsch", "log2", "log10", "gcd", "lcm", "gamma", "not", "bit-and",
            "bit-or", "bit-xor", "bit-nand", "bit-not", "bit-popcount", "fib", "ceil", "floor",
            "round", "and", "or", "abs", "to-string", "filter", "parallel-filter", "any", "all",
            "none", "sort", "scanl", "scanl1", "scanr", "scanr1", "replicate", "defun", "λ",
            "⌽", "⍳", "⊤", "⊥", "≠", "π", "√", "≥", "≤", "Γ", "¬", "⌈", "⌊", "∧", "∨", "⍭", "⍴",
            "same", "not-same", "≢", "≡", "grade-up", "grade-down", "⍋", "⍒", "cons", "flatten",
            "∊", "let", "cond", "cmpx", "import", "get-file", "try-catch"
    );
    public static void registerDefault(Environment env) {
        env.set("fr", new Atom(new BigDecimal(10)));
        env.set("lambda", new Atom(new Dfn()));
        env.set("λ", new Atom(new Dfn()));
        env.set("def", new Atom(new GlobalBinding()));
        env.set("+", new Atom(new Plus()));
        env.set("-", new Atom(new Minus()));
        env.set("*", new Atom(new Star()));
        env.set("/", new Atom(new Slash()));
        env.set("car", new Atom(new Car()));
        env.set("cdr", new Atom(new Cdr()));
        env.set("reverse", new Atom(new Reverse()));
        env.set("⌽", new Atom(new Reverse()));
        env.set("range", new Atom(new Range()));
        env.set("⍳", new Atom(new Range()));
        env.set("foldl", new Atom(new Foldl()));
        env.set("foldr", new Atom(new Foldr()));
        env.set("foldl1", new Atom(new Foldl1()));
        env.set("foldr1", new Atom(new Foldr1()));
        env.set("lift", new Atom(new Lift()));
        env.set("mod", new Atom(new Mod()));
        env.set("tie", new Atom(new Tie()));
        env.set("exp", new Atom(new Exp()));
        env.set("max", new Atom(new Max()));
        env.set("min", new Atom(new Min()));
        env.set("signum", new Atom(new Signum()));
        env.set("true", Atom.TRUE);
        env.set("⊤", Atom.TRUE);
        env.set("false", Atom.FALSE);
        env.set("⊥", Atom.FALSE);
        env.set("if", new Atom(new If()));
        env.set("=", new Atom(new Eq()));
        env.set("/=", new Atom(new Neq()));
        env.set("≠", new Atom(new Neq()));
        env.set("pi", new Atom(new Pi()));
        env.set("π", new Atom(new Pi()));
        env.set("e", new Atom(new E()));
        env.set("str-format", new Atom(new Format()));
        env.set("str-lines", new Atom(new Lines()));
        env.set("**", new Atom(new DoubleStar()));
        env.set("ln", new Atom(new Ln()));
        env.set("sqrt", new Atom(new Sqrt()));
        env.set("√", new Atom(new Sqrt()));
        env.set(">", new Atom(new Gt()));
        env.set("<", new Atom(new Lt()));
        env.set(">=", new Atom(new Ge()));
        env.set("≥", new Atom(new Ge()));
        env.set("<=", new Atom(new Le()));
        env.set("≤", new Atom(new Le()));
        env.set("sin", new Atom(new Sin()));
        env.set("cos", new Atom(new Cos()));
        env.set("tan", new Atom(new Tan()));
        env.set("asin", new Atom(new Asin()));
        env.set("acos", new Atom(new Acos()));
        env.set("atan", new Atom(new Atan()));
        env.set("csc", new Atom(new Csc()));
        env.set("sec", new Atom(new Sec()));
        env.set("cot", new Atom(new Cot()));
        env.set("acsc", new Atom(new Acsc()));
        env.set("asec", new Atom(new Asec()));
        env.set("acot", new Atom(new Acot()));
        env.set("sinh", new Atom(new Sinh()));
        env.set("cosh", new Atom(new Cosh()));
        env.set("tanh", new Atom(new Tanh()));
        env.set("coth", new Atom(new Coth()));
        env.set("sech", new Atom(new Sech()));
        env.set("csch", new Atom(new Csch()));
        env.set("asinh", new Atom(new Asinh()));
        env.set("acosh", new Atom(new Acosh()));
        env.set("atanh", new Atom(new Atanh()));
        env.set("acoth", new Atom(new Acoth()));
        env.set("asech", new Atom(new Asech()));
        env.set("acsch", new Atom(new Acsch()));
        env.set("log2", new Atom(new Log2()));
        env.set("log10", new Atom(new Log10()));
        env.set("gcd", new Atom(new Gcd()));
        env.set("lcm", new Atom(new Lcm()));
        env.set("gamma", new Atom(new Gamma()));
        env.set("Γ", new Atom(new Gamma()));
        env.set("not", new Atom(new Not()));
        env.set("¬", new Atom(new Not()));
        env.set("bit-and", new Atom(new BitAnd()));
        env.set("bit-or", new Atom(new BitOr()));
        env.set("bit-xor", new Atom(new BitXor()));
        env.set("bit-nand", new Atom(new BitNand()));
        env.set("bit-not", new Atom(new BitNot()));
        env.set("bit-popcount", new Atom(new BitPopcount()));
        env.set("fib", new Atom(new Fib()));
        env.set("ceil", new Atom(new Ceil()));
        env.set("⌈", new Atom(new Ceil()));
        env.set("floor", new Atom(new Floor()));
        env.set("⌊", new Atom(new Floor()));
        env.set("round", new Atom(new Round()));
        env.set("and", new Atom(new And()));
        env.set("or", new Atom(new Or()));
        env.set("∧", new Atom(new And()));
        env.set("∨", new Atom(new Or()));
        env.set("abs", new Atom(new Abs()));
        env.set("to-string", new Atom(new ToString()));
        env.set("filter", new Atom(new Filter()));
        env.set("⍭", new Atom(new Filter()));
        env.set("parallel-filter", new Atom(new ParallelFilter()));
        env.set("any", new Atom(new Any()));
        env.set("all", new Atom(new All()));
        env.set("none", new Atom(new None()));
        env.set("sort", new Atom(new Sort()));
        env.set("scanl", new Atom(new Scanl()));
        env.set("scanl1", new Atom(new Scanl1()));
        env.set("scanr", new Atom(new Scanr()));
        env.set("scanr1", new Atom(new Scanr1()));
        env.set("replicate", new Atom(new Replicate()));
        env.set("defun", new Atom(new Defun()));
        env.set("outer-product", new Atom(new OuterProduct()));
        env.set("env-keys", new Atom(new EnvKeys()));
        env.set("levenshtein", new Atom(new Levenshtein()));
        env.set("tally", new Atom(new Tally()));
        env.set("⍴", new Atom(new Tally()));
        env.set("same", new Atom(new Same()));
        env.set("not-same", new Atom(new NotSame()));
        env.set("≡", new Atom(new Same()));
        env.set("≢", new Atom(new NotSame()));
        env.set("grade-up", new Atom(new GradeUp()));
        env.set("grade-down", new Atom(new GradeDown()));
        env.set("⍋", new Atom(new GradeUp()));
        env.set("⍒", new Atom(new GradeDown()));
        env.set("cons", new Atom(new Cons()));
        env.set("flatten", new Atom(new Flatten()));
        env.set("∊", new Atom(new Flatten()));
        env.set("let", new Atom(new Let()));
        env.set("cond", new Atom(new Cond()));
        env.set("cmpx", new Atom(new Cmpx()));
        env.set("import", new Atom(new Import()));
        env.set("get-file", new Atom(new GetFile()));
        env.set("try-catch", new Atom(new TryCatch()));
        env.set("writeln", new Atom(new Writeln()));
    }
}
