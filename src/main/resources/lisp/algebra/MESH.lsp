
(SDEFUN |MESH;makePt|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) (|z| (|DoubleFloat|))
         (|c| #1=(|DoubleFloat|)) ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |x| |y| |z| |c|)) (QREFELT $ 8)))) 

(SDEFUN |MESH;ptFunc;3MMM;2|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|g| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|h| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|c|
          (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                     (|DoubleFloat|)))
         ($
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|))))
        (SPROG NIL
               (SEQ
                (CONS #'|MESH;ptFunc;3MMM;2!0| (VECTOR $ |c| |h| |g| |f|))))) 

(SDEFUN |MESH;ptFunc;3MMM;2!0| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|f| |g| |h| |c| $)
          (LETT |f| (QREFELT $$ 4))
          (LETT |g| (QREFELT $$ 3))
          (LETT |h| (QREFELT $$ 2))
          (LETT |c| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|z| NIL) (|y| NIL) (|x| NIL))
                   (SEQ (LETT |x| (SPADCALL |z1| |z2| |f|))
                        (LETT |y| (SPADCALL |z1| |z2| |g|))
                        (LETT |z| (SPADCALL |z1| |z2| |h|))
                        (EXIT
                         (|MESH;makePt| |x| |y| |z| (SPADCALL |x| |y| |z| |c|)
                          $)))))))) 

