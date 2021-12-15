package kamilalisp.data;

import com.google.common.collect.Iterables;
import com.google.common.collect.Streams;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class MatrixImpl extends Matrix {
    private List<Atom> ravelData;
    private int iRows, iCols;

    protected MatrixImpl(List<List<Atom>> a) {
        if(a.stream().anyMatch(l -> l.size() != a.get(0).size()))
            throw new IllegalArgumentException("All cols of a matrix must have the same length");
        this.ravelData = a.stream().flatMap(Collection::stream).collect(Collectors.toList());
        this.iRows = a.size();
        this.iCols = a.get(0).size();
    }

    protected MatrixImpl(List<Atom> a, int rows, int cols) {
        if(a.size() != rows * cols)
            throw new IllegalArgumentException("The size of the ravel data must be equal to the product of rows and cols");
        this.ravelData = a;
        this.iRows = rows;
        this.iCols = cols;
    }

    @Override
    public boolean isNumeric() {
        return ravelData.stream().map(x -> x.getType() == Type.NUMBER || x.getType() == Type.COMPLEX)
                .reduce(Boolean::logicalAnd).orElse(true);
    }

    @Override
    public int getRows() {
        return iRows;
    }

    @Override
    public int getCols() {
        return iCols;
    }

    @Override
    public Atom get(int row, int col) {
        return ravelData.get(row * iCols + col);
    }

    @Override
    public void set(int row, int col, Atom a) {
        ravelData.set(row * iCols + col, a);
    }

    @Override
    public List<Atom> ravel() {
        return ravelData;
    }

    private List<Atom> getRow(int row) {
        return IntStream.range(0, iCols).mapToObj(x -> get(row, x)).collect(Collectors.toList());
    }

    private List<Atom> getCol(int col) {
        return IntStream.range(0, iRows).mapToObj(x -> get(x, col)).collect(Collectors.toList());
    }

    @Override
    public Stream<List<Atom>> rows() {
        return IntStream.range(0, iRows).mapToObj(this::getRow);
    }

    @Override
    public Stream<List<Atom>> cols() {
        return IntStream.range(0, iCols).mapToObj(this::getCol);
    }

    @Override
    public Matrix reshape(int rows, int cols, boolean recycle) {
        List<Atom> currentRavel = ravelData;
        if(!recycle) {
            if (currentRavel.size() < rows * cols)
                return new MatrixImpl(Stream.concat(currentRavel.stream(), Stream.generate(() -> isNumeric() ? new Atom(BigDecimal.ZERO) : Atom.NULL).limit(rows * cols - currentRavel.size())).collect(Collectors.toList()), rows, cols);
        } else {
            if (currentRavel.size() < rows * cols)
                return new MatrixImpl(Streams.stream(Iterables.cycle(currentRavel)).limit(rows * cols).collect(Collectors.toList()), rows, cols);
        }
        if (currentRavel.size() > rows * cols)
            return new MatrixImpl(currentRavel.subList(0, rows * cols), rows, cols);
        else
            return new MatrixImpl(currentRavel, rows, cols);
    }

    @Override
    public Matrix transpose() {
        return new Matrix() {
            @Override
            public int getRows() {
                return MatrixImpl.this.getCols();
            }

            @Override
            public int getCols() {
                return MatrixImpl.this.getRows();
            }

            @Override
            public Atom get(int row, int col) {
                return MatrixImpl.this.get(col, row);
            }

            @Override
            public void set(int row, int col, Atom a) {
                MatrixImpl.this.set(row, col, a);
            }

            @Override
            public List<Atom> ravel() {
                return MatrixImpl.this.cols().flatMap(Collection::stream).collect(Collectors.toList());
            }

            @Override
            public Stream<List<Atom>> rows() {
                return MatrixImpl.this.cols();
            }

            @Override
            public Stream<List<Atom>> cols() {
                return MatrixImpl.this.rows();
            }

            @Override
            public Matrix reshape(int rows, int cols, boolean recycle) {
                List<Atom> currentRavel = ravelData;
                if(!recycle) {
                    if (currentRavel.size() < rows * cols)
                        return new MatrixImpl(Stream.concat(currentRavel.stream(), Stream.generate(() -> isNumeric() ? new Atom(BigDecimal.ZERO) : Atom.NULL).limit(rows * cols - currentRavel.size())).collect(Collectors.toList()), rows, cols).transpose();
                } else {
                    if (currentRavel.size() < rows * cols)
                        return new MatrixImpl(Streams.stream(Iterables.cycle(currentRavel)).limit(rows * cols).collect(Collectors.toList()), rows, cols).transpose();
                }
                if (currentRavel.size() > rows * cols)
                    return new MatrixImpl(currentRavel.subList(0, rows * cols), rows, cols).transpose();
                else
                    return new MatrixImpl(currentRavel, rows, cols).transpose();
            }

            @Override
            public Matrix transpose() {
                return MatrixImpl.this;
            }

            @Override
            public boolean isNumeric() {
                return MatrixImpl.this.isNumeric();
            }
        };
    }
}
