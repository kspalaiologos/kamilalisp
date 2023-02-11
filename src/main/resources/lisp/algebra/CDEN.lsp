
(SDEFUN |CDEN;clearDenominator;2A;1| ((|l| (A)) ($ (A)))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 9)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|CDEN;clearDenominator;2A;1!0| (VECTOR $ |d|))
                      |l| (QREFELT $ 14)))))) 

(SDEFUN |CDEN;clearDenominator;2A;1!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |d| |x| (QREFELT $ 10)) (QREFELT $ 11))
             (QREFELT $ 12)))))) 

(SDEFUN |CDEN;splitDenominator;AR;2|
        ((|l| (A)) ($ (|Record| (|:| |num| A) (|:| |den| R))))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 9)))
                    (EXIT
                     (CONS
                      (SPADCALL
                       (CONS #'|CDEN;splitDenominator;AR;2!0| (VECTOR $ |d|))
                       |l| (QREFELT $ 14))
                      |d|))))) 

(SDEFUN |CDEN;splitDenominator;AR;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |d| |x| (QREFELT $ 10)) (QREFELT $ 11))
             (QREFELT $ 12)))))) 

(SDEFUN |CDEN;qlcm| ((|a| (Q)) (|b| (Q)) ($ (Q)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| (QREFELT $ 11)) (SPADCALL |b| (QREFELT $ 11))
                   (QREFELT $ 18))
         (QREFELT $ 12))) 

(SDEFUN |CDEN;commonDenominator;AR;4| ((|l| (A)) ($ (R)))
        (SPADCALL
         (SPADCALL (CONS (|function| |CDEN;qlcm|) $)
                   (SPADCALL (CONS #'|CDEN;commonDenominator;AR;4!0| $) |l|
                             (QREFELT $ 14))
                   (|spadConstant| $ 20) (QREFELT $ 22))
         (QREFELT $ 11))) 

(SDEFUN |CDEN;commonDenominator;AR;4!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 12))) 

(SDEFUN |CDEN;commonDenominator;AR;5| ((|l| (A)) ($ (R)))
        (SPADCALL
         (SPADCALL (ELT $ 23)
                   (SPADCALL (CONS #'|CDEN;commonDenominator;AR;5!0| $) |l|
                             (QREFELT $ 14))
                   (|spadConstant| $ 20) (QREFELT $ 22))
         (QREFELT $ 11))) 

(SDEFUN |CDEN;commonDenominator;AR;5!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |CommonDenominator;|)) 

(DEFUN |CommonDenominator| (&REST #1=#:G706)
  (SPROG NIL
         (PROG (#2=#:G707)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|CommonDenominator|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |CommonDenominator;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|CommonDenominator|)))))))))) 

(DEFUN |CommonDenominator;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|CommonDenominator| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CommonDenominator|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|GcdDomain|))
            (PROGN
             (QSETREFV $ 9
                       (CONS (|dispatchFunction| |CDEN;commonDenominator;AR;4|)
                             $))))
           ('T
            (QSETREFV $ 9
                      (CONS (|dispatchFunction| |CDEN;commonDenominator;AR;5|)
                            $))))
          $))) 

(MAKEPROP '|CommonDenominator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |commonDenominator|) (5 . *) (11 . |numer|)
              (16 . |coerce|) (|Mapping| 7 7) (21 . |map|)
              |CDEN;clearDenominator;2A;1|
              (|Record| (|:| |num| 8) (|:| |den| 6))
              |CDEN;splitDenominator;AR;2| (27 . |lcm|) (33 . |denom|)
              (38 . |One|) (|Mapping| 7 7 7) (42 . |reduce|) (49 . *))
           '#(|splitDenominator| 55 |commonDenominator| 60 |clearDenominator|
              65)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|commonDenominator| (|#1| |#3|)) T)
                                   '((|clearDenominator| (|#3| |#3|)) T)
                                   '((|splitDenominator|
                                      ((|Record| (|:| |num| |#3|)
                                                 (|:| |den| |#1|))
                                       |#3|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(1 0 6 8 9 2 7 0 6 0 10 1 7 6 0 11
                                              1 7 0 6 12 2 8 0 13 0 14 2 6 0 0
                                              0 18 1 7 6 0 19 0 7 0 20 3 8 7 21
                                              0 7 22 2 7 0 0 0 23 1 0 16 8 17 1
                                              0 6 8 9 1 0 8 8 15)))))
           '|lookupComplete|)) 
