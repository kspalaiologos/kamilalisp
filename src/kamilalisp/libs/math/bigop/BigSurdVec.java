package kamilalisp.libs.math.bigop;

import java.util.* ;
import java.math.* ;

/** A BigSurdVec represents an algebraic sum or differences of values
* which each term an instance of BigSurd.
* This mainly means that sums or differences of two BigSurd (or two BigSurdVec) can
* be represented (exactly) as a BigSurdVec.
* @since 2012-02-15
* @author Richard J. Mathar
*/
public class BigSurdVec implements Comparable<BigSurdVec>
{
        /** The value of zero.
        */
        static public BigSurdVec ZERO = new BigSurdVec() ;

        /** The value of one.
        */
        static public BigSurdVec ONE = new BigSurdVec(BigSurd.ONE) ;

        /** Internal representation: Each term as a single BigSurd.
        * The value zero is represented by an empty vector.
        */
        Vector<BigSurd> terms ;

        /** Default ctor, which represents the zero.
        * @since 2012-02-15
        */
        public BigSurdVec()
        {
                terms = new Vector<BigSurd>() ;
        } /* ctor */

        /** ctor given the value of a BigSurd.
        * @param a The value to be represented by this vector.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public BigSurdVec(BigSurd a)
        {
                terms = new Vector<BigSurd>(1) ;
                terms.add(a) ;
        } /* ctor */

        /** ctor given two values, which (when added) represent this number a+b.
        * @param a The value to be represented by the first term of the vector.
        * @param b The value to be represented by the second term of the vector.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public BigSurdVec(BigSurd a, BigSurd b)
        {
                terms = new Vector<BigSurd>(2) ;
                terms.add(a) ;
                terms.add(b) ;
                normalize() ;
        } /* ctor */

        /** ctor given a periodic continued fraction.
        * The value to be represented has a cont. fraction [a0,a1,a2,...,a0,a1,a2,...]
        * @param a The coefficients a[0], a[1],.. of the period of the continued fraction.
        * @since 2012-03-08
        * @author Richard J. Mathar
        */
        public BigSurdVec(Vector<BigInteger> a) throws NumberFormatException
        {
                /* this = a0+1/(a1+1/(a2+....) recursively unbundled by setting this=x
                * in a rational polynomial
                */
                if ( a.size() == 0 )
                        throw new NumberFormatException("Empty periodic continued fraction") ;
                
                /* intialize with a value of x = (0+1*x)/(1)
                */ 
                RationalPoly x = new RationalPoly(BigIntegerPoly.X, BigIntegerPoly.ONE) ;

                for(int i=0 ; i < a.size() ; i++)
                {
                        /* move a0 to the other side, and invert to have a1,a2,a3.. left on the r.h.s.
                        */
                        x = x.minus( a.elementAt(i)).inverse() ;
                }
                /* reached the bottom of the recursion. Solve numer(x)/denom(x) = x     
                * to obtain x as the solution of a quadratic equation.
                * Need to solve numer.a0+number.a1*x = x*(denom.a0+denom.a1*x)
                * which is numer.a0+number.a1*x = x*(denom.a0+denom.a1*x). This becomes defeq=0.
                */
                RatPoly defeq = x.b.multiply(BigIntegerPoly.X).subtract(x.a) ;
                terms = new Vector<BigSurd>() ;

                switch(defeq.degree())
                {
                case 0:
                        throw new NumberFormatException("Non-definitive periodic continued fraction") ;
                case 1:
                        /* if the term in front of the x^2 is zero, defeq=0 results in x= -defeq.at(0)/defeq.at(1)
                        */
                        Rational a0a1 = defeq.at(0).negate().divide(defeq.at(1)) ;
                        BigSurd loneterm = new BigSurd(a0a1,Rational.ONE) ;
                        terms.add(loneterm) ;
                        break;
                case 2:
                        /* a2*x^2+a1*x+a0=0 made monic
                        */
                        Rational a1 = defeq.at(1).divide(defeq.at(2)) ;
                        Rational a0 = defeq.at(0).divide(defeq.at(2)) ;
                        /* x = - a1/2  +- sqrt((a1/2)^2-a0). We take only the positive sign here.
                        */
                        a1 = a1.negate().divide(2) ;
                        loneterm = new BigSurd(a1,Rational.ONE) ;
                        terms.add(loneterm) ;
                        loneterm = new BigSurd(Rational.ONE,a1.pow(2).subtract(a0)) ;
                        terms.add(loneterm) ;
                        /* just in case the discriminant was a square
                        */
                        normalize() ; 
                        break;
                default :
                        /* cannot happen
                        */
                        throw new NumberFormatException("Internal error "+defeq) ;
                }
        } /* ctor */

