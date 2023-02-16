
(SDEFUN |WFFINTBS;listSquaredFactors| ((|px| (R)) ($ (|List| R)))
        (SPROG
         ((|ans| (|List| R)) (#1=#:G721 NIL) (|f| NIL)
          (|factored| (|Factored| R)))
         (SEQ (LETT |ans| NIL) (LETT |factored| (SPADCALL |px| (QREFELT $ 12)))
              (SEQ (LETT |f| NIL)
                   (LETT #1# (SPADCALL |factored| (QREFELT $ 16))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (QVELT |f| 2) 1)
                       (LETT |ans| (CONS (QVELT |f| 1) |ans|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |WFFINTBS;iLocalIntegralBasis|
        ((|bas| (|Vector| F)) (|pows| (|Vector| F)) (|tfm| (|Matrix| R))
         (|matrixOut| (|Matrix| R)) (|disc| (R)) (|prime| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)) (|:| |discr| R))))
        (SPROG
         ((#1=#:G767 NIL) (#2=#:G768 NIL) (|oldIndex| (R)) (|indexChange| (R))
          (|rbinv| #3=(|Matrix| R)) (|rbden| (R)) (|rb| #3#) (|index| (R))
          (|idinv| (|Matrix| R)) (|id| (|Matrix| R)) (#4=#:G777 NIL) (|j| NIL)
          (#5=#:G776 NIL) (|vec| NIL) (|i| NIL) (#6=#:G775 NIL) (#7=#:G774 NIL)
          (|ns| (|List| (|Vector| |sae|))) (|frobPow| (|Matrix| |sae|))
          (#8=#:G773 NIL) (#9=#:G772 NIL) (#10=#:G771 NIL) (|r| NIL)
          (|tmpMat| (|Matrix| |sae|)) (|frob| (|Matrix| |sae|))
          (|pPows| (|Matrix| |sae|)) (|coMat| (|Matrix| R))
          (|coMat0| (|Union| (|Matrix| R) "failed")) (|denPow| (R))
          (#11=#:G737 NIL) (|coor0| (|Matrix| R)) (|bi| (F)) (#12=#:G770 NIL)
          (#13=#:G769 NIL) (|lp| (|NonNegativeInteger|))
          (|q| (|NonNegativeInteger|)) (|p| (|NonNegativeInteger|))
          (|sae|
           (|Join| (|MonogenicAlgebra| K R)
                   (CATEGORY |package|
                    (IF (|has| K (|Field|))
                        (IF (|has| K (|PolynomialFactorizationExplicit|))
                            (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                            |noBranch|)
                        |noBranch|))))
          (|p2| (R)) (|standardBasis| (|Vector| F)) (|n| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL (QREFELT $ 19)))
                (LETT |standardBasis| (SPADCALL (QREFELT $ 21)))
                (LETT |p2| (SPADCALL |prime| |prime| (QREFELT $ 22)))
                (LETT |sae|
                      (|SimpleAlgebraicExtension| (QREFELT $ 6) (QREFELT $ 7)
                                                  |prime|))
                (LETT |p| (SPADCALL (QREFELT $ 24)))
                (LETT |q|
                      (SPADCALL
                       (|compiledLookupCheck| '|size|
                                              (LIST
                                               (LIST '|NonNegativeInteger|))
                                              |sae|)))
                (LETT |lp| (SPADCALL |q| |n| (QREFELT $ 26)))
                (LETT |rb| (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29)))
                (LETT |rbinv|
                      (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29)))
                (LETT |rbden| (|spadConstant| $ 27))
                (LETT |index| (|spadConstant| $ 27))
                (LETT |oldIndex| (|spadConstant| $ 27))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (SEQ (LETT |i| 1) (LETT #13# |n|) G190
                            (COND ((|greater_SI| |i| #13#) (GO G191)))
                            (SEQ (LETT |bi| (|spadConstant| $ 30))
                                 (SEQ (LETT |j| 1) (LETT #12# |n|) G190
                                      (COND
                                       ((|greater_SI| |j| #12#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT |bi|
                                              (SPADCALL |bi|
                                                        (SPADCALL
                                                         (QAREF2O |rb| |i| |j|
                                                                  1 1)
                                                         (QAREF1O
                                                          |standardBasis| |j|
                                                          1)
                                                         (QREFELT $ 31))
                                                        (QREFELT $ 32)))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (QSETAREF1O |bas| |i| |bi| 1)
                                 (EXIT
                                  (QSETAREF1O |pows| |i|
                                              (SPADCALL |bi| |p|
                                                        (QREFELT $ 33))
                                              1)))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |coor0|
                             (SPADCALL (SPADCALL |pows| |bas| (QREFELT $ 34))
                                       (QREFELT $ 35)))
                       (LETT |denPow|
                             (SPADCALL |rbden|
                                       (PROG1 (LETT #11# (- |p| 1))
                                         (|check_subtype2| (>= #11# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #11#))
                                       (QREFELT $ 36)))
                       (LETT |coMat0|
                             (SPADCALL |coor0| |denPow| (QREFELT $ 38)))
                       (EXIT
                        (COND ((QEQCAR |coMat0| 1) (|error| "can't happen"))
                              ('T
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |coMat| (QCDR |coMat0|))
                                      (LETT |pPows|
                                            (SPADCALL
                                             (|compiledLookupCheck| '|reduce|
                                                                    (LIST '$
                                                                          (|devaluate|
                                                                           (ELT
                                                                            $
                                                                            7)))
                                                                    |sae|)
                                             |coMat|
                                             (|compiledLookupCheck| '|map|
                                                                    (LIST
                                                                     (LIST
                                                                      '|Matrix|
                                                                      (|devaluate|
                                                                       |sae|))
                                                                     (LIST
                                                                      '|Mapping|
                                                                      (|devaluate|
                                                                       |sae|)
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7)))
                                                                     (LIST
                                                                      '|Matrix|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7))))
                                                                    (|MatrixCategoryFunctions2|
                                                                     (ELT $ 7)
                                                                     (|Vector|
                                                                      (ELT $
                                                                           7))
                                                                     (|Vector|
                                                                      (ELT $
                                                                           7))
                                                                     (|Matrix|
                                                                      (ELT $
                                                                           7))
                                                                     |sae|
                                                                     (|Vector|
                                                                      |sae|)
                                                                     (|Vector|
                                                                      |sae|)
                                                                     (|Matrix|
                                                                      |sae|)))))
                                      (LETT |frob|
                                            (SPADCALL |pPows|
                                                      (|compiledLookupCheck|
                                                       '|copy| (LIST '$ '$)
                                                       (|Matrix| |sae|))))
                                      (LETT |tmpMat|
                                            (MAKE_MATRIX1 |n| |n|
                                                          (SPADCALL
                                                           (|compiledLookupCheck|
                                                            '|Zero| (LIST '$)
                                                            |sae|))))
                                      (SEQ (LETT |r| 2)
                                           (LETT #10#
                                                 (SPADCALL |p| |q|
                                                           (QREFELT $ 26)))
                                           G190
                                           (COND
                                            ((|greater_SI| |r| #10#)
                                             (GO G191)))
                                           (SEQ
                                            (SEQ (LETT |i| 1) (LETT #9# |n|)
                                                 G190
                                                 (COND
                                                  ((|greater_SI| |i| #9#)
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (SEQ (LETT |j| 1)
                                                        (LETT #8# |n|) G190
                                                        (COND
                                                         ((|greater_SI| |j|
                                                                        #8#)
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (QSETAREF2O |tmpMat|
                                                                      |i| |j|
                                                                      (SPADCALL
                                                                       (QAREF2O
                                                                        |frob|
                                                                        |i| |j|
                                                                        1 1)
                                                                       |p|
                                                                       (|compiledLookupCheck|
                                                                        '^
                                                                        (LIST
                                                                         '$ '$
                                                                         (LIST
                                                                          '|Integer|))
                                                                        |sae|))
                                                                      1 1)))
                                                        (LETT |j|
                                                              (|inc_SI| |j|))
                                                        (GO G190) G191
                                                        (EXIT NIL))))
                                                 (LETT |i| (|inc_SI| |i|))
                                                 (GO G190) G191 (EXIT NIL))
                                            (EXIT
                                             (SPADCALL |frob| |pPows| |tmpMat|
                                                       (|compiledLookupCheck|
                                                        '|times!|
                                                        (LIST
                                                         (LIST '|Matrix|
                                                               (|devaluate|
                                                                |sae|))
                                                         (LIST '|Matrix|
                                                               (|devaluate|
                                                                |sae|))
                                                         (LIST '|Matrix|
                                                               (|devaluate|
                                                                |sae|))
                                                         (LIST '|Matrix|
                                                               (|devaluate|
                                                                |sae|)))
                                                        (|StorageEfficientMatrixOperations|
                                                         |sae|)))))
                                           (LETT |r| (|inc_SI| |r|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (LETT |frobPow|
                                            (SPADCALL |frob| |lp|
                                                      (|compiledLookupCheck| '^
                                                                             (LIST
                                                                              '$
                                                                              '$
                                                                              (LIST
                                                                               '|NonNegativeInteger|))
                                                                             (|Matrix|
                                                                              |sae|))))
                                      (LETT |ns|
                                            (SPADCALL |frobPow|
                                                      (|compiledLookupCheck|
                                                       '|nullSpace|
                                                       (LIST
                                                        (LIST '|List|
                                                              (LIST '|Vector|
                                                                    (|devaluate|
                                                                     |sae|)))
                                                        '$)
                                                       (|Matrix| |sae|))))
                                      (SEQ (LETT |i| 1) (LETT #7# |n|) G190
                                           (COND
                                            ((|greater_SI| |i| #7#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (SEQ (LETT |j| 1) (LETT #6# |n|)
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |j| #6#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (QSETAREF2O |tfm| |i| |j|
                                                                (|spadConstant|
                                                                 $ 40)
                                                                1 1)))
                                                  (LETT |j| (|inc_SI| |j|))
                                                  (GO G190) G191 (EXIT NIL))))
                                           (LETT |i| (|inc_SI| |i|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (SEQ (LETT |i| 1) (LETT |vec| NIL)
                                           (LETT #5# |ns|) G190
                                           (COND
                                            ((OR (ATOM #5#)
                                                 (PROGN
                                                  (LETT |vec| (CAR #5#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (SEQ (LETT |j| 1) (LETT #4# |n|)
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |j| #4#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (QSETAREF2O |tfm| |i| |j|
                                                                (SPADCALL
                                                                 (QAREF1O |vec|
                                                                          |j|
                                                                          1)
                                                                 (|compiledLookupCheck|
                                                                  '|lift|
                                                                  (LIST
                                                                   (|devaluate|
                                                                    (ELT $ 7))
                                                                   '$)
                                                                  |sae|))
                                                                1 1)))
                                                  (LETT |j| (|inc_SI| |j|))
                                                  (GO G190) G191 (EXIT NIL))))
                                           (LETT #5#
                                                 (PROG1 (CDR #5#)
                                                   (LETT |i| (|inc_SI| |i|))))
                                           (GO G190) G191 (EXIT NIL))
                                      (LETT |id|
                                            (SPADCALL
                                             (SPADCALL |tfm| |prime|
                                                       (QREFELT $ 42))
                                             (QREFELT $ 43)))
                                      (LETT |idinv|
                                            (SPADCALL |id| |prime|
                                                      (QREFELT $ 45)))
                                      (LETT |rbinv|
                                            (SPADCALL
                                             (SPADCALL |id| |rb|
                                                       (QREFELT $ 46))
                                             (SPADCALL |rbinv| |idinv|
                                                       (QREFELT $ 46))
                                             (SPADCALL |prime| |rbden|
                                                       (QREFELT $ 22))
                                             (QREFELT $ 47)))
                                      (LETT |index|
                                            (SPADCALL |rbinv| (QREFELT $ 48)))
                                      (LETT |rb|
                                            (SPADCALL
                                             (SPADCALL |rbinv|
                                                       (SPADCALL |rbden|
                                                                 |prime|
                                                                 (QREFELT $
                                                                          22))
                                                       (QREFELT $ 49))
                                             (QREFELT $ 50)))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |rb| |matrixOut| |prime| |n|
                                                   (QREFELT $ 52))
                                         (|spadConstant| $ 27) (QREFELT $ 54))
                                        (LETT |rb| |matrixOut|))
                                       ('T
                                        (LETT |rbden|
                                              (SPADCALL |rbden| |prime|
                                                        (QREFELT $ 22)))))
                                      (LETT |rbinv|
                                            (SPADCALL |rb| |rbden|
                                                      (QREFELT $ 45)))
                                      (LETT |indexChange|
                                            (SPADCALL |index| |oldIndex|
                                                      (QREFELT $ 55)))
                                      (LETT |oldIndex| |index|)
                                      (LETT |disc|
                                            (SPADCALL |disc|
                                                      (SPADCALL |indexChange|
                                                                |indexChange|
                                                                (QREFELT $ 22))
                                                      (QREFELT $ 55)))
                                      (EXIT
                                       (COND
                                        ((SPADCALL (|spadConstant| $ 27)
                                                   |indexChange|
                                                   (QREFELT $ 56))
                                         (COND
                                          ((QEQCAR
                                            (SPADCALL |disc| |p2|
                                                      (QREFELT $ 57))
                                            1)
                                           (PROGN
                                            (LETT #1#
                                                  (PROGN
                                                   (LETT #2#
                                                         (VECTOR |rb| |rbden|
                                                                 |rbinv|
                                                                 |disc|))
                                                   (GO #14=#:G766)))
                                            (GO #15=#:G762)))))
                                        ('T
                                         (PROGN
                                          (LETT #1#
                                                (PROGN
                                                 (LETT #2#
                                                       (VECTOR |rb| |rbden|
                                                               |rbinv| |disc|))
                                                 (GO #14#)))
                                          (GO #15#)))))))
                                #15# (EXIT #1#))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #14# (EXIT #2#)))) 

(SDEFUN |WFFINTBS;integralBasis;R;3|
        (($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|runningRbinv| #1=(|Matrix| R)) (|runningRb| #1#)
          (|runningRbden| (R)) (|mat| (|Matrix| R)) (|disc| (R)) (|rbden| (R))
          (|rb| #2=(|Matrix| R))
          (|lb|
           (|Record| (|:| |basis| #2#) (|:| |basisDen| R)
                     (|:| |basisInv| (|Matrix| R)) (|:| |discr| R)))
          (#3=#:G789 NIL) (|prime| NIL) (|matrixOut| #4=(|Matrix| R))
          (|tfm| #4#) (|pows| #5=(|Vector| F)) (|bas| #5#)
          (|singList| (|List| R)) (|n| (|PositiveInteger|))
          (|traceMat| (|Matrix| R)))
         (SEQ (LETT |traceMat| (SPADCALL (QREFELT $ 58)))
              (LETT |n| (SPADCALL (QREFELT $ 19)))
              (LETT |disc| (SPADCALL |traceMat| (QREFELT $ 59)))
              (EXIT
               (COND
                ((SPADCALL |disc| (QREFELT $ 60))
                 (|error| "integralBasis: polynomial must be separable"))
                (#6='T
                 (SEQ
                  (LETT |singList| (|WFFINTBS;listSquaredFactors| |disc| $))
                  (LETT |runningRb|
                        (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29)))
                  (LETT |runningRbinv|
                        (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29)))
                  (LETT |runningRbden| (|spadConstant| $ 27))
                  (EXIT
                   (COND
                    ((NULL |singList|)
                     (VECTOR |runningRb| |runningRbden| |runningRbinv|))
                    (#6#
                     (SEQ (LETT |bas| (MAKEARR1 |n| (|spadConstant| $ 30)))
                          (LETT |pows| (MAKEARR1 |n| (|spadConstant| $ 30)))
                          (LETT |tfm|
                                (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 40)))
                          (LETT |matrixOut|
                                (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 40)))
                          (SEQ (LETT |prime| NIL) (LETT #3# |singList|) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |prime| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (LETT |lb|
                                      (|WFFINTBS;iLocalIntegralBasis| |bas|
                                       |pows| |tfm| |matrixOut| |disc| |prime|
                                       $))
                                (LETT |rb| (QVELT |lb| 0))
                                (LETT |rbden| (QVELT |lb| 1))
                                (LETT |disc| (QVELT |lb| 3))
                                (EXIT
                                 (COND
                                  ((SPADCALL (|spadConstant| $ 27) |rbden|
                                             (QREFELT $ 56))
                                   (SEQ
                                    (LETT |mat|
                                          (SPADCALL
                                           (SPADCALL |rbden| |runningRb|
                                                     (QREFELT $ 61))
                                           (SPADCALL |runningRbden| |rb|
                                                     (QREFELT $ 61))
                                           (QREFELT $ 62)))
                                    (LETT |runningRbden|
                                          (SPADCALL |runningRbden| |rbden|
                                                    (QREFELT $ 22)))
                                    (LETT |runningRb|
                                          (SPADCALL
                                           (SPADCALL |mat| |runningRbden|
                                                     (QREFELT $ 42))
                                           (QREFELT $ 43)))
                                    (EXIT
                                     (LETT |runningRbinv|
                                           (SPADCALL |runningRb| |runningRbden|
                                                     (QREFELT $ 45)))))))))
                               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (VECTOR |runningRb| |runningRbden|
                                   |runningRbinv|))))))))))))) 

(SDEFUN |WFFINTBS;localIntegralBasis;RR;4|
        ((|prime| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|lb|
           (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                     (|:| |basisInv| (|Matrix| R)) (|:| |discr| R)))
          (|matrixOut| #1=(|Matrix| R)) (|tfm| #1#) (|pows| #2=(|Vector| F))
          (|bas| #2#) (|disc| (R)) (|n| (|PositiveInteger|))
          (|traceMat| (|Matrix| R)))
         (SEQ (LETT |traceMat| (SPADCALL (QREFELT $ 58)))
              (LETT |n| (SPADCALL (QREFELT $ 19)))
              (LETT |disc| (SPADCALL |traceMat| (QREFELT $ 59)))
              (EXIT
               (COND
                ((SPADCALL |disc| (QREFELT $ 60))
                 (|error| "localIntegralBasis: polynomial must be separable"))
                ((QEQCAR
                  (SPADCALL |disc| (SPADCALL |prime| |prime| (QREFELT $ 22))
                            (QREFELT $ 57))
                  1)
                 (VECTOR (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29))
                         (|spadConstant| $ 27)
                         (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29))))
                ('T
                 (SEQ (LETT |bas| (MAKEARR1 |n| (|spadConstant| $ 30)))
                      (LETT |pows| (MAKEARR1 |n| (|spadConstant| $ 30)))
                      (LETT |tfm| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 40)))
                      (LETT |matrixOut|
                            (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 40)))
                      (LETT |lb|
                            (|WFFINTBS;iLocalIntegralBasis| |bas| |pows| |tfm|
                             |matrixOut| |disc| |prime| $))
                      (EXIT
                       (VECTOR (QVELT |lb| 0) (QVELT |lb| 1)
                               (QVELT |lb| 2)))))))))) 

(DECLAIM (NOTINLINE |WildFunctionFieldIntegralBasis;|)) 

(DEFUN |WildFunctionFieldIntegralBasis| (&REST #1=#:G803)
  (SPROG NIL
         (PROG (#2=#:G804)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|WildFunctionFieldIntegralBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |WildFunctionFieldIntegralBasis;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|WildFunctionFieldIntegralBasis|)))))))))) 

(DEFUN |WildFunctionFieldIntegralBasis;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|WildFunctionFieldIntegralBasis| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 66))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|WildFunctionFieldIntegralBasis|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|WildFunctionFieldIntegralBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Factored| 7)
              (|DistinctDegreeFactorize| 6 7) (0 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 13) (|:| |factor| 7) (|:| |exponent| 23))
              (|List| 14) (5 . |factorList|) (10 . |One|) (|PositiveInteger|)
              (14 . |rank|) (|Vector| $) (18 . |basis|) (22 . *)
              (|NonNegativeInteger|) (28 . |characteristic|)
              (|IntegralBasisTools| 7 8 9) (32 . |leastPower|) (38 . |One|)
              (|Matrix| 7) (42 . |scalarMatrix|) (48 . |Zero|) (52 . *)
              (58 . +) (64 . ^) (70 . |coordinates|) (76 . |transpose|)
              (81 . ^) (|Union| $ '"failed") (87 . |exquo|) (93 . |Zero|)
              (97 . |Zero|) (|ModularHermitianRowReduction| 7)
              (101 . |rowEchelon|) (107 . |squareTop|)
              (|TriangularMatrixOperations| 7 (|Vector| 7) (|Vector| 7) 28)
              (112 . |UpTriBddDenomInv|) (118 . *) (124 . |idealiser|)
              (131 . |diagonalProduct|) (136 . |LowTriBddDenomInv|)
              (142 . |rowEchelon|) (|Integer|) (147 . |divideIfCan!|)
              (|Boolean|) (155 . =) (161 . |quo|) (167 . |sizeLess?|)
              (173 . |exquo|) (179 . |traceMatrix|) (183 . |determinant|)
              (188 . |zero?|) (193 . *) (199 . |vertConcat|)
              (|Record| (|:| |basis| 28) (|:| |basisDen| 7)
                        (|:| |basisInv| 28))
              |WFFINTBS;integralBasis;R;3| |WFFINTBS;localIntegralBasis;RR;4|)
           '#(|localIntegralBasis| 205 |integralBasis| 210) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|integralBasis|
                                 ((|Record| (|:| |basis| (|Matrix| |#2|))
                                            (|:| |basisDen| |#2|)
                                            (|:| |basisInv| (|Matrix| |#2|)))))
                                T)
                              '((|localIntegralBasis|
                                 ((|Record| (|:| |basis| (|Matrix| |#2|))
                                            (|:| |basisDen| |#2|)
                                            (|:| |basisInv| (|Matrix| |#2|)))
                                  |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 65
                                            '(1 11 10 7 12 1 10 15 0 16 0 6 0
                                              17 0 9 18 19 0 9 20 21 2 7 0 0 0
                                              22 0 9 23 24 2 25 23 23 23 26 0 7
                                              0 27 2 28 0 23 7 29 0 9 0 30 2 9
                                              0 7 0 31 2 9 0 0 0 32 2 9 0 0 23
                                              33 2 9 28 20 20 34 1 28 0 0 35 2
                                              7 0 0 23 36 2 28 37 0 7 38 0 6 0
                                              39 0 7 0 40 2 41 28 28 7 42 1 28
                                              0 0 43 2 44 28 28 7 45 2 28 0 0 0
                                              46 3 25 28 28 28 7 47 1 25 7 28
                                              48 2 44 28 28 7 49 1 28 0 0 50 4
                                              25 7 28 28 7 51 52 2 7 53 0 0 54
                                              2 7 0 0 0 55 2 7 53 0 0 56 2 7 37
                                              0 0 57 0 9 28 58 1 28 7 0 59 1 7
                                              53 0 60 2 28 0 7 0 61 2 28 0 0 0
                                              62 1 0 63 7 65 0 0 63 64)))))
           '|lookupComplete|)) 
