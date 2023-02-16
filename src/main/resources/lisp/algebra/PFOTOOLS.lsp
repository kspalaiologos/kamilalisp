
(SDEFUN |PFOTOOLS;mix;LI;1|
        ((|l|
          (|List|
           (|Record| (|:| |den| (|Integer|)) (|:| |gcdnum| (|Integer|)))))
         ($ (|Integer|)))
        (SPROG
         ((#1=#:G707 NIL) (|p| NIL) (#2=#:G706 NIL) (#3=#:G705 NIL)
          (#4=#:G704 NIL))
         (SEQ
          (SPADCALL
           (SPADCALL
            (PROGN
             (LETT #4# NIL)
             (SEQ (LETT |p| NIL) (LETT #3# |l|) G190
                  (COND
                   ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                    (GO G191)))
                  (SEQ (EXIT (LETT #4# (CONS (QCAR |p|) #4#))))
                  (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT (NREVERSE #4#))))
            (QREFELT $ 10))
           (SPADCALL
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |p| NIL) (LETT #1# |l|) G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ (EXIT (LETT #2# (CONS (QCDR |p|) #2#))))
                  (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#))))
            (QREFELT $ 11))
           (QREFELT $ 12))))) 

(SDEFUN |PFOTOOLS;badNum;UPUPI;2| ((|p| (UPUP)) ($ (|Integer|)))
        (SPROG ((#1=#:G717 NIL) (|c| NIL) (#2=#:G716 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 17)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |c| (QREFELT $ 19))
                                          (QREFELT $ 20))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 15))))) 

(SDEFUN |PFOTOOLS;polyred;2UPUP;3| ((|r| (UPUP)) ($ (UPUP)))
        (SPROG
         ((|ld| (|List| (|Integer|))) (#1=#:G725 NIL) (|c| NIL)
          (#2=#:G724 NIL))
         (SEQ
          (LETT |ld|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |r| (QREFELT $ 17)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |c| (QREFELT $ 19))
                                         (QREFELT $ 23))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL (SPADCALL |ld| (QREFELT $ 10)) |r| (QREFELT $ 24)))))) 

(SDEFUN |PFOTOOLS;badNum;UPR;4|
        ((|p| (UP))
         ($ (|Record| (|:| |den| (|Integer|)) (|:| |gcdnum| (|Integer|)))))
        (SPROG
         ((#1=#:G733 NIL) (|c| NIL) (#2=#:G732 NIL)
          (|cd| (|Record| (|:| |num| UP) (|:| |den| (|Integer|)))))
         (SEQ (LETT |cd| (SPADCALL |p| (QREFELT $ 27)))
              (EXIT
               (CONS (QCDR |cd|)
                     (SPADCALL
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |c| NIL)
                            (LETT #1# (SPADCALL (QCAR |cd|) (QREFELT $ 29)))
                            G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (SPADCALL |c| (QREFELT $ 31)) #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (QREFELT $ 11))))))) 

(SDEFUN |PFOTOOLS;getGoodPrime;IPi;5|
        ((|n| (|Integer|)) ($ (|PositiveInteger|)))
        (SPROG ((|p| (|PositiveInteger|)) (#1=#:G735 NIL))
               (SEQ (LETT |p| 3)
                    (SEQ G190 (COND ((NULL (ZEROP (REM |n| |p|))) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |p|
                                 (PROG1
                                     (LETT #1# (SPADCALL |p| (QREFELT $ 33)))
                                   (|check_subtype2| (> #1# 0)
                                                     '(|PositiveInteger|)
                                                     '(|Integer|) #1#)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |p|)))) 

(SDEFUN |PFOTOOLS;doubleDisc;UPUPI;6| ((|r| (UPUP)) ($ (|Integer|)))
        (SPROG ((#1=#:G740 NIL) (|d| (UP)))
               (SEQ
                (LETT |d|
                      (SPADCALL (SPADCALL |r| (QREFELT $ 36)) (QREFELT $ 19)))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (PROG2
                       (LETT #1#
                             (SPADCALL |d|
                                       (SPADCALL |d|
                                                 (SPADCALL |d| (QREFELT $ 37))
                                                 (QREFELT $ 38))
                                       (QREFELT $ 40)))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                     (|Union| (QREFELT $ 6) "failed") #1#))
                   (QREFELT $ 41))
                  (QREFELT $ 31)))))) 

(DECLAIM (NOTINLINE |PointsOfFiniteOrderTools;|)) 

(DEFUN |PointsOfFiniteOrderTools| (&REST #1=#:G744)
  (SPROG NIL
         (PROG (#2=#:G745)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PointsOfFiniteOrderTools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PointsOfFiniteOrderTools;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PointsOfFiniteOrderTools|)))))))))) 

(DEFUN |PointsOfFiniteOrderTools;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PointsOfFiniteOrderTools| DV$1 DV$2))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PointsOfFiniteOrderTools|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PointsOfFiniteOrderTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| $)
              (|Integer|) (0 . |lcm|) (5 . |gcd|) (10 . |lcm|)
              (|Record| (|:| |den| 9) (|:| |gcdnum| 9)) (|List| 13)
              |PFOTOOLS;mix;LI;1| (|List| 18) (16 . |coefficients|)
              (|Fraction| 6) (21 . |retract|) |PFOTOOLS;badNum;UPR;4|
              |PFOTOOLS;badNum;UPUPI;2|
              (|UnivariatePolynomialCommonDenominator| 9 30 6)
              (26 . |commonDenominator|) (31 . *) |PFOTOOLS;polyred;2UPUP;3|
              (|Record| (|:| |num| 6) (|:| |den| 9)) (37 . |splitDenominator|)
              (|List| 30) (42 . |coefficients|) (|Fraction| 9) (47 . |retract|)
              (|IntegerPrimesPackage| 9) (52 . |nextPrime|) (|PositiveInteger|)
              |PFOTOOLS;getGoodPrime;IPi;5| (57 . |discriminant|)
              (62 . |differentiate|) (67 . |gcd|) (|Union| $ '"failed")
              (73 . |exquo|) (79 . |discriminant|)
              |PFOTOOLS;doubleDisc;UPUPI;6|)
           '#(|polyred| 84 |mix| 89 |getGoodPrime| 94 |doubleDisc| 99 |badNum|
              104)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|getGoodPrime|
                                 ((|PositiveInteger|) (|Integer|)))
                                T)
                              '((|badNum|
                                 ((|Record| (|:| |den| (|Integer|))
                                            (|:| |gcdnum| (|Integer|)))
                                  |#1|))
                                T)
                              '((|badNum| ((|Integer|) |#2|)) T)
                              '((|mix|
                                 ((|Integer|)
                                  (|List|
                                   (|Record| (|:| |den| (|Integer|))
                                             (|:| |gcdnum| (|Integer|))))))
                                T)
                              '((|doubleDisc| ((|Integer|) |#2|)) T)
                              '((|polyred| (|#2| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 9 0 8 10 1 9 0 8 11 2 9 0 0 0
                                              12 1 7 16 0 17 1 18 6 0 19 1 22 9
                                              6 23 2 7 0 9 0 24 1 22 26 6 27 1
                                              6 28 0 29 1 30 9 0 31 1 32 9 9 33
                                              1 7 18 0 36 1 6 0 0 37 2 6 0 0 0
                                              38 2 6 39 0 0 40 1 6 30 0 41 1 0
                                              7 7 25 1 0 9 14 15 1 0 34 9 35 1
                                              0 9 7 42 1 0 9 7 21 1 0 13 6
                                              20)))))
           '|lookupComplete|)) 