        /** Combine terms that can be written as a single surd.
        * This unites for example the terms sqrt(90) and sqrt(10) to 4*sqrt(10).
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        protected void normalize()
        {
                /* nothing to be done if at most one term
                */
                if ( terms.size() <=1 )
                        return ;

                Vector<BigSurd> newter = new Vector<BigSurd>() ;
                newter.add( terms.firstElement()) ;
                /* add j-th element to the existing vector and combine were possible
                */
                for(int j=1 ; j < terms.size() ; j++)
                {
                        BigSurd todo = terms.elementAt(j) ;
                        boolean merged = false ;
                        for(int ex=0 ; ex < newter.size() ; ex++)
                        {
                                BigSurd v = newter.elementAt(ex) ;
                                /* try to merge terms[j] and newter[ex].
                                * todo = r * v with r a rational number is needed. 
                                * Replaces v with v+todo = v*(1+r) if this reduction works.
                                */
                                BigSurd r = todo.divide(v) ;
                                if ( r.isRational() )
                                {
                                        /* compute r+1 */
                                        Rational newpref = r.toRational().add(1) ;
                                        /* eliminate accidental zeros; overwrite with v*(1+r).
                                        */
                                        if ( newpref.compareTo( Rational.ZERO) == 0 )
                                                newter.removeElementAt(ex) ;
                                        else
                                        {
                                                v = v.multiply(newpref) ;
                                                newter.setElementAt(v,ex) ;
                                        }
                                        merged =true;
                                        break ;
                                }
                        }
                        /* append if none of the existing elements matched
                        */
                        if ( ! merged)
                                newter.add(todo) ;
                }

