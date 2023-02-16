
(SDEFUN |RF;coerce;RF;1| ((|r| (R)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (SPADCALL |r| (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |RF;variables;FL;2|
        ((|f| (|Fraction| (|Polynomial| R))) ($ (|List| (|Symbol|))))
        (SPADCALL |f| (QREFELT $ 14))) 

(SDEFUN |RF;mainVariable;FU;3|
        ((|f| (|Fraction| (|Polynomial| R))) ($ (|Union| (|Symbol|) "failed")))
        (SPADCALL |f| (QREFELT $ 17))) 

(SDEFUN |RF;univariate;FSF;4|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         ($
          (|Fraction|
           (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
        (SPADCALL |f| |x| (QREFELT $ 21))) 

(SDEFUN |RF;multivariate;FSF;5|
        ((|f|
          (|Fraction|
           (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
         (|x| (|Symbol|)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL |f| |x| (QREFELT $ 23))) 

(SDEFUN |RF;eval;FS2F;6|
        ((|x| (|Fraction| (|Polynomial| R))) (|s| (|Symbol|))
         (|y| (|Fraction| (|Polynomial| R))) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL |x| (LIST |s|) (LIST |y|) (QREFELT $ 26))) 

(SDEFUN |RF;eval;FEF;7|
        ((|x| (|Fraction| (|Polynomial| R)))
         (|eq| (|Equation| (|Fraction| (|Polynomial| R))))
         ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL |x| (LIST |eq|) (QREFELT $ 29))) 

(SDEFUN |RF;foo|
        ((|ls| (|List| (|Symbol|)))
         (|lv| (|List| (|Fraction| (|Polynomial| R)))) (|x| (|Symbol|))
         ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL |ls| |lv| |x| (SPADCALL |x| (QREFELT $ 32)) (QREFELT $ 34))) 

(SDEFUN |RF;eval;FLF;9|
        ((|x| (|Fraction| (|Polynomial| R)))
         (|l| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
         ($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((#1=#:G719 NIL) (|eq| NIL) (#2=#:G718 NIL) (#3=#:G717 NIL)
          (#4=#:G716 NIL))
         (SEQ
          (SPADCALL |x|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |eq| NIL) (LETT #3# |l|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |eq| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL (SPADCALL |eq| (QREFELT $ 35))
                                             (QREFELT $ 36))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |eq| NIL) (LETT #1# |l|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |eq| (QREFELT $ 37)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 26))))) 

(SDEFUN |RF;eval;FLLF;10|
        ((|x| (|Fraction| (|Polynomial| R))) (|ls| (|List| (|Symbol|)))
         (|lv| (|List| (|Fraction| (|Polynomial| R))))
         ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (|RF;peval| (SPADCALL |x| (QREFELT $ 38)) |ls| |lv| $)
                  (|RF;peval| (SPADCALL |x| (QREFELT $ 39)) |ls| |lv| $)
                  (QREFELT $ 40))) 

(SDEFUN |RF;peval|
        ((|p| (|Polynomial| R)) (|ls| (|List| (|Symbol|)))
         (|lv| (|List| (|Fraction| (|Polynomial| R))))
         ($ (|Fraction| (|Polynomial| R))))
        (SPROG NIL
               (SPADCALL (CONS #'|RF;peval!0| (VECTOR $ |lv| |ls|)) (ELT $ 11)
                         |p| (QREFELT $ 44)))) 

(SDEFUN |RF;peval!0| ((|z1| NIL) ($$ NIL))
        (PROG (|ls| |lv| $)
          (LETT |ls| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|RF;foo| |ls| |lv| |z1| $))))) 

(DECLAIM (NOTINLINE |RationalFunction;|)) 

(DEFUN |RationalFunction| (#1=#:G723)
  (SPROG NIL
         (PROG (#2=#:G724)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RationalFunction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalFunction|)))))))))) 

(DEFUN |RationalFunction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFunction| DV$1))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFunction| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Polynomial| 6)
              (0 . |coerce|) (|Fraction| 7) (5 . |coerce|) |RF;coerce;RF;1|
              (|List| 20)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 20) 20
                                                     6 7 9)
              (10 . |variables|) |RF;variables;FL;2| (|Union| 20 '"failed")
              (15 . |mainVariable|) |RF;mainVariable;FU;3|
              (|Fraction| (|SparseUnivariatePolynomial| 9)) (|Symbol|)
              (20 . |univariate|) |RF;univariate;FSF;4| (26 . |multivariate|)
              |RF;multivariate;FSF;5| (|List| 9) |RF;eval;FLLF;10|
              |RF;eval;FS2F;6| (|List| 30) |RF;eval;FLF;9| (|Equation| 9)
              |RF;eval;FEF;7| (32 . |coerce|) (|ListToMap| 20 9) (37 . |match|)
              (45 . |lhs|) (50 . |retract|) (55 . |rhs|) (60 . |numer|)
              (65 . |denom|) (70 . /) (|Mapping| 9 20) (|Mapping| 9 6)
              (|PolynomialCategoryLifting| (|IndexedExponents| 20) 20 6 7 9)
              (76 . |map|))
           '#(|variables| 83 |univariate| 88 |multivariate| 94 |mainVariable|
              100 |eval| 105 |coerce| 131)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|variables|
                                 ((|List| (|Symbol|))
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((|mainVariable|
                                 ((|Union| (|Symbol|) "failed")
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((|univariate|
                                 ((|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|multivariate|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|Symbol|)))
                                T)
                              '((|eval|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((|eval|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|List| (|Symbol|))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|eval|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|Equation|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|eval|
                                 ((|Fraction| (|Polynomial| |#1|))
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))))
                                T)
                              '((|coerce|
                                 ((|Fraction| (|Polynomial| |#1|)) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(1 7 0 6 8 1 9 0 7 10 1 13 12 9 14
                                              1 13 16 9 17 2 13 19 9 20 21 2 13
                                              9 19 20 23 1 9 0 20 32 4 33 9 12
                                              25 20 9 34 1 30 9 0 35 1 9 20 0
                                              36 1 30 9 0 37 1 9 7 0 38 1 9 7 0
                                              39 2 9 0 0 0 40 3 43 9 41 42 7 44
                                              1 0 12 9 15 2 0 19 9 20 22 2 0 9
                                              19 20 24 1 0 16 9 18 3 0 9 9 12
                                              25 26 3 0 9 9 20 9 27 2 0 9 9 30
                                              31 2 0 9 9 28 29 1 0 9 6 11)))))
           '|lookupComplete|)) 
