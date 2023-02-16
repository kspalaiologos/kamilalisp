
(SDEFUN |POLYCATQ;univariate;FVF;1|
        ((|f| (F)) (|x| (V)) ($ (|Fraction| (|SparseUnivariatePolynomial| F))))
        (SPADCALL (|POLYCATQ;P2UP| (SPADCALL |f| (QREFELT $ 11)) |x| $)
                  (|POLYCATQ;P2UP| (SPADCALL |f| (QREFELT $ 12)) |x| $)
                  (QREFELT $ 15))) 

(SDEFUN |POLYCATQ;univ_root|
        ((|f| (F)) (|x| (V)) (|a| (F)) (|k| (|Integer|))
         (|modulus| (|SparseUnivariatePolynomial| F))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((|nd| (F)) (|cofact| (|SparseUnivariatePolynomial| F))
          (|cf2| #1=(|SparseUnivariatePolynomial| F)) (#2=#:G713 NIL)
          (|ndu| (|Union| (|SparseUnivariatePolynomial| F) #3="failed"))
          (|nd1| (|SparseUnivariatePolynomial| F)) (|cf1| #1#) (|c0| (F))
          (|c1| (F)) (|c2| (F)) (|df| #4=(|SparseUnivariatePolynomial| F))
          (|nf| #4#))
         (SEQ
          (LETT |nf|
                (SPADCALL (|POLYCATQ;P2UP| (SPADCALL |f| (QREFELT $ 11)) |x| $)
                          |modulus| (QREFELT $ 20)))
          (LETT |df|
                (SPADCALL (|POLYCATQ;P2UP| (SPADCALL |f| (QREFELT $ 12)) |x| $)
                          |modulus| (QREFELT $ 20)))
          (LETT |cofact|
                (COND ((EQL |k| 1) (|spadConstant| $ 23))
                      ((EQL |k| 2)
                       (SPADCALL |df| (QREFELT $ 19)
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 24)
                                            (QREFELT $ 25))
                                  1 (QREFELT $ 27))
                                 (QREFELT $ 28)))
                      ((EQL |k| 3)
                       (SEQ (LETT |c2| (SPADCALL |df| 2 (QREFELT $ 29)))
                            (LETT |c1| (SPADCALL |df| 1 (QREFELT $ 29)))
                            (LETT |c0| (SPADCALL |df| 0 (QREFELT $ 29)))
                            (EXIT
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL |c0| 2 (QREFELT $ 33))
                                          (SPADCALL
                                           (SPADCALL |c2| |c1| (QREFELT $ 34))
                                           |a| (QREFELT $ 34))
                                          (QREFELT $ 35))
                                (QREFELT $ 36))
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (SPADCALL |c2| 2 (QREFELT $ 33)) |a|
                                           (QREFELT $ 34))
                                 (SPADCALL |c0| |c1| (QREFELT $ 34))
                                 (QREFELT $ 35))
                                1 (QREFELT $ 27))
                               (QREFELT $ 37))
                              (SPADCALL
                               (SPADCALL (SPADCALL |c1| 2 (QREFELT $ 33))
                                         (SPADCALL |c0| |c2| (QREFELT $ 34))
                                         (QREFELT $ 35))
                               2 (QREFELT $ 27))
                              (QREFELT $ 37)))))
                      ((EQL |k| 4)
                       (SEQ
                        (LETT |cf1|
                              (SPADCALL |df| (QREFELT $ 19)
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 24)
                                                   (QREFELT $ 25))
                                         1 (QREFELT $ 27))
                                        (QREFELT $ 28)))
                        (LETT |nd1| (SPADCALL |df| |cf1| (QREFELT $ 38)))
                        (LETT |ndu| (SPADCALL |nd1| 2 (QREFELT $ 40)))
                        (LETT |cf2|
                              (SPADCALL
                               (PROG2 (LETT #2# |ndu|)
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0)
                                                 (|SparseUnivariatePolynomial|
                                                  (QREFELT $ 10))
                                                 (|Union|
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 10))
                                                  #3#)
                                                 #2#))
                               (QREFELT $ 19)
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 24) (QREFELT $ 25))
                                2 (QREFELT $ 27))
                               (QREFELT $ 28)))
                        (EXIT (SPADCALL |cf1| |cf2| (QREFELT $ 38)))))))
          (LETT |nd|
                (SPADCALL
                 (SPADCALL (SPADCALL |df| |cofact| (QREFELT $ 38)) |modulus|
                           (QREFELT $ 20))
                 (QREFELT $ 41)))
          (EXIT
           (SPADCALL
            (SPADCALL (SPADCALL |nf| |cofact| (QREFELT $ 38)) |modulus|
                      (QREFELT $ 20))
            |nd| (QREFELT $ 42)))))) 

