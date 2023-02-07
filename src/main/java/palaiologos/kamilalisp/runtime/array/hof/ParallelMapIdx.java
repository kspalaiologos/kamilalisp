package palaiologos.kamilalisp.runtime.array.hof;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.math.BigInteger;
import java.util.List;
import java.util.stream.Stream;

public class ParallelMapIdx extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        Callable reductor = args.get(0).getCallable();
        if (args.get(1).getType() == Type.LIST) {
            List<Atom> list = args.get(1).getList();
            Stream<Pair<BigInteger, Atom>> s = Streams.zip(
                    Stream.iterate(BigInteger.ZERO, i -> i.add(BigInteger.ONE)), list.stream(), Pair::new);
            return new Atom(s.parallel().map(p -> Evaluation.evaluate(env, reductor, List.of(new Atom(p.fst()), p.snd()))).toList());
        } else if (args.get(1).getType() == Type.STRING) {
            String str = args.get(1).getString();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < str.length(); i++) {
                sb.append(Evaluation.evaluate(env, reductor, List.of(new Atom(BigInteger.valueOf(i)), new Atom(String.valueOf(str.charAt(i))))).getString());
            }
            return new Atom(sb.toString());
        } else {
            throw new TypeError("Expected a list or a string as the second argument to `map-idx'.");
        }
    }

    @Override
    protected String name() {
        return "map-idx";
    }
}
