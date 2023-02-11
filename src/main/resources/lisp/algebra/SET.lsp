
(SDEFUN |SET;#;$Nni;1| ((|s| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |s| (QREFELT $ 9))) 

(SDEFUN |SET;set;$;2| (($ ($))) (SPADCALL (QREFELT $ 11))) 

(SDEFUN |SET;empty;$;3| (($ ($))) (SPADCALL (QREFELT $ 13))) 

(SDEFUN |SET;copy;2$;4| ((|s| ($)) ($ ($))) (SPADCALL |s| (QREFELT $ 14))) 

(SDEFUN |SET;parts;$L;5| ((|s| ($)) ($ (|List| S)))
        (SPADCALL |s| (QREFELT $ 17))) 

(SDEFUN |SET;inspect;$S;6| ((|s| ($)) ($ (S)))
        (COND ((SPADCALL |s| (QREFELT $ 20)) (|error| "Empty set"))
              ('T (SPADCALL |s| (SPADCALL |s| (QREFELT $ 22)) (QREFELT $ 23))))) 

(SDEFUN |SET;extract!;$S;7| ((|s| ($)) ($ (S)))
        (SPROG ((|x| (S)))
               (SEQ (LETT |x| (SPADCALL |s| (QREFELT $ 24)))
                    (SPADCALL |s| (SPADCALL |s| (QREFELT $ 22)) (QREFELT $ 25))
                    (EXIT |x|)))) 

(SDEFUN |SET;find;M$U;8|
        ((|f| (|Mapping| (|Boolean|) S)) (|s| ($)) ($ (|Union| S "failed")))
        (SPADCALL |f| |s| (QREFELT $ 29))) 

(SDEFUN |SET;map;M2$;9| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SPADCALL |f| (SPADCALL |s| (QREFELT $ 15)) (QREFELT $ 32))) 

(SDEFUN |SET;reduce;M$S;10| ((|f| (|Mapping| S S S)) (|s| ($)) ($ (S)))
        (SPADCALL |f| |s| (QREFELT $ 35))) 

(SDEFUN |SET;reduce;M$2S;11|
        ((|f| (|Mapping| S S S)) (|s| ($)) (|x| (S)) ($ (S)))
        (SPADCALL |f| |s| |x| (QREFELT $ 37))) 

(SDEFUN |SET;reduce;M$3S;12|
        ((|f| (|Mapping| S S S)) (|s| ($)) (|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL |f| |s| |x| |y| (QREFELT $ 39))) 

(SDEFUN |SET;convert;$If;13| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|set| (QREFELT $ 43))
               (SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 44)))
         (QREFELT $ 46))) 

(SDEFUN |SET;=;2$B;14| ((|s| ($)) (|t| ($)) ($ (|Boolean|)))
        (SPADCALL |s| |t| (QREFELT $ 48))) 

(SDEFUN |SET;max;$S;15| ((|s| ($)) ($ (S))) (SPADCALL |s| (QREFELT $ 24))) 

