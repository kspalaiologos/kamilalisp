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

import java.io.File;
import java.io.IOException;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.FloatControl;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.SourceDataLine;

/** 
 * Play.java
 * <p>
 * A simple class that plays audio from given file names.
 * <p>
 * Uses the Java Sound SourceDataLine interface to stream the sound. 
 * Converts compressed encodings (ALAW, ULAW, MP3) to PCM.
 * @author Dan Becker, beckerdo@io.com
 */
public class SndPlayer {
    
    /** 
     * Plays audio from given file names.
     * @param args Command line parameters
     */
    public static void main(String [] args) {
        // Check for given sound file names.
        if (args.length < 1) {
            System.out.println("SndPlayer usage:");
            System.out.println("\tjava SndPlayer <sound file names>*");
            System.exit(0);
        }
        
        // Process arguments.
        for (int i = 0; i < args.length; i++) 
            playAudioFile(args[ i ]);
        
        // Must exit explicitly since audio creates non-daemon threads.
        System.exit(0);
    } // main
    
    /** 
     * Play audio from the given file name. 
     * @param fileName  The file to play
     */
    public static void playAudioFile(String fileName) {
        File soundFile = new File(fileName);
        
        try {
            // Create a stream from the given file.
            // Throws IOException or UnsupportedAudioFileException
            AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(soundFile);
            // AudioSystem.getAudioInputStream(inputStream); // alternate audio stream from inputstream
            playAudioStream(audioInputStream);
        } catch (Exception e) {
            System.out.println("Problem with file " + fileName + ":");
            e.printStackTrace();
        }
    } // playAudioFile
    
    /** 
     * Plays audio from the given audio input stream. 
     * @param audioInputStream  The audio stream to play
     */
    public static void playAudioStream(AudioInputStream audioInputStream) {
        // Audio format provides information like sample rate, size, channels.
        AudioFormat audioFormat = audioInputStream.getFormat();
        System.out.println("Play input audio format=" + audioFormat);
        
        // Convert compressed audio data to uncompressed PCM format.
        if (audioFormat.getEncoding() != AudioFormat.Encoding.PCM_SIGNED) {
            // if ((audioFormat.getEncoding() != AudioFormat.Encoding.PCM) ||
            //     (audioFormat.getEncoding() == AudioFormat.Encoding.ALAW) || 
            //     (audioFormat.getEncoding() == AudioFormat.Encoding.MP3)) {
            AudioFormat newFormat = new AudioFormat(
                    AudioFormat.Encoding.PCM_SIGNED, 
                    audioFormat.getSampleRate(),
                    16,
                    audioFormat.getChannels(),
                    audioFormat.getChannels() * 2,
                    audioFormat.getSampleRate(),
                    false);
            System.out.println("Converting audio format to " + newFormat);
            AudioInputStream newStream = AudioSystem.getAudioInputStream(newFormat, audioInputStream);
            audioFormat = newFormat;
            audioInputStream = newStream;
        }
        
        // Open a data line to play our type of sampled audio.
        // Use SourceDataLine for play and TargetDataLine for record.
        DataLine.Info info = new DataLine.Info(SourceDataLine.class, audioFormat);
        if (!AudioSystem.isLineSupported(info)) {
            System.out.println("Play.playAudioStream does not handle this type of audio on this system.");
            return;
        }
        
        try {
            // Create a SourceDataLine for play back (throws LineUnavailableException).  
            SourceDataLine dataLine = (SourceDataLine) AudioSystem.getLine(info);
            // System.out.println("SourceDataLine class=" + dataLine.getClass());
            
            // The line acquires system resources (throws LineAvailableException).
            dataLine.open(audioFormat);
            
            // Adjust the volume on the output line.
            if (dataLine.isControlSupported(FloatControl.Type.MASTER_GAIN)) {
                FloatControl volume = (FloatControl) dataLine.getControl(FloatControl.Type.MASTER_GAIN);
                volume.setValue(100.0F);
            }
            
            // Allows the line to move data in and out to a port.
            dataLine.start();
            
            // Create a buffer for moving data from the audio stream to the line.   
            int bufferSize = (int) audioFormat.getSampleRate() * audioFormat.getFrameSize();
            byte [] buffer = new byte[ bufferSize ];
            
            // Move the data until done or there is an error.
            try {
                int bytesRead = 0;
                while (bytesRead >= 0) {
                    bytesRead = audioInputStream.read(buffer, 0, buffer.length);
                    if (bytesRead >= 0) {
                        // System.out.println("Play.playAudioStream bytes read=" + bytesRead +
                        //    ", frame size=" + audioFormat.getFrameSize() + ", frames read=" + bytesRead / audioFormat.getFrameSize());
                        // Odd sized sounds throw an exception if we don't write the same amount.
                        dataLine.write(buffer, 0, bytesRead);
                    }
                } // while
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            System.out.println("Play.playAudioStream draining line.");
            // Continues data line I/O until its buffer is drained.
            dataLine.drain();
            
            System.out.println("Play.playAudioStream closing line.");
            // Closes the data line, freeing any resources such as the audio device.
            dataLine.close();
        } catch (LineUnavailableException e) {
            e.printStackTrace();
        }
    } // playAudioStream
} // Play
