package kamilalisp.matrix;

import com.google.common.base.CharMatcher;
import com.google.common.collect.Streams;
import kamilalisp.data.Atom;

import java.util.Arrays;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public abstract class Matrix {
    public abstract int getRows();
    public abstract int getCols();

    public abstract Atom get(int row, int col);
    public abstract List<Atom> ravel();
    public abstract Stream<List<Atom>> rows();
    public abstract Stream<List<Atom>> cols();

    public abstract Matrix reshape(int rows, int cols, boolean recycle);

    public abstract Matrix transpose();

    public abstract boolean isNumeric();

    public Matrix transmogrifyRank0(Function<Atom, Atom> f) {
        return from(ravel().stream().map(x -> f.apply(x)).collect(Collectors.toList()), getRows(), getCols());
    }

    public Matrix transmogrifyRank0(BiFunction<Atom, Atom, Atom> f, Matrix other) {
        if(getRows() != other.getRows() || getCols() != other.getCols()) {
            throw new IllegalArgumentException("Matrices must have the same dimensions");
        }

        return from(Streams.zip(this.ravel().stream(), other.ravel().stream(), (x, y) -> f.apply(x, y)).collect(Collectors.toList()), getRows(), getCols());
    }

    public Matrix transmogrifyRowsRank1(Function<List<Atom>, List<Atom>> f) {
        return from(rows().map(f).collect(Collectors.toList()));
    }

    public Matrix transmogrifyColsRank1(Function<List<Atom>, List<Atom>> f) {
        return from(cols().map(f).collect(Collectors.toList()));
    }

    public Matrix transmogrifyRowsRank1(BiFunction<List<Atom>, List<Atom>, List<Atom>> f, Matrix other) {
        return from(Streams.zip(this.rows(), other.rows(), (x, y) -> f.apply(x, y)).collect(Collectors.toList()));
    }

    public Matrix transmogrifyColsRank1(BiFunction<List<Atom>, List<Atom>, List<Atom>> f, Matrix other) {
        return from(Streams.zip(this.cols(), other.cols(), (x, y) -> f.apply(x, y)).collect(Collectors.toList()));
    }

    public Matrix transmogrifyRowsColsRank1(BiFunction<List<Atom>, List<Atom>, List<Atom>> f, Matrix other) {
        return from(Streams.zip(this.rows(), other.cols(), (x, y) -> f.apply(x, y)).collect(Collectors.toList()));
    }

    public Matrix transmogrifyColsRowsRank1(BiFunction<List<Atom>, List<Atom>, List<Atom>> f, Matrix other) {
        return from(Streams.zip(this.cols(), other.rows(), (x, y) -> f.apply(x, y)).collect(Collectors.toList()));
    }

    public List<Atom> foldColsRank1(Function<List<Atom>, Atom> reductor) {
        return cols().map(reductor).collect(Collectors.toList());
    }

    public List<Atom> foldRowsRank1(Function<List<Atom>, Atom> reductor) {
        return rows().map(reductor).collect(Collectors.toList());
    }

    public static Matrix from(List<List<Atom>> a) {
        return new MatrixImpl(a);
    }

    public static Matrix from(List<Atom> a, int rows, int cols) {
        return new MatrixImpl(a, rows, cols);
    }

    public static Matrix of(BiFunction<Integer, Integer, Atom> generator, int rows, int cols) {
        return from(IntStream.range(0, rows).mapToObj(i -> IntStream.range(0, cols).mapToObj(j -> generator.apply(i, j)).collect(Collectors.toList())).collect(Collectors.toList()));
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Matrix matrix = (Matrix) o;

        if (getRows() != matrix.getRows()) return false;
        if (getCols() != matrix.getCols()) return false;
        return ravel().equals(matrix.ravel());
    }

    @Override
    public String toString() {
        List<List<String>> stringifiedRows = rows().map(x -> x.stream().map(Atom::toString).collect(Collectors.toList())).collect(Collectors.toList());
        List<Integer> columnWidths = IntStream.range(0, getCols())
                .mapToObj(i -> stringifiedRows.stream().mapToInt(row -> {
                    if(row.get(i).contains("\n"))
                        return Arrays.stream(row.get(i).split("\n")).mapToInt(s -> s.length()).max().orElse(0);
                    return row.get(i).length();
                }).max().orElse(0))
                .collect(Collectors.toList());
        List<Integer> rowHeights = IntStream.range(0, getRows())
                .mapToObj(i -> stringifiedRows.get(i).stream().mapToInt(str -> {
                    if(str.contains("\n"))
                        return CharMatcher.is('\n').countIn(str);
                    return 1;
                }).max().orElse(0))
                .collect(Collectors.toList());

        // The algorithm is starting with drawing the matrix border.
        String result = "+" + String.join("+", columnWidths.stream().map(w -> "-".repeat(w + 2)).collect(Collectors.toList())) + "+\n";

        // Then, we draw the rows.
        for (int i = 0; i < getRows(); i++) {
            int kludge = i;
            for(int j = 0; j < rowHeights.get(i); j++) {
                int kludge2 = j;
                result += "|" + IntStream.range(0, getCols()).mapToObj(n -> {
                    String s = stringifiedRows.get(kludge).get(n);
                    if (s.contains("\n")) {
                        String[] arr = s.split("\n");
                        if(arr.length < kludge2)
                            s = "";
                        else
                            s = arr[kludge2];
                    } else if(kludge2 > 0)
                        s = "";
                    return " " + s + " ".repeat(columnWidths.get(n) + 1 - s.length());
                }).collect(Collectors.joining("|")) + "|\n";
            }
            result += "+" + String.join("+", columnWidths.stream().map(w -> "-".repeat(w + 2)).collect(Collectors.toList())) + "+\n";
        }

        return result.trim();
    }
}
