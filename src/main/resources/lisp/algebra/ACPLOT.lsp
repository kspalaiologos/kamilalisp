
(SDEFUN |ACPLOT;NFtoSF| ((|x| (|Float|)) ($ (|DoubleFloat|)))
        (|add_DF| 0.0 (SPADCALL |x| (QREFELT $ 22)))) 

(SDEFUN |ACPLOT;makePt|
        ((|xx| (|DoubleFloat|)) (|yy| #1=(|DoubleFloat|))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |xx| |yy|)) (QREFELT $ 25)))) 

(SDEFUN |ACPLOT;swapCoords|
        ((|pt| (|Point| (|DoubleFloat|))) ($ (|Point| (|DoubleFloat|))))
        (|ACPLOT;makePt| (SPADCALL |pt| (QREFELT $ 27))
         (SPADCALL |pt| (QREFELT $ 28)) $)) 

(SDEFUN |ACPLOT;samePlottedPt?|
        ((|p0| (|Point| (|DoubleFloat|))) (|p1| (|Point| (|DoubleFloat|)))
         ($ (|Boolean|)))
        (SPROG
         ((|y1| #1=(|DoubleFloat|)) (|x1| #2=(|DoubleFloat|)) (|y0| #1#)
          (|x0| #2#))
         (SEQ (LETT |x0| (SPADCALL |p0| (QREFELT $ 28)))
              (LETT |y0| (SPADCALL |p0| (QREFELT $ 27)))
              (LETT |x1| (SPADCALL |p1| (QREFELT $ 28)))
              (LETT |y1| (SPADCALL |p1| (QREFELT $ 27)))
              (EXIT
               (COND
                ((|less_DF| (|abs_DF| (|sub_DF| |x1| |x0|)) (QREFELT $ 15))
                 (|less_DF| (|abs_DF| (|sub_DF| |y1| |y0|)) (QREFELT $ 15)))
                ('T NIL)))))) 

(SDEFUN |ACPLOT;findPtOnList|
        ((|pt| (|Point| (|DoubleFloat|)))
         (|pointList| (|List| (|Point| (|DoubleFloat|))))
         ($ (|Union| (|Point| (|DoubleFloat|)) "failed")))
        (SPROG ((#1=#:G789 NIL) (#2=#:G790 NIL) (#3=#:G791 NIL) (|point| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |point| NIL) (LETT #3# |pointList|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |point| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|ACPLOT;samePlottedPt?| |pt| |point| $)
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 0 |point|))
                                     (GO #4=#:G788)))
                              (GO #5=#:G786))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(PUT '|ACPLOT;makeCorners| '|SPADreplace| 'VECTOR) 

(SDEFUN |ACPLOT;makeCorners|
        ((|xMinSF| (|DoubleFloat|)) (|xMaxSF| (|DoubleFloat|))
         (|yMinSF| (|DoubleFloat|)) (|yMaxSF| (|DoubleFloat|))
         ($
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|)))))
        (VECTOR |xMinSF| |xMaxSF| |yMinSF| |yMaxSF|)) 

(PUT '|ACPLOT;getXMin| '|SPADreplace| '(XLAM (|corners|) (QVELT |corners| 0))) 

(SDEFUN |ACPLOT;getXMin|
        ((|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         ($ (|DoubleFloat|)))
        (QVELT |corners| 0)) 

(PUT '|ACPLOT;getXMax| '|SPADreplace| '(XLAM (|corners|) (QVELT |corners| 1))) 

(SDEFUN |ACPLOT;getXMax|
        ((|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         ($ (|DoubleFloat|)))
        (QVELT |corners| 1)) 

(PUT '|ACPLOT;getYMin| '|SPADreplace| '(XLAM (|corners|) (QVELT |corners| 2))) 

(SDEFUN |ACPLOT;getYMin|
        ((|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         ($ (|DoubleFloat|)))
        (QVELT |corners| 2)) 

(PUT '|ACPLOT;getYMax| '|SPADreplace| '(XLAM (|corners|) (QVELT |corners| 3))) 

(SDEFUN |ACPLOT;getYMax|
        ((|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         ($ (|DoubleFloat|)))
        (QVELT |corners| 3)) 

(SDEFUN |ACPLOT;SFPolyToUPoly|
        ((|p| (|Polynomial| (|DoubleFloat|)))
         ($ (|SparseUnivariatePolynomial| (|DoubleFloat|))))
        (COND ((SPADCALL |p| (QREFELT $ 31)) (|spadConstant| $ 33))
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |p| (QREFELT $ 34))
                          (SPADCALL |p| (QREFELT $ 36)) (QREFELT $ 37))
                (|ACPLOT;SFPolyToUPoly| (SPADCALL |p| (QREFELT $ 38)) $)
                (QREFELT $ 39))))) 

(SDEFUN |ACPLOT;RNPolyToUPoly|
        ((|p| (|Polynomial| (|Fraction| (|Integer|))))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (COND ((SPADCALL |p| (QREFELT $ 41)) (|spadConstant| $ 43))
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |p| (QREFELT $ 45))
                          (SPADCALL |p| (QREFELT $ 46)) (QREFELT $ 47))
                (|ACPLOT;RNPolyToUPoly| (SPADCALL |p| (QREFELT $ 48)) $)
                (QREFELT $ 49))))) 

(SDEFUN |ACPLOT;coerceCoefsToSFs|
        ((|p| (|Polynomial| (|Integer|))) ($ (|Polynomial| (|DoubleFloat|))))
        (SPADCALL (ELT $ 50) |p| (QREFELT $ 54))) 

(SDEFUN |ACPLOT;coerceCoefsToRNs|
        ((|p| (|Polynomial| (|Integer|)))
         ($ (|Polynomial| (|Fraction| (|Integer|)))))
        (SPADCALL (ELT $ 55) |p| (QREFELT $ 58))) 

(SDEFUN |ACPLOT;RNtoSF| ((|r| (|Fraction| (|Integer|))) ($ (|DoubleFloat|)))
        (SPADCALL |r| (QREFELT $ 59))) 

(SDEFUN |ACPLOT;RNtoNF| ((|r| (|Fraction| (|Integer|))) ($ (|Float|)))
        (SPADCALL |r| (QREFELT $ 60))) 

(SDEFUN |ACPLOT;SFtoNF| ((|x| (|DoubleFloat|)) ($ (|Float|)))
        (SPADCALL |x| (QREFELT $ 61))) 

(SDEFUN |ACPLOT;listPtsOnHorizBdry|
        ((|pRN| (|Polynomial| (|Fraction| (|Integer|)))) (|y| (|Symbol|))
         (|y0| (|Fraction| (|Integer|))) (|xMinNF| (|Float|))
         (|xMaxNF| (|Float|)) ($ (|List| (|Point| (|DoubleFloat|)))))
        (SPROG
         ((|pointList| (|List| (|Point| (|DoubleFloat|)))) (#1=#:G825 NIL)
          (|root| NIL) (|roots| (|List| (|Float|)))
          (|f| (|Polynomial| (|Fraction| (|Integer|))))
          (|ySF| (|DoubleFloat|)))
         (SEQ (LETT |pointList| NIL) (LETT |ySF| (|ACPLOT;RNtoSF| |y0| $))
              (LETT |f| (SPADCALL |pRN| |y| |y0| (QREFELT $ 63)))
              (LETT |roots| (SPADCALL |f| (QREFELT $ 12) (QREFELT $ 66)))
              (SEQ (LETT |root| NIL) (LETT #1# |roots|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |root| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |xMinNF| |root| (QREFELT $ 67))
                       (COND
                        ((SPADCALL |root| |xMaxNF| (QREFELT $ 67))
                         (LETT |pointList|
                               (CONS
                                (|ACPLOT;makePt| (|ACPLOT;NFtoSF| |root| $)
                                 |ySF| $)
                                |pointList|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |pointList|)))) 

(SDEFUN |ACPLOT;listPtsOnVertBdry|
        ((|pRN| (|Polynomial| (|Fraction| (|Integer|)))) (|x| (|Symbol|))
         (|x0| (|Fraction| (|Integer|))) (|yMinNF| (|Float|))
         (|yMaxNF| (|Float|)) ($ (|List| (|Point| (|DoubleFloat|)))))
        (SPROG
         ((|pointList| (|List| (|Point| (|DoubleFloat|)))) (#1=#:G830 NIL)
          (|root| NIL) (|roots| (|List| (|Float|)))
          (|f| (|Polynomial| (|Fraction| (|Integer|))))
          (|xSF| (|DoubleFloat|)))
         (SEQ (LETT |pointList| NIL) (LETT |xSF| (|ACPLOT;RNtoSF| |x0| $))
              (LETT |f| (SPADCALL |pRN| |x| |x0| (QREFELT $ 63)))
              (LETT |roots| (SPADCALL |f| (QREFELT $ 12) (QREFELT $ 66)))
              (SEQ (LETT |root| NIL) (LETT #1# |roots|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |root| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |yMinNF| |root| (QREFELT $ 68))
                       (COND
                        ((SPADCALL |root| |yMaxNF| (QREFELT $ 68))
                         (LETT |pointList|
                               (CONS
                                (|ACPLOT;makePt| |xSF|
                                 (|ACPLOT;NFtoSF| |root| $) $)
                                |pointList|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |pointList|)))) 

(SDEFUN |ACPLOT;listPtsInRect|
        ((|points| (|List| (|List| (|Float|)))) (|xMin| (|Float|))
         (|xMax| (|Float|)) (|yMin| (|Float|)) (|yMax| (|Float|))
         ($ (|List| (|Point| (|DoubleFloat|)))))
        (SPROG
         ((|pointList| (|List| (|Point| (|DoubleFloat|)))) (|yy| (|Float|))
          (|xx| (|Float|)) (#1=#:G838 NIL) (|point| NIL))
         (SEQ (LETT |pointList| NIL)
              (SEQ (LETT |point| NIL) (LETT #1# |points|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |point| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |xx| (|SPADfirst| |point|))
                        (LETT |yy| (SPADCALL |point| (QREFELT $ 69)))
                        (EXIT
                         (COND
                          ((SPADCALL |xMin| |xx| (QREFELT $ 68))
                           (COND
                            ((SPADCALL |xx| |xMax| (QREFELT $ 68))
                             (COND
                              ((SPADCALL |yMin| |yy| (QREFELT $ 68))
                               (COND
                                ((SPADCALL |yy| |yMax| (QREFELT $ 68))
                                 (LETT |pointList|
                                       (CONS
                                        (|ACPLOT;makePt|
                                         (|ACPLOT;NFtoSF| |xx| $)
                                         (|ACPLOT;NFtoSF| |yy| $) $)
                                        |pointList|))))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |pointList|)))) 

(SDEFUN |ACPLOT;ptsSuchThat?|
        ((|points| (|List| (|List| (|Float|))))
         (|pred| (|Mapping| (|Boolean|) (|List| (|Float|)))) ($ (|Boolean|)))
        (SPROG ((#1=#:G844 NIL) (#2=#:G845 NIL) (|point| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |point| NIL) (LETT #2# |points|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |point| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |point| |pred|)
                           (PROGN (LETT #1# 'T) (GO #3=#:G843))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |ACPLOT;inRect?|
        ((|point| (|List| (|Float|))) (|xMinNF| (|Float|)) (|xMaxNF| (|Float|))
         (|yMinNF| (|Float|)) (|yMaxNF| (|Float|)) ($ (|Boolean|)))
        (SPROG ((|yy| (|Float|)) (|xx| (|Float|)))
               (SEQ (LETT |xx| (|SPADfirst| |point|))
                    (LETT |yy| (SPADCALL |point| (QREFELT $ 69)))
                    (EXIT
                     (COND
                      ((SPADCALL |xMinNF| |xx| (QREFELT $ 68))
                       (COND
                        ((SPADCALL |xx| |xMaxNF| (QREFELT $ 68))
                         (COND
                          ((SPADCALL |yMinNF| |yy| (QREFELT $ 68))
                           (SPADCALL |yy| |yMaxNF| (QREFELT $ 68)))
                          (#1='T NIL)))
                        (#1# NIL)))
                      (#1# NIL)))))) 

(SDEFUN |ACPLOT;onHorzSeg?|
        ((|point| (|List| (|Float|))) (|xMinNF| (|Float|)) (|xMaxNF| (|Float|))
         (|yNF| (|Float|)) ($ (|Boolean|)))
        (SPROG ((|yy| (|Float|)) (|xx| (|Float|)))
               (SEQ (LETT |xx| (|SPADfirst| |point|))
                    (LETT |yy| (SPADCALL |point| (QREFELT $ 69)))
                    (EXIT
                     (COND
                      ((SPADCALL |yy| |yNF| (QREFELT $ 70))
                       (COND
                        ((SPADCALL |xMinNF| |xx| (QREFELT $ 68))
                         (SPADCALL |xx| |xMaxNF| (QREFELT $ 68)))
                        (#1='T NIL)))
                      (#1# NIL)))))) 

(SDEFUN |ACPLOT;onVertSeg?|
        ((|point| (|List| (|Float|))) (|yMinNF| (|Float|)) (|yMaxNF| (|Float|))
         (|xNF| (|Float|)) ($ (|Boolean|)))
        (SPROG ((|yy| (|Float|)) (|xx| (|Float|)))
               (SEQ (LETT |xx| (|SPADfirst| |point|))
                    (LETT |yy| (SPADCALL |point| (QREFELT $ 69)))
                    (EXIT
                     (COND
                      ((SPADCALL |xx| |xNF| (QREFELT $ 70))
                       (COND
                        ((SPADCALL |yMinNF| |yy| (QREFELT $ 68))
                         (SPADCALL |yy| |yMaxNF| (QREFELT $ 68)))
                        (#1='T NIL)))
                      (#1# NIL)))))) 

(SDEFUN |ACPLOT;newX|
        ((|vtanPts| (|List| (|List| (|Float|))))
         (|singPts| (|List| (|List| (|Float|)))) (|yMinNF| (|Float|))
         (|yMaxNF| (|Float|)) (|xNF| (|Float|))
         (|xRN| (|Fraction| (|Integer|))) (|horizInc| (|Fraction| (|Integer|)))
         ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|goo| (|Mapping| (|Boolean|) (|List| (|Float|))))
          (|foo| (|Mapping| (|Boolean|) (|List| (|Float|))))
          (|xLftNF| (|Float|)) (|xRtNF| (|Float|)) (|xNewNF| (|Float|)))
         (SEQ
          (LETT |xNewNF|
                (SPADCALL |xNF| (|ACPLOT;RNtoNF| |horizInc| $) (QREFELT $ 71)))
          (LETT |xRtNF| (SPADCALL |xNF| |xNewNF| (QREFELT $ 72)))
          (LETT |xLftNF| (SPADCALL |xNF| |xNewNF| (QREFELT $ 73)))
          (LETT |foo|
                (CONS #'|ACPLOT;newX!0|
                      (VECTOR $ |yMaxNF| |yMinNF| |xRtNF| |xLftNF|)))
          (EXIT
           (COND
            ((|ACPLOT;ptsSuchThat?| |singPts| |foo| $)
             (|ACPLOT;newX| |vtanPts| |singPts| |yMinNF| |yMaxNF| |xNF| |xRN|
              (SPADCALL |horizInc| (SPADCALL 2 (QREFELT $ 55)) (QREFELT $ 74))
              $))
            (#1='T
             (SEQ
              (LETT |goo|
                    (CONS #'|ACPLOT;newX!1|
                          (VECTOR $ |xNewNF| |yMaxNF| |yMinNF|)))
              (EXIT
               (COND
                ((|ACPLOT;ptsSuchThat?| |vtanPts| |goo| $)
                 (|ACPLOT;newX| |vtanPts| |singPts| |yMinNF| |yMaxNF| |xNF|
                  |xRN|
                  (SPADCALL |horizInc| (SPADCALL 2 (QREFELT $ 55))
                            (QREFELT $ 74))
                  $))
                (#1# (SPADCALL |xRN| |horizInc| (QREFELT $ 75)))))))))))) 

(SDEFUN |ACPLOT;newX!1| ((|x| NIL) ($$ NIL))
        (PROG (|yMinNF| |yMaxNF| |xNewNF| $)
          (LETT |yMinNF| (QREFELT $$ 3))
          (LETT |yMaxNF| (QREFELT $$ 2))
          (LETT |xNewNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ACPLOT;onVertSeg?| |x| |yMinNF| |yMaxNF| |xNewNF| $))))) 

(SDEFUN |ACPLOT;newX!0| ((|x| NIL) ($$ NIL))
        (PROG (|xLftNF| |xRtNF| |yMinNF| |yMaxNF| $)
          (LETT |xLftNF| (QREFELT $$ 4))
          (LETT |xRtNF| (QREFELT $$ 3))
          (LETT |yMinNF| (QREFELT $$ 2))
          (LETT |yMaxNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ACPLOT;inRect?| |x| |xLftNF| |xRtNF| |yMinNF| |yMaxNF| $))))) 

(SDEFUN |ACPLOT;newY|
        ((|htanPts| (|List| (|List| (|Float|))))
         (|singPts| (|List| (|List| (|Float|)))) (|xMinNF| (|Float|))
         (|xMaxNF| (|Float|)) (|yNF| (|Float|))
         (|yRN| (|Fraction| (|Integer|))) (|vertInc| (|Fraction| (|Integer|)))
         ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|goo| (|Mapping| (|Boolean|) (|List| (|Float|))))
          (|foo| (|Mapping| (|Boolean|) (|List| (|Float|))))
          (|yBotNF| (|Float|)) (|yTopNF| (|Float|)) (|yNewNF| (|Float|)))
         (SEQ
          (LETT |yNewNF|
                (SPADCALL |yNF| (|ACPLOT;RNtoNF| |vertInc| $) (QREFELT $ 71)))
          (LETT |yTopNF| (SPADCALL |yNF| |yNewNF| (QREFELT $ 72)))
          (LETT |yBotNF| (SPADCALL |yNF| |yNewNF| (QREFELT $ 73)))
          (LETT |foo|
                (CONS #'|ACPLOT;newY!0|
                      (VECTOR $ |yTopNF| |yBotNF| |xMaxNF| |xMinNF|)))
          (EXIT
           (COND
            ((|ACPLOT;ptsSuchThat?| |singPts| |foo| $)
             (|ACPLOT;newY| |htanPts| |singPts| |xMinNF| |xMaxNF| |yNF| |yRN|
              (SPADCALL |vertInc| (SPADCALL 2 (QREFELT $ 55)) (QREFELT $ 74))
              $))
            (#1='T
             (SEQ
              (LETT |goo|
                    (CONS #'|ACPLOT;newY!1|
                          (VECTOR $ |yNewNF| |xMaxNF| |xMinNF|)))
              (EXIT
               (COND
                ((|ACPLOT;ptsSuchThat?| |htanPts| |goo| $)
                 (|ACPLOT;newY| |htanPts| |singPts| |xMinNF| |xMaxNF| |yNF|
                  |yRN|
                  (SPADCALL |vertInc| (SPADCALL 2 (QREFELT $ 55))
                            (QREFELT $ 74))
                  $))
                (#1# (SPADCALL |yRN| |vertInc| (QREFELT $ 75)))))))))))) 

(SDEFUN |ACPLOT;newY!1| ((|x| NIL) ($$ NIL))
        (PROG (|xMinNF| |xMaxNF| |yNewNF| $)
          (LETT |xMinNF| (QREFELT $$ 3))
          (LETT |xMaxNF| (QREFELT $$ 2))
          (LETT |yNewNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ACPLOT;onHorzSeg?| |x| |xMinNF| |xMaxNF| |yNewNF| $))))) 

(SDEFUN |ACPLOT;newY!0| ((|x| NIL) ($$ NIL))
        (PROG (|xMinNF| |xMaxNF| |yBotNF| |yTopNF| $)
          (LETT |xMinNF| (QREFELT $$ 4))
          (LETT |xMaxNF| (QREFELT $$ 3))
          (LETT |yBotNF| (QREFELT $$ 2))
          (LETT |yTopNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ACPLOT;inRect?| |x| |xMinNF| |xMaxNF| |yBotNF| |yTopNF| $))))) 

(SDEFUN |ACPLOT;makeSketch;P2S2S$;27|
        ((|p| (|Polynomial| (|Integer|))) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|xRange| (|Segment| (|Fraction| (|Integer|))))
         (|yRange| (|Segment| (|Fraction| (|Integer|)))) ($ ($)))
        (SPROG
         ((|varList| (|List| (|Symbol|))) (|yMax| #1=(|Fraction| (|Integer|)))
          (|yMin| #2=(|Fraction| (|Integer|))) (|xMax| #1#) (|xMin| #2#))
         (SEQ (LETT |xMin| (SPADCALL |xRange| (QREFELT $ 77)))
              (LETT |xMax| (SPADCALL |xRange| (QREFELT $ 78)))
              (LETT |yMin| (SPADCALL |yRange| (QREFELT $ 77)))
              (LETT |yMax| (SPADCALL |yRange| (QREFELT $ 78)))
              (EXIT
               (COND
                ((SPADCALL |xMax| |xMin| (QREFELT $ 79))
                 (|error| "makeSketch: bad range for first variable"))
                ((SPADCALL |yMax| |yMin| (QREFELT $ 79))
                 (|error| "makeSketch: bad range for second variable"))
                (#3='T
                 (SEQ (LETT |varList| (SPADCALL |p| (QREFELT $ 81)))
                      (EXIT
                       (COND
                        ((> (LENGTH |varList|) 2)
                         (|error|
                          "makeSketch: polynomial in more than 2 variables"))
                        ((EQL (LENGTH |varList|) 0)
                         (|error| "makeSketch: constant polynomial"))
                        ((EQL (LENGTH |varList|) 1)
                         (SEQ
                          (COND
                           ((NULL (SPADCALL |x| |varList| (QREFELT $ 82)))
                            (COND
                             ((NULL (SPADCALL |y| |varList| (QREFELT $ 82)))
                              (EXIT (|error| "makeSketch: bad variables"))))))
                          (EXIT
                           (|ACPLOT;makeOneVarSketch| |p| |x| |y| |xMin| |xMax|
                            |yMin| |yMax| (|SPADfirst| |varList|) $))))
                        (#3#
                         (SEQ
                          (COND
                           ((SPADCALL |x| |varList| (QREFELT $ 82))
                            (COND
                             ((NULL (SPADCALL |y| |varList| (QREFELT $ 82)))
                              (EXIT
                               (|error| #4="makeSketch: bad variables")))))
                           (#3# (EXIT (|error| #4#))))
                          (EXIT
                           (COND
                            ((EQL (SPADCALL |p| (QREFELT $ 83)) 1)
                             (|ACPLOT;makeLineSketch| |p| |x| |y| |xMin| |xMax|
                              |yMin| |yMax| $))
                            ((EQL (SPADCALL |p| |y| (QREFELT $ 84)) 1)
                             (|ACPLOT;makeRatFcnSketch| |p| |x| |y| |xMin|
                              |xMax| |yMin| |yMax| |y| $))
                            ((EQL (SPADCALL |p| |x| (QREFELT $ 84)) 1)
                             (|ACPLOT;makeRatFcnSketch| |p| |x| |y| |xMin|
                              |xMax| |yMin| |yMax| |x| $))
                            (#3#
                             (|ACPLOT;makeGeneralSketch| |p| |x| |y| |xMin|
                              |xMax| |yMin| |yMax| $))))))))))))))) 

(SDEFUN |ACPLOT;makeOneVarSketch|
        ((|p| (|Polynomial| (|Integer|))) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|xMin| (|Fraction| (|Integer|))) (|xMax| (|Fraction| (|Integer|)))
         (|yMin| (|Fraction| (|Integer|))) (|yMax| (|Fraction| (|Integer|)))
         (|var| (|Symbol|)) ($ ($)))
        (SPROG
         ((|bran| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|branch| (|List| #1=(|Point| (|DoubleFloat|))))
          (|lf| (|List| (|Point| (|DoubleFloat|)))) (|pt2| #1#)
          (|rt| (|List| (|Point| (|DoubleFloat|)))) (|pt1| #1#) (#2=#:G905 NIL)
          (|rootSF| NIL) (|xMaxSF| #3=(|DoubleFloat|)) (|xMinSF| #3#)
          (|bt| (|List| (|Point| (|DoubleFloat|))))
          (|tp| (|List| (|Point| (|DoubleFloat|)))) (#4=#:G904 NIL)
          (|yMaxSF| #3#) (|yMinSF| #3#)
          (|sketchRoots| (|List| (|DoubleFloat|))) (#5=#:G903 NIL) (|root| NIL)
          (|roots| (|List| (|Float|)))
          (|vtans| (|List| (|Point| (|DoubleFloat|))))
          (|htans| (|List| (|Point| (|DoubleFloat|)))) (|maxVal| #6=(|Float|))
          (|minVal| #6#))
         (SEQ
          (COND
           ((EQUAL |var| |x|)
            (SEQ (LETT |minVal| (|ACPLOT;RNtoNF| |xMin| $))
                 (EXIT (LETT |maxVal| (|ACPLOT;RNtoNF| |xMax| $)))))
           (#7='T
            (SEQ (LETT |minVal| (|ACPLOT;RNtoNF| |yMin| $))
                 (EXIT (LETT |maxVal| (|ACPLOT;RNtoNF| |yMax| $))))))
          (LETT |lf| NIL) (LETT |rt| NIL) (LETT |bt| NIL) (LETT |tp| NIL)
          (LETT |htans| NIL) (LETT |vtans| NIL) (LETT |bran| NIL)
          (LETT |roots| (SPADCALL |p| (QREFELT $ 12) (QREFELT $ 86)))
          (LETT |sketchRoots| NIL)
          (SEQ (LETT |root| NIL) (LETT #5# |roots|) G190
               (COND
                ((OR (ATOM #5#) (PROGN (LETT |root| (CAR #5#)) NIL))
                 (GO G191)))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL |minVal| |root| (QREFELT $ 68))
                   (COND
                    ((SPADCALL |root| |maxVal| (QREFELT $ 68))
                     (LETT |sketchRoots|
                           (CONS (|ACPLOT;NFtoSF| |root| $)
                                 |sketchRoots|))))))))
               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (COND
            ((NULL |sketchRoots|)
             (VECTOR |p| |x| |y| |xMin| |xMax| |yMin| |yMax|
                     (VECTOR |lf| |rt| |bt| |tp|) |htans| |vtans| |bran|))
            (#7#
             (SEQ
              (COND
               ((EQUAL |var| |x|)
                (SEQ (LETT |yMinSF| (|ACPLOT;RNtoSF| |yMin| $))
                     (LETT |yMaxSF| (|ACPLOT;RNtoSF| |yMax| $))
                     (EXIT
                      (SEQ (LETT |rootSF| NIL) (LETT #4# |sketchRoots|) G190
                           (COND
                            ((OR (ATOM #4#)
                                 (PROGN (LETT |rootSF| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |tp|
                                  (CONS
                                   (LETT |pt1|
                                         (|ACPLOT;makePt| |rootSF| |yMaxSF| $))
                                   |tp|))
                            (LETT |bt|
                                  (CONS
                                   (LETT |pt2|
                                         (|ACPLOT;makePt| |rootSF| |yMinSF| $))
                                   |bt|))
                            (LETT |branch| (LIST |pt1| |pt2|))
                            (EXIT (LETT |bran| (CONS |branch| |bran|))))
                           (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL)))))
               (#7#
                (SEQ (LETT |xMinSF| (|ACPLOT;RNtoSF| |xMin| $))
                     (LETT |xMaxSF| (|ACPLOT;RNtoSF| |xMax| $))
                     (EXIT
                      (SEQ (LETT |rootSF| NIL) (LETT #2# |sketchRoots|) G190
                           (COND
                            ((OR (ATOM #2#)
                                 (PROGN (LETT |rootSF| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |rt|
                                  (CONS
                                   (LETT |pt1|
                                         (|ACPLOT;makePt| |xMaxSF| |rootSF| $))
                                   |rt|))
                            (LETT |lf|
                                  (CONS
                                   (LETT |pt2|
                                         (|ACPLOT;makePt| |xMinSF| |rootSF| $))
                                   |lf|))
                            (LETT |branch| (LIST |pt1| |pt2|))
                            (EXIT (LETT |bran| (CONS |branch| |bran|))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))))
              (EXIT
               (VECTOR |p| |x| |y| |xMin| |xMax| |yMin| |yMax|
                       (VECTOR |lf| |rt| |bt| |tp|) |htans| |vtans|
                       |bran|))))))))) 

(SDEFUN |ACPLOT;makeLineSketch|
        ((|p| (|Polynomial| (|Integer|))) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|xMin| (|Fraction| (|Integer|))) (|xMax| (|Fraction| (|Integer|)))
         (|yMin| (|Fraction| (|Integer|))) (|yMax| (|Fraction| (|Integer|)))
         ($ ($)))
        (SPROG
         ((|bran| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|branch| (|List| (|Point| (|DoubleFloat|))))
          (|rt| (|List| (|Point| (|DoubleFloat|))))
          (|pt| (|Point| (|DoubleFloat|)))
          (|lf| (|List| (|Point| (|DoubleFloat|))))
          (|tp| (|List| (|Point| (|DoubleFloat|))))
          (|bt| (|List| (|Point| (|DoubleFloat|))))
          (|yRight| #1=(|DoubleFloat|)) (|yLeft| #1#) (|xTop| #1#)
          (|xBottom| #1#) (|vtans| (|List| (|Point| (|DoubleFloat|))))
          (|htans| (|List| (|Point| (|DoubleFloat|)))) (|c| (|DoubleFloat|))
          (|b| (|DoubleFloat|)) (|a| (|DoubleFloat|))
          (|yMaxSF| #2=(|DoubleFloat|)) (|yMinSF| #2#) (|xMaxSF| #2#)
          (|xMinSF| #2#))
         (SEQ (LETT |xMinSF| (|ACPLOT;RNtoSF| |xMin| $))
              (LETT |xMaxSF| (|ACPLOT;RNtoSF| |xMax| $))
              (LETT |yMinSF| (|ACPLOT;RNtoSF| |yMin| $))
              (LETT |yMaxSF| (|ACPLOT;RNtoSF| |yMax| $))
              (LETT |a|
                    (FLOAT
                     (SPADCALL (SPADCALL |p| |x| 1 (QREFELT $ 87))
                               (QREFELT $ 88))
                     MOST-POSITIVE-DOUBLE-FLOAT))
              (LETT |b|
                    (FLOAT
                     (SPADCALL (SPADCALL |p| |y| 1 (QREFELT $ 87))
                               (QREFELT $ 88))
                     MOST-POSITIVE-DOUBLE-FLOAT))
              (LETT |c|
                    (FLOAT
                     (SPADCALL
                      (SPADCALL (SPADCALL |p| |x| 0 (QREFELT $ 87)) |y| 0
                                (QREFELT $ 87))
                      (QREFELT $ 88))
                     MOST-POSITIVE-DOUBLE-FLOAT))
              (LETT |lf| NIL) (LETT |rt| NIL) (LETT |bt| NIL) (LETT |tp| NIL)
              (LETT |htans| NIL) (LETT |vtans| NIL) (LETT |branch| NIL)
              (LETT |bran| NIL)
              (LETT |xBottom|
                    (|div_DF|
                     (|sub_DF| (|minus_DF| (|mul_DF| |b| |yMinSF|)) |c|) |a|))
              (LETT |xTop|
                    (|div_DF|
                     (|sub_DF| (|minus_DF| (|mul_DF| |b| |yMaxSF|)) |c|) |a|))
              (LETT |yLeft|
                    (|div_DF|
                     (|sub_DF| (|minus_DF| (|mul_DF| |a| |xMinSF|)) |c|) |b|))
              (LETT |yRight|
                    (|div_DF|
                     (|sub_DF| (|minus_DF| (|mul_DF| |a| |xMaxSF|)) |c|) |b|))
              (COND
               ((|less_DF| |xMinSF| |xBottom|)
                (COND
                 ((|less_DF| |xBottom| |xMaxSF|)
                  (SEQ
                   (LETT |bt|
                         (CONS
                          (LETT |pt| (|ACPLOT;makePt| |xBottom| |yMinSF| $))
                          |bt|))
                   (EXIT (LETT |branch| (CONS |pt| |branch|))))))))
              (COND
               ((|less_DF| |xMinSF| |xTop|)
                (COND
                 ((|less_DF| |xTop| |xMaxSF|)
                  (SEQ
                   (LETT |tp|
                         (CONS (LETT |pt| (|ACPLOT;makePt| |xTop| |yMaxSF| $))
                               |tp|))
                   (EXIT (LETT |branch| (CONS |pt| |branch|))))))))
              (COND
               ((SPADCALL |yMinSF| |yLeft| (QREFELT $ 89))
                (COND
                 ((SPADCALL |yLeft| |yMaxSF| (QREFELT $ 89))
                  (SEQ
                   (LETT |lf|
                         (CONS (LETT |pt| (|ACPLOT;makePt| |xMinSF| |yLeft| $))
                               |lf|))
                   (EXIT (LETT |branch| (CONS |pt| |branch|))))))))
              (COND
               ((SPADCALL |yMinSF| |yRight| (QREFELT $ 89))
                (COND
                 ((SPADCALL |yRight| |yMaxSF| (QREFELT $ 89))
                  (SEQ
                   (LETT |rt|
                         (CONS
                          (LETT |pt| (|ACPLOT;makePt| |xMaxSF| |yRight| $))
                          |rt|))
                   (EXIT (LETT |branch| (CONS |pt| |branch|))))))))
              (LETT |bran| (CONS |branch| |bran|))
              (EXIT
               (VECTOR |p| |x| |y| |xMin| |xMax| |yMin| |yMax|
                       (VECTOR |lf| |rt| |bt| |tp|) |htans| |vtans| |bran|))))) 

(SDEFUN |ACPLOT;singValBetween?|
        ((|xCurrent| (|DoubleFloat|)) (|xNext| (|DoubleFloat|))
         (|xSingList| (|List| (|DoubleFloat|))) ($ (|Boolean|)))
        (SPROG ((#1=#:G917 NIL) (#2=#:G918 NIL) (#3=#:G919 NIL) (|xVal| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |xVal| NIL) (LETT #3# |xSingList|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |xVal| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|less_DF| |xCurrent| |xVal|)
                             (COND
                              ((|less_DF| |xVal| |xNext|)
                               (PROGN
                                (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G916)))
                                (GO #5=#:G914))))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |ACPLOT;segmentInfo|
        ((|f| (|Mapping| #1=(|DoubleFloat|) (|DoubleFloat|)))
         (|lo| (|DoubleFloat|)) (|hi| (|DoubleFloat|))
         (|botList| (|List| (|DoubleFloat|)))
         (|topList| (|List| (|DoubleFloat|)))
         (|singList| (|List| (|DoubleFloat|))) (|minSF| (|DoubleFloat|))
         (|maxSF| (|DoubleFloat|))
         ($
          (|Record| (|:| |seg| (|Segment| (|DoubleFloat|)))
                    (|:| |left| (|DoubleFloat|))
                    (|:| |lowerVals| (|List| (|DoubleFloat|)))
                    (|:| |upperVals| (|List| (|DoubleFloat|))))))
        (SPROG
         ((#2=#:G944 NIL) (|val| #1#) (|nextFrom| #3=(|String|))
          (|nxt| #4=(|DoubleFloat|)) (|top| #4#) (|bot| #4#)
          (|currentFrom| #3#) (|current| #4#))
         (SEQ
          (EXIT
           (SEQ G190 NIL
                (SEQ
                 (COND
                  ((NULL |topList|)
                   (COND
                    ((NULL |botList|)
                     (PROGN
                      (LETT #2#
                            (VECTOR (SPADCALL |lo| |hi| (QREFELT $ 91)) |hi|
                                    NIL NIL))
                      (GO #5=#:G943)))
                    ('T
                     (SEQ (LETT |current| (|SPADfirst| |botList|))
                          (LETT |botList| (CDR |botList|))
                          (EXIT (LETT |currentFrom| (QREFELT $ 19)))))))
                  ((NULL |botList|)
                   (SEQ (LETT |current| (|SPADfirst| |topList|))
                        (LETT |topList| (CDR |topList|))
                        (EXIT (LETT |currentFrom| (QREFELT $ 20)))))
                  ('T
                   (SEQ (LETT |bot| (|SPADfirst| |botList|))
                        (LETT |top| (|SPADfirst| |topList|))
                        (EXIT
                         (COND
                          ((|less_DF| |bot| |top|)
                           (SEQ (LETT |current| |bot|)
                                (LETT |botList| (CDR |botList|))
                                (EXIT (LETT |currentFrom| (QREFELT $ 19)))))
                          ('T
                           (SEQ (LETT |current| |top|)
                                (LETT |topList| (CDR |topList|))
                                (EXIT
                                 (LETT |currentFrom| (QREFELT $ 20))))))))))
                 (COND
                  ((NULL |topList|)
                   (COND
                    ((NULL |botList|)
                     (PROGN
                      (LETT #2#
                            (VECTOR (SPADCALL |lo| |hi| (QREFELT $ 91)) |hi|
                                    NIL NIL))
                      (GO #5#)))
                    ('T
                     (SEQ (LETT |nxt| (|SPADfirst| |botList|))
                          (LETT |botList| (CDR |botList|))
                          (EXIT (LETT |nextFrom| (QREFELT $ 19)))))))
                  ((NULL |botList|)
                   (SEQ (LETT |nxt| (|SPADfirst| |topList|))
                        (LETT |topList| (CDR |topList|))
                        (EXIT (LETT |nextFrom| (QREFELT $ 20)))))
                  ('T
                   (SEQ (LETT |bot| (|SPADfirst| |botList|))
                        (LETT |top| (|SPADfirst| |topList|))
                        (EXIT
                         (COND
                          ((|less_DF| |bot| |top|)
                           (SEQ (LETT |nxt| |bot|)
                                (LETT |botList| (CDR |botList|))
                                (EXIT (LETT |nextFrom| (QREFELT $ 19)))))
                          ('T
                           (SEQ (LETT |nxt| |top|)
                                (LETT |topList| (CDR |topList|))
                                (EXIT (LETT |nextFrom| (QREFELT $ 20))))))))))
                 (EXIT
                  (COND
                   ((EQUAL |currentFrom| |nextFrom|)
                    (COND
                     ((|ACPLOT;singValBetween?| |current| |nxt| |singList| $)
                      (PROGN
                       (LETT #2#
                             (VECTOR (SPADCALL |lo| |current| (QREFELT $ 91))
                                     |nxt| |botList| |topList|))
                       (GO #5#)))
                     ('T
                      (SEQ
                       (LETT |val|
                             (SPADCALL
                              (|div_DF| (|sub_DF| |nxt| |current|)
                                        (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT))
                              |f|))
                       (EXIT
                        (COND
                         ((OR (SPADCALL |val| |minSF| (QREFELT $ 89))
                              (SPADCALL |val| |maxSF| (QREFELT $ 92)))
                          (PROGN
                           (LETT #2#
                                 (VECTOR
                                  (SPADCALL |lo| |current| (QREFELT $ 91))
                                  |nxt| |botList| |topList|))
                           (GO #5#)))))))))
                   ((|ACPLOT;singValBetween?| |current| |nxt| |singList| $)
                    (PROGN
                     (LETT #2#
                           (VECTOR (SPADCALL |lo| |current| (QREFELT $ 91))
                                   |nxt| |botList| |topList|))
                     (GO #5#))))))
                NIL (GO G190) G191 (EXIT NIL)))
          #5# (EXIT #2#)))) 

(SDEFUN |ACPLOT;makeRatFcnSketch|
        ((|p| (|Polynomial| (|Integer|))) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|xMin| #1=(|Fraction| (|Integer|)))
         (|xMax| #2=(|Fraction| (|Integer|)))
         (|yMin| #3=(|Fraction| (|Integer|)))
         (|yMax| #4=(|Fraction| (|Integer|))) (|depVar| (|Symbol|)) ($ ($)))
        (SPROG
         ((|bran| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|curve| (|List| (|Point| (|DoubleFloat|)))) (|RFPlot| (|Plot|))
          (#5=#:G1035 NIL) (|segment| NIL) (#6=#:G1026 NIL)
          (|topList| (|List| (|DoubleFloat|)))
          (|botList| (|List| (|DoubleFloat|))) (|lo| #7=(|DoubleFloat|))
          (|segList| (|List| (|Segment| (|DoubleFloat|))))
          (|segInfo|
           (|Record| (|:| |seg| (|Segment| (|DoubleFloat|)))
                     (|:| |left| (|DoubleFloat|))
                     (|:| |lowerVals| (|List| (|DoubleFloat|)))
                     (|:| |upperVals| (|List| (|DoubleFloat|)))))
          (|maxSF| #7#) (|minSF| #7#) (|hi| (|DoubleFloat|))
          (|top| #8=(|DoubleFloat|)) (|bot| #8#) (#9=#:G1027 NIL)
          (|tp| (|List| (|Point| (|DoubleFloat|)))) (#10=#:G1034 NIL)
          (|val| NIL) (|bt| (|List| (|Point| (|DoubleFloat|))))
          (#11=#:G1033 NIL) (|rt| (|List| (|Point| (|DoubleFloat|))))
          (|lf| (|List| (|Point| (|DoubleFloat|)))) (#12=#:G1032 NIL)
          (#13=#:G1031 NIL) (|rightVal| #14=(|DoubleFloat|)) (|leftVal| #14#)
          (|denUPolyRN|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|outList| (|List| (|DoubleFloat|))) (#15=#:G1030 NIL) (|root| NIL)
          (|roots| (|List| (|Float|))) (#16=#:G1029 NIL)
          (|singList| (|List| (|DoubleFloat|))) (#17=#:G1028 NIL)
          (|vtans| #18=(|List| (|Point| (|DoubleFloat|)))) (|htans| #18#)
          (|vtanPts| #19=(|List| (|List| (|Float|)))) (|htanPts| #19#)
          (|depVarMaxSF| #7#) (|depVarMinSF| #7#) (|depVarMax| #2#)
          (|depVarMin| #1#) (|indVarMaxSF| #7#) (|indVarMinSF| #7#)
          (|indVarMaxNF| #20=(|Float|)) (|indVarMinNF| #20#) (|indVarMax| #4#)
          (|indVarMin| #3#) (|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
          (|denUPolySF| #21=(|SparseUnivariatePolynomial| (|DoubleFloat|)))
          (|numUPolySF| #21#) (|den| (|Polynomial| (|Integer|)))
          (|num| (|Polynomial| (|Integer|))) (|yMaxNF| #20#) (|yMinNF| #20#)
          (|xMaxNF| #20#) (|xMinNF| #20#) (|yMaxSF| #7#) (|yMinSF| #7#)
          (|xMaxSF| #7#) (|xMinSF| #7#)
          (|pRN| (|Polynomial| (|Fraction| (|Integer|))))
          (|dpdy| #22=(|Polynomial| (|Integer|))) (|dpdx| #22#)
          (|factoredP| (|Factored| (|Polynomial| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |factoredP| (SPADCALL |p| (QREFELT $ 94)))
                (EXIT
                 (COND
                  ((> (SPADCALL |factoredP| (QREFELT $ 95)) 1)
                   (|error| "reducible polynomial"))
                  (#23='T
                   (SEQ (LETT |dpdx| (SPADCALL |p| |x| (QREFELT $ 96)))
                        (LETT |dpdy| (SPADCALL |p| |y| (QREFELT $ 96)))
                        (LETT |pRN| (|ACPLOT;coerceCoefsToRNs| |p| $))
                        (LETT |xMinSF| (|ACPLOT;RNtoSF| |xMin| $))
                        (LETT |xMaxSF| (|ACPLOT;RNtoSF| |xMax| $))
                        (LETT |yMinSF| (|ACPLOT;RNtoSF| |yMin| $))
                        (LETT |yMaxSF| (|ACPLOT;RNtoSF| |yMax| $))
                        (LETT |xMinNF| (|ACPLOT;RNtoNF| |xMin| $))
                        (LETT |xMaxNF| (|ACPLOT;RNtoNF| |xMax| $))
                        (LETT |yMinNF| (|ACPLOT;RNtoNF| |yMin| $))
                        (LETT |yMaxNF| (|ACPLOT;RNtoNF| |yMax| $))
                        (LETT |num|
                              (SPADCALL
                               (SPADCALL |p| |depVar| 0 (QREFELT $ 87))
                               (QREFELT $ 97)))
                        (LETT |den| (SPADCALL |p| |depVar| 1 (QREFELT $ 87)))
                        (LETT |numUPolySF|
                              (|ACPLOT;SFPolyToUPoly|
                               (|ACPLOT;coerceCoefsToSFs| |num| $) $))
                        (LETT |denUPolySF|
                              (|ACPLOT;SFPolyToUPoly|
                               (|ACPLOT;coerceCoefsToSFs| |den| $) $))
                        (LETT |f|
                              (CONS #'|ACPLOT;makeRatFcnSketch!0|
                                    (VECTOR |denUPolySF| $ |numUPolySF|)))
                        (COND
                         ((EQUAL |depVar| |x|)
                          (SEQ (LETT |indVarMin| |yMin|)
                               (LETT |indVarMax| |yMax|)
                               (LETT |indVarMinNF| |yMinNF|)
                               (LETT |indVarMaxNF| |yMaxNF|)
                               (LETT |indVarMinSF| |yMinSF|)
                               (LETT |indVarMaxSF| |yMaxSF|)
                               (LETT |depVarMin| |xMin|)
                               (LETT |depVarMax| |xMax|)
                               (LETT |depVarMinSF| |xMinSF|)
                               (EXIT (LETT |depVarMaxSF| |xMaxSF|))))
                         (#23#
                          (SEQ (LETT |indVarMin| |xMin|)
                               (LETT |indVarMax| |xMax|)
                               (LETT |indVarMinNF| |xMinNF|)
                               (LETT |indVarMaxNF| |xMaxNF|)
                               (LETT |indVarMinSF| |xMinSF|)
                               (LETT |indVarMaxSF| |xMaxSF|)
                               (LETT |depVarMin| |yMin|)
                               (LETT |depVarMax| |yMax|)
                               (LETT |depVarMinSF| |yMinSF|)
                               (EXIT (LETT |depVarMaxSF| |yMaxSF|)))))
                        (LETT |htanPts|
                              (SPADCALL (LIST |p| |dpdx|) (LIST |x| |y|)
                                        (QREFELT $ 12) (QREFELT $ 102)))
                        (LETT |vtanPts|
                              (SPADCALL (LIST |p| |dpdy|) (LIST |x| |y|)
                                        (QREFELT $ 12) (QREFELT $ 102)))
                        (LETT |htans|
                              (|ACPLOT;listPtsInRect| |htanPts| |xMinNF|
                               |xMaxNF| |yMinNF| |yMaxNF| $))
                        (LETT |vtans|
                              (|ACPLOT;listPtsInRect| |vtanPts| |xMinNF|
                               |xMaxNF| |yMinNF| |yMaxNF| $))
                        (LETT |lf| NIL) (LETT |rt| NIL) (LETT |bt| NIL)
                        (LETT |tp| NIL)
                        (LETT |singList|
                              (SEQ
                               (LETT |roots|
                                     (SPADCALL |den| (QREFELT $ 12)
                                               (QREFELT $ 86)))
                               (LETT |outList| NIL)
                               (SEQ (LETT |root| NIL) (LETT #17# |roots|) G190
                                    (COND
                                     ((OR (ATOM #17#)
                                          (PROGN (LETT |root| (CAR #17#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |indVarMinNF| |root|
                                                  (QREFELT $ 67))
                                        (COND
                                         ((SPADCALL |root| |indVarMaxNF|
                                                    (QREFELT $ 67))
                                          (LETT |outList|
                                                (CONS
                                                 (|ACPLOT;NFtoSF| |root| $)
                                                 |outList|))))))))
                                    (LETT #17# (CDR #17#)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SPADCALL (ELT $ 103) |outList|
                                          (QREFELT $ 105)))))
                        (LETT |topList|
                              (SEQ
                               (LETT |roots|
                                     (SPADCALL
                                      (SPADCALL |pRN| |depVar| |depVarMax|
                                                (QREFELT $ 63))
                                      (QREFELT $ 12) (QREFELT $ 66)))
                               (LETT |outList| NIL)
                               (SEQ (LETT |root| NIL) (LETT #16# |roots|) G190
                                    (COND
                                     ((OR (ATOM #16#)
                                          (PROGN (LETT |root| (CAR #16#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |indVarMinNF| |root|
                                                  (QREFELT $ 67))
                                        (COND
                                         ((SPADCALL |root| |indVarMaxNF|
                                                    (QREFELT $ 67))
                                          (LETT |outList|
                                                (CONS
                                                 (|ACPLOT;NFtoSF| |root| $)
                                                 |outList|))))))))
                                    (LETT #16# (CDR #16#)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SPADCALL (ELT $ 103) |outList|
                                          (QREFELT $ 105)))))
                        (LETT |botList|
                              (SEQ
                               (LETT |roots|
                                     (SPADCALL
                                      (SPADCALL |pRN| |depVar| |depVarMin|
                                                (QREFELT $ 63))
                                      (QREFELT $ 12) (QREFELT $ 66)))
                               (LETT |outList| NIL)
                               (SEQ (LETT |root| NIL) (LETT #15# |roots|) G190
                                    (COND
                                     ((OR (ATOM #15#)
                                          (PROGN (LETT |root| (CAR #15#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |indVarMinNF| |root|
                                                  (QREFELT $ 67))
                                        (COND
                                         ((SPADCALL |root| |indVarMaxNF|
                                                    (QREFELT $ 67))
                                          (LETT |outList|
                                                (CONS
                                                 (|ACPLOT;NFtoSF| |root| $)
                                                 |outList|))))))))
                                    (LETT #15# (CDR #15#)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SPADCALL (ELT $ 103) |outList|
                                          (QREFELT $ 105)))))
                        (LETT |denUPolyRN|
                              (|ACPLOT;RNPolyToUPoly|
                               (|ACPLOT;coerceCoefsToRNs| |den| $) $))
                        (COND
                         ((SPADCALL
                           (SPADCALL |denUPolyRN| |indVarMin| (QREFELT $ 106))
                           (|spadConstant| $ 107) (QREFELT $ 108))
                          (LETT |leftVal|
                                (|sub_DF| |depVarMinSF|
                                          (|add_DF| (|abs_DF| |depVarMinSF|)
                                                    1.0))))
                         (#23# (LETT |leftVal| (SPADCALL |indVarMinSF| |f|))))
                        (COND
                         ((SPADCALL
                           (SPADCALL |denUPolyRN| |indVarMax| (QREFELT $ 106))
                           (|spadConstant| $ 107) (QREFELT $ 108))
                          (LETT |rightVal|
                                (|sub_DF| |depVarMinSF|
                                          (|add_DF| (|abs_DF| |depVarMinSF|)
                                                    1.0))))
                         (#23# (LETT |rightVal| (SPADCALL |indVarMaxSF| |f|))))
                        (COND
                         ((EQUAL |depVar| |x|)
                          (SEQ
                           (COND
                            ((|less_DF| |xMinSF| |leftVal|)
                             (COND
                              ((|less_DF| |leftVal| |xMaxSF|)
                               (LETT |bt|
                                     (CONS
                                      (|ACPLOT;makePt| |leftVal| |yMinSF| $)
                                      |bt|))))))
                           (COND
                            ((|less_DF| |xMinSF| |rightVal|)
                             (COND
                              ((|less_DF| |rightVal| |xMaxSF|)
                               (LETT |tp|
                                     (CONS
                                      (|ACPLOT;makePt| |rightVal| |yMaxSF| $)
                                      |tp|))))))
                           (SEQ (LETT |val| NIL) (LETT #13# |botList|) G190
                                (COND
                                 ((OR (ATOM #13#)
                                      (PROGN (LETT |val| (CAR #13#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |lf|
                                        (CONS
                                         (|ACPLOT;makePt| |xMinSF| |val| $)
                                         |lf|))))
                                (LETT #13# (CDR #13#)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (SEQ (LETT |val| NIL) (LETT #12# |topList|) G190
                                 (COND
                                  ((OR (ATOM #12#)
                                       (PROGN (LETT |val| (CAR #12#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |rt|
                                         (CONS
                                          (|ACPLOT;makePt| |xMaxSF| |val| $)
                                          |rt|))))
                                 (LETT #12# (CDR #12#)) (GO G190) G191
                                 (EXIT NIL)))))
                         (#23#
                          (SEQ
                           (COND
                            ((|less_DF| |yMinSF| |leftVal|)
                             (COND
                              ((|less_DF| |leftVal| |yMaxSF|)
                               (LETT |lf|
                                     (CONS
                                      (|ACPLOT;makePt| |xMinSF| |leftVal| $)
                                      |lf|))))))
                           (COND
                            ((|less_DF| |yMinSF| |rightVal|)
                             (COND
                              ((|less_DF| |rightVal| |yMaxSF|)
                               (LETT |rt|
                                     (CONS
                                      (|ACPLOT;makePt| |xMaxSF| |rightVal| $)
                                      |rt|))))))
                           (SEQ (LETT |val| NIL) (LETT #11# |botList|) G190
                                (COND
                                 ((OR (ATOM #11#)
                                      (PROGN (LETT |val| (CAR #11#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |bt|
                                        (CONS
                                         (|ACPLOT;makePt| |val| |yMinSF| $)
                                         |bt|))))
                                (LETT #11# (CDR #11#)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (SEQ (LETT |val| NIL) (LETT #10# |topList|) G190
                                 (COND
                                  ((OR (ATOM #10#)
                                       (PROGN (LETT |val| (CAR #10#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |tp|
                                         (CONS
                                          (|ACPLOT;makePt| |val| |yMaxSF| $)
                                          |tp|))))
                                 (LETT #10# (CDR #10#)) (GO G190) G191
                                 (EXIT NIL))))))
                        (LETT |bran| NIL)
                        (COND
                         ((|less_DF| |depVarMinSF| |leftVal|)
                          (COND
                           ((|less_DF| |leftVal| |depVarMaxSF|)
                            (LETT |lo| |indVarMinSF|))
                           ((NULL |topList|)
                            (COND
                             ((NULL |botList|)
                              (PROGN
                               (LETT #9#
                                     (VECTOR |p| |x| |y| |xMin| |xMax| |yMin|
                                             |yMax|
                                             (VECTOR |lf| |rt| |bt| |tp|)
                                             |htans| |vtans| |bran|))
                               (GO #24=#:G1025)))
                             (#23#
                              (SEQ (LETT |lo| (|SPADfirst| |botList|))
                                   (EXIT (LETT |botList| (CDR |botList|)))))))
                           ((NULL |botList|)
                            (SEQ (LETT |lo| (|SPADfirst| |topList|))
                                 (EXIT (LETT |topList| (CDR |topList|)))))
                           (#23#
                            (SEQ (LETT |bot| (|SPADfirst| |botList|))
                                 (LETT |top| (|SPADfirst| |topList|))
                                 (EXIT
                                  (COND
                                   ((|less_DF| |bot| |top|)
                                    (SEQ (LETT |lo| |bot|)
                                         (EXIT
                                          (LETT |botList| (CDR |botList|)))))
                                   (#23#
                                    (SEQ (LETT |lo| |top|)
                                         (EXIT
                                          (LETT |topList|
                                                (CDR |topList|)))))))))))
                         ((NULL |topList|)
                          (COND
                           ((NULL |botList|)
                            (PROGN
                             (LETT #9#
                                   (VECTOR |p| |x| |y| |xMin| |xMax| |yMin|
                                           |yMax| (VECTOR |lf| |rt| |bt| |tp|)
                                           |htans| |vtans| |bran|))
                             (GO #24#)))
                           (#23#
                            (SEQ (LETT |lo| (|SPADfirst| |botList|))
                                 (EXIT (LETT |botList| (CDR |botList|)))))))
                         ((NULL |botList|)
                          (SEQ (LETT |lo| (|SPADfirst| |topList|))
                               (EXIT (LETT |topList| (CDR |topList|)))))
                         (#23#
                          (SEQ (LETT |bot| (|SPADfirst| |botList|))
                               (LETT |top| (|SPADfirst| |topList|))
                               (EXIT
                                (COND
                                 ((|less_DF| |bot| |top|)
                                  (SEQ (LETT |lo| |bot|)
                                       (EXIT
                                        (LETT |botList| (CDR |botList|)))))
                                 (#23#
                                  (SEQ (LETT |lo| |top|)
                                       (EXIT
                                        (LETT |topList|
                                              (CDR |topList|))))))))))
                        (LETT |hi| 0.0)
                        (COND
                         ((|less_DF| |depVarMinSF| |rightVal|)
                          (COND
                           ((|less_DF| |rightVal| |depVarMaxSF|)
                            (LETT |hi| |indVarMaxSF|))
                           ((NULL |topList|)
                            (COND
                             ((NULL |botList|)
                              (|error| #25="makeRatFcnSketch: plot domain"))
                             (#23#
                              (SEQ
                               (LETT |hi| (SPADCALL |botList| (QREFELT $ 109)))
                               (EXIT
                                (LETT |botList|
                                      (SPADCALL |hi| |botList|
                                                (QREFELT $ 110))))))))
                           ((NULL |botList|)
                            (SEQ
                             (LETT |hi| (SPADCALL |topList| (QREFELT $ 109)))
                             (EXIT
                              (LETT |topList|
                                    (SPADCALL |hi| |topList|
                                              (QREFELT $ 110))))))
                           (#23#
                            (SEQ
                             (LETT |bot| (SPADCALL |botList| (QREFELT $ 109)))
                             (LETT |top| (SPADCALL |topList| (QREFELT $ 109)))
                             (EXIT
                              (COND
                               ((SPADCALL |bot| |top| (QREFELT $ 111))
                                (SEQ (LETT |hi| |bot|)
                                     (EXIT
                                      (LETT |botList|
                                            (SPADCALL |hi| |botList|
                                                      (QREFELT $ 110))))))
                               (#23#
                                (SEQ (LETT |hi| |top|)
                                     (EXIT
                                      (LETT |topList|
                                            (SPADCALL |hi| |topList|
                                                      (QREFELT $
                                                               110))))))))))))
                         ((NULL |topList|)
                          (COND ((NULL |botList|) (|error| #25#))
                                (#23#
                                 (SEQ
                                  (LETT |hi|
                                        (SPADCALL |botList| (QREFELT $ 109)))
                                  (EXIT
                                   (LETT |botList|
                                         (SPADCALL |hi| |botList|
                                                   (QREFELT $ 110))))))))
                         ((NULL |botList|)
                          (SEQ (LETT |hi| (SPADCALL |topList| (QREFELT $ 109)))
                               (EXIT
                                (LETT |topList|
                                      (SPADCALL |hi| |topList|
                                                (QREFELT $ 110))))))
                         (#23#
                          (SEQ
                           (LETT |bot| (SPADCALL |botList| (QREFELT $ 109)))
                           (LETT |top| (SPADCALL |topList| (QREFELT $ 109)))
                           (EXIT
                            (COND
                             ((SPADCALL |bot| |top| (QREFELT $ 111))
                              (SEQ (LETT |hi| |bot|)
                                   (EXIT
                                    (LETT |botList|
                                          (SPADCALL |hi| |botList|
                                                    (QREFELT $ 110))))))
                             (#23#
                              (SEQ (LETT |hi| |top|)
                                   (EXIT
                                    (LETT |topList|
                                          (SPADCALL |hi| |topList|
                                                    (QREFELT $ 110)))))))))))
                        (COND
                         ((EQUAL |depVar| |x|)
                          (SEQ (LETT |minSF| |xMinSF|)
                               (EXIT (LETT |maxSF| |xMaxSF|))))
                         (#23#
                          (SEQ (LETT |minSF| |yMinSF|)
                               (EXIT (LETT |maxSF| |yMaxSF|)))))
                        (LETT |segList| NIL)
                        (SEQ
                         (EXIT
                          (SEQ G190 NIL
                               (SEQ
                                (LETT |segInfo|
                                      (|ACPLOT;segmentInfo| |f| |lo| |hi|
                                       |botList| |topList| |singList| |minSF|
                                       |maxSF| $))
                                (LETT |segList|
                                      (CONS (QVELT |segInfo| 0) |segList|))
                                (LETT |lo| (QVELT |segInfo| 1))
                                (LETT |botList| (QVELT |segInfo| 2))
                                (LETT |topList| (QVELT |segInfo| 3))
                                (EXIT
                                 (COND
                                  ((|eql_DF| |lo| |hi|)
                                   (PROGN
                                    (LETT #6# |$NoValue|)
                                    (GO #26=#:G1017))))))
                               NIL (GO G190) G191 (EXIT NIL)))
                         #26# (EXIT #6#))
                        (SEQ (LETT |segment| NIL) (LETT #5# |segList|) G190
                             (COND
                              ((OR (ATOM #5#)
                                   (PROGN (LETT |segment| (CAR #5#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |RFPlot|
                                    (SPADCALL |f| |segment| (QREFELT $ 114)))
                              (LETT |curve|
                                    (|SPADfirst|
                                     (SPADCALL |RFPlot| (QREFELT $ 116))))
                              (EXIT
                               (COND
                                ((EQUAL |depVar| |y|)
                                 (LETT |bran| (CONS |curve| |bran|)))
                                ('T
                                 (LETT |bran|
                                       (CONS
                                        (SPADCALL
                                         (CONS (|function| |ACPLOT;swapCoords|)
                                               $)
                                         |curve| (QREFELT $ 119))
                                        |bran|))))))
                             (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (VECTOR |p| |x| |y| |xMin| |xMax| |yMin| |yMax|
                                 (VECTOR |lf| |rt| |bt| |tp|) |htans| |vtans|
                                 |bran|))))))))
          #24# (EXIT #9#)))) 

(SDEFUN |ACPLOT;makeRatFcnSketch!0| ((|s| NIL) ($$ NIL))
        (PROG (|numUPolySF| $ |denUPolySF|)
          (LETT |numUPolySF| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |denUPolySF| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |numUPolySF| |s| (QREFELT $ 98))
                      (SPADCALL |denUPolySF| |s| (QREFELT $ 98))
                      (QREFELT $ 99)))))) 

(SDEFUN |ACPLOT;makeGeneralSketch|
        ((|pol| (|Polynomial| (|Integer|))) (|x| (|Symbol|)) (|y| (|Symbol|))
         (|xMin| (|Fraction| (|Integer|))) (|xMax| (|Fraction| (|Integer|)))
         (|yMin| (|Fraction| (|Integer|))) (|yMax| (|Fraction| (|Integer|)))
         ($ ($)))
        (SPROG
         ((|bran| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|bdPts|
           (|Record| (|:| |left| (|List| (|Point| (|DoubleFloat|))))
                     (|:| |right| (|List| (|Point| (|DoubleFloat|))))
                     (|:| |bottom| (|List| (|Point| (|DoubleFloat|))))
                     (|:| |top| (|List| (|Point| (|DoubleFloat|))))))
          (|tp| #1=(|List| (|Point| (|DoubleFloat|)))) (|bt| #1#)
          (|rt| #2=(|List| (|Point| (|DoubleFloat|)))) (|lf| #2#)
          (|pRN| (|Polynomial| (|Fraction| (|Integer|))))
          (|bound| (|PositiveInteger|)) (|err| #3=(|DoubleFloat|))
          (|delta| #3#) (|dpdySF| #4=(|Polynomial| (|DoubleFloat|)))
          (|dpdxSF| #4#) (|pSF| #4#)
          (|corners|
           (|Record| (|:| |minXVal| (|DoubleFloat|))
                     (|:| |maxXVal| (|DoubleFloat|))
                     (|:| |minYVal| (|DoubleFloat|))
                     (|:| |maxYVal| (|DoubleFloat|))))
          (|yMaxSF| #5=(|DoubleFloat|)) (|yMinSF| #5#) (|xMaxSF| #5#)
          (|xMinSF| #5#) (|crits| (|List| (|Point| (|DoubleFloat|))))
          (|vtans| #6=(|List| (|Point| (|DoubleFloat|)))) (|htans| #6#)
          (|yMaxNF| #7=(|Float|))
          (|foo| (|Mapping| (|Boolean|) (|List| (|Float|)))) (|yMinNF| #7#)
          (|xMaxNF| #7#) (|xMinNF| #7#) (|vInc| #8=(|Fraction| (|Integer|)))
          (|hInc| #8#) (|critPts| (|List| (|List| (|Float|))))
          (|vtanPts| #9=(|List| (|List| (|Float|)))) (|htanPts| #9#)
          (|singPts| #9#) (|dpdy| #10=(|Polynomial| (|Integer|))) (|dpdx| #10#)
          (|p| #11=(|Polynomial| (|Integer|)))
          (|flist|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #11#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|factoredPol| (|Factored| (|Polynomial| (|Integer|)))))
         (SEQ (LETT |factoredPol| (SPADCALL |pol| (QREFELT $ 94)))
              (LETT |flist| (SPADCALL |factoredPol| (QREFELT $ 123)))
              (EXIT
               (COND ((> (LENGTH |flist|) 1) (|error| "reducible polynomial"))
                     (#12='T
                      (SEQ (LETT |p| (QVELT (|SPADfirst| |flist|) 1))
                           (LETT |dpdx| (SPADCALL |p| |x| (QREFELT $ 96)))
                           (LETT |dpdy| (SPADCALL |p| |y| (QREFELT $ 96)))
                           (LETT |xMinNF| (|ACPLOT;RNtoNF| |xMin| $))
                           (LETT |xMaxNF| (|ACPLOT;RNtoNF| |xMax| $))
                           (LETT |yMinNF| (|ACPLOT;RNtoNF| |yMin| $))
                           (LETT |yMaxNF| (|ACPLOT;RNtoNF| |yMax| $))
                           (LETT |singPts|
                                 (SPADCALL (LIST |p| |dpdx| |dpdy|)
                                           (LIST |x| |y|) (QREFELT $ 12)
                                           (QREFELT $ 102)))
                           (LETT |foo|
                                 (CONS #'|ACPLOT;makeGeneralSketch!0|
                                       (VECTOR $ |yMaxNF| |yMinNF| |xMaxNF|
                                               |xMinNF|)))
                           (EXIT
                            (COND
                             ((|ACPLOT;ptsSuchThat?| |singPts| |foo| $)
                              (|error| "singular pts in region of sketch"))
                             (#12#
                              (SEQ
                               (LETT |htanPts|
                                     (SPADCALL (LIST |p| |dpdx|) (LIST |x| |y|)
                                               (QREFELT $ 12) (QREFELT $ 102)))
                               (LETT |vtanPts|
                                     (SPADCALL (LIST |p| |dpdy|) (LIST |x| |y|)
                                               (QREFELT $ 12) (QREFELT $ 102)))
                               (LETT |critPts|
                                     (SPADCALL |htanPts| |vtanPts|
                                               (QREFELT $ 124)))
                               (LETT |hInc|
                                     (SPADCALL (SPADCALL 1 20 (QREFELT $ 125))
                                               (SPADCALL |xMax| |xMin|
                                                         (QREFELT $ 126))
                                               (QREFELT $ 127)))
                               (LETT |vInc|
                                     (SPADCALL (SPADCALL 1 20 (QREFELT $ 125))
                                               (SPADCALL |yMax| |yMin|
                                                         (QREFELT $ 126))
                                               (QREFELT $ 127)))
                               (LETT |foo|
                                     (CONS #'|ACPLOT;makeGeneralSketch!1|
                                           (VECTOR $ |xMinNF| |yMaxNF|
                                                   |yMinNF|)))
                               (COND
                                ((|ACPLOT;ptsSuchThat?| |critPts| |foo| $)
                                 (SEQ
                                  (LETT |xMin|
                                        (|ACPLOT;newX| |critPts| |singPts|
                                         |yMinNF| |yMaxNF| |xMinNF| |xMin|
                                         (SPADCALL |hInc| (QREFELT $ 128)) $))
                                  (EXIT
                                   (LETT |xMinNF|
                                         (|ACPLOT;RNtoNF| |xMin| $))))))
                               (LETT |foo|
                                     (CONS #'|ACPLOT;makeGeneralSketch!2|
                                           (VECTOR $ |xMaxNF| |yMaxNF|
                                                   |yMinNF|)))
                               (COND
                                ((|ACPLOT;ptsSuchThat?| |critPts| |foo| $)
                                 (SEQ
                                  (LETT |xMax|
                                        (|ACPLOT;newX| |critPts| |singPts|
                                         |yMinNF| |yMaxNF| |xMaxNF| |xMax|
                                         |hInc| $))
                                  (EXIT
                                   (LETT |xMaxNF|
                                         (|ACPLOT;RNtoNF| |xMax| $))))))
                               (LETT |foo|
                                     (CONS #'|ACPLOT;makeGeneralSketch!3|
                                           (VECTOR $ |yMinNF| |xMaxNF|
                                                   |xMinNF|)))
                               (COND
                                ((|ACPLOT;ptsSuchThat?| |critPts| |foo| $)
                                 (SEQ
                                  (LETT |yMin|
                                        (|ACPLOT;newY| |critPts| |singPts|
                                         |xMinNF| |xMaxNF| |yMinNF| |yMin|
                                         (SPADCALL |vInc| (QREFELT $ 128)) $))
                                  (EXIT
                                   (LETT |yMinNF|
                                         (|ACPLOT;RNtoNF| |yMin| $))))))
                               (LETT |foo|
                                     (CONS #'|ACPLOT;makeGeneralSketch!4|
                                           (VECTOR $ |yMaxNF| |xMaxNF|
                                                   |xMinNF|)))
                               (COND
                                ((|ACPLOT;ptsSuchThat?| |critPts| |foo| $)
                                 (SEQ
                                  (LETT |yMax|
                                        (|ACPLOT;newY| |critPts| |singPts|
                                         |xMinNF| |xMaxNF| |yMaxNF| |yMax|
                                         |vInc| $))
                                  (EXIT
                                   (LETT |yMaxNF|
                                         (|ACPLOT;RNtoNF| |yMax| $))))))
                               (LETT |htans|
                                     (|ACPLOT;listPtsInRect| |htanPts| |xMinNF|
                                      |xMaxNF| |yMinNF| |yMaxNF| $))
                               (LETT |vtans|
                                     (|ACPLOT;listPtsInRect| |vtanPts| |xMinNF|
                                      |xMaxNF| |yMinNF| |yMaxNF| $))
                               (LETT |crits|
                                     (SPADCALL |htans| |vtans|
                                               (QREFELT $ 129)))
                               (LETT |xMinSF| (|ACPLOT;RNtoSF| |xMin| $))
                               (LETT |xMaxSF| (|ACPLOT;RNtoSF| |xMax| $))
                               (LETT |yMinSF| (|ACPLOT;RNtoSF| |yMin| $))
                               (LETT |yMaxSF| (|ACPLOT;RNtoSF| |yMax| $))
                               (LETT |corners|
                                     (|ACPLOT;makeCorners| |xMinSF| |xMaxSF|
                                      |yMinSF| |yMaxSF| $))
                               (LETT |pSF| (|ACPLOT;coerceCoefsToSFs| |p| $))
                               (LETT |dpdxSF|
                                     (|ACPLOT;coerceCoefsToSFs| |dpdx| $))
                               (LETT |dpdySF|
                                     (|ACPLOT;coerceCoefsToSFs| |dpdy| $))
                               (LETT |delta|
                                     (|min_DF|
                                      (|div_DF_I| (|sub_DF| |xMaxSF| |xMinSF|)
                                                  25)
                                      (|div_DF_I| (|sub_DF| |yMaxSF| |yMinSF|)
                                                  25)))
                               (LETT |err|
                                     (|min_DF| (|div_DF_I| |delta| 100)
                                               (|div_DF_I| (QREFELT $ 15)
                                                           100)))
                               (LETT |bound| 10)
                               (LETT |pRN| (|ACPLOT;coerceCoefsToRNs| |p| $))
                               (LETT |lf|
                                     (|ACPLOT;listPtsOnVertBdry| |pRN| |x|
                                      |xMin| |yMinNF| |yMaxNF| $))
                               (LETT |rt|
                                     (|ACPLOT;listPtsOnVertBdry| |pRN| |x|
                                      |xMax| |yMinNF| |yMaxNF| $))
                               (LETT |bt|
                                     (|ACPLOT;listPtsOnHorizBdry| |pRN| |y|
                                      |yMin| |xMinNF| |xMaxNF| $))
                               (LETT |tp|
                                     (|ACPLOT;listPtsOnHorizBdry| |pRN| |y|
                                      |yMax| |xMinNF| |xMaxNF| $))
                               (LETT |bdPts| (VECTOR |lf| |rt| |bt| |tp|))
                               (LETT |bran|
                                     (|ACPLOT;traceBranches| |pSF| |dpdxSF|
                                      |dpdySF| |x| |y| |corners| |delta| |err|
                                      |bound| |crits| |bdPts| $))
                               (EXIT
                                (VECTOR |p| |x| |y| |xMin| |xMax| |yMin| |yMax|
                                        |bdPts| |htans| |vtans|
                                        |bran|))))))))))))) 

(SDEFUN |ACPLOT;makeGeneralSketch!4| ((|s| NIL) ($$ NIL))
        (PROG (|xMinNF| |xMaxNF| |yMaxNF| $)
          (LETT |xMinNF| (QREFELT $$ 3))
          (LETT |xMaxNF| (QREFELT $$ 2))
          (LETT |yMaxNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ACPLOT;onHorzSeg?| |s| |xMinNF| |xMaxNF| |yMaxNF| $))))) 

(SDEFUN |ACPLOT;makeGeneralSketch!3| ((|s| NIL) ($$ NIL))
        (PROG (|xMinNF| |xMaxNF| |yMinNF| $)
          (LETT |xMinNF| (QREFELT $$ 3))
          (LETT |xMaxNF| (QREFELT $$ 2))
          (LETT |yMinNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ACPLOT;onHorzSeg?| |s| |xMinNF| |xMaxNF| |yMinNF| $))))) 

(SDEFUN |ACPLOT;makeGeneralSketch!2| ((|s| NIL) ($$ NIL))
        (PROG (|yMinNF| |yMaxNF| |xMaxNF| $)
          (LETT |yMinNF| (QREFELT $$ 3))
          (LETT |yMaxNF| (QREFELT $$ 2))
          (LETT |xMaxNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ACPLOT;onVertSeg?| |s| |yMinNF| |yMaxNF| |xMaxNF| $))))) 

(SDEFUN |ACPLOT;makeGeneralSketch!1| ((|s| NIL) ($$ NIL))
        (PROG (|yMinNF| |yMaxNF| |xMinNF| $)
          (LETT |yMinNF| (QREFELT $$ 3))
          (LETT |yMaxNF| (QREFELT $$ 2))
          (LETT |xMinNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|ACPLOT;onVertSeg?| |s| |yMinNF| |yMaxNF| |xMinNF| $))))) 

(SDEFUN |ACPLOT;makeGeneralSketch!0| ((|s| NIL) ($$ NIL))
        (PROG (|xMinNF| |xMaxNF| |yMinNF| |yMaxNF| $)
          (LETT |xMinNF| (QREFELT $$ 4))
          (LETT |xMaxNF| (QREFELT $$ 3))
          (LETT |yMinNF| (QREFELT $$ 2))
          (LETT |yMaxNF| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ACPLOT;inRect?| |s| |xMinNF| |xMaxNF| |yMinNF| |yMaxNF| $))))) 

(SDEFUN |ACPLOT;refine;$Df$;34|
        ((|plot| ($)) (|stepFraction| (|DoubleFloat|)) ($ ($)))
        (SPROG
         ((|vtans| (|List| (|Point| (|DoubleFloat|))))
          (|htans| (|List| (|Point| (|DoubleFloat|))))
          (|bran| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|bdPts|
           (|Record| (|:| |left| (|List| (|Point| (|DoubleFloat|))))
                     (|:| |right| (|List| (|Point| (|DoubleFloat|))))
                     (|:| |bottom| (|List| (|Point| (|DoubleFloat|))))
                     (|:| |top| (|List| (|Point| (|DoubleFloat|))))))
          (|crits| (|List| (|Point| (|DoubleFloat|))))
          (|bound| (|PositiveInteger|)) (|err| (|DoubleFloat|))
          (|delta| (|DoubleFloat|))
          (|dpdySF| #1=(|Polynomial| (|DoubleFloat|))) (|dpdxSF| #1#)
          (|pSF| #1#)
          (|corners|
           (|Record| (|:| |minXVal| (|DoubleFloat|))
                     (|:| |maxXVal| (|DoubleFloat|))
                     (|:| |minYVal| (|DoubleFloat|))
                     (|:| |maxYVal| (|DoubleFloat|))))
          (|yMaxSF| #2=(|DoubleFloat|)) (|yMinSF| #2#) (|xMaxSF| #2#)
          (|xMinSF| #2#) (|yMax| (|Fraction| (|Integer|)))
          (|yMin| (|Fraction| (|Integer|))) (|xMax| (|Fraction| (|Integer|)))
          (|xMin| (|Fraction| (|Integer|)))
          (|dpdy| #3=(|Polynomial| (|Integer|))) (|dpdx| #3#) (|y| (|Symbol|))
          (|x| (|Symbol|)) (|p| (|Polynomial| (|Integer|))))
         (SEQ (LETT |p| (QVELT |plot| 0)) (LETT |x| (QVELT |plot| 1))
              (LETT |y| (QVELT |plot| 2))
              (LETT |dpdx| (SPADCALL |p| |x| (QREFELT $ 96)))
              (LETT |dpdy| (SPADCALL |p| |y| (QREFELT $ 96)))
              (LETT |pSF| (|ACPLOT;coerceCoefsToSFs| |p| $))
              (LETT |dpdxSF| (|ACPLOT;coerceCoefsToSFs| |dpdx| $))
              (LETT |dpdySF| (|ACPLOT;coerceCoefsToSFs| |dpdy| $))
              (LETT |xMin| (QVELT |plot| 3)) (LETT |xMax| (QVELT |plot| 4))
              (LETT |yMin| (QVELT |plot| 5)) (LETT |yMax| (QVELT |plot| 6))
              (LETT |xMinSF| (|ACPLOT;RNtoSF| |xMin| $))
              (LETT |xMaxSF| (|ACPLOT;RNtoSF| |xMax| $))
              (LETT |yMinSF| (|ACPLOT;RNtoSF| |yMin| $))
              (LETT |yMaxSF| (|ACPLOT;RNtoSF| |yMax| $))
              (LETT |corners|
                    (|ACPLOT;makeCorners| |xMinSF| |xMaxSF| |yMinSF| |yMaxSF|
                     $))
              (LETT |pSF| (|ACPLOT;coerceCoefsToSFs| |p| $))
              (LETT |dpdxSF| (|ACPLOT;coerceCoefsToSFs| |dpdx| $))
              (LETT |dpdySF| (|ACPLOT;coerceCoefsToSFs| |dpdy| $))
              (LETT |delta|
                    (|mul_DF| |stepFraction|
                              (|min_DF|
                               (|div_DF_I| (|sub_DF| |xMaxSF| |xMinSF|) 25)
                               (|div_DF_I| (|sub_DF| |yMaxSF| |yMinSF|) 25))))
              (LETT |err|
                    (|min_DF| (|div_DF_I| |delta| 100)
                              (|div_DF_I| (QREFELT $ 15) 100)))
              (LETT |bound| 10)
              (LETT |crits|
                    (SPADCALL (QVELT |plot| 8) (QVELT |plot| 9)
                              (QREFELT $ 129)))
              (LETT |bdPts| (QVELT |plot| 7))
              (LETT |bran|
                    (|ACPLOT;traceBranches| |pSF| |dpdxSF| |dpdySF| |x| |y|
                     |corners| |delta| |err| |bound| |crits| |bdPts| $))
              (LETT |htans| (QVELT |plot| 8)) (LETT |vtans| (QVELT |plot| 9))
              (EXIT
               (VECTOR |p| |x| |y| |xMin| |xMax| |yMin| |yMax| |bdPts| |htans|
                       |vtans| |bran|))))) 

(SDEFUN |ACPLOT;traceBranches|
        ((|pSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdxSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdySF| (|Polynomial| (|DoubleFloat|))) (|x| (|Symbol|))
         (|y| (|Symbol|))
         (|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         (|delta| (|DoubleFloat|)) (|err| (|DoubleFloat|))
         (|bound| (|PositiveInteger|))
         (|crits| (|List| (|Point| (|DoubleFloat|))))
         (|bdPts|
          (|Record| (|:| |left| #1=(|List| (|Point| (|DoubleFloat|))))
                    (|:| |right| #2=(|List| (|Point| (|DoubleFloat|))))
                    (|:| |bottom| #3=(|List| (|Point| (|DoubleFloat|))))
                    (|:| |top| #4=(|List| (|Point| (|DoubleFloat|))))))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|bran| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|segInfo| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|pt| (|Point| (|DoubleFloat|)))
          (|bdry| (|List| (|Point| (|DoubleFloat|))))
          (|p0| (|Point| (|DoubleFloat|))) (|bt| #3#) (|tp| #4#) (|rt| #2#)
          (|lf| #1#))
         (SEQ (LETT |lf| (QVELT |bdPts| 0)) (LETT |rt| (QVELT |bdPts| 1))
              (LETT |tp| (QVELT |bdPts| 3)) (LETT |bt| (QVELT |bdPts| 2))
              (LETT |bdry|
                    (SPADCALL (SPADCALL |lf| |rt| (QREFELT $ 129))
                              (SPADCALL |bt| |tp| (QREFELT $ 129))
                              (QREFELT $ 129)))
              (LETT |bran| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |bdry|))) (GO G191)))
                   (SEQ (LETT |pt| (|SPADfirst| |bdry|))
                        (LETT |p0|
                              (|ACPLOT;dummyFirstPt| |pt| |dpdxSF| |dpdySF| |x|
                               |y| |lf| |rt| |bt| |tp| $))
                        (LETT |segInfo|
                              (|ACPLOT;listPtsOnSegment| |pSF| |dpdxSF|
                               |dpdySF| |x| |y| |p0| |pt| |corners| |delta|
                               |err| |bound| |crits| |bdry| $))
                        (LETT |bran| (CONS (|SPADfirst| |segInfo|) |bran|))
                        (LETT |crits| (SPADCALL |segInfo| (QREFELT $ 131)))
                        (EXIT
                         (LETT |bdry| (SPADCALL |segInfo| (QREFELT $ 132)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (NULL (NULL |crits|))) (GO G191)))
                   (SEQ (LETT |pt| (|SPADfirst| |crits|))
                        (LETT |segInfo|
                              (|ACPLOT;listPtsOnLoop| |pSF| |dpdxSF| |dpdySF|
                               |x| |y| |pt| |corners| |delta| |err| |bound|
                               |crits| |bdry| $))
                        (LETT |bran| (CONS (|SPADfirst| |segInfo|) |bran|))
                        (EXIT
                         (LETT |crits| (SPADCALL |segInfo| (QREFELT $ 131)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |bran|)))) 

(SDEFUN |ACPLOT;dummyFirstPt|
        ((|p1| (|Point| (|DoubleFloat|)))
         (|dpdxSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdySF| (|Polynomial| (|DoubleFloat|))) (|x| (|Symbol|))
         (|y| (|Symbol|)) (|lf| (|List| (|Point| (|DoubleFloat|))))
         (|rt| (|List| (|Point| (|DoubleFloat|))))
         (|bt| (|List| (|Point| (|DoubleFloat|))))
         (|tp| (|List| (|Point| (|DoubleFloat|))))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG
         ((|py| #1=(|DoubleFloat|)) (|px| #1#) (|one| (|DoubleFloat|))
          (|zero| (|DoubleFloat|)) (|y1| (|DoubleFloat|))
          (|x1| (|DoubleFloat|)))
         (SEQ (LETT |x1| (SPADCALL |p1| (QREFELT $ 28)))
              (LETT |y1| (SPADCALL |p1| (QREFELT $ 27))) (LETT |zero| 0.0)
              (LETT |one| 1.0)
              (LETT |px|
                    (SPADCALL
                     (SPADCALL |dpdxSF| (LIST |x| |y|) (LIST |x1| |y1|)
                               (QREFELT $ 133))
                     (QREFELT $ 134)))
              (LETT |py|
                    (SPADCALL
                     (SPADCALL |dpdySF| (LIST |x| |y|) (LIST |x1| |y1|)
                               (QREFELT $ 133))
                     (QREFELT $ 134)))
              (EXIT
               (COND
                ((|less_DF| (|mul_DF| |px| |py|) |zero|)
                 (COND
                  ((OR (SPADCALL |p1| |lf| (QREFELT $ 135))
                       (SPADCALL |p1| |bt| (QREFELT $ 135)))
                   (|ACPLOT;makePt| (|sub_DF| |x1| |one|) (|sub_DF| |y1| |one|)
                    $))
                  (#2='T
                   (|ACPLOT;makePt| (|add_DF| |x1| |one|) (|add_DF| |y1| |one|)
                    $))))
                ((OR (SPADCALL |p1| |lf| (QREFELT $ 135))
                     (SPADCALL |p1| |tp| (QREFELT $ 135)))
                 (|ACPLOT;makePt| (|sub_DF| |x1| |one|) (|add_DF| |y1| |one|)
                  $))
                (#2#
                 (|ACPLOT;makePt| (|add_DF| |x1| |one|) (|sub_DF| |y1| |one|)
                  $))))))) 

(SDEFUN |ACPLOT;listPtsOnSegment|
        ((|pSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdxSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdySF| (|Polynomial| (|DoubleFloat|))) (|x| (|Symbol|))
         (|y| (|Symbol|)) (|p0| (|Point| (|DoubleFloat|)))
         (|p1| #1=(|Point| (|DoubleFloat|)))
         (|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         (|delta| (|DoubleFloat|)) (|err| (|DoubleFloat|))
         (|bound| (|PositiveInteger|))
         (|crits| (|List| (|Point| (|DoubleFloat|))))
         (|bdry| (|List| (|Point| (|DoubleFloat|))))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|pointList| (|List| #1#)) (#2=#:G1100 NIL)
          (|p2| #3=(|Point| (|DoubleFloat|)))
          (|ptInfo| (|Record| (|:| |newPt| #3#) (|:| |type| (|String|))))
          (|pt1| (|Point| (|DoubleFloat|))) (|pt0| (|Point| (|DoubleFloat|))))
         (SEQ
          (EXIT
           (SEQ (LETT |bdry| (SPADCALL |p1| |bdry| (QREFELT $ 136)))
                (LETT |pointList| (LIST |p1|))
                (LETT |ptInfo|
                      (|ACPLOT;computeNextPt| |pSF| |dpdxSF| |dpdySF| |x| |y|
                       |p0| |p1| |corners| |delta| |err| |bound| |crits| |bdry|
                       $))
                (LETT |p2| (QCAR |ptInfo|))
                (EXIT
                 (COND
                  ((EQUAL (QCDR |ptInfo|) (QREFELT $ 17))
                   (SEQ (LETT |bdry| (SPADCALL |p2| |bdry| (QREFELT $ 136)))
                        (LETT |pointList| (CONS |p2| |pointList|))
                        (EXIT (LIST |pointList| |crits| |bdry|))))
                  ('T
                   (SEQ
                    (COND
                     ((EQUAL (QCDR |ptInfo|) (QREFELT $ 18))
                      (LETT |crits| (SPADCALL |p2| |crits| (QREFELT $ 136)))))
                    (LETT |pointList| (CONS |p2| |pointList|))
                    (SEQ G190 NIL
                         (SEQ
                          (LETT |pt0| (SPADCALL |pointList| (QREFELT $ 137)))
                          (LETT |pt1| (|SPADfirst| |pointList|))
                          (LETT |ptInfo|
                                (|ACPLOT;computeNextPt| |pSF| |dpdxSF| |dpdySF|
                                 |x| |y| |pt0| |pt1| |corners| |delta| |err|
                                 |bound| |crits| |bdry| $))
                          (LETT |p2| (QCAR |ptInfo|))
                          (EXIT
                           (COND
                            ((EQUAL (QCDR |ptInfo|) (QREFELT $ 17))
                             (SEQ
                              (LETT |bdry|
                                    (SPADCALL |p2| |bdry| (QREFELT $ 136)))
                              (LETT |pointList| (CONS |p2| |pointList|))
                              (EXIT
                               (PROGN
                                (LETT #2# (LIST |pointList| |crits| |bdry|))
                                (GO #4=#:G1099)))))
                            ('T
                             (SEQ
                              (COND
                               ((EQUAL (QCDR |ptInfo|) (QREFELT $ 18))
                                (LETT |crits|
                                      (SPADCALL |p2| |crits|
                                                (QREFELT $ 136)))))
                              (EXIT
                               (LETT |pointList| (CONS |p2| |pointList|))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (LIST |pointList| |crits| |bdry|))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |ACPLOT;listPtsOnLoop|
        ((|pSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdxSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdySF| (|Polynomial| (|DoubleFloat|))) (|x| (|Symbol|))
         (|y| (|Symbol|)) (|p1| #1=(|Point| (|DoubleFloat|)))
         (|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         (|delta| (|DoubleFloat|)) (|err| (|DoubleFloat|))
         (|bound| (|PositiveInteger|))
         (|crits| (|List| (|Point| (|DoubleFloat|))))
         (|bdry| (|List| (|Point| (|DoubleFloat|))))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|pointList| (|List| #1#)) (#2=#:G1115 NIL)
          (|p2| #3=(|Point| (|DoubleFloat|)))
          (|ptInfo| (|Record| (|:| |newPt| #3#) (|:| |type| (|String|))))
          (|pt1| (|Point| (|DoubleFloat|))) (|pt0| (|Point| (|DoubleFloat|)))
          (|p0| (|Point| (|DoubleFloat|))) (|y1| (|DoubleFloat|))
          (|x1| (|DoubleFloat|)))
         (SEQ
          (EXIT
           (SEQ (LETT |x1| (SPADCALL |p1| (QREFELT $ 28)))
                (LETT |y1| (SPADCALL |p1| (QREFELT $ 27)))
                (LETT |p0|
                      (|ACPLOT;makePt| (|sub_DF| |x1| 1.0) (|sub_DF| |y1| 1.0)
                       $))
                (LETT |pointList| (LIST |p1|))
                (LETT |ptInfo|
                      (|ACPLOT;computeNextPt| |pSF| |dpdxSF| |dpdySF| |x| |y|
                       |p0| |p1| |corners| |delta| |err| |bound| |crits| |bdry|
                       $))
                (LETT |p2| (QCAR |ptInfo|))
                (EXIT
                 (COND
                  ((EQUAL (QCDR |ptInfo|) (QREFELT $ 17))
                   (|error| "boundary reached while on loop"))
                  (#4='T
                   (SEQ
                    (COND
                     ((EQUAL (QCDR |ptInfo|) (QREFELT $ 18))
                      (COND
                       ((SPADCALL |p1| |p2| (QREFELT $ 138))
                        (|error|
                         "first and second points on loop are identical"))
                       (#4#
                        (LETT |crits|
                              (SPADCALL |p2| |crits| (QREFELT $ 136)))))))
                    (LETT |pointList| (CONS |p2| |pointList|))
                    (SEQ G190 NIL
                         (SEQ
                          (LETT |pt0| (SPADCALL |pointList| (QREFELT $ 137)))
                          (LETT |pt1| (|SPADfirst| |pointList|))
                          (LETT |ptInfo|
                                (|ACPLOT;computeNextPt| |pSF| |dpdxSF| |dpdySF|
                                 |x| |y| |pt0| |pt1| |corners| |delta| |err|
                                 |bound| |crits| |bdry| $))
                          (LETT |p2| (QCAR |ptInfo|))
                          (EXIT
                           (COND
                            ((EQUAL (QCDR |ptInfo|) (QREFELT $ 17))
                             (|error| "boundary reached while on loop"))
                            ('T
                             (SEQ
                              (COND
                               ((EQUAL (QCDR |ptInfo|) (QREFELT $ 18))
                                (SEQ
                                 (LETT |crits|
                                       (SPADCALL |p2| |crits| (QREFELT $ 136)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |p1| |p2| (QREFELT $ 138))
                                    (SEQ
                                     (LETT |pointList| (CONS |p2| |pointList|))
                                     (EXIT
                                      (PROGN
                                       (LETT #2#
                                             (LIST |pointList| |crits| |bdry|))
                                       (GO #5=#:G1114))))))))))
                              (EXIT
                               (LETT |pointList| (CONS |p2| |pointList|))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (LIST |pointList| |crits| |bdry|))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |ACPLOT;computeNextPt|
        ((|pSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdxSF| (|Polynomial| (|DoubleFloat|)))
         (|dpdySF| (|Polynomial| (|DoubleFloat|))) (|x| #1=(|Symbol|))
         (|y| (|Symbol|)) (|p0| (|Point| (|DoubleFloat|)))
         (|p1| (|Point| (|DoubleFloat|)))
         (|corners|
          (|Record| (|:| |minXVal| (|DoubleFloat|))
                    (|:| |maxXVal| (|DoubleFloat|))
                    (|:| |minYVal| (|DoubleFloat|))
                    (|:| |maxYVal| (|DoubleFloat|))))
         (|delta| (|DoubleFloat|)) (|err| (|DoubleFloat|))
         (|bound| (|PositiveInteger|))
         (|crits| (|List| (|Point| (|DoubleFloat|))))
         (|bdry| (|List| (|Point| (|DoubleFloat|))))
         ($
          (|Record| (|:| |newPt| (|Point| (|DoubleFloat|)))
                    (|:| |type| (|String|)))))
        (SPROG
         ((|critPt| #2=(|Union| (|Point| (|DoubleFloat|)) #3="failed"))
          (|bdryPt| #2#) (|pt| #4=(|Point| (|DoubleFloat|)))
          (|x2| #5=(|DoubleFloat|)) (#6=#:G1178 NIL)
          (|x2New| #7=(|Union| (|DoubleFloat|) "failed"))
          (|f| (|SparseUnivariatePolynomial| (|DoubleFloat|)))
          (|y2| (|DoubleFloat|)) (|y2New| #7#) (|y2Approx| #5#)
          (|x2Approx| #5#) (|lookingFor| (|String|)) (|incVar| #1#)
          (#8=#:G1143 NIL) (|critPt2| #2#) (|critPt1| #2#) (|pt2| #4#)
          (|pt1| #4#) (|x2Temp| #5#) (|y2Temp| #5#) (|yHi| #5#)
          (|yLo| #9=(|DoubleFloat|))
          (|yPointList| (|List| (|Point| (|DoubleFloat|)))) (|xHi| #5#)
          (|xLo| #10=(|DoubleFloat|))
          (|xPointList| (|List| (|Point| (|DoubleFloat|)))) (|yy| #9#)
          (|xx| #10#) (#11=#:G1179 NIL) (|y2Approxx| #5#) (|x2Approxx| #5#)
          (|deltaY| #12=(|DoubleFloat|)) (|incVar0| #1#) (|deltaX| #12#)
          (|py| #13=(|DoubleFloat|)) (|px| #13#) (|y1| #9#) (|x1| #10#)
          (|y0| #9#) (|x0| #10#) (|yMaxSF| (|DoubleFloat|))
          (|yMinSF| (|DoubleFloat|)) (|xMaxSF| (|DoubleFloat|))
          (|xMinSF| (|DoubleFloat|)))
         (SEQ
          (EXIT
           (SEQ (LETT |xMinSF| (|ACPLOT;getXMin| |corners| $))
                (LETT |xMaxSF| (|ACPLOT;getXMax| |corners| $))
                (LETT |yMinSF| (|ACPLOT;getYMin| |corners| $))
                (LETT |yMaxSF| (|ACPLOT;getYMax| |corners| $))
                (LETT |x0| (SPADCALL |p0| (QREFELT $ 28)))
                (LETT |y0| (SPADCALL |p0| (QREFELT $ 27)))
                (LETT |x1| (SPADCALL |p1| (QREFELT $ 28)))
                (LETT |y1| (SPADCALL |p1| (QREFELT $ 27)))
                (LETT |px|
                      (SPADCALL
                       (SPADCALL |dpdxSF| (LIST |x| |y|) (LIST |x1| |y1|)
                                 (QREFELT $ 133))
                       (QREFELT $ 134)))
                (LETT |py|
                      (SPADCALL
                       (SPADCALL |dpdySF| (LIST |x| |y|) (LIST |x1| |y1|)
                                 (QREFELT $ 133))
                       (QREFELT $ 134)))
                (COND
                 ((SPADCALL (|abs_DF| |py|) (|abs_DF| |px|) (QREFELT $ 111))
                  (SEQ (LETT |incVar0| (LETT |incVar| |x|))
                       (LETT |deltaX|
                             (COND
                              ((SPADCALL |x1| |x0| (QREFELT $ 111)) |delta|)
                              (#14='T (|minus_DF| |delta|))))
                       (LETT |x2Approx| (|add_DF| |x1| |deltaX|))
                       (EXIT
                        (LETT |y2Approx|
                              (|add_DF| |y1|
                                        (|mul_DF|
                                         (|minus_DF| (|div_DF| |px| |py|))
                                         |deltaX|))))))
                 (#14#
                  (SEQ (LETT |incVar0| (LETT |incVar| |y|))
                       (LETT |deltaY|
                             (COND
                              ((SPADCALL |y1| |y0| (QREFELT $ 111)) |delta|)
                              (#14# (|minus_DF| |delta|))))
                       (LETT |x2Approx|
                             (|add_DF| |x1|
                                       (|mul_DF|
                                        (|minus_DF| (|div_DF| |py| |px|))
                                        |deltaY|)))
                       (EXIT (LETT |y2Approx| (|add_DF| |y1| |deltaY|))))))
                (LETT |lookingFor| (QREFELT $ 16))
                (COND
                 ((SPADCALL |x2Approx| |xMaxSF| (QREFELT $ 92))
                  (SEQ (LETT |incVar| |x|) (LETT |lookingFor| (QREFELT $ 17))
                       (LETT |x2Approx| |xMaxSF|)
                       (EXIT
                        (LETT |y2Approx|
                              (|add_DF| |y1|
                                        (|mul_DF|
                                         (|minus_DF| (|div_DF| |px| |py|))
                                         (|sub_DF| |x2Approx| |x1|)))))))
                 ((SPADCALL |x2Approx| |xMinSF| (QREFELT $ 89))
                  (SEQ (LETT |incVar| |x|) (LETT |lookingFor| (QREFELT $ 17))
                       (LETT |x2Approx| |xMinSF|)
                       (EXIT
                        (LETT |y2Approx|
                              (|add_DF| |y1|
                                        (|mul_DF|
                                         (|minus_DF| (|div_DF| |px| |py|))
                                         (|sub_DF| |x2Approx| |x1|))))))))
                (COND
                 ((SPADCALL |y2Approx| |yMaxSF| (QREFELT $ 92))
                  (SEQ (LETT |incVar| |y|) (LETT |lookingFor| (QREFELT $ 17))
                       (LETT |y2Approx| |yMaxSF|)
                       (EXIT
                        (LETT |x2Approx|
                              (|add_DF| |x1|
                                        (|mul_DF|
                                         (|minus_DF| (|div_DF| |py| |px|))
                                         (|sub_DF| |y2Approx| |y1|)))))))
                 ((SPADCALL |y2Approx| |yMinSF| (QREFELT $ 89))
                  (SEQ (LETT |incVar| |y|) (LETT |lookingFor| (QREFELT $ 17))
                       (LETT |y2Approx| |yMinSF|)
                       (EXIT
                        (LETT |x2Approx|
                              (|add_DF| |x1|
                                        (|mul_DF|
                                         (|minus_DF| (|div_DF| |py| |px|))
                                         (|sub_DF| |y2Approx| |y1|))))))))
                (COND
                 ((|less_DF| |x1| |x2Approx|)
                  (SEQ (LETT |xLo| |x1|) (EXIT (LETT |xHi| |x2Approx|))))
                 (#14# (SEQ (LETT |xLo| |x2Approx|) (EXIT (LETT |xHi| |x1|)))))
                (COND
                 ((|less_DF| |y1| |y2Approx|)
                  (SEQ (LETT |yLo| |y1|) (EXIT (LETT |yHi| |y2Approx|))))
                 (#14# (SEQ (LETT |yLo| |y2Approx|) (EXIT (LETT |yHi| |y1|)))))
                (LETT |x2Approxx| |x2Approx|) (LETT |y2Approxx| |y2Approx|)
                (LETT |xPointList| NIL) (LETT |yPointList| NIL)
                (SEQ (LETT #11# |crits|) G190
                     (COND
                      ((OR (ATOM #11#) (PROGN (LETT |pt| (CAR #11#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |xx| (SPADCALL |pt| (QREFELT $ 28)))
                          (LETT |yy| (SPADCALL |pt| (QREFELT $ 27)))
                          (COND
                           ((|eql_DF| |xx| |x2Approx|)
                            (COND
                             ((NULL (|eql_DF| |xx| |x1|))
                              (COND
                               ((|less_DF|
                                 (|min_DF| (|abs_DF| (|sub_DF| |yy| |yLo|))
                                           (|abs_DF| (|sub_DF| |yy| |yHi|)))
                                 |delta|)
                                (LETT |xPointList|
                                      (CONS |pt| |xPointList|))))))))
                          (COND
                           ((|less_DF| |xLo| |xx|)
                            (COND
                             ((|less_DF| |xx| |xHi|)
                              (COND
                               ((|less_DF|
                                 (|min_DF| (|abs_DF| (|sub_DF| |yy| |yLo|))
                                           (|abs_DF| (|sub_DF| |yy| |yHi|)))
                                 |delta|)
                                (SEQ (LETT |xPointList| (CONS |pt| NIL))
                                     (LETT |x2Approx| |xx|)
                                     (EXIT
                                      (COND
                                       ((|less_DF| |xx| |x1|)
                                        (LETT |xLo| |xx|))
                                       ('T (LETT |xHi| |xx|)))))))))))
                          (COND
                           ((|eql_DF| |yy| |y2Approx|)
                            (COND
                             ((NULL (|eql_DF| |yy| |y1|))
                              (LETT |yPointList| (CONS |pt| |yPointList|))))))
                          (EXIT
                           (COND
                            ((|less_DF| |yLo| |yy|)
                             (COND
                              ((|less_DF| |yy| |yHi|)
                               (COND
                                ((|less_DF|
                                  (|min_DF| (|abs_DF| (|sub_DF| |xx| |xLo|))
                                            (|abs_DF| (|sub_DF| |xx| |xHi|)))
                                  |delta|)
                                 (SEQ (LETT |yPointList| (CONS |pt| NIL))
                                      (LETT |y2Approx| |yy|)
                                      (EXIT
                                       (COND
                                        ((|less_DF| |yy| |y1|)
                                         (LETT |yLo| |yy|))
                                        ('T (LETT |yHi| |yy|)))))))))))))
                     (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((NULL (NULL |xPointList|))
                  (COND
                   ((NULL (NULL |yPointList|))
                    (COND
                     ((SPADCALL |xPointList| |yPointList| (QREFELT $ 139))
                      (SEQ (LETT |incVar| |incVar0|)
                           (COND
                            ((EQUAL |incVar| |x|)
                             (LETT |y2Approx|
                                   (|add_DF| |y1|
                                             (|mul_DF|
                                              (|minus_DF| (|div_DF| |px| |py|))
                                              (|sub_DF| |x2Approx| |x1|)))))
                            (#14#
                             (LETT |x2Approx|
                                   (|add_DF| |x1|
                                             (|mul_DF|
                                              (|minus_DF| (|div_DF| |py| |px|))
                                              (|sub_DF| |y2Approx| |y1|))))))
                           (EXIT (LETT |lookingFor| (QREFELT $ 18)))))
                     ((EQUAL |incVar0| |x|)
                      (SEQ
                       (LETT |x2Temp|
                             (|add_DF| |x1|
                                       (|mul_DF|
                                        (|minus_DF| (|div_DF| |py| |px|))
                                        (|sub_DF| |y2Approx| |y1|))))
                       (LETT |f|
                             (|ACPLOT;SFPolyToUPoly|
                              (SPADCALL |pSF| |y| |y2Approx| (QREFELT $ 140))
                              $))
                       (LETT |x2New|
                             (|ACPLOT;newtonApprox| |f| |x2Temp| |err| |bound|
                              $))
                       (EXIT
                        (COND
                         ((QEQCAR |x2New| 1)
                          (SEQ
                           (LETT |y2Approx|
                                 (|add_DF| |y1|
                                           (|mul_DF|
                                            (|minus_DF| (|div_DF| |px| |py|))
                                            (|sub_DF| |x2Approx| |x1|))))
                           (LETT |incVar| |x|)
                           (EXIT (LETT |lookingFor| (QREFELT $ 18)))))
                         (#14#
                          (SEQ
                           (LETT |y2Temp|
                                 (|add_DF| |y1|
                                           (|mul_DF|
                                            (|minus_DF| (|div_DF| |px| |py|))
                                            (|sub_DF| |x2Approx| |x1|))))
                           (LETT |f|
                                 (|ACPLOT;SFPolyToUPoly|
                                  (SPADCALL |pSF| |x| |x2Approx|
                                            (QREFELT $ 140))
                                  $))
                           (LETT |y2New|
                                 (|ACPLOT;newtonApprox| |f| |y2Temp| |err|
                                  |bound| $))
                           (EXIT
                            (COND
                             ((QEQCAR |y2New| 1)
                              (PROGN
                               (LETT #6#
                                     (|ACPLOT;computeNextPt| |pSF| |dpdxSF|
                                      |dpdySF| |x| |y| |p0| |p1| |corners|
                                      (|abs_DF|
                                       (|div_DF_I| (|sub_DF| |x2Approx| |x1|)
                                                   2))
                                      |err| |bound| |crits| |bdry| $))
                               (GO #15=#:G1177)))
                             (#14#
                              (SEQ
                               (LETT |pt1|
                                     (|ACPLOT;makePt| |x2Approx| (QCDR |y2New|)
                                      $))
                               (LETT |pt2|
                                     (|ACPLOT;makePt| (QCDR |x2New|) |y2Approx|
                                      $))
                               (LETT |critPt1|
                                     (|ACPLOT;findPtOnList| |pt1| |crits| $))
                               (LETT |critPt2|
                                     (|ACPLOT;findPtOnList| |pt2| |crits| $))
                               (COND
                                ((QEQCAR |critPt1| 1)
                                 (COND
                                  ((QEQCAR |critPt2| 1)
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (|abs_DF| (|sub_DF| |x2Approx| |x1|))
                                       (|abs_DF| (|sub_DF| |x2Temp| |x1|))
                                       (QREFELT $ 111))
                                      (PROGN
                                       (LETT #6# (CONS |pt1| (QREFELT $ 16)))
                                       (GO #15#)))
                                     (#14#
                                      (PROGN
                                       (LETT #6# (CONS |pt2| (QREFELT $ 16)))
                                       (GO #15#)))))))))
                               (EXIT
                                (COND
                                 ((QEQCAR |critPt1| 1)
                                  (PROGN
                                   (LETT #6#
                                         (CONS
                                          (PROG2 (LETT #8# |critPt2|)
                                              (QCDR #8#)
                                            (|check_union2| (QEQCAR #8# 0)
                                                            (|Point|
                                                             (|DoubleFloat|))
                                                            (|Union|
                                                             (|Point|
                                                              (|DoubleFloat|))
                                                             #3#)
                                                            #8#))
                                          (QREFELT $ 18)))
                                   (GO #15#)))
                                 ((QEQCAR |critPt2| 1)
                                  (PROGN
                                   (LETT #6#
                                         (CONS (QCDR |critPt1|)
                                               (QREFELT $ 18)))
                                   (GO #15#)))
                                 (#14#
                                  (COND
                                   ((SPADCALL
                                     (|abs_DF| (|sub_DF| |x2Approx| |x1|))
                                     (|abs_DF| (|sub_DF| |x2Temp| |x1|))
                                     (QREFELT $ 111))
                                    (PROGN
                                     (LETT #6#
                                           (CONS (QCDR |critPt2|)
                                                 (QREFELT $ 18)))
                                     (GO #15#)))
                                   (#14#
                                    (PROGN
                                     (LETT #6#
                                           (CONS (QCDR |critPt1|)
                                                 (QREFELT $ 18)))
                                     (GO #15#)))))))))))))))))
                     (#14#
                      (SEQ
                       (LETT |y2Temp|
                             (|add_DF| |y1|
                                       (|mul_DF|
                                        (|minus_DF| (|div_DF| |px| |py|))
                                        (|sub_DF| |x2Approx| |x1|))))
                       (LETT |f|
                             (|ACPLOT;SFPolyToUPoly|
                              (SPADCALL |pSF| |x| |x2Approx| (QREFELT $ 140))
                              $))
                       (LETT |y2New|
                             (|ACPLOT;newtonApprox| |f| |y2Temp| |err| |bound|
                              $))
                       (EXIT
                        (COND
                         ((QEQCAR |y2New| 1)
                          (SEQ
                           (LETT |x2Approx|
                                 (|add_DF| |x1|
                                           (|mul_DF|
                                            (|minus_DF| (|div_DF| |py| |px|))
                                            (|sub_DF| |y2Approx| |y1|))))
                           (LETT |incVar| |y|)
                           (EXIT (LETT |lookingFor| (QREFELT $ 18)))))
                         (#14#
                          (SEQ
                           (LETT |x2Temp|
                                 (|add_DF| |x1|
                                           (|mul_DF|
                                            (|minus_DF| (|div_DF| |py| |px|))
                                            (|sub_DF| |y2Approx| |y1|))))
                           (LETT |f|
                                 (|ACPLOT;SFPolyToUPoly|
                                  (SPADCALL |pSF| |y| |y2Approx|
                                            (QREFELT $ 140))
                                  $))
                           (LETT |x2New|
                                 (|ACPLOT;newtonApprox| |f| |x2Temp| |err|
                                  |bound| $))
                           (EXIT
                            (COND
                             ((QEQCAR |x2New| 1)
                              (PROGN
                               (LETT #6#
                                     (|ACPLOT;computeNextPt| |pSF| |dpdxSF|
                                      |dpdySF| |x| |y| |p0| |p1| |corners|
                                      (|abs_DF|
                                       (|div_DF_I| (|sub_DF| |y2Approx| |y1|)
                                                   2))
                                      |err| |bound| |crits| |bdry| $))
                               (GO #15#)))
                             (#14#
                              (SEQ
                               (LETT |pt1|
                                     (|ACPLOT;makePt| |x2Approx| (QCDR |y2New|)
                                      $))
                               (LETT |pt2|
                                     (|ACPLOT;makePt| (QCDR |x2New|) |y2Approx|
                                      $))
                               (LETT |critPt1|
                                     (|ACPLOT;findPtOnList| |pt1| |crits| $))
                               (LETT |critPt2|
                                     (|ACPLOT;findPtOnList| |pt2| |crits| $))
                               (COND
                                ((QEQCAR |critPt1| 1)
                                 (COND
                                  ((QEQCAR |critPt2| 1)
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (|abs_DF| (|sub_DF| |y2Approx| |y1|))
                                       (|abs_DF| (|sub_DF| |y2Temp| |y1|))
                                       (QREFELT $ 111))
                                      (PROGN
                                       (LETT #6# (CONS |pt2| (QREFELT $ 16)))
                                       (GO #15#)))
                                     (#14#
                                      (PROGN
                                       (LETT #6# (CONS |pt1| (QREFELT $ 16)))
                                       (GO #15#)))))))))
                               (EXIT
                                (COND
                                 ((QEQCAR |critPt1| 1)
                                  (PROGN
                                   (LETT #6#
                                         (CONS
                                          (PROG2 (LETT #8# |critPt2|)
                                              (QCDR #8#)
                                            (|check_union2| (QEQCAR #8# 0)
                                                            (|Point|
                                                             (|DoubleFloat|))
                                                            (|Union|
                                                             (|Point|
                                                              (|DoubleFloat|))
                                                             #3#)
                                                            #8#))
                                          (QREFELT $ 18)))
                                   (GO #15#)))
                                 ((QEQCAR |critPt2| 1)
                                  (PROGN
                                   (LETT #6#
                                         (CONS (QCDR |critPt1|)
                                               (QREFELT $ 18)))
                                   (GO #15#)))
                                 (#14#
                                  (COND
                                   ((SPADCALL
                                     (|abs_DF| (|sub_DF| |y2Approx| |y1|))
                                     (|abs_DF| (|sub_DF| |y2Temp| |y1|))
                                     (QREFELT $ 111))
                                    (PROGN
                                     (LETT #6#
                                           (CONS (QCDR |critPt1|)
                                                 (QREFELT $ 18)))
                                     (GO #15#)))
                                   (#14#
                                    (PROGN
                                     (LETT #6#
                                           (CONS (QCDR |critPt2|)
                                                 (QREFELT $ 18)))
                                     (GO #15#))))))))))))))))))))))
                (COND
                 ((NULL (NULL |xPointList|))
                  (COND
                   ((NULL |yPointList|)
                    (SEQ
                     (LETT |y2Approx|
                           (|add_DF| |y1|
                                     (|mul_DF|
                                      (|minus_DF| (|div_DF| |px| |py|))
                                      (|sub_DF| |x2Approx| |x1|))))
                     (EXIT
                      (COND
                       ((EQUAL |incVar0| |x|)
                        (SEQ (LETT |incVar| |x|)
                             (EXIT (LETT |lookingFor| (QREFELT $ 18)))))
                       (#14#
                        (SEQ
                         (LETT |f|
                               (|ACPLOT;SFPolyToUPoly|
                                (SPADCALL |pSF| |x| |x2Approx| (QREFELT $ 140))
                                $))
                         (LETT |y2New|
                               (|ACPLOT;newtonApprox| |f| |y2Approx| |err|
                                |bound| $))
                         (EXIT
                          (COND
                           ((QEQCAR |y2New| 1)
                            (SEQ (LETT |x2Approx| |x2Approxx|)
                                 (EXIT (LETT |y2Approx| |y2Approxx|))))
                           (#14#
                            (SEQ
                             (LETT |pt|
                                   (|ACPLOT;makePt| |x2Approx| (QCDR |y2New|)
                                    $))
                             (LETT |critPt|
                                   (|ACPLOT;findPtOnList| |pt| |crits| $))
                             (EXIT
                              (COND
                               ((QEQCAR |critPt| 1)
                                (PROGN
                                 (LETT #6# (CONS |pt| (QREFELT $ 16)))
                                 (GO #15#)))
                               (#14#
                                (PROGN
                                 (LETT #6#
                                       (CONS (QCDR |critPt|) (QREFELT $ 18)))
                                 (GO #15#))))))))))))))))))
                (COND
                 ((NULL |xPointList|)
                  (COND
                   ((NULL (NULL |yPointList|))
                    (SEQ
                     (LETT |x2Approx|
                           (|add_DF| |x1|
                                     (|mul_DF|
                                      (|minus_DF| (|div_DF| |py| |px|))
                                      (|sub_DF| |y2Approx| |y1|))))
                     (EXIT
                      (COND
                       ((EQUAL |incVar0| |y|)
                        (SEQ (LETT |incVar| |y|)
                             (EXIT (LETT |lookingFor| (QREFELT $ 18)))))
                       (#14#
                        (SEQ
                         (LETT |f|
                               (|ACPLOT;SFPolyToUPoly|
                                (SPADCALL |pSF| |y| |y2Approx| (QREFELT $ 140))
                                $))
                         (LETT |x2New|
                               (|ACPLOT;newtonApprox| |f| |x2Approx| |err|
                                |bound| $))
                         (EXIT
                          (COND
                           ((QEQCAR |x2New| 1)
                            (SEQ (LETT |x2Approx| |x2Approxx|)
                                 (EXIT (LETT |y2Approx| |y2Approxx|))))
                           (#14#
                            (SEQ
                             (LETT |pt|
                                   (|ACPLOT;makePt| (QCDR |x2New|) |y2Approx|
                                    $))
                             (LETT |critPt|
                                   (|ACPLOT;findPtOnList| |pt| |crits| $))
                             (EXIT
                              (COND
                               ((QEQCAR |critPt| 1)
                                (PROGN
                                 (LETT #6# (CONS |pt| (QREFELT $ 16)))
                                 (GO #15#)))
                               (#14#
                                (PROGN
                                 (LETT #6#
                                       (CONS (QCDR |critPt|) (QREFELT $ 18)))
                                 (GO #15#))))))))))))))))))
                (COND
                 ((EQUAL |incVar| |x|)
                  (SEQ (LETT |x2| |x2Approx|)
                       (LETT |f|
                             (|ACPLOT;SFPolyToUPoly|
                              (SPADCALL |pSF| |x| |x2| (QREFELT $ 140)) $))
                       (LETT |y2New|
                             (|ACPLOT;newtonApprox| |f| |y2Approx| |err|
                              |bound| $))
                       (EXIT
                        (COND
                         ((QEQCAR |y2New| 1)
                          (PROGN
                           (LETT #6#
                                 (|ACPLOT;computeNextPt| |pSF| |dpdxSF|
                                  |dpdySF| |x| |y| |p0| |p1| |corners|
                                  (|abs_DF|
                                   (|div_DF_I| (|sub_DF| |x2| |x1|) 2))
                                  |err| |bound| |crits| |bdry| $))
                           (GO #15#)))
                         (#14# (LETT |y2| (QCDR |y2New|)))))))
                 (#14#
                  (SEQ (LETT |y2| |y2Approx|)
                       (LETT |f|
                             (|ACPLOT;SFPolyToUPoly|
                              (SPADCALL |pSF| |y| |y2| (QREFELT $ 140)) $))
                       (LETT |x2New|
                             (|ACPLOT;newtonApprox| |f| |x2Approx| |err|
                              |bound| $))
                       (EXIT
                        (COND
                         ((QEQCAR |x2New| 1)
                          (PROGN
                           (LETT #6#
                                 (|ACPLOT;computeNextPt| |pSF| |dpdxSF|
                                  |dpdySF| |x| |y| |p0| |p1| |corners|
                                  (|abs_DF|
                                   (|div_DF_I| (|sub_DF| |y2| |y1|) 2))
                                  |err| |bound| |crits| |bdry| $))
                           (GO #15#)))
                         (#14# (LETT |x2| (QCDR |x2New|))))))))
                (LETT |pt| (|ACPLOT;makePt| |x2| |y2| $))
                (EXIT
                 (COND
                  ((EQUAL |lookingFor| (QREFELT $ 16))
                   (CONS |pt| |lookingFor|))
                  ((EQUAL |lookingFor| (QREFELT $ 17))
                   (SEQ (LETT |bdryPt| (|ACPLOT;findPtOnList| |pt| |bdry| $))
                        (EXIT
                         (COND
                          ((QEQCAR |bdryPt| 1)
                           (|error| "couldn't find boundary point"))
                          (#14# (CONS (QCDR |bdryPt|) (QREFELT $ 17)))))))
                  (#14#
                   (SEQ (LETT |critPt| (|ACPLOT;findPtOnList| |pt| |crits| $))
                        (EXIT
                         (COND ((QEQCAR |critPt| 1) (CONS |pt| (QREFELT $ 16)))
                               (#14#
                                (CONS (QCDR |critPt|) (QREFELT $ 18)))))))))))
          #15# (EXIT #6#)))) 

(SDEFUN |ACPLOT;newtonApprox|
        ((|f| (|SparseUnivariatePolynomial| (|DoubleFloat|)))
         (|a0| #1=(|DoubleFloat|)) (|err| (|DoubleFloat|))
         (|bound| (|PositiveInteger|)) ($ (|Union| (|DoubleFloat|) "failed")))
        (SPROG
         ((|i| (|PositiveInteger|)) (|newApprox| (|DoubleFloat|))
          (|oldApprox| #1#) (#2=#:G1188 NIL)
          (|Df| (|SparseUnivariatePolynomial| (|DoubleFloat|))))
         (SEQ
          (EXIT
           (SEQ (LETT |Df| (SPADCALL |f| (QREFELT $ 141)))
                (LETT |oldApprox| |a0|)
                (LETT |newApprox|
                      (|sub_DF| |a0|
                                (|div_DF| (SPADCALL |f| |a0| (QREFELT $ 98))
                                          (SPADCALL |Df| |a0|
                                                    (QREFELT $ 98)))))
                (LETT |i| 1)
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL (|abs_DF| (|sub_DF| |newApprox| |oldApprox|))
                                  |err| (QREFELT $ 111)))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQL |i| |bound|)
                         (PROGN (LETT #2# (CONS 1 "failed")) (GO #3=#:G1187)))
                        ('T
                         (SEQ (LETT |oldApprox| |newApprox|)
                              (LETT |newApprox|
                                    (|sub_DF| |oldApprox|
                                              (|div_DF|
                                               (SPADCALL |f| |oldApprox|
                                                         (QREFELT $ 98))
                                               (SPADCALL |Df| |oldApprox|
                                                         (QREFELT $ 98)))))
                              (EXIT (LETT |i| (+ |i| 1))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |newApprox|))))
          #3# (EXIT #2#)))) 

(PUT '|ACPLOT;listBranches;$L;41| '|SPADreplace|
     '(XLAM (|acplot|) (QVELT |acplot| 10))) 

(SDEFUN |ACPLOT;listBranches;$L;41|
        ((|acplot| ($)) ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (QVELT |acplot| 10)) 

(SDEFUN |ACPLOT;coerce;$Of;42| ((|acplot| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|ff| (|OutputForm|)) (|f| (|List| (|OutputForm|)))
          (|ll| (|List| (|OutputForm|))) (#1=#:G1199 NIL) (|p| NIL)
          (#2=#:G1198 NIL) (#3=#:G1197 NIL) (|branch| NIL)
          (|l| (|List| #4=(|OutputForm|))) (|les| #5=(|OutputForm|))
          (|com| #5#) (|zip| #5#) (|yHi| #4#) (|yLo| (|OutputForm|))
          (|xHi| (|OutputForm|)) (|xLo| (|OutputForm|)) (|yy| (|OutputForm|))
          (|xx| (|OutputForm|)) (|pp| (|OutputForm|)))
         (SEQ (LETT |pp| (SPADCALL (QVELT |acplot| 0) (QREFELT $ 144)))
              (LETT |xx| (SPADCALL (QVELT |acplot| 1) (QREFELT $ 145)))
              (LETT |yy| (SPADCALL (QVELT |acplot| 2) (QREFELT $ 145)))
              (LETT |xLo| (SPADCALL (QVELT |acplot| 3) (QREFELT $ 146)))
              (LETT |xHi| (SPADCALL (QVELT |acplot| 4) (QREFELT $ 146)))
              (LETT |yLo| (SPADCALL (QVELT |acplot| 5) (QREFELT $ 146)))
              (LETT |yHi| (SPADCALL (QVELT |acplot| 6) (QREFELT $ 146)))
              (LETT |zip| (SPADCALL " = 0" (QREFELT $ 148)))
              (LETT |com| (SPADCALL ",   " (QREFELT $ 148)))
              (LETT |les| (SPADCALL " <= " (QREFELT $ 148)))
              (LETT |l|
                    (LIST |pp| |zip| |com| |xLo| |les| |xx| |les| |xHi| |com|
                          |yLo| |les| |yy| |les| |yHi|))
              (LETT |f| NIL)
              (SEQ (LETT |branch| NIL) (LETT #3# (QVELT |acplot| 10)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |branch| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |ll|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |p| NIL) (LETT #1# |branch|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |p| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |p| (QREFELT $ 149))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#)))))
                    (EXIT
                     (LETT |f| (CONS (SPADCALL |ll| (QREFELT $ 151)) |f|))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |ff|
                    (SPADCALL (SPADCALL |l| (QREFELT $ 152))
                              (SPADCALL |f| (QREFELT $ 151)) (QREFELT $ 153)))
              (EXIT
               (SPADCALL (SPADCALL "ACPLOT" (QREFELT $ 148)) |ff|
                         (QREFELT $ 153)))))) 

(DECLAIM (NOTINLINE |PlaneAlgebraicCurvePlot;|)) 

(DEFUN |PlaneAlgebraicCurvePlot| ()
  (SPROG NIL
         (PROG (#1=#:G1201)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PlaneAlgebraicCurvePlot|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PlaneAlgebraicCurvePlot|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|PlaneAlgebraicCurvePlot;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|PlaneAlgebraicCurvePlot|)))))))))) 

(DEFUN |PlaneAlgebraicCurvePlot;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PlaneAlgebraicCurvePlot|))
          (LETT $ (GETREFV 155))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PlaneAlgebraicCurvePlot| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |poly| (|Polynomial| (|Integer|)))
                              (|:| |xVar| (|Symbol|)) (|:| |yVar| (|Symbol|))
                              (|:| |minXVal| (|Fraction| (|Integer|)))
                              (|:| |maxXVal| (|Fraction| (|Integer|)))
                              (|:| |minYVal| (|Fraction| (|Integer|)))
                              (|:| |maxYVal| (|Fraction| (|Integer|)))
                              (|:| |bdryPts|
                                   (|Record|
                                    (|:| |left|
                                         (|List| (|Point| (|DoubleFloat|))))
                                    (|:| |right|
                                         (|List| (|Point| (|DoubleFloat|))))
                                    (|:| |bottom|
                                         (|List| (|Point| (|DoubleFloat|))))
                                    (|:| |top|
                                         (|List| (|Point| (|DoubleFloat|))))))
                              (|:| |hTanPts|
                                   (|List| (|Point| (|DoubleFloat|))))
                              (|:| |vTanPts|
                                   (|List| (|Point| (|DoubleFloat|))))
                              (|:| |branches|
                                   (|List|
                                    (|List| (|Point| (|DoubleFloat|)))))))
          (QSETREFV $ 12 (SPADCALL 1 -6 10 (QREFELT $ 11)))
          (QSETREFV $ 15 (SPADCALL 1 -3 10 (QREFELT $ 14)))
          (QSETREFV $ 16 "nothing in particular")
          (QSETREFV $ 17 "boundary point")
          (QSETREFV $ 18 "critical point")
          (QSETREFV $ 19 "bottom")
          (QSETREFV $ 20 "top")
          $))) 

(MAKEPROP '|PlaneAlgebraicCurvePlot| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Float|) (0 . |One|) (|Integer|)
              (|PositiveInteger|) (4 . |float|) 'EPSILON (|DoubleFloat|)
              (11 . |float|) 'PLOTERR 'NADA 'BDRY 'CRIT 'BOTTOM 'TOP
              (18 . |Zero|) (22 . |convert|) (|List| 13) (|Point| 13)
              (27 . |point|) (|PointPackage| 13) (32 . |yCoord|)
              (37 . |xCoord|) (|Boolean|) (|Polynomial| 13) (42 . |zero?|)
              (|SparseUnivariatePolynomial| 13) (47 . |Zero|)
              (51 . |leadingCoefficient|) (|NonNegativeInteger|)
              (56 . |totalDegree|) (61 . |monomial|) (67 . |reductum|) (72 . +)
              (|Polynomial| 44) (78 . |zero?|)
              (|SparseUnivariatePolynomial| 44) (83 . |Zero|) (|Fraction| 9)
              (87 . |leadingCoefficient|) (92 . |totalDegree|)
              (97 . |monomial|) (103 . |reductum|) (108 . +) (114 . |coerce|)
              (|Mapping| 13 9) (|Polynomial| 9) (|PolynomialFunctions2| 9 13)
              (119 . |map|) (125 . |coerce|) (|Mapping| 44 9)
              (|PolynomialFunctions2| 9 44) (130 . |map|) (136 . |coerce|)
              (141 . |coerce|) (146 . |convert|) (|Symbol|) (151 . |eval|)
              (|List| 7) (|RealSolvePackage|) (158 . |solve|) (164 . <)
              (170 . <=) (176 . |second|) (181 . =) (187 . +) (193 . |max|)
              (199 . |min|) (205 . /) (211 . +) (|Segment| 44) (217 . |low|)
              (222 . |high|) (227 . <=) (|List| 62) (233 . |variables|)
              (238 . |member?|) (244 . |totalDegree|) (249 . |degree|)
              |ACPLOT;makeSketch;P2S2S$;27| (255 . |solve|)
              (261 . |coefficient|) (268 . |ground|) (273 . <=) (|Segment| 13)
              (279 . |segment|) (285 . >=) (|Factored| 52) (291 . |coerce|)
              (296 . |numberOfFactors|) (301 . |differentiate|) (307 . -)
              (312 . |elt|) (318 . /) (|List| 64) (|List| 52)
              (324 . |realSolve|) (331 . <) (|Mapping| 29 13 13) (337 . |sort|)
              (343 . |elt|) (349 . |Zero|) (353 . =) (359 . |last|)
              (364 . |remove|) (370 . >) (|Mapping| 13 13) (|Plot|)
              (376 . |plot|) (|List| 118) (382 . |listBranches|)
              (|Mapping| 24 24) (|List| 24) (387 . |map|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 120) (|:| |factor| 52) (|:| |exponent| 35))
              (|List| 121) (393 . |factorList|) (398 . |append|) (404 . /)
              (410 . -) (416 . *) (422 . -) (427 . |append|)
              |ACPLOT;refine;$Df$;34| (433 . |second|) (438 . |third|)
              (443 . |eval|) (450 . |ground|) (455 . |member?|)
              (461 . |remove|) (467 . |second|) (472 . =) (478 . =)
              (484 . |eval|) (491 . |differentiate|)
              |ACPLOT;listBranches;$L;41| (|OutputForm|) (496 . |coerce|)
              (501 . |coerce|) (506 . |coerce|) (|String|) (511 . |message|)
              (516 . |coerce|) (|List| $) (521 . |vconcat|) (526 . |hconcat|)
              (531 . |vconcat|) |ACPLOT;coerce;$Of;42|)
           '#(|yRange| 537 |xRange| 542 |refine| 547 |makeSketch| 553
              |listBranches| 562 |coerce| 567)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(NIL NIL)
                       (CONS
                        '#((|PlottablePlaneCurveCategory|) (|CoercibleTo| 143))
                        (|makeByteWordVec2| 154
                                            '(0 7 0 8 3 7 0 9 9 10 11 3 13 0 9
                                              9 10 14 0 7 0 21 1 7 13 0 22 1 24
                                              0 23 25 1 26 13 24 27 1 26 13 24
                                              28 1 30 29 0 31 0 32 0 33 1 30 13
                                              0 34 1 30 35 0 36 2 32 0 13 35 37
                                              1 30 0 0 38 2 32 0 0 0 39 1 40 29
                                              0 41 0 42 0 43 1 40 44 0 45 1 40
                                              35 0 46 2 42 0 44 35 47 1 40 0 0
                                              48 2 42 0 0 0 49 1 13 0 9 50 2 53
                                              30 51 52 54 1 44 0 9 55 2 57 40
                                              56 52 58 1 13 0 44 59 1 7 0 44 60
                                              1 7 0 13 61 3 40 0 0 62 44 63 2
                                              65 64 40 7 66 2 7 29 0 0 67 2 7
                                              29 0 0 68 1 64 7 0 69 2 7 29 0 0
                                              70 2 7 0 0 0 71 2 7 0 0 0 72 2 7
                                              0 0 0 73 2 44 0 0 0 74 2 44 0 0 0
                                              75 1 76 44 0 77 1 76 44 0 78 2 44
                                              29 0 0 79 1 52 80 0 81 2 80 29 62
                                              0 82 1 52 35 0 83 2 52 35 0 62 84
                                              2 65 64 52 7 86 3 52 0 0 62 35 87
                                              1 52 9 0 88 2 13 29 0 0 89 2 90 0
                                              13 13 91 2 13 29 0 0 92 1 93 0 52
                                              94 1 93 35 0 95 2 52 0 0 62 96 1
                                              52 0 0 97 2 32 13 0 13 98 2 13 0
                                              0 0 99 3 65 100 101 80 7 102 2 62
                                              29 0 0 103 2 23 0 104 0 105 2 42
                                              44 0 44 106 0 44 0 107 2 44 29 0
                                              0 108 1 23 13 0 109 2 23 0 13 0
                                              110 2 13 29 0 0 111 2 113 0 112
                                              90 114 1 113 115 0 116 2 118 0
                                              117 0 119 1 93 122 0 123 2 100 0
                                              0 0 124 2 44 0 9 9 125 2 44 0 0 0
                                              126 2 44 0 0 44 127 1 44 0 0 128
                                              2 118 0 0 0 129 1 115 118 0 131 1
                                              115 118 0 132 3 30 0 0 80 23 133
                                              1 30 13 0 134 2 118 29 24 0 135 2
                                              118 0 24 0 136 1 118 24 0 137 2
                                              24 29 0 0 138 2 118 29 0 0 139 3
                                              30 0 0 62 13 140 1 32 0 0 141 1
                                              52 143 0 144 1 62 143 0 145 1 44
                                              143 0 146 1 143 0 147 148 1 24
                                              143 0 149 1 143 0 150 151 1 143 0
                                              150 152 2 143 0 0 0 153 1 0 90 0
                                              1 1 0 90 0 1 2 0 0 0 13 130 5 0 0
                                              52 62 62 76 76 85 1 0 115 0 142 1
                                              0 143 0 154)))))
           '|lookupComplete|)) 

(MAKEPROP '|PlaneAlgebraicCurvePlot| 'NILADIC T) 
