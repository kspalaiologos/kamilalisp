
(PUT '|MODRING;modulus;$Mod;1| '|SPADreplace| 'QCDR) 

(SDEFUN |MODRING;modulus;$Mod;1| ((|x| ($)) ($ (|Mod|))) (QCDR |x|)) 

(PUT '|MODRING;coerce;$R;2| '|SPADreplace| 'QCAR) 

(SDEFUN |MODRING;coerce;$R;2| ((|x| ($)) ($ (R))) (QCAR |x|)) 

(SDEFUN |MODRING;coerce;I$;3| ((|i| (|Integer|)) ($ ($)))
        (CONS (SPADCALL |i| (QREFELT $ 15)) (|spadConstant| $ 18))) 

(SDEFUN |MODRING;*;I2$;4| ((|i| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 19)) |x| (QREFELT $ 20))) 

(SDEFUN |MODRING;coerce;$Of;5| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (QCAR |x|) (QREFELT $ 23))) 

(SDEFUN |MODRING;reduce;RMod$;6| ((|a| (R)) (|m| (|Mod|)) ($ ($)))
        (CONS (SPADCALL |a| |m| (QREFELT $ 8)) |m|)) 

(SDEFUN |MODRING;characteristic;Nni;7| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 27))) 

(SDEFUN |MODRING;Zero;$;8| (($ ($)))
        (CONS (|spadConstant| $ 17) (|spadConstant| $ 18))) 

(SDEFUN |MODRING;One;$;9| (($ ($)))
        (CONS (|spadConstant| $ 29) (|spadConstant| $ 18))) 

(SDEFUN |MODRING;zero?;$B;10| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL (QCAR |x|) (QREFELT $ 32))) 

(SDEFUN |MODRING;one?;$B;11| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL (QCAR |x|) (|spadConstant| $ 29) (QREFELT $ 34))) 

(SDEFUN |MODRING;newmodulo| ((|m1| (|Mod|)) (|m2| (|Mod|)) ($ (|Mod|)))
        (SPROG ((|r| (|Union| |Mod| "failed")))
               (SEQ (LETT |r| (SPADCALL |m1| |m2| (QREFELT $ 9)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (|error| "incompatible moduli"))
                           ('T (QCDR |r|))))))) 

(SDEFUN |MODRING;=;2$B;13| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 34)) 'T)
              ((SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 36)) NIL)
              ('T
               (SPADCALL (QCAR (SPADCALL |x| |y| (QREFELT $ 37)))
                         (|spadConstant| $ 17) (QREFELT $ 34))))) 

(SDEFUN |MODRING;+;3$;14| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 39))
                  (|MODRING;newmodulo| (QCDR |x|) (QCDR |y|) $) (QREFELT $ 25))) 

(SDEFUN |MODRING;-;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 41))
                  (|MODRING;newmodulo| (QCDR |x|) (QCDR |y|) $) (QREFELT $ 25))) 

(SDEFUN |MODRING;-;2$;16| ((|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QREFELT $ 42)) (QCDR |x|)
                  (QREFELT $ 25))) 

(SDEFUN |MODRING;*;3$;17| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 44))
                  (|MODRING;newmodulo| (QCDR |x|) (QCDR |y|) $) (QREFELT $ 25))) 

(SDEFUN |MODRING;exQuo;2$U;18| ((|x| ($)) (|y| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|r| (|Union| R "failed")) (|xm| (|Mod|)))
               (SEQ (LETT |xm| (QCDR |x|))
                    (COND
                     ((SPADCALL |xm| (QCDR |y|) (QREFELT $ 45))
                      (LETT |xm| (|MODRING;newmodulo| |xm| (QCDR |y|) $))))
                    (LETT |r|
                          (SPADCALL (QCAR |x|) (QCAR |y|) |xm| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (CONS (QCDR |r|) |xm|)))))))) 

