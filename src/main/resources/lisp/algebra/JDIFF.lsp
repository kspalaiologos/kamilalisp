
(SDEFUN |JDIFF;d;JB$;1| ((|jb| (JB)) ($ ($)))
        (CONS (LIST (|spadConstant| $ 9)) (LIST |jb|))) 

(SDEFUN |JDIFF;dX;Pi$;2| ((|i| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 12)) (QREFELT $ 10))) 

(SDEFUN |JDIFF;dU;Pi$;3| ((|i| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 14)) (QREFELT $ 10))) 

(SDEFUN |JDIFF;dP;PiL$;4|
        ((|i| (|PositiveInteger|)) (|mu| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (SPADCALL (SPADCALL |i| |mu| (QREFELT $ 17)) (QREFELT $ 10))) 

(SDEFUN |JDIFF;monom| ((|c| (D)) (|jb| (JB)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |c| (QREFELT $ 20))
          (SPADCALL (SPADCALL "d" (QREFELT $ 23))
                    (SPADCALL |jb| (QREFELT $ 24)) (QREFELT $ 25)))
         ('T
          (SPADCALL (SPADCALL |c| (QREFELT $ 26))
                    (SPADCALL (SPADCALL "d" (QREFELT $ 23))
                              (SPADCALL |jb| (QREFELT $ 24)) (QREFELT $ 25))
                    (QREFELT $ 27))))) 

(SDEFUN |JDIFF;coerce;$Of;6| ((|om| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G733 NIL) (|c| NIL) (#2=#:G734 NIL) (|jb| NIL) (#3=#:G732 NIL))
         (SEQ
          (COND
           ((NULL (QCDR |om|)) (SPADCALL (|spadConstant| $ 28) (QREFELT $ 26)))
           ((EQL (LENGTH (QCDR |om|)) 1)
            (|JDIFF;monom| (|SPADfirst| (QCAR |om|)) (|SPADfirst| (QCDR |om|))
             $))
           ('T
            (SPADCALL (ELT $ 29)
                      (PROGN
                       (LETT #3# NIL)
                       (SEQ (LETT |jb| NIL) (LETT #2# (QCDR |om|))
                            (LETT |c| NIL) (LETT #1# (QCAR |om|)) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL)
                                  (ATOM #2#) (PROGN (LETT |jb| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #3#
                                    (CONS (|JDIFF;monom| |c| |jb| $) #3#))))
                            (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                            (GO G190) G191 (EXIT (NREVERSE #3#))))
                      (QREFELT $ 32))))))) 

(SDEFUN |JDIFF;coefficients;$L;7| ((|om| ($)) ($ (|List| D)))
        (SPADCALL (QCAR |om|) (QREFELT $ 35))) 

(SDEFUN |JDIFF;differentials;$L;8| ((|om| ($)) ($ (|List| JB)))
        (SPADCALL (QCDR |om|) (QREFELT $ 38))) 

(SDEFUN |JDIFF;coefficient;$JBD;9| ((|om| ($)) (|jb| (JB)) ($ (D)))
        (SPROG ((|pos| (|Integer|)))
               (SEQ (LETT |pos| (SPADCALL |jb| (QCDR |om|) (QREFELT $ 41)))
                    (EXIT
                     (COND
                      ((< |pos| (PROGN (QCDR |om|) 1)) (|spadConstant| $ 28))
                      ('T (SPADCALL (QCAR |om|) |pos| (QREFELT $ 42)))))))) 

(SDEFUN |JDIFF;copy;2$;10| ((|om| ($)) ($ ($)))
        (CONS (SPADCALL (QCAR |om|) (QREFELT $ 35))
              (SPADCALL (QCDR |om|) (QREFELT $ 38)))) 

(PUT '|JDIFF;Zero;$;11| '|SPADreplace| '(XLAM NIL (CONS NIL NIL))) 

(SDEFUN |JDIFF;Zero;$;11| (($ ($))) (CONS NIL NIL)) 

(SDEFUN |JDIFF;zero?;$B;12| ((|om| ($)) ($ (|Boolean|))) (NULL (QCDR |om|))) 

(SDEFUN |JDIFF;-;2$;13| ((|om| ($)) ($ ($)))
        (SPROG ((#1=#:G746 NIL) (|c| NIL) (#2=#:G745 NIL))
               (SEQ
                (CONS
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |c| NIL) (LETT #1# (QCAR |om|)) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |c| (QREFELT $ 47)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QCDR |om|))))) 

(SDEFUN |JDIFF;+;3$;14| ((|om1| ($)) (|om2| ($)) ($ ($)))
        (SPROG
         ((|lj2| (|List| JB)) (|lc2| (|List| D)) (|resJ| (|List| JB))
          (|resC| (|List| D)) (|sum| (D)) (#1=#:G765 NIL) (|c1| NIL)
          (#2=#:G766 NIL) (|j1| NIL))
         (SEQ
          (COND ((SPADCALL |om1| (QREFELT $ 46)) |om2|)
                ((SPADCALL |om2| (QREFELT $ 46)) |om1|)
                ('T
                 (SEQ (LETT |lc2| (SPADCALL (QCAR |om2|) (QREFELT $ 35)))
                      (LETT |lj2| (SPADCALL (QCDR |om2|) (QREFELT $ 38)))
                      (LETT |resC| NIL) (LETT |resJ| NIL)
                      (SEQ (LETT |j1| NIL) (LETT #2# (QCDR |om1|))
                           (LETT |c1| NIL) (LETT #1# (QCAR |om1|)) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |c1| (CAR #1#)) NIL)
                                 (ATOM #2#) (PROGN (LETT |j1| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lj2|) NIL)
                                          ('T
                                           (SPADCALL (|SPADfirst| |lj2|) |j1|
                                                     (QREFELT $ 49)))))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |resC|
                                        (CONS (|SPADfirst| |lc2|) |resC|))
                                  (LETT |resJ|
                                        (CONS (|SPADfirst| |lj2|) |resJ|))
                                  (LETT |lc2| (CDR |lc2|))
                                  (EXIT (LETT |lj2| (CDR |lj2|))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT
                             (COND
                              ((OR (NULL |lj2|)
                                   (NULL
                                    (SPADCALL (|SPADfirst| |lj2|) |j1|
                                              (QREFELT $ 50))))
                               (SEQ (LETT |resC| (CONS |c1| |resC|))
                                    (EXIT (LETT |resJ| (CONS |j1| |resJ|)))))
                              ('T
                               (SEQ
                                (LETT |sum|
                                      (SPADCALL |c1| (|SPADfirst| |lc2|)
                                                (QREFELT $ 51)))
                                (COND
                                 ((NULL (SPADCALL |sum| (QREFELT $ 52)))
                                  (SEQ (LETT |resC| (CONS |sum| |resC|))
                                       (EXIT
                                        (LETT |resJ| (CONS |j1| |resJ|))))))
                                (LETT |lc2| (CDR |lc2|))
                                (EXIT (LETT |lj2| (CDR |lj2|))))))))
                           (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (CONS (SPADCALL (NREVERSE |resC|) |lc2| (QREFELT $ 53))
                             (SPADCALL (NREVERSE |resJ|) |lj2|
                                       (QREFELT $ 54)))))))))) 

(SDEFUN |JDIFF;*;D2$;15| ((|f| (D)) (|om| ($)) ($ ($)))
        (SPROG ((#1=#:G772 NIL) (|c| NIL) (#2=#:G771 NIL))
               (SEQ
                (COND ((SPADCALL |f| (QREFELT $ 52)) (|spadConstant| $ 45))
                      ('T
                       (CONS
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |c| NIL) (LETT #1# (QCAR |om|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |c| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |f| |c| (QREFELT $ 56))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QCDR |om|))))))) 

(SDEFUN |JDIFF;d;D$;16| ((|f| (D)) ($ ($)))
        (SPROG
         ((|Co| (|List| D)) (#1=#:G779 NIL) (|jv| NIL) (#2=#:G778 NIL)
          (JV (|List| JB)))
         (SEQ (LETT JV (NREVERSE (SPADCALL |f| (QREFELT $ 58))))
              (EXIT
               (COND ((NULL JV) (|spadConstant| $ 45))
                     ('T
                      (SEQ
                       (LETT |Co|
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |jv| NIL) (LETT #1# JV) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |jv| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (SPADCALL |f| |jv| (QREFELT $ 59))
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                       (EXIT (CONS |Co| JV))))))))) 

(SDEFUN |JDIFF;eval;$JvfD;17|
        ((|om| ($)) (|v| (|JetVectorField| JB D)) ($ (D)))
        (SPROG
         ((|lj2| (|List| JB)) (|lc2| (|List| D)) (|res| (D)) (#1=#:G794 NIL)
          (|c1| NIL) (#2=#:G795 NIL) (|j1| NIL))
         (SEQ
          (COND
           ((OR (SPADCALL |om| (QREFELT $ 46)) (SPADCALL |v| (QREFELT $ 62)))
            (|spadConstant| $ 28))
           ('T
            (SEQ
             (LETT |lc2|
                   (SPADCALL (SPADCALL |v| (QREFELT $ 63)) (QREFELT $ 35)))
             (LETT |lj2|
                   (SPADCALL (SPADCALL |v| (QREFELT $ 64)) (QREFELT $ 38)))
             (LETT |res| (|spadConstant| $ 28))
             (SEQ (LETT |j1| NIL) (LETT #2# (QCDR |om|)) (LETT |c1| NIL)
                  (LETT #1# (QCAR |om|)) G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |c1| (CAR #1#)) NIL) (ATOM #2#)
                        (PROGN (LETT |j1| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ
                   (SEQ G190
                        (COND
                         ((NULL
                           (COND ((NULL |lj2|) NIL)
                                 ('T
                                  (SPADCALL (|SPADfirst| |lj2|) |j1|
                                            (QREFELT $ 49)))))
                          (GO G191)))
                        (SEQ (LETT |lc2| (CDR |lc2|))
                             (EXIT (LETT |lj2| (CDR |lj2|))))
                        NIL (GO G190) G191 (EXIT NIL))
                   (EXIT
                    (COND
                     ((NULL (NULL |lj2|))
                      (COND
                       ((SPADCALL (|SPADfirst| |lj2|) |j1| (QREFELT $ 50))
                        (SEQ
                         (LETT |res|
                               (SPADCALL |res|
                                         (SPADCALL |c1| (|SPADfirst| |lc2|)
                                                   (QREFELT $ 56))
                                         (QREFELT $ 51)))
                         (LETT |lc2| (CDR |lc2|))
                         (EXIT (LETT |lj2| (CDR |lj2|))))))))))
                  (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                  G191 (EXIT NIL))
             (EXIT |res|))))))) 

(SDEFUN |JDIFF;contract;Jvf$D;18|
        ((|v| (|JetVectorField| JB D)) (|om| ($)) ($ (D)))
        (SPADCALL |om| |v| (QREFELT $ 65))) 

(DECLAIM (NOTINLINE |JetDifferential;|)) 

(DEFUN |JetDifferential| (&REST #1=#:G803)
  (SPROG NIL
         (PROG (#2=#:G804)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|JetDifferential|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetDifferential;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|JetDifferential|)))))))))) 

(DEFUN |JetDifferential;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G802 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|JetDifferential| DV$1 DV$2))
    (LETT $ (GETREFV 71))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|AbelianMonoid|)))
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #1#)))))
    (|haddProp| |$ConstructorCache| '|JetDifferential| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8
              (|Record| (|:| |Coeff| (|List| |#2|))
                        (|:| |Diff| (|List| |#1|))))
    $))) 

(MAKEPROP '|JetDifferential| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (0 . |One|) |JDIFF;d;JB$;1| (|PositiveInteger|) (4 . X)
              |JDIFF;dX;Pi$;2| (9 . U) |JDIFF;dU;Pi$;3| (|List| 68) (14 . P)
              |JDIFF;dP;PiL$;4| (|Boolean|) (20 . |one?|) (|String|)
              (|OutputForm|) (25 . |message|) (30 . |coerce|) (35 . |hconcat|)
              (41 . |coerce|) (46 . *) (52 . |Zero|) (56 . +)
              (|Mapping| 22 22 22) (|List| 22) (62 . |reduce|)
              |JDIFF;coerce;$Of;6| (|List| 7) (68 . |copy|)
              |JDIFF;coefficients;$L;7| (|List| 6) (73 . |copy|)
              |JDIFF;differentials;$L;8| (|Integer|) (78 . |position|)
              (84 . |qelt|) |JDIFF;coefficient;$JBD;9| |JDIFF;copy;2$;10|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |JDIFF;Zero;$;11|) $))
              |JDIFF;zero?;$B;12| (90 . -) |JDIFF;-;2$;13| (95 . <) (101 . =)
              (107 . +) (113 . |zero?|) (118 . |concat!|) (124 . |concat!|)
              |JDIFF;+;3$;14| (130 . *) |JDIFF;*;D2$;15| (136 . |jetVariables|)
              (141 . |differentiate|) |JDIFF;d;D$;16| (|JetVectorField| 6 7)
              (147 . |zero?|) (152 . |coefficients|) (157 . |directions|)
              |JDIFF;eval;$JvfD;17| |JDIFF;contract;Jvf$D;18|
              (|Union| $ '"failed") (|NonNegativeInteger|) (|HashState|)
              (|SingleInteger|))
           '#(~= 162 |zero?| 168 |subtractIfCan| 173 |sample| 179 |opposite?|
              183 |lie| 189 |latex| 195 |hashUpdate!| 200 |hash| 206 |eval| 211
              |differentials| 217 |dX| 222 |dU| 227 |dP| 232 |d| 238 |copy| 248
              |contract| 253 |coerce| 259 |coefficients| 264 |coefficient| 269
              |Zero| 275 = 279 - 285 + 296 * 302)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(0 0 0 0 1 1 3 0 0 0 0))
                 (CONS
                  '#(|Module&| NIL NIL NIL |AbelianGroup&| NIL |AbelianMonoid&|
                     |AbelianSemiGroup&| |SetCategory&| |BasicType&| NIL)
                  (CONS
                   '#((|Module| 7) (|BiModule| 7 7) (|LeftModule| 7)
                      (|RightModule| 7) (|AbelianGroup|)
                      (|CancellationAbelianMonoid|) (|AbelianMonoid|)
                      (|AbelianSemiGroup|) (|SetCategory|) (|BasicType|)
                      (|CoercibleTo| 22))
                   (|makeByteWordVec2| 70
                                       '(0 7 0 9 1 6 0 11 12 1 6 0 11 14 2 6 0
                                         11 16 17 1 7 19 0 20 1 22 0 21 23 1 6
                                         22 0 24 2 22 0 0 0 25 1 7 22 0 26 2 22
                                         0 0 0 27 0 7 0 28 2 22 0 0 0 29 2 31
                                         22 30 0 32 1 34 0 0 35 1 37 0 0 38 2
                                         37 40 6 0 41 2 34 7 0 40 42 1 7 0 0 47
                                         2 6 19 0 0 49 2 6 19 0 0 50 2 7 0 0 0
                                         51 1 7 19 0 52 2 34 0 0 0 53 2 37 0 0
                                         0 54 2 7 0 0 0 56 1 7 37 0 58 2 7 0 0
                                         6 59 1 61 19 0 62 1 61 34 0 63 1 61 37
                                         0 64 2 0 19 0 0 1 1 2 19 0 46 2 1 67 0
                                         0 1 0 2 0 1 2 2 19 0 0 1 2 0 0 61 0 1
                                         1 0 21 0 1 2 0 69 69 0 1 1 0 70 0 1 2
                                         0 7 0 61 65 1 0 37 0 39 1 0 0 11 13 1
                                         0 0 11 15 2 0 0 11 16 18 1 0 0 7 60 1
                                         0 0 6 10 1 0 0 0 44 2 0 7 61 0 66 1 0
                                         22 0 33 1 0 34 0 36 2 0 7 0 6 43 0 2 0
                                         45 2 0 19 0 0 1 2 1 0 0 0 1 1 1 0 0 48
                                         2 0 0 0 0 55 2 1 0 40 0 1 2 2 0 68 0 1
                                         2 0 0 0 7 1 2 0 0 7 0 57 2 0 0 11 0
                                         1)))))
           '|lookupComplete|)) 
