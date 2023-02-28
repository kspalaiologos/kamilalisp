package org.kc7bfi.jflac.util;

/**
 * libFLAC - Free Lossless Audio Codec library
 * Copyright (C) 2001,2002,2003  Josh Coalson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307, USA.
 */

/**
 * Utility class for bit math.
 * @author kc7bfi
 */
public final class BitMath {
    
    /**
     * Compute ilog2().
     *  An example of what ilog2() computes:
     *
     * ilog2( 0) = assertion failure
     * ilog2( 1) = 0
     * ilog2( 2) = 1
     * ilog2( 3) = 1
     * ilog2( 4) = 2
     * ilog2( 5) = 2
     * ilog2( 6) = 2
     * ilog2( 7) = 2
     * ilog2( 8) = 3
     * ilog2( 9) = 3
     * ilog2(10) = 3
     * ilog2(11) = 3
     * ilog2(12) = 3
     * ilog2(13) = 3
     * ilog2(14) = 3
     * ilog2(15) = 3
     * ilog2(16) = 4
     * ilog2(17) = 4
     * ilog2(18) = 4
     * 
     * @param v     The value
     * @return      The ilog2 value
     */
    public static int ilog2(int v) {
        int l = 0;
        while ((v >>= 1) != 0) l++;
        return l;
    }
    
    /**
     * Compute silog2().
     * An example of what silog2() computes:
     *
     * silog2(-10) = 5
     * silog2(- 9) = 5
     * silog2(- 8) = 4
     * silog2(- 7) = 4
     * silog2(- 6) = 4
     * silog2(- 5) = 4
     * silog2(- 4) = 3
     * silog2(- 3) = 3
     * silog2(- 2) = 2
     * silog2(- 1) = 2
     * silog2(  0) = 0
     * silog2(  1) = 2
     * silog2(  2) = 3
     * silog2(  3) = 3
     * silog2(  4) = 4
     * silog2(  5) = 4
     * silog2(  6) = 4
     * silog2(  7) = 4
     * silog2(  8) = 5
     * silog2(  9) = 5
     * silog2( 10) = 5
     * 
     * @param v     The value
     * @return      The silog2 value
     */
    public static int silog2(int v) {
        while (true) {
            if (v == 0) return 0;
            if (v > 0) {
                int l = 0;
                while (v != 0) {
                    l++;
                    v >>= 1;
                }
                return l + 1;
            }
            if (v == -1) return 2;
            v++;
            v = -v;
        }
    }
    
    /**
     * Compute silog2().
     * An example of what silog2() computes:
     *
     * silog2(-10) = 5
     * silog2(- 9) = 5
     * silog2(- 8) = 4
     * silog2(- 7) = 4
     * silog2(- 6) = 4
     * silog2(- 5) = 4
     * silog2(- 4) = 3
     * silog2(- 3) = 3
     * silog2(- 2) = 2
     * silog2(- 1) = 2
     * silog2(  0) = 0
     * silog2(  1) = 2
     * silog2(  2) = 3
     * silog2(  3) = 3
     * silog2(  4) = 4
     * silog2(  5) = 4
     * silog2(  6) = 4
     * silog2(  7) = 4
     * silog2(  8) = 5
     * silog2(  9) = 5
     * silog2( 10) = 5
     * 
     * @param v     The value
     * @return      The silog2 value
     */
    public static int silog2Wide(long v) {
        while (true) {
            if (v == 0) return 0;
            if (v > 0) {
                int l = 0;
                while (v != 0) {
                    l++;
                    v >>= 1;
                }
                return l + 1;
            }
            if (v == -1) return 2;
            v++;
            v = -v;
        }
    }
}