(SDEFUN |POLYCATQ;univariate;FV2Sup;3|
        ((|f| (F)) (|x| (V)) (|modulus| (|SparseUnivariatePolynomial| F))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((|bc|
           (|Union|
            (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                      (|:| |coef2| (|SparseUnivariatePolynomial| F)))
            "failed"))
          (|m0| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (COND
           ((<= (SPADCALL |modulus| (QREFELT $ 43)) 4)
            (COND
             ((SPADCALL (LETT |m0| (SPADCALL |modulus| (QREFELT $ 44)))
                        (QREFELT $ 46))
              (EXIT
               (|POLYCATQ;univ_root| |f| |x|
                (SPADCALL
                 (SPADCALL (SPADCALL |m0| (QREFELT $ 47))
                           (SPADCALL |modulus| (QREFELT $ 48)) (QREFELT $ 49))
                 (QREFELT $ 25))
                (SPADCALL |modulus| (QREFELT $ 43)) |modulus| $))))))
          (LETT |bc|
                (SPADCALL (|POLYCATQ;P2UP| (SPADCALL |f| (QREFELT $ 12)) |x| $)
                          |modulus| (|spadConstant| $ 23) (QREFELT $ 52)))
          (EXIT
           (COND
            ((QEQCAR |bc| 1) (|error| "univariate: denominator is 0 mod p"))
            ('T
             (SPADCALL
              (SPADCALL (|POLYCATQ;P2UP| (SPADCALL |f| (QREFELT $ 11)) |x| $)
                        (QCAR (QCDR |bc|)) (QREFELT $ 38))
              |modulus| (QREFELT $ 20)))))))) 

(SDEFUN |POLYCATQ;multivariate;FVF;4|
        ((|f| (|Fraction| (|SparseUnivariatePolynomial| F))) (|x| (V)) ($ (F)))
        (SPROG ((|v| (F)))
               (SEQ
                (LETT |v|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 54)) (QREFELT $ 55)))
                (EXIT
                 (SPADCALL
                  (SPADCALL (SPADCALL |f| (QREFELT $ 56)) |v| (QREFELT $ 57))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 58)) |v| (QREFELT $ 57))
                  (QREFELT $ 49)))))) 

(SDEFUN |POLYCATQ;mymerge| ((|l| (|List| V)) (|m| (|List| V)) ($ (|List| V)))
        (COND ((NULL |l|) |m|) ((NULL |m|) |l|)
              ((SPADCALL (|SPADfirst| |l|) (|SPADfirst| |m|) (QREFELT $ 60))
               (CONS (|SPADfirst| |l|)
                     (|POLYCATQ;mymerge| (CDR |l|) (CDR |m|) $)))
              ((SPADCALL (|SPADfirst| |l|) (|SPADfirst| |m|) (QREFELT $ 61))
               (CONS (|SPADfirst| |l|) (|POLYCATQ;mymerge| (CDR |l|) |m| $)))
              ('T
               (CONS (|SPADfirst| |m|) (|POLYCATQ;mymerge| |l| (CDR |m|) $))))) 

(SDEFUN |POLYCATQ;variables;FL;6| ((|f| (F)) ($ (|List| V)))
        (|POLYCATQ;mymerge|
         (SPADCALL (SPADCALL |f| (QREFELT $ 11)) (QREFELT $ 63))
         (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (QREFELT $ 63)) $)) 

