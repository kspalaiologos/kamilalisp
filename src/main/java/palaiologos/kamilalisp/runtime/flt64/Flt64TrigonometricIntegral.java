package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

public class Flt64TrigonometricIntegral {
    private static double SiF(double x){
        double x2 = x * x;
        double nrt = 1 +
                (7.44437068161936700618e2 +
                        (1.96396372895146869801e5 +
                                (2.37750310125431834034e7 +
                                        (1.43073403821274636888e9 +
                                                (4.33736238870432522765e10 +
                                                        (6.40533830574022022911e11 +
                                                                (4.20968180571076940208e12 +
                                                                        (1.00795182980368574617e13 +
                                                                                (4.94816688199951963482e12 -
                                                                                        (4.94701168645415959931e11 / x2))
                                                                                        / x2)
                                                                                / x2)
                                                                        / x2)
                                                                / x2)
                                                        / x2)
                                                / x2)
                                        / x2)
                                / x2)
                        / x2;
        double drt = 1 +
                (7.46437068161927678031e2 +
                        (1.97865247031583951450e5 +
                                (2.41535670165126845144e7 +
                                        (1.47478952192985464958e9 +
                                                (4.58595115847765779830e10 +
                                                        (7.08501308149515401563e11 +
                                                                (5.06084464593475076774e12 +
                                                                        (1.43468549171581016479e13 +
                                                                                (1.11535493509914254097e13 / x2))
                                                                                / x2)
                                                                        / x2)
                                                                / x2)
                                                        / x2)
                                                / x2)
                                        / x2)
                                / x2)
                        / x2;
        return nrt / (drt * x);
    }

    private static double SiG(double x){
        double x2 = x * x;
        double nrt = 1 +
                (8.1359520115168615e2 +
                        (2.35239181626478200e5 +
                                (3.12557570795778731e7 +
                                        (2.06297595146763354e9 +
                                                (6.83052205423625007e10 +
                                                        (1.09049528450362786e12 +
                                                                (7.57664583257834349e12 +
                                                                        (1.81004487464664575e13 +
                                                                                (6.43291613143049485e12 -
                                                                                        (1.36517137670871689e12 / x2))
                                                                                        / x2)
                                                                                / x2)
                                                                        / x2)
                                                                / x2)
                                                        / x2)
                                                / x2)
                                        / x2)
                                / x2)
                        / x2;
        double drt = 1 +
                (8.19595201151451564e2 +
                        (2.40036752835578777e5 +
                                (3.26026661647090822e7 +
                                        (2.23355543278099360e9 +
                                                (7.87465017341829930e10 +
                                                        (1.39866710696414565e12 +
                                                                (1.17164723371736605e13 +
                                                                        (4.01839087307656620e13 +
                                                                                (3.99653257887490811e13 / x2))
                                                                                / x2)
                                                                        / x2)
                                                                / x2)
                                                        / x2)
                                                / x2)
                                        / x2)
                                / x2)
                        / x2;
        return nrt / (drt * x2);
    }

    public static double Si(double x) {
        if(x < 0.0) return Double.NaN;
        if(x < 4.0) {
            double x2 = x * x;
            double x4 = x2 * x2;
            double x6 = x4 * x2;
            double x8 = x4 * x4;
            double x10 = x8 * x2;
            double x12 = x8 * x4;
            double nrt = 1.0 - 4.54393409816329991e-2 * x2 + 1.15457225751016682e-3 * x4 - 1.41018536821330254e-5 * x6 + 9.43280809438713025e-8 * x8 - 3.53201978997168357e-10 * x10 + x12 * (7.08240282274875911e-13 - 6.05338212010422477e-16 * x2);
            double drt = 1.0 + 1.01162145739225565e-2 * x2 + 4.99175116169755106e-5 * x4 + 1.55654986308745614e-7 * x6 + 3.28067571055789734e-10 * x8 + 4.5049097575386581e-13 * x10 + 3.21107051193712168e-16 * x12;
            return x * nrt / drt;
        } else {
            // Si(x) = pi/2 - SiF(x)*cos(x) - SiG(x)*sin(x)
            double pi2 = Math.PI / 2.0;
            double cos = Math.cos(x);
            double sin = Math.sin(x);
            return pi2 - SiF(x) * cos - SiG(x) * sin;
        }
    }

    public static double si(double x) {
        return Si(x) - Math.PI / 2;
    }

    public static double Ci(double x) {
        if(x < 0.0) return Double.NaN;
        if(x < 4.0) {
            double x2 = x * x;
            double x4 = x2 * x2;
            double x6 = x4 * x2;
            double x8 = x4 * x4;
            double x10 = x8 * x2;
            double x12 = x8 * x4;
            double x14 = x12 * x2;
            double nrt = -0.25 + 7.51851524438898291e-3 * x2 - 1.27528342240267686e-4 * x4 + 1.05297363846239184e-6 * x6 - 4.68889508144848019e-9 * x8 + 1.06480802891189243e-11 * x10 - 9.93728488857585407e-15 * x12;
            double drt = 1 + 1.1592605689110735e-2 * x2 + 6.72126800814254432e-5 * x4 + 2.55533277086129636e-7 * x6 + 6.97071295760958946e-10 * x8 + 1.38536352772778619e-12 * x10 + 1.89106054713059759e-15 * x12 + 1.39759616731376855e-18 * x14;
            return 0.57721566490153286060651209008240243104215933593992 + Math.log(x) + x2 * (nrt / drt);
        } else {
            // Ci(x) = SiF(x)*sin(x) - SiG(x)*cos(x)
            double cos = Math.cos(x);
            double sin = Math.sin(x);
            return SiF(x) * sin - SiG(x) * cos;
        }
    }

    public static double Cin(double x) {
        // Ci(x) = euler-gamma + ln(x) - Cin(x).
        // ... => Cin(x) = euler-gamma + ln(x) - Ci(x)
        return 0.57721566490153286060651209008240243104215933593992 + Math.log(x) - Ci(x);
    }

    public static final Flt64Base.Flt64Function fSi = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:Si";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(Si(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64TrigonometricIntegral::Si).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public static final Flt64Base.Flt64Function fsi = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:si";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(si(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64TrigonometricIntegral::si).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public static final Flt64Base.Flt64Function fCi = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:Ci";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(Ci(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64TrigonometricIntegral::Ci).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public static final Flt64Base.Flt64Function fCin = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:Cin";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(Cin(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64TrigonometricIntegral::Cin).mapToObj(Flt64Base::toAtom).toList());
        }
    };
}
