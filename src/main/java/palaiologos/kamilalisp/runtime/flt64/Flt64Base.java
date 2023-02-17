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
            assertArity(args, 1);
            double x = toFlt64(args.get(0));
            return toAtom(erf(x));
        }
    };
    public final Flt64Function erfc = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erfc";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            double x = toFlt64(args.get(0));
            return toAtom(erfc(x));
        }
    };
    public final Flt64Function erfcInverse = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erfc-inverse";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            double x = toFlt64(args.get(0));
            return toAtom(inverfc(x));
        }
    };
    public final Flt64Function erfInverse = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erf-inverse";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            double x = toFlt64(args.get(0));
            return toAtom(inverfc(1. - x));
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

    public static double lowerIncomplete(double a, double x) {
        return regularizedGammaP(a, x) * gamma(a);
    }

    public static double upperIncomplete(double a, double x) {
        return regularizedGammaQ(a, x) * gamma(a);
    }

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

    public void registerFlt64(Environment env) {
        // TODO:
        // dawson-f, Expint, Ei, log-integral, fresnel-s, fresnel-c, fresnel-f, fresnel-g,
        // Si, Co, Shi, Chi, bessel-j, bessel-y, bessel-i, bessel-k, hankel-h1, hankel-h2,
        // airy-ai, airy-bi, hypergeom-2f1, hypergeom-pfq, meijer-g, fox-h, hypergeom-1f1,
        // whittaker-m, whittaker-w, elliptic-k, elliptic-f, elliptic-e, elliptic-pi,
        // lerch-phi, dirchlet-beta, dirchlet-eta, dirchlet-lambda, barnesg, logbarnesg,
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

    public static class ZetaCalculation {
        private static final double[] zetBernCoefs = new double[]
                {
                        0.0,
                        0.083333333333333333333, -0.0013888888888888888889, 0.000033068783068783068783,
                        -8.2671957671957671958e-7, 2.0876756987868098979e-8, -5.2841901386874931848e-10,
                        1.3382536530684678833e-11, -3.3896802963225828668e-13, 8.5860620562778445641e-15,
                        -2.1748686985580618730e-16
                };

        private static double __riemann_zeta_sum(double s) {
            if (s < 1.0) {
                throw new IllegalArgumentException("Bad argument in zeta sum.");
            }

            final int max_iter = 10000;
            double zeta = 0.0;
            for (int k = 1; k < max_iter; ++k) {
                double term = Math.pow(k, -s);
                if (term < EPSILON) {
                    break;
                }
                zeta += term;
            }

            return zeta;
        }

        private static double __riemann_zeta_alt(double __s) {
            double __sgn = 1;
            double __zeta = 0;
            for (int __i = 1; __i < 10000000; ++__i) {
                double __term = __sgn / Math.pow(__i, __s);
                if (Math.abs(__term) < EPSILON)
                    break;
                __zeta += __term;
                __sgn *= -1;
            }
            __zeta /= 1 - Math.pow(2, 1 - __s);

            return __zeta;
        }

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
}
