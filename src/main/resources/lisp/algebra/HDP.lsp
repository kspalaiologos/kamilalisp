
(SDEFUN |HDP;<;2$B;1| ((|v1| ($)) (|v2| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G708 NIL) (|i| NIL) (|n2| (S)) (|n1| (S)) (#2=#:G709 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |n1| (|spadConstant| $ 9))
                (LETT |n2| (|spadConstant| $ 9))
                (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 6)) G190
                     (COND ((|greater_SI| |i| #2#) (GO G191)))
                     (SEQ
                      (LETT |n1|
                            (SPADCALL |n1| (SPADCALL |v1| |i| (QREFELT $ 11))
                                      (QREFELT $ 12)))
                      (EXIT
                       (LETT |n2|
                             (SPADCALL |n2| (SPADCALL |v2| |i| (QREFELT $ 11))
                                       (QREFELT $ 12)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (COND ((SPADCALL |n1| |n2| (QREFELT $ 14)) 'T)
                       ((SPADCALL |n2| |n1| (QREFELT $ 14)) NIL)
                       ('T
                        (SEQ
                         (SEQ (LETT |i| (QREFELT $ 6)) G190
                              (COND ((< |i| 1) (GO G191)))
                              (SEQ
                               (COND
                                ((SPADCALL (SPADCALL |v2| |i| (QREFELT $ 11))
                                           (SPADCALL |v1| |i| (QREFELT $ 11))
                                           (QREFELT $ 14))
                                 (PROGN (LETT #1# 'T) (GO #3=#:G707))))
                               (EXIT
                                (COND
                                 ((SPADCALL (SPADCALL |v1| |i| (QREFELT $ 11))
                                            (SPADCALL |v2| |i| (QREFELT $ 11))
                                            (QREFELT $ 14))
                                  (PROGN (LETT #1# NIL) (GO #3#))))))
                              (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                         (EXIT NIL)))))))
          #3# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |HomogeneousDirectProduct;|)) 

(DEFUN |HomogeneousDirectProduct| (&REST #1=#:G745)
  (SPROG NIL
         (PROG (#2=#:G746)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|HomogeneousDirectProduct|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |HomogeneousDirectProduct;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|HomogeneousDirectProduct|)))))))))) 

(DEFUN |HomogeneousDirectProduct;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G737 NIL) (#2=#:G738 NIL) (#3=#:G739 NIL) (#4=#:G740 NIL)
    (#5=#:G741 NIL) (#6=#:G742 NIL) (#7=#:G743 NIL) (#8=#:G744 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|HomogeneousDirectProduct| DV$1 DV$2))
    (LETT $ (GETREFV 47))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|OrderedAbelianMonoidSup|))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoid|))
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoidSup|)))
                                        (LETT #8#
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoid|))
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoidSup|))
                                         #8#)
                                        (|HasCategory| |#2| '(|unitsKnown|))
                                        (|HasCategory| |#2|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (|HasCategory| |#2| '(|SemiRng|))
                                        (|HasCategory| |#2| '(|Ring|))
                                        (|HasCategory| |#2| '(|Monoid|))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#2| '(|SemiRng|)))
                                        (LETT #7#
                                              (|HasCategory| |#2| '(|Finite|)))
                                        (OR #7#
                                            (|HasCategory| |#2|
                                                           '(|OrderedAbelianMonoid|))
                                            (|HasCategory| |#2|
                                                           '(|OrderedAbelianMonoidSup|))
                                            #8#)
                                        (|HasCategory| |#2|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (LETT #6#
                                              (|HasCategory| |#2|
                                                             '(|DifferentialRing|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #6# (|HasCategory| |#2| '(|Ring|))
                                         (|HasCategory| |#2| '(|SemiRng|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #6# (|HasCategory| |#2| '(|Ring|)))
                                        (|HasCategory| |#2| '(|SetCategory|))
                                        (AND
                                         (|HasCategory| |#2|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#2|)))
                                         (|HasCategory| |#2| '(|SetCategory|)))
                                        (|HasCategory| |#2| '(|BasicType|))
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))
                                        (OR #7# #8#)
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (AND #6#
                                             (|HasCategory| |#2| '(|Ring|)))
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (LETT #5#
                                              (|HasCategory| |#2|
                                                             '(|AbelianMonoid|)))
                                        (AND #5#
                                             (|HasCategory| |#2| '(|Monoid|)))
                                        (AND #5#
                                             (|HasCategory| |#2| '(|SemiRng|)))
                                        (LETT #4#
                                              (|HasCategory| |#2|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #5# #4#)
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #4#)
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #5# #4#
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #6# (|HasCategory| |#2| '(|Ring|))
                                         (|HasCategory| |#2| '(|SemiRng|)))
                                        (LETT #3#
                                              (|HasCategory| |#2|
                                                             '(|SemiGroup|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          #4#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          #6#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          #7#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2| '(|Monoid|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|OrderedAbelianMonoid|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|OrderedAbelianMonoidSup|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          #8#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          #3#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2| '(|SemiRng|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|SetCategory|))))
                                        (OR (|HasCategory| |#2| '(|Monoid|))
                                            #3#)
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #5#
                                         (|HasCategory| |#2| '(|BasicType|))
                                         #4#
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #6# #7#
                                         (|HasCategory| |#2| '(|Monoid|))
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoid|))
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoidSup|))
                                         #8# (|HasCategory| |#2| '(|Ring|)) #3#
                                         (|HasCategory| |#2| '(|SemiRng|))
                                         (|HasCategory| |#2| '(|SetCategory|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #5# #4#
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #6# #7#
                                         (|HasCategory| |#2| '(|Monoid|))
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoid|))
                                         (|HasCategory| |#2|
                                                        '(|OrderedAbelianMonoidSup|))
                                         #8# (|HasCategory| |#2| '(|Ring|)) #3#
                                         (|HasCategory| |#2| '(|SemiRng|))
                                         (|HasCategory| |#2| '(|SetCategory|)))
                                        (OR #5#
                                            (|HasCategory| |#2| '(|SemiRng|)))
                                        (|HasCategory| |#2|
                                                       '(|CoercibleTo|
                                                         (|OutputForm|)))
                                        (LETT #2#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|RetractableTo|
                                                                (|Integer|)))
                                               (|HasCategory| |#2|
                                                              '(|SetCategory|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #4#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #6#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #7#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#2| '(|Monoid|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|OrderedAbelianMonoid|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|OrderedAbelianMonoidSup|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #8#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#2| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          #3#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Integer|)))
                                          (|HasCategory| |#2| '(|SemiRng|)))
                                         #2#)
                                        (OR #2# (|HasCategory| |#2| '(|Ring|)))
                                        (LETT #1#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|RetractableTo|
                                                                (|Fraction|
                                                                 (|Integer|))))
                                               (|HasCategory| |#2|
                                                              '(|SetCategory|))))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|SetCategory|)))
                                         #1# #2#
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|AbelianGroup|))
                                          (|HasCategory| |#2| '(|SemiRng|)))
                                         (AND #5#
                                              (|HasCategory| |#2|
                                                             '(|SemiRng|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #4#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #6#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #7#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2| '(|Monoid|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|OrderedAbelianMonoid|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|OrderedAbelianMonoidSup|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #8#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          #3#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|RetractableTo|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2| '(|SemiRng|)))
                                         #1#)))))
    (|haddProp| |$ConstructorCache| '|HomogeneousDirectProduct|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 70368744177664))
    (AND #8# (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 140737488355328))
    (AND (|HasCategory| |#2| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 281474976710656))
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 562949953421312))
    (AND
     (OR #5#
         (AND (|HasCategory| |#2| '(|SemiRng|))
              (|HasCategory| $ '(|AbelianMonoid|))))
     (|augmentPredVector| $ 1125899906842624))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|AbelianGroup|))
           (|HasCategory| |#2| '(|SemiRng|)))
      #4#
      (AND (|HasCategory| |#2| '(|SemiRng|))
           (|HasCategory| $ '(|AbelianGroup|))))
     (|augmentPredVector| $ 2251799813685248))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (AND (|HasCategory| |#2| '(|SemiRng|))
              (|HasCategory| $ '(|AbelianGroup|))))
     (|augmentPredVector| $ 4503599627370496))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      (|HasCategory| |#2| '(|SetCategory|)))
     (|augmentPredVector| $ 9007199254740992))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|Vector| |#2|))
    $))) 

(MAKEPROP '|HomogeneousDirectProduct| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 7)
              (|local| |#1|) (|local| |#2|) '|Rep| (0 . |Zero|) (|Integer|)
              (4 . |qelt|) (10 . +) (|Boolean|) (16 . <) |HDP;<;2$B;1|
              (|NonNegativeInteger|) (|PositiveInteger|) (|List| 7)
              (|Equation| 7) (|List| 19)
              (|Record| (|:| |mat| 24) (|:| |vec| (|Vector| 10))) (|Matrix| $)
              (|Vector| $) (|Matrix| 10) (|List| 27) (|List| 16) (|Symbol|)
              (|Union| 29 '#1="failed") (|Fraction| 10) (|Union| 10 '#1#)
              (|Union| $ '"failed") (|Mapping| 13 7 7) (|Mapping| 13 7)
              (|Void|) (|Mapping| 7 7) (|OutputForm|) (|InputForm|) (|List| $)
              (|Matrix| 7) (|Record| (|:| |mat| 39) (|:| |vec| 45))
              (|Union| 7 '#1#) (|SingleInteger|) (|String|) (|HashState|)
              (|Vector| 7) (|List| 10))
           '#(|qelt| 22 < 28) 'NIL
           (CONS
            (|makeByteWordVec2| 46
                                '(0 6 9 9 6 6 9 14 15 16 18 9 18 8 6 6 1 9 11
                                  11 0 1 8 11 8 11 18 2 7 2 32 9 10 0 4 31 10
                                  12 36 17 0 13 36 33 19 0 0 35 6 38 19 46 42 0
                                  0 0 0 35 45 3 5 6 12 37 19 46 42))
            (CONS
             '#(|DirectProductCategory&| NIL |FullyLinearlyExplicitOver&|
                |DifferentialExtension&| |Algebra&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                NIL |Module&| |Module&| NIL |NonAssociativeRing&| NIL NIL NIL
                NIL NIL NIL NIL NIL |NonAssociativeRng&| NIL |AbelianGroup&|
                NIL NIL NIL NIL |IndexedAggregate&| |OrderedSet&|
                |AbelianMonoid&| |MagmaWithUnit&| |Finite&| NIL
                |NonAssociativeSemiRng&| |HomogeneousAggregate&| NIL |Magma&|
                |AbelianSemiGroup&| |FullyRetractableTo&| |Aggregate&|
                |EltableAggregate&| |Evalable&| NIL |SetCategory&|
                |RetractableTo&| |RetractableTo&| |RetractableTo&| NIL NIL NIL
                NIL |InnerEvalable&| NIL |PartialOrder&| NIL NIL NIL
                |BasicType&| NIL NIL NIL)
             (CONS
              '#((|DirectProductCategory| 6 7) (|CommutativeRing|)
                 (|FullyLinearlyExplicitOver| 7) (|DifferentialExtension| 7)
                 (|Algebra| $$) (|Algebra| 7) (|LinearlyExplicitOver| 7)
                 (|LinearlyExplicitOver| 10) (|PartialDifferentialRing| 27)
                 (|DifferentialRing|) (|Ring|) (|SemiRing|) (|Rng|) (|SemiRng|)
                 (|Module| $$) (|Module| 7) (|OrderedAbelianMonoidSup|)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|BiModule| 7 7)
                 (|AbelianProductCategory| 7)
                 (|OrderedCancellationAbelianMonoid|) (|RightModule| $$)
                 (|LeftModule| $$) (|RightModule| 7) (|LeftModule| 7)
                 (|NonAssociativeRng|) (|OrderedAbelianMonoid|)
                 (|AbelianGroup|) (|OrderedAbelianSemiGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|IndexedAggregate| 10 7) (|OrderedSet|)
                 (|AbelianMonoid|) (|MagmaWithUnit|) (|Finite|) (|SemiGroup|)
                 (|NonAssociativeSemiRng|) (|HomogeneousAggregate| 7)
                 (|Comparable|) (|Magma|) (|AbelianSemiGroup|)
                 (|FullyRetractableTo| 7) (|Aggregate|)
                 (|EltableAggregate| 10 7) (|Evalable| 7) (|CommutativeStar|)
                 (|SetCategory|) (|RetractableTo| 7) (|RetractableTo| 29)
                 (|RetractableTo| 10) (|Type|) (|finiteAggregate|)
                 (|CoercibleTo| (|Vector| 7)) (|Eltable| 10 7)
                 (|InnerEvalable| 7 7) (|CoercibleTo| 36) (|PartialOrder|)
                 (|unitsKnown|) (|TwoSidedRecip|) (|ConvertibleTo| 37)
                 (|BasicType|) (|CoercibleFrom| 7) (|CoercibleFrom| 29)
                 (|CoercibleFrom| 10))
              (|makeByteWordVec2| 15
                                  '(0 7 0 9 2 0 7 0 10 11 2 7 0 0 0 12 2 7 13 0
                                    0 14 2 0 7 0 10 11 2 3 13 0 0 15)))))
           '|lookupIncomplete|)) 
