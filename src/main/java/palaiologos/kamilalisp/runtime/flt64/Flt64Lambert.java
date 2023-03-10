package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

public class Flt64Lambert {
    public static final Flt64Base.Flt64Function lambert0 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:lambert-w0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(lambert0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Lambert::lambert0).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public static final Flt64Base.Flt64Function lambertn1 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:lambert-w-1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(lambertn1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Lambert::lambertn1).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    private static final double[] c = { -1.0, 2.331643981597124203363536062168,
            -1.812187885639363490240191647568, 1.936631114492359755363277457668,
            -2.353551201881614516821543561516, 3.066858901050631912893148922704,
            -4.175335600258177138854984177460, 5.858023729874774148815053846119,
            -8.401032217523977370984161688514, 12.250753501314460424,
            -18.100697012472442755, 27.029044799010561650 };

    private static double halley_iteration(double x, double w_initial, int max_iters) {
        double w = w_initial;
        int i;

        for (i = 0; i < max_iters; i++) {
            double tol;
            final double e = Math.exp(w);
            final double p = w + 1.0;
            double t = w * e - x;

            if (w > 0) {
                t = (t / p) / e;
            } else {
                t /= e * p - 0.5 * (p + 1.0) * t / p;
            }

            w -= t;

            tol = 10 * Flt64Base.EPSILON
                    * Math.max(Math.abs(w), 1.0 / (Math.abs(p) * e));

            if (Math.abs(t) < tol) {
                return w;
            }
        }

        return Double.NaN;
    }

    private static double series_eval(double r) {
        final double t_8 = c[8] + r * (c[9] + r * (c[10] + r * c[11]));
        final double t_5 = c[5] + r * (c[6] + r * (c[7] + r * t_8));
        final double t_1 = c[1]
                + r * (c[2] + r * (c[3] + r * (c[4] + r * t_5)));
        return c[0] + r * t_1;
    }

    static public double lambert0(double x) {
        if (x < -1 / Math.E) {
            return Double.NaN;
        }

        final double one_over_E = 1.0 / Math.E;
        final double q = x + one_over_E;

        if (x == 0.0) {
            return 0.0;
        } else if (q < 0.0) {
            return -1.0;
        } else if (q == 0.0) {
            return -1.0;
        } else if (q < 1.0e-03) {
            final double r = Math.sqrt(q);
            return series_eval(r);
        } else {
            final int MAX_ITERS = 10;
            double w;

            if (x < 1.0) {
                final double p = Math.sqrt(2.0 * Math.E * q);
                w = -1.0 + p * (1.0 + p * (-1.0 / 3.0 + p * 11.0 / 72.0));
            } else {
                w = Math.log(x);
                if (x > 3.0) {
                    w -= Math.log(w);
                }
            }

            return halley_iteration(x, w, MAX_ITERS);
        }
    }

    static public double lambertn1(double x) {
        if (x < -1 / Math.E || x >= 0) {
            return Double.NaN;
        }

        final int MAX_ITERS = 32;
        final double one_over_E = 1.0 / Math.E;
        final double q = x + one_over_E;
        double w;

        if (q < 0.0) {
            return -1.0;
        }

        if (x < -1.0e-6) {
            final double r = -Math.sqrt(q);
            w = series_eval(r);
            if (q < 3.0e-3) {
                return w;
            }
        } else {
            final double L_1 = Math.log(-x);
            final double L_2 = Math.log(-L_1);
            w = L_1 - L_2 + L_2 / L_1;
        }

        return halley_iteration(x, w, MAX_ITERS);
    }
}
