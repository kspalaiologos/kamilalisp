
(SDEFUN |BRAGG-;elt;AleftA;1| ((|x| (A)) (T1 ("left")) ($ (A)))
        (SPADCALL |x| (QREFELT $ 8))) 

(SDEFUN |BRAGG-;elt;ArightA;2| ((|x| (A)) (T2 ("right")) ($ (A)))
        (SPADCALL |x| (QREFELT $ 11))) 

(SDEFUN |BRAGG-;leaf?;AB;3| ((|x| (A)) ($ (|Boolean|)))
        (COND
         ((OR (SPADCALL |x| (QREFELT $ 15))
              (NULL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 15))))
          NIL)
         ('T (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 15))))) 

(SDEFUN |BRAGG-;leaves;AL;4| ((|t| (A)) ($ (|List| S)))
        (COND ((SPADCALL |t| (QREFELT $ 15)) NIL)
              ((SPADCALL |t| (QREFELT $ 17))
               (LIST (SPADCALL |t| (QREFELT $ 18))))
              ('T
               (SPADCALL (SPADCALL (SPADCALL |t| (QREFELT $ 8)) (QREFELT $ 20))
                         (SPADCALL (SPADCALL |t| (QREFELT $ 11))
                                   (QREFELT $ 20))
                         (QREFELT $ 21))))) 

(SDEFUN |BRAGG-;nodes;AL;5| ((|x| (A)) ($ (|List| A)))
        (COND ((SPADCALL |x| (QREFELT $ 15)) NIL)
              ('T
               (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 24))
                         (CONS |x|
                               (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                         (QREFELT $ 24)))
                         (QREFELT $ 26))))) 

(SDEFUN |BRAGG-;children;AL;6| ((|x| (A)) ($ (|List| A)))
        (COND
         ((SPADCALL |x| (QREFELT $ 15))
          (|error| "children: argument is empty"))
         ((SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 15))
          (COND ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 15)) NIL)
                (#1='T (LIST (SPADCALL |x| (QREFELT $ 11))))))
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 15))
          (LIST (SPADCALL |x| (QREFELT $ 8))))
         (#1#
          (LIST (SPADCALL |x| (QREFELT $ 8)) (SPADCALL |x| (QREFELT $ 11)))))) 

