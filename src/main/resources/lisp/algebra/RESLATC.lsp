
(SDEFUN |RESLATC;coerce;SV;1| ((|s| (S)) ($ (|Void|))) (SPADCALL (QREFELT $ 8))) 

(PUT '|RESLATC;coerce;ES;2| '|SPADreplace|
     '(XLAM (|e|)
       (|error| "Bug: Should not be able to obtain value of type Exit"))) 

(SDEFUN |RESLATC;coerce;ES;2| ((|e| (|Exit|)) ($ (S)))
        (|error| "Bug: Should not be able to obtain value of type Exit")) 

(DECLAIM (NOTINLINE |ResolveLatticeCompletion;|)) 

(DEFUN |ResolveLatticeCompletion| (#1=#:G691)
  (SPROG NIL
         (PROG (#2=#:G692)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ResolveLatticeCompletion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|ResolveLatticeCompletion;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ResolveLatticeCompletion|)))))))))) 

(DEFUN |ResolveLatticeCompletion;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ResolveLatticeCompletion| DV$1))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ResolveLatticeCompletion|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ResolveLatticeCompletion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Void|) (0 . |void|)
              |RESLATC;coerce;SV;1| (|Exit|) |RESLATC;coerce;ES;2|)
           '#(|coerce| 4) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| ((|Void|) |#1|)) T)
                                   '((|coerce| (|#1| (|Exit|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11
                                            '(0 7 0 8 1 0 6 10 11 1 0 7 6
                                              9)))))
           '|lookupComplete|)) 
