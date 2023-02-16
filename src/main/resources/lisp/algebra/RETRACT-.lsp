
(SDEFUN |RETRACT-;retract;AS;1| ((|s| (A)) ($ (S)))
        (SPROG ((|u| (|Union| S "failed")))
               (SEQ (LETT |u| (SPADCALL |s| (QREFELT $ 9)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (|error| "not retractable"))
                           ('T (QCDR |u|))))))) 

(DECLAIM (NOTINLINE |RetractableTo&;|)) 

(DEFUN |RetractableTo&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RetractableTo&| DV$1 DV$2))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RetractableTo&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| 7 '"failed") (0 . |retractIfCan|)
              |RETRACT-;retract;AS;1|)
           '#(|retract| 5) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory| (LIST '((|retract| (|#2| |#1|)) T))
                                          (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10 '(1 6 8 0 9 1 0 7 0 10)))))
           '|lookupComplete|)) 
