
(SDEFUN |PTPACK;xCoord;PR;1| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 1 (QREFELT $ 10))) 

(SDEFUN |PTPACK;yCoord;PR;2| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 2 (QREFELT $ 10))) 

(SDEFUN |PTPACK;zCoord;PR;3| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 3 (QREFELT $ 10))) 

(SDEFUN |PTPACK;rCoord;PR;4| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 1 (QREFELT $ 10))) 

(SDEFUN |PTPACK;thetaCoord;PR;5| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 2 (QREFELT $ 10))) 

(SDEFUN |PTPACK;phiCoord;PR;6| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 3 (QREFELT $ 10))) 

(SDEFUN |PTPACK;color;PR;7| ((|p| (|Point| R)) ($ (R)))
        (COND
         ((> (SPADCALL |p| (QREFELT $ 18)) 3) (SPADCALL |p| 4 (QREFELT $ 10)))
         ('T (SPADCALL |p| 3 (QREFELT $ 10))))) 

(SDEFUN |PTPACK;hue;PR;8| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 3 (QREFELT $ 10))) 

(SDEFUN |PTPACK;shade;PR;9| ((|p| (|Point| R)) ($ (R)))
        (SPADCALL |p| 4 (QREFELT $ 10))) 

(DECLAIM (NOTINLINE |PointPackage;|)) 

(DEFUN |PointPackage| (#1=#:G705)
  (SPROG NIL
         (PROG (#2=#:G706)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PointPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PointPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|PointPackage|)))))))))) 

(DEFUN |PointPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PointPackage| DV$1))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PointPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PointPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (|Integer|)
              (|Point| 6) (4 . |elt|) |PTPACK;xCoord;PR;1| |PTPACK;yCoord;PR;2|
              |PTPACK;zCoord;PR;3| |PTPACK;rCoord;PR;4|
              |PTPACK;thetaCoord;PR;5| |PTPACK;phiCoord;PR;6|
              (|NonNegativeInteger|) (10 . |#|) |PTPACK;color;PR;7|
              |PTPACK;hue;PR;8| |PTPACK;shade;PR;9|)
           '#(|zCoord| 15 |yCoord| 20 |xCoord| 25 |thetaCoord| 30 |shade| 35
              |rCoord| 40 |phiCoord| 45 |hue| 50 |color| 55)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|xCoord| (|#1| (|Point| |#1|))) T)
                                   '((|yCoord| (|#1| (|Point| |#1|))) T)
                                   '((|zCoord| (|#1| (|Point| |#1|))) T)
                                   '((|rCoord| (|#1| (|Point| |#1|))) T)
                                   '((|thetaCoord| (|#1| (|Point| |#1|))) T)
                                   '((|phiCoord| (|#1| (|Point| |#1|))) T)
                                   '((|color| (|#1| (|Point| |#1|))) T)
                                   '((|hue| (|#1| (|Point| |#1|))) T)
                                   '((|shade| (|#1| (|Point| |#1|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(0 6 0 7 2 9 6 0 8 10 1 9 17 0 18
                                              1 0 6 9 13 1 0 6 9 12 1 0 6 9 11
                                              1 0 6 9 15 1 0 6 9 21 1 0 6 9 14
                                              1 0 6 9 16 1 0 6 9 20 1 0 6 9
                                              19)))))
           '|lookupComplete|)) 
