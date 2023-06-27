package palaiologos.kamilalisp.runtime.lib;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.flt64.*;
import rocks.palaiologos.maja.Complex;
import rocks.palaiologos.maja.Maja;

public class Flt64Lib {
    public static void register(Environment env) {
        env.setPrimitive("flt64:+", new Atom(new Flt64PervasiveDyadicFunction("flt64:+") {
            @Override
            public double apply(double x, double y) { return Maja.add(x, y); }
        }));
        env.setPrimitive("flt64:-", new Atom(new Flt64PervasiveDyadicFunction("flt64:-") {
            @Override
            public double apply(double x, double y) { return Maja.sub(x, y); }
        }));
        env.setPrimitive("flt64:*", new Atom(new Flt64PervasiveDyadicFunction("flt64:*") {
            @Override
            public double apply(double x, double y) { return Maja.mul(x, y); }
        }));
        env.setPrimitive("flt64:**", new Atom(new Flt64PervasiveDyadicFunction("flt64:**") {
            @Override
            public double apply(double x, double y) { return Maja.pow(x, y); }
        }));
        env.setPrimitive("flt64:/", new Atom(new Flt64PervasiveDyadicFunction("flt64:/") {
            @Override
            public double apply(double x, double y) { return Maja.div(x, y); }
        }));
        env.setPrimitive("flt64:exp", new Atom(new Flt64PervasiveMonadicFunction("flt64:exp") {
            @Override
            public double apply(double x) { return Maja.exp(x); }
        }));
        env.setPrimitive("flt64:log", new Atom(new Flt64PervasiveMonadicFunction("flt64:log") {
            @Override
            public double apply(double x) { return Maja.log(x); }
        }));
        env.setPrimitive("flt64:pow", new Atom(new Flt64PervasiveDyadicFunction("flt64:pow") {
            @Override
            public double apply(double x, double y) { return Maja.pow(x, y); }
        }));
        env.setPrimitive("flt64:sqrt", new Atom(new Flt64PervasiveMonadicFunction("flt64:sqrt") {
            @Override
            public double apply(double x) { return Maja.sqrt(x); }
        }));
        env.setPrimitive("flt64:mod", new Atom(new Flt64PervasiveDyadicFunction("flt64:mod") {
            @Override
            public double apply(double x, double y) { return Maja.mod(x, y); }
        }));
        env.setPrimitive("flt64:abs", new Atom(new Flt64PervasiveMonadicFunction("flt64:abs") {
            @Override
            public double apply(double x) { return Maja.abs(x); }
        }));
        env.setPrimitive("flt64:signum", new Atom(new Flt64PervasiveMonadicFunction("flt64:signum") {
            @Override
            public double apply(double x) { return Maja.signum(x); }
        }));
        env.setPrimitive("flt64:rem", new Atom(new Flt64PervasiveDyadicFunction("flt64:rem") {
            @Override
            public double apply(double x, double y) { return Maja.rem(x, y); }
        }));
        env.setPrimitive("flt64:asin", new Atom(new Flt64PervasiveMonadicFunction("flt64:asin") {
            @Override
            public double apply(double x) { return Maja.asin(x); }
        }));
        env.setPrimitive("flt64:acos", new Atom(new Flt64PervasiveMonadicFunction("flt64:acos") {
            @Override
            public double apply(double x) { return Maja.acos(x); }
        }));
        env.setPrimitive("flt64:atan", new Atom(new Flt64PervasiveMonadicFunction("flt64:atan") {
            @Override
            public double apply(double x) { return Maja.atan(x); }
        }));
        env.setPrimitive("flt64:atan2", new Atom(new Flt64PervasiveDyadicFunction("flt64:atan2") {
            @Override
            public double apply(double x, double y) { return Maja.atan2(x, y); }
        }));
        env.setPrimitive("flt64:cbrt", new Atom(new Flt64PervasiveMonadicFunction("flt64:cbrt") {
            @Override
            public double apply(double x) { return Maja.cbrt(x); }
        }));
        env.setPrimitive("flt64:ceil", new Atom(new Flt64PervasiveMonadicFunction("flt64:ceil") {
            @Override
            public double apply(double x) { return Maja.ceil(x); }
        }));
        env.setPrimitive("flt64:cos", new Atom(new Flt64PervasiveMonadicFunction("flt64:cos") {
            @Override
            public double apply(double x) { return Maja.cos(x); }
        }));
        env.setPrimitive("flt64:cosh", new Atom(new Flt64PervasiveMonadicFunction("flt64:cosh") {
            @Override
            public double apply(double x) { return Maja.cosh(x); }
        }));
        env.setPrimitive("flt64:expm1", new Atom(new Flt64PervasiveMonadicFunction("flt64:expm1") {
            @Override
            public double apply(double x) { return Maja.expm1(x); }
        }));
        env.setPrimitive("flt64:floor", new Atom(new Flt64PervasiveMonadicFunction("flt64:floor") {
            @Override
            public double apply(double x) { return Maja.floor(x); }
        }));
        env.setPrimitive("flt64:hypot", new Atom(new Flt64PervasiveDyadicFunction("flt64:hypot") {
            @Override
            public double apply(double x, double y) { return Maja.hypot(x, y); }
        }));
        env.setPrimitive("flt64:log2", new Atom(new Flt64PervasiveMonadicFunction("flt64:log2") {
            @Override
            public double apply(double x) { return Maja.log2(x); }
        }));
        env.setPrimitive("flt64:ln", new Atom(new Flt64PervasiveMonadicFunction("flt64:ln") {
            @Override
            public double apply(double x) { return Maja.log(x); }
        }));
        env.setPrimitive("flt64:log10", new Atom(new Flt64PervasiveMonadicFunction("flt64:log10") {
            @Override
            public double apply(double x) { return Maja.log10(x); }
        }));
        env.setPrimitive("flt64:log1p", new Atom(new Flt64PervasiveMonadicFunction("flt64:log1p") {
            @Override
            public double apply(double x) { return Maja.log1p(x); }
        }));
        env.setPrimitive("flt64:max", new Atom(new Flt64PervasiveDyadicFunction("flt64:max") {
            @Override
            public double apply(double x, double y) { return Maja.max(x, y); }
        }));
        env.setPrimitive("flt64:min", new Atom(new Flt64PervasiveDyadicFunction("flt64:min") {
            @Override
            public double apply(double x, double y) { return Maja.min(x, y); }
        }));
        env.setPrimitive("flt64:sin", new Atom(new Flt64PervasiveMonadicFunction("flt64:sin") {
            @Override
            public double apply(double x) { return Maja.sin(x); }
        }));
        env.setPrimitive("flt64:sinc", new Atom(new Flt64PervasiveMonadicFunction("flt64:sinc") {
            @Override
            public double apply(double x) { return Maja.sinc(x); }
        }));
        env.setPrimitive("flt64:sinh", new Atom(new Flt64PervasiveMonadicFunction("flt64:sinh") {
            @Override
            public double apply(double x) { return Maja.sinh(x); }
        }));
        env.setPrimitive("flt64:tan", new Atom(new Flt64PervasiveMonadicFunction("flt64:tan") {
            @Override
            public double apply(double x) { return Maja.tan(x); }
        }));
        env.setPrimitive("flt64:tanh", new Atom(new Flt64PervasiveMonadicFunction("flt64:tanh") {
            @Override
            public double apply(double x) { return Maja.tanh(x); }
        }));
        env.setPrimitive("flt64:to-degrees", new Atom(new Flt64PervasiveMonadicFunction("flt64:to-degrees") {
            @Override
            public double apply(double x) { return Maja.toDegrees(x); }
        }));
        env.setPrimitive("flt64:to-radians", new Atom(new Flt64PervasiveMonadicFunction("flt64:to-radians") {
            @Override
            public double apply(double x) { return Maja.toRadians(x); }
        }));
        env.setPrimitive("flt64:ulp", new Atom(new Flt64PervasiveMonadicFunction("flt64:ulp") {
            @Override
            public double apply(double x) { return Maja.ulp(x); }
        }));
        env.setPrimitive("flt64:fma", new Atom(new Flt64TriadicFunction("flt64:fma") {
            @Override
            public double apply(double x, double y, double z) { return Maja.fma(x, y, z); }
        }));
        env.setPrimitive("flt64:next-after", new Atom(new Flt64TriadicFunction("flt64:next-after") {
            @Override
            public double apply(double x, double y, double z) { return Maja.nextAfter(x, y); }
        }));
        env.setPrimitive("flt64:next-up", new Atom(new Flt64PervasiveMonadicFunction("flt64:next-up") {
            @Override
            public double apply(double x) { return Maja.nextUp(x); }
        }));
        env.setPrimitive("flt64:next-down", new Atom(new Flt64PervasiveMonadicFunction("flt64:next-down") {
            @Override
            public double apply(double x) { return Maja.nextDown(x); }
        }));
        env.setPrimitive("flt64:scalb", new Atom(new Flt64PervasiveDyadicFunction("flt64:scalb") {
            @Override
            public double apply(double x, double y) { return Maja.scalb(x, (int)y); }
        }));
        env.setPrimitive("flt64:copy-sign", new Atom(new Flt64PervasiveDyadicFunction("flt64:copy-sign") {
            @Override
            public double apply(double x, double y) { return Maja.copySign(x, y); }
        }));
        env.setPrimitive("flt64:get-exponent", new Atom(new Flt64PervasiveMonadicFunction("flt64:get-exponent") {
            @Override
            public double apply(double x) { return Maja.getExponent(x); }
        }));
        env.setPrimitive("flt64:round", new Atom(new Flt64PervasiveMonadicFunction("flt64:round") {
            @Override
            public double apply(double x) { return Maja.round(x); }
        }));
        env.setPrimitive("flt64:random-zero", new Atom(new Flt64PervasiveMonadicFunction("flt64:random-zero") {
            @Override
            public double apply(double x) { return Maja.random(x); }
        }));
        env.setPrimitive("flt64:random-range", new Atom(new Flt64PervasiveDyadicFunction("flt64:random-range") {
            @Override
            public double apply(double x, double y) { return Maja.random(x, y); }
        }));
        env.setPrimitive("flt64:lt", new Atom(new Flt64PervasiveDyadicComparator("flt64:lt") {
            @Override
            public boolean apply(double x, double y) { return Maja.lt(x, y); }
        }));
        env.setPrimitive("flt64:le", new Atom(new Flt64PervasiveDyadicComparator("flt64:le") {
            @Override
            public boolean apply(double x, double y) { return Maja.le(x, y); }
        }));
        env.setPrimitive("flt64:eq", new Atom(new Flt64PervasiveDyadicComparator("flt64:eq") {
            @Override
            public boolean apply(double x, double y) { return Maja.eq(x, y); }
        }));
        env.setPrimitive("flt64:ne", new Atom(new Flt64PervasiveDyadicComparator("flt64:ne") {
            @Override
            public boolean apply(double x, double y) { return Maja.ne(x, y); }
        }));
        env.setPrimitive("flt64:ge", new Atom(new Flt64PervasiveDyadicComparator("flt64:ge") {
            @Override
            public boolean apply(double x, double y) { return Maja.ge(x, y); }
        }));
        env.setPrimitive("flt64:gt", new Atom(new Flt64PervasiveDyadicComparator("flt64:gt") {
            @Override
            public boolean apply(double x, double y) { return Maja.gt(x, y); }
        }));
        env.setPrimitive("flt64:is-nan", new Atom(new Flt64PervasiveMonadicFunction("flt64:is-nan") {
            @Override
            public double apply(double x) { return Double.isNaN(x) ? 1.0 : 0.0; }
        }));
        env.setPrimitive("flt64:is-infinite", new Atom(new Flt64PervasiveMonadicFunction("flt64:is-infinite") {
            @Override
            public double apply(double x) { return Double.isInfinite(x) ? 1.0 : 0.0; }
        }));
        env.setPrimitive("flt64:is-finite", new Atom(new Flt64PervasiveMonadicFunction("flt64:is-finite") {
            @Override
            public double apply(double x) { return Double.isFinite(x) ? 1.0 : 0.0; }
        }));
        env.setPrimitive("flt64:compare", new Atom(new Flt64PervasiveDyadicFunction("flt64:compare") {
            @Override
            public double apply(double x, double y) { return Maja.compare(x, y); }
        }));
        env.setPrimitive("flt64:linear-map", new Atom(new Flt64QuinticFunction("flt64:linear-map") {
            @Override
            public double apply(double u, double w, double x, double y, double z) {
                return Maja.linearMap(u, w, x, y, z);
            }
        }));
        env.setPrimitive("flt64:linear-norm", new Atom(new Flt64TriadicFunction("flt64:linear-norm") {
            @Override
            public double apply(double x, double y, double z) {
                return Maja.linearNorm(x, y, z);
            }
        }));
        env.setPrimitive("flt64:linear-interpolate", new Atom(new Flt64TriadicFunction("flt64:linear-interpolate") {
            @Override
            public double apply(double x, double y, double z) {
                return Maja.linearInterpolate(x, y, z);
            }
        }));
        env.setPrimitive("flt64:clamp", new Atom(new Flt64TriadicFunction("flt64:clamp") {
            @Override
            public double apply(double x, double y, double z) {
                return Maja.clamp(x, y, z);
            }
        }));
        env.setPrimitive("flt64:airy-ai", new Atom(new Flt64PervasiveMonadicFunction("flt64:airy-ai") {
            @Override
            public double apply(double x) { return Maja.airyAi(x); }
        }));
        env.setPrimitive("flt64:airy-bi", new Atom(new Flt64PervasiveMonadicFunction("flt64:airy-bi") {
            @Override
            public double apply(double x) { return Maja.airyBi(x); }
        }));
        env.setPrimitive("flt64:airy-aip", new Atom(new Flt64PervasiveMonadicFunction("flt64:airy-aip") {
            @Override
            public double apply(double x) { return Maja.airyAip(x); }
        }));
        env.setPrimitive("flt64:airy-bip", new Atom(new Flt64PervasiveMonadicFunction("flt64:airy-bip") {
            @Override
            public double apply(double x) { return Maja.airyBip(x); }
        }));
        env.setPrimitive("flt64:gamma", new Atom(new Flt64PervasiveMonadicFunction("flt64:gamma") {
            @Override
            public double apply(double x) { return Maja.gamma(x); }
        }));
        env.setPrimitive("flt64:log-gamma", new Atom(new Flt64PervasiveMonadicFunction("flt64:log-gamma") {
            @Override
            public double apply(double x) { return Maja.loggamma(x); }
        }));
        env.setPrimitive("flt64:digamma", new Atom(new Flt64PervasiveMonadicFunction("flt64:digamma") {
            @Override
            public double apply(double x) { return Maja.digamma(x); }
        }));
        env.setPrimitive("flt64:trigamma", new Atom(new Flt64PervasiveMonadicFunction("flt64:trigamma") {
            @Override
            public double apply(double x) { return Maja.trigamma(x); }
        }));
        env.setPrimitive("flt64:ui-gamma", new Atom(new Flt64PervasiveDyadicFunction("flt64:ui-gamma") {
            @Override
            public double apply(double x, double y) { return Maja.uiGamma(x, y); }
        }));
        env.setPrimitive("flt64:li-gamma", new Atom(new Flt64PervasiveDyadicFunction("flt64:li-gamma") {
            @Override
            public double apply(double x, double y) { return Maja.liGamma(x, y); }
        }));
        env.setPrimitive("flt64:pochhammer", new Atom(new Flt64PervasiveDyadicFunction("flt64:pochhammer") {
            @Override
            public double apply(double x, double y) { return Maja.pochhammer(x, y); }
        }));
        env.setPrimitive("flt64:Ei", new Atom(new Flt64PervasiveMonadicFunction("flt64:Ei") {
            @Override
            public double apply(double x) { return Maja.Ei(x); }
        }));
        env.setPrimitive("flt64:riemann-zeta", new Atom(new Flt64PervasiveMonadicFunction("flt64:riemann-zeta") {
            @Override
            public double apply(double x) { return Maja.zeta(x); }
        }));
        env.setPrimitive("flt64:hurwitz-zeta", new Atom(new Flt64PervasiveDyadicFunction("flt64:hurwitz-zeta") {
            @Override
            public double apply(double x, double y) { return Maja.hurwitzZeta(x, y); }
        }));
        env.setPrimitive("flt64:polygamma", new Atom(new Flt64PervasiveDyadicFunction("flt64:polygamma") {
            @Override
            public double apply(double x, double y) { return Maja.polygamma(x, y); }
        }));
        env.setPrimitive("flt64:beta", new Atom(new Flt64PervasiveDyadicFunction("flt64:beta") {
            @Override
            public double apply(double x, double y) { return Maja.beta(x, y); }
        }));
        env.setPrimitive("flt64:log-beta", new Atom(new Flt64PervasiveDyadicFunction("flt64:log-beta") {
            @Override
            public double apply(double x, double y) { return Maja.logbeta(x, y); }
        }));
        env.setPrimitive("flt64:dilog", new Atom(new Flt64PervasiveMonadicFunction("flt64:dilog") {
            @Override
            public double apply(double x) { return Maja.dilog(x); }
        }));
        env.setPrimitive("flt64:spence", new Atom(new Flt64PervasiveMonadicFunction("flt64:spence") {
            @Override
            public double apply(double x) { return Maja.spence(x); }
        }));
        env.setPrimitive("flt64:polylog", new Atom(new Flt64PervasiveDyadicFunction("flt64:polylog") {
            @Override
            public double apply(double x, double y) { return Maja.polylog((int) x, y); }
        }));
        env.setPrimitive("flt64:sec", new Atom(new Flt64PervasiveMonadicFunction("flt64:sec") {
            @Override
            public double apply(double x) { return Maja.sec(x); }
        }));
        env.setPrimitive("flt64:csc", new Atom(new Flt64PervasiveMonadicFunction("flt64:csc") {
            @Override
            public double apply(double x) { return Maja.csc(x); }
        }));
        env.setPrimitive("flt64:cot", new Atom(new Flt64PervasiveMonadicFunction("flt64:cot") {
            @Override
            public double apply(double x) { return Maja.cot(x); }
        }));
        env.setPrimitive("flt64:sech", new Atom(new Flt64PervasiveMonadicFunction("flt64:sech") {
            @Override
            public double apply(double x) { return Maja.sech(x); }
        }));
        env.setPrimitive("flt64:csch", new Atom(new Flt64PervasiveMonadicFunction("flt64:csch") {
            @Override
            public double apply(double x) { return Maja.csch(x); }
        }));
        env.setPrimitive("flt64:coth", new Atom(new Flt64PervasiveMonadicFunction("flt64:coth") {
            @Override
            public double apply(double x) { return Maja.coth(x); }
        }));
        env.setPrimitive("flt64:asec", new Atom(new Flt64PervasiveMonadicFunction("flt64:asec") {
            @Override
            public double apply(double x) { return Maja.asec(x); }
        }));
        env.setPrimitive("flt64:acsc", new Atom(new Flt64PervasiveMonadicFunction("flt64:acsc") {
            @Override
            public double apply(double x) { return Maja.acsc(x); }
        }));
        env.setPrimitive("flt64:acot", new Atom(new Flt64PervasiveMonadicFunction("flt64:acot") {
            @Override
            public double apply(double x) { return Maja.acot(x); }
        }));
        env.setPrimitive("flt64:asinh", new Atom(new Flt64PervasiveMonadicFunction("flt64:asinh") {
            @Override
            public double apply(double x) { return Maja.asinh(x); }
        }));
        env.setPrimitive("flt64:acosh", new Atom(new Flt64PervasiveMonadicFunction("flt64:acosh") {
            @Override
            public double apply(double x) { return Maja.acosh(x); }
        }));
        env.setPrimitive("flt64:atanh", new Atom(new Flt64PervasiveMonadicFunction("flt64:atanh") {
            @Override
            public double apply(double x) { return Maja.atanh(x); }
        }));
        env.setPrimitive("flt64:asech", new Atom(new Flt64PervasiveMonadicFunction("flt64:asech") {
            @Override
            public double apply(double x) { return Maja.asech(x); }
        }));
        env.setPrimitive("flt64:acsch", new Atom(new Flt64PervasiveMonadicFunction("flt64:acsch") {
            @Override
            public double apply(double x) { return Maja.acsch(x); }
        }));
        env.setPrimitive("flt64:acoth", new Atom(new Flt64PervasiveMonadicFunction("flt64:acoth") {
            @Override
            public double apply(double x) { return Maja.acoth(x); }
        }));
        env.setPrimitive("flt64:lambert-w0", new Atom(new Flt64PervasiveMonadicFunction("flt64:lambert-w0") {
            @Override
            public double apply(double x) { return Maja.lambertW0(x); }
        }));
        env.setPrimitive("flt64:lambert-wm1", new Atom(new Flt64PervasiveMonadicFunction("flt64:lambert-wm1") {
            @Override
            public double apply(double x) { return Maja.lambertWm1(x); }
        }));
        env.setPrimitive("flt64:lerch-phi", new Atom(new Flt64TriadicFunction("flt64:lerch-phi") {
            @Override
            public double apply(double x, double y, double z) { return Maja.lerchPhi(x, y, z); }
        }));
        env.setPrimitive("flt64:dawson+", new Atom(new Flt64PervasiveMonadicFunction("flt64:dawson+") {
            @Override
            public double apply(double x) { return Maja.dawsonPlus(x); }
        }));
        env.setPrimitive("flt64:dawson-", new Atom(new Flt64PervasiveMonadicFunction("flt64:dawson-") {
            @Override
            public double apply(double x) { return Maja.dawsonMinus(x); }
        }));
        env.setPrimitive("flt64:erf", new Atom(new Flt64PervasiveMonadicFunction("flt64:erf") {
            @Override
            public double apply(double x) { return Maja.erf(x); }
        }));
        env.setPrimitive("flt64:erfc", new Atom(new Flt64PervasiveMonadicFunction("flt64:erfc") {
            @Override
            public double apply(double x) { return Maja.erfc(x); }
        }));
        env.setPrimitive("flt64:erfi", new Atom(new Flt64PervasiveMonadicFunction("flt64:erfi") {
            @Override
            public double apply(double x) { return Maja.erfi(x); }
        }));
        env.setPrimitive("flt64:stretch", new Atom(new Flt64PervasiveMonadicFunction("flt64:stretch") {
            @Override
            public double apply(double x) { return Maja.stretch(x); }
        }));
        env.setPrimitive("flt64:squash", new Atom(new Flt64PervasiveMonadicFunction("flt64:squash") {
            @Override
            public double apply(double x) { return Maja.squash(x); }
        }));
        env.setPrimitive("flt64:Si", new Atom(new Flt64PervasiveMonadicFunction("flt64:Si") {
            @Override
            public double apply(double x) { return Maja.Si(x); }
        }));
        env.setPrimitive("flt64:Ci", new Atom(new Flt64PervasiveMonadicFunction("flt64:Ci") {
            @Override
            public double apply(double x) { return Maja.Ci(x); }
        }));
        env.setPrimitive("flt64:si", new Atom(new Flt64PervasiveMonadicFunction("flt64:si") {
            @Override
            public double apply(double x) { return Maja.si(x); }
        }));
        env.setPrimitive("flt64:Cin", new Atom(new Flt64PervasiveMonadicFunction("flt64:Cin") {
            @Override
            public double apply(double x) { return Maja.Cin(x); }
        }));
        env.setPrimitive("flt64:Shi", new Atom(new Flt64PervasiveMonadicFunction("flt64:Shi") {
            @Override
            public double apply(double x) { return Maja.Shi(x); }
        }));
        env.setPrimitive("flt64:Chi", new Atom(new Flt64PervasiveMonadicFunction("flt64:Chi") {
            @Override
            public double apply(double x) { return Maja.Chi(x); }
        }));
        env.setPrimitive("flt64:fresnel-C", new Atom(new Flt64PervasiveMonadicFunction("flt64:fresnel-C") {
            @Override
            public double apply(double x) { return Maja.fresnelC(x); }
        }));
        env.setPrimitive("flt64:fresnel-S", new Atom(new Flt64PervasiveMonadicFunction("flt64:fresnel-S") {
            @Override
            public double apply(double x) { return Maja.fresnelS(x); }
        }));
        env.setPrimitive("flt64:bessel-Y0", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-Y0") {
            @Override
            public double apply(double x) { return Maja.besselY0(x); }
        }));
        env.setPrimitive("flt64:bessel-Y1", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-Y1") {
            @Override
            public double apply(double x) { return Maja.besselY1(x); }
        }));
        env.setPrimitive("flt64:bessel-Yn", new Atom(new Flt64PervasiveDyadicFunction("flt64:bessel-Yn") {
            @Override
            public double apply(double x, double y) {
                return Maja.besselYn((int) x, y);
            }
        }));
        env.setPrimitive("flt64:bessel-J0", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-J0") {
            @Override
            public double apply(double x) { return Maja.besselJ0(x); }
        }));
        env.setPrimitive("flt64:bessel-J1", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-J1") {
            @Override
            public double apply(double x) { return Maja.besselJ1(x); }
        }));
        env.setPrimitive("flt64:bessel-Jn", new Atom(new Flt64PervasiveDyadicFunction("flt64:bessel-Jn") {
            @Override
            public double apply(double x, double y) {
                return Maja.besselJn((int) x, y);
            }
        }));
        env.setPrimitive("flt64:bessel-I0", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-I0") {
            @Override
            public double apply(double x) { return Maja.besselI0(x); }
        }));
        env.setPrimitive("flt64:bessel-I1", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-I1") {
            @Override
            public double apply(double x) { return Maja.besselI1(x); }
        }));
        env.setPrimitive("flt64:bessel-K0", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-K0") {
            @Override
            public double apply(double x) { return Maja.besselK0(x); }
        }));
        env.setPrimitive("flt64:bessel-K1", new Atom(new Flt64PervasiveMonadicFunction("flt64:bessel-K1") {
            @Override
            public double apply(double x) { return Maja.besselK1(x); }
        }));
        env.setPrimitive("flt64:bessel-Kn", new Atom(new Flt64PervasiveDyadicFunction("flt64:bessel-Kn") {
            @Override
            public double apply(double x, double y) {
                return Maja.besselKn((int) x, y);
            }
        }));
        env.setPrimitive("flt64:gcd", new Atom(new Flt64PervasiveDyadicFunction("flt64:gcd") {
            @Override
            public double apply(double x, double y) {
                return Maja.gcd(x, y);
            }
        }));
        env.setPrimitive("flt64:lcm", new Atom(new Flt64PervasiveDyadicFunction("flt64:lcm") {
            @Override
            public double apply(double x, double y) {
                return Maja.lcm(x, y);
            }
        }));
        env.setPrimitive("flt64:fib", new Atom(new Flt64PervasiveMonadicFunction("flt64:fib") {
            @Override
            public double apply(double x) {
                return Maja.fib((int) x);
            }
        }));
        env.setPrimitive("flt64:hypergeo-2F1", new Atom(new Flt64QuarticFunction("flt64:hypergeo-2F1") {
            @Override
            public double apply(double a, double b, double c, double x) {
                return Maja.hypergeo2F1(a, b, c, x);
            }
        }));
        env.setPrimitive("flt64:hypergeo-1F1", new Atom(new Flt64TriadicFunction("flt64:hypergeo-1F1") {
            @Override
            public double apply(double a, double b, double x) {
                return Maja.hypergeo1F1(a, b, x);
            }
        }));
        env.setPrimitive("flt64:hypergeo-1F2", new Atom(new Flt64QuarticFunction("flt64:hypergeo-1F2") {
            @Override
            public double apply(double a, double b, double c, double x) {
                return Maja.hypergeo1F2(a, b, c, x);
            }
        }));
        env.setPrimitive("flt64:hypergeo-3F0", new Atom(new Flt64QuarticFunction("flt64:hypergeo-3F0") {
            @Override
            public double apply(double a, double b, double c, double x) {
                return Maja.hypergeo3F0(a, b, c, x);
            }
        }));
        env.setPrimitive("flt64:struve", new Atom(new Flt64PervasiveDyadicFunction("flt64:struve") {
            @Override
            public double apply(double x, double y) {
                return Maja.struve(x, y);
            }
        }));
        env.setPrimitive("flt64:bessel-Jv", new Atom(new Flt64PervasiveDyadicFunction("flt64:bessel-Jv") {
            @Override
            public double apply(double x, double y) {
                return Maja.besselJv(x, y);
            }
        }));
        env.setPrimitive("flt64:bessel-Yv", new Atom(new Flt64PervasiveDyadicFunction("flt64:bessel-Yv") {
            @Override
            public double apply(double x, double y) {
                return Maja.besselYv(x, y);
            }
        }));
        env.setPrimitive("flt64:e", new Atom(new Flt64PervasiveMonadicFunction("flt64:e") {
            @Override
            public double apply(double x) {
                return Maja.E * x;
            }

            @Override
            public double apply() {
                return Maja.E;
            }
        }));
        env.setPrimitive("flt64:pi", new Atom(new Flt64PervasiveMonadicFunction("flt64:pi") {
            @Override
            public double apply(double x) {
                return Maja.PI * x;
            }

            @Override
            public double apply() {
                return Maja.PI;
            }
        }));
        env.setPrimitive("flt64:ln2", Flt64AtomThunk.toAtom(Maja.LN2));
        env.setPrimitive("flt64:ln10", Flt64AtomThunk.toAtom(Maja.LN10));
        env.setPrimitive("flt64:log2e", Flt64AtomThunk.toAtom(Maja.LOG2E));
        env.setPrimitive("flt64:epsilon", Flt64AtomThunk.toAtom(Maja.EPSILON));
        env.setPrimitive("flt64:euler-gamma", Flt64AtomThunk.toAtom(Maja.EULER_GAMMA));
        env.setPrimitive("flt64:golden-ratio", Flt64AtomThunk.toAtom(Maja.GOLDEN_RATIO));
        env.setPrimitive("flt64:apery-constant", Flt64AtomThunk.toAtom(Maja.APERY_CONSTANT));
        env.setPrimitive("flt64:mills-constant", Flt64AtomThunk.toAtom(Maja.MILLS_CONSTANT));
        env.setPrimitive("flt64:catalan-constant", Flt64AtomThunk.toAtom(Maja.CATALAN_CONSTANT));
        env.setPrimitive("flt64:glaisher-constant", Flt64AtomThunk.toAtom(Maja.GLAISHER_CONSTANT));
        env.setPrimitive("flt64:khinchin-constant", Flt64AtomThunk.toAtom(Maja.KHINCHIN_CONSTANT));

        env.setPrimitive("flt64:LU", new Atom(new Flt64LU()));
        env.setPrimitive("flt64:PLU", new Atom(new Flt64PLU()));
        env.setPrimitive("flt64:det", new Atom(new Flt64Det()));
        env.setPrimitive("flt64:permanent", new Atom(new Flt64Permanent()));
        env.setPrimitive("flt64:invert", new Atom(new Flt64Inv()));
        env.setPrimitive("flt64:trace", new Atom(new Flt64Trace()));
        env.setPrimitive("flt64:solve", new Atom(new Flt64Solve()));

        // Complex numbers from the cmplx64 package.
        env.setPrimitive("cmplx64:ceil", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:ceil") {
            @Override
            public Complex apply(Complex x) { return Maja.ceil(x); }
        }));
        env.setPrimitive("cmplx64:floor", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:floor") {
            @Override
            public Complex apply(Complex x) { return Maja.floor(x); }
        }));
        env.setPrimitive("cmplx64:round", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:round") {
            @Override
            public Complex apply(Complex x) { return Maja.round(x); }
        }));
        env.setPrimitive("cmplx64:sinc", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:sinc") {
            @Override
            public Complex apply(Complex x) { return Maja.sinc(x); }
        }));
        env.setPrimitive("cmplx64:fma", new Atom(new Cmplx64TriadicFunction("cmplx64:fma") {
            @Override
            public Complex apply(Complex x, Complex y, Complex z) { return Maja.fma(x, y, z); }
        }));
        env.setPrimitive("cmplx64:pochhammer", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:pochhammer") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.pochhammer(x, y); }
        }));
        env.setPrimitive("cmplx64:zeta", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:zeta") {
            @Override
            public Complex apply(Complex x) { return Maja.zeta(x); }
        }));
        env.setPrimitive("cmplx64:polygamma", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:polygamma") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.polygamma(x, y); }
        }));
        env.setPrimitive("cmplx64:gcd", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:gcd") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.gcd(x, y); }
        }));
        env.setPrimitive("cmplx64:lcm", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:lcm") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.lcm(x, y); }
        }));
        env.setPrimitive("cmplx64:rem", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:rem") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.rem(x, y); }
        }));
        env.setPrimitive("cmplx64:+", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:+") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.add(x, y); }
        }));
        env.setPrimitive("cmplx64:-", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:-") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.sub(x, y); }
        }));
        env.setPrimitive("cmplx64:*", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:*") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.mul(x, y); }
        }));
        env.setPrimitive("cmplx64:**", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:**") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.pow(x, y); }
        }));
        env.setPrimitive("cmplx64:/", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:/") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.div(x, y); }
        }));
        env.setPrimitive("cmplx64:conj", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:conj") {
            @Override
            public Complex apply(Complex x) { return Maja.conj(x); }
        }));
        env.setPrimitive("cmplx64:abs", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:abs") {
            @Override
            public Complex apply(Complex x) { return new Complex(Maja.abs(x)); }
        }));
        env.setPrimitive("cmplx64:sqrt", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:sqrt") {
            @Override
            public Complex apply(Complex x) { return Maja.sqrt(x); }
        }));
        env.setPrimitive("cmplx64:exp", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:exp") {
            @Override
            public Complex apply(Complex x) { return Maja.exp(x); }
        }));
        env.setPrimitive("cmplx64:log", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:log") {
            @Override
            public Complex apply(Complex x) { return Maja.log(x); }
        }));
        env.setPrimitive("cmplx64:arg", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:arg") {
            @Override
            public Complex apply(Complex x) { return new Complex(Maja.arg(x)); }
        }));
        env.setPrimitive("cmplx64:=", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:=") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.eq(x, y) ? Complex.ONE : Complex.ZERO; }
        }));
        env.setPrimitive("cmplx64:/=", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:/=") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.ne(x, y) ? Complex.ONE : Complex.ZERO; }
        }));
        env.setPrimitive("cmplx64:cbrt", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:cbrt") {
            @Override
            public Complex apply(Complex x) { return Maja.cbrt(x); }
        }));
        env.setPrimitive("cmplx64:asin", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:asin") {
            @Override
            public Complex apply(Complex x) { return Maja.asin(x); }
        }));
        env.setPrimitive("cmplx64:acos", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:acos") {
            @Override
            public Complex apply(Complex x) { return Maja.acos(x); }
        }));
        env.setPrimitive("cmplx64:atan", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:atan") {
            @Override
            public Complex apply(Complex x) { return Maja.atan(x); }
        }));
        env.setPrimitive("cmplx64:asinh", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:asinh") {
            @Override
            public Complex apply(Complex x) { return Maja.asinh(x); }
        }));
        env.setPrimitive("cmplx64:acosh", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:acosh") {
            @Override
            public Complex apply(Complex x) { return Maja.acosh(x); }
        }));
        env.setPrimitive("cmplx64:atanh", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:atanh") {
            @Override
            public Complex apply(Complex x) { return Maja.atanh(x); }
        }));
        env.setPrimitive("cmplx64:sin", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:sin") {
            @Override
            public Complex apply(Complex x) { return Maja.sin(x); }
        }));
        env.setPrimitive("cmplx64:cos", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:cos") {
            @Override
            public Complex apply(Complex x) { return Maja.cos(x); }
        }));
        env.setPrimitive("cmplx64:tan", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:tan") {
            @Override
            public Complex apply(Complex x) { return Maja.tan(x); }
        }));
        env.setPrimitive("cmplx64:sinh", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:sinh") {
            @Override
            public Complex apply(Complex x) { return Maja.sinh(x); }
        }));
        env.setPrimitive("cmplx64:cosh", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:cosh") {
            @Override
            public Complex apply(Complex x) { return Maja.cosh(x); }
        }));
        env.setPrimitive("cmplx64:tanh", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:tanh") {
            @Override
            public Complex apply(Complex x) { return Maja.tanh(x); }
        }));
        env.setPrimitive("cmplx64:sec", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:sec") {
            @Override
            public Complex apply(Complex x) { return Maja.sec(x); }
        }));
        env.setPrimitive("cmplx64:csc", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:csc") {
            @Override
            public Complex apply(Complex x) { return Maja.csc(x); }
        }));
        env.setPrimitive("cmplx64:cot", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:cot") {
            @Override
            public Complex apply(Complex x) { return Maja.cot(x); }
        }));
        env.setPrimitive("cmplx64:sech", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:sech") {
            @Override
            public Complex apply(Complex x) { return Maja.sech(x); }
        }));
        env.setPrimitive("cmplx64:csch", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:csch") {
            @Override
            public Complex apply(Complex x) { return Maja.csch(x); }
        }));
        env.setPrimitive("cmplx64:coth", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:coth") {
            @Override
            public Complex apply(Complex x) { return Maja.coth(x); }
        }));
        env.setPrimitive("cmplx64:asec", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:asec") {
            @Override
            public Complex apply(Complex x) { return Maja.asec(x); }
        }));
        env.setPrimitive("cmplx64:acsc", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:acsc") {
            @Override
            public Complex apply(Complex x) { return Maja.acsc(x); }
        }));
        env.setPrimitive("cmplx64:acot", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:acot") {
            @Override
            public Complex apply(Complex x) { return Maja.acot(x); }
        }));
        env.setPrimitive("cmplx64:asech", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:asech") {
            @Override
            public Complex apply(Complex x) { return Maja.asech(x); }
        }));
        env.setPrimitive("cmplx64:acsch", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:acsch") {
            @Override
            public Complex apply(Complex x) { return Maja.acsch(x); }
        }));
        env.setPrimitive("cmplx64:acoth", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:acoth") {
            @Override
            public Complex apply(Complex x) { return Maja.acoth(x); }
        }));
        env.setPrimitive("cmplx64:pow", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:pow") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.pow(x, y); }
        }));
        env.setPrimitive("cmplx64:neg", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:neg") {
            @Override
            public Complex apply(Complex x) { return Maja.negate(x); }
        }));
        // gamma, beta, airy.
        env.setPrimitive("cmplx64:gamma", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:gamma") {
            @Override
            public Complex apply(Complex x) { return Maja.gamma(x); }
        }));
        env.setPrimitive("cmplx64:beta", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:beta") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.beta(x, y); }
        }));
        env.setPrimitive("cmplx64:airy-ai", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:airy-ai") {
            @Override
            public Complex apply(Complex x) { return Maja.airyAi(x); }
        }));
        env.setPrimitive("cmplx64:airy-bi", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:airy-bi") {
            @Override
            public Complex apply(Complex x) { return Maja.airyBi(x); }
        }));
        env.setPrimitive("cmplx64:airy-aip", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:airy-aip") {
            @Override
            public Complex apply(Complex x) { return Maja.airyAip(x); }
        }));
        env.setPrimitive("cmplx64:airy-bip", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:airy-bip") {
            @Override
            public Complex apply(Complex x) { return Maja.airyBip(x); }
        }));
        env.setPrimitive("cmplx64:e1", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:e1") {
            @Override
            public Complex apply(Complex x) { return Maja.e1(x); }
        }));
        env.setPrimitive("cmplx64:ei", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:ei") {
            @Override
            public Complex apply(Complex x) { return Maja.Ei(x); }
        }));
        env.setPrimitive("cmplx64:ein", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:ein") {
            @Override
            public Complex apply(Complex x) { return Maja.Ein(x); }
        }));
        env.setPrimitive("cmplx64:loggamma", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:loggamma") {
            @Override
            public Complex apply(Complex x) { return Maja.loggamma(x); }
        }));
        env.setPrimitive("cmplx64:logbeta", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:logbeta") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.logbeta(x, y); }
        }));
        env.setPrimitive("cmplx64:ligamma", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:ligamma") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.liGamma(x, y); }
        }));
        env.setPrimitive("cmplx64:uigamma", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:uigamma") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.uiGamma(x, y); }
        }));
        env.setPrimitive("cmplx64:erf", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:erf") {
            @Override
            public Complex apply(Complex x) { return Maja.erf(x); }
        }));
        env.setPrimitive("cmplx64:erfc", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:erfc") {
            @Override
            public Complex apply(Complex x) { return Maja.erfc(x); }
        }));
        env.setPrimitive("cmplx64:erfi", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:erfi") {
            @Override
            public Complex apply(Complex x) { return Maja.erfi(x); }
        }));
        env.setPrimitive("cmplx64:dawson+", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:dawson+") {
            @Override
            public Complex apply(Complex x) { return Maja.dawsonPlus(x); }
        }));
        env.setPrimitive("cmplx64:dawson-", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:dawson-") {
            @Override
            public Complex apply(Complex x) { return Maja.dawsonMinus(x); }
        }));
        env.setPrimitive("cmplx64:fresnelS", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:fresnelS") {
            @Override
            public Complex apply(Complex x) { return Maja.fresnelS(x); }
        }));
        env.setPrimitive("cmplx64:fresnelC", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:fresnelC") {
            @Override
            public Complex apply(Complex x) { return Maja.fresnelC(x); }
        }));
        env.setPrimitive("cmplx64:digamma", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:digamma") {
            @Override
            public Complex apply(Complex x) { return Maja.digamma(x); }
        }));
        env.setPrimitive("cmplx64:trigamma", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:trigamma") {
            @Override
            public Complex apply(Complex x) { return Maja.trigamma(x); }
        }));
        env.setPrimitive("cmplx64:li", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:li") {
            @Override
            public Complex apply(Complex x) { return Maja.li(x); }
        }));
        env.setPrimitive("cmplx64:si", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:si") {
            @Override
            public Complex apply(Complex x) { return Maja.si(x); }
        }));
        env.setPrimitive("cmplx64:Ci", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:Ci") {
            @Override
            public Complex apply(Complex x) { return Maja.Ci(x); }
        }));
        env.setPrimitive("cmplx64:Si", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:Si") {
            @Override
            public Complex apply(Complex x) { return Maja.Si(x); }
        }));
        env.setPrimitive("cmplx64:Cin", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:Cin") {
            @Override
            public Complex apply(Complex x) { return Maja.Cin(x); }
        }));
        env.setPrimitive("cmplx64:Shi", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:Shi") {
            @Override
            public Complex apply(Complex x) { return Maja.Shi(x); }
        }));
        env.setPrimitive("cmplx64:Chi", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:Chi") {
            @Override
            public Complex apply(Complex x) { return Maja.Chi(x); }
        }));
        env.setPrimitive("cmplx64:En", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:En") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.en(x, y); }
        }));
        // hurwitz zeta,dilog, spence, polylog, lerchphi, lambertw, chop
        env.setPrimitive("cmplx64:hurwitz-zeta", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:hurwitz-zeta") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.hurwitzZeta(x, y); }
        }));
        env.setPrimitive("cmplx64:dilog", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:dilog") {
            @Override
            public Complex apply(Complex x) { return Maja.dilog(x); }
        }));
        env.setPrimitive("cmplx64:spence", new Atom(new Cmplx64PervasiveMonadicFunction("cmplx64:spence") {
            @Override
            public Complex apply(Complex x) { return Maja.spence(x); }
        }));
        env.setPrimitive("cmplx64:polylog", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:polylog") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.polylog(x, y); }
        }));
        env.setPrimitive("cmplx64:lerchphi", new Atom(new Cmplx64TriadicFunction("cmplx64:lerchphi") {
            @Override
            public Complex apply(Complex x, Complex y, Complex z) { return Maja.lerchPhi(x, y, z); }
        }));
        env.setPrimitive("cmplx64:lambertw", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:lambertw") {
            @Override
            public Complex apply(Complex x, Complex y) {
                int order = (int) x.re();
                if(x.im() != 0 || x.re() != Math.floor(x.re()) || order < 0)
                    throw new IllegalArgumentException("lambertw: order must be a non-negative integer");
                return Maja.lambertw(y, order);
            }
        }));
        env.setPrimitive("cmplx64:legendre-F", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:legendre-F") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.legendreF(x, y); }
        }));
        env.setPrimitive("cmplx64:legendre-E", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:legendre-E") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.legendreE(x, y); }
        }));
        env.setPrimitive("cmplx64:legendre-D", new Atom(new Cmplx64PervasiveDyadicFunction("cmplx64:legendre-D") {
            @Override
            public Complex apply(Complex x, Complex y) { return Maja.legendreD(x, y); }
        }));
        env.setPrimitive("cmplx64:legendre-Pi", new Atom(new Cmplx64TriadicFunction("cmplx64:legendre-Pi") {
            @Override
            public Complex apply(Complex x, Complex y, Complex z) { return Maja.legendrePi(x, y, z); }
        }));
        env.setPrimitive("cmplx64:solve", new Atom(new Cmplx64Solve()));
    }
}
