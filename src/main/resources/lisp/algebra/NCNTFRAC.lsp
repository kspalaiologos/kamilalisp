
(SDEFUN |NCNTFRAC;cfc| ((|a| (F)) ($ (|Stream| (|Integer|))))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|NCNTFRAC;cfc!0| (VECTOR $ |a|))
                          (QREFELT $ 18))))) 

(SDEFUN |NCNTFRAC;cfc!0| (($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|aa| NIL) (|b| NIL))
                   (SEQ (LETT |aa| (SPADCALL |a| (QREFELT $ 8)))
                        (EXIT
                         (COND
                          ((SPADCALL
                            (LETT |b|
                                  (SPADCALL |a| (SPADCALL |aa| (QREFELT $ 9))
                                            (QREFELT $ 10)))
                            (QREFELT $ 12))
                           (SPADCALL |aa| (SPADCALL (QREFELT $ 14))
                                     (QREFELT $ 15)))
                          ('T
                           (SPADCALL |aa|
                                     (|NCNTFRAC;cfc|
                                      (SPADCALL |b| (QREFELT $ 16)) $)
                                     (QREFELT $ 15))))))))))) 

(SDEFUN |NCNTFRAC;continuedFraction;FCf;2|
        ((|a| (F)) ($ (|ContinuedFraction| (|Integer|))))
        (SPROG ((|b| (F)) (|aa| (|Integer|)))
               (SEQ (LETT |aa| (SPADCALL |a| (QREFELT $ 8)))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (LETT |b|
                              (SPADCALL |a| (SPADCALL |aa| (QREFELT $ 9))
                                        (QREFELT $ 10)))
                        (QREFELT $ 12))
                       (SPADCALL |aa| (SPADCALL (QREFELT $ 14))
                                 (QREFELT $ 20)))
                      ('T
                       (SEQ
                        (COND
                         ((SPADCALL |b| (QREFELT $ 21))
                          (SEQ (LETT |aa| (- |aa| 1))
                               (EXIT
                                (LETT |b|
                                      (SPADCALL |b| (|spadConstant| $ 22)
                                                (QREFELT $ 24)))))))
                        (EXIT
                         (SPADCALL |aa|
                                   (|NCNTFRAC;cfc|
                                    (SPADCALL |b| (QREFELT $ 16)) $)
                                   (QREFELT $ 20)))))))))) 

(DECLAIM (NOTINLINE |NumericContinuedFraction;|)) 

(DEFUN |NumericContinuedFraction| (#1=#:G705)
  (SPROG NIL
         (PROG (#2=#:G706)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|NumericContinuedFraction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|NumericContinuedFraction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|NumericContinuedFraction|)))))))))) 

(DEFUN |NumericContinuedFraction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|NumericContinuedFraction| DV$1))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NumericContinuedFraction|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NumericContinuedFraction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              (0 . |wholePart|) (5 . |coerce|) (10 . -) (|Boolean|)
              (16 . |zero?|) (|Stream| 7) (21 . |empty|) (25 . |concat|)
              (31 . |inv|) (|Mapping| $) (36 . |delay|) (|ContinuedFraction| 7)
              (41 . |reducedContinuedFraction|) (47 . |negative?|) (52 . |One|)
              (56 . |One|) (60 . +) |NCNTFRAC;continuedFraction;FCf;2|)
           '#(|continuedFraction| 66) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|continuedFraction|
                                 ((|ContinuedFraction| (|Integer|)) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(1 6 7 0 8 1 6 0 7 9 2 6 0 0 0 10
                                              1 6 11 0 12 0 13 0 14 2 13 0 7 0
                                              15 1 6 0 0 16 1 13 0 17 18 2 19 0
                                              7 13 20 1 6 11 0 21 0 6 0 22 0 19
                                              0 23 2 6 0 0 0 24 1 0 19 6
                                              25)))))
           '|lookupComplete|)) 