(SDEFUN |POLYCATQ;isPower;FU;7|
        ((|f| (F))
         ($
          (|Union| (|Record| (|:| |val| F) (|:| |exponent| (|Integer|)))
                   "failed")))
        (SPROG
         ((|r|
           (|Record| (|:| |var| V) (|:| |exponent| (|NonNegativeInteger|))))
          (|ur|
           (|Union|
            (|Record| (|:| |var| V) (|:| |exponent| (|NonNegativeInteger|)))
            "failed"))
          (|den| (P)))
         (SEQ
          (COND
           ((SPADCALL (LETT |den| (SPADCALL |f| (QREFELT $ 12)))
                      (|spadConstant| $ 22) (QREFELT $ 65))
            (COND
             ((SPADCALL (SPADCALL |f| (QREFELT $ 11)) (|spadConstant| $ 22)
                        (QREFELT $ 65))
              (CONS 1 "failed"))
             (#1='T
              (SEQ (LETT |ur| (SPADCALL |den| (QREFELT $ 68)))
                   (EXIT
                    (COND
                     ((QEQCAR |ur| 1)
                      (CONS 0 (CONS (SPADCALL |den| (QREFELT $ 55)) -1)))
                     (#1#
                      (SEQ (LETT |r| (QCDR |ur|))
                           (EXIT
                            (CONS 0
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL (QCAR |r|) (QREFELT $ 54))
                                    (QREFELT $ 55))
                                   (- (QCDR |r|)))))))))))))
           (#1#
            (SEQ
             (LETT |ur|
                   (SPADCALL (SPADCALL |f| (QREFELT $ 11)) (QREFELT $ 68)))
             (EXIT
              (COND ((QEQCAR |ur| 1) (CONS 1 "failed"))
                    (#1#
                     (SEQ (LETT |r| (QCDR |ur|))
                          (EXIT
                           (CONS 0
                                 (CONS
                                  (SPADCALL
                                   (SPADCALL (QCAR |r|) (QREFELT $ 54))
                                   (QREFELT $ 55))
                                  (QCDR |r|)))))))))))))) 

