package palaiologos.kamilalisp.runtime.math;

import ch.obermuhlner.math.big.BigComplex;
import ch.obermuhlner.math.big.BigDecimalMath;
import com.google.common.collect.Streams;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Arrays;
import java.util.List;

public class FFT extends PrimitiveFunction implements Lambda {
    /*
     * Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
     * The vector can have any length. This is a wrapper function.
     */
    public static void transform(MathContext mc, BigDecimal[] real, BigDecimal[] imag) {
        int n = real.length;
        if (n != imag.length)
            throw new IllegalArgumentException("Mismatched lengths");
        if (n == 0) {
        }
        else if ((n & (n - 1)) == 0)  // Is power of 2
            transformRadix2(mc, real, imag);
        else  // More complicated algorithm for arbitrary sizes
            transformBluestein(mc, real, imag);
    }


    /*
     * Computes the inverse discrete Fourier transform (IDFT) of the given complex vector, storing the result back into the vector.
     * The vector can have any length. This is a wrapper function. This transform does not perform scaling, so the inverse is not a true inverse.
     */
    public static void inverseTransform(MathContext mc, BigDecimal[] real, BigDecimal[] imag) {
        transform(mc, imag, real);
    }


    /*
     * Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
     * The vector's length must be a power of 2. Uses the Cooley-Tukey decimation-in-time radix-2 algorithm.
     */
    public static void transformRadix2(MathContext mc, BigDecimal[] real, BigDecimal[] imag) {
        // Length variables
        int n = real.length;
        if (n != imag.length)
            throw new IllegalArgumentException("Mismatched lengths");
        int levels = 31 - Integer.numberOfLeadingZeros(n);  // Equal to floor(log2(n))
        if (1 << levels != n)
            throw new IllegalArgumentException("Length is not a power of 2");

        // Trigonometric tables
        BigDecimal[] cosTable = new BigDecimal[n / 2];
        BigDecimal[] sinTable = new BigDecimal[n / 2];
        for (int i = 0; i < n / 2; i++) {
            cosTable[i] = BigDecimalMath.cos(BigDecimalMath.pi(mc).multiply(BigDecimal.valueOf(2 * i)).divide(BigDecimal.valueOf(n), mc), mc);
            sinTable[i] = BigDecimalMath.sin(BigDecimalMath.pi(mc).multiply(BigDecimal.valueOf(2 * i)).divide(BigDecimal.valueOf(n), mc), mc);
        }

        // Bit-reversed addressing permutation
        for (int i = 0; i < n; i++) {
            int j = Integer.reverse(i) >>> (32 - levels);
            if (j > i) {
                BigDecimal temp = real[i];
                real[i] = real[j];
                real[j] = temp;
                temp = imag[i];
                imag[i] = imag[j];
                imag[j] = temp;
            }
        }

        // Cooley-Tukey decimation-in-time radix-2 FFT
        for (int size = 2; size <= n; size *= 2) {
            int halfsize = size / 2;
            int tablestep = n / size;
            for (int i = 0; i < n; i += size) {
                for (int j = i, k = 0; j < i + halfsize; j++, k += tablestep) {
                    int l = j + halfsize;
                    BigDecimal tpre = real[l].multiply(cosTable[k]).add(imag[l].multiply(sinTable[k]));
                    BigDecimal tpim = real[l].negate().multiply(sinTable[k]).add(imag[l].multiply(cosTable[k]));
                    real[l] = real[j].subtract(tpre);
                    imag[l] = imag[j].subtract(tpim);
                    real[j] = real[j].add(tpre);
                    imag[j] = imag[j].add(tpim);
                }
            }
            if (size == n)  // Prevent overflow in 'size *= 2'
                break;
        }
    }


