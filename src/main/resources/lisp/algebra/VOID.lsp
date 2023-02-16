
(PUT '|VOID;void;$;1| '|SPADreplace| '|voidValue|) 

(SDEFUN |VOID;void;$;1| (($ ($))) (|voidValue|)) 

(SDEFUN |VOID;coerce;$Of;2| ((|v| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9))) 

(DECLAIM (NOTINLINE |Void;|)) 

(DEFUN |Void| ()
  (SPROG NIL
         (PROG (#1=#:G697)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Void|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Void|
                             (LIST (CONS NIL (CONS 1 (|Void;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Void|)))))))))) 

(DEFUN |Void;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Void|))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Void| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|String|))
          $))) 

(MAKEPROP '|Void| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| |VOID;void;$;1| (|OutputForm|)
              (0 . |coerce|) |VOID;coerce;$Of;2|)
           '#(|void| 5 |coerce| 9) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|void| ($$)) T)
                                   '((|coerce| ((|OutputForm|) $$)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(1 6 8 0 9 0 0 0 7 1 0 8 0 10)))))
           '|lookupComplete|)) 

(MAKEPROP '|Void| 'NILADIC T) 
