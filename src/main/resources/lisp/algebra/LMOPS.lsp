
(PUT '|LMOPS;makeUnit;$;1| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |LMOPS;makeUnit;$;1| (($ ($))) NIL) 

(SDEFUN |LMOPS;size;$Nni;2| ((|l| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL |l| (QREFELT $ 13)))) 

(SDEFUN |LMOPS;coerce;S$;3| ((|s| (S)) ($ ($))) (LIST (CONS |s| (QREFELT $ 8)))) 

(SDEFUN |LMOPS;coerce;$Of;4| ((|l| ($)) ($ (|OutputForm|)))
        (SPADCALL |l| (QREFELT $ 18))) 

(SDEFUN |LMOPS;makeTerm;SE$;5| ((|s| (S)) (|e| (E)) ($ ($)))
        (COND ((SPADCALL |e| (QREFELT $ 21)) (SPADCALL (QREFELT $ 10)))
              ('T (LIST (CONS |s| |e|))))) 

(PUT '|LMOPS;makeMulti;L$;6| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |LMOPS;makeMulti;L$;6|
        ((|l| (|List| (|Record| (|:| |gen| S) (|:| |exp| E)))) ($ ($))) |l|) 

(SDEFUN |LMOPS;=;2$B;7| ((|f| ($)) (|g| ($)) ($ (|Boolean|)))
        (SPADCALL |f| |g| (QREFELT $ 24))) 

(PUT '|LMOPS;listOfMonoms;$L;8| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |LMOPS;listOfMonoms;$L;8|
        ((|l| ($)) ($ (|List| (|Record| (|:| |gen| S) (|:| |exp| E))))) |l|) 

(SDEFUN |LMOPS;nthExpon;$IE;9| ((|f| ($)) (|i| (|Integer|)) ($ (E)))
        (QCDR (SPADCALL |f| (+ (- |i| 1) (PROGN |f| 1)) (QREFELT $ 27)))) 

(SDEFUN |LMOPS;nthFactor;$IS;10| ((|f| ($)) (|i| (|Integer|)) ($ (S)))
        (QCAR (SPADCALL |f| (+ (- |i| 1) (PROGN |f| 1)) (QREFELT $ 27)))) 

(PUT '|LMOPS;reverse;2$;11| '|SPADreplace| 'REVERSE) 

(SDEFUN |LMOPS;reverse;2$;11| ((|l| ($)) ($ ($))) (REVERSE |l|)) 

(PUT '|LMOPS;reverse!;2$;12| '|SPADreplace| 'NREVERSE) 

(SDEFUN |LMOPS;reverse!;2$;12| ((|l| ($)) ($ ($))) (NREVERSE |l|)) 

(SDEFUN |LMOPS;mapGen;M2$;13| ((|f| (|Mapping| S S)) (|l| ($)) ($ ($)))
        (SPROG ((#1=#:G749 NIL) (|x| NIL) (#2=#:G748 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (CONS (SPADCALL (QCAR |x|) |f|) (QCDR |x|))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |LMOPS;mapExpon;M2$;14| ((|f| (|Mapping| E E)) (|l| ($)) ($ ($)))
        (SPROG
         ((|ans| (|List| (|Record| (|:| |gen| S) (|:| |exp| E)))) (|a| (E))
          (#1=#:G757 NIL) (|x| NIL))
         (SEQ (LETT |ans| NIL)
              (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (LETT |a| (SPADCALL (QCDR |x|) |f|))
                                 (|spadConstant| $ 34) (QREFELT $ 35))
                       (LETT |ans| (CONS (CONS (QCAR |x|) |a|) |ans|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |ans| (QREFELT $ 31)))))) 

(SDEFUN |LMOPS;outputForm;$2MIOf;15|
        ((|l| ($))
         (|op| (|Mapping| (|OutputForm|) (|OutputForm|) (|OutputForm|)))
         (|opexp| (|Mapping| (|OutputForm|) (|OutputForm|) (|OutputForm|)))
         (|id| (|Integer|)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G768 NIL) (|p| NIL) (#2=#:G767 NIL))
               (SEQ
                (COND ((NULL |l|) (SPADCALL |id| (QREFELT $ 38)))
                      ('T
                       (SEQ
                        (LETT |l|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |p| NIL) (LETT #1# |l|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |p| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS
                                             (COND
                                              ((SPADCALL (QCDR |p|)
                                                         (QREFELT $ 8)
                                                         (QREFELT $ 39))
                                               (SPADCALL (QCAR |p|)
                                                         (QREFELT $ 40)))
                                              ('T
                                               (SPADCALL
                                                (SPADCALL (QCAR |p|)
                                                          (QREFELT $ 40))
                                                (SPADCALL (QCDR |p|)
                                                          (QREFELT $ 41))
                                                |opexp|)))
                                             #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#)))))
                        (EXIT (SPADCALL |op| |l| (QREFELT $ 44))))))))) 

(SDEFUN |LMOPS;retractIfCan;$U;16| ((|l| ($)) ($ (|Union| S "failed")))
        (SEQ
         (COND
          ((NULL (NULL |l|))
           (COND
            ((NULL (CDR |l|))
             (COND
              ((SPADCALL (QCDR (|SPADfirst| |l|)) (QREFELT $ 8) (QREFELT $ 39))
               (EXIT (CONS 0 (QCAR (|SPADfirst| |l|))))))))))
         (EXIT (CONS 1 "failed")))) 

(SDEFUN |LMOPS;rightMult;$S$;17| ((|f| ($)) (|s| (S)) ($ ($)))
        (SPROG ((|h| ($)))
               (SEQ
                (COND ((NULL |f|) (SPADCALL |s| (QREFELT $ 16)))
                      ((SPADCALL |s|
                                 (QCAR (SPADCALL |f| '|last| (QREFELT $ 49)))
                                 (QREFELT $ 50))
                       (SEQ
                        (SPADCALL (LETT |h| (SPADCALL |f| (QREFELT $ 51)))
                                  (CONS |s|
                                        (SPADCALL
                                         (QCDR
                                          (SPADCALL |f| '|last|
                                                    (QREFELT $ 49)))
                                         (QREFELT $ 8) (QREFELT $ 52)))
                                  (QREFELT $ 53))
                        (EXIT |h|)))
                      ('T
                       (SPADCALL |f| (CONS |s| (QREFELT $ 8))
                                 (QREFELT $ 54))))))) 

(SDEFUN |LMOPS;leftMult;S2$;18| ((|s| (S)) (|f| ($)) ($ ($)))
        (COND ((NULL |f|) (SPADCALL |s| (QREFELT $ 16)))
              ((SPADCALL |s| (QCAR (|SPADfirst| |f|)) (QREFELT $ 50))
               (CONS
                (CONS |s|
                      (SPADCALL (QCDR (|SPADfirst| |f|)) (QREFELT $ 8)
                                (QREFELT $ 52)))
                (CDR |f|)))
              ('T (CONS (CONS |s| (QREFELT $ 8)) |f|)))) 

(DECLAIM (NOTINLINE |ListMonoidOps;|)) 

(DEFUN |ListMonoidOps| (&REST #1=#:G794)
  (SPROG NIL
         (PROG (#2=#:G795)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|ListMonoidOps|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ListMonoidOps;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ListMonoidOps|)))))))))) 

(DEFUN |ListMonoidOps;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 |#3|)
          (LETT |dv$| (LIST '|ListMonoidOps| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 60))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ListMonoidOps|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (|List| (|Record| (|:| |gen| |#1|) (|:| |exp| |#2|))))
          $))) 

(MAKEPROP '|ListMonoidOps| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|Rep| |LMOPS;makeUnit;$;1|
              (|Record| (|:| |gen| 6) (|:| |exp| 7)) (|List| 11)
              |LMOPS;listOfMonoms;$L;8| (|NonNegativeInteger|)
              |LMOPS;size;$Nni;2| |LMOPS;coerce;S$;3| (|OutputForm|)
              (0 . |coerce|) |LMOPS;coerce;$Of;4| (|Boolean|) (5 . |zero?|)
              |LMOPS;makeTerm;SE$;5| |LMOPS;makeMulti;L$;6| (10 . =)
              |LMOPS;=;2$B;7| (|Integer|) (16 . |elt|) |LMOPS;nthExpon;$IE;9|
              |LMOPS;nthFactor;$IS;10| |LMOPS;reverse;2$;11|
              |LMOPS;reverse!;2$;12| (|Mapping| 6 6) |LMOPS;mapGen;M2$;13|
              (22 . |Zero|) (26 . ~=) (|Mapping| 7 7) |LMOPS;mapExpon;M2$;14|
              (32 . |coerce|) (37 . =) (43 . |coerce|) (48 . |coerce|)
              (|Mapping| 17 17 17) (|List| 17) (53 . |reduce|)
              |LMOPS;outputForm;$2MIOf;15| (|Union| 6 '"failed")
              |LMOPS;retractIfCan;$U;16| '"last" (59 . |elt|) (65 . =)
              (71 . |copy|) (76 . +) (82 . |setlast!|) (88 . |concat|)
              |LMOPS;rightMult;$S$;17| |LMOPS;leftMult;S2$;18| (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 94 |size| 100 |rightMult| 105 |reverse!| 111 |reverse| 116
              |retractIfCan| 121 |retract| 126 |outputForm| 131 |nthFactor| 139
              |nthExpon| 145 |mapGen| 151 |mapExpon| 157 |makeUnit| 163
              |makeTerm| 167 |makeMulti| 173 |listOfMonoms| 178 |leftMult| 183
              |latex| 189 |hashUpdate!| 194 |hash| 200 |coerce| 205 = 215)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0))
                 (CONS '#(|SetCategory&| |RetractableTo&| |BasicType&| NIL NIL)
                       (CONS
                        '#((|SetCategory|) (|RetractableTo| 6) (|BasicType|)
                           (|CoercibleFrom| 6) (|CoercibleTo| 17))
                        (|makeByteWordVec2| 59
                                            '(1 9 17 0 18 1 7 20 0 21 2 9 20 0
                                              0 24 2 9 11 0 26 27 0 7 0 34 2 7
                                              20 0 0 35 1 26 17 0 38 2 7 20 0 0
                                              39 1 6 17 0 40 1 7 17 0 41 2 43
                                              17 42 0 44 2 9 11 0 48 49 2 6 20
                                              0 0 50 1 9 0 0 51 2 7 0 0 0 52 2
                                              9 11 0 11 53 2 9 0 0 11 54 2 0 20
                                              0 0 1 1 0 14 0 15 2 0 0 0 6 55 1
                                              0 0 0 31 1 0 0 0 30 1 0 46 0 47 1
                                              0 6 0 1 4 0 17 0 42 42 26 45 2 0
                                              6 0 26 29 2 0 7 0 26 28 2 0 0 32
                                              0 33 2 0 0 36 0 37 0 0 0 10 2 0 0
                                              6 7 22 1 0 0 12 23 1 0 12 0 13 2
                                              0 0 6 0 56 1 0 57 0 1 2 0 59 59 0
                                              1 1 0 58 0 1 1 0 0 6 16 1 0 17 0
                                              19 2 0 20 0 0 25)))))
           '|lookupComplete|)) 
