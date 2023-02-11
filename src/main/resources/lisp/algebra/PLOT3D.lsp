
(SDEFUN |PLOT3D;point|
        ((|xx| (|DoubleFloat|)) (|yy| (|DoubleFloat|)) (|zz| (|DoubleFloat|))
         (|col| #1=(|DoubleFloat|)) ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |xx| |yy| |zz| |col|))
                         (QREFELT $ 18)))) 

(SDEFUN |PLOT3D;fourth|
        ((|list| (|List| (|Segment| (|DoubleFloat|))))
         ($ (|Segment| (|DoubleFloat|))))
        (|SPADfirst| (CDR (CDR (CDR |list|))))) 

(SDEFUN |PLOT3D;checkRange|
        ((|r| (|Segment| (|DoubleFloat|))) ($ (|Segment| (|DoubleFloat|))))
        (COND
         ((SPADCALL (SPADCALL |r| (QREFELT $ 20)) (SPADCALL |r| (QREFELT $ 21))
                    (QREFELT $ 23))
          (|error| "ranges cannot be negative"))
         ('T |r|))) 

(SDEFUN |PLOT3D;intersect|
        ((|s| (|Segment| (|DoubleFloat|))) (|t| (|Segment| (|DoubleFloat|)))
         ($ (|Segment| (|DoubleFloat|))))
        (|PLOT3D;checkRange|
         (SPADCALL
          (|max_DF| (SPADCALL |s| (QREFELT $ 20))
                    (SPADCALL |t| (QREFELT $ 20)))
          (|min_DF| (SPADCALL |s| (QREFELT $ 21))
                    (SPADCALL |t| (QREFELT $ 21)))
          (QREFELT $ 24))
         $)) 

(SDEFUN |PLOT3D;union|
        ((|s| (|Segment| (|DoubleFloat|))) (|t| (|Segment| (|DoubleFloat|)))
         ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL
         (|min_DF| (SPADCALL |s| (QREFELT $ 20)) (SPADCALL |t| (QREFELT $ 20)))
         (|max_DF| (SPADCALL |s| (QREFELT $ 21)) (SPADCALL |t| (QREFELT $ 21)))
         (QREFELT $ 24))) 

(SDEFUN |PLOT3D;join|
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
         ((|u| (|Segment| (|DoubleFloat|))) (#1=#:G733 NIL) (|r| NIL)
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
                           (SPADCALL (QVELT |rr| 1) (QREFELT $ 26)))
                          ((EQL |i| 2)
                           (SPADCALL (QVELT |rr| 1) (QREFELT $ 27)))
                          ('T (|PLOT3D;fourth| (QVELT |rr| 1) $))))
              (SEQ (LETT |r| NIL) (LETT #1# (CDR |l|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL |i| 0)
                       (LETT |u|
                             (|PLOT3D;union| |u| (|SPADfirst| (QVELT |r| 1))
                              $)))
                      ((EQL |i| 1)
                       (LETT |u|
                             (|PLOT3D;union| |u|
                              (SPADCALL (QVELT |r| 1) (QREFELT $ 26)) $)))
                      ((EQL |i| 2)
                       (LETT |u|
                             (|PLOT3D;union| |u|
                              (SPADCALL (QVELT |r| 1) (QREFELT $ 27)) $)))
                      ('T
                       (LETT |u|
                             (|PLOT3D;union| |u|
                              (|PLOT3D;fourth| (QVELT |r| 1) $) $))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |u|)))) 

(SDEFUN |PLOT3D;parametricRange| ((|r| ($)) ($ (|Segment| (|DoubleFloat|))))
        (|SPADfirst| (QVELT |r| 1))) 

(SDEFUN |PLOT3D;minPoints3D;I;8| (($ (|Integer|))) (QREFELT $ 8)) 

(SDEFUN |PLOT3D;setMinPoints3D;2I;9| ((|n| (|Integer|)) ($ (|Integer|)))
        (SEQ (COND ((< |n| 3) (|error| "three points minimum required")))
             (COND ((< (QREFELT $ 9) |n|) (SETELT $ 9 |n|)))
             (EXIT (SETELT $ 8 |n|)))) 

(SDEFUN |PLOT3D;maxPoints3D;I;10| (($ (|Integer|))) (QREFELT $ 9)) 

(SDEFUN |PLOT3D;setMaxPoints3D;2I;11| ((|n| (|Integer|)) ($ (|Integer|)))
        (SEQ (COND ((< |n| 3) (|error| "three points minimum required")))
             (COND ((> (QREFELT $ 8) |n|) (SETELT $ 8 |n|)))
             (EXIT (SETELT $ 9 |n|)))) 

(SDEFUN |PLOT3D;screenResolution3D;I;12| (($ (|Integer|))) (QREFELT $ 11)) 

(SDEFUN |PLOT3D;setScreenResolution3D;2I;13|
        ((|n| (|Integer|)) ($ (|Integer|)))
        (SEQ (COND ((< |n| 2) (|error| "buy a new terminal")))
             (EXIT (SETELT $ 11 |n|)))) 

(SDEFUN |PLOT3D;adaptive3D?;B;14| (($ (|Boolean|))) (QREFELT $ 7)) 

(SDEFUN |PLOT3D;setAdaptive3D;2B;15| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SETELT $ 7 |b|)) 

(SDEFUN |PLOT3D;numFunEvals3D;I;16| (($ (|Integer|))) (QREFELT $ 10)) 

(SDEFUN |PLOT3D;debug3D;2B;17| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SETELT $ 15 |b|)) 

(SDEFUN |PLOT3D;xRange;$S;18| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL (QVELT |plot| 1) (QREFELT $ 26))) 

(SDEFUN |PLOT3D;yRange;$S;19| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL (QVELT |plot| 1) (QREFELT $ 27))) 

