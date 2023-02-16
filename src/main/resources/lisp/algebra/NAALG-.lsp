
(SDEFUN |NAALG-;plenaryPower;SPiS;1|
        ((|a| (S)) (|n| (|PositiveInteger|)) ($ (S)))
        (SPROG ((|n1| (|PositiveInteger|)) (#1=#:G707 NIL) (#2=#:G706 NIL))
               (SEQ
                (COND ((EQL |n| 1) |a|)
                      ('T
                       (SEQ
                        (LETT |n1|
                              (PROG1
                                  (LETT #1#
                                        (PROG1 (LETT #2# (- |n| 1))
                                          (|check_subtype2| (>= #2# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #2#)))
                                (|check_subtype2| (> #1# 0)
                                                  '(|PositiveInteger|)
                                                  '(|NonNegativeInteger|)
                                                  #1#)))
                        (EXIT
                         (SPADCALL (SPADCALL |a| |n1| (QREFELT $ 10))
                                   (SPADCALL |a| |n1| (QREFELT $ 10))
                                   (QREFELT $ 11))))))))) 

(DECLAIM (NOTINLINE |NonAssociativeAlgebra&;|)) 

(DEFUN |NonAssociativeAlgebra&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|NonAssociativeAlgebra&| DV$1 DV$2))
          (LETT $ (GETREFV 13))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NonAssociativeAlgebra&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (|PositiveInteger|) (4 . |plenaryPower|) (10 . *)
              |NAALG-;plenaryPower;SPiS;1|)
           '#(|plenaryPower| 16) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|plenaryPower|
                                 (|#1| |#1| (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 12
                                            '(0 7 0 8 2 6 0 0 9 10 2 6 0 0 0 11
                                              2 0 0 0 9 12)))))
           '|lookupComplete|)) 
