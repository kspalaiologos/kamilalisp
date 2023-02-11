
(SDEFUN |LATJOFM;proposition| ((|s| (|String|)) ($ ($)))
        (LIST (LIST (CONS 1 (LIST |s|))))) 

(SDEFUN |LATJOFM;logicT;$;2| (($ ($))) (LIST (LIST (CONS 0 (LIST 'T))))) 

(SDEFUN |LATJOFM;logicF;$;3| (($ ($))) (LIST (LIST (CONS 0 (LIST 'F))))) 

(PUT '|LATJOFM;emptyLattice;$;4| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |LATJOFM;emptyLattice;$;4| (($ ($))) NIL) 

(SDEFUN |LATJOFM;variable;S$;5| ((|v| (|String|)) ($ ($)))
        (LIST (LIST (CONS 1 (LIST |v|))))) 

(SDEFUN |LATJOFM;latticeJoinOfMeets;U$;6|
        ((|e|
          (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                   (|:| |var| (|Record| (|:| |str| (|String|))))))
         ($ ($)))
        (LIST (LIST |e|))) 

(PUT '|LATJOFM;empty?;$B;7| '|SPADreplace| 'NULL) 

(SDEFUN |LATJOFM;empty?;$B;7| ((|n| ($)) ($ (|Boolean|))) (NULL |n|)) 

(SDEFUN |LATJOFM;/\\;3$;8| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|r|
           (|List|
            (|List|
             (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                      (|:| |var| (|Record| (|:| |str| (|String|))))))))
          (|term|
           (|List|
            (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                     (|:| |var| (|Record| (|:| |str| (|String|)))))))
          (|termRight|
           #1=(|List|
               (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                        (|:| |var| (|Record| (|:| |str| (|String|)))))))
          (|termLeft| #1#) (#2=#:G784 NIL) (|innerb| NIL) (#3=#:G783 NIL)
          (|innera| NIL) (#4=#:G782 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |a| (QREFELT $ 17))
              (PROGN (LETT #4# |b|) (GO #5=#:G781))))
            (COND
             ((SPADCALL |b| (QREFELT $ 17)) (PROGN (LETT #4# |a|) (GO #5#))))
            (LETT |r| NIL)
            (SEQ (LETT |innera| NIL) (LETT #3# |a|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |innera| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |innerb| NIL) (LETT #2# |b|) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |innerb| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ (LETT |termLeft| |innera|)
                             (LETT |termRight| |innerb|)
                             (LETT |term|
                                   (SPADCALL |termLeft| |termRight|
                                             (QREFELT $ 19)))
                             (EXIT
                              (LETT |r| (SPADCALL |r| |term| (QREFELT $ 21)))))
                        (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT (SPADCALL |r| (QREFELT $ 22)))))
          #5# (EXIT #4#)))) 

(SDEFUN |LATJOFM;\\/;3$;9| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G793 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |a| (QREFELT $ 17))
                    (PROGN (LETT #1# |b|) (GO #2=#:G792))))
                  (COND
                   ((SPADCALL |b| (QREFELT $ 17))
                    (PROGN (LETT #1# |a|) (GO #2#))))
                  (EXIT
                   (SPADCALL (SPADCALL |a| |b| (QREFELT $ 24))
                             (QREFELT $ 22)))))
                #2# (EXIT #1#)))) 

(SDEFUN |LATJOFM;meet;L$;10| ((|ln| (|List| $)) ($ ($)))
        (SPROG ((|r| ($)) (#1=#:G798 NIL) (|ele| NIL))
               (SEQ (LETT |r| (SPADCALL (QREFELT $ 9)))
                    (SEQ (LETT |ele| NIL) (LETT #1# |ln|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |ele| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |r| (SPADCALL |r| |ele| (QREFELT $ 23)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |r|)))) 

(SDEFUN |LATJOFM;join;L$;11| ((|ln| (|List| $)) ($ ($)))
        (SPROG ((|r| ($)) (#1=#:G803 NIL) (|ele| NIL))
               (SEQ (LETT |r| (SPADCALL (QREFELT $ 9)))
                    (SEQ (LETT |ele| NIL) (LETT #1# |ln|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |ele| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |r| (SPADCALL |r| |ele| (QREFELT $ 25)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |r|)))) 

(SDEFUN |LATJOFM;equalElements|
        ((|a|
          (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                   (|:| |var| (|Record| (|:| |str| (|String|))))))
         (|b|
          (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                   (|:| |var| (|Record| (|:| |str| (|String|))))))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G817 NIL) (#2=#:G806 NIL) (#3=#:G807 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |a| 1)
                    (PROGN
                     (LETT #1#
                           (EQUAL (QCAR (CDR |a|))
                                  (QCAR
                                   (PROG2 (LETT #3# |b|)
                                       (QCDR #3#)
                                     (|check_union2| (QEQCAR #3# 1)
                                                     (|Record|
                                                      (|:| |str| (|String|)))
                                                     (|Union|
                                                      (|:| |const|
                                                           (|Record|
                                                            (|:| |val|
                                                                 (|Symbol|))))
                                                      (|:| |var|
                                                           (|Record|
                                                            (|:| |str|
                                                                 (|String|)))))
                                                     #3#)))))
                     (GO #4=#:G816))))
                  (COND
                   ((QEQCAR |a| 0)
                    (COND
                     ((QEQCAR |b| 0)
                      (PROGN
                       (LETT #1#
                             (EQUAL
                              (QCAR
                               (PROG2 (LETT #2# |a|)
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0)
                                                 (|Record|
                                                  (|:| |val| (|Symbol|)))
                                                 (|Union|
                                                  (|:| |const|
                                                       (|Record|
                                                        (|:| |val|
                                                             (|Symbol|))))
                                                  (|:| |var|
                                                       (|Record|
                                                        (|:| |str|
                                                             (|String|)))))
                                                 #2#)))
                              (QCAR (CDR |b|))))
                       (GO #4#))))))
                  (EXIT NIL)))
                #4# (EXIT #1#)))) 

(SDEFUN |LATJOFM;removeDuplicatesInTerm|
        ((|n|
          (|List|
           (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                    (|:| |var| (|Record| (|:| |str| (|String|)))))))
         ($
          (|List|
           (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                    (|:| |var| (|Record| (|:| |str| (|String|))))))))
        (SPROG
         ((|r|
           (|List|
            (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                     (|:| |var| (|Record| (|:| |str| (|String|)))))))
          (|match| (|Boolean|)) (#1=#:G836 NIL) (|e2| NIL) (#2=#:G837 NIL)
          (|ne2| NIL) (#3=#:G834 NIL) (|e1| NIL) (#4=#:G835 NIL) (|ne1| NIL))
         (SEQ (LETT |r| NIL)
              (SEQ (LETT |ne1| 1) (LETT #4# (LENGTH |n|)) (LETT |e1| NIL)
                   (LETT #3# |n|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |e1| (CAR #3#)) NIL)
                         (|greater_SI| |ne1| #4#))
                     (GO G191)))
                   (SEQ (LETT |match| NIL)
                        (SEQ (LETT |ne2| 1) (LETT #2# (LENGTH |n|))
                             (LETT |e2| NIL) (LETT #1# |n|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |e2| (CAR #1#)) NIL)
                                   (|greater_SI| |ne2| #2#))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |e1| |e2| (QREFELT $ 29))
                                 (COND ((< |ne1| |ne2|) (LETT |match| 'T)))))))
                             (LETT #1#
                                   (PROG1 (CDR #1#)
                                     (LETT |ne2| (|inc_SI| |ne2|))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL |match|)
                           (LETT |r| (SPADCALL |r| |e1| (QREFELT $ 30)))))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT |ne1| (|inc_SI| |ne1|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |LATJOFM;equalTerms|
        ((|a|
          (|List|
           (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                    (|:| |var| (|Record| (|:| |str| (|String|)))))))
         (|b|
          (|List|
           (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                    (|:| |var| (|Record| (|:| |str| (|String|)))))))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G855 NIL) (|found| (|Boolean|)) (#2=#:G857 NIL) (|b1| NIL)
          (#3=#:G856 NIL) (|a1| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL (LENGTH |a|) (LENGTH |b|) (QREFELT $ 32))
              (PROGN (LETT #1# NIL) (GO #4=#:G854))))
            (SEQ (LETT |a1| NIL) (LETT #3# |a|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |a1| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |found| NIL)
                      (SEQ (LETT |b1| NIL) (LETT #2# |b|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |b1| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((|LATJOFM;equalElements| |a1| |b1| $)
                               (LETT |found| 'T)))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL |found|) (PROGN (LETT #1# NIL) (GO #4#))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |LATJOFM;subTerm|
        ((|a|
          (|List|
           (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                    (|:| |var| (|Record| (|:| |str| (|String|)))))))
         (|b|
          (|List|
           (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                    (|:| |var| (|Record| (|:| |str| (|String|)))))))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G875 NIL) (|found| (|Boolean|)) (#2=#:G877 NIL) (|b1| NIL)
          (#3=#:G876 NIL) (|a1| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((>= (LENGTH |a|) (LENGTH |b|))
              (PROGN (LETT #1# NIL) (GO #4=#:G874))))
            (SEQ (LETT |a1| NIL) (LETT #3# |a|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |a1| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |found| NIL)
                      (SEQ (LETT |b1| NIL) (LETT #2# |b|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |b1| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((|LATJOFM;equalElements| |a1| |b1| $)
                               (LETT |found| 'T)))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL |found|) (PROGN (LETT #1# NIL) (GO #4#))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |LATJOFM;redux;2$;16| ((|n| ($)) ($ ($)))
        (SPROG
         ((|r|
           (|List|
            (|List|
             (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                      (|:| |var| (|Record| (|:| |str| (|String|))))))))
          (|modified| #1=(|Boolean|)) (|isSubTerm| #1#) (#2=#:G894 NIL)
          (|inner| NIL) (|match| #1#) (#3=#:G892 NIL) (#4=#:G893 NIL)
          (|innern| NIL)
          (|newinnerList|
           (|List|
            (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                     (|:| |var| (|Record| (|:| |str| (|String|)))))))
          (#5=#:G890 NIL) (|outer| NIL) (#6=#:G891 NIL) (|outern| NIL))
         (SEQ (LETT |r| NIL) (LETT |modified| NIL)
              (SEQ (LETT |outern| 1) (LETT #6# (LENGTH |n|)) (LETT |outer| NIL)
                   (LETT #5# |n|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |outer| (CAR #5#)) NIL)
                         (|greater_SI| |outern| #6#))
                     (GO G191)))
                   (SEQ
                    (LETT |newinnerList|
                          (|LATJOFM;removeDuplicatesInTerm| |outer| $))
                    (COND
                     ((NULL (|LATJOFM;equalTerms| |newinnerList| |outer| $))
                      (LETT |modified| 'T)))
                    (LETT |match| NIL)
                    (SEQ (LETT |innern| 1) (LETT #4# (LENGTH |n|))
                         (LETT |inner| NIL) (LETT #3# |n|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |inner| (CAR #3#)) NIL)
                               (|greater_SI| |innern| #4#))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|LATJOFM;equalTerms| |inner| |outer| $)
                             (COND
                              ((< |innern| |outern|) (LETT |match| 'T)))))))
                         (LETT #3#
                               (PROG1 (CDR #3#)
                                 (LETT |innern| (|inc_SI| |innern|))))
                         (GO G190) G191 (EXIT NIL))
                    (LETT |isSubTerm| NIL)
                    (SEQ (LETT |inner| NIL) (LETT #2# |n|) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |inner| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|LATJOFM;subTerm| |inner| |outer| $)
                             (LETT |isSubTerm| 'T)))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND ((OR |match| |isSubTerm|) (LETT |modified| 'T))
                           ('T
                            (LETT |r|
                                  (SPADCALL |r| |newinnerList|
                                            (QREFELT $ 21)))))))
                   (LETT #5#
                         (PROG1 (CDR #5#) (LETT |outern| (|inc_SI| |outern|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND (|modified| (SPADCALL |r| (QREFELT $ 22))) ('T |r|)))))) 

(PUT '|LATJOFM;factor;$L;17| '|SPADreplace| 'LIST) 

(SDEFUN |LATJOFM;factor;$L;17| ((|n| ($)) ($ (|List| $))) (LIST |n|)) 

(PUT '|LATJOFM;removeDup| '|SPADreplace| '(XLAM (|a| |b|) |a|)) 

(SDEFUN |LATJOFM;removeDup| ((|a| (|List| $)) (|b| (|List| $)) ($ (|List| $)))
        |a|) 

(PUT '|LATJOFM;deductions;2L;19| '|SPADreplace| '(XLAM (|ln|) |ln|)) 

(SDEFUN |LATJOFM;deductions;2L;19| ((|ln| (|List| $)) ($ (|List| $))) |ln|) 

(PUT '|LATJOFM;opType;$S;20| '|SPADreplace| '(XLAM (|n|) 'OTHER)) 

(SDEFUN |LATJOFM;opType;$S;20| ((|n| ($)) ($ (|Symbol|))) 'OTHER) 

(PUT '|LATJOFM;atom?;$B;21| '|SPADreplace| '(XLAM (|n|) NIL)) 

(SDEFUN |LATJOFM;atom?;$B;21| ((|n| ($)) ($ (|Boolean|))) NIL) 

(PUT '|LATJOFM;value;$S;22| '|SPADreplace| '(XLAM (|n|) 'C)) 

(SDEFUN |LATJOFM;value;$S;22| ((|n| ($)) ($ (|Symbol|))) 'C) 

(PUT '|LATJOFM;getChildren;$L;23| '|SPADreplace| 'LIST) 

(SDEFUN |LATJOFM;getChildren;$L;23| ((|n| ($)) ($ (|List| $))) (LIST |n|)) 

(PUT '|LATJOFM;=;2$B;24| '|SPADreplace| '(XLAM (|a| |b|) NIL)) 

(SDEFUN |LATJOFM;=;2$B;24| ((|a| ($)) (|b| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |LATJOFM;toString;$S;25| ((|n| ($)) ($ (|String|)))
        (SPADCALL (LIST "(" (SPADCALL |n| (QREFELT $ 41)) ")") (QREFELT $ 42))) 

(SDEFUN |LATJOFM;stringVarOrLit|
        ((|a|
          (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                   (|:| |var| (|Record| (|:| |str| (|String|))))))
         ($ (|String|)))
        (SPROG ((#1=#:G908 NIL) (#2=#:G820 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |a| 1)
                    (PROGN (LETT #1# (QCAR (CDR |a|))) (GO #3=#:G907))))
                  (COND
                   ((QEQCAR |a| 0)
                    (SEQ
                     (COND
                      ((EQUAL
                        (QCAR
                         (PROG2 (LETT #2# |a|)
                             (QCDR #2#)
                           (|check_union2| (QEQCAR #2# 0)
                                           (|Record| (|:| |val| (|Symbol|)))
                                           (|Union|
                                            (|:| |const|
                                                 (|Record|
                                                  (|:| |val| (|Symbol|))))
                                            (|:| |var|
                                                 (|Record|
                                                  (|:| |str| (|String|)))))
                                           #2#)))
                        'T)
                       (PROGN (LETT #1# "T") (GO #3#))))
                     (EXIT (PROGN (LETT #1# "F") (GO #3#))))))
                  (EXIT "error")))
                #3# (EXIT #1#)))) 

(SDEFUN |LATJOFM;toStringUnwrapped;$S;27| ((|n| ($)) ($ (|String|)))
        (SPROG
         ((|r| (|String|)) (#1=#:G923 NIL) (|inner| NIL) (#2=#:G924 NIL)
          (|innern| NIL) (#3=#:G921 NIL) (|outer| NIL) (#4=#:G922 NIL)
          (|outern| NIL))
         (SEQ (LETT |r| "")
              (SEQ (LETT |outern| 1) (LETT #4# (LENGTH |n|)) (LETT |outer| NIL)
                   (LETT #3# |n|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |outer| (CAR #3#)) NIL)
                         (|greater_SI| |outern| #4#))
                     (GO G191)))
                   (SEQ
                    (SEQ (LETT |innern| 1) (LETT #2# (LENGTH |outer|))
                         (LETT |inner| NIL) (LETT #1# |outer|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |inner| (CAR #1#)) NIL)
                               (|greater_SI| |innern| #2#))
                           (GO G191)))
                         (SEQ
                          (LETT |r|
                                (STRCONC |r|
                                         (|LATJOFM;stringVarOrLit| |inner| $)))
                          (EXIT
                           (COND
                            ((SPADCALL |innern| (LENGTH |outer|)
                                       (QREFELT $ 32))
                             (LETT |r| (STRCONC |r| "/\\"))))))
                         (LETT #1#
                               (PROG1 (CDR #1#)
                                 (LETT |innern| (|inc_SI| |innern|))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND
                      ((SPADCALL |outern| (LENGTH |n|) (QREFELT $ 32))
                       (LETT |r| (STRCONC |r| ")\\/("))))))
                   (LETT #3#
                         (PROG1 (CDR #3#) (LETT |outern| (|inc_SI| |outern|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |LATJOFM;outputVarOrLit|
        ((|a|
          (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                   (|:| |var| (|Record| (|:| |str| (|String|))))))
         ($ (|OutputForm|)))
        (SPROG ((#1=#:G927 NIL) (#2=#:G820 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |a| 1)
                    (PROGN
                     (LETT #1# (SPADCALL (QCAR (CDR |a|)) (QREFELT $ 45)))
                     (GO #3=#:G926))))
                  (COND
                   ((QEQCAR |a| 0)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (QCAR
                             (PROG2 (LETT #2# |a|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 0)
                                               (|Record|
                                                (|:| |val| (|Symbol|)))
                                               (|Union|
                                                (|:| |const|
                                                     (|Record|
                                                      (|:| |val| (|Symbol|))))
                                                (|:| |var|
                                                     (|Record|
                                                      (|:| |str| (|String|)))))
                                               #2#)))
                            (QREFELT $ 46)))
                     (GO #3#))))
                  (EXIT (|error| "outputVarOrLit"))))
                #3# (EXIT #1#)))) 

(SDEFUN |LATJOFM;coerce;$Of;29| ((|n| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|r| (|OutputForm|)) (#1=#:G942 NIL) (|inner| NIL) (#2=#:G943 NIL)
          (|innern| NIL) (#3=#:G940 NIL) (|outer| NIL) (#4=#:G941 NIL)
          (|outern| NIL))
         (SEQ (LETT |r| (SPADCALL "(" (QREFELT $ 47)))
              (SEQ (LETT |outern| 1) (LETT #4# (LENGTH |n|)) (LETT |outer| NIL)
                   (LETT #3# |n|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |outer| (CAR #3#)) NIL)
                         (|greater_SI| |outern| #4#))
                     (GO G191)))
                   (SEQ
                    (SEQ (LETT |innern| 1) (LETT #2# (LENGTH |outer|))
                         (LETT |inner| NIL) (LETT #1# |outer|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |inner| (CAR #1#)) NIL)
                               (|greater_SI| |innern| #2#))
                           (GO G191)))
                         (SEQ
                          (LETT |r|
                                (SPADCALL |r|
                                          (|LATJOFM;outputVarOrLit| |inner| $)
                                          (QREFELT $ 48)))
                          (EXIT
                           (COND
                            ((SPADCALL |innern| (LENGTH |outer|)
                                       (QREFELT $ 32))
                             (LETT |r|
                                   (SPADCALL |r|
                                             (SPADCALL "/\\" (QREFELT $ 47))
                                             (QREFELT $ 48)))))))
                         (LETT #1#
                               (PROG1 (CDR #1#)
                                 (LETT |innern| (|inc_SI| |innern|))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND
                      ((SPADCALL |outern| (LENGTH |n|) (QREFELT $ 32))
                       (LETT |r|
                             (SPADCALL |r| (SPADCALL ")\\/(" (QREFELT $ 47))
                                       (QREFELT $ 48)))))))
                   (LETT #3#
                         (PROG1 (CDR #3#) (LETT |outern| (|inc_SI| |outern|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |r| (SPADCALL ")" (QREFELT $ 47)) (QREFELT $ 48)))))) 

(SDEFUN |LATJOFM;coerce;$Lmoj;30| ((|n| ($)) ($ (|LatticeMeetOfJoins|)))
        (SPROG
         ((|r| #1=(|LatticeMeetOfJoins|)) (|term| #1#)
          (|ele| (|LatticeMeetOfJoins|)) (#2=#:G956 NIL) (|inner| NIL)
          (#3=#:G957 NIL) (|innern| NIL) (#4=#:G954 NIL) (|outer| NIL)
          (#5=#:G955 NIL) (|outern| NIL))
         (SEQ (LETT |r| (SPADCALL (QREFELT $ 51)))
              (SEQ (LETT |outern| 1) (LETT #5# (LENGTH |n|)) (LETT |outer| NIL)
                   (LETT #4# |n|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |outer| (CAR #4#)) NIL)
                         (|greater_SI| |outern| #5#))
                     (GO G191)))
                   (SEQ (LETT |term| (SPADCALL (QREFELT $ 51)))
                        (SEQ (LETT |innern| 1) (LETT #3# (LENGTH |outer|))
                             (LETT |inner| NIL) (LETT #2# |outer|) G190
                             (COND
                              ((OR (ATOM #2#)
                                   (PROGN (LETT |inner| (CAR #2#)) NIL)
                                   (|greater_SI| |innern| #3#))
                               (GO G191)))
                             (SEQ
                              (LETT |ele| (SPADCALL |inner| (QREFELT $ 52)))
                              (EXIT
                               (LETT |term|
                                     (SPADCALL |term| |ele| (QREFELT $ 53)))))
                             (LETT #2#
                                   (PROG1 (CDR #2#)
                                     (LETT |innern| (|inc_SI| |innern|))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT (LETT |r| (SPADCALL |r| |term| (QREFELT $ 54)))))
                   (LETT #4#
                         (PROG1 (CDR #4#) (LETT |outern| (|inc_SI| |outern|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |LATJOFM;coerce;Lmoj$;31| ((|n1| (|LatticeMeetOfJoins|)) ($ ($)))
        (SPROG
         ((|r| ($)) (|term| ($)) (|ele| ($)) (#1=#:G970 NIL) (|inner| NIL)
          (#2=#:G971 NIL) (|innern| NIL) (#3=#:G968 NIL) (|outer| NIL)
          (#4=#:G969 NIL) (|outern| NIL)
          (|n|
           (|List|
            (|List|
             (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                      (|:| |var| (|Record| (|:| |str| (|String|)))))))))
         (SEQ (LETT |r| (SPADCALL (QREFELT $ 9))) (LETT |n| |n1|)
              (SEQ (LETT |outern| 1) (LETT #4# (LENGTH |n|)) (LETT |outer| NIL)
                   (LETT #3# |n|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |outer| (CAR #3#)) NIL)
                         (|greater_SI| |outern| #4#))
                     (GO G191)))
                   (SEQ (LETT |term| (SPADCALL (QREFELT $ 9)))
                        (SEQ (LETT |innern| 1) (LETT #2# (LENGTH |outer|))
                             (LETT |inner| NIL) (LETT #1# |outer|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |inner| (CAR #1#)) NIL)
                                   (|greater_SI| |innern| #2#))
                               (GO G191)))
                             (SEQ
                              (LETT |ele| (SPADCALL |inner| (QREFELT $ 15)))
                              (EXIT
                               (LETT |term|
                                     (SPADCALL |term| |ele| (QREFELT $ 25)))))
                             (LETT #1#
                                   (PROG1 (CDR #1#)
                                     (LETT |innern| (|inc_SI| |innern|))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT (LETT |r| (SPADCALL |r| |term| (QREFELT $ 23)))))
                   (LETT #3#
                         (PROG1 (CDR #3#) (LETT |outern| (|inc_SI| |outern|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(DECLAIM (NOTINLINE |LatticeJoinOfMeets;|)) 

(DEFUN |LatticeJoinOfMeets| ()
  (SPROG NIL
         (PROG (#1=#:G973)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|LatticeJoinOfMeets|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|LatticeJoinOfMeets|
                             (LIST
                              (CONS NIL (CONS 1 (|LatticeJoinOfMeets;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|LatticeJoinOfMeets|)))))))))) 

(DEFUN |LatticeJoinOfMeets;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|LatticeJoinOfMeets|))
          (LETT $ (GETREFV 59))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LatticeJoinOfMeets| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|List|
                     (|List|
                      (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                               (|:| |var|
                                    (|Record| (|:| |str| (|String|))))))))
          $))) 

(MAKEPROP '|LatticeJoinOfMeets| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| |LATJOFM;logicT;$;2|
              |LATJOFM;logicF;$;3| |LATJOFM;emptyLattice;$;4| (|String|)
              |LATJOFM;variable;S$;5| (|Record| (|:| |val| 35))
              (|Record| (|:| |str| 10))
              (|Union| (|:| |const| 12) (|:| |var| 13))
              |LATJOFM;latticeJoinOfMeets;U$;6| (|Boolean|)
              |LATJOFM;empty?;$B;7| (|List| 14) (0 . |concat|) (|List| 18)
              (6 . |concat|) |LATJOFM;redux;2$;16| |LATJOFM;/\\;3$;8|
              (12 . |concat|) |LATJOFM;\\/;3$;9| (|List| $)
              |LATJOFM;meet;L$;10| |LATJOFM;join;L$;11| (18 . =)
              (24 . |concat|) (|NonNegativeInteger|) (30 . ~=)
              |LATJOFM;factor;$L;17| |LATJOFM;deductions;2L;19| (|Symbol|)
              |LATJOFM;opType;$S;20| |LATJOFM;atom?;$B;21|
              |LATJOFM;value;$S;22| |LATJOFM;getChildren;$L;23|
              |LATJOFM;=;2$B;24| |LATJOFM;toStringUnwrapped;$S;27|
              (36 . |concat|) |LATJOFM;toString;$S;25| (|OutputForm|)
              (41 . |coerce|) (46 . |coerce|) (51 . |message|) (56 . |hconcat|)
              |LATJOFM;coerce;$Of;29| (|LatticeMeetOfJoins|)
              (62 . |emptyLattice|) (66 . |latticeMeetOfJoins|) (71 . |/\\|)
              (77 . |\\/|) |LATJOFM;coerce;$Lmoj;30| |LATJOFM;coerce;Lmoj$;31|
              (|HashState|) (|SingleInteger|))
           '#(~= 83 |variable| 89 |value| 94 |toStringUnwrapped| 99 |toString|
              104 |redux| 109 |opType| 114 |meet| 119 |logicT| 124 |logicF| 128
              |latticeJoinOfMeets| 132 |latex| 137 |join| 142 |hashUpdate!| 147
              |hash| 153 |getChildren| 158 |factor| 163 |emptyLattice| 168
              |empty?| 172 |deductions| 177 |coerce| 182 |atom?| 197 |_\|_| 202
              |\\/| 206 T$ 212 = 216 |/\\| 222)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL NIL NIL NIL NIL NIL NIL NIL |SetCategory&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|BoundedDistributiveLattice|) (|BoundedLattice|)
                      (|DistributiveLattice|) (|BoundedMeetSemilattice|)
                      (|Lattice|) (|BoundedJoinSemilattice|)
                      (|MeetSemilattice|) (|JoinSemilattice|) (|SetCategory|)
                      (|BasicType|) (|CoercibleTo| 44))
                   (|makeByteWordVec2| 58
                                       '(2 18 0 0 0 19 2 20 0 0 18 21 2 20 0 0
                                         0 24 2 14 16 0 0 29 2 18 0 0 14 30 2
                                         31 16 0 0 32 1 10 0 26 42 1 10 44 0 45
                                         1 35 44 0 46 1 44 0 10 47 2 44 0 0 0
                                         48 0 50 0 51 1 50 0 14 52 2 50 0 0 0
                                         53 2 50 0 0 0 54 2 0 16 0 0 1 1 0 0 10
                                         11 1 0 35 0 38 1 0 10 0 41 1 0 10 0 43
                                         1 0 0 0 22 1 0 35 0 36 1 0 0 26 27 0 0
                                         0 7 0 0 0 8 1 0 0 14 15 1 0 10 0 1 1 0
                                         0 26 28 2 0 57 57 0 1 1 0 58 0 1 1 0
                                         26 0 39 1 0 26 0 33 0 0 0 9 1 0 16 0
                                         17 1 0 26 26 34 1 0 0 50 56 1 0 50 0
                                         55 1 0 44 0 49 1 0 16 0 37 0 0 0 1 2 0
                                         0 0 0 25 0 0 0 1 2 0 16 0 0 40 2 0 0 0
                                         0 23)))))
           '|lookupComplete|)) 

(MAKEPROP '|LatticeJoinOfMeets| 'NILADIC T) 
