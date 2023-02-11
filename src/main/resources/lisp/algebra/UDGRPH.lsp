
(PUT '|UDGRPH;isDirected?;B;1| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |UDGRPH;isDirected?;B;1| (($ (|Boolean|))) NIL) 

(SDEFUN |UDGRPH;undirectedGraph;L$;2| ((|ob| (|List| S)) ($ ($)))
        (SPROG
         ((|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#1=#:G726 NIL) (|x| NIL) (#2=#:G725 NIL))
         (SEQ
          (LETT |objs|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |ob|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (VECTOR |x| 0 0) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (CONS |objs| NIL))))) 

(PUT '|UDGRPH;undirectedGraph;L$;3| '|SPADreplace|
     '(XLAM (|ob|) (CONS |ob| NIL))) 

(SDEFUN |UDGRPH;undirectedGraph;L$;3|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)))))
         ($ ($)))
        (CONS |ob| NIL)) 

(PUT '|UDGRPH;undirectedGraph;LL$;4| '|SPADreplace| 'CONS) 

(SDEFUN |UDGRPH;undirectedGraph;LL$;4|
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
        (CONS |ob| |ar|)) 

(SDEFUN |UDGRPH;undirectedGraph;LL$;5|
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
          (#1=#:G762 NIL) (|ar| NIL) (#2=#:G763 NIL) (|arn| NIL)
          (|nodes|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (#3=#:G760 NIL) (|ob| NIL) (#4=#:G761 NIL) (|obn| NIL))
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
                                            (QREFELT $ 19))
                                  (SPADCALL (LENGTH |obs|) |obn|
                                            (QREFELT $ 20))))
                    (EXIT
                     (LETT |nodes| (SPADCALL |nodes| |o| (QREFELT $ 21)))))
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
                                     (QREFELT $ 22)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |arn| (|inc_SI| |arn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |nodes| |edges|))))) 