    /*
     * Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
     * The vector can have any length. This requires the convolution function, which in turn requires the radix-2 FFT function.
     * Uses Bluestein's chirp z-transform algorithm.
     */
    public static void transformBluestein(MathContext mc, BigDecimal[] real, BigDecimal[] imag) {
        // Find a power-of-2 convolution length m such that m >= n * 2 + 1
        int n = real.length;
        if (n != imag.length)
            throw new IllegalArgumentException("Mismatched lengths");
        if (n >= 0x20000000)
            throw new IllegalArgumentException("Array too large");
        int m = Integer.highestOneBit(n) * 4;

        // Trigonometric tables
        BigDecimal[] cosTable = new BigDecimal[n];
        BigDecimal[] sinTable = new BigDecimal[n];
        for (int i = 0; i < n; i++) {
            int j = (int)((long)i * i % (n * 2));  // This is more accurate than j = i * i
            BigDecimal quot = BigDecimal.valueOf(j).divide(BigDecimal.valueOf(n), mc);
            cosTable[i] = BigDecimalMath.cos(BigDecimalMath.pi(mc).multiply(quot), mc);
            sinTable[i] = BigDecimalMath.sin(BigDecimalMath.pi(mc).multiply(quot), mc);
        }

        // Temporary vectors and preprocessing
        BigDecimal[] areal = new BigDecimal[m];
        BigDecimal[] aimag = new BigDecimal[m];
        Arrays.fill(areal, BigDecimal.ZERO);
        Arrays.fill(aimag, BigDecimal.ZERO);
        for (int i = 0; i < n; i++) {
            areal[i] = real[i].multiply(cosTable[i]).add(imag[i].multiply(sinTable[i]));
            aimag[i] = real[i].negate().multiply(sinTable[i]).add(imag[i].multiply(cosTable[i]));
        }
        BigDecimal[] breal = new BigDecimal[m];
        BigDecimal[] bimag = new BigDecimal[m];
        Arrays.fill(breal, BigDecimal.ZERO);
        Arrays.fill(bimag, BigDecimal.ZERO);
        breal[0] = cosTable[0];
        bimag[0] = sinTable[0];
        for (int i = 1; i < n; i++) {
            breal[i] = breal[m - i] = cosTable[i];
            bimag[i] = bimag[m - i] = sinTable[i];
        }

        // Convolution
        BigDecimal[] creal = new BigDecimal[m];
        BigDecimal[] cimag = new BigDecimal[m];
        Arrays.fill(creal, BigDecimal.ZERO);
        Arrays.fill(cimag, BigDecimal.ZERO);
        convolve(mc, areal, aimag, breal, bimag, creal, cimag);

        // Postprocessing
        for (int i = 0; i < n; i++) {
            real[i] =  creal[i].multiply(cosTable[i]).add(cimag[i].multiply(sinTable[i]));
            imag[i] = creal[i].negate().multiply(sinTable[i]).add(cimag[i].multiply(cosTable[i]));
        }
    }

    /*
     * Computes the circular convolution of the given real vectors. Each vector's length must be the same.
     */
    public static void convolve(MathContext mc, BigDecimal[] xvec, BigDecimal[] yvec, BigDecimal[] outvec) {
        int n = xvec.length;
        if (n != yvec.length || n != outvec.length)
            throw new IllegalArgumentException("Mismatched lengths");
        convolve(mc, xvec, new BigDecimal[n], yvec, new BigDecimal[n], outvec, new BigDecimal[n]);
    }


    /*
     * Computes the circular convolution of the given complex vectors. Each vector's length must be the same.
     */
    public static void convolve(MathContext mc, BigDecimal[] xreal, BigDecimal[] ximag,
                                BigDecimal[] yreal, BigDecimal[] yimag, BigDecimal[] outreal, BigDecimal[] outimag) {

        int n = xreal.length;
        if (n != ximag.length || n != yreal.length || n != yimag.length
                || n != outreal.length || n != outimag.length)
            throw new IllegalArgumentException("Mismatched lengths");

        xreal = xreal.clone();
        ximag = ximag.clone();
        yreal = yreal.clone();
        yimag = yimag.clone();
        transform(mc, xreal, ximag);
        transform(mc, yreal, yimag);

        for (int i = 0; i < n; i++) {
            BigDecimal temp = xreal[i].multiply(yreal[i]).subtract(ximag[i].multiply(yimag[i]));
            ximag[i] = ximag[i].multiply(yreal[i]).add(xreal[i].multiply(yimag[i]));
            xreal[i] = temp;
        }
        inverseTransform(mc, xreal, ximag);

        for (int i = 0; i < n; i++) {  // Scaling (because this FFT implementation omits it)
            outreal[i] = xreal[i].divide(BigDecimal.valueOf(n), mc);
            outimag[i] = ximag[i].divide(BigDecimal.valueOf(n), mc);
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        List<Atom> data = args.get(0).getList();
        BigDecimal[] real = args.get(0).getList().stream().map(x -> x.getComplex().re).toArray(BigDecimal[]::new);
        BigDecimal[] imag = args.get(0).getList().stream().map(x -> x.getComplex().im).toArray(BigDecimal[]::new);
        transform(env.getMathContext(), real, imag);
        List<Atom> result = Streams.zip(Arrays.stream(real), Arrays.stream(imag), (re, im) -> new Atom(BigComplex.valueOf(re, im))).toList();
        return new Atom(result);
    }

    @Override
    protected String name() {
        return "fft";
    }
}
