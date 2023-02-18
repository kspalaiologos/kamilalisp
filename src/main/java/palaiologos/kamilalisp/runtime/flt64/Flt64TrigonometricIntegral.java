package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Pair;

import java.util.List;

public class Flt64TrigonometricIntegral {
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
    // Shi/Chi implementation:
    private static final double[] S1 = {
            1.83889230173399459482E-17,
            -9.55485532279655569575E-17,
            2.04326105980879882648E-16,
            1.09896949074905343022E-15,
            -1.31313534344092599234E-14,
            5.93976226264314278932E-14,
            -3.47197010497749154755E-14,
            -1.40059764613117131000E-12,
            9.49044626224223543299E-12,
            -1.61596181145435454033E-11,
            -1.77899784436430310321E-10,
            1.35455469767246947469E-9,
            -1.03257121792819495123E-9,
            -3.56699611114982536845E-8,
            1.44818877384267342057E-7,
            7.82018215184051295296E-7,
            -5.39919118403805073710E-6,
            -3.12458202168959833422E-5,
            8.90136741950727517826E-5,
            2.02558474743846862168E-3,
            2.96064440855633256972E-2,
            1.11847751047257036625E0
    };
    private static final double[] S2 = {
            -1.05311574154850938805E-17,
            2.62446095596355225821E-17,
            8.82090135625368160657E-17,
            -3.38459811878103047136E-16,
            -8.30608026366935789136E-16,
            3.93397875437050071776E-15,
            1.01765565969729044505E-14,
            -4.21128170307640802703E-14,
            -1.60818204519802480035E-13,
            3.34714954175994481761E-13,
            2.72600352129153073807E-12,
            1.66894954752839083608E-12,
            -3.49278141024730899554E-11,
            -1.58580661666482709598E-10,
            -1.79289437183355633342E-10,
            1.76281629144264523277E-9,
            1.69050228879421288846E-8,
            1.25391771228487041649E-7,
            1.16229947068677338732E-6,
            1.61038260117376323993E-5,
            3.49810375601053973070E-4,
            1.28478065259647610779E-2,
            1.03665722588798326712E0
    };
    private static final double[] C1 = {
            -8.12435385225864036372E-18,
            2.17586413290339214377E-17,
            5.22624394924072204667E-17,
            -9.48812110591690559363E-16,
            5.35546311647465209166E-15,
            -1.21009970113732918701E-14,
            -6.00865178553447437951E-14,
            7.16339649156028587775E-13,
            -2.93496072607599856104E-12,
            -1.40359438136491256904E-12,
            8.76302288609054966081E-11,
            -4.40092476213282340617E-10,
            -1.87992075640569295479E-10,
            1.31458150989474594064E-8,
            -4.75513930924765465590E-8,
            -2.21775018801848880741E-7,
            1.94635531373272490962E-6,
            4.33505889257316408893E-6,
            -6.13387001076494349496E-5,
            -3.13085477492997465138E-4,
            4.97164789823116062801E-4,
            2.64347496031374526641E-2,
            1.11446150876699213025E0
    };
    private static final double[] C2 = {
            8.06913408255155572081E-18,
            -2.08074168180148170312E-17,
            -5.98111329658272336816E-17,
            2.68533951085945765591E-16,
            4.52313941698904694774E-16,
            -3.10734917335299464535E-15,
            -4.42823207332531972288E-15,
            3.49639695410806959872E-14,
            6.63406731718911586609E-14,
            -3.71902448093119218395E-13,
            -1.27135418132338309016E-12,
            2.74851141935315395333E-12,
            2.33781843985453438400E-11,
            2.71436006377612442764E-11,
            -2.56600180000355990529E-10,
            -1.61021375163803438552E-9,
            -4.72543064876271773512E-9,
            -3.00095178028681682282E-9,
            7.79387474390914922337E-8,
            1.06942765566401507066E-6,
            1.59503164802313196374E-5,
            3.49592575153777996871E-4,
            1.28475387530065247392E-2,
            1.03665693917934275131E0
    };
    public static final Flt64Base.Flt64Function fShi = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:Shi";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(Shi(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64TrigonometricIntegral::Shi).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fChi = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:Chi";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(Chi(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64TrigonometricIntegral::Chi).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    private static double SiF(double x) {
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

    private static double SiG(double x) {
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
        if (x < 0.0) return Double.NaN;
        if (x < 4.0) {
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
        if (x < 0.0) return Double.NaN;
        if (x < 4.0) {
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

    public static double Shi(double x) {
        return ShiChi(x).fst();
    }

    public static double Chi(double x) {
        return ShiChi(x).snd();
    }

    public static Pair<Double, Double> ShiChi(double x) {
        double k, z, c, s, a, si, ci;
        short sign;

        if (x < 0.0) {
            sign = -1;
            x = -x;
        } else
            sign = 0;

        if (x == 0.0) {
            return new Pair<>(0.0, -1.7976931348623158E308);
        }

        if (x < 8.0) {

            z = x * x;

            a = 1.0;
            s = 1.0;
            c = 0.0;
            k = 2.0;

            do {
                a *= z / k;
                c += a / k;
                k += 1.0;
                a /= k;
                s += a / k;
                k += 1.0;
            }
            while (Math.abs(a / s) > Flt64Base.EPSILON);

            s *= x;
            if (sign != 0)
                s = -s;
            si = s;
            ci = 0.57721566490153286060651209008240243104215933593992 + Math.log(x) + c;
            return new Pair<>(si, ci);
        }

        if (x < 18.0) {
            a = (576.0 / x - 52.0) / 10.0;
            k = Math.exp(x) / x;
            s = k * chbevl(a, S1, 22);
            c = k * chbevl(a, C1, 23);
            if (sign != 0)
                s = -s;
            si = s;
            ci = 0.57721566490153286060651209008240243104215933593992 + Math.log(x) + c;
            return new Pair<>(si, ci);
        }

        if (x <= 88.0) {
            a = (6336.0 / x - 212.0) / 70.0;
            k = Math.exp(x) / x;
            s = k * chbevl(a, S2, 23);
            c = k * chbevl(a, C2, 24);
            if (sign != 0)
                s = -s;
            si = s;
            ci = 0.57721566490153286060651209008240243104215933593992 + Math.log(x) + c;
        } else {
            if (sign != 0)
                si = -1.7976931348623158E308;
            else
                si = 1.7976931348623158E308;
            ci = 1.7976931348623158E308;
        }
        return new Pair<>(si, ci);
    }
}
