package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

public class Flt64Bessel {
    protected static final double[] A_i0 = {
            -4.41534164647933937950E-18,
            3.33079451882223809783E-17,
            -2.43127984654795469359E-16,
            1.71539128555513303061E-15,
            -1.16853328779934516808E-14,
            7.67618549860493561688E-14,
            -4.85644678311192946090E-13,
            2.95505266312963983461E-12,
            -1.72682629144155570723E-11,
            9.67580903537323691224E-11,
            -5.18979560163526290666E-10,
            2.65982372468238665035E-9,
            -1.30002500998624804212E-8,
            6.04699502254191894932E-8,
            -2.67079385394061173391E-7,
            1.11738753912010371815E-6,
            -4.41673835845875056359E-6,
            1.64484480707288970893E-5,
            -5.75419501008210370398E-5,
            1.88502885095841655729E-4,
            -5.76375574538582365885E-4,
            1.63947561694133579842E-3,
            -4.32430999505057594430E-3,
            1.05464603945949983183E-2,
            -2.37374148058994688156E-2,
            4.93052842396707084878E-2,
            -9.49010970480476444210E-2,
            1.71620901522208775349E-1,
            -3.04682672343198398683E-1,
            6.76795274409476084995E-1
    };
    protected static final double[] B_i0 = {
            -7.23318048787475395456E-18,
            -4.83050448594418207126E-18,
            4.46562142029675999901E-17,
            3.46122286769746109310E-17,
            -2.82762398051658348494E-16,
            -3.42548561967721913462E-16,
            1.77256013305652638360E-15,
            3.81168066935262242075E-15,
            -9.55484669882830764870E-15,
            -4.15056934728722208663E-14,
            1.54008621752140982691E-14,
            3.85277838274214270114E-13,
            7.18012445138366623367E-13,
            -1.79417853150680611778E-12,
            -1.32158118404477131188E-11,
            -3.14991652796324136454E-11,
            1.18891471078464383424E-11,
            4.94060238822496958910E-10,
            3.39623202570838634515E-9,
            2.26666899049817806459E-8,
            2.04891858946906374183E-7,
            2.89137052083475648297E-6,
            6.88975834691682398426E-5,
            3.36911647825569408990E-3,
            8.04490411014108831608E-1
    };
    protected static final double[] A_i1 = {
            2.77791411276104639959E-18,
            -2.11142121435816608115E-17,
            1.55363195773620046921E-16,
            -1.10559694773538630805E-15,
            7.60068429473540693410E-15,
            -5.04218550472791168711E-14,
            3.22379336594557470981E-13,
            -1.98397439776494371520E-12,
            1.17361862988909016308E-11,
            -6.66348972350202774223E-11,
            3.62559028155211703701E-10,
            -1.88724975172282928790E-9,
            9.38153738649577178388E-9,
            -4.44505912879632808065E-8,
            2.00329475355213526229E-7,
            -8.56872026469545474066E-7,
            3.47025130813767847674E-6,
            -1.32731636560394358279E-5,
            4.78156510755005422638E-5,
            -1.61760815825896745588E-4,
            5.12285956168575772895E-4,
            -1.51357245063125314899E-3,
            4.15642294431288815669E-3,
            -1.05640848946261981558E-2,
            2.47264490306265168283E-2,
            -5.29459812080949914269E-2,
            1.02643658689847095384E-1,
            -1.76416518357834055153E-1,
            2.52587186443633654823E-1
    };
    protected static final double[] B_i1 = {
            7.51729631084210481353E-18,
            4.41434832307170791151E-18,
            -4.65030536848935832153E-17,
            -3.20952592199342395980E-17,
            2.96262899764595013876E-16,
            3.30820231092092828324E-16,
            -1.88035477551078244854E-15,
            -3.81440307243700780478E-15,
            1.04202769841288027642E-14,
            4.27244001671195135429E-14,
            -2.10154184277266431302E-14,
            -4.08355111109219731823E-13,
            -7.19855177624590851209E-13,
            2.03562854414708950722E-12,
            1.41258074366137813316E-11,
            3.25260358301548823856E-11,
            -1.89749581235054123450E-11,
            -5.58974346219658380687E-10,
            -3.83538038596423702205E-9,
            -2.63146884688951950684E-8,
            -2.51223623787020892529E-7,
            -3.88256480887769039346E-6,
            -1.10588938762623716291E-4,
            -9.76109749136146840777E-3,
            7.78576235018280120474E-1
    };
    protected static final double[] A_k0 = {
            1.37446543561352307156E-16,
            4.25981614279661018399E-14,
            1.03496952576338420167E-11,
            1.90451637722020886025E-9,
            2.53479107902614945675E-7,
            2.28621210311945178607E-5,
            1.26461541144692592338E-3,
            3.59799365153615016266E-2,
            3.44289899924628486886E-1,
            -5.35327393233902768720E-1
    };
    protected static final double[] B_k0 = {
            5.30043377268626276149E-18,
            -1.64758043015242134646E-17,
            5.21039150503902756861E-17,
            -1.67823109680541210385E-16,
            5.51205597852431940784E-16,
            -1.84859337734377901440E-15,
            6.34007647740507060557E-15,
            -2.22751332699166985548E-14,
            8.03289077536357521100E-14,
            -2.98009692317273043925E-13,
            1.14034058820847496303E-12,
            -4.51459788337394416547E-12,
            1.85594911495471785253E-11,
            -7.95748924447710747776E-11,
            3.57739728140030116597E-10,
            -1.69753450938905987466E-9,
            8.57403401741422608519E-9,
            -4.66048989768794782956E-8,
            2.76681363944501510342E-7,
            -1.83175552271911948767E-6,
            1.39498137188764993662E-5,
            -1.28495495816278026384E-4,
            1.56988388573005337491E-3,
            -3.14481013119645005427E-2,
            2.44030308206595545468E0
    };
    protected static final double[] A_k1 = {
            -7.02386347938628759343E-18,
            -2.42744985051936593393E-15,
            -6.66690169419932900609E-13,
            -1.41148839263352776110E-10,
            -2.21338763073472585583E-8,
            -2.43340614156596823496E-6,
            -1.73028895751305206302E-4,
            -6.97572385963986435018E-3,
            -1.22611180822657148235E-1,
            -3.53155960776544875667E-1,
            1.52530022733894777053E0
    };
    protected static final double[] B_k1 = {
            -5.75674448366501715755E-18,
            1.79405087314755922667E-17,
            -5.68946255844285935196E-17,
            1.83809354436663880070E-16,
            -6.05704724837331885336E-16,
            2.03870316562433424052E-15,
            -7.01983709041831346144E-15,
            2.47715442448130437068E-14,
            -8.97670518232499435011E-14,
            3.34841966607842919884E-13,
            -1.28917396095102890680E-12,
            5.13963967348173025100E-12,
            -2.12996783842756842877E-11,
            9.21831518760500529508E-11,
            -4.19035475934189648750E-10,
            2.01504975519703286596E-9,
            -1.03457624656780970260E-8,
            5.74108412545004946722E-8,
            -3.50196060308781257119E-7,
            2.40648494783721712015E-6,
            -1.93619797416608296024E-5,
            1.95215518471351631108E-4,
            -2.85781685962277938680E-3,
            1.03923736576817238437E-1,
            2.72062619048444266945E0
    };

