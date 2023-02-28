package org.kc7bfi.jflac;

/**
 *  libFLAC - Free Lossless Audio Codec library
 * Copyright (C) 2000,2001,2002,2003  Josh Coalson
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

public class Constants {
    
    /** The maximum number of audio channels. */
    public static final int MAX_CHANNELS = 8;
    
    /** The maximum frame block size. */
    public static final int MAX_BLOCK_SIZE = 65535;

    /** The maximum Rice partition order permitted by the format. */
    public static final int MAX_RICE_PARTITION_ORDER = 15;
    
    /** independent channels. */
    public static final int CHANNEL_ASSIGNMENT_INDEPENDENT = 0;
    /** left+side stereo. */
    public static final int CHANNEL_ASSIGNMENT_LEFT_SIDE = 1;
    /** right+side stereo. */
    public static final int CHANNEL_ASSIGNMENT_RIGHT_SIDE = 2;
    /** mid+side stereo. */
    public static final int CHANNEL_ASSIGNMENT_MID_SIDE = 3;

    /** FLAC Stream Sync string. */
    public static final byte[] STREAM_SYNC_STRING = new byte[] { (byte)'f', (byte)'L', (byte)'a', (byte)'C' };


        /*
    boolean format_sample_rate_is_valid(int sample_rate) {
        if (sample_rate == 0
            || sample_rate > MAX_SAMPLE_RATE
            || (sample_rate >= (1 << 16) && !(sample_rate % 1000 == 0 || sample_rate % 10 == 0))) {
            return false;
        } else
            return true;
    }
    */

    /*
     * These routines are private to libFLAC
     */
        /*
    int format_get_max_rice_partition_order(int blocksize, int predictor_order) {
        return format_get_max_rice_partition_order_from_blocksize_limited_max_and_predictor_order(
            format_get_max_rice_partition_order_from_blocksize(blocksize),
            blocksize,
            predictor_order);
    }

    int format_get_max_rice_partition_order_from_blocksize(int blocksize) {
        int max_rice_partition_order = 0;
        while ((blocksize & 1) == 0) {
            max_rice_partition_order++;
            blocksize >>= 1;
        }
        return Math.min(MAX_RICE_PARTITION_ORDER, max_rice_partition_order);
    }

    int format_get_max_rice_partition_order_from_blocksize_limited_max_and_predictor_order(
        int limit,
        int blocksize,
        int predictor_order) {
        int max_rice_partition_order = limit;

        while (max_rice_partition_order > 0 && (blocksize >> max_rice_partition_order) <= predictor_order)
            max_rice_partition_order--;

        return max_rice_partition_order;
    }
    */
}