                /* overwrite old version */
                terms = newter ;
        } /* normalize */
                
        /** Compare algebraic value with oth.
        * Returns -1, 0 or +1 depending on whether this is smaller, equal to or larger than oth.
        * @param oth The value with which this is to be compared.
        * @return 0 or +-1.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public int compareTo(BigSurdVec oth)
        {
                final BigSurdVec diff = this.subtract(oth) ;
                return diff.signum() ;
        } /* compareTo */
        
        /** Sign function.
        * Returns -1, 0 or +1 depending on whether this is smaller, equal to or larger than zero.
        * @return 0 or +-1.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public int signum()
        {
                /* the case of zero is unique, because no (reduced) vector of surds other than
                * the one element 0 itself can add/subtract to zero.
                */
                if ( terms.size() == 0 )
                        return 0 ;

                /* if there is one term: forward to the signum function of BigSurd
                */
                if ( terms.size() == 1 )
                        return terms.firstElement().signum() ;

                /* if all terms have a common sign: take that one
                * offsig is the index of the first "offending" term in the sense that its
                * sign doese not agree with the term[0].
                */
                int sig0 = terms.elementAt(0).signum() ;
                int offsig = 1;
                for( ; offsig < terms.size() ; offsig++)
                        if ( terms.elementAt(offsig).signum() != sig0)
                                break;
                if ( offsig >= terms.size() )
                        return sig0 ;

                /* if there are two terms (now known to have different sign):
                * forward to the comparison of the two elements as BigSurds
                */
                if ( terms.size() == 2 )
                        return terms.elementAt(0).compareTo( terms.elementAt(1).negate() ) ;

                /* if there are three terms, move the one with the offending sign to the
                * other side and square both sides (which looses the sign) to remove all but one surds.
                * The difference of the squared sides contains at most two terms, which reduces to the
                * case above.
                *  t(0)+t(offbar) <> -t(offs)
                */
                if ( terms.size() == 3 )
                {
                        BigSurdVec lhs ;
                        if ( offsig == 2)
                                lhs = new BigSurdVec( terms.elementAt(0), terms.elementAt(1)) ;
                        else
                                lhs = new BigSurdVec( terms.elementAt(0), terms.elementAt(2)) ;
                        lhs = lhs.sqr() ;
                        BigSurd rhs = new BigSurd(terms.elementAt(offsig).sqr(),Rational.ONE) ;
                        if ( lhs.compareTo(lhs) > 0 )
                                /* dominating sign was t(0)+t(offbar)
                                */
                                return terms.elementAt(0).signum() ;
                        else
                                return terms.elementAt(offsig).signum() ;
                }

                /* for a larger number of terms: take a floating point representation with a small
                * but correct number of digits, and resume with the sign of that one.
                */
                return (floatValue() > 0. ) ? 1 : -1 ;

        } /* signum */

        /** Construct an approximate floating point representation
        * @param mc The intended accuracy of the result.
        * @return A truncated version with the precision described by mc
        * @author Richard J. Mathar
        */
        public BigDecimal BigDecimalValue(MathContext mc)
        {
                /* simple cases with one term forwarded to the BigSurd class
                */
                if ( terms.size() == 0 )
                        return BigDecimal.ZERO ;
                else if ( terms.size() == 1 )
                {
                        return terms.firstElement().BigDecimalValue(mc) ;
                }

                /* To reduce cancellation errors, loop over increasing local precision
                * until we are stable to the required result. Keep the old (less precise)
                * estimate in res[0], and the newer, more precise in res[1].
                */
                BigDecimal [] res = new BigDecimal[2] ;
                res[0] = BigDecimal.ZERO ;
                for(int addpr =1 ; ; addpr += 3)
                {
                        MathContext locmc = new MathContext(mc.getPrecision()+addpr,mc.getRoundingMode()) ;
                        /* start with an explicitly set first value to avoid treating the
                        * initial zero as being a rounded zero
                        */
                        res[1] = (terms.size() ==0 )? BigDecimal.ZERO : terms.firstElement().BigDecimalValue(locmc) ;
                        for( int i = 1 ; i < terms.size() ; i++)
                        {
                                BigSurd j = terms.elementAt(i) ;
                                res[1] = BigDecimalMath.addRound(res[1], j.BigDecimalValue(locmc) ) ;
                        }
                        if ( addpr > 1 )
                        {
                                BigDecimal err = res[1].subtract(res[0]).abs() ;
                                int prec = BigDecimalMath.err2prec(res[1],err) ;
                                if ( prec > mc.getPrecision() )
                                        break ;
                        }
                        res[0] = res[1] ;
                }
                return BigDecimalMath.scalePrec(res[1],mc) ;
        
        } /* BigDecimalValue */

        /** Construct an approximate floating point representation
        * @return A truncated version with the precision described by mc
        * @author Richard J. Mathar
        */
        public double doubleValue()
        {
                BigDecimal bd = BigDecimalValue(MathContext.DECIMAL128) ;
                return bd.doubleValue() ;
        } /* doubleValue */

        /** Construct an approximate floating point representation
        * @return A truncated version with the precision described by mc
        * @author Richard J. Mathar
        */
        public double floatValue()
        {
                BigDecimal bd = BigDecimalValue(MathContext.DECIMAL64) ;
                return bd.floatValue() ;
        } /* floatValue */

        /** Add two vectors algebraically.
        * @param val The value to be added to this.
        * @return The new value representing this+val.
        * @author Richard J. Mathar
        */
        public BigSurdVec add(final Rational val)
        {
                /* forward to the more general signature
                */
                return add(new BigSurd(val,Rational.ONE)) ;
        } /* add */

        /** Add two vectors algebraically.
        * @param val The value to be added to this.
        * @return The new value representing this+val.
        * @author Richard J. Mathar
        */
        public BigSurdVec add(final BigSurdVec val)
        {
                BigSurdVec sum = new BigSurdVec() ;
                /* concatenate the vectors and eliminate common overlaps
                */
                sum.terms.addAll( terms) ;
                sum.terms.addAll( val.terms) ;
                sum.normalize() ;
                return sum ;
        } /* add */

        /** Add two vectors algebraically.
        * @param val The value to be added to this.
        * @return The new value representing this+val.
        * @author Richard J. Mathar
        */
        public BigSurdVec add(final BigSurd val)
        {
                BigSurdVec sum = new BigSurdVec() ;
                /* concatenate the vectors and eliminate common overlaps
                */
                sum.terms.addAll( terms) ;
                sum.terms.add( val) ;
                sum.normalize() ;
                return sum ;
        } /* add */

        /** Subtract another number.
        * @param val The value to be subtracted from this.
        * @return The new value representing this-val.
        * @author Richard J. Mathar
        */
        public BigSurdVec subtract(final BigSurdVec val)
        {
                BigSurdVec sum = new BigSurdVec() ;
                /* concatenate the vectors and eliminate common overlaps
                */
                sum.terms.addAll( terms) ;
                for ( BigSurd s : val.terms)
                        sum.terms.add( s.negate() ) ;
                sum.normalize() ;
                return sum ;
        } /* subtract */

        /** Subtract another number.
        * @param val The value to be subtracted from this.
        * @return The new value representing this-val.
        * @author Richard J. Mathar
        */
        public BigSurdVec subtract(final BigSurd val)
        {
                BigSurdVec sum = new BigSurdVec() ;
                /* concatenate the vectors and eliminate common overlaps
                */
                sum.terms.addAll( terms) ;
                sum.terms.add( val.negate() ) ;
                sum.normalize() ;
                return sum ;
        } /* subtract */

        /** Compute the negative.
        * @return -this.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public BigSurdVec negate()
        {
                /* accumulate the negated elements of term one by one
                */
                BigSurdVec resul = new BigSurdVec() ;
                for( BigSurd s : terms)
                        resul.terms.add( s.negate()) ;
                /* no normalization step here, because the negation of all terms
                * does not introduce new common factors
                */
                return resul ;
        } /* negate */

        /** Compute the square.
        * @return this value squared.
        * @since 2012-02-15
        * @author Richard J. Mathar
        */
        public BigSurdVec sqr()
        {
                /* Binomial expansion. First the sum of the terms squared,
                * then 2 times the mixed products.
                */
                BigSurdVec resul = new BigSurdVec() ;
                for( int i=0 ; i < terms.size() ; i++)
                        resul.terms.add( new BigSurd(terms.elementAt(i).sqr(),Rational.ONE) ) ;
                for( int i=0 ; i < terms.size()-1 ; i++)
                for( int j= i+1 ; j < terms.size() ; j++)
                        resul.terms.add( terms.elementAt(i).multiply(terms.elementAt(j)).multiply(2) ) ;
                resul.normalize() ;
                return resul ;
        } /* sqr */

        /** Multiply by another square root.
        * @param val a second number of this type.
        * @return the product of this with the val.
        * @since 2011-02-12
        * @author Richard J. Mathar
        */
        public BigSurdVec multiply(final BigSurd val)
        {
                BigSurdVec resul = new BigSurdVec() ;
                for( BigSurd s : terms)
                        resul.terms.add( s.multiply(val) )  ;
                resul.normalize() ;
                return resul ;
        } /* multiply */

        /** Return a string in the format (number/denom)*()^(1/2).
        * If the discriminant equals 1, print just the prefactor.
        * @return the human-readable version in base 10
        * @since 2012-02-16
        * @author Richard J. Mathar
        */
        public String toString()
        {
                /* simple cases with one term forwarded to the BigSurd class
                */
                if ( terms.size() == 0 )
                        return new String("0") ;
                else 
                {
                        String s = new String() ;
                        for(int t=0 ; t< terms.size() ; t++)
                        {
                                BigSurd bs = terms.elementAt(t) ;
                                if ( bs.signum() > 0 )
                                        s += "+" ;
                                s += bs.toString() ;
                        }
                        return s ;
                }
        } /* toString */




} /* BigSurdVec */
