package kamilalisp.libs.math.bigop;

import java.lang.* ;
import java.util.* ;


/** This class represents a permutation of [1,2,...,n].
* @since 2015-03-07
* @author Richard J. Mathar
*/
class Permutation implements Cloneable
{
        /** The set of integers in the 1-line order.
        */
        int[] images ;

        /** The order of this permutation.
        * A non-positive value means that this is not yet known, because the computation is delayed.
        */
        private int ord ;

        /** Defines whether the permutation is represented with indices 0..n-1 or with 1..n
        * The value is either 1 (more complicated) or 0 (simpler to implement).
        */
        public static int REPOFFSET =0 ;

        /** Ctor with a set of integers that are a permutation of [1,..n] or [0,...,n-1].
        * @param v The list of integers.
        */
        Permutation(final int[] v) 
        {
                init(v) ;
        } /* ctor */

        /** Ctor for the unit permutation.
        * This is either (1,2,..,n) or (0,1,...,n-1) depending on the internally fixed offset.
        * @param n The maximum in the list of integers.
        */
        Permutation(final int n) 
        {
                /* Create the starting vector to be permuted.
                */
                int[] v = new int[n] ;
                for(int i=0 ; i < n ; i++)
                        v[i] = i+REPOFFSET ;
                init(v) ;
        } /* ctor */

        /** ctor given a set of integers to be permuted.
        * @param v The list of integers.
        * @since 2015-03-07
        * @author Richard J. Mathar
        */
        Permutation(final Vector<Integer> v) 
        {
                int[] varr = new int[v.size()] ;
                for(int i=0 ;i < varr.length ; i++)
                        varr[i] = v.elementAt(i).intValue() ;
                init(varr) ;
        } /* ctor */

        /** ctor starting with a cycle-length specification.
        * If v[0]+v[1]+...+v[] = n is a partition of n, then we construct
        * a permutation with cycles of length v[0], v[1], ... v[].
        * @param parts The list of cycle lengths.
        * @param n The sum of the elements of v.
        * @since 2015-03-16
        * @author Richard J. Mathar
        */
        Permutation(final int[] parts, int n) 
        {
                images = new int[n] ;
                int el=0 ;
                for(int p=0 ;p < parts.length ; p++)
                {
                        final int plen = parts[p] ;
                        for(int l=0 ; l < plen ; l++)
                        {
                                if ( l == plen-1)
                                        images[el] = el+1+REPOFFSET-plen ;
                                else
                                        images[el] = el+1+REPOFFSET ;
                                el++ ;
                        }
                }

                ord = -1 ;
        } /* ctor */

        /** Ctor given the cycles.
        * @param cycs cycs[c][0..] are the elements in the c'th cycle.
        * @since 2015-03-18
        * @author Richard J. Mathar
        */
        Permutation(final int[][] cycs) 
        {
                int n=0 ;
                for(int c=0 ; c < cycs.length; c++)
                        n += cycs[c].length ;

                images = new int[n] ;
                for(int c=0 ; c < cycs.length; c++)
                {
                        final int cl = cycs[c].length ;
                        for(int i =0 ; i < cl ; i++)
                        {
                                /* element cycs[c][i] is permuted to cycs[c][i+1] for i>=0 but
                                * the last in the cycle to cycs[c][0], back to the front.
                                */
                                final int e = cycs[c][i] ;
                                final int targ = cycs[c][(i+1) % cl] ;
                                images[e-REPOFFSET] = targ ;
                        }
                }

                ord = orderByCycles(cycs) ;
        } /* ctor */

        /** Copy the permutation to the local storage
        * @param v The vector of n elements.
        */
        private void init(int[] v)
        {
                images = new int[v.length] ;
                for(int i=0 ; i < v.length; i++)
                        images[i] = v[i] ;

                /* no check that all integers are there once and only once, to speed up */
                ord = -1 ;
        } /* init */

