
(SDEFUN |EXPRTUBE;getVariable|
        ((|x| (|Expression| (|Integer|))) (|y| (|Expression| (|Integer|)))
         (|z| (|Expression| (|Integer|))) ($ (|Symbol|)))
        (SPROG
         ((|t2| #1=(|Symbol|)) (|t1| #1#) (|varList3| #2=(|List| (|Symbol|)))
          (|varList2| #2#) (|varList1| #2#))
         (SEQ (LETT |varList1| (SPADCALL |x| (QREFELT $ 8)))
              (LETT |varList2| (SPADCALL |y| (QREFELT $ 8)))
              (LETT |varList3| (SPADCALL |z| (QREFELT $ 8)))
              (COND
               ((<= (LENGTH |varList1|) 1)
                (COND
                 ((<= (LENGTH |varList2|) 1)
                  (COND
                   ((NULL (<= (LENGTH |varList3|) 1))
                    (EXIT
                     (|error| #3="tubePlot: only one variable may be used")))))
                 (#4='T (EXIT (|error| #3#)))))
               (#4# (EXIT (|error| #3#))))
              (EXIT
               (COND
                ((NULL |varList1|)
                 (COND
                  ((NULL |varList2|)
                   (COND
                    ((NULL |varList3|)
                     (|error| "tubePlot: a variable must appear in functions"))
                    (#4# (|SPADfirst| |varList3|))))
                  (#4#
                   (SEQ (LETT |t2| (|SPADfirst| |varList2|))
                        (EXIT
                         (COND ((NULL |varList3|) |t2|)
                               ((NULL (EQUAL (|SPADfirst| |varList3|) |t2|))
                                (|error|
                                 "tubePlot: only one variable may be used"))))))))
                (#4#
                 (SEQ (LETT |t1| (|SPADfirst| |varList1|))
                      (EXIT
                       (COND
                        ((NULL |varList2|)
                         (COND
                          ((OR (NULL |varList3|)
                               (NULL
                                (NULL (EQUAL (|SPADfirst| |varList3|) |t1|))))
                           |t1|)
                          ('T
                           (|error|
                            "tubePlot: only one variable may be used"))))
                        (#4#
                         (SEQ (LETT |t2| (|SPADfirst| |varList2|))
                              (EXIT
                               (COND
                                ((NULL |varList3|)
                                 (COND ((EQUAL |t1| |t2|) |t1|)
                                       (#4#
                                        (|error|
                                         "tubePlot: only one variable may be used"))))
                                (#4#
                                 (SEQ
                                  (COND
                                   ((EQUAL (|SPADfirst| |varList3|) |t1|)
                                    (COND
                                     ((NULL (EQUAL |t2| |t1|))
                                      (EXIT
                                       (|error|
                                        #5="tubePlot: only one variable may be used")))))
                                   (#4# (EXIT (|error| #5#))))
                                  (EXIT |t1|)))))))))))))))) 

(SDEFUN |EXPRTUBE;tubePlot;3EMSMISTp;2|
        ((|x| (|Expression| (|Integer|))) (|y| (|Expression| (|Integer|)))
         (|z| (|Expression| (|Integer|)))
         (|colorFcn| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|radFcn| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|n| (|Integer|)) (|string| (|String|)) ($ (|TubePlot| (|Plot3D|))))
        (SPROG
         ((|loopList| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|lps| (|List| (|Point| (|DoubleFloat|))))
          (|bNorm| #1=(|Point| (|DoubleFloat|)))
          (|bNormList| (|List| #2=(|DoubleFloat|))) (|pNorm| #1#)
          (|pNormList| (|List| #2#))
          (|curvePts| (|List| (|Point| (|DoubleFloat|))))
          (|ctr| (|Point| (|DoubleFloat|))) (|tvals| (|List| (|DoubleFloat|)))
          (|tval| (|DoubleFloat|)) (|cosSin| (|List| (|List| (|DoubleFloat|))))
          (|parPlot| (|Plot3D|))
          (|BzFunc| #3=(|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
          (|ByFunc| #3#) (|BxFunc| #3#) (|Bz| #4=(|Expression| (|Integer|)))
          (|By| #4#) (|Bx| #4#) (|NzFunc| #3#) (|NyFunc| #3#) (|NxFunc| #3#)
          (|Nz| #5=(|Expression| (|Integer|))) (|Ny| #5#) (|Nx| #5#)
          (K #6=(|Expression| (|Integer|)))
          (|Tzp| #7=(|Expression| (|Integer|))) (|Typ| #7#) (|Txp| #7#)
          (|Tz| #5#) (|Ty| #5#) (|Tx| #5#) (|sp| #6#) (|zp| #7#) (|yp| #7#)
          (|xp| #7#) (|zFunc| #3#) (|yFunc| #3#) (|xFunc| #3#) (|t| (|Symbol|))
          (|flag| (|Boolean|)))
         (SEQ
          (COND ((< |n| 3) (|error| "tubePlot: n should be at least 3"))
                (#8='T
                 (SEQ
                  (LETT |flag|
                        (COND ((EQUAL |string| "closed") 'T)
                              ((EQUAL |string| "open") NIL)
                              (#8#
                               (|error|
                                "tubePlot: last argument should be open or closed"))))
                  (LETT |t| (|EXPRTUBE;getVariable| |x| |y| |z| $))
                  (LETT |xFunc| (SPADCALL |x| |t| (QREFELT $ 13)))
                  (LETT |yFunc| (SPADCALL |y| |t| (QREFELT $ 13)))
                  (LETT |zFunc| (SPADCALL |z| |t| (QREFELT $ 13)))
                  (LETT |xp| (SPADCALL |x| |t| (QREFELT $ 14)))
                  (LETT |yp| (SPADCALL |y| |t| (QREFELT $ 14)))
                  (LETT |zp| (SPADCALL |z| |t| (QREFELT $ 14)))
                  (LETT |sp|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |xp| 2 (QREFELT $ 16))
                                    (SPADCALL |yp| 2 (QREFELT $ 16))
                                    (QREFELT $ 17))
                          (SPADCALL |zp| 2 (QREFELT $ 16)) (QREFELT $ 17))
                         (QREFELT $ 18)))
                  (LETT |Tx| (SPADCALL |xp| |sp| (QREFELT $ 19)))
                  (LETT |Ty| (SPADCALL |yp| |sp| (QREFELT $ 19)))
                  (LETT |Tz| (SPADCALL |zp| |sp| (QREFELT $ 19)))
                  (LETT |Txp| (SPADCALL |Tx| |t| (QREFELT $ 14)))
                  (LETT |Typ| (SPADCALL |Ty| |t| (QREFELT $ 14)))
                  (LETT |Tzp| (SPADCALL |Tz| |t| (QREFELT $ 14)))
                  (LETT K
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |Txp| 2 (QREFELT $ 16))
                                    (SPADCALL |Typ| 2 (QREFELT $ 16))
                                    (QREFELT $ 17))
                          (SPADCALL |Tzp| 2 (QREFELT $ 16)) (QREFELT $ 17))
                         (QREFELT $ 18)))
                  (LETT |Nx| (SPADCALL |Txp| K (QREFELT $ 19)))
                  (LETT |Ny| (SPADCALL |Typ| K (QREFELT $ 19)))
                  (LETT |Nz| (SPADCALL |Tzp| K (QREFELT $ 19)))
                  (LETT |NxFunc| (SPADCALL |Nx| |t| (QREFELT $ 13)))
                  (LETT |NyFunc| (SPADCALL |Ny| |t| (QREFELT $ 13)))
                  (LETT |NzFunc| (SPADCALL |Nz| |t| (QREFELT $ 13)))
                  (LETT |Bx|
                        (SPADCALL (SPADCALL |Ty| |Nz| (QREFELT $ 20))
                                  (SPADCALL |Tz| |Ny| (QREFELT $ 20))
                                  (QREFELT $ 21)))
                  (LETT |By|
                        (SPADCALL (SPADCALL |Tz| |Nx| (QREFELT $ 20))
                                  (SPADCALL |Tx| |Nz| (QREFELT $ 20))
                                  (QREFELT $ 21)))
                  (LETT |Bz|
                        (SPADCALL (SPADCALL |Tx| |Ny| (QREFELT $ 20))
                                  (SPADCALL |Ty| |Nx| (QREFELT $ 20))
                                  (QREFELT $ 21)))
                  (LETT |BxFunc| (SPADCALL |Bx| |t| (QREFELT $ 13)))
                  (LETT |ByFunc| (SPADCALL |By| |t| (QREFELT $ 13)))
                  (LETT |BzFunc| (SPADCALL |Bz| |t| (QREFELT $ 13)))
                  (LETT |parPlot|
                        (SPADCALL |xFunc| |yFunc| |zFunc| |colorFcn| |tRange|
                                  (QREFELT $ 24)))
                  (LETT |tvals|
                        (|SPADfirst| (SPADCALL |parPlot| (QREFELT $ 26))))
                  (LETT |curvePts|
                        (|SPADfirst| (SPADCALL |parPlot| (QREFELT $ 28))))
                  (LETT |cosSin| (SPADCALL |n| (QREFELT $ 31)))
                  (LETT |loopList| NIL)
                  (SEQ G190 (COND ((NULL (NULL (NULL |tvals|))) (GO G191)))
                       (SEQ (LETT |tval| (|SPADfirst| |tvals|))
                            (LETT |tvals| (CDR |tvals|))
                            (LETT |ctr| (|SPADfirst| |curvePts|))
                            (LETT |curvePts| (CDR |curvePts|))
                            (LETT |pNormList|
                                  (LIST (SPADCALL |tval| |NxFunc|)
                                        (SPADCALL |tval| |NyFunc|)
                                        (SPADCALL |tval| |NzFunc|)
                                        (SPADCALL |tval| |colorFcn|)))
                            (LETT |pNorm|
                                  (SPADCALL |pNormList| (QREFELT $ 34)))
                            (LETT |bNormList|
                                  (LIST (SPADCALL |tval| |BxFunc|)
                                        (SPADCALL |tval| |ByFunc|)
                                        (SPADCALL |tval| |BzFunc|)
                                        (SPADCALL |tval| |colorFcn|)))
                            (LETT |bNorm|
                                  (SPADCALL |bNormList| (QREFELT $ 34)))
                            (LETT |lps|
                                  (SPADCALL |ctr| |pNorm| |bNorm|
                                            (SPADCALL |tval| |radFcn|) |cosSin|
                                            (QREFELT $ 37)))
                            (EXIT (LETT |loopList| (CONS |lps| |loopList|))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SPADCALL |parPlot| (NREVERSE |loopList|) |flag|
                             (QREFELT $ 40))))))))) 

(SDEFUN |EXPRTUBE;tubePlot;3EMSMITp;3|
        ((|x| (|Expression| (|Integer|))) (|y| (|Expression| (|Integer|)))
         (|z| (|Expression| (|Integer|)))
         (|colorFcn| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|)))
         (|radFcn| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|n| (|Integer|)) ($ (|TubePlot| (|Plot3D|))))
        (SPADCALL |x| |y| |z| |colorFcn| |tRange| |radFcn| |n| "open"
                  (QREFELT $ 42))) 

(PUT '|EXPRTUBE;project| '|SPADreplace| '(XLAM (|x| |y|) |x|)) 

(SDEFUN |EXPRTUBE;project|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) ($ (|DoubleFloat|))) |x|) 

(SDEFUN |EXPRTUBE;constantToUnaryFunction;DfM;5|
        ((|x| (|DoubleFloat|)) ($ (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
        (SPROG NIL
               (CONS #'|EXPRTUBE;constantToUnaryFunction;DfM;5!0|
                     (VECTOR $ |x|)))) 

(SDEFUN |EXPRTUBE;constantToUnaryFunction;DfM;5!0| ((|s| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|EXPRTUBE;project| |x| |s| $))))) 

(SDEFUN |EXPRTUBE;tubePlot;3EMSDfISTp;6|
        ((|x| (|Expression| (|Integer|))) (|y| (|Expression| (|Integer|)))
         (|z| (|Expression| (|Integer|)))
         (|colorFcn| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|))) (|rad| (|DoubleFloat|))
         (|n| (|Integer|)) (|s| (|String|)) ($ (|TubePlot| (|Plot3D|))))
        (SPADCALL |x| |y| |z| |colorFcn| |tRange|
                  (SPADCALL |rad| (QREFELT $ 44)) |n| |s| (QREFELT $ 42))) 

(SDEFUN |EXPRTUBE;tubePlot;3EMSDfITp;7|
        ((|x| (|Expression| (|Integer|))) (|y| (|Expression| (|Integer|)))
         (|z| (|Expression| (|Integer|)))
         (|colorFcn| (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
         (|tRange| (|Segment| (|DoubleFloat|))) (|rad| (|DoubleFloat|))
         (|n| (|Integer|)) ($ (|TubePlot| (|Plot3D|))))
        (SPADCALL |x| |y| |z| |colorFcn| |tRange| |rad| |n| "open"
                  (QREFELT $ 45))) 

(DECLAIM (NOTINLINE |ExpressionTubePlot;|)) 

(DEFUN |ExpressionTubePlot| ()
  (SPROG NIL
         (PROG (#1=#:G763)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ExpressionTubePlot|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ExpressionTubePlot|
                             (LIST
                              (CONS NIL (CONS 1 (|ExpressionTubePlot;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ExpressionTubePlot|)))))))))) 

(DEFUN |ExpressionTubePlot;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ExpressionTubePlot|))
          (LETT $ (GETREFV 47))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExpressionTubePlot| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ExpressionTubePlot| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| 11) (|Expression| 29)
              (0 . |variables|) (5 . |One|) (|Mapping| 36 36) (|Symbol|)
              (|MakeFloatCompiledFunction| 7) (9 . |makeFloatFunction|)
              (15 . |differentiate|) (|PositiveInteger|) (21 . ^) (27 . +)
              (33 . |sqrt|) (38 . /) (44 . *) (50 . -) (|Segment| 36)
              (|Plot3D|) (56 . |plot|) (|List| 32) (65 . |tValues|) (|List| 35)
              (70 . |listBranches|) (|Integer|) (|TubePlotTools|)
              (75 . |cosSinInfo|) (|List| 36) (|Point| 36) (80 . |point|)
              (|List| 33) (|DoubleFloat|) (85 . |loopPoints|) (|Boolean|)
              (|TubePlot| 23) (94 . |tube|) (|String|)
              |EXPRTUBE;tubePlot;3EMSMISTp;2| |EXPRTUBE;tubePlot;3EMSMITp;3|
              |EXPRTUBE;constantToUnaryFunction;DfM;5|
              |EXPRTUBE;tubePlot;3EMSDfISTp;6| |EXPRTUBE;tubePlot;3EMSDfITp;7|)
           '#(|tubePlot| 101 |constantToUnaryFunction| 147) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|constantToUnaryFunction|
                                 ((|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|DoubleFloat|)))
                                T)
                              '((|tubePlot|
                                 ((|TubePlot| (|Plot3D|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Integer|)))
                                T)
                              '((|tubePlot|
                                 ((|TubePlot| (|Plot3D|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Integer|) (|String|)))
                                T)
                              '((|tubePlot|
                                 ((|TubePlot| (|Plot3D|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|)) (|DoubleFloat|)
                                  (|Integer|)))
                                T)
                              '((|tubePlot|
                                 ((|TubePlot| (|Plot3D|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|)) (|DoubleFloat|)
                                  (|Integer|) (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(1 7 6 0 8 0 7 0 9 2 12 10 7 11 13
                                              2 7 0 0 11 14 2 7 0 0 15 16 2 7 0
                                              0 0 17 1 7 0 0 18 2 7 0 0 0 19 2
                                              7 0 0 0 20 2 7 0 0 0 21 5 23 0 10
                                              10 10 10 22 24 1 23 25 0 26 1 23
                                              27 0 28 1 30 25 29 31 1 33 0 32
                                              34 5 30 35 33 33 33 36 25 37 3 39
                                              0 23 27 38 40 7 0 39 7 7 7 10 22
                                              10 29 43 8 0 39 7 7 7 10 22 10 29
                                              41 42 8 0 39 7 7 7 10 22 36 29 41
                                              45 7 0 39 7 7 7 10 22 36 29 46 1
                                              0 10 36 44)))))
           '|lookupComplete|)) 

(MAKEPROP '|ExpressionTubePlot| 'NILADIC T) 
