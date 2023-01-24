package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class Without extends PrimitiveFunction implements Lambda {
    @Override
    public String name() {
        return "without";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() != 2)
            throw new TypeError("`without' requires 2 arguments");
        args.get(0).assertTypes(Type.LIST, Type.STRING);
        args.get(1).assertTypes(Type.LIST, Type.STRING);
        if(args.get(0).getType() == Type.LIST && args.get(1).getType() == Type.LIST) {
            List<Atom> list = new ArrayList<>(args.get(0).getList());
            list.removeAll(args.get(1).getList());
            return new Atom(list);
        } else if(args.get(0).getType() == Type.STRING && args.get(1).getType() == Type.STRING) {
            StringBuilder result = new StringBuilder();
            for(char c : args.get(0).getString().toCharArray()) {
                if(!args.get(1).getString().contains(String.valueOf(c))) {
                    result.append(c);
                }
            }
            return new Atom(result.toString());
        } else {
            throw new TypeError("`without' requires both arguments to be of the same type");
        }
    }
}
