package kamilalisp.libs.math.bigop;

import java.lang.* ;
import java.util.* ;
import java.math.* ;

/** A uni-variant polynomial with rational coefficients.
* Alternatively to be interpreted as a sequence which has the polynomial as an (approximate)
* generating function.
* @since 2006-06-25
* @author Richard J. Mathar
*/
class RatPoly
{
        /** The list of all coefficients, ascending exponents. Starting with a0, then a1, representing
        * a value a0+a1*x+a2*x^2+a3*x^3+...
        */
        protected Vector<Rational> a ;

        /** The constant 1
        */
        static public final RatPoly ONE = new RatPoly("1") ;

        /** Default ctor.
        * Initializes the zero-valued polynomial x=0.
        * @author Richard J. Mathar
        */
        public RatPoly()
        {
                a = new Vector<Rational>() ;
        } /* ctor */

        /** Constructor with an explicit list of coefficients.
        * @param L the coefficients a0, a1, a2, a3,.., A deep copy of the these is created.
        * @author Richard J. Mathar
        */
        public RatPoly(final Vector<Rational> L)
        {
                a = new Vector<Rational>() ;
                for(int i=0 ; i < L.size() ; i++)
                        a.add( L.elementAt(i).clone() ) ;
                simplify() ;
        } /* ctor */

        /** Constructor with a comma-separated list as the list of coefficients.
        * @param L the string of the form a0,a1,a2,a3 with the coefficients
        * @author Richard J. Mathar
        */
        public RatPoly(final String L) throws NumberFormatException
        {
                a = new Vector<Rational>() ;
                Scanner sc = new Scanner(L) ;
                sc.useDelimiter(",") ;
                while ( sc.hasNext())
                {
                        String tok =sc.next() ;
                        a.add(new Rational(tok)) ;
                }
                simplify() ;
        } /* ctor */


        /** Constructor from a hypergeometric series.
        * @param A the list of values in the numerator of AFB
        * @param B the list of values in the denominator of AFB
        * @param nmax the order of the truncated polynomial representation
        * @since 2008-11-13
        * @author Richard J. Mathar
        */
        public RatPoly(final Vector<BigInteger> A, final Vector<BigInteger> B, int nmax)
        {
                /* To allow common initialization with the signature below,
                * the main body is assembled in a separate function.
                */
                init(A,B,nmax) ;
        }


        /** Constructor from a hypergeometric series.
        * @param A the list of values in the numerator of AFB.
        *   At least one of these values must be a negative integer, which implicitly determines
        *   the order of the new polynomial.
        * @param B the list of values in the denominator of AFB
        * @since 2009-08-05
        * @author Richard J. Mathar
        */
        public RatPoly(final Vector<BigInteger> A, final Vector<BigInteger> B)
        {
                BigInteger Nmax = BigInteger.ONE.negate() ;
                for(int j=0; j < A.size() ; j++)
                {
                        if ( A.elementAt(j).compareTo(BigInteger.ZERO) <= 0)
                        {
                                if  ( Nmax.compareTo(BigInteger.ZERO) < 0 )
                                        Nmax = A.elementAt(j).negate() ;
                                else
                                        Nmax = Nmax.min( A.elementAt(j).negate() ) ;
                        }
                }
                if ( Nmax.compareTo(BigInteger.ZERO) < 0 )
                        throw new ArithmeticException("Infinite Number of Terms in Series "+Nmax.toString()) ;

                int nmax = Nmax.intValue()-1 ;
                init(A,B,nmax) ;
        } /* ctor */

