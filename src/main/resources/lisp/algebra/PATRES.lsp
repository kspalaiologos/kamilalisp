
(SDEFUN |PATRES;new;$;1| (($ ($))) (CONS 0 (SPADCALL (QREFELT $ 10)))) 

(PUT '|PATRES;failed;$;2| '|SPADreplace| '(XLAM NIL (CONS 1 "failed"))) 

(SDEFUN |PATRES;failed;$;2| (($ ($))) (CONS 1 "failed")) 

(PUT '|PATRES;failed?;$B;3| '|SPADreplace| '(XLAM (|x|) (QEQCAR |x| 1))) 

(SDEFUN |PATRES;failed?;$B;3| ((|x| ($)) ($ (|Boolean|))) (QEQCAR |x| 1)) 

(SDEFUN |PATRES;insertMatch;PS2$;4|
        ((|p| (|Pattern| R)) (|x| (S)) (|l| ($)) ($ ($)))
        (CONS 0
              (SPADCALL (CONS (SPADCALL |p| (QREFELT $ 17)) |x|) (QCDR |l|)
                        (QREFELT $ 19)))) 

(SDEFUN |PATRES;construct;L$;5|
        ((|l| (|List| (|Record| (|:| |key| (|Symbol|)) (|:| |entry| S))))
         ($ ($)))
        (CONS 0 (SPADCALL |l| (QREFELT $ 22)))) 

(SDEFUN |PATRES;destruct;$L;6|
        ((|l| ($))
         ($ (|List| (|Record| (|:| |key| (|Symbol|)) (|:| |entry| S)))))
        (SPADCALL (QCDR |l|) (QREFELT $ 24))) 

(SDEFUN |PATRES;satisfy?;$PU;7|
        ((|r| ($)) (|p| (|Pattern| R)) ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|lv| (|List| S)) (#1=#:G747 NIL) (|u| (|Union| S "failed"))
          (#2=#:G749 NIL) (|v| NIL) (#3=#:G748 NIL)
          (|lr| (|AssociationList| (|Symbol|) S)))
         (SEQ
          (EXIT
           (COND ((SPADCALL |r| (QREFELT $ 14)) (CONS 0 NIL))
                 ('T
                  (SEQ (LETT |lr| (QCDR |r|))
                       (LETT |lv|
                             (PROGN
                              (LETT #3# NIL)
                              (SEQ (LETT |v| NIL)
                                   (LETT #2#
                                         (QCAR (SPADCALL |p| (QREFELT $ 27))))
                                   G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |v| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #3#
                                           (CONS
                                            (SEQ
                                             (LETT |u|
                                                   (SPADCALL |v| |lr|
                                                             (QREFELT $ 29)))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |u| 1)
                                                (PROGN
                                                 (LETT #1# (CONS 1 "failed"))
                                                 (GO #4=#:G746)))
                                               ('T (QCDR |u|)))))
                                            #3#))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT (NREVERSE #3#)))))
                       (EXIT (CONS 0 (SPADCALL |lv| |p| (QREFELT $ 32))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |PATRES;union;3$;8| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND
         ((OR (SPADCALL |x| (QREFELT $ 14)) (SPADCALL |y| (QREFELT $ 14)))
          (SPADCALL (QREFELT $ 12)))
         ('T
          (CONS 0
                (SPADCALL (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 35))
                          (QREFELT $ 36)))))) 

(SDEFUN |PATRES;=;2$B;9| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 14)) (SPADCALL |y| (QREFELT $ 14)))
              ((SPADCALL |y| (QREFELT $ 14)) NIL)
              ('T (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 38))))) 

(SDEFUN |PATRES;coerce;$Of;10| ((|x| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |x| (QREFELT $ 14))
          (SPADCALL "Does not match" (QREFELT $ 42)))
         ('T (SPADCALL (SPADCALL |x| (QREFELT $ 25)) (QREFELT $ 43))))) 

(SDEFUN |PATRES;addMatchRestricted;PS$S$;11|
        ((|p| (|Pattern| R)) (|x| (S)) (|l| ($)) (|ident| (S)) ($ ($)))
        (SEQ
         (COND
          ((NULL (SPADCALL |p| (QREFELT $ 45)))
           (COND
            ((SPADCALL |x| |ident| (QREFELT $ 46))
             (EXIT (SPADCALL (QREFELT $ 12)))))))
         (EXIT (SPADCALL |p| |x| |l| (QREFELT $ 47))))) 

(SDEFUN |PATRES;addMatch;PS2$;12|
        ((|p| (|Pattern| R)) (|x| (S)) (|l| ($)) ($ ($)))
        (SPROG
         ((|r| (|Union| S "failed")) (|sy| (|Symbol|))
          (|al| (|AssociationList| (|Symbol|) S)))
         (SEQ
          (COND
           ((OR (SPADCALL |l| (QREFELT $ 14))
                (NULL (SPADCALL |x| |p| (QREFELT $ 49))))
            (SPADCALL (QREFELT $ 12)))
           ('T
            (SEQ (LETT |al| (QCDR |l|))
                 (LETT |sy| (SPADCALL |p| (QREFELT $ 17)))
                 (LETT |r| (SPADCALL |sy| |al| (QREFELT $ 29)))
                 (EXIT
                  (COND ((QEQCAR |r| 1) (SPADCALL |p| |x| |l| (QREFELT $ 20)))
                        ((SPADCALL (QCDR |r|) |x| (QREFELT $ 46)) |l|)
                        ('T (SPADCALL (QREFELT $ 12))))))))))) 

(SDEFUN |PATRES;getMatch;P$U;13|
        ((|p| (|Pattern| R)) (|l| ($)) ($ (|Union| S "failed")))
        (COND ((SPADCALL |l| (QREFELT $ 14)) (CONS 1 "failed"))
              ('T
               (SPADCALL (SPADCALL |p| (QREFELT $ 17)) (QCDR |l|)
                         (QREFELT $ 29))))) 

(DECLAIM (NOTINLINE |PatternMatchResult;|)) 

(DEFUN |PatternMatchResult| (&REST #1=#:G785)
  (SPROG NIL
         (PROG (#2=#:G786)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchResult|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatchResult;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternMatchResult|)))))))))) 

(DEFUN |PatternMatchResult;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PatternMatchResult| DV$1 DV$2))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchResult|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|Union| (|AssociationList| (|Symbol|) |#2|) "failed"))
          $))) 

(MAKEPROP '|PatternMatchResult| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|AssociationList| 15 7) (0 . |empty|) |PATRES;new;$;1|
              |PATRES;failed;$;2| (|Boolean|) |PATRES;failed?;$B;3| (|Symbol|)
              (|Pattern| 6) (4 . |retract|)
              (|Record| (|:| |key| 15) (|:| |entry| 7)) (9 . |concat|)
              |PATRES;insertMatch;PS2$;4| (|List| 18) (15 . |construct|)
              |PATRES;construct;L$;5| (20 . |entries|) |PATRES;destruct;$L;6|
              (|Record| (|:| |var| (|List| 15)) (|:| |pred| (|Any|)))
              (25 . |topPredicate|) (|Union| 7 '"failed") (30 . |search|)
              (|List| 7) (|PatternFunctions1| 6 7) (36 . |satisfy?|)
              (|Union| 13 '"failed") |PATRES;satisfy?;$PU;7| (42 . |concat|)
              (48 . |removeDuplicates|) |PATRES;union;3$;8| (53 . =)
              |PATRES;=;2$B;9| (|String|) (|OutputForm|) (59 . |message|)
              (64 . |coerce|) |PATRES;coerce;$Of;10| (69 . |optional?|)
              (74 . =) |PATRES;addMatch;PS2$;12|
              |PATRES;addMatchRestricted;PS$S$;11| (80 . |satisfy?|)
              |PATRES;getMatch;P$U;13| (|SingleInteger|) (|HashState|))
           '#(~= 86 |union| 92 |satisfy?| 98 |new| 104 |latex| 108
              |insertMatch| 113 |hashUpdate!| 120 |hash| 126 |getMatch| 131
              |failed?| 137 |failed| 142 |destruct| 146 |construct| 151
              |coerce| 156 |addMatchRestricted| 161 |addMatch| 169 = 176)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 41))
                        (|makeByteWordVec2| 52
                                            '(0 9 0 10 1 16 15 0 17 2 9 0 18 0
                                              19 1 9 0 21 22 1 9 21 0 24 1 16
                                              26 0 27 2 9 28 15 0 29 2 31 13 30
                                              16 32 2 9 0 0 0 35 1 9 0 0 36 2 9
                                              13 0 0 38 1 41 0 40 42 1 21 41 0
                                              43 1 16 13 0 45 2 7 13 0 0 46 2
                                              31 13 7 16 49 2 0 13 0 0 1 2 0 0
                                              0 0 37 2 0 33 0 16 34 0 0 0 11 1
                                              0 40 0 1 3 0 0 16 7 0 20 2 0 52
                                              52 0 1 1 0 51 0 1 2 0 28 16 0 50
                                              1 0 13 0 14 0 0 0 12 1 0 21 0 25
                                              1 0 0 21 23 1 0 41 0 44 4 0 0 16
                                              7 0 7 48 3 0 0 16 7 0 47 2 0 13 0
                                              0 39)))))
           '|lookupComplete|)) 
