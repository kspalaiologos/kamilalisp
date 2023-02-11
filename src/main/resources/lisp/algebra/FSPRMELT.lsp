
(SDEFUN |FSPRMELT;F2P|
        ((|f| (F)) (|l| (|List| (|Symbol|))) ($ (|Polynomial| F)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |f| (QREFELT $ 9)) (QREFELT $ 10))
                 (QREFELT $ 11))
                (SPADCALL (CONS #'|FSPRMELT;F2P!0| (VECTOR $ |l|))
                          (CONS #'|FSPRMELT;F2P!1| $)
                          (SPADCALL |f| (QREFELT $ 15)) (QREFELT $ 20))
                (QREFELT $ 21)))) 

(SDEFUN |FSPRMELT;F2P!1| ((|r1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |r1| (QREFELT $ 12)) (QREFELT $ 14))) 

(SDEFUN |FSPRMELT;F2P!0| ((|k1| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|FSPRMELT;K2P| |k1| |l| $))))) 

(SDEFUN |FSPRMELT;K2P|
        ((|k| (|Kernel| F)) (|l| (|List| (|Symbol|))) ($ (|Polynomial| F)))
        (SPROG ((#1=#:G721 NIL) (|v| (|Union| (|Symbol|) "failed")))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |v| (SPADCALL |k| (QREFELT $ 24)))
                       (EXIT
                        (COND
                         ((QEQCAR |v| 0)
                          (COND
                           ((SPADCALL (QCDR |v|) |l| (QREFELT $ 28))
                            (PROGN
                             (LETT #1# (SPADCALL (QCDR |v|) (QREFELT $ 29)))
                             (GO #2=#:G719))))))))
                  (EXIT
                   (SPADCALL (SPADCALL |k| (QREFELT $ 31)) (QREFELT $ 14)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FSPRMELT;primitiveElement;LR;3|
        ((|l| (|List| F))
         ($
          (|Record| (|:| |primelt| F)
                    (|:| |poly| (|List| (|SparseUnivariatePolynomial| F)))
                    (|:| |prim| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#1=#:G741 NIL) (#2=#:G740 (F)) (#3=#:G742 (F)) (#4=#:G755 NIL)
          (|c| NIL) (#5=#:G756 NIL) (|a| NIL)
          (|rec|
           (|Record| (|:| |coef| (|List| (|Integer|)))
                     (|:| |poly| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |prim| (|SparseUnivariatePolynomial| F))))
          (|pols| (|List| (|Polynomial| F))) (#6=#:G753 NIL) (|k| NIL)
          (#7=#:G754 NIL) (|v| NIL) (#8=#:G752 NIL)
          (|kers| (|List| (|Kernel| F))) (#9=#:G751 NIL) (#10=#:G750 NIL)
          (|vv| (|List| F)) (#11=#:G749 NIL) (#12=#:G748 NIL)
          (|vars| (|List| (|Symbol|))) (#13=#:G747 NIL) (|i| NIL)
          (#14=#:G746 NIL) (|u| (|String|)) (|uu| (|Symbol|)))
         (SEQ
          (LETT |u|
                (SPADCALL (LETT |uu| (SPADCALL (QREFELT $ 32)))
                          (QREFELT $ 34)))
          (LETT |vars|
                (PROGN
                 (LETT #14# NIL)
                 (SEQ (LETT |i| 1) (LETT #13# (LENGTH |l|)) G190
                      (COND ((|greater_SI| |i| #13#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #14#
                              (CONS
                               (SPADCALL (STRCONC |u| (STRINGIMAGE |i|))
                                         (QREFELT $ 35))
                               #14#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #14#)))))
          (LETT |vv|
                (PROGN
                 (LETT #12# NIL)
                 (SEQ (LETT |v| NIL) (LETT #11# |vars|) G190
                      (COND
                       ((OR (ATOM #11#) (PROGN (LETT |v| (CAR #11#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #12#
                              (CONS
                               (SPADCALL (SPADCALL |v| (QREFELT $ 36))
                                         (QREFELT $ 31))
                               #12#))))
                      (LETT #11# (CDR #11#)) (GO G190) G191
                      (EXIT (NREVERSE #12#)))))
          (LETT |kers|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |a| NIL) (LETT #9# |l|) G190
                      (COND
                       ((OR (ATOM #9#) (PROGN (LETT |a| (CAR #9#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #10# (CONS (SPADCALL |a| (QREFELT $ 37)) #10#))))
                      (LETT #9# (CDR #9#)) (GO G190) G191
                      (EXIT (NREVERSE #10#)))))
          (LETT |pols|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |v| NIL) (LETT #7# |vv|) (LETT |k| NIL)
                      (LETT #6# |kers|) G190
                      (COND
                       ((OR (ATOM #6#) (PROGN (LETT |k| (CAR #6#)) NIL)
                            (ATOM #7#) (PROGN (LETT |v| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8#
                              (CONS
                               (|FSPRMELT;F2P|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |k| (QREFELT $ 39)) |v|
                                            (QREFELT $ 41))
                                  |kers| (QREFELT $ 44))
                                 |kers| |vv| (QREFELT $ 47))
                                |vars| $)
                               #8#))))
                      (LETT #6# (PROG1 (CDR #6#) (LETT #7# (CDR #7#))))
                      (GO G190) G191 (EXIT (NREVERSE #8#)))))
          (LETT |rec| (SPADCALL |pols| |vars| |uu| (QREFELT $ 51)))
          (EXIT
           (VECTOR
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT |a| NIL) (LETT #5# |l|) (LETT |c| NIL)
                  (LETT #4# (QVELT |rec| 0)) G190
                  (COND
                   ((OR (ATOM #4#) (PROGN (LETT |c| (CAR #4#)) NIL) (ATOM #5#)
                        (PROGN (LETT |a| (CAR #5#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #3# (SPADCALL |c| |a| (QREFELT $ 53)))
                     (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 54))))
                           ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                  (LETT #4# (PROG1 (CDR #4#) (LETT #5# (CDR #5#)))) (GO G190)
                  G191 (EXIT NIL))
             (COND (#1# #2#) ('T (|spadConstant| $ 55))))
            (QVELT |rec| 1) (QVELT |rec| 2)))))) 

(SDEFUN |FSPRMELT;F2UP|
        ((|p| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|q| (|SparseUnivariatePolynomial| F))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((|ans| (|SparseUnivariatePolynomial| F))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (SEQ (LETT |ans| (|spadConstant| $ 59))
              (SEQ G190
                   (COND
                    ((NULL (NULL (SPADCALL |p| (QREFELT $ 60)))) (GO G191)))
                   (SEQ
                    (LETT |f|
                          (SPADCALL (SPADCALL |p| (QREFELT $ 61)) |k|
                                    (QREFELT $ 63)))
                    (LETT |ans|
                          (SPADCALL |ans|
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |f| (QREFELT $ 65))
                                               |q| (QREFELT $ 66))
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |f| (QREFELT $ 67))
                                                 (QREFELT $ 68))
                                       (QREFELT $ 11))
                                      (SPADCALL |p| (QREFELT $ 70))
                                      (QREFELT $ 71))
                                     (QREFELT $ 72))
                                    (QREFELT $ 73)))
                    (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 74)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |FSPRMELT;primitiveElement;2FR;5|
        ((|a1| (F)) (|a2| (F))
         ($
          (|Record| (|:| |primelt| F)
                    (|:| |pol1| (|SparseUnivariatePolynomial| F))
                    (|:| |pol2| (|SparseUnivariatePolynomial| F))
                    (|:| |prim| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| F))
          (|r| (|SparseUnivariatePolynomial| F))
          (|gg| (|SparseUnivariatePolynomial| F)) (|ic1| (F)) (|c2g| (F))
          (|g| (F)) (|w| (F))
          (|rec|
           (|Record| (|:| |coef1| (|Integer|)) (|:| |coef2| (|Integer|))
                     (|:| |prim| (|SparseUnivariatePolynomial| F))))
          (|p2| (|SparseUnivariatePolynomial| F))
          (|p1| (|SparseUnivariatePolynomial| F)) (|k1| (|Kernel| F))
          (|l| (|List| #1=(|Symbol|))) (|b| (F)) (|bb| #1#) (|a| (F))
          (|aa| #1#))
         (SEQ
          (LETT |a|
                (SPADCALL (LETT |aa| (SPADCALL (QREFELT $ 32)))
                          (QREFELT $ 75)))
          (LETT |b|
                (SPADCALL (LETT |bb| (SPADCALL (QREFELT $ 32)))
                          (QREFELT $ 75)))
          (LETT |l| (LIST |aa| |bb|))
          (LETT |p1|
                (SPADCALL (LETT |k1| (SPADCALL |a1| (QREFELT $ 37)))
                          (QREFELT $ 39)))
          (LETT |p2|
                (SPADCALL
                 (CONS #'|FSPRMELT;primitiveElement;2FR;5!0|
                       (VECTOR |a| $ |k1|))
                 (SPADCALL (SPADCALL |a2| (QREFELT $ 37)) (QREFELT $ 39))
                 (QREFELT $ 77)))
          (LETT |rec|
                (SPADCALL
                 (|FSPRMELT;F2P| (SPADCALL |p1| |a| (QREFELT $ 41)) |l| $) |aa|
                 (|FSPRMELT;F2P| (SPADCALL |p2| |b| (QREFELT $ 41)) |l| $) |bb|
                 (QREFELT $ 79)))
          (LETT |w|
                (SPADCALL (SPADCALL (QVELT |rec| 0) |a1| (QREFELT $ 53))
                          (SPADCALL (QVELT |rec| 1) |a2| (QREFELT $ 53))
                          (QREFELT $ 54)))
          (LETT |g| (SPADCALL (QVELT |rec| 2) (QREFELT $ 80)))
          (EXIT
           (COND
            ((ZEROP (QVELT |rec| 0))
             (SEQ
              (LETT |c2g|
                    (SPADCALL
                     (SPADCALL (SPADCALL (QVELT |rec| 1) (QREFELT $ 81))
                               (QREFELT $ 11))
                     |g| (QREFELT $ 82)))
              (LETT |r|
                    (SPADCALL |p1|
                              (SPADCALL (SPADCALL |p2| |c2g| (QREFELT $ 41))
                                        (SPADCALL |a| (QREFELT $ 37)) |p1|
                                        (QREFELT $ 84))
                              (QREFELT $ 85)))
              (LETT |q| (|FSPRMELT;getpoly| |r| |g| $))
              (EXIT
               (VECTOR |w| |q|
                       (SPADCALL (QVELT |rec| 1)
                                 (SPADCALL (|spadConstant| $ 87) 1
                                           (QREFELT $ 71))
                                 (QREFELT $ 88))
                       (QVELT |rec| 2)))))
            ('T
             (SEQ
              (LETT |ic1|
                    (SPADCALL (SPADCALL (QVELT |rec| 0) (QREFELT $ 81))
                              (QREFELT $ 11)))
              (LETT |gg|
                    (SPADCALL
                     (SPADCALL (SPADCALL |ic1| |g| (QREFELT $ 82))
                               (QREFELT $ 89))
                     (SPADCALL (SPADCALL (QVELT |rec| 1) |ic1| (QREFELT $ 53))
                               1 (QREFELT $ 71))
                     (QREFELT $ 90)))
              (LETT |r|
                    (SPADCALL (SPADCALL |p1| |gg| (QREFELT $ 66))
                              (|FSPRMELT;F2UP| |p2|
                               (SPADCALL |a| (QREFELT $ 37)) |gg| $)
                              (QREFELT $ 85)))
              (LETT |q| (|FSPRMELT;getpoly| |r| |g| $))
              (EXIT
               (VECTOR |w|
                       (SPADCALL (SPADCALL |ic1| 1 (QREFELT $ 71))
                                 (SPADCALL
                                  (SPADCALL (QVELT |rec| 1) |ic1|
                                            (QREFELT $ 53))
                                  |q| (QREFELT $ 91))
                                 (QREFELT $ 90))
                       |q| (QVELT |rec| 2)))))))))) 

(SDEFUN |FSPRMELT;primitiveElement;2FR;5!0| ((|z1| NIL) ($$ NIL))
        (PROG (|k1| $ |a|)
          (LETT |k1| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| (LIST |k1|) (QREFELT $ 44)) (LIST |k1|)
                      (LIST |a|) (QREFELT $ 47)))))) 

(SDEFUN |FSPRMELT;getpoly|
        ((|r| (|SparseUnivariatePolynomial| F)) (|g| (F))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPROG ((|k| (|Kernel| F)))
               (SEQ
                (COND
                 ((EQL (SPADCALL |r| (QREFELT $ 70)) 1)
                  (SEQ (LETT |k| (SPADCALL |g| (QREFELT $ 37)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |r| 0 (QREFELT $ 95))
                                    (SPADCALL |r| (QREFELT $ 61))
                                    (QREFELT $ 96))
                          (QREFELT $ 97))
                         |k| (SPADCALL |k| (QREFELT $ 39)) (QREFELT $ 84)))))
                 ('T (|error| "GCD not of degree 1")))))) 

(DECLAIM (NOTINLINE |FunctionSpacePrimitiveElement;|)) 

(DEFUN |FunctionSpacePrimitiveElement| (&REST #1=#:G778)
  (SPROG NIL
         (PROG (#2=#:G779)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpacePrimitiveElement|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FunctionSpacePrimitiveElement;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpacePrimitiveElement|)))))))))) 

(DEFUN |FunctionSpacePrimitiveElement;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpacePrimitiveElement| DV$1 DV$2))
          (LETT $ (GETREFV 98))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|AlgebraicallyClosedField|))))))
          (|haddProp| |$ConstructorCache| '|FunctionSpacePrimitiveElement|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 93
                       (CONS
                        (|dispatchFunction| |FSPRMELT;primitiveElement;2FR;5|)
                        $)))))
          $))) 

(MAKEPROP '|FunctionSpacePrimitiveElement| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseMultivariatePolynomial| 6 30) (0 . |denom|)
              (5 . |coerce|) (10 . |inv|) (15 . |coerce|) (|Polynomial| 7)
              (20 . |coerce|) (25 . |numer|) (|Mapping| 13 23) (|Mapping| 13 6)
              (|SparseMultivariatePolynomial| 6 23)
              (|PolynomialCategoryLifting| (|IndexedExponents| 23) 23 6 18 13)
              (30 . |map|) (37 . *) (|Union| 26 '"failed") (|Kernel| 7)
              (43 . |symbolIfCan|) (|Boolean|) (|Symbol|) (|List| 26)
              (48 . |member?|) (54 . |coerce|) (|Kernel| $) (59 . |coerce|)
              (64 . |new|) (|String|) (68 . |string|) (73 . |coerce|)
              (78 . |kernel|) (83 . |retract|) (|SparseUnivariatePolynomial| $)
              (88 . |minPoly|) (|SparseUnivariatePolynomial| 7) (93 . |elt|)
              (|List| 23) (|AlgebraicManipulations| 6 7) (99 . |ratDenom|)
              (|List| 30) (|List| $) (105 . |subst|)
              (|Record| (|:| |coef| (|List| 52)) (|:| |poly| (|List| 40))
                        (|:| |prim| 40))
              (|List| 13) (|PrimitiveElement| 7) (112 . |primitiveElement|)
              (|Integer|) (119 . *) (125 . +) (131 . |Zero|)
              (|Record| (|:| |primelt| 7) (|:| |poly| (|List| 40))
                        (|:| |prim| 40))
              (|List| 7) |FSPRMELT;primitiveElement;LR;3| (135 . |Zero|)
              (139 . |zero?|) (144 . |leadingCoefficient|) (|Fraction| 38)
              (149 . |univariate|) (|Fraction| 40) (155 . |numer|)
              (160 . |elt|) (166 . |denom|) (171 . |retract|)
              (|NonNegativeInteger|) (176 . |degree|) (181 . |monomial|)
              (187 . *) (193 . +) (199 . |reductum|) (204 . |coerce|)
              (|Mapping| 7 7) (209 . |map|)
              (|Record| (|:| |coef1| 52) (|:| |coef2| 52) (|:| |prim| 40))
              (215 . |primitiveElement|) (223 . |rootOf|) (228 . |coerce|)
              (233 . *)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 23) 23
                                                     6 18 7)
              (239 . |univariate|) (246 . |gcd|) (252 . |One|) (256 . |One|)
              (260 . *) (266 . |coerce|) (271 . -) (277 . *)
              (|Record| (|:| |primelt| 7) (|:| |pol1| 40) (|:| |pol2| 40)
                        (|:| |prim| 40))
              (283 . |primitiveElement|) (289 . |Zero|) (293 . |coefficient|)
              (299 . /) (305 . -))
           '#(|primitiveElement| 310) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|primitiveElement|
                                 ((|Record| (|:| |primelt| |#2|)
                                            (|:| |poly|
                                                 (|List|
                                                  (|SparseUnivariatePolynomial|
                                                   |#2|)))
                                            (|:| |prim|
                                                 (|SparseUnivariatePolynomial|
                                                  |#2|)))
                                  (|List| |#2|)))
                                T)
                              '((|primitiveElement|
                                 ((|Record| (|:| |primelt| |#2|)
                                            (|:| |pol1|
                                                 (|SparseUnivariatePolynomial|
                                                  |#2|))
                                            (|:| |pol2|
                                                 (|SparseUnivariatePolynomial|
                                                  |#2|))
                                            (|:| |prim|
                                                 (|SparseUnivariatePolynomial|
                                                  |#2|)))
                                  |#2| |#2|))
                                (|has| 7 (|AlgebraicallyClosedField|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 97
                                            '(1 7 8 0 9 1 7 0 8 10 1 7 0 0 11 1
                                              7 0 6 12 1 13 0 7 14 1 7 8 0 15 3
                                              19 13 16 17 18 20 2 13 0 7 0 21 1
                                              23 22 0 24 2 27 25 26 0 28 1 13 0
                                              26 29 1 7 0 30 31 0 26 0 32 1 26
                                              33 0 34 1 26 0 33 35 1 23 0 26 36
                                              1 7 30 0 37 1 7 38 30 39 2 40 7 0
                                              7 41 2 43 7 7 42 44 3 7 0 0 45 46
                                              47 3 50 48 49 27 26 51 2 7 0 52 0
                                              53 2 7 0 0 0 54 0 7 0 55 0 40 0
                                              59 1 40 25 0 60 1 40 7 0 61 2 7
                                              62 0 30 63 1 64 40 0 65 2 40 0 0
                                              0 66 1 64 40 0 67 1 40 7 0 68 1
                                              40 69 0 70 2 40 0 7 69 71 2 40 0
                                              0 0 72 2 40 0 0 0 73 1 40 0 0 74
                                              1 7 0 26 75 2 40 0 76 0 77 4 50
                                              78 13 26 13 26 79 1 7 0 38 80 1 7
                                              0 52 81 2 7 0 0 0 82 3 83 40 7 23
                                              40 84 2 40 0 0 0 85 0 6 0 86 0 7
                                              0 87 2 40 0 52 0 88 1 40 0 7 89 2
                                              40 0 0 0 90 2 40 0 7 0 91 2 0 92
                                              7 7 93 0 6 0 94 2 40 7 0 69 95 2
                                              7 0 0 0 96 1 7 0 0 97 2 1 92 7 7
                                              93 1 0 56 57 58)))))
           '|lookupComplete|)) 
