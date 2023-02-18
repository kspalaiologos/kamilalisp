package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

public class Flt64Fresnel {
    static final double sqrt_2pi = 2.506628274631000502415765284811045253006;
    public static final Flt64Base.Flt64Function fFresnelSine = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:fresnel-S";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(fresnelS(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Fresnel::fresnelS).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fFresnelCosine = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:fresnel-C";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(fresnelC(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Fresnel::fresnelC).mapToObj(Flt64Base::toAtom).toList());
        }
    };

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
