
(SDEFUN |GALFACTU;height;UPF;1| ((|p| (UP)) ($ (F)))
        (SPADCALL |p| (QREFELT $ 9))) 

(SDEFUN |GALFACTU;length;UPF;2| ((|p| (UP)) ($ (F)))
        (SPADCALL |p| 1 (QREFELT $ 14))) 

(SDEFUN |GALFACTU;norm;UPPiF;3| ((|f| (UP)) (|p| (|PositiveInteger|)) ($ (F)))
        (SPROG ((|n| (F)) (#1=#:G708 NIL) (|c| NIL))
               (SEQ (LETT |n| (|spadConstant| $ 16))
                    (SEQ (LETT |c| NIL)
                         (LETT #1# (SPADCALL |f| (QREFELT $ 18))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |n|
                                 (SPADCALL |n|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |c| (QREFELT $ 19))
                                             (QREFELT $ 20))
                                            |p| (QREFELT $ 21))
                                           (QREFELT $ 22)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |n| |p| (QREFELT $ 24)))))) 

(SDEFUN |GALFACTU;quadraticNorm;UPF;4| ((|f| (UP)) ($ (F)))
        (SPADCALL |f| 2 (QREFELT $ 14))) 

(SDEFUN |GALFACTU;infinityNorm;UPF;5| ((|f| (UP)) ($ (F)))
        (SPROG ((|n| (F)) (#1=#:G714 NIL) (|c| NIL))
               (SEQ (LETT |n| (|spadConstant| $ 16))
                    (SEQ (LETT |c| NIL)
                         (LETT #1# (SPADCALL |f| (QREFELT $ 18))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |n|
                                 (SPADCALL |n|
                                           (SPADCALL
                                            (SPADCALL |c| (QREFELT $ 19))
                                            (QREFELT $ 20))
                                           (QREFELT $ 26)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |n|)))) 

(SDEFUN |GALFACTU;singleFactorBound;UPNniI;6|
        ((|p| (UP)) (|r| (|NonNegativeInteger|)) ($ (|Integer|)))
        (SPROG
         ((|den| (F)) (|num| (F)) (|nf| (F)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |p| (QREFELT $ 28))) (LETT |r| (MAX 2 |r|))
              (EXIT
               (COND
                ((< |n| |r|) (|error| "singleFactorBound: Bad arguments."))
                (#1='T
                 (SEQ (LETT |nf| (SPADCALL |n| (QREFELT $ 29)))
                      (LETT |num|
                            (SPADCALL (SPADCALL |p| (QREFELT $ 30)) |r|
                                      (QREFELT $ 24)))
                      (COND
                       ((|HasSignature| (QREFELT $ 8)
                                        (LIST '|Gamma|
                                              (LIST (|devaluate| (QREFELT $ 8))
                                                    (|devaluate|
                                                     (QREFELT $ 8)))))
                        (SEQ
                         (LETT |num|
                               (SPADCALL |num|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |nf| (|spadConstant| $ 31)
                                                     (QREFELT $ 22))
                                           (QREFELT $ 32))
                                          (* 2 |r|) (QREFELT $ 24))
                                         (QREFELT $ 33)))
                         (EXIT
                          (LETT |den|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL |nf|
                                            (SPADCALL (* 2 |r|) (QREFELT $ 29))
                                            (QREFELT $ 34))
                                  (|spadConstant| $ 31) (QREFELT $ 22))
                                 (QREFELT $ 32))))))
                       (#1#
                        (SEQ
                         (LETT |num|
                               (SPADCALL
                                (SPADCALL |num|
                                          (SPADCALL (SPADCALL 2 (QREFELT $ 29))
                                                    (SPADCALL
                                                     (SPADCALL 5 8
                                                               (QREFELT $ 36))
                                                     (SPADCALL |n| 2
                                                               (QREFELT $ 36))
                                                     (QREFELT $ 37))
                                                    (QREFELT $ 38))
                                          (QREFELT $ 33))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 31)
                                           (SPADCALL 4 |nf| (QREFELT $ 39))
                                           (QREFELT $ 34))
                                 (QREFELT $ 40))
                                (QREFELT $ 33)))
                         (EXIT
                          (LETT |den|
                                (SPADCALL
                                 (SPADCALL (SPADCALL (QREFELT $ 41)) |nf|
                                           (QREFELT $ 33))
                                 (SPADCALL 3 8 (QREFELT $ 36))
                                 (QREFELT $ 38)))))))
                      (EXIT
                       (SPADCALL (SPADCALL |num| |den| (QREFELT $ 34))
                                 (QREFELT $ 43)))))))))) 

