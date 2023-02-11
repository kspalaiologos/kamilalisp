
(DECLAIM (NOTINLINE |BezoutMatrixWrapper;|)) 

(DEFUN |BezoutMatrixWrapper| (&REST #1=#:G694)
  (SPROG NIL
         (PROG (#2=#:G695)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|BezoutMatrixWrapper|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |BezoutMatrixWrapper;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BezoutMatrixWrapper|)))))))))) 

(DEFUN |BezoutMatrixWrapper;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|BezoutMatrixWrapper| DV$1 DV$2))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|))))))
          (|haddProp| |$ConstructorCache| '|BezoutMatrixWrapper|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|BezoutMatrixWrapper| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|BezoutMatrix| 6 7 9 (|Vector| 6) (|Vector| 6)) (|local| |#1|)
              (|local| |#2|) (|IndexedVector| 7 '0) (|Matrix| 6)
              (|NonNegativeInteger|))
           '#() 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|sylvesterMatrix| ((|Matrix| |#1|) |#2| |#2|))
                                T)
                              '((|subSylvesterMatrix|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|subSylvesterMatrix|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|bezoutMatrix| ((|Matrix| |#1|) |#2| |#2|)) T)
                              '((|subresultants|
                                 ((|IndexedVector| |#2| 0) |#2| |#2|))
                                (|has| 6 (|CommutativeRing|)))
                              '((|bezoutResultant| (|#1| |#2| |#2|))
                                (|has| 6 (|CommutativeRing|)))
                              '((|bezoutDiscriminant| (|#1| |#2|))
                                (|has| 6 (|CommutativeRing|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 
