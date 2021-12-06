package kamilalisp.libs.math.bigop;

import java.security.* ;
import java.math.* ;

/** Square roots on the real line.
* These represent numbers which are a product of a (signed) fraction by
* a square root of a non-negative fraction.
* This might be extended to values on the imaginary axis by allowing negative
* values underneath the square root, but this is not yet implemented.
* @since 2011-02-12
* @author Richard J. Mathar
*/
public class BigSurd implements Cloneable, Comparable<BigSurd>
{
        /** The value of zero.
        */
        static public BigSurd ZERO = new BigSurd() ;

        /** The value of one.
        */
        static public BigSurd ONE = new BigSurd(Rational.ONE,Rational.ONE) ;
        /** Prefactor
        */
        Rational pref ;

        /** The number underneath the square root, always non-negative.
        * The mathematical object has the value pref*sqrt(disc).
        */
        Rational disc ;

        /** Default ctor, which represents the zero.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd()
        {
                pref = Rational.ZERO ;
                disc = Rational.ZERO ;
        } /* ctor */

        /** ctor given the prefactor and the basis of the root.
        * This creates an object of value a*sqrt(b).
        * @param a the prefactor.
        * @param b the discriminant.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd(Rational a, Rational b)
        {
                this.pref = a ;
                /* reject attempts to use a negative b
                */
                if ( b.signum() < 0 )
                        throw new ProviderException("Not implemented: imaginary surds") ;
                this.disc = b ;
                normalize() ;
                normalizeG() ;
        } /* ctor */

        /** ctor given the numerator and denominator of the root.
        * This creates an object of value sqrt(a/b).
        * @param a the numerator
        * @param b the denominator.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd(int a, int b)
        {
                this( Rational.ONE, new Rational(a,b) ) ;
        } /* ctor */

        /** ctor given the value under the root.
        * This creates an object of value sqrt(a).
        * @param a the discriminant.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd(BigInteger a)
        {
                this( Rational.ONE, new Rational(a,BigInteger.ONE) ) ;
        } /* ctor */

        /** Create a deep copy.
        * @since 2011-02-12
        */
        public BigSurd clone()
        {
                Rational fclon = pref.clone() ;
                Rational dclon = disc.clone() ;
                /* the main intent here is to bypass any attempt to reduce the discriminant
                * by figuring out the square-free part in normalize(), which has already done
                * in the current copy of the number.
                */
                BigSurd cl = new BigSurd() ;
                cl.pref = fclon ;
                cl.disc = dclon ;
                return cl ;
        } /* BigSurd.clone */

        /** Add two surds of compatible discriminant.
        * @param val The value to be added to this.
        * @return The sum of this and val
        * @author Richard J. Mathar
        */
        public BigSurdVec add(final BigSurd val)
        {
                /* zero plus somethings yields something
                */
                if ( signum() == 0 )
                        return new BigSurdVec(val) ;
                else if (val.signum() == 0  )
                        return new BigSurdVec(this) ;
                else
                        /* let the ctor of BigSurdVec to the work */
                        return new BigSurdVec(this,val) ;
        } /* add */

        /** Multiply by another square root.
        * @param val a second number of this type.
        * @return the product of this with the val.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd multiply(final BigSurd val)
        {
                return new BigSurd( pref.multiply(val.pref), disc.multiply(val.disc) ) ;
        } /* BigSurd.multiply */

        /** Multiply by a rational number.
        * @param val the factor.
        * @return the product of this with the val.
        * @since 2011-02-15
        * @author Richard J. Mathar
        */
        public BigSurd multiply(final Rational val)
        {
                return new BigSurd( pref.multiply(val), disc) ;
        } /* BigSurd.multiply */

        /** Multiply by a BigInteger.
        * @param val a second number.
        * @return the product of this with the value.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd multiply(final BigInteger val)
        {
                return new BigSurd(pref.multiply(val), disc) ;
        } /* BigSurd.multiply */

        /** Multiply by an integer.
        * @param val a second number.
        * @return the product of this with the value.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd multiply(final int val)
        {
                BigInteger tmp = new BigInteger(""+val) ;
                return multiply(tmp) ;
        } /* BigSurd.multiply */


        /** Compute the square.
        * @return this value squared.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public Rational sqr()
        {
                Rational res = pref.pow(2) ;
                res = res.multiply(disc) ;
                return res;
        } /* BigSurd.sqr */

        /** Divide by another square root.
        * @param val A second number of this type.
        * @return The value of this/val
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd divide(final BigSurd val)
        {
                if( val.signum() == 0 )
                        throw new ArithmeticException("Dividing "+ toString() + " through zero.") ;
                return new BigSurd( pref.divide(val.pref), disc.divide(val.disc) ) ;
        } /* BigSurd.divide */

        /** Divide by an integer.
        * @param val a second number.
        * @return the value of this/val
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd divide(final BigInteger val)
        {
                if( val.signum() == 0 )
                        throw new ArithmeticException("Dividing "+ toString() + " through zero.") ;
                return new BigSurd( pref.divide(val), disc ) ;
        } /* BigSurd.divide */

        /** Divide by an integer.
        * @param val A second number.
        * @return The value of this/val
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd divide(int val)
        {
                if( val == 0 )
                        throw new ArithmeticException("Dividing "+ toString() + " through zero.") ;
                return new BigSurd( pref.divide(val), disc ) ;
        } /* BigSurd.divide */

        /** Compute the negative.
        * @return -this.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd negate()
        {
                /* This is trying to be quick, avoiding normalize(), by toggling
                * the sign in a clone()
                */
                BigSurd n = clone() ;
                n.pref = n.pref.negate() ;
                return n ;
        } /* BigSurd.negate */

        /** Absolute value.
        * @return The absolute (non-negative) value of this.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurd abs()
        {
                return new BigSurd(pref.abs(),disc) ;
        }

        /** Compares the value of this with another constant.
        * @param val the other constant to compare with
        * @return -1, 0 or 1 if this number is numerically less than, equal to,
        *    or greater than val.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public int compareTo(final BigSurd val)
        {
                /* Since we keep the discriminant positive, the rough estimate
                * comes from comparing the signs of the prefactors.
                */
                final int sig = signum() ;
                final int sigv = val.signum() ;
                if ( sig < 0 && sigv >= 0 )
                        return -1 ;
                if ( sig > 0 && sigv <= 0 )
                        return 1 ;
                if ( sig == 0 && sigv == 0 )
                        return 0 ;
                if ( sig == 0 && sigv > 0 )
                        return -1 ;
                if ( sig == 0 && sigv < 0 )
                        return 1 ;

                /* Work out the cases of equal sign. Compare absolute values by comparison
                * of the squares which is forwarded to the comparison of the Rational class.
                */
                final Rational this2 = sqr() ;
                final Rational val2 = val.sqr() ;
                final int c = this2.compareTo(val2) ;
                if ( c == 0 )
                        return 0 ;
                /* If both values have negative sign, the one with the smaller square is the larger number.
                */
                else if ( sig >0 && c >0 || sig <0 && c <0 )
                        return 1;
                else
                        return -1 ;
        } /* BigSurd.compareTo */

        /** Return a string in the format (number/denom)*()^(1/2).
        * If the discriminant equals 1, print just the prefactor.
        * @return the human-readable version in base 10
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public String toString()
        {
                if ( disc.compareTo(Rational.ONE) != 0 && disc.compareTo(Rational.ZERO) != 0)
                        return( "("+pref.toString()+")*("+disc.toString()+")^(1/2)" ) ;
                else
                        return pref.toString() ;
        } /* BigSurd.toString */

        /** Return a double value representation.
        * @return The value with double precision.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public double doubleValue()
        {
                /* First compute the square to prevent overflows if the two pieces of
                * the prefactor and the discriminant are of very different magnitude.
                */
                Rational p2 = pref.pow(2).multiply(disc) ;
                double res = p2.doubleValue() ;
                return (pref.signum() >= 0) ? Math.sqrt(res) : -Math.sqrt(res) ;
        } /* BigSurd.doubleValue */

        /** Return a float value representation.
        * @return The value with single precision.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public float floatValue()
        {
                return (float)(doubleValue()) ;
        } /* BigSurd.floatValue */

        /** True if the value is integer.
        * Equivalent to the indication whether a conversion to an integer
        * can be exact.
        * @return True if the value can be exactly represented as an integer.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public boolean isBigInteger()
        {
                return pref.isBigInteger() && ( disc.signum() ==0 || disc.compareTo(Rational.ONE) == 0 ) ;
        } /* BigSurd.isBigInteger */

        /** True if the value is rational.
        * Equivalent to the indication whether a conversion to a Rational can be exact.
        * @return True if the value can be exactly represented as a rational number.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public boolean isRational()
        {
                return ( disc.signum() ==0 || disc.compareTo(Rational.ONE) == 0 ) ;
        } /* BigSurd.isRational */

        /** Convert to a rational value if possible
        * @return The equivalent representation as a rational number.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public Rational toRational()
        {
                if ( isRational() )
                        return pref ;
                else
                        throw new ArithmeticException("Undefined conversion "+ toString() + " to Rational.") ;
        } /* BigSurd.toRational */

        /** The sign: 1 if the number is larger than 0, 0 if it equals zero, -1 if it is less than zero
        * @return the signum of the value.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public int signum()
        {
                /* Since the disc is kept positive, this is the same
                * as the sign of the prefactor. This works because a zero discriminant
                * is always copied over to the prefactor, not hidden.
                */
                return pref.signum() ;
        } /* BigSurd.signum */

        /** Normalize to squarefree discriminant.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        protected void normalize()
        {
                /* Move squares out of the numerator and denominator of the discriminant
                */
                if ( disc.signum() != 0 )
                {
                        /* square-free part of the numerator: numer = numC*some^2
                        */
                        BigInteger numC = BigIntegerMath.core(disc.numer()) ;
                        /* extract the perfect square of the numerator
                        */
                        BigInteger sq = disc.numer().divide(numC) ;
                        /* extract the associated square root
                        */
                        BigInteger sqf = BigIntegerMath.isqrt(sq) ;

                        /* move sqf over to the pre-factor
                        */
                        pref = pref.multiply(sqf) ;

                        BigInteger denC = BigIntegerMath.core(disc.denom()) ;
                        sq = disc.denom().divide(denC) ;
                        sqf = BigIntegerMath.isqrt(sq) ;
                        pref = pref.divide(sqf) ;

                        disc = new Rational(numC,denC) ;
                }
                else
                        pref = Rational.ZERO ;
        } /* BigSurd.normalize */

        /** Normalize to coprime numerator and denominator in prefactor and discriminant
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        protected void normalizeG()
        {
                /* Is there a common factor between the numerator of the prefactor
                * and the denominator of the discriminant ?
                */
                BigInteger d = pref.numer().abs().gcd( disc.denom()) ;
                if ( d.compareTo(BigInteger.ONE) > 0 )
                {
                        pref = pref.divide(d) ;
                        /* instead of multiplying with the square of d, using two steps
                        * offers a change to recognize the common factor..
                        */
                        disc = disc.multiply(d) ;
                        disc = disc.multiply(d) ;
                }
                /* Is there a common factor between the denominator of the prefactor
                * and the numerator of the discriminant ?
                */
                d = pref.denom().gcd( disc.numer()) ;
                if ( d.compareTo(BigInteger.ONE) > 0 )
                {
                        pref = pref.multiply(d) ;
                        /* instead of dividing through the square of d, using two steps
                        * offers a change to recognize the common factor..
                        */
                        disc = disc.divide(d) ;
                        disc = disc.divide(d) ;
                }
        } /* BigSurd.normalizeG */

        /** Return the approximate floating point representation.
        * @param mc Description of the accuracy needed.
        * @return A representation with digits valid as described by mc
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public BigDecimal BigDecimalValue(MathContext mc)
        {
                /* the relative error of the result equals the relative error of the
                * prefactor plus half of the relative error of the discriminant.
                * So adding 3 digits temporarily is sufficient.
                */
                final MathContext locmc = new MathContext(mc.getPrecision()+3,mc.getRoundingMode()) ;
                /* first the square root of the discriminant
                */
                BigDecimal sqrdis = BigDecimalMath.sqrt(disc.BigDecimalValue(locmc),locmc ) ;
                /* Then multiply by the prefactor. If sqrdis is a terminating decimal fraction,
                * we prevent early truncation of the result by truncating later.
                */
                BigDecimal res = sqrdis.multiply(pref.BigDecimalValue(mc)) ;
                return BigDecimalMath.scalePrec(res,mc) ;
        } /* BigDecimalValue */



} /* BigSurd */

