package org.kc7bfi.jflac.apps;

/* libFLAC - Free Lossless Audio Codec library
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


import java.io.FileNotFoundException;
import java.io.IOException;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.SourceDataLine;

import org.kc7bfi.jflac.FrameListener;
import org.kc7bfi.jflac.PCMProcessor;
import org.kc7bfi.jflac.FLACDecoder;
import org.kc7bfi.jflac.frame.Frame;
import org.kc7bfi.jflac.io.RandomFileInputStream;
import org.kc7bfi.jflac.metadata.Metadata;
import org.kc7bfi.jflac.metadata.SeekPoint;
import org.kc7bfi.jflac.metadata.SeekTable;
import org.kc7bfi.jflac.metadata.StreamInfo;
import org.kc7bfi.jflac.util.ByteData;


/**
 * Play a FLAC file application.
 * @author kc7bfi
 */
public class SeekTablePlayer implements PCMProcessor, FrameListener {
    private AudioFormat fmt;
    private DataLine.Info info;
    private SourceDataLine line;
    
    private StreamInfo streamInfo = null;
    private SeekTable seekTable = null;
    
    /**
     * Decode and play an input FLAC file.
     * @param inFileName    The input FLAC file name
     * @param fromSeekPoint The starting Seek Point
     * @param toSeekPoint   The ending Seek Point (non-inclusive)
     * @throws IOException  Thrown if error reading file
     * @throws LineUnavailableException Thrown if error playing file
     */
    public void play(String inFileName, int fromSeekPoint, int toSeekPoint) throws IOException, LineUnavailableException {
        System.out.println("Play [" + inFileName + "]");
        RandomFileInputStream is = new RandomFileInputStream(inFileName);
        
        FLACDecoder decoder = new FLACDecoder(is);
        decoder.addPCMProcessor(this);
        decoder.addFrameListener(this);
        decoder.readMetadata();
        
        // see if SeekTbale exists
        if (seekTable == null) {
            System.out.println("Missing SeekTable!");
            return;
        }
        
        SeekPoint from = seekTable.getSeekPoint(fromSeekPoint);
        SeekPoint to = null;
        if (toSeekPoint + 1 < seekTable.numberOfPoints()) to = seekTable.getSeekPoint(toSeekPoint + 1);
        System.out.println("Seek From: " + from);
        System.out.println("Seek To  : " + to);
        decoder.decode(from, to);
        
        line.drain();
        line.close();
    }
    
    /**
     * Process the StreamInfo block.
     * @param streamInfo the StreamInfo block
     * @see org.kc7bfi.jflac.PCMProcessor#processStreamInfo(org.kc7bfi.jflac.metadata.StreamInfo)
     */
    public void processStreamInfo(StreamInfo streamInfo) {
        this.streamInfo = streamInfo;
        try {
            fmt = streamInfo.getAudioFormat();
            info = new DataLine.Info(SourceDataLine.class, fmt, AudioSystem.NOT_SPECIFIED);
            line = (SourceDataLine) AudioSystem.getLine(info);
            line.open(fmt, AudioSystem.NOT_SPECIFIED);
            line.start();
        } catch (LineUnavailableException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Process the decoded PCM bytes.
     * @param pcm The decoded PCM data
     * @see org.kc7bfi.jflac.PCMProcessor#processPCM(org.kc7bfi.jflac.util.ByteSpace)
     */
    public void processPCM(ByteData pcm) {
        line.write(pcm.getData(), 0, pcm.getLen());
    }

    /**
     * Called for each Metadata frame read.
     * @param metadata The metadata frame read
     */
    public void processMetadata(Metadata metadata) {
        if (metadata instanceof SeekTable) seekTable = (SeekTable)metadata;
    }

    /**
     * Called for each data frame read.
     * @param frame The data frame read
     */
    public void processFrame(Frame frame) {
    }

    /**
     * Process a decoder error.
     * @param msg   The error message
     * @see org.kc7bfi.jflac.FrameListener#processError(java.lang.String)
     */
    public void processError(String msg) {
        System.out.println("FLAC Error: " + msg);
   }
    
    /**
     * The main routine.
     * <p>args[0] is the input file name
     * @param args  Command line arguments
     */
    public static void main(String[] args) {
        String flacFile = args[0];
        int fromSeekPoint = Integer.parseInt(args[1]);
        int toSeekPoint = Integer.parseInt(args[2]);
        try {
            SeekTablePlayer player = new SeekTablePlayer();
            player.play(flacFile, fromSeekPoint, toSeekPoint);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (LineUnavailableException e) {
            e.printStackTrace();
        }
        
        System.exit(0);
    }
}
