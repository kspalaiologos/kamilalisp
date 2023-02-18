package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

public class Flt64Zeta {
    public static final Flt64Base.Flt64Function fRiemannZeta = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:zeta";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(riemann_zeta(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Zeta::riemann_zeta).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    private static final double[] zetBernCoefs = new double[]
            {
                    0.0,
                    0.083333333333333333333, -0.0013888888888888888889, 0.000033068783068783068783,
                    -8.2671957671957671958e-7, 2.0876756987868098979e-8, -5.2841901386874931848e-10,
                    1.3382536530684678833e-11, -3.3896802963225828668e-13, 8.5860620562778445641e-15,
                    -2.1748686985580618730e-16
            };
    public static final Flt64Base.Flt64Function fHurwitzZeta = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:hurwitz-zeta";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(hurwitz_zeta(Flt64Base.toFlt64(args.get(0)), Flt64Base.toFlt64(args.get(1))));
        }
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
                __zeta *= Math.pow(2 * Math.PI, __s) * Math.sin(Math.PI / 2 * __s) * Math.exp(Flt64Gamma.loggamma(1 - __s)) / Math.PI;
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
                double __bincoeff = Flt64Gamma.loggamma(1 + __i) - Flt64Gamma.loggamma(1 + __j) - Flt64Gamma.loggamma(1 + __i - __j);
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
            if (Math.abs(__term / __zeta) < Flt64Base.EPSILON)
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
            if (1 - __fact < Flt64Base.EPSILON) {
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
            zeta *= Math.pow(2 * Math.PI, s) * Math.sin(Math.PI / 2 * s) * Math.exp(Flt64Gamma.loggamma(1 - s)) / Math.PI;
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
                return Math.exp(Math.log(2) + Flt64Gamma.loggamma(s) - s * Math.log(2 * Math.PI)) * sum;
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
            part2 += zetBernCoefs[k] * Math.exp(-(k + x) * Math.log(a + n) + Flt64Gamma.loggamma(-2 + 3 * k + x) - Flt64Gamma.loggamma(-2 + 2 * k + x));
        }

        return part1 + Math.pow(a + n, 1 - x) / (x - 1) - 1. / (2 * Math.pow(a + n, x)) + part2;
    }
}
