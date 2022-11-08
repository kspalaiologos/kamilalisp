package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.*;

import java.util.List;
import java.util.stream.Collectors;

public class Index extends PrimitiveFunction implements Lambda {
    private Atom indexed, indexer;

    public Index(Atom indexed, Atom indexer) {
        this.indexed = indexed;
        this.indexer = indexer;
    }

    private List<Atom> index(Atom head, List<Atom> indices) {
        return indices.stream().map(x -> {
            if(x.getType() == Type.INTEGER) {
                return head.getList().get(x.getInteger().intValueExact());
            } else if(x.getType() == Type.REAL) {
                return head.getList().get(x.getReal().intValue());
            } else if(x.getType() == Type.LIST) {
                return new Atom(index(head, x.getList()));
            } else {
                throw new RuntimeException("Can't index with a " + x.getType() + ".");
            }
        }).collect(Collectors.toList());
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(indexer.getList().size() == 1) {
            // The indexer is either a scalar value or some variable,
            // in which case if it evaluates into a list we want to also obtain elements from it.
            Atom indexedAtom = Evaluation.evaluate(env, indexed);
            indexedAtom.assertTypes(Type.LIST);
            Atom indexerHead = Evaluation.evaluate(env, indexer.getList().get(0));
            if(indexerHead.getType() == Type.INTEGER) {
                return indexedAtom.getList().get(indexerHead.getInteger().intValueExact());
            } else if(indexerHead.getType() == Type.REAL) {
                return indexedAtom.getList().get(indexerHead.getReal().intValue());
            } else if(indexerHead.getType() == Type.LIST) {
                return new Atom(indexerHead.getList().stream().map(x -> {
                    x.assertTypes(Type.INTEGER, Type.REAL);
                    if(x.getType() == Type.INTEGER) {
                        return indexedAtom.getList().get(x.getInteger().intValueExact());
                    } else if(x.getType() == Type.REAL) {
                        return indexedAtom.getList().get(x.getReal().intValue());
                    } else
                        throw new RuntimeException("Can't index with a " + x.getType() + ".");
                }).collect(Collectors.toList()));
            } else
                throw new RuntimeException("Can't index with a " + indexerHead.getType() + ".");
        } else if(indexer.getList().size() > 1) {
            return new Atom(index(Evaluation.evaluate(env, indexed), indexer.getList().stream().map(x -> Evaluation.evaluate(env, x)).toList()));
        } else {
            return Atom.NULL;
        }
    }

    @Override
    protected String name() {
        return "..$[...]/syn";
    }
}
