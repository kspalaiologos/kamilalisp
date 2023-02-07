package palaiologos.kamilalisp.atom;

public interface Userdata {
    Atom field(Object key);

    int compareTo(Userdata other);

    boolean equals(Userdata other);

    String toString();

    String toDisplayString();

    String typeName();

    boolean coerceBoolean();
}