(SDEFUN |BRAGG-;#;ANni;7| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (|BRAGG-;aggCount| |x| 0 $)) 

(SDEFUN |BRAGG-;aggCount|
        ((|x| (A)) (|k| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G770 NIL) (|y| NIL))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 15)) 0)
                      ('T
                       (SEQ (LETT |k| (+ |k| 1))
                            (COND
                             ((EQL |k| 1000)
                              (COND
                               ((SPADCALL |x| (QREFELT $ 31))
                                (EXIT (|error| "cyclic tree"))))))
                            (SEQ (LETT |y| NIL)
                                 (LETT #1# (SPADCALL |x| (QREFELT $ 32))) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |y| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |k| (|BRAGG-;aggCount| |y| |k| $))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |k|))))))) 

(SDEFUN |BRAGG-;node?;2AB;9| ((|u| (A)) (|v| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G776 NIL))
               (SEQ
                (EXIT
                 (COND ((SPADCALL |v| (QREFELT $ 15)) NIL)
                       ((SPADCALL |u| |v| (QREFELT $ 33)) 'T)
                       ('T
                        (COND
                         ((OR
                           (SPADCALL |u| (SPADCALL |v| (QREFELT $ 8))
                                     (QREFELT $ 34))
                           (SPADCALL |u| (SPADCALL |v| (QREFELT $ 11))
                                     (QREFELT $ 34)))
                          (PROGN (LETT #1# 'T) (GO #2=#:G775)))
                         ('T NIL)))))
                #2# (EXIT #1#)))) 

(SDEFUN |BRAGG-;=;2AB;10| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 15)) (SPADCALL |y| (QREFELT $ 15)))
              ((OR
                (OR (SPADCALL |y| (QREFELT $ 15))
                    (NULL
                     (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                               (SPADCALL |y| (QREFELT $ 18)) (QREFELT $ 36))))
                (NULL
                 (SPADCALL (SPADCALL |x| (QREFELT $ 8))
                           (SPADCALL |y| (QREFELT $ 8)) (QREFELT $ 33))))
               NIL)
              ('T
               (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                         (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 33))))) 

(SDEFUN |BRAGG-;member?;SAB;11| ((|x| (S)) (|u| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |u| (QREFELT $ 15)) NIL)
              ((OR (SPADCALL |x| (SPADCALL |u| (QREFELT $ 18)) (QREFELT $ 36))
                   (SPADCALL |x| (SPADCALL |u| (QREFELT $ 8)) (QREFELT $ 38)))
               'T)
              ('T (SPADCALL |x| (SPADCALL |u| (QREFELT $ 11)) (QREFELT $ 38))))) 

(SDEFUN |BRAGG-;coerce;AOf;12| ((|t| (A)) ($ (|OutputForm|)))
        (SPROG ((|r| #1=(|OutputForm|)) (|l| #1#) (|v| (|OutputForm|)))
               (SEQ
                (COND
                 ((SPADCALL |t| (QREFELT $ 15)) (SPADCALL "[]" (QREFELT $ 42)))
                 (#2='T
                  (SEQ
                   (LETT |v|
                         (SPADCALL (SPADCALL |t| (QREFELT $ 18))
                                   (QREFELT $ 43)))
                   (EXIT
                    (COND
                     ((SPADCALL (SPADCALL |t| (QREFELT $ 8)) (QREFELT $ 15))
                      (COND
                       ((SPADCALL (SPADCALL |t| (QREFELT $ 11)) (QREFELT $ 15))
                        |v|)
                       (#2#
                        (SEQ
                         (LETT |r|
                               (SPADCALL (SPADCALL |t| (QREFELT $ 11))
                                         (QREFELT $ 44)))
                         (EXIT
                          (SPADCALL
                           (LIST (SPADCALL "." (QREFELT $ 42)) |v| |r|)
                           (QREFELT $ 45)))))))
                     (#2#
                      (SEQ
                       (LETT |l|
                             (SPADCALL (SPADCALL |t| (QREFELT $ 8))
                                       (QREFELT $ 44)))
                       (LETT |r|
                             (COND
                              ((SPADCALL (SPADCALL |t| (QREFELT $ 11))
                                         (QREFELT $ 15))
                               (SPADCALL "." (QREFELT $ 42)))
                              (#2#
                               (SPADCALL (SPADCALL |t| (QREFELT $ 11))
                                         (QREFELT $ 44)))))
                       (EXIT
                        (SPADCALL (LIST |l| |v| |r|) (QREFELT $ 45))))))))))))) 

(SDEFUN |BRAGG-;cyclic?;AB;13| ((|x| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 15)) NIL)
              ('T (|BRAGG-;isCycle?| |x| NIL $)))) 

(SDEFUN |BRAGG-;isCycle?| ((|x| (A)) (|acc| (|List| A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G803 NIL) (#2=#:G804 NIL) (#3=#:G805 NIL) (|y| NIL))
               (SEQ
                (EXIT
                 (COND ((SPADCALL |x| (QREFELT $ 15)) NIL)
                       ((|BRAGG-;eqMember?| |x| |acc| $) 'T)
                       ('T
                        (SEQ
                         (SEQ
                          (EXIT
                           (SEQ (LETT |y| NIL)
                                (LETT #3# (SPADCALL |x| (QREFELT $ 32))) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |y| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((NULL (SPADCALL |y| (QREFELT $ 15)))
                                    (COND
                                     ((|BRAGG-;isCycle?| |y| |acc| $)
                                      (PROGN
                                       (LETT #1#
                                             (PROGN
                                              (LETT #2# 'T)
                                              (GO #4=#:G802)))
                                       (GO #5=#:G798))))))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT NIL)))
                          #5# (EXIT #1#))
                         (EXIT NIL)))))
                #4# (EXIT #2#)))) 

(SDEFUN |BRAGG-;eqMember?| ((|y| (A)) (|l| (|List| A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G811 NIL) (#2=#:G812 NIL) (#3=#:G813 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |x| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |x| |y| (QREFELT $ 48))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G810)))
                              (GO #5=#:G808))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |BRAGG-;setelt!;Aleft2A;16| ((|x| (A)) (T3 ("left")) (|b| (A)) ($ (A)))
        (SPADCALL |x| |b| (QREFELT $ 49))) 

(SDEFUN |BRAGG-;setelt!;Aright2A;17|
        ((|x| (A)) (T4 ("right")) (|b| (A)) ($ (A)))
        (SPADCALL |x| |b| (QREFELT $ 51))) 

(DECLAIM (NOTINLINE |BinaryRecursiveAggregate&;|)) 

(DEFUN |BinaryRecursiveAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|BinaryRecursiveAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 54))
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
             (QSETREFV $ 30 (CONS (|dispatchFunction| |BRAGG-;#;ANni;7|) $))
             (COND
              ((|HasCategory| |#2| '(|BasicType|))
               (PROGN
                (QSETREFV $ 35
                          (CONS (|dispatchFunction| |BRAGG-;node?;2AB;9|) $))
                (QSETREFV $ 37 (CONS (|dispatchFunction| |BRAGG-;=;2AB;10|) $))
                (QSETREFV $ 39
                          (CONS (|dispatchFunction| |BRAGG-;member?;SAB;11|)
                                $)))))
             (COND
              ((|HasCategory| |#2| '(|CoercibleTo| (|OutputForm|)))
               (QSETREFV $ 46
                         (CONS (|dispatchFunction| |BRAGG-;coerce;AOf;12|)
                               $)))))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 50
                       (CONS (|dispatchFunction| |BRAGG-;setelt!;Aleft2A;16|)
                             $))
             (QSETREFV $ 52
                       (CONS (|dispatchFunction| |BRAGG-;setelt!;Aright2A;17|)
                             $)))))
          $))) 

(MAKEPROP '|BinaryRecursiveAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |left|) '#1="left" |BRAGG-;elt;AleftA;1| (5 . |right|)
              '#2="right" |BRAGG-;elt;ArightA;2| (|Boolean|) (10 . |empty?|)
              |BRAGG-;leaf?;AB;3| (15 . |leaf?|) (20 . |value|) (|List| 7)
              (25 . |leaves|) (30 . |concat|) |BRAGG-;leaves;AL;4| (|List| $)
              (36 . |nodes|) (|List| 6) (41 . |concat|) |BRAGG-;nodes;AL;5|
              |BRAGG-;children;AL;6| (|NonNegativeInteger|) (47 . |#|)
              (52 . |cyclic?|) (57 . |children|) (62 . =) (68 . |node?|)
              (74 . |node?|) (80 . =) (86 . =) (92 . |member?|)
              (98 . |member?|) (|String|) (|OutputForm|) (104 . |message|)
              (109 . |coerce|) (114 . |coerce|) (119 . |bracket|)
              (124 . |coerce|) |BRAGG-;cyclic?;AB;13| (129 . |eq?|)
              (135 . |setleft!|) (141 . |setelt!|) (148 . |setright!|)
              (154 . |setelt!|) '#3="value")
           '#(|setelt!| 161 |nodes| 175 |node?| 180 |member?| 186 |leaves| 192
              |leaf?| 197 |elt| 202 |cyclic?| 214 |coerce| 219 |children| 224 =
              229 |#| 235)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|setelt!| (|#1| |#1| "right" |#1|)) T)
                                   '((|setelt!| (|#1| |#1| "left" |#1|)) T)
                                   '((|elt| (|#1| |#1| #2#)) T)
                                   '((|elt| (|#1| |#1| #1#)) T)
                                   '((|setelt!| (|#2| |#1| #3# |#2|)) T)
                                   '((|node?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|leaves| ((|List| |#2|) |#1|)) T)
                                   '((|cyclic?| ((|Boolean|) |#1|)) T)
                                   '((|elt| (|#2| |#1| #3#)) T)
                                   '((|leaf?| ((|Boolean|) |#1|)) T)
                                   '((|nodes| ((|List| |#1|) |#1|)) T)
                                   '((|children| ((|List| |#1|) |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T)
                                   '((|member?| ((|Boolean|) |#2| |#1|)) T)
                                   '((|#| ((|NonNegativeInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 52
                                            '(1 6 0 0 8 1 6 0 0 11 1 6 14 0 15
                                              1 6 14 0 17 1 6 7 0 18 1 6 19 0
                                              20 2 19 0 0 0 21 1 6 23 0 24 2 25
                                              0 0 0 26 1 0 29 0 30 1 6 14 0 31
                                              1 6 23 0 32 2 6 14 0 0 33 2 6 14
                                              0 0 34 2 0 14 0 0 35 2 7 14 0 0
                                              36 2 0 14 0 0 37 2 6 14 7 0 38 2
                                              0 14 7 0 39 1 41 0 40 42 1 7 41 0
                                              43 1 6 41 0 44 1 41 0 23 45 1 0
                                              41 0 46 2 6 14 0 0 48 2 6 0 0 0
                                              49 3 0 0 0 9 0 50 2 6 0 0 0 51 3
                                              0 0 0 12 0 52 3 0 0 0 9 0 50 3 0
                                              0 0 12 0 52 1 0 23 0 27 2 0 14 0
                                              0 35 2 0 14 7 0 39 1 0 19 0 22 1
                                              0 14 0 16 2 0 0 0 9 10 2 0 0 0 12
                                              13 1 0 14 0 47 1 0 41 0 46 1 0 23
                                              0 28 2 0 14 0 0 37 1 0 29 0
                                              30)))))
           '|lookupComplete|)) 
