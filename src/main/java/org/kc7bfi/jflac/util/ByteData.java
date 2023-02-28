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
 * Expandable byte data storage.
 * @author kc7bfi
 */
public class ByteData {
    private static final int DEFAULT_BUFFER_SIZE = 256;
    
    /** The byte array where data is stored. */
    private byte[] data;
    
    /** The number of bytes stored in the array. */
    private int len;
    
    /**
     * The default constructor.
     * @param maxSpace  The maximum space in the internal byte array.
     */
    public ByteData(int maxSpace) {
        if (maxSpace <= 0) maxSpace = DEFAULT_BUFFER_SIZE;
        data = new byte[maxSpace];
        len = 0;
    }
    
    /**
     * Append byte to storage.
     * @param b byte to extend
     */
    public void append(byte b) {
        data[len++] = b;
    }
    
    /**
     * @return Returns the data.
     */
    public byte[] getData() {
        return data;
    }
    
    /**
     * Return a data byte.
     * @param idx   The data byte to return
     * @return Returns the data.
     */
    public byte getData(int idx) {
        return data[idx];
    }
    
    /**
     * @return Returns the len.
     */
    public int getLen() {
        return len;
    }
    
    /**
     * Set the length of this ByteData object without re-allocating the underlying array.
     * It is not possible to set the length larger than the underlying byte array. 
     */
    public void setLen(int len) {
    	if (len > data.length) {
    		len = data.length;
    	}
    	this.len = len;
    }
}
