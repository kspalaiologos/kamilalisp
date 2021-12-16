package kamilalisp.libs.primitives.math;

import kamilalisp.data.*;

import java.math.BigDecimal;
import java.util.LinkedList;
import java.util.List;

public class Tilde implements Closure {
    public String reverseCase(String text) {
        return text.chars()
                .map(c -> Character.isUpperCase(c) ?
                        Character.toLowerCase(c) :
                        Character.toUpperCase(c))
                .collect(
                        StringBuilder::new,
                        StringBuilder::appendCodePoint,
                        StringBuilder::append)
                .toString();
    }

    public Atom neg(Atom a) {
        a.guardType("First argument to monadic '~'", Type.NUMBER, Type.STRING_CONSTANT);

        if(a.getType() == Type.NUMBER) {
            return new Atom(BigDecimal.valueOf(a.getNumber().get().compareTo(BigDecimal.ZERO) == 0 ? 1 : 0));
        } else if(a.getType() == Type.STRING_CONSTANT) {
            return new Atom(new StringConstant(reverseCase(a.getStringConstant().get().get())));
        }

        // Should never get here.
        return null;
    }

    public Atom neg(Atom a, Atom b) {
        a.guardType("First argument to dyadic '~'", Type.LIST);
        if(b.getType() == Type.LIST) {
            List<Atom> clone = new LinkedList<>(a.getList().get());
            clone.removeIf(x -> a.getList().get().contains(x.get().get()));
            return new Atom(clone);
        } else {
            List<Atom> clone = new LinkedList<>(a.getList().get());
            clone.removeIf(x -> x.get().get().equals(b.get().get()));
            return new Atom(clone);
        }
    }

    @Override
    public Atom apply(Executor env, List<Atom> arguments) {
        if(arguments.size() == 0)
            throw new Error("Invalid invocation to '~'.");
        else if(arguments.size() == 1)
            return new Atom(new LbcSupplier(() -> neg(arguments.get(0)).get().get()));
        else if(arguments.size() == 2)
            return new Atom(new LbcSupplier(() -> neg(arguments.get(0), arguments.get(1)).get().get()));
        throw new Error("Invalid invocation to '~'.");
    }
}
