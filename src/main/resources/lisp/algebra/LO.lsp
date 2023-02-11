
(SDEFUN |LO;Zero;$;1| (($ ($)))
        (CONS (|spadConstant| $ 10) (|spadConstant| $ 11))) 

(SDEFUN |LO;zero?;$B;2| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL (QCAR |x|) (QREFELT $ 13))) 

(SDEFUN |LO;-;2$;3| ((|x| ($)) ($ ($)))
        (CONS (SPADCALL (QCAR |x|) (QREFELT $ 15)) (QCDR |x|))) 

(SDEFUN |LO;=;2$B;4| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL (QCDR |y|) (QCAR |x|) (QREFELT $ 17))
                  (SPADCALL (QCDR |x|) (QCAR |y|) (QREFELT $ 17))
                  (QREFELT $ 18))) 

(PUT '|LO;numer;$M;5| '|SPADreplace| 'QCAR) 

(SDEFUN |LO;numer;$M;5| ((|x| ($)) ($ (M))) (QCAR |x|)) 

(PUT '|LO;denom;$R;6| '|SPADreplace| 'QCDR) 

(SDEFUN |LO;denom;$R;6| ((|x| ($)) ($ (R))) (QCDR |x|)) 

(SDEFUN |LO;<;2$B;7| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL (QCDR |y|) (QCAR |x|) (QREFELT $ 17))
                  (SPADCALL (QCDR |x|) (QCAR |y|) (QREFELT $ 17))
                  (QREFELT $ 22))) 

(SDEFUN |LO;+;3$;8| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS
         (SPADCALL (SPADCALL (QCDR |y|) (QCAR |x|) (QREFELT $ 17))
                   (SPADCALL (QCDR |x|) (QCAR |y|) (QREFELT $ 17))
                   (QREFELT $ 24))
         (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 25)))) 

(SDEFUN |LO;*;I2$;9| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (CONS (SPADCALL |n| (QCAR |x|) (QREFELT $ 28)) (QCDR |x|))) 

