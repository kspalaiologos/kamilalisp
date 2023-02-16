
(SDEFUN |DPMM;*;R2$;1| ((|r| (R)) (|x| ($)) ($ ($)))
        (SPROG ((#1=#:G700 NIL) (#2=#:G702 NIL) (|i| NIL) (#3=#:G701 NIL))
               (SEQ
                (PROGN
                 (LETT #3# (GETREFV #4=(QREFELT $ 6)))
                 (SEQ (LETT |i| 1) (LETT #2# #4#) (LETT #1# 0) G190
                      (COND ((|greater_SI| |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL |r| (SPADCALL |x| |i| (QREFELT $ 12))
                                          (QREFELT $ 13)))))
                      (LETT #1#
                            (PROG1 (|inc_SI| #1#) (LETT |i| (|inc_SI| |i|))))
                      (GO G190) G191 (EXIT NIL))
                 #3#)))) 

(SDEFUN |DPMM;*;M2$;2| ((|m| (M)) (|x| ($)) ($ ($)))
        (SPROG
         ((#1=#:G705 NIL) (#2=#:G704 (S)) (#3=#:G706 (S)) (#4=#:G712 NIL)
          (|j| NIL) (#5=#:G709 NIL) (#6=#:G711 NIL) (|i| NIL) (#7=#:G710 NIL))
         (SEQ
          (PROGN
           (LETT #7# (GETREFV #8=(QREFELT $ 6)))
           (SEQ (LETT |i| 1) (LETT #6# #8#) (LETT #5# 0) G190
                (COND ((|greater_SI| |i| #6#) (GO G191)))
                (SEQ
                 (EXIT
                  (SETELT #7# #5#
                          (PROGN
                           (LETT #1# NIL)
                           (SEQ (LETT |j| 1) (LETT #4# (QREFELT $ 6)) G190
                                (COND ((|greater_SI| |j| #4#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #3#
                                         (SPADCALL
                                          (SPADCALL |m| |i| |j| (QREFELT $ 15))
                                          (SPADCALL |x| |j| (QREFELT $ 12))
                                          (QREFELT $ 13)))
                                   (COND
                                    (#1#
                                     (LETT #2#
                                           (SPADCALL #2# #3# (QREFELT $ 16))))
                                    ('T
                                     (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT NIL))
                           (COND (#1# #2#) ('T (|spadConstant| $ 17)))))))
                (LETT #5# (PROG1 (|inc_SI| #5#) (LETT |i| (|inc_SI| |i|))))
                (GO G190) G191 (EXIT NIL))
           #7#)))) 

(DECLAIM (NOTINLINE |DirectProductMatrixModule;|)) 

(DEFUN |DirectProductMatrixModule| (&REST #1=#:G747)
  (SPROG NIL
         (PROG (#2=#:G748)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL T T T))
                     (HGET |$ConstructorCache| '|DirectProductMatrixModule|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DirectProductMatrixModule;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|DirectProductMatrixModule|)))))))))) 

(DEFUN |DirectProductMatrixModule;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) (#1=#:G739 NIL) (#2=#:G740 NIL) (#3=#:G741 NIL) (#4=#:G742 NIL)
    (#5=#:G743 NIL) (#6=#:G744 NIL) (#7=#:G745 NIL) (#8=#:G746 NIL) ($ NIL)
    (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|DirectProductMatrixModule| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 51))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#4|
                                                       '(|OrderedAbelianMonoidSup|))
                                        (OR
                                         (|HasCategory| |#4|
                                                        '(|OrderedAbelianMonoid|))
                                         (|HasCategory| |#4|
                                                        '(|OrderedAbelianMonoidSup|)))
                                        (LETT #8#
                                              (|HasCategory| |#4|
                                                             '(|OrderedSet|)))
                                        (OR
                                         (|HasCategory| |#4|
                                                        '(|OrderedAbelianMonoid|))
                                         (|HasCategory| |#4|
                                                        '(|OrderedAbelianMonoidSup|))
                                         #8#)
                                        (|HasCategory| |#4| '(|unitsKnown|))
                                        (|HasCategory| |#4|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#4| '(|SemiRng|))
                                        (|HasCategory| |#4| '(|Ring|))
                                        (|HasCategory| |#4| '(|Monoid|))
                                        (OR
                                         (|HasCategory| |#4|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#4| '(|SemiRng|)))
                                        (LETT #7#
                                              (|HasCategory| |#4| '(|Finite|)))
                                        (OR #7#
                                            (|HasCategory| |#4|
                                                           '(|OrderedAbelianMonoid|))
                                            (|HasCategory| |#4|
                                                           '(|OrderedAbelianMonoidSup|))
                                            #8#)
                                        (|HasCategory| |#4|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#4|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (LETT #6#
                                              (|HasCategory| |#4|
                                                             '(|DifferentialRing|)))
                                        (OR
                                         (|HasCategory| |#4|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#4|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#4|
                                                        '(|CommutativeRing|))
                                         #6# (|HasCategory| |#4| '(|Ring|))
                                         (|HasCategory| |#4| '(|SemiRng|)))
                                        (OR
                                         (|HasCategory| |#4|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#4|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#4|
                                                        '(|CommutativeRing|))
                                         #6# (|HasCategory| |#4| '(|Ring|)))
                                        (|HasCategory| |#4| '(|SetCategory|))
                                        (AND
                                         (|HasCategory| |#4|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#4|)))
                                         (|HasCategory| |#4| '(|SetCategory|)))
                                        (|HasCategory| |#4| '(|BasicType|))
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))
                                        (OR #7# #8#)
                                        (AND
                                         (|HasCategory| |#4|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#4| '(|Ring|)))
                                        (AND #6#
                                             (|HasCategory| |#4| '(|Ring|)))
                                        (AND
                                         (|HasCategory| |#4|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#4| '(|Ring|)))
                                        (LETT #5#
                                              (|HasCategory| |#4|
                                                             '(|SemiGroup|)))
                                        (OR (|HasCategory| |#4| '(|Monoid|))
                                            #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#4|
                                                              '(|RetractableTo|
                                                                (|Integer|)))
                                               (|HasCategory| |#4|
                                                              '(|SetCategory|))))
                                        (OR #4# (|HasCategory| |#4| '(|Ring|)))
                                        (AND
                                         (|HasCategory| |#4|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#4| '(|SetCategory|)))
                                        (|HasCategory| |#2| '(|AbelianMonoid|))
                                        (|HasCategory| |#3| '(|AbelianMonoid|))
                                        (LETT #3#
                                              (|HasCategory| |#4|
                                                             '(|AbelianMonoid|)))
                                        (AND #3#
                                             (|HasCategory| |#4| '(|Monoid|)))
                                        (AND #3#
                                             (|HasCategory| |#4| '(|SemiRng|)))
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (|HasCategory| |#3| '(|AbelianGroup|))
                                        (LETT #2#
                                              (|HasCategory| |#4|
                                                             '(|AbelianGroup|)))
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         (|HasCategory| |#3| '(|AbelianGroup|))
                                         (|HasCategory| |#4|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#4|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         #2#)
                                        (LETT #1#
                                              (|HasCategory| |#4|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|))))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          #6#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          #7#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4| '(|Monoid|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4|
                                                         '(|OrderedAbelianMonoid|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4|
                                                         '(|OrderedAbelianMonoidSup|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          #8#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          #5#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4| '(|SemiRng|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#4|)))
                                          (|HasCategory| |#4|
                                                         '(|SetCategory|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #6#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #7#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4| '(|Monoid|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4|
                                                         '(|OrderedAbelianMonoid|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4|
                                                         '(|OrderedAbelianMonoidSup|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #8#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #5#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4| '(|SemiRng|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#4|
                                                         '(|SetCategory|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#4|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #6#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #7#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#4| '(|Monoid|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#4|
                                                         '(|OrderedAbelianMonoid|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#4|
                                                         '(|OrderedAbelianMonoidSup|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #8#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#4| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #5#)
                                         (AND
                                          (|HasCategory| |#4|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#4| '(|SemiRng|)))
                                         #4#)
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         (|HasCategory| |#3| '(|AbelianGroup|))
                                         (|HasCategory| |#4|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#4|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         #2# #1#)
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         (|HasCategory| |#2|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#3| '(|AbelianGroup|))
                                         (|HasCategory| |#3|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#4|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#4|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         #2# #3# #1#)))))
    (|haddProp| |$ConstructorCache| '|DirectProductMatrixModule|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 35184372088832))
    (AND #8# (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 70368744177664))
    (AND (|HasCategory| |#4| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 140737488355328))
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 281474976710656))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianMonoid|))
         (|HasCategory| |#3| '(|AbelianMonoid|)) #3#
         (AND (|HasCategory| |#4| '(|SemiRng|))
              (|HasCategory| $ '(|AbelianMonoid|))))
     (|augmentPredVector| $ 562949953421312))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (|HasCategory| |#3| '(|AbelianGroup|))
         (AND #2# (|HasCategory| |#4| '(|SemiRng|))) #1#
         (AND (|HasCategory| |#4| '(|SemiRng|))
              (|HasCategory| $ '(|AbelianGroup|))))
     (|augmentPredVector| $ 1125899906842624))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (|HasCategory| |#3| '(|AbelianGroup|)) #2#
         (AND (|HasCategory| |#4| '(|SemiRng|))
              (|HasCategory| $ '(|AbelianGroup|))))
     (|augmentPredVector| $ 2251799813685248))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (|Vector| |#4|))
    $))) 

(MAKEPROP '|DirectProductMatrixModule| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 9)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|local| |#4|)
              '|Rep| (|Integer|) (0 . |elt|) (6 . *) |DPMM;*;R2$;1|
              (12 . |elt|) (19 . +) (25 . |Zero|) |DPMM;*;M2$;2| (|Boolean|)
              (|NonNegativeInteger|) (|PositiveInteger|) (|List| 9)
              (|Equation| 9) (|List| 23)
              (|Record| (|:| |mat| 28) (|:| |vec| (|Vector| 11))) (|Matrix| $)
              (|Vector| $) (|Matrix| 11) (|Symbol|) (|List| 29) (|List| 20)
              (|Union| 33 '#1="failed") (|Fraction| 11) (|Union| 11 '#1#)
              (|Union| $ '"failed") (|Mapping| 19 9 9) (|Mapping| 19 9)
              (|Void|) (|Mapping| 9 9) (|InputForm|) (|List| $)
              (|Record| (|:| |mat| 43) (|:| |vec| 49)) (|Matrix| 9)
              (|Union| 9 '#1#) (|SingleInteger|) (|OutputForm|) (|String|)
              (|HashState|) (|Vector| 9) (|List| 11))
           '#(|elt| 29 * 35) 'NIL
           (CONS
            (|makeByteWordVec2| 45
                                '(0 6 8 8 6 6 8 13 14 15 17 8 17 7 6 6 1 8 10
                                  10 0 0 0 1 7 10 7 10 17 2 39 2 8 9 44 0 4 9
                                  11 27 16 45 0 0 12 27 18 0 0 0 41 6 18 42 43
                                  0 0 0 0 0 0 41 3 5 6 11 18 42 43))
            (CONS
             '#(|DirectProductCategory&| NIL |FullyLinearlyExplicitOver&|
                |DifferentialExtension&| |Algebra&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                NIL |Module&| |Module&| NIL |NonAssociativeRing&| NIL NIL NIL
                NIL NIL NIL NIL NIL NIL NIL |NonAssociativeRng&| NIL
                |AbelianGroup&| NIL NIL NIL NIL |IndexedAggregate&|
                |OrderedSet&| |MagmaWithUnit&| |Finite&| NIL
                |NonAssociativeSemiRng&| |AbelianMonoid&|
                |HomogeneousAggregate&| |AbelianSemiGroup&| NIL |Magma&|
                |FullyRetractableTo&| |Aggregate&| |SetCategory&|
                |EltableAggregate&| |Evalable&| NIL |RetractableTo&|
                |RetractableTo&| |RetractableTo&| NIL NIL |BasicType&| NIL NIL
                NIL |InnerEvalable&| |PartialOrder&| NIL NIL NIL NIL NIL NIL)
             (CONS
              '#((|DirectProductCategory| 6 9) (|CommutativeRing|)
                 (|FullyLinearlyExplicitOver| 9) (|DifferentialExtension| 9)
                 (|Algebra| $$) (|Algebra| 9) (|LinearlyExplicitOver| 9)
                 (|LinearlyExplicitOver| 11) (|PartialDifferentialRing| 29)
                 (|DifferentialRing|) (|Ring|) (|SemiRing|) (|Rng|) (|SemiRng|)
                 (|Module| $$) (|Module| 9) (|OrderedAbelianMonoidSup|)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|BiModule| 9 9)
                 (|LeftModule| 8) (|LeftModule| 7) (|AbelianProductCategory| 9)
                 (|OrderedCancellationAbelianMonoid|) (|RightModule| $$)
                 (|LeftModule| $$) (|RightModule| 9) (|LeftModule| 9)
                 (|NonAssociativeRng|) (|OrderedAbelianMonoid|)
                 (|AbelianGroup|) (|OrderedAbelianSemiGroup|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|CancellationAbelianMonoid|) (|IndexedAggregate| 11 9)
                 (|OrderedSet|) (|MagmaWithUnit|) (|Finite|) (|SemiGroup|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|HomogeneousAggregate| 9) (|AbelianSemiGroup|) (|Comparable|)
                 (|Magma|) (|FullyRetractableTo| 9) (|Aggregate|)
                 (|SetCategory|) (|EltableAggregate| 11 9) (|Evalable| 9)
                 (|CommutativeStar|) (|RetractableTo| 9) (|RetractableTo| 33)
                 (|RetractableTo| 11) (|Type|) (|CoercibleTo| 46) (|BasicType|)
                 (|finiteAggregate|) (|CoercibleTo| (|Vector| 9))
                 (|Eltable| 11 9) (|InnerEvalable| 9 9) (|PartialOrder|)
                 (|unitsKnown|) (|TwoSidedRecip|) (|ConvertibleTo| 40)
                 (|CoercibleFrom| 9) (|CoercibleFrom| 33) (|CoercibleFrom| 11))
              (|makeByteWordVec2| 18
                                  '(2 0 9 0 11 12 2 9 0 7 0 13 3 8 7 0 11 11 15
                                    2 9 0 0 0 16 0 9 0 17 2 0 9 0 11 12 2 0 0 8
                                    0 18 2 0 0 7 0 14)))))
           '|lookupIncomplete|)) 
