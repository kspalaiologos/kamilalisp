
(SDEFUN |DELTCF;circle;Dc;1| (($ (|DeltaComplex| VS)))
        (SPROG ((|vs1| (|List| VS)))
               (SEQ (LETT |vs1| NIL)
                    (EXIT
                     (SPADCALL |vs1| 1 (LIST (LIST (LIST 1 -1)))
                               (QREFELT $ 11)))))) 

(SDEFUN |DELTCF;dunceHat;Dc;2| (($ (|DeltaComplex| VS)))
        (SPROG ((|vs1| (|List| VS)))
               (SEQ (LETT |vs1| NIL)
                    (EXIT
                     (SPADCALL |vs1| 1
                               (LIST (LIST (LIST 1 1 -1)) (LIST (LIST 1 -1)))
                               (QREFELT $ 11)))))) 

(SDEFUN |DELTCF;torusSurface;Dc;3| (($ (|DeltaComplex| VS)))
        (SPROG ((|vs1| (|List| VS)))
               (SEQ (LETT |vs1| NIL)
                    (EXIT
                     (SPADCALL |vs1| 1
                               (LIST (LIST (LIST 1 2 -1 -2))
                                     (LIST (LIST 1 -1) (LIST 1 -1)))
                               (QREFELT $ 11)))))) 

(SDEFUN |DELTCF;projectiveSpace;IDc;4|
        ((|n| (|Integer|)) ($ (|DeltaComplex| VS)))
        (SPROG
         ((|cl| (|List| (|List| (|List| (|Integer|))))) (#1=#:G712 NIL)
          (|i| NIL) (|vs1| (|List| VS)))
         (SEQ (LETT |vs1| NIL) (LETT |cl| NIL)
              (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |cl|
                           (CONS (LIST (LIST 1 (COND ((ODDP |i|) -1) ('T 1))))
                                 |cl|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |vs1| 1 |cl| (QREFELT $ 11)))))) 

(SDEFUN |DELTCF;kleinBottle;Dc;5| (($ (|DeltaComplex| VS)))
        (SPROG ((|vs1| (|List| VS)))
               (SEQ (LETT |vs1| NIL)
                    (EXIT
                     (SPADCALL |vs1| 1
                               (LIST (LIST (LIST 1 2 1 -2))
                                     (LIST (LIST 1 -1) (LIST 1 -1)))
                               (QREFELT $ 11)))))) 

(DECLAIM (NOTINLINE |DeltaComplexFactory;|)) 

(DEFUN |DeltaComplexFactory| (#1=#:G715)
  (SPROG NIL
         (PROG (#2=#:G716)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DeltaComplexFactory|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|DeltaComplexFactory;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DeltaComplexFactory|)))))))))) 

(DEFUN |DeltaComplexFactory;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DeltaComplexFactory| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DeltaComplexFactory| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DeltaComplexFactory| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|List| 6)
              (|NonNegativeInteger|) (|List| (|List| (|List| 15)))
              (|DeltaComplex| 6) (0 . |deltaComplex|) |DELTCF;circle;Dc;1|
              |DELTCF;dunceHat;Dc;2| |DELTCF;torusSurface;Dc;3| (|Integer|)
              |DELTCF;projectiveSpace;IDc;4| |DELTCF;kleinBottle;Dc;5|)
           '#(|torusSurface| 7 |projectiveSpace| 11 |kleinBottle| 16 |dunceHat|
              20 |circle| 24)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|circle| ((|DeltaComplex| |#1|))) T)
                                   '((|dunceHat| ((|DeltaComplex| |#1|))) T)
                                   '((|torusSurface| ((|DeltaComplex| |#1|)))
                                     T)
                                   '((|projectiveSpace|
                                      ((|DeltaComplex| |#1|) (|Integer|)))
                                     T)
                                   '((|kleinBottle| ((|DeltaComplex| |#1|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(3 10 0 7 8 9 11 0 0 10 14 1 0 10
                                              15 16 0 0 10 17 0 0 10 13 0 0 10
                                              12)))))
           '|lookupComplete|)) 