(SDEFUN |LO;*;R2$;10| ((|r| (R)) (|x| ($)) ($ ($)))
        (COND
         ((SPADCALL |r| (QCDR |x|) (QREFELT $ 30))
          (CONS (QCAR |x|) (|spadConstant| $ 11)))
         ('T (CONS (SPADCALL |r| (QCAR |x|) (QREFELT $ 17)) (QCDR |x|))))) 

(SDEFUN |LO;/;$R$;11| ((|x| ($)) (|d| (R)) ($ ($)))
        (SPROG ((|u| (R)))
               (COND
                ((SPADCALL (LETT |u| (SPADCALL |d| (QCDR |x|) (QREFELT $ 25)))
                           (QREFELT $ 32))
                 (|error| "division by zero"))
                ('T (CONS (QCAR |x|) |u|))))) 

(SDEFUN |LO;/;MR$;12| ((|m| (M)) (|d| (R)) ($ ($)))
        (COND ((SPADCALL |d| (QREFELT $ 32)) (|error| "division by zero"))
              ('T (CONS |m| |d|)))) 

(SDEFUN |LO;coerce;$Of;13| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|xd| (R)))
               (SEQ (LETT |xd| (QCDR |x|))
                    (EXIT
                     (COND
                      ((SPADCALL |xd| (|spadConstant| $ 11) (QREFELT $ 30))
                       (SPADCALL (QCAR |x|) (QREFELT $ 36)))
                      ('T
                       (SPADCALL (SPADCALL (QCAR |x|) (QREFELT $ 36))
                                 (SPADCALL |xd| (QREFELT $ 37))
                                 (QREFELT $ 38)))))))) 

(SDEFUN |LO;latex;$S;14| ((|x| ($)) ($ (|String|)))
        (SPROG ((|dl| #1=(|String|)) (|nl| #1#) (|xd| (R)))
               (SEQ (LETT |xd| (QCDR |x|))
                    (EXIT
                     (COND
                      ((SPADCALL |xd| (|spadConstant| $ 11) (QREFELT $ 30))
                       (SPADCALL (QCAR |x|) (QREFELT $ 41)))
                      ('T
                       (SEQ
                        (LETT |nl|
                              (STRCONC "{"
                                       (STRCONC
                                        (SPADCALL (QCAR |x|) (QREFELT $ 41))
                                        "}")))
                        (LETT |dl|
                              (STRCONC "{"
                                       (STRCONC
                                        (SPADCALL (QCDR |x|) (QREFELT $ 42))
                                        "}")))
                        (EXIT
                         (STRCONC "{ "
                                  (STRCONC |nl|
                                           (STRCONC " \\over "
                                                    (STRCONC |dl|
                                                             " }")))))))))))) 

(DECLAIM (NOTINLINE |Localize;|)) 

(DEFUN |Localize| (&REST #1=#:G729)
  (SPROG NIL
         (PROG (#2=#:G730)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|Localize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |Localize;|) #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Localize|)))))))))) 

(DEFUN |Localize;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Localize| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|OrderedAbelianGroup|))
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|OrderedAbelianGroup|))
                                               (|HasCategory| |#2|
                                                              '(|AbelianGroup|))
                                               (|HasCategory| |#2|
                                                              '(|AbelianMonoid|)))
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|OrderedAbelianGroup|))
                                               (|HasCategory| |#2|
                                                              '(|AbelianGroup|)))
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|OrderedAbelianGroup|))
                                               (|HasCategory| |#2|
                                                              '(|AbelianMonoid|)))))))
          (|haddProp| |$ConstructorCache| '|Localize| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|Record| (|:| |num| |#1|) (|:| |den| |#2|)))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 23 (CONS (|dispatchFunction| |LO;<;2$B;7|) $))))
          $))) 

(MAKEPROP '|Localize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |LO;Zero;$;1|) $))
              (0 . |Zero|) (4 . |One|) (|Boolean|) (8 . |zero?|)
              |LO;zero?;$B;2| (13 . -) |LO;-;2$;3| (18 . *) (24 . =)
              |LO;=;2$B;4| |LO;numer;$M;5| |LO;denom;$R;6| (30 . <) (36 . <)
              (42 . +) (48 . *) |LO;+;3$;8| (|Integer|) (54 . *) |LO;*;I2$;9|
              (60 . =) |LO;*;R2$;10| (66 . |zero?|) |LO;/;$R$;11| |LO;/;MR$;12|
              (|OutputForm|) (71 . |coerce|) (76 . |coerce|) (81 . /)
              |LO;coerce;$Of;13| (|String|) (87 . |latex|) (92 . |latex|)
              |LO;latex;$S;14| (|Union| $ '"failed") (|NonNegativeInteger|)
              (|PositiveInteger|) (|HashState|) (|SingleInteger|))
           '#(~= 97 |zero?| 103 |subtractIfCan| 108 |smaller?| 114 |sample| 120
              |opposite?| 124 |numer| 130 |min| 135 |max| 141 |latex| 147
              |hashUpdate!| 152 |hash| 158 |denom| 163 |coerce| 168 |Zero| 173
              >= 177 > 183 = 189 <= 195 < 201 / 207 - 219 + 230 * 236)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(0 0 1 0 0 1 1 3 1 3 1 2 0 1 0 0 0 1))
                 (CONS
                  '#(|Module&| NIL NIL NIL NIL NIL NIL |AbelianGroup&| NIL NIL
                     |OrderedSet&| |AbelianMonoid&| |AbelianSemiGroup&| NIL
                     |SetCategory&| |BasicType&| NIL |PartialOrder&|)
                  (CONS
                   '#((|Module| 7) (|BiModule| 7 7) (|OrderedAbelianGroup|)
                      (|LeftModule| 7) (|RightModule| 7)
                      (|OrderedCancellationAbelianMonoid|)
                      (|OrderedAbelianMonoid|) (|AbelianGroup|)
                      (|OrderedAbelianSemiGroup|) (|CancellationAbelianMonoid|)
                      (|OrderedSet|) (|AbelianMonoid|) (|AbelianSemiGroup|)
                      (|Comparable|) (|SetCategory|) (|BasicType|)
                      (|CoercibleTo| 35) (|PartialOrder|))
                   (|makeByteWordVec2| 48
                                       '(0 6 0 10 0 7 0 11 1 6 12 0 13 1 6 0 0
                                         15 2 6 0 7 0 17 2 6 12 0 0 18 2 6 12 0
                                         0 22 2 0 12 0 0 23 2 6 0 0 0 24 2 7 0
                                         0 0 25 2 6 0 27 0 28 2 7 12 0 0 30 1 7
                                         12 0 32 1 6 35 0 36 1 7 35 0 37 2 35 0
                                         0 0 38 1 6 40 0 41 1 7 40 0 42 2 0 12
                                         0 0 1 1 4 12 0 14 2 3 44 0 0 1 2 1 12
                                         0 0 1 0 4 0 1 2 4 12 0 0 1 1 0 6 0 20
                                         2 1 0 0 0 1 2 1 0 0 0 1 1 0 40 0 43 2
                                         0 47 47 0 1 1 0 48 0 1 1 0 7 0 21 1 0
                                         35 0 39 0 4 0 9 2 1 12 0 0 1 2 1 12 0
                                         0 1 2 0 12 0 0 19 2 1 12 0 0 1 2 1 12
                                         0 0 23 2 0 0 6 7 34 2 0 0 0 7 33 1 3 0
                                         0 16 2 3 0 0 0 1 2 0 0 0 0 26 2 3 0 27
                                         0 29 2 4 0 45 0 1 2 0 0 7 0 31 2 0 0 0
                                         7 1 2 0 0 46 0 1)))))
           '|lookupComplete|)) 
