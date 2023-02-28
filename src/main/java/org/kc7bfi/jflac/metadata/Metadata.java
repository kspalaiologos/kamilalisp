package org.kc7bfi.jflac.metadata;

/**
 * libFLAC - Free Lossless Audio Codec library
 * Copyright (C) 2001,2002,2003  Josh Coalson
 * Modified 2007 Bruce MacNaughton (added PICTURE metadata type)
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
 * Root class for all Metadata subclasses.
 * @author kc7bfi
 */
public abstract class Metadata {
    
    /** StreamInfo Metatdata type. */
    public static final int METADATA_TYPE_STREAMINFO = 0;
    
    /** Padding Metatdata type. */
    public static final int METADATA_TYPE_PADDING = 1;
    
    /** Application Metatdata type. */
    public static final int METADATA_TYPE_APPLICATION = 2;
    
    /** SeekTable Metatdata type. */
    public static final int METADATA_TYPE_SEEKTABLE = 3;
    
    /** VorbisComment Metatdata type. */
    public static final int METADATA_TYPE_VORBIS_COMMENT = 4;
    
    /** CueSheet Metatdata type. */
    public static final int METADATA_TYPE_CUESHEET = 5;
    
    /** Picture Metatdata type. */
    public static final int METADATA_TYPE_PICTURE = 6;
    
    /** Metadata IsLast field length. */
    public static final int STREAM_METADATA_IS_LAST_LEN = 1; // bits
    
    /** Metadata type field length. */
    public static final int STREAM_METADATA_TYPE_LEN = 7; // bits
    
    /** Metadata length field length. */
    public static final int STREAM_METADATA_LENGTH_LEN = 24; // bits
    
    protected boolean isLast;
    
    /**
     * Constructir.
     * @param isLast    True if last Metadata block
     */
    public Metadata(boolean isLast) {
        this.isLast = isLast;
    }
    
    /**
     * Test if this is the last metadata block.
     * @return True if last metadata block in chain
     */
    public boolean isLast() {
        return isLast;
    }
}
