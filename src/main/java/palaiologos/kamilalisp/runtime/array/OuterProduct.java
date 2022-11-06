package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class OuterProduct extends PrimitiveFunction implements Lambda {
    public Atom op2(Atom a, Atom b) {
        if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Lists.cartesianProduct(a.getList(), b.getList()).stream().map(Atom::new).toList());
        } else if(a.getType() == Type.LIST && b.getType() != Type.LIST) {
            return new Atom(Lists.cartesianProduct(a.getList(), List.of(b)).stream().map(Atom::new).toList());
        } else if(a.getType() != Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Lists.cartesianProduct(List.of(a), b.getList()).stream().map(Atom::new).toList());
        } else {
            return new Atom(List.of(a, b));
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() <= 1) {
            throw new TypeError("outer-product called with too few arguments.");
        }

        return args.stream().reduce((acc, x) -> op2(acc, x)).get();
    }

    @Override
    protected String name() {
        return "outer-product";
    }
}
