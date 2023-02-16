
(PUT '|ITAYLOR;stream| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |ITAYLOR;stream| ((|x| ($)) ($ (|Stream| |Coef|))) |x|) 

(PUT '|ITAYLOR;series;S$;2| '|SPADreplace| '(XLAM (|st|) |st|)) 

(SDEFUN |ITAYLOR;series;S$;2| ((|st| (|Stream| |Coef|)) ($ ($))) |st|) 

(SDEFUN |ITAYLOR;Zero;$;3| (($ ($)))
        (SPADCALL (|spadConstant| $ 11) (QREFELT $ 13))) 

(SDEFUN |ITAYLOR;One;$;4| (($ ($)))
        (SPADCALL (|spadConstant| $ 15) (QREFELT $ 13))) 

(SDEFUN |ITAYLOR;=;2$B;5| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG
         ((|st| (|Stream| |Coef|)) (#1=#:G711 NIL) (#2=#:G712 NIL) (|i| NIL)
          (|n| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |st| (|ITAYLOR;stream| (SPADCALL |x| |y| (QREFELT $ 16)) $))
            (LETT |n| |$streamCount|)
            (SEQ (LETT |i| 0) (LETT #2# |n|) G190
                 (COND ((|greater_SI| |i| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |st| (QREFELT $ 18))
                     (PROGN (LETT #1# 'T) (GO #3=#:G710)))
                    ((SPADCALL (SPADCALL |st| (QREFELT $ 19))
                               (|spadConstant| $ 11) (QREFELT $ 20))
                     (PROGN (LETT #1# NIL) (GO #3#)))
                    ('T (LETT |st| (SPADCALL |st| (QREFELT $ 21)))))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (EXIT (SPADCALL |st| (QREFELT $ 18)))))
          #3# (EXIT #1#)))) 

(SDEFUN |ITAYLOR;coefficients;$S;6| ((|x| ($)) ($ (|Stream| |Coef|)))
        (|ITAYLOR;stream| |x| $)) 

(SDEFUN |ITAYLOR;+;3$;7| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|ITAYLOR;stream| |x| $) (|ITAYLOR;stream| |y| $)
                  (QREFELT $ 24))) 

(SDEFUN |ITAYLOR;-;3$;8| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|ITAYLOR;stream| |x| $) (|ITAYLOR;stream| |y| $)
                  (QREFELT $ 26))) 

(SDEFUN |ITAYLOR;*;3$;9| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|ITAYLOR;stream| |x| $) (|ITAYLOR;stream| |y| $)
                  (QREFELT $ 27))) 

(SDEFUN |ITAYLOR;-;2$;10| ((|x| ($)) ($ ($)))
        (SPADCALL (|ITAYLOR;stream| |x| $) (QREFELT $ 29))) 

(SDEFUN |ITAYLOR;*;I2$;11| ((|i| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 32)) (|ITAYLOR;stream| |x| $)
                  (QREFELT $ 33))) 

(SDEFUN |ITAYLOR;*;$I$;12| ((|x| ($)) (|i| (|Integer|)) ($ ($)))
        (SPADCALL (|ITAYLOR;stream| |x| $) (SPADCALL |i| (QREFELT $ 32))
                  (QREFELT $ 35))) 

(SDEFUN |ITAYLOR;*;Coef2$;13| ((|c| (|Coef|)) (|x| ($)) ($ ($)))
        (SPADCALL |c| (|ITAYLOR;stream| |x| $) (QREFELT $ 33))) 

(SDEFUN |ITAYLOR;*;$Coef$;14| ((|x| ($)) (|c| (|Coef|)) ($ ($)))
        (SPADCALL (|ITAYLOR;stream| |x| $) |c| (QREFELT $ 35))) 

(SDEFUN |ITAYLOR;recip;$U;15| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|rec| (|Union| (|Stream| |Coef|) "failed")))
               (SEQ
                (LETT |rec| (SPADCALL (|ITAYLOR;stream| |x| $) (QREFELT $ 40)))
                (EXIT
                 (COND ((QEQCAR |rec| 1) (CONS 1 "failed"))
                       ('T (CONS 0 (SPADCALL (QCDR |rec|) (QREFELT $ 9))))))))) 

(SDEFUN |ITAYLOR;exquo;2$U;16| ((|x| ($)) (|y| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|quot| (|Union| (|Stream| |Coef|) "failed")))
               (SEQ
                (LETT |quot|
                      (SPADCALL (|ITAYLOR;stream| |x| $)
                                (|ITAYLOR;stream| |y| $) (QREFELT $ 43)))
                (EXIT
                 (COND ((QEQCAR |quot| 1) (CONS 1 "failed"))
                       ('T (CONS 0 (SPADCALL (QCDR |quot|) (QREFELT $ 9))))))))) 

(SDEFUN |ITAYLOR;^;$Nni$;17| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G743 NIL))
               (COND ((EQL |n| 0) (|spadConstant| $ 14))
                     ('T
                      (SPADCALL |x|
                                (PROG1 (LETT #1# |n|)
                                  (|check_subtype2| (> #1# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #1#))
                                (QREFELT $ 47)))))) 

(SDEFUN |ITAYLOR;characteristic;Nni;18| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 50))) 

(PUT '|ITAYLOR;pole?;$B;19| '|SPADreplace| '(XLAM (|x|) NIL)) 

(SDEFUN |ITAYLOR;pole?;$B;19| ((|x| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |ITAYLOR;iOrder|
        ((|st| (|Stream| |Coef|)) (|n| (|NonNegativeInteger|))
         (|n0| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (COND ((OR (EQL |n| |n0|) (SPADCALL |st| (QREFELT $ 18))) |n0|)
              ('T
               (COND
                ((SPADCALL (SPADCALL |st| (QREFELT $ 19)) (QREFELT $ 53))
                 (|ITAYLOR;iOrder| (SPADCALL |st| (QREFELT $ 21)) (+ |n| 1)
                  |n0| $))
                ('T |n|))))) 

(SDEFUN |ITAYLOR;order;$2Nni;21|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (|ITAYLOR;iOrder| (|ITAYLOR;stream| |x| $) 0 |n| $)) 

(SDEFUN |ITAYLOR;iOrder2|
        ((|st| (|Stream| |Coef|)) (|n| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (COND
         ((SPADCALL |st| (QREFELT $ 18))
          (|error| "order: series has infinite order"))
         ((SPADCALL (SPADCALL |st| (QREFELT $ 19)) (QREFELT $ 53))
          (|ITAYLOR;iOrder2| (SPADCALL |st| (QREFELT $ 21)) (+ |n| 1) $))
         ('T |n|))) 

(SDEFUN |ITAYLOR;order;$Nni;23| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (|ITAYLOR;iOrder2| (|ITAYLOR;stream| |x| $) 0 $)) 

(DECLAIM (NOTINLINE |InnerTaylorSeries;|)) 

(DEFUN |InnerTaylorSeries| (#1=#:G756)
  (SPROG NIL
         (PROG (#2=#:G757)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|InnerTaylorSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|InnerTaylorSeries;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InnerTaylorSeries|)))))))))) 

(DEFUN |InnerTaylorSeries;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|InnerTaylorSeries| DV$1))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|))))))
          (|haddProp| |$ConstructorCache| '|InnerTaylorSeries| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Stream| |#1|))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 44
                      (CONS (|dispatchFunction| |ITAYLOR;exquo;2$U;16|) $))))
          $))) 

(MAKEPROP '|InnerTaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Stream| 6)
              |ITAYLOR;series;S$;2|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |ITAYLOR;Zero;$;3|) $))
              (0 . |Zero|) (|StreamTaylorSeriesOperations| 6) (4 . |coerce|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |ITAYLOR;One;$;4|) $))
              (9 . |One|) |ITAYLOR;-;3$;8| (|Boolean|) (13 . |empty?|)
              (18 . |frst|) (23 . ~=) (29 . |rst|) |ITAYLOR;=;2$B;5|
              |ITAYLOR;coefficients;$S;6| (34 . +) |ITAYLOR;+;3$;7| (40 . -)
              (46 . *) |ITAYLOR;*;3$;9| (52 . -) |ITAYLOR;-;2$;10| (|Integer|)
              (57 . |coerce|) (62 . *) |ITAYLOR;*;I2$;11| (68 . *)
              |ITAYLOR;*;$I$;12| |ITAYLOR;*;Coef2$;13| |ITAYLOR;*;$Coef$;14|
              (|Union| 8 '"failed") (74 . |recip|) (|Union| $ '"failed")
              |ITAYLOR;recip;$U;15| (79 . |exquo|) (85 . |exquo|)
              (|PositiveInteger|) (|RepeatedSquaring| $$) (91 . |expt|)
              (|NonNegativeInteger|) |ITAYLOR;^;$Nni$;17|
              (97 . |characteristic|) |ITAYLOR;characteristic;Nni;18|
              |ITAYLOR;pole?;$B;19| (101 . |zero?|) |ITAYLOR;order;$2Nni;21|
              |ITAYLOR;order;$Nni;23|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|HashState|) (|String|) (|OutputForm|) (|SingleInteger|))
           '#(~= 106 |zero?| 112 |unitNormal| 117 |unitCanonical| 122 |unit?|
              127 |subtractIfCan| 132 |series| 138 |sample| 143 |rightRecip|
              147 |rightPower| 152 |recip| 164 |pole?| 169 |order| 174
              |opposite?| 185 |one?| 191 |leftRecip| 196 |leftPower| 201
              |latex| 213 |hashUpdate!| 218 |hash| 224 |exquo| 229 |commutator|
              235 |coerce| 241 |coefficients| 256 |characteristic| 261
              |associator| 265 |associates?| 272 |antiCommutator| 278
              |annihilate?| 284 ^ 290 |Zero| 302 |One| 306 = 310 - 316 + 327 *
              333)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(1 1 1 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 1 0 0 0 1 1))
            (CONS
             '#(NIL NIL |Algebra&| |EntireRing&| NIL |Rng&| NIL NIL |Module&|
                |NonAssociativeRing&| NIL |NonAssociativeRng&| NIL NIL
                |AbelianGroup&| NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |Magma&|
                |AbelianSemiGroup&| |SetCategory&| NIL NIL |BasicType&| NIL NIL
                NIL)
             (CONS
              '#((|IntegralDomain|) (|CommutativeRing|) (|Algebra| $$)
                 (|EntireRing|) (|Ring|) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|Module| $$) (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| $$)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|SetCategory|) (|CommutativeStar|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 59)
                 (|TwoSidedRecip|) (|noZeroDivisors|))
              (|makeByteWordVec2| 60
                                  '(0 6 0 11 1 12 8 6 13 0 6 0 15 1 7 17 0 18 1
                                    7 6 0 19 2 6 17 0 0 20 1 8 0 0 21 2 12 8 8
                                    8 24 2 12 8 8 8 26 2 12 8 8 8 27 1 12 8 8
                                    29 1 6 0 31 32 2 12 8 6 8 33 2 12 8 8 6 35
                                    1 12 39 8 40 2 12 39 8 8 43 2 0 41 0 0 44 2
                                    46 2 2 45 47 0 6 48 50 1 6 17 0 53 2 0 17 0
                                    0 1 1 0 17 0 1 1 1 56 0 1 1 1 0 0 1 1 1 17
                                    0 1 2 0 41 0 0 1 1 0 0 8 9 0 0 0 1 1 0 41 0
                                    1 2 0 0 0 48 1 2 0 0 0 45 1 1 0 41 0 42 1 0
                                    17 0 52 2 0 48 0 48 54 1 0 48 0 55 2 0 17 0
                                    0 1 1 0 17 0 1 1 0 41 0 1 2 0 0 0 48 1 2 0
                                    0 0 45 1 1 0 58 0 1 2 0 57 57 0 1 1 0 60 0
                                    1 2 1 41 0 0 44 2 0 0 0 0 1 1 1 0 0 1 1 0 0
                                    31 1 1 0 59 0 1 1 0 8 0 23 0 0 48 51 3 0 0
                                    0 0 0 1 2 1 17 0 0 1 2 0 0 0 0 1 2 0 17 0 0
                                    1 2 0 0 0 48 49 2 0 0 0 45 1 0 0 0 10 0 0 0
                                    14 2 0 17 0 0 22 1 0 0 0 30 2 0 0 0 0 16 2
                                    0 0 0 0 25 2 0 0 0 31 36 2 0 0 6 0 37 2 0 0
                                    0 6 38 2 0 0 48 0 1 2 0 0 31 0 34 2 0 0 0 0
                                    28 2 0 0 45 0 1)))))
           '|lookupComplete|)) 