(SDEFUN |SET;min;$S;16| ((|s| ($)) ($ (S)))
        (COND ((SPADCALL |s| (QREFELT $ 20)) (|error| "Empty set"))
              ('T (SPADCALL |s| (SPADCALL |s| (QREFELT $ 51)) (QREFELT $ 23))))) 

(SDEFUN |SET;map!;M2$;17| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SEQ (SPADCALL |f| |s| (QREFELT $ 53)) (SPADCALL |s| (QREFELT $ 54))
             (EXIT (SPADCALL |s| (QREFELT $ 55))))) 

(SDEFUN |SET;construct;L$;18| ((|l| (|List| S)) ($ ($)))
        (SPROG
         ((|i| NIL) (#1=#:G759 NIL) (|x| NIL) (|a| ($))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((ZEROP (LETT |n| (LENGTH |l|))) (SPADCALL (QREFELT $ 11)))
                ('T
                 (SEQ
                  (LETT |a| (SPADCALL |n| (|SPADfirst| |l|) (QREFELT $ 56)))
                  (SEQ (LETT |x| NIL) (LETT #1# |l|)
                       (LETT |i| (SPADCALL |a| (QREFELT $ 51))) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (SPADCALL |a| |i| |x| (QREFELT $ 57))))
                       (LETT |i| (PROG1 (+ |i| 1) (LETT #1# (CDR #1#))))
                       (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SPADCALL (SPADCALL |a| (QREFELT $ 54))
                             (QREFELT $ 55))))))))) 

(SDEFUN |SET;insert!;S2$;19| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((|k| (|Integer|)) (|n| (|Integer|)))
               (SEQ (LETT |n| (+ (SPADCALL |s| (QREFELT $ 22)) 1))
                    (LETT |k| (SPADCALL |s| (QREFELT $ 51)))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((< |k| |n|)
                              (SPADCALL |x| (SPADCALL |s| |k| (QREFELT $ 23))
                                        (QREFELT $ 59)))
                             ('T NIL)))
                           (GO G191)))
                         (SEQ (EXIT (LETT |k| (+ |k| 1)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (COND
                     ((< |k| |n|)
                      (COND
                       ((SPADCALL (SPADCALL |s| |k| (QREFELT $ 23)) |x|
                                  (QREFELT $ 60))
                        (EXIT |s|)))))
                    (EXIT (SPADCALL |x| |s| |k| (QREFELT $ 61)))))) 

(SDEFUN |SET;member?;S$B;20| ((|x| (S)) (|s| ($)) ($ (|Boolean|)))
        (SPROG ((|t| (|Integer|)) (|b| (|Integer|)) (|m| (|Integer|)))
               (SEQ
                (COND ((SPADCALL |s| (QREFELT $ 20)) NIL)
                      ('T
                       (SEQ (LETT |t| (SPADCALL |s| (QREFELT $ 22)))
                            (LETT |b| (SPADCALL |s| (QREFELT $ 51)))
                            (SEQ G190 (COND ((NULL (< |b| |t|)) (GO G191)))
                                 (SEQ (LETT |m| (QUOTIENT2 (+ |b| |t|) 2))
                                      (EXIT
                                       (COND
                                        ((SPADCALL |x|
                                                   (SPADCALL |s| |m|
                                                             (QREFELT $ 23))
                                                   (QREFELT $ 59))
                                         (LETT |b| (+ |m| 1)))
                                        ('T (LETT |t| |m|)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT
                             (SPADCALL |x| (SPADCALL |s| |t| (QREFELT $ 23))
                                       (QREFELT $ 60))))))))) 

(SDEFUN |SET;remove!;S2$;21| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((|k| (|Integer|)) (|n| (|Integer|)))
               (SEQ (LETT |n| (+ (SPADCALL |s| (QREFELT $ 22)) 1))
                    (LETT |k| (SPADCALL |s| (QREFELT $ 51)))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((< |k| |n|)
                              (SPADCALL |x| (SPADCALL |s| |k| (QREFELT $ 23))
                                        (QREFELT $ 59)))
                             ('T NIL)))
                           (GO G191)))
                         (SEQ (EXIT (LETT |k| (+ |k| 1)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (COND
                     ((< |k| |n|)
                      (COND
                       ((SPADCALL |x| (SPADCALL |s| |k| (QREFELT $ 23))
                                  (QREFELT $ 60))
                        (EXIT (SPADCALL |s| |k| (QREFELT $ 25)))))))
                    (EXIT |s|)))) 

(SDEFUN |SET;intersect;3$;22| ((|s| ($)) (|t| ($)) ($ ($)))
        (SPROG
         ((|j| #1=(|Integer|)) (|i| #1#) (|r| ($)) (|n| #2=(|Integer|))
          (|m| #2#))
         (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 22)))
              (LETT |n| (SPADCALL |t| (QREFELT $ 22)))
              (LETT |i| (SPADCALL |s| (QREFELT $ 51)))
              (LETT |j| (SPADCALL |t| (QREFELT $ 51)))
              (LETT |r| (SPADCALL (QREFELT $ 11)))
              (SEQ G190
                   (COND
                    ((NULL (COND ((<= |i| |m|) (<= |j| |n|)) ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 60))
                       (SEQ
                        (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (LETT |i| (+ |i| 1)) (EXIT (LETT |j| (+ |j| 1)))))
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 66))
                       (LETT |i| (+ |i| 1)))
                      ('T (LETT |j| (+ |j| 1))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |SET;difference;3$;23| ((|s| ($)) (|t| ($)) ($ ($)))
        (SPROG
         ((|i| #1=(|Integer|)) (|j| #1#) (|r| ($)) (|n| #2=(|Integer|))
          (|m| #2#))
         (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 22)))
              (LETT |n| (SPADCALL |t| (QREFELT $ 22)))
              (LETT |i| (SPADCALL |s| (QREFELT $ 51)))
              (LETT |j| (SPADCALL |t| (QREFELT $ 51)))
              (LETT |r| (SPADCALL (QREFELT $ 11)))
              (SEQ G190
                   (COND
                    ((NULL (COND ((<= |i| |m|) (<= |j| |n|)) ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 60))
                       (SEQ (LETT |i| (+ |i| 1)) (EXIT (LETT |j| (+ |j| 1)))))
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 66))
                       (SEQ
                        (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (EXIT (LETT |i| (+ |i| 1)))))
                      ('T (LETT |j| (+ |j| 1))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (<= |i| |m|)) (GO G191)))
                   (SEQ
                    (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                              (QREFELT $ 65))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |SET;symmetricDifference;3$;24| ((|s| ($)) (|t| ($)) ($ ($)))
        (SPROG
         ((|j| #1=(|Integer|)) (|i| #1#) (|r| ($)) (|n| #2=(|Integer|))
          (|m| #2#))
         (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 22)))
              (LETT |n| (SPADCALL |t| (QREFELT $ 22)))
              (LETT |i| (SPADCALL |s| (QREFELT $ 51)))
              (LETT |j| (SPADCALL |t| (QREFELT $ 51)))
              (LETT |r| (SPADCALL (QREFELT $ 11)))
              (SEQ G190
                   (COND
                    ((NULL (COND ((<= |i| |m|) (<= |j| |n|)) ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 66))
                       (SEQ
                        (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (EXIT (LETT |i| (+ |i| 1)))))
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 59))
                       (SEQ
                        (SPADCALL |r| (SPADCALL |t| |j| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (EXIT (LETT |j| (+ |j| 1)))))
                      ('T
                       (SEQ (LETT |i| (+ |i| 1))
                            (EXIT (LETT |j| (+ |j| 1))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (<= |i| |m|)) (GO G191)))
                   (SEQ
                    (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                              (QREFELT $ 65))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (<= |j| |n|)) (GO G191)))
                   (SEQ
                    (SPADCALL |r| (SPADCALL |t| |j| (QREFELT $ 23))
                              (QREFELT $ 65))
                    (EXIT (LETT |j| (+ |j| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |SET;subset?;2$B;25| ((|s| ($)) (|t| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G817 NIL) (|j| #2=(|Integer|)) (|i| #2#) (|n| #3=(|Integer|))
          (|m| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 22)))
                (LETT |n| (SPADCALL |t| (QREFELT $ 22)))
                (EXIT
                 (COND ((> |m| |n|) NIL)
                       ('T
                        (SEQ (LETT |i| (SPADCALL |s| (QREFELT $ 51)))
                             (LETT |j| (SPADCALL |t| (QREFELT $ 51)))
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (COND ((<= |i| |m|) (<= |j| |n|))
                                           ('T NIL)))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |s| |i| (QREFELT $ 23))
                                       (SPADCALL |t| |j| (QREFELT $ 23))
                                       (QREFELT $ 60))
                                      (SEQ (LETT |i| (+ |i| 1))
                                           (EXIT (LETT |j| (+ |j| 1)))))
                                     ((SPADCALL
                                       (SPADCALL |s| |i| (QREFELT $ 23))
                                       (SPADCALL |t| |j| (QREFELT $ 23))
                                       (QREFELT $ 59))
                                      (LETT |j| (+ |j| 1)))
                                     ('T
                                      (PROGN (LETT #1# NIL) (GO #4=#:G816))))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT (> |i| |m|))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |SET;union;3$;26| ((|s| ($)) (|t| ($)) ($ ($)))
        (SPROG
         ((|j| #1=(|Integer|)) (|i| #1#) (|r| ($)) (|n| #2=(|Integer|))
          (|m| #2#))
         (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 22)))
              (LETT |n| (SPADCALL |t| (QREFELT $ 22)))
              (LETT |i| (SPADCALL |s| (QREFELT $ 51)))
              (LETT |j| (SPADCALL |t| (QREFELT $ 51)))
              (LETT |r| (SPADCALL (QREFELT $ 11)))
              (SEQ G190
                   (COND
                    ((NULL (COND ((<= |i| |m|) (<= |j| |n|)) ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 60))
                       (SEQ
                        (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (LETT |i| (+ |i| 1)) (EXIT (LETT |j| (+ |j| 1)))))
                      ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 23))
                                 (SPADCALL |t| |j| (QREFELT $ 23))
                                 (QREFELT $ 66))
                       (SEQ
                        (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (EXIT (LETT |i| (+ |i| 1)))))
                      ('T
                       (SEQ
                        (SPADCALL |r| (SPADCALL |t| |j| (QREFELT $ 23))
                                  (QREFELT $ 65))
                        (EXIT (LETT |j| (+ |j| 1))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (<= |i| |m|)) (GO G191)))
                   (SEQ
                    (SPADCALL |r| (SPADCALL |s| |i| (QREFELT $ 23))
                              (QREFELT $ 65))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (<= |j| |n|)) (GO G191)))
                   (SEQ
                    (SPADCALL |r| (SPADCALL |t| |j| (QREFELT $ 23))
                              (QREFELT $ 65))
                    (EXIT (LETT |j| (+ |j| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |SET;insert!;S2$;27| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((#1=#:G838 NIL) (#2=#:G839 NIL) (#3=#:G840 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |k| (SPADCALL |s| (QREFELT $ 51)))
                         (LETT #3# (SPADCALL |s| (QREFELT $ 22))) G190
                         (COND ((> |k| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |s| |k| (QREFELT $ 23)) |x|
                                       (QREFELT $ 60))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# |s|) (GO #4=#:G837)))
                              (GO #5=#:G835))))))
                         (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT
                   (SPADCALL |x| |s| (+ (SPADCALL |s| (QREFELT $ 22)) 1)
                             (QREFELT $ 61)))))
                #4# (EXIT #2#)))) 

(SDEFUN |SET;remove!;S2$;28| ((|x| (S)) (|s| ($)) ($ ($)))
        (SPROG ((|k| (|Integer|)) (#1=#:G846 NIL) (|n| (|Integer|)))
               (SEQ
                (EXIT
                 (SEQ (LETT |n| (+ (SPADCALL |s| (QREFELT $ 22)) 1))
                      (LETT |k| (SPADCALL |s| (QREFELT $ 51)))
                      (SEQ G190 (COND ((NULL (< |k| |n|)) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |x| (SPADCALL |s| |k| (QREFELT $ 23))
                                         (QREFELT $ 60))
                               (PROGN
                                (LETT #1# (SPADCALL |s| |k| (QREFELT $ 25)))
                                (GO #2=#:G845)))
                              ('T (LETT |k| (+ |k| 1))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |s|)))
                #2# (EXIT #1#)))) 

(SDEFUN |SET;map!;M2$;29| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SEQ (SPADCALL |f| |s| (QREFELT $ 53))
             (EXIT (SPADCALL |s| (QREFELT $ 72))))) 

(DECLAIM (NOTINLINE |Set;|)) 

(DEFUN |Set| (#1=#:G854)
  (SPROG NIL
         (PROG (#2=#:G855)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Set|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Set;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Set|)))))))))) 

(DEFUN |Set;| (|#1|)
  (SPROG ((#1=#:G853 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Set| DV$1))
          (LETT $ (GETREFV 81))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|Comparable|))
                                              (|HasCategory| |#1| '(|Finite|))
                                              (|HasCategory| |#1|
                                                             '(|OrderedSet|))
                                              (AND
                                               (|HasCategory| |#1|
                                                              (LIST '|Evalable|
                                                                    (|devaluate|
                                                                     |#1|)))
                                               (|HasCategory| |#1|
                                                              '(|SetCategory|)))
                                              (OR
                                               (AND
                                                (|HasCategory| |#1|
                                                               (LIST
                                                                '|Evalable|
                                                                (|devaluate|
                                                                 |#1|)))
                                                (|HasCategory| |#1|
                                                               '(|Comparable|)))
                                               (AND
                                                (|HasCategory| |#1|
                                                               (LIST
                                                                '|Evalable|
                                                                (|devaluate|
                                                                 |#1|)))
                                                (|HasCategory| |#1|
                                                               '(|Finite|)))
                                               (AND
                                                (|HasCategory| |#1|
                                                               (LIST
                                                                '|Evalable|
                                                                (|devaluate|
                                                                 |#1|)))
                                                (|HasCategory| |#1|
                                                               '(|SetCategory|))))
                                              (|HasCategory| |#1|
                                                             '(|BasicType|))))))
          (|haddProp| |$ConstructorCache| '|Set| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 128))
          (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
               (|augmentPredVector| $ 256))
          (AND (|HasCategory| |#1| '(|OrderedSet|)) #1#
               (|augmentPredVector| $ 512))
          (AND (|HasCategory| |#1| '(|BasicType|)) #1#
               (|augmentPredVector| $ 1024))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|FlexibleArray| |#1|))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 47
                      (CONS (|dispatchFunction| |SET;convert;$If;13|) $))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 49 (CONS (|dispatchFunction| |SET;=;2$B;14|) $))
             (QSETREFV $ 50 (CONS (|dispatchFunction| |SET;max;$S;15|) $))
             (QSETREFV $ 52 (CONS (|dispatchFunction| |SET;min;$S;16|) $))
             (QSETREFV $ 32 (CONS (|dispatchFunction| |SET;map!;M2$;17|) $))
             (QSETREFV $ 58
                       (CONS (|dispatchFunction| |SET;construct;L$;18|) $))
             (QSETREFV $ 62 (CONS (|dispatchFunction| |SET;insert!;S2$;19|) $))
             (QSETREFV $ 63 (CONS (|dispatchFunction| |SET;member?;S$B;20|) $))
             (QSETREFV $ 64 (CONS (|dispatchFunction| |SET;remove!;S2$;21|) $))
             (QSETREFV $ 67
                       (CONS (|dispatchFunction| |SET;intersect;3$;22|) $))
             (QSETREFV $ 68
                       (CONS (|dispatchFunction| |SET;difference;3$;23|) $))
             (QSETREFV $ 69
                       (CONS
                        (|dispatchFunction| |SET;symmetricDifference;3$;24|)
                        $))
             (QSETREFV $ 70 (CONS (|dispatchFunction| |SET;subset?;2$B;25|) $))
             (QSETREFV $ 71 (CONS (|dispatchFunction| |SET;union;3$;26|) $))))
           ('T
            (PROGN
             (QSETREFV $ 62 (CONS (|dispatchFunction| |SET;insert!;S2$;27|) $))
             (QSETREFV $ 64 (CONS (|dispatchFunction| |SET;remove!;S2$;28|) $))
             (QSETREFV $ 32 (CONS (|dispatchFunction| |SET;map!;M2$;29|) $)))))
          $))) 

(MAKEPROP '|Set| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|NonNegativeInteger|) (0 . |#|) |SET;#;$Nni;1| |SET;empty;$;3|
              |SET;set;$;2| (5 . |empty|) (9 . |copy|) |SET;copy;2$;4|
              (|List| 6) (14 . |parts|) |SET;parts;$L;5| (|Boolean|)
              (19 . |empty?|) (|Integer|) (24 . |maxIndex|) (29 . |elt|)
              |SET;inspect;$S;6| (35 . |delete!|) |SET;extract!;$S;7|
              (|Union| 6 '"failed") (|Mapping| 19 6) (41 . |find|)
              |SET;find;M$U;8| (|Mapping| 6 6) (47 . |map!|) |SET;map;M2$;9|
              (|Mapping| 6 6 6) (53 . |reduce|) |SET;reduce;M$S;10|
              (59 . |reduce|) |SET;reduce;M$2S;11| (66 . |reduce|)
              |SET;reduce;M$3S;12| (|Symbol|) (|InputForm|) (74 . |convert|)
              (79 . |convert|) (|List| $) (84 . |convert|) (89 . |convert|)
              (94 . =) (100 . =) (106 . |max|) (111 . |minIndex|) (116 . |min|)
              (121 . |map!|) (127 . |sort!|) (132 . |removeRepeats!|)
              (137 . |new|) (143 . |setelt!|) (150 . |construct|) (155 . >)
              (161 . =) (167 . |insert!|) (174 . |insert!|) (180 . |member?|)
              (186 . |remove!|) (192 . |concat!|) (198 . <) (204 . |intersect|)
              (210 . |difference|) (216 . |symmetricDifference|)
              (222 . |subset?|) (228 . |union|) (234 . |removeDuplicates!|)
              (|List| 74) (|Equation| 6) (|Mapping| 19 6 6) (|PositiveInteger|)
              (|OutputForm|) (|HashState|) (|SingleInteger|) (|String|))
           '#(~= 239 |universe| 245 |union| 249 |symmetricDifference| 267
              |subset?| 273 |smaller?| 279 |size?| 285 |size| 291 |set| 295
              |select!| 304 |select| 310 |sample| 316 |removeDuplicates| 320
              |remove!| 325 |remove| 337 |reduce| 349 |random| 370 |parts| 374
              |more?| 379 |min| 385 |members| 390 |member?| 395 |max| 401
              |map!| 412 |map| 418 |lookup| 424 |less?| 429 |latex| 435
              |intersect| 440 |inspect| 446 |insert!| 451 |index| 457
              |hashUpdate!| 462 |hash| 468 |find| 473 |extract!| 479 |every?|
              484 |eval| 490 |eq?| 516 |enumerate| 522 |empty?| 526 |empty| 531
              |difference| 535 |dictionary| 547 |count| 556 |copy| 568
              |convert| 573 |construct| 578 |complement| 583 |coerce| 588
              |cardinality| 593 |any?| 598 >= 604 > 610 = 616 <= 622 < 628 |#|
              634)
           'NIL
           (CONS
            (|makeByteWordVec2| 6 '(0 0 0 0 0 0 3 0 2 0 0 6 0 0 0 0 0 0 6 1))
            (CONS
             '#(|FiniteSetAggregate&| |Dictionary&| |DictionaryOperations&|
                |BagAggregate&| |SetAggregate&| |Collection&| |Finite&|
                |HomogeneousAggregate&| NIL |Aggregate&| |SetCategory&|
                |Evalable&| NIL NIL |PartialOrder&| |BasicType&| NIL NIL
                |InnerEvalable&| NIL)
             (CONS
              '#((|FiniteSetAggregate| 6) (|Dictionary| 6)
                 (|DictionaryOperations| 6) (|BagAggregate| 6)
                 (|SetAggregate| 6) (|Collection| 6) (|Finite|)
                 (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                 (|SetCategory|) (|Evalable| 6) (|Type|) (|finiteAggregate|)
                 (|PartialOrder|) (|BasicType|) (|CoercibleTo| 77)
                 (|shallowlyMutable|) (|InnerEvalable| 6 6)
                 (|ConvertibleTo| 42))
              (|makeByteWordVec2| 80
                                  '(1 7 8 0 9 0 7 0 13 1 7 0 0 14 1 7 16 0 17 1
                                    0 19 0 20 1 7 21 0 22 2 7 6 0 21 23 2 7 0 0
                                    21 25 2 7 27 28 0 29 2 0 0 31 0 32 2 7 6 34
                                    0 35 3 7 6 34 0 6 37 4 7 6 34 0 6 6 39 1 42
                                    0 41 43 1 16 42 0 44 1 42 0 45 46 1 0 42 0
                                    47 2 7 19 0 0 48 2 0 19 0 0 49 1 0 6 0 50 1
                                    7 21 0 51 1 0 6 0 52 2 7 0 31 0 53 1 7 0 0
                                    54 1 7 0 0 55 2 7 0 8 6 56 3 7 6 0 21 6 57
                                    1 0 0 16 58 2 6 19 0 0 59 2 6 19 0 0 60 3 7
                                    0 6 0 21 61 2 0 0 6 0 62 2 0 19 6 0 63 2 0
                                    0 6 0 64 2 7 0 0 6 65 2 6 19 0 0 66 2 0 0 0
                                    0 67 2 0 0 0 0 68 2 0 0 0 0 69 2 0 19 0 0
                                    70 2 0 0 0 0 71 1 7 0 0 72 2 0 19 0 0 1 0 3
                                    0 1 2 0 0 0 6 1 2 0 0 0 0 71 2 0 0 6 0 1 2
                                    0 0 0 0 69 2 0 19 0 0 70 2 2 19 0 0 1 2 0
                                    19 0 8 1 0 3 8 1 1 0 0 16 1 0 0 0 12 2 9 0
                                    28 0 1 2 9 0 28 0 1 0 0 0 1 1 11 0 0 1 2 11
                                    0 6 0 64 2 9 0 28 0 1 2 11 0 6 0 1 2 9 0 28
                                    0 1 4 11 6 34 0 6 6 40 2 9 6 34 0 36 3 9 6
                                    34 0 6 38 0 3 0 1 1 9 16 0 18 2 0 19 0 8 1
                                    1 10 6 0 52 1 9 16 0 1 2 11 19 6 0 63 1 10
                                    6 0 50 2 9 6 75 0 1 2 8 0 31 0 32 2 0 0 31
                                    0 33 1 3 76 0 1 2 0 19 0 8 1 1 0 80 0 1 2 0
                                    0 0 0 67 1 0 6 0 24 2 0 0 6 0 62 1 3 0 76 1
                                    2 0 78 78 0 1 1 0 79 0 1 2 0 27 28 0 30 1 0
                                    6 0 26 2 9 19 28 0 1 3 5 0 0 6 6 1 3 5 0 0
                                    16 16 1 2 5 0 0 73 1 2 5 0 0 74 1 2 0 19 0
                                    0 1 0 3 45 1 1 0 19 0 20 0 0 0 11 2 0 0 0 0
                                    68 2 0 0 0 6 1 1 0 0 16 1 0 0 0 1 2 11 8 6
                                    0 1 2 9 8 28 0 1 1 0 0 0 15 1 1 42 0 47 1 0
                                    0 16 58 1 3 0 0 1 1 0 77 0 1 1 0 8 0 1 2 9
                                    19 28 0 1 2 0 19 0 0 1 2 0 19 0 0 1 2 0 19
                                    0 0 49 2 0 19 0 0 1 2 0 19 0 0 1 1 9 8 0
                                    10)))))
           '|lookupComplete|)) 
