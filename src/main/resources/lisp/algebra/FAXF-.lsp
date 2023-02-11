
(SDEFUN |FAXF-;represents;VS;1| ((|v| (|Vector| F)) ($ (S)))
        (SPROG ((|a| (S)) (#1=#:G729 NIL) (|i| NIL) (|b| (|Vector| S)))
               (SEQ (LETT |a| (|spadConstant| $ 8))
                    (LETT |b| (SPADCALL (QREFELT $ 10)))
                    (SEQ (LETT |i| 1) (LETT #1# (SPADCALL (QREFELT $ 12))) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |a|
                                 (SPADCALL |a|
                                           (SPADCALL
                                            (SPADCALL |v| |i| (QREFELT $ 15))
                                            (SPADCALL |b| |i| (QREFELT $ 17))
                                            (QREFELT $ 18))
                                           (QREFELT $ 19)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |a|)))) 

(PUT '|FAXF-;transcendenceDegree;Nni;2| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |FAXF-;transcendenceDegree;Nni;2| (($ (|NonNegativeInteger|))) 0) 

(SDEFUN |FAXF-;extensionDegree;Opc;3|
        (($ (|OnePointCompletion| (|PositiveInteger|))))
        (SPROG ((#1=#:G733 NIL))
               (SPADCALL
                (PROG1 (LETT #1# (QVSIZE (SPADCALL (QREFELT $ 10))))
                  (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                    '(|NonNegativeInteger|) #1#))
                (QREFELT $ 24)))) 

(SDEFUN |FAXF-;degree;SOpc;4|
        ((|a| (S)) ($ (|OnePointCompletion| (|PositiveInteger|))))
        (SPADCALL (SPADCALL |a| (QREFELT $ 26)) (QREFELT $ 24))) 

(SDEFUN |FAXF-;coordinates;VM;5| ((|v| (|Vector| S)) ($ (|Matrix| F)))
        (SPROG ((#1=#:G740 NIL) (|i| NIL) (|j| NIL) (|m| (|Matrix| F)))
               (SEQ
                (LETT |m|
                      (MAKE_MATRIX1 (QVSIZE |v|) (SPADCALL (QREFELT $ 12))
                                    (|spadConstant| $ 28)))
                (SEQ (LETT |j| (PROGN |m| 1))
                     (LETT |i| (SPADCALL |v| (QREFELT $ 29)))
                     (LETT #1# (QVSIZE |v|)) G190
                     (COND ((> |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |m| |j|
                                 (SPADCALL (QAREF1O |v| |i| 1) (QREFELT $ 30))
                                 (QREFELT $ 32))))
                     (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |m|)))) 

(PUT '|FAXF-;algebraic?;SB;6| '|SPADreplace| '(XLAM (|a|) 'T)) 

(SDEFUN |FAXF-;algebraic?;SB;6| ((|a| (S)) ($ (|Boolean|))) 'T) 

(PUT '|FAXF-;transcendent?;SB;7| '|SPADreplace| '(XLAM (|a|) NIL)) 

(SDEFUN |FAXF-;transcendent?;SB;7| ((|a| (S)) ($ (|Boolean|))) NIL) 

(SDEFUN |FAXF-;extensionDegree;Pi;8| (($ (|PositiveInteger|)))
        (SPROG ((#1=#:G743 NIL))
               (PROG1 (LETT #1# (QVSIZE (SPADCALL (QREFELT $ 10))))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |FAXF-;trace;SF;9| ((|a| (S)) ($ (F)))
        (SPROG ((|abs| (F)) (#1=#:G749 NIL) (|i| NIL) (|b| (|Vector| S)))
               (SEQ (LETT |b| (SPADCALL (QREFELT $ 10)))
                    (LETT |abs| (|spadConstant| $ 28))
                    (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |b|)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |abs|
                                 (SPADCALL |abs|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |a|
                                                       (SPADCALL |b| |i|
                                                                 (QREFELT $
                                                                          17))
                                                       (QREFELT $ 38))
                                             (QREFELT $ 30))
                                            |i| (QREFELT $ 15))
                                           (QREFELT $ 39)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |abs|)))) 

(SDEFUN |FAXF-;norm;SF;10| ((|a| (S)) ($ (F)))
        (SPROG
         ((#1=#:G754 NIL) (|i| NIL) (|m| (|Matrix| F)) (|b| (|Vector| S)))
         (SEQ (LETT |b| (SPADCALL (QREFELT $ 10)))
              (LETT |m|
                    (MAKE_MATRIX1 (QVSIZE |b|) (QVSIZE |b|)
                                  (|spadConstant| $ 28)))
              (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |b|)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |m| |i|
                               (SPADCALL
                                (SPADCALL |a| (SPADCALL |b| |i| (QREFELT $ 17))
                                          (QREFELT $ 38))
                                (QREFELT $ 30))
                               (QREFELT $ 32))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |m| (QREFELT $ 41)))))) 

(SDEFUN |FAXF-;linearAssociatedExp;SSupS;11|
        ((|x| (S)) (|f| (|SparseUnivariatePolynomial| F)) ($ (S)))
        (SPROG ((|y| (S)) (|erg| (S)) (#1=#:G760 NIL) (|i| NIL))
               (SEQ (LETT |erg| (|spadConstant| $ 8)) (LETT |y| |x|)
                    (SEQ (LETT |i| 0) (LETT #1# (SPADCALL |f| (QREFELT $ 44)))
                         G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (LETT |erg|
                                (SPADCALL |erg|
                                          (SPADCALL
                                           (SPADCALL |f| |i| (QREFELT $ 45))
                                           |y| (QREFELT $ 18))
                                          (QREFELT $ 19)))
                          (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 46)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |erg|)))) 

(SDEFUN |FAXF-;linearAssociatedLog;2SU;12|
        ((|b| (S)) (|x| (S))
         ($ (|Union| (|SparseUnivariatePolynomial| F) "failed")))
        (SPROG
         ((|p| #1=(|SparseUnivariatePolynomial| F)) (#2=#:G780 NIL)
          (#3=#:G779 #1#) (#4=#:G781 #1#) (#5=#:G790 NIL) (|i| NIL)
          (|rown| (|Integer|)) (#6=#:G789 NIL) (|v| (|Vector| F))
          (|m1| (|Matrix| F)) (|l| (|List| (|List| F))) (|a| (S))
          (#7=#:G788 NIL) (|extdeg| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL |x| (|spadConstant| $ 8) (QREFELT $ 48))
            (CONS 0 (|spadConstant| $ 49)))
           (#8='T
            (SEQ
             (LETT |l|
                   (LIST
                    (SPADCALL (SPADCALL |b| (QREFELT $ 30)) (QREFELT $ 51))))
             (LETT |a| |b|) (LETT |extdeg| (SPADCALL (QREFELT $ 12)))
             (SEQ (LETT |i| 2) (LETT #7# |extdeg|) G190
                  (COND ((|greater_SI| |i| #7#) (GO G191)))
                  (SEQ (LETT |a| (SPADCALL |a| (QREFELT $ 46)))
                       (EXIT
                        (LETT |l|
                              (SPADCALL |l|
                                        (SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                                  (QREFELT $ 51))
                                        (QREFELT $ 53)))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (LETT |l|
                   (SPADCALL |l|
                             (SPADCALL (SPADCALL |x| (QREFELT $ 30))
                                       (QREFELT $ 51))
                             (QREFELT $ 53)))
             (LETT |m1|
                   (SPADCALL
                    (SPADCALL (SPADCALL |l| (QREFELT $ 54)) (QREFELT $ 55))
                    (QREFELT $ 56)))
             (LETT |v| (SPADCALL |extdeg| (QREFELT $ 57))) (LETT |rown| 1)
             (SEQ (LETT |i| 1) (LETT #6# |extdeg|) G190
                  (COND ((|greater_SI| |i| #6#) (GO G191)))
                  (SEQ
                   (EXIT
                    (COND
                     ((SPADCALL (QAREF2O |m1| |rown| |i| 1 1)
                                (|spadConstant| $ 58) (QREFELT $ 59))
                      (SEQ
                       (SPADCALL |v| |i|
                                 (QAREF2O |m1| |rown| (+ |extdeg| 1) 1 1)
                                 (QREFELT $ 61))
                       (EXIT (LETT |rown| (+ |rown| 1))))))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (LETT |p|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |i| 0) (LETT #5# (- (QVSIZE |v|) 1)) G190
                         (COND ((|greater_SI| |i| #5#) (GO G191)))
                         (SEQ
                          (EXIT
                           (PROGN
                            (LETT #4#
                                  (SPADCALL
                                   (SPADCALL |v| (+ |i| 1) (QREFELT $ 15)) |i|
                                   (QREFELT $ 62)))
                            (COND
                             (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 63))))
                             ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (COND (#2# #3#) (#8# (|spadConstant| $ 49)))))
             (EXIT
              (COND
               ((SPADCALL |p| (|spadConstant| $ 49) (QREFELT $ 64))
                (SEQ
                 (SPADCALL
                  "linearAssociatedLog: second argument not in                       group generated by first argument"
                  (QREFELT $ 68))
                 (EXIT (CONS 1 "failed"))))
               (#8# (CONS 0 |p|)))))))))) 

(SDEFUN |FAXF-;linearAssociatedLog;SSup;13|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| F)))
        (SPROG ((#1=#:G792 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL (SPADCALL (QREFELT $ 71)) |x|
                                   (QREFELT $ 72)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|SparseUnivariatePolynomial| (QREFELT $ 7))
                                 (|Union|
                                  (|SparseUnivariatePolynomial| (QREFELT $ 7))
                                  "failed")
                                 #1#)))) 

(SDEFUN |FAXF-;linearAssociatedOrder;SSup;14|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((#1=#:G799 NIL) (#2=#:G798 #3=(|SparseUnivariatePolynomial| F))
          (#4=#:G800 #3#) (#5=#:G804 NIL) (|i| NIL) (|v| (|Vector| F))
          (|l| (|List| (|List| F))) (|a| (S)) (#6=#:G803 NIL))
         (SEQ
          (COND
           ((SPADCALL |x| (|spadConstant| $ 8) (QREFELT $ 48))
            (|spadConstant| $ 49))
           (#7='T
            (SEQ
             (LETT |l|
                   (LIST
                    (SPADCALL (SPADCALL |x| (QREFELT $ 30)) (QREFELT $ 51))))
             (LETT |a| |x|)
             (SEQ (LETT |i| 1) (LETT #6# (SPADCALL (QREFELT $ 12))) G190
                  (COND ((|greater_SI| |i| #6#) (GO G191)))
                  (SEQ (LETT |a| (SPADCALL |a| (QREFELT $ 46)))
                       (EXIT
                        (LETT |l|
                              (SPADCALL |l|
                                        (SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                                  (QREFELT $ 51))
                                        (QREFELT $ 53)))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (LETT |v|
                   (|SPADfirst|
                    (SPADCALL
                     (SPADCALL (SPADCALL |l| (QREFELT $ 54)) (QREFELT $ 55))
                     (QREFELT $ 75))))
             (EXIT
              (PROGN
               (LETT #1# NIL)
               (SEQ (LETT |i| 0) (LETT #5# (- (QVSIZE |v|) 1)) G190
                    (COND ((|greater_SI| |i| #5#) (GO G191)))
                    (SEQ
                     (EXIT
                      (PROGN
                       (LETT #4#
                             (SPADCALL (SPADCALL |v| (+ |i| 1) (QREFELT $ 15))
                                       |i| (QREFELT $ 62)))
                       (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 63))))
                             ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
               (COND (#1# #2#) (#7# (|spadConstant| $ 49))))))))))) 

(SDEFUN |FAXF-;charthRoot;SU;15| ((|x| (S)) ($ (|Union| S "failed")))
        (CONS 0 (SPADCALL |x| (QREFELT $ 77)))) 

(SDEFUN |FAXF-;minimalPolynomial;SPiSup;16|
        ((|a| (S)) (|n| (|PositiveInteger|))
         ($ (|SparseUnivariatePolynomial| S)))
        (SPROG ((|u| (S)) (|f| (|SparseUnivariatePolynomial| S)))
               (SEQ
                (COND
                 ((SPADCALL (REM (SPADCALL (QREFELT $ 12)) |n|) 0
                            (QREFELT $ 80))
                  (|error|
                   "minimalPolynomial: 2. argument must divide extension degree"))
                 ('T
                  (SEQ
                   (LETT |f|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 60) 1 (QREFELT $ 82))
                          (SPADCALL |a| 0 (QREFELT $ 82)) (QREFELT $ 83)))
                   (LETT |u| (SPADCALL |a| |n| (QREFELT $ 84)))
                   (SEQ G190
                        (COND
                         ((NULL (NULL (SPADCALL |u| |a| (QREFELT $ 48))))
                          (GO G191)))
                        (SEQ
                         (LETT |f|
                               (SPADCALL |f|
                                         (SPADCALL
                                          (SPADCALL (|spadConstant| $ 60) 1
                                                    (QREFELT $ 82))
                                          (SPADCALL |u| 0 (QREFELT $ 82))
                                          (QREFELT $ 83))
                                         (QREFELT $ 85)))
                         (EXIT (LETT |u| (SPADCALL |u| |n| (QREFELT $ 84)))))
                        NIL (GO G190) G191 (EXIT NIL))
                   (EXIT |f|))))))) 

(SDEFUN |FAXF-;norm;SPiS;17| ((|e| (S)) (|s| (|PositiveInteger|)) ($ (S)))
        (SPROG
         ((#1=#:G820 NIL) (|pow| (|Integer|))
          (|qr|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|)))))
         (SEQ (LETT |qr| (DIVIDE2 (SPADCALL (QREFELT $ 12)) |s|))
              (EXIT
               (COND
                ((ZEROP (QCDR |qr|))
                 (SEQ
                  (LETT |pow|
                        (QUOTIENT2 (- (SPADCALL (QREFELT $ 89)) 1)
                                   (- (EXPT (SPADCALL (QREFELT $ 90)) |s|) 1)))
                  (EXIT
                   (SPADCALL |e|
                             (PROG1 (LETT #1# |pow|)
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#))
                             (QREFELT $ 91)))))
                ('T
                 (|error|
                  "norm: second argument must divide degree of extension"))))))) 

(SDEFUN |FAXF-;trace;SPiS;18| ((|e| (S)) (|s| (|PositiveInteger|)) ($ (S)))
        (SPROG
         ((|a| (S)) (#1=#:G830 NIL) (|i| NIL) (|q| (|NonNegativeInteger|))
          (|qr|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|)))))
         (SEQ (LETT |qr| (DIVIDE2 (SPADCALL (QREFELT $ 12)) |s|))
              (LETT |q| (SPADCALL (QREFELT $ 90)))
              (EXIT
               (COND
                ((ZEROP (QCDR |qr|))
                 (SEQ (LETT |a| (|spadConstant| $ 8))
                      (SEQ (LETT |i| 0) (LETT #1# (- (QCAR |qr|) 1)) G190
                           (COND ((|greater_SI| |i| #1#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |a|
                                   (SPADCALL |a|
                                             (SPADCALL |e|
                                                       (EXPT |q| (* |s| |i|))
                                                       (QREFELT $ 91))
                                             (QREFELT $ 19)))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |a|)))
                ('T
                 (|error|
                  "trace: second argument must divide degree of extension"))))))) 

(SDEFUN |FAXF-;size;Nni;19| (($ (|NonNegativeInteger|)))
        (EXPT (SPADCALL (QREFELT $ 90)) (SPADCALL (QREFELT $ 12)))) 

(SDEFUN |FAXF-;createNormalElement;S;20| (($ (S)))
        (SPROG
         ((#1=#:G840 NIL) (#2=#:G841 NIL) (|res| (S)) (#3=#:G834 NIL)
          (|i| NIL))
         (SEQ
          (EXIT
           (COND
            ((EQL (SPADCALL (QREFELT $ 95)) (SPADCALL (QREFELT $ 89)))
             (|spadConstant| $ 60))
            ('T
             (SEQ
              (SEQ (LETT |i| 1) G190 NIL
                   (SEQ
                    (EXIT
                     (SEQ
                      (LETT |res|
                            (SPADCALL
                             (PROG1 (LETT #3# |i|)
                               (|check_subtype2| (> #3# 0) '(|PositiveInteger|)
                                                 '(|NonNegativeInteger|) #3#))
                             (QREFELT $ 96)))
                      (EXIT
                       (COND
                        ((NULL (SPADCALL |res| (QREFELT $ 97)))
                         (PROGN
                          (LETT #1#
                                (COND
                                 ((SPADCALL |res| (QREFELT $ 98))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN
                                          (LETT #2# |res|)
                                          (GO #4=#:G839)))
                                   (GO #5=#:G836)))))
                          (GO #5#)))))))
                    #5# (EXIT #1#))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))))
          #4# (EXIT #2#)))) 

(SDEFUN |FAXF-;normal?;SB;21| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((|f| #1=(|SparseUnivariatePolynomial| S)) (#2=#:G843 NIL)
          (#3=#:G842 #1#) (#4=#:G844 #1#) (#5=#:G847 NIL) (|i| NIL)
          (|p| (|SparseUnivariatePolynomial| S)))
         (SEQ
          (LETT |p|
                (SPADCALL
                 (SPADCALL (|spadConstant| $ 60) (SPADCALL (QREFELT $ 12))
                           (QREFELT $ 82))
                 (SPADCALL (|spadConstant| $ 60) 0 (QREFELT $ 82))
                 (QREFELT $ 83)))
          (LETT |f|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #5# (- (SPADCALL (QREFELT $ 12)) 1))
                      G190 (COND ((|greater_SI| |i| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4#
                               (SPADCALL (SPADCALL |x| |i| (QREFELT $ 84)) |i|
                                         (QREFELT $ 82)))
                         (COND
                          (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 100))))
                          ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (COND (#2# #3#) (#6='T (|spadConstant| $ 101)))))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |p| |f| (QREFELT $ 102))
                       (|spadConstant| $ 103) (QREFELT $ 104))
             'T)
            (#6# NIL)))))) 

(SDEFUN |FAXF-;degree;SPi;22| ((|a| (S)) ($ (|PositiveInteger|)))
        (SPROG ((|deg| (|PositiveInteger|)) (|y| (S)))
               (SEQ (LETT |y| (SPADCALL |a| (QREFELT $ 46))) (LETT |deg| 1)
                    (SEQ G190
                         (COND
                          ((NULL (SPADCALL |y| |a| (QREFELT $ 106)))
                           (GO G191)))
                         (SEQ (LETT |y| (SPADCALL |y| (QREFELT $ 46)))
                              (EXIT (LETT |deg| (+ |deg| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |deg|)))) 

(DECLAIM (NOTINLINE |FiniteAlgebraicExtensionField&;|)) 

(DEFUN |FiniteAlgebraicExtensionField&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FiniteAlgebraicExtensionField&| DV$1 DV$2))
          (LETT $ (GETREFV 108))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Finite|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 47
                       (CONS
                        (|dispatchFunction|
                         |FAXF-;linearAssociatedExp;SSupS;11|)
                        $))
             (QSETREFV $ 70
                       (CONS
                        (|dispatchFunction| |FAXF-;linearAssociatedLog;2SU;12|)
                        $))
             (QSETREFV $ 73
                       (CONS
                        (|dispatchFunction|
                         |FAXF-;linearAssociatedLog;SSup;13|)
                        $))
             (QSETREFV $ 76
                       (CONS
                        (|dispatchFunction|
                         |FAXF-;linearAssociatedOrder;SSup;14|)
                        $))
             (QSETREFV $ 79
                       (CONS (|dispatchFunction| |FAXF-;charthRoot;SU;15|) $))
             (QSETREFV $ 87
                       (CONS
                        (|dispatchFunction|
                         |FAXF-;minimalPolynomial;SPiSup;16|)
                        $))
             (QSETREFV $ 92 (CONS (|dispatchFunction| |FAXF-;norm;SPiS;17|) $))
             (QSETREFV $ 93
                       (CONS (|dispatchFunction| |FAXF-;trace;SPiS;18|) $))
             (QSETREFV $ 94 (CONS (|dispatchFunction| |FAXF-;size;Nni;19|) $))
             (QSETREFV $ 99
                       (CONS
                        (|dispatchFunction| |FAXF-;createNormalElement;S;20|)
                        $))
             (QSETREFV $ 105
                       (CONS (|dispatchFunction| |FAXF-;normal?;SB;21|) $))
             (QSETREFV $ 107
                       (CONS (|dispatchFunction| |FAXF-;degree;SPi;22|) $)))))
          $))) 

(MAKEPROP '|FiniteAlgebraicExtensionField&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |Zero|) (|Vector| $) (4 . |basis|) (|PositiveInteger|)
              (8 . |extensionDegree|) (|Integer|) (|Vector| 7) (12 . |elt|)
              (|Vector| 6) (18 . |elt|) (24 . *) (30 . +)
              |FAXF-;represents;VS;1| (|NonNegativeInteger|)
              |FAXF-;transcendenceDegree;Nni;2| (|OnePointCompletion| 11)
              (36 . |coerce|) |FAXF-;extensionDegree;Opc;3| (41 . |degree|)
              |FAXF-;degree;SOpc;4| (46 . |Zero|) (50 . |minIndex|)
              (55 . |coordinates|) (|Matrix| 7) (60 . |setRow!|)
              |FAXF-;coordinates;VM;5| (|Boolean|) |FAXF-;algebraic?;SB;6|
              |FAXF-;transcendent?;SB;7| |FAXF-;extensionDegree;Pi;8| (67 . *)
              (73 . +) |FAXF-;trace;SF;9| (79 . |determinant|)
              |FAXF-;norm;SF;10| (|SparseUnivariatePolynomial| 7)
              (84 . |degree|) (89 . |coefficient|) (95 . |Frobenius|)
              (100 . |linearAssociatedExp|) (106 . =) (112 . |Zero|) (|List| 7)
              (116 . |entries|) (|List| 50) (121 . |concat|) (127 . |matrix|)
              (132 . |transpose|) (137 . |rowEchelon|) (142 . |zero|)
              (147 . |One|) (151 . =) (157 . |One|) (161 . |setelt!|)
              (168 . |monomial|) (174 . +) (180 . =) (|Void|) (|String|)
              (|OutputForm|) (186 . |messagePrint|) (|Union| 43 '#1="failed")
              (191 . |linearAssociatedLog|) (197 . |normalElement|)
              (201 . |linearAssociatedLog|) (207 . |linearAssociatedLog|)
              (|List| 14) (212 . |nullSpace|) (217 . |linearAssociatedOrder|)
              (222 . |charthRoot|) (|Union| $ '"failed") (227 . |charthRoot|)
              (232 . ~=) (|SparseUnivariatePolynomial| 6) (238 . |monomial|)
              (244 . -) (250 . |Frobenius|) (256 . *)
              (|SparseUnivariatePolynomial| $) (262 . |minimalPolynomial|)
              (268 . |extensionDegree|) (272 . |size|) (276 . |size|) (280 . ^)
              (286 . |norm|) (292 . |trace|) (298 . |size|)
              (302 . |characteristic|) (306 . |index|) (311 . |inGroundField?|)
              (316 . |normal?|) (321 . |createNormalElement|) (325 . +)
              (331 . |Zero|) (335 . |gcd|) (341 . |One|) (345 . =)
              (351 . |normal?|) (356 . ~=) (362 . |degree|))
           '#(|transcendent?| 367 |transcendenceDegree| 372 |trace| 376 |size|
              387 |represents| 391 |normal?| 396 |norm| 401 |minimalPolynomial|
              412 |linearAssociatedOrder| 418 |linearAssociatedLog| 423
              |linearAssociatedExp| 434 |extensionDegree| 440 |degree| 448
              |createNormalElement| 458 |coordinates| 462 |charthRoot| 467
              |algebraic?| 472)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|charthRoot| ((|Union| |#1| "failed") |#1|))
                                T)
                              '((|charthRoot| (|#1| |#1|)) T)
                              '((|linearAssociatedLog|
                                 ((|Union| (|SparseUnivariatePolynomial| |#2|)
                                           #1#)
                                  |#1| |#1|))
                                T)
                              '((|linearAssociatedLog|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|linearAssociatedOrder|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|linearAssociatedExp|
                                 (|#1| |#1|
                                  (|SparseUnivariatePolynomial| |#2|)))
                                T)
                              '((|normal?| ((|Boolean|) |#1|)) T)
                              '((|createNormalElement| (|#1|)) T)
                              '((|trace| (|#1| |#1| (|PositiveInteger|))) T)
                              '((|norm| (|#1| |#1| (|PositiveInteger|))) T)
                              '((|minimalPolynomial|
                                 ((|SparseUnivariatePolynomial| |#1|) |#1|
                                  (|PositiveInteger|)))
                                T)
                              '((|degree| ((|PositiveInteger|) |#1|)) T)
                              '((|extensionDegree| ((|PositiveInteger|))) T)
                              '((|trace| (|#2| |#1|)) T)
                              '((|norm| (|#2| |#1|)) T)
                              '((|coordinates|
                                 ((|Vector| |#2|) |#1| (|Vector| |#1|)))
                                T)
                              '((|coordinates|
                                 ((|Matrix| |#2|) (|Vector| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((|represents|
                                 (|#1| (|Vector| |#2|) (|Vector| |#1|)))
                                T)
                              '((|minimalPolynomial|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|size| ((|NonNegativeInteger|))) T)
                              '((|represents| (|#1| (|Vector| |#2|))) T)
                              '((|coordinates|
                                 ((|Matrix| |#2|) (|Vector| |#1|)))
                                T)
                              '((|coordinates| ((|Vector| |#2|) |#1|)) T)
                              '((|transcendenceDegree|
                                 ((|NonNegativeInteger|)))
                                T)
                              '((|extensionDegree|
                                 ((|OnePointCompletion| (|PositiveInteger|))))
                                T)
                              '((|degree|
                                 ((|OnePointCompletion| (|PositiveInteger|))
                                  |#1|))
                                T)
                              '((|transcendent?| ((|Boolean|) |#1|)) T)
                              '((|algebraic?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 107
                                            '(0 6 0 8 0 6 9 10 0 6 11 12 2 14 7
                                              0 13 15 2 16 6 0 13 17 2 6 0 7 0
                                              18 2 6 0 0 0 19 1 23 0 11 24 1 6
                                              11 0 26 0 7 0 28 1 16 13 0 29 1 6
                                              14 0 30 3 31 0 0 13 14 32 2 6 0 0
                                              0 38 2 7 0 0 0 39 1 31 7 0 41 1
                                              43 21 0 44 2 43 7 0 21 45 1 6 0 0
                                              46 2 0 0 0 43 47 2 6 34 0 0 48 0
                                              43 0 49 1 14 50 0 51 2 52 0 0 50
                                              53 1 31 0 52 54 1 31 0 0 55 1 31
                                              0 0 56 1 14 0 21 57 0 7 0 58 2 7
                                              34 0 0 59 0 6 0 60 3 14 7 0 13 7
                                              61 2 43 0 7 21 62 2 43 0 0 0 63 2
                                              43 34 0 0 64 1 67 65 66 68 2 0 69
                                              0 0 70 0 6 0 71 2 6 69 0 0 72 1 0
                                              43 0 73 1 31 74 0 75 1 0 43 0 76
                                              1 6 0 0 77 1 0 78 0 79 2 21 34 0
                                              0 80 2 81 0 6 21 82 2 81 0 0 0 83
                                              2 6 0 0 21 84 2 81 0 0 0 85 2 0
                                              86 0 11 87 0 6 23 88 0 6 21 89 0
                                              7 21 90 2 6 0 0 21 91 2 0 0 0 11
                                              92 2 0 0 0 11 93 0 0 21 94 0 6 21
                                              95 1 6 0 11 96 1 6 34 0 97 1 6 34
                                              0 98 0 0 0 99 2 81 0 0 0 100 0 81
                                              0 101 2 81 0 0 0 102 0 81 0 103 2
                                              81 34 0 0 104 1 0 34 0 105 2 6 34
                                              0 0 106 1 0 11 0 107 1 0 34 0 36
                                              0 0 21 22 2 0 0 0 11 93 1 0 7 0
                                              40 0 0 21 94 1 0 0 14 20 1 0 34 0
                                              105 2 0 0 0 11 92 1 0 7 0 42 2 0
                                              86 0 11 87 1 0 43 0 76 2 0 69 0 0
                                              70 1 0 43 0 73 2 0 0 0 43 47 0 0
                                              11 37 0 0 23 25 1 0 11 0 107 1 0
                                              23 0 27 0 0 0 99 1 0 31 9 33 1 0
                                              78 0 79 1 0 34 0 35)))))
           '|lookupComplete|)) 
