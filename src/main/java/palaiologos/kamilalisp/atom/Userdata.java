package palaiologos.kamilalisp.atom;

public interface Userdata {
    Atom field(Object key);

    default int compareTo(Userdata other) {
        return hashCode() - other.hashCode();
    }

    default boolean equals(Userdata other) {
        return compareTo(other) == 0;
    }

    String toString();

    String toDisplayString();

    String typeName();

    default boolean coerceBoolean() {
        return true;
    }
}
