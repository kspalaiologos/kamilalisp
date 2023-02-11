
(SDEFUN |DRAWCX;makeArrow|
        ((|p1| (|Point| (|DoubleFloat|))) (|p2| (|Point| (|DoubleFloat|)))
         (|len| (|DoubleFloat|)) (|arg| (|DoubleFloat|))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|p4| #1=(|Point| (|DoubleFloat|))) (|p3| #1#)
          (|s2| #2=(|DoubleFloat|)) (|c2| #3=(|DoubleFloat|)) (|s1| #2#)
          (|c1| #3#))
         (SEQ (LETT |c1| (|cos_DF| (|add_DF| |arg| (QREFELT $ 7))))
              (LETT |s1| (|sin_DF| (|add_DF| |arg| (QREFELT $ 7))))
              (LETT |c2| (|cos_DF| (|sub_DF| |arg| (QREFELT $ 7))))
              (LETT |s2| (|sin_DF| (|sub_DF| |arg| (QREFELT $ 7))))
              (LETT |p3|
                    (SPADCALL
                     (LIST
                      (|add_DF| (SPADCALL |p2| 1 (QREFELT $ 14))
                                (|mul_DF| (|mul_DF| |c1| (QREFELT $ 6)) |len|))
                      (|add_DF| (SPADCALL |p2| 2 (QREFELT $ 14))
                                (|mul_DF| (|mul_DF| |s1| (QREFELT $ 6)) |len|))
                      (SPADCALL |p2| 3 (QREFELT $ 14))
                      (SPADCALL |p2| 4 (QREFELT $ 14)))
                     (QREFELT $ 16)))
              (LETT |p4|
                    (SPADCALL
                     (LIST
                      (|add_DF| (SPADCALL |p2| 1 (QREFELT $ 14))
                                (|mul_DF| (|mul_DF| |c2| (QREFELT $ 6)) |len|))
                      (|add_DF| (SPADCALL |p2| 2 (QREFELT $ 14))
                                (|mul_DF| (|mul_DF| |s2| (QREFELT $ 6)) |len|))
                      (SPADCALL |p2| 3 (QREFELT $ 14))
                      (SPADCALL |p2| 4 (QREFELT $ 14)))
                     (QREFELT $ 16)))
              (EXIT (LIST (LIST |p1| |p2| |p3|) (LIST |p2| |p4|)))))) 

(SDEFUN |DRAWCX;clipFun| ((|x| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (|min_DF| (|max_DF| |x| (|minus_DF| (QREFELT $ 10))) (QREFELT $ 10))) 

(SDEFUN |DRAWCX;drawComplex;M2SBTdv;3|
        ((|f|
          (|Mapping| #1=(|Complex| (|DoubleFloat|))
                     (|Complex| (|DoubleFloat|))))
         (|realRange| (|Segment| (|DoubleFloat|)))
         (|imagRange| (|Segment| (|DoubleFloat|))) (|arrows?| (|Boolean|))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG
         ((|real| #2=(|DoubleFloat|)) (|imag| #2#) (#3=#:G751 NIL) (|a| NIL)
          (|arrow| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|p2| #4=(|Point| (|DoubleFloat|))) (|len| (|DoubleFloat|))
          (|p1| #4#) (|arg| (|DoubleFloat|)) (#5=#:G750 NIL) (|j| NIL)
          (#6=#:G749 NIL) (|i| NIL) (|space| (|ThreeSpace| (|DoubleFloat|)))
          (|llp| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|lp| (|List| (|Point| (|DoubleFloat|)))) (|p| #4#) (#7=#:G748 NIL)
          (#8=#:G747 NIL) (|z| #1#) (#9=#:G746 NIL) (#10=#:G745 NIL)
          (|funTable|
           (|TwoDimensionalArray|
            (|Record| (|:| |rr| (|DoubleFloat|)) (|:| |th| (|DoubleFloat|)))))
          (#11=#:G711 NIL) (#12=#:G709 NIL) (|delImag| #13=(|DoubleFloat|))
          (|delReal| #13#))
         (SEQ
          (LETT |delReal|
                (|div_DF|
                 (|sub_DF| (SPADCALL |realRange| (QREFELT $ 18))
                           (SPADCALL |realRange| (QREFELT $ 19)))
                 (FLOAT (QREFELT $ 8) MOST-POSITIVE-DOUBLE-FLOAT)))
          (LETT |delImag|
                (|div_DF|
                 (|sub_DF| (SPADCALL |imagRange| (QREFELT $ 18))
                           (SPADCALL |imagRange| (QREFELT $ 19)))
                 (FLOAT (QREFELT $ 9) MOST-POSITIVE-DOUBLE-FLOAT)))
          (LETT |funTable|
                (MAKE_MATRIX1
                 (+
                  (PROG1 (LETT #12# (QREFELT $ 8))
                    (|check_subtype2| (>= #12# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #12#))
                  1)
                 (+
                  (PROG1 (LETT #11# (QREFELT $ 9))
                    (|check_subtype2| (>= #11# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #11#))
                  1)
                 (CONS 0.0 0.0)))
          (LETT |real| (SPADCALL |realRange| (QREFELT $ 19)))
          (SEQ (LETT |i| 1) (LETT #10# (+ (QREFELT $ 8) 1)) G190
               (COND ((|greater_SI| |i| #10#) (GO G191)))
               (SEQ (LETT |imag| (SPADCALL |imagRange| (QREFELT $ 19)))
                    (SEQ (LETT |j| 1) (LETT #9# (+ (QREFELT $ 9) 1)) G190
                         (COND ((|greater_SI| |j| #9#) (GO G191)))
                         (SEQ
                          (LETT |z|
                                (SPADCALL
                                 (SPADCALL |real| |imag| (QREFELT $ 21)) |f|))
                          (SPADCALL |funTable| |i| |j|
                                    (CONS
                                     (|DRAWCX;clipFun|
                                      (SPADCALL (SPADCALL |z| (QREFELT $ 22))
                                                (QREFELT $ 23))
                                      $)
                                     (SPADCALL |z| (QREFELT $ 24)))
                                    (QREFELT $ 27))
                          (EXIT (LETT |imag| (|add_DF| |imag| |delImag|))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |real| (|add_DF| |real| |delReal|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |llp| NIL) (LETT |real| (SPADCALL |realRange| (QREFELT $ 19)))
          (SEQ (LETT |i| 1) (LETT #8# (+ (QREFELT $ 8) 1)) G190
               (COND ((|greater_SI| |i| #8#) (GO G191)))
               (SEQ (LETT |imag| (SPADCALL |imagRange| (QREFELT $ 19)))
                    (LETT |lp| NIL)
                    (SEQ (LETT |j| 1) (LETT #7# (+ (QREFELT $ 9) 1)) G190
                         (COND ((|greater_SI| |j| #7#) (GO G191)))
                         (SEQ
                          (LETT |p|
                                (SPADCALL
                                 (LIST |real| |imag|
                                       (QCAR
                                        (SPADCALL |funTable| |i| |j|
                                                  (QREFELT $ 28)))
                                       (QCDR
                                        (SPADCALL |funTable| |i| |j|
                                                  (QREFELT $ 28))))
                                 (QREFELT $ 16)))
                          (LETT |lp| (CONS |p| |lp|))
                          (EXIT (LETT |imag| (|add_DF| |imag| |delImag|))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (LETT |real| (|add_DF| |real| |delReal|))
                    (EXIT (LETT |llp| (CONS |lp| |llp|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |space| (SPADCALL |llp| (QREFELT $ 31)))
          (COND
           (|arrows?|
            (SEQ (LETT |real| (SPADCALL |realRange| (QREFELT $ 19)))
                 (EXIT
                  (SEQ (LETT |i| 1) (LETT #6# (+ (QREFELT $ 8) 1)) G190
                       (COND ((|greater_SI| |i| #6#) (GO G191)))
                       (SEQ (LETT |imag| (SPADCALL |imagRange| (QREFELT $ 19)))
                            (SEQ (LETT |j| 1) (LETT #5# (+ (QREFELT $ 9) 1))
                                 G190 (COND ((|greater_SI| |j| #5#) (GO G191)))
                                 (SEQ
                                  (LETT |arg|
                                        (QCDR
                                         (SPADCALL |funTable| |i| |j|
                                                   (QREFELT $ 28))))
                                  (LETT |p1|
                                        (SPADCALL
                                         (LIST |real| |imag|
                                               (QCAR
                                                (SPADCALL |funTable| |i| |j|
                                                          (QREFELT $ 28)))
                                               |arg|)
                                         (QREFELT $ 16)))
                                  (LETT |len|
                                        (|mul_DF| |delReal| (|mk_DF| 2 0)))
                                  (LETT |p2|
                                        (SPADCALL
                                         (LIST
                                          (|add_DF|
                                           (SPADCALL |p1| 1 (QREFELT $ 14))
                                           (|mul_DF| |len| (|cos_DF| |arg|)))
                                          (|add_DF|
                                           (SPADCALL |p1| 2 (QREFELT $ 14))
                                           (|mul_DF| |len| (|sin_DF| |arg|)))
                                          (SPADCALL |p1| 3 (QREFELT $ 14))
                                          (SPADCALL |p1| 4 (QREFELT $ 14)))
                                         (QREFELT $ 16)))
                                  (LETT |arrow|
                                        (|DRAWCX;makeArrow| |p1| |p2| |len|
                                         |arg| $))
                                  (SEQ (LETT |a| NIL) (LETT #3# |arrow|) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN (LETT |a| (CAR #3#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SPADCALL |space| |a|
                                                   (QREFELT $ 33))))
                                       (LETT #3# (CDR #3#)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT
                                   (LETT |imag| (|add_DF| |imag| |delImag|))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT (LETT |real| (|add_DF| |real| |delReal|))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))))))
          (EXIT (SPADCALL |space| "Complex Function" (QREFELT $ 36)))))) 

(SDEFUN |DRAWCX;drawComplexVectorField;M2STdv;4|
        ((|f|
          (|Mapping| #1=(|Complex| (|DoubleFloat|))
                     (|Complex| (|DoubleFloat|))))
         (|realRange| (|Segment| (|DoubleFloat|)))
         (|imagRange| (|Segment| (|DoubleFloat|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG
         ((|real| #2=(|DoubleFloat|)) (|imag| #2#) (#3=#:G764 NIL) (|a| NIL)
          (|arrow| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|p2| #4=(|Point| (|DoubleFloat|))) (|scaleLen| (|DoubleFloat|))
          (|p1| #4#) (|len| (|DoubleFloat|)) (|arg| (|DoubleFloat|)) (|z| #1#)
          (#5=#:G763 NIL) (|j| NIL) (#6=#:G762 NIL) (|i| NIL)
          (|space| (|ThreeSpace| (|DoubleFloat|)))
          (|delImag| #7=(|DoubleFloat|)) (|delReal| #7#))
         (SEQ
          (LETT |delReal|
                (|div_DF|
                 (|sub_DF| (SPADCALL |realRange| (QREFELT $ 18))
                           (SPADCALL |realRange| (QREFELT $ 19)))
                 (FLOAT (QREFELT $ 8) MOST-POSITIVE-DOUBLE-FLOAT)))
          (LETT |delImag|
                (|div_DF|
                 (|sub_DF| (SPADCALL |imagRange| (QREFELT $ 18))
                           (SPADCALL |imagRange| (QREFELT $ 19)))
                 (FLOAT (QREFELT $ 9) MOST-POSITIVE-DOUBLE-FLOAT)))
          (LETT |space| (SPADCALL (QREFELT $ 40)))
          (LETT |real| (SPADCALL |realRange| (QREFELT $ 19)))
          (SEQ (LETT |i| 1) (LETT #6# (+ (QREFELT $ 8) 1)) G190
               (COND ((|greater_SI| |i| #6#) (GO G191)))
               (SEQ (LETT |imag| (SPADCALL |imagRange| (QREFELT $ 19)))
                    (SEQ (LETT |j| 1) (LETT #5# (+ (QREFELT $ 9) 1)) G190
                         (COND ((|greater_SI| |j| #5#) (GO G191)))
                         (SEQ
                          (LETT |z|
                                (SPADCALL
                                 (SPADCALL |real| |imag| (QREFELT $ 21)) |f|))
                          (LETT |arg| (SPADCALL |z| (QREFELT $ 24)))
                          (LETT |len|
                                (|DRAWCX;clipFun|
                                 (SPADCALL (SPADCALL |z| (QREFELT $ 22))
                                           (QREFELT $ 23))
                                 $))
                          (LETT |p1|
                                (SPADCALL (LIST |real| |imag| 0.0 |arg|)
                                          (QREFELT $ 16)))
                          (LETT |scaleLen| (|mul_DF| |delReal| |len|))
                          (LETT |p2|
                                (SPADCALL
                                 (LIST
                                  (|add_DF| (SPADCALL |p1| 1 (QREFELT $ 14))
                                            (|mul_DF| |scaleLen|
                                                      (|cos_DF| |arg|)))
                                  (|add_DF| (SPADCALL |p1| 2 (QREFELT $ 14))
                                            (|mul_DF| |scaleLen|
                                                      (|sin_DF| |arg|)))
                                  0.0 |arg|)
                                 (QREFELT $ 16)))
                          (LETT |arrow|
                                (|DRAWCX;makeArrow| |p1| |p2| |scaleLen| |arg|
                                 $))
                          (SEQ (LETT |a| NIL) (LETT #3# |arrow|) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |a| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT (SPADCALL |space| |a| (QREFELT $ 33))))
                               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                          (EXIT (LETT |imag| (|add_DF| |imag| |delImag|))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |real| (|add_DF| |real| |delReal|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |space| "Complex Vector Field" (QREFELT $ 36)))))) 

(SDEFUN |DRAWCX;setRealSteps;2I;5| ((|n| (|Integer|)) ($ (|Integer|)))
        (SETELT $ 8 |n|)) 

(SDEFUN |DRAWCX;setImagSteps;2I;6| ((|n| (|Integer|)) ($ (|Integer|)))
        (SETELT $ 9 |n|)) 

(SDEFUN |DRAWCX;setClipValue;2Df;7|
        ((|clip| (|DoubleFloat|)) ($ (|DoubleFloat|))) (SETELT $ 10 |clip|)) 

(DECLAIM (NOTINLINE |DrawComplex;|)) 

(DEFUN |DrawComplex| ()
  (SPROG NIL
         (PROG (#1=#:G769)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|DrawComplex|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DrawComplex|
                             (LIST (CONS NIL (CONS 1 (|DrawComplex;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|DrawComplex|)))))))))) 

(DEFUN |DrawComplex;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DrawComplex|))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DrawComplex| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|mk_DF| 125 -3))
          (QSETREFV $ 7
                    (|sub_DF| (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT)
                              (|div_DF| (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT)
                                        (FLOAT 20
                                               MOST-POSITIVE-DOUBLE-FLOAT))))
          (QSETREFV $ 8 11)
          (QSETREFV $ 9 11)
          (QSETREFV $ 10 (FLOAT 10 MOST-POSITIVE-DOUBLE-FLOAT))
          $))) 

(MAKEPROP '|DrawComplex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|arrowScale| '|arrowAngle| '|realSteps|
              '|imagSteps| '|clipValue| (|DoubleFloat|) (|Integer|)
              (|Point| 11) (0 . |elt|) (|List| 11) (6 . |point|) (|Segment| 11)
              (11 . |high|) (16 . |low|) (|Complex| 11) (21 . |complex|)
              (27 . |norm|) (32 . |sqrt|) (37 . |argument|)
              (|Record| (|:| |rr| 11) (|:| |th| 11)) (|TwoDimensionalArray| 25)
              (42 . |setelt!|) (50 . |elt|) (|List| 32) (|ThreeSpace| 11)
              (57 . |mesh|) (|List| 13) (62 . |curve|) (|String|)
              (|ThreeDimensionalViewport|) (68 . |makeViewport3D|)
              (|Mapping| 20 20) (|Boolean|) |DRAWCX;drawComplex;M2SBTdv;3|
              (74 . |create3Space|) |DRAWCX;drawComplexVectorField;M2STdv;4|
              |DRAWCX;setRealSteps;2I;5| |DRAWCX;setImagSteps;2I;6|
              |DRAWCX;setClipValue;2Df;7|)
           '#(|setRealSteps| 78 |setImagSteps| 83 |setClipValue| 88
              |drawComplexVectorField| 93 |drawComplex| 100)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|drawComplex|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|Complex| (|DoubleFloat|))
                                             (|Complex| (|DoubleFloat|)))
                                  (|Segment| (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|)) (|Boolean|)))
                                T)
                              '((|drawComplexVectorField|
                                 ((|ThreeDimensionalViewport|)
                                  (|Mapping| (|Complex| (|DoubleFloat|))
                                             (|Complex| (|DoubleFloat|)))
                                  (|Segment| (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))))
                                T)
                              '((|setRealSteps| ((|Integer|) (|Integer|))) T)
                              '((|setImagSteps| ((|Integer|) (|Integer|))) T)
                              '((|setClipValue|
                                 ((|DoubleFloat|) (|DoubleFloat|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(2 13 11 0 12 14 1 13 0 15 16 1 17
                                              11 0 18 1 17 11 0 19 2 20 0 11 11
                                              21 1 20 11 0 22 1 11 0 0 23 1 20
                                              11 0 24 4 26 25 0 12 12 25 27 3
                                              26 25 0 12 12 28 1 30 0 29 31 2
                                              30 0 0 32 33 2 35 0 30 34 36 0 30
                                              0 40 1 0 12 12 42 1 0 12 12 43 1
                                              0 11 11 44 3 0 35 37 17 17 41 4 0
                                              35 37 17 17 38 39)))))
           '|lookupComplete|)) 

(MAKEPROP '|DrawComplex| 'NILADIC T) 
