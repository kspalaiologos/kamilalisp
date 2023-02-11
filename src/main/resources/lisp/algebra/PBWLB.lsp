
(PUT '|PBWLB;One;$;1| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |PBWLB;One;$;1| (($ ($))) NIL) 

(SDEFUN |PBWLB;=;2$B;2| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 10))) 

(SDEFUN |PBWLB;varList;$L;3| ((|x| ($)) ($ (|List| |VarSet|)))
        (SPROG
         ((|le| #1=(|List| |VarSet|)) (#2=#:G708 NIL) (#3=#:G707 #1#)
          (#4=#:G709 #1#) (#5=#:G712 NIL) (|l| NIL))
         (SEQ
          (COND ((NULL |x|) NIL)
                (#6='T
                 (LETT |le|
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |l| NIL) (LETT #5# |x|) G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |l| (CAR #5#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (PROGN
                                (LETT #4# (SPADCALL |l| (QREFELT $ 14)))
                                (COND
                                 (#2#
                                  (LETT #3# (SPADCALL #3# #4# (QREFELT $ 15))))
                                 ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                             (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                        (COND (#2# #3#)
                              (#6# (|IdentityError| '|setUnion|)))))))))) 

(PUT '|PBWLB;first;$Lw;4| '|SPADreplace| '|SPADfirst|) 

(SDEFUN |PBWLB;first;$Lw;4| ((|x| ($)) ($ (|LyndonWord| |VarSet|)))
        (|SPADfirst| |x|)) 

(PUT '|PBWLB;rest;2$;5| '|SPADreplace| 'CDR) 

(SDEFUN |PBWLB;rest;2$;5| ((|x| ($)) ($ ($))) (CDR |x|)) 

(SDEFUN |PBWLB;coerce;VarSet$;6| ((|v| (|VarSet|)) ($ ($)))
        (LIST (SPADCALL |v| (QREFELT $ 19)))) 

(PUT '|PBWLB;coerce;Lw$;7| '|SPADreplace| 'LIST) 

(SDEFUN |PBWLB;coerce;Lw$;7| ((|l| (|LyndonWord| |VarSet|)) ($ ($))) (LIST |l|)) 

(PUT '|PBWLB;listOfTerms;$L;8| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |PBWLB;listOfTerms;$L;8|
        ((|x| ($)) ($ (|List| (|LyndonWord| |VarSet|)))) |x|) 

(SDEFUN |PBWLB;coerce;$Fm;9| ((|x| ($)) ($ (|FreeMonoid| |VarSet|)))
        (COND ((NULL |x|) (|spadConstant| $ 25))
              ('T
               (SPADCALL (SPADCALL (|SPADfirst| |x|) (QREFELT $ 26))
                         (SPADCALL (CDR |x|) (QREFELT $ 27)) (QREFELT $ 28))))) 

(SDEFUN |PBWLB;coerce;$Of;10| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G727 NIL) (|l| NIL) (#2=#:G726 NIL))
               (SEQ
                (COND ((NULL |x|) (SPADCALL 1 (QREFELT $ 31)))
                      ('T
                       (SPADCALL (ELT $ 32)
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |l| NIL) (LETT #1# |x|) G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |l| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL |l| (QREFELT $ 33))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#))))
                                 (QREFELT $ 36))))))) 

(SDEFUN |PBWLB;retractable?;$B;11| ((|x| ($)) ($ (|Boolean|)))
        (COND ((NULL |x|) NIL) ('T (NULL (CDR |x|))))) 

(SDEFUN |PBWLB;retract;$Lw;12| ((|x| ($)) ($ (|LyndonWord| |VarSet|)))
        (COND
         ((SPADCALL (LENGTH |x|) 1 (QREFELT $ 40))
          (|error| "cannot convert to Lyndon word"))
         ('T (|SPADfirst| |x|)))) 

(SDEFUN |PBWLB;retractIfCan;$U;13|
        ((|x| ($)) ($ (|Union| (|LyndonWord| |VarSet|) "failed")))
        (COND ((SPADCALL |x| (QREFELT $ 38)) (CONS 0 (|SPADfirst| |x|)))
              ('T (CONS 1 "failed")))) 

(SDEFUN |PBWLB;length;$Nni;14| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G744 NIL) (|n| #2=(|Integer|)) (#3=#:G742 NIL) (#4=#:G741 #2#)
          (#5=#:G743 #2#) (#6=#:G747 NIL) (|l| NIL))
         (SEQ
          (LETT |n|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |l| NIL) (LETT #6# |x|) G190
                      (COND
                       ((OR (ATOM #6#) (PROGN (LETT |l| (CAR #6#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #5# (SPADCALL |l| (QREFELT $ 45)))
                         (COND (#3# (LETT #4# (+ #4# #5#)))
                               ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                      (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                 (COND (#3# #4#) ('T 0))))
          (EXIT
           (PROG1 (LETT #1# |n|)
             (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|) '(|Integer|)
                               #1#)))))) 

(SDEFUN |PBWLB;recursif| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((NULL |y|) NIL) ((NULL |x|) 'T)
              ((SPADCALL (|SPADfirst| |x|) (|SPADfirst| |y|) (QREFELT $ 47))
               (|PBWLB;recursif| (SPADCALL |x| (QREFELT $ 18))
                (SPADCALL |y| (QREFELT $ 18)) $))
              ('T
               (SPADCALL (|SPADfirst| |x|) (|SPADfirst| |y|) (QREFELT $ 48))))) 

(SDEFUN |PBWLB;<;2$B;16| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|ly| #1=(|NonNegativeInteger|)) (|lx| #1#))
               (SEQ (LETT |lx| (SPADCALL |x| (QREFELT $ 46)))
                    (LETT |ly| (SPADCALL |y| (QREFELT $ 46)))
                    (EXIT
                     (COND ((EQL |lx| |ly|) (|PBWLB;recursif| |x| |y| $))
                           ('T (< |lx| |ly|))))))) 

(DECLAIM (NOTINLINE |PoincareBirkhoffWittLyndonBasis;|)) 

(DEFUN |PoincareBirkhoffWittLyndonBasis| (#1=#:G756)
  (SPROG NIL
         (PROG (#2=#:G757)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PoincareBirkhoffWittLyndonBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|PoincareBirkhoffWittLyndonBasis;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PoincareBirkhoffWittLyndonBasis|)))))))))) 

(DEFUN |PoincareBirkhoffWittLyndonBasis;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PoincareBirkhoffWittLyndonBasis| DV$1))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PoincareBirkhoffWittLyndonBasis|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|List| (|LyndonWord| |#1|)))
          $))) 

(MAKEPROP '|PoincareBirkhoffWittLyndonBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |PBWLB;One;$;1|) $))
              (|Boolean|) (0 . =) |PBWLB;=;2$B;2| (|List| 6) (|LyndonWord| 6)
              (6 . |varList|) (11 . |setUnion|) |PBWLB;varList;$L;3|
              |PBWLB;first;$Lw;4| |PBWLB;rest;2$;5| (17 . |coerce|)
              |PBWLB;coerce;VarSet$;6| |PBWLB;coerce;Lw$;7| (|List| 13)
              |PBWLB;listOfTerms;$L;8| (|FreeMonoid| 6) (22 . |One|)
              (26 . |coerce|) |PBWLB;coerce;$Fm;9| (31 . *) (|Integer|)
              (|OutputForm|) (37 . |outputForm|) (42 . *) (48 . |coerce|)
              (|Mapping| 30 30 30) (|List| 30) (53 . |reduce|)
              |PBWLB;coerce;$Of;10| |PBWLB;retractable?;$B;11|
              (|NonNegativeInteger|) (59 . ~=) |PBWLB;retract;$Lw;12|
              (|Union| 13 '"failed") |PBWLB;retractIfCan;$U;13|
              (|PositiveInteger|) (65 . |length|) |PBWLB;length;$Nni;14|
              (70 . =) (76 . |lexico|) |PBWLB;<;2$B;16| (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 82 |varList| 88 |smaller?| 93 |retractable?| 99 |retractIfCan|
              104 |retract| 109 |rest| 114 |min| 119 |max| 125 |listOfTerms|
              131 |length| 136 |latex| 141 |hashUpdate!| 146 |hash| 152 |first|
              157 |coerce| 162 |One| 182 >= 186 > 192 = 198 <= 204 < 210)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |RetractableTo&|
                     |BasicType&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|RetractableTo| (|LyndonWord| 6)) (|BasicType|)
                      (|CoercibleFrom| (|LyndonWord| 6)) (|PartialOrder|)
                      (|CoercibleTo| 30))
                   (|makeByteWordVec2| 52
                                       '(2 7 9 0 0 10 1 13 12 0 14 2 12 0 0 0
                                         15 1 13 0 6 19 0 24 0 25 1 13 24 0 26
                                         2 24 0 0 0 28 1 30 0 29 31 2 30 0 0 0
                                         32 1 13 30 0 33 2 35 30 34 0 36 2 39 9
                                         0 0 40 1 13 44 0 45 2 13 9 0 0 47 2 13
                                         9 0 0 48 2 0 9 0 0 1 1 0 12 0 16 2 0 9
                                         0 0 1 1 0 9 0 38 1 0 42 0 43 1 0 13 0
                                         41 1 0 0 0 18 2 0 0 0 0 1 2 0 0 0 0 1
                                         1 0 22 0 23 1 0 39 0 46 1 0 51 0 1 2 0
                                         50 50 0 1 1 0 52 0 1 1 0 13 0 17 1 0 0
                                         6 20 1 0 24 0 27 1 0 0 13 21 1 0 30 0
                                         37 0 0 0 8 2 0 9 0 0 1 2 0 9 0 0 1 2 0
                                         9 0 0 11 2 0 9 0 0 1 2 0 9 0 0 49)))))
           '|lookupComplete|)) 
