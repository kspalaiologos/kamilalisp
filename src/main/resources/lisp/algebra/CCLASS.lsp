
(SDEFUN |CCLASS;digit;$;1| (($ ($))) (SPADCALL "0123456789" (QREFELT $ 9))) 

(SDEFUN |CCLASS;hexDigit;$;2| (($ ($)))
        (SPADCALL "0123456789abcdefABCDEF" (QREFELT $ 9))) 

(SDEFUN |CCLASS;upperCase;$;3| (($ ($)))
        (SPADCALL "ABCDEFGHIJKLMNOPQRSTUVWXYZ" (QREFELT $ 9))) 

(SDEFUN |CCLASS;lowerCase;$;4| (($ ($)))
        (SPADCALL "abcdefghijklmnopqrstuvwxyz" (QREFELT $ 9))) 

(SDEFUN |CCLASS;alphabetic;$;5| (($ ($)))
        (SPADCALL (|spadConstant| $ 12) (|spadConstant| $ 13) (QREFELT $ 14))) 

(SDEFUN |CCLASS;alphanumeric;$;6| (($ ($)))
        (SPADCALL (|spadConstant| $ 15) (|spadConstant| $ 10) (QREFELT $ 14))) 

(SDEFUN |CCLASS;=;2$B;7| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPADCALL |a| |b| (QREFELT $ 18))) 

