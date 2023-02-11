
(SDEFUN |BTOURN;binaryTournament;L$;1| ((|u| (|List| S)) ($ ($)))
        (SPROG ((#1=#:G706 NIL) (|x| NIL) (|tree| ($)))
               (SEQ
                (COND ((NULL |u|) (SPADCALL (QREFELT $ 8)))
                      ('T
                       (SEQ
                        (LETT |tree|
                              (SPADCALL (|SPADfirst| |u|) (QREFELT $ 9)))
                        (SEQ (LETT |x| NIL) (LETT #1# (CDR |u|)) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (SPADCALL |x| |tree| (QREFELT $ 10))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT |tree|))))))) 

(SDEFUN |BTOURN;insert!;S2$;2| ((|x| (S)) (|t| ($)) ($ ($)))
        (SEQ
         (COND ((SPADCALL |t| (QREFELT $ 14)) (SPADCALL |x| (QREFELT $ 9)))
               ((SPADCALL |x| (SPADCALL |t| (QREFELT $ 15)) (QREFELT $ 16))
                (SEQ
                 (SPADCALL |t| (SPADCALL |t| (QREFELT $ 17)) (QREFELT $ 18))
                 (SPADCALL |t| |x| (QREFELT $ 19))
                 (EXIT
                  (SPADCALL |t| (SPADCALL (QREFELT $ 8)) (QREFELT $ 20)))))
               ('T
                (SEQ
                 (SPADCALL |t|
                           (SPADCALL |x| (SPADCALL |t| (QREFELT $ 21))
                                     (QREFELT $ 10))
                           (QREFELT $ 20))
                 (EXIT |t|)))))) 

(DECLAIM (NOTINLINE |BinaryTournament;|)) 

(DEFUN |BinaryTournament| (#1=#:G721)
  (SPROG NIL
         (PROG (#2=#:G722)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|BinaryTournament|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|BinaryTournament;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BinaryTournament|)))))))))) 

(DEFUN |BinaryTournament;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G718 NIL) (#2=#:G719 NIL) (#3=#:G720 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|BinaryTournament| DV$1))
    (LETT $ (GETREFV 37))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #3#)
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|BasicType|)))
                                        (OR #2# #3#)
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #1#
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #3#))))))
    (|haddProp| |$ConstructorCache| '|BinaryTournament| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 128))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 256))
    (AND #2# (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 512))
    (AND (OR (AND #2# (|HasCategory| $ '(|finiteAggregate|))) #3#)
         (|augmentPredVector| $ 1024))
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 2048))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 (|BinaryTree| |#1|))
    $))) 

(MAKEPROP '|BinaryTournament| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|BinaryTree| 6) (|local| |#1|) '|Rep|
              (0 . |empty|) (4 . |binaryTree|) |BTOURN;insert!;S2$;2|
              (|List| 6) |BTOURN;binaryTournament;L$;1| (|Boolean|)
              (9 . |empty?|) (14 . |value|) (19 . >) (25 . |copy|)
              (30 . |setleft!|) (36 . |setvalue!|) (42 . |setright!|)
              (48 . |right|) (|NonNegativeInteger|) (|List| 24) (|Equation| 6)
              (|Mapping| 13 6 6) (|Mapping| 13 6) '"right" '"left" '"value"
              (|List| $) (|Mapping| 6 6) (|OutputForm|) (|SingleInteger|)
              (|String|) (|HashState|) (|Integer|))
           '#(~= 53 |value| 59 |size?| 64 |setvalue!| 70 |setright!| 76
              |setleft!| 82 |setelt!| 88 |setchildren!| 109 |sample| 115
              |right| 119 |parts| 124 |nodes| 129 |node?| 134 |node| 140
              |more?| 147 |min| 153 |members| 158 |member?| 163 |max| 169
              |map!| 180 |map| 186 |less?| 192 |left| 198 |leaves| 203 |leaf?|
              208 |latex| 213 |insert!| 218 |hashUpdate!| 224 |hash| 230
              |every?| 235 |eval| 241 |eq?| 267 |empty?| 273 |empty| 278 |elt|
              282 |distance| 300 |cyclic?| 306 |count| 311 |copy| 323 |coerce|
              328 |children| 333 |child?| 338 |binaryTournament| 344 |any?| 349
              = 355 |#| 361)
           'NIL
           (CONS (|makeByteWordVec2| 7 '(0 0 0 0 0 2 1 0 0 0 2 5 7))
                 (CONS
                  '#(|BinaryTreeCategory&| |BinaryRecursiveAggregate&|
                     |RecursiveAggregate&| |HomogeneousAggregate&| |Aggregate&|
                     |Evalable&| |SetCategory&| NIL NIL NIL |InnerEvalable&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|BinaryTreeCategory| 6) (|BinaryRecursiveAggregate| 6)
                      (|RecursiveAggregate| 6) (|HomogeneousAggregate| 6)
                      (|Aggregate|) (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 32))
                   (|makeByteWordVec2| 36
                                       '(0 0 0 8 1 7 0 6 9 1 0 13 0 14 1 0 6 0
                                         15 2 6 13 0 0 16 1 0 0 0 17 2 0 0 0 0
                                         18 2 0 6 0 6 19 2 0 0 0 0 20 1 0 0 0
                                         21 2 11 13 0 0 1 1 0 6 0 15 2 0 13 0
                                         22 1 2 12 6 0 6 19 2 12 0 0 0 20 2 12
                                         0 0 0 18 3 12 0 0 27 0 1 3 12 0 0 28 0
                                         1 3 12 6 0 29 6 1 2 12 0 0 30 1 0 0 0
                                         1 1 0 0 0 21 1 8 11 0 1 1 0 30 0 1 2 4
                                         13 0 0 1 3 0 0 0 6 0 1 2 0 13 0 22 1 1
                                         9 6 0 1 1 8 11 0 1 2 10 13 6 0 1 1 9 6
                                         0 1 2 8 6 25 0 1 2 12 0 31 0 1 2 0 0
                                         31 0 1 2 0 13 0 22 1 1 0 0 0 1 1 0 11
                                         0 1 1 0 13 0 1 1 1 34 0 1 2 0 0 6 0 10
                                         2 1 35 35 0 1 1 1 33 0 1 2 8 13 26 0 1
                                         3 2 0 0 6 6 1 3 2 0 0 11 11 1 2 2 0 0
                                         23 1 2 2 0 0 24 1 2 0 13 0 0 1 1 0 13
                                         0 14 0 0 0 8 2 0 0 0 27 1 2 0 0 0 28 1
                                         2 0 6 0 29 1 2 0 36 0 0 1 1 0 13 0 1 2
                                         10 22 6 0 1 2 8 22 26 0 1 1 0 0 0 17 1
                                         6 32 0 1 1 0 30 0 1 2 4 13 0 0 1 1 0 0
                                         11 12 2 8 13 26 0 1 2 11 13 0 0 1 1 8
                                         22 0 1)))))
           '|lookupComplete|)) 
