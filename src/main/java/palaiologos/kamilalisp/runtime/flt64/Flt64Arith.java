package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;

import static palaiologos.kamilalisp.runtime.flt64.Flt64Base.toAtom;
import static palaiologos.kamilalisp.runtime.flt64.Flt64Base.toFlt64;

public class Flt64Arith {
    public static final Flt64Base.Flt64Function add = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:+";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).sum());
        }
    };
    public static final Flt64Base.Flt64Function sub = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:-";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1) {
                return toAtom(-toFlt64(args.get(0)));
            } else {
                return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a - b).orElse(0));
            }
        }
    };
    public static final Flt64Base.Flt64Function mul = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:*";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a * b).orElse(1));
        }
    };
    public static final Flt64Base.Flt64Function div = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:/";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a / b).orElse(1));
        }
    };
    public static final Flt64Base.Flt64Function mod = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:mod";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce((a, b) -> a % b).orElse(1));
        }
    };
    public static final Flt64Base.Flt64Function pow = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:**";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            return toAtom(args.stream().mapToDouble(Flt64Base::toFlt64).reduce(Math::pow).orElse(1));
        }
    };
    public static final Flt64Base.Flt64Function abs = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:abs";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.abs(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::abs).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function ceil = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:ceil";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.ceil(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::ceil).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function floor = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:floor";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.floor(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::floor).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function round = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:round";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.round(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::round).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function exp = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:exp";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.exp(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::exp).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function ln = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:ln";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.log(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::log).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function log = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:log10";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.log10(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::log10).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function log2 = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:log2";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.log(toFlt64(args.get(0))) / Math.log(2));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::log).map(x -> x / Math.log(2)).mapToObj(Flt64Base::toAtom).toList());
        }
    };
    public static final Flt64Base.Flt64Function sqrt = new Flt64Base.Flt64Function() {
        @Override
        protected String name() {
            return "flt64:sqrt";
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            if (args.size() == 1)
                return toAtom(Math.sqrt(toFlt64(args.get(0))));
            else
                return new Atom(args.stream().mapToDouble(Flt64Base::toFlt64).map(Math::sqrt).mapToObj(Flt64Base::toAtom).toList());
        }
    };
}