        /** Number of elements in the permutation
        * @return The number of elements in the image list.
        */
        public int length()
        {
                return images.length ;
        } /* length */

        /** Produce a "deep" clone of this.
        * @return a permutation with the same images as this.
        */
        public Permutation clone()
        {
                return new Permutation(images) ;
        } /* clone */

        /** Calculate the inverse permutation.
        * @return a permutation that yields the unit element after multiplication with this.
        */
        public Permutation inverse()
        {
                int[] invi = new int[images.length] ;
                for(int i=0 ; i < images.length; i++)
                        invi[images[i]-REPOFFSET] = i+REPOFFSET ;
                return new Permutation(invi) ;
        } /* inverse */

        /** Multiply with another permutation (which is placed to the right).
        * The result is the product of the permutations in the sense that
        * this is acting first, then 'right' later.
        * @param right The other factor in the product of the two permutations.
        * @return The product (result of succession) of the two permutations.
        * @since 2015-03-07
        */
        Permutation multiply(final Permutation right)
        {
                if ( images.length != right.images.length )
                        throw new IllegalArgumentException("Different permutation lengths " 
                                        + images.length + " vs " + right.images.length) ;

                /* the list of images in the new product
                */
                int[] prod = new int[images.length] ;
                for(int i=0 ; i < images.length ; i++)
                        /* pay attention to 1-offset convention of permutations here
                        * Standard slower implementation:
                        * prod[i] = right.imageOf(imageOf(i+REPOFFSET)) ;
                        * Inlined version follows:
                        */
                        prod[i] = right.images[images[i]-REPOFFSET] ;

                /* convert the images to a permutation
                */
                return new Permutation(prod) ;
        } /* multiply */

        /** True if this is the trivial (=no) permutation.
        * @return True if this is the permutation (1,2,3,...,n) or (0,1,2,3,..n-1), depending on the REPOFFSET.
        */
        public boolean isUnit()
        {
                for(int i=0 ; i < images.length ; i++)
                        if ( images[i] != i+REPOFFSET )
                                return false;
                return true;
        } /* isUnit */


        /** Greatest common divisor of two positive integers.
        * Euclid's algorithm.
        * @param a The first positive integer.
        * @param b The second positive integer.
        * @return gcd(a,b), the greatest common divisor of both. 
        */
        static int gcd(int a, int b)
        {
                while ( b > 0 )
                {
                        final int t = b;
                        b = a % b ;
                        a = t ;
                }
                return a;
        } /* gcd */

        /** Least common multiple of two positive integers.
        * Computed via Euclid's algorithm.
        * @param a The first positive integer.
        * @param b The second positive integer.
        * @return lcm(a,b), the least common multiple of both. 
        */
        static int lcm(int a, int b)
        {
                return a/gcd(a,b)*b ;
        } /* lcm */

        /** Calculate the order.
        * This is computed as the lcm of the lengths of the cycles.
        * @return the order of the permutation. This is the smallest positive power 0 of the
        * permutation that yields the unit element.
        */
        int orderByCycles()
        {
                /* recall any previously saved value to speed things up.
                */
                if ( ord <= 0)
                {
                        int[][] cyc = cycles() ;
                        if ( cyc.length < 1 )
                                ord =1 ;
                        else
                        {
                                ord = cyc[0].length ;
                                for(int c=1 ; c < cyc.length ; c++)
                                        ord = lcm(ord,cyc[c].length) ;
                        }
                }
                return ord;
        } /* orderByCycles */

        /** Calculate the order.
        * This is computed by the lcm of the lengths of the cycles.
        * @param cyc The cycles. Complete in the sense that each moved element
        *   in the permutation appears exactly once in the array.
        * @return The order of the permutation. This is the smallest positive power 0 of the
        * permutation that yields the unit element.
        */
        static int orderByCycles(final int [][] cyc)
        {
                if ( cyc.length < 1 )
                        /* if the cycle array is empty, there were only fixed elements in the
                        * permutation (of length 1) and the order of these is 1.
                        */
                        return 1;
                else
                {
                        int ord = cyc[0].length ;
                        for(int c=1 ; c < cyc.length ; c++)
                                ord = lcm(ord,cyc[c].length) ;
                        return ord ;
                }
        } /* orderByCycles */

