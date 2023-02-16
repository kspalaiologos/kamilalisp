
(SDEFUN |BOUNDZRO;integerBound;UPI;1| ((|p| (UP)) ($ (|Integer|)))
        (SPADCALL |p| (QREFELT $ 10))) 

(PUT '|BOUNDZRO;integerBound;UPI;2| '|SPADreplace|
     '(XLAM (|p|) (|error| "integerBound: unimplemented"))) 

(SDEFUN |BOUNDZRO;integerBound;UPI;2| ((|p| (UP)) ($ (|Integer|)))
        (|error| "integerBound: unimplemented")) 

(DECLAIM (NOTINLINE |BoundIntegerRoots;|)) 

(DEFUN |BoundIntegerRoots| (&REST #1=#:G694)
  (SPROG NIL
         (PROG (#2=#:G695)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|BoundIntegerRoots|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |BoundIntegerRoots;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BoundIntegerRoots|)))))))))) 

(DEFUN |BoundIntegerRoots;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|BoundIntegerRoots| DV$1 DV$2))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|BoundIntegerRoots| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|LinearlyExplicitOver| (|Integer|)))
            (QSETREFV $ 11
                      (CONS (|dispatchFunction| |BOUNDZRO;integerBound;UPI;1|)
                            $)))
           ('T
            (QSETREFV $ 11
                      (CONS (|dispatchFunction| |BOUNDZRO;integerBound;UPI;2|)
                            $))))
          $))) 

(MAKEPROP '|BoundIntegerRoots| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Integer|)
              (|PolynomialRationalRoots| 6 7) (0 . |integerBound|)
              (5 . |integerBound|))
           '#(|integerBound| 10) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|integerBound| ((|Integer|) |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11
                                            '(1 9 8 7 10 1 0 8 7 11 1 0 8 7
                                              11)))))
           '|lookupComplete|)) 
