package kamilalisp.libs.math.bigop;

import java.lang.* ;
import java.util.* ;
import java.math.* ;

/** Number of partitions.
* @since 2008-10-15
* @author Richard J. Mathar
*/
public class PartitionsP
{
        /**
        * The list of all partitions as a vector.
        */
        static protected Vector<BigInteger> a = new Vector<BigInteger>() ;

        /**
        * The maximum integer covered by the high end of the list.
        */
        static protected BigInteger nMax =new BigInteger("-1") ;

        /**
        * Default constructor initializing a list of partitions up to 7.
        * @author Richard J. Mathar
        */
        public PartitionsP()
        {
                if ( a.size() == 0 )
                {
                        a.add(new BigInteger(""+1)) ;
                        a.add(new BigInteger(""+1)) ;
                        a.add(new BigInteger(""+2)) ;
                        a.add(new BigInteger(""+3)) ;
                        a.add(new BigInteger(""+5)) ;
                        a.add(new BigInteger(""+7)) ;
                }
                nMax = new BigInteger(""+(a.size()-1)) ;
        } /* ctor */

        /** return the number of partitions of i
        * @param i the zero-based index into the list of partitions
        * @return the ith partition number. This is 1 if i=0 or 1, 2 if i=2 and so forth.
        * @author Richard J. Mathar
        */
        public BigInteger at(int i)
        {
                /* If the current list is too small, increase in intervals
                * of 3 until the list has at least i elements.
                */
                while ( i > nMax.intValue() )
                {
                        growto(nMax.add(new BigInteger(""+3))) ;
                }
                return ( a.elementAt(i) ) ;
        } /* at */

        /** extend the list of known partitions up to n
        * @param n the maximum integer hashed after the call.
        * @author Richard J. Mathar
        */
        private void growto(BigInteger n)
        {
                while( a.size() <= n.intValue() )
                {
                        BigInteger per = new BigInteger("0") ;
                        BigInteger cursiz = new BigInteger(""+a.size()) ;
                        for(int k=0; k < a.size() ; k++)
                        {
                                BigInteger tmp = a.elementAt(k).multiply(BigIntegerMath.sigma(a.size()-k)) ;
                                per = per.add(tmp) ;
                        }
                        a.add(per.divide(cursiz)) ;
                }
                nMax = new BigInteger(""+(a.size()-1)) ;
        } /* growto */
}