        /** Generate a list of lists that are the cycle representation.
        * @return [0][..] are the integers in the first cycle, [1][...] in the second, and so on.
        *  Fixed elements of cycle length 1 are not included in the result.
        */
        public int[][] cycles()
        {
                Vector< int[] > c = new Vector<int[] > () ; 

                /* flag for each integer in the permutation that is has not     
                * yet appeared in a cycle. Default initialiation for booleans is false, so
                * we may skip the initialization here.
                */
                boolean []  done = new boolean[images.length] ;

                while( true)
                {
                        /* check done[] for any not yet booked integers in cycles
                        */
                        int notmoved =0 ;
                        for( ; notmoved < images.length; notmoved++)
                        {
                                if ( done[notmoved] ==false )
                                        break;
                        }

                        /* if all the integers have been flagged in the previous loop as accounted for,
                        * that loop exited with notmoved=images.length and we
                        * terminate the loop that lists cycles.
                        */
                        if ( notmoved == images.length)
                                break;

                        /* list in tracei[] the repeated images of the element notmoved.
                        */
                        int[] tracei = orbit(notmoved+REPOFFSET) ;

                        /* mark all elements in this cycle as treated and accounted
                        * for by tracei[]. Note that tracei may be empty if notmoved was a fixed element,
                        * but the associated element needs to be marked as moved anyway.
                        */
                        done[notmoved] = true ;
                        for(int i=1 ; i < tracei.length; i++)
                                done[tracei[i]-REPOFFSET] = true ;

                        /* add this cycle to the vector if non-trivial, i.e., if not for a fixed element.
                        */
                        if ( tracei.length > 1)
                                c.add(tracei) ;
                }

                int[][] cycs = new int[c.size()][] ;
                for(int i=0 ; i < c.size() ; i++)
                        cycs[i] = c.elementAt(i) ;

                return cycs ;
        } /* cycles */

        /** Generate a list of lists that are the cycle representation.
        * In the string all elements are larger than or equal to 1 and less than or equal to n, 1-based.
        * @return The 0th component are the integers in the first cycle, the 1th compoment in the second, and so on.
        */
        public String cyclRep()
        {
                int[][] allcyc = cycles() ;
                String rep= new String() ;
                /* there is one case ( the unit element) where no cycles are listed
                * because they are only containing fixed elements. To vaoid that this
                * disappears entirely, we print an empty () to let it be visible.
                */
                if ( allcyc.length == 0 )
                        return new String("()") ;

                /* loop over all cycles in the order genereated (ie, such that
                * the small elements appear early.
                */
                for(int c=0 ; c < allcyc.length ; c++)
                {
                        for(int e=0 ; e < allcyc[c].length; e++)
                        {
                                if ( e == 0 )
                                        rep += "(" + (allcyc[c][e]+1-REPOFFSET) ;
                                else if ( e == allcyc[c].length -1 )
                                        rep += " " + (allcyc[c][e]+1-REPOFFSET) +")" ;
                                else
                                        rep += " " + (allcyc[c][e]+1-REPOFFSET) ;
                        }
                }

                return rep;
        } /* cyclRep */

        /** Calculate the image of an integer
        * @param e The integer (original element).
        * @return The image of e under this permutation.
        */
        int imageOf(final int e)
        {
                if ( e < REPOFFSET )
                        throw new IllegalArgumentException("Argument " + e + " out of range for length " + images.length) ;

                /* if the element is outside the range of the permutation, it is assumed to stay fixed.
                */
                if ( e >= images.length+REPOFFSET )
                        return e;
                        
                return images[e-REPOFFSET] ;
        } /* imageOf */

