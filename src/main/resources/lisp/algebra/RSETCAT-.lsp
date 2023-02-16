
(SDEFUN |RSETCAT-;purelyAlgebraic?;PSB;1|
        ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |p| (QREFELT $ 12)) 'T)
              ((NULL
                (SPADCALL (SPADCALL |p| (QREFELT $ 13)) |ts| (QREFELT $ 14)))
               NIL)
              ('T (SPADCALL |p| |ts| (QREFELT $ 15))))) 

(SDEFUN |RSETCAT-;purelyTranscendental?;PSB;2|
        ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (SPROG ((|lv| (|List| V)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 17)) 'T)
                      ('T
                       (SEQ (LETT |lv| (SPADCALL |p| (QREFELT $ 19)))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lv|) NIL)
                                          ('T
                                           (NULL
                                            (SPADCALL (|SPADfirst| |lv|) |ts|
                                                      (QREFELT $ 14))))))
                                   (GO G191)))
                                 (SEQ (EXIT (LETT |lv| (CDR |lv|)))) NIL
                                 (GO G190) G191 (EXIT NIL))
                            (EXIT (NULL |lv|)))))))) 

(SDEFUN |RSETCAT-;purelyAlgebraicLeadingMonomial?;PSB;3|
        ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |p| (QREFELT $ 12)) 'T)
              ((SPADCALL (SPADCALL |p| (QREFELT $ 13)) |ts| (QREFELT $ 14))
               (SPADCALL (SPADCALL |p| (QREFELT $ 21)) |ts| (QREFELT $ 22)))
              ('T NIL))) 

(SDEFUN |RSETCAT-;algebraicCoefficients?;PSB;4|
        ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (SEQ
         (COND ((SPADCALL |p| (QREFELT $ 12)) 'T)
               (#1='T
                (SEQ
                 (COND
                  ((NULL
                    (SPADCALL (SPADCALL |p| (QREFELT $ 21)) (QREFELT $ 12)))
                   (COND
                    ((NULL
                      (SPADCALL
                       (SPADCALL (SPADCALL |p| (QREFELT $ 21)) (QREFELT $ 13))
                       |ts| (QREFELT $ 14)))
                     (EXIT NIL)))))
                 (EXIT
                  (COND
                   ((SPADCALL (SPADCALL |p| (QREFELT $ 21)) |ts|
                              (QREFELT $ 15))
                    (COND
                     ((SPADCALL (SPADCALL |p| (QREFELT $ 24)) (QREFELT $ 12))
                      'T)
                     ((OR
                       (SPADCALL
                        (SPADCALL (SPADCALL |p| (QREFELT $ 24)) (QREFELT $ 13))
                        (SPADCALL |p| (QREFELT $ 13)) (QREFELT $ 25))
                       (SPADCALL
                        (SPADCALL (SPADCALL |p| (QREFELT $ 24)) (QREFELT $ 13))
                        |ts| (QREFELT $ 14)))
                      (SPADCALL (SPADCALL |p| (QREFELT $ 24)) |ts|
                                (QREFELT $ 15)))
                     ('T NIL)))
                   (#1# NIL)))))))) 

(SDEFUN |RSETCAT-;purelyAlgebraic?;SB;5| ((|ts| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G782 NIL) (|i| (|NonNegativeInteger|)) (#2=#:G771 NIL)
          (|v| (V)) (#3=#:G783 NIL) (|p| NIL) (|lp| (|List| P)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL |ts| (QREFELT $ 17))
                 (EQL (SPADCALL (QREFELT $ 28))
                      (SPADCALL |ts| (QREFELT $ 29))))
             'T)
            ('T
             (SEQ
              (LETT |lp|
                    (SPADCALL (ELT $ 30) (SPADCALL |ts| (QREFELT $ 32))
                              (QREFELT $ 34)))
              (LETT |i| (SPADCALL (QREFELT $ 28)))
              (SEQ (LETT |p| NIL) (LETT #3# |lp|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 13)))
                        (EXIT
                         (COND
                          ((OR (EQL |i| (SPADCALL |v| (QREFELT $ 36)))
                               (OR (SPADCALL |p| (QREFELT $ 42))
                                   (NULL
                                    (NULL
                                     (SPADCALL |p|
                                               (SPADCALL |ts| |v|
                                                         (QREFELT $ 43))
                                               (QREFELT $ 15))))))
                           (LETT |i|
                                 (PROG2
                                     (LETT #2# (SPADCALL |i| 1 (QREFELT $ 40)))
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|NonNegativeInteger|)
                                                   (|Union|
                                                    (|NonNegativeInteger|)
                                                    "failed")
                                                   #2#))))
                          ('T (PROGN (LETT #1# NIL) (GO #4=#:G781))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT 'T)))))
          #4# (EXIT #1#)))) 

(SDEFUN |RSETCAT-;purelyAlgebraic?;SB;6| ((|ts| (S)) ($ (|Boolean|)))
        (SPROG ((|p| (P)) (#1=#:G785 NIL) (|v| (V)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 17)) 'T)
                      ('T
                       (SEQ (LETT |v| (SPADCALL |ts| (QREFELT $ 45)))
                            (LETT |p|
                                  (PROG2
                                      (LETT #1#
                                            (SPADCALL |ts| |v| (QREFELT $ 47)))
                                      (QCDR #1#)
                                    (|check_union2| (QEQCAR #1# 0)
                                                    (QREFELT $ 10)
                                                    (|Union| (QREFELT $ 10)
                                                             "failed")
                                                    #1#)))
                            (LETT |ts| (SPADCALL |ts| |v| (QREFELT $ 43)))
                            (EXIT
                             (COND
                              ((SPADCALL |ts| (QREFELT $ 17))
                               (SPADCALL |p| (QREFELT $ 42)))
                              ((NULL (SPADCALL |ts| (QREFELT $ 48))) NIL)
                              ('T (SPADCALL |p| |ts| (QREFELT $ 15))))))))))) 

(SDEFUN |RSETCAT-;augment;P2L;7| ((|p| (P)) (|lts| (|List| S)) ($ (|List| S)))
        (SPROG ((|toSave| (|List| S)) (|ts| (S)))
               (SEQ (LETT |toSave| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |lts|))) (GO G191)))
                         (SEQ (LETT |ts| (|SPADfirst| |lts|))
                              (LETT |lts| (CDR |lts|))
                              (EXIT
                               (LETT |toSave|
                                     (SPADCALL
                                      (SPADCALL |p| |ts| (QREFELT $ 50))
                                      |toSave| (QREFELT $ 52)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |toSave|)))) 

(SDEFUN |RSETCAT-;augment;LSL;8| ((|lp| (|List| P)) (|ts| (S)) ($ (|List| S)))
        (SPROG ((|toSave| (|List| S)) (|p| (P)))
               (SEQ (LETT |toSave| (LIST |ts|))
                    (EXIT
                     (COND ((NULL |lp|) |toSave|)
                           ('T
                            (SEQ
                             (LETT |lp|
                                   (SPADCALL (ELT $ 30) |lp| (QREFELT $ 34)))
                             (SEQ G190
                                  (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                                  (SEQ (LETT |p| (|SPADfirst| |lp|))
                                       (LETT |lp| (CDR |lp|))
                                       (EXIT
                                        (LETT |toSave|
                                              (SPADCALL |p| |toSave|
                                                        (QREFELT $ 54)))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT |toSave|)))))))) 

(SDEFUN |RSETCAT-;augment;L2L;9|
        ((|lp| (|List| P)) (|lts| (|List| S)) ($ (|List| S)))
        (SPROG ((|toSave| (|List| S)) (|ts| (S)))
               (SEQ
                (COND ((NULL |lp|) |lts|)
                      ('T
                       (SEQ (LETT |toSave| NIL)
                            (SEQ G190
                                 (COND ((NULL (NULL (NULL |lts|))) (GO G191)))
                                 (SEQ (LETT |ts| (|SPADfirst| |lts|))
                                      (LETT |lts| (CDR |lts|))
                                      (EXIT
                                       (LETT |toSave|
                                             (SPADCALL
                                              (SPADCALL |lp| |ts|
                                                        (QREFELT $ 56))
                                              |toSave| (QREFELT $ 52)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT |toSave|))))))) 

(SDEFUN |RSETCAT-;extend;P2L;10| ((|p| (P)) (|lts| (|List| S)) ($ (|List| S)))
        (SPROG ((|toSave| (|List| S)) (|ts| (S)))
               (SEQ (LETT |toSave| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |lts|))) (GO G191)))
                         (SEQ (LETT |ts| (|SPADfirst| |lts|))
                              (LETT |lts| (CDR |lts|))
                              (EXIT
                               (LETT |toSave|
                                     (SPADCALL
                                      (SPADCALL |p| |ts| (QREFELT $ 58))
                                      |toSave| (QREFELT $ 52)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |toSave|)))) 

(SDEFUN |RSETCAT-;extend;LSL;11| ((|lp| (|List| P)) (|ts| (S)) ($ (|List| S)))
        (SPROG ((|toSave| (|List| S)) (|p| (P)))
               (SEQ (LETT |toSave| (LIST |ts|))
                    (EXIT
                     (COND ((NULL |lp|) |toSave|)
                           ('T
                            (SEQ
                             (LETT |lp|
                                   (SPADCALL (ELT $ 30) |lp| (QREFELT $ 34)))
                             (SEQ G190
                                  (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                                  (SEQ (LETT |p| (|SPADfirst| |lp|))
                                       (LETT |lp| (CDR |lp|))
                                       (EXIT
                                        (LETT |toSave|
                                              (SPADCALL |p| |toSave|
                                                        (QREFELT $ 60)))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT |toSave|)))))))) 

(SDEFUN |RSETCAT-;extend;L2L;12|
        ((|lp| (|List| P)) (|lts| (|List| S)) ($ (|List| S)))
        (SPROG ((|toSave| (|List| S)) (|ts| (S)))
               (SEQ
                (COND ((NULL |lp|) |lts|)
                      ('T
                       (SEQ (LETT |toSave| NIL)
                            (SEQ G190
                                 (COND ((NULL (NULL (NULL |lts|))) (GO G191)))
                                 (SEQ (LETT |ts| (|SPADfirst| |lts|))
                                      (LETT |lts| (CDR |lts|))
                                      (EXIT
                                       (LETT |toSave|
                                             (SPADCALL
                                              (SPADCALL |lp| |ts|
                                                        (QREFELT $ 62))
                                              |toSave| (QREFELT $ 52)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT |toSave|))))))) 

(SDEFUN |RSETCAT-;intersect;L2L;13|
        ((|lp| (|List| P)) (|lts| (|List| S)) ($ (|List| S)))
        (SPROG
         ((|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| S))))
          (#1=#:G873 NIL) (|us| NIL) (#2=#:G872 NIL) (|lus| (|List| S))
          (|p| (P)) (|toSave| (|List| S)) (|ts| (S))
          (|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| S)))
          (#3=#:G871 NIL) (#4=#:G870 NIL) (#5=#:G869 NIL) (#6=#:G868 NIL))
         (SEQ
          (COND ((OR (NULL |lp|) (NULL |lts|)) |lts|)
                ('T
                 (SEQ
                  (LETT |lp|
                        (PROGN
                         (LETT #6# NIL)
                         (SEQ (LETT #5# |lp|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |p| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #6#
                                      (CONS (SPADCALL |p| (QREFELT $ 64))
                                            #6#))))
                              (LETT #5# (CDR #5#)) (GO G190) G191
                              (EXIT (NREVERSE #6#)))))
                  (LETT |lp| (SPADCALL |lp| (QREFELT $ 65)))
                  (LETT |lp| (SPADCALL (ELT $ 66) |lp| (QREFELT $ 68)))
                  (EXIT
                   (COND ((SPADCALL (ELT $ 12) |lp| (QREFELT $ 69)) NIL)
                         ('T
                          (SEQ
                           (LETT |toSee|
                                 (PROGN
                                  (LETT #4# NIL)
                                  (SEQ (LETT #3# |lts|) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN (LETT |ts| (CAR #3#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #4#
                                               (CONS (CONS |lp| |ts|) #4#))))
                                       (LETT #3# (CDR #3#)) (GO G190) G191
                                       (EXIT (NREVERSE #4#)))))
                           (LETT |toSave| NIL)
                           (SEQ G190
                                (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                                (SEQ (LETT |lpwt| (|SPADfirst| |toSee|))
                                     (LETT |toSee| (CDR |toSee|))
                                     (LETT |lp| (QCAR |lpwt|))
                                     (LETT |ts| (QCDR |lpwt|))
                                     (EXIT
                                      (COND
                                       ((NULL |lp|)
                                        (LETT |toSave| (CONS |ts| |toSave|)))
                                       ('T
                                        (SEQ (LETT |p| (|SPADfirst| |lp|))
                                             (LETT |lp| (CDR |lp|))
                                             (LETT |lus|
                                                   (SPADCALL |p| |ts|
                                                             (QREFELT $ 70)))
                                             (EXIT
                                              (LETT |toSee|
                                                    (SPADCALL
                                                     (PROGN
                                                      (LETT #2# NIL)
                                                      (SEQ (LETT |us| NIL)
                                                           (LETT #1# |lus|)
                                                           G190
                                                           (COND
                                                            ((OR (ATOM #1#)
                                                                 (PROGN
                                                                  (LETT |us|
                                                                        (CAR
                                                                         #1#))
                                                                  NIL))
                                                             (GO G191)))
                                                           (SEQ
                                                            (EXIT
                                                             (LETT #2#
                                                                   (CONS
                                                                    (CONS |lp|
                                                                          |us|)
                                                                    #2#))))
                                                           (LETT #1# (CDR #1#))
                                                           (GO G190) G191
                                                           (EXIT
                                                            (NREVERSE #2#))))
                                                     |toSee|
                                                     (QREFELT $ 73)))))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT |toSave|))))))))))) 

(SDEFUN |RSETCAT-;intersect;LSL;14|
        ((|lp| (|List| P)) (|ts| (S)) ($ (|List| S)))
        (SPADCALL |lp| (LIST |ts|) (QREFELT $ 75))) 

(SDEFUN |RSETCAT-;intersect;P2L;15|
        ((|p| (P)) (|lts| (|List| S)) ($ (|List| S)))
        (SPADCALL (LIST |p|) |lts| (QREFELT $ 75))) 

(DECLAIM (NOTINLINE |RegularTriangularSetCategory&;|)) 

(DEFUN |RegularTriangularSetCategory&| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$|
          (LIST '|RegularTriangularSetCategory&| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 78))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#4| '(|Finite|))
      (QSETREFV $ 44
                (CONS (|dispatchFunction| |RSETCAT-;purelyAlgebraic?;SB;5|)
                      $)))
     ('T
      (QSETREFV $ 44
                (CONS (|dispatchFunction| |RSETCAT-;purelyAlgebraic?;SB;6|)
                      $))))
    $))) 

(MAKEPROP '|RegularTriangularSetCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|Boolean|)
              (0 . |ground?|) (5 . |mvar|) (10 . |algebraic?|)
              (16 . |algebraicCoefficients?|) |RSETCAT-;purelyAlgebraic?;PSB;1|
              (22 . |empty?|) (|List| 9) (27 . |variables|)
              |RSETCAT-;purelyTranscendental?;PSB;2| (32 . |init|)
              (37 . |purelyAlgebraicLeadingMonomial?|)
              |RSETCAT-;purelyAlgebraicLeadingMonomial?;PSB;3| (43 . |tail|)
              (48 . =) |RSETCAT-;algebraicCoefficients?;PSB;4|
              (|NonNegativeInteger|) (54 . |size|) (58 . |#|)
              (63 . |infRittWu?|) (|List| 10) (69 . |members|)
              (|Mapping| 11 10 10) (74 . |sort|) (|PositiveInteger|)
              (80 . |lookup|) (85 . |One|) (89 . |One|) (|Union| $ '"failed")
              (93 . |subtractIfCan|) (|PolynomialSetUtilitiesPackage| 7 8 9 10)
              (99 . |univariate?|) (104 . |collectUnder|)
              (110 . |purelyAlgebraic?|) (115 . |mvar|) (|Union| 10 '"failed")
              (120 . |select|) (126 . |purelyAlgebraic?|) (|List| $)
              (131 . |augment|) (|List| 6) (137 . |concat|)
              |RSETCAT-;augment;P2L;7| (143 . |augment|)
              |RSETCAT-;augment;LSL;8| (149 . |augment|)
              |RSETCAT-;augment;L2L;9| (155 . |extend|)
              |RSETCAT-;extend;P2L;10| (161 . |extend|)
              |RSETCAT-;extend;LSL;11| (167 . |extend|)
              |RSETCAT-;extend;L2L;12| (173 . |primitivePart|)
              (178 . |removeDuplicates|) (183 . |zero?|) (|Mapping| 11 10)
              (188 . |remove|) (194 . |any?|) (200 . |intersect|)
              (|Record| (|:| |val| 31) (|:| |tower| 6)) (|List| 71)
              (206 . |concat|) |RSETCAT-;intersect;L2L;13| (212 . |intersect|)
              |RSETCAT-;intersect;LSL;14| |RSETCAT-;intersect;P2L;15|)
           '#(|purelyTranscendental?| 218 |purelyAlgebraicLeadingMonomial?| 224
              |purelyAlgebraic?| 230 |intersect| 241 |extend| 259 |augment| 277
              |algebraicCoefficients?| 295)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|extend|
                                 ((|List| |#1|) (|List| |#5|) (|List| |#1|)))
                                T)
                              '((|extend| ((|List| |#1|) (|List| |#5|) |#1|))
                                T)
                              '((|extend| ((|List| |#1|) |#5| (|List| |#1|)))
                                T)
                              '((|extend| ((|List| |#1|) |#5| |#1|)) T)
                              '((|augment|
                                 ((|List| |#1|) (|List| |#5|) (|List| |#1|)))
                                T)
                              '((|augment| ((|List| |#1|) (|List| |#5|) |#1|))
                                T)
                              '((|augment| ((|List| |#1|) |#5| (|List| |#1|)))
                                T)
                              '((|augment| ((|List| |#1|) |#5| |#1|)) T)
                              '((|intersect|
                                 ((|List| |#1|) |#5| (|List| |#1|)))
                                T)
                              '((|intersect|
                                 ((|List| |#1|) (|List| |#5|) (|List| |#1|)))
                                T)
                              '((|intersect|
                                 ((|List| |#1|) (|List| |#5|) |#1|))
                                T)
                              '((|intersect| ((|List| |#1|) |#5| |#1|)) T)
                              '((|purelyAlgebraicLeadingMonomial?|
                                 ((|Boolean|) |#5| |#1|))
                                T)
                              '((|purelyAlgebraic?| ((|Boolean|) |#1|)) T)
                              '((|algebraicCoefficients?|
                                 ((|Boolean|) |#5| |#1|))
                                T)
                              '((|purelyTranscendental?|
                                 ((|Boolean|) |#5| |#1|))
                                T)
                              '((|purelyAlgebraic?| ((|Boolean|) |#5| |#1|)) T)
                              '((|extend| (|#1| |#1| |#5|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 77
                                            '(1 10 11 0 12 1 10 9 0 13 2 6 11 9
                                              0 14 2 6 11 10 0 15 1 6 11 0 17 1
                                              10 18 0 19 1 10 0 0 21 2 6 11 10
                                              0 22 1 10 0 0 24 2 9 11 0 0 25 0
                                              9 27 28 1 6 27 0 29 2 10 11 0 0
                                              30 1 6 31 0 32 2 31 0 33 0 34 1 9
                                              35 0 36 0 7 0 37 0 10 0 38 2 27
                                              39 0 0 40 1 41 11 10 42 2 6 0 0 9
                                              43 1 0 11 0 44 1 6 9 0 45 2 6 46
                                              0 9 47 1 6 11 0 48 2 6 49 10 0 50
                                              2 51 0 0 0 52 2 6 49 10 49 54 2 6
                                              49 31 0 56 2 6 49 10 0 58 2 6 49
                                              10 49 60 2 6 49 31 0 62 1 10 0 0
                                              64 1 31 0 0 65 1 10 11 0 66 2 31
                                              0 67 0 68 2 31 11 67 0 69 2 6 49
                                              10 0 70 2 72 0 0 0 73 2 6 49 31
                                              49 75 2 0 11 10 0 20 2 0 11 10 0
                                              23 1 0 11 0 44 2 0 11 10 0 16 2 0
                                              49 10 49 77 2 0 49 31 0 76 2 0 49
                                              31 49 74 2 0 49 31 0 61 2 0 49 31
                                              49 63 2 0 49 10 49 59 2 0 49 31 0
                                              55 2 0 49 31 49 57 2 0 49 10 49
                                              53 2 0 11 10 0 26)))))
           '|lookupComplete|)) 
