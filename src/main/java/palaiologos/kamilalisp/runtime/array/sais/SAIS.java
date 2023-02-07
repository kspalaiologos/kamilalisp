package palaiologos.kamilalisp.runtime.array.sais;

/*
 * sais.java for sais-java
 * Copyright (c) 2008-2010 Yuta Mori All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

public class SAIS {
    /* find the start or end of each bucket */
    private static void
    getCounts(BaseArray T, BaseArray C, int n, int k) {
        int i;
        for (i = 0; i < k; ++i) {
            C.set(i, 0);
        }
        for (i = 0; i < n; ++i) {
            C.update(T.get(i), 1);
        }
    }

    private static void
    getBuckets(BaseArray C, BaseArray B, int k, boolean end) {
        int i, sum = 0;
        if (end) {
            for (i = 0; i < k; ++i) {
                sum += C.get(i);
                B.set(i, sum);
            }
        } else {
            for (i = 0; i < k; ++i) {
                sum += C.get(i);
                B.set(i, sum - C.get(i));
            }
        }
    }

    /* sort all type LMS suffixes */
    private static void
    LMSsort(BaseArray T, int[] SA, BaseArray C, BaseArray B, int n, int k) {
        int b, i, j;
        int c0, c1;
        /* compute SAl */
        if (C == B) {
            getCounts(T, C, n, k);
        }
        getBuckets(C, B, k, false); /* find starts of buckets */
        j = n - 1;
        b = B.get(c1 = T.get(j));
        --j;
        SA[b++] = (T.get(j) < c1) ? ~j : j;
        for (i = 0; i < n; ++i) {
            if (0 < (j = SA[i])) {
                if ((c0 = T.get(j)) != c1) {
                    B.set(c1, b);
                    b = B.get(c1 = c0);
                }
                --j;
                SA[b++] = (T.get(j) < c1) ? ~j : j;
                SA[i] = 0;
            } else if (j < 0) {
                SA[i] = ~j;
            }
        }
        /* compute SAs */
        if (C == B) {
            getCounts(T, C, n, k);
        }
        getBuckets(C, B, k, true); /* find ends of buckets */
        for (i = n - 1, b = B.get(c1 = 0); 0 <= i; --i) {
            if (0 < (j = SA[i])) {
                if ((c0 = T.get(j)) != c1) {
                    B.set(c1, b);
                    b = B.get(c1 = c0);
                }
                --j;
                SA[--b] = (T.get(j) > c1) ? ~(j + 1) : j;
                SA[i] = 0;
            }
        }
    }

    private static int
    LMSpostproc(BaseArray T, int[] SA, int n, int m) {
        int i, j, p, q, plen, qlen, name;
        int c0, c1;
        boolean diff;

    /* compact all the sorted substrings into the first m items of SA
        2*m must be not larger than n (proveable) */
        for (i = 0; (p = SA[i]) < 0; ++i) {
            SA[i] = ~p;
        }
        if (i < m) {
            for (j = i, ++i; ; ++i) {
                if ((p = SA[i]) < 0) {
                    SA[j++] = ~p;
                    SA[i] = 0;
                    if (j == m) {
                        break;
                    }
                }
            }
        }

        /* store the length of all substrings */
        i = n - 1;
        j = n - 1;
        c0 = T.get(n - 1);
        do {
            c1 = c0;
        } while ((0 <= --i) && ((c0 = T.get(i)) >= c1));
        while (0 <= i) {
            do {
                c1 = c0;
            } while ((0 <= --i) && ((c0 = T.get(i)) <= c1));
            if (0 <= i) {
                SA[m + ((i + 1) >> 1)] = j - i;
                j = i + 1;
                do {
                    c1 = c0;
                } while ((0 <= --i) && ((c0 = T.get(i)) >= c1));
            }
        }

        /* find the lexicographic names of all substrings */
        for (i = 0, name = 0, q = n, qlen = 0; i < m; ++i) {
            p = SA[i];
            plen = SA[m + (p >> 1)];
            diff = true;
            if ((plen == qlen) && ((q + plen) < n)) {
                for (j = 0; (j < plen) && (T.get(p + j) == T.get(q + j)); ++j) {
                }
                if (j == plen) {
                    diff = false;
                }
            }
            if (diff) {
                ++name;
                q = p;
                qlen = plen;
            }
            SA[m + (p >> 1)] = name;
        }

        return name;
    }

    /* compute SA and BWT */
    private static void
    induceSA(BaseArray T, int[] SA, BaseArray C, BaseArray B, int n, int k) {
        int b, i, j;
        int c0, c1;
        /* compute SAl */
        if (C == B) {
            getCounts(T, C, n, k);
        }
        getBuckets(C, B, k, false); /* find starts of buckets */
        j = n - 1;
        b = B.get(c1 = T.get(j));
        SA[b++] = ((0 < j) && (T.get(j - 1) < c1)) ? ~j : j;
        for (i = 0; i < n; ++i) {
            j = SA[i];
            SA[i] = ~j;
            if (0 < j) {
                if ((c0 = T.get(--j)) != c1) {
                    B.set(c1, b);
                    b = B.get(c1 = c0);
                }
                SA[b++] = ((0 < j) && (T.get(j - 1) < c1)) ? ~j : j;
            }
        }
        /* compute SAs */
        if (C == B) {
            getCounts(T, C, n, k);
        }
        getBuckets(C, B, k, true); /* find ends of buckets */
        for (i = n - 1, b = B.get(c1 = 0); 0 <= i; --i) {
            if (0 < (j = SA[i])) {
                if ((c0 = T.get(--j)) != c1) {
                    B.set(c1, b);
                    b = B.get(c1 = c0);
                }
                SA[--b] = ((j == 0) || (T.get(j - 1) > c1)) ? ~j : j;
            } else {
                SA[i] = ~j;
            }
        }
    }

    private static int
    computeBWT(BaseArray T, int[] SA, BaseArray C, BaseArray B, int n, int k) {
        int b, i, j, pidx = -1;
        int c0, c1;
        /* compute SAl */
        if (C == B) {
            getCounts(T, C, n, k);
        }
        getBuckets(C, B, k, false); /* find starts of buckets */
        j = n - 1;
        b = B.get(c1 = T.get(j));
        SA[b++] = ((0 < j) && (T.get(j - 1) < c1)) ? ~j : j;
        for (i = 0; i < n; ++i) {
            if (0 < (j = SA[i])) {
                SA[i] = ~(c0 = T.get(--j));
                if (c0 != c1) {
                    B.set(c1, b);
                    b = B.get(c1 = c0);
                }
                SA[b++] = ((0 < j) && (T.get(j - 1) < c1)) ? ~j : j;
            } else if (j != 0) {
                SA[i] = ~j;
            }
        }
        /* compute SAs */
        if (C == B) {
            getCounts(T, C, n, k);
        }
        getBuckets(C, B, k, true); /* find ends of buckets */
        for (i = n - 1, b = B.get(c1 = 0); 0 <= i; --i) {
            if (0 < (j = SA[i])) {
                SA[i] = (c0 = T.get(--j));
                if (c0 != c1) {
                    B.set(c1, b);
                    b = B.get(c1 = c0);
                }
                SA[--b] = ((0 < j) && (T.get(j - 1) > c1)) ? ~((int) T.get(j - 1)) : j;
            } else if (j != 0) {
                SA[i] = ~j;
            } else {
                pidx = i;
            }
        }
        return pidx;
    }

    /* find the suffix array SA of T[0..n-1] in {0..k-1}^n
       use a working space (excluding T and SA) of at most 2n+O(1) for a constant alphabet */
    private static int
    SA_IS(BaseArray T, int[] SA, int fs, int n, int k, boolean isbwt) {
        BaseArray C, B, RA;
        int i, j, b, c, m, p, q, name, pidx = 0, newfs;
        int c0, c1;
        int flags = 0;

        if (k <= 256) {
            C = new IntArray(new int[k], 0);
            if (k <= fs) {
                B = new IntArray(SA, n + fs - k);
                flags = 1;
            } else {
                B = new IntArray(new int[k], 0);
                flags = 3;
            }
        } else if (k <= fs) {
            C = new IntArray(SA, n + fs - k);
            if (k <= (fs - k)) {
                B = new IntArray(SA, n + fs - k * 2);
                flags = 0;
            } else if (k <= 1024) {
                B = new IntArray(new int[k], 0);
                flags = 2;
            } else {
                B = C;
                flags = 8;
            }
        } else {
            C = B = new IntArray(new int[k], 0);
            flags = 4 | 8;
        }

    /* stage 1: reduce the problem by at least 1/2
       sort all the LMS-substrings */
        getCounts(T, C, n, k);
        getBuckets(C, B, k, true); /* find ends of buckets */
        for (i = 0; i < n; ++i) {
            SA[i] = 0;
        }
        b = -1;
        i = n - 1;
        j = n;
        m = 0;
        c0 = T.get(n - 1);
        do {
            c1 = c0;
        } while ((0 <= --i) && ((c0 = T.get(i)) >= c1));
        while (0 <= i) {
            do {
                c1 = c0;
            } while ((0 <= --i) && ((c0 = T.get(i)) <= c1));
            if (0 <= i) {
                if (0 <= b) {
                    SA[b] = j;
                }
                b = B.update(c1, -1);
                j = i;
                ++m;
                do {
                    c1 = c0;
                } while ((0 <= --i) && ((c0 = T.get(i)) >= c1));
            }
        }
        if (1 < m) {
            LMSsort(T, SA, C, B, n, k);
            name = LMSpostproc(T, SA, n, m);
        } else if (m == 1) {
            SA[b] = j + 1;
            name = 1;
        } else {
            name = 0;
        }

    /* stage 2: solve the reduced problem
       recurse if names are not yet unique */
        if (name < m) {
            if ((flags & 4) != 0) {
                C = null;
                B = null;
            }
            if ((flags & 2) != 0) {
                B = null;
            }
            newfs = (n + fs) - (m * 2);
            if ((flags & (1 | 4 | 8)) == 0) {
                if ((k + name) <= newfs) {
                    newfs -= k;
                } else {
                    flags |= 8;
                }
            }
            for (i = m + (n >> 1) - 1, j = m * 2 + newfs - 1; m <= i; --i) {
                if (SA[i] != 0) {
                    SA[j--] = SA[i] - 1;
                }
            }
            RA = new IntArray(SA, m + newfs);
            SA_IS(RA, SA, newfs, m, name, false);
            RA = null;

            i = n - 1;
            j = m * 2 - 1;
            c0 = T.get(n - 1);
            do {
                c1 = c0;
            } while ((0 <= --i) && ((c0 = T.get(i)) >= c1));
            while (0 <= i) {
                do {
                    c1 = c0;
                } while ((0 <= --i) && ((c0 = T.get(i)) <= c1));
                if (0 <= i) {
                    SA[j--] = i + 1;
                    do {
                        c1 = c0;
                    } while ((0 <= --i) && ((c0 = T.get(i)) >= c1));
                }
            }

            for (i = 0; i < m; ++i) {
                SA[i] = SA[m + SA[i]];
            }
            if ((flags & 4) != 0) {
                C = B = new IntArray(new int[k], 0);
            }
            if ((flags & 2) != 0) {
                B = new IntArray(new int[k], 0);
            }
        }

        /* stage 3: induce the result for the original problem */
        if ((flags & 8) != 0) {
            getCounts(T, C, n, k);
        }
        /* put all left-most S characters into their buckets */
        if (1 < m) {
            getBuckets(C, B, k, true); /* find ends of buckets */
            i = m - 1;
            j = n;
            p = SA[m - 1];
            c1 = T.get(p);
            do {
                q = B.get(c0 = c1);
                while (q < j) {
                    SA[--j] = 0;
                }
                do {
                    SA[--j] = p;
                    if (--i < 0) {
                        break;
                    }
                    p = SA[i];
                } while ((c1 = T.get(p)) == c0);
            } while (0 <= i);
            while (0 < j) {
                SA[--j] = 0;
            }
        }
        if (!isbwt) {
            induceSA(T, SA, C, B, n, k);
        } else {
            pidx = computeBWT(T, SA, C, B, n, k);
        }
        C = null;
        B = null;
        return pidx;
    }

    /**
     * Suffixsorting
     **/
    /* byte */
    public static int
    suffixsort(byte[] T, int[] SA, int n) {
        if ((T == null) || (SA == null) || (T.length < n) || (SA.length < n)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                SA[0] = 0;
            }
            return 0;
        }
        return SA_IS(new ByteArray(T), SA, 0, n, 256, false);
    }

    /* char */
    public static int
    suffixsort(char[] T, int[] SA, int n) {
        if ((T == null) || (SA == null) || (T.length < n) || (SA.length < n)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                SA[0] = 0;
            }
            return 0;
        }
        return SA_IS(new CharArray(T), SA, 0, n, 65536, false);
    }

    /* short */
    public static int
    suffixsort(short[] T, int[] SA, int n, int k) {
        if ((T == null) || (SA == null) ||
                (T.length < n) || (SA.length < n) ||
                (k <= 0) || (65536 < k)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                SA[0] = 0;
            }
            return 0;
        }
        return SA_IS(new ShortArray(T), SA, 0, n, k, false);
    }

    /* int */
    public static int
    suffixsort(int[] T, int[] SA, int n, int k) {
        if ((T == null) || (SA == null) ||
                (T.length < n) || (SA.length < n) ||
                (k <= 0)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                SA[0] = 0;
            }
            return 0;
        }
        return SA_IS(new IntArray(T, 0), SA, 0, n, k, false);
    }

    /* String */
    public static int
    suffixsort(String T, int[] SA, int n) {
        if ((T == null) || (SA == null) ||
                (T.length() < n) || (SA.length < n)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                SA[0] = 0;
            }
            return 0;
        }
        return SA_IS(new StringArray(T), SA, 0, n, 65536, false);
    }

    /**
     * Burrows-Wheeler Transform
     **/
    /* byte */
    public static int
    bwtransform(byte[] T, byte[] U, int[] A, int n) {
        int i, pidx;
        if ((T == null) || (U == null) || (A == null) ||
                (T.length < n) || (U.length < n) || (A.length < n)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                U[0] = T[0];
            }
            return n;
        }
        pidx = SA_IS(new ByteArray(T), A, 0, n, 256, true);
        U[0] = T[n - 1];
        for (i = 0; i < pidx; ++i) {
            U[i + 1] = (byte) (A[i] & 0xff);
        }
        for (i += 1; i < n; ++i) {
            U[i] = (byte) (A[i] & 0xff);
        }
        return pidx + 1;
    }

    /* char */
    public static int
    bwtransform(char[] T, char[] U, int[] A, int n) {
        int i, pidx;
        if ((T == null) || (U == null) || (A == null) ||
                (T.length < n) || (U.length < n) || (A.length < n)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                U[0] = T[0];
            }
            return n;
        }
        pidx = SA_IS(new CharArray(T), A, 0, n, 65536, true);
        U[0] = T[n - 1];
        for (i = 0; i < pidx; ++i) {
            U[i + 1] = (char) (A[i] & 0xffff);
        }
        for (i += 1; i < n; ++i) {
            U[i] = (char) (A[i] & 0xffff);
        }
        return pidx + 1;
    }

    /* short */
    public static int
    bwtransform(short[] T, short[] U, int[] A, int n, int k) {
        int i, pidx;
        if ((T == null) || (U == null) || (A == null) ||
                (T.length < n) || (U.length < n) || (A.length < n) ||
                (k <= 0) || (65536 < k)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                U[0] = T[0];
            }
            return n;
        }
        pidx = SA_IS(new ShortArray(T), A, 0, n, k, true);
        U[0] = T[n - 1];
        for (i = 0; i < pidx; ++i) {
            U[i + 1] = (short) (A[i] & 0xffff);
        }
        for (i += 1; i < n; ++i) {
            U[i] = (short) (A[i] & 0xffff);
        }
        return pidx + 1;
    }

    /* int */
    public static int
    bwtransform(int[] T, int[] U, int[] A, int n, int k) {
        int i, pidx;
        if ((T == null) || (U == null) || (A == null) ||
                (T.length < n) || (U.length < n) || (A.length < n) ||
                (k <= 0)) {
            return -1;
        }
        if (n <= 1) {
            if (n == 1) {
                U[0] = T[0];
            }
            return n;
        }
        pidx = SA_IS(new IntArray(T, 0), A, 0, n, k, true);
        U[0] = T[n - 1];
        for (i = 0; i < pidx; ++i) {
            U[i + 1] = A[i];
        }
        for (i += 1; i < n; ++i) {
            U[i] = A[i];
        }
        return pidx + 1;
    }

    private interface BaseArray {
        int get(int i);

        void set(int i, int val);

        int update(int i, int val);
    }

    private static class ByteArray implements BaseArray {
        private byte[] m_A;
        private int m_pos;

        ByteArray(byte[] A) {
            m_A = A;
            m_pos = 0;
        }

        public int get(int i) {
            return m_A[m_pos + i] & 0xff;
        }

        public void set(int i, int val) {
            m_A[m_pos + i] = (byte) (val & 0xff);
        }

        public int update(int i, int val) {
            return m_A[m_pos + i] += val & 0xff;
        }
    }

    private static class CharArray implements BaseArray {
        private char[] m_A;
        private int m_pos;

        CharArray(char[] A) {
            m_A = A;
            m_pos = 0;
        }

        public int get(int i) {
            return m_A[m_pos + i] & 0xffff;
        }

        public void set(int i, int val) {
            m_A[m_pos + i] = (char) (val & 0xffff);
        }

        public int update(int i, int val) {
            return m_A[m_pos + i] += val & 0xffff;
        }
    }

    private static class ShortArray implements BaseArray {
        private short[] m_A;
        private int m_pos;

        ShortArray(short[] A) {
            m_A = A;
            m_pos = 0;
        }

        public int get(int i) {
            return m_A[m_pos + i] & 0xffff;
        }

        public void set(int i, int val) {
            m_A[m_pos + i] = (short) (val & 0xffff);
        }

        public int update(int i, int val) {
            return m_A[m_pos + i] += val & 0xffff;
        }
    }

    private static class IntArray implements BaseArray {
        private int[] m_A;
        private int m_pos;

        IntArray(int[] A, int pos) {
            m_A = A;
            m_pos = pos;
        }

        public int get(int i) {
            return m_A[m_pos + i];
        }

        public void set(int i, int val) {
            m_A[m_pos + i] = val;
        }

        public int update(int i, int val) {
            return m_A[m_pos + i] += val;
        }
    }

    private static class StringArray implements BaseArray {
        private String m_A;
        private int m_pos;

        StringArray(String A) {
            m_A = A;
            m_pos = 0;
        }

        public int get(int i) {
            return m_A.charAt(m_pos + i) & 0xffff;
        }

        public void set(int i, int val) {
        }

        public int update(int i, int val) {
            return 0;
        }
    }
}
