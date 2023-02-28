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

package org.kc7bfi.jflac.metadata;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import org.kc7bfi.jflac.io.BitInputStream;


/**
 * Picture Metadata block.
 * @author BMacNaughton
 */
public class Picture extends Metadata {
    private int pictureType;
    private int mimeTypeByteCount;
    private String mimeString;      //ASCII 0x20 to 0x7e or --> (data is URL)
    private int descStringByteCount;
    private String descString;      // UTF-8
    private int picPixelWidth;
    private int picPixelHeight;
    private int picBitsPerPixel;
    private int picColorCount;      // for GIF, else 0
    private int picByteCount;
    
    protected byte[] image;
    
    /**
     * The constructor.
     * @param is                The InputBitStream
     * @param length            Length of the record
     * @param isLast            True if this is the last Metadata block in the chain
     * @throws IOException      Thrown if error reading from InputBitStream
     */
    public Picture(BitInputStream is, int length, boolean isLast) throws IOException {
        super(isLast);
        int usedBits = 0;
        byte[] data;
        
        pictureType = is.readRawUInt(32);
        usedBits += 32;
        
        mimeTypeByteCount = is.readRawUInt(32);
        usedBits += 32;
        
        data = new byte[mimeTypeByteCount];
        is.readByteBlockAlignedNoCRC(data, mimeTypeByteCount);
        usedBits += mimeTypeByteCount*8;
        
        mimeString = new String(data);  // convert to a string
        
        descStringByteCount = is.readRawUInt(32);
        usedBits += 32;
        
        if (descStringByteCount != 0) {
            data = new byte[descStringByteCount];
            is.readByteBlockAlignedNoCRC(data, descStringByteCount);
            try {
                descString = new String(data, "UTF-8");
            } catch (UnsupportedEncodingException e) {}
            usedBits += 32;
        } else {
            descString = new String("");
        }
        
        picPixelWidth = is.readRawUInt(32);
        usedBits += 32;
        
        picPixelHeight = is.readRawUInt(32);
        usedBits += 32;
        
        picBitsPerPixel = is.readRawUInt(32);
        usedBits += 32;
        
        picColorCount = is.readRawUInt(32);
        usedBits += 32;
        
        picByteCount = is.readRawUInt(32);
        usedBits += 32;
        
        //get the image now
        image = new byte[picByteCount];
        is.readByteBlockAlignedNoCRC(image, picByteCount);
        usedBits += picByteCount*8;
        
        // skip the rest of the block if any
        length -= (usedBits / 8);
        is.readByteBlockAlignedNoCRC(null, length);

    }
    /**
     * Convert the class to a string representation.
     * @return  A string representation of the Picture metadata
     */

    @Override
    public String toString() {
        return "Picture: " 
            + " Type=" + pictureType
            + " MIME type=" + mimeString
            + " Description=\"" + descString + "\""
            + " Pixels (WxH)=" + picPixelWidth + "x" + picPixelHeight
            + " Color Depth=" + picBitsPerPixel
            + " Color Count=" + picColorCount
            + " Picture Size (bytes)=" + picByteCount;
    }
 
}
