package org.kc7bfi.jflac.util;

/**
 *  libFLAC - Free Lossless Audio Codec library
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

/**
 * Utility class to calculate 16-bit CRC.
 * @author kc7bfi
 */
public final class CRC16 {

    // CRC-16, poly = x^16 + x^15 + x^2 + x^0, init = 0
    private static final short[] CRC16_TABLE =
        new short[] {
            (short) 0x0000,
            (short) 0x8005,
            (short) 0x800f,
            (short) 0x000a,
            (short) 0x801b,
            (short) 0x001e,
            (short) 0x0014,
            (short) 0x8011,
            (short) 0x8033,
            (short) 0x0036,
            (short) 0x003c,
            (short) 0x8039,
            (short) 0x0028,
            (short) 0x802d,
            (short) 0x8027,
            (short) 0x0022,
            (short) 0x8063,
            (short) 0x0066,
            (short) 0x006c,
            (short) 0x8069,
            (short) 0x0078,
            (short) 0x807d,
            (short) 0x8077,
            (short) 0x0072,
            (short) 0x0050,
            (short) 0x8055,
            (short) 0x805f,
            (short) 0x005a,
            (short) 0x804b,
            (short) 0x004e,
            (short) 0x0044,
            (short) 0x8041,
            (short) 0x80c3,
            (short) 0x00c6,
            (short) 0x00cc,
            (short) 0x80c9,
            (short) 0x00d8,
            (short) 0x80dd,
            (short) 0x80d7,
            (short) 0x00d2,
            (short) 0x00f0,
            (short) 0x80f5,
            (short) 0x80ff,
            (short) 0x00fa,
            (short) 0x80eb,
            (short) 0x00ee,
            (short) 0x00e4,
            (short) 0x80e1,
            (short) 0x00a0,
            (short) 0x80a5,
            (short) 0x80af,
            (short) 0x00aa,
            (short) 0x80bb,
            (short) 0x00be,
            (short) 0x00b4,
            (short) 0x80b1,
            (short) 0x8093,
            (short) 0x0096,
            (short) 0x009c,
            (short) 0x8099,
            (short) 0x0088,
            (short) 0x808d,
            (short) 0x8087,
            (short) 0x0082,
            (short) 0x8183,
            (short) 0x0186,
            (short) 0x018c,
            (short) 0x8189,
            (short) 0x0198,
            (short) 0x819d,
            (short) 0x8197,
            (short) 0x0192,
            (short) 0x01b0,
            (short) 0x81b5,
            (short) 0x81bf,
            (short) 0x01ba,
            (short) 0x81ab,
            (short) 0x01ae,
            (short) 0x01a4,
            (short) 0x81a1,
            (short) 0x01e0,
            (short) 0x81e5,
            (short) 0x81ef,
            (short) 0x01ea,
            (short) 0x81fb,
            (short) 0x01fe,
            (short) 0x01f4,
            (short) 0x81f1,
            (short) 0x81d3,
            (short) 0x01d6,
            (short) 0x01dc,
            (short) 0x81d9,
            (short) 0x01c8,
            (short) 0x81cd,
            (short) 0x81c7,
            (short) 0x01c2,
            (short) 0x0140,
            (short) 0x8145,
            (short) 0x814f,
            (short) 0x014a,
            (short) 0x815b,
            (short) 0x015e,
            (short) 0x0154,
            (short) 0x8151,
            (short) 0x8173,
            (short) 0x0176,
            (short) 0x017c,
            (short) 0x8179,
            (short) 0x0168,
            (short) 0x816d,
            (short) 0x8167,
            (short) 0x0162,
            (short) 0x8123,
            (short) 0x0126,
            (short) 0x012c,
            (short) 0x8129,
            (short) 0x0138,
            (short) 0x813d,
            (short) 0x8137,
            (short) 0x0132,
            (short) 0x0110,
            (short) 0x8115,
            (short) 0x811f,
            (short) 0x011a,
            (short) 0x810b,
            (short) 0x010e,
            (short) 0x0104,
            (short) 0x8101,
            (short) 0x8303,
            (short) 0x0306,
            (short) 0x030c,
            (short) 0x8309,
            (short) 0x0318,
            (short) 0x831d,
            (short) 0x8317,
            (short) 0x0312,
            (short) 0x0330,
            (short) 0x8335,
            (short) 0x833f,
            (short) 0x033a,
            (short) 0x832b,
            (short) 0x032e,
            (short) 0x0324,
            (short) 0x8321,
            (short) 0x0360,
            (short) 0x8365,
            (short) 0x836f,
            (short) 0x036a,
            (short) 0x837b,
            (short) 0x037e,
            (short) 0x0374,
            (short) 0x8371,
            (short) 0x8353,
            (short) 0x0356,
            (short) 0x035c,
            (short) 0x8359,
            (short) 0x0348,
            (short) 0x834d,
            (short) 0x8347,
            (short) 0x0342,
            (short) 0x03c0,
            (short) 0x83c5,
            (short) 0x83cf,
            (short) 0x03ca,
            (short) 0x83db,
            (short) 0x03de,
            (short) 0x03d4,
            (short) 0x83d1,
            (short) 0x83f3,
            (short) 0x03f6,
            (short) 0x03fc,
            (short) 0x83f9,
            (short) 0x03e8,
            (short) 0x83ed,
            (short) 0x83e7,
            (short) 0x03e2,
            (short) 0x83a3,
            (short) 0x03a6,
            (short) 0x03ac,
            (short) 0x83a9,
            (short) 0x03b8,
            (short) 0x83bd,
            (short) 0x83b7,
            (short) 0x03b2,
            (short) 0x0390,
            (short) 0x8395,
            (short) 0x839f,
            (short) 0x039a,
            (short) 0x838b,
            (short) 0x038e,
            (short) 0x0384,
            (short) 0x8381,
            (short) 0x0280,
            (short) 0x8285,
            (short) 0x828f,
            (short) 0x028a,
            (short) 0x829b,
            (short) 0x029e,
            (short) 0x0294,
            (short) 0x8291,
            (short) 0x82b3,
            (short) 0x02b6,
            (short) 0x02bc,
            (short) 0x82b9,
            (short) 0x02a8,
            (short) 0x82ad,
            (short) 0x82a7,
            (short) 0x02a2,
            (short) 0x82e3,
            (short) 0x02e6,
            (short) 0x02ec,
            (short) 0x82e9,
            (short) 0x02f8,
            (short) 0x82fd,
            (short) 0x82f7,
            (short) 0x02f2,
            (short) 0x02d0,
            (short) 0x82d5,
            (short) 0x82df,
            (short) 0x02da,
            (short) 0x82cb,
            (short) 0x02ce,
            (short) 0x02c4,
            (short) 0x82c1,
            (short) 0x8243,
            (short) 0x0246,
            (short) 0x024c,
            (short) 0x8249,
            (short) 0x0258,
            (short) 0x825d,
            (short) 0x8257,
            (short) 0x0252,
            (short) 0x0270,
            (short) 0x8275,
            (short) 0x827f,
            (short) 0x027a,
            (short) 0x826b,
            (short) 0x026e,
            (short) 0x0264,
            (short) 0x8261,
            (short) 0x0220,
            (short) 0x8225,
            (short) 0x822f,
            (short) 0x022a,
            (short) 0x823b,
            (short) 0x023e,
            (short) 0x0234,
            (short) 0x8231,
            (short) 0x8213,
            (short) 0x0216,
            (short) 0x021c,
            (short) 0x8219,
            (short) 0x0208,
            (short) 0x820d,
            (short) 0x8207,
            (short) 0x0202 };

    /**
     * Update the CRC with the byte data.
     * 
     * @param data  The byte data
     * @param crc   The starting CRC value
     * @return      The updated CRC value
     */
    public static short update(byte data, short crc) {
        crc = (short) ((crc << 8) ^ CRC16_TABLE[((crc >> 8) ^ data) & 0xff]);
        return crc;
    }

    /**
     * Update the CRC with the byte array data.
     * 
     * @param data  The byte array data
     * @param len   The byte array length
     * @param crc   The starting CRC value
     * @return      The updated CRC value
     */
    public static short updateBlock(byte[] data, int len, short crc) {
        for (int i = 0; i < len; i++)
            crc = (short) ((crc << 8) ^ CRC16_TABLE[(crc >> 8) ^ data[i]]);
        return crc;
    }


    /**
     * Calculate the CRC over a byte array.
     * 
     * @param data  The byte data
     * @param len   The byte array length
     * @return      The calculated CRC value
     */
    public static short calc(byte[] data, int len) {
        short crc = 0;

        for (int i = 0; i < len; i++)
            crc = (short) ((crc << 8) ^ CRC16_TABLE[(crc >> 8) ^ data[i]]);

        return crc;
    }
}
