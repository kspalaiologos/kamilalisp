
(SDEFUN |EP;Ei_to_EiF|
        ((|a|
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SuchThat| (|Symbol|) (|Polynomial| R))))
         ($
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SparseUnivariatePolynomial|
                    (|Fraction| (|Polynomial| R))))))
        (COND ((QEQCAR |a| 0) (CONS 0 (QCDR |a|)))
              ('T
               (CONS 1
                     (SPADCALL (ELT $ 9)
                               (SPADCALL (SPADCALL (QCDR |a|) (QREFELT $ 11))
                                         (SPADCALL (QCDR |a|) (QREFELT $ 13))
                                         (QREFELT $ 15))
                               (QREFELT $ 20)))))) 

(SDEFUN |EP;get_x|
        ((|a|
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SuchThat| (|Symbol|) (|Polynomial| R))))
         ($ (|Symbol|)))
        (COND ((QEQCAR |a| 0) (QREFELT $ 22))
              ('T (SPADCALL (QCDR |a|) (QREFELT $ 13))))) 

(SDEFUN |EP;UP_to_F|
        ((|p| (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))
         (|x| (|Symbol|)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL |p| (SPADCALL (SPADCALL |x| (QREFELT $ 23)) (QREFELT $ 9))
                  (QREFELT $ 24))) 

(SDEFUN |EP;AV_to_M|
        ((|v|
          (|Vector|
           (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
         (|x| (|Symbol|)) ($ (|Matrix| (|Fraction| (|Polynomial| R)))))
        (SPROG ((#1=#:G730 NIL) (|i| NIL) (#2=#:G729 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |v|)) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (LIST
                                 (|EP;UP_to_F|
                                  (SPADCALL |v| |i| (QREFELT $ 27)) |x| $))
                                #2#))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 30))))) 

(SDEFUN |EP;characteristicPolynomial;MSP;5|
        ((|m| (|Matrix| (|Fraction| (|Polynomial| R)))) (|x| (|Symbol|))
         ($ (|Polynomial| R)))
        (SPADCALL
         (SPADCALL (SPADCALL |m| (QREFELT $ 32))
                   (SPADCALL (SPADCALL |x| (QREFELT $ 23)) (QREFELT $ 9))
                   (QREFELT $ 24))
         (QREFELT $ 33))) 

(SDEFUN |EP;characteristicPolynomial;MP;6|
        ((|m| (|Matrix| (|Fraction| (|Polynomial| R)))) ($ (|Polynomial| R)))
        (SPADCALL |m| (SPADCALL (QREFELT $ 21)) (QREFELT $ 34))) 

(SDEFUN |EP;eigenvector;UML;7|
        ((|a|
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SuchThat| (|Symbol|) (|Polynomial| R))))
         (|m| (|Matrix| (|Fraction| (|Polynomial| R))))
         ($ (|List| (|Matrix| (|Fraction| (|Polynomial| R))))))
        (SPROG
         ((#1=#:G744 NIL) (|v| NIL) (#2=#:G743 NIL)
          (|res1|
           (|List|
            (|Vector|
             (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
          (|x| (|Symbol|)))
         (SEQ (LETT |x| (|EP;get_x| |a| $))
              (LETT |res1|
                    (SPADCALL (|EP;Ei_to_EiF| |a| $) |m| (QREFELT $ 38)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |v| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT (LETT #2# (CONS (|EP;AV_to_M| |v| |x| $) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |EP;generalizedEigenvector;UM2NniL;8|
        ((|a|
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SuchThat| (|Symbol|) (|Polynomial| R))))
         (|m| (|Matrix| (|Fraction| (|Polynomial| R))))
         (|k| (|NonNegativeInteger|)) (|g| (|NonNegativeInteger|))
         ($ (|List| (|Matrix| (|Fraction| (|Polynomial| R))))))
        (SPROG
         ((#1=#:G753 NIL) (|v| NIL) (#2=#:G752 NIL)
          (|res1|
           (|List|
            (|Vector|
             (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
          (|x| (|Symbol|)))
         (SEQ (LETT |x| (|EP;get_x| |a| $))
              (LETT |res1|
                    (SPADCALL (|EP;Ei_to_EiF| |a| $) |m| |k| |g|
                              (QREFELT $ 43)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |v| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT (LETT #2# (CONS (|EP;AV_to_M| |v| |x| $) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |EP;generalizedEigenvector;RML;9|
        ((|eif|
          (|Record|
           (|:| |eigval|
                (|Union| (|Fraction| (|Polynomial| R))
                         (|SuchThat| (|Symbol|) (|Polynomial| R))))
           (|:| |eigmult| #1=(|NonNegativeInteger|))
           (|:| |eigvec| (|List| (|Matrix| (|Fraction| (|Polynomial| R)))))))
         (|m| (|Matrix| (|Fraction| (|Polynomial| R))))
         ($ (|List| (|Matrix| (|Fraction| (|Polynomial| R))))))
        (SPROG ((|g| (|NonNegativeInteger|)) (|k| #1#))
               (SEQ (LETT |k| (QVELT |eif| 1))
                    (LETT |g| (LENGTH (QVELT |eif| 2)))
                    (EXIT
                     (COND ((EQL |k| |g|) (QVELT |eif| 2))
                           ('T
                            (SPADCALL (QVELT |eif| 0) |m| |k| |g|
                                      (QREFELT $ 44)))))))) 

(SDEFUN |EP;EiF_to_Ei|
        ((|a|
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SparseUnivariatePolynomial|
                    (|Fraction| (|Polynomial| R)))))
         (|x| (|Symbol|))
         ($
          (|Union| (|Fraction| (|Polynomial| R))
                   (|SuchThat| (|Symbol|) (|Polynomial| R)))))
        (COND ((QEQCAR |a| 0) (CONS 0 (QCDR |a|)))
              ('T
               (CONS 1
                     (SPADCALL |x|
                               (SPADCALL
                                (SPADCALL (QCDR |a|)
                                          (SPADCALL |x| (QREFELT $ 47))
                                          (QREFELT $ 24))
                                (QREFELT $ 33))
                               (QREFELT $ 48)))))) 

(SDEFUN |EP;eigenvalues;ML;11|
        ((|m| (|Matrix| (|Fraction| (|Polynomial| R))))
         ($
          (|List|
           (|Union| (|Fraction| (|Polynomial| R))
                    (|SuchThat| (|Symbol|) (|Polynomial| R))))))
        (SPROG
         ((#1=#:G773 NIL) (|a| NIL) (#2=#:G772 NIL)
          (|res1|
           (|List|
            (|Union| (|Fraction| (|Polynomial| R))
                     (|SparseUnivariatePolynomial|
                      (|Fraction| (|Polynomial| R))))))
          (|x| (|Symbol|)))
         (SEQ (LETT |x| (SPADCALL (QREFELT $ 21)))
              (LETT |res1| (SPADCALL |m| (QREFELT $ 50)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |a| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT (LETT #2# (CONS (|EP;EiF_to_Ei| |a| |x| $) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |EP;eigenvectors;ML;12|
        ((|m| (|Matrix| (|Fraction| (|Polynomial| R))))
         ($
          (|List|
           (|Record|
            (|:| |eigval|
                 (|Union| (|Fraction| (|Polynomial| R))
                          (|SuchThat| (|Symbol|) (|Polynomial| R))))
            (|:| |eigmult| (|NonNegativeInteger|))
            (|:| |eigvec|
                 (|List| (|Matrix| (|Fraction| (|Polynomial| R)))))))))
        (SPROG
         ((#1=#:G786 NIL) (|v| NIL) (#2=#:G785 NIL) (#3=#:G784 NIL) (|ri| NIL)
          (#4=#:G783 NIL)
          (|res1|
           (|List|
            (|Record|
             (|:| |eigval|
                  (|Union| (|Fraction| (|Polynomial| R))
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|Polynomial| R)))))
             (|:| |eigmult| (|NonNegativeInteger|))
             (|:| |eigvec|
                  (|List|
                   (|Vector|
                    (|SparseUnivariatePolynomial|
                     (|Fraction| (|Polynomial| R)))))))))
          (|x| (|Symbol|)))
         (SEQ (LETT |x| (SPADCALL (QREFELT $ 21)))
              (LETT |res1| (SPADCALL |m| (QREFELT $ 55)))
              (EXIT
               (PROGN
                (LETT #4# NIL)
                (SEQ (LETT |ri| NIL) (LETT #3# |res1|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |ri| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #4#
                             (CONS
                              (VECTOR (|EP;EiF_to_Ei| (QVELT |ri| 0) |x| $)
                                      (QVELT |ri| 1)
                                      (PROGN
                                       (LETT #2# NIL)
                                       (SEQ (LETT |v| NIL)
                                            (LETT #1# (QVELT |ri| 2)) G190
                                            (COND
                                             ((OR (ATOM #1#)
                                                  (PROGN
                                                   (LETT |v| (CAR #1#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #2#
                                                    (CONS
                                                     (|EP;AV_to_M| |v| |x| $)
                                                     #2#))))
                                            (LETT #1# (CDR #1#)) (GO G190) G191
                                            (EXIT (NREVERSE #2#)))))
                              #4#))))
                     (LETT #3# (CDR #3#)) (GO G190) G191
                     (EXIT (NREVERSE #4#)))))))) 

(SDEFUN |EP;generalizedEigenvectors;ML;13|
        ((|m| (|Matrix| (|Fraction| (|Polynomial| R))))
         ($
          (|List|
           (|Record|
            (|:| |eigval|
                 (|Union| (|Fraction| (|Polynomial| R))
                          (|SuchThat| (|Symbol|) (|Polynomial| R))))
            (|:| |geneigvec|
                 (|List| (|Matrix| (|Fraction| (|Polynomial| R)))))))))
        (SPROG
         ((#1=#:G800 NIL) (|v| NIL) (#2=#:G799 NIL) (#3=#:G798 NIL) (|ri| NIL)
          (#4=#:G797 NIL)
          (|res1|
           (|List|
            (|Record|
             (|:| |eigval|
                  (|Union| (|Fraction| (|Polynomial| R))
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|Polynomial| R)))))
             (|:| |geneigvec|
                  (|List|
                   (|Vector|
                    (|SparseUnivariatePolynomial|
                     (|Fraction| (|Polynomial| R)))))))))
          (|x| (|Symbol|)))
         (SEQ (LETT |x| (SPADCALL (QREFELT $ 21)))
              (LETT |res1| (SPADCALL |m| (QREFELT $ 60)))
              (EXIT
               (PROGN
                (LETT #4# NIL)
                (SEQ (LETT |ri| NIL) (LETT #3# |res1|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |ri| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #4#
                             (CONS
                              (CONS (|EP;EiF_to_Ei| (QCAR |ri|) |x| $)
                                    (PROGN
                                     (LETT #2# NIL)
                                     (SEQ (LETT |v| NIL) (LETT #1# (QCDR |ri|))
                                          G190
                                          (COND
                                           ((OR (ATOM #1#)
                                                (PROGN
                                                 (LETT |v| (CAR #1#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #2#
                                                  (CONS
                                                   (|EP;AV_to_M| |v| |x| $)
                                                   #2#))))
                                          (LETT #1# (CDR #1#)) (GO G190) G191
                                          (EXIT (NREVERSE #2#)))))
                              #4#))))
                     (LETT #3# (CDR #3#)) (GO G190) G191
                     (EXIT (NREVERSE #4#)))))))) 

(DECLAIM (NOTINLINE |EigenPackage;|)) 

(DEFUN |EigenPackage| (#1=#:G801)
  (SPROG NIL
         (PROG (#2=#:G802)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|EigenPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|EigenPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|EigenPackage|)))))))))) 

(DEFUN |EigenPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|EigenPackage| DV$1))
          (LETT $ (GETREFV 64))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|PolynomialFactorizationExplicit|))))))
          (|haddProp| |$ConstructorCache| '|EigenPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 22 (SPADCALL (QREFELT $ 21)))
          (COND
           ((|HasCategory| (|Fraction| (|Polynomial| |#1|))
                           '(|PolynomialFactorizationExplicit|))
            (PROGN
             (QSETREFV $ 52
                       (CONS (|dispatchFunction| |EP;eigenvalues;ML;11|) $))
             (QSETREFV $ 57
                       (CONS (|dispatchFunction| |EP;eigenvectors;ML;12|) $))
             (QSETREFV $ 63
                       (CONS
                        (|dispatchFunction| |EP;generalizedEigenvectors;ML;13|)
                        $)))))
          $))) 

(MAKEPROP '|EigenPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Polynomial| 6)
              (|Fraction| 7) (0 . |coerce|) (|SuchThat| 12 7) (5 . |rhs|)
              (|Symbol|) (10 . |lhs|) (|SparseUnivariatePolynomial| $)
              (15 . |univariate|) (|SparseUnivariatePolynomial| 8)
              (|Mapping| 8 7) (|SparseUnivariatePolynomial| 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 18 8 16) (21 . |map|)
              (27 . |new|) '|dummy| (31 . |coerce|) (36 . |elt|) (|Integer|)
              (|Vector| 16) (42 . |elt|) (|List| (|List| 8)) (|Matrix| 8)
              (48 . |matrix|) (|InnerEigenPackage| 8)
              (53 . |characteristicPolynomial|) (58 . |numer|)
              |EP;characteristicPolynomial;MSP;5|
              |EP;characteristicPolynomial;MP;6| (|List| 26) (|Union| 8 16)
              (63 . |eigenvector|) (|List| 29) (|Union| 8 10)
              |EP;eigenvector;UML;7| (|NonNegativeInteger|)
              (69 . |generalizedEigenvector|)
              |EP;generalizedEigenvector;UM2NniL;8|
              (|Record| (|:| |eigval| 40) (|:| |eigmult| 42) (|:| |eigvec| 39))
              |EP;generalizedEigenvector;RML;9| (77 . |coerce|)
              (82 . |construct|) (|List| 37) (88 . |eigenvalues|) (|List| 40)
              (93 . |eigenvalues|)
              (|Record| (|:| |eigval| 37) (|:| |eigmult| 42) (|:| |eigvec| 36))
              (|List| 53) (98 . |eigenvectors|) (|List| 45)
              (103 . |eigenvectors|)
              (|Record| (|:| |eigval| 37) (|:| |geneigvec| 36)) (|List| 58)
              (108 . |generalizedEigenvectors|)
              (|Record| (|:| |eigval| 40) (|:| |geneigvec| 39)) (|List| 61)
              (113 . |generalizedEigenvectors|))
           '#(|generalizedEigenvectors| 118 |generalizedEigenvector| 123
              |eigenvectors| 137 |eigenvector| 142 |eigenvalues| 148
              |characteristicPolynomial| 153)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|characteristicPolynomial|
                                 ((|Polynomial| |#1|)
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))
                                  (|Symbol|)))
                                T)
                              '((|characteristicPolynomial|
                                 ((|Polynomial| |#1|)
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|eigenvector|
                                 ((|List|
                                   (|Matrix| (|Fraction| (|Polynomial| |#1|))))
                                  (|Union| (|Fraction| (|Polynomial| |#1|))
                                           (|SuchThat| (|Symbol|)
                                                       (|Polynomial| |#1|)))
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|generalizedEigenvector|
                                 ((|List|
                                   (|Matrix| (|Fraction| (|Polynomial| |#1|))))
                                  (|Union| (|Fraction| (|Polynomial| |#1|))
                                           (|SuchThat| (|Symbol|)
                                                       (|Polynomial| |#1|)))
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|generalizedEigenvector|
                                 ((|List|
                                   (|Matrix| (|Fraction| (|Polynomial| |#1|))))
                                  (|Record|
                                   (|:| |eigval|
                                        (|Union|
                                         (|Fraction| (|Polynomial| |#1|))
                                         (|SuchThat| (|Symbol|)
                                                     (|Polynomial| |#1|))))
                                   (|:| |eigmult| (|NonNegativeInteger|))
                                   (|:| |eigvec|
                                        (|List|
                                         (|Matrix|
                                          (|Fraction| (|Polynomial| |#1|))))))
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|eigenvalues|
                                 ((|List|
                                   (|Union| (|Fraction| (|Polynomial| |#1|))
                                            (|SuchThat| (|Symbol|)
                                                        (|Polynomial| |#1|))))
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))))
                                (|has| 6 (|PolynomialFactorizationExplicit|)))
                              '((|generalizedEigenvectors|
                                 ((|List|
                                   (|Record|
                                    (|:| |eigval|
                                         (|Union|
                                          (|Fraction| (|Polynomial| |#1|))
                                          (|SuchThat| (|Symbol|)
                                                      (|Polynomial| |#1|))))
                                    (|:| |geneigvec|
                                         (|List|
                                          (|Matrix|
                                           (|Fraction|
                                            (|Polynomial| |#1|)))))))
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))))
                                (|has| 6 (|PolynomialFactorizationExplicit|)))
                              '((|eigenvectors|
                                 ((|List|
                                   (|Record|
                                    (|:| |eigval|
                                         (|Union|
                                          (|Fraction| (|Polynomial| |#1|))
                                          (|SuchThat| (|Symbol|)
                                                      (|Polynomial| |#1|))))
                                    (|:| |eigmult| (|NonNegativeInteger|))
                                    (|:| |eigvec|
                                         (|List|
                                          (|Matrix|
                                           (|Fraction|
                                            (|Polynomial| |#1|)))))))
                                  (|Matrix| (|Fraction| (|Polynomial| |#1|)))))
                                (|has| 6 (|PolynomialFactorizationExplicit|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 63
                                            '(1 8 0 7 9 1 10 7 0 11 1 10 12 0
                                              13 2 7 14 0 12 15 2 19 16 17 18
                                              20 0 12 0 21 1 7 0 12 23 2 16 8 0
                                              8 24 2 26 16 0 25 27 1 29 0 28 30
                                              1 31 16 29 32 1 8 7 0 33 2 31 36
                                              37 29 38 4 31 36 37 29 42 42 43 1
                                              8 0 12 47 2 10 0 12 7 48 1 31 49
                                              29 50 1 0 51 29 52 1 31 54 29 55
                                              1 0 56 29 57 1 31 59 29 60 1 0 62
                                              29 63 1 1 62 29 63 4 0 39 40 29
                                              42 42 44 2 0 39 45 29 46 1 1 56
                                              29 57 2 0 39 40 29 41 1 1 51 29
                                              52 1 0 7 29 35 2 0 7 29 12
                                              34)))))
           '|lookupComplete|)) 
