
(SDEFUN |MSET;elt| ((|t| (|Table| S (|Integer|))) (|s| (S)) ($ (|Integer|)))
        (SPROG ((|a| (|Union| (|Integer|) "failed")))
               (SEQ (LETT |a| (SPADCALL |s| |t| (QREFELT $ 10)))
                    (EXIT (COND ((QEQCAR |a| 1) 0) ('T (QCDR |a|))))))) 

(SDEFUN |MSET;empty;$;2| (($ ($))) (CONS 0 (SPADCALL (QREFELT $ 11)))) 

(SDEFUN |MSET;multiset;$;3| (($ ($))) (SPADCALL (QREFELT $ 12))) 

(SDEFUN |MSET;dictionary;$;4| (($ ($))) (SPADCALL (QREFELT $ 12))) 

(SDEFUN |MSET;set;$;5| (($ ($))) (SPADCALL (QREFELT $ 12))) 

(SDEFUN |MSET;construct;L$;6| ((|l| (|List| S)) ($ ($)))
        (SPROG
         ((|n| (|Integer|)) (#1=#:G725 NIL) (|e| NIL)
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |t| (SPADCALL (QREFELT $ 11))) (LETT |n| 0)
              (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (SPADCALL |t| |e| (+ (|MSET;elt| |t| |e| $) 1)
                              (QREFELT $ 17))
                    (EXIT (LETT |n| (+ |n| 1))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |n| |t|))))) 

(SDEFUN |MSET;multiset;L$;7| ((|l| (|List| S)) ($ ($)))
        (SPADCALL |l| (QREFELT $ 19))) 

(SDEFUN |MSET;dictionary;L$;8| ((|l| (|List| S)) ($ ($)))
        (SPADCALL |l| (QREFELT $ 19))) 

(SDEFUN |MSET;set;L$;9| ((|l| (|List| S)) ($ ($)))
        (SPADCALL |l| (QREFELT $ 19))) 

(SDEFUN |MSET;multiset;S$;10| ((|s| (S)) ($ ($)))
        (SPADCALL (LIST |s|) (QREFELT $ 19))) 

(SDEFUN |MSET;convert;$If;11| ((|ms| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|multiset| (QREFELT $ 26))
               (SPADCALL (SPADCALL |ms| (QREFELT $ 27)) (QREFELT $ 28)))
         (QREFELT $ 30))) 

(SDEFUN |MSET;members;$L;12| ((|ms| ($)) ($ (|List| S)))
        (SPADCALL (QCDR |ms|) (QREFELT $ 32))) 

(SDEFUN |MSET;coerce;$Of;13| ((|ms| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|item| #1=(|OutputForm|))
          (|n| (|Integer|)) (|ex| #1#) (#2=#:G741 NIL) (|e| NIL)
          (|colon| (|OutputForm|)) (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |l| NIL) (LETT |t| (QCDR |ms|))
              (LETT |colon| (SPADCALL " : " (QREFELT $ 36)))
              (SEQ (LETT |e| NIL) (LETT #2# (SPADCALL |t| (QREFELT $ 32))) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ex| (SPADCALL |e| (QREFELT $ 37)))
                        (LETT |n| (|MSET;elt| |t| |e| $))
                        (LETT |item|
                              (COND
                               ((> |n| 1)
                                (SPADCALL
                                 (LIST (SPADCALL |n| (QREFELT $ 38)) |colon|
                                       |ex|)
                                 (QREFELT $ 39)))
                               ('T |ex|)))
                        (EXIT (LETT |l| (CONS |item| |l|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |l| (QREFELT $ 40)))))) 

(SDEFUN |MSET;duplicates;$L;14|
        ((|ms| ($))
         ($
          (|List|
           (|Record| (|:| |entry| S) (|:| |count| (|NonNegativeInteger|))))))
        (SPROG
         ((|ld|
           (|List|
            (|Record| (|:| |entry| S) (|:| |count| (|NonNegativeInteger|)))))
          (#1=#:G747 NIL) (|n| (|Integer|)) (#2=#:G753 NIL) (|e| NIL)
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |ld| NIL) (LETT |t| (QCDR |ms|))
              (SEQ (LETT |e| NIL) (LETT #2# (SPADCALL |t| (QREFELT $ 32))) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (LETT |n| (|MSET;elt| |t| |e| $)) 1)
                       (LETT |ld|
                             (CONS
                              (CONS |e|
                                    (PROG1 (LETT #1# |n|)
                                      (|check_subtype2| (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#)))
                              |ld|))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ld|)))) 

(SDEFUN |MSET;extract!;$S;15| ((|ms| ($)) ($ (S)))
        (SPROG ((|n| (|Integer|)) (|e| (S)) (|t| (|Table| S (|Integer|))))
               (SEQ
                (COND
                 ((SPADCALL |ms| (QREFELT $ 46))
                  (|error| "extract: Empty multiset"))
                 (#1='T
                  (SEQ (PROGN (RPLACA |ms| (- (QCAR |ms|) 1)) (QCAR |ms|))
                       (LETT |t| (QCDR |ms|))
                       (LETT |e| (QCAR (SPADCALL |t| (QREFELT $ 48))))
                       (SEQ (LETT |n| (|MSET;elt| |t| |e| $))
                            (EXIT
                             (COND
                              ((> |n| 1)
                               (SPADCALL |t| |e| (- |n| 1) (QREFELT $ 17)))
                              (#1# (SPADCALL |e| |t| (QREFELT $ 49))))))
                       (EXIT |e|))))))) 

(SDEFUN |MSET;inspect;$S;16| ((|ms| ($)) ($ (S)))
        (QCAR (SPADCALL (QCDR |ms|) (QREFELT $ 48)))) 

(SDEFUN |MSET;insert!;S2$;17| ((|e| (S)) (|ms| ($)) ($ ($)))
        (SEQ (PROGN (RPLACA |ms| (+ (QCAR |ms|) 1)) (QCAR |ms|))
             (SPADCALL (QCDR |ms|) |e| (+ (|MSET;elt| (QCDR |ms|) |e| $) 1)
                       (QREFELT $ 17))
             (EXIT |ms|))) 

(SDEFUN |MSET;member?;S$B;18| ((|e| (S)) (|ms| ($)) ($ (|Boolean|)))
        (SPADCALL |e| (SPADCALL (QCDR |ms|) (QREFELT $ 32)) (QREFELT $ 53))) 

(SDEFUN |MSET;empty?;$B;19| ((|ms| ($)) ($ (|Boolean|))) (EQL (QCAR |ms|) 0)) 

(SDEFUN |MSET;#;$Nni;20| ((|ms| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G770 NIL))
               (PROG1 (LETT #1# (QCAR |ms|))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |MSET;count;S$Nni;21| ((|e| (S)) (|ms| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G772 NIL))
               (PROG1 (LETT #1# (|MSET;elt| (QCDR |ms|) |e| $))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |MSET;remove!;S$I$;22|
        ((|e| (S)) (|ms| ($)) (|max| (|Integer|)) ($ ($)))
        (SPROG ((|n| (|Integer|)) (|t| (|Table| S (|Integer|))))
               (SEQ
                (COND ((ZEROP |max|) (SPADCALL |e| |ms| (QREFELT $ 58)))
                      (#1='T
                       (SEQ (LETT |t| (QCDR |ms|))
                            (COND
                             ((SPADCALL |e| (SPADCALL |t| (QREFELT $ 32))
                                        (QREFELT $ 53))
                              (SEQ (LETT |n| (|MSET;elt| |t| |e| $))
                                   (EXIT
                                    (COND
                                     ((<= |n| |max|)
                                      (SEQ (SPADCALL |e| |t| (QREFELT $ 49))
                                           (EXIT
                                            (PROGN
                                             (RPLACA |ms| (- (QCAR |ms|) |n|))
                                             (QCAR |ms|)))))
                                     ((> |max| 0)
                                      (SEQ
                                       (SPADCALL |t| |e| (- |n| |max|)
                                                 (QREFELT $ 17))
                                       (EXIT
                                        (PROGN
                                         (RPLACA |ms| (- (QCAR |ms|) |max|))
                                         (QCAR |ms|)))))
                                     (#1#
                                      (SEQ (LETT |n| (+ |n| |max|))
                                           (EXIT
                                            (COND
                                             ((> |n| 0)
                                              (SEQ
                                               (SPADCALL |t| |e| (- |max|)
                                                         (QREFELT $ 17))
                                               (EXIT
                                                (PROGN
                                                 (RPLACA |ms|
                                                         (- (QCAR |ms|) |n|))
                                                 (QCAR |ms|))))))))))))))
                            (EXIT |ms|))))))) 

(SDEFUN |MSET;remove!;M$I$;23|
        ((|p| (|Mapping| (|Boolean|) S)) (|ms| ($)) (|max| (|Integer|))
         ($ ($)))
        (SPROG
         ((#1=#:G796 NIL) (|n| (|Integer|)) (#2=#:G797 NIL) (|e| NIL)
          (|t| (|Table| S (|Integer|))))
         (SEQ
          (COND ((ZEROP |max|) (SPADCALL |p| |ms| (QREFELT $ 61)))
                ('T
                 (SEQ (LETT |t| (QCDR |ms|))
                      (SEQ (LETT |e| NIL)
                           (LETT #2# (SPADCALL |t| (QREFELT $ 32))) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |e| |p|)
                               (SEQ (LETT |n| (|MSET;elt| |t| |e| $))
                                    (EXIT
                                     (COND
                                      ((<= |n| |max|)
                                       (SEQ (SPADCALL |e| |t| (QREFELT $ 49))
                                            (EXIT
                                             (PROGN
                                              (RPLACA |ms| (- (QCAR |ms|) |n|))
                                              (QCAR |ms|)))))
                                      ((> |max| 0)
                                       (SEQ
                                        (SPADCALL |t| |e| (- |n| |max|)
                                                  (QREFELT $ 17))
                                        (EXIT
                                         (PROGN
                                          (RPLACA |ms| (- (QCAR |ms|) |max|))
                                          (QCAR |ms|)))))
                                      ('T
                                       (SEQ
                                        (EXIT
                                         (SEQ (LETT |n| (+ |n| |max|))
                                              (EXIT
                                               (COND
                                                ((> |n| 0)
                                                 (PROGN
                                                  (LETT #1#
                                                        (SEQ
                                                         (SPADCALL |t| |e|
                                                                   (- |max|)
                                                                   (QREFELT $
                                                                            17))
                                                         (EXIT
                                                          (PROGN
                                                           (RPLACA |ms|
                                                                   (-
                                                                    (QCAR |ms|)
                                                                    |n|))
                                                           (QCAR |ms|)))))
                                                  (GO #3=#:G790)))))))
                                        #3# (EXIT #1#))))))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |ms|))))))) 

(SDEFUN |MSET;remove;S$I$;24|
        ((|e| (S)) (|ms| ($)) (|max| (|Integer|)) ($ ($)))
        (SPADCALL |e| (SPADCALL |ms| (QREFELT $ 63)) |max| (QREFELT $ 59))) 

(SDEFUN |MSET;remove;M$I$;25|
        ((|p| (|Mapping| (|Boolean|) S)) (|ms| ($)) (|max| (|Integer|))
         ($ ($)))
        (SPADCALL |p| (SPADCALL |ms| (QREFELT $ 63)) |max| (QREFELT $ 62))) 

(SDEFUN |MSET;remove!;S2$;26| ((|e| (S)) (|ms| ($)) ($ ($)))
        (SPROG ((|t| (|Table| S (|Integer|))))
               (SEQ (LETT |t| (QCDR |ms|))
                    (COND
                     ((SPADCALL |e| (SPADCALL |t| (QREFELT $ 32))
                                (QREFELT $ 53))
                      (SEQ
                       (PROGN
                        (RPLACA |ms| (- (QCAR |ms|) (|MSET;elt| |t| |e| $)))
                        (QCAR |ms|))
                       (EXIT (SPADCALL |e| |t| (QREFELT $ 49))))))
                    (EXIT |ms|)))) 

(SDEFUN |MSET;remove!;M2$;27|
        ((|p| (|Mapping| (|Boolean|) S)) (|ms| ($)) ($ ($)))
        (SPROG ((#1=#:G812 NIL) (|e| NIL) (|t| (|Table| S (|Integer|))))
               (SEQ (LETT |t| (QCDR |ms|))
                    (SEQ (LETT |e| NIL)
                         (LETT #1# (SPADCALL |t| (QREFELT $ 32))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |e| |p|)
                             (SEQ
                              (PROGN
                               (RPLACA |ms|
                                       (- (QCAR |ms|) (|MSET;elt| |t| |e| $)))
                               (QCAR |ms|))
                              (EXIT (SPADCALL |e| |t| (QREFELT $ 49))))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ms|)))) 

(SDEFUN |MSET;select!;M2$;28|
        ((|p| (|Mapping| (|Boolean|) S)) (|ms| ($)) ($ ($)))
        (SPADCALL (CONS #'|MSET;select!;M2$;28!0| |p|) |ms| (QREFELT $ 61))) 

(SDEFUN |MSET;select!;M2$;28!0| ((|s1| NIL) (|p| NIL))
        (NULL (SPADCALL |s1| |p|))) 

(SDEFUN |MSET;removeDuplicates!;2$;29| ((|ms| ($)) ($ ($)))
        (SPROG
         ((#1=#:G824 NIL) (|e| NIL) (|l| (|List| S))
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |t| (QCDR |ms|)) (LETT |l| (SPADCALL |t| (QREFELT $ 32)))
              (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |t| |e| 1 (QREFELT $ 17))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (PROGN (RPLACA |ms| (LENGTH |l|)) (QCAR |ms|)) (EXIT |ms|)))) 

(SDEFUN |MSET;insert!;S$Nni$;30|
        ((|e| (S)) (|ms| ($)) (|more| (|NonNegativeInteger|)) ($ ($)))
        (SEQ (PROGN (RPLACA |ms| (+ (QCAR |ms|) |more|)) (QCAR |ms|))
             (SPADCALL (QCDR |ms|) |e|
                       (+ (|MSET;elt| (QCDR |ms|) |e| $) |more|)
                       (QREFELT $ 17))
             (EXIT |ms|))) 

(SDEFUN |MSET;map!;M2$;31| ((|f| (|Mapping| S S)) (|ms| ($)) ($ ($)))
        (SPROG
         ((#1=#:G834 NIL) (|e| NIL) (|t1| (|Table| S (|Integer|)))
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |t| (QCDR |ms|)) (LETT |t1| (SPADCALL (QREFELT $ 11)))
              (SEQ (LETT |e| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 32))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (SPADCALL |t1| (SPADCALL |e| |f|) (|MSET;elt| |t| |e| $)
                              (QREFELT $ 17))
                    (EXIT (SPADCALL |e| |t| (QREFELT $ 49))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (PROGN (RPLACD |ms| |t1|) (QCDR |ms|)) (EXIT |ms|)))) 

(SDEFUN |MSET;map;M2$;32| ((|f| (|Mapping| S S)) (|ms| ($)) ($ ($)))
        (SPADCALL |f| (SPADCALL |ms| (QREFELT $ 63)) (QREFELT $ 70))) 

(SDEFUN |MSET;parts;$L;33| ((|m| ($)) ($ (|List| S)))
        (SPROG
         ((|l| (|List| S)) (#1=#:G846 NIL) (|i| NIL) (#2=#:G845 NIL) (|e| NIL)
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |l| NIL) (LETT |t| (QCDR |m|))
              (SEQ (LETT |e| NIL) (LETT #2# (SPADCALL |t| (QREFELT $ 32))) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #1# (|MSET;elt| |t| |e| $)) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ (EXIT (LETT |l| (CONS |e| |l|))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |l|)))) 

(SDEFUN |MSET;union;3$;34| ((|m1| ($)) (|m2| ($)) ($ ($)))
        (SPROG
         ((#1=#:G854 NIL) (|e| NIL) (#2=#:G853 NIL)
          (|t2| #3=(|Table| S (|Integer|))) (|t1| #3#)
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |t| (SPADCALL (QREFELT $ 11))) (LETT |t1| (QCDR |m1|))
              (LETT |t2| (QCDR |m2|))
              (SEQ (LETT |e| NIL) (LETT #2# (SPADCALL |t1| (QREFELT $ 32)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |t| |e| (|MSET;elt| |t1| |e| $)
                               (QREFELT $ 17))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |e| NIL) (LETT #1# (SPADCALL |t2| (QREFELT $ 32)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |t| |e|
                               (+ (|MSET;elt| |t2| |e| $)
                                  (|MSET;elt| |t| |e| $))
                               (QREFELT $ 17))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (+ (QCAR |m1|) (QCAR |m2|)) |t|))))) 

(SDEFUN |MSET;intersect;3$;35| ((|m1| ($)) (|m2| ($)) ($ ($)))
        (SPROG
         ((|n| (|Integer|)) (|m| (|Integer|)) (#1=#:G861 NIL) (|e| NIL)
          (|t2| #2=(|Table| S (|Integer|))) (|t1| #2#)
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |t| (SPADCALL (QREFELT $ 11))) (LETT |t1| (QCDR |m1|))
              (LETT |t2| (QCDR |m2|)) (LETT |n| 0)
              (SEQ (LETT |e| NIL) (LETT #1# (SPADCALL |t1| (QREFELT $ 32)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |m|
                          (MIN (|MSET;elt| |t1| |e| $)
                               (|MSET;elt| |t2| |e| $)))
                    (EXIT
                     (COND
                      ((> |m| 0)
                       (SEQ
                        (LETT |m|
                              (+ (|MSET;elt| |t1| |e| $)
                                 (|MSET;elt| |t2| |e| $)))
                        (SPADCALL |t| |e| |m| (QREFELT $ 17))
                        (EXIT (LETT |n| (+ |n| |m|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |n| |t|))))) 

(SDEFUN |MSET;difference;3$;36| ((|m1| ($)) (|m2| ($)) ($ ($)))
        (SPROG
         ((|n| (|Integer|)) (|k2| #1=(|Integer|)) (|k1| #1#) (#2=#:G868 NIL)
          (|e| NIL) (|t2| #3=(|Table| S (|Integer|))) (|t1| #3#)
          (|t| (|Table| S (|Integer|))))
         (SEQ (LETT |t| (SPADCALL (QREFELT $ 11))) (LETT |t1| (QCDR |m1|))
              (LETT |t2| (QCDR |m2|)) (LETT |n| 0)
              (SEQ (LETT |e| NIL) (LETT #2# (SPADCALL |t1| (QREFELT $ 32)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |k1| (|MSET;elt| |t1| |e| $))
                        (LETT |k2| (|MSET;elt| |t2| |e| $))
                        (EXIT
                         (COND
                          ((> |k1| 0)
                           (COND
                            ((EQL |k2| 0)
                             (SEQ (SPADCALL |t| |e| |k1| (QREFELT $ 17))
                                  (EXIT (LETT |n| (+ |n| |k1|))))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 12)))
                     ('T (CONS |n| |t|))))))) 

(SDEFUN |MSET;symmetricDifference;3$;37| ((|m1| ($)) (|m2| ($)) ($ ($)))
        (SPADCALL (SPADCALL |m1| |m2| (QREFELT $ 74))
                  (SPADCALL |m2| |m1| (QREFELT $ 74)) (QREFELT $ 72))) 

(SDEFUN |MSET;=;2$B;38| ((|m1| ($)) (|m2| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G880 NIL) (#2=#:G882 NIL) (#3=#:G884 NIL) (|e| NIL)
          (#4=#:G881 NIL) (#5=#:G883 NIL) (|t2| #6=(|Table| S (|Integer|)))
          (|t1| #6#))
         (SEQ
          (EXIT
           (COND ((SPADCALL (QCAR |m1|) (QCAR |m2|) (QREFELT $ 76)) NIL)
                 ('T
                  (SEQ (LETT |t1| (QCDR |m1|)) (LETT |t2| (QCDR |m2|))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |e| NIL)
                              (LETT #5# (SPADCALL |t1| (QREFELT $ 32))) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |e| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (|MSET;elt| |t1| |e| $)
                                            (|MSET;elt| |t2| |e| $)
                                            (QREFELT $ 76))
                                  (PROGN
                                   (LETT #4#
                                         (PROGN (LETT #2# NIL) (GO #7=#:G879)))
                                   (GO #8=#:G873))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL)))
                        #8# (EXIT #4#))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |e| NIL)
                              (LETT #3# (SPADCALL |t2| (QREFELT $ 32))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |e| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (|MSET;elt| |t1| |e| $)
                                            (|MSET;elt| |t2| |e| $)
                                            (QREFELT $ 76))
                                  (PROGN
                                   (LETT #1# (PROGN (LETT #2# NIL) (GO #7#)))
                                   (GO #9=#:G876))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                        #9# (EXIT #1#))
                       (EXIT 'T)))))
          #7# (EXIT #2#)))) 

(SDEFUN |MSET;<;2$B;39| ((|m1| ($)) (|m2| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G892 NIL) (#2=#:G893 NIL) (#3=#:G894 NIL) (|e| NIL)
          (|t2| #4=(|Table| S (|Integer|))) (|t1| #4#))
         (SEQ
          (EXIT
           (COND ((>= (QCAR |m1|) (QCAR |m2|)) NIL)
                 ('T
                  (SEQ (LETT |t1| (QCDR |m1|)) (LETT |t2| (QCDR |m2|))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |e| NIL)
                              (LETT #3# (SPADCALL |t1| (QREFELT $ 32))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |e| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((> (|MSET;elt| |t1| |e| $)
                                     (|MSET;elt| |t2| |e| $))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #5=#:G891)))
                                   (GO #6=#:G888))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (EXIT (< (QCAR |m1|) (QCAR |m2|)))))))
          #5# (EXIT #2#)))) 

(SDEFUN |MSET;subset?;2$B;40| ((|m1| ($)) (|m2| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G902 NIL) (#2=#:G903 NIL) (#3=#:G904 NIL) (|e| NIL)
          (|t2| #4=(|Table| S (|Integer|))) (|t1| #4#))
         (SEQ
          (EXIT
           (COND ((> (QCAR |m1|) (QCAR |m2|)) NIL)
                 ('T
                  (SEQ (LETT |t1| (QCDR |m1|)) (LETT |t2| (QCDR |m2|))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |e| NIL)
                              (LETT #3# (SPADCALL |t1| (QREFELT $ 32))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |e| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((> (|MSET;elt| |t1| |e| $)
                                     (|MSET;elt| |t2| |e| $))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #5=#:G901)))
                                   (GO #6=#:G898))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |MSET;<=;2$B;41| ((|m1| ($)) (|m2| ($)) ($ (|Boolean|)))
        (SPADCALL |m1| |m2| (QREFELT $ 79))) 

(DECLAIM (NOTINLINE |Multiset;|)) 

(DEFUN |Multiset| (#1=#:G912)
  (SPROG NIL
         (PROG (#2=#:G913)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Multiset|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Multiset;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Multiset|)))))))))) 

(DEFUN |Multiset;| (|#1|)
  (SPROG ((#1=#:G911 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Multiset| DV$1))
          (LETT $ (GETREFV 88))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (AND
                                               (|HasCategory| |#1|
                                                              (LIST '|Evalable|
                                                                    (|devaluate|
                                                                     |#1|)))
                                               (|HasCategory| |#1|
                                                              '(|SetCategory|)))
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#1|
                                                             '(|BasicType|))))))
          (|haddProp| |$ConstructorCache| '|Multiset| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 16))
          (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
               (|augmentPredVector| $ 32))
          (AND (|HasCategory| |#1| '(|OrderedSet|)) #1#
               (|augmentPredVector| $ 64))
          (AND (|HasCategory| |#1| '(|BasicType|)) #1#
               (|augmentPredVector| $ 128))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |count| (|Integer|))
                              (|:| |table| (|Table| |#1| (|Integer|)))))
          (COND
           ((|testBitVector| |pv$| 2)
            (QSETREFV $ 31
                      (CONS (|dispatchFunction| |MSET;convert;$If;11|) $))))
          $))) 

(MAKEPROP '|Multiset| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|Union| 16 '"failed") (|Table| 6 16) (0 . |search|)
              (6 . |table|) |MSET;empty;$;2| |MSET;multiset;$;3|
              |MSET;dictionary;$;4| |MSET;set;$;5| (|Integer|) (10 . |setelt!|)
              (|List| 6) |MSET;construct;L$;6| |MSET;multiset;L$;7|
              |MSET;dictionary;L$;8| |MSET;set;L$;9| |MSET;multiset;S$;10|
              (|Symbol|) (|InputForm|) (17 . |convert|) |MSET;parts;$L;33|
              (22 . |convert|) (|List| $) (27 . |convert|) (32 . |convert|)
              (37 . |keys|) |MSET;members;$L;12| (|String|) (|OutputForm|)
              (42 . |message|) (47 . |coerce|) (52 . |coerce|) (57 . |hconcat|)
              (62 . |brace|) |MSET;coerce;$Of;13|
              (|Record| (|:| |entry| 6) (|:| |count| 55)) (|List| 42)
              |MSET;duplicates;$L;14| (|Boolean|) |MSET;empty?;$B;19|
              (|Record| (|:| |key| 6) (|:| |entry| 16)) (67 . |inspect|)
              (72 . |remove!|) |MSET;extract!;$S;15| |MSET;inspect;$S;16|
              |MSET;insert!;S2$;17| (78 . |member?|) |MSET;member?;S$B;18|
              (|NonNegativeInteger|) |MSET;#;$Nni;20| |MSET;count;S$Nni;21|
              |MSET;remove!;S2$;26| |MSET;remove!;S$I$;22| (|Mapping| 45 6)
              |MSET;remove!;M2$;27| |MSET;remove!;M$I$;23| (84 . |copy|)
              |MSET;remove;S$I$;24| |MSET;remove;M$I$;25| |MSET;select!;M2$;28|
              |MSET;removeDuplicates!;2$;29| |MSET;insert!;S$Nni$;30|
              (|Mapping| 6 6) |MSET;map!;M2$;31| |MSET;map;M2$;32|
              |MSET;union;3$;34| |MSET;intersect;3$;35| |MSET;difference;3$;36|
              |MSET;symmetricDifference;3$;37| (89 . ~=) |MSET;=;2$B;38|
              |MSET;<;2$B;39| |MSET;subset?;2$B;40| |MSET;<=;2$B;41|
              (|Mapping| 6 6 6) (|Equation| 6) (|List| 82) (|Mapping| 45 6 6)
              (|SingleInteger|) (|HashState|) (|Union| 6 '"failed"))
           '#(~= 95 |union| 101 |symmetricDifference| 119 |subset?| 125 |size?|
              131 |set| 137 |select!| 146 |select| 152 |sample| 158
              |removeDuplicates!| 162 |removeDuplicates| 167 |remove!| 172
              |remove| 198 |reduce| 224 |parts| 245 |multiset| 250 |more?| 264
              |min| 270 |members| 275 |member?| 280 |max| 286 |map!| 297 |map|
              303 |less?| 309 |latex| 315 |intersect| 320 |inspect| 326
              |insert!| 331 |hashUpdate!| 344 |hash| 350 |find| 355 |extract!|
              361 |every?| 366 |eval| 372 |eq?| 398 |empty?| 404 |empty| 409
              |duplicates| 413 |difference| 418 |dictionary| 430 |count| 439
              |copy| 451 |convert| 456 |construct| 461 |coerce| 466 |any?| 471
              >= 477 > 483 = 489 <= 495 < 501 |#| 507)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 2))
                 (CONS
                  '#(NIL NIL |DictionaryOperations&| |BagAggregate&|
                     |SetAggregate&| |Collection&| |HomogeneousAggregate&|
                     |Aggregate&| |SetCategory&| |Evalable&| NIL NIL
                     |PartialOrder&| NIL |BasicType&| NIL |InnerEvalable&| NIL)
                  (CONS
                   '#((|MultisetAggregate| 6) (|MultiDictionary| 6)
                      (|DictionaryOperations| 6) (|BagAggregate| 6)
                      (|SetAggregate| 6) (|Collection| 6)
                      (|HomogeneousAggregate| 6) (|Aggregate|) (|SetCategory|)
                      (|Evalable| 6) (|Type|) (|finiteAggregate|)
                      (|PartialOrder|) (|CoercibleTo| 35) (|BasicType|)
                      (|shallowlyMutable|) (|InnerEvalable| 6 6)
                      (|ConvertibleTo| 25))
                   (|makeByteWordVec2| 87
                                       '(2 9 8 6 0 10 0 9 0 11 3 9 16 0 6 16 17
                                         1 25 0 24 26 1 18 25 0 28 1 25 0 29 30
                                         1 0 25 0 31 1 9 18 0 32 1 35 0 34 36 1
                                         6 35 0 37 1 16 35 0 38 1 35 0 29 39 1
                                         35 0 29 40 1 9 47 0 48 2 9 8 6 0 49 2
                                         18 45 6 0 53 1 0 0 0 63 2 16 45 0 0 76
                                         2 0 45 0 0 1 2 0 0 0 0 72 2 0 0 6 0 1
                                         2 0 0 0 6 1 2 0 0 0 0 75 2 0 45 0 0 79
                                         2 0 45 0 55 1 0 0 0 15 1 0 0 18 22 2 6
                                         0 60 0 66 2 6 0 60 0 1 0 0 0 1 1 0 0 0
                                         67 1 8 0 0 1 2 8 0 6 0 58 2 6 0 60 0
                                         61 3 0 0 6 0 16 59 3 0 0 60 0 16 62 2
                                         8 0 6 0 1 2 6 0 60 0 1 3 0 0 6 0 16 64
                                         3 0 0 60 0 16 65 4 8 6 81 0 6 6 1 3 6
                                         6 81 0 6 1 2 6 6 81 0 1 1 6 18 0 27 1
                                         0 0 6 23 1 0 0 18 20 0 0 0 13 2 0 45 0
                                         55 1 1 7 6 0 1 1 6 18 0 33 2 8 45 6 0
                                         54 1 7 6 0 1 2 6 6 84 0 1 2 5 0 69 0
                                         70 2 0 0 69 0 71 2 0 45 0 55 1 1 0 34
                                         0 1 2 0 0 0 0 73 1 0 6 0 51 3 0 0 6 0
                                         55 68 2 0 0 6 0 52 2 0 86 86 0 1 1 0
                                         85 0 1 2 0 87 60 0 1 1 0 6 0 50 2 6 45
                                         60 0 1 3 1 0 0 18 18 1 2 1 0 0 82 1 3
                                         1 0 0 6 6 1 2 1 0 0 83 1 2 0 45 0 0 1
                                         1 0 45 0 46 0 0 0 12 1 0 43 0 44 2 0 0
                                         0 6 1 2 0 0 0 0 74 1 0 0 18 21 0 0 0
                                         14 2 8 55 6 0 57 2 6 55 60 0 1 1 0 0 0
                                         63 1 2 25 0 31 1 0 0 18 19 1 0 35 0 41
                                         2 6 45 60 0 1 2 0 45 0 0 1 2 0 45 0 0
                                         1 2 0 45 0 0 77 2 0 45 0 0 80 2 0 45 0
                                         0 78 1 6 55 0 56)))))
           '|lookupComplete|)) 
