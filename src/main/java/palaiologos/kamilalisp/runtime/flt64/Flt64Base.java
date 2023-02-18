package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class Flt64Base {
    private static final double EPSILON = Math.ulp(1.0d);
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
            if (args.size() == 1)
                return toAtom(Math.abs(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.ceil(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.floor(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.round(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.exp(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.log(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.log10(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.log(toFlt64(args.get(0))) / Math.log(2));
            else
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
            if (args.size() == 1)
                return toAtom(Math.sqrt(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.signum(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.sin(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.cos(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.tan(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.asin(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.acos(toFlt64(args.get(0))));
            else
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
            if (args.size() == 1)
                return toAtom(Math.atan(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::atan).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function sec = new Flt64Function() {
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
    public final Flt64Function csc = new Flt64Function() {
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
    public final Flt64Function cot = new Flt64Function() {
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
    public final Flt64Function asec = new Flt64Function() {
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
    public final Flt64Function acsc = new Flt64Function() {
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
    public final Flt64Function acot = new Flt64Function() {
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
    public final Flt64Function sinh = new Flt64Function() {
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
    public final Flt64Function cosh = new Flt64Function() {
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
    public final Flt64Function tanh = new Flt64Function() {
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
    public final Flt64Function sech = new Flt64Function() {
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
    public final Flt64Function csch = new Flt64Function() {
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
    public final Flt64Function coth = new Flt64Function() {
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
    public final Flt64Function asinh = new Flt64Function() {
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
    public final Flt64Function acosh = new Flt64Function() {
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
    public final Flt64Function atanh = new Flt64Function() {
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
    public final Flt64Function eq = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:=";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return new Atom(Flt64Base.toFlt64(args.get(0)) == Flt64Base.toFlt64(args.get(1)));
        }
    };
    public final Flt64Function ne = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:/=";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return new Atom(Flt64Base.toFlt64(args.get(0)) != Flt64Base.toFlt64(args.get(1)));
        }
    };
    public final Flt64Function lt = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:<";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return new Atom(Flt64Base.toFlt64(args.get(0)) < Flt64Base.toFlt64(args.get(1)));
        }
    };
    public final Flt64Function le = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:<=";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return new Atom(Flt64Base.toFlt64(args.get(0)) <= Flt64Base.toFlt64(args.get(1)));
        }
    };
    public final Flt64Function gt = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:>";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return new Atom(Flt64Base.toFlt64(args.get(0)) > Flt64Base.toFlt64(args.get(1)));
        }
    };
    public final Flt64Function ge = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:>=";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return new Atom(Flt64Base.toFlt64(args.get(0)) >= Flt64Base.toFlt64(args.get(1)));
        }
    };
    public final Flt64Function gamma = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:gamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(gamma(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::gamma).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function beta = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:beta";
        }

        private double betaImpl(double x, double y) {
            return gamma(x) * gamma(y) / gamma(x + y);
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(betaImpl(Flt64Base.toFlt64(args.get(0)), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public final Flt64Function digamma = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:digamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(digamma(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::digamma).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function trigamma = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:trigamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(trigamma(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::trigamma).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function loggamma = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:loggamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(loggamma(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::loggamma).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function zeta = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:zeta";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(ZetaCalculation.riemann_zeta(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(ZetaCalculation::riemann_zeta).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function hurwitz_zeta = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:hurwitz-zeta";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(ZetaCalculation.hurwitz_zeta(Flt64Base.toFlt64(args.get(0)), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public final Flt64Function polygamma = new Flt64Function() {
        private static double polygamma(double n, double x) {
            // Polygamma[n, x] = (-1)^(n+1) * Gamma[n + 1] * HurwitzZeta[n + 1, x]
            return Math.pow(-1, n + 1) * gamma(n + 1) * ZetaCalculation.hurwitz_zeta(n + 1, x);
        }

        @Override
        protected String name() {
            return "flt64:polygamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(polygamma(Flt64Base.toFlt64(args.get(0)), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public final Flt64Function pochhammer = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:pochhammer";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            double x = toFlt64(args.get(0));
            double n = toFlt64(args.get(1));
            return toAtom(gamma(x + n) / gamma(x));
        }
    };
    public final Flt64Function erf = new Flt64Function() {
        public static double erf(double x) {
            if (x > 26.0) {
                return 1.0;
            } else if (x < -5.5) {
                return -1.0;
            } else {
                double absx, c, p, q;
                absx = Math.abs(x);
                if (absx <= 0.5) {
                    c = x * x;
                    p = ((-0.356098437018154e-1 * c + 0.699638348861914e1) * c + 0.219792616182942e2) * c + 0.242667955230532e3;
                    q = ((c + 0.150827976304078e2) * c + 0.911649054045149e2) * c + 0.215058875869861e3;
                    return x * p / q;
                }
                if (x < 0.0) {
                    return -(1.0 - Math.exp(-x * x) * nonexperfc(absx));
                }
                return 1.0 - Math.exp(-x * x) * nonexperfc(absx);
            }
        }

        private static double nonexperfc(double x) {
            double absx, c, p, q;
            absx = Math.abs(x);
            if (absx <= 0.5) {
                return Math.exp(x * x) * erf(x);
            } else if (absx < 4.0) {
                c = absx;
                p = ((((((-0.136864857382717e-6 * c + 0.564195517478974e0) * c + 0.721175825088309e1) * c + 0.431622272220567e2) * c + 0.152989285046940e3) * c + 0.339320816734344e3) * c + 0.451918953711873e3) * c + 0.300459261020162e3;
                q = ((((((c + 0.127827273196294e2) * c + 0.770001529352295e2) * c + 0.277585444743988e3) * c + 0.638980264465631e3) * c + 0.931354094850610e3) * c + 0.790950925327898e3) * c + 0.300459260956983e3;
                return ((x > 0.0) ? p / q : Math.exp(x * x) * 2.0 - p / q);
            } else {
                c = 1.0 / x / x;
                p = (((0.223192459734185e-1 * c + 0.278661308609648e0) * c + 0.226956593539687e0) * c + 0.494730910623251e-1) * c + 0.299610707703542e-2;
                q = (((c + 0.198733201817135e1) * c + 0.105167510706793e1) * c + 0.191308926107830e0) * c + 0.106209230528468e-1;
                c = (c * (-p) / q + 0.564189583547756) / absx;
                return ((x > 0.0) ? c : Math.exp(x * x) * 2.0 - c);
            }
        }

        @Override
        protected String name() {
            return "flt64:erf";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(erf(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> erf(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function erfc = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erfc";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(erfc(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::erfc).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function erfcInverse = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erfc-inverse";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(inverfc(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> inverfc(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function erfInverse = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erf-inverse";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(inverfc(1. - Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> inverfc(1. - x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function upperIncompleteGamma = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:ui-gamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            double a = toFlt64(args.get(0));
            double x = toFlt64(args.get(1));
            return toAtom(upperIncomplete(a, x));
        }
    };
    public final Flt64Function lowerIncompleteGamma = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:li-gamma";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            double a = toFlt64(args.get(0));
            double x = toFlt64(args.get(1));
            return toAtom(lowerIncomplete(a, x));
        }
    };
    public final Flt64Function bessel0 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-j0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(BesselComputation.bessel0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(BesselComputation::bessel0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function bessel1 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-j1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(BesselComputation.bessel1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(BesselComputation::bessel1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function bessel = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-jn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return toAtom(BesselComputation.bessel(args.get(0).getInteger().intValueExact(), toFlt64(args.get(1))));
        }
    };
    public final Flt64Function besselderv = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-jn-derv";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return toAtom(BesselComputation.besselnDerivative(args.get(0).getInteger().intValueExact(), toFlt64(args.get(1))));
        }
    };
    public final Flt64Function airy = new Flt64Function() {
        public static double airy(double x) {
            int n, l;
            double s, t, u, v, uc, vc, k1, k2, c, xt, si, co, expxt;
            double sqrtx, wwl, pl, pl1, pl2, zzz, ai;
            double[] xtmp = new double[26];
            xtmp[1] = 1.4083081072180964e1;
            xtmp[2] = 1.0214885479197331e1;
            xtmp[3] = 7.4416018450450930;
            xtmp[4] = 5.3070943061781927;
            xtmp[5] = 3.6340135029132462;
            xtmp[6] = 2.3310652303052450;
            xtmp[7] = 1.3447970842609268;
            xtmp[8] = 6.4188858369567296e-1;
            xtmp[9] = 2.0100345998121046e-1;
            xtmp[10] = 8.0594359172052833e-3;
            xtmp[11] = 3.1542515762964787e-14;
            xtmp[12] = 6.6394210819584921e-11;
            xtmp[13] = 1.7583889061345669e-8;
            xtmp[14] = 1.3712392370435815e-6;
            xtmp[15] = 4.4350966639284350e-5;
            xtmp[16] = 7.1555010917718255e-4;
            xtmp[17] = 6.4889566103335381e-3;
            xtmp[18] = 3.6440415875773282e-2;
            xtmp[19] = 1.4399792418590999e-1;
            xtmp[20] = 8.1231141336261486e-1;
            xtmp[21] = 0.355028053887817;
            xtmp[22] = 0.258819403792807;
            xtmp[23] = 1.73205080756887729;
            xtmp[24] = 0.78539816339744831;
            xtmp[25] = 0.56418958354775629;
            if ((x >= -5.0) && (x <= 8.0)) {
                u = v = t = uc = vc = 1.0;
                s = 0.5;
                n = 3;
                zzz = x * x * x;
                while (Math.abs(u) + Math.abs(v) + Math.abs(s) + Math.abs(t) > 1.0e-18) {
                    u = u * zzz / (n * (n - 1));
                    v = v * zzz / (n * (n + 1));
                    s = s * zzz / (n * (n + 2));
                    t = t * zzz / (n * (n - 2));
                    uc += u;
                    vc += v;
                    n += 3;
                }
                if (x < 2.5) {
                    ai = xtmp[21] * uc - xtmp[22] * x * vc;
                    return ai;
                }
            }
            k1 = k2 = 0.0;
            sqrtx = Math.sqrt(Math.abs(x));
            xt = 0.666666666666667 * Math.abs(x) * sqrtx;
            c = xtmp[25] / Math.sqrt(sqrtx);
            if (x < 0.0) {
                co = Math.cos(xt - xtmp[24]);
                si = Math.sin(xt - xtmp[24]);
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl2 = pl * pl;
                    pl1 = 1.0 + pl2;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / pl1;
                }
                ai = c * (co * k1 + si * k2);
            } else {
                if (x < 9.0) {
                    expxt = Math.exp(xt);
                } else {
                    expxt = 1.0;
                }
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl1 = 1.0 + pl;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / (xt * pl1 * pl1);
                }
                ai = 0.5 * c * k1 / expxt;
                if (x >= 9.0) {
                    // Asymptotic behavior follows
                    expxt = Math.pow(x, 3. / 2.);
                    ai = 0.5 * Math.exp(-2.0 * expxt / 3.0) / Math.sqrt(Math.PI) / Math.pow(x, 0.25);
                }
            }
            return ai;
        }

        @Override
        protected String name() {
            return "flt64:airy-ai";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(airy(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> airy(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public final Flt64Function airyDerv = new Flt64Function() {
        public static double airyDerivative(double x) {
            int n, l;
            double s, t, u, v, sc, tc, k1, k2, k3, k4, c, xt, si, co, expxt;
            double sqrtx, wwl, pl, pl1, pl2, pl3, zzz, ai, aid;
            double[] xtmp = new double[26];
            xtmp[1] = 1.4083081072180964e1;
            xtmp[2] = 1.0214885479197331e1;
            xtmp[3] = 7.4416018450450930;
            xtmp[4] = 5.3070943061781927;
            xtmp[5] = 3.6340135029132462;
            xtmp[6] = 2.3310652303052450;
            xtmp[7] = 1.3447970842609268;
            xtmp[8] = 6.4188858369567296e-1;
            xtmp[9] = 2.0100345998121046e-1;
            xtmp[10] = 8.0594359172052833e-3;
            xtmp[11] = 3.1542515762964787e-14;
            xtmp[12] = 6.6394210819584921e-11;
            xtmp[13] = 1.7583889061345669e-8;
            xtmp[14] = 1.3712392370435815e-6;
            xtmp[15] = 4.4350966639284350e-5;
            xtmp[16] = 7.1555010917718255e-4;
            xtmp[17] = 6.4889566103335381e-3;
            xtmp[18] = 3.6440415875773282e-2;
            xtmp[19] = 1.4399792418590999e-1;
            xtmp[20] = 8.1231141336261486e-1;
            xtmp[21] = 0.355028053887817;
            xtmp[22] = 0.258819403792807;
            xtmp[23] = 1.73205080756887729;
            xtmp[24] = 0.78539816339744831;
            xtmp[25] = 0.56418958354775629;
            if ((x >= -5.0) && (x <= 8.0)) {
                u = v = t = tc = 1.0;
                s = sc = 0.5;
                n = 3;
                zzz = x * x * x;
                while (Math.abs(u) + Math.abs(v) + Math.abs(s) + Math.abs(t) > 1.0e-18) {
                    u = u * zzz / (n * (n - 1));
                    v = v * zzz / (n * (n + 1));
                    s = s * zzz / (n * (n + 2));
                    t = t * zzz / (n * (n - 2));
                    sc += s;
                    tc += t;
                    n += 3;
                }
                if (x < 2.5) {
                    return xtmp[21] * sc * x * x - xtmp[22] * tc;
                }
            }
            k1 = k2 = k3 = k4 = 0.0;
            sqrtx = Math.sqrt(Math.abs(x));
            xt = 0.666666666666667 * Math.abs(x) * sqrtx;
            c = xtmp[25] / Math.sqrt(sqrtx);
            if (x < 0.0) {
                x = -x;
                co = Math.cos(xt - xtmp[24]);
                si = Math.sin(xt - xtmp[24]);
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl2 = pl * pl;
                    pl1 = 1.0 + pl2;
                    pl3 = pl1 * pl1;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / pl1;
                    k3 += wwl * pl * (1.0 + pl * (2.0 / xt + pl)) / pl3;
                    k4 += wwl * (-1.0 - pl * (1.0 + pl * (xt - pl)) / xt) / pl3;
                }
                ai = c * (co * k1 + si * k2);
                aid = 0.25 * ai / x - c * sqrtx * (co * k3 + si * k4);
            } else {
                if (x < 9.0) {
                    expxt = Math.exp(xt);
                } else {
                    expxt = 1.0;
                }
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl1 = 1.0 + pl;
                    pl2 = 1.0 - pl;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / (xt * pl1 * pl1);
                    k3 += wwl / pl2;
                    k4 += wwl * pl / (xt * pl2 * pl2);
                }
                ai = 0.5 * c * k1 / expxt;
                aid = ai * (-0.25 / x - sqrtx) + 0.5 * c * sqrtx * k2 / expxt;
                if (x >= 9) {
                    // Asymptotic behavior follows
                    expxt = Math.pow(x, 3. / 2.);
                    ai = 0.5 * Math.exp(-2.0 * expxt / 3.0) / Math.sqrt(Math.PI) / Math.pow(x, 0.25);
                    aid = -ai * Math.pow(x, 0.5) - ai / x / 4.0;
                }
            }
            return aid;
        }

        @Override
        protected String name() {
            return "flt64:airy-ai-derv";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(airyDerivative(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> airyDerivative(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function Ei = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:Ei";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(ExpInt.expint(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(ExpInt::expint).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function bessely0 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-y0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(y0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::y0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function bessely1 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-y1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(y1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::y1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function bessely = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-yn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(yn(args.get(0).getInteger().intValueExact(), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public final Flt64Function besselk = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-kn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(BesselComputation.kn(args.get(0).getInteger().intValueExact(), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public final Flt64Function besseli0 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-i0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(BesselComputation.i0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(BesselComputation::i0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function besseli1 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-i1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(BesselComputation.i1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(BesselComputation::i1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function besselk0 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-k0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(BesselComputation.k0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(BesselComputation::k0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function besselk1 = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-k1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(BesselComputation.k1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(BesselComputation::k1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function fresnelSine = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:fresnel-S";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(FresnelCalculation.fresnelS(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(FresnelCalculation::fresnelS).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function fresnelCosine = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:fresnel-C";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(FresnelCalculation.fresnelC(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(FresnelCalculation::fresnelC).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    private static double toFlt64(Atom a) {
        return switch (a.getType()) {
            case INTEGER -> a.getInteger().doubleValue();
            case REAL -> a.getReal().doubleValue();
            case COMPLEX -> a.getComplex().re.doubleValue();
            default -> throw new IllegalArgumentException("Cannot convert " + a.getType() + " to flt64");
        };
    }

    public static Atom toAtom(double d) {
        return new Atom(BigDecimal.valueOf(d));
    }

    private static double gamma(double x) {
        /*
         * Input parameters:
         *       X   -   argument
         * Domain:
         *       0 < X < 171.6
         *    -170 < X < 0, X is not an integer.
         * Relative error:
         * arithmetic   domain     # trials      peak         rms
         * IEEE    -170,-33      20000       2.3e-15     3.3e-16
         * IEEE     -33,  33     20000       9.4e-16     2.2e-16
         * IEEE      33, 171.6   20000       2.3e-15     3.2e-16
         */
        double sgngam, q, z, y, p1, q1;
        int ip, p;
        double[] pp = {1.60119522476751861407E-4, 1.19135147006586384913E-3, 1.04213797561761569935E-2, 4.76367800457137231464E-2, 2.07448227648435975150E-1, 4.94214826801497100753E-1, 9.99999999999999996796E-1};
        double[] qq = {-2.31581873324120129819E-5, 5.39605580493303397842E-4, -4.45641913851797240494E-3, 1.18139785222060435552E-2, 3.58236398605498653373E-2, -2.34591795718243348568E-1, 7.14304917030273074085E-2, 1.00000000000000000320};
        sgngam = 1;
        q = Math.abs(x);
        if (q > 33.0) {
            if (x < 0.0) {
                p = (int) Math.floor(q);
                ip = Math.round(p);
                if (ip % 2 == 0) {
                    sgngam = -1;
                }
                z = q - p;
                if (z > 0.5) {
                    p = p + 1;
                    z = q - p;
                }
                z = q * Math.sin(Math.PI * z);
                z = Math.abs(z);
                z = Math.PI / (z * gammastirf(q));
            } else {
                z = gammastirf(x);
            }
            y = sgngam * z;
            return y;
        }
        z = 1;
        while (x >= 3) {
            x = x - 1;
            z = z * x;
        }
        while (x < 0) {
            if (x > -0.000000001) {
                y = z / ((1 + 0.5772156649015329 * x) * x);
                return y;
            }
            z = z / x;
            x = x + 1;
        }
        while (x < 2) {
            if (x < 0.000000001) {
                y = z / ((1 + 0.5772156649015329 * x) * x);
                return y;
            }
            z = z / x;
            x = x + 1.0;
        }
        if (x == 2) {
            y = z;
            return y;
        }
        x = x - 2.0;
        p1 = pp[0];
        for (int i = 1; i < 7; i++) {
            p1 = pp[i] + p1 * x;
        }
        q1 = qq[0];
        for (int i = 1; i < 8; i++) {
            q1 = qq[i] + q1 * x;
        }
        return z * p1 / q1;
    }

    private static double gammastirf(double x) {
        double p1, w, y, v;
        w = 1 / x;
        double[] pp = {7.87311395793093628397E-4, -2.29549961613378126380E-4, -2.68132617805781232825E-3, 3.47222221605458667310E-3, 8.33333333333482257126E-2};
        p1 = pp[0];
        for (int i = 1; i < 5; i++) {
            p1 = pp[i] + p1 * x;
        }
        w = 1 + w * p1;
        y = Math.exp(x);
        if (x > 143.01608) {
            v = Math.pow(x, 0.5 * x - 0.25);
            y = v * (v / y);
        } else {
            y = Math.pow(x, x - 0.5) / y;
        }
        return 2.50662827463100050242 * y * w;
    }

    private static double digamma(double x) {
        final double GAMMA = 0.577215664901532860606512090082;
        final double C_LIMIT = 49;
        final double S_LIMIT = 1e-5;
        final double F_M1_12 = -1d / 12;
        final double F_1_120 = 1d / 120;
        final double F_M1_252 = -1d / 252;

        if (!Double.isFinite(x)) {
            return x;
        }

        double digamma = 0;
        if (x < 0) {
            // Use reflection formula to fall back into positive values.
            digamma -= Math.PI / Math.tan(Math.PI * x);
            x = 1 - x;
        }

        if (x > 0 && x <= S_LIMIT) {
            // Use method 5 from Bernardo AS103, accurate to O(x).
            return digamma - GAMMA - 1 / x;
        }

        while (x < C_LIMIT) {
            digamma -= 1 / x;
            x += 1;
        }

        // Use method 4, accurate to O(1/x^8)
        final double inv = 1 / (x * x);
        //            1       1        1         1
        // log(x) -  --- - ------ + ------- - -------
        //           2 x   12 x^2   120 x^4   252 x^6
        digamma += Math.log(x) - 0.5 / x + inv * (F_M1_12 + inv * (F_1_120 + F_M1_252 * inv));

        return digamma;
    }

    private static double trigamma(double x) {
        final double C_LIMIT = 49;
        final double S_LIMIT = 1e-5;
        final double F_1_6 = 1d / 6;
        final double F_1_30 = 1d / 30;
        final double F_1_42 = 1d / 42;

        if (!Double.isFinite(x)) {
            return x;
        }

        if (x > 0 && x <= S_LIMIT) {
            return 1 / (x * x);
        }

        double trigamma = 0;
        while (x < C_LIMIT) {
            trigamma += 1 / (x * x);
            x += 1;
        }

        final double inv = 1 / (x * x);
        //  1    1      1       1       1
        //  - + ---- + ---- - ----- + -----
        //  x      2      3       5       7
        //      2 x    6 x    30 x    42 x
        trigamma += 1 / x + inv / 2 + inv / x * (F_1_6 - inv * (F_1_30 + F_1_42 * inv));

        return trigamma;
    }

    private static double loggamma(double xx) {
        double x, y, tmp, ser;

        final double[] cof = {76.18009172947146, -86.50532032941677,
                24.01409824083091, -1.231739572450155, 0.1208650973866179e-2,
                -0.5395239384953e-5};
        int j;
        y = x = xx;
        tmp = x + 5.5;
        tmp -= (x + 0.5) * Math.log(tmp);
        ser = 1.000000000190015;
        for (j = 0; j <= 5; j++)
            ser += cof[j] / ++y;

        return -tmp + Math.log(2.5066282746310005 * ser / x);
    }

    public static double erfc(double x) {
        final double t = 1.0 / (1.0 + 0.5 * Math.abs(x));
        final double ans = t
                * Math.exp(-x
                * x
                - 1.26551223
                + t
                * (1.00002368 + t
                * (0.37409196 + t
                * (0.09678418 + t
                * (-0.18628806 + t
                * (0.27886807 + t
                * (-1.13520398 + t
                * (1.48851587 + t
                * (-0.82215223 + t * 0.17087277)))))))));

        return x >= 0.0 ? ans : -ans;
    }

    public static double lowerIncomplete(double a, double x) {
        if (a == 0)
            return -ExpInt.expint(-x);
        return regularizedGammaP(a, x) * gamma(a);
    }

    public static double upperIncomplete(double a, double x) {
        return regularizedGammaQ(a, x) * gamma(a);
    }

    public static double regularizedGammaQ(double a, double x) {
        if (a <= 0.0)
            throw new IllegalArgumentException(
                    "Invalid arguments in routine gammq");
        return 1.0 - regularizedGammaP(a, x);
    }

    public static double regularizedGammaP(double a, double x) {
        if (a <= 0.0)
            throw new IllegalArgumentException(
                    "Invalid arguments in routine gammp");
        if (x < (a + 1.0)) { // Use the series representation.
            return gser(a, x);
        } else { // Use the continued fraction representation
            return 1.0 - gcf(a, x);
        }
    }

    private static double gser(double a, double x) {
        double gln = loggamma(a);
        if (x <= 0.0) {
            if (x < 0.0)
                throw new IllegalArgumentException("x < 0 in routine gser");
            return 0.0;
        } else {
            double ap = a;
            double del, sum;
            del = sum = 1.0 / a;
            for (int n = 1; n <= 100; n++) {
                ++ap;
                del *= x / ap;
                sum += del;
                if (Math.abs(del) < Math.abs(sum) * 3.0e-7) {
                    return sum * Math.exp(-x + a * Math.log(x) - gln);
                }
            }
            throw new IllegalArgumentException(
                    "a too large, ITMAX too small in routine gser");
        }
    }

    private static double gcf(double a, double x) {
        double an, del;
        int i;
        double b = x + 1.0 - a;
        // Set up for evaluating continued fraction
        // by modified Lentz’s method (§5.2) with b0 = 0.
        double c = 1.0 / Double.MIN_VALUE;
        double d = 1.0 / b;
        double h = d;
        for (i = 1; i <= 100; i++) { // Iterate to convergence.
            an = -i * (i - a);
            b += 2.0;
            d = an * d + b;
            if (Math.abs(d) < Double.MIN_VALUE)
                d = Double.MIN_VALUE;
            c = b + an / c;
            if (Math.abs(c) < Double.MIN_VALUE)
                c = Double.MIN_VALUE;
            d = 1.0 / d;
            del = d * c;
            h *= del;
            if (Math.abs(del - 1.0) < 3.0e-7)
                break;
        }
        if (i > 100)
            throw new IllegalArgumentException(
                    "a too large, ITMAX too small in gcf");
        double gln = loggamma(a);
        return Math.exp(-x + a * Math.log(x) - gln) * h;
    }

    static public double y0(double x) throws ArithmeticException {

        if (x < 8.0) {
            double y = x * x;

            double ans1 = -2957821389.0 + y * (7062834065.0 + y * (-512359803.6
                    + y * (10879881.29 + y * (-86327.92757 + y * 228.4622733))));
            double ans2 = 40076544269.0 + y * (745249964.8 + y * (7189466.438
                    + y * (47447.26470 + y * (226.1030244 + y))));

            return (ans1 / ans2) + 0.636619772 * BesselComputation.bessel0(x) * Math.log(x);
        } else {
            double z = 8.0 / x;
            double y = z * z;
            double xx = x - 0.785398164;

            double ans1 = 1.0 + y * (-0.1098628627e-2 + y * (0.2734510407e-4
                    + y * (-0.2073370639e-5 + y * 0.2093887211e-6)));
            double ans2 = -0.1562499995e-1 + y * (0.1430488765e-3
                    + y * (-0.6911147651e-5 + y * (0.7621095161e-6
                    + y * (-0.934945152e-7))));
            return Math.sqrt(0.636619772 / x) *
                    (Math.sin(xx) * ans1 + z * Math.cos(xx) * ans2);
        }
    }

    static public double y1(double x) throws ArithmeticException {

        if (x < 8.0) {
            double y = x * x;
            double ans1 = x * (-0.4900604943e13 + y * (0.1275274390e13
                    + y * (-0.5153438139e11 + y * (0.7349264551e9
                    + y * (-0.4237922726e7 + y * 0.8511937935e4)))));
            double ans2 = 0.2499580570e14 + y * (0.4244419664e12
                    + y * (0.3733650367e10 + y * (0.2245904002e8
                    + y * (0.1020426050e6 + y * (0.3549632885e3 + y)))));
            return (ans1 / ans2) + 0.636619772 * (BesselComputation.bessel1(x) * Math.log(x) - 1.0 / x);
        } else {
            double z = 8.0 / x;
            double y = z * z;
            double xx = x - 2.356194491;
            double ans1 = 1.0 + y * (0.183105e-2 + y * (-0.3516396496e-4
                    + y * (0.2457520174e-5 + y * (-0.240337019e-6))));
            double ans2 = 0.04687499995 + y * (-0.2002690873e-3
                    + y * (0.8449199096e-5 + y * (-0.88228987e-6
                    + y * 0.105787412e-6)));
            return Math.sqrt(0.636619772 / x) *
                    (Math.sin(xx) * ans1 + z * Math.cos(xx) * ans2);
        }
    }

    static public double yn(int n, double x) {
        double by, bym, byp, tox;

        if (n == 0) return y0(x);
        if (n == 1) return y1(x);

        tox = 2.0 / x;
        by = y1(x);
        bym = y0(x);
        for (int j = 1; j < n; j++) {
            byp = j * tox * by - bym;
            bym = by;
            by = byp;
        }
        return by;
    }

    double inverfc(double p) {
        double x, err, t, pp;
        if (p >= 2.0) return -100.;
        if (p <= 0.0) return 100.;
        pp = (p < 1.0) ? p : 2. - p;
        t = Math.sqrt(-2. * Math.log(pp / 2.));
        x = -0.70711 * ((2.30753 + t * 0.27061) / (1. + t * (0.99229 + t * 0.04481)) - t);
        for (int j = 0; j < 2; j++) {
            err = erfc(x) - pp;
            x += err / (1.12837916709551257 * Math.exp(-x * x) - x * err);
        }
        return (p < 1.0 ? x : -x);
    }

    public void registerFlt64(Environment env) {
        // TODO:
        // dawson-f, log-integral, fresnel-f, fresnel-g,
        // Si, Co, Shi, Chi, hankel-h1, hankel-h2, dilog (spence), polylog
        // airy-bi, hypergeom-2f1, hypergeom-pfq, meijer-g, fox-h, hypergeom-1f1,
        // whittaker-m, whittaker-w, elliptic-k, elliptic-f, elliptic-e, elliptic-pi,
        // lerch-phi, dirichlet-beta, dirichlet-eta, dirichlet-lambda, barnesg, logbarnesg,
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
        env.setPrimitive("flt64:sec", new Atom(sec));
        env.setPrimitive("flt64:csc", new Atom(csc));
        env.setPrimitive("flt64:cot", new Atom(cot));
        env.setPrimitive("flt64:asec", new Atom(asec));
        env.setPrimitive("flt64:acsc", new Atom(acsc));
        env.setPrimitive("flt64:acot", new Atom(acot));
        env.setPrimitive("flt64:sinh", new Atom(sinh));
        env.setPrimitive("flt64:cosh", new Atom(cosh));
        env.setPrimitive("flt64:tanh", new Atom(tanh));
        env.setPrimitive("flt64:asinh", new Atom(asinh));
        env.setPrimitive("flt64:acosh", new Atom(acosh));
        env.setPrimitive("flt64:atanh", new Atom(atanh));
        env.setPrimitive("flt64:sech", new Atom(sech));
        env.setPrimitive("flt64:csch", new Atom(csch));
        env.setPrimitive("flt64:coth", new Atom(coth));
        env.setPrimitive("flt64:gamma", new Atom(gamma));
        env.setPrimitive("flt64:digamma", new Atom(digamma));
        env.setPrimitive("flt64:trigamma", new Atom(trigamma));
        env.setPrimitive("flt64:beta", new Atom(beta));
        env.setPrimitive("flt64:zeta", new Atom(zeta));
        env.setPrimitive("flt64:hurwitz-zeta", new Atom(hurwitz_zeta));
        env.setPrimitive("flt64:polygamma", new Atom(polygamma));
        env.setPrimitive("flt64:pochhammer", new Atom(pochhammer));
        env.setPrimitive("flt64:erf", new Atom(erf));
        env.setPrimitive("flt64:erfc", new Atom(erfc));
        env.setPrimitive("flt64:erf-inverse", new Atom(erfInverse));
        env.setPrimitive("flt64:erfc-inverse", new Atom(erfcInverse));
        env.setPrimitive("flt64:ui-gamma", new Atom(upperIncompleteGamma));
        env.setPrimitive("flt64:li-gamma", new Atom(lowerIncompleteGamma));
        env.setPrimitive("flt64:log-gamma", new Atom(loggamma));
        env.setPrimitive("flt64:bessel-j0", new Atom(bessel0));
        env.setPrimitive("flt64:bessel-j1", new Atom(bessel1));
        env.setPrimitive("flt64:bessel-jn", new Atom(bessel));
        env.setPrimitive("flt64:bessel-jn-derv", new Atom(besselderv));
        env.setPrimitive("flt64:bessel-y0", new Atom(bessely0));
        env.setPrimitive("flt64:bessel-y1", new Atom(bessely1));
        env.setPrimitive("flt64:bessel-yn", new Atom(bessely));
        env.setPrimitive("flt64:bessel-i0", new Atom(besseli0));
        env.setPrimitive("flt64:bessel-i1", new Atom(besseli1));
        env.setPrimitive("flt64:bessel-k0", new Atom(besselk0));
        env.setPrimitive("flt64:bessel-k1", new Atom(besselk1));
        env.setPrimitive("flt64:bessel-kn", new Atom(besselk));
        env.setPrimitive("flt64:airy-ai", new Atom(airy));
        env.setPrimitive("flt64:airy-ai-derv", new Atom(airyDerv));
        env.setPrimitive("flt64:fresnel-S", new Atom(fresnelSine));
        env.setPrimitive("flt64:fresnel-C", new Atom(fresnelCosine));
        env.setPrimitive("flt64:Ei", new Atom(Ei));
        env.setPrimitive("flt64:=", new Atom(eq));
        env.setPrimitive("flt64:/=", new Atom(ne));
        env.setPrimitive("flt64:<", new Atom(lt));
        env.setPrimitive("flt64:<=", new Atom(le));
        env.setPrimitive("flt64:>", new Atom(gt));
        env.setPrimitive("flt64:>=", new Atom(ge));
        env.setPrimitive("flt64:e", toAtom(Math.E));
        env.setPrimitive("flt64:pi", toAtom(Math.PI));
        env.setPrimitive("flt64:euler-gamma", toAtom(0.57721566490153286060651209008240243104215933593992));
    }

    private abstract static class Flt64Function extends PrimitiveFunction implements Lambda {
    }

    public static class ExpInt {
        private static final double eulerGamma = 0.57721566490153286060651209008240243104215933593992;

        private static double __expint_E1_series(double __x) {
            double __term = 1.0;
            double __esum = 0.0;
            double __osum = 0.0;
            final int __max_iter = 1000;
            for (int __i = 1; __i < __max_iter; ++__i) {
                __term *= -__x / __i;
                if (Math.abs(__term) < EPSILON)
                    break;
                if (__term >= 0.0)
                    __esum += __term / __i;
                else
                    __osum += __term / __i;
            }
            return -__esum - __osum
                    - eulerGamma - Math.log(__x);
        }

        private static double __expint_E1_asymp(double __x) {
            double __term = 1;
            double __esum = 1;
            double __osum = 0;
            final int __max_iter = 1000;
            for (int __i = 1; __i < __max_iter; ++__i) {
                double __prev = __term;
                __term *= -__i / __x;
                if (Math.abs(__term) > Math.abs(__prev))
                    break;
                if (__term >= 0)
                    __esum += __term;
                else
                    __osum += __term;
            }
            return Math.exp(-__x) * (__esum + __osum) / __x;
        }

        private static double __expint_En_cont_frac(double __x) {
            final int __max_iter = 1000;
            double __b = __x + 1;
            double __c = 1 / Double.MIN_VALUE;
            double __d = 1 / __b;
            double __h = __d;
            for (int __i = 1; __i <= __max_iter; ++__i) {
                double __a = -__i * (__i);
                __b += 2;
                __d = 1 / (__a * __d + __b);
                __c = __b + __a / __c;
                final double __del = __c * __d;
                __h *= __del;
                if (Math.abs(__del - 1) < EPSILON) {
                    return __h * Math.exp(-__x);
                }
            }
            throw new RuntimeException("Continued fraction failed in __expint_En_cont_frac.");
        }

        private static double __expint_Ei_series(double __x) {
            double __term = 1;
            double __sum = 0;
            final int __max_iter = 1000;
            for (int __i = 1; __i < __max_iter; ++__i) {
                __term *= __x / __i;
                __sum += __term / __i;
                if (__term < EPSILON * __sum)
                    break;
            }
            return eulerGamma + __sum + Math.log(__x);
        }

        private static double __expint_Ei_asymp(double __x) {
            double __term = 1;
            double __sum = 1;
            final int __max_iter = 1000;
            for (int __i = 1; __i < __max_iter; ++__i) {
                double __prev = __term;
                __term *= __i / __x;
                if (__term < EPSILON)
                    break;
                if (__term >= __prev)
                    break;
                __sum += __term;
            }
            return Math.exp(__x) * __sum / __x;
        }

        private static double __expint_Ei(double __x) {
            if (__x < 0)
                return -__expint_E1(-__x);
            else if (__x < -Math.log(EPSILON))
                return __expint_Ei_series(__x);
            else
                return __expint_Ei_asymp(__x);
        }

        private static double __expint_E1(double __x) {
            if (__x < 0)
                return -__expint_Ei(-__x);
            else if (__x < 1)
                return __expint_E1_series(__x);
            else if (__x < 100)  //  TODO: Find a good asymptotic switch point.
                return __expint_En_cont_frac(__x);
            else
                return __expint_E1_asymp(__x);
        }

        public static double expint(double x) {
            if (Double.isNaN(x)) {
                return Double.NaN;
            } else {
                return __expint_Ei(x);
            }
        }
    }

    public static class FresnelCalculation {
        static final double sqrt_2pi = 2.506628274631000502415765284811045253006;

        private static double SChebyshev_Expansion_0_1(double x) {
            final double[] c = {
                    +2.560134650043040830997e-1, -1.993005146464943284549e-1,
                    +4.025503636721387266117e-2, -4.459600454502960250729e-3,
                    +6.447097305145147224459e-5, +7.544218493763717599380e-5,
                    -1.580422720690700333493e-5, +1.755845848573471891519e-6,
                    -9.289769688468301734718e-8, -5.624033192624251079833e-9,
                    +1.854740406702369495830e-9, -2.174644768724492443378e-10,
                    +1.392899828133395918767e-11, -6.989216003725983789869e-14,
                    -9.959396121060010838331e-14, +1.312085140393647257714e-14,
                    -9.240470383522792593305e-16, +2.472168944148817385152e-17,
                    +2.834615576069400293894e-18, -4.650983461314449088349e-19,
                    +3.544083040732391556797e-20
            };

            return chebvl((x - 0.5) / 0.5, c, c.length - 1);
        }

        private static double SChebyshev_Expansion_1_3(double x) {
            final double[] c = {
                    +3.470341566046115476477e-2, -3.855580521778624043304e-2,
                    +1.420604309383996764083e-2, -4.037349972538938202143e-3,
                    +9.292478174580997778194e-4, -1.742730601244797978044e-4,
                    +2.563352976720387343201e-5, -2.498437524746606551732e-6,
                    -1.334367201897140224779e-8, +7.436854728157752667212e-8,
                    -2.059620371321272169176e-8, +3.753674773239250330547e-9,
                    -5.052913010605479996432e-10, +4.580877371233042345794e-11,
                    -7.664740716178066564952e-13, -7.200170736686941995387e-13,
                    +1.812701686438975518372e-13, -2.799876487275995466163e-14,
                    +3.048940815174731772007e-15, -1.936754063718089166725e-16,
                    -7.653673328908379651914e-18, +4.534308864750374603371e-18,
                    -8.011054486030591219007e-19, +9.374587915222218230337e-20,
                    -7.144943099280650363024e-21, +1.105276695821552769144e-22,
                    +6.989334213887669628647e-23
            };

            return chebvl((x - 2.0), c, c.length - 1);
        }

        private static double SChebyshev_Expansion_3_5(double x) {
            final double[] c = {
                    +3.684922395955255848372e-3, -2.624595437764014386717e-3,
                    +6.329162500611499391493e-4, -1.258275676151483358569e-4,
                    +2.207375763252044217165e-5, -3.521929664607266176132e-6,
                    +5.186211398012883705616e-7, -7.095056569102400546407e-8,
                    +9.030550018646936241849e-9, -1.066057806832232908641e-9,
                    +1.157128073917012957550e-10, -1.133877461819345992066e-11,
                    +9.633572308791154852278e-13, -6.336675771012312827721e-14,
                    +1.634407356931822107368e-15, +3.944542177576016972249e-16,
                    -9.577486627424256130607e-17, +1.428772744117447206807e-17,
                    -1.715342656474756703926e-18, +1.753564314320837957805e-19,
                    -1.526125102356904908532e-20, +1.070275366865736879194e-21,
                    -4.783978662888842165071e-23
            };

            return chebvl((x - 4.0), c, c.length - 1);
        }

        private static double SChebyshev_Expansion_5_7(double x) {
            final double[] c = {
                    +1.000801217561417083840e-3, -4.915205279689293180607e-4,
                    +8.133163567827942356534e-5, -1.120758739236976144656e-5,
                    +1.384441872281356422699e-6, -1.586485067224130537823e-7,
                    +1.717840749804993618997e-8, -1.776373217323590289701e-9,
                    +1.765399783094380160549e-10, -1.692470022450343343158e-11,
                    +1.568238301528778401489e-12, -1.405356860742769958771e-13,
                    +1.217377701691787512346e-14, -1.017697418261094517680e-15,
                    +8.186068056719295045596e-17, -6.305153620995673221364e-18,
                    +4.614110100197028845266e-19, -3.165914620159266813849e-20,
                    +1.986716456911232767045e-21, -1.078418278174434671506e-22,
                    +4.255983404468350776788e-24
            };

            return chebvl((x - 6.0), c, c.length - 1);

        }

        private static double SAsymptotic_Series(double x) {
            double x2 = x * x;
            double x4 = -4.0 * x2 * x2;
            double xn = 1.0;
            double factorial = 1.0;
            double g = 0.0;
            final int asymptoticTerms = 35;
            double[] term = new double[asymptoticTerms + 1];
            double epsilon = EPSILON / 4.0;
            int j = 5;
            int i = 0;

            term[0] = 1.0;
            term[asymptoticTerms] = 0.0;
            for (i = 1; i < asymptoticTerms; i++) {
                factorial *= ((double) j * (double) (j - 2));
                xn *= x4;
                term[i] = factorial / xn;
                j += 4;
                if (Math.abs(term[i]) >= Math.abs(term[i - 1])) {
                    i--;
                    break;
                }
                if (Math.abs(term[i]) <= epsilon) break;
            }
            for (; i >= 0; i--) g += term[i];

            g /= (x * sqrt_2pi);
            return g / (x2 + x2);
        }

        public static double CChebyshev_Expansion_0_1(double x) {
            final double[] c = {
                    +1.025703371090289562388e-1, -2.569833023232301400495e-2,
                    +3.160592981728234288078e-3, -3.776110718882714758799e-4,
                    +4.325593433537248833341e-5, -4.668447489229591855730e-6,
                    +4.619254757356785108280e-7, -3.970436510433553795244e-8,
                    +2.535664754977344448598e-9, -2.108170964644819803367e-11,
                    -2.959172018518707683013e-11, +6.727219944906606516055e-12,
                    -1.062829587519902899001e-12, +1.402071724705287701110e-13,
                    -1.619154679722651005075e-14, +1.651319588396970446858e-15,
                    -1.461704569438083772889e-16, +1.053521559559583268504e-17,
                    -4.760946403462515858756e-19, -1.803784084922403924313e-20,
                    +7.873130866418738207547e-21
            };

            int degree = c.length - 1;

            return chebvl((x - 0.5) / 0.5, c, degree);
        }

        public static double CChebyshev_Expansion_1_3(double x) {
            final double[] c = {
                    +1.025703371090289562388e-1, -2.569833023232301400495e-2,
                    +3.160592981728234288078e-3, -3.776110718882714758799e-4,
                    +4.325593433537248833341e-5, -4.668447489229591855730e-6,
                    +4.619254757356785108280e-7, -3.970436510433553795244e-8,
                    +2.535664754977344448598e-9, -2.108170964644819803367e-11,
                    -2.959172018518707683013e-11, +6.727219944906606516055e-12,
                    -1.062829587519902899001e-12, +1.402071724705287701110e-13,
                    -1.619154679722651005075e-14, +1.651319588396970446858e-15,
                    -1.461704569438083772889e-16, +1.053521559559583268504e-17,
                    -4.760946403462515858756e-19, -1.803784084922403924313e-20,
                    +7.873130866418738207547e-21
            };

            int degree = c.length - 1;
            double midpoint = 4.0;

            return chebvl((x - midpoint), c, degree);
        }

        public static double CChebyshev_Expansion_3_5(double x) {
            final double[] c = {
                    +1.025703371090289562388e-1, -2.569833023232301400495e-2,
                    +3.160592981728234288078e-3, -3.776110718882714758799e-4,
                    +4.325593433537248833341e-5, -4.668447489229591855730e-6,
                    +4.619254757356785108280e-7, -3.970436510433553795244e-8,
                    +2.535664754977344448598e-9, -2.108170964644819803367e-11,
                    -2.959172018518707683013e-11, +6.727219944906606516055e-12,
                    -1.062829587519902899001e-12, +1.402071724705287701110e-13,
                    -1.619154679722651005075e-14, +1.651319588396970446858e-15,
                    -1.461704569438083772889e-16, +1.053521559559583268504e-17,
                    -4.760946403462515858756e-19, -1.803784084922403924313e-20,
                    +7.873130866418738207547e-21
            };

            int degree = c.length - 1;
            double midpoint = 4.0;

            return chebvl((x - midpoint), c, degree);
        }

        public static double CChebyshev_Expansion_5_7(double x) {
            final double[] c = {
                    +6.738667333400589274018e-2, -1.128146832637904868638e-2,
                    +9.408843234170404670278e-4, -7.800074103496165011747e-5,
                    +6.409101169623350885527e-6, -5.201350558247239981834e-7,
                    +4.151668914650221476906e-8, -3.242202015335530552721e-9,
                    +2.460339340900396789789e-10, -1.796823324763304661865e-11,
                    +1.244108496436438952425e-12, -7.950417122987063540635e-14,
                    +4.419142625999150971878e-15, -1.759082736751040110146e-16,
                    -1.307443936270786700760e-18, +1.362484141039320395814e-18,
                    -2.055236564763877250559e-19, +2.329142055084791308691e-20,
                    -2.282438671525884861970e-21
            };

            int degree = c.length - 1;
            double midpoint = 6.0;

            return chebvl((x - midpoint), c, degree);
        }

        private static double CAsymptotic_Series(double x) {
            double x2 = x * x;
            double x4 = -4.0 * x2 * x2;
            double xn = 1.0;
            double factorial = 1.0;
            double f = 0.0;
            double epsilon = EPSILON / 4.0;
            int j = 3;
            int i = 0;

            double[] term = new double[36];
            term[0] = 1.0;
            term[35] = 0.0;
            for (i = 1; i < 35; i++) {
                factorial *= ((double) j * (double) (j - 2));
                xn *= x4;
                term[i] = factorial / xn;
                j += 4;
                if (Math.abs(term[i]) >= Math.abs(term[i - 1])) {
                    i--;
                    break;
                }
                if (Math.abs(term[i]) <= epsilon) break;
            }

            for (; i >= 0; i--) f += term[i];

            return f / (x * sqrt_2pi);
        }

        private static double fresnelAuxiliaryCosineIntegral(double x) {
            if (x == 0.0) return 0.5;
            if (x <= 1.0) return CChebyshev_Expansion_0_1(x);
            if (x <= 3.0) return CChebyshev_Expansion_1_3(x);
            if (x <= 5.0) return CChebyshev_Expansion_3_5(x);
            if (x <= 7.0) return CChebyshev_Expansion_5_7(x);
            return CAsymptotic_Series(x);
        }

        private static double fresnelAuxiliarySineIntegral(double x) {
            if (x == 0.0) return 0.5;
            if (x <= 1.0) return SChebyshev_Expansion_0_1(x);
            if (x <= 3.0) return SChebyshev_Expansion_1_3(x);
            if (x <= 5.0) return SChebyshev_Expansion_3_5(x);
            if (x <= 7.0) return SChebyshev_Expansion_5_7(x);
            return SAsymptotic_Series(x);
        }

        public static double fresnelS(double x) {
            double f;
            double g;
            double x2;
            double s;

            if (Math.abs(x) < 0.5) return powerSeriesS(x);

            f = fresnelAuxiliaryCosineIntegral(Math.abs(x));
            g = fresnelAuxiliarySineIntegral(Math.abs(x));
            x2 = x * x;
            s = 0.5 - Math.cos(x2) * f - Math.sin(x2) * g;
            return (x < 0.0) ? -s : s;
        }

        public static double fresnelC(double x) {
            double f;
            double g;
            double x2;
            double c;

            if (Math.abs(x) < 0.5) return powerSeriesC(x);

            f = fresnelAuxiliaryCosineIntegral(Math.abs(x));
            g = fresnelAuxiliarySineIntegral(Math.abs(x));
            x2 = x * x;
            c = 0.5 + Math.sin(x2) * f - Math.cos(x2) * g;
            return (x < 0.0) ? -c : c;
        }

        private static double chebvl(double x, double[] a, int degree) {
            double yp2 = 0.0;
            double yp1 = 0.0;
            double y;
            double two_x = x + x;
            int k;

            if (degree < 0) return 0.0;

            for (k = degree; k >= 1; k--, yp2 = yp1, yp1 = y)
                y = two_x * yp1 - yp2 + a[k];

            return x * yp1 - yp2 + a[0];
        }

        private static double powerSeriesS(double x) {
            double x2 = x * x;
            double x3 = x * x2;
            double x4 = -x2 * x2;
            double xn = 1.0;
            double Sn = 1.0;
            double Sm1 = 0.0;
            double term;
            double factorial = 1.0;
            double sqrt_2_o_pi = 7.978845608028653558798921198687637369517e-1;
            int y = 0;

            if (x == 0.0) return 0.0;
            Sn /= 3.0;
            while (Math.abs(Sn - Sm1) > EPSILON * Math.abs(Sm1)) {
                Sm1 = Sn;
                y += 1;
                factorial *= y + y;
                factorial *= y + y + 1;
                xn *= x4;
                term = xn / factorial;
                term /= y + y + y + y + 3;
                Sn += term;
            }
            return x3 * sqrt_2_o_pi * Sn;
        }

        private static double powerSeriesC(double x) {
            double x2 = x * x;
            double x3 = x * x2;
            double x4 = -x2 * x2;
            double xn = 1.0;
            double Sn = 1.0;
            double Sm1 = 0.0;
            double term;
            double factorial = 1.0;
            double sqrt_2_o_pi = 7.978845608028653558798921198687637369517e-1;
            int y = 0;

            if (x == 0.0) return 0.0;
            while (Math.abs(Sn - Sm1) > Math.ulp(Sm1) * Math.abs(Sm1)) {
                Sm1 = Sn;
                y += 1;
                factorial *= y + y;
                factorial *= y + y - 1;
                xn *= x4;
                term = xn / factorial;
                term /= y + y + y + y + 1;
                Sn += term;
            }
            return x * sqrt_2_o_pi * Sn;
        }
    }

    public static class ZetaCalculation {
        private static final double[] zetBernCoefs = new double[]
                {
                        0.0,
                        0.083333333333333333333, -0.0013888888888888888889, 0.000033068783068783068783,
                        -8.2671957671957671958e-7, 2.0876756987868098979e-8, -5.2841901386874931848e-10,
                        1.3382536530684678833e-11, -3.3896802963225828668e-13, 8.5860620562778445641e-15,
                        -2.1748686985580618730e-16
                };

        private static double __riemann_zeta_glob(double __s) {
            double __zeta = 0;

            //  Max e exponent before overflow.
            final double __max_bincoeff = 308 * Math.log(10) - 1;

            //  This series works until the binomial coefficient blows up
            //  so use reflection.
            if (__s < 0) {
                {
                    __zeta = __riemann_zeta_glob(1 - __s);
                    __zeta *= Math.pow(2 * Math.PI, __s) * Math.sin(Math.PI / 2 * __s) * Math.exp(loggamma(1 - __s)) / Math.PI;
                    return __zeta;
                }
            }

            double __num = 0.5;
            final int __maxit = 10000;
            for (int __i = 0; __i < __maxit; ++__i) {
                boolean __punt = false;
                double __sgn = 1;
                double __term = 0;
                for (int __j = 0; __j <= __i; ++__j) {
                    double __bincoeff = loggamma(1 + __i) - loggamma(1 + __j) - loggamma(1 + __i - __j);
                    if (__bincoeff > __max_bincoeff) {
                        //  This only gets hit for x << 0.
                        __punt = true;
                        break;
                    }
                    __bincoeff = Math.exp(__bincoeff);
                    __term += __sgn * __bincoeff * Math.pow(1 + __j, -__s);
                    __sgn *= -1;
                }
                if (__punt)
                    break;
                __term *= __num;
                __zeta += __term;
                if (Math.abs(__term / __zeta) < EPSILON)
                    break;
                __num *= 0.5;
            }

            __zeta /= 1 - Math.pow(2, 1 - __s);

            return __zeta;
        }

        private static double __riemann_zeta_product(double __s) {
            final double[] __prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109};

            double __zeta = 1;
            for (double v : __prime) {
                double __fact = 1 - Math.pow(v, -__s);
                __zeta *= __fact;
                if (1 - __fact < EPSILON) {
                    break;
                }
            }

            __zeta = 1 / __zeta;

            return __zeta;
        }

        public static double riemann_zeta(double s) {
            if (Double.isNaN(s)) {
                return Double.NaN;
            } else if (s == 1) {
                return Double.POSITIVE_INFINITY;
            } else if (s < -19) {
                double zeta = __riemann_zeta_product(1 - s);
                zeta *= Math.pow(2 * Math.PI, s) * Math.sin(Math.PI / 2 * s) * Math.exp(loggamma(1 - s)) / Math.PI;
                return zeta;
            } else if (s < 20) {
                return __riemann_zeta_glob(s);
            } else {
                return __riemann_zeta_product(s);
            }
        }

        public static double hurwitz_zeta(double x, double a) {
            if (x == 0)
                return 0.5 - a;
            if (a <= 0)
                return Double.NaN;
            if (x == 1)
                return Double.NaN;
            if (a > 1e7 || (x < 0 && x >= -100 && a >= 1e3)) {
                return (1 / (x - 1) + 1 / (2 * a)) * Math.pow(a, 1 - x);
            }
            if (x < 0) {
                if (a <= 1) {
                    double s = 1 - x;
                    double sum = 0;
                    for (int n = 1; n <= 20; n++)
                        sum += Math.pow(n, -s) * Math.cos(Math.PI * 0.5 * s - 2 * n * Math.PI * a);
                    return Math.exp(Math.log(2) + loggamma(s) - s * Math.log(2 * Math.PI)) * sum;
                } else {
                    double m = Math.floor(a);
                    if (m == a)
                        m--;
                    double a_new = a - m;
                    double sum = 0;
                    for (int n = (int) (m - 1); n >= 0; n--) {
                        double t = Math.pow(n + a_new, -x);
                        sum += t;
                        if (t / sum < 1e-6)
                            break;
                    }

                    return hurwitz_zeta(x, a_new) - sum;
                }
            }

            double part1 = 0;
            double part2 = 0;
            final int n = 9;
            for (int k = 0; k <= n; k++) {
                part1 += 1 / Math.pow(a + k, x);
            }

            for (int k = 1; k < zetBernCoefs.length; k++) {
                part2 += zetBernCoefs[k] * Math.exp(-(k + x) * Math.log(a + n) + loggamma(-2 + 3 * k + x) - loggamma(-2 + 2 * k + x));
            }

            return part1 + Math.pow(a + n, 1 - x) / (x - 1) - 1. / (2 * Math.pow(a + n, x)) + part2;
        }
    }

    private static class BesselComputation {
        protected static final double[] A_i0 = {
                -4.41534164647933937950E-18,
                3.33079451882223809783E-17,
                -2.43127984654795469359E-16,
                1.71539128555513303061E-15,
                -1.16853328779934516808E-14,
                7.67618549860493561688E-14,
                -4.85644678311192946090E-13,
                2.95505266312963983461E-12,
                -1.72682629144155570723E-11,
                9.67580903537323691224E-11,
                -5.18979560163526290666E-10,
                2.65982372468238665035E-9,
                -1.30002500998624804212E-8,
                6.04699502254191894932E-8,
                -2.67079385394061173391E-7,
                1.11738753912010371815E-6,
                -4.41673835845875056359E-6,
                1.64484480707288970893E-5,
                -5.75419501008210370398E-5,
                1.88502885095841655729E-4,
                -5.76375574538582365885E-4,
                1.63947561694133579842E-3,
                -4.32430999505057594430E-3,
                1.05464603945949983183E-2,
                -2.37374148058994688156E-2,
                4.93052842396707084878E-2,
                -9.49010970480476444210E-2,
                1.71620901522208775349E-1,
                -3.04682672343198398683E-1,
                6.76795274409476084995E-1
        };
        protected static final double[] B_i0 = {
                -7.23318048787475395456E-18,
                -4.83050448594418207126E-18,
                4.46562142029675999901E-17,
                3.46122286769746109310E-17,
                -2.82762398051658348494E-16,
                -3.42548561967721913462E-16,
                1.77256013305652638360E-15,
                3.81168066935262242075E-15,
                -9.55484669882830764870E-15,
                -4.15056934728722208663E-14,
                1.54008621752140982691E-14,
                3.85277838274214270114E-13,
                7.18012445138366623367E-13,
                -1.79417853150680611778E-12,
                -1.32158118404477131188E-11,
                -3.14991652796324136454E-11,
                1.18891471078464383424E-11,
                4.94060238822496958910E-10,
                3.39623202570838634515E-9,
                2.26666899049817806459E-8,
                2.04891858946906374183E-7,
                2.89137052083475648297E-6,
                6.88975834691682398426E-5,
                3.36911647825569408990E-3,
                8.04490411014108831608E-1
        };
        protected static final double[] A_i1 = {
                2.77791411276104639959E-18,
                -2.11142121435816608115E-17,
                1.55363195773620046921E-16,
                -1.10559694773538630805E-15,
                7.60068429473540693410E-15,
                -5.04218550472791168711E-14,
                3.22379336594557470981E-13,
                -1.98397439776494371520E-12,
                1.17361862988909016308E-11,
                -6.66348972350202774223E-11,
                3.62559028155211703701E-10,
                -1.88724975172282928790E-9,
                9.38153738649577178388E-9,
                -4.44505912879632808065E-8,
                2.00329475355213526229E-7,
                -8.56872026469545474066E-7,
                3.47025130813767847674E-6,
                -1.32731636560394358279E-5,
                4.78156510755005422638E-5,
                -1.61760815825896745588E-4,
                5.12285956168575772895E-4,
                -1.51357245063125314899E-3,
                4.15642294431288815669E-3,
                -1.05640848946261981558E-2,
                2.47264490306265168283E-2,
                -5.29459812080949914269E-2,
                1.02643658689847095384E-1,
                -1.76416518357834055153E-1,
                2.52587186443633654823E-1
        };
        protected static final double[] B_i1 = {
                7.51729631084210481353E-18,
                4.41434832307170791151E-18,
                -4.65030536848935832153E-17,
                -3.20952592199342395980E-17,
                2.96262899764595013876E-16,
                3.30820231092092828324E-16,
                -1.88035477551078244854E-15,
                -3.81440307243700780478E-15,
                1.04202769841288027642E-14,
                4.27244001671195135429E-14,
                -2.10154184277266431302E-14,
                -4.08355111109219731823E-13,
                -7.19855177624590851209E-13,
                2.03562854414708950722E-12,
                1.41258074366137813316E-11,
                3.25260358301548823856E-11,
                -1.89749581235054123450E-11,
                -5.58974346219658380687E-10,
                -3.83538038596423702205E-9,
                -2.63146884688951950684E-8,
                -2.51223623787020892529E-7,
                -3.88256480887769039346E-6,
                -1.10588938762623716291E-4,
                -9.76109749136146840777E-3,
                7.78576235018280120474E-1
        };
        protected static final double[] A_k0 = {
                1.37446543561352307156E-16,
                4.25981614279661018399E-14,
                1.03496952576338420167E-11,
                1.90451637722020886025E-9,
                2.53479107902614945675E-7,
                2.28621210311945178607E-5,
                1.26461541144692592338E-3,
                3.59799365153615016266E-2,
                3.44289899924628486886E-1,
                -5.35327393233902768720E-1
        };
        protected static final double[] B_k0 = {
                5.30043377268626276149E-18,
                -1.64758043015242134646E-17,
                5.21039150503902756861E-17,
                -1.67823109680541210385E-16,
                5.51205597852431940784E-16,
                -1.84859337734377901440E-15,
                6.34007647740507060557E-15,
                -2.22751332699166985548E-14,
                8.03289077536357521100E-14,
                -2.98009692317273043925E-13,
                1.14034058820847496303E-12,
                -4.51459788337394416547E-12,
                1.85594911495471785253E-11,
                -7.95748924447710747776E-11,
                3.57739728140030116597E-10,
                -1.69753450938905987466E-9,
                8.57403401741422608519E-9,
                -4.66048989768794782956E-8,
                2.76681363944501510342E-7,
                -1.83175552271911948767E-6,
                1.39498137188764993662E-5,
                -1.28495495816278026384E-4,
                1.56988388573005337491E-3,
                -3.14481013119645005427E-2,
                2.44030308206595545468E0
        };
        protected static final double[] A_k1 = {
                -7.02386347938628759343E-18,
                -2.42744985051936593393E-15,
                -6.66690169419932900609E-13,
                -1.41148839263352776110E-10,
                -2.21338763073472585583E-8,
                -2.43340614156596823496E-6,
                -1.73028895751305206302E-4,
                -6.97572385963986435018E-3,
                -1.22611180822657148235E-1,
                -3.53155960776544875667E-1,
                1.52530022733894777053E0
        };
        protected static final double[] B_k1 = {
                -5.75674448366501715755E-18,
                1.79405087314755922667E-17,
                -5.68946255844285935196E-17,
                1.83809354436663880070E-16,
                -6.05704724837331885336E-16,
                2.03870316562433424052E-15,
                -7.01983709041831346144E-15,
                2.47715442448130437068E-14,
                -8.97670518232499435011E-14,
                3.34841966607842919884E-13,
                -1.28917396095102890680E-12,
                5.13963967348173025100E-12,
                -2.12996783842756842877E-11,
                9.21831518760500529508E-11,
                -4.19035475934189648750E-10,
                2.01504975519703286596E-9,
                -1.03457624656780970260E-8,
                5.74108412545004946722E-8,
                -3.50196060308781257119E-7,
                2.40648494783721712015E-6,
                -1.93619797416608296024E-5,
                1.95215518471351631108E-4,
                -2.85781685962277938680E-3,
                1.03923736576817238437E-1,
                2.72062619048444266945E0
        };

        private static double besseln(int n, double x) {
            int sg, k;
            double y, tmp, pk, xk, pkm1, r, pkm2;
            if (n < 0) {
                n = -n;
                if (n % 2 == 0) {
                    sg = 1;
                } else {
                    sg = -1;
                }
            } else {
                sg = 1;
            }
            if (x < 0) {
                if (n % 2 != 0) {
                    sg = -sg;
                }
                x = -x;
            }
            if (n == 0) {
                y = sg * bessel0(x);
                return y;
            }
            if (n == 1) {
                y = sg * bessel1(x);
                return y;
            }
            if (n == 2) {
                if (x == 0) {
                    y = 0;
                } else {
                    y = sg * (2.0 * bessel1(x) / x - bessel0(x));
                }
                return y;
            }
            if (x < 1.e-12) {
                y = 0;
                return y;
            }
            k = 53;
            pk = 2 * (n + k);
            tmp = pk;
            xk = x * x;
            while (k != 0) {
                pk = pk - 2.0;
                tmp = pk - xk / tmp;
                k = k - 1;
            }
            tmp = x / tmp;
            pk = 1.0;
            pkm1 = 1.0 / tmp;
            k = n - 1;
            r = 2 * k;
            while (k != 0) {
                pkm2 = (pkm1 * r - pk * x) / x;
                pk = pkm1;
                pkm1 = pkm2;
                r = r - 2.0;
                k = k - 1;
            }
            if (Math.abs(pk) > Math.abs(pkm1)) {
                tmp = bessel1(x) / pk;
            } else {
                tmp = bessel0(x) / pkm1;
            }
            return sg * tmp;
        }

        public static double besselnDerivative(int n, double x) {
            int m, qm, qp, nm, np;
            double bjn, bjnm, bjnp;
            m = n;
            if (n == 0) {
                bjn = besseln(1, x);
                return -bjn;
            }
            qm = 1;
            qp = 1;
            nm = m - 1;
            np = m + 1;
            if (m < 0) {
                if (nm < 0) {
                    nm = -nm;
                    qm = -1;
                }
                if (np < 0) {
                    np = -np;
                    qp = -1;
                }
            }
            bjnm = besseln(nm, x);
            bjnp = besseln(np, x);
            bjnm = Math.pow(qm, nm) * bjnm;
            bjnp = Math.pow(qp, np) * bjnp;
            return (bjnm - bjnp) / 2.;
        }

        public static double bessel0(double x) {
            double nn, pzero, qzero, xsq, p1, q1, y;
            double[] zz;
            double[] p = {26857.86856980014981415848441, -40504123.71833132706360663322, 25071582855.36881945555156435, -8085222034853.793871199468171, 1434354939140344.111664316553, -136762035308817138.6865416609, 6382059341072356562.289432465, -117915762910761053603.8440800, 493378725179413356181.6813446};
            double[] q = {1.0, 1363.063652328970604442810507, 1114636.098462985378182402543, 669998767.2982239671814028660, 312304311494.1213172572469442, 112775673967979.8507056031594, 30246356167094626.98627330784, 5428918384092285160.200195092, 493378725179413356211.3278438};
            if (x < 0) {
                x = -x;
            }
            if (x > 8.0) {
                zz = besselasympt0(x);
                pzero = zz[0];
                qzero = zz[1];
                nn = x - Math.PI / 4;
                y = Math.sqrt(2 / Math.PI / x) * (pzero * Math.cos(nn) - qzero * Math.sin(nn));
                return y;
            }
            xsq = x * x;
            p1 = p[0];
            for (int i = 1; i < 9; i++) {
                p1 = p[i] + p1 * xsq;
            }
            q1 = q[0];
            for (int i = 1; i < 9; i++) {
                q1 = q[i] + q1 * xsq;
            }
            return p1 / q1;
        }

        public static double bessel1(double x) {
            double s, pzero, qzero, nn, p1, q1, y, xsq;
            double[] zz;
            double[] p = {2701.122710892323414856790990, -4695753.530642995859767162166, 3413234182.301700539091292655, -1322983480332.126453125473247, 290879526383477.5409737601689, -35888175699101060.50743641413, 2316433580634002297.931815435, -66721065689249162980.20941484, 581199354001606143928.050809};
            double[] q = {1.0, 1606.931573481487801970916749, 1501793.594998585505921097578, 1013863514.358673989967045588, 524371026216.7649715406728642, 208166122130760.7351240184229, 60920613989175217.46105196863, 11857707121903209998.37113348, 1162398708003212287858.529400};
            s = Math.signum(x);
            if (x < 0) {
                x = -x;
            }
            if (x > 8.0) {
                zz = besselasympt1(x);
                pzero = zz[0];
                qzero = zz[1];
                nn = x - 3 * Math.PI / 4;
                y = Math.sqrt(2 / Math.PI / x) * (pzero * Math.cos(nn) - qzero * Math.sin(nn));
                if (s < 0) {
                    y = -y;
                }
                return y;
            }
            xsq = x * x;
            p1 = p[0];
            for (int i = 1; i < 9; i++) {
                p1 = p[i] + p1 * xsq;
            }
            q1 = q[0];
            for (int i = 1; i < 9; i++) {
                q1 = q[i] + q1 * xsq;
            }
            return s * x * p1 / q1;
        }

        private static double[] besselasympt0(double x) {
            double xsq, p2, q2, p3, q3, pzero, qzero;
            double[] zz = new double[2];
            double[] p = {0.0, 2485.271928957404011288128951, 153982.6532623911470917825993, 2016135.283049983642487182349, 8413041.456550439208464315611, 12332384.76817638145232406055, 5393485.083869438325262122897};
            double[] q = {1.0, 2615.700736920839685159081813, 156001.7276940030940592769933, 2025066.801570134013891035236, 8426449.050629797331554404810, 12338310.22786324960844856182, 5393485.083869438325560444960};
            double[] pp = {0.0, -4.887199395841261531199129300, -226.2630641933704113967255053, -2365.956170779108192723612816, -8239.066313485606568803548860, -10381.41698748464093880530341, -3984.617357595222463506790588};
            double[] qq = {1.0, 408.7714673983499223402830260, 15704.89191515395519392882766, 156021.3206679291652539287109, 533291.3634216897168722255057, 666745.4239319826986004038103, 255015.5108860942382983170882};
            xsq = 64.0 / x / x;
            p2 = p[0];
            for (int i = 1; i < 7; i++) {
                p2 = p[i] + p2 * xsq;
            }
            q2 = q[0];
            for (int i = 1; i < 7; i++) {
                q2 = q[i] + q2 * xsq;
            }
            p3 = pp[0];
            for (int i = 1; i < 7; i++) {
                p3 = pp[i] + p3 * xsq;
            }
            q3 = qq[0];
            for (int i = 1; i < 7; i++) {
                q3 = qq[i] + q3 * xsq;
            }
            pzero = p2 / q2;
            qzero = 8 * p3 / q3 / x;
            zz[0] = pzero;
            zz[1] = qzero;
            return zz;
        }

        private static double[] besselasympt1(double x) {
            double xsq, p2, q2, p3, q3, pzero, qzero;
            double[] zz = new double[2];
            double[] p = {-1611.616644324610116477412898, -109824.0554345934672737413139, -1523529.351181137383255105722, -6603373.248364939109255245434, -9942246.505077641195658377899, -4435757.816794127857114720794};
            double[] q = {1.0, -1455.009440190496182453565068, -107263.8599110382011903063867, -1511809.506634160881644546358, -6585339.479723087072826915069, -9934124.389934585658967556309, -4435757.816794127856828016962};
            double[] pp = {35.26513384663603218592175580, 1706.375429020768002061283546, 18494.26287322386679652009819, 66178.83658127083517939992166, 85145.16067533570196555001171, 33220.91340985722351859704442};
            double[] qq = {1.0, 863.8367769604990967475517183, 37890.22974577220264142952256, 400294.4358226697511708610813, 1419460.669603720892855755253, 1819458.042243997298924553839, 708712.8194102874357377502472};
            xsq = 64.0 / x / x;
            p2 = p[0];
            for (int i = 1; i < 6; i++) {
                p2 = p[i] + p2 * xsq;
            }
            q2 = q[0];
            for (int i = 1; i < 7; i++) {
                q2 = q[i] + q2 * xsq;
            }
            p3 = pp[0];
            for (int i = 1; i < 6; i++) {
                p3 = pp[i] + p3 * xsq;
            }
            q3 = qq[0];
            for (int i = 1; i < 7; i++) {
                q3 = qq[i] + q3 * xsq;
            }
            pzero = p2 / q2;
            qzero = 8 * p3 / q3 / x;
            zz[0] = pzero;
            zz[1] = qzero;
            return zz;
        }

        public static double bessel(int n, double x) {
            if (n == 0)
                return bessel0(x);
            else if (n == 1)
                return bessel1(x);
            else
                return besseln(n, x);
        }

        // BesselK
        private static double chbevl(double x, double[] coef, int N) {
            double b0, b1, b2;

            int p = 0;
            int i;

            b0 = coef[p++];
            b1 = 0.0;
            i = N - 1;

            do {
                b2 = b1;
                b1 = b0;
                b0 = x * b1 - b2 + coef[p++];
            } while (--i > 0);

            return (0.5 * (b0 - b2));
        }

        static public double i0(double x) {
            double y;
            if (x < 0) x = -x;
            if (x <= 8.0) {
                y = (x / 2.0) - 2.0;
                return (Math.exp(x) * chbevl(y, A_i0, 30));
            }

            return (Math.exp(x) * chbevl(32.0 / x - 2.0, B_i0, 25) / Math.sqrt(x));
        }

        static public double i1(double x) {
            double y, z;

            z = Math.abs(x);
            if (z <= 8.0) {
                y = (z / 2.0) - 2.0;
                z = chbevl(y, A_i1, 29) * z * Math.exp(z);
            } else {
                z = Math.exp(z) * chbevl(32.0 / z - 2.0, B_i1, 25) / Math.sqrt(z);
            }
            if (x < 0.0)
                z = -z;
            return (z);
        }

        static public double k0(double x) {
            double y, z;

            if (x <= 0.0) throw new ArithmeticException();
            if (x <= 2.0) {
                y = x * x - 2.0;
                y = chbevl(y, A_k0, 10) - Math.log(0.5 * x) * i0(x);
                return (y);
            }

            z = 8.0 / x - 2.0;
            y = Math.exp(-x) * chbevl(z, B_k0, 25) / Math.sqrt(x);
            return (y);
        }

        static public double k1(double x) {
            double y, z;

            z = 0.5 * x;
            if (z <= 0.0) throw new ArithmeticException();
            if (x <= 2.0) {
                y = x * x - 2.0;
                y = Math.log(z) * i1(x) + chbevl(y, A_k1, 11) / x;
                return (y);
            }

            return (Math.exp(-x) * chbevl(8.0 / x - 2.0, B_k1, 25) / Math.sqrt(x));
        }

        static public double kn(int nn, double x) {
            final double EUL = 5.772156649015328606065e-1;
            final double MAXNUM = Double.MAX_VALUE;
            final int MAXFAC = 31;

            double k, kf, nk1f, nkf, zn, t, s, z0, z;
            double ans, fn, pn, pk, zmn, tlg, tox;
            int i, n;

            if (nn < 0)
                n = -nn;
            else
                n = nn;

            if (n > MAXFAC) throw new ArithmeticException("Overflow");
            if (x <= 0.0) throw new IllegalArgumentException();

            if (x <= 9.55) {
                ans = 0.0;
                z0 = 0.25 * x * x;
                fn = 1.0;
                pn = 0.0;
                zmn = 1.0;
                tox = 2.0 / x;

                if (n > 0) {
                    pn = -EUL;
                    k = 1.0;
                    for (i = 1; i < n; i++) {
                        pn += 1.0 / k;
                        k += 1.0;
                        fn *= k;
                    }

                    zmn = tox;

                    if (n == 1) {
                        ans = 1.0 / x;
                    } else {
                        nk1f = fn / n;
                        kf = 1.0;
                        s = nk1f;
                        z = -z0;
                        zn = 1.0;
                        for (i = 1; i < n; i++) {
                            nk1f = nk1f / (n - i);
                            kf = kf * i;
                            zn *= z;
                            t = nk1f * zn / kf;
                            s += t;
                            if ((MAXNUM - Math.abs(t)) < Math.abs(s)) throw new ArithmeticException("Overflow");
                            if ((tox > 1.0) && ((MAXNUM / tox) < zmn)) throw new ArithmeticException("Overflow");
                            zmn *= tox;
                        }
                        s *= 0.5;
                        t = Math.abs(s);
                        if ((zmn > 1.0) && ((MAXNUM / zmn) < t)) throw new ArithmeticException("Overflow");
                        if ((t > 1.0) && ((MAXNUM / t) < zmn)) throw new ArithmeticException("Overflow");
                        ans = s * zmn;
                    }
                }


                tlg = 2.0 * Math.log(0.5 * x);
                pk = -EUL;
                if (n == 0) {
                    pn = pk;
                    t = 1.0;
                } else {
                    pn = pn + 1.0 / n;
                    t = 1.0 / fn;
                }
                s = (pk + pn - tlg) * t;
                k = 1.0;
                do {
                    t *= z0 / (k * (k + n));
                    pk += 1.0 / k;
                    pn += 1.0 / (k + n);
                    s += (pk + pn - tlg) * t;
                    k += 1.0;
                }
                while (Math.abs(t / s) > 1.11022302462515654042E-16);

                s = 0.5 * s / zmn;
                if ((n & 1) > 0)
                    s = -s;
                ans += s;

                return (ans);
            }

            /* Asymptotic expansion for Kn(x) */
            /* Converges to 1.4e-17 for x > 18.4 */
            if (x > 7.09782712893383996732E2) throw new ArithmeticException("Underflow");
            k = n;
            pn = 4.0 * k * k;
            pk = 1.0;
            z0 = 8.0 * x;
            fn = 1.0;
            t = 1.0;
            s = t;
            nkf = MAXNUM;
            i = 0;
            do {
                z = pn - pk * pk;
                t = t * z / (fn * z0);
                nk1f = Math.abs(t);
                if ((i >= n) && (nk1f > nkf)) {
                    ans = Math.exp(-x) * Math.sqrt(Math.PI / (2.0 * x)) * s;
                    return (ans);
                }
                nkf = nk1f;
                s += t;
                fn += 1.0;
                pk += 2.0;
                i += 1;
            } while (Math.abs(t / s) > 1.11022302462515654042E-16);


            ans = Math.exp(-x) * Math.sqrt(Math.PI / (2.0 * x)) * s;
            return (ans);
        }
    }
}
