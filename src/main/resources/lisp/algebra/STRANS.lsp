
(SDEFUN |STRANS;STransform1;DUTSR;1| ((|x| (|Distribution| R)) ($ (UTSR)))
        (SPROG
         ((|res| (|Sequence| R)) (|chi| (|Stream| R)) (|mom| (|Stream| R)))
         (SEQ
          (LETT |mom| (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 14)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |mom| (QREFELT $ 15)) (QREFELT $ 17))
             (|error| "mean is zero!"))
            ('T
             (SEQ
              (LETT |mom|
                    (SPADCALL (|spadConstant| $ 18) |mom| (QREFELT $ 20)))
              (LETT |chi| (SPADCALL |mom| (QREFELT $ 22)))
              (LETT |res|
                    (SPADCALL (SPADCALL |chi| (QREFELT $ 23))
                              (SPADCALL (SPADCALL |chi| (QREFELT $ 24))
                                        (QREFELT $ 23))
                              (QREFELT $ 25)))
              (EXIT
               (SPADCALL (SPADCALL |res| (QREFELT $ 14)) (QREFELT $ 26)))))))))) 

(SDEFUN |STRANS;STransform2;DUPSR;2| ((|x| (|Distribution| R)) ($ (UPSR)))
        (SPROG
         ((S2 (ULSR)) (|res2| (UTSR)) (|chi2| (|Stream| R))
          (|mom2| (|Stream| R)) (|mom| (|Stream| R)))
         (SEQ
          (LETT |mom| (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 14)))
          (COND
           ((NULL (SPADCALL (SPADCALL |mom| (QREFELT $ 15)) (QREFELT $ 17)))
            (EXIT (|error| "mean is nonzero!"))))
          (LETT |mom2|
                (SPADCALL (|spadConstant| $ 18)
                          (SPADCALL (SPADCALL 1 2 (QREFELT $ 32))
                                    (SPADCALL |mom| (QREFELT $ 24))
                                    (QREFELT $ 33))
                          (QREFELT $ 20)))
          (LETT |chi2| (SPADCALL |mom2| (QREFELT $ 22)))
          (LETT |res2| (SPADCALL |chi2| (QREFELT $ 26)))
          (LETT S2
                (SPADCALL (SPADCALL -2 |res2| (QREFELT $ 34))
                          (SPADCALL 0 |res2| (QREFELT $ 34)) (QREFELT $ 35)))
          (EXIT (SPADCALL (SPADCALL 1 2 (QREFELT $ 32)) S2 (QREFELT $ 36)))))) 

(SDEFUN |STRANS;STransform;DUPSR;3| ((|x| (|Distribution| R)) ($ (UPSR)))
        (SPROG
         ((S (UTSR)) (|res| (|Sequence| R)) (|chi| #1=(|Stream| R))
          (|mom| (|Stream| R)) (S2 (ULSR)) (|res2| (UTSR)) (|chi2| #1#)
          (|mom2| (|Stream| R)))
         (SEQ
          (LETT |mom| (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 14)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |mom| (QREFELT $ 15)) (QREFELT $ 17))
             (SEQ
              (LETT |mom2|
                    (SPADCALL (|spadConstant| $ 18)
                              (SPADCALL (SPADCALL 1 2 (QREFELT $ 32))
                                        (SPADCALL |mom| (QREFELT $ 24))
                                        (QREFELT $ 33))
                              (QREFELT $ 20)))
              (LETT |chi2| (SPADCALL |mom2| (QREFELT $ 22)))
              (LETT |res2| (SPADCALL |chi2| (QREFELT $ 26)))
              (LETT S2
                    (SPADCALL (SPADCALL -2 |res2| (QREFELT $ 34))
                              (SPADCALL 0 |res2| (QREFELT $ 34))
                              (QREFELT $ 35)))
              (EXIT
               (SPADCALL (SPADCALL 1 2 (QREFELT $ 32)) S2 (QREFELT $ 36)))))
            ('T
             (SEQ
              (LETT |mom|
                    (SPADCALL (|spadConstant| $ 18) |mom| (QREFELT $ 20)))
              (LETT |chi| (SPADCALL |mom| (QREFELT $ 22)))
              (LETT |res|
                    (SPADCALL (SPADCALL |chi| (QREFELT $ 23))
                              (SPADCALL (SPADCALL |chi| (QREFELT $ 24))
                                        (QREFELT $ 23))
                              (QREFELT $ 25)))
              (LETT S
                    (SPADCALL (SPADCALL |res| (QREFELT $ 14)) (QREFELT $ 26)))
              (EXIT
               (SPADCALL (|spadConstant| $ 38) (SPADCALL 0 S (QREFELT $ 34))
                         (QREFELT $ 36)))))))))) 

