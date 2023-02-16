
(SDEFUN |HOAGG-;eval;ALA;1| ((|u| (A)) (|l| (|List| (|Equation| S))) ($ (A)))
        (SPROG NIL
               (SPADCALL (CONS #'|HOAGG-;eval;ALA;1!0| (VECTOR $ |l|)) |u|
                         (QREFELT $ 11)))) 

(SDEFUN |HOAGG-;eval;ALA;1!0| ((|x| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |l| (QREFELT $ 9)))))) 

(SDEFUN |HOAGG-;#;ANni;2| ((|c| (A)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL |c| (QREFELT $ 14)))) 

(SDEFUN |HOAGG-;any?;MAB;3|
        ((|f| (|Mapping| (|Boolean|) S)) (|c| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G724 NIL) (#2=#:G725 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |x| NIL) (LETT #2# (SPADCALL |c| (QREFELT $ 14)))
                       G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |x| |f|)
                           (PROGN (LETT #1# 'T) (GO #3=#:G723))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |HOAGG-;every?;MAB;4|
        ((|f| (|Mapping| (|Boolean|) S)) (|c| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G731 NIL) (#2=#:G732 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |x| NIL) (LETT #2# (SPADCALL |c| (QREFELT $ 14)))
                       G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |x| |f|))
                           (PROGN (LETT #1# NIL) (GO #3=#:G730))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |HOAGG-;count;MANni;5|
        ((|f| (|Mapping| (|Boolean|) S)) (|c| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G734 NIL) (#2=#:G733 #3=(|NonNegativeInteger|)) (#4=#:G735 #3#)
          (#5=#:G737 NIL) (|x| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |x| NIL) (LETT #5# (SPADCALL |c| (QREFELT $ 14))) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |x| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (COND
                   ((SPADCALL |x| |f|)
                    (PROGN
                     (LETT #4# 1)
                     (COND (#1# (LETT #2# (+ #2# #4#)))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T 0)))))) 

(SDEFUN |HOAGG-;members;AL;6| ((|x| (A)) ($ (|List| S)))
        (SPADCALL |x| (QREFELT $ 14))) 

(SDEFUN |HOAGG-;max;MAS;7|
        ((|p| (|Mapping| (|Boolean|) S S)) (|u| (A)) ($ (S)))
        (SPROG ((|r| (S)) (#1=#:G746 NIL) (|x| NIL) (|l| (|List| S)))
               (SEQ
                (COND
                 ((SPADCALL |u| (QREFELT $ 23)) (|error| "empty aggregate"))
                 ('T
                  (SEQ (LETT |l| (SPADCALL |u| (QREFELT $ 14)))
                       (LETT |r| (|SPADfirst| |l|))
                       (SEQ (LETT |x| NIL) (LETT #1# (CDR |l|)) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND ((SPADCALL |r| |x| |p|) (LETT |r| |x|)))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |r|))))))) 

(SDEFUN |HOAGG-;min;AS;8| ((|u| (A)) ($ (S)))
        (SPADCALL (CONS #'|HOAGG-;min;AS;8!0| $) |u| (QREFELT $ 27))) 

(SDEFUN |HOAGG-;min;AS;8!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 26))) 

(SDEFUN |HOAGG-;max;AS;9| ((|u| (A)) ($ (S)))
        (SPADCALL (ELT $ 26) |u| (QREFELT $ 27))) 

(SDEFUN |HOAGG-;count;SANni;10|
        ((|e| (S)) (|c| (A)) ($ (|NonNegativeInteger|)))
        (SPROG NIL
               (SPADCALL (CONS #'|HOAGG-;count;SANni;10!0| (VECTOR $ |e|)) |c|
                         (QREFELT $ 31)))) 

(SDEFUN |HOAGG-;count;SANni;10!0| ((|x| NIL) ($$ NIL))
        (PROG (|e| $)
          (LETT |e| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |x| (QREFELT $ 30)))))) 

(SDEFUN |HOAGG-;member?;SAB;11| ((|e| (S)) (|c| (A)) ($ (|Boolean|)))
        (SPROG NIL
               (SPADCALL (CONS #'|HOAGG-;member?;SAB;11!0| (VECTOR $ |e|)) |c|
                         (QREFELT $ 33)))) 

(SDEFUN |HOAGG-;member?;SAB;11!0| ((|x| NIL) ($$ NIL))
        (PROG (|e| $)
          (LETT |e| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |x| (QREFELT $ 30)))))) 

(SDEFUN |HOAGG-;=;2AB;12| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G759 NIL) (#2=#:G760 NIL) (|a| NIL) (#3=#:G761 NIL) (|b| NIL))
         (SEQ
          (EXIT
           (COND
            ((NULL (SPADCALL |x| (SPADCALL |y| (QREFELT $ 35)) (QREFELT $ 36)))
             NIL)
            ('T
             (SEQ
              (SEQ (LETT |b| NIL) (LETT #3# (SPADCALL |y| (QREFELT $ 14)))
                   (LETT |a| NIL) (LETT #2# (SPADCALL |x| (QREFELT $ 14))) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |a| (CAR #2#)) NIL) (ATOM #3#)
                         (PROGN (LETT |b| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |a| |b| (QREFELT $ 37))
                       (PROGN (LETT #1# NIL) (GO #4=#:G758))))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT 'T)))))
          #4# (EXIT #1#)))) 

(SDEFUN |HOAGG-;coerce;AOf;13| ((|x| (A)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G766 NIL) (|a| NIL) (#2=#:G765 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |a| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 14)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |a| (QREFELT $ 40)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 42))))) 

(DECLAIM (NOTINLINE |HomogeneousAggregate&;|)) 

(DEFUN |HomogeneousAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|HomogeneousAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#2|
                                                             '(|BasicType|))
                                              (|HasCategory| |#1|
                                                             '(|finiteAggregate|))
                                              (|HasCategory| |#1|
                                                             '(|shallowlyMutable|))
                                              (|HasCategory| |#2|
                                                             (LIST '|Evalable|
                                                                   (|devaluate|
                                                                    |#2|)))
                                              (|HasCategory| |#2|
                                                             '(|SetCategory|))
                                              (|HasCategory| |#2|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|)))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 12 (CONS (|dispatchFunction| |HOAGG-;eval;ALA;1|) $))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 16 (CONS (|dispatchFunction| |HOAGG-;#;ANni;2|) $))
             (QSETREFV $ 19 (CONS (|dispatchFunction| |HOAGG-;any?;MAB;3|) $))
             (QSETREFV $ 20
                       (CONS (|dispatchFunction| |HOAGG-;every?;MAB;4|) $))
             (QSETREFV $ 21
                       (CONS (|dispatchFunction| |HOAGG-;count;MANni;5|) $))
             (QSETREFV $ 22
                       (CONS (|dispatchFunction| |HOAGG-;members;AL;6|) $))
             (QSETREFV $ 25 (CONS (|dispatchFunction| |HOAGG-;max;MAS;7|) $))
             (COND
              ((|testBitVector| |pv$| 1)
               (PROGN
                (QSETREFV $ 28 (CONS (|dispatchFunction| |HOAGG-;min;AS;8|) $))
                (QSETREFV $ 29
                          (CONS (|dispatchFunction| |HOAGG-;max;AS;9|) $)))))
             (COND
              ((|testBitVector| |pv$| 2)
               (PROGN
                (QSETREFV $ 32
                          (CONS (|dispatchFunction| |HOAGG-;count;SANni;10|)
                                $))
                (QSETREFV $ 34
                          (CONS (|dispatchFunction| |HOAGG-;member?;SAB;11|)
                                $))
                (QSETREFV $ 38
                          (CONS (|dispatchFunction| |HOAGG-;=;2AB;12|) $)))))
             (COND
              ((|testBitVector| |pv$| 7)
               (QSETREFV $ 43
                         (CONS (|dispatchFunction| |HOAGG-;coerce;AOf;13|)
                               $)))))))
          $))) 

(MAKEPROP '|HomogeneousAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 44)
              (0 . |eval|) (|Mapping| 7 7) (6 . |map|) (12 . |eval|) (|List| 7)
              (18 . |parts|) (|NonNegativeInteger|) (23 . |#|) (|Boolean|)
              (|Mapping| 17 7) (28 . |any?|) (34 . |every?|) (40 . |count|)
              (46 . |members|) (51 . |empty?|) (|Mapping| 17 7 7) (56 . |max|)
              (62 . <) (68 . |max|) (74 . |min|) (79 . |max|) (84 . =)
              (90 . |count|) (96 . |count|) (102 . |any?|) (108 . |member?|)
              (114 . |#|) (119 . |size?|) (125 . ~=) (131 . =) (|OutputForm|)
              (137 . |coerce|) (|List| $) (142 . |bracket|) (147 . |coerce|)
              (|Equation| 7))
           '#(|min| 152 |members| 157 |member?| 162 |max| 168 |every?| 179
              |eval| 185 |count| 191 |coerce| 203 |any?| 208 = 214 |#| 220)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T)
                                   '((|eval|
                                      (|#1| |#1| (|List| |#2|) (|List| |#2|)))
                                     T)
                                   '((|eval| (|#1| |#1| |#2| |#2|)) T)
                                   '((|eval| (|#1| |#1| (|Equation| |#2|))) T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Equation| |#2|))))
                                     T)
                                   '((|member?| ((|Boolean|) |#2| |#1|)) T)
                                   '((|count|
                                      ((|NonNegativeInteger|) |#2| |#1|))
                                     T)
                                   '((|max| (|#2| |#1|)) T)
                                   '((|min| (|#2| |#1|)) T)
                                   '((|max|
                                      (|#2| (|Mapping| (|Boolean|) |#2| |#2|)
                                       |#1|))
                                     T)
                                   '((|members| ((|List| |#2|) |#1|)) T)
                                   '((|count|
                                      ((|NonNegativeInteger|)
                                       (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T)
                                   '((|every?|
                                      ((|Boolean|) (|Mapping| (|Boolean|) |#2|)
                                       |#1|))
                                     T)
                                   '((|any?|
                                      ((|Boolean|) (|Mapping| (|Boolean|) |#2|)
                                       |#1|))
                                     T)
                                   '((|#| ((|NonNegativeInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(2 7 0 0 8 9 2 6 0 10 0 11 2 0 0 0
                                              8 12 1 6 13 0 14 1 0 15 0 16 2 0
                                              17 18 0 19 2 0 17 18 0 20 2 0 15
                                              18 0 21 1 0 13 0 22 1 6 17 0 23 2
                                              0 7 24 0 25 2 7 17 0 0 26 2 6 7
                                              24 0 27 1 0 7 0 28 1 0 7 0 29 2 7
                                              17 0 0 30 2 6 15 18 0 31 2 0 15 7
                                              0 32 2 6 17 18 0 33 2 0 17 7 0 34
                                              1 6 15 0 35 2 6 17 0 15 36 2 7 17
                                              0 0 37 2 0 17 0 0 38 1 7 39 0 40
                                              1 39 0 41 42 1 0 39 0 43 1 0 7 0
                                              28 1 0 13 0 22 2 0 17 7 0 34 1 0
                                              7 0 29 2 0 7 24 0 25 2 0 17 18 0
                                              20 2 0 0 0 8 12 2 0 15 7 0 32 2 0
                                              15 18 0 21 1 0 39 0 43 2 0 17 18
                                              0 19 2 0 17 0 0 38 1 0 15 0
                                              16)))))
           '|lookupComplete|)) 