(SDEFUN |GALFACTU;singleFactorBound;UPI;7| ((|p| (UP)) ($ (|Integer|)))
        (SPADCALL |p| 2 (QREFELT $ 44))) 

(SDEFUN |GALFACTU;rootBound;UPI;8| ((|p| (UP)) ($ (|Integer|)))
        (SPROG
         ((|b4| (F)) (|b3| (F)) (|b2| (F)) (|cl| (F)) (|b1| (F)) (|c| (F))
          (#1=#:G730 NIL) (#2=#:G736 NIL) (|i| NIL) (|lc| (F))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |p| (QREFELT $ 28)))
              (EXIT
               (COND ((ZEROP |n|) 0)
                     ('T
                      (SEQ
                       (LETT |lc|
                             (SPADCALL
                              (SPADCALL (SPADCALL |p| (QREFELT $ 46))
                                        (QREFELT $ 19))
                              (QREFELT $ 20)))
                       (LETT |b1| (|spadConstant| $ 16))
                       (LETT |b2| (|spadConstant| $ 16))
                       (LETT |b3| (|spadConstant| $ 16))
                       (LETT |b4| (|spadConstant| $ 16))
                       (LETT |c| (|spadConstant| $ 16))
                       (LETT |cl| (|spadConstant| $ 16))
                       (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ
                             (LETT |c|
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL |p|
                                               (PROG1 (LETT #1# (- |n| |i|))
                                                 (|check_subtype2| (>= #1# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #1#))
                                               (QREFELT $ 47))
                                     (QREFELT $ 19))
                                    (QREFELT $ 20)))
                             (LETT |b1| (SPADCALL |b1| |c| (QREFELT $ 26)))
                             (LETT |cl| (SPADCALL |c| |lc| (QREFELT $ 34)))
                             (LETT |b2|
                                   (SPADCALL |b2|
                                             (SPADCALL |cl| |i| (QREFELT $ 24))
                                             (QREFELT $ 26)))
                             (LETT |b3|
                                   (SPADCALL |b3|
                                             (SPADCALL
                                              (SPADCALL |cl|
                                                        (SPADCALL |n| |i|
                                                                  (QREFELT $
                                                                           48))
                                                        (QREFELT $ 34))
                                              |i| (QREFELT $ 24))
                                             (QREFELT $ 26)))
                             (EXIT
                              (LETT |b4|
                                    (SPADCALL |b4|
                                              (SPADCALL
                                               (SPADCALL |n| |cl|
                                                         (QREFELT $ 49))
                                               |i| (QREFELT $ 24))
                                              (QREFELT $ 26)))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT
                        (MIN
                         (+ 1
                            (SPADCALL (SPADCALL |b1| |lc| (QREFELT $ 34))
                                      (QREFELT $ 50)))
                         (MIN
                          (SPADCALL (SPADCALL 2 |b2| (QREFELT $ 39))
                                    (QREFELT $ 50))
                          (MIN
                           (SPADCALL
                            (SPADCALL |b3|
                                      (SPADCALL
                                       (SPADCALL (SPADCALL 2 (QREFELT $ 29))
                                                 |n| (QREFELT $ 24))
                                       (|spadConstant| $ 31) (QREFELT $ 51))
                                      (QREFELT $ 34))
                            (QREFELT $ 50))
                           (SPADCALL |b4| (QREFELT $ 50))))))))))))) 

(SDEFUN |GALFACTU;beauzamyBound;UPI;9| ((|f| (UP)) ($ (|Integer|)))
        (SPROG ((|d| (|NonNegativeInteger|)))
               (SEQ (LETT |d| (SPADCALL |f| (QREFELT $ 28)))
                    (EXIT
                     (COND
                      ((ZEROP |d|)
                       (SPADCALL (SPADCALL |f| (QREFELT $ 30)) (QREFELT $ 43)))
                      ('T
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |f| (QREFELT $ 30))
                                   (SPADCALL (SPADCALL 3 (QREFELT $ 29))
                                             (SPADCALL
                                              (SPADCALL 3 4 (QREFELT $ 36))
                                              (SPADCALL |d| 2 (QREFELT $ 36))
                                              (QREFELT $ 37))
                                             (QREFELT $ 38))
                                   (QREFELT $ 33))
                         (SPADCALL 2
                                   (SPADCALL
                                    (SPADCALL (SPADCALL (QREFELT $ 41))
                                              (SPADCALL |d| (QREFELT $ 29))
                                              (QREFELT $ 33))
                                    (QREFELT $ 53))
                                   (QREFELT $ 39))
                         (QREFELT $ 34))
                        (QREFELT $ 43)))))))) 

