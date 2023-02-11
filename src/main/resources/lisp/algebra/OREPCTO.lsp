
(SDEFUN |OREPCTO;times;2CAMC;1|
        ((|x| (C)) (|y| (C)) (|sigma| (|Automorphism| R))
         (|delta| (|Mapping| R R)) ($ (C)))
        (COND ((SPADCALL |y| (QREFELT $ 9)) (|spadConstant| $ 10))
              ('T
               (QCAR
                (|OREPCTO;times2| (SPADCALL |x| (QREFELT $ 12)) |x| |y| |sigma|
                 |delta| $))))) 

(SDEFUN |OREPCTO;times2|
        ((|n| (|NonNegativeInteger|)) (|x| (C)) (|y| (C))
         (|sigma| (|Automorphism| R)) (|delta| (|Mapping| R R))
         ($ (|Record| (|:| |prod| C) (|:| |yton| C))))
        (SPROG
         ((|y1| (C)) (|z| (C)) (|b| (R)) (|m| (|NonNegativeInteger|))
          (|pp| (|Record| (|:| |prod| C) (|:| |yton| C))) (|x1| (C))
          (|n1| (|NonNegativeInteger|))
          (|u| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ (LETT |u| (SPADCALL |n| 1 (QREFELT $ 19)))
              (EXIT
               (COND
                ((QEQCAR |u| 1)
                 (COND
                  ((SPADCALL |x| (QREFELT $ 9))
                   (CONS (|spadConstant| $ 10) |y|))
                  (#1='T
                   (CONS
                    (SPADCALL (SPADCALL |x| (QREFELT $ 21)) |y| (QREFELT $ 22))
                    |y|))))
                (#1#
                 (SEQ (LETT |n1| (QCDR |u|))
                      (LETT |x1|
                            (COND
                             ((EQL |n| (SPADCALL |x| (QREFELT $ 12)))
                              (SPADCALL |x| (QREFELT $ 23)))
                             (#1# |x|)))
                      (LETT |pp|
                            (|OREPCTO;times2| |n1| |x1| |y| |sigma| |delta| $))
                      (LETT |y1| (QCDR |pp|)) (LETT |z| (|spadConstant| $ 10))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL |y1| (|spadConstant| $ 10)
                                        (QREFELT $ 24)))
                             (GO G191)))
                           (SEQ (LETT |m| (SPADCALL |y1| (QREFELT $ 12)))
                                (LETT |b| (SPADCALL |y1| (QREFELT $ 21)))
                                (LETT |z|
                                      (SPADCALL
                                       (SPADCALL |z|
                                                 (SPADCALL
                                                  (SPADCALL |sigma| |b|
                                                            (QREFELT $ 25))
                                                  (+ |m| 1) (QREFELT $ 26))
                                                 (QREFELT $ 27))
                                       (SPADCALL (SPADCALL |b| |delta|) |m|
                                                 (QREFELT $ 26))
                                       (QREFELT $ 27)))
                                (EXIT
                                 (LETT |y1| (SPADCALL |y1| (QREFELT $ 23)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((EQL |n| (SPADCALL |x| (QREFELT $ 12)))
                         (CONS
                          (SPADCALL
                           (SPADCALL (SPADCALL |x| (QREFELT $ 21)) |z|
                                     (QREFELT $ 22))
                           (QCAR |pp|) (QREFELT $ 27))
                          |z|))
                        (#1# (CONS (QCAR |pp|) |z|))))))))))) 

(SDEFUN |OREPCTO;apply;C2RAMR;3|
        ((|p| (C)) (|c| (R)) (|x| (R)) (|sigma| (|Automorphism| R))
         (|delta| (|Mapping| R R)) ($ (R)))
        (SPROG ((|xn| (R)) (|w| (R)) (#1=#:G730 NIL) (|i| NIL))
               (SEQ (LETT |w| (|spadConstant| $ 20)) (LETT |xn| |x|)
                    (SEQ (LETT |i| 0) (LETT #1# (SPADCALL |p| (QREFELT $ 12)))
                         G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (LETT |w|
                                (SPADCALL |w|
                                          (SPADCALL
                                           (SPADCALL |p| |i| (QREFELT $ 28))
                                           |xn| (QREFELT $ 29))
                                          (QREFELT $ 30)))
                          (EXIT
                           (LETT |xn|
                                 (SPADCALL
                                  (SPADCALL |c|
                                            (SPADCALL |sigma| |xn|
                                                      (QREFELT $ 25))
                                            (QREFELT $ 29))
                                  (SPADCALL |xn| |delta|) (QREFELT $ 30)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |w|)))) 

(SDEFUN |OREPCTO;localLeftDivide|
        ((|a| (C)) (|b| (C)) (|sigma| (|Automorphism| R)) (|b1| (R))
         ($ (|Record| (|:| |quotient| C) (|:| |remainder| C))))
        (SPROG
         ((|qr| (|Record| (|:| |quotient| C) (|:| |remainder| C))) (|a1| (C))
          (|q| (C)) (#1=#:G740 NIL)
          (|n| (|Union| (|NonNegativeInteger|) "failed"))
          (|m| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL |b| (QREFELT $ 9)) (|error| "leftDivide: division by 0"))
           (#2='T
            (SEQ
             (EXIT
              (SEQ
               (COND
                ((SPADCALL |a| (QREFELT $ 9))
                 (EXIT (CONS (|spadConstant| $ 10) |a|)))
                (#2#
                 (SEQ
                  (LETT |n|
                        (SPADCALL (SPADCALL |a| (QREFELT $ 12))
                                  (LETT |m| (SPADCALL |b| (QREFELT $ 12)))
                                  (QREFELT $ 19)))
                  (EXIT
                   (COND
                    ((QEQCAR |n| 1)
                     (PROGN
                      (LETT #1# (CONS (|spadConstant| $ 10) |a|))
                      (GO #3=#:G737))))))))
               (LETT |q|
                     (SPADCALL
                      (SPADCALL (SPADCALL |sigma| (- |m|) (QREFELT $ 33))
                                (SPADCALL |b1| (SPADCALL |a| (QREFELT $ 21))
                                          (QREFELT $ 29))
                                (QREFELT $ 25))
                      (QCDR |n|) (QREFELT $ 26)))
               (LETT |a1|
                     (SPADCALL (SPADCALL |a| (QREFELT $ 23))
                               (SPADCALL (SPADCALL |b| |q| (QREFELT $ 34))
                                         (QREFELT $ 23))
                               (QREFELT $ 35)))
               (LETT |qr| (|OREPCTO;localLeftDivide| |a1| |b| |sigma| |b1| $))
               (EXIT
                (CONS (SPADCALL |q| (QCAR |qr|) (QREFELT $ 27)) (QCDR |qr|)))))
             #3# (EXIT #1#))))))) 

(SDEFUN |OREPCTO;localRightDivide|
        ((|a| (C)) (|b| (C)) (|sigma| (|Automorphism| R)) (|b1| (R))
         ($ (|Record| (|:| |quotient| C) (|:| |remainder| C))))
        (SPROG
         ((|qr| (|Record| (|:| |quotient| C) (|:| |remainder| C))) (|a1| (C))
          (|q| (C)) (#1=#:G750 NIL)
          (|n| (|Union| (|NonNegativeInteger|) "failed"))
          (|m| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL |b| (QREFELT $ 9))
            (|error| "rightDivide: division by 0"))
           (#2='T
            (SEQ
             (EXIT
              (SEQ
               (COND
                ((SPADCALL |a| (QREFELT $ 9))
                 (EXIT (CONS (|spadConstant| $ 10) |a|)))
                (#2#
                 (SEQ
                  (LETT |n|
                        (SPADCALL (SPADCALL |a| (QREFELT $ 12))
                                  (LETT |m| (SPADCALL |b| (QREFELT $ 12)))
                                  (QREFELT $ 19)))
                  (EXIT
                   (COND
                    ((QEQCAR |n| 1)
                     (PROGN
                      (LETT #1# (CONS (|spadConstant| $ 10) |a|))
                      (GO #3=#:G747))))))))
               (LETT |q|
                     (SPADCALL
                      (SPADCALL (SPADCALL |a| (QREFELT $ 21))
                                (SPADCALL
                                 (SPADCALL |sigma| (QCDR |n|) (QREFELT $ 33))
                                 |b1| (QREFELT $ 25))
                                (QREFELT $ 29))
                      (QCDR |n|) (QREFELT $ 26)))
               (LETT |a1|
                     (SPADCALL (SPADCALL |a| (QREFELT $ 23))
                               (SPADCALL (SPADCALL |q| |b| (QREFELT $ 34))
                                         (QREFELT $ 23))
                               (QREFELT $ 35)))
               (LETT |qr| (|OREPCTO;localRightDivide| |a1| |b| |sigma| |b1| $))
               (EXIT
                (CONS (SPADCALL |q| (QCAR |qr|) (QREFELT $ 27)) (QCDR |qr|)))))
             #3# (EXIT #1#))))))) 

(SDEFUN |OREPCTO;monicLeftDivide;2CAR;6|
        ((|a| (C)) (|b| (C)) (|sigma| (|Automorphism| R))
         ($ (|Record| (|:| |quotient| C) (|:| |remainder| C))))
        (SPROG ((#1=#:G753 NIL) (|u| (R)))
               (COND
                ((SPADCALL (LETT |u| (SPADCALL |b| (QREFELT $ 21)))
                           (QREFELT $ 36))
                 (|OREPCTO;localLeftDivide| |a| |b| |sigma|
                  (PROG2 (LETT #1# (SPADCALL |u| (QREFELT $ 37)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                    (|Union| (QREFELT $ 6) "failed") #1#))
                  $))
                ('T (|error| "monicLeftDivide: divisor is not monic"))))) 

(SDEFUN |OREPCTO;monicRightDivide;2CAR;7|
        ((|a| (C)) (|b| (C)) (|sigma| (|Automorphism| R))
         ($ (|Record| (|:| |quotient| C) (|:| |remainder| C))))
        (SPROG ((#1=#:G760 NIL) (|u| (R)))
               (COND
                ((SPADCALL (LETT |u| (SPADCALL |b| (QREFELT $ 21)))
                           (QREFELT $ 36))
                 (|OREPCTO;localRightDivide| |a| |b| |sigma|
                  (PROG2 (LETT #1# (SPADCALL |u| (QREFELT $ 37)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                    (|Union| (QREFELT $ 6) "failed") #1#))
                  $))
                ('T (|error| "monicRightDivide: divisor is not monic"))))) 

(SDEFUN |OREPCTO;leftDivide;2CAR;8|
        ((|a| (C)) (|b| (C)) (|sigma| (|Automorphism| R))
         ($ (|Record| (|:| |quotient| C) (|:| |remainder| C))))
        (|OREPCTO;localLeftDivide| |a| |b| |sigma|
         (SPADCALL (SPADCALL |b| (QREFELT $ 21)) (QREFELT $ 41)) $)) 

(SDEFUN |OREPCTO;rightDivide;2CAR;9|
        ((|a| (C)) (|b| (C)) (|sigma| (|Automorphism| R))
         ($ (|Record| (|:| |quotient| C) (|:| |remainder| C))))
        (|OREPCTO;localRightDivide| |a| |b| |sigma|
         (SPADCALL (SPADCALL |b| (QREFELT $ 21)) (QREFELT $ 41)) $)) 

(DECLAIM (NOTINLINE |UnivariateSkewPolynomialCategoryOps;|)) 

(DEFUN |UnivariateSkewPolynomialCategoryOps| (&REST #1=#:G768)
  (SPROG NIL
         (PROG (#2=#:G769)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariateSkewPolynomialCategoryOps|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |UnivariateSkewPolynomialCategoryOps;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariateSkewPolynomialCategoryOps|)))))))))) 

(DEFUN |UnivariateSkewPolynomialCategoryOps;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariateSkewPolynomialCategoryOps| DV$1 DV$2))
          (LETT $ (GETREFV 44))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|))))))
          (|haddProp| |$ConstructorCache|
                      '|UnivariateSkewPolynomialCategoryOps| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 39
                       (CONS
                        (|dispatchFunction| |OREPCTO;monicLeftDivide;2CAR;6|)
                        $))
             (QSETREFV $ 40
                       (CONS
                        (|dispatchFunction| |OREPCTO;monicRightDivide;2CAR;7|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 42
                       (CONS (|dispatchFunction| |OREPCTO;leftDivide;2CAR;8|)
                             $))
             (QSETREFV $ 43
                       (CONS (|dispatchFunction| |OREPCTO;rightDivide;2CAR;9|)
                             $)))))
          $))) 

(MAKEPROP '|UnivariateSkewPolynomialCategoryOps| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |zero?|) (5 . |Zero|) (|NonNegativeInteger|) (9 . |degree|)
              (|Automorphism| 6) (|Mapping| 6 6) |OREPCTO;times;2CAMC;1|
              (14 . |One|) (18 . |One|) (|Union| $ '"failed")
              (22 . |subtractIfCan|) (28 . |Zero|) (32 . |leadingCoefficient|)
              (37 . *) (43 . |reductum|) (48 . ~=) (54 . |elt|)
              (60 . |monomial|) (66 . +) (72 . |coefficient|) (78 . *) (84 . +)
              |OREPCTO;apply;C2RAMR;3| (|Integer|) (90 . ^) (96 . *) (102 . -)
              (108 . |unit?|) (113 . |recip|)
              (|Record| (|:| |quotient| 7) (|:| |remainder| 7))
              (118 . |monicLeftDivide|) (125 . |monicRightDivide|)
              (132 . |inv|) (137 . |leftDivide|) (144 . |rightDivide|))
           '#(|times| 151 |rightDivide| 159 |monicRightDivide| 166
              |monicLeftDivide| 173 |leftDivide| 180 |apply| 187)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|times|
                                 (|#2| |#2| |#2| (|Automorphism| |#1|)
                                  (|Mapping| |#1| |#1|)))
                                T)
                              '((|apply|
                                 (|#1| |#2| |#1| |#1| (|Automorphism| |#1|)
                                  (|Mapping| |#1| |#1|)))
                                T)
                              '((|monicLeftDivide|
                                 ((|Record| (|:| |quotient| |#2|)
                                            (|:| |remainder| |#2|))
                                  |#2| |#2| (|Automorphism| |#1|)))
                                (|has| 6 (|IntegralDomain|)))
                              '((|monicRightDivide|
                                 ((|Record| (|:| |quotient| |#2|)
                                            (|:| |remainder| |#2|))
                                  |#2| |#2| (|Automorphism| |#1|)))
                                (|has| 6 (|IntegralDomain|)))
                              '((|leftDivide|
                                 ((|Record| (|:| |quotient| |#2|)
                                            (|:| |remainder| |#2|))
                                  |#2| |#2| (|Automorphism| |#1|)))
                                (|has| 6 (|Field|)))
                              '((|rightDivide|
                                 ((|Record| (|:| |quotient| |#2|)
                                            (|:| |remainder| |#2|))
                                  |#2| |#2| (|Automorphism| |#1|)))
                                (|has| 6 (|Field|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(1 7 8 0 9 0 7 0 10 1 7 11 0 12 0
                                              6 0 16 0 7 0 17 2 11 18 0 0 19 0
                                              6 0 20 1 7 6 0 21 2 7 0 6 0 22 1
                                              7 0 0 23 2 7 8 0 0 24 2 13 6 0 6
                                              25 2 7 0 6 11 26 2 7 0 0 0 27 2 7
                                              6 0 11 28 2 6 0 0 0 29 2 6 0 0 0
                                              30 2 13 0 0 32 33 2 7 0 0 0 34 2
                                              7 0 0 0 35 1 6 8 0 36 1 6 18 0 37
                                              3 0 38 7 7 13 39 3 0 38 7 7 13 40
                                              1 6 0 0 41 3 0 38 7 7 13 42 3 0
                                              38 7 7 13 43 4 0 7 7 7 13 14 15 3
                                              1 38 7 7 13 43 3 2 38 7 7 13 40 3
                                              2 38 7 7 13 39 3 1 38 7 7 13 42 5
                                              0 6 7 6 6 13 14 31)))))
           '|lookupComplete|)) 
