package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.traverse.RandomWalkVertexIterator;
import palaiologos.kamilalisp.atom.*;

import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class RS extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 3);
        GraphWrapper w = Evaluation.evaluate(env, args.get(0)).getUserdata(GraphWrapper.class);
        Atom start = args.get(1);
        List<Atom> ops = args.get(2).getList();
        Iterator<Atom> it = new RandomWalkVertexIterator<>(w.getGraph(), start);
        Iterable<Atom> iterable = () -> it;
        Stream<Atom> stream = StreamSupport.stream(iterable.spliterator(), false);
        return IteratorPipeline.evaluate(env, ops, stream);
    }

    @Override
    protected String name() {
        return "graph:rs";
    }
}
