package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.color.RandomGreedyColoring;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RandomGreedyColouring extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var colouring = new RandomGreedyColoring<>(wp.getGraph());
        Map<Atom, Integer> cm = colouring.getColoring().getColors();
        Map<Atom, Atom> colourMap = new HashMap<>();
        for (var entry : cm.entrySet())
            colourMap.put(new Atom(entry.getKey().toString()), new Atom(BigInteger.valueOf(entry.getValue())));
        Map<Atom, Atom> data = Map.ofEntries(
                Map.entry(new Atom("colours"), new Atom(new HashMapUserData(HashTreePMap.from(colourMap)))),
                Map.entry(new Atom("colouring"), new Atom(colouring.getColoring().getColorClasses().stream().map(x -> new Atom(new ArrayList<>(x))).toList()))
        );
        return new Atom(new HashMapUserData(HashTreePMap.from(data)));
    }

    @Override
    protected String name() {
        return "graph:random-greedy-colouring";
    }
}
