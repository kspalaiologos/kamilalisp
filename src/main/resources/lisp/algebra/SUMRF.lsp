
(SDEFUN |SUMRF;sum;FSbU;1|
        ((|f| (|Fraction| (|Polynomial| R)))
         (|s| (|SegmentBinding| (|Fraction| (|Polynomial| R))))
         ($ (|Union| (|Fraction| (|Polynomial| R)) (|Expression| R))))
        (SPROG
         ((|indef| (|Union| (|Fraction| (|Polynomial| R)) "failed"))
          (|v| (|Symbol|)))
         (SEQ
          (LETT |indef|
                (|SUMRF;innersum| |f| (LETT |v| (SPADCALL |s| (QREFELT $ 9)))
                 $))
          (EXIT
           (COND
            ((QEQCAR |indef| 1)
             (CONS 1
                   (SPADCALL (SPADCALL |f| (QREFELT $ 12))
                             (SPADCALL (ELT $ 12) |s| (QREFELT $ 16))
                             (QREFELT $ 18))))
            ('T
             (CONS 0
                   (SPADCALL
                    (SPADCALL (QCDR |indef|) |v|
                              (SPADCALL (|spadConstant| $ 20)
                                        (SPADCALL (SPADCALL |s| (QREFELT $ 22))
                                                  (QREFELT $ 23))
                                        (QREFELT $ 24))
                              (QREFELT $ 26))
                    (SPADCALL (QCDR |indef|) |v|
                              (SPADCALL (SPADCALL |s| (QREFELT $ 22))
                                        (QREFELT $ 27))
                              (QREFELT $ 26))
                    (QREFELT $ 28))))))))) 

(SDEFUN |SUMRF;sum;FSU;2|
        ((|an| (|Fraction| (|Polynomial| R))) (|n| (|Symbol|))
         ($ (|Union| (|Fraction| (|Polynomial| R)) (|Expression| R))))
        (SPROG ((|u| (|Union| (|Fraction| (|Polynomial| R)) "failed")))
               (SEQ (LETT |u| (|SUMRF;innersum| |an| |n| $))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 1)
                       (CONS 1
                             (SPADCALL (SPADCALL |an| (QREFELT $ 12)) |n|
                                       (QREFELT $ 31))))
                      ('T (CONS 0 (QCDR |u|)))))))) 

(SDEFUN |SUMRF;sum;PSbF;3|
        ((|p| (|Polynomial| R)) (|s| (|SegmentBinding| (|Polynomial| R)))
         ($ (|Fraction| (|Polynomial| R))))
        (SPROG ((|f| (|Fraction| (|Polynomial| R))) (|v| (|Symbol|)))
               (SEQ
                (LETT |f|
                      (SPADCALL |p| (LETT |v| (SPADCALL |s| (QREFELT $ 34)))
                                (QREFELT $ 36)))
                (EXIT
                 (SPADCALL
                  (SPADCALL |f| |v|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 37)
                                       (SPADCALL (SPADCALL |s| (QREFELT $ 39))
                                                 (QREFELT $ 40))
                                       (QREFELT $ 41))
                             (QREFELT $ 42))
                            (QREFELT $ 26))
                  (SPADCALL |f| |v|
                            (SPADCALL
                             (SPADCALL (SPADCALL |s| (QREFELT $ 39))
                                       (QREFELT $ 43))
                             (QREFELT $ 42))
                            (QREFELT $ 26))
                  (QREFELT $ 28)))))) 

