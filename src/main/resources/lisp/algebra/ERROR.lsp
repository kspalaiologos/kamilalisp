
(SDEFUN |ERROR;doit| ((|s| (|String|)) ($ (|Exit|)))
        (SEQ (|throwPatternMsg| |s| NIL) (EXIT "exit"))) 

(SDEFUN |ERROR;error;SE;2| ((|s| (|String|)) ($ (|Exit|)))
        (|ERROR;doit| (SPADCALL (LIST (QREFELT $ 6) |s|) (QREFELT $ 10)) $)) 

(SDEFUN |ERROR;error;LE;3| ((|l| (|List| (|String|))) ($ (|Exit|)))
        (SPROG ((|s| (|String|)) (#1=#:G705 NIL) (|x| NIL))
               (SEQ (LETT |s| (QREFELT $ 6))
                    (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |s|
                                 (SPADCALL (LIST |s| " " |x|)
                                           (QREFELT $ 10)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (|ERROR;doit| |s| $))))) 

(SDEFUN |ERROR;error;2SE;4| ((|fn| (|String|)) (|s| (|String|)) ($ (|Exit|)))
        (|ERROR;doit|
         (SPADCALL (LIST (QREFELT $ 7) |fn| ": %d %l " |s|) (QREFELT $ 10)) $)) 

(SDEFUN |ERROR;error;SLE;5|
        ((|fn| (|String|)) (|l| (|List| (|String|))) ($ (|Exit|)))
        (SPROG ((|s| (|String|)) (#1=#:G711 NIL) (|x| NIL))
               (SEQ
                (LETT |s|
                      (SPADCALL (LIST (QREFELT $ 7) |fn| ": %d %l")
                                (QREFELT $ 10)))
                (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |s|
                             (SPADCALL (LIST |s| " " |x|) (QREFELT $ 10)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (|ERROR;doit| |s| $))))) 

(DECLAIM (NOTINLINE |ErrorFunctions;|)) 

(DEFUN |ErrorFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G713)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ErrorFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ErrorFunctions|
                             (LIST (CONS NIL (CONS 1 (|ErrorFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ErrorFunctions|)))))))))) 

(DEFUN |ErrorFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ErrorFunctions|))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ErrorFunctions| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 "Error signalled from user code: %l ")
          (QSETREFV $ 7 "Error signalled from user code in function %b ")
          $))) 

(MAKEPROP '|ErrorFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|prefix1| '|prefix2| (|List| $)
              (|String|) (0 . |concat|) (|Exit|) |ERROR;error;SE;2| (|List| 9)
              |ERROR;error;LE;3| |ERROR;error;2SE;4| |ERROR;error;SLE;5|)
           '#(|error| 5) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|error| ((|Exit|) (|String|))) T)
                                   '((|error| ((|Exit|) (|List| (|String|))))
                                     T)
                                   '((|error| ((|Exit|) (|String|) (|String|)))
                                     T)
                                   '((|error|
                                      ((|Exit|) (|String|)
                                       (|List| (|String|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(1 9 0 8 10 1 0 11 13 14 1 0 11 9
                                              12 2 0 11 9 13 16 2 0 11 9 9
                                              15)))))
           '|lookupComplete|)) 

(MAKEPROP '|ErrorFunctions| 'NILADIC T) 
