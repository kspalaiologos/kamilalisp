
(SDEFUN |POSET-;addObject!;ASA;1| ((|s| (A)) (|n| (S)) ($ (A)))
        (SPROG
         ((|arrows| (|List| (|List| (|Boolean|))))
          (|emptyRow| (|List| (|Boolean|))) (#1=#:G770 NIL) (|x| NIL)
          (#2=#:G769 NIL) (|a| (|List| (|Boolean|))) (#3=#:G768 NIL)
          (|diff| (|NonNegativeInteger|)) (#4=#:G750 NIL)
          (|padding| (|Union| (|NonNegativeInteger|) "failed"))
          (|width| (|NonNegativeInteger|)) (#5=#:G767 NIL) (|obs| (|List| S))
          (|dim| (|NonNegativeInteger|)))
         (SEQ (LETT |dim| (+ (LENGTH (SPADCALL |s| (QREFELT $ 9))) 1))
              (LETT |obs|
                    (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |n| (QREFELT $ 10)))
              (LETT |arrows| NIL)
              (SEQ (LETT #5# (SPADCALL |s| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |a| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |width| (LENGTH |a|))
                        (LETT |padding|
                              (SPADCALL |dim| |width| (QREFELT $ 15)))
                        (COND
                         ((SPADCALL |padding| (CONS 1 "failed") (QREFELT $ 18))
                          (SEQ
                           (LETT |diff|
                                 (PROG2 (LETT #4# |padding|)
                                     (QCDR #4#)
                                   (|check_union2| (QEQCAR #4# 0)
                                                   (|NonNegativeInteger|)
                                                   (|Union|
                                                    (|NonNegativeInteger|)
                                                    "failed")
                                                   #4#)))
                           (EXIT
                            (SEQ (LETT |x| 1) (LETT #3# |diff|) G190
                                 (COND ((|greater_SI| |x| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |a|
                                         (SPADCALL |a| NIL (QREFELT $ 20)))))
                                 (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                                 (EXIT NIL))))))
                        (EXIT
                         (COND ((NULL |arrows|) (LETT |arrows| (LIST |a|)))
                               ('T
                                (LETT |arrows|
                                      (SPADCALL |arrows| |a|
                                                (QREFELT $ 21)))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |emptyRow|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |x| 1) (LETT #1# |dim|) G190
                          (COND ((|greater_SI| |x| #1#) (GO G191)))
                          (SEQ (EXIT (LETT #2# (CONS NIL #2#))))
                          (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |arrows| (SPADCALL |arrows| |emptyRow| (QREFELT $ 21)))
              (EXIT (SPADCALL |obs| |arrows| (QREFELT $ 22)))))) 

(SDEFUN |POSET-;addArrow!;A2NniA;2|
        ((|s| (A)) (|n1| (|NonNegativeInteger|)) (|n2| (|NonNegativeInteger|))
         ($ (A)))
        (SPROG ((|a| (|List| (|Boolean|))))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |n1|
                                (QREFELT $ 25)))
                (SPADCALL |a| |n2| 'T (QREFELT $ 26))
                (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |n1| |a|
                          (QREFELT $ 27))
                (EXIT
                 (SPADCALL (SPADCALL |s| (QREFELT $ 9))
                           (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 22)))))) 

(SDEFUN |POSET-;isArrow?|
        ((|arr| (|List| (|List| (|Boolean|)))) (|a| (|NonNegativeInteger|))
         (|b| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G779 NIL) (|val| (|Boolean|)) (#2=#:G780 NIL) (|x| NIL)
          (|row| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |row| 1)
                (SEQ (LETT |x| NIL) (LETT #2# |arr|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (COND
                       ((EQL |row| |a|)
                        (SEQ (LETT |val| (SPADCALL |x| |b| (QREFELT $ 29)))
                             (EXIT (PROGN (LETT #1# |val|) (GO #3=#:G778))))))
                      (EXIT (EQL |row| (+ |row| 1))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT NIL)))
          #3# (EXIT #1#)))) 

(SDEFUN |POSET-;le;A2NniB;4|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (|POSET-;isArrow?| (SPADCALL |s| (QREFELT $ 12)) |a| |b| $)) 

(SDEFUN |POSET-;setArrow!|
        ((|arr| (|List| (|List| (|Boolean|)))) (|a| (|NonNegativeInteger|))
         (|b| (|NonNegativeInteger|)) (|c| (|Boolean|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G788 NIL) (#2=#:G789 NIL) (|x| NIL)
          (|row| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |row| 1)
                (SEQ (LETT |x| NIL) (LETT #2# |arr|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (COND
                       ((EQL |row| |a|)
                        (SEQ (SPADCALL |x| |b| |c| (QREFELT $ 26))
                             (EXIT
                              (PROGN
                               (LETT #1# (SPADCALL (QREFELT $ 32)))
                               (GO #3=#:G787))))))
                      (EXIT (EQL |row| (+ |row| 1))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL (QREFELT $ 32)))))
          #3# (EXIT #1#)))) 

(SDEFUN |POSET-;addObject!;ASA;6| ((|s| (A)) (|n| (S)) ($ (A)))
        (SPROG
         ((|arrows| (|List| (|List| (|Boolean|))))
          (|emptyRow| (|List| (|Boolean|))) (#1=#:G807 NIL) (|x| NIL)
          (#2=#:G806 NIL) (|a| (|List| (|Boolean|))) (#3=#:G805 NIL)
          (|diff| (|NonNegativeInteger|)) (#4=#:G792 NIL)
          (|padding| (|Union| (|NonNegativeInteger|) "failed"))
          (|width| (|NonNegativeInteger|)) (#5=#:G804 NIL) (|obs| (|List| S))
          (|dim| (|NonNegativeInteger|)))
         (SEQ (LETT |dim| (+ (LENGTH (SPADCALL |s| (QREFELT $ 9))) 1))
              (LETT |obs|
                    (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |n| (QREFELT $ 10)))
              (LETT |arrows| NIL)
              (SEQ (LETT #5# (SPADCALL |s| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |a| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |width| (LENGTH |a|))
                        (LETT |padding|
                              (SPADCALL |dim| |width| (QREFELT $ 15)))
                        (COND
                         ((SPADCALL |padding| (CONS 1 "failed") (QREFELT $ 18))
                          (SEQ
                           (LETT |diff|
                                 (PROG2 (LETT #4# |padding|)
                                     (QCDR #4#)
                                   (|check_union2| (QEQCAR #4# 0)
                                                   (|NonNegativeInteger|)
                                                   (|Union|
                                                    (|NonNegativeInteger|)
                                                    "failed")
                                                   #4#)))
                           (EXIT
                            (SEQ (LETT |x| 1) (LETT #3# |diff|) G190
                                 (COND ((|greater_SI| |x| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |a|
                                         (SPADCALL |a| NIL (QREFELT $ 20)))))
                                 (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                                 (EXIT NIL))))))
                        (EXIT
                         (COND ((NULL |arrows|) (LETT |arrows| (LIST |a|)))
                               ('T
                                (LETT |arrows|
                                      (SPADCALL |arrows| |a|
                                                (QREFELT $ 21)))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |emptyRow|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |x| 1) (LETT #1# |dim|) G190
                          (COND ((|greater_SI| |x| #1#) (GO G191)))
                          (SEQ (EXIT (LETT #2# (CONS NIL #2#))))
                          (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |arrows| (SPADCALL |arrows| |emptyRow| (QREFELT $ 21)))
              (SPADCALL |s| |obs| (QREFELT $ 33))
              (SPADCALL |s| |arrows| (QREFELT $ 34)) (EXIT |s|)))) 

(SDEFUN |POSET-;addObject!;ARA;7|
        ((|s| (A))
         (|n|
          (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                    (|:| |posY| (|NonNegativeInteger|))))
         ($ (A)))
        (SPROG ((|ob| (S)))
               (SEQ (LETT |ob| (QVELT |n| 0))
                    (EXIT (SPADCALL |s| |ob| (QREFELT $ 35)))))) 

(SDEFUN |POSET-;addArrow!;AS2NniA;8|
        ((|s| (A)) (|name| (|String|)) (|n1| (|NonNegativeInteger|))
         (|n2| (|NonNegativeInteger|)) ($ (A)))
        (SPROG ((|a| (|List| (|Boolean|))))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |n1|
                                (QREFELT $ 25)))
                (SPADCALL |a| |n2| 'T (QREFELT $ 26))
                (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |n1| |a|
                          (QREFELT $ 27))
                (EXIT
                 (SPADCALL (SPADCALL |s| (QREFELT $ 9))
                           (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 22)))))) 

(SDEFUN |POSET-;addArrow!;AS2NniLA;9|
        ((|s| (A)) (|name| (|String|)) (|n1| (|NonNegativeInteger|))
         (|n2| (|NonNegativeInteger|)) (|mp| (|List| (|NonNegativeInteger|)))
         ($ (A)))
        (SPADCALL |s| |name| |n1| |n2| (QREFELT $ 40))) 

(SDEFUN |POSET-;getVertices;AL;10|
        ((|s| (A))
         ($
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))))
        (SPROG ((#1=#:G821 NIL) (|x| NIL) (#2=#:G820 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# (SPADCALL |s| (QREFELT $ 9)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (VECTOR |x| 0 0) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |POSET-;getArrows;AL;11|
        ((|s| (A))
         ($
          (|List|
           #1=(|Record| (|:| |name| (|String|))
                        (|:| |arrType| (|NonNegativeInteger|))
                        (|:| |fromOb| (|NonNegativeInteger|))
                        (|:| |toOb| (|NonNegativeInteger|))
                        (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                        (|:| |map| (|List| (|NonNegativeInteger|)))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (#2=#:G833 NIL) (|y| NIL) (#3=#:G834 NIL) (|val| NIL)
          (#4=#:G831 NIL) (|x| NIL) (#5=#:G832 NIL) (|row| NIL)
          (|dim| (|NonNegativeInteger|)))
         (SEQ (LETT |res| NIL)
              (LETT |dim| (LENGTH (SPADCALL |s| (QREFELT $ 12))))
              (SEQ (LETT |row| NIL) (LETT #5# (SPADCALL |s| (QREFELT $ 12)))
                   (LETT |x| 1) (LETT #4# |dim|) G190
                   (COND
                    ((OR (|greater_SI| |x| #4#) (ATOM #5#)
                         (PROGN (LETT |row| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |val| NIL) (LETT #3# |row|) (LETT |y| 1)
                          (LETT #2# |dim|) G190
                          (COND
                           ((OR (|greater_SI| |y| #2#) (ATOM #3#)
                                (PROGN (LETT |val| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             (|val|
                              (SEQ (LETT |arr| (VECTOR "x" 0 |x| |y| 0 0 NIL))
                                   (EXIT
                                    (LETT |res|
                                          (SPADCALL |res| |arr|
                                                    (QREFELT $ 47)))))))))
                          (LETT |y|
                                (PROG1 (|inc_SI| |y|) (LETT #3# (CDR #3#))))
                          (GO G190) G191 (EXIT NIL))))
                   (LETT |x| (PROG1 (|inc_SI| |x|) (LETT #5# (CDR #5#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |POSET-;flatten;DgA;12| ((|n| (|DirectedGraph| A)) ($ (A)))
        (SPADCALL NIL (LIST NIL) (QREFELT $ 22))) 

(SDEFUN |POSET-;initial;A;13| (($ (A))) (SPADCALL NIL NIL (QREFELT $ 22))) 

(SDEFUN |POSET-;terminal;SA;14| ((|a| (S)) ($ (A)))
        (SPADCALL (LIST |a|) (LIST (LIST 'T)) (QREFELT $ 22))) 

(SDEFUN |POSET-;cycleOpen;LSA;15|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ (A)))
        (SPADCALL NIL (LIST NIL) (QREFELT $ 22))) 

(SDEFUN |POSET-;cycleClosed;LSA;16|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ (A)))
        (SPADCALL NIL (LIST NIL) (QREFELT $ 22))) 

(SDEFUN |POSET-;unit;LSA;17|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ (A)))
        (SPROG
         ((|arrs| (|List| (|List| (|Boolean|)))) (|row| (|List| (|Boolean|)))
          (|val| (|Boolean|)) (#1=#:G849 NIL) (|y| NIL) (#2=#:G848 NIL)
          (|x| NIL) (|dim| (|NonNegativeInteger|)))
         (SEQ (LETT |dim| (LENGTH |objs|)) (LETT |arrs| (LIST NIL))
              (SEQ (LETT |x| 1) (LETT #2# |dim|) G190
                   (COND ((|greater_SI| |x| #2#) (GO G191)))
                   (SEQ (LETT |row| NIL)
                        (SEQ (LETT |y| 1) (LETT #1# |dim|) G190
                             (COND ((|greater_SI| |y| #1#) (GO G191)))
                             (SEQ (LETT |val| (EQL |x| |y|))
                                  (EXIT
                                   (LETT |row|
                                         (SPADCALL |row| |val|
                                                   (QREFELT $ 20)))))
                             (LETT |y| (|inc_SI| |y|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT
                         (LETT |arrs| (SPADCALL |arrs| |row| (QREFELT $ 21)))))
                   (LETT |x| (|inc_SI| |x|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |objs| |arrs| (QREFELT $ 22)))))) 

(SDEFUN |POSET-;kgraph;LSA;18|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ (A)))
        (SPADCALL NIL (LIST (LIST NIL)) (QREFELT $ 22))) 

(SDEFUN |POSET-;isDirectSuccessor?;A2NniB;19|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG ((|row| (|List| (|Boolean|))))
               (SEQ
                (LETT |row|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |a|
                                (QREFELT $ 25)))
                (EXIT (SPADCALL |row| |b| (QREFELT $ 29)))))) 

(SDEFUN |POSET-;isGreaterThan?;A2NniB;20|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG ((|row| (|List| (|Boolean|))))
               (SEQ
                (LETT |row|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |a|
                                (QREFELT $ 25)))
                (EXIT (SPADCALL |row| |b| (QREFELT $ 29)))))) 

(SDEFUN |POSET-;max;ANni;21| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G859 NIL) (#2=#:G863 NIL)
          (|res| (|Union| (|NonNegativeInteger|) "failed"))
          (|index| (|NonNegativeInteger|))
          (|arr| (|List| (|NonNegativeInteger|))) (#3=#:G864 NIL) (|x| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |arr| NIL) (LETT |index| 1)
                (SEQ (LETT |x| NIL) (LETT #3# (SPADCALL |s| (QREFELT $ 12)))
                     G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |arr| (SPADCALL |arr| |index| (QREFELT $ 59)))
                          (EXIT (LETT |index| (+ |index| 1))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (LETT |res| (SPADCALL |s| |arr| (QREFELT $ 60)))
                (COND
                 ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 61))
                  (PROGN (LETT #2# 0) (GO #4=#:G862))))
                (EXIT
                 (PROG2 (LETT #1# |res|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                   (|Union| (|NonNegativeInteger|) "failed")
                                   #1#)))))
          #4# (EXIT #2#)))) 

(SDEFUN |POSET-;max;ALNni;22|
        ((|s| (A)) (|sub| (|List| (|NonNegativeInteger|)))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G866 NIL) (#2=#:G870 NIL)
          (|res| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |res| (SPADCALL |s| |sub| (QREFELT $ 60)))
                (COND
                 ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 61))
                  (PROGN (LETT #2# 0) (GO #3=#:G869))))
                (EXIT
                 (PROG2 (LETT #1# |res|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                   (|Union| (|NonNegativeInteger|) "failed")
                                   #1#)))))
          #3# (EXIT #2#)))) 

(SDEFUN |POSET-;min;ANni;23| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G875 NIL) (#2=#:G879 NIL)
          (|res| (|Union| (|NonNegativeInteger|) "failed"))
          (|index| (|NonNegativeInteger|))
          (|arr| (|List| (|NonNegativeInteger|))) (#3=#:G880 NIL) (|x| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |arr| NIL) (LETT |index| 1)
                (SEQ (LETT |x| NIL) (LETT #3# (SPADCALL |s| (QREFELT $ 12)))
                     G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |arr| (SPADCALL |arr| |index| (QREFELT $ 59)))
                          (EXIT (LETT |index| (+ |index| 1))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (LETT |res| (SPADCALL |s| |arr| (QREFELT $ 64)))
                (COND
                 ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 61))
                  (PROGN (LETT #2# 0) (GO #4=#:G878))))
                (EXIT
                 (PROG2 (LETT #1# |res|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                   (|Union| (|NonNegativeInteger|) "failed")
                                   #1#)))))
          #4# (EXIT #2#)))) 

(SDEFUN |POSET-;min;ALNni;24|
        ((|s| (A)) (|sub| (|List| (|NonNegativeInteger|)))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G882 NIL) (#2=#:G886 NIL)
          (|res| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |res| (SPADCALL |s| |sub| (QREFELT $ 64)))
                (COND
                 ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 61))
                  (PROGN (LETT #2# 0) (GO #3=#:G885))))
                (EXIT
                 (PROG2 (LETT #1# |res|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                   (|Union| (|NonNegativeInteger|) "failed")
                                   #1#)))))
          #3# (EXIT #2#)))) 

(PUT '|POSET-;isFixPoint?;ANniB;25| '|SPADreplace| '(XLAM (|s| |a|) 'T)) 

(SDEFUN |POSET-;isFixPoint?;ANniB;25|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|Boolean|))) 'T) 

(PUT '|POSET-;arrowName;A2NniS;26| '|SPADreplace| '(XLAM (|s| |a| |b|) "?")) 

(SDEFUN |POSET-;arrowName;A2NniS;26|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|String|)))
        "?") 

(PUT '|POSET-;getArrowIndex;A3Nni;27| '|SPADreplace| '(XLAM (|s| |a| |b|) 0)) 

(SDEFUN |POSET-;getArrowIndex;A3Nni;27|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        0) 

(PUT '|POSET-;inDegree;A2Nni;28| '|SPADreplace| '(XLAM (|s| |a|) 0)) 

(SDEFUN |POSET-;inDegree;A2Nni;28|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|))) 0) 

(PUT '|POSET-;outDegree;A2Nni;29| '|SPADreplace| '(XLAM (|s| |a|) 0)) 

(SDEFUN |POSET-;outDegree;A2Nni;29|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|))) 0) 

(PUT '|POSET-;nodeFromNode;ANniL;30| '|SPADreplace| '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;nodeFromNode;ANniL;30|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;nodeToNode;ANniL;31| '|SPADreplace| '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;nodeToNode;ANniL;31|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;arrowsFromNode;ANniL;32| '|SPADreplace|
     '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;arrowsFromNode;ANniL;32|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;arrowsToNode;ANniL;33| '|SPADreplace| '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;arrowsToNode;ANniL;33|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;nodeFromArrow;ANniL;34| '|SPADreplace| '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;nodeFromArrow;ANniL;34|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;nodeToArrow;ANniL;35| '|SPADreplace| '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;nodeToArrow;ANniL;35|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;arrowsFromArrow;ANniL;36| '|SPADreplace|
     '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;arrowsFromArrow;ANniL;36|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;arrowsToArrow;ANniL;37| '|SPADreplace| '(XLAM (|s| |a|) (LIST 0))) 

(SDEFUN |POSET-;arrowsToArrow;ANniL;37|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;routeNodes;A2NniL;38| '|SPADreplace|
     '(XLAM (|s| |a| |b|) (LIST 0))) 

(SDEFUN |POSET-;routeNodes;A2NniL;38|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;routeArrows;A2NniL;39| '|SPADreplace|
     '(XLAM (|s| |a| |b|) (LIST 0))) 

(SDEFUN |POSET-;routeArrows;A2NniL;39|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (LIST 0)) 

(PUT '|POSET-;distance;A2NniI;40| '|SPADreplace| '(XLAM (|s| |a| |b|) 0)) 

(SDEFUN |POSET-;distance;A2NniI;40|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Integer|)))
        0) 

(PUT '|POSET-;+| '|SPADreplace| '(XLAM (|a| |b|) |a|)) 

(SDEFUN |POSET-;+| ((|a| (A)) (|b| (A)) ($ (A))) |a|) 

(PUT '|POSET-;merge;3A;42| '|SPADreplace| '(XLAM (|a| |b|) |a|)) 

(SDEFUN |POSET-;merge;3A;42| ((|a| (A)) (|b| (A)) ($ (A))) |a|) 

(PUT '|POSET-;isDirected?;B;43| '|SPADreplace| '(XLAM NIL 'T)) 

(SDEFUN |POSET-;isDirected?;B;43| (($ (|Boolean|))) 'T) 

(PUT '|POSET-;createWidth;2Nni;44| '|SPADreplace| '(XLAM (|x|) 0)) 

(SDEFUN |POSET-;createWidth;2Nni;44|
        ((|x| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|))) 0) 

(PUT '|POSET-;createX;3Nni;45| '|SPADreplace| '(XLAM (|x| |n|) 0)) 

(SDEFUN |POSET-;createX;3Nni;45|
        ((|x| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        0) 

(PUT '|POSET-;createY;3Nni;46| '|SPADreplace| '(XLAM (|x| |n|) 0)) 

(SDEFUN |POSET-;createY;3Nni;46|
        ((|x| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        0) 

(PUT '|POSET-;looseEquals;2AB;47| '|SPADreplace| '(XLAM (|x| |y|) NIL)) 

(SDEFUN |POSET-;looseEquals;2AB;47| ((|x| (A)) (|y| (A)) ($ (|Boolean|))) NIL) 

(PUT '|POSET-;map;ALL2IA;48| '|SPADreplace|
     '(XLAM (|s| |m| |newOb| |offsetX| |offsetY|) |s|)) 

(SDEFUN |POSET-;map;ALL2IA;48|
        ((|s| (A)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| (|Integer|)) (|offsetY| (|Integer|)) ($ (A)))
        |s|) 

(PUT '|POSET-;mapContra;ALL2IA;49| '|SPADreplace|
     '(XLAM (|s| |m| |newOb| |offsetX| |offsetY|) |s|)) 

(SDEFUN |POSET-;mapContra;ALL2IA;49|
        ((|s| (A)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| (|Integer|)) (|offsetY| (|Integer|)) ($ (A)))
        |s|) 

(SDEFUN |POSET-;opposite;2A;50| ((|s| (A)) ($ (A)))
        (SPROG
         ((#1=#:G927 NIL) (|b| NIL) (#2=#:G926 NIL) (|a| NIL)
          (|arr2| (|List| (|List| (|Boolean|)))) (|row| (|List| (|Boolean|)))
          (#3=#:G925 NIL) (|y| NIL) (#4=#:G924 NIL) (|x| NIL))
         (SEQ (LETT |arr2| (LIST NIL))
              (SEQ (LETT |x| NIL) (LETT #4# (SPADCALL |s| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |row| NIL)
                        (SEQ (LETT |y| NIL) (LETT #3# |x|) G190
                             (COND
                              ((OR (ATOM #3#) (PROGN (LETT |y| (CAR #3#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |row|
                                     (SPADCALL |row| NIL (QREFELT $ 20)))))
                             (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |arr2| (SPADCALL |arr2| |row| (QREFELT $ 21)))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |a| 1)
                   (LETT #2# (LENGTH (SPADCALL |s| (QREFELT $ 12)))) G190
                   (COND ((|greater_SI| |a| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |b| 1)
                          (LETT #1# (LENGTH (SPADCALL |s| (QREFELT $ 12))))
                          G190 (COND ((|greater_SI| |b| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((|POSET-;isArrow?| (SPADCALL |s| (QREFELT $ 12))
                               |a| |b| $)
                              (|POSET-;setArrow!| |arr2| |b| |a| 'T $)))))
                          (LETT |b| (|inc_SI| |b|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |a| (|inc_SI| |a|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |arr2| (QREFELT $ 22)))))) 

(SDEFUN |POSET-;implies;A2NniB;51|
        ((|s| (A)) (|left| (|NonNegativeInteger|))
         (|right| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG ((|b| (|Boolean|)) (|a| (|List| (|Boolean|))))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |left|
                                (QREFELT $ 25)))
                (LETT |b| (SPADCALL |a| |right| (QREFELT $ 29))) (EXIT |b|)))) 

(SDEFUN |POSET-;joinIfCan;A2NniU;52|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|)))
          (|index| (|NonNegativeInteger|))
          (|candidatesb| (|List| (|NonNegativeInteger|))) (#1=#:G942 NIL)
          (|x| NIL) (|flagb| #2=(|List| (|Boolean|)))
          (|candidatesa| (|List| (|NonNegativeInteger|))) (#3=#:G941 NIL)
          (|flaga| #2#))
         (SEQ (LETT |res| NIL)
              (LETT |flaga|
                    (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |a|
                              (QREFELT $ 25)))
              (LETT |candidatesa| NIL) (LETT |index| 1)
              (SEQ (LETT |x| NIL) (LETT #3# |flaga|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|x|
                      (LETT |candidatesa|
                            (SPADCALL |candidatesa| |index| (QREFELT $ 59)))))
                    (EXIT (LETT |index| (+ |index| 1))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |flagb|
                    (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |b|
                              (QREFELT $ 25)))
              (LETT |candidatesb| NIL) (LETT |index| 1)
              (SEQ (LETT |x| NIL) (LETT #1# |flagb|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|x|
                      (LETT |candidatesb|
                            (SPADCALL |candidatesb| |index| (QREFELT $ 59)))))
                    (EXIT (LETT |index| (+ |index| 1))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |res|
                    (SPADCALL |candidatesa| |candidatesb| (QREFELT $ 93)))
              (EXIT (SPADCALL |s| |res| (QREFELT $ 94)))))) 

(SDEFUN |POSET-;meetIfCan;A2NniU;53|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|)))
          (|index| (|NonNegativeInteger|))
          (|candidatesb| (|List| (|NonNegativeInteger|))) (#1=#:G961 NIL)
          (|x| NIL) (|flagb| (|List| (|Boolean|))) (#2=#:G960 NIL)
          (|candidatesa| (|List| (|NonNegativeInteger|))) (#3=#:G959 NIL)
          (|flaga| (|List| (|Boolean|))) (#4=#:G958 NIL))
         (SEQ (LETT |res| NIL) (LETT |flaga| NIL) (LETT |flagb| NIL)
              (SEQ (LETT |x| NIL) (LETT #4# (SPADCALL |s| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |flaga|
                           (SPADCALL |flaga| (SPADCALL |x| |a| (QREFELT $ 29))
                                     (QREFELT $ 20)))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |candidatesa| NIL) (LETT |index| 1)
              (SEQ (LETT |x| NIL) (LETT #3# |flaga|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|x|
                      (LETT |candidatesa|
                            (SPADCALL |candidatesa| |index| (QREFELT $ 59)))))
                    (EXIT (LETT |index| (+ |index| 1))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |x| NIL) (LETT #2# (SPADCALL |s| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |flagb|
                           (SPADCALL |flagb| (SPADCALL |x| |b| (QREFELT $ 29))
                                     (QREFELT $ 20)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |candidatesb| NIL) (LETT |index| 1)
              (SEQ (LETT |x| NIL) (LETT #1# |flagb|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|x|
                      (LETT |candidatesb|
                            (SPADCALL |candidatesb| |index| (QREFELT $ 59)))))
                    (EXIT (LETT |index| (+ |index| 1))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |res|
                    (SPADCALL |candidatesa| |candidatesb| (QREFELT $ 93)))
              (EXIT (SPADCALL |s| |res| (QREFELT $ 96)))))) 

(SDEFUN |POSET-;meetIfCan;ALU;54|
        ((|s| (A)) (|elements| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|)))
          (|index| (|NonNegativeInteger|))
          (|candidates| (|List| (|NonNegativeInteger|))) (#1=#:G977 NIL)
          (|x| NIL) (|flage| (|List| (|Boolean|))) (#2=#:G976 NIL)
          (#3=#:G975 NIL) (|e| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |e| NIL) (LETT #3# |elements|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |e| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |flage| NIL)
                        (SEQ (LETT |x| NIL)
                             (LETT #2# (SPADCALL |s| (QREFELT $ 12))) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |flage|
                                     (SPADCALL |flage|
                                               (SPADCALL |x| |e|
                                                         (QREFELT $ 29))
                                               (QREFELT $ 20)))))
                             (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                        (LETT |candidates| NIL) (LETT |index| 1)
                        (EXIT
                         (SEQ (LETT |x| NIL) (LETT #1# |flage|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |x| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (COND
                                (|x|
                                 (LETT |candidates|
                                       (SPADCALL |candidates| |index|
                                                 (QREFELT $ 59)))))
                               (EXIT (LETT |index| (+ |index| 1))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |res| (SPADCALL |res| |candidates| (QREFELT $ 93)))
              (EXIT (SPADCALL |s| |res| (QREFELT $ 96)))))) 

(SDEFUN |POSET-;joinIfCan;ALU;55|
        ((|s| (A)) (|elements| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|)))
          (|index| (|NonNegativeInteger|))
          (|candidates| (|List| (|NonNegativeInteger|))) (#1=#:G990 NIL)
          (|x| NIL) (|flage| (|List| (|Boolean|))) (#2=#:G989 NIL) (|e| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |e| NIL) (LETT #2# |elements|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |flage|
                          (SPADCALL (SPADCALL |s| (QREFELT $ 12)) |e|
                                    (QREFELT $ 25)))
                    (LETT |candidates| NIL) (LETT |index| 1)
                    (SEQ (LETT |x| NIL) (LETT #1# |flage|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (COND
                           (|x|
                            (LETT |candidates|
                                  (SPADCALL |candidates| |index|
                                            (QREFELT $ 59)))))
                          (EXIT (LETT |index| (+ |index| 1))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res| |candidates| (QREFELT $ 93)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |s| |res| (QREFELT $ 94)))))) 

(SDEFUN |POSET-;glb;ALU;56|
        ((|s| (A)) (|a| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((#1=#:G1008 NIL) (|resultList| (|List| (|NonNegativeInteger|)))
          (#2=#:G1010 NIL) (|y| NIL) (#3=#:G1009 NIL) (|x| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((NULL |a|) (PROGN (LETT #1# (CONS 0 0)) (GO #4=#:G1007))))
            (COND
             ((EQL (SPADCALL |a| (QREFELT $ 100)) 1)
              (PROGN (LETT #1# (CONS 0 (|SPADfirst| |a|))) (GO #4#))))
            (LETT |resultList| (SPADCALL |a| (QREFELT $ 101)))
            (SEQ (LETT |x| NIL) (LETT #3# |a|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |y| NIL) (LETT #2# |a|) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |y| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL |s| |x| |y| (QREFELT $ 102))
                            (COND
                             ((SPADCALL |x| |y| (QREFELT $ 103))
                              (COND
                               ((SPADCALL |x| |resultList| (QREFELT $ 104))
                                (LETT |resultList|
                                      (SPADCALL |y| |resultList|
                                                (QREFELT $ 105)))))))))))
                        (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL (SPADCALL |resultList| (QREFELT $ 100)) 1
                        (QREFELT $ 103))
              (PROGN (LETT #1# (CONS 0 0)) (GO #4#))))
            (EXIT (CONS 0 (|SPADfirst| |resultList|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |POSET-;lub;ALU;57|
        ((|s| (A)) (|a| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG
         ((#1=#:G1026 NIL) (|resultList| (|List| (|NonNegativeInteger|)))
          (#2=#:G1028 NIL) (|y| NIL) (#3=#:G1027 NIL) (|x| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((NULL |a|) (PROGN (LETT #1# (CONS 0 0)) (GO #4=#:G1025))))
            (COND
             ((EQL (SPADCALL |a| (QREFELT $ 100)) 1)
              (PROGN (LETT #1# (CONS 0 (|SPADfirst| |a|))) (GO #4#))))
            (LETT |resultList| (SPADCALL |a| (QREFELT $ 101)))
            (SEQ (LETT |x| NIL) (LETT #3# |a|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |y| NIL) (LETT #2# |a|) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |y| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL |s| |x| |y| (QREFELT $ 102))
                            (COND
                             ((SPADCALL |x| |y| (QREFELT $ 103))
                              (COND
                               ((SPADCALL |y| |resultList| (QREFELT $ 104))
                                (LETT |resultList|
                                      (SPADCALL |x| |resultList|
                                                (QREFELT $ 105)))))))))))
                        (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL (SPADCALL |resultList| (QREFELT $ 100)) 1
                        (QREFELT $ 103))
              (PROGN (LETT #1# (CONS 0 0)) (GO #4#))))
            (EXIT (CONS 0 (|SPADfirst| |resultList|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |POSET-;indexToObject;ANniS;58|
        ((|s| (A)) (|index| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |index| (QREFELT $ 108))) 

(SDEFUN |POSET-;objectToIndex;ASNni;59|
        ((|s| (A)) (|obj| (S)) ($ (|NonNegativeInteger|)))
        (SPADCALL |obj| (SPADCALL |s| (QREFELT $ 9)) (QREFELT $ 110))) 

(SDEFUN |POSET-;completeReflexivity;2A;60| ((|s| (A)) ($ (A)))
        (SPROG
         ((#1=#:G1035 NIL) (|a| NIL) (|struct2| (|List| (|List| (|Boolean|))))
          (|set2| (|List| S)))
         (SEQ (LETT |set2| (SPADCALL |s| (QREFELT $ 9)))
              (LETT |struct2|
                    (SPADCALL (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 112)))
              (SEQ (LETT |a| 1) (LETT #1# (LENGTH |set2|)) G190
                   (COND ((|greater_SI| |a| #1#) (GO G191)))
                   (SEQ (EXIT (|POSET-;setArrow!| |struct2| |a| |a| 'T $)))
                   (LETT |a| (|inc_SI| |a|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |set2| |struct2| (QREFELT $ 22)))))) 

(SDEFUN |POSET-;completeTransitivity;2A;61| ((|s| (A)) ($ (A)))
        (SPROG
         ((#1=#:G1049 NIL) (|c| NIL) (#2=#:G1048 NIL) (|b| NIL)
          (#3=#:G1047 NIL) (|a| NIL) (|struct2| (|List| (|List| (|Boolean|))))
          (|dim| (|NonNegativeInteger|)) (|set2| (|List| S)))
         (SEQ (LETT |set2| (SPADCALL |s| (QREFELT $ 9)))
              (LETT |dim| (LENGTH |set2|))
              (LETT |struct2|
                    (SPADCALL (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 112)))
              (SEQ (LETT |a| 1) (LETT #3# |dim|) G190
                   (COND ((|greater_SI| |a| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |b| 1) (LETT #2# |dim|) G190
                          (COND ((|greater_SI| |b| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |c| 1) (LETT #1# |dim|) G190
                                 (COND ((|greater_SI| |c| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((|POSET-;isArrow?| |struct2| |a| |b| $)
                                     (COND
                                      ((|POSET-;isArrow?| |struct2| |b| |c| $)
                                       (COND
                                        ((NULL
                                          (|POSET-;isArrow?| |struct2| |a| |c|
                                           $))
                                         (|POSET-;setArrow!| |struct2| |a| |c|
                                          'T $)))))))))
                                 (LETT |c| (|inc_SI| |c|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |b| (|inc_SI| |b|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |a| (|inc_SI| |a|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |set2| |struct2| (QREFELT $ 22)))))) 

(SDEFUN |POSET-;isAntisymmetric?;AB;62| ((|s| (A)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1059 NIL) (#2=#:G1061 NIL) (|b| NIL) (#3=#:G1060 NIL)
          (|a| NIL) (|struct2| (|List| (|List| (|Boolean|))))
          (|dim| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |dim| (LENGTH (SPADCALL |s| (QREFELT $ 9))))
                (LETT |struct2|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 12)) (QREFELT $ 112)))
                (SEQ (LETT |a| 1) (LETT #3# |dim|) G190
                     (COND ((|greater_SI| |a| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |b| 1) (LETT #2# |dim|) G190
                            (COND ((|greater_SI| |b| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((|POSET-;isArrow?| |struct2| |a| |b| $)
                                (COND
                                 ((|POSET-;isArrow?| |struct2| |b| |a| $)
                                  (COND
                                   ((SPADCALL |a| |b| (QREFELT $ 103))
                                    (PROGN
                                     (LETT #1# NIL)
                                     (GO #4=#:G1058))))))))))
                            (LETT |b| (|inc_SI| |b|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |a| (|inc_SI| |a|)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |POSET-;zetaMatrix;AIa;63|
        ((|s| (A)) ($ (|IncidenceAlgebra| (|Integer|) S)))
        (SPROG
         ((|zf| (|Matrix| (|Integer|))) (#1=#:G1079 NIL) (|y| NIL)
          (#2=#:G1078 NIL) (#3=#:G1077 NIL) (|x| NIL) (#4=#:G1076 NIL)
          (|xxi| (|List| (|NonNegativeInteger|))) (#5=#:G1063 NIL)
          (#6=#:G1075 NIL) (|xxoi| NIL) (#7=#:G1074 NIL) (|xxo| (|List| S))
          (|arr| (|List| (|List| (|Boolean|)))) (|xx| (|List| S)))
         (SEQ (LETT |xx| (SPADCALL |s| (QREFELT $ 9)))
              (LETT |arr| (SPADCALL |s| (QREFELT $ 12)))
              (LETT |xxo|
                    (SPADCALL (SPADCALL |arr| |xx| (QREFELT $ 117))
                              (QREFELT $ 118)))
              (LETT |xxi|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |xxoi| NIL) (LETT #6# |xxo|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |xxoi| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS
                                   (PROG1
                                       (LETT #5#
                                             (SPADCALL |xxoi| |xx|
                                                       (QREFELT $ 110)))
                                     (|check_subtype2| (>= #5# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #5#))
                                   #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |zf|
                    (SPADCALL
                     (PROGN
                      (LETT #4# NIL)
                      (SEQ (LETT |x| NIL) (LETT #3# |xxi|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #4#
                                   (CONS
                                    (PROGN
                                     (LETT #2# NIL)
                                     (SEQ (LETT |y| NIL) (LETT #1# |xxi|) G190
                                          (COND
                                           ((OR (ATOM #1#)
                                                (PROGN
                                                 (LETT |y| (CAR #1#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #2#
                                                  (CONS
                                                   (COND
                                                    ((SPADCALL
                                                      (SPADCALL |arr| |x|
                                                                (QREFELT $ 25))
                                                      |y| (QREFELT $ 29))
                                                     1)
                                                    ('T 0))
                                                   #2#))))
                                          (LETT #1# (CDR #1#)) (GO G190) G191
                                          (EXIT (NREVERSE #2#))))
                                    #4#))))
                           (LETT #3# (CDR #3#)) (GO G190) G191
                           (EXIT (NREVERSE #4#))))
                     (QREFELT $ 121)))
              (EXIT (SPADCALL |zf| |xxo| (QREFELT $ 123)))))) 

(SDEFUN |POSET-;moebius;AIa;64|
        ((|s| (A)) ($ (|IncidenceAlgebra| (|Integer|) S)))
        (SPROG
         ((|mf| (|Matrix| (|Integer|)))
          (|z| (|IncidenceAlgebra| (|Integer|) S)))
         (SEQ (LETT |z| (SPADCALL |s| (QREFELT $ 125)))
              (LETT |mf|
                    (SPADCALL (SPADCALL |z| (QREFELT $ 126)) 1
                              (QREFELT $ 128)))
              (EXIT
               (SPADCALL |mf| (SPADCALL |z| (QREFELT $ 130))
                         (QREFELT $ 131)))))) 

(SDEFUN |POSET-;coverMatrix;AIa;65|
        ((|s| (A)) ($ (|IncidenceAlgebra| (|Integer|) S)))
        (SPROG
         ((|tabx| (|List| (|Integer|))) (#1=#:G1095 NIL) (|j| NIL)
          (#2=#:G1094 NIL) (|i| NIL) (|ni| (|Integer|))
          (|res| (|Matrix| (|Integer|))) (|n| (|NonNegativeInteger|))
          (|zf| (|Matrix| (|Integer|)))
          (|z| (|IncidenceAlgebra| (|Integer|) S)))
         (SEQ (LETT |z| (SPADCALL |s| (QREFELT $ 125)))
              (LETT |zf| (SPADCALL |z| (QREFELT $ 126)))
              (LETT |n| (ANROWS |zf|))
              (LETT |res| (SPADCALL |n| |n| (QREFELT $ 133))) (LETT |ni| |n|)
              (SEQ (LETT |i| 1) (LETT #2# (- |ni| 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |tabx| NIL)
                        (EXIT
                         (SEQ (LETT |j| (+ |i| 1)) (LETT #1# |ni|) G190
                              (COND ((> |j| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((EQL (SPADCALL |zf| |i| |j| (QREFELT $ 134))
                                       1)
                                  (COND
                                   ((NULL
                                     (SPADCALL
                                      (CONS #'|POSET-;coverMatrix;AIa;65!0|
                                            (VECTOR $ |j| |zf|))
                                      |tabx| (QREFELT $ 138)))
                                    (SEQ (LETT |tabx| (CONS |j| |tabx|))
                                         (EXIT
                                          (SPADCALL |res| |i| |j| 1
                                                    (QREFELT $ 139))))))))))
                              (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |res| (SPADCALL |z| (QREFELT $ 130))
                         (QREFELT $ 131)))))) 

(SDEFUN |POSET-;coverMatrix;AIa;65!0| ((|u| NIL) ($$ NIL))
        (PROG (|zf| |j| $)
          (LETT |zf| (QREFELT $$ 2))
          (LETT |j| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |zf| |u| |j| (QREFELT $ 134))
                      (QREFELT $ 135)))))) 

(PUT '|POSET-;hash;ASi;66| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |POSET-;hash;ASi;66| ((|s| (A)) ($ (|SingleInteger|))) 0) 

(SDEFUN |POSET-;=;2AB;67| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1101 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 9))
                              (SPADCALL |y| (QREFELT $ 9)) (QREFELT $ 143))
                    (PROGN (LETT #1# NIL) (GO #2=#:G1100))))
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                              (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 144))
                    (PROGN (LETT #1# NIL) (GO #2#))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |POSET-;~=;2AB;68| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 146)))) 

(SDEFUN |POSET-;coerce;AOf;69| ((|s| (A)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G1115 NIL) (|mat| (|List| (|List| (|OutputForm|))))
          (|row| (|List| (|OutputForm|))) (|c| (|Symbol|)) (#2=#:G1117 NIL)
          (|b| NIL) (#3=#:G1116 NIL) (|a| NIL) (|dim| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |dim| (LENGTH (SPADCALL |s| (QREFELT $ 9))))
                (COND
                 ((NULL (SPADCALL |s| (QREFELT $ 12)))
                  (PROGN
                   (LETT #1#
                         (SPADCALL (SPADCALL (QREFELT $ 149)) (QREFELT $ 150)))
                   (GO #4=#:G1114))))
                (LETT |mat| NIL)
                (SEQ (LETT |a| NIL) (LETT #3# (SPADCALL |s| (QREFELT $ 12)))
                     G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |row| NIL)
                          (COND
                           ((SPADCALL |a| (QREFELT $ 151))
                            (LETT |row|
                                  (SPADCALL |row|
                                            (SPADCALL
                                             (SPADCALL (QREFELT $ 149))
                                             (QREFELT $ 150))
                                            (QREFELT $ 153))))
                           ('T
                            (SEQ (LETT |b| NIL) (LETT #2# |a|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |b| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |c| (COND (|b| '|true|) ('T '|false|)))
                                  (EXIT
                                   (LETT |row|
                                         (SPADCALL |row|
                                                   (SPADCALL |c|
                                                             (QREFELT $ 155))
                                                   (QREFELT $ 153)))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT NIL))))
                          (COND
                           ((SPADCALL (LENGTH |row|) |dim| (QREFELT $ 103))
                            (PROGN
                             (LETT #1#
                                   (SPADCALL "wrong number of cols"
                                             (QREFELT $ 156)))
                             (GO #4#))))
                          (EXIT
                           (LETT |mat|
                                 (SPADCALL |mat| |row| (QREFELT $ 158)))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((SPADCALL (LENGTH |mat|) |dim| (QREFELT $ 103))
                  (PROGN
                   (LETT #1# (SPADCALL "wrong number of rows" (QREFELT $ 156)))
                   (GO #4#))))
                (EXIT (SPADCALL |mat| (QREFELT $ 160)))))
          #4# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |Poset&;|)) 

(DEFUN |Poset&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Poset&| DV$1 DV$2))
          (LETT $ (GETREFV 162))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Poset&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 7)
              (0 . |getVert|) (5 . |concat|) (|List| 19) (11 . |getArr|)
              (|Union| $ '"failed") (|NonNegativeInteger|)
              (16 . |subtractIfCan|) (|Boolean|) (|Union| 14 '"failed")
              (22 . ~=) (|List| 16) (28 . |concat|) (34 . |concat|)
              (40 . |finitePoset|) |POSET-;addObject!;ASA;6| (|Integer|)
              (46 . |qelt|) (52 . |setelt!|) (59 . |setelt!|)
              |POSET-;addArrow!;A2NniA;2| (66 . |qelt|) |POSET-;le;A2NniB;4|
              (|Void|) (72 . |void|) (76 . |setVert|) (82 . |setArr|)
              (88 . |addObject!|)
              (|Record| (|:| |value| 7) (|:| |posX| 14) (|:| |posY| 14))
              |POSET-;addObject!;ARA;7| (|String|) |POSET-;addArrow!;AS2NniA;8|
              (94 . |addArrow!|) (|List| 14) |POSET-;addArrow!;AS2NniLA;9|
              (|List| 36) |POSET-;getVertices;AL;10|
              (|Record| (|:| |name| 38) (|:| |arrType| 14) (|:| |fromOb| 14)
                        (|:| |toOb| 14) (|:| |xOffset| 24) (|:| |yOffset| 24)
                        (|:| |map| 41))
              (|List| 45) (102 . |concat|) |POSET-;getArrows;AL;11|
              (|DirectedGraph| $) |POSET-;flatten;DgA;12| |POSET-;initial;A;13|
              |POSET-;terminal;SA;14| |POSET-;cycleOpen;LSA;15|
              |POSET-;cycleClosed;LSA;16| |POSET-;unit;LSA;17|
              |POSET-;kgraph;LSA;18| |POSET-;isDirectSuccessor?;A2NniB;19|
              |POSET-;isGreaterThan?;A2NniB;20| (108 . |concat|)
              (114 . |meetIfCan|) (120 . =) |POSET-;max;ANni;21|
              |POSET-;max;ALNni;22| (126 . |joinIfCan|) |POSET-;min;ANni;23|
              |POSET-;min;ALNni;24| |POSET-;isFixPoint?;ANniB;25|
              |POSET-;arrowName;A2NniS;26| |POSET-;getArrowIndex;A3Nni;27|
              |POSET-;inDegree;A2Nni;28| |POSET-;outDegree;A2Nni;29|
              |POSET-;nodeFromNode;ANniL;30| |POSET-;nodeToNode;ANniL;31|
              |POSET-;arrowsFromNode;ANniL;32| |POSET-;arrowsToNode;ANniL;33|
              |POSET-;nodeFromArrow;ANniL;34| |POSET-;nodeToArrow;ANniL;35|
              |POSET-;arrowsFromArrow;ANniL;36| |POSET-;arrowsToArrow;ANniL;37|
              |POSET-;routeNodes;A2NniL;38| |POSET-;routeArrows;A2NniL;39|
              |POSET-;distance;A2NniI;40| |POSET-;merge;3A;42|
              |POSET-;isDirected?;B;43| |POSET-;createWidth;2Nni;44|
              |POSET-;createX;3Nni;45| |POSET-;createY;3Nni;46|
              |POSET-;looseEquals;2AB;47| |POSET-;map;ALL2IA;48|
              |POSET-;mapContra;ALL2IA;49| |POSET-;opposite;2A;50|
              |POSET-;implies;A2NniB;51| (132 . |setIntersection|)
              (138 . |glb|) |POSET-;joinIfCan;A2NniU;52| (144 . |lub|)
              |POSET-;meetIfCan;A2NniU;53| |POSET-;meetIfCan;ALU;54|
              |POSET-;joinIfCan;ALU;55| (150 . |#|) (155 . |copy|)
              (160 . |implies|) (167 . ~=) (173 . |entry?|) (179 . |remove|)
              |POSET-;glb;ALU;56| |POSET-;lub;ALU;57| (185 . |qelt|)
              |POSET-;indexToObject;ANniS;58| (191 . |position|)
              |POSET-;objectToIndex;ASNni;59| (197 . |copy|)
              |POSET-;completeReflexivity;2A;60|
              |POSET-;completeTransitivity;2A;61|
              |POSET-;isAntisymmetric?;AB;62| (|ListPackage| 7)
              (202 . |topologicalSort|) (208 . |removeDuplicates|) (|List| 137)
              (|Matrix| 24) (213 . |matrix|) (|IncidenceAlgebra| 24 7)
              (218 . |incidenceAlgebra|) |POSET-;zetaMatrix;AIa;63|
              (224 . |zetaMatrix|) (229 . |matrix|)
              (|TriangularMatrixOperations| 24 (|Vector| 24) (|Vector| 24) 120)
              (234 . |UpTriBddDenomInv|) (|OneDimensionalArray| 7)
              (240 . |indices|) (245 . |incidenceAlgebra|)
              |POSET-;moebius;AIa;64| (251 . |zero|) (257 . |elt|)
              (264 . |one?|) (|Mapping| 16 24) (|List| 24) (269 . |any?|)
              (275 . |setelt!|) |POSET-;coverMatrix;AIa;65| (|SingleInteger|)
              |POSET-;hash;ASi;66| (283 . ~=) (289 . ~=) |POSET-;=;2AB;67|
              (295 . =) |POSET-;~=;2AB;68| (|OutputForm|) (301 . |empty|)
              (305 . |bracket|) (310 . |empty?|) (|List| 148) (315 . |concat|)
              (|Symbol|) (321 . |outputForm|) (326 . |outputForm|) (|List| 152)
              (331 . |concat|) (|List| (|List| $)) (337 . |matrix|)
              |POSET-;coerce;AOf;69|)
           '#(~= 342 |zetaMatrix| 348 |unit| 353 |terminal| 359 |routeNodes|
              364 |routeArrows| 371 |outDegree| 378 |opposite| 384
              |objectToIndex| 389 |nodeToNode| 395 |nodeToArrow| 401
              |nodeFromNode| 407 |nodeFromArrow| 413 |moebius| 419 |min| 424
              |merge| 435 |meetIfCan| 441 |max| 454 |mapContra| 465 |map| 474
              |lub| 483 |looseEquals| 489 |le| 495 |kgraph| 502 |joinIfCan| 508
              |isGreaterThan?| 521 |isFixPoint?| 528 |isDirected?| 534
              |isDirectSuccessor?| 538 |isAntisymmetric?| 545 |initial| 550
              |indexToObject| 554 |inDegree| 560 |implies| 566 |hash| 573 |glb|
              578 |getVertices| 584 |getArrows| 589 |getArrowIndex| 594
              |flatten| 601 |distance| 606 |cycleOpen| 613 |cycleClosed| 619
              |createY| 625 |createX| 631 |createWidth| 637 |coverMatrix| 642
              |completeTransitivity| 647 |completeReflexivity| 652 |coerce| 657
              |arrowsToNode| 662 |arrowsToArrow| 668 |arrowsFromNode| 674
              |arrowsFromArrow| 680 |arrowName| 686 |addObject!| 693
              |addArrow!| 705 = 729)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coverMatrix|
                                 ((|IncidenceAlgebra| (|Integer|) |#2|) |#1|))
                                T)
                              '((|zetaMatrix|
                                 ((|IncidenceAlgebra| (|Integer|) |#2|) |#1|))
                                T)
                              '((|moebius|
                                 ((|IncidenceAlgebra| (|Integer|) |#2|) |#1|))
                                T)
                              '((|isAntisymmetric?| ((|Boolean|) |#1|)) T)
                              '((|completeTransitivity| (|#1| |#1|)) T)
                              '((|completeReflexivity| (|#1| |#1|)) T)
                              '((|objectToIndex|
                                 ((|NonNegativeInteger|) |#1| |#2|))
                                T)
                              '((|indexToObject|
                                 (|#2| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|lub|
                                 ((|Union| (|NonNegativeInteger|) "failed")
                                  |#1| (|List| (|NonNegativeInteger|))))
                                T)
                              '((|glb|
                                 ((|Union| (|NonNegativeInteger|) "failed")
                                  |#1| (|List| (|NonNegativeInteger|))))
                                T)
                              '((|joinIfCan|
                                 ((|Union| (|NonNegativeInteger|) "failed")
                                  |#1| (|List| (|NonNegativeInteger|))))
                                T)
                              '((|meetIfCan|
                                 ((|Union| (|NonNegativeInteger|) "failed")
                                  |#1| (|List| (|NonNegativeInteger|))))
                                T)
                              '((|joinIfCan|
                                 ((|Union| (|NonNegativeInteger|) "failed")
                                  |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|meetIfCan|
                                 ((|Union| (|NonNegativeInteger|) "failed")
                                  |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|implies|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|opposite| (|#1| |#1|)) T)
                              '((|addArrow!|
                                 (|#1| |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|le|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|mapContra|
                                 (|#1| |#1| (|List| (|NonNegativeInteger|))
                                  (|List| |#2|) (|Integer|) (|Integer|)))
                                T)
                              '((|map|
                                 (|#1| |#1| (|List| (|NonNegativeInteger|))
                                  (|List| |#2|) (|Integer|) (|Integer|)))
                                T)
                              '((|looseEquals| ((|Boolean|) |#1| |#1|)) T)
                              '((|createY|
                                 ((|NonNegativeInteger|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|createX|
                                 ((|NonNegativeInteger|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|createWidth|
                                 ((|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|isDirected?| ((|Boolean|))) T)
                              '((|merge| (|#1| |#1| |#1|)) T)
                              '((|distance|
                                 ((|Integer|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|routeArrows|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|routeNodes|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|arrowsToArrow|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|arrowsFromArrow|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|nodeToArrow|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|nodeFromArrow|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|arrowsToNode|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|arrowsFromNode|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|nodeToNode|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|nodeFromNode|
                                 ((|List| (|NonNegativeInteger|)) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|outDegree|
                                 ((|NonNegativeInteger|) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|inDegree|
                                 ((|NonNegativeInteger|) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|getArrowIndex|
                                 ((|NonNegativeInteger|) |#1|
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|arrowName|
                                 ((|String|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|isFixPoint?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)))
                                T)
                              '((|min|
                                 ((|NonNegativeInteger|) |#1|
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|min| ((|NonNegativeInteger|) |#1|)) T)
                              '((|max|
                                 ((|NonNegativeInteger|) |#1|
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|max| ((|NonNegativeInteger|) |#1|)) T)
                              '((|isGreaterThan?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|isDirectSuccessor?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|kgraph| (|#1| (|List| |#2|) (|String|))) T)
                              '((|unit| (|#1| (|List| |#2|) (|String|))) T)
                              '((|cycleClosed| (|#1| (|List| |#2|) (|String|)))
                                T)
                              '((|cycleOpen| (|#1| (|List| |#2|) (|String|)))
                                T)
                              '((|terminal| (|#1| |#2|)) T)
                              '((|initial| (|#1|)) T)
                              '((|flatten| (|#1| (|DirectedGraph| |#1|))) T)
                              '((|getArrows|
                                 ((|List|
                                   (|Record| (|:| |name| (|String|))
                                             (|:| |arrType|
                                                  (|NonNegativeInteger|))
                                             (|:| |fromOb|
                                                  (|NonNegativeInteger|))
                                             (|:| |toOb|
                                                  (|NonNegativeInteger|))
                                             (|:| |xOffset| (|Integer|))
                                             (|:| |yOffset| (|Integer|))
                                             (|:| |map|
                                                  (|List|
                                                   (|NonNegativeInteger|)))))
                                  |#1|))
                                T)
                              '((|getVertices|
                                 ((|List|
                                   (|Record| (|:| |value| |#2|)
                                             (|:| |posX|
                                                  (|NonNegativeInteger|))
                                             (|:| |posY|
                                                  (|NonNegativeInteger|))))
                                  |#1|))
                                T)
                              '((|addArrow!| (|#1| |#1| (|String|) |#2| |#2|))
                                T)
                              '((|addArrow!|
                                 (|#1| |#1| (|String|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|addArrow!|
                                 (|#1| |#1| (|String|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|addArrow!|
                                 (|#1| |#1|
                                  (|Record| (|:| |name| (|String|))
                                            (|:| |arrType|
                                                 (|NonNegativeInteger|))
                                            (|:| |fromOb|
                                                 (|NonNegativeInteger|))
                                            (|:| |toOb| (|NonNegativeInteger|))
                                            (|:| |xOffset| (|Integer|))
                                            (|:| |yOffset| (|Integer|))
                                            (|:| |map|
                                                 (|List|
                                                  (|NonNegativeInteger|))))))
                                T)
                              '((|addObject!|
                                 (|#1| |#1|
                                  (|Record| (|:| |value| |#2|)
                                            (|:| |posX| (|NonNegativeInteger|))
                                            (|:| |posY|
                                                 (|NonNegativeInteger|)))))
                                T)
                              '((|addObject!| (|#1| |#1| |#2|)) T)
                              '((|hash| ((|SingleInteger|) |#1|)) T)
                              '((|coerce| ((|OutputForm|) |#1|)) T)
                              '((= ((|Boolean|) |#1| |#1|)) T)
                              '((~= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 161
                                            '(1 6 8 0 9 2 8 0 0 7 10 1 6 11 0
                                              12 2 14 13 0 0 15 2 17 16 0 0 18
                                              2 19 0 0 16 20 2 11 0 0 19 21 2 6
                                              0 8 11 22 2 11 19 0 24 25 3 19 16
                                              0 24 16 26 3 11 19 0 24 19 27 2
                                              19 16 0 24 29 0 31 0 32 2 6 31 0
                                              8 33 2 6 31 0 11 34 2 6 0 0 7 35
                                              4 6 0 0 38 14 14 40 2 46 0 0 45
                                              47 2 41 0 0 14 59 2 6 17 0 41 60
                                              2 17 16 0 0 61 2 6 17 0 41 64 2
                                              41 0 0 0 93 2 6 17 0 41 94 2 6 17
                                              0 41 96 1 41 14 0 100 1 41 0 0
                                              101 3 6 16 0 14 14 102 2 14 16 0
                                              0 103 2 41 16 14 0 104 2 41 0 14
                                              0 105 2 8 7 0 24 108 2 8 24 7 0
                                              110 1 11 0 0 112 2 116 8 11 8 117
                                              1 8 0 0 118 1 120 0 119 121 2 122
                                              0 120 8 123 1 6 122 0 125 1 122
                                              120 0 126 2 127 120 120 24 128 1
                                              122 129 0 130 2 122 0 120 129 131
                                              2 120 0 14 14 133 3 120 24 0 24
                                              24 134 1 24 16 0 135 2 137 16 136
                                              0 138 4 120 24 0 24 24 24 139 2 8
                                              16 0 0 143 2 11 16 0 0 144 2 6 16
                                              0 0 146 0 148 0 149 1 148 0 0 150
                                              1 19 16 0 151 2 152 0 0 148 153 1
                                              148 0 154 155 1 148 0 38 156 2
                                              157 0 0 152 158 1 148 0 159 160 2
                                              0 16 0 0 147 1 0 122 0 124 2 0 0
                                              8 38 55 1 0 0 7 52 3 0 41 0 14 14
                                              80 3 0 41 0 14 14 81 2 0 14 0 14
                                              71 1 0 0 0 91 2 0 14 0 7 111 2 0
                                              41 0 14 73 2 0 41 0 14 77 2 0 41
                                              0 14 72 2 0 41 0 14 76 1 0 122 0
                                              132 2 0 14 0 41 66 1 0 14 0 65 2
                                              0 0 0 0 83 2 0 17 0 41 98 3 0 17
                                              0 14 14 97 2 0 14 0 41 63 1 0 14
                                              0 62 5 0 0 0 41 8 24 24 90 5 0 0
                                              0 41 8 24 24 89 2 0 17 0 41 107 2
                                              0 16 0 0 88 3 0 16 0 14 14 30 2 0
                                              0 8 38 56 2 0 17 0 41 99 3 0 17 0
                                              14 14 95 3 0 16 0 14 14 58 2 0 16
                                              0 14 67 0 0 16 84 3 0 16 0 14 14
                                              57 1 0 16 0 115 0 0 0 51 2 0 7 0
                                              14 109 2 0 14 0 14 70 3 0 16 0 14
                                              14 92 1 0 141 0 142 2 0 17 0 41
                                              106 1 0 43 0 44 1 0 46 0 48 3 0
                                              14 0 14 14 69 1 0 0 49 50 3 0 24
                                              0 14 14 82 2 0 0 8 38 53 2 0 0 8
                                              38 54 2 0 14 14 14 87 2 0 14 14
                                              14 86 1 0 14 14 85 1 0 122 0 140
                                              1 0 0 0 114 1 0 0 0 113 1 0 148 0
                                              161 2 0 41 0 14 75 2 0 41 0 14 79
                                              2 0 41 0 14 74 2 0 41 0 14 78 3 0
                                              38 0 14 14 68 2 0 0 0 36 37 2 0 0
                                              0 7 23 3 0 0 0 14 14 28 4 0 0 0
                                              38 14 14 39 5 0 0 0 38 14 14 41
                                              42 2 0 16 0 0 145)))))
           '|lookupComplete|)) 
