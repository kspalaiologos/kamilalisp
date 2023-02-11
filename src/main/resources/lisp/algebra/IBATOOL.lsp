
(SDEFUN |IBATOOL;diagonalProduct;MR;1| ((|m| (|Matrix| R)) ($ (R)))
        (SPROG
         ((|ans| (R)) (#1=#:G710 NIL) (|i| NIL) (#2=#:G711 NIL) (|j| NIL))
         (SEQ (LETT |ans| (|spadConstant| $ 9))
              (SEQ (LETT |j| (PROGN |m| 1))
                   (LETT #2# (SPADCALL |m| (QREFELT $ 13)))
                   (LETT |i| (PROGN |m| 1))
                   (LETT #1# (SPADCALL |m| (QREFELT $ 12))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |ans|
                           (SPADCALL |ans| (QAREF2O |m| |i| |j| 1 1)
                                     (QREFELT $ 14)))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |IBATOOL;matrixGcd;MRNniR;2|
        ((|mat| (|Matrix| R)) (|sing| (R)) (|n| (|NonNegativeInteger|))
         ($ (R)))
        (SPROG
         ((#1=#:G720 NIL) (|d| (R)) (|mij| (R)) (#2=#:G722 NIL) (|j| NIL)
          (#3=#:G721 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |d| |sing|)
                (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                     (COND ((|greater_SI| |i| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| |i|) (LETT #2# |n|) G190
                            (COND ((> |j| #2#) (GO G191)))
                            (SEQ
                             (COND
                              ((NULL
                                (SPADCALL
                                 (LETT |mij| (QAREF2O |mat| |i| |j| 1 1))
                                 (QREFELT $ 17)))
                               (LETT |d| (SPADCALL |d| |mij| (QREFELT $ 18)))))
                             (EXIT
                              (COND
                               ((SPADCALL |d| (|spadConstant| $ 9)
                                          (QREFELT $ 20))
                                (PROGN (LETT #1# |d|) (GO #4=#:G719))))))
                            (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |d|)))
          #4# (EXIT #1#)))) 

(SDEFUN |IBATOOL;divideIfCan!;2MRIR;3|
        ((|matrix| (|Matrix| R)) (|matrixOut| (|Matrix| R)) (|prime| (R))
         (|n| (|Integer|)) ($ (R)))
        (SPROG
         ((#1=#:G733 NIL) (|a| (|Union| R "failed")) (#2=#:G735 NIL) (|j| NIL)
          (#3=#:G734 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                 (COND ((|greater_SI| |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| |i|) (LETT #2# |n|) G190
                        (COND ((> |j| #2#) (GO G191)))
                        (SEQ
                         (LETT |a|
                               (SPADCALL (QAREF2O |matrix| |i| |j| 1 1) |prime|
                                         (QREFELT $ 24)))
                         (EXIT
                          (COND
                           ((QEQCAR |a| 1)
                            (PROGN (LETT #1# |prime|) (GO #4=#:G732)))
                           ('T
                            (QSETAREF2O |matrixOut| |i| |j| (QCDR |a|) 1 1)))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (EXIT (|spadConstant| $ 9))))
          #4# (EXIT #1#)))) 

(SDEFUN |IBATOOL;leastPower;3Nni;4|
        ((|p| #1=(|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|q| #1#) (|e| (|NonNegativeInteger|)))
               (SEQ (LETT |e| 1) (LETT |q| |p|)
                    (SEQ G190 (COND ((NULL (< |q| |n|)) (GO G191)))
                         (SEQ (LETT |e| (+ |e| 1))
                              (EXIT (LETT |q| (* |q| |p|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |e|)))) 

(SDEFUN |IBATOOL;idealiserMatrix;3M;5|
        ((|ideal| (|Matrix| R)) (|idealinv| (|Matrix| R)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G761 NIL) (|k| NIL) (#2=#:G760 NIL) (|j| NIL)
          (|m| (|Matrix| R)) (|r| (|Matrix| R)) (#3=#:G759 NIL) (|i| NIL)
          (|v| (|Vector| F)) (|mc| (|Integer|)) (|mr| (|Integer|))
          (|bigm| (|Matrix| R)) (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 28)))
              (LETT |bigm| (SPADCALL (* |n| |n|) |n| (QREFELT $ 29)))
              (LETT |mr| (PROGN |bigm| 1)) (LETT |mc| (PROGN |bigm| 1))
              (LETT |v| (SPADCALL (QREFELT $ 31)))
              (SEQ (LETT |i| 0) (LETT #3# (- |n| 1)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |r|
                          (SPADCALL
                           (SPADCALL
                            (QAREF1O |v| (+ |i| (SPADCALL |v| (QREFELT $ 33)))
                                     1)
                            (QREFELT $ 34))
                           (QREFELT $ 35)))
                    (LETT |m|
                          (SPADCALL (SPADCALL |ideal| |r| (QREFELT $ 36))
                                    |idealinv| (QREFELT $ 36)))
                    (EXIT
                     (SEQ (LETT |j| 0) (LETT #2# (- |n| 1)) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 0) (LETT #1# (- |n| 1)) G190
                                 (COND ((|greater_SI| |k| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SPADCALL |bigm|
                                             (+ (+ (* |j| |n|) |k|) |mr|)
                                             (+ |i| |mc|)
                                             (QAREF2O |m| (+ |j| |mr|)
                                                      (+ |k| |mc|) 1 1)
                                             (QREFELT $ 37))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |bigm|)))) 

(SDEFUN |IBATOOL;idealiser;3M;6|
        ((|ideal| (|Matrix| R)) (|idealinv| (|Matrix| R)) ($ (|Matrix| R)))
        (SPROG ((|bigm| (|Matrix| R)))
               (SEQ (LETT |bigm| (SPADCALL |ideal| |idealinv| (QREFELT $ 38)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |bigm| (QREFELT $ 40))
                                (QREFELT $ 41))
                      (QREFELT $ 35)))))) 

(SDEFUN |IBATOOL;idealiser;2MRM;7|
        ((|ideal| (|Matrix| R)) (|idealinv| (|Matrix| R)) (|denom| (R))
         ($ (|Matrix| R)))
        (SPROG ((|bigm| (|Matrix| R)) (#1=#:G765 NIL))
               (SEQ
                (LETT |bigm|
                      (PROG2
                          (LETT #1#
                                (SPADCALL
                                 (SPADCALL |ideal| |idealinv| (QREFELT $ 38))
                                 |denom| (QREFELT $ 43)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (|Matrix| (QREFELT $ 6))
                                        (|Union| (|Matrix| (QREFELT $ 6))
                                                 "failed")
                                        #1#)))
                (EXIT
                 (SPADCALL
                  (SPADCALL (SPADCALL |bigm| |denom| (QREFELT $ 44))
                            (QREFELT $ 41))
                  (QREFELT $ 35)))))) 

(SDEFUN |IBATOOL;moduleSum;3R;8|
        ((|mod1|
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R))))
         (|mod2|
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R))))
         ($
          (|Record| (|:| |basis| #1=(|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| #2=(|Matrix| R)))))
        (SPROG
         ((|rbinv| (|Matrix| R)) (|rb| (|Matrix| R)) (|c2| (R)) (|c1| (R))
          (|den| (R)) (|n| (|NonNegativeInteger|)) (|rbinv2| #2#)
          (|rbden2| (R)) (|rb2| #1#) (|rbinv1| #2#) (|rbden1| (R)) (|rb1| #1#))
         (SEQ (LETT |rb1| (QVELT |mod1| 0)) (LETT |rbden1| (QVELT |mod1| 1))
              (LETT |rbinv1| (QVELT |mod1| 2)) (LETT |rb2| (QVELT |mod2| 0))
              (LETT |rbden2| (QVELT |mod2| 1)) (LETT |rbinv2| (QVELT |mod2| 2))
              (COND
               ((SPADCALL |rb1| (QREFELT $ 46))
                (COND
                 ((SPADCALL |rbinv1| (QREFELT $ 46))
                  (COND
                   ((SPADCALL |rb2| (QREFELT $ 46))
                    (COND
                     ((NULL (SPADCALL |rbinv2| (QREFELT $ 46)))
                      (EXIT
                       (|error| #3="moduleSum: matrices must be square")))))
                   (#4='T (EXIT (|error| #3#)))))
                 (#4# (EXIT (|error| #3#)))))
               (#4# (EXIT (|error| #3#))))
              (COND
               ((OR
                 (SPADCALL (LETT |n| (ANROWS |rb1|)) (ANROWS |rbinv1|)
                           (QREFELT $ 47))
                 (OR (SPADCALL |n| (ANROWS |rb2|) (QREFELT $ 47))
                     (SPADCALL |n| (ANROWS |rbinv2|) (QREFELT $ 47))))
                (EXIT
                 (|error| "moduleSum: matrices of incompatible dimensions"))))
              (COND
               ((OR (SPADCALL |rbden1| (QREFELT $ 17))
                    (SPADCALL |rbden2| (QREFELT $ 17)))
                (EXIT (|error| "moduleSum: denominator must be non-zero"))))
              (LETT |den| (SPADCALL |rbden1| |rbden2| (QREFELT $ 48)))
              (LETT |c1| (SPADCALL |den| |rbden1| (QREFELT $ 49)))
              (LETT |c2| (SPADCALL |den| |rbden2| (QREFELT $ 49)))
              (LETT |rb|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |c1| |rb1| (QREFELT $ 50))
                                (SPADCALL |c2| |rb2| (QREFELT $ 50))
                                (QREFELT $ 51))
                      |den| (QREFELT $ 44))
                     (QREFELT $ 41)))
              (LETT |rbinv| (SPADCALL |rb| |den| (QREFELT $ 53)))
              (EXIT (VECTOR |rb| |den| |rbinv|))))) 

(DECLAIM (NOTINLINE |IntegralBasisTools;|)) 

(DEFUN |IntegralBasisTools| (&REST #1=#:G782)
  (SPROG NIL
         (PROG (#2=#:G783)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IntegralBasisTools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |IntegralBasisTools;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IntegralBasisTools|)))))))))) 

(DEFUN |IntegralBasisTools;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|IntegralBasisTools| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegralBasisTools|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegralBasisTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |One|) (|Integer|) (|Matrix| 6)
              (4 . |maxRowIndex|) (9 . |maxColIndex|) (14 . *)
              |IBATOOL;diagonalProduct;MR;1| (|Boolean|) (20 . |zero?|)
              (25 . |gcd|) (31 . |One|) (35 . =) (|NonNegativeInteger|)
              |IBATOOL;matrixGcd;MRNniR;2| (|Union| $ '"failed") (41 . |exquo|)
              |IBATOOL;divideIfCan!;2MRIR;3| |IBATOOL;leastPower;3Nni;4|
              (|PositiveInteger|) (47 . |rank|) (51 . |zero|) (|Vector| $)
              (57 . |basis|) (|Vector| 8) (61 . |minIndex|)
              (66 . |regularRepresentation|) (71 . |transpose|) (76 . *)
              (82 . |setelt!|) |IBATOOL;idealiserMatrix;3M;5|
              (|ModularHermitianRowReduction| 6) (90 . |rowEch|)
              (95 . |squareTop|) |IBATOOL;idealiser;3M;6| (100 . |exquo|)
              (106 . |rowEchelon|) |IBATOOL;idealiser;2MRM;7| (112 . |square?|)
              (117 . ~=) (123 . |lcm|) (129 . |quo|) (135 . *)
              (141 . |vertConcat|)
              (|TriangularMatrixOperations| 6 (|Vector| 6) (|Vector| 6) 11)
              (147 . |UpTriBddDenomInv|)
              (|Record| (|:| |basis| 11) (|:| |basisDen| 6)
                        (|:| |basisInv| 11))
              |IBATOOL;moduleSum;3R;8|)
           '#(|moduleSum| 153 |matrixGcd| 159 |leastPower| 166
              |idealiserMatrix| 172 |idealiser| 178 |divideIfCan!| 191
              |diagonalProduct| 199)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|diagonalProduct| (|#1| (|Matrix| |#1|))) T)
                              '((|matrixGcd|
                                 (|#1| (|Matrix| |#1|) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|divideIfCan!|
                                 (|#1| (|Matrix| |#1|) (|Matrix| |#1|) |#1|
                                  (|Integer|)))
                                T)
                              '((|leastPower|
                                 ((|NonNegativeInteger|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|idealiser|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|Matrix| |#1|)))
                                T)
                              '((|idealiser|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|Matrix| |#1|) |#1|))
                                T)
                              '((|idealiserMatrix|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|Matrix| |#1|)))
                                T)
                              '((|moduleSum|
                                 ((|Record| (|:| |basis| (|Matrix| |#1|))
                                            (|:| |basisDen| |#1|)
                                            (|:| |basisInv| (|Matrix| |#1|)))
                                  (|Record| (|:| |basis| (|Matrix| |#1|))
                                            (|:| |basisDen| |#1|)
                                            (|:| |basisInv| (|Matrix| |#1|)))
                                  (|Record| (|:| |basis| (|Matrix| |#1|))
                                            (|:| |basisDen| |#1|)
                                            (|:| |basisInv| (|Matrix| |#1|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 55
                                            '(0 6 0 9 1 11 10 0 12 1 11 10 0 13
                                              2 6 0 0 0 14 1 6 16 0 17 2 6 0 0
                                              0 18 0 7 0 19 2 6 16 0 0 20 2 6
                                              23 0 0 24 0 8 27 28 2 11 0 21 21
                                              29 0 8 30 31 1 32 10 0 33 1 8 11
                                              0 34 1 11 0 0 35 2 11 0 0 0 36 4
                                              11 6 0 10 10 6 37 1 39 11 11 40 1
                                              11 0 0 41 2 11 23 0 6 43 2 39 11
                                              11 6 44 1 11 16 0 46 2 21 16 0 0
                                              47 2 6 0 0 0 48 2 6 0 0 0 49 2 11
                                              0 6 0 50 2 11 0 0 0 51 2 52 11 11
                                              6 53 2 0 54 54 54 55 3 0 6 11 6
                                              21 22 2 0 21 21 21 26 2 0 11 11
                                              11 38 3 0 11 11 11 6 45 2 0 11 11
                                              11 42 4 0 6 11 11 6 10 25 1 0 6
                                              11 15)))))
           '|lookupComplete|)) 
