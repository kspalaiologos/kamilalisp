package palaiologos.kamilalisp.runtime.graph;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class ZhangShashaTreeEditDistance extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 4) {
            GraphWrapper g1 = args.get(0).getUserdata(GraphWrapper.class);
            Atom v1 = args.get(1);
            GraphWrapper g2 = args.get(2).getUserdata(GraphWrapper.class);
            Atom v2 = args.get(3);
            var editDistance = new org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance<>(g1.getGraph(), v1, g2.getGraph(), v2);
            Map<Atom, Atom> result = Map.ofEntries(
                    Map.entry(new Atom("distance"), new Atom(BigDecimal.valueOf(editDistance.getDistance()))),
                    Map.entry(new Atom("insertions"), new Atom(editDistance.getEditOperationLists().stream().filter(x -> x.getType().equals(org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance.OperationType.INSERT)).map(x -> new Atom(List.of(x.getFirstOperand(), x.getSecondOperand()))).toList())),
                    Map.entry(new Atom("modifications"), new Atom(editDistance.getEditOperationLists().stream().filter(x -> x.getType().equals(org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance.OperationType.CHANGE)).map(x -> new Atom(List.of(x.getFirstOperand(), x.getSecondOperand()))).toList())),
                    Map.entry(new Atom("removals"), new Atom(editDistance.getEditOperationLists().stream().filter(x -> x.getType().equals(org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance.OperationType.REMOVE)).map(x -> new Atom(List.of(x.getFirstOperand(), x.getSecondOperand()))).toList()))
            );
            return new Atom(new HashMapUserData(HashTreePMap.from(result)));
        } else if(args.size() == 7) {
            GraphWrapper g1 = args.get(0).getUserdata(GraphWrapper.class);
            Atom v1 = args.get(1);
            GraphWrapper g2 = args.get(2).getUserdata(GraphWrapper.class);
            Atom v2 = args.get(3);
            Callable insertionCost = args.get(4).getCallable();
            Callable removalCost = args.get(5).getCallable();
            Callable modificationCost = args.get(6).getCallable();
            var editDistance = new org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance<>(
                    g1.getGraph(), v1, g2.getGraph(), v2,
                    value -> Evaluation.evaluate(env, insertionCost, List.of(value)).getReal().doubleValue(),
                    value -> Evaluation.evaluate(env, removalCost, List.of(value)).getReal().doubleValue(),
                    (a, b) -> Evaluation.evaluate(env, modificationCost, List.of(a, b)).getReal().doubleValue());
            Map<Atom, Atom> result = Map.ofEntries(
                    Map.entry(new Atom("distance"), new Atom(BigDecimal.valueOf(editDistance.getDistance()))),
                    Map.entry(new Atom("insertions"), new Atom(editDistance.getEditOperationLists().stream().filter(x -> x.getType().equals(org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance.OperationType.INSERT)).map(x -> new Atom(List.of(x.getFirstOperand(), x.getSecondOperand()))).toList())),
                    Map.entry(new Atom("modifications"), new Atom(editDistance.getEditOperationLists().stream().filter(x -> x.getType().equals(org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance.OperationType.CHANGE)).map(x -> new Atom(List.of(x.getFirstOperand(), x.getSecondOperand()))).toList())),
                    Map.entry(new Atom("removals"), new Atom(editDistance.getEditOperationLists().stream().filter(x -> x.getType().equals(org.jgrapht.alg.similarity.ZhangShashaTreeEditDistance.OperationType.REMOVE)).map(x -> new Atom(List.of(x.getFirstOperand(), x.getSecondOperand()))).toList()))
            );
            return new Atom(new HashMapUserData(HashTreePMap.from(result)));
        } else {
            throw new RuntimeException("Expected 4 or 7 arguments.");
        }
    }

    @Override
    protected String name() {
        return "graph:zhang-shasha-tree-edit-distance";
    }
}
