
(SDEFUN |MFGRPH;multifunctionGraph;L$;1| ((|ob| (|List| S)) ($ ($)))
        (SPROG
         ((|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|)))))))
          (#1=#:G716 NIL) (|x| NIL) (#2=#:G715 NIL))
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
                        (LETT #2# (CONS (VECTOR |x| 0 0 (LIST 1) NIL) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (LIST |objs|))))) 

(PUT '|MFGRPH;multifunctionGraph;L$;2| '|SPADreplace| 'LIST) 

(SDEFUN |MFGRPH;multifunctionGraph;L$;2|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|List| (|NonNegativeInteger|)))
                     (|:| |map| (|List| (|List| (|NonNegativeInteger|)))))))
         ($ ($)))
        (LIST |ob|)) 

(SDEFUN |MFGRPH;multifunctionGraph;LL$;3|
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
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|fo| #1#) (#2=#:G754 NIL) (|f| NIL) (#3=#:G755 NIL) (|fn| NIL)
          (|too| (|NonNegativeInteger|)) (|fromo| (|NonNegativeInteger|))
          (#4=#:G753 NIL) (|a| NIL) (|arrs| (|List| (|NonNegativeInteger|)))
          (#5=#:G752 NIL) (|x| NIL) (#6=#:G751 NIL))
         (SEQ
          (LETT |arrs|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |x| 1) (LETT #5# (LENGTH |ob|)) G190
                      (COND ((|greater_SI| |x| #5#) (GO G191)))
                      (SEQ (EXIT (LETT #6# (CONS |x| #6#))))
                      (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (SEQ (LETT |a| NIL) (LETT #4# |ar|) G190
               (COND
                ((OR (ATOM #4#) (PROGN (LETT |a| (CAR #4#)) NIL)) (GO G191)))
               (SEQ (LETT |fromo| (QVELT |a| 2)) (LETT |too| (QVELT |a| 3))
                    (EXIT (SPADCALL |arrs| |fromo| |too| (QREFELT $ 16))))
               (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
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
                              (LIST (SPADCALL |arrs| |fn| (QREFELT $ 17)))
                              NIL))
                (EXIT (LETT |fobs| (SPADCALL |fobs| |fo| (QREFELT $ 18)))))
               (LETT #2# (PROG1 (CDR #2#) (LETT |fn| (|inc_SI| |fn|))))
               (GO G190) G191 (EXIT NIL))
          (EXIT (LIST |fobs|))))) 

(SDEFUN |MFGRPH;multifunctionGraph;LL$;4|
        ((|objs| (|List| S)) (|am| (|List| (|List| (|NonNegativeInteger|))))
         ($ ($)))
        (SPROG
         ((|fobs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|fo| #1#) (#2=#:G769 NIL) (|f| NIL) (#3=#:G770 NIL) (|fn| NIL)
          (|obs|
           (|List|
            #4=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #4#) (|ob| (S)) (#5=#:G768 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #5# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #5#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 24)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 25))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 27)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (LETT |fobs| NIL)
              (SEQ (LETT |fn| 1) (LETT #3# (LENGTH |obs|)) (LETT |f| NIL)
                   (LETT #2# |obs|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL)
                         (|greater_SI| |fn| #3#))
                     (GO G191)))
                   (SEQ
                    (LETT |fo|
                          (VECTOR (QVELT |f| 0) (QVELT |f| 1) (QVELT |f| 2)
                                  (SPADCALL |am| |fn| (QREFELT $ 29)) NIL))
                    (EXIT (LETT |fobs| (SPADCALL |fobs| |fo| (QREFELT $ 18)))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |fn| (|inc_SI| |fn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |fobs|))))) 

(SDEFUN |MFGRPH;multifunctionGraph;L$;5|
        ((|perms| (|List| (|Permutation| S))) ($ ($)))
        (SPROG
         ((|verts|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|o| #1#) (#2=#:G929 NIL) (|vert| NIL) (#3=#:G930 NIL) (|i| NIL)
          (#4=#:G908 NIL) (#5=#:G907 NIL) (|pout| #6=(|Integer|)) (|pin| #6#)
          (#7=#:G928 NIL) (|pt| NIL) (|preim| #8=(|List| S))
          (|im| #9=(|List| S))
          (|lr| (|Record| (|:| |preimage| #8#) (|:| |image| #9#)))
          (#10=#:G926 NIL) (|perm| NIL) (#11=#:G927 NIL) (|pi| NIL)
          (|tab| (|List| (|List| (|NonNegativeInteger|)))) (#12=#:G925 NIL)
          (|a| NIL) (#13=#:G924 NIL) (#14=#:G923 NIL) (|b| NIL)
          (#15=#:G922 NIL) (|obs| (|List| S)) (#16=#:G921 NIL) (|v| NIL)
          (#17=#:G919 NIL) (#18=#:G920 NIL) (|px| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |px| 1) (LETT #18# (LENGTH |perms|)) (LETT |perm| NIL)
                   (LETT #17# |perms|) G190
                   (COND
                    ((OR (ATOM #17#) (PROGN (LETT |perm| (CAR #17#)) NIL)
                         (|greater_SI| |px| #18#))
                     (GO G191)))
                   (SEQ (LETT |lr| (SPADCALL |perm| (QREFELT $ 33)))
                        (LETT |im| (QCDR |lr|)) (LETT |preim| (QCAR |lr|))
                        (EXIT
                         (COND ((EQL |px| 1) (LETT |obs| |im|))
                               ('T
                                (SEQ (LETT |v| NIL) (LETT #16# |im|) G190
                                     (COND
                                      ((OR (ATOM #16#)
                                           (PROGN (LETT |v| (CAR #16#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((< (SPADCALL |v| |obs| (QREFELT $ 35))
                                            1)
                                         (LETT |obs|
                                               (SPADCALL |obs| |v|
                                                         (QREFELT $ 36)))))))
                                     (LETT #16# (CDR #16#)) (GO G190) G191
                                     (EXIT NIL))))))
                   (LETT #17# (PROG1 (CDR #17#) (LETT |px| (|inc_SI| |px|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |tab|
                    (PROGN
                     (LETT #15# NIL)
                     (SEQ (LETT |b| 1) (LETT #14# (LENGTH |obs|)) G190
                          (COND ((|greater_SI| |b| #14#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #15#
                                  (CONS
                                   (PROGN
                                    (LETT #13# NIL)
                                    (SEQ (LETT |a| 1)
                                         (LETT #12# (LENGTH |perms|)) G190
                                         (COND
                                          ((|greater_SI| |a| #12#) (GO G191)))
                                         (SEQ
                                          (EXIT (LETT #13# (CONS |b| #13#))))
                                         (LETT |a| (|inc_SI| |a|)) (GO G190)
                                         G191 (EXIT (NREVERSE #13#))))
                                   #15#))))
                          (LETT |b| (|inc_SI| |b|)) (GO G190) G191
                          (EXIT (NREVERSE #15#)))))
              (SEQ (LETT |pi| 1) (LETT #11# (LENGTH |perms|)) (LETT |perm| NIL)
                   (LETT #10# |perms|) G190
                   (COND
                    ((OR (ATOM #10#) (PROGN (LETT |perm| (CAR #10#)) NIL)
                         (|greater_SI| |pi| #11#))
                     (GO G191)))
                   (SEQ (LETT |lr| (SPADCALL |perm| (QREFELT $ 33)))
                        (LETT |im| (QCDR |lr|)) (LETT |preim| (QCAR |lr|))
                        (EXIT
                         (SEQ (LETT |pt| 1) (LETT #7# (LENGTH |im|)) G190
                              (COND ((|greater_SI| |pt| #7#) (GO G191)))
                              (SEQ
                               (LETT |pin|
                                     (SPADCALL
                                      (SPADCALL |im| |pt| (QREFELT $ 24)) |obs|
                                      (QREFELT $ 35)))
                               (LETT |pout|
                                     (SPADCALL
                                      (SPADCALL |preim| |pt| (QREFELT $ 24))
                                      |obs| (QREFELT $ 35)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL |tab|
                                           (PROG1 (LETT #5# |pin|)
                                             (|check_subtype2| (>= #5# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #5#))
                                           (QREFELT $ 29))
                                 |pi|
                                 (PROG1 (LETT #4# |pout|)
                                   (|check_subtype2| (>= #4# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #4#))
                                 (QREFELT $ 16))))
                              (LETT |pt| (|inc_SI| |pt|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT #10# (PROG1 (CDR #10#) (LETT |pi| (|inc_SI| |pi|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |verts| NIL)
              (SEQ (LETT |i| 1) (LETT #3# (LENGTH |obs|)) (LETT |vert| NIL)
                   (LETT #2# |obs|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |vert| (CAR #2#)) NIL)
                         (|greater_SI| |i| #3#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |vert|
                                  (SPADCALL (LENGTH |obs|) |i| (QREFELT $ 25))
                                  (SPADCALL (LENGTH |obs|) |i| (QREFELT $ 26))
                                  (SPADCALL |tab| |i| (QREFELT $ 29)) NIL))
                    (EXIT
                     (LETT |verts| (SPADCALL |verts| |o| (QREFELT $ 18)))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |verts|))))) 

(SDEFUN |MFGRPH;addObject!;$S$;6| ((|s| ($)) (|n| (S)) ($ ($)))
        (SPROG
         ((|obj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|List| (|NonNegativeInteger|)))
                     (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))
          (|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))))
         (SEQ (LETT |obs| (QCAR |s|))
              (LETT |obj| (VECTOR |n| 0 0 (LIST (LENGTH |obs|)) NIL))
              (COND
               ((SPADCALL |obs| NIL (QREFELT $ 40))
                (PROGN (RPLACA |s| (LIST |obj|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |obj| (QREFELT $ 18)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |MFGRPH;addObject!;$R$;7|
        ((|s| ($))
         (|n|
          (|Record| (|:| |value| S) (|:| |posX| #1=(|NonNegativeInteger|))
                    (|:| |posY| #1#)))
         ($ ($)))
        (SEQ
         (|error|
          "this form of addObject! not supported in multifunctionGraph")
         (EXIT (LIST NIL)))) 

(SDEFUN |MFGRPH;addArrow!;$S2Nni$;8|
        ((|s| ($)) (|nm| (|String|)) (|n1| #1=(|NonNegativeInteger|))
         (|n2| #1#) ($ ($)))
        (SEQ
         (SPADCALL (QVELT (SPADCALL (QCAR |s|) |n1| (QREFELT $ 43)) 3) 1 |n2|
                   (QREFELT $ 16))
         (EXIT |s|))) 

(SDEFUN |MFGRPH;getVertices;$L;9|
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
          (|o| #1#) (#2=#:G952 NIL) (|soj| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |soj| NIL) (LETT #2# (QCAR |s|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |soj| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR (QVELT |soj| 0) (QVELT |soj| 1)
                                  (QVELT |soj| 2)))
                    (EXIT (LETT |res| (SPADCALL |res| |o| (QREFELT $ 27)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |MFGRPH;getArrows;$L;10|
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
          (|a| #1#) (#2=#:G967 NIL) (|ar| NIL) (#3=#:G968 NIL) (|ai| NIL)
          (|soj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|List| (|NonNegativeInteger|)))
                     (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))
          (#4=#:G966 NIL) (|sojn| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |sojn| 1) (LETT #4# (LENGTH (QCAR |s|))) G190
                   (COND ((|greater_SI| |sojn| #4#) (GO G191)))
                   (SEQ
                    (LETT |soj| (SPADCALL (QCAR |s|) |sojn| (QREFELT $ 43)))
                    (EXIT
                     (SEQ (LETT |ai| 1)
                          (LETT #3# (SPADCALL (QVELT |soj| 3) (QREFELT $ 47)))
                          (LETT |ar| NIL) (LETT #2# (QVELT |soj| 3)) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |ar| (CAR #2#)) NIL)
                                (|greater_SI| |ai| #3#))
                            (GO G191)))
                          (SEQ
                           (LETT |a|
                                 (VECTOR
                                  (STRCONC (STRINGIMAGE |sojn|)
                                           (STRINGIMAGE |ai|))
                                  0 |sojn| |ar| 0 0 NIL))
                           (EXIT
                            (LETT |res| (SPADCALL |res| |a| (QREFELT $ 48)))))
                          (LETT #2#
                                (PROG1 (CDR #2#) (LETT |ai| (|inc_SI| |ai|))))
                          (GO G190) G191 (EXIT NIL))))
                   (LETT |sojn| (|inc_SI| |sojn|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(PUT '|MFGRPH;initial;$;11| '|SPADreplace| '(XLAM NIL (LIST NIL))) 

(SDEFUN |MFGRPH;initial;$;11| (($ ($))) (LIST NIL)) 

(SDEFUN |MFGRPH;terminal;S$;12| ((|a| (S)) ($ ($)))
        (SPROG
         ((|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|List| (|NonNegativeInteger|)))
                     (|:| |map| (|List| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |o| (VECTOR |a| 0 0 (LIST 1) NIL))
              (EXIT (LIST (LIST |o|)))))) 

(SDEFUN |MFGRPH;cycleOpen;LS$;13|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|o| #1#) (|n| (|NonNegativeInteger|)) (|ob| (S)) (#2=#:G982 NIL)
          (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #2# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #2#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 24)))
                        (LETT |n| (+ |obn| 1))
                        (COND
                         ((EQL |obn| (LENGTH |objs|))
                          (LETT |n| (LENGTH |objs|))))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 25))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (LIST |n|) NIL))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 18)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |obs|))))) 

(SDEFUN |MFGRPH;cycleClosed;LS$;14|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|o| #1#) (|n| (|NonNegativeInteger|)) (|ob| (S)) (#2=#:G991 NIL)
          (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #2# (LENGTH |objs|)) G190
                   (COND ((|greater_SI| |obn| #2#) (GO G191)))
                   (SEQ (LETT |ob| (SPADCALL |objs| |obn| (QREFELT $ 24)))
                        (LETT |n| (+ |obn| 1))
                        (COND ((EQL |obn| (LENGTH |objs|)) (LETT |n| 1)))
                        (LETT |o|
                              (VECTOR |ob|
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 25))
                                      (SPADCALL (LENGTH |objs|) |obn|
                                                (QREFELT $ 26))
                                      (LIST |n|) NIL))
                        (EXIT
                         (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 18)))))
                   (LETT |obn| (|inc_SI| |obn|)) (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |obs|))))) 

(SDEFUN |MFGRPH;unit;LS$;15|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SPROG ((#1=#:G998 NIL) (|x| NIL) (#2=#:G997 NIL))
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
                                      (SPADCALL |objs| |x| (QREFELT $ 24)) 0 0
                                      (LIST |x|) NIL)
                                     #2#))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))
                (EXIT (LIST |objs|))))) 

(SDEFUN |MFGRPH;kgraph;LS$;16|
        ((|objs| (|List| S)) (|arrowName| (|String|)) ($ ($)))
        (SEQ (|error| "kgraph not valid in function graph") (EXIT (LIST NIL)))) 

(SDEFUN |MFGRPH;+;3$;17| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|c|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|)))))))
          (#1=#:G1011 NIL) (|x| NIL) (#2=#:G1010 NIL)
          (|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))))
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
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 43))
                                           0)
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 43))
                                           1)
                                    (QVELT (SPADCALL |objs| |x| (QREFELT $ 43))
                                           2)
                                    (LIST (+ |x| (LENGTH (QCAR |a|)))) NIL)
                                   #2#))))
                          (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (LIST (SPADCALL (QCAR |a|) |c| (QREFELT $ 56))))))) 

(SDEFUN |MFGRPH;merge;3$;18| ((|a| ($)) (|b| ($)) ($ ($)))
        (SEQ (|error| "merge not valid in function graph") (EXIT (LIST NIL)))) 

(SDEFUN |MFGRPH;indexProd|
        ((|aObj| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G1015 NIL))
               (+ |a|
                  (*
                   (PROG1 (LETT #1# (- |b| 1))
                     (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #1#))
                   (LENGTH (QCAR |aObj|)))))) 

(SDEFUN |MFGRPH;tensorNext|
        ((|aObj| ($)) (|a| (|List| (|NonNegativeInteger|)))
         (|b| (|List| (|NonNegativeInteger|)))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|))) (|x| (|NonNegativeInteger|))
          (#1=#:G1029 NIL) (|j| NIL) (#2=#:G1028 NIL) (|i| NIL))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |a| (QREFELT $ 47))
                      (SPADCALL |b| (QREFELT $ 47)) (QREFELT $ 59))
            (|error|
             (SPADCALL
              (LIST "tensor product with different degree a="
                    (|mathObject2String| |a|) " b=" (|mathObject2String| |b|))
              (QREFELT $ 61)))))
          (LETT |res| NIL)
          (SEQ (LETT |i| 1) (LETT #2# (SPADCALL |a| (QREFELT $ 47))) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #1# (SPADCALL |b| (QREFELT $ 47)))
                      G190 (COND ((|greater_SI| |j| #1#) (GO G191)))
                      (SEQ
                       (LETT |x|
                             (|MFGRPH;indexProd| |aObj|
                              (SPADCALL |a| |i| (QREFELT $ 17))
                              (SPADCALL |b| |j| (QREFELT $ 17)) $))
                       (EXIT (LETT |res| (SPADCALL |res| |x| (QREFELT $ 62)))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |MFGRPH;cartesianNext|
        ((|aObj| ($)) (|a| (|List| (|NonNegativeInteger|)))
         (|b| (|List| (|NonNegativeInteger|))) (|an| (|NonNegativeInteger|))
         (|bn| (|NonNegativeInteger|)) ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|)))
          (|y| #1=(|NonNegativeInteger|)) (|x| #1#) (#2=#:G1037 NIL) (|i| NIL))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |a| (QREFELT $ 47))
                      (SPADCALL |b| (QREFELT $ 47)) (QREFELT $ 59))
            (|error|
             (SPADCALL
              (LIST "Cartesian product with different degree a="
                    (|mathObject2String| |a|) " b=" (|mathObject2String| |b|))
              (QREFELT $ 61)))))
          (LETT |res| NIL)
          (SEQ (LETT |i| 1) (LETT #2# (SPADCALL |a| (QREFELT $ 47))) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (LETT |x|
                      (|MFGRPH;indexProd| |aObj|
                       (SPADCALL |a| |i| (QREFELT $ 17)) |bn| $))
                (LETT |res| (SPADCALL |res| |x| (QREFELT $ 62)))
                (LETT |y|
                      (|MFGRPH;indexProd| |aObj| |an|
                       (SPADCALL |b| |i| (QREFELT $ 17)) $))
                (EXIT (LETT |res| (SPADCALL |res| |y| (QREFELT $ 62)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |MFGRPH;*;2$Mg;22|
        ((|a| ($)) (|b| ($)) ($ (|MultifunctionGraph| (|Product| S S))))
        (SPROG
         ((|newObjs|
           (|List|
            #1=(|Record| (|:| |value| (|Product| S S))
                         (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|ob| #1#) (|sp| (|Product| S S))
          (|nextA| (|List| (|NonNegativeInteger|)))
          (|y| #2=(|NonNegativeInteger|)) (|x| #2#)
          (|bni| #3=(|List| (|NonNegativeInteger|)))
          (|byi| #4=(|NonNegativeInteger|)) (|bxi| #5=(|NonNegativeInteger|))
          (|bi| (S)) (#6=#:G1053 NIL) (|boi| NIL) (|ani| #3#) (|ayi| #4#)
          (|axi| #5#) (|ai| (S)) (#7=#:G1052 NIL) (|aoi| NIL))
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
                                             (SPADCALL |a| (QREFELT $ 63)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 64)))
                                          |ayi|))
                                   (LETT |nextA|
                                         (|MFGRPH;tensorNext| |b| |bni| |ani|
                                          $))
                                   (LETT |sp|
                                         (SPADCALL |ai| |bi| (QREFELT $ 66)))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y| |nextA| NIL))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 69)))))
                              (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |newObjs| (QREFELT $ 71)))))) 

(SDEFUN |MFGRPH;cartesian;2$Mg;23|
        ((|a| ($)) (|b| ($)) ($ (|MultifunctionGraph| (|Product| S S))))
        (SPROG
         ((|newObjs|
           (|List|
            #1=(|Record| (|:| |value| (|Product| S S))
                         (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|ob| #1#) (|sp| (|Product| S S))
          (|nextA| (|List| (|NonNegativeInteger|)))
          (|y| #2=(|NonNegativeInteger|)) (|x| #2#)
          (|bni| #3=(|List| (|NonNegativeInteger|)))
          (|byi| #4=(|NonNegativeInteger|)) (|bxi| #5=(|NonNegativeInteger|))
          (|bi| (S)) (#6=#:G1068 NIL) (|bptr| NIL) (#7=#:G1069 NIL) (|boi| NIL)
          (|ani| #3#) (|ayi| #4#) (|axi| #5#) (|ai| (S)) (#8=#:G1066 NIL)
          (|aptr| NIL) (#9=#:G1067 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #9# (QCAR |a|)) (LETT |aptr| 1)
                   (LETT #8# (LENGTH (QCAR |a|))) G190
                   (COND
                    ((OR (|greater_SI| |aptr| #8#) (ATOM #9#)
                         (PROGN (LETT |aoi| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ai| (QVELT |aoi| 0))
                        (LETT |axi| (QVELT |aoi| 1))
                        (LETT |ayi| (QVELT |aoi| 2))
                        (LETT |ani| (QVELT |aoi| 3))
                        (EXIT
                         (SEQ (LETT |boi| NIL) (LETT #7# (QCAR |b|))
                              (LETT |bptr| 1) (LETT #6# (LENGTH (QCAR |a|)))
                              G190
                              (COND
                               ((OR (|greater_SI| |bptr| #6#) (ATOM #7#)
                                    (PROGN (LETT |boi| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |bi| (QVELT |boi| 0))
                                   (LETT |bxi| (QVELT |boi| 1))
                                   (LETT |byi| (QVELT |boi| 2))
                                   (LETT |bni| (QVELT |boi| 3))
                                   (LETT |x|
                                         (+
                                          (* |bxi|
                                             (SPADCALL |a| (QREFELT $ 63)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 64)))
                                          |ayi|))
                                   (LETT |nextA|
                                         (|MFGRPH;cartesianNext| |b| |bni|
                                          |ani| |bptr| |aptr| $))
                                   (LETT |sp|
                                         (SPADCALL |ai| |bi| (QREFELT $ 66)))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y| |nextA| NIL))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 69)))))
                              (LETT |bptr|
                                    (PROG1 (|inc_SI| |bptr|)
                                      (LETT #7# (CDR #7#))))
                              (GO G190) G191 (EXIT NIL))))
                   (LETT |aptr| (PROG1 (|inc_SI| |aptr|) (LETT #9# (CDR #9#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |newObjs| (QREFELT $ 71)))))) 

(SDEFUN |MFGRPH;closedTensor;2$M$;24|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newObjs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| #2=(|NonNegativeInteger|))
                         (|:| |posY| #3=(|NonNegativeInteger|))
                         (|:| |next| #4=(|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|ob| #1#) (|sp| (S)) (|nextA| (|List| (|NonNegativeInteger|)))
          (|y| #5=(|NonNegativeInteger|)) (|x| #5#) (|bni| #4#) (|byi| #3#)
          (|bxi| #2#) (|bi| (S)) (#6=#:G1081 NIL) (|boi| NIL) (|ani| #4#)
          (|ayi| #3#) (|axi| #2#) (|ai| (S)) (#7=#:G1080 NIL) (|aoi| NIL))
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
                                             (SPADCALL |a| (QREFELT $ 63)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 64)))
                                          |ayi|))
                                   (LETT |nextA|
                                         (|MFGRPH;tensorNext| |b| |bni| |ani|
                                          $))
                                   (LETT |sp| (SPADCALL |ai| |bi| |f|))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y| |nextA| NIL))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 18)))))
                              (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |newObjs| (QREFELT $ 12)))))) 

(SDEFUN |MFGRPH;closedCartesian;2$M$;25|
        ((|a| ($)) (|b| ($)) (|f| (|Mapping| S S S)) ($ ($)))
        (SPROG
         ((|newObjs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| #2=(|NonNegativeInteger|))
                         (|:| |posY| #3=(|NonNegativeInteger|))
                         (|:| |next| #4=(|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|ob| #1#) (|sp| (S)) (|nextA| (|List| (|NonNegativeInteger|)))
          (|y| #5=(|NonNegativeInteger|)) (|x| #5#) (|bni| #4#) (|byi| #3#)
          (|bxi| #2#) (|bi| (S)) (#6=#:G1095 NIL) (|bptr| NIL) (#7=#:G1096 NIL)
          (|boi| NIL) (|ani| #4#) (|ayi| #3#) (|axi| #2#) (|ai| (S))
          (#8=#:G1093 NIL) (|aptr| NIL) (#9=#:G1094 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #9# (QCAR |a|)) (LETT |aptr| 1)
                   (LETT #8# (LENGTH (QCAR |a|))) G190
                   (COND
                    ((OR (|greater_SI| |aptr| #8#) (ATOM #9#)
                         (PROGN (LETT |aoi| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ai| (QVELT |aoi| 0))
                        (LETT |axi| (QVELT |aoi| 1))
                        (LETT |ayi| (QVELT |aoi| 2))
                        (LETT |ani| (QVELT |aoi| 3))
                        (EXIT
                         (SEQ (LETT |boi| NIL) (LETT #7# (QCAR |b|))
                              (LETT |bptr| 1) (LETT #6# (LENGTH (QCAR |a|)))
                              G190
                              (COND
                               ((OR (|greater_SI| |bptr| #6#) (ATOM #7#)
                                    (PROGN (LETT |boi| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |bi| (QVELT |boi| 0))
                                   (LETT |bxi| (QVELT |boi| 1))
                                   (LETT |byi| (QVELT |boi| 2))
                                   (LETT |bni| (QVELT |boi| 3))
                                   (LETT |x|
                                         (+
                                          (* |bxi|
                                             (SPADCALL |a| (QREFELT $ 63)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 64)))
                                          |ayi|))
                                   (LETT |nextA|
                                         (|MFGRPH;cartesianNext| |b| |bni|
                                          |ani| |bptr| |aptr| $))
                                   (LETT |sp| (SPADCALL |ai| |bi| |f|))
                                   (LETT |ob|
                                         (VECTOR |sp| |x| |y| |nextA| NIL))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 18)))))
                              (LETT |bptr|
                                    (PROG1 (|inc_SI| |bptr|)
                                      (LETT #7# (CDR #7#))))
                              (GO G190) G191 (EXIT NIL))))
                   (LETT |aptr| (PROG1 (|inc_SI| |aptr|) (LETT #9# (CDR #9#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |newObjs| (QREFELT $ 12)))))) 

(SDEFUN |MFGRPH;~;2$;26| ((|s| ($)) ($ ($)))
        (SPROG
         ((|newObjs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|))
                         (|:| |next| (|List| (|NonNegativeInteger|)))
                         (|:| |map|
                              (|List| (|List| (|NonNegativeInteger|)))))))
          (|ob| #1#) (|nextA| (|List| (|NonNegativeInteger|))) (#2=#:G1109 NIL)
          (|x| NIL) (#3=#:G1108 NIL) (|aoi| NIL))
         (SEQ (LETT |newObjs| NIL)
              (SEQ (LETT |aoi| NIL) (LETT #3# (QCAR |s|)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |aoi| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |nextA| NIL)
                        (SEQ (LETT |x| 1) (LETT #2# (LENGTH (QCAR |s|))) G190
                             (COND ((|greater_SI| |x| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((EQL
                                  (SPADCALL |x| (QVELT |aoi| 3) (QREFELT $ 77))
                                  0)
                                 (LETT |nextA|
                                       (SPADCALL |nextA| |x|
                                                 (QREFELT $ 62)))))))
                             (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |ob|
                              (VECTOR (QVELT |aoi| 0) (QVELT |aoi| 1)
                                      (QVELT |aoi| 2) |nextA| NIL))
                        (EXIT
                         (LETT |newObjs|
                               (SPADCALL |newObjs| |ob| (QREFELT $ 18)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT (LIST |newObjs|))))) 

(SDEFUN |MFGRPH;map;$LL2I$;27|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|nv|
           #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                        (|:| |posY| (|NonNegativeInteger|))
                        (|:| |next| (|List| (|NonNegativeInteger|)))
                        (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))
          (|newNext| (|List| (|NonNegativeInteger|))) (#3=#:G1128 NIL)
          (|n| NIL) (|newY| (|NonNegativeInteger|)) (#4=#:G1117 NIL)
          (|newX| (|NonNegativeInteger|)) (#5=#:G1116 NIL) (|newObj| (S))
          (|i| (|NonNegativeInteger|))
          (|oldObj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|List| (|NonNegativeInteger|)))
                     (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))
          (#6=#:G1127 NIL) (|oi| NIL)
          (|oldObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|)))))))
          (|newObjs| (|List| #2#)) (#7=#:G1126 NIL) (|o| NIL) (#8=#:G1125 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |o| NIL) (LETT #7# |newOb|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |o| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #8# (CONS (VECTOR |o| 0 0 NIL NIL) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |oldObjs| (QCAR |s|))
          (SEQ (LETT |oi| 1) (LETT #6# (LENGTH |oldObjs|)) G190
               (COND ((|greater_SI| |oi| #6#) (GO G191)))
               (SEQ (LETT |oldObj| (SPADCALL |oldObjs| |oi| (QREFELT $ 43)))
                    (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 17)))
                    (LETT |newObj| (SPADCALL |newOb| |i| (QREFELT $ 24)))
                    (LETT |newX|
                          (PROG1 (LETT #5# (+ (QVELT |oldObj| 1) |offsetX|))
                            (|check_subtype2| (>= #5# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #5#)))
                    (LETT |newY|
                          (PROG1 (LETT #4# (+ (QVELT |oldObj| 2) |offsetY|))
                            (|check_subtype2| (>= #4# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #4#)))
                    (LETT |newNext| NIL)
                    (SEQ (LETT |n| NIL) (LETT #3# (QVELT |oldObj| 3)) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |n| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |newNext|
                                 (SPADCALL |newNext|
                                           (SPADCALL |m| |n| (QREFELT $ 17))
                                           (QREFELT $ 62)))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                    (LETT |nv| (VECTOR |newObj| |newX| |newY| |newNext| NIL))
                    (EXIT (SPADCALL |newObjs| |i| |nv| (QREFELT $ 79))))
               (LETT |oi| (|inc_SI| |oi|)) (GO G190) G191 (EXIT NIL))
          (EXIT (LIST |newObjs|))))) 

(SDEFUN |MFGRPH;mapContra;$LL2I$;28|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|))) (|newOb| (|List| S))
         (|offsetX| #1=(|Integer|)) (|offsetY| #1#) ($ ($)))
        (SPROG
         ((|nv|
           #2=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                        (|:| |posY| (|NonNegativeInteger|))
                        (|:| |next| (|List| (|NonNegativeInteger|)))
                        (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))
          (|newNext| (|List| (|NonNegativeInteger|)))
          (|incoming| (|List| (|NonNegativeInteger|))) (#3=#:G1148 NIL)
          (|n| NIL) (|newY| (|NonNegativeInteger|)) (#4=#:G1136 NIL)
          (|newX| (|NonNegativeInteger|)) (#5=#:G1135 NIL) (|newObj| (S))
          (|i| (|NonNegativeInteger|))
          (|oldObj|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))
                     (|:| |next| (|List| (|NonNegativeInteger|)))
                     (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))
          (#6=#:G1147 NIL) (|oi| NIL)
          (|oldObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|)))))))
          (|newObjs| (|List| #2#)) (#7=#:G1146 NIL) (|o| NIL) (#8=#:G1145 NIL))
         (SEQ
          (LETT |newObjs|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |o| NIL) (LETT #7# |newOb|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |o| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #8# (CONS (VECTOR |o| 0 0 NIL NIL) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |oldObjs| (QCAR |s|))
          (SEQ (LETT |oi| 1) (LETT #6# (LENGTH |oldObjs|)) G190
               (COND ((|greater_SI| |oi| #6#) (GO G191)))
               (SEQ (LETT |oldObj| (SPADCALL |oldObjs| |oi| (QREFELT $ 43)))
                    (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 17)))
                    (LETT |newObj| (SPADCALL |newOb| |i| (QREFELT $ 24)))
                    (LETT |newX|
                          (PROG1 (LETT #5# (+ (QVELT |oldObj| 1) |offsetX|))
                            (|check_subtype2| (>= #5# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #5#)))
                    (LETT |newY|
                          (PROG1 (LETT #4# (+ (QVELT |oldObj| 2) |offsetY|))
                            (|check_subtype2| (>= #4# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #4#)))
                    (LETT |newNext| NIL)
                    (SEQ (LETT |n| NIL) (LETT #3# (QVELT |oldObj| 3)) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |n| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |incoming|
                                (SPADCALL |s| (SPADCALL |m| |n| (QREFELT $ 17))
                                          (QREFELT $ 81)))
                          (EXIT
                           (LETT |newNext|
                                 (SPADCALL |newNext| |incoming|
                                           (QREFELT $ 82)))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                    (LETT |nv| (VECTOR |newObj| |newX| |newY| |newNext| NIL))
                    (EXIT (SPADCALL |newObjs| |i| |nv| (QREFELT $ 79))))
               (LETT |oi| (|inc_SI| |oi|)) (GO G190) G191 (EXIT NIL))
          (EXIT (LIST |newObjs|))))) 

(SDEFUN |MFGRPH;coAdjoint;$LU;29|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|List| (|NonNegativeInteger|)) "failed")))
        (SPROG
         ((|entry| (|NonNegativeInteger|)) (#1=#:G1169 NIL)
          (|x| (|NonNegativeInteger|)) (#2=#:G1176 NIL) (|ri| NIL)
          (#3=#:G1175 NIL) (|mi| NIL)
          (|retOpt| (|List| (|List| (|NonNegativeInteger|)))) (#4=#:G1174 NIL)
          (#5=#:G1173 NIL) (|ret| (|List| (|NonNegativeInteger|)))
          (#6=#:G1172 NIL) (#7=#:G1171 NIL)
          (|codomainSize| (|NonNegativeInteger|)) (#8=#:G1170 NIL))
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
                (SEQ (LETT |mi| 1) (LETT #3# (SPADCALL |m| (QREFELT $ 47)))
                     G190 (COND ((|greater_SI| |mi| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |retOpt| (SPADCALL |m| |mi| (QREFELT $ 17))
                                 (SPADCALL
                                  (SPADCALL |retOpt|
                                            (SPADCALL |m| |mi| (QREFELT $ 17))
                                            (QREFELT $ 29))
                                  |mi| (QREFELT $ 62))
                                 (QREFELT $ 84))))
                     (LETT |mi| (|inc_SI| |mi|)) (GO G190) G191 (EXIT NIL))
                (LETT |entry| 1)
                (SEQ (LETT |ri| NIL) (LETT #2# |retOpt|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |ri| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |x| (SPADCALL |s| |ri| (QREFELT $ 85)))
                          (COND
                           ((EQL |x| 0)
                            (PROGN
                             (LETT #1# (CONS 1 "failed"))
                             (GO #9=#:G1168))))
                          (SPADCALL |ret| |entry| |x| (QREFELT $ 16))
                          (EXIT (LETT |entry| (+ |entry| 1))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ret|))))
          #9# (EXIT #1#)))) 

(SDEFUN |MFGRPH;contraAdjoint;$LU;30|
        ((|s| ($)) (|m| (|List| (|NonNegativeInteger|)))
         ($ (|Union| (|List| (|NonNegativeInteger|)) "failed")))
        (SPROG
         ((|entry| (|NonNegativeInteger|)) (#1=#:G1194 NIL)
          (|x| (|NonNegativeInteger|)) (#2=#:G1201 NIL) (|ri| NIL)
          (#3=#:G1200 NIL) (|mi| NIL)
          (|retOpt| (|List| (|List| (|NonNegativeInteger|)))) (#4=#:G1199 NIL)
          (#5=#:G1198 NIL) (|ret| (|List| (|NonNegativeInteger|)))
          (#6=#:G1197 NIL) (#7=#:G1196 NIL)
          (|codomainSize| (|NonNegativeInteger|)) (#8=#:G1195 NIL))
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
                (SEQ (LETT |mi| 1) (LETT #3# (SPADCALL |m| (QREFELT $ 47)))
                     G190 (COND ((|greater_SI| |mi| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |retOpt| (SPADCALL |m| |mi| (QREFELT $ 17))
                                 (SPADCALL
                                  (SPADCALL |retOpt|
                                            (SPADCALL |m| |mi| (QREFELT $ 17))
                                            (QREFELT $ 29))
                                  |mi| (QREFELT $ 62))
                                 (QREFELT $ 84))))
                     (LETT |mi| (|inc_SI| |mi|)) (GO G190) G191 (EXIT NIL))
                (LETT |entry| 1)
                (SEQ (LETT |ri| NIL) (LETT #2# |retOpt|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |ri| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |x| (SPADCALL |s| |ri| (QREFELT $ 88)))
                          (COND
                           ((EQL |x| 0)
                            (PROGN
                             (LETT #1# (CONS 1 "failed"))
                             (GO #9=#:G1193))))
                          (SPADCALL |ret| |entry| |x| (QREFELT $ 16))
                          (EXIT (LETT |entry| (+ |entry| 1))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ret|))))
          #9# (EXIT #1#)))) 

(SDEFUN |MFGRPH;apply;$3Nni;31|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPADCALL (QVELT (SPADCALL (QCAR |s|) |a| (QREFELT $ 43)) 3) |m|
                  (QREFELT $ 17))) 

(SDEFUN |MFGRPH;limit;$2NniL;32|
        ((|s| ($)) (|a| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
         ($ (|Loop|)))
        (SPROG
         ((|ptr| (|NonNegativeInteger|)) (#1=#:G1214 NIL)
          (|lp| (|List| (|Loop|))) (#2=#:G1215 NIL) (|s1| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ptr| |a|)
                (SEQ (LETT |s1| NIL) (LETT #2# (QCAR |s|)) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |s1| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |lp| (SPADCALL |s| |ptr| (QREFELT $ 92)))
                          (COND
                           ((> (LENGTH |lp|) 1)
                            (|error| "limit: cant have >1 loop through node")))
                          (COND
                           ((EQL (LENGTH |lp|) 1)
                            (PROGN
                             (LETT #1# (|SPADfirst| |lp|))
                             (GO #3=#:G1213))))
                          (EXIT
                           (LETT |ptr|
                                 (SPADCALL |s| |ptr| |m| (QREFELT $ 90)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL NIL (QREFELT $ 94)))))
          #3# (EXIT #1#)))) 

(SDEFUN |MFGRPH;coerce;Pg$;33| ((|pg| (|PermutationGroup| S)) ($ ($)))
        (SPADCALL (SPADCALL |pg| (QREFELT $ 97)) (QREFELT $ 38))) 

(SDEFUN |MFGRPH;permIndex|
        ((|entry| (|Permutation| S)) (|lps2| (|List| (|Permutation| S)))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((|resu| (|NonNegativeInteger|)) (|e2| (|Permutation| S))
          (#1=#:G1222 NIL) (|i| NIL) (|dimen| (|NonNegativeInteger|)))
         (SEQ (LETT |dimen| (LENGTH |lps2|)) (LETT |resu| 0)
              (SEQ (LETT |i| 1) (LETT #1# |dimen|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ (LETT |e2| (SPADCALL |lps2| |i| (QREFELT $ 99)))
                        (EXIT
                         (COND
                          ((SPADCALL |entry| |e2| (QREFELT $ 100))
                           (LETT |resu| |i|)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |resu|)))) 

(SDEFUN |MFGRPH;generateNewPerms|
        ((|gens2| (|List| (|Permutation| S))) (|stngs| (|List| (|String|)))
         (|permutationNames| (|Boolean|))
         ($
          (|Record| (|:| |prm| (|List| (|Permutation| S)))
                    (|:| |nam| (|List| (|String|))))))
        (SPROG
         ((|resstr| (|List| (|String|))) (|resu| (|List| (|Permutation| S)))
          (|foundNew| (|Boolean|)) (|p| (|Permutation| S)) (#1=#:G1235 NIL)
          (|j| NIL) (#2=#:G1234 NIL) (|i| NIL)
          (|dimen| (|NonNegativeInteger|)))
         (SEQ (LETT |dimen| (LENGTH |gens2|)) (LETT |resu| NIL)
              (LETT |resstr| NIL)
              (SEQ (LETT |i| 1) (LETT #2# |dimen|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |dimen|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (LETT |p|
                                 (SPADCALL
                                  (SPADCALL |gens2| |i| (QREFELT $ 99))
                                  (SPADCALL |gens2| |j| (QREFELT $ 99))
                                  (QREFELT $ 101)))
                           (LETT |foundNew|
                                 (COND
                                  ((SPADCALL |p| |gens2| (QREFELT $ 102)) NIL)
                                  ('T
                                   (NULL
                                    (SPADCALL |p| |resu| (QREFELT $ 102))))))
                           (EXIT
                            (COND
                             (|foundNew|
                              (SEQ
                               (LETT |resu|
                                     (SPADCALL |resu| |p| (QREFELT $ 103)))
                               (EXIT
                                (COND
                                 (|permutationNames|
                                  (LETT |resstr|
                                        (SPADCALL |resstr|
                                                  (|mathObject2String| |p|)
                                                  (QREFELT $ 105))))
                                 ('T
                                  (LETT |resstr|
                                        (SPADCALL |resstr|
                                                  (STRCONC
                                                   (SPADCALL |stngs| |i|
                                                             (QREFELT $ 106))
                                                   (SPADCALL |stngs| |j|
                                                             (QREFELT $ 106)))
                                                  (QREFELT $ 105)))))))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |resu| |resstr|))))) 

(SDEFUN |MFGRPH;generateName| ((|n| (|NonNegativeInteger|)) ($ (|String|)))
        (SPROG ((|ascii| (|NonNegativeInteger|)))
               (SEQ (LETT |ascii| 96) (COND ((> |n| 8) (LETT |ascii| 97)))
                    (EXIT
                     (SPADCALL (SPADCALL (+ |ascii| |n|) (QREFELT $ 108))
                               (QREFELT $ 109)))))) 

(SDEFUN |MFGRPH;generateNames|
        ((|n| (|NonNegativeInteger|)) ($ (|List| (|String|))))
        (SPROG ((#1=#:G1243 NIL) (|ptr2| NIL) (#2=#:G1242 NIL))
               (SEQ
                (COND ((EQL |n| 0) (LIST "0"))
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |ptr2| 1) (LETT #1# |n|) G190
                             (COND ((|greater_SI| |ptr2| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS (|MFGRPH;generateName| |ptr2| $)
                                           #2#))))
                             (LETT |ptr2| (|inc_SI| |ptr2|)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |MFGRPH;generateNamesCycle|
        ((|g| (|List| (|Permutation| S))) ($ (|List| (|String|))))
        (SPROG
         ((|s2| (|List| (|String|))) (#1=#:G1249 NIL) (|ptr2| NIL)
          (#2=#:G1248 NIL) (|s1| (|String|)))
         (SEQ (LETT |s1| (|mathObject2String| (|spadConstant| $ 34)))
              (LETT |s2|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |ptr2| NIL) (LETT #1# |g|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |ptr2| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (|mathObject2String| |ptr2|) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (CONS |s1| |s2|))))) 

(SDEFUN |MFGRPH;toCayleyGraph;LBMg;39|
        ((|permList| (|List| (|Permutation| S)))
         (|permutationNames| (|Boolean|))
         ($ (|MultifunctionGraph| (|String|))))
        (SPROG
         ((|gens| (|List| (|List| (|NonNegativeInteger|)))) (#1=#:G1273 NIL)
          (|i| NIL) (#2=#:G1272 NIL)
          (|ct| (|List| (|List| (|NonNegativeInteger|)))) (#3=#:G1271 NIL)
          (|j| NIL) (#4=#:G1270 NIL) (#5=#:G1269 NIL) (#6=#:G1268 NIL)
          (|dimen| #7=(|NonNegativeInteger|)) (|strngs| (|List| (|String|)))
          (|elements| (|List| (|Permutation| S))) (|idPerm| (|Permutation| S))
          (|idPos| (|Integer|)) (|contin| (|Boolean|))
          (|resu|
           (|Record| (|:| |prm| (|List| (|Permutation| S)))
                     (|:| |nam| (|List| (|String|)))))
          (|numGenerators| #7#))
         (SEQ (LETT |elements| |permList|)
              (LETT |numGenerators| (LENGTH |permList|))
              (LETT |strngs| (|MFGRPH;generateNames| (LENGTH |elements|) $))
              (COND
               (|permutationNames|
                (LETT |strngs| (|MFGRPH;generateNamesCycle| |permList| $))))
              (LETT |contin| 'T)
              (SEQ G190 (COND ((NULL |contin|) (GO G191)))
                   (SEQ
                    (LETT |resu|
                          (|MFGRPH;generateNewPerms| |elements| |strngs|
                           |permutationNames| $))
                    (LETT |contin| (NULL (NULL (QCAR |resu|))))
                    (EXIT
                     (COND
                      (|contin|
                       (SEQ
                        (LETT |elements|
                              (SPADCALL |elements| (QCAR |resu|)
                                        (QREFELT $ 110)))
                        (EXIT
                         (LETT |strngs|
                               (SPADCALL |strngs| (QCDR |resu|)
                                         (QREFELT $ 111)))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |idPos| (SPADCALL (ELT $ 113) |elements| (QREFELT $ 115)))
              (COND
               ((> |idPos| 1)
                (SEQ
                 (LETT |idPerm| (SPADCALL |elements| |idPos| (QREFELT $ 99)))
                 (LETT |elements|
                       (CONS |idPerm|
                             (SPADCALL |elements| |idPos| (QREFELT $ 116))))
                 (EXIT
                  (LETT |strngs|
                        (CONS "i"
                              (SPADCALL |strngs| |idPos| (QREFELT $ 117))))))))
              (LETT |dimen| (LENGTH |elements|))
              (LETT |ct|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |i| 1) (LETT #5# |dimen|) G190
                          (COND ((|greater_SI| |i| #5#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6#
                                  (CONS
                                   (PROGN
                                    (LETT #4# NIL)
                                    (SEQ (LETT |j| 1) (LETT #3# |dimen|) G190
                                         (COND
                                          ((|greater_SI| |j| #3#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #4#
                                                 (CONS
                                                  (|MFGRPH;permIndex|
                                                   (SPADCALL
                                                    (SPADCALL |elements| |i|
                                                              (QREFELT $ 99))
                                                    (SPADCALL |elements| |j|
                                                              (QREFELT $ 99))
                                                    (QREFELT $ 101))
                                                   |elements| $)
                                                  #4#))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT (NREVERSE #4#))))
                                   #6#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (LETT |gens|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 1) (LETT #1# |dimen|) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL
                                    (CDR (SPADCALL |ct| |i| (QREFELT $ 29)))
                                    |numGenerators| (QREFELT $ 118))
                                   #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (SPADCALL |strngs| |gens| (QREFELT $ 120)))))) 

(SDEFUN |MFGRPH;toCayleyGraph;PgMg;40|
        ((|pg| (|PermutationGroup| S)) ($ (|MultifunctionGraph| (|String|))))
        (SPROG ((|perms| (|List| (|Permutation| S))))
               (SEQ (LETT |perms| (SPADCALL |pg| (QREFELT $ 122)))
                    (EXIT (SPADCALL |perms| NIL (QREFELT $ 121)))))) 

(SDEFUN |MFGRPH;toPermutation;$Pg;41|
        ((|s| ($)) ($ (|PermutationGroup| (|NonNegativeInteger|))))
        (SPROG
         ((|lp| (|List| (|Permutation| (|NonNegativeInteger|))))
          (|p| (|Permutation| (|NonNegativeInteger|)))
          (|imgs| (|List| (|NonNegativeInteger|))) (#1=#:G1301 NIL) (|i| NIL)
          (|preImgs| (|List| (|NonNegativeInteger|))) (#2=#:G1300 NIL)
          (#3=#:G1299 NIL)
          (|cayleyTable| (|List| (|List| (|NonNegativeInteger|))))
          (#4=#:G1298 NIL) (|j| NIL) (#5=#:G1297 NIL) (#6=#:G1296 NIL)
          (#7=#:G1295 NIL) (|numCols| (|NonNegativeInteger|))
          (|numRows| (|NonNegativeInteger|))
          (|preTable| (|List| (|List| (|NonNegativeInteger|))))
          (|newNext| (|List| (|NonNegativeInteger|))) (#8=#:G1293 NIL)
          (|obj| NIL) (#9=#:G1294 NIL) (|oi| NIL)
          (|objs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))
                      (|:| |next| (|List| (|NonNegativeInteger|)))
                      (|:| |map| (|List| (|List| (|NonNegativeInteger|))))))))
         (SEQ (LETT |lp| NIL) (LETT |objs| (QCAR |s|))
              (SEQ (LETT |oi| 1) (LETT #9# (LENGTH |objs|)) (LETT |obj| NIL)
                   (LETT #8# |objs|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |obj| (CAR #8#)) NIL)
                         (|greater_SI| |oi| #9#))
                     (GO G191)))
                   (SEQ (LETT |newNext| (QVELT |obj| 3))
                        (EXIT
                         (LETT |preTable|
                               (SPADCALL |preTable| |newNext|
                                         (QREFELT $ 124)))))
                   (LETT #8# (PROG1 (CDR #8#) (LETT |oi| (|inc_SI| |oi|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |numRows| (LENGTH |preTable|))
              (LETT |numCols|
                    (SPADCALL (|SPADfirst| |preTable|) (QREFELT $ 47)))
              (LETT |cayleyTable|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |i| 1) (LETT #6# |numCols|) G190
                          (COND ((|greater_SI| |i| #6#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS
                                   (PROGN
                                    (LETT #5# NIL)
                                    (SEQ (LETT |j| 1) (LETT #4# |numRows|) G190
                                         (COND
                                          ((|greater_SI| |j| #4#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #5#
                                                 (CONS
                                                  (SPADCALL
                                                   (SPADCALL |preTable| |j|
                                                             (QREFELT $ 29))
                                                   |i| (QREFELT $ 17))
                                                  #5#))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT (NREVERSE #5#))))
                                   #7#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |preImgs|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |p| 1) (LETT #2# |numRows|) G190
                          (COND ((|greater_SI| |p| #2#) (GO G191)))
                          (SEQ (EXIT (LETT #3# (CONS |p| #3#))))
                          (LETT |p| (|inc_SI| |p|)) (GO G190) G191
                          (EXIT (NREVERSE #3#)))))
              (SEQ (LETT |i| 1) (LETT #1# (LENGTH |cayleyTable|)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |imgs| (SPADCALL |cayleyTable| |i| (QREFELT $ 29)))
                    (LETT |p|
                          (SPADCALL (LIST |preImgs| |imgs|) (QREFELT $ 126)))
                    (EXIT (LETT |lp| (SPADCALL |lp| |p| (QREFELT $ 128)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |lp| (QREFELT $ 130)))))) 

(DECLAIM (NOTINLINE |MultifunctionGraph;|)) 

(DEFUN |MultifunctionGraph| (#1=#:G1304)
  (SPROG NIL
         (PROG (#2=#:G1305)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MultifunctionGraph|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|MultifunctionGraph;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MultifunctionGraph|)))))))))) 

(DEFUN |MultifunctionGraph;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MultifunctionGraph| DV$1))
          (LETT $ (GETREFV 142))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MultifunctionGraph| (LIST DV$1)
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
                                     (|:| |next|
                                          (|List| (|NonNegativeInteger|)))
                                     (|:| |map|
                                          (|List|
                                           (|List|
                                            (|NonNegativeInteger|)))))))))
          $))) 

(MAKEPROP '|MultifunctionGraph| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|List| 6)
              |MFGRPH;multifunctionGraph;L$;1|
              (|Record| (|:| |value| 6) (|:| |posX| 13) (|:| |posY| 13)
                        (|:| |next| 15) (|:| |map| 28))
              (|List| 10) |MFGRPH;multifunctionGraph;L$;2|
              (|NonNegativeInteger|) (|Integer|) (|List| 13) (0 . |setelt!|)
              (7 . |elt|) (13 . |concat|)
              (|Record| (|:| |value| 6) (|:| |posX| 13) (|:| |posY| 13))
              (|List| 19)
              (|Record| (|:| |name| 44) (|:| |arrType| 13) (|:| |fromOb| 13)
                        (|:| |toOb| 13) (|:| |xOffset| 14) (|:| |yOffset| 14)
                        (|:| |map| 15))
              (|List| 21) |MFGRPH;multifunctionGraph;LL$;3| (19 . |elt|)
              (25 . |createX|) (31 . |createY|) (37 . |concat|) (|List| 15)
              (43 . |elt|) |MFGRPH;multifunctionGraph;LL$;4|
              (|Record| (|:| |preimage| 8) (|:| |image| 8)) (|Permutation| 6)
              (49 . |listRepresentation|) (54 . |One|) (58 . |position|)
              (64 . |concat|) (|List| 32) |MFGRPH;multifunctionGraph;L$;5|
              (|Boolean|) (70 . =) |MFGRPH;addObject!;$S$;6|
              |MFGRPH;addObject!;$R$;7| (76 . |elt|) (|String|)
              |MFGRPH;addArrow!;$S2Nni$;8| |MFGRPH;getVertices;$L;9| (82 . |#|)
              (87 . |concat|) |MFGRPH;getArrows;$L;10| |MFGRPH;initial;$;11|
              |MFGRPH;terminal;S$;12| |MFGRPH;cycleOpen;LS$;13|
              |MFGRPH;cycleClosed;LS$;14| |MFGRPH;unit;LS$;15|
              |MFGRPH;kgraph;LS$;16| (93 . |concat|) |MFGRPH;+;3$;17|
              |MFGRPH;merge;3$;18| (99 . ~=) (|List| $) (105 . |concat|)
              (110 . |concat|) (116 . |diagramWidth|) (121 . |diagramHeight|)
              (|Product| 6 6) (126 . |construct|)
              (|Record| (|:| |value| 65) (|:| |posX| 13) (|:| |posY| 13)
                        (|:| |next| 15) (|:| |map| 28))
              (|List| 67) (132 . |concat|) (|MultifunctionGraph| 65)
              (138 . |multifunctionGraph|) |MFGRPH;*;2$Mg;22|
              |MFGRPH;cartesian;2$Mg;23| (|Mapping| 6 6 6)
              |MFGRPH;closedTensor;2$M$;24| |MFGRPH;closedCartesian;2$M$;25|
              (143 . |position|) |MFGRPH;~;2$;26| (149 . |setelt!|)
              |MFGRPH;map;$LL2I$;27| (156 . |nodeToNode|) (162 . |concat|)
              |MFGRPH;mapContra;$LL2I$;28| (168 . |setelt!|) (175 . |max|)
              (|Union| 15 '"failed") |MFGRPH;coAdjoint;$LU;29| (181 . |min|)
              |MFGRPH;contraAdjoint;$LU;30| |MFGRPH;apply;$3Nni;31| (|List| 93)
              (187 . |loopsAtNode|) (|Loop|) (193 . |loop|)
              |MFGRPH;limit;$2NniL;32| (|PermutationGroup| 6) (198 . |coerce|)
              |MFGRPH;coerce;Pg$;33| (203 . |elt|) (209 . =) (215 . *)
              (221 . |member?|) (227 . |concat|) (|List| 44) (233 . |concat|)
              (239 . |elt|) (|Character|) (245 . |char|) (250 . |coerce|)
              (255 . |append|) (261 . |append|) (267 . |one?|) (272 . |one?|)
              (|Mapping| 39 32) (277 . |position|) (283 . |delete|)
              (289 . |delete|) (295 . |first|) (|MultifunctionGraph| 44)
              (301 . |multifunctionGraph|) |MFGRPH;toCayleyGraph;LBMg;39|
              (307 . |generators|) |MFGRPH;toCayleyGraph;PgMg;40|
              (312 . |concat|) (|Permutation| 13)
              (318 . |coercePreimagesImages|) (|List| 125) (323 . |concat|)
              (|PermutationGroup| 13) (329 . |permutationGroup|)
              |MFGRPH;toPermutation;$Pg;41| (|Void|)
              (|Scene| (|SCartesian| '2)) (|Matrix| 14) (|Matrix| 13)
              (|Tree| 14) (|List| 136) (|DirectedGraph| $) (|SingleInteger|)
              (|HashState|) (|OutputForm|))
           '#(~= 334 ~ 340 |unit| 345 |toPermutation| 351 |toCayleyGraph| 356
              |terminal| 367 |subdiagramSvg| 372 |spanningTreeNode| 380
              |spanningTreeArrow| 386 |spanningForestNode| 392
              |spanningForestArrow| 397 |routeNodes| 402 |routeArrows| 409
              |outDegree| 416 |nodeToNode| 422 |nodeToArrow| 428 |nodeFromNode|
              434 |nodeFromArrow| 440 |multifunctionGraph| 446 |min| 473
              |merge| 484 |max| 490 |mapContra| 501 |map| 510 |looseEquals| 519
              |loopsNodes| 525 |loopsAtNode| 530 |loopsArrows| 536 |limit| 541
              |latex| 548 |laplacianMatrix| 553 |kgraph| 558 |isGreaterThan?|
              564 |isFunctional?| 571 |isFixPoint?| 576 |isDirected?| 582
              |isDirectSuccessor?| 586 |isAcyclic?| 593 |initial| 598
              |incidenceMatrix| 602 |inDegree| 607 |hashUpdate!| 613 |hash| 619
              |getVertices| 624 |getVertexIndex| 629 |getArrows| 635
              |getArrowIndex| 640 |flatten| 647 |distanceMatrix| 652 |distance|
              657 |diagramsSvg| 664 |diagramWidth| 671 |diagramSvg| 676
              |diagramHeight| 683 |deepDiagramSvg| 688 |cycleOpen| 695
              |cycleClosed| 701 |createY| 707 |createX| 713 |createWidth| 719
              |contraAdjoint| 724 |coerce| 730 |coAdjoint| 740 |closedTensor|
              746 |closedCartesian| 753 |cartesian| 760 |arrowsToNode| 766
              |arrowsToArrow| 772 |arrowsFromNode| 778 |arrowsFromArrow| 784
              |arrowName| 790 |apply| 797 |adjacencyMatrix| 804 |addObject!|
              809 |addArrow!| 821 = 852 + 858 * 864)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|FiniteGraph&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FiniteGraph| 6) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 141))
                        (|makeByteWordVec2| 141
                                            '(3 15 13 0 14 13 16 2 15 13 0 14
                                              17 2 11 0 0 10 18 2 8 6 0 14 24 2
                                              0 13 13 13 25 2 0 13 13 13 26 2
                                              20 0 0 19 27 2 28 15 0 14 29 1 32
                                              31 0 33 0 32 0 34 2 8 14 6 0 35 2
                                              8 0 0 6 36 2 11 39 0 0 40 2 11 10
                                              0 14 43 1 15 13 0 47 2 22 0 0 21
                                              48 2 11 0 0 0 56 2 13 39 0 0 59 1
                                              44 0 60 61 2 15 0 0 13 62 1 0 13
                                              0 63 1 0 13 0 64 2 65 0 6 6 66 2
                                              68 0 0 67 69 1 70 0 68 71 2 15 14
                                              13 0 77 3 11 10 0 14 10 79 2 0 15
                                              0 13 81 2 15 0 0 0 82 3 28 15 0
                                              14 15 84 2 0 13 0 15 85 2 0 13 0
                                              15 88 2 0 91 0 13 92 1 93 0 15 94
                                              1 96 37 0 97 2 37 32 0 14 99 2 32
                                              39 0 0 100 2 32 0 0 0 101 2 37 39
                                              32 0 102 2 37 0 0 32 103 2 104 0
                                              0 44 105 2 104 44 0 14 106 1 107
                                              0 14 108 1 44 0 107 109 2 37 0 0
                                              0 110 2 104 0 0 0 111 1 13 39 0
                                              112 1 32 39 0 113 2 37 14 114 0
                                              115 2 37 0 0 14 116 2 104 0 0 14
                                              117 2 15 0 0 13 118 2 119 0 104
                                              28 120 1 96 37 0 122 2 28 0 0 15
                                              124 1 125 0 28 126 2 127 0 0 125
                                              128 1 129 0 127 130 2 0 39 0 0 1
                                              1 0 0 0 78 2 0 0 8 44 54 1 0 129
                                              0 131 1 0 119 96 123 2 0 119 37
                                              39 121 1 0 0 6 51 4 0 132 133 0
                                              39 39 1 2 0 136 0 13 1 2 0 136 0
                                              13 1 1 0 137 0 1 1 0 137 0 1 3 0
                                              15 0 13 13 1 3 0 15 0 13 13 1 2 0
                                              13 0 13 1 2 0 15 0 13 81 2 0 15 0
                                              13 1 2 0 15 0 13 1 2 0 15 0 13 1
                                              1 0 0 37 38 2 0 0 20 22 23 2 0 0
                                              8 28 30 1 0 0 11 12 1 0 0 8 9 1 0
                                              13 0 1 2 0 13 0 15 88 2 0 0 0 0
                                              58 2 0 13 0 15 85 1 0 13 0 1 5 0
                                              0 0 15 8 14 14 83 5 0 0 0 15 8 14
                                              14 80 2 0 39 0 0 1 1 0 91 0 1 2 0
                                              91 0 13 92 1 0 91 0 1 3 0 93 0 13
                                              13 95 1 0 44 0 1 1 0 134 0 1 2 0
                                              0 8 44 55 3 0 39 0 13 13 1 1 0 39
                                              0 1 2 0 39 0 13 1 0 0 39 1 3 0 39
                                              0 13 13 1 1 0 39 0 1 0 0 0 50 1 0
                                              134 0 1 2 0 13 0 13 1 2 0 140 140
                                              0 1 1 0 139 0 1 1 0 20 0 46 2 0
                                              13 0 6 1 1 0 22 0 49 3 0 13 0 13
                                              13 1 1 0 0 138 1 1 0 134 0 1 3 0
                                              14 0 13 13 1 3 0 132 44 60 39 1 1
                                              0 13 0 63 3 0 132 44 0 39 1 1 0
                                              13 0 64 3 0 132 44 0 39 1 2 0 0 8
                                              44 52 2 0 0 8 44 53 2 0 13 13 13
                                              26 2 0 13 13 13 25 1 0 13 13 1 2
                                              0 86 0 15 89 1 0 0 96 98 1 0 141
                                              0 1 2 0 86 0 15 87 3 0 0 0 0 74
                                              75 3 0 0 0 0 74 76 2 0 70 0 0 73
                                              2 0 15 0 13 1 2 0 15 0 13 1 2 0
                                              15 0 13 1 2 0 15 0 13 1 3 0 44 0
                                              13 13 1 3 0 13 0 13 13 90 1 0 135
                                              0 1 2 0 0 0 6 41 2 0 0 0 19 42 4
                                              0 0 0 44 6 6 1 4 0 0 0 44 13 13
                                              45 5 0 0 0 44 13 13 15 1 2 0 0 0
                                              21 1 2 0 39 0 0 1 2 0 0 0 0 57 2
                                              0 70 0 0 72)))))
           '|lookupComplete|)) 