(SDEFUN |UDGRPH;undirectedGraph;Fp$;6| ((|poset| (|FinitePoset| S)) ($ ($)))
        (SPROG
         ((|ars|
           (|List|
            #1=(|Record| (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|)))))
          (|z| #1#) (#2=#:G774 NIL) (|y| NIL) (#3=#:G775 NIL) (|yn| NIL)
          (#4=#:G772 NIL) (|x| NIL) (#5=#:G773 NIL) (|xn| NIL)
          (|mat| (|List| (|List| (|Boolean|)))) (|obs| (|List| S)))
         (SEQ (LETT |obs| (SPADCALL |poset| (QREFELT $ 27))) (LETT |ars| NIL)
              (LETT |mat| (SPADCALL |poset| (QREFELT $ 29)))
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
                                                    (QREFELT $ 30)))))))))
                          (LETT #2#
                                (PROG1 (CDR #2#) (LETT |yn| (|inc_SI| |yn|))))
                          (GO G190) G191 (EXIT NIL))))
                   (LETT #4# (PROG1 (CDR #4#) (LETT |xn| (|inc_SI| |xn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |obs| |ars| (QREFELT $ 25)))))) 

(SDEFUN |UDGRPH;undirectedGraph;LL$;7|
        ((|objs| (|List| S)) (|am| (|List| (|List| (|NonNegativeInteger|))))
         ($ ($)))
        (SPROG
         ((|ar|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (#2=#:G794 NIL) (|j| NIL) (#3=#:G793 NIL) (|i| NIL)
          (|obs|
           (|List|
            #4=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #4#) (|ob| (S)) (#5=#:G792 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #5# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #5#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 33)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 19))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 20))))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (LETT |ar| NIL)
              (SEQ (LETT |i| 1) (LETT #3# (LENGTH |am|)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1)
                          (LETT #2#
                                (SPADCALL (SPADCALL |am| |i| (QREFELT $ 36))
                                          (QREFELT $ 37)))
                          G190 (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((EQL
                               (SPADCALL (SPADCALL |am| |i| (QREFELT $ 36)) |j|
                                         (QREFELT $ 38))
                               1)
                              (SEQ (LETT |a| (VECTOR "a" 0 |i| |j| 0 0 NIL))
                                   (EXIT
                                    (LETT |ar|
                                          (SPADCALL |ar| |a|
                                                    (QREFELT $ 22)))))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ar|))))) 

(SDEFUN |UDGRPH;addObject!;$S$;8| ((|s| ($)) (|n| (S)) ($ ($)))
        (SPROG
         ((|obj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |obs| (QCAR |s|)) (LETT |obj| (VECTOR |n| 0 0))
              (COND
               ((SPADCALL |obs| NIL (QREFELT $ 40))
                (PROGN (RPLACA |s| (LIST |obj|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |obj| (QREFELT $ 21)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |UDGRPH;addObject!;$R$;9|
        ((|s| ($))
         (|n|
          (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                    (|:| |posY| #1#)))
         ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |obs| (QCAR |s|))
              (COND
               ((SPADCALL |obs| NIL (QREFELT $ 40))
                (PROGN (RPLACA |s| (LIST |n|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |n| (QREFELT $ 21)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |UDGRPH;addArrow!;$R$;10|
        ((|s| ($))
         (|ar|
          (|Record| (|:| |name| (|String|))
                    (|:| |arrType| #1=(|NonNegativeInteger|))
                    (|:| |fromOb| #1#) (|:| |toOb| #1#)
                    (|:| |xOffset| #2=(|Integer|)) (|:| |yOffset| #2#)
                    (|:| |map| (|List| #1#))))
         ($ ($)))
        (SEQ
         (PROGN
          (RPLACD |s| (SPADCALL (QCDR |s|) |ar| (QREFELT $ 22)))
          (QCDR |s|))
         (EXIT |s|))) 

(SDEFUN |UDGRPH;addArrow!;$S2Nni$;11|
        ((|s| ($)) (|nm| (|String|)) (|n1| #1=(|NonNegativeInteger|))
         (|n2| #1#) ($ ($)))
        (SPROG
         ((|a|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         (SEQ (LETT |a| (VECTOR |nm| 0 |n1| |n2| 0 0 NIL))
              (EXIT (SPADCALL |s| |a| (QREFELT $ 43)))))) 

(SDEFUN |UDGRPH;addArrow!;$S2NniL$;12|
        ((|s| ($)) (|nm| (|String|)) (|n1| #1=(|NonNegativeInteger|))
         (|n2| #1#) (|mp| (|List| #1#)) ($ ($)))
        (SPROG
         ((|a|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         (SEQ (LETT |a| (VECTOR |nm| 0 |n1| |n2| 0 0 |mp|))
              (EXIT (SPADCALL |s| |a| (QREFELT $ 43)))))) 

(PUT '|UDGRPH;getVertices;$L;13| '|SPADreplace| 'QCAR) 

(SDEFUN |UDGRPH;getVertices;$L;13|
        ((|s| ($))
         ($
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))))
        (QCAR |s|)) 

(SDEFUN |UDGRPH;getArrows;$L;14|
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
         ((|as|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|revAr| #1#) (#2=#:G826 NIL) (|a| NIL) (|forwAr| #1#)
          (#3=#:G825 NIL))
         (SEQ (LETT |as| NIL)
              (SEQ (LETT |a| NIL) (LETT #3# (QCDR |s|)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |forwAr|
                          (VECTOR (QVELT |a| 0) (QVELT |a| 1) (QVELT |a| 2)
                                  (QVELT |a| 3) (QVELT |a| 4) (QVELT |a| 5)
                                  (QVELT |a| 6)))
                    (EXIT (LETT |as| (SPADCALL |as| |forwAr| (QREFELT $ 22)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |a| NIL) (LETT #2# (QCDR |s|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |a| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |revAr|
                          (VECTOR (QVELT |a| 0) (QVELT |a| 1) (QVELT |a| 3)
                                  (QVELT |a| 2) (QVELT |a| 4) (QVELT |a| 5)
                                  (QVELT |a| 6)))
                    (EXIT (LETT |as| (SPADCALL |as| |revAr| (QREFELT $ 22)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |as|)))) 

(PUT '|UDGRPH;initial;$;15| '|SPADreplace| '(XLAM NIL (CONS NIL NIL))) 

(SDEFUN |UDGRPH;initial;$;15| (($ ($))) (CONS NIL NIL)) 

(SDEFUN |UDGRPH;terminal;S$;16| ((|a| (S)) ($ ($)))
        (SPROG
         ((|ar|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)))))
         (SEQ (LETT |o| (VECTOR |a| 0 0))
              (LETT |ar| (VECTOR "loop" 0 1 1 0 0 NIL))
              (EXIT (CONS (LIST |o|) (LIST |ar|)))))) 

(SDEFUN |UDGRPH;cycleOpen;LS$;17|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (|next| (|NonNegativeInteger|))
          (|obs|
           (|List|
            #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #2#) (|ob| (S)) (#3=#:G843 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #3#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 33)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 19))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 20))))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))
                        (LETT |next| (+ |obn| 1))
                        (EXIT
                         (COND
                          ((<= |next| (LENGTH |objs|))
                           (SEQ
                            (LETT |a|
                                  (VECTOR
                                   (STRCONC |arrowName| (STRINGIMAGE |arn|)) 0
                                   |obn| |next| 0 0 NIL))
                            (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 22)))
                            (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |UDGRPH;cycleClosed;LS$;18|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (|next| (|NonNegativeInteger|))
          (|obs|
           (|List|
            #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #2#) (|ob| (S)) (#3=#:G854 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #3#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 33)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 19))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 20))))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))
                        (LETT |next| (+ |obn| 1))
                        (COND
                         ((EQL (- |next| 1) (LENGTH |objs|)) (LETT |next| 1)))
                        (EXIT
                         (COND
                          ((<= |next| (LENGTH |objs|))
                           (SEQ
                            (LETT |a|
                                  (VECTOR
                                   (STRCONC |arrowName| (STRINGIMAGE |arn|)) 0
                                   |obn| |next| 0 0 NIL))
                            (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 22)))
                            (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |UDGRPH;unit;LS$;19|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#)
          (|obs|
           (|List|
            #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #2#) (|ob| (S)) (#3=#:G863 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #3#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 33)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 19))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 20))))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))
                        (LETT |a|
                              (VECTOR (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                      0 |obn| |obn| 0 0 NIL))
                        (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 22)))
                        (EXIT (LETT |arn| (+ |arn| 1))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |UDGRPH;kgraph;LS$;20|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|arn| (|Integer|))
          (|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (#2=#:G877 NIL) (|obm| NIL)
          (|obs|
           (|List|
            #3=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #3#) (|ob| (S)) (#4=#:G876 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #4# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #4#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 33)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 19))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 20))))
                        (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))
                        (EXIT
                         (SEQ (LETT |obm| 1) (LETT #2# (LENGTH |objs|)) G190
                              (COND ((|greater_SI| |obm| #2#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |obn| |obm| (QREFELT $ 54))
                                  (SEQ
                                   (LETT |a|
                                         (VECTOR
                                          (STRCONC |arrowName|
                                                   (STRINGIMAGE |arn|))
                                          0 |obn| |obm| 0 0 NIL))
                                   (LETT |ars|
                                         (SPADCALL |ars| |a| (QREFELT $ 22)))
                                   (EXIT (LETT |arn| (+ |arn| 1))))))))
                              (LETT |obm| (|inc_SI| |obm|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |UDGRPH;+;3$;21| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|la|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|lb|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (#2=#:G886 NIL) (|ba| NIL)
          (|bStart| (|NonNegativeInteger|))
          (|lo|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |lo| (SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 56)))
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
                    (EXIT (LETT |lb| (SPADCALL |lb| |arr| (QREFELT $ 22)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |la| (SPADCALL (QCDR |a|) |lb| (QREFELT $ 57)))
              (EXIT (CONS |lo| |la|))))) 

(SDEFUN |UDGRPH;merge;3$;22| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|la|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|lb|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|fromI| #2=(|NonNegativeInteger|)) (|toI| #2#)
          (#3=#:G910 NIL) (|ba| NIL) (|bStart| #4=(|NonNegativeInteger|))
          (|bmap| (|List| (|NonNegativeInteger|))) (#5=#:G897 NIL)
          (|newIndex| #4#)
          (|mergedObjects|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|i| (|Integer|)) (#6=#:G909 NIL) (|bob| NIL) (#7=#:G908 NIL)
          (|x| NIL) (#8=#:G907 NIL))
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
               (SEQ (LETT |i| (SPADCALL |bob| (QCAR |a|) (QREFELT $ 59)))
                    (EXIT
                     (COND
                      ((< |i| 1)
                       (SEQ
                        (LETT |mergedObjects|
                              (SPADCALL |mergedObjects| |bob| (QREFELT $ 21)))
                        (LETT |newIndex| (+ |newIndex| 1))
                        (EXIT
                         (LETT |bmap|
                               (SPADCALL |bmap| |newIndex| (QREFELT $ 60))))))
                      ('T
                       (LETT |bmap|
                             (SPADCALL |bmap|
                                       (PROG1 (LETT #5# |i|)
                                         (|check_subtype2| (>= #5# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #5#))
                                       (QREFELT $ 60)))))))
               (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
          (LETT |bStart| (LENGTH (QCAR |a|))) (LETT |lb| NIL)
          (SEQ (LETT |ba| NIL) (LETT #3# (QCDR |b|)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |ba| (CAR #3#)) NIL)) (GO G191)))
               (SEQ
                (LETT |toI|
                      (SPADCALL |bmap| (+ (QVELT |ba| 3) |bStart|)
                                (QREFELT $ 38)))
                (LETT |fromI|
                      (SPADCALL |bmap| (+ (QVELT |ba| 2) |bStart|)
                                (QREFELT $ 38)))
                (LETT |arr|
                      (VECTOR (QVELT |ba| 0) (QVELT |ba| 1) |fromI| |toI|
                              (QVELT |ba| 4) (QVELT |ba| 5) (QVELT |ba| 6)))
                (EXIT (LETT |lb| (SPADCALL |lb| |arr| (QREFELT $ 22)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (LETT |la| (SPADCALL (QCDR |a|) |lb| (QREFELT $ 57)))
          (EXIT (CONS |mergedObjects| |la|))))) 

(SDEFUN |UDGRPH;objProd|
        ((|a| ($)) (|b| ($))
         ($
          (|List|
           (|Record| (|:| |value| (|Product| S S))
                     (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))))
        (SPROG
         ((|newObjs|
           (|List|
            (|Record| (|:| |value| (|Product| S S))
                      (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|ob|
           (|Record| (|:| |value| (|Product| S S))
                     (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (|sp| (|Product| S S)) (|y| #1=(|NonNegativeInteger|)) (|x| #1#)
          (|byi| #2=(|NonNegativeInteger|)) (|bxi| #3=(|NonNegativeInteger|))
          (|bi| (S)) (#4=#:G924 NIL) (|boi| NIL) (|ayi| #2#) (|axi| #3#)
          (|ai| (S)) (#5=#:G923 NIL) (|aoi| NIL))
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
                                             (SPADCALL |a| (QREFELT $ 62)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 63)))
                                          |ayi|))
                                   (LETT |sp|
                                         (SPADCALL |ai| |bi| (QREFELT $ 65)))
                                   (LETT |ob| (VECTOR |sp| |x| |y|))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 68)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |newObjs|)))) 

(SDEFUN |UDGRPH;indexProd|
        ((|aObj| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G925 NIL))
               (+ |a|
                  (*
                   (PROG1 (LETT #1# (- |b| 1))
                     (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #1#))
                   (LENGTH (QCAR |aObj|)))))) 

(SDEFUN |UDGRPH;*;2$Ug;25|
        ((|a| ($)) (|b| ($)) ($ (|UndirectedGraph| (|Product| S S))))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G951 NIL) (|bv| NIL)
          (#3=#:G950 NIL) (|bu| NIL) (#4=#:G949 NIL) (|av| NIL) (#5=#:G948 NIL)
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
                                                      (QREFELT $ 69))
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 69))
                                              (SEQ
                                               (LETT |an|
                                                     (SPADCALL
                                                      (LIST
                                                       (SPADCALL |a| |au| |av|
                                                                 (QREFELT $
                                                                          70))
                                                       "*"
                                                       (SPADCALL |b| |bu| |bv|
                                                                 (QREFELT $
                                                                          70)))
                                                      (QREFELT $ 72)))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|UDGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|UDGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         22)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|UDGRPH;objProd| |a| |b| $) |newArrs|
                         (QREFELT $ 74)))))) 

(SDEFUN |UDGRPH;cartesian;2$Ug;26|
        ((|a| ($)) (|b| ($)) ($ (|UndirectedGraph| (|Product| S S))))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G980 NIL) (|bv| NIL)
          (#3=#:G979 NIL) (|bu| NIL) (#4=#:G978 NIL) (|av| NIL) (#5=#:G977 NIL)
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
                                           ((EQL |bu| |bv|)
                                            (COND
                                             ((SPADCALL |a| |au| |av|
                                                        (QREFELT $ 69))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            69))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              70))
                                                           #6="#"
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 72)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              70))
                                                           #7="#"
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 72)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            70))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 72)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|UDGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|UDGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         22))))))
                                             ((EQL |au| |av|)
                                              (COND
                                               ((SPADCALL |b| |bu| |bv|
                                                          (QREFELT $ 69))
                                                (SEQ
                                                 (LETT |an|
                                                       (COND
                                                        ((EQL |bu| |bv|)
                                                         (COND
                                                          ((SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              69))
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |a| |au|
                                                                       |av|
                                                                       (QREFELT
                                                                        $ 70))
                                                             #6#
                                                             (STRINGIMAGE
                                                              |bv|))
                                                            (QREFELT $ 72)))
                                                          ('T
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |b| |bu|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 70))
                                                             #7#
                                                             (STRINGIMAGE
                                                              |av|))
                                                            (QREFELT $ 72)))))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              70))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 72)))))
                                                 (LETT |arr|
                                                       (VECTOR |an| 0
                                                               (|UDGRPH;indexProd|
                                                                |b| |bu| |au|
                                                                $)
                                                               (|UDGRPH;indexProd|
                                                                |b| |bv| |av|
                                                                $)
                                                               0 0 NIL))
                                                 (EXIT
                                                  (LETT |newArrs|
                                                        (SPADCALL |newArrs|
                                                                  |arr|
                                                                  (QREFELT $
                                                                           22))))))))))
                                           ((EQL |au| |av|)
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 69))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            69))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              70))
                                                           #6#
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 72)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              70))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 72)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            70))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 72)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|UDGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|UDGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         22)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|UDGRPH;objProd| |a| |b| $) |newArrs|
                         (QREFELT $ 74)))))) 

(SDEFUN |UDGRPH;closedObjProd|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S))
         ($
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))))
        (SPROG
         ((|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|ob|
           (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                     (|:| |posY| #2=(|NonNegativeInteger|))))
          (|sp| (S)) (|y| #3=(|NonNegativeInteger|)) (|x| #3#) (|byi| #2#)
          (|bxi| #1#) (|bi| (S)) (#4=#:G991 NIL) (|boi| NIL) (|ayi| #2#)
          (|axi| #1#) (|ai| (S)) (#5=#:G990 NIL) (|aoi| NIL))
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
                                             (SPADCALL |a| (QREFELT $ 62)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 63)))
                                          |ayi|))
                                   (LETT |sp| (SPADCALL |ai| |bi| |f|))
                                   (LETT |ob| (VECTOR |sp| |x| |y|))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 21)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |newObjs|)))) 

(SDEFUN |UDGRPH;closedTensor;2$M$;28|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G1016 NIL) (|bv| NIL)
          (#3=#:G1015 NIL) (|bu| NIL) (#4=#:G1014 NIL) (|av| NIL)
          (#5=#:G1013 NIL) (|au| NIL))
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
                                                      (QREFELT $ 69))
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 69))
                                              (SEQ
                                               (LETT |an|
                                                     (SPADCALL
                                                      (LIST
                                                       (SPADCALL |a| |au| |av|
                                                                 (QREFELT $
                                                                          70))
                                                       "*"
                                                       (SPADCALL |b| |bu| |bv|
                                                                 (QREFELT $
                                                                          70)))
                                                      (QREFELT $ 72)))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|UDGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|UDGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         22)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|UDGRPH;closedObjProd| |a| |b| |f| $) |newArrs|
                         (QREFELT $ 17)))))) 

(SDEFUN |UDGRPH;closedCartesian;2$M$;29|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr| #1#) (|an| (|String|)) (#2=#:G1046 NIL) (|bv| NIL)
          (#3=#:G1045 NIL) (|bu| NIL) (#4=#:G1044 NIL) (|av| NIL)
          (#5=#:G1043 NIL) (|au| NIL))
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
                                                        (QREFELT $ 69))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            69))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              70))
                                                           #6="#"
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 72)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              70))
                                                           #7="#"
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 72)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            70))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 72)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|UDGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|UDGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         22))))))
                                             ((EQL |au| |av|)
                                              (COND
                                               ((SPADCALL |b| |bu| |bv|
                                                          (QREFELT $ 69))
                                                (SEQ
                                                 (LETT |an|
                                                       (COND
                                                        ((EQL |bu| |bv|)
                                                         (COND
                                                          ((SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              69))
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |a| |au|
                                                                       |av|
                                                                       (QREFELT
                                                                        $ 70))
                                                             #6#
                                                             (STRINGIMAGE
                                                              |bv|))
                                                            (QREFELT $ 72)))
                                                          ('T
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |b| |bu|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 70))
                                                             #7#
                                                             (STRINGIMAGE
                                                              |av|))
                                                            (QREFELT $ 72)))))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              70))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 72)))))
                                                 (LETT |arr|
                                                       (VECTOR |an| 0
                                                               (|UDGRPH;indexProd|
                                                                |b| |bu| |au|
                                                                $)
                                                               (|UDGRPH;indexProd|
                                                                |b| |bv| |av|
                                                                $)
                                                               0 0 NIL))
                                                 (EXIT
                                                  (LETT |newArrs|
                                                        (SPADCALL |newArrs|
                                                                  |arr|
                                                                  (QREFELT $
                                                                           22))))))))))
                                           ((EQL |au| |av|)
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 69))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            69))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              70))
                                                           #6#
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 72)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              70))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 72)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            70))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 72)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|UDGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|UDGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         22)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|UDGRPH;closedObjProd| |a| |b| |f| $) |newArrs|
                         (QREFELT $ 17)))))) 

