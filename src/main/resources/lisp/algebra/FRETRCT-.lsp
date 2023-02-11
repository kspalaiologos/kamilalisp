
(SDEFUN |FRETRCT-;coerce;IA;1| ((|n| (|Integer|)) ($ (A)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 9)) (QREFELT $ 10))) 

(SDEFUN |FRETRCT-;retract;AI;2| ((|r| (A)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 12)) (QREFELT $ 13))) 

(SDEFUN |FRETRCT-;retractIfCan;AU;3|
        ((|r| (A)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|u| (|Union| S "failed")))
               (SEQ (LETT |u| (SPADCALL |r| (QREFELT $ 16)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |u|) (QREFELT $ 18)))))))) 

(SDEFUN |FRETRCT-;coerce;FA;4| ((|n| (|Fraction| (|Integer|))) ($ (A)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 21)) (QREFELT $ 10))) 

(SDEFUN |FRETRCT-;retract;AF;5| ((|r| (A)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL |r| (QREFELT $ 12)) (QREFELT $ 23))) 

(SDEFUN |FRETRCT-;retractIfCan;AU;6|
        ((|r| (A)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPROG ((|u| (|Union| S "failed")))
               (SEQ (LETT |u| (SPADCALL |r| (QREFELT $ 16)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |u|) (QREFELT $ 26)))))))) 

(DECLAIM (NOTINLINE |FullyRetractableTo&;|)) 

(DEFUN |FullyRetractableTo&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FullyRetractableTo&| DV$1 DV$2))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Integer|)))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND ((|domainEqual| |#2| (|Integer|)))
                ((|testBitVector| |pv$| 2)
                 (PROGN
                  (QSETREFV $ 11
                            (CONS (|dispatchFunction| |FRETRCT-;coerce;IA;1|)
                                  $))
                  (QSETREFV $ 14
                            (CONS (|dispatchFunction| |FRETRCT-;retract;AI;2|)
                                  $))
                  (QSETREFV $ 19
                            (CONS
                             (|dispatchFunction| |FRETRCT-;retractIfCan;AU;3|)
                             $)))))
          (COND ((|domainEqual| |#2| (|Fraction| (|Integer|))))
                ((|testBitVector| |pv$| 1)
                 (PROGN
                  (QSETREFV $ 22
                            (CONS (|dispatchFunction| |FRETRCT-;coerce;FA;4|)
                                  $))
                  (QSETREFV $ 24
                            (CONS (|dispatchFunction| |FRETRCT-;retract;AF;5|)
                                  $))
                  (QSETREFV $ 27
                            (CONS
                             (|dispatchFunction| |FRETRCT-;retractIfCan;AU;6|)
                             $)))))
          $))) 

(MAKEPROP '|FullyRetractableTo&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Integer|)
              (0 . |coerce|) (5 . |coerce|) (10 . |coerce|) (15 . |retract|)
              (20 . |retract|) (25 . |retract|) (|Union| 7 '#1="failed")
              (30 . |retractIfCan|) (|Union| 8 '#1#) (35 . |retractIfCan|)
              (40 . |retractIfCan|) (|Fraction| 8) (45 . |coerce|)
              (50 . |coerce|) (55 . |retract|) (60 . |retract|)
              (|Union| 20 '#1#) (65 . |retractIfCan|) (70 . |retractIfCan|))
           '#(|retractIfCan| 75 |retract| 85 |coerce| 95) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| (|#1| (|Integer|))) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #1#) |#1|))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #1#)
                                       |#1|))
                                     T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|retractIfCan| ((|Union| |#2| #1#) |#1|))
                                     T)
                                   '((|coerce| (|#1| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 27
                                            '(1 7 0 8 9 1 6 0 7 10 1 0 0 8 11 1
                                              6 7 0 12 1 7 8 0 13 1 0 8 0 14 1
                                              6 15 0 16 1 7 17 0 18 1 0 17 0 19
                                              1 7 0 20 21 1 0 0 20 22 1 7 20 0
                                              23 1 0 20 0 24 1 7 25 0 26 1 0 25
                                              0 27 1 0 17 0 19 1 0 25 0 27 1 0
                                              8 0 14 1 0 20 0 24 1 0 0 8 11 1 0
                                              0 20 22)))))
           '|lookupComplete|)) 
