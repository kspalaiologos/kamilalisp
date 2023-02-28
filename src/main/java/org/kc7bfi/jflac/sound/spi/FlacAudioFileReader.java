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

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.SequenceInputStream;
import java.net.URL;

import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;
import javax.sound.sampled.spi.AudioFileReader;

import org.kc7bfi.jflac.Constants;
import org.kc7bfi.jflac.FLACDecoder;
import org.kc7bfi.jflac.io.BitInputStream;
import org.kc7bfi.jflac.io.BitOutputStream;
import org.kc7bfi.jflac.metadata.StreamInfo;

/**
 * Provider for Flac audio file reading services. This implementation can parse
 * the format information from Flac audio file, and can produce audio input
 * streams from files of this type.
 * 
 * @author Marc Gimpel, Wimba S.A. (marc@wimba.com)
 * @version $Revision: 1.8 $
 */
public class FlacAudioFileReader extends AudioFileReader {
    
	private static final boolean DEBUG = false;
	
    private FLACDecoder decoder;
    private StreamInfo streamInfo;

    /**
     * Obtains the audio file format of the File provided. The File must point
     * to valid audio file data.
     * 
     * @param file
     *            the File from which file format information should be
     *            extracted.
     * @return an AudioFileFormat object describing the audio file format.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    public AudioFileFormat getAudioFileFormat(File file) throws UnsupportedAudioFileException, IOException {
        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(file);
            return getAudioFileFormat(inputStream, (int) file.length());
        } finally {
            inputStream.close();
        }
    }

    /**
     * Obtains an audio input stream from the URL provided. The URL must point
     * to valid audio file data.
     * 
     * @param url
     *            the URL for which the AudioInputStream should be constructed.
     * @return an AudioInputStream object based on the audio file data pointed
     *         to by the URL.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    public AudioFileFormat getAudioFileFormat(URL url) throws UnsupportedAudioFileException, IOException {
        InputStream inputStream = url.openStream();
        try {
            return getAudioFileFormat(inputStream);
        } finally {
            inputStream.close();
        }
    }

    /**
     * Obtains an audio input stream from the input stream provided.
     * 
     * @param stream
     *            the input stream from which the AudioInputStream should be
     *            constructed.
     * @return an AudioInputStream object based on the audio file data contained
     *         in the input stream.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    public AudioFileFormat getAudioFileFormat(InputStream stream) throws UnsupportedAudioFileException, IOException {
        return getAudioFileFormat(stream, AudioSystem.NOT_SPECIFIED);
    }

    /**
     * Return the AudioFileFormat from the given InputStream.
     * 
     * @param stream
     *            the input stream from which the AudioInputStream should be
     *            constructed.
     * @param medialength
     * @return an AudioInputStream object based on the audio file data contained
     *         in the input stream.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */

