package palaiologos.kamilalisp.atom;

import com.google.common.collect.ImmutableMap;

public interface Userdata {
    Atom field(Object key);

    int compareTo(Userdata other);

    boolean equals(Userdata other);

    String toString();

    String toDisplayString();

    String typeName();

    boolean coerceBoolean();
}
