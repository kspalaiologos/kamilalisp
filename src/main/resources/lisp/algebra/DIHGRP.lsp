
(PUT '|DIHGRP;rep| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |DIHGRP;rep| ((|x| ($)) ($ (|Rep|))) |x|) 

(PUT '|DIHGRP;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |DIHGRP;per| ((|r| (|Rep|)) ($ ($))) |r|) 

(SDEFUN |DIHGRP;expa;$Im;3| ((|x| ($)) ($ (|IntegerMod| |n|)))
        (QCAR (|DIHGRP;rep| |x| $))) 

(SDEFUN |DIHGRP;expb;$Im;4| ((|x| ($)) ($ (|IntegerMod| 2)))
        (QCDR (|DIHGRP;rep| |x| $))) 

(SDEFUN |DIHGRP;exponenta;$I;5| ((|x| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 15))) 

(SDEFUN |DIHGRP;exponentb;$I;6| ((|x| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 17))) 

(SDEFUN |DIHGRP;One;$;7| (($ ($)))
        (|DIHGRP;per| (CONS (|spadConstant| $ 19) (|spadConstant| $ 20)) $)) 

(SDEFUN |DIHGRP;one?;$B;8| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 23))
          (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 24)))
         ('T NIL))) 

(SDEFUN |DIHGRP;coerce;$Of;9| ((|y| ($)) ($ (|OutputForm|)))
        (SPROG ((|aout| (|OutputForm|)))
               (SEQ
                (COND
                 ((SPADCALL |y| (QREFELT $ 25)) (SPADCALL 1 (QREFELT $ 27)))
                 ((SPADCALL (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 23))
                  (SPADCALL (QREFELT $ 8) (QREFELT $ 29)))
                 (#1='T
                  (SEQ
                   (COND
                    ((SPADCALL (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 30))
                     (LETT |aout| (SPADCALL (QREFELT $ 7) (QREFELT $ 29))))
                    (#1#
                     (LETT |aout|
                           (SPADCALL (SPADCALL (QREFELT $ 7) (QREFELT $ 29))
                                     (SPADCALL (SPADCALL |y| (QREFELT $ 11))
                                               (QREFELT $ 31))
                                     (QREFELT $ 32)))))
                   (EXIT
                    (COND
                     ((SPADCALL (SPADCALL |y| (QREFELT $ 13)) (QREFELT $ 24))
                      |aout|)
                     (#1#
                      (SPADCALL |aout| (SPADCALL (QREFELT $ 8) (QREFELT $ 29))
                                (QREFELT $ 33))))))))))) 

(SDEFUN |DIHGRP;generators;L;10| (($ (|List| $)))
        (LIST
         (|DIHGRP;per| (CONS (|spadConstant| $ 35) (|spadConstant| $ 20)) $)
         (|DIHGRP;per| (CONS (|spadConstant| $ 19) (|spadConstant| $ 36)) $))) 

(SDEFUN |DIHGRP;*;3$;11| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 24))
          (|DIHGRP;per|
           (CONS
            (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                      (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 39))
            (SPADCALL |y| (QREFELT $ 13)))
           $))
         ('T
          (|DIHGRP;per|
           (CONS
            (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                      (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 40))
            (SPADCALL (SPADCALL |x| (QREFELT $ 13))
                      (SPADCALL |y| (QREFELT $ 13)) (QREFELT $ 41)))
           $)))) 

(SDEFUN |DIHGRP;inv;2$;12| ((|x| ($)) ($ ($)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 24))
          (|DIHGRP;per|
           (CONS (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 43))
                 (|spadConstant| $ 20))
           $))
         ('T |x|))) 

(SDEFUN |DIHGRP;order;$I;13| ((|x| ($)) ($ (|Integer|)))
        (COND ((SPADCALL |x| (QREFELT $ 25)) 0)
              ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 45)) 2)
              ('T
               (QUOTIENT2 (QREFELT $ 6)
                          (GCD
                           (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                     (QREFELT $ 15))
                           (QREFELT $ 6)))))) 

