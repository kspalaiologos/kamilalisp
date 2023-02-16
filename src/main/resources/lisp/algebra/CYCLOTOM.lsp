
(SDEFUN |CYCLOTOM;cyclotomic;ISup;1|
        ((|n| (|Integer|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG
         ((|l| (|SparseUnivariatePolynomial| (|Integer|))) (#1=#:G715 NIL)
          (#2=#:G714 NIL) (#3=#:G712 NIL) (#4=#:G720 NIL) (|u| NIL)
          (|g|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|Integer|))
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ (LETT |g| (SPADCALL (SPADCALL |n| (QREFELT $ 9)) (QREFELT $ 13)))
              (LETT |l|
                    (SPADCALL (SPADCALL 1 1 (QREFELT $ 17))
                              (SPADCALL 1 0 (QREFELT $ 17)) (QREFELT $ 18)))
              (SEQ (LETT |u| NIL) (LETT #4# |g|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |u| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |l|
                          (QCAR
                           (SPADCALL
                            (SPADCALL |l|
                                      (PROG1 (LETT #3# (QVELT |u| 1))
                                        (|check_subtype2| (>= #3# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #3#))
                                      (QREFELT $ 19))
                            |l| (QREFELT $ 21))))
                    (EXIT
                     (COND
                      ((> (QVELT |u| 2) 1)
                       (LETT |l|
                             (SPADCALL |l|
                                       (PROG1
                                           (LETT #1#
                                                 (EXPT (QVELT |u| 1)
                                                       (PROG1
                                                           (LETT #2#
                                                                 (-
                                                                  (QVELT |u| 2)
                                                                  1))
                                                         (|check_subtype2|
                                                          (>= #2# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #2#))))
                                         (|check_subtype2| (>= #1# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #1#))
                                       (QREFELT $ 19)))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT |l|)))) 

(SDEFUN |CYCLOTOM;cyclotomicDecomposition;IL;2|
        ((|n| (|Integer|))
         ($ (|List| (|SparseUnivariatePolynomial| (|Integer|)))))
        (SPROG
         ((|l| (|List| (|SparseUnivariatePolynomial| (|Integer|))))
          (|m| (|List| (|SparseUnivariatePolynomial| (|Integer|))))
          (#1=#:G732 NIL) (#2=#:G745 NIL) (|z| NIL) (#3=#:G744 NIL)
          (#4=#:G743 NIL) (|rr| NIL) (#5=#:G726 NIL) (#6=#:G742 NIL)
          (#7=#:G741 NIL) (#8=#:G740 NIL) (|u| NIL)
          (|g|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|Integer|))
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ (LETT |g| (SPADCALL (SPADCALL |n| (QREFELT $ 9)) (QREFELT $ 13)))
              (LETT |l|
                    (LIST
                     (SPADCALL (SPADCALL 1 1 (QREFELT $ 17))
                               (SPADCALL 1 0 (QREFELT $ 17)) (QREFELT $ 18))))
              (SEQ (LETT |u| NIL) (LETT #8# |g|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |u| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |m|
                          (PROGN
                           (LETT #7# NIL)
                           (SEQ (LETT |z| NIL) (LETT #6# |l|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |z| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #7#
                                        (CONS
                                         (QCAR
                                          (SPADCALL
                                           (SPADCALL |z|
                                                     (PROG1
                                                         (LETT #5#
                                                               (QVELT |u| 1))
                                                       (|check_subtype2|
                                                        (>= #5# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #5#))
                                                     (QREFELT $ 19))
                                           |z| (QREFELT $ 21)))
                                         #7#))))
                                (LETT #6# (CDR #6#)) (GO G190) G191
                                (EXIT (NREVERSE #7#)))))
                    (SEQ (LETT |rr| 1) (LETT #4# (- (QVELT |u| 2) 1)) G190
                         (COND ((|greater_SI| |rr| #4#) (GO G191)))
                         (SEQ (LETT |l| (SPADCALL |l| |m| (QREFELT $ 24)))
                              (EXIT
                               (LETT |m|
                                     (PROGN
                                      (LETT #3# NIL)
                                      (SEQ (LETT |z| NIL) (LETT #2# |m|) G190
                                           (COND
                                            ((OR (ATOM #2#)
                                                 (PROGN
                                                  (LETT |z| (CAR #2#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #3#
                                                   (CONS
                                                    (SPADCALL |z|
                                                              (PROG1
                                                                  (LETT #1#
                                                                        (QVELT
                                                                         |u|
                                                                         1))
                                                                (|check_subtype2|
                                                                 (>= #1# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #1#))
                                                              (QREFELT $ 19))
                                                    #3#))))
                                           (LETT #2# (CDR #2#)) (GO G190) G191
                                           (EXIT (NREVERSE #3#)))))))
                         (LETT |rr| (|inc_SI| |rr|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |l| (SPADCALL |l| |m| (QREFELT $ 24)))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (EXIT |l|)))) 

(SDEFUN |CYCLOTOM;cyclotomicFactorization;IF;3|
        ((|n| (|Integer|))
         ($ (|Factored| (|SparseUnivariatePolynomial| (|Integer|)))))
        (SPROG
         ((|fr| (|Factored| (|SparseUnivariatePolynomial| (|Integer|))))
          (#1=#:G750 NIL) (|f| NIL))
         (SEQ (LETT |fr| (|spadConstant| $ 27))
              (SEQ (LETT |f| NIL) (LETT #1# (SPADCALL |n| (QREFELT $ 25))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |fr|
                           (SPADCALL |fr| (SPADCALL |f| 1 (QREFELT $ 28))
                                     (QREFELT $ 29)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |fr|)))) 

(DECLAIM (NOTINLINE |CyclotomicPolynomialPackage;|)) 

(DEFUN |CyclotomicPolynomialPackage| ()
  (SPROG NIL
         (PROG (#1=#:G752)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|CyclotomicPolynomialPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|CyclotomicPolynomialPackage|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|CyclotomicPolynomialPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|CyclotomicPolynomialPackage|)))))))))) 

(DEFUN |CyclotomicPolynomialPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|CyclotomicPolynomialPackage|))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CyclotomicPolynomialPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CyclotomicPolynomialPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Factored| 7) (|Integer|)
              (|IntegerFactorizationPackage| 7) (0 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 10) (|:| |factor| 7) (|:| |exponent| 16))
              (|List| 11) (5 . |factorList|) (|SparseUnivariatePolynomial| 7)
              (10 . |One|) (|NonNegativeInteger|) (14 . |monomial|) (20 . -)
              (26 . |multiplyExponents|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (32 . |monicDivide|) |CYCLOTOM;cyclotomic;ISup;1| (|List| 14)
              (38 . |append|) |CYCLOTOM;cyclotomicDecomposition;IL;2|
              (|Factored| 14) (44 . |One|) (48 . |primeFactor|) (54 . *)
              |CYCLOTOM;cyclotomicFactorization;IF;3|)
           '#(|cyclotomicFactorization| 60 |cyclotomicDecomposition| 65
              |cyclotomic| 70)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|cyclotomicDecomposition|
                                 ((|List|
                                   (|SparseUnivariatePolynomial| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|cyclotomic|
                                 ((|SparseUnivariatePolynomial| (|Integer|))
                                  (|Integer|)))
                                T)
                              '((|cyclotomicFactorization|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| (|Integer|)))
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(1 8 6 7 9 1 6 12 0 13 0 14 0 15 2
                                              14 0 7 16 17 2 14 0 0 0 18 2 14 0
                                              0 16 19 2 14 20 0 0 21 2 23 0 0 0
                                              24 0 26 0 27 2 26 0 14 16 28 2 26
                                              0 0 0 29 1 0 26 7 30 1 0 23 7 25
                                              1 0 14 7 22)))))
           '|lookupComplete|)) 

(MAKEPROP '|CyclotomicPolynomialPackage| 'NILADIC T) 
