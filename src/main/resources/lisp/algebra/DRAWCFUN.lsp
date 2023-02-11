
(SDEFUN |DRAWCFUN;drawToScaleRanges|
        ((|xVals| (|Segment| (|DoubleFloat|)))
         (|yVals| (|Segment| (|DoubleFloat|)))
         ($ (|List| (|Segment| (|Float|)))))
        (SPROG
         ((|pad| (|Float|)) (|yDiff| #1=(|Float|)) (|xDiff| #1#)
          (|yLo| #2=(|Float|)) (|yHi| #2#) (|xLo| #2#) (|xHi| #2#))
         (SEQ
          (LETT |xHi|
                (SPADCALL (SPADCALL |xVals| (QREFELT $ 11)) (QREFELT $ 13)))
          (LETT |xLo|
                (SPADCALL (SPADCALL |xVals| (QREFELT $ 14)) (QREFELT $ 13)))
          (LETT |yHi|
                (SPADCALL (SPADCALL |yVals| (QREFELT $ 11)) (QREFELT $ 13)))
          (LETT |yLo|
                (SPADCALL (SPADCALL |yVals| (QREFELT $ 14)) (QREFELT $ 13)))
          (LETT |xDiff| (SPADCALL |xHi| |xLo| (QREFELT $ 15)))
          (LETT |yDiff| (SPADCALL |yHi| |yLo| (QREFELT $ 15)))
          (LETT |pad|
                (SPADCALL
                 (SPADCALL (SPADCALL |yDiff| |xDiff| (QREFELT $ 15))
                           (QREFELT $ 16))
                 2 (QREFELT $ 18)))
          (EXIT
           (COND
            ((SPADCALL |yDiff| |xDiff| (QREFELT $ 20))
             (LIST
              (SPADCALL (SPADCALL |xLo| |pad| (QREFELT $ 15))
                        (SPADCALL |xHi| |pad| (QREFELT $ 21)) (QREFELT $ 23))
              (SPADCALL (ELT $ 13) |yVals| (QREFELT $ 26))))
            ('T
             (LIST (SPADCALL (ELT $ 13) |xVals| (QREFELT $ 26))
                   (SPADCALL (SPADCALL |yLo| |pad| (QREFELT $ 15))
                             (SPADCALL |yHi| |pad| (QREFELT $ 21))
                             (QREFELT $ 23))))))))) 

(SDEFUN |DRAWCFUN;make_plot|
        ((|plot| (|Plot|)) (|l| (|List| (|DrawOption|))) ($ (|GraphImage|)))
        (SPROG
         ((|crCol| (|Palette|)) (|ptCol| (|Palette|))
          (|ll| (|List| #1=(|Segment| (|Float|)))) (|yRangeFloat| #1#)
          (|xRangeFloat| #1#) (|scaledRanges| (|List| (|Segment| (|Float|))))
          (|yRange| (|Segment| (|DoubleFloat|)))
          (|xRange| (|Segment| (|DoubleFloat|)))
          (|branches| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|clipInfo|
           (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                     (|:| |xValues| (|Segment| (|DoubleFloat|)))
                     (|:| |yValues| (|Segment| (|DoubleFloat|)))))
          (|yHi| #2=(|DoubleFloat|)) (|yLo| #2#)
          (|yRangeF| #3=(|Segment| (|Float|))) (|xHi| #2#) (|xLo| #2#)
          (|xRangeF| #3#) (|segList| (|List| (|Segment| (|Float|))))
          (|cl| (|Union| (|Any|) "failed")))
         (SEQ (LETT |branches| (SPADCALL |plot| (QREFELT $ 29)))
              (LETT |xRange| (SPADCALL |plot| (QREFELT $ 30)))
              (LETT |yRange| (SPADCALL |plot| (QREFELT $ 31)))
              (SEQ (LETT |cl| (SPADCALL |l| '|clipSegment| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((QEQCAR |cl| 1)
                      (COND
                       ((SPADCALL |l| (SPADCALL (QREFELT $ 38)) (QREFELT $ 41))
                        (SEQ
                         (LETT |clipInfo|
                               (COND
                                ((SPADCALL |plot| (QREFELT $ 42))
                                 (SPADCALL |plot| (QREFELT $ 45)))
                                (#4='T (SPADCALL |plot| (QREFELT $ 46)))))
                         (LETT |branches| (QVELT |clipInfo| 0))
                         (LETT |xRange| (QVELT |clipInfo| 1))
                         (EXIT (LETT |yRange| (QVELT |clipInfo| 2)))))
                       (#4# "No explicit user-specified clipping")))
                     (#4#
                      (SEQ
                       (LETT |segList| (SPADCALL (QCDR |cl|) (QREFELT $ 50)))
                       (EXIT
                        (COND
                         ((NULL |segList|)
                          (|error|
                           "draw: you may specify at least 1 segment for 2D clipping"))
                         ((SPADCALL |segList| 2 (QREFELT $ 52))
                          (|error|
                           "draw: you may specify at most 2 segments for 2D clipping"))
                         (#4#
                          (SEQ (LETT |xLo| 0.0) (LETT |xHi| 0.0)
                               (LETT |yLo| 0.0) (LETT |yHi| 0.0)
                               (COND
                                ((NULL (CDR |segList|))
                                 (SEQ
                                  (LETT |xLo|
                                        (SPADCALL |xRange| (QREFELT $ 14)))
                                  (LETT |xHi|
                                        (SPADCALL |xRange| (QREFELT $ 11)))
                                  (LETT |yRangeF| (|SPADfirst| |segList|))
                                  (LETT |yLo|
                                        (SPADCALL
                                         (SPADCALL |yRangeF| (QREFELT $ 53))
                                         (QREFELT $ 54)))
                                  (EXIT
                                   (LETT |yHi|
                                         (SPADCALL
                                          (SPADCALL |yRangeF| (QREFELT $ 55))
                                          (QREFELT $ 54))))))
                                (#4#
                                 (SEQ (LETT |xRangeF| (|SPADfirst| |segList|))
                                      (LETT |xLo|
                                            (SPADCALL
                                             (SPADCALL |xRangeF|
                                                       (QREFELT $ 53))
                                             (QREFELT $ 54)))
                                      (LETT |xHi|
                                            (SPADCALL
                                             (SPADCALL |xRangeF|
                                                       (QREFELT $ 55))
                                             (QREFELT $ 54)))
                                      (LETT |yRangeF|
                                            (SPADCALL |segList|
                                                      (QREFELT $ 56)))
                                      (LETT |yLo|
                                            (SPADCALL
                                             (SPADCALL |yRangeF|
                                                       (QREFELT $ 53))
                                             (QREFELT $ 54)))
                                      (EXIT
                                       (LETT |yHi|
                                             (SPADCALL
                                              (SPADCALL |yRangeF|
                                                        (QREFELT $ 55))
                                              (QREFELT $ 54)))))))
                               (LETT |clipInfo|
                                     (SPADCALL |branches| |xLo| |xHi| |yLo|
                                               |yHi| (QREFELT $ 57)))
                               (LETT |branches| (QVELT |clipInfo| 0))
                               (LETT |xRange| (QVELT |clipInfo| 1))
                               (EXIT
                                (LETT |yRange| (QVELT |clipInfo| 2))))))))))))
              (COND
               ((SPADCALL |l| (SPADCALL (QREFELT $ 58)) (QREFELT $ 59))
                (SEQ
                 (LETT |scaledRanges|
                       (|DRAWCFUN;drawToScaleRanges| |xRange| |yRange| $))
                 (EXIT
                  (LETT |l|
                        (CONS (SPADCALL |scaledRanges| (QREFELT $ 60)) |l|)))))
               (#4#
                (SEQ
                 (LETT |xRangeFloat|
                       (SPADCALL (ELT $ 13) |xRange| (QREFELT $ 26)))
                 (LETT |yRangeFloat|
                       (SPADCALL (ELT $ 13) |yRange| (QREFELT $ 26)))
                 (EXIT
                  (LETT |l|
                        (CONS
                         (SPADCALL
                          (LETT |ll| (LIST |xRangeFloat| |yRangeFloat|))
                          (QREFELT $ 60))
                         |l|))))))
              (LETT |ptCol|
                    (SPADCALL |l| (SPADCALL (QREFELT $ 63)) (QREFELT $ 64)))
              (LETT |crCol|
                    (SPADCALL |l| (SPADCALL (QREFELT $ 65)) (QREFELT $ 66)))
              (EXIT
               (SPADCALL |branches| |ptCol| |crCol| (SPADCALL (QREFELT $ 68))
                         |l| (QREFELT $ 71)))))) 

(SDEFUN |DRAWCFUN;normalize|
        ((|seg| (|Segment| (|Float|))) ($ (|Segment| (|DoubleFloat|))))
        (SPROG ((|b| #1=(|DoubleFloat|)) (|a| #1#))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |seg| (QREFELT $ 53))
                                (QREFELT $ 54)))
                (LETT |b|
                      (SPADCALL (SPADCALL |seg| (QREFELT $ 55))
                                (QREFELT $ 54)))
                (EXIT
                 (COND ((|eql_DF| |a| |b|) (|error| (QREFELT $ 7)))
                       ((|less_DF| |a| |b|) (SPADCALL |a| |b| (QREFELT $ 72)))
                       ('T (SPADCALL |b| |a| (QREFELT $ 72)))))))) 

(SDEFUN |DRAWCFUN;myTrap1|
        ((|ff| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|f| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (SPROG ((|r| (|DoubleFloat|)) (|s| (|Union| (|DoubleFloat|) "failed")))
               (SEQ (LETT |s| (|trapNumericErrors| (SPADCALL |f| |ff|)))
                    (EXIT
                     (COND ((QEQCAR |s| 1) 0.0)
                           (#1='T
                            (SEQ (LETT |r| (QCDR |s|))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |r| MOST-POSITIVE-DOUBLE-FLOAT
                                              (QREFELT $ 73))
                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                   ((|less_DF| |r| MOST-NEGATIVE-DOUBLE-FLOAT)
                                    MOST-NEGATIVE-DOUBLE-FLOAT)
                                   (#1# |r|)))))))))) 

(SDEFUN |DRAWCFUN;makePt2|
        ((|x| (|DoubleFloat|)) (|y| #1=(|DoubleFloat|))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |x| |y|)) (QREFELT $ 76)))) 

(SDEFUN |DRAWCFUN;makeObject;MSLGi;6|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|GraphImage|)))
        (SPROG
         ((|pl| (|Plot|))
          (|ff| (|List| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|))))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|c| (|Union| (|Any|) "failed")) (|oldAdaptive| (|Boolean|)))
         (SEQ (LETT |oldAdaptive| (SPADCALL (QREFELT $ 77)))
              (SPADCALL (SPADCALL |l| |oldAdaptive| (QREFELT $ 78))
                        (QREFELT $ 79))
              (LETT |ff|
                    (LIST
                     (CONS #'|DRAWCFUN;makeObject;MSLGi;6!0| (VECTOR $ |f|))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((QEQCAR |c| 1)
                      (LETT |ff|
                            (LIST
                             (CONS #'|DRAWCFUN;makeObject;MSLGi;6!1|
                                   (VECTOR $ |f|)))))
                     ('T
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |ff|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;MSLGi;6!2|
                                     (VECTOR |cc| $ |ff|))))))))))
              (LETT |pl|
                    (SPADCALL (SPADCALL |ff| (QREFELT $ 87))
                              (|DRAWCFUN;normalize| |seg| $) (QREFELT $ 88)))
              (SPADCALL |oldAdaptive| (QREFELT $ 79))
              (EXIT (|DRAWCFUN;make_plot| |pl| |l| $))))) 

(SDEFUN |DRAWCFUN;makeObject;MSLGi;6!2| ((|x| NIL) ($$ NIL))
        (PROG (|ff| $ |cc|)
          (LETT |ff| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (SPADCALL |ff| (QREFELT $ 87)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;MSLGi;6!1| ((|x| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|DRAWCFUN;makePt2| |x| (|DRAWCFUN;myTrap1| |f| |x| $) $))))) 

(SDEFUN |DRAWCFUN;makeObject;MSLGi;6!0| ((|x| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|DRAWCFUN;makePt2| (|DRAWCFUN;myTrap1| |f| |x| $) |x| $))))) 

(SDEFUN |DRAWCFUN;draw;MSLTdv;7|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|TwoDimensionalViewport|)))
        (SPROG ((|g| (|GraphImage|)))
               (SEQ (LETT |g| (SPADCALL |f| |seg| |l| (QREFELT $ 90)))
                    (EXIT (SPADCALL |g| |l| (QREFELT $ 92)))))) 

(SDEFUN |DRAWCFUN;draw;MSTdv;8|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) ($ (|TwoDimensionalViewport|)))
        (SPADCALL |f| |seg| NIL (QREFELT $ 93))) 

(SDEFUN |DRAWCFUN;makeObject;PpcSLGi;9|
        ((|ppc|
          (|ParametricPlaneCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|GraphImage|)))
        (SPROG
         ((|pl| (|Plot|))
          (|fcn|
           (|List| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|))))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|c| (|Union| (|Any|) "failed"))
          (|g| #1=(|Mapping| (|DoubleFloat|) (|DoubleFloat|))) (|f| #1#)
          (|oldAdaptive| (|Boolean|)))
         (SEQ (LETT |oldAdaptive| (SPADCALL (QREFELT $ 77)))
              (SPADCALL (SPADCALL |l| |oldAdaptive| (QREFELT $ 78))
                        (QREFELT $ 79))
              (LETT |f| (SPADCALL |ppc| 1 (QREFELT $ 97)))
              (LETT |g| (SPADCALL |ppc| 2 (QREFELT $ 97)))
              (LETT |fcn|
                    (LIST
                     (CONS #'|DRAWCFUN;makeObject;PpcSLGi;9!0|
                           (VECTOR |g| $ |f|))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c| 1))
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |fcn|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;PpcSLGi;9!1|
                                     (VECTOR |cc| $ |fcn|))))))))))
              (LETT |pl|
                    (SPADCALL (SPADCALL |fcn| (QREFELT $ 87))
                              (|DRAWCFUN;normalize| |seg| $) (QREFELT $ 88)))
              (SPADCALL |oldAdaptive| (QREFELT $ 79))
              (EXIT (|DRAWCFUN;make_plot| |pl| |l| $))))) 

(SDEFUN |DRAWCFUN;makeObject;PpcSLGi;9!1| ((|x| NIL) ($$ NIL))
        (PROG (|fcn| $ |cc|)
          (LETT |fcn| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (SPADCALL |fcn| (QREFELT $ 87)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;PpcSLGi;9!0| ((|x| NIL) ($$ NIL))
        (PROG (|f| $ |g|)
          (LETT |f| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |g| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|DRAWCFUN;makePt2| (|DRAWCFUN;myTrap1| |f| |x| $)
             (|DRAWCFUN;myTrap1| |g| |x| $) $))))) 

(SDEFUN |DRAWCFUN;draw;PpcSLTdv;10|
        ((|ppc|
          (|ParametricPlaneCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|TwoDimensionalViewport|)))
        (SPROG ((|g| (|GraphImage|)))
               (SEQ (LETT |g| (SPADCALL |ppc| |seg| |l| (QREFELT $ 98)))
                    (EXIT (SPADCALL |g| |l| (QREFELT $ 92)))))) 

(SDEFUN |DRAWCFUN;draw;PpcSTdv;11|
        ((|ppc|
          (|ParametricPlaneCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) ($ (|TwoDimensionalViewport|)))
        (SPADCALL |ppc| |seg| NIL (QREFELT $ 99))) 

(SDEFUN |DRAWCFUN;makePt4|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) (|z| (|DoubleFloat|))
         (|c| #1=(|DoubleFloat|)) ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |x| |y| |z| |c|)) (QREFELT $ 76)))) 

(PUT '|DRAWCFUN;id| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |DRAWCFUN;id| ((|x| (|DoubleFloat|)) ($ (|DoubleFloat|))) |x|) 

(PUT '|DRAWCFUN;zCoord| '|SPADreplace| '(XLAM (|x| |y| |z|) |z|)) 

(SDEFUN |DRAWCFUN;zCoord|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) (|z| (|DoubleFloat|))
         ($ (|DoubleFloat|)))
        |z|) 

(SDEFUN |DRAWCFUN;colorPoints|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|func|
          (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                     (|DoubleFloat|)))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG ((#1=#:G794 NIL) (|p| NIL) (#2=#:G793 NIL) (|lp| NIL))
               (SEQ
                (SEQ (LETT |lp| NIL) (LETT #2# |llp|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |lp| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |p| 4
                                        (SPADCALL
                                         (SPADCALL |p| 1 (QREFELT $ 101))
                                         (SPADCALL |p| 2 (QREFELT $ 101))
                                         (SPADCALL |p| 3 (QREFELT $ 101))
                                         |func|)
                                        (QREFELT $ 102))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT |llp|)))) 

(SDEFUN |DRAWCFUN;makeObject;PscSLTs;16|
        ((|psc|
          (|ParametricSpaceCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((#1=#:G830 NIL) (|b| NIL)
          (|br| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|c3| #2=(|Union| (|Any|) "failed"))
          (|loops| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|tub| (|TubePlot| (|Plot3D|))) (|rad| (|DoubleFloat|))
          (|pts| (|PositiveInteger|)) (|s| #3=(|ThreeSpace| (|DoubleFloat|)))
          (|pl| (|Plot3D|))
          (|fcn|
           (|List| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|))))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|c| #2#) (|pointsColored?| (|Boolean|)) (|c1| #2#)
          (|h| #4=(|Mapping| (|DoubleFloat|) (|DoubleFloat|))) (|g| #4#)
          (|f| #4#) (|sp| #3#))
         (SEQ (LETT |sp| (SPADCALL |l| (QREFELT $ 104)))
              (LETT |f| (SPADCALL |psc| 1 (QREFELT $ 106)))
              (LETT |g| (SPADCALL |psc| 2 (QREFELT $ 106)))
              (LETT |h| (SPADCALL |psc| 3 (QREFELT $ 106)))
              (LETT |fcn|
                    (LIST
                     (CONS #'|DRAWCFUN;makeObject;PscSLTs;16!0|
                           (VECTOR |h| |g| $ |f|))))
              (LETT |pointsColored?| NIL)
              (SEQ (LETT |c1| (SPADCALL |l| '|colorFunction1| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c1| 1))
                      (SEQ (LETT |pointsColored?| 'T)
                           (EXIT
                            (LETT |fcn|
                                  (LIST
                                   (CONS #'|DRAWCFUN;makeObject;PscSLTs;16!1|
                                         (VECTOR |c1| |h| |g| $ |f|))))))))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c| 1))
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |fcn|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;PscSLTs;16!2|
                                     (VECTOR |cc| $ |fcn|))))))))))
              (LETT |pl|
                    (SPADCALL (SPADCALL |fcn| (QREFELT $ 87))
                              (|DRAWCFUN;normalize| |seg| $) (QREFELT $ 110)))
              (LETT |s| |sp|)
              (EXIT
               (COND
                ((SPADCALL |l| '|tubeRadius| (QREFELT $ 111))
                 (SEQ (LETT |pts| (SPADCALL |l| 8 (QREFELT $ 112)))
                      (LETT |rad|
                            (SPADCALL
                             (SPADCALL |l| (SPADCALL 25 -2 10 (QREFELT $ 113))
                                       (QREFELT $ 114))
                             (QREFELT $ 54)))
                      (LETT |tub| (SPADCALL |pl| |rad| |pts| (QREFELT $ 117)))
                      (LETT |loops| (SPADCALL |tub| (QREFELT $ 118)))
                      (COND
                       ((NULL |pointsColored?|)
                        (SEQ
                         (LETT |c3|
                               (SPADCALL |l| '|colorFunction3| (QREFELT $ 36)))
                         (EXIT
                          (COND
                           ((QEQCAR |c3| 1)
                            (|DRAWCFUN;colorPoints| |loops|
                             (CONS (|function| |DRAWCFUN;zCoord|) $) $))
                           (#5='T
                            (|DRAWCFUN;colorPoints| |loops|
                             (SPADCALL (QCDR |c3|) (QREFELT $ 121)) $)))))))
                      (SPADCALL |s| |loops| NIL NIL (QREFELT $ 122))
                      (EXIT |s|)))
                (#5#
                 (SEQ (LETT |br| (SPADCALL |pl| (QREFELT $ 123)))
                      (SEQ (LETT |b| NIL) (LETT #1# |br|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (EXIT (SPADCALL |s| |b| (QREFELT $ 125))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |s|)))))))) 

(SDEFUN |DRAWCFUN;makeObject;PscSLTs;16!2| ((|x| NIL) ($$ NIL))
        (PROG (|fcn| $ |cc|)
          (LETT |fcn| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (SPADCALL |fcn| (QREFELT $ 87)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;PscSLTs;16!1| ((|x| NIL) ($$ NIL))
        (PROG (|f| $ |g| |h| |c1|)
          (LETT |f| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |g| (QREFELT $$ 2))
          (LETT |h| (QREFELT $$ 1))
          (LETT |c1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|DRAWCFUN;makePt4| (|DRAWCFUN;myTrap1| |f| |x| $)
             (|DRAWCFUN;myTrap1| |g| |x| $) (|DRAWCFUN;myTrap1| |h| |x| $)
             (SPADCALL |x| (SPADCALL (QCDR |c1|) (QREFELT $ 108))) $))))) 

(SDEFUN |DRAWCFUN;makeObject;PscSLTs;16!0| ((|x| NIL) ($$ NIL))
        (PROG (|f| $ |g| |h|)
          (LETT |f| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |g| (QREFELT $$ 1))
          (LETT |h| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|DRAWCFUN;makePt4| (|DRAWCFUN;myTrap1| |f| |x| $)
             (|DRAWCFUN;myTrap1| |g| |x| $) (|DRAWCFUN;myTrap1| |h| |x| $)
             (|DRAWCFUN;myTrap1| (CONS (|function| |DRAWCFUN;id|) $) |x| $)
             $))))) 

(SDEFUN |DRAWCFUN;makeObject;MSLTs;17|
        ((|psc| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((#1=#:G848 NIL) (|b| NIL)
          (|br| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|loops| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|tub| (|TubePlot| (|Plot3D|))) (|rad| (|DoubleFloat|))
          (|pts| (|PositiveInteger|)) (|s| #2=(|ThreeSpace| (|DoubleFloat|)))
          (|pl| (|Plot3D|))
          (|fcn|
           (|List| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|))))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|c| #3=(|Union| (|Any|) "failed")) (|c1| #3#) (|sp| #2#))
         (SEQ (LETT |sp| (SPADCALL |l| (QREFELT $ 104)))
              (LETT |fcn| (LIST |psc|))
              (SEQ (LETT |c1| (SPADCALL |l| '|colorFunction1| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c1| 1))
                      (LETT |fcn|
                            (LIST
                             (CONS #'|DRAWCFUN;makeObject;MSLTs;17!0|
                                   (VECTOR $ |c1| |psc|))))))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c| 1))
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |fcn|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;MSLTs;17!1|
                                     (VECTOR |cc| $ |fcn|))))))))))
              (LETT |pl|
                    (SPADCALL (SPADCALL |fcn| (QREFELT $ 87))
                              (|DRAWCFUN;normalize| |seg| $) (QREFELT $ 110)))
              (LETT |s| |sp|)
              (EXIT
               (COND
                ((SPADCALL |l| '|tubeRadius| (QREFELT $ 111))
                 (SEQ (LETT |pts| (SPADCALL |l| 8 (QREFELT $ 112)))
                      (LETT |rad|
                            (SPADCALL
                             (SPADCALL |l| (SPADCALL 25 -2 10 (QREFELT $ 113))
                                       (QREFELT $ 114))
                             (QREFELT $ 54)))
                      (LETT |tub| (SPADCALL |pl| |rad| |pts| (QREFELT $ 117)))
                      (LETT |loops| (SPADCALL |tub| (QREFELT $ 118)))
                      (SPADCALL |s| |loops| NIL NIL (QREFELT $ 122))
                      (EXIT |s|)))
                ('T
                 (SEQ (LETT |br| (SPADCALL |pl| (QREFELT $ 123)))
                      (SEQ (LETT |b| NIL) (LETT #1# |br|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (EXIT (SPADCALL |s| |b| (QREFELT $ 125))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |s|)))))))) 

(SDEFUN |DRAWCFUN;makeObject;MSLTs;17!1| ((|x| NIL) ($$ NIL))
        (PROG (|fcn| $ |cc|)
          (LETT |fcn| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (SPADCALL |fcn| (QREFELT $ 87)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;MSLTs;17!0| ((|x| NIL) ($$ NIL))
        (PROG (|psc| |c1| $)
          (LETT |psc| (QREFELT $$ 2))
          (LETT |c1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |psc|)
                      (SPADCALL |x| (SPADCALL (QCDR |c1|) (QREFELT $ 108)))
                      (QREFELT $ 127)))))) 

(SDEFUN |DRAWCFUN;makeObject;PscSTs;18|
        ((|psc|
          (|ParametricSpaceCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |psc| |seg| NIL (QREFELT $ 126))) 

(SDEFUN |DRAWCFUN;makeObject;MSTs;19|
        ((|psc| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |psc| |seg| NIL (QREFELT $ 128))) 

(SDEFUN |DRAWCFUN;draw;PscSLTdv;20|
        ((|psc|
          (|ParametricSpaceCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG ((|sp| (|ThreeSpace| (|DoubleFloat|))))
               (SEQ (LETT |sp| (SPADCALL |psc| |seg| |l| (QREFELT $ 126)))
                    (EXIT (SPADCALL |sp| |l| (QREFELT $ 132)))))) 

(SDEFUN |DRAWCFUN;draw;PscSTdv;21|
        ((|psc|
          (|ParametricSpaceCurve| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|seg| (|Segment| (|Float|))) ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |psc| |seg| NIL (QREFELT $ 133))) 

(SDEFUN |DRAWCFUN;draw;MSLTdv;22|
        ((|psc| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG ((|sp| (|ThreeSpace| (|DoubleFloat|))))
               (SEQ (LETT |sp| (SPADCALL |psc| |seg| |l| (QREFELT $ 128)))
                    (EXIT (SPADCALL |sp| |l| (QREFELT $ 132)))))) 

(SDEFUN |DRAWCFUN;draw;MSTdv;23|
        ((|psc| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|seg| (|Segment| (|Float|))) ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |psc| |seg| NIL (QREFELT $ 135))) 

(SDEFUN |DRAWCFUN;myTrap2|
        ((|ff| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|u| (|DoubleFloat|)) (|v| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (SPROG ((|r| (|DoubleFloat|)) (|s| (|Union| (|DoubleFloat|) "failed")))
               (SEQ (LETT |s| (|trapNumericErrors| (SPADCALL |u| |v| |ff|)))
                    (EXIT
                     (COND ((QEQCAR |s| 1) 0.0)
                           (#1='T
                            (SEQ (LETT |r| (QCDR |s|))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |r| MOST-POSITIVE-DOUBLE-FLOAT
                                              (QREFELT $ 73))
                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                   ((|less_DF| |r| MOST-NEGATIVE-DOUBLE-FLOAT)
                                    MOST-NEGATIVE-DOUBLE-FLOAT)
                                   (#1# |r|)))))))))) 

(SDEFUN |DRAWCFUN;recolor;MMM;25|
        ((|ptFunc|
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|colFunc|
          (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                     (|DoubleFloat|)))
         ($
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|))))
        (SPROG NIL
               (SEQ
                (CONS #'|DRAWCFUN;recolor;MMM;25!0|
                      (VECTOR |colFunc| $ |ptFunc|))))) 

(SDEFUN |DRAWCFUN;recolor;MMM;25!0| ((|f1| NIL) (|f2| NIL) ($$ NIL))
        (PROG (|ptFunc| $ |colFunc|)
          (LETT |ptFunc| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |colFunc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|pt| NIL))
                   (SEQ (LETT |pt| (SPADCALL |f1| |f2| |ptFunc|))
                        (SPADCALL |pt| 4
                                  (SPADCALL
                                   (SPADCALL |pt| (|spadConstant| $ 138)
                                             (QREFELT $ 101))
                                   (SPADCALL |pt| 2 (QREFELT $ 101))
                                   (SPADCALL |pt| 3 (QREFELT $ 101)) |colFunc|)
                                  (QREFELT $ 102))
                        (EXIT |pt|))))))) 

(PUT '|DRAWCFUN;xCoord| '|SPADreplace| '(XLAM (|x| |y|) |x|)) 

(SDEFUN |DRAWCFUN;xCoord|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) ($ (|DoubleFloat|))) |x|) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;27|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|xSeg| (|Segment| (|Float|))) (|ySeg| (|Segment| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|mesh| (|ThreeSpace| (|DoubleFloat|)))
          (|fcn|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                       (|DoubleFloat|))))
          (|c| #1=(|Union| (|Any|) "failed"))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|col2|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|pointsColored?| (|Boolean|)) (|c2| #1#)
          (|sp| (|ThreeSpace| (|DoubleFloat|))))
         (SEQ (LETT |sp| (SPADCALL |l| (QREFELT $ 104)))
              (LETT |col2| (LIST (CONS (|function| |DRAWCFUN;xCoord|) $)))
              (LETT |pointsColored?| NIL)
              (SEQ (LETT |c2| (SPADCALL |l| '|colorFunction2| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c2| 1))
                      (SEQ (LETT |pointsColored?| 'T)
                           (EXIT
                            (LETT |col2|
                                  (LIST
                                   (SPADCALL (QCDR |c2|)
                                             (QREFELT $ 143))))))))))
              (LETT |fcn|
                    (LIST
                     (CONS #'|DRAWCFUN;makeObject;M2SLTs;27!0|
                           (VECTOR |col2| $ |f|))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((QEQCAR |c| 1)
                      (LETT |fcn|
                            (LIST
                             (CONS #'|DRAWCFUN;makeObject;M2SLTs;27!1|
                                   (VECTOR |col2| $ |f|)))))
                     (#2='T
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |fcn|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;M2SLTs;27!2|
                                     (VECTOR |cc| $ |fcn|))))))))))
              (COND
               ((NULL |pointsColored?|)
                (SEQ (LETT |c| (SPADCALL |l| '|colorFunction3| (QREFELT $ 36)))
                     (EXIT
                      (LETT |fcn|
                            (COND
                             ((QEQCAR |c| 1)
                              (LIST
                               (SPADCALL (SPADCALL |fcn| (QREFELT $ 147))
                                         (CONS (|function| |DRAWCFUN;zCoord|)
                                               $)
                                         (QREFELT $ 140))))
                             (#2#
                              (LIST
                               (SPADCALL (SPADCALL |fcn| (QREFELT $ 147))
                                         (SPADCALL (QCDR |c|) (QREFELT $ 121))
                                         (QREFELT $ 140))))))))))
              (LETT |mesh|
                    (SPADCALL |sp| (SPADCALL |fcn| (QREFELT $ 147))
                              (|DRAWCFUN;normalize| |xSeg| $)
                              (|DRAWCFUN;normalize| |ySeg| $) |l|
                              (QREFELT $ 149)))
              (EXIT |mesh|)))) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;27!2| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|fcn| $ |cc|)
          (LETT |fcn| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |y| (SPADCALL |fcn| (QREFELT $ 147)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;27!1| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|f| $ |col2|)
          (LETT |f| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |col2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|DRAWCFUN;makePt4| |x| |y| (|DRAWCFUN;myTrap2| |f| |x| |y| $)
             (SPADCALL |x| |y| (SPADCALL |col2| (QREFELT $ 145))) $))))) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;27!0| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|f| $ |col2|)
          (LETT |f| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |col2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|DRAWCFUN;makePt4| (|DRAWCFUN;myTrap2| |f| |x| |y| $) |x| |y|
             (SPADCALL |x| |y| (SPADCALL |col2| (QREFELT $ 145))) $))))) 

(SDEFUN |DRAWCFUN;makeObject;M2STs;28|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|xSeg| (|Segment| (|Float|))) (|ySeg| (|Segment| (|Float|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |f| |xSeg| |ySeg| NIL (QREFELT $ 150))) 

(SDEFUN |DRAWCFUN;draw;M2SLTdv;29|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|xSeg| (|Segment| (|Float|))) (|ySeg| (|Segment| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|ThreeDimensionalViewport|)))
        (SPROG ((|sp| (|ThreeSpace| (|DoubleFloat|))))
               (SEQ
                (LETT |sp| (SPADCALL |f| |xSeg| |ySeg| |l| (QREFELT $ 150)))
                (EXIT (SPADCALL |sp| |l| (QREFELT $ 132)))))) 

(SDEFUN |DRAWCFUN;draw;M2STdv;30|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|xSeg| (|Segment| (|Float|))) (|ySeg| (|Segment| (|Float|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |f| |xSeg| |ySeg| NIL (QREFELT $ 152))) 

(SDEFUN |DRAWCFUN;makeObject;Ps2SLTs;31|
        ((|s|
          (|ParametricSurface|
           (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|mesh| (|ThreeSpace| (|DoubleFloat|)))
          (|fcn|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                       (|DoubleFloat|))))
          (|col3|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                       (|DoubleFloat|))))
          (|c| #1=(|Union| (|Any|) "failed"))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|col2|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|pointsColored?| (|Boolean|)) (|c2| #1#)
          (|h|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|g|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|f|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|sp| (|ThreeSpace| (|DoubleFloat|))))
         (SEQ (LETT |sp| (SPADCALL |l| (QREFELT $ 104)))
              (LETT |f|
                    (LIST
                     (SPADCALL |s| (|spadConstant| $ 154) (QREFELT $ 156))))
              (LETT |g| (LIST (SPADCALL |s| 2 (QREFELT $ 156))))
              (LETT |h| (LIST (SPADCALL |s| 3 (QREFELT $ 156))))
              (LETT |col2| (LIST (CONS (|function| |DRAWCFUN;xCoord|) $)))
              (LETT |pointsColored?| NIL)
              (SEQ (LETT |c2| (SPADCALL |l| '|colorFunction2| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c2| 1))
                      (SEQ (LETT |pointsColored?| 'T)
                           (EXIT
                            (LETT |col2|
                                  (LIST
                                   (SPADCALL (QCDR |c2|)
                                             (QREFELT $ 143))))))))))
              (LETT |fcn|
                    (LIST
                     (CONS #'|DRAWCFUN;makeObject;Ps2SLTs;31!0|
                           (VECTOR |col2| |h| |g| $ |f|))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c| 1))
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |fcn|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;Ps2SLTs;31!1|
                                     (VECTOR |cc| $ |fcn|))))))))))
              (COND
               ((NULL |pointsColored?|)
                (SEQ
                 (LETT |col3| (LIST (CONS (|function| |DRAWCFUN;zCoord|) $)))
                 (SEQ
                  (LETT |c| (SPADCALL |l| '|colorFunction3| (QREFELT $ 36)))
                  (EXIT
                   (COND
                    ((NULL (QEQCAR |c| 1))
                     (LETT |col3|
                           (LIST (SPADCALL (QCDR |c|) (QREFELT $ 121))))))))
                 (EXIT
                  (LETT |fcn|
                        (LIST
                         (SPADCALL (SPADCALL |fcn| (QREFELT $ 147))
                                   (SPADCALL |col3| (QREFELT $ 158))
                                   (QREFELT $ 140))))))))
              (LETT |mesh|
                    (SPADCALL |sp| (SPADCALL |fcn| (QREFELT $ 147))
                              (|DRAWCFUN;normalize| |uSeg| $)
                              (|DRAWCFUN;normalize| |vSeg| $) |l|
                              (QREFELT $ 149)))
              (EXIT |mesh|)))) 