        /** Constructor from a hypergeometric series.
        * @param A the list of values in the numerator of AFB
        * @param B the list of values in the denominator of AFB
        * @param nmax the order of the truncated polynomial representation
        * @since 2008-11-13
        * @author Richard J. Mathar
        */
        protected void init(final Vector<BigInteger> A, final Vector<BigInteger> B, int nmax)
        {
                a = new Vector<Rational>() ;
                Factorial f=new Factorial() ;
                for( int n=0; n <= nmax ; n++)
                {
                        Rational c = new Rational(1,1) ;
                        for(int j=0; j < A.size() ; j++)
                        {
                                Rational aEl = new Rational(A.elementAt(j)) ;
                                c = c.multiply(aEl.Pochhammer(n)) ;
                        }
                        for(int j=0; j < B.size() ; j++)
                        {
                                Rational bEl = new Rational(B.elementAt(j)) ;
                                c = c.divide(bEl.Pochhammer(n)) ;
                        }
                        c =c.divide(f.at(n)) ;
                        a.add(c) ;
                }
                simplify() ;
        } /* init */


        /** Create a copy of this.
        * @since 2008-11-07
        * @author Richard J. Mathar
        */
        public RatPoly clone()
        {
                RatPoly clo = new RatPoly() ;
                clo.a = (Vector<Rational>)a.clone() ;
                return clo ;
        } /* clone */

        /** Retrieve a polynomial coefficient.
        * @param n the zero-based index of the coefficient. n=0 for the constant term. 
        * @return the polynomial coefficient in front of x^n.
        * @author Richard J. Mathar
        */
        public Rational at(final int n)
        {
                if ( n < a.size())
                        return( a.elementAt(n) ) ;
                else
                        return( new Rational(0,1) ) ;
        } /* at */

