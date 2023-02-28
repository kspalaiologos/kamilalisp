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
 * LPC Predictor utility class.
 * @author kc7bfi
 */
public class LPCPredictor {
    //static private final double M_LN2 = 0.69314718055994530942;
    
    /*
     void FLAC__lpc_compute_autocorrelation(double data[], int data_len, int lag, double autoc[])
     {
     //
      // this version tends to run faster because of better data locality
       // ('data_len' is usually much larger than 'lag')
        //
         double d;
         int sample, coeff;
         int limit = data_len - lag;
         
         for(coeff = 0; coeff < lag; coeff++)
         autoc[coeff] = 0.0;
         for(sample = 0; sample <= limit; sample++) {
         d = data[sample];
         for(coeff = 0; coeff < lag; coeff++)
         autoc[coeff] += d * data[sample+coeff];
         }
         for(; sample < data_len; sample++) {
         d = data[sample];
         for(coeff = 0; coeff < data_len - sample; coeff++)
         autoc[coeff] += d * data[sample+coeff];
         }
         }
         
         void FLAC__lpc_compute_lp_coefficients(double autoc[], int max_order, double[][] lp_coeff, double error[])
         {
         int i, j;
         double r, err;
         double ref = new double[Constants.MAX_LPC_ORDER];
         double lpc = new double[Constants.MAX_LPC_ORDER];
         
         err = autoc[0];
         
         for(i = 0; i < max_order; i++) {
         // Sum up this iteration's reflection coefficient.
          r = -autoc[i+1];
          for(j = 0; j < i; j++)
          r -= lpc[j] * autoc[i-j];
          ref[i] = (r/=err);
          
          // Update LPC coefficients and total error.
           lpc[i]=r;
           for(j = 0; j < (i>>1); j++) {
           double tmp = lpc[j];
           lpc[j] += r * lpc[i-1-j];
           lpc[i-1-j] += r * tmp;
           }
           if(i & 1)
           lpc[j] += lpc[j] * r;
           
           err *= (1.0 - r * r);
           
           // save this order
            for(j = 0; j <= i; j++)
            lp_coeff[i][j] = (double)(-lpc[j]); // negate FIR filter coeff to get predictor coeff
            error[i] = (double)err;
            }
            }
            
            int FLAC__lpc_quantize_coefficients(double lp_coeff[], int order, int precision, FLAC__int32 qlp_coeff[], int *shift)
            {
            int i;
            double d, cmax = -1e32;
            FLAC__int32 qmax, qmin;
            int max_shiftlimit = (1 << (FLAC__SUBFRAME_LPC_QLP_SHIFT_LEN-1)) - 1;
            int min_shiftlimit = -max_shiftlimit - 1;
            
            FLAC__ASSERT(precision > 0);
            FLAC__ASSERT(precision >= FLAC__MIN_QLP_COEFF_PRECISION);
            
            // drop one bit for the sign; from here on out we consider only |lp_coeff[i]|
             precision--;
             qmax = 1 << precision;
             qmin = -qmax;
             qmax--;
             
             for(i = 0; i < order; i++) {
             if(lp_coeff[i] == 0.0)
             continue;
             d = fabs(lp_coeff[i]);
             if(d > cmax)
             cmax = d;
             }
             redo_it:
             if(cmax <= 0.0) {
             // => coefficients are all 0, which means our constant-detect didn't work 
              return 2;
              }
              else {
              int log2cmax;
              
              (void)frexp(cmax, &log2cmax);
              log2cmax--;
              *shift = (int)precision - log2cmax - 1;
              
              if(*shift < min_shiftlimit || *shift > max_shiftlimit) {
              #if 0
              //@@@ this does not seem to help at all, but was not extensively tested either:
               if(*shift > max_shiftlimit)
               *shift = max_shiftlimit;
               else
               #endif
               return 1;
               }
               }
               
               if(*shift >= 0) {
               for(i = 0; i < order; i++) {
               qlp_coeff[i] = (FLAC__int32)floor((double)lp_coeff[i] * (double)(1 << *shift));
               
               // double-check the result
                if(qlp_coeff[i] > qmax || qlp_coeff[i] < qmin) {
                #ifdef FLAC__OVERFLOW_DETECT
                fprintf(stderr,"FLAC__lpc_quantize_coefficients: compensating for overflow, qlp_coeff[%u]=%d, lp_coeff[%u]=%f, cmax=%f, precision=%u, shift=%d, q=%f, f(q)=%f\n", i, qlp_coeff[i], i, lp_coeff[i], cmax, precision, *shift, (double)lp_coeff[i] * (double)(1 << *shift), floor((double)lp_coeff[i] * (double)(1 << *shift)));
                #endif
                cmax *= 2.0;
                goto redo_it;
                }
                }
                }
                else { // (*shift < 0)
                int nshift = -(*shift);
                #ifdef DEBUG
                fprintf(stderr,"FLAC__lpc_quantize_coefficients: negative shift = %d\n", *shift);
                #endif
                for(i = 0; i < order; i++) {
                qlp_coeff[i] = (FLAC__int32)floor((double)lp_coeff[i] / (double)(1 << nshift));
                
                // double-check the result
                 if(qlp_coeff[i] > qmax || qlp_coeff[i] < qmin) {
                 #ifdef FLAC__OVERFLOW_DETECT
                 fprintf(stderr,"FLAC__lpc_quantize_coefficients: compensating for overflow, qlp_coeff[%u]=%d, lp_coeff[%u]=%f, cmax=%f, precision=%u, shift=%d, q=%f, f(q)=%f\n", i, qlp_coeff[i], i, lp_coeff[i], cmax, precision, *shift, (double)lp_coeff[i] / (double)(1 << nshift), floor((double)lp_coeff[i] / (double)(1 << nshift)));
                 #endif
                 cmax *= 2.0;
                 goto redo_it;
                 }
                 }
                 }
                 
                 return 0;
                 }
                 */
    
