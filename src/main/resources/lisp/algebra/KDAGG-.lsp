
(SDEFUN |KDAGG-;key?;KeySB;1| ((|k| (|Key|)) (|t| (S)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |k| |t| (QREFELT $ 10)) 0)) 

(SDEFUN |KDAGG-;member?;RSB;2|
        ((|p| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))) (|t| (S))
         ($ (|Boolean|)))
        (SPROG ((|r| (|Union| |Entry| "failed")))
               (SEQ (LETT |r| (SPADCALL (QCAR |p|) |t| (QREFELT $ 10)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0)
                       (SPADCALL (CONS 0 (QCDR |r|)) (CONS 0 (QCDR |p|))
                                 (QREFELT $ 13)))
                      ('T NIL)))))) 

(SDEFUN |KDAGG-;keys;SL;3| ((|t| (S)) ($ (|List| |Key|)))
        (SPROG ((#1=#:G723 NIL) (|x| NIL) (#2=#:G722 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 17)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCAR |x|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |KeyedDictionary&;|)) 

(DEFUN |KeyedDictionary&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|KeyedDictionary&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|finiteAggregate|))
            (QSETREFV $ 19 (CONS (|dispatchFunction| |KDAGG-;keys;SL;3|) $))))
          $))) 

(MAKEPROP '|KeyedDictionary&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Union| 8 '"failed") (0 . |search|) (|Boolean|)
              |KDAGG-;key?;KeySB;1| (6 . =)
              (|Record| (|:| |key| 7) (|:| |entry| 8)) |KDAGG-;member?;RSB;2|
              (|List| 14) (12 . |parts|) (|List| 7) (17 . |keys|))
           '#(|member?| 22 |keys| 28 |key?| 33) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|keys| ((|List| |#2|) |#1|)) T)
                                   '((|key?| ((|Boolean|) |#2| |#1|)) T)
                                   '((|member?|
                                      ((|Boolean|)
                                       (|Record| (|:| |key| |#2|)
                                                 (|:| |entry| |#3|))
                                       |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(2 6 9 7 0 10 2 9 11 0 0 13 1 6 16
                                              0 17 1 0 18 0 19 2 0 11 14 0 15 1
                                              0 18 0 19 2 0 11 7 0 12)))))
           '|lookupComplete|)) 