    private static double besseln(int n, double x) {
        int sg, k;
        double y, tmp, pk, xk, pkm1, r, pkm2;
        if (n < 0) {
            n = -n;
            if (n % 2 == 0) {
                sg = 1;
            } else {
                sg = -1;
            }
        } else {
            sg = 1;
        }
        if (x < 0) {
            if (n % 2 != 0) {
                sg = -sg;
            }
            x = -x;
        }
        if (n == 0) {
            y = sg * bessel0(x);
            return y;
        }
        if (n == 1) {
            y = sg * bessel1(x);
            return y;
        }
        if (n == 2) {
            if (x == 0) {
                y = 0;
            } else {
                y = sg * (2.0 * bessel1(x) / x - bessel0(x));
            }
            return y;
        }
        if (x < 1.e-12) {
            y = 0;
            return y;
        }
        k = 53;
        pk = 2 * (n + k);
        tmp = pk;
        xk = x * x;
        while (k != 0) {
            pk = pk - 2.0;
            tmp = pk - xk / tmp;
            k = k - 1;
        }
        tmp = x / tmp;
        pk = 1.0;
        pkm1 = 1.0 / tmp;
        k = n - 1;
        r = 2 * k;
        while (k != 0) {
            pkm2 = (pkm1 * r - pk * x) / x;
            pk = pkm1;
            pkm1 = pkm2;
            r = r - 2.0;
            k = k - 1;
        }
        if (Math.abs(pk) > Math.abs(pkm1)) {
            tmp = bessel1(x) / pk;
        } else {
            tmp = bessel0(x) / pkm1;
        }
        return sg * tmp;
    }

