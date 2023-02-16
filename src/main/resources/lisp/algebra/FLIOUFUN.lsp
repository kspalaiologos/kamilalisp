
(SDEFUN |FLIOUFUN;gamma;C;1| (($ (|Complex| (|Float|))))
        (SPROG ((|nbits| (|PositiveInteger|)) (|obits| (|Integer|)))
               (SEQ
                (COND
                 ((<= (LETT |obits| (SPADCALL (QREFELT $ 10)))
                      (QCAR (QREFELT $ 8)))
                  (SPADCALL (QCDR (QREFELT $ 8)) (|spadConstant| $ 7)
                            (QREFELT $ 13)))
                 ('T
                  (SEQ (LETT |nbits| (MAX |obits| (* 2 (QCAR (QREFELT $ 8)))))
                       (EXIT
                        (|finally|
                         (SEQ (SPADCALL |nbits| (QREFELT $ 14))
                              (PROGN
                               (RPLACD (QREFELT $ 8)
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 15)
                                                  (QREFELT $ 17))
                                        (QREFELT $ 18)))
                               (QCDR (QREFELT $ 8)))
                              (PROGN
                               (RPLACA (QREFELT $ 8) |nbits|)
                               (QCAR (QREFELT $ 8)))
                              (EXIT
                               (SPADCALL (QCDR (QREFELT $ 8))
                                         (|spadConstant| $ 7) (QREFELT $ 13))))
                         (SPADCALL |obits| (QREFELT $ 14)))))))))) 

(SDEFUN |FLIOUFUN;erf_series|
        ((|z| #1=(|Complex| (|Float|))) (|n| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|tk| #1#) (|k2| #2=(|NonNegativeInteger|))
          (|res| (|Complex| (|Float|))) (|term| (|Complex| (|Float|)))
          (|k1| #2#) (#3=#:G735 NIL) (|i| NIL) (|z2| (|Complex| (|Float|))))
         (SEQ (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20))) (LETT |tk| |z|)
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 0) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (LETT |k1| (+ (* 2 |i|) 1))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 15)
                                         (SPADCALL |k1| (QREFELT $ 23))
                                         (QREFELT $ 26))
                               |tk| (QREFELT $ 28)))
                        (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (LETT |k2| (+ |i| 1))
                        (EXIT
                         (LETT |tk|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 15)
                                            (SPADCALL |k2| (QREFELT $ 23))
                                            (QREFELT $ 26))
                                  (QREFELT $ 18))
                                 |z2| (QREFELT $ 28))
                                |tk| (QREFELT $ 20)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL 2 (QREFELT $ 23))
                          (SPADCALL (SPADCALL (QREFELT $ 30)) (QREFELT $ 31))
                          (QREFELT $ 26))
                |res| (QREFELT $ 28)))))) 

(SDEFUN |FLIOUFUN;erfc_asymptotic|
        ((|z| (|Complex| (|Float|))) (|prec| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|term| (|Complex| (|Float|))) (|res| (|Complex| (|Float|)))
          (|k| NIL) (|z2_inv| (|Complex| (|Float|)))
          (|z2| (|Complex| (|Float|))) (|eps| (|Float|)))
         (SEQ (LETT |eps| (SPADCALL 1 (- (* 2 |prec|)) 2 (QREFELT $ 32)))
              (LETT |term| (|spadConstant| $ 27))
              (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20)))
              (LETT |z2_inv|
                    (SPADCALL (|spadConstant| $ 27)
                              (SPADCALL (SPADCALL 2 (QREFELT $ 23)) |z2|
                                        (QREFELT $ 28))
                              (QREFELT $ 33)))
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |term| (QREFELT $ 34)) |eps|
                                (QREFELT $ 36)))
                     (GO G191)))
                   (SEQ (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (EXIT
                         (LETT |term|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (+ (* 2 |k|) 1) (QREFELT $ 23))
                                  |z2_inv| (QREFELT $ 28))
                                 |term| (QREFELT $ 20))
                                (QREFELT $ 37)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |z2| (QREFELT $ 37)) (QREFELT $ 38)) |res|
                 (QREFELT $ 20))
                (SPADCALL |z|
                          (SPADCALL (SPADCALL (QREFELT $ 30)) (QREFELT $ 31))
                          (QREFELT $ 39))
                (QREFELT $ 33)))))) 

