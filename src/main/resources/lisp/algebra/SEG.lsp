
(PUT '|SEG;SEGMENT;2S$;1| '|SPADreplace| '(XLAM (|a| |b|) (VECTOR |a| |b| 1))) 

(SDEFUN |SEG;SEGMENT;2S$;1| ((|a| (S)) (|b| (S)) ($ ($))) (VECTOR |a| |b| 1)) 

(PUT '|SEG;low;$S;2| '|SPADreplace| '(XLAM (|s|) (QVELT |s| 0))) 

(SDEFUN |SEG;low;$S;2| ((|s| ($)) ($ (S))) (QVELT |s| 0)) 

(PUT '|SEG;high;$S;3| '|SPADreplace| '(XLAM (|s|) (QVELT |s| 1))) 

(SDEFUN |SEG;high;$S;3| ((|s| ($)) ($ (S))) (QVELT |s| 1)) 

(PUT '|SEG;incr;$I;4| '|SPADreplace| '(XLAM (|s|) (QVELT |s| 2))) 

(SDEFUN |SEG;incr;$I;4| ((|s| ($)) ($ (|Integer|))) (QVELT |s| 2)) 

(PUT '|SEG;segment;2S$;5| '|SPADreplace| '(XLAM (|a| |b|) (VECTOR |a| |b| 1))) 

(SDEFUN |SEG;segment;2S$;5| ((|a| (S)) (|b| (S)) ($ ($))) (VECTOR |a| |b| 1)) 

(SDEFUN |SEG;BY;$I$;6| ((|s| ($)) (|r| (|Integer|)) ($ ($)))
        (VECTOR (SPADCALL |s| (QREFELT $ 9)) (SPADCALL |s| (QREFELT $ 10)) |r|)) 

(SDEFUN |SEG;=;2$B;7| ((|s1| ($)) (|s2| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QVELT |s1| 0) (QVELT |s2| 0) (QREFELT $ 16))
          (COND
           ((SPADCALL (QVELT |s1| 1) (QVELT |s2| 1) (QREFELT $ 16))
            (EQL (QVELT |s1| 2) (QVELT |s2| 2)))
           (#1='T NIL)))
         (#1# NIL))) 

(SDEFUN |SEG;coerce;$Of;8| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG ((|seg| (|OutputForm|)))
               (SEQ
                (LETT |seg|
                      (SPADCALL (SPADCALL (QVELT |s| 0) (QREFELT $ 19))
                                (SPADCALL (QVELT |s| 1) (QREFELT $ 19))
                                (QREFELT $ 20)))
                (EXIT
                 (COND ((EQL (QVELT |s| 2) 1) |seg|)
                       ('T
                        (SPADCALL (SPADCALL " by " (QREFELT $ 22)) |seg|
                                  (SPADCALL (QVELT |s| 2) (QREFELT $ 23))
                                  (QREFELT $ 24)))))))) 

(PUT '|SEG;convert;S$;9| '|SPADreplace| '(XLAM (|a|) (VECTOR |a| |a| 1))) 

(SDEFUN |SEG;convert;S$;9| ((|a| (S)) ($ ($))) (VECTOR |a| |a| 1)) 

(SDEFUN |SEG;convert;$If;10| ((|s| ($)) ($ (|InputForm|)))
        (SPROG ((|seg| (|InputForm|)))
               (SEQ
                (LETT |seg|
                      (SPADCALL 'SEGMENT
                                (LIST
                                 (SPADCALL (SPADCALL |s| (QREFELT $ 9))
                                           (QREFELT $ 28))
                                 (SPADCALL (SPADCALL |s| (QREFELT $ 10))
                                           (QREFELT $ 28)))
                                (QREFELT $ 32)))
                (EXIT
                 (COND ((EQL (SPADCALL |s| (QREFELT $ 12)) 1) |seg|)
                       ('T
                        (SPADCALL 'BY
                                  (LIST |seg|
                                        (SPADCALL (SPADCALL |s| (QREFELT $ 12))
                                                  (QREFELT $ 33)))
                                  (QREFELT $ 32)))))))) 

(SDEFUN |SEG;+;S2$;11| ((|i| (S)) (|s| ($)) ($ ($)))
        (VECTOR (SPADCALL |i| (SPADCALL |s| (QREFELT $ 9)) (QREFELT $ 35))
                (SPADCALL |i| (SPADCALL |s| (QREFELT $ 10)) (QREFELT $ 35))
                (SPADCALL |s| (QREFELT $ 12)))) 

(SDEFUN |SEG;+;$S$;12| ((|s| ($)) (|i| (S)) ($ ($)))
        (VECTOR (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |i| (QREFELT $ 35))
                (SPADCALL (SPADCALL |s| (QREFELT $ 10)) |i| (QREFELT $ 35))
                (SPADCALL |s| (QREFELT $ 12)))) 

(SDEFUN |SEG;-;$S$;13| ((|s| ($)) (|i| (S)) ($ ($)))
        (VECTOR (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |i| (QREFELT $ 38))
                (SPADCALL (SPADCALL |s| (QREFELT $ 10)) |i| (QREFELT $ 38))
                (SPADCALL |s| (QREFELT $ 12)))) 

(SDEFUN |SEG;reverse;2$;14| ((|s| ($)) ($ ($)))
        (VECTOR (SPADCALL |s| (QREFELT $ 10)) (SPADCALL |s| (QREFELT $ 9))
                (- (SPADCALL |s| (QREFELT $ 12))))) 

(SDEFUN |SEG;expand;LL;15| ((|ls| (|List| $)) ($ (|List| S)))
        (SPROG
         ((|l| (S)) (|lr| (|List| S)) (|inc| (S)) (|h| (S)) (#1=#:G738 NIL)
          (|s| NIL))
         (SEQ (LETT |lr| NIL)
              (SEQ (LETT |s| NIL) (LETT #1# |ls|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |l| (SPADCALL |s| (QREFELT $ 9)))
                        (LETT |h| (SPADCALL |s| (QREFELT $ 10)))
                        (LETT |inc|
                              (SPADCALL (SPADCALL |s| (QREFELT $ 12))
                                        (QREFELT $ 41)))
                        (EXIT
                         (COND
                          ((SPADCALL |inc| (QREFELT $ 42))
                           (|error|
                            "Cannot expand a segment with an increment of zero"))
                          ((SPADCALL |inc| (|spadConstant| $ 43)
                                     (QREFELT $ 44))
                           (SEQ G190
                                (COND
                                 ((NULL (SPADCALL |l| |h| (QREFELT $ 45)))
                                  (GO G191)))
                                (SEQ (LETT |lr| (CONS |l| |lr|))
                                     (EXIT
                                      (LETT |l|
                                            (SPADCALL |l| |inc|
                                                      (QREFELT $ 35)))))
                                NIL (GO G190) G191 (EXIT NIL)))
                          ('T
                           (SEQ G190
                                (COND
                                 ((NULL (SPADCALL |l| |h| (QREFELT $ 46)))
                                  (GO G191)))
                                (SEQ (LETT |lr| (CONS |l| |lr|))
                                     (EXIT
                                      (LETT |l|
                                            (SPADCALL |l| |inc|
                                                      (QREFELT $ 35)))))
                                NIL (GO G190) G191 (EXIT NIL))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |lr|))))) 

(SDEFUN |SEG;expand;$L;16| ((|s| ($)) ($ (|List| S)))
        (SPADCALL (LIST |s|) (QREFELT $ 49))) 

(SDEFUN |SEG;map;M$L;17| ((|f| (|Mapping| S S)) (|s| ($)) ($ (|List| S)))
        (SPROG ((|l| (S)) (|lr| (|List| S)) (|inc| (S)) (|h| (S)))
               (SEQ (LETT |lr| NIL) (LETT |l| (SPADCALL |s| (QREFELT $ 9)))
                    (LETT |h| (SPADCALL |s| (QREFELT $ 10)))
                    (LETT |inc|
                          (SPADCALL (SPADCALL |s| (QREFELT $ 12))
                                    (QREFELT $ 41)))
                    (COND
                     ((SPADCALL |inc| (|spadConstant| $ 43) (QREFELT $ 44))
                      (SEQ G190
                           (COND
                            ((NULL (SPADCALL |l| |h| (QREFELT $ 45)))
                             (GO G191)))
                           (SEQ (LETT |lr| (CONS (SPADCALL |l| |f|) |lr|))
                                (EXIT
                                 (LETT |l|
                                       (SPADCALL |l| |inc| (QREFELT $ 35)))))
                           NIL (GO G190) G191 (EXIT NIL)))
                     ('T
                      (SEQ G190
                           (COND
                            ((NULL (SPADCALL |l| |h| (QREFELT $ 46)))
                             (GO G191)))
                           (SEQ (LETT |lr| (CONS (SPADCALL |l| |f|) |lr|))
                                (EXIT
                                 (LETT |l|
                                       (SPADCALL |l| |inc| (QREFELT $ 35)))))
                           NIL (GO G190) G191 (EXIT NIL))))
                    (EXIT (NREVERSE |lr|))))) 

(DECLAIM (NOTINLINE |Segment;|)) 

(DEFUN |Segment| (#1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Segment|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Segment;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Segment|)))))))))) 

(DEFUN |Segment;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Segment| DV$1))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|OrderedRing|))
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|))
                                              (|HasCategory| |#1|
                                                             '(|AbelianSemiGroup|))
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|))))))
          (|haddProp| |$ConstructorCache| '|Segment| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |low| |#1|) (|:| |high| |#1|)
                              (|:| |incr| (|Integer|))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 17 (CONS (|dispatchFunction| |SEG;=;2$B;7|) $))
             (QSETREFV $ 25
                       (CONS (|dispatchFunction| |SEG;coerce;$Of;8|) $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 34
                       (CONS (|dispatchFunction| |SEG;convert;$If;10|) $)))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 36 (CONS (|dispatchFunction| |SEG;+;S2$;11|) $))
             (QSETREFV $ 37 (CONS (|dispatchFunction| |SEG;+;$S$;12|) $)))))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 39 (CONS (|dispatchFunction| |SEG;-;$S$;13|) $))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 40 (CONS (|dispatchFunction| |SEG;reverse;2$;14|) $))
             (QSETREFV $ 49 (CONS (|dispatchFunction| |SEG;expand;LL;15|) $))
             (QSETREFV $ 50 (CONS (|dispatchFunction| |SEG;expand;$L;16|) $))
             (QSETREFV $ 52 (CONS (|dispatchFunction| |SEG;map;M$L;17|) $)))))
          $))) 

