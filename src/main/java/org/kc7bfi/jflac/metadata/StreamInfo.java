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

import javax.sound.sampled.AudioFormat;

import org.kc7bfi.jflac.io.BitInputStream;
import org.kc7bfi.jflac.io.BitOutputStream;

/**
 * StreamInfo Metadata block.
 * @author kc7bfi
 */
public class StreamInfo extends Metadata {

    private static final int STREAMINFO_MIN_BLOCK_SIZE_LEN = 16; // bits
    private static final int STREAMINFO_MAX_BLOCK_SIZE_LEN = 16; // bits
    private static final int STREAMINFO_MIN_FRAME_SIZE_LEN = 24; // bits
    private static final int STREAMINFO_MAX_FRAME_SIZE_LEN = 24; // bits
    private static final int STREAMINFO_SAMPLE_RATE_LEN = 20; // bits
    private static final int STREAMINFO_CHANNELS_LEN = 3; // bits
    private static final int STREAMINFO_BITS_PER_SAMPLE_LEN = 5; // bits
    private static final int STREAMINFO_TOTAL_SAMPLES_LEN = 36; // bits
    private static final int STREAMINFO_MD5SUM_LEN = 128; // bits

    private byte[] md5sum = new byte[16];

    private int minBlockSize;
    private int maxBlockSize;
    private int minFrameSize;
    private int maxFrameSize;
    private int sampleRate;
    private int channels;
    private int bitsPerSample;
    private long totalSamples;
    
    /**
     * The constructor.
     * @param is                The InputBitStream
     * @param length            Length of the record
     * @param isLast            True if this is the last Metadata block in the chain
     * @throws IOException      Thrown if error reading from InputBitStream
     */
    public StreamInfo(BitInputStream is, int length, boolean isLast) throws IOException {
        super(isLast);
        int usedBits = 0;

        minBlockSize = is.readRawUInt(STREAMINFO_MIN_BLOCK_SIZE_LEN);
        usedBits += STREAMINFO_MIN_BLOCK_SIZE_LEN;

        maxBlockSize = is.readRawUInt(STREAMINFO_MAX_BLOCK_SIZE_LEN);
        usedBits += STREAMINFO_MAX_BLOCK_SIZE_LEN;

        minFrameSize = is.readRawUInt(STREAMINFO_MIN_FRAME_SIZE_LEN);
        usedBits += STREAMINFO_MIN_FRAME_SIZE_LEN;

        maxFrameSize = is.readRawUInt(STREAMINFO_MAX_FRAME_SIZE_LEN);
        usedBits += STREAMINFO_MAX_FRAME_SIZE_LEN;

        sampleRate = is.readRawUInt(STREAMINFO_SAMPLE_RATE_LEN);
        usedBits += STREAMINFO_SAMPLE_RATE_LEN;

        channels = is.readRawUInt(STREAMINFO_CHANNELS_LEN) + 1;
        usedBits += STREAMINFO_CHANNELS_LEN;

        bitsPerSample = is.readRawUInt(STREAMINFO_BITS_PER_SAMPLE_LEN) + 1;
        usedBits += STREAMINFO_BITS_PER_SAMPLE_LEN;

        totalSamples = is.readRawULong(STREAMINFO_TOTAL_SAMPLES_LEN);
        usedBits += STREAMINFO_TOTAL_SAMPLES_LEN;

        is.readByteBlockAlignedNoCRC(md5sum, STREAMINFO_MD5SUM_LEN / 8);
        usedBits += 16 * 8;

        // skip the rest of the block
        length -= (usedBits / 8);
        is.readByteBlockAlignedNoCRC(null, length);
    }
    
