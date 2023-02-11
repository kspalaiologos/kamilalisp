
(SDEFUN |FFCGP;tableForDiscreteLogarithm;IT;1|
        ((|fac| (|Integer|))
         ($ (|Table| (|PositiveInteger|) (|NonNegativeInteger|))))
        (SPADCALL (QREFELT $ 36))) 

(SDEFUN |FFCGP;getZechTable;Pa;2| (($ (|PrimitiveArray| (|SingleInteger|))))
        (QREFELT $ 20)) 

(SDEFUN |FFCGP;order;$Pi;3| ((|x| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G732 NIL))
               (COND
                ((SPADCALL |x| (QREFELT $ 42))
                 (|error| "order: order of zero undefined"))
                ('T
                 (PROG1
                     (LETT #1#
                           (QUOTIENT2 (QREFELT $ 18) (GCD (QREFELT $ 18) |x|)))
                   (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                     '(|Integer|) #1#)))))) 

(SDEFUN |FFCGP;primitive?;$B;4| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((OR (SPADCALL |x| (QREFELT $ 42))
              (SPADCALL |x| (|spadConstant| $ 17) (QREFELT $ 45)))
          NIL)
         ('T
          (COND ((SPADCALL (GCD |x| (QREFELT $ 18)) 1 (QREFELT $ 45)) 'T)
                ('T NIL))))) 

(SDEFUN |FFCGP;coordinates;$V;5| ((|x| ($)) ($ (|Vector| GF)))
        (SPROG
         ((|primElement|
           (|SimpleAlgebraicExtension| GF (|SparseUnivariatePolynomial| GF)
                                       |defpol|)))
         (SEQ
          (COND
           ((SPADCALL |x| (|spadConstant| $ 27) (QREFELT $ 45))
            (MAKEARR1 (QREFELT $ 12) (|spadConstant| $ 47)))
           ('T
            (SEQ
             (LETT |primElement|
                   (SPADCALL (SPADCALL (|spadConstant| $ 48) 1 (QREFELT $ 49))
                             (QREFELT $ 51)))
             (EXIT
              (SPADCALL (SPADCALL |primElement| |x| (QREFELT $ 52))
                        (QREFELT $ 54))))))))) 

(SDEFUN |FFCGP;+;3$;6| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|d| (|Rep|)))
               (SEQ (COND ((QREFELT $ 32) (|FFCGP;initializeZech| $)))
                    (EXIT
                     (COND ((|eql_SI| |x| -1) |y|) ((|eql_SI| |y| -1) |x|)
                           (#1='T
                            (SEQ
                             (LETT |d| (|submod_SI| |y| |x| (QREFELT $ 18)))
                             (EXIT
                              (COND
                               ((SPADCALL |d| (|lshift_SI| (QREFELT $ 18) -1)
                                          (QREFELT $ 56))
                                (COND
                                 ((|eql_SI| (QAREF1 (QREFELT $ 20) |d|) -1) -1)
                                 (#1#
                                  (|addmod_SI| |x| (QAREF1 (QREFELT $ 20) |d|)
                                               (QREFELT $ 18)))))
                               (#1#
                                (SEQ (LETT |d| (|sub_SI| (QREFELT $ 18) |d|))
                                     (EXIT
                                      (|addmod_SI| |y|
                                                   (QAREF1 (QREFELT $ 20) |d|)
                                                   (QREFELT $ 18)))))))))))))) 

(SDEFUN |FFCGP;initializeZech| (($ (|Void|)))
        (SEQ (SETELT $ 20 (SPADCALL (QREFELT $ 7) (QREFELT $ 59)))
             (SETELT $ 32 NIL) (EXIT (SPADCALL (QREFELT $ 61))))) 

(SDEFUN |FFCGP;basis;PiV;8| ((|n| (|PositiveInteger|)) ($ (|Vector| $)))
        (SPROG
         ((#1=#:G756 NIL) (#2=#:G762 NIL) (|i| NIL) (#3=#:G761 NIL)
          (|m| (|Integer|)))
         (SEQ
          (COND
           ((SPADCALL (REM (SPADCALL (QREFELT $ 64)) |n|) 0 (QREFELT $ 65))
            (|error| "argument must divide extension degree"))
           ('T
            (SEQ
             (LETT |m|
                   (QUOTIENT2 (QREFELT $ 18)
                              (- (EXPT (SPADCALL (QREFELT $ 13)) |n|) 1)))
             (EXIT
              (PROGN
               (LETT #3# (GETREFV |n|))
               (SEQ (LETT |i| 0) (LETT #2# (- |n| 1)) G190
                    (COND ((|greater_SI| |i| #2#) (GO G191)))
                    (SEQ
                     (EXIT
                      (SETELT #3# |i|
                              (SPADCALL
                               (PROG1 (LETT #1# (+ 1 (* |i| |m|)))
                                 (|check_subtype2| (> #1# 0)
                                                   '(|PositiveInteger|)
                                                   '(|Integer|) #1#))
                               (QREFELT $ 66)))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
               #3#)))))))) 

(SDEFUN |FFCGP;*;I2$;9| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |n| (QREFELT $ 69)) (QREFELT $ 70)) |x|
                  (QREFELT $ 71))) 

(SDEFUN |FFCGP;minimalPolynomial;$Sup;10|
        ((|a| ($)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|f| (|SparseUnivariatePolynomial| $))
          (|p| (|SparseUnivariatePolynomial| GF)) (|g| (GF)) (|u| ($)))
         (SEQ
          (LETT |f|
                (SPADCALL (SPADCALL (|spadConstant| $ 17) 1 (QREFELT $ 74))
                          (SPADCALL |a| 0 (QREFELT $ 74)) (QREFELT $ 75)))
          (LETT |u| (SPADCALL |a| (QREFELT $ 76)))
          (SEQ G190
               (COND
                ((NULL (NULL (SPADCALL |u| |a| (QREFELT $ 45)))) (GO G191)))
               (SEQ
                (LETT |f|
                      (SPADCALL |f|
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 17) 1
                                           (QREFELT $ 74))
                                 (SPADCALL |u| 0 (QREFELT $ 74))
                                 (QREFELT $ 75))
                                (QREFELT $ 77)))
                (EXIT (LETT |u| (SPADCALL |u| (QREFELT $ 76)))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT |p| (|spadConstant| $ 26))
          (SEQ G190
               (COND ((NULL (NULL (SPADCALL |f| (QREFELT $ 78)))) (GO G191)))
               (SEQ
                (LETT |g|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 79)) (QREFELT $ 80)))
                (LETT |p|
                      (SPADCALL |p|
                                (SPADCALL |g| (SPADCALL |f| (QREFELT $ 81))
                                          (QREFELT $ 49))
                                (QREFELT $ 82)))
                (EXIT (LETT |f| (SPADCALL |f| (QREFELT $ 83)))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT |p|)))) 

(SDEFUN |FFCGP;factorsOfCyclicGroupSize;L;11|
        (($
          (|List|
           (|Record| (|:| |factor| (|Integer|))
                     (|:| |exponent| (|NonNegativeInteger|))))))
        (SEQ (COND ((NULL (QREFELT $ 31)) (|FFCGP;initializeElt| $)))
             (EXIT (QREFELT $ 31)))) 

(PUT '|FFCGP;representationType;U;12| '|SPADreplace|
     '(XLAM NIL (CONS 3 "cyclic"))) 

(SDEFUN |FFCGP;representationType;U;12|
        (($ (|Union| "prime" "polynomial" "normal" "cyclic")))
        (CONS 3 "cyclic")) 

(SDEFUN |FFCGP;definingPolynomial;Sup;13|
        (($ (|SparseUnivariatePolynomial| GF))) (QREFELT $ 7)) 

(SDEFUN |FFCGP;random;$;14| (($ ($))) (|sub_SI| (RANDOM (QREFELT $ 14)) 1)) 

(SDEFUN |FFCGP;represents;V$;15| ((|v| (|Vector| GF)) ($ ($)))
        (SPROG ((|u| (|FiniteFieldExtensionByPolynomial| GF |defpol|)))
               (SEQ (LETT |u| (SPADCALL |v| (QREFELT $ 93)))
                    (EXIT
                     (COND
                      ((SPADCALL |u| (|spadConstant| $ 94) (QREFELT $ 95))
                       (|spadConstant| $ 27))
                      ('T (SPADCALL |u| (QREFELT $ 96)))))))) 

(SDEFUN |FFCGP;coerce;GF$;16| ((|e| (GF)) ($ ($)))
        (SPROG ((|log| (|Integer|)) (#1=#:G794 NIL))
               (SEQ
                (COND ((SPADCALL |e| (QREFELT $ 98)) (|spadConstant| $ 27))
                      ('T
                       (SEQ
                        (LETT |log|
                              (*
                               (PROG2
                                   (LETT #1#
                                         (SPADCALL (QREFELT $ 30) |e|
                                                   (QREFELT $ 100)))
                                   (QCDR #1#)
                                 (|check_union2| (QEQCAR #1# 0)
                                                 (|NonNegativeInteger|)
                                                 (|Union|
                                                  (|NonNegativeInteger|)
                                                  "failed")
                                                 #1#))
                               (QREFELT $ 19)))
                        (EXIT
                         (SPADCALL |log| (QREFELT $ 18) (QREFELT $ 101))))))))) 

(SDEFUN |FFCGP;retractIfCan;$U;17| ((|x| ($)) ($ (|Union| GF "failed")))
        (SPROG ((#1=#:G803 NIL) (|u| (|Union| $ #2="failed")))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 42)) (CONS 0 (|spadConstant| $ 47)))
                 (#3='T
                  (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 19) (QREFELT $ 103)))
                       (EXIT
                        (COND
                         ((SPADCALL |u| (CONS 1 "failed") (QREFELT $ 105))
                          (CONS 1 "failed"))
                         (#3#
                          (CONS 0
                                (SPADCALL (QREFELT $ 30)
                                          (PROG2 (LETT #1# |u|)
                                              (QCDR #1#)
                                            (|check_union2| (QEQCAR #1# 0) $
                                                            (|Union| $ #2#)
                                                            #1#))
                                          (QREFELT $ 106)))))))))))) 

(SDEFUN |FFCGP;retract;$GF;18| ((|x| ($)) ($ (GF)))
        (SPROG ((#1=#:G815 NIL) (|a| (|Union| GF #2="failed")))
               (SEQ (LETT |a| (SPADCALL |x| (QREFELT $ 108)))
                    (EXIT
                     (COND
                      ((SPADCALL |a| (CONS 1 "failed") (QREFELT $ 109))
                       (|error| "element not in ground field"))
                      ('T
                       (PROG2 (LETT #1# |a|)
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                         (|Union| (QREFELT $ 6) #2#) #1#)))))))) 

(SDEFUN |FFCGP;basis;V;19| (($ (|Vector| $)))
        (SPROG
         ((#1=#:G821 NIL) (#2=#:G824 NIL) (#3=#:G826 NIL) (|i| NIL)
          (#4=#:G825 NIL))
         (SEQ
          (PROGN
           (LETT #4# (GETREFV #5=(QREFELT $ 12)))
           (SEQ (LETT |i| 1) (LETT #3# #5#) (LETT #2# 0) G190
                (COND ((|greater_SI| |i| #3#) (GO G191)))
                (SEQ
                 (EXIT
                  (SETELT #4# #2#
                          (SPADCALL
                           (PROG1 (LETT #1# |i|)
                             (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                               '(|NonNegativeInteger|) #1#))
                           (QREFELT $ 66)))))
                (LETT #2# (PROG1 (|inc_SI| #2#) (LETT |i| (|inc_SI| |i|))))
                (GO G190) G191 (EXIT NIL))
           #4#)))) 

(SDEFUN |FFCGP;inGroundField?;$B;20| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((OR (SPADCALL |x| (QREFELT $ 42))
              (|eql_SI| (SPADCALL |x| (QREFELT $ 19) (QREFELT $ 111)) 0))
          'T)
         ('T NIL))) 

(SDEFUN |FFCGP;discreteLog;2$U;21|
        ((|b| ($)) (|x| ($)) ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((|e1| (|Record| (|:| |coef1| $) (|:| |coef2| $))) (#1=#:G835 NIL)
          (|e|
           (|Union| (|Record| (|:| |coef1| $) (|:| |coef2| $)) #2="failed")))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 42)) (CONS 1 "failed"))
                (#3='T
                 (SEQ
                  (LETT |e| (SPADCALL |b| (QREFELT $ 18) |x| (QREFELT $ 115)))
                  (EXIT
                   (COND
                    ((SPADCALL |e| (CONS 1 "failed") (QREFELT $ 118))
                     (CONS 1 "failed"))
                    (#3#
                     (SEQ
                      (LETT |e1|
                            (PROG2 (LETT #1# |e|)
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 0)
                                              (|Record| (|:| |coef1| $)
                                                        (|:| |coef2| $))
                                              (|Union|
                                               (|Record| (|:| |coef1| $)
                                                         (|:| |coef2| $))
                                               #2#)
                                              #1#)))
                      (EXIT
                       (CONS 0
                             (SPADCALL (QCAR |e1|) (QREFELT $ 18)
                                       (QREFELT $ 111)))))))))))))) 

(SDEFUN |FFCGP;-;2$;22| ((|x| ($)) ($ ($)))
        (COND ((|eql_SI| |x| -1) -1) ((EQL (SPADCALL (QREFELT $ 120)) 2) |x|)
              ('T
               (|addmod_SI| |x| (|lshift_SI| (QREFELT $ 18) -1)
                            (QREFELT $ 18))))) 

(PUT '|FFCGP;generator;$;23| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |FFCGP;generator;$;23| (($ ($))) 1) 

(PUT '|FFCGP;createPrimitiveElement;$;24| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |FFCGP;createPrimitiveElement;$;24| (($ ($))) 1) 

(PUT '|FFCGP;primitiveElement;$;25| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |FFCGP;primitiveElement;$;25| (($ ($))) 1) 

(SDEFUN |FFCGP;discreteLog;$Nni;26| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (COND
         ((SPADCALL |x| (QREFELT $ 42)) (|error| "discrete logarithm error"))
         ('T |x|))) 

(SDEFUN |FFCGP;normalElement;$;27| (($ ($)))
        (SEQ (COND ((QREFELT $ 33) (|FFCGP;initializeElt| $)))
             (EXIT (QREFELT $ 34)))) 

(SDEFUN |FFCGP;initializeElt| (($ (|Void|)))
        (SEQ
         (SETELT $ 31
                 (SPADCALL (SPADCALL (QREFELT $ 18) (QREFELT $ 129))
                           (QREFELT $ 131)))
         (SETELT $ 34 (SPADCALL (QREFELT $ 132))) (SETELT $ 33 NIL)
         (EXIT (SPADCALL (QREFELT $ 61))))) 

(SDEFUN |FFCGP;extensionDegree;Pi;29| (($ (|PositiveInteger|))) (QREFELT $ 12)) 

(SDEFUN |FFCGP;characteristic;Nni;30| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 133))) 

(SDEFUN |FFCGP;lookup;$Pi;31| ((|x| ($)) ($ (|PositiveInteger|)))
        (COND ((|eql_SI| |x| -1) (QREFELT $ 14)) ('T (|add_SI| |x| 1)))) 

(SDEFUN |FFCGP;index;Pi$;32| ((|a| (|PositiveInteger|)) ($ ($)))
        (|sub_SI| (SPADCALL |a| (QREFELT $ 14) (QREFELT $ 101)) 1)) 

(PUT '|FFCGP;Zero;$;33| '|SPADreplace| '(XLAM NIL -1)) 

(SDEFUN |FFCGP;Zero;$;33| (($ ($))) -1) 

(PUT '|FFCGP;One;$;34| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |FFCGP;One;$;34| (($ ($))) 0) 

(SDEFUN |FFCGP;coerce;$Of;35| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|y| (|Integer|)))
               (SEQ
                (COND ((|eql_SI| |x| -1) (SPADCALL "0" (QREFELT $ 137)))
                      ((|eql_SI| |x| 0) (SPADCALL "1" (QREFELT $ 137)))
                      ('T
                       (SEQ (LETT |y| (- (SPADCALL |x| (QREFELT $ 135)) 1))
                            (EXIT
                             (SPADCALL (QREFELT $ 25)
                                       (SPADCALL |y| (QREFELT $ 138))
                                       (QREFELT $ 139))))))))) 

(PUT '|FFCGP;=;2$B;36| '|SPADreplace| '|eql_SI|) 

(SDEFUN |FFCGP;=;2$B;36| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (|eql_SI| |x| |y|)) 

(SDEFUN |FFCGP;*;3$;37| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND ((OR (|eql_SI| |x| -1) (|eql_SI| |y| -1)) -1)
              ('T (|addmod_SI| |x| |y| (QREFELT $ 18))))) 

(SDEFUN |FFCGP;*;GF2$;38| ((|a| (GF)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 70)) |x| (QREFELT $ 71))) 

(SDEFUN |FFCGP;/;$GF$;39| ((|x| ($)) (|a| (GF)) ($ ($)))
        (SPADCALL |x| (SPADCALL |a| (QREFELT $ 70)) (QREFELT $ 142))) 

(SDEFUN |FFCGP;inv;2$;40| ((|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 42)) (|error| "inv: not invertible"))
              ((SPADCALL |x| (|spadConstant| $ 17) (QREFELT $ 45))
               (|spadConstant| $ 17))
              ('T (|sub_SI| (QREFELT $ 18) |x|)))) 

(SDEFUN |FFCGP;^;$Pi$;41| ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 145))) 

(SDEFUN |FFCGP;^;$Nni$;42| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 145))) 

(SDEFUN |FFCGP;^;$I$;43| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((|m| (|Rep|)))
               (SEQ (LETT |m| (SPADCALL |n| (QREFELT $ 18) (QREFELT $ 101)))
                    (EXIT
                     (COND ((|eql_SI| |m| 0) (|spadConstant| $ 17))
                           ((SPADCALL |x| (|spadConstant| $ 27) (QREFELT $ 45))
                            (|spadConstant| $ 27))
                           ('T (|mulmod_SI| |m| |x| (QREFELT $ 18)))))))) 

(DECLAIM (NOTINLINE |FiniteFieldCyclicGroupExtensionByPolynomial;|)) 

(DEFUN |FiniteFieldCyclicGroupExtensionByPolynomial| (&REST #1=#:G903)
  (SPROG NIL
         (PROG (#2=#:G904)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteFieldCyclicGroupExtensionByPolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |FiniteFieldCyclicGroupExtensionByPolynomial;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FiniteFieldCyclicGroupExtensionByPolynomial|)))))))))) 

(DEFUN |FiniteFieldCyclicGroupExtensionByPolynomial;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G902 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT |dv$|
          (LIST '|FiniteFieldCyclicGroupExtensionByPolynomial| DV$1 DV$2))
    (LETT $ (GETREFV 167))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (LETT #1#
                                              (|HasCategory| |#1| '(|Finite|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         #1#)
                                        (|HasCategory| |#1| '(|Field|))))))
    (|haddProp| |$ConstructorCache|
                '|FiniteFieldCyclicGroupExtensionByPolynomial| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND #1# (|HasCategory| $ '(|CharacteristicNonZero|))
         (|augmentPredVector| $ 16))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|SingleInteger|))
    (QSETREFV $ 12 (SPADCALL |#2| (QREFELT $ 11)))
    (QSETREFV $ 14 (EXPT (SPADCALL (QREFELT $ 13)) (QREFELT $ 12)))
    (QSETREFV $ 15 (> (QREFELT $ 14) (EXPT 2 20)))
    (COND ((QREFELT $ 15) (|error| "field too large for this representation")))
    (QSETREFV $ 18 (- (QREFELT $ 14) 1))
    (QSETREFV $ 19 (QUOTIENT2 (QREFELT $ 18) (- (SPADCALL (QREFELT $ 13)) 1)))
    (QSETREFV $ 20 (MAKEARR1 (QUOTIENT2 (+ (QREFELT $ 14) 1) 2) -1))
    (QSETREFV $ 25 (SPADCALL (SPADCALL (QREFELT $ 22)) (QREFELT $ 24)))
    (QSETREFV $ 30
              (COND
               ((ODDP (QREFELT $ 12))
                (SPADCALL (SPADCALL |#2| 0 (QREFELT $ 28)) (QREFELT $ 29)))
               ('T (SPADCALL |#2| 0 (QREFELT $ 28)))))
    (QSETREFV $ 31 NIL)
    (QSETREFV $ 32 'T)
    (QSETREFV $ 33 'T)
    (QSETREFV $ 34 0)
    $))) 

(MAKEPROP '|FiniteFieldCyclicGroupExtensionByPolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|NonNegativeInteger|) (|SparseUnivariatePolynomial| 6)
              (0 . |degree|) '|extdeg| (5 . |size|) '|sizeFF| '#:G689
              (9 . |One|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FFCGP;One;$;34|) $))
              '|sizeCG| '|sizeFG| '|zechlog| (|Symbol|) (13 . |new|)
              (|OutputForm|) (17 . |coerce|) '|alpha| (22 . |Zero|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |FFCGP;Zero;$;33|) $))
              (26 . |coefficient|) (32 . -) '|primEltGF| '|facOfGroupSize|
              '|initzech?| '|initelt?| '|normalElt| (|Table| 43 9)
              (37 . |table|) (|Integer|) |FFCGP;tableForDiscreteLogarithm;IT;1|
              (|PrimitiveArray| 165) |FFCGP;getZechTable;Pa;2| (|Boolean|)
              (41 . |zero?|) (|PositiveInteger|) |FFCGP;order;$Pi;3|
              |FFCGP;=;2$B;36| |FFCGP;primitive?;$B;4| (46 . |Zero|)
              (50 . |One|) (54 . |monomial|)
              (|SimpleAlgebraicExtension| 6 10 (NRTEVAL (QREFELT $ 7)))
              (60 . |convert|) (65 . ^) (|Vector| 6) (71 . |coordinates|)
              |FFCGP;coordinates;$V;5| (76 . <=) |FFCGP;+;3$;6|
              (|FiniteFieldFunctions| 6) (82 . |createZechTable|) (|Void|)
              (87 . |void|) (|OnePointCompletion| 43) (91 . |extensionDegree|)
              |FFCGP;extensionDegree;Pi;29| (95 . ~=) |FFCGP;index;Pi$;32|
              (|Vector| $) |FFCGP;basis;PiV;8| (101 . |coerce|)
              |FFCGP;coerce;GF$;16| |FFCGP;*;3$;37| |FFCGP;*;I2$;9|
              (|SparseUnivariatePolynomial| $$) (106 . |monomial|) (112 . -)
              (118 . |Frobenius|) (123 . *) (129 . |zero?|)
              (134 . |leadingCoefficient|) |FFCGP;retract;$GF;18|
              (139 . |degree|) (144 . +) (150 . |reductum|)
              |FFCGP;minimalPolynomial;$Sup;10|
              (|Record| (|:| |factor| 37) (|:| |exponent| 9)) (|List| 85)
              |FFCGP;factorsOfCyclicGroupSize;L;11|
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic")
              |FFCGP;representationType;U;12| |FFCGP;definingPolynomial;Sup;13|
              |FFCGP;random;$;14|
              (|FiniteFieldExtensionByPolynomial| 6 (NRTEVAL (QREFELT $ 7)))
              (155 . |represents|) (160 . |Zero|) (164 . =)
              (170 . |discreteLog|) |FFCGP;represents;V$;15| (175 . |zero?|)
              (|Union| 9 '"failed") (180 . |discreteLog|)
              (186 . |positiveRemainder|) (|Union| $ '#1="failed")
              (192 . |exquo|) (|Union| $$ '#1#) (198 . =) (204 . ^)
              (|Union| 6 '"failed") |FFCGP;retractIfCan;$U;17| (210 . =)
              |FFCGP;basis;V;19| (216 . |positiveRemainder|)
              |FFCGP;inGroundField?;$B;20|
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 113 '#2="failed") (222 . |extendedEuclidean|)
              (|Record| (|:| |coef1| $$) (|:| |coef2| $$)) (|Union| 116 '#2#)
              (229 . =) |FFCGP;discreteLog;2$U;21| (235 . |characteristic|)
              (239 . -) |FFCGP;-;2$;22| |FFCGP;generator;$;23|
              |FFCGP;createPrimitiveElement;$;24| |FFCGP;primitiveElement;$;25|
              |FFCGP;discreteLog;$Nni;26| |FFCGP;normalElement;$;27|
              (|Factored| $) (244 . |factor|) (|Factored| 37) (249 . |factors|)
              (254 . |createNormalElement|) (258 . |characteristic|)
              |FFCGP;characteristic;Nni;30| |FFCGP;lookup;$Pi;31| (|String|)
              (262 . |message|) (267 . |coerce|) (272 . ^)
              |FFCGP;coerce;$Of;35| |FFCGP;*;GF2$;38| (278 . /)
              |FFCGP;/;$GF$;39| |FFCGP;inv;2$;40| |FFCGP;^;$I$;43|
              |FFCGP;^;$Pi$;41| |FFCGP;^;$Nni$;42| (|Union| 67 '#3="failed")
              (|Matrix| $) (|Factored| 151) (|SparseUnivariatePolynomial| $)
              (|Union| 153 '#3#) (|List| 151) (|Union| 10 '"failed")
              (|InputForm|) (|List| $) (|Matrix| 6) (|Fraction| 37)
              (|Union| 156 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 156) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|SingleInteger|) (|HashState|))
           '#(~= 284 |zero?| 290 |unitNormal| 295 |unitCanonical| 300 |unit?|
              305 |transcendent?| 310 |transcendenceDegree| 315 |traceMatrix|
              319 |trace| 328 |tableForDiscreteLogarithm| 339 |subtractIfCan|
              344 |squareFreePolynomial| 350 |squareFreePart| 355 |squareFree|
              360 |solveLinearPolynomialEquation| 365 |smaller?| 371
              |sizeLess?| 377 |size| 383 |sample| 387 |rightRecip| 391
              |rightPower| 396 |retractIfCan| 408 |retract| 413 |represents|
              418 |representationType| 429 |rem| 433 |regularRepresentation|
              439 |recip| 450 |rank| 455 |random| 459 |quo| 463
              |principalIdeal| 469 |primitiveElement| 474 |primitive?| 478
              |primeFrobenius| 483 |prime?| 494 |order| 499 |opposite?| 509
              |one?| 515 |normalElement| 520 |normal?| 524 |norm| 529
              |nextItem| 540 |multiEuclidean| 545 |minimalPolynomial| 551
              |lookup| 562 |linearAssociatedOrder| 567 |linearAssociatedLog|
              572 |linearAssociatedExp| 583 |leftRecip| 589 |leftPower| 594
              |lcmCoef| 606 |lcm| 612 |latex| 623 |inv| 628 |init| 633 |index|
              637 |inGroundField?| 642 |hashUpdate!| 647 |hash| 653
              |getZechTable| 658 |generator| 662 |gcdPolynomial| 666 |gcd| 672
              |factorsOfCyclicGroupSize| 683 |factorSquareFreePolynomial| 687
              |factorPolynomial| 692 |factor| 697 |extensionDegree| 702
              |extendedEuclidean| 710 |exquo| 723 |expressIdealMember| 729
              |euclideanSize| 735 |enumerate| 740 |divide| 744 |discriminant|
              750 |discreteLog| 759 |differentiate| 770 |degree| 781
              |definingPolynomial| 791 |createPrimitiveElement| 795
              |createNormalElement| 799 |coordinates| 803 |convert| 825
              |conditionP| 840 |commutator| 845 |coerce| 851 |charthRoot| 876
              |characteristicPolynomial| 886 |characteristic| 891 |basis| 895
              |associator| 904 |associates?| 911 |antiCommutator| 917
              |annihilate?| 923 |algebraic?| 929 ^ 934 |Zero| 952 |One| 956
              |Frobenius| 960 D 971 = 982 / 988 - 1000 + 1011 * 1017)
           'NIL
           (CONS
            (|makeByteWordVec2| 3
                                '(0 0 2 3 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 3 1 2
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 2 0 0 2 2 0 0 0 0 0 0 0 0 0 0 0 2))
            (CONS
             '#(|FiniteAlgebraicExtensionField&| |ExtensionField&|
                |FiniteFieldCategory&| |FieldOfPrimeCharacteristic&| |Field&|
                |EuclideanDomain&| |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| |FramedAlgebra&| NIL
                |FiniteRankAlgebra&| |DivisionRing&| NIL NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL |DifferentialRing&|
                NIL |Rng&| NIL |Module&| |Module&| |Module&| NIL
                |FramedModule&| NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL
                NIL NIL |NonAssociativeRng&| NIL |AbelianGroup&| NIL NIL NIL
                NIL |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Finite&| |Magma&| |AbelianSemiGroup&| NIL NIL |RetractableTo&|
                NIL |SetCategory&| NIL NIL NIL NIL NIL NIL |BasicType&| NIL
                NIL)
             (CONS
              '#((|FiniteAlgebraicExtensionField| 6) (|ExtensionField| 6)
                 (|FiniteFieldCategory|) (|FieldOfPrimeCharacteristic|)
                 (|Field|) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|)
                 (|FramedAlgebra| 6 (|SparseUnivariatePolynomial| 6))
                 (|IntegralDomain|)
                 (|FiniteRankAlgebra| 6 (|SparseUnivariatePolynomial| 6))
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|Algebra| 6) (|Algebra| 158) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|DifferentialRing|) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| 6) (|Module| 158) (|Module| $$) (|SemiRng|)
                 (|FramedModule| 6) (|BiModule| 6 6) (|BiModule| 158 158)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|RightModule| 6)
                 (|LeftModule| 6) (|RightModule| 158) (|LeftModule| 158)
                 (|LeftModule| $$) (|NonAssociativeRng|) (|RightModule| $$)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Finite|)
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|RetractableTo| 6) (|CommutativeStar|) (|SetCategory|)
                 (|CoercibleFrom| 6) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 23)
                 (|ConvertibleTo| 155))
              (|makeByteWordVec2| 166
                                  '(1 10 9 0 11 0 6 9 13 0 10 0 16 0 21 0 22 1
                                    21 23 0 24 0 10 0 26 2 10 6 0 9 28 1 6 0 0
                                    29 0 35 0 36 1 0 41 0 42 0 6 0 47 0 6 0 48
                                    2 10 0 6 9 49 1 50 0 10 51 2 50 0 0 37 52 1
                                    50 53 0 54 2 8 41 0 0 56 1 58 39 10 59 0 60
                                    0 61 0 0 62 63 2 9 41 0 0 65 1 6 0 37 69 2
                                    73 0 2 9 74 2 73 0 0 0 75 1 0 0 0 76 2 73 0
                                    0 0 77 1 73 41 0 78 1 73 2 0 79 1 73 9 0 81
                                    2 10 0 0 0 82 1 73 0 0 83 1 92 0 53 93 0 92
                                    0 94 2 92 41 0 0 95 1 92 9 0 96 1 6 41 0 98
                                    2 6 99 0 0 100 2 37 0 0 0 101 2 8 102 0 0
                                    103 2 104 41 0 0 105 2 6 0 0 37 106 2 107
                                    41 0 0 109 2 8 0 0 0 111 3 8 114 0 0 0 115
                                    2 117 41 0 0 118 0 10 9 120 1 10 0 0 121 1
                                    37 128 0 129 1 130 86 0 131 0 0 0 132 0 6 9
                                    133 1 23 0 136 137 1 37 23 0 138 2 23 0 0 0
                                    139 2 0 0 0 0 142 2 0 41 0 0 1 1 0 41 0 42
                                    1 0 164 0 1 1 0 0 0 1 1 0 41 0 1 1 0 41 0 1
                                    0 0 9 1 1 0 157 67 1 0 0 157 1 2 2 0 0 43 1
                                    1 0 6 0 1 1 2 35 37 38 2 0 102 0 0 1 1 2
                                    150 151 1 1 0 0 0 1 1 0 128 0 1 2 2 152 153
                                    151 1 2 2 41 0 0 1 2 0 41 0 0 1 0 2 9 1 0 0
                                    0 1 1 0 102 0 1 2 0 0 0 9 1 2 0 0 0 43 1 1
                                    0 107 0 108 1 0 6 0 80 2 0 0 53 67 1 1 0 0
                                    53 97 0 2 88 89 2 0 0 0 0 1 2 0 157 0 67 1
                                    1 0 157 0 1 1 0 102 0 1 0 0 43 1 0 2 0 91 2
                                    0 0 0 0 1 1 0 162 156 1 0 2 0 125 1 2 41 0
                                    46 2 3 0 0 9 1 1 3 0 0 1 1 0 41 0 1 1 3 62
                                    0 1 1 2 43 0 44 2 0 41 0 0 1 1 0 41 0 1 0 2
                                    0 127 1 2 41 0 1 2 2 0 0 43 1 1 0 6 0 1 1 2
                                    102 0 1 2 0 159 156 0 1 1 4 10 0 84 2 2 151
                                    0 43 1 1 2 43 0 135 1 2 10 0 1 2 2 154 0 0
                                    1 1 2 10 0 1 2 2 0 0 10 1 1 0 102 0 1 2 0 0
                                    0 9 1 2 0 0 0 43 1 2 0 163 0 0 1 1 0 0 156
                                    1 2 0 0 0 0 1 1 0 136 0 1 1 0 0 0 144 0 2 0
                                    1 1 2 0 43 66 1 0 41 0 112 2 0 166 166 0 1
                                    1 0 165 0 1 0 0 39 40 0 2 0 123 2 0 151 151
                                    151 1 1 0 0 156 1 2 0 0 0 0 1 0 2 86 87 1 2
                                    150 151 1 1 2 150 151 1 1 0 128 0 1 0 0 43
                                    64 0 0 62 63 3 0 114 0 0 0 1 2 0 160 0 0 1
                                    2 0 102 0 0 1 2 0 159 156 0 1 1 0 9 0 1 0 2
                                    156 1 2 0 161 0 0 1 1 0 6 67 1 0 0 6 1 2 3
                                    99 0 0 119 1 2 9 0 126 2 2 0 0 9 1 1 2 0 0
                                    1 1 0 43 0 1 1 0 62 0 1 0 0 10 90 0 2 0 124
                                    0 2 0 132 2 0 53 0 67 1 2 0 157 67 67 1 1 0
                                    53 0 55 1 0 157 67 1 1 2 155 0 1 1 0 53 0 1
                                    1 0 0 53 1 1 5 148 149 1 2 0 0 0 0 1 1 0 0
                                    6 70 1 0 0 158 1 1 0 0 0 1 1 0 0 37 1 1 0
                                    23 0 140 1 3 102 0 1 1 2 0 0 1 1 0 10 0 1 0
                                    0 9 134 1 2 67 43 68 0 0 67 110 3 0 0 0 0 0
                                    1 2 0 41 0 0 1 2 0 0 0 0 1 2 0 41 0 0 1 1 0
                                    41 0 1 2 0 0 0 37 145 2 0 0 0 9 147 2 0 0 0
                                    43 146 0 0 0 27 0 0 0 17 2 2 0 0 9 1 1 2 0
                                    0 76 2 2 0 0 9 1 1 2 0 0 1 2 0 41 0 0 45 2
                                    0 0 0 6 143 2 0 0 0 0 142 1 0 0 0 122 2 0 0
                                    0 0 1 2 0 0 0 0 57 2 0 0 6 0 141 2 0 0 0 6
                                    1 2 0 0 158 0 1 2 0 0 0 158 1 2 0 0 9 0 1 2
                                    0 0 37 0 72 2 0 0 0 0 71 2 0 0 43 0 1)))))
           '|lookupComplete|)) 