(SDEFUN |DRAWCFUN;makeObject;Ps2SLTs;31!1| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|fcn| $ |cc|)
          (LETT |fcn| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |y| (SPADCALL |fcn| (QREFELT $ 147)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;Ps2SLTs;31!0| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|f| $ |g| |h| |col2|)
          (LETT |f| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |g| (QREFELT $$ 2))
          (LETT |h| (QREFELT $$ 1))
          (LETT |col2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|DRAWCFUN;makePt4|
             (|DRAWCFUN;myTrap2| (SPADCALL |f| (QREFELT $ 145)) |x| |y| $)
             (|DRAWCFUN;myTrap2| (SPADCALL |g| (QREFELT $ 145)) |x| |y| $)
             (|DRAWCFUN;myTrap2| (SPADCALL |h| (QREFELT $ 145)) |x| |y| $)
             (|DRAWCFUN;myTrap2| (SPADCALL |col2| (QREFELT $ 145)) |x| |y| $)
             $))))) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;32|
        ((|s|
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|mesh| (|ThreeSpace| (|DoubleFloat|)))
          (|fcn|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                       (|DoubleFloat|))))
          (|cc|
           (|List|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
          (|c| #1=(|Union| (|Any|) "failed"))
          (|col2|
           (|List|
            (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
          (|pointsColored?| (|Boolean|)) (|c2| #1#)
          (|sp| (|ThreeSpace| (|DoubleFloat|))))
         (SEQ (LETT |sp| (SPADCALL |l| (QREFELT $ 104)))
              (LETT |col2| (LIST (CONS (|function| |DRAWCFUN;xCoord|) $)))
              (LETT |pointsColored?| NIL)
              (SEQ (LETT |c2| (SPADCALL |l| '|colorFunction2| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c2| 1))
                      (SEQ (LETT |pointsColored?| 'T)
                           (EXIT
                            (LETT |col2|
                                  (LIST
                                   (SPADCALL (QCDR |c2|)
                                             (QREFELT $ 143))))))))))
              (LETT |fcn|
                    (COND
                     (|pointsColored?|
                      (LIST
                       (CONS #'|DRAWCFUN;makeObject;M2SLTs;32!0|
                             (VECTOR $ |col2| |s|))))
                     ('T (LIST |s|))))
              (SEQ (LETT |c| (SPADCALL |l| '|coordinates| (QREFELT $ 36)))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |c| 1))
                      (SEQ
                       (LETT |cc| (LIST (SPADCALL (QCDR |c|) (QREFELT $ 82))))
                       (EXIT
                        (LETT |fcn|
                              (LIST
                               (CONS #'|DRAWCFUN;makeObject;M2SLTs;32!1|
                                     (VECTOR |cc| $ |fcn|))))))))))
              (LETT |mesh|
                    (SPADCALL |sp| (SPADCALL |fcn| (QREFELT $ 147))
                              (|DRAWCFUN;normalize| |uSeg| $)
                              (|DRAWCFUN;normalize| |vSeg| $) |l|
                              (QREFELT $ 149)))
              (EXIT |mesh|)))) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;32!1| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|fcn| $ |cc|)
          (LETT |fcn| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |cc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |y| (SPADCALL |fcn| (QREFELT $ 147)))
                      (SPADCALL |cc| (QREFELT $ 84))))))) 

