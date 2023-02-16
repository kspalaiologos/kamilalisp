
(SDEFUN |FNGRPH;functionGraph;L$;1| ((|ob| (|List| S)) ($ ($)))
        (SPROG
         ((|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#1=#:G716 NIL) (|x| NIL) (#2=#:G715 NIL))
         (SEQ
          (LETT |objs|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |ob|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (VECTOR |x| 0 0 0 NIL) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (LIST |objs|))))) 

(PUT '|FNGRPH;functionGraph;L$;2| '|SPADreplace| 'LIST) 

(SDEFUN |FNGRPH;functionGraph;L$;2|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         ($ ($)))
        (LIST |ob|)) 

(SDEFUN |FNGRPH;functionGraph;LL$;3|
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
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|fo|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|f|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (#1=#:G751 NIL) (|fn| NIL) (|too| (|NonNegativeInteger|))
          (|fromo| (|NonNegativeInteger|)) (#2=#:G750 NIL) (|a| NIL)
          (|arrs| (|List| (|NonNegativeInteger|))) (#3=#:G749 NIL) (|x| NIL)
          (#4=#:G748 NIL))
         (SEQ
          (LETT |arrs|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |x| 1) (LETT #3# (LENGTH |ob|)) G190
                      (COND ((|greater_SI| |x| #3#) (GO G191)))
                      (SEQ (EXIT (LETT #4# (CONS |x| #4#))))
                      (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (SEQ (LETT |a| NIL) (LETT #2# |ar|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |a| (CAR #2#)) NIL)) (GO G191)))
               (SEQ (LETT |fromo| (QVELT |a| 2)) (LETT |too| (QVELT |a| 3))
                    (EXIT (SPADCALL |arrs| |fromo| |too| (QREFELT $ 16))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (LETT |fobs| NIL)
          (SEQ (LETT |fn| 1) (LETT #1# (LENGTH |ob|)) G190
               (COND ((|greater_SI| |fn| #1#) (GO G191)))
               (SEQ (LETT |f| (SPADCALL |ob| |fn| (QREFELT $ 19)))
                    (LETT |fo|
                          (VECTOR (QVELT |f| 0) (QVELT |f| 1) (QVELT |f| 2)
                                  (SPADCALL |arrs| |fn| (QREFELT $ 20)) NIL))
                    (EXIT (LETT |fobs| (SPADCALL |fobs| |fo| (QREFELT $ 21)))))
               (LETT |fn| (|inc_SI| |fn|)) (GO G190) G191 (EXIT NIL))
          (EXIT (LIST |fobs|))))) 

(SDEFUN |FNGRPH;functionGraph;L$;4|
        ((|perms| (|List| (|Permutation| S))) ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|n| (|NonNegativeInteger|)) (#1=#:G766 NIL) (|j| NIL)
          (#2=#:G764 NIL) (|vert| NIL) (#3=#:G765 NIL) (|i| NIL)
          (|preim| #4=(|List| S)) (|im| #5=(|List| S))
          (|lr| (|Record| (|:| |preimage| #4#) (|:| |image| #5#)))
          (|perm| (|Permutation| S)))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |perms|) 1 (QREFELT $ 28))
            (|error| "functionGraph only needs one permutation")))
          (LETT |obs| NIL) (LETT |perm| (|SPADfirst| |perms|))
          (LETT |lr| (SPADCALL |perm| (QREFELT $ 30))) (LETT |im| (QCDR |lr|))
          (LETT |preim| (QCAR |lr|))
          (SEQ (LETT |i| 1) (LETT #3# (LENGTH |im|)) (LETT |vert| NIL)
               (LETT #2# |im|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |vert| (CAR #2#)) NIL)
                     (|greater_SI| |i| #3#))
                 (GO G191)))
               (SEQ (LETT |n| 1)
                    (SEQ (LETT |j| 1) (LETT #1# (LENGTH |preim|)) G190
                         (COND ((|greater_SI| |j| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |im| |i| (QREFELT $ 31))
                                       (SPADCALL |preim| |j| (QREFELT $ 31))
                                       (QREFELT $ 32))
                             (LETT |n| |j|)))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (LETT |o|
                          (VECTOR |vert|
                                  (SPADCALL (LENGTH |im|) |i| (QREFELT $ 33))
                                  (SPADCALL (LENGTH |im|) |i| (QREFELT $ 34))
                                  |n| NIL))
                    (EXIT (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))))
               (LETT #2# (PROG1 (CDR #2#) (LETT |i| (|inc_SI| |i|)))) (GO G190)
               G191 (EXIT NIL))
          (EXIT (LIST |obs|))))) 

(SDEFUN |FNGRPH;addObject!;$S$;5| ((|s| ($)) (|n| (S)) ($ ($)))
        (SPROG
         ((|obj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |obs| (QCAR |s|))
              (LETT |obj| (VECTOR |n| 0 0 (LENGTH |obs|) NIL))
              (COND
               ((SPADCALL |obs| NIL (QREFELT $ 37))
                (PROGN (RPLACA |s| (LIST |obj|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |obj| (QREFELT $ 21)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |FNGRPH;addObject!;$R$;6|
        ((|s| ($))
         (|n|
          (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                    (|:| |posY| #1#)))
         ($ ($)))
        (SEQ (|error| "this form of addObject! not supported in functionGraph")
             (EXIT (LIST NIL)))) 

(SDEFUN |FNGRPH;addArrow!;$S2Nni$;7|
        ((|s| ($)) (|nm| (|String|)) (|n1| #1=(|NonNegativeInteger|))
         (|n2| #1#) ($ ($)))
        (SEQ (QSETVELT (SPADCALL (QCAR |s|) |n1| (QREFELT $ 40)) 3 |n2|)
             (EXIT |s|))) 

(SDEFUN |FNGRPH;getVertices;$L;8|
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
          (|o| #1#) (#2=#:G783 NIL) (|soj| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |soj| NIL) (LETT #2# (QCAR |s|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |soj| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR (QVELT |soj| 0) (QVELT |soj| 1)
                                  (QVELT |soj| 2)))
                    (EXIT (LETT |res| (SPADCALL |res| |o| (QREFELT $ 43)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FNGRPH;getArrows;$L;9|
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
         ((|res|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#)
          (|soj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (#2=#:G791 NIL) (|sojn| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |sojn| 1) (LETT #2# (LENGTH (QCAR |s|))) G190
                   (COND ((|greater_SI| |sojn| #2#) (GO G191)))
                   (SEQ
                    (LETT |soj| (SPADCALL (QCAR |s|) |sojn| (QREFELT $ 40)))
                    (LETT |a|
                          (VECTOR (STRINGIMAGE |sojn|) 0 |sojn| (QVELT |soj| 3)
                                  0 0 (QVELT |soj| 4)))
                    (EXIT (LETT |res| (SPADCALL |res| |a| (QREFELT $ 45)))))
                   (LETT |sojn| (|inc_SI| |sojn|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(PUT '|FNGRPH;initial;$;10| '|SPADreplace| '(XLAM NIL (LIST NIL))) 

(SDEFUN |FNGRPH;initial;$;10| (($ ($))) (LIST NIL)) 

(SDEFUN |FNGRPH;terminal;S$;11| ((|a| (S)) ($ ($)))
        (SPROG
         ((|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         (SEQ (LETT |o| (VECTOR |a| 0 0 1 NIL)) (EXIT (LIST (LIST |o|)))))) 

(SDEFUN |FNGRPH;cycleOpen;LS$;12|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|n| (|NonNegativeInteger|)) (|ob| (S)) (#1=#:G802 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #1# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #1#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 31)))
                        (LETT |n| (+ |obn| 1))
                        (COND
                         ((EQL |obn| (LENGTH |objs|))
                          (LETT |n| (LENGTH |objs|))))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 33))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 34))
                                      |n| NIL))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |obs|))))) 

(SDEFUN |FNGRPH;cycleClosed;LS$;13|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|n| (|NonNegativeInteger|)) (|ob| (S)) (#1=#:G810 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #1# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #1#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 31)))
                        (LETT |n| (+ |obn| 1))
                        (COND ((EQL |obn| (LENGTH |objs|)) (LETT |n| 1)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 33))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 34))
                                      |n| NIL))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 21)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |obs|))))) 

(SDEFUN |FNGRPH;unit;LS$;14|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG ((#1=#:G816 NIL) (|x| NIL) (#2=#:G815 NIL))
               (SEQ
                (LETT |objs|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |x| 1) (LETT #1# (LENGTH |objs|)) G190
                            (COND ((|greater_SI| |x| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS
                                     (VECTOR
                                      (SPADCALL |objs| |x| (QREFELT $ 31)) 0 0
                                      |x| NIL)
                                     #2#))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))
                (EXIT (LIST |objs|))))) 

(SDEFUN |FNGRPH;kgraph;LS$;15|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SEQ (|error| "kgraph not valid in function graph") (EXIT (LIST NIL)))) 

(SDEFUN |FNGRPH;+;3$;16| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|c|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#1=#:G827 NIL) (|x| NIL) (#2=#:G826 NIL)
          (|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |objs| (QCAR |b|))
              (LETT |c|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |x| 1) (LETT #1# (LENGTH |objs|)) G190
                          (COND ((|greater_SI| |x| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (VECTOR
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 40))
                                           0)
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 40))
                                           1)
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 40))
                                           2)
                                    (+ |x| (LENGTH (QCAR |a|)))
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 40))
                                           4))
                                   #2#))))
                          (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (LIST (SPADCALL (QCAR |a|) |c| (QREFELT $ 53))))))) 

(SDEFUN |FNGRPH;merge;3$;17| ((|a| ($)) (|b| ($)) ($ ($)))
        (SEQ (|error| "merge not valid in function graph") (EXIT (LIST NIL)))) 

(SDEFUN |FNGRPH;indexProd|
        ((|aObj| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|x| (|NonNegativeInteger|)) (#1=#:G830 NIL))
               (SEQ
                (LETT |x|
                      (+ |a|
                         (*
                          (PROG1 (LETT #1# (- |b| 1))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))
                          (LENGTH (QCAR |aObj|)))))
                (EXIT |x|)))) 

(SDEFUN |FNGRPH;*;2$Fg;19|
        ((|a| ($)) (|b| ($)) ($ (|FunctionGraph| (|Product| S S))))
        (SPROG
         ((|newObjs|
           (|List|
            #1=(|Record| (|:| |value| (|Product| S S))
                         (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|NonNegativeInteger|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|ob| #1#) (|sp| (|Product| S S)) (|nextA| (|NonNegativeInteger|))
          (|y| #2=(|NonNegativeInteger|)) (|x| #2#)
          (|bni| #3=(|NonNegativeInteger|)) (|byi| #4=(|NonNegativeInteger|))
          (|bxi| #5=(|NonNegativeInteger|)) (|bi| (S)) (#6=#:G848 NIL)
          (|boi| NIL) (|ani| #3#) (|ayi| #4#) (|axi| #5#) (|ai| (S))
          (#7=#:G847 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #7# (QCAR |a|)) G190
                   (COND
                    ((OR (ATOM #7#) (PROGN (LETT |aoi| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ai| (QVELT |aoi| 0))
                        (LETT |axi| (QVELT |aoi| 1))
                        (LETT |ayi| (QVELT |aoi| 2))
                        (LETT |ani| (QVELT |aoi| 3))
                        (EXIT
                         (SEQ (LETT |boi| NIL) (LETT #6# (QCAR |b|)) G190
                              (COND
                               ((OR (ATOM #6#)
                                    (PROGN (LETT |boi| (CAR #6#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |bi| (QVELT |boi| 0))
                                   (LETT |bxi| (QVELT |boi| 1))
                                   (LETT |byi| (QVELT |boi| 2))
                                   (LETT |bni| (QVELT |boi| 3))
                                   (LETT |x|
                                         (+
                                          (* |bxi|
                                             (SPADCALL |a| (QREFELT $ 56)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 57)))
                                          |ayi|))
                                   (LETT |nextA|
                                         (|FNGRPH;indexProd| |b| |bni| |ani|
                                          $))
                                   (LETT |sp|
                                         (SPADCALL |ai| |bi| (QREFELT $ 59)))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y| |nextA| NIL))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 62)))))
                              (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |newObjs| (QREFELT $ 64)))))) 

(SDEFUN |FNGRPH;closedTensor;2$M$;20|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|ob|
           (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                     (|:| |posY| #2=(|NonNegativeInteger|))
                     (|:| |next| #3=(|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|sp| (S)) (|nextA| (|NonNegativeInteger|))
          (|y| #4=(|NonNegativeInteger|)) (|x| #4#) (|bni| #3#) (|byi| #2#)
          (|bxi| #1#) (|bi| (S)) (#5=#:G859 NIL) (|boi| NIL) (|ani| #3#)
          (|ayi| #2#) (|axi| #1#) (|ai| (S)) (#6=#:G858 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #6# (QCAR |a|)) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |aoi| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ai| (QVELT |aoi| 0))
                        (LETT |axi| (QVELT |aoi| 1))
                        (LETT |ayi| (QVELT |aoi| 2))
                        (LETT |ani| (QVELT |aoi| 3))
                        (EXIT
                         (SEQ (LETT |boi| NIL) (LETT #5# (QCAR |b|)) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |boi| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |bi| (QVELT |boi| 0))
                                   (LETT |bxi| (QVELT |boi| 1))
                                   (LETT |byi| (QVELT |boi| 2))
                                   (LETT |bni| (QVELT |boi| 3))
                                   (LETT |x|
                                         (+
                                          (* |bxi|
                                             (SPADCALL |a| (QREFELT $ 56)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 57)))
                                          |ayi|))
                                   (LETT |nextA|
                                         (|FNGRPH;indexProd| |b| |bni| |ani|
                                          $))
                                   (LETT |sp| (SPADCALL |ai| |bi| |f|))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y| |nextA| NIL))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 21)))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |newObjs| (QREFELT $ 12)))))) 

(SDEFUN |FNGRPH;map;$LL2I$;21|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|nwob|
           #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                        (|:| |posY| (|NonNegativeInteger|))
                        (|:| |next| (|NonNegativeInteger|))
                        (|:| |map| (|List| (|NonNegativeInteger|)))))
          (#3=#:G879 NIL) (|p| NIL)
          (|nv|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|newNext| #4=(|NonNegativeInteger|)) (|newY| (|NonNegativeInteger|))
          (#5=#:G866 NIL) (|newX| (|NonNegativeInteger|)) (#6=#:G865 NIL)
          (|newObj| (S)) (|inext| #4#) (|i| #4#) (|oldObj| #2#) (#7=#:G878 NIL)
          (|oi| NIL)
          (|oldObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#8=#:G877 NIL) (|o| NIL) (#9=#:G876 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #9# NIL)
                 (SEQ (LETT |o| NIL) (LETT #8# |newOb|) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |o| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #9# (CONS (VECTOR |o| 0 0 0 NIL) #9#))))
                      (LETT #8# (CDR #8#)) (GO G190) G191
                      (EXIT (NREVERSE #9#)))))
          (LETT |oldObjs| (QCAR |s|))
          (SEQ (LETT |oi| 1) (LETT #7# (LENGTH |oldObjs|)) G190
               (COND ((|greater_SI| |oi| #7#) (GO G191)))
               (SEQ (LETT |oldObj| (SPADCALL |oldObjs| |oi| (QREFELT $ 40)))
                    (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 20)))
                    (LETT |inext|
                          (SPADCALL |m| (QVELT |oldObj| 3) (QREFELT $ 20)))
                    (LETT |newObj| (SPADCALL |newOb| |i| (QREFELT $ 31)))
                    (LETT |newX|
                          (PROG1 (LETT #6# (+ (QVELT |oldObj| 1) |offsetX|))
                            (|check_subtype2| (>= #6# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #6#)))
                    (LETT |newY|
                          (PROG1 (LETT #5# (+ (QVELT |oldObj| 2) |offsetY|))
                            (|check_subtype2| (>= #5# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #5#)))
                    (LETT |newNext|
                          (SPADCALL |m| (QVELT |oldObj| 3) (QREFELT $ 20)))
                    (LETT |nv|
                          (VECTOR |newObj| |newX| |newY| |newNext|
                                  (QVELT |oldObj| 4)))
                    (EXIT
                     (COND
                      ((SPADCALL |i| |inext| (QREFELT $ 28))
                       (SPADCALL |newObjs| |i| |nv| (QREFELT $ 68))))))
               (LETT |oi| (|inc_SI| |oi|)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |p| 1) (LETT #3# (LENGTH |newObjs|)) G190
               (COND ((|greater_SI| |p| #3#) (GO G191)))
               (SEQ (LETT |nwob| (SPADCALL |newObjs| |p| (QREFELT $ 40)))
                    (EXIT
                     (COND ((< (QVELT |nwob| 3) 1) (QSETVELT |nwob| 3 |p|)))))
               (LETT |p| (|inc_SI| |p|)) (GO G190) G191 (EXIT NIL))
          (EXIT (LIST |newObjs|))))) 

(SDEFUN |FNGRPH;mapContra;$LL2I$;22|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|nwob|
           #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                        (|:| |posY| (|NonNegativeInteger|))
                        (|:| |next| (|NonNegativeInteger|))
                        (|:| |map| (|List| (|NonNegativeInteger|)))))
          (#3=#:G902 NIL) (|p| NIL)
          (|n|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|NonNegativeInteger|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|newNext| #4=(|NonNegativeInteger|))
          (|incoming| (|List| (|NonNegativeInteger|)))
          (|newY| (|NonNegativeInteger|)) (#5=#:G886 NIL)
          (|newX| (|NonNegativeInteger|)) (#6=#:G885 NIL) (|newObj| (S))
          (|inext| #4#) (|i| #4#) (|oldObj| #2#) (#7=#:G901 NIL) (|oi| NIL)
          (|oldObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|NonNegativeInteger|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#8=#:G900 NIL) (|o| NIL) (#9=#:G899 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #9# NIL)
                 (SEQ (LETT |o| NIL) (LETT #8# |newOb|) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |o| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #9# (CONS (VECTOR |o| 0 0 0 NIL) #9#))))
                      (LETT #8# (CDR #8#)) (GO G190) G191
                      (EXIT (NREVERSE #9#)))))
          (LETT |oldObjs| (QCAR |s|))
          (SEQ (LETT |oi| 1) (LETT #7# (LENGTH |oldObjs|)) G190
               (COND ((|greater_SI| |oi| #7#) (GO G191)))
               (SEQ (LETT |oldObj| (SPADCALL |oldObjs| |oi| (QREFELT $ 40)))
                    (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 20)))
                    (LETT |inext|
                          (SPADCALL |m| (QVELT |oldObj| 3) (QREFELT $ 20)))
                    (LETT |newObj| (SPADCALL |newOb| |i| (QREFELT $ 31)))
                    (LETT |newX|
                          (PROG1 (LETT #6# (+ (QVELT |oldObj| 1) |offsetX|))
                            (|check_subtype2| (>= #6# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #6#)))
                    (LETT |newY|
                          (PROG1 (LETT #5# (+ (QVELT |oldObj| 2) |offsetY|))
                            (|check_subtype2| (>= #5# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #5#)))
                    (LETT |incoming| (SPADCALL |s| |oi| (QREFELT $ 70)))
                    (COND
                     ((SPADCALL (SPADCALL |incoming| (QREFELT $ 71)) 1
                                (QREFELT $ 28))
                      (|error| "not a FunctionGraph")))
                    (LETT |newNext|
                          (SPADCALL |m| (|SPADfirst| |incoming|)
                                    (QREFELT $ 20)))
                    (LETT |n|
                          (VECTOR |newObj| |newX| |newY| |newNext|
                                  (QVELT |oldObj| 4)))
                    (EXIT
                     (COND
                      ((SPADCALL |i| |inext| (QREFELT $ 28))
                       (SPADCALL |newObjs| |i| |n| (QREFELT $ 68))))))
               (LETT |oi| (|inc_SI| |oi|)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |p| 1) (LETT #3# (LENGTH |newObjs|)) G190
               (COND ((|greater_SI| |p| #3#) (GO G191)))
               (SEQ (LETT |nwob| (SPADCALL |newObjs| |p| (QREFELT $ 40)))
                    (EXIT
                     (COND ((< (QVELT |nwob| 3) 1) (QSETVELT |nwob| 3 |p|)))))
               (LETT |p| (|inc_SI| |p|)) (GO G190) G191 (EXIT NIL))
          (EXIT (LIST |newObjs|))))) 

(SDEFUN |FNGRPH;coAdjoint;$LU;23|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|List| (|NonNegativeInteger|)) "failed")))
        (SPROG
         ((|entry| (|NonNegativeInteger|)) (#1=#:G923 NIL)
          (|x| (|NonNegativeInteger|)) (#2=#:G930 NIL) (|ri| NIL)
          (#3=#:G929 NIL) (|mi| NIL)
          (|retOpt| (|List| (|List| (|NonNegativeInteger|)))) (#4=#:G928 NIL)
          (#5=#:G927 NIL) (|ret| (|List| (|NonNegativeInteger|)))
          (#6=#:G926 NIL) (#7=#:G925 NIL)
          (|codomainSize| (|NonNegativeInteger|)) (#8=#:G924 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |codomainSize| 0)
                (SEQ (LETT |mi| NIL) (LETT #8# |m|) G190
                     (COND
                      ((OR (ATOM #8#) (PROGN (LETT |mi| (CAR #8#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((> |mi| |codomainSize|) (LETT |codomainSize| |mi|)))))
                     (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                (LETT |ret|
                      (PROGN
                       (LETT #7# NIL)
                       (SEQ (LETT |x| 1) (LETT #6# |codomainSize|) G190
                            (COND ((|greater_SI| |x| #6#) (GO G191)))
                            (SEQ (EXIT (LETT #7# (CONS 0 #7#))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT (NREVERSE #7#)))))
                (LETT |retOpt|
                      (PROGN
                       (LETT #5# NIL)
                       (SEQ (LETT |x| 1) (LETT #4# |codomainSize|) G190
                            (COND ((|greater_SI| |x| #4#) (GO G191)))
                            (SEQ (EXIT (LETT #5# (CONS NIL #5#))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT (NREVERSE #5#)))))
                (SEQ (LETT |mi| 1) (LETT #3# (SPADCALL |m| (QREFELT $ 71)))
                     G190 (COND ((|greater_SI| |mi| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |retOpt| (SPADCALL |m| |mi| (QREFELT $ 20))
                                 (SPADCALL
                                  (SPADCALL |retOpt|
                                            (SPADCALL |m| |mi| (QREFELT $ 20))
                                            (QREFELT $ 74))
                                  |mi| (QREFELT $ 75))
                                 (QREFELT $ 76))))
                     (LETT |mi| (|inc_SI| |mi|)) (GO G190) G191 (EXIT NIL))
                (LETT |entry| 1)
                (SEQ (LETT |ri| NIL) (LETT #2# |retOpt|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |ri| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |x| (SPADCALL |s| |ri| (QREFELT $ 77)))
                          (COND
                           ((EQL |x| 0)
                            (PROGN
                             (LETT #1# (CONS 1 "failed"))
                             (GO #9=#:G922))))
                          (SPADCALL |ret| |entry| |x| (QREFELT $ 16))
                          (EXIT (LETT |entry| (+ |entry| 1))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ret|))))
          #9# (EXIT #1#)))) 

(SDEFUN |FNGRPH;contraAdjoint;$LU;24|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|List| (|NonNegativeInteger|)) "failed")))
        (SPROG
         ((|entry| (|NonNegativeInteger|)) (#1=#:G948 NIL)
          (|x| (|NonNegativeInteger|)) (#2=#:G955 NIL) (|ri| NIL)
          (#3=#:G954 NIL) (|mi| NIL)
          (|retOpt| (|List| (|List| (|NonNegativeInteger|)))) (#4=#:G953 NIL)
          (#5=#:G952 NIL) (|ret| (|List| (|NonNegativeInteger|)))
          (#6=#:G951 NIL) (#7=#:G950 NIL)
          (|codomainSize| (|NonNegativeInteger|)) (#8=#:G949 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |codomainSize| 0)
                (SEQ (LETT |mi| NIL) (LETT #8# |m|) G190
                     (COND
                      ((OR (ATOM #8#) (PROGN (LETT |mi| (CAR #8#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((> |mi| |codomainSize|) (LETT |codomainSize| |mi|)))))
                     (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                (LETT |ret|
                      (PROGN
                       (LETT #7# NIL)
                       (SEQ (LETT |x| 1) (LETT #6# |codomainSize|) G190
                            (COND ((|greater_SI| |x| #6#) (GO G191)))
                            (SEQ (EXIT (LETT #7# (CONS 0 #7#))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT (NREVERSE #7#)))))
                (LETT |retOpt|
                      (PROGN
                       (LETT #5# NIL)
                       (SEQ (LETT |x| 1) (LETT #4# |codomainSize|) G190
                            (COND ((|greater_SI| |x| #4#) (GO G191)))
                            (SEQ (EXIT (LETT #5# (CONS NIL #5#))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT (NREVERSE #5#)))))
                (SEQ (LETT |mi| 1) (LETT #3# (SPADCALL |m| (QREFELT $ 71)))
                     G190 (COND ((|greater_SI| |mi| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |retOpt| (SPADCALL |m| |mi| (QREFELT $ 20))
                                 (SPADCALL
                                  (SPADCALL |retOpt|
                                            (SPADCALL |m| |mi| (QREFELT $ 20))
                                            (QREFELT $ 74))
                                  |mi| (QREFELT $ 75))
                                 (QREFELT $ 76))))
                     (LETT |mi| (|inc_SI| |mi|)) (GO G190) G191 (EXIT NIL))
                (LETT |entry| 1)
                (SEQ (LETT |ri| NIL) (LETT #2# |retOpt|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |ri| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |x| (SPADCALL |s| |ri| (QREFELT $ 80)))
                          (COND
                           ((EQL |x| 0)
                            (PROGN
                             (LETT #1# (CONS 1 "failed"))
                             (GO #9=#:G947))))
                          (SPADCALL |ret| |entry| |x| (QREFELT $ 16))
                          (EXIT (LETT |entry| (+ |entry| 1))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ret|))))
          #9# (EXIT #1#)))) 

(SDEFUN |FNGRPH;apply;$2Nni;25|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (QVELT (SPADCALL (QCAR |s|) |a| (QREFELT $ 40)) 3)) 

(SDEFUN |FNGRPH;limit;$NniL;26|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) ($ (|Loop|)))
        (SPROG
         ((|ptr| (|NonNegativeInteger|)) (#1=#:G966 NIL)
          (|lp| (|List| (|Loop|))) (#2=#:G967 NIL) (|s1| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ptr| |a|)
                (SEQ (LETT |s1| NIL) (LETT #2# (QCAR |s|)) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |s1| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |lp| (SPADCALL |s| |ptr| (QREFELT $ 84)))
                          (COND
                           ((> (LENGTH |lp|) 1)
                            (|error| "limit: cant have >1 loop through node")))
                          (COND
                           ((EQL (LENGTH |lp|) 1)
                            (PROGN
                             (LETT #1# (|SPADfirst| |lp|))
                             (GO #3=#:G965))))
                          (EXIT
                           (LETT |ptr| (SPADCALL |s| |ptr| (QREFELT $ 82)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL NIL (QREFELT $ 86)))))
          #3# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |FunctionGraph;|)) 

(DEFUN |FunctionGraph| (#1=#:G971)
  (SPROG NIL
         (PROG (#2=#:G972)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FunctionGraph|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FunctionGraph;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FunctionGraph|)))))))))) 

(DEFUN |FunctionGraph;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FunctionGraph| DV$1))
          (LETT $ (GETREFV 99))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionGraph| (LIST DV$1)
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
                                     (|:| |posY| (|NonNegativeInteger|))
                                     (|:| |next| (|NonNegativeInteger|))
                                     (|:| |map|
                                          (|List| (|NonNegativeInteger|))))))))
          $))) 

(MAKEPROP '|FunctionGraph| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|List| 6)
              |FNGRPH;functionGraph;L$;1|
              (|Record| (|:| |value| 6) (|:| |posX| 13) (|:| |posY| 13)
                        (|:| |next| 13) (|:| |map| 15))
              (|List| 10) |FNGRPH;functionGraph;L$;2| (|NonNegativeInteger|)
              (|Integer|) (|List| 13) (0 . |setelt!|)
              (|Record| (|:| |value| 6) (|:| |posX| 13) (|:| |posY| 13))
              (|List| 17) (7 . |elt|) (13 . |elt|) (19 . |concat|)
              (|Record| (|:| |name| 41) (|:| |arrType| 13) (|:| |fromOb| 13)
                        (|:| |toOb| 13) (|:| |xOffset| 14) (|:| |yOffset| 14)
                        (|:| |map| 15))
              (|List| 22) |FNGRPH;functionGraph;LL$;3| (|Permutation| 6)
              (25 . |One|) (|Boolean|) (29 . ~=)
              (|Record| (|:| |preimage| 8) (|:| |image| 8))
              (35 . |listRepresentation|) (40 . |elt|) (46 . =)
              (52 . |createX|) (58 . |createY|) (|List| 25)
              |FNGRPH;functionGraph;L$;4| (64 . =) |FNGRPH;addObject!;$S$;5|
              |FNGRPH;addObject!;$R$;6| (70 . |elt|) (|String|)
              |FNGRPH;addArrow!;$S2Nni$;7| (76 . |concat|)
              |FNGRPH;getVertices;$L;8| (82 . |concat|) |FNGRPH;getArrows;$L;9|
              |FNGRPH;initial;$;10| |FNGRPH;terminal;S$;11|
              |FNGRPH;cycleOpen;LS$;12| |FNGRPH;cycleClosed;LS$;13|
              |FNGRPH;unit;LS$;14| |FNGRPH;kgraph;LS$;15| (88 . |concat|)
              |FNGRPH;+;3$;16| |FNGRPH;merge;3$;17| (94 . |diagramWidth|)
              (99 . |diagramHeight|) (|Product| 6 6) (104 . |construct|)
              (|Record| (|:| |value| 58) (|:| |posX| 13) (|:| |posY| 13)
                        (|:| |next| 13) (|:| |map| 15))
              (|List| 60) (110 . |concat|) (|FunctionGraph| 58)
              (116 . |functionGraph|) |FNGRPH;*;2$Fg;19| (|Mapping| 6 6 6)
              |FNGRPH;closedTensor;2$M$;20| (121 . |setelt!|)
              |FNGRPH;map;$LL2I$;21| (128 . |nodeToNode|) (134 . |#|)
              |FNGRPH;mapContra;$LL2I$;22| (|List| 15) (139 . |elt|)
              (145 . |concat|) (151 . |setelt!|) (158 . |max|)
              (|Union| 15 '"failed") |FNGRPH;coAdjoint;$LU;23| (164 . |min|)
              |FNGRPH;contraAdjoint;$LU;24| |FNGRPH;apply;$2Nni;25| (|List| 85)
              (170 . |loopsAtNode|) (|Loop|) (176 . |loop|)
              |FNGRPH;limit;$NniL;26| (|Void|) (|List| $)
              (|Scene| (|SCartesian| '2)) (|Matrix| 14) (|Matrix| 13)
              (|List| 94) (|Tree| 14) (|DirectedGraph| $) (|SingleInteger|)
              (|HashState|) (|OutputForm|))
           '#(~= 181 |unit| 187 |terminal| 193 |subdiagramSvg| 198
              |spanningTreeNode| 206 |spanningTreeArrow| 212
              |spanningForestNode| 218 |spanningForestArrow| 223 |routeNodes|
              228 |routeArrows| 235 |outDegree| 242 |nodeToNode| 248
              |nodeToArrow| 254 |nodeFromNode| 260 |nodeFromArrow| 266 |min|
              272 |merge| 283 |max| 289 |mapContra| 300 |map| 309 |looseEquals|
              318 |loopsNodes| 324 |loopsAtNode| 329 |loopsArrows| 335 |limit|
              340 |latex| 346 |laplacianMatrix| 351 |kgraph| 356
              |isGreaterThan?| 362 |isFunctional?| 369 |isFixPoint?| 374
              |isDirected?| 380 |isDirectSuccessor?| 384 |isAcyclic?| 391
              |initial| 396 |incidenceMatrix| 400 |inDegree| 405 |hashUpdate!|
              411 |hash| 417 |getVertices| 422 |getVertexIndex| 427 |getArrows|
              433 |getArrowIndex| 438 |functionGraph| 445 |flatten| 466
              |distanceMatrix| 471 |distance| 476 |diagramsSvg| 483
              |diagramWidth| 490 |diagramSvg| 495 |diagramHeight| 502
              |deepDiagramSvg| 507 |cycleOpen| 514 |cycleClosed| 520 |createY|
              526 |createX| 532 |createWidth| 538 |contraAdjoint| 543 |coerce|
              549 |coAdjoint| 554 |closedTensor| 560 |arrowsToNode| 567
              |arrowsToArrow| 573 |arrowsFromNode| 579 |arrowsFromArrow| 585
              |arrowName| 591 |apply| 598 |adjacencyMatrix| 604 |addObject!|
              609 |addArrow!| 621 = 652 + 658 * 664)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|FiniteGraph&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FiniteGraph| 6) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 98))
                        (|makeByteWordVec2| 98
                                            '(3 15 13 0 14 13 16 2 18 17 0 14
                                              19 2 15 13 0 14 20 2 11 0 0 10 21
                                              0 25 0 26 2 13 27 0 0 28 1 25 29
                                              0 30 2 8 6 0 14 31 2 6 27 0 0 32
                                              2 0 13 13 13 33 2 0 13 13 13 34 2
                                              11 27 0 0 37 2 11 10 0 14 40 2 18
                                              0 0 17 43 2 23 0 0 22 45 2 11 0 0
                                              0 53 1 0 13 0 56 1 0 13 0 57 2 58
                                              0 6 6 59 2 61 0 0 60 62 1 63 0 61
                                              64 3 11 10 0 14 10 68 2 0 15 0 13
                                              70 1 15 13 0 71 2 73 15 0 14 74 2
                                              15 0 0 13 75 3 73 15 0 14 15 76 2
                                              0 13 0 15 77 2 0 13 0 15 80 2 0
                                              83 0 13 84 1 85 0 15 86 2 0 27 0
                                              0 1 2 0 0 8 41 51 1 0 0 6 48 4 0
                                              88 90 0 27 27 1 2 0 94 0 13 1 2 0
                                              94 0 13 1 1 0 93 0 1 1 0 93 0 1 3
                                              0 15 0 13 13 1 3 0 15 0 13 13 1 2
                                              0 13 0 13 1 2 0 15 0 13 70 2 0 15
                                              0 13 1 2 0 15 0 13 1 2 0 15 0 13
                                              1 1 0 13 0 1 2 0 13 0 15 80 2 0 0
                                              0 0 55 1 0 13 0 1 2 0 13 0 15 77
                                              5 0 0 0 15 8 14 14 72 5 0 0 0 15
                                              8 14 14 69 2 0 27 0 0 1 1 0 83 0
                                              1 2 0 83 0 13 84 1 0 83 0 1 2 0
                                              85 0 13 87 1 0 41 0 1 1 0 91 0 1
                                              2 0 0 8 41 52 3 0 27 0 13 13 1 1
                                              0 27 0 1 2 0 27 0 13 1 0 0 27 1 3
                                              0 27 0 13 13 1 1 0 27 0 1 0 0 0
                                              47 1 0 91 0 1 2 0 13 0 13 1 2 0
                                              97 97 0 1 1 0 96 0 1 1 0 18 0 44
                                              2 0 13 0 6 1 1 0 23 0 46 3 0 13 0
                                              13 13 1 1 0 0 35 36 2 0 0 18 23
                                              24 1 0 0 8 9 1 0 0 11 12 1 0 0 95
                                              1 1 0 91 0 1 3 0 14 0 13 13 1 3 0
                                              88 41 89 27 1 1 0 13 0 56 3 0 88
                                              41 0 27 1 1 0 13 0 57 3 0 88 41 0
                                              27 1 2 0 0 8 41 49 2 0 0 8 41 50
                                              2 0 13 13 13 34 2 0 13 13 13 33 1
                                              0 13 13 1 2 0 78 0 15 81 1 0 98 0
                                              1 2 0 78 0 15 79 3 0 0 0 0 66 67
                                              2 0 15 0 13 1 2 0 15 0 13 1 2 0
                                              15 0 13 1 2 0 15 0 13 1 3 0 41 0
                                              13 13 1 2 0 13 0 13 82 1 0 92 0 1
                                              2 0 0 0 6 38 2 0 0 0 17 39 4 0 0
                                              0 41 6 6 1 4 0 0 0 41 13 13 42 5
                                              0 0 0 41 13 13 15 1 2 0 0 0 22 1
                                              2 0 27 0 0 1 2 0 0 0 0 54 2 0 63
                                              0 0 65)))))
           '|lookupComplete|)) 
