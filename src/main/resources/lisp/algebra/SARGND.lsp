
(PUT '|SARGND;spnt;2Df$;1| '|SPADreplace| 'CONS) 

(SDEFUN |SARGND;spnt;2Df$;1| ((|a| #1=(|DoubleFloat|)) (|b| #1#) ($ ($)))
        (CONS |a| |b|)) 

(PUT '|SARGND;spnt;3Df$;2| '|SPADreplace| '(XLAM (|a| |b| |c|) (CONS |a| |b|))) 

(SDEFUN |SARGND;spnt;3Df$;2|
        ((|a| #1=(|DoubleFloat|)) (|b| #1#) (|c| #1#) ($ ($))) (CONS |a| |b|)) 

(PUT '|SARGND;svec;2Df$;3| '|SPADreplace| 'CONS) 

(SDEFUN |SARGND;svec;2Df$;3| ((|a| #1=(|DoubleFloat|)) (|b| #1#) ($ ($)))
        (CONS |a| |b|)) 

(PUT '|SARGND;svec;3Df$;4| '|SPADreplace| '(XLAM (|a| |b| |c|) (CONS |a| |b|))) 

(SDEFUN |SARGND;svec;3Df$;4|
        ((|a| #1=(|DoubleFloat|)) (|b| #1#) (|c| #1#) ($ ($))) (CONS |a| |b|)) 

(SDEFUN |SARGND;min;3$;5| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|im| #1=(|DoubleFloat|)) (|re| #1#))
               (SEQ (LETT |re| (|min_DF| (QCAR |a|) (QCAR |b|)))
                    (LETT |im| (|min_DF| (QCDR |a|) (QCDR |b|)))
                    (EXIT (CONS |re| |im|))))) 

(SDEFUN |SARGND;max;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|im| #1=(|DoubleFloat|)) (|re| #1#))
               (SEQ (LETT |re| (|max_DF| (QCAR |a|) (QCAR |b|)))
                    (LETT |im| (|max_DF| (QCDR |a|) (QCDR |b|)))
                    (EXIT (CONS |re| |im|))))) 

(PUT '|SARGND;dimension;$Pi;7| '|SPADreplace| '(XLAM (|p|) 2)) 

(SDEFUN |SARGND;dimension;$Pi;7| ((|p| ($)) ($ (|PositiveInteger|))) 2) 

(SDEFUN |SARGND;nan?| ((|x| (|DoubleFloat|)) ($ (|Boolean|)))
        (SPADCALL |x| |x| (QREFELT $ 17))) 

(SDEFUN |SARGND;Pnan?;$B;9| ((|p| ($)) ($ (|Boolean|)))
        (COND
         ((OR (|SARGND;nan?| (QCAR |p|) $) (|SARGND;nan?| (QCDR |p|) $)) 'T)
         ('T NIL))) 

(SDEFUN |SARGND;unitVector;2$;10| ((|p| ($)) ($ ($)))
        (SPROG ((|factor| (|DoubleFloat|)))
               (SEQ
                (LETT |factor|
                      (SPADCALL
                       (|add_DF| (|mul_DF| (QCAR |p|) (QCAR |p|))
                                 (|mul_DF| (QCDR |p|) (QCDR |p|)))
                       (QREFELT $ 19)))
                (EXIT
                 (CONS (|div_DF| (QCAR |p|) |factor|)
                       (|div_DF| (QCDR |p|) |factor|)))))) 

(SDEFUN |SARGND;distanceSquared;2$Df;11|
        ((|p1| ($)) (|p2| ($)) ($ (|DoubleFloat|)))
        (|add_DF| (|expt_DF_I| (|sub_DF| (QCAR |p1|) (QCAR |p2|)) 2)
                  (|expt_DF_I| (|sub_DF| (QCDR |p1|) (QCDR |p2|)) 2))) 

(SDEFUN |SARGND;parallel;2$Df;12| ((|x| ($)) (|y| ($)) ($ (|DoubleFloat|)))
        (|add_DF| (|mul_DF| (QCAR |x|) (QCAR |y|))
                  (|mul_DF| (QCDR |x|) (QCDR |y|)))) 

(PUT '|SARGND;perpendicular;3$;13| '|SPADreplace|
     '(XLAM (|x| |y|) (CONS 0.0 1.0))) 

(SDEFUN |SARGND;perpendicular;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS 0.0 1.0)) 

(SDEFUN |SARGND;*;Df2$;14| ((|s| (|DoubleFloat|)) (|x| ($)) ($ ($)))
        (CONS (|mul_DF| (QCAR |x|) |s|) (|mul_DF| (QCDR |x|) |s|))) 

(SDEFUN |SARGND;+;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (|add_DF| (QCAR |x|) (QCAR |y|))
              (|add_DF| (QCDR |x|) (QCDR |y|)))) 

(SDEFUN |SARGND;-;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (|sub_DF| (QCAR |x|) (QCAR |y|))
              (|sub_DF| (QCDR |x|) (QCDR |y|)))) 

(SDEFUN |SARGND;inBounds?;3$B;17|
        ((|pt| ($)) (|mns| ($)) (|mxs| ($)) ($ (|Boolean|)))
        (COND
         ((OR (|less_DF| (QCAR |pt|) (QCAR |mns|))
              (OR (SPADCALL (QCAR |pt|) (QCAR |mxs|) (QREFELT $ 27))
                  (|less_DF| (QCDR |pt|) (QCDR |mns|))))
          NIL)
         ('T (NULL (SPADCALL (QCDR |pt|) (QCDR |mxs|) (QREFELT $ 27)))))) 

(PUT '|SARGND;screenCoordX;$Df;18| '|SPADreplace| 'QCAR) 

(SDEFUN |SARGND;screenCoordX;$Df;18| ((|pt| ($)) ($ (|DoubleFloat|)))
        (QCAR |pt|)) 

(PUT '|SARGND;screenCoordY;$Df;19| '|SPADreplace| 'QCDR) 

(SDEFUN |SARGND;screenCoordY;$Df;19| ((|pt| ($)) ($ (|DoubleFloat|)))
        (QCDR |pt|)) 

(PUT '|SARGND;screenCoordZ;$Df;20| '|SPADreplace| '(XLAM (|pt|) 0.0)) 

(SDEFUN |SARGND;screenCoordZ;$Df;20| ((|pt| ($)) ($ (|DoubleFloat|))) 0.0) 

(SDEFUN |SARGND;screenCoords;$L;21| ((|pt| ($)) ($ (|List| (|DoubleFloat|))))
        (LIST (QCAR |pt|) (QCDR |pt|))) 

(SDEFUN |SARGND;extendedCoords;$L;22| ((|pt| ($)) ($ (|List| (|DoubleFloat|))))
        (LIST (QCAR |pt|) (QCDR |pt|))) 

(SDEFUN |SARGND;toPoint;2$;23| ((|p| ($)) ($ ($))) (CONS (QCAR |p|) (QCDR |p|))) 

(SDEFUN |SARGND;toVector;2$;24| ((|p| ($)) ($ ($)))
        (CONS (QCAR |p|) (QCDR |p|))) 

(PUT '|SARGND;isPoint?;$B;25| '|SPADreplace| '(XLAM (|p|) 'T)) 

(SDEFUN |SARGND;isPoint?;$B;25| ((|p| ($)) ($ (|Boolean|))) 'T) 

(PUT '|SARGND;isVector?;$B;26| '|SPADreplace| '(XLAM (|p|) 'T)) 

(SDEFUN |SARGND;isVector?;$B;26| ((|p| ($)) ($ (|Boolean|))) 'T) 

(SDEFUN |SARGND;coerce;$C;27| ((|me| ($)) ($ (|Complex| (|DoubleFloat|))))
        (SPADCALL (QCAR |me|) (QCDR |me|) (QREFELT $ 40))) 

(SDEFUN |SARGND;coerce;C$;28| ((|cmpx| (|Complex| (|DoubleFloat|))) ($ ($)))
        (CONS (SPADCALL |cmpx| (QREFELT $ 42))
              (SPADCALL |cmpx| (QREFELT $ 43)))) 

(PUT '|SARGND;hash;$Si;29| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |SARGND;hash;$Si;29| ((|s| ($)) ($ (|SingleInteger|))) 0) 

(SDEFUN |SARGND;=;2$B;30| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G767 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 17))
                    (PROGN (LETT #1# NIL) (GO #2=#:G766))))
                  (COND
                   ((SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 17))
                    (PROGN (LETT #1# NIL) (GO #2#))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |SARGND;~=;2$B;31| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 47)))) 

(SDEFUN |SARGND;coerce;$Of;32| ((|pt| ($)) ($ (|OutputForm|)))
        (COND
         ((|less_DF| (QCDR |pt|) 0.0)
          (SPADCALL (SPADCALL (QCAR |pt|) (QREFELT $ 50))
                    (SPADCALL (SPADCALL '|%i| (QREFELT $ 52))
                              (SPADCALL (|minus_DF| (QCDR |pt|))
                                        (QREFELT $ 50))
                              (QREFELT $ 53))
                    (QREFELT $ 54)))
         ('T
          (SPADCALL (SPADCALL (QCAR |pt|) (QREFELT $ 50))
                    (SPADCALL (SPADCALL '|%i| (QREFELT $ 52))
                              (SPADCALL (QCDR |pt|) (QREFELT $ 50))
                              (QREFELT $ 53))
                    (QREFELT $ 55))))) 

(DECLAIM (NOTINLINE |SArgand;|)) 

(DEFUN |SArgand| ()
  (SPROG NIL
         (PROG (#1=#:G777)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|SArgand|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|SArgand|
                             (LIST (CONS NIL (CONS 1 (|SArgand;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|SArgand|)))))))))) 

(DEFUN |SArgand;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SArgand|))
          (LETT $ (GETREFV 60))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SArgand| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |r| (|DoubleFloat|))
                              (|:| |i| (|DoubleFloat|))))
          $))) 

(MAKEPROP '|SArgand| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|DoubleFloat|)
              |SARGND;spnt;2Df$;1| |SARGND;spnt;3Df$;2| |SARGND;svec;2Df$;3|
              |SARGND;svec;3Df$;4| |SARGND;min;3$;5| |SARGND;max;3$;6|
              (|PositiveInteger|) |SARGND;dimension;$Pi;7| (|Boolean|) (0 . ~=)
              |SARGND;Pnan?;$B;9| (6 . |sqrt|) |SARGND;unitVector;2$;10|
              |SARGND;distanceSquared;2$Df;11| |SARGND;parallel;2$Df;12|
              |SARGND;perpendicular;3$;13| |SARGND;*;Df2$;14| |SARGND;+;3$;15|
              |SARGND;-;3$;16| (11 . >) |SARGND;inBounds?;3$B;17|
              |SARGND;screenCoordX;$Df;18| |SARGND;screenCoordY;$Df;19|
              |SARGND;screenCoordZ;$Df;20| (|List| 7)
              |SARGND;screenCoords;$L;21| |SARGND;extendedCoords;$L;22|
              |SARGND;toPoint;2$;23| |SARGND;toVector;2$;24|
              |SARGND;isPoint?;$B;25| |SARGND;isVector?;$B;26| (|Complex| 7)
              (17 . |complex|) |SARGND;coerce;$C;27| (23 . |real|)
              (28 . |imag|) |SARGND;coerce;C$;28| (|SingleInteger|)
              |SARGND;hash;$Si;29| |SARGND;=;2$B;30| |SARGND;~=;2$B;31|
              (|OutputForm|) (33 . |coerce|) (|Symbol|) (38 . |coerce|)
              (43 . |hconcat|) (49 . -) (55 . +) |SARGND;coerce;$Of;32|
              (|Integer|) (|String|) (|HashState|))
           '#(~= 61 |unitVector| 67 |toVector| 72 |toPoint| 77 |svec| 82 |spnt|
              95 |sivec| 108 |sipnt| 121 |screenCoords| 134 |screenCoordZ| 139
              |screenCoordY| 144 |screenCoordX| 149 |perpendicular| 154
              |parallel| 160 |min| 166 |max| 172 |latex| 178 |isVector?| 183
              |isPoint?| 188 |inBounds?| 193 |hashUpdate!| 200 |hash| 206
              |extendedCoords| 211 |distanceSquared| 216 |distance| 222
              |dimension| 228 |colinearity| 233 |coerce| 239 |Pnan?| 254 = 259
              - 265 + 271 * 277)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|SPointCategory&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SPointCategory|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 49))
                        (|makeByteWordVec2| 59
                                            '(2 7 16 0 0 17 1 7 0 0 19 2 7 16 0
                                              0 27 2 39 0 7 7 40 1 39 7 0 42 1
                                              39 7 0 43 1 7 49 0 50 1 51 49 0
                                              52 2 49 0 0 0 53 2 49 0 0 0 54 2
                                              49 0 0 0 55 2 0 16 0 0 48 1 0 0 0
                                              20 1 0 0 0 36 1 0 0 0 35 3 0 0 7
                                              7 7 11 2 0 0 7 7 10 3 0 0 7 7 7 9
                                              2 0 0 7 7 8 3 0 0 57 57 57 1 2 0
                                              0 57 57 1 3 0 0 57 57 57 1 2 0 0
                                              57 57 1 1 0 32 0 33 1 0 7 0 31 1
                                              0 7 0 30 1 0 7 0 29 2 0 0 0 0 23
                                              2 0 7 0 0 22 2 0 0 0 0 12 2 0 0 0
                                              0 13 1 0 58 0 1 1 0 16 0 38 1 0
                                              16 0 37 3 0 16 0 0 0 28 2 0 59 59
                                              0 1 1 0 45 0 46 1 0 32 0 34 2 0 7
                                              0 0 21 2 0 7 0 0 1 1 0 14 0 15 2
                                              0 7 0 0 1 1 0 39 0 41 1 0 0 39 44
                                              1 0 49 0 56 1 0 16 0 18 2 0 16 0
                                              0 47 2 0 0 0 0 26 2 0 0 0 0 25 2
                                              0 0 7 0 24)))))
           '|lookupComplete|)) 

(MAKEPROP '|SArgand| 'NILADIC T) 
