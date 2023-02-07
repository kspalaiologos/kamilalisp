package palaiologos.kamilalisp.runtime;

import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class InlineMap implements SpecialForm, ReactiveFunction {
    private final HashMap<Atom, Atom> data;
    private final int col;
    private final int line;

    public InlineMap(HashMap<Atom, Atom> data, int col, int line) {
        this.data = data;
        this.col = col;
        this.line = line;
    }

    @Override
    public String stringify() {
        return "$%" + data.toString();
    }

    @Override
    public String frameString() {
        return "Map constructor";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new HashMapUserData(HashTreePMap.from(data.entrySet().stream().map(e -> {
            Atom key = e.getKey();
            Atom value = e.getValue();
            key = Evaluation.evaluate(env, key);
            value = Evaluation.evaluate(env, value);
            return new HashMap.SimpleEntry<>(key, value);
        }).collect(Collectors.toMap(HashMap.SimpleEntry::getKey, HashMap.SimpleEntry::getValue)))));
    }

    @Override
    public int line() {
        return line;
    }

    @Override
    public int column() {
        return col;
    }
}