        /** Generate the trace of an integer until the repeated image has closed its cycle.
        * @param s The integer to be traced.
        * @return a vector [s, images[s], images^2[s]...].
        *   Fixed elements are not reported at all, so their return vector is empty.
        */
        int[] orbit(final int s)
        {
                if ( s < REPOFFSET || s >= images.length+REPOFFSET )
                        throw new IllegalArgumentException("Argument " + s + " out of range ") ;

                Vector<Integer> or = new Vector< Integer> ();
                or.add(new Integer(s)) ;
                /* i is the i-th image of s */
                int i = s ;
                for(;;)
                {
                        i = imageOf(i) ;
                        if ( i != s )
                                /* cycle not yet closed. Append the new image to the result
                                */
                                or.add(new Integer(i)) ;
                        else
                                /* cycle completed */
                                break;
                }

                /* convert the Vector to an array */
                int[] oArr ;
                if ( or.size() >= 2 )
                {
                        /* return only something if the order of the element is at least 2; skip
                        * fixed points.
                        */
                        oArr = new int[or.size()] ;
                        for(int j=0 ; j < or.size() ; j++)
                                oArr[j] = or.elementAt(j).intValue() ;
                }
                else
                        oArr = new int[0] ;
                return oArr ;
        } /* orbit */

        /** Swap/exchange the images of i and j
        * @param i 0-based element in the permutation.
        * @param j 0-based element in the permutation.
        */
        public void swap(final int i, final int j)
        {
                final int tmp = images[i] ;
                images[i] = images[j] ;
                images[j] = tmp ;
        } /* swap */

        /** Compare with another permutation.
        * The dominant key is the lenghts of the permutations.
        * The secondary key (if of the same length) is the left-right image=by-image comparison.
        * @param oth
        * @return -1, 0 or +1 depending on whether this is smaller than, equal to or greater than oth
        */
        public int compareTo(final Permutation oth)
        {
                if (images.length < oth.images.length)
                        return -1;
                else if (images.length > oth.images.length)
                        return +1;
                else
                {
                        for(int j=0 ; j < images.length ; j++)
                        {
                                if ( images[j] < oth.images[j] )
                                        return -1 ;
                                else if ( images[j] > oth.images[j] )
                                        return 1 ;
                        }
                        return 0 ;
                }
        } /* compareTo */

        /** Index of the smallest element that is moved under the permutation.
        * @return The smallest index (0-based) that does not stay fixed.
        *   If all elements are fixed, the number of elements is returned.
        * @since 2015-03-13
        */
        public int smallestMoved()
        {
                for (int i=0 ; i < images.length ; i++)
                        if ( images[i] != i+REPOFFSET)
                                return i;
                return images.length ;
        } /* smallestMoved */

        /** Index of the largest element that is fixed under the permutation.
        * @return The largest index (0-based) that stays fixed.
        *   If all elements are moved, -1 is returned.
        * @since 2015-03-13
        */
        public int largestFixed()
        {
                for (int i= images.length-1 ; i >= 0 ; i--)
                        if ( images[i] == i+REPOFFSET)
                                return i;
                return -1 ;
        } /* largestFixed */

        /** Smallest element that remains fixed under all permutations of a set.
        * This means all elements of smaller index are moved by at least one of the permutations.
        * @param pers The set of permutations that may move the element
        * @return The minimum 0-based or 1-based element that remains fixed.
        *   If the pers move a dense set of points, this is 1 higher than the point length of the longest permutation.
        * @since 2015-03-15
        */
        static public int smallestFixed(Vector<Permutation> pers)
        {
                int el= REPOFFSET ;
                for (; ; el++)
                {
                        boolean isfix = true ;
                        for (Permutation p : pers)
                        {
                                /* does p move el? The function imageOf() fixes all elements that
                                * are beyond the range of the permutation to run this smoothly. */
                                if ( p.imageOf(el) != el)
                                {
                                        isfix = false ;
                                        break;
                                }
                        }
                        if ( isfix)
                        {
                                return el ;
                        }
                }
        } /* smallestFixed */

