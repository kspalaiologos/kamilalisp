package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Index implements SpecialForm {
    private final Atom indexed;
    private int c, l;

    public Index(Atom indexed, int c, int l) {
        this.indexed = indexed;
    }

    @Override
    public int line() {
        return l;
    }

    @Override
    public int column() {
        return c;
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        Atom indexedAtom = Evaluation.evaluate(env, indexed);
        indexedAtom.assertTypes(Type.LIST, Type.STRING);
        // Check if every element of args is integer.
        Atom ix;
        if(args.stream().allMatch(x -> x.getType() == Type.INTEGER)) {
            // Treat it as a verbatim list or integer.
            if(args.size() == 1)
                ix = args.get(0);
            else
                ix = new Atom(args);
        } else {
            ix = Evaluation.evaluate(env, new Atom(args));
        }

        if(indexedAtom.getType() == Type.LIST) {
            if (ix.getType() == Type.INTEGER) {
                return indexedAtom.getList().get(ix.getInteger().intValueExact());
            } else if (ix.getType() == Type.REAL) {
                return indexedAtom.getList().get(ix.getReal().intValue());
            } else if (ix.getType() == Type.LIST) {
                return new Atom(ix.getList().stream().map(x -> {
                    if (x.getType() == Type.INTEGER) {
                        return indexedAtom.getList().get(x.getInteger().intValueExact());
                    } else if (x.getType() == Type.REAL) {
                        return indexedAtom.getList().get(x.getReal().intValue());
                    } else {
                        throw new RuntimeException("Can't index with type " + x.getType());
                    }
                }).toList());
            } else {
                throw new RuntimeException("Can't index with type " + ix.getType());
            }
        } else if(indexedAtom.getType() == Type.STRING) {
            if (ix.getType() == Type.INTEGER) {
                return new Atom(String.valueOf(indexedAtom.getString().charAt(ix.getInteger().intValueExact())));
            } else if (ix.getType() == Type.REAL) {
                return new Atom(String.valueOf(indexedAtom.getString().charAt(ix.getReal().intValue())));
            } else if (ix.getType() == Type.LIST) {
                StringBuilder sb = new StringBuilder();
                for(Atom a : ix.getList()) {
                    if (a.getType() == Type.INTEGER) {
                        sb.append(indexedAtom.getString().charAt(a.getInteger().intValueExact()));
                    } else if (a.getType() == Type.REAL) {
                        sb.append(indexedAtom.getString().charAt(a.getReal().intValue()));
                    } else {
                        throw new RuntimeException("Can't index with type " + a.getType());
                    }
                }
                return new Atom(sb.toString());
            } else {
                throw new RuntimeException("Can't index with type " + ix.getType());
            }
        } else {
            throw new RuntimeException("Can't index into type " + indexedAtom.getType());
        }
    }

    @Override
    public String frameString() {
        return "$[]/syn";
    }

    @Override
    public String stringify() {
        return indexed.toString() + "$";
    }
}
