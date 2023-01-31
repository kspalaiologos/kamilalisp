package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Pmat extends PrimitiveFunction implements Lambda {
    public <E> List<List<E>> generatePerm(List<E> original) {
        if (original.isEmpty()) {
            List<List<E>> result = new ArrayList<>();
            result.add(new ArrayList<>());
            return result;
        }
        E firstElement = original.remove(0);
        List<List<E>> returnValue = new ArrayList<>();
        List<List<E>> permutations = generatePerm(original);
        for (List<E> smallerPermutated : permutations) {
            for (int index = 0; index <= smallerPermutated.size(); index++) {
                List<E> temp = new ArrayList<>(smallerPermutated);
                temp.add(index, firstElement);
                returnValue.add(temp);
            }
        }
        return returnValue;
    }


    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() == 1) {
            int n = args.get(0).getInteger().intValueExact();
            if (n < 0) {
                throw new IllegalArgumentException("`pmat' takes only non-negative integers.");
            }

            List<Atom> list = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                list.add(new Atom(BigInteger.valueOf(i)));
            }

            List<List<Atom>> permutations = generatePerm(list);

            return new Atom(permutations.stream().map(Atom::new).toList());
        } else {
            throw new IllegalArgumentException("`pmat' takes only one argument.");
        }
    }

    @Override
    protected String name() {
        return "pmat";
    }
}
