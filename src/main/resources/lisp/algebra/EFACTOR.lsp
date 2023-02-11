
(SDEFUN |EFACTOR;poly_factor;SupF;1|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| F))))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))))
        (SPADCALL |p| (QREFELT $ 11))) 

(SDEFUN |EFACTOR;poly_factor;SupF;2|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| F))))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))))
        (SPADCALL |p| (QREFELT $ 11))) 

(SDEFUN |EFACTOR;poly_factor;SupF;3|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| F))))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))))
        (SPADCALL |p| (QREFELT $ 16))) 

(PUT '|EFACTOR;poly_factor;SupF;4| '|SPADreplace|
     '(XLAM (|p|) (|error| "factorPolynomial unimplemented"))) 

(SDEFUN |EFACTOR;poly_factor;SupF;4|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| F))))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))))
        (|error| "factorPolynomial unimplemented")) 

(SDEFUN |EFACTOR;fpoly_factor|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|Factored| (|SparseUnivariatePolynomial| F))))
        (SPROG
         ((|res| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|fr2| (|SparseUnivariatePolynomial| F))
          (|fru| (|SparseUnivariatePolynomial| F))
          (|fr1|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (#1=#:G748 NIL) (|frec| NIL)
          (|fres1|
           (|Factored|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| R (|Kernel| F)))))
          (|p2|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|pf| (F)) (|cnp| (|SparseUnivariatePolynomial| F)) (|cn| (F)))
         (SEQ (LETT |cn| (SPADCALL |p| (QREFELT $ 27)))
              (EXIT
               (COND
                ((SPADCALL |cn| (|spadConstant| $ 29) (QREFELT $ 31))
                 (SPADCALL |p| 1 (QREFELT $ 36)))
                ('T
                 (SEQ (LETT |p| (SPADCALL |p| |cn| (QREFELT $ 37)))
                      (LETT |cnp| (SPADCALL |cn| (QREFELT $ 38)))
                      (LETT |pf|
                            (SPADCALL
                             (SPADCALL |p| (QREFELT $ 19)
                                       (SPADCALL (QREFELT $ 25) (QREFELT $ 40))
                                       (QREFELT $ 41))
                             (QREFELT $ 42)))
                      (LETT |p2|
                            (SPADCALL (SPADCALL |pf| (QREFELT $ 44))
                                      (QREFELT $ 25) (QREFELT $ 45)))
                      (LETT |fres1| (SPADCALL |p2| (QREFELT $ 12)))
                      (LETT |res| (SPADCALL |cnp| NIL (QREFELT $ 49)))
                      (SEQ (LETT |frec| NIL)
                           (LETT #1# (SPADCALL |fres1| (QREFELT $ 52))) G190
                           (COND
                            ((OR (ATOM #1#)
                                 (PROGN (LETT |frec| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |fr1| (QVELT |frec| 1))
                                (EXIT
                                 (COND
                                  ((< (SPADCALL |fr1| (QREFELT $ 53)) 1)
                                   "iterate")
                                  ('T
                                   (SEQ
                                    (COND
                                     ((SPADCALL (QVELT |frec| 0)
                                                (CONS 3 "prime")
                                                (QREFELT $ 54))
                                      (COND
                                       ((SPADCALL (QVELT |frec| 0)
                                                  (CONS 2 "irred")
                                                  (QREFELT $ 54))
                                        (EXIT (|error| "impossible"))))))
                                    (LETT |fru|
                                          (SPADCALL (ELT $ 55) |fr1|
                                                    (QREFELT $ 58)))
                                    (LETT |fr2|
                                          (SPADCALL |fru|
                                                    (SPADCALL |fru|
                                                              (QREFELT $ 27))
                                                    (QREFELT $ 37)))
                                    (EXIT
                                     (LETT |res|
                                           (SPADCALL |res|
                                                     (SPADCALL |fr2|
                                                               (QVELT |frec| 2)
                                                               (QREFELT $ 59))
                                                     (QREFELT $ 60)))))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |EFACTOR;ifactor|
        ((|p| (|SparseUnivariatePolynomial| F)) (|lk| (|List| #1=(|Kernel| F)))
         ($ (|Factored| (|SparseUnivariatePolynomial| F))))
        (SPROG
         ((|res| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|fr2| (|SparseUnivariatePolynomial| F))
          (|fru| (|SparseUnivariatePolynomial| F)) (|fr1| (|ups|))
          (#2=#:G782 NIL) (|frec| NIL) (|kf| (F)) (|fres1| (|Factored| |ups|))
          (|p2| (|ups|))
          (|ups|
           (|Join| (|UnivariatePolynomialCategory| |sae|)
                   (CATEGORY |domain|
                    (SIGNATURE |outputForm|
                     ((|OutputForm|) $ (|OutputForm|))))))
          (|sae|
           (|Join| (|MonogenicAlgebra| F (|SparseUnivariatePolynomial| F))
                   (CATEGORY |package|
                    (IF (|has| F (|Field|))
                        (IF (|has| F (|PolynomialFactorizationExplicit|))
                            (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                            |noBranch|)
                        |noBranch|))))
          (|lk2| (|List| #1#)) (#3=#:G781 NIL) (|k| NIL) (#4=#:G780 NIL)
          (|q| (|SparseUnivariatePolynomial| F)) (|k1| (|Kernel| F))
          (|cnp| (|SparseUnivariatePolynomial| F)) (|cn| (F))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |p| (QREFELT $ 61)))
              (LETT |cn| (SPADCALL |p| (QREFELT $ 27)))
              (EXIT
               (COND
                ((SPADCALL |cn| (|spadConstant| $ 29) (QREFELT $ 31))
                 (SPADCALL |p| 1 (QREFELT $ 36)))
                (#5='T
                 (SEQ (LETT |cnp| (SPADCALL |cn| (QREFELT $ 38)))
                      (EXIT
                       (COND ((< |n| 1) (SPADCALL |cnp| NIL (QREFELT $ 49)))
                             ((EQL |n| 1)
                              (SPADCALL |cnp|
                                        (LIST
                                         (VECTOR (CONS 3 "prime")
                                                 (SPADCALL |p| |cn|
                                                           (QREFELT $ 37))
                                                 1))
                                        (QREFELT $ 49)))
                             (#5#
                              (COND
                               ((NULL |lk|) (|EFACTOR;fpoly_factor| |p| $))
                               (#5#
                                (SEQ
                                 (LETT |q|
                                       (SPADCALL
                                        (LETT |k1|
                                              (SPADCALL (ELT $ 62) |lk|
                                                        (QREFELT $ 65)))
                                        (QREFELT $ 66)))
                                 (LETT |lk2|
                                       (PROGN
                                        (LETT #4# NIL)
                                        (SEQ (LETT |k| NIL) (LETT #3# |lk|)
                                             G190
                                             (COND
                                              ((OR (ATOM #3#)
                                                   (PROGN
                                                    (LETT |k| (CAR #3#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((SPADCALL |k| |k1|
                                                           (QREFELT $ 67))
                                                 (LETT #4# (CONS |k| #4#))))))
                                             (LETT #3# (CDR #3#)) (GO G190)
                                             G191 (EXIT (NREVERSE #4#)))))
                                 (LETT |sae|
                                       (|SimpleAlgebraicExtension|
                                        (QREFELT $ 7)
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 7))
                                        |q|))
                                 (LETT |ups|
                                       (|SparseUnivariatePolynomial| |sae|))
                                 (LETT |p2|
                                       (SPADCALL
                                        (CONS #'|EFACTOR;ifactor!0|
                                              (VECTOR |sae| $ |q| |k1|))
                                        |p|
                                        (|compiledLookupCheck| '|map|
                                                               (LIST
                                                                (|devaluate|
                                                                 |ups|)
                                                                (LIST
                                                                 '|Mapping|
                                                                 (|devaluate|
                                                                  |sae|)
                                                                 (|devaluate|
                                                                  (ELT $ 7)))
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  (ELT $ 7))))
                                                               (|UnivariatePolynomialCategoryFunctions2|
                                                                (ELT $ 7)
                                                                (|SparseUnivariatePolynomial|
                                                                 (ELT $ 7))
                                                                |sae| |ups|))))
                                 (LETT |fres1|
                                       (SPADCALL |p2|
                                                 (CONS #'|EFACTOR;ifactor!1|
                                                       (VECTOR $ |lk2|))
                                                 (|compiledLookupCheck|
                                                  '|factor|
                                                  (LIST
                                                   (LIST '|Factored|
                                                         (|devaluate| |ups|))
                                                   (|devaluate| |ups|)
                                                   (LIST '|Mapping|
                                                         (LIST '|Factored|
                                                               (LIST
                                                                '|SparseUnivariatePolynomial|
                                                                (|devaluate|
                                                                 (ELT $ 7))))
                                                         (LIST
                                                          '|SparseUnivariatePolynomial|
                                                          (|devaluate|
                                                           (ELT $ 7)))))
                                                  (|InnerAlgFactor| (ELT $ 7)
                                                                    (|SparseUnivariatePolynomial|
                                                                     (ELT $ 7))
                                                                    |sae|
                                                                    |ups|))))
                                 (LETT |res|
                                       (SPADCALL |cnp| NIL (QREFELT $ 49)))
                                 (LETT |kf| (SPADCALL |k1| (QREFELT $ 40)))
                                 (SEQ (LETT |frec| NIL)
                                      (LETT #2#
                                            (SPADCALL |fres1|
                                                      (|compiledLookupCheck|
                                                       '|factorList|
                                                       (LIST
                                                        (LIST '|List|
                                                              (LIST '|Record|
                                                                    (LIST '|:|
                                                                          '|flag|
                                                                          (LIST
                                                                           '|Union|
                                                                           '"nil"
                                                                           '"sqfr"
                                                                           '"irred"
                                                                           '"prime"))
                                                                    (LIST '|:|
                                                                          '|factor|
                                                                          (|devaluate|
                                                                           |ups|))
                                                                    (LIST '|:|
                                                                          '|exponent|
                                                                          (LIST
                                                                           '|NonNegativeInteger|))))
                                                        '$)
                                                       (|Factored| |ups|))))
                                      G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN
                                             (LETT |frec| (CAR #2#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ (LETT |fr1| (QVELT |frec| 1))
                                           (COND
                                            ((SPADCALL (QVELT |frec| 0)
                                                       (CONS 3 "prime")
                                                       (QREFELT $ 54))
                                             (COND
                                              ((SPADCALL (QVELT |frec| 0)
                                                         (CONS 2 "irred")
                                                         (QREFELT $ 54))
                                               (EXIT
                                                (|error| "impossible"))))))
                                           (LETT |fru|
                                                 (SPADCALL
                                                  (CONS #'|EFACTOR;ifactor!2|
                                                        (VECTOR |kf| |sae| $))
                                                  |fr1|
                                                  (|compiledLookupCheck| '|map|
                                                                         (LIST
                                                                          (LIST
                                                                           '|SparseUnivariatePolynomial|
                                                                           (|devaluate|
                                                                            (ELT
                                                                             $
                                                                             7)))
                                                                          (LIST
                                                                           '|Mapping|
                                                                           (|devaluate|
                                                                            (ELT
                                                                             $
                                                                             7))
                                                                           (|devaluate|
                                                                            |sae|))
                                                                          (|devaluate|
                                                                           |ups|))
                                                                         (|UnivariatePolynomialCategoryFunctions2|
                                                                          |sae|
                                                                          |ups|
                                                                          (ELT
                                                                           $ 7)
                                                                          (|SparseUnivariatePolynomial|
                                                                           (ELT
                                                                            $
                                                                            7))))))
                                           (LETT |fr2|
                                                 (SPADCALL |fru|
                                                           (SPADCALL |fru|
                                                                     (QREFELT $
                                                                              27))
                                                           (QREFELT $ 37)))
                                           (EXIT
                                            (LETT |res|
                                                  (SPADCALL |res|
                                                            (SPADCALL |fr2|
                                                                      (QVELT
                                                                       |frec|
                                                                       2)
                                                                      (QREFELT
                                                                       $ 59))
                                                            (QREFELT $ 60)))))
                                      (LETT #2# (CDR #2#)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT |res|)))))))))))))) 

(SDEFUN |EFACTOR;ifactor!2| ((|c1| NIL) ($$ NIL))
        (PROG ($ |sae| |kf|)
          (LETT $ (QREFELT $$ 2))
          (LETT |sae| (QREFELT $$ 1))
          (LETT |kf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |c1|
                       (|compiledLookupCheck| '|lift|
                                              (LIST
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (|devaluate| (ELT $ 7)))
                                               '$)
                                              |sae|))
             |kf| (QREFELT $ 70)))))) 

(SDEFUN |EFACTOR;ifactor!1| ((|x| NIL) ($$ NIL))
        (PROG (|lk2| $)
          (LETT |lk2| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|EFACTOR;ifactor| |x| |lk2| $))))) 

(SDEFUN |EFACTOR;ifactor!0| ((|x| NIL) ($$ NIL))
        (PROG (|k1| |q| $ |sae|)
          (LETT |k1| (QREFELT $$ 3))
          (LETT |q| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |sae| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |k1| |q| (QREFELT $ 69))
                      (|compiledLookupCheck| '|reduce|
                                             (LIST '$
                                                   (LIST
                                                    '|SparseUnivariatePolynomial|
                                                    (|devaluate| (ELT $ 7))))
                                             |sae|)))))) 

(SDEFUN |EFACTOR;factorPolynomial;SupF;7|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|Factored| (|SparseUnivariatePolynomial| F))))
        (|EFACTOR;ifactor| |p|
         (SPADCALL (SPADCALL |p| (QREFELT $ 72)) (QREFELT $ 75)) $)) 

(SDEFUN |EFACTOR;factor;SupLF;8|
        ((|p| (|SparseUnivariatePolynomial| F)) (|lf| (|List| F))
         ($ (|Factored| (|SparseUnivariatePolynomial| F))))
        (|EFACTOR;ifactor| |p|
         (SPADCALL (SPADCALL |lf| (SPADCALL |p| (QREFELT $ 72)) (QREFELT $ 77))
                   (QREFELT $ 75))
         $)) 

(DECLAIM (NOTINLINE |ExpressionFactorPolynomial;|)) 

(DEFUN |ExpressionFactorPolynomial| (&REST #1=#:G793)
  (SPROG NIL
         (PROG (#2=#:G794)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ExpressionFactorPolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ExpressionFactorPolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ExpressionFactorPolynomial|)))))))))) 

(DEFUN |ExpressionFactorPolynomial;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ExpressionFactorPolynomial| DV$1 DV$2))
          (LETT $ (GETREFV 79))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExpressionFactorPolynomial|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|domainEqual| |#1| (|Integer|))
            (PROGN
             (QSETREFV $ 12
                       (CONS (|dispatchFunction| |EFACTOR;poly_factor;SupF;1|)
                             $))))
           ((|domainEqual| |#1| (|Complex| (|Integer|)))
            (PROGN
             (QSETREFV $ 12
                       (CONS (|dispatchFunction| |EFACTOR;poly_factor;SupF;2|)
                             $))))
           ((|HasCategory|
             (|SparseMultivariatePolynomial| |#1| (|Kernel| |#2|))
             '(|PolynomialFactorizationExplicit|))
            (QSETREFV $ 12
                      (CONS (|dispatchFunction| |EFACTOR;poly_factor;SupF;3|)
                            $)))
           ('T
            (QSETREFV $ 12
                      (CONS (|dispatchFunction| |EFACTOR;poly_factor;SupF;4|)
                            $))))
          (QSETREFV $ 19 (SPADCALL (QREFELT $ 18)))
          (QSETREFV $ 22 (SPADCALL (QREFELT $ 21)))
          (QSETREFV $ 25 (SPADCALL (QREFELT $ 22) (QREFELT $ 24)))
          $))) 

(MAKEPROP '|ExpressionFactorPolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Factored| 9) (|SparseUnivariatePolynomial| 15)
              (|MultivariateFactorize| 23 (|IndexedExponents| 23) 6 15)
              (0 . |factor|) (5 . |poly_factor|) (|Factored| 14)
              (|SparseUnivariatePolynomial| $)
              (|SparseMultivariatePolynomial| 6 23) (10 . |factorPolynomial|)
              (|SingletonAsOrderedSet|) (15 . |create|) '|dummy| (|Symbol|)
              (19 . |new|) '|xs| (|Kernel| 7) (23 . |kernel|) '|xk|
              (|SparseUnivariatePolynomial| 7) (28 . |leadingCoefficient|)
              (33 . |Zero|) (37 . |Zero|) (|Boolean|) (41 . =) (47 . |One|)
              (51 . |One|) (|NonNegativeInteger|) (|Factored| 26)
              (55 . |nilFactor|) (61 . /) (67 . |coerce|) (|Kernel| $)
              (72 . |coerce|) (77 . |eval|) (84 . |retract|)
              (|SparseMultivariatePolynomial| 6 39) (89 . |numer|)
              (94 . |univariate|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 46) (|:| |factor| 26) (|:| |exponent| 34))
              (|List| 47) (100 . |makeFR|)
              (|Record| (|:| |flag| 46) (|:| |factor| 9) (|:| |exponent| 34))
              (|List| 50) (106 . |factorList|) (111 . |degree|) (116 . ~=)
              (122 . |coerce|) (|Mapping| 7 15)
              (|UnivariatePolynomialCategoryFunctions2| 15 9 7 26)
              (127 . |map|) (133 . |primeFactor|) (139 . *) (145 . |degree|)
              (150 . |max|) (|Mapping| 23 23 23) (|List| 23) (156 . |reduce|)
              (162 . |minPoly|) (167 . ~=)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 23) 23
                                                     6 15 7)
              (173 . |univariate|) (180 . |elt|) (|List| 7)
              (186 . |coefficients|) (|List| 39) (|List| $) (191 . |algtower|)
              |EFACTOR;factorPolynomial;SupF;7| (196 . |concat|)
              |EFACTOR;factor;SupLF;8|)
           '#(|poly_factor| 202 |factorPolynomial| 207 |factor| 212) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factorPolynomial|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|SparseUnivariatePolynomial| |#2|)))
                                T)
                              '((|factor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|SparseUnivariatePolynomial| |#2|)
                                  (|List| |#2|)))
                                T)
                              '((|poly_factor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial|
                                    (|SparseMultivariatePolynomial| |#1|
                                                                    (|Kernel|
                                                                     |#2|))))
                                  (|SparseUnivariatePolynomial|
                                   (|SparseMultivariatePolynomial| |#1|
                                                                   (|Kernel|
                                                                    |#2|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 78
                                            '(1 10 8 9 11 1 0 8 9 12 1 15 13 14
                                              16 0 17 0 18 0 20 0 21 1 23 0 20
                                              24 1 26 7 0 27 0 6 0 28 0 7 0 29
                                              2 7 30 0 0 31 0 6 0 32 0 7 0 33 2
                                              35 0 26 34 36 2 26 0 0 7 37 1 26
                                              0 7 38 1 7 0 39 40 3 26 0 0 17 7
                                              41 1 26 7 0 42 1 7 43 0 44 2 15
                                              14 0 23 45 2 35 0 26 48 49 1 8 51
                                              0 52 1 9 34 0 53 2 46 30 0 0 54 1
                                              7 0 43 55 2 57 26 56 9 58 2 35 0
                                              26 34 59 2 35 0 0 0 60 1 26 34 0
                                              61 2 23 0 0 0 62 2 64 23 63 0 65
                                              1 7 14 39 66 2 23 30 0 0 67 3 68
                                              26 7 23 26 69 2 26 7 0 7 70 1 26
                                              71 0 72 1 7 73 74 75 2 71 0 0 0
                                              77 1 0 8 9 12 1 0 35 26 76 2 0 35
                                              26 71 78)))))
           '|lookupComplete|)) 
