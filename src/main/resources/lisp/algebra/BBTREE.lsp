
(SDEFUN |BBTREE;setleaves!;$L$;1| ((|t| ($)) (|u| (|List| S)) ($ ($)))
        (SPROG
         ((|acc| (|List| S)) (#1=#:G721 NIL) (|i| NIL)
          (|m| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |u|))
              (EXIT
               (COND
                ((EQL |n| 0)
                 (COND ((SPADCALL |t| (QREFELT $ 9)) |t|)
                       (#2='T
                        (|error|
                         "the tree and list must have the same number of elements"))))
                ((EQL |n| 1)
                 (SEQ (SPADCALL |t| (|SPADfirst| |u|) (QREFELT $ 10))
                      (EXIT |t|)))
                (#2#
                 (SEQ (LETT |m| (QUOTIENT2 |n| 2)) (LETT |acc| NIL)
                      (SEQ (LETT |i| 1) (LETT #1# |m|) G190
                           (COND ((|greater_SI| |i| #1#) (GO G191)))
                           (SEQ (LETT |acc| (CONS (|SPADfirst| |u|) |acc|))
                                (EXIT (LETT |u| (CDR |u|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (SPADCALL (SPADCALL |t| (QREFELT $ 11)) (NREVERSE |acc|)
                                (QREFELT $ 13))
                      (SPADCALL (SPADCALL |t| (QREFELT $ 14)) |u|
                                (QREFELT $ 13))
                      (EXIT |t|)))))))) 

(SDEFUN |BBTREE;balancedBinaryTree;NniS$;2|
        ((|n| (|NonNegativeInteger|)) (|val| (S)) ($ ($)))
        (SPROG ((|m| (|NonNegativeInteger|)))
               (SEQ
                (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 15)))
                      ((EQL |n| 1)
                       (SPADCALL (SPADCALL (QREFELT $ 15)) |val|
                                 (SPADCALL (QREFELT $ 15)) (QREFELT $ 16)))
                      ('T
                       (SEQ (LETT |m| (QUOTIENT2 |n| 2))
                            (EXIT
                             (SPADCALL (SPADCALL |m| |val| (QREFELT $ 18))
                                       |val|
                                       (SPADCALL (- |n| |m|) |val|
                                                 (QREFELT $ 18))
                                       (QREFELT $ 16))))))))) 

(SDEFUN |BBTREE;mapUp!;$MS;3| ((|x| ($)) (|fn| (|Mapping| S S S)) ($ (S)))
        (COND
         ((SPADCALL |x| (QREFELT $ 9))
          (|error| "mapUp! called on a null tree"))
         ((SPADCALL |x| (QREFELT $ 19)) (SPADCALL |x| '|value| (QREFELT $ 21)))
         ('T
          (SPADCALL |x| '|value|
                    (SPADCALL
                     (SPADCALL (SPADCALL |x| '|left| (QREFELT $ 23)) |fn|
                               (QREFELT $ 25))
                     (SPADCALL (SPADCALL |x| '|right| (QREFELT $ 27)) |fn|
                               (QREFELT $ 25))
                     |fn|)
                    (QREFELT $ 28))))) 

(SDEFUN |BBTREE;mapUp!;2$M$;4|
        ((|x| ($)) (|y| ($)) (|fn| (|Mapping| S S S S S)) ($ ($)))
        (SEQ
         (COND
          ((OR (SPADCALL |x| (QREFELT $ 9)) (SPADCALL |y| (QREFELT $ 9)))
           (|error| "mapUp! is called on a null tree"))
          ('T
           (COND
            ((SPADCALL |x| (QREFELT $ 19))
             (COND ((SPADCALL |y| (QREFELT $ 19)) |x|)
                   (#1='T (|error| "balanced binary trees are incompatible"))))
            ((SPADCALL |y| (QREFELT $ 19))
             (|error| "balanced binary trees are incompatible"))
            (#1#
             (SEQ
              (SPADCALL (SPADCALL |x| '|left| (QREFELT $ 23))
                        (SPADCALL |y| '|left| (QREFELT $ 23)) |fn|
                        (QREFELT $ 30))
              (SPADCALL (SPADCALL |x| '|right| (QREFELT $ 27))
                        (SPADCALL |y| '|right| (QREFELT $ 27)) |fn|
                        (QREFELT $ 30))
              (SPADCALL |x| '|value|
                        (SPADCALL
                         (SPADCALL (SPADCALL |x| '|left| (QREFELT $ 23))
                                   '|value| (QREFELT $ 21))
                         (SPADCALL (SPADCALL |x| '|right| (QREFELT $ 27))
                                   '|value| (QREFELT $ 21))
                         (SPADCALL (SPADCALL |y| '|left| (QREFELT $ 23))
                                   '|value| (QREFELT $ 21))
                         (SPADCALL (SPADCALL |y| '|right| (QREFELT $ 27))
                                   '|value| (QREFELT $ 21))
                         |fn|)
                        (QREFELT $ 28))
              (EXIT |x|)))))))) 

(SDEFUN |BBTREE;mapDown!;$SM$;5|
        ((|x| ($)) (|p| (S)) (|fn| (|Mapping| S S S)) ($ ($)))
        (SEQ
         (COND ((SPADCALL |x| (QREFELT $ 9)) |x|)
               ('T
                (SEQ
                 (SPADCALL |x| '|value|
                           (SPADCALL |p| (SPADCALL |x| '|value| (QREFELT $ 21))
                                     |fn|)
                           (QREFELT $ 28))
                 (SPADCALL (SPADCALL |x| '|left| (QREFELT $ 23))
                           (SPADCALL |x| '|value| (QREFELT $ 21)) |fn|
                           (QREFELT $ 31))
                 (SPADCALL (SPADCALL |x| '|right| (QREFELT $ 27))
                           (SPADCALL |x| '|value| (QREFELT $ 21)) |fn|
                           (QREFELT $ 31))
                 (EXIT |x|)))))) 

(SDEFUN |BBTREE;mapDown!;$SM$;6|
        ((|x| ($)) (|p| (S)) (|fn| (|Mapping| (|List| S) S S S)) ($ ($)))
        (SPROG ((|u| (|List| S)))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 9)) |x|)
                      (#1='T
                       (SEQ (SPADCALL |x| '|value| |p| (QREFELT $ 28))
                            (EXIT
                             (COND ((SPADCALL |x| (QREFELT $ 19)) |x|)
                                   (#1#
                                    (SEQ
                                     (LETT |u|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |x| '|left|
                                                       (QREFELT $ 23))
                                             '|value| (QREFELT $ 21))
                                            (SPADCALL
                                             (SPADCALL |x| '|right|
                                                       (QREFELT $ 27))
                                             '|value| (QREFELT $ 21))
                                            |p| |fn|))
                                     (SPADCALL
                                      (SPADCALL |x| '|left| (QREFELT $ 23))
                                      (SPADCALL |u| 1 (QREFELT $ 33)) |fn|
                                      (QREFELT $ 35))
                                     (SPADCALL
                                      (SPADCALL |x| '|right| (QREFELT $ 27))
                                      (SPADCALL |u| 2 (QREFELT $ 33)) |fn|
                                      (QREFELT $ 35))
                                     (EXIT |x|))))))))))) 

(DECLAIM (NOTINLINE |BalancedBinaryTree;|)) 

(DEFUN |BalancedBinaryTree| (#1=#:G781)
  (SPROG NIL
         (PROG (#2=#:G782)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|BalancedBinaryTree|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|BalancedBinaryTree;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BalancedBinaryTree|)))))))))) 

(DEFUN |BalancedBinaryTree;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G778 NIL) (#2=#:G779 NIL) (#3=#:G780 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|BalancedBinaryTree| DV$1))
    (LETT $ (GETREFV 49))
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
    (|haddProp| |$ConstructorCache| '|BalancedBinaryTree| (LIST DV$1)
                (CONS 1 $))
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

(MAKEPROP '|BalancedBinaryTree| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|BinaryTree| 6) (|local| |#1|) '|Rep|
              (|Boolean|) (0 . |empty?|) (5 . |setvalue!|) (11 . |left|)
              (|List| 6) |BBTREE;setleaves!;$L$;1| (16 . |right|)
              (21 . |empty|) (25 . |node|) (|NonNegativeInteger|)
              |BBTREE;balancedBinaryTree;NniS$;2| (32 . |leaf?|) '|value|
              (37 . |elt|) '|left| (43 . |elt|) (|Mapping| 6 6 6)
              |BBTREE;mapUp!;$MS;3| '|right| (49 . |elt|) (55 . |setelt!|)
              (|Mapping| 6 6 6 6 6) |BBTREE;mapUp!;2$M$;4|
              |BBTREE;mapDown!;$SM$;5| (|Integer|) (62 . |elt|)
              (|Mapping| 12 6 6 6) |BBTREE;mapDown!;$SM$;6| (|List| 37)
              (|Equation| 6) (|Mapping| 8 6 6) (|Mapping| 8 6) '"right" '"left"
              '"value" (|List| $) (|Mapping| 6 6) (|OutputForm|)
              (|SingleInteger|) (|String|) (|HashState|))
           '#(~= 68 |value| 74 |size?| 79 |setvalue!| 85 |setright!| 91
              |setleft!| 97 |setleaves!| 103 |setelt!| 109 |setchildren!| 130
              |sample| 136 |right| 140 |parts| 145 |nodes| 150 |node?| 155
              |node| 161 |more?| 168 |min| 174 |members| 179 |member?| 184
              |max| 190 |mapUp!| 201 |mapDown!| 214 |map!| 228 |map| 234
              |less?| 240 |left| 246 |leaves| 251 |leaf?| 256 |latex| 261
              |hashUpdate!| 266 |hash| 272 |every?| 277 |eval| 283 |eq?| 309
              |empty?| 315 |empty| 320 |elt| 324 |distance| 342 |cyclic?| 348
              |count| 353 |copy| 365 |coerce| 370 |children| 375 |child?| 380
              |balancedBinaryTree| 386 |any?| 392 = 398 |#| 404)
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
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 45))
                   (|makeByteWordVec2| 48
                                       '(1 0 8 0 9 2 0 6 0 6 10 1 0 0 0 11 1 0
                                         0 0 14 0 0 0 15 3 0 0 0 6 0 16 1 0 8 0
                                         19 2 0 6 0 20 21 2 0 0 0 22 23 2 0 0 0
                                         26 27 3 0 6 0 20 6 28 2 12 6 0 32 33 2
                                         11 8 0 0 1 1 0 6 0 1 2 0 8 0 17 1 2 12
                                         6 0 6 10 2 12 0 0 0 1 2 12 0 0 0 1 2 0
                                         0 0 12 13 3 12 0 0 40 0 1 3 12 0 0 41
                                         0 1 3 12 6 0 42 6 1 2 12 0 0 43 1 0 0
                                         0 1 1 0 0 0 14 1 8 12 0 1 1 0 43 0 1 2
                                         4 8 0 0 1 3 0 0 0 6 0 16 2 0 8 0 17 1
                                         1 9 6 0 1 1 8 12 0 1 2 10 8 6 0 1 1 9
                                         6 0 1 2 8 6 38 0 1 3 0 0 0 0 29 30 2 0
                                         6 0 24 25 3 0 0 0 6 34 35 3 0 0 0 6 24
                                         31 2 12 0 44 0 1 2 0 0 44 0 1 2 0 8 0
                                         17 1 1 0 0 0 11 1 0 12 0 1 1 0 8 0 19
                                         1 1 47 0 1 2 1 48 48 0 1 1 1 46 0 1 2
                                         8 8 39 0 1 3 2 0 0 6 6 1 3 2 0 0 12 12
                                         1 2 2 0 0 36 1 2 2 0 0 37 1 2 0 8 0 0
                                         1 1 0 8 0 9 0 0 0 15 2 0 0 0 40 1 2 0
                                         0 0 41 1 2 0 6 0 42 1 2 0 32 0 0 1 1 0
                                         8 0 1 2 10 17 6 0 1 2 8 17 39 0 1 1 0
                                         0 0 1 1 6 45 0 1 1 0 43 0 1 2 4 8 0 0
                                         1 2 0 0 17 6 18 2 8 8 39 0 1 2 11 8 0
                                         0 1 1 8 17 0 1)))))
           '|lookupComplete|)) 
