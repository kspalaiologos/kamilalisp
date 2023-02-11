
(DECLAIM (NOTINLINE |SExpression;|)) 

(DEFUN |SExpression| ()
  (SPROG NIL
         (PROG (#1=#:G2595)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|SExpression|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|SExpression|
                             (LIST (CONS NIL (CONS 1 (|SExpression;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|SExpression|)))))))))) 

(DEFUN |SExpression;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SExpression|))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SExpression| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SExpression| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SExpressionOf| 9 10 7 8) (|List| 7)
              (|Integer|) (|DoubleFloat|) (|String|) (|Symbol|) (|List| $)
              (|Boolean|) (|HashState|) (|OutputForm|) (|SingleInteger|))
           '#() 'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SExpressionCategory| 9 10 7 8) (|SetCategory|)
                           (|BasicType|) (|CoercibleTo| 14))
                        (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 

(MAKEPROP '|SExpression| 'NILADIC T) 
