package org.kc7bfi.jflac.io;

/**
 * libFLAC - Free Lossless Audio Codec library Copyright (C) 2000,2001,2002,2003
 * Josh Coalson
 * 
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Library General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option) any
 * later version.
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Library General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU Library General Public License
 * along with this library; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

import java.io.IOException;
import java.io.OutputStream;

import org.kc7bfi.jflac.util.CRC16;
import org.kc7bfi.jflac.util.CRC8;


/**
 * Bit-wide output stream.
 * @author kc7bfi
 */
public class BitOutputStream {
    private static final int BITS_PER_BLURB = 8;
    //private static final int BITS_PER_BLURB_LOG2 = 3;
    //private static final int BYTES_PER_BLURB = 1;
    //private static final byte BLURB_TOP_BIT_ONE = ((byte) 0x80);
    private static final long[] MASK32 = new long[]{0, 0x0000000000000001, 0x0000000000000003, 0x0000000000000007, 0x000000000000000F,
            0x000000000000001F, 0x000000000000003F, 0x000000000000007F, 0x00000000000000FF, 0x00000000000001FF, 0x00000000000003FF,
            0x00000000000007FF, 0x0000000000000FFF, 0x0000000000001FFF, 0x0000000000003FFF, 0x0000000000007FFF, 0x000000000000FFFF,
            0x000000000001FFFF, 0x000000000003FFFF, 0x000000000007FFFF, 0x00000000000FFFFF, 0x00000000001FFFFF, 0x00000000003FFFFF,
            0x00000000007FFFFF, 0x0000000000FFFFFF, 0x0000000001FFFFFF, 0x0000000003FFFFFF, 0x0000000007FFFFFF, 0x000000000FFFFFFF,
            0x000000001FFFFFFF, 0x000000003FFFFFFF, 0x000000007FFFFFFF, 0x00000000FFFFFFFF, 0x00000001FFFFFFFFL,
            0x00000003FFFFFFFFL, 0x00000007FFFFFFFFL, 0x0000000FFFFFFFFFL, 0x0000001FFFFFFFFFL, 0x0000003FFFFFFFFFL,
            0x0000007FFFFFFFFFL, 0x000000FFFFFFFFFFL, 0x000001FFFFFFFFFFL, 0x000003FFFFFFFFFFL, 0x000007FFFFFFFFFFL,
            0x00000FFFFFFFFFFFL, 0x00001FFFFFFFFFFFL, 0x00003FFFFFFFFFFFL, 0x00007FFFFFFFFFFFL, 0x0000FFFFFFFFFFFFL,
            0x0001FFFFFFFFFFFFL, 0x0003FFFFFFFFFFFFL, 0x0007FFFFFFFFFFFFL, 0x000FFFFFFFFFFFFFL, 0x001FFFFFFFFFFFFFL,
            0x003FFFFFFFFFFFFFL, 0x007FFFFFFFFFFFFFL, 0x00FFFFFFFFFFFFFFL, 0x01FFFFFFFFFFFFFFL, 0x03FFFFFFFFFFFFFFL,
            0x07FFFFFFFFFFFFFFL, 0x0FFFFFFFFFFFFFFFL, 0x1FFFFFFFFFFFFFFFL, 0x3FFFFFFFFFFFFFFFL, 0x7FFFFFFFFFFFFFFFL,
            0xFFFFFFFFFFFFFFFFL};
    
    private byte[] buffer = new byte[0];
    private int outCapacity = 0; // in blurbs
    private int outBlurbs = 0;
    private int outBits = 0;
    private int totalBits = 0; // must always == BITS_PER_BLURB*blurbs+bits
    private int consumedBlurbs = 0;
    private int consumedBits = 0;
    private int totalConsumedBits = 0;
    private short readCRC16 = 0;
    private OutputStream os;
    
