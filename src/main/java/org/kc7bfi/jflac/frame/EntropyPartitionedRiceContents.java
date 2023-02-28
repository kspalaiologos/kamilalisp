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

public class EntropyPartitionedRiceContents {

    protected int[] parameters; // The Rice parameters for each context.
    protected int[] rawBits; // Widths for escape-coded partitions.

    /** 
     * The capacity of the parameters and raw_bits arrays specified as an order.
     * i.e. the number of array elements allocated is 2 ^ capacity_by_order.
     */
    protected int capacityByOrder = 0;
    
    /**
     * Ensure enough menory has been allocated.
     * @param maxPartitionOrder The maximum partition order
     */
    public void ensureSize(int maxPartitionOrder) {
        if (capacityByOrder >= maxPartitionOrder) return;
        parameters = new int[(1 << maxPartitionOrder)];
        rawBits = new int[(1 << maxPartitionOrder)]; 
        capacityByOrder = maxPartitionOrder;
    }
}
