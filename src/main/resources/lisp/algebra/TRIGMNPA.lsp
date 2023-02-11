
(SDEFUN |TRIGMNPA;ker2explogs|
        ((|k| (|Kernel| FG)) (|l| (|List| (|Kernel| FG))) ($ (FG)))
        (SPROG
         ((|e| (FG)) (|z| (FG)) (|args| (|List| FG)) (#1=#:G726 NIL) (|a| NIL)
          (#2=#:G725 NIL) (|kf| (FG)))
         (SEQ (LETT |kf| (SPADCALL |k| (QREFELT $ 13)))
              (EXIT
               (COND
                ((NULL
                  (LETT |args|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |a| NIL)
                              (LETT #1# (SPADCALL |k| (QREFELT $ 16))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |a| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |a| |l| (QREFELT $ 18))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))))
                 |kf|)
                (#3='T
                 (SEQ (LETT |z| (|SPADfirst| |args|))
                      (EXIT
                       (COND
                        ((SPADCALL |k| '|tan| (QREFELT $ 21))
                         (SEQ
                          (LETT |e|
                                (COND
                                 ((SPADCALL |k| |l| (QREFELT $ 22))
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (QREFELT $ 11) |z|
                                              (QREFELT $ 23))
                                    (QREFELT $ 24))
                                   2 (QREFELT $ 26)))
                                 (#3#
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL 2 (QREFELT $ 11) (QREFELT $ 28))
                                    |z| (QREFELT $ 23))
                                   (QREFELT $ 24)))))
                          (EXIT
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (QREFELT $ 11)
                                       (SPADCALL |e| (|spadConstant| $ 30)
                                                 (QREFELT $ 31))
                                       (QREFELT $ 23))
                             (SPADCALL |e| (|spadConstant| $ 30)
                                       (QREFELT $ 32))
                             (QREFELT $ 33))
                            (QREFELT $ 34)))))
                        ((SPADCALL |k| '|atan| (QREFELT $ 21))
                         (SPADCALL
                          (SPADCALL (QREFELT $ 11)
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 30)
                                                (SPADCALL (QREFELT $ 11) |z|
                                                          (QREFELT $ 23))
                                                (QREFELT $ 31))
                                      (SPADCALL (|spadConstant| $ 30)
                                                (SPADCALL (QREFELT $ 11) |z|
                                                          (QREFELT $ 23))
                                                (QREFELT $ 32))
                                      (QREFELT $ 33))
                                     (QREFELT $ 35))
                                    (QREFELT $ 23))
                          (SPADCALL 2 (QREFELT $ 36)) (QREFELT $ 33)))
                        (#3#
                         (SPADCALL (SPADCALL |k| (QREFELT $ 38)) |args|
                                   (QREFELT $ 40)))))))))))) 

(SDEFUN |TRIGMNPA;trigs2explogs;FGLFG;2|
        ((|f| (FG)) (|l| (|List| (|Kernel| FG))) ($ (FG)))
        (SPADCALL (|TRIGMNPA;smp2explogs| (SPADCALL |f| (QREFELT $ 42)) |l| $)
                  (|TRIGMNPA;smp2explogs| (SPADCALL |f| (QREFELT $ 43)) |l| $)
                  (QREFELT $ 33))) 

(SDEFUN |TRIGMNPA;smp2explogs|
        ((|p| (|SparseMultivariatePolynomial| G (|Kernel| FG)))
         (|l| (|List| (|Kernel| FG))) ($ (FG)))
        (SPROG NIL
               (SPADCALL (CONS #'|TRIGMNPA;smp2explogs!0| (VECTOR $ |l|))
                         (ELT $ 10) |p| (QREFELT $ 48)))) 

(SDEFUN |TRIGMNPA;smp2explogs!0| ((|x| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|TRIGMNPA;ker2explogs| |x| |l| $))))) 

(DECLAIM (NOTINLINE |TrigonometricManipulationsAux;|)) 

(DEFUN |TrigonometricManipulationsAux| (&REST #1=#:G730)
  (SPROG NIL
         (PROG (#2=#:G731)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TrigonometricManipulationsAux|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TrigonometricManipulationsAux;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TrigonometricManipulationsAux|)))))))))) 

(DEFUN |TrigonometricManipulationsAux;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|TrigonometricManipulationsAux| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TrigonometricManipulationsAux|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (COND
                     ((|HasSignature| |#1|
                                      (LIST '|imaginary|
                                            (LIST (|devaluate| |#1|))))
                      (SPADCALL (QREFELT $ 8)))
                     ('T (|error| "G must have imaginary unit"))))
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 9) (QREFELT $ 10)))
          $))) 

(MAKEPROP '|TrigonometricManipulationsAux| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |imaginary|) '|im1| (4 . |coerce|) '|im| (|Kernel| $)
              (9 . |coerce|) (|List| 7) (|Kernel| 7) (14 . |argument|)
              (|List| 15) |TRIGMNPA;trigs2explogs;FGLFG;2| (|Boolean|)
              (|Symbol|) (19 . |is?|) (25 . |member?|) (31 . *) (37 . |exp|)
              (|Integer|) (42 . ^) (|PositiveInteger|) (48 . *) (54 . |One|)
              (58 . |One|) (62 . -) (68 . +) (74 . /) (80 . -) (85 . |log|)
              (90 . |coerce|) (|BasicOperator|) (95 . |operator|) (|List| $)
              (100 . |elt|) (|SparseMultivariatePolynomial| 6 12)
              (106 . |numer|) (111 . |denom|) (|Mapping| 7 15) (|Mapping| 7 6)
              (|SparseMultivariatePolynomial| 6 15)
              (|PolynomialCategoryLifting| (|IndexedExponents| 15) 15 6 46 7)
              (116 . |map|))
           '#(|trigs2explogs| 123) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|trigs2explogs|
                                 (|#2| |#2| (|List| (|Kernel| |#2|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(0 6 0 8 1 7 0 6 10 1 7 0 12 13 1
                                              15 14 0 16 2 15 19 0 20 21 2 17
                                              19 15 0 22 2 7 0 0 0 23 1 7 0 0
                                              24 2 7 0 0 25 26 2 7 0 27 0 28 0
                                              6 0 29 0 7 0 30 2 7 0 0 0 31 2 7
                                              0 0 0 32 2 7 0 0 0 33 1 7 0 0 34
                                              1 7 0 0 35 1 7 0 25 36 1 15 37 0
                                              38 2 7 0 37 39 40 1 7 41 0 42 1 7
                                              41 0 43 3 47 7 44 45 46 48 2 0 7
                                              7 17 18)))))
           '|lookupComplete|)) 
