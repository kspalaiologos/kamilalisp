
(SDEFUN |MONOTOOL;normalDenom;FMUP;1|
        ((|f| (|Fraction| UP)) (|derivation| (|Mapping| UP UP)) ($ (UP)))
        (QCAR
         (SPADCALL (SPADCALL |f| (QREFELT $ 9)) |derivation| (QREFELT $ 12)))) 

(SDEFUN |MONOTOOL;split;UPMR;2|
        ((|p| (UP)) (|derivation| (|Mapping| UP UP))
         ($ (|Record| (|:| |normal| UP) (|:| |special| UP))))
        (SPROG
         ((|rec| (|Record| (|:| |normal| UP) (|:| |special| UP)))
          (#1=#:G707 NIL) (|pbar| (UP)) (|g| (UP)) (|difp| (UP)) (|derp| (UP)))
         (SEQ (LETT |derp| (SPADCALL |p| |derivation|))
              (LETT |difp| (SPADCALL |p| (QREFELT $ 14)))
              (EXIT
               (COND
                ((SPADCALL |derp| |difp| (QREFELT $ 16))
                 (CONS |p| (|spadConstant| $ 18)))
                (#2='T
                 (SEQ (LETT |g| (SPADCALL |p| |derp| (QREFELT $ 19)))
                      (EXIT
                       (COND
                        ((ZEROP (SPADCALL |g| (QREFELT $ 21)))
                         (CONS |p| (|spadConstant| $ 18)))
                        (#2#
                         (SEQ
                          (LETT |pbar|
                                (PROG2
                                    (LETT #1#
                                          (SPADCALL |g|
                                                    (SPADCALL |p| |difp|
                                                              (QREFELT $ 19))
                                                    (QREFELT $ 23)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                                  (|Union| (QREFELT $ 7)
                                                           #3="failed")
                                                  #1#)))
                          (EXIT
                           (COND
                            ((ZEROP (SPADCALL |pbar| (QREFELT $ 21)))
                             (CONS |p| (|spadConstant| $ 18)))
                            (#2#
                             (SEQ
                              (LETT |rec|
                                    (SPADCALL
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |p| |pbar|
                                                         (QREFELT $ 23)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (QREFELT $ 7)
                                                       (|Union| (QREFELT $ 7)
                                                                #3#)
                                                       #1#))
                                     |derivation| (QREFELT $ 12)))
                              (EXIT
                               (CONS (QCAR |rec|)
                                     (SPADCALL |pbar| (QCDR |rec|)
                                               (QREFELT $ 24))))))))))))))))))) 

(SDEFUN |MONOTOOL;splitSquarefree;UPMR;3|
        ((|p| (UP)) (|derivation| (|Mapping| UP UP))
         ($
          (|Record| (|:| |normal| (|Factored| UP))
                    (|:| |special| (|Factored| UP)))))
        (SPROG
         ((|n| #1=(|Factored| UP)) (|h| (UP)) (#2=#:G733 NIL) (|s| #1#)
          (|g| (UP)) (|r| (UP)) (#3=#:G740 NIL) (|rec| NIL)
          (|q| (|Factored| UP)))
         (SEQ (LETT |s| (|spadConstant| $ 26)) (LETT |n| |s|)
              (LETT |q| (SPADCALL |p| (QREFELT $ 28)))
              (SEQ (LETT |rec| NIL) (LETT #3# (SPADCALL |q| (QREFELT $ 32)))
                   G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |rec| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |r| (QVELT |rec| 1))
                        (LETT |g|
                              (SPADCALL |r| (SPADCALL |r| |derivation|)
                                        (QREFELT $ 19)))
                        (COND
                         ((NULL (SPADCALL |g| (QREFELT $ 33)))
                          (LETT |s|
                                (SPADCALL |s|
                                          (SPADCALL |g| (QVELT |rec| 2)
                                                    (QREFELT $ 34))
                                          (QREFELT $ 35)))))
                        (LETT |h|
                              (PROG2
                                  (LETT #2# (SPADCALL |r| |g| (QREFELT $ 23)))
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                                (|Union| (QREFELT $ 7)
                                                         "failed")
                                                #2#)))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |h| (QREFELT $ 33)))
                           (LETT |n|
                                 (SPADCALL |n|
                                           (SPADCALL |h| (QVELT |rec| 2)
                                                     (QREFELT $ 34))
                                           (QREFELT $ 35)))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (CONS |n|
                     (SPADCALL (SPADCALL |q| (QREFELT $ 36)) |s|
                               (QREFELT $ 37))))))) 

(SDEFUN |MONOTOOL;decompose;FMR;4|
        ((|f| (|Fraction| UP)) (|derivation| (|Mapping| UP UP))
         ($
          (|Record| (|:| |poly| UP) (|:| |normal| (|Fraction| UP))
                    (|:| |special| (|Fraction| UP)))))
        (SPROG
         ((|eeu| (|Record| (|:| |coef1| UP) (|:| |coef2| UP))) (#1=#:G747 NIL)
          (|rec| (|Record| (|:| |normal| UP) (|:| |special| UP)))
          (|qr| (|Record| (|:| |quotient| UP) (|:| |remainder| UP))))
         (SEQ
          (LETT |qr|
                (SPADCALL (SPADCALL |f| (QREFELT $ 40))
                          (SPADCALL |f| (QREFELT $ 9)) (QREFELT $ 42)))
          (LETT |rec|
                (SPADCALL (SPADCALL |f| (QREFELT $ 9)) |derivation|
                          (QREFELT $ 12)))
          (LETT |eeu|
                (PROG2
                    (LETT #1#
                          (SPADCALL (QCAR |rec|) (QCDR |rec|) (QCDR |qr|)
                                    (QREFELT $ 45)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|Record| (|:| |coef1| (QREFELT $ 7))
                                            (|:| |coef2| (QREFELT $ 7)))
                                  (|Union|
                                   (|Record| (|:| |coef1| (QREFELT $ 7))
                                             (|:| |coef2| (QREFELT $ 7)))
                                   "failed")
                                  #1#)))
          (EXIT
           (VECTOR (QCAR |qr|)
                   (SPADCALL (QCDR |eeu|) (QCAR |rec|) (QREFELT $ 46))
                   (SPADCALL (QCAR |eeu|) (QCDR |rec|) (QREFELT $ 46))))))) 

(DECLAIM (NOTINLINE |MonomialExtensionTools;|)) 

(DEFUN |MonomialExtensionTools| (&REST #1=#:G752)
  (SPROG NIL
         (PROG (#2=#:G753)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MonomialExtensionTools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MonomialExtensionTools;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MonomialExtensionTools|)))))))))) 

(DEFUN |MonomialExtensionTools;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|MonomialExtensionTools| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MonomialExtensionTools|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MonomialExtensionTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Fraction| 7) (0 . |denom|)
              (|Record| (|:| |normal| 7) (|:| |special| 7)) (|Mapping| 7 7)
              |MONOTOOL;split;UPMR;2| |MONOTOOL;normalDenom;FMUP;1|
              (5 . |differentiate|) (|Boolean|) (10 . =) (16 . |One|)
              (20 . |One|) (24 . |gcd|) (|NonNegativeInteger|) (30 . |degree|)
              (|Union| $ '"failed") (35 . |exquo|) (41 . *) (|Factored| 7)
              (47 . |One|) (|Factored| $) (51 . |squareFree|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 29) (|:| |factor| 7) (|:| |exponent| 20))
              (|List| 30) (56 . |factorList|) (61 . |ground?|)
              (66 . |sqfrFactor|) (72 . *) (78 . |unit|) (83 . *)
              (|Record| (|:| |normal| 25) (|:| |special| 25))
              |MONOTOOL;splitSquarefree;UPMR;3| (89 . |numer|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $)) (94 . |divide|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 43 '"failed")
              (100 . |extendedEuclidean|) (107 . /)
              (|Record| (|:| |poly| 7) (|:| |normal| 8) (|:| |special| 8))
              |MONOTOOL;decompose;FMR;4|)
           '#(|splitSquarefree| 113 |split| 119 |normalDenom| 125 |decompose|
              131)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|split|
                                 ((|Record| (|:| |normal| |#2|)
                                            (|:| |special| |#2|))
                                  |#2| (|Mapping| |#2| |#2|)))
                                T)
                              '((|splitSquarefree|
                                 ((|Record| (|:| |normal| (|Factored| |#2|))
                                            (|:| |special| (|Factored| |#2|)))
                                  |#2| (|Mapping| |#2| |#2|)))
                                T)
                              '((|normalDenom|
                                 (|#2| (|Fraction| |#2|)
                                  (|Mapping| |#2| |#2|)))
                                T)
                              '((|decompose|
                                 ((|Record| (|:| |poly| |#2|)
                                            (|:| |normal| (|Fraction| |#2|))
                                            (|:| |special| (|Fraction| |#2|)))
                                  (|Fraction| |#2|) (|Mapping| |#2| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(1 8 7 0 9 1 7 0 0 14 2 7 15 0 0
                                              16 0 6 0 17 0 7 0 18 2 7 0 0 0 19
                                              1 7 20 0 21 2 7 22 0 0 23 2 7 0 0
                                              0 24 0 25 0 26 1 7 27 0 28 1 25
                                              31 0 32 1 7 15 0 33 2 25 0 7 20
                                              34 2 25 0 0 0 35 1 25 7 0 36 2 25
                                              0 7 0 37 1 8 7 0 40 2 7 41 0 0 42
                                              3 7 44 0 0 0 45 2 8 0 7 7 46 2 0
                                              38 7 11 39 2 0 10 7 11 12 2 0 7 8
                                              11 13 2 0 47 8 11 48)))))
           '|lookupComplete|)) 
