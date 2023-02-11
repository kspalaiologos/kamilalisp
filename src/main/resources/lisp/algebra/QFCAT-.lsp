
(SDEFUN |QFCAT-;numerator;2A;1| ((|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 9))) 

(SDEFUN |QFCAT-;denominator;2A;2| ((|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 9))) 

(SDEFUN |QFCAT-;init;A;3| (($ (A)))
        (SPADCALL (|spadConstant| $ 13) (|spadConstant| $ 14) (QREFELT $ 15))) 

(SDEFUN |QFCAT-;nextItem;AU;4| ((|n| (A)) ($ (|Union| A #1="failed")))
        (SPROG ((|m| (|Union| S #1#)))
               (SEQ
                (LETT |m|
                      (SPADCALL (SPADCALL |n| (QREFELT $ 8)) (QREFELT $ 18)))
                (EXIT
                 (COND
                  ((QEQCAR |m| 1)
                   (|error| "We seem to have a Fraction of a finite object"))
                  ('T
                   (CONS 0
                         (SPADCALL (QCDR |m|) (|spadConstant| $ 14)
                                   (QREFELT $ 15))))))))) 

(SDEFUN |QFCAT-;map;M2A;5| ((|fn| (|Mapping| S S)) (|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11)) |fn|) (QREFELT $ 15))) 

(SDEFUN |QFCAT-;reducedSystem;MM;6| ((|m| (|Matrix| A)) ($ (|Matrix| S)))
        (SPROG
         ((#1=#:G724 NIL) (|ell| (A)) (#2=#:G733 NIL) (|j| NIL) (|d| (S))
          (#3=#:G732 NIL) (|i| NIL) (|ans| (|Matrix| S))
          (|ncm| (|NonNegativeInteger|)) (|nrm| (|NonNegativeInteger|)))
         (SEQ (LETT |nrm| (ANROWS |m|)) (LETT |ncm| (ANCOLS |m|))
              (LETT |ans| (MAKE_MATRIX1 |nrm| |ncm| (|spadConstant| $ 24)))
              (SEQ (LETT |i| 1) (LETT #3# |nrm|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |d|
                          (SPADCALL (SPADCALL |m| |i| (QREFELT $ 28))
                                    (QREFELT $ 30)))
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #2# |ncm|) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ (LETT |ell| (QAREF2O |m| |i| |j| 1 1))
                               (EXIT
                                (QSETAREF2O |ans| |i| |j|
                                            (SPADCALL
                                             (PROG2
                                                 (LETT #1#
                                                       (SPADCALL |d|
                                                                 (SPADCALL
                                                                  |ell|
                                                                  (QREFELT $
                                                                           11))
                                                                 (QREFELT $
                                                                          31)))
                                                 (QCDR #1#)
                                               (|check_union2| (QEQCAR #1# 0)
                                                               (QREFELT $ 7)
                                                               (|Union|
                                                                (QREFELT $ 7)
                                                                "failed")
                                                               #1#))
                                             (SPADCALL |ell| (QREFELT $ 8))
                                             (QREFELT $ 32))
                                            1 1)))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |QFCAT-;characteristic;Nni;7| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 37))) 

(SDEFUN |QFCAT-;differentiate;AMA;8|
        ((|x| (A)) (|deriv| (|Mapping| S S)) ($ (A)))
        (SPROG ((|d| (S)) (|n| (S)))
               (SEQ (LETT |n| (SPADCALL |x| (QREFELT $ 8)))
                    (LETT |d| (SPADCALL |x| (QREFELT $ 11)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL |n| |deriv|) |d| (QREFELT $ 32))
                       (SPADCALL |n| (SPADCALL |d| |deriv|) (QREFELT $ 32))
                       (QREFELT $ 39))
                      (SPADCALL |d| 2 (QREFELT $ 41)) (QREFELT $ 15)))))) 

(SDEFUN |QFCAT-;convert;AIf;9| ((|x| (A)) ($ (|InputForm|)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 44))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 44))
                  (QREFELT $ 45))) 

(SDEFUN |QFCAT-;convert;AF;10| ((|x| (A)) ($ (|Float|)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 48))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 48))
                  (QREFELT $ 49))) 

(SDEFUN |QFCAT-;convert;ADf;11| ((|x| (A)) ($ (|DoubleFloat|)))
        (|div_DF| (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 52))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 52)))) 

