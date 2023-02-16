
(SDEFUN |REDORDER;localbinom|
        ((|j| (|Integer|)) (|i| (|Integer|)) ($ (|Integer|)))
        (COND ((> |j| |i|) (SPADCALL |j| (+ |i| 1) (QREFELT $ 13))) ('T 0))) 

(SDEFUN |REDORDER;locals|
        ((|s| (|PrimitiveArray| F)) (|j| (|Integer|)) (|i| (|Integer|))
         ($ (F)))
        (COND ((> |j| |i|) (QAREF1 |s| (- (- |j| |i|) 1)))
              ('T (|spadConstant| $ 14)))) 

(SDEFUN |REDORDER;ReduceOrder;LLR;3|
        ((|l| (L)) (|sols| (|List| F))
         ($ (|Record| (|:| |eq| L) (|:| |op| (|List| F)))))
        (SPROG
         ((|rec| (|Record| (|:| |eq| L) (|:| |op| (|List| F)))) (#1=#:G714 NIL)
          (|s| NIL) (#2=#:G713 NIL) (|neweq| (L)) (|sol| (F)))
         (SEQ
          (COND ((NULL |sols|) (CONS |l| NIL))
                ('T
                 (SEQ
                  (LETT |neweq|
                        (SPADCALL |l| (LETT |sol| (|SPADfirst| |sols|))
                                  (QREFELT $ 15)))
                  (LETT |rec|
                        (SPADCALL |neweq|
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |s| NIL) (LETT #1# (CDR |sols|))
                                        G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |s| (CAR #1#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL (QREFELT $ 9)
                                                           (SPADCALL |s| |sol|
                                                                     (QREFELT $
                                                                              16))
                                                           (QREFELT $ 17))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#))))
                                  (QREFELT $ 20)))
                  (EXIT
                   (CONS (QCAR |rec|)
                         (SPADCALL (QCDR |rec|) |sol| (QREFELT $ 21)))))))))) 

(SDEFUN |REDORDER;ithcoef|
        ((|eq| (L)) (|i| (|Integer|)) (|s| (|PrimitiveArray| F)) ($ (F)))
        (SPROG ((|ans| (F)) (|j| (|NonNegativeInteger|)))
               (SEQ (LETT |ans| (|spadConstant| $ 14))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |eq| (|spadConstant| $ 22)
                                      (QREFELT $ 24)))
                           (GO G191)))
                         (SEQ (LETT |j| (SPADCALL |eq| (QREFELT $ 26)))
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL
                                               (SPADCALL
                                                (|REDORDER;localbinom| |j| |i|
                                                 $)
                                                (|REDORDER;locals| |s| |j| |i|
                                                 $)
                                                (QREFELT $ 27))
                                               (SPADCALL |eq| (QREFELT $ 28))
                                               (QREFELT $ 29))
                                              (QREFELT $ 30)))
                              (EXIT
                               (LETT |eq| (SPADCALL |eq| (QREFELT $ 31)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |REDORDER;ReduceOrder;LFL;5| ((|eq| (L)) (|sol| (F)) ($ (L)))
        (SPROG
         ((|ans| (L)) (#1=#:G735 NIL) (#2=#:G730 NIL) (|i| NIL) (|si| (F))
          (#3=#:G734 NIL) (#4=#:G726 NIL) (|s| (|PrimitiveArray| F))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (LETT |s|
                (MAKEARR1 (LETT |n| (SPADCALL |eq| (QREFELT $ 26)))
                          (|spadConstant| $ 14)))
          (LETT |si| |sol|) (QSETAREF1 |s| 0 |si|)
          (SEQ (LETT |i| 1)
               (LETT #3#
                     (PROG1 (LETT #4# (- |n| 1))
                       (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #4#)))
               G190 (COND ((|greater_SI| |i| #3#) (GO G191)))
               (SEQ
                (EXIT
                 (QSETAREF1 |s| |i|
                            (LETT |si|
                                  (SPADCALL (QREFELT $ 9) |si|
                                            (QREFELT $ 17))))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |ans| (|spadConstant| $ 22))
          (SEQ (LETT |i| 0)
               (LETT #1#
                     (PROG1 (LETT #2# (- |n| 1))
                       (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #2#)))
               G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (LETT |ans|
                       (SPADCALL |ans|
                                 (SPADCALL (|REDORDER;ithcoef| |eq| |i| |s| $)
                                           |i| (QREFELT $ 32))
                                 (QREFELT $ 33)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |ans|)))) 

(DECLAIM (NOTINLINE |ReductionOfOrder;|)) 

(DEFUN |ReductionOfOrder| (&REST #1=#:G736)
  (SPROG NIL
         (PROG (#2=#:G737)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ReductionOfOrder|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ReductionOfOrder;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ReductionOfOrder|)))))))))) 

(DEFUN |ReductionOfOrder;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ReductionOfOrder| DV$1 DV$2))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ReductionOfOrder| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          $))) 

(MAKEPROP '|ReductionOfOrder| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . D)
              '|diff| (4 . |One|) (8 . |One|) (|Integer|) (12 . |binomial|)
              (18 . |Zero|) |REDORDER;ReduceOrder;LFL;5| (22 . /) (28 . |elt|)
              (|Record| (|:| |eq| 7) (|:| |op| 19)) (|List| 6)
              |REDORDER;ReduceOrder;LLR;3| (34 . |concat!|) (40 . |Zero|)
              (|Boolean|) (44 . ~=) (|NonNegativeInteger|) (50 . |degree|)
              (55 . *) (61 . |leadingCoefficient|) (66 . *) (72 . +)
              (78 . |reductum|) (83 . |monomial|) (89 . +))
           '#(|ReduceOrder| 95) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|ReduceOrder| (|#2| |#2| |#1|)) T)
                                   '((|ReduceOrder|
                                      ((|Record| (|:| |eq| |#2|)
                                                 (|:| |op| (|List| |#1|)))
                                       |#2| (|List| |#1|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 33
                                            '(0 7 0 8 0 6 0 10 0 7 0 11 2 12 0
                                              0 0 13 0 6 0 14 2 6 0 0 0 16 2 7
                                              6 0 6 17 2 19 0 0 6 21 0 7 0 22 2
                                              7 23 0 0 24 1 7 25 0 26 2 6 0 12
                                              0 27 1 7 6 0 28 2 6 0 0 0 29 2 6
                                              0 0 0 30 1 7 0 0 31 2 7 0 6 25 32
                                              2 7 0 0 0 33 2 0 18 7 19 20 2 0 7
                                              7 6 15)))))
           '|lookupComplete|)) 
