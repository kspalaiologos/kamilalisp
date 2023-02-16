
(SDEFUN |FSAGG-;<=;2AB;1| ((|s| (A)) (|t| (A)) ($ (|Boolean|)))
        (SPADCALL |s| (SPADCALL |s| |t| (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |FSAGG-;<;2AB;2| ((|s| (A)) (|t| (A)) ($ (|Boolean|)))
        (COND
         ((< (SPADCALL |s| (QREFELT $ 13)) (SPADCALL |t| (QREFELT $ 13)))
          (SPADCALL |s| |t| (QREFELT $ 14)))
         ('T NIL))) 

(SDEFUN |FSAGG-;=;2AB;3| ((|s| (A)) (|t| (A)) ($ (|Boolean|)))
        (COND
         ((EQL (SPADCALL |s| (QREFELT $ 13)) (SPADCALL |t| (QREFELT $ 13)))
          (SPADCALL (SPADCALL |s| |t| (QREFELT $ 16)) (QREFELT $ 17)))
         ('T NIL))) 

(SDEFUN |FSAGG-;set;LA;4| ((|l| (|List| S)) ($ (A)))
        (SPADCALL |l| (QREFELT $ 20))) 

(SDEFUN |FSAGG-;cardinality;ANni;5| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPADCALL |s| (QREFELT $ 13))) 

(SDEFUN |FSAGG-;construct;LA;6| ((|l| (|List| S)) ($ (A)))
        (SPROG ((|s| (A)) (#1=#:G726 NIL) (|x| NIL))
               (SEQ (LETT |s| (SPADCALL (QREFELT $ 23)))
                    (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT |s| (SPADCALL |x| |s| (QREFELT $ 24)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |s|)))) 

(SDEFUN |FSAGG-;count;SANni;7| ((|x| (S)) (|s| (A)) ($ (|NonNegativeInteger|)))
        (COND ((SPADCALL |x| |s| (QREFELT $ 26)) 1) ('T 0))) 

(SDEFUN |FSAGG-;subset?;2AB;8| ((|s| (A)) (|t| (A)) ($ (|Boolean|)))
        (SPROG NIL
               (COND
                ((<= (SPADCALL |s| (QREFELT $ 13))
                     (SPADCALL |t| (QREFELT $ 13)))
                 (SPADCALL (CONS #'|FSAGG-;subset?;2AB;8!0| (VECTOR $ |t|))
                           (SPADCALL |s| (QREFELT $ 28)) (QREFELT $ 30)))
                ('T NIL)))) 

(SDEFUN |FSAGG-;subset?;2AB;8!0| ((|x| NIL) ($$ NIL))
        (PROG (|t| $)
          (LETT |t| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |t| (QREFELT $ 26)))))) 

(SDEFUN |FSAGG-;coerce;AOf;9| ((|s| (A)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G737 NIL) (|x| NIL) (#2=#:G736 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |x| NIL) (LETT #1# (SPADCALL |s| (QREFELT $ 28)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |x| (QREFELT $ 33)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 35))))) 

(SDEFUN |FSAGG-;intersect;3A;10| ((|s| (A)) (|t| (A)) ($ (A)))
        (SPROG ((|i| (A)) (#1=#:G742 NIL) (|x| NIL))
               (SEQ (LETT |i| (SPADCALL (QREFELT $ 23)))
                    (SEQ (LETT |x| NIL)
                         (LETT #1# (SPADCALL |s| (QREFELT $ 28))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x| |t| (QREFELT $ 26))
                             (LETT |i| (SPADCALL |x| |i| (QREFELT $ 24)))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |i|)))) 

(SDEFUN |FSAGG-;difference;3A;11| ((|s| (A)) (|t| (A)) ($ (A)))
        (SPROG ((|m| (A)) (#1=#:G747 NIL) (|x| NIL))
               (SEQ (LETT |m| (SPADCALL |s| (QREFELT $ 38)))
                    (SEQ (LETT |x| NIL)
                         (LETT #1# (SPADCALL |t| (QREFELT $ 28))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT |m| (SPADCALL |x| |m| (QREFELT $ 39)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |m|)))) 

(SDEFUN |FSAGG-;symmetricDifference;3A;12| ((|s| (A)) (|t| (A)) ($ (A)))
        (SPROG ((|d| (A)) (#1=#:G753 NIL) (|x| NIL))
               (SEQ (LETT |d| (SPADCALL |s| (QREFELT $ 38)))
                    (SEQ (LETT |x| NIL)
                         (LETT #1# (SPADCALL |t| (QREFELT $ 28))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x| |s| (QREFELT $ 26))
                             (LETT |d| (SPADCALL |x| |d| (QREFELT $ 39))))
                            ('T
                             (LETT |d| (SPADCALL |x| |d| (QREFELT $ 24)))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |d|)))) 

(SDEFUN |FSAGG-;union;3A;13| ((|s| (A)) (|t| (A)) ($ (A)))
        (SPROG ((|u| (A)) (#1=#:G758 NIL) (|x| NIL))
               (SEQ (LETT |u| (SPADCALL |s| (QREFELT $ 38)))
                    (SEQ (LETT |x| NIL)
                         (LETT #1# (SPADCALL |t| (QREFELT $ 28))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT |u| (SPADCALL |x| |u| (QREFELT $ 24)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |u|)))) 

(SDEFUN |FSAGG-;universe;A;14| (($ (A)))
        (SPROG ((#1=#:G764 NIL) (#2=#:G768 NIL) (|i| NIL) (#3=#:G767 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #3# NIL)
                  (SEQ (LETT |i| 1) (LETT #2# (SPADCALL (QREFELT $ 43))) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #3#
                               (CONS
                                (SPADCALL
                                 (PROG1 (LETT #1# |i|)
                                   (|check_subtype2| (> #1# 0)
                                                     '(|PositiveInteger|)
                                                     '(|NonNegativeInteger|)
                                                     #1#))
                                 (QREFELT $ 45))
                                #3#))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                       (EXIT (NREVERSE #3#))))
                 (QREFELT $ 46))))) 

(SDEFUN |FSAGG-;complement;2A;15| ((|s| (A)) ($ (A)))
        (SPADCALL (SPADCALL (QREFELT $ 48)) |s| (QREFELT $ 16))) 

(SDEFUN |FSAGG-;size;Nni;16| (($ (|NonNegativeInteger|)))
        (EXPT 2 (SPADCALL (QREFELT $ 43)))) 

(SDEFUN |FSAGG-;index;PiA;17| ((|i| (|PositiveInteger|)) ($ (A)))
        (SPROG
         ((#1=#:G773 NIL) (#2=#:G778 NIL) (|j| NIL) (#3=#:G777 NIL)
          (|l| (|Integer|)))
         (SEQ (LETT |l| (INTEGER-LENGTH (- |i| 1)))
              (EXIT
               (COND
                ((> |l| (SPADCALL (QREFELT $ 43)))
                 (|error| "index out of bound"))
                ('T
                 (SPADCALL
                  (PROGN
                   (LETT #3# NIL)
                   (SEQ (LETT |j| 1) (LETT #2# |l|) G190
                        (COND ((|greater_SI| |j| #2#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL (- |i| 1) (- |j| 1) (QREFELT $ 52))
                            (LETT #3#
                                  (CONS
                                   (SPADCALL
                                    (PROG1 (LETT #1# |j|)
                                      (|check_subtype2| (> #1# 0)
                                                        '(|PositiveInteger|)
                                                        '(|NonNegativeInteger|)
                                                        #1#))
                                    (QREFELT $ 45))
                                   #3#))))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                        (EXIT (NREVERSE #3#))))
                  (QREFELT $ 46)))))))) 

(SDEFUN |FSAGG-;lookup;APi;18| ((|s| (A)) ($ (|PositiveInteger|)))
        (SPROG
         ((|n| (|PositiveInteger|)) (#1=#:G781 NIL) (#2=#:G785 NIL) (|x| NIL))
         (SEQ (LETT |n| 1)
              (SEQ (LETT |x| NIL) (LETT #2# (SPADCALL |s| (QREFELT $ 28))) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |n|
                           (+ |n|
                              (EXPT 2
                                    (PROG1
                                        (LETT #1#
                                              (- (SPADCALL |x| (QREFELT $ 54))
                                                 1))
                                      (|check_subtype2| (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |n|)))) 

(SDEFUN |FSAGG-;max;AS;19| ((|s| (A)) ($ (S)))
        (SPROG ((|l| (|List| S)))
               (COND
                ((NULL (LETT |l| (SPADCALL |s| (QREFELT $ 28))))
                 (|error| "Empty set"))
                ('T (SPADCALL (ELT $ 56) |l| (QREFELT $ 58)))))) 

(SDEFUN |FSAGG-;min;AS;20| ((|s| (A)) ($ (S)))
        (SPROG ((|l| (|List| S)))
               (COND
                ((NULL (LETT |l| (SPADCALL |s| (QREFELT $ 28))))
                 (|error| "Empty set"))
                ('T (SPADCALL (ELT $ 60) |l| (QREFELT $ 58)))))) 

(SDEFUN |FSAGG-;smaller?;2AB;21| ((|s1| (A)) (|s2| (A)) ($ (|Boolean|)))
        (SPROG ((|ls2| #1=(|List| S)) (|ls1| #1#))
               (SEQ
                (LETT |ls1|
                      (SPADCALL (ELT $ 62) (SPADCALL |s1| (QREFELT $ 28))
                                (QREFELT $ 64)))
                (LETT |ls2|
                      (SPADCALL (ELT $ 62) (SPADCALL |s2| (QREFELT $ 28))
                                (QREFELT $ 64)))
                (EXIT (SPADCALL |ls1| |ls2| (QREFELT $ 65)))))) 

(DECLAIM (NOTINLINE |FiniteSetAggregate&;|)) 

(DEFUN |FiniteSetAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FiniteSetAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 67))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Comparable|))
                                              (|HasCategory| |#2|
                                                             '(|Finite|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 47
                       (CONS (|dispatchFunction| |FSAGG-;universe;A;14|) $))
             (QSETREFV $ 49
                       (CONS (|dispatchFunction| |FSAGG-;complement;2A;15|) $))
             (QSETREFV $ 50 (CONS (|dispatchFunction| |FSAGG-;size;Nni;16|) $))
             (QSETREFV $ 53
                       (CONS (|dispatchFunction| |FSAGG-;index;PiA;17|) $))
             (QSETREFV $ 55
                       (CONS (|dispatchFunction| |FSAGG-;lookup;APi;18|) $)))))
          (COND
           ((|HasCategory| |#2| '(|OrderedSet|))
            (PROGN
             (QSETREFV $ 59 (CONS (|dispatchFunction| |FSAGG-;max;AS;19|) $))
             (QSETREFV $ 61
                       (CONS (|dispatchFunction| |FSAGG-;min;AS;20|) $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 66
                      (CONS (|dispatchFunction| |FSAGG-;smaller?;2AB;21|) $))))
          $))) 

(MAKEPROP '|FiniteSetAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |intersect|) (|Boolean|) (6 . =) |FSAGG-;<=;2AB;1|
              (|NonNegativeInteger|) (12 . |#|) (17 . <=) |FSAGG-;<;2AB;2|
              (23 . |difference|) (29 . |empty?|) |FSAGG-;=;2AB;3| (|List| 7)
              (34 . |construct|) |FSAGG-;set;LA;4| |FSAGG-;cardinality;ANni;5|
              (39 . |set|) (43 . |insert!|) |FSAGG-;construct;LA;6|
              (49 . |member?|) |FSAGG-;count;SANni;7| (55 . |parts|)
              (|Mapping| 9 7) (60 . |every?|) |FSAGG-;subset?;2AB;8|
              (|OutputForm|) (66 . |coerce|) (|List| $) (71 . |brace|)
              |FSAGG-;coerce;AOf;9| |FSAGG-;intersect;3A;10| (76 . |copy|)
              (81 . |remove!|) |FSAGG-;difference;3A;11|
              |FSAGG-;symmetricDifference;3A;12| |FSAGG-;union;3A;13|
              (87 . |size|) (|PositiveInteger|) (91 . |index|) (96 . |set|)
              (101 . |universe|) (105 . |universe|) (109 . |complement|)
              (114 . |size|) (|Integer|) (118 . |bit?|) (124 . |index|)
              (129 . |lookup|) (134 . |lookup|) (139 . |max|) (|Mapping| 7 7 7)
              (145 . |reduce|) (151 . |max|) (156 . |min|) (162 . |min|)
              (167 . |smaller?|) (|Mapping| 9 7 7) (173 . |sort|)
              (179 . |smaller?|) (185 . |smaller?|))
           '#(|universe| 191 |union| 195 |symmetricDifference| 201 |subset?|
              207 |smaller?| 213 |size| 219 |set| 223 |min| 228 |max| 233
              |lookup| 238 |intersect| 243 |index| 249 |difference| 254 |count|
              260 |construct| 266 |complement| 271 |coerce| 276 |cardinality|
              281 = 286 <= 292 < 298)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|smaller?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|size| ((|NonNegativeInteger|))) T)
                                   '((|index| (|#1| (|PositiveInteger|))) T)
                                   '((|lookup| ((|PositiveInteger|) |#1|)) T)
                                   '((|universe| (|#1|)) T)
                                   '((|complement| (|#1| |#1|)) T)
                                   '((|cardinality|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((= ((|Boolean|) |#1| |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((< ((|Boolean|) |#1| |#1|)) T)
                                   '((<= ((|Boolean|) |#1| |#1|)) T)
                                   '((|set| (|#1|)) T)
                                   '((|set| (|#1| (|List| |#2|))) T)
                                   '((|intersect| (|#1| |#1| |#1|)) T)
                                   '((|difference| (|#1| |#1| |#1|)) T)
                                   '((|difference| (|#1| |#1| |#2|)) T)
                                   '((|symmetricDifference| (|#1| |#1| |#1|))
                                     T)
                                   '((|subset?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|union| (|#1| |#1| |#1|)) T)
                                   '((|union| (|#1| |#1| |#2|)) T)
                                   '((|union| (|#1| |#2| |#1|)) T)
                                   '((|construct| (|#1| (|List| |#2|))) T)
                                   '((|count|
                                      ((|NonNegativeInteger|) |#2| |#1|))
                                     T)
                                   '((|max| (|#2| |#1|)) T)
                                   '((|min| (|#2| |#1|)) T)
                                   '((|max|
                                      (|#2| (|Mapping| (|Boolean|) |#2| |#2|)
                                       |#1|))
                                     T)
                                   '((|count|
                                      ((|NonNegativeInteger|)
                                       (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 66
                                            '(2 6 0 0 0 8 2 6 9 0 0 10 1 6 12 0
                                              13 2 6 9 0 0 14 2 6 0 0 0 16 1 6
                                              9 0 17 1 6 0 19 20 0 6 0 23 2 6 0
                                              7 0 24 2 6 9 7 0 26 1 6 19 0 28 2
                                              19 9 29 0 30 1 7 32 0 33 1 32 0
                                              34 35 1 6 0 0 38 2 6 0 7 0 39 0 7
                                              12 43 1 7 0 44 45 1 6 0 19 46 0 0
                                              0 47 0 6 0 48 1 0 0 0 49 0 0 12
                                              50 2 51 9 0 0 52 1 0 0 44 53 1 7
                                              44 0 54 1 0 44 0 55 2 7 0 0 0 56
                                              2 19 7 57 0 58 1 0 7 0 59 2 7 0 0
                                              0 60 1 0 7 0 61 2 7 9 0 0 62 2 19
                                              0 63 0 64 2 19 9 0 0 65 2 0 9 0 0
                                              66 0 0 0 47 2 0 0 0 0 42 2 0 0 0
                                              0 41 2 0 9 0 0 31 2 0 9 0 0 66 0
                                              0 12 50 1 0 0 19 21 1 0 7 0 61 1
                                              0 7 0 59 1 0 44 0 55 2 0 0 0 0 37
                                              1 0 0 44 53 2 0 0 0 0 40 2 0 12 7
                                              0 27 1 0 0 19 25 1 0 0 0 49 1 0
                                              32 0 36 1 0 12 0 22 2 0 9 0 0 18
                                              2 0 9 0 0 11 2 0 9 0 0 15)))))
           '|lookupComplete|)) 
