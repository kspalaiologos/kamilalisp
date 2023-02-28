package org.kc7bfi.jflac.metadata;

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

import org.kc7bfi.jflac.io.BitInputStream;

/**
 * An entry into the cue sheet.
 * @author kc7bfi
 */
public class CueTrack {

    private static final int CUESHEET_TRACK_OFFSET_LEN = 64; // bits
    private static final int CUESHEET_TRACK_NUMBER_LEN = 8; // bits
    private static final int CUESHEET_TRACK_ISRC_LEN = 12 * 8; // bits
    private static final int CUESHEET_TRACK_TYPE_LEN = 1; // bit
    private static final int CUESHEET_TRACK_PRE_EMPHASIS_LEN = 1; // bit
    private static final int CUESHEET_TRACK_RESERVED_LEN = 6 + 13 * 8; // bits
    private static final int CUESHEET_TRACK_NUM_INDICES_LEN = 8; // bits

    protected long offset; // Track offset in samples, relative to the beginning of the FLAC audio stream.
    protected byte number; // The track number.
    protected byte[] isrc = new byte[13]; // Track ISRC.  This is a 12-digit alphanumeric code plus a trailing '\0'
    protected int type; // The track type: 0 for audio, 1 for non-audio.
    protected int preEmphasis; // The pre-emphasis flag: 0 for no pre-emphasis, 1 for pre-emphasis.
    protected byte numIndices; // The number of track index points.
    protected CueIndex[] indices; // NULL if num_indices == 0, else pointer to array of index points.

    /**
     * The constructor.
     * @param is                The InputBitStream
     * @throws IOException      Thrown if error reading from InputBitStream
     */
    public CueTrack(BitInputStream is) throws IOException {
        offset = is.readRawULong(CUESHEET_TRACK_OFFSET_LEN);
        number = (byte) is.readRawUInt(CUESHEET_TRACK_NUMBER_LEN);
        is.readByteBlockAlignedNoCRC(isrc, CUESHEET_TRACK_ISRC_LEN / 8);
        type = is.readRawUInt(CUESHEET_TRACK_TYPE_LEN);
        preEmphasis = is.readRawUInt(CUESHEET_TRACK_PRE_EMPHASIS_LEN);
        is.skipBitsNoCRC(CUESHEET_TRACK_RESERVED_LEN);
        numIndices = (byte) is.readRawUInt(CUESHEET_TRACK_NUM_INDICES_LEN);
        if (numIndices > 0) {
            indices = new CueIndex[numIndices];
            for (int j = 0; j < numIndices; j++) {
                indices[j] = new CueIndex(is);
            }
        }
        
    }
}
