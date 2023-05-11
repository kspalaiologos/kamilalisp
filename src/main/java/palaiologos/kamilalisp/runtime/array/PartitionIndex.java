package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class PartitionIndex extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        int[] pattern = new int[args.get(0).getList().size()];
        for (int i = 0; i < pattern.length; i++) {
            pattern[i] = args.get(0).getList().get(i).getInteger().intValueExact();
        }
        Arrays.sort(pattern);
        if(args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            List<Atom> result = new ArrayList<>(pattern.length);
            // Break up the list into parts on indices specified by the pattern.
            int start = 0;
            for (int end : pattern) {
                result.add(new Atom(new ArrayList<>(list.subList(start, end))));
                start = end;
            }
            // Add the last part.
            if(start < list.size())
                result.add(new Atom(new ArrayList<>(list.subList(start, list.size()))));
            return new Atom(result);
        } else if(args.get(1).getType() == Type.STRING) {
            String string = args.get(1).getString();
            List<Atom> result = new ArrayList<>(pattern.length);
            // Break up the string into parts on indices specified by the pattern.
            int start = 0;
            for (int end : pattern) {
                result.add(new Atom(string.substring(start, end)));
                start = end;
            }
            // Add the last part.
            if(start < string.length())
                result.add(new Atom(string.substring(start)));
            return new Atom(result);
        } else {
            throw new RuntimeException("partition-index: expected list or string as second argument");
        }
    }

    @Override
    protected String name() {
        return "partition-index";
    }
}