(SDEFUN |QFCAT-;<;2AB;12| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (SPADCALL |y| (QREFELT $ 11))
                   (QREFELT $ 32))
         (SPADCALL (SPADCALL |y| (QREFELT $ 8)) (SPADCALL |x| (QREFELT $ 11))
                   (QREFELT $ 32))
         (QREFELT $ 55))) 

(SDEFUN |QFCAT-;smaller?;2AB;13| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (SPADCALL |y| (QREFELT $ 11))
                   (QREFELT $ 32))
         (SPADCALL (SPADCALL |y| (QREFELT $ 8)) (SPADCALL |x| (QREFELT $ 11))
                   (QREFELT $ 32))
         (QREFELT $ 57))) 

(SDEFUN |QFCAT-;fractionPart;2A;14| ((|x| (A)) ($ (A)))
        (SPADCALL |x| (SPADCALL (SPADCALL |x| (QREFELT $ 59)) (QREFELT $ 9))
                  (QREFELT $ 60))) 

(SDEFUN |QFCAT-;coerce;SA;15| ((|s| (|Symbol|)) ($ (A)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 63)) (QREFELT $ 9))) 

(SDEFUN |QFCAT-;retract;AS;16| ((|x| (A)) ($ (|Symbol|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 65)) (QREFELT $ 66))) 

(SDEFUN |QFCAT-;retractIfCan;AU;17|
        ((|x| (A)) ($ (|Union| (|Symbol|) "failed")))
        (SPROG ((|r| (|Union| S "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 69)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |r|) (QREFELT $ 71)))))))) 

(SDEFUN |QFCAT-;convert;AP;18| ((|x| (A)) ($ (|Pattern| (|Integer|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 74))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 74))
                  (QREFELT $ 75))) 

(SDEFUN |QFCAT-;patternMatch;AP2Pmr;19|
        ((|x| (A)) (|p| (|Pattern| (|Integer|)))
         (|l| (|PatternMatchResult| (|Integer|) A))
         ($ (|PatternMatchResult| (|Integer|) A)))
        (SPADCALL |x| |p| |l| (QREFELT $ 79))) 

(SDEFUN |QFCAT-;convert;AP;20| ((|x| (A)) ($ (|Pattern| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 83))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 83))
                  (QREFELT $ 84))) 

(SDEFUN |QFCAT-;patternMatch;AP2Pmr;21|
        ((|x| (A)) (|p| (|Pattern| (|Float|)))
         (|l| (|PatternMatchResult| (|Float|) A))
         ($ (|PatternMatchResult| (|Float|) A)))
        (SPADCALL |x| |p| |l| (QREFELT $ 88))) 

(SDEFUN |QFCAT-;coerce;FA;22| ((|x| (|Fraction| (|Integer|))) ($ (A)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 93))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 94)) (QREFELT $ 93))
                  (QREFELT $ 95))) 

(SDEFUN |QFCAT-;retract;AI;23| ((|x| (A)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 65)) (QREFELT $ 97))) 

