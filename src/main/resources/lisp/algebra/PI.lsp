
(SETQ |$CategoryFrame|
        (|put| #1='|PositiveInteger| '|SuperDomain| #2='(|NonNegativeInteger|)
               (|put| #2# #3='|SubDomain|
                      (CONS '(|PositiveInteger| > |#1| 0)
                            (DELASC #1# (|get| #2# #3# |$CategoryFrame|)))
                      |$CategoryFrame|))) 

(PUT '|PI;qcoerce;I$;1| '|SPADreplace| '(XLAM (|n|) |n|)) 

(SDEFUN |PI;qcoerce;I$;1| ((|n| (|Integer|)) ($ ($))) |n|) 

(DECLAIM (NOTINLINE |PositiveInteger;|)) 

(DEFUN |PositiveInteger| ()
  (SPROG NIL
         (PROG (#1=#:G2551)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PositiveInteger|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PositiveInteger|
                             (LIST (CONS NIL (CONS 1 (|PositiveInteger;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|PositiveInteger|)))))))))) 

(DEFUN |PositiveInteger;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PositiveInteger|))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PositiveInteger| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PositiveInteger| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|NonNegativeInteger|) (|Integer|)
              |PI;qcoerce;I$;1| (|InputForm|) (|PositiveInteger|) (|Boolean|)
              (|Union| $ '"failed") (|HashState|) (|String|) (|OutputForm|)
              (|SingleInteger|))
           '#(~= 0 |smaller?| 6 |sample| 12 |rightRecip| 16 |rightPower| 21
              |recip| 33 |qcoerce| 38 |one?| 43 |min| 48 |max| 54 |leftRecip|
              60 |leftPower| 65 |latex| 77 |hashUpdate!| 82 |hash| 88 |gcd| 93
              |convert| 99 |coerce| 104 ^ 109 |One| 121 >= 125 > 131 = 137 <=
              143 < 149 + 155 * 161)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL NIL NIL NIL |MagmaWithUnit&| NIL |OrderedSet&|
                     |Magma&| NIL |AbelianSemiGroup&| NIL |SetCategory&| NIL
                     NIL |BasicType&| |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedMonoid|) (|OrderedAbelianSemiGroup|) (|Monoid|)
                      (|OrderedSemiGroup|) (|MagmaWithUnit|) (|SemiGroup|)
                      (|OrderedSet|) (|Magma|) (|Comparable|)
                      (|AbelianSemiGroup|) (|CommutativeStar|) (|SetCategory|)
                      (|ConvertibleTo| 8) (|TwoSidedRecip|) (|BasicType|)
                      (|PartialOrder|) (|CoercibleTo| 14))
                   (|makeByteWordVec2| 15
                                       '(2 0 10 0 0 1 2 0 10 0 0 1 0 0 0 1 1 0
                                         11 0 1 2 0 0 0 9 1 2 0 0 0 5 1 1 0 11
                                         0 1 1 0 0 6 7 1 0 10 0 1 2 0 0 0 0 1 2
                                         0 0 0 0 1 1 0 11 0 1 2 0 0 0 9 1 2 0 0
                                         0 5 1 1 0 13 0 1 2 0 12 12 0 1 1 0 15
                                         0 1 2 0 0 0 0 1 1 0 8 0 1 1 0 14 0 1 2
                                         0 0 0 9 1 2 0 0 0 5 1 0 0 0 1 2 0 10 0
                                         0 1 2 0 10 0 0 1 2 0 10 0 0 1 2 0 10 0
                                         0 1 2 0 10 0 0 1 2 0 0 0 0 1 2 0 0 0 0
                                         1 2 0 0 9 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|PositiveInteger| 'NILADIC T) 
