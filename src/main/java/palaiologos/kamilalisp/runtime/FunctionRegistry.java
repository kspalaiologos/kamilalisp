package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.IO.GetFile;
import palaiologos.kamilalisp.runtime.IO.Writeln;
import palaiologos.kamilalisp.runtime.array.*;
import palaiologos.kamilalisp.runtime.array.hof.*;
import palaiologos.kamilalisp.runtime.datetime.*;
import palaiologos.kamilalisp.runtime.hashmap.*;
import palaiologos.kamilalisp.runtime.math.*;
import palaiologos.kamilalisp.runtime.math.bit.*;
import palaiologos.kamilalisp.runtime.math.cmp.*;
import palaiologos.kamilalisp.runtime.math.hyperbolic.*;
import palaiologos.kamilalisp.runtime.math.prime.*;
import palaiologos.kamilalisp.runtime.math.trig.*;
import palaiologos.kamilalisp.runtime.meta.*;
import palaiologos.kamilalisp.runtime.regex.RegexMatches;
import palaiologos.kamilalisp.runtime.regex.RegexReplace;
import palaiologos.kamilalisp.runtime.regex.RegexSplit;
import palaiologos.kamilalisp.runtime.string.*;

import java.math.BigDecimal;

public class FunctionRegistry {
    public static void registerDefault(Environment env) {
        env.setp("fr", new Atom(new BigDecimal(200)));
        env.setp("lambda", new Atom(new Dfn()));
        env.setp("λ", new Atom(new Dfn()));
        env.setp("def", new Atom(new GlobalBinding()));
        env.setp("○←", new Atom(new GlobalBinding()));
        env.setp("car", new Atom(new Car()));
        env.setp("cdr", new Atom(new Cdr()));
        env.setp("⍎", new Atom(new Car()));
        env.setp("⍕", new Atom(new Cdr()));
        env.setp("reverse", new Atom(new Reverse()));
        env.setp("⌽", new Atom(new Reverse()));
        env.setp("rotate", new Atom(new Rotate()));
        env.setp("⊖", new Atom(new Rotate()));
        env.setp("range", new Atom(new Range()));
        env.setp("⍳", new Atom(new Range()));
        env.setp("foldl", new Atom(new Foldl()));
        env.setp("⌿←", new Atom(new Foldl()));
        env.setp("foldr", new Atom(new Foldr()));
        env.setp("⌿→", new Atom(new Foldr()));
        env.setp("foldl1", new Atom(new Foldl1()));
        env.setp("⌿.←", new Atom(new Foldl1()));
        env.setp("foldr1", new Atom(new Foldr1()));
        env.setp("⌿.→", new Atom(new Foldr1()));
        env.setp("lift", new Atom(new Lift()));
        env.setp("⍏", new Atom(new Lift()));
        env.setp("tie", new Atom(new Tie()));
        env.setp(",⍧", new Atom(new Tie()));
        env.setp("if", new Atom(new If()));
        env.setp("↕", new Atom(new If()));
        env.setp("str:format", new Atom(new Format()));
        env.setp("⍫∊", new Atom(new Format()));
        env.setp("str:lines", new Atom(new Lines()));
        env.setp("to-string", new Atom(new ToString()));
        env.setp("⍫←", new Atom(new ToString()));
        env.setp("filter", new Atom(new Filter()));
        env.setp("⍭", new Atom(new Filter()));
        env.setp("filter-idx", new Atom(new FilterIdx()));
        env.setp("⍭¨", new Atom(new FilterIdx()));
        env.setp("map-idx", new Atom(new MapIdx()));
        env.setp("parallel-filter", new Atom(new ParallelFilter()));
        env.setp("⍭∵", new Atom(new ParallelFilter()));
        env.setp("∨?", new Atom(new Any()));
        env.setp("∧?", new Atom(new All()));
        env.setp("∅?", new Atom(new None()));
        env.setp("any", new Atom(new Any()));
        env.setp("all", new Atom(new All()));
        env.setp("none", new Atom(new None()));
        env.setp("count", new Atom(new Count()));
        env.setp("⍴?", new Atom(new Count()));
        env.setp("sort-asc", new Atom(new Sort()));
        env.setp("sort-desc", new Atom(new SortDesc()));
        env.setp("⊼", new Atom(new Sort()));
        env.setp("⊻", new Atom(new SortDesc()));
        env.setp("scanl", new Atom(new Scanl()));
        env.setp("⍀←", new Atom(new Scanl()));
        env.setp("⍀→", new Atom(new Scanr()));
        env.setp("⍀.←", new Atom(new Scanl1()));
        env.setp("⍀.→", new Atom(new Scanr1()));
        env.setp("scanl1", new Atom(new Scanl1()));
        env.setp("scanr", new Atom(new Scanr()));
        env.setp("scanr1", new Atom(new Scanr1()));
        env.setp("replicate", new Atom(new Replicate()));
        env.setp("∥", new Atom(new Replicate()));
        env.setp("defun", new Atom(new Defun()));
        env.setp("⍥←", new Atom(new Defun()));
        env.setp("outer-product", new Atom(new OuterProduct()));
        env.setp("⌼", new Atom(new OuterProduct()));
        env.setp("inner-product", new Atom(new InnerProduct()));
        env.setp("⌻", new Atom(new InnerProduct()));
        env.setp("env-keys", new Atom(new EnvKeys()));
        env.setp("levenshtein", new Atom(new Levenshtein()));
        env.setp("⍫≉", new Atom(new Levenshtein()));
        env.setp("shannon-entropy", new Atom(new Shannon()));
        env.setp("⍫⍴", new Atom(new Shannon()));
        env.setp("tally", new Atom(new Tally()));
        env.setp("⍴", new Atom(new Tally()));
        env.setp("rank", new Atom(new Rank()));
        env.setp("⍴⍴", new Atom(new Rank()));
        env.setp("same", new Atom(new Same()));
        env.setp("converge", new Atom(new Converge()));
        env.setp("→≡", new Atom(new Converge()));
        env.setp("not-same", new Atom(new NotSame()));
        env.setp("≡", new Atom(new Same()));
        env.setp("≢", new Atom(new NotSame()));
        env.setp("grade-up", new Atom(new GradeUp()));
        env.setp("grade-down", new Atom(new GradeDown()));
        env.setp("⍋", new Atom(new GradeUp()));
        env.setp("⍒", new Atom(new GradeDown()));
        env.setp("cons", new Atom(new Cons()));
        env.setp("⍟", new Atom(new Cons()));
        env.setp("flatten", new Atom(new Flatten()));
        env.setp("∊", new Atom(new Flatten()));
        env.setp("let", new Atom(new Let()));
        env.setp("○⊢", new Atom(new Let()));
        env.setp("cond", new Atom(new Cond()));
        env.setp("↕¨", new Atom(new Cond()));
        env.setp("cmpx", new Atom(new Cmpx()));
        env.setp("import", new Atom(new Import()));
        env.setp("○←⍫", new Atom(new Import()));
        env.setp("append", new Atom(new Append()));
        env.setp("list:group", new Atom(new Group()));
        env.setp("⌸", new Atom(new Group()));
        env.setp("⍠", new Atom(new Append()));
        env.setp("get-file", new Atom(new GetFile()));
        env.setp("⍫⊢", new Atom(new GetFile()));
        env.setp("try-catch", new Atom(new TryCatch()));
        env.setp("‼", new Atom(new TryCatch()));
        env.setp("raise", new Atom(new Raise()));
        env.setp("↑‼", new Atom(new Raise()));
        env.setp("writeln", new Atom(new Writeln()));
        env.setp("↑⍫", new Atom(new Writeln()));
        env.setp("let-seq", new Atom(new LetSeq()));
        env.setp("○⊢¨", new Atom(new LetSeq()));
        env.setp("while", new Atom(new While()));
        env.setp("partial-while", new Atom(new PartialWhile()));
        env.setp("⍣", new Atom(new While()));
        env.setp("⍀⍣", new Atom(new PartialWhile()));
        env.setp("memo", new Atom(new Memo()));
        env.setp("⌹↔", new Atom(new Memo()));
        env.setp("index-of", new Atom(new IndexOf()));
        env.setp("∊?", new Atom(new IndexOf()));
        env.setp("to-digits", new Atom(new ToDigits()));
        env.setp("⌹⊙", new Atom(new ToDigits()));
        env.setp("without", new Atom(new Without()));
        env.setp("⍪", new Atom(new Without()));
        env.setp("from-digits", new Atom(new FromDigits()));
        env.setp("⊙⌹", new Atom(new FromDigits()));
        env.setp("cycle", new Atom(new Cycle()));
        env.setp("⍉↩", new Atom(new Cycle()));
        env.setp("take", new Atom(new Take()));
        env.setp("↑", new Atom(new Take()));
        env.setp("drop", new Atom(new Drop()));
        env.setp("↓", new Atom(new Drop()));
        env.setp("unique-mask", new Atom(new UniqueMask()));
        env.setp("⊙¨", new Atom(new UniqueMask()));
        env.setp("unique", new Atom(new Unique()));
        env.setp("⊙", new Atom(new Unique()));
        env.setp("intersection", new Atom(new Intersection()));
        env.setp("⋂", new Atom(new Intersection()));
        env.setp("union", new Atom(new Union()));
        env.setp("⋃", new Atom(new Union()));
        env.setp("parse-number", new Atom(new ParseNumber()));
        env.setp("⊙⍫", new Atom(new ParseNumber()));
        env.setp("prefixes", new Atom(new Prefixes()));
        env.setp("ᑈ", new Atom(new Prefixes()));
        env.setp("suffixes", new Atom(new Suffixes()));
        env.setp("ᐵ", new Atom(new Suffixes()));
        env.setp("interleave", new Atom(new Interleave()));
        env.setp("⍧", new Atom(new Interleave()));
        env.setp("take-while", new Atom(new TakeWhile()));
        env.setp("drop-while", new Atom(new DropWhile()));
        env.setp("⍣↑", new Atom(new TakeWhile()));
        env.setp("⍣↓", new Atom(new DropWhile()));

        env.setp("prime:factors", new Atom(new PrimeFactors()));
        env.setp("prime:is?", new Atom(new IsPrime()));
        env.setp("prime:next", new Atom(new NextPrime()));
        env.setp("prime:nth", new Atom(new PrimeNo()));

        env.setp("abs", new Atom(new Abs()));
        env.setp("bernoulli", new Atom(new Bernoulli()));
        env.setp("**", new Atom(new DoubleStar()));
        env.setp("ln", new Atom(new Ln()));
        env.setp("sqrt", new Atom(new Sqrt()));
        env.setp("√", new Atom(new Sqrt()));
        env.setp(">", new Atom(new Gt()));
        env.setp("<", new Atom(new Lt()));
        env.setp(">=", new Atom(new Ge()));
        env.setp("≥", new Atom(new Ge()));
        env.setp("<=", new Atom(new Le()));
        env.setp("≤", new Atom(new Le()));
        env.setp("sin", new Atom(new Sin()));
        env.setp("cos", new Atom(new Cos()));
        env.setp("tan", new Atom(new Tan()));
        env.setp("asin", new Atom(new Asin()));
        env.setp("acos", new Atom(new Acos()));
        env.setp("atan", new Atom(new Atan()));
        env.setp("re", new Atom(new Re()));
        env.setp("complex-parts", new Atom(new ComplexParts()));
        env.setp("im", new Atom(new Im()));
        env.setp("csc", new Atom(new Csc()));
        env.setp("sec", new Atom(new Sec()));
        env.setp("cot", new Atom(new Cot()));
        env.setp("acsc", new Atom(new Acsc()));
        env.setp("asec", new Atom(new Asec()));
        env.setp("acot", new Atom(new Acot()));
        env.setp("sinh", new Atom(new Sinh()));
        env.setp("cosh", new Atom(new Cosh()));
        env.setp("tanh", new Atom(new Tanh()));
        env.setp("coth", new Atom(new Coth()));
        env.setp("sech", new Atom(new Sech()));
        env.setp("csch", new Atom(new Csch()));
        env.setp("asinh", new Atom(new Asinh()));
        env.setp("acosh", new Atom(new Acosh()));
        env.setp("atanh", new Atom(new Atanh()));
        env.setp("acoth", new Atom(new Acoth()));
        env.setp("asech", new Atom(new Asech()));
        env.setp("acsch", new Atom(new Acsch()));
        env.setp("log2", new Atom(new Log2()));
        env.setp("log10", new Atom(new Log10()));
        env.setp("gcd", new Atom(new Gcd()));
        env.setp("lcm", new Atom(new Lcm()));
        env.setp("gamma", new Atom(new Gamma()));
        env.setp("Γ", new Atom(new Gamma()));
        env.setp("not", new Atom(new Not()));
        env.setp("¬", new Atom(new Not()));
        env.setp("bit:and", new Atom(new BitAnd()));
        env.setp("bit:or", new Atom(new BitOr()));
        env.setp("bit:xor", new Atom(new BitXor()));
        env.setp("bit:nand", new Atom(new BitNand()));
        env.setp("bit:not", new Atom(new BitNot()));
        env.setp("bit:popcount", new Atom(new BitPopcount()));
        env.setp("⌶:∧", new Atom(new BitAnd()));
        env.setp("⌶:∨", new Atom(new BitOr()));
        env.setp("⌶:≠", new Atom(new BitXor()));
        env.setp("⌶:¬∧", new Atom(new BitNand()));
        env.setp("⌶:¬", new Atom(new BitNot()));
        env.setp("⌶:⍏", new Atom(new BitPopcount()));
        env.setp("fib", new Atom(new Fib()));
        env.setp("ceil", new Atom(new Ceil()));
        env.setp("⌈", new Atom(new Ceil()));
        env.setp("floor", new Atom(new Floor()));
        env.setp("⌊", new Atom(new Floor()));
        env.setp("round", new Atom(new Round()));
        env.setp("and", new Atom(new And()));
        env.setp("or", new Atom(new Or()));
        env.setp("∧", new Atom(new And()));
        env.setp("∨", new Atom(new Or()));
        env.setp("exp", new Atom(new Exp()));
        env.setp("max", new Atom(new Max()));
        env.setp("min", new Atom(new Min()));
        env.setp("signum", new Atom(new Signum()));
        env.setp("true", Atom.TRUE);
        env.setp("⊤", Atom.TRUE);
        env.setp("false", Atom.FALSE);
        env.setp("⊥", Atom.FALSE);
        env.setp("=", new Atom(new Eq()));
        env.setp("/=", new Atom(new Neq()));
        env.setp("≠", new Atom(new Neq()));
        env.setp("pi", new Atom(new Pi()));
        env.setp("π", new Atom(new Pi()));
        env.setp("e", new Atom(new E()));
        env.setp("+", new Atom(new Plus()));
        env.setp("-", new Atom(new Minus()));
        env.setp("*", new Atom(new Star()));
        env.setp("/", new Atom(new Slash()));
        env.setp("mod", new Atom(new Mod()));
        env.setp("<=>", new Atom(new Spaceship()));
        env.setp("⇔", new Atom(new Spaceship()));
        env.setp("ucs", new Atom(new Ucs()));
        env.setp("match", new Atom(new Match()));
        env.setp("→", new Atom(new Match()));
        env.setp("list:shuffle", new Atom(new Shuffle()));
        env.setp("random", new Atom(new Random()));
        env.setp("⍰", new Atom(new Random()));

        env.setp("bipartition", new Atom(new Bipartition()));
        env.setp("list:partition", new Atom(new PartitionRange()));
        env.setp("⍡", new Atom(new PartitionRange()));

        env.setp("⌹⇔⍡", new Atom(new Windows()));
        env.setp("list:windows", new Atom(new Windows()));

        env.setp("regex:matches?", new Atom(new RegexMatches()));
        env.setp("regex:replace", new Atom(new RegexReplace()));
        env.setp("regex:split", new Atom(new RegexSplit()));

        env.setp("⍫⊖∊?", new Atom(new RegexMatches()));
        env.setp("⍫⊖⍆", new Atom(new RegexReplace()));
        env.setp("⍫⊖⍭", new Atom(new RegexSplit()));

        env.setp("date:from", new Atom(new DateTimeFrom()));
        env.setp("time:from", new Atom(new TimeFrom()));
        env.setp("date:add", new Atom(new DateTimeAdd()));
        env.setp("date:difference", new Atom(new DateTimeDifference()));
        env.setp("time:hours", new Atom(new TimeHours()));
        env.setp("time:minutes", new Atom(new TimeMinutes()));
        env.setp("time:seconds", new Atom(new TimeSeconds()));
        env.setp("time:nanoseconds", new Atom(new TimeNanoseconds()));
        env.setp("date:years", new Atom(new DateYears()));
        env.setp("date:months", new Atom(new DateMonths()));
        env.setp("date:days", new Atom(new DateDays()));
        env.setp("date:to-list", new Atom(new DateTimeToList()));
        env.setp("date:day-of-week", new Atom(new DateTimeDayOfWeek()));
        env.setp("date:now", new Atom(new DateNow()));
        env.setp("date:now-tz", new Atom(new DateNowTZ()));
        env.setp("time:now", new Atom(new TimeNow()));
        env.setp("time:now-tz", new Atom(new TimeNowTZ()));
        env.setp("date:parse", new Atom(new DateParse()));
        env.setp("time:parse", new Atom(new TimeParse()));

        env.setp("hashmap:from-list", new Atom(new HashMapFromList()));
        env.setp("hashmap:as-list", new Atom(new HashMapAsList()));
        env.setp("hashmap:size", new Atom(new HashMapSize()));
        env.setp("hashmap:key-list", new Atom(new HashMapKeyList()));
        env.setp("hashmap:value-list", new Atom(new HashMapValueList()));
        env.setp("hashmap:contains-key?", new Atom(new HashMapContainsKey()));
        env.setp("hashmap:contains-value?", new Atom(new HashMapContainsValue()));
        env.setp("hashmap:get", new Atom(new HashMapGet()));
        env.setp("hashmap:adjoin", new Atom(new HashMapAdjoin()));
        env.setp("hashmap:minus", new Atom(new HashMapMinus()));
        env.setp("hashmap:merge", new Atom(new HashMapMerge()));
        env.setp("hashmap:without", new Atom(new HashMapWithout()));
        env.setp("hashmap:group", new Atom(new HashMapGroup()));

        env.setp("⍔⌿", new Atom(new HashMapFromList()));
        env.setp("⍔⍀", new Atom(new HashMapAsList()));
        env.setp("⍔⍴", new Atom(new HashMapSize()));
        env.setp("⍔⍎", new Atom(new HashMapKeyList()));
        env.setp("⍔⍕", new Atom(new HashMapValueList()));
        env.setp("⍔⍎?", new Atom(new HashMapContainsKey()));
        env.setp("⍔⍕?", new Atom(new HashMapContainsValue()));
        env.setp("⍔⍆", new Atom(new HashMapGet()));
        env.setp("⍔+", new Atom(new HashMapAdjoin()));
        env.setp("⍔-", new Atom(new HashMapMinus()));
        env.setp("⍔⋃", new Atom(new HashMapMerge()));
        env.setp("⍔⍪", new Atom(new HashMapWithout()));
        env.setp("⍔⌸", new Atom(new HashMapGroup()));
    }
}