    /*
     * WATCHOUT: The current implentation is not friendly to shrinking, i.e. it
     * does not shift left what is consumed, it just chops off the end, whether
     * there is unconsumed data there or not. This is OK because currently we
     * never shrink the buffer, but if this ever changes, we'll have to do some
     * fixups here.
     */
    private boolean resize(int newCapacity) {
        if (outCapacity >= newCapacity) return true;
        byte[] newBuffer = new byte[newCapacity];
        System.arraycopy(buffer, 0, newBuffer, 0, Math.min(outBlurbs + ((outBits != 0) ? 1 : 0), newCapacity));
        if (newCapacity < outBlurbs + ((outBits != 0) ? 1 : 0)) {
            outBlurbs = newCapacity;
            outBits = 0;
            totalBits = newCapacity << 3;
        }
        if (newCapacity < consumedBlurbs + ((consumedBits != 0) ? 1 : 0)) {
            consumedBlurbs = newCapacity;
            consumedBits = 0;
            totalConsumedBits = newCapacity << 3;
        }
        buffer = newBuffer;
        outCapacity = newCapacity;
        return true;
    }
    
    private boolean grow(int minBlurbsToAdd) {
        int newCapacity = Math.max(outCapacity * 2, outCapacity + minBlurbsToAdd);
        return resize(newCapacity);
    }
    
    private boolean ensureSize(int bitsToAdd) {
        if ((outCapacity << 3) < totalBits + bitsToAdd) {
            return grow((bitsToAdd >> 3) + 2);
        }
        return true;
    }
    
    /*
    private int readFromStream() throws IOException {
        // first shift the unconsumed buffer data toward the front as much as possible
        if (totalConsumedBits >= BITS_PER_BLURB) {
            int l = 0;
            int r = consumedBlurbs;
            int r_end = inBlurbs + ((inBits != 0) ? 1 : 0);
            for (; r < r_end; l++, r++)
                buffer[l] = buffer[r];
            for (; l < r_end; l++)
                buffer[l] = 0;
            inBlurbs -= consumedBlurbs;
            totalBits -= consumedBlurbs << 3;
            consumedBlurbs = 0;
            totalConsumedBits = consumedBits;
        }
        
        // grow if we need to
        if (capacity <= 1) resize(16);
        
        // set the target for reading, taking into account blurb alignment
        // blurb == byte, so no gyrations necessary:
        int bytes = capacity - inBlurbs;
        
        // finally, read in some data
        bytes = is.read(buffer, inBlurbs, bytes);
        if (bytes <= 0) throw new EOFException();
        
        // now we have to handle partial blurb cases:
        // blurb == byte, so no gyrations necessary:
        inBlurbs += bytes;
        totalBits += bytes << 3;
        return bytes;
    }
    */
    
    /**
     * The constructor.
     * @param os    The InputStream to read bits from
     */
    public BitOutputStream(OutputStream os) {
        this.os = os;
    }
    
    /**
     * The constructor.
     */
    public BitOutputStream() {
    }
    
    /** TODO
     */
    //public void clear() {
    //    
    //}
    
    /**
     * Concatinate one InputBitStream to the end of this one.
     * @param src   The inputBitStream to copy
     * @return      True if copy was successful
     */
    public boolean concatenateAligned(BitOutputStream src) {
        int bitsToAdd = src.totalBits - src.totalConsumedBits;
        if (bitsToAdd == 0) return true;
        if (outBits != src.consumedBits) return false;
        if (!ensureSize(bitsToAdd)) return false;
        if (outBits == 0) {
            System.arraycopy(src.buffer, src.consumedBlurbs, buffer, outBlurbs, 
                    (src.outBlurbs - src.consumedBlurbs + ((src.outBits != 0) ? 1 : 0)));
        } else if (outBits + bitsToAdd > BITS_PER_BLURB) {
            buffer[outBlurbs] <<= (BITS_PER_BLURB - outBits);
            buffer[outBlurbs] |= (src.buffer[src.consumedBlurbs] & ((1 << (BITS_PER_BLURB - outBits)) - 1));
            System.arraycopy(src.buffer, src.consumedBlurbs + 1, buffer, outBlurbs + 11,
                    (src.outBlurbs - src.consumedBlurbs - 1 + ((src.outBits != 0) ? 1 : 0)));
        } else {
            buffer[outBlurbs] <<= bitsToAdd;
            buffer[outBlurbs] |= (src.buffer[src.consumedBlurbs] & ((1 << bitsToAdd) - 1));
        }
        outBits = src.outBits;
        totalBits += bitsToAdd;
        outBlurbs = totalBits / BITS_PER_BLURB;
        return true;
    }
    
