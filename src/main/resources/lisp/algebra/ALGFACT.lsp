
(SDEFUN |ALGFACT;liftpoly|
        ((|p| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (UP)))
        (SPADCALL (ELT $ 9) |p| (QREFELT $ 13))) 

(SDEFUN |ALGFACT;downpoly|
        ((|p| (UP))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPADCALL (ELT $ 14) |p| (QREFELT $ 17))) 

(SDEFUN |ALGFACT;ifactor|
        ((|p| (|SparseUnivariatePolynomial| (|AlgebraicNumber|)))
         (|l| (|List| (|Kernel| (|AlgebraicNumber|))))
         ($ (|Factored| (|SparseUnivariatePolynomial| (|AlgebraicNumber|)))))
        (|ALGFACT;fact| |p| |l| $)) 

(SDEFUN |ALGFACT;factor;UPF;4| ((|p| (UP)) ($ (|Factored| UP)))
        (|ALGFACT;fact| |p|
         (SPADCALL (SPADCALL |p| (QREFELT $ 19)) (QREFELT $ 22)) $)) 

(SDEFUN |ALGFACT;factor;UPLF;5|
        ((|p| (UP)) (|l| (|List| (|AlgebraicNumber|))) ($ (|Factored| UP)))
        (|ALGFACT;fact| |p|
         (SPADCALL
          (SPADCALL (SPADCALL |l| (SPADCALL |p| (QREFELT $ 19)) (QREFELT $ 25))
                    (QREFELT $ 26))
          (QREFELT $ 22))
         $)) 

