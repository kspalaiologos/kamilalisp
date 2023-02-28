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

import org.kc7bfi.jflac.io.BitInputStream;

/**
 * This class holds the Entropy Partitioned Rice contents.
 * @author kc7bfi
 */
public class EntropyPartitionedRice extends EntropyCodingMethod {
    private static final int ENTROPY_CODING_METHOD_PARTITIONED_RICE_PARAMETER_LEN = 4; /* bits */
    private static final int ENTROPY_CODING_METHOD_PARTITIONED_RICE_RAW_LEN = 5; /* bits */
    private static final int ENTROPY_CODING_METHOD_PARTITIONED_RICE_ESCAPE_PARAMETER = 15;

    protected int order; // The partition order, i.e. # of contexts = 2 ^ order.
    protected EntropyPartitionedRiceContents contents; // The context's Rice parameters and/or raw bits.

    /**
     * Read compressed signal residual data.
     * 
     * @param is                The InputBitStream
     * @param predictorOrder    The predicate order
     * @param partitionOrder    The partition order
     * @param header            The FLAC Frame Header
     * @param residual          The residual signal (output)
     * @throws IOException      On error reading from InputBitStream
     */
    void readResidual(BitInputStream is, int predictorOrder, int partitionOrder, Header header, int[] residual) throws IOException {
        //System.out.println("readREsidual Pred="+predictorOrder+" part="+partitionOrder);
        int sample = 0;
        int partitions = 1 << partitionOrder;
        int partitionSamples = partitionOrder > 0 ? header.blockSize >> partitionOrder : header.blockSize - predictorOrder;
        contents.ensureSize(Math.max(6, partitionOrder));
        contents.parameters = new int[partitions];

        for (int partition = 0; partition < partitions; partition++) {
            int riceParameter = is.readRawUInt(ENTROPY_CODING_METHOD_PARTITIONED_RICE_PARAMETER_LEN);
            contents.parameters[partition] = riceParameter;
            if (riceParameter < ENTROPY_CODING_METHOD_PARTITIONED_RICE_ESCAPE_PARAMETER) {
                int u = (partitionOrder == 0 || partition > 0) ? partitionSamples : partitionSamples - predictorOrder;
                is.readRiceSignedBlock(residual, sample, u, riceParameter);
                sample += u;
            } else {
                riceParameter = is.readRawUInt(ENTROPY_CODING_METHOD_PARTITIONED_RICE_RAW_LEN);
                contents.rawBits[partition] = riceParameter;
                for (int u = (partitionOrder == 0 || partition > 0) ? 0 : predictorOrder; u < partitionSamples; u++, sample++) {
                    residual[sample] = is.readRawInt(riceParameter);
                }
            }
        }
    }
}
