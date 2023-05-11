package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;

public class Partition extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        List<Atom> pattern = args.get(0).getList();
        int leadingZeroes = 0;
        for (Atom atom : pattern) {
            if (atom.getInteger().intValueExact() == 0) {
                leadingZeroes++;
            } else {
                break;
            }
        }

        if(args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            List<List<Atom>> result = new ArrayList<>();

            if (leadingZeroes > list.size())
                return Atom.NULL;

            for (int i = leadingZeroes; i < pattern.size(); i++) {
                if (pattern.get(i).getInteger().intValueExact() >= 1) {
                    int n = pattern.get(i).getInteger().intValueExact();
                    while (n != 1) {
                        n--;
                        result.add(Atom.NULL.getList());
                    }
                    result.add(new ArrayList<>());
                    if (list.size() > i) {
                        result.get(result.size() - 1).add(list.get(i));
                    }
                } else if (pattern.get(i).getInteger().intValueExact() == 0) {
                    if (list.size() > i) {
                        result.get(result.size() - 1).add(list.get(i));
                    }
                } else {
                    throw new RuntimeException("Invalid pattern");
                }
            }

            List<Atom> list1 = new ArrayList<>();
            for (List<Atom> atoms : result) {
                Atom atom = new Atom(atoms);
                list1.add(atom);
            }
            return new Atom(list1);
        } else if(args.get(1).getType() == Type.STRING) {
            String string = args.get(1).getString();
            List<String> result = new ArrayList<>();

            if (leadingZeroes > string.length())
                return Atom.NULL;

            for (int i = leadingZeroes; i < pattern.size(); i++) {
                if (pattern.get(i).getInteger().intValueExact() >= 1) {
                    int n = pattern.get(i).getInteger().intValueExact();
                    while (n != 1) {
                        n--;
                        result.add("");
                    }
                    result.add("");
                    if (string.length() > i) {
                        // append to last element
                        result.set(result.size() - 1, result.get(result.size() - 1) + string.charAt(i));
                    }
                } else if (pattern.get(i).getInteger().intValueExact() == 0) {
                    if (string.length() > i) {
                        result.set(result.size() - 1, result.get(result.size() - 1) + string.charAt(i));
                    }
                } else {
                    throw new RuntimeException("Invalid pattern");
                }
            }

            List<Atom> list = new ArrayList<>();
            for (String s : result) {
                Atom atom = new Atom(s);
                list.add(atom);
            }
            return new Atom(list);
        } else {
            throw new RuntimeException("Invalid type. Expected string or list.");
        }
    }

    @Override
    protected String name() {
        return "partition";
    }
}