(MAKEPROP '|Segment| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| |SEG;SEGMENT;2S$;1|
              |SEG;low;$S;2| |SEG;high;$S;3| (|Integer|) |SEG;incr;$I;4|
              |SEG;segment;2S$;5| |SEG;BY;$I$;6| (|Boolean|) (0 . =) (6 . =)
              (|OutputForm|) (12 . |coerce|) (17 . SEGMENT) (|String|)
              (23 . |message|) (28 . |coerce|) (33 . |infix|) (40 . |coerce|)
              |SEG;convert;S$;9| (|InputForm|) (45 . |convert|) (|Symbol|)
              (|List| 27) (|InputFormFunctions1| $$) (50 . |packageCall|)
              (56 . |convert|) (61 . |convert|) (66 . +) (72 . +) (78 . +)
              (84 . -) (90 . -) (96 . |reverse|) (101 . |coerce|)
              (106 . |zero?|) (111 . |Zero|) (115 . >) (121 . <=) (127 . >=)
              (|List| 6) (|List| $) (133 . |expand|) (138 . |expand|)
              (|Mapping| 6 6) (143 . |map|) (|SingleInteger|) (|HashState|))
           '#(~= 149 |segment| 155 |reverse| 161 |map| 166 |low| 172 |latex|
              177 |incr| 182 |high| 187 |hashUpdate!| 192 |hash| 198 |expand|
              203 |convert| 213 |coerce| 223 SEGMENT 228 BY 234 = 240 - 246 +
              252)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(2 0 3 0 1 3 3))
                 (CONS '#(NIL NIL |SetCategory&| NIL NIL |BasicType&| NIL)
                       (CONS
                        '#((|SegmentExpansionCategory| 6 (|List| 6))
                           (|SegmentCategory| 6) (|SetCategory|) (|Type|)
                           (|ConvertibleTo| 27) (|BasicType|)
                           (|CoercibleTo| 18))
                        (|makeByteWordVec2| 54
                                            '(2 6 15 0 0 16 2 0 15 0 0 17 1 6
                                              18 0 19 2 18 0 0 0 20 1 18 0 21
                                              22 1 11 18 0 23 3 18 0 0 0 0 24 1
                                              0 18 0 25 1 6 27 0 28 2 31 27 29
                                              30 32 1 27 0 11 33 1 0 27 0 34 2
                                              6 0 0 0 35 2 0 0 6 0 36 2 0 0 0 6
                                              37 2 6 0 0 0 38 2 0 0 0 6 39 1 0
                                              0 0 40 1 6 0 11 41 1 6 15 0 42 0
                                              6 0 43 2 6 15 0 0 44 2 6 15 0 0
                                              45 2 6 15 0 0 46 1 0 47 48 49 1 0
                                              47 0 50 2 0 47 51 0 52 2 3 15 0 0
                                              1 2 0 0 6 6 13 1 2 0 0 40 2 2 47
                                              51 0 52 1 0 6 0 9 1 3 21 0 1 1 0
                                              11 0 12 1 0 6 0 10 2 3 54 54 0 1
                                              1 3 53 0 1 1 2 47 0 50 1 2 47 48
                                              49 1 1 27 0 34 1 0 0 6 26 1 3 18
                                              0 25 2 0 0 6 6 8 2 0 0 0 11 14 2
                                              3 15 0 0 17 2 5 0 0 6 39 2 4 0 0
                                              6 37 2 4 0 6 0 36)))))
           '|lookupComplete|)) 
