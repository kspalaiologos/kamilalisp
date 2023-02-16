
(SDEFUN |COMPCAT-;characteristicPolynomial;SSup;1|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG ((|v| (|SparseUnivariatePolynomial| R)))
               (SEQ (LETT |v| (SPADCALL (|spadConstant| $ 9) 1 (QREFELT $ 12)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |v| 2 (QREFELT $ 14))
                                (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                          (SPADCALL |v| 1 (QREFELT $ 16))
                                          (QREFELT $ 17))
                                (QREFELT $ 18))
                      (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                (SPADCALL |v| 0 (QREFELT $ 16)) (QREFELT $ 17))
                      (QREFELT $ 22)))))) 

(SDEFUN |COMPCAT-;myNextPrime| ((|x| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPROG ((|xr| (R)))
               (SEQ
                (LETT |xr|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 24))
                                (SPADCALL 4 (QREFELT $ 26)) (QREFELT $ 27)))
                (SEQ G190
                     (COND
                      ((NULL (NULL (SPADCALL |xr| (QREFELT $ 29)))) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |xr|
                             (SPADCALL |xr| (SPADCALL 4 (QREFELT $ 26))
                                       (QREFELT $ 27)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |xr| (|spadConstant| $ 21) (QREFELT $ 30)))))) 

(SDEFUN |COMPCAT-;solveLinearPolynomialEquation;LSupU;3|
        ((|lp| (|List| (|SparseUnivariatePolynomial| S)))
         (|p| (|SparseUnivariatePolynomial| S))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPADCALL |lp| |p| (QREFELT $ 35))) 

(SDEFUN |COMPCAT-;normPolynomial|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|SparseUnivariatePolynomial| R)))
        (SPADCALL (ELT $ 40)
                  (SPADCALL |pp| (SPADCALL (ELT $ 41) |pp| (QREFELT $ 43))
                            (QREFELT $ 44))
                  (QREFELT $ 47))) 

(SDEFUN |COMPCAT-;factorPolynomial;SupF;5|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPADCALL (SPADCALL |pp| (QREFELT $ 49)) (ELT $ 51) (QREFELT $ 55))) 

(SDEFUN |COMPCAT-;factorSquareFreePolynomial;SupF;6|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPROG
         ((#1=#:G808 NIL)
          (|lF|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| S))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|p2| (|SparseUnivariatePolynomial| S))
          (|p1| (|SparseUnivariatePolynomial| S)) (#2=#:G815 NIL) (|u| NIL)
          (|fR| (|Factored| (|SparseUnivariatePolynomial| R)))
          (|pnorm| (|SparseUnivariatePolynomial| R)) (|k| (R)))
         (SEQ (LETT |pnorm| (|COMPCAT-;normPolynomial| |pp| $))
              (LETT |k| (|spadConstant| $ 21))
              (SEQ G190
                   (COND
                    ((NULL
                      (>
                       (SPADCALL
                        (SPADCALL |pnorm| (SPADCALL |pnorm| (QREFELT $ 57))
                                  (QREFELT $ 58))
                        (QREFELT $ 59))
                       0))
                     (GO G191)))
                   (SEQ
                    (LETT |k|
                          (SPADCALL |k| (|spadConstant| $ 9) (QREFELT $ 60)))
                    (EXIT
                     (LETT |pnorm|
                           (|COMPCAT-;normPolynomial|
                            (SPADCALL |pp|
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 8) 1
                                                 (QREFELT $ 61))
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 21) |k|
                                                  (QREFELT $ 30))
                                        0 (QREFELT $ 61))
                                       (QREFELT $ 62))
                                      (QREFELT $ 63))
                            $))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |fR| (SPADCALL |pnorm| (QREFELT $ 64)))
              (EXIT
               (COND
                ((EQL (SPADCALL |fR| (QREFELT $ 66)) 1)
                 (SPADCALL (|spadConstant| $ 67)
                           (LIST (VECTOR (CONS 2 "irred") |pp| 1))
                           (QREFELT $ 71)))
                ('T
                 (SEQ (LETT |lF| NIL)
                      (SEQ (LETT |u| NIL)
                           (LETT #2# (SPADCALL |fR| (QREFELT $ 74))) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |u| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |p1|
                                  (SPADCALL (ELT $ 75) (QVELT |u| 1)
                                            (QREFELT $ 78)))
                            (COND
                             ((NULL (SPADCALL |k| (QREFELT $ 79)))
                              (LETT |p1|
                                    (SPADCALL |p1|
                                              (SPADCALL
                                               (SPADCALL (|spadConstant| $ 8) 1
                                                         (QREFELT $ 61))
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 21)
                                                          |k| (QREFELT $ 30))
                                                0 (QREFELT $ 61))
                                               (QREFELT $ 80))
                                              (QREFELT $ 63)))))
                            (LETT |p2| (SPADCALL |p1| |pp| (QREFELT $ 81)))
                            (LETT |lF|
                                  (CONS (VECTOR (CONS 2 "irred") |p2| 1) |lF|))
                            (EXIT
                             (LETT |pp|
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL |pp| |p2|
                                                       (QREFELT $ 83)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (|SparseUnivariatePolynomial|
                                                      (QREFELT $ 6))
                                                     (|Union|
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 6))
                                                      "failed")
                                                     #1#)))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL |pp| |lF| (QREFELT $ 71)))))))))) 

(SDEFUN |COMPCAT-;factor;SF;7| ((|x| (S)) ($ (|Factored| S)))
        (SPROG
         ((|z| (|Factored| (|Complex| (|Integer|))))
          (|y| (|Complex| (|Integer|))))
         (SEQ
          (LETT |y|
                (SPADCALL
                 (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 85))
                 (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 85))
                 (QREFELT $ 88)))
          (LETT |z| (SPADCALL |y| (QREFELT $ 91)))
          (EXIT
           (SPADCALL (CONS #'|COMPCAT-;factor;SF;7!0| $) |z| (QREFELT $ 97)))))) 

(SDEFUN |COMPCAT-;factor;SF;7!0| ((|f| NIL) ($ NIL))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 92)) (QREFELT $ 26))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 93)) (QREFELT $ 26))
                  (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;squareFree;SF;8| ((|x| (S)) ($ (|Factored| S)))
        (SPADCALL |x| (QREFELT $ 99))) 

(SDEFUN |COMPCAT-;prime?;SB;9| ((|x| (S)) ($ (|Boolean|)))
        (SPROG ((|y| (|Complex| (|Integer|))))
               (SEQ
                (LETT |y|
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 85))
                       (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 85))
                       (QREFELT $ 88)))
                (EXIT (SPADCALL |y| (QREFELT $ 101)))))) 

(PUT '|COMPCAT-;rank;Pi;10| '|SPADreplace| '(XLAM NIL 2)) 

(SDEFUN |COMPCAT-;rank;Pi;10| (($ (|PositiveInteger|))) 2) 

(SDEFUN |COMPCAT-;discriminant;R;11| (($ (R)))
        (SPADCALL (SPADCALL 4 (QREFELT $ 26)) (QREFELT $ 104))) 

(SDEFUN |COMPCAT-;norm;SR;12| ((|x| (S)) ($ (R)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) 2 (QREFELT $ 106))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) 2 (QREFELT $ 106))
                  (QREFELT $ 60))) 

(SDEFUN |COMPCAT-;trace;SR;13| ((|x| (S)) ($ (R)))
        (SPADCALL 2 (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 108))) 

(SDEFUN |COMPCAT-;imaginary;S;14| (($ (S)))
        (SPADCALL (|spadConstant| $ 21) (|spadConstant| $ 9) (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;conjugate;2S;15| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 24))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 104))
                  (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;characteristic;Nni;16| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 112))) 

(SDEFUN |COMPCAT-;map;M2S;17| ((|fn| (|Mapping| R R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) |fn|) (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;=;2SB;18| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 24)) (SPADCALL |y| (QREFELT $ 24))
                    (QREFELT $ 116))
          (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (SPADCALL |y| (QREFELT $ 86))
                    (QREFELT $ 116)))
         ('T NIL))) 

(SDEFUN |COMPCAT-;+;3S;19| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (SPADCALL |y| (QREFELT $ 24))
                   (QREFELT $ 60))
         (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (SPADCALL |y| (QREFELT $ 86))
                   (QREFELT $ 60))
         (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;-;2S;20| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 104))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 104))
                  (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;*;R2S;21| ((|r| (R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |r| (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 120))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 120))
                  (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;coordinates;SV;22| ((|x| (S)) ($ (|Vector| R)))
        (VECTOR (SPADCALL |x| (QREFELT $ 24)) (SPADCALL |x| (QREFELT $ 86)))) 

(SDEFUN |COMPCAT-;*;I2S;23| ((|n| (|Integer|)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |n| (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 124))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 124))
                  (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;differentiate;SMS;24|
        ((|x| (S)) (|d| (|Mapping| R R)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |d|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) |d|) (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;definingPolynomial;Sup;25|
        (($ (|SparseUnivariatePolynomial| R)))
        (SPADCALL (SPADCALL (|spadConstant| $ 9) 2 (QREFELT $ 12))
                  (SPADCALL (|spadConstant| $ 9) 0 (QREFELT $ 12))
                  (QREFELT $ 22))) 

(SDEFUN |COMPCAT-;reduce;SupS;26|
        ((|pol| (|SparseUnivariatePolynomial| R)) ($ (S)))
        (SPROG ((|part| (|SparseUnivariatePolynomial| R)))
               (SEQ
                (LETT |part|
                      (QCDR
                       (SPADCALL |pol| (SPADCALL (QREFELT $ 128))
                                 (QREFELT $ 130))))
                (EXIT
                 (SPADCALL (SPADCALL |part| 0 (QREFELT $ 131))
                           (SPADCALL |part| 1 (QREFELT $ 131))
                           (QREFELT $ 30)))))) 

(SDEFUN |COMPCAT-;lift;SSup;27|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) 0 (QREFELT $ 12))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) 1 (QREFELT $ 12))
                  (QREFELT $ 22))) 