(SDEFUN |STRANS;distributionBySTransform;UPSRD;4|
        ((S (UPSR)) ($ (|Distribution| R)))
        (SPROG ((|taylS| (UTSR)) (|laurS| (ULSR)))
               (SEQ (LETT |laurS| (SPADCALL S (QREFELT $ 40)))
                    (LETT |taylS| (SPADCALL |laurS| (QREFELT $ 41)))
                    (EXIT
                     (SPADCALL (SPADCALL S (QREFELT $ 42))
                               (SPADCALL S (QREFELT $ 43))
                               (SPADCALL (SPADCALL |taylS| (QREFELT $ 44))
                                         (QREFELT $ 23))
                               (QREFELT $ 45)))))) 

(DECLAIM (NOTINLINE |STransformPackage;|)) 

(DEFUN |STransformPackage| (&REST #1=#:G715)
  (SPROG NIL
         (PROG (#2=#:G716)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|STransformPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |STransformPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|STransformPackage|)))))))))) 

(DEFUN |STransformPackage;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|STransformPackage| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 47))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|STransformPackage|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|STransformPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Sequence| 6) (|Distribution| 6)
              (0 . |moments|) (|Stream| 6) (5 . |stream|) (10 . |first|)
              (|Boolean|) (15 . |zero?|) (20 . |Zero|) (24 . |Zero|)
              (28 . |cons|) (|StreamTaylorSeriesOperations| 6) (34 . |revert|)
              (39 . |sequence|) (44 . |rest|) (49 . +) (55 . |series|)
              |STRANS;STransform1;DUTSR;1| (60 . |One|) (64 . |One|)
              (|Integer|) (|Fraction| 30) (68 . /) (74 . |powern|)
              (80 . |laurent|) (86 . +) (92 . |puiseux|)
              |STRANS;STransform2;DUPSR;2| (98 . |One|)
              |STRANS;STransform;DUPSR;3| (102 . |laurentRep|)
              (107 . |taylorRep|) (112 . |rationalPower|) (117 . |order|)
              (122 . |coefficients|) (127 . |distributionBySTransform|)
              |STRANS;distributionBySTransform;UPSRD;4|)
           '#(|distributionBySTransform| 134 |STransform2| 139 |STransform1|
              144 |STransform| 149)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|STransform1| (|#2| (|Distribution| |#1|))) T)
                              '((|STransform2| (|#4| (|Distribution| |#1|))) T)
                              '((|STransform| (|#4| (|Distribution| |#1|))) T)
                              '((|distributionBySTransform|
                                 ((|Distribution| |#1|) |#4|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(1 11 10 0 12 1 10 13 0 14 1 13 6
                                              0 15 1 6 16 0 17 0 6 0 18 0 7 0
                                              19 2 13 0 6 0 20 1 21 13 13 22 1
                                              10 0 13 23 1 13 0 0 24 2 10 0 0 0
                                              25 1 7 0 13 26 0 6 0 28 0 7 0 29
                                              2 31 0 30 30 32 2 21 13 31 13 33
                                              2 8 0 30 7 34 2 8 0 0 0 35 2 9 0
                                              31 8 36 0 31 0 38 1 9 8 0 40 1 8
                                              7 0 41 1 9 31 0 42 1 9 31 0 43 1
                                              7 13 0 44 3 11 0 31 31 10 45 1 0
                                              11 9 46 1 0 9 11 37 1 0 7 11 27 1
                                              0 9 11 39)))))
           '|lookupComplete|)) 
