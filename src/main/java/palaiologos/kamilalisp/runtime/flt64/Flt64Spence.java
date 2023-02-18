package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Pair;

import java.util.List;

public class Flt64Spence {
    private final static double[] A = {
            4.65128586073990045278E-5,
            7.31589045238094711071E-3,
            1.33847639578309018650E-1,
            8.79691311754530315341E-1,
            2.71149851196553469920E0,
            4.25697156008121755724E0,
            3.29771340985225106936E0,
            1.00000000000000000126E0,
    };

    private final static double[] B = {
            6.90990488912553276999E-4,
            2.54043763932544379113E-2,
            2.82974860602568089943E-1,
            1.41172597751831069617E0,
            3.63800533345137075418E0,
            5.03278880143316990390E0,
            3.54771340985225096217E0,
            9.99999999999999998740E-1,
    };
    public static final Flt64Base.Flt64Function spence = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:dilog";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(spence(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Spence::spence).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    // Polylog tables:
    static double[] A4 = {
            3.056144922089490701751E-2,
            3.243086484162581557457E-1,
            2.877847281461875922565E-1,
            7.091267785886180663385E-2,
            6.466460072456621248630E-3,
            2.450233019296542883275E-4,
            4.031655364627704957049E-6,
            2.884169163909467997099E-8,
            8.680067002466594858347E-11,
            1.025983405866370985438E-13,
            4.233468313538272640380E-17,
            4.959422035066206902317E-21,
            1.059365867585275714599E-25,
    };
    static double[] B4 = {
            2.821262403600310974875E0,
            1.780221124881327022033E0,
            3.778888211867875721773E-1,
            3.193887040074337940323E-2,
            1.161252418498096498304E-3,
            1.867362374829870620091E-5,
            1.319022779715294371091E-7,
            3.942755256555603046095E-10,
            4.644326968986396928092E-13,
            1.913336021014307074861E-16,
            2.240041814626069927477E-20,
            4.784036597230791011855E-25,
    };

    private static double polevl(double x, double[] p, int N) {
        int i = N, dx = 0;
        double ans = p[dx++];

        do
            ans = ans * x + p[dx++];
        while (--i > 0);

        return ans;
    }

    private static double p1evl(double x, double[] p, int N) {
        int i = N - 1, dx = 0;
        double ans = x + p[dx++];

        do
            ans = ans * x + p[dx++];
        while (--i > 0);

        return ans;
    }

    private static double zetac(double d) {
        return Flt64Zeta.riemann_zeta(d) - 1;
    }

    public static double spence(double x) {
        double w, y, z;
        int flag;

        if (x < 0.0)
            throw new ArithmeticException("Domain error");
        if (x == 1.0)
            return 0.0;
        if (x == 0.0)
            return Math.PI * Math.PI / 6.0;

        flag = 0;

        if (x > 2.0) {
            x = 1.0 / x;
            flag |= 2;
        }

        if (x > 1.5) {
            w = (1.0 / x) - 1.0;
            flag |= 2;
        } else if (x < 0.5) {
            w = -x;
            flag |= 1;
        } else
            w = x - 1.0;

        y = -w * polevl(w, A, 7) / polevl(w, B, 7);

        if ((flag & 1) != 0)
            y = (Math.PI * Math.PI) / 6.0 - Math.log(x) * Math.log(1.0 - x) - y;

        if ((flag & 2) != 0) {
            z = Math.log(x);
            y = -0.5 * z * z - y;
        }

        return y;
    }

    private static Pair<Integer, Double> frexp(double value) {
        long bits = Double.doubleToLongBits(value);
        double realMant = 1.;

        if (Double.isNaN(value) ||
                value + value == value ||
                Double.isInfinite(value)) {
            return new Pair<>(0, value);
        } else {

            boolean neg = (bits < 0);
            int exponent = (int) ((bits >> 52) & 0x7ffL);
            long mantissa = bits & 0xfffffffffffffL;

            if (exponent == 0) {
                exponent++;
            } else {
                mantissa = mantissa | (1L << 52);
            }

            exponent -= 1075;
            realMant = mantissa;

            while (realMant > 1.0) {
                mantissa >>= 1;
                realMant /= 2.;
                exponent++;
            }

            if (neg) {
                realMant = realMant * -1;
            }

            return new Pair<>(exponent, realMant);
        }
    }


    private static double powi(double x, int nn) {
        int n, e, sign, asign, lx;
        double w, y, s;
        if (x == 0.0) {
            if (nn == 0)
                return (1.0);
            else if (nn < 0)
                return (1.7976931348623158E308);
            else
                return (0.0);
        }
        if (nn == 0)
            return (1.0);
        if (x < 0.0) {
            asign = -1;
            x = -x;
        } else
            asign = 0;
        if (nn < 0) {
            sign = -1;
            n = -nn;
        } else {
            sign = 1;
            n = nn;
        }
        Pair<Integer, Double> p = frexp(x);
        lx = p.fst();
        s = p.snd();
        e = (lx - 1) * n;
        if ((e == 0) || (e > 64) || (e < -64)) {
            s = (s - 7.0710678118654752e-1) / (s + 7.0710678118654752e-1);
            s = (2.9142135623730950 * s - 0.5 + lx) * nn * 1.4426950408889634073599;
        } else {
            s = 1.4426950408889634073599 * e;
        }

        if (s > 7.09782712893383996843E2) {
            throw new ArithmeticException("powi: overflow");
        }
        if (s < -7.09782712893383996843E2)
            return (0.0);
        if ((n & 1) != 0)
            y = x;
        else {
            y = 1.0;
            asign = 0;
        }
        w = x;
        n >>= 1;
        while (n != 0) {
            w = w * w;
            if ((n & 1) != 0)
                y *= w;
            n >>= 1;
        }
        if (asign != 0)
            y = -y;
        if (sign < 0)
            y = 1.0 / y;
        return (y);
    }

    public static double polylog(int n, double x) {
        double h, k, p, s, t, u, xc, z;
        int i, j;

        if (n == -1) {
            p = 1.0 - x;
            u = x / p;
            return u * u + u;
        }

        if (n == 0) {
            return x / (1.0 - x);
        }

        if (x > 1.0 || n < -1) {
            throw new ArithmeticException("Domain error");
        }

        if (n == 1) {
            return -Math.log(1.0 - x);
        }

        if (x == 1.0) {
            return Flt64Zeta.riemann_zeta(n);
        }

        if (x == -1.0) {
            /* Li_n(1) = zeta(n) */
            s = Flt64Zeta.riemann_zeta(n);
            s = s * (powi(2.0, 1 - n) - 1.0);
            return s;
        }

        throw new UnsupportedOperationException("Not implemented yet");
    }
}
