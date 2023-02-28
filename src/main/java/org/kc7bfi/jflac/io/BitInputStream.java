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

import java.io.EOFException;
import java.io.IOException;
import java.io.InputStream;

import org.kc7bfi.jflac.util.ByteData;
import org.kc7bfi.jflac.util.CRC16;


/**
 * Bit-wide input stream.
 * @author kc7bfi
 */
public class BitInputStream {
    private static final int BITS_PER_BLURB = 8;
    private static final int BITS_PER_BLURB_LOG2 = 3;
    private static final byte BLURB_TOP_BIT_ONE = ((byte) 0x80);
    //private static final long[] MASK32 = new long[]{0, 0x0000000000000001, 0x0000000000000003, 0x0000000000000007, 0x000000000000000F,
    //        0x000000000000001F, 0x000000000000003F, 0x000000000000007F, 0x00000000000000FF, 0x00000000000001FF, 0x00000000000003FF,
    //        0x00000000000007FF, 0x0000000000000FFF, 0x0000000000001FFF, 0x0000000000003FFF, 0x0000000000007FFF, 0x000000000000FFFF,
    //        0x000000000001FFFF, 0x000000000003FFFF, 0x000000000007FFFF, 0x00000000000FFFFF, 0x00000000001FFFFF, 0x00000000003FFFFF,
    //        0x00000000007FFFFF, 0x0000000000FFFFFF, 0x0000000001FFFFFF, 0x0000000003FFFFFF, 0x0000000007FFFFFF, 0x000000000FFFFFFF,
    //        0x000000001FFFFFFF, 0x000000003FFFFFFF, 0x000000007FFFFFFF, 0x00000000FFFFFFFF, 0x00000001FFFFFFFFL,
    //        0x00000003FFFFFFFFL, 0x00000007FFFFFFFFL, 0x0000000FFFFFFFFFL, 0x0000001FFFFFFFFFL, 0x0000003FFFFFFFFFL,
    //        0x0000007FFFFFFFFFL, 0x000000FFFFFFFFFFL, 0x000001FFFFFFFFFFL, 0x000003FFFFFFFFFFL, 0x000007FFFFFFFFFFL,
    //        0x00000FFFFFFFFFFFL, 0x00001FFFFFFFFFFFL, 0x00003FFFFFFFFFFFL, 0x00007FFFFFFFFFFFL, 0x0000FFFFFFFFFFFFL,
    //        0x0001FFFFFFFFFFFFL, 0x0003FFFFFFFFFFFFL, 0x0007FFFFFFFFFFFFL, 0x000FFFFFFFFFFFFFL, 0x001FFFFFFFFFFFFFL,
    //        0x003FFFFFFFFFFFFFL, 0x007FFFFFFFFFFFFFL, 0x00FFFFFFFFFFFFFFL, 0x01FFFFFFFFFFFFFFL, 0x03FFFFFFFFFFFFFFL,
    //        0x07FFFFFFFFFFFFFFL, 0x0FFFFFFFFFFFFFFFL, 0x1FFFFFFFFFFFFFFFL, 0x3FFFFFFFFFFFFFFFL, 0x7FFFFFFFFFFFFFFFL,
    //        0xFFFFFFFFFFFFFFFFL};
    
    private static final int BUFFER_CHUNK_SIZE = 1024;
    private byte[] buffer = new byte[BUFFER_CHUNK_SIZE];
    private int putByte = 0;
    private int getByte = 0;
    private int getBit = 0;
    private int availBits = 0;
    private int totalBitsRead = 0;
    
    private short readCRC16 = 0;
    
    private InputStream inStream;
    
    /**
     * The constructor.
     * @param is    The InputStream to read bits from
     */
    public BitInputStream(InputStream is) {
        this.inStream = is;
    }
    
    //private void resize(int newCapacity) {
    //    if (buffer.length >= newCapacity) return;
    //    System.out.println("RESIZE FROM " + buffer.length + " TO " + newCapacity);
    //    byte[] newBuffer = new byte[newCapacity];
    //    System.arraycopy(buffer, 0, newBuffer, 0, putByte);
    //    buffer = newBuffer;
    //    //return;
    //}
    
