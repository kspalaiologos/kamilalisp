/** @file
* Construction of the list of partitions or compositions of positive integers .
*/

package kamilalisp.libs.math.bigop;

import java.util.* ;

/*!************************************************
* @brief The class Partit constructs the partitions of an integer into positive integers.
* @author Richard J. Mathar
* @since 2014-06-19
*/
public class Partit implements Iterator
{
        /** The sum of the parts
        */
        int n;

        /** The current (most recent) part emitted.
        * This is equivalent to the minimum of any partitions emitted in the
        * future, because we are emitting them in increasing order.
        */
        int curPart ;

        /** The maximum (upper bound) of any part admitted.
        */
        int maxpart ;

        /** Parts to be appended to current[]. In a tree-type recursive approach, this is 
        * the partition that can generate the trailing parts to be appended to the
        * frozen parts.
        */
        Partit trail ;

        /** A flag which is true if compositions of n are constructed.
        * False if partitions of n are constructed.
        * @since 2015-03-18
        */
        boolean composit ;

        /**
        * Constructor defining the integer to be decomposed.
        * @param n The integer to be decomposed into partitions.
        * @param doComposit If true construct compositions, else partitions of n.
        * @since 2015-03-18
        * @author Richard J. Mathar
        */
        public Partit(int n, boolean doComposit)
        {
                /* forward this to the constructor which puts a lower bound of 1 and
                * a maximum cap of n to the parts to be admitted.
                */
                this(n,1,n,doComposit) ;
        } /* ctor */

        /**
        * Constructor defining the integer to be decomposed.
        * @param n The integer to be decomposed into partitions.
        * @author Richard J. Mathar
        */
        public Partit(int n)
        {
                /* forward this to the constructor which puts a lower bound of 1 and
                * a maximum cap of n to the parts to be admitted.
                */
                this(n,false) ;
        } /* ctor */

        /**
        * Constructor defining the integer to be decomposed and a lower bound
        * on all parts.
        * @param n The integer to be decomposed into partitions.
        * @param minp The minimum of all parts in the partitions to be generated.
        * @param maxp The upper bound of any part in the partitions.
        * @param doComposit Set to true if compositions instead of partitions are to be generated.
        * @author Richard J. Mathar
        */
        public Partit(int n, int minp, int maxp, boolean doComposit)
        {
                this.n = n ;
                curPart = minp ;
                maxpart = maxp ;
                /* possible to have a partition of n with minpart ?
                */
                if ( curPart >= n || curPart > maxpart)
                {
                        /* The requirements of n<=maxp cannot be met and the requirement
                        * of minp<=n can be met at most once (by setting the next part to be equal to n=curPart).
                        */
                        trail = null;
                }
                else
                {
                        /* The requirements of minp<=n<=maxp cann be met.
                        * If we book 'curPart' as the first part in the upcomming partitions,
                        * the rest of the partitions need to partition n minus curPart and 
                        * have to take 'curPart' as their new minimum.
                        */
                        trail = new Partit(n-curPart,curPart,maxp,doComposit) ;
                }
                composit = doComposit;
        } /* ctor */

        /**
        * Constructor defining the integer to be decomposed and a lower bound
        * on all parts.
        * @param n The integer to be decomposed into partitions.
        * @param minp The minimum of all parts in the partitions to be generated.
        * @param maxp The upper bound of any part in the partitions.
        * @author Richard J. Mathar
        */
        public Partit(int n, int minp, int maxp)
        {
                this(n,minp,maxp,false) ;
        } /* ctor */

        /**
        * Compute the largest part in a partition.
        * @param parts The list of positive integers providing the partition.
        *   The integers do not need to be sorted in any particular way.
        * @return The maximum element in parts[].
        *   This is zero if there are no parts.
        * @since 2014-07-14
        * @author Richard J. Mathar
        */
        static public int max(final int[] parts)
        {
                int m=0 ;
                for(int i=0 ; i < parts.length ; i++)
                        m = Math.max(m,parts[i]) ;
                return m ;
        } /* max */

