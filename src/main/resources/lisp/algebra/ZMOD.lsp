
(SDEFUN |ZMOD;size;Nni;1| (($ (|NonNegativeInteger|))) (QREFELT $ 6)) 

(SDEFUN |ZMOD;characteristic;Nni;2| (($ (|NonNegativeInteger|))) (QREFELT $ 6)) 

(SDEFUN |ZMOD;lookup;$Pi;3| ((|x| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G700 NIL))
               (COND ((SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 6))
                     ('T
                      (PROG1 (LETT #1# (SPADCALL |x| (QREFELT $ 13)))
                        (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                          '(|Integer|) #1#)))))) 

(SDEFUN |ZMOD;bloodyCompiler| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL |n| (QREFELT $ 6) (QREFELT $ 21))) 

(PUT '|ZMOD;convert;$I;5| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |ZMOD;convert;$I;5| ((|x| ($)) ($ (|Integer|))) |x|) 

(SDEFUN |ZMOD;coerce;$Of;6| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 23))) 

(SDEFUN |ZMOD;coerce;I$;7| ((|n| (|Integer|)) ($ ($)))
        (|ZMOD;bloodyCompiler| |n| $)) 

(PUT '|ZMOD;Zero;$;8| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |ZMOD;Zero;$;8| (($ ($))) 0) 

(PUT '|ZMOD;One;$;9| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |ZMOD;One;$;9| (($ ($))) 1) 

(PUT '|ZMOD;init;$;10| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |ZMOD;init;$;10| (($ ($))) 0) 

(SDEFUN |ZMOD;nextItem;$U;11| ((|n| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|m| ($)))
               (SEQ
                (LETT |m| (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29)))
                (EXIT
                 (COND
                  ((SPADCALL |m| (|spadConstant| $ 26) (QREFELT $ 30))
                   (CONS 1 "failed"))
                  ('T (CONS 0 |m|))))))) 

(PUT '|ZMOD;=;2$B;12| '|SPADreplace| '|eql_SI|) 

(SDEFUN |ZMOD;=;2$B;12| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (|eql_SI| |x| |y|)) 

(SDEFUN |ZMOD;*;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (|mulmod_SI| |x| |y| (QREFELT $ 20))) 

(SDEFUN |ZMOD;*;I2$;14| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (|mulmod_SI| (|ZMOD;bloodyCompiler| |n| $) |x| (QREFELT $ 20))) 

(SDEFUN |ZMOD;+;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (|addmod_SI| |x| |y| (QREFELT $ 20))) 

(SDEFUN |ZMOD;-;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (|submod_SI| |x| |y| (QREFELT $ 20))) 

(SDEFUN |ZMOD;random;$;17| (($ ($))) (RANDOM (QREFELT $ 20))) 

(SDEFUN |ZMOD;index;Pi$;18| ((|a| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 25)) (QREFELT $ 20) (QREFELT $ 37))) 

(SDEFUN |ZMOD;-;2$;19| ((|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 11)) (|spadConstant| $ 26))
              ('T (|sub_SI| (QREFELT $ 20) |x|)))) 

(SDEFUN |ZMOD;^;$Nni$;20| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (COND
         ((< |n| (QREFELT $ 6))
          (SPADCALL |x| (SPADCALL |n| (QREFELT $ 25)) (QREFELT $ 20)
                    (QREFELT $ 40)))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |x| (QREFELT $ 13)) |n| (QREFELT $ 6)
                     (QREFELT $ 41))
           (QREFELT $ 25))))) 

(SDEFUN |ZMOD;recip;$U;21| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG
         ((|g| ($)) (|c2| ($)) (|c1| ($))
          (|#G24|
           (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))))
         (SEQ
          (PROGN
           (LETT |#G24| (SPADCALL |x| (QREFELT $ 20) (QREFELT $ 44)))
           (LETT |c1| (QVELT |#G24| 0))
           (LETT |c2| (QVELT |#G24| 1))
           (LETT |g| (QVELT |#G24| 2))
           |#G24|)
          (EXIT
           (COND
            ((SPADCALL |g| (|spadConstant| $ 27) (QREFELT $ 30))
             (CONS 0 (SPADCALL |c1| (QREFELT $ 20) (QREFELT $ 37))))
            ('T (CONS 1 "failed"))))))) 

(PUT '|ZMOD;hashUpdate!;Hs$Hs;22| '|SPADreplace| 'HASHSTATEUPDATE) 

(SDEFUN |ZMOD;hashUpdate!;Hs$Hs;22| ((|hs| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (HASHSTATEUPDATE |hs| |s|)) 

(PUT '|ZMOD;convert;$I;23| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |ZMOD;convert;$I;23| ((|x| ($)) ($ (|Integer|))) |x|) 

(SDEFUN |ZMOD;coerce;I$;24| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL |n| (QREFELT $ 6) (QREFELT $ 37))) 

(SDEFUN |ZMOD;coerce;$Of;25| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 23))) 

(PUT '|ZMOD;Zero;$;26| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |ZMOD;Zero;$;26| (($ ($))) 0) 

(PUT '|ZMOD;One;$;27| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |ZMOD;One;$;27| (($ ($))) 1) 

(PUT '|ZMOD;init;$;28| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |ZMOD;init;$;28| (($ ($))) 0) 

(SDEFUN |ZMOD;nextItem;$U;29| ((|n| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|m| ($)))
               (SEQ
                (LETT |m| (SPADCALL |n| (|spadConstant| $ 27) (QREFELT $ 29)))
                (EXIT
                 (COND
                  ((SPADCALL |m| (|spadConstant| $ 26) (QREFELT $ 30))
                   (CONS 1 "failed"))
                  ('T (CONS 0 |m|))))))) 

(PUT '|ZMOD;=;2$B;30| '|SPADreplace| 'EQL) 

(SDEFUN |ZMOD;=;2$B;30| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQL |x| |y|)) 

(SDEFUN |ZMOD;*;3$;31| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 6) (QREFELT $ 48))) 

(SDEFUN |ZMOD;*;I2$;32| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 6) (QREFELT $ 37)) |x| (QREFELT $ 6)
                  (QREFELT $ 48))) 

(SDEFUN |ZMOD;+;3$;33| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 6) (QREFELT $ 49))) 

(SDEFUN |ZMOD;-;3$;34| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 6) (QREFELT $ 50))) 

(SDEFUN |ZMOD;random;$;35| (($ ($))) (RANDOM (QREFELT $ 6))) 

(SDEFUN |ZMOD;index;Pi$;36| ((|a| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |a| (QREFELT $ 6) (QREFELT $ 37))) 

(SDEFUN |ZMOD;-;2$;37| ((|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 11)) (|spadConstant| $ 26))
              ('T (- (QREFELT $ 6) |x|)))) 

(SDEFUN |ZMOD;^;$Nni$;38| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 6) (QREFELT $ 40))) 

(SDEFUN |ZMOD;recip;$U;39| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG
         ((|g| ($)) (|c2| ($)) (|c1| ($))
          (|#G46|
           (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))))
         (SEQ
          (PROGN
           (LETT |#G46| (SPADCALL |x| (QREFELT $ 6) (QREFELT $ 44)))
           (LETT |c1| (QVELT |#G46| 0))
           (LETT |c2| (QVELT |#G46| 1))
           (LETT |g| (QVELT |#G46| 2))
           |#G46|)
          (EXIT
           (COND
            ((SPADCALL |g| (|spadConstant| $ 27) (QREFELT $ 30))
             (CONS 0 (SPADCALL |c1| (QREFELT $ 6) (QREFELT $ 37))))
            ('T (CONS 1 "failed"))))))) 

(SDEFUN |ZMOD;hashUpdate!;Hs$Hs;40| ((|hs| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (HASHSTATEUPDATE |hs| (SXHASH |s|))) 

(DECLAIM (NOTINLINE |IntegerMod;|)) 

(DEFUN |IntegerMod| (#1=#:G769)
  (SPROG NIL
         (PROG (#2=#:G770)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IntegerMod|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IntegerMod;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|IntegerMod|)))))))))) 

(DEFUN |IntegerMod;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|IntegerMod| DV$1))
          (LETT $ (GETREFV 54))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerMod| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 16 (<= |#1| (ASH MOST-POSITIVE-FIXNUM -1)))
          (COND
           ((QREFELT $ 16)
            (PROGN
             (QSETREFV $ 17 (|SingleInteger|))
             (QSETREFV $ 20 (SPADCALL |#1| (QREFELT $ 19)))
             NIL
             (QSETREFV $ 13 (CONS (|dispatchFunction| |ZMOD;convert;$I;5|) $))
             (QSETREFV $ 24 (CONS (|dispatchFunction| |ZMOD;coerce;$Of;6|) $))
             (QSETREFV $ 25 (CONS (|dispatchFunction| |ZMOD;coerce;I$;7|) $))
             (QSETREFV $ 26
                       (CONS #'|makeSpadConstant|
                             (LIST (|dispatchFunction| |ZMOD;Zero;$;8|) $ 26)))
             (QSETREFV $ 27
                       (CONS #'|makeSpadConstant|
                             (LIST (|dispatchFunction| |ZMOD;One;$;9|) $ 27)))
             (QSETREFV $ 28
                       (CONS #'|makeSpadConstant|
                             (LIST (|dispatchFunction| |ZMOD;init;$;10|) $
                                   28)))
             (QSETREFV $ 32
                       (CONS (|dispatchFunction| |ZMOD;nextItem;$U;11|) $))
             (QSETREFV $ 30 (CONS (|dispatchFunction| |ZMOD;=;2$B;12|) $))
             (QSETREFV $ 33 (CONS (|dispatchFunction| |ZMOD;*;3$;13|) $))
             (QSETREFV $ 34 (CONS (|dispatchFunction| |ZMOD;*;I2$;14|) $))
             (QSETREFV $ 29 (CONS (|dispatchFunction| |ZMOD;+;3$;15|) $))
             (QSETREFV $ 35 (CONS (|dispatchFunction| |ZMOD;-;3$;16|) $))
             (QSETREFV $ 36 (CONS (|dispatchFunction| |ZMOD;random;$;17|) $))
             (QSETREFV $ 38 (CONS (|dispatchFunction| |ZMOD;index;Pi$;18|) $))
             (QSETREFV $ 39 (CONS (|dispatchFunction| |ZMOD;-;2$;19|) $))
             (QSETREFV $ 42 (CONS (|dispatchFunction| |ZMOD;^;$Nni$;20|) $))
             (QSETREFV $ 45 (CONS (|dispatchFunction| |ZMOD;recip;$U;21|) $))
             (QSETREFV $ 47
                       (CONS (|dispatchFunction| |ZMOD;hashUpdate!;Hs$Hs;22|)
                             $))))
           ('T
            (PROGN
             (SETELT $ 17 (|Integer|))
             (QSETREFV $ 13 (CONS (|dispatchFunction| |ZMOD;convert;$I;23|) $))
             (QSETREFV $ 25 (CONS (|dispatchFunction| |ZMOD;coerce;I$;24|) $))
             (QSETREFV $ 24 (CONS (|dispatchFunction| |ZMOD;coerce;$Of;25|) $))
             (QSETREFV $ 26
                       (CONS #'|makeSpadConstant|
                             (LIST (|dispatchFunction| |ZMOD;Zero;$;26|) $
                                   26)))
             (QSETREFV $ 27
                       (CONS #'|makeSpadConstant|
                             (LIST (|dispatchFunction| |ZMOD;One;$;27|) $ 27)))
             (QSETREFV $ 28
                       (CONS #'|makeSpadConstant|
                             (LIST (|dispatchFunction| |ZMOD;init;$;28|) $
                                   28)))
             (QSETREFV $ 32
                       (CONS (|dispatchFunction| |ZMOD;nextItem;$U;29|) $))
             (QSETREFV $ 30 (CONS (|dispatchFunction| |ZMOD;=;2$B;30|) $))
             (QSETREFV $ 33 (CONS (|dispatchFunction| |ZMOD;*;3$;31|) $))
             (QSETREFV $ 34 (CONS (|dispatchFunction| |ZMOD;*;I2$;32|) $))
             (QSETREFV $ 29 (CONS (|dispatchFunction| |ZMOD;+;3$;33|) $))
             (QSETREFV $ 35 (CONS (|dispatchFunction| |ZMOD;-;3$;34|) $))
             (QSETREFV $ 36 (CONS (|dispatchFunction| |ZMOD;random;$;35|) $))
             (QSETREFV $ 38 (CONS (|dispatchFunction| |ZMOD;index;Pi$;36|) $))
             (QSETREFV $ 39 (CONS (|dispatchFunction| |ZMOD;-;2$;37|) $))
             (QSETREFV $ 42 (CONS (|dispatchFunction| |ZMOD;^;$Nni$;38|) $))
             (QSETREFV $ 45 (CONS (|dispatchFunction| |ZMOD;recip;$U;39|) $))
             (QSETREFV $ 47
                       (CONS (|dispatchFunction| |ZMOD;hashUpdate!;Hs$Hs;40|)
                             $)))))
          $))) 

(MAKEPROP '|IntegerMod| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              |ZMOD;size;Nni;1| |ZMOD;characteristic;Nni;2| (|Boolean|)
              (0 . |zero?|) (|Integer|) (5 . |convert|) (|PositiveInteger|)
              |ZMOD;lookup;$Pi;3| '#:G692 '|Rep| (|SingleInteger|)
              (10 . |coerce|) '|q| (15 . |positiveRemainder|) (|OutputForm|)
              (21 . |coerce|) (26 . |coerce|) (31 . |coerce|) (36 . |Zero|)
              (40 . |One|) (44 . |init|) (48 . +) (54 . =)
              (|Union| $ '"failed") (60 . |nextItem|) (65 . *) (71 . *)
              (77 . -) (83 . |random|) (87 . |positiveRemainder|)
              (93 . |index|) (98 . -) (103 . |powmod|) (110 . |powmod|)
              (117 . ^)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (123 . |extendedEuclidean|) (129 . |recip|) (|HashState|)
              (134 . |hashUpdate!|) (140 . |mulmod|) (147 . |addmod|)
              (154 . |submod|) (|InputForm|) (|List| $) (|String|))
           '#(~= 161 |zero?| 167 |subtractIfCan| 172 |smaller?| 178 |size| 184
              |sample| 188 |rightRecip| 192 |rightPower| 197 |recip| 209
              |random| 214 |opposite?| 218 |one?| 224 |nextItem| 229 |lookup|
              234 |leftRecip| 239 |leftPower| 244 |latex| 256 |init| 261
              |index| 265 |hashUpdate!| 270 |hash| 276 |enumerate| 281
              |convert| 285 |commutator| 295 |coerce| 301 |characteristic| 316
              |associator| 320 |antiCommutator| 327 |annihilate?| 333 ^ 339
              |Zero| 351 |One| 355 = 359 - 365 + 376 * 382)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(NIL |Algebra&| NIL |Rng&| NIL |Module&| NIL NIL
                |NonAssociativeRing&| NIL |NonAssociativeRng&| NIL
                |AbelianGroup&| NIL NIL NIL |Finite&| NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| NIL NIL |Magma&|
                |AbelianSemiGroup&| NIL |SetCategory&| NIL NIL NIL NIL
                |BasicType&| NIL)
             (CONS
              '#((|CommutativeRing|) (|Algebra| $$) (|Ring|) (|Rng|)
                 (|SemiRing|) (|Module| $$) (|SemiRng|) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|Finite|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|StepThrough|)
                 (|Comparable|) (|Magma|) (|AbelianSemiGroup|)
                 (|CommutativeStar|) (|SetCategory|) (|ConvertibleTo| 12)
                 (|ConvertibleTo| 51) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 22))
              (|makeByteWordVec2| 53
                                  '(1 0 10 0 11 1 0 12 0 13 1 18 0 12 19 2 12 0
                                    0 0 21 1 17 22 0 23 1 0 22 0 24 1 0 0 12 25
                                    0 0 0 26 0 0 0 27 0 0 0 28 2 0 0 0 0 29 2 0
                                    10 0 0 30 1 0 31 0 32 2 0 0 0 0 33 2 0 0 12
                                    0 34 2 0 0 0 0 35 0 0 0 36 2 17 0 0 0 37 1
                                    0 0 14 38 1 0 0 0 39 3 17 0 0 0 0 40 3 12 0
                                    0 0 0 41 2 0 0 0 7 42 2 17 43 0 0 44 1 0 31
                                    0 45 2 0 46 46 0 47 3 17 0 0 0 0 48 3 17 0
                                    0 0 0 49 3 17 0 0 0 0 50 2 0 10 0 0 1 1 0
                                    10 0 11 2 0 31 0 0 1 2 0 10 0 0 1 0 0 7 8 0
                                    0 0 1 1 0 31 0 1 2 0 0 0 7 1 2 0 0 0 14 1 1
                                    0 31 0 45 0 0 0 36 2 0 10 0 0 1 1 0 10 0 1
                                    1 0 31 0 32 1 0 14 0 15 1 0 31 0 1 2 0 0 0
                                    7 1 2 0 0 0 14 1 1 0 53 0 1 0 0 0 28 1 0 0
                                    14 38 2 0 46 46 0 47 1 0 18 0 1 0 0 52 1 1
                                    0 12 0 13 1 0 51 0 1 2 0 0 0 0 1 1 0 0 0 1
                                    1 0 0 12 25 1 0 22 0 24 0 0 7 9 3 0 0 0 0 0
                                    1 2 0 0 0 0 1 2 0 10 0 0 1 2 0 0 0 7 42 2 0
                                    0 0 14 1 0 0 0 26 0 0 0 27 2 0 10 0 0 30 1
                                    0 0 0 39 2 0 0 0 0 35 2 0 0 0 0 29 2 0 0 7
                                    0 1 2 0 0 12 0 34 2 0 0 0 0 33 2 0 0 14 0
                                    1)))))
           '|lookupComplete|)) 
