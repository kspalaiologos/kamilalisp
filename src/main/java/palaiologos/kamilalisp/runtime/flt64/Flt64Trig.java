package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Flt64Base.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Flt64Base.toFlt64;

public class Flt64Trig {
    public static final Flt64Base.Flt64Function sin = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sin";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.sin(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::sin).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function cos = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:cos";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.cos(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::cos).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function tan = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:tan";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.tan(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::tan).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function asin = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:asin";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.asin(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::asin).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function acos = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:acos";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.acos(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::acos).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function atan = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:atan";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.atan(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::atan).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function sec = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sec";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(1 / Math.cos(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> 1 / Math.cos(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function csc = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:csc";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(1 / Math.sin(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> 1 / Math.sin(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function cot = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:cot";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(1 / Math.tan(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> 1 / Math.tan(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function asec = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:asec";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.acos(1 / toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> Math.acos(1 / x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function acsc = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:acsc";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.asin(1 / toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> Math.asin(1 / x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function acot = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:acot";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.atan(1 / toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> Math.atan(1 / x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function sinh = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sinh";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.sinh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::sinh).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function cosh = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:cosh";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.cosh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::cosh).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function tanh = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:tanh";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.tanh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::tanh).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function sech = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sech";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(1 / Math.cosh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> 1 / Math.cosh(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function csch = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:csch";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(1 / Math.sinh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> 1 / Math.sinh(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function coth = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:coth";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(1 / Math.tanh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> 1 / Math.tanh(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function asinh = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:asinh";
        }

        public double asinh(double a) {
            final double sign;

            if (Double.doubleToRawLongBits(a) < 0) {
                a = Math.abs(a);
                sign = -1.0d;
            } else {
                sign = 1.0d;
            }

            return sign * Math.log(Math.sqrt(a * a + 1.0d) + a);
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(asinh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(this::asinh).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function acosh = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:acosh";
        }

        public double acosh(double x) {
            double ans;

            if (Double.isNaN(x) || (x < 1)) {
                ans = Double.NaN;
            } else if (x < 94906265.62) {
                ans = safeLog(x + Math.sqrt(x * x - 1.0D));
            } else {
                ans = 0.69314718055994530941723212145818D + safeLog(x);
            }

            return ans;
        }

        public double safeLog(double x) {
            if (x == 0.0D) {
                return 0.0D;
            } else {
                return Math.log(x);
            }
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(acosh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(this::acosh).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function atanh = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:atanh";
        }

        public double atanh(double a) {
            final double mult;

            if (Double.doubleToRawLongBits(a) < 0) {
                a = Math.abs(a);
                mult = -0.5d;
            } else {
                mult = 0.5d;
            }
            return mult * Math.log((1.0d + a) / (1.0d - a));
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(atanh(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(this::atanh).mapToObj(Flt64Base::toAtom).toList());
        }
    };
}
