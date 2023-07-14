package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.traverse.MaximumCardinalityIterator;
import palaiologos.kamilalisp.atom.*;

import java.util.Iterator;
import java.util.List;

public class MCS extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        GraphWrapper w = args.get(0).getUserdata(GraphWrapper.class);
        Callable op = args.get(1).getCallable();
        Atom init = args.size() > 2 ? args.get(2) : Atom.NULL;
        Iterator<Atom> it = new MaximumCardinalityIterator<>(w.getGraph());
        while (it.hasNext()) {
            Atom a = it.next();
            List<Atom> result = op.apply(env, List.of(a, init)).getList();
            init = result.get(0);
            if (result.get(1).coerceBool())
                break;
        }
        return init;
    }

    @Override
    protected String name() {
        return "graph:mcs";
    }
}