(SDEFUN |MESH;meshPar2Var;TsM2SLTs;3|
        ((|sp| #1=(|ThreeSpace| (|DoubleFloat|)))
         (|ptFun|
          (|Mapping| #2=(|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|uSeg| (|Segment| (|DoubleFloat|)))
         (|vSeg| (|Segment| (|DoubleFloat|))) (|opts| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG
         ((|space| #1#) (|aProp| (|SubSpaceComponentProperty|)) (#3=#:G729 NIL)
          (|lProp| (|List| (|SubSpaceComponentProperty|))) (#4=#:G728 NIL)
          (|l| NIL) (#5=#:G727 NIL) (|someV| #6=(|DoubleFloat|))
          (|llp| (|List| (|List| (|Point| (|DoubleFloat|))))) (|someU| #6#)
          (|lp| (|List| (|Point| (|DoubleFloat|)))) (|pt| #2#) (|iu| NIL)
          (|iv| NIL) (|vstep| #7=(|DoubleFloat|)) (|ustep| #7#)
          (|vNum| (|PositiveInteger|)) (|uNum| (|PositiveInteger|)))
         (SEQ (LETT |llp| NIL)
              (LETT |uNum|
                    (SPADCALL |opts| (SPADCALL (QREFELT $ 15)) (QREFELT $ 18)))
              (LETT |vNum|
                    (SPADCALL |opts| (SPADCALL (QREFELT $ 19)) (QREFELT $ 20)))
              (LETT |ustep|
                    (|div_DF_I|
                     (|sub_DF| (SPADCALL |uSeg| (QREFELT $ 23))
                               (SPADCALL |uSeg| (QREFELT $ 24)))
                     |uNum|))
              (LETT |vstep|
                    (|div_DF_I|
                     (|sub_DF| (SPADCALL |vSeg| (QREFELT $ 23))
                               (SPADCALL |vSeg| (QREFELT $ 24)))
                     |vNum|))
              (LETT |someV| (SPADCALL |vSeg| (QREFELT $ 24)))
              (SEQ (LETT |iv| |vNum|) G190 (COND ((< |iv| 0) (GO G191)))
                   (SEQ
                    (COND
                     ((ZEROP |iv|)
                      (LETT |someV| (SPADCALL |vSeg| (QREFELT $ 23)))))
                    (LETT |lp| NIL)
                    (LETT |someU| (SPADCALL |uSeg| (QREFELT $ 24)))
                    (SEQ (LETT |iu| |uNum|) G190 (COND ((< |iu| 0) (GO G191)))
                         (SEQ
                          (COND
                           ((ZEROP |iu|)
                            (LETT |someU| (SPADCALL |uSeg| (QREFELT $ 23)))))
                          (LETT |pt| (SPADCALL |someU| |someV| |ptFun|))
                          (LETT |lp| (CONS |pt| |lp|))
                          (EXIT (LETT |someU| (|add_DF| |someU| |ustep|))))
                         (LETT |iu| (+ |iu| -1)) (GO G190) G191 (EXIT NIL))
                    (LETT |llp| (CONS |lp| |llp|))
                    (EXIT (LETT |someV| (|add_DF| |someV| |vstep|))))
                   (LETT |iv| (+ |iv| -1)) (GO G190) G191 (EXIT NIL))
              (LETT |lProp|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |l| NIL) (LETT #4# |llp|) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |l| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5# (CONS (SPADCALL (QREFELT $ 26)) #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (SEQ (LETT #3# |lProp|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |aProp| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (SPADCALL |aProp| NIL (QREFELT $ 28))
                        (EXIT (SPADCALL |aProp| NIL (QREFELT $ 29))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |aProp| (SPADCALL (QREFELT $ 26)))
              (SPADCALL |aProp| NIL (QREFELT $ 28))
              (SPADCALL |aProp| NIL (QREFELT $ 29)) (LETT |space| |sp|)
              (SPADCALL |space| |llp| |lProp| |aProp| (QREFELT $ 33))
              (EXIT |space|)))) 

(SDEFUN |MESH;meshPar2Var;M2SLTs;4|
        ((|ptFun|
          (|Mapping| (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                     (|DoubleFloat|)))
         (|uSeg| (|Segment| (|DoubleFloat|)))
         (|vSeg| (|Segment| (|DoubleFloat|))) (|opts| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG ((|sp| (|ThreeSpace| (|DoubleFloat|))))
               (SEQ (LETT |sp| (SPADCALL (QREFELT $ 35)))
                    (EXIT
                     (SPADCALL |sp| |ptFun| |uSeg| |vSeg| |opts|
                               (QREFELT $ 34)))))) 

(PUT '|MESH;zCoord| '|SPADreplace| '(XLAM (|x| |y| |z|) |z|)) 

(SDEFUN |MESH;zCoord|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) (|z| (|DoubleFloat|))
         ($ (|DoubleFloat|)))
        |z|) 

(SDEFUN |MESH;meshPar2Var;3MU2SLTs;6|
        ((|xFun| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|yFun| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|zFun| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|colorFun|
          (|Union|
           (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                      (|DoubleFloat|))
           "undefined"))
         (|uSeg| (|Segment| (|DoubleFloat|)))
         (|vSeg| (|Segment| (|DoubleFloat|))) (|opts| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (COND
         ((QEQCAR |colorFun| 0)
          (SPADCALL
           (SPADCALL |xFun| |yFun| |zFun| (QCDR |colorFun|) (QREFELT $ 12))
           |uSeg| |vSeg| |opts| (QREFELT $ 36)))
         ('T
          (SPADCALL
           (SPADCALL |xFun| |yFun| |zFun| (CONS (|function| |MESH;zCoord|) $)
                     (QREFELT $ 12))
           |uSeg| |vSeg| |opts| (QREFELT $ 36))))) 

(SDEFUN |MESH;meshFun2Var;MU2SLTs;7|
        ((|zFun| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         (|colorFun|
          (|Union|
           (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                      (|DoubleFloat|))
           "undefined"))
         (|xSeg| (|Segment| (|DoubleFloat|)))
         (|ySeg| (|Segment| (|DoubleFloat|))) (|opts| (|List| (|DrawOption|)))
         ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPADCALL (LIST #'|MESH;meshFun2Var;MU2SLTs;7!0|)
                  (LIST #'|MESH;meshFun2Var;MU2SLTs;7!1|) |zFun| |colorFun|
                  |xSeg| |ySeg| |opts| (QREFELT $ 38))) 

(SDEFUN |MESH;meshFun2Var;MU2SLTs;7!1| ((|z1| NIL) (|z2| NIL) ($$ NIL)) |z2|) 

(SDEFUN |MESH;meshFun2Var;MU2SLTs;7!0| ((|z1| NIL) (|z2| NIL) ($$ NIL)) |z1|) 

(DECLAIM (NOTINLINE |MeshCreationRoutinesForThreeDimensions;|)) 

(DEFUN |MeshCreationRoutinesForThreeDimensions| ()
  (SPROG NIL
         (PROG (#1=#:G781)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|MeshCreationRoutinesForThreeDimensions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|MeshCreationRoutinesForThreeDimensions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|MeshCreationRoutinesForThreeDimensions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|MeshCreationRoutinesForThreeDimensions|)))))))))) 

(DEFUN |MeshCreationRoutinesForThreeDimensions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|MeshCreationRoutinesForThreeDimensions|))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|MeshCreationRoutinesForThreeDimensions| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MeshCreationRoutinesForThreeDimensions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| 21) (|Point| 21) (0 . |point|)
              (|Mapping| 7 21 21) (|Mapping| 21 21 21) (|Mapping| 21 21 21 21)
              |MESH;ptFunc;3MMM;2| (|PositiveInteger|) (|ViewDefaultsPackage|)
              (5 . |var1StepsDefault|) (|List| (|DrawOption|))
              (|DrawOptionFunctions0|) (9 . |var1Steps|)
              (15 . |var2StepsDefault|) (19 . |var2Steps|) (|DoubleFloat|)
              (|Segment| 21) (25 . |low|) (30 . |high|)
              (|SubSpaceComponentProperty|) (35 . |new|) (|Boolean|)
              (39 . |close|) (45 . |solid|) (|List| (|List| 7)) (|List| 25)
              (|ThreeSpace| 21) (51 . |mesh|) |MESH;meshPar2Var;TsM2SLTs;3|
              (59 . |create3Space|) |MESH;meshPar2Var;M2SLTs;4|
              (|Union| 11 '#1="undefined") |MESH;meshPar2Var;3MU2SLTs;6|
              |MESH;meshFun2Var;MU2SLTs;7| (|Expression| (|Integer|))
              (|Mapping| 21 21))
           '#(|ptFunc| 63 |meshPar2Var| 71 |meshPar1Var| 99 |meshFun2Var| 109)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|meshPar2Var|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Union|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                              (|DoubleFloat|) (|DoubleFloat|))
                                   #1#)
                                  (|Segment| (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|meshPar2Var|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|meshPar2Var|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|meshFun2Var|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Union|
                                   (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                              (|DoubleFloat|) (|DoubleFloat|))
                                   #1#)
                                  (|Segment| (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|meshPar1Var|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  (|Segment| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|ptFunc|
                                 ((|Mapping| (|Point| (|DoubleFloat|))
                                             (|DoubleFloat|) (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|) (|DoubleFloat|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 41
                                            '(1 7 0 6 8 0 14 13 15 2 17 13 16
                                              13 18 0 14 13 19 2 17 13 16 13 20
                                              1 22 21 0 23 1 22 21 0 24 0 25 0
                                              26 2 25 27 0 27 28 2 25 27 0 27
                                              29 4 32 0 0 30 31 25 33 0 32 0 35
                                              4 0 9 10 10 10 11 12 7 0 32 10 10
                                              10 37 22 22 16 38 5 0 32 32 9 22
                                              22 16 34 4 0 32 9 22 22 16 36 6 0
                                              32 40 40 40 41 22 16 1 5 0 32 10
                                              37 22 22 16 39)))))
           '|lookupComplete|)) 

(MAKEPROP '|MeshCreationRoutinesForThreeDimensions| 'NILADIC T) 
