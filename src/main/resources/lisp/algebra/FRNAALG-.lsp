
(SDEFUN |FRNAALG-;min_poly_from_matrix|
        ((|mx| (|Matrix| (|Polynomial| R))) (|x| (|Matrix| (|Polynomial| R)))
         ($ (|SparseUnivariatePolynomial| (|Polynomial| R))))
        (SPROG
         ((|res| (|SparseUnivariatePolynomial| (|Polynomial| R)))
          (#1=#:G732 NIL) (|i| NIL)
          (|vectorOfCoef| (|Vector| (|Polynomial| R)))
          (|cond| (|Matrix| (|Polynomial| R))) (|k| (|PositiveInteger|)))
         (SEQ (LETT |k| 1) (LETT |cond| (SPADCALL |x| (QREFELT $ 9)))
              (SEQ G190
                   (COND
                    ((NULL (EQL (SPADCALL |cond| (QREFELT $ 13)) |k|))
                     (GO G191)))
                   (SEQ (LETT |k| (+ |k| 1))
                        (LETT |x| (SPADCALL |mx| |x| (QREFELT $ 17)))
                        (EXIT
                         (LETT |cond| (SPADCALL |cond| |x| (QREFELT $ 18)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |vectorOfCoef|
                    (|SPADfirst| (SPADCALL |cond| (QREFELT $ 20))))
              (LETT |res| (|spadConstant| $ 21))
              (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (SPADCALL
                                      (SPADCALL |vectorOfCoef| |i|
                                                (QREFELT $ 25))
                                      |i| (QREFELT $ 26))
                                     (QREFELT $ 27)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FRNAALG-;rank_polynomial|
        ((|left| (|Boolean|))
         ($ (|SparseUnivariatePolynomial| (|Polynomial| R))))
        (SPROG
         ((|cijk| (R)) (|mxjk| (|Polynomial| R)) (#1=#:G759 NIL) (|k| NIL)
          (#2=#:G758 NIL) (|j| NIL) (|mo| (|Polynomial| R)) (#3=#:G757 NIL)
          (|i| NIL) (|mx| #4=(|Matrix| (|Polynomial| R))) (|x| #4#)
          (|symbolsForCoef| (|Vector| (|Symbol|))) (#5=#:G754 NIL)
          (#6=#:G756 NIL) (#7=#:G755 NIL) (|listOfNumbers| (|List| (|String|)))
          (#8=#:G753 NIL) (|q| NIL) (#9=#:G752 NIL)
          (|gamma| (|Vector| (|Matrix| R))) (|b| (|Vector| S))
          (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 11)))
              (LETT |b| (SPADCALL (QREFELT $ 29)))
              (LETT |gamma| (SPADCALL |b| (QREFELT $ 31)))
              (LETT |listOfNumbers|
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |q| 1) (LETT #8# |n|) G190
                          (COND ((|greater_SI| |q| #8#) (GO G191)))
                          (SEQ (EXIT (LETT #9# (CONS (STRINGIMAGE |q|) #9#))))
                          (LETT |q| (|inc_SI| |q|)) (GO G190) G191
                          (EXIT (NREVERSE #9#)))))
              (LETT |symbolsForCoef|
                    (PROGN
                     (LETT #7# (GETREFV (SIZE |listOfNumbers|)))
                     (SEQ (LETT |i| NIL) (LETT #6# |listOfNumbers|)
                          (LETT #5# 0) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |i| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (SETELT #7# #5#
                                    (SPADCALL (STRCONC "%" (STRCONC "x" |i|))
                                              (QREFELT $ 34)))))
                          (LETT #5#
                                (PROG1 (|inc_SI| #5#) (LETT #6# (CDR #6#))))
                          (GO G190) G191 (EXIT NIL))
                     #7#))
              (LETT |x| (MAKE_MATRIX1 |n| 1 (|spadConstant| $ 35)))
              (LETT |mx| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 35)))
              (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |mo|
                          (SPADCALL (|spadConstant| $ 38)
                                    (LIST
                                     (SPADCALL |symbolsForCoef| |i|
                                               (QREFELT $ 40)))
                                    (LIST 1) (QREFELT $ 43)))
                    (QSETAREF2O |x| |i| 1 |mo| 1 1)
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #2# |n|) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #1# |n|) G190
                                 (COND ((|greater_SI| |k| #1#) (GO G191)))
                                 (SEQ (LETT |mxjk| (QAREF2O |mx| |j| |k| 1 1))
                                      (LETT |cijk|
                                            (COND
                                             ((OR |left| 'T)
                                              (SPADCALL
                                               (SPADCALL |gamma| |j|
                                                         (QREFELT $ 45))
                                               |i| |k| (QREFELT $ 46)))))
                                      (EXIT
                                       (QSETAREF2O |mx| |j| |k|
                                                   (SPADCALL |mxjk|
                                                             (SPADCALL |mo|
                                                                       |cijk|
                                                                       (QREFELT
                                                                        $ 47))
                                                             (QREFELT $ 48))
                                                   1 1)))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (|FRNAALG-;min_poly_from_matrix| |mx| |x| $))))) 

(SDEFUN |FRNAALG-;leftRankPolynomial;Sup;3|
        (($ (|SparseUnivariatePolynomial| (|Polynomial| R))))
        (|FRNAALG-;rank_polynomial| 'T $)) 

(SDEFUN |FRNAALG-;rightRankPolynomial;Sup;4|
        (($ (|SparseUnivariatePolynomial| (|Polynomial| R))))
        (|FRNAALG-;rank_polynomial| NIL $)) 

(SDEFUN |FRNAALG-;leftUnitsInternal|
        (($
          (|Record| (|:| |particular| (|Union| (|Vector| R) "failed"))
                    (|:| |basis| (|List| (|Vector| R))))))
        (SPROG
         ((#1=#:G776 NIL) (|j| NIL) (|addOn| (R)) (|z| (|Integer|))
          (#2=#:G775 NIL) (|i| NIL) (#3=#:G774 NIL) (|k| NIL)
          (|rhs| (|Vector| R)) (|cond| (|Matrix| R))
          (|gamma| (|Vector| (|Matrix| R))) (|b| (|Vector| S))
          (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 11)))
              (LETT |b| (SPADCALL (QREFELT $ 29)))
              (LETT |gamma| (SPADCALL |b| (QREFELT $ 31)))
              (LETT |cond|
                    (MAKE_MATRIX1 (EXPT |n| 2) |n| (|spadConstant| $ 37)))
              (LETT |rhs| (MAKEARR1 (EXPT |n| 2) (|spadConstant| $ 37)))
              (LETT |z| 0) (LETT |addOn| (|spadConstant| $ 37))
              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                          (COND ((|greater_SI| |i| #2#) (GO G191)))
                          (SEQ (LETT |z| (+ |z| 1))
                               (LETT |addOn|
                                     (COND
                                      ((EQL |k| |i|) (|spadConstant| $ 14))
                                      ('T (|spadConstant| $ 37))))
                               (SPADCALL |rhs| |z| |addOn| (QREFELT $ 52))
                               (EXIT
                                (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                                     (COND ((|greater_SI| |j| #1#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (SPADCALL |cond| |z| |j|
                                                 (SPADCALL
                                                  (SPADCALL |gamma| |k|
                                                            (QREFELT $ 45))
                                                  |j| |i| (QREFELT $ 46))
                                                 (QREFELT $ 53))))
                                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                     (EXIT NIL))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |cond| |rhs| (QREFELT $ 57)))))) 

(SDEFUN |FRNAALG-;leftUnit;U;6| (($ (|Union| S "failed")))
        (SPROG
         ((#1=#:G782 NIL)
          (|res|
           (|Record| (|:| |particular| (|Union| (|Vector| R) #2="failed"))
                     (|:| |basis| (|List| (|Vector| R))))))
         (SEQ (LETT |res| (|FRNAALG-;leftUnitsInternal| $))
              (EXIT
               (COND
                ((QEQCAR (QCAR |res|) 1)
                 (SEQ (SPADCALL "this algebra has no left unit" (QREFELT $ 60))
                      (EXIT (CONS 1 "failed"))))
                ('T
                 (CONS 0
                       (SPADCALL
                        (PROG2 (LETT #1# (QCAR |res|))
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 0)
                                          (|Vector| (QREFELT $ 7))
                                          (|Union| (|Vector| (QREFELT $ 7))
                                                   #2#)
                                          #1#))
                        (QREFELT $ 61))))))))) 

(SDEFUN |FRNAALG-;leftUnits;U;7|
        (($
          (|Union| (|Record| (|:| |particular| S) (|:| |basis| (|List| S)))
                   "failed")))
        (SPROG
         ((#1=#:G796 NIL)
          (|res|
           (|Record| (|:| |particular| (|Union| (|Vector| R) #2="failed"))
                     (|:| |basis| (|List| (|Vector| R))))))
         (SEQ (LETT |res| (|FRNAALG-;leftUnitsInternal| $))
              (EXIT
               (COND
                ((QEQCAR (QCAR |res|) 1)
                 (SEQ (SPADCALL "this algebra has no left unit" (QREFELT $ 60))
                      (EXIT (CONS 1 "failed"))))
                ('T
                 (CONS 0
                       (CONS
                        (SPADCALL
                         (PROG2 (LETT #1# (QCAR |res|))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0)
                                           (|Vector| (QREFELT $ 7))
                                           (|Union| (|Vector| (QREFELT $ 7))
                                                    #2#)
                                           #1#))
                         (QREFELT $ 61))
                        (SPADCALL (ELT $ 61) (QCDR |res|)
                                  (QREFELT $ 68)))))))))) 

(SDEFUN |FRNAALG-;rightUnitsInternal|
        (($
          (|Record| (|:| |particular| (|Union| (|Vector| R) "failed"))
                    (|:| |basis| (|List| (|Vector| R))))))
        (SPROG
         ((#1=#:G818 NIL) (|j| NIL) (|addOn| (R)) (|z| (|Integer|))
          (#2=#:G817 NIL) (|i| NIL) (#3=#:G816 NIL) (|k| NIL)
          (|rhs| (|Vector| R)) (|condo| (|Matrix| R))
          (|gamma| (|Vector| (|Matrix| R))) (|b| (|Vector| S))
          (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 11)))
              (LETT |b| (SPADCALL (QREFELT $ 29)))
              (LETT |gamma| (SPADCALL |b| (QREFELT $ 31)))
              (LETT |condo|
                    (MAKE_MATRIX1 (EXPT |n| 2) |n| (|spadConstant| $ 37)))
              (LETT |rhs| (MAKEARR1 (EXPT |n| 2) (|spadConstant| $ 37)))
              (LETT |z| 0) (LETT |addOn| (|spadConstant| $ 37))
              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                          (COND ((|greater_SI| |i| #2#) (GO G191)))
                          (SEQ (LETT |z| (+ |z| 1))
                               (LETT |addOn|
                                     (COND
                                      ((EQL |k| |i|) (|spadConstant| $ 14))
                                      ('T (|spadConstant| $ 37))))
                               (SPADCALL |rhs| |z| |addOn| (QREFELT $ 52))
                               (EXIT
                                (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                                     (COND ((|greater_SI| |j| #1#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (SPADCALL |condo| |z| |j|
                                                 (SPADCALL
                                                  (SPADCALL |gamma| |k|
                                                            (QREFELT $ 45))
                                                  |i| |j| (QREFELT $ 46))
                                                 (QREFELT $ 53))))
                                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                     (EXIT NIL))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |condo| |rhs| (QREFELT $ 57)))))) 

(SDEFUN |FRNAALG-;rightUnit;U;9| (($ (|Union| S "failed")))
        (SPROG
         ((#1=#:G824 NIL)
          (|res|
           (|Record| (|:| |particular| (|Union| (|Vector| R) #2="failed"))
                     (|:| |basis| (|List| (|Vector| R))))))
         (SEQ (LETT |res| (|FRNAALG-;rightUnitsInternal| $))
              (EXIT
               (COND
                ((QEQCAR (QCAR |res|) 1)
                 (SEQ
                  (SPADCALL "this algebra has no right unit" (QREFELT $ 60))
                  (EXIT (CONS 1 "failed"))))
                ('T
                 (CONS 0
                       (SPADCALL
                        (PROG2 (LETT #1# (QCAR |res|))
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 0)
                                          (|Vector| (QREFELT $ 7))
                                          (|Union| (|Vector| (QREFELT $ 7))
                                                   #2#)
                                          #1#))
                        (QREFELT $ 61))))))))) 

(SDEFUN |FRNAALG-;rightUnits;U;10|
        (($
          (|Union| (|Record| (|:| |particular| S) (|:| |basis| (|List| S)))
                   "failed")))
        (SPROG
         ((#1=#:G835 NIL)
          (|res|
           (|Record| (|:| |particular| (|Union| (|Vector| R) #2="failed"))
                     (|:| |basis| (|List| (|Vector| R))))))
         (SEQ (LETT |res| (|FRNAALG-;rightUnitsInternal| $))
              (EXIT
               (COND
                ((QEQCAR (QCAR |res|) 1)
                 (SEQ
                  (SPADCALL "this algebra has no right unit" (QREFELT $ 60))
                  (EXIT (CONS 1 "failed"))))
                ('T
                 (CONS 0
                       (CONS
                        (SPADCALL
                         (PROG2 (LETT #1# (QCAR |res|))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0)
                                           (|Vector| (QREFELT $ 7))
                                           (|Union| (|Vector| (QREFELT $ 7))
                                                    #2#)
                                           #1#))
                         (QREFELT $ 61))
                        (SPADCALL (ELT $ 61) (QCDR |res|)
                                  (QREFELT $ 68)))))))))) 

(SDEFUN |FRNAALG-;unit;U;11| (($ (|Union| S "failed")))
        (SPROG
         ((#1=#:G854 NIL)
          (|res|
           (|Record| (|:| |particular| (|Union| (|Vector| R) "failed"))
                     (|:| |basis| (|List| (|Vector| R)))))
          (#2=#:G861 NIL) (|j| NIL) (|addOn| (R)) (|z| (|Integer|))
          (#3=#:G860 NIL) (|i| NIL) (#4=#:G859 NIL) (|k| NIL) (|u| (|Integer|))
          (|rhs| (|Vector| R)) (|cond| (|Matrix| R))
          (|gamma| (|Vector| (|Matrix| R))) (|b| (|Vector| S))
          (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 11)))
              (LETT |b| (SPADCALL (QREFELT $ 29)))
              (LETT |gamma| (SPADCALL |b| (QREFELT $ 31)))
              (LETT |cond|
                    (MAKE_MATRIX1 (* 2 (EXPT |n| 2)) |n|
                                  (|spadConstant| $ 37)))
              (LETT |rhs| (MAKEARR1 (* 2 (EXPT |n| 2)) (|spadConstant| $ 37)))
              (LETT |z| 0) (LETT |u| (* |n| |n|))
              (LETT |addOn| (|spadConstant| $ 37))
              (SEQ (LETT |k| 1) (LETT #4# |n|) G190
                   (COND ((|greater_SI| |k| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ (LETT |z| (+ |z| 1))
                               (LETT |addOn|
                                     (COND
                                      ((EQL |k| |i|) (|spadConstant| $ 14))
                                      ('T (|spadConstant| $ 37))))
                               (SPADCALL |rhs| |z| |addOn| (QREFELT $ 52))
                               (SPADCALL |rhs| |u| |addOn| (QREFELT $ 52))
                               (EXIT
                                (SEQ (LETT |j| 1) (LETT #2# |n|) G190
                                     (COND ((|greater_SI| |j| #2#) (GO G191)))
                                     (SEQ
                                      (SPADCALL |cond| |z| |j|
                                                (SPADCALL
                                                 (SPADCALL |gamma| |k|
                                                           (QREFELT $ 45))
                                                 |j| |i| (QREFELT $ 46))
                                                (QREFELT $ 53))
                                      (EXIT
                                       (SPADCALL |cond| |u| |j|
                                                 (SPADCALL
                                                  (SPADCALL |gamma| |k|
                                                            (QREFELT $ 45))
                                                  |i| |j| (QREFELT $ 46))
                                                 (QREFELT $ 53))))
                                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                     (EXIT NIL))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (LETT |res| (SPADCALL |cond| |rhs| (QREFELT $ 57)))
              (EXIT
               (COND
                ((QEQCAR (QCAR |res|) 1)
                 (SEQ (SPADCALL "this algebra has no unit" (QREFELT $ 60))
                      (EXIT (CONS 1 "failed"))))
                ('T
                 (CONS 0
                       (SPADCALL
                        (PROG2 (LETT #1# (QCAR |res|))
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 0)
                                          (|Vector| (QREFELT $ 7))
                                          (|Union| (|Vector| (QREFELT $ 7))
                                                   "failed")
                                          #1#))
                        (QREFELT $ 61))))))))) 

(SDEFUN |FRNAALG-;apply;M2S;12| ((|m| (|Matrix| R)) (|a| (S)) ($ (S)))
        (SPROG ((|v| (|Vector| R)))
               (SEQ (LETT |v| (SPADCALL |a| (QREFELT $ 75)))
                    (LETT |v| (SPADCALL |m| |v| (QREFELT $ 76)))
                    (EXIT (SPADCALL |v| (QREFELT $ 77)))))) 

(SDEFUN |FRNAALG-;structuralConstants;V;13| (($ (|Vector| (|Matrix| R))))
        (SPADCALL (SPADCALL (QREFELT $ 29)) (QREFELT $ 31))) 

(SDEFUN |FRNAALG-;conditionsForIdempotents;L;14|
        (($ (|List| (|Polynomial| R))))
        (SPADCALL (SPADCALL (QREFELT $ 29)) (QREFELT $ 81))) 

(SDEFUN |FRNAALG-;leftTraceMatrix;M;15| (($ (|Matrix| R)))
        (SPADCALL (SPADCALL (QREFELT $ 29)) (QREFELT $ 83))) 

(SDEFUN |FRNAALG-;rightTraceMatrix;M;16| (($ (|Matrix| R)))
        (SPADCALL (SPADCALL (QREFELT $ 29)) (QREFELT $ 85))) 

(SDEFUN |FRNAALG-;leftDiscriminant;R;17| (($ (R)))
        (SPADCALL (SPADCALL (QREFELT $ 29)) (QREFELT $ 87))) 

(SDEFUN |FRNAALG-;rightDiscriminant;R;18| (($ (R)))
        (SPADCALL (SPADCALL (QREFELT $ 29)) (QREFELT $ 89))) 

(SDEFUN |FRNAALG-;leftRegularRepresentation;SM;19| ((|x| (S)) ($ (|Matrix| R)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 29)) (QREFELT $ 91))) 

(SDEFUN |FRNAALG-;rightRegularRepresentation;SM;20|
        ((|x| (S)) ($ (|Matrix| R)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 29)) (QREFELT $ 93))) 

(SDEFUN |FRNAALG-;coordinates;SV;21| ((|x| (S)) ($ (|Vector| R)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 29)) (QREFELT $ 95))) 

(SDEFUN |FRNAALG-;represents;VS;22| ((|v| (|Vector| R)) ($ (S)))
        (SPADCALL |v| (SPADCALL (QREFELT $ 29)) (QREFELT $ 97))) 

(DECLAIM (NOTINLINE |FramedNonAssociativeAlgebra&;|)) 

(DEFUN |FramedNonAssociativeAlgebra&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FramedNonAssociativeAlgebra&| DV$1 DV$2))
          (LETT $ (GETREFV 99))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Field|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 49
                       (CONS
                        (|dispatchFunction|
                         |FRNAALG-;leftRankPolynomial;Sup;3|)
                        $))
             (QSETREFV $ 50
                       (CONS
                        (|dispatchFunction|
                         |FRNAALG-;rightRankPolynomial;Sup;4|)
                        $))
             NIL
             (QSETREFV $ 63
                       (CONS (|dispatchFunction| |FRNAALG-;leftUnit;U;6|) $))
             (QSETREFV $ 71
                       (CONS (|dispatchFunction| |FRNAALG-;leftUnits;U;7|) $))
             NIL
             (QSETREFV $ 72
                       (CONS (|dispatchFunction| |FRNAALG-;rightUnit;U;9|) $))
             (QSETREFV $ 73
                       (CONS (|dispatchFunction| |FRNAALG-;rightUnits;U;10|)
                             $))
             (QSETREFV $ 74
                       (CONS (|dispatchFunction| |FRNAALG-;unit;U;11|) $)))))
          $))) 

(MAKEPROP '|FramedNonAssociativeAlgebra&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Matrix| 22) (0 . |copy|) (|PositiveInteger|) (5 . |rank|)
              (|NonNegativeInteger|) (9 . |rank|) (14 . |One|)
              (|SparseUnivariatePolynomial| 22) (18 . |One|) (22 . *)
              (28 . |horizConcat|) (|List| 24) (34 . |nullSpace|) (39 . |Zero|)
              (|Polynomial| 7) (|Integer|) (|Vector| 22) (43 . |elt|)
              (49 . |monomial|) (55 . +) (|Vector| $) (61 . |basis|)
              (|Vector| 44) (65 . |structuralConstants|) (|String|) (|Symbol|)
              (70 . |coerce|) (75 . |Zero|) (79 . |Zero|) (83 . |Zero|)
              (87 . |One|) (|Vector| 33) (91 . |elt|) (|List| 33) (|List| 12)
              (97 . |monomial|) (|Matrix| 7) (104 . |elt|) (110 . |elt|)
              (117 . *) (123 . +) (129 . |leftRankPolynomial|)
              (133 . |rightRankPolynomial|) (|Vector| 7) (137 . |setelt!|)
              (144 . |setelt!|) (|Union| 51 '"failed")
              (|Record| (|:| |particular| 54) (|:| |basis| 66))
              (|LinearSystemMatrixPackage| 7 51 51 44) (152 . |solve|) (|Void|)
              (|OutputForm|) (158 . |messagePrint|) (163 . |represents|)
              (|Union| $ '#1="failed") (168 . |leftUnit|) (|List| 6)
              (|Mapping| 6 51) (|List| 51) (|ListFunctions2| 51 6)
              (172 . |map|)
              (|Record| (|:| |particular| $) (|:| |basis| (|List| $)))
              (|Union| 69 '#1#) (178 . |leftUnits|) (182 . |rightUnit|)
              (186 . |rightUnits|) (190 . |unit|) (194 . |coordinates|)
              (199 . *) (205 . |convert|) |FRNAALG-;apply;M2S;12|
              |FRNAALG-;structuralConstants;V;13| (|List| 22)
              (210 . |conditionsForIdempotents|)
              |FRNAALG-;conditionsForIdempotents;L;14|
              (215 . |leftTraceMatrix|) |FRNAALG-;leftTraceMatrix;M;15|
              (220 . |rightTraceMatrix|) |FRNAALG-;rightTraceMatrix;M;16|
              (225 . |leftDiscriminant|) |FRNAALG-;leftDiscriminant;R;17|
              (230 . |rightDiscriminant|) |FRNAALG-;rightDiscriminant;R;18|
              (235 . |leftRegularRepresentation|)
              |FRNAALG-;leftRegularRepresentation;SM;19|
              (241 . |rightRegularRepresentation|)
              |FRNAALG-;rightRegularRepresentation;SM;20| (247 . |coordinates|)
              |FRNAALG-;coordinates;SV;21| (253 . |represents|)
              |FRNAALG-;represents;VS;22|)
           '#(|unit| 259 |structuralConstants| 263 |rightUnits| 267 |rightUnit|
              271 |rightTraceMatrix| 275 |rightRegularRepresentation| 279
              |rightRankPolynomial| 284 |rightDiscriminant| 288 |represents|
              292 |leftUnits| 297 |leftUnit| 301 |leftTraceMatrix| 305
              |leftRegularRepresentation| 309 |leftRankPolynomial| 314
              |leftDiscriminant| 318 |coordinates| 322
              |conditionsForIdempotents| 327 |apply| 331)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|apply| (|#1| (|Matrix| |#2|) |#1|)) T)
                                   '((|rightRankPolynomial|
                                      ((|SparseUnivariatePolynomial|
                                        (|Polynomial| |#2|))))
                                     T)
                                   '((|leftRankPolynomial|
                                      ((|SparseUnivariatePolynomial|
                                        (|Polynomial| |#2|))))
                                     T)
                                   '((|rightRegularRepresentation|
                                      ((|Matrix| |#2|) |#1|))
                                     T)
                                   '((|leftRegularRepresentation|
                                      ((|Matrix| |#2|) |#1|))
                                     T)
                                   '((|rightTraceMatrix| ((|Matrix| |#2|))) T)
                                   '((|leftTraceMatrix| ((|Matrix| |#2|))) T)
                                   '((|rightDiscriminant| (|#2|)) T)
                                   '((|leftDiscriminant| (|#2|)) T)
                                   '((|conditionsForIdempotents|
                                      ((|List| (|Polynomial| |#2|))))
                                     T)
                                   '((|structuralConstants|
                                      ((|Vector| (|Matrix| |#2|))))
                                     T)
                                   '((|coordinates| ((|Vector| |#2|) |#1|)) T)
                                   '((|coordinates|
                                      ((|Matrix| |#2|) (|Vector| |#1|)))
                                     T)
                                   '((|represents| (|#1| (|Vector| |#2|))) T)
                                   '((|unit| ((|Union| |#1| #1#))) T)
                                   '((|rightUnit| ((|Union| |#1| #1#))) T)
                                   '((|leftUnit| ((|Union| |#1| #1#))) T)
                                   '((|rightUnits|
                                      ((|Union|
                                        (|Record| (|:| |particular| |#1|)
                                                  (|:| |basis| (|List| |#1|)))
                                        #1#)))
                                     T)
                                   '((|leftUnits|
                                      ((|Union|
                                        (|Record| (|:| |particular| |#1|)
                                                  (|:| |basis| (|List| |#1|)))
                                        #1#)))
                                     T)
                                   '((|rightTraceMatrix|
                                      ((|Matrix| |#2|) (|Vector| |#1|)))
                                     T)
                                   '((|leftTraceMatrix|
                                      ((|Matrix| |#2|) (|Vector| |#1|)))
                                     T)
                                   '((|rightDiscriminant|
                                      (|#2| (|Vector| |#1|)))
                                     T)
                                   '((|leftDiscriminant|
                                      (|#2| (|Vector| |#1|)))
                                     T)
                                   '((|represents|
                                      (|#1| (|Vector| |#2|) (|Vector| |#1|)))
                                     T)
                                   '((|coordinates|
                                      ((|Matrix| |#2|) (|Vector| |#1|)
                                       (|Vector| |#1|)))
                                     T)
                                   '((|coordinates|
                                      ((|Vector| |#2|) |#1| (|Vector| |#1|)))
                                     T)
                                   '((|rightRegularRepresentation|
                                      ((|Matrix| |#2|) |#1| (|Vector| |#1|)))
                                     T)
                                   '((|leftRegularRepresentation|
                                      ((|Matrix| |#2|) |#1| (|Vector| |#1|)))
                                     T)
                                   '((|structuralConstants|
                                      ((|Vector| (|Matrix| |#2|))
                                       (|Vector| |#1|)))
                                     T)
                                   '((|conditionsForIdempotents|
                                      ((|List| (|Polynomial| |#2|))
                                       (|Vector| |#1|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 98
                                            '(1 8 0 0 9 0 6 10 11 1 8 12 0 13 0
                                              7 0 14 0 15 0 16 2 8 0 0 0 17 2 8
                                              0 0 0 18 1 8 19 0 20 0 15 0 21 2
                                              24 22 0 23 25 2 15 0 22 12 26 2
                                              15 0 0 0 27 0 6 28 29 1 6 30 28
                                              31 1 33 0 32 34 0 22 0 35 0 6 0
                                              36 0 7 0 37 0 22 0 38 2 39 33 0
                                              23 40 3 22 0 0 41 42 43 2 30 44 0
                                              23 45 3 44 7 0 23 23 46 2 22 0 0
                                              7 47 2 22 0 0 0 48 0 0 15 49 0 0
                                              15 50 3 51 7 0 23 7 52 4 44 7 0
                                              23 23 7 53 2 56 55 44 51 57 1 59
                                              58 32 60 1 6 0 51 61 0 0 62 63 2
                                              67 64 65 66 68 0 0 70 71 0 0 62
                                              72 0 0 70 73 0 0 62 74 1 6 51 0
                                              75 2 44 51 0 51 76 1 6 0 51 77 1
                                              6 80 28 81 1 6 44 28 83 1 6 44 28
                                              85 1 6 7 28 87 1 6 7 28 89 2 6 44
                                              0 28 91 2 6 44 0 28 93 2 6 51 0
                                              28 95 2 6 0 51 28 97 0 0 62 74 0
                                              0 30 79 0 0 70 73 0 0 62 72 0 0
                                              44 86 1 0 44 0 94 0 0 15 50 0 0 7
                                              90 1 0 0 51 98 0 0 70 71 0 0 62
                                              63 0 0 44 84 1 0 44 0 92 0 0 15
                                              49 0 0 7 88 1 0 51 0 96 0 0 80 82
                                              2 0 0 44 0 78)))))
           '|lookupComplete|)) 
