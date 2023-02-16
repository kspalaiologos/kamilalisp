
(SDEFUN |INFPROD0;infiniteProduct;2UTS;1| ((|x| (UTS)) ($ (UTS)))
        (SPADCALL |x| 1 1 (QREFELT $ 11))) 

(SDEFUN |INFPROD0;evenInfiniteProduct;2UTS;2| ((|x| (UTS)) ($ (UTS)))
        (SPADCALL |x| 2 2 (QREFELT $ 11))) 

(SDEFUN |INFPROD0;oddInfiniteProduct;2UTS;3| ((|x| (UTS)) ($ (UTS)))
        (SPADCALL |x| 1 2 (QREFELT $ 11))) 

(SDEFUN |INFPROD0;generalInfiniteProduct;UTS2IUTS;4|
        ((|x| (UTS)) (|a| (|Integer|)) (|d| (|Integer|)) ($ (UTS)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 16)) |a| |d| (QREFELT $ 18))
         (QREFELT $ 19))) 

(DECLAIM (NOTINLINE |InfiniteLambertProduct;|)) 

(DEFUN |InfiniteLambertProduct| (&REST #1=#:G698)
  (SPROG NIL
         (PROG (#2=#:G699)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InfiniteLambertProduct|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InfiniteLambertProduct;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InfiniteLambertProduct|)))))))))) 

(DEFUN |InfiniteLambertProduct;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|InfiniteLambertProduct| DV$1 DV$2))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InfiniteLambertProduct|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|InfiniteLambertProduct| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (4 . |One|) (|Integer|)
              |INFPROD0;generalInfiniteProduct;UTS2IUTS;4|
              |INFPROD0;infiniteProduct;2UTS;1|
              |INFPROD0;evenInfiniteProduct;2UTS;2|
              |INFPROD0;oddInfiniteProduct;2UTS;3| (|Stream| 6)
              (8 . |coefficients|) (|StreamTaylorSeriesOperations| 6)
              (13 . |general_Lambert_product|) (20 . |series|))
           '#(|oddInfiniteProduct| 25 |infiniteProduct| 30
              |generalInfiniteProduct| 35 |evenInfiniteProduct| 42)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|infiniteProduct| (|#2| |#2|)) T)
                                   '((|evenInfiniteProduct| (|#2| |#2|)) T)
                                   '((|oddInfiniteProduct| (|#2| |#2|)) T)
                                   '((|generalInfiniteProduct|
                                      (|#2| |#2| (|Integer|) (|Integer|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(0 6 0 8 0 7 0 9 1 7 15 0 16 3 17
                                              15 15 10 10 18 1 7 0 15 19 1 0 7
                                              7 14 1 0 7 7 12 3 0 7 7 10 10 11
                                              1 0 7 7 13)))))
           '|lookupComplete|)) 
