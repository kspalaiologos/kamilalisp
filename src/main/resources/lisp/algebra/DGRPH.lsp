
(SDEFUN |DGRPH;directedGraph;L$;1| ((|objs| (|List| S)) ($ ($)))
        (SPROG
         ((|obs|
           (|List|
            #1=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #1#) (#2=#:G738 NIL) (|ob| NIL) (#3=#:G739 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |objs|)) (LETT |ob| NIL)
                   (LETT #2# |objs|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |ob| (CAR #2#)) NIL)
                         (|greater_SI| |obn| #3#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 9))
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 10))))
                    (EXIT (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| NIL))))) 

(PUT '|DGRPH;directedGraph;L$;2| '|SPADreplace| '(XLAM (|ob|) (CONS |ob| NIL))) 

(SDEFUN |DGRPH;directedGraph;L$;2|
        ((|ob|
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)))))
         ($ ($)))
        (CONS |ob| NIL)) 

(PUT '|DGRPH;directedGraph;LL$;3| '|SPADreplace| 'CONS) 

(SDEFUN |DGRPH;directedGraph;LL$;3|
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

(SDEFUN |DGRPH;directedGraph;LL$;4|
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
          (#1=#:G763 NIL) (|ar| NIL) (#2=#:G764 NIL) (|arn| NIL)
          (|nodes|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (#3=#:G761 NIL) (|ob| NIL) (#4=#:G762 NIL) (|obn| NIL))
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
                                  (SPADCALL (LENGTH |obs|) |obn| (QREFELT $ 9))
                                  (SPADCALL (LENGTH |obs|) |obn|
                                            (QREFELT $ 10))))
                    (EXIT
                     (LETT |nodes| (SPADCALL |nodes| |o| (QREFELT $ 13)))))
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
                                     (QREFELT $ 20)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |arn| (|inc_SI| |arn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |nodes| |edges|))))) 

