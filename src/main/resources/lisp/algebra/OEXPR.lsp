
(PUT '|OEXPR;retract;E$;1| '|SPADreplace| '(XLAM (|e|) |e|)) 

(SDEFUN |OEXPR;retract;E$;1| ((|e| (|Expression| (|Integer|))) ($ ($))) |e|) 

(PUT '|OEXPR;coerce;$E;2| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |OEXPR;coerce;$E;2| ((|x| ($)) ($ (|Expression| (|Integer|)))) |x|) 

(SDEFUN |OEXPR;retractIfCan;EU;3|
        ((|x| (|Expression| (|Integer|))) ($ (|Union| $ "failed")))
        (CONS 0 (SPADCALL |x| (QREFELT $ 7)))) 

(SDEFUN |OEXPR;<;2$B;4| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|s| (|Union| (|Integer|) "failed")) (|di| ($)))
               (SEQ (LETT |di| (SPADCALL |y| |x| (QREFELT $ 11)))
                    (EXIT
                     (COND
                      ((SPADCALL |di| (|spadConstant| $ 12) (QREFELT $ 15))
                       NIL)
                      (#1='T
                       (SEQ (LETT |s| (SPADCALL |di| (QREFELT $ 18)))
                            (EXIT
                             (COND ((QEQCAR |s| 0) (EQL (QCDR |s|) 1))
                                   (#1#
                                    (|error| "can not determine sign"))))))))))) 

(DECLAIM (NOTINLINE |OrderedExpression;|)) 

(DEFUN |OrderedExpression| ()
  (SPROG NIL
         (PROG (#1=#:G719)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OrderedExpression|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OrderedExpression|
                             (LIST
                              (CONS NIL (CONS 1 (|OrderedExpression;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OrderedExpression|)))))))))) 

(DEFUN |OrderedExpression;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OrderedExpression|))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrderedExpression| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|Expression| (|Integer|)))
          $))) 

(MAKEPROP '|OrderedExpression| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Expression| 21) '|Rep| |OEXPR;retract;E$;1|
              |OEXPR;coerce;$E;2| (|Union| $ '"failed")
              |OEXPR;retractIfCan;EU;3| (0 . -) (6 . |Zero|) (10 . |Zero|)
              (|Boolean|) (14 . =) (|Union| 21 '"failed")
              (|ElementaryFunctionSign| 21 5) (20 . |sign|) |OEXPR;<;2$B;4|
              (|Fraction| 21) (|Integer|) (|PositiveInteger|)
              (|NonNegativeInteger|) (|HashState|) (|String|) (|OutputForm|)
              (|SingleInteger|))
           '#(~= 25 |zero?| 31 |subtractIfCan| 36 |smaller?| 42 |sign| 48
              |sample| 53 |rightRecip| 57 |rightPower| 62 |retractIfCan| 74
              |retract| 79 |recip| 84 |positive?| 89 |opposite?| 94 |one?| 100
              |negative?| 105 |min| 110 |max| 116 |leftRecip| 122 |leftPower|
              127 |latex| 139 |hashUpdate!| 144 |hash| 150 |commutator| 155
              |coerce| 161 |characteristic| 181 |associator| 185
              |antiCommutator| 192 |annihilate?| 198 |abs| 204 ^ 209 |Zero| 221
              |One| 225 >= 229 > 235 = 241 <= 247 < 253 - 259 + 270 * 276)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|OrderedRing&| |Algebra&| NIL NIL |Rng&| NIL |Module&| NIL NIL
                NIL |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&|
                NIL NIL NIL |AbelianGroup&| NIL NIL NIL NIL |OrderedSet&| NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&| NIL
                |Magma&| |AbelianSemiGroup&| |RetractableFrom&| |SetCategory&|
                NIL NIL |BasicType&| |PartialOrder&| NIL)
             (CONS
              '#((|OrderedRing|) (|Algebra| 20) (|CharacteristicZero|) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 20) (|SemiRng|)
                 (|OrderedAbelianGroup|) (|BiModule| 20 20)
                 (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|OrderedCancellationAbelianMonoid|) (|RightModule| 20)
                 (|LeftModule| 20) (|NonAssociativeRng|) (|RightModule| $$)
                 (|LeftModule| $$) (|OrderedAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianSemiGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedSet|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Comparable|)
                 (|Magma|) (|AbelianSemiGroup|) (|RetractableFrom| 5)
                 (|SetCategory|) (|CoercibleTo| 5) (|unitsKnown|) (|BasicType|)
                 (|PartialOrder|) (|CoercibleTo| 26))
              (|makeByteWordVec2| 27
                                  '(2 0 0 0 0 11 0 0 0 12 0 6 0 13 2 0 14 0 0
                                    15 1 17 16 5 18 2 0 14 0 0 1 1 0 14 0 1 2 0
                                    9 0 0 1 2 0 14 0 0 1 1 0 21 0 1 0 0 0 1 1 0
                                    9 0 1 2 0 0 0 22 1 2 0 0 0 23 1 1 0 9 5 10
                                    1 0 0 5 7 1 0 9 0 1 1 0 14 0 1 2 0 14 0 0 1
                                    1 0 14 0 1 1 0 14 0 1 2 0 0 0 0 1 2 0 0 0 0
                                    1 1 0 9 0 1 2 0 0 0 22 1 2 0 0 0 23 1 1 0
                                    25 0 1 2 0 24 24 0 1 1 0 27 0 1 2 0 0 0 0 1
                                    1 0 5 0 8 1 0 0 20 1 1 0 0 21 1 1 0 26 0 1
                                    0 0 23 1 3 0 0 0 0 0 1 2 0 0 0 0 1 2 0 14 0
                                    0 1 1 0 0 0 1 2 0 0 0 22 1 2 0 0 0 23 1 0 0
                                    0 12 0 0 0 1 2 0 14 0 0 1 2 0 14 0 0 1 2 0
                                    14 0 0 15 2 0 14 0 0 1 2 0 14 0 0 19 1 0 0
                                    0 1 2 0 0 0 0 11 2 0 0 0 0 1 2 0 0 0 20 1 2
                                    0 0 20 0 1 2 0 0 0 0 1 2 0 0 21 0 1 2 0 0
                                    23 0 1 2 0 0 22 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|OrderedExpression| 'NILADIC T) 
