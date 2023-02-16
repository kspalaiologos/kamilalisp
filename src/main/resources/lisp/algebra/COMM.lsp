
(SDEFUN |COMM;=;2$B;1| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|yy| (P)) (|xx| (P)))
               (SEQ
                (COND
                 ((QEQCAR |x| 0)
                  (COND
                   ((QEQCAR |y| 0)
                    (EXIT
                     (SPADCALL (CONS 0 (QCDR |x|)) (CONS 0 (QCDR |y|))
                               (QREFELT $ 9)))))))
                (COND
                 ((QEQCAR |x| 1)
                  (COND
                   ((QEQCAR |y| 1)
                    (EXIT
                     (SEQ (LETT |xx| (QCDR |x|)) (LETT |yy| (QCDR |y|))
                          (EXIT
                           (COND
                            ((SPADCALL (QCDR |xx|) (QCDR |yy|) (QREFELT $ 9))
                             (SPADCALL (QCAR |xx|) (QCAR |yy|) (QREFELT $ 9)))
                            ('T NIL)))))))))
                (EXIT NIL)))) 

(SDEFUN |COMM;mkcomm;I$;2| ((|i| (|Integer|)) ($ ($)))
        (CONS 0 (SPADCALL |i| (QREFELT $ 12)))) 

(SDEFUN |COMM;mkcomm;3$;3| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS 1 (CONS |x| |y|))) 

(SDEFUN |COMM;coerce;$Of;4| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|xx| (P)))
               (SEQ
                (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 16)))
                      ('T
                       (SEQ (LETT |xx| (QCDR |x|))
                            (EXIT
                             (SPADCALL
                              (LIST (SPADCALL (QCAR |xx|) (QREFELT $ 17))
                                    (SPADCALL (QCDR |xx|) (QREFELT $ 17)))
                              (QREFELT $ 19))))))))) 

(DECLAIM (NOTINLINE |Commutator;|)) 

(DEFUN |Commutator| ()
  (SPROG NIL
         (PROG (#1=#:G715)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Commutator|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Commutator|
                             (LIST (CONS NIL (CONS 1 (|Commutator;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|Commutator|)))))))))) 

(DEFUN |Commutator;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Commutator|))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Commutator| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|Record| (|:| |left| $) (|:| |right| $)))
          (QSETREFV $ 7 (|Union| (|OrdSetInts|) (QREFELT $ 6)))
          $))) 

(MAKEPROP '|Commutator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL 'P '|Rep| (|Boolean|) |COMM;=;2$B;1|
              (|Integer|) (|OrdSetInts|) (0 . |coerce|) |COMM;mkcomm;I$;2|
              |COMM;mkcomm;3$;3| (|OutputForm|) (5 . |coerce|)
              |COMM;coerce;$Of;4| (|List| $) (10 . |bracket|) (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 15 |mkcomm| 21 |latex| 32 |hashUpdate!| 37 |hash| 43 |coerce|
              48 = 53)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 15))
                        (|makeByteWordVec2| 22
                                            '(1 11 0 10 12 1 11 15 0 16 1 15 0
                                              18 19 2 0 8 0 0 1 1 0 0 10 13 2 0
                                              0 0 0 14 1 0 21 0 1 2 0 20 20 0 1
                                              1 0 22 0 1 1 0 15 0 17 2 0 8 0 0
                                              9)))))
           '|lookupComplete|)) 

(MAKEPROP '|Commutator| 'NILADIC T) 
