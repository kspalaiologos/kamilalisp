
(PUT '|INTBIT;bitTruth;INniB;1| '|SPADreplace|
     '(XLAM (|n| |i|) (LOGBITP |i| |n|))) 

(SDEFUN |INTBIT;bitTruth;INniB;1|
        ((|n| (|Integer|)) (|i| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (LOGBITP |i| |n|)) 

(SDEFUN |INTBIT;bitCoef;INniI;2|
        ((|n| (|Integer|)) (|i| (|NonNegativeInteger|)) ($ (|Integer|)))
        (COND ((SPADCALL |n| |i| (QREFELT $ 9)) 1) ('T 0))) 

(DECLAIM (NOTINLINE |IntegerBits;|)) 

(DEFUN |IntegerBits| ()
  (SPROG NIL
         (PROG (#1=#:G698)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|IntegerBits|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|IntegerBits|
                             (LIST (CONS NIL (CONS 1 (|IntegerBits;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|IntegerBits|)))))))))) 

(DEFUN |IntegerBits;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|IntegerBits|))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerBits| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegerBits| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) (|Integer|)
              (|NonNegativeInteger|) |INTBIT;bitTruth;INniB;1|
              |INTBIT;bitCoef;INniI;2|)
           '#(|bitTruth| 0 |bitCoef| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|bitCoef|
                                 ((|Integer|) (|Integer|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|bitTruth|
                                 ((|Boolean|) (|Integer|)
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10 '(2 0 6 7 8 9 2 0 7 7 8 10)))))
           '|lookupComplete|)) 

(MAKEPROP '|IntegerBits| 'NILADIC T) 