(SDEFUN |DIHGRP;=;2$B;14| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 11))
                    (QREFELT $ 47))
          (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (SPADCALL |y| (QREFELT $ 13))
                    (QREFELT $ 48)))
         ('T NIL))) 

(SDEFUN |DIHGRP;smaller?;2$B;15| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((< (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 17))
             (SPADCALL (SPADCALL |y| (QREFELT $ 13)) (QREFELT $ 17)))
          'T)
         ('T
          (NULL
           (OR
            (> (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 17))
               (SPADCALL (SPADCALL |y| (QREFELT $ 13)) (QREFELT $ 17)))
            (NULL
             (< (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 15))
                (SPADCALL (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 15))))))))) 

(SDEFUN |DIHGRP;size;Nni;16| (($ (|NonNegativeInteger|))) (* 2 (QREFELT $ 6))) 

(SDEFUN |DIHGRP;index;Pi$;17| ((|i| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|imodn| (|IntegerMod| |n|)))
               (SEQ
                (COND ((> |i| (* 2 (QREFELT $ 6))) (|error| "out of range"))
                      (#1='T
                       (SEQ (LETT |imodn| (SPADCALL (- |i| 1) (QREFELT $ 53)))
                            (EXIT
                             (COND
                              ((> |i| (QREFELT $ 6))
                               (|DIHGRP;per|
                                (CONS |imodn| (|spadConstant| $ 36)) $))
                              (#1#
                               (|DIHGRP;per|
                                (CONS |imodn| (|spadConstant| $ 20)) $)))))))))) 

(SDEFUN |DIHGRP;lookup;$Pi;18| ((|x| ($)) ($ (|PositiveInteger|)))
        (SPROG ((|xa| (|PositiveInteger|)))
               (LETT |xa|
                     (+
                      (+
                       (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 15))
                       1)
                      (* (QREFELT $ 6)
                         (SPADCALL (SPADCALL |x| (QREFELT $ 13))
                                   (QREFELT $ 17))))))) 

