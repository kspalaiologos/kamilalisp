
(SDEFUN |IEP;eigenvalues;ML;1|
        ((|m| (|Matrix| F))
         ($ (|List| (|Union| F (|SparseUnivariatePolynomial| F)))))
        (SPADCALL |m| (ELT $ 9) (QREFELT $ 14))) 

(SDEFUN |IEP;eigenvectors;ML;2|
        ((|m| (|Matrix| F))
         ($
          (|List|
           (|Record|
            (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
            (|:| |eigmult| (|NonNegativeInteger|))
            (|:| |eigvec|
                 (|List| (|Vector| (|SparseUnivariatePolynomial| F))))))))
        (SPADCALL |m| (ELT $ 9) (QREFELT $ 18))) 

(SDEFUN |IEP;generalizedEigenvectors;ML;3|
        ((|m| (|Matrix| F))
         ($
          (|List|
           (|Record|
            (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
            (|:| |geneigvec|
                 (|List| (|Vector| (|SparseUnivariatePolynomial| F))))))))
        (SPADCALL |m| (ELT $ 9) (QREFELT $ 22))) 

(SDEFUN |IEP;reduction|
        ((|u| (|SparseUnivariatePolynomial| F))
         (|p| (|SparseUnivariatePolynomial| F))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL |u| |p| (QREFELT $ 25))) 

(SDEFUN |IEP;merge|
        ((|p| (|SparseUnivariatePolynomial| F))
         (|q| (|SparseUnivariatePolynomial| F))
         ($ (|Union| (|SparseUnivariatePolynomial| F) "failed")))
        (COND ((SPADCALL |p| |q| (QREFELT $ 27)) (CONS 0 |p|))
              ((SPADCALL |p| (|spadConstant| $ 29) (QREFELT $ 27))
               (CONS 0 |q|))
              ((SPADCALL |q| (|spadConstant| $ 29) (QREFELT $ 27))
               (CONS 0 |p|))
              ('T (CONS 1 "failed")))) 

(SDEFUN |IEP;exactquo|
        ((|u| (|SparseUnivariatePolynomial| F))
         (|v| (|SparseUnivariatePolynomial| F))
         (|p| (|SparseUnivariatePolynomial| F))
         ($ (|Union| (|SparseUnivariatePolynomial| F) "failed")))
        (SPROG
         ((|val|
           (|Union|
            (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                      (|:| |coef2| (|SparseUnivariatePolynomial| F)))
            "failed")))
         (SEQ (LETT |val| (SPADCALL |v| |p| |u| (QREFELT $ 32)))
              (EXIT
               (COND ((QEQCAR |val| 1) (CONS 1 "failed"))
                     ('T (CONS 0 (QCAR (QCDR |val|))))))))) 

(SDEFUN |IEP;genEigForm|
        ((|eigen|
          (|Record|
           (|:| |eigval| #1=(|Union| F (|SparseUnivariatePolynomial| F)))
           (|:| |eigmult| #2=(|NonNegativeInteger|))
           (|:| |eigvec|
                (|List| (|Vector| (|SparseUnivariatePolynomial| F))))))
         (A (|Matrix| F))
         ($
          (|Record| (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
                    (|:| |geneigvec|
                         (|List|
                          (|Vector| (|SparseUnivariatePolynomial| F)))))))
        (SPROG ((|g| (|NonNegativeInteger|)) (|k| #2#) (|alpha| #1#))
               (SEQ (LETT |alpha| (QVELT |eigen| 0))
                    (LETT |k| (QVELT |eigen| 1))
                    (LETT |g| (LENGTH (QVELT |eigen| 2)))
                    (EXIT
                     (COND ((EQL |k| |g|) (CONS |alpha| (QVELT |eigen| 2)))
                           ('T
                            (CONS |alpha|
                                  (SPADCALL |alpha| A |k| |g|
                                            (QREFELT $ 35))))))))) 

(SDEFUN |IEP;characteristicPolynomial;MSup;8|
        ((A (|Matrix| F)) ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL A (QREFELT $ 37))) 

(SDEFUN |IEP;characteristicPolynomial;MSup;9|
        ((A (|Matrix| F)) ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((#1=#:G752 NIL) (|j| NIL) (#2=#:G751 NIL) (|i| NIL)
          (B (|Matrix| (|SparseUnivariatePolynomial| F)))
          (|dimA| (|NonNegativeInteger|)))
         (SEQ (LETT |dimA| (ANROWS A))
              (EXIT
               (COND
                ((SPADCALL |dimA| (ANCOLS A) (QREFELT $ 39))
                 (|error| " The matrix is not square"))
                ((EQL |dimA| 0) (|spadConstant| $ 40))
                ('T
                 (SEQ (LETT B (SPADCALL |dimA| |dimA| (QREFELT $ 42)))
                      (SEQ (LETT |i| 1) (LETT #2# |dimA|) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ
                            (SEQ (LETT |j| 1) (LETT #1# |dimA|) G190
                                 (COND ((|greater_SI| |j| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SPADCALL B |i| |j|
                                             (SPADCALL
                                              (SPADCALL A |i| |j|
                                                        (QREFELT $ 44))
                                              (QREFELT $ 45))
                                             (QREFELT $ 46))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (SPADCALL B |i| |i|
                                       (SPADCALL
                                        (SPADCALL B |i| |i| (QREFELT $ 47))
                                        (SPADCALL (|spadConstant| $ 48) 1
                                                  (QREFELT $ 49))
                                        (QREFELT $ 50))
                                       (QREFELT $ 46))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL B (QREFELT $ 51)))))))))) 

(SDEFUN |IEP;eigenvalues;MML;10|
        ((A (|Matrix| F))
         (|fac|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| F))
                     (|SparseUnivariatePolynomial| F)))
         ($ (|List| (|Union| F (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#1=#:G771 NIL) (|ls| NIL) (#2=#:G770 NIL) (#3=#:G769 NIL) (|lr| NIL)
          (#4=#:G768 NIL) (|lsym| (|List| (|SparseUnivariatePolynomial| F)))
          (|lrat| (|List| F)) (|rv| (F))
          (|f1| (|SparseUnivariatePolynomial| F)) (#5=#:G767 NIL) (|fr| NIL)
          (|fp| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|pol| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |pol| (SPADCALL A (QREFELT $ 38))) (LETT |lrat| NIL)
              (LETT |lsym| NIL) (LETT |fp| (SPADCALL |pol| |fac|))
              (SEQ (LETT |fr| NIL) (LETT #5# (SPADCALL |fp| (QREFELT $ 56)))
                   G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |fr| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |f1| (QVELT |fr| 1))
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |f1| (QREFELT $ 57)) 1)
                           (SEQ
                            (LETT |rv|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |f1| 0 (QREFELT $ 58))
                                             (SPADCALL |f1| (QREFELT $ 59))
                                             (QREFELT $ 60))
                                   (QREFELT $ 61)))
                            (EXIT (LETT |lrat| (CONS |rv| |lrat|)))))
                          ('T (LETT |lsym| (CONS |f1| |lsym|))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |lr| NIL) (LETT #3# |lrat|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |lr| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #4# (CONS (CONS 0 |lr|) #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#))))
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |ls| NIL) (LETT #1# |lsym|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |ls| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (CONS 1 |ls|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))
                (QREFELT $ 62)))))) 

(SDEFUN |IEP;eigenvector;UML;11|
        ((|alpha| (|Union| F (|SparseUnivariatePolynomial| F)))
         (A (|Matrix| F))
         ($ (|List| (|Vector| (|SparseUnivariatePolynomial| F)))))
        (COND ((QEQCAR |alpha| 0) (|IEP;intRatEig| (QCDR |alpha|) A 1 $))
              ('T (|IEP;intAlgEig| (QCDR |alpha|) A 1 $)))) 

(SDEFUN |IEP;intRatEig|
        ((|alpha| (F)) (A (|Matrix| F)) (|m| (|NonNegativeInteger|))
         ($ (|List| (|Vector| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|sol| (|List| (|Vector| (|SparseUnivariatePolynomial| F))))
          (#1=#:G795 NIL) (|i| NIL)
          (|w| (|Vector| (|SparseUnivariatePolynomial| F))) (#2=#:G794 NIL)
          (|v| NIL) (#3=#:G793 NIL) (|j| NIL) (#4=#:G792 NIL) (B (|Matrix| F))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (ANROWS A)) (LETT B (SPADCALL |n| |n| (QREFELT $ 64)))
              (SEQ (LETT |i| 1) (LETT #4# |n|) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #3# |n|) G190
                         (COND ((|greater_SI| |j| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL B |i| |j|
                                     (SPADCALL A |i| |j| (QREFELT $ 44))
                                     (QREFELT $ 65))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL B |i| |i|
                               (SPADCALL (SPADCALL B |i| |i| (QREFELT $ 44))
                                         |alpha| (QREFELT $ 66))
                               (QREFELT $ 65))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |sol| NIL)
              (SEQ (LETT |v| NIL)
                   (LETT #2#
                         (SPADCALL (SPADCALL B |m| (QREFELT $ 67))
                                   (QREFELT $ 69)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |w| (MAKEARR1 |n| (|spadConstant| $ 29)))
                        (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                             (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |w| |i|
                                         (SPADCALL
                                          (SPADCALL |v| |i| (QREFELT $ 71))
                                          (QREFELT $ 45))
                                         (QREFELT $ 73))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (LETT |sol| (CONS |w| |sol|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |sol|)))) 

(SDEFUN |IEP;intAlgEig|
        ((|alpha| (|SparseUnivariatePolynomial| F)) (A (|Matrix| F))
         (|m| (|NonNegativeInteger|))
         ($ (|List| (|Vector| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|sol| (|List| (|Vector| (|SparseUnivariatePolynomial| F))))
          (#1=#:G826 NIL) (|i| NIL)
          (|w| (|Vector| (|SparseUnivariatePolynomial| F))) (#2=#:G825 NIL)
          (|vec| NIL) (#3=#:G824 NIL) (|j| NIL) (#4=#:G823 NIL) (B (AM))
          (|alg| (MM)) (|pol| (|SparseUnivariatePolynomial| F))
          (AM
           (|Join| (|MatrixCategory| MM (|Vector| MM) (|Vector| MM))
                   (CATEGORY |domain|
                    (SIGNATURE |diagonalMatrix| ($ (|Vector| MM)))
                    (IF (|has| MM (|ConvertibleTo| (|InputForm|)))
                        (ATTRIBUTE (|ConvertibleTo| (|InputForm|)))
                        |noBranch|)
                    (IF (|has| MM (|IntegralDomain|))
                        (SIGNATURE |invertIfCan| ((|Union| $ "failed") $))
                        |noBranch|))))
          (MM
           (|Join| (|Field|)
                   (CATEGORY |domain|
                    (SIGNATURE |modulus|
                     (#5=(|SparseUnivariatePolynomial| F) $))
                    (SIGNATURE |coerce|
                     (#6=(|SparseUnivariatePolynomial| F) $))
                    (SIGNATURE |reduce| ($ #6# #5#))
                    (SIGNATURE |exQuo| ((|Union| $ "failed") $ $)))))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (ANROWS A))
              (LETT MM
                    (|ModularField|
                     (|SparseUnivariatePolynomial| (QREFELT $ 6))
                     (|SparseUnivariatePolynomial| (QREFELT $ 6))
                     (CONS (|function| |IEP;reduction|) $)
                     (CONS (|function| |IEP;merge|) $)
                     (CONS (|function| |IEP;exactquo|) $)))
              (LETT AM (|Matrix| MM))
              (LETT |pol| (SPADCALL |alpha| (QREFELT $ 74)))
              (LETT |alg|
                    (SPADCALL (SPADCALL (|spadConstant| $ 48) 1 (QREFELT $ 49))
                              |pol|
                              (|compiledLookupCheck| '|reduce|
                                                     (LIST '$
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (|devaluate|
                                                             (ELT $ 6)))
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (|devaluate|
                                                             (ELT $ 6))))
                                                     MM)))
              (LETT B
                    (SPADCALL |n| |n|
                              (|compiledLookupCheck| '|zero|
                                                     (LIST '$
                                                           (LIST
                                                            '|NonNegativeInteger|)
                                                           (LIST
                                                            '|NonNegativeInteger|))
                                                     AM)))
              (SEQ (LETT |i| 1) (LETT #4# |n|) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #3# |n|) G190
                         (COND ((|greater_SI| |j| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL B |i| |j|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL A |i| |j| (QREFELT $ 44))
                                       (QREFELT $ 45))
                                      |pol|
                                      (|compiledLookupCheck| '|reduce|
                                                             (LIST '$
                                                                   (LIST
                                                                    '|SparseUnivariatePolynomial|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6)))
                                                                   (LIST
                                                                    '|SparseUnivariatePolynomial|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                             MM))
                                     (|compiledLookupCheck| '|setelt!|
                                                            (LIST
                                                             (|devaluate| MM)
                                                             '$
                                                             (LIST '|Integer|)
                                                             (LIST '|Integer|)
                                                             (|devaluate| MM))
                                                            AM))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL B |i| |i|
                               (SPADCALL
                                (SPADCALL B |i| |i|
                                          (|compiledLookupCheck| '|elt|
                                                                 (LIST
                                                                  (|devaluate|
                                                                   MM)
                                                                  '$
                                                                  (LIST
                                                                   '|Integer|)
                                                                  (LIST
                                                                   '|Integer|))
                                                                 AM))
                                |alg|
                                (|compiledLookupCheck| '- (LIST '$ '$ '$) MM))
                               (|compiledLookupCheck| '|setelt!|
                                                      (LIST (|devaluate| MM) '$
                                                            (LIST '|Integer|)
                                                            (LIST '|Integer|)
                                                            (|devaluate| MM))
                                                      AM))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |sol| NIL)
              (SEQ (LETT |vec| NIL)
                   (LETT #2#
                         (SPADCALL
                          (SPADCALL B |m|
                                    (|compiledLookupCheck| '^
                                                           (LIST '$ '$
                                                                 (LIST
                                                                  '|NonNegativeInteger|))
                                                           AM))
                          (|compiledLookupCheck| '|nullSpace|
                                                 (LIST
                                                  (LIST '|List|
                                                        (LIST '|Vector|
                                                              (|devaluate|
                                                               MM)))
                                                  '$)
                                                 AM)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |vec| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |w| (MAKEARR1 |n| (|spadConstant| $ 29)))
                        (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                             (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |w| |i|
                                         (SPADCALL
                                          (SPADCALL |vec| |i|
                                                    (|compiledLookupCheck|
                                                     '|elt|
                                                     (LIST (|devaluate| MM) '$
                                                           (LIST '|Integer|))
                                                     (|Vector| MM)))
                                          (|compiledLookupCheck| '|coerce|
                                                                 (LIST
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (|devaluate|
                                                                    (ELT $ 6)))
                                                                  '$)
                                                                 MM))
                                         (QREFELT $ 73))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (LETT |sol| (CONS |w| |sol|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |sol|)))) 

(SDEFUN |IEP;generalizedEigenvector;UM2NniL;14|
        ((|alpha| (|Union| F (|SparseUnivariatePolynomial| F)))
         (A (|Matrix| F)) (|k| (|NonNegativeInteger|))
         (|g| (|NonNegativeInteger|))
         ($ (|List| (|Vector| (|SparseUnivariatePolynomial| F)))))
        (SPROG ((#1=#:G831 NIL) (#2=#:G830 NIL))
               (COND
                ((QEQCAR |alpha| 0)
                 (|IEP;intRatEig| (QCDR |alpha|) A
                  (PROG1 (LETT #2# (- (+ 1 |k|) |g|))
                    (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #2#))
                  $))
                ('T
                 (|IEP;intAlgEig| (QCDR |alpha|) A
                  (PROG1 (LETT #1# (- (+ 1 |k|) |g|))
                    (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #1#))
                  $))))) 

(SDEFUN |IEP;generalizedEigenvector;RML;15|
        ((|ei|
          (|Record| (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
                    (|:| |eigmult| (|NonNegativeInteger|))
                    (|:| |eigvec|
                         (|List|
                          (|Vector| (|SparseUnivariatePolynomial| F))))))
         (A (|Matrix| F))
         ($ (|List| (|Vector| (|SparseUnivariatePolynomial| F)))))
        (SPADCALL (QVELT |ei| 0) A (QVELT |ei| 1) (LENGTH (QVELT |ei| 2))
                  (QREFELT $ 35))) 

(SDEFUN |IEP;generalizedEigenvectors;MML;16|
        ((A (|Matrix| F))
         (|fac|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| F))
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|List|
           (|Record|
            (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
            (|:| |geneigvec|
                 (|List| (|Vector| (|SparseUnivariatePolynomial| F))))))))
        (SPROG
         ((#1=#:G845 NIL) (|leg| NIL) (#2=#:G844 NIL)
          (|leig|
           (|List|
            (|Record|
             (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
             (|:| |eigmult| (|NonNegativeInteger|))
             (|:| |eigvec|
                  (|List| (|Vector| (|SparseUnivariatePolynomial| F))))))))
         (SEQ (LETT |leig| (SPADCALL A |fac| (QREFELT $ 18)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |leg| NIL) (LETT #1# |leig|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |leg| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2# (CONS (|IEP;genEigForm| |leg| A $) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |IEP;eigenvectors;MML;17|
        ((A (|Matrix| F))
         (|fac|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| F))
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|List|
           (|Record|
            (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
            (|:| |eigmult| (|NonNegativeInteger|))
            (|:| |eigvec|
                 (|List| (|Vector| (|SparseUnivariatePolynomial| F))))))))
        (SPROG
         ((|algSol|
           #1=(|List|
               (|Record|
                (|:| |eigval| (|Union| F (|SparseUnivariatePolynomial| F)))
                (|:| |eigmult| (|NonNegativeInteger|))
                (|:| |eigvec|
                     (|List| (|Vector| (|SparseUnivariatePolynomial| F)))))))
          (|alpha| #2=(|SparseUnivariatePolynomial| F)) (|ratSol| #1#)
          (|vec| (F)) (|pol| #2#) (#3=#:G858 NIL) (|fact| NIL)
          (|lff|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #2#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |p| (SPADCALL A (QREFELT $ 38))) (LETT |ratSol| NIL)
              (LETT |algSol| NIL)
              (LETT |lff| (SPADCALL (SPADCALL |p| |fac|) (QREFELT $ 56)))
              (SEQ (LETT |fact| NIL) (LETT #3# |lff|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |fact| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |pol| (QVELT |fact| 1))
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |pol| (QREFELT $ 57)) 1)
                           (SEQ
                            (LETT |vec|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |pol| 0 (QREFELT $ 58))
                                             (SPADCALL |pol| (QREFELT $ 59))
                                             (QREFELT $ 60))
                                   (QREFELT $ 61)))
                            (EXIT
                             (LETT |ratSol|
                                   (CONS
                                    (VECTOR (CONS 0 |vec|) (QVELT |fact| 2)
                                            (|IEP;intRatEig| |vec| A 1 $))
                                    |ratSol|)))))
                          ('T
                           (SEQ (LETT |alpha| |pol|)
                                (EXIT
                                 (LETT |algSol|
                                       (CONS
                                        (VECTOR (CONS 1 |alpha|)
                                                (QVELT |fact| 2)
                                                (|IEP;intAlgEig| |alpha| A 1
                                                 $))
                                        |algSol|))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |ratSol| |algSol| (QREFELT $ 76)))))) 

(DECLAIM (NOTINLINE |InnerEigenPackage;|)) 

(DEFUN |InnerEigenPackage| (#1=#:G859)
  (SPROG NIL
         (PROG (#2=#:G860)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|InnerEigenPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|InnerEigenPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InnerEigenPackage|)))))))))) 

(DEFUN |InnerEigenPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|InnerEigenPackage| DV$1))
          (LETT $ (GETREFV 77))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|PolynomialFactorizationExplicit|))))))
          (|haddProp| |$ConstructorCache| '|InnerEigenPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 15
                       (CONS (|dispatchFunction| |IEP;eigenvalues;ML;1|) $))
             (QSETREFV $ 19
                       (CONS (|dispatchFunction| |IEP;eigenvectors;ML;2|) $))
             (QSETREFV $ 23
                       (CONS
                        (|dispatchFunction| |IEP;generalizedEigenvectors;ML;3|)
                        $)))))
          (COND
           ((|HasCategory| |#1| '(|FiniteFieldCategory|))
            (QSETREFV $ 38
                      (CONS
                       (|dispatchFunction|
                        |IEP;characteristicPolynomial;MSup;8|)
                       $)))
           ('T
            (QSETREFV $ 38
                      (CONS
                       (|dispatchFunction|
                        |IEP;characteristicPolynomial;MSup;9|)
                       $))))
          $))) 

(MAKEPROP '|InnerEigenPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Factored| 8)
              (|SparseUnivariatePolynomial| $) (0 . |factorPolynomial|)
              (|Union| 6 24) (|List| 10) (|Matrix| 6) (|Mapping| 55 24)
              |IEP;eigenvalues;MML;10| (5 . |eigenvalues|)
              (|Record| (|:| |eigval| 10) (|:| |eigmult| 34) (|:| |eigvec| 33))
              (|List| 16) |IEP;eigenvectors;MML;17| (10 . |eigenvectors|)
              (|Record| (|:| |eigval| 10) (|:| |geneigvec| 33)) (|List| 20)
              |IEP;generalizedEigenvectors;MML;16|
              (15 . |generalizedEigenvectors|) (|SparseUnivariatePolynomial| 6)
              (20 . |rem|) (|Boolean|) (26 . =) (32 . |Zero|) (36 . |Zero|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 30 '"failed")
              (40 . |extendedEuclidean|) (|List| 72) (|NonNegativeInteger|)
              |IEP;generalizedEigenvector;UM2NniL;14|
              (|CharacteristicPolynomial2| 6) (47 . |char_pol|)
              (52 . |characteristicPolynomial|) (57 . ~=) (63 . |One|)
              (|Matrix| 24) (67 . |zero|) (|Integer|) (73 . |elt|)
              (80 . |coerce|) (85 . |setelt!|) (93 . |elt|) (100 . |One|)
              (104 . |monomial|) (110 . -) (116 . |determinant|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 52) (|:| |factor| 24) (|:| |exponent| 34))
              (|List| 53) (|Factored| 24) (121 . |factorList|) (126 . |degree|)
              (131 . |coefficient|) (137 . |leadingCoefficient|) (142 . /)
              (148 . -) (153 . |append|) |IEP;eigenvector;UML;11|
              (159 . |zero|) (165 . |setelt!|) (173 . -) (179 . ^) (|List| 70)
              (185 . |nullSpace|) (|Vector| 6) (190 . |elt|) (|Vector| 24)
              (196 . |setelt!|) (203 . |unitCanonical|)
              |IEP;generalizedEigenvector;RML;15| (208 . |append|))
           '#(|generalizedEigenvectors| 214 |generalizedEigenvector| 225
              |eigenvectors| 239 |eigenvector| 250 |eigenvalues| 256
              |characteristicPolynomial| 267)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|characteristicPolynomial|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|Matrix| |#1|)))
                                T)
                              '((|eigenvalues|
                                 ((|List|
                                   (|Union| |#1|
                                            (|SparseUnivariatePolynomial|
                                             |#1|)))
                                  (|Matrix| |#1|)
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial| |#1|))
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T)
                              '((|eigenvector|
                                 ((|List|
                                   (|Vector|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|Union| |#1|
                                           (|SparseUnivariatePolynomial| |#1|))
                                  (|Matrix| |#1|)))
                                T)
                              '((|generalizedEigenvector|
                                 ((|List|
                                   (|Vector|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|Union| |#1|
                                           (|SparseUnivariatePolynomial| |#1|))
                                  (|Matrix| |#1|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|generalizedEigenvector|
                                 ((|List|
                                   (|Vector|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|Record|
                                   (|:| |eigval|
                                        (|Union| |#1|
                                                 (|SparseUnivariatePolynomial|
                                                  |#1|)))
                                   (|:| |eigmult| (|NonNegativeInteger|))
                                   (|:| |eigvec|
                                        (|List|
                                         (|Vector|
                                          (|SparseUnivariatePolynomial|
                                           |#1|)))))
                                  (|Matrix| |#1|)))
                                T)
                              '((|generalizedEigenvectors|
                                 ((|List|
                                   (|Record|
                                    (|:| |eigval|
                                         (|Union| |#1|
                                                  (|SparseUnivariatePolynomial|
                                                   |#1|)))
                                    (|:| |geneigvec|
                                         (|List|
                                          (|Vector|
                                           (|SparseUnivariatePolynomial|
                                            |#1|))))))
                                  (|Matrix| |#1|)
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial| |#1|))
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T)
                              '((|eigenvectors|
                                 ((|List|
                                   (|Record|
                                    (|:| |eigval|
                                         (|Union| |#1|
                                                  (|SparseUnivariatePolynomial|
                                                   |#1|)))
                                    (|:| |eigmult| (|NonNegativeInteger|))
                                    (|:| |eigvec|
                                         (|List|
                                          (|Vector|
                                           (|SparseUnivariatePolynomial|
                                            |#1|))))))
                                  (|Matrix| |#1|)
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial| |#1|))
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T)
                              '((|eigenvalues|
                                 ((|List|
                                   (|Union| |#1|
                                            (|SparseUnivariatePolynomial|
                                             |#1|)))
                                  (|Matrix| |#1|)))
                                (|has| 6 (|PolynomialFactorizationExplicit|)))
                              '((|eigenvectors|
                                 ((|List|
                                   (|Record|
                                    (|:| |eigval|
                                         (|Union| |#1|
                                                  (|SparseUnivariatePolynomial|
                                                   |#1|)))
                                    (|:| |eigmult| (|NonNegativeInteger|))
                                    (|:| |eigvec|
                                         (|List|
                                          (|Vector|
                                           (|SparseUnivariatePolynomial|
                                            |#1|))))))
                                  (|Matrix| |#1|)))
                                (|has| 6 (|PolynomialFactorizationExplicit|)))
                              '((|generalizedEigenvectors|
                                 ((|List|
                                   (|Record|
                                    (|:| |eigval|
                                         (|Union| |#1|
                                                  (|SparseUnivariatePolynomial|
                                                   |#1|)))
                                    (|:| |geneigvec|
                                         (|List|
                                          (|Vector|
                                           (|SparseUnivariatePolynomial|
                                            |#1|))))))
                                  (|Matrix| |#1|)))
                                (|has| 6 (|PolynomialFactorizationExplicit|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 76
                                            '(1 6 7 8 9 1 0 11 12 15 1 0 17 12
                                              19 1 0 21 12 23 2 24 0 0 0 25 2
                                              24 26 0 0 27 0 6 0 28 0 24 0 29 3
                                              24 31 0 0 0 32 1 36 24 12 37 1 0
                                              24 12 38 2 34 26 0 0 39 0 24 0 40
                                              2 41 0 34 34 42 3 12 6 0 43 43 44
                                              1 24 0 6 45 4 41 24 0 43 43 24 46
                                              3 41 24 0 43 43 47 0 6 0 48 2 24
                                              0 6 34 49 2 24 0 0 0 50 1 41 24 0
                                              51 1 55 54 0 56 1 24 34 0 57 2 24
                                              6 0 34 58 1 24 6 0 59 2 6 0 0 0
                                              60 1 6 0 0 61 2 11 0 0 0 62 2 12
                                              0 34 34 64 4 12 6 0 43 43 6 65 2
                                              6 0 0 0 66 2 12 0 0 34 67 1 12 68
                                              0 69 2 70 6 0 43 71 3 72 24 0 43
                                              24 73 1 24 0 0 74 2 17 0 0 0 76 1
                                              1 21 12 23 2 0 21 12 13 22 2 0 33
                                              16 12 75 4 0 33 10 12 34 34 35 1
                                              1 17 12 19 2 0 17 12 13 18 2 0 33
                                              10 12 63 1 1 11 12 15 2 0 11 12
                                              13 14 1 0 24 12 38)))))
           '|lookupComplete|)) 
