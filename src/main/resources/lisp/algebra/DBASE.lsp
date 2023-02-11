
(PUT '|DBASE;coerce;L$;1| '|SPADreplace| '(XLAM (|u|) |u|)) 

(SDEFUN |DBASE;coerce;L$;1| ((|u| (|List| S)) ($ ($))) |u|) 

(SDEFUN |DBASE;elt;$SDl;2|
        ((|data| ($)) (|s| (|Symbol|)) ($ (|DataList| (|String|))))
        (SPROG ((#1=#:G699 NIL) (|x| NIL) (#2=#:G698 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |x| NIL) (LETT #1# |data|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS (SPADCALL |x| |s| (QREFELT $ 11)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 14))))) 

(SDEFUN |DBASE;elt;$Qe$;3| ((|data| ($)) (|eq| (|QueryEquation|)) ($ ($)))
        (SPROG
         ((#1=#:G705 NIL) (|x| NIL) (#2=#:G704 NIL) (|val| (|String|))
          (|field| (|Symbol|)))
         (SEQ (LETT |field| (SPADCALL |eq| (QREFELT $ 17)))
              (LETT |val| (SPADCALL |eq| (QREFELT $ 18)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |x| NIL) (LETT #1# |data|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((|stringMatches?| |val|
                                           (SPADCALL |x| |field|
                                                     (QREFELT $ 11)))
                         (LETT #2# (CONS |x| #2#))))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |DBASE;+;3$;4| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL |x| |y| (QREFELT $ 20)) (QREFELT $ 21))) 

(SDEFUN |DBASE;-;3$;5| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 24)) |y| (QREFELT $ 26))) 

(SDEFUN |DBASE;coerce;$Of;6| ((|data| ($)) ($ (|OutputForm|)))
        (SPADCALL (LENGTH |data|) (QREFELT $ 30))) 

(SDEFUN |DBASE;display;$V;7| ((|data| ($)) ($ (|Void|)))
        (SPROG ((#1=#:G716 NIL) (|x| NIL))
               (SEQ (LETT |x| NIL) (LETT #1# |data|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ (EXIT (SPADCALL |x| (QREFELT $ 33))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |DBASE;fullDisplay;$V;8| ((|data| ($)) ($ (|Void|)))
        (SPROG ((#1=#:G720 NIL) (|x| NIL))
               (SEQ (LETT |x| NIL) (LETT #1# |data|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ (EXIT (SPADCALL |x| (QREFELT $ 35))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |DBASE;fullDisplay;$2PiV;9|
        ((|data| ($)) (|n| (|PositiveInteger|)) (|m| (|PositiveInteger|))
         ($ (|Void|)))
        (SPROG ((#1=#:G727 NIL) (|x| NIL) (#2=#:G728 NIL) (|i| NIL))
               (SEQ (LETT |i| 1) (LETT #2# |m|) (LETT |x| NIL)
                    (LETT #1# |data|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL)
                          (|greater_SI| |i| #2#))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (COND ((>= |i| |n|) (SPADCALL |x| (QREFELT $ 35))))))
                    (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                    (GO G190) G191 (EXIT NIL)))) 

(DECLAIM (NOTINLINE |Database;|)) 

(DEFUN |Database| (#1=#:G729)
  (SPROG NIL
         (PROG (#2=#:G730)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Database|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Database;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Database|)))))))))) 

(DEFUN |Database;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Database| DV$1))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Database| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|List| |#1|))
          $))) 

(MAKEPROP '|Database| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|List| 6) (|local| |#1|) '|Rep|
              |DBASE;coerce;L$;1| (|String|) (|Symbol|) (0 . |elt|) (|List| 9)
              (|DataList| 9) (6 . |coerce|) |DBASE;elt;$SDl;2|
              (|QueryEquation|) (11 . |variable|) (16 . |value|)
              |DBASE;elt;$Qe$;3| (21 . |merge|) (27 . |removeDuplicates!|)
              |DBASE;+;3$;4| (32 . |copy|) (37 . |copy|) (|MergeThing| 6)
              (42 . |mergeDifference|) |DBASE;-;3$;5| (|OutputForm|)
              (|NonNegativeInteger|) (48 . |coerce|) |DBASE;coerce;$Of;6|
              (|Void|) (53 . |display|) |DBASE;display;$V;7|
              (58 . |fullDisplay|) |DBASE;fullDisplay;$V;8| (|PositiveInteger|)
              |DBASE;fullDisplay;$2PiV;9| (|HashState|) (|SingleInteger|)
              (|Boolean|))
           '#(~= 63 |latex| 69 |hashUpdate!| 74 |hash| 80 |fullDisplay| 85
              |elt| 97 |display| 109 |coerce| 114 = 124 - 130 + 136)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 28))
                        (|makeByteWordVec2| 41
                                            '(2 6 9 0 10 11 1 13 0 12 14 1 16
                                              10 0 17 1 16 9 0 18 2 7 0 0 0 20
                                              1 7 0 0 21 1 7 0 0 23 1 5 0 0 24
                                              2 25 5 5 5 26 1 29 28 0 30 1 6 32
                                              0 33 1 6 32 0 35 2 0 41 0 0 1 1 0
                                              9 0 1 2 0 39 39 0 1 1 0 40 0 1 3
                                              0 32 0 37 37 38 1 0 32 0 36 2 0
                                              13 0 10 15 2 0 0 0 16 19 1 0 32 0
                                              34 1 0 0 5 8 1 0 28 0 31 2 0 41 0
                                              0 1 2 0 0 0 0 27 2 0 0 0 0
                                              22)))))
           '|lookupComplete|)) 
