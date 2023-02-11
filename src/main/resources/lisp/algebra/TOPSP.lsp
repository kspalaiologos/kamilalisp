
(SDEFUN |TOPSP;createThreeSpace;Ts;1| (($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL (QREFELT $ 7))) 

(DECLAIM (NOTINLINE |TopLevelThreeSpace;|)) 

(DEFUN |TopLevelThreeSpace| ()
  (SPROG NIL
         (PROG (#1=#:G694)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|TopLevelThreeSpace|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|TopLevelThreeSpace|
                             (LIST
                              (CONS NIL (CONS 1 (|TopLevelThreeSpace;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|TopLevelThreeSpace|)))))))))) 

(DEFUN |TopLevelThreeSpace;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TopLevelThreeSpace|))
          (LETT $ (GETREFV 9))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TopLevelThreeSpace| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TopLevelThreeSpace| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|ThreeSpace| (|DoubleFloat|))
              (0 . |create3Space|) |TOPSP;createThreeSpace;Ts;1|)
           '#(|createThreeSpace| 4) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|createThreeSpace|
                                 ((|ThreeSpace| (|DoubleFloat|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 8 '(0 6 0 7 0 0 6 8)))))
           '|lookupComplete|)) 

(MAKEPROP '|TopLevelThreeSpace| 'NILADIC T) 
