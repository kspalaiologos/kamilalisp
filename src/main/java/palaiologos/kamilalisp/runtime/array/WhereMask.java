package palaiologos.kamilalisp.runtime.array;

import palaiologos.kamilalisp.atom.*;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class WhereMask extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        List<Atom> data = args.get(0).getList();
        if(data.stream().allMatch(x -> x.getType() == Type.INTEGER)) {
            int[] indices = data.stream().mapToInt(x -> x.getInteger().intValueExact()).toArray();
            int max = Arrays.stream(indices).max().orElse(0);
            int[] mask = new int[max + 1];
            for(int i : indices)
                mask[i]++;
            return new Atom(Arrays.stream(mask).mapToObj(x -> new Atom(BigInteger.valueOf(x))).toList());
        } else {
            // Determine the rank of result.
            int rank = data.get(0).getList().size();
            if(rank == 0)
                throw new RuntimeException("Cannot apply where-mask to a list of scalars.");
            if(data.stream().anyMatch(x -> x.getList().size() != rank))
                throw new RuntimeException("Cannot apply where-mask to a list of lists of different rank.");
            // Compute the maximum of each dimension.
            int[] max = new int[rank];
            for(Atom a : data) {
                List<Atom> list = a.getList();
                for(int i = 0; i < rank; i++) {
                    int x = list.get(i).getInteger().intValueExact();
                    if(x > max[i])
                        max[i] = x;
                }
            }
            // Create empty matrix (nested list of atoms) of specified dimension.
            Atom mat = emptyMatrix(max, 0);
            // Fill the matrix.
            for(Atom a : data)
                atCell(mat, a.getList().stream().mapToInt(x -> x.getInteger().intValueExact()).toArray(), 0);
            return mat;
        }
    }

    private Atom emptyMatrix(int[] max, int dim) {
        List<Atom> list = new ArrayList<>();
        for(int i = 0; i < max[dim] + 1; i++)
            list.add(dim == max.length - 1 ? new Atom(BigInteger.ZERO) : emptyMatrix(max, dim + 1));
        return new Atom(list);
    }

    private void atCell(Atom mat, int[] indices, int dim) {
        if(dim == indices.length - 1)
            mat.getList().set(indices[dim], new Atom(mat.getList().get(indices[dim]).getInteger().add(BigInteger.ONE)));
        else
            atCell(mat.getList().get(indices[dim]), indices, dim + 1);
    }

    @Override
    protected String name() {
        return "where-mask";
    }
}
