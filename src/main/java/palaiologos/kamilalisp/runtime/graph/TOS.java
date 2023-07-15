package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.traverse.DepthFirstIterator;
import org.jgrapht.traverse.TopologicalOrderIterator;
import palaiologos.kamilalisp.atom.*;

import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class TOS extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 3) {
            GraphWrapper w = args.get(0).getUserdata(GraphWrapper.class);
            Callable comparator = Evaluation.evaluate(env, args.get(1)).getCallable();
            Callable op = args.get(2).getCallable();
            Atom init = args.size() > 3 ? args.get(3) : Atom.NULL;
            Iterator<Atom> it = new TopologicalOrderIterator<>(w.getGraph(), (o1, o2) -> Evaluation.evaluate(env, comparator, List.of(o1, o2)).getInteger().intValueExact());
            while (it.hasNext()) {
                Atom a = it.next();
                List<Atom> result = op.apply(env, List.of(a, init)).getList();
                init = result.get(0);
                if (result.get(1).coerceBool())
                    break;
            }
            return init;
        } else if(args.size() == 2) {
            GraphWrapper w = args.get(0).getUserdata(GraphWrapper.class);
            Callable op = args.get(1).getCallable();
            Atom init = args.size() > 2 ? args.get(3) : Atom.NULL;
            Iterator<Atom> it = new TopologicalOrderIterator<>(w.getGraph(), Comparator.naturalOrder());
            while (it.hasNext()) {
                Atom a = it.next();
                List<Atom> result = op.apply(env, List.of(a, init)).getList();
                init = result.get(0);
                if (result.get(1).coerceBool())
                    break;
            }
            return init;
        } else
            throw new RuntimeException("Invalid arity");
    }

    @Override
    protected String name() {
        return "graph:tos";
    }
}
