
(SDEFUN |FSRED;newReduc;IV;1| ((|n| (|Integer|)) ($ (|Void|)))
        (SPROG ((#1=#:G708 NIL) (|k| NIL))
               (SEQ (SETELT $ 12 |n|)
                    (EXIT
                     (SEQ (LETT |k| NIL)
                          (LETT #1# (SPADCALL (QREFELT $ 11) (QREFELT $ 14)))
                          G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT (SPADCALL |k| (QREFELT $ 11) (QREFELT $ 17))))
                          (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |FSRED;bringDown;FKSup;2|
        ((|f| (F)) (|k| (|Kernel| F))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|bc|
           (|Union|
            (|Record|
             (|:| |coef1|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
             (|:| |coef2|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
            "failed"))
          (|m| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|ff| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (SEQ (LETT |ff| (SPADCALL |f| |k| (QREFELT $ 23)))
              (LETT |bc|
                    (SPADCALL
                     (SPADCALL (ELT $ 25) (SPADCALL |ff| (QREFELT $ 28))
                               (QREFELT $ 32))
                     (LETT |m|
                           (SPADCALL (ELT $ 25) (SPADCALL |k| (QREFELT $ 34))
                                     (QREFELT $ 32)))
                     (|spadConstant| $ 35) (QREFELT $ 38)))
              (EXIT
               (COND ((QEQCAR |bc| 1) (|error| "denominator is 0"))
                     ('T
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (ELT $ 25) (SPADCALL |ff| (QREFELT $ 39))
                                  (QREFELT $ 32))
                        (QCAR (QCDR |bc|)) (QREFELT $ 40))
                       |m| (QREFELT $ 41)))))))) 

(SDEFUN |FSRED;bringDown;FF;3| ((|f| (F)) ($ (|Fraction| (|Integer|))))
        (SPROG
         ((#1=#:G731 NIL) (|k| NIL) (#2=#:G730 NIL)
          (|lk| (|List| (|Kernel| F))))
         (SEQ
          (SPADCALL
           (SPADCALL |f| (LETT |lk| (SPADCALL |f| (QREFELT $ 44)))
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |k| NIL) (LETT #1# |lk|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT (LETT #2# (CONS (|FSRED;K2Z| |k| $) #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 46))
           (QREFELT $ 47))))) 

(SDEFUN |FSRED;K2Z| ((|k| (|Kernel| F)) ($ (F)))
        (SPROG ((|u| (|Union| (|Integer|) "failed")))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |k| (QREFELT $ 49)) (QREFELT $ 8)
                            (QREFELT $ 52))
                  (|error| "Cannot reduce constant field"))
                 (#1='T
                  (SEQ (LETT |u| (SPADCALL |k| (QREFELT $ 11) (QREFELT $ 53)))
                       (EXIT
                        (COND
                         ((QEQCAR |u| 1)
                          (SPADCALL
                           (SPADCALL (QREFELT $ 11) |k| (RANDOM (QREFELT $ 12))
                                     (QREFELT $ 54))
                           (QREFELT $ 55)))
                         (#1# (SPADCALL (QCDR |u|) (QREFELT $ 55))))))))))) 

(DECLAIM (NOTINLINE |FunctionSpaceReduce;|)) 

(DEFUN |FunctionSpaceReduce| (&REST #1=#:G738)
  (SPROG NIL
         (PROG (#2=#:G739)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceReduce|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FunctionSpaceReduce;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FunctionSpaceReduce|)))))))))) 

(DEFUN |FunctionSpaceReduce;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpaceReduce| DV$1 DV$2))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionSpaceReduce|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|%alg|)
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 12 (EXPT 10 6))
          $))) 

(MAKEPROP '|FunctionSpaceReduce| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'ALGOP
              (|AssociationList| 16 19) (0 . |table|) '|redmap| '|nn|
              (|List| 16) (4 . |keys|) (|Union| 19 '"failed") (|Kernel| 7)
              (9 . |remove!|) (|Void|) (|Integer|) |FSRED;newReduc;IV;1|
              (|Fraction| 33) (|Kernel| $) (15 . |univariate|) (|Fraction| 19)
              |FSRED;bringDown;FF;3| (|SparseUnivariatePolynomial| 7)
              (|Fraction| 26) (21 . |denom|) (|SparseUnivariatePolynomial| 24)
              (|Mapping| 24 7) (|SparseUnivariatePolynomialFunctions2| 7 24)
              (26 . |map|) (|SparseUnivariatePolynomial| $) (32 . |minPoly|)
              (37 . |One|) (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 36 '"failed") (41 . |extendedEuclidean|) (48 . |numer|)
              (53 . *) (59 . |rem|) |FSRED;bringDown;FKSup;2| (|List| 22)
              (65 . |kernels|) (|List| $) (70 . |eval|) (77 . |retract|)
              (|BasicOperator|) (82 . |operator|) (|Boolean|) (|Symbol|)
              (87 . |has?|) (93 . |search|) (99 . |setelt!|) (106 . |coerce|))
           '#(|newReduc| 111 |bringDown| 116) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|bringDown| ((|Fraction| (|Integer|)) |#2|))
                                T)
                              '((|bringDown|
                                 ((|SparseUnivariatePolynomial|
                                   (|Fraction| (|Integer|)))
                                  |#2| (|Kernel| |#2|)))
                                T)
                              '((|newReduc| ((|Void|) (|Integer|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 55
                                            '(0 9 0 10 1 9 13 0 14 2 9 15 16 0
                                              17 2 7 21 0 22 23 1 27 26 0 28 2
                                              31 29 30 26 32 1 7 33 22 34 0 29
                                              0 35 3 29 37 0 0 0 38 1 27 26 0
                                              39 2 29 0 0 0 40 2 29 0 0 0 41 1
                                              7 43 0 44 3 7 0 0 43 45 46 1 7 24
                                              0 47 1 16 48 0 49 2 48 50 0 51 52
                                              2 9 15 16 0 53 3 9 19 0 16 19 54
                                              1 7 0 19 55 1 0 18 19 20 1 0 24 7
                                              25 2 0 29 7 16 42)))))
           '|lookupComplete|)) 
