package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.array.*;
import palaiologos.kamilalisp.runtime.math.*;
import palaiologos.kamilalisp.runtime.math.cmp.*;
import palaiologos.kamilalisp.runtime.math.hyperbolic.*;
import palaiologos.kamilalisp.runtime.math.trig.*;
import palaiologos.kamilalisp.runtime.meta.EnvKeys;
import palaiologos.kamilalisp.runtime.string.Format;
import palaiologos.kamilalisp.runtime.string.Levenshtein;
import palaiologos.kamilalisp.runtime.string.Lines;

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
            "acoth", "asech", "acsch"
    );
    public static void registerDefault(Environment env) {
        env.set("fr", new Atom(new BigDecimal(10)));
        env.set("lambda", new Atom(new Dfn()));
        env.set("def", new Atom(new GlobalBinding()));
        env.set("+", new Atom(new Plus()));
        env.set("-", new Atom(new Minus()));
        env.set("*", new Atom(new Star()));
        env.set("/", new Atom(new Slash()));
        env.set("car", new Atom(new Car()));
        env.set("cdr", new Atom(new Cdr()));
        env.set("reverse", new Atom(new Reverse()));
        env.set("range", new Atom(new Range()));
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
        env.set("true", new Atom(BigDecimal.valueOf(1)));
        env.set("false", new Atom(BigDecimal.valueOf(0)));
        env.set("if", new Atom(new If()));
        env.set("=", new Atom(new Eq()));
        env.set("/=", new Atom(new Neq()));
        env.set("pi", new Atom(new Pi()));
        env.set("e", new Atom(new E()));
        env.set("str-format", new Atom(new Format()));
        env.set("str-lines", new Atom(new Lines()));
        env.set("**", new Atom(new DoubleStar()));
        env.set("ln", new Atom(new Ln()));
        env.set("sqrt", new Atom(new Sqrt()));
        env.set(">", new Atom(new Gt()));
        env.set("<", new Atom(new Lt()));
        env.set(">=", new Atom(new Ge()));
        env.set("<=", new Atom(new Le()));
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
        env.set("outer-product", new Atom(new OuterProduct()));
        env.set("env-keys", new Atom(new EnvKeys()));
        env.set("levenshtein", new Atom(new Levenshtein()));
        env.set("tally", new Atom(new Tally()));
    }
}
