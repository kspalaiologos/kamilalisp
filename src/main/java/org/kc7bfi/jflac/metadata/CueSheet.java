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
 * CueSheet Metadata block.
 * @author kc7bfi
 */
public class CueSheet extends Metadata {

    private static final int CUESHEET_MEDIA_CATALOG_NUMBER_LEN = 128 * 8; // bits
    private static final int CUESHEET_LEAD_IN_LEN = 64; // bits
    private static final int CUESHEET_IS_CD_LEN = 1; // bit
    private static final int CUESHEET_RESERVED_LEN = 7 + 258 * 8; // bits
    private static final int CUESHEET_NUM_TRACKS_LEN = 8; // bits

    /** 
     * Media catalog number.
     * in ASCII printable characters 0x20-0x7e.  In
     * general, the media catalog number may be 0 to 128 bytes long; any
     * unused characters should be right-padded with NUL characters.
     */
    protected byte[] mediaCatalogNumber = new byte[129];

    protected long leadIn = 0; // The number of lead-in samples.
    protected boolean isCD = false; // true if CUESHEET corresponds to a Compact Disc, else false
    protected int numTracks = 0; // The number of tracks.
    protected CueTrack[] tracks; // NULL if num_tracks == 0, else pointer to array of tracks.

    /**
     * The constructor.
     * @param is                The InputBitStream
     * @param length            Length of the record
     * @param isLast            True if this is the last Metadata block in the chain
     * @throws IOException      Thrown if error reading from InputBitStream
     */
    public CueSheet(BitInputStream is, int length, boolean isLast) throws IOException {
        super(isLast);
        is.readByteBlockAlignedNoCRC(mediaCatalogNumber, CUESHEET_MEDIA_CATALOG_NUMBER_LEN / 8);
        leadIn = is.readRawULong(CUESHEET_LEAD_IN_LEN);
        isCD = (is.readRawUInt(CUESHEET_IS_CD_LEN) != 0);
        is.skipBitsNoCRC(CUESHEET_RESERVED_LEN);
        numTracks = is.readRawUInt(CUESHEET_NUM_TRACKS_LEN);

        if (numTracks > 0) {
            tracks = new CueTrack[numTracks];
            for (int i = 0; i < numTracks; i++) {
                tracks[i] = new CueTrack(is);
            }
        }
    }

    /**
     * Verifys the Cue Sheet.
     * @param checkCdDaSubset   True for check CD subset
     * @throws Violation        Thrown if invalid Cue Sheet
     */
    void isLegal(boolean checkCdDaSubset) throws Violation {

        if (checkCdDaSubset) {
            if (leadIn < 2 * 44100) {
                    throw new Violation("CD-DA cue sheet must have a lead-in length of at least 2 seconds");
            }
            if (leadIn % 588 != 0) {
                throw new Violation("CD-DA cue sheet lead-in length must be evenly divisible by 588 samples");
            }
        }

        if (numTracks == 0) {
            throw new Violation("cue sheet must have at least one track (the lead-out)");
        }

        if (checkCdDaSubset && tracks[numTracks - 1].number != 170) {
            throw new Violation("CD-DA cue sheet must have a lead-out track number 170 (0xAA)");
        }

        for (int i = 0; i < numTracks; i++) {
            if (tracks[i].number == 0) {
                throw new Violation("cue sheet may not have a track number 0");
            }

            if (checkCdDaSubset) {
                if (!((tracks[i].number >= 1 && tracks[i].number <= 99)
                    || tracks[i].number == 170)) {
                        throw new Violation("CD-DA cue sheet track number must be 1-99 or 170");
                }
            }

            if (checkCdDaSubset && tracks[i].offset % 588 != 0) {
                throw new Violation("CD-DA cue sheet track offset must be evenly divisible by 588 samples");
            }

            if (i < numTracks - 1) {
                if (tracks[i].numIndices == 0) {
                    throw new Violation("cue sheet track must have at least one index point");
                }

                if (tracks[i].indices[0].number > 1) {
                    throw new Violation("cue sheet track's first index number must be 0 or 1");
                }
            }

            for (int j = 0; j < tracks[i].numIndices; j++) {
                if (checkCdDaSubset && tracks[i].indices[j].offset % 588 != 0) {
                    throw new Violation("CD-DA cue sheet track index offset must be evenly divisible by 588 samples");
                }

                if (j > 0) {
                    if (tracks[i].indices[j].number != tracks[i].indices[j - 1].number + 1) {
                        throw new Violation("cue sheet track index numbers must increase by 1");
                    }
                }
            }
        }
    }

}