    /**
     * Reset the read CRC-16 value.
     * @param seed  The initial CRC-16 value
     */
    public void resetReadCRC16(short seed) {
        readCRC16 = seed;
    }
    
    /**
     * return the read CRC-16 value.
     * @return  The read CRC-16 value
     */
    public short getReadCRC16() {
        return readCRC16;
    }
    
    /**
     * return the write CRC-16 value.
     * @return The write CRC-16 value
     */
    public short getWriteCRC16() {
        return CRC16.calc(buffer, outBlurbs);
    }
    
    /**
     * return the write CRC-8 value.
     * @return  The write CRC-8 value
     */
    public byte getWriteCRC8() {
        return CRC8.calc(buffer, outBlurbs);
    }
    
    /**
     * Test if the Bit Stream is byte aligned.
     * @return  True of bit stream is byte aligned
     */
    public boolean isByteAligned() {
        return ((outBits & 7) == 0);
    }
    
    /**
     * Test if the Bit Stream consumed bits is byte aligned.
     * @return  True of bit stream consumed bits is byte aligned
     */
    public boolean isConsumedByteAligned() {
        return ((consumedBits & 7) == 0);
    }
    
    /**
     * return the number of bits to read to align the byte.
     * @return  The number of bits to align the byte
     */
    public int bitsLeftForByteAlignment() {
        return 8 - (consumedBits & 7);
    }
    
    /**
     * return the number of bytes left to read.
     * @return  The number of bytes left to read
     */
    public int getInputBytesUnconsumed() {
        return (totalBits - totalConsumedBits) >> 3;
    }
    
    /**
     * Write zero bits.
     * @param bits  The number of zero bits to write
     * @throws IOException  On write error
     */
    public void writeZeroes(int bits) throws IOException {
        if (bits == 0) return;
        if (!ensureSize(bits)) throw new IOException("Memory Allocation Error");
        totalBits += bits;
        while (bits > 0) {
            int n = Math.min(BITS_PER_BLURB - outBits, bits);
            buffer[outBlurbs] <<= n;
            bits -= n;
            outBits += n;
            if (outBits == BITS_PER_BLURB) {
                outBlurbs++;
                outBits = 0;
            }
        }
    }

    /**
     * Write a true/false integer.
     * @param val   The true/false value
     * @param bits  The bit size to write
     * @throws IOException  On write error
     */
    public void writeRawUInt(boolean val, int bits) throws IOException {
        writeRawUInt((val) ? 1 : 0, bits);
    }
    
    public void writeRawUInt(int val, int bits) throws IOException {
        if (bits == 0) return;
        
        // inline the size check so we don't incure a function call unnecessarily
        if ((outCapacity << 3) < totalBits + bits) {
            if (!ensureSize(bits)) throw new IOException("Memory allocation error");
        }
        
        // zero-out unused bits; WATCHOUT: other code relies on this, so this needs to stay
        if (bits < 32) val &= (~(0xffffffff << bits)); // zero-out unused bits
        totalBits += bits;
        while (bits > 0) {
            int n = BITS_PER_BLURB - outBits;
            if (n == BITS_PER_BLURB) { // i.e. outBits == 0
                if (bits < BITS_PER_BLURB) {
                    buffer[outBlurbs] = (byte) val;
                    outBits = bits;
                    break;
                } else if (bits == BITS_PER_BLURB) {
                    buffer[outBlurbs++] = (byte) val;
                    break;
                } else {
                    int k = bits - BITS_PER_BLURB;
                    buffer[outBlurbs++] = (byte) (val >> k);
                    
                    // we know k < 32 so no need to protect against the gcc bug mentioned above
                    val &= (~(0xffffffff << k));
                    bits -= BITS_PER_BLURB;
                }
            } else if (bits <= n) {
                buffer[outBlurbs] <<= bits;
                buffer[outBlurbs] |= val;
                if (bits == n) {
                    outBlurbs++;
                    outBits = 0;
                } else
                    outBits += bits;
                break;
            } else {
                int k = bits - n;
                buffer[outBlurbs] <<= n;
                buffer[outBlurbs] |= (val >> k);
                
                // we know n > 0 so k < 32 so no need to protect against the gcc bug mentioned above
                val &= (~(0xffffffff << k));
                bits -= n;
                outBlurbs++;
                outBits = 0;
            }
        }
    }
    
