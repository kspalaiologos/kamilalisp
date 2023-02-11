
(SDEFUN |PDRING-;differentiate;ALA;1| ((|r| (A)) (|l| (|List| S)) ($ (A)))
        (SPROG ((#1=#:G708 NIL) (|s| NIL))
               (SEQ
                (SEQ (LETT |s| NIL) (LETT #1# |l|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT |r| (SPADCALL |r| |s| (QREFELT $ 8)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |PDRING-;differentiate;ASNniA;2|
        ((|r| (A)) (|s| (S)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPROG ((#1=#:G719 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (LETT |r| (SPADCALL |r| |s| (QREFELT $ 8)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |PDRING-;differentiate;ALLA;3|
        ((|r| (A)) (|ls| (|List| S)) (|ln| (|List| (|NonNegativeInteger|)))
         ($ (A)))
        (SPROG ((#1=#:G724 NIL) (|s| NIL) (#2=#:G725 NIL) (|n| NIL))
               (SEQ
                (SEQ (LETT |n| NIL) (LETT #2# |ln|) (LETT |s| NIL)
                     (LETT #1# |ls|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |n| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT (LETT |r| (SPADCALL |r| |s| |n| (QREFELT $ 13)))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |PDRING-;D;ASA;4| ((|r| (A)) (|v| (S)) ($ (A)))
        (SPADCALL |r| |v| (QREFELT $ 8))) 

(SDEFUN |PDRING-;D;ALA;5| ((|r| (A)) (|lv| (|List| S)) ($ (A)))
        (SPADCALL |r| |lv| (QREFELT $ 17))) 

(SDEFUN |PDRING-;D;ASNniA;6|
        ((|r| (A)) (|v| (S)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPADCALL |r| |v| |n| (QREFELT $ 13))) 

(SDEFUN |PDRING-;D;ALLA;7|
        ((|r| (A)) (|lv| (|List| S)) (|ln| (|List| (|NonNegativeInteger|)))
         ($ (A)))
        (SPADCALL |r| |lv| |ln| (QREFELT $ 20))) 

(DECLAIM (NOTINLINE |PartialDifferentialRing&;|)) 

(DEFUN |PartialDifferentialRing&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PartialDifferentialRing&| DV$1 DV$2))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PartialDifferentialRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |differentiate|) (|List| 7) |PDRING-;differentiate;ALA;1|
              (|NonNegativeInteger|) |PDRING-;differentiate;ASNniA;2|
              (6 . |differentiate|) (|List| 11) |PDRING-;differentiate;ALLA;3|
              |PDRING-;D;ASA;4| (13 . |differentiate|) |PDRING-;D;ALA;5|
              |PDRING-;D;ASNniA;6| (19 . |differentiate|) |PDRING-;D;ALLA;7|)
           '#(|differentiate| 26 D 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((D
                                 (|#1| |#1| (|List| |#2|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((D (|#1| |#1| |#2| (|NonNegativeInteger|))) T)
                              '((D (|#1| |#1| (|List| |#2|))) T)
                              '((D (|#1| |#1| |#2|)) T)
                              '((|differentiate|
                                 (|#1| |#1| (|List| |#2|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| |#2| (|NonNegativeInteger|)))
                                T)
                              '((|differentiate| (|#1| |#1| (|List| |#2|))) T)
                              '((|differentiate| (|#1| |#1| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(2 6 0 0 7 8 3 6 0 0 7 11 13 2 6 0
                                              0 9 17 3 6 0 0 9 14 20 3 0 0 0 7
                                              11 12 3 0 0 0 9 14 15 2 0 0 0 9
                                              10 3 0 0 0 7 11 19 3 0 0 0 9 14
                                              21 2 0 0 0 7 16 2 0 0 0 9 18)))))
           '|lookupComplete|)) 
