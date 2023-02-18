package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class Flt64Base {
    public static final double EPSILON = Math.ulp(1.0d);
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
            return toAtom(Flt64Gamma.gamma(x + n) / Flt64Gamma.gamma(x));
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

    static double toFlt64(Atom a) {
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
        env.setPrimitive("flt64:gamma", new Atom(Flt64Gamma.fGamma));
        env.setPrimitive("flt64:digamma", new Atom(Flt64Gamma.fDigamma));
        env.setPrimitive("flt64:trigamma", new Atom(Flt64Gamma.fTrigamma));
        env.setPrimitive("flt64:beta", new Atom(Flt64Gamma.fBeta));
        env.setPrimitive("flt64:zeta", new Atom(Flt64Zeta.fRiemannZeta));
        env.setPrimitive("flt64:hurwitz-zeta", new Atom(Flt64Zeta.fHurwitzZeta));
        env.setPrimitive("flt64:polygamma", new Atom(Flt64Gamma.fPolygamma));
        env.setPrimitive("flt64:pochhammer", new Atom(pochhammer));
        env.setPrimitive("flt64:erf", new Atom(erf));
        env.setPrimitive("flt64:erfc", new Atom(erfc));
        env.setPrimitive("flt64:erf-inverse", new Atom(erfInverse));
        env.setPrimitive("flt64:erfc-inverse", new Atom(erfcInverse));
        env.setPrimitive("flt64:ui-gamma", new Atom(Flt64Gamma.fUpperIncompleteGamma));
        env.setPrimitive("flt64:li-gamma", new Atom(Flt64Gamma.fLowerIncompleteGamma));
        env.setPrimitive("flt64:log-gamma", new Atom(Flt64Gamma.fLogGamma));
        env.setPrimitive("flt64:bessel-j0", new Atom(Flt64Bessel.fBessel0));
        env.setPrimitive("flt64:bessel-j1", new Atom(Flt64Bessel.fBessel1));
        env.setPrimitive("flt64:bessel-jn", new Atom(Flt64Bessel.fBessel));
        env.setPrimitive("flt64:bessel-jn-derv", new Atom(Flt64Bessel.fBesselderv));
        env.setPrimitive("flt64:bessel-y0", new Atom(Flt64Bessel.fBessely0));
        env.setPrimitive("flt64:bessel-y1", new Atom(Flt64Bessel.fBessely1));
        env.setPrimitive("flt64:bessel-yn", new Atom(Flt64Bessel.fBessely));
        env.setPrimitive("flt64:bessel-i0", new Atom(Flt64Bessel.fBesseli0));
        env.setPrimitive("flt64:bessel-i1", new Atom(Flt64Bessel.fBesseli1));
        env.setPrimitive("flt64:bessel-k0", new Atom(Flt64Bessel.fBesselk0));
        env.setPrimitive("flt64:bessel-k1", new Atom(Flt64Bessel.fBesselk1));
        env.setPrimitive("flt64:bessel-kn", new Atom(Flt64Bessel.fBesselk));
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

    abstract static class Flt64Function extends PrimitiveFunction implements Lambda {
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
            final int asymptoticTerms = 50;
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
            final int asymptoticTerms = 50;
            int j = 3;
            int i = 0;

            double[] term = new double[asymptoticTerms + 1];
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
}