    public void writeRawInt(int val, int bits) throws IOException {
        writeRawUInt((int) val, bits);
    }
    
    public void writeRawULong(long val, int bits) throws IOException {
        if (bits == 0) return;
        if (!ensureSize(bits)) throw new IOException("Memory Allocate Error");
        val &= MASK32[bits];
        totalBits += bits;
        while (bits > 0) {
            if (outBits == 0) {
                if (bits < BITS_PER_BLURB) {
                    buffer[outBlurbs] = (byte) val;
                    outBits = bits;
                    break;
                } else if (bits == BITS_PER_BLURB) {
                    buffer[outBlurbs++] = (byte) val;
                    break;
                } else {
                    int k = bits - BITS_PER_BLURB;
                    buffer[outBlurbs++] = (byte) (val >> k);
                    
                    // we know k < 64 so no need to protect against the gcc bug mentioned above
                    val &= (~(0xffffffffffffffffL << k));
                    bits -= BITS_PER_BLURB;
                }
            } else {
                int n = Math.min(BITS_PER_BLURB - outBits, bits);
                int k = bits - n;
                buffer[outBlurbs] <<= n;
                buffer[outBlurbs] |= (val >> k);
                
                // we know n > 0 so k < 64 so no need to protect against the gcc bug mentioned above
                val &= (~(0xffffffffffffffffL << k));
                bits -= n;
                outBits += n;
                if (outBits == BITS_PER_BLURB) {
                    outBlurbs++;
                    outBits = 0;
                }
            }
        }
    }
    
    public void writeRawUIntLittleEndian(int val) throws IOException {
        // NOTE: we rely on the fact that write_raw_uint32() masks out the unused bits
        writeRawUInt(val, 8);
        writeRawUInt(val >> 8, 8);
        writeRawUInt(val >> 16, 8);
        writeRawUInt(val >> 24, 8);
    }
    
    public void writeByteBlock(byte[] vals, int nvals) throws IOException {
        // this could be faster but currently we don't need it to be
        for (int i = 0; i < nvals; i++) {
            writeRawUInt((int) (vals[i]), 8);
        }
    }
    
    public void writeUnaryUnsigned(int val) throws IOException {
        if (val < 32)
            writeRawUInt(1, ++val);
        else if (val < 64)
            writeRawULong(1, ++val);
        else {
            writeZeroes(val);
            writeRawUInt(1, 1);
        }
    }
    
    public int riceBits(int val, int parameter) {
        int msbs, uval;
        // fold signed to unsigned
        if (val < 0) {
            // equivalent to (unsigned)(((--val) < < 1) - 1); but without the overflow problem at MININT
            uval = (int) (((-(++val)) << 1) + 1);
        } else {
            uval = (int) (val << 1);
        }
        msbs = uval >> parameter;
        return 1 + parameter + msbs;
    }
    /*
     * DRR FIX # ifdef SYMMETRIC_RICE boolean
     * write_symmetric_rice_signed(BitBuffer8 * bb, int val, unsigned parameter) {
     * unsigned total_bits, interesting_bits, msbs; uint32 pattern;
     * 
     * ASSERT(0 != bb); ASSERT(0 != buffer); ASSERT(parameter <= 31); // init
     * pattern with the unary end bit and the sign bit if (val < 0) { pattern =
     * 3; val = -val; } else pattern = 2;
     * 
     * msbs = val >> parameter; interesting_bits = 2 + parameter; total_bits =
     * interesting_bits + msbs; pattern < <= parameter; pattern |= (val & ((1 < <
     * parameter) - 1)); // the binary LSBs
     * 
     * if (total_bits <= 32) { if (!write_raw_uint32(bb, pattern, total_bits))
     * return false; } else { // write the unary MSBs if (!write_zeroes(bb,
     * msbs)) return false; // write the unary end bit, the sign bit, and binary
     * LSBs if (!write_raw_uint32(bb, pattern, interesting_bits)) return false; }
     * return true; }
     * 
     * boolean write_symmetric_rice_signed_escape(BitBuffer8 * bb, int val,
     * unsigned parameter) { unsigned total_bits, val_bits; uint32 pattern;
     * 
     * ASSERT(0 != bb); ASSERT(0 != buffer); ASSERT(parameter <= 31);
     * 
     * val_bits = bitmath_silog2(val); total_bits = 2 + parameter + 5 +
     * val_bits;
     * 
     * if (total_bits <= 32) { pattern = 3; pattern < <= (parameter + 5);
     * pattern |= val_bits; pattern < <= val_bits; pattern |= (val & ((1 < <
     * val_bits) - 1)); if (!write_raw_uint32(bb, pattern, total_bits)) return
     * false; } else { // write the '-0' escape code first if
     * (!write_raw_uint32(bb, 3 u < < parameter, 2 + parameter)) return false; //
     * write the length if (!write_raw_uint32(bb, val_bits, 5)) return false; //
     * write the value if (!write_raw_int32(bb, val, val_bits)) return false; }
     * return true; } # endif // ifdef SYMMETRIC_RICE
     */
    
