package palaiologos.kamilalisp.runtime.hashmap;

import org.pcollections.HashPMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Userdata;

import java.math.BigDecimal;

public record HashMapUserData(HashPMap<Atom, Atom> value) implements Userdata {
    @Override
    public Atom field(Object key) {
        if (key instanceof BigDecimal) {
            if (value.containsKey(new Atom(key.toString())))
                return value.get(new Atom(key.toString()));
            else
                return Atom.NULL;
        } else if (key instanceof String) {
            if (value.containsKey(new Atom((String) key)))
                return value.get(new Atom((String) key));
            else
                return Atom.NULL;
        } else
            throw new IllegalArgumentException("Key must be either an integer or a string");
    }

    @Override
    public int compareTo(Userdata other) {
        if (!(other instanceof HashMapUserData))
            return other.hashCode() - hashCode();
        return value.size() - ((HashMapUserData) other).value.size();
    }

    @Override
    public boolean equals(Userdata other) {
        if (!(other instanceof HashMapUserData))
            return false;
        return value.equals(((HashMapUserData) other).value);
    }

    @Override
    public String toDisplayString() {
        return value.toString();
    }

    @Override
    public String typeName() {
        return "hashmap";
    }

    @Override
    public boolean coerceBoolean() {
        return !value.isEmpty();
    }

}
