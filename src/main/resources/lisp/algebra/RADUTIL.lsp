
(SDEFUN |RADUTIL;radix;FIA;1|
        ((|q| (|Fraction| (|Integer|))) (|b| (|Integer|)) ($ (|Any|)))
        (SPADCALL
         (SPADCALL |q|
                   (|compiledLookupCheck| '|coerce|
                                          (LIST '$
                                                (LIST '|Fraction|
                                                      (LIST '|Integer|)))
                                          (|RadixExpansion| |b|)))
         (|compiledLookupCheck| '|coerce|
                                (LIST (LIST '|Any|)
                                      (LIST '|RadixExpansion| |b|))
                                (|AnyFunctions1| (|RadixExpansion| |b|))))) 

(DECLAIM (NOTINLINE |RadixUtilities;|)) 

(DEFUN |RadixUtilities| ()
  (SPROG NIL
         (PROG (#1=#:G701)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|RadixUtilities|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|RadixUtilities|
                             (LIST (CONS NIL (CONS 1 (|RadixUtilities;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|RadixUtilities|)))))))))) 

(DEFUN |RadixUtilities;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|RadixUtilities|))
          (LETT $ (GETREFV 10))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RadixUtilities| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RadixUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Any|) (|Fraction| 8) (|Integer|)
              |RADUTIL;radix;FIA;1|)
           '#(|radix| 0) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|radix|
                                 ((|Any|) (|Fraction| (|Integer|))
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 9 '(2 0 6 7 8 9)))))
           '|lookupComplete|)) 

(MAKEPROP '|RadixUtilities| 'NILADIC T) 