        /** Compute the number of moved points
        * @return The number of points that are not fixed by this permutation.
        */
        public int nrMoved()
        {
                int m=0 ;
                for (int i= 0; i <images.length ; i++)
                        if ( images[i] != i+REPOFFSET)
                                m++ ;
                return m;
        } /* nrMoved */

        /** Compute the minimum degree of a list of permutations.
        * @param per The list of permutations. These should be the full list of the members of a permutation group.
        * @return The smallest number of points that are not fixed by any non-identity permutation.
        */
        public static int nrMoved(final Permutation[] per)
        {
                /* start with the most pessimistic upper bound that all elements are moved.
                * do not use per[0].nrMoved() here because per[0] may be the identity.
                */
                int minp = 0 ;
                int m= 1+per[0].length() ;
                for (int p= 0; p < per.length ; p++)
                {
                        Permutation thisp = per[p] ;
                        if ( ! thisp.isUnit() )
                        {
                                if ( thisp.nrMoved() < m )
                                        minp = p ;
                                m = Math.min(m, thisp.nrMoved()) ;
                        }
                }
                System.out.println("deg " + m + " at g" + (minp+1) + " " + per[minp].cyclRep()) ;
                return m;
        } /* nrMoved */

        /** Check whether the fixed elements are all at the low positions.
        * @return true if the moved elements have all higher indices than the fixed elements.
        */
        boolean isSorted()
        {
                if ( orderByCycles() == 1 )
                        return true;
                final int m = smallestMoved() ;
                final int f = largestFixed() ;
                /* there are three cases: all elements moved where m=0, f=-1,
                * all elements fixed, where m=images.length, f=images.length-1 and the general case.
                * Well-ordered in the current sense are sensed by the criterion m=f+1.
                */
                return ( m == f+1) ? true: false ;
        } /* isSorted */

        /** Check whether the fixed elements are all at the low positions.
        * @return true if the moved elements have all higher indices than the fixed elements.
        */
        boolean isCycSorted()
        {
                final int[][] cyc = cycles() ;
                if ( cyc.length <= 1 )
                        return true;
                else
                {
                        /* long cycles after short cycles
                        */
                        for(int i=0 ; i < cyc.length-1 ; i++)
                                for(int j=i+1 ; j < cyc.length ; j++)
                                {
                                        if ( cyc[j].length < cyc[i].length)
                                                return false;
                                }

                        /* compare all pairs cyc[i] and cyc[j], j>i, to test if
                        * all elements of cyc[j] are larger than all elements of cyc[i]
                        */
                        for(int i=0 ; i < cyc.length-1 ; i++)
                                for(int j=i+1 ; j < cyc.length ; j++)
                                {
                                        for(int ei =0 ; ei < cyc[i].length ; ei++)
                                                for(int ej =0 ; ej < cyc[j].length ; ej++)
                                                        if ( cyc[j][ej] <= cyc[i][ei])
                                                                return false;
                                }

                        /* also enforce ordering within each cycle
                        */
                        for(int i=0 ; i < cyc.length-1 ; i++)
                        {
                                for(int ei =0 ; ei < cyc[i].length-1 ; ei++)
                                        if ( cyc[i][ei+1] <= cyc[i][ei])
                                                return false;
                        }
                        return true;
                }
        } /* iscycSorted */

        /** Test if the permutation is a pivotal representative of permutations with the same structure
        */
        boolean isPivot()
        {
                return ( isSorted() && isCycSorted() );
        } /* isPivot() */

        /** Print the permutation as a left-right list of integers.
        * This output is always using a 1-based representation of the vectors.
        * @since 2015-03-07
        * @author Richard J. Mathar
        */
        public String toString()
        {
                String s= new String("(") ;
                for(int i=0 ; i< images.length ; i++)
                        s += (images[i]+1-REPOFFSET) + " " ;
                s += ")" ;
                return s;
        } /* toString */


} /* Permutation */
