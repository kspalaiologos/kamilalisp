
(SDEFUN |GCNAALG;eval|
        ((|rf| (|Fraction| (|Polynomial| R))) (|a| ($))
         ($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((|bot| #1=(|Polynomial| R)) (|top| #1#)
          (|lEq| (|List| (|Equation| (|Polynomial| R)))) (#2=#:G742 NIL)
          (|i| NIL) (#3=#:G741 NIL) (|s| NIL) (#4=#:G740 NIL)
          (|coefOfa| (|List| (|Polynomial| R))))
         (SEQ
          (LETT |coefOfa|
                (SPADCALL (ELT $ 36)
                          (SPADCALL (SPADCALL |a| (QREFELT $ 37))
                                    (QREFELT $ 39))
                          (QREFELT $ 43)))
          (SETELT $ 8
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |s| NIL)
                        (LETT #3# (SPADCALL (QREFELT $ 18) (QREFELT $ 44)))
                        G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #4#
                                (CONS
                                 (SPADCALL (|spadConstant| $ 20) (LIST |s|)
                                           (LIST 1) (QREFELT $ 26))
                                 #4#))))
                        (LETT #3# (CDR #3#)) (GO G190) G191
                        (EXIT (NREVERSE #4#)))))
          (LETT |lEq| NIL)
          (SEQ (LETT |i| 1) (LETT #2# (LENGTH (QREFELT $ 8))) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (LETT |lEq|
                       (CONS
                        (SPADCALL (SPADCALL (QREFELT $ 8) |i| (QREFELT $ 45))
                                  (SPADCALL |coefOfa| |i| (QREFELT $ 45))
                                  (QREFELT $ 47))
                        |lEq|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |top|
                (SPADCALL (SPADCALL |rf| (QREFELT $ 36)) |lEq| (QREFELT $ 49)))
          (LETT |bot|
                (SPADCALL (SPADCALL |rf| (QREFELT $ 36)) |lEq| (QREFELT $ 49)))
          (EXIT (SPADCALL |top| |bot| (QREFELT $ 50)))))) 

(SDEFUN |GCNAALG;genericLeftTraceForm;2$F;2|
        ((|a| ($)) (|b| ($)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (SPADCALL |a| |b| (QREFELT $ 51)) (QREFELT $ 52))) 

(SDEFUN |GCNAALG;genericLeftDiscriminant;F;3|
        (($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((|m| (|Matrix| (|Fraction| (|Polynomial| R)))) (#1=#:G753 NIL)
          (|a| NIL) (#2=#:G752 NIL) (#3=#:G751 NIL) (|b| NIL) (#4=#:G750 NIL)
          (|listBasis| (|List| $)))
         (SEQ
          (LETT |listBasis|
                (SPADCALL (SPADCALL (QREFELT $ 55)) (QREFELT $ 58)))
          (LETT |m|
                (SPADCALL
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |b| NIL) (LETT #3# |listBasis|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |b| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |a| NIL) (LETT #1# |listBasis|)
                                      G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |a| (CAR #1#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #2#
                                              (CONS
                                               (SPADCALL |a| |b|
                                                         (QREFELT $ 53))
                                               #2#))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))
                 (QREFELT $ 61)))
          (EXIT (SPADCALL |m| (QREFELT $ 62)))))) 

(SDEFUN |GCNAALG;genericRightTraceForm;2$F;4|
        ((|a| ($)) (|b| ($)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (SPADCALL |a| |b| (QREFELT $ 51)) (QREFELT $ 64))) 

(SDEFUN |GCNAALG;genericRightDiscriminant;F;5|
        (($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((|m| (|Matrix| (|Fraction| (|Polynomial| R)))) (#1=#:G764 NIL)
          (|a| NIL) (#2=#:G763 NIL) (#3=#:G762 NIL) (|b| NIL) (#4=#:G761 NIL)
          (|listBasis| (|List| $)))
         (SEQ
          (LETT |listBasis|
                (SPADCALL (SPADCALL (QREFELT $ 55)) (QREFELT $ 58)))
          (LETT |m|
                (SPADCALL
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |b| NIL) (LETT #3# |listBasis|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |b| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |a| NIL) (LETT #1# |listBasis|)
                                      G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |a| (CAR #1#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #2#
                                              (CONS
                                               (SPADCALL |a| |b|
                                                         (QREFELT $ 65))
                                               #2#))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))
                 (QREFELT $ 61)))
          (EXIT (SPADCALL |m| (QREFELT $ 62)))))) 

(SDEFUN |GCNAALG;initializeLeft| (($ (|Void|)))
        (SEQ (SETELT $ 70 NIL)
             (SETELT $ 69 (SPADCALL (QREFELT $ 35) (QREFELT $ 71)))
             (EXIT (SPADCALL (QREFELT $ 73))))) 

(SDEFUN |GCNAALG;initializeRight| (($ (|Void|)))
        (SEQ (SETELT $ 75 NIL)
             (SETELT $ 74 (SPADCALL (QREFELT $ 35) (QREFELT $ 76)))
             (EXIT (SPADCALL (QREFELT $ 73))))) 

(SDEFUN |GCNAALG;leftRankPolynomial;Sup;8|
        (($ (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
        (SEQ (COND ((QREFELT $ 70) (|GCNAALG;initializeLeft| $)))
             (EXIT (QREFELT $ 69)))) 

(SDEFUN |GCNAALG;rightRankPolynomial;Sup;9|
        (($ (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
        (SEQ (COND ((QREFELT $ 75) (|GCNAALG;initializeRight| $)))
             (EXIT (QREFELT $ 74)))) 

(SDEFUN |GCNAALG;genericLeftMinimalPolynomial;$Sup;10|
        ((|a| ($))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
        (SPROG NIL
               (SEQ (COND ((QREFELT $ 70) (|GCNAALG;initializeLeft| $)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|GCNAALG;genericLeftMinimalPolynomial;$Sup;10!0|
                            (VECTOR $ |a|))
                      (QREFELT $ 69) (QREFELT $ 80)))))) 

(SDEFUN |GCNAALG;genericLeftMinimalPolynomial;$Sup;10!0| ((|x| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GCNAALG;eval| |x| |a| $))))) 

(SDEFUN |GCNAALG;genericRightMinimalPolynomial;$Sup;11|
        ((|a| ($))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
        (SPROG NIL
               (SEQ (COND ((QREFELT $ 75) (|GCNAALG;initializeRight| $)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|GCNAALG;genericRightMinimalPolynomial;$Sup;11!0|
                            (VECTOR $ |a|))
                      (QREFELT $ 74) (QREFELT $ 80)))))) 

(SDEFUN |GCNAALG;genericRightMinimalPolynomial;$Sup;11!0| ((|x| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GCNAALG;eval| |x| |a| $))))) 

(SDEFUN |GCNAALG;genericLeftTrace;$F;12|
        ((|a| ($)) ($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((|rf| (|Fraction| (|Polynomial| R))) (|d1| (|NonNegativeInteger|)))
         (SEQ (COND ((QREFELT $ 70) (|GCNAALG;initializeLeft| $)))
              (LETT |d1|
                    (SPADCALL (SPADCALL (QREFELT $ 69) (QREFELT $ 84)) 1
                              (QREFELT $ 85)))
              (LETT |rf| (SPADCALL (QREFELT $ 69) |d1| (QREFELT $ 86)))
              (LETT |rf| (|GCNAALG;eval| |rf| |a| $))
              (EXIT (SPADCALL |rf| (QREFELT $ 87)))))) 

(SDEFUN |GCNAALG;genericRightTrace;$F;13|
        ((|a| ($)) ($ (|Fraction| (|Polynomial| R))))
        (SPROG
         ((|rf| (|Fraction| (|Polynomial| R))) (|d1| (|NonNegativeInteger|)))
         (SEQ (COND ((QREFELT $ 75) (|GCNAALG;initializeRight| $)))
              (LETT |d1|
                    (SPADCALL (SPADCALL (QREFELT $ 74) (QREFELT $ 84)) 1
                              (QREFELT $ 85)))
              (LETT |rf| (SPADCALL (QREFELT $ 74) |d1| (QREFELT $ 86)))
              (LETT |rf| (|GCNAALG;eval| |rf| |a| $))
              (EXIT (SPADCALL |rf| (QREFELT $ 87)))))) 

(SDEFUN |GCNAALG;genericLeftNorm;$F;14|
        ((|a| ($)) ($ (|Fraction| (|Polynomial| R))))
        (SPROG ((|rf| (|Fraction| (|Polynomial| R))))
               (SEQ (COND ((QREFELT $ 70) (|GCNAALG;initializeLeft| $)))
                    (LETT |rf| (SPADCALL (QREFELT $ 69) 1 (QREFELT $ 86)))
                    (COND
                     ((ODDP (SPADCALL (QREFELT $ 69) (QREFELT $ 84)))
                      (LETT |rf| (SPADCALL |rf| (QREFELT $ 87)))))
                    (EXIT |rf|)))) 

(SDEFUN |GCNAALG;genericRightNorm;$F;15|
        ((|a| ($)) ($ (|Fraction| (|Polynomial| R))))
        (SPROG ((|rf| (|Fraction| (|Polynomial| R))))
               (SEQ (COND ((QREFELT $ 75) (|GCNAALG;initializeRight| $)))
                    (LETT |rf| (SPADCALL (QREFELT $ 74) 1 (QREFELT $ 86)))
                    (COND
                     ((ODDP (SPADCALL (QREFELT $ 74) (QREFELT $ 84)))
                      (LETT |rf| (SPADCALL |rf| (QREFELT $ 87)))))
                    (EXIT |rf|)))) 

(SDEFUN |GCNAALG;conditionsForIdempotents;VL;16|
        ((|b| (|Vector| $)) ($ (|List| (|Polynomial| R))))
        (SPROG ((|x| ($)))
               (SEQ (LETT |x| (SPADCALL |b| (QREFELT $ 90)))
                    (EXIT
                     (SPADCALL (ELT $ 36)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (SPADCALL |x| |x| (QREFELT $ 51))
                                           |x| (QREFELT $ 91))
                                 |b| (QREFELT $ 92))
                                (QREFELT $ 39))
                               (QREFELT $ 43)))))) 

(SDEFUN |GCNAALG;conditionsForIdempotents;L;17| (($ (|List| (|Polynomial| R))))
        (SPROG ((|x| ($)))
               (SEQ (LETT |x| (QREFELT $ 35))
                    (EXIT
                     (SPADCALL (ELT $ 36)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (SPADCALL |x| |x| (QREFELT $ 51))
                                           |x| (QREFELT $ 91))
                                 (QREFELT $ 37))
                                (QREFELT $ 39))
                               (QREFELT $ 43)))))) 

(SDEFUN |GCNAALG;generic;$;18| (($ ($))) (QREFELT $ 35)) 

(SDEFUN |GCNAALG;generic;VV$;19|
        ((|vs| (|Vector| (|Symbol|))) (|ve| (|Vector| $)) ($ ($)))
        (SPROG
         ((|v| (|Vector| (|Polynomial| R))) (#1=#:G803 NIL) (#2=#:G805 NIL)
          (|i| NIL) (#3=#:G804 NIL))
         (SEQ
          (COND
           ((> (QVSIZE |vs|) (SPADCALL |ve| (QREFELT $ 96)))
            (|error| "generic: too little symbols"))
           ('T
            (SEQ
             (LETT |v|
                   (PROGN
                    (LETT #3# (GETREFV #4=(SPADCALL |ve| (QREFELT $ 96))))
                    (SEQ (LETT |i| 1) (LETT #2# #4#) (LETT #1# 0) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SETELT #3# #1#
                                   (SPADCALL (|spadConstant| $ 20)
                                             (LIST
                                              (SPADCALL |vs| |i|
                                                        (QREFELT $ 23)))
                                             (LIST 1) (QREFELT $ 26)))))
                         (LETT #1#
                               (PROG1 (|inc_SI| #1#)
                                 (LETT |i| (|inc_SI| |i|))))
                         (GO G190) G191 (EXIT NIL))
                    #3#))
             (EXIT
              (SPADCALL (SPADCALL (ELT $ 28) |v| (QREFELT $ 33)) |ve|
                        (QREFELT $ 97))))))))) 

(SDEFUN |GCNAALG;generic;SV$;20| ((|s| (|Symbol|)) (|ve| (|Vector| $)) ($ ($)))
        (SPROG
         ((|sFC| (|Vector| (|Symbol|))) (#1=#:G814 NIL) (#2=#:G816 NIL)
          (|i| NIL) (#3=#:G815 NIL) (|lON| (|List| (|String|))) (#4=#:G813 NIL)
          (|q| NIL) (#5=#:G812 NIL))
         (SEQ
          (LETT |lON|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |q| 1) (LETT #4# (SPADCALL |ve| (QREFELT $ 96)))
                      G190 (COND ((|greater_SI| |q| #4#) (GO G191)))
                      (SEQ (EXIT (LETT #5# (CONS (STRINGIMAGE |q|) #5#))))
                      (LETT |q| (|inc_SI| |q|)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |sFC|
                (PROGN
                 (LETT #3# (GETREFV (SIZE |lON|)))
                 (SEQ (LETT |i| NIL) (LETT #2# |lON|) (LETT #1# 0) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL (STRCONC |s| |i|) (QREFELT $ 17)))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT #2# (CDR #2#))))
                      (GO G190) G191 (EXIT NIL))
                 #3#))
          (EXIT (SPADCALL |sFC| |ve| (QREFELT $ 98)))))) 

(SDEFUN |GCNAALG;generic;V$;21| ((|ve| (|Vector| $)) ($ ($)))
        (SPROG
         ((|v| (|Vector| (|Polynomial| R))) (#1=#:G831 NIL) (#2=#:G833 NIL)
          (|i| NIL) (#3=#:G832 NIL) (|sFC| (|Vector| (|Symbol|)))
          (#4=#:G828 NIL) (#5=#:G830 NIL) (#6=#:G829 NIL)
          (|lON| (|List| (|String|))) (#7=#:G827 NIL) (|q| NIL)
          (#8=#:G826 NIL))
         (SEQ
          (LETT |lON|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |q| 1) (LETT #7# (SPADCALL |ve| (QREFELT $ 96)))
                      G190 (COND ((|greater_SI| |q| #7#) (GO G191)))
                      (SEQ (EXIT (LETT #8# (CONS (STRINGIMAGE |q|) #8#))))
                      (LETT |q| (|inc_SI| |q|)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |sFC|
                (PROGN
                 (LETT #6# (GETREFV (SIZE |lON|)))
                 (SEQ (LETT |i| NIL) (LETT #5# |lON|) (LETT #4# 0) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #6# #4#
                                (SPADCALL (STRCONC "%" (STRCONC "x" |i|))
                                          (QREFELT $ 17)))))
                      (LETT #4# (PROG1 (|inc_SI| #4#) (LETT #5# (CDR #5#))))
                      (GO G190) G191 (EXIT NIL))
                 #6#))
          (LETT |v|
                (PROGN
                 (LETT #3# (GETREFV #9=(SPADCALL |ve| (QREFELT $ 96))))
                 (SEQ (LETT |i| 1) (LETT #2# #9#) (LETT #1# 0) G190
                      (COND ((|greater_SI| |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL (|spadConstant| $ 20)
                                          (LIST
                                           (SPADCALL |sFC| |i| (QREFELT $ 23)))
                                          (LIST 1) (QREFELT $ 26)))))
                      (LETT #1#
                            (PROG1 (|inc_SI| #1#) (LETT |i| (|inc_SI| |i|))))
                      (GO G190) G191 (EXIT NIL))
                 #3#))
          (EXIT
           (SPADCALL (SPADCALL (ELT $ 28) |v| (QREFELT $ 33)) |ve|
                     (QREFELT $ 97)))))) 

(SDEFUN |GCNAALG;generic;V$;22| ((|vs| (|Vector| (|Symbol|))) ($ ($)))
        (SPADCALL |vs| (SPADCALL (QREFELT $ 55)) (QREFELT $ 98))) 

(SDEFUN |GCNAALG;generic;S$;23| ((|s| (|Symbol|)) ($ ($)))
        (SPADCALL |s| (SPADCALL (QREFELT $ 55)) (QREFELT $ 99))) 

(DECLAIM (NOTINLINE |GenericNonAssociativeAlgebra;|)) 

(DEFUN |GenericNonAssociativeAlgebra| (&REST #1=#:G851)
  (SPROG NIL
         (PROG (#2=#:G852)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL NIL))
                     (HGET |$ConstructorCache| '|GenericNonAssociativeAlgebra|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |GenericNonAssociativeAlgebra;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GenericNonAssociativeAlgebra|)))))))))) 

(DEFUN |GenericNonAssociativeAlgebra;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|v| NIL) (#1=#:G848 NIL) (#2=#:G850 NIL) (|i| NIL) (#3=#:G849 NIL)
    (#4=#:G845 NIL) (#5=#:G847 NIL) (#6=#:G846 NIL) (#7=#:G844 NIL) (|q| NIL)
    (#8=#:G843 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 (|devaluate| |#1|))
     (LETT DV$2 |#2|)
     (LETT DV$3 |#3|)
     (LETT DV$4 |#4|)
     (LETT |dv$| (LIST '|GenericNonAssociativeAlgebra| DV$1 DV$2 DV$3 DV$4))
     (LETT $ (GETREFV 116))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3
               (LETT |pv$|
                     (|buildPredVector| 0 0
                                        (LIST
                                         (|HasCategory|
                                          (|Fraction| (|Polynomial| |#1|))
                                          '(|IntegralDomain|))
                                         (|HasCategory|
                                          (|Fraction| (|Polynomial| |#1|))
                                          '(|Finite|))
                                         (|HasCategory|
                                          (|Fraction| (|Polynomial| |#1|))
                                          '(|Field|))
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))))))
     (|haddProp| |$ConstructorCache| '|GenericNonAssociativeAlgebra|
                 (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (QSETREFV $ 7 |#2|)
     (QSETREFV $ 8 |#3|)
     (QSETREFV $ 9 |#4|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 14
               (PROGN
                (LETT #8# NIL)
                (SEQ (LETT |q| 1) (LETT #7# |#2|) G190
                     (COND ((|greater_SI| |q| #7#) (GO G191)))
                     (SEQ (EXIT (LETT #8# (CONS (STRINGIMAGE |q|) #8#))))
                     (LETT |q| (|inc_SI| |q|)) (GO G190) G191
                     (EXIT (NREVERSE #8#)))))
     (QSETREFV $ 18
               (PROGN
                (LETT #6# (GETREFV (SIZE #9=(QREFELT $ 14))))
                (SEQ (LETT |i| NIL) (LETT #5# #9#) (LETT #4# 0) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SETELT #6# #4#
                               (SPADCALL (STRCONC "%" (STRCONC "x" |i|))
                                         (QREFELT $ 17)))))
                     (LETT #4# (PROG1 (|inc_SI| #4#) (LETT #5# (CDR #5#))))
                     (GO G190) G191 (EXIT NIL))
                #6#))
     (QSETREFV $ 35
               (SEQ
                (LETT |v|
                      (PROGN
                       (LETT #3# (GETREFV |#2|))
                       (SEQ (LETT |i| 1) (LETT #2# |#2|) (LETT #1# 0) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SETELT #3# #1#
                                      (SPADCALL (|spadConstant| $ 20)
                                                (LIST
                                                 (SPADCALL (QREFELT $ 18) |i|
                                                           (QREFELT $ 23)))
                                                (LIST 1) (QREFELT $ 26)))))
                            (LETT #1#
                                  (PROG1 (|inc_SI| #1#)
                                    (LETT |i| (|inc_SI| |i|))))
                            (GO G190) G191 (EXIT NIL))
                       #3#))
                (EXIT
                 (SPADCALL (SPADCALL (ELT $ 28) |v| (QREFELT $ 33))
                           (QREFELT $ 34)))))
     (COND
      ((|testBitVector| |pv$| 4)
       (PROGN
        (QSETREFV $ 53
                  (CONS
                   (|dispatchFunction| |GCNAALG;genericLeftTraceForm;2$F;2|)
                   $))
        (QSETREFV $ 63
                  (CONS
                   (|dispatchFunction| |GCNAALG;genericLeftDiscriminant;F;3|)
                   $))
        (QSETREFV $ 65
                  (CONS
                   (|dispatchFunction| |GCNAALG;genericRightTraceForm;2$F;4|)
                   $))
        (QSETREFV $ 66
                  (CONS
                   (|dispatchFunction| |GCNAALG;genericRightDiscriminant;F;5|)
                   $))
        (QSETREFV $ 69 (|spadConstant| $ 68))
        (QSETREFV $ 70 'T)
        NIL
        (QSETREFV $ 74 (|spadConstant| $ 68))
        (QSETREFV $ 75 'T)
        NIL
        (QSETREFV $ 77
                  (CONS (|dispatchFunction| |GCNAALG;leftRankPolynomial;Sup;8|)
                        $))
        (QSETREFV $ 78
                  (CONS
                   (|dispatchFunction| |GCNAALG;rightRankPolynomial;Sup;9|) $))
        (QSETREFV $ 81
                  (CONS
                   (|dispatchFunction|
                    |GCNAALG;genericLeftMinimalPolynomial;$Sup;10|)
                   $))
        (QSETREFV $ 82
                  (CONS
                   (|dispatchFunction|
                    |GCNAALG;genericRightMinimalPolynomial;$Sup;11|)
                   $))
        (QSETREFV $ 52
                  (CONS (|dispatchFunction| |GCNAALG;genericLeftTrace;$F;12|)
                        $))
        (QSETREFV $ 64
                  (CONS (|dispatchFunction| |GCNAALG;genericRightTrace;$F;13|)
                        $))
        (QSETREFV $ 88
                  (CONS (|dispatchFunction| |GCNAALG;genericLeftNorm;$F;14|)
                        $))
        (QSETREFV $ 89
                  (CONS (|dispatchFunction| |GCNAALG;genericRightNorm;$F;15|)
                        $)))))
     $)))) 

(MAKEPROP '|GenericNonAssociativeAlgebra| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|AlgebraGivenByStructuralConstants| 27 (NRTEVAL (QREFELT $ 7))
                                                   (NRTEVAL (QREFELT $ 8))
                                                   (NRTEVAL
                                                    (SPADCALL (QREFELT $ 9)
                                                              (QREFELT $ 13))))
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|local| |#4|)
              (|Vector| 60) (|Vector| (|Matrix| 6))
              (|CoerceVectorMatrixPackage| 6) (0 . |coerce|) '|listOfNumbers|
              (|String|) (|Symbol|) (5 . |coerce|) '|symbolsForCoef|
              (|Polynomial| 6) (10 . |One|) (|Integer|) (|Vector| 16)
              (14 . |elt|) (|List| 16) (|List| 83) (20 . |monomial|)
              (|Fraction| 19) (27 . |coerce|) (|Vector| 27) (|Mapping| 27 19)
              (|Vector| 19) (|VectorFunctions2| 19 27) (32 . |map|)
              (38 . |convert|) '|genericElement| (43 . |numer|)
              (48 . |coordinates|) (|List| 27) (53 . |entries|) (|List| 19)
              (|Mapping| 19 27) (|ListFunctions2| 27 19) (58 . |map|)
              (64 . |entries|) (69 . |elt|) (|Equation| 19) (75 . |equation|)
              (|List| (|Equation| $)) (81 . |eval|) (87 . /) (93 . *)
              (99 . |genericLeftTrace|) (104 . |genericLeftTraceForm|)
              (|Vector| $) (110 . |basis|) (|List| $$) (|Vector| $$)
              (114 . |entries|) (|List| 38) (|Matrix| 27) (119 . |matrix|)
              (124 . |determinant|) (129 . |genericLeftDiscriminant|)
              (133 . |genericRightTrace|) (138 . |genericRightTraceForm|)
              (144 . |genericRightDiscriminant|)
              (|SparseUnivariatePolynomial| 27) (148 . |Zero|) '|leftRankPoly|
              '|initLeft?| (152 . |leftMinimalPolynomial|) (|Void|)
              (157 . |void|) '|rightRankPoly| '|initRight?|
              (161 . |rightMinimalPolynomial|) (166 . |leftRankPolynomial|)
              (170 . |rightRankPolynomial|) (|Mapping| 27 27) (174 . |map|)
              (180 . |genericLeftMinimalPolynomial|)
              (185 . |genericRightMinimalPolynomial|) (|NonNegativeInteger|)
              (190 . |degree|) (195 . -) (201 . |coefficient|) (207 . -)
              (212 . |genericLeftNorm|) (217 . |genericRightNorm|)
              |GCNAALG;generic;V$;21| (222 . -) (228 . |coordinates|)
              |GCNAALG;conditionsForIdempotents;VL;16|
              |GCNAALG;conditionsForIdempotents;L;17| |GCNAALG;generic;$;18|
              (234 . |maxIndex|) (239 . |represents|) |GCNAALG;generic;VV$;19|
              |GCNAALG;generic;SV$;20| |GCNAALG;generic;V$;22|
              |GCNAALG;generic;S$;23|
              (|SparseUnivariatePolynomial| (|Polynomial| 27)) (|List| $)
              (|PositiveInteger|) (|InputForm|) (|Boolean|)
              (|Union| $ '"failed") (|List| 29)
              (|Record| (|:| |particular| $) (|:| |basis| 103))
              (|Union| 109 '"failed")
              (|SquareMatrix| (NRTEVAL (QREFELT $ 7)) 27)
              (|List| (|Polynomial| 27)) (|HashState|) (|OutputForm|)
              (|SingleInteger|))
           '#(|rightRankPolynomial| 245 |rightMinimalPolynomial| 249
              |represents| 254 |leftRankPolynomial| 260 |leftMinimalPolynomial|
              264 |genericRightTraceForm| 269 |genericRightTrace| 275
              |genericRightNorm| 280 |genericRightMinimalPolynomial| 285
              |genericRightDiscriminant| 290 |genericLeftTraceForm| 294
              |genericLeftTrace| 300 |genericLeftNorm| 305
              |genericLeftMinimalPolynomial| 310 |genericLeftDiscriminant| 315
              |generic| 319 |coordinates| 350 |convert| 361
              |conditionsForIdempotents| 366 |basis| 375 - 379 * 385)
           'NIL
           (CONS
            (|makeByteWordVec2| 2
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 2 0 0 0 1
                                  2))
            (CONS
             '#(|FramedNonAssociativeAlgebra&|
                |FiniteRankNonAssociativeAlgebra&| |NonAssociativeAlgebra&|
                |Module&| |FramedModule&| NIL |NonAssociativeRng&| NIL NIL NIL
                |AbelianGroup&| NIL |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Finite&| |AbelianSemiGroup&| |Magma&| NIL |SetCategory&|
                |BasicType&| NIL NIL NIL)
             (CONS
              '#((|FramedNonAssociativeAlgebra| (|Fraction| (|Polynomial| 6)))
                 (|FiniteRankNonAssociativeAlgebra|
                  (|Fraction| (|Polynomial| 6)))
                 (|NonAssociativeAlgebra| (|Fraction| (|Polynomial| 6)))
                 (|Module| (|Fraction| (|Polynomial| 6)))
                 (|FramedModule| (|Fraction| (|Polynomial| 6)))
                 (|BiModule| (|Fraction| (|Polynomial| 6))
                             (|Fraction| (|Polynomial| 6)))
                 (|NonAssociativeRng|)
                 (|LeftModule|
                  (|SquareMatrix| 7 (|Fraction| (|Polynomial| 6))))
                 (|RightModule| (|Fraction| (|Polynomial| 6)))
                 (|LeftModule| (|Fraction| (|Polynomial| 6))) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Finite|) (|AbelianSemiGroup|) (|Magma|)
                 (|Comparable|) (|SetCategory|) (|BasicType|)
                 (|CoercibleTo| 114) (|unitsKnown|) (|ConvertibleTo| 105))
              (|makeByteWordVec2| 101
                                  '(1 12 10 11 13 1 16 0 15 17 0 19 0 20 2 22
                                    16 0 21 23 3 19 0 0 24 25 26 1 27 0 19 28 2
                                    32 29 30 31 33 1 0 0 29 34 1 27 19 0 36 1 0
                                    29 0 37 1 29 38 0 39 2 42 40 41 38 43 1 22
                                    24 0 44 2 40 19 0 21 45 2 46 0 19 19 47 2
                                    19 0 0 48 49 2 27 0 19 19 50 2 0 0 0 0 51 1
                                    0 27 0 52 2 0 27 0 0 53 0 0 54 55 1 57 56 0
                                    58 1 60 0 59 61 1 60 27 0 62 0 0 27 63 1 0
                                    27 0 64 2 0 27 0 0 65 0 0 27 66 0 67 0 68 1
                                    0 67 0 71 0 72 0 73 1 0 67 0 76 0 0 67 77 0
                                    0 67 78 2 67 0 79 0 80 1 0 67 0 81 1 0 67 0
                                    82 1 67 83 0 84 2 83 0 0 0 85 2 67 27 0 83
                                    86 1 27 0 0 87 1 0 27 0 88 1 0 27 0 89 2 0
                                    0 0 0 91 2 0 29 0 54 92 1 57 21 0 96 2 0 0
                                    29 54 97 0 4 67 78 1 1 67 0 76 2 0 0 29 54
                                    97 0 4 67 77 1 1 67 0 71 2 4 27 0 0 65 1 4
                                    27 0 64 1 4 27 0 89 1 4 67 0 82 0 4 27 66 2
                                    4 27 0 0 53 1 4 27 0 52 1 4 27 0 88 1 4 67
                                    0 81 0 4 27 63 2 0 0 22 54 98 1 0 0 54 90 2
                                    0 0 16 54 99 1 0 0 16 101 1 0 0 22 100 0 0
                                    0 95 1 0 29 0 37 2 0 29 0 54 92 1 0 0 29 34
                                    0 4 40 94 1 4 40 54 93 0 0 54 55 2 0 0 0 0
                                    91 2 0 0 0 0 51)))))
           '|lookupIncomplete|)) 
