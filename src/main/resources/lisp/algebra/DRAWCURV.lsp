
(SDEFUN |DRAWCURV;drawToScaleRanges|
        ((|xVals| (|Segment| (|Float|))) (|yVals| (|Segment| (|Float|)))
         ($ (|List| (|Segment| (|Float|)))))
        (SPROG
         ((|pad| (|Float|)) (|yDiff| #1=(|Float|)) (|xDiff| #1#)
          (|yLo| #2=(|Float|)) (|yHi| #3=(|Float|)) (|xLo| #2#) (|xHi| #3#))
         (SEQ (LETT |xHi| (SPADCALL |xVals| (QREFELT $ 10)))
              (LETT |xLo| (SPADCALL |xVals| (QREFELT $ 11)))
              (LETT |yHi| (SPADCALL |yVals| (QREFELT $ 10)))
              (LETT |yLo| (SPADCALL |yVals| (QREFELT $ 11)))
              (LETT |xDiff| (SPADCALL |xHi| |xLo| (QREFELT $ 12)))
              (LETT |yDiff| (SPADCALL |yHi| |yLo| (QREFELT $ 12)))
              (LETT |pad|
                    (SPADCALL
                     (SPADCALL (SPADCALL |yDiff| |xDiff| (QREFELT $ 12))
                               (QREFELT $ 13))
                     2 (QREFELT $ 15)))
              (EXIT
               (COND
                ((SPADCALL |yDiff| |xDiff| (QREFELT $ 17))
                 (LIST
                  (SPADCALL (SPADCALL |xLo| |pad| (QREFELT $ 12))
                            (SPADCALL |xHi| |pad| (QREFELT $ 18))
                            (QREFELT $ 19))
                  |yVals|))
                ('T
                 (LIST |xVals|
                       (SPADCALL (SPADCALL |yLo| |pad| (QREFELT $ 12))
                                 (SPADCALL |yHi| |pad| (QREFELT $ 18))
                                 (QREFELT $ 19))))))))) 

(SDEFUN |DRAWCURV;intConvert| ((|r| (R)) ($ (|Integer|)))
        (SPROG ((|nn| (|Union| (|Integer|) "failed")))
               (SEQ (LETT |nn| (SPADCALL |r| (QREFELT $ 21)))
                    (EXIT
                     (COND
                      ((QEQCAR |nn| 1)
                       (|error|
                        "draw: polynomial must have rational coefficients"))
                      ('T (QCDR |nn|))))))) 

(SDEFUN |DRAWCURV;polyEquation|
        ((|eq| (|Equation| |Ex|)) ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|rat| (|Fraction| (|Polynomial| R)))
          (|r| (|Union| (|Fraction| (|Polynomial| R)) "failed")) (|ff| (|Ex|)))
         (SEQ
          (LETT |ff|
                (SPADCALL (SPADCALL |eq| (QREFELT $ 23))
                          (SPADCALL |eq| (QREFELT $ 24)) (QREFELT $ 25)))
          (LETT |r| (SPADCALL |ff| (QREFELT $ 27)))
          (EXIT
           (COND ((QEQCAR |r| 1) (|error| "draw: not a polynomial equation"))
                 (#1='T
                  (SEQ (LETT |rat| (QCDR |r|))
                       (EXIT
                        (COND
                         ((QEQCAR
                           (SPADCALL (SPADCALL |rat| (QREFELT $ 30))
                                     (QREFELT $ 32))
                           1)
                          (|error| "draw: non-constant denominator"))
                         (#1#
                          (SPADCALL (CONS (|function| |DRAWCURV;intConvert|) $)
                                    (SPADCALL |rat| (QREFELT $ 33))
                                    (QREFELT $ 37)))))))))))) 

(SDEFUN |DRAWCURV;makeObject;E2SLGi;4|
        ((|eq| (|Equation| |Ex|)) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|l| (|List| (|DrawOption|))) ($ (|GraphImage|)))
        (SPROG
         ((|crCol| (|Palette|)) (|ptCol| (|Palette|))
          (|scaledRanges| (|List| (|Segment| (|Float|))))
          (|acplot| (|PlaneAlgebraicCurvePlot|))
          (|floatRanges| (|List| (|Segment| (|Float|))))
          (|yRangeFloat| #1=(|Segment| (|Float|))) (|xRangeFloat| #1#)
          (|yRange| #2=(|Segment| (|Fraction| (|Integer|)))) (|xRange| #2#)
          (|ranges| (|List| (|Segment| (|Fraction| (|Integer|)))))
          (#3=#:G729 NIL) (|ratRange| #4=(|Union| (|Any|) #5="failed"))
          (|floatRange| #4#) (|p| (|Polynomial| (|Integer|))))
         (SEQ (LETT |p| (|DRAWCURV;polyEquation| |eq| $))
              (LETT |floatRange| (SPADCALL |l| '|rangeFloat| (QREFELT $ 42)))
              (LETT |ratRange| (SPADCALL |l| '|rangeRat| (QREFELT $ 42)))
              (COND
               ((QEQCAR |floatRange| 1)
                (COND
                 ((QEQCAR |ratRange| 1)
                  (EXIT
                   (|error|
                    "draw: you must specify ranges for an implicit plot"))))))
              (LETT |ranges| NIL) (LETT |floatRanges| NIL)
              (LETT |xRange|
                    (SPADCALL (|spadConstant| $ 46) (|spadConstant| $ 46)
                              (QREFELT $ 48)))
              (LETT |yRange|
                    (SPADCALL (|spadConstant| $ 46) (|spadConstant| $ 46)
                              (QREFELT $ 48)))
              (LETT |xRangeFloat|
                    (SPADCALL (|spadConstant| $ 49) (|spadConstant| $ 49)
                              (QREFELT $ 19)))
              (LETT |yRangeFloat|
                    (SPADCALL (|spadConstant| $ 49) (|spadConstant| $ 49)
                              (QREFELT $ 19)))
              (COND
               ((QEQCAR |ratRange| 1)
                (SEQ
                 (LETT |floatRanges|
                       (SPADCALL
                        (PROG2 (LETT #3# |floatRange|)
                            (QCDR #3#)
                          (|check_union2| (QEQCAR #3# 0) (|Any|)
                                          (|Union| (|Any|) #5#) #3#))
                        (QREFELT $ 53)))
                 (COND
                  ((NULL (SPADCALL |floatRanges| 2 (QREFELT $ 55)))
                   (EXIT (|error| "draw: you must specify two ranges"))))
                 (LETT |xRangeFloat| (|SPADfirst| |floatRanges|))
                 (LETT |yRangeFloat| (SPADCALL |floatRanges| (QREFELT $ 56)))
                 (LETT |xRange|
                       (SPADCALL (ELT $ 57) |xRangeFloat| (QREFELT $ 60)))
                 (LETT |yRange|
                       (SPADCALL (ELT $ 57) |yRangeFloat| (QREFELT $ 60)))
                 (EXIT (LETT |ranges| (LIST |xRange| |yRange|)))))
               (#6='T
                (SEQ
                 (LETT |ranges| (SPADCALL (QCDR |ratRange|) (QREFELT $ 63)))
                 (COND
                  ((NULL (SPADCALL |ranges| 2 (QREFELT $ 64)))
                   (EXIT (|error| "draw: you must specify two ranges"))))
                 (LETT |xRange| (|SPADfirst| |ranges|))
                 (LETT |yRange| (SPADCALL |ranges| (QREFELT $ 65)))
                 (LETT |xRangeFloat|
                       (SPADCALL (ELT $ 66) |xRange| (QREFELT $ 69)))
                 (LETT |yRangeFloat|
                       (SPADCALL (ELT $ 66) |yRange| (QREFELT $ 69)))
                 (EXIT
                  (LETT |floatRanges| (LIST |xRangeFloat| |yRangeFloat|))))))
              (LETT |acplot|
                    (SPADCALL |p| |x| |y| |xRange| |yRange| (QREFELT $ 71)))
              (COND
               ((SPADCALL |l| (SPADCALL (QREFELT $ 73)) (QREFELT $ 76))
                (SEQ
                 (LETT |scaledRanges|
                       (|DRAWCURV;drawToScaleRanges| |xRangeFloat|
                        |yRangeFloat| $))
                 (EXIT
                  (LETT |l|
                        (CONS (SPADCALL |scaledRanges| (QREFELT $ 77)) |l|)))))
               (#6#
                (LETT |l| (CONS (SPADCALL |floatRanges| (QREFELT $ 77)) |l|))))
              (LETT |ptCol|
                    (SPADCALL |l| (SPADCALL (QREFELT $ 80)) (QREFELT $ 81)))
              (LETT |crCol|
                    (SPADCALL |l| (SPADCALL (QREFELT $ 82)) (QREFELT $ 83)))
              (EXIT
               (SPADCALL (SPADCALL |acplot| (QREFELT $ 85)) |ptCol| |crCol|
                         (SPADCALL (QREFELT $ 87)) |l| (QREFELT $ 90)))))) 

(SDEFUN |DRAWCURV;draw;E2SLTdv;5|
        ((|eq| (|Equation| |Ex|)) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|l| (|List| (|DrawOption|))) ($ (|TwoDimensionalViewport|)))
        (SPROG ((|g| (|GraphImage|)))
               (SEQ (LETT |g| (SPADCALL |eq| |x| |y| |l| (QREFELT $ 91)))
                    (EXIT (SPADCALL |g| |l| (QREFELT $ 93)))))) 

(DECLAIM (NOTINLINE |TopLevelDrawFunctionsForAlgebraicCurves;|)) 

(DEFUN |TopLevelDrawFunctionsForAlgebraicCurves| (&REST #1=#:G745)
  (SPROG NIL
         (PROG (#2=#:G746)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TopLevelDrawFunctionsForAlgebraicCurves|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |TopLevelDrawFunctionsForAlgebraicCurves;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TopLevelDrawFunctionsForAlgebraicCurves|)))))))))) 

(DEFUN |TopLevelDrawFunctionsForAlgebraicCurves;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|TopLevelDrawFunctionsForAlgebraicCurves| DV$1 DV$2))
          (LETT $ (GETREFV 95))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|TopLevelDrawFunctionsForAlgebraicCurves|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TopLevelDrawFunctionsForAlgebraicCurves| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Float|)
              (|Segment| 8) (0 . |high|) (5 . |low|) (10 . -) (16 . |abs|)
              (|Integer|) (21 . /) (|Boolean|) (27 . >) (33 . +)
              (39 . |segment|) (|Union| 14 '#1="failed") (45 . |retractIfCan|)
              (|Equation| 7) (50 . |lhs|) (55 . |rhs|) (60 . -)
              (|Union| 29 '#1#) (66 . |retractIfCan|) (|Polynomial| 6)
              (|Fraction| 28) (71 . |denom|) (|Union| 6 '"failed")
              (76 . |retractIfCan|) (81 . |numer|) (|Polynomial| 14)
              (|Mapping| 14 6) (|PolynomialFunctions2| 6 14) (86 . |map|)
              (|Union| 51 '"failed") (|List| $) (|Symbol|) (|DrawOption|)
              (92 . |option|) (98 . |Zero|) (102 . |Zero|) (|Fraction| 14)
              (106 . |Zero|) (|Segment| 45) (110 . |segment|) (116 . |Zero|)
              (|List| 9) (|Any|) (|AnyFunctions1| 50) (120 . |retract|)
              (|NonNegativeInteger|) (125 . |size?|) (131 . |second|)
              (136 . |retract|) (|Mapping| 45 8) (|SegmentFunctions2| 8 45)
              (141 . |map|) (|List| 47) (|AnyFunctions1| 61) (147 . |retract|)
              (152 . |size?|) (158 . |second|) (163 . |convert|)
              (|Mapping| 8 45) (|SegmentFunctions2| 45 8) (168 . |map|)
              (|PlaneAlgebraicCurvePlot|) (174 . |makeSketch|)
              (|GraphicsDefaults|) (183 . |drawToScale|) (|List| 41)
              (|DrawOptionFunctions0|) (187 . |toScale|) (193 . |ranges|)
              (|Palette|) (|ViewDefaultsPackage|) (198 . |pointColorDefault|)
              (202 . |pointColorPalette|) (208 . |lineColorDefault|)
              (212 . |curveColorPalette|)
              (|List| (|List| (|Point| (|DoubleFloat|))))
              (218 . |listBranches|) (|PositiveInteger|)
              (223 . |pointSizeDefault|) (|GraphImage|) (|ViewportPackage|)
              (227 . |graphCurves|) |DRAWCURV;makeObject;E2SLGi;4|
              (|TwoDimensionalViewport|) (236 . |makeViewport2D|)
              |DRAWCURV;draw;E2SLTdv;5|)
           '#(|makeObject| 242 |draw| 250) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|draw|
                                 ((|TwoDimensionalViewport|) (|Equation| |#2|)
                                  (|Symbol|) (|Symbol|)
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|GraphImage|) (|Equation| |#2|) (|Symbol|)
                                  (|Symbol|) (|List| (|DrawOption|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 94
                                            '(1 9 8 0 10 1 9 8 0 11 2 8 0 0 0
                                              12 1 8 0 0 13 2 8 0 0 14 15 2 8
                                              16 0 0 17 2 8 0 0 0 18 2 9 0 8 8
                                              19 1 6 20 0 21 1 22 7 0 23 1 22 7
                                              0 24 2 7 0 0 0 25 1 7 26 0 27 1
                                              29 28 0 30 1 28 31 0 32 1 29 28 0
                                              33 2 36 34 35 28 37 2 41 38 39 40
                                              42 0 6 0 43 0 7 0 44 0 45 0 46 2
                                              47 0 45 45 48 0 8 0 49 1 52 50 51
                                              53 2 50 16 0 54 55 1 50 9 0 56 1
                                              8 45 0 57 2 59 47 58 9 60 1 62 61
                                              51 63 2 61 16 0 54 64 1 61 47 0
                                              65 1 45 8 0 66 2 68 9 67 47 69 5
                                              70 0 34 40 40 47 47 71 0 72 16 73
                                              2 75 16 74 16 76 1 41 0 50 77 0
                                              79 78 80 2 75 78 74 78 81 0 79 78
                                              82 2 75 78 74 78 83 1 70 84 0 85
                                              0 79 86 87 5 89 88 84 78 78 86 74
                                              90 2 92 0 88 74 93 4 0 88 22 40
                                              40 74 91 4 0 92 22 40 40 74
                                              94)))))
           '|lookupComplete|)) 
