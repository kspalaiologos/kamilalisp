
(SDEFUN |DRAW;makeObject;ExSbLGi;1|
        ((|f| (|Ex|)) (|bind| (|SegmentBinding| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|GraphImage|)))
        (SPADCALL (SPADCALL |f| (SPADCALL |bind| (QREFELT $ 9)) (QREFELT $ 12))
                  (SPADCALL |bind| (QREFELT $ 14)) |l| (QREFELT $ 18))) 

(SDEFUN |DRAW;maybe_add_title0|
        ((|f| (|Ex|)) (|l| (|List| (|DrawOption|))) (|s0| (|String|))
         ($ (|List| (|DrawOption|))))
        (SPROG ((|s| (|String|)))
               (SEQ
                (COND ((SPADCALL |l| '|title| (QREFELT $ 23)) |l|)
                      (#1='T
                       (SEQ
                        (LETT |s|
                              (SPADCALL (SPADCALL |f| (QREFELT $ 25))
                                        (QREFELT $ 27)))
                        (EXIT
                         (COND
                          ((> (SPADCALL |s| (QREFELT $ 30)) 50)
                           (CONS (SPADCALL |s0| (QREFELT $ 31)) |l|))
                          (#1# (CONS (SPADCALL |s| (QREFELT $ 31)) |l|)))))))))) 

(SDEFUN |DRAW;maybe_add_title2D|
        ((|f| (|Ex|)) (|l| (|List| (|DrawOption|)))
         ($ (|List| (|DrawOption|))))
        (|DRAW;maybe_add_title0| |f| |l| "FriCAS2D" $)) 

(SDEFUN |DRAW;maybe_add_title3D|
        ((|f| (|Ex|)) (|l| (|List| (|DrawOption|)))
         ($ (|List| (|DrawOption|))))
        (|DRAW;maybe_add_title0| |f| |l| "FriCAS3D" $)) 

(SDEFUN |DRAW;draw;ExSbLTdv;5|
        ((|f| (|Ex|)) (|bind| (|SegmentBinding| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|TwoDimensionalViewport|)))
        (SPROG ((|g| (|GraphImage|)))
               (SEQ (LETT |l| (|DRAW;maybe_add_title2D| |f| |l| $))
                    (LETT |g| (SPADCALL |f| |bind| |l| (QREFELT $ 19)))
                    (EXIT (SPADCALL |g| |l| (QREFELT $ 33)))))) 

(SDEFUN |DRAW;draw;ExSbTdv;6|
        ((|f| (|Ex|)) (|bind| (|SegmentBinding| (|Float|)))
         ($ (|TwoDimensionalViewport|)))
        (SPADCALL |f| |bind| NIL (QREFELT $ 34))) 

(SDEFUN |DRAW;makeObject;PpcSbLGi;7|
        ((|ppc| (|ParametricPlaneCurve| |Ex|))
         (|bind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|GraphImage|)))
        (SPROG
         ((|curve|
           (|ParametricPlaneCurve|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
          (|g| (|Ex|)) (|f| (|Ex|)))
         (SEQ (LETT |f| (SPADCALL |ppc| 1 (QREFELT $ 38)))
              (LETT |g| (SPADCALL |ppc| 2 (QREFELT $ 38)))
              (LETT |curve|
                    (SPADCALL
                     (SPADCALL |f| (SPADCALL |bind| (QREFELT $ 9))
                               (QREFELT $ 12))
                     (SPADCALL |g| (SPADCALL |bind| (QREFELT $ 9))
                               (QREFELT $ 12))
                     (QREFELT $ 40)))
              (EXIT
               (SPADCALL |curve| (SPADCALL |bind| (QREFELT $ 14)) |l|
                         (QREFELT $ 41)))))) 

(SDEFUN |DRAW;draw;PpcSbLTdv;8|
        ((|ppc| (|ParametricPlaneCurve| |Ex|))
         (|bind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|TwoDimensionalViewport|)))
        (SPROG ((|g| (|GraphImage|)) (|f| (|Ex|)))
               (SEQ (LETT |f| (SPADCALL |ppc| 1 (QREFELT $ 38)))
                    (LETT |l| (|DRAW;maybe_add_title2D| |f| |l| $))
                    (LETT |g| (SPADCALL |ppc| |bind| |l| (QREFELT $ 42)))
                    (EXIT (SPADCALL |g| |l| (QREFELT $ 33)))))) 

(SDEFUN |DRAW;draw;PpcSbTdv;9|
        ((|ppc| (|ParametricPlaneCurve| |Ex|))
         (|bind| (|SegmentBinding| (|Float|))) ($ (|TwoDimensionalViewport|)))
        (SPADCALL |ppc| |bind| NIL (QREFELT $ 43))) 

(SDEFUN |DRAW;makeObject;PscSbLTs;10|
        ((|psc| (|ParametricSpaceCurve| |Ex|))
         (|tBind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|curve|
           (|ParametricSpaceCurve|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
          (|h| (|Ex|)) (|g| (|Ex|)) (|f| (|Ex|)) (|tSeg| (|Segment| (|Float|)))
          (|t| (|Symbol|)))
         (SEQ (LETT |t| (SPADCALL |tBind| (QREFELT $ 9)))
              (LETT |tSeg| (SPADCALL |tBind| (QREFELT $ 14)))
              (LETT |f| (SPADCALL |psc| 1 (QREFELT $ 46)))
              (LETT |g| (SPADCALL |psc| 2 (QREFELT $ 46)))
              (LETT |h| (SPADCALL |psc| 3 (QREFELT $ 46)))
              (LETT |l| (|DRAW;maybe_add_title3D| |f| |l| $))
              (LETT |curve|
                    (SPADCALL (SPADCALL |f| |t| (QREFELT $ 12))
                              (SPADCALL |g| |t| (QREFELT $ 12))
                              (SPADCALL |h| |t| (QREFELT $ 12))
                              (QREFELT $ 48)))
              (EXIT (SPADCALL |curve| |tSeg| |l| (QREFELT $ 50)))))) 

(SDEFUN |DRAW;makeObject;PscSbTs;11|
        ((|psc| (|ParametricSpaceCurve| |Ex|))
         (|tBind| (|SegmentBinding| (|Float|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |psc| |tBind| NIL (QREFELT $ 51))) 

(SDEFUN |DRAW;draw;PscSbLTdv;12|
        ((|psc| (|ParametricSpaceCurve| |Ex|))
         (|tBind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG
         ((|curve|
           (|ParametricSpaceCurve|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
          (|h| (|Ex|)) (|g| (|Ex|)) (|f| (|Ex|)) (|tSeg| (|Segment| (|Float|)))
          (|t| (|Symbol|)))
         (SEQ (LETT |t| (SPADCALL |tBind| (QREFELT $ 9)))
              (LETT |tSeg| (SPADCALL |tBind| (QREFELT $ 14)))
              (LETT |f| (SPADCALL |psc| 1 (QREFELT $ 46)))
              (LETT |g| (SPADCALL |psc| 2 (QREFELT $ 46)))
              (LETT |h| (SPADCALL |psc| 3 (QREFELT $ 46)))
              (LETT |l| (|DRAW;maybe_add_title3D| |f| |l| $))
              (LETT |curve|
                    (SPADCALL (SPADCALL |f| |t| (QREFELT $ 12))
                              (SPADCALL |g| |t| (QREFELT $ 12))
                              (SPADCALL |h| |t| (QREFELT $ 12))
                              (QREFELT $ 48)))
              (EXIT (SPADCALL |curve| |tSeg| |l| (QREFELT $ 54)))))) 

(SDEFUN |DRAW;draw;PscSbTdv;13|
        ((|psc| (|ParametricSpaceCurve| |Ex|))
         (|tBind| (|SegmentBinding| (|Float|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |psc| |tBind| NIL (QREFELT $ 55))) 

(SDEFUN |DRAW;makeObject;Ex2SbLTs;14|
        ((|f| (|Ex|)) (|xBind| (|SegmentBinding| (|Float|)))
         (|yBind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|ySeg| #1=(|Segment| (|Float|))) (|y| #2=(|Symbol|)) (|xSeg| #1#)
          (|x| #2#))
         (SEQ (LETT |l| (|DRAW;maybe_add_title3D| |f| |l| $))
              (LETT |x| (SPADCALL |xBind| (QREFELT $ 9)))
              (LETT |xSeg| (SPADCALL |xBind| (QREFELT $ 14)))
              (LETT |y| (SPADCALL |yBind| (QREFELT $ 9)))
              (LETT |ySeg| (SPADCALL |yBind| (QREFELT $ 14)))
              (EXIT
               (SPADCALL (SPADCALL |f| |x| |y| (QREFELT $ 58)) |xSeg| |ySeg|
                         |l| (QREFELT $ 59)))))) 

(SDEFUN |DRAW;makeObject;Ex2SbTs;15|
        ((|f| (|Ex|)) (|xBind| (|SegmentBinding| (|Float|)))
         (|yBind| (|SegmentBinding| (|Float|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |f| |xBind| |yBind| NIL (QREFELT $ 60))) 

(SDEFUN |DRAW;draw;Ex2SbLTdv;16|
        ((|f| (|Ex|)) (|xBind| (|SegmentBinding| (|Float|)))
         (|yBind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG
         ((|ySeg| #1=(|Segment| (|Float|))) (|y| #2=(|Symbol|)) (|xSeg| #1#)
          (|x| #2#))
         (SEQ (LETT |l| (|DRAW;maybe_add_title3D| |f| |l| $))
              (LETT |x| (SPADCALL |xBind| (QREFELT $ 9)))
              (LETT |xSeg| (SPADCALL |xBind| (QREFELT $ 14)))
              (LETT |y| (SPADCALL |yBind| (QREFELT $ 9)))
              (LETT |ySeg| (SPADCALL |yBind| (QREFELT $ 14)))
              (EXIT
               (SPADCALL (SPADCALL |f| |x| |y| (QREFELT $ 58)) |xSeg| |ySeg|
                         |l| (QREFELT $ 62)))))) 

(SDEFUN |DRAW;draw;Ex2SbTdv;17|
        ((|f| (|Ex|)) (|xBind| (|SegmentBinding| (|Float|)))
         (|yBind| (|SegmentBinding| (|Float|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |f| |xBind| |yBind| NIL (QREFELT $ 63))) 

(SDEFUN |DRAW;makeObject;Ps2SbLTs;18|
        ((|s| (|ParametricSurface| |Ex|))
         (|uBind| (|SegmentBinding| (|Float|)))
         (|vBind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|surf|
           (|ParametricSurface|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|vSeg| #1=(|Segment| (|Float|))) (|v| #2=(|Symbol|)) (|uSeg| #1#)
          (|u| #2#) (|h| (|Ex|)) (|g| (|Ex|)) (|f| (|Ex|)))
         (SEQ (LETT |f| (SPADCALL |s| 1 (QREFELT $ 66)))
              (LETT |g| (SPADCALL |s| 2 (QREFELT $ 66)))
              (LETT |h| (SPADCALL |s| 3 (QREFELT $ 66)))
              (LETT |l| (|DRAW;maybe_add_title3D| |f| |l| $))
              (LETT |u| (SPADCALL |uBind| (QREFELT $ 9)))
              (LETT |uSeg| (SPADCALL |uBind| (QREFELT $ 14)))
              (LETT |v| (SPADCALL |vBind| (QREFELT $ 9)))
              (LETT |vSeg| (SPADCALL |vBind| (QREFELT $ 14)))
              (LETT |surf|
                    (SPADCALL (SPADCALL |f| |u| |v| (QREFELT $ 58))
                              (SPADCALL |g| |u| |v| (QREFELT $ 58))
                              (SPADCALL |h| |u| |v| (QREFELT $ 58))
                              (QREFELT $ 68)))
              (EXIT (SPADCALL |surf| |uSeg| |vSeg| |l| (QREFELT $ 69)))))) 

(SDEFUN |DRAW;makeObject;Ps2SbTs;19|
        ((|s| (|ParametricSurface| |Ex|))
         (|uBind| (|SegmentBinding| (|Float|)))
         (|vBind| (|SegmentBinding| (|Float|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |s| |uBind| |vBind| NIL (QREFELT $ 70))) 

(SDEFUN |DRAW;draw;Ps2SbLTdv;20|
        ((|s| (|ParametricSurface| |Ex|))
         (|uBind| (|SegmentBinding| (|Float|)))
         (|vBind| (|SegmentBinding| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG
         ((|surf|
           (|ParametricSurface|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|vSeg| #1=(|Segment| (|Float|))) (|v| #2=(|Symbol|)) (|uSeg| #1#)
          (|u| #2#) (|h| (|Ex|)) (|g| (|Ex|)) (|f| (|Ex|)))
         (SEQ (LETT |f| (SPADCALL |s| 1 (QREFELT $ 66)))
              (LETT |g| (SPADCALL |s| 2 (QREFELT $ 66)))
              (LETT |h| (SPADCALL |s| 3 (QREFELT $ 66)))
              (LETT |l| (|DRAW;maybe_add_title3D| |f| |l| $))
              (LETT |u| (SPADCALL |uBind| (QREFELT $ 9)))
              (LETT |uSeg| (SPADCALL |uBind| (QREFELT $ 14)))
              (LETT |v| (SPADCALL |vBind| (QREFELT $ 9)))
              (LETT |vSeg| (SPADCALL |vBind| (QREFELT $ 14)))
              (LETT |surf|
                    (SPADCALL (SPADCALL |f| |u| |v| (QREFELT $ 58))
                              (SPADCALL |g| |u| |v| (QREFELT $ 58))
                              (SPADCALL |h| |u| |v| (QREFELT $ 58))
                              (QREFELT $ 68)))
              (EXIT (SPADCALL |surf| |uSeg| |vSeg| |l| (QREFELT $ 72)))))) 

(SDEFUN |DRAW;draw;Ps2SbTdv;21|
        ((|s| (|ParametricSurface| |Ex|))
         (|uBind| (|SegmentBinding| (|Float|)))
         (|vBind| (|SegmentBinding| (|Float|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |s| |uBind| |vBind| NIL (QREFELT $ 73))) 

(DECLAIM (NOTINLINE |TopLevelDrawFunctions;|)) 

(DEFUN |TopLevelDrawFunctions| (#1=#:G764)
  (SPROG NIL
         (PROG (#2=#:G765)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TopLevelDrawFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|TopLevelDrawFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|TopLevelDrawFunctions|)))))))))) 

(DEFUN |TopLevelDrawFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TopLevelDrawFunctions| DV$1))
          (LETT $ (GETREFV 75))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TopLevelDrawFunctions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TopLevelDrawFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|)
              (|SegmentBinding| (|Float|)) (0 . |variable|)
              (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
              (|MakeFloatCompiledFunction| 6) (5 . |makeFloatFunction|)
              (|Segment| (|Float|)) (11 . |segment|) (|GraphImage|) (|List| 22)
              (|TopLevelDrawFunctionsForCompiledFunctions|) (16 . |makeObject|)
              |DRAW;makeObject;ExSbLGi;1| (|Boolean|) (|List| $) (|DrawOption|)
              (23 . |option?|) (|InputForm|) (29 . |convert|) (|String|)
              (34 . |unparse|) (|Integer|) (|DisplayPackage|)
              (39 . |sayLength|) (44 . |title|) (|TwoDimensionalViewport|)
              (49 . |makeViewport2D|) |DRAW;draw;ExSbLTdv;5|
              |DRAW;draw;ExSbTdv;6| (|NonNegativeInteger|)
              (|ParametricPlaneCurve| 6) (55 . |coordinate|)
              (|ParametricPlaneCurve| 10) (61 . |curve|) (67 . |makeObject|)
              |DRAW;makeObject;PpcSbLGi;7| |DRAW;draw;PpcSbLTdv;8|
              |DRAW;draw;PpcSbTdv;9| (|ParametricSpaceCurve| 6)
              (74 . |coordinate|) (|ParametricSpaceCurve| 10) (80 . |curve|)
              (|ThreeSpace| (|DoubleFloat|)) (87 . |makeObject|)
              |DRAW;makeObject;PscSbLTs;10| |DRAW;makeObject;PscSbTs;11|
              (|ThreeDimensionalViewport|) (94 . |draw|)
              |DRAW;draw;PscSbLTdv;12| |DRAW;draw;PscSbTdv;13|
              (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))
              (101 . |makeFloatFunction|) (108 . |makeObject|)
              |DRAW;makeObject;Ex2SbLTs;14| |DRAW;makeObject;Ex2SbTs;15|
              (116 . |draw|) |DRAW;draw;Ex2SbLTdv;16| |DRAW;draw;Ex2SbTdv;17|
              (|ParametricSurface| 6) (124 . |coordinate|)
              (|ParametricSurface| 57) (130 . |surface|) (137 . |makeObject|)
              |DRAW;makeObject;Ps2SbLTs;18| |DRAW;makeObject;Ps2SbTs;19|
              (145 . |draw|) |DRAW;draw;Ps2SbLTdv;20| |DRAW;draw;Ps2SbTdv;21|)
           '#(|makeObject| 153 |draw| 210) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|draw|
                                 ((|TwoDimensionalViewport|) |#1|
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|) |#1|
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|GraphImage|) |#1|
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|ParametricPlaneCurve| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|ParametricPlaneCurve| |#1|)
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|GraphImage|) (|ParametricPlaneCurve| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSpaceCurve| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSpaceCurve| |#1|)
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSpaceCurve| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSpaceCurve| |#1|)
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|) |#1|
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|) |#1|
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|)) |#1|
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|)) |#1|
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSurface| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSurface| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSurface| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSurface| |#1|)
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 74
                                            '(1 8 7 0 9 2 11 10 6 7 12 1 8 13 0
                                              14 3 17 15 10 13 16 18 2 22 20 21
                                              7 23 1 6 24 0 25 1 24 26 0 27 1
                                              29 28 26 30 1 22 0 26 31 2 32 0
                                              15 16 33 2 37 6 0 36 38 2 39 0 10
                                              10 40 3 17 15 39 13 16 41 2 45 6
                                              0 36 46 3 47 0 10 10 10 48 3 17
                                              49 47 13 16 50 3 17 53 47 13 16
                                              54 3 11 57 6 7 7 58 4 17 49 57 13
                                              13 16 59 4 17 53 57 13 13 16 62 2
                                              65 6 0 36 66 3 67 0 57 57 57 68 4
                                              17 49 67 13 13 16 69 4 17 53 67
                                              13 13 16 72 3 0 15 6 8 16 19 3 0
                                              15 37 8 16 42 3 0 49 45 8 16 51 2
                                              0 49 45 8 52 4 0 49 6 8 8 16 60 3
                                              0 49 6 8 8 61 3 0 49 65 8 8 71 4
                                              0 49 65 8 8 16 70 2 0 32 6 8 35 3
                                              0 32 6 8 16 34 3 0 32 37 8 16 43
                                              2 0 32 37 8 44 3 0 53 45 8 16 55
                                              2 0 53 45 8 56 4 0 53 6 8 8 16 63
                                              3 0 53 6 8 8 64 4 0 53 65 8 8 16
                                              73 3 0 53 65 8 8 74)))))
           '|lookupComplete|)) 
