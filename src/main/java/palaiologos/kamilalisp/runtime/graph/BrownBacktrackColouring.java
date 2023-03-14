package palaiologos.kamilalisp.runtime.graph;

import org.jgrapht.alg.color.BrownBacktrackColoring;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigInteger;
import java.util.*;

public class BrownBacktrackColouring extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        GraphWrapper wp = args.get(0).getUserdata(GraphWrapper.class);
        var colouring = new BrownBacktrackColoring<>(wp.getGraph());
        Map<Atom, Integer> cm = colouring.getColoring().getColors();
        Map<Atom, Atom> colourMap = new HashMap<>();
        for (var entry : cm.entrySet())
            colourMap.put(new Atom(entry.getKey().toString()), new Atom(BigInteger.valueOf(entry.getValue())));
        Map<Atom, Atom> data = Map.ofEntries(
                Map.entry(new Atom("chromatic-number"), new Atom(BigInteger.valueOf(colouring.getChromaticNumber()))),
                Map.entry(new Atom("colours"), new Atom(new HashMapUserData(HashTreePMap.from(colourMap)))),
                Map.entry(new Atom("colouring"), new Atom(colouring.getColoring().getColorClasses().stream().map(x -> new Atom(new ArrayList<>(x))).toList()))
        );
        return new Atom(new HashMapUserData(HashTreePMap.from(data)));
    }

    @Override
    protected String name() {
        return "graph:brown-backtrack-colouring";
    }
}