    public static double besselnDerivative(int n, double x) {
        int m, qm, qp, nm, np;
        double bjn, bjnm, bjnp;
        m = n;
        if (n == 0) {
            bjn = besseln(1, x);
            return -bjn;
        }
        qm = 1;
        qp = 1;
        nm = m - 1;
        np = m + 1;
        if (m < 0) {
            if (nm < 0) {
                nm = -nm;
                qm = -1;
            }
            if (np < 0) {
                np = -np;
                qp = -1;
            }
        }
        bjnm = besseln(nm, x);
        bjnp = besseln(np, x);
        bjnm = Math.pow(qm, nm) * bjnm;
        bjnp = Math.pow(qp, np) * bjnp;
        return (bjnm - bjnp) / 2.;
    }

    public static double bessel0(double x) {
        double nn, pzero, qzero, xsq, p1, q1, y;
        double[] zz;
        double[] p = {26857.86856980014981415848441, -40504123.71833132706360663322, 25071582855.36881945555156435, -8085222034853.793871199468171, 1434354939140344.111664316553, -136762035308817138.6865416609, 6382059341072356562.289432465, -117915762910761053603.8440800, 493378725179413356181.6813446};
        double[] q = {1.0, 1363.063652328970604442810507, 1114636.098462985378182402543, 669998767.2982239671814028660, 312304311494.1213172572469442, 112775673967979.8507056031594, 30246356167094626.98627330784, 5428918384092285160.200195092, 493378725179413356211.3278438};
        if (x < 0) {
            x = -x;
        }
        if (x > 8.0) {
            zz = besselasympt0(x);
            pzero = zz[0];
            qzero = zz[1];
            nn = x - Math.PI / 4;
            y = Math.sqrt(2 / Math.PI / x) * (pzero * Math.cos(nn) - qzero * Math.sin(nn));
            return y;
        }
        xsq = x * x;
        p1 = p[0];
        for (int i = 1; i < 9; i++) {
            p1 = p[i] + p1 * xsq;
        }
        q1 = q[0];
        for (int i = 1; i < 9; i++) {
            q1 = q[i] + q1 * xsq;
        }
        return p1 / q1;
    }

    public static double bessel1(double x) {
        double s, pzero, qzero, nn, p1, q1, y, xsq;
        double[] zz;
        double[] p = {2701.122710892323414856790990, -4695753.530642995859767162166, 3413234182.301700539091292655, -1322983480332.126453125473247, 290879526383477.5409737601689, -35888175699101060.50743641413, 2316433580634002297.931815435, -66721065689249162980.20941484, 581199354001606143928.050809};
        double[] q = {1.0, 1606.931573481487801970916749, 1501793.594998585505921097578, 1013863514.358673989967045588, 524371026216.7649715406728642, 208166122130760.7351240184229, 60920613989175217.46105196863, 11857707121903209998.37113348, 1162398708003212287858.529400};
        s = Math.signum(x);
        if (x < 0) {
            x = -x;
        }
        if (x > 8.0) {
            zz = besselasympt1(x);
            pzero = zz[0];
            qzero = zz[1];
            nn = x - 3 * Math.PI / 4;
            y = Math.sqrt(2 / Math.PI / x) * (pzero * Math.cos(nn) - qzero * Math.sin(nn));
            if (s < 0) {
                y = -y;
            }
            return y;
        }
        xsq = x * x;
        p1 = p[0];
        for (int i = 1; i < 9; i++) {
            p1 = p[i] + p1 * xsq;
        }
        q1 = q[0];
        for (int i = 1; i < 9; i++) {
            q1 = q[i] + q1 * xsq;
        }
        return s * x * p1 / q1;
    }

