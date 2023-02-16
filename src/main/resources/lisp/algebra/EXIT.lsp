
(PUT '|EXIT;coerce;$Of;1| '|SPADreplace|
     '(XLAM (|n|) (|error| "Cannot use an Exit value."))) 

(SDEFUN |EXIT;coerce;$Of;1| ((|n| ($)) ($ (|OutputForm|)))
        (|error| "Cannot use an Exit value.")) 

(PUT '|EXIT;=;2$B;2| '|SPADreplace|
     '(XLAM (|n1| |n2|) (|error| "Cannot use an Exit value."))) 

(SDEFUN |EXIT;=;2$B;2| ((|n1| ($)) (|n2| ($)) ($ (|Boolean|)))
        (|error| "Cannot use an Exit value.")) 

(DECLAIM (NOTINLINE |Exit;|)) 

(DEFUN |Exit| ()
  (SPROG NIL
         (PROG (#1=#:G694)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Exit|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Exit|
                             (LIST (CONS NIL (CONS 1 (|Exit;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Exit|)))))))))) 

(DEFUN |Exit;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Exit|))
          (LETT $ (GETREFV 13))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Exit| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Exit| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) |EXIT;coerce;$Of;1|
              (|Boolean|) |EXIT;=;2$B;2| (|String|) (|SingleInteger|)
              (|HashState|))
           '#(~= 0 |latex| 6 |hashUpdate!| 11 |hash| 17 |coerce| 22 = 27) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 6))
                        (|makeByteWordVec2| 12
                                            '(2 0 8 0 0 1 1 0 10 0 1 2 0 12 12
                                              0 1 1 0 11 0 1 1 0 6 0 7 2 0 8 0
                                              0 9)))))
           '|lookupComplete|)) 

(MAKEPROP '|Exit| 'NILADIC T) 