(SDEFUN |SUMRF;innersum|
        ((|an| (|Fraction| (|Polynomial| R))) (|n| (|Symbol|))
         ($ (|Union| (|Fraction| (|Polynomial| R)) "failed")))
        (SPROG
         ((|u| (|Union| (|Fraction| (|Polynomial| R)) "failed"))
          (|an1| (|Fraction| (|Polynomial| R)))
          (|r| (|Union| (|Polynomial| R) "failed")))
         (SEQ (LETT |r| (SPADCALL |an| (QREFELT $ 46)))
              (EXIT
               (COND
                ((QEQCAR |r| 1)
                 (SEQ
                  (LETT |an1|
                        (SPADCALL |an| |n|
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 20)
                                             (QREFELT $ 47))
                                   (SPADCALL |n| (QREFELT $ 48))
                                   (QREFELT $ 24))
                                  (QREFELT $ 26)))
                  (LETT |u|
                        (SPADCALL (SPADCALL |an| |an1| (QREFELT $ 49)) |n|
                                  (ELT $ 50) (QREFELT $ 54)))
                  (EXIT
                   (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                         (#1='T
                          (CONS 0
                                (SPADCALL |an1|
                                          (SPADCALL (QCDR |u|) |n|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (|spadConstant| $ 20)
                                                      (QREFELT $ 47))
                                                     (SPADCALL |n|
                                                               (QREFELT $ 48))
                                                     (QREFELT $ 24))
                                                    (QREFELT $ 26))
                                          (QREFELT $ 56))))))))
                (#1# (CONS 0 (SPADCALL (QCDR |r|) |n| (QREFELT $ 36))))))))) 

(SDEFUN |SUMRF;sum;PSF;5|
        ((|p| (|Polynomial| R)) (|n| (|Symbol|))
         ($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((|rec|
           (|Record| (|:| |num| (|Polynomial| R)) (|:| |den| (|Integer|)))))
         (SEQ (LETT |rec| (SPADCALL |p| |n| (QREFELT $ 59)))
              (EXIT
               (SPADCALL (QCAR |rec|) (SPADCALL (QCDR |rec|) (QREFELT $ 61))
                         (QREFELT $ 62)))))) 

(DECLAIM (NOTINLINE |RationalFunctionSum;|)) 

(DEFUN |RationalFunctionSum| (#1=#:G733)
  (SPROG NIL
         (PROG (#2=#:G734)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFunctionSum|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RationalFunctionSum;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalFunctionSum|)))))))))) 

(DEFUN |RationalFunctionSum;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFunctionSum| DV$1))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFunctionSum| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalFunctionSum| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|)
              (|SegmentBinding| 10) (0 . |variable|) (|Fraction| 35)
              (|Expression| 6) (5 . |coerce|) (|SegmentBinding| 11)
              (|Mapping| 11 10) (|SegmentBindingFunctions2| 10 11) (10 . |map|)
              (|SegmentBinding| $) (16 . |summation|) (22 . |One|) (26 . |One|)
              (|Segment| 10) (30 . |segment|) (35 . |high|) (40 . +)
              (|RationalFunction| 6) (46 . |eval|) (53 . |low|) (58 . -)
              (|Union| 10 11) |SUMRF;sum;FSbU;1| (64 . |summation|)
              |SUMRF;sum;FSU;2| (|SegmentBinding| 35) (70 . |variable|)
              (|Polynomial| 6) |SUMRF;sum;PSF;5| (75 . |One|) (|Segment| 35)
              (79 . |segment|) (84 . |high|) (89 . +) (95 . |coerce|)
              (100 . |low|) |SUMRF;sum;PSbF;3| (|Union| 35 '"failed")
              (105 . |retractIfCan|) (110 . -) (115 . |coerce|) (120 . /)
              (126 . |new|) (|Union| 10 '"failed") (|Mapping| 7)
              (|GosperSummationMethod| (|IndexedExponents| 7) 7 6 35 10)
              (130 . |GospersMethod|) (137 . -) (142 . *)
              (|Record| (|:| |num| 35) (|:| |den| 60))
              (|InnerPolySum| (|IndexedExponents| 7) 7 6 35) (148 . |sum|)
              (|Integer|) (154 . |coerce|) (159 . /))
           '#(|sum| 165) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|sum|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Polynomial| |#1|) (|Symbol|)))
                                T)
                              '((|sum|
                                 ((|Union| (|Fraction| (|Polynomial| |#1|))
                                           (|Expression| |#1|))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|sum|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Polynomial| |#1|)
                                  (|SegmentBinding| (|Polynomial| |#1|))))
                                T)
                              '((|sum|
                                 ((|Union| (|Fraction| (|Polynomial| |#1|))
                                           (|Expression| |#1|))
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|SegmentBinding|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 62
                                            '(1 8 7 0 9 1 11 0 10 12 2 15 13 14
                                              8 16 2 11 0 0 17 18 0 6 0 19 0 10
                                              0 20 1 8 21 0 22 1 21 10 0 23 2
                                              10 0 0 0 24 3 25 10 10 7 10 26 1
                                              21 10 0 27 2 10 0 0 0 28 2 11 0 0
                                              7 31 1 33 7 0 34 0 35 0 37 1 33
                                              38 0 39 1 38 35 0 40 2 35 0 0 0
                                              41 1 10 0 35 42 1 38 35 0 43 1 10
                                              45 0 46 1 10 0 0 47 1 10 0 7 48 2
                                              10 0 0 0 49 0 7 0 50 3 53 51 10 7
                                              52 54 1 6 0 0 55 2 10 0 0 0 56 2
                                              58 57 35 7 59 1 35 0 60 61 2 10 0
                                              35 35 62 2 0 29 10 7 32 2 0 10 35
                                              7 36 2 0 29 10 8 30 2 0 10 35 33
                                              44)))))
           '|lookupComplete|)) 
