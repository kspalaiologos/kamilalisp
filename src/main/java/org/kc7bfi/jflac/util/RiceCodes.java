/*
 * Created on Jun 24, 2004
 *
 * To change the template for this generated file go to
 * Window - Preferences - Java - Code Generation - Code and Comments
 */
package org.kc7bfi.jflac.util;


/**
 * Utility class for handling Rice codes.
 * @author kc7bfi
 */
public class RiceCodes {
    
    /**
     * generate int from rice code.
     * @param val   The rice code
     * @param parameter The rice parameter
     * @return  The decoded value
     */
    public int riceBits(int val, int parameter) {
        // fold signed to unsigned
        int uval;
        if (val < 0) {
            // equivalent to (unsigned)(((--val) < < 1) - 1); but without the overflow problem at MININT
            uval = (int) (((-(++val)) << 1) + 1);
        } else {
            uval = (int) (val << 1);
        }
        int msbs = uval >> parameter;
        return 1 + parameter + msbs;
    }
}
