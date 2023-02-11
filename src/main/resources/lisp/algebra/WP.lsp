
(SDEFUN |WP;changeWeightLevel;NniV;1|
        ((|n| (|NonNegativeInteger|)) ($ (|Void|))) (SETELT $ 12 |n|)) 

(SDEFUN |WP;lookup| ((|v| (|VarSet|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |var| |VarSet|)
                      (|:| |weight| (|NonNegativeInteger|)))))
          (#1=#:G719 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |l| (QREFELT $ 22))
                (SEQ G190
                     (COND
                      ((NULL (SPADCALL |l| NIL (QREFELT $ 25))) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |v| (QCAR (|SPADfirst| |l|)) (QREFELT $ 26))
                         (PROGN
                          (LETT #1# (QCDR (|SPADfirst| |l|)))
                          (GO #2=#:G718)))
                        ('T (LETT |l| (CDR |l|))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT 0)))
          #2# (EXIT #1#)))) 

(SDEFUN |WP;innercoerce| ((|p| (P)) (|z| (|Integer|)) ($ ($)))
        (SPROG
         ((|tmp| ($)) (|ans| ($)) (|mon| (P))
          (|up| (|SparseUnivariatePolynomial| P)) (|lcup| (P))
          (|f| (|NonNegativeInteger|)) (|d| (|NonNegativeInteger|))
          (|n| (|NonNegativeInteger|)) (|mv| (|Union| |VarSet| "failed")))
         (SEQ
          (COND
           ((OR (< |z| 0) (SPADCALL |p| (QREFELT $ 28))) (|spadConstant| $ 27))
           ('T
            (SEQ (LETT |mv| (SPADCALL |p| (QREFELT $ 30)))
                 (EXIT
                  (COND ((QEQCAR |mv| 1) (SPADCALL |p| 0 (QREFELT $ 31)))
                        ('T
                         (SEQ (LETT |n| (|WP;lookup| (QCDR |mv|) $))
                              (LETT |up|
                                    (SPADCALL |p| (QCDR |mv|) (QREFELT $ 33)))
                              (LETT |ans| (|spadConstant| $ 27))
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (NULL (SPADCALL |up| (QREFELT $ 35))))
                                     (GO G191)))
                                   (SEQ
                                    (LETT |d| (SPADCALL |up| (QREFELT $ 36)))
                                    (LETT |f| (* |n| |d|))
                                    (LETT |lcup|
                                          (SPADCALL |up| (QREFELT $ 37)))
                                    (LETT |up|
                                          (SPADCALL |up|
                                                    (SPADCALL |up|
                                                              (QREFELT $ 38))
                                                    (QREFELT $ 39)))
                                    (LETT |mon|
                                          (SPADCALL (|spadConstant| $ 40)
                                                    (QCDR |mv|) |d|
                                                    (QREFELT $ 41)))
                                    (EXIT
                                     (COND
                                      ((<= |f| |z|)
                                       (SEQ
                                        (LETT |tmp|
                                              (|WP;innercoerce| |lcup|
                                               (- |z| |f|) $))
                                        (EXIT
                                         (SEQ G190
                                              (COND
                                               ((NULL
                                                 (NULL
                                                  (SPADCALL |tmp|
                                                            (QREFELT $ 42))))
                                                (GO G191)))
                                              (SEQ
                                               (LETT |ans|
                                                     (SPADCALL |ans|
                                                               (SPADCALL
                                                                (SPADCALL |mon|
                                                                          (SPADCALL
                                                                           |tmp|
                                                                           (QREFELT
                                                                            $
                                                                            43))
                                                                          (QREFELT
                                                                           $
                                                                           44))
                                                                (+
                                                                 (SPADCALL
                                                                  |tmp|
                                                                  (QREFELT $
                                                                           45))
                                                                 |f|)
                                                                (QREFELT $ 31))
                                                               (QREFELT $ 46)))
                                               (EXIT
                                                (LETT |tmp|
                                                      (SPADCALL |tmp|
                                                                (QREFELT $
                                                                         47)))))
                                              NIL (GO G190) G191
                                              (EXIT NIL))))))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (EXIT |ans|))))))))))) 

(SDEFUN |WP;coerce;P$;4| ((|p| (P)) ($ ($)))
        (|WP;innercoerce| |p| (QREFELT $ 12) $)) 

(SDEFUN |WP;coerce;$P;5| ((|w| ($)) ($ (P)))
        (SPROG
         ((#1=#:G739 NIL) (#2=#:G738 (P)) (#3=#:G740 (P)) (#4=#:G742 NIL)
          (|c| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |c| NIL) (LETT #4# (SPADCALL |w| (QREFELT $ 50))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |c| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3# |c|)
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 51))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 52))))))) 

(SDEFUN |WP;coerce;$Of;6| ((|p| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G757 NIL) (|c| NIL) (#2=#:G756 NIL))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 42)) (SPADCALL 0 (QREFELT $ 56)))
                 ((EQL (SPADCALL |p| (QREFELT $ 45)) 0)
                  (SPADCALL (SPADCALL |p| (QREFELT $ 43)) (QREFELT $ 57)))
                 ('T
                  (SPADCALL (ELT $ 59)
                            (REVERSE
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |c| NIL)
                                   (LETT #1# (SPADCALL |p| (QREFELT $ 50)))
                                   G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |c| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (SPADCALL
                                             (SPADCALL |c| (QREFELT $ 57))
                                             (QREFELT $ 58))
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                            (QREFELT $ 62))))))) 

(SDEFUN |WP;Zero;$;7| (($ ($))) (|spadConstant| $ 64)) 

(SDEFUN |WP;One;$;8| (($ ($))) (|spadConstant| $ 65)) 

(SDEFUN |WP;=;2$B;9| ((|x1| ($)) (|x2| ($)) ($ (|Boolean|)))
        (SEQ
         (SEQ G190
              (COND
               ((NULL (> (SPADCALL |x1| (QREFELT $ 45)) (QREFELT $ 12)))
                (GO G191)))
              (SEQ (EXIT (LETT |x1| (SPADCALL |x1| (QREFELT $ 47))))) NIL
              (GO G190) G191 (EXIT NIL))
         (SEQ G190
              (COND
               ((NULL (> (SPADCALL |x2| (QREFELT $ 45)) (QREFELT $ 12)))
                (GO G191)))
              (SEQ (EXIT (LETT |x2| (SPADCALL |x2| (QREFELT $ 47))))) NIL
              (GO G190) G191 (EXIT NIL))
         (EXIT (SPADCALL |x1| |x2| (QREFELT $ 67))))) 

(SDEFUN |WP;+;3$;10| ((|x1| ($)) (|x2| ($)) ($ ($)))
        (SPADCALL |x1| |x2| (QREFELT $ 69))) 

(SDEFUN |WP;-;2$;11| ((|x1| ($)) ($ ($))) (SPADCALL |x1| (QREFELT $ 70))) 

(SDEFUN |WP;*;I2$;12| ((|z| (|Integer|)) (|x1| ($)) ($ ($)))
        (SPADCALL |z| |x1| (QREFELT $ 71))) 

(SDEFUN |WP;*;3$;13| ((|x1| ($)) (|x2| ($)) ($ ($)))
        (SPROG ((|w| ($)))
               (SEQ (LETT |w| (SPADCALL |x1| |x2| (QREFELT $ 73)))
                    (SEQ G190
                         (COND
                          ((NULL
                            (> (SPADCALL |w| (QREFELT $ 45)) (QREFELT $ 12)))
                           (GO G191)))
                         (SEQ (EXIT (LETT |w| (SPADCALL |w| (QREFELT $ 47)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |w|)))) 

(SDEFUN |WP;characteristic;Nni;14| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 75))) 

(DECLAIM (NOTINLINE |WeightedPolynomials;|)) 

(DEFUN |WeightedPolynomials| (&REST #1=#:G783)
  (SPROG NIL
         (PROG (#2=#:G784)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T T T NIL NIL NIL))
                     (HGET |$ConstructorCache| '|WeightedPolynomials|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |WeightedPolynomials;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|WeightedPolynomials|)))))))))) 

(DEFUN |WeightedPolynomials;| (|#1| |#2| |#3| |#4| |#5| |#6| |#7|)
  (SPROG
   ((#1=#:G781 NIL) (|v| NIL) (#2=#:G782 NIL) (|n| NIL) (#3=#:G780 NIL)
    (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$7 NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL)
    (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 (|devaluate| |#1|))
     (LETT DV$2 (|devaluate| |#2|))
     (LETT DV$3 (|devaluate| |#3|))
     (LETT DV$4 (|devaluate| |#4|))
     (LETT DV$5 |#5|)
     (LETT DV$6 |#6|)
     (LETT DV$7 |#7|)
     (LETT |dv$|
           (LIST '|WeightedPolynomials| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7))
     (LETT $ (GETREFV 82))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3
               (LETT |pv$|
                     (|buildPredVector| 0 0
                                        (LIST
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1| '(|Field|))))))
     (|haddProp| |$ConstructorCache| '|WeightedPolynomials|
                 (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7) (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (QSETREFV $ 7 |#2|)
     (QSETREFV $ 8 |#3|)
     (QSETREFV $ 9 |#4|)
     (QSETREFV $ 10 |#5|)
     (QSETREFV $ 11 |#6|)
     (QSETREFV $ 12 |#7|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 13 (|PolynomialRing| |#4| (|NonNegativeInteger|)))
     (QSETREFV $ 21
               (SPADCALL (LENGTH |#5|) (SPADCALL |#6| (QREFELT $ 18))
                         (QREFELT $ 20)))
     (COND
      ((QREFELT $ 21)
       (|error| "incompatible length lists in WeightedPolynomial")))
     (QSETREFV $ 22
               (PROGN
                (LETT #3# NIL)
                (SEQ (LETT |n| NIL) (LETT #2# |#6|) (LETT |v| NIL)
                     (LETT #1# |#5|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |n| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT #3# (CONS (CONS |v| |n|) #3#))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT (NREVERSE #3#)))))
     $)))) 

(MAKEPROP '|WeightedPolynomials| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) '|Rep| (|Void|) (|NonNegativeInteger|)
              |WP;changeWeightLevel;NniV;1| (|List| 15) (0 . |#|) (|Boolean|)
              (5 . ~=) '#:G689 '|lookupList|
              (|Record| (|:| |var| 7) (|:| |weight| 15)) (|List| 23) (11 . ~=)
              (17 . =)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |WP;Zero;$;7|) $))
              (23 . |zero?|) (|Union| 7 '"failed") (28 . |mainVariable|)
              (33 . |monomial|) (|SparseUnivariatePolynomial| $)
              (39 . |univariate|) (|SparseUnivariatePolynomial| 9)
              (45 . |zero?|) (50 . |degree|) (55 . |leadingCoefficient|)
              (60 . |leadingMonomial|) (65 . -) (71 . |One|) (75 . |monomial|)
              (82 . |zero?|) (87 . |leadingCoefficient|) (92 . *)
              (98 . |degree|) |WP;+;3$;10| (103 . |reductum|) |WP;coerce;P$;4|
              (|List| 9) (108 . |coefficients|) (113 . +) (119 . |Zero|)
              |WP;coerce;$P;5| (|OutputForm|) (|Integer|) (123 . |coerce|)
              (128 . |coerce|) (133 . |paren|) (138 . +) (|Mapping| 54 54 54)
              (|List| 54) (144 . |reduce|) |WP;coerce;$Of;6| (150 . |Zero|)
              (154 . |One|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |WP;One;$;8|) $))
              (158 . =) |WP;=;2$B;9| (164 . +) |WP;-;2$;11| (170 . *)
              |WP;*;I2$;12| (176 . *) |WP;*;3$;13| (182 . |characteristic|)
              |WP;characteristic;Nni;14| (|Union| $ '"failed")
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 186 |zero?| 192 |subtractIfCan| 197 |sample| 203 |rightRecip|
              207 |rightPower| 212 |recip| 224 |opposite?| 229 |one?| 235
              |leftRecip| 240 |leftPower| 245 |latex| 257 |hashUpdate!| 262
              |hash| 268 |commutator| 273 |coerce| 279 |characteristic| 304
              |changeWeightLevel| 308 |associator| 313 |antiCommutator| 320
              |annihilate?| 326 ^ 332 |Zero| 344 |One| 348 = 352 / 358 - 364 +
              375 * 381)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(1 0 0 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0))
            (CONS
             '#(|Algebra&| NIL |Rng&| NIL NIL |Module&| |NonAssociativeRing&|
                NIL NIL |NonAssociativeRng&| NIL NIL NIL NIL |AbelianGroup&|
                NIL NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |Magma&| |AbelianSemiGroup&| |SetCategory&|
                NIL |BasicType&| NIL)
             (CONS
              '#((|Algebra| 6) (|Ring|) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|Module| 6) (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|BiModule| 6 6) (|NonAssociativeRng|) (|RightModule| $$)
                 (|LeftModule| $$) (|LeftModule| 6) (|RightModule| 6)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|SetCategory|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 54))
              (|makeByteWordVec2| 81
                                  '(1 17 15 0 18 2 15 19 0 0 20 2 24 19 0 0 25
                                    2 7 19 0 0 26 1 9 19 0 28 1 9 29 0 30 2 13
                                    0 9 15 31 2 9 32 0 7 33 1 34 19 0 35 1 34
                                    15 0 36 1 34 9 0 37 1 34 0 0 38 2 34 0 0 0
                                    39 0 9 0 40 3 9 0 0 7 15 41 1 0 19 0 42 1
                                    13 9 0 43 2 9 0 0 0 44 1 13 15 0 45 1 13 0
                                    0 47 1 13 49 0 50 2 9 0 0 0 51 0 9 0 52 1
                                    55 54 0 56 1 9 54 0 57 1 54 0 0 58 2 54 0 0
                                    0 59 2 61 54 60 0 62 0 13 0 64 0 13 0 65 2
                                    13 19 0 0 67 2 13 0 0 0 69 2 13 0 55 0 71 2
                                    13 0 0 0 73 0 6 15 75 2 0 19 0 0 1 1 0 19 0
                                    42 2 0 77 0 0 1 0 0 0 1 1 0 77 0 1 2 0 0 0
                                    15 1 2 0 0 0 78 1 1 0 77 0 1 2 0 19 0 0 1 1
                                    0 19 0 1 1 0 77 0 1 2 0 0 0 15 1 2 0 0 0 78
                                    1 1 0 79 0 1 2 0 81 81 0 1 1 0 80 0 1 2 0 0
                                    0 0 1 1 1 0 6 1 1 0 0 9 48 1 0 9 0 53 1 0 0
                                    55 1 1 0 54 0 63 0 0 15 76 1 0 14 15 16 3 0
                                    0 0 0 0 1 2 0 0 0 0 1 2 0 19 0 0 1 2 0 0 0
                                    15 1 2 0 0 0 78 1 0 0 0 27 0 0 0 66 2 0 19
                                    0 0 68 2 2 77 0 0 1 2 0 0 0 0 1 1 0 0 0 70
                                    2 0 0 0 0 46 2 1 0 0 6 1 2 1 0 6 0 1 2 0 0
                                    15 0 1 2 0 0 55 0 72 2 0 0 0 0 74 2 0 0 78
                                    0 1)))))
           '|lookupComplete|)) 
