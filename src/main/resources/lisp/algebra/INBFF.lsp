
(SDEFUN |INBFF;inv;2V;1| ((|a| (|Vector| GF)) ($ (|Vector| GF)))
        (SPROG ((|erg| (|Vector| GF)) (|b| (|Vector| GF)) (#1=#:G716 NIL))
               (SEQ
                (LETT |b|
                      (SPADCALL
                       (SPADCALL |a|
                                 (SPADCALL
                                  (PROG1 (LETT #1# (- (QVSIZE |a|) 1))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  (QREFELT $ 17))
                                 1 (QREFELT $ 19))
                       1 (QREFELT $ 20)))
                (EXIT
                 (LETT |erg|
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |a| |b| (QREFELT $ 21)) 1
                                    (QREFELT $ 22))
                          (QREFELT $ 12) (QREFELT $ 23))
                         (QREFELT $ 24))
                        |b| (QREFELT $ 25))))))) 

(SDEFUN |INBFF;^;VIV;2|
        ((|a| (|Vector| GF)) (|ex| (|Integer|)) ($ (|Vector| GF)))
        (SPROG
         ((|mult| (|Integer|)) (|k| (|SingleInteger|))
          (|expT| (|List| (|SingleInteger|))) (|logqe| (|SingleInteger|))
          (|q1| (|SingleInteger|)) (|e1| (|SingleInteger|))
          (|e| (|NonNegativeInteger|)) (#1=#:G728 NIL) (#2=#:G727 NIL))
         (SEQ
          (LETT |e|
                (PROG1
                    (LETT #1#
                          (SPADCALL |ex|
                                    (-
                                     (EXPT (QREFELT $ 9)
                                           (PROG1 (LETT #2# (QVSIZE |a|))
                                             (|check_subtype2| (> #2# 0)
                                                               '(|PositiveInteger|)
                                                               '(|NonNegativeInteger|)
                                                               #2#)))
                                     1)
                                    (QREFELT $ 27)))
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#)))
          (EXIT
           (COND ((ZEROP |e|) (MAKEARR1 (QVSIZE |a|) (QREFELT $ 12)))
                 ((EQL |e| 1) (SPADCALL |a| (QREFELT $ 28)))
                 (#3='T
                  (SEQ
                   (LETT |e1| (SPADCALL (INTEGER-LENGTH |e|) (QREFELT $ 17)))
                   (EXIT
                    (COND
                     ((> (QREFELT $ 9) 11)
                      (SEQ
                       (LETT |q1|
                             (SPADCALL (INTEGER-LENGTH (QREFELT $ 9))
                                       (QREFELT $ 17)))
                       (LETT |logqe| (|add_SI| (|quo_SI| |e1| |q1|) 1))
                       (EXIT
                        (COND
                         ((> (* 10 (- (+ |logqe| (QREFELT $ 9)) 2))
                             (|mul_SI| 15 |e1|))
                          (SPADCALL |a| |e| (QREFELT $ 29)))
                         (#3# (SPADCALL |a| |e| 1 (QREFELT $ 30)))))))
                     (#3#
                      (SEQ
                       (LETT |logqe|
                             (|add_SI|
                              (|quo_SI| (|mul_SI| 10 |e1|)
                                        (SPADCALL (QREFELT $ 13) (QREFELT $ 9)
                                                  (QREFELT $ 32)))
                              1))
                       (LETT |k| 1)
                       (LETT |expT|
                             (SPADCALL (QREFELT $ 14) (QREFELT $ 9)
                                       (QREFELT $ 34)))
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND
                                ((SPADCALL |logqe|
                                           (SPADCALL |expT| |k| (QREFELT $ 32))
                                           (QREFELT $ 36))
                                 (NULL
                                  (|zero?_SI|
                                   (SPADCALL |expT| |k| (QREFELT $ 32)))))
                                ('T NIL)))
                              (GO G191)))
                            (SEQ (EXIT (LETT |k| (|add_SI| |k| 1)))) NIL
                            (GO G190) G191 (EXIT NIL))
                       (LETT |mult|
                             (-
                              (+
                               (* (- (QREFELT $ 9) 1)
                                  (EXPT (QREFELT $ 9) (|sub_SI| |k| 1)))
                               (|quo_SI| (|sub_SI| (|add_SI| |logqe| |k|) 1)
                                         |k|))
                              2))
                       (EXIT
                        (COND
                         ((>= (* 10 |mult|) (* 15 |e1|))
                          (SPADCALL |a| |e| (QREFELT $ 29)))
                         (#3#
                          (SPADCALL |a| |e| |k| (QREFELT $ 30)))))))))))))))) 

(SDEFUN |INBFF;repSq;VNniV;3|
        ((|b| (|Vector| GF)) (|e| (|NonNegativeInteger|)) ($ (|Vector| GF)))
        (SPROG ((|a| (|Vector| GF)))
               (SEQ (LETT |a| (SPADCALL |b| (QREFELT $ 28)))
                    (EXIT
                     (COND ((EQL |e| 1) |a|)
                           ((ODDP |e|)
                            (SPADCALL |a|
                                      (SPADCALL
                                       (SPADCALL |a| |a| (QREFELT $ 21))
                                       (QUOTIENT2 |e| 2) (QREFELT $ 29))
                                      (QREFELT $ 21)))
                           ('T
                            (SPADCALL (SPADCALL |a| |a| (QREFELT $ 21))
                                      (QUOTIENT2 |e| 2) (QREFELT $ 29)))))))) 

(SDEFUN |INBFF;dAndcExp;VNniSiV;4|
        ((|a| (|Vector| GF)) (|e| (|NonNegativeInteger|))
         (|k| #1=(|SingleInteger|)) ($ (|Vector| GF)))
        (SPROG
         ((|i| #1#) (|erg| (|Vector| GF)) (#2=#:G766 NIL) (|j| NIL)
          (|ex| (|Integer|)) (|l| (|List| (|NonNegativeInteger|)))
          (|plist| (|List| (|Vector| GF))) (|b| (|Vector| GF)) (#3=#:G765 NIL)
          (|qk| (|Integer|)))
         (SEQ (LETT |plist| (LIST (SPADCALL |a| (QREFELT $ 28))))
              (LETT |qk| (EXPT (QREFELT $ 9) |k|))
              (SEQ (LETT |j| 2) (LETT #3# (- |qk| 1)) G190
                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                   (SEQ
                    (COND
                     ((EQL (SPADCALL |j| (QREFELT $ 9) (QREFELT $ 27)) 0)
                      (LETT |b|
                            (SPADCALL
                             (SPADCALL |plist| (QUOTIENT2 |j| (QREFELT $ 9))
                                       (QREFELT $ 39))
                             1 (QREFELT $ 20))))
                     ('T
                      (LETT |b|
                            (SPADCALL |a| (SPADCALL |plist| (QREFELT $ 40))
                                      (QREFELT $ 21)))))
                    (EXIT
                     (LETT |plist| (SPADCALL |plist| |b| (QREFELT $ 41)))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (LETT |l| NIL) (LETT |ex| |e|)
              (SEQ G190 (COND ((NULL (NULL (EQL |ex| 0))) (GO G191)))
                   (SEQ
                    (LETT |l|
                          (SPADCALL |l| (SPADCALL |ex| |qk| (QREFELT $ 27))
                                    (QREFELT $ 44)))
                    (EXIT (LETT |ex| (QUOTIENT2 |ex| |qk|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((EQL (|SPADfirst| |l|) 0)
                (LETT |erg| (MAKEARR1 (QVSIZE |a|) (QREFELT $ 12))))
               ('T
                (LETT |erg|
                      (SPADCALL |plist| (|SPADfirst| |l|) (QREFELT $ 39)))))
              (LETT |i| |k|)
              (SEQ (LETT |j| NIL) (LETT #2# (CDR |l|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |j| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |j| 0 (QREFELT $ 45))
                      (LETT |erg|
                            (SPADCALL |erg|
                                      (SPADCALL
                                       (SPADCALL |plist| |j| (QREFELT $ 39))
                                       |i| (QREFELT $ 20))
                                      (QREFELT $ 21)))))
                    (EXIT (LETT |i| (|add_SI| |i| |k|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |erg|)))) 

(SDEFUN |INBFF;*;3V;5|
        ((|a| (|Vector| GF)) (|b| (|Vector| GF)) ($ (|Vector| GF)))
        (SPROG
         ((|k| (|SingleInteger|)) (|x| (|SingleInteger|)) (|y| (GF))
          (#1=#:G786 NIL) (|t| NIL) (#2=#:G785 NIL) (|j| NIL) (#3=#:G784 NIL)
          (|i| NIL) (#4=#:G783 NIL) (#5=#:G782 NIL) (|erg| (|Vector| GF))
          (|e| (|SingleInteger|)))
         (SEQ (LETT |e| (SPADCALL (QVSIZE |a|) (QREFELT $ 17)))
              (LETT |erg| (SPADCALL (QVSIZE |a|) (QREFELT $ 46)))
              (SEQ (LETT |t| NIL)
                   (LETT #5# (SPADCALL (QREFELT $ 11) 1 (QREFELT $ 50))) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |t| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #4# |e|) G190
                          (COND ((|greater_SI| |j| #4#) (GO G191)))
                          (SEQ (LETT |y| (QCAR |t|)) (LETT |x| (QCDR |t|))
                               (LETT |k|
                                     (|add_SI|
                                      (|addmod_SI| |x|
                                                   (SPADCALL |j|
                                                             (QREFELT $ 17))
                                                   |e|)
                                      1))
                               (EXIT
                                (SPADCALL |erg| |k|
                                          (SPADCALL
                                           (SPADCALL |erg| |k| (QREFELT $ 22))
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |a| |j| (QREFELT $ 22))
                                             (SPADCALL |b| |j| (QREFELT $ 22))
                                             (QREFELT $ 23))
                                            |y| (QREFELT $ 23))
                                           (QREFELT $ 51))
                                          (QREFELT $ 52))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| 1) (LETT #3# (|sub_SI| |e| 1)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| (+ |i| 1)) (LETT #2# |e|) G190
                          (COND ((> |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |t| NIL)
                                 (LETT #1#
                                       (SPADCALL (QREFELT $ 11)
                                                 (+ (- |j| |i|) 1)
                                                 (QREFELT $ 50)))
                                 G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |t| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ (LETT |y| (QCAR |t|))
                                      (LETT |x| (QCDR |t|))
                                      (LETT |k|
                                            (|add_SI|
                                             (|addmod_SI| |x|
                                                          (SPADCALL |i|
                                                                    (QREFELT $
                                                                             17))
                                                          |e|)
                                             1))
                                      (EXIT
                                       (SPADCALL |erg| |k|
                                                 (SPADCALL
                                                  (SPADCALL |erg| |k|
                                                            (QREFELT $ 22))
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |a| |i|
                                                               (QREFELT $ 22))
                                                     (SPADCALL |b| |j|
                                                               (QREFELT $ 22))
                                                     (QREFELT $ 23))
                                                    (SPADCALL
                                                     (SPADCALL |a| |j|
                                                               (QREFELT $ 22))
                                                     (SPADCALL |b| |i|
                                                               (QREFELT $ 22))
                                                     (QREFELT $ 23))
                                                    (QREFELT $ 51))
                                                   |y| (QREFELT $ 23))
                                                  (QREFELT $ 51))
                                                 (QREFELT $ 52))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |erg|)))) 

(SDEFUN |INBFF;lookup;VPi;6| ((|x| (|Vector| GF)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G790 NIL) (#2=#:G789 NIL) (|erg| (|Integer|)) (|j| NIL))
               (SEQ (LETT |erg| 0)
                    (SEQ (LETT |j| (QVSIZE |x|)) G190
                         (COND ((< |j| 1) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |erg|
                                 (+ (* |erg| (QREFELT $ 9))
                                    (REM
                                     (SPADCALL
                                      (SPADCALL |x| |j| (QREFELT $ 22))
                                      (QREFELT $ 54))
                                     (QREFELT $ 9))))))
                         (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND
                      ((EQL |erg| 0)
                       (PROG1 (LETT #2# (EXPT (QREFELT $ 9) (QVSIZE |x|)))
                         (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                           '(|NonNegativeInteger|) #2#)))
                      ('T
                       (PROG1 (LETT #1# |erg|)
                         (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                           '(|Integer|) #1#)))))))) 

(SDEFUN |INBFF;norm;VPiV;7|
        ((|a| (|Vector| GF)) (|d| (|PositiveInteger|)) ($ (|Vector| GF)))
        (SPROG
         ((|r|
           (|Record| (|:| |quotient| (|SingleInteger|))
                     (|:| |remainder| (|SingleInteger|))))
          (|dSI| (|SingleInteger|)))
         (SEQ (LETT |dSI| (SPADCALL |d| (QREFELT $ 17)))
              (LETT |r|
                    (SPADCALL (SPADCALL (QVSIZE |a|) (QREFELT $ 17)) |dSI|
                              (QREFELT $ 57)))
              (COND
               ((NULL (|eql_SI| (QCDR |r|) 0))
                (EXIT (|error| "norm: 2.arg must divide extdeg"))))
              (EXIT (SPADCALL |a| (QCAR |r|) |dSI| (QREFELT $ 19)))))) 

(SDEFUN |INBFF;expPot;V2SiV;8|
        ((|a| (|Vector| GF)) (|e| (|SingleInteger|)) (|d| #1=(|SingleInteger|))
         ($ (|Vector| GF)))
        (SPROG
         ((|qpot| #1#) (|erg| #2=(|Vector| GF)) (|k2| #1#) (|y| #2#)
          (#3=#:G807 NIL) (|k| NIL) (|deg| (|SingleInteger|)))
         (SEQ (LETT |deg| (SPADCALL (QVSIZE |a|) (QREFELT $ 17)))
              (EXIT
               (COND ((|eql_SI| |e| 1) (SPADCALL |a| (QREFELT $ 28)))
                     (#4='T
                      (SEQ (LETT |k2| |d|)
                           (LETT |y| (SPADCALL |a| (QREFELT $ 28)))
                           (COND
                            ((SPADCALL |e| 0 (QREFELT $ 59))
                             (SEQ (LETT |erg| (SPADCALL |y| (QREFELT $ 28)))
                                  (EXIT (LETT |qpot| |k2|))))
                            (#4#
                             (SEQ
                              (LETT |erg|
                                    (MAKEARR1 (QVSIZE |a|)
                                              (SPADCALL (QREFELT $ 12)
                                                        (QREFELT $ 24))))
                              (EXIT (LETT |qpot| 0)))))
                           (SEQ (LETT |k| 1) (LETT #3# (INTEGER-LENGTH |e|))
                                G190 (COND ((|greater_SI| |k| #3#) (GO G191)))
                                (SEQ
                                 (LETT |y|
                                       (SPADCALL |y|
                                                 (SPADCALL |y| |k2|
                                                           (QREFELT $ 20))
                                                 (QREFELT $ 21)))
                                 (LETT |k2| (|addmod_SI| |k2| |k2| |deg|))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |e| |k| (QREFELT $ 60))
                                    (SEQ
                                     (LETT |erg|
                                           (SPADCALL |erg|
                                                     (SPADCALL |y| |qpot|
                                                               (QREFELT $ 20))
                                                     (QREFELT $ 21)))
                                     (EXIT
                                      (LETT |qpot|
                                            (|addmod_SI| |qpot| |k2|
                                                         |deg|))))))))
                                (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT |erg|)))))))) 

(SDEFUN |INBFF;qPot;VIV;9|
        ((|e| (|Vector| GF)) (|n| (|Integer|)) ($ (|Vector| GF)))
        (SPROG
         ((#1=#:G816 NIL) (|i| NIL) (#2=#:G815 NIL) (|e1| (|Vector| GF))
          (|m| (|SingleInteger|)) (|ei| (|SingleInteger|)))
         (SEQ (LETT |ei| (SPADCALL (QVSIZE |e|) (QREFELT $ 17)))
              (LETT |m|
                    (SPADCALL (SPADCALL |n| (QREFELT $ 17)) |ei|
                              (QREFELT $ 61)))
              (EXIT
               (COND ((|zero?_SI| |m|) |e|)
                     ('T
                      (SEQ (LETT |e1| (SPADCALL (QVSIZE |e|) (QREFELT $ 46)))
                           (SEQ (LETT |i| (|add_SI| |m| 1)) (LETT #2# |ei|)
                                G190 (COND ((|greater_SI| |i| #2#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SPADCALL |e1| |i|
                                            (SPADCALL |e| (|sub_SI| |i| |m|)
                                                      (QREFELT $ 22))
                                            (QREFELT $ 52))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (SEQ (LETT |i| 1) (LETT #1# |m|) G190
                                (COND ((|greater_SI| |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SPADCALL |e1| |i|
                                            (SPADCALL |e| (- (+ |ei| |i|) |m|)
                                                      (QREFELT $ 22))
                                            (QREFELT $ 52))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT |e1|)))))))) 

(SDEFUN |INBFF;trace;VPiV;10|
        ((|a| (|Vector| GF)) (|d| (|PositiveInteger|)) ($ (|Vector| GF)))
        (SPROG
         ((#1=#:G826 NIL) (|j| NIL) (#2=#:G825 NIL) (|i| NIL)
          (|sSI| #3=(|SingleInteger|)) (|v| (|Vector| GF))
          (|r|
           (|Record| (|:| |quotient| #3#) (|:| |remainder| (|SingleInteger|))))
          (|dSI| (|SingleInteger|)))
         (SEQ (LETT |dSI| (SPADCALL |d| (QREFELT $ 17)))
              (LETT |r|
                    (SPADCALL (SPADCALL (QVSIZE |a|) (QREFELT $ 17)) |dSI|
                              (QREFELT $ 57)))
              (COND
               ((NULL (|eql_SI| (QCDR |r|) 0))
                (EXIT (|error| "trace: 2.arg must divide extdeg"))))
              (LETT |v|
                    (SPADCALL
                     (SPADCALL |a| (SPADCALL 1 |dSI| (QREFELT $ 63))
                               (QREFELT $ 64))
                     (QREFELT $ 28)))
              (LETT |sSI| (QCAR |r|))
              (SEQ (LETT |i| 1) (LETT #2# |dSI|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# (|sub_SI| |sSI| 1)) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |v| |i|
                                      (SPADCALL
                                       (SPADCALL |v| |i| (QREFELT $ 22))
                                       (SPADCALL |a|
                                                 (+ |i|
                                                    (|mul_SI|
                                                     (SPADCALL |j|
                                                               (QREFELT $ 17))
                                                     |dSI|))
                                                 (QREFELT $ 22))
                                       (QREFELT $ 51))
                                      (QREFELT $ 52))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |v|)))) 

(SDEFUN |INBFF;random;PiV;11| ((|n| (|PositiveInteger|)) ($ (|Vector| GF)))
        (SPROG ((#1=#:G831 NIL) (|i| NIL) (|v| (|Vector| GF)))
               (SEQ (LETT |v| (SPADCALL |n| (QREFELT $ 46)))
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL |v| |i| (SPADCALL (QREFELT $ 66))
                                     (QREFELT $ 52))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |v|)))) 

(SDEFUN |INBFF;xn;NniSup;12|
        ((|m| (|NonNegativeInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPADCALL (SPADCALL (|spadConstant| $ 10) |m| (QREFELT $ 69))
                  (|spadConstant| $ 70) (QREFELT $ 71))) 

(SDEFUN |INBFF;normal?;VB;13| ((|x| (|Vector| GF)) ($ (|Boolean|)))
        (COND
         ((SPADCALL
           (SPADCALL (SPADCALL (QVSIZE |x|) (QREFELT $ 72))
                     (SPADCALL |x| (QREFELT $ 73)) (QREFELT $ 74))
           (|spadConstant| $ 70) (QREFELT $ 75))
          'T)
         ('T NIL))) 

(SDEFUN |INBFF;/;3V;14|
        ((|x| (|Vector| GF)) (|y| (|Vector| GF)) ($ (|Vector| GF)))
        (SPADCALL |x| (SPADCALL |y| (QREFELT $ 26)) (QREFELT $ 21))) 

(SDEFUN |INBFF;setFieldInfo;VGFV;15|
        ((|m|
          (|Vector|
           (|List|
            (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|))))))
         (|n| (GF)) ($ (|Void|)))
        (SEQ (SETELT $ 11 |m|) (SETELT $ 12 |n|)
             (EXIT (SPADCALL (QREFELT $ 79))))) 

(SDEFUN |INBFF;minimalPolynomial;VSup;16|
        ((|x| (|Vector| GF)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|v| (|Vector| GF)) (|y| (|Vector| GF)) (#1=#:G855 NIL) (|k| NIL)
          (#2=#:G854 NIL) (|j| NIL) (|dy| #3=(|NonNegativeInteger|))
          (#4=#:G853 NIL) (|i| NIL) (|m| (|Matrix| GF)) (|dx| #3#))
         (SEQ (LETT |dx| (QVSIZE |x|))
              (LETT |y|
                    (MAKEARR1 (QVSIZE |x|)
                              (SPADCALL (QREFELT $ 12) (QREFELT $ 24))))
              (LETT |m| (SPADCALL |dx| (+ |dx| 1) (QREFELT $ 82)))
              (SEQ (LETT |i| 1) (LETT #4# (+ |dx| 1)) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ (LETT |dy| (QVSIZE |y|))
                        (SEQ (LETT |j| 1) (LETT #2# |dy|) G190
                             (COND ((|greater_SI| |j| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |k| 0)
                                    (LETT #1# (- (QUOTIENT2 |dx| |dy|) 1)) G190
                                    (COND ((|greater_SI| |k| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (QSETAREF2O |m| (+ |j| (* |k| |dy|)) |i|
                                                  (SPADCALL |y| |j|
                                                            (QREFELT $ 22))
                                                  1 1)))
                                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (LETT |y| (SPADCALL |y| |x| (QREFELT $ 21)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |v| (|SPADfirst| (SPADCALL |m| (QREFELT $ 83))))
              (EXIT (SPADCALL |v| (QREFELT $ 73)))))) 

(SDEFUN |INBFF;basis;PiV;17|
        ((|n| (|PositiveInteger|)) ($ (|Vector| (|Vector| GF))))
        (SPROG
         ((|uniti| (|Vector| GF)) (#1=#:G861 NIL) (|i| NIL)
          (|bas| (|Vector| (|Vector| GF))))
         (SEQ (LETT |bas| (MAKEARR1 |n| (SPADCALL |n| (QREFELT $ 46))))
              (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ (LETT |uniti| (SPADCALL |n| (QREFELT $ 46)))
                        (QSETAREF1O |uniti| |i| (|spadConstant| $ 10) 1)
                        (EXIT (QSETAREF1O |bas| |i| |uniti| 1)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |bas|)))) 

(SDEFUN |INBFF;normalElement;PiV;18|
        ((|n| (|PositiveInteger|)) ($ (|Vector| GF)))
        (SPROG ((|v| (|Vector| GF)))
               (SEQ (LETT |v| (SPADCALL |n| (QREFELT $ 46)))
                    (QSETAREF1O |v| 1 (|spadConstant| $ 10) 1) (EXIT |v|)))) 

(SDEFUN |INBFF;index;2PiV;19|
        ((|degm| (|PositiveInteger|)) (|n| (|PositiveInteger|))
         ($ (|Vector| GF)))
        (SPROG
         ((|m| (|Integer|)) (#1=#:G869 NIL) (|j| NIL) (|erg| (|Vector| GF)))
         (SEQ (LETT |m| (REM |n| (EXPT (QREFELT $ 9) |degm|)))
              (LETT |erg| (SPADCALL |degm| (QREFELT $ 46)))
              (SEQ (LETT |j| 1) (LETT #1# |degm|) G190
                   (COND ((|greater_SI| |j| #1#) (GO G191)))
                   (SEQ
                    (SPADCALL |erg| |j|
                              (SPADCALL
                               (+ (QREFELT $ 9) (REM |m| (QREFELT $ 9)))
                               (QREFELT $ 88))
                              (QREFELT $ 52))
                    (EXIT (LETT |m| (QUOTIENT2 |m| (QREFELT $ 9)))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT |erg|)))) 

(SDEFUN |INBFF;pol;VSup;20|
        ((|x| (|Vector| GF)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((#1=#:G871 NIL) (#2=#:G870 #3=(|SparseUnivariatePolynomial| GF))
          (#4=#:G872 #3#) (#5=#:G873 NIL) (#6=#:G875 NIL) (|i| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |i| 1) (LETT #6# (QVSIZE |x|)) G190
                (COND ((|greater_SI| |i| #6#) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4#
                         (SPADCALL (SPADCALL |x| |i| (QREFELT $ 22))
                                   (PROG1 (LETT #5# (- |i| 1))
                                     (|check_subtype2| (>= #5# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #5#))
                                   (QREFELT $ 69)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 90))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 91))))))) 

(DECLAIM (NOTINLINE |InnerNormalBasisFieldFunctions;|)) 

(DEFUN |InnerNormalBasisFieldFunctions| (#1=#:G876)
  (SPROG NIL
         (PROG (#2=#:G877)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|InnerNormalBasisFieldFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|InnerNormalBasisFieldFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerNormalBasisFieldFunctions|)))))))))) 

(DEFUN |InnerNormalBasisFieldFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|InnerNormalBasisFieldFunctions| DV$1))
          (LETT $ (GETREFV 92))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InnerNormalBasisFieldFunctions|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          (QSETREFV $ 11 (MAKEARR1 1 NIL))
          (QSETREFV $ 12 (|spadConstant| $ 10))
          (QSETREFV $ 13 (LIST 0 10 16 20 23 0 28 30 32 0 35))
          (QSETREFV $ 14
                    (LIST NIL (LIST 4 12 48 160 480 0) (LIST 8 72 432 0)
                          (LIST 18 216 0) (LIST 32 480 0) NIL (LIST 72 0)
                          (LIST 98 0) (LIST 128 0) NIL (LIST 200 0)))
          $))) 

(MAKEPROP '|InnerNormalBasisFieldFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              (0 . |size|) '|sizeGF| (4 . |One|) '|multTable| '|trGen| '|logq|
              '|expTable| (|Integer|) (|SingleInteger|) (8 . |coerce|)
              (|Vector| 6) |INBFF;expPot;V2SiV;8| |INBFF;qPot;VIV;9|
              |INBFF;*;3V;5| (13 . |elt|) (19 . *) (25 . |inv|) (30 . *)
              |INBFF;inv;2V;1| (36 . |positiveRemainder|) (42 . |copy|)
              |INBFF;repSq;VNniV;3| |INBFF;dAndcExp;VNniSiV;4| (|List| 16)
              (47 . |elt|) (|List| 31) (53 . |elt|) (|Boolean|) (59 . >=)
              |INBFF;^;VIV;2| (|List| 18) (65 . |elt|) (71 . |last|)
              (76 . |concat|) (82 . |Zero|) (|List| 7) (86 . |concat|)
              (92 . ~=) (98 . |zero|)
              (|Record| (|:| |value| 6) (|:| |index| 16)) (|List| 47)
              (|Vector| 48) (103 . |elt|) (109 . +) (115 . |setelt!|)
              (|PositiveInteger|) (122 . |lookup|) |INBFF;lookup;VPi;6|
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (127 . |divide|) |INBFF;norm;VPiV;7| (133 . |bit?|)
              (139 . |bit?|) (145 . |positiveRemainder|)
              (|UniversalSegment| 15) (151 . SEGMENT) (157 . |elt|)
              |INBFF;trace;VPiV;10| (163 . |random|) |INBFF;random;PiV;11|
              (|SparseUnivariatePolynomial| 6) (167 . |monomial|) (173 . |One|)
              (177 . -) |INBFF;xn;NniSup;12| |INBFF;pol;VSup;20| (183 . |gcd|)
              (189 . =) |INBFF;normal?;VB;13| |INBFF;/;3V;14| (|Void|)
              (195 . |void|) |INBFF;setFieldInfo;VGFV;15| (|Matrix| 6)
              (199 . |zero|) (205 . |nullSpace|)
              |INBFF;minimalPolynomial;VSup;16| (|Vector| 18)
              |INBFF;basis;PiV;17| |INBFF;normalElement;PiV;18| (210 . |index|)
              |INBFF;index;2PiV;19| (215 . +) (221 . |Zero|))
           '#(|xn| 225 |trace| 230 |setFieldInfo| 236 |repSq| 242 |random| 248
              |qPot| 253 |pol| 259 |normalElement| 264 |normal?| 269 |norm| 274
              |minimalPolynomial| 280 |lookup| 285 |inv| 290 |index| 295
              |expPot| 301 |dAndcExp| 308 |basis| 315 ^ 320 / 326 * 332)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|setFieldInfo|
                                 ((|Void|)
                                  (|Vector|
                                   (|List|
                                    (|Record| (|:| |value| |#1|)
                                              (|:| |index|
                                                   (|SingleInteger|)))))
                                  |#1|))
                                T)
                              '((|random|
                                 ((|Vector| |#1|) (|PositiveInteger|)))
                                T)
                              '((|index|
                                 ((|Vector| |#1|) (|PositiveInteger|)
                                  (|PositiveInteger|)))
                                T)
                              '((|pol|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((|xn|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|dAndcExp|
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|NonNegativeInteger|) (|SingleInteger|)))
                                T)
                              '((|repSq|
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|expPot|
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|SingleInteger|) (|SingleInteger|)))
                                T)
                              '((|qPot|
                                 ((|Vector| |#1|) (|Vector| |#1|) (|Integer|)))
                                T)
                              '((^
                                 ((|Vector| |#1|) (|Vector| |#1|) (|Integer|)))
                                T)
                              '((*
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((/
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((|norm|
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|trace|
                                 ((|Vector| |#1|) (|Vector| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|inv| ((|Vector| |#1|) (|Vector| |#1|))) T)
                              '((|lookup|
                                 ((|PositiveInteger|) (|Vector| |#1|)))
                                T)
                              '((|normal?| ((|Boolean|) (|Vector| |#1|))) T)
                              '((|basis|
                                 ((|Vector| (|Vector| |#1|))
                                  (|PositiveInteger|)))
                                T)
                              '((|normalElement|
                                 ((|Vector| |#1|) (|PositiveInteger|)))
                                T)
                              '((|minimalPolynomial|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|Vector| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 91
                                            '(0 6 7 8 0 6 0 10 1 16 0 15 17 2
                                              18 6 0 15 22 2 6 0 0 0 23 1 6 0 0
                                              24 2 18 0 6 0 25 2 15 0 0 0 27 1
                                              18 0 0 28 2 31 16 0 15 32 2 33 31
                                              0 15 34 2 16 35 0 0 36 2 38 18 0
                                              15 39 1 38 18 0 40 2 38 0 0 18 41
                                              0 6 0 42 2 43 0 0 7 44 2 7 35 0 0
                                              45 1 18 0 7 46 2 49 48 0 15 50 2
                                              6 0 0 0 51 3 18 6 0 15 6 52 1 6
                                              53 0 54 2 16 56 0 0 57 2 16 35 0
                                              0 59 2 15 35 0 0 60 2 16 0 0 0 61
                                              2 62 0 15 15 63 2 18 0 0 62 64 0
                                              6 0 66 2 68 0 6 7 69 0 68 0 70 2
                                              68 0 0 0 71 2 68 0 0 0 74 2 68 35
                                              0 0 75 0 78 0 79 2 81 0 7 7 82 1
                                              81 38 0 83 1 6 0 53 88 2 68 0 0 0
                                              90 0 68 0 91 1 0 68 7 72 2 0 18
                                              18 53 65 2 0 78 49 6 80 2 0 18 18
                                              7 29 1 0 18 53 67 2 0 18 18 15 20
                                              1 0 68 18 73 1 0 18 53 87 1 0 35
                                              18 76 2 0 18 18 53 58 1 0 68 18
                                              84 1 0 53 18 55 1 0 18 18 26 2 0
                                              18 53 53 89 3 0 18 18 16 16 19 3
                                              0 18 18 7 16 30 1 0 85 53 86 2 0
                                              18 18 15 37 2 0 18 18 18 77 2 0
                                              18 18 18 21)))))
           '|lookupComplete|)) 
