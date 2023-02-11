
(SDEFUN |FMAGMA;=;2$B;1| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |x| 0)
          (COND
           ((QEQCAR |y| 0) (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 10)))
           (#1='T NIL)))
         ((QEQCAR |y| 1) (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 11)))
         (#1# NIL))) 

(SDEFUN |FMAGMA;varList;$L;2| ((|x| ($)) ($ (|List| |VarSet|)))
        (SPROG ((|lv| (|List| |VarSet|)))
               (SEQ
                (COND ((QEQCAR |x| 0) (LIST (QCDR |x|)))
                      ('T
                       (SEQ
                        (LETT |lv|
                              (SPADCALL
                               (SPADCALL (QCAR (QCDR |x|)) (QREFELT $ 14))
                               (SPADCALL (QCDR (QCDR |x|)) (QREFELT $ 14))
                               (QREFELT $ 15)))
                        (EXIT (SPADCALL |lv| (QREFELT $ 16))))))))) 

(SDEFUN |FMAGMA;left;2$;3| ((|x| ($)) ($ ($)))
        (COND ((QEQCAR |x| 0) (|error| "x has only one entry"))
              ('T (QCAR (QCDR |x|))))) 

(SDEFUN |FMAGMA;right;2$;4| ((|x| ($)) ($ ($)))
        (COND ((QEQCAR |x| 0) (|error| "x has only one entry"))
              ('T (QCDR (QCDR |x|))))) 

(PUT '|FMAGMA;retractable?;$B;5| '|SPADreplace| '(XLAM (|x|) (QEQCAR |x| 0))) 

(SDEFUN |FMAGMA;retractable?;$B;5| ((|x| ($)) ($ (|Boolean|))) (QEQCAR |x| 0)) 

(SDEFUN |FMAGMA;retract;$VarSet;6| ((|x| ($)) ($ (|VarSet|)))
        (COND ((QEQCAR |x| 0) (QCDR |x|)) ('T (|error| "Not retractable")))) 

(SDEFUN |FMAGMA;retractIfCan;$U;7| ((|x| ($)) ($ (|Union| |VarSet| "failed")))
        (COND ((SPADCALL |x| (QREFELT $ 19)) (CONS 0 (QCDR |x|)))
              ('T (CONS 1 "failed")))) 

(PUT '|FMAGMA;coerce;VarSet$;8| '|SPADreplace| '(XLAM (|l|) (CONS 0 |l|))) 

(SDEFUN |FMAGMA;coerce;VarSet$;8| ((|l| (|VarSet|)) ($ ($))) (CONS 0 |l|)) 

(SDEFUN |FMAGMA;mirror;2$;9| ((|x| ($)) ($ ($)))
        (COND ((QEQCAR |x| 0) |x|)
              ('T
               (CONS 1
                     (CONS (SPADCALL (QCDR (QCDR |x|)) (QREFELT $ 24))
                           (SPADCALL (QCAR (QCDR |x|)) (QREFELT $ 24))))))) 

(SDEFUN |FMAGMA;coerce;$Fm;10| ((|x| ($)) ($ (|FreeMonoid| |VarSet|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 26)))
              ('T
               (SPADCALL (SPADCALL (QCAR (QCDR |x|)) (QREFELT $ 27))
                         (SPADCALL (QCDR (QCDR |x|)) (QREFELT $ 27))
                         (QREFELT $ 28))))) 

(SDEFUN |FMAGMA;coerce;$Of;11| ((|x| ($)) ($ (|OutputForm|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 30)))
              ('T
               (SPADCALL
                (LIST (SPADCALL (QCAR (QCDR |x|)) (QREFELT $ 31))
                      (SPADCALL (QCDR (QCDR |x|)) (QREFELT $ 31)))
                (QREFELT $ 33))))) 

(SDEFUN |FMAGMA;*;3$;12| ((|x| ($)) (|y| ($)) ($ ($))) (CONS 1 (CONS |x| |y|))) 

(SDEFUN |FMAGMA;first;$VarSet;13| ((|x| ($)) ($ (|VarSet|)))
        (COND ((QEQCAR |x| 0) (QCDR |x|))
              ('T (SPADCALL (QCAR (QCDR |x|)) (QREFELT $ 35))))) 

(SDEFUN |FMAGMA;rest;2$;14| ((|x| ($)) ($ ($)))
        (SPROG ((|lx| ($)))
               (SEQ
                (COND
                 ((QEQCAR |x| 0) (|error| "rest$FreeMagma: inexistant rest"))
                 (#1='T
                  (SEQ (LETT |lx| (QCAR (QCDR |x|)))
                       (EXIT
                        (COND ((QEQCAR |lx| 0) (QCDR (QCDR |x|)))
                              (#1#
                               (CONS 1
                                     (CONS (SPADCALL |lx| (QREFELT $ 36))
                                           (QCDR (QCDR |x|))))))))))))) 

(SDEFUN |FMAGMA;length;$Pi;15| ((|x| ($)) ($ (|PositiveInteger|)))
        (COND ((QEQCAR |x| 0) 1)
              ('T
               (+ (SPADCALL (QCAR (QCDR |x|)) (QREFELT $ 38))
                  (SPADCALL (QCDR (QCDR |x|)) (QREFELT $ 38)))))) 

(SDEFUN |FMAGMA;recursif| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |x| 0)
          (COND
           ((QEQCAR |y| 0) (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 39)))
           (#1='T 'T)))
         ((QEQCAR |y| 0) NIL)
         (#1#
          (COND
           ((SPADCALL (QCAR (QCDR |x|)) (QCAR (QCDR |y|)) (QREFELT $ 12))
            (SPADCALL (QCDR (QCDR |x|)) (QCDR (QCDR |y|)) (QREFELT $ 40)))
           (#1#
            (SPADCALL (QCAR (QCDR |x|)) (QCAR (QCDR |y|)) (QREFELT $ 40))))))) 

(SDEFUN |FMAGMA;lexico;2$B;17| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|fy| (|VarSet|)) (|fx| (|VarSet|)))
               (SEQ
                (COND
                 ((QEQCAR |x| 0)
                  (COND
                   ((QEQCAR |y| 0)
                    (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 39)))
                   (#1='T
                    (SPADCALL (QCDR |x|) (SPADCALL |y| (QREFELT $ 35))
                              (QREFELT $ 41)))))
                 ((QEQCAR |y| 0)
                  (SPADCALL (CONS 0 (SPADCALL |x| (QREFELT $ 35)))
                            (CONS 0 (SPADCALL |y| (QREFELT $ 20)))
                            (QREFELT $ 40)))
                 (#1#
                  (SEQ (LETT |fx| (SPADCALL |x| (QREFELT $ 35)))
                       (LETT |fy| (SPADCALL |y| (QREFELT $ 35)))
                       (EXIT
                        (COND
                         ((SPADCALL |fx| |fy| (QREFELT $ 10))
                          (SPADCALL (SPADCALL |x| (QREFELT $ 36))
                                    (SPADCALL |y| (QREFELT $ 36))
                                    (QREFELT $ 42)))
                         (#1# (SPADCALL |fx| |fy| (QREFELT $ 39))))))))))) 

(SDEFUN |FMAGMA;<;2$B;18| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|ly| #1=(|PositiveInteger|)) (|lx| #1#))
               (SEQ (LETT |lx| (SPADCALL |x| (QREFELT $ 38)))
                    (LETT |ly| (SPADCALL |y| (QREFELT $ 38)))
                    (EXIT
                     (COND ((EQL |lx| |ly|) (|FMAGMA;recursif| |x| |y| $))
                           ('T (< |lx| |ly|))))))) 

(DECLAIM (NOTINLINE |FreeMagma;|)) 

(DEFUN |FreeMagma| (#1=#:G740)
  (SPROG NIL
         (PROG (#2=#:G741)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FreeMagma|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FreeMagma;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FreeMagma|)))))))))) 

(DEFUN |FreeMagma;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FreeMagma| DV$1))
          (LETT $ (GETREFV 46))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FreeMagma| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Record| (|:| |left| $) (|:| |right| $)))
          (QSETREFV $ 8 (|Union| |#1| (QREFELT $ 7)))
          $))) 

(MAKEPROP '|FreeMagma| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'VWORD '|Rep| (|Boolean|)
              (0 . =) (6 . =) |FMAGMA;=;2$B;1| (|List| 6) |FMAGMA;varList;$L;2|
              (12 . |setUnion|) (18 . |sort!|) |FMAGMA;left;2$;3|
              |FMAGMA;right;2$;4| |FMAGMA;retractable?;$B;5|
              |FMAGMA;retract;$VarSet;6| (|Union| 6 '"failed")
              |FMAGMA;retractIfCan;$U;7| |FMAGMA;coerce;VarSet$;8|
              |FMAGMA;mirror;2$;9| (|FreeMonoid| 6) (23 . |coerce|)
              |FMAGMA;coerce;$Fm;10| (28 . *) (|OutputForm|) (34 . |coerce|)
              |FMAGMA;coerce;$Of;11| (|List| $) (39 . |bracket|)
              |FMAGMA;*;3$;12| |FMAGMA;first;$VarSet;13| |FMAGMA;rest;2$;14|
              (|PositiveInteger|) |FMAGMA;length;$Pi;15| (44 . <)
              |FMAGMA;<;2$B;18| (50 . <=) |FMAGMA;lexico;2$B;17| (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 56 |varList| 62 |smaller?| 67 |right| 73 |retractable?| 78
              |retractIfCan| 83 |retract| 88 |rest| 93 |mirror| 98 |min| 103
              |max| 109 |lexico| 115 |length| 121 |left| 126 |latex| 131
              |hashUpdate!| 136 |hash| 142 |first| 147 |coerce| 152 >= 167 >
              173 = 179 <= 185 < 191 * 197)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |RetractableTo&|
                     |BasicType&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|RetractableTo| 6) (|BasicType|) (|CoercibleFrom| 6)
                      (|PartialOrder|) (|CoercibleTo| 29))
                   (|makeByteWordVec2| 45
                                       '(2 6 9 0 0 10 2 7 9 0 0 11 2 13 0 0 0
                                         15 1 13 0 0 16 1 25 0 6 26 2 25 0 0 0
                                         28 1 6 29 0 30 1 29 0 32 33 2 6 9 0 0
                                         39 2 6 9 0 0 41 2 0 9 0 0 1 1 0 13 0
                                         14 2 0 9 0 0 1 1 0 0 0 18 1 0 9 0 19 1
                                         0 21 0 22 1 0 6 0 20 1 0 0 0 36 1 0 0
                                         0 24 2 0 0 0 0 1 2 0 0 0 0 1 2 0 9 0 0
                                         42 1 0 37 0 38 1 0 0 0 17 1 0 44 0 1 2
                                         0 43 43 0 1 1 0 45 0 1 1 0 6 0 35 1 0
                                         25 0 27 1 0 0 6 23 1 0 29 0 31 2 0 9 0
                                         0 1 2 0 9 0 0 1 2 0 9 0 0 12 2 0 9 0 0
                                         1 2 0 9 0 0 40 2 0 0 0 0 34)))))
           '|lookupComplete|)) 
