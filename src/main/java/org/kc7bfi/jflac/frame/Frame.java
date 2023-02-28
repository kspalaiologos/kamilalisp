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

import org.kc7bfi.jflac.Constants;

/**
 * The FLAC Frame class.
 * @author kc7bfi
 */
public class Frame {
    /** The frame header. */
    public Header header;
    
    /** The subframes - One per channel. */
    public Channel[] subframes = new Channel[Constants.MAX_CHANNELS];
    
    /** The frame footer. */
    private short crc;
    
    /**
     * @see java.lang.Object#toString()
     */
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("Frame Header: " + header + "\n");
        for (int i = 0; i < header.channels; i++) {
            sb.append("\tFrame Data " + subframes[i].toString() + "\n");
        }
        sb.append("\tFrame Footer: " + crc);
        
        return sb.toString();
        
    }
    
    /**
     * Return the maximum Rice partition order based on the block size.
     * @param blocksize The block size
     * @return  The maximum Rice partition order
     */
    public static int getMaxRicePartitionOrderFromBlocksize(int blocksize) {
        int maxRicePartitionOrder = 0;
        while ((blocksize & 1) == 0) {
            maxRicePartitionOrder++;
            blocksize >>= 1;
        }
        return Math.min(Constants.MAX_RICE_PARTITION_ORDER, maxRicePartitionOrder);
    }
    
    /**
     * return the frame's CRC.
     * @return Returns the crc.
     */
    public short getCRC() {
        return crc;
    }
    
    /**
     * Set the frame's CRC.
     * @param crc The crc to set.
     */
    public void setCRC(short crc) {
        this.crc = crc;
    }
}