        /** Horner scheme to find the function value at the argument x
        * @param x The argument of the polynomial
        * @param mc The context determining the precision of the value returned.
        * @return The value of the polynomial at x.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public BigComplex valueOf( BigComplex x, MathContext mc)
        {
                /* result is initialized to zero */
                BigComplex f = new BigComplex() ;
                for(int i=degree() ; i >= 0 ; i--)
                        f = f.multiply(x,mc).add(a.elementAt(i).BigDecimalValue(mc)) ;
                return f ;
        } /* valueOf */

        /** Horner scheme to find the function value at the argument x
        * @param x The argument of the polynomial
        * @return The value of the polynomial at x.
        * @since 2008-11-13
        * @author Richard J. Mathar
        */
        public Rational valueOf( Rational x)
        {
                /* result is initialized to zero */
                Rational f = new Rational(0,1) ;
                for(int i=degree() ; i >= 0 ; i--)
                        f = f.multiply(x).add(a.elementAt(i)) ;
                return f ;
        } /* valueOf */

        /** Horner scheme to find the function value at the argument x
        * @param x The argument of the polynomial
        * @return The value of the polynomial at x.
        * @since 2008-11-13
        * @author Richard J. Mathar
        */
        public Rational valueOf( int x)
        {
                return valueOf(new Rational(x,1)) ;
        } /* valueOf */

        /** Horner scheme to evaluate the function at the argument x
        * @param x The argument of the polynomial
        * @return The value of the polynomial at x.
        * @since 2010-08-27
        * @author Richard J. Mathar
        */
        public Rational valueOf( BigInteger x)
        {
                return valueOf(new Rational(x)) ;
        } /* valueOf */

        /* Set a polynomial coefficient.
        * @param n the zero-based index of the coefficient. n=0 for the constant term. 
        *  If the polynomial has not yet the degree to need this coefficient,
        *  the intermediate coefficients are implicitly set to zero.
        * @param value the new value of the coefficient.
        * @author Richard J. Mathar
        */
        public void set(final int n, final Rational value)
        {
                if ( n < a.size())
                        a.set(n,value) ;
                else
                {
                        /* fill intermediate powers with coefficients of zero
                        */
                        while ( a.size() < n )
                                a.add(new Rational(0,1)) ;
                        a.add(value) ;
                }
        } /* set */

        /** Set a polynomial coefficient.
        * @param n the zero-based index of the coefficient. n=0 for the constant term. 
        *  If the polynomial has not yet the degree to need this coefficient,
        *  the intermediate coefficients are implicitly set to zero.
        * @param value the new value of the coefficient.
        * @author Richard J. Mathar
        */
        public void set(final int n, final BigInteger value)
        {
                Rational val2 = new Rational(value,BigInteger.ONE) ;
                set(n,val2) ;
        } /* set */

        /** Set a polynomial coefficient.
        * @param n the zero-based index of the coefficient. n=0 for the constant term. 
        *  If the polynomial has not yet the degree to need this coefficient,
        *  the intermediate coefficients are implicitly set to zero.
        * @param value the new value of the coefficient.
        * @author Richard J. Mathar
        */
        public void set(final int n, final int value)
        {
                Rational val2 = new Rational(value,1) ;
                set(n,val2) ;
        } /* set */

        /* Set to the taylor series of exp(x) up to degree nmax.
        * @param nmax the maximum polynomial degree
        * @author Richard J. Mathar
        */
        public void setExp(final int nmax)
        {
                a.clear() ;
                Factorial factorial=new Factorial() ;
                for(int n=0; n <= nmax ; n++)
                        set(n, new Rational(BigInteger.ONE,factorial.at(n))) ;
        } /* setExp */

        /** Set to the taylor series representing 0+x.
        * @author Richard J. Mathar
        */
        public void setx()
        {
                a.clear() ;
                /* coefficient 0/1=0 */
                a.add(new Rational(0,1)) ;
                /* coefficient 1/1=1 */
                a.add(new Rational(1,1)) ;
        } /* setx */

        /** Count of coefficients. One more than the degree of the polynomial.
        * @return the number of polynomial coefficients.
        * @author Richard J. Mathar
        */
        public int size()
        {
                return a.size() ;
        } /* size */

        /** Polynomial degree.
        * @return the polynomial degree.
        * @author Richard J. Mathar
        */
        public int degree()
        {
                return a.size()-1 ;
        } /* degree */

        /** Lower Polynomial degree.
        * @return The smallest exponent n such that [x^n] of the polynomial is nonzero.
        * If the polynmial is identical zero, the result is (still) 0.
        * @since 2010-08-27
        * @author Richard J. Mathar
        */
        public int ldegree()
        {
                for(int n=0 ; n < a.size() ; n++)
                        if ( a.elementAt(n).compareTo(BigInteger.ZERO) != 0 )
                                return n;
                return 0 ;
        } /* ldegree */

        /** Multiply by a constant factor.
        * @param val the factor
        * @return the product of this with the factor.
        *   All coefficients of this have been multiplied individually by the factor.
        * @author Richard J. Mathar
        */
        public RatPoly multiply(final Rational val)
        {
                RatPoly resul = new RatPoly() ;
                if ( val.compareTo(BigInteger.ZERO) != 0 )
                        for(int n=0; n < a.size() ; n++)
                                resul.set(n,a.elementAt(n).multiply(val) ) ;
                return resul ;
        } /* multiply */

        /** Multiply by a constant factor.
        * @param val the factor
        * @return the product of this with the factor.
        *   All coefficients of this have been multiplied individually by the factor.
        * @since 2010-08-27
        * @author Richard J. Mathar
        */
        public RatPoly multiply(final BigInteger val)
        {
                RatPoly resul = new RatPoly() ;
                if ( val.compareTo(BigInteger.ZERO) != 0 )
                        for(int n=0; n < a.size() ; n++)
                                resul.set(n,a.elementAt(n).multiply(val) ) ;
                return resul ;
        } /* multiply */

        /** Multiply by another polynomial
        * @param val the other polynomial
        * @return the product of this with the other polynomial
        * @author Richard J. Mathar
        */
        public RatPoly multiply(final BigIntegerPoly val)
        {
                /* forward to the other signature
                */
                return multiply(val.toRatPoly()) ;
        } /* multiply */

        /** Multiply by another polynomial
        * @param val the other polynomial
        * @return the product of this with the other polynomial
        * @author Richard J. Mathar
        */
        public RatPoly multiply(final RatPoly val)
        {
                RatPoly resul = new RatPoly() ;
                /* the degree of the result is the sum of the two degrees.
                */
                final int nmax = degree()+val.degree() ;
                for(int n=0; n <= nmax ; n++)
                {
                        Rational coef = new Rational(0,1) ;
                        for(int nleft=0; nleft <= n ; nleft++)
                        {
                                coef = coef.add(at(nleft).multiply(val.at(n-nleft))) ;
                        }
                        resul.set(n,coef) ;
                }
                resul.simplify() ;
                return resul ;
        } /* multiply */

        /** Raise to a positive power.
        * @param n The non-negative exponent of the power
        * @return The n-th power of this.
        * @author Richard J. Mathar
        */
        public RatPoly pow(final int n) throws ArithmeticException
        {
                RatPoly resul = new RatPoly("1") ;
                if ( n < 0 )
                        throw new ArithmeticException("negative polynomial power "+n) ;
                else
                {
                        /* this ought probably be done with some binary representation
                        * of the power and a smaller number of multiplications.
                        */
                        for(int i=1 ; i <= n ; i++)
                                resul = resul.multiply(this) ;
                        resul.simplify() ;
                        return resul ;
                }
        } /* pow */

        /** Raise to a rational power.
        * The result is the taylor expansion of this, truncated at the first
        * term that remains undetermined based on the current number of coefficients.
        * @param r the exponent of the power
        * @return This^r .
        * @since 2009-05-18
        * @author Richard J. Mathar
        */
        public RatPoly pow(final Rational r) throws ArithmeticException
        {
                /* split (a0+a1*x+a2*x^2+...)^r = a0^r*(1+a1/a0*r+a2/a0*r^2+..)^r
                */
                Rational f = at(0) ;
                f = f.pow(r) ;

                /* scale the polynomial by division through the expansion coefficient of the absolute term
                */
                RatPoly red = divide(a.elementAt(0)) ;

                /* and remove the leading term (now equal to 1)
                */
                red.set(0,0) ;

                /* Binomial expansion of the rest. sum_{l=0..infinity} binomial(r,l)*red^l
                */
                RatPoly resul = new RatPoly("1") ;

                final int d = degree() ;
                for(int l=1 ; l <= d ; l++)
                {
                        final Rational b = Rational.binomial(r,l) ;
                        resul = resul.add( red.pow(l).multiply(b) ) ;
                }
                return resul.multiply(f) ;
        } /* pow */

        /** Add another polynomial
        * @param val The other polynomial
        * @return The sum of this and the other polynomial
        * @since 2008-10-25
        * @author Richard J. Mathar
        */
        public RatPoly add(final RatPoly val)
        {
                RatPoly resul = new RatPoly() ;
                /* the degree of the result is the larger of the two degrees (before simplify() at least).
                */
                final int nmax = (degree()>val.degree()) ? degree() : val.degree() ;
                for(int n=0; n <= nmax ; n++)
                {
                        Rational coef = at(n).add(val.at(n)) ;
                        resul.set(n,coef) ;
                }
                resul.simplify() ;
                return resul ;
        } /* add */

        /** Subtract another polynomial
        * @param val The other polynomial
        * @return The difference between this and the other polynomial
        * @since 2008-10-25
        * @author Richard J. Mathar
        */
        public RatPoly subtract(final RatPoly val)
        {
                RatPoly resul = new RatPoly() ;
                /* the degree of the result is the larger of the two degrees (before simplify() at least).
                */
                final int nmax = (degree()>val.degree()) ? degree() : val.degree() ;
                for(int n=0; n <= nmax ; n++)
                {
                        Rational coef = at(n).subtract(val.at(n)) ;
                        resul.set(n,coef) ;
                }
                resul.simplify() ;
                return resul ;
        } /* subtract */

        /** Divide by a constant.
        * @param val the constant through which the coefficients will be divided.
        * @return the Taylor expansion of this/val .
        * @since 2009-05-18
        * @author Richard J. Mathar
        */
        public RatPoly divide(final Rational val)
        {
                if ( val.compareTo(Rational.ZERO) != 0 )
                {
                        RatPoly resul = new RatPoly() ;
                        for(int n=0; n < a.size() ; n++)
                                resul.set(n,a.elementAt(n).divide(val) ) ;
                        return resul ;
                }
                else
                        throw new ArithmeticException("Cannot divide " + toPString() +" through zero.") ;
        } /* divide */

        /** Divide by another polynomial.
        * @param val the other polynomial
        * @param nmax the maximum degree of the Taylor expansion of the result.
        * @return the Taylor expansion of this/val up to degree nmax.
        */
        public RatPoly divide(final RatPoly val,int nmax)
        {
                RatPoly num = this ;
                RatPoly denom = val ;

                /* divide by a common smallest power/degree
                */
                while( num.at(0).compareTo(BigInteger.ZERO) == 0 && denom.at(0).compareTo(BigInteger.ZERO) == 0)
                {
                        num.a.remove(0) ;
                        denom.a.remove(0) ;
                        if( num.size() <= 1 || denom.size() <= 1)
                                break ;
                }

                RatPoly resul = new RatPoly() ;
                /* todo: If the polynomial division is exact, we could leave
                * the loop earlier, indeed
                */
                for(int n=0; n <= nmax ; n++)
                {
                        Rational coef = num.at(n) ;
                        for(int nres=0; nres < n ; nres++)
                        {
                                coef = coef.subtract(resul.at(nres).multiply(denom.at(n-nres))) ;
                        }
                        coef = coef.divide(denom.at(0)) ;
                        resul.set(n,coef) ;
                }
                resul.simplify() ;
                return(resul) ;
        } /* divide */

        /** Divide by another polynomial.
        * @param val the other polynomial
        * @return A vector with [0] containg the polynomial of degree which is the
        *  difference of thisdegree and the degree of val. [1] the remainder polynomial.
        * This = returnvalue[0] + returnvalue[1]/val .
        * @since 2012-03-01
        * @author Richard J. Mathar
        */
        public RatPoly[] divideAndRemainder(final RatPoly val)
        {
                RatPoly[] ret = new RatPoly[2] ;
                /* remove any high-order zeros
                */
                RatPoly valSimpl = val.clone() ;
                valSimpl.simplify() ;
                RatPoly thisSimpl = clone() ;
                thisSimpl.simplify() ;

                /* catch the case with val equal to zero
                */
                if ( valSimpl.degree() == 0 && valSimpl.a.firstElement().compareTo(Rational.ZERO) == 0)
                        throw new ArithmeticException("Division through zero polynomial") ;
                /* degree of this smaller than degree of val: remainder is this
                */
                if ( thisSimpl.degree() < valSimpl.degree() )
                {
                        /* leading polynomial equals zero 
                        */
                        ret[0] = new RatPoly() ;
                        ret[1] = thisSimpl ;
                }
                else
                {
                        /* long division. Highest degree by dividing the highest degree
                        * of this thru val.
                        */
                        ret[0] = new RatPoly() ;
                        ret[0].set(thisSimpl.degree()-valSimpl.degree(),
                                thisSimpl.a.lastElement().divide(valSimpl.a.lastElement()) ) ;

                        /* recurrences: build this - val*(1-termresult) and feed this
                        * into another round of division. Have intermediate ret[0]+ret[1]/val.
                        */
                        ret[1] = thisSimpl.subtract( ret[0].multiply( valSimpl) );

                        /* any remainder left ?
                        */
                        if ( ret[1].degree() < valSimpl.degree() )
                                ;
                        else
                        {
                                RatPoly rem[] = ret[1].divideAndRemainder(val) ;
                                ret[0] = ret[0].add(rem[0]) ;
                                ret[1] = rem[1] ;
                        }
                }
                return ret ;
        } /* divideAndRemainder */

        /** Print as a comma-separated list of coefficients.
        * @return The representation a0,a1,a2,a3,...
        * This is a sort of opposite of the ctor that takes a string as an argument.
        * @since 2008-10-25
        * @author Richard J. Mathar
        */
        public String toString()
        {
                String str = new String();
                for(int n=0; n < a.size() ; n++)
                {
                        if ( n == 0 )
                                str += a.elementAt(n).toString() ;
                        else
                                str += ","+a.elementAt(n).toString() ;
                }
                /* print at least a sole zero
                */
                if (str.length() == 0)
                        str = "0" ;
                return str ;
        } /* toString */

        /** Print as a polyomial in x.
        * @return To representation a0+a1*x+a2*x^2+...
        *    This does not print the terms with coefficients equal to zero.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public String toPString()
        {
                String str = new String();
                for(int n=0; n < a.size() ; n++)
                {
                        final BigInteger num = a.elementAt(n).a ;
                        if ( num.compareTo(BigInteger.ZERO) != 0 )
                        {
                                str += " " ;
                                if ( num.compareTo(BigInteger.ZERO) > 0 )
                                        str += "+" ;
                                str += a.elementAt(n).toString() ;
                                if ( n > 0 )
                                {
                                        str += "*x" ;
                                        if ( n > 1 ) 
                                                str += "^"+n ;
                                }
                        }
                }
                /* print at least a sole zero
                */
                if (str.length() == 0)
                        str = "0" ;
                return str ;
        } /* toPString */

        /** Simplify the representation.
        * Trailing values with zero coefficients (at high powers) are deleted.
        * This modifies the polynomial on the stop (does not return another instance)
        * @author Richard J. Mathar
        */
        private void simplify()
        {
                int n = a.size()-1 ;
                if ( n >= 0)
                        while( a.elementAt(n).compareTo(BigInteger.ZERO) == 0 )
                        {
                                a.remove(n) ;
                                if( --n <0)
                                        break ;
                        }
        } /* simplify */

        /** First derivative.
        * @return The first derivative with respect to the indeterminate variable.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public RatPoly derive()
        {
                if ( a.size() <= 1)
                        /* derivative of the constant is just zero
                        */
                        return new RatPoly() ;
                else
                {       
                        RatPoly d = new RatPoly() ;
                        for(int i=1 ; i <= degree() ; i++)
                        {
                                final Rational c = a.elementAt(i).multiply(i) ;
                                d.set(i-1,c) ;
                        }
                        return d ;
                }
        } /* derive */

        /** Scale coefficients such that the coefficient in front of the maximum degree is unity.
        * @return The scaled polynomial
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public RatPoly monic()
        {
                RatPoly m = new RatPoly() ;
                final int d = degree() ;
                for(int i=0 ; i <= d ; i++)
                {
                        final Rational c = a.elementAt(i).divide(a.elementAt(d) ) ;
                        m.set(i,c) ;
                }
                return m ;
        } /* monic */


        /** Mobius transform.
        * @param maxdeg the maximum polynomial degree of the result
        * @return the sequence of coefficients is the Mobius transform of the original sequence.
        * @since 2008-12-02
        * @author Richard J. Mathar
        */
        public RatPoly mobiusT(int maxdeg)
        {
                /* Start with the polynomial 0
                */
                RatPoly r = new RatPoly() ;
                for(int i=1; i <= maxdeg; i++)
                {
                        Rational c = new Rational() ;
                        for(int d=1; d <= i && d < a.size(); d++)
                        {
                                if (i % d == 0) 
                                {
                                        final Ifactor m = new Ifactor(i/d) ;
                                        c = c.add( a.elementAt(d).multiply( m.moebius() ) ) ;
                                }
                        }
                        r.set(i,c) ;
                }
                r.simplify() ;
                return r ;
        } /* mobiusT */

        /** Inverse Mobius transform.
        * @param maxdeg the maximum polynomial degree of the result
        * @return the sequence of coefficients is the inverse Mobius transform of the original sequence.
        * @since 2008-12-02
        * @author Richard J. Mathar
        */
        public RatPoly mobiusTInv(int maxdeg)
        {
                /* Start with the polynomial 0
                */
                RatPoly r = new RatPoly() ;
                for(int i=1; i <= maxdeg; i++)
                {
                        Rational c = new Rational() ;
                        for(int d=1; d <= i && d < a.size(); d++)
                        {
                                if (i % d == 0) 
                                        c = c.add( a.elementAt(d) ) ;
                        }
                        r.set(i,c) ;
                }
                r.simplify() ;
                return r ;
        } /* mobiusTInv */

        /** Binomial transform.
        * @param maxdeg the maximum polynomial degree of the result
        * @return the sequence of coefficients is the binomial transform of the original sequence.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public RatPoly binomialT(int maxdeg)
        {
                RatPoly r = new RatPoly() ;
                for(int i=0; i <= maxdeg; i++)
                {
                        Rational c = new Rational(0,1) ;
                        for(int j=0; j <= i && j < a.size(); j++)
                                c = c.add( a.elementAt(j).multiply(BigIntegerMath.binomial(i,j)) ) ;
                        r.set(i,c) ;
                }
                r.simplify() ;
                return r ;
        } /* binomialT */

        /** Inverse Binomial transform.
        * @param maxdeg the maximum polynomial degree of the result
        * @return the sequence of coefficients is the inverse binomial transform of the original sequence.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public RatPoly binomialTInv(int maxdeg)
        {
                RatPoly r = new RatPoly() ;
                for(int i=0; i <= maxdeg; i++)
                {
                        Rational c = new Rational(0,1) ;
                        for(int j=0; j <= i && j < a.size(); j++)
                                if ( (j+i) % 2 != 0 )
                                        c = c.subtract( a.elementAt(j).multiply(BigIntegerMath.binomial(i,j)) ) ;
                                else
                                        c = c.add( a.elementAt(j).multiply(BigIntegerMath.binomial(i,j)) ) ;
                        r.set(i,c) ;
                }
                r.simplify() ;
                return r ;
        } /* binomialTInv */


        /** Truncate polynomial degree.
        * @param newdeg The maximum degree of the result.
        * @return The polynomial with all coefficients beyond deg set to zero.
        * If newdeg =3, for example the polynomial returned has at most degree 3.
        * If newdeg is larger than the degree of this, zeros (at the higher orders of x)
        * are appended. That polynomial would have formal degree larger than this.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public RatPoly trunc(int newdeg)
        {
                RatPoly t = new RatPoly() ;
                for(int i=0; i <= newdeg; i++)
                        t.set(i,at(i)) ;
                t.simplify() ;
                return t ;
        } /* trunc */

        /** Generate the roots of the polynomial in floating point arithmetic.
        * <a href="http://en.wikipedia.org/wiki/Durand-Kerner_method">Durand Kerner method</a>
        * @param digits the number of floating point digits
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public Vector<BigComplex> roots(int digits)
        {
                RatPoly mon = monic() ;

                Random rand = new Random() ;
                MathContext mc = new MathContext(digits+3,RoundingMode.DOWN) ;

                Vector<BigComplex> res =new Vector<BigComplex>() ;

                final int d = mon.degree() ;
                double randRad =0. ;
                for(int i=0 ; i <= d ; i++)
                {
                        /* scale coefficient at maximum degree */
                        double absi = Math.abs( mon.at(i).doubleValue() ) ;
                        if ( absi > randRad) 
                                randRad = absi ;
                }
                randRad += 1.0 ;

                /* initial values randomly in radius 1+randRad
                */
                for(int i=0 ; i < d ; i++)
                {
                        double rad = randRad*rand.nextDouble() ;
                        double phi = 2.0*3.14159*rand.nextDouble() ;
                        res.add(i, new BigComplex(rad*Math.cos(phi),rad*Math.sin(phi)) ) ;
                }

                /* iterate until convr indicates that all values changed by less than the digits 
                * precision indicates.
                */
                boolean convr = false ;
                for(int itr =0 ; ! convr ; itr++)
                {
                        convr = true ;
                        Vector<BigComplex> resPlus =new Vector<BigComplex>() ;
                        for(int v=0 ; v < d; v++)
                        {
                                /* evaluate f(x)/(x-root1)/(x-root2)/... (x-rootdegr), Newton method
                                */
                                BigComplex thisx = res.elementAt(v) ;
                                BigComplex nv = mon.valueOf(thisx,mc) ;
                                for(int j=0; j < d ; j++)
                                {
                                        if ( j != v )
                                                nv = nv.divide(thisx.subtract(res.elementAt(j)),mc) ;
                                }

                                /* is this value converged ? */
                                if ( nv.abs(mc).doubleValue() >  thisx.abs(mc).doubleValue()*Math.pow(10.0,-digits) )
                                        convr =false;
        
                                thisx = thisx.subtract(nv) ;

                                /* If unstable, start over */
                                if ( thisx.abs(MathContext.DECIMAL32).doubleValue() > randRad )
                                        return roots(digits) ;

                                resPlus.add(thisx) ;
                        }
                        res = resPlus ;

                }
                return res;
        } /* roots */

        /** Generate the integer roots of the polynomial.
        * @return The vector of integer roots, with multiplicity.
        * The shows alternatingly first a root then its multiplicty, then another root and multiplicty etc.
        * @since 2008-10-26
        * @author Richard J. Mathar
        */
        public Vector<BigInteger> iroots()
        {
                /* The vector of the roots */
                Vector<BigInteger> res =new Vector<BigInteger>() ;

                int lowd = ldegree() ;
                if( lowd == 0 && a.elementAt(0).compareTo(BigInteger.ZERO) == 0)
                {
                        /* Case of polynomial identical to zero:
                        * reported as a simple root of value 0.
                        */
                        res.add(BigInteger.ZERO) ;
                        res.add(BigInteger.ONE) ;
                        return res ;
                }

                /* multiply all coefs with the lcm() to get an integer polynomial
                * start with denominator of first non-zero coefficient.
                */
                BigInteger lcmDeno = a.elementAt(lowd).b ;
                for(int i=lowd+1; i < degree() ; i++)
                        lcmDeno = BigIntegerMath.lcm(lcmDeno, a.elementAt(i).b ) ;

                /* and eventually get the integer polynomial by ignoring the denominators
                */
                Vector<BigInteger> ipo = new Vector<BigInteger>() ;
                for(int i=0 ; i < a.size() ; i++)
                {
                        BigInteger d = a.elementAt(i).a.multiply( lcmDeno).divide( a.elementAt(i).b)  ;
                        ipo.add(d) ;
                }

                BigIntegerPoly p = new BigIntegerPoly(ipo) ;
                /* collect the integer roots (multiple roots only once). Since we
                * removed the zero already above, cand does not contain zeros.
                */
                Vector<BigInteger> cand = p.iroots() ;
                for( int i =0 ; i < cand.size() ; i++)
                {
                        final BigInteger r = cand.elementAt(i) ;
                        int deg = p.rootDeg( r) ;
                        res.add(r) ;
                        res.add(new BigInteger(""+deg)) ;
                }

                return res;
        } /* iroots */


} /* RatPoly */
