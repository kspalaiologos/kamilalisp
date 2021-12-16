package kamilalisp.libs.primitives.math;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class And implements Closure {
    public Atom and(Atom a, Atom b) {
        if(a.getType() == Type.NUMBER && b.getType() == Type.NUMBER) {
            return new Atom(new BigDecimal(a.getNumber().get().toBigInteger().and(b.getNumber().get().toBigInteger())));
        } else if(a.getType() == Type.STRING_CONSTANT && b.getType() == Type.STRING_CONSTANT) {
            Set<Integer> result = new LinkedHashSet<>(a.getStringConstant().get().get().codePoints().boxed().collect(Collectors.toList()));
            result.retainAll(b.getStringConstant().get().get().codePoints().boxed().collect(Collectors.toList()));
            return new Atom(new StringConstant(result.stream().collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString()));
        } else if(a.getType() == Type.LIST && b.getType() == Type.LIST) {
            Set<Atom> result = new LinkedHashSet<>(a.getList().get());
            result.retainAll(b.getList().get());
            return new Atom(new ArrayList<>(result));
        } else
            throw new Error("Invalid invocation to '&'. Expected two numbers, two strings or two lists.");
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() != 2)
            throw new Error("Invalid invocation to '&'.");
        return new Atom(new LbcSupplier<>(() -> and(arguments.get(0), arguments.get(1)).get().get()));
    }
}
