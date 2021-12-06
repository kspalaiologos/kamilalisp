package kamilalisp.libs.math.bigop;

import java.math.* ;

/** Ratio of two univariate polynomials with rational coefficients.
* @since 2012-03-08
* @author Richard J. Mathar
*/
public class RationalPoly
{
        /** Numerator
        */
        RatPoly a;

        /** Denominator
        */
        RatPoly b;

        /** Ctor with explicit numerator and denominator polynomials.
        * @param num The numerator.
        * @param den The denominator.
        * @author Richard J. Mathar
        */
        public RationalPoly(RatPoly num, RatPoly den)
        {
                a = num ;
                b = den ;
        } /* ctor */

        /** Ctor with explicit numerator and denominator polynomials.
        * @param num The numerator.
        * @param den The denominator.
        */
        public RationalPoly(BigIntegerPoly num, BigIntegerPoly den)
        {
                a = num.toRatPoly() ;
                b = den.toRatPoly() ;
        } /* ctor */

        /** Ctor with explicit numerator.
        * The denominator is set to 1.
        * @param num The numerator.
        * @author Richard J. Mathar
        */
        public RationalPoly(RatPoly num)
        {
                a = num ;
                b = RatPoly.ONE ;
        } /* ctor */

        /** Subtract a constant.
        * @param oth The number to be subtracted
        * @return this-oth.
        * @author Richard J. Mathar
        */
        public RationalPoly minus(Rational oth)
        {
                /* a/b -c = (a-bc)/b
                */
                RatPoly newNum = a.subtract(b.multiply(oth)) ;
                return new RationalPoly(newNum,b) ;
        } /* minus */

        /** Subtract a constant.
        * @param oth The number to be subtracted
        * @return this-oth.
        * @author Richard J. Mathar
        */
        public RationalPoly minus(BigInteger oth)
        {
                /* forward to the other signature */
                return minus(new Rational(oth)) ;
        } /* minus */

        /** Build the inverse, 1 divided by this.
        * @return 1/this.
        * @author Richard J. Mathar
        */
        public RationalPoly inverse()
        {
                return new RationalPoly(b,a) ;
        } /* inverse */

} /* RationalPoly */
