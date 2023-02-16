
(SDEFUN |PLOT;Fnan?| ((|x| (|DoubleFloat|)) ($ (|Boolean|)))
        (SPADCALL |x| |x| (QREFELT $ 17))) 

(SDEFUN |PLOT;Pnan?| ((|x| (|Point| (|DoubleFloat|))) ($ (|Boolean|)))
        (SPADCALL (CONS (|function| |PLOT;Fnan?|) $) |x| (QREFELT $ 20))) 

(SDEFUN |PLOT;listBranches;$L;3|
        ((|plot| ($)) ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|outList| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|newl| (|List| (|Point| (|DoubleFloat|)))) (#1=#:G743 NIL) (|p| NIL)
          (#2=#:G742 NIL) (|curve| NIL))
         (SEQ (LETT |outList| NIL)
              (SEQ (LETT |curve| NIL) (LETT #2# (QVELT |plot| 4)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |curve| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |newl| NIL)
                        (SEQ (LETT |p| NIL) (LETT #1# (QVELT |curve| 3)) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((|PLOT;Pnan?| |p| $)
                                 (COND
                                  ((NULL (NULL |newl|))
                                   (SEQ
                                    (LETT |outList|
                                          (CONS (LETT |newl| (NREVERSE |newl|))
                                                |outList|))
                                    (EXIT (LETT |newl| NIL))))))
                                ('T (LETT |newl| (CONS |p| |newl|))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL (NULL |newl|))
                           (LETT |outList|
                                 (CONS (LETT |newl| (NREVERSE |newl|))
                                       |outList|))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |outList|)))) 

(SDEFUN |PLOT;checkRange|
        ((|r| (|Segment| (|DoubleFloat|))) ($ (|Segment| (|DoubleFloat|))))
        (COND
         ((SPADCALL (SPADCALL |r| (QREFELT $ 24)) (SPADCALL |r| (QREFELT $ 25))
                    (QREFELT $ 26))
          (|error| "ranges cannot be negative"))
         ('T |r|))) 

(SDEFUN |PLOT;intersect|
        ((|s| (|Segment| (|DoubleFloat|))) (|t| (|Segment| (|DoubleFloat|)))
         ($ (|Segment| (|DoubleFloat|))))
        (|PLOT;checkRange|
         (SPADCALL
          (|max_DF| (SPADCALL |s| (QREFELT $ 24))
                    (SPADCALL |t| (QREFELT $ 24)))
          (|min_DF| (SPADCALL |s| (QREFELT $ 25))
                    (SPADCALL |t| (QREFELT $ 25)))
          (QREFELT $ 27))
         $)) 

(SDEFUN |PLOT;union|
        ((|s| (|Segment| (|DoubleFloat|))) (|t| (|Segment| (|DoubleFloat|)))
         ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL
         (|min_DF| (SPADCALL |s| (QREFELT $ 24)) (SPADCALL |t| (QREFELT $ 24)))
         (|max_DF| (SPADCALL |s| (QREFELT $ 25)) (SPADCALL |t| (QREFELT $ 25)))
         (QREFELT $ 27))) 

(SDEFUN |PLOT;join|
        ((|l|
          (|List|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
            (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
         (|i| (|Integer|)) ($ (|Segment| (|DoubleFloat|))))
        (SPROG
         ((|u| (|Segment| (|DoubleFloat|))) (#1=#:G755 NIL) (|r| NIL)
          (|rr|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
            (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
         (SEQ (LETT |rr| (|SPADfirst| |l|))
              (LETT |u|
                    (COND ((EQL |i| 0) (|SPADfirst| (QVELT |rr| 1)))
                          ((EQL |i| 1)
                           (SPADCALL (QVELT |rr| 1) (QREFELT $ 29)))
                          ('T (SPADCALL (QVELT |rr| 1) (QREFELT $ 30)))))
              (SEQ (LETT |r| NIL) (LETT #1# (CDR |l|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL |i| 0)
                       (LETT |u|
                             (|PLOT;union| |u| (|SPADfirst| (QVELT |r| 1)) $)))
                      ((EQL |i| 1)
                       (LETT |u|
                             (|PLOT;union| |u|
                              (SPADCALL (QVELT |r| 1) (QREFELT $ 29)) $)))
                      ('T
                       (LETT |u|
                             (|PLOT;union| |u|
                              (SPADCALL (QVELT |r| 1) (QREFELT $ 30)) $))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |u|)))) 

(SDEFUN |PLOT;parametricRange| ((|r| ($)) ($ (|Segment| (|DoubleFloat|))))
        (|SPADfirst| (QVELT |r| 2))) 

(SDEFUN |PLOT;minPoints;I;9| (($ (|Integer|))) (QREFELT $ 8)) 

(SDEFUN |PLOT;setMinPoints;2I;10| ((|n| (|Integer|)) ($ (|Integer|)))
        (SEQ (COND ((< |n| 3) (|error| "three points minimum required")))
             (COND ((< (QREFELT $ 9) |n|) (SETELT $ 9 |n|)))
             (EXIT (SETELT $ 8 |n|)))) 

(SDEFUN |PLOT;maxPoints;I;11| (($ (|Integer|))) (QREFELT $ 9)) 

(SDEFUN |PLOT;setMaxPoints;2I;12| ((|n| (|Integer|)) ($ (|Integer|)))
        (SEQ (COND ((< |n| 3) (|error| "three points minimum required")))
             (COND ((> (QREFELT $ 8) |n|) (SETELT $ 8 |n|)))
             (EXIT (SETELT $ 9 |n|)))) 

(SDEFUN |PLOT;screenResolution;I;13| (($ (|Integer|))) (QREFELT $ 11)) 

(SDEFUN |PLOT;setScreenResolution;2I;14| ((|n| (|Integer|)) ($ (|Integer|)))
        (SEQ (COND ((< |n| 2) (|error| "buy a new terminal")))
             (EXIT (SETELT $ 11 |n|)))) 

(SDEFUN |PLOT;adaptive?;B;15| (($ (|Boolean|))) (QREFELT $ 7)) 

(SDEFUN |PLOT;setAdaptive;2B;16| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SETELT $ 7 |b|)) 

(PUT '|PLOT;parametric?;$B;17| '|SPADreplace| '(XLAM (|p|) (QVELT |p| 0))) 

(SDEFUN |PLOT;parametric?;$B;17| ((|p| ($)) ($ (|Boolean|))) (QVELT |p| 0)) 

(SDEFUN |PLOT;numFunEvals;I;18| (($ (|Integer|))) (QREFELT $ 10)) 

(SDEFUN |PLOT;debug;2B;19| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SETELT $ 15 |b|)) 

(SDEFUN |PLOT;xRange;$S;20| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL (QVELT |plot| 2) (QREFELT $ 29))) 

(SDEFUN |PLOT;yRange;$S;21| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL (QVELT |plot| 2) (QREFELT $ 30))) 

(SDEFUN |PLOT;tRange;$S;22| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (|SPADfirst| (QVELT |plot| 2))) 

(SDEFUN |PLOT;select|
        ((|l| (|List| (|Point| (|DoubleFloat|))))
         (|f| (|Mapping| #1=(|DoubleFloat|) (|Point| (|DoubleFloat|))))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (SPROG ((|m| #1#) (|n| #1#) (#2=#:G780 NIL) (|p| NIL))
               (SEQ (LETT |m| (SPADCALL (|SPADfirst| |l|) |f|))
                    (COND ((|PLOT;Fnan?| |m| $) (LETT |m| 0.0)))
                    (SEQ (LETT |p| NIL) (LETT #2# (CDR |l|)) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |n| |m|)
                              (LETT |m| (SPADCALL |m| (SPADCALL |p| |f|) |g|))
                              (EXIT
                               (COND ((|PLOT;Fnan?| |m| $) (LETT |m| |n|)))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |m|)))) 

(SDEFUN |PLOT;rangeRefine|
        ((|curve|
          (|Record|
           (|:| |source| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| (|List| (|DoubleFloat|)))
           (|:| |points| (|List| (|Point| (|DoubleFloat|))))))
         (|nRange| (|Segment| (|DoubleFloat|)))
         ($
          (|Record|
           (|:| |source|
                #1=(|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| #2=(|List| (|DoubleFloat|)))
           (|:| |points| #3=(|List| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|yRange| #4=(|Segment| (|DoubleFloat|))) (|xRange| #4#) (|p| #3#)
          (|t| #2#) (#5=#:G822 NIL) (|i| NIL) (|d| #6=(|DoubleFloat|))
          (|n| (|Integer|)) (|q| (|List| (|Point| (|DoubleFloat|))))
          (|c| (|List| (|DoubleFloat|))) (|s| #6#) (#7=#:G821 NIL) (|f| #1#)
          (|h| (|DoubleFloat|)) (|l| (|DoubleFloat|)))
         (SEQ
          (EXIT
           (SEQ (|PLOT;checkRange| |nRange| $)
                (LETT |l| (SPADCALL |nRange| (QREFELT $ 24)))
                (LETT |h| (SPADCALL |nRange| (QREFELT $ 25)))
                (LETT |t| (QVELT |curve| 2)) (LETT |p| (QVELT |curve| 3))
                (LETT |f| (QVELT |curve| 0))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |t|) NIL)
                              ('T (|less_DF| (|SPADfirst| |t|) |l|))))
                       (GO G191)))
                     (SEQ (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|)))) NIL
                     (GO G190) G191 (EXIT NIL))
                (LETT |c| NIL) (LETT |q| NIL)
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |t|) NIL)
                              ('T
                               (SPADCALL (|SPADfirst| |t|) |h|
                                         (QREFELT $ 46)))))
                       (GO G191)))
                     (SEQ (LETT |c| (CONS (|SPADfirst| |t|) |c|))
                          (LETT |q| (CONS (|SPADfirst| |p|) |q|))
                          (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((NULL |c|)
                  (PROGN
                   (LETT #7# (|PLOT;basicPlot| |f| |nRange| $))
                   (GO #8=#:G820))))
                (COND
                 ((|less_DF| (|SPADfirst| |c|) |h|)
                  (SEQ (LETT |c| (CONS |h| |c|))
                       (LETT |q| (CONS (SPADCALL |h| |f|) |q|))
                       (EXIT (SETELT $ 10 (+ (QREFELT $ 10) 1))))))
                (LETT |t| (LETT |c| (NREVERSE |c|)))
                (LETT |p| (LETT |q| (NREVERSE |q|)))
                (LETT |s|
                      (|div_DF| (|sub_DF| |h| |l|)
                                (|sub_DF|
                                 (FLOAT (SPADCALL (QREFELT $ 32))
                                        MOST-POSITIVE-DOUBLE-FLOAT)
                                 1.0)))
                (COND
                 ((SPADCALL (|SPADfirst| |t|) |l| (QREFELT $ 17))
                  (SEQ (LETT |t| (LETT |c| (CONS |l| |c|)))
                       (LETT |p| (LETT |q| (CONS (SPADCALL |l| |f|) |p|)))
                       (EXIT (SETELT $ 10 (+ (QREFELT $ 10) 1))))))
                (SEQ G190 (COND ((NULL (NULL (NULL (CDR |t|)))) (GO G191)))
                     (SEQ
                      (LETT |n|
                            (TRUNCATE
                             (|div_DF|
                              (|sub_DF| (SPADCALL |t| (QREFELT $ 48))
                                        (|SPADfirst| |t|))
                              |s|)))
                      (LETT |d|
                            (|div_DF|
                             (|sub_DF| (SPADCALL |t| (QREFELT $ 48))
                                       (|SPADfirst| |t|))
                             (FLOAT (+ |n| 1) MOST-POSITIVE-DOUBLE-FLOAT)))
                      (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                           (COND ((|greater_SI| |i| #5#) (GO G191)))
                           (SEQ
                            (SPADCALL |t| '|rest|
                                      (CONS (|add_DF| (|SPADfirst| |t|) |d|)
                                            (CDR |t|))
                                      (QREFELT $ 50))
                            (SPADCALL |p| '|rest|
                                      (CONS
                                       (SPADCALL (SPADCALL |t| (QREFELT $ 48))
                                                 |f|)
                                       (CDR |p|))
                                      (QREFELT $ 52))
                            (SETELT $ 10 (+ (QREFELT $ 10) 1))
                            (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |xRange|
                      (SPADCALL (|PLOT;select| |q| (ELT $ 54) (ELT $ 55) $)
                                (|PLOT;select| |q| (ELT $ 54) (ELT $ 56) $)
                                (QREFELT $ 27)))
                (LETT |yRange|
                      (SPADCALL (|PLOT;select| |q| (ELT $ 57) (ELT $ 55) $)
                                (|PLOT;select| |q| (ELT $ 57) (ELT $ 56) $)
                                (QREFELT $ 27)))
                (EXIT (VECTOR |f| (LIST |nRange| |xRange| |yRange|) |c| |q|))))
          #8# (EXIT #7#)))) 

(SDEFUN |PLOT;adaptivePlot|
        ((|curve|
          (|Record|
           (|:| |source| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| (|List| (|DoubleFloat|)))
           (|:| |points| (|List| (|Point| (|DoubleFloat|))))))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|))) (|pixelfraction| (|Integer|))
         ($
          (|Record|
           (|:| |source|
                #1=(|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| #2=(|List| (|DoubleFloat|)))
           (|:| |points| #3=(|List| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|p| #3#) (|t| #2#) (|tj| #4=(|DoubleFloat|)) (|n| (|Integer|))
          (#5=#:G864 NIL) (|sp| #6=(|List| (|Point| (|DoubleFloat|))))
          (|st| #7=(|List| (|DoubleFloat|))) (|dp| (|DoubleFloat|))
          (|s2| #8=(|DoubleFloat|)) (|s1| #8#) (|b2| #4#) (|a2| #4#) (|b1| #4#)
          (|a1| #4#) (|y2| #9=(|DoubleFloat|)) (|x2| #10=(|DoubleFloat|))
          (|y1| #9#) (|x1| #10#) (|y0| #9#) (|x0| #10#) (|t2| (|DoubleFloat|))
          (|t1| (|DoubleFloat|)) (|t0| (|DoubleFloat|)) (|headerp| #6#)
          (|headert| #7#) (|tLimit| #4#) (|maxLength| #4#) (|minLength| #4#)
          (|f| #1#) (|tDiff| #11=(|DoubleFloat|)) (|h| (|DoubleFloat|))
          (|l| (|DoubleFloat|)) (|yDiff| #11#) (|xDiff| #11#))
         (SEQ
          (LETT |xDiff|
                (|sub_DF| (SPADCALL |xRange| (QREFELT $ 25))
                          (SPADCALL |xRange| (QREFELT $ 24))))
          (LETT |yDiff|
                (|sub_DF| (SPADCALL |yRange| (QREFELT $ 25))
                          (SPADCALL |yRange| (QREFELT $ 24))))
          (COND
           ((OR (|eql_DF| |xDiff| 0.0) (|eql_DF| |yDiff| 0.0)) (EXIT |curve|)))
          (LETT |l| (SPADCALL |tRange| (QREFELT $ 24)))
          (LETT |h| (SPADCALL |tRange| (QREFELT $ 25)))
          (LETT |tDiff| (|sub_DF| |h| |l|))
          (EXIT
           (COND ((|eql_DF| |tDiff| 0.0) |curve|)
                 (#12='T
                  (SEQ (LETT |t| (QVELT |curve| 2))
                       (EXIT
                        (COND ((< (LENGTH |t|) 3) |curve|)
                              (#12#
                               (SEQ (LETT |p| (QVELT |curve| 3))
                                    (LETT |f| (QVELT |curve| 0))
                                    (LETT |minLength|
                                          (|div_DF|
                                           (FLOAT 4 MOST-POSITIVE-DOUBLE-FLOAT)
                                           (FLOAT 500
                                                  MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |maxLength|
                                          (|div_DF| 1.0
                                                    (FLOAT 6
                                                           MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |tLimit|
                                          (|div_DF| |tDiff|
                                                    (FLOAT
                                                     (* |pixelfraction| 500)
                                                     MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (SEQ G190
                                         (COND
                                          ((NULL
                                            (COND ((NULL |t|) NIL)
                                                  ('T
                                                   (|less_DF| (|SPADfirst| |t|)
                                                              |l|))))
                                           (GO G191)))
                                         (SEQ (LETT |t| (CDR |t|))
                                              (EXIT (LETT |p| (CDR |p|))))
                                         NIL (GO G190) G191 (EXIT NIL))
                                    (EXIT
                                     (COND ((< (LENGTH |t|) 3) |curve|)
                                           (#12#
                                            (SEQ (LETT |headert| |t|)
                                                 (LETT |headerp| |p|)
                                                 (LETT |st| |headert|)
                                                 (LETT |sp| |headerp|)
                                                 (LETT |n| 0)
                                                 (SEQ
                                                  (EXIT
                                                   (SEQ G190
                                                        (COND
                                                         ((NULL
                                                           (NULL
                                                            (NULL
                                                             (CDR
                                                              (CDR |st|)))))
                                                          (GO G191)))
                                                        (SEQ
                                                         (LETT |t0|
                                                               (|SPADfirst|
                                                                |st|))
                                                         (LETT |t1|
                                                               (SPADCALL |st|
                                                                         (QREFELT
                                                                          $
                                                                          48)))
                                                         (LETT |t2|
                                                               (SPADCALL |st|
                                                                         (QREFELT
                                                                          $
                                                                          58)))
                                                         (COND
                                                          ((SPADCALL |t2| |h|
                                                                     (QREFELT $
                                                                              26))
                                                           (PROGN
                                                            (LETT #5#
                                                                  |$NoValue|)
                                                            (GO #13=#:G844))))
                                                         (EXIT
                                                          (COND
                                                           ((|less_DF|
                                                             (|sub_DF| |t2|
                                                                       |t0|)
                                                             |tLimit|)
                                                            (SEQ
                                                             (LETT |st|
                                                                   (CDR |st|))
                                                             (EXIT
                                                              (LETT |sp|
                                                                    (CDR
                                                                     |sp|)))))
                                                           ('T
                                                            (SEQ
                                                             (LETT |x0|
                                                                   (SPADCALL
                                                                    (|SPADfirst|
                                                                     |sp|)
                                                                    (QREFELT $
                                                                             54)))
                                                             (LETT |y0|
                                                                   (SPADCALL
                                                                    (|SPADfirst|
                                                                     |sp|)
                                                                    (QREFELT $
                                                                             57)))
                                                             (LETT |x1|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |sp|
                                                                     (QREFELT $
                                                                              59))
                                                                    (QREFELT $
                                                                             54)))
                                                             (LETT |y1|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |sp|
                                                                     (QREFELT $
                                                                              59))
                                                                    (QREFELT $
                                                                             57)))
                                                             (LETT |x2|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |sp|
                                                                     (QREFELT $
                                                                              60))
                                                                    (QREFELT $
                                                                             54)))
                                                             (LETT |y2|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |sp|
                                                                     (QREFELT $
                                                                              60))
                                                                    (QREFELT $
                                                                             57)))
                                                             (LETT |a1|
                                                                   (|div_DF|
                                                                    (|sub_DF|
                                                                     |x1| |x0|)
                                                                    |xDiff|))
                                                             (LETT |b1|
                                                                   (|div_DF|
                                                                    (|sub_DF|
                                                                     |y1| |y0|)
                                                                    |yDiff|))
                                                             (LETT |a2|
                                                                   (|div_DF|
                                                                    (|sub_DF|
                                                                     |x2| |x1|)
                                                                    |xDiff|))
                                                             (LETT |b2|
                                                                   (|div_DF|
                                                                    (|sub_DF|
                                                                     |y2| |y1|)
                                                                    |yDiff|))
                                                             (LETT |s1|
                                                                   (SPADCALL
                                                                    (|add_DF|
                                                                     (SPADCALL
                                                                      |a1| 2
                                                                      (QREFELT
                                                                       $ 62))
                                                                     (SPADCALL
                                                                      |b1| 2
                                                                      (QREFELT
                                                                       $ 62)))
                                                                    (QREFELT $
                                                                             63)))
                                                             (LETT |s2|
                                                                   (SPADCALL
                                                                    (|add_DF|
                                                                     (SPADCALL
                                                                      |a2| 2
                                                                      (QREFELT
                                                                       $ 62))
                                                                     (SPADCALL
                                                                      |b2| 2
                                                                      (QREFELT
                                                                       $ 62)))
                                                                    (QREFELT $
                                                                             63)))
                                                             (LETT |dp|
                                                                   (|add_DF|
                                                                    (|mul_DF|
                                                                     |a1| |a2|)
                                                                    (|mul_DF|
                                                                     |b1|
                                                                     |b2|)))
                                                             (COND
                                                              ((|less_DF| |s1|
                                                                          |maxLength|)
                                                               (COND
                                                                ((|less_DF|
                                                                  |s2|
                                                                  |maxLength|)
                                                                 (COND
                                                                  ((OR
                                                                    (|eql_DF|
                                                                     |s1| 0.0)
                                                                    (|eql_DF|
                                                                     |s2| 0.0))
                                                                   (EXIT
                                                                    (SEQ
                                                                     (LETT |st|
                                                                           (CDR
                                                                            |st|))
                                                                     (EXIT
                                                                      (LETT
                                                                       |sp|
                                                                       (CDR
                                                                        |sp|))))))
                                                                  ((|less_DF|
                                                                    |s1|
                                                                    |minLength|)
                                                                   (COND
                                                                    ((OR
                                                                      (|less_DF|
                                                                       |s2|
                                                                       |minLength|)
                                                                      (SPADCALL
                                                                       (|div_DF|
                                                                        (|div_DF|
                                                                         |dp|
                                                                         |s1|)
                                                                        |s2|)
                                                                       (QREFELT
                                                                        $ 14)
                                                                       (QREFELT
                                                                        $ 26)))
                                                                     (EXIT
                                                                      (SEQ
                                                                       (LETT
                                                                        |st|
                                                                        (CDR
                                                                         |st|))
                                                                       (EXIT
                                                                        (LETT
                                                                         |sp|
                                                                         (CDR
                                                                          |sp|))))))))
                                                                  ('T
                                                                   (COND
                                                                    ((SPADCALL
                                                                      (|div_DF|
                                                                       (|div_DF|
                                                                        |dp|
                                                                        |s1|)
                                                                       |s2|)
                                                                      (QREFELT
                                                                       $ 14)
                                                                      (QREFELT
                                                                       $ 26))
                                                                     (EXIT
                                                                      (SEQ
                                                                       (LETT
                                                                        |st|
                                                                        (CDR
                                                                         |st|))
                                                                       (EXIT
                                                                        (LETT
                                                                         |sp|
                                                                         (CDR
                                                                          |sp|)))))))))))))
                                                             (COND
                                                              ((> |n|
                                                                  (QREFELT $
                                                                           9))
                                                               (PROGN
                                                                (LETT #5#
                                                                      |$NoValue|)
                                                                (GO #13#)))
                                                              ('T
                                                               (LETT |n|
                                                                     (+ |n|
                                                                        1))))
                                                             (LETT |t| |st|)
                                                             (LETT |p| |sp|)
                                                             (LETT |tj|
                                                                   (|div_DF|
                                                                    (|add_DF|
                                                                     |t0| |t1|)
                                                                    (FLOAT 2
                                                                           MOST-POSITIVE-DOUBLE-FLOAT)))
                                                             (|qset_rest| |t|
                                                                          (CONS
                                                                           |tj|
                                                                           (CDR
                                                                            |t|)))
                                                             (|qset_rest| |p|
                                                                          (CONS
                                                                           (SPADCALL
                                                                            |tj|
                                                                            |f|)
                                                                           (CDR
                                                                            |p|)))
                                                             (LETT |t|
                                                                   (CDR |t|))
                                                             (LETT |p|
                                                                   (CDR |p|))
                                                             (LETT |t|
                                                                   (CDR |t|))
                                                             (LETT |p|
                                                                   (CDR |p|))
                                                             (LETT |tj|
                                                                   (|div_DF|
                                                                    (|add_DF|
                                                                     |t1| |t2|)
                                                                    (FLOAT 2
                                                                           MOST-POSITIVE-DOUBLE-FLOAT)))
                                                             (|qset_rest| |t|
                                                                          (CONS
                                                                           |tj|
                                                                           (CDR
                                                                            |t|)))
                                                             (EXIT
                                                              (|qset_rest| |p|
                                                                           (CONS
                                                                            (SPADCALL
                                                                             |tj|
                                                                             |f|)
                                                                            (CDR
                                                                             |p|)))))))))
                                                        NIL (GO G190) G191
                                                        (EXIT NIL)))
                                                  #13# (EXIT #5#))
                                                 (EXIT
                                                  (COND
                                                   ((> |n| 0)
                                                    (SEQ
                                                     (SETELT $ 10
                                                             (+ (QREFELT $ 10)
                                                                |n|))
                                                     (LETT |t|
                                                           (QVELT |curve| 2))
                                                     (LETT |p|
                                                           (QVELT |curve| 3))
                                                     (LETT |xRange|
                                                           (SPADCALL
                                                            (|PLOT;select| |p|
                                                             (ELT $ 54)
                                                             (ELT $ 55) $)
                                                            (|PLOT;select| |p|
                                                             (ELT $ 54)
                                                             (ELT $ 56) $)
                                                            (QREFELT $ 27)))
                                                     (LETT |yRange|
                                                           (SPADCALL
                                                            (|PLOT;select| |p|
                                                             (ELT $ 57)
                                                             (ELT $ 55) $)
                                                            (|PLOT;select| |p|
                                                             (ELT $ 57)
                                                             (ELT $ 56) $)
                                                            (QREFELT $ 27)))
                                                     (EXIT
                                                      (VECTOR (QVELT |curve| 0)
                                                              (LIST |tRange|
                                                                    |xRange|
                                                                    |yRange|)
                                                              |t| |p|))))
                                                   (#12#
                                                    |curve|)))))))))))))))))) 

(SDEFUN |PLOT;basicPlot|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         ($
          (|Record|
           (|:| |source| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| (|List| (|DoubleFloat|)))
           (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|yRange| #1=(|Segment| (|DoubleFloat|))) (|xRange| #1#)
          (|p| (|List| (|Point| (|DoubleFloat|))))
          (|t| (|List| (|DoubleFloat|))) (|l| (|DoubleFloat|)) (#2=#:G884 NIL)
          (|i| NIL) (|s| (|DoubleFloat|)) (|h| (|DoubleFloat|)))
         (SEQ (|PLOT;checkRange| |tRange| $)
              (LETT |l| (SPADCALL |tRange| (QREFELT $ 24)))
              (LETT |h| (SPADCALL |tRange| (QREFELT $ 25)))
              (LETT |t| (SPADCALL |l| (QREFELT $ 64)))
              (LETT |p| (SPADCALL (SPADCALL |l| |f|) (QREFELT $ 65)))
              (LETT |s|
                    (|div_DF| (|sub_DF| |h| |l|)
                              (FLOAT (- (SPADCALL (QREFELT $ 32)) 1)
                                     MOST-POSITIVE-DOUBLE-FLOAT)))
              (SEQ (LETT |i| 2) (LETT #2# (- (SPADCALL (QREFELT $ 32)) 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |l| (|add_DF| |l| |s|)) (LETT |t| (CONS |l| |t|))
                        (EXIT (LETT |p| (CONS (SPADCALL |l| |f|) |p|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |t| (NREVERSE (CONS |h| |t|)))
              (LETT |p| (NREVERSE (CONS (SPADCALL |h| |f|) |p|)))
              (LETT |xRange|
                    (SPADCALL (|PLOT;select| |p| (ELT $ 54) (ELT $ 55) $)
                              (|PLOT;select| |p| (ELT $ 54) (ELT $ 56) $)
                              (QREFELT $ 27)))
              (LETT |yRange|
                    (SPADCALL (|PLOT;select| |p| (ELT $ 57) (ELT $ 55) $)
                              (|PLOT;select| |p| (ELT $ 57) (ELT $ 56) $)
                              (QREFELT $ 27)))
              (EXIT (VECTOR |f| (LIST |tRange| |xRange| |yRange|) |t| |p|))))) 

(SDEFUN |PLOT;zoom;$S$;27|
        ((|p| ($)) (|xRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (VECTOR (QVELT |p| 0)
                (LIST |xRange| (SPADCALL (QVELT |p| 1) (QREFELT $ 30)))
                (QVELT |p| 2) (QVELT |p| 3) (QVELT |p| 4))) 

(SDEFUN |PLOT;zoom;$2S$;28|
        ((|p| ($)) (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (VECTOR (QVELT |p| 0) (LIST |xRange| |yRange|) (QVELT |p| 2)
                (QVELT |p| 3) (QVELT |p| 4))) 

(SDEFUN |PLOT;basicRefine|
        ((|curve|
          (|Record|
           (|:| |source| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| (|List| (|DoubleFloat|)))
           (|:| |points| (|List| (|Point| (|DoubleFloat|))))))
         (|nRange| (|Segment| (|DoubleFloat|)))
         ($
          (|Record|
           (|:| |source|
                #1=(|Mapping| #2=(|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| #3=(|List| (|DoubleFloat|)))
           (|:| |points| #4=(|List| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|yRange| #5=(|Segment| (|DoubleFloat|))) (|xRange| #5#) (|p| #4#)
          (|t| #3#) (|pm| #2#) (|tm| (|DoubleFloat|)) (|f| #1#)
          (|h| (|DoubleFloat|)) (|l| (|DoubleFloat|))
          (|tRange| (|Segment| (|DoubleFloat|))))
         (SEQ (LETT |tRange| (|SPADfirst| (QVELT |curve| 1)))
              (LETT |curve|
                    (VECTOR (QVELT |curve| 0) (QVELT |curve| 1)
                            (QVELT |curve| 2) (QVELT |curve| 3)))
              (LETT |t|
                    (QSETVELT |curve| 2
                              (SPADCALL (QVELT |curve| 2) (QREFELT $ 68))))
              (LETT |p|
                    (QSETVELT |curve| 3
                              (SPADCALL (QVELT |curve| 3) (QREFELT $ 69))))
              (LETT |l| (SPADCALL |nRange| (QREFELT $ 24)))
              (LETT |h| (SPADCALL |nRange| (QREFELT $ 25)))
              (LETT |f| (QVELT |curve| 0))
              (SEQ G190
                   (COND
                    ((NULL
                      (COND ((NULL (CDR |t|)) NIL)
                            ('T (|less_DF| (|SPADfirst| |t|) |h|))))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((|less_DF| (SPADCALL |t| (QREFELT $ 48)) |l|)
                       (SEQ (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|)))))
                      ('T
                       (SEQ
                        (LETT |tm|
                              (|div_DF|
                               (|add_DF| (|SPADfirst| |t|)
                                         (SPADCALL |t| (QREFELT $ 48)))
                               (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT)))
                        (LETT |pm| (SPADCALL |tm| |f|))
                        (SETELT $ 10 (+ (QREFELT $ 10) 1))
                        (SPADCALL |t| '|rest| (CONS |tm| (CDR |t|))
                                  (QREFELT $ 50))
                        (LETT |t| (CDR (CDR |t|)))
                        (SPADCALL |p| '|rest| (CONS |pm| (CDR |p|))
                                  (QREFELT $ 52))
                        (EXIT (LETT |p| (CDR (CDR |p|)))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |t| (QVELT |curve| 2)) (LETT |p| (QVELT |curve| 3))
              (LETT |xRange|
                    (SPADCALL (|PLOT;select| |p| (ELT $ 54) (ELT $ 55) $)
                              (|PLOT;select| |p| (ELT $ 54) (ELT $ 56) $)
                              (QREFELT $ 27)))
              (LETT |yRange|
                    (SPADCALL (|PLOT;select| |p| (ELT $ 57) (ELT $ 55) $)
                              (|PLOT;select| |p| (ELT $ 57) (ELT $ 56) $)
                              (QREFELT $ 27)))
              (EXIT
               (VECTOR (QVELT |curve| 0) (LIST |tRange| |xRange| |yRange|) |t|
                       |p|))))) 

(SDEFUN |PLOT;refine;2$;30| ((|p| ($)) ($ ($)))
        (SPADCALL |p| (|PLOT;parametricRange| |p| $) (QREFELT $ 70))) 

(SDEFUN |PLOT;refine;$S$;31|
        ((|p| ($)) (|nRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|yRange| #1=(|Segment| (|DoubleFloat|))) (|xRange| #1#)
          (|curves|
           (|List|
            (|Record|
             (|:| |source|
                  (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
             (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
             (|:| |knots| (|List| (|DoubleFloat|)))
             (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
          (#2=#:G925 NIL) (|c| NIL) (#3=#:G924 NIL)
          (|tlimit| (|PositiveInteger|)) (#4=#:G923 NIL) (#5=#:G922 NIL)
          (|tRange| (|Segment| (|DoubleFloat|))))
         (SEQ (SETELT $ 10 0) (LETT |tRange| (|PLOT;parametricRange| |p| $))
              (LETT |nRange| (|PLOT;intersect| |tRange| |nRange| $))
              (LETT |curves|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |c| NIL) (LETT #4# (QVELT |p| 4)) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |c| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS (|PLOT;basicRefine| |c| |nRange| $)
                                        #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |xRange| (|PLOT;join| |curves| 1 $))
              (LETT |yRange| (|PLOT;join| |curves| 2 $))
              (COND
               ((SPADCALL (QREFELT $ 38))
                (SEQ
                 (LETT |tlimit|
                       (COND ((SPADCALL |p| (QREFELT $ 40)) 8) ('T 1)))
                 (LETT |curves|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |c| NIL) (LETT #2# |curves|) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |c| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS
                                      (|PLOT;adaptivePlot| |c| |nRange|
                                       |xRange| |yRange| |tlimit| $)
                                      #3#))))
                             (LETT #2# (CDR #2#)) (GO G190) G191
                             (EXIT (NREVERSE #3#)))))
                 (LETT |xRange| (|PLOT;join| |curves| 1 $))
                 (EXIT (LETT |yRange| (|PLOT;join| |curves| 2 $))))))
              (EXIT
               (VECTOR (QVELT |p| 0) (QVELT |p| 1)
                       (LIST |tRange| |xRange| |yRange|) (QVELT |p| 3)
                       |curves|))))) 

(SDEFUN |PLOT;plot;$S$;32|
        ((|p| ($)) (|tRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|yRange| #1=(|Segment| (|DoubleFloat|))) (|xRange| #1#)
          (|curves|
           (|List|
            (|Record|
             (|:| |source|
                  (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
             (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
             (|:| |knots| (|List| (|DoubleFloat|)))
             (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
          (#2=#:G938 NIL) (|c| NIL) (#3=#:G937 NIL)
          (|tlimit| (|PositiveInteger|)) (#4=#:G936 NIL) (#5=#:G935 NIL))
         (SEQ (SETELT $ 10 0)
              (LETT |curves|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |c| NIL) (LETT #4# (QVELT |p| 4)) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |c| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS (|PLOT;rangeRefine| |c| |tRange| $)
                                        #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |xRange| (|PLOT;join| |curves| 1 $))
              (LETT |yRange| (|PLOT;join| |curves| 2 $))
              (COND
               ((SPADCALL (QREFELT $ 38))
                (SEQ
                 (LETT |tlimit|
                       (COND ((SPADCALL |p| (QREFELT $ 40)) 8) ('T 1)))
                 (LETT |curves|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |c| NIL) (LETT #2# |curves|) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |c| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS
                                      (|PLOT;adaptivePlot| |c| |tRange|
                                       |xRange| |yRange| |tlimit| $)
                                      #3#))))
                             (LETT #2# (CDR #2#)) (GO G190) G191
                             (EXIT (NREVERSE #3#)))))
                 (LETT |xRange| (|PLOT;join| |curves| 1 $))
                 (EXIT (LETT |yRange| (|PLOT;join| |curves| 2 $))))))
              (EXIT
               (VECTOR (QVELT |p| 0) (LIST |xRange| |yRange|)
                       (LIST |tRange| |xRange| |yRange|) (QVELT |p| 3)
                       |curves|))))) 

(SDEFUN |PLOT;pt|
        ((|xx| (|DoubleFloat|)) (|yy| #1=(|DoubleFloat|))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |xx| |yy|)) (QREFELT $ 73)))) 

(SDEFUN |PLOT;myTrap|
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
                                              (QREFELT $ 26))
                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                   ((|less_DF| |r| MOST-NEGATIVE-DOUBLE-FLOAT)
                                    MOST-NEGATIVE-DOUBLE-FLOAT)
                                   (#1# |r|)))))))))) 

(SDEFUN |PLOT;plot;MS$;35|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|r| #1=(|List| (|Segment| (|DoubleFloat|))))
          (|p|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| #1#) (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
         (SEQ
          (LETT |p|
                (|PLOT;basicPlot| (CONS #'|PLOT;plot;MS$;35!0| (VECTOR $ |f|))
                 |xRange| $))
          (LETT |r| (QVELT |p| 1)) (SETELT $ 10 (SPADCALL (QREFELT $ 32)))
          (COND
           ((SPADCALL (QREFELT $ 38))
            (SEQ
             (LETT |p|
                   (|PLOT;adaptivePlot| |p| (|SPADfirst| |r|)
                    (SPADCALL |r| (QREFELT $ 29)) (SPADCALL |r| (QREFELT $ 30))
                    1 $))
             (EXIT (LETT |r| (QVELT |p| 1))))))
          (EXIT (VECTOR NIL (CDR |r|) |r| NIL (LIST |p|)))))) 

(SDEFUN |PLOT;plot;MS$;35!0| ((|u1| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PLOT;pt| |u1| (|PLOT;myTrap| |f| |u1| $) $))))) 

(SDEFUN |PLOT;plot;M2S$;36|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG ((|p| ($)))
               (SEQ (LETT |p| (SPADCALL |f| |xRange| (QREFELT $ 75)))
                    (QSETVELT |p| 1
                              (LIST |xRange| (|PLOT;checkRange| |yRange| $)))
                    (EXIT |p|)))) 

(SDEFUN |PLOT;plot;2MS$;37|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|r| #1=(|List| (|Segment| (|DoubleFloat|))))
          (|p|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| #1#) (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
         (SEQ
          (LETT |p|
                (|PLOT;basicPlot|
                 (CONS #'|PLOT;plot;2MS$;37!0| (VECTOR |g| $ |f|)) |tRange| $))
          (LETT |r| (QVELT |p| 1)) (SETELT $ 10 (SPADCALL (QREFELT $ 32)))
          (COND
           ((SPADCALL (QREFELT $ 38))
            (SEQ
             (LETT |p|
                   (|PLOT;adaptivePlot| |p| (|SPADfirst| |r|)
                    (SPADCALL |r| (QREFELT $ 29)) (SPADCALL |r| (QREFELT $ 30))
                    8 $))
             (EXIT (LETT |r| (QVELT |p| 1))))))
          (EXIT (VECTOR 'T (CDR |r|) |r| NIL (LIST |p|)))))) 

(SDEFUN |PLOT;plot;2MS$;37!0| ((|z1| NIL) ($$ NIL))
        (PROG (|f| $ |g|)
          (LETT |f| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |g| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|PLOT;pt| (|PLOT;myTrap| |f| |z1| $) (|PLOT;myTrap| |g| |z1| $)
             $))))) 

(SDEFUN |PLOT;plot;2M3S$;38|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG ((|p| ($)))
               (SEQ (LETT |p| (SPADCALL |f| |g| |tRange| (QREFELT $ 77)))
                    (QSETVELT |p| 1
                              (LIST (|PLOT;checkRange| |xRange| $)
                                    (|PLOT;checkRange| |yRange| $)))
                    (EXIT |p|)))) 

(SDEFUN |PLOT;pointPlot;MS$;39|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|r| #1=(|List| (|Segment| (|DoubleFloat|))))
          (|p|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| #1#) (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
         (SEQ (LETT |p| (|PLOT;basicPlot| |f| |tRange| $))
              (LETT |r| (QVELT |p| 1)) (SETELT $ 10 (SPADCALL (QREFELT $ 32)))
              (COND
               ((SPADCALL (QREFELT $ 38))
                (SEQ
                 (LETT |p|
                       (|PLOT;adaptivePlot| |p| (|SPADfirst| |r|)
                        (SPADCALL |r| (QREFELT $ 29))
                        (SPADCALL |r| (QREFELT $ 30)) 8 $))
                 (EXIT (LETT |r| (QVELT |p| 1))))))
              (EXIT (VECTOR 'T (CDR |r|) |r| NIL (LIST |p|)))))) 

(SDEFUN |PLOT;pointPlot;M3S$;40|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG ((|p| ($)))
               (SEQ (LETT |p| (SPADCALL |f| |tRange| (QREFELT $ 80)))
                    (QSETVELT |p| 1
                              (LIST (|PLOT;checkRange| |xRange| $)
                                    (|PLOT;checkRange| |yRange| $)))
                    (EXIT |p|)))) 

(SDEFUN |PLOT;plot;LS$;41|
        ((|l| (|List| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|xRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|yRange| (|Segment| (|DoubleFloat|)))
          (|t|
           (|List|
            (|Record|
             (|:| |source|
                  (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
             (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
             (|:| |knots| (|List| (|DoubleFloat|)))
             (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
          (#1=#:G995 NIL) (|f| NIL) (#2=#:G996 NIL) (|p| NIL) (#3=#:G994 NIL)
          (#4=#:G993 NIL) (#5=#:G992 NIL))
         (SEQ (COND ((NULL |l|) (|error| "empty list of functions")))
              (LETT |t|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |f| NIL) (LETT #4# |l|) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |f| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS
                                   (|PLOT;basicPlot|
                                    (CONS #'|PLOT;plot;LS$;41!0|
                                          (VECTOR $ |f|))
                                    |xRange| $)
                                   #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |yRange| (|PLOT;join| |t| 2 $))
              (SETELT $ 10 (* (LENGTH |l|) (SPADCALL (QREFELT $ 32))))
              (COND
               ((SPADCALL (QREFELT $ 38))
                (SEQ
                 (LETT |t|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |p| NIL) (LETT #2# |t|) (LETT |f| NIL)
                             (LETT #1# |l|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS
                                      (|PLOT;adaptivePlot| |p| |xRange|
                                       |xRange| |yRange| 1 $)
                                      #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT (LETT |yRange| (|PLOT;join| |t| 2 $))))))
              (EXIT
               (VECTOR NIL (LIST |xRange| |yRange|)
                       (LIST |xRange| |xRange| |yRange|) NIL |t|))))) 

(SDEFUN |PLOT;plot;LS$;41!0| ((|z1| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PLOT;pt| |z1| (|PLOT;myTrap| |f| |z1| $) $))))) 

(SDEFUN |PLOT;plot;L2S$;42|
        ((|l| (|List| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG ((|p| ($)))
               (SEQ (LETT |p| (SPADCALL |l| |xRange| (QREFELT $ 83)))
                    (QSETVELT |p| 1
                              (LIST |xRange| (|PLOT;checkRange| |yRange| $)))
                    (EXIT |p|)))) 

(SDEFUN |PLOT;plotPolar;MS$;43|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|thetaRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|PLOT;plotPolar;MS$;43!0| (VECTOR $ |f|))
                         (CONS #'|PLOT;plotPolar;MS$;43!1| (VECTOR $ |f|))
                         |thetaRange| (QREFELT $ 77)))) 

(SDEFUN |PLOT;plotPolar;MS$;43!1| ((|v1| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |v1| |f|) (SPADCALL |v1| (QREFELT $ 87))
                      (QREFELT $ 86)))))) 

(SDEFUN |PLOT;plotPolar;MS$;43!0| ((|u1| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |u1| |f|) (SPADCALL |u1| (QREFELT $ 85))
                      (QREFELT $ 86)))))) 

(SDEFUN |PLOT;plotPolar;M$;44|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))) ($ ($)))
        (SPADCALL |f|
                  (SPADCALL 0.0
                            (SPADCALL 2 (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT)
                                      (QREFELT $ 89))
                            (QREFELT $ 90))
                  (QREFELT $ 88))) 

(SDEFUN |PLOT;coerce;$Of;45| ((|r| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|f| (|List| (|OutputForm|))) (|l| (|List| #1=(|OutputForm|)))
          (#2=#:G1018 NIL) (|p| NIL) (#3=#:G1017 NIL) (|h| (|OutputForm|))
          (|yRange| #1#) (|xRange| (|OutputForm|)) (#4=#:G1016 NIL)
          (|curve| NIL) (|tRange| (|OutputForm|))
          (|plotSymbol| #5=(|OutputForm|)) (|tSymbol| #5#) (|ySymbol| #5#)
          (|xSymbol| #5#) (|spaces| #5#))
         (SEQ (LETT |spaces| (SPADCALL "   " (QREFELT $ 94)))
              (LETT |xSymbol| (SPADCALL "x = " (QREFELT $ 94)))
              (LETT |ySymbol| (SPADCALL "y = " (QREFELT $ 94)))
              (LETT |tSymbol| (SPADCALL "t = " (QREFELT $ 94)))
              (LETT |plotSymbol| (SPADCALL "PLOT" (QREFELT $ 94)))
              (LETT |tRange|
                    (SPADCALL (|PLOT;parametricRange| |r| $) (QREFELT $ 95)))
              (LETT |f| NIL)
              (SEQ (LETT |curve| NIL) (LETT #4# (QVELT |r| 4)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |curve| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |xRange|
                          (SPADCALL (SPADCALL (QVELT |curve| 1) (QREFELT $ 29))
                                    (QREFELT $ 95)))
                    (LETT |yRange|
                          (SPADCALL (SPADCALL (QVELT |curve| 1) (QREFELT $ 30))
                                    (QREFELT $ 95)))
                    (LETT |l|
                          (LIST |xSymbol| |xRange| |spaces| |ySymbol|
                                |yRange|))
                    (COND
                     ((SPADCALL |r| (QREFELT $ 40))
                      (LETT |l|
                            (SPADCALL (LIST |tSymbol| |tRange| |spaces|) |l|
                                      (QREFELT $ 97)))))
                    (LETT |h| (SPADCALL |l| (QREFELT $ 99)))
                    (LETT |l|
                          (PROGN
                           (LETT #3# NIL)
                           (SEQ (LETT |p| NIL) (LETT #2# (QVELT |curve| 3))
                                G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |p| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #3#
                                        (CONS (SPADCALL |p| (QREFELT $ 100))
                                              #3#))))
                                (LETT #2# (CDR #2#)) (GO G190) G191
                                (EXIT (NREVERSE #3#)))))
                    (EXIT
                     (LETT |f|
                           (CONS (SPADCALL (CONS |h| |l|) (QREFELT $ 101))
                                 |f|))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |plotSymbol| (NREVERSE |f|) (QREFELT $ 102)))))) 

(DECLAIM (NOTINLINE |Plot;|)) 

(DEFUN |Plot| ()
  (SPROG NIL
         (PROG (#1=#:G1020)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Plot|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Plot|
                             (LIST (CONS NIL (CONS 1 (|Plot;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Plot|)))))))))) 

(DEFUN |Plot;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Plot|))
          (LETT $ (GETREFV 104))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Plot| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |parametric| (|Boolean|))
                              (|:| |display|
                                   (|List| (|Segment| (|DoubleFloat|))))
                              (|:| |bounds|
                                   (|List| (|Segment| (|DoubleFloat|))))
                              (|:| |axisLabels| (|List| (|String|)))
                              (|:| |functions|
                                   (|List|
                                    (|Record|
                                     (|:| |source|
                                          (|Mapping| (|Point| (|DoubleFloat|))
                                                     (|DoubleFloat|)))
                                     (|:| |ranges|
                                          (|List| (|Segment| (|DoubleFloat|))))
                                     (|:| |knots| (|List| (|DoubleFloat|)))
                                     (|:| |points|
                                          (|List|
                                           (|Point| (|DoubleFloat|)))))))))
          (QSETREFV $ 7 'T)
          (QSETREFV $ 8 49)
          (QSETREFV $ 9 1000)
          (QSETREFV $ 10 0)
          (QSETREFV $ 11 500)
          (QSETREFV $ 14
                    (|cos_DF|
                     (SPADCALL (FLOAT 4 MOST-POSITIVE-DOUBLE-FLOAT)
                               (QREFELT $ 13))))
          (QSETREFV $ 15 NIL)
          $))) 

(MAKEPROP '|Plot| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| 'ADAPTIVE 'MINPOINTS 'MAXPOINTS
              'NUMFUNEVALS 'SCREENRES (|DoubleFloat|) (0 . |inv|) 'ANGLEBOUND
              'DEBUG (|Boolean|) (5 . ~=) (|Mapping| 16 12) (|Point| 12)
              (11 . |any?|) (|List| 51) |PLOT;listBranches;$L;3| (|Segment| 12)
              (17 . |low|) (22 . |high|) (27 . >) (33 . SEGMENT) (|List| 23)
              (39 . |second|) (44 . |third|) (|Integer|) |PLOT;minPoints;I;9|
              |PLOT;setMinPoints;2I;10| |PLOT;maxPoints;I;11|
              |PLOT;setMaxPoints;2I;12| |PLOT;screenResolution;I;13|
              |PLOT;setScreenResolution;2I;14| |PLOT;adaptive?;B;15|
              |PLOT;setAdaptive;2B;16| |PLOT;parametric?;$B;17|
              |PLOT;numFunEvals;I;18| |PLOT;debug;2B;19| |PLOT;xRange;$S;20|
              |PLOT;yRange;$S;21| |PLOT;tRange;$S;22| (49 . <=) (|List| 12)
              (55 . |second|) '"rest" (60 . |setelt!|) (|List| 19)
              (67 . |setelt!|) (|PointPackage| 12) (74 . |xCoord|) (79 . |min|)
              (85 . |max|) (91 . |yCoord|) (96 . |third|) (101 . |second|)
              (106 . |third|) (|PositiveInteger|) (111 . ^) (117 . |sqrt|)
              (122 . |list|) (127 . |list|) |PLOT;zoom;$S$;27|
              |PLOT;zoom;$2S$;28| (132 . |copy|) (137 . |copy|)
              |PLOT;refine;$S$;31| |PLOT;refine;2$;30| |PLOT;plot;$S$;32|
              (142 . |point|) (|Mapping| 12 12) |PLOT;plot;MS$;35|
              |PLOT;plot;M2S$;36| |PLOT;plot;2MS$;37| |PLOT;plot;2M3S$;38|
              (|Mapping| 19 12) |PLOT;pointPlot;MS$;39|
              |PLOT;pointPlot;M3S$;40| (|List| 74) |PLOT;plot;LS$;41|
              |PLOT;plot;L2S$;42| (147 . |cos|) (152 . *) (158 . |sin|)
              |PLOT;plotPolar;MS$;43| (163 . *) (169 . |segment|)
              |PLOT;plotPolar;M$;44| (|String|) (|OutputForm|)
              (175 . |message|) (180 . |coerce|) (|List| 93) (185 . |concat!|)
              (|List| $) (191 . |hconcat|) (196 . |coerce|) (201 . |vconcat|)
              (206 . |prefix|) |PLOT;coerce;$Of;45|)
           '#(|zoom| 212 |yRange| 225 |xRange| 230 |tRange| 235
              |setScreenResolution| 240 |setMinPoints| 245 |setMaxPoints| 250
              |setAdaptive| 255 |screenResolution| 260 |refine| 264 |pointPlot|
              275 |plotPolar| 289 |plot| 300 |parametric?| 348 |numFunEvals|
              353 |minPoints| 357 |maxPoints| 361 |listBranches| 365 |debug|
              370 |coerce| 375 |adaptive?| 380)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(NIL NIL)
                       (CONS
                        '#((|PlottablePlaneCurveCategory|) (|CoercibleTo| 93))
                        (|makeByteWordVec2| 103
                                            '(1 12 0 0 13 2 12 16 0 0 17 2 19
                                              16 18 0 20 1 23 12 0 24 1 23 12 0
                                              25 2 12 16 0 0 26 2 23 0 12 12 27
                                              1 28 23 0 29 1 28 23 0 30 2 12 16
                                              0 0 46 1 47 12 0 48 3 47 0 0 49 0
                                              50 3 51 0 0 49 0 52 1 53 12 19 54
                                              2 12 0 0 0 55 2 12 0 0 0 56 1 53
                                              12 19 57 1 47 12 0 58 1 51 19 0
                                              59 1 51 19 0 60 2 12 0 0 61 62 1
                                              12 0 0 63 1 47 0 12 64 1 51 0 19
                                              65 1 47 0 0 68 1 51 0 0 69 1 19 0
                                              47 73 1 12 0 0 85 2 12 0 0 0 86 1
                                              12 0 0 87 2 12 0 61 0 89 2 23 0
                                              12 12 90 1 93 0 92 94 1 23 93 0
                                              95 2 96 0 0 0 97 1 93 0 98 99 1
                                              19 93 0 100 1 93 0 98 101 2 93 0
                                              0 98 102 2 0 0 0 23 66 3 0 0 0 23
                                              23 67 1 0 23 0 44 1 0 23 0 43 1 0
                                              23 0 45 1 0 31 31 37 1 0 31 31 33
                                              1 0 31 31 35 1 0 16 16 39 0 0 31
                                              36 2 0 0 0 23 70 1 0 0 0 71 2 0 0
                                              79 23 80 4 0 0 79 23 23 23 81 2 0
                                              0 74 23 88 1 0 0 74 91 2 0 0 0 23
                                              72 3 0 0 74 74 23 77 5 0 0 74 74
                                              23 23 23 78 2 0 0 82 23 83 3 0 0
                                              82 23 23 84 2 0 0 74 23 75 3 0 0
                                              74 23 23 76 1 0 16 0 40 0 0 31 41
                                              0 0 31 32 0 0 31 34 1 0 21 0 22 1
                                              0 16 16 42 1 0 93 0 103 0 0 16
                                              38)))))
           '|lookupComplete|)) 

(MAKEPROP '|Plot| 'NILADIC T) 
