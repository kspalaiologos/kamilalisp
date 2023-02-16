
(SDEFUN |GUESSP1;m1| ((|var| (|Symbol|)) ($ (|Expression| (|Integer|))))
        (SPADCALL |var| (QREFELT $ 9))) 

(SDEFUN |GUESSP1;m3|
        ((|var| (|Kernel| (|Expression| (|Integer|))))
         ($ (|Expression| (|Integer|))))
        (SPADCALL |var| (QREFELT $ 11))) 

(SDEFUN |GUESSP1;iim2;RE;3| ((|coeff| (R)) ($ (|Expression| (|Integer|))))
        (SPADCALL |coeff| (QREFELT $ 12))) 

(SDEFUN |GUESSP1;iiretractVar;KP;4|
        ((|v| (|Kernel| (|Expression| (|Integer|)))) ($ (|Polynomial| R)))
        (SPROG ((|r| (|Union| R "failed")) (|v2| (|Expression| (|Integer|))))
               (SEQ (LETT |v2| (|GUESSP1;m3| |v| $))
                    (LETT |r| (SPADCALL |v2| (QREFELT $ 15)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 1)
                       (SPADCALL (SPADCALL |v2| (QREFELT $ 16))
                                 (QREFELT $ 18)))
                      ('T (SPADCALL (QCDR |r|) (QREFELT $ 19)))))))) 

(SDEFUN |GUESSP1;iim2;RE;5| ((|coeff| (R)) ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL |coeff| (QREFELT $ 23)) (QREFELT $ 24))) 

(SDEFUN |GUESSP1;iiretractVar;KP;6|
        ((|v| (|Kernel| (|Expression| (|Integer|)))) ($ (|Polynomial| R)))
        (SPROG
         ((|r| (|Union| (|Integer|) "failed"))
          (|v2| (|Expression| (|Integer|))))
         (SEQ (LETT |v2| (|GUESSP1;m3| |v| $))
              (LETT |r| (SPADCALL |v2| (QREFELT $ 26)))
              (EXIT
               (COND
                ((QEQCAR |r| 1)
                 (SPADCALL (SPADCALL |v2| (QREFELT $ 16)) (QREFELT $ 18)))
                ('T
                 (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 27))
                           (QREFELT $ 19)))))))) 

(SDEFUN |GUESSP1;S2EXPRR|
        ((|p| (|Polynomial| R)) ($ (|Expression| (|Integer|))))
        (SPADCALL (CONS #'|GUESSP1;S2EXPRR!0| $) (ELT $ 13) |p| (QREFELT $ 31))) 

(SDEFUN |GUESSP1;S2EXPRR!0| ((|var| NIL) ($ NIL)) (|GUESSP1;m1| |var| $)) 

(SDEFUN |GUESSP1;F2EXPRR;FE;8|
        ((|p| (|Fraction| (|Polynomial| R))) ($ (|Expression| (|Integer|))))
        (SPADCALL (|GUESSP1;S2EXPRR| (SPADCALL |p| (QREFELT $ 33)) $)
                  (|GUESSP1;S2EXPRR| (SPADCALL |p| (QREFELT $ 34)) $)
                  (QREFELT $ 35))) 

(SDEFUN |GUESSP1;SMP2S|
        ((|p|
          (|SparseMultivariatePolynomial| (|Integer|)
                                          (|Kernel|
                                           (|Expression| (|Integer|)))))
         ($ (|Polynomial| R)))
        (SPADCALL (ELT $ 21) (CONS #'|GUESSP1;SMP2S!0| $) |p| (QREFELT $ 41))) 

(SDEFUN |GUESSP1;SMP2S!0| ((|coeff| NIL) ($ NIL))
        (SPADCALL (SPADCALL |coeff| (QREFELT $ 27)) (QREFELT $ 19))) 

(SDEFUN |GUESSP1;EXPRR2F;EF;10|
        ((|p| (|Expression| (|Integer|))) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (|GUESSP1;SMP2S| (SPADCALL |p| (QREFELT $ 43)) $)
                  (|GUESSP1;SMP2S| (SPADCALL |p| (QREFELT $ 44)) $)
                  (QREFELT $ 45))) 

(DECLAIM (NOTINLINE |GuessPolynomialFunctions;|)) 

(DEFUN |GuessPolynomialFunctions| (#1=#:G723)
  (SPROG NIL
         (PROG (#2=#:G724)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GuessPolynomialFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|GuessPolynomialFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GuessPolynomialFunctions|)))))))))) 

(DEFUN |GuessPolynomialFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GuessPolynomialFunctions| DV$1))
          (LETT $ (GETREFV 47))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GuessPolynomialFunctions|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| (|Expression| (|Integer|))
                           (LIST '|RetractableTo| (|devaluate| |#1|)))
            (PROGN
             (QSETREFV $ 13 (CONS (|dispatchFunction| |GUESSP1;iim2;RE;3|) $))
             (QSETREFV $ 21
                       (CONS (|dispatchFunction| |GUESSP1;iiretractVar;KP;4|)
                             $))))
           ((|HasCategory| |#1| '(|ConvertibleTo| (|Integer|)))
            (PROGN
             (QSETREFV $ 13 (CONS (|dispatchFunction| |GUESSP1;iim2;RE;5|) $))
             (QSETREFV $ 21
                       (CONS (|dispatchFunction| |GUESSP1;iiretractVar;KP;6|)
                             $))))
           ('T
            (|error|
             "retraction and coercion to EXPR INT is not implemented for this Ring")))
          $))) 

(MAKEPROP '|GuessPolynomialFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|)
              (|Expression| 22) (0 . |coerce|) (|Kernel| $) (5 . |coerce|)
              (10 . |coerce|) (15 . |iim2|) (|Union| 6 '"failed")
              (20 . |retractIfCan|) (25 . |retract|) (|Polynomial| 6)
              (30 . |coerce|) (35 . |coerce|) (|Kernel| 8)
              (40 . |iiretractVar|) (|Integer|) (45 . |convert|)
              (50 . |coerce|) (|Union| 22 '"failed") (55 . |retractIfCan|)
              (60 . |coerce|) (|Mapping| 8 7) (|Mapping| 8 6)
              (|PolynomialCategoryLifting| (|IndexedExponents| 7) 7 6 17 8)
              (65 . |map|) (|Fraction| 17) (72 . |numer|) (77 . |denom|)
              (82 . /) |GUESSP1;F2EXPRR;FE;8| (|Mapping| 17 20)
              (|Mapping| 17 22) (|SparseMultivariatePolynomial| 22 20)
              (|PolynomialCategoryLifting| (|IndexedExponents| 20) 20 22 39 17)
              (88 . |map|) (|SparseMultivariatePolynomial| 22 10)
              (95 . |numer|) (100 . |denom|) (105 . /) |GUESSP1;EXPRR2F;EF;10|)
           '#(|iiretractVar| 111 |iim2| 116 F2EXPRR 121 EXPRR2F 126) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((F2EXPRR
                                 ((|Expression| (|Integer|))
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((EXPRR2F
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Expression| (|Integer|))))
                                T)
                              '((|iim2| ((|Expression| (|Integer|)) |#1|)) T)
                              '((|iiretractVar|
                                 ((|Polynomial| |#1|)
                                  (|Kernel| (|Expression| (|Integer|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(1 8 0 7 9 1 8 0 10 11 1 8 0 6 12
                                              1 0 8 6 13 1 8 14 0 15 1 8 7 0 16
                                              1 17 0 7 18 1 17 0 6 19 1 0 17 20
                                              21 1 6 22 0 23 1 8 0 22 24 1 8 25
                                              0 26 1 6 0 22 27 3 30 8 28 29 17
                                              31 1 32 17 0 33 1 32 17 0 34 2 8
                                              0 0 0 35 3 40 17 37 38 39 41 1 8
                                              42 0 43 1 8 42 0 44 2 32 0 17 17
                                              45 1 0 17 20 21 1 0 8 6 13 1 0 8
                                              32 36 1 0 32 8 46)))))
           '|lookupComplete|)) 
