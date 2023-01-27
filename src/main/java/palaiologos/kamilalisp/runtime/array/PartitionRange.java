package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.util.ArrayList;
import java.util.List;

public class PartitionRange extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        List<Atom> pattern = args.get(0).getList();
        List<Atom> list = args.get(1).getList();
        List<List<Atom>> result = new ArrayList<>();

        int leadingZeroes = 0;
        for (Atom atom : pattern) {
            if (atom.getInteger().intValueExact() == 0) {
                leadingZeroes++;
            } else {
                break;
            }
        }

        if(leadingZeroes > list.size())
            return Atom.NULL;

        for(int i = leadingZeroes; i < pattern.size(); i++) {
            if(pattern.get(i).getInteger().intValueExact() >= 1) {
                int n = pattern.get(i).getInteger().intValueExact();
                while(n != 1) {
                    n--;
                    result.add(Atom.NULL.getList());
                }
                result.add(new ArrayList<>());
                if(list.size() > i) {
                    result.get(result.size() - 1).add(list.get(i));
                }
            } else if(pattern.get(i).getInteger().intValueExact() == 0) {
                if(list.size() > i) {
                    result.get(result.size() - 1).add(list.get(i));
                }
            } else {
                throw new RuntimeException("Invalid pattern");
            }
        }

        return new Atom(result.stream().map(Atom::new).toList());
    }

    @Override
    protected String name() {
        return "list:partition-range";
    }
}
