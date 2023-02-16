
(SDEFUN |SCONF;spnt;2Df$;1| ((|a| #1=(|DoubleFloat|)) (|b| #1#) ($ ($)))
        (SPROG ((|z| ($)) (|inf| (|DoubleFloat|)))
               (SEQ
                (LETT |inf|
                      (|mul_DF|
                       (|add_DF| (|mul_DF| |a| |a|) (|mul_DF| |b| |b|))
                       (|mk_DF| 5 -1)))
                (LETT |z| (MAKEARR1 (QREFELT $ 7) 0.0))
                (QSETAREF1 |z| 1 (|minus_DF| 1.0)) (QSETAREF1 |z| 2 |inf|)
                (QSETAREF1 |z| 4 |a|) (QSETAREF1 |z| 8 |b|) (EXIT |z|)))) 

(SDEFUN |SCONF;spnt;3Df$;2|
        ((|a| #1=(|DoubleFloat|)) (|b| #1#) (|c| #1#) ($ ($)))
        (SPROG ((|z| ($)) (|inf| (|DoubleFloat|)))
               (SEQ
                (LETT |inf|
                      (|mul_DF|
                       (|add_DF|
                        (|add_DF| (|mul_DF| |a| |a|) (|mul_DF| |b| |b|))
                        (|mul_DF| |c| |c|))
                       (|mk_DF| 5 -1)))
                (LETT |z| (MAKEARR1 (QREFELT $ 7) 0.0))
                (QSETAREF1 |z| 1 (|minus_DF| 1.0)) (QSETAREF1 |z| 2 |inf|)
                (QSETAREF1 |z| 4 |a|) (QSETAREF1 |z| 8 |b|)
                (COND ((> (QREFELT $ 6) 2) (QSETAREF1 |z| 16 |c|)))
                (EXIT |z|)))) 

(SDEFUN |SCONF;svec;2Df$;3| ((|a| #1=(|DoubleFloat|)) (|b| #1#) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |z| 1 0.0) (QSETAREF1 |z| 2 0.0)
                    (QSETAREF1 |z| 4 |a|) (QSETAREF1 |z| 8 |b|) (EXIT |z|)))) 

(SDEFUN |SCONF;svec;3Df$;4|
        ((|a| #1=(|DoubleFloat|)) (|b| #1#) (|c| #1#) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |z| 1 0.0) (QSETAREF1 |z| 2 0.0)
                    (QSETAREF1 |z| 4 |a|) (QSETAREF1 |z| 8 |b|)
                    (COND ((> (QREFELT $ 6) 2) (QSETAREF1 |z| 16 |c|)))
                    (EXIT |z|)))) 

(SDEFUN |SCONF;min;3$;5| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |pt| 8 (|min_DF| (QAREF1 |a| 8) (QAREF1 |b| 8)))
                    (QSETAREF1 |pt| 4 (|min_DF| (QAREF1 |a| 4) (QAREF1 |b| 4)))
                    (QSETAREF1 |pt| 2
                               (|mul_DF|
                                (|add_DF|
                                 (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                                 (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                                (|mk_DF| 5 -1)))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(SDEFUN |SCONF;max;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |pt| 8 (|max_DF| (QAREF1 |a| 8) (QAREF1 |b| 8)))
                    (QSETAREF1 |pt| 4 (|max_DF| (QAREF1 |a| 4) (QAREF1 |b| 4)))
                    (QSETAREF1 |pt| 2
                               (|mul_DF|
                                (|add_DF|
                                 (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                                 (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                                (|mk_DF| 5 -1)))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(PUT '|SCONF;dimension;$Pi;7| '|SPADreplace| '(XLAM (|p|) 2)) 

(SDEFUN |SCONF;dimension;$Pi;7| ((|p| ($)) ($ (|PositiveInteger|))) 2) 

(SDEFUN |SCONF;nan?| ((|x| (|DoubleFloat|)) ($ (|Boolean|)))
        (SPADCALL |x| |x| (QREFELT $ 21))) 

(SDEFUN |SCONF;Pnan?;$B;9| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G736 NIL) (#2=#:G737 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 7) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((|SCONF;nan?| (QAREF1 |p| |i|) $)
                           (PROGN (LETT #1# 'T) (GO #3=#:G735))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |SCONF;unitVector;2$;10| ((|p| ($)) ($ ($)))
        (SPROG ((|pt| ($)) (|factor| (|DoubleFloat|)))
               (SEQ
                (LETT |factor|
                      (SPADCALL
                       (|add_DF| (|mul_DF| (QAREF1 |p| 4) (QAREF1 |p| 4))
                                 (|mul_DF| (QAREF1 |p| 8) (QAREF1 |p| 8)))
                       (QREFELT $ 23)))
                (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                (QSETAREF1 |pt| 4 (|div_DF| (QAREF1 |p| 4) |factor|))
                (QSETAREF1 |pt| 8 (|div_DF| (QAREF1 |p| 8) |factor|))
                (QSETAREF1 |pt| 2
                           (|mul_DF|
                            (|add_DF|
                             (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                             (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                            (|mk_DF| 5 -1)))
                (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(PUT '|SCONF;distanceSquared;2$Df;11| '|SPADreplace| '(XLAM (|p1| |p2|) 1.0)) 

(SDEFUN |SCONF;distanceSquared;2$Df;11|
        ((|p1| ($)) (|p2| ($)) ($ (|DoubleFloat|))) 1.0) 

(SDEFUN |SCONF;parallel;2$Df;12| ((|x| ($)) (|y| ($)) ($ (|DoubleFloat|)))
        (|add_DF| (|mul_DF| (QAREF1 |x| 6) (QAREF1 |y| 6))
                  (|mul_DF| (QAREF1 |x| 10) (QAREF1 |y| 10)))) 

(SDEFUN |SCONF;perpendicular;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |pt| 4 0.0) (QSETAREF1 |pt| 8 1.0)
                    (QSETAREF1 |pt| 2
                               (|mul_DF|
                                (|add_DF|
                                 (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                                 (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                                (|mk_DF| 5 -1)))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(SDEFUN |SCONF;*;Df2$;14| ((|s| (|DoubleFloat|)) (|x| ($)) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |pt| 4 (|mul_DF| (QAREF1 |x| 4) |s|))
                    (QSETAREF1 |pt| 8 (|mul_DF| (QAREF1 |x| 8) |s|))
                    (QSETAREF1 |pt| 2
                               (|mul_DF|
                                (|add_DF|
                                 (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                                 (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                                (|mk_DF| 5 -1)))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(SDEFUN |SCONF;+;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |pt| 4 (|add_DF| (QAREF1 |x| 4) (QAREF1 |y| 4)))
                    (QSETAREF1 |pt| 8 (|add_DF| (QAREF1 |x| 8) (QAREF1 |y| 8)))
                    (QSETAREF1 |pt| 2
                               (|mul_DF|
                                (|add_DF|
                                 (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                                 (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                                (|mk_DF| 5 -1)))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(SDEFUN |SCONF;-;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (QSETAREF1 |pt| 4 (|sub_DF| (QAREF1 |x| 4) (QAREF1 |y| 4)))
                    (QSETAREF1 |pt| 8 (|sub_DF| (QAREF1 |x| 8) (QAREF1 |y| 8)))
                    (QSETAREF1 |pt| 2
                               (|mul_DF|
                                (|add_DF|
                                 (|mul_DF| (QAREF1 |pt| 4) (QAREF1 |pt| 4))
                                 (|mul_DF| (QAREF1 |pt| 8) (QAREF1 |pt| 8)))
                                (|mk_DF| 5 -1)))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(SDEFUN |SCONF;inBounds?;3$B;17|
        ((|pt| ($)) (|mns| ($)) (|mxs| ($)) ($ (|Boolean|)))
        (COND
         ((OR (|less_DF| (QAREF1 |pt| 4) (QAREF1 |mns| 4))
              (OR (SPADCALL (QAREF1 |pt| 4) (QAREF1 |mxs| 4) (QREFELT $ 31))
                  (|less_DF| (QAREF1 |pt| 8) (QAREF1 |mns| 8))))
          NIL)
         ('T
          (NULL (SPADCALL (QAREF1 |pt| 8) (QAREF1 |mxs| 8) (QREFELT $ 31)))))) 

(PUT '|SCONF;screenCoordX;$Df;18| '|SPADreplace| '(XLAM (|pt|) (QAREF1 |pt| 4))) 

(SDEFUN |SCONF;screenCoordX;$Df;18| ((|pt| ($)) ($ (|DoubleFloat|)))
        (QAREF1 |pt| 4)) 

(PUT '|SCONF;screenCoordY;$Df;19| '|SPADreplace| '(XLAM (|pt|) (QAREF1 |pt| 8))) 

(SDEFUN |SCONF;screenCoordY;$Df;19| ((|pt| ($)) ($ (|DoubleFloat|)))
        (QAREF1 |pt| 8)) 

(SDEFUN |SCONF;screenCoordZ;$Df;20| ((|pt| ($)) ($ (|DoubleFloat|)))
        (COND ((> (QREFELT $ 6) 2) (QAREF1 |pt| 16)) ('T 0.0))) 

(SDEFUN |SCONF;screenCoords;$L;21| ((|pt| ($)) ($ (|List| (|DoubleFloat|))))
        (SPROG ((#1=#:G764 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((> (QREFELT $ 6) 2)
                    (PROGN
                     (LETT #1#
                           (LIST (QAREF1 |pt| 4) (QAREF1 |pt| 8)
                                 (QAREF1 |pt| 16)))
                     (GO #2=#:G763))))
                  (EXIT (LIST (QAREF1 |pt| 4) (QAREF1 |pt| 8)))))
                #2# (EXIT #1#)))) 

(SDEFUN |SCONF;extendedCoords;$L;22| ((|pt| ($)) ($ (|List| (|DoubleFloat|))))
        (SPADCALL |pt| (QREFELT $ 38))) 

(SDEFUN |SCONF;normalisePoint;2$;23| ((|pt| ($)) ($ ($)))
        (SPROG
         ((|infin| (|DoubleFloat|)) (|index| (|PositiveInteger|))
          (#1=#:G777 NIL) (|x| NIL) (|pt2| ($)) (#2=#:G776 NIL)
          (|scaleFactor| (|DoubleFloat|)))
         (SEQ
          (EXIT
           (SEQ (LETT |scaleFactor| (QAREF1 |pt| 1))
                (COND
                 ((|less_DF| |scaleFactor| (|mk_DF| 1 -2))
                  (COND
                   ((SPADCALL |scaleFactor| (|minus_DF| (|mk_DF| 1 -2))
                              (QREFELT $ 31))
                    (SEQ
                     (SPADCALL
                      (SPADCALL "can't apply normalisePoint to a vector"
                                (QREFELT $ 42))
                      (QREFELT $ 44))
                     (EXIT (PROGN (LETT #2# |pt|) (GO #3=#:G775))))))))
                (COND
                 ((|less_DF| |scaleFactor| (|minus_DF| (|mk_DF| 99 -2)))
                  (COND
                   ((SPADCALL |scaleFactor| (|minus_DF| (|mk_DF| 101 -2))
                              (QREFELT $ 31))
                    (PROGN (LETT #2# |pt|) (GO #3#))))))
                (LETT |pt2| (MAKEARR1 (QREFELT $ 7) 0.0)) (LETT |infin| 0.0)
                (SEQ (LETT |x| 1) (LETT #1# (QREFELT $ 6)) G190
                     (COND ((|greater_SI| |x| #1#) (GO G191)))
                     (SEQ (LETT |index| (EXPT 2 (+ |x| 1)))
                          (QSETAREF1 |pt2| |index|
                                     (|div_DF| (QAREF1 |pt| |index|)
                                               (|minus_DF| |scaleFactor|)))
                          (EXIT
                           (LETT |infin|
                                 (|add_DF| |infin|
                                           (|mul_DF|
                                            (|mul_DF| (QAREF1 |pt2| |index|)
                                                      (QAREF1 |pt2| |index|))
                                            (|mk_DF| 5 -1))))))
                     (LETT |x| (|inc_SI| |x|)) (GO G190) G191 (EXIT NIL))
                (QSETAREF1 |pt2| 1 (|minus_DF| 1.0))
                (QSETAREF1 |pt2| 2 |infin|) (EXIT |pt2|)))
          #3# (EXIT #2#)))) 

(SDEFUN |SCONF;toPoint;2$;24| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G782 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 7) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (EXIT (QSETAREF1 |pt| |i| (QAREF1 |p| |i|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| 1 (|minus_DF| 1.0)) (EXIT |pt|)))) 

(SDEFUN |SCONF;toVector;2$;25| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G787 NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (MAKEARR1 (QREFELT $ 7) 0.0))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 7) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (EXIT (QSETAREF1 |pt| |i| (QAREF1 |p| |i|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |pt| 1 0.0) (EXIT |pt|)))) 

(SDEFUN |SCONF;isPoint?;$B;26| ((|p| ($)) ($ (|Boolean|)))
        (|less_DF| (QAREF1 |p| 1) (|minus_DF| (|mk_DF| 1 -1)))) 

(SDEFUN |SCONF;isVector?;$B;27| ((|p| ($)) ($ (|Boolean|)))
        (SPADCALL (QAREF1 |p| 1) (|minus_DF| (|mk_DF| 9 -1)) (QREFELT $ 31))) 

(PUT '|SCONF;hash;$Si;28| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |SCONF;hash;$Si;28| ((|s| ($)) ($ (|SingleInteger|))) 0) 

(SDEFUN |SCONF;=;2$B;29| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G796 NIL) (#2=#:G797 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 7) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (QAREF1 |x| |i|) (QAREF1 |y| |i|)
                                     (QREFELT $ 21))
                           (PROGN (LETT #1# NIL) (GO #3=#:G795))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |SCONF;~=;2$B;30| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 52)))) 

(SDEFUN |SCONF;coerce;$Of;31| ((|pt| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|eles| (|List| (|OutputForm|))) (#1=#:G804 NIL) (|i| NIL)
          (#2=#:G803 NIL))
         (SEQ
          (LETT |eles|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 7) 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL (QAREF1 |pt| |i|) (QREFELT $ 54))
                                    #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL |eles| (QREFELT $ 56)))))) 

(DECLAIM (NOTINLINE |SConformal;|)) 

(DEFUN |SConformal| (#1=#:G805)
  (SPROG NIL
         (PROG (#2=#:G806)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SConformal|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|SConformal;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SConformal|)))))))))) 

(DEFUN |SConformal;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|SConformal| DV$1))
          (LETT $ (GETREFV 59))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SConformal| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (EXPT 2 (+ |#1| 2)))
          (QSETREFV $ 8 (|PrimitiveArray| (|DoubleFloat|)))
          $))) 

(MAKEPROP '|SConformal| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|dim| '|Rep|
              (|DoubleFloat|) |SCONF;spnt;2Df$;1| |SCONF;spnt;3Df$;2|
              |SCONF;svec;2Df$;3| |SCONF;svec;3Df$;4| |SCONF;min;3$;5|
              (|Integer|) (0 . |elt|) |SCONF;max;3$;6| (|PositiveInteger|)
              |SCONF;dimension;$Pi;7| (|Boolean|) (6 . ~=) |SCONF;Pnan?;$B;9|
              (12 . |sqrt|) |SCONF;unitVector;2$;10|
              |SCONF;distanceSquared;2$Df;11| |SCONF;parallel;2$Df;12|
              |SCONF;perpendicular;3$;13| |SCONF;*;Df2$;14| |SCONF;+;3$;15|
              |SCONF;-;3$;16| (17 . >) |SCONF;inBounds?;3$B;17|
              |SCONF;screenCoordX;$Df;18| |SCONF;screenCoordY;$Df;19|
              |SCONF;screenCoordZ;$Df;20| (|List| 9) |SCONF;screenCoords;$L;21|
              (23 . |entries|) |SCONF;extendedCoords;$L;22| (|String|)
              (|OutputForm|) (28 . |message|) (|Void|) (33 . |print|)
              |SCONF;normalisePoint;2$;23| |SCONF;toPoint;2$;24|
              |SCONF;toVector;2$;25| |SCONF;isPoint?;$B;26|
              |SCONF;isVector?;$B;27| (|SingleInteger|) |SCONF;hash;$Si;28|
              |SCONF;=;2$B;29| |SCONF;~=;2$B;30| (38 . |coerce|) (|List| $)
              (43 . |paren|) |SCONF;coerce;$Of;31| (|HashState|))
           '#(~= 48 |unitVector| 54 |toVector| 59 |toPoint| 64 |svec| 69 |spnt|
              82 |sivec| 95 |sipnt| 108 |screenCoords| 121 |screenCoordZ| 126
              |screenCoordY| 131 |screenCoordX| 136 |perpendicular| 141
              |parallel| 147 |normalisePoint| 153 |min| 158 |max| 164 |latex|
              170 |isVector?| 175 |isPoint?| 180 |inBounds?| 185 |hashUpdate!|
              192 |hash| 198 |extendedCoords| 203 |distanceSquared| 208
              |distance| 214 |dimension| 220 |colinearity| 225 |coerce| 231
              |Pnan?| 236 = 241 - 247 + 253 * 259)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|SPointCategory&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SPointCategory|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 41))
                        (|makeByteWordVec2| 58
                                            '(2 8 9 0 15 16 2 9 20 0 0 21 1 9 0
                                              0 23 2 9 20 0 0 31 1 8 36 0 38 1
                                              41 0 40 42 1 41 43 0 44 1 9 41 0
                                              54 1 41 0 55 56 2 0 20 0 0 53 1 0
                                              0 0 24 1 0 0 0 47 1 0 0 0 46 3 0
                                              0 9 9 9 13 2 0 0 9 9 12 3 0 0 9 9
                                              9 11 2 0 0 9 9 10 3 0 0 15 15 15
                                              1 2 0 0 15 15 1 3 0 0 15 15 15 1
                                              2 0 0 15 15 1 1 0 36 0 37 1 0 9 0
                                              35 1 0 9 0 34 1 0 9 0 33 2 0 0 0
                                              0 27 2 0 9 0 0 26 1 0 0 0 45 2 0
                                              0 0 0 14 2 0 0 0 0 17 1 0 40 0 1
                                              1 0 20 0 49 1 0 20 0 48 3 0 20 0
                                              0 0 32 2 0 58 58 0 1 1 0 50 0 51
                                              1 0 36 0 39 2 0 9 0 0 25 2 0 9 0
                                              0 1 1 0 18 0 19 2 0 9 0 0 1 1 0
                                              41 0 57 1 0 20 0 22 2 0 20 0 0 52
                                              2 0 0 0 0 30 2 0 0 0 0 29 2 0 0 9
                                              0 28)))))
           '|lookupComplete|)) 
