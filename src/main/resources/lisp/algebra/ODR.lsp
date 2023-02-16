
(PUT '|ODR;coerce;R$;1| '|SPADreplace| '(XLAM (|u|) |u|)) 

(SDEFUN |ODR;coerce;R$;1| ((|u| (R)) ($ ($))) |u|) 

(PUT '|ODR;coerce;$R;2| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |ODR;coerce;$R;2| ((|p| ($)) ($ (R))) |p|) 

(SDEFUN |ODR;differentiate;2$;3| ((|p| ($)) ($ ($)))
        (SPADCALL |p| (QREFELT $ 8) (QREFELT $ 12))) 

(SDEFUN |ODR;/;3$;4| ((|p| ($)) (|q| ($)) ($ ($)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 11)) (SPADCALL |q| (QREFELT $ 11))
                  (QREFELT $ 14))) 

(SDEFUN |ODR;^;$I$;5| ((|p| ($)) (|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 11)) |n| (QREFELT $ 17))) 

(SDEFUN |ODR;inv;2$;6| ((|p| ($)) ($ ($)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 11)) (QREFELT $ 19))) 

(DECLAIM (NOTINLINE |OrdinaryDifferentialRing;|)) 

(DEFUN |OrdinaryDifferentialRing| (&REST #1=#:G735)
  (SPROG NIL
         (PROG (#2=#:G736)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|OrdinaryDifferentialRing|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |OrdinaryDifferentialRing;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|OrdinaryDifferentialRing|)))))))))) 

(DEFUN |OrdinaryDifferentialRing;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 |#3|)
          (LETT |dv$| (LIST '|OrdinaryDifferentialRing| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache| '|OrdinaryDifferentialRing|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 5 |#2|)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 |#2|)
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 15 (CONS (|dispatchFunction| |ODR;/;3$;4|) $))
             (QSETREFV $ 18 (CONS (|dispatchFunction| |ODR;^;$I$;5|) $))
             (QSETREFV $ 20 (CONS (|dispatchFunction| |ODR;inv;2$;6|) $)))))
          $))) 

(MAKEPROP '|OrdinaryDifferentialRing| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|local| |#2|) (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|Rep| |ODR;coerce;R$;1| |ODR;coerce;$R;2|
              (0 . |differentiate|) |ODR;differentiate;2$;3| (6 . /) (12 . /)
              (|Integer|) (18 . ^) (24 . ^) (30 . |inv|) (35 . |inv|)
              (|Fraction| 16) (|Boolean|) (|Factored| $)
              (|Union| 25 '#1="failed") (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 27 '#1#)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|NonNegativeInteger|)
              (|Record| (|:| |coef| 25) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $) (|Union| $ '"failed")
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|)
              (|OutputForm|))
           '#(~= 40 |zero?| 46 |unitNormal| 51 |unitCanonical| 56 |unit?| 61
              |subtractIfCan| 66 |squareFreePart| 72 |squareFree| 77
              |sizeLess?| 82 |sample| 88 |rightRecip| 92 |rightPower| 97 |rem|
              109 |recip| 115 |quo| 120 |principalIdeal| 126 |prime?| 131
              |opposite?| 136 |one?| 142 |multiEuclidean| 147 |leftRecip| 153
              |leftPower| 158 |lcmCoef| 170 |lcm| 176 |latex| 187 |inv| 192
              |hashUpdate!| 197 |hash| 203 |gcdPolynomial| 208 |gcd| 214
              |factor| 225 |extendedEuclidean| 230 |exquo| 243
              |expressIdealMember| 249 |euclideanSize| 255 |divide| 260
              |differentiate| 266 |commutator| 277 |coerce| 283
              |characteristic| 313 |associator| 317 |associates?| 324
              |antiCommutator| 330 |annihilate?| 336 ^ 342 |Zero| 360 |One| 364
              D 368 = 379 / 385 - 391 + 402 * 408)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 0 0 1 1 0 0 1 0
                                  0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1
                                  1))
            (CONS
             '#(|Field&| |EuclideanDomain&| NIL |UniqueFactorizationDomain&|
                |GcdDomain&| NIL NIL NIL |DivisionRing&| |DifferentialRing&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL |Rng&| NIL
                |Module&| |Module&| NIL |NonAssociativeRing&| NIL NIL
                |NonAssociativeRng&| NIL NIL NIL |AbelianGroup&| NIL NIL NIL
                NIL |MagmaWithUnit&| |AbelianMonoid&| |NonAssociativeSemiRng&|
                |Magma&| |AbelianSemiGroup&| |SetCategory&| NIL NIL
                |BasicType&| NIL NIL NIL NIL NIL)
             (CONS
              '#((|Field|) (|EuclideanDomain|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|) (|IntegralDomain|)
                 (|LeftOreRing|) (|CommutativeRing|) (|DivisionRing|)
                 (|DifferentialRing|) (|Algebra| $$) (|EntireRing|)
                 (|Algebra| 21) (|Ring|) (|SemiRing|) (|Rng|) (|SemiRng|)
                 (|Module| $$) (|Module| 21) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|BiModule| 21 21) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| 21)
                 (|RightModule| 21) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|AbelianMonoid|)
                 (|NonAssociativeSemiRng|) (|Magma|) (|AbelianSemiGroup|)
                 (|SetCategory|) (|CommutativeStar|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 40) (|TwoSidedRecip|)
                 (|noZeroDivisors|) (|canonicalUnitNormal|)
                 (|canonicalsClosed|))
              (|makeByteWordVec2| 40
                                  '(2 9 0 0 6 12 2 5 0 0 0 14 2 0 0 0 0 15 2 5
                                    0 0 16 17 2 0 0 0 16 18 1 5 0 0 19 1 0 0 0
                                    20 2 0 22 0 0 1 1 0 22 0 1 1 1 35 0 1 1 1 0
                                    0 1 1 1 22 0 1 2 0 33 0 0 1 1 1 0 0 1 1 1
                                    23 0 1 2 1 22 0 0 1 0 0 0 1 1 0 33 0 1 2 0
                                    0 0 36 1 2 0 0 0 30 1 2 1 0 0 0 1 1 0 33 0
                                    1 2 1 0 0 0 1 1 1 31 25 1 1 1 22 0 1 2 0 22
                                    0 0 1 1 0 22 0 1 2 1 24 25 0 1 1 0 33 0 1 2
                                    0 0 0 36 1 2 0 0 0 30 1 2 1 34 0 0 1 1 1 0
                                    25 1 2 1 0 0 0 1 1 0 37 0 1 1 1 0 0 20 2 0
                                    39 39 0 1 1 0 38 0 1 2 1 32 32 32 1 2 1 0 0
                                    0 1 1 1 0 25 1 1 1 23 0 1 2 1 26 0 0 1 3 1
                                    28 0 0 0 1 2 1 33 0 0 1 2 1 24 25 0 1 1 1
                                    30 0 1 2 1 29 0 0 1 1 0 0 0 13 2 0 0 0 30 1
                                    2 0 0 0 0 1 1 1 0 21 1 1 1 0 0 1 1 0 0 5 10
                                    1 0 5 0 11 1 0 0 16 1 1 0 40 0 1 0 0 30 1 3
                                    0 0 0 0 0 1 2 1 22 0 0 1 2 0 0 0 0 1 2 0 22
                                    0 0 1 2 1 0 0 16 18 2 0 0 0 36 1 2 0 0 0 30
                                    1 0 0 0 1 0 0 0 1 1 0 0 0 1 2 0 0 0 30 1 2
                                    0 22 0 0 1 2 1 0 0 0 15 1 0 0 0 1 2 0 0 0 0
                                    1 2 0 0 0 0 1 2 1 0 0 21 1 2 1 0 21 0 1 2 0
                                    0 16 0 1 2 0 0 30 0 1 2 0 0 0 0 1 2 0 0 36
                                    0 1)))))
           '|lookupComplete|)) 
