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

import java.io.IOException;

import org.kc7bfi.jflac.ChannelData;
import org.kc7bfi.jflac.io.BitInputStream;

/**
 * FLAC Constant Subframe (Channel) data.
 * This class represents a FLAC subframe (channel) for a Constant data
 * @author kc7bfi
 */
public class ChannelConstant extends Channel {
    
    /** The constant signal value. */
    private int value;

    /**
     * The constructor.
     * @param is            The InputBitStream
     * @param header        The FLAC Frame Header
     * @param channelData   The decoded channel data (output)
     * @param bps           The bits-per-second
     * @param wastedBits    The bits waisted in the frame
     * @throws IOException  Thrown if error reading from the InputBitStream
     */
    public ChannelConstant(BitInputStream is, Header header, ChannelData channelData, int bps, int wastedBits) throws IOException {
        super(header, wastedBits);

        value = is.readRawInt(bps);

        // decode the subframe
        for (int i = 0; i < header.blockSize; i++) channelData.getOutput()[i] = value;
    }
    
    /**
     * toString conversion.
     * @see java.lang.Object#toString()
     */
    public String toString() {
        return "ChannelConstant: Value=" + value + " WastedBits=" + wastedBits;
    }
}
