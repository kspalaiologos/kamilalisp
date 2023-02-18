package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.util.List;

public class Flt64Base {
    public static final double EPSILON = Math.ulp(1.0d);
    public final Flt64Function erf = new Flt64Function() {
        public static double erf(double x) {
            if (x > 26.0) {
                return 1.0;
            } else if (x < -5.5) {
                return -1.0;
            } else {
                double absx, c, p, q;
                absx = Math.abs(x);
                if (absx <= 0.5) {
                    c = x * x;
                    p = ((-0.356098437018154e-1 * c + 0.699638348861914e1) * c + 0.219792616182942e2) * c + 0.242667955230532e3;
                    q = ((c + 0.150827976304078e2) * c + 0.911649054045149e2) * c + 0.215058875869861e3;
                    return x * p / q;
                }
                if (x < 0.0) {
                    return -(1.0 - Math.exp(-x * x) * nonexperfc(absx));
                }
                return 1.0 - Math.exp(-x * x) * nonexperfc(absx);
            }
        }

        private static double nonexperfc(double x) {
            double absx, c, p, q;
            absx = Math.abs(x);
            if (absx <= 0.5) {
                return Math.exp(x * x) * erf(x);
            } else if (absx < 4.0) {
                c = absx;
                p = ((((((-0.136864857382717e-6 * c + 0.564195517478974e0) * c + 0.721175825088309e1) * c + 0.431622272220567e2) * c + 0.152989285046940e3) * c + 0.339320816734344e3) * c + 0.451918953711873e3) * c + 0.300459261020162e3;
                q = ((((((c + 0.127827273196294e2) * c + 0.770001529352295e2) * c + 0.277585444743988e3) * c + 0.638980264465631e3) * c + 0.931354094850610e3) * c + 0.790950925327898e3) * c + 0.300459260956983e3;
                return ((x > 0.0) ? p / q : Math.exp(x * x) * 2.0 - p / q);
            } else {
                c = 1.0 / x / x;
                p = (((0.223192459734185e-1 * c + 0.278661308609648e0) * c + 0.226956593539687e0) * c + 0.494730910623251e-1) * c + 0.299610707703542e-2;
                q = (((c + 0.198733201817135e1) * c + 0.105167510706793e1) * c + 0.191308926107830e0) * c + 0.106209230528468e-1;
                c = (c * (-p) / q + 0.564189583547756) / absx;
                return ((x > 0.0) ? c : Math.exp(x * x) * 2.0 - c);
            }
        }

        @Override
        protected String name() {
            return "flt64:erf";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(erf(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> erf(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function erfc = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erfc";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(erfc(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Flt64Base::erfc).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function erfcInverse = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erfc-inverse";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(inverfc(Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> inverfc(x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function erfInverse = new Flt64Function() {
        @Override
        protected String name() {
            return "flt64:erf-inverse";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return Flt64Base.toAtom(inverfc(1. - Flt64Base.toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(x -> inverfc(1. - x)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public final Flt64Function airy = new Flt64Function() {
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

    public final Flt64Function airyDerv = new Flt64Function() {
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

    static double toFlt64(Atom a) {
        return switch (a.getType()) {
            case INTEGER -> a.getInteger().doubleValue();
            case REAL -> a.getReal().doubleValue();
            case COMPLEX -> a.getComplex().re.doubleValue();
            default -> throw new IllegalArgumentException("Cannot convert " + a.getType() + " to flt64");
        };
    }

    public static Atom toAtom(double d) {
        return new Atom(BigDecimal.valueOf(d));
    }

    public static double erfc(double x) {
        final double t = 1.0 / (1.0 + 0.5 * Math.abs(x));
        final double ans = t
                * Math.exp(-x
                * x
                - 1.26551223
                + t
                * (1.00002368 + t
                * (0.37409196 + t
                * (0.09678418 + t
                * (-0.18628806 + t
                * (0.27886807 + t
                * (-1.13520398 + t
                * (1.48851587 + t
                * (-0.82215223 + t * 0.17087277)))))))));

        return x >= 0.0 ? ans : -ans;
    }

    double inverfc(double p) {
        double x, err, t, pp;
        if (p >= 2.0) return -100.;
        if (p <= 0.0) return 100.;
        pp = (p < 1.0) ? p : 2. - p;
        t = Math.sqrt(-2. * Math.log(pp / 2.));
        x = -0.70711 * ((2.30753 + t * 0.27061) / (1. + t * (0.99229 + t * 0.04481)) - t);
        for (int j = 0; j < 2; j++) {
            err = erfc(x) - pp;
            x += err / (1.12837916709551257 * Math.exp(-x * x) - x * err);
        }
        return (p < 1.0 ? x : -x);
    }

    public void registerFlt64(Environment env) {
        // TODO:
        // Si(x), Co(x) - investigate cases of catastorphic cancellation.
        // dawson-f, log-integral, fresnel-f, fresnel-g, Shi, Chi, hankel-h1, hankel-h2, polylog
        // dilog (spence), airy-bi, hypergeom-2f1, hypergeom-pfq, meijer-g, fox-h, hypergeom-1f1,
        // whittaker-m, whittaker-w, elliptic-k, elliptic-f, elliptic-e, elliptic-pi,
        // lerch-phi, dirichlet-beta, dirichlet-eta, dirichlet-lambda, barnesg, logbarnesg,
        env.setPrimitive("flt64:+", new Atom(Flt64Arith.add));
        env.setPrimitive("flt64:-", new Atom(Flt64Arith.sub));
        env.setPrimitive("flt64:*", new Atom(Flt64Arith.mul));
        env.setPrimitive("flt64:/", new Atom(Flt64Arith.div));
        env.setPrimitive("flt64:mod", new Atom(Flt64Arith.mod));
        env.setPrimitive("flt64:**", new Atom(Flt64Arith.pow));
        env.setPrimitive("flt64:abs", new Atom(Flt64Arith.abs));
        env.setPrimitive("flt64:ceil", new Atom(Flt64Arith.ceil));
        env.setPrimitive("flt64:floor", new Atom(Flt64Arith.floor));
        env.setPrimitive("flt64:round", new Atom(Flt64Arith.round));
        env.setPrimitive("flt64:exp", new Atom(Flt64Arith.exp));
        env.setPrimitive("flt64:ln", new Atom(Flt64Arith.ln));
        env.setPrimitive("flt64:log2", new Atom(Flt64Arith.log2));
        env.setPrimitive("flt64:log10", new Atom(Flt64Arith.log));
        env.setPrimitive("flt64:sqrt", new Atom(Flt64Arith.sqrt));
        env.setPrimitive("flt64:min", new Atom(Flt64Cmp.min));
        env.setPrimitive("flt64:max", new Atom(Flt64Cmp.max));
        env.setPrimitive("flt64:signum", new Atom(Flt64Cmp.signum));
        env.setPrimitive("flt64:sin", new Atom(Flt64Trig.sin));
        env.setPrimitive("flt64:cos", new Atom(Flt64Trig.cos));
        env.setPrimitive("flt64:tan", new Atom(Flt64Trig.tan));
        env.setPrimitive("flt64:asin", new Atom(Flt64Trig.asin));
        env.setPrimitive("flt64:acos", new Atom(Flt64Trig.acos));
        env.setPrimitive("flt64:atan", new Atom(Flt64Trig.atan));
        env.setPrimitive("flt64:sec", new Atom(Flt64Trig.sec));
        env.setPrimitive("flt64:csc", new Atom(Flt64Trig.csc));
        env.setPrimitive("flt64:cot", new Atom(Flt64Trig.cot));
        env.setPrimitive("flt64:asec", new Atom(Flt64Trig.asec));
        env.setPrimitive("flt64:acsc", new Atom(Flt64Trig.acsc));
        env.setPrimitive("flt64:acot", new Atom(Flt64Trig.acot));
        env.setPrimitive("flt64:sinh", new Atom(Flt64Trig.sinh));
        env.setPrimitive("flt64:cosh", new Atom(Flt64Trig.cosh));
        env.setPrimitive("flt64:tanh", new Atom(Flt64Trig.tanh));
        env.setPrimitive("flt64:asinh", new Atom(Flt64Trig.asinh));
        env.setPrimitive("flt64:acosh", new Atom(Flt64Trig.acosh));
        env.setPrimitive("flt64:atanh", new Atom(Flt64Trig.atanh));
        env.setPrimitive("flt64:sech", new Atom(Flt64Trig.sech));
        env.setPrimitive("flt64:csch", new Atom(Flt64Trig.csch));
        env.setPrimitive("flt64:coth", new Atom(Flt64Trig.coth));
        env.setPrimitive("flt64:gamma", new Atom(Flt64Gamma.fGamma));
        env.setPrimitive("flt64:digamma", new Atom(Flt64Gamma.fDigamma));
        env.setPrimitive("flt64:trigamma", new Atom(Flt64Gamma.fTrigamma));
        env.setPrimitive("flt64:beta", new Atom(Flt64Gamma.fBeta));
        env.setPrimitive("flt64:zeta", new Atom(Flt64Zeta.fRiemannZeta));
        env.setPrimitive("flt64:hurwitz-zeta", new Atom(Flt64Zeta.fHurwitzZeta));
        env.setPrimitive("flt64:polygamma", new Atom(Flt64Gamma.fPolygamma));
        env.setPrimitive("flt64:pochhammer", new Atom(Flt64Gamma.fPochhammer));
        env.setPrimitive("flt64:erf", new Atom(erf));
        env.setPrimitive("flt64:erfc", new Atom(erfc));
        env.setPrimitive("flt64:erf-inverse", new Atom(erfInverse));
        env.setPrimitive("flt64:erfc-inverse", new Atom(erfcInverse));
        env.setPrimitive("flt64:ui-gamma", new Atom(Flt64Gamma.fUpperIncompleteGamma));
        env.setPrimitive("flt64:li-gamma", new Atom(Flt64Gamma.fLowerIncompleteGamma));
        env.setPrimitive("flt64:log-gamma", new Atom(Flt64Gamma.fLogGamma));
        env.setPrimitive("flt64:bessel-j0", new Atom(Flt64Bessel.fBessel0));
        env.setPrimitive("flt64:bessel-j1", new Atom(Flt64Bessel.fBessel1));
        env.setPrimitive("flt64:bessel-jn", new Atom(Flt64Bessel.fBessel));
        env.setPrimitive("flt64:bessel-jn-derv", new Atom(Flt64Bessel.fBesselderv));
        env.setPrimitive("flt64:bessel-y0", new Atom(Flt64Bessel.fBessely0));
        env.setPrimitive("flt64:bessel-y1", new Atom(Flt64Bessel.fBessely1));
        env.setPrimitive("flt64:bessel-yn", new Atom(Flt64Bessel.fBessely));
        env.setPrimitive("flt64:bessel-i0", new Atom(Flt64Bessel.fBesseli0));
        env.setPrimitive("flt64:bessel-i1", new Atom(Flt64Bessel.fBesseli1));
        env.setPrimitive("flt64:bessel-k0", new Atom(Flt64Bessel.fBesselk0));
        env.setPrimitive("flt64:bessel-k1", new Atom(Flt64Bessel.fBesselk1));
        env.setPrimitive("flt64:bessel-kn", new Atom(Flt64Bessel.fBesselk));
        env.setPrimitive("flt64:airy-ai", new Atom(airy));
        env.setPrimitive("flt64:airy-ai-derv", new Atom(airyDerv));
        env.setPrimitive("flt64:fresnel-S", new Atom(Flt64Fresnel.fFresnelSine));
        env.setPrimitive("flt64:fresnel-C", new Atom(Flt64Fresnel.fFresnelCosine));
        env.setPrimitive("flt64:Si", new Atom(Flt64TrigonometricIntegral.fSi));
        env.setPrimitive("flt64:si", new Atom(Flt64TrigonometricIntegral.fsi));
        env.setPrimitive("flt64:Ci", new Atom(Flt64TrigonometricIntegral.fCi));
        env.setPrimitive("flt64:Cin", new Atom(Flt64TrigonometricIntegral.fCin));
        env.setPrimitive("flt64:Shi", new Atom(Flt64TrigonometricIntegral.fShi));
        env.setPrimitive("flt64:Chi", new Atom(Flt64TrigonometricIntegral.fChi));
        env.setPrimitive("flt64:Ei", new Atom(Flt64Ei.fEi));
        env.setPrimitive("flt64:=", new Atom(Flt64Cmp.eq));
        env.setPrimitive("flt64:/=", new Atom(Flt64Cmp.ne));
        env.setPrimitive("flt64:<", new Atom(Flt64Cmp.lt));
        env.setPrimitive("flt64:<=", new Atom(Flt64Cmp.le));
        env.setPrimitive("flt64:>", new Atom(Flt64Cmp.gt));
        env.setPrimitive("flt64:>=", new Atom(Flt64Cmp.ge));
        env.setPrimitive("flt64:e", toAtom(Math.E));
        env.setPrimitive("flt64:pi", toAtom(Math.PI));
        env.setPrimitive("flt64:euler-gamma", toAtom(0.57721566490153286060651209008240243104215933593992));
    }

    abstract static class Flt64Function extends PrimitiveFunction implements Lambda {
    }
}
