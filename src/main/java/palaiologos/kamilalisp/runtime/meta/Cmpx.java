package palaiologos.kamilalisp.runtime.meta;

import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.*;

import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class Cmpx extends PrimitiveFunction implements SpecialForm {
    private static long getGC() {
        long garbageCollectionTime = 0;

        for (GarbageCollectorMXBean gc : ManagementFactory.getGarbageCollectorMXBeans()) {
            long time = gc.getCollectionTime();

            if (time >= 0) {
                garbageCollectionTime += time;
            }
        }

        return garbageCollectionTime;
    }

    private static boolean isSpecial(double d) {
        return Double.isNaN(d) || Double.isInfinite(d);
    }

    public static String doCmpx(Environment env, List<Atom> args) {
        long gcBefore = getGC();

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
            int cumTime = furtherTimings.get(0).stream().mapToInt(x -> x).sum() + initialTimings.get(i);
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

        System.gc();

        long gcAfter = getGC();

        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < args.size(); i++) {
            sb.append("Expression ").append(i).append(":\n");
            sb.append("\t").append(args.get(i)).append("\n");
            sb.append("avg: ").append(means.get(i)).append("ms, med: ").append(medians.get(i)).append("ms\n");
            sb.append("dev: ").append(stdDevs.get(i)).append("ms, %ch: ").append(isSpecial(percentageChange.get(i)) ? "--" : percentageChange.get(i)).append("%\n\n");
        }

        sb.append("GC time: ").append(gcAfter - gcBefore).append("ms\n");

        return sb.toString();
    }

    @Override
    public String name() {
        return "cmpx";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.isEmpty())
            throw new RuntimeException("cmpx requires at least one argument");

        System.out.println(doCmpx(env, args));
        return Atom.NULL;
    }
}
