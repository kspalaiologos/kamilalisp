
(PUT '|HASHSTAT;new;$;1| '|SPADreplace| '(XLAM NIL HASHSTATEBASIS)) 

(SDEFUN |HASHSTAT;new;$;1| (($ ($))) HASHSTATEBASIS) 

(PUT '|HASHSTAT;value;$Si;2| '|SPADreplace| 'HASHSTATEMAKEFIXNUM) 

(SDEFUN |HASHSTAT;value;$Si;2| ((|hs| ($)) ($ (|SingleInteger|)))
        (HASHSTATEMAKEFIXNUM |hs|)) 

(PUT '|HASHSTAT;update!;$Si$;3| '|SPADreplace| 'HASHSTATEUPDATE) 

(SDEFUN |HASHSTAT;update!;$Si$;3| ((|hs| ($)) (|i| (|SingleInteger|)) ($ ($)))
        (HASHSTATEUPDATE |hs| |i|)) 

(PUT '|HASHSTAT;modulo| '|SPADreplace| 'HASHSTATEMOD) 

(SDEFUN |HASHSTAT;modulo|
        ((|hs| ($)) (|i| (|SingleInteger|)) ($ (|SingleInteger|)))
        (HASHSTATEMOD |hs| |i|)) 

(DECLAIM (NOTINLINE |HashState;|)) 

(DEFUN |HashState| ()
  (SPROG NIL
         (PROG (#1=#:G1613)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|HashState|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|HashState|
                             (LIST (CONS NIL (CONS 1 (|HashState;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|HashState|)))))))))) 

(DEFUN |HashState;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|HashState|))
          (LETT $ (GETREFV 10))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|HashState| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|HashState| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL |HASHSTAT;new;$;1| (|SingleInteger|)
              |HASHSTAT;value;$Si;2| |HASHSTAT;update!;$Si$;3|)
           '#(|value| 0 |update!| 5 |new| 11) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|new| ($$)) T)
                                   '((|update!| ($$ $$ (|SingleInteger|))) T)
                                   '((|value| ((|SingleInteger|) $$)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 9
                                            '(1 0 7 0 8 2 0 0 0 7 9 0 0 0
                                              6)))))
           '|lookupComplete|)) 

(MAKEPROP '|HashState| 'NILADIC T) 
