package palaiologos.kamilalisp.atom;

import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;

import java.util.HashMap;

public class Identifier {
    private static BiMap<String, Identifier> identifiers = HashBiMap.create();

    public static String of(Identifier i) {
        return identifiers.inverse().get(i);
    }

    public static Identifier of(String s) {
        if (identifiers.containsKey(s)) {
            return identifiers.get(s);
        } else {
            Identifier i = new Identifier();
            identifiers.put(s, i);
            return i;
        }
    }

    @Override
    public int hashCode() {
        return Identifier.of(this).hashCode();
    }
}
