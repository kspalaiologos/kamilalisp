package palaiologos.kamilalisp.atom;

import com.google.common.collect.ImmutableMap;

public interface Userdata {
    ImmutableMap<String, Callable> getMethods();

    int compareTo(Userdata other);

    boolean equals(Userdata other);

    String toString();

    String toDisplayString();

    String typeName();

    boolean coerceBoolean();
}
