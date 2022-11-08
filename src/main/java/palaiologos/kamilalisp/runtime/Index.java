package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Index implements SpecialForm {
    private Atom indexed;
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
        indexedAtom.assertTypes(Type.LIST);
        Atom ix = Evaluation.evaluate(env, new Atom(args));
        if(ix.getType() == Type.INTEGER) {
            return indexedAtom.getList().get(ix.getInteger().intValueExact());
        } else if(ix.getType() == Type.REAL) {
            return indexedAtom.getList().get(ix.getReal().intValue());
        } else if(ix.getType() == Type.LIST) {
            return new Atom(ix.getList().stream().map(x -> {
                if(x.getType() == Type.INTEGER) {
                    return indexedAtom.getList().get(x.getInteger().intValueExact());
                } else if(x.getType() == Type.REAL) {
                    return indexedAtom.getList().get(x.getReal().intValue());
                } else {
                    throw new RuntimeException("Can't index with type " + x.getType());
                }
            }).toList());
        } else {
            throw new RuntimeException("Can't index with type " + ix.getType());
        }
    }

    @Override
    public String frameString() {
        return "?$[?]/syn";
    }

    @Override
    public String stringify() {
        return indexed.toString() + "$";
    }
}
