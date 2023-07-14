package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.traverse.TopologicalOrderIterator;
import palaiologos.kamilalisp.atom.*;

import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class TOS extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 3) {
            GraphWrapper w = Evaluation.evaluate(env, args.get(0)).getUserdata(GraphWrapper.class);
            Callable comparator = Evaluation.evaluate(env, args.get(1)).getCallable();
            List<Atom> ops = args.get(2).getList();
            Iterator<Atom> it = new TopologicalOrderIterator<>(w.getGraph(), (o1, o2) -> Evaluation.evaluate(env, comparator, List.of(o1, o2)).getInteger().intValueExact());
            Iterable<Atom> iterable = () -> it;
            Stream<Atom> stream = StreamSupport.stream(iterable.spliterator(), false);
            return IteratorPipeline.evaluate(env, ops, stream);
        } else if(args.size() == 2) {
            GraphWrapper w = Evaluation.evaluate(env, args.get(0)).getUserdata(GraphWrapper.class);
            List<Atom> ops = args.get(2).getList();
            Iterator<Atom> it = new TopologicalOrderIterator<>(w.getGraph(), Comparator.naturalOrder());
            Iterable<Atom> iterable = () -> it;
            Stream<Atom> stream = StreamSupport.stream(iterable.spliterator(), false);
            return IteratorPipeline.evaluate(env, ops, stream);
        } else
            throw new RuntimeException("Invalid arity");
    }

    @Override
    protected String name() {
        return "graph:tos";
    }
}