(SDEFUN |GALFACTU;bombieriNorm;UPPiF;10|
        ((|f| (UP)) (|p| (|PositiveInteger|)) ($ (F)))
        (SPROG
         ((|b| (F)) (#1=#:G763 NIL) (|dd| (|Integer|)) (#2=#:G746 NIL)
          (#3=#:G769 NIL) (|i| NIL) (#4=#:G768 NIL)
          (|d| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |d| (SPADCALL |f| (QREFELT $ 28)))
                (LETT |b|
                      (SPADCALL
                       (SPADCALL (SPADCALL |f| 0 (QREFELT $ 47))
                                 (QREFELT $ 19))
                       (QREFELT $ 20)))
                (COND ((ZEROP |d|) (PROGN (LETT #4# |b|) (GO #5=#:G767)))
                      ('T (LETT |b| (SPADCALL |b| |p| (QREFELT $ 21)))))
                (LETT |b|
                      (SPADCALL |b|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |f| (QREFELT $ 46))
                                            (QREFELT $ 19))
                                  (QREFELT $ 20))
                                 |p| (QREFELT $ 21))
                                (QREFELT $ 22)))
                (LETT |dd| (QUOTIENT2 (- |d| 1) 2))
                (SEQ (LETT |i| 1) (LETT #3# |dd|) G190
                     (COND ((|greater_SI| |i| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |b|
                             (SPADCALL |b|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |f| |i| (QREFELT $ 47))
                                            (QREFELT $ 19))
                                           (QREFELT $ 20))
                                          |p| (QREFELT $ 21))
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |f|
                                                      (PROG1
                                                          (LETT #2#
                                                                (- |d| |i|))
                                                        (|check_subtype2|
                                                         (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#))
                                                      (QREFELT $ 47))
                                            (QREFELT $ 19))
                                           (QREFELT $ 20))
                                          |p| (QREFELT $ 21))
                                         (QREFELT $ 22))
                                        (SPADCALL |d| |i| (QREFELT $ 48))
                                        (QREFELT $ 34))
                                       (QREFELT $ 22)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((EVENP |d|)
                  (SEQ (LETT |dd| (+ |dd| 1))
                       (EXIT
                        (LETT |b|
                              (SPADCALL |b|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |f|
                                                      (PROG1 (LETT #1# |dd|)
                                                        (|check_subtype2|
                                                         (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                                      (QREFELT $ 47))
                                            (QREFELT $ 19))
                                           (QREFELT $ 20))
                                          |p| (QREFELT $ 21))
                                         (SPADCALL |d| |dd| (QREFELT $ 48))
                                         (QREFELT $ 34))
                                        (QREFELT $ 22)))))))
                (EXIT (SPADCALL |b| |p| (QREFELT $ 24)))))
          #5# (EXIT #4#)))) 

(SDEFUN |GALFACTU;bombieriNorm;UPF;11| ((|f| (UP)) ($ (F)))
        (SPADCALL |f| 2 (QREFELT $ 57))) 

(DECLAIM (NOTINLINE |GaloisGroupFactorizationUtilities;|)) 

(DEFUN |GaloisGroupFactorizationUtilities| (&REST #1=#:G771)
  (SPROG NIL
         (PROG (#2=#:G772)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GaloisGroupFactorizationUtilities|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |GaloisGroupFactorizationUtilities;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GaloisGroupFactorizationUtilities|)))))))))) 

(DEFUN |GaloisGroupFactorizationUtilities;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|GaloisGroupFactorizationUtilities| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 58))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GaloisGroupFactorizationUtilities|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GaloisGroupFactorizationUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) |GALFACTU;infinityNorm;UPF;5|
              |GALFACTU;height;UPF;1| (0 . |One|) (4 . |One|)
              (|PositiveInteger|) |GALFACTU;norm;UPPiF;3|
              |GALFACTU;length;UPF;2| (8 . |Zero|) (|List| 6)
              (12 . |coefficients|) (17 . |coerce|) (22 . |abs|) (27 . ^)
              (33 . +) (|Integer|) (39 . |nthRoot|)
              |GALFACTU;quadraticNorm;UPF;4| (45 . |max|)
              (|NonNegativeInteger|) (51 . |degree|) (56 . |coerce|)
              |GALFACTU;bombieriNorm;UPF;11| (61 . |One|) (65 . |Gamma|)
              (70 . *) (76 . /) (|Fraction| 23) (82 . /) (88 . +) (94 . ^)
              (100 . *) (106 . |exp|) (111 . |pi|) (|GaloisGroupUtilities| 8)
              (115 . |safeFloor|) |GALFACTU;singleFactorBound;UPNniI;6|
              |GALFACTU;singleFactorBound;UPI;7| (120 . |leadingCoefficient|)
              (125 . |coefficient|) (131 . |pascalTriangle|) (137 . *)
              (143 . |safeCeiling|) (148 . -) |GALFACTU;rootBound;UPI;8|
              (154 . |sqrt|) |GALFACTU;beauzamyBound;UPI;9| (159 . |Zero|)
              (163 . |Zero|) |GALFACTU;bombieriNorm;UPPiF;10|)
           '#(|singleFactorBound| 167 |rootBound| 178 |quadraticNorm| 183
              |norm| 188 |length| 194 |infinityNorm| 199 |height| 204
              |bombieriNorm| 209 |beauzamyBound| 220)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|beauzamyBound| ((|Integer|) |#2|)) T)
                                   '((|bombieriNorm| (|#3| |#2|)) T)
                                   '((|bombieriNorm|
                                      (|#3| |#2| (|PositiveInteger|)))
                                     T)
                                   '((|rootBound| ((|Integer|) |#2|)) T)
                                   '((|singleFactorBound|
                                      ((|Integer|) |#2|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|singleFactorBound| ((|Integer|) |#2|))
                                     T)
                                   '((|norm| (|#3| |#2| (|PositiveInteger|)))
                                     T)
                                   '((|quadraticNorm| (|#3| |#2|)) T)
                                   '((|infinityNorm| (|#3| |#2|)) T)
                                   '((|height| (|#3| |#2|)) T)
                                   '((|length| (|#3| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 57
                                            '(0 6 0 11 0 7 0 12 0 8 0 16 1 7 17
                                              0 18 1 8 0 6 19 1 8 0 0 20 2 8 0
                                              0 13 21 2 8 0 0 0 22 2 8 0 0 23
                                              24 2 8 0 0 0 26 1 7 27 0 28 1 8 0
                                              23 29 0 8 0 31 1 8 0 0 32 2 8 0 0
                                              0 33 2 8 0 0 0 34 2 35 0 23 23 36
                                              2 35 0 0 0 37 2 8 0 0 35 38 2 8 0
                                              13 0 39 1 8 0 0 40 0 8 0 41 1 42
                                              23 8 43 1 7 6 0 46 2 7 6 0 27 47
                                              2 42 8 27 23 48 2 8 0 27 0 49 1
                                              42 23 8 50 2 8 0 0 0 51 1 8 0 0
                                              53 0 6 0 55 0 7 0 56 2 0 23 7 27
                                              44 1 0 23 7 45 1 0 23 7 52 1 0 8
                                              7 25 2 0 8 7 13 14 1 0 8 7 15 1 0
                                              8 7 9 1 0 8 7 10 1 0 8 7 30 2 0 8
                                              7 13 57 1 0 23 7 54)))))
           '|lookupComplete|)) 