(SDEFUN |DRAWCFUN;makeObject;M2SLTs;32!0| ((|x| NIL) (|y| NIL) ($$ NIL))
        (PROG (|s| |col2| $)
          (LETT |s| (QREFELT $$ 2))
          (LETT |col2| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |y| |s|)
                      (SPADCALL |x| |y| (SPADCALL |col2| (QREFELT $ 145)))
                      (QREFELT $ 127)))))) 

(SDEFUN |DRAWCFUN;makeObject;Ps2STs;33|
        ((|s|
          (|ParametricSurface|
           (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |s| |uSeg| |vSeg| NIL (QREFELT $ 159))) 

(SDEFUN |DRAWCFUN;draw;Ps2SLTdv;34|
        ((|s|
          (|ParametricSurface|
           (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|ThreeDimensionalViewport|)))
        (SPROG ((|mesh| (|ThreeSpace| (|DoubleFloat|))))
               (SEQ
                (LETT |mesh| (SPADCALL |s| |uSeg| |vSeg| |l| (QREFELT $ 159)))
                (EXIT (SPADCALL |mesh| |l| (QREFELT $ 132)))))) 

(SDEFUN |DRAWCFUN;draw;Ps2STdv;35|
        ((|s|
          (|ParametricSurface|
           (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |s| |uSeg| |vSeg| NIL (QREFELT $ 162))) 

(SDEFUN |DRAWCFUN;makeObject;M2STs;36|
        ((|s|
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL |s| |uSeg| |vSeg| NIL (QREFELT $ 160))) 

(SDEFUN |DRAWCFUN;draw;M2SLTdv;37|
        ((|s|
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         (|l| (|List| (|DrawOption|))) ($ (|ThreeDimensionalViewport|)))
        (SPROG ((|mesh| (|ThreeSpace| (|DoubleFloat|))))
               (SEQ
                (LETT |mesh| (SPADCALL |s| |uSeg| |vSeg| |l| (QREFELT $ 160)))
                (EXIT (SPADCALL |mesh| |l| (QREFELT $ 132)))))) 

(SDEFUN |DRAWCFUN;draw;M2STdv;38|
        ((|s|
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|uSeg| (|Segment| (|Float|))) (|vSeg| (|Segment| (|Float|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |s| |uSeg| |vSeg| NIL (QREFELT $ 165))) 

(DECLAIM (NOTINLINE |TopLevelDrawFunctionsForCompiledFunctions;|)) 

(DEFUN |TopLevelDrawFunctionsForCompiledFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G1006)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|TopLevelDrawFunctionsForCompiledFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|TopLevelDrawFunctionsForCompiledFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|TopLevelDrawFunctionsForCompiledFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|TopLevelDrawFunctionsForCompiledFunctions|)))))))))) 

(DEFUN |TopLevelDrawFunctionsForCompiledFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TopLevelDrawFunctionsForCompiledFunctions|))
          (LETT $ (GETREFV 167))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|TopLevelDrawFunctionsForCompiledFunctions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    "draw: when specifying function, left hand side must be a variable")
          (QSETREFV $ 7 "draw: range is in interval with only one point")
          (QSETREFV $ 8
                    "draw: independent variable appears on lhs of function definition")
          $))) 

