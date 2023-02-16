
(SDEFUN |PLOTTOOL;drawToScaleRanges|
        ((|xVals| (|Segment| (|DoubleFloat|)))
         (|yVals| (|Segment| (|DoubleFloat|)))
         ($ (|List| (|Segment| (|DoubleFloat|)))))
        (SPROG
         ((|pad| (|DoubleFloat|)) (|yDiff| #1=(|DoubleFloat|))
          (|yLo| #2=(|DoubleFloat|)) (|yHi| #3=(|DoubleFloat|)) (|xDiff| #1#)
          (|xLo| #2#) (|xHi| #3#))
         (SEQ
          (LETT |xDiff|
                (|sub_DF| (LETT |xHi| (SPADCALL |xVals| (QREFELT $ 8)))
                          (LETT |xLo| (SPADCALL |xVals| (QREFELT $ 9)))))
          (LETT |yDiff|
                (|sub_DF| (LETT |yHi| (SPADCALL |yVals| (QREFELT $ 8)))
                          (LETT |yLo| (SPADCALL |yVals| (QREFELT $ 9)))))
          (LETT |pad| (|div_DF_I| (|abs_DF| (|sub_DF| |yDiff| |xDiff|)) 2))
          (EXIT
           (COND
            ((SPADCALL |yDiff| |xDiff| (QREFELT $ 11))
             (LIST
              (SPADCALL (|sub_DF| |xLo| |pad|) (|add_DF| |xHi| |pad|)
                        (QREFELT $ 12))
              |yVals|))
            ('T
             (LIST |xVals|
                   (SPADCALL (|sub_DF| |yLo| |pad|) (|add_DF| |yHi| |pad|)
                             (QREFELT $ 12))))))))) 

(SDEFUN |PLOTTOOL;select|
        ((|l| (|List| (|Point| (|DoubleFloat|))))
         (|f| (|Mapping| #1=(|DoubleFloat|) (|Point| (|DoubleFloat|))))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (SPROG ((|m| #1#) (#2=#:G705 NIL) (|p| NIL))
               (SEQ (LETT |m| (SPADCALL (|SPADfirst| |l|) |f|))
                    (SEQ (LETT |p| NIL) (LETT #2# (CDR |l|)) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |m| (SPADCALL |m| (SPADCALL |p| |f|) |g|))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |m|)))) 

(SDEFUN |PLOTTOOL;xRange0|
        ((|list| (|List| (|Point| (|DoubleFloat|))))
         ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL (|PLOTTOOL;select| |list| (ELT $ 15) (ELT $ 16) $)
                  (|PLOTTOOL;select| |list| (ELT $ 15) (ELT $ 17) $)
                  (QREFELT $ 18))) 

(SDEFUN |PLOTTOOL;yRange0|
        ((|list| (|List| (|Point| (|DoubleFloat|))))
         ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL (|PLOTTOOL;select| |list| (ELT $ 19) (ELT $ 16) $)
                  (|PLOTTOOL;select| |list| (ELT $ 19) (ELT $ 17) $)
                  (QREFELT $ 18))) 

(SDEFUN |PLOTTOOL;select2|
        ((|l| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|f|
          (|Mapping| #1=(|DoubleFloat|) (|List| (|Point| (|DoubleFloat|)))))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (SPROG ((|m| #1#) (#2=#:G724 NIL) (|p| NIL))
               (SEQ (LETT |m| (SPADCALL (|SPADfirst| |l|) |f|))
                    (SEQ (LETT |p| NIL) (LETT #2# (CDR |l|)) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |m| (SPADCALL |m| (SPADCALL |p| |f|) |g|))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |m|)))) 

(SDEFUN |PLOTTOOL;xRange|
        ((|list| (|List| (|List| (|Point| (|DoubleFloat|)))))
         ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL
         (|PLOTTOOL;select2| |list| (CONS #'|PLOTTOOL;xRange!0| $) (ELT $ 16)
          $)
         (|PLOTTOOL;select2| |list| (CONS #'|PLOTTOOL;xRange!1| $) (ELT $ 17)
          $)
         (QREFELT $ 18))) 

(SDEFUN |PLOTTOOL;xRange!1| ((|v1| NIL) ($ NIL))
        (SPADCALL (|PLOTTOOL;xRange0| |v1| $) (QREFELT $ 8))) 

(SDEFUN |PLOTTOOL;xRange!0| ((|u1| NIL) ($ NIL))
        (SPADCALL (|PLOTTOOL;xRange0| |u1| $) (QREFELT $ 9))) 

(SDEFUN |PLOTTOOL;yRange|
        ((|list| (|List| (|List| (|Point| (|DoubleFloat|)))))
         ($ (|Segment| (|DoubleFloat|))))
        (SPADCALL
         (|PLOTTOOL;select2| |list| (CONS #'|PLOTTOOL;yRange!0| $) (ELT $ 16)
          $)
         (|PLOTTOOL;select2| |list| (CONS #'|PLOTTOOL;yRange!1| $) (ELT $ 17)
          $)
         (QREFELT $ 18))) 

(SDEFUN |PLOTTOOL;yRange!1| ((|v1| NIL) ($ NIL))
        (SPADCALL (|PLOTTOOL;yRange0| |v1| $) (QREFELT $ 8))) 

(SDEFUN |PLOTTOOL;yRange!0| ((|u1| NIL) ($ NIL))
        (SPADCALL (|PLOTTOOL;yRange0| |u1| $) (QREFELT $ 9))) 

(SDEFUN |PLOTTOOL;calcRanges;LL;8|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|)))))
         ($ (|List| (|Segment| (|DoubleFloat|)))))
        (COND
         ((SPADCALL (QREFELT $ 21))
          (|PLOTTOOL;drawToScaleRanges| (|PLOTTOOL;xRange| |llp| $)
           (|PLOTTOOL;yRange| |llp| $) $))
         ('T (LIST (|PLOTTOOL;xRange| |llp| $) (|PLOTTOOL;yRange| |llp| $))))) 

(DECLAIM (NOTINLINE |PlotTools;|)) 

(DEFUN |PlotTools| ()
  (SPROG NIL
         (PROG (#1=#:G741)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PlotTools|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PlotTools|
                             (LIST (CONS NIL (CONS 1 (|PlotTools;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|PlotTools|)))))))))) 

(DEFUN |PlotTools;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PlotTools|))
          (LETT $ (GETREFV 25))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PlotTools| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PlotTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|DoubleFloat|) (|Segment| 6)
              (0 . |high|) (5 . |low|) (|Boolean|) (10 . >) (16 . |segment|)
              (|Point| 6) (|PointPackage| 6) (22 . |xCoord|) (27 . |min|)
              (33 . |max|) (39 . SEGMENT) (45 . |yCoord|) (|GraphicsDefaults|)
              (50 . |drawToScale|) (|List| 7) (|List| (|List| 13))
              |PLOTTOOL;calcRanges;LL;8|)
           '#(|calcRanges| 54) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|calcRanges|
                                 ((|List| (|Segment| (|DoubleFloat|)))
                                  (|List| (|List| (|Point| (|DoubleFloat|))))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 24
                                            '(1 7 6 0 8 1 7 6 0 9 2 6 10 0 0 11
                                              2 7 0 6 6 12 1 14 6 13 15 2 6 0 0
                                              0 16 2 6 0 0 0 17 2 7 0 6 6 18 1
                                              14 6 13 19 0 20 10 21 1 0 22 23
                                              24)))))
           '|lookupComplete|)) 

(MAKEPROP '|PlotTools| 'NILADIC T) 
