package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class Flt64Base {
    private abstract class Flt64Function extends PrimitiveFunction implements Lambda { }

    private static double toFlt64(Atom a) {
        return switch(a.getType()) {
            case INTEGER -> a.getInteger().doubleValue();
            case REAL -> a.getReal().doubleValue();
            case COMPLEX -> a.getComplex().re.doubleValue();
            default -> throw new IllegalArgumentException("Cannot convert " + a.getType() + " to flt64");
        };
    }

    public static Atom toAtom(double d) {
        return new Atom(BigDecimal.valueOf(d));
    }

    public final Flt64Function add = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:+";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).sum());
        }
    };

    public final Flt64Function sub = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:-";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1) {
                return toAtom(-toFlt64(args.get(0)));
            } else {
                return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a - b).orElse(0));
            }
        }
    };

    public final Flt64Function mul = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:*";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a * b).orElse(1));
        }
    };

    public final Flt64Function div = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:/";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a / b).orElse(1));
        }
    };

    public final Flt64Function mod = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:mod";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a % b).orElse(1));
        }
    };

    public final Flt64Function pow = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:**";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce(Math::pow).orElse(1));
        }
    };

    public final Flt64Function abs = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:abs";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::abs).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function ceil = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:ceil";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::ceil).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function floor = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:floor";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::floor).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function round = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:round";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::round).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function exp = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:exp";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::exp).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function ln = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:ln";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::log).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function log = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:log10";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::log10).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function log2 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:log2";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::log).map(x -> x / Math.log(2)).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function sqrt = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sqrt";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::sqrt).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function min = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:min";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).min().orElse(0));
        }
    };

    public final Flt64Function max = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:max";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).max().orElse(0));
        }
    };

    public final Flt64Function signum = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:signum";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> x < 0 ? -1 : x == 0 ? 0 : 1).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function sin = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sin";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::sin).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function cos = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:cos";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::cos).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function tan = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:tan";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::tan).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function asin = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:asin";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::asin).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function acos = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:acos";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::acos).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function atan = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:atan";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::atan).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public void registerFlt64(Environment env) {
        env.setPrimitive("flt64:+", new Atom(add));
        env.setPrimitive("flt64:-", new Atom(sub));
        env.setPrimitive("flt64:*", new Atom(mul));
        env.setPrimitive("flt64:/", new Atom(div));
        env.setPrimitive("flt64:mod", new Atom(mod));
        env.setPrimitive("flt64:**", new Atom(pow));
        env.setPrimitive("flt64:abs", new Atom(abs));
        env.setPrimitive("flt64:ceil", new Atom(ceil));
        env.setPrimitive("flt64:floor", new Atom(floor));
        env.setPrimitive("flt64:round", new Atom(round));
        env.setPrimitive("flt64:exp", new Atom(exp));
        env.setPrimitive("flt64:ln", new Atom(ln));
        env.setPrimitive("flt64:log2", new Atom(log2));
        env.setPrimitive("flt64:log10", new Atom(log));
        env.setPrimitive("flt64:sqrt", new Atom(sqrt));
        env.setPrimitive("flt64:min", new Atom(min));
        env.setPrimitive("flt64:max", new Atom(max));
        env.setPrimitive("flt64:signum", new Atom(signum));
        env.setPrimitive("flt64:sin", new Atom(sin));
        env.setPrimitive("flt64:cos", new Atom(cos));
        env.setPrimitive("flt64:tan", new Atom(tan));
        env.setPrimitive("flt64:asin", new Atom(asin));
        env.setPrimitive("flt64:acos", new Atom(acos));
        env.setPrimitive("flt64:atan", new Atom(atan));
        env.setPrimitive("flt64:e", toAtom(Math.E));
        env.setPrimitive("flt64:pi", toAtom(Math.PI));
        env.setPrimitive("flt64:euler-gamma", toAtom(0.57721566490153286060651209008240243104215933593992));
    }
}