    /*
     void FLAC__lpc_compute_residual_from_qlp_coefficients(int[] data, int dataLen, int[] qlp_coeff, int order, int lp_quantization, int[] residual) {
     int[] history;
     
     
     for(int i = 0; i < dataLen; i++) {
     int sum = 0;
     history = data;
     for(j = 0; j < order; j++) {
     sum += qlp_coeff[j] * (*(--history));
     }
     residual[i] = data[i] - (sum >> lp_quantization);
     }
     }
     
     void FLAC__lpc_compute_residual_from_qlp_coefficients_wide(int[] data, int data_len, int[] qlp_coeff, int order, int lp_quantization, int[] residual)
     {
     int[] history;
     
     
     for(int i = 0; i < data_len; i++) {
     long sum = 0;
     history = data;
     for(int j = 0; j < order; j++)
     sum += (long)qlp_coeff[j] * (long)(*(--history));
     residual[i] = data[i] - (int)(sum >> lp_quantization);
     }
     }
     */
    
    /**
     * Restore the signal from the LPC compression.
     * @param residual  The residual signal
     * @param dataLen   The length of the residual data
     * @param qlpCoeff
     * @param order     The predicate order
     * @param lpQuantization
     * @param data      The restored signal (output)
     * @param startAt   The starting position in the data array
     */
    public static void restoreSignal(int[] residual, int dataLen, int[] qlpCoeff, int order, int lpQuantization, int[] data, int startAt) {
        //System.out.println("Q="+lpQuantization);
        for (int i = 0; i < dataLen; i++) {
            int sum = 0;
            for (int j = 0; j < order; j++) {
                sum += qlpCoeff[j] * data[startAt + i - j - 1];
            }
            //System.out.print((sum >> lpQuantization)+" ");
            data[startAt + i] = residual[i] + (sum >> lpQuantization);
        }
        //System.out.println();
        //for (int i = 0; i < dataLen+startAt; i++) System.out.print(data[i]+" "); System.out.println();
        //for (int j = 0; j < order; j++) System.out.print(qlpCoeff[j]+" ");System.out.println();
        //System.exit(1);
    }
    
    /**
     * Restore the signal from the LPC compression.
     * @param residual  The residual signal
     * @param dataLen   The length of the residual data
     * @param qlpCoeff
     * @param order     The predicate order
     * @param lpQuantization
     * @param data      The restored signal (output)
     * @param startAt   The starting position in the data array
     */
    public static void restoreSignalWide(int[] residual, int dataLen, int[] qlpCoeff, int order, int lpQuantization, int[] data, int startAt) {
        for (int i = 0; i < dataLen; i++) {
            long sum = 0;
            for (int j = 0; j < order; j++)
                sum += (long) qlpCoeff[j] * (long) (data[startAt + i - j - 1]);
            data[startAt + i] = residual[i] + (int) (sum >> lpQuantization);
        }
    }
    
    /*
     double FLAC__lpc_compute_expected_bits_per_residual_sample(double lpc_error, int total_samples)
     {
     double error_scale;
     
     FLAC__ASSERT(total_samples > 0);
     
     error_scale = 0.5 * M_LN2 * M_LN2 / (double)total_samples;
     
     return FLAC__lpc_compute_expected_bits_per_residual_sample_with_error_scale(lpc_error, error_scale);
     }
     
     double FLAC__lpc_compute_expected_bits_per_residual_sample_with_error_scale(double lpc_error, double error_scale)
     {
     if(lpc_error > 0.0) {
     double bps = (double)((double)0.5 * log(error_scale * lpc_error) / M_LN2);
     if(bps >= 0.0)
     return bps;
     else
     return 0.0;
     }
     else if(lpc_error < 0.0) { // error should not be negative but can happen due to inadequate float resolution
     return (double)1e32;
     }
     else {
     return 0.0;
     }
     }
     
     int FLAC__lpc_compute_best_order(double lpc_error[], int max_order, int total_samples, int bits_per_signal_sample)
     {
     int order, best_order;
     double best_bits, tmp_bits;
     double error_scale;
     
     FLAC__ASSERT(max_order > 0);
     FLAC__ASSERT(total_samples > 0);
     
     error_scale = 0.5 * M_LN2 * M_LN2 / (double)total_samples;
     
     best_order = 0;
     best_bits = FLAC__lpc_compute_expected_bits_per_residual_sample_with_error_scale(lpc_error[0], error_scale) * (double)total_samples;
     
     for(order = 1; order < max_order; order++) {
     tmp_bits = FLAC__lpc_compute_expected_bits_per_residual_sample_with_error_scale(lpc_error[order], error_scale) * (double)(total_samples - order) + (double)(order * bits_per_signal_sample);
     if(tmp_bits < best_bits) {
     best_order = order;
     best_bits = tmp_bits;
     }
     }
     
     return best_order+1; // +1 since index of lpc_error[] is order-1
     }
     */
}
