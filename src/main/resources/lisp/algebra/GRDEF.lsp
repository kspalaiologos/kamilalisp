
(SDEFUN |GRDEF;clipPointsDefault;B;1| (($ (|Boolean|))) (QREFELT $ 6)) 

(SDEFUN |GRDEF;drawToScale;B;2| (($ (|Boolean|))) (QREFELT $ 7)) 

(SDEFUN |GRDEF;clipPointsDefault;2B;3| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SETELT $ 6 |b|)) 

(SDEFUN |GRDEF;drawToScale;2B;4| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SETELT $ 7 |b|)) 

(SDEFUN |GRDEF;adaptive;B;5| (($ (|Boolean|))) (SPADCALL (QREFELT $ 14))) 

(SDEFUN |GRDEF;minPoints;I;6| (($ (|Integer|))) (SPADCALL (QREFELT $ 17))) 

(SDEFUN |GRDEF;maxPoints;I;7| (($ (|Integer|))) (SPADCALL (QREFELT $ 19))) 

(SDEFUN |GRDEF;screenResolution;I;8| (($ (|Integer|)))
        (SPADCALL (QREFELT $ 21))) 

(SDEFUN |GRDEF;adaptive;2B;9| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SPADCALL |b| (QREFELT $ 23))) 

(SDEFUN |GRDEF;minPoints;2I;10| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPADCALL |n| (QREFELT $ 25))) 

(SDEFUN |GRDEF;maxPoints;2I;11| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPADCALL |n| (QREFELT $ 27))) 

(SDEFUN |GRDEF;screenResolution;2I;12| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPADCALL |n| (QREFELT $ 29))) 

(DECLAIM (NOTINLINE |GraphicsDefaults;|)) 

(DEFUN |GraphicsDefaults| ()
  (SPROG NIL
         (PROG (#1=#:G705)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GraphicsDefaults|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GraphicsDefaults|
                             (LIST (CONS NIL (CONS 1 (|GraphicsDefaults;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|GraphicsDefaults|)))))))))) 

(DEFUN |GraphicsDefaults;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GraphicsDefaults|))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GraphicsDefaults| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 'T)
          (QSETREFV $ 7 NIL)
          $))) 

(MAKEPROP '|GraphicsDefaults| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL 'CLIPPOINTSDEFAULT 'TOSCALE (|Boolean|)
              |GRDEF;clipPointsDefault;B;1| |GRDEF;drawToScale;B;2|
              |GRDEF;clipPointsDefault;2B;3| |GRDEF;drawToScale;2B;4| (|Plot|)
              (0 . |adaptive?|) |GRDEF;adaptive;B;5| (|Integer|)
              (4 . |minPoints|) |GRDEF;minPoints;I;6| (8 . |maxPoints|)
              |GRDEF;maxPoints;I;7| (12 . |screenResolution|)
              |GRDEF;screenResolution;I;8| (16 . |setAdaptive|)
              |GRDEF;adaptive;2B;9| (21 . |setMinPoints|)
              |GRDEF;minPoints;2I;10| (26 . |setMaxPoints|)
              |GRDEF;maxPoints;2I;11| (31 . |setScreenResolution|)
              |GRDEF;screenResolution;2I;12|)
           '#(|screenResolution| 36 |minPoints| 45 |maxPoints| 54 |drawToScale|
              63 |clipPointsDefault| 72 |adaptive| 81)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|clipPointsDefault| ((|Boolean|))) T)
                                   '((|drawToScale| ((|Boolean|))) T)
                                   '((|clipPointsDefault|
                                      ((|Boolean|) (|Boolean|)))
                                     T)
                                   '((|drawToScale| ((|Boolean|) (|Boolean|)))
                                     T)
                                   '((|adaptive| ((|Boolean|))) T)
                                   '((|maxPoints| ((|Integer|))) T)
                                   '((|minPoints| ((|Integer|))) T)
                                   '((|screenResolution| ((|Integer|))) T)
                                   '((|adaptive| ((|Boolean|) (|Boolean|))) T)
                                   '((|maxPoints| ((|Integer|) (|Integer|))) T)
                                   '((|minPoints| ((|Integer|) (|Integer|))) T)
                                   '((|screenResolution|
                                      ((|Integer|) (|Integer|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(0 13 8 14 0 13 16 17 0 13 16 19 0
                                              13 16 21 1 13 8 8 23 1 13 16 16
                                              25 1 13 16 16 27 1 13 16 16 29 0
                                              0 16 22 1 0 16 16 30 0 0 16 18 1
                                              0 16 16 26 0 0 16 20 1 0 16 16 28
                                              0 0 8 10 1 0 8 8 12 0 0 8 9 1 0 8
                                              8 11 0 0 8 15 1 0 8 8 24)))))
           '|lookupComplete|)) 

(MAKEPROP '|GraphicsDefaults| 'NILADIC T) 
