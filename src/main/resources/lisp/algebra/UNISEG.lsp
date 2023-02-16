
(SDEFUN |UNISEG;segment;S$;1| ((|a| (S)) ($ ($))) (CONS 0 (CONS |a| 1))) 

(SDEFUN |UNISEG;segment;2S$;2| ((|a| (S)) (|b| (S)) ($ ($)))
        (CONS 1 (SPADCALL |a| |b| (QREFELT $ 10)))) 

(SDEFUN |UNISEG;BY;$I$;3| ((|s| ($)) (|i| (|Integer|)) ($ ($)))
        (COND
         ((QEQCAR |s| 1) (CONS 1 (SPADCALL (QCDR |s|) |i| (QREFELT $ 13))))
         ('T (CONS 0 (CONS (SPADCALL |s| (QREFELT $ 14)) |i|))))) 

(SDEFUN |UNISEG;low;$S;4| ((|s| ($)) ($ (S)))
        (COND ((QEQCAR |s| 0) (QCAR (QCDR |s|)))
              ('T (SPADCALL (QCDR |s|) (QREFELT $ 16))))) 

(PUT '|UNISEG;hasHi;$B;5| '|SPADreplace| '(XLAM (|s|) (QEQCAR |s| 1))) 

(SDEFUN |UNISEG;hasHi;$B;5| ((|s| ($)) ($ (|Boolean|))) (QEQCAR |s| 1)) 

(SDEFUN |UNISEG;high;$S;6| ((|s| ($)) ($ (S)))
        (COND
         ((NULL (SPADCALL |s| (QREFELT $ 18)))
          (|error| "high: segment has no upper bound"))
         ('T (SPADCALL (QCDR |s|) (QREFELT $ 19))))) 

(SDEFUN |UNISEG;incr;$I;7| ((|s| ($)) ($ (|Integer|)))
        (COND ((QEQCAR |s| 0) (QCDR (QCDR |s|)))
              ('T (SPADCALL (QCDR |s|) (QREFELT $ 21))))) 

(SDEFUN |UNISEG;SEGMENT;S$;8| ((|a| (S)) ($ ($))) (SPADCALL |a| (QREFELT $ 8))) 

(SDEFUN |UNISEG;SEGMENT;2S$;9| ((|a| (S)) (|b| (S)) ($ ($)))
        (SPADCALL |a| |b| (QREFELT $ 11))) 

(PUT '|UNISEG;coerce;S$;10| '|SPADreplace| '(XLAM (|sg|) (CONS 1 |sg|))) 

(SDEFUN |UNISEG;coerce;S$;10| ((|sg| (|Segment| S)) ($ ($))) (CONS 1 |sg|)) 

(SDEFUN |UNISEG;convert;S$;11| ((|a| (S)) ($ ($)))
        (CONS 1 (SPADCALL |a| (QREFELT $ 26)))) 

(SDEFUN |UNISEG;=;2$B;12| ((|s1| ($)) (|s2| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |s1| 0)
          (COND
           ((QEQCAR |s2| 0)
            (COND
             ((SPADCALL (QCAR (QCDR |s1|)) (QCAR (QCDR |s2|)) (QREFELT $ 28))
              (EQL (QCDR (QCDR |s1|)) (QCDR (QCDR |s2|))))
             (#1='T NIL)))
           (#1# NIL)))
         ((QEQCAR |s1| 1)
          (COND
           ((QEQCAR |s2| 1) (SPADCALL (QCDR |s1|) (QCDR |s2|) (QREFELT $ 29)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |UNISEG;coerce;$Of;13| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|inc| (|Integer|)) (|seg| (|OutputForm|)) (|e| (|OutputForm|)))
         (SEQ
          (LETT |seg|
                (SEQ
                 (LETT |e|
                       (SPADCALL (SPADCALL |s| (QREFELT $ 14)) (QREFELT $ 32)))
                 (EXIT
                  (COND
                   ((SPADCALL |s| (QREFELT $ 18))
                    (SPADCALL |e|
                              (SPADCALL (SPADCALL |s| (QREFELT $ 20))
                                        (QREFELT $ 32))
                              (QREFELT $ 33)))
                   (#1='T (SPADCALL |e| (QREFELT $ 34)))))))
          (LETT |inc| (SPADCALL |s| (QREFELT $ 22)))
          (EXIT
           (COND ((EQL |inc| 1) |seg|)
                 (#1#
                  (SPADCALL (SPADCALL " by " (QREFELT $ 36)) |seg|
                            (SPADCALL |inc| (QREFELT $ 37))
                            (QREFELT $ 38)))))))) 

(SDEFUN |UNISEG;convert;$If;14| ((|s| ($)) ($ (|InputForm|)))
        (SPROG ((|seg| (|InputForm|)))
               (SEQ
                (COND ((QEQCAR |s| 1) (SPADCALL (QCDR |s|) (QREFELT $ 41)))
                      (#1='T
                       (SEQ
                        (LETT |seg|
                              (SPADCALL 'SEGMENT
                                        (LIST
                                         (SPADCALL
                                          (SPADCALL |s| (QREFELT $ 14))
                                          (QREFELT $ 42)))
                                        (QREFELT $ 46)))
                        (EXIT
                         (COND ((EQL (SPADCALL |s| (QREFELT $ 22)) 1) |seg|)
                               (#1#
                                (SPADCALL 'BY
                                          (LIST |seg|
                                                (SPADCALL
                                                 (SPADCALL |s| (QREFELT $ 22))
                                                 (QREFELT $ 47)))
                                          (QREFELT $ 46))))))))))) 

(SDEFUN |UNISEG;+;S2$;15| ((|i| (S)) (|s| ($)) ($ ($)))
        (COND
         ((QEQCAR |s| 1) (CONS 1 (SPADCALL |i| (QCDR |s|) (QREFELT $ 49))))
         ('T
          (CONS 0
                (CONS
                 (SPADCALL |i| (SPADCALL |s| (QREFELT $ 14)) (QREFELT $ 50))
                 (SPADCALL |s| (QREFELT $ 22))))))) 

(SDEFUN |UNISEG;+;$S$;16| ((|s| ($)) (|i| (S)) ($ ($)))
        (COND
         ((QEQCAR |s| 1) (CONS 1 (SPADCALL (QCDR |s|) |i| (QREFELT $ 52))))
         ('T
          (CONS 0
                (CONS
                 (SPADCALL (SPADCALL |s| (QREFELT $ 14)) |i| (QREFELT $ 50))
                 (SPADCALL |s| (QREFELT $ 22))))))) 

(SDEFUN |UNISEG;-;$S$;17| ((|s| ($)) (|i| (S)) ($ ($)))
        (COND
         ((QEQCAR |s| 1) (CONS 1 (SPADCALL (QCDR |s|) |i| (QREFELT $ 54))))
         ('T
          (CONS 0
                (CONS
                 (SPADCALL (SPADCALL |s| (QREFELT $ 14)) |i| (QREFELT $ 55))
                 (SPADCALL |s| (QREFELT $ 22))))))) 

(SDEFUN |UNISEG;expand;$S;18| ((|s| ($)) ($ (|Stream| S)))
        (SPADCALL (LIST |s|) (QREFELT $ 59))) 

(SDEFUN |UNISEG;map;M$S;19| ((|f| (|Mapping| S S)) (|s| ($)) ($ (|Stream| S)))
        (SPADCALL |f| (SPADCALL |s| (QREFELT $ 60)) (QREFELT $ 62))) 

(SDEFUN |UNISEG;expand;LS;20| ((|ls| (|List| $)) ($ (|Stream| S)))
        (SPROG
         ((|st| (|Stream| S)) (|s| ($)) (|lb| (|List| (|Segment| S)))
          (|ns| (|Segment| S)))
         (SEQ (LETT |st| (SPADCALL (QREFELT $ 64)))
              (EXIT
               (COND ((SPADCALL |ls| (QREFELT $ 66)) |st|)
                     (#1='T
                      (SEQ (LETT |lb| NIL)
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (COND ((SPADCALL |ls| (QREFELT $ 66)) NIL)
                                         ('T
                                          (SPADCALL
                                           (SPADCALL |ls| (QREFELT $ 67))
                                           (QREFELT $ 18)))))
                                  (GO G191)))
                                (SEQ (LETT |s| (SPADCALL |ls| (QREFELT $ 67)))
                                     (LETT |ls| (SPADCALL |ls| (QREFELT $ 68)))
                                     (LETT |ns|
                                           (SPADCALL
                                            (QCDR
                                             (SPADCALL
                                              (SPADCALL |s| (QREFELT $ 14))
                                              (SPADCALL |s| (QREFELT $ 20))
                                              (QREFELT $ 24)))
                                            (SPADCALL |s| (QREFELT $ 22))
                                            (QREFELT $ 13)))
                                     (EXIT
                                      (LETT |lb|
                                            (SPADCALL |lb| |ns|
                                                      (QREFELT $ 70)))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (COND
                            ((SPADCALL |ls| (QREFELT $ 66))
                             (LETT |st| (SPADCALL (QREFELT $ 64))))
                            (#1#
                             (SEQ (LETT |s| (SPADCALL |ls| (QREFELT $ 67)))
                                  (EXIT
                                   (LETT |st|
                                         (SPADCALL
                                          (CONS #'|UNISEG;expand;LS;20!0|
                                                (VECTOR $ |s|))
                                          (SPADCALL |s| (QREFELT $ 14))
                                          (QREFELT $ 72)))))))
                           (EXIT
                            (SPADCALL
                             (SPADCALL (SPADCALL |lb| (QREFELT $ 74))
                                       (QREFELT $ 75))
                             |st| (QREFELT $ 76)))))))))) 

(SDEFUN |UNISEG;expand;LS;20!0| ((|x| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 22)) (QREFELT $ 71))
                      (QREFELT $ 50)))))) 

(DECLAIM (NOTINLINE |UniversalSegment;|)) 

(DEFUN |UniversalSegment| (#1=#:G798)
  (SPROG NIL
         (PROG (#2=#:G799)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|UniversalSegment|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|UniversalSegment;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|UniversalSegment|)))))))))) 

(DEFUN |UniversalSegment;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|UniversalSegment| DV$1))
          (LETT $ (GETREFV 79))
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
          (|haddProp| |$ConstructorCache| '|UniversalSegment| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Union|
                     (|Record| (|:| |low| |#1|) (|:| |incr| (|Integer|)))
                     (|Segment| |#1|)))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 30 (CONS (|dispatchFunction| |UNISEG;=;2$B;12|) $))
             (QSETREFV $ 39
                       (CONS (|dispatchFunction| |UNISEG;coerce;$Of;13|) $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 48
                       (CONS (|dispatchFunction| |UNISEG;convert;$If;14|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 51 (CONS (|dispatchFunction| |UNISEG;+;S2$;15|) $))
             (QSETREFV $ 53 (CONS (|dispatchFunction| |UNISEG;+;$S$;16|) $)))))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 56 (CONS (|dispatchFunction| |UNISEG;-;$S$;17|) $))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 60
                       (CONS (|dispatchFunction| |UNISEG;expand;$S;18|) $))
             (QSETREFV $ 63 (CONS (|dispatchFunction| |UNISEG;map;M$S;19|) $))
             (QSETREFV $ 59
                       (CONS (|dispatchFunction| |UNISEG;expand;LS;20|) $)))))
          $))) 

(MAKEPROP '|UniversalSegment| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              |UNISEG;segment;S$;1| (|Segment| 6) (0 . |segment|)
              |UNISEG;segment;2S$;2| (|Integer|) (6 . BY) |UNISEG;low;$S;4|
              |UNISEG;BY;$I$;3| (12 . |low|) (|Boolean|) |UNISEG;hasHi;$B;5|
              (17 . |high|) |UNISEG;high;$S;6| (22 . |incr|) |UNISEG;incr;$I;7|
              |UNISEG;SEGMENT;S$;8| |UNISEG;SEGMENT;2S$;9|
              |UNISEG;coerce;S$;10| (27 . |convert|) |UNISEG;convert;S$;11|
              (32 . =) (38 . =) (44 . =) (|OutputForm|) (50 . |coerce|)
              (55 . SEGMENT) (61 . SEGMENT) (|String|) (66 . |message|)
              (71 . |coerce|) (76 . |infix|) (83 . |coerce|) (|InputForm|)
              (88 . |convert|) (93 . |convert|) (|Symbol|) (|List| 40)
              (|InputFormFunctions1| $$) (98 . |packageCall|) (104 . |convert|)
              (109 . |convert|) (114 . +) (120 . +) (126 . +) (132 . +)
              (138 . +) (144 . -) (150 . -) (156 . -) (|Stream| 6) (|List| $)
              (162 . |expand|) (167 . |expand|) (|Mapping| 6 6) (172 . |map|)
              (178 . |map|) (184 . |empty|) (|List| $$) (188 . |empty?|)
              (193 . |first|) (198 . |rest|) (|List| 9) (203 . |concat!|)
              (209 . |coerce|) (214 . |stream|) (|List| 6) (220 . |expand|)
              (225 . |construct|) (230 . |concat|) (|HashState|)
              (|SingleInteger|))
           '#(~= 236 |segment| 242 |reverse| 253 |map| 258 |low| 264 |latex|
              269 |incr| 274 |high| 279 |hashUpdate!| 284 |hash| 290 |hasHi|
              295 |expand| 300 |convert| 310 |coerce| 320 SEGMENT 330 BY 341 =
              347 - 353 + 359)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(2 0 3 0 1 3 3))
                 (CONS '#(NIL NIL |SetCategory&| NIL NIL |BasicType&| NIL)
                       (CONS
                        '#((|SegmentExpansionCategory| 6 (|Stream| 6))
                           (|SegmentCategory| 6) (|SetCategory|) (|Type|)
                           (|ConvertibleTo| 40) (|BasicType|)
                           (|CoercibleTo| 31))
                        (|makeByteWordVec2| 78
                                            '(2 9 0 6 6 10 2 9 0 0 12 13 1 9 6
                                              0 16 1 9 6 0 19 1 9 12 0 21 1 9 0
                                              6 26 2 6 17 0 0 28 2 9 17 0 0 29
                                              2 0 17 0 0 30 1 6 31 0 32 2 31 0
                                              0 0 33 1 31 0 0 34 1 31 0 35 36 1
                                              12 31 0 37 3 31 0 0 0 0 38 1 0 31
                                              0 39 1 9 40 0 41 1 6 40 0 42 2 45
                                              40 43 44 46 1 12 40 0 47 1 0 40 0
                                              48 2 9 0 6 0 49 2 6 0 0 0 50 2 0
                                              0 6 0 51 2 9 0 0 6 52 2 0 0 0 6
                                              53 2 9 0 0 6 54 2 6 0 0 0 55 2 0
                                              0 0 6 56 1 0 57 58 59 1 0 57 0 60
                                              2 57 0 61 0 62 2 0 57 61 0 63 0
                                              57 0 64 1 65 17 0 66 1 65 2 0 67
                                              1 65 0 0 68 2 69 0 0 9 70 1 6 0
                                              12 71 2 57 0 61 6 72 1 9 73 58 74
                                              1 57 0 73 75 2 57 0 0 0 76 2 3 17
                                              0 0 1 1 0 0 6 8 2 0 0 6 6 11 1 2
                                              0 0 1 2 2 57 61 0 63 1 0 6 0 14 1
                                              3 35 0 1 1 0 12 0 22 1 0 6 0 20 2
                                              3 77 77 0 1 1 3 78 0 1 1 0 17 0
                                              18 1 2 57 0 60 1 2 57 58 59 1 1
                                              40 0 48 1 0 0 6 27 1 3 31 0 39 1
                                              0 0 9 25 1 0 0 6 23 2 0 0 6 6 24
                                              2 0 0 0 12 15 2 3 17 0 0 30 2 5 0
                                              0 6 56 2 4 0 6 0 51 2 4 0 0 6
                                              53)))))
           '|lookupComplete|)) 
