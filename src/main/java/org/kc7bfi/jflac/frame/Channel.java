package org.kc7bfi.jflac.frame;

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
 * Base class for FLAC subframe (channel) classes.
 * @author kc7bfi
 */
public abstract class Channel {

    /** Partisioned Rice Encoding Method. */
    public static final int ENTROPY_CODING_METHOD_PARTITIONED_RICE = 0;
    
    /** The size of the encoding method field (in bits). */
    public static final int ENTROPY_CODING_METHOD_TYPE_LEN = 2;
    
    /** The size of the Rice Order field (in bits). */
    public static final int ENTROPY_CODING_METHOD_PARTITIONED_RICE_ORDER_LEN = 4;

    /** The FLAC Frame Header. */
    protected Header header;
    
    /** The number of waisted bits in the frame. */
    protected int wastedBits;
 
    /**
     * The constructor.
     * @param header        The FLAC Frame Header
     * @param wastedBits    The number of waisted bits in the frame
     */
    protected Channel(Header header, int wastedBits) {
        this.header = header;
        this.wastedBits = wastedBits;
    }
    
    /**
     * Return he number of waisted bits in the frame.
     * @return The number of waisted bits in the frame
     */
    public int getWastedBits() {
        return wastedBits;
    }
}
