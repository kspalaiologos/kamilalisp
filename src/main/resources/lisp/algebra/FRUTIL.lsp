
(SDEFUN |FRUTIL;refine;FMF;1|
        ((|f| (|Factored| R)) (|func| (|Mapping| #1=(|Factored| R) R))
         ($ (|Factored| R)))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#2=#:G734 NIL) (|v| NIL) (#3=#:G733 NIL) (|u| (R)) (|fitem| #1#)
          (#4=#:G732 NIL) (|item| NIL))
         (SEQ (LETT |u| (SPADCALL |f| (QREFELT $ 8))) (LETT |l| NIL)
              (SEQ (LETT |item| NIL) (LETT #4# (SPADCALL |f| (QREFELT $ 12)))
                   G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |item| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |fitem| (SPADCALL (QVELT |item| 1) |func|))
                        (LETT |u|
                              (SPADCALL |u|
                                        (SPADCALL
                                         (SPADCALL |fitem| (QREFELT $ 8))
                                         (QVELT |item| 2) (QREFELT $ 14))
                                        (QREFELT $ 15)))
                        (EXIT
                         (COND
                          ((EQL (QVELT |item| 2) 1)
                           (LETT |l|
                                 (SPADCALL (SPADCALL |fitem| (QREFELT $ 12))
                                           |l| (QREFELT $ 16))))
                          ('T
                           (LETT |l|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT |v| NIL)
                                        (LETT #2#
                                              (SPADCALL |fitem|
                                                        (QREFELT $ 12)))
                                        G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT |v| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #3#
                                                (CONS
                                                 (VECTOR (QVELT |v| 0)
                                                         (QVELT |v| 1)
                                                         (* (QVELT |v| 2)
                                                            (QVELT |item| 2)))
                                                 #3#))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT (NREVERSE #3#))))
                                  |l| (QREFELT $ 17)))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |u| |l| (QREFELT $ 18)))))) 

(DECLAIM (NOTINLINE |FactoredFunctionUtilities;|)) 

(DEFUN |FactoredFunctionUtilities| (#1=#:G735)
  (SPROG NIL
         (PROG (#2=#:G736)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FactoredFunctionUtilities|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|FactoredFunctionUtilities;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FactoredFunctionUtilities|)))))))))) 

(DEFUN |FactoredFunctionUtilities;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FactoredFunctionUtilities| DV$1))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FactoredFunctionUtilities|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FactoredFunctionUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Factored| 6)
              (0 . |unit|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 9) (|:| |factor| 6) (|:| |exponent| 13))
              (|List| 10) (5 . |factorList|) (|NonNegativeInteger|) (10 . ^)
              (16 . *) (22 . |concat|) (28 . |concat!|) (34 . |makeFR|)
              (|Mapping| 7 6) |FRUTIL;refine;FMF;1|)
           '#(|refine| 40) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|refine|
                                 ((|Factored| |#1|) (|Factored| |#1|)
                                  (|Mapping| (|Factored| |#1|) |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(1 7 6 0 8 1 7 11 0 12 2 6 0 0 13
                                              14 2 6 0 0 0 15 2 11 0 0 0 16 2
                                              11 0 0 0 17 2 7 0 6 11 18 2 0 7 7
                                              19 20)))))
           '|lookupComplete|)) 