(SDEFUN |COMPCAT-;minimalPolynomial;SSup;28|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79))
          (SPADCALL (SPADCALL (|spadConstant| $ 9) 1 (QREFELT $ 12))
                    (SPADCALL (SPADCALL |x| (QREFELT $ 24)) 0 (QREFELT $ 12))
                    (QREFELT $ 18)))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL (|spadConstant| $ 9) 2 (QREFELT $ 12))
                     (SPADCALL (SPADCALL |x| (QREFELT $ 15)) 1 (QREFELT $ 12))
                     (QREFELT $ 18))
           (SPADCALL (SPADCALL |x| (QREFELT $ 19)) 0 (QREFELT $ 12))
           (QREFELT $ 22))))) 

(SDEFUN |COMPCAT-;coordinates;SVV;29|
        ((|x| (S)) (|v| (|Vector| S)) ($ (|Vector| R)))
        (SPROG
         ((|ix| (R)) (|rx| (R)) (#1=#:G862 NIL) (|d| (|Union| R "failed"))
          (|ia| (R)) (|ib| (R)) (|rb| (R)) (|b| (S)) (|ra| (R)) (|a| (S)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ra|
                  (SPADCALL
                   (LETT |a|
                         (SPADCALL |v| (SPADCALL |v| (QREFELT $ 136))
                                   (QREFELT $ 137)))
                   (QREFELT $ 24)))
            (LETT |rb|
                  (SPADCALL
                   (LETT |b| (SPADCALL |v| (QVSIZE |v|) (QREFELT $ 137)))
                   (QREFELT $ 24)))
            (COND
             ((SPADCALL (QVSIZE |v|) 2 (QREFELT $ 138))
              (EXIT (|error| #2="coordinates: vector is not a basis")))
             ('T
              (SEQ
               (LETT |d|
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL |ra| (LETT |ib| (SPADCALL |b| (QREFELT $ 86)))
                                 (QREFELT $ 120))
                       (SPADCALL (LETT |ia| (SPADCALL |a| (QREFELT $ 86))) |rb|
                                 (QREFELT $ 120))
                       (QREFELT $ 27))
                      (QREFELT $ 139)))
               (EXIT
                (COND
                 ((QEQCAR |d| 1)
                  (PROGN (LETT #1# (|error| #2#)) (GO #3=#:G860))))))))
            (LETT |rx| (SPADCALL |x| (QREFELT $ 24)))
            (LETT |ix| (SPADCALL |x| (QREFELT $ 86)))
            (EXIT
             (VECTOR
              (SPADCALL (QCDR |d|)
                        (SPADCALL (SPADCALL |rx| |ib| (QREFELT $ 120))
                                  (SPADCALL |ix| |rb| (QREFELT $ 120))
                                  (QREFELT $ 27))
                        (QREFELT $ 120))
              (SPADCALL (QCDR |d|)
                        (SPADCALL (SPADCALL |ra| |ix| (QREFELT $ 120))
                                  (SPADCALL |ia| |rx| (QREFELT $ 120))
                                  (QREFELT $ 27))
                        (QREFELT $ 120))))))
          #3# (EXIT #1#)))) 

(SDEFUN |COMPCAT-;coerce;SOf;30| ((|x| (S)) ($ (|OutputForm|)))
        (SPROG
         ((|ip| #1=(|OutputForm|)) (|outi| #1#) (|ie| (|OutputForm|)) (|i| (R))
          (|re| (|OutputForm|)) (|r| (R)))
         (SEQ
          (LETT |re|
                (SPADCALL (LETT |r| (SPADCALL |x| (QREFELT $ 24)))
                          (QREFELT $ 143)))
          (LETT |ie|
                (SPADCALL (LETT |i| (SPADCALL |x| (QREFELT $ 86)))
                          (QREFELT $ 143)))
          (EXIT
           (COND ((SPADCALL |i| (QREFELT $ 79)) |re|)
                 (#2='T
                  (SEQ (LETT |outi| (SPADCALL '|%i| (QREFELT $ 145)))
                       (LETT |ip|
                             (COND
                              ((SPADCALL |i| (|spadConstant| $ 9)
                                         (QREFELT $ 116))
                               |outi|)
                              ((SPADCALL (SPADCALL |i| (QREFELT $ 104))
                                         (|spadConstant| $ 9) (QREFELT $ 116))
                               (SPADCALL |outi| (QREFELT $ 146)))
                              (#2# (SPADCALL |ie| |outi| (QREFELT $ 147)))))
                       (EXIT
                        (COND ((SPADCALL |r| (QREFELT $ 79)) |ip|)
                              (#2#
                               (SPADCALL |re| |ip| (QREFELT $ 148)))))))))))) 

(SDEFUN |COMPCAT-;retract;SR;31| ((|x| (S)) ($ (R)))
        (COND
         ((NULL (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79)))
          (|error| "Imaginary part is nonzero. Cannot retract."))
         ('T (SPADCALL |x| (QREFELT $ 24))))) 

(SDEFUN |COMPCAT-;retractIfCan;SU;32| ((|x| (S)) ($ (|Union| R "failed")))
        (COND
         ((NULL (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79)))
          (CONS 1 "failed"))
         ('T (CONS 0 (SPADCALL |x| (QREFELT $ 24)))))) 

(SDEFUN |COMPCAT-;*;3S;33| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (SPADCALL |y| (QREFELT $ 24))
                    (QREFELT $ 120))
          (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (SPADCALL |y| (QREFELT $ 86))
                    (QREFELT $ 120))
          (QREFELT $ 27))
         (SPADCALL
          (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (SPADCALL |y| (QREFELT $ 24))
                    (QREFELT $ 120))
          (SPADCALL (SPADCALL |y| (QREFELT $ 86)) (SPADCALL |x| (QREFELT $ 24))
                    (QREFELT $ 120))
          (QREFELT $ 60))
         (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;reducedSystem;MM;34| ((|m| (|Matrix| S)) ($ (|Matrix| R)))
        (SPADCALL (SPADCALL (ELT $ 24) |m| (QREFELT $ 157))
                  (SPADCALL (ELT $ 86) |m| (QREFELT $ 157)) (QREFELT $ 158))) 

(SDEFUN |COMPCAT-;reducedSystem;MVR;35|
        ((|m| (|Matrix| S)) (|v| (|Vector| S))
         ($ (|Record| (|:| |mat| (|Matrix| R)) (|:| |vec| (|Vector| R)))))
        (SPROG ((|rh| (|Matrix| R)))
               (SEQ
                (LETT |rh|
                      (SPADCALL (SPADCALL |v| (QREFELT $ 161))
                                (QREFELT $ 162)))
                (EXIT
                 (CONS (SPADCALL |m| (QREFELT $ 162))
                       (SPADCALL |rh| (PROGN |rh| 1) (QREFELT $ 163))))))) 

(SDEFUN |COMPCAT-;abs;2S;36| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 166))
                  (QREFELT $ 75))) 

(SDEFUN |COMPCAT-;convert;SC;37| ((|x| (S)) ($ (|Complex| (|DoubleFloat|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 169))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 169))
                  (QREFELT $ 171))) 

(SDEFUN |COMPCAT-;convert;SC;38| ((|x| (S)) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 174))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 174))
                  (QREFELT $ 176))) 

(SDEFUN |COMPCAT-;convert;SIf;39| ((|x| (S)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|complex| (QREFELT $ 179))
               (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 180))
               (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 180)))
         (QREFELT $ 182))) 

(SDEFUN |COMPCAT-;convert;SP;40| ((|x| (S)) ($ (|Pattern| (|Integer|))))
        (SPADCALL |x| (QREFELT $ 186))) 

(SDEFUN |COMPCAT-;convert;SP;41| ((|x| (S)) ($ (|Pattern| (|Float|))))
        (SPADCALL |x| (QREFELT $ 190))) 

(SDEFUN |COMPCAT-;patternMatch;SP2Pmr;42|
        ((|x| (S)) (|p| (|Pattern| (|Integer|)))
         (|l| (|PatternMatchResult| (|Integer|) S))
         ($ (|PatternMatchResult| (|Integer|) S)))
        (SPADCALL |x| |p| |l| (QREFELT $ 194))) 

(SDEFUN |COMPCAT-;patternMatch;SP2Pmr;43|
        ((|x| (S)) (|p| (|Pattern| (|Float|)))
         (|l| (|PatternMatchResult| (|Float|) S))
         ($ (|PatternMatchResult| (|Float|) S)))
        (SPADCALL |x| |p| |l| (QREFELT $ 199))) 

(SDEFUN |COMPCAT-;smaller?;2SB;44| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 24)) (SPADCALL |y| (QREFELT $ 24))
                    (QREFELT $ 116))
          (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (SPADCALL |y| (QREFELT $ 86))
                    (QREFELT $ 202)))
         ('T
          (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (SPADCALL |y| (QREFELT $ 24))
                    (QREFELT $ 202))))) 

(SDEFUN |COMPCAT-;rational?;SB;45| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79))) 

(SDEFUN |COMPCAT-;rational;SF;46| ((|x| (S)) ($ (|Fraction| (|Integer|))))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79))
          (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 206)))
         ('T (|error| "Not a rational number")))) 

(SDEFUN |COMPCAT-;rationalIfCan;SU;47|
        ((|x| (S)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79))
          (CONS 0 (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 206))))
         ('T (CONS 1 "failed")))) 

(SDEFUN |COMPCAT-;inv;2S;48| ((|x| (S)) ($ (S)))
        (SPROG ((|r| (R)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 79))
                  (SPADCALL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 210))
                   (QREFELT $ 75)))
                 ('T
                  (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 19)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |r|
                                   (QREFELT $ 211))
                         (SPADCALL
                          (SPADCALL (SPADCALL |x| (QREFELT $ 86)) |r|
                                    (QREFELT $ 211))
                          (QREFELT $ 104))
                         (QREFELT $ 30))))))))) 

(SDEFUN |COMPCAT-;exquo;SRU;49| ((|x| (S)) (|r| (R)) ($ (|Union| S "failed")))
        (SPROG ((|r2| #1=(|Union| R "failed")) (|r1| #1#))
               (SEQ
                (COND
                 ((SPADCALL |r| (|spadConstant| $ 9) (QREFELT $ 116))
                  (CONS 0 |x|))
                 (#2='T
                  (SEQ
                   (LETT |r1|
                         (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |r|
                                   (QREFELT $ 213)))
                   (EXIT
                    (COND ((QEQCAR |r1| 1) (CONS 1 "failed"))
                          (#2#
                           (SEQ
                            (LETT |r2|
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 86)) |r|
                                            (QREFELT $ 213)))
                            (EXIT
                             (COND ((QEQCAR |r2| 1) (CONS 1 "failed"))
                                   (#2#
                                    (CONS 0
                                          (SPADCALL (QCDR |r1|) (QCDR |r2|)
                                                    (QREFELT $
                                                             30)))))))))))))))) 