(SDEFUN |QFCAT-;retractIfCan;AU;24|
        ((|x| (A)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|u| (|Union| S "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 69)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |u|) (QREFELT $ 100)))))))) 

(SDEFUN |QFCAT-;reducedSystem;MVR;25|
        ((|m| (|Matrix| A)) (|v| (|Vector| A))
         ($ (|Record| (|:| |mat| (|Matrix| S)) (|:| |vec| (|Vector| S)))))
        (SPROG ((|n| (|Matrix| S)))
               (SEQ
                (LETT |n|
                      (SPADCALL
                       (SPADCALL (SPADCALL |v| (QREFELT $ 102)) |m|
                                 (QREFELT $ 103))
                       (QREFELT $ 104)))
                (EXIT
                 (CONS
                  (SPADCALL |n| (PROGN |n| 1) (SPADCALL |n| (QREFELT $ 105))
                            (+ 1 (PROGN |n| 1)) (SPADCALL |n| (QREFELT $ 106))
                            (QREFELT $ 107))
                  (SPADCALL |n| (PROGN |n| 1) (QREFELT $ 109))))))) 

(DECLAIM (NOTINLINE |QuotientFieldCategory&;|)) 

(DEFUN |QuotientFieldCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|QuotientFieldCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 119))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|PolynomialFactorizationExplicit|))
                                              (|HasCategory| |#2|
                                                             '(|IntegerNumberSystem|))
                                              (|HasCategory| |#2|
                                                             '(|EuclideanDomain|))
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Symbol|)))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#2|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#2|
                                                             '(|RealConstant|))
                                              (|HasCategory| |#2|
                                                             '(|OrderedIntegralDomain|))
                                              (|HasCategory| |#2|
                                                             '(|Comparable|))
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#2|
                                                             '(|StepThrough|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 13)
            (PROGN
             (QSETREFV $ 16 (CONS (|dispatchFunction| |QFCAT-;init;A;3|) $))
             (QSETREFV $ 20
                       (CONS (|dispatchFunction| |QFCAT-;nextItem;AU;4|) $)))))
          (COND
           ((|testBitVector| |pv$| 7)
            (QSETREFV $ 46
                      (CONS (|dispatchFunction| |QFCAT-;convert;AIf;9|) $))))
          (COND
           ((|testBitVector| |pv$| 8)
            (PROGN
             (QSETREFV $ 50
                       (CONS (|dispatchFunction| |QFCAT-;convert;AF;10|) $))
             (QSETREFV $ 53
                       (CONS (|dispatchFunction| |QFCAT-;convert;ADf;11|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 11)
            (QSETREFV $ 56 (CONS (|dispatchFunction| |QFCAT-;<;2AB;12|) $))))
          (COND
           ((|testBitVector| |pv$| 10)
            (QSETREFV $ 58
                      (CONS (|dispatchFunction| |QFCAT-;smaller?;2AB;13|) $))))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 61
                      (CONS (|dispatchFunction| |QFCAT-;fractionPart;2A;14|)
                            $))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 64
                       (CONS (|dispatchFunction| |QFCAT-;coerce;SA;15|) $))
             (QSETREFV $ 67
                       (CONS (|dispatchFunction| |QFCAT-;retract;AS;16|) $))
             (QSETREFV $ 72
                       (CONS (|dispatchFunction| |QFCAT-;retractIfCan;AU;17|)
                             $)))))
          (COND
           ((|HasCategory| |#2| '(|ConvertibleTo| (|Pattern| (|Integer|))))
            (PROGN
             (QSETREFV $ 76
                       (CONS (|dispatchFunction| |QFCAT-;convert;AP;18|) $))
             (COND
              ((|HasCategory| |#2| '(|PatternMatchable| (|Integer|)))
               (QSETREFV $ 81
                         (CONS
                          (|dispatchFunction| |QFCAT-;patternMatch;AP2Pmr;19|)
                          $)))))))
          (COND
           ((|HasCategory| |#2| '(|ConvertibleTo| (|Pattern| (|Float|))))
            (PROGN
             (QSETREFV $ 85
                       (CONS (|dispatchFunction| |QFCAT-;convert;AP;20|) $))
             (COND
              ((|HasCategory| |#2| '(|PatternMatchable| (|Float|)))
               (QSETREFV $ 90
                         (CONS
                          (|dispatchFunction| |QFCAT-;patternMatch;AP2Pmr;21|)
                          $)))))))
          (COND
           ((|testBitVector| |pv$| 12)
            (PROGN
             (QSETREFV $ 96
                       (CONS (|dispatchFunction| |QFCAT-;coerce;FA;22|) $))
             (COND ((|domainEqual| |#2| (|Integer|)))
                   ('T
                    (PROGN
                     (QSETREFV $ 98
                               (CONS
                                (|dispatchFunction| |QFCAT-;retract;AI;23|) $))
                     (QSETREFV $ 101
                               (CONS
                                (|dispatchFunction|
                                 |QFCAT-;retractIfCan;AU;24|)
                                $))))))))
          $))) 

(MAKEPROP '|QuotientFieldCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |numer|) (5 . |coerce|) |QFCAT-;numerator;2A;1|
              (10 . |denom|) |QFCAT-;denominator;2A;2| (15 . |init|)
              (19 . |One|) (23 . /) (29 . |init|) (|Union| $ '#1="failed")
              (33 . |nextItem|) (38 . |One|) (42 . |nextItem|) (|Mapping| 7 7)
              |QFCAT-;map;M2A;5| (47 . |Zero|) (51 . |Zero|) (|Vector| 6)
              (|Integer|) (|Matrix| 6) (55 . |row|)
              (|CommonDenominator| 7 6 25) (61 . |commonDenominator|)
              (66 . |exquo|) (72 . *) (|Matrix| 7) (|Matrix| $)
              |QFCAT-;reducedSystem;MM;6| (|NonNegativeInteger|)
              (78 . |characteristic|) |QFCAT-;characteristic;Nni;7| (82 . -)
              (|PositiveInteger|) (88 . ^) |QFCAT-;differentiate;AMA;8|
              (|InputForm|) (94 . |convert|) (99 . /) (105 . |convert|)
              (|Float|) (110 . |convert|) (115 . /) (121 . |convert|)
              (|DoubleFloat|) (126 . |convert|) (131 . |convert|) (|Boolean|)
              (136 . <) (142 . <) (148 . |smaller?|) (154 . |smaller?|)
              (160 . |wholePart|) (165 . -) (171 . |fractionPart|) (|Symbol|)
              (176 . |coerce|) (181 . |coerce|) (186 . |retract|)
              (191 . |retract|) (196 . |retract|) (|Union| 7 '#2="failed")
              (201 . |retractIfCan|) (|Union| 62 '#2#) (206 . |retractIfCan|)
              (211 . |retractIfCan|) (|Pattern| 26) (216 . |convert|) (221 . /)
              (227 . |convert|) (|PatternMatchResult| 26 6)
              (|PatternMatchQuotientFieldCategory| 26 7 6)
              (232 . |patternMatch|) (|PatternMatchResult| 26 $)
              (239 . |patternMatch|) (|Pattern| 47) (246 . |convert|) (251 . /)
              (257 . |convert|) (|PatternMatchResult| 47 6)
              (|PatternMatchQuotientFieldCategory| 47 7 6)
              (262 . |patternMatch|) (|PatternMatchResult| 47 $)
              (269 . |patternMatch|) (|Fraction| 26) (276 . |numer|)
              (281 . |coerce|) (286 . |denom|) (291 . /) (297 . |coerce|)
              (302 . |retract|) (307 . |retract|) (|Union| 26 '#2#)
              (312 . |retractIfCan|) (317 . |retractIfCan|) (322 . |coerce|)
              (327 . |horizConcat|) (333 . |reducedSystem|)
              (338 . |maxRowIndex|) (343 . |maxColIndex|) (348 . |subMatrix|)
              (|Vector| 7) (357 . |column|)
              (|Record| (|:| |mat| 33) (|:| |vec| 108)) (|Vector| $)
              |QFCAT-;reducedSystem;MVR;25| (|Union| 91 '#2#)
              (|Record| (|:| |mat| 115) (|:| |vec| (|Vector| 26)))
              (|Matrix| 26) (|List| 62) (|List| 36) (|OutputForm|))
           '#(|smaller?| 363 |retractIfCan| 369 |retract| 379 |reducedSystem|
              389 |patternMatch| 400 |numerator| 414 |nextItem| 419 |map| 424
              |init| 430 |fractionPart| 434 |differentiate| 439 |denominator|
              445 |convert| 450 |coerce| 475 |characteristic| 485 < 489)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|init| (|#1|)) T)
                                   '((|nextItem| ((|Union| |#1| #1#) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #2#) |#1|))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #2#)
                                       |#1|))
                                     T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|smaller?| ((|Boolean|) |#1| |#1|)) T)
                                   '((< ((|Boolean|) |#1| |#1|)) T)
                                   '((|convert| ((|DoubleFloat|) |#1|)) T)
                                   '((|convert| ((|Float|) |#1|)) T)
                                   '((|convert| ((|InputForm|) |#1|)) T)
                                   '((|coerce| (|#1| (|Symbol|))) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Symbol|) #2#) |#1|))
                                     T)
                                   '((|retract| ((|Symbol|) |#1|)) T)
                                   '((|fractionPart| (|#1| |#1|)) T)
                                   '((|denominator| (|#1| |#1|)) T)
                                   '((|numerator| (|#1| |#1|)) T)
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
                                   '((|convert| ((|Pattern| (|Float|)) |#1|))
                                     T)
                                   '((|convert| ((|Pattern| (|Integer|)) |#1|))
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
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|retractIfCan| ((|Union| |#2| #2#) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 112
                                            '(1 6 7 0 8 1 6 0 7 9 1 6 7 0 11 0
                                              7 0 13 0 7 0 14 2 6 0 7 7 15 0 0
                                              0 16 1 7 17 0 18 0 6 0 19 1 0 17
                                              0 20 0 6 0 23 0 7 0 24 2 27 25 0
                                              26 28 1 29 7 25 30 2 7 17 0 0 31
                                              2 7 0 0 0 32 0 7 36 37 2 7 0 0 0
                                              39 2 7 0 0 40 41 1 7 43 0 44 2 43
                                              0 0 0 45 1 0 43 0 46 1 7 47 0 48
                                              2 47 0 0 0 49 1 0 47 0 50 1 7 51
                                              0 52 1 0 51 0 53 2 7 54 0 0 55 2
                                              0 54 0 0 56 2 7 54 0 0 57 2 0 54
                                              0 0 58 1 6 7 0 59 2 6 0 0 0 60 1
                                              0 0 0 61 1 7 0 62 63 1 0 0 62 64
                                              1 6 7 0 65 1 7 62 0 66 1 0 62 0
                                              67 1 6 68 0 69 1 7 70 0 71 1 0 70
                                              0 72 1 7 73 0 74 2 73 0 0 0 75 1
                                              0 73 0 76 3 78 77 6 73 77 79 3 0
                                              80 0 73 80 81 1 7 82 0 83 2 82 0
                                              0 0 84 1 0 82 0 85 3 87 86 6 82
                                              86 88 3 0 89 0 82 89 90 1 91 26 0
                                              92 1 6 0 26 93 1 91 26 0 94 2 6 0
                                              0 0 95 1 0 0 91 96 1 7 26 0 97 1
                                              0 26 0 98 1 7 99 0 100 1 0 99 0
                                              101 1 27 0 25 102 2 27 0 0 0 103
                                              1 6 33 34 104 1 33 26 0 105 1 33
                                              26 0 106 5 33 0 0 26 26 26 26 107
                                              2 33 108 0 26 109 2 0 54 0 0 58 1
                                              0 99 0 101 1 0 70 0 72 1 0 26 0
                                              98 1 0 62 0 67 2 0 110 34 111 112
                                              1 0 33 34 35 3 0 89 0 82 89 90 3
                                              0 80 0 73 80 81 1 0 0 0 10 1 0 17
                                              0 20 2 0 0 21 0 22 0 0 0 16 1 0 0
                                              0 61 2 0 0 0 21 42 1 0 0 0 12 1 0
                                              47 0 50 1 0 51 0 53 1 0 43 0 46 1
                                              0 73 0 76 1 0 82 0 85 1 0 0 62 64
                                              1 0 0 91 96 0 0 36 38 2 0 54 0 0
                                              56)))))
           '|lookupComplete|)) 
