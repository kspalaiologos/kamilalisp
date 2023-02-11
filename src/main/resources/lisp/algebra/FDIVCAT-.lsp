
(SDEFUN |FDIVCAT-;principal?;SB;1| ((|d| (S)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |d| (QREFELT $ 12)) 0)) 

(SDEFUN |FDIVCAT-;divisor;R3UPFS;2|
        ((|h| (R)) (|d| (UP)) (|dp| (UP)) (|g| (UP)) (|r| (F)) ($ (S)))
        (SPADCALL
         (SPADCALL |h|
                   (SPADCALL
                    (SPADCALL (SPADCALL |r| |dp| (QREFELT $ 15))
                              (QREFELT $ 17))
                    (QREFELT $ 18))
                   (QREFELT $ 19))
         |d| |g| (QREFELT $ 20))) 

(DECLAIM (NOTINLINE |FiniteDivisorCategory&;|)) 

(DEFUN |FiniteDivisorCategory&| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|FiniteDivisorCategory&| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 24))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|FiniteDivisorCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Union| 10 '"failed") (0 . |generator|) (|Boolean|)
              |FDIVCAT-;principal?;SB;1| (5 . *) (|Fraction| 8) (11 . |coerce|)
              (16 . |coerce|) (21 . -) (27 . |divisor|)
              |FDIVCAT-;divisor;R3UPFS;2| (|Integer|)
              (|FractionalIdeal| 8 16 9 10))
           '#(|principal?| 34 |divisor| 39) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|divisor| (|#1| |#5| |#3| |#3| |#3| |#2|)) T)
                              '((|divisor| (|#1| |#5| |#3| |#3|)) T)
                              '((|principal?| ((|Boolean|) |#1|)) T)
                              '((|divisor| (|#1| |#2| |#2| (|Integer|))) T)
                              '((|divisor| (|#1| |#2| |#2|)) T)
                              '((|divisor| (|#1| |#5|)) T)
                              '((|divisor|
                                 (|#1|
                                  (|FractionalIdeal| |#3| (|Fraction| |#3|)
                                                     |#4| |#5|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(1 6 11 0 12 2 8 0 7 0 15 1 16 0 8
                                              17 1 10 0 16 18 2 10 0 0 0 19 3 6
                                              0 10 8 8 20 1 0 13 0 14 5 0 0 10
                                              8 8 8 7 21)))))
           '|lookupComplete|)) 