(SDEFUN |FLIOUFUN;erf_z|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((#1=#:G749 NIL) (#2=#:G750 NIL) (|res| (|Complex| (|Float|)))
          (|n| (|Integer|)) (|nf| #3=(|DoubleFloat|))
          (|np| (|PositiveInteger|)) (|npf| #3#) (|sp| (|DoubleFloat|))
          (|dnz| (|DoubleFloat|)) (|oz| (|Integer|))
          (|prec| (|PositiveInteger|)) (|nz| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                (LETT |nz| (SPADCALL |z| (QREFELT $ 34)))
                (LETT |prec| (+ |obits| 20))
                (LETT |oz| (SPADCALL |nz| (QREFELT $ 40)))
                (EXIT
                 (COND
                  ((> (INTEGER-LENGTH |prec|) 500)
                   (|error| "reqested too high precision"))
                  (#4='T
                   (SEQ
                    (COND
                     ((< |oz| 500)
                      (SEQ
                       (EXIT
                        (SEQ (LETT |dnz| (SPADCALL |nz| (QREFELT $ 42)))
                             (LETT |sp|
                                   (SPADCALL |prec|
                                             (SPADCALL
                                              (SPADCALL 694 1000
                                                        (QREFELT $ 43))
                                              (QREFELT $ 44))
                                             (QREFELT $ 46)))
                             (EXIT
                              (COND
                               ((SPADCALL |sp| |dnz| (QREFELT $ 47))
                                (PROGN
                                 (LETT #1#
                                       (SEQ
                                        (LETT |npf|
                                              (|add_DF|
                                               (|mul_DF|
                                                (SPADCALL
                                                 (SPADCALL 2000 693
                                                           (QREFELT $ 43))
                                                 (QREFELT $ 44))
                                                |dnz|)
                                               (FLOAT |prec|
                                                      MOST-POSITIVE-DOUBLE-FLOAT)))
                                        (LETT |np|
                                              (SPADCALL
                                               (SPADCALL |npf| (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (LETT |nf|
                                              (|add_DF|
                                               (|mul_DF| (|exp_DF| 1.0) |dnz|)
                                               |sp|))
                                        (LETT |n|
                                              (SPADCALL
                                               (SPADCALL |nf| (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (SPADCALL |np| (QREFELT $ 14))
                                        (LETT |res|
                                              (|FLIOUFUN;erf_series| |z| |n|
                                               $))
                                        (SPADCALL |obits| (QREFELT $ 14))
                                        (EXIT
                                         (PROGN
                                          (LETT #2# |res|)
                                          (GO #5=#:G748)))))
                                 (GO #6=#:G745)))))))
                       #6# (EXIT #1#))))
                    (SPADCALL |prec| (QREFELT $ 14))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |z| (QREFELT $ 50))
                                 (|spadConstant| $ 7) (QREFELT $ 36))
                       (SPADCALL (|spadConstant| $ 27)
                                 (|FLIOUFUN;erfc_asymptotic| |z| (+ |obits| 5)
                                  $)
                                 (QREFELT $ 51)))
                      (#4#
                       (SPADCALL
                        (|FLIOUFUN;erfc_asymptotic|
                         (SPADCALL |z| (QREFELT $ 37)) (+ |obits| 5) $)
                        (|spadConstant| $ 27) (QREFELT $ 51)))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FLIOUFUN;erf;2C;5|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                    (EXIT
                     (|finally| (|FLIOUFUN;erf_z| |z| $)
                                (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;erf;2F;6| ((|z| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |z| (|spadConstant| $ 7) (QREFELT $ 13))
                   (QREFELT $ 52))
         (QREFELT $ 50))) 

(SDEFUN |FLIOUFUN;erfi;2C;7|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPADCALL
         (SPADCALL (|spadConstant| $ 7)
                   (SPADCALL (|spadConstant| $ 15) (QREFELT $ 18))
                   (QREFELT $ 13))
         (SPADCALL
          (SPADCALL
           (SPADCALL (|spadConstant| $ 7) (|spadConstant| $ 15) (QREFELT $ 13))
           |z| (QREFELT $ 20))
          (QREFELT $ 52))
         (QREFELT $ 20))) 

(SDEFUN |FLIOUFUN;erfi;2F;8| ((|z| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL (|spadConstant| $ 7) |z| (QREFELT $ 13))
                   (QREFELT $ 52))
         (QREFELT $ 55))) 

(SDEFUN |FLIOUFUN;fresnel_c_series|
        ((|z| #1=(|Complex| (|Float|))) (|n| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|tk| #1#) (|k2| (|NonNegativeInteger|))
          (|res| (|Complex| (|Float|))) (|term| (|Complex| (|Float|)))
          (|k1| (|NonNegativeInteger|)) (#2=#:G761 NIL) (|i| NIL)
          (|z4| #3=(|Complex| (|Float|))) (|z2| #3#))
         (SEQ (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20))) (LETT |tk| |z|)
              (LETT |z4| (SPADCALL |z2| |z2| (QREFELT $ 20)))
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 0) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |k1| (+ (* 4 |i|) 1))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 15)
                                         (SPADCALL |k1| (QREFELT $ 23))
                                         (QREFELT $ 26))
                               |tk| (QREFELT $ 28)))
                        (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (LETT |k2| (* (+ (* 2 |i|) 1) (+ (* 2 |i|) 2)))
                        (EXIT
                         (LETT |tk|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 15)
                                            (SPADCALL |k2| (QREFELT $ 23))
                                            (QREFELT $ 26))
                                  (QREFELT $ 18))
                                 |z4| (QREFELT $ 28))
                                |tk| (QREFELT $ 20)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FLIOUFUN;fresnel_c_asymptotic|
        ((|z| (|Complex| (|Float|))) (|prec| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|term| (|Complex| (|Float|))) (|res_c| #1=(|Complex| (|Float|)))
          (|res_s| #1#) (|k| NIL) (|z2_inv| #2=(|Complex| (|Float|)))
          (|z2| (|Complex| (|Float|))) (|z_inv| #2#) (|eps| (|Float|)))
         (SEQ (LETT |eps| (SPADCALL 1 (- (* 2 |prec|)) 2 (QREFELT $ 32)))
              (LETT |z_inv|
                    (SPADCALL (|spadConstant| $ 27) |z| (QREFELT $ 33)))
              (LETT |term| (|spadConstant| $ 27))
              (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20)))
              (LETT |z2_inv|
                    (SPADCALL (|spadConstant| $ 27)
                              (SPADCALL (SPADCALL 2 (QREFELT $ 23)) |z2|
                                        (QREFELT $ 28))
                              (QREFELT $ 33)))
              (LETT |res_c| (|spadConstant| $ 21))
              (LETT |res_s| (|spadConstant| $ 21))
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |term| (QREFELT $ 34)) |eps|
                                (QREFELT $ 36)))
                     (GO G191)))
                   (SEQ (LETT |res_s| (SPADCALL |res_s| |term| (QREFELT $ 51)))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (+ (* 4 |k|) 1) (QREFELT $ 23))
                                |z2_inv| (QREFELT $ 28))
                               |term| (QREFELT $ 20)))
                        (LETT |res_c| (SPADCALL |res_c| |term| (QREFELT $ 29)))
                        (EXIT
                         (LETT |term|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (+ (* 4 |k|) 3) (QREFELT $ 23))
                                  |z2_inv| (QREFELT $ 28))
                                 |term| (QREFELT $ 20))
                                (QREFELT $ 37)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL 1 2 (QREFELT $ 43)) (QREFELT $ 57))
                 |z_inv| (QREFELT $ 28))
                (SPADCALL
                 (SPADCALL (SPADCALL |z2| (QREFELT $ 58)) |res_c|
                           (QREFELT $ 20))
                 (SPADCALL (SPADCALL |z2| (QREFELT $ 59)) |res_s|
                           (QREFELT $ 20))
                 (QREFELT $ 29))
                (QREFELT $ 20)))))) 

(SDEFUN |FLIOUFUN;fresnel_c_z|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|im_z| (|Float|)) (|re_z| (|Float|)) (|pi_fac| (|Float|))
          (#1=#:G775 NIL) (#2=#:G776 NIL) (|res| (|Complex| (|Float|)))
          (|n| (|Integer|)) (|nf| #3=(|DoubleFloat|))
          (|np| (|PositiveInteger|)) (|npf| #3#) (|sp| (|DoubleFloat|))
          (|dnz| (|DoubleFloat|)) (|oz| (|Integer|))
          (|prec| (|PositiveInteger|)) (|nz| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                (LETT |nz| (SPADCALL |z| (QREFELT $ 34)))
                (LETT |prec| (+ |obits| 10))
                (LETT |oz| (SPADCALL |nz| (QREFELT $ 40)))
                (EXIT
                 (COND
                  ((> (INTEGER-LENGTH |prec|) 500)
                   (|error| "reqested too high precision"))
                  (#4='T
                   (SEQ
                    (COND
                     ((< |oz| 500)
                      (SEQ
                       (EXIT
                        (SEQ (LETT |dnz| (SPADCALL |nz| (QREFELT $ 42)))
                             (LETT |sp|
                                   (SPADCALL |prec|
                                             (SPADCALL
                                              (SPADCALL 694 1000
                                                        (QREFELT $ 43))
                                              (QREFELT $ 44))
                                             (QREFELT $ 46)))
                             (EXIT
                              (COND
                               ((SPADCALL |sp| |dnz| (QREFELT $ 47))
                                (PROGN
                                 (LETT #1#
                                       (SEQ
                                        (LETT |npf|
                                              (|add_DF|
                                               (|mul_DF|
                                                (SPADCALL
                                                 (SPADCALL 2000 693
                                                           (QREFELT $ 43))
                                                 (QREFELT $ 44))
                                                |dnz|)
                                               (FLOAT |prec|
                                                      MOST-POSITIVE-DOUBLE-FLOAT)))
                                        (LETT |np|
                                              (SPADCALL
                                               (SPADCALL |npf| (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (LETT |nf|
                                              (|add_DF|
                                               (|mul_DF| (|exp_DF| 1.0) |dnz|)
                                               |sp|))
                                        (LETT |n|
                                              (SPADCALL
                                               (SPADCALL
                                                (|div_DF| |nf|
                                                          (FLOAT 2
                                                                 MOST-POSITIVE-DOUBLE-FLOAT))
                                                (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (SPADCALL |np| (QREFELT $ 14))
                                        (LETT |res|
                                              (|FLIOUFUN;fresnel_c_series| |z|
                                               |n| $))
                                        (SPADCALL |obits| (QREFELT $ 14))
                                        (EXIT
                                         (PROGN
                                          (LETT #2# |res|)
                                          (GO #5=#:G774)))))
                                 (GO #6=#:G768)))))))
                       #6# (EXIT #1#))))
                    (SPADCALL |prec| (QREFELT $ 14))
                    (LETT |pi_fac|
                          (SPADCALL
                           (SPADCALL (SPADCALL (QREFELT $ 30))
                                     (SPADCALL 8 (QREFELT $ 23))
                                     (QREFELT $ 26))
                           (QREFELT $ 31)))
                    (LETT |re_z| (SPADCALL |z| (QREFELT $ 50)))
                    (LETT |im_z| (SPADCALL |z| (QREFELT $ 55)))
                    (EXIT
                     (COND
                      ((SPADCALL |re_z| (|spadConstant| $ 7) (QREFELT $ 36))
                       (COND
                        ((SPADCALL |im_z| (|spadConstant| $ 7) (QREFELT $ 36))
                         (COND
                          ((SPADCALL |re_z| |im_z| (QREFELT $ 36))
                           (SPADCALL
                            (SPADCALL |pi_fac| (|spadConstant| $ 7)
                                      (QREFELT $ 13))
                            (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                            (QREFELT $ 51)))
                          (#4#
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 7) |pi_fac|
                                      (QREFELT $ 13))
                            (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                            (QREFELT $ 51)))))
                        ((SPADCALL |re_z| (SPADCALL |im_z| (QREFELT $ 18))
                                   (QREFELT $ 36))
                         (SPADCALL
                          (SPADCALL |pi_fac| (|spadConstant| $ 7)
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7)
                                    (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))))
                      ((SPADCALL |im_z| (|spadConstant| $ 7) (QREFELT $ 36))
                       (COND
                        ((SPADCALL (SPADCALL |re_z| (QREFELT $ 18)) |im_z|
                                   (QREFELT $ 36))
                         (SPADCALL
                          (SPADCALL (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (|spadConstant| $ 7) (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7) |pi_fac|
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))))
                      (#4#
                       (COND
                        ((SPADCALL (SPADCALL |re_z| (QREFELT $ 18))
                                   (SPADCALL |im_z| (QREFELT $ 18))
                                   (QREFELT $ 36))
                         (SPADCALL
                          (SPADCALL (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (|spadConstant| $ 7) (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7)
                                    (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_c_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FLIOUFUN;fresnelC;2C;12|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|res| (|Complex| (|Float|))) (|pi_fac| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
              (EXIT
               (|finally|
                (SEQ (SPADCALL (+ |obits| 10) (QREFELT $ 14))
                     (LETT |pi_fac|
                           (SPADCALL
                            (SPADCALL (SPADCALL (QREFELT $ 30))
                                      (SPADCALL 2 (QREFELT $ 23))
                                      (QREFELT $ 26))
                            (QREFELT $ 31)))
                     (LETT |z| (SPADCALL |pi_fac| |z| (QREFELT $ 28)))
                     (LETT |res| (|FLIOUFUN;fresnel_c_z| |z| $))
                     (SPADCALL (+ |obits| 10) (QREFELT $ 14))
                     (EXIT
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 15) |pi_fac| (QREFELT $ 26))
                       |res| (QREFELT $ 28))))
                (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;fresnelC;2F;13| ((|z| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |z| (|spadConstant| $ 7) (QREFELT $ 13))
                   (QREFELT $ 60))
         (QREFELT $ 50))) 

(SDEFUN |FLIOUFUN;fresnel_s_series|
        ((|z| (|Complex| (|Float|))) (|n| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|tk| #1=(|Complex| (|Float|))) (|k2| (|NonNegativeInteger|))
          (|res| (|Complex| (|Float|))) (|term| (|Complex| (|Float|)))
          (|k1| (|NonNegativeInteger|)) (#2=#:G786 NIL) (|i| NIL) (|z4| #1#)
          (|z2| #1#))
         (SEQ (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20)))
              (LETT |tk| (SPADCALL |z2| |z| (QREFELT $ 20)))
              (LETT |z4| (SPADCALL |z2| |z2| (QREFELT $ 20)))
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 0) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |k1| (+ (* 4 |i|) 3))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 15)
                                         (SPADCALL |k1| (QREFELT $ 23))
                                         (QREFELT $ 26))
                               |tk| (QREFELT $ 28)))
                        (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (LETT |k2| (* (+ (* 2 |i|) 2) (+ (* 2 |i|) 3)))
                        (EXIT
                         (LETT |tk|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 15)
                                            (SPADCALL |k2| (QREFELT $ 23))
                                            (QREFELT $ 26))
                                  (QREFELT $ 18))
                                 |z4| (QREFELT $ 28))
                                |tk| (QREFELT $ 20)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FLIOUFUN;fresnel_s_asymptotic|
        ((|z| (|Complex| (|Float|))) (|prec| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|term| (|Complex| (|Float|))) (|res_s| #1=(|Complex| (|Float|)))
          (|res_c| #1#) (|k| NIL) (|z2_inv| #2=(|Complex| (|Float|)))
          (|z2| (|Complex| (|Float|))) (|z_inv| #2#) (|eps| (|Float|)))
         (SEQ (LETT |eps| (SPADCALL 1 (- (* 2 |prec|)) 2 (QREFELT $ 32)))
              (LETT |z_inv|
                    (SPADCALL (|spadConstant| $ 27) |z| (QREFELT $ 33)))
              (LETT |term| (|spadConstant| $ 27))
              (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20)))
              (LETT |z2_inv|
                    (SPADCALL (|spadConstant| $ 27)
                              (SPADCALL (SPADCALL 2 (QREFELT $ 23)) |z2|
                                        (QREFELT $ 28))
                              (QREFELT $ 33)))
              (LETT |res_c| (|spadConstant| $ 21))
              (LETT |res_s| (|spadConstant| $ 21))
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |term| (QREFELT $ 34)) |eps|
                                (QREFELT $ 36)))
                     (GO G191)))
                   (SEQ (LETT |res_c| (SPADCALL |res_c| |term| (QREFELT $ 29)))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (+ (* 4 |k|) 1) (QREFELT $ 23))
                                |z2_inv| (QREFELT $ 28))
                               |term| (QREFELT $ 20)))
                        (LETT |res_s| (SPADCALL |res_s| |term| (QREFELT $ 29)))
                        (EXIT
                         (LETT |term|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (+ (* 4 |k|) 3) (QREFELT $ 23))
                                  |z2_inv| (QREFELT $ 28))
                                 |term| (QREFELT $ 20))
                                (QREFELT $ 37)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL 1 2 (QREFELT $ 43)) (QREFELT $ 57))
                 |z_inv| (QREFELT $ 28))
                (SPADCALL
                 (SPADCALL (SPADCALL |z2| (QREFELT $ 58)) |res_c|
                           (QREFELT $ 20))
                 (SPADCALL (SPADCALL |z2| (QREFELT $ 59)) |res_s|
                           (QREFELT $ 20))
                 (QREFELT $ 29))
                (QREFELT $ 20)))))) 

(SDEFUN |FLIOUFUN;fresnel_s_z|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|im_z| (|Float|)) (|re_z| (|Float|)) (|pi_fac| (|Float|))
          (#1=#:G800 NIL) (#2=#:G801 NIL) (|res| (|Complex| (|Float|)))
          (|n| (|Integer|)) (|nf| #3=(|DoubleFloat|))
          (|np| (|PositiveInteger|)) (|npf| #3#) (|sp| (|DoubleFloat|))
          (|dnz| (|DoubleFloat|)) (|oz| (|Integer|))
          (|prec| (|PositiveInteger|)) (|nz| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                (LETT |nz| (SPADCALL |z| (QREFELT $ 34)))
                (LETT |prec| (+ |obits| 10))
                (LETT |oz| (SPADCALL |nz| (QREFELT $ 40)))
                (EXIT
                 (COND
                  ((> (INTEGER-LENGTH |prec|) 500)
                   (|error| "reqested too high precision"))
                  (#4='T
                   (SEQ
                    (COND
                     ((< |oz| 500)
                      (SEQ
                       (EXIT
                        (SEQ (LETT |dnz| (SPADCALL |nz| (QREFELT $ 42)))
                             (LETT |sp|
                                   (SPADCALL |prec|
                                             (SPADCALL
                                              (SPADCALL 694 1000
                                                        (QREFELT $ 43))
                                              (QREFELT $ 44))
                                             (QREFELT $ 46)))
                             (EXIT
                              (COND
                               ((SPADCALL |sp| |dnz| (QREFELT $ 47))
                                (PROGN
                                 (LETT #1#
                                       (SEQ
                                        (LETT |npf|
                                              (|add_DF|
                                               (|mul_DF|
                                                (SPADCALL
                                                 (SPADCALL 2000 693
                                                           (QREFELT $ 43))
                                                 (QREFELT $ 44))
                                                |dnz|)
                                               (FLOAT |prec|
                                                      MOST-POSITIVE-DOUBLE-FLOAT)))
                                        (LETT |np|
                                              (SPADCALL
                                               (SPADCALL |npf| (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (LETT |nf|
                                              (|add_DF|
                                               (|mul_DF| (|exp_DF| 1.0) |dnz|)
                                               |sp|))
                                        (LETT |n|
                                              (SPADCALL
                                               (SPADCALL
                                                (|div_DF| |nf|
                                                          (FLOAT 2
                                                                 MOST-POSITIVE-DOUBLE-FLOAT))
                                                (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (SPADCALL |np| (QREFELT $ 14))
                                        (LETT |res|
                                              (|FLIOUFUN;fresnel_s_series| |z|
                                               |n| $))
                                        (SPADCALL |obits| (QREFELT $ 14))
                                        (EXIT
                                         (PROGN
                                          (LETT #2# |res|)
                                          (GO #5=#:G799)))))
                                 (GO #6=#:G793)))))))
                       #6# (EXIT #1#))))
                    (SPADCALL |prec| (QREFELT $ 14))
                    (LETT |pi_fac|
                          (SPADCALL
                           (SPADCALL (SPADCALL (QREFELT $ 30))
                                     (SPADCALL 8 (QREFELT $ 23))
                                     (QREFELT $ 26))
                           (QREFELT $ 31)))
                    (LETT |re_z| (SPADCALL |z| (QREFELT $ 50)))
                    (LETT |im_z| (SPADCALL |z| (QREFELT $ 55)))
                    (EXIT
                     (COND
                      ((SPADCALL |re_z| (|spadConstant| $ 7) (QREFELT $ 36))
                       (COND
                        ((SPADCALL |im_z| (|spadConstant| $ 7) (QREFELT $ 36))
                         (COND
                          ((SPADCALL |re_z| |im_z| (QREFELT $ 36))
                           (SPADCALL
                            (SPADCALL |pi_fac| (|spadConstant| $ 7)
                                      (QREFELT $ 13))
                            (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                            (QREFELT $ 51)))
                          (#4#
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 7)
                                      (SPADCALL |pi_fac| (QREFELT $ 18))
                                      (QREFELT $ 13))
                            (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                            (QREFELT $ 51)))))
                        ((SPADCALL |re_z| (SPADCALL |im_z| (QREFELT $ 18))
                                   (QREFELT $ 36))
                         (SPADCALL
                          (SPADCALL |pi_fac| (|spadConstant| $ 7)
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7) |pi_fac|
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))))
                      ((SPADCALL |im_z| (|spadConstant| $ 7) (QREFELT $ 36))
                       (COND
                        ((SPADCALL (SPADCALL |re_z| (QREFELT $ 18)) |im_z|
                                   (QREFELT $ 36))
                         (SPADCALL
                          (SPADCALL (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (|spadConstant| $ 7) (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7)
                                    (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))))
                      (#4#
                       (COND
                        ((SPADCALL (SPADCALL |re_z| (QREFELT $ 18))
                                   (SPADCALL |im_z| (QREFELT $ 18))
                                   (QREFELT $ 36))
                         (SPADCALL
                          (SPADCALL (SPADCALL |pi_fac| (QREFELT $ 18))
                                    (|spadConstant| $ 7) (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7) |pi_fac|
                                    (QREFELT $ 13))
                          (|FLIOUFUN;fresnel_s_asymptotic| |z| |obits| $)
                          (QREFELT $ 51)))))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FLIOUFUN;fresnelS;2C;17|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|res| (|Complex| (|Float|))) (|pi_fac| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
              (EXIT
               (|finally|
                (SEQ (SPADCALL (+ |obits| 10) (QREFELT $ 14))
                     (LETT |pi_fac|
                           (SPADCALL
                            (SPADCALL (SPADCALL (QREFELT $ 30))
                                      (SPADCALL 2 (QREFELT $ 23))
                                      (QREFELT $ 26))
                            (QREFELT $ 31)))
                     (LETT |z| (SPADCALL |pi_fac| |z| (QREFELT $ 28)))
                     (LETT |res| (|FLIOUFUN;fresnel_s_z| |z| $))
                     (SPADCALL (+ |obits| 10) (QREFELT $ 14))
                     (EXIT
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 15) |pi_fac| (QREFELT $ 26))
                       |res| (QREFELT $ 28))))
                (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;fresnelS;2F;18| ((|z| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |z| (|spadConstant| $ 7) (QREFELT $ 13))
                   (QREFELT $ 62))
         (QREFELT $ 50))) 

(SDEFUN |FLIOUFUN;ei_series|
        ((|z| #1=(|Complex| (|Float|))) (|n| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|tk| #1#) (|k2| #2=(|NonNegativeInteger|))
          (|res| (|Complex| (|Float|))) (|term| (|Complex| (|Float|)))
          (|k1| #2#) (#3=#:G811 NIL) (|i| NIL))
         (SEQ (LETT |tk| |z|) (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 0) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (LETT |k1| (+ |i| 1))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 15)
                                         (SPADCALL |k1| (QREFELT $ 23))
                                         (QREFELT $ 26))
                               |tk| (QREFELT $ 28)))
                        (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (LETT |k2| (+ |i| 2))
                        (EXIT
                         (LETT |tk|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 15)
                                           (SPADCALL |k2| (QREFELT $ 23))
                                           (QREFELT $ 26))
                                 |z| (QREFELT $ 28))
                                |tk| (QREFELT $ 20)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FLIOUFUN;ei_asymptotic|
        ((|z| (|Complex| (|Float|))) (|prec| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|term| #1=(|Complex| (|Float|))) (|res| (|Complex| (|Float|)))
          (|k| NIL) (|z_inv| #1#) (|eps| (|Float|)))
         (SEQ (LETT |eps| (SPADCALL 1 (- (* 2 |prec|)) 2 (QREFELT $ 32)))
              (LETT |z_inv|
                    (SPADCALL (|spadConstant| $ 27) |z| (QREFELT $ 33)))
              (LETT |term| |z_inv|) (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |term| (QREFELT $ 34)) |eps|
                                (QREFELT $ 36)))
                     (GO G191)))
                   (SEQ (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (EXIT
                         (LETT |term|
                               (SPADCALL
                                (SPADCALL (SPADCALL (+ |k| 1) (QREFELT $ 23))
                                          |z_inv| (QREFELT $ 28))
                                |term| (QREFELT $ 20)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |z| (QREFELT $ 38)) |res| (QREFELT $ 20)))))) 

(SDEFUN |FLIOUFUN;ei_z| ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|im_z| (|Float|)) (|pii| (|Float|)) (#1=#:G824 NIL) (#2=#:G825 NIL)
          (|res| (|Complex| (|Float|))) (|n| (|Integer|))
          (|nf| #3=(|DoubleFloat|)) (|np| (|PositiveInteger|)) (|npf| #3#)
          (|sp| (|DoubleFloat|)) (|dnz| (|DoubleFloat|)) (|oz| (|Integer|))
          (|prec| (|PositiveInteger|)) (|nz| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                (LETT |nz| (SPADCALL |z| (QREFELT $ 34)))
                (LETT |prec| (+ |obits| 20))
                (LETT |oz| (SPADCALL |nz| (QREFELT $ 40)))
                (EXIT
                 (COND
                  ((> (INTEGER-LENGTH |prec|) 500)
                   (|error| "reqested too high precision"))
                  (#4='T
                   (SEQ
                    (COND
                     ((< |oz| 1000)
                      (SEQ
                       (EXIT
                        (SEQ
                         (LETT |dnz|
                               (SPADCALL (SPADCALL |nz| (QREFELT $ 42))
                                         (QREFELT $ 64)))
                         (LETT |sp|
                               (SPADCALL |prec|
                                         (SPADCALL
                                          (SPADCALL 694 1000 (QREFELT $ 43))
                                          (QREFELT $ 44))
                                         (QREFELT $ 46)))
                         (EXIT
                          (COND
                           ((SPADCALL |sp| |dnz| (QREFELT $ 47))
                            (PROGN
                             (LETT #1#
                                   (SEQ
                                    (LETT |npf|
                                          (|add_DF|
                                           (|mul_DF|
                                            (SPADCALL
                                             (SPADCALL 2000 693 (QREFELT $ 43))
                                             (QREFELT $ 44))
                                            |dnz|)
                                           (FLOAT |prec|
                                                  MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |np|
                                          (SPADCALL
                                           (SPADCALL |npf| (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (LETT |nf|
                                          (|add_DF|
                                           (|mul_DF| (|exp_DF| 1.0) |dnz|)
                                           |sp|))
                                    (LETT |n|
                                          (SPADCALL
                                           (SPADCALL |nf| (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (SPADCALL |np| (QREFELT $ 14))
                                    (LETT |res|
                                          (|FLIOUFUN;ei_series| |z| |n| $))
                                    (SPADCALL |obits| (QREFELT $ 14))
                                    (EXIT
                                     (PROGN
                                      (LETT #2#
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL (QREFELT $ 19))
                                              (SPADCALL |z| (QREFELT $ 65))
                                              (QREFELT $ 29))
                                             |res| (QREFELT $ 29)))
                                      (GO #5=#:G823)))))
                             (GO #6=#:G818)))))))
                       #6# (EXIT #1#))))
                    (SPADCALL |prec| (QREFELT $ 14))
                    (LETT |pii| (SPADCALL (QREFELT $ 30)))
                    (LETT |im_z| (SPADCALL |z| (QREFELT $ 55)))
                    (EXIT
                     (COND
                      ((SPADCALL |im_z| (|spadConstant| $ 7) (QREFELT $ 66))
                       (COND
                        ((SPADCALL (SPADCALL |z| (QREFELT $ 50))
                                   (SPADCALL |im_z| (QREFELT $ 18))
                                   (QREFELT $ 36))
                         (|FLIOUFUN;ei_asymptotic| |z| (+ |obits| 5) $))
                        (#4#
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 7)
                                    (SPADCALL |pii| (QREFELT $ 18))
                                    (QREFELT $ 13))
                          (|FLIOUFUN;ei_asymptotic| |z| (+ |obits| 5) $)
                          (QREFELT $ 29)))))
                      ((SPADCALL (SPADCALL |z| (QREFELT $ 50)) |im_z|
                                 (QREFELT $ 36))
                       (|FLIOUFUN;ei_asymptotic| |z| (+ |obits| 5) $))
                      (#4#
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 7) |pii| (QREFELT $ 13))
                        (|FLIOUFUN;ei_asymptotic| |z| (+ |obits| 5) $)
                        (QREFELT $ 29)))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FLIOUFUN;Ei;2C;22|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                    (EXIT
                     (|finally| (|FLIOUFUN;ei_z| |z| $)
                                (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;Ei;2F;23| ((|x| (|Float|)) ($ (|Float|)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 68))
          (|error| "Ei: x <= 0"))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 13))
                     (QREFELT $ 67))
           (QREFELT $ 50))))) 

(SDEFUN |FLIOUFUN;li;2C;24|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|z1| (|Complex| (|Float|))) (|obits| (|PositiveInteger|)))
               (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                    (EXIT
                     (|finally|
                      (SEQ (SPADCALL (+ |obits| 5) (QREFELT $ 14))
                           (LETT |z1| (SPADCALL |z| (QREFELT $ 65)))
                           (EXIT (SPADCALL |z1| (QREFELT $ 67))))
                      (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;li;2F;25| ((|x| (|Float|)) ($ (|Float|)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 15) (QREFELT $ 68))
          (|error| "li: x <= 1"))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 13))
                     (QREFELT $ 70))
           (QREFELT $ 50))))) 

(SDEFUN |FLIOUFUN;ci_series|
        ((|z| (|Complex| (|Float|))) (|n| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|tk| #1=(|Complex| (|Float|))) (|k2| (|NonNegativeInteger|))
          (|res| (|Complex| (|Float|))) (|term| #1#)
          (|k1| (|NonNegativeInteger|)) (#2=#:G838 NIL) (|i| NIL)
          (|z2| (|Complex| (|Float|))))
         (SEQ (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20)))
              (LETT |tk|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 15)
                                (SPADCALL 2 (QREFELT $ 23)) (QREFELT $ 26))
                      (QREFELT $ 18))
                     |z2| (QREFELT $ 28)))
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |k1| (* 2 |i|))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 15)
                                         (SPADCALL |k1| (QREFELT $ 23))
                                         (QREFELT $ 26))
                               |tk| (QREFELT $ 28)))
                        (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (LETT |k2| (* (+ (* 2 |i|) 1) (+ (* 2 |i|) 2)))
                        (EXIT
                         (LETT |tk|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 15)
                                            (SPADCALL |k2| (QREFELT $ 23))
                                            (QREFELT $ 26))
                                  (QREFELT $ 18))
                                 |z2| (QREFELT $ 28))
                                |tk| (QREFELT $ 20)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FLIOUFUN;ci_asymptotic|
        ((|z| (|Complex| (|Float|))) (|prec| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|term| (|Complex| (|Float|))) (|res_c| #1=(|Complex| (|Float|)))
          (|res_s| #1#) (|k| NIL) (|z_inv| (|Complex| (|Float|)))
          (|eps| (|Float|)))
         (SEQ (LETT |eps| (SPADCALL 1 (- (* 2 |prec|)) 2 (QREFELT $ 32)))
              (LETT |z_inv|
                    (SPADCALL (|spadConstant| $ 27) |z| (QREFELT $ 33)))
              (LETT |term| (|spadConstant| $ 27))
              (LETT |res_c| (|spadConstant| $ 21))
              (LETT |res_s| (|spadConstant| $ 21))
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |term| (QREFELT $ 34)) |eps|
                                (QREFELT $ 36)))
                     (GO G191)))
                   (SEQ (LETT |res_s| (SPADCALL |res_s| |term| (QREFELT $ 29)))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (+ (* 2 |k|) 1) (QREFELT $ 23))
                                 |z_inv| (QREFELT $ 28))
                                |term| (QREFELT $ 20))
                               (QREFELT $ 37)))
                        (LETT |res_c| (SPADCALL |res_c| |term| (QREFELT $ 29)))
                        (EXIT
                         (LETT |term|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (+ (* 2 |k|) 2) (QREFELT $ 23))
                                 |z_inv| (QREFELT $ 28))
                                |term| (QREFELT $ 20)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |z_inv|
                         (SPADCALL
                          (SPADCALL (SPADCALL |z| (QREFELT $ 58)) |res_c|
                                    (QREFELT $ 20))
                          (SPADCALL (SPADCALL |z| (QREFELT $ 59)) |res_s|
                                    (QREFELT $ 20))
                          (QREFELT $ 29))
                         (QREFELT $ 20)))))) 

(SDEFUN |FLIOUFUN;ci_z| ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|pi_fac| (|Float|)) (#1=#:G850 NIL) (#2=#:G851 NIL)
          (|res| (|Complex| (|Float|))) (|n| (|Integer|))
          (|nf| #3=(|DoubleFloat|)) (|np| (|PositiveInteger|)) (|npf| #3#)
          (|sp| (|DoubleFloat|)) (|dnz| (|DoubleFloat|)) (|oz| (|Integer|))
          (|prec| (|PositiveInteger|)) (|nz| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                (LETT |nz| (SPADCALL |z| (QREFELT $ 34)))
                (LETT |prec| (+ |obits| 20))
                (LETT |oz| (SPADCALL |nz| (QREFELT $ 40)))
                (EXIT
                 (COND
                  ((> (INTEGER-LENGTH |prec|) 500)
                   (|error| "reqested too high precision"))
                  (#4='T
                   (SEQ
                    (COND
                     ((< |oz| 1000)
                      (SEQ
                       (EXIT
                        (SEQ
                         (LETT |dnz|
                               (SPADCALL (SPADCALL |nz| (QREFELT $ 42))
                                         (QREFELT $ 64)))
                         (LETT |sp|
                               (SPADCALL |prec|
                                         (SPADCALL
                                          (SPADCALL 694 1000 (QREFELT $ 43))
                                          (QREFELT $ 44))
                                         (QREFELT $ 46)))
                         (EXIT
                          (COND
                           ((SPADCALL |sp| |dnz| (QREFELT $ 47))
                            (PROGN
                             (LETT #1#
                                   (SEQ
                                    (LETT |npf|
                                          (|add_DF|
                                           (|mul_DF|
                                            (SPADCALL
                                             (SPADCALL 2000 693 (QREFELT $ 43))
                                             (QREFELT $ 44))
                                            |dnz|)
                                           (FLOAT |prec|
                                                  MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |np|
                                          (SPADCALL
                                           (SPADCALL |npf| (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (LETT |nf|
                                          (|add_DF|
                                           (|mul_DF| (|exp_DF| 1.0) |dnz|)
                                           |sp|))
                                    (LETT |n|
                                          (SPADCALL
                                           (SPADCALL
                                            (|div_DF| |nf|
                                                      (FLOAT 2
                                                             MOST-POSITIVE-DOUBLE-FLOAT))
                                            (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (SPADCALL |np| (QREFELT $ 14))
                                    (LETT |res|
                                          (|FLIOUFUN;ci_series| |z| |n| $))
                                    (SPADCALL |obits| (QREFELT $ 14))
                                    (EXIT
                                     (PROGN
                                      (LETT #2#
                                            (SPADCALL
                                             (SPADCALL |res|
                                                       (SPADCALL
                                                        (QREFELT $ 19))
                                                       (QREFELT $ 29))
                                             (SPADCALL |z| (QREFELT $ 65))
                                             (QREFELT $ 29)))
                                      (GO #5=#:G849)))))
                             (GO #6=#:G845)))))))
                       #6# (EXIT #1#))))
                    (SPADCALL |prec| (QREFELT $ 14))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |z| (QREFELT $ 50))
                                 (|spadConstant| $ 7) (QREFELT $ 36))
                       (|FLIOUFUN;ci_asymptotic| |z| (+ |obits| 5) $))
                      (#4#
                       (SEQ (LETT |pi_fac| (SPADCALL (QREFELT $ 30)))
                            (EXIT
                             (COND
                              ((SPADCALL (SPADCALL |z| (QREFELT $ 55))
                                         (|spadConstant| $ 7) (QREFELT $ 66))
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 7)
                                          (SPADCALL |pi_fac| (QREFELT $ 18))
                                          (QREFELT $ 13))
                                (|FLIOUFUN;ci_asymptotic| |z| (+ |obits| 5) $)
                                (QREFELT $ 29)))
                              (#4#
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 7) |pi_fac|
                                          (QREFELT $ 13))
                                (|FLIOUFUN;ci_asymptotic| |z| (+ |obits| 5) $)
                                (QREFELT $ 29)))))))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FLIOUFUN;Ci;2C;29|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                    (EXIT
                     (|finally| (|FLIOUFUN;ci_z| |z| $)
                                (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;Ci;2F;30| ((|x| (|Float|)) ($ (|Float|)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 68))
          (|error| "Ci: x <= 0"))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 13))
                     (QREFELT $ 72))
           (QREFELT $ 50))))) 

(SDEFUN |FLIOUFUN;Chi;2C;31|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL (|spadConstant| $ 7) (|spadConstant| $ 15)
                      (QREFELT $ 13))
            |z| (QREFELT $ 20))
           (QREFELT $ 72))
          (SPADCALL |z| (QREFELT $ 65)) (QREFELT $ 29))
         (SPADCALL
          (SPADCALL
           (SPADCALL (|spadConstant| $ 7) (|spadConstant| $ 15) (QREFELT $ 13))
           |z| (QREFELT $ 20))
          (QREFELT $ 65))
         (QREFELT $ 51))) 

(SDEFUN |FLIOUFUN;Chi;2F;32| ((|x| (|Float|)) ($ (|Float|)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 68))
          (|error| "Chi: x <= 0"))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 13))
                     (QREFELT $ 74))
           (QREFELT $ 50))))) 

(SDEFUN |FLIOUFUN;si_series|
        ((|z| #1=(|Complex| (|Float|))) (|n| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|tk| #1#) (|k2| (|NonNegativeInteger|))
          (|res| (|Complex| (|Float|))) (|term| (|Complex| (|Float|)))
          (|k1| (|NonNegativeInteger|)) (#2=#:G862 NIL) (|i| NIL)
          (|z2| (|Complex| (|Float|))))
         (SEQ (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 20))) (LETT |tk| |z|)
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 0) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |k1| (+ (* 2 |i|) 1))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 15)
                                         (SPADCALL |k1| (QREFELT $ 23))
                                         (QREFELT $ 26))
                               |tk| (QREFELT $ 28)))
                        (LETT |res| (SPADCALL |res| |term| (QREFELT $ 29)))
                        (LETT |k2| (* (+ (* 2 |i|) 2) (+ (* 2 |i|) 3)))
                        (EXIT
                         (LETT |tk|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 15)
                                            (SPADCALL |k2| (QREFELT $ 23))
                                            (QREFELT $ 26))
                                  (QREFELT $ 18))
                                 |z2| (QREFELT $ 28))
                                |tk| (QREFELT $ 20)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FLIOUFUN;si_asymptotic|
        ((|z| (|Complex| (|Float|))) (|prec| (|Integer|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|term| (|Complex| (|Float|))) (|res_s| #1=(|Complex| (|Float|)))
          (|res_c| #1#) (|k| NIL) (|z_inv| (|Complex| (|Float|)))
          (|eps| (|Float|)))
         (SEQ (LETT |eps| (SPADCALL 1 (- (* 2 |prec|)) 2 (QREFELT $ 32)))
              (LETT |z_inv|
                    (SPADCALL (|spadConstant| $ 27) |z| (QREFELT $ 33)))
              (LETT |term| (|spadConstant| $ 27))
              (LETT |res_c| (|spadConstant| $ 21))
              (LETT |res_s| (|spadConstant| $ 21))
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |term| (QREFELT $ 34)) |eps|
                                (QREFELT $ 36)))
                     (GO G191)))
                   (SEQ (LETT |res_c| (SPADCALL |res_c| |term| (QREFELT $ 29)))
                        (LETT |term|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (+ (* 2 |k|) 1) (QREFELT $ 23))
                                |z_inv| (QREFELT $ 28))
                               |term| (QREFELT $ 20)))
                        (LETT |res_s| (SPADCALL |res_s| |term| (QREFELT $ 29)))
                        (EXIT
                         (LETT |term|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (+ (* 2 |k|) 2) (QREFELT $ 23))
                                  |z_inv| (QREFELT $ 28))
                                 |term| (QREFELT $ 20))
                                (QREFELT $ 37)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |z_inv|
                         (SPADCALL
                          (SPADCALL (SPADCALL |z| (QREFELT $ 58)) |res_c|
                                    (QREFELT $ 20))
                          (SPADCALL (SPADCALL |z| (QREFELT $ 59)) |res_s|
                                    (QREFELT $ 20))
                          (QREFELT $ 29))
                         (QREFELT $ 20)))))) 

(SDEFUN |FLIOUFUN;si_z| ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|pi_fac| (|Float|)) (#1=#:G873 NIL) (#2=#:G874 NIL)
          (|res| (|Complex| (|Float|))) (|n| (|Integer|))
          (|nf| #3=(|DoubleFloat|)) (|np| (|PositiveInteger|)) (|npf| #3#)
          (|sp| (|DoubleFloat|)) (|dnz| (|DoubleFloat|)) (|oz| (|Integer|))
          (|prec| (|PositiveInteger|)) (|nz| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                (LETT |nz| (SPADCALL |z| (QREFELT $ 34)))
                (LETT |prec| (+ |obits| 20))
                (LETT |oz| (SPADCALL |nz| (QREFELT $ 40)))
                (EXIT
                 (COND
                  ((> (INTEGER-LENGTH |prec|) 500)
                   (|error| "reqested too high precision"))
                  (#4='T
                   (SEQ
                    (COND
                     ((< |oz| 1000)
                      (SEQ
                       (EXIT
                        (SEQ
                         (LETT |dnz|
                               (SPADCALL (SPADCALL |nz| (QREFELT $ 42))
                                         (QREFELT $ 64)))
                         (LETT |sp|
                               (SPADCALL |prec|
                                         (SPADCALL
                                          (SPADCALL 694 1000 (QREFELT $ 43))
                                          (QREFELT $ 44))
                                         (QREFELT $ 46)))
                         (EXIT
                          (COND
                           ((SPADCALL |sp| |dnz| (QREFELT $ 47))
                            (PROGN
                             (LETT #1#
                                   (SEQ
                                    (LETT |npf|
                                          (|add_DF|
                                           (|mul_DF|
                                            (SPADCALL
                                             (SPADCALL 2000 693 (QREFELT $ 43))
                                             (QREFELT $ 44))
                                            |dnz|)
                                           (FLOAT |prec|
                                                  MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |np|
                                          (SPADCALL
                                           (SPADCALL |npf| (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (LETT |nf|
                                          (|add_DF|
                                           (|mul_DF| (|exp_DF| 1.0) |dnz|)
                                           |sp|))
                                    (LETT |n|
                                          (SPADCALL
                                           (SPADCALL
                                            (|div_DF| |nf|
                                                      (FLOAT 2
                                                             MOST-POSITIVE-DOUBLE-FLOAT))
                                            (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (SPADCALL |np| (QREFELT $ 14))
                                    (LETT |res|
                                          (|FLIOUFUN;si_series| |z| |n| $))
                                    (SPADCALL |obits| (QREFELT $ 14))
                                    (EXIT
                                     (PROGN (LETT #2# |res|) (GO #5=#:G872)))))
                             (GO #6=#:G869)))))))
                       #6# (EXIT #1#))))
                    (SPADCALL |prec| (QREFELT $ 14))
                    (LETT |pi_fac|
                          (SPADCALL (SPADCALL (QREFELT $ 30))
                                    (SPADCALL 2 (QREFELT $ 23))
                                    (QREFELT $ 26)))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |z| (QREFELT $ 50))
                                 (|spadConstant| $ 7) (QREFELT $ 36))
                       (SPADCALL
                        (SPADCALL |pi_fac| (|spadConstant| $ 7) (QREFELT $ 13))
                        (|FLIOUFUN;si_asymptotic| |z| (+ |obits| 5) $)
                        (QREFELT $ 51)))
                      (#4#
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL |pi_fac| (|spadConstant| $ 7)
                                   (QREFELT $ 13))
                         (|FLIOUFUN;si_asymptotic|
                          (SPADCALL |z| (QREFELT $ 37)) (+ |obits| 5) $)
                         (QREFELT $ 51))
                        (QREFELT $ 37)))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FLIOUFUN;Si;2C;36|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ (LETT |obits| (SPADCALL (QREFELT $ 10)))
                    (EXIT
                     (|finally| (|FLIOUFUN;si_z| |z| $)
                                (SPADCALL |obits| (QREFELT $ 14))))))) 

(SDEFUN |FLIOUFUN;Si;2F;37| ((|z| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |z| (|spadConstant| $ 7) (QREFELT $ 13))
                   (QREFELT $ 76))
         (QREFELT $ 50))) 

(SDEFUN |FLIOUFUN;Shi;2C;38|
        ((|z| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPADCALL
         (SPADCALL
          (SPADCALL (|spadConstant| $ 7) (|spadConstant| $ 15) (QREFELT $ 13))
          (SPADCALL
           (SPADCALL
            (SPADCALL (|spadConstant| $ 7) (|spadConstant| $ 15)
                      (QREFELT $ 13))
            |z| (QREFELT $ 20))
           (QREFELT $ 76))
          (QREFELT $ 20))
         (QREFELT $ 37))) 

(SDEFUN |FLIOUFUN;Shi;2F;39| ((|x| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 13))
                   (QREFELT $ 78))
         (QREFELT $ 50))) 

(DECLAIM (NOTINLINE |FloatLiouvilianFunctions;|)) 

(DEFUN |FloatLiouvilianFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G881)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FloatLiouvilianFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FloatLiouvilianFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|FloatLiouvilianFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|FloatLiouvilianFunctions|)))))))))) 

(DEFUN |FloatLiouvilianFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FloatLiouvilianFunctions|))
          (LETT $ (GETREFV 80))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FloatLiouvilianFunctions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (CONS -1 (|spadConstant| $ 7)))
          $))) 

(MAKEPROP '|FloatLiouvilianFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Float|) (0 . |Zero|) 'G
              (|PositiveInteger|) (4 . |bits|) (8 . |precision|) (|Complex| 6)
              (12 . |complex|) (18 . |bits|) (23 . |One|)
              (|FloatSpecialFunctions|) (27 . |digamma|) (32 . -)
              |FLIOUFUN;gamma;C;1| (37 . *) (43 . |Zero|) (|Integer|)
              (47 . |coerce|) (|Fraction| 22) (52 . |One|) (56 . /)
              (62 . |One|) (66 . *) (72 . +) (78 . |pi|) (82 . |sqrt|)
              (87 . |float|) (94 . /) (100 . |norm|) (|Boolean|) (105 . >)
              (111 . -) (116 . |exp|) (121 . *) (127 . |order|) (|DoubleFloat|)
              (132 . |coerce|) (137 . /) (143 . |coerce|)
              (|NonNegativeInteger|) (148 . *) (154 . >) (160 . |round|)
              (165 . |retract|) (170 . |real|) (175 . -) |FLIOUFUN;erf;2C;5|
              |FLIOUFUN;erf;2F;6| |FLIOUFUN;erfi;2C;7| (181 . |imag|)
              |FLIOUFUN;erfi;2F;8| (186 . |coerce|) (191 . |cos|) (196 . |sin|)
              |FLIOUFUN;fresnelC;2C;12| |FLIOUFUN;fresnelC;2F;13|
              |FLIOUFUN;fresnelS;2C;17| |FLIOUFUN;fresnelS;2F;18|
              (201 . |sqrt|) (206 . |log|) (211 . <) |FLIOUFUN;Ei;2C;22|
              (217 . <=) |FLIOUFUN;Ei;2F;23| |FLIOUFUN;li;2C;24|
              |FLIOUFUN;li;2F;25| |FLIOUFUN;Ci;2C;29| |FLIOUFUN;Ci;2F;30|
              |FLIOUFUN;Chi;2C;31| |FLIOUFUN;Chi;2F;32| |FLIOUFUN;Si;2C;36|
              |FLIOUFUN;Si;2F;37| |FLIOUFUN;Shi;2C;38| |FLIOUFUN;Shi;2F;39|)
           '#(|li| 223 |gamma| 233 |fresnelS| 237 |fresnelC| 247 |erfi| 257
              |erf| 267 |Si| 277 |Shi| 287 |Ei| 297 |Ci| 307 |Chi| 317)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|gamma| ((|Complex| (|Float|)))) T)
                                   '((|erf| ((|Float|) (|Float|))) T)
                                   '((|erf|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|erfi| ((|Float|) (|Float|))) T)
                                   '((|erfi|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|fresnelC| ((|Float|) (|Float|))) T)
                                   '((|fresnelC|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|fresnelS| ((|Float|) (|Float|))) T)
                                   '((|fresnelS|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|Ei| ((|Float|) (|Float|))) T)
                                   '((|Ei|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|li| ((|Float|) (|Float|))) T)
                                   '((|li|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|Ci| ((|Float|) (|Float|))) T)
                                   '((|Ci|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|Si| ((|Float|) (|Float|))) T)
                                   '((|Si|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|Chi| ((|Float|) (|Float|))) T)
                                   '((|Chi|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T)
                                   '((|Shi| ((|Float|) (|Float|))) T)
                                   '((|Shi|
                                      ((|Complex| (|Float|))
                                       (|Complex| (|Float|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 79
                                            '(0 6 0 7 0 6 9 10 0 6 9 11 2 12 0
                                              6 6 13 1 6 9 9 14 0 6 0 15 1 16 6
                                              6 17 1 6 0 0 18 2 12 0 0 0 20 0
                                              12 0 21 1 6 0 22 23 0 24 0 25 2 6
                                              0 0 0 26 0 12 0 27 2 12 0 6 0 28
                                              2 12 0 0 0 29 0 6 0 30 1 6 0 0 31
                                              3 6 0 22 22 9 32 2 12 0 0 0 33 1
                                              12 6 0 34 2 6 35 0 0 36 1 12 0 0
                                              37 1 12 0 0 38 2 12 0 0 6 39 1 6
                                              22 0 40 1 6 41 0 42 2 24 0 22 22
                                              43 1 41 0 24 44 2 41 0 45 0 46 2
                                              41 35 0 0 47 1 41 0 0 48 1 41 22
                                              0 49 1 12 6 0 50 2 12 0 0 0 51 1
                                              12 6 0 55 1 6 0 24 57 1 12 0 0 58
                                              1 12 0 0 59 1 41 0 0 64 1 12 0 0
                                              65 2 6 35 0 0 66 2 6 35 0 0 68 1
                                              0 6 6 71 1 0 12 12 70 0 0 12 19 1
                                              0 6 6 63 1 0 12 12 62 1 0 12 12
                                              60 1 0 6 6 61 1 0 12 12 54 1 0 6
                                              6 56 1 0 6 6 53 1 0 12 12 52 1 0
                                              6 6 77 1 0 12 12 76 1 0 12 12 78
                                              1 0 6 6 79 1 0 6 6 69 1 0 12 12
                                              67 1 0 12 12 72 1 0 6 6 73 1 0 6
                                              6 75 1 0 12 12 74)))))
           '|lookupComplete|)) 

(MAKEPROP '|FloatLiouvilianFunctions| 'NILADIC T) 
