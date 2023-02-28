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

/**
 * RingBuffer class.
 * @author David R Robison
 */
public class RingBuffer {
    protected static final int DEFAULT_BUFFER_SIZE = 2048;
    protected volatile int bufferSize = 0;
    protected byte[] buffer = null;
    protected volatile int putHere = 0;
    protected volatile int getHere = 0;
    protected volatile boolean eof = false;
    protected Object signal = new Object();
    
    /**
     * Constructor.
     * @param size  The size of the ring buffer
     */
    public RingBuffer(int size) {
        bufferSize = size;
        buffer = new byte[size];
    }
    
    /**
     * Constructor.
     */
    public RingBuffer() {
        this(DEFAULT_BUFFER_SIZE);
    }
    
    /**
     * Return the size of the ring buffer.
     * @return  The ring buffer size
     */
    public int size() {
        return buffer.length;
    }
    
    /**
     * Resize the ring buffer.
     * @param newSize   The new size of the ring buffer
     */
    public void resize(int newSize) {
        if (bufferSize >= newSize) return;
        byte[] newBuffer = new byte[newSize];
        System.arraycopy(buffer, 0, newBuffer, 0, buffer.length);
        buffer = newBuffer;
        bufferSize = newSize;
        //signal.notifyAll();
    }
    
    /**
     * return the space avaiable for writing.
     * @return The byte that may be written to the ring buffer
     */
    public int putAvailable() {
        if (putHere == getHere) return bufferSize - 1;
        if (putHere < getHere) return getHere - putHere - 1;
        return bufferSize - (putHere - getHere) - 1;
    }
    
    /**
     * Empty the ring buffer.
     */
    public void empty() {
        synchronized (signal) {
            putHere = 0;
            getHere = 0;
            signal.notifyAll();
        }
    }
    
    /**
     * Put data into the ring buffer.
     * @param data  The data to write
     * @param offset    The start position in the data array
     * @param len   The bytes from the data array to write
     */
    public void put(byte[] data, int offset, int len) {
        if (len == 0) return;
        
        synchronized (signal) {
            // see if we have enough room
            while (putAvailable() < len) {
                try { signal.wait(1000); } catch (Exception e) { System.out.println("Put.Signal.wait:" + e); }
            }
            
            // copy data
            if (putHere >= getHere) {
                int l = Math.min(len, bufferSize - putHere);
                System.arraycopy(data, offset, buffer, putHere, l);
                putHere += l;
                if (putHere >= bufferSize) putHere = 0;
                if (len > l) put(data, offset + l, len - l);
            } else {
                int l = Math.min(len, getHere - putHere - 1);
                System.arraycopy(data, offset, buffer, putHere, l);
                putHere += l;
                if (putHere >= bufferSize) putHere = 0;
            }
            signal.notify();
        }
    }
    
    /**
     * Return the bytes available for reading.
     * @return The number of bytes that may be read from the ring buffer
     */
    public int getAvailable() {
        if (putHere == getHere) return 0;
        if (putHere < getHere) return bufferSize - (getHere - putHere);
        return putHere - getHere;
    }
    
    /**
     * Read data from the ring buffer.
     * @param data  Where to put the data
     * @param offset    The offset into the data array to start putting data
     * @param len   The maximum data to read
     * @return  The number of bytes read
     */
    public int get(byte[] data, int offset, int len) {
        if (len == 0) return 0;
        int dataLen = 0;
        
        synchronized (signal) {
            // see if we have enough data
            while (getAvailable() <= 0) {
                if (eof) return (-1);
                try { signal.wait(1000); } catch (Exception e) { System.out.println("Get.Signal.wait:" + e); }
            }
            len = Math.min(len, getAvailable());
            
            // copy data
            if (getHere < putHere) {
                int l = Math.min(len, putHere - getHere);
                System.arraycopy(buffer, getHere, data, offset, l);
                getHere += l;
                if (getHere >= bufferSize) getHere = 0;
                dataLen = l;
            } else {
                int l = Math.min(len, bufferSize - getHere);
                System.arraycopy(buffer, getHere, data, offset, l);
                getHere += l;
                if (getHere >= bufferSize) getHere = 0;
                dataLen = l;
                if (len > l) dataLen += get(data, offset + l, len - l);
            }
            signal.notify();
        }
        
        return dataLen;
    }
    
    /**
     * Return EOF status.
     * @return True if EOF.
     */
    public boolean isEOF() {
        return eof;
    }
    
    /**
     * Set the EOF status.
     * @param eof The eof to set.
     */
    public void setEOF(boolean eof) {
        this.eof = eof;
    }
    
    /**
     * Test main routine.
     * @param args  Not used
     */
    public static void main(String[] args) {
        RingBuffer r = new RingBuffer(9);
        byte[] b = new String("ABCDEFG").getBytes();
        byte[] g = new byte[2];
        System.out.println("Start");
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
        r.put(b, 0, 3);
        r.get(g, 0, 2);
        System.out.println(new String(g));
    }
}