    //private void grow(int minBlurbsToAdd) {
    //    int newCapacity = (buffer.length + minBlurbsToAdd + BUFFER_CHUNK_SIZE - 1) / BUFFER_CHUNK_SIZE;
    //    resize(newCapacity);
    //}
    
    //private void ensureSize(int bitsToAdd) {
    //    int blurbsToAdd = (bitsToAdd + 7) >> 3;
    //    if (buffer.length < (putByte + blurbsToAdd))
    //        grow(blurbsToAdd);
    //}
    
    private int readFromStream() throws IOException {
        // first shift the unconsumed buffer data toward the front as much as possible
        if (getByte > 0 && putByte > getByte) {
            System.arraycopy(buffer, getByte, buffer, 0, putByte - getByte);
        }
        putByte -= getByte;
        getByte = 0;
        
        // set the target for reading, taking into account blurb alignment
        // blurb == byte, so no gyrations necessary:
        int bytes = buffer.length - putByte;
        
        // finally, read in some data
        bytes = inStream.read(buffer, putByte, bytes);
        if (bytes <= 0) throw new EOFException();
        
        // now we have to handle partial blurb cases:
        // blurb == byte, so no gyrations necessary:
        putByte += bytes;
        availBits += bytes << 3;
        return bytes;
    }
    