(SDEFUN |UDGRPH;map;$LL2I$;30|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #2=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newArr| #2#) (#3=#:G1066 NIL) (|oldArrow| NIL) (#4=#:G1053 NIL)
          (#5=#:G1052 NIL) (|i| (|NonNegativeInteger|)) (#6=#:G1065 NIL)
          (|oi| NIL)
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#7=#:G1064 NIL) (|o| NIL) (#8=#:G1063 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |o| NIL) (LETT #7# |newOb|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |o| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #8# (CONS (VECTOR |o| 0 0) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (SEQ (LETT |oi| 1) (LETT #6# (LENGTH (QCAR |s|))) G190
               (COND ((|greater_SI| |oi| #6#) (GO G191)))
               (SEQ (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 38)))
                    (EXIT
                     (SPADCALL |newObjs| |i|
                               (VECTOR
                                (QVELT (SPADCALL |newObjs| |i| (QREFELT $ 80))
                                       0)
                                (PROG1
                                    (LETT #5#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 80))
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
                                                      (QREFELT $ 80))
                                            2)
                                           |offsetY|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#)))
                               (QREFELT $ 81))))
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
                                        (QREFELT $ 38))
                              (SPADCALL |m| (QVELT |oldArrow| 3)
                                        (QREFELT $ 38))
                              (QVELT |oldArrow| 4) (QVELT |oldArrow| 5)
                              (QVELT |oldArrow| 6)))
                (EXIT
                 (LETT |newArrs|
                       (SPADCALL |newArrs| |newArr| (QREFELT $ 22)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |newObjs| |newArrs|))))) 

