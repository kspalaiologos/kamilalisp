
(SDEFUN |UPXSCCA-;zero?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 11))) 

(SDEFUN |UPXSCCA-;retract;SULS;2| ((|x| (S)) ($ (ULS)))
        (SPADCALL |x| (QREFELT $ 13))) 

(SDEFUN |UPXSCCA-;retractIfCan;SU;3| ((|x| (S)) ($ (|Union| ULS "failed")))
        (SPADCALL |x| (QREFELT $ 16))) 

(DECLAIM (NOTINLINE |UnivariatePuiseuxSeriesConstructorCategory&;|)) 

(DEFUN |UnivariatePuiseuxSeriesConstructorCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|UnivariatePuiseuxSeriesConstructorCategory&| DV$1 DV$2
                      DV$3))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariatePuiseuxSeriesConstructorCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |laurentRep|) (|Boolean|) (5 . |zero?|)
              |UPXSCCA-;zero?;SB;1| (10 . |laurent|) |UPXSCCA-;retract;SULS;2|
              (|Union| 8 '"failed") (15 . |laurentIfCan|)
              |UPXSCCA-;retractIfCan;SU;3|)
           '#(|zero?| 20 |retractIfCan| 25 |retract| 30) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|retractIfCan| ((|Union| |#3| "failed") |#1|))
                                T)
                              '((|retract| (|#3| |#1|)) T)
                              '((|zero?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 6 8 0 9 1 8 10 0 11 1 6 8 0 13
                                              1 6 15 0 16 1 0 10 0 12 1 0 15 0
                                              17 1 0 8 0 14)))))
           '|lookupComplete|)) 
