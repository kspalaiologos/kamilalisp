package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

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

    private static double polevl(double x, double[] p, int N) {
        int i = N, dx = 0;
        double ans = p[dx++];

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
}