(SDEFUN |MODRING;recip;$U;19| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ
                (LETT |r|
                      (SPADCALL (|spadConstant| $ 29) (QCAR |x|) (QCDR |x|)
                                (QREFELT $ 10)))
                (EXIT
                 (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                       ('T (CONS 0 (CONS (QCDR |r|) (QCDR |x|))))))))) 

(SDEFUN |MODRING;inv;2$;20| ((|x| ($)) ($ ($)))
        (SPROG ((|u| (|Union| $ "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 48)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (|error| "not invertible"))
                           ('T (QCDR |u|))))))) 

(DECLAIM (NOTINLINE |ModularRing;|)) 

(DEFUN |ModularRing| (&REST #1=#:G753)
  (SPROG NIL
         (PROG (#2=#:G754)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T NIL NIL NIL))
                     (HGET |$ConstructorCache| '|ModularRing|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ModularRing;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ModularRing|)))))))))) 

(DEFUN |ModularRing;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT DV$5 |#5|)
    (LETT |dv$| (LIST '|ModularRing| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 54))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|ModularRing|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 11 (|Record| (|:| |val| |#1|) (|:| |modulo| |#2|)))
    $))) 

(MAKEPROP '|ModularRing| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) '|Rep|
              |MODRING;modulus;$Mod;1| |MODRING;coerce;$R;2| (|Integer|)
              (0 . |coerce|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |MODRING;Zero;$;8|) $))
              (5 . |Zero|) (9 . |Zero|) |MODRING;coerce;I$;3| |MODRING;*;3$;17|
              |MODRING;*;I2$;4| (|OutputForm|) (13 . |coerce|)
              |MODRING;coerce;$Of;5| |MODRING;reduce;RMod$;6|
              (|NonNegativeInteger|) (18 . |characteristic|)
              |MODRING;characteristic;Nni;7| (22 . |One|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |MODRING;One;$;9|) $))
              (|Boolean|) (26 . |zero?|) |MODRING;zero?;$B;10| (31 . =)
              |MODRING;one?;$B;11| (37 . =) |MODRING;-;3$;15|
              |MODRING;=;2$B;13| (43 . +) |MODRING;+;3$;14| (49 . -) (55 . -)
              |MODRING;-;2$;16| (60 . *) (66 . ~=) (|Union| $ '"failed")
              |MODRING;exQuo;2$U;18| |MODRING;recip;$U;19| |MODRING;inv;2$;20|
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 72 |zero?| 78 |subtractIfCan| 83 |sample| 89 |rightRecip| 93
              |rightPower| 98 |reduce| 110 |recip| 116 |opposite?| 121 |one?|
              127 |modulus| 132 |leftRecip| 137 |leftPower| 142 |latex| 154
              |inv| 159 |hashUpdate!| 164 |hash| 170 |exQuo| 175 |commutator|
              181 |coerce| 187 |characteristic| 202 |associator| 206
              |antiCommutator| 213 |annihilate?| 219 ^ 225 |Zero| 237 |One| 241
              = 245 - 251 + 262 * 268)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0))
            (CONS
             '#(NIL |Rng&| NIL NIL |NonAssociativeRing&| NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| |SetCategory&| NIL |BasicType&|
                NIL)
             (CONS
              '#((|Ring|) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| $$)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|SetCategory|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 22))
              (|makeByteWordVec2| 53
                                  '(1 6 0 14 15 0 6 0 17 0 7 0 18 1 6 22 0 23 0
                                    6 26 27 0 6 0 29 1 6 31 0 32 2 6 31 0 0 34
                                    2 7 31 0 0 36 2 6 0 0 0 39 2 6 0 0 0 41 1 6
                                    0 0 42 2 6 0 0 0 44 2 7 31 0 0 45 2 0 31 0
                                    0 1 1 0 31 0 33 2 0 46 0 0 1 0 0 0 1 1 0 46
                                    0 1 2 0 0 0 26 1 2 0 0 0 50 1 2 0 0 6 7 25
                                    1 0 46 0 48 2 0 31 0 0 1 1 0 31 0 35 1 0 7
                                    0 12 1 0 46 0 1 2 0 0 0 26 1 2 0 0 0 50 1 1
                                    0 51 0 1 1 0 0 0 49 2 0 53 53 0 1 1 0 52 0
                                    1 2 0 46 0 0 47 2 0 0 0 0 1 1 0 6 0 13 1 0
                                    0 14 19 1 0 22 0 24 0 0 26 28 3 0 0 0 0 0 1
                                    2 0 0 0 0 1 2 0 31 0 0 1 2 0 0 0 26 1 2 0 0
                                    0 50 1 0 0 0 16 0 0 0 30 2 0 31 0 0 38 1 0
                                    0 0 43 2 0 0 0 0 37 2 0 0 0 0 40 2 0 0 26 0
                                    1 2 0 0 14 0 21 2 0 0 0 0 20 2 0 0 50 0
                                    1)))))
           '|lookupComplete|)) 
