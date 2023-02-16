
(SDEFUN |URAGG-;elt;AfirstS;1| ((|x| (A)) (T1 ("first")) ($ (S)))
        (SPADCALL |x| (QREFELT $ 8))) 

(SDEFUN |URAGG-;elt;AlastS;2| ((|x| (A)) (T2 ("last")) ($ (S)))
        (SPADCALL |x| (QREFELT $ 11))) 

(SDEFUN |URAGG-;elt;ArestA;3| ((|x| (A)) (T3 ("rest")) ($ (A)))
        (SPADCALL |x| (QREFELT $ 14))) 

(SDEFUN |URAGG-;second;AS;4| ((|x| (A)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 8))) 

(SDEFUN |URAGG-;third;AS;5| ((|x| (A)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 14))
                  (QREFELT $ 8))) 

(SDEFUN |URAGG-;cyclic?;AB;6| ((|x| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 20)) NIL)
              ('T (NULL (SPADCALL (|URAGG-;findCycle| |x| $) (QREFELT $ 20)))))) 

(SDEFUN |URAGG-;last;AS;7| ((|x| (A)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 22)) (QREFELT $ 8))) 

(SDEFUN |URAGG-;first;ANniA;8| ((|x| (A)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPROG ((|l| (|List| S)) (|res| (A)) (#1=#:G784 NIL) (|i| NIL))
               (SEQ (LETT |l| NIL)
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x| (QREFELT $ 20))
                             (|error| "Index out of range"))
                            ('T
                             (SEQ
                              (LETT |l|
                                    (CONS (SPADCALL |x| (QREFELT $ 8)) |l|))
                              (EXIT
                               (LETT |x| (SPADCALL |x| (QREFELT $ 14)))))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (LETT |res| (SPADCALL (QREFELT $ 24)))
                    (SEQ G190 (COND ((NULL (NULL (NULL |l|))) (GO G191)))
                         (SEQ
                          (LETT |res|
                                (SPADCALL (|SPADfirst| |l|) |res|
                                          (QREFELT $ 25)))
                          (EXIT (LETT |l| (CDR |l|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |URAGG-;nodes;AL;9| ((|x| (A)) ($ (|List| A)))
        (SPROG ((|l| (|List| A)))
               (SEQ (LETT |l| NIL)
                    (SEQ G190
                         (COND
                          ((NULL (NULL (SPADCALL |x| (QREFELT $ 20))))
                           (GO G191)))
                         (SEQ (LETT |l| (CONS |x| |l|))
                              (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 14)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |l|))))) 

(SDEFUN |URAGG-;children;AL;10| ((|x| (A)) ($ (|List| A)))
        (COND
         ((SPADCALL |x| (QREFELT $ 20))
          (|error| "children: argument is empty"))
         ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 20)) NIL)
         ('T (LIST (SPADCALL |x| (QREFELT $ 14)))))) 

(SDEFUN |URAGG-;leaves;AL;11| ((|x| (A)) ($ (|List| S)))
        (COND ((SPADCALL |x| (QREFELT $ 20)) NIL)
              ('T (LIST (SPADCALL |x| (QREFELT $ 11)))))) 

(SDEFUN |URAGG-;leaf?;AB;12| ((|x| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 20)) NIL)
              ('T (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 20))))) 

(SDEFUN |URAGG-;value;AS;13| ((|x| (A)) ($ (S)))
        (COND ((SPADCALL |x| (QREFELT $ 20)) (|error| "value of empty object"))
              ('T (SPADCALL |x| (QREFELT $ 8))))) 

(SDEFUN |URAGG-;less?;ANniB;14|
        ((|l| (A)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (LETT |i| |n|)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((> |i| 0) (NULL (SPADCALL |l| (QREFELT $ 20))))
                             ('T NIL)))
                           (GO G191)))
                         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 14)))
                              (EXIT (LETT |i| (- |i| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (> |i| 0))))) 

(SDEFUN |URAGG-;more?;ANniB;15|
        ((|l| (A)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (LETT |i| |n|)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((> |i| 0) (NULL (SPADCALL |l| (QREFELT $ 20))))
                             ('T NIL)))
                           (GO G191)))
                         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 14)))
                              (EXIT (LETT |i| (- |i| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND ((ZEROP |i|) (NULL (SPADCALL |l| (QREFELT $ 20))))
                           ('T NIL)))))) 

(SDEFUN |URAGG-;size?;ANniB;16|
        ((|l| (A)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (LETT |i| |n|)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((SPADCALL |l| (QREFELT $ 20)) NIL)
                                  ('T (> |i| 0))))
                           (GO G191)))
                         (SEQ (LETT |l| (SPADCALL |l| (QREFELT $ 14)))
                              (EXIT (LETT |i| (- |i| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND ((SPADCALL |l| (QREFELT $ 20)) (ZEROP |i|))
                           ('T NIL)))))) 

(SDEFUN |URAGG-;tail;2A;17| ((|x| (A)) ($ (A)))
        (SPROG ((|y| (A)) (|k| NIL))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 20)) (|error| "empty list"))
                      ('T
                       (SEQ (LETT |y| (SPADCALL |x| (QREFELT $ 14)))
                            (SEQ (LETT |k| 0) G190
                                 (COND
                                  ((NULL (NULL (SPADCALL |y| (QREFELT $ 20))))
                                   (GO G191)))
                                 (SEQ
                                  (COND
                                   ((EQL |k| 1000)
                                    (COND
                                     ((SPADCALL |x| (QREFELT $ 38))
                                      (EXIT (|error| "cyclic list"))))))
                                  (EXIT
                                   (LETT |y|
                                         (SPADCALL (LETT |x| |y|)
                                                   (QREFELT $ 14)))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |x|))))))) 

(SDEFUN |URAGG-;findCycle| ((|x| (A)) ($ (A)))
        (SPROG ((|y| (A)) (#1=#:G837 NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |y| (SPADCALL |x| (QREFELT $ 14)))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |y| (QREFELT $ 20))))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL |x| |y| (QREFELT $ 40))
                              (PROGN (LETT #1# |x|) (GO #2=#:G836))))
                            (LETT |x| (SPADCALL |x| (QREFELT $ 14)))
                            (LETT |y| (SPADCALL |y| (QREFELT $ 14)))
                            (COND
                             ((SPADCALL |y| (QREFELT $ 20))
                              (PROGN (LETT #1# |y|) (GO #2#))))
                            (COND
                             ((SPADCALL |x| |y| (QREFELT $ 40))
                              (PROGN (LETT #1# |y|) (GO #2#))))
                            (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 14)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |y|)))
                #2# (EXIT #1#)))) 

(SDEFUN |URAGG-;cycleTail;2A;19| ((|x| (A)) ($ (A)))
        (SPROG ((|z| (A)) (|y| (A)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |y| (LETT |x| (SPADCALL |x| (QREFELT $ 41))))
                            (QREFELT $ 20))
                  |x|)
                 ('T
                  (SEQ (LETT |z| (SPADCALL |x| (QREFELT $ 14)))
                       (SEQ G190
                            (COND
                             ((NULL (NULL (SPADCALL |x| |z| (QREFELT $ 40))))
                              (GO G191)))
                            (SEQ (LETT |y| |z|)
                                 (EXIT
                                  (LETT |z| (SPADCALL |z| (QREFELT $ 14)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |y|))))))) 

(SDEFUN |URAGG-;cycleEntry;2A;20| ((|x| (A)) ($ (A)))
        (SPROG ((|y| (A)) (#1=#:G858 NIL) (|k| NIL) (|z| (A)) (|l| NIL))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 20)) |x|)
                      ((SPADCALL (LETT |y| (|URAGG-;findCycle| |x| $))
                                 (QREFELT $ 20))
                       |y|)
                      ('T
                       (SEQ (LETT |z| (SPADCALL |y| (QREFELT $ 14)))
                            (SEQ (LETT |l| 1) G190
                                 (COND
                                  ((NULL
                                    (NULL (SPADCALL |y| |z| (QREFELT $ 40))))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |z| (SPADCALL |z| (QREFELT $ 14)))))
                                 (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |y| |x|)
                            (SEQ (LETT |k| 1) (LETT #1# |l|) G190
                                 (COND ((|greater_SI| |k| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |y| (SPADCALL |y| (QREFELT $ 14)))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (NULL (SPADCALL |x| |y| (QREFELT $ 40))))
                                   (GO G191)))
                                 (SEQ (LETT |x| (SPADCALL |x| (QREFELT $ 14)))
                                      (EXIT
                                       (LETT |y|
                                             (SPADCALL |y| (QREFELT $ 14)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT |x|))))))) 

(SDEFUN |URAGG-;cycleLength;ANni;21| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG ((|y| (A)) (|k| NIL))
               (SEQ
                (COND
                 ((OR (SPADCALL |x| (QREFELT $ 20))
                      (SPADCALL (LETT |x| (|URAGG-;findCycle| |x| $))
                                (QREFELT $ 20)))
                  0)
                 ('T
                  (SEQ (LETT |y| (SPADCALL |x| (QREFELT $ 14)))
                       (SEQ (LETT |k| 1) G190
                            (COND
                             ((NULL (NULL (SPADCALL |x| |y| (QREFELT $ 40))))
                              (GO G191)))
                            (SEQ
                             (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 14)))))
                            (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT |k|))))))) 

(SDEFUN |URAGG-;rest;ANniA;22| ((|x| (A)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPROG ((#1=#:G871 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |x| (QREFELT $ 20))
                         (|error| "Index out of range"))
                        ('T (LETT |x| (SPADCALL |x| (QREFELT $ 14)))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |x|)))) 

(SDEFUN |URAGG-;#;ANni;23| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG ((|k| NIL))
               (SEQ
                (SEQ (LETT |k| 0) G190
                     (COND
                      ((NULL (NULL (SPADCALL |x| (QREFELT $ 20)))) (GO G191)))
                     (SEQ
                      (COND
                       ((EQL |k| 1000)
                        (COND
                         ((SPADCALL |x| (QREFELT $ 38))
                          (EXIT (|error| "cyclic list"))))))
                      (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 14)))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT |k|)))) 

(SDEFUN |URAGG-;last;ANniA;24| ((|x| (A)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPROG ((|xn| (A)) (#1=#:G888 NIL) (|i| NIL))
               (SEQ (LETT |xn| |x|)
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |xn| (QREFELT $ 20))
                             (|error| "index out of range"))
                            ('T (LETT |xn| (SPADCALL |xn| (QREFELT $ 14)))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (SEQ G190
                         (COND
                          ((NULL (NULL (SPADCALL |xn| (QREFELT $ 20))))
                           (GO G191)))
                         (SEQ (LETT |xn| (SPADCALL |xn| (QREFELT $ 14)))
                              (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 14)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |x| (QREFELT $ 47)))))) 

(SDEFUN |URAGG-;=;2AB;25| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G899 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (COND ((SPADCALL |x| |y| (QREFELT $ 40)) 'T)
                       (#2='T
                        (SEQ
                         (SEQ (LETT |k| 0) G190
                              (COND
                               ((NULL
                                 (COND ((SPADCALL |x| (QREFELT $ 20)) NIL)
                                       ('T
                                        (NULL (SPADCALL |y| (QREFELT $ 20))))))
                                (GO G191)))
                              (SEQ
                               (COND
                                ((EQL |k| 1000)
                                 (COND
                                  ((SPADCALL |x| (QREFELT $ 38))
                                   (EXIT (|error| "cyclic list"))))))
                               (EXIT
                                (COND
                                 ((SPADCALL (SPADCALL |x| (QREFELT $ 8))
                                            (SPADCALL |y| (QREFELT $ 8))
                                            (QREFELT $ 49))
                                  (PROGN (LETT #1# NIL) (GO #3=#:G898)))
                                 ('T
                                  (SEQ (LETT |x| (SPADCALL |x| (QREFELT $ 14)))
                                       (EXIT
                                        (LETT |y|
                                              (SPADCALL |y|
                                                        (QREFELT $ 14)))))))))
                              (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT
                          (COND
                           ((SPADCALL |x| (QREFELT $ 20))
                            (SPADCALL |y| (QREFELT $ 20)))
                           (#2# NIL)))))))
                #3# (EXIT #1#)))) 

(SDEFUN |URAGG-;node?;2AB;26| ((|u| (A)) (|v| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G908 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (COND ((SPADCALL |v| (QREFELT $ 20)) NIL)
                       ('T
                        (SEQ
                         (SEQ (LETT |k| 0) G190
                              (COND
                               ((NULL (NULL (SPADCALL |v| (QREFELT $ 20))))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |u| |v| (QREFELT $ 51))
                                  (PROGN (LETT #1# 'T) (GO #2=#:G907)))
                                 ('T
                                  (SEQ
                                   (COND
                                    ((EQL |k| 1000)
                                     (COND
                                      ((SPADCALL |v| (QREFELT $ 38))
                                       (EXIT (|error| "cyclic list"))))))
                                   (EXIT
                                    (LETT |v|
                                          (SPADCALL |v| (QREFELT $ 14)))))))))
                              (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT (SPADCALL |u| |v| (QREFELT $ 51)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |URAGG-;setelt!;Afirst2S;27|
        ((|x| (A)) (T4 ("first")) (|a| (S)) ($ (S)))
        (SPADCALL |x| |a| (QREFELT $ 53))) 

(SDEFUN |URAGG-;setelt!;Alast2S;28| ((|x| (A)) (T5 ("last")) (|a| (S)) ($ (S)))
        (SPADCALL |x| |a| (QREFELT $ 55))) 

(SDEFUN |URAGG-;setelt!;Arest2A;29| ((|x| (A)) (T6 ("rest")) (|a| (A)) ($ (A)))
        (SPADCALL |x| |a| (QREFELT $ 57))) 

(SDEFUN |URAGG-;concat;3A;30| ((|x| (A)) (|y| (A)) ($ (A)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 47)) |y| (QREFELT $ 59))) 

(SDEFUN |URAGG-;concat!;LA;31| ((|lu| (|List| A)) ($ (A)))
        (SPROG ((|t| (A)) (#1=#:G923 NIL) (|u| NIL) (|res| (A)))
               (SEQ
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |lu|) NIL)
                              ('T
                               (SPADCALL (|SPADfirst| |lu|) (QREFELT $ 20)))))
                       (GO G191)))
                     (SEQ (EXIT (LETT |lu| (CDR |lu|)))) NIL (GO G190) G191
                     (EXIT NIL))
                (EXIT
                 (COND ((NULL |lu|) (SPADCALL (QREFELT $ 24)))
                       ('T
                        (SEQ (LETT |res| (|SPADfirst| |lu|))
                             (LETT |t| (SPADCALL |res| (QREFELT $ 22)))
                             (SEQ (LETT |u| NIL) (LETT #1# (CDR |lu|)) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |u| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((NULL (SPADCALL |u| (QREFELT $ 20)))
                                      (SEQ (SPADCALL |t| |u| (QREFELT $ 57))
                                           (EXIT
                                            (LETT |t|
                                                  (SPADCALL |t|
                                                            (QREFELT $
                                                                     22)))))))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT |res|)))))))) 

(SDEFUN |URAGG-;qsetfirst!;A2S;32| ((|x| (A)) (|a| (S)) ($ (S)))
        (SPADCALL |x| |a| (QREFELT $ 53))) 

(SDEFUN |URAGG-;qsetrest!;3A;33| ((|x| (A)) (|a| (A)) ($ (A)))
        (SPADCALL |x| |a| (QREFELT $ 57))) 

(SDEFUN |URAGG-;setlast!;A2S;34| ((|x| (A)) (|s| (S)) ($ (S)))
        (SEQ
         (COND ((SPADCALL |x| (QREFELT $ 20)) (|error| "setlast: empty list"))
               ('T
                (SEQ
                 (SPADCALL (SPADCALL |x| (QREFELT $ 22)) |s| (QREFELT $ 53))
                 (EXIT |s|)))))) 

(SDEFUN |URAGG-;setchildren!;ALA;35| ((|u| (A)) (|lv| (|List| A)) ($ (A)))
        (COND
         ((EQL (LENGTH |lv|) 1)
          (SPADCALL |u| (|SPADfirst| |lv|) (QREFELT $ 57)))
         ('T (|error| "wrong number of children specified")))) 

(SDEFUN |URAGG-;setvalue!;A2S;36| ((|u| (A)) (|s| (S)) ($ (S)))
        (SPADCALL |u| |s| (QREFELT $ 53))) 

(SDEFUN |URAGG-;split!;ANniA;37|
        ((|p| (A)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPROG ((|q| (A)) (#1=#:G932 NIL))
               (SEQ
                (COND ((< |n| 1) (|error| "index out of range"))
                      ('T
                       (SEQ
                        (LETT |p|
                              (SPADCALL |p|
                                        (PROG1 (LETT #1# (- |n| 1))
                                          (|check_subtype2| (>= #1# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #1#))
                                        (QREFELT $ 67)))
                        (LETT |q| (SPADCALL |p| (QREFELT $ 14)))
                        (SPADCALL |p| (SPADCALL (QREFELT $ 24)) (QREFELT $ 57))
                        (EXIT |q|))))))) 

(SDEFUN |URAGG-;cycleSplit!;2A;38| ((|x| (A)) ($ (A)))
        (SPROG ((|z| (A)) (|y| (A)))
               (SEQ
                (COND
                 ((OR
                   (SPADCALL (LETT |y| (SPADCALL |x| (QREFELT $ 41)))
                             (QREFELT $ 20))
                   (SPADCALL |x| |y| (QREFELT $ 40)))
                  |y|)
                 ('T
                  (SEQ (LETT |z| (SPADCALL |x| (QREFELT $ 14)))
                       (SEQ G190
                            (COND
                             ((NULL (NULL (SPADCALL |z| |y| (QREFELT $ 40))))
                              (GO G191)))
                            (SEQ (LETT |x| |z|)
                                 (EXIT
                                  (LETT |z| (SPADCALL |z| (QREFELT $ 14)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (SPADCALL |x| (SPADCALL (QREFELT $ 24)) (QREFELT $ 57))
                       (EXIT |y|))))))) 

(SDEFUN |URAGG-;map!;M2A;39| ((|f| (|Mapping| S S)) (|l| (A)) ($ (A)))
        (SPROG ((|y| (A)))
               (SEQ (LETT |y| |l|)
                    (SEQ G190
                         (COND
                          ((NULL (NULL (SPADCALL |l| (QREFELT $ 20))))
                           (GO G191)))
                         (SEQ
                          (SPADCALL |l|
                                    (SPADCALL (SPADCALL |l| (QREFELT $ 8)) |f|)
                                    (QREFELT $ 53))
                          (EXIT (LETT |l| (SPADCALL |l| (QREFELT $ 14)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |y|)))) 

(DECLAIM (NOTINLINE |UnaryRecursiveAggregate&;|)) 

(DEFUN |UnaryRecursiveAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnaryRecursiveAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 73))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|shallowlyMutable|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|finiteAggregate|))
            (PROGN
             (QSETREFV $ 46 (CONS (|dispatchFunction| |URAGG-;#;ANni;23|) $))
             (QSETREFV $ 48
                       (CONS (|dispatchFunction| |URAGG-;last;ANniA;24|) $)))))
          (COND
           ((|HasCategory| |#1| '(|finiteAggregate|))
            (COND
             ((|HasCategory| |#2| '(|BasicType|))
              (PROGN
               (QSETREFV $ 50 (CONS (|dispatchFunction| |URAGG-;=;2AB;25|) $))
               (QSETREFV $ 52
                         (CONS (|dispatchFunction| |URAGG-;node?;2AB;26|)
                               $)))))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 54
                       (CONS (|dispatchFunction| |URAGG-;setelt!;Afirst2S;27|)
                             $))
             (QSETREFV $ 56
                       (CONS (|dispatchFunction| |URAGG-;setelt!;Alast2S;28|)
                             $))
             (QSETREFV $ 58
                       (CONS (|dispatchFunction| |URAGG-;setelt!;Arest2A;29|)
                             $))
             (QSETREFV $ 60
                       (CONS (|dispatchFunction| |URAGG-;concat;3A;30|) $))
             (QSETREFV $ 61
                       (CONS (|dispatchFunction| |URAGG-;concat!;LA;31|) $))
             (QSETREFV $ 62
                       (CONS (|dispatchFunction| |URAGG-;qsetfirst!;A2S;32|)
                             $))
             (QSETREFV $ 63
                       (CONS (|dispatchFunction| |URAGG-;qsetrest!;3A;33|) $))
             (QSETREFV $ 64
                       (CONS (|dispatchFunction| |URAGG-;setlast!;A2S;34|) $))
             (QSETREFV $ 65
                       (CONS (|dispatchFunction| |URAGG-;setchildren!;ALA;35|)
                             $))
             (QSETREFV $ 66
                       (CONS (|dispatchFunction| |URAGG-;setvalue!;A2S;36|) $))
             (QSETREFV $ 68
                       (CONS (|dispatchFunction| |URAGG-;split!;ANniA;37|) $))
             (QSETREFV $ 69
                       (CONS (|dispatchFunction| |URAGG-;cycleSplit!;2A;38|)
                             $))
             (QSETREFV $ 71
                       (CONS (|dispatchFunction| |URAGG-;map!;M2A;39|) $)))))
          $))) 

(MAKEPROP '|UnaryRecursiveAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |first|) '#1="first" |URAGG-;elt;AfirstS;1| (5 . |last|)
              '#2="last" |URAGG-;elt;AlastS;2| (10 . |rest|) '#3="rest"
              |URAGG-;elt;ArestA;3| |URAGG-;second;AS;4| |URAGG-;third;AS;5|
              (|Boolean|) (15 . |empty?|) |URAGG-;cyclic?;AB;6| (20 . |tail|)
              |URAGG-;last;AS;7| (25 . |empty|) (29 . |concat|)
              (|NonNegativeInteger|) |URAGG-;first;ANniA;8| (|List| $)
              |URAGG-;nodes;AL;9| |URAGG-;children;AL;10| (|List| 7)
              |URAGG-;leaves;AL;11| |URAGG-;leaf?;AB;12| |URAGG-;value;AS;13|
              |URAGG-;less?;ANniB;14| |URAGG-;more?;ANniB;15|
              |URAGG-;size?;ANniB;16| (35 . |cyclic?|) |URAGG-;tail;2A;17|
              (40 . |eq?|) (46 . |cycleEntry|) |URAGG-;cycleTail;2A;19|
              |URAGG-;cycleEntry;2A;20| |URAGG-;cycleLength;ANni;21|
              |URAGG-;rest;ANniA;22| (51 . |#|) (56 . |copy|) (61 . |last|)
              (67 . ~=) (73 . =) (79 . =) (85 . |node?|) (91 . |setfirst!|)
              (97 . |setelt!|) (104 . |setlast!|) (110 . |setelt!|)
              (117 . |setrest!|) (123 . |setelt!|) (130 . |concat!|)
              (136 . |concat|) (142 . |concat!|) (147 . |qsetfirst!|)
              (153 . |qsetrest!|) (159 . |setlast!|) (165 . |setchildren!|)
              (171 . |setvalue!|) (177 . |rest|) (183 . |split!|)
              (189 . |cycleSplit!|) (|Mapping| 7 7) (194 . |map!|) '#4="value")
           '#(|value| 200 |third| 205 |tail| 210 |split!| 215 |size?| 221
              |setvalue!| 227 |setlast!| 233 |setelt!| 239 |setchildren!| 260
              |second| 266 |rest| 271 |qsetrest!| 277 |qsetfirst!| 283 |nodes|
              289 |node?| 294 |more?| 300 |map!| 306 |less?| 312 |leaves| 318
              |leaf?| 323 |last| 328 |first| 339 |elt| 345 |cyclic?| 363
              |cycleTail| 368 |cycleSplit!| 373 |cycleLength| 378 |cycleEntry|
              383 |concat!| 388 |concat| 393 |children| 399 = 404 |#| 410)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|split!| (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|setelt!| (|#2| |#1| "last" |#2|)) T)
                              '((|setlast!| (|#2| |#1| |#2|)) T)
                              '((|setelt!| (|#1| |#1| "rest" |#1|)) T)
                              '((|qsetrest!| (|#1| |#1| |#1|)) T)
                              '((|setelt!| (|#2| |#1| "first" |#2|)) T)
                              '((|qsetfirst!| (|#2| |#1| |#2|)) T)
                              '((|cycleSplit!| (|#1| |#1|)) T)
                              '((|concat!| (|#1| (|List| |#1|))) T)
                              '((|concat!| (|#1| |#1| |#2|)) T)
                              '((|concat!| (|#1| |#1| |#1|)) T)
                              '((|cycleTail| (|#1| |#1|)) T)
                              '((|cycleLength| ((|NonNegativeInteger|) |#1|))
                                T)
                              '((|cycleEntry| (|#1| |#1|)) T)
                              '((|third| (|#2| |#1|)) T)
                              '((|second| (|#2| |#1|)) T)
                              '((|tail| (|#1| |#1|)) T)
                              '((|last| (|#1| |#1| (|NonNegativeInteger|))) T)
                              '((|elt| (|#2| |#1| #2#)) T)
                              '((|last| (|#2| |#1|)) T)
                              '((|rest| (|#1| |#1| (|NonNegativeInteger|))) T)
                              '((|elt| (|#1| |#1| #3#)) T)
                              '((|rest| (|#1| |#1|)) T)
                              '((|first| (|#1| |#1| (|NonNegativeInteger|))) T)
                              '((|elt| (|#2| |#1| #1#)) T)
                              '((|first| (|#2| |#1|)) T)
                              '((|concat| (|#1| |#2| |#1|)) T)
                              '((|concat| (|#1| |#1| |#1|)) T)
                              '((|setvalue!| (|#2| |#1| |#2|)) T)
                              '((|setelt!| (|#2| |#1| #4# |#2|)) T)
                              '((|setchildren!| (|#1| |#1| (|List| |#1|))) T)
                              '((|node?| ((|Boolean|) |#1| |#1|)) T)
                              '((|leaves| ((|List| |#2|) |#1|)) T)
                              '((|cyclic?| ((|Boolean|) |#1|)) T)
                              '((|elt| (|#2| |#1| #4#)) T)
                              '((|value| (|#2| |#1|)) T)
                              '((|leaf?| ((|Boolean|) |#1|)) T)
                              '((|nodes| ((|List| |#1|) |#1|)) T)
                              '((|children| ((|List| |#1|) |#1|)) T)
                              '((= ((|Boolean|) |#1| |#1|)) T)
                              '((|map!| (|#1| (|Mapping| |#2| |#2|) |#1|)) T)
                              '((|#| ((|NonNegativeInteger|) |#1|)) T)
                              '((|size?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)))
                                T)
                              '((|more?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)))
                                T)
                              '((|less?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 71
                                            '(1 6 7 0 8 1 6 7 0 11 1 6 0 0 14 1
                                              6 19 0 20 1 6 0 0 22 0 6 0 24 2 6
                                              0 7 0 25 1 6 19 0 38 2 6 19 0 0
                                              40 1 6 0 0 41 1 0 26 0 46 1 6 0 0
                                              47 2 0 0 0 26 48 2 7 19 0 0 49 2
                                              0 19 0 0 50 2 6 19 0 0 51 2 0 19
                                              0 0 52 2 6 7 0 7 53 3 0 7 0 9 7
                                              54 2 6 7 0 7 55 3 0 7 0 12 7 56 2
                                              6 0 0 0 57 3 0 0 0 15 0 58 2 6 0
                                              0 0 59 2 0 0 0 0 60 1 0 0 28 61 2
                                              0 7 0 7 62 2 0 0 0 0 63 2 0 7 0 7
                                              64 2 0 0 0 28 65 2 0 7 0 7 66 2 6
                                              0 0 26 67 2 0 0 0 26 68 1 0 0 0
                                              69 2 0 0 70 0 71 1 0 7 0 34 1 0 7
                                              0 18 1 0 0 0 39 2 0 0 0 26 68 2 0
                                              19 0 26 37 2 0 7 0 7 66 2 0 7 0 7
                                              64 3 0 7 0 12 7 56 3 0 0 0 15 0
                                              58 3 0 7 0 9 7 54 2 0 0 0 28 65 1
                                              0 7 0 17 2 0 0 0 26 45 2 0 0 0 0
                                              63 2 0 7 0 7 62 1 0 28 0 29 2 0
                                              19 0 0 52 2 0 19 0 26 36 2 0 0 70
                                              0 71 2 0 19 0 26 35 1 0 31 0 32 1
                                              0 19 0 33 2 0 0 0 26 48 1 0 7 0
                                              23 2 0 0 0 26 27 2 0 7 0 12 13 2
                                              0 0 0 15 16 2 0 7 0 9 10 1 0 19 0
                                              21 1 0 0 0 42 1 0 0 0 69 1 0 26 0
                                              44 1 0 0 0 43 1 0 0 28 61 2 0 0 0
                                              0 60 1 0 28 0 30 2 0 19 0 0 50 1
                                              0 26 0 46)))))
           '|lookupComplete|)) 
