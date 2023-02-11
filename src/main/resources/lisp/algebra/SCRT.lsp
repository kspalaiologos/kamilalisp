
(SDEFUN |SCRT;spnt;2Df$;1| ((|a| #1=(|DoubleFloat|)) (|b| #1#) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (QSETAREF1 |pt| 0 |a|) (QSETAREF1 |pt| 1 |b|)
                    (QSETAREF1 |pt| (QREFELT $ 6) 1.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;spnt;3Df$;2|
        ((|a| #1=(|DoubleFloat|)) (|b| #1#) (|c| #1#) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (QSETAREF1 |pt| 0 |a|) (QSETAREF1 |pt| 1 |b|)
                    (COND ((> (QREFELT $ 6) 2) (QSETAREF1 |pt| 2 |c|)))
                    (QSETAREF1 |pt| (QREFELT $ 6) 1.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;svec;2Df$;3| ((|a| #1=(|DoubleFloat|)) (|b| #1#) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (QSETAREF1 |pt| 0 |a|) (QSETAREF1 |pt| 1 |b|)
                    (QSETAREF1 |pt| (QREFELT $ 6) 0.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;svec;3Df$;4|
        ((|a| #1=(|DoubleFloat|)) (|b| #1#) (|c| #1#) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (QSETAREF1 |pt| 0 |a|) (QSETAREF1 |pt| 1 |b|)
                    (COND ((> (QREFELT $ 6) 2) (QSETAREF1 |pt| 2 |c|)))
                    (QSETAREF1 |pt| (QREFELT $ 6) 0.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;min;3$;5| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G719 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |pt| |i|
                                      (|min_DF| (QAREF1 |a| |i|)
                                                (QAREF1 |b| |i|)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6) 1.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;max;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G726 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |pt| |i|
                                      (|max_DF| (QAREF1 |a| |i|)
                                                (QAREF1 |b| |i|)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6) 1.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;dimension;$Pi;7| ((|p| ($)) ($ (|PositiveInteger|)))
        (+ (QREFELT $ 6) 1)) 

(SDEFUN |SCRT;nan?| ((|x| (|DoubleFloat|)) ($ (|Boolean|)))
        (SPADCALL |x| |x| (QREFELT $ 20))) 

(SDEFUN |SCRT;Pnan?;$B;9| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G734 NIL) (#2=#:G735 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 6) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((|SCRT;nan?| (QAREF1 |p| |i|) $)
                           (PROGN (LETT #1# 'T) (GO #3=#:G733))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |SCRT;parallel;2$Df;10| ((|x| ($)) (|y| ($)) ($ (|DoubleFloat|)))
        (|add_DF|
         (|add_DF| (|mul_DF| (QAREF1 |x| 0) (QAREF1 |y| 0))
                   (|mul_DF| (QAREF1 |x| 1) (QAREF1 |y| 1)))
         (|mul_DF| (QAREF1 |x| 2) (QAREF1 |y| 2)))) 

(SDEFUN |SCRT;unitVector;2$;11| ((|p| ($)) ($ ($)))
        (SPROG
         ((#1=#:G748 NIL) (|i| NIL) (|pt| ($)) (|factor| (|DoubleFloat|))
          (#2=#:G747 NIL))
         (SEQ (LETT |factor| 0.0)
              (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 6) 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |factor|
                           (|add_DF| |factor|
                                     (|mul_DF| (QAREF1 |p| |i|)
                                               (QAREF1 |p| |i|))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |factor| (SPADCALL |factor| (QREFELT $ 23)))
              (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
              (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 |pt| |i|
                                (|div_DF| (QAREF1 |p| |i|) |factor|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (QSETAREF1 |pt| (QREFELT $ 6) 0.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;distanceSquared;2$Df;12|
        ((|p1| ($)) (|p2| ($)) ($ (|DoubleFloat|)))
        (SPROG ((|factor| (|DoubleFloat|)) (#1=#:G753 NIL) (|i| NIL))
               (SEQ (LETT |factor| 0.0)
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |factor|
                                 (|add_DF| |factor|
                                           (|expt_DF_I|
                                            (|sub_DF| (QAREF1 |p1| |i|)
                                                      (QAREF1 |p2| |i|))
                                            2)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |factor|)))) 

(SDEFUN |SCRT;perpendicular;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G756 NIL) (|pt| ($)))
               (SEQ
                (EXIT
                 (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                      (COND
                       ((< (QREFELT $ 6) 3)
                        (PROGN
                         (LETT #1# (SPADCALL 0 0 (QREFELT $ 26)))
                         (GO #2=#:G755))))
                      (QSETAREF1 |pt| 0
                                 (|sub_DF|
                                  (|mul_DF| (QAREF1 |x| 1) (QAREF1 |y| 2))
                                  (|mul_DF| (QAREF1 |x| 2) (QAREF1 |y| 1))))
                      (QSETAREF1 |pt| 1
                                 (|sub_DF|
                                  (|mul_DF| (QAREF1 |x| 2) (QAREF1 |y| 0))
                                  (|mul_DF| (QAREF1 |x| 0) (QAREF1 |y| 2))))
                      (QSETAREF1 |pt| 2
                                 (|sub_DF|
                                  (|mul_DF| (QAREF1 |x| 0) (QAREF1 |y| 1))
                                  (|mul_DF| (QAREF1 |x| 1) (QAREF1 |y| 0))))
                      (QSETAREF1 |pt| (QREFELT $ 6) 0.0) (EXIT |pt|)))
                #2# (EXIT #1#)))) 

(SDEFUN |SCRT;*;Df2$;14| ((|s| (|DoubleFloat|)) (|x| ($)) ($ ($)))
        (SPROG ((#1=#:G761 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |pt| |i|
                                      (|mul_DF| (QAREF1 |x| |i|) |s|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6) (QAREF1 |x| (QREFELT $ 6)))
                    (EXIT |pt|)))) 

(SDEFUN |SCRT;+;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G767 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |pt| |i|
                                      (|add_DF| (QAREF1 |x| |i|)
                                                (QAREF1 |y| |i|)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6)
                               (|add_DF| (QAREF1 |x| (QREFELT $ 6))
                                         (QAREF1 |y| (QREFELT $ 6))))
                    (COND
                     ((SPADCALL (QAREF1 |pt| (QREFELT $ 6)) 1.0 (QREFELT $ 29))
                      (QSETAREF1 |pt| (QREFELT $ 6) 1.0)))
                    (EXIT |pt|)))) 

(SDEFUN |SCRT;-;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G773 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |pt| |i|
                                      (|sub_DF| (QAREF1 |x| |i|)
                                                (QAREF1 |y| |i|)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6)
                               (|add_DF| (QAREF1 |x| (QREFELT $ 6))
                                         (QAREF1 |y| (QREFELT $ 6))))
                    (COND
                     ((SPADCALL (QAREF1 |pt| (QREFELT $ 6)) 1.0 (QREFELT $ 29))
                      (QSETAREF1 |pt| (QREFELT $ 6) 0.0)))
                    (EXIT |pt|)))) 

(SDEFUN |SCRT;inBounds?;3$B;17|
        ((|pt| ($)) (|mns| ($)) (|mxs| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G780 NIL) (#2=#:G781 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 6) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (COND
                         ((|less_DF| (QAREF1 |pt| |i|) (QAREF1 |mns| |i|))
                          (PROGN (LETT #1# NIL) (GO #3=#:G779))))
                        (EXIT
                         (COND
                          ((SPADCALL (QAREF1 |pt| |i|) (QAREF1 |mxs| |i|)
                                     (QREFELT $ 29))
                           (PROGN (LETT #1# NIL) (GO #3#))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(PUT '|SCRT;screenCoordX;$Df;18| '|SPADreplace| '(XLAM (|pt|) (QAREF1 |pt| 0))) 

(SDEFUN |SCRT;screenCoordX;$Df;18| ((|pt| ($)) ($ (|DoubleFloat|)))
        (QAREF1 |pt| 0)) 

(PUT '|SCRT;screenCoordY;$Df;19| '|SPADreplace| '(XLAM (|pt|) (QAREF1 |pt| 1))) 

(SDEFUN |SCRT;screenCoordY;$Df;19| ((|pt| ($)) ($ (|DoubleFloat|)))
        (QAREF1 |pt| 1)) 

(SDEFUN |SCRT;screenCoordZ;$Df;20| ((|pt| ($)) ($ (|DoubleFloat|)))
        (COND ((> (QREFELT $ 6) 2) (QAREF1 |pt| 2)) ('T 0.0))) 

(SDEFUN |SCRT;screenCoords;$L;21| ((|pt| ($)) ($ (|List| (|DoubleFloat|))))
        (SPROG ((|res| (|List| (|DoubleFloat|))) (#1=#:G801 NIL) (|i| NIL))
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL |res| (QAREF1 |pt| |i|)
                                           (QREFELT $ 37)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |SCRT;extendedCoords;$L;22| ((|pt| ($)) ($ (|List| (|DoubleFloat|))))
        (SPADCALL |pt| (QREFELT $ 39))) 

(SDEFUN |SCRT;toPoint;2$;23| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G807 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (EXIT (QSETAREF1 |pt| |i| (QAREF1 |p| |i|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6) 1.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;toVector;2$;24| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G812 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (+ (QREFELT $ 6) 1) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (EXIT (QSETAREF1 |pt| |i| (QAREF1 |p| |i|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| (QREFELT $ 6) 0.0) (EXIT |pt|)))) 

(SDEFUN |SCRT;isPoint?;$B;25| ((|p| ($)) ($ (|Boolean|)))
        (SPADCALL (QAREF1 |p| (QREFELT $ 6)) (|mk_DF| 9 -1) (QREFELT $ 29))) 

(SDEFUN |SCRT;isVector?;$B;26| ((|p| ($)) ($ (|Boolean|)))
        (|less_DF| (QAREF1 |p| (QREFELT $ 6)) (|mk_DF| 1 -1))) 

(PUT '|SCRT;hash;$Si;27| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |SCRT;hash;$Si;27| ((|s| ($)) ($ (|SingleInteger|))) 0) 

(SDEFUN |SCRT;=;2$B;28| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G821 NIL) (#2=#:G822 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (+ (QREFELT $ 6) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (QAREF1 |x| |i|) (QAREF1 |y| |i|)
                                     (QREFELT $ 20))
                           (PROGN (LETT #1# NIL) (GO #3=#:G820))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |SCRT;~=;2$B;29| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 47)))) 

(SDEFUN |SCRT;coerce;$Of;30| ((|pt| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|eles| (|List| (|OutputForm|))) (#1=#:G836 NIL) (|i| NIL)
          (#2=#:G835 NIL) (|s| (|Symbol|)))
         (SEQ (LETT |s| '|proj|)
              (COND
               ((|eql_DF| (QAREF1 |pt| (QREFELT $ 6)) 0.0) (LETT |s| '|vec|)))
              (COND
               ((|eql_DF| (QAREF1 |pt| (QREFELT $ 6)) 1.0) (LETT |s| '|pt|)))
              (LETT |eles|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL (QAREF1 |pt| |i|) (QREFELT $ 50))
                                   #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (SPADCALL (SPADCALL |s| (QREFELT $ 52))
                         (SPADCALL |eles| (QREFELT $ 54)) (QREFELT $ 55)))))) 

(DECLAIM (NOTINLINE |SCartesian;|)) 

(DEFUN |SCartesian| (#1=#:G837)
  (SPROG NIL
         (PROG (#2=#:G838)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SCartesian|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|SCartesian;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SCartesian|)))))))))) 

(DEFUN |SCartesian;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|SCartesian| DV$1))
          (LETT $ (GETREFV 59))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SCartesian| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|PrimitiveArray| (|DoubleFloat|)))
          $))) 

(MAKEPROP '|SCartesian| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|DoubleFloat|)
              |SCRT;spnt;2Df$;1| |SCRT;spnt;3Df$;2| |SCRT;svec;2Df$;3|
              |SCRT;svec;3Df$;4| |SCRT;min;3$;5| (|Integer|) (0 . |elt|)
              |SCRT;max;3$;6| (|PositiveInteger|) |SCRT;dimension;$Pi;7|
              (|Boolean|) (6 . ~=) |SCRT;Pnan?;$B;9| |SCRT;parallel;2$Df;10|
              (12 . |sqrt|) |SCRT;unitVector;2$;11|
              |SCRT;distanceSquared;2$Df;12| (17 . |sipnt|)
              |SCRT;perpendicular;3$;13| |SCRT;*;Df2$;14| (23 . >)
              |SCRT;+;3$;15| |SCRT;-;3$;16| |SCRT;inBounds?;3$B;17|
              |SCRT;screenCoordX;$Df;18| |SCRT;screenCoordY;$Df;19|
              |SCRT;screenCoordZ;$Df;20| (|List| 8) (29 . |concat|)
              |SCRT;screenCoords;$L;21| (35 . |entries|)
              |SCRT;extendedCoords;$L;22| |SCRT;toPoint;2$;23|
              |SCRT;toVector;2$;24| |SCRT;isPoint?;$B;25|
              |SCRT;isVector?;$B;26| (|SingleInteger|) |SCRT;hash;$Si;27|
              |SCRT;=;2$B;28| |SCRT;~=;2$B;29| (|OutputForm|) (40 . |coerce|)
              (|Symbol|) (45 . |coerce|) (|List| $) (50 . |paren|)
              (55 . |hconcat|) |SCRT;coerce;$Of;30| (|String|) (|HashState|))
           '#(~= 61 |unitVector| 67 |toVector| 72 |toPoint| 77 |svec| 82 |spnt|
              95 |sivec| 108 |sipnt| 121 |screenCoords| 134 |screenCoordZ| 139
              |screenCoordY| 144 |screenCoordX| 149 |perpendicular| 154
              |parallel| 160 |min| 166 |max| 172 |latex| 178 |isVector?| 183
              |isPoint?| 188 |inBounds?| 193 |hashUpdate!| 200 |hash| 206
              |extendedCoords| 211 |distanceSquared| 216 |distance| 222
              |dimension| 228 |colinearity| 233 |coerce| 239 |Pnan?| 244 = 249
              - 255 + 261 * 267)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|SPointCategory&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SPointCategory|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 49))
                        (|makeByteWordVec2| 58
                                            '(2 7 8 0 14 15 2 8 19 0 0 20 1 8 0
                                              0 23 2 0 0 14 14 26 2 8 19 0 0 29
                                              2 36 0 0 8 37 1 7 36 0 39 1 8 49
                                              0 50 1 51 49 0 52 1 49 0 53 54 2
                                              49 0 0 0 55 2 0 19 0 0 48 1 0 0 0
                                              24 1 0 0 0 42 1 0 0 0 41 3 0 0 8
                                              8 8 12 2 0 0 8 8 11 3 0 0 8 8 8
                                              10 2 0 0 8 8 9 3 0 0 14 14 14 1 2
                                              0 0 14 14 1 3 0 0 14 14 14 1 2 0
                                              0 14 14 26 1 0 36 0 38 1 0 8 0 35
                                              1 0 8 0 34 1 0 8 0 33 2 0 0 0 0
                                              27 2 0 8 0 0 22 2 0 0 0 0 13 2 0
                                              0 0 0 16 1 0 57 0 1 1 0 19 0 44 1
                                              0 19 0 43 3 0 19 0 0 0 32 2 0 58
                                              58 0 1 1 0 45 0 46 1 0 36 0 40 2
                                              0 8 0 0 25 2 0 8 0 0 1 1 0 17 0
                                              18 2 0 8 0 0 1 1 0 49 0 56 1 0 19
                                              0 21 2 0 19 0 0 47 2 0 0 0 0 31 2
                                              0 0 0 0 30 2 0 0 8 0 28)))))
           '|lookupComplete|)) 
