
(SDEFUN |OPHANDL;new;$;1| (($ ($))) (SPADCALL (QREFELT $ 8))) 

(SDEFUN |OPHANDL;knownHandler?;$ISB;2|
        ((|t| ($)) (|n| (|Integer|)) (|op| (|String|)) ($ (|Boolean|)))
        (COND
         ((SPADCALL |n| |t| (QREFELT $ 12))
          (SPADCALL |op| (SPADCALL |t| |n| (QREFELT $ 14)) (QREFELT $ 16)))
         ('T NIL))) 

(SDEFUN |OPHANDL;handler;$ISHANDLER;3|
        ((|t| ($)) (|n| (|Integer|)) (|op| (|String|)) ($ (HANDLER)))
        (SPADCALL (SPADCALL |t| |n| (QREFELT $ 14)) |op| (QREFELT $ 18))) 

(SDEFUN |OPHANDL;setHandler!;$IS2HANDLER;4|
        ((|t| ($)) (|n| (|Integer|)) (|op| (|String|)) (|h| (HANDLER))
         ($ (HANDLER)))
        (SEQ
         (COND
          ((NULL (SPADCALL |n| |t| (QREFELT $ 12)))
           (SPADCALL |t| |n| (SPADCALL (QREFELT $ 20)) (QREFELT $ 21))))
         (EXIT
          (SPADCALL (SPADCALL |t| |n| (QREFELT $ 14)) |op| |h|
                    (QREFELT $ 22))))) 

(SDEFUN |OPHANDL;removeHandler!;$ISV;5|
        ((|t| ($)) (|n| (|Integer|)) (|op| (|String|)) ($ (|Void|)))
        (COND
         ((SPADCALL |n| |t| (QREFELT $ 12))
          (SPADCALL |op| (SPADCALL |t| |n| (QREFELT $ 14)) (QREFELT $ 25))))) 

(DECLAIM (NOTINLINE |OperatorHandlers;|)) 

(DEFUN |OperatorHandlers| (#1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|OperatorHandlers|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|OperatorHandlers;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|OperatorHandlers|)))))))))) 

(DEFUN |OperatorHandlers;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OperatorHandlers| DV$1))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OperatorHandlers| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OperatorHandlers| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|XHashTable| 11 13)
              (0 . |empty|) |OPHANDL;new;$;1| (|Boolean|) (|Integer|)
              (4 . |key?|) (|XHashTable| 15 6) (10 . |elt|) (|String|)
              (16 . |key?|) |OPHANDL;knownHandler?;$ISB;2| (22 . |elt|)
              |OPHANDL;handler;$ISHANDLER;3| (28 . |empty|) (32 . |setelt!|)
              (39 . |setelt!|) |OPHANDL;setHandler!;$IS2HANDLER;4|
              (|Union| 6 '"failed") (46 . |remove!|) (|Void|)
              |OPHANDL;removeHandler!;$ISV;5|)
           '#(|setHandler!| 52 |removeHandler!| 60 |new| 67 |knownHandler?| 71
              |handler| 78)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|new| ($$)) T)
                                   '((|knownHandler?|
                                      ((|Boolean|) $$ (|Integer|) (|String|)))
                                     T)
                                   '((|handler|
                                      (|#1| $$ (|Integer|) (|String|)))
                                     T)
                                   '((|setHandler!|
                                      (|#1| $$ (|Integer|) (|String|) |#1|))
                                     T)
                                   '((|removeHandler!|
                                      ((|Void|) $$ (|Integer|) (|String|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 27
                                            '(0 7 0 8 2 7 10 11 0 12 2 7 13 0
                                              11 14 2 13 10 15 0 16 2 13 6 0 15
                                              18 0 13 0 20 3 7 13 0 11 13 21 3
                                              13 6 0 15 6 22 2 13 24 15 0 25 4
                                              0 6 0 11 15 6 23 3 0 26 0 11 15
                                              27 0 0 0 9 3 0 10 0 11 15 17 3 0
                                              6 0 11 15 19)))))
           '|lookupComplete|)) 
