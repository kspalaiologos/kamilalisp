
(SDEFUN |DROPT0;adaptive;L2B;1|
        ((|l| (|List| (|DrawOption|))) (|s| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|u| (|Union| (|Boolean|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|adaptive| (QREFELT $ 10)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;clipBoolean;L2B;2|
        ((|l| (|List| (|DrawOption|))) (|s| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|u| (|Union| (|Boolean|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|clipBoolean| (QREFELT $ 10)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;title;L2S;3|
        ((|l| (|List| (|DrawOption|))) (|s| (|String|)) ($ (|String|)))
        (SPROG ((|u| (|Union| (|String|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|title| (QREFELT $ 16)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;viewpoint;L2R;4|
        ((|l| (|List| (|DrawOption|)))
         (|vp|
          (|Record| (|:| |theta| (|DoubleFloat|)) (|:| |phi| (|DoubleFloat|))
                    (|:| |scale| (|DoubleFloat|))
                    (|:| |scaleX| (|DoubleFloat|))
                    (|:| |scaleY| (|DoubleFloat|))
                    (|:| |scaleZ| (|DoubleFloat|))
                    (|:| |deltaX| (|DoubleFloat|))
                    (|:| |deltaY| (|DoubleFloat|))))
         ($
          (|Record| (|:| |theta| (|DoubleFloat|)) (|:| |phi| (|DoubleFloat|))
                    (|:| |scale| (|DoubleFloat|))
                    (|:| |scaleX| (|DoubleFloat|))
                    (|:| |scaleY| (|DoubleFloat|))
                    (|:| |scaleZ| (|DoubleFloat|))
                    (|:| |deltaX| (|DoubleFloat|))
                    (|:| |deltaY| (|DoubleFloat|)))))
        (SPROG
         ((|u|
           (|Union|
            (|Record| (|:| |theta| (|DoubleFloat|)) (|:| |phi| (|DoubleFloat|))
                      (|:| |scale| (|DoubleFloat|))
                      (|:| |scaleX| (|DoubleFloat|))
                      (|:| |scaleY| (|DoubleFloat|))
                      (|:| |scaleZ| (|DoubleFloat|))
                      (|:| |deltaX| (|DoubleFloat|))
                      (|:| |deltaY| (|DoubleFloat|)))
            "failed")))
         (SEQ (LETT |u| (SPADCALL |l| '|viewpoint| (QREFELT $ 22)))
              (EXIT (COND ((QEQCAR |u| 1) |vp|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;style;L2S;5|
        ((|l| (|List| (|DrawOption|))) (|s| (|String|)) ($ (|String|)))
        (SPROG ((|u| (|Union| (|String|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|style| (QREFELT $ 16)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;toScale;L2B;6|
        ((|l| (|List| (|DrawOption|))) (|s| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|u| (|Union| (|Boolean|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|toScale| (QREFELT $ 10)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;pointColorPalette;L2P;7|
        ((|l| (|List| (|DrawOption|))) (|s| (|Palette|)) ($ (|Palette|)))
        (SPROG ((|u| (|Union| (|Palette|) "failed")))
               (SEQ
                (LETT |u| (SPADCALL |l| '|pointColorPalette| (QREFELT $ 28)))
                (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;curveColorPalette;L2P;8|
        ((|l| (|List| (|DrawOption|))) (|s| (|Palette|)) ($ (|Palette|)))
        (SPROG ((|u| (|Union| (|Palette|) "failed")))
               (SEQ
                (LETT |u| (SPADCALL |l| '|curveColorPalette| (QREFELT $ 28)))
                (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;ranges;L2L;9|
        ((|l| (|List| (|DrawOption|))) (|s| (|List| (|Segment| (|Float|))))
         ($ (|List| (|Segment| (|Float|)))))
        (SPROG ((|u| (|Union| (|List| (|Segment| (|Float|))) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|ranges| (QREFELT $ 34)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;space;LTs;10|
        ((|l| (|List| (|DrawOption|))) ($ (|ThreeSpace| (|DoubleFloat|))))
        (SPROG ((|u| (|Union| (|ThreeSpace| (|DoubleFloat|)) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|space| (QREFELT $ 39)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (SPADCALL (QREFELT $ 41)))
                           ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;var1Steps;L2Pi;11|
        ((|l| (|List| (|DrawOption|))) (|s| (|PositiveInteger|))
         ($ (|PositiveInteger|)))
        (SPROG ((|u| (|Union| (|PositiveInteger|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|var1Steps| (QREFELT $ 45)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;var2Steps;L2Pi;12|
        ((|l| (|List| (|DrawOption|))) (|s| (|PositiveInteger|))
         ($ (|PositiveInteger|)))
        (SPROG ((|u| (|Union| (|PositiveInteger|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|var2Steps| (QREFELT $ 45)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;tubePoints;L2Pi;13|
        ((|l| (|List| (|DrawOption|))) (|s| (|PositiveInteger|))
         ($ (|PositiveInteger|)))
        (SPROG ((|u| (|Union| (|PositiveInteger|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|tubePoints| (QREFELT $ 45)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;tubeRadius;L2F;14|
        ((|l| (|List| (|DrawOption|))) (|s| (|Float|)) ($ (|Float|)))
        (SPROG ((|u| (|Union| (|Float|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|tubeRadius| (QREFELT $ 52)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;coord;L2M;15|
        ((|l| (|List| (|DrawOption|)))
         (|s| (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|))))
         ($ (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))))
        (SPROG
         ((|u|
           (|Union|
            (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))
            "failed")))
         (SEQ (LETT |u| (SPADCALL |l| '|coord| (QREFELT $ 58)))
              (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(SDEFUN |DROPT0;units;L2L;16|
        ((|l| (|List| (|DrawOption|))) (|s| (|List| (|Float|)))
         ($ (|List| (|Float|))))
        (SPROG ((|u| (|Union| (|List| (|Float|)) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| '|unit| (QREFELT $ 62)))
                    (EXIT (COND ((QEQCAR |u| 1) |s|) ('T (QCDR |u|))))))) 

(DECLAIM (NOTINLINE |DrawOptionFunctions0;|)) 

(DEFUN |DrawOptionFunctions0| ()
  (SPROG NIL
         (PROG (#1=#:G789)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|DrawOptionFunctions0|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DrawOptionFunctions0|
                             (LIST
                              (CONS NIL (CONS 1 (|DrawOptionFunctions0;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|DrawOptionFunctions0|)))))))))) 

(DEFUN |DrawOptionFunctions0;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DrawOptionFunctions0|))
          (LETT $ (GETREFV 65))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DrawOptionFunctions0| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DrawOptionFunctions0| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Union| 11 '#1="failed")
              (|List| (|DrawOption|)) (|Symbol|) (|DrawOptionFunctions1| 11)
              (0 . |option|) (|Boolean|) |DROPT0;adaptive;L2B;1|
              |DROPT0;clipBoolean;L2B;2| (|Union| 17 '#1#)
              (|DrawOptionFunctions1| 17) (6 . |option|) (|String|)
              |DROPT0;title;L2S;3|
              (|Record| (|:| |theta| (|DoubleFloat|))
                        (|:| |phi| (|DoubleFloat|))
                        (|:| |scale| (|DoubleFloat|))
                        (|:| |scaleX| (|DoubleFloat|))
                        (|:| |scaleY| (|DoubleFloat|))
                        (|:| |scaleZ| (|DoubleFloat|))
                        (|:| |deltaX| (|DoubleFloat|))
                        (|:| |deltaY| (|DoubleFloat|)))
              (|Union| 19 '#1#) (|DrawOptionFunctions1| 19) (12 . |option|)
              |DROPT0;viewpoint;L2R;4| |DROPT0;style;L2S;5|
              |DROPT0;toScale;L2B;6| (|Union| 29 '#1#)
              (|DrawOptionFunctions1| 29) (18 . |option|) (|Palette|)
              |DROPT0;pointColorPalette;L2P;7| |DROPT0;curveColorPalette;L2P;8|
              (|Union| 35 '#1#) (|DrawOptionFunctions1| 35) (24 . |option|)
              (|List| (|Segment| 53)) |DROPT0;ranges;L2L;9| (|Union| 40 '#1#)
              (|DrawOptionFunctions1| 40) (30 . |option|)
              (|ThreeSpace| (|DoubleFloat|)) (36 . |create3Space|)
              |DROPT0;space;LTs;10| (|Union| 46 '#1#)
              (|DrawOptionFunctions1| 46) (40 . |option|) (|PositiveInteger|)
              |DROPT0;var1Steps;L2Pi;11| |DROPT0;var2Steps;L2Pi;12|
              |DROPT0;tubePoints;L2Pi;13| (|Union| 53 '#1#)
              (|DrawOptionFunctions1| 53) (46 . |option|) (|Float|)
              |DROPT0;tubeRadius;L2F;14|
              (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))
              (|Union| 55 '#1#) (|DrawOptionFunctions1| 55) (52 . |option|)
              |DROPT0;coord;L2M;15| (|Union| 63 '#1#)
              (|DrawOptionFunctions1| 63) (58 . |option|) (|List| 53)
              |DROPT0;units;L2L;16|)
           '#(|viewpoint| 64 |var2Steps| 70 |var1Steps| 76 |units| 82
              |tubeRadius| 88 |tubePoints| 94 |toScale| 100 |title| 106 |style|
              112 |space| 118 |ranges| 123 |pointColorPalette| 129
              |curveColorPalette| 135 |coord| 141 |clipBoolean| 147 |adaptive|
              153)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|adaptive|
                                 ((|Boolean|) (|List| (|DrawOption|))
                                  (|Boolean|)))
                                T)
                              '((|clipBoolean|
                                 ((|Boolean|) (|List| (|DrawOption|))
                                  (|Boolean|)))
                                T)
                              '((|viewpoint|
                                 ((|Record| (|:| |theta| (|DoubleFloat|))
                                            (|:| |phi| (|DoubleFloat|))
                                            (|:| |scale| (|DoubleFloat|))
                                            (|:| |scaleX| (|DoubleFloat|))
                                            (|:| |scaleY| (|DoubleFloat|))
                                            (|:| |scaleZ| (|DoubleFloat|))
                                            (|:| |deltaX| (|DoubleFloat|))
                                            (|:| |deltaY| (|DoubleFloat|)))
                                  (|List| (|DrawOption|))
                                  (|Record| (|:| |theta| (|DoubleFloat|))
                                            (|:| |phi| (|DoubleFloat|))
                                            (|:| |scale| (|DoubleFloat|))
                                            (|:| |scaleX| (|DoubleFloat|))
                                            (|:| |scaleY| (|DoubleFloat|))
                                            (|:| |scaleZ| (|DoubleFloat|))
                                            (|:| |deltaX| (|DoubleFloat|))
                                            (|:| |deltaY| (|DoubleFloat|)))))
                                T)
                              '((|title|
                                 ((|String|) (|List| (|DrawOption|))
                                  (|String|)))
                                T)
                              '((|style|
                                 ((|String|) (|List| (|DrawOption|))
                                  (|String|)))
                                T)
                              '((|toScale|
                                 ((|Boolean|) (|List| (|DrawOption|))
                                  (|Boolean|)))
                                T)
                              '((|pointColorPalette|
                                 ((|Palette|) (|List| (|DrawOption|))
                                  (|Palette|)))
                                T)
                              '((|curveColorPalette|
                                 ((|Palette|) (|List| (|DrawOption|))
                                  (|Palette|)))
                                T)
                              '((|ranges|
                                 ((|List| (|Segment| (|Float|)))
                                  (|List| (|DrawOption|))
                                  (|List| (|Segment| (|Float|)))))
                                T)
                              '((|var1Steps|
                                 ((|PositiveInteger|) (|List| (|DrawOption|))
                                  (|PositiveInteger|)))
                                T)
                              '((|var2Steps|
                                 ((|PositiveInteger|) (|List| (|DrawOption|))
                                  (|PositiveInteger|)))
                                T)
                              '((|space|
                                 ((|ThreeSpace| (|DoubleFloat|))
                                  (|List| (|DrawOption|))))
                                T)
                              '((|tubePoints|
                                 ((|PositiveInteger|) (|List| (|DrawOption|))
                                  (|PositiveInteger|)))
                                T)
                              '((|tubeRadius|
                                 ((|Float|) (|List| (|DrawOption|)) (|Float|)))
                                T)
                              '((|coord|
                                 ((|Mapping| (|Point| (|DoubleFloat|))
                                             (|Point| (|DoubleFloat|)))
                                  (|List| (|DrawOption|))
                                  (|Mapping| (|Point| (|DoubleFloat|))
                                             (|Point| (|DoubleFloat|)))))
                                T)
                              '((|units|
                                 ((|List| (|Float|)) (|List| (|DrawOption|))
                                  (|List| (|Float|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 64
                                            '(2 9 6 7 8 10 2 15 14 7 8 16 2 21
                                              20 7 8 22 2 27 26 7 8 28 2 33 32
                                              7 8 34 2 38 37 7 8 39 0 40 0 41 2
                                              44 43 7 8 45 2 51 50 7 8 52 2 57
                                              56 7 8 58 2 61 60 7 8 62 2 0 19 7
                                              19 23 2 0 46 7 46 48 2 0 46 7 46
                                              47 2 0 63 7 63 64 2 0 53 7 53 54
                                              2 0 46 7 46 49 2 0 11 7 11 25 2 0
                                              17 7 17 18 2 0 17 7 17 24 1 0 40
                                              7 42 2 0 35 7 35 36 2 0 29 7 29
                                              30 2 0 29 7 29 31 2 0 55 7 55 59
                                              2 0 11 7 11 13 2 0 11 7 11
                                              12)))))
           '|lookupComplete|)) 

(MAKEPROP '|DrawOptionFunctions0| 'NILADIC T) 
