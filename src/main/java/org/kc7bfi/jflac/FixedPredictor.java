package org.kc7bfi.jflac;

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
 * Fixed Predictor utility class.
 * @author kc7bfi
 */
public class FixedPredictor {
    
    private static final double M_LN2 = 0.69314718055994530942;
    
    /**
     * Compute the best predictor order.
     * @param data
     * @param dataLen
     * @param residualBitsPerSample
     * @return
     */
    public static int computeBestPredictor(int[] data, int dataLen, double[] residualBitsPerSample) {
        int lastError0 = data[-1];
        int lastError1 = data[-1] - data[-2];
        int lastError2 = lastError1 - (data[-2] - data[-3]);
        int lastError3 = lastError2 - (data[-2] - 2 * data[-3] + data[-4]);
        int error, save;
        int totalError0 = 0, totalError1 = 0, totalError2 = 0, totalError3 = 0, totalError4 = 0;
        int i, order;
        
        for (i = 0; i < dataLen; i++) {
            error = data[i];
            totalError0 += Math.abs(error);
            save = error;
            error -= lastError0;
            totalError1 += Math.abs(error);
            lastError0 = save;
            save = error;
            error -= lastError1;
            totalError2 += Math.abs(error);
            lastError1 = save;
            save = error;
            error -= lastError2;
            totalError3 += Math.abs(error);
            lastError2 = save;
            save = error;
            error -= lastError3;
            totalError4 += Math.abs(error);
            lastError3 = save;
        }
        
        if (totalError0 < Math.min(Math.min(Math.min(totalError1, totalError2), totalError3), totalError4))
            order = 0;
        else if (totalError1 < Math.min(Math.min(totalError2, totalError3), totalError4))
            order = 1;
        else if (totalError2 < Math.min(totalError3, totalError4))
            order = 2;
        else if (totalError3 < totalError4)
            order = 3;
        else
            order = 4;
        
        // Estimate the expected number of bits per residual signal sample.
        // 'total_error*' is linearly related to the variance of the residual
        // signal, so we use it directly to compute E(|x|)
        residualBitsPerSample[0] = (double) ((totalError0 > 0) ? Math.log(M_LN2 * (double) totalError0 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[1] = (double) ((totalError1 > 0) ? Math.log(M_LN2 * (double) totalError1 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[2] = (double) ((totalError2 > 0) ? Math.log(M_LN2 * (double) totalError2 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[3] = (double) ((totalError3 > 0) ? Math.log(M_LN2 * (double) totalError3 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[4] = (double) ((totalError4 > 0) ? Math.log(M_LN2 * (double) totalError4 / (double) dataLen) / M_LN2 : 0.0);
        
        return order;
    }
    
    /**
     * Compute the best predictor order.
     * @param data
     * @param dataLen
     * @param residualBitsPerSample
     * @return
     */
    public static int computeBestPredictorWide(int[] data, int dataLen, double[] residualBitsPerSample) {
        int lastError0 = data[-1];
        int lastError1 = data[-1] - data[-2];
        int lastError2 = lastError1 - (data[-2] - data[-3]);
        int lastError3 = lastError2 - (data[-2] - 2 * data[-3] + data[-4]);
        int error, save;
        
        // totalError* are 64-bits to avoid overflow when encoding
        // erratic signals when the bits-per-sample and blocksize are
        // large.
        long totalError0 = 0, totalError1 = 0, totalError2 = 0, totalError3 = 0, totalError4 = 0;
        int i, order;
        
        for (i = 0; i < dataLen; i++) {
            error = data[i];
            totalError0 += Math.abs(error);
            save = error;
            error -= lastError0;
            totalError1 += Math.abs(error);
            lastError0 = save;
            save = error;
            error -= lastError1;
            totalError2 += Math.abs(error);
            lastError1 = save;
            save = error;
            error -= lastError2;
            totalError3 += Math.abs(error);
            lastError2 = save;
            save = error;
            error -= lastError3;
            totalError4 += Math.abs(error);
            lastError3 = save;
        }
        
        if (totalError0 < Math.min(Math.min(Math.min(totalError1, totalError2), totalError3), totalError4))
            order = 0;
        else if (totalError1 < Math.min(Math.min(totalError2, totalError3), totalError4))
            order = 1;
        else if (totalError2 < Math.min(totalError3, totalError4))
            order = 2;
        else if (totalError3 < totalError4)
            order = 3;
        else
            order = 4;
        
        // Estimate the expected number of bits per residual signal sample.
        // 'total_error*' is linearly related to the variance of the residual
        // signal, so we use it directly to compute E(|x|)
        // with VC++ you have to spoon feed it the casting
        residualBitsPerSample[0] = (double) ((totalError0 > 0) ? Math.log(M_LN2 * (double) (long) totalError0 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[1] = (double) ((totalError1 > 0) ? Math.log(M_LN2 * (double) (long) totalError1 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[2] = (double) ((totalError2 > 0) ? Math.log(M_LN2 * (double) (long) totalError2 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[3] = (double) ((totalError3 > 0) ? Math.log(M_LN2 * (double) (long) totalError3 / (double) dataLen) / M_LN2 : 0.0);
        residualBitsPerSample[4] = (double) ((totalError4 > 0) ? Math.log(M_LN2 * (double) (long) totalError4 / (double) dataLen) / M_LN2 : 0.0);
        
        return order;
    }
    
    /**
     * Compute the residual from the compressed signal.
     * @param data
     * @param dataLen
     * @param order
     * @param residual
     */
    public static void computeResidual(int[] data, int dataLen, int order, int[] residual) {
        int idataLen = (int) dataLen;
        
        switch (order) {
            case 0 :
                for (int i = 0; i < idataLen; i++) {
                    residual[i] = data[i];
                }
                break;
            case 1 :
                for (int i = 0; i < idataLen; i++) {
                    residual[i] = data[i] - data[i - 1];
                }
                break;
            case 2 :
                for (int i = 0; i < idataLen; i++) {
                    /* == data[i] - 2*data[i-1] + data[i-2] */
                    residual[i] = data[i] - (data[i - 1] << 1) + data[i - 2];
                }
                break;
            case 3 :
                for (int i = 0; i < idataLen; i++) {
                    /* == data[i] - 3*data[i-1] + 3*data[i-2] - data[i-3] */
                    residual[i] = data[i] - (((data[i - 1] - data[i - 2]) << 1) + (data[i - 1] - data[i - 2])) - data[i - 3];
                }
                break;
            case 4 :
                for (int i = 0; i < idataLen; i++) {
                    /* == data[i] - 4*data[i-1] + 6*data[i-2] - 4*data[i-3] + data[i-4] */
                    residual[i] = data[i] - ((data[i - 1] + data[i - 3]) << 2) + ((data[i - 2] << 2) + (data[i - 2] << 1)) + data[i - 4];
                }
                break;
            default :
        }
    }
    
    /**
     * Restore the signal from the fixed predictor.
     * @param residual  The residual data
     * @param dataLen   The length of residual data
     * @param order     The preicate order
     * @param data      The restored signal (output)
     * @param startAt   The starting position in the data array
     */
    public static void restoreSignal(int[] residual, int dataLen, int order, int[] data, int startAt) {
        int idataLen = (int) dataLen;
        
        switch (order) {
            case 0 :
                for (int i = 0; i < idataLen; i++) {
                    data[i + startAt] = residual[i];
                }
                break;
            case 1 :
                for (int i = 0; i < idataLen; i++) {
                    data[i + startAt] = residual[i] + data[i + startAt - 1];
                }
                break;
            case 2 :
                for (int i = 0; i < idataLen; i++) {
                    /* == residual[i] + 2*data[i-1] - data[i-2] */
                    data[i + startAt] = residual[i] + (data[i + startAt - 1] << 1) - data[i + startAt - 2];
                }
                break;
            case 3 :
                for (int i = 0; i < idataLen; i++) {
                    /* residual[i] + 3*data[i-1] - 3*data[i-2]) + data[i-3] */
                    data[i + startAt] = residual[i] + (((data[i + startAt - 1] - data[i + startAt - 2]) << 1) + (data[i + startAt - 1] - data[i + startAt - 2])) + data[i + startAt - 3];
                }
                break;
            case 4 :
                for (int i = 0; i < idataLen; i++) {
                    /* == residual[i] + 4*data[i-1] - 6*data[i-2] + 4*data[i-3] - data[i-4] */
                    data[i + startAt] = residual[i] + ((data[i + startAt - 1] + data[i + startAt - 3]) << 2) - ((data[i + startAt - 2] << 2) + (data[i + startAt - 2] << 1)) - data[i + startAt - 4];
                }
                break;
            default :
        }
    }
}
