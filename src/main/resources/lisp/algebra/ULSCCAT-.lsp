
(SDEFUN |ULSCCAT-;zero?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 11))) 

(SDEFUN |ULSCCAT-;retract;SUTS;2| ((|x| (S)) ($ (UTS)))
        (SPADCALL |x| (QREFELT $ 13))) 

(SDEFUN |ULSCCAT-;retractIfCan;SU;3| ((|x| (S)) ($ (|Union| UTS "failed")))
        (SPADCALL |x| (QREFELT $ 16))) 

(SDEFUN |ULSCCAT-;laurent;ISS;4|
        ((|n| (|Integer|)) (|st| (|Stream| |Coef|)) ($ (S)))
        (SPADCALL |n| (SPADCALL |st| (QREFELT $ 19)) (QREFELT $ 21))) 

(DECLAIM (NOTINLINE |UnivariateLaurentSeriesConstructorCategory&;|)) 

(DEFUN |UnivariateLaurentSeriesConstructorCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|UnivariateLaurentSeriesConstructorCategory&| DV$1 DV$2
                      DV$3))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Field|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariateLaurentSeriesConstructorCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |taylorRep|) (|Boolean|) (5 . |zero?|)
              |ULSCCAT-;zero?;SB;1| (10 . |taylor|) |ULSCCAT-;retract;SUTS;2|
              (|Union| 8 '"failed") (15 . |taylorIfCan|)
              |ULSCCAT-;retractIfCan;SU;3| (|Stream| 7) (20 . |series|)
              (|Integer|) (25 . |laurent|) |ULSCCAT-;laurent;ISS;4| (|Symbol|)
              (|Union| 23 '#1="failed") (|Union| 26 '#1#) (|Fraction| 20)
              (|Union| 20 '#1#))
           '#(|zero?| 31 |retractIfCan| 36 |retract| 41 |laurent| 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|zero?| ((|Boolean|) |#1|)) T)
                                   '((|retract| ((|Symbol|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Symbol|) #1#) |#1|))
                                     T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #1#)
                                       |#1|))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #1#) |#1|))
                                     T)
                                   '((|laurent| (|#1| (|Integer|) |#3|)) T)
                                   '((|retractIfCan| ((|Union| |#3| #1#) |#1|))
                                     T)
                                   '((|retract| (|#3| |#1|)) T)
                                   '((|laurent|
                                      (|#1| (|Integer|) (|Stream| |#2|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(1 6 8 0 9 1 8 10 0 11 1 6 8 0 13
                                              1 6 15 0 16 1 8 0 18 19 2 6 0 20
                                              8 21 1 0 10 0 12 1 0 15 0 17 1 0
                                              8 0 14 2 0 0 20 18 22)))))
           '|lookupComplete|)) 
