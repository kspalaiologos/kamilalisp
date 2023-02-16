
(SDEFUN |DISTPOL;eval;DUPSS;1| ((|x| (|Distribution| R)) (|p| (UPS)) ($ (S)))
        (SPROG ((|res| (S)))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 10))
                  (SPADCALL (SPADCALL |p| (QREFELT $ 11)) (|spadConstant| $ 12)
                            (QREFELT $ 13)))
                 ('T
                  (SEQ (LETT |res| (|spadConstant| $ 14))
                       (SEQ G190
                            (COND
                             ((NULL (NULL (SPADCALL |p| (QREFELT $ 15))))
                              (GO G191)))
                            (SEQ
                             (LETT |res|
                                   (SPADCALL |res|
                                             (SPADCALL
                                              (SPADCALL |x|
                                                        (SPADCALL |p|
                                                                  (QREFELT $
                                                                           17))
                                                        (QREFELT $ 19))
                                              (SPADCALL |p| (QREFELT $ 11))
                                              (QREFELT $ 20))
                                             (QREFELT $ 21)))
                             (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 22)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |res|))))))) 

(SDEFUN |DISTPOL;integrate;UPSDS;2|
        ((|p| (UPS)) (|x| (|Distribution| R)) ($ (S)))
        (SPADCALL |x| |p| (QREFELT $ 23))) 

(SDEFUN |DISTPOL;apply;UPSDD;3|
        ((|p| (UPS)) (|x| (|Distribution| R)) ($ (|Distribution| S)))
        (SPROG ((|mompx| (|Stream| S)) (IN (|Stream| (|Integer|))))
               (SEQ
                (LETT IN
                      (SPADCALL (LIST (SPADCALL 1 (QREFELT $ 28)))
                                (QREFELT $ 31)))
                (LETT |mompx|
                      (SPADCALL
                       (CONS #'|DISTPOL;apply;UPSDD;3!0| (VECTOR $ |p| |x|)) IN
                       (QREFELT $ 37)))
                (EXIT
                 (SPADCALL (SPADCALL |mompx| (QREFELT $ 39)) (QREFELT $ 41)))))) 

(SDEFUN |DISTPOL;apply;UPSDD;3!0| ((|k| NIL) ($$ NIL))
        (PROG (|x| |p| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G709 NIL))
                   (SPADCALL |x|
                             (SPADCALL |p|
                                       (PROG1 (LETT #1# |k|)
                                         (|check_subtype2| (> #1# 0)
                                                           '(|PositiveInteger|)
                                                           '(|Integer|) #1#))
                                       (QREFELT $ 33))
                             (QREFELT $ 23))))))) 

(DECLAIM (NOTINLINE |DistributionPolynomialPackage;|)) 

(DEFUN |DistributionPolynomialPackage| (&REST #1=#:G713)
  (SPROG NIL
         (PROG (#2=#:G714)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DistributionPolynomialPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |DistributionPolynomialPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|DistributionPolynomialPackage|)))))))))) 

(DEFUN |DistributionPolynomialPackage;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|DistributionPolynomialPackage| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DistributionPolynomialPackage|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DistributionPolynomialPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (0 . |ground?|)
              (5 . |leadingCoefficient|) (10 . |One|) (14 . *) (20 . |Zero|)
              (24 . |zero?|) (|NonNegativeInteger|) (29 . |degree|)
              (|Distribution| 6) (34 . |moment|) (40 . *) (46 . +)
              (52 . |reductum|) |DISTPOL;eval;DUPSS;1|
              |DISTPOL;integrate;UPSDS;2| (57 . |One|) (|Integer|)
              (|UniversalSegment| 26) (61 . SEGMENT) (|Stream| 26) (|List| $)
              (66 . |expand|) (|PositiveInteger|) (71 . ^) (|Stream| 7)
              (|Mapping| 7 26) (|StreamFunctions2| 26 7) (77 . |map|)
              (|Sequence| 7) (83 . |sequence|) (|Distribution| 7)
              (88 . |distributionByMoments|) |DISTPOL;apply;UPSDD;3|)
           '#(|integrate| 93 |eval| 99 |apply| 105) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|eval| (|#2| (|Distribution| |#1|) |#3|)) T)
                              '((|integrate| (|#2| |#3| (|Distribution| |#1|)))
                                T)
                              '((|apply|
                                 ((|Distribution| |#2|) |#3|
                                  (|Distribution| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 8 9 0 10 1 8 7 0 11 0 7 0 12 2
                                              7 0 0 0 13 0 7 0 14 1 8 9 0 15 1
                                              8 16 0 17 2 18 6 0 16 19 2 7 0 6
                                              0 20 2 7 0 0 0 21 1 8 0 0 22 0 6
                                              0 25 1 27 0 26 28 1 27 29 30 31 2
                                              8 0 0 32 33 2 36 34 35 29 37 1 38
                                              0 34 39 1 40 0 38 41 2 0 7 8 18
                                              24 2 0 7 18 8 23 2 0 40 8 18
                                              42)))))
           '|lookupComplete|)) 
