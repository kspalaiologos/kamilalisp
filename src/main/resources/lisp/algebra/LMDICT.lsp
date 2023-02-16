
(SDEFUN |LMDICT;coerce;$Of;1| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G715 NIL) (|x| NIL) (#2=#:G714 NIL))
               (SEQ
                (SPADCALL (SPADCALL "dictionary" (QREFELT $ 10))
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |x| NIL)
                                (LETT #1# (SPADCALL |s| (QREFELT $ 12))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |x| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |x| (QREFELT $ 13))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 15))))) 

(SDEFUN |LMDICT;#;$Nni;2| ((|s| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL |s| (QREFELT $ 12)))) 

(SDEFUN |LMDICT;copy;2$;3| ((|s| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 19))
                  (QREFELT $ 20))) 

(SDEFUN |LMDICT;empty?;$B;4| ((|s| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |s| (QREFELT $ 12)))) 

(SDEFUN |LMDICT;dictionary;$;5| (($ ($))) (SPADCALL NIL (QREFELT $ 20))) 

(SDEFUN |LMDICT;empty;$;6| (($ ($))) (SPADCALL NIL (QREFELT $ 25))) 

(SDEFUN |LMDICT;dictionary;L$;7| ((|ls| (|List| S)) ($ ($)))
        (SPROG ((#1=#:G730 NIL) (|x| NIL) (|lmd| ($)))
               (SEQ
                (COND ((NULL |ls|) (SPADCALL (QREFELT $ 26)))
                      ('T
                       (SEQ (LETT |lmd| (SPADCALL (QREFELT $ 26)))
                            (SEQ (LETT |x| NIL) (LETT #1# |ls|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |x| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT (SPADCALL |x| |lmd| (QREFELT $ 27))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |lmd|))))))) 

(SDEFUN |LMDICT;convert;$If;8| ((|lmd| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|dictionary| (QREFELT $ 30))
               (SPADCALL (SPADCALL |lmd| (QREFELT $ 12)) (QREFELT $ 31)))
         (QREFELT $ 32))) 

(SDEFUN |LMDICT;map;M2$;9| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 35))
                  (QREFELT $ 20))) 

(SDEFUN |LMDICT;map!;M2$;10| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 37))
                  (QREFELT $ 20))) 

(SDEFUN |LMDICT;parts;$L;11| ((|s| ($)) ($ (|List| S)))
        (SPADCALL |s| (QREFELT $ 39))) 

(SDEFUN |LMDICT;sub| ((|x| (S)) (|y| (S)) (|z| (S)) ($ (S)))
        (COND ((SPADCALL |z| |x| (QREFELT $ 40)) |y|) ('T |z|))) 

(SDEFUN |LMDICT;insert!;S$Nni$;13|
        ((|x| (S)) (|s| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G747 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (SPADCALL |x| |s| (QREFELT $ 27))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |s|)))) 

(SDEFUN |LMDICT;substitute;2S2$;14| ((|x| (S)) (|y| (S)) (|s| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL
                 (CONS #'|LMDICT;substitute;2S2$;14!0| (VECTOR $ |y| |x|))
                 (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 35))
                (QREFELT $ 20)))) 

(SDEFUN |LMDICT;substitute;2S2$;14!0| ((|z1| NIL) ($$ NIL))
        (PROG (|x| |y| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |y| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|LMDICT;sub| |x| |y| |z1| $))))) 

(SDEFUN |LMDICT;removeDuplicates!;2$;15| ((|s| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 43))
                  (QREFELT $ 20))) 

(SDEFUN |LMDICT;inspect;$S;16| ((|s| ($)) ($ (S)))
        (COND ((SPADCALL |s| (QREFELT $ 23)) (|error| "empty dictionary"))
              ('T (|SPADfirst| (SPADCALL |s| (QREFELT $ 12)))))) 

(SDEFUN |LMDICT;extract!;$S;17| ((|s| ($)) ($ (S)))
        (SPROG ((|x| (S)) (|p| (|List| S)))
               (SEQ
                (COND
                 ((SPADCALL |s| (QREFELT $ 23)) (|error| "empty dictionary"))
                 ('T
                  (SEQ
                   (LETT |x|
                         (|SPADfirst|
                          (LETT |p| (SPADCALL |s| (QREFELT $ 12)))))
                   (SPADCALL |s| (CDR |p|) (QREFELT $ 46)) (EXIT |x|))))))) 

(SDEFUN |LMDICT;duplicates?;$B;18| ((|s| ($)) ($ (|Boolean|)))
        (SPROG ((|q| (|List| S)) (|p| (|List| S)) (#1=#:G764 NIL))
               (SEQ
                (EXIT
                 (COND ((NULL (LETT |p| (SPADCALL |s| (QREFELT $ 12)))) NIL)
                       ('T
                        (SEQ (LETT |q| (CDR |p|))
                             (SEQ G190
                                  (COND ((NULL (NULL (NULL |q|))) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL (|SPADfirst| |p|)
                                                (|SPADfirst| |q|)
                                                (QREFELT $ 40))
                                      (PROGN (LETT #1# 'T) (GO #2=#:G763)))
                                     ('T
                                      (SEQ (LETT |p| |q|)
                                           (EXIT (LETT |q| (CDR |q|))))))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT NIL)))))
                #2# (EXIT #1#)))) 

(SDEFUN |LMDICT;remove!;M2$;19|
        ((|p| (|Mapping| (|Boolean|) S)) (|lmd| ($)) ($ ($)))
        (SPROG ((#1=#:G770 NIL) (|x| NIL))
               (SEQ
                (SEQ (LETT |x| NIL)
                     (LETT #1#
                           (SPADCALL (SPADCALL |lmd| (QREFELT $ 12))
                                     (QREFELT $ 49)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |x| |p|)
                         (SPADCALL |x| |lmd| (QREFELT $ 50))))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |lmd|)))) 

(SDEFUN |LMDICT;select!;M2$;20|
        ((|p| (|Mapping| (|Boolean|) S)) (|lmd| ($)) ($ ($)))
        (SPADCALL (CONS #'|LMDICT;select!;M2$;20!0| |p|) |lmd| (QREFELT $ 52))) 

(SDEFUN |LMDICT;select!;M2$;20!0| ((|z1| NIL) (|p| NIL))
        (NULL (SPADCALL |z1| |p|))) 

(SDEFUN |LMDICT;duplicates;$L;21|
        ((|lmd| ($))
         ($
          (|List|
           (|Record| (|:| |entry| S) (|:| |count| (|NonNegativeInteger|))))))
        (SPROG
         ((|ld|
           (|List|
            (|Record| (|:| |entry| S) (|:| |count| (|NonNegativeInteger|)))))
          (|n| (|NonNegativeInteger|)) (#1=#:G785 NIL) (|x| NIL))
         (SEQ (LETT |ld| NIL)
              (SEQ (LETT |x| NIL)
                   (LETT #1#
                         (SPADCALL (SPADCALL |lmd| (QREFELT $ 12))
                                   (QREFELT $ 49)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (LETT |n| (SPADCALL |x| |lmd| (QREFELT $ 54))) 1)
                       (LETT |ld| (CONS (CONS |x| |n|) |ld|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ld|)))) 

(SDEFUN |LMDICT;=;2$B;22| ((|s| ($)) (|t| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 12)) (SPADCALL |t| (QREFELT $ 12))
                  (QREFELT $ 58))) 

(SDEFUN |LMDICT;remove!;S2$;23| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((|q| (|List| S)) (|p| (|List| S)))
               (SEQ (LETT |p| (SPADCALL |s| (QREFELT $ 39)))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((NULL |p|) NIL)
                                  ('T
                                   (SPADCALL |x| (|SPADfirst| |p|)
                                             (QREFELT $ 40)))))
                           (GO G191)))
                         (SEQ (EXIT (LETT |p| (CDR |p|)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (SPADCALL |s| |p| (QREFELT $ 46))
                    (EXIT
                     (COND ((NULL |p|) |s|)
                           ('T
                            (SEQ (LETT |q| (CDR |p|))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND ((NULL |q|) NIL)
                                               ('T
                                                (SPADCALL |x| (|SPADfirst| |q|)
                                                          (QREFELT $ 60)))))
                                        (GO G191)))
                                      (SEQ (LETT |p| |q|)
                                           (EXIT (LETT |q| (CDR |q|))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND ((NULL |q|) NIL)
                                               ('T
                                                (SPADCALL |x| (|SPADfirst| |q|)
                                                          (QREFELT $ 40)))))
                                        (GO G191)))
                                      (SEQ (EXIT (LETT |q| (CDR |q|)))) NIL
                                      (GO G190) G191 (EXIT NIL))
                                 (SPADCALL |p| '|rest| |q| (QREFELT $ 62))
                                 (EXIT |s|)))))))) 

(SDEFUN |LMDICT;insert!;S2$;24| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((|q| (|List| S)) (|p| (|List| S)))
               (SEQ (LETT |p| (SPADCALL |s| (QREFELT $ 39)))
                    (COND
                     ((OR (NULL |p|)
                          (SPADCALL |x| (|SPADfirst| |p|) (QREFELT $ 63)))
                      (EXIT
                       (SEQ (SPADCALL |s| (CONS |x| |p|) (QREFELT $ 46))
                            (EXIT |s|)))))
                    (LETT |q| (CDR |p|))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((NULL |q|) NIL)
                                  ('T
                                   (SPADCALL |x| (|SPADfirst| |q|)
                                             (QREFELT $ 60)))))
                           (GO G191)))
                         (SEQ (LETT |p| |q|) (EXIT (LETT |q| (CDR |q|)))) NIL
                         (GO G190) G191 (EXIT NIL))
                    (SPADCALL |p| '|rest| (CONS |x| |q|) (QREFELT $ 62))
                    (EXIT |s|)))) 

(SDEFUN |LMDICT;remove!;S2$;25| ((|x| (S)) (|s| ($)) ($ ($)))
        (SEQ
         (SPADCALL |s|
                   (SPADCALL |x| (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 64))
                   (QREFELT $ 46))
         (EXIT |s|))) 

(SDEFUN |LMDICT;=;2$B;26| ((|s| ($)) (|t| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G818 NIL) (|x| (S)) (|a| ($)))
               (SEQ
                (EXIT
                 (SEQ (LETT |a| (SPADCALL |s| (QREFELT $ 21)))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |a| (QREFELT $ 23))))
                             (GO G191)))
                           (SEQ (LETT |x| (SPADCALL |a| (QREFELT $ 45)))
                                (EXIT
                                 (COND
                                  ((SPADCALL (SPADCALL |x| |s| (QREFELT $ 54))
                                             (SPADCALL |x| |t| (QREFELT $ 54))
                                             (QREFELT $ 65))
                                   (PROGN (LETT #1# NIL) (GO #2=#:G817)))
                                  ('T (SPADCALL |x| |a| (QREFELT $ 50))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |LMDICT;insert!;S2$;27| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((|p| (|List| S)) (#1=#:G826 NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |p| (SPADCALL |s| (QREFELT $ 39)))
                      (SEQ G190 (COND ((NULL (NULL (NULL |p|))) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |x| (|SPADfirst| |p|) (QREFELT $ 40))
                               (SEQ
                                (SPADCALL |p| '|rest| (CONS |x| (CDR |p|))
                                          (QREFELT $ 62))
                                (EXIT (PROGN (LETT #1# |s|) (GO #2=#:G825)))))
                              ('T (LETT |p| (CDR |p|))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (SPADCALL |s| (CONS |x| (SPADCALL |s| (QREFELT $ 39)))
                                (QREFELT $ 46))
                      (EXIT |s|)))
                #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |ListMultiDictionary;|)) 

(DEFUN |ListMultiDictionary| (#1=#:G837)
  (SPROG NIL
         (PROG (#2=#:G838)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ListMultiDictionary|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|ListMultiDictionary;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ListMultiDictionary|)))))))))) 

(DEFUN |ListMultiDictionary;| (|#1|)
  (SPROG
   ((#1=#:G836 NIL) (#2=#:G835 NIL) (|pv$| NIL) (#3=#:G832 NIL) (#4=#:G833 NIL)
    (#5=#:G834 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|ListMultiDictionary| DV$1))
    (LETT $ (GETREFV 73))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #5#)
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|BasicType|)))
                                        (OR #4# #5#)
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #3#
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #5#))))))
    (|haddProp| |$ConstructorCache| '|ListMultiDictionary| (LIST DV$1)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 256))
    (AND (LETT #2# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 512))
    (AND (|HasCategory| |#1| '(|OrderedSet|)) #2# (|augmentPredVector| $ 1024))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 2048))
    (AND (OR #1# #5#) (|augmentPredVector| $ 4096))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 (|Reference| (|List| |#1|)))
    (COND
     ((|testBitVector| |pv$| 3)
      (QSETREFV $ 33 (CONS (|dispatchFunction| |LMDICT;convert;$If;8|) $))))
    (COND
     ((|testBitVector| |pv$| 4)
      (PROGN
       (QSETREFV $ 59 (CONS (|dispatchFunction| |LMDICT;=;2$B;22|) $))
       (QSETREFV $ 50 (CONS (|dispatchFunction| |LMDICT;remove!;S2$;23|) $))
       (QSETREFV $ 27 (CONS (|dispatchFunction| |LMDICT;insert!;S2$;24|) $))))
     ('T
      (PROGN
       (QSETREFV $ 50 (CONS (|dispatchFunction| |LMDICT;remove!;S2$;25|) $))
       (QSETREFV $ 59 (CONS (|dispatchFunction| |LMDICT;=;2$B;26|) $))
       (QSETREFV $ 27 (CONS (|dispatchFunction| |LMDICT;insert!;S2$;27|) $)))))
    $))) 

(MAKEPROP '|ListMultiDictionary| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|String|)
              (|OutputForm|) (0 . |message|) (|List| 6) |LMDICT;parts;$L;11|
              (5 . |coerce|) (|List| $) (10 . |prefix|) |LMDICT;coerce;$Of;1|
              (|NonNegativeInteger|) |LMDICT;#;$Nni;2| (16 . |copy|)
              |LMDICT;dictionary;L$;7| |LMDICT;copy;2$;3| (|Boolean|)
              |LMDICT;empty?;$B;4| |LMDICT;dictionary;$;5| (21 . |ref|)
              |LMDICT;empty;$;6| (26 . |insert!|) (|Symbol|) (|InputForm|)
              (32 . |convert|) (37 . |convert|) (42 . |convert|)
              (47 . |convert|) (|Mapping| 6 6) (52 . |map|) |LMDICT;map;M2$;9|
              (58 . |map!|) |LMDICT;map!;M2$;10| (64 . |deref|) (69 . =)
              |LMDICT;insert!;S$Nni$;13| |LMDICT;substitute;2S2$;14|
              (75 . |removeDuplicates!|) |LMDICT;removeDuplicates!;2$;15|
              |LMDICT;inspect;$S;16| (80 . |setref|) |LMDICT;extract!;$S;17|
              |LMDICT;duplicates?;$B;18| (86 . |removeDuplicates|)
              (91 . |remove!|) (|Mapping| 22 6) |LMDICT;remove!;M2$;19|
              |LMDICT;select!;M2$;20| (97 . |count|)
              (|Record| (|:| |entry| 6) (|:| |count| 17)) (|List| 55)
              |LMDICT;duplicates;$L;21| (103 . =) (109 . =) (115 . >) '"rest"
              (121 . |setelt!|) (128 . <) (134 . |remove!|) (140 . ~=)
              (|Mapping| 6 6 6) (|List| 68) (|Equation| 6) (|Mapping| 22 6 6)
              (|SingleInteger|) (|HashState|) (|Union| 6 '"failed"))
           '#(~= 146 |substitute| 152 |size?| 159 |select!| 165 |select| 171
              |sample| 177 |removeDuplicates!| 181 |removeDuplicates| 186
              |remove!| 191 |remove| 203 |reduce| 215 |parts| 236 |more?| 241
              |min| 247 |members| 252 |member?| 257 |max| 263 |map!| 274 |map|
              280 |less?| 286 |latex| 292 |inspect| 297 |insert!| 302
              |hashUpdate!| 315 |hash| 321 |find| 326 |extract!| 332 |every?|
              337 |eval| 343 |eq?| 369 |empty?| 375 |empty| 380 |duplicates?|
              384 |duplicates| 389 |dictionary| 394 |count| 403 |copy| 415
              |convert| 420 |construct| 425 |coerce| 430 |any?| 435 = 441 |#|
              447)
           'NIL
           (CONS (|makeByteWordVec2| 8 '(0 0 0 0 0 0 2 1 0 0 0 2 6 8 3))
                 (CONS
                  '#(NIL |DictionaryOperations&| |BagAggregate&| |Collection&|
                     |HomogeneousAggregate&| |Aggregate&| |Evalable&|
                     |SetCategory&| NIL NIL NIL |InnerEvalable&| |BasicType&|
                     NIL NIL)
                  (CONS
                   '#((|MultiDictionary| 6) (|DictionaryOperations| 6)
                      (|BagAggregate| 6) (|Collection| 6)
                      (|HomogeneousAggregate| 6) (|Aggregate|) (|Evalable| 6)
                      (|SetCategory|) (|Type|) (|finiteAggregate|)
                      (|shallowlyMutable|) (|InnerEvalable| 6 6) (|BasicType|)
                      (|CoercibleTo| 9) (|ConvertibleTo| 29))
                   (|makeByteWordVec2| 72
                                       '(1 9 0 8 10 1 6 9 0 13 2 9 0 0 14 15 1
                                         11 0 0 19 1 7 0 11 25 2 0 0 6 0 27 1
                                         29 0 28 30 1 11 29 0 31 1 29 0 14 32 1
                                         0 29 0 33 2 11 0 34 0 35 2 11 0 34 0
                                         37 1 7 11 0 39 2 6 22 0 0 40 1 11 0 0
                                         43 2 7 11 0 11 46 1 11 0 0 49 2 0 0 6
                                         0 50 2 0 17 6 0 54 2 11 22 0 0 58 2 0
                                         22 0 0 59 2 6 22 0 0 60 3 11 0 0 61 0
                                         62 2 6 22 0 0 63 2 11 0 6 0 64 2 17 22
                                         0 0 65 2 13 22 0 0 1 3 0 0 6 6 0 42 2
                                         0 22 0 17 1 2 10 0 51 0 53 2 10 0 51 0
                                         1 0 0 0 1 1 0 0 0 44 1 12 0 0 1 2 12 0
                                         6 0 50 2 10 0 51 0 52 2 12 0 6 0 1 2
                                         10 0 51 0 1 4 12 6 66 0 6 6 1 3 10 6
                                         66 0 6 1 2 10 6 66 0 1 1 10 11 0 12 2
                                         0 22 0 17 1 1 11 6 0 1 1 10 11 0 1 2
                                         12 22 6 0 1 1 11 6 0 1 2 10 6 69 0 1 2
                                         9 0 34 0 38 2 0 0 34 0 36 2 0 22 0 17
                                         1 1 1 8 0 1 1 0 6 0 45 3 0 0 6 0 17 41
                                         2 0 0 6 0 27 2 1 71 71 0 1 1 1 70 0 1
                                         2 0 72 51 0 1 1 0 6 0 47 2 10 22 51 0
                                         1 3 2 0 0 11 11 1 3 2 0 0 6 6 1 2 2 0
                                         0 67 1 2 2 0 0 68 1 2 0 22 0 0 1 1 0
                                         22 0 23 0 0 0 26 1 0 22 0 48 1 0 56 0
                                         57 1 0 0 11 20 0 0 0 24 2 12 17 6 0 54
                                         2 10 17 51 0 1 1 0 0 0 21 1 3 29 0 33
                                         1 0 0 11 1 1 7 9 0 16 2 10 22 51 0 1 2
                                         13 22 0 0 59 1 10 17 0 18)))))
           '|lookupComplete|)) 
