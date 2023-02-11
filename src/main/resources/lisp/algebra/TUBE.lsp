
(PUT '|TUBE;getCurve;$Curve;1| '|SPADreplace| '(XLAM (|plot|) (QVELT |plot| 0))) 

(SDEFUN |TUBE;getCurve;$Curve;1| ((|plot| ($)) ($ (|Curve|))) (QVELT |plot| 0)) 

(PUT '|TUBE;listLoops;$L;2| '|SPADreplace| '(XLAM (|plot|) (QVELT |plot| 1))) 

(SDEFUN |TUBE;listLoops;$L;2|
        ((|plot| ($)) ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (QVELT |plot| 1)) 

(PUT '|TUBE;closed?;$B;3| '|SPADreplace| '(XLAM (|plot|) (QVELT |plot| 2))) 

(SDEFUN |TUBE;closed?;$B;3| ((|plot| ($)) ($ (|Boolean|))) (QVELT |plot| 2)) 

(SDEFUN |TUBE;open?;$B;4| ((|plot| ($)) ($ (|Boolean|)))
        (NULL (QVELT |plot| 2))) 

(PUT '|TUBE;setClosed;$2B;5| '|SPADreplace|
     '(XLAM (|plot| |flag|) (QSETVELT |plot| 2 |flag|))) 

(SDEFUN |TUBE;setClosed;$2B;5|
        ((|plot| ($)) (|flag| (|Boolean|)) ($ (|Boolean|)))
        (QSETVELT |plot| 2 |flag|)) 

(PUT '|TUBE;tube;CurveLB$;6| '|SPADreplace| 'VECTOR) 

(SDEFUN |TUBE;tube;CurveLB$;6|
        ((|curve| (|Curve|)) (|ll| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|b| (|Boolean|)) ($ ($)))
        (VECTOR |curve| |ll| |b|)) 

(DECLAIM (NOTINLINE |TubePlot;|)) 

(DEFUN |TubePlot| (#1=#:G706)
  (SPROG NIL
         (PROG (#2=#:G707)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TubePlot|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|TubePlot;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|TubePlot|)))))))))) 

(DEFUN |TubePlot;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TubePlot| DV$1))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TubePlot| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |parCurve| |#1|)
                              (|:| |loops|
                                   (|List| (|List| (|Point| (|DoubleFloat|)))))
                              (|:| |closedTube?| (|Boolean|))))
          $))) 

(MAKEPROP '|TubePlot| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              |TUBE;getCurve;$Curve;1|
              (|List| (|List| (|Point| (|DoubleFloat|)))) |TUBE;listLoops;$L;2|
              (|Boolean|) |TUBE;closed?;$B;3| |TUBE;open?;$B;4|
              |TUBE;setClosed;$2B;5| |TUBE;tube;CurveLB$;6|)
           '#(|tube| 0 |setClosed| 7 |open?| 13 |listLoops| 18 |getCurve| 23
              |closed?| 28)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|getCurve| (|#1| $$)) T)
                                   '((|listLoops|
                                      ((|List|
                                        (|List| (|Point| (|DoubleFloat|))))
                                       $$))
                                     T)
                                   '((|closed?| ((|Boolean|) $$)) T)
                                   '((|open?| ((|Boolean|) $$)) T)
                                   '((|setClosed| ((|Boolean|) $$ (|Boolean|)))
                                     T)
                                   '((|tube|
                                      ($$ |#1|
                                       (|List|
                                        (|List| (|Point| (|DoubleFloat|))))
                                       (|Boolean|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(3 0 0 6 9 11 15 2 0 11 0 11 14 1
                                              0 11 0 13 1 0 9 0 10 1 0 6 0 8 1
                                              0 11 0 12)))))
           '|lookupComplete|)) 
