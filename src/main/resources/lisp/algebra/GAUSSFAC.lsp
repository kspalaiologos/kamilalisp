
(SDEFUN |GAUSSFAC;reduction|
        ((|u| (|Integer|)) (|p| (|Integer|)) ($ (|Integer|)))
        (COND ((EQL |p| 0) |u|) ('T (SPADCALL |u| |p| (QREFELT $ 7))))) 

(SDEFUN |GAUSSFAC;merge|
        ((|p| (|Integer|)) (|q| (|Integer|))
         ($ (|Union| (|Integer|) "failed")))
        (COND ((EQL |p| |q|) (CONS 0 |p|)) ((EQL |p| 0) (CONS 0 |q|))
              ((EQL |q| 0) (CONS 0 |p|)) ('T (CONS 1 "failed")))) 

(SDEFUN |GAUSSFAC;exactquo|
        ((|u| (|Integer|)) (|v| (|Integer|)) (|p| (|Integer|))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG ((#1=#:G709 NIL))
               (COND ((EQL |p| 0) (SPADCALL |u| |v| (QREFELT $ 9)))
                     ((EQL (REM |v| |p|) 0) (CONS 1 "failed"))
                     ('T
                      (CONS 0
                            (SPADCALL
                             (QCAR
                              (PROG2
                                  (LETT #1#
                                        (SPADCALL |v| |p| |u| (QREFELT $ 12)))
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0)
                                                (|Record|
                                                 (|:| |coef1| (|Integer|))
                                                 (|:| |coef2| (|Integer|)))
                                                (|Union|
                                                 (|Record|
                                                  (|:| |coef1| (|Integer|))
                                                  (|:| |coef2| (|Integer|)))
                                                 "failed")
                                                #1#)))
                             |p| (QREFELT $ 7))))))) 

(SDEFUN |GAUSSFAC;findelt| ((|q| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|t| (|FMod|)) (|s| (|FMod|)) (#1=#:G740 NIL) (|i| NIL)
          (|qq1| (|FMod|)) (|r1| (|Union| (|Integer|) "failed"))
          (|r| #2=(|Integer|)) (#3=#:G704 NIL) (|q1| #2#))
         (SEQ (LETT |q1| (- |q| 1)) (LETT |r| |q1|)
              (LETT |r1| (SPADCALL |r| 4 (QREFELT $ 9)))
              (SEQ G190 (COND ((NULL (NULL (QEQCAR |r1| 1))) (GO G191)))
                   (SEQ
                    (LETT |r|
                          (PROG2 (LETT #3# |r1|)
                              (QCDR #3#)
                            (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                            (|Union| (|Integer|) "failed")
                                            #3#)))
                    (EXIT (LETT |r1| (SPADCALL |r| 2 (QREFELT $ 9)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |s| (SPADCALL 1 |q| (QREFELT $ 18)))
              (LETT |qq1| (SPADCALL |q1| |q| (QREFELT $ 18)))
              (SEQ (LETT |i| 2) G190
                   (COND
                    ((NULL
                      (COND
                       ((SPADCALL |s| (|spadConstant| $ 14) (QREFELT $ 20)) 'T)
                       ('T (SPADCALL |s| |qq1| (QREFELT $ 20)))))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |s|
                           (SPADCALL (SPADCALL |i| |q| (QREFELT $ 18))
                                     (PROG1 (LETT #1# |r|)
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                     (QREFELT $ 22)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |t| |s|)
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |t| |qq1| (QREFELT $ 23))) (GO G191)))
                   (SEQ (LETT |s| |t|)
                        (EXIT (LETT |t| (SPADCALL |t| 2 (QREFELT $ 25)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |s| (QREFELT $ 26)))))) 

(SDEFUN |GAUSSFAC;sumsq1| ((|p| #1=(|Integer|)) ($ (|List| (|Integer|))))
        (SPROG ((|s| (|Integer|)) (|u| #1#) (|w| (|Integer|)))
               (SEQ (LETT |s| (|GAUSSFAC;findelt| |p| $)) (LETT |u| |p|)
                    (SEQ G190 (COND ((NULL (> (EXPT |u| 2) |p|)) (GO G191)))
                         (SEQ (LETT |w| (REM |u| |s|)) (LETT |u| |s|)
                              (EXIT (LETT |s| |w|)))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (LIST |u| |s|))))) 

(SDEFUN |GAUSSFAC;intfactor|
        ((|n| (|Integer|)) ($ (|Factored| (|Complex| (|Integer|)))))
        (SPROG
         ((|r|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|Complex| (|Integer|)))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|z| #1=(|Complex| (|Integer|))) (|sz| (|List| (|Integer|)))
          (|unity| #1#) (|exp| (|NonNegativeInteger|)) (#2=#:G792 NIL)
          (|term| NIL) (|lfn| (|Factored| (|Integer|))))
         (SEQ (LETT |lfn| (SPADCALL |n| (QREFELT $ 29))) (LETT |r| NIL)
              (LETT |unity|
                    (SPADCALL (SPADCALL |lfn| (QREFELT $ 30)) 0
                              (QREFELT $ 16)))
              (SEQ (LETT |term| NIL) (LETT #2# (SPADCALL |lfn| (QREFELT $ 34)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |term| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |n| (QVELT |term| 1))
                        (LETT |exp| (QVELT |term| 2))
                        (EXIT
                         (COND
                          ((EQL |n| 2)
                           (SEQ
                            (LETT |r|
                                  (CONS
                                   (VECTOR (CONS 3 "prime") (QREFELT $ 17)
                                           (* 2 |exp|))
                                   |r|))
                            (EXIT
                             (LETT |unity|
                                   (SPADCALL |unity|
                                             (SPADCALL
                                              (SPADCALL 0 -1 (QREFELT $ 16))
                                              (REM |exp| 4) (QREFELT $ 35))
                                             (QREFELT $ 36))))))
                          ((EQL (REM |n| 4) 3)
                           (LETT |r|
                                 (CONS
                                  (VECTOR (CONS 3 "prime")
                                          (SPADCALL |n| 0 (QREFELT $ 16))
                                          |exp|)
                                  |r|)))
                          ('T
                           (SEQ (LETT |sz| (|GAUSSFAC;sumsq1| |n| $))
                                (LETT |z|
                                      (SPADCALL
                                       (SPADCALL |sz| 1 (QREFELT $ 38))
                                       (SPADCALL |sz| 2 (QREFELT $ 38))
                                       (QREFELT $ 16)))
                                (EXIT
                                 (LETT |r|
                                       (CONS
                                        (VECTOR (CONS 3 "prime") |z| |exp|)
                                        (CONS
                                         (VECTOR (CONS 3 "prime")
                                                 (SPADCALL |z| (QREFELT $ 39))
                                                 |exp|)
                                         |r|)))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |unity| |r| (QREFELT $ 43)))))) 

(SDEFUN |GAUSSFAC;factor;CF;7|
        ((|m| (|Complex| (|Integer|)))
         ($ (|Factored| (|Complex| (|Integer|)))))
        (SPROG
         ((|unity| (|Complex| (|Integer|)))
          (|result|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|Complex| (|Integer|)))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|z| (|Complex| (|Integer|)))
          (|part|
           (|Record|
            (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
            (|:| |factor| (|Complex| (|Integer|)))
            (|:| |exponent| (|NonNegativeInteger|))))
          (|g0| (|Complex| (|Integer|))) (|exp| #5=(|NonNegativeInteger|))
          (|n| (|Integer|)) (#6=#:G814 NIL) (|term| NIL)
          (|factn|
           (|List|
            (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#))
                      (|:| |factor| (|Integer|)) (|:| |exponent| #5#))))
          (|r| #7=(|Factored| (|Complex| (|Integer|)))) (|b| (|Integer|))
          (#8=#:G704 NIL) (|a| (|Integer|)) (|d| (|Integer|)) (|ris| #7#))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 45) (QREFELT $ 46))
            (SPADCALL (|spadConstant| $ 45) 1 (QREFELT $ 47)))
           (#9='T
            (SEQ (LETT |a| (SPADCALL |m| (QREFELT $ 48)))
                 (LETT |b| (SPADCALL |m| (QREFELT $ 49)))
                 (EXIT
                  (COND ((EQL |b| 0) (|GAUSSFAC;intfactor| |a| $))
                        ((EQL |a| 0)
                         (SEQ (LETT |ris| (|GAUSSFAC;intfactor| |b| $))
                              (LETT |unity|
                                    (SPADCALL (SPADCALL |ris| (QREFELT $ 50))
                                              (SPADCALL 0 1 (QREFELT $ 16))
                                              (QREFELT $ 36)))
                              (EXIT
                               (SPADCALL |unity|
                                         (SPADCALL |ris| (QREFELT $ 51))
                                         (QREFELT $ 43)))))
                        (#9#
                         (SEQ (LETT |d| (GCD |a| |b|)) (LETT |result| NIL)
                              (LETT |unity| (|spadConstant| $ 52))
                              (COND
                               ((SPADCALL |d| 1 (QREFELT $ 53))
                                (SEQ
                                 (LETT |a|
                                       (PROG2
                                           (LETT #8#
                                                 (SPADCALL |a| |d|
                                                           (QREFELT $ 9)))
                                           (QCDR #8#)
                                         (|check_union2| (QEQCAR #8# 0)
                                                         (|Integer|)
                                                         (|Union| (|Integer|)
                                                                  #10="failed")
                                                         #8#)))
                                 (LETT |b|
                                       (PROG2
                                           (LETT #8#
                                                 (SPADCALL |b| |d|
                                                           (QREFELT $ 9)))
                                           (QCDR #8#)
                                         (|check_union2| (QEQCAR #8# 0)
                                                         (|Integer|)
                                                         (|Union| (|Integer|)
                                                                  #10#)
                                                         #8#)))
                                 (LETT |r| (|GAUSSFAC;intfactor| |d| $))
                                 (LETT |result| (SPADCALL |r| (QREFELT $ 51)))
                                 (LETT |unity| (SPADCALL |r| (QREFELT $ 50)))
                                 (EXIT
                                  (LETT |m|
                                        (SPADCALL |a| |b| (QREFELT $ 16)))))))
                              (LETT |n| (+ (EXPT |a| 2) (EXPT |b| 2)))
                              (LETT |factn|
                                    (SPADCALL (SPADCALL |n| (QREFELT $ 29))
                                              (QREFELT $ 34)))
                              (LETT |part|
                                    (VECTOR (CONS 3 "prime")
                                            (|spadConstant| $ 45) 0))
                              (SEQ (LETT |term| NIL) (LETT #6# |factn|) G190
                                   (COND
                                    ((OR (ATOM #6#)
                                         (PROGN (LETT |term| (CAR #6#)) NIL))
                                     (GO G191)))
                                   (SEQ (LETT |n| (QVELT |term| 1))
                                        (LETT |exp| (QVELT |term| 2))
                                        (EXIT
                                         (COND
                                          ((EQL |n| 2)
                                           (SEQ
                                            (LETT |part|
                                                  (VECTOR (CONS 3 "prime")
                                                          (QREFELT $ 17)
                                                          |exp|))
                                            (LETT |m|
                                                  (SPADCALL |m|
                                                            (SPADCALL
                                                             (QREFELT $ 17)
                                                             |exp|
                                                             (QREFELT $ 35))
                                                            (QREFELT $ 54)))
                                            (EXIT
                                             (LETT |result|
                                                   (CONS |part| |result|)))))
                                          ((EQL (REM |n| 4) 3)
                                           (SEQ
                                            (LETT |g0|
                                                  (SPADCALL |n| 0
                                                            (QREFELT $ 16)))
                                            (LETT |part|
                                                  (VECTOR (CONS 3 "prime") |g0|
                                                          (QUOTIENT2 |exp| 2)))
                                            (LETT |m|
                                                  (SPADCALL |m| |g0|
                                                            (QREFELT $ 54)))
                                            (EXIT
                                             (LETT |result|
                                                   (CONS |part| |result|)))))
                                          ('T
                                           (SEQ
                                            (LETT |z|
                                                  (SPADCALL |m|
                                                            (SPADCALL |n| 0
                                                                      (QREFELT
                                                                       $ 16))
                                                            (QREFELT $ 55)))
                                            (LETT |part|
                                                  (VECTOR (CONS 3 "prime") |z|
                                                          |exp|))
                                            (LETT |z|
                                                  (SPADCALL |z| |exp|
                                                            (QREFELT $ 35)))
                                            (LETT |m|
                                                  (SPADCALL |m| |z|
                                                            (QREFELT $ 54)))
                                            (EXIT
                                             (LETT |result|
                                                   (CONS |part|
                                                         |result|))))))))
                                   (LETT #6# (CDR #6#)) (GO G190) G191
                                   (EXIT NIL))
                              (COND
                               ((SPADCALL |m| (|spadConstant| $ 52)
                                          (QREFELT $ 56))
                                (LETT |unity|
                                      (SPADCALL |unity| |m| (QREFELT $ 36)))))
                              (EXIT
                               (SPADCALL |unity| |result|
                                         (QREFELT $ 43))))))))))))) 

(SDEFUN |GAUSSFAC;sumSquares;IL;8| ((|p| (|Integer|)) ($ (|List| (|Integer|))))
        (COND ((EQL |p| 2) (LIST 1 1))
              ((SPADCALL (REM |p| 4) 1 (QREFELT $ 53))
               (|error| "no solutions"))
              ('T (|GAUSSFAC;sumsq1| |p| $)))) 

(SDEFUN |GAUSSFAC;prime?;CB;9| ((|a| (|Complex| (|Integer|))) ($ (|Boolean|)))
        (SPROG
         ((|p| (|Integer|)) (|im| (|Integer|)) (|re| (|Integer|))
          (|n| (|Integer|)))
         (SEQ (LETT |n| (SPADCALL |a| (QREFELT $ 59)))
              (EXIT
               (COND ((OR (EQL |n| 0) (EQL |n| 1)) NIL)
                     ((SPADCALL |n| (QREFELT $ 61)) 'T)
                     (#1='T
                      (SEQ (LETT |re| (SPADCALL |a| (QREFELT $ 48)))
                           (LETT |im| (SPADCALL |a| (QREFELT $ 49)))
                           (COND
                            ((SPADCALL |re| 0 (QREFELT $ 53))
                             (COND
                              ((SPADCALL |im| 0 (QREFELT $ 53)) (EXIT NIL)))))
                           (LETT |p| (ABS (+ |re| |im|)))
                           (EXIT
                            (COND ((SPADCALL (REM |p| 4) 3 (QREFELT $ 53)) NIL)
                                  (#1# (SPADCALL |p| (QREFELT $ 61)))))))))))) 

(DECLAIM (NOTINLINE |GaussianFactorizationPackage;|)) 

(DEFUN |GaussianFactorizationPackage| ()
  (SPROG NIL
         (PROG (#1=#:G824)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|GaussianFactorizationPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|GaussianFactorizationPackage|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|GaussianFactorizationPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|GaussianFactorizationPackage|)))))))))) 

(DEFUN |GaussianFactorizationPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GaussianFactorizationPackage|))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GaussianFactorizationPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 13
                    (|ModularRing| (|Integer|) (|Integer|)
                                   (CONS (|function| |GAUSSFAC;reduction|) $)
                                   (CONS (|function| |GAUSSFAC;merge|) $)
                                   (CONS (|function| |GAUSSFAC;exactquo|) $)))
          (QSETREFV $ 17 (SPADCALL 1 1 (QREFELT $ 16)))
          $))) 

(MAKEPROP '|GaussianFactorizationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) (0 . |positiveRemainder|)
              (|Union| $ '"failed") (6 . |exquo|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 10 '"failed")
              (12 . |extendedEuclidean|) '|FMod| (19 . |One|) (|Complex| 6)
              (23 . |complex|) '|fact2| (29 . |reduce|) (|Boolean|) (35 . =)
              (|NonNegativeInteger|) (41 . ^) (47 . ~=) (|PositiveInteger|)
              (53 . ^) (59 . |coerce|) (|Factored| 6)
              (|IntegerFactorizationPackage| 6) (64 . |factor|) (69 . |unit|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 31) (|:| |factor| 6) (|:| |exponent| 21))
              (|List| 32) (74 . |factorList|) (79 . ^) (85 . *) (|List| 6)
              (91 . |elt|) (97 . |conjugate|)
              (|Record| (|:| |flag| 31) (|:| |factor| 15) (|:| |exponent| 21))
              (|List| 40) (|Factored| 15) (102 . |makeFR|) (108 . |Zero|)
              (112 . |Zero|) (116 . =) (122 . |primeFactor|) (128 . |real|)
              (133 . |imag|) (138 . |unit|) (143 . |factorList|) (148 . |One|)
              (152 . ~=) (158 . |quo|) (164 . |gcd|) (170 . ~=)
              |GAUSSFAC;factor;CF;7| |GAUSSFAC;sumSquares;IL;8| (176 . |norm|)
              (|IntegerPrimesPackage| 6) (181 . |prime?|)
              |GAUSSFAC;prime?;CB;9|)
           '#(|sumSquares| 186 |prime?| 191 |factor| 196) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factor|
                                 ((|Factored| (|Complex| (|Integer|)))
                                  (|Complex| (|Integer|))))
                                T)
                              '((|sumSquares|
                                 ((|List| (|Integer|)) (|Integer|)))
                                T)
                              '((|prime?|
                                 ((|Boolean|) (|Complex| (|Integer|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 62
                                            '(2 6 0 0 0 7 2 6 8 0 0 9 3 6 11 0
                                              0 0 12 0 13 0 14 2 15 0 6 6 16 2
                                              13 0 6 6 18 2 13 19 0 0 20 2 13 0
                                              0 21 22 2 13 19 0 0 23 2 13 0 0
                                              24 25 1 13 6 0 26 1 28 27 6 29 1
                                              27 6 0 30 1 27 33 0 34 2 15 0 0
                                              21 35 2 15 0 0 0 36 2 37 6 0 6 38
                                              1 15 0 0 39 2 42 0 15 41 43 0 13
                                              0 44 0 15 0 45 2 15 19 0 0 46 2
                                              42 0 15 21 47 1 15 6 0 48 1 15 6
                                              0 49 1 42 15 0 50 1 42 41 0 51 0
                                              15 0 52 2 6 19 0 0 53 2 15 0 0 0
                                              54 2 15 0 0 0 55 2 15 19 0 0 56 1
                                              15 6 0 59 1 60 19 6 61 1 0 37 6
                                              58 1 0 19 15 62 1 0 42 15 57)))))
           '|lookupComplete|)) 

(MAKEPROP '|GaussianFactorizationPackage| 'NILADIC T) 
