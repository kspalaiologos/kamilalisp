
(SDEFUN |VIEW;graphCurves;LGi;1|
        ((|listOfListsOfPoints| (|List| (|List| (|Point| (|DoubleFloat|)))))
         ($ (|GraphImage|)))
        (SPADCALL |listOfListsOfPoints| (SPADCALL (QREFELT $ 8))
                  (SPADCALL (QREFELT $ 9)) (SPADCALL (QREFELT $ 11)) NIL
                  (QREFELT $ 15))) 

(SDEFUN |VIEW;graphCurves;LLGi;2|
        ((|listOfListsOfPoints| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|optionsList| (|List| (|DrawOption|))) ($ (|GraphImage|)))
        (SPADCALL |listOfListsOfPoints| (SPADCALL (QREFELT $ 8))
                  (SPADCALL (QREFELT $ 9)) (SPADCALL (QREFELT $ 11))
                  |optionsList| (QREFELT $ 15))) 

(SDEFUN |VIEW;graphCurves;L2PPiLGi;3|
        ((|listOfListsOfPoints| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|ptColor| (|Palette|)) (|lineColor| (|Palette|))
         (|ptSize| (|PositiveInteger|)) (|optionsList| (|List| (|DrawOption|)))
         ($ (|GraphImage|)))
        (SPROG
         ((|listOfPointSizes| (|List| (|PositiveInteger|))) (#1=#:G718 NIL)
          (|i| NIL) (#2=#:G717 NIL) (|listOfLineColors| (|List| (|Palette|)))
          (#3=#:G716 NIL) (#4=#:G715 NIL)
          (|listOfPointColors| (|List| (|Palette|))) (#5=#:G714 NIL)
          (#6=#:G713 NIL) (|len| (|NonNegativeInteger|)))
         (SEQ (LETT |len| (LENGTH |listOfListsOfPoints|))
              (LETT |listOfPointColors|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |i| 1) (LETT #5# |len|) G190
                          (COND ((|greater_SI| |i| #5#) (GO G191)))
                          (SEQ (EXIT (LETT #6# (CONS |ptColor| #6#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (LETT |listOfLineColors|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |i| 1) (LETT #3# |len|) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ (EXIT (LETT #4# (CONS |lineColor| #4#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |listOfPointSizes|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 1) (LETT #1# |len|) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ (EXIT (LETT #2# (CONS |ptSize| #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (SPADCALL |listOfListsOfPoints| |listOfPointColors|
                         |listOfLineColors| |listOfPointSizes| |optionsList|
                         (QREFELT $ 20)))))) 

(SDEFUN |VIEW;drawCurves;LLTdv;4|
        ((|listOfListsOfPoints| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|optionsList| (|List| (|DrawOption|)))
         ($ (|TwoDimensionalViewport|)))
        (SPADCALL |listOfListsOfPoints| (SPADCALL (QREFELT $ 8))
                  (SPADCALL (QREFELT $ 9)) (SPADCALL (QREFELT $ 11))
                  |optionsList| (QREFELT $ 22))) 

(SDEFUN |VIEW;drawCurves;L2PPiLTdv;5|
        ((|ptLists| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|ptColor| (|Palette|)) (|lColor| (|Palette|))
         (|ptSize| (|PositiveInteger|)) (|optList| (|List| (|DrawOption|)))
         ($ (|TwoDimensionalViewport|)))
        (SPROG ((|g| (|GraphImage|)) (|v| (|TwoDimensionalViewport|)))
               (SEQ (LETT |v| (SPADCALL (QREFELT $ 24)))
                    (SPADCALL |v| |optList| (QREFELT $ 25))
                    (LETT |g|
                          (SPADCALL |ptLists| |ptColor| |lColor| |ptSize|
                                    |optList| (QREFELT $ 15)))
                    (SPADCALL |v| |g| 1 (QREFELT $ 27))
                    (EXIT (SPADCALL |v| (QREFELT $ 28)))))) 

(SDEFUN |VIEW;coerce;GiTdv;6|
        ((|graf| (|GraphImage|)) ($ (|TwoDimensionalViewport|)))
        (SPADCALL |graf| NIL (QREFELT $ 29))) 

(DECLAIM (NOTINLINE |ViewportPackage;|)) 

(DEFUN |ViewportPackage| ()
  (SPROG NIL
         (PROG (#1=#:G724)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ViewportPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ViewportPackage|
                             (LIST (CONS NIL (CONS 1 (|ViewportPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ViewportPackage|)))))))))) 

(DEFUN |ViewportPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ViewportPackage|))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ViewportPackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ViewportPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Palette|) (|ViewDefaultsPackage|)
              (0 . |pointColorDefault|) (4 . |lineColorDefault|)
              (|PositiveInteger|) (8 . |pointSizeDefault|) (|GraphImage|)
              (|List| (|List| (|Point| (|DoubleFloat|))))
              (|List| (|DrawOption|)) |VIEW;graphCurves;L2PPiLGi;3|
              |VIEW;graphCurves;LGi;1| |VIEW;graphCurves;LLGi;2| (|List| 6)
              (|List| 10) (12 . |makeGraphImage|) (|TwoDimensionalViewport|)
              |VIEW;drawCurves;L2PPiLTdv;5| |VIEW;drawCurves;LLTdv;4|
              (21 . |viewport2D|) (25 . |options|) (|Void|) (31 . |putGraph|)
              (38 . |makeViewport2D|) (43 . |makeViewport2D|)
              |VIEW;coerce;GiTdv;6|)
           '#(|graphCurves| 49 |drawCurves| 69 |coerce| 84) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|graphCurves|
                                 ((|GraphImage|)
                                  (|List| (|List| (|Point| (|DoubleFloat|))))
                                  (|Palette|) (|Palette|) (|PositiveInteger|)
                                  (|List| (|DrawOption|))))
                                T)
                              '((|graphCurves|
                                 ((|GraphImage|)
                                  (|List| (|List| (|Point| (|DoubleFloat|))))))
                                T)
                              '((|graphCurves|
                                 ((|GraphImage|)
                                  (|List| (|List| (|Point| (|DoubleFloat|))))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|drawCurves|
                                 ((|TwoDimensionalViewport|)
                                  (|List| (|List| (|Point| (|DoubleFloat|))))
                                  (|Palette|) (|Palette|) (|PositiveInteger|)
                                  (|List| (|DrawOption|))))
                                T)
                              '((|drawCurves|
                                 ((|TwoDimensionalViewport|)
                                  (|List| (|List| (|Point| (|DoubleFloat|))))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|coerce|
                                 ((|TwoDimensionalViewport|) (|GraphImage|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(0 7 6 8 0 7 6 9 0 7 10 11 5 12 0
                                              13 18 18 19 14 20 0 21 0 24 2 21
                                              0 0 14 25 3 21 26 0 12 10 27 1 21
                                              0 0 28 2 21 0 12 14 29 5 0 12 13
                                              6 6 10 14 15 2 0 12 13 14 17 1 0
                                              12 13 16 5 0 21 13 6 6 10 14 22 2
                                              0 21 13 14 23 1 0 21 12 30)))))
           '|lookupComplete|)) 

(MAKEPROP '|ViewportPackage| 'NILADIC T) 