(SDEFUN |COMPCAT-;exquo;2SU;50| ((|x| (S)) (|y| (S)) ($ (|Union| S "failed")))
        (COND
         ((SPADCALL (SPADCALL |y| (QREFELT $ 86)) (QREFELT $ 79))
          (SPADCALL |x| (SPADCALL |y| (QREFELT $ 24)) (QREFELT $ 215)))
         ('T
          (SPADCALL
           (SPADCALL |x| (SPADCALL |y| (QREFELT $ 41)) (QREFELT $ 216))
           (SPADCALL |y| (QREFELT $ 19)) (QREFELT $ 215))))) 

(SDEFUN |COMPCAT-;recip;SU;51| ((|x| (S)) ($ (|Union| S "failed")))
        (SPADCALL (|spadConstant| $ 8) |x| (QREFELT $ 218))) 

(SDEFUN |COMPCAT-;unitNormal;SR;52|
        ((|x| (S))
         ($ (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
        (SPROG
         ((|c|
           (|Record| (|:| |unit| R) (|:| |canonical| R) (|:| |associate| R)))
          (|u| (|Union| S "failed")))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 220))
            (VECTOR (|spadConstant| $ 8) |x| (|spadConstant| $ 8)))
           (#1='T
            (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 221)))
                 (EXIT
                  (COND
                   ((QEQCAR |u| 0)
                    (VECTOR |x| (|spadConstant| $ 8) (QCDR |u|)))
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 79))
                    (SEQ
                     (LETT |c|
                           (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                     (QREFELT $ 223)))
                     (EXIT
                      (VECTOR
                       (SPADCALL (|spadConstant| $ 21) (QVELT |c| 0)
                                 (QREFELT $ 30))
                       (SPADCALL
                        (SPADCALL (QVELT |c| 2) (SPADCALL |x| (QREFELT $ 86))
                                  (QREFELT $ 120))
                        (QREFELT $ 75))
                       (SPADCALL (|spadConstant| $ 21)
                                 (SPADCALL (QVELT |c| 2) (QREFELT $ 104))
                                 (QREFELT $ 30))))))
                   (#1#
                    (SEQ
                     (LETT |c|
                           (SPADCALL (SPADCALL |x| (QREFELT $ 24))
                                     (QREFELT $ 223)))
                     (LETT |x| (SPADCALL (QVELT |c| 2) |x| (QREFELT $ 224)))
                     (EXIT
                      (COND
                       ((SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                  (|spadConstant| $ 21) (QREFELT $ 225))
                        (SEQ
                         (LETT |x|
                               (SPADCALL
                                (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                          (QREFELT $ 104))
                                (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 30)))
                         (EXIT
                          (VECTOR
                           (SPADCALL
                            (SPADCALL (QVELT |c| 0) (SPADCALL (QREFELT $ 226))
                                      (QREFELT $ 224))
                            (QREFELT $ 227))
                           |x|
                           (SPADCALL (QVELT |c| 2) (SPADCALL (QREFELT $ 226))
                                     (QREFELT $ 224))))))
                       (#1#
                        (VECTOR (SPADCALL (QVELT |c| 0) (QREFELT $ 75)) |x|
                                (SPADCALL (QVELT |c| 2)
                                          (QREFELT $ 75)))))))))))))))) 

(SDEFUN |COMPCAT-;unitNormal;SR;53|
        ((|x| (S))
         ($ (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
        (SPROG
         ((|c|
           (|Record| (|:| |unit| R) (|:| |canonical| R) (|:| |associate| R)))
          (|u| (|Union| S "failed")))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 220))
            (VECTOR (|spadConstant| $ 8) |x| (|spadConstant| $ 8)))
           (#1='T
            (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 221)))
                 (EXIT
                  (COND
                   ((QEQCAR |u| 0)
                    (VECTOR |x| (|spadConstant| $ 8) (QCDR |u|)))
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 79))
                    (SEQ
                     (LETT |c|
                           (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                     (QREFELT $ 223)))
                     (EXIT
                      (VECTOR
                       (SPADCALL (|spadConstant| $ 21) (QVELT |c| 0)
                                 (QREFELT $ 30))
                       (SPADCALL
                        (SPADCALL (QVELT |c| 2) (SPADCALL |x| (QREFELT $ 86))
                                  (QREFELT $ 120))
                        (QREFELT $ 75))
                       (SPADCALL (|spadConstant| $ 21)
                                 (SPADCALL (QVELT |c| 2) (QREFELT $ 104))
                                 (QREFELT $ 30))))))
                   (#1#
                    (SEQ
                     (LETT |c|
                           (SPADCALL (SPADCALL |x| (QREFELT $ 24))
                                     (QREFELT $ 223)))
                     (LETT |x| (SPADCALL (QVELT |c| 2) |x| (QREFELT $ 224)))
                     (EXIT
                      (VECTOR (SPADCALL (QVELT |c| 0) (QREFELT $ 75)) |x|
                              (SPADCALL (QVELT |c| 2)
                                        (QREFELT $ 75)))))))))))))) 

(SDEFUN |COMPCAT-;euclideanSize;SNni;54| ((|x| (S)) ($ (|NonNegativeInteger|)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 24)) 2 (QREFELT $ 106))
                   (SPADCALL (SPADCALL |x| (QREFELT $ 86)) 2 (QREFELT $ 106))
                   (QREFELT $ 60))
         (QREFELT $ 229))) 

