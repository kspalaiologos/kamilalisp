
(SDEFUN |FFINTBAS;squaredFactors| ((|px| (R)) ($ (R)))
        (SPROG
         ((#1=#:G711 NIL) (#2=#:G710 (R)) (#3=#:G712 (R)) (#4=#:G719 NIL)
          (|ffe| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |ffe| NIL)
                (LETT #4#
                      (SPADCALL (SPADCALL |px| (QREFELT $ 10)) (QREFELT $ 15)))
                G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |ffe| (CAR #4#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (COND ((> (QVELT |ffe| 2) 1) (QVELT |ffe| 1))
                               ('T (|spadConstant| $ 16))))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 17))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 16))))))) 

(SDEFUN |FFINTBAS;iIntegralBasis|
        ((|tfm| (|Matrix| R)) (|disc| (R)) (|sing| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((#1=#:G726 NIL) (#2=#:G738 NIL) (|oldIndex| (R)) (|indexChange| (R))
          (|rbinv| #3=(|Matrix| R)) (|rbden| (R)) (|rb| #3#) (|g| (R))
          (|index| (R)) (|idinv| (|Matrix| R)) (|id| (|Matrix| R))
          (|disc0| (R)) (|tfm0| (|Matrix| R)) (|n| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL (QREFELT $ 19)))
                (LETT |tfm0| (SPADCALL |tfm| (QREFELT $ 21)))
                (LETT |disc0| |disc|)
                (LETT |rb| (SPADCALL |n| (|spadConstant| $ 16) (QREFELT $ 24)))
                (LETT |rbinv|
                      (SPADCALL |n| (|spadConstant| $ 16) (QREFELT $ 24)))
                (LETT |rbden| (|spadConstant| $ 16))
                (LETT |index| (|spadConstant| $ 16))
                (LETT |oldIndex| (|spadConstant| $ 16))
                (COND
                 ((NULL (SPADCALL (|spadConstant| $ 16) |sing| (QREFELT $ 26)))
                  (EXIT (VECTOR |rb| |rbden| |rbinv|))))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (LETT |idinv|
                             (SPADCALL
                              (SPADCALL (SPADCALL |tfm| |sing| (QREFELT $ 28))
                                        (QREFELT $ 29))
                              (QREFELT $ 30)))
                       (LETT |id|
                             (SPADCALL (SPADCALL |idinv| |sing| (QREFELT $ 32))
                                       (QREFELT $ 33)))
                       (LETT |idinv| (SPADCALL |id| |sing| (QREFELT $ 34)))
                       (LETT |rbinv|
                             (SPADCALL (SPADCALL |id| |rb| (QREFELT $ 35))
                                       (SPADCALL |rbinv| |idinv|
                                                 (QREFELT $ 35))
                                       (SPADCALL |sing| |rbden| (QREFELT $ 17))
                                       (QREFELT $ 37)))
                       (LETT |index| (SPADCALL |rbinv| (QREFELT $ 38)))
                       (LETT |rb|
                             (SPADCALL
                              (SPADCALL |rbinv|
                                        (SPADCALL |rbden| |sing|
                                                  (QREFELT $ 17))
                                        (QREFELT $ 32))
                              (QREFELT $ 33)))
                       (LETT |g| (SPADCALL |rb| |sing| |n| (QREFELT $ 39)))
                       (COND
                        ((SPADCALL (|spadConstant| $ 16) |g| (QREFELT $ 26))
                         (LETT |rb|
                               (PROG2
                                   (LETT #1#
                                         (SPADCALL |rb| |g| (QREFELT $ 41)))
                                   (QCDR #1#)
                                 (|check_union2| (QEQCAR #1# 0)
                                                 (|Matrix| (QREFELT $ 6))
                                                 (|Union|
                                                  (|Matrix| (QREFELT $ 6))
                                                  #4="failed")
                                                 #1#)))))
                       (LETT |rbden|
                             (SPADCALL |rbden|
                                       (SPADCALL |sing| |g| (QREFELT $ 42))
                                       (QREFELT $ 17)))
                       (LETT |rbinv| (SPADCALL |rb| |rbden| (QREFELT $ 34)))
                       (LETT |disc|
                             (SPADCALL |disc0|
                                       (SPADCALL |index| |index|
                                                 (QREFELT $ 17))
                                       (QREFELT $ 42)))
                       (LETT |indexChange|
                             (SPADCALL |index| |oldIndex| (QREFELT $ 42)))
                       (LETT |oldIndex| |index|)
                       (LETT |sing|
                             (SPADCALL |indexChange|
                                       (|FFINTBAS;squaredFactors| |disc| $)
                                       (QREFELT $ 43)))
                       (COND
                        ((NULL
                          (SPADCALL (|spadConstant| $ 16) |sing|
                                    (QREFELT $ 26)))
                         (EXIT
                          (PROGN
                           (LETT #2# (VECTOR |rb| |rbden| |rbinv|))
                           (GO #5=#:G737)))))
                       (EXIT
                        (LETT |tfm|
                              (PROG2
                                  (LETT #1#
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |rb| |tfm0| (QREFELT $ 35))
                                          (SPADCALL |rb| (QREFELT $ 30))
                                          (QREFELT $ 35))
                                         (SPADCALL |rbden| |rbden|
                                                   (QREFELT $ 17))
                                         (QREFELT $ 41)))
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0)
                                                (|Matrix| (QREFELT $ 6))
                                                (|Union|
                                                 (|Matrix| (QREFELT $ 6)) #4#)
                                                #1#)))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |FFINTBAS;integralBasis;R;3|
        (($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|sing| (R)) (|disc| (R)) (|tfm| (|Matrix| R))
          (|p| (|NonNegativeInteger|)) (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 19)))
              (LETT |p| (SPADCALL (QREFELT $ 44)))
              (COND
               ((NULL (ZEROP |p|))
                (COND
                 ((>= |n| |p|)
                  (EXIT
                   (|error| "integralBasis: possible wild ramification"))))))
              (LETT |tfm| (SPADCALL (QREFELT $ 45)))
              (LETT |disc| (SPADCALL |tfm| (QREFELT $ 46)))
              (LETT |sing| (|FFINTBAS;squaredFactors| |disc| $))
              (EXIT (|FFINTBAS;iIntegralBasis| |tfm| |disc| |sing| $))))) 

(SDEFUN |FFINTBAS;localIntegralBasis;RR;4|
        ((|prime| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|disc| (R)) (|tfm| (|Matrix| R)) (|p| (|NonNegativeInteger|))
          (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 19)))
              (LETT |p| (SPADCALL (QREFELT $ 44)))
              (COND
               ((NULL (ZEROP |p|))
                (COND
                 ((>= |n| |p|)
                  (EXIT
                   (|error| "integralBasis: possible wild ramification"))))))
              (LETT |tfm| (SPADCALL (QREFELT $ 45)))
              (LETT |disc| (SPADCALL |tfm| (QREFELT $ 46)))
              (EXIT
               (COND
                ((QEQCAR
                  (SPADCALL |disc| (SPADCALL |prime| |prime| (QREFELT $ 17))
                            (QREFELT $ 49))
                  1)
                 (VECTOR (SPADCALL |n| (|spadConstant| $ 16) (QREFELT $ 24))
                         (|spadConstant| $ 16)
                         (SPADCALL |n| (|spadConstant| $ 16) (QREFELT $ 24))))
                ('T (|FFINTBAS;iIntegralBasis| |tfm| |disc| |prime| $))))))) 

(DECLAIM (NOTINLINE |FunctionFieldIntegralBasis;|)) 

(DEFUN |FunctionFieldIntegralBasis| (&REST #1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionFieldIntegralBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FunctionFieldIntegralBasis;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionFieldIntegralBasis|)))))))))) 

(DEFUN |FunctionFieldIntegralBasis;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FunctionFieldIntegralBasis| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 51))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionFieldIntegralBasis|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FunctionFieldIntegralBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Factored| $) (0 . |squareFree|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 11) (|:| |factor| 6) (|:| |exponent| 23))
              (|List| 12) (|Factored| 6) (5 . |factorList|) (10 . |One|)
              (14 . *) (|PositiveInteger|) (20 . |rank|) (|Matrix| 6)
              (24 . |copy|) (29 . |One|) (|NonNegativeInteger|)
              (33 . |scalarMatrix|) (|Boolean|) (39 . |sizeLess?|)
              (|ModularHermitianRowReduction| 6) (45 . |rowEchelon|)
              (51 . |squareTop|) (56 . |transpose|)
              (|TriangularMatrixOperations| 6 (|Vector| 6) (|Vector| 6) 20)
              (61 . |LowTriBddDenomInv|) (67 . |rowEchelon|)
              (72 . |UpTriBddDenomInv|) (78 . *) (|IntegralBasisTools| 6 7 8)
              (84 . |idealiser|) (91 . |diagonalProduct|) (96 . |matrixGcd|)
              (|Union| $ '"failed") (103 . |exquo|) (109 . |quo|) (115 . |gcd|)
              (121 . |characteristic|) (125 . |traceMatrix|)
              (129 . |determinant|)
              (|Record| (|:| |basis| 20) (|:| |basisDen| 6)
                        (|:| |basisInv| 20))
              |FFINTBAS;integralBasis;R;3| (134 . |exquo|)
              |FFINTBAS;localIntegralBasis;RR;4|)
           '#(|localIntegralBasis| 140 |integralBasis| 145) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|integralBasis|
                                 ((|Record| (|:| |basis| (|Matrix| |#1|))
                                            (|:| |basisDen| |#1|)
                                            (|:| |basisInv| (|Matrix| |#1|)))))
                                T)
                              '((|localIntegralBasis|
                                 ((|Record| (|:| |basis| (|Matrix| |#1|))
                                            (|:| |basisDen| |#1|)
                                            (|:| |basisInv| (|Matrix| |#1|)))
                                  |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 50
                                            '(1 6 9 0 10 1 14 13 0 15 0 6 0 16
                                              2 6 0 0 0 17 0 8 18 19 1 20 0 0
                                              21 0 7 0 22 2 20 0 23 6 24 2 6 25
                                              0 0 26 2 27 20 20 6 28 1 20 0 0
                                              29 1 20 0 0 30 2 31 20 20 6 32 1
                                              20 0 0 33 2 31 20 20 6 34 2 20 0
                                              0 0 35 3 36 20 20 20 6 37 1 36 6
                                              20 38 3 36 6 20 6 23 39 2 20 40 0
                                              6 41 2 6 0 0 0 42 2 6 0 0 0 43 0
                                              8 23 44 0 8 20 45 1 20 6 0 46 2 6
                                              40 0 0 49 1 0 47 6 50 0 0 47
                                              48)))))
           '|lookupComplete|)) 