    /**
     * Reset the bit stream.
     */
    public void reset() {
        getByte = 0;
        getBit = 0;
        putByte = 0;
        availBits = 0;
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
     * Test if the Bit Stream consumed bits is byte aligned.
     * @return  True of bit stream consumed bits is byte aligned
     */
    public boolean isConsumedByteAligned() {
        return ((getBit & 7) == 0);
    }
    
    /**
     * return the number of bits to read to align the byte.
     * @return  The number of bits to align the byte
     */
    public int bitsLeftForByteAlignment() {
        return 8 - (getBit & 7);
    }
    
    /**
     * return the number of bytes left to read.
     * @return  The number of bytes left to read
     */
    public int getInputBytesUnconsumed() {
        return availBits >> 3;
    }   
        
    /**
     * skip over bits in bit stream without updating CRC.
     * @param bits  Number of bits to skip
     * @throws IOException  Thrown if error reading from input stream
     */
    public void skipBitsNoCRC(int bits) throws IOException {
        if (bits == 0) return;
        int bitsToAlign = getBit & 7;
        if (bitsToAlign != 0) {
            int bitsToTake = Math.min(8 - bitsToAlign, bits);
            readRawUInt(bitsToTake);
            bits -= bitsToTake;
        }
        int bytesNeeded = bits / 8;
        if (bytesNeeded > 0) {
            readByteBlockAlignedNoCRC(null, bytesNeeded);
            bits %= 8;
        }
        if (bits > 0) {
            readRawUInt(bits);
        }
    }
    
    /**
     * read a single bit.
     * @return  The bit
     * @throws IOException  Thrown if error reading input stream
     */
    public int readBit() throws IOException {
        while (true) {
            if (availBits > 0) {
                int val = ((buffer[getByte] & (0x80 >> getBit)) != 0) ? 1 : 0;
                getBit++;
                if (getBit == BITS_PER_BLURB) {
                    readCRC16 = CRC16.update(buffer[getByte], readCRC16);
                    getByte++;
                    getBit = 0;
                }
                availBits--;
                totalBitsRead++;
                return val;
            } else {
                readFromStream();
            }
        }
    }
    
    /**
     * read a bit into an integer value.
     * The bits of the input integer are shifted left and the 
     * read bit is placed into bit 0.
     * @param val   The integer to shift and add read bit
     * @return      The updated integer value
     * @throws IOException  Thrown if error reading input stream
     */
    public int readBitToInt(int val) throws IOException {
        while (true) {
            if (availBits > 0) {
                val <<= 1;
                val |= ((buffer[getByte] & (0x80 >> getBit)) != 0) ? 1 : 0;
                getBit++;
                if (getBit == BITS_PER_BLURB) {
                    readCRC16 = CRC16.update(buffer[getByte], readCRC16);
                    getByte++;
                    getBit = 0;
                }
                availBits--;
                totalBitsRead++;
                return val;
            } else {
                readFromStream();
            }
        }
    }
    
    /**
     * peek at the next bit and add it to the input integer.
     * The bits of the input integer are shifted left and the 
     * read bit is placed into bit 0.
     * @param val   The input integer
     * @param bit   The bit to peek at
     * @return      The updated integer value
     * @throws IOException  Thrown if error reading input stream
     */
    public int peekBitToInt(int val, int bit) throws IOException {
        while (true) {
            if (bit < availBits) {
                val <<= 1;
                if ((getBit + bit) >= BITS_PER_BLURB) {
                    bit = (getBit + bit) % BITS_PER_BLURB;
                    val |= ((buffer[getByte + 1] & (0x80 >> bit)) != 0) ? 1 : 0;
                } else {
                    val |= ((buffer[getByte] & (0x80 >> (getBit + bit))) != 0) ? 1 : 0;
                }
                return val;
            } else {
                readFromStream();
            }
        }
    }
    
    /**
     * read a bit into a long value.
     * The bits of the input long are shifted left and the 
     * read bit is placed into bit 0.
     * @param val   The long to shift and add read bit
     * @return      The updated long value
     * @throws IOException  Thrown if error reading input stream
     */
    public long readBitToLong(long val) throws IOException {
        while (true) {
            if (availBits > 0) {
                val <<= 1;
                val |= ((buffer[getByte] & (0x80 >> getBit)) != 0) ? 1 : 0;
                getBit++;
                if (getBit == BITS_PER_BLURB) {
                    readCRC16 = CRC16.update(buffer[getByte], readCRC16);
                    getByte++;
                    getBit = 0;
                }
                availBits--;
                totalBitsRead++;
                return val;
            } else {
                readFromStream();
            }
        }
    }
    
    /**
     * read bits into an unsigned integer.
     * @param bits  The number of bits to read
     * @return      The bits as an unsigned integer
     * @throws IOException  Thrown if error reading input stream
     */
    public int readRawUInt(int bits) throws IOException {
        int val = 0;
        for (int i = 0; i < bits; i++) {
            val = readBitToInt(val);
        }
        return val;
    }
    
    /**
     * peek at bits into an unsigned integer without advancing the input stream.
     * @param bits  The number of bits to read
     * @return      The bits as an unsigned integer
     * @throws IOException  Thrown if error reading input stream
     */
    public int peekRawUInt(int bits) throws IOException {
        int val = 0;
        for (int i = 0; i < bits; i++) {
            val = peekBitToInt(val, i);
        }
        return val;
    }
    
    /**
     * read bits into a signed integer.
     * @param bits  The number of bits to read
     * @return      The bits as a signed integer
     * @throws IOException  Thrown if error reading input stream
     */
    public int readRawInt(int bits) throws IOException { 
        if (bits == 0) { return 0; }
        int uval = 0;
        for (int i = 0; i < bits; i++) {
            uval = readBitToInt(uval);
        }
        
        // fix the sign
        int val;
        int bitsToleft = 32 - bits;
        if (bitsToleft != 0) {
            uval <<= bitsToleft;
            val = uval;
            val >>= bitsToleft;
        } else {
            val = uval;
        }
        return val;
    }
    
    /**
     * read bits into an unsigned long.
     * @param bits  The number of bits to read
     * @return      The bits as an unsigned long
     * @throws IOException  Thrown if error reading input stream
     */
    public long readRawULong(int bits) throws IOException {
        long val = 0;
        for (int i = 0; i < bits; i++) {
            val = readBitToLong(val);
        }
        return val;
    }
    
    /**
     * read bits into an unsigned little endian integer.
     * @return      The bits as an unsigned integer
     * @throws IOException  Thrown if error reading input stream
     */
    public int readRawIntLittleEndian() throws IOException {
        int x32 = readRawUInt(8);
        int x8 = readRawUInt(8);
        x32 |= (x8 << 8);
        x8 = readRawUInt(8);
        x32 |= (x8 << 16);
        x8 = readRawUInt(8);
        x32 |= (x8 << 24);
        return x32;
    }
    
    /**
     * Read a block of bytes (aligned) without updating the CRC value.
     * @param val   The array to receive the bytes. If null, no bytes are returned
     * @param nvals The number of bytes to read
     * @throws IOException  Thrown if error reading input stream
     */
    public void readByteBlockAlignedNoCRC(byte[] val, int nvals) throws IOException {
        int destlength = nvals;
        while (nvals > 0) {
            int chunk = Math.min(nvals, putByte - getByte);
            if (chunk == 0) {
                readFromStream();
            } else {
                if (val != null) System.arraycopy(buffer, getByte, val, destlength - nvals, chunk);
                nvals -= chunk;
                getByte += chunk;
                //totalConsumedBits = (getByte << BITS_PER_BLURB_LOG2);
                availBits -= (chunk << BITS_PER_BLURB_LOG2);
                totalBitsRead += (chunk << BITS_PER_BLURB_LOG2);
            }
        }
    }
    
    /**
     * Read and count the number of zero bits.
     * @return  The number of zero bits read
     * @throws IOException  Thrown if error reading input stream
     */
    public int readUnaryUnsigned() throws IOException {
        int val = 0;
        while (true) {
            int bit = readBit();
            if (bit != 0) break;
            val++;
        }
        return val;
    }
    
    /**
     * Read a Rice Signal Block.
     * @param vals  The values to be returned
     * @param pos   The starting position in the vals array
     * @param nvals The number of values to return
     * @param parameter The Rice parameter
     * @throws IOException  On read error
     */
    public void readRiceSignedBlock(int[] vals, int pos, int nvals, int parameter) throws IOException {
        int j, valI = 0;
        int cbits = 0, uval = 0, msbs = 0, lsbsLeft = 0;
        byte blurb, saveBlurb;
        int state = 0; // 0 = getting unary MSBs, 1 = getting binary LSBs
        if (nvals == 0) return;
        int i = getByte;
        
        long startBits = getByte * 8 + getBit;
        
        // We unroll the main loop to take care of partially consumed blurbs here.
        if (getBit > 0) {
            saveBlurb = blurb = buffer[i];
            cbits = getBit;
            blurb <<= cbits;
            while (true) {
                if (state == 0) {
                    if (blurb != 0) {
                        for (j = 0; (blurb & BLURB_TOP_BIT_ONE) == 0; j++)
                            blurb <<= 1;
                        msbs += j;
                        
                        // dispose of the unary end bit
                        blurb <<= 1;
                        j++;
                        cbits += j;
                        uval = 0;
                        lsbsLeft = parameter;
                        state++;
                        //totalBitsRead += msbs;
                        if (cbits == BITS_PER_BLURB) {
                            cbits = 0;
                            readCRC16 = CRC16.update(saveBlurb, readCRC16);
                            break;
                        }
                    } else {
                        msbs += BITS_PER_BLURB - cbits;
                        cbits = 0;
                        readCRC16 = CRC16.update(saveBlurb, readCRC16);
                        //totalBitsRead += msbs;
                        break;
                    }
                } else {
                    int availableBits = BITS_PER_BLURB - cbits;
                    if (lsbsLeft >= availableBits) {
                        uval <<= availableBits;
                        uval |= ((blurb & 0xff) >> cbits);
                        cbits = 0;
                        readCRC16 = CRC16.update(saveBlurb, readCRC16);
                        //totalBitsRead += availableBits;
                        if (lsbsLeft == availableBits) {
                            // compose the value
                            uval |= (msbs << parameter);
                            if ((uval & 1) != 0)
                                vals[pos + valI++] = -((int) (uval >> 1)) - 1;
                            else
                                vals[pos + valI++] = (int) (uval >> 1);
                            if (valI == nvals)
                                break;
                            msbs = 0;
                            state = 0;
                        }
                        lsbsLeft -= availableBits;
                        break;
                    } else {
                        uval <<= lsbsLeft;
                        uval |= ((blurb & 0xff) >> (BITS_PER_BLURB - lsbsLeft));
                        blurb <<= lsbsLeft;
                        cbits += lsbsLeft;
                        //totalBitsRead += lsbsLeft;
                        // compose the value
                        uval |= (msbs << parameter);
                        if ((uval & 1) != 0)
                            vals[pos + valI++] = -((int) (uval >> 1)) - 1;
                        else
                            vals[pos + valI++] = (int) (uval >> 1);
                        if (valI == nvals) {
                            // back up one if we exited the for loop because we
                            // read all nvals but the end came in the middle of
                            // a blurb
                            i--;
                            break;
                        }
                        msbs = 0;
                        state = 0;
                    }
                }
            }
            i++;
            getByte = i;
            getBit = cbits;
            //totalConsumedBits = (i << BITS_PER_BLURB_LOG2) | cbits;
            //totalBitsRead += (BITS_PER_BLURB) | cbits;
        }
        
        // Now that we are blurb-aligned the logic is slightly simpler
        while (valI < nvals) {
            for (; i < putByte && valI < nvals; i++) {
                saveBlurb = blurb = buffer[i];
                cbits = 0;
                while (true) {
                    if (state == 0) {
                        if (blurb != 0) {
                            for (j = 0; (blurb & BLURB_TOP_BIT_ONE) == 0; j++) blurb <<= 1;
                            msbs += j;
                            // dispose of the unary end bit
                            blurb <<= 1;
                            j++;
                            cbits += j;
                            uval = 0;
                            lsbsLeft = parameter;
                            state++;
                            //totalBitsRead += msbs;
                            if (cbits == BITS_PER_BLURB) {
                                cbits = 0;
                                readCRC16 = CRC16.update(saveBlurb, readCRC16);
                                break;
                            }
                        } else {
                            msbs += BITS_PER_BLURB - cbits;
                            cbits = 0;
                            readCRC16 = CRC16.update(saveBlurb, readCRC16);
                            //totalBitsRead += msbs;
                            break;
                        }
                    } else {
                        int availableBits = BITS_PER_BLURB - cbits;
                        if (lsbsLeft >= availableBits) {
                            uval <<= availableBits;
                            uval |= ((blurb & 0xff) >> cbits);
                            cbits = 0;
                            readCRC16 = CRC16.update(saveBlurb, readCRC16);
                            //totalBitsRead += availableBits;
                            if (lsbsLeft == availableBits) {
                                // compose the value
                                uval |= (msbs << parameter);
                                if ((uval & 1) != 0)
                                    vals[pos + valI++] = -((int) (uval >> 1)) - 1;
                                else
                                    vals[pos + valI++] = (int) (uval >> 1);
                                if (valI == nvals)
                                    break;
                                msbs = 0;
                                state = 0;
                            }
                            lsbsLeft -= availableBits;
                            break;
                        } else {
                            uval <<= lsbsLeft;
                            uval |= ((blurb & 0xff) >> (BITS_PER_BLURB - lsbsLeft));
                            blurb <<= lsbsLeft;
                            cbits += lsbsLeft;
                            //totalBitsRead += lsbsLeft;
                            // compose the value
                            uval |= (msbs << parameter);
                            if ((uval & 1) != 0)
                                vals[pos + valI++] = -((int) (uval >> 1)) - 1;
                            else
                                vals[pos + valI++] = (int) (uval >> 1);
                            if (valI == nvals) {
                                // back up one if we exited the for loop because
                                // we read all nvals but the end came in the
                                // middle of a blurb
                                i--;
                                break;
                            }
                            msbs = 0;
                            state = 0;
                        }
                    }
                }
            }
            getByte = i;
            getBit = cbits;
            //totalConsumedBits = (i << BITS_PER_BLURB_LOG2) | cbits;
            //totalBitsRead += (BITS_PER_BLURB) | cbits;
            if (valI < nvals) {
                long endBits = getByte * 8 + getBit;
                //System.out.println("SE0 "+startBits+" "+endBits);
                totalBitsRead += endBits - startBits;
                availBits -=  endBits - startBits;
                readFromStream();
                // these must be zero because we can only get here if we got to
                // the end of the buffer
                i = 0;
                startBits = getByte * 8 + getBit;
            }
        }
        
        long endBits = getByte * 8 + getBit;
        //System.out.println("SE1 "+startBits+" "+endBits);
        totalBitsRead += endBits - startBits;
        availBits -= endBits - startBits;
    }
    
    /**
     * read UTF8 integer.
     * on return, if *val == 0xffffffff then the utf-8 sequence was invalid, but
     * the return value will be true
     * @param raw   The raw bytes read (output). If null, no bytes are returned
     * @return      The integer read
     * @throws IOException  Thrown if error reading input stream
     */
    public int readUTF8Int(ByteData raw) throws IOException {
        int val;
        int v = 0;
        int x;
        int i;
        x = readRawUInt(8);
        if (raw != null) raw.append((byte) x);
        if ((x & 0x80) == 0) { // 0xxxxxxx
            v = x;
            i = 0;
        } else if (((x & 0xC0) != 0) && ((x & 0x20) == 0)) { // 110xxxxx
            v = x & 0x1F;
            i = 1;
        } else if (((x & 0xE0) != 0) && ((x & 0x10) == 0)) { // 1110xxxx
            v = x & 0x0F;
            i = 2;
        } else if (((x & 0xF0) != 0) && ((x & 0x08) == 0)) { // 11110xxx
            v = x & 0x07;
            i = 3;
        } else if (((x & 0xF8) != 0) && ((x & 0x04) == 0)) { // 111110xx
            v = x & 0x03;
            i = 4;
        } else if (((x & 0xFC) != 0) && ((x & 0x02) == 0)) { // 1111110x
            v = x & 0x01;
            i = 5;
        } else {
            val = 0xffffffff;
            return val;
        }
        for (; i > 0; i--) {
            x = peekRawUInt(8);
            if (((x & 0x80) == 0) || ((x & 0x40) != 0)) { // 10xxxxxx
                val = 0xffffffff;
                return val;
            }
            x = readRawUInt(8);
            if (raw != null)
                raw.append((byte) x);
            v <<= 6;
            v |= (x & 0x3F);
        }
        val = v;
        return val;
    }
    
    /**
     * read UTF long.
     * on return, if *val == 0xffffffffffffffff then the utf-8 sequence was
     * invalid, but the return value will be true
     * @param raw   The raw bytes read (output). If null, no bytes are returned
     * @return      The long read
     * @throws IOException  Thrown if error reading input stream
     */
    public long readUTF8Long(ByteData raw) throws IOException {
        long v = 0;
        int x;
        int i;
        long val;
        x = readRawUInt(8);
        if (raw != null)
            raw.append((byte) x);
        if (((x & 0x80) == 0)) { // 0xxxxxxx
            v = x;
            i = 0;
        } else if (((x & 0xC0) != 0) && ((x & 0x20) == 0)) { // 110xxxxx
            v = x & 0x1F;
            i = 1;
        } else if (((x & 0xE0) != 0) && ((x & 0x10) == 0)) { // 1110xxxx
            v = x & 0x0F;
            i = 2;
        } else if (((x & 0xF0) != 0) && ((x & 0x08) == 0)) { // 11110xxx
            v = x & 0x07;
            i = 3;
        } else if (((x & 0xF8) != 0) && ((x & 0x04) == 0)) { // 111110xx
            v = x & 0x03;
            i = 4;
        } else if (((x & 0xFC) != 0) && ((x & 0x02) == 0)) { // 1111110x
            v = x & 0x01;
            i = 5;
        } else if (((x & 0xFE) != 0) && ((x & 0x01) == 0)) { // 11111110
            v = 0;
            i = 6;
        } else {
            val = 0xffffffffffffffffL;
            return val;
        }
        for (; i > 0; i--) {
            x = peekRawUInt(8);
            if (((x & 0x80) == 0) || ((x & 0x40) != 0)) { // 10xxxxxx
                val = 0xffffffffffffffffL;
                return val;
            }
            x = readRawUInt(8);
            if (raw != null)
                raw.append((byte) x);
            v <<= 6;
            v |= (x & 0x3F);
        }
        val = v;
        return val;
    }
    
    /**
     * Total Blurbs read.
     * @return Returns the total blurbs read.
     */
    public int getTotalBytesRead() {
        return ((totalBitsRead + 7) / 8);
    }
}
