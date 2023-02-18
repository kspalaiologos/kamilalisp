package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Pair;

import java.math.BigDecimal;
import java.math.BigInteger;
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

    public static final Flt64Base.Flt64Function frexp = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:frexp";
        }

        Atom frexpA(Atom a) {
            double aD = Flt64Base.toFlt64(a);
            Pair<Integer, Double> p = frexp(aD);
            return new Atom(List.of(new Atom(BigInteger.valueOf(p.fst())), new Atom(BigDecimal.valueOf(p.snd()))));
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if(args.size() == 1)
                return frexpA(args.get(0));
            else
                return new Atom(args.stream().map(this::frexpA).toList());
        }
    };

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

    // It's more efficient to simply tabulate all factorials.
    private static double factorialTab[] = {
            1.0,1.0,2.0,6.0,24.0,120.0,720.0,5040.0,40320.0,362880.0,3628800.0,39916800.0,479001600.0,6227020800.0,
            8.71782912E10,1.307674368E12,2.092278989E13,3.556874281E14,6.402373706E15,
            1.216451004E17,2.432902008E18,5.109094217E19,1.124000728E21,
            2.585201674E22,6.204484017E23,1.551121004E25,4.032914611E26,
            1.088886945E28,3.048883446E29,8.841761994E30,2.652528598E32,
            8.222838654E33,2.631308369E35,8.683317619E36,2.95232799E38,1.033314797E40,
            3.719933268E41,1.376375309E43,5.230226175E44,2.039788208E46,
            8.159152832E47,3.345252661E49,1.405006118E51,6.041526306E52,
            2.658271575E54,1.196222209E56,5.50262216E57,2.586232415E59,1.241391559E61,
            6.08281864E62,3.04140932E64,1.551118753E66,8.065817517E67,4.274883284E69,
            2.308436973E71,1.269640335E73,7.109985878E74,4.05269195E76,2.350561331E78,
            1.386831185E80,8.320987113E81,5.075802139E83,3.146997326E85,
            1.982608315E87,1.268869322E89,8.247650592E90,5.443449391E92,
            3.647111092E94,2.480035542E96,1.711224524E98,1.197857167E100,
            8.504785886E101,6.123445838E103,4.470115462E105,3.307885442E107,
            2.480914081E109,1.885494702E111,1.45183092E113,1.132428118E115,
            8.946182131E116,7.156945705E118,5.797126021E120,4.753643337E122,
            3.94552397E124,3.314240135E126,2.817104114E128,2.422709538E130,
            2.107757298E132,1.854826423E134,1.650795516E136,1.485715964E138,
            1.352001528E140,1.243841405E142,1.156772507E144,1.087366157E146,
            1.032997849E148,9.916779349E149,9.619275968E151,9.426890449E153,
            9.332621544E155,9.332621544E157,9.42594776E159,9.614466715E161,
            9.902900716E163,1.029901675E166,1.081396758E168,1.146280564E170,
            1.226520203E172,1.324641819E174,1.443859583E176,1.588245542E178,
            1.762952551E180,1.974506857E182,2.231192749E184,2.543559733E186,
            2.925093693E188,3.393108684E190,3.969937161E192,4.68452585E194,
            5.574585761E196,6.689502913E198,8.094298525E200,9.875044201E202,
            1.214630437E205,1.506141742E207,1.882677177E209,2.372173243E211,
            3.012660018E213,3.856204824E215,4.974504222E217,6.466855489E219,
            8.471580691E221,1.118248651E224,1.487270706E226,1.992942746E228,
            2.690472707E230,3.659042882E232,5.012888748E234,6.917786473E236,
            9.615723197E238,1.346201248E241,1.898143759E243,2.695364138E245,
            3.854370717E247,5.550293833E249,8.047926057E251,1.174997204E254,
            1.72724589E256,2.556323918E258,3.808922638E260,5.713383956E262,
            8.627209774E264,1.311335886E267,2.006343905E269,3.089769614E271,
            4.789142901E273,7.471062926E275,1.172956879E278,1.853271869E280,
            2.946702272E282,4.714723636E284,7.590705054E286,1.229694219E289,
            2.004401577E291,3.287218586E293,5.423910666E295,9.003691706E297,
            1.503616515E300,2.526075745E302,4.269068009E304,7.257415615E306
    };

    public static double factorial(int n){
        if(n < 0){
            throw new ArithmeticException("Domain error");
        }
        if(n > 170){
            return Double.POSITIVE_INFINITY;
        }
        return factorialTab[n];
    }

    public static final Flt64Base.Flt64Function factorial = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:factorial";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(factorial((int) Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> factorial((int) x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };

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

        if(x < -1.0) {
            double q, w;
            int r;

            w = Math.log(-x);
            s = 0.0;
            for(r = 1; r <= n / 2; r++) {
                j = 2 * r;
                p = polylog(j, -1.0);
                j = n - j;
                if(j == 0) {
                    s = s + p;
                    break;
                }
                q = j;
                q = Math.pow(w, q) * p / factorial(j);
                s = s + q;
            }
            s = 2.0 * s;
            q = polylog(n, 1.0 / x);
            if((n & 1) == 1)
                q = -q;
            s = s - q;
            s = s - Math.pow(w, n) / factorial(n);
            return s;
        }

        throw new UnsupportedOperationException("Not implemented yet");
    }
}
