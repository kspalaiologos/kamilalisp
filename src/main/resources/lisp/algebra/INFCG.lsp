
(PUT '|INFCG;rep| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |INFCG;rep| ((|x| ($)) ($ (|Rep|))) |x|) 

(PUT '|INFCG;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |INFCG;per| ((|r| (|Rep|)) ($ ($))) |r|) 

(SDEFUN |INFCG;coerce;$Of;3| ((|x| ($)) ($ (|OutputForm|)))
        (COND ((SPADCALL |x| (QREFELT $ 9)) (SPADCALL 1 (QREFELT $ 12)))
              ((EQL (|INFCG;rep| |x| $) 1)
               (SPADCALL (QREFELT $ 6) (QREFELT $ 14)))
              ('T
               (SPADCALL (SPADCALL (QREFELT $ 6) (QREFELT $ 14))
                         (SPADCALL (|INFCG;rep| |x| $) (QREFELT $ 15))
                         (QREFELT $ 16))))) 

(SDEFUN |INFCG;hashUpdate!;Hs$Hs;4| ((|hs| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (HASHSTATEUPDATE |hs| (|INFCG;rep| |s| $))) 

(SDEFUN |INFCG;convert;$Se;5| ((|x| ($)) ($ (|SExpression|)))
        (SPADCALL (|INFCG;rep| |x| $) (QREFELT $ 21))) 

(SDEFUN |INFCG;generator;$;6| (($ ($))) (|INFCG;per| 1 $)) 

(SDEFUN |INFCG;generators;L;7| (($ (|List| $)))
        (LIST (SPADCALL (QREFELT $ 23)))) 

(SDEFUN |INFCG;exponent;$I;8| ((|x| ($)) ($ (|Integer|))) (|INFCG;rep| |x| $)) 

(SDEFUN |INFCG;One;$;9| (($ ($))) (|INFCG;per| 0 $)) 

(SDEFUN |INFCG;one?;$B;10| ((|x| ($)) ($ (|Boolean|)))
        (ZEROP (|INFCG;rep| |x| $))) 

(SDEFUN |INFCG;*;3$;11| ((|x| ($)) (|y| ($)) ($ ($)))
        (|INFCG;per| (+ (|INFCG;rep| |x| $) (|INFCG;rep| |y| $)) $)) 

(SDEFUN |INFCG;inv;2$;12| ((|x| ($)) ($ ($)))
        (|INFCG;per| (- (|INFCG;rep| |x| $)) $)) 

(SDEFUN |INFCG;=;2$B;13| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (EQL (|INFCG;rep| |x| $) (|INFCG;rep| |y| $))) 

(SDEFUN |INFCG;<;2$B;14| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (< (|INFCG;rep| |x| $) (|INFCG;rep| |y| $))) 

(DECLAIM (NOTINLINE |InfiniteCyclicGroup;|)) 

(DEFUN |InfiniteCyclicGroup| (#1=#:G729)
  (SPROG NIL
         (PROG (#2=#:G730)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InfiniteCyclicGroup|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|InfiniteCyclicGroup;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InfiniteCyclicGroup|)))))))))) 

(DEFUN |InfiniteCyclicGroup;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|InfiniteCyclicGroup| DV$1))
          (LETT $ (GETREFV 37))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InfiniteCyclicGroup| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Integer|))
          $))) 

(MAKEPROP '|InfiniteCyclicGroup| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|)
              |INFCG;one?;$B;10| (|OutputForm|) (|Integer|) (0 . |coerce|)
              (|Symbol|) (5 . |coerce|) (10 . |coerce|) (15 . ^)
              |INFCG;coerce;$Of;3| (|HashState|) |INFCG;hashUpdate!;Hs$Hs;4|
              (|SExpression|) (21 . |convert|) |INFCG;convert;$Se;5|
              |INFCG;generator;$;6| (|List| $) |INFCG;generators;L;7|
              |INFCG;exponent;$I;8|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |INFCG;One;$;9|) $))
              |INFCG;*;3$;11| |INFCG;inv;2$;12| |INFCG;=;2$B;13|
              |INFCG;<;2$B;14| (|NonNegativeInteger|) (|Union| $ '"failed")
              (|PositiveInteger|) (|String|) (|SingleInteger|))
           '#(~= 26 |smaller?| 32 |sample| 38 |rightRecip| 42 |rightPower| 47
              |recip| 59 |one?| 64 |min| 69 |max| 75 |leftRecip| 81 |leftPower|
              86 |latex| 98 |inv| 103 |hashUpdate!| 108 |hash| 114 |generators|
              119 |generator| 123 |exponent| 127 |convert| 132 |conjugate| 137
              |commutator| 143 |coerce| 149 ^ 154 |One| 172 >= 176 > 182 = 188
              <= 194 < 200 / 206 * 212)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Group&| NIL NIL NIL NIL |OrderedSet&| |MagmaWithUnit&|
                     NIL |Magma&| NIL |SetCategory&| NIL NIL |PartialOrder&|
                     NIL NIL |BasicType&| NIL)
                  (CONS
                   '#((|Group|) (|OrderedMonoid|) (|Monoid|)
                      (|OrderedSemiGroup|) (|SemiGroup|) (|OrderedSet|)
                      (|MagmaWithUnit|) (|Comparable|) (|Magma|)
                      (|CommutativeStar|) (|SetCategory|) (|ConvertibleTo| 20)
                      (|TwoSidedRecip|) (|PartialOrder|) (|FinitelyGenerated|)
                      (|unitsKnown|) (|BasicType|) (|CoercibleTo| 10))
                   (|makeByteWordVec2| 36
                                       '(1 11 10 0 12 1 13 10 0 14 1 7 10 0 15
                                         2 10 0 0 0 16 1 20 0 11 21 2 0 8 0 0 1
                                         2 0 8 0 0 1 0 0 0 1 1 0 33 0 1 2 0 0 0
                                         32 1 2 0 0 0 34 1 1 0 33 0 1 1 0 8 0 9
                                         2 0 0 0 0 1 2 0 0 0 0 1 1 0 33 0 1 2 0
                                         0 0 32 1 2 0 0 0 34 1 1 0 35 0 1 1 0 0
                                         0 29 2 0 18 18 0 19 1 0 36 0 1 0 0 24
                                         25 0 0 0 23 1 0 11 0 26 1 0 20 0 22 2
                                         0 0 0 0 1 2 0 0 0 0 1 1 0 10 0 17 2 0
                                         0 0 11 1 2 0 0 0 32 1 2 0 0 0 34 1 0 0
                                         0 27 2 0 8 0 0 1 2 0 8 0 0 1 2 0 8 0 0
                                         30 2 0 8 0 0 1 2 0 8 0 0 31 2 0 0 0 0
                                         1 2 0 0 0 0 28)))))
           '|lookupComplete|)) 
