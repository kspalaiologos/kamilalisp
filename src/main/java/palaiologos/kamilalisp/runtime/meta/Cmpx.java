package palaiologos.kamilalisp.runtime.meta;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class Cmpx extends PrimitiveFunction implements SpecialForm {
    @Override
    public String name() {
        return "cmpx";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            throw new RuntimeException("cmpx requires at least one argument");
        List<Integer> initialTimings = args.stream().map(x -> {
            int start = (int) System.currentTimeMillis();
            Evaluation.evaluate(env, x);
            return 1 + ((int) System.currentTimeMillis() - start);
        }).toList();
        // We want to ideally spend ~5s on each expression.
        List<Integer> times = initialTimings.stream().map(x -> 5000 / x).toList();
        List<List<Integer>> furtherTimings = Streams.zip(times.stream(), args.stream(), (x, y) -> {
            List<Integer> timings = new ArrayList<>();
            for (int i = 0; i < x; i++) {
                int start = (int) System.currentTimeMillis();
                Evaluation.evaluate(env, y);
                timings.add(1 + ((int) System.currentTimeMillis() - start));
            }
            return timings;
        }).toList();
        // Compute some interesting statistics about each expression.
        // Standard deviation, mean, median.
        List<Integer> means = new ArrayList<>();
        List<Integer> medians = new ArrayList<>();
        List<Integer> stdDevs = new ArrayList<>();
        for (int i = 0; i < args.size(); i++) {
            Integer cumTime = furtherTimings.get(0).stream().mapToInt(x -> x).sum() + initialTimings.get(i);
            Integer mean = cumTime / (times.get(i) + 1);
            means.add(mean);

            List<Integer> medianList =
                    Streams.concat(Stream.of(initialTimings.get(i)), furtherTimings.get(i).stream())
                            .sorted().toList();
            if (medianList.size() % 2 == 0) {
                medians.add((medianList.get(medianList.size() / 2) + medianList.get(medianList.size() / 2 - 1)) / 2);
            } else {
                medians.add(medianList.get(medianList.size() / 2));
            }

            Integer almostVariance =
                    Streams.concat(Stream.of(initialTimings.get(i)), furtherTimings.get(i).stream())
                            .map(x -> (x - mean) * (x - mean))
                            .reduce(Integer::sum).get();
            stdDevs.add((int) Math.sqrt(almostVariance / (times.get(i) + 1)));
        }

        Integer meanOfMeans = means.stream().mapToInt(x -> x).sum() / means.size();

        List<Double> percentageChange = means.stream().map(x -> (x - meanOfMeans) * 100.0 / meanOfMeans).toList();

        for (int i = 0; i < args.size(); i++) {
            System.out.println("Expression " + i + ":");
            System.out.println("\t" + args.get(i));
            System.out.println("avg: " + means.get(i) + "ms, med: " + medians.get(i) + "ms");
            System.out.println("dev: " + stdDevs.get(i) + "ms, %ch: " + percentageChange.get(i) + "%");
            if (i != args.size() - 1) System.out.println();
        }

        return Atom.NULL;
    }
}
