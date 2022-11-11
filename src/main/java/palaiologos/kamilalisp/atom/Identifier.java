package palaiologos.kamilalisp.atom;

import com.google.common.collect.BiMap;
import com.google.common.collect.HashBiMap;

public class Identifier {
    private static final BiMap<String, Identifier> identifiers = HashBiMap.create();

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


}