(SDEFUN |COMPCAT-;rem;3S;55| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG ((|yr| (R)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |y| (QREFELT $ 86)) (QREFELT $ 79))
                  (SEQ (LETT |yr| (SPADCALL |y| (QREFELT $ 24)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |yr|
                                   (QREFELT $ 231))
                         (SPADCALL (SPADCALL |x| (QREFELT $ 86)) |yr|
                                   (QREFELT $ 231))
                         (QREFELT $ 30)))))
                 ('T (QCDR (SPADCALL |x| |y| (QREFELT $ 232)))))))) 

(SDEFUN |COMPCAT-;quo;3S;56| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG ((|xi| (R)) (|xr| (R)) (|yr| (R)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |y| (QREFELT $ 86)) (QREFELT $ 79))
                  (SEQ (LETT |yr| (SPADCALL |y| (QREFELT $ 24)))
                       (LETT |xr| (SPADCALL |x| (QREFELT $ 24)))
                       (LETT |xi| (SPADCALL |x| (QREFELT $ 86)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL |xr| (SPADCALL |xr| |yr| (QREFELT $ 231))
                                    (QREFELT $ 27))
                          |yr| (QREFELT $ 234))
                         (SPADCALL
                          (SPADCALL |xi| (SPADCALL |xi| |yr| (QREFELT $ 231))
                                    (QREFELT $ 27))
                          |yr| (QREFELT $ 234))
                         (QREFELT $ 30)))))
                 ('T (QCAR (SPADCALL |x| |y| (QREFELT $ 232)))))))) 

(SDEFUN |COMPCAT-;divide;2SR;57|
        ((|x| (S)) (|y| (S))
         ($ (|Record| (|:| |quotient| S) (|:| |remainder| S))))
        (SPROG
         ((#1=#:G985 NIL) (|y1| (S)) (|b| (R)) (|x2| (R)) (|a| (R)) (|x1| (R))
          (|xx| (S)) (|r| (R)))
         (SEQ (LETT |r| (SPADCALL |y| (QREFELT $ 19)))
              (LETT |y1| (SPADCALL |y| (QREFELT $ 41)))
              (LETT |xx| (SPADCALL |x| |y1| (QREFELT $ 216)))
              (LETT |x1|
                    (SPADCALL (SPADCALL |xx| (QREFELT $ 24)) |r|
                              (QREFELT $ 236)))
              (LETT |a| |x1|)
              (COND
               ((SPADCALL |x1| (|spadConstant| $ 21) (QREFELT $ 237))
                (COND
                 ((SPADCALL |r| (SPADCALL 2 |x1| (QREFELT $ 108))
                            (QREFELT $ 238))
                  (SEQ (LETT |a| (SPADCALL |x1| |r| (QREFELT $ 27)))
                       (EXIT
                        (COND
                         ((SPADCALL |x1| |a| (QREFELT $ 238))
                          (LETT |a| (SPADCALL |x1| |r| (QREFELT $ 60)))))))))))
              (LETT |x2|
                    (SPADCALL (SPADCALL |xx| (QREFELT $ 86)) |r|
                              (QREFELT $ 236)))
              (LETT |b| |x2|)
              (COND
               ((SPADCALL |x2| (|spadConstant| $ 21) (QREFELT $ 237))
                (COND
                 ((SPADCALL |r| (SPADCALL 2 |x2| (QREFELT $ 108))
                            (QREFELT $ 238))
                  (SEQ (LETT |b| (SPADCALL |x2| |r| (QREFELT $ 27)))
                       (EXIT
                        (COND
                         ((SPADCALL |x2| |b| (QREFELT $ 238))
                          (LETT |b| (SPADCALL |x2| |r| (QREFELT $ 60)))))))))))
              (LETT |y1|
                    (PROG2
                        (LETT #1#
                              (SPADCALL (SPADCALL |a| |b| (QREFELT $ 30)) |y1|
                                        (QREFELT $ 218)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                      (|Union| (QREFELT $ 6) #2="failed")
                                      #1#)))
              (EXIT
               (CONS
                (PROG2
                    (LETT #1#
                          (SPADCALL (SPADCALL |x| |y1| (QREFELT $ 239)) |y|
                                    (QREFELT $ 218)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                  (|Union| (QREFELT $ 6) #2#) #1#))
                |y1|))))) 

(SDEFUN |COMPCAT-;atan2loc| ((|x| (R)) (|y| (R)) ($ (R)))
        (SPROG ((|theta| (R)) (#1=#:G990 NIL) (|pi2| (R)) (|pi1| (R)))
               (SEQ (LETT |pi1| (SPADCALL (QREFELT $ 242)))
                    (LETT |pi2|
                          (SPADCALL |pi1| (QREFELT $ 241) (QREFELT $ 120)))
                    (EXIT
                     (COND
                      ((SPADCALL |x| (|spadConstant| $ 21) (QREFELT $ 116))
                       (COND
                        ((SPADCALL |y| (|spadConstant| $ 21) (QREFELT $ 243))
                         |pi2|)
                        (#2='T (SPADCALL |pi2| (QREFELT $ 104)))))
                      (#2#
                       (SEQ
                        (LETT |theta|
                              (SPADCALL
                               (SPADCALL |y|
                                         (PROG2
                                             (LETT #1#
                                                   (SPADCALL |x|
                                                             (QREFELT $ 139)))
                                             (QCDR #1#)
                                           (|check_union2| (QEQCAR #1# 0)
                                                           (QREFELT $ 7)
                                                           (|Union|
                                                            (QREFELT $ 7)
                                                            "failed")
                                                           #1#))
                                         (QREFELT $ 120))
                               (QREFELT $ 244)))
                        (EXIT
                         (COND
                          ((SPADCALL |x| (|spadConstant| $ 21) (QREFELT $ 243))
                           |theta|)
                          ((SPADCALL |y| (|spadConstant| $ 21) (QREFELT $ 243))
                           (SPADCALL |theta| |pi1| (QREFELT $ 60)))
                          (#2# (SPADCALL |theta| |pi1| (QREFELT $ 27)))))))))))) 

(SDEFUN |COMPCAT-;argument;SR;59| ((|x| (S)) ($ (R)))
        (|COMPCAT-;atan2loc| (SPADCALL |x| (QREFELT $ 24))
         (SPADCALL |x| (QREFELT $ 86)) $)) 

(SDEFUN |COMPCAT-;argument;SR;60| ((|x| (S)) ($ (R)))
        (SPROG ((#1=#:G990 NIL) (|x1| (R)) (|n1| (R)))
               (SEQ
                (LETT |n1|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 166)))
                (LETT |x1|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |n1|
                                (QREFELT $ 60)))
                (EXIT
                 (SPADCALL (SPADCALL 2 (QREFELT $ 26))
                           (SPADCALL
                            (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                      (PROG2
                                          (LETT #1#
                                                (SPADCALL |x1|
                                                          (QREFELT $ 139)))
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 "failed")
                                                        #1#))
                                      (QREFELT $ 120))
                            (QREFELT $ 244))
                           (QREFELT $ 120)))))) 

(SDEFUN |COMPCAT-;argument;SR;61| ((|x| (S)) ($ (R)))
        (SPROG ((#1=#:G990 NIL) (|x1| (R)) (|n1| (R)))
               (SEQ
                (LETT |n1|
                      (SPADCALL
                       (SPADCALL (QREFELT $ 241)
                                 (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                           (QREFELT $ 246))
                                 (QREFELT $ 120))
                       (QREFELT $ 247)))
                (LETT |x1|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |n1|
                                (QREFELT $ 60)))
                (EXIT
                 (SPADCALL (SPADCALL 2 (QREFELT $ 26))
                           (SPADCALL
                            (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                      (PROG2
                                          (LETT #1#
                                                (SPADCALL |x1|
                                                          (QREFELT $ 139)))
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 "failed")
                                                        #1#))
                                      (QREFELT $ 120))
                            (QREFELT $ 244))
                           (QREFELT $ 120)))))) 

(SDEFUN |COMPCAT-;pi;S;62| (($ (S)))
        (SPADCALL (SPADCALL (QREFELT $ 242)) (QREFELT $ 75))) 

(SDEFUN |COMPCAT-;exp;2S;63| ((|x| (S)) ($ (S)))
        (|c_to_s| (EXP (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;log;2S;64| ((|x| (S)) ($ (S)))
        (|c_to_s| (LOG (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;sin;2S;65| ((|x| (S)) ($ (S)))
        (|c_to_s| (SIN (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;cos;2S;66| ((|x| (S)) ($ (S)))
        (|c_to_s| (COS (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;tan;2S;67| ((|x| (S)) ($ (S)))
        (|c_to_s| (TAN (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;asin;2S;68| ((|x| (S)) ($ (S)))
        (|c_to_s| (ASIN (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;acos;2S;69| ((|x| (S)) ($ (S)))
        (|c_to_s| (ACOS (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;atan;2S;70| ((|x| (S)) ($ (S)))
        (SPROG ((|z| (S)))
               (SEQ
                (LETT |z|
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                 (|minus_DF| (SPADCALL |x| (QREFELT $ 24)))
                                 (QREFELT $ 30))
                       (QREFELT $ 256)))
                (EXIT
                 (SPADCALL (|minus_DF| (SPADCALL |z| (QREFELT $ 86)))
                           (SPADCALL |z| (QREFELT $ 24)) (QREFELT $ 30)))))) 

(SDEFUN |COMPCAT-;sinh;2S;71| ((|x| (S)) ($ (S)))
        (|c_to_s| (SINH (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;cosh;2S;72| ((|x| (S)) ($ (S)))
        (|c_to_s| (COSH (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;tanh;2S;73| ((|x| (S)) ($ (S)))
        (|c_to_s| (TANH (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;asinh;2S;74| ((|x| (S)) ($ (S)))
        (|c_to_s| (ASINH (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;acosh;2S;75| ((|x| (S)) ($ (S)))
        (|c_to_s| (ACOSH (|s_to_c| |x|)))) 

(SDEFUN |COMPCAT-;atanh;2S;76| ((|x| (S)) ($ (S)))
        (SPADCALL |x| (QREFELT $ 264))) 

(SDEFUN |COMPCAT-;atan;2S;77| ((|x| (S)) ($ (S)))
        (SPROG ((|ix| (S)))
               (SEQ
                (LETT |ix|
                      (SPADCALL (SPADCALL (QREFELT $ 226)) |x|
                                (QREFELT $ 216)))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL (QREFELT $ 226)) (QREFELT $ 241)
                             (QREFELT $ 266))
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 8) |ix| (QREFELT $ 267))
                     (QREFELT $ 268))
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 8) |ix| (QREFELT $ 239))
                     (QREFELT $ 268))
                    (QREFELT $ 239))
                   (QREFELT $ 216))
                  (QREFELT $ 227)))))) 

(SDEFUN |COMPCAT-;log;2S;78| ((|x| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 246))
                   (QREFELT $ 241) (QREFELT $ 120))
         (SPADCALL |x| (QREFELT $ 269)) (QREFELT $ 30))) 

(SDEFUN |COMPCAT-;exp;2S;79| ((|x| (S)) ($ (S)))
        (SPROG ((|e| (R)))
               (SEQ
                (LETT |e|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 247)))
                (EXIT
                 (SPADCALL
                  (SPADCALL |e|
                            (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                      (QREFELT $ 270))
                            (QREFELT $ 120))
                  (SPADCALL |e|
                            (SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                      (QREFELT $ 271))
                            (QREFELT $ 120))
                  (QREFELT $ 30)))))) 

(SDEFUN |COMPCAT-;cos;2S;80| ((|x| (S)) ($ (S)))
        (SPROG ((#1=#:G1022 NIL) (|e| (S)))
               (SEQ
                (LETT |e|
                      (SPADCALL
                       (SPADCALL (SPADCALL (QREFELT $ 226)) |x|
                                 (QREFELT $ 216))
                       (QREFELT $ 272)))
                (EXIT
                 (SPADCALL (QREFELT $ 241)
                           (SPADCALL |e|
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |e| (QREFELT $ 221)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (QREFELT $ 6)
                                                       (|Union| (QREFELT $ 6)
                                                                "failed")
                                                       #1#))
                                     (QREFELT $ 267))
                           (QREFELT $ 224)))))) 

(SDEFUN |COMPCAT-;sin;2S;81| ((|x| (S)) ($ (S)))
        (SPROG ((#1=#:G1027 NIL) (|e| (S)))
               (SEQ
                (LETT |e|
                      (SPADCALL
                       (SPADCALL (SPADCALL (QREFELT $ 226)) |x|
                                 (QREFELT $ 216))
                       (QREFELT $ 272)))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL (QREFELT $ 226)) (QREFELT $ 241)
                             (QREFELT $ 266))
                   (SPADCALL |e|
                             (PROG2 (LETT #1# (SPADCALL |e| (QREFELT $ 221)))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                               (|Union| (QREFELT $ 6) "failed")
                                               #1#))
                             (QREFELT $ 239))
                   (QREFELT $ 216))
                  (QREFELT $ 227)))))) 

(SDEFUN |COMPCAT-;asin;2S;82| ((|x| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL (QREFELT $ 226))
                   (SPADCALL
                    (SPADCALL (SPADCALL (QREFELT $ 226)) |x| (QREFELT $ 216))
                    (QREFELT $ 273))
                   (QREFELT $ 216))
         (QREFELT $ 227))) 

(SDEFUN |COMPCAT-;acos;2S;83| ((|x| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL (QREFELT $ 226))
                   (SPADCALL
                    (SPADCALL |x|
                              (SPADCALL (SPADCALL (QREFELT $ 226))
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 8)
                                                   (SPADCALL |x| 2
                                                             (QREFELT $ 274))
                                                   (QREFELT $ 239))
                                         (QREFELT $ 275))
                                        (QREFELT $ 216))
                              (QREFELT $ 267))
                    (QREFELT $ 268))
                   (QREFELT $ 216))
         (QREFELT $ 227))) 

(SDEFUN |COMPCAT-;acos;2S;84| ((|x| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL (QREFELT $ 242)) (QREFELT $ 241) (QREFELT $ 120))
          (QREFELT $ 75))
         (SPADCALL |x| (QREFELT $ 276)) (QREFELT $ 239))) 

(SDEFUN |COMPCAT-;polarCoordinates;SR;85|
        ((|x| (S)) ($ (|Record| (|:| |r| R) (|:| |phi| R))))
        (SPROG ((|t| (R)))
               (CONS (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 166))
                     (COND
                      ((SPADCALL (LETT |t| (SPADCALL |x| (QREFELT $ 269)))
                                 (QREFELT $ 277))
                       (SPADCALL |t|
                                 (SPADCALL 2 (SPADCALL (QREFELT $ 242))
                                           (QREFELT $ 108))
                                 (QREFELT $ 60)))
                      ('T |t|))))) 

(SDEFUN |COMPCAT-;^;SFS;86| ((|x| (S)) (|q| (|Fraction| (|Integer|))) ($ (S)))
        (SPROG ((|tx| (R)) (|ax| (R)) (|ee| (|Integer|)) (|rx| (R)))
               (SEQ
                (COND
                 ((SPADCALL |q| (QREFELT $ 280))
                  (COND
                   ((SPADCALL |x| (QREFELT $ 220))
                    (|error| "0 ^ 0 is undefined"))
                   (#1='T (|spadConstant| $ 8))))
                 ((SPADCALL |x| (QREFELT $ 220)) (|spadConstant| $ 20))
                 (#1#
                  (SEQ (LETT |rx| (SPADCALL |x| (QREFELT $ 24)))
                       (COND
                        ((SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                   (QREFELT $ 79))
                         (COND
                          ((SPADCALL |rx| (QREFELT $ 281))
                           (EXIT
                            (SPADCALL (SPADCALL |rx| |q| (QREFELT $ 282))
                                      (QREFELT $ 75)))))))
                       (COND
                        ((SPADCALL (SPADCALL |x| (QREFELT $ 86))
                                   (QREFELT $ 79))
                         (COND
                          ((EQL (SPADCALL |q| (QREFELT $ 283)) 2)
                           (EXIT
                            (SEQ
                             (LETT |ee|
                                   (QUOTIENT2
                                    (- (SPADCALL |q| (QREFELT $ 284)) 1) 2))
                             (EXIT
                              (SPADCALL (|spadConstant| $ 21)
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL (|spadConstant| $ 9)
                                                    (QREFELT $ 104))
                                          |ee| (QREFELT $ 285))
                                         (SPADCALL
                                          (SPADCALL |rx| (QREFELT $ 104)) |q|
                                          (QREFELT $ 282))
                                         (QREFELT $ 120))
                                        (QREFELT $ 30)))))))))
                       (LETT |ax|
                             (SPADCALL
                              (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                        (QREFELT $ 166))
                              |q| (QREFELT $ 282)))
                       (LETT |tx|
                             (SPADCALL (SPADCALL |q| (QREFELT $ 286))
                                       (SPADCALL |x| (QREFELT $ 269))
                                       (QREFELT $ 120)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL |ax| (SPADCALL |tx| (QREFELT $ 270))
                                   (QREFELT $ 120))
                         (SPADCALL |ax| (SPADCALL |tx| (QREFELT $ 271))
                                   (QREFELT $ 120))
                         (QREFELT $ 30))))))))) 

(SDEFUN |COMPCAT-;^;SFS;87| ((|x| (S)) (|q| (|Fraction| (|Integer|))) ($ (S)))
        (SPROG ((|e| (R)) (|t| (R)) (#1=#:G990 NIL) (|i| (R)) (|r| (R)))
               (SEQ
                (COND
                 ((SPADCALL |q| (QREFELT $ 280))
                  (COND
                   ((SPADCALL |x| (QREFELT $ 220))
                    (|error| "0 ^ 0 is undefined"))
                   (#2='T (|spadConstant| $ 8))))
                 (#2#
                  (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 24)))
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |i| (SPADCALL |x| (QREFELT $ 86)))
                                    (QREFELT $ 79))
                          (SPADCALL (SPADCALL |r| |q| (QREFELT $ 282))
                                    (QREFELT $ 75)))
                         (#2#
                          (SEQ
                           (LETT |t|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |q| (QREFELT $ 284))
                                            (PROG2
                                                (LETT #1#
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |q|
                                                                  (QREFELT $
                                                                           283))
                                                        (QREFELT $ 26))
                                                       (QREFELT $ 139)))
                                                (QCDR #1#)
                                              (|check_union2| (QEQCAR #1# 0)
                                                              (QREFELT $ 7)
                                                              (|Union|
                                                               (QREFELT $ 7)
                                                               "failed")
                                                              #1#))
                                            (QREFELT $ 124))
                                  (SPADCALL |x| (QREFELT $ 269))
                                  (QREFELT $ 120)))
                           (LETT |e|
                                 (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                           (SPADCALL |q|
                                                     (SPADCALL 2
                                                               (QREFELT $ 288))
                                                     (QREFELT $ 289))
                                           (QREFELT $ 282)))
                           (EXIT
                            (SPADCALL
                             (SPADCALL |e| (SPADCALL |t| (QREFELT $ 270))
                                       (QREFELT $ 120))
                             (SPADCALL |e| (SPADCALL |t| (QREFELT $ 271))
                                       (QREFELT $ 120))
                             (QREFELT $ 30))))))))))))) 

(SDEFUN |COMPCAT-;^;3S;88| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG ((|yr| (R)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 20) (QREFELT $ 290))
                  (SEQ (LETT |yr| (SPADCALL |y| (QREFELT $ 24)))
                       (EXIT
                        (COND
                         ((SPADCALL (|spadConstant| $ 21) |yr| (QREFELT $ 225))
                          (|spadConstant| $ 20))
                         (#1='T
                          (|error| "x^y with x = 0 and real(y) <= 0"))))))
                 (#1#
                  (SPADCALL
                   (SPADCALL |y| (SPADCALL |x| (QREFELT $ 268))
                             (QREFELT $ 216))
                   (QREFELT $ 272))))))) 

(SDEFUN |COMPCAT-;^;3S;89| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG ((|yr| (R)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 20) (QREFELT $ 290))
                  (SEQ (LETT |yr| (SPADCALL |y| (QREFELT $ 24)))
                       (EXIT
                        (COND ((|less_DF| 0.0 |yr|) (|spadConstant| $ 20))
                              (#1='T
                               (|error| "x^y with x = 0 and real(y) <= 0"))))))
                 (#1#
                  (SPADCALL
                   (SPADCALL |y| (SPADCALL |x| (QREFELT $ 268))
                             (QREFELT $ 216))
                   (QREFELT $ 272))))))) 

(DECLAIM (NOTINLINE |ComplexCategory&;|)) 

(DEFUN |ComplexCategory&| (|#1| |#2|)
  (SPROG
   ((#1=#:G990 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|ComplexCategory&| DV$1 DV$2))
    (LETT $ (GETREFV 298))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#2|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory| |#2|
                                                       '(|RadicalCategory|))
                                        (|HasCategory| |#2|
                                                       '(|TranscendentalFunctionCategory|))
                                        (|HasCategory| |#2|
                                                       '(|arbitraryPrecision|))
                                        (|HasCategory| |#2|
                                                       '(|RealNumberSystem|))
                                        (|HasCategory| |#2| '(|RealConstant|))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#2|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#2| '(|Field|))
                                        (|HasCategory| |#2|
                                                       '(|IntegerNumberSystem|))
                                        (|HasCategory| |#2|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#2|
                                                       '(|Comparable|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 2)
      (COND
       ((|testBitVector| |pv$| 1)
        (PROGN
         (COND
          ((|testBitVector| |pv$| 12)
           (PROGN
            (QSETREFV $ 39
                      (CONS
                       (|dispatchFunction|
                        |COMPCAT-;solveLinearPolynomialEquation;LSupU;3|)
                       $)))))
         NIL
         (QSETREFV $ 56
                   (CONS
                    (|dispatchFunction| |COMPCAT-;factorPolynomial;SupF;5|) $))
         (QSETREFV $ 84
                   (CONS
                    (|dispatchFunction|
                     |COMPCAT-;factorSquareFreePolynomial;SupF;6|)
                    $)))))))
    (COND
     ((|testBitVector| |pv$| 12)
      (PROGN
       (QSETREFV $ 98 (CONS (|dispatchFunction| |COMPCAT-;factor;SF;7|) $))
       (QSETREFV $ 100
                 (CONS (|dispatchFunction| |COMPCAT-;squareFree;SF;8|) $))
       (QSETREFV $ 102 (CONS (|dispatchFunction| |COMPCAT-;prime?;SB;9|) $)))))
    (COND
     ((|testBitVector| |pv$| 6)
      (QSETREFV $ 167 (CONS (|dispatchFunction| |COMPCAT-;abs;2S;36|) $))))
    (COND
     ((|testBitVector| |pv$| 7)
      (PROGN
       (QSETREFV $ 172 (CONS (|dispatchFunction| |COMPCAT-;convert;SC;37|) $))
       (QSETREFV $ 177
                 (CONS (|dispatchFunction| |COMPCAT-;convert;SC;38|) $)))))
    (COND
     ((|testBitVector| |pv$| 10)
      (QSETREFV $ 183
                (CONS (|dispatchFunction| |COMPCAT-;convert;SIf;39|) $))))
    (COND
     ((|HasCategory| |#2| '(|ConvertibleTo| (|Pattern| (|Integer|))))
      (QSETREFV $ 187 (CONS (|dispatchFunction| |COMPCAT-;convert;SP;40|) $))))
    (COND
     ((|HasCategory| |#2| '(|ConvertibleTo| (|Pattern| (|Float|))))
      (QSETREFV $ 191 (CONS (|dispatchFunction| |COMPCAT-;convert;SP;41|) $))))
    (COND
     ((|HasCategory| |#2| '(|PatternMatchable| (|Integer|)))
      (QSETREFV $ 196
                (CONS (|dispatchFunction| |COMPCAT-;patternMatch;SP2Pmr;42|)
                      $))))
    (COND
     ((|HasCategory| |#2| '(|PatternMatchable| (|Float|)))
      (QSETREFV $ 201
                (CONS (|dispatchFunction| |COMPCAT-;patternMatch;SP2Pmr;43|)
                      $))))
    (COND
     ((|testBitVector| |pv$| 14)
      (QSETREFV $ 203
                (CONS (|dispatchFunction| |COMPCAT-;smaller?;2SB;44|) $))))
    (COND
     ((|testBitVector| |pv$| 12)
      (PROGN
       (QSETREFV $ 204
                 (CONS (|dispatchFunction| |COMPCAT-;rational?;SB;45|) $))
       (QSETREFV $ 207 (CONS (|dispatchFunction| |COMPCAT-;rational;SF;46|) $))
       (QSETREFV $ 209
                 (CONS (|dispatchFunction| |COMPCAT-;rationalIfCan;SU;47|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 11)
      (QSETREFV $ 212 (CONS (|dispatchFunction| |COMPCAT-;inv;2S;48|) $))))
    (COND
     ((|testBitVector| |pv$| 13)
      (PROGN
       (QSETREFV $ 214 (CONS (|dispatchFunction| |COMPCAT-;exquo;SRU;49|) $))
       (QSETREFV $ 217 (CONS (|dispatchFunction| |COMPCAT-;exquo;2SU;50|) $))
       (QSETREFV $ 219 (CONS (|dispatchFunction| |COMPCAT-;recip;SU;51|) $))
       (COND
        ((|HasCategory| |#2| '(|OrderedRing|))
         (QSETREFV $ 228
                   (CONS (|dispatchFunction| |COMPCAT-;unitNormal;SR;52|) $)))
        ('T
         (QSETREFV $ 228
                   (CONS (|dispatchFunction| |COMPCAT-;unitNormal;SR;53|)
                         $)))))))
    (COND
     ((|testBitVector| |pv$| 12)
      (PROGN
       (QSETREFV $ 230
                 (CONS (|dispatchFunction| |COMPCAT-;euclideanSize;SNni;54|)
                       $))
       (QSETREFV $ 233 (CONS (|dispatchFunction| |COMPCAT-;rem;3S;55|) $))
       (QSETREFV $ 235 (CONS (|dispatchFunction| |COMPCAT-;quo;3S;56|) $))
       (QSETREFV $ 240
                 (CONS (|dispatchFunction| |COMPCAT-;divide;2SR;57|) $)))))
    (COND
     ((|testBitVector| |pv$| 4)
      (PROGN
       (QSETREFV $ 241
                 (PROG2
                     (LETT #1#
                           (SPADCALL (SPADCALL 2 (QREFELT $ 26))
                                     (QREFELT $ 139)))
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) |#2| (|Union| |#2| "failed")
                                   #1#)))
       (COND
        ((|testBitVector| |pv$| 6)
         (PROGN
          (QSETREFV $ 245
                    (CONS (|dispatchFunction| |COMPCAT-;argument;SR;59|) $))))
        ((|testBitVector| |pv$| 3)
         (QSETREFV $ 245
                   (CONS (|dispatchFunction| |COMPCAT-;argument;SR;60|) $)))
        ('T
         (QSETREFV $ 245
                   (CONS (|dispatchFunction| |COMPCAT-;argument;SR;61|) $))))
       (QSETREFV $ 248 (CONS (|dispatchFunction| |COMPCAT-;pi;S;62|) $))
       (COND
        ((|domainEqual| |#2| (|DoubleFloat|))
         (PROGN
          (QSETREFV $ 249 (CONS (|dispatchFunction| |COMPCAT-;exp;2S;63|) $))
          (QSETREFV $ 250 (CONS (|dispatchFunction| |COMPCAT-;log;2S;64|) $))
          (QSETREFV $ 251 (CONS (|dispatchFunction| |COMPCAT-;sin;2S;65|) $))
          (QSETREFV $ 252 (CONS (|dispatchFunction| |COMPCAT-;cos;2S;66|) $))
          (QSETREFV $ 253 (CONS (|dispatchFunction| |COMPCAT-;tan;2S;67|) $))
          (QSETREFV $ 254 (CONS (|dispatchFunction| |COMPCAT-;asin;2S;68|) $))
          (QSETREFV $ 255 (CONS (|dispatchFunction| |COMPCAT-;acos;2S;69|) $))
          (QSETREFV $ 257 (CONS (|dispatchFunction| |COMPCAT-;atan;2S;70|) $))
          (QSETREFV $ 258 (CONS (|dispatchFunction| |COMPCAT-;sinh;2S;71|) $))
          (QSETREFV $ 259 (CONS (|dispatchFunction| |COMPCAT-;cosh;2S;72|) $))
          (QSETREFV $ 260 (CONS (|dispatchFunction| |COMPCAT-;tanh;2S;73|) $))
          (QSETREFV $ 261 (CONS (|dispatchFunction| |COMPCAT-;asinh;2S;74|) $))
          (QSETREFV $ 262 (CONS (|dispatchFunction| |COMPCAT-;acosh;2S;75|) $))
          (QSETREFV $ 265
                    (CONS (|dispatchFunction| |COMPCAT-;atanh;2S;76|) $))))
        ('T
         (PROGN
          (QSETREFV $ 257 (CONS (|dispatchFunction| |COMPCAT-;atan;2S;77|) $))
          (QSETREFV $ 250 (CONS (|dispatchFunction| |COMPCAT-;log;2S;78|) $))
          (QSETREFV $ 249 (CONS (|dispatchFunction| |COMPCAT-;exp;2S;79|) $))
          (QSETREFV $ 252 (CONS (|dispatchFunction| |COMPCAT-;cos;2S;80|) $))
          (QSETREFV $ 251 (CONS (|dispatchFunction| |COMPCAT-;sin;2S;81|) $))
          (QSETREFV $ 254 (CONS (|dispatchFunction| |COMPCAT-;asin;2S;82|) $))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 255
                      (CONS (|dispatchFunction| |COMPCAT-;acos;2S;83|) $)))
           ('T
            (QSETREFV $ 255
                      (CONS (|dispatchFunction| |COMPCAT-;acos;2S;84|) $)))))))
       (COND
        ((|testBitVector| |pv$| 6)
         (PROGN
          (QSETREFV $ 279
                    (CONS
                     (|dispatchFunction| |COMPCAT-;polarCoordinates;SR;85|) $))
          (QSETREFV $ 287 (CONS (|dispatchFunction| |COMPCAT-;^;SFS;86|) $))))
        ((|testBitVector| |pv$| 3)
         (QSETREFV $ 287
                   (CONS (|dispatchFunction| |COMPCAT-;^;SFS;87|) $)))))))
    (COND
     ((|domainEqual| |#2| (|Float|))
      (COND
       ((|HasSignature| |#2|
                        (LIST '<
                              (LIST '(|Boolean|) (|devaluate| |#2|)
                                    (|devaluate| |#2|))))
        (QSETREFV $ 291 (CONS (|dispatchFunction| |COMPCAT-;^;3S;88|) $)))))
     ((|domainEqual| |#2| (|DoubleFloat|))
      (COND
       ((|HasSignature| |#2|
                        (LIST '<
                              (LIST '(|Boolean|) (|devaluate| |#2|)
                                    (|devaluate| |#2|))))
        (QSETREFV $ 291 (CONS (|dispatchFunction| |COMPCAT-;^;3S;89|) $))))))
    $))) 

(MAKEPROP '|ComplexCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (4 . |One|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 7) (8 . |monomial|)
              (|PositiveInteger|) (14 . ^) (20 . |trace|) (25 . ^) (31 . *)
              (37 . -) (43 . |norm|) (48 . |Zero|) (52 . |Zero|) (56 . +)
              |COMPCAT-;characteristicPolynomial;SSup;1| (62 . |real|)
              (|Integer|) (67 . |coerce|) (72 . -) (|Boolean|) (78 . |prime?|)
              (83 . |complex|) (|Union| 32 '"failed") (|List| 33)
              (|SparseUnivariatePolynomial| 6)
              (|ComplexIntegerSolveLinearPolynomialEquation| 7 6)
              (89 . |solveLinearPolynomialEquation|) (|Union| 37 '#1="failed")
              (|List| 38) (|SparseUnivariatePolynomial| $)
              (95 . |solveLinearPolynomialEquation|) (101 . |retract|)
              (106 . |conjugate|) (|Mapping| 6 6) (111 . |map|) (117 . *)
              (|Mapping| 7 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 33 7 11)
              (123 . |map|) (|Factored| $) (129 . |squareFree|) (|Factored| 38)
              (134 . |factorSquareFreePolynomial|) (|Factored| 33)
              (|Mapping| 52 33) (|FactoredFunctionUtilities| 33)
              (139 . |refine|) (145 . |factorPolynomial|)
              (150 . |differentiate|) (155 . |gcd|) (161 . |degree|) (166 . +)
              (172 . |monomial|) (178 . -) (184 . |elt|)
              (190 . |factorSquareFreePolynomial|) (|Factored| 11)
              (195 . |numberOfFactors|) (200 . |One|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 68) (|:| |factor| 33) (|:| |exponent| 10))
              (|List| 69) (204 . |makeFR|)
              (|Record| (|:| |flag| 68) (|:| |factor| 11) (|:| |exponent| 10))
              (|List| 72) (210 . |factorList|) (215 . |coerce|) (|Mapping| 6 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 11 6 33)
              (220 . |map|) (226 . |zero?|) (231 . +) (237 . |gcd|)
              (|Union| $ '"failed") (243 . |exquo|)
              (249 . |factorSquareFreePolynomial|) (254 . |convert|)
              (259 . |imag|) (|Complex| 25) (264 . |complex|) (|Factored| 87)
              (|GaussianFactorizationPackage|) (270 . |factor|) (275 . |real|)
              (280 . |imag|) (|Factored| 6) (|Mapping| 6 87)
              (|FactoredFunctions2| 87 6) (285 . |map|) (291 . |factor|)
              (296 . |factor|) (301 . |squareFree|) (306 . |prime?|)
              (311 . |prime?|) |COMPCAT-;rank;Pi;10| (316 . -)
              |COMPCAT-;discriminant;R;11| (321 . ^) |COMPCAT-;norm;SR;12|
              (327 . *) |COMPCAT-;trace;SR;13| |COMPCAT-;imaginary;S;14|
              |COMPCAT-;conjugate;2S;15| (333 . |characteristic|)
              |COMPCAT-;characteristic;Nni;16| (|Mapping| 7 7)
              |COMPCAT-;map;M2S;17| (337 . =) |COMPCAT-;=;2SB;18|
              |COMPCAT-;+;3S;19| |COMPCAT-;-;2S;20| (343 . *)
              |COMPCAT-;*;R2S;21| (|Vector| 7) |COMPCAT-;coordinates;SV;22|
              (349 . *) |COMPCAT-;*;I2S;23| |COMPCAT-;differentiate;SMS;24|
              |COMPCAT-;definingPolynomial;Sup;25| (355 . |definingPolynomial|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (359 . |monicDivide|) (365 . |coefficient|)
              |COMPCAT-;reduce;SupS;26| |COMPCAT-;lift;SSup;27|
              |COMPCAT-;minimalPolynomial;SSup;28| (|Vector| 6)
              (371 . |minIndex|) (376 . |elt|) (382 . ~=) (388 . |recip|)
              (|Vector| $) |COMPCAT-;coordinates;SVV;29| (|OutputForm|)
              (393 . |coerce|) (|Symbol|) (398 . |coerce|) (403 . -) (408 . *)
              (414 . +) |COMPCAT-;coerce;SOf;30| |COMPCAT-;retract;SR;31|
              (|Union| 7 '"failed") |COMPCAT-;retractIfCan;SU;32|
              |COMPCAT-;*;3S;33| (|Matrix| 7) (|Matrix| 6)
              (|MatrixCategoryFunctions2| 6 135 135 155 7 122 122 154)
              (420 . |map|) (426 . |vertConcat|) (|Matrix| $)
              |COMPCAT-;reducedSystem;MM;34| (432 . |coerce|)
              (437 . |reducedSystem|) (442 . |column|)
              (|Record| (|:| |mat| 154) (|:| |vec| 122))
              |COMPCAT-;reducedSystem;MVR;35| (448 . |sqrt|) (453 . |abs|)
              (|DoubleFloat|) (458 . |convert|) (|Complex| 168)
              (463 . |complex|) (469 . |convert|) (|Float|) (474 . |convert|)
              (|Complex| 173) (479 . |complex|) (485 . |convert|) (|InputForm|)
              (490 . |convert|) (495 . |convert|) (|List| $) (500 . |convert|)
              (505 . |convert|) (|Pattern| 25) (|ComplexPattern| 25 7 6)
              (510 . |convert|) (515 . |convert|) (|Pattern| 173)
              (|ComplexPattern| 173 7 6) (520 . |convert|) (525 . |convert|)
              (|PatternMatchResult| 25 6) (|ComplexPatternMatch| 25 7 6)
              (530 . |patternMatch|) (|PatternMatchResult| 25 $)
              (537 . |patternMatch|) (|PatternMatchResult| 173 6)
              (|ComplexPatternMatch| 173 7 6) (544 . |patternMatch|)
              (|PatternMatchResult| 173 $) (551 . |patternMatch|)
              (558 . |smaller?|) (564 . |smaller?|) (570 . |rational?|)
              (|Fraction| 25) (575 . |rational|) (580 . |rational|)
              (|Union| 205 '#2="failed") (585 . |rationalIfCan|) (590 . |inv|)
              (595 . /) (601 . |inv|) (606 . |exquo|) (612 . |exquo|)
              (618 . |exquo|) (624 . *) (630 . |exquo|) (636 . |exquo|)
              (642 . |recip|) (647 . |zero?|) (652 . |recip|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (657 . |unitNormal|) (662 . *) (668 . <) (674 . |imaginary|)
              (678 . -) (683 . |unitNormal|) (688 . |euclideanSize|)
              (693 . |euclideanSize|) (698 . |symmetricRemainder|)
              (704 . |divide|) (710 . |rem|) (716 . |quo|) (722 . |quo|)
              (728 . |rem|) (734 . ~=) (740 . |sizeLess?|) (746 . -)
              (752 . |divide|) '|half| (758 . |pi|) (762 . >=) (768 . |atan|)
              (773 . |argument|) (778 . |log|) (783 . |exp|) (788 . |pi|)
              (792 . |exp|) (797 . |log|) (802 . |sin|) (807 . |cos|)
              (812 . |tan|) (817 . |asin|) (822 . |acos|) (827 . |atanh|)
              (832 . |atan|) (837 . |sinh|) (842 . |cosh|) (847 . |tanh|)
              (852 . |asinh|) (857 . |acosh|)
              (|DoubleFloatElementaryFunctions|) (862 . |atanh|)
              (867 . |atanh|) (872 . *) (878 . +) (884 . |log|)
              (889 . |argument|) (894 . |cos|) (899 . |sin|) (904 . |exp|)
              (909 . |asinh|) (914 . ^) (920 . |sqrt|) (925 . |asin|)
              (930 . |negative?|) (|Record| (|:| |r| 7) (|:| |phi| 7))
              (935 . |polarCoordinates|) (940 . |zero?|) (945 . |positive?|)
              (950 . ^) (956 . |denom|) (961 . |numer|) (966 . ^)
              (972 . |coerce|) (977 . ^) (983 . |coerce|) (988 . /) (994 . =)
              (1000 . ^) (|List| 144) (|List| 10) (|Fraction| 11) (|Matrix| 25)
              (|Record| (|:| |mat| 295) (|:| |vec| (|Vector| 25)))
              (|Union| 25 '#3="failed"))
           '#(|unitNormal| 1006 |trace| 1011 |tanh| 1016 |tan| 1021
              |squareFree| 1026 |solveLinearPolynomialEquation| 1031 |smaller?|
              1037 |sinh| 1043 |sin| 1048 |retractIfCan| 1053 |retract| 1058
              |rem| 1063 |reducedSystem| 1069 |reduce| 1080 |recip| 1085
              |rationalIfCan| 1090 |rational?| 1095 |rational| 1100 |rank| 1105
              |quo| 1109 |prime?| 1115 |polarCoordinates| 1120 |pi| 1125
              |patternMatch| 1129 |norm| 1143 |minimalPolynomial| 1148 |map|
              1153 |log| 1159 |lift| 1164 |inv| 1169 |imaginary| 1174
              |factorSquareFreePolynomial| 1178 |factorPolynomial| 1183
              |factor| 1188 |exquo| 1193 |exp| 1205 |euclideanSize| 1210
              |divide| 1215 |discriminant| 1221 |differentiate| 1225
              |definingPolynomial| 1231 |cosh| 1235 |cos| 1240 |coordinates|
              1245 |convert| 1256 |conjugate| 1281 |coerce| 1286
              |characteristicPolynomial| 1291 |characteristic| 1296 |atanh|
              1300 |atan| 1305 |asinh| 1310 |asin| 1315 |argument| 1320 |acosh|
              1325 |acos| 1330 |abs| 1335 ^ 1340 = 1352 - 1358 + 1363 * 1369)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|smaller?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|unitNormal|
                                      ((|Record| (|:| |unit| |#1|)
                                                 (|:| |canonical| |#1|)
                                                 (|:| |associate| |#1|))
                                       |#1|))
                                     T)
                                   '((|exquo|
                                      ((|Union| |#1| "failed") |#1| |#1|))
                                     T)
                                   '((|euclideanSize|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|divide|
                                      ((|Record| (|:| |quotient| |#1|)
                                                 (|:| |remainder| |#1|))
                                       |#1| |#1|))
                                     T)
                                   '((|quo| (|#1| |#1| |#1|)) T)
                                   '((|rem| (|#1| |#1| |#1|)) T)
                                   '((|factor| ((|Factored| |#1|) |#1|)) T)
                                   '((|squareFree| ((|Factored| |#1|) |#1|)) T)
                                   '((|prime?| ((|Boolean|) |#1|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|convert| ((|InputForm|) |#1|)) T)
                                   '((|convert|
                                      ((|Complex| (|DoubleFloat|)) |#1|))
                                     T)
                                   '((|convert| ((|Complex| (|Float|)) |#1|))
                                     T)
                                   '((|tan| (|#1| |#1|)) T)
                                   '((|sin| (|#1| |#1|)) T)
                                   '((|cos| (|#1| |#1|)) T)
                                   '((|acos| (|#1| |#1|)) T)
                                   '((|asin| (|#1| |#1|)) T)
                                   '((|atan| (|#1| |#1|)) T)
                                   '((|cosh| (|#1| |#1|)) T)
                                   '((|sinh| (|#1| |#1|)) T)
                                   '((|tanh| (|#1| |#1|)) T)
                                   '((|acosh| (|#1| |#1|)) T)
                                   '((|asinh| (|#1| |#1|)) T)
                                   '((|atanh| (|#1| |#1|)) T)
                                   '((|log| (|#1| |#1|)) T)
                                   '((|exp| (|#1| |#1|)) T)
                                   '((^ (|#1| |#1| |#1|)) T) '((|pi| (|#1|)) T)
                                   '((^ (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|factorPolynomial|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|factorSquareFreePolynomial|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|solveLinearPolynomialEquation|
                                      ((|Union|
                                        (|List|
                                         (|SparseUnivariatePolynomial| |#1|))
                                        #1#)
                                       (|List|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|rationalIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #2#)
                                       |#1|))
                                     T)
                                   '((|rational|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|rational?| ((|Boolean|) |#1|)) T)
                                   '((|polarCoordinates|
                                      ((|Record| (|:| |r| |#2|)
                                                 (|:| |phi| |#2|))
                                       |#1|))
                                     T)
                                   '((|argument| (|#2| |#1|)) T)
                                   '((|abs| (|#1| |#1|)) T)
                                   '((|exquo|
                                      ((|Union| |#1| "failed") |#1| |#2|))
                                     T)
                                   '((|conjugate| (|#1| |#1|)) T)
                                   '((|imaginary| (|#1|)) T)
                                   '((|convert| ((|Pattern| (|Float|)) |#1|))
                                     T)
                                   '((|convert| ((|Pattern| (|Integer|)) |#1|))
                                     T)
                                   '((|patternMatch|
                                      ((|PatternMatchResult| (|Float|) |#1|)
                                       |#1| (|Pattern| (|Float|))
                                       (|PatternMatchResult| (|Float|) |#1|)))
                                     T)
                                   '((|patternMatch|
                                      ((|PatternMatchResult| (|Integer|) |#1|)
                                       |#1| (|Pattern| (|Integer|))
                                       (|PatternMatchResult| (|Integer|)
                                                             |#1|)))
                                     T)
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))))
                                     T)
                                   '((|differentiate| (|#1| |#1| (|Symbol|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate| (|#1| |#1|)) T)
                                   '((|inv| (|#1| |#1|)) T)
                                   '((^ (|#1| |#1| (|Integer|))) T)
                                   '((* (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((* (|#1| (|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|reduce|
                                      ((|Union| |#1| "failed")
                                       (|Fraction|
                                        (|SparseUnivariatePolynomial| |#2|))))
                                     T)
                                   '((|lift|
                                      ((|SparseUnivariatePolynomial| |#2|)
                                       |#1|))
                                     T)
                                   '((|convert|
                                      (|#1|
                                       (|SparseUnivariatePolynomial| |#2|)))
                                     T)
                                   '((|reduce|
                                      (|#1|
                                       (|SparseUnivariatePolynomial| |#2|)))
                                     T)
                                   '((|definingPolynomial|
                                      ((|SparseUnivariatePolynomial| |#2|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Matrix| |#2|) (|Matrix| |#1|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Record| (|:| |mat| (|Matrix| |#2|))
                                                 (|:| |vec| (|Vector| |#2|)))
                                       (|Matrix| |#1|) (|Vector| |#1|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Record|
                                        (|:| |mat| (|Matrix| (|Integer|)))
                                        (|:| |vec| (|Vector| (|Integer|))))
                                       (|Matrix| |#1|) (|Vector| |#1|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Matrix| (|Integer|)) (|Matrix| |#1|)))
                                     T)
                                   '((|retractIfCan| ((|Union| |#2| #3#) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #3#)
                                       |#1|))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #3#) |#1|))
                                     T)
                                   '((|convert|
                                      ((|SparseUnivariatePolynomial| |#2|)
                                       |#1|))
                                     T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((|discriminant| (|#2|)) T)
                                   '((|coordinates| ((|Vector| |#2|) |#1|)) T)
                                   '((|coordinates|
                                      ((|Matrix| |#2|) (|Vector| |#1|)))
                                     T)
                                   '((|convert| ((|Vector| |#2|) |#1|)) T)
                                   '((|convert| (|#1| (|Vector| |#2|))) T)
                                   '((|minimalPolynomial|
                                      ((|SparseUnivariatePolynomial| |#2|)
                                       |#1|))
                                     T)
                                   '((|characteristicPolynomial|
                                      ((|SparseUnivariatePolynomial| |#2|)
                                       |#1|))
                                     T)
                                   '((|discriminant| (|#2| (|Vector| |#1|))) T)
                                   '((|coordinates|
                                      ((|Matrix| |#2|) (|Vector| |#1|)
                                       (|Vector| |#1|)))
                                     T)
                                   '((|coordinates|
                                      ((|Vector| |#2|) |#1| (|Vector| |#1|)))
                                     T)
                                   '((|norm| (|#2| |#1|)) T)
                                   '((|trace| (|#2| |#1|)) T)
                                   '((|rank| ((|PositiveInteger|))) T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|recip| ((|Union| |#1| "failed") |#1|))
                                     T)
                                   '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((- (|#1| |#1|)) T)
                                   '((- (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((^ (|#1| |#1| (|PositiveInteger|))) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T)
                                   '((+ (|#1| |#1| |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 291
                                            '(0 6 0 8 0 7 0 9 2 11 0 7 10 12 2
                                              11 0 0 13 14 1 6 7 0 15 2 11 0 0
                                              10 16 2 11 0 7 0 17 2 11 0 0 0 18
                                              1 6 7 0 19 0 6 0 20 0 7 0 21 2 11
                                              0 0 0 22 1 6 7 0 24 1 7 0 25 26 2
                                              7 0 0 0 27 1 7 28 0 29 2 6 0 7 7
                                              30 2 34 31 32 33 35 2 0 36 37 38
                                              39 1 6 7 0 40 1 6 0 0 41 2 33 0
                                              42 0 43 2 33 0 0 0 44 2 46 11 45
                                              33 47 1 33 48 0 49 1 6 50 38 51 2
                                              54 52 52 53 55 1 0 50 38 56 1 11
                                              0 0 57 2 11 0 0 0 58 1 11 10 0 59
                                              2 7 0 0 0 60 2 33 0 6 10 61 2 33
                                              0 0 0 62 2 33 0 0 0 63 1 7 50 38
                                              64 1 65 10 0 66 0 33 0 67 2 52 0
                                              33 70 71 1 65 73 0 74 1 6 0 7 75
                                              2 77 33 76 11 78 1 7 28 0 79 2 33
                                              0 0 0 80 2 33 0 0 0 81 2 33 82 0
                                              0 83 1 0 50 38 84 1 7 25 0 85 1 6
                                              7 0 86 2 87 0 25 25 88 1 90 89 87
                                              91 1 87 25 0 92 1 87 25 0 93 2 96
                                              94 95 89 97 1 0 48 0 98 1 6 48 0
                                              99 1 0 48 0 100 1 90 28 87 101 1
                                              0 28 0 102 1 7 0 0 104 2 7 0 0 13
                                              106 2 7 0 13 0 108 0 7 10 112 2 7
                                              28 0 0 116 2 7 0 0 0 120 2 7 0 25
                                              0 124 0 6 11 128 2 11 129 0 0 130
                                              2 11 7 0 10 131 1 135 25 0 136 2
                                              135 6 0 25 137 2 25 28 0 0 138 1
                                              7 82 0 139 1 7 142 0 143 1 144
                                              142 0 145 1 142 0 0 146 2 142 0 0
                                              0 147 2 142 0 0 0 148 2 156 154
                                              45 155 157 2 154 0 0 0 158 1 155
                                              0 135 161 1 6 154 159 162 2 154
                                              122 0 25 163 1 7 0 0 166 1 0 0 0
                                              167 1 7 168 0 169 2 170 0 168 168
                                              171 1 0 170 0 172 1 7 173 0 174 2
                                              175 0 173 173 176 1 0 175 0 177 1
                                              178 0 144 179 1 7 178 0 180 1 178
                                              0 181 182 1 0 178 0 183 1 185 184
                                              6 186 1 0 184 0 187 1 189 188 6
                                              190 1 0 188 0 191 3 193 192 6 184
                                              192 194 3 0 195 0 184 195 196 3
                                              198 197 6 188 197 199 3 0 200 0
                                              188 200 201 2 7 28 0 0 202 2 0 28
                                              0 0 203 1 0 28 0 204 1 7 205 0
                                              206 1 0 205 0 207 1 0 208 0 209 1
                                              7 0 0 210 2 7 0 0 0 211 1 0 0 0
                                              212 2 7 82 0 0 213 2 0 82 0 7 214
                                              2 6 82 0 7 215 2 6 0 0 0 216 2 0
                                              82 0 0 217 2 6 82 0 0 218 1 0 82
                                              0 219 1 6 28 0 220 1 6 82 0 221 1
                                              7 222 0 223 2 6 0 7 0 224 2 7 28
                                              0 0 225 0 6 0 226 1 6 0 0 227 1 0
                                              222 0 228 1 7 10 0 229 1 0 10 0
                                              230 2 7 0 0 0 231 2 6 129 0 0 232
                                              2 0 0 0 0 233 2 7 0 0 0 234 2 0 0
                                              0 0 235 2 7 0 0 0 236 2 7 28 0 0
                                              237 2 7 28 0 0 238 2 6 0 0 0 239
                                              2 0 129 0 0 240 0 7 0 242 2 7 28
                                              0 0 243 1 7 0 0 244 1 0 7 0 245 1
                                              7 0 0 246 1 7 0 0 247 0 0 0 248 1
                                              0 0 0 249 1 0 0 0 250 1 0 0 0 251
                                              1 0 0 0 252 1 0 0 0 253 1 0 0 0
                                              254 1 0 0 0 255 1 6 0 0 256 1 0 0
                                              0 257 1 0 0 0 258 1 0 0 0 259 1 0
                                              0 0 260 1 0 0 0 261 1 0 0 0 262 1
                                              263 170 170 264 1 0 0 0 265 2 6 0
                                              0 7 266 2 6 0 0 0 267 1 6 0 0 268
                                              1 6 7 0 269 1 7 0 0 270 1 7 0 0
                                              271 1 6 0 0 272 1 6 0 0 273 2 6 0
                                              0 13 274 1 6 0 0 275 1 6 0 0 276
                                              1 7 28 0 277 1 0 278 0 279 1 205
                                              28 0 280 1 7 28 0 281 2 7 0 0 205
                                              282 1 205 25 0 283 1 205 25 0 284
                                              2 7 0 0 25 285 1 7 0 205 286 2 0
                                              0 0 205 287 1 205 0 25 288 2 205
                                              0 0 0 289 2 6 28 0 0 290 2 0 0 0
                                              0 291 1 0 222 0 228 1 0 7 0 109 1
                                              0 0 0 260 1 0 0 0 253 1 0 48 0
                                              100 2 0 36 37 38 39 2 0 28 0 0
                                              203 1 0 0 0 258 1 0 0 0 251 1 0
                                              151 0 152 1 0 7 0 150 2 0 0 0 0
                                              233 1 0 154 159 160 2 0 164 159
                                              140 165 1 0 0 11 132 1 0 82 0 219
                                              1 0 208 0 209 1 0 28 0 204 1 0
                                              205 0 207 0 0 13 103 2 0 0 0 0
                                              235 1 0 28 0 102 1 0 278 0 279 0
                                              0 0 248 3 0 200 0 188 200 201 3 0
                                              195 0 184 195 196 1 0 7 0 107 1 0
                                              11 0 134 2 0 0 114 0 115 1 0 0 0
                                              250 1 0 11 0 133 1 0 0 0 212 0 0
                                              0 110 1 0 50 38 84 1 0 50 38 56 1
                                              0 48 0 98 2 0 82 0 0 217 2 0 82 0
                                              7 214 1 0 0 0 249 1 0 10 0 230 2
                                              0 129 0 0 240 0 0 7 105 2 0 0 0
                                              114 126 0 0 11 127 1 0 0 0 259 1
                                              0 0 0 252 1 0 122 0 123 2 0 122 0
                                              140 141 1 0 170 0 172 1 0 178 0
                                              183 1 0 175 0 177 1 0 188 0 191 1
                                              0 184 0 187 1 0 0 0 111 1 0 142 0
                                              149 1 0 11 0 23 0 0 10 113 1 0 0
                                              0 265 1 0 0 0 257 1 0 0 0 261 1 0
                                              0 0 254 1 0 7 0 245 1 0 0 0 262 1
                                              0 0 0 255 1 0 0 0 167 2 0 0 0 0
                                              291 2 0 0 0 205 287 2 0 28 0 0
                                              117 1 0 0 0 119 2 0 0 0 0 118 2 0
                                              0 7 0 121 2 0 0 25 0 125 2 0 0 0
                                              0 153)))))
           '|lookupComplete|)) 
