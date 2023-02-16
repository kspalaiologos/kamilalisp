
(SDEFUN |PARSC2;map;MPscPsc;1|
        ((|f| (|Mapping| CF2 CF1)) (|c| (|ParametricSpaceCurve| CF1))
         ($ (|ParametricSpaceCurve| CF2)))
        (SPADCALL (SPADCALL (SPADCALL |c| 1 (QREFELT $ 10)) |f|)
                  (SPADCALL (SPADCALL |c| 2 (QREFELT $ 10)) |f|)
                  (SPADCALL (SPADCALL |c| 3 (QREFELT $ 10)) |f|)
                  (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |ParametricSpaceCurveFunctions2;|)) 

(DEFUN |ParametricSpaceCurveFunctions2| (&REST #1=#:G696)
  (SPROG NIL
         (PROG (#2=#:G697)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ParametricSpaceCurveFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |ParametricSpaceCurveFunctions2;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ParametricSpaceCurveFunctions2|)))))))))) 

(DEFUN |ParametricSpaceCurveFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ParametricSpaceCurveFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 15))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ParametricSpaceCurveFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ParametricSpaceCurveFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (|ParametricSpaceCurve| 6)
              (0 . |coordinate|) (|ParametricSpaceCurve| 7) (6 . |curve|)
              (|Mapping| 7 6) |PARSC2;map;MPscPsc;1|)
           '#(|map| 13) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|ParametricSpaceCurve| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|ParametricSpaceCurve| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 14
                                            '(2 9 6 0 8 10 3 11 0 7 7 7 12 2 0
                                              11 13 9 14)))))
           '|lookupComplete|)) 