    private static double[] besselasympt0(double x) {
        double xsq, p2, q2, p3, q3, pzero, qzero;
        double[] zz = new double[2];
        double[] p = {0.0, 2485.271928957404011288128951, 153982.6532623911470917825993, 2016135.283049983642487182349, 8413041.456550439208464315611, 12332384.76817638145232406055, 5393485.083869438325262122897};
        double[] q = {1.0, 2615.700736920839685159081813, 156001.7276940030940592769933, 2025066.801570134013891035236, 8426449.050629797331554404810, 12338310.22786324960844856182, 5393485.083869438325560444960};
        double[] pp = {0.0, -4.887199395841261531199129300, -226.2630641933704113967255053, -2365.956170779108192723612816, -8239.066313485606568803548860, -10381.41698748464093880530341, -3984.617357595222463506790588};
        double[] qq = {1.0, 408.7714673983499223402830260, 15704.89191515395519392882766, 156021.3206679291652539287109, 533291.3634216897168722255057, 666745.4239319826986004038103, 255015.5108860942382983170882};
        xsq = 64.0 / x / x;
        p2 = p[0];
        for (int i = 1; i < 7; i++) {
            p2 = p[i] + p2 * xsq;
        }
        q2 = q[0];
        for (int i = 1; i < 7; i++) {
            q2 = q[i] + q2 * xsq;
        }
        p3 = pp[0];
        for (int i = 1; i < 7; i++) {
            p3 = pp[i] + p3 * xsq;
        }
        q3 = qq[0];
        for (int i = 1; i < 7; i++) {
            q3 = qq[i] + q3 * xsq;
        }
        pzero = p2 / q2;
        qzero = 8 * p3 / q3 / x;
        zz[0] = pzero;
        zz[1] = qzero;
        return zz;
    }

    private static double[] besselasympt1(double x) {
        double xsq, p2, q2, p3, q3, pzero, qzero;
        double[] zz = new double[2];
        double[] p = {-1611.616644324610116477412898, -109824.0554345934672737413139, -1523529.351181137383255105722, -6603373.248364939109255245434, -9942246.505077641195658377899, -4435757.816794127857114720794};
        double[] q = {1.0, -1455.009440190496182453565068, -107263.8599110382011903063867, -1511809.506634160881644546358, -6585339.479723087072826915069, -9934124.389934585658967556309, -4435757.816794127856828016962};
        double[] pp = {35.26513384663603218592175580, 1706.375429020768002061283546, 18494.26287322386679652009819, 66178.83658127083517939992166, 85145.16067533570196555001171, 33220.91340985722351859704442};
        double[] qq = {1.0, 863.8367769604990967475517183, 37890.22974577220264142952256, 400294.4358226697511708610813, 1419460.669603720892855755253, 1819458.042243997298924553839, 708712.8194102874357377502472};
        xsq = 64.0 / x / x;
        p2 = p[0];
        for (int i = 1; i < 6; i++) {
            p2 = p[i] + p2 * xsq;
        }
        q2 = q[0];
        for (int i = 1; i < 7; i++) {
            q2 = q[i] + q2 * xsq;
        }
        p3 = pp[0];
        for (int i = 1; i < 6; i++) {
            p3 = pp[i] + p3 * xsq;
        }
        q3 = qq[0];
        for (int i = 1; i < 7; i++) {
            q3 = qq[i] + q3 * xsq;
        }
        pzero = p2 / q2;
        qzero = 8 * p3 / q3 / x;
        zz[0] = pzero;
        zz[1] = qzero;
        return zz;
    }

    public static double bessel(int n, double x) {
        if (n == 0)
            return bessel0(x);
        else if (n == 1)
            return bessel1(x);
        else
            return besseln(n, x);
    }

    // BesselK
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

    static public double i0(double x) {
        double y;
        if (x < 0) x = -x;
        if (x <= 8.0) {
            y = (x / 2.0) - 2.0;
            return (Math.exp(x) * chbevl(y, A_i0, 30));
        }

        return (Math.exp(x) * chbevl(32.0 / x - 2.0, B_i0, 25) / Math.sqrt(x));
    }

    static public double i1(double x) {
        double y, z;

        z = Math.abs(x);
        if (z <= 8.0) {
            y = (z / 2.0) - 2.0;
            z = chbevl(y, A_i1, 29) * z * Math.exp(z);
        } else {
            z = Math.exp(z) * chbevl(32.0 / z - 2.0, B_i1, 25) / Math.sqrt(z);
        }
        if (x < 0.0)
            z = -z;
        return (z);
    }