(SDEFUN |ALGFACT;split;UPF;6| ((|p| (UP)) ($ (|Factored| UP)))
        (SPROG
         ((#1=#:G732 NIL) (#2=#:G731 #3=(|Factored| UP)) (#4=#:G733 #3#)
          (#5=#:G737 NIL) (|fc| NIL) (|fp| (|Factored| UP)))
         (SEQ (LETT |fp| (SPADCALL |p| (QREFELT $ 24)))
              (EXIT
               (SPADCALL (SPADCALL |fp| (QREFELT $ 28))
                         (PROGN
                          (LETT #1# NIL)
                          (SEQ (LETT |fc| NIL)
                               (LETT #5# (SPADCALL |fp| (QREFELT $ 32))) G190
                               (COND
                                ((OR (ATOM #5#)
                                     (PROGN (LETT |fc| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #4#
                                        (|ALGFACT;extend| (QVELT |fc| 1)
                                         (QVELT |fc| 2) $))
                                  (COND
                                   (#1#
                                    (LETT #2#
                                          (SPADCALL #2# #4# (QREFELT $ 33))))
                                   ('T
                                    (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                          (COND (#1# #2#) ('T (|spadConstant| $ 34))))
                         (QREFELT $ 35)))))) 

(SDEFUN |ALGFACT;extend|
        ((|p| (UP)) (|n| (|NonNegativeInteger|)) ($ (|Factored| UP)))
        (SPROG ((#1=#:G742 NIL) (|q| (UP)))
               (SEQ
                (COND
                 ((EQL (SPADCALL |p| (QREFELT $ 38)) 1)
                  (SPADCALL |p| |n| (QREFELT $ 39)))
                 ('T
                  (SEQ
                   (LETT |q|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 41) 1 (QREFELT $ 42))
                          (SPADCALL (SPADCALL |p| (QREFELT $ 44))
                                    (QREFELT $ 45))
                          (QREFELT $ 46)))
                   (EXIT
                    (SPADCALL (SPADCALL |q| |n| (QREFELT $ 39))
                              (SPADCALL
                               (SPADCALL
                                (PROG2
                                    (LETT #1#
                                          (SPADCALL |p| |q| (QREFELT $ 48)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                                  (|Union| (QREFELT $ 6)
                                                           "failed")
                                                  #1#))
                                (QREFELT $ 36))
                               |n| (QREFELT $ 49))
                              (QREFELT $ 33))))))))) 

(SDEFUN |ALGFACT;doublyTransitive?;UPB;8| ((|p| (UP)) ($ (|Boolean|)))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((|ALGFACT;irred?| |p| $)
                 (|ALGFACT;irred?|
                  (PROG2
                      (LETT #1#
                            (SPADCALL |p|
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 41) 1
                                                 (QREFELT $ 42))
                                       (SPADCALL (SPADCALL |p| (QREFELT $ 44))
                                                 (QREFELT $ 45))
                                       (QREFELT $ 46))
                                      (QREFELT $ 48)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                    (|Union| (QREFELT $ 6) "failed") #1#))
                  $))
                ('T NIL)))) 

(SDEFUN |ALGFACT;irred?| ((|p| (UP)) ($ (|Boolean|)))
        (SPROG
         ((|fp|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| UP)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (LETT |fp| (SPADCALL (SPADCALL |p| (QREFELT $ 24)) (QREFELT $ 32)))
          (EXIT
           (COND
            ((SPADCALL |fp| 1 (QREFELT $ 52))
             (EQL (QVELT (|SPADfirst| |fp|) 2) 1))
            ('T NIL)))))) 

(SDEFUN |ALGFACT;fact|
        ((|p| (UP)) (|l| (|List| #1=(|Kernel| (|AlgebraicNumber|))))
         ($ (|Factored| UP)))
        (SPROG
         ((#2=#:G779 NIL) (#3=#:G778 #4=(|Factored| UP)) (#5=#:G780 #4#)
          (#6=#:G788 NIL) (|fc| NIL) (|newalpha| (|AlgebraicNumber|))
          (|fr| (|Factored| |ups|))
          (|ups|
           (|Join| (|UnivariatePolynomialCategory| |sae|)
                   (CATEGORY |domain|
                    (SIGNATURE |outputForm|
                     ((|OutputForm|) $ (|OutputForm|))))))
          (|sae|
           (|Join|
            (|MonogenicAlgebra| #7=(|AlgebraicNumber|)
                                (|SparseUnivariatePolynomial|
                                 (|AlgebraicNumber|)))
            (CATEGORY |package|
             (IF (|has| #7# (|Field|))
                 (IF (|has| #7# (|PolynomialFactorizationExplicit|))
                     (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                     |noBranch|)
                 |noBranch|))))
          (|newl| (|List| (|Kernel| (|AlgebraicNumber|))))
          (|q| (|SparseUnivariatePolynomial| (|AlgebraicNumber|)))
          (|alpha| #1#) (#8=#:G763 NIL) (#9=#:G762 #1#) (#10=#:G764 #1#)
          (#11=#:G787 NIL) (#12=#:G689 NIL) (#13=#:G759 NIL) (#14=#:G758 #4#)
          (#15=#:G760 #4#) (#16=#:G786 NIL) (|dc| NIL)
          (|dr|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (SEQ
          (COND
           ((EQL (SPADCALL |p| (QREFELT $ 38)) 1)
            (SPADCALL |p| 1 (QREFELT $ 39)))
           ((NULL |l|)
            (SEQ
             (LETT |dr| (SPADCALL (|ALGFACT;downpoly| |p| $) (QREFELT $ 55)))
             (EXIT
              (SPADCALL (|ALGFACT;liftpoly| (SPADCALL |dr| (QREFELT $ 56)) $)
                        (PROGN
                         (LETT #13# NIL)
                         (SEQ (LETT |dc| NIL)
                              (LETT #16# (SPADCALL |dr| (QREFELT $ 59))) G190
                              (COND
                               ((OR (ATOM #16#)
                                    (PROGN (LETT |dc| (CAR #16#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #15#
                                       (SPADCALL
                                        (|ALGFACT;liftpoly| (QVELT |dc| 1) $)
                                        (QVELT |dc| 2) (QREFELT $ 39)))
                                 (COND
                                  (#13#
                                   (LETT #14#
                                         (SPADCALL #14# #15# (QREFELT $ 33))))
                                  ('T
                                   (PROGN (LETT #14# #15#) (LETT #13# 'T)))))))
                              (LETT #16# (CDR #16#)) (GO G190) G191 (EXIT NIL))
                         (COND (#13# #14#) (#17='T (|spadConstant| $ 34))))
                        (QREFELT $ 35)))))
           (#17#
            (SEQ
             (LETT |q|
                   (SPADCALL
                    (LETT |alpha|
                          (PROGN
                           (LETT #8# NIL)
                           (SEQ (LETT #12# NIL) (LETT #11# |l|) G190
                                (COND
                                 ((OR (ATOM #11#)
                                      (PROGN (LETT #12# (CAR #11#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #10# #12#)
                                   (COND
                                    (#8#
                                     (LETT #9#
                                           (SPADCALL #9# #10# (QREFELT $ 61))))
                                    ('T
                                     (PROGN (LETT #9# #10#) (LETT #8# 'T)))))))
                                (LETT #11# (CDR #11#)) (GO G190) G191
                                (EXIT NIL))
                           (COND (#8# #9#) (#17# (|IdentityError| '|max|)))))
                    (QREFELT $ 63)))
             (LETT |newl|
                   (SPADCALL (CONS #'|ALGFACT;fact!0| (VECTOR $ |alpha|)) |l|
                             (QREFELT $ 67)))
             (LETT |sae|
                   (|SimpleAlgebraicExtension| (|AlgebraicNumber|)
                                               (|SparseUnivariatePolynomial|
                                                (|AlgebraicNumber|))
                                               |q|))
             (LETT |ups| (|SparseUnivariatePolynomial| |sae|))
             (LETT |fr|
                   (SPADCALL
                    (SPADCALL
                     (CONS #'|ALGFACT;fact!1| (VECTOR |sae| $ |q| |alpha|)) |p|
                     (|compiledLookupCheck| '|map|
                                            (LIST (|devaluate| |ups|)
                                                  (LIST '|Mapping|
                                                        (|devaluate| |sae|)
                                                        (LIST
                                                         '|AlgebraicNumber|))
                                                  (|devaluate| (ELT $ 6)))
                                            (|UnivariatePolynomialCategoryFunctions2|
                                             (|AlgebraicNumber|) (ELT $ 6)
                                             |sae| |ups|)))
                    (CONS #'|ALGFACT;fact!2| (VECTOR $ |newl|))
                    (|compiledLookupCheck| '|factor|
                                           (LIST
                                            (LIST '|Factored|
                                                  (|devaluate| |ups|))
                                            (|devaluate| |ups|)
                                            (LIST '|Mapping|
                                                  (LIST '|Factored|
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (LIST
                                                          '|AlgebraicNumber|)))
                                                  (LIST
                                                   '|SparseUnivariatePolynomial|
                                                   (LIST '|AlgebraicNumber|))))
                                           (|InnerAlgFactor|
                                            (|AlgebraicNumber|)
                                            (|SparseUnivariatePolynomial|
                                             (|AlgebraicNumber|))
                                            |sae| |ups|))))
             (LETT |newalpha| (SPADCALL |alpha| (QREFELT $ 71)))
             (EXIT
              (SPADCALL
               (SPADCALL (CONS #'|ALGFACT;fact!3| (VECTOR $ |newalpha| |sae|))
                         (SPADCALL |fr|
                                   (|compiledLookupCheck| '|unit|
                                                          (LIST
                                                           (|devaluate| |ups|)
                                                           '$)
                                                          (|Factored| |ups|)))
                         (|compiledLookupCheck| '|map|
                                                (LIST (|devaluate| (ELT $ 6))
                                                      (LIST '|Mapping|
                                                            (LIST
                                                             '|AlgebraicNumber|)
                                                            (|devaluate|
                                                             |sae|))
                                                      (|devaluate| |ups|))
                                                (|UnivariatePolynomialCategoryFunctions2|
                                                 |sae| |ups|
                                                 (|AlgebraicNumber|)
                                                 (ELT $ 6))))
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |fc| NIL)
                     (LETT #6#
                           (SPADCALL |fr|
                                     (|compiledLookupCheck| '|factorList|
                                                            (LIST
                                                             (LIST '|List|
                                                                   (LIST
                                                                    '|Record|
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
                                                            (|Factored|
                                                             |ups|))))
                     G190
                     (COND
                      ((OR (ATOM #6#) (PROGN (LETT |fc| (CAR #6#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (PROGN
                        (LETT #5#
                              (SPADCALL
                               (SPADCALL
                                (CONS #'|ALGFACT;fact!4|
                                      (VECTOR $ |newalpha| |sae|))
                                (QVELT |fc| 1)
                                (|compiledLookupCheck| '|map|
                                                       (LIST
                                                        (|devaluate| (ELT $ 6))
                                                        (LIST '|Mapping|
                                                              (LIST
                                                               '|AlgebraicNumber|)
                                                              (|devaluate|
                                                               |sae|))
                                                        (|devaluate| |ups|))
                                                       (|UnivariatePolynomialCategoryFunctions2|
                                                        |sae| |ups|
                                                        (|AlgebraicNumber|)
                                                        (ELT $ 6))))
                               (QVELT |fc| 2) (QREFELT $ 39)))
                        (COND
                         (#2# (LETT #3# (SPADCALL #3# #5# (QREFELT $ 33))))
                         ('T (PROGN (LETT #3# #5#) (LETT #2# 'T)))))))
                     (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                (COND (#2# #3#) (#17# (|spadConstant| $ 34))))
               (QREFELT $ 35))))))))) 

(SDEFUN |ALGFACT;fact!4| ((|x| NIL) ($$ NIL))
        (PROG (|sae| |newalpha| $)
          (LETT |sae| (QREFELT $$ 2))
          (LETT |newalpha| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |x|
                       (|compiledLookupCheck| '|lift|
                                              (LIST
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (LIST '|AlgebraicNumber|))
                                               '$)
                                              |sae|))
             |newalpha| (QREFELT $ 72)))))) 

(SDEFUN |ALGFACT;fact!3| ((|x| NIL) ($$ NIL))
        (PROG (|sae| |newalpha| $)
          (LETT |sae| (QREFELT $$ 2))
          (LETT |newalpha| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |x|
                       (|compiledLookupCheck| '|lift|
                                              (LIST
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (LIST '|AlgebraicNumber|))
                                               '$)
                                              |sae|))
             |newalpha| (QREFELT $ 72)))))) 

(SDEFUN |ALGFACT;fact!2| ((|x| NIL) ($$ NIL))
        (PROG (|newl| $)
          (LETT |newl| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|ALGFACT;ifactor| |x| |newl| $))))) 

(SDEFUN |ALGFACT;fact!1| ((|x| NIL) ($$ NIL))
        (PROG (|alpha| |q| $ |sae|)
          (LETT |alpha| (QREFELT $$ 3))
          (LETT |q| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |sae| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |alpha| |q| (QREFELT $ 70))
                      (|compiledLookupCheck| '|reduce|
                                             (LIST '$
                                                   (LIST
                                                    '|SparseUnivariatePolynomial|
                                                    (LIST '|AlgebraicNumber|)))
                                             |sae|)))))) 

(SDEFUN |ALGFACT;fact!0| ((|x| NIL) ($$ NIL))
        (PROG (|alpha| $)
          (LETT |alpha| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |alpha| |x| (QREFELT $ 64)))))) 

(DECLAIM (NOTINLINE |AlgFactor;|)) 

(DEFUN |AlgFactor| (#1=#:G789)
  (SPROG NIL
         (PROG (#2=#:G790)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|AlgFactor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|AlgFactor;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|AlgFactor|)))))))))) 

(DEFUN |AlgFactor;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|AlgFactor| DV$1))
          (LETT $ (GETREFV 73))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|AlgFactor| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|AlgFactor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Fraction| (|Integer|))
              (|AlgebraicNumber|) (0 . |coerce|) (|Mapping| 8 7)
              (|SparseUnivariatePolynomial| 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 11 8 6) (5 . |map|)
              (11 . |retract|) (|Mapping| 7 8)
              (|UnivariatePolynomialCategoryFunctions2| 8 6 7 11) (16 . |map|)
              (|List| 8) (22 . |coefficients|) (|List| 62) (|List| $)
              (27 . |tower|) (|Factored| 6) |ALGFACT;factor;UPF;4|
              (32 . |concat|) (38 . |removeDuplicates|) |ALGFACT;factor;UPLF;5|
              (43 . |unit|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 29) (|:| |factor| 6) (|:| |exponent| 37))
              (|List| 30) (48 . |factorList|) (53 . *) (59 . |One|) (63 . *)
              |ALGFACT;split;UPF;6| (|NonNegativeInteger|) (69 . |degree|)
              (74 . |primeFactor|) (80 . |One|) (84 . |One|) (88 . |monomial|)
              (|SparseUnivariatePolynomial| $) (94 . |zeroOf|) (99 . |coerce|)
              (104 . -) (|Union| $ '"failed") (110 . |exquo|) (116 . ^)
              (|Boolean|) |ALGFACT;doublyTransitive?;UPB;8| (122 . |size?|)
              (|Factored| 11) (|RationalFactorize| 11) (128 . |factor|)
              (133 . |unit|)
              (|Record| (|:| |flag| 29) (|:| |factor| 11) (|:| |exponent| 37))
              (|List| 57) (138 . |factorList|) (|Kernel| 8) (143 . |max|)
              (|Kernel| $) (149 . |minPoly|) (154 . =) (|Mapping| 50 60)
              (|List| 60) (160 . |remove|) (|SparseUnivariatePolynomial| 8)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 60) 60
                                                     (|Integer|)
                                                     (|SparseMultivariatePolynomial|
                                                      (|Integer|) 60)
                                                     8)
              (166 . |univariate|) (173 . |coerce|) (178 . |elt|))
           '#(|split| 184 |factor| 189 |doublyTransitive?| 200) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factor|
                                 ((|Factored| |#1|) |#1|
                                  (|List| (|AlgebraicNumber|))))
                                T)
                              '((|factor| ((|Factored| |#1|) |#1|)) T)
                              '((|split| ((|Factored| |#1|) |#1|)) T)
                              '((|doublyTransitive?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 72
                                            '(1 8 0 7 9 2 12 6 10 11 13 1 8 7 0
                                              14 2 16 11 15 6 17 1 6 18 0 19 1
                                              8 20 21 22 2 18 0 0 0 25 1 18 0 0
                                              26 1 23 6 0 28 1 23 31 0 32 2 23
                                              0 0 0 33 0 23 0 34 2 23 0 6 0 35
                                              1 6 37 0 38 2 23 0 6 37 39 0 6 0
                                              40 0 8 0 41 2 6 0 8 37 42 1 8 0
                                              43 44 1 6 0 8 45 2 6 0 0 0 46 2 6
                                              47 0 0 48 2 23 0 0 37 49 2 31 50
                                              0 37 52 1 54 53 11 55 1 53 11 0
                                              56 1 53 58 0 59 2 60 0 0 0 61 1 8
                                              43 62 63 2 60 50 0 0 64 2 66 0 65
                                              0 67 3 69 68 8 60 68 70 1 8 0 62
                                              71 2 68 8 0 8 72 1 0 23 6 36 1 0
                                              23 6 24 2 0 23 6 18 27 1 0 50 6
                                              51)))))
           '|lookupComplete|)) 