(SDEFUN |DGRPH;directedGraph;Fp$;5| ((|poset| (|FinitePoset| S)) ($ ($)))
        (SPROG
         ((|ars|
           (|List|
            #1=(|Record| (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|)))))
          (|z| #1#) (#2=#:G775 NIL) (|y| NIL) (#3=#:G776 NIL) (|yn| NIL)
          (#4=#:G773 NIL) (|x| NIL) (#5=#:G774 NIL) (|xn| NIL)
          (|mat| (|List| (|List| (|Boolean|)))) (|obs| (|List| S)))
         (SEQ (LETT |obs| (SPADCALL |poset| (QREFELT $ 25))) (LETT |ars| NIL)
              (LETT |mat| (SPADCALL |poset| (QREFELT $ 27)))
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
                                                    (QREFELT $ 28)))))))))
                          (LETT #2#
                                (PROG1 (CDR #2#) (LETT |yn| (|inc_SI| |yn|))))
                          (GO G190) G191 (EXIT NIL))))
                   (LETT #4# (PROG1 (CDR #4#) (LETT |xn| (|inc_SI| |xn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |obs| |ars| (QREFELT $ 23)))))) 

(SDEFUN |DGRPH;directedGraph;LL$;6|
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
          (|a| #1#) (#2=#:G796 NIL) (|j| NIL) (#3=#:G795 NIL) (|i| NIL)
          (|obs|
           (|List|
            #4=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #4#) (#5=#:G793 NIL) (|ob| NIL) (#6=#:G794 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |obn| 1) (LETT #6# (LENGTH |objs|)) (LETT |ob| NIL)
                   (LETT #5# |objs|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |ob| (CAR #5#)) NIL)
                         (|greater_SI| |obn| #6#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 9))
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 10))))
                    (EXIT (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))))
                   (LETT #5# (PROG1 (CDR #5#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |ar| NIL)
              (SEQ (LETT |i| 1) (LETT #3# (LENGTH |am|)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1)
                          (LETT #2#
                                (SPADCALL (SPADCALL |am| |i| (QREFELT $ 33))
                                          (QREFELT $ 34)))
                          G190 (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((EQL
                               (SPADCALL (SPADCALL |am| |i| (QREFELT $ 33)) |j|
                                         (QREFELT $ 35))
                               1)
                              (SEQ (LETT |a| (VECTOR "a" 0 |i| |j| 0 0 NIL))
                                   (EXIT
                                    (LETT |ar|
                                          (SPADCALL |ar| |a|
                                                    (QREFELT $ 20)))))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ar|))))) 

(SDEFUN |DGRPH;directedGraph;L$;7|
        ((|perms| (|List| (|Permutation| S))) ($ ($)))
        (SPROG
         ((|ars|
           (|List|
            #1=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|a| #1#) (#2=#:G981 NIL) (|arrNum| NIL)
          (|verts|
           (|List|
            #3=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #3#) (#4=#:G979 NIL) (|vert| NIL) (#5=#:G980 NIL) (|i| NIL)
          (#6=#:G954 NIL) (#7=#:G953 NIL) (|pout| #8=(|Integer|)) (|pin| #8#)
          (#9=#:G978 NIL) (|pt| NIL) (|preim| #10=(|List| S))
          (|im| #11=(|List| S))
          (|lr| (|Record| (|:| |preimage| #10#) (|:| |image| #11#)))
          (#12=#:G976 NIL) (|perm| NIL) (#13=#:G977 NIL) (|pi| NIL)
          (|tab| (|List| (|List| (|NonNegativeInteger|)))) (#14=#:G975 NIL)
          (#15=#:G974 NIL) (#16=#:G973 NIL) (|b| NIL) (#17=#:G972 NIL)
          (|obs| (|List| S)) (#18=#:G971 NIL) (|v| NIL) (#19=#:G969 NIL)
          (#20=#:G970 NIL) (|px| NIL))
         (SEQ (LETT |obs| NIL)
              (SEQ (LETT |px| 1) (LETT #20# (LENGTH |perms|)) (LETT |perm| NIL)
                   (LETT #19# |perms|) G190
                   (COND
                    ((OR (ATOM #19#) (PROGN (LETT |perm| (CAR #19#)) NIL)
                         (|greater_SI| |px| #20#))
                     (GO G191)))
                   (SEQ (LETT |lr| (SPADCALL |perm| (QREFELT $ 39)))
                        (LETT |im| (QCDR |lr|))
                        (EXIT
                         (COND ((EQL |px| 1) (LETT |obs| |im|))
                               ('T
                                (SEQ (LETT |v| NIL) (LETT #18# |im|) G190
                                     (COND
                                      ((OR (ATOM #18#)
                                           (PROGN (LETT |v| (CAR #18#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((< (SPADCALL |v| |obs| (QREFELT $ 41))
                                            1)
                                         (LETT |obs|
                                               (SPADCALL |obs| |v|
                                                         (QREFELT $ 42)))))))
                                     (LETT #18# (CDR #18#)) (GO G190) G191
                                     (EXIT NIL))))))
                   (LETT #19# (PROG1 (CDR #19#) (LETT |px| (|inc_SI| |px|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |tab|
                    (PROGN
                     (LETT #17# NIL)
                     (SEQ (LETT |b| 1) (LETT #16# (LENGTH |obs|)) G190
                          (COND ((|greater_SI| |b| #16#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #17#
                                  (CONS
                                   (PROGN
                                    (LETT #15# NIL)
                                    (SEQ (LETT |a| 1)
                                         (LETT #14# (LENGTH |perms|)) G190
                                         (COND
                                          ((|greater_SI| |a| #14#) (GO G191)))
                                         (SEQ
                                          (EXIT (LETT #15# (CONS |b| #15#))))
                                         (LETT |a| (|inc_SI| |a|)) (GO G190)
                                         G191 (EXIT (NREVERSE #15#))))
                                   #17#))))
                          (LETT |b| (|inc_SI| |b|)) (GO G190) G191
                          (EXIT (NREVERSE #17#)))))
              (SEQ (LETT |pi| 1) (LETT #13# (LENGTH |perms|)) (LETT |perm| NIL)
                   (LETT #12# |perms|) G190
                   (COND
                    ((OR (ATOM #12#) (PROGN (LETT |perm| (CAR #12#)) NIL)
                         (|greater_SI| |pi| #13#))
                     (GO G191)))
                   (SEQ (LETT |lr| (SPADCALL |perm| (QREFELT $ 39)))
                        (LETT |im| (QCDR |lr|)) (LETT |preim| (QCAR |lr|))
                        (EXIT
                         (SEQ (LETT |pt| 1) (LETT #9# (LENGTH |im|)) G190
                              (COND ((|greater_SI| |pt| #9#) (GO G191)))
                              (SEQ
                               (LETT |pin|
                                     (SPADCALL
                                      (SPADCALL |im| |pt| (QREFELT $ 43)) |obs|
                                      (QREFELT $ 41)))
                               (LETT |pout|
                                     (SPADCALL
                                      (SPADCALL |preim| |pt| (QREFELT $ 43))
                                      |obs| (QREFELT $ 41)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL |tab|
                                           (PROG1 (LETT #7# |pin|)
                                             (|check_subtype2| (>= #7# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #7#))
                                           (QREFELT $ 33))
                                 |pi|
                                 (PROG1 (LETT #6# |pout|)
                                   (|check_subtype2| (>= #6# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #6#))
                                 (QREFELT $ 44))))
                              (LETT |pt| (|inc_SI| |pt|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT #12# (PROG1 (CDR #12#) (LETT |pi| (|inc_SI| |pi|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |verts| NIL) (LETT |ars| NIL)
              (SEQ (LETT |i| 1) (LETT #5# (LENGTH |obs|)) (LETT |vert| NIL)
                   (LETT #4# |obs|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |vert| (CAR #4#)) NIL)
                         (|greater_SI| |i| #5#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |vert|
                                  (SPADCALL (LENGTH |obs|) |i| (QREFELT $ 9))
                                  (SPADCALL (LENGTH |obs|) |i|
                                            (QREFELT $ 10))))
                    (LETT |verts| (SPADCALL |verts| |o| (QREFELT $ 13)))
                    (EXIT
                     (SEQ (LETT |arrNum| NIL)
                          (LETT #2# (SPADCALL |tab| |i| (QREFELT $ 33))) G190
                          (COND
                           ((OR (ATOM #2#)
                                (PROGN (LETT |arrNum| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |a| (VECTOR "a" 0 |i| |arrNum| 0 0 NIL))
                               (EXIT
                                (LETT |ars|
                                      (SPADCALL |ars| |a| (QREFELT $ 20)))))
                          (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #4# (PROG1 (CDR #4#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |verts| |ars|))))) 

(SDEFUN |DGRPH;addObject!;$S$;8| ((|s| ($)) (|n| (S)) ($ ($)))
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
               ((SPADCALL |obs| NIL (QREFELT $ 48))
                (PROGN (RPLACA |s| (LIST |obj|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |obj| (QREFELT $ 13)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |DGRPH;addObject!;$R$;9|
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
               ((SPADCALL |obs| NIL (QREFELT $ 48))
                (PROGN (RPLACA |s| (LIST |n|)) (QCAR |s|)))
               ('T
                (PROGN
                 (RPLACA |s| (SPADCALL |obs| |n| (QREFELT $ 13)))
                 (QCAR |s|))))
              (EXIT |s|)))) 

(SDEFUN |DGRPH;addArrow!;$R$;10|
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
          (RPLACD |s| (SPADCALL (QCDR |s|) |ar| (QREFELT $ 20)))
          (QCDR |s|))
         (EXIT |s|))) 

(SDEFUN |DGRPH;addArrow!;$S2Nni$;11|
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
              (EXIT (SPADCALL |s| |a| (QREFELT $ 51)))))) 

(SDEFUN |DGRPH;addArrow!;$S2NniL$;12|
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
              (EXIT (SPADCALL |s| |a| (QREFELT $ 51)))))) 

(PUT '|DGRPH;getVertices;$L;13| '|SPADreplace| 'QCAR) 

(SDEFUN |DGRPH;getVertices;$L;13|
        ((|s| ($))
         ($
          (|List|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))))
        (QCAR |s|)) 

(PUT '|DGRPH;getArrows;$L;14| '|SPADreplace| 'QCDR) 

(SDEFUN |DGRPH;getArrows;$L;14|
        ((|s| ($))
         ($
          (|List|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))))
        (QCDR |s|)) 

(SDEFUN |DGRPH;flatten;Dg$;15| ((|n| (|DirectedGraph| $)) ($ ($)))
        (SPROG
         ((|a|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arr|
           #1=(|Record| (|:| |name| #2=(|String|))
                        (|:| |arrType| #3=(|NonNegativeInteger|))
                        (|:| |fromOb| (|NonNegativeInteger|))
                        (|:| |toOb| (|NonNegativeInteger|))
                        (|:| |xOffset| #4=(|Integer|))
                        (|:| |yOffset| #5=(|Integer|))
                        (|:| |map| #6=(|List| (|NonNegativeInteger|)))))
          (|toOb3| #7=(|NonNegativeInteger|)) (|fromOb3| #7#) (#8=#:G1037 NIL)
          (|endi| NIL) (#9=#:G1038 NIL) (|starti| NIL) (|map3| #6#)
          (|yOffset3| #5#) (|xOffset3| #4#) (|arrType3| #3#) (|name3| #2#)
          (#10=#:G1036 NIL) (|oa3| NIL)
          (|outerArrows|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|map2| #6#) (|yOffset2| #5#) (|xOffset2| #4#) (|toOb2| #7#)
          (|fromOb2| #7#) (|arrType2| #3#) (|name2| #2#) (#11=#:G1035 NIL)
          (|a3| NIL) (#12=#:G1033 NIL) (|a2| NIL) (#13=#:G1034 NIL) (|a2n| NIL)
          (|iv|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|offset| (|NonNegativeInteger|))
          (|offsets| (|List| (|NonNegativeInteger|)))
          (|innerArrows| (|List| (|List| #1#)))
          (|ina|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|innerValues|
           (|List|
            #14=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                          (|:| |posY| (|NonNegativeInteger|)))))
          (|obs2|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|ob2| #14#) (|py| #7#) (|px| #7#) (#15=#:G1032 NIL) (|ob| NIL)
          (|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|v3| ($)) (#16=#:G1031 NIL) (|v2| NIL)
          (|v|
           (|List|
            (|Record| (|:| |value| $) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |v| (SPADCALL |n| (QREFELT $ 60))) (LETT |innerValues| NIL)
              (LETT |offset| 0) (LETT |offsets| NIL) (LETT |innerArrows| NIL)
              (SEQ (LETT |v2| NIL) (LETT #16# |v|) G190
                   (COND
                    ((OR (ATOM #16#) (PROGN (LETT |v2| (CAR #16#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |v3| (QVELT |v2| 0))
                        (LETT |obs| (SPADCALL |v3| (QREFELT $ 55)))
                        (LETT |obs2| NIL)
                        (SEQ (LETT |ob| NIL) (LETT #15# |obs|) G190
                             (COND
                              ((OR (ATOM #15#)
                                   (PROGN (LETT |ob| (CAR #15#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |px|
                                    (+ (QVELT |ob| 1) (* 4 (QVELT |v2| 1))))
                              (LETT |py|
                                    (+ (QVELT |ob| 2) (* 4 (QVELT |v2| 2))))
                              (LETT |ob2| (VECTOR (QVELT |ob| 0) |px| |py|))
                              (EXIT
                               (LETT |obs2|
                                     (SPADCALL |obs2| |ob2| (QREFELT $ 13)))))
                             (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
                        (LETT |innerValues|
                              (SPADCALL |innerValues| |obs2| (QREFELT $ 61)))
                        (LETT |ina| (SPADCALL |v3| (QREFELT $ 56)))
                        (LETT |innerArrows|
                              (SPADCALL |innerArrows| |ina| (QREFELT $ 63)))
                        (LETT |offsets|
                              (SPADCALL |offsets| |offset| (QREFELT $ 64)))
                        (EXIT (LETT |offset| (+ |offset| (LENGTH |obs|)))))
                   (LETT #16# (CDR #16#)) (GO G190) G191 (EXIT NIL))
              (LETT |iv| |innerValues|) (LETT |a| NIL)
              (SEQ (LETT |a2n| 1) (LETT #13# (LENGTH |innerArrows|))
                   (LETT |a2| NIL) (LETT #12# |innerArrows|) G190
                   (COND
                    ((OR (ATOM #12#) (PROGN (LETT |a2| (CAR #12#)) NIL)
                         (|greater_SI| |a2n| #13#))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |a3| NIL) (LETT #11# |a2|) G190
                          (COND
                           ((OR (ATOM #11#) (PROGN (LETT |a3| (CAR #11#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |name2| (QVELT |a3| 0))
                               (LETT |arrType2| (QVELT |a3| 1))
                               (LETT |fromOb2|
                                     (+ (QVELT |a3| 2)
                                        (SPADCALL |offsets| |a2n|
                                                  (QREFELT $ 35))))
                               (LETT |toOb2|
                                     (+ (QVELT |a3| 3)
                                        (SPADCALL |offsets| |a2n|
                                                  (QREFELT $ 35))))
                               (LETT |xOffset2| (QVELT |a3| 4))
                               (LETT |yOffset2| (QVELT |a3| 5))
                               (LETT |map2| (QVELT |a3| 6))
                               (LETT |arr|
                                     (VECTOR |name2| |arrType2| |fromOb2|
                                             |toOb2| |xOffset2| |yOffset2|
                                             |map2|))
                               (EXIT
                                (LETT |a|
                                      (SPADCALL |a| |arr| (QREFELT $ 20)))))
                          (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #12# (PROG1 (CDR #12#) (LETT |a2n| (|inc_SI| |a2n|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |outerArrows| (SPADCALL |n| (QREFELT $ 65)))
              (SEQ (LETT |oa3| NIL) (LETT #10# |outerArrows|) G190
                   (COND
                    ((OR (ATOM #10#) (PROGN (LETT |oa3| (CAR #10#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |name3| (QVELT |oa3| 0))
                        (LETT |arrType3| (QVELT |oa3| 1))
                        (LETT |fromOb3|
                              (+
                               (SPADCALL |offsets| (QVELT |oa3| 2)
                                         (QREFELT $ 35))
                               1))
                        (LETT |toOb3|
                              (+
                               (SPADCALL |offsets| (QVELT |oa3| 3)
                                         (QREFELT $ 35))
                               1))
                        (LETT |xOffset3| (QVELT |oa3| 4))
                        (LETT |yOffset3| (QVELT |oa3| 5))
                        (LETT |map3| (QVELT |oa3| 6))
                        (EXIT
                         (SEQ (LETT |starti| 1)
                              (LETT #9# (SPADCALL |map3| (QREFELT $ 34)))
                              (LETT |endi| NIL) (LETT #8# |map3|) G190
                              (COND
                               ((OR (ATOM #8#)
                                    (PROGN (LETT |endi| (CAR #8#)) NIL)
                                    (|greater_SI| |starti| #9#))
                                (GO G191)))
                              (SEQ
                               (LETT |fromOb3|
                                     (+
                                      (SPADCALL |offsets| (QVELT |oa3| 2)
                                                (QREFELT $ 35))
                                      |starti|))
                               (LETT |toOb3|
                                     (+
                                      (SPADCALL |offsets| (QVELT |oa3| 3)
                                                (QREFELT $ 35))
                                      |endi|))
                               (LETT |arr|
                                     (VECTOR |name3| |arrType3| |fromOb3|
                                             |toOb3| |xOffset3| |yOffset3|
                                             NIL))
                               (EXIT
                                (LETT |a|
                                      (SPADCALL |a| |arr| (QREFELT $ 20)))))
                              (LETT #8#
                                    (PROG1 (CDR #8#)
                                      (LETT |starti| (|inc_SI| |starti|))))
                              (GO G190) G191 (EXIT NIL))))
                   (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |iv| |a|))))) 

(PUT '|DGRPH;initial;$;16| '|SPADreplace| '(XLAM NIL (CONS NIL NIL))) 

(SDEFUN |DGRPH;initial;$;16| (($ ($))) (CONS NIL NIL)) 

(SDEFUN |DGRPH;terminal;S$;17| ((|a| (S)) ($ ($)))
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

(SDEFUN |DGRPH;cycleOpen;LS$;18|
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
          (|o| #2#) (#3=#:G1056 NIL) (|ob| NIL) (#4=#:G1057 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #4# (LENGTH |objs|)) (LETT |ob| NIL)
                   (LETT #3# |objs|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |ob| (CAR #3#)) NIL)
                         (|greater_SI| |obn| #4#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 9))
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 10))))
                    (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))
                    (LETT |next| (+ |obn| 1))
                    (COND
                     ((EQL (- |next| 1) (LENGTH |objs|)) (LETT |next| |obn|)))
                    (EXIT
                     (COND
                      ((<= |next| (LENGTH |objs|))
                       (SEQ
                        (LETT |a|
                              (VECTOR (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                      0 |obn| |next| 0 0 NIL))
                        (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 20)))
                        (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |DGRPH;cycleClosed;LS$;19|
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
          (|o| #2#) (#3=#:G1068 NIL) (|ob| NIL) (#4=#:G1069 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #4# (LENGTH |objs|)) (LETT |ob| NIL)
                   (LETT #3# |objs|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |ob| (CAR #3#)) NIL)
                         (|greater_SI| |obn| #4#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 9))
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 10))))
                    (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))
                    (LETT |next| (+ |obn| 1))
                    (COND ((EQL (- |next| 1) (LENGTH |objs|)) (LETT |next| 1)))
                    (EXIT
                     (COND
                      ((<= |next| (LENGTH |objs|))
                       (SEQ
                        (LETT |a|
                              (VECTOR (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                      0 |obn| |next| 0 0 NIL))
                        (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 20)))
                        (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |DGRPH;unit;LS$;20|
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
          (|o| #2#) (#3=#:G1077 NIL) (|ob| NIL) (#4=#:G1078 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #4# (LENGTH |objs|)) (LETT |ob| NIL)
                   (LETT #3# |objs|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |ob| (CAR #3#)) NIL)
                         (|greater_SI| |obn| #4#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 9))
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 10))))
                    (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))
                    (LETT |a|
                          (VECTOR (STRCONC |arrowName| (STRINGIMAGE |arn|)) 0
                                  |obn| |obn| 0 0 NIL))
                    (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 20)))
                    (EXIT (LETT |arn| (+ |arn| 1))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |DGRPH;kgraph;LS$;21|
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
          (|a| #1#) (#2=#:G1092 NIL) (|obm| NIL)
          (|obs|
           (|List|
            #3=(|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                         (|:| |posY| (|NonNegativeInteger|)))))
          (|o| #3#) (#4=#:G1090 NIL) (|ob| NIL) (#5=#:G1091 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #5# (LENGTH |objs|)) (LETT |ob| NIL)
                   (LETT #4# |objs|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |ob| (CAR #4#)) NIL)
                         (|greater_SI| |obn| #5#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 9))
                                  (SPADCALL (LENGTH |objs|) |obn|
                                            (QREFELT $ 10))))
                    (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))
                    (EXIT
                     (SEQ (LETT |obm| 1) (LETT #2# (LENGTH |objs|)) G190
                          (COND ((|greater_SI| |obm| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL |obn| |obm| (QREFELT $ 73))
                              (SEQ
                               (LETT |a|
                                     (VECTOR
                                      (STRCONC |arrowName| (STRINGIMAGE |arn|))
                                      0 |obn| |obm| 0 0 NIL))
                               (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 20)))
                               (EXIT (LETT |arn| (+ |arn| 1))))))))
                          (LETT |obm| (|inc_SI| |obm|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT #4# (PROG1 (CDR #4#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(SDEFUN |DGRPH;+;3$;22| ((|a| ($)) (|b| ($)) ($ ($)))
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
          (|arr| #1#) (#2=#:G1101 NIL) (|ba| NIL)
          (|bStart| (|NonNegativeInteger|))
          (|lo|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |lo| (SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 61)))
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
                                  (QVELT |ba| 5) NIL))
                    (EXIT (LETT |lb| (SPADCALL |lb| |arr| (QREFELT $ 20)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |la| (SPADCALL (QCDR |a|) |lb| (QREFELT $ 75)))
              (EXIT (CONS |lo| |la|))))) 

(SDEFUN |DGRPH;merge;3$;23| ((|a| ($)) (|b| ($)) ($ ($)))
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
          (#3=#:G1125 NIL) (|ba| NIL) (|bStart| #4=(|NonNegativeInteger|))
          (|bmap| (|List| (|NonNegativeInteger|))) (#5=#:G1112 NIL)
          (|newIndex| #4#)
          (|mergedObjects|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|i| (|Integer|)) (#6=#:G1124 NIL) (|bob| NIL) (#7=#:G1123 NIL)
          (|x| NIL) (#8=#:G1122 NIL))
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
               (SEQ (LETT |i| (SPADCALL |bob| (QCAR |a|) (QREFELT $ 77)))
                    (EXIT
                     (COND
                      ((< |i| 1)
                       (SEQ
                        (LETT |mergedObjects|
                              (SPADCALL |mergedObjects| |bob| (QREFELT $ 13)))
                        (LETT |newIndex| (+ |newIndex| 1))
                        (EXIT
                         (LETT |bmap|
                               (SPADCALL |bmap| |newIndex| (QREFELT $ 64))))))
                      ('T
                       (LETT |bmap|
                             (SPADCALL |bmap|
                                       (PROG1 (LETT #5# |i|)
                                         (|check_subtype2| (>= #5# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #5#))
                                       (QREFELT $ 64)))))))
               (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
          (LETT |bStart| (LENGTH (QCAR |a|))) (LETT |lb| NIL)
          (SEQ (LETT |ba| NIL) (LETT #3# (QCDR |b|)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |ba| (CAR #3#)) NIL)) (GO G191)))
               (SEQ
                (LETT |toI|
                      (SPADCALL |bmap| (+ (QVELT |ba| 3) |bStart|)
                                (QREFELT $ 35)))
                (LETT |fromI|
                      (SPADCALL |bmap| (+ (QVELT |ba| 2) |bStart|)
                                (QREFELT $ 35)))
                (LETT |arr|
                      (VECTOR (QVELT |ba| 0) (QVELT |ba| 1) |fromI| |toI|
                              (QVELT |ba| 4) (QVELT |ba| 5) (QVELT |ba| 6)))
                (EXIT (LETT |lb| (SPADCALL |lb| |arr| (QREFELT $ 20)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (LETT |la| (SPADCALL (QCDR |a|) |lb| (QREFELT $ 75)))
          (EXIT (CONS |mergedObjects| |la|))))) 

(SDEFUN |DGRPH;objProd|
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
          (|bi| (S)) (#4=#:G1139 NIL) (|boi| NIL) (|ayi| #2#) (|axi| #3#)
          (|ai| (S)) (#5=#:G1138 NIL) (|aoi| NIL))
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
                                             (SPADCALL |a| (QREFELT $ 79)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 80)))
                                          |ayi|))
                                   (LETT |sp|
                                         (SPADCALL |ai| |bi| (QREFELT $ 82)))
                                   (LETT |ob| (VECTOR |sp| |x| |y|))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 85)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |newObjs|)))) 

(SDEFUN |DGRPH;indexProd|
        ((|aObj| ($)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G1140 NIL))
               (+ |a|
                  (*
                   (PROG1 (LETT #1# (- |b| 1))
                     (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #1#))
                   (LENGTH (QCAR |aObj|)))))) 

(SDEFUN |DGRPH;*;2$Dg;26|
        ((|a| ($)) (|b| ($)) ($ (|DirectedGraph| (|Product| S S))))
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
          (|arr| #1#) (|an| (|String|)) (#2=#:G1166 NIL) (|bv| NIL)
          (#3=#:G1165 NIL) (|bu| NIL) (#4=#:G1164 NIL) (|av| NIL)
          (#5=#:G1163 NIL) (|au| NIL))
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
                                                      (QREFELT $ 86))
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 86))
                                              (SEQ
                                               (LETT |an|
                                                     (SPADCALL
                                                      (LIST
                                                       (SPADCALL |a| |au| |av|
                                                                 (QREFELT $
                                                                          87))
                                                       "*"
                                                       (SPADCALL |b| |bu| |bv|
                                                                 (QREFELT $
                                                                          87)))
                                                      (QREFELT $ 89)))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|DGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|DGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         20)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|DGRPH;objProd| |a| |b| $) |newArrs|
                         (QREFELT $ 91)))))) 

(SDEFUN |DGRPH;cartesian;2$Dg;27|
        ((|a| ($)) (|b| ($)) ($ (|DirectedGraph| (|Product| S S))))
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
          (|arr| #1#) (|an| (|String|)) (#2=#:G1195 NIL) (|bv| NIL)
          (#3=#:G1194 NIL) (|bu| NIL) (#4=#:G1193 NIL) (|av| NIL)
          (#5=#:G1192 NIL) (|au| NIL))
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
                                                        (QREFELT $ 86))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            86))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              87))
                                                           #6="#"
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 89)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              87))
                                                           #7="#"
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 89)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            87))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 89)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|DGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|DGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         20))))))
                                             ((EQL |au| |av|)
                                              (COND
                                               ((SPADCALL |b| |bu| |bv|
                                                          (QREFELT $ 86))
                                                (SEQ
                                                 (LETT |an|
                                                       (COND
                                                        ((EQL |bu| |bv|)
                                                         (COND
                                                          ((SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              86))
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |a| |au|
                                                                       |av|
                                                                       (QREFELT
                                                                        $ 87))
                                                             #6#
                                                             (STRINGIMAGE
                                                              |bv|))
                                                            (QREFELT $ 89)))
                                                          ('T
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |b| |bu|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 87))
                                                             #7#
                                                             (STRINGIMAGE
                                                              |av|))
                                                            (QREFELT $ 89)))))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              87))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 89)))))
                                                 (LETT |arr|
                                                       (VECTOR |an| 0
                                                               (|DGRPH;indexProd|
                                                                |b| |bu| |au|
                                                                $)
                                                               (|DGRPH;indexProd|
                                                                |b| |bv| |av|
                                                                $)
                                                               0 0 NIL))
                                                 (EXIT
                                                  (LETT |newArrs|
                                                        (SPADCALL |newArrs|
                                                                  |arr|
                                                                  (QREFELT $
                                                                           20))))))))))
                                           ((EQL |au| |av|)
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 86))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            86))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              87))
                                                           #6#
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 89)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              87))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 89)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            87))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 89)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|DGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|DGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         20)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|DGRPH;objProd| |a| |b| $) |newArrs|
                         (QREFELT $ 91)))))) 

(SDEFUN |DGRPH;closedObjProd|
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
          (|bxi| #1#) (|bi| (S)) (#4=#:G1206 NIL) (|boi| NIL) (|ayi| #2#)
          (|axi| #1#) (|ai| (S)) (#5=#:G1205 NIL) (|aoi| NIL))
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
                                             (SPADCALL |a| (QREFELT $ 79)))
                                          |axi|))
                                   (LETT |y|
                                         (+
                                          (* |byi|
                                             (SPADCALL |a| (QREFELT $ 80)))
                                          |ayi|))
                                   (LETT |sp| (SPADCALL |ai| |bi| |f|))
                                   (LETT |ob| (VECTOR |sp| |x| |y|))
                                   (EXIT
                                    (LETT |newObjs|
                                          (SPADCALL |newObjs| |ob|
                                                    (QREFELT $ 13)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |newObjs|)))) 

(SDEFUN |DGRPH;closedTensor;2$M$;29|
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
          (|arr| #1#) (|an| (|String|)) (#2=#:G1231 NIL) (|bv| NIL)
          (#3=#:G1230 NIL) (|bu| NIL) (#4=#:G1229 NIL) (|av| NIL)
          (#5=#:G1228 NIL) (|au| NIL))
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
                                                      (QREFELT $ 86))
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 86))
                                              (SEQ
                                               (LETT |an|
                                                     (SPADCALL
                                                      (LIST
                                                       (SPADCALL |a| |au| |av|
                                                                 (QREFELT $
                                                                          87))
                                                       "*"
                                                       (SPADCALL |b| |bu| |bv|
                                                                 (QREFELT $
                                                                          87)))
                                                      (QREFELT $ 89)))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|DGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|DGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         20)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|DGRPH;closedObjProd| |a| |b| |f| $) |newArrs|
                         (QREFELT $ 19)))))) 

(SDEFUN |DGRPH;closedCartesian;2$M$;30|
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
          (|arr| #1#) (|an| (|String|)) (#2=#:G1261 NIL) (|bv| NIL)
          (#3=#:G1260 NIL) (|bu| NIL) (#4=#:G1259 NIL) (|av| NIL)
          (#5=#:G1258 NIL) (|au| NIL))
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
                                                        (QREFELT $ 86))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            86))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              87))
                                                           #6="#"
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 89)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              87))
                                                           #7="#"
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 89)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            87))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 89)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|DGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|DGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         20))))))
                                             ((EQL |au| |av|)
                                              (COND
                                               ((SPADCALL |b| |bu| |bv|
                                                          (QREFELT $ 86))
                                                (SEQ
                                                 (LETT |an|
                                                       (COND
                                                        ((EQL |bu| |bv|)
                                                         (COND
                                                          ((SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              86))
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |a| |au|
                                                                       |av|
                                                                       (QREFELT
                                                                        $ 87))
                                                             #6#
                                                             (STRINGIMAGE
                                                              |bv|))
                                                            (QREFELT $ 89)))
                                                          ('T
                                                           (SPADCALL
                                                            (LIST
                                                             (SPADCALL |b| |bu|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 87))
                                                             #7#
                                                             (STRINGIMAGE
                                                              |av|))
                                                            (QREFELT $ 89)))))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              87))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 89)))))
                                                 (LETT |arr|
                                                       (VECTOR |an| 0
                                                               (|DGRPH;indexProd|
                                                                |b| |bu| |au|
                                                                $)
                                                               (|DGRPH;indexProd|
                                                                |b| |bv| |av|
                                                                $)
                                                               0 0 NIL))
                                                 (EXIT
                                                  (LETT |newArrs|
                                                        (SPADCALL |newArrs|
                                                                  |arr|
                                                                  (QREFELT $
                                                                           20))))))))))
                                           ((EQL |au| |av|)
                                            (COND
                                             ((SPADCALL |b| |bu| |bv|
                                                        (QREFELT $ 86))
                                              (SEQ
                                               (LETT |an|
                                                     (COND
                                                      ((EQL |bu| |bv|)
                                                       (COND
                                                        ((SPADCALL |a| |au|
                                                                   |av|
                                                                   (QREFELT $
                                                                            86))
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |a| |au|
                                                                     |av|
                                                                     (QREFELT $
                                                                              87))
                                                           #6#
                                                           (STRINGIMAGE |bv|))
                                                          (QREFELT $ 89)))
                                                        ('T
                                                         (SPADCALL
                                                          (LIST
                                                           (SPADCALL |b| |bu|
                                                                     |bv|
                                                                     (QREFELT $
                                                                              87))
                                                           #7#
                                                           (STRINGIMAGE |av|))
                                                          (QREFELT $ 89)))))
                                                      ('T
                                                       (SPADCALL
                                                        (LIST
                                                         (SPADCALL |b| |bu|
                                                                   |bv|
                                                                   (QREFELT $
                                                                            87))
                                                         #7#
                                                         (STRINGIMAGE |av|))
                                                        (QREFELT $ 89)))))
                                               (LETT |arr|
                                                     (VECTOR |an| 0
                                                             (|DGRPH;indexProd|
                                                              |b| |bu| |au| $)
                                                             (|DGRPH;indexProd|
                                                              |b| |bv| |av| $)
                                                             0 0 NIL))
                                               (EXIT
                                                (LETT |newArrs|
                                                      (SPADCALL |newArrs| |arr|
                                                                (QREFELT $
                                                                         20)))))))))))
                                        (LETT |bv| (|inc_SI| |bv|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |bu| (|inc_SI| |bu|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |av| (|inc_SI| |av|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |au| (|inc_SI| |au|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (|DGRPH;closedObjProd| |a| |b| |f| $) |newArrs|
                         (QREFELT $ 19)))))) 

(SDEFUN |DGRPH;~;2$;31| ((|s| ($)) ($ ($)))
        (SPROG
         ((|newArrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|newArr|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (#1=#:G1274 NIL) (|j| NIL) (#2=#:G1273 NIL) (|i| NIL)
          (|ars|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|obs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |obs| (QCAR |s|)) (LETT |ars| (QCDR |s|))
              (LETT |newArrs| NIL)
              (SEQ (LETT |i| 1) (LETT #2# (LENGTH |obs|)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# (LENGTH |obs|)) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((NULL (SPADCALL |s| |i| |j| (QREFELT $ 86)))
                              (SEQ
                               (LETT |newArr|
                                     (VECTOR
                                      (STRCONC (STRINGIMAGE |i|)
                                               (STRINGIMAGE |j|))
                                      0 |i| |j| 0 0 NIL))
                               (EXIT
                                (LETT |newArrs|
                                      (SPADCALL |newArrs| |newArr|
                                                (QREFELT $ 20)))))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |newArrs|))))) 

(SDEFUN |DGRPH;map;$LL2I$;32|
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
          (|newArr| #2#) (#3=#:G1294 NIL) (|oldArrow| NIL) (#4=#:G1281 NIL)
          (#5=#:G1280 NIL) (|i| (|NonNegativeInteger|)) (#6=#:G1293 NIL)
          (|oi| NIL)
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#7=#:G1292 NIL) (|o| NIL) (#8=#:G1291 NIL))
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
               (SEQ (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 35)))
                    (EXIT
                     (SPADCALL |newObjs| |i|
                               (VECTOR
                                (QVELT (SPADCALL |newObjs| |i| (QREFELT $ 98))
                                       0)
                                (PROG1
                                    (LETT #5#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 98))
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
                                                      (QREFELT $ 98))
                                            2)
                                           |offsetY|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#)))
                               (QREFELT $ 99))))
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
                                        (QREFELT $ 35))
                              (SPADCALL |m| (QVELT |oldArrow| 3)
                                        (QREFELT $ 35))
                              (QVELT |oldArrow| 4) (QVELT |oldArrow| 5)
                              (QVELT |oldArrow| 6)))
                (EXIT
                 (LETT |newArrs|
                       (SPADCALL |newArrs| |newArr| (QREFELT $ 20)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |newObjs| |newArrs|))))) 

(SDEFUN |DGRPH;mapContra;$LL2I$;33|
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
          (|newArr| #2#) (#3=#:G1314 NIL) (|oldArrow| NIL) (#4=#:G1301 NIL)
          (#5=#:G1300 NIL) (|i| (|NonNegativeInteger|)) (#6=#:G1313 NIL)
          (|oi| NIL)
          (|newObjs|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#7=#:G1312 NIL) (|o| NIL) (#8=#:G1311 NIL))
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
               (SEQ (LETT |i| (SPADCALL |m| |oi| (QREFELT $ 35)))
                    (EXIT
                     (SPADCALL |newObjs| |i|
                               (VECTOR
                                (QVELT (SPADCALL |newObjs| |i| (QREFELT $ 98))
                                       0)
                                (PROG1
                                    (LETT #5#
                                          (+
                                           (QVELT
                                            (SPADCALL (QCAR |s|) |oi|
                                                      (QREFELT $ 98))
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
                                                      (QREFELT $ 98))
                                            2)
                                           |offsetY|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#)))
                               (QREFELT $ 99))))
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
                                        (QREFELT $ 35))
                              (SPADCALL |m| (QVELT |oldArrow| 2)
                                        (QREFELT $ 35))
                              (QVELT |oldArrow| 4) (QVELT |oldArrow| 5)
                              (QVELT |oldArrow| 6)))
                (EXIT
                 (LETT |newArrs|
                       (SPADCALL |newArrs| |newArr| (QREFELT $ 20)))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |newObjs| |newArrs|))))) 

(SDEFUN |DGRPH;coerce;Pg$;34| ((|pg| (|PermutationGroup| S)) ($ ($)))
        (SPADCALL (SPADCALL |pg| (QREFELT $ 103)) (QREFELT $ 46))) 

(SDEFUN |DGRPH;coerce;Fp$;35| ((|poset| (|FinitePoset| S)) ($ ($)))
        (SPADCALL |poset| (QREFELT $ 29))) 

(SDEFUN |DGRPH;coerce;L$;36| ((|lst| (|List| S)) ($ ($)))
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
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|o|
           (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))
          (#2=#:G1324 NIL) (|ob| NIL) (#3=#:G1325 NIL) (|obn| NIL))
         (SEQ (LETT |obs| NIL) (LETT |ars| NIL) (LETT |arn| 1)
              (SEQ (LETT |obn| 1) (LETT #3# (LENGTH |lst|)) (LETT |ob| NIL)
                   (LETT #2# |lst|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |ob| (CAR #2#)) NIL)
                         (|greater_SI| |obn| #3#))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (VECTOR |ob|
                                  (SPADCALL (LENGTH |lst|) |obn| (QREFELT $ 9))
                                  (SPADCALL (LENGTH |lst|) |obn|
                                            (QREFELT $ 10))))
                    (LETT |obs| (SPADCALL |obs| |o| (QREFELT $ 13)))
                    (LETT |next| (+ |obn| 1))
                    (EXIT
                     (COND
                      ((<= |next| (LENGTH |lst|))
                       (SEQ
                        (LETT |a|
                              (VECTOR (STRCONC "a" (STRINGIMAGE |arn|)) 0 |obn|
                                      |next| 0 0 NIL))
                        (LETT |ars| (SPADCALL |ars| |a| (QREFELT $ 20)))
                        (EXIT (LETT |arn| (+ |arn| 1))))))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |obn| (|inc_SI| |obn|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |obs| |ars|))))) 

(DECLAIM (NOTINLINE |DirectedGraph;|)) 

(DEFUN |DirectedGraph| (#1=#:G1328)
  (SPROG NIL
         (PROG (#2=#:G1329)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DirectedGraph|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|DirectedGraph;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|DirectedGraph|)))))))))) 

(DEFUN |DirectedGraph;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DirectedGraph| DV$1))
          (LETT $ (GETREFV 117))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DirectedGraph| (LIST DV$1)
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

(MAKEPROP '|DirectedGraph| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|NonNegativeInteger|) (0 . |createX|) (6 . |createY|)
              (|Record| (|:| |value| 6) (|:| |posX| 8) (|:| |posY| 8))
              (|List| 11) (12 . |concat|) (|List| 6) |DGRPH;directedGraph;L$;1|
              |DGRPH;directedGraph;L$;2|
              (|Record| (|:| |name| 52) (|:| |arrType| 8) (|:| |fromOb| 8)
                        (|:| |toOb| 8) (|:| |xOffset| 31) (|:| |yOffset| 31)
                        (|:| |map| 30))
              (|List| 17) |DGRPH;directedGraph;LL$;3| (18 . |concat|)
              (|Record| (|:| |fromOb| 8) (|:| |toOb| 8)) (|List| 21)
              |DGRPH;directedGraph;LL$;4| (|FinitePoset| 6) (24 . |getVert|)
              (|List| (|List| 47)) (29 . |getArr|) (34 . |concat|)
              |DGRPH;directedGraph;Fp$;5| (|List| 8) (|Integer|) (|List| 30)
              (40 . |elt|) (46 . |#|) (51 . |elt|) |DGRPH;directedGraph;LL$;6|
              (|Record| (|:| |preimage| 14) (|:| |image| 14)) (|Permutation| 6)
              (57 . |listRepresentation|) (62 . |One|) (66 . |position|)
              (72 . |concat|) (78 . |elt|) (84 . |setelt!|) (|List| 38)
              |DGRPH;directedGraph;L$;7| (|Boolean|) (91 . =)
              |DGRPH;addObject!;$S$;8| |DGRPH;addObject!;$R$;9|
              |DGRPH;addArrow!;$R$;10| (|String|) |DGRPH;addArrow!;$S2Nni$;11|
              |DGRPH;addArrow!;$S2NniL$;12| |DGRPH;getVertices;$L;13|
              |DGRPH;getArrows;$L;14|
              (|Record| (|:| |value| $$) (|:| |posX| 8) (|:| |posY| 8))
              (|List| 57) (|DirectedGraph| $$) (97 . |getVertices|)
              (102 . |concat|) (|List| 18) (108 . |concat|) (114 . |concat|)
              (120 . |getArrows|) (|DirectedGraph| $) |DGRPH;flatten;Dg$;15|
              |DGRPH;initial;$;16| |DGRPH;terminal;S$;17|
              |DGRPH;cycleOpen;LS$;18| |DGRPH;cycleClosed;LS$;19|
              |DGRPH;unit;LS$;20| (125 . ~=) |DGRPH;kgraph;LS$;21|
              (131 . |concat|) |DGRPH;+;3$;22| (137 . |position|)
              |DGRPH;merge;3$;23| (143 . |diagramWidth|)
              (148 . |diagramHeight|) (|Product| 6 6) (153 . |construct|)
              (|Record| (|:| |value| 81) (|:| |posX| 8) (|:| |posY| 8))
              (|List| 83) (159 . |concat|) (165 . |isDirectSuccessor?|)
              (172 . |arrowName|) (|List| $) (179 . |concat|)
              (|DirectedGraph| 81) (184 . |directedGraph|) |DGRPH;*;2$Dg;26|
              |DGRPH;cartesian;2$Dg;27| (|Mapping| 6 6 6)
              |DGRPH;closedTensor;2$M$;29| |DGRPH;closedCartesian;2$M$;30|
              |DGRPH;~;2$;31| (190 . |elt|) (196 . |setelt!|)
              |DGRPH;map;$LL2I$;32| |DGRPH;mapContra;$LL2I$;33|
              (|PermutationGroup| 6) (203 . |coerce|) |DGRPH;coerce;Pg$;34|
              |DGRPH;coerce;Fp$;35| |DGRPH;coerce;L$;36| (|Void|)
              (|Scene| (|SCartesian| '2)) (|Matrix| 31) (|Matrix| 8)
              (|List| (|Loop|)) (|List| 113) (|Tree| 31) (|SingleInteger|)
              (|HashState|) (|OutputForm|))
           '#(~= 208 ~ 214 |unit| 219 |terminal| 225 |subdiagramSvg| 230
              |spanningTreeNode| 238 |spanningTreeArrow| 244
              |spanningForestNode| 250 |spanningForestArrow| 255 |routeNodes|
              260 |routeArrows| 267 |outDegree| 274 |nodeToNode| 280
              |nodeToArrow| 286 |nodeFromNode| 292 |nodeFromArrow| 298 |min|
              304 |merge| 315 |max| 321 |mapContra| 332 |map| 341 |looseEquals|
              350 |loopsNodes| 356 |loopsAtNode| 361 |loopsArrows| 367 |latex|
              372 |laplacianMatrix| 377 |kgraph| 382 |isGreaterThan?| 388
              |isFunctional?| 395 |isFixPoint?| 400 |isDirected?| 406
              |isDirectSuccessor?| 410 |isAcyclic?| 417 |initial| 422
              |incidenceMatrix| 426 |inDegree| 431 |hashUpdate!| 437 |hash| 443
              |getVertices| 448 |getVertexIndex| 453 |getArrows| 459
              |getArrowIndex| 464 |flatten| 471 |distanceMatrix| 476 |distance|
              481 |directedGraph| 488 |diagramsSvg| 526 |diagramWidth| 533
              |diagramSvg| 538 |diagramHeight| 545 |deepDiagramSvg| 550
              |cycleOpen| 557 |cycleClosed| 563 |createY| 569 |createX| 575
              |createWidth| 581 |coerce| 586 |closedTensor| 606
              |closedCartesian| 613 |cartesian| 620 |arrowsToNode| 626
              |arrowsToArrow| 632 |arrowsFromNode| 638 |arrowsFromArrow| 644
              |arrowName| 650 |adjacencyMatrix| 657 |addObject!| 662
              |addArrow!| 674 = 705 + 711 * 717)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|FiniteGraph&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FiniteGraph| 6) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 116))
                        (|makeByteWordVec2| 116
                                            '(2 0 8 8 8 9 2 0 8 8 8 10 2 12 0 0
                                              11 13 2 18 0 0 17 20 1 24 14 0 25
                                              1 24 26 0 27 2 22 0 0 21 28 2 32
                                              30 0 31 33 1 30 8 0 34 2 30 8 0
                                              31 35 1 38 37 0 39 0 38 0 40 2 14
                                              31 6 0 41 2 14 0 0 6 42 2 14 6 0
                                              31 43 3 30 8 0 31 8 44 2 12 47 0
                                              0 48 1 59 58 0 60 2 12 0 0 0 61 2
                                              62 0 0 18 63 2 30 0 0 8 64 1 59
                                              18 0 65 2 8 47 0 0 73 2 18 0 0 0
                                              75 2 12 31 11 0 77 1 0 8 0 79 1 0
                                              8 0 80 2 81 0 6 6 82 2 84 0 0 83
                                              85 3 0 47 0 8 8 86 3 0 52 0 8 8
                                              87 1 52 0 88 89 2 90 0 84 18 91 2
                                              12 11 0 31 98 3 12 11 0 31 11 99
                                              1 102 45 0 103 2 0 47 0 0 1 1 0 0
                                              0 97 2 0 0 14 52 72 1 0 0 6 69 4
                                              0 107 108 0 47 47 1 2 0 113 0 8 1
                                              2 0 113 0 8 1 1 0 112 0 1 1 0 112
                                              0 1 3 0 30 0 8 8 1 3 0 30 0 8 8 1
                                              2 0 8 0 8 1 2 0 30 0 8 1 2 0 30 0
                                              8 1 2 0 30 0 8 1 2 0 30 0 8 1 2 0
                                              8 0 30 1 1 0 8 0 1 2 0 0 0 0 78 2
                                              0 8 0 30 1 1 0 8 0 1 5 0 0 0 30
                                              14 31 31 101 5 0 0 0 30 14 31 31
                                              100 2 0 47 0 0 1 1 0 111 0 1 2 0
                                              111 0 8 1 1 0 111 0 1 1 0 52 0 1
                                              1 0 109 0 1 2 0 0 14 52 74 3 0 47
                                              0 8 8 1 1 0 47 0 1 2 0 47 0 8 1 0
                                              0 47 1 3 0 47 0 8 8 86 1 0 47 0 1
                                              0 0 0 68 1 0 109 0 1 2 0 8 0 8 1
                                              2 0 115 115 0 1 1 0 114 0 1 1 0
                                              12 0 55 2 0 8 0 6 1 1 0 18 0 56 3
                                              0 8 0 8 8 1 1 0 0 66 67 1 0 109 0
                                              1 3 0 31 0 8 8 1 1 0 0 45 46 1 0
                                              0 24 29 2 0 0 14 22 23 2 0 0 14
                                              32 36 2 0 0 12 18 19 1 0 0 14 15
                                              1 0 0 12 16 3 0 107 52 88 47 1 1
                                              0 8 0 79 3 0 107 52 0 47 1 1 0 8
                                              0 80 3 0 107 52 0 47 1 2 0 0 14
                                              52 70 2 0 0 14 52 71 2 0 8 8 8 10
                                              2 0 8 8 8 9 1 0 8 8 1 1 0 0 24
                                              105 1 0 0 14 106 1 0 0 102 104 1
                                              0 116 0 1 3 0 0 0 0 94 95 3 0 0 0
                                              0 94 96 2 0 90 0 0 93 2 0 30 0 8
                                              1 2 0 30 0 8 1 2 0 30 0 8 1 2 0
                                              30 0 8 1 3 0 52 0 8 8 87 1 0 110
                                              0 1 2 0 0 0 6 49 2 0 0 0 11 50 4
                                              0 0 0 52 6 6 1 4 0 0 0 52 8 8 53
                                              5 0 0 0 52 8 8 30 54 2 0 0 0 17
                                              51 2 0 47 0 0 1 2 0 0 0 0 76 2 0
                                              90 0 0 92)))))
           '|lookupComplete|)) 
