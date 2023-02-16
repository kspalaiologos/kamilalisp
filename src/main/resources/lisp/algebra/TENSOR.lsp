
(SDEFUN |TENSOR;termgreater?|
        ((|t1| (|Record| (|:| |k| (|Product| B1 B2)) (|:| |c| R)))
         (|t2| (|Record| (|:| |k| (|Product| B1 B2)) (|:| |c| R)))
         ($ (|Boolean|)))
        (SPADCALL (QCAR |t2|) (QCAR |t1|) (QREFELT $ 13))) 

(SDEFUN |TENSOR;tensor;M1M2$;2| ((|x1| (M1)) (|x2| (M2)) ($ ($)))
        (SPROG
         ((|res| (|List| (|Record| (|:| |k| (|Product| B1 B2)) (|:| |c| R))))
          (#1=#:G719 NIL) (|s2| NIL) (#2=#:G718 NIL) (|s1| NIL)
          (|ltx2| (|List| (|Record| (|:| |k| B2) (|:| |c| R))))
          (|ltx1| (|List| (|Record| (|:| |k| B1) (|:| |c| R))))
          (#3=#:G717 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL |x1| (QREFELT $ 14)) (SPADCALL |x2| (QREFELT $ 16)))
             (PROGN (LETT #3# (|spadConstant| $ 15)) (GO #4=#:G716)))
            ('T
             (SEQ (LETT |ltx1| (SPADCALL |x1| (QREFELT $ 19)))
                  (LETT |ltx2| (SPADCALL |x2| (QREFELT $ 22))) (LETT |res| NIL)
                  (SEQ (LETT |s1| NIL) (LETT #2# (REVERSE |ltx1|)) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |s1| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |s2| NIL) (LETT #1# (REVERSE |ltx2|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |s2| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT |res|
                                      (CONS
                                       (CONS
                                        (SPADCALL (QCAR |s1|) (QCAR |s2|)
                                                  (QREFELT $ 23))
                                        (SPADCALL (QCDR |s1|) (QCDR |s2|)
                                                  (QREFELT $ 24)))
                                       |res|))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (SPADCALL |res| (QREFELT $ 27)))))))
          #4# (EXIT #3#)))) 

(SDEFUN |TENSOR;*;3$;3| ((|x1| ($)) (|x2| ($)) ($ ($)))
        (SPROG
         ((|res| (|List| (|Record| (|:| |k| (|Product| B1 B2)) (|:| |c| R))))
          (#1=#:G731 NIL) (|t| NIL) (|t2b| (M2)) (|t2a| (M1)) (|t1b| (M2))
          (|t1a| (M1)) (|t2k| #2=(|Product| B1 B2)) (|t1k| #2#) (#3=#:G730 NIL)
          (|t2| NIL) (#4=#:G729 NIL) (|t1| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |t1| NIL) (LETT #4# (SPADCALL |x1| (QREFELT $ 29)))
                   G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |t1| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |t2| NIL)
                          (LETT #3# (SPADCALL |x2| (QREFELT $ 29))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |t2| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |t1k| (QCAR |t1|))
                               (LETT |t2k| (QCAR |t2|))
                               (LETT |t1a|
                                     (SPADCALL (QCDR |t1|)
                                               (SPADCALL |t1k| (QREFELT $ 30))
                                               (QREFELT $ 31)))
                               (LETT |t1b|
                                     (SPADCALL (|spadConstant| $ 33)
                                               (SPADCALL |t1k| (QREFELT $ 34))
                                               (QREFELT $ 35)))
                               (LETT |t2a|
                                     (SPADCALL (QCDR |t2|)
                                               (SPADCALL |t2k| (QREFELT $ 30))
                                               (QREFELT $ 31)))
                               (LETT |t2b|
                                     (SPADCALL (|spadConstant| $ 33)
                                               (SPADCALL |t2k| (QREFELT $ 34))
                                               (QREFELT $ 35)))
                               (EXIT
                                (SEQ (LETT |t| NIL)
                                     (LETT #1#
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |t1a| |t2a|
                                                       (QREFELT $ 36))
                                             (SPADCALL |t1b| |t2b|
                                                       (QREFELT $ 37))
                                             (QREFELT $ 28))
                                            (QREFELT $ 29)))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |t| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ (EXIT (LETT |res| (CONS |t| |res|))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT NIL))))
                          (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |res| (QREFELT $ 38)))))) 

(SDEFUN |TENSOR;coerce;$Of;4| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|le| (|List| (|OutputForm|))) (|ko| (|OutputForm|)) (#1=#:G741 NIL)
          (|rec| NIL))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 40))
            (SPADCALL (|spadConstant| $ 41) (QREFELT $ 43)))
           ('T
            (SEQ (LETT |le| NIL)
                 (SEQ (LETT |rec| NIL)
                      (LETT #1# (REVERSE (SPADCALL |x| (QREFELT $ 29)))) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |ko|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QCAR |rec|) (QREFELT $ 30))
                                        (QREFELT $ 44))
                              (SPADCALL (SPADCALL (QCAR |rec|) (QREFELT $ 34))
                                        (QREFELT $ 45))
                              (QREFELT $ 46)))
                       (EXIT
                        (COND
                         ((SPADCALL (QCDR |rec|) (|spadConstant| $ 33)
                                    (QREFELT $ 47))
                          (LETT |le| (CONS |ko| |le|)))
                         ('T
                          (LETT |le|
                                (CONS
                                 (SPADCALL
                                  (SPADCALL (QCDR |rec|) (QREFELT $ 43)) |ko|
                                  (QREFELT $ 48))
                                 |le|))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (EXIT (SPADCALL (ELT $ 49) |le| (QREFELT $ 52))))))))) 