    static public double k0(double x) {
        double y, z;

        if (x <= 0.0) throw new ArithmeticException();
        if (x <= 2.0) {
            y = x * x - 2.0;
            y = chbevl(y, A_k0, 10) - Math.log(0.5 * x) * i0(x);
            return (y);
        }

        z = 8.0 / x - 2.0;
        y = Math.exp(-x) * chbevl(z, B_k0, 25) / Math.sqrt(x);
        return (y);
    }

    static public double k1(double x) {
        double y, z;

        z = 0.5 * x;
        if (z <= 0.0) throw new ArithmeticException();
        if (x <= 2.0) {
            y = x * x - 2.0;
            y = Math.log(z) * i1(x) + chbevl(y, A_k1, 11) / x;
            return (y);
        }

        return (Math.exp(-x) * chbevl(8.0 / x - 2.0, B_k1, 25) / Math.sqrt(x));
    }

    static public double kn(int nn, double x) {
        final double EUL = 5.772156649015328606065e-1;
        final double MAXNUM = Double.MAX_VALUE;
        final int MAXFAC = 31;

        double k, kf, nk1f, nkf, zn, t, s, z0, z;
        double ans, fn, pn, pk, zmn, tlg, tox;
        int i, n;

        if (nn < 0)
            n = -nn;
        else
            n = nn;

        if (n > MAXFAC) throw new ArithmeticException("Overflow");
        if (x <= 0.0) throw new IllegalArgumentException();

        if (x <= 9.55) {
            ans = 0.0;
            z0 = 0.25 * x * x;
            fn = 1.0;
            pn = 0.0;
            zmn = 1.0;
            tox = 2.0 / x;

            if (n > 0) {
                pn = -EUL;
                k = 1.0;
                for (i = 1; i < n; i++) {
                    pn += 1.0 / k;
                    k += 1.0;
                    fn *= k;
                }

                zmn = tox;

                if (n == 1) {
                    ans = 1.0 / x;
                } else {
                    nk1f = fn / n;
                    kf = 1.0;
                    s = nk1f;
                    z = -z0;
                    zn = 1.0;
                    for (i = 1; i < n; i++) {
                        nk1f = nk1f / (n - i);
                        kf = kf * i;
                        zn *= z;
                        t = nk1f * zn / kf;
                        s += t;
                        if ((MAXNUM - Math.abs(t)) < Math.abs(s)) throw new ArithmeticException("Overflow");
                        if ((tox > 1.0) && ((MAXNUM / tox) < zmn)) throw new ArithmeticException("Overflow");
                        zmn *= tox;
                    }
                    s *= 0.5;
                    t = Math.abs(s);
                    if ((zmn > 1.0) && ((MAXNUM / zmn) < t)) throw new ArithmeticException("Overflow");
                    if ((t > 1.0) && ((MAXNUM / t) < zmn)) throw new ArithmeticException("Overflow");
                    ans = s * zmn;
                }
            }


            tlg = 2.0 * Math.log(0.5 * x);
            pk = -EUL;
            if (n == 0) {
                pn = pk;
                t = 1.0;
            } else {
                pn = pn + 1.0 / n;
                t = 1.0 / fn;
            }
            s = (pk + pn - tlg) * t;
            k = 1.0;
            do {
                t *= z0 / (k * (k + n));
                pk += 1.0 / k;
                pn += 1.0 / (k + n);
                s += (pk + pn - tlg) * t;
                k += 1.0;
            }
            while (Math.abs(t / s) > 1.11022302462515654042E-16);

            s = 0.5 * s / zmn;
            if ((n & 1) > 0)
                s = -s;
            ans += s;

            return (ans);
        }

        /* Asymptotic expansion for Kn(x) */
        /* Converges to 1.4e-17 for x > 18.4 */
        if (x > 7.09782712893383996732E2) throw new ArithmeticException("Underflow");
        k = n;
        pn = 4.0 * k * k;
        pk = 1.0;
        z0 = 8.0 * x;
        fn = 1.0;
        t = 1.0;
        s = t;
        nkf = MAXNUM;
        i = 0;
        do {
            z = pn - pk * pk;
            t = t * z / (fn * z0);
            nk1f = Math.abs(t);
            if ((i >= n) && (nk1f > nkf)) {
                ans = Math.exp(-x) * Math.sqrt(Math.PI / (2.0 * x)) * s;
                return (ans);
            }
            nkf = nk1f;
            s += t;
            fn += 1.0;
            pk += 2.0;
            i += 1;
        } while (Math.abs(t / s) > 1.11022302462515654042E-16);


        ans = Math.exp(-x) * Math.sqrt(Math.PI / (2.0 * x)) * s;
        return (ans);
    }

