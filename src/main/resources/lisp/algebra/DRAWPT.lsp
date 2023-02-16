
(SDEFUN |DRAWPT;draw;LLTdv;1|
        ((|lp| (|List| (|Point| (|DoubleFloat|))))
         (|l| (|List| (|DrawOption|))) ($ (|TwoDimensionalViewport|)))
        (SPADCALL (SPADCALL (LIST |lp|) (QREFELT $ 8)) |l| (QREFELT $ 11))) 

(SDEFUN |DRAWPT;draw;LTdv;2|
        ((|lp| (|List| (|Point| (|DoubleFloat|))))
         ($ (|TwoDimensionalViewport|)))
        (SPADCALL |lp| NIL (QREFELT $ 13))) 

(SDEFUN |DRAWPT;draw;2LLTdv;3|
        ((|lx| (|List| (|DoubleFloat|))) (|ly| (|List| (|DoubleFloat|)))
         (|l| (|List| (|DrawOption|))) ($ (|TwoDimensionalViewport|)))
        (SPROG
         ((#1=#:G706 NIL) (|x| NIL) (#2=#:G707 NIL) (|y| NIL) (#3=#:G705 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #3# NIL)
            (SEQ (LETT |y| NIL) (LETT #2# |ly|) (LETT |x| NIL) (LETT #1# |lx|)
                 G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL) (ATOM #2#)
                       (PROGN (LETT |y| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #3#
                         (CONS (SPADCALL (LIST |x| |y|) (QREFELT $ 17)) #3#))))
                 (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                 G191 (EXIT (NREVERSE #3#))))
           |l| (QREFELT $ 13))))) 

(SDEFUN |DRAWPT;draw;2LTdv;4|
        ((|lx| (|List| (|DoubleFloat|))) (|ly| (|List| (|DoubleFloat|)))
         ($ (|TwoDimensionalViewport|)))
        (SPADCALL |lx| |ly| NIL (QREFELT $ 18))) 

(SDEFUN |DRAWPT;draw;3LTdv;5|
        ((|x| (|List| (|DoubleFloat|))) (|y| (|List| (|DoubleFloat|)))
         (|z| (|List| (|DoubleFloat|))) ($ (|ThreeDimensionalViewport|)))
        (SPADCALL |x| |y| |z| NIL (QREFELT $ 21))) 

(SDEFUN |DRAWPT;draw;3LLTdv;6|
        ((|x| (|List| (|DoubleFloat|))) (|y| (|List| (|DoubleFloat|)))
         (|z| (|List| (|DoubleFloat|))) (|l| (|List| (|DrawOption|)))
         ($ (|ThreeDimensionalViewport|)))
        (SPROG
         ((|points| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|row| (|List| (|Point| (|DoubleFloat|)))) (|zval| (|Integer|))
          (|i| NIL) (|j| NIL) (|zLen| (|Integer|)) (|n| (|Integer|))
          (|m| (|Integer|)))
         (SEQ (LETT |m| (LENGTH |x|))
              (EXIT
               (COND ((ZEROP |m|) (|error| "No X values"))
                     (#1='T
                      (SEQ (LETT |n| (LENGTH |y|))
                           (EXIT
                            (COND ((ZEROP |n|) (|error| "No Y values"))
                                  (#1#
                                   (SEQ (LETT |zLen| (LENGTH |z|))
                                        (EXIT
                                         (COND
                                          ((SPADCALL |zLen| (* |m| |n|)
                                                     (QREFELT $ 25))
                                           (COND
                                            ((> |zLen| (* |m| |n|))
                                             (|error|
                                              "Too many Z-values to fit grid"))
                                            (#1#
                                             (|error|
                                              "Not enough Z-values to fit grid"))))
                                          (#1#
                                           (SEQ (LETT |points| NIL)
                                                (SEQ (LETT |j| |n|) G190
                                                     (COND
                                                      ((< |j| 1) (GO G191)))
                                                     (SEQ (LETT |row| NIL)
                                                          (SEQ (LETT |i| |m|)
                                                               G190
                                                               (COND
                                                                ((< |i| 1)
                                                                 (GO G191)))
                                                               (SEQ
                                                                (LETT |zval|
                                                                      (+
                                                                       (*
                                                                        (- |j|
                                                                           1)
                                                                        |m|)
                                                                       |i|))
                                                                (EXIT
                                                                 (LETT |row|
                                                                       (CONS
                                                                        (SPADCALL
                                                                         (LIST
                                                                          (SPADCALL
                                                                           |x|
                                                                           |i|
                                                                           (QREFELT
                                                                            $
                                                                            27))
                                                                          (SPADCALL
                                                                           |y|
                                                                           |j|
                                                                           (QREFELT
                                                                            $
                                                                            27))
                                                                          (SPADCALL
                                                                           |z|
                                                                           |zval|
                                                                           (QREFELT
                                                                            $
                                                                            27))
                                                                          (SPADCALL
                                                                           |z|
                                                                           |zval|
                                                                           (QREFELT
                                                                            $
                                                                            27)))
                                                                         (QREFELT
                                                                          $
                                                                          17))
                                                                        |row|))))
                                                               (LETT |i|
                                                                     (+ |i|
                                                                        -1))
                                                               (GO G190) G191
                                                               (EXIT NIL))
                                                          (EXIT
                                                           (LETT |points|
                                                                 (CONS |row|
                                                                       |points|))))
                                                     (LETT |j| (+ |j| -1))
                                                     (GO G190) G191 (EXIT NIL))
                                                (EXIT
                                                 (SPADCALL
                                                  (SPADCALL |points|
                                                            (QREFELT $ 29))
                                                  |l|
                                                  (QREFELT $
                                                           30)))))))))))))))))) 

(DECLAIM (NOTINLINE |TopLevelDrawFunctionsForPoints;|)) 

(DEFUN |TopLevelDrawFunctionsForPoints| ()
  (SPROG NIL
         (PROG (#1=#:G742)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|TopLevelDrawFunctionsForPoints|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|TopLevelDrawFunctionsForPoints|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|TopLevelDrawFunctionsForPoints;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|TopLevelDrawFunctionsForPoints|)))))))))) 

(DEFUN |TopLevelDrawFunctionsForPoints;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TopLevelDrawFunctionsForPoints|))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TopLevelDrawFunctionsForPoints| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TopLevelDrawFunctionsForPoints| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| 12) (|GraphImage|)
              (0 . |makeGraphImage|) (|List| (|DrawOption|))
              (|TwoDimensionalViewport|) (5 . |makeViewport2D|) (|List| 16)
              |DRAWPT;draw;LLTdv;1| |DRAWPT;draw;LTdv;2| (|List| 26)
              (|Point| 26) (11 . |point|) |DRAWPT;draw;2LLTdv;3|
              |DRAWPT;draw;2LTdv;4| (|ThreeDimensionalViewport|)
              |DRAWPT;draw;3LLTdv;6| |DRAWPT;draw;3LTdv;5| (|Boolean|)
              (|Integer|) (16 . ~=) (|DoubleFloat|) (22 . |elt|)
              (|ThreeSpace| 26) (28 . |mesh|) (33 . |makeViewport3D|))
           '#(|draw| 39) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|List| (|Point| (|DoubleFloat|)))))
                                T)
                              '((|draw|
                                 ((|TwoDimensionalViewport|)
                                  (|List| (|Point| (|DoubleFloat|)))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|))))
                                T)
                              '((|draw|
                                 ((|ThreeDimensionalViewport|)
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(1 7 0 6 8 2 10 0 7 9 11 1 16 0 15
                                              17 2 24 23 0 0 25 2 15 26 0 24 27
                                              1 28 0 6 29 2 20 0 28 9 30 2 0 10
                                              15 15 19 1 0 10 12 14 3 0 10 15
                                              15 9 18 2 0 10 12 9 13 4 0 20 15
                                              15 15 9 21 3 0 20 15 15 15
                                              22)))))
           '|lookupComplete|)) 

(MAKEPROP '|TopLevelDrawFunctionsForPoints| 'NILADIC T) 