    public void writeRiceSigned(int val, int parameter) throws IOException {
        int totalBits;
        int interestingBits;
        int msbs;
        int uval;
        int pattern;
        
        // fold signed to unsigned
        if (val < 0) {
            // equivalent to (unsigned)(((--val) < < 1) - 1); but without the overflow problem at MININT
            uval = (int) (((-(++val)) << 1) + 1);
        } else {
            uval = (int) (val << 1);
        }
        msbs = uval >> parameter;
        interestingBits = 1 + parameter;
        totalBits = interestingBits + msbs;
        pattern = 1 << parameter; /* the unary end bit */
        pattern |= (uval & ((1 << parameter) - 1)); /* the binary LSBs */
        if (totalBits <= 32) {
            writeRawUInt(pattern, totalBits);
        } else {
            /* write the unary MSBs */
            writeZeroes(msbs);
            /* write the unary end bit and binary LSBs */
            writeRawUInt(pattern, interestingBits);
        }
    }
    
    public void writeUTF8UInt(int val) throws IOException {
        if (val < 0x80) {
            writeRawUInt(val, 8);
        } else if (val < 0x800) {
            writeRawUInt(0xC0 | (val >> 6), 8);
            writeRawUInt(0x80 | (val & 0x3F), 8);
        } else if (val < 0x10000) {
            writeRawUInt(0xE0 | (val >> 12), 8);
            writeRawUInt(0x80 | ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (val & 0x3F), 8);
        } else if (val < 0x200000) {
            writeRawUInt(0xF0 | (val >> 18), 8);
            writeRawUInt(0x80 | ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (val & 0x3F), 8);
        } else if (val < 0x4000000) {
            writeRawUInt(0xF8 | (val >> 24), 8);
            writeRawUInt(0x80 | ((val >> 18) & 0x3F), 8);
            writeRawUInt(0x80 | ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (val & 0x3F), 8);
        } else {
            writeRawUInt(0xFC | (val >> 30), 8);
            writeRawUInt(0x80 | ((val >> 24) & 0x3F), 8);
            writeRawUInt(0x80 | ((val >> 18) & 0x3F), 8);
            writeRawUInt(0x80 | ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (val & 0x3F), 8);
        }
    }
    
