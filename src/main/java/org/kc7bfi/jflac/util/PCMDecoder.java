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

import java.io.IOException;

import org.kc7bfi.jflac.ChannelData;
import org.kc7bfi.jflac.frame.Frame;
import org.kc7bfi.jflac.metadata.StreamInfo;

/**
 * This class is a PCM FLAC decoder.
 * @author kc7bfi
 */
public class PCMDecoder {
    //private static final int MAX_BLOCK_SIZE = 65535;
    
    private long totalSamples;
    private int channels;
    private int bps;
    private int sampleRate;
    
    private int samplesProcessed = 0;
    private int frameCounter = 0;
   
    private ByteData buf;
    
    
    /**
     * The constructor.
     * @param streamInfo    The FLAC stream info
     */
    public PCMDecoder(StreamInfo streamInfo) {
        this.totalSamples = streamInfo.getTotalSamples();
        this.channels = streamInfo.getChannels();
        this.bps = streamInfo.getBitsPerSample();
        this.sampleRate = streamInfo.getSampleRate();
        this.buf = new ByteData(streamInfo.getMaxFrameSize());
    }
    
    
    /**
     * Write a WAV frame record.
     * @param frame         The FLAC frame
     * @param channelData   The decoded channel data
     * @return returns the decoded buffer data
     * @throws IOException  Thrown if error writing to output channel
     */
    public ByteData getFrame(Frame frame, ChannelData[] channelData) throws IOException {
        boolean isUnsignedSamples = (bps <= 8);
        int wideSamples = frame.header.blockSize;
        int wideSample;
        int sample;
        int channel;
        
        if (wideSamples > 0) {
            samplesProcessed += wideSamples;
            frameCounter++;
            if (bps == 8) {
                if (isUnsignedSamples) {
                    for (sample = wideSample = 0; wideSample < wideSamples; wideSample++)
                        for (channel = 0; channel < channels; channel++) {
                            //System.out.print("("+(int)((byte)(channelData[channel].getOutput()[wideSample] + 0x80))+")");
                            buf.append((byte) (channelData[channel].getOutput()[wideSample] + 0x80));
                        }
                } else {
                    for (sample = wideSample = 0; wideSample < wideSamples; wideSample++)
                        for (channel = 0; channel < channels; channel++)
                            buf.append((byte) (channelData[channel].getOutput()[wideSample]));
                }
            } else if (bps == 16) {
                if (isUnsignedSamples) {
                    for (sample = wideSample = 0; wideSample < wideSamples; wideSample++)
                        for (channel = 0; channel < channels; channel++) {
                            short val = (short) (channelData[channel].getOutput()[wideSample] + 0x8000);
                            buf.append((byte) (val & 0xff));
                            buf.append((byte) ((val >> 8) & 0xff));
                        }
                } else {
                    for (sample = wideSample = 0; wideSample < wideSamples; wideSample++)
                        for (channel = 0; channel < channels; channel++) {
                            short val = (short) (channelData[channel].getOutput()[wideSample]);
                            buf.append((byte) (val & 0xff));
                            buf.append((byte) ((val >> 8) & 0xff));
                        }
                }
            } else if (bps == 24) {
                if (isUnsignedSamples) {
                    for (sample = wideSample = 0; wideSample < wideSamples; wideSample++)
                        for (channel = 0; channel < channels; channel++) {
                            int val = (channelData[channel].getOutput()[wideSample] + 0x800000);
                            buf.append((byte) (val & 0xff));
                            buf.append((byte) ((val >> 8) & 0xff));
                            buf.append((byte) ((val >> 16) & 0xff));
                        }
                } else {
                    for (sample = wideSample = 0; wideSample < wideSamples; wideSample++)
                        for (channel = 0; channel < channels; channel++) {
                            int val = (channelData[channel].getOutput()[wideSample]);
                            buf.append((byte) (val & 0xff));
                            buf.append((byte) ((val >> 8) & 0xff));
                            buf.append((byte) ((val >> 16) & 0xff));
                        }
                }
            }
        }
        
        return buf;
    }
}
