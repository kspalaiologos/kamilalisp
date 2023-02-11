
(SDEFUN |PRODUCT;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL
         (LIST (SPADCALL (QCAR |x|) (QREFELT $ 10))
               (SPADCALL (QCDR |x|) (QREFELT $ 11)))
         (QREFELT $ 13))) 

(SDEFUN |PRODUCT;=;2$B;2| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 16))
          (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 17)))
         ('T NIL))) 

(PUT '|PRODUCT;construct;AB$;3| '|SPADreplace| 'CONS) 

(SDEFUN |PRODUCT;construct;AB$;3| ((|a| (A)) (|b| (B)) ($ ($))) (CONS |a| |b|)) 

(PUT '|PRODUCT;first;$A;4| '|SPADreplace| 'QCAR) 

(SDEFUN |PRODUCT;first;$A;4| ((|x| ($)) ($ (A))) (QCAR |x|)) 

(PUT '|PRODUCT;second;$B;5| '|SPADreplace| 'QCDR) 

(SDEFUN |PRODUCT;second;$B;5| ((|x| ($)) ($ (B))) (QCDR |x|)) 

(SDEFUN |PRODUCT;One;$;6| (($ ($)))
        (SPADCALL (|spadConstant| $ 22) (|spadConstant| $ 23) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;*;3$;7| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 25))
                  (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 26))
                  (QREFELT $ 19))) 

(SDEFUN |PRODUCT;^;$Nni$;8| ((|x| ($)) (|p| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) |p| (QREFELT $ 29))
                  (SPADCALL (QCDR |x|) |p| (QREFELT $ 30)) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;size;Nni;9| (($ (|NonNegativeInteger|)))
        (* (SPADCALL (QREFELT $ 32)) (SPADCALL (QREFELT $ 33)))) 

(SDEFUN |PRODUCT;index;Pi$;10| ((|n| (|PositiveInteger|)) ($ ($)))
        (SPROG ((#1=#:G715 NIL) (#2=#:G714 NIL))
               (SPADCALL
                (SPADCALL
                 (PROG1
                     (LETT #2#
                           (+ (QUOTIENT2 (- |n| 1) (SPADCALL (QREFELT $ 33)))
                              1))
                   (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                     '(|Integer|) #2#))
                 (QREFELT $ 36))
                (SPADCALL
                 (PROG1
                     (LETT #1# (+ (REM (- |n| 1) (SPADCALL (QREFELT $ 33))) 1))
                   (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                     '(|Integer|) #1#))
                 (QREFELT $ 37))
                (QREFELT $ 19)))) 

(SDEFUN |PRODUCT;random;$;11| (($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 39)) (SPADCALL (QREFELT $ 40))
                  (QREFELT $ 19))) 

(SDEFUN |PRODUCT;lookup;$Pi;12| ((|x| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G719 NIL))
               (PROG1
                   (LETT #1#
                         (+
                          (* (- (SPADCALL (QCAR |x|) (QREFELT $ 42)) 1)
                             (SPADCALL (QREFELT $ 33)))
                          (SPADCALL (QCDR |x|) (QREFELT $ 43))))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                   #1#)))) 

(SDEFUN |PRODUCT;hashUpdate!;Hs$Hs;13|
        ((|s| (|HashState|)) (|x| ($)) ($ (|HashState|)))
        (SPADCALL (SPADCALL |s| (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 46))
                  (SPADCALL |x| (QREFELT $ 21)) (QREFELT $ 47))) 

(SDEFUN |PRODUCT;inv;2$;14| ((|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QREFELT $ 49))
                  (SPADCALL (QCDR |x|) (QREFELT $ 50)) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;Zero;$;15| (($ ($)))
        (SPADCALL (|spadConstant| $ 52) (|spadConstant| $ 53) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;+;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 55))
                  (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 56))
                  (QREFELT $ 19))) 

(SDEFUN |PRODUCT;*;Nni2$;17| ((|c| (|NonNegativeInteger|)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |c| (QCAR |x|) (QREFELT $ 58))
                  (SPADCALL |c| (QCDR |x|) (QREFELT $ 59)) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;subtractIfCan;2$U;18|
        ((|x| ($)) (|y| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|nb| (|Union| B #1="failed")) (|na| (|Union| A #1#)))
               (SEQ (LETT |na| (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 62)))
                    (EXIT
                     (COND ((QEQCAR |na| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |nb|
                                   (SPADCALL (QCDR |x|) (QCDR |y|)
                                             (QREFELT $ 63)))
                             (EXIT
                              (COND ((QEQCAR |nb| 1) (CONS 1 "failed"))
                                    (#2#
                                     (CONS 0
                                           (SPADCALL (QCDR |na|) (QCDR |nb|)
                                                     (QREFELT $ 19))))))))))))) 

(SDEFUN |PRODUCT;-;2$;19| ((|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QREFELT $ 65))
                  (SPADCALL (QCDR |x|) (QREFELT $ 66)) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;-;3$;20| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 68))
                  (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 69))
                  (QREFELT $ 19))) 

(SDEFUN |PRODUCT;*;I2$;21| ((|d| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |d| (QCAR |x|) (QREFELT $ 72))
                  (SPADCALL |d| (QCDR |x|) (QREFELT $ 73)) (QREFELT $ 19))) 

(SDEFUN |PRODUCT;sup;3$;22| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 75))
                  (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 76))
                  (QREFELT $ 19))) 