(DECLAIM (NOTINLINE |TensorProduct;|)) 

(DEFUN |TensorProduct| (&REST #1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TensorProduct|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |TensorProduct;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|TensorProduct|)))))))))) 

(DEFUN |TensorProduct;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) (#1=#:G749 NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL)
    (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|TensorProduct| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 66))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#4|
                                                        (LIST '|Algebra|
                                                              (|devaluate|
                                                               |#1|)))
                                         (|HasCategory| |#5|
                                                        (LIST '|Algebra|
                                                              (|devaluate|
                                                               |#1|))))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))
                                          (|HasCategory| |#5|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))
                                          (|HasCategory| |#5|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))
                                          (|HasCategory| |#5|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (LETT #1#
                                              (|HasCategory|
                                               (|Product| |#2| |#3|)
                                               '(|Comparable|)))
                                        (AND
                                         (|HasCategory| |#1| '(|Comparable|))
                                         #1#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))
                                          (|HasCategory| |#5|
                                                         (LIST '|Algebra|
                                                               (|devaluate|
                                                                |#1|)))))))))
    (|haddProp| |$ConstructorCache| '|TensorProduct|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#4| (LIST '|Algebra| (|devaluate| |#1|)))
      (COND
       ((|HasCategory| |#5| (LIST '|Algebra| (|devaluate| |#1|)))
        (QSETREFV $ 39 (CONS (|dispatchFunction| |TENSOR;*;3$;3|) $))))))
    $))) 

(MAKEPROP '|TensorProduct| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FreeModule| 6 12) (|local| |#1|)
              (|local| |#2|) (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Boolean|) (|Product| 7 8) (0 . <) (6 . |zero?|) (11 . |Zero|)
              (15 . |zero?|) (|Record| (|:| |k| 7) (|:| |c| 6)) (|List| 17)
              (20 . |listOfTerms|) (|Record| (|:| |k| 8) (|:| |c| 6))
              (|List| 20) (25 . |listOfTerms|) (30 . |construct|) (36 . *)
              (|Record| (|:| |k| 12) (|:| |c| 6)) (|List| 25)
              (42 . |constructOrdered|) |TENSOR;tensor;M1M2$;2|
              (47 . |listOfTerms|) (52 . |first|) (57 . |monomial|)
              (63 . |One|) (67 . |One|) (71 . |second|) (76 . |monomial|)
              (82 . *) (88 . *) (94 . |construct|) (99 . *) (105 . |zero?|)
              (110 . |Zero|) (|OutputForm|) (114 . |coerce|) (119 . |coerce|)
              (124 . |coerce|) (129 . |tensor|) (135 . =) (141 . *) (147 . +)
              (|Mapping| 42 42 42) (|List| 42) (153 . |reduce|)
              |TENSOR;coerce;$Of;4| (|Integer|) (|NonNegativeInteger|)
              (|Union| $ '"failed") (|PositiveInteger|) (|Mapping| 6 12)
              (|List| 6) (|Mapping| 6 6) (|List| 12) (|List| $) (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 159 |zero?| 165 |tensor| 170 |support| 176 |subtractIfCan| 181
              |smaller?| 187 |sample| 193 |rightRecip| 197 |rightPower| 202
              |reductum| 214 |recip| 219 |opposite?| 224 |one?| 230
              |numberOfMonomials| 235 |monomials| 240 |monomial?| 245
              |monomial| 250 |map| 256 |listOfTerms| 262 |linearExtend| 267
              |leftRecip| 273 |leftPower| 278 |leadingTerm| 290
              |leadingSupport| 295 |leadingMonomial| 300 |leadingCoefficient|
              305 |latex| 310 |hashUpdate!| 315 |hash| 321 |constructOrdered|
              326 |construct| 331 |commutator| 336 |coerce| 342 |coefficients|
              357 |coefficient| 362 |characteristic| 368 |associator| 372
              |antiCommutator| 379 |annihilate?| 385 ^ 391 |Zero| 403 |One| 407
              = 411 - 417 + 428 * 434)
           'NIL
           (CONS
            (|makeByteWordVec2| 7
                                '(1 1 0 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 2 4 1 1
                                  3 1 1 1 0 7 1 0 0 0 1))
            (CONS
             '#(|Algebra&| NIL NIL |FreeModuleCategory&| |Rng&| NIL |Module&|
                NIL NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL NIL
                |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |AbelianMonoid&| |MagmaWithUnit&| NIL |NonAssociativeSemiRng&|
                |AbelianSemiGroup&| NIL |Magma&| |SetCategory&| |BasicType&|
                NIL NIL)
             (CONS
              '#((|Algebra| 6) (|Ring|) (|TensorProductCategory| 6 9 10)
                 (|FreeModuleCategory| 6 (|Product| 7 8)) (|Rng|) (|SemiRing|)
                 (|Module| 6)
                 (|IndexedDirectProductCategory| 6 (|Product| 7 8)) (|SemiRng|)
                 (|IndexedProductCategory| 6 (|Product| 7 8)) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|LeftModule| $$) (|RightModule| $$)
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|AbelianMonoid|) (|MagmaWithUnit|) (|SemiGroup|)
                 (|NonAssociativeSemiRng|) (|AbelianSemiGroup|) (|Comparable|)
                 (|Magma|) (|SetCategory|) (|BasicType|) (|CoercibleTo| 42)
                 (|unitsKnown|))
              (|makeByteWordVec2| 65
                                  '(2 12 11 0 0 13 1 9 11 0 14 0 0 0 15 1 10 11
                                    0 16 1 9 18 0 19 1 10 21 0 22 2 12 0 7 8 23
                                    2 6 0 0 0 24 1 0 0 26 27 1 0 26 0 29 1 12 7
                                    0 30 2 9 0 6 7 31 0 0 0 32 0 6 0 33 1 12 8
                                    0 34 2 10 0 6 8 35 2 9 0 0 0 36 2 10 0 0 0
                                    37 1 0 0 26 38 2 0 0 0 0 39 1 0 11 0 40 0 6
                                    0 41 1 6 42 0 43 1 7 42 0 44 1 8 42 0 45 2
                                    42 0 0 0 46 2 6 11 0 0 47 2 42 0 0 0 48 2
                                    42 0 0 0 49 2 51 42 50 0 52 2 0 11 0 0 1 1
                                    8 11 0 40 2 0 0 9 10 28 1 0 61 0 1 2 4 56 0
                                    0 1 2 7 11 0 0 1 0 8 0 1 1 1 56 0 1 2 1 0 0
                                    55 1 2 1 0 0 57 1 1 6 0 0 1 1 1 56 0 1 2 8
                                    11 0 0 1 1 1 11 0 1 1 0 55 0 1 1 0 62 0 1 1
                                    0 11 0 1 2 0 0 6 12 1 2 0 0 60 0 1 1 0 26 0
                                    29 2 5 6 58 0 1 1 1 56 0 1 2 1 0 0 55 1 2 1
                                    0 0 57 1 1 6 25 0 1 1 6 12 0 1 1 6 0 0 1 1
                                    6 6 0 1 1 0 64 0 1 2 0 63 63 0 1 1 0 65 0 1
                                    1 6 0 26 27 1 0 0 26 38 2 1 0 0 0 1 1 1 0 6
                                    1 1 1 0 54 1 1 0 42 0 53 1 0 59 0 1 2 0 6 0
                                    12 1 0 1 55 1 3 1 0 0 0 0 1 2 1 0 0 0 1 2 1
                                    11 0 0 1 2 1 0 0 55 1 2 1 0 0 57 1 0 8 0 15
                                    0 1 0 32 2 0 11 0 0 1 1 2 0 0 1 2 2 0 0 0 1
                                    2 0 0 0 0 1 2 1 0 0 0 39 2 2 0 54 0 1 2 8 0
                                    55 0 1 2 0 0 6 0 1 2 0 0 0 6 1 2 0 0 57 0
                                    1)))))
           '|lookupComplete|)) 
