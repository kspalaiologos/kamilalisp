
(SDEFUN |CLIP;Fnan?| ((|x| (|DoubleFloat|)) ($ (|Boolean|)))
        (SPADCALL |x| |x| (QREFELT $ 8))) 

(SDEFUN |CLIP;Pnan?| ((|p| (|Point| (|DoubleFloat|))) ($ (|Boolean|)))
        (SPADCALL (CONS (|function| |CLIP;Fnan?|) $) |p| (QREFELT $ 11))) 

(SDEFUN |CLIP;iClipParametric|
        ((|pointLists| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|fraction| (|Fraction| (|Integer|)))
         (|scale| (|Fraction| (|Integer|)))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (SPROG
         ((|yseg| #1=(|Segment| (|DoubleFloat|))) (|xseg| #1#)
          (|yMax| #2=(|DoubleFloat|)) (|xMax| #3=(|DoubleFloat|)) (|yMin| #2#)
          (|xMin| #3#) (|ys| #4=(|List| (|DoubleFloat|))) (|xs| #4#)
          (|newclip|
           (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                     (|:| |xValues| (|Segment| (|DoubleFloat|)))
                     (|:| |yValues| (|Segment| (|DoubleFloat|)))))
          (|denn| #5=(|Integer|)) (|numm| #6=(|Integer|))
          (|single_eps| (|DoubleFloat|)) (|yDiff| #7=(|DoubleFloat|))
          (|xDiff| #7#) (#8=#:G783 NIL) (|k| NIL) (#9=#:G784 NIL) (|pt| NIL)
          (|firstPt| (|Point| (|DoubleFloat|))) (|lastN| (|Integer|))
          (|clipNum| (|Integer|)) (|den| #5#) (|num| #6#)
          (|n| (|NonNegativeInteger|))
          (|sortedList| (|List| (|Point| (|DoubleFloat|)))))
         (SEQ
          (COND
           ((OR (SPADCALL |fraction| (|spadConstant| $ 13) (QREFELT $ 14))
                (SPADCALL |fraction| (|spadConstant| $ 15) (QREFELT $ 16)))
            (|error| "clipDraw: fraction should be between 0 and 1"))
           ('T
            (COND
             ((NULL |pointLists|)
              (VECTOR NIL (SPADCALL 0.0 0.0 (QREFELT $ 18))
                      (SPADCALL 0.0 0.0 (QREFELT $ 18))))
             (#10='T
              (SEQ
               (LETT |sortedList|
                     (SPADCALL (CONS #'|CLIP;iClipParametric!0| $)
                               (SPADCALL (CONS #'|CLIP;iClipParametric!1| $)
                                         (SPADCALL |pointLists| (QREFELT $ 22))
                                         (QREFELT $ 24))
                               (QREFELT $ 26)))
               (EXIT
                (COND
                 ((NULL |sortedList|)
                  (VECTOR NIL (SPADCALL 0.0 0.0 (QREFELT $ 18))
                          (SPADCALL 0.0 0.0 (QREFELT $ 18))))
                 (#10#
                  (SEQ (LETT |n| (LENGTH |sortedList|))
                       (LETT |num| (SPADCALL |fraction| (QREFELT $ 28)))
                       (LETT |den| (SPADCALL |fraction| (QREFELT $ 29)))
                       (LETT |clipNum| (QUOTIENT2 (* |n| |num|) |den|))
                       (LETT |lastN| (- (- |n| 1) |clipNum|))
                       (LETT |firstPt| (|SPADfirst| |sortedList|))
                       (LETT |xMin| (SPADCALL |firstPt| (QREFELT $ 31)))
                       (LETT |xMax| (SPADCALL |firstPt| (QREFELT $ 31)))
                       (LETT |yMin| (SPADCALL |firstPt| (QREFELT $ 32)))
                       (LETT |yMax| (SPADCALL |firstPt| (QREFELT $ 32)))
                       (SEQ (LETT |pt| NIL) (LETT #9# (CDR |sortedList|))
                            (LETT |k| 0) (LETT #8# |lastN|) G190
                            (COND
                             ((OR (|greater_SI| |k| #8#) (ATOM #9#)
                                  (PROGN (LETT |pt| (CAR #9#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |xMin|
                                   (|min_DF| |xMin|
                                             (SPADCALL |pt| (QREFELT $ 31))))
                             (LETT |xMax|
                                   (|max_DF| |xMax|
                                             (SPADCALL |pt| (QREFELT $ 31))))
                             (LETT |yMin|
                                   (|min_DF| |yMin|
                                             (SPADCALL |pt| (QREFELT $ 32))))
                             (EXIT
                              (LETT |yMax|
                                    (|max_DF| |yMax|
                                              (SPADCALL |pt|
                                                        (QREFELT $ 32))))))
                            (LETT |k|
                                  (PROG1 (|inc_SI| |k|) (LETT #9# (CDR #9#))))
                            (GO G190) G191 (EXIT NIL))
                       (LETT |xDiff| (|sub_DF| |xMax| |xMin|))
                       (LETT |yDiff| (|sub_DF| |yMax| |yMin|))
                       (EXIT
                        (COND
                         ((|eql_DF| |xDiff| 0.0)
                          (COND
                           ((|eql_DF| |yDiff| 0.0)
                            (VECTOR |pointLists|
                                    (SPADCALL (|sub_DF| |xMin| 1.0)
                                              (|add_DF| |xMax| 1.0)
                                              (QREFELT $ 18))
                                    (SPADCALL (|sub_DF| |yMin| 1.0)
                                              (|add_DF| |yMax| 1.0)
                                              (QREFELT $ 18))))
                           (#10#
                            (VECTOR |pointLists|
                                    (SPADCALL (|sub_DF| |xMin| 1.0)
                                              (|add_DF| |xMax| 1.0)
                                              (QREFELT $ 18))
                                    (SPADCALL |yMin| |yMax| (QREFELT $ 18))))))
                         (#10#
                          (SEQ
                           (LETT |single_eps| (|expt_DF_I| (|mk_DF| 2 0) -19))
                           (COND
                            ((|less_DF| |yDiff| |single_eps|)
                             (SEQ
                              (LETT |yMin|
                                    (COND
                                     ((|less_DF| (|abs_DF| |yMin|) 1.0)
                                      (|sub_DF| |yMin| |single_eps|))
                                     ((|less_DF| |yMin| 0.0)
                                      (|mul_DF| |yMin|
                                                (|add_DF| 1.0 |single_eps|)))
                                     (#10#
                                      (|mul_DF| |yMin|
                                                (|sub_DF| 1.0 |single_eps|)))))
                              (EXIT
                               (LETT |yMax|
                                     (COND
                                      ((|less_DF| (|abs_DF| |yMax|) 1.0)
                                       (|add_DF| |yMax| |single_eps|))
                                      ((|less_DF| |yMax| 0.0)
                                       (|mul_DF| |yMax|
                                                 (|sub_DF| 1.0 |single_eps|)))
                                      (#10#
                                       (|mul_DF| |yMax|
                                                 (|add_DF| 1.0
                                                           |single_eps|)))))))))
                           (LETT |numm| (SPADCALL |scale| (QREFELT $ 28)))
                           (LETT |denn| (SPADCALL |scale| (QREFELT $ 29)))
                           (LETT |xMin|
                                 (|sub_DF| |xMin|
                                           (|div_DF|
                                            (|mul_DF|
                                             (FLOAT |numm|
                                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                             |xDiff|)
                                            (FLOAT |denn|
                                                   MOST-POSITIVE-DOUBLE-FLOAT))))
                           (LETT |xMax|
                                 (|add_DF| |xMax|
                                           (|div_DF|
                                            (|mul_DF|
                                             (FLOAT |numm|
                                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                             |xDiff|)
                                            (FLOAT |denn|
                                                   MOST-POSITIVE-DOUBLE-FLOAT))))
                           (LETT |yMin|
                                 (|sub_DF| |yMin|
                                           (|div_DF|
                                            (|mul_DF|
                                             (FLOAT |numm|
                                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                             |yDiff|)
                                            (FLOAT |denn|
                                                   MOST-POSITIVE-DOUBLE-FLOAT))))
                           (LETT |yMax|
                                 (|add_DF| |yMax|
                                           (|div_DF|
                                            (|mul_DF|
                                             (FLOAT |numm|
                                                    MOST-POSITIVE-DOUBLE-FLOAT)
                                             |yDiff|)
                                            (FLOAT |denn|
                                                   MOST-POSITIVE-DOUBLE-FLOAT))))
                           (LETT |newclip|
                                 (SPADCALL |pointLists| |xMin| |xMax| |yMin|
                                           |yMax| (QREFELT $ 35)))
                           (EXIT
                            (COND
                             ((> (LENGTH (QVELT |newclip| 0))
                                 (LENGTH |pointLists|))
                              |newclip|)
                             (#10#
                              (SEQ
                               (LETT |xs|
                                     (SPADCALL (ELT $ 31) |sortedList|
                                               (QREFELT $ 39)))
                               (LETT |ys|
                                     (SPADCALL (ELT $ 32) |sortedList|
                                               (QREFELT $ 39)))
                               (LETT |xMin|
                                     (SPADCALL (ELT $ 40) |xs| (QREFELT $ 42)))
                               (LETT |yMin|
                                     (SPADCALL (ELT $ 40) |ys| (QREFELT $ 42)))
                               (LETT |xMax|
                                     (SPADCALL (ELT $ 43) |xs| (QREFELT $ 42)))
                               (LETT |yMax|
                                     (SPADCALL (ELT $ 43) |ys| (QREFELT $ 42)))
                               (LETT |xseg|
                                     (SPADCALL |xMin| |xMax| (QREFELT $ 44)))
                               (LETT |yseg|
                                     (SPADCALL |yMin| |yMax| (QREFELT $ 44)))
                               (EXIT
                                (VECTOR |pointLists| |xseg|
                                        |yseg|)))))))))))))))))))))) 

(SDEFUN |CLIP;iClipParametric!1| ((|z| NIL) ($ NIL))
        (NULL (|CLIP;Pnan?| |z| $))) 

(SDEFUN |CLIP;iClipParametric!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (|CLIP;norm| |x| $) (|CLIP;norm| |y| $) (QREFELT $ 19))) 

(SDEFUN |CLIP;point|
        ((|xx| (|DoubleFloat|)) (|yy| #1=(|DoubleFloat|))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |xx| |yy|)) (QREFELT $ 45)))) 

(SDEFUN |CLIP;discardAndSplit|
        ((|pointList| (|List| (|Point| (|DoubleFloat|))))
         (|pred| (|Mapping| (|Boolean|) (|Point| (|DoubleFloat|))))
         (|xMin| (|DoubleFloat|)) (|xMax| (|DoubleFloat|))
         (|yMin| (|DoubleFloat|)) (|yMax| (|DoubleFloat|))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|list| (|List| (|Point| (|DoubleFloat|)))) (|lastPt?| (|Boolean|))
          (|lastPt| (|Point| (|DoubleFloat|)))
          (|ans| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|pt| (|Point| (|DoubleFloat|))))
         (SEQ (LETT |ans| NIL) (LETT |list| NIL) (LETT |lastPt?| NIL)
              (LETT |lastPt| (|CLIP;point| 0.0 0.0 $))
              (SEQ G190 (COND ((NULL (NULL (NULL |pointList|))) (GO G191)))
                   (SEQ (LETT |pt| (|SPADfirst| |pointList|))
                        (LETT |pointList| (CDR |pointList|))
                        (EXIT
                         (COND
                          ((SPADCALL |pt| |pred|)
                           (LETT |list| (CONS |pt| |list|)))
                          ('T
                           (SEQ
                            (COND
                             ((NULL (NULL |list|))
                              (LETT |ans| (CONS |list| |ans|))))
                            (LETT |lastPt| |pt|) (LETT |lastPt?| 'T)
                            (EXIT (LETT |list| NIL)))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND ((NULL |list|) |ans|)
                     ('T (NREVERSE (CONS (NREVERSE |list|) |ans|)))))))) 

(SDEFUN |CLIP;clip;P2FR;6|
        ((|plot| (|Plot|)) (|fraction| (|Fraction| (|Integer|)))
         (|scale| (|Fraction| (|Integer|)))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (SPROG
         ((|yMax| #1=(|DoubleFloat|)) (|yMin| #1#) (#2=#:G818 NIL) (|pt| NIL)
          (#3=#:G817 NIL) (|list| NIL)
          (|lists| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|xMax| (|DoubleFloat|)) (|xMin| (|DoubleFloat|))
          (|denn| #4=(|Integer|)) (|numm| #5=(|Integer|))
          (|yDiff| (|DoubleFloat|)) (|clipNum| (|Integer|)) (|den| #4#)
          (|num| #5#) (|n| (|NonNegativeInteger|))
          (|sortedList| (|List| (|Point| (|DoubleFloat|))))
          (|pointList| (|List| (|Point| (|DoubleFloat|))))
          (|pointLists| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|xVals| (|Segment| (|DoubleFloat|))))
         (SEQ
          (COND
           ((OR (SPADCALL |fraction| (|spadConstant| $ 13) (QREFELT $ 14))
                (SPADCALL |fraction| (SPADCALL 1 2 (QREFELT $ 46))
                          (QREFELT $ 16)))
            (|error| "clipDraw: fraction should be between 0 and 1/2"))
           ('T
            (SEQ (LETT |xVals| (SPADCALL |plot| (QREFELT $ 48)))
                 (EXIT
                  (COND
                   ((NULL (LETT |pointLists| (SPADCALL |plot| (QREFELT $ 49))))
                    (VECTOR NIL |xVals| (SPADCALL 0.0 0.0 (QREFELT $ 18))))
                   ((SPADCALL
                     (LETT |pointLists| (SPADCALL |plot| (QREFELT $ 49))) 1
                     (QREFELT $ 51))
                    (|error| "clipDraw: plot has more than one branch"))
                   ((NULL (LETT |pointList| (|SPADfirst| |pointLists|)))
                    (VECTOR NIL |xVals| (SPADCALL 0.0 0.0 (QREFELT $ 18))))
                   (#6='T
                    (SEQ
                     (LETT |sortedList|
                           (SPADCALL (CONS #'|CLIP;clip;P2FR;6!0| $)
                                     |pointList| (QREFELT $ 26)))
                     (LETT |n| (LENGTH |sortedList|))
                     (LETT |num| (SPADCALL |fraction| (QREFELT $ 28)))
                     (LETT |den| (SPADCALL |fraction| (QREFELT $ 29)))
                     (LETT |clipNum| (QUOTIENT2 (* |n| |num|) |den|))
                     (LETT |yMin|
                           (SPADCALL
                            (SPADCALL |sortedList| |clipNum| (QREFELT $ 52))
                            (QREFELT $ 32)))
                     (LETT |yMax|
                           (SPADCALL
                            (SPADCALL |sortedList| (- (- |n| 1) |clipNum|)
                                      (QREFELT $ 52))
                            (QREFELT $ 32)))
                     (COND ((|CLIP;Fnan?| |yMin| $) (LETT |yMin| 0.0)))
                     (COND ((|CLIP;Fnan?| |yMax| $) (LETT |yMax| 0.0)))
                     (LETT |yDiff| (|sub_DF| |yMax| |yMin|))
                     (EXIT
                      (COND
                       ((|eql_DF| |yDiff| 0.0)
                        (VECTOR |pointLists| (SPADCALL |plot| (QREFELT $ 48))
                                (SPADCALL (|sub_DF| |yMin| 1.0)
                                          (|add_DF| |yMax| 1.0)
                                          (QREFELT $ 18))))
                       (#6#
                        (SEQ (LETT |numm| (SPADCALL |scale| (QREFELT $ 28)))
                             (LETT |denn| (SPADCALL |scale| (QREFELT $ 29)))
                             (LETT |xMin| (SPADCALL |xVals| (QREFELT $ 53)))
                             (LETT |xMax| (SPADCALL |xVals| (QREFELT $ 54)))
                             (LETT |yMin|
                                   (|sub_DF| |yMin|
                                             (|div_DF|
                                              (|mul_DF|
                                               (FLOAT |numm|
                                                      MOST-POSITIVE-DOUBLE-FLOAT)
                                               |yDiff|)
                                              (FLOAT |denn|
                                                     MOST-POSITIVE-DOUBLE-FLOAT))))
                             (LETT |yMax|
                                   (|add_DF| |yMax|
                                             (|div_DF|
                                              (|mul_DF|
                                               (FLOAT |numm|
                                                      MOST-POSITIVE-DOUBLE-FLOAT)
                                               |yDiff|)
                                              (FLOAT |denn|
                                                     MOST-POSITIVE-DOUBLE-FLOAT))))
                             (LETT |lists|
                                   (|CLIP;discardAndSplit| |pointList|
                                    (CONS #'|CLIP;clip;P2FR;6!1|
                                          (VECTOR |yMin| |yMax| $))
                                    |xMin| |xMax| |yMin| |yMax| $))
                             (LETT |yMin|
                                   (SPADCALL
                                    (SPADCALL |sortedList| |clipNum|
                                              (QREFELT $ 52))
                                    (QREFELT $ 32)))
                             (LETT |yMax|
                                   (SPADCALL
                                    (SPADCALL |sortedList|
                                              (- (- |n| 1) |clipNum|)
                                              (QREFELT $ 52))
                                    (QREFELT $ 32)))
                             (COND ((|CLIP;Fnan?| |yMin| $) (LETT |yMin| 0.0)))
                             (COND ((|CLIP;Fnan?| |yMax| $) (LETT |yMax| 0.0)))
                             (SEQ (LETT |list| NIL) (LETT #3# |lists|) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |list| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SEQ (LETT |pt| NIL) (LETT #2# |list|) G190
                                         (COND
                                          ((OR (ATOM #2#)
                                               (PROGN
                                                (LETT |pt| (CAR #2#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((NULL
                                              (|CLIP;Fnan?|
                                               (SPADCALL |pt| (QREFELT $ 32))
                                               $))
                                             (SEQ
                                              (LETT |yMin|
                                                    (|min_DF| |yMin|
                                                              (SPADCALL |pt|
                                                                        (QREFELT
                                                                         $
                                                                         32))))
                                              (EXIT
                                               (LETT |yMax|
                                                     (|max_DF| |yMax|
                                                               (SPADCALL |pt|
                                                                         (QREFELT
                                                                          $
                                                                          32))))))))))
                                         (LETT #2# (CDR #2#)) (GO G190) G191
                                         (EXIT NIL))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (VECTOR |lists| |xVals|
                                      (SPADCALL |yMin| |yMax|
                                                (QREFELT $ 18)))))))))))))))))) 

(SDEFUN |CLIP;clip;P2FR;6!1| ((|x| NIL) ($$ NIL))
        (PROG ($ |yMax| |yMin|)
          (LETT $ (QREFELT $$ 2))
          (LETT |yMax| (QREFELT $$ 1))
          (LETT |yMin| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 32)) |yMax| (QREFELT $ 19))
              (SPADCALL (SPADCALL |x| (QREFELT $ 32)) |yMin| (QREFELT $ 55)))
             ('T NIL)))))) 

(SDEFUN |CLIP;clip;P2FR;6!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 32)) (SPADCALL |y| (QREFELT $ 32))
                  (QREFELT $ 19))) 

(SDEFUN |CLIP;clip;PR;7|
        ((|plot| (|Plot|))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (SPADCALL |plot| (SPADCALL 1 4 (QREFELT $ 46))
                  (SPADCALL 5 1 (QREFELT $ 46)) (QREFELT $ 56))) 

(SDEFUN |CLIP;norm| ((|pt| (|Point| (|DoubleFloat|))) ($ (|DoubleFloat|)))
        (SPROG
         ((|r| (|DoubleFloat|)) (|y| (|DoubleFloat|)) (|x| (|DoubleFloat|)))
         (SEQ (LETT |x| (SPADCALL |pt| (QREFELT $ 31)))
              (LETT |y| (SPADCALL |pt| (QREFELT $ 32)))
              (COND
               ((|CLIP;Fnan?| |x| $)
                (COND ((|CLIP;Fnan?| |y| $) (LETT |r| 0.0))
                      (#1='T (LETT |r| (SPADCALL |y| 2 (QREFELT $ 59))))))
               ((|CLIP;Fnan?| |y| $)
                (LETT |r| (SPADCALL |x| 2 (QREFELT $ 59))))
               (#1#
                (LETT |r|
                      (|add_DF| (SPADCALL |x| 2 (QREFELT $ 59))
                                (SPADCALL |y| 2 (QREFELT $ 59))))))
              (EXIT |r|)))) 

(SDEFUN |CLIP;findPt|
        ((|lists| (|List| (|List| (|Point| (|DoubleFloat|)))))
         ($ (|Union| (|Point| (|DoubleFloat|)) "failed")))
        (SPROG
         ((#1=#:G838 NIL) (#2=#:G837 NIL) (#3=#:G839 NIL) (#4=#:G841 NIL)
          (|p| NIL) (#5=#:G840 NIL) (|list| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |list| NIL) (LETT #5# |lists|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |list| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (NULL |list|))
                       (PROGN
                        (LETT #1#
                              (SEQ
                               (EXIT
                                (SEQ (LETT |p| NIL) (LETT #4# |list|) G190
                                     (COND
                                      ((OR (ATOM #4#)
                                           (PROGN (LETT |p| (CAR #4#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((NULL (|CLIP;Pnan?| |p| $))
                                         (PROGN
                                          (LETT #2#
                                                (PROGN
                                                 (LETT #3# (CONS 0 |p|))
                                                 (GO #6=#:G836)))
                                          (GO #7=#:G832))))))
                                     (LETT #4# (CDR #4#)) (GO G190) G191
                                     (EXIT NIL)))
                               #7# (EXIT #2#)))
                        (GO #8=#:G834))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL)))
             #8# (EXIT #1#))
            (EXIT (CONS 1 "failed"))))
          #6# (EXIT #3#)))) 

(SDEFUN |CLIP;clipWithRanges;L4DfR;10|
        ((|pointLists| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|xMin| (|DoubleFloat|)) (|xMax| (|DoubleFloat|))
         (|yMin| (|DoubleFloat|)) (|yMax| (|DoubleFloat|))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (SPROG
         ((#1=#:G879 NIL) (#2=#:G878 NIL) (|list| NIL)
          (|firstPt| (|Point| (|DoubleFloat|)))
          (|pt| (|Union| (|Point| (|DoubleFloat|)) "failed"))
          (|lists| (|List| (|List| (|Point| (|DoubleFloat|))))) (#3=#:G877 NIL)
          (|pointList| NIL))
         (SEQ (LETT |lists| NIL)
              (SEQ (LETT |pointList| NIL) (LETT #3# |pointLists|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |pointList| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |lists|
                           (SPADCALL |lists|
                                     (|CLIP;discardAndSplit| |pointList|
                                      (CONS #'|CLIP;clipWithRanges;L4DfR;10!0|
                                            (VECTOR |yMin| |yMax| |xMin| |xMax|
                                                    $))
                                      |xMin| |xMax| |yMin| |yMax| $)
                                     (QREFELT $ 62)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |pt| (|CLIP;findPt| |lists| $))
              (EXIT
               (COND
                ((QEQCAR |pt| 1)
                 (VECTOR NIL (SPADCALL 0.0 0.0 (QREFELT $ 18))
                         (SPADCALL 0.0 0.0 (QREFELT $ 18))))
                ('T
                 (SEQ (LETT |firstPt| (QCDR |pt|))
                      (LETT |xMin| (SPADCALL |firstPt| (QREFELT $ 31)))
                      (LETT |xMax| (SPADCALL |firstPt| (QREFELT $ 31)))
                      (LETT |yMin| (SPADCALL |firstPt| (QREFELT $ 32)))
                      (LETT |yMax| (SPADCALL |firstPt| (QREFELT $ 32)))
                      (SEQ (LETT |list| NIL) (LETT #2# |lists|) G190
                           (COND
                            ((OR (ATOM #2#)
                                 (PROGN (LETT |list| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (SEQ (LETT #1# |list|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |pt| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((NULL (|CLIP;Pnan?| |pt| $))
                                      (SEQ
                                       (LETT |xMin|
                                             (|min_DF| |xMin|
                                                       (SPADCALL |pt|
                                                                 (QREFELT $
                                                                          31))))
                                       (LETT |xMax|
                                             (|max_DF| |xMax|
                                                       (SPADCALL |pt|
                                                                 (QREFELT $
                                                                          31))))
                                       (LETT |yMin|
                                             (|min_DF| |yMin|
                                                       (SPADCALL |pt|
                                                                 (QREFELT $
                                                                          32))))
                                       (EXIT
                                        (LETT |yMax|
                                              (|max_DF| |yMax|
                                                        (SPADCALL |pt|
                                                                  (QREFELT $
                                                                           32))))))))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (VECTOR |lists| (SPADCALL |xMin| |xMax| (QREFELT $ 18))
                               (SPADCALL |yMin| |yMax| (QREFELT $ 18))))))))))) 

(SDEFUN |CLIP;clipWithRanges;L4DfR;10!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |xMax| |xMin| |yMax| |yMin|)
          (LETT $ (QREFELT $$ 4))
          (LETT |xMax| (QREFELT $$ 3))
          (LETT |xMin| (QREFELT $$ 2))
          (LETT |yMax| (QREFELT $$ 1))
          (LETT |yMin| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 31)) |xMax| (QREFELT $ 60))
              (COND
               ((SPADCALL (SPADCALL |x| (QREFELT $ 31)) |xMin| (QREFELT $ 61))
                (COND
                 ((SPADCALL (SPADCALL |x| (QREFELT $ 32)) |yMax|
                            (QREFELT $ 60))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 32)) |yMin|
                            (QREFELT $ 61)))
                 ('T NIL)))
               ('T NIL)))
             ('T NIL)))))) 

(SDEFUN |CLIP;clipParametric;P2FR;11|
        ((|plot| (|Plot|)) (|fraction| (|Fraction| (|Integer|)))
         (|scale| (|Fraction| (|Integer|)))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (|CLIP;iClipParametric| (SPADCALL |plot| (QREFELT $ 49)) |fraction|
         |scale| $)) 

(SDEFUN |CLIP;clipParametric;PR;12|
        ((|plot| (|Plot|))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (SPADCALL |plot| (SPADCALL 1 2 (QREFELT $ 46))
                  (SPADCALL 5 1 (QREFELT $ 46)) (QREFELT $ 63))) 

(SDEFUN |CLIP;clip;LR;13|
        ((|l| (|List| (|Point| (|DoubleFloat|))))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (|CLIP;iClipParametric| (SPADCALL |l| (QREFELT $ 65))
         (SPADCALL 1 2 (QREFELT $ 46)) (SPADCALL 5 1 (QREFELT $ 46)) $)) 

(SDEFUN |CLIP;clip;LR;14|
        ((|l| (|List| (|List| (|Point| (|DoubleFloat|)))))
         ($
          (|Record| (|:| |brans| (|List| (|List| (|Point| (|DoubleFloat|)))))
                    (|:| |xValues| (|Segment| (|DoubleFloat|)))
                    (|:| |yValues| (|Segment| (|DoubleFloat|))))))
        (|CLIP;iClipParametric| |l| (SPADCALL 1 2 (QREFELT $ 46))
         (SPADCALL 5 1 (QREFELT $ 46)) $)) 

(DECLAIM (NOTINLINE |TwoDimensionalPlotClipping;|)) 

(DEFUN |TwoDimensionalPlotClipping| ()
  (SPROG NIL
         (PROG (#1=#:G889)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|TwoDimensionalPlotClipping|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|TwoDimensionalPlotClipping|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|TwoDimensionalPlotClipping;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|TwoDimensionalPlotClipping|)))))))))) 

(DEFUN |TwoDimensionalPlotClipping;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TwoDimensionalPlotClipping|))
          (LETT $ (GETREFV 68))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TwoDimensionalPlotClipping| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TwoDimensionalPlotClipping| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) (|DoubleFloat|) (0 . ~=)
              (|Mapping| 6 7) (|Point| 7) (6 . |any?|) (|Fraction| 27)
              (12 . |Zero|) (16 . <) (22 . |One|) (26 . >) (|Segment| 7)
              (32 . |segment|) (38 . <) (|List| $) (|List| 10) (44 . |concat|)
              (|Mapping| 6 10) (49 . |select|) (|Mapping| 6 10 10)
              (55 . |sort|) (|Integer|) (61 . |numer|) (66 . |denom|)
              (|PointPackage| 7) (71 . |xCoord|) (76 . |yCoord|)
              (|Record| (|:| |brans| 34) (|:| |xValues| 17) (|:| |yValues| 17))
              (|List| 21) |CLIP;clipWithRanges;L4DfR;10| (|List| 7)
              (|Mapping| 7 10) (|ListFunctions2| 10 7) (81 . |map|)
              (87 . |min|) (|Mapping| 7 7 7) (93 . |reduce|) (99 . |max|)
              (105 . SEGMENT) (111 . |point|) (116 . /) (|Plot|)
              (122 . |xRange|) (127 . |listBranches|) (|NonNegativeInteger|)
              (132 . |more?|) (138 . |elt|) (144 . |low|) (149 . |high|)
              (154 . >) |CLIP;clip;P2FR;6| |CLIP;clip;PR;7| (|PositiveInteger|)
              (160 . ^) (166 . <=) (172 . >=) (178 . |concat|)
              |CLIP;clipParametric;P2FR;11| |CLIP;clipParametric;PR;12|
              (184 . |list|) |CLIP;clip;LR;13| |CLIP;clip;LR;14|)
           '#(|clipWithRanges| 189 |clipParametric| 198 |clip| 210) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|clip|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|Plot|)))
                                T)
                              '((|clip|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|Plot|) (|Fraction| (|Integer|))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|clipParametric|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|Plot|)))
                                T)
                              '((|clipParametric|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|Plot|) (|Fraction| (|Integer|))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|clipWithRanges|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|List| (|List| (|Point| (|DoubleFloat|))))
                                  (|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|) (|DoubleFloat|)))
                                T)
                              '((|clip|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|List| (|Point| (|DoubleFloat|)))))
                                T)
                              '((|clip|
                                 ((|Record|
                                   (|:| |brans|
                                        (|List|
                                         (|List| (|Point| (|DoubleFloat|)))))
                                   (|:| |xValues| (|Segment| (|DoubleFloat|)))
                                   (|:| |yValues| (|Segment| (|DoubleFloat|))))
                                  (|List| (|List| (|Point| (|DoubleFloat|))))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 67
                                            '(2 7 6 0 0 8 2 10 6 9 0 11 0 12 0
                                              13 2 12 6 0 0 14 0 12 0 15 2 12 6
                                              0 0 16 2 17 0 7 7 18 2 7 6 0 0 19
                                              1 21 0 20 22 2 21 0 23 0 24 2 21
                                              0 25 0 26 1 12 27 0 28 1 12 27 0
                                              29 1 30 7 10 31 1 30 7 10 32 2 38
                                              36 37 21 39 2 7 0 0 0 40 2 36 7
                                              41 0 42 2 7 0 0 0 43 2 17 0 7 7
                                              44 1 10 0 36 45 2 12 0 27 27 46 1
                                              47 17 0 48 1 47 34 0 49 2 34 6 0
                                              50 51 2 21 10 0 27 52 1 17 7 0 53
                                              1 17 7 0 54 2 7 6 0 0 55 2 7 0 0
                                              58 59 2 7 6 0 0 60 2 7 6 0 0 61 2
                                              34 0 0 0 62 1 34 0 21 65 5 0 33
                                              34 7 7 7 7 35 1 0 33 47 64 3 0 33
                                              47 12 12 63 1 0 33 47 57 3 0 33
                                              47 12 12 56 1 0 33 34 67 1 0 33
                                              21 66)))))
           '|lookupComplete|)) 

(MAKEPROP '|TwoDimensionalPlotClipping| 'NILADIC T) 
