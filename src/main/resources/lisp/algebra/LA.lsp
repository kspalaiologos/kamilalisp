
(SDEFUN |LA;One;$;1| (($ ($)))
        (SPADCALL (|spadConstant| $ 8) (|spadConstant| $ 9) (QREFELT $ 10))) 

(SDEFUN |LA;*;3$;2| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (SPADCALL |y| (QREFELT $ 12))
                   (QREFELT $ 13))
         (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (SPADCALL |y| (QREFELT $ 14))
                   (QREFELT $ 15))
         (QREFELT $ 10))) 

(SDEFUN |LA;characteristic;Nni;3| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 18))) 

(DECLAIM (NOTINLINE |LocalAlgebra;|)) 

(DEFUN |LocalAlgebra| (&REST #1=#:G702)
  (SPROG NIL
         (PROG (#2=#:G703)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LocalAlgebra|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LocalAlgebra;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|LocalAlgebra|)))))))))) 

(DEFUN |LocalAlgebra;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|LocalAlgebra| DV$1 DV$2))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|OrderedRing|))))))
          (|haddProp| |$ConstructorCache| '|LocalAlgebra| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LocalAlgebra| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Localize| 6 7) (|local| |#1|)
              (|local| |#2|) (0 . |One|) (4 . |One|) (8 . /)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |LA;One;$;1|) $))
              (14 . |numer|) (19 . *) (25 . |denom|) (30 . *) |LA;*;3$;2|
              (|NonNegativeInteger|) (36 . |characteristic|)
              |LA;characteristic;Nni;3| (|Integer|) (|Boolean|)
              (|Union| $ '"failed") (|PositiveInteger|) (|HashState|)
              (|String|) (|OutputForm|) (|SingleInteger|))
           '#(~= 40 |zero?| 46 |subtractIfCan| 51 |smaller?| 57 |sign| 63
              |sample| 68 |rightRecip| 72 |rightPower| 77 |recip| 89
              |positive?| 94 |opposite?| 99 |one?| 105 |numer| 110 |negative?|
              115 |min| 120 |max| 126 |leftRecip| 132 |leftPower| 137 |latex|
              149 |hashUpdate!| 154 |hash| 160 |denom| 165 |commutator| 170
              |coerce| 176 |characteristic| 191 |associator| 195
              |antiCommutator| 202 |annihilate?| 208 |abs| 214 ^ 219 |Zero| 231
              |One| 235 >= 239 > 245 = 251 <= 257 < 263 / 269 - 281 + 292 *
              298)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(1 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 1 0 0 0
                                  1 0 0 0 0 1 0 0 1 0 0 0 0 1))
            (CONS
             '#(|OrderedRing&| |Algebra&| NIL NIL |Rng&| NIL |Module&| NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&| NIL
                NIL NIL |AbelianGroup&| NIL NIL NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |OrderedSet&| |Magma&| |AbelianSemiGroup&| NIL |SetCategory&|
                NIL |BasicType&| NIL |PartialOrder&|)
             (CONS
              '#((|OrderedRing|) (|Algebra| 7) (|CharacteristicZero|) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 7) (|SemiRng|) (|BiModule| 7 7)
                 (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|OrderedAbelianGroup|) (|RightModule| 7) (|LeftModule| 7)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| $$)
                 (|OrderedCancellationAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|OrderedAbelianSemiGroup|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|OrderedSet|) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|SetCategory|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 26)
                 (|PartialOrder|))
              (|makeByteWordVec2| 27
                                  '(0 6 0 8 0 7 0 9 2 0 0 6 7 10 1 0 6 0 12 2 6
                                    0 0 0 13 1 0 7 0 14 2 7 0 0 0 15 0 6 17 18
                                    2 0 21 0 0 1 1 0 21 0 1 2 0 22 0 0 1 2 1 21
                                    0 0 1 1 1 20 0 1 0 0 0 1 1 0 22 0 1 2 0 0 0
                                    17 1 2 0 0 0 23 1 1 0 22 0 1 1 1 21 0 1 2 0
                                    21 0 0 1 1 0 21 0 1 1 0 6 0 12 1 1 21 0 1 2
                                    1 0 0 0 1 2 1 0 0 0 1 1 0 22 0 1 2 0 0 0 17
                                    1 2 0 0 0 23 1 1 0 25 0 1 2 0 24 24 0 1 1 0
                                    27 0 1 1 0 7 0 14 2 0 0 0 0 1 1 0 0 7 1 1 0
                                    0 20 1 1 0 26 0 1 0 0 17 19 3 0 0 0 0 0 1 2
                                    0 0 0 0 1 2 0 21 0 0 1 1 1 0 0 1 2 0 0 0 17
                                    1 2 0 0 0 23 1 0 0 0 1 0 0 0 11 2 1 21 0 0
                                    1 2 1 21 0 0 1 2 0 21 0 0 1 2 1 21 0 0 1 2
                                    1 21 0 0 1 2 0 0 6 7 10 2 0 0 0 7 1 2 0 0 0
                                    0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 7 0 1 2 0 0
                                    0 7 1 2 0 0 17 0 1 2 0 0 20 0 1 2 0 0 0 0
                                    16 2 0 0 23 0 1)))))
           '|lookupComplete|)) 
