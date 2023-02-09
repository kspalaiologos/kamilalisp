package palaiologos.kamilalisp.runtime.dataformat;

import palaiologos.kamilalisp.atom.Atom;

import java.math.BigInteger;
import java.util.AbstractList;
import java.util.List;

public class BufferAtomList {
    public static List<Atom> from(byte[] data) {
        return new AbstractList<>() {
            @Override
            public Atom get(int index) {
                if (index < 0 || index >= data.length)
                    throw new IndexOutOfBoundsException();
                return new Atom(BigInteger.valueOf(data[index]));
            }

            @Override
            public int size() {
                return data.length;
            }
        };
    }

    public static List<Atom> from(byte[] data, int size) {
        return new AbstractList<>() {
            @Override
            public Atom get(int index) {
                if (index < 0 || index >= size)
                    throw new IndexOutOfBoundsException();
                return new Atom(BigInteger.valueOf(data[index]));
            }

            @Override
            public int size() {
                return size;
            }
        };
    }
}