    static public double y0(double x) throws ArithmeticException {

        if (x < 8.0) {
            double y = x * x;

            double ans1 = -2957821389.0 + y * (7062834065.0 + y * (-512359803.6
                    + y * (10879881.29 + y * (-86327.92757 + y * 228.4622733))));
            double ans2 = 40076544269.0 + y * (745249964.8 + y * (7189466.438
                    + y * (47447.26470 + y * (226.1030244 + y))));

            return (ans1 / ans2) + 0.636619772 * bessel0(x) * Math.log(x);
        } else {
            double z = 8.0 / x;
            double y = z * z;
            double xx = x - 0.785398164;

            double ans1 = 1.0 + y * (-0.1098628627e-2 + y * (0.2734510407e-4
                    + y * (-0.2073370639e-5 + y * 0.2093887211e-6)));
            double ans2 = -0.1562499995e-1 + y * (0.1430488765e-3
                    + y * (-0.6911147651e-5 + y * (0.7621095161e-6
                    + y * (-0.934945152e-7))));
            return Math.sqrt(0.636619772 / x) *
                    (Math.sin(xx) * ans1 + z * Math.cos(xx) * ans2);
        }
    }

    static public double y1(double x) throws ArithmeticException {

        if (x < 8.0) {
            double y = x * x;
            double ans1 = x * (-0.4900604943e13 + y * (0.1275274390e13
                    + y * (-0.5153438139e11 + y * (0.7349264551e9
                    + y * (-0.4237922726e7 + y * 0.8511937935e4)))));
            double ans2 = 0.2499580570e14 + y * (0.4244419664e12
                    + y * (0.3733650367e10 + y * (0.2245904002e8
                    + y * (0.1020426050e6 + y * (0.3549632885e3 + y)))));
            return (ans1 / ans2) + 0.636619772 * (bessel1(x) * Math.log(x) - 1.0 / x);
        } else {
            double z = 8.0 / x;
            double y = z * z;
            double xx = x - 2.356194491;
            double ans1 = 1.0 + y * (0.183105e-2 + y * (-0.3516396496e-4
                    + y * (0.2457520174e-5 + y * (-0.240337019e-6))));
            double ans2 = 0.04687499995 + y * (-0.2002690873e-3
                    + y * (0.8449199096e-5 + y * (-0.88228987e-6
                    + y * 0.105787412e-6)));
            return Math.sqrt(0.636619772 / x) *
                    (Math.sin(xx) * ans1 + z * Math.cos(xx) * ans2);
        }
    }

    static public double yn(int n, double x) {
        double by, bym, byp, tox;

        if (n == 0) return y0(x);
        if (n == 1) return y1(x);

        tox = 2.0 / x;
        by = y1(x);
        bym = y0(x);
        for (int j = 1; j < n; j++) {
            byp = j * tox * by - bym;
            bym = by;
            by = byp;
        }
        return by;
    }

    public static final Flt64Base.Flt64Function fBessely0 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-y0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(y0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::y0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBessely1 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-y1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(y1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::y1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBessely = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-yn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(yn(args.get(0).getInteger().intValueExact(), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public static final Flt64Base.Flt64Function fBesselk = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-kn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(kn(args.get(0).getInteger().intValueExact(), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public static final Flt64Base.Flt64Function fBesseli0 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-i0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(i0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::i0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBesseli1 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-i1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(i1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::i1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBesselk0 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-k0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(k0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::k0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBesselk1 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-k1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(k1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::k1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBessel0 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-j0";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(bessel0(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::bessel0).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBessel1 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-j1";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(bessel1(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Bessel::bessel1).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function fBessel = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-jn";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(bessel(args.get(0).getInteger().intValueExact(), Flt64Base.toFlt64(args.get(1))));
        }
    };
    public static final Flt64Base.Flt64Function fBesselderv = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:bessel-jn-derv";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            return Flt64Base.toAtom(besselnDerivative(args.get(0).getInteger().intValueExact(), Flt64Base.toFlt64(args.get(1))));
        }
    };
}
