
(SDEFUN |SORD;Zero;$;1| (($ ($))) (|spadConstant| $ 7)) 

(SDEFUN |SORD;One;$;2| (($ ($))) (|spadConstant| $ 9)) 

(SDEFUN |SORD;omega;$;3| (($ ($)))
        (SPADCALL 1 (|spadConstant| $ 10) (QREFELT $ 12))) 

(SDEFUN |SORD;omegapower;2$;4| ((|p| ($)) ($ ($)))
        (SPADCALL 1 |p| (QREFELT $ 12))) 

(SDEFUN |SORD;zero?;$B;5| ((|p| ($)) ($ (|Boolean|)))
        (SPADCALL |p| (QREFELT $ 16))) 

(SDEFUN |SORD;one?;$B;6| ((|p| ($)) ($ (|Boolean|)))
        (SPADCALL |p| (|spadConstant| $ 10) (QREFELT $ 18))) 

(SDEFUN |SORD;=;2$B;7| ((|p1| ($)) (|p2| ($)) ($ (|Boolean|)))
        (SPADCALL |p1| |p2| (QREFELT $ 18))) 

(SDEFUN |SORD;hashUpdate!;Hs$Hs;8| ((|hs| #1=(|HashState|)) (|p| ($)) ($ #1#))
        (COND ((SPADCALL |p| (QREFELT $ 17)) (HASHSTATEUPDATE |hs| 6672))
              ('T (SPADCALL |hs| |p| (QREFELT $ 22))))) 

(SDEFUN |SORD;coerce;Nni$;9| ((|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |n| (|spadConstant| $ 8) (QREFELT $ 12))) 

(SDEFUN |SORD;retractIfCan;$U;10|
        ((|x| ($)) ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPADCALL |x| (QREFELT $ 26))) 

(SDEFUN |SORD;<;2$B;11| ((|o1| ($)) (|o2| ($)) ($ (|Boolean|)))
        (SPROG ((|p2| (|Rep|)) (|p1| (|Rep|)))
               (SEQ (LETT |p1| |o1|) (LETT |p2| |o2|)
                    (EXIT
                     (COND
                      ((SPADCALL |p1| (QREFELT $ 28))
                       (COND
                        ((SPADCALL |p2| (QREFELT $ 28))
                         (< (SPADCALL |p1| (QREFELT $ 29))
                            (SPADCALL |p2| (QREFELT $ 29))))
                        (#1='T 'T)))
                      ((SPADCALL |p2| (QREFELT $ 28)) NIL)
                      (#1# (SPADCALL |p1| |p2| (QREFELT $ 30)))))))) 

(SDEFUN |SORD;+;3$;12| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPADCALL |p1| |p2| (QREFELT $ 32))) 

(SDEFUN |SORD;*;3$;13| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPADCALL |p1| |p2| (QREFELT $ 34))) 

(SDEFUN |SORD;subtractIfCan;2$U;14|
        ((|o1| ($)) (|o2| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |o1| |o2| (QREFELT $ 37))) 

(SDEFUN |SORD;ordinalAdd;3$;15| ((|o1| ($)) (|o2| ($)) ($ ($)))
        (SPROG
         ((|p2| (|Rep|)) (#1=#:G742 NIL) (|t| NIL) (|p1| (|Rep|))
          (|lt| (|List| |Rep|)) (|e| ($)))
         (SEQ (LETT |p1| |o1|) (LETT |p2| |o2|)
              (LETT |e| (SPADCALL |p2| (QREFELT $ 39)))
              (EXIT
               (COND
                ((SPADCALL |e| (|spadConstant| $ 8) (QREFELT $ 20))
                 (SPADCALL |p1| |p2| (QREFELT $ 33)))
                ('T
                 (SEQ (LETT |lt| NIL)
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL (SPADCALL |p1| (QREFELT $ 39)) |e|
                                        (QREFELT $ 40)))
                             (GO G191)))
                           (SEQ
                            (LETT |lt|
                                  (CONS (SPADCALL |p1| (QREFELT $ 41)) |lt|))
                            (EXIT (LETT |p1| (SPADCALL |p1| (QREFELT $ 42)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |p2| (SPADCALL |t| |p2| (QREFELT $ 33)))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |p2|)))))))) 

(SDEFUN |SORD;integerPart;$Nni;16| ((|o| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|p| (|Rep|)))
               (SEQ (LETT |p| |o|)
                    (SEQ G190
                         (COND
                          ((NULL (NOT (SPADCALL |p| (QREFELT $ 28))))
                           (GO G191)))
                         (SEQ (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 42)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |p| (QREFELT $ 29)))))) 

(SDEFUN |SORD;limitPart;2$;17| ((|o| ($)) ($ ($)))
        (SPROG ((#1=#:G748 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL |o|
                                   (SPADCALL (SPADCALL |o| (QREFELT $ 44))
                                             (QREFELT $ 24))
                                   (QREFELT $ 38)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) $ (|Union| $ "failed") #1#)))) 

(SDEFUN |SORD;ordinalMul;3$;18| ((|o1| ($)) (|o2| ($)) ($ ($)))
        (SPROG ((|lo| ($)) (|hi| ($)) (|e| ($)))
               (SEQ (LETT |e| (SPADCALL |o1| (QREFELT $ 39)))
                    (LETT |hi|
                          (COND
                           ((SPADCALL |e| (|spadConstant| $ 8) (QREFELT $ 46))
                            (SPADCALL
                             (CONS #'|SORD;ordinalMul;3$;18!0| (VECTOR $ |e|))
                             (SPADCALL |o2| (QREFELT $ 45)) (QREFELT $ 48)))
                           ('T (SPADCALL |o2| (QREFELT $ 45)))))
                    (LETT |lo|
                          (SPADCALL |o1| (SPADCALL |o2| (QREFELT $ 44))
                                    (QREFELT $ 49)))
                    (EXIT (SPADCALL |hi| |lo| (QREFELT $ 33)))))) 

(SDEFUN |SORD;ordinalMul;3$;18!0| ((|x| NIL) ($$ NIL))
        (PROG (|e| $)
          (LETT |e| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |x| (QREFELT $ 43)))))) 

(SDEFUN |SORD;sub_one| ((|o| ($)) ($ ($)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |o| (QREFELT $ 28))
                  (SEQ (LETT |n| (SPADCALL |o| (QREFELT $ 29)))
                       (EXIT
                        (COND
                         ((EQL |n| 0)
                          (|error| "sub_one applied to zero ordinal"))
                         (#1='T (SPADCALL (- |n| 1) (QREFELT $ 24)))))))
                 (#1# |o|))))) 

(SDEFUN |SORD;infinite_power| ((|o1| ($)) (|o2| ($)) ($ ($)))
        (SPROG ((|e1| ($)))
               (SEQ
                (COND
                 ((SPADCALL |o1| (|spadConstant| $ 8) (QREFELT $ 20))
                  (|spadConstant| $ 8))
                 ((SPADCALL |o1| (|spadConstant| $ 10) (QREFELT $ 20))
                  (|spadConstant| $ 10))
                 (#1='T
                  (SEQ (LETT |e1| (SPADCALL |o1| (QREFELT $ 39)))
                       (EXIT
                        (COND
                         ((SPADCALL |e1| (|spadConstant| $ 8) (QREFELT $ 46))
                          (SPADCALL (SPADCALL |e1| |o2| (QREFELT $ 50))
                                    (QREFELT $ 14)))
                         (#1#
                          (SPADCALL
                           (SPADCALL (CONS (|function| |SORD;sub_one|) $) |o2|
                                     (QREFELT $ 48))
                           (QREFELT $ 14))))))))))) 

(SDEFUN |SORD;finite_ordinal_power|
        ((|o| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|n1| (|NonNegativeInteger|)) (|e| ($)))
               (SEQ
                (COND ((EQL |n| 0) (|spadConstant| $ 10)) ((EQL |n| 1) |o|)
                      (#1='T
                       (SEQ (LETT |e| (SPADCALL |o| (QREFELT $ 39)))
                            (EXIT
                             (COND
                              ((SPADCALL |e| (|spadConstant| $ 8)
                                         (QREFELT $ 20))
                               (SPADCALL
                                (EXPT (SPADCALL |o| (QREFELT $ 51)) |n|)
                                (QREFELT $ 24)))
                              (#1#
                               (SEQ (LETT |n1| (- |n| 1))
                                    (EXIT
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |e| |n1| (QREFELT $ 49))
                                       (QREFELT $ 14))
                                      |o| (QREFELT $ 50))))))))))))) 

(SDEFUN |SORD;ordinalPower;3$;22| ((|o1| ($)) (|o2| ($)) ($ ($)))
        (SPADCALL (|SORD;infinite_power| |o1| (SPADCALL |o2| (QREFELT $ 45)) $)
                  (|SORD;finite_ordinal_power| |o1|
                   (SPADCALL |o2| (QREFELT $ 44)) $)
                  (QREFELT $ 50))) 

(SDEFUN |SORD;^;3$;23| ((|o1| ($)) (|o2| ($)) ($ ($)))
        (SPADCALL (|SORD;infinite_power| |o1| (SPADCALL |o2| (QREFELT $ 45)) $)
                  (SPADCALL |o1| (SPADCALL |o2| (QREFELT $ 44)) (QREFELT $ 53))
                  (QREFELT $ 35))) 

(SDEFUN |SORD;coerce;$Of;24| ((|o| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|l1| #1=(|OutputForm|))
          (|mon| #2=(|OutputForm|)) (|co| #1#) (|p| (|Rep|)) (|e| ($))
          (|c| (|NonNegativeInteger|)) (|v| #2#))
         (SEQ (LETT |p| |o|)
              (EXIT
               (COND
                ((SPADCALL |p| (QREFELT $ 28))
                 (SPADCALL (SPADCALL |p| (QREFELT $ 29)) (QREFELT $ 56)))
                ('T
                 (SEQ (LETT |l| NIL)
                      (LETT |v| (SPADCALL "omega" (QREFELT $ 58)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL |p| (|spadConstant| $ 7)
                                        (QREFELT $ 59)))
                             (GO G191)))
                           (SEQ (LETT |c| (SPADCALL |p| (QREFELT $ 60)))
                                (LETT |e| (SPADCALL |p| (QREFELT $ 39)))
                                (LETT |p| (SPADCALL |p| (QREFELT $ 42)))
                                (LETT |co| (SPADCALL |c| (QREFELT $ 56)))
                                (LETT |l1|
                                      (COND
                                       ((SPADCALL |e| (|spadConstant| $ 8)
                                                  (QREFELT $ 20))
                                        |co|)
                                       ('T
                                        (SEQ
                                         (COND
                                          ((SPADCALL |e| (|spadConstant| $ 10)
                                                     (QREFELT $ 20))
                                           (LETT |mon| |v|))
                                          ('T
                                           (LETT |mon|
                                                 (SPADCALL |v|
                                                           (SPADCALL |e|
                                                                     (QREFELT $
                                                                              61))
                                                           (QREFELT $ 62)))))
                                         (EXIT
                                          (COND ((EQL |c| 1) |mon|)
                                                ('T
                                                 (SPADCALL |co| |mon|
                                                           (QREFELT $
                                                                    63)))))))))
                                (EXIT (LETT |l| (CONS |l1| |l|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |l| (NREVERSE |l|))
                      (EXIT (SPADCALL (ELT $ 64) |l| (QREFELT $ 67)))))))))) 

(DECLAIM (NOTINLINE |SmallOrdinal;|)) 

(DEFUN |SmallOrdinal| ()
  (SPROG NIL
         (PROG (#1=#:G776)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|SmallOrdinal|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|SmallOrdinal|
                             (LIST (CONS NIL (CONS 1 (|SmallOrdinal;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|SmallOrdinal|)))))))))) 

(DEFUN |SmallOrdinal;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SmallOrdinal|))
          (LETT $ (GETREFV 71))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SmallOrdinal| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|AbelianGroup|)) (|augmentPredVector| $ 1))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|PolynomialRing| (|NonNegativeInteger|) $))
          $))) 

(MAKEPROP '|SmallOrdinal| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (0 . |Zero|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |SORD;Zero;$;1|) $))
              (4 . |One|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |SORD;One;$;2|) $))
              (|NonNegativeInteger|) (8 . |monomial|) |SORD;omega;$;3|
              |SORD;omegapower;2$;4| (|Boolean|) (14 . |zero?|)
              |SORD;zero?;$B;5| (19 . =) |SORD;one?;$B;6| |SORD;=;2$B;7|
              (|HashState|) (25 . |hashUpdate!|) |SORD;hashUpdate!;Hs$Hs;8|
              |SORD;coerce;Nni$;9| (|Union| 11 '"failed") (31 . |retractIfCan|)
              |SORD;retractIfCan;$U;10| (36 . |ground?|) (41 . |ground|)
              (46 . |smaller?|) |SORD;<;2$B;11| (52 . +) |SORD;+;3$;12|
              (58 . *) |SORD;*;3$;13| (|Union| $ '"failed")
              (64 . |subtractIfCan|) |SORD;subtractIfCan;2$U;14|
              (70 . |degree|) (75 . >=) (81 . |leadingMonomial|)
              (86 . |reductum|) |SORD;ordinalAdd;3$;15|
              |SORD;integerPart;$Nni;16| |SORD;limitPart;2$;17| (91 . >)
              (|Mapping| $$ $$) (97 . |mapExponents|) (103 . *)
              |SORD;ordinalMul;3$;18| (109 . |retract|)
              |SORD;ordinalPower;3$;22| (114 . ^) |SORD;^;3$;23| (|OutputForm|)
              (120 . |coerce|) (|String|) (125 . |message|) (130 . ~=)
              (136 . |leadingCoefficient|) |SORD;coerce;$Of;24| (141 . ^)
              (147 . *) (153 . +) (|Mapping| 55 55 55) (|List| 55)
              (159 . |reduce|) (|Integer|) (|PositiveInteger|)
              (|SingleInteger|))
           '#(~= 165 |zero?| 171 |subtractIfCan| 176 |smaller?| 182 |sample|
              188 |rightRecip| 192 |rightPower| 197 |retractIfCan| 209
              |retract| 214 |recip| 219 |ordinalPower| 224 |ordinalMul| 230
              |ordinalAdd| 236 |opposite?| 242 |one?| 248 |omegapower| 253
              |omega| 258 |min| 262 |max| 268 |limitPart| 274 |leftRecip| 279
              |leftPower| 284 |latex| 296 |integerPart| 301 |hashUpdate!| 306
              |hash| 312 |coerce| 317 |antiCommutator| 327 ^ 333 |Zero| 351
              |One| 355 >= 359 > 365 = 371 <= 377 < 383 - 389 + 400 * 406)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0))
            (CONS
             '#(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL |OrderedSet&|
                |AbelianMonoid&| NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                NIL |Magma&| |AbelianSemiGroup&| |RetractableTo&|
                |SetCategory&| NIL |BasicType&| |PartialOrder&| NIL)
             (CONS
              '#((|SemiRing|) (|SemiRng|) (|BiModule| $$ $$) (|RightModule| $$)
                 (|LeftModule| $$) (|OrderedAbelianMonoid|)
                 (|OrderedAbelianSemiGroup|) (|CancellationAbelianMonoid|)
                 (|Monoid|) (|NonAssociativeSemiRing|) (|OrderedSet|)
                 (|AbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|Comparable|) (|Magma|)
                 (|AbelianSemiGroup|) (|RetractableTo| 11) (|SetCategory|)
                 (|CoercibleFrom| 11) (|BasicType|) (|PartialOrder|)
                 (|CoercibleTo| 55))
              (|makeByteWordVec2| 70
                                  '(0 6 0 7 0 6 0 9 2 6 0 11 2 12 1 6 15 0 16 2
                                    6 15 0 0 18 2 6 21 21 0 22 1 6 25 0 26 1 6
                                    15 0 28 1 6 11 0 29 2 6 15 0 0 30 2 6 0 0 0
                                    32 2 6 0 0 0 34 2 6 36 0 0 37 1 6 2 0 39 2
                                    0 15 0 0 40 1 6 0 0 41 1 6 0 0 42 2 0 15 0
                                    0 46 2 6 0 47 0 48 2 6 0 0 11 49 1 0 11 0
                                    51 2 0 0 0 11 53 1 11 55 0 56 1 55 0 57 58
                                    2 0 15 0 0 59 1 6 11 0 60 2 55 0 0 0 62 2
                                    55 0 0 0 63 2 55 0 0 0 64 2 66 55 65 0 67 2
                                    0 15 0 0 59 1 0 15 0 17 2 0 36 0 0 38 2 0
                                    15 0 0 1 0 0 0 1 1 0 36 0 1 2 0 0 0 69 1 2
                                    0 0 0 11 1 1 0 25 0 27 1 0 11 0 51 1 0 36 0
                                    1 2 0 0 0 0 52 2 0 0 0 0 50 2 0 0 0 0 43 2
                                    0 15 0 0 1 1 0 15 0 19 1 0 0 0 14 0 0 0 13
                                    2 0 0 0 0 1 2 0 0 0 0 1 1 0 0 0 45 1 0 36 0
                                    1 2 0 0 0 69 1 2 0 0 0 11 1 1 0 57 0 1 1 0
                                    11 0 44 2 0 21 21 0 23 1 0 70 0 1 1 0 0 11
                                    24 1 0 55 0 61 2 0 0 0 0 1 2 0 0 0 0 54 2 0
                                    0 0 69 1 2 0 0 0 11 53 0 0 0 8 0 0 0 10 2 0
                                    15 0 0 40 2 0 15 0 0 46 2 0 15 0 0 20 2 0
                                    15 0 0 1 2 0 15 0 0 31 2 1 0 0 0 1 1 1 0 0
                                    1 2 0 0 0 0 33 2 1 0 68 0 1 2 0 0 0 0 35 2
                                    0 0 11 0 1 2 0 0 69 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|SmallOrdinal| 'NILADIC T) 
