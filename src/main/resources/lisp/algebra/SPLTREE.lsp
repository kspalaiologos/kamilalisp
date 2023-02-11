
(PUT '|SPLTREE;rep| '|SPADreplace| '(XLAM (|n|) |n|)) 

(SDEFUN |SPLTREE;rep|
        ((|n| ($))
         ($
          (|Record| (|:| |root| (|SplittingNode| V C))
                    (|:| |subTrees| (|List| $)))))
        |n|) 

(PUT '|SPLTREE;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |SPLTREE;per|
        ((|r|
          (|Record| (|:| |root| (|SplittingNode| V C))
                    (|:| |subTrees| (|List| $))))
         ($ ($)))
        |r|) 

(SDEFUN |SPLTREE;construct;Sn$;3| ((|s| (|SplittingNode| V C)) ($ ($)))
        (|SPLTREE;per| (CONS |s| NIL) $)) 

(SDEFUN |SPLTREE;construct;VCL$;4|
        ((|v| (V)) (|t| (C)) (|la| (|List| $)) ($ ($)))
        (|SPLTREE;per| (CONS (SPADCALL |v| |t| (QREFELT $ 10)) |la|) $)) 

(SDEFUN |SPLTREE;construct;VCL$;5|
        ((|v| (V)) (|t| (C)) (|ls| (|List| (|SplittingNode| V C))) ($ ($)))
        (SPROG ((#1=#:G759 NIL) (|s| NIL) (#2=#:G758 NIL))
               (SEQ
                (|SPLTREE;per|
                 (CONS (SPADCALL |v| |t| (QREFELT $ 10))
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |s| NIL) (LETT #1# |ls|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS (SPADCALL |s| (QREFELT $ 9)) #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#)))))
                 $)))) 

(SDEFUN |SPLTREE;construct;VCVL$;6|
        ((|v1| (V)) (|t| (C)) (|v2| (V)) (|lt| (|List| C)) ($ ($)))
        (SPADCALL |v1| |t| (SPADCALL |v2| |lt| (QREFELT $ 16)) (QREFELT $ 14))) 

(SDEFUN |SPLTREE;empty?;$B;7| ((|a| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCAR (|SPLTREE;rep| |a| $)) (QREFELT $ 19))
          (SPADCALL (QCDR (|SPLTREE;rep| |a| $)) (QREFELT $ 21)))
         ('T NIL))) 

(SDEFUN |SPLTREE;empty;$;8| (($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) (QREFELT $ 9))) 

(SDEFUN |SPLTREE;remove;Sn2$;9| ((|s| (|SplittingNode| V C)) (|a| ($)) ($ ($)))
        (SPROG ((|lb| (|List| $)) (|la| (|List| $)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) |a|)
                      ('T
                       (SEQ
                        (COND
                         ((SPADCALL |s| (SPADCALL |a| (QREFELT $ 25))
                                    (QREFELT $ 26))
                          (COND
                           ((|BooleanEquality| (SPADCALL |s| (QREFELT $ 27))
                                               (SPADCALL
                                                (SPADCALL |a| (QREFELT $ 25))
                                                (QREFELT $ 27)))
                            (EXIT (SPADCALL (QREFELT $ 24)))))))
                        (LETT |la| (SPADCALL |a| (QREFELT $ 28)))
                        (LETT |lb| NIL)
                        (SEQ G190
                             (COND
                              ((NULL (NULL (SPADCALL |la| (QREFELT $ 21))))
                               (GO G191)))
                             (SEQ
                              (LETT |lb|
                                    (SPADCALL
                                     (SPADCALL |s|
                                               (SPADCALL |la| (QREFELT $ 29))
                                               (QREFELT $ 30))
                                     |lb| (QREFELT $ 31)))
                              (EXIT
                               (LETT |la| (SPADCALL |la| (QREFELT $ 32)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (LETT |lb|
                              (SPADCALL
                               (SPADCALL (ELT $ 22) |lb| (QREFELT $ 34))
                               (QREFELT $ 35)))
                        (EXIT
                         (SPADCALL
                          (SPADCALL (SPADCALL |a| (QREFELT $ 25))
                                    (QREFELT $ 36))
                          (SPADCALL (SPADCALL |a| (QREFELT $ 25))
                                    (QREFELT $ 37))
                          |lb| (QREFELT $ 12))))))))) 

(SDEFUN |SPLTREE;remove!;Sn2$;10|
        ((|s| (|SplittingNode| V C)) (|a| ($)) ($ ($)))
        (SPROG ((|lb| (|List| $)) (|la| (|List| $)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) |a|)
                      ('T
                       (SEQ
                        (COND
                         ((SPADCALL |s| (SPADCALL |a| (QREFELT $ 25))
                                    (QREFELT $ 26))
                          (COND
                           ((|BooleanEquality| (SPADCALL |s| (QREFELT $ 27))
                                               (SPADCALL
                                                (SPADCALL |a| (QREFELT $ 25))
                                                (QREFELT $ 27)))
                            (EXIT
                             (SEQ
                              (PROGN
                               (RPLACA #1=(|SPLTREE;rep| |a| $)
                                       (SPADCALL (QREFELT $ 23)))
                               (QCAR #1#))
                              (PROGN
                               (RPLACD #2=(|SPLTREE;rep| |a| $) NIL)
                               (QCDR #2#))
                              (EXIT |a|)))))))
                        (LETT |la| (SPADCALL |a| (QREFELT $ 28)))
                        (LETT |lb| NIL)
                        (SEQ G190
                             (COND
                              ((NULL (NULL (SPADCALL |la| (QREFELT $ 21))))
                               (GO G191)))
                             (SEQ
                              (LETT |lb|
                                    (SPADCALL
                                     (SPADCALL |s|
                                               (SPADCALL |la| (QREFELT $ 29))
                                               (QREFELT $ 38))
                                     |lb| (QREFELT $ 31)))
                              (EXIT
                               (LETT |la| (SPADCALL |la| (QREFELT $ 32)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (LETT |lb|
                              (SPADCALL
                               (SPADCALL (SPADCALL (QREFELT $ 24)) |lb|
                                         (QREFELT $ 39))
                               (QREFELT $ 35)))
                        (EXIT (SPADCALL |a| |lb| (QREFELT $ 40))))))))) 

(SDEFUN |SPLTREE;value;$Sn;11| ((|a| ($)) ($ (|SplittingNode| V C)))
        (QCAR (|SPLTREE;rep| |a| $))) 

(SDEFUN |SPLTREE;children;$L;12| ((|a| ($)) ($ (|List| $)))
        (QCDR (|SPLTREE;rep| |a| $))) 

(SDEFUN |SPLTREE;leaf?;$B;13| ((|a| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
              ('T (SPADCALL (QCDR (|SPLTREE;rep| |a| $)) (QREFELT $ 21))))) 

(SDEFUN |SPLTREE;setchildren!;$L$;14| ((|a| ($)) (|la| (|List| $)) ($ ($)))
        (SEQ (PROGN (RPLACD #1=(|SPLTREE;rep| |a| $) |la|) (QCDR #1#))
             (EXIT |a|))) 

(SDEFUN |SPLTREE;setvalue!;$2Sn;15|
        ((|a| ($)) (|s| #1=(|SplittingNode| V C)) ($ #1#))
        (SEQ (PROGN (RPLACA #2=(|SPLTREE;rep| |a| $) |s|) (QCAR #2#))
             (EXIT |s|))) 

(PUT '|SPLTREE;cyclic?;$B;16| '|SPADreplace| '(XLAM (|a|) NIL)) 

(SDEFUN |SPLTREE;cyclic?;$B;16| ((|a| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |SPLTREE;map;M2$;17|
        ((|foo| (|Mapping| #1=(|SplittingNode| V C) #1#)) (|a| ($)) ($ ($)))
        (SPROG ((#2=#:G803 NIL) (|c| NIL) (#3=#:G802 NIL) (|b| ($)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) |a|)
                      (#4='T
                       (SEQ
                        (LETT |b|
                              (SPADCALL
                               (SPADCALL (SPADCALL |a| (QREFELT $ 25)) |foo|)
                               (QREFELT $ 9)))
                        (EXIT
                         (COND ((SPADCALL |a| (QREFELT $ 41)) |b|)
                               (#4#
                                (SPADCALL |b|
                                          (PROGN
                                           (LETT #3# NIL)
                                           (SEQ (LETT |c| NIL)
                                                (LETT #2#
                                                      (SPADCALL |a|
                                                                (QREFELT $
                                                                         28)))
                                                G190
                                                (COND
                                                 ((OR (ATOM #2#)
                                                      (PROGN
                                                       (LETT |c| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #3#
                                                        (CONS
                                                         (SPADCALL |foo| |c|
                                                                   (QREFELT $
                                                                            45))
                                                         #3#))))
                                                (LETT #2# (CDR #2#)) (GO G190)
                                                G191 (EXIT (NREVERSE #3#))))
                                          (QREFELT $ 40))))))))))) 

(SDEFUN |SPLTREE;map!;M2$;18|
        ((|foo| (|Mapping| #1=(|SplittingNode| V C) #1#)) (|a| ($)) ($ ($)))
        (SPROG ((#2=#:G811 NIL) (|c| NIL) (#3=#:G810 NIL))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) |a|)
                      (#4='T
                       (SEQ
                        (SPADCALL |a|
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 25))
                                            |foo|)
                                  (QREFELT $ 42))
                        (EXIT
                         (COND ((SPADCALL |a| (QREFELT $ 41)) |a|)
                               (#4#
                                (SPADCALL |a|
                                          (PROGN
                                           (LETT #3# NIL)
                                           (SEQ (LETT |c| NIL)
                                                (LETT #2#
                                                      (SPADCALL |a|
                                                                (QREFELT $
                                                                         28)))
                                                G190
                                                (COND
                                                 ((OR (ATOM #2#)
                                                      (PROGN
                                                       (LETT |c| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #3#
                                                        (CONS
                                                         (SPADCALL |foo| |c|
                                                                   (QREFELT $
                                                                            46))
                                                         #3#))))
                                                (LETT #2# (CDR #2#)) (GO G190)
                                                G191 (EXIT (NREVERSE #3#))))
                                          (QREFELT $ 40))))))))))) 

(SDEFUN |SPLTREE;copy;2$;19| ((|a| ($)) ($ ($)))
        (SPADCALL (ELT $ 47) |a| (QREFELT $ 45))) 

(PUT '|SPLTREE;eq?;2$B;20| '|SPADreplace|
     '(XLAM (|a1| |a2|) (|error| "in eq? from SPLTREE : unimplemented"))) 

(SDEFUN |SPLTREE;eq?;2$B;20| ((|a1| ($)) (|a2| ($)) ($ (|Boolean|)))
        (|error| "in eq? from SPLTREE : unimplemented")) 

(SDEFUN |SPLTREE;nodes;$L;21| ((|a| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G829 NIL) (|c| NIL) (#2=#:G828 NIL))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                      ((SPADCALL |a| (QREFELT $ 41)) (LIST |a|))
                      ('T
                       (SPADCALL |a|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |c| NIL)
                                        (LETT #1#
                                              (SPADCALL |a| (QREFELT $ 28)))
                                        G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |c| (CAR #1#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL |c| (QREFELT $ 50))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#))))
                                  (QREFELT $ 51))
                                 (QREFELT $ 31))))))) 

(SDEFUN |SPLTREE;leaves;$L;22| ((|a| ($)) ($ (|List| (|SplittingNode| V C))))
        (SPROG ((#1=#:G836 NIL) (|c| NIL) (#2=#:G835 NIL))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                      ((SPADCALL |a| (QREFELT $ 41))
                       (LIST (SPADCALL |a| (QREFELT $ 25))))
                      ('T
                       (SPADCALL
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |c| NIL)
                              (LETT #1# (SPADCALL |a| (QREFELT $ 28))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |c| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |c| (QREFELT $ 52))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QREFELT $ 53))))))) 

(SDEFUN |SPLTREE;members;$L;23| ((|a| ($)) ($ (|List| (|SplittingNode| V C))))
        (SPROG ((#1=#:G843 NIL) (|c| NIL) (#2=#:G842 NIL))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                      ((SPADCALL |a| (QREFELT $ 41))
                       (LIST (SPADCALL |a| (QREFELT $ 25))))
                      ('T
                       (CONS (SPADCALL |a| (QREFELT $ 25))
                             (SPADCALL
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |c| NIL)
                                    (LETT #1# (SPADCALL |a| (QREFELT $ 28)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |c| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS (SPADCALL |c| (QREFELT $ 54))
                                                  #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 53)))))))) 

(SDEFUN |SPLTREE;#;$Nni;24| ((|a| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G853 NIL) (|c| NIL) (#2=#:G852 NIL))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) 0)
                      ((SPADCALL |a| (QREFELT $ 41)) 1)
                      ('T
                       (SPADCALL (ELT $ 56)
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |c| NIL)
                                       (LETT #1# (SPADCALL |a| (QREFELT $ 28)))
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |c| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL |c| (QREFELT $ 57))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#))))
                                 1 (QREFELT $ 60))))))) 

(SDEFUN |SPLTREE;=;2$B;25| ((|a1| ($)) (|a2| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |a1| (QREFELT $ 22)) (SPADCALL |a2| (QREFELT $ 22)))
              ((SPADCALL |a2| (QREFELT $ 22)) NIL)
              ((SPADCALL |a1| (QREFELT $ 41))
               (COND ((NULL (SPADCALL |a2| (QREFELT $ 41))) NIL)
                     ('T
                      (SPADCALL (SPADCALL |a1| (QREFELT $ 25))
                                (SPADCALL |a2| (QREFELT $ 25))
                                (QREFELT $ 26)))))
              ((OR (SPADCALL |a2| (QREFELT $ 41))
                   (SPADCALL (SPADCALL |a1| (QREFELT $ 25))
                             (SPADCALL |a2| (QREFELT $ 25)) (QREFELT $ 61)))
               NIL)
              ('T
               (SPADCALL (SPADCALL |a1| (QREFELT $ 28))
                         (SPADCALL |a2| (QREFELT $ 28)) (QREFELT $ 62))))) 

(SDEFUN |SPLTREE;localCoerce|
        ((|a| ($)) (|k| (|NonNegativeInteger|)) ($ (|OutputForm|)))
        (SPROG
         ((|lo| (|List| (|OutputForm|))) (#1=#:G875 NIL) (|c| NIL)
          (#2=#:G874 NIL) (|ro| (|OutputForm|)) (|s| (|String|))
          (#3=#:G873 NIL) (|i| NIL))
         (SEQ (COND ((EQL |k| 1) (LETT |s| "* ")) (#4='T (LETT |s| "-> ")))
              (SEQ (LETT |i| 2) (LETT #3# |k|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (EXIT (LETT |s| (STRCONC "-+" |s|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |ro|
                    (SPADCALL
                     (SPADCALL (SPADCALL |s| (QREFELT $ 66))
                               (SPADCALL (SPADCALL |a| (QREFELT $ 25))
                                         (QREFELT $ 67))
                               (QREFELT $ 68))
                     (QREFELT $ 69)))
              (EXIT
               (COND ((SPADCALL |a| (QREFELT $ 41)) |ro|)
                     (#4#
                      (SEQ
                       (LETT |lo|
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |c| NIL)
                                   (LETT #1# (SPADCALL |a| (QREFELT $ 28)))
                                   G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |c| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (|SPLTREE;localCoerce| |c|
                                             (+ |k| 1) $)
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                       (LETT |lo| (CONS |ro| |lo|))
                       (EXIT (SPADCALL |lo| (QREFELT $ 70)))))))))) 

(SDEFUN |SPLTREE;coerce;$Of;27| ((|a| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |a| (QREFELT $ 22))
          (SPADCALL (SPADCALL " " (QREFELT $ 66))
                    (SPADCALL "* []" (QREFELT $ 66)) (QREFELT $ 71)))
         ('T
          (SPADCALL (SPADCALL " " (QREFELT $ 66))
                    (|SPLTREE;localCoerce| |a| 1 $) (QREFELT $ 71))))) 

(SDEFUN |SPLTREE;extractSplittingLeaf;$U;28|
        ((|a| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|la| (|List| $)) (#2=#:G890 NIL) (|esl| (|Union| $ #1#)))
               (SEQ
                (EXIT
                 (COND
                  ((OR (SPADCALL |a| (QREFELT $ 22))
                       (SPADCALL (SPADCALL |a| (QREFELT $ 25)) (QREFELT $ 27)))
                   (CONS 1 "failed"))
                  ('T
                   (SEQ (LETT |la| (SPADCALL |a| (QREFELT $ 28)))
                        (EXIT
                         (COND ((SPADCALL |la| (QREFELT $ 21)) (CONS 0 |a|))
                               ('T
                                (SEQ
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (NULL (SPADCALL |la| (QREFELT $ 21))))
                                        (GO G191)))
                                      (SEQ
                                       (LETT |esl|
                                             (SPADCALL
                                              (SPADCALL |la| (QREFELT $ 29))
                                              (QREFELT $ 74)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |esl| 0)
                                          (PROGN
                                           (LETT #2# |esl|)
                                           (GO #3=#:G889)))
                                         ('T
                                          (LETT |la|
                                                (SPADCALL |la|
                                                          (QREFELT $ 32)))))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT (CONS 1 "failed"))))))))))
                #3# (EXIT #2#)))) 

(SDEFUN |SPLTREE;updateStatus!;2$;29| ((|a| ($)) ($ ($)))
        (SPROG ((|la| (|List| $)) (|done| (|Boolean|)))
               (SEQ (LETT |la| (SPADCALL |a| (QREFELT $ 28)))
                    (COND
                     ((OR (SPADCALL |la| (QREFELT $ 21))
                          (SPADCALL (SPADCALL |a| (QREFELT $ 25))
                                    (QREFELT $ 27)))
                      (EXIT |a|)))
                    (LETT |done| 'T)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((SPADCALL |la| (QREFELT $ 21)) NIL)
                                  ('T |done|)))
                           (GO G191)))
                         (SEQ
                          (LETT |done|
                                (COND
                                 (|done|
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |la| (QREFELT $ 29))
                                              (QREFELT $ 75))
                                    (QREFELT $ 25))
                                   (QREFELT $ 27)))
                                 ('T NIL)))
                          (EXIT (LETT |la| (SPADCALL |la| (QREFELT $ 32)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (SPADCALL (SPADCALL |a| (QREFELT $ 25)) |done|
                              (QREFELT $ 76))
                    (EXIT |a|)))) 

(SDEFUN |SPLTREE;result;$L;30|
        ((|a| ($)) ($ (|List| (|Record| (|:| |val| V) (|:| |tower| C)))))
        (SPROG
         ((#1=#:G909 NIL) (|s| NIL) (#2=#:G908 NIL)
          (|ls| (|List| (|SplittingNode| V C))))
         (SEQ
          (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                ((NULL (SPADCALL (SPADCALL |a| (QREFELT $ 25)) (QREFELT $ 27)))
                 (|error| "in result from SLPTREE : mad cow!"))
                ('T
                 (SEQ (LETT |ls| (SPADCALL |a| (QREFELT $ 52)))
                      (EXIT
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |s| NIL) (LETT #1# |ls|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (CONS (SPADCALL |s| (QREFELT $ 36))
                                            (SPADCALL |s| (QREFELT $ 37)))
                                      #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |SPLTREE;conditions;$L;31| ((|a| ($)) ($ (|List| C)))
        (SPROG
         ((#1=#:G916 NIL) (|s| NIL) (#2=#:G915 NIL)
          (|ls| (|List| (|SplittingNode| V C))))
         (SEQ
          (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                ('T
                 (SEQ (LETT |ls| (SPADCALL |a| (QREFELT $ 52)))
                      (EXIT
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |s| NIL) (LETT #1# |ls|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS (SPADCALL |s| (QREFELT $ 37))
                                           #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |SPLTREE;nodeOf?;Sn$B;32|
        ((|s| (|SplittingNode| V C)) (|a| ($)) ($ (|Boolean|)))
        (SPROG ((|la| (|List| $)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                      ((SPADCALL |s| (SPADCALL |a| (QREFELT $ 25))
                                 (QREFELT $ 26))
                       'T)
                      ('T
                       (SEQ (LETT |la| (SPADCALL |a| (QREFELT $ 28)))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((SPADCALL |la| (QREFELT $ 21)) NIL)
                                          ('T
                                           (NULL
                                            (SPADCALL |s|
                                                      (SPADCALL |la|
                                                                (QREFELT $ 29))
                                                      (QREFELT $ 81))))))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |la| (SPADCALL |la| (QREFELT $ 32)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (NULL (SPADCALL |la| (QREFELT $ 21)))))))))) 

(SDEFUN |SPLTREE;subNodeOf?;Sn$MB;33|
        ((|s| (|SplittingNode| V C)) (|a| ($))
         (|sub?| (|Mapping| (|Boolean|) C C)) ($ (|Boolean|)))
        (SPROG ((|la| (|List| $)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 22)) NIL)
                      ('T
                       (SEQ
                        (COND
                         ((SPADCALL (SPADCALL |a| (QREFELT $ 25))
                                    (QREFELT $ 27))
                          (COND
                           ((SPADCALL |s| (SPADCALL |a| (QREFELT $ 25)) |sub?|
                                      (QREFELT $ 83))
                            (EXIT 'T)))))
                        (LETT |la| (SPADCALL |a| (QREFELT $ 28)))
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((SPADCALL |la| (QREFELT $ 21)) NIL)
                                      ('T
                                       (NULL
                                        (SPADCALL |s|
                                                  (SPADCALL |la|
                                                            (QREFELT $ 29))
                                                  |sub?| (QREFELT $ 84))))))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |la| (SPADCALL |la| (QREFELT $ 32)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT (NULL (SPADCALL |la| (QREFELT $ 21)))))))))) 

(SDEFUN |SPLTREE;splitNodeOf!;2$L$;34|
        ((|l| ($)) (|a| ($)) (|ls| (|List| (|SplittingNode| V C))) ($ ($)))
        (SPROG ((|la| (|List| $)) (|ln| (|List| (|SplittingNode| V C))))
               (SEQ (LETT |ln| (SPADCALL |ls| (QREFELT $ 85))) (LETT |la| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |ln|))) (GO G191)))
                         (SEQ
                          (COND
                           ((NULL
                             (SPADCALL (|SPADfirst| |ln|) |a| (QREFELT $ 81)))
                            (LETT |la|
                                  (SPADCALL
                                   (SPADCALL (|SPADfirst| |ln|) (QREFELT $ 9))
                                   |la| (QREFELT $ 31)))))
                          (EXIT (LETT |ln| (CDR |ln|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |la| (SPADCALL |la| (QREFELT $ 35)))
                    (SPADCALL |l| |la| (QREFELT $ 40))
                    (COND
                     ((SPADCALL |la| (QREFELT $ 21))
                      (PROGN
                       (RPLACA #1=(|SPLTREE;rep| |l| $)
                               (SPADCALL (SPADCALL (QREFELT $ 86))
                                         (SPADCALL (QREFELT $ 87)) 'T
                                         (QREFELT $ 88)))
                       (QCAR #1#))))
                    (EXIT (SPADCALL |a| (QREFELT $ 75)))))) 

(SDEFUN |SPLTREE;splitNodeOf!;2$LM$;35|
        ((|l| ($)) (|a| ($)) (|ls| (|List| (|SplittingNode| V C)))
         (|sub?| (|Mapping| (|Boolean|) C C)) ($ ($)))
        (SPROG ((|la| (|List| $)) (|ln| (|List| (|SplittingNode| V C))))
               (SEQ (LETT |ln| (SPADCALL |ls| (QREFELT $ 85))) (LETT |la| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |ln|))) (GO G191)))
                         (SEQ
                          (COND
                           ((NULL
                             (SPADCALL (|SPADfirst| |ln|) |a| |sub?|
                                       (QREFELT $ 84)))
                            (LETT |la|
                                  (SPADCALL
                                   (SPADCALL (|SPADfirst| |ln|) (QREFELT $ 9))
                                   |la| (QREFELT $ 31)))))
                          (EXIT (LETT |ln| (CDR |ln|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |la| (SPADCALL |la| (QREFELT $ 35)))
                    (SPADCALL |l| |la| (QREFELT $ 40))
                    (COND
                     ((SPADCALL |la| (QREFELT $ 21))
                      (PROGN
                       (RPLACA #1=(|SPLTREE;rep| |l| $)
                               (SPADCALL (SPADCALL (QREFELT $ 86))
                                         (SPADCALL (QREFELT $ 87)) 'T
                                         (QREFELT $ 88)))
                       (QCAR #1#))))
                    (EXIT (SPADCALL |a| (QREFELT $ 75)))))) 

(DECLAIM (NOTINLINE |SplittingTree;|)) 

(DEFUN |SplittingTree| (&REST #1=#:G961)
  (SPROG NIL
         (PROG (#2=#:G962)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SplittingTree|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SplittingTree;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SplittingTree|)))))))))) 

(DEFUN |SplittingTree;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G958 NIL) (#2=#:G959 NIL) (#3=#:G960 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|SplittingTree| DV$1 DV$2))
    (LETT $ (GETREFV 99))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #3#
                                              (|HasCategory|
                                               (|SplittingNode| |#1| |#2|)
                                               '(|SetCategory|)))
                                        (AND
                                         (|HasCategory|
                                          (|SplittingNode| |#1| |#2|)
                                          (LIST '|Evalable|
                                                (LIST '|SplittingNode|
                                                      (|devaluate| |#1|)
                                                      (|devaluate| |#2|))))
                                         #3#)
                                        (|HasCategory|
                                         (|SplittingNode| |#1| |#2|)
                                         '(|OrderedSet|))
                                        (LETT #2#
                                              (|HasCategory|
                                               (|SplittingNode| |#1| |#2|)
                                               '(|BasicType|)))
                                        (OR #2# #3#)
                                        (LETT #1#
                                              (|HasCategory|
                                               (|SplittingNode| |#1| |#2|)
                                               '(|CoercibleTo|
                                                 (|OutputForm|))))
                                        (OR #1#
                                            (AND
                                             (|HasCategory|
                                              (|SplittingNode| |#1| |#2|)
                                              (LIST '|Evalable|
                                                    (LIST '|SplittingNode|
                                                          (|devaluate| |#1|)
                                                          (|devaluate| |#2|))))
                                             #3#))))))
    (|haddProp| |$ConstructorCache| '|SplittingTree| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 128))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| (|SplittingNode| |#1| |#2|) '(|OrderedSet|))
         (|augmentPredVector| $ 256))
    (AND (|HasCategory| $ '(|finiteAggregate|)) #2#
         (|augmentPredVector| $ 512))
    (AND (OR (AND (|HasCategory| $ '(|finiteAggregate|)) #2#) #3#)
         (|augmentPredVector| $ 1024))
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 2048))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|SplittingTree| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SplittingNode| 6 7) |SPLTREE;construct;Sn$;3| (0 . |construct|)
              (|List| $) |SPLTREE;construct;VCL$;4| (|List| 8)
              |SPLTREE;construct;VCL$;5| (|List| 7) (6 . |construct|)
              |SPLTREE;construct;VCVL$;6| (|Boolean|) (12 . |empty?|)
              (|List| $$) (17 . |empty?|) |SPLTREE;empty?;$B;7| (22 . |empty|)
              |SPLTREE;empty;$;8| |SPLTREE;value;$Sn;11| (26 . =)
              (32 . |status|) |SPLTREE;children;$L;12| (37 . |first|)
              |SPLTREE;remove;Sn2$;9| (42 . |cons|) (48 . |rest|)
              (|Mapping| 18 $$) (53 . |remove|) (59 . |reverse|) (64 . |value|)
              (69 . |condition|) |SPLTREE;remove!;Sn2$;10| (74 . |remove|)
              |SPLTREE;setchildren!;$L$;14| |SPLTREE;leaf?;$B;13|
              |SPLTREE;setvalue!;$2Sn;15| |SPLTREE;cyclic?;$B;16|
              (|Mapping| 8 8) |SPLTREE;map;M2$;17| |SPLTREE;map!;M2$;18|
              (80 . |copy|) |SPLTREE;copy;2$;19| |SPLTREE;eq?;2$B;20|
              |SPLTREE;nodes;$L;21| (85 . |concat|) |SPLTREE;leaves;$L;22|
              (90 . |concat|) |SPLTREE;members;$L;23| (|NonNegativeInteger|)
              (95 . +) |SPLTREE;#;$Nni;24| (|Mapping| 55 55 55) (|List| 55)
              (101 . |reduce|) (108 . ~=) (114 . =) |SPLTREE;=;2$B;25|
              (|String|) (|OutputForm|) (120 . |message|) (125 . |coerce|)
              (130 . |hconcat|) (136 . |left|) (141 . |vconcat|)
              (146 . |vconcat|) |SPLTREE;coerce;$Of;27| (|Union| $ '"failed")
              |SPLTREE;extractSplittingLeaf;$U;28|
              |SPLTREE;updateStatus!;2$;29| (152 . |setStatus!|)
              (|Record| (|:| |val| 6) (|:| |tower| 7)) (|List| 77)
              |SPLTREE;result;$L;30| |SPLTREE;conditions;$L;31|
              |SPLTREE;nodeOf?;Sn$B;32| (|Mapping| 18 7 7) (158 . |subNode?|)
              |SPLTREE;subNodeOf?;Sn$MB;33| (165 . |removeDuplicates|)
              (170 . |empty|) (174 . |empty|) (178 . |construct|)
              |SPLTREE;splitNodeOf!;2$L$;34| |SPLTREE;splitNodeOf!;2$LM$;35|
              (|Equation| 8) (|List| 91) (|HashState|) (|SingleInteger|)
              (|Mapping| 18 8 8) (|Mapping| 18 8) '"value" (|Integer|))
           '#(~= 185 |value| 191 |updateStatus!| 196 |subNodeOf?| 201
              |splitNodeOf!| 208 |size?| 223 |setvalue!| 229 |setelt!| 235
              |setchildren!| 242 |sample| 248 |result| 252 |remove!| 257
              |remove| 263 |parts| 269 |nodes| 274 |nodeOf?| 279 |node?| 285
              |more?| 291 |min| 297 |members| 302 |member?| 307 |max| 313
              |map!| 324 |map| 330 |less?| 336 |leaves| 342 |leaf?| 347 |latex|
              352 |hashUpdate!| 357 |hash| 363 |extractSplittingLeaf| 368
              |every?| 373 |eval| 379 |eq?| 405 |empty?| 411 |empty| 416 |elt|
              420 |distance| 426 |cyclic?| 432 |count| 437 |copy| 449
              |construct| 454 |conditions| 481 |coerce| 486 |children| 491
              |child?| 496 |any?| 502 = 508 |#| 514)
           'NIL
           (CONS (|makeByteWordVec2| 7 '(0 0 0 2 1 0 0 0 2 5 7))
                 (CONS
                  '#(|RecursiveAggregate&| |HomogeneousAggregate&| |Aggregate&|
                     |Evalable&| |SetCategory&| NIL NIL NIL |InnerEvalable&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|RecursiveAggregate| (|SplittingNode| 6 7))
                      (|HomogeneousAggregate| (|SplittingNode| 6 7))
                      (|Aggregate|) (|Evalable| (|SplittingNode| 6 7))
                      (|SetCategory|) (|Type|) (|finiteAggregate|)
                      (|shallowlyMutable|)
                      (|InnerEvalable| (|SplittingNode| 6 7)
                                       (|SplittingNode| 6 7))
                      (|BasicType|) (|CoercibleTo| 65))
                   (|makeByteWordVec2| 98
                                       '(2 8 0 6 7 10 2 8 11 6 15 16 1 8 18 0
                                         19 1 20 18 0 21 0 8 0 23 2 8 18 0 0 26
                                         1 8 18 0 27 1 20 2 0 29 2 20 0 2 0 31
                                         1 20 0 0 32 2 20 0 33 0 34 1 20 0 0 35
                                         1 8 6 0 36 1 8 7 0 37 2 20 0 2 0 39 1
                                         8 0 0 47 1 20 0 11 51 1 13 0 11 53 2
                                         55 0 0 0 56 3 59 55 58 0 55 60 2 8 18
                                         0 0 61 2 20 18 0 0 62 1 65 0 64 66 1 8
                                         65 0 67 2 65 0 0 0 68 1 65 0 0 69 1 65
                                         0 11 70 2 65 0 0 0 71 2 8 0 0 18 76 3
                                         8 18 0 0 82 83 1 13 0 0 85 0 6 0 86 0
                                         7 0 87 3 8 0 6 7 18 88 2 11 18 0 0 1 1
                                         0 8 0 25 1 0 0 0 75 3 0 18 8 0 82 84 4
                                         0 0 0 0 13 82 90 3 0 0 0 0 13 89 2 0
                                         18 0 55 1 2 12 8 0 8 42 3 12 8 0 97 8
                                         1 2 12 0 0 11 40 0 0 0 1 1 0 78 0 79 2
                                         0 0 8 0 38 2 0 0 8 0 30 1 8 13 0 1 1 0
                                         11 0 50 2 0 18 8 0 81 2 4 18 0 0 1 2 0
                                         18 0 55 1 1 9 8 0 1 1 8 13 0 54 2 10
                                         18 8 0 1 1 9 8 0 1 2 8 8 95 0 1 2 12 0
                                         44 0 46 2 0 0 44 0 45 2 0 18 0 55 1 1
                                         0 13 0 52 1 0 18 0 41 1 1 64 0 1 2 1
                                         93 93 0 1 1 1 94 0 1 1 0 73 0 74 2 8
                                         18 96 0 1 3 2 0 0 13 13 1 2 2 0 0 91 1
                                         3 2 0 0 8 8 1 2 2 0 0 92 1 2 0 18 0 0
                                         49 1 0 18 0 22 0 0 0 24 2 0 8 0 97 1 2
                                         0 98 0 0 1 1 0 18 0 43 2 10 55 8 0 1 2
                                         8 55 96 0 1 1 0 0 0 48 3 0 0 6 7 13 14
                                         4 0 0 6 7 6 15 17 1 0 0 8 9 3 0 0 6 7
                                         11 12 1 0 15 0 80 1 6 65 0 72 1 0 11 0
                                         28 2 4 18 0 0 1 2 8 18 96 0 1 2 11 18
                                         0 0 63 1 8 55 0 57)))))
           '|lookupComplete|)) 
