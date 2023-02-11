
(SDEFUN |QFORM;quadraticForm;Sm$;1| ((|m| (|SquareMatrix| |n| K)) ($ ($)))
        (COND
         ((NULL (SPADCALL |m| (QREFELT $ 10)))
          (|error| "quadraticForm requires a symmetric matrix"))
         ('T |m|))) 

(PUT '|QFORM;matrix;$Sm;2| '|SPADreplace| '(XLAM (|q|) |q|)) 

(SDEFUN |QFORM;matrix;$Sm;2| ((|q| ($)) ($ (|SquareMatrix| |n| K))) |q|) 

(SDEFUN |QFORM;elt;$DpK;3| ((|q| ($)) (|v| (|DirectProduct| |n| K)) ($ (K)))
        (SPADCALL |v|
                  (SPADCALL (SPADCALL |q| (QREFELT $ 12)) |v| (QREFELT $ 14))
                  (QREFELT $ 15))) 

(SDEFUN |QFORM;convert;$If;4| ((|q| ($)) ($ (|InputForm|)))
        (SPROG ((|qf| (|InputForm|)) (|mif| (|InputForm|)))
               (SEQ
                (LETT |mif|
                      (SPADCALL (SPADCALL |q| (QREFELT $ 12)) (QREFELT $ 18)))
                (LETT |qf|
                      (SPADCALL (SPADCALL '|quadraticForm| (QREFELT $ 21))
                                (QREFELT $ 22)))
                (EXIT (SPADCALL (LIST |qf| |mif|) (QREFELT $ 24)))))) 

(DECLAIM (NOTINLINE |QuadraticForm;|)) 

(DEFUN |QuadraticForm| (&REST #1=#:G716)
  (SPROG NIL
         (PROG (#2=#:G717)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|QuadraticForm|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |QuadraticForm;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|QuadraticForm|)))))))))) 

(DEFUN |QuadraticForm;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|QuadraticForm| DV$1 DV$2))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory|
                                               (|SquareMatrix| |#1| |#2|)
                                               '(|ConvertibleTo|
                                                 (|InputForm|)))))))
          (|haddProp| |$ConstructorCache| '|QuadraticForm| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|SquareMatrix| |#1| |#2|))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 25
                      (CONS (|dispatchFunction| |QFORM;convert;$If;4|) $))))
          $))) 

(MAKEPROP '|QuadraticForm| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SquareMatrix| (NRTEVAL (QREFELT $ 6)) 7)
              (|local| |#1|) (|local| |#2|) '|Rep| (|Boolean|)
              (0 . |symmetric?|) |QFORM;quadraticForm;Sm$;1|
              |QFORM;matrix;$Sm;2| (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 7)
              (5 . *) (11 . |dot|) |QFORM;elt;$DpK;3| (|InputForm|)
              (17 . |convert|) (|Symbol|) (|SExpression|) (22 . |convert|)
              (27 . |convert|) (|List| $) (32 . |convert|) (37 . |convert|)
              (|Integer|) (|Union| $ '"failed") (|NonNegativeInteger|)
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|)
              (|OutputForm|))
           '#(~= 42 |zero?| 48 |subtractIfCan| 53 |sample| 59 |quadraticForm|
              63 |opposite?| 68 |matrix| 74 |latex| 79 |hashUpdate!| 84 |hash|
              90 |elt| 95 |convert| 101 |coerce| 106 |Zero| 111 = 115 - 121 +
              132 * 138)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 1))
                 (CONS
                  '#(|AbelianGroup&| NIL |AbelianMonoid&| |AbelianSemiGroup&|
                     |SetCategory&| |BasicType&| NIL NIL)
                  (CONS
                   '#((|AbelianGroup|) (|CancellationAbelianMonoid|)
                      (|AbelianMonoid|) (|AbelianSemiGroup|) (|SetCategory|)
                      (|BasicType|) (|CoercibleTo| 33) (|ConvertibleTo| 17))
                   (|makeByteWordVec2| 33
                                       '(1 8 9 0 10 2 8 13 0 13 14 2 13 7 0 0
                                         15 1 5 17 0 18 1 20 0 19 21 1 17 0 20
                                         22 1 17 0 23 24 1 0 17 0 25 2 0 9 0 0
                                         1 1 0 9 0 1 2 0 27 0 0 1 0 0 0 1 1 0 0
                                         5 11 2 0 9 0 0 1 1 0 5 0 12 1 0 30 0 1
                                         2 0 32 32 0 1 1 0 31 0 1 2 0 7 0 13 16
                                         1 1 17 0 25 1 0 33 0 1 0 0 0 1 2 0 9 0
                                         0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1
                                         2 0 0 26 0 1 2 0 0 28 0 1 2 0 0 29 0
                                         1)))))
           '|lookupComplete|)) 