(SDEFUN |POLYCATQ;isExpt;FU;8|
        ((|f| (F))
         ($
          (|Union| (|Record| (|:| |var| V) (|:| |exponent| (|Integer|)))
                   "failed")))
        (SPROG
         ((|r|
           (|Record| (|:| |var| V) (|:| |exponent| (|NonNegativeInteger|))))
          (|ur|
           (|Union|
            (|Record| (|:| |var| V) (|:| |exponent| (|NonNegativeInteger|)))
            "failed")))
         (SEQ
          (LETT |ur| (SPADCALL (SPADCALL |f| (QREFELT $ 11)) (QREFELT $ 68)))
          (EXIT
           (COND
            ((QEQCAR |ur| 1)
             (COND
              ((SPADCALL (SPADCALL |f| (QREFELT $ 11)) (|spadConstant| $ 22)
                         (QREFELT $ 72))
               (SEQ
                (LETT |ur|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (QREFELT $ 68)))
                (EXIT
                 (COND ((QEQCAR |ur| 1) (CONS 1 "failed"))
                       (#1='T
                        (SEQ (LETT |r| (QCDR |ur|))
                             (EXIT
                              (CONS 0 (CONS (QCAR |r|) (- (QCDR |r|)))))))))))
              (#1# (CONS 1 "failed"))))
            (#1#
             (SEQ (LETT |r| (QCDR |ur|))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |f| (QREFELT $ 12))
                               (|spadConstant| $ 22) (QREFELT $ 72))
                     (CONS 0 (CONS (QCAR |r|) (QCDR |r|))))
                    (#1# (CONS 1 "failed"))))))))))) 

(SDEFUN |POLYCATQ;isTimes;FU;9| ((|f| (F)) ($ (|Union| (|List| F) "failed")))
        (SPROG
         ((|d| (F)) (|den| (P)) (|l| (|Union| (|List| F) "failed"))
          (#1=#:G798 NIL) (|x| NIL) (#2=#:G797 NIL)
          (|t| (|Union| (|List| P) "failed")) (|num| (P)))
         (SEQ
          (LETT |t|
                (SPADCALL (LETT |num| (SPADCALL |f| (QREFELT $ 11)))
                          (QREFELT $ 77)))
          (LETT |l|
                (COND ((QEQCAR |t| 1) (CONS 1 "failed"))
                      (#3='T
                       (CONS 0
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |x| NIL) (LETT #1# (QCDR |t|)) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |x| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS (SPADCALL |x| (QREFELT $ 55))
                                                 #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#))))))))
          (LETT |den| (SPADCALL |f| (QREFELT $ 12)))
          (EXIT
           (COND ((SPADCALL |den| (|spadConstant| $ 22) (QREFELT $ 72)) |l|)
                 ((SPADCALL |num| (|spadConstant| $ 22) (QREFELT $ 72))
                  (CONS 1 "failed"))
                 (#3#
                  (SEQ
                   (LETT |d|
                         (SPADCALL (SPADCALL |den| (QREFELT $ 55))
                                   (QREFELT $ 78)))
                   (EXIT
                    (COND
                     ((QEQCAR |l| 1)
                      (CONS 0 (LIST (SPADCALL |num| (QREFELT $ 55)) |d|)))
                     (#3#
                      (CONS 0
                            (SPADCALL (QCDR |l|) |d| (QREFELT $ 80))))))))))))) 

(SDEFUN |POLYCATQ;isPlus;FU;10| ((|f| (F)) ($ (|Union| (|List| F) "failed")))
        (SPROG
         ((#1=#:G811 NIL) (|x| NIL) (#2=#:G810 NIL)
          (|s| (|Union| (|List| P) "failed")))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |f| (QREFELT $ 12)) (|spadConstant| $ 22)
                      (QREFELT $ 65))
            (CONS 1 "failed"))
           (#3='T
            (SEQ
             (LETT |s| (SPADCALL (SPADCALL |f| (QREFELT $ 11)) (QREFELT $ 83)))
             (EXIT
              (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                    (#3#
                     (CONS 0
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |x| NIL) (LETT #1# (QCDR |s|)) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |x| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (SPADCALL |x| (QREFELT $ 55))
                                               #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#)))))))))))))) 

(SDEFUN |POLYCATQ;mainVariable;FU;11| ((|f| (F)) ($ (|Union| V "failed")))
        (SPROG ((|b| #1=(|Union| V "failed")) (|a| #1#))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 11)) (QREFELT $ 86)))
                (LETT |b|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (QREFELT $ 86)))
                (EXIT
                 (COND ((QEQCAR |b| 1) |a|) ((QEQCAR |a| 1) |b|)
                       ('T
                        (CONS 0
                              (SPADCALL (QCDR |a|) (QCDR |b|)
                                        (QREFELT $ 87))))))))) 

(SDEFUN |POLYCATQ;P2UP|
        ((|p| (P)) (|x| (V)) ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL (ELT $ 55) (SPADCALL |p| |x| (QREFELT $ 90)) (QREFELT $ 94))) 

(DECLAIM (NOTINLINE |PolynomialCategoryQuotientFunctions;|)) 

(DEFUN |PolynomialCategoryQuotientFunctions| (&REST #1=#:G818)
  (SPROG NIL
         (PROG (#2=#:G819)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialCategoryQuotientFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |PolynomialCategoryQuotientFunctions;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PolynomialCategoryQuotientFunctions|)))))))))) 

(DEFUN |PolynomialCategoryQuotientFunctions;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$|
          (LIST '|PolynomialCategoryQuotientFunctions| DV$1 DV$2 DV$3 DV$4
                DV$5))
    (LETT $ (GETREFV 95))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PolynomialCategoryQuotientFunctions|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 19 (SPADCALL (QREFELT $ 18)))
    $))) 

(MAKEPROP '|PolynomialCategoryQuotientFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (0 . |numer|)
              (5 . |denom|) (|SparseUnivariatePolynomial| 10) (|Fraction| 13)
              (10 . /) |POLYCATQ;univariate;FVF;1| (|SingletonAsOrderedSet|)
              (16 . |create|) '|dummys| (20 . |rem|) (26 . |One|) (30 . |One|)
              (34 . |One|) (38 . |One|) (42 . -) (|NonNegativeInteger|)
              (47 . |monomial|) (53 . |eval|) (60 . |coefficient|)
              (66 . |Zero|) (70 . |Zero|) (|PositiveInteger|) (74 . ^) (80 . *)
              (86 . -) (92 . |coerce|) (97 . +) (103 . *) (|Union| $ '"failed")
              (109 . |divideExponents|) (115 . |retract|) (120 . /)
              (126 . |degree|) (131 . |reductum|) (|Boolean|) (136 . |ground?|)
              (141 . |ground|) (146 . |leadingCoefficient|) (151 . /)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 50 '"failed")
              (157 . |extendedEuclidean|) |POLYCATQ;univariate;FV2Sup;3|
              (164 . |coerce|) (169 . |coerce|) (174 . |numer|) (179 . |elt|)
              (185 . |denom|) |POLYCATQ;multivariate;FVF;4| (190 . =) (196 . >)
              (|List| 7) (202 . |variables|) |POLYCATQ;variables;FL;6|
              (207 . ~=) (|Record| (|:| |var| 7) (|:| |exponent| 26))
              (|Union| 66 '#1="failed") (213 . |isExpt|)
              (|Record| (|:| |val| 10) (|:| |exponent| (|Integer|)))
              (|Union| 69 '#2="failed") |POLYCATQ;isPower;FU;7| (218 . =)
              (|Record| (|:| |var| 7) (|:| |exponent| (|Integer|)))
              (|Union| 73 '#3="failed") |POLYCATQ;isExpt;FU;8|
              (|Union| (|List| $) '#1#) (224 . |isTimes|) (229 . |inv|)
              (|List| 10) (234 . |concat!|) (|Union| 79 '#4="failed")
              |POLYCATQ;isTimes;FU;9| (240 . |isPlus|) |POLYCATQ;isPlus;FU;10|
              (|Union| 7 '"failed") (245 . |mainVariable|) (250 . |max|)
              |POLYCATQ;mainVariable;FU;11| (|SparseUnivariatePolynomial| $)
              (256 . |univariate|) (|Mapping| 10 9)
              (|SparseUnivariatePolynomial| 9)
              (|SparseUnivariatePolynomialFunctions2| 9 10) (262 . |map|))
           '#(|variables| 268 |univariate| 273 |multivariate| 286
              |mainVariable| 292 |isTimes| 297 |isPower| 302 |isPlus| 307
              |isExpt| 312)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|variables| ((|List| |#2|) |#5|)) T)
                                   '((|mainVariable|
                                      ((|Union| |#2| "failed") |#5|))
                                     T)
                                   '((|univariate|
                                      ((|Fraction|
                                        (|SparseUnivariatePolynomial| |#5|))
                                       |#5| |#2|))
                                     T)
                                   '((|multivariate|
                                      (|#5|
                                       (|Fraction|
                                        (|SparseUnivariatePolynomial| |#5|))
                                       |#2|))
                                     T)
                                   '((|univariate|
                                      ((|SparseUnivariatePolynomial| |#5|) |#5|
                                       |#2|
                                       (|SparseUnivariatePolynomial| |#5|)))
                                     T)
                                   '((|isPlus|
                                      ((|Union| (|List| |#5|) "failed") |#5|))
                                     T)
                                   '((|isTimes|
                                      ((|Union| (|List| |#5|) #4#) |#5|))
                                     T)
                                   '((|isExpt|
                                      ((|Union|
                                        (|Record| (|:| |var| |#2|)
                                                  (|:| |exponent| (|Integer|)))
                                        #3#)
                                       |#5|))
                                     T)
                                   '((|isPower|
                                      ((|Union|
                                        (|Record| (|:| |val| |#5|)
                                                  (|:| |exponent| (|Integer|)))
                                        #2#)
                                       |#5|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 94
                                            '(1 10 9 0 11 1 10 9 0 12 2 14 0 13
                                              13 15 0 17 0 18 2 13 0 0 0 20 0 8
                                              0 21 0 9 0 22 0 13 0 23 0 10 0 24
                                              1 10 0 0 25 2 13 0 10 26 27 3 13
                                              0 0 17 0 28 2 13 10 0 26 29 0 6 0
                                              30 0 8 0 31 2 10 0 0 32 33 2 10 0
                                              0 0 34 2 10 0 0 0 35 1 13 0 10 36
                                              2 13 0 0 0 37 2 13 0 0 0 38 2 13
                                              39 0 26 40 1 13 10 0 41 2 13 0 0
                                              10 42 1 13 26 0 43 1 13 0 0 44 1
                                              13 45 0 46 1 13 10 0 47 1 13 10 0
                                              48 2 10 0 0 0 49 3 13 51 0 0 0 52
                                              1 9 0 7 54 1 10 0 9 55 1 14 13 0
                                              56 2 13 10 0 10 57 1 14 13 0 58 2
                                              7 45 0 0 60 2 7 45 0 0 61 1 9 62
                                              0 63 2 9 45 0 0 65 1 9 67 0 68 2
                                              9 45 0 0 72 1 9 76 0 77 1 10 0 0
                                              78 2 79 0 0 10 80 1 9 76 0 83 1 9
                                              85 0 86 2 7 0 0 0 87 2 9 89 0 7
                                              90 2 93 13 91 92 94 1 0 62 10 64
                                              2 0 14 10 7 16 3 0 13 10 7 13 53
                                              2 0 10 14 7 59 1 0 85 10 88 1 0
                                              81 10 82 1 0 70 10 71 1 0 81 10
                                              84 1 0 74 10 75)))))
           '|lookupComplete|)) 
