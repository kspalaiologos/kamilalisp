
(SDEFUN |RANDSRC;randnum;I;1| (($ (|Integer|)))
        (SPROG ((|t| (|Integer|)))
               (SEQ
                (LETT |t|
                      (REM
                       (- (* 271828183 (QREFELT $ 8))
                          (* 314159269 (QREFELT $ 7)))
                       (QREFELT $ 6)))
                (COND ((< |t| 0) (LETT |t| (+ |t| (QREFELT $ 6)))))
                (SETELT $ 7 (QREFELT $ 8)) (EXIT (SETELT $ 8 |t|))))) 

(SDEFUN |RANDSRC;size;I;2| (($ (|Integer|))) (QREFELT $ 6)) 

(SDEFUN |RANDSRC;reseed;IV;3| ((|n| (|Integer|)) ($ (|Void|)))
        (SEQ (SETELT $ 7 (REM |n| (QREFELT $ 6)))
             (EXIT (SETELT $ 8 (QUOTIENT2 |n| (QREFELT $ 6)))))) 

(SDEFUN |RANDSRC;seed;I;4| (($ (|Integer|)))
        (+ (* (QREFELT $ 8) (QREFELT $ 6)) (QREFELT $ 7))) 

(SDEFUN |RANDSRC;randnum;2I;5| ((|n| (|Integer|)) ($ (|Integer|)))
        (QUOTIENT2 (* |n| (SPADCALL (QREFELT $ 10))) (QREFELT $ 6))) 

(DECLAIM (NOTINLINE |RandomNumberSource;|)) 

(DEFUN |RandomNumberSource| ()
  (SPROG NIL
         (PROG (#1=#:G702)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|RandomNumberSource|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|RandomNumberSource|
                             (LIST
                              (CONS NIL (CONS 1 (|RandomNumberSource;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|RandomNumberSource|)))))))))) 

(DEFUN |RandomNumberSource;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|RandomNumberSource|))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RandomNumberSource| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (- (EXPT 2 31) 1))
          (QSETREFV $ 7 1231231231)
          (QSETREFV $ 8 3243232987)
          $))) 

(MAKEPROP '|RandomNumberSource| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|ranbase| '|x0| '|x1| (|Integer|)
              |RANDSRC;randnum;I;1| |RANDSRC;size;I;2| (|Void|)
              |RANDSRC;reseed;IV;3| |RANDSRC;seed;I;4| |RANDSRC;randnum;2I;5|)
           '#(|size| 0 |seed| 4 |reseed| 8 |randnum| 13) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|randnum| ((|Integer|))) T)
                                   '((|size| ((|Integer|))) T)
                                   '((|randnum| ((|Integer|) (|Integer|))) T)
                                   '((|reseed| ((|Void|) (|Integer|))) T)
                                   '((|seed| ((|Integer|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(0 0 9 11 0 0 9 14 1 0 12 9 13 0 0
                                              9 10 1 0 9 9 15)))))
           '|lookupComplete|)) 

(MAKEPROP '|RandomNumberSource| 'NILADIC T) 
