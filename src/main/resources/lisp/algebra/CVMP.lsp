
(SDEFUN |CVMP;imbedFP| ((|r| (R)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (SPADCALL |r| (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |CVMP;imbedP| ((|r| (R)) ($ (|Polynomial| R)))
        (SPADCALL |r| (QREFELT $ 8))) 

(SDEFUN |CVMP;coerceP;VV;3|
        ((|g| (|Vector| (|Matrix| R)))
         ($ (|Vector| (|Matrix| (|Polynomial| R)))))
        (SPROG
         ((|l| (|List| (|Matrix| (|Polynomial| R))))
          (|m2| (|Matrix| (|Polynomial| R))) (#1=#:G712 NIL) (|m| NIL)
          (|lim| (|List| (|Matrix| R))))
         (SEQ (LETT |lim| (SPADCALL |g| (QREFELT $ 13))) (LETT |l| NIL)
              (SEQ (LETT |m| NIL) (LETT #1# |lim|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |m| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |m2|
                          (SPADCALL (CONS (|function| |CVMP;imbedP|) $) |m|
                                    (QREFELT $ 18)))
                    (EXIT (LETT |l| (CONS |m2| |l|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (REVERSE |l|) (QREFELT $ 21)))))) 

(SDEFUN |CVMP;coerce;VV;4|
        ((|g| (|Vector| (|Matrix| R)))
         ($ (|Vector| (|Matrix| (|Fraction| (|Polynomial| R))))))
        (SPROG
         ((|l| (|List| (|Matrix| (|Fraction| (|Polynomial| R)))))
          (|m3| (|Matrix| (|Fraction| (|Polynomial| R)))) (#1=#:G719 NIL)
          (|m| NIL) (|lim| (|List| (|Matrix| R))))
         (SEQ (LETT |lim| (SPADCALL |g| (QREFELT $ 13))) (LETT |l| NIL)
              (SEQ (LETT |m| NIL) (LETT #1# |lim|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |m| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |m3|
                          (SPADCALL (CONS (|function| |CVMP;imbedFP|) $) |m|
                                    (QREFELT $ 26)))
                    (EXIT (LETT |l| (CONS |m3| |l|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (REVERSE |l|) (QREFELT $ 29)))))) 

(DECLAIM (NOTINLINE |CoerceVectorMatrixPackage;|)) 

(DEFUN |CoerceVectorMatrixPackage| (#1=#:G720)
  (SPROG NIL
         (PROG (#2=#:G721)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|CoerceVectorMatrixPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|CoerceVectorMatrixPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|CoerceVectorMatrixPackage|)))))))))) 

(DEFUN |CoerceVectorMatrixPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|CoerceVectorMatrixPackage| DV$1))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CoerceVectorMatrixPackage|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CoerceVectorMatrixPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Polynomial| 6)
              (0 . |coerce|) (|Fraction| 7) (5 . |coerce|) (|List| 16)
              (|Vector| 16) (10 . |entries|) (|Matrix| 7) (|Mapping| 7 6)
              (|Matrix| 6)
              (|MatrixCategoryFunctions2| 6 (|Vector| 6) (|Vector| 6) 16 7
                                          (|Vector| 7) (|Vector| 7) 14)
              (15 . |map|) (|List| 14) (|Vector| 14) (21 . |vector|)
              |CVMP;coerceP;VV;3| (|Matrix| 9) (|Mapping| 9 6)
              (|MatrixCategoryFunctions2| 6 (|Vector| 6) (|Vector| 6) 16 9
                                          (|Vector| 9) (|Vector| 9) 23)
              (26 . |map|) (|List| 23) (|Vector| 23) (32 . |vector|)
              |CVMP;coerce;VV;4|)
           '#(|coerceP| 37 |coerce| 42) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coerceP|
                                 ((|Vector| (|Matrix| (|Polynomial| |#1|)))
                                  (|Vector| (|Matrix| |#1|))))
                                T)
                              '((|coerce|
                                 ((|Vector|
                                   (|Matrix| (|Fraction| (|Polynomial| |#1|))))
                                  (|Vector| (|Matrix| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(1 7 0 6 8 1 9 0 7 10 1 12 11 0 13
                                              2 17 14 15 16 18 1 20 0 19 21 2
                                              25 23 24 16 26 1 28 0 27 29 1 0
                                              20 12 22 1 0 28 12 30)))))
           '|lookupComplete|)) 
