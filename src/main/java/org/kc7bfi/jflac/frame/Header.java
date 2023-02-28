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

import org.kc7bfi.jflac.Constants;
import org.kc7bfi.jflac.io.BitInputStream;
import org.kc7bfi.jflac.metadata.StreamInfo;
import org.kc7bfi.jflac.util.ByteData;
import org.kc7bfi.jflac.util.CRC8;

/**
 * Frame header class.
 * @author kc7bfi
 */
public class Header {
    
    /** The number of samples per subframe. */
    public int blockSize;
    /** The sample rate in Hz. */
    public int sampleRate;
    /** The number of channels (== number of subframes). */
    public int channels;
    /** The channel assignment for the frame. */
    public int channelAssignment;
    /** The sample resolution. */
    public int bitsPerSample;
    
    /** 
     * The frame number or sample number of first sample in frame.
     * use the number_type value to determine which to use. 
     */
    public int frameNumber = -1;
    
    /**
     * The sample number for the first sample in the frame.
     */
    public long sampleNumber = -1;
    
    /** 
     * CRC-8 (polynomial = x^8 + x^2 + x^1 + x^0, initialized with 0).
     * of the raw frame header bytes, meaning everything before the CRC byte
     * including the sync code.
     */
    protected byte crc;
    
    /**
     * The constructor.
     * @param is                    The InputBitStream
     * @param headerWarmup          The header warm-up bytes
     * @param streamInfo            The FLAC Stream Info
     * @throws IOException          Thrown on error reading InputBitStream
     * @throws BadHeaderException   Thrown if header is bad
     */
    public Header(BitInputStream is, byte[] headerWarmup, StreamInfo streamInfo) throws IOException, BadHeaderException {
        int blocksizeHint = 0;
        int sampleRateHint = 0;
        ByteData rawHeader = new ByteData(16); // MAGIC NUMBER based on the maximum frame header size, including CRC
        boolean isKnownVariableBlockSizeStream = (streamInfo != null && streamInfo.getMinBlockSize() != streamInfo.getMaxBlockSize());
        boolean isKnownFixedBlockSizeStream = (streamInfo != null && streamInfo.getMinBlockSize() == streamInfo.getMaxBlockSize());
        
        // init the raw header with the saved bits from synchronization
        rawHeader.append(headerWarmup[0]);
        rawHeader.append(headerWarmup[1]);
        
        // check to make sure that the reserved bits are 0
        if ((rawHeader.getData(1) & 0x03) != 0) { // MAGIC NUMBER
            throw new BadHeaderException("Bad Magic Number: " + (rawHeader.getData(1) & 0xff));
        }
        
        // Note that along the way as we read the header, we look for a sync
        // code inside.  If we find one it would indicate that our original
        // sync was bad since there cannot be a sync code in a valid header.
        
        // read in the raw header as bytes so we can CRC it, and parse it on the way
        for (int i = 0; i < 2; i++) {
            if (is.peekRawUInt(8) == 0xff) { // MAGIC NUMBER for the first 8 frame sync bits
                throw new BadHeaderException("Found sync byte");
            }
            rawHeader.append((byte) is.readRawUInt(8));
        }
        
        int bsType = (rawHeader.getData(2) >> 4) & 0x0f;
        switch (bsType) {
            case 0 :
                if (!isKnownFixedBlockSizeStream)
                    throw new BadHeaderException("Unknown Block Size (0)");
                blockSize = streamInfo.getMinBlockSize();
                break;
            case 1 :
                blockSize = 192;
                break;
            case 2 :
            case 3 :
            case 4 :
            case 5 :
                blockSize = 576 << (bsType - 2);
                break;
            case 6 :
            case 7 :
                blocksizeHint = bsType;
                break;
            case 8 :
            case 9 :
            case 10 :
            case 11 :
            case 12 :
            case 13 :
            case 14 :
            case 15 :
                blockSize = 256 << (bsType - 8);
                break;
            default :
                break;
        }
        //System.out.println("BSType="+bsType+" BS="+blockSize);
        
        int srType = rawHeader.getData(2) & 0x0f;
        switch (srType) {
            case 0 :
                if (streamInfo == null)
                    throw new BadHeaderException("Bad Sample Rate (0)");
                sampleRate = streamInfo.getSampleRate();
                break;
            case 1 :
            case 2 :
            case 3 :
                throw new BadHeaderException("Bad Sample Rate (" + srType + ")");
            case 4 :
                sampleRate = 8000;
                break;
            case 5 :
                sampleRate = 16000;
                break;
            case 6 :
                sampleRate = 22050;
                break;
            case 7 :
                sampleRate = 24000;
                break;
            case 8 :
                sampleRate = 32000;
                break;
            case 9 :
                sampleRate = 44100;
                break;
            case 10 :
                sampleRate = 48000;
                break;
            case 11 :
                sampleRate = 96000;
                break;
            case 12 :
            case 13 :
            case 14 :
                sampleRateHint = srType;
                break;
            case 15 :
                throw new BadHeaderException("Bad Sample Rate (" + srType + ")");
            default :
        }
        
        int asgnType = (int) ((rawHeader.getData(3) >> 4) & 0x0f);
        //System.out.println("AsgnType="+asgnType+" "+(rawHeader.space[3] >> 4));
        if ((asgnType & 8) != 0) {
            channels = 2;
            switch (asgnType & 7) {
                case 0 :
                    channelAssignment = Constants.CHANNEL_ASSIGNMENT_LEFT_SIDE;
                    break;
                case 1 :
                    channelAssignment = Constants.CHANNEL_ASSIGNMENT_RIGHT_SIDE;
                    break;
                case 2 :
                    channelAssignment = Constants.CHANNEL_ASSIGNMENT_MID_SIDE;
                    break;
                default :
                    throw new BadHeaderException("Bad Channel Assignment (" + asgnType + ")");
            }
        } else {
            channels = (int) asgnType + 1;
            channelAssignment = Constants.CHANNEL_ASSIGNMENT_INDEPENDENT;
        }
        
        int bpsType = (int) (rawHeader.getData(3) & 0x0e) >> 1;
        switch (bpsType) {
            case 0 :
                if (streamInfo != null)
                    bitsPerSample = streamInfo.getBitsPerSample();
                else
                    throw new BadHeaderException("Bad BPS (" + bpsType + ")");
                break;
            case 1 :
                bitsPerSample = 8;
                break;
            case 2 :
                bitsPerSample = 12;
                break;
            case 4 :
                bitsPerSample = 16;
                break;
            case 5 :
                bitsPerSample = 20;
                break;
            case 6 :
                bitsPerSample = 24;
                break;
            case 3 :
            case 7 :
                throw new BadHeaderException("Bad BPS (" + bpsType + ")");
            default :
                break;
        }
        
        if ((rawHeader.getData(3) & 0x01) != 0) { // this should be a zero padding bit
            throw new BadHeaderException("this should be a zero padding bit");
        }
        
        if ((blocksizeHint != 0) && isKnownVariableBlockSizeStream) {
            sampleNumber = is.readUTF8Long(rawHeader);
            if (sampleNumber == 0xffffffffffffffffL) { // i.e. non-UTF8 code...
                throw new BadHeaderException("Bad Sample Number");
            }
        } else {
            int lastFrameNumber = is.readUTF8Int(rawHeader);
            if (lastFrameNumber == 0xffffffff) { // i.e. non-UTF8 code...
                throw new BadHeaderException("Bad Last Frame");
            }
            sampleNumber = (long) streamInfo.getMinBlockSize() * (long) lastFrameNumber;
        }
        
        if (blocksizeHint != 0) {
            int blockSizeCode = is.readRawUInt(8);
            rawHeader.append((byte) blockSizeCode);
            if (blocksizeHint == 7) {
                int blockSizeCode2 = is.readRawUInt(8);
                rawHeader.append((byte) blockSizeCode2);
                blockSizeCode = (blockSizeCode << 8) | blockSizeCode2;
            }
            blockSize = blockSizeCode + 1;
        }
        
        if (sampleRateHint != 0) {
            int sampleRateCode = is.readRawUInt(8);
            rawHeader.append((byte) sampleRateCode);
            if (sampleRateHint != 12) {
                int sampleRateCode2 = is.readRawUInt(8);
                rawHeader.append((byte) sampleRateCode2);
                sampleRateCode = (sampleRateCode << 8) | sampleRateCode2;
            }
            if (sampleRateHint == 12)
                sampleRate = sampleRateCode * 1000;
            else if (sampleRateHint == 13)
                sampleRate = sampleRateCode;
            else
                sampleRate = sampleRateCode * 10;
        }
        
        // read the CRC-8 byte
        byte crc8 = (byte) is.readRawUInt(8);
        
        if (CRC8.calc(rawHeader.getData(), rawHeader.getLen()) != crc8) {
            throw new BadHeaderException("STREAM_DECODER_ERROR_STATUS_BAD_HEADER");
        }
    }
    
    /**
     * Return a descriptive string for this object.
     * @return the string description
     * @see java.lang.Object#toString()
     */
    public String toString() {
        return "FrameHeader:"
            + " BlockSize=" + blockSize
            + " SampleRate=" + sampleRate
            + " Channels=" + channels
            + " ChannelAssignment=" + channelAssignment
            + " BPS=" + bitsPerSample
            + " SampleNumber=" + sampleNumber;
    }
}
