
(PUT '|TREE;empty?;$B;1| '|SPADreplace| '(XLAM (|t|) (QEQCAR |t| 1))) 

(SDEFUN |TREE;empty?;$B;1| ((|t| ($)) ($ (|Boolean|))) (QEQCAR |t| 1)) 

(PUT '|TREE;empty;$;2| '|SPADreplace| '(XLAM NIL (CONS 1 "empty"))) 

(SDEFUN |TREE;empty;$;2| (($ ($))) (CONS 1 "empty")) 

(SDEFUN |TREE;children;$L;3| ((|t| ($)) ($ (|List| $)))
        (COND
         ((QEQCAR |t| 1) (|error| "cannot take the children of an empty tree"))
         ('T (QCDR (CDR |t|))))) 

(SDEFUN |TREE;setchildren!;$L$;4| ((|t| ($)) (|lt| (|List| $)) ($ ($)))
        (SEQ
         (COND
          ((QEQCAR |t| 1) (|error| "cannot set children of an empty tree"))
          ('T (SEQ (PROGN (RPLACD #1=(CDR |t|) |lt|) (QCDR #1#)) (EXIT |t|)))))) 

(SDEFUN |TREE;setvalue!;$2S;5| ((|t| ($)) (|s| (S)) ($ (S)))
        (SEQ
         (COND ((QEQCAR |t| 1) (|error| "cannot set value of an empty tree"))
               ('T
                (SEQ (PROGN (RPLACA #1=(CDR |t|) |s|) (QCAR #1#))
                     (EXIT |s|)))))) 

(SDEFUN |TREE;count;S$Nni;6| ((|n| (S)) (|t| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|i| #1=(|NonNegativeInteger|)) (#2=#:G729 NIL) (#3=#:G728 #1#)
          (#4=#:G730 #1#) (#5=#:G735 NIL) (|c| NIL))
         (SEQ
          (COND ((QEQCAR |t| 1) 0)
                (#6='T
                 (SEQ
                  (LETT |i|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |c| NIL)
                              (LETT #5# (SPADCALL |t| (QREFELT $ 12))) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |c| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4# (SPADCALL |n| |c| (QREFELT $ 16)))
                                 (COND (#2# (LETT #3# (+ #3# #4#)))
                                       ('T
                                        (PROGN
                                         (LETT #3# #4#)
                                         (LETT #2# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#6# 0))))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |t| (QREFELT $ 17)) |n|
                               (QREFELT $ 18))
                     (+ |i| 1))
                    (#6# |i|))))))))) 

(SDEFUN |TREE;count;M$Nni;7|
        ((|fn| (|Mapping| (|Boolean|) S)) (|t| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|i| #1=(|NonNegativeInteger|)) (#2=#:G737 NIL) (#3=#:G736 #1#)
          (#4=#:G738 #1#) (#5=#:G742 NIL) (|c| NIL))
         (SEQ
          (COND ((QEQCAR |t| 1) 0)
                (#6='T
                 (SEQ
                  (LETT |i|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |c| NIL)
                              (LETT #5# (SPADCALL |t| (QREFELT $ 12))) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |c| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4# (SPADCALL |fn| |c| (QREFELT $ 20)))
                                 (COND (#2# (LETT #3# (+ #3# #4#)))
                                       ('T
                                        (PROGN
                                         (LETT #3# #4#)
                                         (LETT #2# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#6# 0))))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |t| (QREFELT $ 17)) |fn|) (+ |i| 1))
                    (#6# |i|))))))))) 

(SDEFUN |TREE;map;M2$;8| ((|fn| (|Mapping| S S)) (|t| ($)) ($ ($)))
        (SPROG ((#1=#:G748 NIL) (|c| NIL) (#2=#:G747 NIL))
               (SEQ
                (COND ((QEQCAR |t| 1) |t|)
                      ('T
                       (SPADCALL (SPADCALL (SPADCALL |t| (QREFELT $ 17)) |fn|)
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |c| NIL)
                                       (LETT #1# (SPADCALL |t| (QREFELT $ 12)))
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |c| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL |fn| |c|
                                                          (QREFELT $ 22))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#))))
                                 (QREFELT $ 23))))))) 

(SDEFUN |TREE;map!;M2$;9| ((|fn| (|Mapping| S S)) (|t| ($)) ($ ($)))
        (SPROG ((#1=#:G754 NIL) (|c| NIL))
               (SEQ
                (COND ((QEQCAR |t| 1) |t|)
                      ('T
                       (SEQ
                        (SPADCALL |t|
                                  (SPADCALL (SPADCALL |t| (QREFELT $ 17)) |fn|)
                                  (QREFELT $ 14))
                        (SEQ (LETT |c| NIL)
                             (LETT #1# (SPADCALL |t| (QREFELT $ 12))) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (SPADCALL |fn| |c| (QREFELT $ 24))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT |t|))))))) 

(SDEFUN |TREE;tree;SL$;10| ((|s| (S)) (|lt| (|List| $)) ($ ($)))
        (CONS 0 (CONS |s| |lt|))) 

(SDEFUN |TREE;tree;S$;11| ((|s| (S)) ($ ($))) (CONS 0 (CONS |s| NIL))) 

(SDEFUN |TREE;tree;L$;12| ((|ls| (|List| S)) ($ ($)))
        (SPROG ((#1=#:G762 NIL) (|s| NIL) (#2=#:G761 NIL))
               (SEQ
                (COND ((NULL |ls|) (SPADCALL (QREFELT $ 10)))
                      ('T
                       (SPADCALL (|SPADfirst| |ls|)
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |s| NIL) (LETT #1# (CDR |ls|))
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |s| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL |s| (QREFELT $ 25))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#))))
                                 (QREFELT $ 23))))))) 

(SDEFUN |TREE;value;$S;13| ((|t| ($)) ($ (S)))
        (COND
         ((QEQCAR |t| 1) (|error| "cannot take the value of an empty tree"))
         ('T (QCAR (CDR |t|))))) 

(SDEFUN |TREE;child?;2$B;14| ((|t1| ($)) (|t2| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |t2| (QREFELT $ 9)) NIL)
              ('T
               (SPADCALL |t1| (SPADCALL |t2| (QREFELT $ 12)) (QREFELT $ 29))))) 

(SDEFUN |TREE;distance1| ((|t1| ($)) (|t2| ($)) ($ #1=(|Integer|)))
        (SPROG
         ((#2=#:G771 NIL) (#3=#:G770 #1#) (#4=#:G772 #1#) (#5=#:G777 NIL)
          (#6=#:G689 NIL) (|u| (|List| #1#)) (|n| #1#) (#7=#:G776 NIL)
          (|t| NIL) (#8=#:G775 NIL))
         (SEQ
          (COND ((SPADCALL |t1| |t2| (QREFELT $ 31)) 0) ((QEQCAR |t2| 1) -1)
                (#9='T
                 (SEQ
                  (LETT |u|
                        (PROGN
                         (LETT #8# NIL)
                         (SEQ (LETT |t| NIL)
                              (LETT #7# (SPADCALL |t2| (QREFELT $ 12))) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |t| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((>= (LETT |n| (|TREE;distance1| |t1| |t| $))
                                      0)
                                  (LETT #8# (CONS |n| #8#))))))
                              (LETT #7# (CDR #7#)) (GO G190) G191
                              (EXIT (NREVERSE #8#)))))
                  (EXIT
                   (COND
                    ((> (LENGTH |u|) 0)
                     (+ 1
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT #6# NIL) (LETT #5# |u|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT #6# (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4# #6#)
                                 (COND (#2# (LETT #3# (MIN #3# #4#)))
                                       ('T
                                        (PROGN
                                         (LETT #3# #4#)
                                         (LETT #2# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#9# (|IdentityError| '|min|))))))
                    (#9# -1))))))))) 

(SDEFUN |TREE;distance;2$I;16| ((|t1| ($)) (|t2| ($)) ($ (|Integer|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (|TREE;distance1| |t1| |t2| $))
                    (EXIT
                     (COND ((>= |n| 0) |n|)
                           ('T (|TREE;distance1| |t2| |t1| $))))))) 

(SDEFUN |TREE;node?;2$B;17| ((|t1| ($)) (|t2| ($)) ($ (|Boolean|)))
        (SPROG NIL
               (COND ((SPADCALL |t1| |t2| (QREFELT $ 31)) 'T)
                     ((QEQCAR |t2| 1) NIL)
                     ('T
                      (SPADCALL (CONS #'|TREE;node?;2$B;17!0| (VECTOR $ |t1|))
                                (SPADCALL |t2| (QREFELT $ 12))
                                (QREFELT $ 36)))))) 

(SDEFUN |TREE;node?;2$B;17!0| ((|t| NIL) ($$ NIL))
        (PROG (|t1| $)
          (LETT |t1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |t1| |t| (QREFELT $ 34)))))) 

(SDEFUN |TREE;any?;M$B;18|
        ((|fn| (|Mapping| #1=(|Boolean|) S)) (|t| ($)) ($ #1#))
        (SPROG ((#2=#:G793 NIL) (#3=#:G794 NIL) (|c| NIL))
               (SEQ
                (EXIT
                 (COND ((QEQCAR |t| 1) NIL)
                       ((SPADCALL (SPADCALL |t| (QREFELT $ 17)) |fn|) 'T)
                       ('T
                        (SEQ
                         (SEQ (LETT |c| NIL)
                              (LETT #3# (SPADCALL |t| (QREFELT $ 12))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |c| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |fn| |c| (QREFELT $ 37))
                                  (PROGN (LETT #2# 'T) (GO #4=#:G792))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                         (EXIT NIL)))))
                #4# (EXIT #2#)))) 

(SDEFUN |TREE;every?;M$B;19|
        ((|fn| (|Mapping| #1=(|Boolean|) S)) (|t| ($)) ($ #1#))
        (SPROG ((#2=#:G802 NIL) (#3=#:G803 NIL) (|c| NIL))
               (SEQ
                (EXIT
                 (COND ((QEQCAR |t| 1) 'T)
                       ((NULL (SPADCALL (SPADCALL |t| (QREFELT $ 17)) |fn|))
                        NIL)
                       ('T
                        (SEQ
                         (SEQ (LETT |c| NIL)
                              (LETT #3# (SPADCALL |t| (QREFELT $ 12))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |c| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((NULL (SPADCALL |fn| |c| (QREFELT $ 38)))
                                  (PROGN (LETT #2# NIL) (GO #4=#:G801))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                         (EXIT 'T)))))
                #4# (EXIT #2#)))) 

(SDEFUN |TREE;member?;S$B;20| ((|n| (S)) (|t| ($)) ($ (|Boolean|)))
        (SPROG NIL
               (COND ((QEQCAR |t| 1) NIL)
                     ((SPADCALL |n| (SPADCALL |t| (QREFELT $ 17))
                                (QREFELT $ 18))
                      'T)
                     ('T
                      (SPADCALL (CONS #'|TREE;member?;S$B;20!0| (VECTOR $ |n|))
                                (SPADCALL |t| (QREFELT $ 12))
                                (QREFELT $ 36)))))) 

(SDEFUN |TREE;member?;S$B;20!0| ((|c| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |c| (QREFELT $ 39)))))) 

(SDEFUN |TREE;parts;$L;21| ((|t| ($)) ($ (|List| S)))
        (SPROG
         ((#1=#:G815 NIL) (#2=#:G814 #3=(|List| S)) (#4=#:G816 #3#)
          (#5=#:G821 NIL) (#6=#:G690 NIL) (|u| (|List| #3#)) (#7=#:G820 NIL)
          (|c| NIL) (#8=#:G819 NIL))
         (SEQ
          (COND ((QEQCAR |t| 1) NIL)
                (#9='T
                 (SEQ
                  (LETT |u|
                        (PROGN
                         (LETT #8# NIL)
                         (SEQ (LETT |c| NIL)
                              (LETT #7# (SPADCALL |t| (QREFELT $ 12))) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |c| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #8#
                                      (CONS (SPADCALL |c| (QREFELT $ 40))
                                            #8#))))
                              (LETT #7# (CDR #7#)) (GO G190) G191
                              (EXIT (NREVERSE #8#)))))
                  (EXIT
                   (COND
                    ((SPADCALL |u| NIL (QREFELT $ 42))
                     (LIST (SPADCALL |t| (QREFELT $ 17))))
                    (#9#
                     (CONS (SPADCALL |t| (QREFELT $ 17))
                           (PROGN
                            (LETT #1# NIL)
                            (SEQ (LETT #6# NIL) (LETT #5# |u|) G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT #6# (CAR #5#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (PROGN
                                    (LETT #4# #6#)
                                    (COND
                                     (#1#
                                      (LETT #2#
                                            (SPADCALL #2# #4# (QREFELT $ 43))))
                                     ('T
                                      (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                                 (LETT #5# (CDR #5#)) (GO G190) G191
                                 (EXIT NIL))
                            (COND (#1# #2#) (#9# NIL))))))))))))) 

(SDEFUN |TREE;hashUpdate!;Hs$Hs;22|
        ((|s| (|HashState|)) (|t| ($)) ($ (|HashState|)))
        (SPROG ((#1=#:G828 NIL) (|subt| NIL))
               (SEQ
                (COND ((QEQCAR |t| 1) |s|)
                      ('T
                       (SEQ
                        (LETT |s|
                              (SPADCALL |s| (SPADCALL |t| (QREFELT $ 17))
                                        (QREFELT $ 45)))
                        (SEQ (LETT |subt| NIL)
                             (LETT #1# (SPADCALL |t| (QREFELT $ 12))) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |subt| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |s|
                                     (SPADCALL |s| |subt| (QREFELT $ 46)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT |s|))))))) 

(SDEFUN |TREE;=;2$B;23| ((|t1| ($)) (|t2| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |t1| (QREFELT $ 9)) (SPADCALL |t2| (QREFELT $ 9)))
              ((SPADCALL (SPADCALL |t1| (QREFELT $ 17))
                         (SPADCALL |t2| (QREFELT $ 17)) (QREFELT $ 18))
               (SPADCALL (SPADCALL |t1| (QREFELT $ 12))
                         (SPADCALL |t2| (QREFELT $ 12)) (QREFELT $ 47)))
              ('T NIL))) 

(SDEFUN |TREE;#;$Nni;24| ((|t| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G837 NIL) (#2=#:G836 #3=(|NonNegativeInteger|)) (#4=#:G838 #3#)
          (#5=#:G841 NIL) (|c| NIL))
         (SEQ
          (COND ((SPADCALL |t| (QREFELT $ 9)) 0)
                (#6='T
                 (+ 1
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |c| NIL)
                          (LETT #5# (SPADCALL |t| (QREFELT $ 12))) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4# (SPADCALL |c| (QREFELT $ 48)))
                             (COND (#1# (LETT #2# (+ #2# #4#)))
                                   ('T
                                    (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) (#6# 0))))))))) 

(SDEFUN |TREE;copy;2$;25| ((|t| ($)) ($ ($)))
        (SPROG ((#1=#:G847 NIL) (|c| NIL) (#2=#:G846 NIL))
               (SEQ
                (COND ((SPADCALL |t| (QREFELT $ 9)) (SPADCALL (QREFELT $ 10)))
                      ('T
                       (SPADCALL (SPADCALL |t| (QREFELT $ 17))
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |c| NIL)
                                       (LETT #1# (SPADCALL |t| (QREFELT $ 12)))
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |c| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL |c| (QREFELT $ 49))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#))))
                                 (QREFELT $ 23))))))) 

(SDEFUN |TREE;coerce;$Of;26| ((|t| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G856 NIL) (|c| NIL) (#2=#:G855 NIL)
          (|nodeForm| (|OutputForm|)))
         (SEQ
          (COND ((SPADCALL |t| (QREFELT $ 9)) (SPADCALL NIL (QREFELT $ 51)))
                (#3='T
                 (SEQ
                  (LETT |nodeForm|
                        (SPADCALL (SPADCALL |t| (QREFELT $ 17))
                                  (QREFELT $ 52)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |t| (QREFELT $ 12)) (QREFELT $ 53))
                     |nodeForm|)
                    (#3#
                     (SPADCALL |nodeForm|
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |c| NIL)
                                     (LETT #1# (SPADCALL |t| (QREFELT $ 12)))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |c| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2#
                                             (CONS
                                              (SPADCALL |c| (QREFELT $ 54))
                                              #2#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #2#))))
                               (QREFELT $ 55))))))))))) 

(DECLAIM (NOTINLINE |Tree;|)) 

(DEFUN |Tree| (#1=#:G863)
  (SPROG NIL
         (PROG (#2=#:G864)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Tree|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Tree;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Tree|)))))))))) 

(DEFUN |Tree;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G860 NIL) (#2=#:G861 NIL) (#3=#:G862 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Tree| DV$1))
    (LETT $ (GETREFV 62))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #3#)
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|BasicType|)))
                                        (OR #2# #3#)
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #1#
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #3#))))))
    (|haddProp| |$ConstructorCache| '|Tree| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 128))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 256))
    (AND #2# (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 512))
    (AND (OR (AND #2# (|HasCategory| $ '(|finiteAggregate|))) #3#)
         (|augmentPredVector| $ 1024))
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 2048))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7
              (|Union|
               (|:| |node|
                    (|Record| (|:| |value| |#1|) (|:| |args| (|List| $))))
               (|:| |empty| "empty")))
    $))) 

(MAKEPROP '|Tree| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|)
              |TREE;empty?;$B;1| |TREE;empty;$;2| (|List| $)
              |TREE;children;$L;3| |TREE;setchildren!;$L$;4|
              |TREE;setvalue!;$2S;5| (|NonNegativeInteger|)
              |TREE;count;S$Nni;6| |TREE;value;$S;13| (0 . =) (|Mapping| 8 6)
              |TREE;count;M$Nni;7| (|Mapping| 6 6) |TREE;map;M2$;8|
              |TREE;tree;SL$;10| |TREE;map!;M2$;9| |TREE;tree;S$;11| (|List| 6)
              |TREE;tree;L$;12| (|List| $$) (6 . |member?|)
              |TREE;child?;2$B;14| |TREE;=;2$B;23| (|Integer|)
              |TREE;distance;2$I;16| |TREE;node?;2$B;17| (|Mapping| 8 $$)
              (12 . |any?|) |TREE;any?;M$B;18| |TREE;every?;M$B;19|
              |TREE;member?;S$B;20| |TREE;parts;$L;21| (|List| 26) (18 . =)
              (24 . |append|) (|HashState|) (30 . |hashUpdate!|)
              |TREE;hashUpdate!;Hs$Hs;22| (36 . =) |TREE;#;$Nni;24|
              |TREE;copy;2$;25| (|OutputForm|) (42 . |coerce|) (47 . |coerce|)
              (52 . |empty?|) |TREE;coerce;$Of;26| (57 . |prefix|) (|List| 57)
              (|Equation| 6) (|Mapping| 8 6 6) '"value" (|SingleInteger|)
              (|String|))
           '#(~= 63 |value| 69 |tree| 74 |size?| 90 |setvalue!| 96 |setelt!|
              102 |setchildren!| 109 |sample| 115 |parts| 119 |nodes| 124
              |node?| 129 |more?| 135 |min| 141 |members| 146 |member?| 151
              |max| 157 |map!| 168 |map| 174 |less?| 180 |leaves| 186 |leaf?|
              191 |latex| 196 |hashUpdate!| 201 |hash| 207 |every?| 212 |eval|
              218 |eq?| 244 |empty?| 250 |empty| 255 |elt| 259 |distance| 265
              |cyclic?| 271 |count| 276 |copy| 288 |coerce| 293 |children| 298
              |child?| 303 |any?| 309 = 315 |#| 321)
           'NIL
           (CONS (|makeByteWordVec2| 7 '(0 0 0 2 1 0 0 0 2 5 7))
                 (CONS
                  '#(|RecursiveAggregate&| |HomogeneousAggregate&| |Aggregate&|
                     |Evalable&| |SetCategory&| NIL NIL NIL |InnerEvalable&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|RecursiveAggregate| 6) (|HomogeneousAggregate| 6)
                      (|Aggregate|) (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|shallowlyMutable|) (|finiteAggregate|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 50))
                   (|makeByteWordVec2| 61
                                       '(2 6 8 0 0 18 2 28 8 2 0 29 2 28 8 35 0
                                         36 2 41 8 0 0 42 2 26 0 0 0 43 2 6 44
                                         44 0 45 2 28 8 0 0 47 1 26 50 0 51 1 6
                                         50 0 52 1 28 8 0 53 2 50 0 0 11 55 2
                                         11 8 0 0 1 1 0 6 0 17 1 0 0 26 27 1 0
                                         0 6 25 2 0 0 6 11 23 2 0 8 0 15 1 2 12
                                         6 0 6 14 3 12 6 0 59 6 1 2 12 0 0 11
                                         13 0 0 0 1 1 8 26 0 40 1 0 11 0 1 2 4
                                         8 0 0 34 2 0 8 0 15 1 1 9 6 0 1 1 8 26
                                         0 1 2 10 8 6 0 39 1 9 6 0 1 2 8 6 58 0
                                         1 2 12 0 21 0 24 2 0 0 21 0 22 2 0 8 0
                                         15 1 1 0 26 0 1 1 0 8 0 1 1 1 61 0 1 2
                                         1 44 44 0 46 1 1 60 0 1 2 8 8 19 0 38
                                         3 2 0 0 26 26 1 3 2 0 0 6 6 1 2 2 0 0
                                         56 1 2 2 0 0 57 1 2 0 8 0 0 1 1 0 8 0
                                         9 0 0 0 10 2 0 6 0 59 1 2 0 32 0 0 33
                                         1 0 8 0 1 2 10 15 6 0 16 2 8 15 19 0
                                         20 1 0 0 0 49 1 6 50 0 54 1 0 11 0 12
                                         2 4 8 0 0 30 2 8 8 19 0 37 2 11 8 0 0
                                         31 1 8 15 0 48)))))
           '|lookupComplete|)) 