(SDEFUN |CCLASS;member?;C$B;8| ((|c| (|Character|)) (|a| ($)) ($ (|Boolean|)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (LETT |i| |c|)
                    (EXIT
                     (COND
                      ((< |i| (QREFELT $ 7)) (SPADCALL |a| |i| (QREFELT $ 21)))
                      ('T NIL)))))) 

(SDEFUN |CCLASS;union;3$;9| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |a| |b| (QREFELT $ 24))) 

(SDEFUN |CCLASS;intersect;3$;10| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |a| |b| (QREFELT $ 25))) 

(SDEFUN |CCLASS;difference;3$;11| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |a| (SPADCALL |b| (QREFELT $ 27)) (QREFELT $ 25))) 

(SDEFUN |CCLASS;complement;2$;12| ((|a| ($)) ($ ($)))
        (SPADCALL |a| (QREFELT $ 27))) 

(SDEFUN |CCLASS;convert;$S;13| ((|cl| ($)) ($ (|String|)))
        (SPADCALL (SPADCALL |cl| (QREFELT $ 31)) (QREFELT $ 32))) 

(SDEFUN |CCLASS;convert;$L;14| ((|cl| ($)) ($ (|List| (|Character|))))
        (SPROG ((#1=#:G718 NIL) (|i| NIL) (#2=#:G717 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 7) 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |cl| |i| (QREFELT $ 21))
                          (LETT #2#
                                (CONS (SPADCALL |i| (QREFELT $ 34)) #2#))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |CCLASS;charClass;S$;15| ((|s| (|String|)) ($ ($)))
        (SPROG ((|j| (|Integer|)) (#1=#:G724 NIL) (|i| NIL) (|cl| ($)))
               (SEQ (LETT |cl| (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 36)))
                    (SEQ (LETT |i| (SPADCALL |s| (QREFELT $ 37)))
                         (LETT #1# (SPADCALL |s| (QREFELT $ 38))) G190
                         (COND ((> |i| #1#) (GO G191)))
                         (SEQ (LETT |j| (SPADCALL |s| |i| (QREFELT $ 39)))
                              (EXIT
                               (COND
                                ((>= |j| (QREFELT $ 7))
                                 (|error| "character code too large"))
                                ('T (SPADCALL |cl| |j| 'T (QREFELT $ 40))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |cl|)))) 

(SDEFUN |CCLASS;charClass;L$;16| ((|l| (|List| (|Character|))) ($ ($)))
        (SPROG ((|j| (|Integer|)) (#1=#:G730 NIL) (|c| NIL) (|cl| ($)))
               (SEQ (LETT |cl| (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 36)))
                    (SEQ (LETT |c| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |j| |c|)
                              (EXIT
                               (COND
                                ((>= |j| (QREFELT $ 7))
                                 (|error| "character code too large"))
                                ('T (SPADCALL |cl| |j| 'T (QREFELT $ 40))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |cl|)))) 

(SDEFUN |CCLASS;coerce;$Of;17| ((|cl| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |cl| (QREFELT $ 33)) (QREFELT $ 43))) 

(SDEFUN |CCLASS;#;$Nni;18| ((|a| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|n| (|NonNegativeInteger|)) (#1=#:G736 NIL) (|i| NIL))
               (SEQ (LETT |n| 0)
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 7) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |a| |i| (QREFELT $ 21))
                             (LETT |n| (+ |n| 1))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |n|)))) 

(SDEFUN |CCLASS;empty;$;19| (($ ($))) (SPADCALL NIL (QREFELT $ 41))) 

(SDEFUN |CCLASS;set;$;20| (($ ($))) (SPADCALL (QREFELT $ 46))) 

(SDEFUN |CCLASS;insert!;C2$;21| ((|c| (|Character|)) (|a| ($)) ($ ($)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (LETT |i| |c|)
                    (EXIT
                     (COND
                      ((< |i| (QREFELT $ 7))
                       (SEQ (SPADCALL |a| |i| 'T (QREFELT $ 40)) (EXIT |a|)))
                      ('T (|error| "character code too large"))))))) 

(SDEFUN |CCLASS;remove!;C2$;22| ((|c| (|Character|)) (|a| ($)) ($ ($)))
        (SPROG ((|i| (|Integer|)))
               (SEQ
                (SEQ (LETT |i| |c|)
                     (EXIT
                      (COND
                       ((< |i| (QREFELT $ 7))
                        (SPADCALL |a| |i| NIL (QREFELT $ 40))))))
                (EXIT |a|)))) 

(SDEFUN |CCLASS;inspect;$C;23| ((|a| ($)) ($ (|Character|)))
        (SPROG ((#1=#:G749 NIL) (#2=#:G750 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 7) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |a| |i| (QREFELT $ 21))
                           (PROGN
                            (LETT #1# (SPADCALL |i| (QREFELT $ 34)))
                            (GO #3=#:G748))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (|error| "Cannot take a character from an empty class."))))
                #3# (EXIT #1#)))) 

(SDEFUN |CCLASS;extract!;$C;24| ((|a| ($)) ($ (|Character|)))
        (SPROG ((#1=#:G756 NIL) (#2=#:G757 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 7) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |a| |i| (QREFELT $ 21))
                           (SEQ (SPADCALL |a| |i| NIL (QREFELT $ 40))
                                (EXIT
                                 (PROGN
                                  (LETT #1# (SPADCALL |i| (QREFELT $ 34)))
                                  (GO #3=#:G755))))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (|error| "Cannot take a character from an empty class."))))
                #3# (EXIT #1#)))) 

(SDEFUN |CCLASS;map;M2$;25|
        ((|f| (|Mapping| #1=(|Character|) #1#)) (|a| ($)) ($ ($)))
        (SPROG ((#2=#:G763 NIL) (|i| NIL) (|b| ($)))
               (SEQ (LETT |b| (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 36)))
                    (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 7) 1)) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |a| |i| (QREFELT $ 21))
                             (SPADCALL |b|
                                       (SPADCALL (SPADCALL |i| (QREFELT $ 34))
                                                 |f|)
                                       'T (QREFELT $ 40))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |b|)))) 

(SDEFUN |CCLASS;map!;M2$;26|
        ((|f| (|Mapping| #1=(|Character|) #1#)) (|a| ($)) ($ ($)))
        (SPROG ((#2=#:G768 NIL) (|i| NIL))
               (SEQ (SPADCALL (QREFELT $ 54) NIL (QREFELT $ 55))
                    (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 7) 1)) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |a| |i| (QREFELT $ 21))
                             (SPADCALL (QREFELT $ 54)
                                       (SPADCALL (SPADCALL |i| (QREFELT $ 34))
                                                 |f|)
                                       'T (QREFELT $ 40))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |a| (QREFELT $ 54) 0 (QREFELT $ 56)))))) 

(SDEFUN |CCLASS;parts;$L;27| ((|a| ($)) ($ (|List| (|Character|))))
        (SPROG ((#1=#:G773 NIL) (|i| NIL) (#2=#:G772 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 7) 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |a| |i| (QREFELT $ 21))
                          (LETT #2#
                                (CONS (SPADCALL |i| (QREFELT $ 34)) #2#))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |CharacterClass;|)) 

(DEFUN |CharacterClass| ()
  (SPROG NIL
         (PROG (#1=#:G783)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|CharacterClass|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|CharacterClass|
                             (LIST (CONS NIL (CONS 1 (|CharacterClass;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|CharacterClass|)))))))))) 

(DEFUN |CharacterClass;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (#1=#:G780 NIL) (|pv$| NIL) (#2=#:G781 NIL))
         (PROGN
          (LETT |dv$| '(|CharacterClass|))
          (LETT $ (GETREFV 70))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| (|Character|)
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| (|Character|)
                                                             '(|Comparable|))
                                              (|HasCategory| (|Character|)
                                                             '(|Finite|))
                                              (LETT #1#
                                                    (AND
                                                     (|HasCategory|
                                                      (|Character|)
                                                      '(|Evalable|
                                                        (|Character|)))
                                                     (|HasCategory|
                                                      (|Character|)
                                                      '(|SetCategory|))))
                                              (OR
                                               (AND
                                                (|HasCategory| (|Character|)
                                                               '(|Evalable|
                                                                 (|Character|)))
                                                (|HasCategory| (|Character|)
                                                               '(|Comparable|)))
                                               (AND
                                                (|HasCategory| (|Character|)
                                                               '(|Evalable|
                                                                 (|Character|)))
                                                (|HasCategory| (|Character|)
                                                               '(|Finite|)))
                                               #1#)
                                              (|HasCategory| (|Character|)
                                                             '(|BasicType|))
                                              (|HasCategory| (|Character|)
                                                             '(|OrderedSet|))))))
          (|haddProp| |$ConstructorCache| '|CharacterClass| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 128))
          (AND (LETT #2# (|HasCategory| $ '(|finiteAggregate|)))
               (|augmentPredVector| $ 256))
          (AND #2# (|HasCategory| (|Character|) '(|BasicType|))
               (|augmentPredVector| $ 512))
          (AND #2# (|HasCategory| (|Character|) '(|OrderedSet|))
               (|augmentPredVector| $ 1024))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|IndexedBits| 0))
          (QSETREFV $ 7 256)
          (QSETREFV $ 54 (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 36)))
          $))) 

(MAKEPROP '|CharacterClass| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| 'N (|String|)
              |CCLASS;charClass;S$;15|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CCLASS;digit;$;1|) $))
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CCLASS;hexDigit;$;2|) $))
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CCLASS;upperCase;$;3|) $))
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CCLASS;lowerCase;$;4|) $))
              |CCLASS;union;3$;9|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CCLASS;alphabetic;$;5|) $))
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CCLASS;alphanumeric;$;6|) $))
              (|Boolean|) (0 . =) |CCLASS;=;2$B;7| (|Integer|) (6 . |elt|)
              (|Character|) |CCLASS;member?;C$B;8| (12 . |Or|) (18 . |And|)
              |CCLASS;intersect;3$;10| (24 . |Not|) |CCLASS;difference;3$;11|
              |CCLASS;complement;2$;12| (|List| 22) |CCLASS;convert;$L;14|
              (29 . |construct|) |CCLASS;convert;$S;13| (34 . |char|)
              (|NonNegativeInteger|) (39 . |new|) (45 . |minIndex|)
              (50 . |maxIndex|) (55 . |elt|) (61 . |setelt!|)
              |CCLASS;charClass;L$;16| (|OutputForm|) (68 . |coerce|)
              |CCLASS;coerce;$Of;17| |CCLASS;#;$Nni;18| |CCLASS;empty;$;19|
              |CCLASS;set;$;20| |CCLASS;insert!;C2$;21| |CCLASS;remove!;C2$;22|
              |CCLASS;inspect;$C;23| |CCLASS;extract!;$C;24| (|Mapping| 22 22)
              |CCLASS;map;M2$;25| '|temp| (73 . |fill!|) (79 . |copyInto!|)
              |CCLASS;map!;M2$;26| |CCLASS;parts;$L;27| (|Equation| 22)
              (|List| 59) (|Mapping| 22 22 22) (|InputForm|) (|List| $)
              (|PositiveInteger|) (|Mapping| 17 22) (|Mapping| 17 22 22)
              (|Union| 22 '"failed") (|SingleInteger|) (|HashState|))
           '#(~= 86 |upperCase| 92 |universe| 96 |union| 100
              |symmetricDifference| 118 |subset?| 124 |smaller?| 130 |size?|
              136 |size| 142 |set| 146 |select!| 155 |select| 161 |sample| 167
              |removeDuplicates| 171 |remove!| 176 |remove| 188 |reduce| 200
              |random| 221 |parts| 225 |more?| 230 |min| 236 |members| 241
              |member?| 246 |max| 252 |map!| 263 |map| 269 |lowerCase| 275
              |lookup| 279 |less?| 284 |latex| 290 |intersect| 295 |inspect|
              301 |insert!| 306 |index| 312 |hexDigit| 317 |hashUpdate!| 321
              |hash| 327 |find| 332 |extract!| 338 |every?| 343 |eval| 349
              |eq?| 375 |enumerate| 381 |empty?| 385 |empty| 390 |digit| 394
              |difference| 398 |dictionary| 410 |count| 419 |copy| 431
              |convert| 436 |construct| 451 |complement| 456 |coerce| 461
              |charClass| 466 |cardinality| 476 |any?| 481 |alphanumeric| 487
              |alphabetic| 491 >= 495 > 501 = 507 <= 513 < 519 |#| 525)
           'NIL
           (CONS
            (|makeByteWordVec2| 5
                                '(0 0 0 0 0 0 3 0 2 0 0 5 0 0 0 0 0 0 0 0 5 1))
            (CONS
             '#(|FiniteSetAggregate&| |Dictionary&| |DictionaryOperations&|
                |SetAggregate&| |BagAggregate&| |Collection&| |Finite&|
                |HomogeneousAggregate&| NIL |SetCategory&| |Aggregate&|
                |Evalable&| NIL NIL |PartialOrder&| |BasicType&| NIL NIL NIL
                NIL |InnerEvalable&| NIL)
             (CONS
              '#((|FiniteSetAggregate| 22) (|Dictionary| 22)
                 (|DictionaryOperations| 22) (|SetAggregate| 22)
                 (|BagAggregate| 22) (|Collection| 22) (|Finite|)
                 (|HomogeneousAggregate| 22) (|Comparable|) (|SetCategory|)
                 (|Aggregate|) (|Evalable| 22) (|ConvertibleTo| 30)
                 (|finiteAggregate|) (|PartialOrder|) (|BasicType|)
                 (|shallowlyMutable|) (|Type|) (|ConvertibleTo| 8)
                 (|CoercibleTo| 42) (|InnerEvalable| 22 22)
                 (|ConvertibleTo| 62))
              (|makeByteWordVec2| 69
                                  '(2 6 17 0 0 18 2 6 17 0 20 21 2 6 0 0 0 24 2
                                    6 0 0 0 25 1 6 0 0 27 1 8 0 30 32 1 22 0 20
                                    34 2 6 0 35 17 36 1 8 20 0 37 1 8 20 0 38 2
                                    8 22 0 20 39 3 6 17 0 20 17 40 1 8 42 0 43
                                    2 6 0 0 17 55 3 6 0 0 0 20 56 2 0 17 0 0 1
                                    0 0 0 12 0 3 0 1 2 0 0 0 22 1 2 0 0 22 0 1
                                    2 0 0 0 0 14 2 0 0 0 0 1 2 0 17 0 0 1 2 2
                                    17 0 0 1 2 0 17 0 35 1 0 3 35 1 0 0 0 47 1
                                    0 0 30 1 2 9 0 65 0 1 2 9 0 65 0 1 0 0 0 1
                                    1 10 0 0 1 2 10 0 22 0 49 2 9 0 65 0 1 2 10
                                    0 22 0 1 2 9 0 65 0 1 4 10 22 61 0 22 22 1
                                    3 9 22 61 0 22 1 2 9 22 61 0 1 0 3 0 1 1 9
                                    30 0 58 2 0 17 0 35 1 1 11 22 0 1 1 9 30 0
                                    1 2 10 17 22 0 23 1 11 22 0 1 2 9 22 66 0 1
                                    2 8 0 52 0 57 2 0 0 52 0 53 0 0 0 13 1 3 64
                                    0 1 2 0 17 0 35 1 1 0 8 0 1 2 0 0 0 0 26 1
                                    0 22 0 50 2 0 0 22 0 48 1 3 0 64 1 0 0 0 11
                                    2 0 69 69 0 1 1 0 68 0 1 2 0 67 65 0 1 1 0
                                    22 0 51 2 9 17 65 0 1 2 4 0 0 59 1 2 4 0 0
                                    60 1 3 4 0 0 22 22 1 3 4 0 0 30 30 1 2 0 17
                                    0 0 1 0 3 63 1 1 0 17 0 1 0 0 0 46 0 0 0 10
                                    2 0 0 0 0 28 2 0 0 0 22 1 1 0 0 30 1 0 0 0
                                    1 2 10 35 22 0 1 2 9 35 65 0 1 1 0 0 0 1 1
                                    1 62 0 1 1 0 30 0 31 1 0 8 0 33 1 0 0 30 1
                                    1 3 0 0 29 1 0 42 0 44 1 0 0 30 41 1 0 0 8
                                    9 1 0 35 0 1 2 9 17 65 0 1 0 0 0 16 0 0 0
                                    15 2 0 17 0 0 1 2 0 17 0 0 1 2 0 17 0 0 19
                                    2 0 17 0 0 1 2 0 17 0 0 1 1 9 35 0 45)))))
           '|lookupComplete|)) 

(MAKEPROP '|CharacterClass| 'NILADIC T) 