(SDEFUN |UDGRPH;mapContra;$LL2I$;31|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            #2=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newArr| #2#) (#3=#:G1086 NIL) (|oldArrow| NIL) (#4=#:G1073 NIL)
          (#5=#:G1072 NIL) (|i| (|NonNegativeInteger|)) (#6=#:G1085 NIL)
          (|oi| NIL)
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#7=#:G1084 NIL) (|o| NIL) (#8=#:G1083 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |o| NIL) (LETT #7# |newOb|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |o| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #8# (CONS (VECTOR |o| 0 0) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (SEQ (LETT |oi| 1) (LETT #6# (LENGTH (QCAR |s|))) G190
               (COND ((|greater_SI| |oi| #6#) (GO G191)))
               (SEQ (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 38)))
                    (EXIT
                     (SPADCALL |newObjs| |i|
                               (VECTOR
                                (QVELT (SPADCALL |newObjs| |i| (QREFELT $ 80))
                                       0)
                                (PROG1
                                    (LETT #5#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 80))
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
                                                      (QREFELT $ 80))
                                            2)
                                           |offsetY|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#)))
                               (QREFELT $ 81))))
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
                                        (QREFELT $ 38))
                              (SPADCALL |m| (QVELT |oldArrow| 2)
                                        (QREFELT $ 38))
                              (QVELT |oldArrow| 4) (QVELT |oldArrow| 5)
                              (QVELT |oldArrow| 6)))
                (EXIT
                 (LETT |newArrs|
                       (SPADCALL |newArrs| |newArr| (QREFELT $ 22)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |newObjs| |newArrs|))))) 

