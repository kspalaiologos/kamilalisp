
(SDEFUN |UDVO;setVariableOrder;LV;1| ((|l| (|List| (|Symbol|))) ($ (|Void|)))
        (SPADCALL (REVERSE |l|) (QREFELT $ 9))) 

(SDEFUN |UDVO;setVariableOrder;2LV;2|
        ((|l1| (|List| (|Symbol|))) (|l2| (|List| (|Symbol|))) ($ (|Void|)))
        (SPADCALL (REVERSE |l2|) (REVERSE |l1|) (QREFELT $ 11))) 

(SDEFUN |UDVO;resetVariableOrder;V;3| (($ (|Void|)))
        (SPADCALL NIL NIL (QREFELT $ 12))) 

(SDEFUN |UDVO;getVariableOrder;R;4|
        (($
          (|Record| (|:| |high| (|List| (|Symbol|)))
                    (|:| |low| (|List| (|Symbol|))))))
        (SPROG
         ((|r|
           (|Record| (|:| |low| (|List| (|Symbol|)))
                     (|:| |high| (|List| (|Symbol|))))))
         (SEQ (LETT |r| (SPADCALL (QREFELT $ 15)))
              (EXIT (CONS (REVERSE (QCDR |r|)) (REVERSE (QCAR |r|))))))) 

(DECLAIM (NOTINLINE |UserDefinedVariableOrdering;|)) 

(DEFUN |UserDefinedVariableOrdering| ()
  (SPROG NIL
         (PROG (#1=#:G705)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|UserDefinedVariableOrdering|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|UserDefinedVariableOrdering|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|UserDefinedVariableOrdering;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|UserDefinedVariableOrdering|)))))))))) 

(DEFUN |UserDefinedVariableOrdering;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|UserDefinedVariableOrdering|))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|UserDefinedVariableOrdering| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UserDefinedVariableOrdering| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Void|) (|List| (|Symbol|))
              (|UserDefinedPartialOrdering| (|Symbol|)) (0 . |setOrder|)
              |UDVO;setVariableOrder;LV;1| (5 . |setOrder|)
              |UDVO;setVariableOrder;2LV;2| |UDVO;resetVariableOrder;V;3|
              (|Record| (|:| |low| 7) (|:| |high| 7)) (11 . |getOrder|)
              (|Record| (|:| |high| 7) (|:| |low| 7))
              |UDVO;getVariableOrder;R;4|)
           '#(|setVariableOrder| 15 |resetVariableOrder| 26 |getVariableOrder|
              30)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|setVariableOrder|
                                 ((|Void|) (|List| (|Symbol|))))
                                T)
                              '((|setVariableOrder|
                                 ((|Void|) (|List| (|Symbol|))
                                  (|List| (|Symbol|))))
                                T)
                              '((|getVariableOrder|
                                 ((|Record| (|:| |high| (|List| (|Symbol|)))
                                            (|:| |low| (|List| (|Symbol|))))))
                                T)
                              '((|resetVariableOrder| ((|Void|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 8 6 7 9 2 8 6 7 7 11 0 8 14 15
                                              2 0 6 7 7 12 1 0 6 7 10 0 0 6 13
                                              0 0 16 17)))))
           '|lookupComplete|)) 

(MAKEPROP '|UserDefinedVariableOrdering| 'NILADIC T) 
