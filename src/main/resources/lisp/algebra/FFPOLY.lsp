
(SDEFUN |FFPOLY;get_deg_GF| (($ (|PositiveInteger|)))
        (SPROG
         ((#1=#:G745 NIL) (|n| (|PositiveInteger|))
          (|ss| (|NonNegativeInteger|)) (#2=#:G740 NIL))
         (SEQ
          (COND
           ((EQL (QREFELT $ 12) 0)
            (SEQ (LETT |n| 1) (LETT |ss| (QREFELT $ 9))
                 (SEQ G190 (COND ((NULL (> |ss| (QREFELT $ 11))) (GO G191)))
                      (SEQ
                       (LETT |ss|
                             (PROG2
                                 (LETT #2#
                                       (SPADCALL |ss| (QREFELT $ 11)
                                                 (QREFELT $ 15)))
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 0)
                                               (|NonNegativeInteger|)
                                               (|Union| (|NonNegativeInteger|)
                                                        "failed")
                                               #2#)))
                       (EXIT (LETT |n| (+ |n| 1))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT (SETELT $ 12 |n|)))))
          (EXIT
           (PROG1 (LETT #1# (QREFELT $ 12))
             (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                               '(|NonNegativeInteger|) #1#)))))) 

(SDEFUN |FFPOLY;listToSUP|
        ((|l|
          (|List|
           (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
         ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|newl|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (#1=#:G765 NIL) (|t| NIL) (#2=#:G764 NIL))
         (SEQ
          (LETT |newl|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #2# (CONS (CONS (CAR |t|) (CDR |t|)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT |newl|)))) 

(SDEFUN |FFPOLY;reducedQPowers;SupPa;3|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|PrimitiveArray| (|SparseUnivariatePolynomial| GF))))
        (SPROG
         ((|h| (|SparseUnivariatePolynomial| GF))
          (|g| (|SparseUnivariatePolynomial| GF)) (#1=#:G785 NIL) (|i| NIL)
          (|qexp| #2=(|PrimitiveArray| (|SparseUnivariatePolynomial| GF)))
          (|w| (MM)) (#3=#:G784 NIL) (|qpow| #2#) (|e| (MM)) (|m1| (|Integer|))
          (|m| (|PositiveInteger|)))
         (SEQ (LETT |m| (SPADCALL |f| (QREFELT $ 25))) (LETT |m1| (- |m| 1))
              (SPADCALL |f| (QREFELT $ 26))
              (LETT |e|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 16) 1 (QREFELT $ 27))
                      (QREFELT $ 28))
                     (QREFELT $ 9) (QREFELT $ 29)))
              (LETT |w| (|spadConstant| $ 30))
              (LETT |qpow| (MAKEARR1 |m| (|spadConstant| $ 31)))
              (QSETAREF1 |qpow| 0 (|spadConstant| $ 32))
              (SEQ (LETT |i| 1) (LETT #3# |m1|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 |qpow| |i|
                                (SPADCALL
                                 (LETT |w| (SPADCALL |w| |e| (QREFELT $ 33)))
                                 (QREFELT $ 34)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |qexp| (MAKEARR1 |m| (|spadConstant| $ 31)))
              (EXIT
               (COND
                ((EQL |m| 1)
                 (SEQ
                  (QSETAREF1 |qexp| 0
                             (SPADCALL
                              (SPADCALL (SPADCALL |f| 0 (QREFELT $ 35))
                                        (QREFELT $ 36))
                              (QREFELT $ 37)))
                  (EXIT |qexp|)))
                ('T
                 (SEQ
                  (QSETAREF1 |qexp| 0
                             (SPADCALL (|spadConstant| $ 16) 1 (QREFELT $ 27)))
                  (LETT |h| (QAREF1 |qpow| 1)) (QSETAREF1 |qexp| 1 |h|)
                  (SEQ (LETT |i| 2) (LETT #1# |m1|) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ (LETT |g| (|spadConstant| $ 31))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (SPADCALL |h| (|spadConstant| $ 31)
                                              (QREFELT $ 39)))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |g|
                                        (SPADCALL |g|
                                                  (SPADCALL
                                                   (SPADCALL |h|
                                                             (QREFELT $ 40))
                                                   (QAREF1 |qpow|
                                                           (SPADCALL |h|
                                                                     (QREFELT $
                                                                              25)))
                                                   (QREFELT $ 41))
                                                  (QREFELT $ 42)))
                                  (EXIT
                                   (LETT |h| (SPADCALL |h| (QREFELT $ 43)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (QSETAREF1 |qexp| |i| (LETT |h| |g|))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |qexp|)))))))) 

(SDEFUN |FFPOLY;leastAffineMultiple;2Sup;4|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((#1=#:G799 NIL) (#2=#:G798 #3=(|SparseUnivariatePolynomial| GF))
          (#4=#:G800 #3#) (#5=#:G802 NIL) (#6=#:G808 NIL) (|k| NIL)
          (|coeffVector| #7=(|Vector| GF)) (|dim| (|NonNegativeInteger|))
          (|i| (|PositiveInteger|)) (#8=#:G807 NIL) (|nse| NIL)
          (|ns| (|List| #7#)) (|col1| (|Matrix| GF)) (|b| (|Matrix| GF))
          (#9=#:G806 NIL) (|ii| NIL) (#10=#:G805 NIL)
          (|n| (|NonNegativeInteger|))
          (|qexp| (|PrimitiveArray| (|SparseUnivariatePolynomial| GF)))
          (|lcf| (GF)))
         (SEQ
          (COND
           ((SPADCALL (LETT |lcf| (SPADCALL |f| (QREFELT $ 40)))
                      (|spadConstant| $ 16) (QREFELT $ 46))
            (LETT |f|
                  (SPADCALL (SPADCALL |lcf| (QREFELT $ 47)) |f|
                            (QREFELT $ 41)))))
          (LETT |qexp| (SPADCALL |f| (QREFELT $ 45)))
          (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
          (LETT |b|
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #10# NIL)
                   (SEQ (LETT |ii| 0) (LETT #9# (- |n| 1)) G190
                        (COND ((|greater_SI| |ii| #9#) (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #10#
                                (CONS
                                 (SPADCALL
                                  (SPADCALL (QAREF1 |qexp| |ii|) |n|
                                            (QREFELT $ 49))
                                  (QREFELT $ 51))
                                 #10#))))
                        (LETT |ii| (|inc_SI| |ii|)) (GO G190) G191
                        (EXIT (NREVERSE #10#))))
                  (QREFELT $ 54))
                 (QREFELT $ 55)))
          (LETT |col1| (MAKE_MATRIX1 |n| 1 (|spadConstant| $ 13)))
          (SPADCALL |col1| 1 1 (|spadConstant| $ 16) (QREFELT $ 57))
          (LETT |ns|
                (SPADCALL (SPADCALL |col1| |b| (QREFELT $ 58)) (QREFELT $ 60)))
          (LETT |dim| (+ |n| 2))
          (SEQ (LETT |nse| NIL) (LETT #8# |ns|) G190
               (COND
                ((OR (ATOM #8#) (PROGN (LETT |nse| (CAR #8#)) NIL)) (GO G191)))
               (SEQ (LETT |i| (+ |n| 1))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL (SPADCALL |nse| |i| (QREFELT $ 61))
                                      (|spadConstant| $ 13) (QREFELT $ 62)))
                           (GO G191)))
                         (SEQ (EXIT (LETT |i| (- |i| 1)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (EXIT
                     (COND
                      ((< |i| |dim|)
                       (SEQ (LETT |dim| |i|)
                            (EXIT (LETT |coeffVector| |nse|)))))))
               (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL
            (SPADCALL (SPADCALL |coeffVector| 1 (QREFELT $ 61)) (QREFELT $ 37))
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT |k| 2) (LETT #6# |dim|) G190
                  (COND ((|greater_SI| |k| #6#) (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (SPADCALL
                            (SPADCALL |coeffVector| |k| (QREFELT $ 61))
                            (EXPT (QREFELT $ 9)
                                  (PROG1 (LETT #5# (- |k| 2))
                                    (|check_subtype2| (>= #5# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #5#)))
                            (QREFELT $ 27)))
                     (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 42))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                  (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) ('T (|spadConstant| $ 31))))
            (QREFELT $ 42)))))) 

(SDEFUN |FFPOLY;numberOfIrreduciblePoly;2Pi;5|
        ((|n| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG
         ((#1=#:G812 NIL) (|lastd| (|PositiveInteger|)) (|sum| (|Integer|))
          (|qd| (|PositiveInteger|)) (#2=#:G815 NIL) (|d| NIL)
          (|divisorsOfn| (|List| (|PositiveInteger|))))
         (SEQ
          (COND ((EQL |n| 1) (QREFELT $ 9))
                ('T
                 (SEQ (LETT |lastd| 1) (LETT |qd| (QREFELT $ 9))
                      (LETT |sum| (* (SPADCALL |n| (QREFELT $ 65)) |qd|))
                      (LETT |divisorsOfn| (CDR (SPADCALL |n| (QREFELT $ 67))))
                      (SEQ (LETT |d| NIL) (LETT #2# |divisorsOfn|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |d| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |qd|
                                  (* |qd|
                                     (EXPT (QREFELT $ 9) (- |d| |lastd|))))
                            (LETT |sum|
                                  (+ |sum|
                                     (*
                                      (SPADCALL (QUOTIENT2 |n| |d|)
                                                (QREFELT $ 65))
                                      |qd|)))
                            (EXIT (LETT |lastd| |d|)))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (PROG1 (LETT #1# (QUOTIENT2 |sum| |n|))
                         (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                           '(|Integer|) #1#))))))))) 

(SDEFUN |FFPOLY;numberOfPrimitivePoly;2Pi;6|
        ((|n| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G816 NIL))
               (PROG1
                   (LETT #1#
                         (QUOTIENT2
                          (SPADCALL (- (EXPT (QREFELT $ 9) |n|) 1)
                                    (QREFELT $ 69))
                          |n|))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                   #1#)))) 

(SDEFUN |FFPOLY;numberOfNormalPoly;2Pi;7|
        ((|n| #1=(|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG
         ((|prod| (|Integer|)) (|qe| #2=(|PositiveInteger|))
          (|e| (|PositiveInteger|)) (#3=#:G940 NIL) (|d| NIL)
          (|divisorsOfm| (|List| (|PositiveInteger|))) (#4=#:G930 NIL)
          (#5=#:G929 NIL) (|m| #1#) (#6=#:G823 NIL) (|q| #2#)
          (|p| (|PositiveInteger|)) (#7=#:G821 NIL) (#8=#:G820 NIL)
          (#9=#:G819 NIL))
         (SEQ
          (COND
           ((EQL |n| 1)
            (PROG1
                (LETT #8#
                      (PROG1 (LETT #9# (- (QREFELT $ 9) 1))
                        (|check_subtype2| (>= #9# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #9#)))
              (|check_subtype2| (> #8# 0) '(|PositiveInteger|)
                                '(|NonNegativeInteger|) #8#)))
           (#10='T
            (SEQ (LETT |m| |n|)
                 (LETT |p|
                       (PROG1 (LETT #7# (SPADCALL (QREFELT $ 10)))
                         (|check_subtype2| (> #7# 0) '(|PositiveInteger|)
                                           '(|NonNegativeInteger|) #7#)))
                 (LETT |q| (QREFELT $ 9))
                 (SEQ G190 (COND ((NULL (EQL (REM |m| |p|) 0)) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |m|
                              (PROG1 (LETT #6# (QUOTIENT2 |m| |p|))
                                (|check_subtype2| (> #6# 0)
                                                  '(|PositiveInteger|)
                                                  '(|NonNegativeInteger|)
                                                  #6#)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (COND
                   ((EQL |m| 1)
                    (PROG1
                        (LETT #4#
                              (QUOTIENT2
                               (*
                                (EXPT |q|
                                      (PROG1 (LETT #5# (- |n| 1))
                                        (|check_subtype2| (>= #5# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #5#)))
                                (- |q| 1))
                               |n|))
                      (|check_subtype2| (> #4# 0) '(|PositiveInteger|)
                                        '(|Integer|) #4#)))
                   (#10#
                    (SEQ (LETT |prod| (- |q| 1))
                         (LETT |divisorsOfm|
                               (CDR (SPADCALL |m| (QREFELT $ 67))))
                         (SEQ (LETT |d| NIL) (LETT #3# |divisorsOfm|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |d| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |e| 1) (LETT |qe| |q|)
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (SPADCALL (REM |qe| |d|) 1
                                                     (QREFELT $ 71)))
                                          (GO G191)))
                                        (SEQ (LETT |e| (+ |e| 1))
                                             (EXIT (LETT |qe| (* |qe| |q|))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (EXIT
                                    (LETT |prod|
                                          (* |prod|
                                             (EXPT (- |qe| 1)
                                                   (QUOTIENT2
                                                    (SPADCALL |d|
                                                              (QREFELT $ 69))
                                                    |e|))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                         (EXIT
                          (QUOTIENT2 (* (EXPT |q| (- |n| |m|)) |prod|)
                                     |n|)))))))))))) 

(SDEFUN |FFPOLY;primitive_i?|
        ((|f| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G964 NIL) (#2=#:G965 NIL) (|expt| (|NonNegativeInteger|))
          (#3=#:G967 NIL) (|d| NIL) (|lfact| (|List| (|PositiveInteger|)))
          (#4=#:G955 NIL) (#5=#:G966 NIL) (|rec| NIL)
          (|lrec|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|Integer|))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|x| (MM)) (|qn1| (|PositiveInteger|)) (#6=#:G943 NIL)
          (#7=#:G942 NIL) (|q| (|PositiveInteger|))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                (EXIT
                 (COND ((EQL |n| 0) NIL)
                       ('T
                        (SEQ (LETT |q| (QREFELT $ 9))
                             (LETT |qn1|
                                   (PROG1
                                       (LETT #6#
                                             (PROG1
                                                 (LETT #7#
                                                       (- (EXPT |q| |n|) 1))
                                               (|check_subtype2| (>= #7# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #7#)))
                                     (|check_subtype2| (> #6# 0)
                                                       '(|PositiveInteger|)
                                                       '(|NonNegativeInteger|)
                                                       #6#)))
                             (SPADCALL |f| (QREFELT $ 26))
                             (LETT |x|
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 16) 1
                                              (QREFELT $ 27))
                                    (QREFELT $ 28)))
                             (LETT |lrec|
                                   (SPADCALL (SPADCALL |qn1| (QREFELT $ 74))
                                             (QREFELT $ 79)))
                             (LETT |lfact| NIL)
                             (SEQ (LETT |rec| NIL) (LETT #5# |lrec|) G190
                                  (COND
                                   ((OR (ATOM #5#)
                                        (PROGN (LETT |rec| (CAR #5#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT |lfact|
                                          (CONS
                                           (PROG1 (LETT #4# (QVELT |rec| 1))
                                             (|check_subtype2| (> #4# 0)
                                                               '(|PositiveInteger|)
                                                               '(|Integer|)
                                                               #4#))
                                           |lfact|))))
                                  (LETT #5# (CDR #5#)) (GO G190) G191
                                  (EXIT NIL))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |d| NIL) (LETT #3# |lfact|) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |d| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ (LETT |expt| (QUOTIENT2 |qn1| |d|))
                                         (EXIT
                                          (COND
                                           ((>= |expt| |n|)
                                            (COND
                                             ((SPADCALL
                                               (SPADCALL
                                                (SPADCALL |x| |expt|
                                                          (QREFELT $ 29))
                                                (QREFELT $ 34))
                                               (|spadConstant| $ 32)
                                               (QREFELT $ 80))
                                              (PROGN
                                               (LETT #1#
                                                     (PROGN
                                                      (LETT #2# NIL)
                                                      (GO #8=#:G963)))
                                               (GO #9=#:G960))))))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT NIL)))
                              #9# (EXIT #1#))
                             (EXIT 'T)))))))
          #8# (EXIT #2#)))) 

(SDEFUN |FFPOLY;primitive?;SupB;9|
        ((|f| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (COND
         ((OR (EQL (SPADCALL |f| (QREFELT $ 25)) 0)
              (OR
               (SPADCALL (SPADCALL |f| (QREFELT $ 40)) (|spadConstant| $ 16)
                         (QREFELT $ 46))
               (OR
                (SPADCALL (SPADCALL |f| 0 (QREFELT $ 35)) (|spadConstant| $ 13)
                          (QREFELT $ 62))
                (NULL (SPADCALL |f| (QREFELT $ 82))))))
          NIL)
         ('T (|FFPOLY;primitive_i?| |f| $)))) 

(SDEFUN |FFPOLY;normal?;SupB;10|
        ((|f| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG
         ((|l| (|List| (|List| GF))) (#1=#:G985 NIL) (#2=#:G977 NIL) (|i| NIL)
          (#3=#:G984 NIL)
          (|g| (|PrimitiveArray| (|SparseUnivariatePolynomial| GF)))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
              (EXIT
               (COND
                ((OR (EQL |n| 0)
                     (OR
                      (SPADCALL (SPADCALL |f| (QREFELT $ 40))
                                (|spadConstant| $ 16) (QREFELT $ 46))
                      (SPADCALL (SPADCALL |f| 0 (QREFELT $ 35))
                                (|spadConstant| $ 13) (QREFELT $ 62))))
                 NIL)
                ((EQL |n| 1) 'T)
                (#4='T
                 (COND ((NULL (SPADCALL |f| (QREFELT $ 82))) NIL)
                       ('T
                        (SEQ (LETT |g| (SPADCALL |f| (QREFELT $ 45)))
                             (LETT |l|
                                   (PROGN
                                    (LETT #3# NIL)
                                    (SEQ (LETT |i| 0)
                                         (LETT #1#
                                               (PROG1 (LETT #2# (- |n| 1))
                                                 (|check_subtype2| (>= #2# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #2#)))
                                         G190
                                         (COND
                                          ((|greater_SI| |i| #1#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #3#
                                                 (CONS
                                                  (SPADCALL
                                                   (SPADCALL (QAREF1 |g| |i|)
                                                             |n|
                                                             (QREFELT $ 49))
                                                   (QREFELT $ 51))
                                                  #3#))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT (NREVERSE #3#)))))
                             (EXIT
                              (COND
                               ((EQL
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 54))
                                           (QREFELT $ 84))
                                 |n|)
                                'T)
                               (#4# NIL)))))))))))) 

(SDEFUN |FFPOLY;normal_and_primitive?|
        ((|f| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (COND ((SPADCALL |f| (QREFELT $ 85)) (|FFPOLY;primitive_i?| |f| $))
              ('T NIL))) 

(SDEFUN |FFPOLY;nextSubset|
        ((|s| (|List| (|NonNegativeInteger|))) (|bound| (|NonNegativeInteger|))
         ($ (|Union| (|List| (|NonNegativeInteger|)) "failed")))
        (SPROG
         ((|j| NIL) (#1=#:G1006 NIL) (|i| (|NonNegativeInteger|))
          (|firstOfs| #2=(|NonNegativeInteger|)) (|noGap| (|Boolean|))
          (|firstOfsPlus1| (|NonNegativeInteger|)) (|secondOfs| #2#)
          (|restOfs| (|List| (|NonNegativeInteger|)))
          (|m| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 87)))
                (EXIT
                 (COND ((EQL |m| 0) (CONS 0 (LIST 1)))
                       (#3='T
                        (SEQ (LETT |noGap| 'T) (LETT |i| 0)
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (COND
                                      (|noGap|
                                       (NULL
                                        (NULL (LETT |restOfs| (CDR |s|)))))
                                      ('T NIL)))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |secondOfs| (|SPADfirst| |restOfs|))
                                   (LETT |firstOfsPlus1|
                                         (+ (|SPADfirst| |s|) 1))
                                   (EXIT
                                    (COND
                                     ((EQL |secondOfs| |firstOfsPlus1|)
                                      (SEQ (LETT |s| |restOfs|)
                                           (EXIT (LETT |i| (+ |i| 1)))))
                                     ('T
                                      (SEQ
                                       (SPADCALL |s| |firstOfsPlus1|
                                                 (QREFELT $ 88))
                                       (EXIT (LETT |noGap| NIL)))))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (COND
                              (|noGap|
                               (SEQ (LETT |firstOfs| (|SPADfirst| |s|))
                                    (EXIT
                                     (COND
                                      ((< |firstOfs| |bound|)
                                       (SPADCALL |s| (+ |firstOfs| 1)
                                                 (QREFELT $ 88)))
                                      ((< |m| |bound|)
                                       (SEQ
                                        (SPADCALL |s| (+ |m| 1) (QREFELT $ 88))
                                        (EXIT (LETT |i| |m|))))
                                      (#3#
                                       (PROGN
                                        (LETT #1# (CONS 1 "failed"))
                                        (GO #4=#:G1005))))))))
                             (SEQ (LETT |j| |i|) G190
                                  (COND ((< |j| 1) (GO G191)))
                                  (SEQ (EXIT (LETT |s| (CONS |j| |s|))))
                                  (LETT |j| (+ |j| -1)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT (CONS 0 |s|))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |FFPOLY;lexSmaller?;2SupB;13|
        ((|f| (|SparseUnivariatePolynomial| GF))
         (|g| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG
         ((|g1| #1=(|SparseUnivariatePolynomial| GF)) (|f1| #1#)
          (#2=#:G1019 NIL) (|k2| #3=(|NonNegativeInteger|)) (|k1| #3#)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                (EXIT
                 (COND
                  ((SPADCALL |n| (SPADCALL |g| (QREFELT $ 25)) (QREFELT $ 71))
                   (|error| "polynomials must have equal degrees"))
                  ((< |n| 1) (|error| "polynomials must have positive degree"))
                  (#4='T
                   (SEQ (LETT |k1| (SPADCALL |f| (QREFELT $ 89)))
                        (LETT |k2| (SPADCALL |g| (QREFELT $ 89)))
                        (EXIT
                         (COND ((< |k1| |k2|) 'T) ((< |k2| |k1|) NIL)
                               (#4#
                                (SEQ (LETT |f1| (SPADCALL |f| (QREFELT $ 43)))
                                     (LETT |g1| (SPADCALL |g| (QREFELT $ 43)))
                                     (SEQ G190
                                          (COND
                                           ((NULL
                                             (SPADCALL |f1|
                                                       (|spadConstant| $ 31)
                                                       (QREFELT $ 39)))
                                            (GO G191)))
                                          (SEQ
                                           (LETT |k1|
                                                 (SPADCALL |f1|
                                                           (QREFELT $ 25)))
                                           (LETT |k2|
                                                 (SPADCALL |g1|
                                                           (QREFELT $ 25)))
                                           (EXIT
                                            (COND
                                             ((< |k1| |k2|)
                                              (PROGN
                                               (LETT #2# 'T)
                                               (GO #5=#:G1018)))
                                             ((< |k2| |k1|)
                                              (PROGN (LETT #2# NIL) (GO #5#)))
                                             ('T
                                              (SEQ
                                               (LETT |f1|
                                                     (SPADCALL |f1|
                                                               (QREFELT $ 43)))
                                               (EXIT
                                                (LETT |g1|
                                                      (SPADCALL |g1|
                                                                (QREFELT $
                                                                         43)))))))))
                                          NIL (GO G190) G191 (EXIT NIL))
                                     (LETT |f1| (SPADCALL |f| (QREFELT $ 43)))
                                     (LETT |g1| (SPADCALL |g| (QREFELT $ 43)))
                                     (SEQ G190
                                          (COND
                                           ((NULL
                                             (SPADCALL |f1|
                                                       (|spadConstant| $ 31)
                                                       (QREFELT $ 39)))
                                            (GO G191)))
                                          (SEQ
                                           (LETT |k1|
                                                 (SPADCALL
                                                  (SPADCALL |f1|
                                                            (QREFELT $ 40))
                                                  (QREFELT $ 90)))
                                           (LETT |k2|
                                                 (SPADCALL
                                                  (SPADCALL |g1|
                                                            (QREFELT $ 40))
                                                  (QREFELT $ 90)))
                                           (EXIT
                                            (COND
                                             ((< |k1| |k2|)
                                              (PROGN (LETT #2# 'T) (GO #5#)))
                                             ((< |k2| |k1|)
                                              (PROGN (LETT #2# NIL) (GO #5#)))
                                             ('T
                                              (SEQ
                                               (LETT |f1|
                                                     (SPADCALL |f1|
                                                               (QREFELT $ 43)))
                                               (EXIT
                                                (LETT |g1|
                                                      (SPADCALL |g1|
                                                                (QREFELT $
                                                                         43)))))))))
                                          NIL (GO G190) G191 (EXIT NIL))
                                     (EXIT NIL)))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FFPOLY;ll_cmp| ((|x1| (GF)) (|x2| (GF)) ($ (|SingleInteger|)))
        (SPROG ((|k2| #1=(|PositiveInteger|)) (|k1| #1#))
               (SEQ
                (COND
                 ((SPADCALL |x1| (|spadConstant| $ 13) (QREFELT $ 62))
                  (COND
                   ((SPADCALL |x2| (|spadConstant| $ 13) (QREFELT $ 46))
                    (EXIT -1)))))
                (COND
                 ((SPADCALL |x1| (|spadConstant| $ 13) (QREFELT $ 46))
                  (COND
                   ((SPADCALL |x2| (|spadConstant| $ 13) (QREFELT $ 62))
                    (EXIT 1)))))
                (LETT |k1| (SPADCALL |x1| (QREFELT $ 90)))
                (LETT |k2| (SPADCALL |x2| (QREFELT $ 90)))
                (EXIT (COND ((< |k1| |k2|) -1) ((< |k2| |k2|) 1) ('T 0)))))) 

(SDEFUN |FFPOLY;clexSmaller?;2SupB;15|
        ((|f| (|SparseUnivariatePolynomial| GF))
         (|g| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG ((|s| (|SingleInteger|)) (|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                    (EXIT
                     (COND
                      ((SPADCALL |n| (SPADCALL |g| (QREFELT $ 25))
                                 (QREFELT $ 71))
                       (|error| "polynomials must have equal degrees"))
                      ((< |n| 1)
                       (|error| "polynomials must have positive degree"))
                      (#1='T
                       (SEQ
                        (LETT |s|
                              (|FFPOLY;ll_cmp| (SPADCALL |f| 0 (QREFELT $ 35))
                               (SPADCALL |g| 0 (QREFELT $ 35)) $))
                        (EXIT
                         (COND ((|less_SI| |s| 0) 'T) ((|less_SI| 0 |s|) NIL)
                               (#1# (SPADCALL |f| |g| (QREFELT $ 91)))))))))))) 

(SDEFUN |FFPOLY;nlexSmaller?;2SupB;16|
        ((|f| (|SparseUnivariatePolynomial| GF))
         (|g| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG
         ((|s| (|SingleInteger|)) (#1=#:G1028 NIL) (#2=#:G1027 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
              (EXIT
               (COND
                ((SPADCALL |n| (SPADCALL |g| (QREFELT $ 25)) (QREFELT $ 71))
                 (|error| "polynomials must have equal degrees"))
                ((< |n| 1) (|error| "polynomials must have positive degree"))
                (#3='T
                 (SEQ
                  (LETT |s|
                        (|FFPOLY;ll_cmp|
                         (SPADCALL |f|
                                   (PROG1 (LETT #2# (- |n| 1))
                                     (|check_subtype2| (>= #2# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #2#))
                                   (QREFELT $ 35))
                         (SPADCALL |g|
                                   (PROG1 (LETT #1# (- |n| 1))
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 35))
                         $))
                  (EXIT
                   (COND ((|less_SI| |s| 0) 'T) ((|less_SI| 0 |s|) NIL)
                         (#3# (SPADCALL |f| |g| (QREFELT $ 91)))))))))))) 

(SDEFUN |FFPOLY;cnlexSmaller?;2SupB;17|
        ((|f| (|SparseUnivariatePolynomial| GF))
         (|g| (|SparseUnivariatePolynomial| GF)) ($ (|Boolean|)))
        (SPROG ((|s| (|SingleInteger|)) (|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                    (EXIT
                     (COND
                      ((SPADCALL |n| (SPADCALL |g| (QREFELT $ 25))
                                 (QREFELT $ 71))
                       (|error| "polynomials must have equal degrees"))
                      ((< |n| 1)
                       (|error| "polynomials must have positive degree"))
                      (#1='T
                       (SEQ
                        (LETT |s|
                              (|FFPOLY;ll_cmp| (SPADCALL |f| 0 (QREFELT $ 35))
                               (SPADCALL |g| 0 (QREFELT $ 35)) $))
                        (EXIT
                         (COND ((|less_SI| |s| 0) 'T) ((|less_SI| 0 |s|) NIL)
                               (#1# (SPADCALL |f| |g| (QREFELT $ 93)))))))))))) 

(SDEFUN |FFPOLY;vecs_to_pol|
        ((|exp_v| (|PrimitiveArray| (|NonNegativeInteger|)))
         (|coeff_v| (|PrimitiveArray| GF)) (|w| (|NonNegativeInteger|))
         ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|resl|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (#1=#:G1040 NIL) (|i| NIL))
         (SEQ (LETT |resl| NIL)
              (SEQ (LETT |i| 0) (LETT #1# |w|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |resl|
                           (CONS
                            (CONS (QAREF1 |exp_v| |i|) (QAREF1 |coeff_v| |i|))
                            |resl|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |resl|)))) 

(SDEFUN |FFPOLY;do_weight|
        ((|exp_v| (|PrimitiveArray| (|NonNegativeInteger|)))
         (|ind_v| (|PrimitiveArray| (|NonNegativeInteger|)))
         (|coeff_v| (|PrimitiveArray| GF)) (|min_i| #1=(|NonNegativeInteger|))
         (|max_i| (|NonNegativeInteger|)) (|w| (|NonNegativeInteger|))
         (|tp?| (|Mapping| (|Boolean|) (|SparseUnivariatePolynomial| GF)))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPROG
         ((#2=#:G1069 NIL) (#3=#:G1070 NIL)
          (|pol| (|SparseUnivariatePolynomial| GF)) (#4=#:G1067 NIL) (|i| #1#)
          (|j| (|NonNegativeInteger|)) (#5=#:G1068 NIL) (#6=#:G1053 NIL)
          (#7=#:G1071 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((EQL (QREFELT $ 9) 2)
              (COND
               ((ODDP |w|)
                (SEQ
                 (SEQ (LETT |i| |min_i|) (LETT #7# (- |max_i| 1)) G190
                      (COND ((> |i| #7#) (GO G191)))
                      (SEQ (QSETAREF1 |exp_v| |i| |i|)
                           (QSETAREF1 |coeff_v| |i| (QREFELT $ 19))
                           (EXIT (QSETAREF1 |ind_v| |i| 1)))
                      (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (PROGN (LETT #3# (CONS 1 "failed")) (GO #8=#:G1066))))))))
            (EXIT
             (SEQ G190 NIL
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| |min_i|)
                         (SEQ
                          (EXIT
                           (SEQ G190 (COND ((NULL (< |i| |max_i|)) (GO G191)))
                                (SEQ (LETT |j| (QAREF1 |ind_v| |i|))
                                     (LETT |j| (+ |j| 1))
                                     (EXIT
                                      (COND
                                       ((EQL |j| (QREFELT $ 9))
                                        (SEQ (QSETAREF1 |ind_v| |i| 1)
                                             (QSETAREF1 |coeff_v| |i|
                                                        (QREFELT $ 19))
                                             (EXIT (LETT |i| (+ |i| 1)))))
                                       ('T
                                        (SEQ (QSETAREF1 |ind_v| |i| |j|)
                                             (QSETAREF1 |coeff_v| |i|
                                                        (SPADCALL
                                                         (PROG1 (LETT #6# |j|)
                                                           (|check_subtype2|
                                                            (> #6# 0)
                                                            '(|PositiveInteger|)
                                                            '(|NonNegativeInteger|)
                                                            #6#))
                                                         (QREFELT $ 18)))
                                             (EXIT
                                              (PROGN
                                               (LETT #5# |$NoValue|)
                                               (GO #9=#:G1056))))))))
                                NIL (GO G190) G191 (EXIT NIL)))
                          #9# (EXIT #5#))
                         (COND
                          ((EQL |i| |max_i|)
                           (SEQ (LETT |i| (MAX |min_i| 1))
                                (SEQ
                                 (EXIT
                                  (SEQ G190
                                       (COND
                                        ((NULL (< |i| |max_i|)) (GO G191)))
                                       (SEQ (LETT |j| (QAREF1 |exp_v| |i|))
                                            (LETT |j| (+ |j| 1))
                                            (EXIT
                                             (COND
                                              ((EQL |j|
                                                    (QAREF1 |exp_v| (+ |i| 1)))
                                               (SEQ
                                                (QSETAREF1 |exp_v| |i|
                                                           (+
                                                            (QAREF1 |exp_v|
                                                                    (- |i| 1))
                                                            1))
                                                (EXIT (LETT |i| (+ |i| 1)))))
                                              ('T
                                               (SEQ (QSETAREF1 |exp_v| |i| |j|)
                                                    (EXIT
                                                     (PROGN
                                                      (LETT #4# |$NoValue|)
                                                      (GO #10=#:G1061))))))))
                                       NIL (GO G190) G191 (EXIT NIL)))
                                 #10# (EXIT #4#))
                                (EXIT
                                 (COND
                                  ((EQL |i| |max_i|)
                                   (PROGN
                                    (LETT #3# (CONS 1 "failed"))
                                    (GO #8#))))))))
                         (LETT |pol|
                               (|FFPOLY;vecs_to_pol| |exp_v| |coeff_v| |w| $))
                         (EXIT
                          (COND
                           ((SPADCALL |pol| |tp?|)
                            (PROGN
                             (LETT #2#
                                   (PROGN (LETT #3# (CONS 0 |pol|)) (GO #8#)))
                             (GO #11=#:G1063)))))))
                   #11# (EXIT #2#))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #8# (EXIT #3#)))) 

(SDEFUN |FFPOLY;do_weights|
        ((|exp_v| (|PrimitiveArray| (|NonNegativeInteger|)))
         (|ind_v| (|PrimitiveArray| (|NonNegativeInteger|)))
         (|coeff_v| (|PrimitiveArray| GF)) (|min_i| (|NonNegativeInteger|))
         (|max_i| (|NonNegativeInteger|)) (|w| #1=(|NonNegativeInteger|))
         (|tp?| (|Mapping| (|Boolean|) (|SparseUnivariatePolynomial| GF)))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPROG
         ((|i| (|NonNegativeInteger|)) (#2=#:G1084 NIL) (|i1| NIL) (|w1| #1#)
          (#3=#:G1083 NIL)
          (|resu| (|Union| (|SparseUnivariatePolynomial| GF) "failed"))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QAREF1 |exp_v| |w|))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (COND
                        ((> |max_i| |min_i|)
                         (SEQ
                          (LETT |resu|
                                (|FFPOLY;do_weight| |exp_v| |ind_v| |coeff_v|
                                 |min_i| |max_i| |w| |tp?| $))
                          (EXIT
                           (COND
                            ((QEQCAR |resu| 0)
                             (PROGN
                              (LETT #3# (CONS 0 (QCDR |resu|)))
                              (GO #4=#:G1082))))))))
                       (EXIT
                        (COND
                         ((EQL |w| |n|)
                          (PROGN (LETT #3# (CONS 1 "failed")) (GO #4#)))
                         ('T
                          (SEQ (LETT |w1| |w|) (LETT |w| (+ |w| 1))
                               (LETT |i| |w|)
                               (SEQ (LETT |i1| |w1|) (LETT #2# |max_i|) G190
                                    (COND ((< |i1| #2#) (GO G191)))
                                    (SEQ
                                     (QSETAREF1 |exp_v| |i|
                                                (QAREF1 |exp_v| |i1|))
                                     (QSETAREF1 |coeff_v| |i|
                                                (QAREF1 |coeff_v| |i1|))
                                     (EXIT (LETT |i| |i1|)))
                                    (LETT |i1| (+ |i1| -1)) (GO G190) G191
                                    (EXIT NIL))
                               (QSETAREF1 |exp_v| |max_i| |max_i|)
                               (QSETAREF1 |ind_v| |max_i| 1)
                               (QSETAREF1 |coeff_v| |max_i| (QREFELT $ 19))
                               (LETT |max_i| (+ |max_i| 1))
                               (EXIT (QSETAREF1 |ind_v| |min_i| 0)))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #4# (EXIT #3#)))) 

(SDEFUN |FFPOLY;nextIrreduciblePoly;SupU;21|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPROG
         ((|ci| (GF)) (#1=#:G1118 NIL) (|term| NIL) (|i| NIL)
          (|coeff_v| (|PrimitiveArray| GF))
          (|ind_v| #2=(|PrimitiveArray| (|NonNegativeInteger|))) (|exp_v| #2#)
          (|w| (|NonNegativeInteger|)) (|good_binomials| (|Boolean|))
          (#3=#:G1116 NIL) (#4=#:G1117 NIL) (|fac| NIL)
          (|facs|
           (|List|
            (|Record| (|:| |factor| (|Integer|))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#5=#:G1095 NIL) (|c| (GF)) (#6=#:G1087 NIL)
          (|lc| (|NonNegativeInteger|))
          (|xn|
           (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF)))
          (|c0| (GF))
          (|f_rep|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (|lcf| (GF)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
              (EXIT
               (COND
                ((EQL |n| 0) (|error| "polynomial must have positive degree"))
                (#7='T
                 (SEQ
                  (COND
                   ((SPADCALL (LETT |lcf| (SPADCALL |f| (QREFELT $ 40)))
                              (|spadConstant| $ 16) (QREFELT $ 46))
                    (LETT |f|
                          (SPADCALL (SPADCALL |lcf| (QREFELT $ 47)) |f|
                                    (QREFELT $ 41)))))
                  (LETT |f_rep| |f|)
                  (LETT |c0| (SPADCALL |f| 0 (QREFELT $ 35)))
                  (EXIT
                   (COND
                    ((EQL |n| 1)
                     (SEQ (LETT |xn| (|SPADfirst| |f_rep|))
                          (LETT |lc|
                                (COND
                                 ((SPADCALL |c0| (|spadConstant| $ 13)
                                            (QREFELT $ 62))
                                  0)
                                 (#7# (SPADCALL |c0| (QREFELT $ 90)))))
                          (EXIT
                           (COND
                            ((EQL |lc| (- (QREFELT $ 9) 1)) (CONS 1 "failed"))
                            (#7#
                             (SEQ
                              (LETT |c|
                                    (SPADCALL
                                     (PROG1 (LETT #6# (+ |lc| 1))
                                       (|check_subtype2| (> #6# 0)
                                                         '(|PositiveInteger|)
                                                         '(|NonNegativeInteger|)
                                                         #6#))
                                     (QREFELT $ 18)))
                              (EXIT (CONS 0 (LIST |xn| (CONS 0 |c|))))))))))
                    (#7#
                     (SEQ
                      (LETT |w|
                            (PROG1 (LETT #5# (- (LENGTH |f_rep|) 1))
                              (|check_subtype2| (>= #5# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #5#)))
                      (COND
                       ((SPADCALL |c0| (|spadConstant| $ 13) (QREFELT $ 62))
                        (LETT |w| (+ |w| 1))))
                      (LETT |good_binomials| 'T)
                      (COND
                       ((> |n| 1)
                        (COND
                         ((EQL |w| 1)
                          (SEQ
                           (LETT |facs|
                                 (SPADCALL (SPADCALL |n| (QREFELT $ 74))
                                           (QREFELT $ 97)))
                           (LETT |good_binomials| (ODDP (QREFELT $ 11)))
                           (SEQ (LETT |fac| NIL) (LETT #4# |facs|) G190
                                (COND
                                 ((OR (ATOM #4#)
                                      (PROGN (LETT |fac| (CAR #4#)) NIL)
                                      (NULL |good_binomials|))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SEQ
                                   (COND
                                    ((EQL (QCAR |fac|) 2)
                                     (COND
                                      ((> (QCDR |fac|) 1)
                                       (EXIT
                                        (COND
                                         ((SPADCALL (REM (- (QREFELT $ 9) 1) 4)
                                                    0 (QREFELT $ 98))
                                          (PROGN
                                           (LETT #3#
                                                 (LETT |good_binomials| NIL))
                                           (GO #8=#:G1101)))))))))
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (REM (- (QREFELT $ 9) 1) (QCAR |fac|)) 0
                                       (QREFELT $ 98))
                                      (LETT |good_binomials| NIL))))))
                                 #8# (EXIT #3#))
                                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND ((NULL |good_binomials|) (LETT |w| 2)))))))))
                      (LETT |exp_v| (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                      (LETT |ind_v| (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                      (LETT |coeff_v|
                            (MAKEARR1 (+ |n| 1) (|spadConstant| $ 13)))
                      (SEQ (LETT |i| 0) (LETT |term| NIL) (LETT #1# |f_rep|)
                           G190
                           (COND
                            ((OR (ATOM #1#)
                                 (PROGN (LETT |term| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (QSETAREF1 |exp_v| (- |w| |i|) (QCAR |term|))
                                (LETT |ci| (QCDR |term|))
                                (QSETAREF1 |coeff_v| (- |w| |i|) |ci|)
                                (EXIT
                                 (QSETAREF1 |ind_v| (- |w| |i|)
                                            (SPADCALL |ci| (QREFELT $ 90)))))
                           (LETT #1#
                                 (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                           (GO G190) G191 (EXIT NIL))
                      (COND
                       ((NULL |good_binomials|)
                        (SEQ (QSETAREF1 |exp_v| 1 1)
                             (QSETAREF1 |coeff_v| 1 (QREFELT $ 19))
                             (EXIT (QSETAREF1 |ind_v| 1 1)))))
                      (EXIT
                       (|FFPOLY;do_weights| |exp_v| |ind_v| |coeff_v| 0 |w| |w|
                        (ELT $ 82) $))))))))))))) 

(SDEFUN |FFPOLY;get_next_GF_generator|
        ((|l| (|NonNegativeInteger|)) (|m1_to_n| (GF))
         ($
          (|Union| (|Record| (|:| |nl| (|PositiveInteger|)) (|:| |nc| GF))
                   "failed")))
        (SPROG
         ((|l1| (|PositiveInteger|)) (#1=#:G1129 NIL) (|c| (GF))
          (#2=#:G1123 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |l1|
                  (PROG1 (LETT #2# |l|)
                    (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                      '(|NonNegativeInteger|) #2#)))
            (SEQ G190 (COND ((NULL (< |l1| (QREFELT $ 9))) (GO G191)))
                 (SEQ (LETT |c| (SPADCALL |l1| (QREFELT $ 18)))
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |m1_to_n| |c| (QREFELT $ 103))
                                   (QREFELT $ 104))
                         (PROGN
                          (LETT #1# (CONS 0 (CONS |l1| |c|)))
                          (GO #3=#:G1128)))
                        ('T (LETT |l1| (+ |l1| 1))))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 1 "failed"))))
          #3# (EXIT #1#)))) 

(SDEFUN |FFPOLY;nextPrimitivePoly;SupU;23|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPROG
         ((#1=#:G1154 NIL)
          (|resu| (|Union| (|SparseUnivariatePolynomial| GF) "failed"))
          (|w| (|NonNegativeInteger|)) (|c| (GF)) (|lc| (|NonNegativeInteger|))
          (|lcr| (|Record| (|:| |nl| (|PositiveInteger|)) (|:| |nc| GF)))
          (|lcu|
           (|Union| (|Record| (|:| |nl| (|PositiveInteger|)) (|:| |nc| GF))
                    "failed"))
          (|m1_to_n| (GF)) (|ci| (GF)) (#2=#:G1155 NIL) (|term| NIL) (|i| NIL)
          (|coeff_v| (|PrimitiveArray| GF))
          (|ind_v| #3=(|PrimitiveArray| (|NonNegativeInteger|))) (|exp_v| #3#)
          (#4=#:G1139 NIL) (|c0| (GF))
          (|xn|
           (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF)))
          (|f_rep|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (|lcf| (GF)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                (EXIT
                 (COND
                  ((EQL |n| 0)
                   (|error| "polynomial must have positive degree"))
                  (#5='T
                   (SEQ
                    (COND
                     ((SPADCALL (LETT |lcf| (SPADCALL |f| (QREFELT $ 40)))
                                (|spadConstant| $ 16) (QREFELT $ 46))
                      (LETT |f|
                            (SPADCALL (SPADCALL |lcf| (QREFELT $ 47)) |f|
                                      (QREFELT $ 41)))))
                    (LETT |f_rep| |f|) (LETT |xn| (|SPADfirst| |f_rep|))
                    (LETT |c0| (SPADCALL |f| 0 (QREFELT $ 35)))
                    (LETT |lc| (SPADCALL |c0| (QREFELT $ 90)))
                    (EXIT
                     (COND
                      ((EQL |n| 1)
                       (SEQ
                        (LETT |m1_to_n|
                              (SPADCALL (|spadConstant| $ 16) (QREFELT $ 36)))
                        (LETT |lcu|
                              (|FFPOLY;get_next_GF_generator| (+ |lc| 1)
                               |m1_to_n| $))
                        (EXIT
                         (COND ((QEQCAR |lcu| 1) (CONS 1 "failed"))
                               (#5#
                                (SEQ (LETT |c| (QCDR (QCDR |lcu|)))
                                     (EXIT
                                      (CONS 0 (LIST |xn| (CONS 0 |c|))))))))))
                      (#5#
                       (SEQ
                        (LETT |w|
                              (PROG1 (LETT #4# (- (LENGTH |f_rep|) 1))
                                (|check_subtype2| (>= #4# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #4#)))
                        (COND
                         ((SPADCALL |c0| (|spadConstant| $ 13) (QREFELT $ 62))
                          (LETT |w| (+ |w| 1))))
                        (LETT |exp_v| (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                        (LETT |ind_v| (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                        (LETT |coeff_v|
                              (MAKEARR1 (+ |n| 1) (|spadConstant| $ 13)))
                        (SEQ (LETT |i| 0) (LETT |term| NIL) (LETT #2# |f_rep|)
                             G190
                             (COND
                              ((OR (ATOM #2#)
                                   (PROGN (LETT |term| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ (QSETAREF1 |exp_v| (- |w| |i|) (QCAR |term|))
                                  (LETT |ci| (QCDR |term|))
                                  (QSETAREF1 |coeff_v| (- |w| |i|) |ci|)
                                  (EXIT
                                   (QSETAREF1 |ind_v| (- |w| |i|)
                                              (SPADCALL |ci| (QREFELT $ 90)))))
                             (LETT #2#
                                   (PROG1 (CDR #2#) (LETT |i| (|inc_SI| |i|))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |c| |c0|)
                        (LETT |m1_to_n|
                              (SPADCALL (EXPT -1 |n|) (QREFELT $ 105)))
                        (COND
                         ((SPADCALL |c| (|spadConstant| $ 13) (QREFELT $ 62))
                          (LETT |lc| 1)))
                        (EXIT
                         (SEQ G190 NIL
                              (SEQ
                               (LETT |lcu|
                                     (|FFPOLY;get_next_GF_generator| |lc|
                                      |m1_to_n| $))
                               (EXIT
                                (COND
                                 ((QEQCAR |lcu| 1)
                                  (PROGN
                                   (LETT #1# (CONS 1 "failed"))
                                   (GO #6=#:G1153)))
                                 ('T
                                  (SEQ (LETT |lcr| (QCDR |lcu|))
                                       (LETT |lc| (+ (QCAR |lcr|) 1))
                                       (QSETAREF1 |ind_v| 0 (QCAR |lcr|))
                                       (QSETAREF1 |coeff_v| 0
                                                  (LETT |c| (QCDR |lcr|)))
                                       (COND
                                        ((SPADCALL |c| |c0| (QREFELT $ 62))
                                         (COND
                                          ((NULL (> |w| 1))
                                           (SEQ (LETT |w| 2)
                                                (QSETAREF1 |exp_v| 1 1)
                                                (QSETAREF1 |ind_v| 1 0)
                                                (QSETAREF1 |coeff_v| 1
                                                           (|spadConstant| $
                                                                           13))
                                                (QSETAREF1 |exp_v| |w| |n|)
                                                (QSETAREF1 |ind_v| |w| 1)
                                                (EXIT
                                                 (QSETAREF1 |coeff_v| |w|
                                                            (|spadConstant| $
                                                                            16)))))))
                                        ('T
                                         (SEQ (LETT |w| 2)
                                              (QSETAREF1 |exp_v| 1 1)
                                              (QSETAREF1 |ind_v| 1 0)
                                              (QSETAREF1 |coeff_v| 1
                                                         (|spadConstant| $ 13))
                                              (QSETAREF1 |exp_v| |w| |n|)
                                              (QSETAREF1 |ind_v| |w| 1)
                                              (EXIT
                                               (QSETAREF1 |coeff_v| |w|
                                                          (|spadConstant| $
                                                                          16))))))
                                       (LETT |resu|
                                             (|FFPOLY;do_weights| |exp_v|
                                              |ind_v| |coeff_v| 1 |w| |w|
                                              (ELT $ 83) $))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |resu| 0)
                                          (PROGN
                                           (LETT #1# (CONS 0 (QCDR |resu|)))
                                           (GO #6#))))))))))
                              NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |FFPOLY;nextNormalPoly;SupU;24|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPROG
         ((|a| (GF)) (#1=#:G1180 NIL) (|la| (|NonNegativeInteger|))
          (#2=#:G1188 NIL)
          (|resu| (|Union| (|SparseUnivariatePolynomial| GF) "failed"))
          (#3=#:G1177 NIL) (|w| (|NonNegativeInteger|)) (|ci| (GF))
          (#4=#:G1189 NIL) (|term| NIL) (|i| NIL)
          (|coeff_v| (|PrimitiveArray| GF))
          (|ind_v| #5=(|PrimitiveArray| (|NonNegativeInteger|))) (|exp_v| #5#)
          (#6=#:G1170 NIL) (#7=#:G1162 NIL)
          (|xn|
           (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF)))
          (|a0| (GF))
          (|f_rep|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (|lcf| (GF)) (|n1| (|NonNegativeInteger|)) (#8=#:G1156 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                (EXIT
                 (COND
                  ((EQL |n| 0)
                   (|error| "polynomial must have positive degree"))
                  (#9='T
                   (SEQ
                    (LETT |n1|
                          (PROG1 (LETT #8# (- |n| 1))
                            (|check_subtype2| (>= #8# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #8#)))
                    (COND
                     ((SPADCALL (LETT |lcf| (SPADCALL |f| (QREFELT $ 40)))
                                (|spadConstant| $ 16) (QREFELT $ 46))
                      (LETT |f|
                            (SPADCALL (SPADCALL |lcf| (QREFELT $ 47)) |f|
                                      (QREFELT $ 41)))))
                    (LETT |f_rep| |f|)
                    (LETT |a0| (SPADCALL |f| |n1| (QREFELT $ 35)))
                    (LETT |la|
                          (REM (SPADCALL |a0| (QREFELT $ 90)) (QREFELT $ 9)))
                    (EXIT
                     (COND
                      ((EQL |n| 1)
                       (SEQ (LETT |xn| (|SPADfirst| |f_rep|))
                            (EXIT
                             (COND
                              ((EQL |la| (- (QREFELT $ 9) 1))
                               (CONS 1 "failed"))
                              (#9#
                               (CONS 0
                                     (LIST |xn|
                                           (CONS 0
                                                 (SPADCALL
                                                  (PROG1 (LETT #7# (+ |la| 1))
                                                    (|check_subtype2| (> #7# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|NonNegativeInteger|)
                                                                      #7#))
                                                  (QREFELT $ 18))))))))))
                      (#9#
                       (SEQ (LETT |a| |a0|)
                            (COND
                             ((EQL |la| 0)
                              (SEQ (LETT |la| 1)
                                   (EXIT (LETT |a| (QREFELT $ 19))))))
                            (LETT |w|
                                  (PROG1 (LETT #6# (- (LENGTH |f_rep|) 1))
                                    (|check_subtype2| (>= #6# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #6#)))
                            (COND
                             ((SPADCALL (SPADCALL |f| 0 (QREFELT $ 35))
                                        (|spadConstant| $ 13) (QREFELT $ 62))
                              (LETT |w| (+ |w| 1))))
                            (LETT |exp_v|
                                  (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                            (LETT |ind_v|
                                  (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                            (LETT |coeff_v|
                                  (MAKEARR1 (+ |n| 1) (|spadConstant| $ 13)))
                            (SEQ (LETT |i| 0) (LETT |term| NIL)
                                 (LETT #4# |f_rep|) G190
                                 (COND
                                  ((OR (ATOM #4#)
                                       (PROGN (LETT |term| (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (QSETAREF1 |exp_v| (- |w| |i|) (QCAR |term|))
                                  (LETT |ci| (QCDR |term|))
                                  (QSETAREF1 |coeff_v| (- |w| |i|) |ci|)
                                  (EXIT
                                   (QSETAREF1 |ind_v| (- |w| |i|)
                                              (SPADCALL |ci| (QREFELT $ 90)))))
                                 (LETT #4#
                                       (PROG1 (CDR #4#)
                                         (LETT |i| (|inc_SI| |i|))))
                                 (GO G190) G191 (EXIT NIL))
                            (SEQ G190
                                 (COND
                                  ((NULL (< |la| (QREFELT $ 9))) (GO G191)))
                                 (SEQ
                                  (COND
                                   ((NULL (SPADCALL |a| |a0| (QREFELT $ 62)))
                                    (SEQ (LETT |w| 2) (QSETAREF1 |ind_v| 0 0)
                                         (QSETAREF1 |coeff_v| 0
                                                    (|spadConstant| $ 13))
                                         (QSETAREF1 |exp_v| (- |w| 1) |n1|)
                                         (QSETAREF1 |ind_v| (- |w| 1) |la|)
                                         (QSETAREF1 |coeff_v| (- |w| 1) |a|)
                                         (QSETAREF1 |exp_v| |w| |n|)
                                         (QSETAREF1 |ind_v| |w| 1)
                                         (EXIT
                                          (QSETAREF1 |coeff_v| |w|
                                                     (|spadConstant| $ 16))))))
                                  (LETT |resu|
                                        (|FFPOLY;do_weights| |exp_v| |ind_v|
                                         |coeff_v| 0
                                         (PROG1 (LETT #3# (- |w| 1))
                                           (|check_subtype2| (>= #3# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #3#))
                                         |w| (ELT $ 85) $))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |resu| 0)
                                     (PROGN
                                      (LETT #2# (CONS 0 (QCDR |resu|)))
                                      (GO #10=#:G1187)))
                                    ('T
                                     (SEQ (LETT |la| (+ |la| 1))
                                          (EXIT
                                           (LETT |a|
                                                 (SPADCALL
                                                  (PROG1 (LETT #1# |la|)
                                                    (|check_subtype2| (> #1# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|NonNegativeInteger|)
                                                                      #1#))
                                                  (QREFELT $ 18)))))))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (CONS 1 "failed"))))))))))))
          #10# (EXIT #2#)))) 

(SDEFUN |FFPOLY;nextNormalPrimitivePoly;SupU;25|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPROG
         ((|lc| (|NonNegativeInteger|)) (|a| (GF))
          (|la| (|NonNegativeInteger|)) (#1=#:G1212 NIL) (#2=#:G1223 NIL)
          (|resu| (|Union| (|SparseUnivariatePolynomial| GF) "failed"))
          (#3=#:G1209 NIL) (#4=#:G1222 NIL)
          (|pol| (|SparseUnivariatePolynomial| GF))
          (|w| (|NonNegativeInteger|)) (|first_pass| (|Boolean|)) (|c| (GF))
          (|lcr| (|Record| (|:| |nl| (|PositiveInteger|)) (|:| |nc| GF)))
          (|lcu|
           (|Union| (|Record| (|:| |nl| (|PositiveInteger|)) (|:| |nc| GF))
                    "failed"))
          (|ci| (GF)) (#5=#:G1224 NIL) (|term| NIL) (|i| NIL)
          (|coeff_v| (|PrimitiveArray| GF))
          (|ind_v| #6=(|PrimitiveArray| (|NonNegativeInteger|))) (|exp_v| #6#)
          (#7=#:G1199 NIL) (|m1_to_n| (GF)) (|a0| (GF)) (|c0| (GF))
          (|f_rep|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (|lcf| (GF)) (|n1| (|NonNegativeInteger|)) (#8=#:G1190 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 25)))
                (EXIT
                 (COND ((EQL |n| 1) (SPADCALL |f| (QREFELT $ 106)))
                       ((EQL |n| 0)
                        (|error| "polynomial must have positive degree"))
                       ('T
                        (SEQ
                         (LETT |n1|
                               (PROG1 (LETT #8# (- |n| 1))
                                 (|check_subtype2| (>= #8# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #8#)))
                         (COND
                          ((SPADCALL (LETT |lcf| (SPADCALL |f| (QREFELT $ 40)))
                                     (|spadConstant| $ 16) (QREFELT $ 46))
                           (LETT |f|
                                 (SPADCALL (SPADCALL |lcf| (QREFELT $ 47)) |f|
                                           (QREFELT $ 41)))))
                         (LETT |f_rep| |f|)
                         (LETT |c0| (SPADCALL |f| 0 (QREFELT $ 35)))
                         (LETT |lc| (SPADCALL |c0| (QREFELT $ 90)))
                         (LETT |a0| (SPADCALL |f| |n1| (QREFELT $ 35)))
                         (LETT |la| (SPADCALL |a0| (QREFELT $ 90)))
                         (LETT |c| |c0|) (LETT |a| |a0|)
                         (COND
                          ((SPADCALL |a| (|spadConstant| $ 13) (QREFELT $ 62))
                           (SEQ (LETT |la| 1)
                                (EXIT (LETT |a| (QREFELT $ 19))))))
                         (LETT |m1_to_n|
                               (SPADCALL (EXPT -1 |n|) (QREFELT $ 105)))
                         (LETT |w|
                               (PROG1 (LETT #7# (- (LENGTH |f_rep|) 1))
                                 (|check_subtype2| (>= #7# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #7#)))
                         (COND
                          ((SPADCALL |c| (|spadConstant| $ 13) (QREFELT $ 62))
                           (SEQ (LETT |lc| 1) (EXIT (LETT |w| (+ |w| 1))))))
                         (LETT |exp_v| (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                         (LETT |ind_v| (SPADCALL (+ |n| 1) 0 (QREFELT $ 100)))
                         (LETT |coeff_v|
                               (MAKEARR1 (+ |n| 1) (|spadConstant| $ 13)))
                         (SEQ (LETT |i| 0) (LETT |term| NIL) (LETT #5# |f_rep|)
                              G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |term| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (QSETAREF1 |exp_v| (- |w| |i|) (QCAR |term|))
                               (LETT |ci| (QCDR |term|))
                               (QSETAREF1 |coeff_v| (- |w| |i|) |ci|)
                               (EXIT
                                (QSETAREF1 |ind_v| (- |w| |i|)
                                           (SPADCALL |ci| (QREFELT $ 90)))))
                              (LETT #5#
                                    (PROG1 (CDR #5#)
                                      (LETT |i| (|inc_SI| |i|))))
                              (GO G190) G191 (EXIT NIL))
                         (LETT |first_pass| 'T)
                         (EXIT
                          (SEQ G190 NIL
                               (SEQ
                                (LETT |lcu|
                                      (|FFPOLY;get_next_GF_generator| |lc|
                                       |m1_to_n| $))
                                (EXIT
                                 (COND
                                  ((QEQCAR |lcu| 1)
                                   (PROGN
                                    (LETT #2# (CONS 1 "failed"))
                                    (GO #9=#:G1221)))
                                  ('T
                                   (SEQ (LETT |lcr| (QCDR |lcu|))
                                        (LETT |lc| (QCAR |lcr|))
                                        (LETT |c| (QCDR |lcr|))
                                        (SEQ G190
                                             (COND
                                              ((NULL (< |la| (QREFELT $ 9)))
                                               (GO G191)))
                                             (SEQ
                                              (COND
                                               ((SPADCALL |a| |a0|
                                                          (QREFELT $ 62))
                                                (COND
                                                 ((NULL
                                                   (SPADCALL |c| |c0|
                                                             (QREFELT $ 62)))
                                                  (SEQ (LETT |first_pass| NIL)
                                                       (LETT |w| 2)
                                                       (QSETAREF1 |ind_v| 0
                                                                  |lc|)
                                                       (QSETAREF1 |coeff_v| 0
                                                                  |c|)
                                                       (QSETAREF1 |exp_v|
                                                                  (- |w| 1)
                                                                  |n1|)
                                                       (QSETAREF1 |ind_v|
                                                                  (- |w| 1)
                                                                  |la|)
                                                       (QSETAREF1 |coeff_v|
                                                                  (- |w| 1)
                                                                  |a|)
                                                       (QSETAREF1 |exp_v| |w|
                                                                  |n|)
                                                       (QSETAREF1 |ind_v| |w|
                                                                  1)
                                                       (EXIT
                                                        (QSETAREF1 |coeff_v|
                                                                   |w|
                                                                   (|spadConstant|
                                                                    $ 16)))))))
                                               ('T
                                                (SEQ (LETT |first_pass| NIL)
                                                     (LETT |w| 2)
                                                     (QSETAREF1 |ind_v| 0 |lc|)
                                                     (QSETAREF1 |coeff_v| 0
                                                                |c|)
                                                     (QSETAREF1 |exp_v|
                                                                (- |w| 1) |n1|)
                                                     (QSETAREF1 |ind_v|
                                                                (- |w| 1) |la|)
                                                     (QSETAREF1 |coeff_v|
                                                                (- |w| 1) |a|)
                                                     (QSETAREF1 |exp_v| |w|
                                                                |n|)
                                                     (QSETAREF1 |ind_v| |w| 1)
                                                     (EXIT
                                                      (QSETAREF1 |coeff_v| |w|
                                                                 (|spadConstant|
                                                                  $ 16))))))
                                              (COND
                                               ((EQL |w| 2)
                                                (COND
                                                 ((NULL |first_pass|)
                                                  (SEQ
                                                   (EXIT
                                                    (SEQ
                                                     (LETT |pol|
                                                           (|FFPOLY;vecs_to_pol|
                                                            |exp_v| |coeff_v|
                                                            |w| $))
                                                     (EXIT
                                                      (COND
                                                       ((|FFPOLY;normal_and_primitive?|
                                                         |pol| $)
                                                        (PROGN
                                                         (LETT #4#
                                                               (PROGN
                                                                (LETT #2#
                                                                      (CONS 0
                                                                            |pol|))
                                                                (GO #9#)))
                                                         (GO #10=#:G1208)))))))
                                                   #10# (EXIT #4#))))))
                                              (LETT |resu|
                                                    (|FFPOLY;do_weights|
                                                     |exp_v| |ind_v| |coeff_v|
                                                     1
                                                     (PROG1
                                                         (LETT #3# (- |w| 1))
                                                       (|check_subtype2|
                                                        (>= #3# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #3#))
                                                     |w|
                                                     (CONS
                                                      (|function|
                                                       |FFPOLY;normal_and_primitive?|)
                                                      $)
                                                     $))
                                              (EXIT
                                               (COND
                                                ((QEQCAR |resu| 0)
                                                 (PROGN
                                                  (LETT #2#
                                                        (CONS 0 (QCDR |resu|)))
                                                  (GO #9#)))
                                                ('T
                                                 (SEQ (LETT |la| (+ |la| 1))
                                                      (EXIT
                                                       (LETT |a|
                                                             (SPADCALL
                                                              (PROG1
                                                                  (LETT #1#
                                                                        |la|)
                                                                (|check_subtype2|
                                                                 (> #1# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|NonNegativeInteger|)
                                                                 #1#))
                                                              (QREFELT $
                                                                       18)))))))))
                                             NIL (GO G190) G191 (EXIT NIL))
                                        (LETT |la| 1)
                                        (LETT |a| (|spadConstant| $ 16))
                                        (EXIT (LETT |lc| (+ |lc| 1))))))))
                               NIL (GO G190) G191 (EXIT NIL)))))))))
          #9# (EXIT #2#)))) 

(SDEFUN |FFPOLY;nextPrimitiveNormalPoly;SupU;26|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|Union| (|SparseUnivariatePolynomial| GF) "failed")))
        (SPADCALL |f| (QREFELT $ 108))) 

(SDEFUN |FFPOLY;createIrreduciblePoly;PiSup;27|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((#1=#:G1042 NIL) (|kg| (GF)) (#2=#:G1229 NIL) (#3=#:G1227 NIL)
          (|l| (|PositiveInteger|)) (|dg| (|PositiveInteger|))
          (|xn| #4=(|SparseUnivariatePolynomial| GF)) (|x| #4#))
         (SEQ (LETT |x| (SPADCALL (|spadConstant| $ 16) 1 (QREFELT $ 27)))
              (EXIT
               (COND ((EQL |n| 1) |x|)
                     (#5='T
                      (SEQ
                       (LETT |xn|
                             (SPADCALL (|spadConstant| $ 16) |n|
                                       (QREFELT $ 27)))
                       (EXIT
                        (COND
                         ((>= |n| (QREFELT $ 9))
                          (PROG2
                              (LETT #1#
                                    (SPADCALL
                                     (SPADCALL |xn| |x| (QREFELT $ 42))
                                     (QREFELT $ 102)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0)
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 6))
                                            (|Union|
                                             (|SparseUnivariatePolynomial|
                                              (QREFELT $ 6))
                                             #6="failed")
                                            #1#)))
                         (#5#
                          (SEQ (LETT |dg| (|FFPOLY;get_deg_GF| $))
                               (LETT |kg|
                                     (COND
                                      ((QREFELT $ 22)
                                       (SEQ (LETT |l| (GCD |n| |dg|))
                                            (EXIT
                                             (COND
                                              ((> |l| 1)
                                               (SPADCALL
                                                (PROG1
                                                    (LETT #2#
                                                          (-
                                                           (EXPT (QREFELT $ 11)
                                                                 (PROG2
                                                                     (LETT #3#
                                                                           (SPADCALL
                                                                            |dg|
                                                                            |l|
                                                                            (QREFELT
                                                                             $
                                                                             15)))
                                                                     (QCDR #3#)
                                                                   (|check_union2|
                                                                    (QEQCAR #3#
                                                                            0)
                                                                    (|NonNegativeInteger|)
                                                                    (|Union|
                                                                     (|NonNegativeInteger|)
                                                                     "failed")
                                                                    #3#)))
                                                           1))
                                                  (|check_subtype2| (> #2# 0)
                                                                    '(|PositiveInteger|)
                                                                    '(|Integer|)
                                                                    #2#))
                                                (QREFELT $ 18)))
                                              ((ODDP |n|)
                                               (|spadConstant| $ 16))
                                              (#5# (|spadConstant| $ 13))))))
                                      (#5# (|spadConstant| $ 13))))
                               (EXIT
                                (PROG2
                                    (LETT #1#
                                          (SPADCALL
                                           (SPADCALL |xn|
                                                     (SPADCALL |kg|
                                                               (QREFELT $ 37))
                                                     (QREFELT $ 42))
                                           (QREFELT $ 102)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0)
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 6))
                                                  (|Union|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 6))
                                                   #6#)
                                                  #1#)))))))))))))) 

(SDEFUN |FFPOLY;createPrimitivePoly;PiSup;28|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((#1=#:G1042 NIL) (|weight| (|NonNegativeInteger|))
          (|s| (|List| (|NonNegativeInteger|)))
          (|s1| (|List| (|NonNegativeInteger|))) (#2=#:G1244 NIL)
          (|notReady| (|Boolean|)) (#3=#:G1252 NIL)
          (|pol| (|SparseUnivariatePolynomial| GF))
          (|polRepr|
           (|List|
            #4=(|Record| (|:| |expnt| (|NonNegativeInteger|))
                         (|:| |coeff| GF))))
          (|n1| (|NonNegativeInteger|)) (#5=#:G1237 NIL) (|constterm| #4#)
          (|c0| (GF)) (|xn| (|SparseUnivariatePolynomial| GF)))
         (SEQ
          (EXIT
           (SEQ (LETT |xn| (SPADCALL (|spadConstant| $ 16) |n| (QREFELT $ 27)))
                (EXIT
                 (COND
                  ((EQL |n| 1)
                   (SPADCALL |xn|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QREFELT $ 111))
                                        (QREFELT $ 36))
                              0 (QREFELT $ 27))
                             (QREFELT $ 42)))
                  ('T
                   (SEQ
                    (LETT |c0|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 16) (QREFELT $ 36)) |n|
                            (QREFELT $ 112))
                           (SPADCALL (QREFELT $ 111)) (QREFELT $ 103)))
                    (LETT |constterm| (CONS 0 |c0|)) (LETT |s| (LIST 0 1))
                    (LETT |weight| 2) (LETT |s1| (LIST 1))
                    (LETT |n1|
                          (PROG1 (LETT #5# (- |n| 1))
                            (|check_subtype2| (>= #5# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #5#)))
                    (LETT |notReady| 'T)
                    (SEQ G190 (COND ((NULL |notReady|) (GO G191)))
                         (SEQ (LETT |polRepr| (LIST |constterm|))
                              (SEQ G190
                                   (COND ((NULL (NULL (NULL |s1|))) (GO G191)))
                                   (SEQ
                                    (LETT |polRepr|
                                          (CONS
                                           (CONS (|SPADfirst| |s1|)
                                                 (|spadConstant| $ 16))
                                           |polRepr|))
                                    (EXIT (LETT |s1| (CDR |s1|))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (LETT |polRepr|
                                    (CONS (CONS |n| (|spadConstant| $ 16))
                                          |polRepr|))
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |pol| (|FFPOLY;listToSUP| |polRepr| $))
                                  (QREFELT $ 83))
                                 (PROGN (LETT #3# |pol|) (GO #6=#:G1251)))
                                ((EQL |weight| |n|) (LETT |notReady| NIL))
                                ('T
                                 (SEQ
                                  (LETT |s1|
                                        (PROG2
                                            (LETT #2#
                                                  (|FFPOLY;nextSubset|
                                                   (CDR |s|) |n1| $))
                                            (QCDR #2#)
                                          (|check_union2| (QEQCAR #2# 0)
                                                          (|List|
                                                           (|NonNegativeInteger|))
                                                          (|Union|
                                                           (|List|
                                                            (|NonNegativeInteger|))
                                                           "failed")
                                                          #2#)))
                                  (LETT |s| (CONS 0 |s1|))
                                  (EXIT
                                   (LETT |weight|
                                         (SPADCALL |s| (QREFELT $ 87)))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (PROG2
                         (LETT #1#
                               (SPADCALL
                                (SPADCALL |xn| (SPADCALL |c0| 0 (QREFELT $ 27))
                                          (QREFELT $ 42))
                                (QREFELT $ 106)))
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0)
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 6))
                                       (|Union|
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 6))
                                        "failed")
                                       #1#)))))))))
          #6# (EXIT #3#)))) 

(SDEFUN |FFPOLY;createNormalPoly;PiSup;29|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG ((#1=#:G1042 NIL) (#2=#:G1254 NIL))
               (COND
                ((EQL |n| 1)
                 (SPADCALL (SPADCALL (|spadConstant| $ 16) 1 (QREFELT $ 27))
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 16) (QREFELT $ 36)) 0
                            (QREFELT $ 27))
                           (QREFELT $ 42)))
                ('T
                 (PROG2
                     (LETT #1#
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 16) |n|
                                       (QREFELT $ 27))
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 16) (QREFELT $ 36))
                              (PROG1 (LETT #2# (- |n| 1))
                                (|check_subtype2| (>= #2# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #2#))
                              (QREFELT $ 27))
                             (QREFELT $ 42))
                            (QREFELT $ 107)))
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0)
                                   (|SparseUnivariatePolynomial| (QREFELT $ 6))
                                   (|Union|
                                    (|SparseUnivariatePolynomial|
                                     (QREFELT $ 6))
                                    "failed")
                                   #1#)))))) 

(SDEFUN |FFPOLY;createNormalPrimitivePoly;PiSup;30|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((#1=#:G1042 NIL) (|pol| (|SparseUnivariatePolynomial| GF))
          (|res| (|Union| (|SparseUnivariatePolynomial| GF) "failed"))
          (|constterm| #2=(|SparseUnivariatePolynomial| GF)) (|c0| (GF))
          (|n1| (|NonNegativeInteger|)) (#3=#:G1256 NIL) (|xn| #2#))
         (SEQ (LETT |xn| (SPADCALL (|spadConstant| $ 16) |n| (QREFELT $ 27)))
              (EXIT
               (COND
                ((EQL |n| 1)
                 (SPADCALL |xn|
                           (SPADCALL
                            (SPADCALL (SPADCALL (QREFELT $ 111))
                                      (QREFELT $ 36))
                            0 (QREFELT $ 27))
                           (QREFELT $ 42)))
                (#4='T
                 (SEQ
                  (LETT |n1|
                        (PROG1 (LETT #3# (- |n| 1))
                          (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #3#)))
                  (LETT |c0|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 16) (QREFELT $ 36)) |n|
                          (QREFELT $ 112))
                         (SPADCALL (QREFELT $ 111)) (QREFELT $ 103)))
                  (LETT |constterm| (SPADCALL |c0| 0 (QREFELT $ 27)))
                  (LETT |pol|
                        (SPADCALL
                         (SPADCALL |xn|
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 16)
                                              (QREFELT $ 36))
                                    |n1| (QREFELT $ 27))
                                   (QREFELT $ 42))
                         |constterm| (QREFELT $ 42)))
                  (COND
                   ((SPADCALL |pol| (QREFELT $ 85))
                    (COND ((SPADCALL |pol| (QREFELT $ 83)) (EXIT |pol|)))))
                  (LETT |res| (SPADCALL |pol| (QREFELT $ 108)))
                  (EXIT
                   (COND ((QEQCAR |res| 0) (QCDR |res|))
                         (#4#
                          (SEQ
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              "weird, can not find normal and primitive"
                              "poly with a{n-1} = -1" (QREFELT $ 116))
                             (QREFELT $ 118))
                            (QREFELT $ 120))
                           (LETT |pol|
                                 (SPADCALL
                                  (SPADCALL |xn|
                                            (SPADCALL (|spadConstant| $ 16)
                                                      |n1| (QREFELT $ 27))
                                            (QREFELT $ 42))
                                  |constterm| (QREFELT $ 42)))
                           (COND
                            ((SPADCALL |pol| (QREFELT $ 85))
                             (COND
                              ((SPADCALL |pol| (QREFELT $ 83)) (EXIT |pol|)))))
                           (EXIT
                            (PROG2 (LETT #1# (SPADCALL |pol| (QREFELT $ 108)))
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 0)
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 6))
                                              (|Union|
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 6))
                                               "failed")
                                              #1#)))))))))))))) 

(SDEFUN |FFPOLY;createPrimitiveNormalPoly;PiSup;31|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPADCALL |n| (QREFELT $ 121))) 

(SDEFUN |FFPOLY;random;PiSup;32|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|polRepr|
           (|List|
            (|Record| (|:| |expnt| (|NonNegativeInteger|)) (|:| |coeff| GF))))
          (|c| (GF)) (#1=#:G1273 NIL) (|i| NIL) (|n1| (|NonNegativeInteger|))
          (#2=#:G1267 NIL))
         (SEQ (LETT |polRepr| NIL)
              (LETT |n1|
                    (PROG1 (LETT #2# (- |n| 1))
                      (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #2#)))
              (SEQ (LETT |i| 0) (LETT #1# |n1|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (LETT |c| (SPADCALL (QREFELT $ 123)))
                                 (|spadConstant| $ 13) (QREFELT $ 46))
                       (LETT |polRepr| (CONS (CONS |i| |c|) |polRepr|))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (CONS |n| (|spadConstant| $ 16)) |polRepr|))))) 

(SDEFUN |FFPOLY;random;2PiSup;33|
        ((|m| #1=(|PositiveInteger|)) (|n| #2=(|PositiveInteger|))
         ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((#3=#:G1275 NIL) (|d| (|NonNegativeInteger|)) (#4=#:G1274 NIL)
          (|#G88| #1#) (|#G87| #2#))
         (SEQ
          (COND
           ((> |m| |n|)
            (PROGN
             (LETT |#G87| |n|)
             (LETT |#G88| |m|)
             (LETT |m| |#G87|)
             (LETT |n| |#G88|))))
          (LETT |d|
                (PROG1 (LETT #4# (- |n| |m|))
                  (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #4#)))
          (COND
           ((> |d| 1)
            (LETT |n|
                  (PROG1 (LETT #3# (+ (RANDOM |d|) |m|))
                    (|check_subtype2| (> #3# 0) '(|PositiveInteger|)
                                      '(|Integer|) #3#)))))
          (EXIT (SPADCALL |n| (QREFELT $ 124)))))) 

(DECLAIM (NOTINLINE |FiniteFieldPolynomialPackage;|)) 

(DEFUN |FiniteFieldPolynomialPackage| (#1=#:G1278)
  (SPROG NIL
         (PROG (#2=#:G1279)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteFieldPolynomialPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|FiniteFieldPolynomialPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FiniteFieldPolynomialPackage|)))))))))) 

(DEFUN |FiniteFieldPolynomialPackage;| (|#1|)
  (SPROG
   ((#1=#:G737 NIL) (#2=#:G736 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|FiniteFieldPolynomialPackage| DV$1))
    (LETT $ (GETREFV 126))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FiniteFieldPolynomialPackage| (LIST DV$1)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9
              (PROG1 (LETT #2# (SPADCALL (QREFELT $ 8)))
                (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                  '(|NonNegativeInteger|) #2#)))
    (QSETREFV $ 11
              (PROG1 (LETT #1# (SPADCALL (QREFELT $ 10)))
                (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                  '(|NonNegativeInteger|) #1#)))
    (QSETREFV $ 12 0)
    (QSETREFV $ 19 (SPADCALL 1 (QREFELT $ 18)))
    (QSETREFV $ 22
              (COND ((QEQCAR (SPADCALL (QREFELT $ 21)) 1) 'T)
                    ('T (QEQCAR (SPADCALL (QREFELT $ 21)) 0))))
    (QSETREFV $ 23 (|ModMonic| |#1| (|SparseUnivariatePolynomial| |#1|)))
    $))) 

(MAKEPROP '|FiniteFieldPolynomialPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              (0 . |size|) '|sizeGF| (4 . |characteristic|) '|char_GF|
              '|deg_GF| (8 . |Zero|) (|Union| $ '"failed") (12 . |exquo|)
              (18 . |One|) (|PositiveInteger|) (22 . |index|) '|elem1|
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic")
              (27 . |representationType|) '|poly_or_prime_rep| 'MM
              (|SparseUnivariatePolynomial| 6) (31 . |degree|) (36 . |setPoly|)
              (41 . |monomial|) (47 . |reduce|) (52 . ^) (58 . |One|)
              (62 . |Zero|) (66 . |One|) (70 . *) (76 . |lift|)
              (81 . |coefficient|) (87 . -) (92 . |coerce|) (|Boolean|)
              (97 . ~=) (103 . |leadingCoefficient|) (108 . *) (114 . +)
              (120 . |reductum|) (|PrimitiveArray| 24)
              |FFPOLY;reducedQPowers;SupPa;3| (125 . ~=) (131 . |inv|)
              (|Vector| 6) (136 . |vectorise|) (|List| 6) (142 . |entries|)
              (|List| 50) (|Matrix| 6) (147 . |matrix|) (152 . |transpose|)
              (|Integer|) (157 . |setelt!|) (165 . |horizConcat|) (|List| 48)
              (171 . |nullSpace|) (176 . |elt|) (182 . =)
              |FFPOLY;leastAffineMultiple;2Sup;4|
              (|IntegerNumberTheoryFunctions|) (188 . |moebiusMu|) (|List| 56)
              (193 . |divisors|) |FFPOLY;numberOfIrreduciblePoly;2Pi;5|
              (198 . |eulerPhi|) |FFPOLY;numberOfPrimitivePoly;2Pi;6|
              (203 . ~=) |FFPOLY;numberOfNormalPoly;2Pi;7| (|Factored| $)
              (209 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 75) (|:| |factor| 56) (|:| |exponent| 7))
              (|List| 76) (|Factored| 56) (214 . |factorList|) (219 . =)
              (|DistinctDegreeFactorize| 6 24) (225 . |irreducible?|)
              |FFPOLY;primitive?;SupB;9| (230 . |rank|)
              |FFPOLY;normal?;SupB;10| (|List| 7) (235 . |#|)
              (240 . |setfirst!|) (246 . |numberOfMonomials|) (251 . |lookup|)
              |FFPOLY;lexSmaller?;2SupB;13| |FFPOLY;clexSmaller?;2SupB;15|
              |FFPOLY;nlexSmaller?;2SupB;16| |FFPOLY;cnlexSmaller?;2SupB;17|
              (|Record| (|:| |factor| 56) (|:| |exponent| 7)) (|List| 95)
              (256 . |factors|) (261 . ~=) (|PrimitiveArray| 7) (267 . |new|)
              (|Union| 24 '#1="failed") |FFPOLY;nextIrreduciblePoly;SupU;21|
              (273 . *) (279 . |primitive?|) (284 . |coerce|)
              |FFPOLY;nextPrimitivePoly;SupU;23|
              |FFPOLY;nextNormalPoly;SupU;24|
              |FFPOLY;nextNormalPrimitivePoly;SupU;25|
              |FFPOLY;nextPrimitiveNormalPoly;SupU;26|
              |FFPOLY;createIrreduciblePoly;PiSup;27|
              (289 . |primitiveElement|) (293 . ^)
              |FFPOLY;createPrimitivePoly;PiSup;28|
              |FFPOLY;createNormalPoly;PiSup;29| (|String|) (299 . |elt|)
              (|OutputForm|) (305 . |message|) (|Void|) (310 . |print|)
              |FFPOLY;createNormalPrimitivePoly;PiSup;30|
              |FFPOLY;createPrimitiveNormalPoly;PiSup;31| (315 . |random|)
              |FFPOLY;random;PiSup;32| |FFPOLY;random;2PiSup;33|)
           '#(|reducedQPowers| 319 |random| 324 |primitive?| 335
              |numberOfPrimitivePoly| 340 |numberOfNormalPoly| 345
              |numberOfIrreduciblePoly| 350 |normal?| 355 |nlexSmaller?| 360
              |nextPrimitivePoly| 366 |nextPrimitiveNormalPoly| 371
              |nextNormalPrimitivePoly| 376 |nextNormalPoly| 381
              |nextIrreduciblePoly| 386 |lexSmaller?| 391 |leastAffineMultiple|
              397 |createPrimitivePoly| 402 |createPrimitiveNormalPoly| 407
              |createNormalPrimitivePoly| 412 |createNormalPoly| 417
              |createIrreduciblePoly| 422 |cnlexSmaller?| 427 |clexSmaller?|
              433)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|primitive?|
                                 ((|Boolean|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|normal?|
                                 ((|Boolean|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|numberOfIrreduciblePoly|
                                 ((|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|numberOfPrimitivePoly|
                                 ((|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|numberOfNormalPoly|
                                 ((|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|createIrreduciblePoly|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|createPrimitivePoly|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|createNormalPoly|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|createNormalPrimitivePoly|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|createPrimitiveNormalPoly|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|lexSmaller?|
                                 ((|Boolean|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|clexSmaller?|
                                 ((|Boolean|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|nlexSmaller?|
                                 ((|Boolean|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|cnlexSmaller?|
                                 ((|Boolean|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|nextIrreduciblePoly|
                                 ((|Union| (|SparseUnivariatePolynomial| |#1|)
                                           #1#)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|nextPrimitivePoly|
                                 ((|Union| (|SparseUnivariatePolynomial| |#1|)
                                           "failed")
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|nextNormalPoly|
                                 ((|Union| (|SparseUnivariatePolynomial| |#1|)
                                           "failed")
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|nextNormalPrimitivePoly|
                                 ((|Union| (|SparseUnivariatePolynomial| |#1|)
                                           "failed")
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|nextPrimitiveNormalPoly|
                                 ((|Union| (|SparseUnivariatePolynomial| |#1|)
                                           "failed")
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|random|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|random|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|leastAffineMultiple|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|reducedQPowers|
                                 ((|PrimitiveArray|
                                   (|SparseUnivariatePolynomial| |#1|))
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 125
                                            '(0 6 7 8 0 6 7 10 0 6 0 13 2 7 14
                                              0 0 15 0 6 0 16 1 6 0 17 18 0 6
                                              20 21 1 24 7 0 25 1 23 24 24 26 2
                                              24 0 6 7 27 1 23 0 24 28 2 23 0 0
                                              7 29 0 23 0 30 0 24 0 31 0 24 0
                                              32 2 23 0 0 0 33 1 23 24 0 34 2
                                              24 6 0 7 35 1 6 0 0 36 1 24 0 6
                                              37 2 24 38 0 0 39 1 24 6 0 40 2
                                              24 0 6 0 41 2 24 0 0 0 42 1 24 0
                                              0 43 2 6 38 0 0 46 1 6 0 0 47 2
                                              24 48 0 7 49 1 48 50 0 51 1 53 0
                                              52 54 1 53 0 0 55 4 53 6 0 56 56
                                              6 57 2 53 0 0 0 58 1 53 59 0 60 2
                                              48 6 0 56 61 2 6 38 0 0 62 1 64
                                              56 56 65 1 64 66 56 67 1 64 56 56
                                              69 2 7 38 0 0 71 1 56 73 0 74 1
                                              78 77 0 79 2 24 38 0 0 80 1 81 38
                                              24 82 1 53 7 0 84 1 86 7 0 87 2
                                              86 7 0 7 88 1 24 7 0 89 1 6 17 0
                                              90 1 78 96 0 97 2 56 38 0 0 98 2
                                              99 0 7 7 100 2 6 0 0 0 103 1 6 38
                                              0 104 1 6 0 56 105 0 6 0 111 2 6
                                              0 0 17 112 2 115 0 0 0 116 1 117
                                              0 115 118 1 117 119 0 120 0 6 0
                                              123 1 0 44 24 45 1 0 24 17 124 2
                                              0 24 17 17 125 1 0 38 24 83 1 0
                                              17 17 70 1 0 17 17 72 1 0 17 17
                                              68 1 0 38 24 85 2 0 38 24 24 93 1
                                              0 101 24 106 1 0 101 24 109 1 0
                                              101 24 108 1 0 101 24 107 1 0 101
                                              24 102 2 0 38 24 24 91 1 0 24 24
                                              63 1 0 24 17 113 1 0 24 17 122 1
                                              0 24 17 121 1 0 24 17 114 1 0 24
                                              17 110 2 0 38 24 24 94 2 0 38 24
                                              24 92)))))
           '|lookupComplete|)) 
