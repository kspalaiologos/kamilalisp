
(SDEFUN |WGRPH;weightedGraph;L$;1| ((|ob| (|List| S)) ($ ($)))
        (SPROG
         ((|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
          (#1=#:G742 NIL) (|x| NIL) (#2=#:G741 NIL))
         (SEQ
          (LETT |objs|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |ob|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (VECTOR |x| 0 0 (|spadConstant| $ 9))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (CONS |objs| NIL))))) 

(PUT '|WGRPH;weightedGraph;L$;2| '|SPADreplace| '(XLAM (|ob|) (CONS |ob| NIL))) 

(SDEFUN |WGRPH;weightedGraph;L$;2|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
         ($ ($)))
        (CONS |ob| NIL)) 

(PUT '|WGRPH;weightedGraph;LL$;3| '|SPADreplace| 'CONS) 

(SDEFUN |WGRPH;weightedGraph;LL$;3|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
         (|ar|
          (|List|
           (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         ($ ($)))
        (CONS |ob| |ar|)) 

(SDEFUN |WGRPH;weightedGraph;LL$;4|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)))))
         (|ar|
          (|List|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         ($ ($)))
        (SPROG
         ((|fobs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |weight| W))))
          (|fo| #1#) (#2=#:G781 NIL) (|f| NIL) (#3=#:G782 NIL) (|fn| NIL)
          (|arrs|
           (|List|
            #4=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arro| #4#) (#5=#:G780 NIL) (|a| NIL))
         (SEQ (LETT |arrs| NIL)
              (SEQ (LETT |a| NIL) (LETT #5# |ar|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |a| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |arro|
                          (VECTOR (QVELT |a| 0) (|spadConstant| $ 9)
                                  (QVELT |a| 2) (QVELT |a| 3) (QVELT |a| 4)
                                  (QVELT |a| 5) (QVELT |a| 6)))
                    (EXIT
                     (LETT |arrs| (SPADCALL |arrs| |arro| (QREFELT $ 18)))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |fobs| NIL)
              (SEQ (LETT |fn| 1) (LETT #3# (LENGTH |ob|)) (LETT |f| NIL)
                   (LETT #2# |ob|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL)
                         (|greater_SI| |fn| #3#))
                     (GO G191)))
                   (SEQ
                    (LETT |fo|
                          (VECTOR (QVELT |f| 0) (QVELT |f| 1) (QVELT |f| 2)
                                  (|spadConstant| $ 9)))
                    (EXIT (LETT |fobs| (SPADCALL |fobs| |fo| (QREFELT $ 19)))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |fn| (|inc_SI| |fn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |fobs| |arrs|))))) 

(SDEFUN |WGRPH;weightedGraph;LL$;5|
        ((|obs| (|List| S))
         (|ars|
          (|List|
           (|Record| (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|)))))
         ($ ($)))
        (SPROG
         ((|edges|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#1=#:G798 NIL) (|ar| NIL) (#2=#:G799 NIL) (|arn| NIL)
          (|nodes|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (#3=#:G796 NIL) (|ob| NIL) (#4=#:G797 NIL) (|obn| NIL))
         (SEQ (LETT |nodes| NIL)
              (SEQ (LETT |obn| 1) (LETT #4# (LENGTH |obs|)) (LETT |ob| NIL)
                   (LETT #3# |obs|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |ob| (CAR #3#)) NIL)
                         (|greater_SI| |obn| #4#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |obs|) |obn|
                                            (QREFELT $ 26))
                                  (SPADCALL (LENGTH |obs|) |obn|
                                            (QREFELT $ 27))))
                    (EXIT
                     (LETT |nodes| (SPADCALL |nodes| |o| (QREFELT $ 28)))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |edges| NIL)
              (SEQ (LETT |arn| 1) (LETT #2# (LENGTH |ars|)) (LETT |ar| NIL)
                   (LETT #1# |ars|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |ar| (CAR #1#)) NIL)
                         (|greater_SI| |arn| #2#))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |edges|
                           (SPADCALL |edges|
                                     (VECTOR (STRCONC "a" (STRINGIMAGE |arn|))
                                             0 (QCAR |ar|) (QCDR |ar|) 0 0 NIL)
                                     (QREFELT $ 29)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |arn| (|inc_SI| |arn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |nodes| |edges| (QREFELT $ 24)))))) 

(SDEFUN |WGRPH;weightedGraph;Fp$;6| ((|poset| (|FinitePoset| S)) ($ ($)))
        (SPROG
         ((|ars|
           (|List|
            #1=(|Record| (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|)))))
          (|z| #1#) (#2=#:G810 NIL) (|y| NIL) (#3=#:G811 NIL) (|yn| NIL)
          (#4=#:G808 NIL) (|x| NIL) (#5=#:G809 NIL) (|xn| NIL)
          (|mat| (|List| (|List| (|Boolean|)))) (|obs| (|List| S)))
         (SEQ (LETT |obs| (SPADCALL |poset| (QREFELT $ 34))) (LETT |ars| NIL)
              (LETT |mat| (SPADCALL |poset| (QREFELT $ 36)))
              (SEQ (LETT |xn| 1) (LETT #5# (LENGTH |mat|)) (LETT |x| NIL)
                   (LETT #4# |mat|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL)
                         (|greater_SI| |xn| #5#))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |yn| 1) (LETT #3# (LENGTH |x|)) (LETT |y| NIL)
                          (LETT #2# |x|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |y| (CAR #2#)) NIL)
                                (|greater_SI| |yn| #3#))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             (|y|
                              (SEQ (LETT |z| (CONS |xn| |yn|))
                                   (EXIT
                                    (LETT |ars|
                                          (SPADCALL |ars| |z|
                                                    (QREFELT $ 37)))))))))
                          (LETT #2#
                                (PROG1 (CDR #2#) (LETT |yn| (|inc_SI| |yn|))))
                          (GO G190) G191 (EXIT NIL))))
                   (LETT #4# (PROG1 (CDR #4#) (LETT |xn| (|inc_SI| |xn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |obs| |ars| (QREFELT $ 32)))))) 

(SDEFUN |WGRPH;weightedGraph;LL$;7|
        ((|objs| (|List| S)) (|am| (|List| (|List| (|NonNegativeInteger|))))
         ($ ($)))
        (SPROG
         ((|ar|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (#2=#:G830 NIL) (|j| NIL) (#3=#:G829 NIL) (|i| NIL)
          (|obs|
           (|List|
            #4=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |weight| W))))
          (|o| #4#) (|ob| (S)) (#5=#:G828 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #5# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #5#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 40)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 27))
                                      (|spadConstant| $ 9)))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 19)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (LETT |ar| NIL)
              (SEQ (LETT |i| 1) (LETT #3# (LENGTH |am|)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1)
                          (LETT #2#
                                (SPADCALL (SPADCALL |am| |i| (QREFELT $ 43))
                                          (QREFELT $ 44)))
                          G190 (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((EQL
                               (SPADCALL (SPADCALL |am| |i| (QREFELT $ 43)) |j|
                                         (QREFELT $ 45))
                               1)
                              (SEQ
                               (LETT |a|
                                     (VECTOR "a" (|spadConstant| $ 9) |i| |j| 0
                                             0 NIL))
                               (EXIT
                                (LETT |ar|
                                      (SPADCALL |ar| |a| (QREFELT $ 18)))))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ar|))))) 

(SDEFUN |WGRPH;addObject!;$S$;8| ((|s| ($)) (|n| (S)) ($ ($)))
        (SPROG
         ((|obj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W)))
          (|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W)))))
         (SEQ (LETT |obs| (QCAR |s|))
              (LETT |obj| (VECTOR |n| 0 0 (|spadConstant| $ 9)))
              (COND
               ((SPADCALL |obs| NIL (QREFELT $ 48))
                (PROGN (RPLACA |s| (LIST |obj|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |obj| (QREFELT $ 19)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |WGRPH;addObject!;$R$;9|
        ((|s| ($))
         (|n|
          (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                    (|:| |posY| #1#)))
         ($ ($)))
        (SEQ
         (|error|
          "this form of addObject! not supported in multifunctionGraph")
         (EXIT (CONS NIL NIL)))) 

(SDEFUN |WGRPH;addArrow!;$R$;10|
        ((|s| ($))
         (|ar|
          (|Record| (|:| |name| (|String|))
                    (|:| |arrType| #1=(|NonNegativeInteger|))
                    (|:| |fromOb| #1#) (|:| |toOb| #1#)
                    (|:| |xOffset| #2=(|Integer|)) (|:| |yOffset| #2#)
                    (|:| |map| (|List| #1#))))
         ($ ($)))
        (SPADCALL |s| (QVELT |ar| 0) (QVELT |ar| 2) (QVELT |ar| 3)
                  (|spadConstant| $ 9) (QREFELT $ 52))) 

(SDEFUN |WGRPH;addArrow!;$S2Nni$;11|
        ((|s| ($)) (|nm| (|String|)) (|n1| #1=(|NonNegativeInteger|))
         (|n2| #1#) ($ ($)))
        (SPADCALL |s| |nm| |n1| |n2| (|spadConstant| $ 9) (QREFELT $ 52))) 

(SDEFUN |WGRPH;addWArrow!;$S2NniW$;12|
        ((|s| ($)) (|nm| (|String|)) (|n1| (|NonNegativeInteger|))
         (|n2| (|NonNegativeInteger|)) (|w| (W)) ($ ($)))
        (SPROG
         ((#1=#:G849 NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a|
           (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|arrss|
           (|List|
            (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ
          (EXIT
           (SEQ (LETT |arrss| (QCDR |s|))
                (LETT |a| (VECTOR |nm| |w| |n1| |n2| 0 0 NIL))
                (EXIT
                 (COND
                  ((NULL |arrss|)
                   (SEQ (PROGN (RPLACD |s| (LIST |a|)) (QCDR |s|))
                        (EXIT (PROGN (LETT #1# |s|) (GO #2=#:G848)))))
                  ('T
                   (SEQ (LETT |arrs| (SPADCALL |arrss| |a| (QREFELT $ 18)))
                        (PROGN (RPLACD |s| |arrs|) (QCDR |s|))
                        (EXIT (PROGN (LETT #1# |s|) (GO #2#)))))))))
          #2# (EXIT #1#)))) 

(SDEFUN |WGRPH;getVertices;$L;13|
        ((|s| ($))
         ($
          (|List|
           #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                        (|:| |posY| (|NonNegativeInteger|))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #1#) (#2=#:G857 NIL) (|soj| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |soj| NIL) (LETT #2# (QCAR |s|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |soj| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR (QVELT |soj| 0) (QVELT |soj| 1)
                                  (QVELT |soj| 2)))
                    (EXIT (LETT |res| (SPADCALL |res| |o| (QREFELT $ 28)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |WGRPH;getArrows;$L;14|
        ((|s| ($))
         ($
          (|List|
           #1=(|Record| (|:| |name| (|String|))
                        (|:| |arrType| (|NonNegativeInteger|))
                        (|:| |fromOb| (|NonNegativeInteger|))
                        (|:| |toOb| (|NonNegativeInteger|))
                        (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                        (|:| |map| (|List| (|NonNegativeInteger|)))))))
        (SPROG
         ((|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|aw| #1#) (#2=#:G865 NIL) (|a| NIL))
         (SEQ (LETT |arrs| NIL)
              (SEQ (LETT |a| NIL) (LETT #2# (QCDR |s|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |a| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |aw|
                          (VECTOR (QVELT |a| 0) 0 (QVELT |a| 2) (QVELT |a| 3)
                                  (QVELT |a| 4) (QVELT |a| 5) (QVELT |a| 6)))
                    (EXIT (LETT |arrs| (SPADCALL |arrs| |aw| (QREFELT $ 29)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |arrs|)))) 

(PUT '|WGRPH;initial;$;15| '|SPADreplace| '(XLAM NIL (CONS NIL NIL))) 

(SDEFUN |WGRPH;initial;$;15| (($ ($))) (CONS NIL NIL)) 

(SDEFUN |WGRPH;terminal;S$;16| ((|a| (S)) ($ ($)))
        (SPROG
         ((|ar|
           (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
         (SEQ (LETT |o| (VECTOR |a| 0 0 (|spadConstant| $ 9)))
              (LETT |ar| (VECTOR "loop" (|spadConstant| $ 9) 1 1 0 0 NIL))
              (EXIT (CONS (LIST |o|) (LIST |ar|)))))) 

(SDEFUN |WGRPH;cycleOpen;LS$;17|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (|next| (|NonNegativeInteger|))
          (|obs|
           (|List|
            #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |weight| W))))
          (|o| #2#) (|ob| (S)) (#3=#:G882 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #3#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 40)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 27))
                                      (|spadConstant| $ 9)))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 19)))
                        (LETT |next| (+ |obn| 1))
                        (EXIT
                         (COND
                          ((<= |next| (LENGTH |objs|))
                           (SEQ
                            (LETT |a|
                                  (VECTOR
                                   (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                   (|spadConstant| $ 9) |obn| |next| 0 0 NIL))
                            (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 18)))
                            (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |WGRPH;cycleClosed;LS$;18|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (|next| (|NonNegativeInteger|))
          (|obs|
           (|List|
            #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |weight| W))))
          (|o| #2#) (|ob| (S)) (#3=#:G893 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #3#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 40)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 27))
                                      (|spadConstant| $ 9)))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 19)))
                        (LETT |next| (+ |obn| 1))
                        (COND
                         ((EQL (- |next| 1) (LENGTH |objs|)) (LETT |next| 1)))
                        (EXIT
                         (COND
                          ((<= |next| (LENGTH |objs|))
                           (SEQ
                            (LETT |a|
                                  (VECTOR
                                   (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                   (|spadConstant| $ 9) |obn| |next| 0 0 NIL))
                            (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 18)))
                            (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |WGRPH;unit;LS$;19|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#)
          (|obs|
           (|List|
            #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |weight| W))))
          (|o| #2#) (|ob| (S)) (#3=#:G902 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #3#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 40)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 27))
                                      (|spadConstant| $ 9)))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 19)))
                        (LETT |a|
                              (VECTOR (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                      (|spadConstant| $ 9) |obn| |obn| 0 0
                                      NIL))
                        (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 18)))
                        (EXIT (LETT |arn| (+ |arn| 1))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |WGRPH;kgraph;LS$;20|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (#2=#:G916 NIL) (|obm| NIL)
          (|obs|
           (|List|
            #3=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |weight| W))))
          (|o| #3#) (|ob| (S)) (#4=#:G915 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #4# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #4#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 40)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 27))
                                      (|spadConstant| $ 9)))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 19)))
                        (EXIT
                         (SEQ (LETT |obm| 1) (LETT #2# (LENGTH |objs|)) G190
                              (COND ((|greater_SI| |obm| #2#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |obn| |obm| (QREFELT $ 62))
                                  (SEQ
                                   (LETT |a|
                                         (VECTOR
                                          (STRCONC |arrowName|
                                                   (STRINGIMAGE |arn|))
                                          (|spadConstant| $ 9) |obn| |obm| 0 0
                                          NIL))
                                   (LETT |ars|
                                         (SPADCALL |ars| |a| (QREFELT $ 18)))
                                   (EXIT (LETT |arn| (+ |arn| 1))))))))
                              (LETT |obm| (|inc_SI| |obm|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |WGRPH;+;3$;21| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|la|
           (|List|
            (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|lb|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (#2=#:G925 NIL) (|ba| NIL)
          (|bStart| (|NonNegativeInteger|))
          (|lo|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W)))))
         (SEQ (LETT |lo| (SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 64)))
              (LETT |bStart| (LENGTH (QCAR |a|))) (LETT |lb| NIL)
              (SEQ (LETT |ba| NIL) (LETT #2# (QCDR |b|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |ba| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |arr|
                          (VECTOR (QVELT |ba| 0) (QVELT |ba| 1)
                                  (+ (QVELT |ba| 2) |bStart|)
                                  (+ (QVELT |ba| 3) |bStart|) (QVELT |ba| 4)
                                  (QVELT |ba| 5) (QVELT |ba| 6)))
                    (EXIT (LETT |lb| (SPADCALL |lb| |arr| (QREFELT $ 18)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |la| (SPADCALL (QCDR |a|) |lb| (QREFELT $ 65)))
              (EXIT (CONS |lo| |la|))))) 

(SDEFUN |WGRPH;merge;3$;22| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|la|
           (|List|
            (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|lb|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|fromI| #2=(|NonNegativeInteger|)) (|toI| #2#)
          (#3=#:G949 NIL) (|ba| NIL) (|bStart| #4=(|NonNegativeInteger|))
          (|bmap| (|List| (|NonNegativeInteger|))) (#5=#:G936 NIL)
          (|newIndex| #4#)
          (|mergedObjects|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
          (|i| (|Integer|)) (#6=#:G948 NIL) (|bob| NIL) (#7=#:G947 NIL)
          (|x| NIL) (#8=#:G946 NIL))
         (SEQ
          (LETT |bmap|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |x| 1) (LETT #7# (LENGTH (QCAR |a|))) G190
                      (COND ((|greater_SI| |x| #7#) (GO G191)))
                      (SEQ (EXIT (LETT #8# (CONS |x| #8#))))
                      (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |newIndex| (LENGTH (QCAR |a|)))
          (LETT |mergedObjects| (QCAR |a|))
          (SEQ (LETT |bob| NIL) (LETT #6# (QCAR |b|)) G190
               (COND
                ((OR (ATOM #6#) (PROGN (LETT |bob| (CAR #6#)) NIL)) (GO G191)))
               (SEQ (LETT |i| (SPADCALL |bob| (QCAR |a|) (QREFELT $ 67)))
                    (EXIT
                     (COND
                      ((< |i| 1)
                       (SEQ
                        (LETT |mergedObjects|
                              (SPADCALL |mergedObjects| |bob| (QREFELT $ 19)))
                        (LETT |newIndex| (+ |newIndex| 1))
                        (EXIT
                         (LETT |bmap|
                               (SPADCALL |bmap| |newIndex| (QREFELT $ 68))))))
                      ('T
                       (LETT |bmap|
                             (SPADCALL |bmap|
                                       (PROG1 (LETT #5# |i|)
                                         (|check_subtype2| (>= #5# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #5#))
                                       (QREFELT $ 68)))))))
               (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
          (LETT |bStart| (LENGTH (QCAR |a|))) (LETT |lb| NIL)
          (SEQ (LETT |ba| NIL) (LETT #3# (QCDR |b|)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |ba| (CAR #3#)) NIL)) (GO G191)))
               (SEQ
                (LETT |toI|
                      (SPADCALL |bmap| (+ (QVELT |ba| 3) |bStart|)
                                (QREFELT $ 45)))
                (LETT |fromI|
                      (SPADCALL |bmap| (+ (QVELT |ba| 2) |bStart|)
                                (QREFELT $ 45)))
                (LETT |arr|
                      (VECTOR (QVELT |ba| 0) (QVELT |ba| 1) |fromI| |toI|
                              (QVELT |ba| 4) (QVELT |ba| 5) (QVELT |ba| 6)))
                (EXIT (LETT |lb| (SPADCALL |lb| |arr| (QREFELT $ 18)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (LETT |la| (SPADCALL (QCDR |a|) |lb| (QREFELT $ 65)))
          (EXIT (CONS |mergedObjects| |la|))))) 

(SDEFUN |WGRPH;objProd|
        ((|a| ($)) (|b| ($))
         ($
          (|List|
           (|Record| (|:| |value| (|Product| S S))
                     (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W)))))
        (SPROG
         ((|newObjs|
           (|List|
            (|Record| (|:| |value| (|Product| S S))
                      (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
          (|ob|
           (|Record| (|:| |value| (|Product| S S))
                     (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W)))
          (|sp| (|Product| S S)) (|y| #1=(|NonNegativeInteger|)) (|x| #1#)
          (|byi| #2=(|NonNegativeInteger|)) (|bxi| #3=(|NonNegativeInteger|))
          (|bi| (S)) (#4=#:G963 NIL) (|boi| NIL) (|ayi| #2#) (|axi| #3#)
          (|ai| (S)) (#5=#:G962 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #5# (QCAR |a|)) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |aoi| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ai| (QVELT |aoi| 0))
                        (LETT |axi| (QVELT |aoi| 1))
                        (LETT |ayi| (QVELT |aoi| 2))
                        (EXIT
                         (SEQ (LETT |boi| NIL) (LETT #4# (QCAR |b|)) G190
                              (COND
                               ((OR (ATOM #4#)
                                    (PROGN (LETT |boi| (CAR #4#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |bi| (QVELT |boi| 0))
                                   (LETT |bxi| (QVELT |boi| 1))
                                   (LETT |byi| (QVELT |boi| 2))
                                   (LETT |x|
                                         (+
                                          (* |bxi|
                                             (SPADCALL |a| (QREFELT $ 70)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 71)))
                                          |ayi|))
                                   (LETT |sp|
                                         (SPADCALL |ai| |bi| (QREFELT $ 73)))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y|
                                                 (|spadConstant| $ 9)))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 76)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |newObjs|)))) 

(SDEFUN |WGRPH;indexProd|
        ((|aObj| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G964 NIL))
               (+ |a|
                  (*
                   (PROG1 (LETT #1# (- |b| 1))
                     (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #1#))
                   (LENGTH (QCAR |aObj|)))))) 

(SDEFUN |WGRPH;*;2$Wg;25|
        ((|a| ($)) (|b| ($)) ($ (|WeightedGraph| (|Product| S S) W)))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G992 NIL) (|bv| NIL)
          (#3=#:G991 NIL) (|bu| NIL) (#4=#:G990 NIL) (|av| NIL) (#5=#:G989 NIL)
          (|au| NIL))
         (SEQ (LETT |newArrs| NIL)
              (SEQ (LETT |au| 1) (LETT #5# (LENGTH (QCAR |a|))) G190
                   (COND ((|greater_SI| |au| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |av| 1) (LETT #4# (LENGTH (QCAR |a|))) G190
                          (COND ((|greater_SI| |av| #4#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |bu| 1) (LETT #3# (LENGTH (QCAR |b|)))
                                 G190
                                 (COND ((|greater_SI| |bu| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |bv| 1)
                                        (LETT #2# (LENGTH (QCAR |b|))) G190
                                        (COND
                                         ((|greater_SI| |bv| #2#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |a| |au| |av|
                                                      (QREFELT $ 77))
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 77))
                                              (SEQ
                                               (LETT |an|
                                                     (SPADCALL
                                                      (LIST
                                                       (SPADCALL |a| |au| |av|
                                                                 (QREFELT $
                                                                          78))
                                                       "*"
                                                       (SPADCALL |b| |bu| |bv|
                                                                 (QREFELT $
                                                                          78)))
                                                      (QREFELT $ 80)))
                                               (LETT |arr|
                                                     (VECTOR |an|
                                                             (|spadConstant| $
                                                                             9)
                                                             (|WGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|WGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         18)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|WGRPH;objProd| |a| |b| $) |newArrs|
                         (QREFELT $ 82)))))) 

(SDEFUN |WGRPH;cartesian;2$Wg;26|
        ((|a| ($)) (|b| ($)) ($ (|WeightedGraph| (|Product| S S) W)))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G1021 NIL) (|bv| NIL)
          (#3=#:G1020 NIL) (|bu| NIL) (#4=#:G1019 NIL) (|av| NIL)
          (#5=#:G1018 NIL) (|au| NIL))
         (SEQ (LETT |newArrs| NIL)
              (SEQ (LETT |au| 1) (LETT #5# (LENGTH (QCAR |a|))) G190
                   (COND ((|greater_SI| |au| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |av| 1) (LETT #4# (LENGTH (QCAR |a|))) G190
                          (COND ((|greater_SI| |av| #4#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |bu| 1) (LETT #3# (LENGTH (QCAR |b|)))
                                 G190
                                 (COND ((|greater_SI| |bu| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |bv| 1)
                                        (LETT #2# (LENGTH (QCAR |b|))) G190
                                        (COND
                                         ((|greater_SI| |bv| #2#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((EQL |bu| |bv|)
                                            (COND
                                             ((SPADCALL |a| |au| |av|
                                                        (QREFELT $ 77))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            77))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              78))
                                                           #6="#"
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 80)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              78))
                                                           #7="#"
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 80)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            78))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 80)))))
                                               (LETT |arr|
                                                     (VECTOR |an|
                                                             (|spadConstant| $
                                                                             9)
                                                             (|WGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|WGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         18))))))
                                             ((EQL |au| |av|)
                                              (COND
                                               ((SPADCALL |b| |bu| |bv|
                                                          (QREFELT $ 77))
                                                (SEQ
                                                 (LETT |an|
                                                       (COND
                                                        ((EQL |bu| |bv|)
                                                         (COND
                                                          ((SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              77))
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |a| |au|
                                                                       |av|
                                                                       (QREFELT
                                                                        $ 78))
                                                             #6#
                                                             (STRINGIMAGE
                                                              |bv|))
                                                            (QREFELT $ 80)))
                                                          ('T
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |b| |bu|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 78))
                                                             #7#
                                                             (STRINGIMAGE
                                                              |av|))
                                                            (QREFELT $ 80)))))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              78))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 80)))))
                                                 (LETT |arr|
                                                       (VECTOR |an|
                                                               (|spadConstant|
                                                                $ 9)
                                                               (|WGRPH;indexProd|
                                                                |b| |bu| |au|
                                                                $)
                                                               (|WGRPH;indexProd|
                                                                |b| |bv| |av|
                                                                $)
                                                               0 0 NIL))
                                                 (EXIT
                                                  (LETT |newArrs|
                                                        (SPADCALL |newArrs|
                                                                  |arr|
                                                                  (QREFELT $
                                                                           18))))))))))
                                           ((EQL |au| |av|)
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 77))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            77))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              78))
                                                           #6#
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 80)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              78))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 80)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            78))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 80)))))
                                               (LETT |arr|
                                                     (VECTOR |an|
                                                             (|spadConstant| $
                                                                             9)
                                                             (|WGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|WGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         18)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|WGRPH;objProd| |a| |b| $) |newArrs|
                         (QREFELT $ 82)))))) 

(SDEFUN |WGRPH;closedObjProd|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S))
         ($
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W)))))
        (SPROG
         ((|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
          (|ob|
           (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                     (|:| |posY| #2=(|NonNegativeInteger|)) (|:| |weight| W)))
          (|sp| (S)) (|y| #3=(|NonNegativeInteger|)) (|x| #3#) (|byi| #2#)
          (|bxi| #1#) (|bi| (S)) (#4=#:G1032 NIL) (|boi| NIL) (|ayi| #2#)
          (|axi| #1#) (|ai| (S)) (#5=#:G1031 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #5# (QCAR |a|)) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |aoi| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ai| (QVELT |aoi| 0))
                        (LETT |axi| (QVELT |aoi| 1))
                        (LETT |ayi| (QVELT |aoi| 2))
                        (EXIT
                         (SEQ (LETT |boi| NIL) (LETT #4# (QCAR |b|)) G190
                              (COND
                               ((OR (ATOM #4#)
                                    (PROGN (LETT |boi| (CAR #4#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |bi| (QVELT |boi| 0))
                                   (LETT |bxi| (QVELT |boi| 1))
                                   (LETT |byi| (QVELT |boi| 2))
                                   (LETT |x|
                                         (+
                                          (* |bxi|
                                             (SPADCALL |a| (QREFELT $ 70)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 71)))
                                          |ayi|))
                                   (LETT |sp| (SPADCALL |ai| |bi| |f|))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y|
                                                 (|spadConstant| $ 9)))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 19)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |newObjs|)))) 

(SDEFUN |WGRPH;closedTensor;2$M$;28|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G1057 NIL) (|bv| NIL)
          (#3=#:G1056 NIL) (|bu| NIL) (#4=#:G1055 NIL) (|av| NIL)
          (#5=#:G1054 NIL) (|au| NIL))
         (SEQ (LETT |newArrs| NIL)
              (SEQ (LETT |au| 1) (LETT #5# (LENGTH (QCAR |a|))) G190
                   (COND ((|greater_SI| |au| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |av| 1) (LETT #4# (LENGTH (QCAR |a|))) G190
                          (COND ((|greater_SI| |av| #4#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |bu| 1) (LETT #3# (LENGTH (QCAR |b|)))
                                 G190
                                 (COND ((|greater_SI| |bu| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |bv| 1)
                                        (LETT #2# (LENGTH (QCAR |b|))) G190
                                        (COND
                                         ((|greater_SI| |bv| #2#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |a| |au| |av|
                                                      (QREFELT $ 77))
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 77))
                                              (SEQ
                                               (LETT |an|
                                                     (SPADCALL
                                                      (LIST
                                                       (SPADCALL |a| |au| |av|
                                                                 (QREFELT $
                                                                          78))
                                                       "*"
                                                       (SPADCALL |b| |bu| |bv|
                                                                 (QREFELT $
                                                                          78)))
                                                      (QREFELT $ 80)))
                                               (LETT |arr|
                                                     (VECTOR |an|
                                                             (|spadConstant| $
                                                                             9)
                                                             (|WGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|WGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         18)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|WGRPH;closedObjProd| |a| |b| |f| $) |newArrs|
                         (QREFELT $ 17)))))) 

(SDEFUN |WGRPH;closedCartesian;2$M$;29|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G1087 NIL) (|bv| NIL)
          (#3=#:G1086 NIL) (|bu| NIL) (#4=#:G1085 NIL) (|av| NIL)
          (#5=#:G1084 NIL) (|au| NIL))
         (SEQ (LETT |newArrs| NIL)
              (SEQ (LETT |au| 1) (LETT #5# (LENGTH (QCAR |a|))) G190
                   (COND ((|greater_SI| |au| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |av| 1) (LETT #4# (LENGTH (QCAR |a|))) G190
                          (COND ((|greater_SI| |av| #4#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |bu| 1) (LETT #3# (LENGTH (QCAR |b|)))
                                 G190
                                 (COND ((|greater_SI| |bu| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |bv| 1)
                                        (LETT #2# (LENGTH (QCAR |b|))) G190
                                        (COND
                                         ((|greater_SI| |bv| #2#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((EQL |bu| |bv|)
                                            (COND
                                             ((SPADCALL |a| |au| |av|
                                                        (QREFELT $ 77))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            77))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              78))
                                                           #6="#"
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 80)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              78))
                                                           #7="#"
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 80)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            78))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 80)))))
                                               (LETT |arr|
                                                     (VECTOR |an|
                                                             (|spadConstant| $
                                                                             9)
                                                             (|WGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|WGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         18))))))
                                             ((EQL |au| |av|)
                                              (COND
                                               ((SPADCALL |b| |bu| |bv|
                                                          (QREFELT $ 77))
                                                (SEQ
                                                 (LETT |an|
                                                       (COND
                                                        ((EQL |bu| |bv|)
                                                         (COND
                                                          ((SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              77))
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |a| |au|
                                                                       |av|
                                                                       (QREFELT
                                                                        $ 78))
                                                             #6#
                                                             (STRINGIMAGE
                                                              |bv|))
                                                            (QREFELT $ 80)))
                                                          ('T
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |b| |bu|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 78))
                                                             #7#
                                                             (STRINGIMAGE
                                                              |av|))
                                                            (QREFELT $ 80)))))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              78))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 80)))))
                                                 (LETT |arr|
                                                       (VECTOR |an|
                                                               (|spadConstant|
                                                                $ 9)
                                                               (|WGRPH;indexProd|
                                                                |b| |bu| |au|
                                                                $)
                                                               (|WGRPH;indexProd|
                                                                |b| |bv| |av|
                                                                $)
                                                               0 0 NIL))
                                                 (EXIT
                                                  (LETT |newArrs|
                                                        (SPADCALL |newArrs|
                                                                  |arr|
                                                                  (QREFELT $
                                                                           18))))))))))
                                           ((EQL |au| |av|)
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 77))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            77))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              78))
                                                           #6#
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 80)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              78))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 80)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            78))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 80)))))
                                               (LETT |arr|
                                                     (VECTOR |an|
                                                             (|spadConstant| $
                                                                             9)
                                                             (|WGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|WGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         18)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|WGRPH;closedObjProd| |a| |b| |f| $) |newArrs|
                         (QREFELT $ 17)))))) 

(SDEFUN |WGRPH;map;$LL2I$;30|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #2=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newArr| #2#) (#3=#:G1107 NIL) (|oldArrow| NIL) (#4=#:G1094 NIL)
          (#5=#:G1093 NIL) (|i| (|NonNegativeInteger|)) (#6=#:G1106 NIL)
          (|oi| NIL)
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
          (#7=#:G1105 NIL) (|o| NIL) (#8=#:G1104 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |o| NIL) (LETT #7# |newOb|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |o| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8#
                              (CONS (VECTOR |o| 0 0 (|spadConstant| $ 9))
                                    #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (SEQ (LETT |oi| 1) (LETT #6# (LENGTH (QCAR |s|))) G190
               (COND ((|greater_SI| |oi| #6#) (GO G191)))
               (SEQ (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 45)))
                    (EXIT
                     (SPADCALL |newObjs| |i|
                               (VECTOR
                                (QVELT (SPADCALL |newObjs| |i| (QREFELT $ 88))
                                       0)
                                (PROG1
                                    (LETT #5#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 88))
                                            1)
                                           |offsetX|))
                                  (|check_subtype2| (>= #5# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #5#))
                                (PROG1
                                    (LETT #4#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 88))
                                            2)
                                           |offsetY|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#))
                                (|spadConstant| $ 9))
                               (QREFELT $ 89))))
               (LETT |oi| (|inc_SI| |oi|)) (GO G190) G191 (EXIT NIL))
          (LETT |newArrs| NIL)
          (SEQ (LETT |oldArrow| NIL) (LETT #3# (QCDR |s|)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |oldArrow| (CAR #3#)) NIL))
                 (GO G191)))
               (SEQ
                (LETT |newArr|
                      (VECTOR (QVELT |oldArrow| 0) (QVELT |oldArrow| 1)
                              (SPADCALL |m| (QVELT |oldArrow| 2)
                                        (QREFELT $ 45))
                              (SPADCALL |m| (QVELT |oldArrow| 3)
                                        (QREFELT $ 45))
                              (QVELT |oldArrow| 4) (QVELT |oldArrow| 5)
                              (QVELT |oldArrow| 6)))
                (EXIT
                 (LETT |newArrs|
                       (SPADCALL |newArrs| |newArr| (QREFELT $ 18)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |newObjs| |newArrs|))))) 

(SDEFUN |WGRPH;mapContra;$LL2I$;31|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #2=(|Record| (|:| |name| (|String|)) (|:| |weight| W)
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newArr| #2#) (#3=#:G1127 NIL) (|oldArrow| NIL) (#4=#:G1114 NIL)
          (#5=#:G1113 NIL) (|i| (|NonNegativeInteger|)) (#6=#:G1126 NIL)
          (|oi| NIL)
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)) (|:| |weight| W))))
          (#7=#:G1125 NIL) (|o| NIL) (#8=#:G1124 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |o| NIL) (LETT #7# |newOb|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |o| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8#
                              (CONS (VECTOR |o| 0 0 (|spadConstant| $ 9))
                                    #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (SEQ (LETT |oi| 1) (LETT #6# (LENGTH (QCAR |s|))) G190
               (COND ((|greater_SI| |oi| #6#) (GO G191)))
               (SEQ (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 45)))
                    (EXIT
                     (SPADCALL |newObjs| |i|
                               (VECTOR
                                (QVELT (SPADCALL |newObjs| |i| (QREFELT $ 88))
                                       0)
                                (PROG1
                                    (LETT #5#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 88))
                                            1)
                                           |offsetX|))
                                  (|check_subtype2| (>= #5# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #5#))
                                (PROG1
                                    (LETT #4#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 88))
                                            2)
                                           |offsetY|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#))
                                (|spadConstant| $ 9))
                               (QREFELT $ 89))))
               (LETT |oi| (|inc_SI| |oi|)) (GO G190) G191 (EXIT NIL))
          (LETT |newArrs| NIL)
          (SEQ (LETT |oldArrow| NIL) (LETT #3# (QCDR |s|)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |oldArrow| (CAR #3#)) NIL))
                 (GO G191)))
               (SEQ
                (LETT |newArr|
                      (VECTOR (QVELT |oldArrow| 0) (QVELT |oldArrow| 1)
                              (SPADCALL |m| (QVELT |oldArrow| 3)
                                        (QREFELT $ 45))
                              (SPADCALL |m| (QVELT |oldArrow| 2)
                                        (QREFELT $ 45))
                              (QVELT |oldArrow| 4) (QVELT |oldArrow| 5)
                              (QVELT |oldArrow| 6)))
                (EXIT
                 (LETT |newArrs|
                       (SPADCALL |newArrs| |newArr| (QREFELT $ 18)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |newObjs| |newArrs|))))) 

(SDEFUN |WGRPH;routeNodeRecursive|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         (|visited| (|List| (|NonNegativeInteger|)))
         ($ #1=(|List| (|NonNegativeInteger|))))
        (SPROG
         ((#2=#:G1141 NIL) (|shortest| (|List| (|NonNegativeInteger|)))
          (|d| #1#) (#3=#:G1142 NIL) (|arr| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((> (SPADCALL |visited| (QREFELT $ 44))
                 (LENGTH (SPADCALL |s| (QREFELT $ 55))))
              (PROGN (LETT #2# NIL) (GO #4=#:G1140))))
            (LETT |shortest| NIL)
            (COND ((EQL |a| |b|) (PROGN (LETT #2# (LIST |a|)) (GO #4#))))
            (COND
             ((SPADCALL |s| |a| |b| (QREFELT $ 77))
              (PROGN (LETT #2# (LIST |a| |b|)) (GO #4#))))
            (SEQ (LETT |arr| NIL) (LETT #3# (SPADCALL |s| (QREFELT $ 56))) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |arr| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |s| |a| (QVELT |arr| 2) (QREFELT $ 77))
                     (SEQ
                      (LETT |d|
                            (|WGRPH;routeNodeRecursive| |s| (QVELT |arr| 2) |b|
                             (SPADCALL |visited| |a| (QREFELT $ 68)) $))
                      (EXIT
                       (COND
                        ((SPADCALL |shortest| NIL (QREFELT $ 92))
                         (LETT |shortest| |d|))
                        ((SPADCALL |d| NIL (QREFELT $ 93))
                         (COND
                          ((SPADCALL
                            (SPADCALL |s| (CONS |a| |d|) (QREFELT $ 94))
                            (SPADCALL |s| (CONS |a| |shortest|) (QREFELT $ 94))
                            (QREFELT $ 95))
                           (LETT |shortest| |d|)))))))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL |shortest| NIL (QREFELT $ 92))
              (PROGN (LETT #2# NIL) (GO #4#))))
            (EXIT (CONS |a| |shortest|))))
          #4# (EXIT #2#)))) 

(SDEFUN |WGRPH;routeNodes;$2NniL;33|
        ((|s| ($)) (|a| #1=(|NonNegativeInteger|)) (|b| #1#)
         ($ (|List| (|NonNegativeInteger|))))
        (|WGRPH;routeNodeRecursive| |s| |a| |b| NIL $)) 

(SDEFUN |WGRPH;routeArrowRecursive|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         (|visited| (|List| (|NonNegativeInteger|)))
         ($ #1=(|List| (|NonNegativeInteger|))))
        (SPROG
         ((#2=#:G1160 NIL)
          (|shortestFullPath| (|List| #3=(|NonNegativeInteger|)))
          (|shortest| (|List| #3#))
          (|fullPath| (|List| (|NonNegativeInteger|))) (|d| #1#) (|aa| #3#)
          (#4=#:G1161 NIL) (|arr| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arrn| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((> (SPADCALL |visited| (QREFELT $ 44))
                 (LENGTH (SPADCALL |s| (QREFELT $ 55))))
              (PROGN (LETT #2# (LIST 0)) (GO #5=#:G1159))))
            (LETT |shortest| (LIST 0))
            (COND ((EQL |a| |b|) (PROGN (LETT #2# NIL) (GO #5#))))
            (LETT |arrn| (SPADCALL |s| |a| |b| (QREFELT $ 97)))
            (COND
             ((SPADCALL |arrn| 0 (QREFELT $ 62))
              (PROGN (LETT #2# (LIST |arrn|)) (GO #5#))))
            (LETT |aa| 0) (LETT |shortestFullPath| (LIST 0))
            (LETT |arrs| (SPADCALL |s| (QREFELT $ 56)))
            (SEQ (LETT |arr| NIL) (LETT #4# |arrs|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |arr| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |s| |a| (QVELT |arr| 2) (QREFELT $ 77))
                     (SEQ
                      (LETT |aa|
                            (SPADCALL |s| |a| (QVELT |arr| 2) (QREFELT $ 97)))
                      (LETT |d|
                            (|WGRPH;routeArrowRecursive| |s| (QVELT |arr| 2)
                             |b| (SPADCALL |visited| |a| (QREFELT $ 68)) $))
                      (LETT |fullPath| (CONS |aa| |d|))
                      (EXIT
                       (COND
                        ((SPADCALL |shortest| (LIST 0) (QREFELT $ 92))
                         (SEQ (LETT |shortest| |d|)
                              (EXIT (LETT |shortestFullPath| |fullPath|))))
                        ((SPADCALL |d| (LIST 0) (QREFELT $ 93))
                         (COND
                          ((SPADCALL (SPADCALL |s| |fullPath| (QREFELT $ 98))
                                     (SPADCALL |s| |shortestFullPath|
                                               (QREFELT $ 98))
                                     (QREFELT $ 95))
                           (SEQ (LETT |shortest| |d|)
                                (EXIT
                                 (LETT |shortestFullPath|
                                       |fullPath|)))))))))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL |shortest| (LIST 0) (QREFELT $ 92))
              (PROGN (LETT #2# (LIST 0)) (GO #5#))))
            (EXIT |shortestFullPath|)))
          #5# (EXIT #2#)))) 

(SDEFUN |WGRPH;routeArrows;$2NniL;35|
        ((|s| ($)) (|a| #1=(|NonNegativeInteger|)) (|b| #1#)
         ($ (|List| (|NonNegativeInteger|))))
        (|WGRPH;routeArrowRecursive| |s| |a| |b| NIL $)) 

(SDEFUN |WGRPH;distanceWeighted;$2NniU;36|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Union| W "disjoint")))
        (SPROG ((#1=#:G1173 NIL) (|r| (|List| (|NonNegativeInteger|))))
               (SEQ
                (EXIT
                 (SEQ (LETT |r| (|WGRPH;routeNodeRecursive| |s| |a| |b| NIL $))
                      (COND
                       ((EQL (SPADCALL |r| (QREFELT $ 44)) 0)
                        (PROGN
                         (LETT #1# (CONS 1 "disjoint"))
                         (GO #2=#:G1172))))
                      (EXIT (CONS 0 (SPADCALL |s| |r| (QREFELT $ 94))))))
                #2# (EXIT #1#)))) 

(SDEFUN |WGRPH;getWeightBetween|
        ((|s| ($)) (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         ($ (W)))
        (SPROG
         ((|res| (W)) (|isDisjoint| (|Boolean|)) (#1=#:G1186 NIL) (|arr| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |isDisjoint| 'T) (LETT |res| (|spadConstant| $ 9))
              (LETT |arrs| (QCDR |s|))
              (SEQ (LETT |arr| NIL) (LETT #1# |arrs|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |arr| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      (|isDisjoint|
                       (COND
                        ((EQL (QVELT |arr| 2) |i1|)
                         (COND
                          ((EQL (QVELT |arr| 3) |i2|)
                           (SEQ (LETT |res| (QVELT |arr| 1))
                                (EXIT (LETT |isDisjoint| NIL))))))))
                      ((EQL (QVELT |arr| 2) |i1|)
                       (COND
                        ((EQL (QVELT |arr| 3) |i2|)
                         (COND
                          ((SPADCALL (QVELT |arr| 1) |res| (QREFELT $ 95))
                           (LETT |res| (QVELT |arr| 1))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |WGRPH;routeNodeWeight;$LW;38|
        ((|s| ($)) (|r| (|List| (|NonNegativeInteger|))) ($ (W)))
        (SPROG
         ((|lasti| (|NonNegativeInteger|)) (|fst| (|Boolean|)) (|res| (W))
          (|w| (W)) (#1=#:G1193 NIL) (|i| NIL))
         (SEQ (LETT |res| (|spadConstant| $ 9)) (LETT |fst| 'T)
              (LETT |lasti| 0)
              (SEQ (LETT |i| NIL) (LETT #1# |r|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((NULL |fst|)
                      (SEQ
                       (LETT |w| (|WGRPH;getWeightBetween| |s| |lasti| |i| $))
                       (EXIT
                        (LETT |res| (SPADCALL |res| |w| (QREFELT $ 102)))))))
                    (LETT |fst| NIL) (EXIT (LETT |lasti| |i|)))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |WGRPH;routeArrowWeight;$LW;39|
        ((|s| ($)) (|r| (|List| (|NonNegativeInteger|))) ($ (W)))
        (SPROG
         ((|res| (W))
          (|a|
           (|Record| (|:| |name| (|String|)) (|:| |weight| W)
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (#1=#:G1200 NIL) (|i| NIL))
         (SEQ (LETT |res| (|spadConstant| $ 9))
              (SEQ (LETT |i| NIL) (LETT #1# |r|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |a| (SPADCALL (QCDR |s|) |i| (QREFELT $ 103)))
                        (EXIT
                         (LETT |res|
                               (SPADCALL |res| (QVELT |a| 1)
                                         (QREFELT $ 102)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |WGRPH;weightedDistanceMatrix;$Tda;40|
        ((|s| ($)) ($ (|TwoDimensionalArray| (|Union| W #1="disjoint"))))
        (SPROG
         ((#2=#:G1216 NIL) (|v| NIL) (#3=#:G1215 NIL) (|u| NIL)
          (|m| (|TwoDimensionalArray| (|Union| W #1#)))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH (SPADCALL |s| (QREFELT $ 55))))
              (LETT |m| (MAKE_MATRIX1 |n| |n| (CONS 0 (|spadConstant| $ 9))))
              (SEQ (LETT |u| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |u| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |v| 1) (LETT #2# |n|) G190
                          (COND ((|greater_SI| |v| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (QSETAREF2O |m| |u| |v|
                                        (SPADCALL |s| |u| |v| (QREFELT $ 101))
                                        1 1)))
                          (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |u| (|inc_SI| |u|)) (GO G190) G191 (EXIT NIL))
              (EXIT |m|)))) 

(SDEFUN |WGRPH;coerce;Fp$;41| ((|poset| (|FinitePoset| S)) ($ ($)))
        (SPADCALL |poset| (QREFELT $ 38))) 

(DECLAIM (NOTINLINE |WeightedGraph;|)) 

(DEFUN |WeightedGraph| (&REST #1=#:G1221)
  (SPROG NIL
         (PROG (#2=#:G1222)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|WeightedGraph|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |WeightedGraph;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|WeightedGraph|)))))))))) 

(DEFUN |WeightedGraph;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|WeightedGraph| DV$1 DV$2))
          (LETT $ (GETREFV 118))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|WeightedGraph| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record|
                     (|:| |objects|
                          (|List|
                           (|Record| (|:| |value| |#1|)
                                     (|:| |posX| (|NonNegativeInteger|))
                                     (|:| |posY| (|NonNegativeInteger|))
                                     (|:| |weight| |#2|))))
                     (|:| |arrows|
                          (|List|
                           (|Record| (|:| |name| (|String|))
                                     (|:| |weight| |#2|)
                                     (|:| |fromOb| (|NonNegativeInteger|))
                                     (|:| |toOb| (|NonNegativeInteger|))
                                     (|:| |xOffset| (|Integer|))
                                     (|:| |yOffset| (|Integer|))
                                     (|:| |map|
                                          (|List| (|NonNegativeInteger|))))))))
          $))) 

(MAKEPROP '|WeightedGraph| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (0 . |Zero|) (|List| 6) |WGRPH;weightedGraph;L$;1|
              (|Record| (|:| |value| 6) (|:| |posX| 25) (|:| |posY| 25)
                        (|:| |weight| 7))
              (|List| 12) |WGRPH;weightedGraph;L$;2|
              (|Record| (|:| |name| 51) (|:| |weight| 7) (|:| |fromOb| 25)
                        (|:| |toOb| 25) (|:| |xOffset| 39) (|:| |yOffset| 39)
                        (|:| |map| 41))
              (|List| 15) |WGRPH;weightedGraph;LL$;3| (4 . |concat|)
              (10 . |concat|)
              (|Record| (|:| |value| 6) (|:| |posX| 25) (|:| |posY| 25))
              (|List| 20)
              (|Record| (|:| |name| 51) (|:| |arrType| 25) (|:| |fromOb| 25)
                        (|:| |toOb| 25) (|:| |xOffset| 39) (|:| |yOffset| 39)
                        (|:| |map| 41))
              (|List| 22) |WGRPH;weightedGraph;LL$;4| (|NonNegativeInteger|)
              (16 . |createX|) (22 . |createY|) (28 . |concat|) (34 . |concat|)
              (|Record| (|:| |fromOb| 25) (|:| |toOb| 25)) (|List| 30)
              |WGRPH;weightedGraph;LL$;5| (|FinitePoset| 6) (40 . |getVert|)
              (|List| (|List| 47)) (45 . |getArr|) (50 . |concat|)
              |WGRPH;weightedGraph;Fp$;6| (|Integer|) (56 . |elt|) (|List| 25)
              (|List| 41) (62 . |elt|) (68 . |#|) (73 . |elt|)
              |WGRPH;weightedGraph;LL$;7| (|Boolean|) (79 . =)
              |WGRPH;addObject!;$S$;8| |WGRPH;addObject!;$R$;9| (|String|)
              |WGRPH;addWArrow!;$S2NniW$;12| |WGRPH;addArrow!;$R$;10|
              |WGRPH;addArrow!;$S2Nni$;11| |WGRPH;getVertices;$L;13|
              |WGRPH;getArrows;$L;14| |WGRPH;initial;$;15|
              |WGRPH;terminal;S$;16| |WGRPH;cycleOpen;LS$;17|
              |WGRPH;cycleClosed;LS$;18| |WGRPH;unit;LS$;19| (85 . ~=)
              |WGRPH;kgraph;LS$;20| (91 . |concat|) (97 . |concat|)
              |WGRPH;+;3$;21| (103 . |position|) (109 . |concat|)
              |WGRPH;merge;3$;22| (115 . |diagramWidth|)
              (120 . |diagramHeight|) (|Product| 6 6) (125 . |construct|)
              (|Record| (|:| |value| 72) (|:| |posX| 25) (|:| |posY| 25)
                        (|:| |weight| 7))
              (|List| 74) (131 . |concat|) (137 . |isDirectSuccessor?|)
              (144 . |arrowName|) (|List| $) (151 . |concat|)
              (|WeightedGraph| 72 7) (156 . |weightedGraph|) |WGRPH;*;2$Wg;25|
              |WGRPH;cartesian;2$Wg;26| (|Mapping| 6 6 6)
              |WGRPH;closedTensor;2$M$;28| |WGRPH;closedCartesian;2$M$;29|
              (162 . |elt|) (168 . |setelt!|) |WGRPH;map;$LL2I$;30|
              |WGRPH;mapContra;$LL2I$;31| (175 . =) (181 . ~=)
              |WGRPH;routeNodeWeight;$LW;38| (187 . <)
              |WGRPH;routeNodes;$2NniL;33| (193 . |getArrowIndex|)
              |WGRPH;routeArrowWeight;$LW;39| |WGRPH;routeArrows;$2NniL;35|
              (|Union| 7 '"disjoint") |WGRPH;distanceWeighted;$2NniU;36|
              (200 . +) (206 . |elt|) (|TwoDimensionalArray| 100)
              |WGRPH;weightedDistanceMatrix;$Tda;40| |WGRPH;coerce;Fp$;41|
              (|Void|) (|Scene| (|SCartesian| '2)) (|Matrix| 39) (|Matrix| 25)
              (|List| (|Loop|)) (|Tree| 39) (|List| 112) (|DirectedGraph| $)
              (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#(~= 212 |weightedGraph| 218 |weightedDistanceMatrix| 257 |unit|
              262 |terminal| 268 |subdiagramSvg| 273 |spanningTreeNode| 281
              |spanningTreeArrow| 287 |spanningForestNode| 293
              |spanningForestArrow| 298 |routeNodes| 303 |routeNodeWeight| 310
              |routeArrows| 316 |routeArrowWeight| 323 |outDegree| 329
              |nodeToNode| 335 |nodeToArrow| 341 |nodeFromNode| 347
              |nodeFromArrow| 353 |min| 359 |merge| 370 |max| 376 |mapContra|
              387 |map| 396 |looseEquals| 405 |loopsNodes| 411 |loopsAtNode|
              416 |loopsArrows| 422 |latex| 427 |laplacianMatrix| 432 |kgraph|
              437 |isGreaterThan?| 443 |isFunctional?| 450 |isFixPoint?| 455
              |isDirected?| 461 |isDirectSuccessor?| 465 |isAcyclic?| 472
              |initial| 477 |incidenceMatrix| 481 |inDegree| 486 |hashUpdate!|
              492 |hash| 498 |getVertices| 503 |getVertexIndex| 508 |getArrows|
              514 |getArrowIndex| 519 |flatten| 526 |distanceWeighted| 531
              |distanceMatrix| 538 |distance| 543 |diagramsSvg| 550
              |diagramWidth| 557 |diagramSvg| 562 |diagramHeight| 569
              |deepDiagramSvg| 574 |cycleOpen| 581 |cycleClosed| 587 |createY|
              593 |createX| 599 |createWidth| 605 |coerce| 610 |closedTensor|
              620 |closedCartesian| 627 |cartesian| 634 |arrowsToNode| 640
              |arrowsToArrow| 646 |arrowsFromNode| 652 |arrowsFromArrow| 658
              |arrowName| 664 |adjacencyMatrix| 671 |addWArrow!| 676
              |addObject!| 685 |addArrow!| 697 = 728 + 734 * 740)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|FiniteGraph&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FiniteGraph| 6) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 117))
                        (|makeByteWordVec2| 117
                                            '(0 7 0 9 2 16 0 0 15 18 2 13 0 0
                                              12 19 2 0 25 25 25 26 2 0 25 25
                                              25 27 2 21 0 0 20 28 2 23 0 0 22
                                              29 1 33 10 0 34 1 33 35 0 36 2 31
                                              0 0 30 37 2 10 6 0 39 40 2 42 41
                                              0 39 43 1 41 25 0 44 2 41 25 0 39
                                              45 2 13 47 0 0 48 2 25 47 0 0 62
                                              2 13 0 0 0 64 2 16 0 0 0 65 2 13
                                              39 12 0 67 2 41 0 0 25 68 1 0 25
                                              0 70 1 0 25 0 71 2 72 0 6 6 73 2
                                              75 0 0 74 76 3 0 47 0 25 25 77 3
                                              0 51 0 25 25 78 1 51 0 79 80 2 81
                                              0 75 16 82 2 13 12 0 39 88 3 13
                                              12 0 39 12 89 2 41 47 0 0 92 2 41
                                              47 0 0 93 2 7 47 0 0 95 3 0 25 0
                                              25 25 97 2 7 0 0 0 102 2 16 15 0
                                              39 103 2 0 47 0 0 1 2 0 0 10 42
                                              46 2 0 0 10 31 32 1 0 0 33 38 2 0
                                              0 21 23 24 1 0 0 13 14 2 0 0 13
                                              16 17 1 0 0 10 11 1 0 104 0 105 2
                                              0 0 10 51 61 1 0 0 6 58 4 0 107
                                              108 0 47 47 1 2 0 112 0 25 1 2 0
                                              112 0 25 1 1 0 113 0 1 1 0 113 0
                                              1 3 0 41 0 25 25 96 2 0 7 0 41 94
                                              3 0 41 0 25 25 99 2 0 7 0 41 98 2
                                              0 25 0 25 1 2 0 41 0 25 1 2 0 41
                                              0 25 1 2 0 41 0 25 1 2 0 41 0 25
                                              1 1 0 25 0 1 2 0 25 0 41 1 2 0 0
                                              0 0 69 2 0 25 0 41 1 1 0 25 0 1 5
                                              0 0 0 41 10 39 39 91 5 0 0 0 41
                                              10 39 39 90 2 0 47 0 0 1 1 0 111
                                              0 1 2 0 111 0 25 1 1 0 111 0 1 1
                                              0 51 0 1 1 0 109 0 1 2 0 0 10 51
                                              63 3 0 47 0 25 25 1 1 0 47 0 1 2
                                              0 47 0 25 1 0 0 47 1 3 0 47 0 25
                                              25 77 1 0 47 0 1 0 0 0 57 1 0 109
                                              0 1 2 0 25 0 25 1 2 0 116 116 0 1
                                              1 0 115 0 1 1 0 21 0 55 2 0 25 0
                                              6 1 1 0 23 0 56 3 0 25 0 25 25 97
                                              1 0 0 114 1 3 0 100 0 25 25 101 1
                                              0 109 0 1 3 0 39 0 25 25 1 3 0
                                              107 51 79 47 1 1 0 25 0 70 3 0
                                              107 51 0 47 1 1 0 25 0 71 3 0 107
                                              51 0 47 1 2 0 0 10 51 59 2 0 0 10
                                              51 60 2 0 25 25 25 27 2 0 25 25
                                              25 26 1 0 25 25 1 1 0 0 33 106 1
                                              0 117 0 1 3 0 0 0 0 85 86 3 0 0 0
                                              0 85 87 2 0 81 0 0 84 2 0 41 0 25
                                              1 2 0 41 0 25 1 2 0 41 0 25 1 2 0
                                              41 0 25 1 3 0 51 0 25 25 78 1 0
                                              110 0 1 5 0 0 0 51 25 25 7 52 2 0
                                              0 0 6 49 2 0 0 0 20 50 4 0 0 0 51
                                              6 6 1 4 0 0 0 51 25 25 54 5 0 0 0
                                              51 25 25 41 1 2 0 0 0 22 53 2 0
                                              47 0 0 1 2 0 0 0 0 66 2 0 81 0 0
                                              83)))))
           '|lookupComplete|)) 