(SDEFUN |DIHGRP;enumerate;L;19| (($ (|List| $)))
        (SPROG
         ((#1=#:G785 NIL) (|k| NIL) (#2=#:G784 NIL) (#3=#:G783 NIL)
          (#4=#:G782 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |k| 0) (LETT #3# (- (QREFELT $ 6) 1)) G190
                 (COND ((|greater_SI| |k| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (|DIHGRP;per|
                           (CONS (SPADCALL |k| (QREFELT $ 53))
                                 (|spadConstant| $ 20))
                           $)
                          #4#))))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                 (EXIT (NREVERSE #4#))))
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |k| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                 (COND ((|greater_SI| |k| #1#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (|DIHGRP;per|
                           (CONS (SPADCALL |k| (QREFELT $ 53))
                                 (|spadConstant| $ 36))
                           $)
                          #2#))))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                 (EXIT (NREVERSE #2#))))
           (QREFELT $ 58))))) 

(DECLAIM (NOTINLINE |DihedralGroup;|)) 

(DEFUN |DihedralGroup| (&REST #1=#:G789)
  (SPROG NIL
         (PROG (#2=#:G790)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL NIL))
                     (HGET |$ConstructorCache| '|DihedralGroup|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DihedralGroup;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|DihedralGroup|)))))))))) 

(DEFUN |DihedralGroup;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 |#2|)
          (LETT DV$3 |#3|)
          (LETT |dv$| (LIST '|DihedralGroup| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 65))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DihedralGroup|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (|Record| (|:| |expa| (|IntegerMod| |#1|))
                              (|:| |expb| (|IntegerMod| 2))))
          $))) 

(MAKEPROP '|DihedralGroup| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|Rep| (|IntegerMod| (NRTEVAL (QREFELT $ 6)))
              |DIHGRP;expa;$Im;3| (|IntegerMod| '2) |DIHGRP;expb;$Im;4|
              (|Integer|) (0 . |convert|) |DIHGRP;exponenta;$I;5|
              (5 . |convert|) |DIHGRP;exponentb;$I;6| (10 . |Zero|)
              (14 . |Zero|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |DIHGRP;One;$;7|) $))
              (|Boolean|) (18 . |zero?|) (23 . |zero?|) |DIHGRP;one?;$B;8|
              (|OutputForm|) (28 . |coerce|) (|Symbol|) (33 . |coerce|)
              (38 . |one?|) (43 . |coerce|) (48 . ^) (54 . *)
              |DIHGRP;coerce;$Of;9| (60 . |One|) (64 . |One|) (|List| $)
              |DIHGRP;generators;L;10| (68 . +) (74 . -) (80 . +)
              |DIHGRP;*;3$;11| (86 . -) |DIHGRP;inv;2$;12| (91 . |one?|)
              |DIHGRP;order;$I;13| (96 . =) (102 . =) |DIHGRP;=;2$B;14|
              |DIHGRP;smaller?;2$B;15| (|NonNegativeInteger|)
              |DIHGRP;size;Nni;16| (108 . |coerce|) (|PositiveInteger|)
              |DIHGRP;index;Pi$;17| |DIHGRP;lookup;$Pi;18| (|List| $$)
              (113 . |concat|) |DIHGRP;enumerate;L;19| (|InputForm|)
              (|Union| $ '"failed") (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 119 |smaller?| 125 |size| 131 |sample| 135 |rightRecip| 139
              |rightPower| 144 |recip| 156 |random| 161 |order| 165 |one?| 170
              |lookup| 175 |leftRecip| 180 |leftPower| 185 |latex| 197 |inv|
              202 |index| 207 |hashUpdate!| 212 |hash| 218 |generators| 223
              |exponentb| 227 |exponenta| 232 |expb| 237 |expa| 242 |enumerate|
              247 |convert| 251 |conjugate| 256 |commutator| 262 |coerce| 268 ^
              273 |One| 291 = 295 / 301 * 307)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|FiniteGroup&| |Group&| NIL NIL |Finite&| |MagmaWithUnit&|
                     NIL |Magma&| |SetCategory&| NIL NIL NIL NIL |BasicType&|
                     NIL)
                  (CONS
                   '#((|FiniteGroup|) (|Group|) (|Monoid|) (|SemiGroup|)
                      (|Finite|) (|MagmaWithUnit|) (|Comparable|) (|Magma|)
                      (|SetCategory|) (|FinitelyGenerated|)
                      (|ConvertibleTo| 60) (|unitsKnown|) (|TwoSidedRecip|)
                      (|BasicType|) (|CoercibleTo| 26))
                   (|makeByteWordVec2| 64
                                       '(1 10 14 0 15 1 12 14 0 17 0 10 0 19 0
                                         12 0 20 1 10 22 0 23 1 12 22 0 24 1 14
                                         26 0 27 1 28 26 0 29 1 10 22 0 30 1 10
                                         26 0 31 2 26 0 0 0 32 2 26 0 0 0 33 0
                                         10 0 35 0 12 0 36 2 10 0 0 0 39 2 10 0
                                         0 0 40 2 12 0 0 0 41 1 10 0 0 43 1 12
                                         22 0 45 2 10 22 0 0 47 2 12 22 0 0 48
                                         1 10 0 14 53 2 57 0 0 0 58 2 0 22 0 0
                                         1 2 0 22 0 0 50 0 0 51 52 0 0 0 1 1 0
                                         61 0 1 2 0 0 0 51 1 2 0 0 0 54 1 1 0
                                         61 0 1 0 0 0 1 1 0 14 0 46 1 0 22 0 25
                                         1 0 54 0 56 1 0 61 0 1 2 0 0 0 51 1 2
                                         0 0 0 54 1 1 0 62 0 1 1 0 0 0 44 1 0 0
                                         54 55 2 0 64 64 0 1 1 0 63 0 1 0 0 37
                                         38 1 0 14 0 18 1 0 14 0 16 1 0 12 0 13
                                         1 0 10 0 11 0 0 37 59 1 0 60 0 1 2 0 0
                                         0 0 1 2 0 0 0 0 1 1 0 26 0 34 2 0 0 0
                                         14 1 2 0 0 0 51 1 2 0 0 0 54 1 0 0 0
                                         21 2 0 22 0 0 49 2 0 0 0 0 1 2 0 0 0 0
                                         42)))))
           '|lookupComplete|)) 