(MAKEPROP '|TopLevelDrawFunctionsForCompiledFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL 'EXTOVARERROR 'SMALLRANGEERROR
              'DEPVARERROR (|DoubleFloat|) (|Segment| 9) (0 . |high|) (|Float|)
              (5 . |convert|) (10 . |low|) (15 . -) (21 . |abs|) (|Integer|)
              (26 . /) (|Boolean|) (32 . >) (38 . +) (|Segment| 12)
              (44 . |segment|) (|Mapping| 12 9) (|SegmentFunctions2| 9 12)
              (50 . |map|) (|List| 124) (|Plot|) (56 . |listBranches|)
              (61 . |xRange|) (66 . |yRange|) (|Union| 48 '"failed") (|List| $)
              (|Symbol|) (|DrawOption|) (71 . |option|) (|GraphicsDefaults|)
              (77 . |clipPointsDefault|) (|List| 35) (|DrawOptionFunctions0|)
              (81 . |clipBoolean|) (87 . |parametric?|)
              (|Record| (|:| |brans| 27) (|:| |xValues| 10) (|:| |yValues| 10))
              (|TwoDimensionalPlotClipping|) (92 . |clipParametric|)
              (97 . |clip|) (|List| 22) (|Any|) (|AnyFunctions1| 47)
              (102 . |retract|) (|NonNegativeInteger|) (107 . |more?|)
              (113 . |low|) (118 . |convert|) (123 . |high|) (128 . |second|)
              (133 . |clipWithRanges|) (142 . |drawToScale|) (146 . |toScale|)
              (152 . |ranges|) (|Palette|) (|ViewDefaultsPackage|)
              (157 . |pointColorDefault|) (161 . |pointColorPalette|)
              (167 . |lineColorDefault|) (171 . |curveColorPalette|)
              (|PositiveInteger|) (177 . |pointSizeDefault|) (|GraphImage|)
              (|ViewportPackage|) (181 . |graphCurves|) (190 . |segment|)
              (196 . >) (|List| 9) (|Point| 9) (202 . |point|)
              (207 . |adaptive?|) (211 . |adaptive|) (217 . |setAdaptive|)
              (|Mapping| 75 75) (|AnyFunctions1| 80) (222 . |retract|)
              (|List| 80) (227 . |first|) (|Mapping| 75 9) (|List| 85)
              (232 . |first|) (237 . |pointPlot|) (|Mapping| 9 9)
              |DRAWCFUN;makeObject;MSLGi;6| (|TwoDimensionalViewport|)
              (243 . |makeViewport2D|) |DRAWCFUN;draw;MSLTdv;7|
              |DRAWCFUN;draw;MSTdv;8| (249 . |One|) (|ParametricPlaneCurve| 89)
              (253 . |coordinate|) |DRAWCFUN;makeObject;PpcSLGi;9|
              |DRAWCFUN;draw;PpcSLTdv;10| |DRAWCFUN;draw;PpcSTdv;11|
              (259 . |elt|) (265 . |setelt!|) (|ThreeSpace| 9) (272 . |space|)
              (|ParametricSpaceCurve| 89) (277 . |coordinate|)
              (|AnyFunctions1| 89) (283 . |retract|) (|Plot3D|)
              (288 . |pointPlot|) (294 . |option?|) (300 . |tubePoints|)
              (306 . |float|) (313 . |tubeRadius|) (|TubePlot| 109)
              (|NumericTubePlot| 109) (319 . |tube|) (326 . |listLoops|)
              (|Mapping| 9 9 9 9) (|AnyFunctions1| 119) (331 . |retract|)
              (336 . |mesh|) (344 . |listBranches|) (|List| 75) (349 . |curve|)
              |DRAWCFUN;makeObject;PscSLTs;16| (355 . |concat|)
              |DRAWCFUN;makeObject;MSLTs;17| |DRAWCFUN;makeObject;PscSTs;18|
              |DRAWCFUN;makeObject;MSTs;19| (|ThreeDimensionalViewport|)
              (361 . |makeViewport3D|) |DRAWCFUN;draw;PscSLTdv;20|
              |DRAWCFUN;draw;PscSTdv;21| |DRAWCFUN;draw;MSLTdv;22|
              |DRAWCFUN;draw;MSTdv;23| (367 . |One|) (371 . |One|)
              (|Mapping| 75 9 9) |DRAWCFUN;recolor;MMM;25| (|Mapping| 9 9 9)
              (|AnyFunctions1| 141) (375 . |retract|) (|List| 141)
              (380 . |first|) (|List| 139) (385 . |first|)
              (|MeshCreationRoutinesForThreeDimensions|) (390 . |meshPar2Var|)
              |DRAWCFUN;makeObject;M2SLTs;27| |DRAWCFUN;makeObject;M2STs;28|
              |DRAWCFUN;draw;M2SLTdv;29| |DRAWCFUN;draw;M2STdv;30|
              (399 . |One|) (|ParametricSurface| 141) (403 . |coordinate|)
              (|List| 119) (409 . |first|) |DRAWCFUN;makeObject;Ps2SLTs;31|
              |DRAWCFUN;makeObject;M2SLTs;32| |DRAWCFUN;makeObject;Ps2STs;33|
              |DRAWCFUN;draw;Ps2SLTdv;34| |DRAWCFUN;draw;Ps2STdv;35|
              |DRAWCFUN;makeObject;M2STs;36| |DRAWCFUN;draw;M2SLTdv;37|
              |DRAWCFUN;draw;M2STdv;38|)
           '#(|recolor| 414 |makeObject| 420 |draw| 505) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|GraphImage|)
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|ParametricPlaneCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|ParametricPlaneCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|GraphImage|)
                                  (|ParametricPlaneCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSpaceCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSpaceCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSpaceCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSpaceCurve|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                                  (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSurface|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                              (|DoubleFloat|)))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|ParametricSurface|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                              (|DoubleFloat|)))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSurface|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                              (|DoubleFloat|)))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|makeObject|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ParametricSurface|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                              (|DoubleFloat|)))
                                  (|Segment| (|Float|)) (|Segment| (|Float|))))
                                T)
                              '((|recolor|
                                 ((|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|) (|DoubleFloat|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 166
                                            '(1 10 9 0 11 1 12 0 9 13 1 10 9 0
                                              14 2 12 0 0 0 15 1 12 0 0 16 2 12
                                              0 0 17 18 2 12 19 0 0 20 2 12 0 0
                                              0 21 2 22 0 12 12 23 2 25 22 24
                                              10 26 1 28 27 0 29 1 28 10 0 30 1
                                              28 10 0 31 2 35 32 33 34 36 0 37
                                              19 38 2 40 19 39 19 41 1 28 19 0
                                              42 1 44 43 28 45 1 44 43 28 46 1
                                              49 47 48 50 2 47 19 0 51 52 1 22
                                              12 0 53 1 12 9 0 54 1 22 12 0 55
                                              1 47 22 0 56 5 44 43 27 9 9 9 9
                                              57 0 37 19 58 2 40 19 39 19 59 1
                                              35 0 47 60 0 62 61 63 2 40 61 39
                                              61 64 0 62 61 65 2 40 61 39 61 66
                                              0 62 67 68 5 70 69 27 61 61 67 39
                                              71 2 10 0 9 9 72 2 9 19 0 0 73 1
                                              75 0 74 76 0 28 19 77 2 40 19 39
                                              19 78 1 28 19 19 79 1 81 80 48 82
                                              1 83 80 0 84 1 86 85 0 87 2 28 0
                                              85 10 88 2 91 0 69 39 92 0 12 0
                                              95 2 96 89 0 51 97 2 75 9 0 17
                                              101 3 75 9 0 17 9 102 1 40 103 39
                                              104 2 105 89 0 51 106 1 107 89 48
                                              108 2 109 0 85 10 110 2 35 19 33
                                              34 111 2 40 67 39 67 112 3 12 0
                                              17 17 67 113 2 40 12 39 12 114 3
                                              116 115 109 9 17 117 1 115 27 0
                                              118 1 120 119 48 121 4 103 0 0 27
                                              19 19 122 1 109 27 0 123 2 103 0
                                              0 124 125 2 75 0 0 9 127 2 131 0
                                              103 39 132 0 9 0 137 0 67 0 138 1
                                              142 141 48 143 1 144 141 0 145 1
                                              146 139 0 147 5 148 103 103 139
                                              10 10 39 149 0 51 0 154 2 155 141
                                              0 51 156 1 157 119 0 158 2 0 139
                                              139 119 140 3 0 69 89 22 39 90 3
                                              0 69 96 22 39 98 3 0 103 105 22
                                              39 126 3 0 103 85 22 39 128 2 0
                                              103 105 22 129 2 0 103 85 22 130
                                              3 0 103 141 22 22 151 4 0 103 141
                                              22 22 39 150 4 0 103 139 22 22 39
                                              160 3 0 103 139 22 22 164 4 0 103
                                              155 22 22 39 159 3 0 103 155 22
                                              22 161 3 0 91 89 22 39 93 2 0 91
                                              89 22 94 3 0 91 96 22 39 99 2 0
                                              91 96 22 100 3 0 131 105 22 39
                                              133 3 0 131 85 22 39 135 2 0 131
                                              105 22 134 2 0 131 85 22 136 3 0
                                              131 141 22 22 153 4 0 131 141 22
                                              22 39 152 3 0 131 139 22 22 166 4
                                              0 131 139 22 22 39 165 4 0 131
                                              155 22 22 39 162 3 0 131 155 22
                                              22 163)))))
           '|lookupComplete|)) 

(MAKEPROP '|TopLevelDrawFunctionsForCompiledFunctions| 'NILADIC T) 