(SDEFUN |UDGRPH;coerce;Fp$;32| ((|poset| (|FinitePoset| S)) ($ ($)))
        (SPADCALL |poset| (QREFELT $ 31))) 

(SDEFUN |UDGRPH;coerce;$Of;33| ((|n| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|arrows| #1=(|OutputForm|)) (|laof| (|List| (|OutputForm|)))
          (#2=#:G1100 NIL) (|ar| NIL) (#3=#:G1099 NIL) (#4=#:G1096 NIL)
          (|la|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|vertices| #1#) (|lvof| (|List| (|OutputForm|))) (#5=#:G1098 NIL)
          (|v| NIL) (#6=#:G1097 NIL)
          (|lv|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |vertices| (SPADCALL "Vertices: " (QREFELT $ 86)))
                (LETT |lv| (SPADCALL |n| (QREFELT $ 47)))
                (LETT |lvof|
                      (PROGN
                       (LETT #6# NIL)
                       (SEQ (LETT |v| NIL) (LETT #5# |lv|) G190
                            (COND
                             ((OR (ATOM #5#) (PROGN (LETT |v| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #6#
                                    (CONS
                                     (SPADCALL (QVELT |v| 0) (QREFELT $ 87))
                                     #6#))))
                            (LETT #5# (CDR #5#)) (GO G190) G191
                            (EXIT (NREVERSE #6#)))))
                (LETT |vertices|
                      (SPADCALL |vertices| (SPADCALL |lvof| (QREFELT $ 88))
                                (QREFELT $ 89)))
                (LETT |arrows| (SPADCALL "Edges: " (QREFELT $ 86)))
                (LETT |la| (SPADCALL |n| (QREFELT $ 48)))
                (COND
                 ((NULL |la|) (PROGN (LETT #4# |vertices|) (GO #7=#:G1095))))
                (LETT |laof|
                      (PROGN
                       (LETT #3# NIL)
                       (SEQ (LETT |ar| NIL) (LETT #2# |la|) G190
                            (COND
                             ((OR (ATOM #2#) (PROGN (LETT |ar| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #3#
                                    (CONS
                                     (SPADCALL
                                      (LIST
                                       (SPADCALL (QVELT |ar| 2) (QREFELT $ 90))
                                       (SPADCALL "-" (QREFELT $ 86))
                                       (SPADCALL (QVELT |ar| 3)
                                                 (QREFELT $ 90)))
                                      (QREFELT $ 91))
                                     #3#))))
                            (LETT #2# (CDR #2#)) (GO G190) G191
                            (EXIT (NREVERSE #3#)))))
                (LETT |arrows|
                      (SPADCALL |arrows| (SPADCALL |laof| (QREFELT $ 88))
                                (QREFELT $ 89)))
                (EXIT (SPADCALL (LIST |vertices| |arrows|) (QREFELT $ 92)))))
          #7# (EXIT #4#)))) 

(SDEFUN |UDGRPH;subdiagramSvg;S$2BV;34|
        ((|sc| (|Scene| (|SCartesian| 2))) (|n| ($))
         (|dispArrowName| #1=(|Boolean|)) (|deep| #1#) ($ (|Void|)))
        (SPROG
         ((#2=#:G1122 NIL) (|s| (|String|))
          (|tnode| #3=(|Scene| (|SCartesian| 2))) (|fnode| #3#)
          (|midY| #4=(|NonNegativeInteger|)) (|midX| #4#)
          (|toY| #5=(|NonNegativeInteger|)) (#6=#:G1116 NIL) (|fromY| #5#)
          (#7=#:G1115 NIL) (|toX| #5#) (#8=#:G1114 NIL) (|fromX| #5#)
          (#9=#:G1113 NIL) (#10=#:G1124 NIL) (|arrow| NIL) (#11=#:G1125 NIL)
          (|arrn| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|indexBounds| (|List| (|Scene| (|SCartesian| 2))))
          (|tn| (|Scene| (|SCartesian| 2)))
          (|indexPointy| (|List| (|NonNegativeInteger|)))
          (|indexPointx| (|List| (|NonNegativeInteger|)))
          (|y| (|NonNegativeInteger|)) (|x| (|NonNegativeInteger|))
          (|indexNodes| (|List| S)) (#12=#:G1123 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|mt| (|Scene| (|SCartesian| 2))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |mt|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "black"
                            "black" (QREFELT $ 96)))
            (LETT |ls| (SPADCALL |n| (QREFELT $ 47))) (LETT |indexPointx| NIL)
            (LETT |indexPointy| NIL) (LETT |indexBounds| NIL)
            (LETT |indexNodes| NIL)
            (SEQ (LETT |i| NIL) (LETT #12# |ls|) G190
                 (COND
                  ((OR (ATOM #12#) (PROGN (LETT |i| (CAR #12#)) NIL))
                   (GO G191)))
                 (SEQ
                  (LETT |indexNodes|
                        (SPADCALL |indexNodes| (QVELT |i| 0) (QREFELT $ 97)))
                  (LETT |s| (|mathObject2String| (QVELT |i| 0)))
                  (LETT |x| (QVELT |i| 1)) (LETT |y| (QVELT |i| 2))
                  (LETT |indexPointx|
                        (SPADCALL |indexPointx| |x| (QREFELT $ 60)))
                  (LETT |indexPointy|
                        (SPADCALL |indexPointy| |y| (QREFELT $ 60)))
                  (LETT |tn|
                        (SPADCALL |sc| |s| 32 (SPADCALL |x| |y| (QREFELT $ 99))
                                  (QREFELT $ 100)))
                  (EXIT
                   (LETT |indexBounds|
                         (SPADCALL |indexBounds| |tn| (QREFELT $ 102)))))
                 (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
            (LETT |arrs| (SPADCALL |n| (QREFELT $ 48)))
            (COND
             ((NULL |arrs|)
              (PROGN (LETT #2# (SPADCALL (QREFELT $ 104))) (GO #13=#:G1121))))
            (SEQ (LETT |arrn| 1) (LETT #11# (LENGTH |arrs|)) (LETT |arrow| NIL)
                 (LETT #10# |arrs|) G190
                 (COND
                  ((OR (ATOM #10#) (PROGN (LETT |arrow| (CAR #10#)) NIL)
                       (|greater_SI| |arrn| #11#))
                   (GO G191)))
                 (SEQ
                  (LETT |fromX|
                        (SPADCALL |indexPointx| (QVELT |arrow| 2)
                                  (QREFELT $ 38)))
                  (LETT |toX|
                        (SPADCALL |indexPointx| (QVELT |arrow| 3)
                                  (QREFELT $ 38)))
                  (LETT |fromY|
                        (SPADCALL |indexPointy| (QVELT |arrow| 2)
                                  (QREFELT $ 38)))
                  (LETT |toY|
                        (SPADCALL |indexPointy| (QVELT |arrow| 3)
                                  (QREFELT $ 38)))
                  (LETT |fromX|
                        (PROG1 (LETT #9# (+ |fromX| (QVELT |arrow| 4)))
                          (|check_subtype2| (>= #9# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #9#)))
                  (LETT |toX|
                        (PROG1 (LETT #8# (+ |toX| (QVELT |arrow| 4)))
                          (|check_subtype2| (>= #8# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #8#)))
                  (LETT |fromY|
                        (PROG1 (LETT #7# (+ |fromY| (QVELT |arrow| 5)))
                          (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #7#)))
                  (LETT |toY|
                        (PROG1 (LETT #6# (+ |toY| (QVELT |arrow| 5)))
                          (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #6#)))
                  (LETT |midX| (ASH (+ |toX| |fromX|) -1))
                  (LETT |midY| (ASH (+ |toY| |fromY|) -1))
                  (LETT |fnode|
                        (SPADCALL |indexBounds| (QVELT |arrow| 2)
                                  (QREFELT $ 105)))
                  (LETT |tnode|
                        (SPADCALL |indexBounds| (QVELT |arrow| 3)
                                  (QREFELT $ 105)))
                  (SPADCALL |mt| |fnode| |tnode|
                            (FLOAT (+ (SPADCALL |n| (QREFELT $ 62)) 10)
                                   MOST-POSITIVE-DOUBLE-FLOAT)
                            |deep| (QREFELT $ 106))
                  (EXIT
                   (COND
                    (|dispArrowName|
                     (SEQ (LETT |s| (QVELT |arrow| 0))
                          (EXIT
                           (SPADCALL |mt| |s| 32
                                     (SPADCALL |midX| |midY| (QREFELT $ 99))
                                     (QREFELT $ 100))))))))
                 (LETT #10# (PROG1 (CDR #10#) (LETT |arrn| (|inc_SI| |arrn|))))
                 (GO G190) G191 (EXIT NIL))
            (EXIT (PROGN (LETT #2# (SPADCALL (QREFELT $ 104))) (GO #13#)))))
          #13# (EXIT #2#)))) 

(SDEFUN |UDGRPH;diagramSvg;S$BV;35|
        ((|fileName| (|String|)) (|n| ($)) (|dispArrowName| (|Boolean|))
         ($ (|Void|)))
        (SPROG
         ((|sc| (|Scene| (|SCartesian| 2)))
          (|view| (|SBoundary| (|SCartesian| 2))))
         (SEQ
          (LETT |view|
                (SPADCALL (SPADCALL 0 0 (QREFELT $ 99))
                          (SPADCALL (+ (SPADCALL |n| (QREFELT $ 62)) 10)
                                    (+ (SPADCALL |n| (QREFELT $ 63)) 10)
                                    (QREFELT $ 99))
                          (QREFELT $ 109)))
          (LETT |sc| (SPADCALL |view| (QREFELT $ 110)))
          (SPADCALL |sc| |n| |dispArrowName| 'T (QREFELT $ 107))
          (EXIT (SPADCALL |sc| |fileName| (QREFELT $ 111)))))) 

(SDEFUN |UDGRPH;diagramSvg2;S$BV;36|
        ((|fileName| (|String|)) (|n| ($)) (|dispArrowName| (|Boolean|))
         ($ (|Void|)))
        (SPROG
         ((|sc| (|Scene| (|SCartesian| 2)))
          (|view| (|SBoundary| (|SCartesian| 2))))
         (SEQ
          (LETT |view|
                (SPADCALL (SPADCALL 0 0 (QREFELT $ 99))
                          (SPADCALL (+ (SPADCALL |n| (QREFELT $ 62)) 10)
                                    (+ (SPADCALL |n| (QREFELT $ 63)) 10)
                                    (QREFELT $ 99))
                          (QREFELT $ 109)))
          (LETT |sc| (SPADCALL |view| (QREFELT $ 110)))
          (SPADCALL |sc| |n| |dispArrowName| NIL (QREFELT $ 107))
          (EXIT (SPADCALL |sc| |fileName| (QREFELT $ 111)))))) 

(DECLAIM (NOTINLINE |UndirectedGraph;|)) 

(DEFUN |UndirectedGraph| (#1=#:G1132)
  (SPROG NIL
         (PROG (#2=#:G1133)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|UndirectedGraph|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|UndirectedGraph;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|UndirectedGraph|)))))))))) 

(DEFUN |UndirectedGraph;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|UndirectedGraph| DV$1))
          (LETT $ (GETREFV 122))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|UndirectedGraph| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record|
                     (|:| |objects|
                          (|List|
                           (|Record| (|:| |value| |#1|)
                                     (|:| |posX| (|NonNegativeInteger|))
                                     (|:| |posY| (|NonNegativeInteger|)))))
                     (|:| |arrows|
                          (|List|
                           (|Record| (|:| |name| (|String|))
                                     (|:| |arrType| (|NonNegativeInteger|))
                                     (|:| |fromOb| (|NonNegativeInteger|))
                                     (|:| |toOb| (|NonNegativeInteger|))
                                     (|:| |xOffset| (|Integer|))
                                     (|:| |yOffset| (|Integer|))
                                     (|:| |map|
                                          (|List| (|NonNegativeInteger|))))))))
          $))) 

(MAKEPROP '|UndirectedGraph| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|)
              |UDGRPH;isDirected?;B;1| (|List| 6) |UDGRPH;undirectedGraph;L$;2|
              (|Record| (|:| |value| 6) (|:| |posX| 18) (|:| |posY| 18))
              (|List| 12) |UDGRPH;undirectedGraph;L$;3|
              (|Record| (|:| |name| 44) (|:| |arrType| 18) (|:| |fromOb| 18)
                        (|:| |toOb| 18) (|:| |xOffset| 32) (|:| |yOffset| 32)
                        (|:| |map| 34))
              (|List| 15) |UDGRPH;undirectedGraph;LL$;4| (|NonNegativeInteger|)
              (0 . |createX|) (6 . |createY|) (12 . |concat|) (18 . |concat|)
              (|Record| (|:| |fromOb| 18) (|:| |toOb| 18)) (|List| 23)
              |UDGRPH;undirectedGraph;LL$;5| (|FinitePoset| 6) (24 . |getVert|)
              (|List| (|List| 8)) (29 . |getArr|) (34 . |concat|)
              |UDGRPH;undirectedGraph;Fp$;6| (|Integer|) (40 . |elt|)
              (|List| 18) (|List| 34) (46 . |elt|) (52 . |#|) (57 . |elt|)
              |UDGRPH;undirectedGraph;LL$;7| (63 . =) |UDGRPH;addObject!;$S$;8|
              |UDGRPH;addObject!;$R$;9| |UDGRPH;addArrow!;$R$;10| (|String|)
              |UDGRPH;addArrow!;$S2Nni$;11| |UDGRPH;addArrow!;$S2NniL$;12|
              |UDGRPH;getVertices;$L;13| |UDGRPH;getArrows;$L;14|
              |UDGRPH;initial;$;15| |UDGRPH;terminal;S$;16|
              |UDGRPH;cycleOpen;LS$;17| |UDGRPH;cycleClosed;LS$;18|
              |UDGRPH;unit;LS$;19| (69 . ~=) |UDGRPH;kgraph;LS$;20|
              (75 . |concat|) (81 . |concat|) |UDGRPH;+;3$;21|
              (87 . |position|) (93 . |concat|) |UDGRPH;merge;3$;22|
              (99 . |diagramWidth|) (104 . |diagramHeight|) (|Product| 6 6)
              (109 . |construct|)
              (|Record| (|:| |value| 64) (|:| |posX| 18) (|:| |posY| 18))
              (|List| 66) (115 . |concat|) (121 . |isDirectSuccessor?|)
              (128 . |arrowName|) (|List| $) (135 . |concat|)
              (|UndirectedGraph| 64) (140 . |undirectedGraph|)
              |UDGRPH;*;2$Ug;25| |UDGRPH;cartesian;2$Ug;26| (|Mapping| 6 6 6)
              |UDGRPH;closedTensor;2$M$;28| |UDGRPH;closedCartesian;2$M$;29|
              (146 . |elt|) (152 . |setelt!|) |UDGRPH;map;$LL2I$;30|
              |UDGRPH;mapContra;$LL2I$;31| |UDGRPH;coerce;Fp$;32|
              (|OutputForm|) (159 . |message|) (164 . |coerce|)
              (169 . |commaSeparate|) (174 . |hconcat|) (180 . |coerce|)
              (185 . |hconcat|) (190 . |pile|) |UDGRPH;coerce;$Of;33|
              (|DoubleFloat|) (|Scene| 98) (195 . |addSceneMaterial|)
              (203 . |concat|) (|SCartesian| '2) (209 . |sipnt|)
              (215 . |addSceneText|) (|List| 95) (223 . |concat|) (|Void|)
              (229 . |void|) (233 . |elt|) (239 . |addSceneLine|)
              |UDGRPH;subdiagramSvg;S$2BV;34| (|SBoundary| 98)
              (248 . |boxBoundary|) (254 . |createSceneRoot|)
              (259 . |writeSvgQuantised|) |UDGRPH;diagramSvg;S$BV;35|
              |UDGRPH;diagramSvg2;S$BV;36| (|Matrix| 32) (|Matrix| 18)
              (|List| (|Loop|)) (|Tree| 32) (|List| 117) (|DirectedGraph| $)
              (|SingleInteger|) (|HashState|))
           '#(~= 265 |unit| 271 |undirectedGraph| 277 |terminal| 310
              |subdiagramSvg| 315 |spanningTreeNode| 323 |spanningTreeArrow|
              329 |spanningForestNode| 335 |spanningForestArrow| 340
              |routeNodes| 345 |routeArrows| 352 |outDegree| 359 |nodeToNode|
              365 |nodeToArrow| 371 |nodeFromNode| 377 |nodeFromArrow| 383
              |min| 389 |merge| 400 |max| 406 |mapContra| 417 |map| 426
              |looseEquals| 435 |loopsNodes| 441 |loopsAtNode| 446
              |loopsArrows| 452 |latex| 457 |laplacianMatrix| 462 |kgraph| 467
              |isGreaterThan?| 473 |isFunctional?| 480 |isFixPoint?| 485
              |isDirected?| 491 |isDirectSuccessor?| 495 |isAcyclic?| 502
              |initial| 507 |incidenceMatrix| 511 |inDegree| 516 |hashUpdate!|
              522 |hash| 528 |getVertices| 533 |getVertexIndex| 538 |getArrows|
              544 |getArrowIndex| 549 |flatten| 556 |distanceMatrix| 561
              |distance| 566 |diagramsSvg| 573 |diagramWidth| 580 |diagramSvg2|
              585 |diagramSvg| 592 |diagramHeight| 599 |deepDiagramSvg| 604
              |cycleOpen| 611 |cycleClosed| 617 |createY| 623 |createX| 629
              |createWidth| 635 |coerce| 640 |closedTensor| 650
              |closedCartesian| 657 |cartesian| 664 |arrowsToNode| 670
              |arrowsToArrow| 676 |arrowsFromNode| 682 |arrowsFromArrow| 688
              |arrowName| 694 |adjacencyMatrix| 701 |addObject!| 706
              |addArrow!| 718 = 749 + 755 * 761)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|FiniteGraph&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FiniteGraph| 6) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 85))
                        (|makeByteWordVec2| 121
                                            '(2 0 18 18 18 19 2 0 18 18 18 20 2
                                              13 0 0 12 21 2 16 0 0 15 22 1 26
                                              10 0 27 1 26 28 0 29 2 24 0 0 23
                                              30 2 10 6 0 32 33 2 35 34 0 32 36
                                              1 34 18 0 37 2 34 18 0 32 38 2 13
                                              8 0 0 40 2 18 8 0 0 54 2 13 0 0 0
                                              56 2 16 0 0 0 57 2 13 32 12 0 59
                                              2 34 0 0 18 60 1 0 18 0 62 1 0 18
                                              0 63 2 64 0 6 6 65 2 67 0 0 66 68
                                              3 0 8 0 18 18 69 3 0 44 0 18 18
                                              70 1 44 0 71 72 2 73 0 67 16 74 2
                                              13 12 0 32 80 3 13 12 0 32 12 81
                                              1 85 0 44 86 1 6 85 0 87 1 85 0
                                              71 88 2 85 0 0 0 89 1 18 85 0 90
                                              1 85 0 71 91 1 85 0 71 92 4 95 0
                                              0 94 44 44 96 2 10 0 0 6 97 2 98
                                              0 32 32 99 4 95 0 0 44 18 98 100
                                              2 101 0 0 95 102 0 103 0 104 2
                                              101 95 0 32 105 5 95 0 0 0 0 94 8
                                              106 2 108 0 98 98 109 1 95 0 108
                                              110 2 95 103 0 44 111 2 0 8 0 0 1
                                              2 0 0 10 44 53 2 0 0 10 35 39 1 0
                                              0 26 31 2 0 0 13 16 17 2 0 0 10
                                              24 25 1 0 0 10 11 1 0 0 13 14 1 0
                                              0 6 50 4 0 103 95 0 8 8 107 2 0
                                              117 0 18 1 2 0 117 0 18 1 1 0 118
                                              0 1 1 0 118 0 1 3 0 34 0 18 18 1
                                              3 0 34 0 18 18 1 2 0 18 0 18 1 2
                                              0 34 0 18 1 2 0 34 0 18 1 2 0 34
                                              0 18 1 2 0 34 0 18 1 2 0 18 0 34
                                              1 1 0 18 0 1 2 0 0 0 0 61 1 0 18
                                              0 1 2 0 18 0 34 1 5 0 0 0 34 10
                                              32 32 83 5 0 0 0 34 10 32 32 82 2
                                              0 8 0 0 1 1 0 116 0 1 2 0 116 0
                                              18 1 1 0 116 0 1 1 0 44 0 1 1 0
                                              114 0 1 2 0 0 10 44 55 3 0 8 0 18
                                              18 1 1 0 8 0 1 2 0 8 0 18 1 0 0 8
                                              9 3 0 8 0 18 18 69 1 0 8 0 1 0 0
                                              0 49 1 0 114 0 1 2 0 18 0 18 1 2
                                              0 121 121 0 1 1 0 120 0 1 1 0 13
                                              0 47 2 0 18 0 6 1 1 0 16 0 48 3 0
                                              18 0 18 18 1 1 0 0 119 1 1 0 114
                                              0 1 3 0 32 0 18 18 1 3 0 103 44
                                              71 8 1 1 0 18 0 62 3 0 103 44 0 8
                                              113 3 0 103 44 0 8 112 1 0 18 0
                                              63 3 0 103 44 0 8 1 2 0 0 10 44
                                              51 2 0 0 10 44 52 2 0 18 18 18 20
                                              2 0 18 18 18 19 1 0 18 18 1 1 0 0
                                              26 84 1 0 85 0 93 3 0 0 0 0 77 78
                                              3 0 0 0 0 77 79 2 0 73 0 0 76 2 0
                                              34 0 18 1 2 0 34 0 18 1 2 0 34 0
                                              18 1 2 0 34 0 18 1 3 0 44 0 18 18
                                              70 1 0 115 0 1 2 0 0 0 6 41 2 0 0
                                              0 12 42 4 0 0 0 44 6 6 1 4 0 0 0
                                              44 18 18 45 5 0 0 0 44 18 18 34
                                              46 2 0 0 0 15 43 2 0 8 0 0 1 2 0
                                              0 0 0 58 2 0 73 0 0 75)))))
           '|lookupComplete|)) 
