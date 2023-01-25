package palaiologos.kamilalisp.runtime.hashmap;

import com.google.common.collect.ImmutableMap;
import org.pcollections.HashPMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Callable;
import palaiologos.kamilalisp.atom.Userdata;

public class HashMapUserData implements Userdata {
    public final HashPMap<Atom, Atom> value;

    public HashMapUserData(HashPMap<Atom, Atom> value) {
        this.value = value;
    }

    @Override
    public ImmutableMap<String, Callable> getMethods() {
        return ImmutableMap.of();
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
