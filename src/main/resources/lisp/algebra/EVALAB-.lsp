
(SDEFUN |EVALAB-;eval;SES;1| ((|f| (S)) (|eq| (|Equation| R)) ($ (S)))
        (SPADCALL |f| (LIST |eq|) (QREFELT $ 9))) 

(SDEFUN |EVALAB-;eval;S2LS;2|
        ((|f| (S)) (|xs| (|List| R)) (|vs| (|List| R)) ($ (S)))
        (SPROG
         ((#1=#:G710 NIL) (|x| NIL) (#2=#:G711 NIL) (|v| NIL) (#3=#:G709 NIL))
         (SEQ
          (SPADCALL |f|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |v| NIL) (LETT #2# |vs|) (LETT |x| NIL)
                          (LETT #1# |xs|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL)
                                (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #3#
                                  (CONS (SPADCALL |x| |v| (QREFELT $ 12))
                                        #3#))))
                          (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                          (GO G190) G191 (EXIT (NREVERSE #3#))))
                    (QREFELT $ 9))))) 

(DECLAIM (NOTINLINE |Evalable&;|)) 

(DEFUN |Evalable&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Evalable&| DV$1 DV$2))
          (LETT $ (GETREFV 15))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Evalable&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 10)
              (0 . |eval|) (|Equation| 7) |EVALAB-;eval;SES;1| (6 . =)
              (|List| 7) |EVALAB-;eval;S2LS;2|)
           '#(|eval| 12) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|eval| (|#1| |#1| (|List| (|Equation| |#2|))))
                                T)
                              '((|eval| (|#1| |#1| (|Equation| |#2|))) T)
                              '((|eval| (|#1| |#1| |#2| |#2|)) T)
                              '((|eval|
                                 (|#1| |#1| (|List| |#2|) (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 14
                                            '(2 6 0 0 8 9 2 10 0 7 7 12 2 0 0 0
                                              10 11 3 0 0 0 13 13 14)))))
           '|lookupComplete|)) 