        /**
        * Compute the frequency of a part in a partition.
        * @param parts The list of integers with the partition.
        * @param n The part to be counted in the parts.
        * @return The non-negative count of n in the parts.
        *   This is somewhere between 0 and the number of elements in parts[] (inclusive).
        * @since 2014-07-14
        * @author Richard J. Mathar
        */
        static public int frequency(final int[] parts, final int n)
        {
                int f=0 ;
                for(int i=0 ; i < parts.length ; i++)
                        if ( parts[i] == n)
                                f++ ;
                return f ;
        } /* frequency */

        /**
        * Compute the frequency of part larger than or equal to some minimum in a partition.
        * @param parts The list of integers with the partition.
        * @param m The minimum of any part to be counted.
        * @return The count of parts in parts[] that are larger or equal to m.
        * @since 2014-07-14
        * @author Richard J. Mathar
        */
        static public int frequencyMin(final int[] parts, final int m)
        {
                int f=0 ;
                for(int i=0 ; i < parts.length ; i++)
                        if ( parts[i] >= m)
                                f++ ;
                return f ;
        } /* frequency */

        /**
        * Compute the conjugate of a partition.
        * @param parts The list of integers with the partition.
        * @return The conjugate of the partition.
        * @since 2014-07-14
        * @author Richard J. Mathar
        */
        static public int[] conjugate(final int[] parts)
        {
                /* number of items in the conjugate equals largest part in parts[].
                */
                int mxpart = max(parts) ;
                int [] conj = new int[mxpart] ;
                for(int m= mxpart ; m >=1 ; m--)
                        conj[mxpart-m] = frequencyMin(parts,m) ; 
                return conj ;
        } /* conjugate */

        /** Removal of elements is not implemented
        * @since 2015-03-18
        * @author Richard J. Mathar
        */
        public void remove() throws UnsupportedOperationException
        {
                throw new UnsupportedOperationException() ;
        } /* remove */

        /** Iterator interface.
        * @return true If some of the partitions have not yet been constructed with next().
        *  This is equivalent to saying that the next call to next() will not return null.
        * @since 2015-03-18
        * @author Richard J. Mathar
        */
        public boolean hasNext()
        {
                /* this is a sort of dry run through next(). We can sequeeze
                * at least one other part if the remaining sum (which is n) is >= curPart.
                */
                if ( n <= 0 || curPart > n || curPart > maxpart)
                        return false ;
                else 
                        return true ;
        } /* hasNext */

        /** Return the next partition.
        * @return An integer vector of the parts.
        *   null if all partitions have already been emitted.
        * @author Richard J. Mathar
        */
        public int[] next()
        {
                if ( curPart == n && curPart <= maxpart)
                {
                        int[] parts = new int[1] ;
                        parts[0] = curPart ;
                        curPart ++ ;
                        trail = null ;
                        return parts ;
                }
                else if ( trail != null)
                {
                        int[] cnext = trail.next() ;
                        if ( cnext != null)
                        {
                                /* could create another partition of the trailing data...
                                */
                                int[] parts = new int[cnext.length+1 ] ;
                                parts[0] = curPart ;
                                for (int i=1 ; i < parts.length ; i++)
                                        parts[i] = cnext[i-1] ;
                                return parts ;
                        }
                        else if ( curPart < n && curPart < maxpart)
                        {
                                curPart++ ;
                                trail = new Partit(n-curPart, composit ? 1 : curPart,maxpart,composit) ;
                                return next() ;
                        }
                        else
                                return null ;
                }
                else
                        return null ;
        } /* next */

        /** Return the current partition.
        * @return An integer vector of the parts.
        *   null if all partitions have already been emitted.
        * @author Richard J. Mathar
        */
        public int[] current()
        {
                if ( curPart > maxpart)
                        return null ;
                if ( curPart == n )
                {
                        /* current partition exhausts n, so trail is not used anyway
                        */
                        int[] parts = new int[1] ;
                        parts[0] = curPart ;
                        return parts ;
                }
                else if ( trail != null)
                {
                        final int[] cnext = trail.current() ;
                        int[] parts = new int[cnext.length+1 ] ;
                        parts[0] = curPart ;
                        for (int i=1 ; i < parts.length ; i++)
                                parts[i] = cnext[i-1] ;
                        return parts ;
                }
                else
                        return null ;
        } /* current */

} /* Partit */
