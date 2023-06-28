/*
 * MIT License
 *
 * Copyright (c) 2002-2023 Mikko Tommila
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package org.apfloat;

import java.math.BigInteger;
import java.io.PushbackReader;
import java.io.Writer;
import java.io.IOException;
import java.lang.ref.SoftReference;
import java.util.Formatter;
import static java.util.FormattableFlags.*;

import org.apfloat.spi.ApfloatImpl;
import static org.apfloat.spi.RadixConstants.*;

/**
 * Arbitrary precision rational number class. An aprational consists of
 * a numerator and a denominator of type {@link Apint}.<p>
 *
 * @see Apint
 * @see AprationalMath
 *
 * @version 1.10.0
 * @author Mikko Tommila
 */

public class Aprational
    extends Apfloat
{
    /**
     * Default constructor. To be used only by subclasses that
     * overload all needed methods.
     */

    protected Aprational()
    {
    }

    /**
     * Construct an integer aprational whose denominator is one.
     *
     * @param value The numerator of the number.
     */

    public Aprational(Apint value)
        throws ApfloatRuntimeException
    {
        this(value, ONES[value.radix()]);
    }

    /**
     * Construct an aprational with the specified numerator and denominator.
     *
     * @param numerator The numerator.
     * @param denominator The denominator.
     *
     * @exception IllegalArgumentException In case the denominator is zero, or if the denominator is not one or the numerator is not zero, and the radix of the numerator and denominator are different.
     */

    public Aprational(Apint numerator, Apint denominator)
        throws IllegalArgumentException, ApfloatRuntimeException
    {
        this.numerator = numerator;
        this.denominator = denominator;

        checkDenominator();

        reduce();
    }

    /**
     * Constructs an aprational from a string. The default radix is used.<p>
     *
     * The input must be of one of the formats<p>
     *
     * <code>integer</code><br>
     * <code>numerator [whitespace] "/" [whitespace] denominator</code><br>
     *
     * @param value The input string.
     *
     * @exception NumberFormatException In case the number is invalid.
     * @exception IllegalArgumentException In case the denominator is zero.
     */

    public Aprational(String value)
        throws NumberFormatException, IllegalArgumentException, ApfloatRuntimeException
    {
        this(value, ApfloatContext.getContext().getDefaultRadix());
    }

    /**
     * Constructs an aprational from a string with the specified radix.<p>
     *
     * The input must be of one of the formats<p>
     *
     * <code>integer</code><br>
     * <code>numerator [whitespace] "/" [whitespace] denominator</code><br>
     *
     * @param value The input string.
     * @param radix The radix to be used.
     *
     * @exception NumberFormatException In case the number is invalid.
     * @exception IllegalArgumentException In case the denominator is zero.
     */

    public Aprational(String value, int radix)
        throws NumberFormatException, IllegalArgumentException, ApfloatRuntimeException
    {
        int index = value.indexOf('/');
        if (index < 0)
        {
            this.numerator = new Apint(value, radix);
            this.denominator = ONES[radix];
            return;
        }

        this.numerator = new Apint(value.substring(0, index).trim(), radix);
        this.denominator = new Apint(value.substring(index + 1).trim(), radix);

        checkDenominator();

        reduce();
    }

    /**
     * Reads an aprational from a reader. The default radix is used. The constructor
     * stops reading at the first character it doesn't understand. The reader must
     * thus be a <code>PushbackReader</code> so that the invalid character can be
     * returned back to the stream.<p>
     *
     * The input must be of one of the formats<p>
     *
     * <code>integer [whitespace]</code><br>
     * <code>numerator [whitespace] "/" [whitespace] denominator</code><br>
     *
     * @param in The input stream.
     *
     * @exception IOException In case of I/O error reading the stream.
     * @exception NumberFormatException In case the number is invalid.
     * @exception IllegalArgumentException In case the denominator is zero.
     */

    public Aprational(PushbackReader in)
        throws IOException, NumberFormatException, IllegalArgumentException, ApfloatRuntimeException
    {
        this(in, ApfloatContext.getContext().getDefaultRadix());
    }

    /**
     * Reads an aprational from a reader. The specified radix is used.
     *
     * @param in The input stream.
     * @param radix The radix to be used.
     *
     * @exception IOException In case of I/O error reading the stream.
     * @exception NumberFormatException In case the number is invalid.
     * @exception IllegalArgumentException In case the denominator is zero.
     *
     * @see #Aprational(PushbackReader)
     */

    public Aprational(PushbackReader in, int radix)
        throws IOException, NumberFormatException, IllegalArgumentException, ApfloatRuntimeException
    {
        this.numerator = new Apint(in, radix);

        ApfloatHelper.extractWhitespace(in);

        if (!ApfloatHelper.readMatch(in, '/'))
        {
            this.denominator = ONES[radix];
            return;
        }

        ApfloatHelper.extractWhitespace(in);
        this.denominator = new Apint(in, radix);

        checkDenominator();

        reduce();
    }

    /**
     * Constructs an aprational from a <code>BigInteger</code>.
     * The default radix is used.
     *
     * @param value The numerator of the number.
     */

    public Aprational(BigInteger value)
        throws ApfloatRuntimeException
    {
        this.numerator = new Apint(value);
        this.denominator = ONE;
    }

    /**
     * Constructs an aprational from a <code>BigInteger</code> using the specified radix.
     *
     * @param value The numerator of the number.
     * @param radix The radix of the number.
     */

    public Aprational(BigInteger value, int radix)
        throws ApfloatRuntimeException
    {
        this.numerator = new Apint(value, radix);
        this.denominator = ONES[radix];
    }

    /**
     * Constructs an aprational from a <code>double</code>.
     * The exact value represented by the <code>double</code> is used.
     * The default radix is used.<p>
     *
     * Note that <code>double</code>s are presented as an integer multiplied by
     * a power of two (positive or negative). Many numbers can't be represented
     * exactly this way, e.g. <code>new Aprational(0.1)</code> won't result
     * in <code>1/10</code> but in <code>3602879701896397/36028797018963968</code>.
     *
     * @param value The numerator of the number.
     */

    public Aprational(double value)
        throws ApfloatRuntimeException
    {
        this(value, ApfloatContext.getContext().getDefaultRadix());
    }

    /**
     * Constructs an aprational from a <code>double</code> using the specified radix.
     * The exact value represented by the <code>double</code> is used.<p>
     *
     * Note that <code>double</code>s are presented as an integer multiplied by
     * a power of two (positive or negative). Many numbers can't be represented
     * exactly this way, e.g. <code>new Aprational(0.1)</code> won't result
     * in <code>1/10</code> but in <code>3602879701896397/36028797018963968</code>.
     *
     * @param value The numerator of the number.
     * @param radix The radix of the number.
     */

    public Aprational(double value, int radix)
        throws ApfloatRuntimeException
    {
        if (Double.isInfinite(value) || Double.isNaN(value))
        {
            throw new NumberFormatException(value + " is not a valid number");
        }
        long bits = Double.doubleToLongBits(value),
             sign = ((bits >> 63) == 0 ? 1 : -1),
             exponent = (bits >> 52) & 0x7FFL,
             significand = (exponent == 0 ? (bits & ((1L << 52) - 1)) << 1 : (bits & ((1L << 52) - 1)) | (1L << 52));
        exponent -= 1075;
        // At this point, value == sign * significand * 2^exponent

        if (significand == 0) // Zero
        {
            this.numerator = new Apint(0, radix);
            this.denominator = ONES[radix];
            return;
        }
        // Normalize so that the significand does not have a factor of two
        while ((significand & 1) == 0) // i.e. the significand is even
        {
            significand >>= 1;
            exponent++;
        }
        this.numerator = new Apint(sign * significand, radix);
        Apint powerOfTwo = ApintMath.pow(new Apint(2, radix), Math.abs(exponent));
        if (exponent >= 0)
        {
            this.numerator = this.numerator.multiply(powerOfTwo);
            this.denominator = ONES[radix];
            // No need to reduce as the value is an integer
        }
        else
        {
            this.denominator = powerOfTwo;
            // No need to reduce as the denominator is a power of two and the numerator does not have a factor of two
        }
    }

    /**
     * Numerator of this aprational.
     *
     * @return <code>n</code> where <code>this = n / m</code>.
     */

    public Apint numerator()
    {
        return this.numerator;
    }

    /**
     * Denominator of this aprational.
     *
     * @return <code>m</code> where <code>this = n / m</code>.
     */

    public Apint denominator()
    {
        return this.denominator;
    }

    /**
     * Radix of this aprational.
     *
     * @return Radix of this aprational.
     */

    @Override
    public int radix()
    {
        return (numerator() == ONE ? denominator().radix() : numerator().radix());
    }

    /**
     * Returns the precision of this aprational.
     *
     * @return <code>INFINITE</code>
     */

    @Override
    public long precision()
        throws ApfloatRuntimeException
    {
        return INFINITE;
    }

    /**
     * Returns the scale of this aprational. Scale is equal to the number of digits in the aprational's truncated value.<p>
     *
     * Zero has a scale of <code>-INFINITE</code>.
     *
     * @return Number of digits in the truncated value of this aprational in the radix in which it's presented.
     *
     * @see Apfloat#scale()
     */

    @Override
    public long scale()
        throws ApfloatRuntimeException
    {
        if (signum() == 0)
        {
            return -INFINITE;
        }

        if (this.scale == UNDEFINED)
        {
            long scale = numerator().scale() - denominator().scale();

            if (scale > 0)
            {
                scale = truncate().scale();
            }
            else
            {
                scale = AprationalMath.scale(this, 1 - scale).truncate().scale() + scale - 1;
            }

            // Writes and reads of volatile long values are always atomic so multiple threads can read and write this at the same time
            this.scale = scale;
        }

        return this.scale;
    }

    /**
     * Returns the size of this aprational. Size is equal to the number of significant
     * digits in the aprational's floating-point expansion. If the expansion is infinite
     * then this method returns <code>INFINITE</code>.<p>
     *
     * Zero has a size of <code>0</code>.
     *
     * @return Number of significant digits in the floating-point expansion of this aprational in the radix in which it's presented.
     *
     * @see Apfloat#size()
     *
     * @since 1.6
     */

    @Override
    public long size()
        throws ApfloatRuntimeException
    {
        if (signum() == 0)
        {
            return 0;
        }
        if (denominator().equals(ONE))
        {
            return numerator().size();
        }

        if (this.size == 0)
        {
            long size;

            // Check that the factorization of the divisor consists entirely of factors of the base
            // E.g. if base is 10=2*5 then the divisor should be 2^n*5^m
            Apint dividend = denominator();
            for (int i = 0; i < RADIX_FACTORS[radix()].length; i++)
            {
                Apint factor = new Apint(RADIX_FACTORS[radix()][i], radix());
                Apint[] quotientAndRemainder;

                // Keep dividing by factor as long as dividend % factor == 0
                // that is remove factors of the base from the divisor
                while ((quotientAndRemainder = ApintMath.div(dividend, factor))[1].signum() == 0)
                {
                    dividend = quotientAndRemainder[0];
                }
            }

            // Check if the divisor was factored all the way to one by just dividing by factors of the base
            if (!dividend.equals(ONE))
            {
                // No - infinite floating-point expansion
                size = INFINITE;
            }
            else
            {
                // Yes - calculate the number of digits
                // Scale the number so that all significant digits will fit in the integer part
                // The factor 5 is a rough estimate; e.g. if the denominator is 2^n then in base 34 we get close to that value
                size = ApintMath.scale(numerator(), denominator().scale() * 5).divide(denominator()).size();
            }

            // Writes and reads of volatile long values are always atomic so multiple threads can read and write this at the same time
            this.size = size;
        }

        return this.size;
    }

    /**
     * Returns the signum function of this aprational.
     *
     * @return -1, 0 or 1 as the value of this aprational is negative, zero or positive.
     */

    @Override
    public int signum()
    {
        return numerator().signum();
    }

    /**
     * Returns if this aprational is "short".
     *
     * @return <code>true</code> if the aprational is "short", <code>false</code> if not.
     *
     * @see Apfloat#isShort()
     */

    @Override
    public boolean isShort()
        throws ApfloatRuntimeException
    {
        return numerator().isShort() && denominator().equals(ONE);
    }

    /**
     * Returns if this number has an integer value. Note that this does not
     * necessarily mean that this object is an instance of {@link Apint}.<p>
     *
     * A rational number is an integer if the denominator is one.
     *
     * @return If this number's value is an integer.
     *
     * @since 1.9.0
     */

    @Override
    public boolean isInteger()
        throws ApfloatRuntimeException
    {
        return denominator().equals(ONE);
    }

    /**
     * Negative value.
     *
     * @return <code>-this</code>.
     *
     * @since 1.1
     */

    @Override
    public Aprational negate()
        throws ApfloatRuntimeException
    {
        return new Aprational(numerator().negate(), denominator());
    }

    /**
     * Adds two aprational numbers.
     *
     * @param x The number to be added to this number.
     *
     * @return <code>this + x</code>.
     */

    public Aprational add(Aprational x)
        throws ApfloatRuntimeException
    {
        return new Aprational(numerator().multiply(x.denominator()).add(denominator().multiply(x.numerator())),
                              denominator().multiply(x.denominator())).reduce();
    }

    /**
     * Subtracts two aprational numbers.
     *
     * @param x The number to be subtracted from this number.
     *
     * @return <code>this - x</code>.
     */

    public Aprational subtract(Aprational x)
        throws ApfloatRuntimeException
    {
        return new Aprational(numerator().multiply(x.denominator()).subtract(denominator().multiply(x.numerator())),
                              denominator().multiply(x.denominator())).reduce();
    }

    /**
     * Multiplies two aprational numbers.
     *
     * @param x The number to be multiplied by this number.
     *
     * @return <code>this * x</code>.
     */

    public Aprational multiply(Aprational x)
        throws ApfloatRuntimeException
    {
        Aprational result = new Aprational(numerator().multiply(x.numerator()),
                                           denominator().multiply(x.denominator()));

        if (this == x)
        {
            // When squaring we know that no reduction is needed
            return result;
        }
        else
        {
            return result.reduce();
        }
    }

    /**
     * Divides two aprational numbers.
     *
     * @param x The number by which this number is to be divided.
     *
     * @return <code>this / x</code>.
     *
     * @exception ArithmeticException In case the divisor is zero.
     */

    public Aprational divide(Aprational x)
        throws ArithmeticException, ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            throw new ArithmeticException(signum() == 0 ? "Zero divided by zero" : "Division by zero");
        }
        else if (signum() == 0)
        {
            // 0 / x = 0
            return this;
        }
        // Comparison against one would be inefficient at this point

        return new Aprational(numerator().multiply(x.denominator()),
                              denominator().multiply(x.numerator())).reduce();
    }

    /**
     * Calculates the remainder when divided by an aprational.
     * The result has the same sign as this number.
     * If <code>x</code> is zero, then zero is returned.
     *
     * @param x The number that is used as the divisor in the remainder calculation.
     *
     * @return <code>this % x</code>.
     *
     * @since 1.2
     */

    public Aprational mod(Aprational x)
        throws ApfloatRuntimeException
    {
        if (x.signum() == 0)
        {
            return x;                           // By definition
        }
        else if (signum() == 0)
        {
            // 0 % x = 0
            return this;
        }

        return subtract(divide(x).truncate().multiply(x));
    }

    /**
     * Floor function. Returns the largest (closest to positive infinity) value
     * that is not greater than this aprational and is equal to a mathematical integer.
     *
     * @return This aprational rounded towards negative infinity.
     */

    @Override
    public Apint floor()
        throws ApfloatRuntimeException
    {
        if (signum() >= 0)
        {
            return truncate();
        }
        else
        {
            return roundAway();
        }
    }

    /**
     * Ceiling function. Returns the smallest (closest to negative infinity) value
     * that is not less than this aprational and is equal to a mathematical integer.
     *
     * @return This aprational rounded towards positive infinity.
     */

    @Override
    public Apint ceil()
        throws ApfloatRuntimeException
    {
        if (signum() <= 0)
        {
            return truncate();
        }
        else
        {
            return roundAway();
        }
    }

    /**
     * Truncates fractional part.
     *
     * @return This aprational rounded towards zero.
     */

    @Override
    public Apint truncate()
        throws ApfloatRuntimeException
    {
        return numerator().divide(denominator());
    }

    /**
     * Returns the fractional part. The fractional part is always <code>0 &lt;= abs(x.frac()) &lt; 1</code>.
     * The fractional part has the same sign as the number. For the fractional and integer parts, this always holds:<p>
     *
     * <code>x = x.truncate() + x.frac()</code>
     *
     * @return The fractional part of this aprational.
     *
     * @since 1.7.0
     */

    @Override
    public Aprational frac()
        throws ApfloatRuntimeException
    {
        return new Aprational(numerator().mod(denominator()), denominator());
    }

    /**
     * Convert this aprational to the specified radix.
     *
     * @param radix The radix.
     *
     * @exception NumberFormatException If the radix is invalid.
     *
     * @since 1.2
     */

    @Override
    public Aprational toRadix(int radix)
        throws NumberFormatException, ApfloatRuntimeException
    {
        return new Aprational(numerator().toRadix(radix), denominator().toRadix(radix));
    }

    /**
     * Compare this aprational to the specified aprational.<p>
     *
     * @param x Aprational to which this aprational is to be compared.
     *
     * @return -1, 0 or 1 as this aprational is numerically less than, equal to, or greater than <code>x</code>.
     */

    public int compareTo(Aprational x)
    {
        Apint a = numerator().multiply(x.denominator()),
              b = x.numerator().multiply(denominator());

        return a.compareTo(b);
    }

    /**
     * Compare this aprational to the specified apfloat.<p>
     *
     * @param x Apfloat to which this aprational is to be compared.
     *
     * @return -1, 0 or 1 as this aprational is numerically less than, equal to, or greater than <code>x</code>.
     */

    @Override
    public int compareTo(Apfloat x)
    {
        if (x instanceof Aprational)
        {
            return compareTo((Aprational) x);
        }
        else
        {
            // Sub-optimal performance wise, but works
            Apfloat a = numerator().precision(INFINITE),                // Actual class must be Apfloat
                    b = x.multiply(denominator()).precision(INFINITE);  // Actual class must be Apfloat

            return a.compareTo(b);
        }
    }

    @Override
    public boolean preferCompare(Apfloat x)
    {
        return !(x instanceof Aprational);
    }

    /**
     * Compares this object to the specified object.<p>
     *
     * Note: if two apfloats are compared where one number doesn't have enough
     * precise digits, the mantissa is assumed to contain zeros.
     * See {@link Apfloat#compareTo(Apfloat)}.
     *
     * @param obj The object to compare with.
     *
     * @return <code>true</code> if the objects are the same; <code>false</code> otherwise.
     */

    @Override
    public boolean equals(Object obj)
    {
        if (obj == this)
        {
            return true;
        }
        else if (obj instanceof Aprational)
        {
            Aprational that = (Aprational) obj;
            return numerator().equals(that.numerator()) &&
                   denominator().equals(that.denominator());
        }
        else if (obj instanceof Apfloat)
        {
            Apfloat that = (Apfloat) obj;

            // Sub-optimal performance wise, but works
            Apfloat a = numerator().precision(INFINITE),                    // Actual class must be Apfloat
                    b = that.multiply(denominator()).precision(INFINITE);   // Actual class must be Apfloat

            return a.equals(b);
        }
        else
        {
            return super.equals(obj);
        }
    }

    /**
     * Tests two aprational numbers for equality.
     * Returns <code>false</code> if the numbers are definitely known to be not equal.
     * If <code>true</code> is returned, equality is unknown and should be verified by
     * calling {@link #equals(Object)}.
     * This method is usually significantly faster than calling <code>equals(Object)</code>.
     *
     * @param x The number to test against.
     *
     * @return <code>false</code> if the numbers are definitely not equal, <code>true</code> if unknown.
     *
     * @since 1.10.0
     */

    public boolean test(Aprational x)
    {
        return numerator().test(x.numerator()) && denominator().test(x.denominator());
    }

    @Override
    public boolean test(Apfloat x)
        throws ApfloatRuntimeException
    {
        if (x instanceof Aprational)
        {
            return test((Aprational) x);
        }
        else
        {
            return !isInteger() || numerator().test(x);
        }
    }

    /**
     * Returns a hash code for this aprational.
     *
     * @return The hash code value for this object.
     */

    @Override
    public int hashCode()
    {
        return numerator().hashCode() * 3 +
               denominator().hashCode();
    }

    /**
     * Returns a string representation of this aprational.
     *
     * @return A string representing this object.
     */

    @Override
    public String toString()
    {
        return toString(true);
    }

    /**
     * Returns a string representation of this aprational.
     *
     * @param pretty <code>true</code> to use a fixed-point notation, <code>false</code> to use an exponential notation.
     *
     * @return A string representing this object.
     */

    @Override
    public String toString(boolean pretty)
        throws ApfloatRuntimeException
    {
        return numerator().toString(pretty) +
               (denominator().equals(ONE) ? "" : '/' + denominator().toString(pretty));
    }

    /**
     * Write a string representation of this aprational to a <code>Writer</code>.
     *
     * @param out The output <code>Writer</code>.
     *
     * @exception IOException In case of I/O error writing to the stream.
     */

    @Override
    public void writeTo(Writer out)
        throws IOException, ApfloatRuntimeException
    {
        writeTo(out, true);
    }

    /**
     * Write a string representation of this aprational to a <code>Writer</code>.
     *
     * @param out The output <code>Writer</code>.
     * @param pretty <code>true</code> to use a fixed-point notation, <code>false</code> to use an exponential notation.
     *
     * @exception IOException In case of I/O error writing to the stream.
     */

    @Override
    public void writeTo(Writer out, boolean pretty)
        throws IOException, ApfloatRuntimeException
    {
        numerator().writeTo(out, pretty);
        if (!denominator().equals(ONE))
        {
            out.write('/');
            denominator().writeTo(out, pretty);
        }
    }

    /**
     * Formats the object using the provided formatter.
     *
     * @param formatter The formatter.
     * @param flags The flags to modify the output format.
     * @param width The minimum number of characters to be written to the output, or <code>-1</code> for no minimum.
     * @param precision The maximum number of characters to be written to the output, or <code>-1</code> for no maximum.
     *
     * @since 1.3
     */

    @Override
    public void formatTo(Formatter formatter, int flags, int width, int precision)
    {
        if (denominator().equals(ONE))
        {
            numerator().formatTo(formatter, flags, width, precision);
        }
        else
        {
            if (width == -1)
            {
                numerator().formatTo(formatter, flags, width, precision);
                formatter.format("/");
                denominator().formatTo(formatter, flags, width, precision);
            }
            else
            {
                try
                {
                    Writer out = FormattingHelper.wrapAppendableWriter(formatter.out());
                    out = FormattingHelper.wrapPadWriter(out, (flags & LEFT_JUSTIFY) == LEFT_JUSTIFY);
                    formatter = new Formatter(out, formatter.locale());
                    numerator().formatTo(formatter, flags, -1, precision);
                    formatter.format("/");
                    denominator().formatTo(formatter, flags, -1, precision);
                    FormattingHelper.finishPad(out, width);
                }
                catch (IOException ioe)
                {
                    // Ignore as we can't propagate it; unfortunately we can't set it to the formattable either
                }
            }
        }
    }

    /**
     * Returns an <code>ApfloatImpl</code> representing the approximation of this
     * aprational up to the requested precision.<p>
     *
     * @param precision Precision of the <code>ApfloatImpl</code> that is needed.
     *
     * @return An <code>ApfloatImpl</code> representing this object to the requested precision.
     */

    @Override
    protected ApfloatImpl getImpl(long precision)
        throws ApfloatRuntimeException
    {
        return ensureApprox(precision).getImpl(precision);
    }

    // Round away from zero i.e. opposite direction of rounding than in truncate()
    @Override
    Apint roundAway()
        throws ApfloatRuntimeException
    {
        Apint[] div = ApintMath.div(numerator(), denominator());

        if (div[1].signum() == 0)
        {
            // No remainder from division; result is exact
            return div[0];
        }
        else
        {
            // Remainder from division; round away from zero
            return div[0].add(new Apint(signum(), div[0].radix()));
        }
    }

    @Override
    Aprational scale(long scale)
    {
        return AprationalMath.scale(this, scale);
    }

    @Override
    Aprational abs()
    {
        return AprationalMath.abs(this);
    }

    @Override
    int compareToHalf()
    {
        return RoundingHelper.compareToHalf(this);
    }

    private void checkDenominator()
        throws IllegalArgumentException
    {
        if (this.denominator.signum() == 0)
        {
            throw new IllegalArgumentException("Denominator is zero");
        }
    }

    // Reduce the numerator and denominator to smallest possible terms and set the signs properly
    // NOTE: the method mutates this object, so it must only be called for newly constructed aprationals
    // Returns this, for convenience
    private Aprational reduce()
        throws IllegalArgumentException, ApfloatRuntimeException
    {
        if (this.numerator.signum() == 0)
        {
            this.denominator = ONES[this.denominator.radix()];
        }
        else
        {
            if (!this.numerator.equals(ONE) && !this.denominator.equals(ONE))
            {
                if (this.numerator.radix() != this.denominator.radix())
                {
                    throw new IllegalArgumentException("Numerator and denominator must have the same radix");
                }

                Apint gcd = ApintMath.gcd(this.numerator, this.denominator);
                this.numerator = this.numerator.divide(gcd);
                this.denominator = this.denominator.divide(gcd);
            }

            int sign = this.numerator.signum() * this.denominator.signum();

            this.denominator = ApintMath.abs(this.denominator);

            if (sign != this.numerator.signum())
            {
                this.numerator = this.numerator.negate();
            }
        }

        return this;
    }

    private synchronized Apfloat ensureApprox(long precision)
        throws ApfloatRuntimeException
    {
        Apfloat approx = getApprox(precision);
        if (approx == null || approx.precision() < precision)
        {
            if (denominator().equals(ONE))
            {
                approx = numerator();
            }
            else
            {
                precision = Math.max(precision, 1);     // In case the requested precision would be zero

                if (denominator().isShort())
                {
                    approx = numerator().precision(precision).divide(denominator());
                    setApprox(approx);
                }
                else
                {
                    Apfloat inverseDen = getInverseDen();
                    inverseDen = ApfloatMath.inverseRoot(denominator(), 1, precision, inverseDen);
                    approx = numerator().multiply(inverseDen);
                    setApprox(approx);
                    setInverseDen(inverseDen);
                }
            }
        }

        return approx;
    }

    private Apfloat getApprox(long precision)
    {
        return (this.approx == null ? null : this.approx.get());
    }

    private void setApprox(Apfloat approx)
    {
        this.approx = new SoftReference<>(approx);
    }

    private Apfloat getInverseDen()
    {
        return (this.inverseDen == null ? null : this.inverseDen.get());
    }

    private void setInverseDen(Apfloat inverseDen)
    {
        this.inverseDen = new SoftReference<>(inverseDen);
    }

    private static final long serialVersionUID = -224128535732558313L;

    private static final long UNDEFINED = 0x8000000000000000L;

    private Apint numerator;
    private Apint denominator;
    private volatile long scale = UNDEFINED;
    private volatile long size = 0;
    private transient SoftReference<Apfloat> inverseDen = null;
    private transient SoftReference<Apfloat> approx = null;
}
