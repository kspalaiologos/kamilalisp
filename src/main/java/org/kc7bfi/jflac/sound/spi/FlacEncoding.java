package org.kc7bfi.jflac.sound.spi;

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

import javax.sound.sampled.AudioFormat;

/**
 * Encodings used by the Flac audio decoder.
 * 
 * @author Marc Gimpel, Wimba S.A. (marc@wimba.com)
 * @version $Revision: 1.2 $
 */
public class FlacEncoding extends AudioFormat.Encoding {

    /** Specifies any Flac encoded data. */
    public static final FlacEncoding FLAC = new FlacEncoding("FLAC");

    /**
     * Constructs a new encoding.
     * 
     * @param name -
     *            Name of the Flac encoding.
     */
    public FlacEncoding(String name) {
        super(name);
    }
}
