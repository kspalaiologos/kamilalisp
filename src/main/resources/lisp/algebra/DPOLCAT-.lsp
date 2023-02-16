
(SDEFUN |DPOLCAT-;makeVariable;SM;1|
        ((|s| (S)) ($ (|Mapping| A (|NonNegativeInteger|))))
        (SPROG NIL (CONS #'|DPOLCAT-;makeVariable;SM;1!0| (VECTOR $ |s|)))) 

(SDEFUN |DPOLCAT-;makeVariable;SM;1!0| ((|n| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |s| |n| (QREFELT $ 12)) (QREFELT $ 13)))))) 

(SDEFUN |DPOLCAT-;differentiate;AMA;2|
        ((|p| (A)) (|d| (|Mapping| R R)) ($ (A)))
        (SPROG
         ((#1=#:G732 NIL) (|ans| (A)) (#2=#:G739 NIL) (#3=#:G738 (A))
          (#4=#:G740 (A)) (#5=#:G746 NIL) (|v| NIL) (#6=#:G736 NIL) (|lc| (R))
          (|t| (A)) (|u| (|Union| R "failed")) (|l| (|List| V)))
         (SEQ (LETT |ans| (|spadConstant| $ 16))
              (LETT |l| (SPADCALL |p| (QREFELT $ 18)))
              (SEQ G190
                   (COND
                    ((NULL (QEQCAR (LETT |u| (SPADCALL |p| (QREFELT $ 20))) 1))
                     (GO G191)))
                   (SEQ (LETT |t| (SPADCALL |p| (QREFELT $ 21)))
                        (LETT |lc| (SPADCALL |t| (QREFELT $ 22)))
                        (LETT |ans|
                              (SPADCALL
                               (SPADCALL |ans|
                                         (SPADCALL
                                          (SPADCALL (SPADCALL |lc| |d|)
                                                    (QREFELT $ 23))
                                          (PROG2
                                              (LETT #6#
                                                    (SPADCALL |t| |lc|
                                                              (QREFELT $ 25)))
                                              (QCDR #6#)
                                            (|check_union2| (QEQCAR #6# 0)
                                                            (QREFELT $ 6)
                                                            (|Union|
                                                             (QREFELT $ 6)
                                                             "failed")
                                                            #6#))
                                          (QREFELT $ 26))
                                         (QREFELT $ 27))
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |v| NIL) (LETT #5# |l|) G190
                                     (COND
                                      ((OR (ATOM #5#)
                                           (PROGN (LETT |v| (CAR #5#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #4#
                                              (SPADCALL
                                               (SPADCALL |t| |v|
                                                         (QREFELT $ 28))
                                               (SPADCALL
                                                (SPADCALL |v| (QREFELT $ 29))
                                                (QREFELT $ 13))
                                               (QREFELT $ 26)))
                                        (COND
                                         (#2#
                                          (LETT #3#
                                                (SPADCALL #3# #4#
                                                          (QREFELT $ 27))))
                                         ('T
                                          (PROGN
                                           (LETT #3# #4#)
                                           (LETT #2# 'T)))))))
                                     (LETT #5# (CDR #5#)) (GO G190) G191
                                     (EXIT NIL))
                                (COND (#2# #3#) ('T (|spadConstant| $ 16))))
                               (QREFELT $ 27)))
                        (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 30)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |ans|
                         (SPADCALL
                          (SPADCALL
                           (PROG2 (LETT #1# |u|)
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                             (|Union| (QREFELT $ 7) "failed")
                                             #1#))
                           |d|)
                          (QREFELT $ 23))
                         (QREFELT $ 27)))))) 

(SDEFUN |DPOLCAT-;order;ANni;3| ((|p| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G748 NIL) (#2=#:G747 #3=(|NonNegativeInteger|)) (#4=#:G749 #3#)
          (#5=#:G752 NIL) (|v| NIL))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 34)) 0)
                (#6='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |v| NIL) (LETT #5# (SPADCALL |p| (QREFELT $ 18)))
                       G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |v| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# (SPADCALL |v| (QREFELT $ 35)))
                          (COND (#1# (LETT #2# (MAX #2# #4#)))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#6# (|IdentityError| '|max|))))))))) 

(SDEFUN |DPOLCAT-;order;ASNni;4|
        ((|p| (A)) (|s| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G756 NIL) (#2=#:G755 #3=(|NonNegativeInteger|)) (#4=#:G757 #3#)
          (#5=#:G763 NIL) (#6=#:G689 NIL) (|vv| (|List| #3#)) (#7=#:G762 NIL)
          (|v| NIL) (#8=#:G761 NIL))
         (SEQ
          (COND
           ((OR (SPADCALL |p| (QREFELT $ 34))
                (NULL
                 (LETT |vv|
                       (PROGN
                        (LETT #8# NIL)
                        (SEQ (LETT |v| NIL)
                             (LETT #7# (SPADCALL |p| (QREFELT $ 18))) G190
                             (COND
                              ((OR (ATOM #7#) (PROGN (LETT |v| (CAR #7#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |v| (QREFELT $ 37)) |s|
                                           (QREFELT $ 38))
                                 (LETT #8#
                                       (CONS (SPADCALL |v| (QREFELT $ 35))
                                             #8#))))))
                             (LETT #7# (CDR #7#)) (GO G190) G191
                             (EXIT (NREVERSE #8#)))))))
            0)
           ('T
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT #6# NIL) (LETT #5# |vv|) G190
                  (COND
                   ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4# #6#)
                     (COND (#1# (LETT #2# (MAX #2# #4#)))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                  (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) ('T (|IdentityError| '|max|))))))))) 

(SDEFUN |DPOLCAT-;degree;ASNni;5|
        ((|p| (A)) (|s| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|d| (|NonNegativeInteger|)) (#1=#:G768 NIL)
          (#2=#:G767 #3=(|NonNegativeInteger|)) (#4=#:G769 #3#) (#5=#:G777 NIL)
          (#6=#:G690 NIL) (|lv| (|List| V)) (#7=#:G776 NIL) (|v| NIL)
          (#8=#:G775 NIL) (#9=#:G774 NIL) (|lp| NIL))
         (SEQ (LETT |d| 0)
              (SEQ (LETT |lp| NIL) (LETT #9# (SPADCALL |p| (QREFELT $ 41)))
                   G190
                   (COND
                    ((OR (ATOM #9#) (PROGN (LETT |lp| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |lv|
                          (PROGN
                           (LETT #8# NIL)
                           (SEQ (LETT |v| NIL)
                                (LETT #7# (SPADCALL |lp| (QREFELT $ 18))) G190
                                (COND
                                 ((OR (ATOM #7#)
                                      (PROGN (LETT |v| (CAR #7#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((SPADCALL (SPADCALL |v| (QREFELT $ 37)) |s|
                                              (QREFELT $ 38))
                                    (LETT #8# (CONS |v| #8#))))))
                                (LETT #7# (CDR #7#)) (GO G190) G191
                                (EXIT (NREVERSE #8#)))))
                    (EXIT
                     (COND
                      ((NULL (NULL |lv|))
                       (LETT |d|
                             (MAX |d|
                                  (PROGN
                                   (LETT #1# NIL)
                                   (SEQ (LETT #6# NIL)
                                        (LETT #5#
                                              (SPADCALL |lp| |lv|
                                                        (QREFELT $ 43)))
                                        G190
                                        (COND
                                         ((OR (ATOM #5#)
                                              (PROGN (LETT #6# (CAR #5#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #4# #6#)
                                           (COND (#1# (LETT #2# (+ #2# #4#)))
                                                 ('T
                                                  (PROGN
                                                   (LETT #2# #4#)
                                                   (LETT #1# 'T)))))))
                                        (LETT #5# (CDR #5#)) (GO G190) G191
                                        (EXIT NIL))
                                   (COND (#1# #2#) ('T 0)))))))))
                   (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
              (EXIT |d|)))) 

(SDEFUN |DPOLCAT-;weights;AL;6| ((|p| (A)) ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|ws| (|List| (|NonNegativeInteger|)))
          (|w| #1=(|NonNegativeInteger|)) (#2=#:G782 NIL) (#3=#:G781 #1#)
          (#4=#:G783 #1#) (#5=#:G799 NIL) (#6=#:G801 NIL) (|v| NIL)
          (#7=#:G802 NIL) (|d| NIL) (#8=#:G800 NIL) (#9=#:G691 NIL)
          (|dv| (|List| (|NonNegativeInteger|))) (|lv| (|List| V))
          (#10=#:G798 NIL) (|lp| NIL) (|mp| (|List| A)))
         (SEQ (LETT |ws| NIL)
              (EXIT
               (COND ((NULL (LETT |mp| (SPADCALL |p| (QREFELT $ 41)))) |ws|)
                     ('T
                      (SEQ
                       (SEQ (LETT |lp| NIL) (LETT #10# |mp|) G190
                            (COND
                             ((OR (ATOM #10#)
                                  (PROGN (LETT |lp| (CAR #10#)) NIL))
                              (GO G191)))
                            (SEQ (LETT |lv| (SPADCALL |lp| (QREFELT $ 18)))
                                 (EXIT
                                  (COND
                                   ((NULL (NULL |lv|))
                                    (SEQ
                                     (LETT |dv|
                                           (SPADCALL |lp| |lv| (QREFELT $ 43)))
                                     (LETT |w|
                                           (PROGN
                                            (LETT #2# NIL)
                                            (SEQ (LETT #9# NIL)
                                                 (LETT #5#
                                                       (PROGN
                                                        (LETT #8# NIL)
                                                        (SEQ (LETT |d| NIL)
                                                             (LETT #7# |dv|)
                                                             (LETT |v| NIL)
                                                             (LETT #6# |lv|)
                                                             G190
                                                             (COND
                                                              ((OR (ATOM #6#)
                                                                   (PROGN
                                                                    (LETT |v|
                                                                          (CAR
                                                                           #6#))
                                                                    NIL)
                                                                   (ATOM #7#)
                                                                   (PROGN
                                                                    (LETT |d|
                                                                          (CAR
                                                                           #7#))
                                                                    NIL))
                                                               (GO G191)))
                                                             (SEQ
                                                              (EXIT
                                                               (LETT #8#
                                                                     (CONS
                                                                      (*
                                                                       (SPADCALL
                                                                        |v|
                                                                        (QREFELT
                                                                         $ 45))
                                                                       |d|)
                                                                      #8#))))
                                                             (LETT #6#
                                                                   (PROG1
                                                                       (CDR
                                                                        #6#)
                                                                     (LETT #7#
                                                                           (CDR
                                                                            #7#))))
                                                             (GO G190) G191
                                                             (EXIT
                                                              (NREVERSE
                                                               #8#)))))
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #5#)
                                                       (PROGN
                                                        (LETT #9# (CAR #5#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (PROGN
                                                    (LETT #4# #9#)
                                                    (COND
                                                     (#2#
                                                      (LETT #3# (+ #3# #4#)))
                                                     ('T
                                                      (PROGN
                                                       (LETT #3# #4#)
                                                       (LETT #2# 'T)))))))
                                                 (LETT #5# (CDR #5#)) (GO G190)
                                                 G191 (EXIT NIL))
                                            (COND (#2# #3#) ('T 0))))
                                     (EXIT
                                      (LETT |ws|
                                            (SPADCALL |ws| |w|
                                                      (QREFELT $ 46)))))))))
                            (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |ws|)))))))) 

(SDEFUN |DPOLCAT-;weight;ANni;7| ((|p| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G804 NIL) (#2=#:G803 #3=(|NonNegativeInteger|)) (#4=#:G805 #3#)
          (#5=#:G808 NIL) (#6=#:G692 NIL) (|ws| (|List| #3#)))
         (SEQ
          (COND ((NULL (LETT |ws| (SPADCALL |p| (QREFELT $ 48)))) 0)
                (#7='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT #6# NIL) (LETT #5# |ws|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# #6#)
                          (COND (#1# (LETT #2# (MAX #2# #4#)))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#7# (|IdentityError| '|max|))))))))) 

(SDEFUN |DPOLCAT-;weights;ASL;8|
        ((|p| (A)) (|s| (S)) ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|ws| (|List| (|NonNegativeInteger|)))
          (|w| #1=(|NonNegativeInteger|)) (#2=#:G815 NIL) (#3=#:G814 #1#)
          (#4=#:G816 #1#) (#5=#:G826 NIL) (#6=#:G828 NIL) (|v| NIL)
          (#7=#:G829 NIL) (|d| NIL) (#8=#:G827 NIL) (#9=#:G693 NIL)
          (|dv| (|List| (|NonNegativeInteger|))) (|lv| (|List| V))
          (#10=#:G825 NIL) (#11=#:G824 NIL) (#12=#:G823 NIL) (|lp| NIL)
          (|mp| (|List| A)))
         (SEQ (LETT |ws| NIL)
              (EXIT
               (COND ((NULL (LETT |mp| (SPADCALL |p| (QREFELT $ 41)))) |ws|)
                     ('T
                      (SEQ
                       (SEQ (LETT |lp| NIL) (LETT #12# |mp|) G190
                            (COND
                             ((OR (ATOM #12#)
                                  (PROGN (LETT |lp| (CAR #12#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |lv|
                                   (PROGN
                                    (LETT #11# NIL)
                                    (SEQ (LETT |v| NIL)
                                         (LETT #10#
                                               (SPADCALL |lp| (QREFELT $ 18)))
                                         G190
                                         (COND
                                          ((OR (ATOM #10#)
                                               (PROGN
                                                (LETT |v| (CAR #10#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((SPADCALL
                                              (SPADCALL |v| (QREFELT $ 37)) |s|
                                              (QREFELT $ 38))
                                             (LETT #11# (CONS |v| #11#))))))
                                         (LETT #10# (CDR #10#)) (GO G190) G191
                                         (EXIT (NREVERSE #11#)))))
                             (EXIT
                              (COND
                               ((NULL (NULL |lv|))
                                (SEQ
                                 (LETT |dv|
                                       (SPADCALL |lp| |lv| (QREFELT $ 43)))
                                 (LETT |w|
                                       (PROGN
                                        (LETT #2# NIL)
                                        (SEQ (LETT #9# NIL)
                                             (LETT #5#
                                                   (PROGN
                                                    (LETT #8# NIL)
                                                    (SEQ (LETT |d| NIL)
                                                         (LETT #7# |dv|)
                                                         (LETT |v| NIL)
                                                         (LETT #6# |lv|) G190
                                                         (COND
                                                          ((OR (ATOM #6#)
                                                               (PROGN
                                                                (LETT |v|
                                                                      (CAR
                                                                       #6#))
                                                                NIL)
                                                               (ATOM #7#)
                                                               (PROGN
                                                                (LETT |d|
                                                                      (CAR
                                                                       #7#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #8#
                                                                 (CONS
                                                                  (*
                                                                   (SPADCALL
                                                                    |v|
                                                                    (QREFELT $
                                                                             45))
                                                                   |d|)
                                                                  #8#))))
                                                         (LETT #6#
                                                               (PROG1 (CDR #6#)
                                                                 (LETT #7#
                                                                       (CDR
                                                                        #7#))))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE #8#)))))
                                             G190
                                             (COND
                                              ((OR (ATOM #5#)
                                                   (PROGN
                                                    (LETT #9# (CAR #5#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (PROGN
                                                (LETT #4# #9#)
                                                (COND
                                                 (#2# (LETT #3# (+ #3# #4#)))
                                                 ('T
                                                  (PROGN
                                                   (LETT #3# #4#)
                                                   (LETT #2# 'T)))))))
                                             (LETT #5# (CDR #5#)) (GO G190)
                                             G191 (EXIT NIL))
                                        (COND (#2# #3#) ('T 0))))
                                 (EXIT
                                  (LETT |ws|
                                        (SPADCALL |ws| |w|
                                                  (QREFELT $ 46)))))))))
                            (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |ws|)))))))) 

(SDEFUN |DPOLCAT-;weight;ASNni;9|
        ((|p| (A)) (|s| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G831 NIL) (#2=#:G830 #3=(|NonNegativeInteger|)) (#4=#:G832 #3#)
          (#5=#:G835 NIL) (#6=#:G694 NIL) (|ws| (|List| #3#)))
         (SEQ
          (COND ((NULL (LETT |ws| (SPADCALL |p| |s| (QREFELT $ 51)))) 0)
                (#7='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT #6# NIL) (LETT #5# |ws|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# #6#)
                          (COND (#1# (LETT #2# (MAX #2# #4#)))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#7# (|IdentityError| '|max|))))))))) 

(SDEFUN |DPOLCAT-;isobaric?;AB;10| ((|p| (A)) ($ (|Boolean|)))
        (EQL
         (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 48)) (QREFELT $ 53))
                   (QREFELT $ 54))
         1)) 

(SDEFUN |DPOLCAT-;leader;AV;11| ((|p| (A)) ($ (V)))
        (SPROG
         ((#1=#:G840 NIL) (#2=#:G839 (V)) (#3=#:G841 (V)) (#4=#:G844 NIL)
          (#5=#:G695 NIL) (|vl| (|List| V)))
         (SEQ (LETT |vl| (SPADCALL |p| (QREFELT $ 18)))
              (EXIT
               (COND ((NULL |vl|) (|error| "leader is not defined "))
                     (#6='T
                      (PROGN
                       (LETT #1# NIL)
                       (SEQ (LETT #5# NIL) (LETT #4# |vl|) G190
                            (COND
                             ((OR (ATOM #4#) (PROGN (LETT #5# (CAR #4#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (PROGN
                               (LETT #3# #5#)
                               (COND
                                (#1#
                                 (LETT #2# (SPADCALL #2# #3# (QREFELT $ 56))))
                                ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                            (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                       (COND (#1# #2#) (#6# (|IdentityError| '|max|)))))))))) 

(SDEFUN |DPOLCAT-;initial;2A;12| ((|p| (A)) ($ (A)))
        (SPADCALL (SPADCALL |p| (SPADCALL |p| (QREFELT $ 58)) (QREFELT $ 60))
                  (QREFELT $ 62))) 

(SDEFUN |DPOLCAT-;separant;2A;13| ((|p| (A)) ($ (A)))
        (SPADCALL |p| (SPADCALL |p| (QREFELT $ 58)) (QREFELT $ 28))) 

(SDEFUN |DPOLCAT-;coerce;SA;14| ((|s| (S)) ($ (A)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 65)) (QREFELT $ 13))) 

(SDEFUN |DPOLCAT-;retractIfCan;AU;15| ((|p| (A)) ($ (|Union| S "failed")))
        (SPROG ((|v| (|Union| V "failed")))
               (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 68)))
                    (EXIT
                     (COND ((QEQCAR |v| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |v|) (QREFELT $ 70)))))))) 

(SDEFUN |DPOLCAT-;differentialVariables;AL;16| ((|p| (A)) ($ (|List| S)))
        (SPROG ((#1=#:G860 NIL) (|v| NIL) (#2=#:G859 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |v| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 18)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |v| (QREFELT $ 37)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 73))))) 

(SDEFUN |DPOLCAT-;makeVariable;AM;17|
        ((|p| (A)) ($ (|Mapping| A (|NonNegativeInteger|))))
        (SPROG NIL (CONS #'|DPOLCAT-;makeVariable;AM;17!0| (VECTOR $ |p|)))) 

(SDEFUN |DPOLCAT-;makeVariable;AM;17!0| ((|n| NIL) ($$ NIL))
        (PROG (|p| $)
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |p| |n| (QREFELT $ 75)))))) 

(SDEFUN |DPOLCAT-;eval;ALLA;18|
        ((|p| (A)) (|sl| (|List| S)) (|rl| (|List| R)) ($ (A)))
        (SPROG
         ((|rrl| (|List| R)) (|t| (R)) (#1=#:G890 NIL) (|i| NIL)
          (#2=#:G889 NIL) (#3=#:G888 NIL) (|r| NIL) (|vl| (|List| V))
          (#4=#:G887 NIL) (|j| NIL) (#5=#:G886 NIL) (#6=#:G885 NIL) (|s| NIL)
          (#7=#:G884 NIL) (|ordp| (|NonNegativeInteger|)))
         (SEQ (LETT |ordp| (SPADCALL |p| (QREFELT $ 77)))
              (LETT |vl|
                    (SPADCALL
                     (PROGN
                      (LETT #7# NIL)
                      (SEQ (LETT |s| NIL) (LETT #6# |sl|) G190
                           (COND
                            ((OR (ATOM #6#) (PROGN (LETT |s| (CAR #6#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #7#
                                   (CONS
                                    (PROGN
                                     (LETT #5# NIL)
                                     (SEQ (LETT |j| 0) (LETT #4# |ordp|) G190
                                          (COND
                                           ((|greater_SI| |j| #4#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #5#
                                                  (CONS
                                                   (SPADCALL |s| |j|
                                                             (QREFELT $ 12))
                                                   #5#))))
                                          (LETT |j| (|inc_SI| |j|)) (GO G190)
                                          G191 (EXIT (NREVERSE #5#))))
                                    #7#))))
                           (LETT #6# (CDR #6#)) (GO G190) G191
                           (EXIT (NREVERSE #7#))))
                     (QREFELT $ 78)))
              (LETT |rrl| NIL)
              (SEQ (LETT |r| NIL) (LETT #3# |rl|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |t| |r|)
                        (EXIT
                         (LETT |rrl|
                               (SPADCALL |rrl|
                                         (CONS |r|
                                               (PROGN
                                                (LETT #2# NIL)
                                                (SEQ (LETT |i| 1)
                                                     (LETT #1# |ordp|) G190
                                                     (COND
                                                      ((|greater_SI| |i| #1#)
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #2#
                                                             (CONS
                                                              (LETT |t|
                                                                    (SPADCALL
                                                                     |t|
                                                                     (QREFELT $
                                                                              79)))
                                                              #2#))))
                                                     (LETT |i| (|inc_SI| |i|))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #2#)))))
                                         (QREFELT $ 81)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |p| |vl| |rrl| (QREFELT $ 82)))))) 

(SDEFUN |DPOLCAT-;eval;ALLA;19|
        ((|p| (A)) (|sl| (|List| S)) (|rl| (|List| A)) ($ (A)))
        (SPROG
         ((|rrl| (|List| A)) (|t| (A)) (#1=#:G916 NIL) (|i| NIL)
          (#2=#:G915 NIL) (#3=#:G914 NIL) (|r| NIL) (|vl| (|List| V))
          (#4=#:G913 NIL) (|j| NIL) (#5=#:G912 NIL) (#6=#:G911 NIL) (|s| NIL)
          (#7=#:G910 NIL) (|ordp| (|NonNegativeInteger|)))
         (SEQ (LETT |ordp| (SPADCALL |p| (QREFELT $ 77)))
              (LETT |vl|
                    (SPADCALL
                     (PROGN
                      (LETT #7# NIL)
                      (SEQ (LETT |s| NIL) (LETT #6# |sl|) G190
                           (COND
                            ((OR (ATOM #6#) (PROGN (LETT |s| (CAR #6#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #7#
                                   (CONS
                                    (PROGN
                                     (LETT #5# NIL)
                                     (SEQ (LETT |j| 0) (LETT #4# |ordp|) G190
                                          (COND
                                           ((|greater_SI| |j| #4#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #5#
                                                  (CONS
                                                   (SPADCALL |s| |j|
                                                             (QREFELT $ 12))
                                                   #5#))))
                                          (LETT |j| (|inc_SI| |j|)) (GO G190)
                                          G191 (EXIT (NREVERSE #5#))))
                                    #7#))))
                           (LETT #6# (CDR #6#)) (GO G190) G191
                           (EXIT (NREVERSE #7#))))
                     (QREFELT $ 78)))
              (LETT |rrl| NIL)
              (SEQ (LETT |r| NIL) (LETT #3# |rl|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |t| |r|)
                        (EXIT
                         (LETT |rrl|
                               (SPADCALL |rrl|
                                         (CONS |r|
                                               (PROGN
                                                (LETT #2# NIL)
                                                (SEQ (LETT |i| 1)
                                                     (LETT #1# |ordp|) G190
                                                     (COND
                                                      ((|greater_SI| |i| #1#)
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #2#
                                                             (CONS
                                                              (LETT |t|
                                                                    (SPADCALL
                                                                     |t|
                                                                     (QREFELT $
                                                                              84)))
                                                              #2#))))
                                                     (LETT |i| (|inc_SI| |i|))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #2#)))))
                                         (QREFELT $ 86)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |p| |vl| |rrl| (QREFELT $ 87)))))) 

(SDEFUN |DPOLCAT-;eval;ALA;20|
        ((|p| (A)) (|l| (|List| (|Equation| A))) ($ (A)))
        (SPROG
         ((#1=#:G925 NIL) (|e| NIL) (#2=#:G924 NIL) (#3=#:G923 NIL)
          (#4=#:G922 NIL))
         (SEQ
          (SPADCALL |p|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |e| NIL) (LETT #3# |l|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |e| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL (SPADCALL |e| (QREFELT $ 90))
                                             (QREFELT $ 91))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |e| (QREFELT $ 92)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 93))))) 

(DECLAIM (NOTINLINE |DifferentialPolynomialCategory&;|)) 

(DEFUN |DifferentialPolynomialCategory&| (|#1| |#2| |#3| |#4| |#5|)
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
          (LIST '|DifferentialPolynomialCategory&| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 104))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|DifferentialRing|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#2| '(|IntegralDomain|))
      (QSETREFV $ 32
                (CONS (|dispatchFunction| |DPOLCAT-;differentiate;AMA;2|) $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 76
                 (CONS (|dispatchFunction| |DPOLCAT-;makeVariable;AM;17|) $))
       (QSETREFV $ 83 (CONS (|dispatchFunction| |DPOLCAT-;eval;ALLA;18|) $))
       (QSETREFV $ 88 (CONS (|dispatchFunction| |DPOLCAT-;eval;ALLA;19|) $))
       (QSETREFV $ 95 (CONS (|dispatchFunction| |DPOLCAT-;eval;ALA;20|) $)))))
    $))) 

(MAKEPROP '|DifferentialPolynomialCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|NonNegativeInteger|) (0 . |makeVariable|) (6 . |coerce|)
              (|Mapping| $ 11) |DPOLCAT-;makeVariable;SM;1| (11 . |Zero|)
              (|List| 9) (15 . |variables|) (|Union| 7 '#1="failed")
              (20 . |retractIfCan|) (25 . |leadingMonomial|)
              (30 . |leadingCoefficient|) (35 . |coerce|) (|Union| $ '"failed")
              (40 . |exquo|) (46 . *) (52 . +) (58 . |differentiate|)
              (64 . |differentiate|) (69 . |reductum|) (|Mapping| 7 7)
              (74 . |differentiate|) (|Boolean|) (80 . |ground?|)
              (85 . |order|) |DPOLCAT-;order;ANni;3| (90 . |variable|) (95 . =)
              |DPOLCAT-;order;ASNni;4| (|List| $) (101 . |monomials|)
              (|List| 11) (106 . |degree|) |DPOLCAT-;degree;ASNni;5|
              (112 . |weight|) (117 . |concat|) |DPOLCAT-;weights;AL;6|
              (123 . |weights|) |DPOLCAT-;weight;ANni;7|
              |DPOLCAT-;weights;ASL;8| (128 . |weights|)
              |DPOLCAT-;weight;ASNni;9| (134 . |removeDuplicates|) (139 . |#|)
              |DPOLCAT-;isobaric?;AB;10| (144 . |max|) |DPOLCAT-;leader;AV;11|
              (150 . |leader|) (|SparseUnivariatePolynomial| $)
              (155 . |univariate|) (|SparseUnivariatePolynomial| 6)
              (161 . |leadingCoefficient|) |DPOLCAT-;initial;2A;12|
              |DPOLCAT-;separant;2A;13| (166 . |coerce|)
              |DPOLCAT-;coerce;SA;14| (|Union| 9 '#1#) (171 . |retractIfCan|)
              (|Union| 8 '#1#) (176 . |retractIfCan|)
              |DPOLCAT-;retractIfCan;AU;15| (|List| 8)
              (181 . |removeDuplicates|) |DPOLCAT-;differentialVariables;AL;16|
              (186 . |differentiate|) (192 . |makeVariable|) (197 . |order|)
              (202 . |concat|) (207 . |differentiate|) (|List| 7)
              (212 . |concat|) (218 . |eval|) (225 . |eval|)
              (232 . |differentiate|) (|List| 6) (237 . |concat|)
              (243 . |eval|) (250 . |eval|) (|Equation| 6) (257 . |lhs|)
              (262 . |retract|) (267 . |rhs|) (272 . |eval|) (|List| 96)
              (279 . |eval|) (|Equation| $) (|Integer|) (|Symbol|) (|List| 98)
              (|Union| 102 '#1#) (|Union| 97 '#1#) (|Fraction| 97)
              (|OutputForm|))
           '#(|weights| 285 |weight| 296 |separant| 307 |retractIfCan| 312
              |order| 317 |makeVariable| 328 |leader| 338 |isobaric?| 343
              |initial| 348 |eval| 353 |differentiate| 373
              |differentialVariables| 379 |degree| 384 |coerce| 390)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|eval|
                                 (|#1| |#1| (|List| |#3|) (|List| |#2|)))
                                T)
                              '((|eval| (|#1| |#1| |#3| |#2|)) T)
                              '((|eval|
                                 (|#1| |#1| (|List| |#3|) (|List| |#1|)))
                                T)
                              '((|eval| (|#1| |#1| |#3| |#1|)) T)
                              '((|eval|
                                 (|#1| |#1| (|List| |#1|) (|List| |#1|)))
                                T)
                              '((|eval| (|#1| |#1| |#1| |#1|)) T)
                              '((|eval| (|#1| |#1| (|Equation| |#1|))) T)
                              '((|eval| (|#1| |#1| (|List| (|Equation| |#1|))))
                                T)
                              '((|makeVariable|
                                 ((|Mapping| |#1| (|NonNegativeInteger|))
                                  |#1|))
                                T)
                              '((|separant| (|#1| |#1|)) T)
                              '((|initial| (|#1| |#1|)) T)
                              '((|leader| (|#4| |#1|)) T)
                              '((|isobaric?| ((|Boolean|) |#1|)) T)
                              '((|weight| ((|NonNegativeInteger|) |#1| |#3|))
                                T)
                              '((|weights|
                                 ((|List| (|NonNegativeInteger|)) |#1| |#3|))
                                T)
                              '((|weight| ((|NonNegativeInteger|) |#1|)) T)
                              '((|weights|
                                 ((|List| (|NonNegativeInteger|)) |#1|))
                                T)
                              '((|degree| ((|NonNegativeInteger|) |#1| |#3|))
                                T)
                              '((|order| ((|NonNegativeInteger|) |#1|)) T)
                              '((|order| ((|NonNegativeInteger|) |#1| |#3|)) T)
                              '((|differentialVariables| ((|List| |#3|) |#1|))
                                T)
                              '((|makeVariable|
                                 ((|Mapping| |#1| (|NonNegativeInteger|))
                                  |#3|))
                                T)
                              '((|coerce| (|#1| |#3|)) T)
                              '((|retractIfCan| ((|Union| |#3| #1#) |#1|)) T)
                              '((|coerce| (|#1| (|Integer|))) T)
                              '((|differentiate|
                                 (|#1| |#1| (|Mapping| |#2| |#2|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|Mapping| |#2| |#2|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|List| (|Symbol|))
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|Symbol|) (|NonNegativeInteger|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|List| (|Symbol|))))
                                T)
                              '((|differentiate| (|#1| |#1| (|Symbol|))) T)
                              '((|differentiate|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|differentiate| (|#1| |#1|)) T)
                              '((|coerce| (|#1| |#4|)) T)
                              '((|retractIfCan| ((|Union| |#4| #1#) |#1|)) T)
                              '((|differentiate| (|#1| |#1| |#4|)) T)
                              '((|differentiate| (|#1| |#1| (|List| |#4|))) T)
                              '((|differentiate|
                                 (|#1| |#1| |#4| (|NonNegativeInteger|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|List| |#4|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|coerce| (|#1| |#1|)) T)
                              '((|eval|
                                 (|#1| |#1| (|List| |#4|) (|List| |#1|)))
                                T)
                              '((|eval| (|#1| |#1| |#4| |#1|)) T)
                              '((|eval|
                                 (|#1| |#1| (|List| |#4|) (|List| |#2|)))
                                T)
                              '((|eval| (|#1| |#1| |#4| |#2|)) T)
                              '((|degree|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|List| |#4|)))
                                T)
                              '((|degree| ((|NonNegativeInteger|) |#1| |#4|))
                                T)
                              '((|coerce| (|#1| |#2|)) T)
                              '((|retractIfCan| ((|Union| |#2| #1#) |#1|)) T)
                              '((|retractIfCan|
                                 ((|Union| (|Fraction| (|Integer|)) #1#) |#1|))
                                T)
                              '((|coerce| (|#1| (|Fraction| (|Integer|)))) T)
                              '((|retractIfCan|
                                 ((|Union| (|Integer|) #1#) |#1|))
                                T)
                              '((|degree| (|#5| |#1|)) T)
                              '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 95
                                            '(2 9 0 8 11 12 1 6 0 9 13 0 6 0 16
                                              1 6 17 0 18 1 6 19 0 20 1 6 0 0
                                              21 1 6 7 0 22 1 6 0 7 23 2 6 24 0
                                              7 25 2 6 0 0 0 26 2 6 0 0 0 27 2
                                              6 0 0 9 28 1 9 0 0 29 1 6 0 0 30
                                              2 0 0 0 31 32 1 6 33 0 34 1 9 11
                                              0 35 1 9 8 0 37 2 8 33 0 0 38 1 6
                                              40 0 41 2 6 42 0 17 43 1 9 11 0
                                              45 2 42 0 0 11 46 1 6 42 0 48 2 6
                                              42 0 8 51 1 42 0 0 53 1 42 11 0
                                              54 2 9 0 0 0 56 1 6 9 0 58 2 6 59
                                              0 9 60 1 61 6 0 62 1 9 0 8 65 1 6
                                              67 0 68 1 9 69 0 70 1 72 0 0 73 2
                                              6 0 0 11 75 1 0 14 0 76 1 6 11 0
                                              77 1 17 0 40 78 1 7 0 0 79 2 80 0
                                              0 0 81 3 6 0 0 17 80 82 3 0 0 0
                                              72 80 83 1 6 0 0 84 2 85 0 0 0 86
                                              3 6 0 0 17 40 87 3 0 0 0 72 40 88
                                              1 89 6 0 90 1 6 8 0 91 1 89 6 0
                                              92 3 6 0 0 72 40 93 2 0 0 0 94 95
                                              2 0 42 0 8 50 1 0 42 0 47 2 0 11
                                              0 8 52 1 0 11 0 49 1 0 0 0 64 1 0
                                              69 0 71 1 0 11 0 36 2 0 11 0 8 39
                                              1 0 14 0 76 1 0 14 8 15 1 0 9 0
                                              57 1 0 33 0 55 1 0 0 0 63 3 0 0 0
                                              72 80 83 3 0 0 0 72 40 88 2 0 0 0
                                              94 95 2 0 0 0 31 32 1 0 72 0 74 2
                                              0 11 0 8 44 1 0 0 8 66)))))
           '|lookupComplete|)) 
