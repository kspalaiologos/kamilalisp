package kamilalisp.data;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigComplexMath;

import java.math.BigDecimal;
import java.util.Comparator;
import java.util.List;

public class AtomComparator implements Comparator<Atom> {
    @Override
    public int compare(Atom o1, Atom o2) {
        // 1. Handle different types.
        if (o1.getType() != o2.getType())
            return o1.getType().compareTo(o2.getType());

        // 2. Handle lists.
        if (o1.getType() == Type.LIST) {
            List<Atom> l1 = o1.getList().get();
            List<Atom> l2 = o2.getList().get();
            if (l1.size() != l2.size())
                return Integer.compare(l1.size(), l2.size());
            for (int i = 0; i < l1.size(); i++) {
                int c = compare(l1.get(i), l2.get(i));
                if (c != 0)
                    return c;
            }
            return 0;
        }

        // 3. Handle strings.
        if (o1.getType() == Type.STRING) {
            String s1 = o1.getString().get();
            String s2 = o2.getString().get();
            return s1.compareTo(s2);
        }

        // 4. Handle string constants.
        if (o1.getType() == Type.STRING_CONSTANT) {
            String s1 = o1.getStringConstant().get().get();
            String s2 = o2.getStringConstant().get().get();
            return s1.compareTo(s2);
        }

        // 5. Handle numbers.
        if (o1.getType() == Type.NUMBER) {
            BigDecimal n1 = o1.getNumber().get();
            BigDecimal n2 = o2.getNumber().get();
            return n1.compareTo(n2);
        }

        // 6. Handle complex numbers.
        if (o1.getType() == Type.COMPLEX) {
            BigComplex c1 = o1.getComplex().get();
            BigComplex c2 = o2.getComplex().get();
            // Compare |c1| and |c2|.
            // Should add a square root, but it's not significant here.
            return c1.re.pow(2).add(c1.im.pow(2)).compareTo(c2.re.pow(2).add(c2.im.pow(2)));
        }

        // 7. Handle closures.
        if (o1.getType() == Type.CLOSURE) {
            Closure c1 = o1.getClosure().get();
            Closure c2 = o2.getClosure().get();
            return c1.representation().compareTo(c2.representation());
        }

        // 8. Handle macros.
        if (o1.getType() == Type.MACRO) {
            Macro m1 = o1.getMacro().get();
            Macro m2 = o2.getMacro().get();
            return m1.representation().compareTo(m2.representation());
        }

        throw new Error("Default 'sort' comparator: Unhandled type: " + o1.getType());
    }
}
