package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;
import java.util.stream.Collectors;

public class OuterProduct extends PrimitiveFunction implements Lambda {
    public Atom op2(Atom a, Atom b) {
        if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            return new Atom(Lists.cartesianProduct(a.getList(), b.getList()).stream().map(Atom::new).toList());
        } else if(a.getType() == Type.STRING && b.getType() == Type.STRING) {
            return new Atom(Lists.cartesianProduct(
                    a.getString().chars().mapToObj(x -> (char) x).toList(),
                    b.getString().chars().mapToObj(x -> (char) x).toList()
            ).stream().map(x -> new Atom(x.stream().map(Object::toString).collect(Collectors.joining()))).toList());
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

        return args.stream().reduce(this::op2).get();
    }

    @Override
    protected String name() {
        return "outer-product";
    }
}
