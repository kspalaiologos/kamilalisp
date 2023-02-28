package org.kc7bfi.jflac;

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

import org.kc7bfi.jflac.frame.EntropyPartitionedRiceContents;

/**
 * FLAC channel data.
 * This class holds the data for the channels in a FLAC frame.
 * @author kc7bfi
 */
public class ChannelData {
    /** The output signal. */
    private int[] output;
    
    /** the risidual signal. */
    private int[] residual;
    
    /** The Entropy signal. */
    private EntropyPartitionedRiceContents partitionedRiceContents;
    
    /**
     * The default constructor.
     * @param size  The block size
     */
    public ChannelData(final int size) {
        output = new int[size];
        residual = new int[size];
        partitionedRiceContents = new EntropyPartitionedRiceContents();
    }
    
    /**
     * @return Returns the output.
     */
    public int[] getOutput() {
        return output;
    }
    
    /**
     * @return Returns the partitionedRiceContents.
     */
    public EntropyPartitionedRiceContents getPartitionedRiceContents() {
        return partitionedRiceContents;
    }
    
    /**
     * @return Returns the residual.
     */
    public int[] getResidual() {
        return residual;
    }
}