(SDEFUN |PRODUCT;<;2$B;23| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|yb| (B)) (|xb| (B)) (|ya| (A)) (|xa| (A)))
               (SEQ (LETT |xa| (QCAR |x|)) (LETT |ya| (QCAR |y|))
                    (EXIT
                     (COND ((SPADCALL |xa| |ya| (QREFELT $ 78)) 'T)
                           (#1='T
                            (SEQ (LETT |xb| (QCDR |x|)) (LETT |yb| (QCDR |y|))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |xa| |ya| (QREFELT $ 16))
                                    (SPADCALL |xb| |yb| (QREFELT $ 79)))
                                   (#1# NIL)))))))))) 

(SDEFUN |PRODUCT;smaller?;2$B;24| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|yb| (B)) (|xb| (B)) (|ya| (A)) (|xa| (A)))
               (SEQ (LETT |xa| (QCAR |x|)) (LETT |ya| (QCAR |y|))
                    (EXIT
                     (COND ((SPADCALL |xa| |ya| (QREFELT $ 81)) 'T)
                           (#1='T
                            (SEQ (LETT |xb| (QCDR |x|)) (LETT |yb| (QCDR |y|))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |xa| |ya| (QREFELT $ 16))
                                    (SPADCALL |xb| |yb| (QREFELT $ 82)))
                                   (#1# NIL)))))))))) 

(DECLAIM (NOTINLINE |Product;|)) 

(DEFUN |Product| (&REST #1=#:G755)
  (SPROG NIL
         (PROG (#2=#:G756)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|Product|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |Product;|) #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Product|)))))))))) 

(DEFUN |Product;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G752 NIL) (#2=#:G753 NIL) (#3=#:G754 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|Product| DV$1 DV$2))
    (LETT $ (GETREFV 87))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #3#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|OrderedAbelianMonoidSup|))
                                               (|HasCategory| |#2|
                                                              '(|OrderedAbelianMonoidSup|))))
                                        (OR #3#
                                            (AND
                                             (|HasCategory| |#1|
                                                            '(|OrderedSet|))
                                             (|HasCategory| |#2|
                                                            '(|OrderedSet|))))
                                        (LETT #2#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|AbelianGroup|))
                                               (|HasCategory| |#2|
                                                              '(|AbelianGroup|))))
                                        (OR #2#
                                            (AND
                                             (|HasCategory| |#1|
                                                            '(|CancellationAbelianMonoid|))
                                             (|HasCategory| |#2|
                                                            '(|CancellationAbelianMonoid|)))
                                            #3#)
                                        (OR #2#
                                            (AND
                                             (|HasCategory| |#1|
                                                            '(|AbelianMonoid|))
                                             (|HasCategory| |#2|
                                                            '(|AbelianMonoid|)))
                                            (AND
                                             (|HasCategory| |#1|
                                                            '(|CancellationAbelianMonoid|))
                                             (|HasCategory| |#2|
                                                            '(|CancellationAbelianMonoid|)))
                                            #3#)
                                        (AND (|HasCategory| |#1| '(|Group|))
                                             (|HasCategory| |#2| '(|Group|)))
                                        (OR
                                         (AND (|HasCategory| |#1| '(|Group|))
                                              (|HasCategory| |#2| '(|Group|)))
                                         (AND (|HasCategory| |#1| '(|Monoid|))
                                              (|HasCategory| |#2|
                                                             '(|Monoid|))))
                                        (LETT #1#
                                              (AND
                                               (|HasCategory| |#1| '(|Finite|))
                                               (|HasCategory| |#2|
                                                              '(|Finite|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          (|HasCategory| |#2| '(|Comparable|)))
                                         #1# #3#
                                         (AND
                                          (|HasCategory| |#1| '(|OrderedSet|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR #2#
                                            (AND
                                             (|HasCategory| |#1|
                                                            '(|AbelianMonoid|))
                                             (|HasCategory| |#2|
                                                            '(|AbelianMonoid|)))
                                            (AND
                                             (|HasCategory| |#1|
                                                            '(|CancellationAbelianMonoid|))
                                             (|HasCategory| |#2|
                                                            '(|CancellationAbelianMonoid|)))
                                            (AND
                                             (|HasCategory| |#1| '(|Group|))
                                             (|HasCategory| |#2| '(|Group|)))
                                            (AND
                                             (|HasCategory| |#1| '(|Monoid|))
                                             (|HasCategory| |#2| '(|Monoid|)))
                                            #3#)))))
    (|haddProp| |$ConstructorCache| '|Product| (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|Record| (|:| |acomp| |#1|) (|:| |bcomp| |#2|)))
    (COND
     ((|HasCategory| |#1| '(|Monoid|))
      (COND
       ((|HasCategory| |#2| '(|Monoid|))
        (PROGN
         (QSETREFV $ 24
                   (CONS #'|makeSpadConstant|
                         (LIST (|dispatchFunction| |PRODUCT;One;$;6|) $ 24)))
         (QSETREFV $ 27 (CONS (|dispatchFunction| |PRODUCT;*;3$;7|) $))
         (QSETREFV $ 31 (CONS (|dispatchFunction| |PRODUCT;^;$Nni$;8|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|Finite|))
      (COND
       ((|HasCategory| |#2| '(|Finite|))
        (PROGN
         (QSETREFV $ 34 (CONS (|dispatchFunction| |PRODUCT;size;Nni;9|) $))
         (QSETREFV $ 38 (CONS (|dispatchFunction| |PRODUCT;index;Pi$;10|) $))
         (QSETREFV $ 41 (CONS (|dispatchFunction| |PRODUCT;random;$;11|) $))
         (QSETREFV $ 44 (CONS (|dispatchFunction| |PRODUCT;lookup;$Pi;12|) $))
         (QSETREFV $ 48
                   (CONS (|dispatchFunction| |PRODUCT;hashUpdate!;Hs$Hs;13|)
                         $)))))))
    (COND
     ((|HasCategory| |#1| '(|Group|))
      (COND
       ((|HasCategory| |#2| '(|Group|))
        (QSETREFV $ 51 (CONS (|dispatchFunction| |PRODUCT;inv;2$;14|) $))))))
    (COND
     ((|HasCategory| |#1| '(|AbelianMonoid|))
      (COND
       ((|HasCategory| |#2| '(|AbelianMonoid|))
        (PROGN
         (QSETREFV $ 54
                   (CONS #'|makeSpadConstant|
                         (LIST (|dispatchFunction| |PRODUCT;Zero;$;15|) $ 54)))
         (QSETREFV $ 57 (CONS (|dispatchFunction| |PRODUCT;+;3$;16|) $))
         (QSETREFV $ 60
                   (CONS (|dispatchFunction| |PRODUCT;*;Nni2$;17|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|CancellationAbelianMonoid|))
      (COND
       ((|HasCategory| |#2| '(|CancellationAbelianMonoid|))
        (QSETREFV $ 64
                  (CONS (|dispatchFunction| |PRODUCT;subtractIfCan;2$U;18|)
                        $))))))
    (COND
     ((|HasCategory| |#1| '(|AbelianGroup|))
      (COND
       ((|HasCategory| |#2| '(|AbelianGroup|))
        (PROGN
         (QSETREFV $ 67 (CONS (|dispatchFunction| |PRODUCT;-;2$;19|) $))
         (QSETREFV $ 70 (CONS (|dispatchFunction| |PRODUCT;-;3$;20|) $))
         (QSETREFV $ 74 (CONS (|dispatchFunction| |PRODUCT;*;I2$;21|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|OrderedAbelianMonoidSup|))
      (COND
       ((|HasCategory| |#2| '(|OrderedAbelianMonoidSup|))
        (QSETREFV $ 77 (CONS (|dispatchFunction| |PRODUCT;sup;3$;22|) $))))))
    (COND
     ((|HasCategory| |#1| '(|OrderedSet|))
      (COND
       ((|HasCategory| |#2| '(|OrderedSet|))
        (QSETREFV $ 80 (CONS (|dispatchFunction| |PRODUCT;<;2$B;23|) $))))))
    (COND
     ((|HasCategory| |#1| '(|Comparable|))
      (COND
       ((|HasCategory| |#2| '(|Comparable|))
        (QSETREFV $ 83
                  (CONS (|dispatchFunction| |PRODUCT;smaller?;2$B;24|) $))))))
    $))) 

(MAKEPROP '|Product| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|OutputForm|) (0 . |coerce|) (5 . |coerce|) (|List| $)
              (10 . |bracket|) |PRODUCT;coerce;$Of;1| (|Boolean|) (15 . =)
              (21 . =) |PRODUCT;=;2$B;2| |PRODUCT;construct;AB$;3|
              |PRODUCT;first;$A;4| |PRODUCT;second;$B;5| (27 . |One|)
              (31 . |One|) (35 . |One|) (39 . *) (45 . *) (51 . *)
              (|NonNegativeInteger|) (57 . ^) (63 . ^) (69 . ^) (75 . |size|)
              (79 . |size|) (83 . |size|) (|PositiveInteger|) (87 . |index|)
              (92 . |index|) (97 . |index|) (102 . |random|) (106 . |random|)
              (110 . |random|) (114 . |lookup|) (119 . |lookup|)
              (124 . |lookup|) (|HashState|) (129 . |hashUpdate!|)
              (135 . |hashUpdate!|) (141 . |hashUpdate!|) (147 . |inv|)
              (152 . |inv|) (157 . |inv|) (162 . |Zero|) (166 . |Zero|)
              (170 . |Zero|) (174 . +) (180 . +) (186 . +) (192 . *) (198 . *)
              (204 . *) (|Union| $ '"failed") (210 . |subtractIfCan|)
              (216 . |subtractIfCan|) (222 . |subtractIfCan|) (228 . -)
              (233 . -) (238 . -) (243 . -) (249 . -) (255 . -) (|Integer|)
              (261 . *) (267 . *) (273 . *) (279 . |sup|) (285 . |sup|)
              (291 . |sup|) (297 . <) (303 . <) (309 . <) (315 . |smaller?|)
              (321 . |smaller?|) (327 . |smaller?|) (|InputForm|) (|String|)
              (|SingleInteger|))
           '#(~= 333 |zero?| 339 |sup| 344 |subtractIfCan| 350 |smaller?| 356
              |size| 362 |second| 366 |sample| 371 |rightRecip| 375
              |rightPower| 380 |recip| 392 |random| 397 |opposite?| 401 |one?|
              407 |min| 412 |max| 418 |lookup| 424 |leftRecip| 429 |leftPower|
              434 |latex| 446 |inv| 451 |inf| 456 |index| 462 |hashUpdate!| 467
              |hash| 473 |first| 478 |enumerate| 483 |convert| 487 |construct|
              492 |conjugate| 498 |commutator| 504 |coerce| 510 ^ 515 |Zero|
              533 |One| 537 >= 541 > 547 = 553 <= 559 < 565 / 571 - 577 + 588 *
              594)
           'NIL
           (CONS
            (|makeByteWordVec2| 9
                                '(1 1 1 3 6 1 4 7 2 5 7 7 8 9 5 7 0 0 0 2 6 6
                                  8))
            (CONS
             '#(NIL NIL NIL |AbelianGroup&| |Group&| NIL NIL NIL |OrderedSet&|
                |AbelianMonoid&| NIL |MagmaWithUnit&| |Finite&| NIL
                |AbelianSemiGroup&| |Magma&| |SetCategory&| |BasicType&| NIL
                |PartialOrder&| NIL NIL NIL)
             (CONS
              '#((|OrderedAbelianMonoidSup|)
                 (|OrderedCancellationAbelianMonoid|) (|OrderedAbelianMonoid|)
                 (|AbelianGroup|) (|Group|) (|OrderedAbelianSemiGroup|)
                 (|CancellationAbelianMonoid|) (|Monoid|) (|OrderedSet|)
                 (|AbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|) (|Finite|)
                 (|Comparable|) (|AbelianSemiGroup|) (|Magma|) (|SetCategory|)
                 (|BasicType|) (|CoercibleTo| 9) (|PartialOrder|)
                 (|TwoSidedRecip|) (|unitsKnown|) (|ConvertibleTo| 84))
              (|makeByteWordVec2| 86
                                  '(1 6 9 0 10 1 7 9 0 11 1 9 0 12 13 2 6 15 0
                                    0 16 2 7 15 0 0 17 0 6 0 22 0 7 0 23 0 0 0
                                    24 2 6 0 0 0 25 2 7 0 0 0 26 2 0 0 0 0 27 2
                                    6 0 0 28 29 2 7 0 0 28 30 2 0 0 0 28 31 0 6
                                    28 32 0 7 28 33 0 0 28 34 1 6 0 35 36 1 7 0
                                    35 37 1 0 0 35 38 0 6 0 39 0 7 0 40 0 0 0
                                    41 1 6 35 0 42 1 7 35 0 43 1 0 35 0 44 2 6
                                    45 45 0 46 2 7 45 45 0 47 2 0 45 45 0 48 1
                                    6 0 0 49 1 7 0 0 50 1 0 0 0 51 0 6 0 52 0 7
                                    0 53 0 0 0 54 2 6 0 0 0 55 2 7 0 0 0 56 2 0
                                    0 0 0 57 2 6 0 28 0 58 2 7 0 28 0 59 2 0 0
                                    28 0 60 2 6 61 0 0 62 2 7 61 0 0 63 2 0 61
                                    0 0 64 1 6 0 0 65 1 7 0 0 66 1 0 0 0 67 2 6
                                    0 0 0 68 2 7 0 0 0 69 2 0 0 0 0 70 2 6 0 71
                                    0 72 2 7 0 71 0 73 2 0 0 71 0 74 2 6 0 0 0
                                    75 2 7 0 0 0 76 2 0 0 0 0 77 2 6 15 0 0 78
                                    2 7 15 0 0 79 2 0 15 0 0 80 2 6 15 0 0 81 2
                                    7 15 0 0 82 2 0 15 0 0 83 2 0 15 0 0 1 1 5
                                    15 0 1 2 1 0 0 0 77 2 4 61 0 0 64 2 9 15 0
                                    0 83 0 8 28 34 1 0 7 0 21 0 10 0 1 1 7 61 0
                                    1 2 7 0 0 28 1 2 7 0 0 35 1 1 7 61 0 1 0 8
                                    0 41 2 5 15 0 0 1 1 7 15 0 1 2 2 0 0 0 1 2
                                    2 0 0 0 1 1 8 35 0 44 1 7 61 0 1 2 7 0 0 28
                                    1 2 7 0 0 35 1 1 0 85 0 1 1 6 0 0 51 2 1 0
                                    0 0 1 1 8 0 35 38 2 0 45 45 0 48 1 0 86 0 1
                                    1 0 6 0 20 0 8 12 1 1 8 84 0 1 2 0 0 6 7 19
                                    2 6 0 0 0 1 2 6 0 0 0 1 1 0 9 0 14 2 6 0 0
                                    71 1 2 7 0 0 28 31 2 7 0 0 35 1 0 5 0 54 0
                                    7 0 24 2 2 15 0 0 1 2 2 15 0 0 1 2 0 15 0 0
                                    18 2 2 15 0 0 1 2 2 15 0 0 80 2 6 0 0 0 1 2
                                    3 0 0 0 70 1 3 0 0 67 2 5 0 0 0 57 2 3 0 71
                                    0 74 2 5 0 28 0 60 2 5 0 35 0 1 2 7 0 0 0
                                    27)))))
           '|lookupComplete|)) 
