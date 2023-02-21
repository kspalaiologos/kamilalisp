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

    public static final Flt64Base.Flt64Function fLerchPhi = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:lerch-phi";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 3);
            return Flt64Base.toAtom(lerch_phi(Flt64Base.toFlt64(args.get(0)), Flt64Base.toFlt64(args.get(1)), Flt64Base.toFlt64(args.get(2))));
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

    // van Wijngaarden's A_j for Lerch Transcendent computation.
    private static double aj(double z, double s, double v, int j, double acc) {
        // ind and two2k can be longs, but we use ints to avoid overflow.
        // there's still a check in the loop body to make sure though.
        double sum, bjk, z2ind, ind, two2k;
        int k;

        sum = 0.0;
        k = -1;
        two2k = 1;

        do {
            k++;

            if (k > 0) two2k *= 2;
            ind = two2k * (j + 1) - 1;

            if (k > 0 && (two2k == 0 || ind == 0)) {
                return Double.NaN;
            }

            z2ind = Math.pow(z, ind);
            bjk = two2k * z2ind / Math.pow(v + ind, s);
            sum += bjk;
        } while (!(Math.abs(sum) <= 2.2250738585072014e-308) && !(Math.abs(bjk / sum) < 1.0e-2 * acc));

        return sum;
    }

    // https://www.marvinrayburns.com/UniversalTOC25.pdf
    private static double lerchphiGeneral(double z, double s, double v, double acc) {
        final int imax = 100;

        if (1.0 <= Math.abs(z)) {
            throw new ArithmeticException("lerchphi: |z| >= 1 divergence");
        }

        if (Math.abs(Math.floor(v) - v) <= Flt64Base.EPSILON * Math.abs(v) && v <= 0.0) {
            throw new ArithmeticException("lerchphi: v divergence");
        }

        double v1 = v, sum1 = 0, result;
        int m = 0, sign;

        boolean s_cond = Math.abs(Math.floor(s) - s) > Flt64Base.EPSILON * Math.abs(s);
        if (v < 0.0 && Math.abs(z) > Flt64Base.EPSILON) {
            if (s_cond) {
                throw new ArithmeticException("lerch-phi: s divergence");
            } else {
                m = -(int) Math.floor(v);
                v1 += m;
                sum1 = 0.0;
                if (((int) s % 2) == 0) sign = 1;
                else sign = -1;
                for (int i = 0; i <= m - 1; i++) {
                    if (i > 0 && z < 0) sign = -sign;
                    sum1 += sign * Math.pow(Math.abs(z), i) / Math.pow(Math.abs(v + i), s);
                }
            }
        }

        if (Math.abs(z) <= Flt64Base.EPSILON) {
            if (v < 0) {
                if (s_cond) {
                    throw new ArithmeticException("lerch-phi: s divergence");
                } else {
                    if (((int) s % 2) == 0) sign = 1;
                    else sign = -1;
                    result = sign * 1.0 / Math.pow(Math.abs(v), s);
                }
            } else {
                return 1.0 / Math.pow(v, s);
            }
        }

        double eps0, skn, skn0, sn, omega;
        eps0 = skn0 = sn = 0.0;

        if (z <= 0.5)
            omega = 1.0 / Math.pow(v1, s);
        else {
            omega = aj(z, s, v1, 0, acc);
        }

        double[] num = new double[imax];
        double[] den = new double[imax];
        double[] StoreAj = null;

        // CNCT case.
        if (z > 0.5) StoreAj = new double[imax];

        int i = -1;
        sign = -1;

        final int beta = 1;
        final int n = 0;

        double est = 0, iom, factor, factor1, eps, x, cacc;

        for (; ; ) {
            i++;
            sign = -sign;
            sn += omega;
            double omegafactor = Math.pow((v1 + i) / (v1 + i + 1), s);
            if (z < 0.0)
                omega = (z) * omegafactor * omega;
            else {
                if (z <= 0.5)
                    omega = (z) * omegafactor * omega;
                else {
                    StoreAj[i] = sign * omega;
                    if (i % 2 == 0) {
                        omega = -sign * 0.5 * (StoreAj[i / 2] - Math.pow(z, i / 2) /
                                Math.pow(v1 + i / 2, s));
                    } else {
                        omega = aj(z, s, v1, i + 1, acc);
                        omega = -sign * omega;
                    }
                }
            }
            if (Math.abs(z) <= 0.5) {
                skn = sn;
                est = 2.0 * Math.pow(Math.abs(z), (i + 1)) / Math.pow(v1 + i + 1, s);
            } else {
                if (Math.abs(omega) <= Flt64Base.EPSILON) {
                    throw new ArithmeticException("lerch-phi: omega ~= 0");
                } else iom = 1.0 / omega;
                num[i] = sn * iom;
                den[i] = iom;
                if (i > 0) {
                    factor = 1.0;
                    num[i - 1] = num[i] - factor * num[i - 1];
                    den[i - 1] = den[i] - factor * den[i - 1];
                }

                factor1 = (double) (beta + n + i - 1) * (beta + n + i - 2);
                for (int j = 2; j <= i; j++) {
                    factor = factor1 / (beta + n + i + j - 2) / (beta + n + i + j - 3);
                    num[i - j] = num[i - j + 1] - factor * num[i - j];
                    den[i - j] = den[i - j + 1] - factor * den[i - j];
                }
                skn = num[0] / den[0];
            }

            eps = Math.abs(skn - skn0);

            if (i > 0 && eps < eps0) {
                if (Math.abs(z) > 0.5) {
                    x = eps / eps0;
                    est = 2.0 / x / (1.0 - x) * eps;
                }
                cacc = Math.abs(est / skn);
                if (cacc < acc) break;
            }

            if (eps <= 0.0) break;

            if (i > imax - 2) {
                throw new ArithmeticException("Maximum number of iterations exceeded in lerch-phi");
            }

            skn0 = skn;
            eps0 = eps;
        }

        if (v < 0) {
            sign = 1;
            if ((z < 0) && (m % 2 != 0)) sign = -1;
            result = sum1 + skn * sign * Math.pow(Math.abs(z), m);
        } else result = skn;

        return result;
    }

    public static double lerch_phi(double s, double a, double z) {
        // lerchphi(1, a, 1) = zeta(a)
        if (s == 1 && z == 1)
            return riemann_zeta(a);
        // lerchphi(1, a, z) = zeta(a, z)
        if (s == 1)
            return hurwitz_zeta(a, z);
        // z*lerchphi(z,s,1) = Li_s(z). n:int
        if (Math.floor(a) == a && z == 1)
            return Flt64Spence.polylog((int) a, s) / s;
        // lerchphi(0,1,a) = 1/sqrt(a^2)
        if (s == 0 && a == 1)
            return 1 / Math.abs(z);
        // lerchphi(1,s,0.5) = (2^s-1)*zeta(s)
        if (s == 1 && z == 0.5)
            return (Math.pow(2, a) - 1) * riemann_zeta(a);
        // lerchphi(z,1,1) = -log(1-z)/z
        if (a == 1 && z == 1)
            return -Math.log(1 - s) / s;
        // lerchphi(z,2,0.5) = 2/sqrt(z) * (Li2(z) - Li2(-z))
        if (a == 2 && z == 0.5)
            return 2 / Math.sqrt(s) * (Flt64Spence.dilog(s) - Flt64Spence.dilog(-s));
        // lerchphi(z,2,1.5) = 2/(z^1.5) * (Li2(z) - Li2(-z) - 2sqrt(z))
        if (a == 2 && z == 1.5)
            return 2 / Math.pow(s, 1.5) * (Flt64Spence.dilog(s) - Flt64Spence.dilog(-s) - 2 * Math.sqrt(s));
        // lerchphi(0,s,a) = (a^2)^(-s/2)
        if (s == 0)
            return Math.pow(z * z, -a / 2);
        // lerchphi(z,0,a) = 1/(1-z)
        if (a == 0)
            return 1 / (1 - s);
        return lerchphiGeneral(s, a, z, 10e-16);
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