    /**
     * Return the AudioFileFormat from the given InputStream. Implementation.
     * 
     * @param bitStream
     * @param baos
     * @param mediaLength
     * @return an AudioInputStream object based on the audio file data contained
     *         in the input stream.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    protected AudioFileFormat getAudioFileFormat(InputStream bitStream, int mediaLength) throws UnsupportedAudioFileException, IOException {
        AudioFormat format;
        //try {
            // If we can't read the format of this stream, we must restore
            // stream to
            // beginning so other providers can attempt to read the stream.
            //if (bitStream.markSupported()) {
                // maximum number of bytes to determine the stream encoding:
                // Size of 1st Ogg Packet (Flac header) = OGG_HEADERSIZE +
                // FLAC_HEADERSIZE + 1
                // Size of 2nd Ogg Packet (Comment) = OGG_HEADERSIZE +
                // comment_size + 1
                // Size of 3rd Ogg Header (First data) = OGG_HEADERSIZE +
                // number_of_frames
                // where number_of_frames < 256 and comment_size < 256 (if
                // within 1 frame)
            //    bitStream.mark(3 * OGG_HEADERSIZE + FLAC_HEADERSIZE + 256
            //            + 256 + 2);
            //}

            //int mode = -1;
            //int sampleRate = 0;
            //int channels = 0;
            //int frameSize = AudioSystem.NOT_SPECIFIED;
            //float frameRate = AudioSystem.NOT_SPECIFIED;
            //byte[] header = new byte[128];
            //int segments = 0;
            //int bodybytes = 0;
            //DataInputStream dis = new DataInputStream(bitStream);
            //if (baos == null) baos = new ByteArrayOutputStream(128);
            //int origchksum;
            //int chksum;
            // read the OGG header
            //dis.readFully(header, 0, OGG_HEADERSIZE);
            //baos.write(header, 0, OGG_HEADERSIZE);
            //origchksum = readInt(header, 22);
            //header[22] = 0;
            //header[23] = 0;
            //header[24] = 0;
            //header[25] = 0;
            //chksum = OggCrc.checksum(0, header, 0, OGG_HEADERSIZE);
            // make sure its a OGG header
            /*
            if (!OGGID.equals(new String(header, 0, 4))) { throw new UnsupportedAudioFileException(
                    "missing ogg id!"); }
            // how many segments are there?
            segments = header[SEGOFFSET] & 0xFF;
            if (segments > 1) { throw new UnsupportedAudioFileException(
                    "Corrupt Flac Header: more than 1 segments"); }
            dis.readFully(header, OGG_HEADERSIZE, segments);
            baos.write(header, OGG_HEADERSIZE, segments);
            chksum = OggCrc.checksum(chksum, header, OGG_HEADERSIZE, segments);
            // get the number of bytes in the segment
            bodybytes = header[OGG_HEADERSIZE] & 0xFF;
            if (bodybytes != FLAC_HEADERSIZE) { throw new UnsupportedAudioFileException(
                    "Corrupt Flac Header: size=" + bodybytes); }
            // read the Flac header
            dis.readFully(header, OGG_HEADERSIZE + 1, bodybytes);
            baos.write(header, OGG_HEADERSIZE + 1, bodybytes);
            chksum = OggCrc.checksum(chksum, header, OGG_HEADERSIZE + 1,
                    bodybytes);
            // make sure its a Flac header
            if (!FLACID.equals(new String(header, OGG_HEADERSIZE + 1, 8))) { throw new UnsupportedAudioFileException(
                    "Corrupt Flac Header: missing Flac ID"); }
            mode = readInt(header, OGG_HEADERSIZE + 1 + 40);
            sampleRate = readInt(header, OGG_HEADERSIZE + 1 + 36);
            channels = readInt(header, OGG_HEADERSIZE + 1 + 48);
            int nframes = readInt(header, OGG_HEADERSIZE + 1 + 64);
            boolean vbr = readInt(header, OGG_HEADERSIZE + 1 + 60) == 1;
            // Checksum
            if (chksum != origchksum)
                    throw new IOException("Ogg CheckSums do not match");
            // Calculate frameSize
            if (!vbr) {
                // Frames size is a constant so:
                // Read Comment Packet the Ogg Header of 1st data packet;
                // the array table_segment repeats the frame size over and over.
            }
            // Calculate frameRate
            if (mode >= 0 && mode <= 2 && nframes > 0) {
                frameRate = ((float) sampleRate)
                        / ((mode == 0 ? 160f : (mode == 1 ? 320f : 640f)) * ((float) nframes));
            }
            */
        try {
            decoder = new FLACDecoder(bitStream);
            streamInfo = decoder.readStreamInfo();
            if (streamInfo == null) {
            	if (DEBUG) {
            		System.out.println("FLAC file reader: no stream info found");
            	}
            	throw new UnsupportedAudioFileException("No StreamInfo found");
            }
            
            format = new FlacAudioFormat(streamInfo);
        //} catch (UnsupportedAudioFileException e) {
            // reset the stream for other providers
            //if (bitStream.markSupported()) {
            //    bitStream.reset();
            //}
            // just rethrow this exception
        //    throw e;
        } catch (IOException ioe) {
        	if (DEBUG) {
        		System.out.println("FLAC file reader: not a FLAC stream");
        	}
            // reset the stream for other providers
            //if (bitStream.markSupported()) {
            //    bitStream.reset();
            //}
            throw new UnsupportedAudioFileException(ioe.getMessage());
        }
    	if (DEBUG) {
    		System.out.println("FLAC file reader: got stream with format "+format);
    	}
        return new AudioFileFormat(FlacFileFormatType.FLAC, format, AudioSystem.NOT_SPECIFIED);
    }

    /**
     * Obtains an audio input stream from the File provided. The File must point
     * to valid audio file data.
     * 
     * @param file
     *            the File for which the AudioInputStream should be constructed.
     * @return an AudioInputStream object based on the audio file data pointed
     *         to by the File.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    public AudioInputStream getAudioInputStream(File file) throws UnsupportedAudioFileException, IOException {
        InputStream inputStream = new FileInputStream(file);
        try {
            return getAudioInputStream(inputStream, (int) file.length());
        } catch (UnsupportedAudioFileException e) {
            inputStream.close();
            throw e;
        } catch (IOException e) {
            inputStream.close();
            throw e;
        }
    }

    /**
     * Obtains an audio input stream from the URL provided. The URL must point
     * to valid audio file data.
     * 
     * @param url
     *            the URL for which the AudioInputStream should be constructed.
     * @return an AudioInputStream object based on the audio file data pointed
     *         to by the URL.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    public AudioInputStream getAudioInputStream(URL url) throws UnsupportedAudioFileException, IOException {
        InputStream inputStream = url.openStream();
        try {
            return getAudioInputStream(inputStream);
        } catch (UnsupportedAudioFileException e) {
            inputStream.close();
            throw e;
        } catch (IOException e) {
            inputStream.close();
            throw e;
        }
    }

    /**
     * Obtains an audio input stream from the input stream provided. The stream
     * must point to valid audio file data.
     * 
     * @param stream
     *            the input stream from which the AudioInputStream should be
     *            constructed.
     * @return an AudioInputStream object based on the audio file data contained
     *         in the input stream.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    public AudioInputStream getAudioInputStream(InputStream stream) throws UnsupportedAudioFileException, IOException {
        return getAudioInputStream(stream, AudioSystem.NOT_SPECIFIED);
    }

    /**
     * Obtains an audio input stream from the input stream provided. The stream
     * must point to valid audio file data.
     * 
     * @param inputStream
     *            the input stream from which the AudioInputStream should be
     *            constructed.
     * @param medialength
     * @return an AudioInputStream object based on the audio file data contained
     *         in the input stream.
     * @exception UnsupportedAudioFileException
     *                if the File does not point to a valid audio file data
     *                recognized by the system.
     * @exception IOException
     *                if an I/O exception occurs.
     */
    protected AudioInputStream getAudioInputStream(InputStream inputStream, int medialength) throws UnsupportedAudioFileException, IOException {
        AudioFileFormat audioFileFormat = getAudioFileFormat(inputStream, medialength);
        
        // push back the StreamInfo
        ByteArrayOutputStream byteOutStream = new ByteArrayOutputStream();
        BitOutputStream bitOutStream = new BitOutputStream(byteOutStream);
        bitOutStream.writeByteBlock(Constants.STREAM_SYNC_STRING, Constants.STREAM_SYNC_STRING.length);
        /** TODO what if StreamInfo not last? */
        streamInfo.write(bitOutStream, false);
        
        // flush bit input stream
        BitInputStream bis = decoder.getBitInputStream();
        int bytesLeft = bis.getInputBytesUnconsumed();
        byte[] b = new byte[bytesLeft];
        bis.readByteBlockAlignedNoCRC(b, bytesLeft);
        byteOutStream.write(b);
        
        ByteArrayInputStream byteInStream = new ByteArrayInputStream(byteOutStream.toByteArray());
        
        //ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
        SequenceInputStream sequenceInputStream = new SequenceInputStream(byteInStream, inputStream);
        //return new AudioInputStream(sequenceInputStream, audioFileFormat
        //        .getFormat(), audioFileFormat.getFrameLength());
        return new AudioInputStream(sequenceInputStream, audioFileFormat.getFormat(), audioFileFormat.getFrameLength());
    }
}
