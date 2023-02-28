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
import org.kc7bfi.jflac.io.BitOutputStream;

/**
 * SeekTable Metadata block.
 * @author kc7bfi
 */
public class SeekTable extends Metadata {
    private static final int SEEKPOINT_LENGTH_BYTES = 18;

    protected SeekPoint[] points;

    /**
     * The constructor.
     * @param is                The InputBitStream
     * @param length            Length of the record
     * @param isLast            True if this is the last Metadata block in the chain
     * @throws IOException      Thrown if error reading from InputBitStream
     */
    public SeekTable(BitInputStream is, int length, boolean isLast) throws IOException {
        super(isLast);
        int numPoints = length / SEEKPOINT_LENGTH_BYTES;

        points = new SeekPoint[numPoints];
        for (int i = 0; i < points.length; i++) {
            points[i] = new SeekPoint(is);
        }
        length -= (length * SEEKPOINT_LENGTH_BYTES);
        
        // if there is a partial point left, skip over it
        if (length > 0) is.readByteBlockAlignedNoCRC(null, length);
    }
    
    /**
     * Constructor.
     * @param points    Seek Points
     * @param isLast            True if this is the last Metadata block in the chain
     */
    public SeekTable(SeekPoint[] points, boolean isLast) {
        super(isLast);
        this.points = points;
    }
    
    /**
     * Write out the metadata block.
     * @param os    The output stream
     * @param isLast    True if this is the last metadata block
     * @throws IOException  Thrown if error writing data
     */
    public void write(BitOutputStream os, boolean isLast) throws IOException {

        os.writeRawUInt(isLast, STREAM_METADATA_IS_LAST_LEN);
        os.writeRawUInt(METADATA_TYPE_SEEKTABLE, STREAM_METADATA_TYPE_LEN);
        os.writeRawUInt(calcLength(), STREAM_METADATA_LENGTH_LEN);
        
        for (int i = 0; i < points.length; i++) {
            points[i].write(os);
        }
        
        os.flushByteAligned();
    }
    
    /**
     * Calculate the metadata block size.
     * @return The metadata block size
     */
    public int calcLength() {
        return points.length * SEEKPOINT_LENGTH_BYTES;
    }
    
    /**
     * Return the selected seek point.
     * @param idx   The seek point number
     * @return  The selected seek point
     */
    public SeekPoint getSeekPoint(int idx) {
        if (idx < 0 || idx >= points.length) return null;
        return points[idx];
    }
    
    /**
     * Return the number of seek points.
     * @return the number of seek points
     */
    public int numberOfPoints() {
        return points.length;
    }
    
    /**
     * @see java.lang.Object#toString()
     */
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("SeekTable: points=" + points.length + "\n");
        for (int i = 0; i < points.length; i++) {
            sb.append("\tPoint " + points[i].toString() + "\n");
        }
        
        return sb.toString();
        
    }
}