    public void writeUTF8ULong(long val) throws IOException {
        if (val < 0x80) {
            writeRawUInt((int) val, 8);
        } else if (val < 0x800) {
            writeRawUInt(0xC0 | (int) (val >> 6), 8);
            writeRawUInt(0x80 | (int) (val & 0x3F), 8);
        } else if (val < 0x10000) {
            writeRawUInt(0xE0 | (int) (val >> 12), 8);
            writeRawUInt(0x80 | (int) ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (int) (val & 0x3F), 8);
        } else if (val < 0x200000) {
            writeRawUInt(0xF0 | (int) (val >> 18), 8);
            writeRawUInt(0x80 | (int) ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (int) (val & 0x3F), 8);
        } else if (val < 0x4000000) {
            writeRawUInt(0xF8 | (int) (val >> 24), 8);
            writeRawUInt(0x80 | (int) ((val >> 18) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (int) (val & 0x3F), 8);
        } else if (val < 0x80000000) {
            writeRawUInt(0xFC | (int) (val >> 30), 8);
            writeRawUInt(0x80 | (int) ((val >> 24) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 18) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (int) (val & 0x3F), 8);
        } else {
            writeRawUInt(0xFE, 8);
            writeRawUInt(0x80 | (int) ((val >> 30) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 24) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 18) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 12) & 0x3F), 8);
            writeRawUInt(0x80 | (int) ((val >> 6) & 0x3F), 8);
            writeRawUInt(0x80 | (int) (val & 0x3F), 8);
        }
    }
    
    /**
     * Write zero bits to byte boundry.
     * @throws IOException  On error writing to bit stream
     */
    public void zeroPadToByteBoundary() throws IOException {
        // 0-pad to byte boundary
        if ((outBits & 7) != 0) writeZeroes(8 - (outBits & 7));
    }
    
    /**
     * Flush bit stream after aligning byte boundry.
     * @throws IOException  On error writing.
     */
    public void flushByteAligned() throws IOException {
        zeroPadToByteBoundary();
        if (outBlurbs == 0) return;
        os.write(buffer, 0, outBlurbs);
        outBlurbs = 0;
    }
    
    /*
     * DRR FIX boolean peek_bit(unsigned * val, boolean(* read_callback) (byte
     * buffer[], unsigned * bytes, void * client_data), void * client_data) {
     * 
     * while (1) { if (total_consumed_bits < total_bits) { val =
     * (buffer[consumed_blurbs] & BLURB_BIT_TO_MASK(consumed_bits)) ? 1 : 0;
     * return true; } else { if (!read_from_client_(bb, read_callback,
     * client_data)) return false; } } }
     */
     
    /*
     * # ifdef SYMMETRIC_RICE boolean read_symmetric_rice_signed( BitBuffer8 *
     * bb, int * val, unsigned parameter, boolean(* read_callback) (byte
     * buffer[], unsigned * bytes, void * client_data), void * client_data) {
     * uint32 sign = 0, lsbs = 0, msbs = 0;
     * 
     * ASSERT(0 != bb); ASSERT(0 != buffer); ASSERT(parameter <= 31); // read
     * the unary MSBs and end bit if (!read_unary_unsigned(bb, & msbs,
     * read_callback, client_data)) return false; // read the sign bit if
     * (!read_bit_to_uint32(bb, & sign, read_callback, client_data)) return
     * false; // read the binary LSBs if (!read_raw_uint32(bb, & lsbs,
     * parameter, read_callback, client_data)) return false; // compose the
     * value val = (msbs < < parameter) | lsbs; if (sign) val = - (* val);
     * 
     * return true; } # endif // ifdef SYMMETRIC_RICE
     * 
     * boolean read_rice_signed( BitBuffer8 * bb, int * val, unsigned parameter,
     * boolean(* read_callback) (byte buffer[], unsigned * bytes, void *
     * client_data), void * client_data) { uint32 lsbs = 0, msbs = 0; unsigned
     * uval;
     * 
     * ASSERT(0 != bb); ASSERT(0 != buffer); ASSERT(parameter <= 31); // read
     * the unary MSBs and end bit if (!read_unary_unsigned(bb, & msbs,
     * read_callback, client_data)) return false; // read the binary LSBs if
     * (!read_raw_uint32(bb, & lsbs, parameter, read_callback, client_data))
     * return false; // compose the value uval = (msbs < < parameter) | lsbs; if
     * (uval & 1) val = - ((int) (uval >> 1)) - 1; else val = (int) (uval >> 1);
     * 
     * return true; }
     */
    
    /**
     * Returns the totalBits.
     * @return Returns the totalBits.
     */
    public int getTotalBits() {
        return totalBits;
    }
    
    /**
     * Returns the totalBlurbs.
     * @return Returns the totalBlurbs.
     */
    public int getTotalBlurbs() {
        return (totalBits + 7) / 8;
    }
}
