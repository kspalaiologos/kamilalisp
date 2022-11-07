package palaiologos.kamilalisp.runtime.array;

import com.google.common.collect.Lists;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.AbstractList;
import java.util.List;

public class Range extends PrimitiveFunction implements Lambda {
    class RangeList extends AbstractList<Atom> {
        private BigInteger begin, end;
        boolean sign;

        public RangeList(BigInteger begin, BigInteger end) {
            this.begin = begin;
            this.end = end;
            sign = begin.compareTo(end) < 0;
        }

        @Override
        public Atom get(int index) {
            if(index > size()) {
                throw new IndexOutOfBoundsException();
            }

            return new Atom(sign ? begin.add(BigInteger.valueOf(index)) : begin.subtract(BigInteger.valueOf(index)));
        }

        @Override
        public int size() {
            return end.subtract(begin).abs().intValue();
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        BigInteger begin = args.get(0).getInteger();
        BigInteger end = args.get(1).getInteger();
        if(begin.compareTo(end) == 0)
            return new Atom(List.of());
        return new Atom(new RangeList(begin, end));
    }

    @Override
    protected String name() {
        return "range";
    }
}