(SDEFUN |PLOT3D;zRange;$S;20| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (|PLOT3D;fourth| (QVELT |plot| 1) $)) 

(SDEFUN |PLOT3D;tRange;$S;21| ((|plot| ($)) ($ (|Segment| (|DoubleFloat|))))
        (|SPADfirst| (QVELT |plot| 1))) 

(SDEFUN |PLOT3D;tValues;$L;22|
        ((|plot| ($)) ($ (|List| (|List| (|DoubleFloat|)))))
        (SPROG
         ((|outList| (|List| (|List| (|DoubleFloat|)))) (#1=#:G757 NIL)
          (|curve| NIL))
         (SEQ (LETT |outList| NIL)
              (SEQ (LETT |curve| NIL) (LETT #1# (QVELT |plot| 4)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |curve| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT (LETT |outList| (CONS (QVELT |curve| 2) |outList|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |outList|)))) 

(SDEFUN |PLOT3D;select|
        ((|l| (|List| (|Point| (|DoubleFloat|))))
         (|f| (|Mapping| #1=(|DoubleFloat|) (|Point| (|DoubleFloat|))))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (SPROG ((|m| #1#) (|fp| #1#) (#2=#:G763 NIL) (|p| NIL))
               (SEQ (LETT |m| (SPADCALL (|SPADfirst| |l|) |f|))
                    (SEQ (LETT |p| NIL) (LETT #2# (CDR |l|)) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |fp| (SPADCALL |p| |f|))
                              (EXIT (LETT |m| (SPADCALL |m| |fp| |g|))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |m|)))) 

(SDEFUN |PLOT3D;rangeRefine|
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
         ((|zRange| #4=(|Segment| (|DoubleFloat|))) (|yRange| #4#)
          (|xRange| #4#) (|p| #3#) (|t| #2#) (|t1| (|DoubleFloat|))
          (#5=#:G811 NIL) (|i| NIL) (|d| #6=(|DoubleFloat|)) (|n| (|Integer|))
          (|q| (|List| (|Point| (|DoubleFloat|))))
          (|c| (|List| (|DoubleFloat|))) (|s| #6#) (#7=#:G810 NIL) (|f| #1#)
          (|h| (|DoubleFloat|)) (|l| (|DoubleFloat|)))
         (SEQ
          (EXIT
           (SEQ (|PLOT3D;checkRange| |nRange| $)
                (LETT |l| (SPADCALL |nRange| (QREFELT $ 20)))
                (LETT |h| (SPADCALL |nRange| (QREFELT $ 21)))
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
                                         (QREFELT $ 45)))))
                       (GO G191)))
                     (SEQ (LETT |c| (CONS (|SPADfirst| |t|) |c|))
                          (LETT |q| (CONS (|SPADfirst| |p|) |q|))
                          (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((NULL |c|)
                  (PROGN
                   (LETT #7# (|PLOT3D;basicPlot| |f| |nRange| $))
                   (GO #8=#:G809))))
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
                                 (FLOAT (QREFELT $ 8)
                                        MOST-POSITIVE-DOUBLE-FLOAT)
                                 1.0)))
                (COND
                 ((SPADCALL (|SPADfirst| |t|) |l| (QREFELT $ 46))
                  (SEQ (LETT |t| (LETT |c| (CONS |l| |c|)))
                       (LETT |p| (LETT |q| (CONS (SPADCALL |l| |f|) |p|)))
                       (EXIT (SETELT $ 10 (+ (QREFELT $ 10) 1))))))
                (SEQ G190 (COND ((NULL (NULL (NULL (CDR |t|)))) (GO G191)))
                     (SEQ
                      (LETT |n|
                            (TRUNCATE
                             (|div_DF|
                              (|sub_DF| (SPADCALL |t| (QREFELT $ 47))
                                        (|SPADfirst| |t|))
                              |s|)))
                      (LETT |d|
                            (|div_DF|
                             (|sub_DF| (SPADCALL |t| (QREFELT $ 47))
                                       (|SPADfirst| |t|))
                             (FLOAT (+ |n| 1) MOST-POSITIVE-DOUBLE-FLOAT)))
                      (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                           (COND ((|greater_SI| |i| #5#) (GO G191)))
                           (SEQ
                            (SPADCALL |t| '|rest|
                                      (CONS (|add_DF| (|SPADfirst| |t|) |d|)
                                            (CDR |t|))
                                      (QREFELT $ 49))
                            (LETT |t1| (SPADCALL |t| (QREFELT $ 47)))
                            (SPADCALL |p| '|rest|
                                      (CONS (SPADCALL |t1| |f|) (CDR |p|))
                                      (QREFELT $ 51))
                            (SETELT $ 10 (+ (QREFELT $ 10) 1))
                            (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |xRange|
                      (SPADCALL (|PLOT3D;select| |q| (ELT $ 53) (ELT $ 54) $)
                                (|PLOT3D;select| |q| (ELT $ 53) (ELT $ 55) $)
                                (QREFELT $ 24)))
                (LETT |yRange|
                      (SPADCALL (|PLOT3D;select| |q| (ELT $ 56) (ELT $ 54) $)
                                (|PLOT3D;select| |q| (ELT $ 56) (ELT $ 55) $)
                                (QREFELT $ 24)))
                (LETT |zRange|
                      (SPADCALL (|PLOT3D;select| |q| (ELT $ 57) (ELT $ 54) $)
                                (|PLOT3D;select| |q| (ELT $ 57) (ELT $ 55) $)
                                (QREFELT $ 24)))
                (EXIT
                 (VECTOR |f| (LIST |nRange| |xRange| |yRange| |zRange|) |c|
                         |q|))))
          #8# (EXIT #7#)))) 

(SDEFUN |PLOT3D;adaptivePlot|
        ((|curve|
          (|Record|
           (|:| |source| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| (|List| (|DoubleFloat|)))
           (|:| |points| (|List| (|Point| (|DoubleFloat|))))))
         (|tRg| (|Segment| (|DoubleFloat|)))
         (|xRg| (|Segment| (|DoubleFloat|)))
         (|yRg| (|Segment| (|DoubleFloat|)))
         (|zRg| (|Segment| (|DoubleFloat|))) (|pixelfraction| (|Integer|))
         (|resolution| (|Integer|))
         ($
          (|Record|
           (|:| |source|
                #1=(|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| #2=(|List| (|DoubleFloat|)))
           (|:| |points| #3=(|List| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|p| #3#) (|t| #2#) (|tj| #4=(|DoubleFloat|)) (|n| (|Integer|))
          (#5=#:G859 NIL) (|sp| #6=(|List| (|Point| (|DoubleFloat|))))
          (|st| #7=(|List| (|DoubleFloat|))) (|dp| (|DoubleFloat|))
          (|s2| #8=(|DoubleFloat|)) (|s1| #8#) (|c2| #4#) (|b2| #4#) (|a2| #4#)
          (|c1| #4#) (|b1| #4#) (|a1| #4#) (|z2| #9=(|DoubleFloat|))
          (|y2| #10=(|DoubleFloat|)) (|x2| #11=(|DoubleFloat|)) (|z1| #9#)
          (|y1| #10#) (|x1| #11#) (|z0| #9#) (|y0| #10#) (|x0| #11#)
          (|t2| (|DoubleFloat|)) (|t1| (|DoubleFloat|)) (|t0| (|DoubleFloat|))
          (|headerp| #6#) (|headert| #7#) (|tLimit| #4#) (|maxLength| #4#)
          (|minLength| #4#) (|f| #1#) (|tDiff| #12=(|DoubleFloat|))
          (|h| (|DoubleFloat|)) (|l| (|DoubleFloat|)) (|zDiff| #12#)
          (|yDiff| #12#) (|xDiff| #12#))
         (SEQ
          (LETT |xDiff|
                (|sub_DF| (SPADCALL |xRg| (QREFELT $ 21))
                          (SPADCALL |xRg| (QREFELT $ 20))))
          (LETT |yDiff|
                (|sub_DF| (SPADCALL |yRg| (QREFELT $ 21))
                          (SPADCALL |yRg| (QREFELT $ 20))))
          (LETT |zDiff|
                (|sub_DF| (SPADCALL |zRg| (QREFELT $ 21))
                          (SPADCALL |zRg| (QREFELT $ 20))))
          (COND ((|eql_DF| |xDiff| 0.0) (LETT |xDiff| 1.0)))
          (COND ((|eql_DF| |yDiff| 0.0) (LETT |yDiff| 1.0)))
          (COND ((|eql_DF| |zDiff| 0.0) (LETT |zDiff| 1.0)))
          (LETT |l| (SPADCALL |tRg| (QREFELT $ 20)))
          (LETT |h| (SPADCALL |tRg| (QREFELT $ 21)))
          (LETT |tDiff| (|sub_DF| |h| |l|))
          (EXIT
           (COND ((|eql_DF| |tDiff| 0.0) |curve|)
                 (#13='T
                  (SEQ (LETT |t| (QVELT |curve| 2))
                       (EXIT
                        (COND ((< (LENGTH |t|) 3) |curve|)
                              (#13#
                               (SEQ (LETT |p| (QVELT |curve| 3))
                                    (LETT |f| (QVELT |curve| 0))
                                    (LETT |minLength|
                                          (|div_DF|
                                           (FLOAT 4 MOST-POSITIVE-DOUBLE-FLOAT)
                                           (FLOAT |resolution|
                                                  MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |maxLength|
                                          (|div_DF| 1.0
                                                    (FLOAT 4
                                                           MOST-POSITIVE-DOUBLE-FLOAT)))
                                    (LETT |tLimit|
                                          (|div_DF| |tDiff|
                                                    (FLOAT
                                                     (* |pixelfraction|
                                                        |resolution|)
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
                                           (#13#
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
                                                                          47)))
                                                         (LETT |t2|
                                                               (SPADCALL |st|
                                                                         (QREFELT
                                                                          $
                                                                          58)))
                                                         (COND
                                                          ((SPADCALL |t2| |h|
                                                                     (QREFELT $
                                                                              23))
                                                           (PROGN
                                                            (LETT #5#
                                                                  |$NoValue|)
                                                            (GO #14=#:G833))))
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
                                                                             53)))
                                                             (LETT |y0|
                                                                   (SPADCALL
                                                                    (|SPADfirst|
                                                                     |sp|)
                                                                    (QREFELT $
                                                                             56)))
                                                             (LETT |z0|
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
                                                                             53)))
                                                             (LETT |y1|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |sp|
                                                                     (QREFELT $
                                                                              59))
                                                                    (QREFELT $
                                                                             56)))
                                                             (LETT |z1|
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
                                                                             53)))
                                                             (LETT |y2|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |sp|
                                                                     (QREFELT $
                                                                              60))
                                                                    (QREFELT $
                                                                             56)))
                                                             (LETT |z2|
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
                                                             (LETT |c1|
                                                                   (|div_DF|
                                                                    (|sub_DF|
                                                                     |z1| |z0|)
                                                                    |zDiff|))
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
                                                             (LETT |c2|
                                                                   (|div_DF|
                                                                    (|sub_DF|
                                                                     |z2| |z1|)
                                                                    |zDiff|))
                                                             (LETT |s1|
                                                                   (SPADCALL
                                                                    (|add_DF|
                                                                     (|add_DF|
                                                                      (SPADCALL
                                                                       |a1| 2
                                                                       (QREFELT
                                                                        $ 62))
                                                                      (SPADCALL
                                                                       |b1| 2
                                                                       (QREFELT
                                                                        $ 62)))
                                                                     (SPADCALL
                                                                      |c1| 2
                                                                      (QREFELT
                                                                       $ 62)))
                                                                    (QREFELT $
                                                                             63)))
                                                             (LETT |s2|
                                                                   (SPADCALL
                                                                    (|add_DF|
                                                                     (|add_DF|
                                                                      (SPADCALL
                                                                       |a2| 2
                                                                       (QREFELT
                                                                        $ 62))
                                                                      (SPADCALL
                                                                       |b2| 2
                                                                       (QREFELT
                                                                        $ 62)))
                                                                     (SPADCALL
                                                                      |c2| 2
                                                                      (QREFELT
                                                                       $ 62)))
                                                                    (QREFELT $
                                                                             63)))
                                                             (LETT |dp|
                                                                   (|add_DF|
                                                                    (|add_DF|
                                                                     (|mul_DF|
                                                                      |a1|
                                                                      |a2|)
                                                                     (|mul_DF|
                                                                      |b1|
                                                                      |b2|))
                                                                    (|mul_DF|
                                                                     |c1|
                                                                     |c2|)))
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
                                                                        $ 23)))
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
                                                                       $ 23))
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
                                                              ((EQL |n|
                                                                    (QREFELT $
                                                                             9))
                                                               (PROGN
                                                                (LETT #5#
                                                                      |$NoValue|)
                                                                (GO #14#)))
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
                                                  #14# (EXIT #5#))
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
                                                     (LETT |xRg|
                                                           (SPADCALL
                                                            (|PLOT3D;select|
                                                             |p| (ELT $ 53)
                                                             (ELT $ 54) $)
                                                            (|PLOT3D;select|
                                                             |p| (ELT $ 53)
                                                             (ELT $ 55) $)
                                                            (QREFELT $ 24)))
                                                     (LETT |yRg|
                                                           (SPADCALL
                                                            (|PLOT3D;select|
                                                             |p| (ELT $ 56)
                                                             (ELT $ 54) $)
                                                            (|PLOT3D;select|
                                                             |p| (ELT $ 56)
                                                             (ELT $ 55) $)
                                                            (QREFELT $ 24)))
                                                     (LETT |zRg|
                                                           (SPADCALL
                                                            (|PLOT3D;select|
                                                             |p| (ELT $ 57)
                                                             (ELT $ 54) $)
                                                            (|PLOT3D;select|
                                                             |p| (ELT $ 57)
                                                             (ELT $ 55) $)
                                                            (QREFELT $ 24)))
                                                     (EXIT
                                                      (VECTOR (QVELT |curve| 0)
                                                              (LIST |tRg| |xRg|
                                                                    |yRg|
                                                                    |zRg|)
                                                              |t| |p|))))
                                                   (#13#
                                                    |curve|)))))))))))))))))) 

(SDEFUN |PLOT3D;basicPlot|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         ($
          (|Record|
           (|:| |source| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
           (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
           (|:| |knots| (|List| (|DoubleFloat|)))
           (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|zRange| #1=(|Segment| (|DoubleFloat|))) (|yRange| #1#)
          (|xRange| #1#) (|p| (|List| (|Point| (|DoubleFloat|))))
          (|t| (|List| (|DoubleFloat|))) (|l| (|DoubleFloat|)) (#2=#:G885 NIL)
          (|i| NIL) (|s| (|DoubleFloat|)) (|h| (|DoubleFloat|)))
         (SEQ (|PLOT3D;checkRange| |tRange| $)
              (LETT |l| (SPADCALL |tRange| (QREFELT $ 20)))
              (LETT |h| (SPADCALL |tRange| (QREFELT $ 21)))
              (LETT |t| (SPADCALL |l| (QREFELT $ 64)))
              (LETT |p| (SPADCALL (SPADCALL |l| |f|) (QREFELT $ 65)))
              (LETT |s|
                    (|div_DF| (|sub_DF| |h| |l|)
                              (FLOAT (- (QREFELT $ 8) 1)
                                     MOST-POSITIVE-DOUBLE-FLOAT)))
              (SEQ (LETT |i| 2) (LETT #2# (- (QREFELT $ 8) 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |l| (|add_DF| |l| |s|)) (LETT |t| (CONS |l| |t|))
                        (EXIT (LETT |p| (CONS (SPADCALL |l| |f|) |p|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |t| (NREVERSE (CONS |h| |t|)))
              (LETT |p| (NREVERSE (CONS (SPADCALL |h| |f|) |p|)))
              (LETT |xRange|
                    (SPADCALL (|PLOT3D;select| |p| (ELT $ 53) (ELT $ 54) $)
                              (|PLOT3D;select| |p| (ELT $ 53) (ELT $ 55) $)
                              (QREFELT $ 24)))
              (LETT |yRange|
                    (SPADCALL (|PLOT3D;select| |p| (ELT $ 56) (ELT $ 54) $)
                              (|PLOT3D;select| |p| (ELT $ 56) (ELT $ 55) $)
                              (QREFELT $ 24)))
              (LETT |zRange|
                    (SPADCALL (|PLOT3D;select| |p| (ELT $ 57) (ELT $ 54) $)
                              (|PLOT3D;select| |p| (ELT $ 57) (ELT $ 55) $)
                              (QREFELT $ 24)))
              (EXIT
               (VECTOR |f| (LIST |tRange| |xRange| |yRange| |zRange|) |t|
                       |p|))))) 

(SDEFUN |PLOT3D;zoom;$3S$;27|
        ((|p| ($)) (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|)))
         (|zRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (VECTOR (LIST |xRange| |yRange| |zRange|) (QVELT |p| 1) (QVELT |p| 2)
                (QVELT |p| 3) (QVELT |p| 4))) 

(SDEFUN |PLOT3D;basicRefine|
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
         ((|zRange| #5=(|Segment| (|DoubleFloat|))) (|yRange| #5#)
          (|xRange| #5#) (|p| #4#) (|t| #3#) (|pm| #2#) (|tm| (|DoubleFloat|))
          (|f| #1#) (|h| (|DoubleFloat|)) (|l| (|DoubleFloat|))
          (|tRange| (|Segment| (|DoubleFloat|))))
         (SEQ (LETT |tRange| (|SPADfirst| (QVELT |curve| 1)))
              (LETT |curve|
                    (VECTOR (QVELT |curve| 0) (QVELT |curve| 1)
                            (QVELT |curve| 2) (QVELT |curve| 3)))
              (LETT |t|
                    (QSETVELT |curve| 2
                              (SPADCALL (QVELT |curve| 2) (QREFELT $ 67))))
              (LETT |p|
                    (QSETVELT |curve| 3
                              (SPADCALL (QVELT |curve| 3) (QREFELT $ 68))))
              (LETT |l| (SPADCALL |nRange| (QREFELT $ 20)))
              (LETT |h| (SPADCALL |nRange| (QREFELT $ 21)))
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
                      ((|less_DF| (SPADCALL |t| (QREFELT $ 47)) |l|)
                       (SEQ (LETT |t| (CDR |t|)) (EXIT (LETT |p| (CDR |p|)))))
                      ('T
                       (SEQ
                        (LETT |tm|
                              (|div_DF|
                               (|add_DF| (|SPADfirst| |t|)
                                         (SPADCALL |t| (QREFELT $ 47)))
                               (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT)))
                        (LETT |pm| (SPADCALL |tm| |f|))
                        (SETELT $ 10 (+ (QREFELT $ 10) 1))
                        (SPADCALL |t| '|rest| (CONS |tm| (CDR |t|))
                                  (QREFELT $ 49))
                        (LETT |t| (CDR (CDR |t|)))
                        (SPADCALL |p| '|rest| (CONS |pm| (CDR |p|))
                                  (QREFELT $ 51))
                        (EXIT (LETT |p| (CDR (CDR |p|)))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |t| (QVELT |curve| 2)) (LETT |p| (QVELT |curve| 3))
              (LETT |xRange|
                    (SPADCALL (|PLOT3D;select| |p| (ELT $ 53) (ELT $ 54) $)
                              (|PLOT3D;select| |p| (ELT $ 53) (ELT $ 55) $)
                              (QREFELT $ 24)))
              (LETT |yRange|
                    (SPADCALL (|PLOT3D;select| |p| (ELT $ 56) (ELT $ 54) $)
                              (|PLOT3D;select| |p| (ELT $ 56) (ELT $ 55) $)
                              (QREFELT $ 24)))
              (LETT |zRange|
                    (SPADCALL (|PLOT3D;select| |p| (ELT $ 57) (ELT $ 54) $)
                              (|PLOT3D;select| |p| (ELT $ 57) (ELT $ 55) $)
                              (QREFELT $ 24)))
              (EXIT
               (VECTOR (QVELT |curve| 0)
                       (LIST |tRange| |xRange| |yRange| |zRange|) |t| |p|))))) 

(SDEFUN |PLOT3D;refine;2$;29| ((|p| ($)) ($ ($)))
        (SPADCALL |p| (|PLOT3D;parametricRange| |p| $) (QREFELT $ 69))) 

(SDEFUN |PLOT3D;refine;$S$;30|
        ((|p| ($)) (|nRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|zRange| #1=(|Segment| (|DoubleFloat|))) (|yRange| #1#)
          (|xRange| #1#)
          (|curves|
           (|List|
            (|Record|
             (|:| |source|
                  (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
             (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
             (|:| |knots| (|List| (|DoubleFloat|)))
             (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
          (|scrres| (|Integer|)) (#2=#:G929 NIL) (|c| NIL) (#3=#:G928 NIL)
          (|tlimit| (|PositiveInteger|)) (#4=#:G927 NIL) (#5=#:G926 NIL)
          (|tRange| (|Segment| (|DoubleFloat|))))
         (SEQ (SETELT $ 10 0) (LETT |tRange| (|PLOT3D;parametricRange| |p| $))
              (LETT |nRange| (|PLOT3D;intersect| |tRange| |nRange| $))
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
                                  (CONS (|PLOT3D;basicRefine| |c| |nRange| $)
                                        #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |xRange| (|PLOT3D;join| |curves| 1 $))
              (LETT |yRange| (|PLOT3D;join| |curves| 2 $))
              (LETT |zRange| (|PLOT3D;join| |curves| 3 $))
              (LETT |scrres| (QVELT |p| 2))
              (COND
               ((SPADCALL (QREFELT $ 35))
                (SEQ (LETT |tlimit| 8)
                     (LETT |curves|
                           (PROGN
                            (LETT #3# NIL)
                            (SEQ (LETT |c| NIL) (LETT #2# |curves|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |c| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #3#
                                         (CONS
                                          (|PLOT3D;adaptivePlot| |c| |nRange|
                                           |xRange| |yRange| |zRange| |tlimit|
                                           (LETT |scrres| (* 2 |scrres|)) $)
                                          #3#))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT (NREVERSE #3#)))))
                     (LETT |xRange| (|PLOT3D;join| |curves| 1 $))
                     (LETT |yRange| (|PLOT3D;join| |curves| 2 $))
                     (EXIT (LETT |zRange| (|PLOT3D;join| |curves| 3 $))))))
              (EXIT
               (VECTOR (QVELT |p| 0) (LIST |tRange| |xRange| |yRange| |zRange|)
                       |scrres| (QVELT |p| 3) |curves|))))) 

(SDEFUN |PLOT3D;plot;$S$;31|
        ((|p| ($)) (|tRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|zRange| #1=(|Segment| (|DoubleFloat|))) (|yRange| #1#)
          (|xRange| #1#)
          (|curves|
           (|List|
            (|Record|
             (|:| |source|
                  (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
             (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
             (|:| |knots| (|List| (|DoubleFloat|)))
             (|:| |points| (|List| (|Point| (|DoubleFloat|)))))))
          (#2=#:G941 NIL) (|c| NIL) (#3=#:G940 NIL)
          (|tlimit| (|PositiveInteger|)) (#4=#:G939 NIL) (#5=#:G938 NIL))
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
                                  (CONS (|PLOT3D;rangeRefine| |c| |tRange| $)
                                        #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |xRange| (|PLOT3D;join| |curves| 1 $))
              (LETT |yRange| (|PLOT3D;join| |curves| 2 $))
              (LETT |zRange| (|PLOT3D;join| |curves| 3 $))
              (COND
               ((SPADCALL (QREFELT $ 35))
                (SEQ (LETT |tlimit| 8)
                     (LETT |curves|
                           (PROGN
                            (LETT #3# NIL)
                            (SEQ (LETT |c| NIL) (LETT #2# |curves|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |c| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #3#
                                         (CONS
                                          (|PLOT3D;adaptivePlot| |c| |tRange|
                                           |xRange| |yRange| |zRange| |tlimit|
                                           (QVELT |p| 2) $)
                                          #3#))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT (NREVERSE #3#)))))
                     (LETT |xRange| (|PLOT3D;join| |curves| 1 $))
                     (LETT |yRange| (|PLOT3D;join| |curves| 2 $))
                     (EXIT (LETT |zRange| (|PLOT3D;join| |curves| 3 $))))))
              (EXIT
               (VECTOR (LIST |xRange| |yRange| |zRange|)
                       (LIST |tRange| |xRange| |yRange| |zRange|) (QVELT |p| 2)
                       (QVELT |p| 3) |curves|))))) 

(SDEFUN |PLOT3D;pointPlot;MS$;32|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|p|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| #1=(|List| (|Segment| (|DoubleFloat|))))
            (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|))))))
          (|r| #1#))
         (SEQ (LETT |p| (|PLOT3D;basicPlot| |f| |tRange| $))
              (LETT |r| (QVELT |p| 1)) (SETELT $ 10 (QREFELT $ 8))
              (COND
               ((SPADCALL (QREFELT $ 35))
                (LETT |p|
                      (|PLOT3D;adaptivePlot| |p| (|SPADfirst| |r|)
                       (SPADCALL |r| (QREFELT $ 26))
                       (SPADCALL |r| (QREFELT $ 27)) (|PLOT3D;fourth| |r| $) 8
                       (QREFELT $ 11) $))))
              (EXIT (VECTOR (CDR |r|) |r| (QREFELT $ 11) NIL (LIST |p|)))))) 

(SDEFUN |PLOT3D;pointPlot;M4S$;33|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|)))
         (|zRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG ((|p| ($)))
               (SEQ (LETT |p| (SPADCALL |f| |tRange| (QREFELT $ 73)))
                    (QSETVELT |p| 0
                              (LIST (|PLOT3D;checkRange| |xRange| $)
                                    (|PLOT3D;checkRange| |yRange| $)
                                    (|PLOT3D;checkRange| |zRange| $)))
                    (EXIT |p|)))) 

(SDEFUN |PLOT3D;myTrap|
        ((|ff| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|f| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (SPROG ((|r| (|DoubleFloat|)) (|s| (|Union| (|DoubleFloat|) "failed")))
               (SEQ (LETT |s| (|trapNumericErrors| (SPADCALL |f| |ff|)))
                    (COND ((QEQCAR |s| 1) (LETT |r| 0.0))
                          ('T (LETT |r| (QCDR |s|))))
                    (EXIT |r|)))) 

(SDEFUN |PLOT3D;plot;4MS$;35|
        ((|f1| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|f2| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|f3| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|col| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG
         ((|p|
           (|Record|
            (|:| |source|
                 (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)))
            (|:| |ranges| #1=(|List| (|Segment| (|DoubleFloat|))))
            (|:| |knots| (|List| (|DoubleFloat|)))
            (|:| |points| (|List| (|Point| (|DoubleFloat|))))))
          (|r| #1#))
         (SEQ
          (LETT |p|
                (|PLOT3D;basicPlot|
                 (CONS #'|PLOT3D;plot;4MS$;35!0|
                       (VECTOR |col| |f3| |f2| $ |f1|))
                 |tRange| $))
          (LETT |r| (QVELT |p| 1)) (SETELT $ 10 (QREFELT $ 8))
          (COND
           ((SPADCALL (QREFELT $ 35))
            (LETT |p|
                  (|PLOT3D;adaptivePlot| |p| (|SPADfirst| |r|)
                   (SPADCALL |r| (QREFELT $ 26)) (SPADCALL |r| (QREFELT $ 27))
                   (|PLOT3D;fourth| |r| $) 8 (QREFELT $ 11) $))))
          (EXIT (VECTOR (CDR |r|) |r| (QREFELT $ 11) NIL (LIST |p|)))))) 

(SDEFUN |PLOT3D;plot;4MS$;35!0| ((|z1| NIL) ($$ NIL))
        (PROG (|f1| $ |f2| |f3| |col|)
          (LETT |f1| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |f2| (QREFELT $$ 2))
          (LETT |f3| (QREFELT $$ 1))
          (LETT |col| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|PLOT3D;point| (|PLOT3D;myTrap| |f1| |z1| $)
             (|PLOT3D;myTrap| |f2| |z1| $) (|PLOT3D;myTrap| |f3| |z1| $)
             (SPADCALL |z1| |col|) $))))) 

(SDEFUN |PLOT3D;plot;4M4S$;36|
        ((|f1| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|f2| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|f3| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|col| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|xRange| (|Segment| (|DoubleFloat|)))
         (|yRange| (|Segment| (|DoubleFloat|)))
         (|zRange| (|Segment| (|DoubleFloat|))) ($ ($)))
        (SPROG ((|p| ($)))
               (SEQ
                (LETT |p|
                      (SPADCALL |f1| |f2| |f3| |col| |tRange| (QREFELT $ 76)))
                (QSETVELT |p| 0
                          (LIST (|PLOT3D;checkRange| |xRange| $)
                                (|PLOT3D;checkRange| |yRange| $)
                                (|PLOT3D;checkRange| |zRange| $)))
                (EXIT |p|)))) 

(SDEFUN |PLOT3D;coerce;$Of;37| ((|r| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|f| (|List| (|OutputForm|))) (|l| (|List| #1=(|OutputForm|)))
          (#2=#:G988 NIL) (|p| NIL) (#3=#:G987 NIL) (|h| (|OutputForm|))
          (|zRange| #1#) (|yRange| #1#) (|xRange| #1#) (#4=#:G986 NIL)
          (|curve| NIL) (|tRange| (|OutputForm|)) (|tSymbol| #5=(|OutputForm|))
          (|zSymbol| #5#) (|ySymbol| #5#) (|xSymbol| #5#) (|spaces| #5#))
         (SEQ (LETT |spaces| (SPADCALL "   " (QREFELT $ 80)))
              (LETT |xSymbol| (SPADCALL "x = " (QREFELT $ 80)))
              (LETT |ySymbol| (SPADCALL "y = " (QREFELT $ 80)))
              (LETT |zSymbol| (SPADCALL "z = " (QREFELT $ 80)))
              (LETT |tSymbol| (SPADCALL "t = " (QREFELT $ 80)))
              (LETT |tRange|
                    (SPADCALL (|PLOT3D;parametricRange| |r| $) (QREFELT $ 81)))
              (LETT |f| NIL)
              (SEQ (LETT |curve| NIL) (LETT #4# (QVELT |r| 4)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |curve| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |xRange|
                          (SPADCALL
                           (SPADCALL (QVELT |curve| 1) 1 (QREFELT $ 82))
                           (QREFELT $ 81)))
                    (LETT |yRange|
                          (SPADCALL
                           (SPADCALL (QVELT |curve| 1) 2 (QREFELT $ 82))
                           (QREFELT $ 81)))
                    (LETT |zRange|
                          (SPADCALL
                           (SPADCALL (QVELT |curve| 1) 3 (QREFELT $ 82))
                           (QREFELT $ 81)))
                    (LETT |l|
                          (LIST |xSymbol| |xRange| |spaces| |ySymbol| |yRange|
                                |spaces| |zSymbol| |zRange|))
                    (LETT |l|
                          (SPADCALL (LIST |tSymbol| |tRange| |spaces|) |l|
                                    (QREFELT $ 84)))
                    (LETT |h| (SPADCALL |l| (QREFELT $ 86)))
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
                                        (CONS (SPADCALL |p| (QREFELT $ 87))
                                              #3#))))
                                (LETT #2# (CDR #2#)) (GO G190) G191
                                (EXIT (NREVERSE #3#)))))
                    (EXIT
                     (LETT |f|
                           (CONS (SPADCALL (CONS |h| |l|) (QREFELT $ 88))
                                 |f|))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL "PLOT" (QREFELT $ 80)) (NREVERSE |f|)
                         (QREFELT $ 89)))))) 

(SDEFUN |PLOT3D;listBranches;$L;38|
        ((|plot| ($)) ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|outList| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (#1=#:G994 NIL) (|curve| NIL))
         (SEQ (LETT |outList| NIL)
              (SEQ (LETT |curve| NIL) (LETT #1# (QVELT |plot| 4)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |curve| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT (LETT |outList| (CONS (QVELT |curve| 3) |outList|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |outList|)))) 

(DECLAIM (NOTINLINE |Plot3D;|)) 

(DEFUN |Plot3D| ()
  (SPROG NIL
         (PROG (#1=#:G996)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Plot3D|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Plot3D|
                             (LIST (CONS NIL (CONS 1 (|Plot3D;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Plot3D|)))))))))) 

(DEFUN |Plot3D;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Plot3D|))
          (LETT $ (GETREFV 93))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Plot3D| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record|
                     (|:| |display| (|List| (|Segment| (|DoubleFloat|))))
                     (|:| |bounds| (|List| (|Segment| (|DoubleFloat|))))
                     (|:| |screenres| (|Integer|))
                     (|:| |axisLabels| (|List| (|String|)))
                     (|:| |functions|
                          (|List|
                           (|Record|
                            (|:| |source|
                                 (|Mapping| (|Point| (|DoubleFloat|))
                                            (|DoubleFloat|)))
                            (|:| |ranges| (|List| (|Segment| (|DoubleFloat|))))
                            (|:| |knots| (|List| (|DoubleFloat|)))
                            (|:| |points|
                                 (|List| (|Point| (|DoubleFloat|)))))))))
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

(MAKEPROP '|Plot3D| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| 'ADAPTIVE 'MINPOINTS 'MAXPOINTS
              'NUMFUNEVALS 'SCREENRES (|DoubleFloat|) (0 . |inv|) 'ANGLEBOUND
              'DEBUG (|List| 12) (|Point| 12) (5 . |point|) (|Segment| 12)
              (10 . |low|) (15 . |high|) (|Boolean|) (20 . >) (26 . SEGMENT)
              (|List| 19) (32 . |second|) (37 . |third|) (|Integer|)
              |PLOT3D;minPoints3D;I;8| |PLOT3D;setMinPoints3D;2I;9|
              |PLOT3D;maxPoints3D;I;10| |PLOT3D;setMaxPoints3D;2I;11|
              |PLOT3D;screenResolution3D;I;12|
              |PLOT3D;setScreenResolution3D;2I;13| |PLOT3D;adaptive3D?;B;14|
              |PLOT3D;setAdaptive3D;2B;15| |PLOT3D;numFunEvals3D;I;16|
              |PLOT3D;debug3D;2B;17| |PLOT3D;xRange;$S;18|
              |PLOT3D;yRange;$S;19| |PLOT3D;zRange;$S;20| |PLOT3D;tRange;$S;21|
              (|List| 16) |PLOT3D;tValues;$L;22| (42 . <=) (48 . ~=)
              (54 . |second|) '"rest" (59 . |setelt!|) (|List| 17)
              (66 . |setelt!|) (|PointPackage| 12) (73 . |xCoord|) (78 . |min|)
              (84 . |max|) (90 . |yCoord|) (95 . |zCoord|) (100 . |third|)
              (105 . |second|) (110 . |third|) (|PositiveInteger|) (115 . ^)
              (121 . |sqrt|) (126 . |list|) (131 . |list|)
              |PLOT3D;zoom;$3S$;27| (136 . |copy|) (141 . |copy|)
              |PLOT3D;refine;$S$;30| |PLOT3D;refine;2$;29| |PLOT3D;plot;$S$;31|
              (|Mapping| 17 12) |PLOT3D;pointPlot;MS$;32|
              |PLOT3D;pointPlot;M4S$;33| (|Mapping| 12 12)
              |PLOT3D;plot;4MS$;35| |PLOT3D;plot;4M4S$;36| (|String|)
              (|OutputForm|) (146 . |message|) (151 . |coerce|) (156 . |elt|)
              (|List| 79) (162 . |concat!|) (|List| $) (168 . |hconcat|)
              (173 . |coerce|) (178 . |vconcat|) (183 . |prefix|)
              |PLOT3D;coerce;$Of;37| (|List| 50) |PLOT3D;listBranches;$L;38|)
           '#(|zoom| 189 |zRange| 197 |yRange| 202 |xRange| 207 |tValues| 212
              |tRange| 217 |setScreenResolution3D| 222 |setMinPoints3D| 227
              |setMaxPoints3D| 232 |setAdaptive3D| 237 |screenResolution3D| 242
              |refine| 246 |pointPlot| 257 |plot| 272 |numFunEvals3D| 299
              |minPoints3D| 303 |maxPoints3D| 307 |listBranches| 311 |debug3D|
              316 |coerce| 321 |adaptive3D?| 326)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(NIL NIL)
                       (CONS
                        '#((|PlottableSpaceCurveCategory|) (|CoercibleTo| 79))
                        (|makeByteWordVec2| 92
                                            '(1 12 0 0 13 1 17 0 16 18 1 19 12
                                              0 20 1 19 12 0 21 2 12 22 0 0 23
                                              2 19 0 12 12 24 1 25 19 0 26 1 25
                                              19 0 27 2 12 22 0 0 45 2 12 22 0
                                              0 46 1 16 12 0 47 3 16 0 0 48 0
                                              49 3 50 0 0 48 0 51 1 52 12 17 53
                                              2 12 0 0 0 54 2 12 0 0 0 55 1 52
                                              12 17 56 1 52 12 17 57 1 16 12 0
                                              58 1 50 17 0 59 1 50 17 0 60 2 12
                                              0 0 61 62 1 12 0 0 63 1 16 0 12
                                              64 1 50 0 17 65 1 16 0 0 67 1 50
                                              0 0 68 1 79 0 78 80 1 19 79 0 81
                                              2 25 19 0 28 82 2 83 0 0 0 84 1
                                              79 0 85 86 1 17 79 0 87 1 79 0 85
                                              88 2 79 0 0 85 89 4 0 0 0 19 19
                                              19 66 1 0 19 0 41 1 0 19 0 40 1 0
                                              19 0 39 1 0 43 0 44 1 0 19 0 42 1
                                              0 28 28 34 1 0 28 28 30 1 0 28 28
                                              32 1 0 22 22 36 0 0 28 33 1 0 0 0
                                              70 2 0 0 0 19 69 5 0 0 72 19 19
                                              19 19 74 2 0 0 72 19 73 2 0 0 0
                                              19 71 5 0 0 75 75 75 75 19 76 8 0
                                              0 75 75 75 75 19 19 19 19 77 0 0
                                              28 37 0 0 28 29 0 0 28 31 1 0 91
                                              0 92 1 0 22 22 38 1 0 79 0 90 0 0
                                              22 35)))))
           '|lookupComplete|)) 

(MAKEPROP '|Plot3D| 'NILADIC T) 
