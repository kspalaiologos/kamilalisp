package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

public class Flt64Airy {
    public static final Flt64Base.Flt64Function airy = new Flt64Base.Flt64Function() {
        public static double airy(double x) {
            int n, l;
            double s, t, u, v, uc, vc, k1, k2, c, xt, si, co, expxt;
            double sqrtx, wwl, pl, pl1, pl2, zzz, ai;
            double[] xtmp = new double[26];
            xtmp[1] = 1.4083081072180964e1;
            xtmp[2] = 1.0214885479197331e1;
            xtmp[3] = 7.4416018450450930;
            xtmp[4] = 5.3070943061781927;
            xtmp[5] = 3.6340135029132462;
            xtmp[6] = 2.3310652303052450;
            xtmp[7] = 1.3447970842609268;
            xtmp[8] = 6.4188858369567296e-1;
            xtmp[9] = 2.0100345998121046e-1;
            xtmp[10] = 8.0594359172052833e-3;
            xtmp[11] = 3.1542515762964787e-14;
            xtmp[12] = 6.6394210819584921e-11;
            xtmp[13] = 1.7583889061345669e-8;
            xtmp[14] = 1.3712392370435815e-6;
            xtmp[15] = 4.4350966639284350e-5;
            xtmp[16] = 7.1555010917718255e-4;
            xtmp[17] = 6.4889566103335381e-3;
            xtmp[18] = 3.6440415875773282e-2;
            xtmp[19] = 1.4399792418590999e-1;
            xtmp[20] = 8.1231141336261486e-1;
            xtmp[21] = 0.355028053887817;
            xtmp[22] = 0.258819403792807;
            xtmp[23] = 1.73205080756887729;
            xtmp[24] = 0.78539816339744831;
            xtmp[25] = 0.56418958354775629;
            if ((x >= -5.0) && (x <= 8.0)) {
                u = v = t = uc = vc = 1.0;
                s = 0.5;
                n = 3;
                zzz = x * x * x;
                while (Math.abs(u) + Math.abs(v) + Math.abs(s) + Math.abs(t) > 1.0e-18) {
                    u = u * zzz / (n * (n - 1));
                    v = v * zzz / (n * (n + 1));
                    s = s * zzz / (n * (n + 2));
                    t = t * zzz / (n * (n - 2));
                    uc += u;
                    vc += v;
                    n += 3;
                }
                if (x < 2.5) {
                    ai = xtmp[21] * uc - xtmp[22] * x * vc;
                    return ai;
                }
            }
            k1 = k2 = 0.0;
            sqrtx = Math.sqrt(Math.abs(x));
            xt = 0.666666666666667 * Math.abs(x) * sqrtx;
            c = xtmp[25] / Math.sqrt(sqrtx);
            if (x < 0.0) {
                co = Math.cos(xt - xtmp[24]);
                si = Math.sin(xt - xtmp[24]);
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl2 = pl * pl;
                    pl1 = 1.0 + pl2;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / pl1;
                }
                ai = c * (co * k1 + si * k2);
            } else {
                if (x < 9.0) {
                    expxt = Math.exp(xt);
                } else {
                    expxt = 1.0;
                }
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl1 = 1.0 + pl;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / (xt * pl1 * pl1);
                }
                ai = 0.5 * c * k1 / expxt;
                if (x >= 9.0) {
                    // Asymptotic behavior follows
                    expxt = Math.pow(x, 3. / 2.);
                    ai = 0.5 * Math.exp(-2.0 * expxt / 3.0) / Math.sqrt(Math.PI) / Math.pow(x, 0.25);
                }
            }
            return ai;
        }

        @Override
        protected String name() {
            return "flt64:airy-ai";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(airy(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> airy(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };

    public static final Flt64Base.Flt64Function airyDerv = new Flt64Base.Flt64Function() {
        public static double airyDerivative(double x) {
            int n, l;
            double s, t, u, v, sc, tc, k1, k2, k3, k4, c, xt, si, co, expxt;
            double sqrtx, wwl, pl, pl1, pl2, pl3, zzz, ai, aid;
            double[] xtmp = new double[26];
            xtmp[1] = 1.4083081072180964e1;
            xtmp[2] = 1.0214885479197331e1;
            xtmp[3] = 7.4416018450450930;
            xtmp[4] = 5.3070943061781927;
            xtmp[5] = 3.6340135029132462;
            xtmp[6] = 2.3310652303052450;
            xtmp[7] = 1.3447970842609268;
            xtmp[8] = 6.4188858369567296e-1;
            xtmp[9] = 2.0100345998121046e-1;
            xtmp[10] = 8.0594359172052833e-3;
            xtmp[11] = 3.1542515762964787e-14;
            xtmp[12] = 6.6394210819584921e-11;
            xtmp[13] = 1.7583889061345669e-8;
            xtmp[14] = 1.3712392370435815e-6;
            xtmp[15] = 4.4350966639284350e-5;
            xtmp[16] = 7.1555010917718255e-4;
            xtmp[17] = 6.4889566103335381e-3;
            xtmp[18] = 3.6440415875773282e-2;
            xtmp[19] = 1.4399792418590999e-1;
            xtmp[20] = 8.1231141336261486e-1;
            xtmp[21] = 0.355028053887817;
            xtmp[22] = 0.258819403792807;
            xtmp[23] = 1.73205080756887729;
            xtmp[24] = 0.78539816339744831;
            xtmp[25] = 0.56418958354775629;
            if ((x >= -5.0) && (x <= 8.0)) {
                u = v = t = tc = 1.0;
                s = sc = 0.5;
                n = 3;
                zzz = x * x * x;
                while (Math.abs(u) + Math.abs(v) + Math.abs(s) + Math.abs(t) > 1.0e-18) {
                    u = u * zzz / (n * (n - 1));
                    v = v * zzz / (n * (n + 1));
                    s = s * zzz / (n * (n + 2));
                    t = t * zzz / (n * (n - 2));
                    sc += s;
                    tc += t;
                    n += 3;
                }
                if (x < 2.5) {
                    return xtmp[21] * sc * x * x - xtmp[22] * tc;
                }
            }
            k1 = k2 = k3 = k4 = 0.0;
            sqrtx = Math.sqrt(Math.abs(x));
            xt = 0.666666666666667 * Math.abs(x) * sqrtx;
            c = xtmp[25] / Math.sqrt(sqrtx);
            if (x < 0.0) {
                x = -x;
                co = Math.cos(xt - xtmp[24]);
                si = Math.sin(xt - xtmp[24]);
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl2 = pl * pl;
                    pl1 = 1.0 + pl2;
                    pl3 = pl1 * pl1;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / pl1;
                    k3 += wwl * pl * (1.0 + pl * (2.0 / xt + pl)) / pl3;
                    k4 += wwl * (-1.0 - pl * (1.0 + pl * (xt - pl)) / xt) / pl3;
                }
                ai = c * (co * k1 + si * k2);
                aid = 0.25 * ai / x - c * sqrtx * (co * k3 + si * k4);
            } else {
                if (x < 9.0) {
                    expxt = Math.exp(xt);
                } else {
                    expxt = 1.0;
                }
                for (l = 1; l <= 10; l++) {
                    wwl = xtmp[l + 10];
                    pl = xtmp[l] / xt;
                    pl1 = 1.0 + pl;
                    pl2 = 1.0 - pl;
                    k1 += wwl / pl1;
                    k2 += wwl * pl / (xt * pl1 * pl1);
                    k3 += wwl / pl2;
                    k4 += wwl * pl / (xt * pl2 * pl2);
                }
                ai = 0.5 * c * k1 / expxt;
                aid = ai * (-0.25 / x - sqrtx) + 0.5 * c * sqrtx * k2 / expxt;
                if (x >= 9) {
                    // Asymptotic behavior follows
                    expxt = Math.pow(x, 3. / 2.);
                    ai = 0.5 * Math.exp(-2.0 * expxt / 3.0) / Math.sqrt(Math.PI) / Math.pow(x, 0.25);
                    aid = -ai * Math.pow(x, 0.5) - ai / x / 4.0;
                }
            }
            return aid;
        }

        @Override
        protected String name() {
            return "flt64:airy-ai-derv";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(airyDerivative(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> airyDerivative(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
}