    /**
     * Write out the metadata block.
     * @param os    The output stream
     * @param isLast    True if this is the last metadata block
     * @throws IOException  Thrown if error writing data
     */
    public void write(BitOutputStream os, boolean isLast) throws IOException {

        os.writeRawUInt(isLast, STREAM_METADATA_IS_LAST_LEN);
        os.writeRawUInt(METADATA_TYPE_STREAMINFO, STREAM_METADATA_TYPE_LEN);
        os.writeRawUInt(calcLength(), STREAM_METADATA_LENGTH_LEN);

        os.writeRawUInt(minBlockSize, STREAMINFO_MIN_BLOCK_SIZE_LEN);
        os.writeRawUInt(maxBlockSize, STREAMINFO_MAX_BLOCK_SIZE_LEN);
        os.writeRawUInt(minFrameSize, STREAMINFO_MIN_FRAME_SIZE_LEN);
        os.writeRawUInt(maxFrameSize, STREAMINFO_MAX_FRAME_SIZE_LEN);
        os.writeRawUInt(sampleRate, STREAMINFO_SAMPLE_RATE_LEN);
        os.writeRawUInt(channels - 1, STREAMINFO_CHANNELS_LEN);
        os.writeRawULong(bitsPerSample - 1, STREAMINFO_BITS_PER_SAMPLE_LEN);
        os.writeRawULong(totalSamples, STREAMINFO_TOTAL_SAMPLES_LEN);
        os.writeByteBlock(md5sum, md5sum.length);
        os.flushByteAligned();
    }
    
    /**
     * Calculate the metadata block size.
     * @return The metadata block size
     */
    public int calcLength() {
        int bits = STREAMINFO_MIN_BLOCK_SIZE_LEN 
                   + STREAMINFO_MAX_BLOCK_SIZE_LEN
                   + STREAMINFO_MIN_FRAME_SIZE_LEN
                   + STREAMINFO_MAX_FRAME_SIZE_LEN
                   + STREAMINFO_SAMPLE_RATE_LEN
                   + STREAMINFO_CHANNELS_LEN
                   + STREAMINFO_BITS_PER_SAMPLE_LEN
                   + STREAMINFO_TOTAL_SAMPLES_LEN
                   + (md5sum.length * 8);
        return ((bits + 7) / 8);
    }
    
    /**
     * Check for compatiable StreamInfo.
     * Checks if sampleRate, channels, and bitsPerSample are equal
     * @param info  The StreamInfo block to check
     * @return  True if this and info are compatable
     */
    public boolean compatiable(StreamInfo info) {
        if (sampleRate != info.sampleRate) return false;
        if (channels != info.channels) return false;
        if (bitsPerSample != info.bitsPerSample) return false;
        return true;
    }
    
    /**
     * Convert to string.
     * @see java.lang.Object#toString()
     */
    public String toString() {
        return "StreamInfo:" 
            + " BlockSize=" + minBlockSize + "-" + maxBlockSize
            + " FrameSize" + minFrameSize + "-" + maxFrameSize
            + " SampleRate=" + sampleRate
            + " Channels=" + channels
            + " BPS=" + bitsPerSample
            + " TotalSamples=" + totalSamples;
    }
    
    /**
     * @return Returns the maxBlockSize.
     */
    public int getMaxBlockSize() {
        return maxBlockSize;
    }
    
    /**
     * @return Returns the minBlockSize.
     */
    public int getMinBlockSize() {
        return minBlockSize;
    }
    
    /**
     * @return Returns the totalSamples.
     */
    public long getTotalSamples() {
        return totalSamples;
    }
    
    /**
     * @param totalSamples The totalSamples to set.
     */
    public void setTotalSamples(long totalSamples) {
        this.totalSamples = totalSamples;
    }
    
    /**
     * @param totalSamples The totalSamples to add.
     */
    public void addTotalSamples(long totalSamples) {
        this.totalSamples += totalSamples;
    }
    
    /**
     * @return Returns the maxFrameSize.
     */
    public int getMaxFrameSize() {
        return maxFrameSize;
    }
    
    /**
     * @return Returns the minFrameSize.
     */
    public int getMinFrameSize() {
        return minFrameSize;
    }
    
    /**
     * @return Returns the sampleRate.
     */
    public int getSampleRate() {
        return sampleRate;
    }
    
    /**
     * @return the Java Sound AudioFormat for this stream info.
     */
    public AudioFormat getAudioFormat() {
        return new AudioFormat(sampleRate, bitsPerSample, channels, (bitsPerSample <= 8) ? false : true, false);
    }
    
    /**
     * @return Returns the bitsPerSample.
     */
    public int getBitsPerSample() {
        return bitsPerSample;
    }
    
    /**
     * @return Returns the channels.
     */
    public int getChannels() {
        return channels;
    }
}
