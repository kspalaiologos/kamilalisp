
(SDEFUN |VIEWDEF;viewPosDefault;L;1| (($ (|List| (|NonNegativeInteger|))))
        (LIST (SPADCALL (QREFELT $ 27) (QREFELT $ 46))
              (SPADCALL (QREFELT $ 28) (QREFELT $ 46)))) 

(SDEFUN |VIEWDEF;viewPosDefault;2L;2|
        ((|l| (|List| (|NonNegativeInteger|)))
         ($ (|List| (|NonNegativeInteger|))))
        (COND
         ((< (SPADCALL |l| (QREFELT $ 49)) 2)
          (|error| "viewPosDefault expects a list with two elements"))
         ('T
          (LIST (SPADCALL (QREFELT $ 27) (|SPADfirst| |l|) (QREFELT $ 50))
                (SPADCALL (QREFELT $ 28) (SPADCALL |l| (QREFELT $ 51))
                          (QREFELT $ 50)))))) 

(SDEFUN |VIEWDEF;viewSizeDefault;L;3| (($ (|List| (|PositiveInteger|))))
        (LIST (SPADCALL (QREFELT $ 29) (QREFELT $ 53))
              (SPADCALL (QREFELT $ 30) (QREFELT $ 53)))) 

(SDEFUN |VIEWDEF;viewSizeDefault;2L;4|
        ((|l| (|List| (|PositiveInteger|))) ($ (|List| (|PositiveInteger|))))
        (COND
         ((< (LENGTH |l|) 2)
          (|error| "viewSizeDefault expects a list with two elements"))
         ('T
          (LIST (SPADCALL (QREFELT $ 29) (|SPADfirst| |l|) (QREFELT $ 56))
                (SPADCALL (QREFELT $ 30) (SPADCALL |l| (QREFELT $ 57))
                          (QREFELT $ 56)))))) 

(SDEFUN |VIEWDEF;viewDefaults;V;5| (($ (|Void|)))
        (SEQ
         (SETELT $ 12
                 (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9))
                           (QREFELT $ 11)))
         (SETELT $ 15
                 (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 13)) (QREFELT $ 14))
                           (QREFELT $ 11)))
         (SETELT $ 17
                 (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 7)) (QREFELT $ 16))
                           (QREFELT $ 11)))
         (SETELT $ 19
                 (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 18)) (QREFELT $ 16))
                           (QREFELT $ 11)))
         (SETELT $ 23 (SPADCALL 3 (QREFELT $ 22)))
         (SETELT $ 27 (SPADCALL 0 (QREFELT $ 26)))
         (SETELT $ 28 (SPADCALL 0 (QREFELT $ 26)))
         (SETELT $ 29 (SPADCALL 400 (QREFELT $ 22)))
         (EXIT (SETELT $ 30 (SPADCALL 427 (QREFELT $ 22)))))) 

(SDEFUN |VIEWDEF;pointColorDefault;P;6| (($ (|Palette|)))
        (SPADCALL (QREFELT $ 12) (QREFELT $ 61))) 

(SDEFUN |VIEWDEF;pointColorDefault;2P;7| ((|p| (|Palette|)) ($ (|Palette|)))
        (SPADCALL (QREFELT $ 12) |p| (QREFELT $ 63))) 

(SDEFUN |VIEWDEF;lineColorDefault;P;8| (($ (|Palette|)))
        (SPADCALL (QREFELT $ 15) (QREFELT $ 61))) 

(SDEFUN |VIEWDEF;lineColorDefault;2P;9| ((|p| (|Palette|)) ($ (|Palette|)))
        (SPADCALL (QREFELT $ 15) |p| (QREFELT $ 63))) 

(SDEFUN |VIEWDEF;axesColorDefault;P;10| (($ (|Palette|)))
        (SPADCALL (QREFELT $ 17) (QREFELT $ 61))) 

(SDEFUN |VIEWDEF;axesColorDefault;2P;11| ((|p| (|Palette|)) ($ (|Palette|)))
        (SPADCALL (QREFELT $ 17) |p| (QREFELT $ 63))) 

(SDEFUN |VIEWDEF;unitsColorDefault;P;12| (($ (|Palette|)))
        (SPADCALL (QREFELT $ 19) (QREFELT $ 61))) 

(SDEFUN |VIEWDEF;unitsColorDefault;2P;13| ((|p| (|Palette|)) ($ (|Palette|)))
        (SPADCALL (QREFELT $ 19) |p| (QREFELT $ 63))) 

(SDEFUN |VIEWDEF;pointSizeDefault;Pi;14| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 23) (QREFELT $ 53))) 

(SDEFUN |VIEWDEF;pointSizeDefault;2Pi;15|
        ((|x| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 23) |x| (QREFELT $ 56))) 

(SDEFUN |VIEWDEF;var1StepsDefault;Pi;16| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 35) (QREFELT $ 53))) 

(SDEFUN |VIEWDEF;var1StepsDefault;2Pi;17|
        ((|i| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 35) |i| (QREFELT $ 56))) 

(SDEFUN |VIEWDEF;var2StepsDefault;Pi;18| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 36) (QREFELT $ 53))) 

(SDEFUN |VIEWDEF;var2StepsDefault;2Pi;19|
        ((|i| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 36) |i| (QREFELT $ 56))) 

(SDEFUN |VIEWDEF;tubePointsDefault;Pi;20| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 37) (QREFELT $ 53))) 

(SDEFUN |VIEWDEF;tubePointsDefault;2Pi;21|
        ((|i| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 37) |i| (QREFELT $ 56))) 

(SDEFUN |VIEWDEF;tubeRadiusDefault;Df;22| (($ (|DoubleFloat|)))
        (SPADCALL (QREFELT $ 41) (QREFELT $ 79))) 

(SDEFUN |VIEWDEF;tubeRadiusDefault;FDf;23|
        ((|f| (|Float|)) ($ (|DoubleFloat|)))
        (SPADCALL (QREFELT $ 41) (SPADCALL |f| (QREFELT $ 82)) (QREFELT $ 83))) 

(PUT '|VIEWDEF;viewWriteAvailable;L;24| '|SPADreplace|
     '(XLAM NIL (LIST "PIXMAP" "BITMAP" "POSTSCRIPT" "IMAGE"))) 

(SDEFUN |VIEWDEF;viewWriteAvailable;L;24| (($ (|List| (|String|))))
        (LIST "PIXMAP" "BITMAP" "POSTSCRIPT" "IMAGE")) 

(SDEFUN |VIEWDEF;viewWriteDefault;L;25| (($ (|List| (|String|))))
        (SPADCALL (QREFELT $ 34) (QREFELT $ 86))) 

(SDEFUN |VIEWDEF;viewWriteDefault;2L;26|
        ((|listOfThings| (|List| (|String|))) ($ (|List| (|String|))))
        (SPROG
         ((|thingsToWrite| (|List| (|String|))) (|writeTypeInt| (|Integer|))
          (#1=#:G743 NIL) (|aTypeOfFile| NIL))
         (SEQ (LETT |thingsToWrite| NIL)
              (SEQ (LETT |aTypeOfFile| NIL) (LETT #1# |listOfThings|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |aTypeOfFile| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |writeTypeInt|
                          (SPADCALL (SPADCALL |aTypeOfFile| (QREFELT $ 89))
                                    (SPADCALL (QREFELT $ 85)) (QREFELT $ 91)))
                    (EXIT
                     (COND
                      ((< |writeTypeInt| 1)
                       (SPADCALL
                        (LIST "  > " |aTypeOfFile|
                              " is not a valid file type for writing a viewport")
                        (QREFELT $ 93)))
                      ('T
                       (LETT |thingsToWrite|
                             (SPADCALL |thingsToWrite| (LIST |aTypeOfFile|)
                                       (QREFELT $ 94)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (QREFELT $ 34) |thingsToWrite| (QREFELT $ 95)))))) 

(DECLAIM (NOTINLINE |ViewDefaultsPackage;|)) 

(DEFUN |ViewDefaultsPackage| ()
  (SPROG NIL
         (PROG (#1=#:G745)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ViewDefaultsPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ViewDefaultsPackage|
                             (LIST
                              (CONS NIL (CONS 1 (|ViewDefaultsPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ViewDefaultsPackage|)))))))))) 

(DEFUN |ViewDefaultsPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ViewDefaultsPackage|))
          (LETT $ (GETREFV 97))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ViewDefaultsPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 12
                    (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9))
                              (QREFELT $ 11)))
          (QSETREFV $ 15
                    (SPADCALL
                     (SPADCALL (SPADCALL (QREFELT $ 13)) (QREFELT $ 14))
                     (QREFELT $ 11)))
          (QSETREFV $ 17
                    (SPADCALL
                     (SPADCALL (SPADCALL (QREFELT $ 7)) (QREFELT $ 16))
                     (QREFELT $ 11)))
          (QSETREFV $ 19
                    (SPADCALL
                     (SPADCALL (SPADCALL (QREFELT $ 18)) (QREFELT $ 16))
                     (QREFELT $ 11)))
          (QSETREFV $ 23 (SPADCALL 3 (QREFELT $ 22)))
          (QSETREFV $ 27 (SPADCALL 0 (QREFELT $ 26)))
          (QSETREFV $ 28 (SPADCALL 0 (QREFELT $ 26)))
          (QSETREFV $ 29 (SPADCALL 400 (QREFELT $ 22)))
          (QSETREFV $ 30 (SPADCALL 400 (QREFELT $ 22)))
          (QSETREFV $ 34 (SPADCALL NIL (QREFELT $ 33)))
          (QSETREFV $ 35 (SPADCALL 27 (QREFELT $ 22)))
          (QSETREFV $ 36 (SPADCALL 27 (QREFELT $ 22)))
          (QSETREFV $ 37 (SPADCALL 6 (QREFELT $ 22)))
          (QSETREFV $ 41 (SPADCALL (|mk_DF| 5 -1) (QREFELT $ 40)))
          (QSETREFV $ 45 (SPADCALL NIL (QREFELT $ 44)))
          $))) 

(MAKEPROP '|ViewDefaultsPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Color|) (0 . |red|) (|Palette|)
              (4 . |bright|) (|Reference| 8) (9 . |ref|) '|defaultPointColor|
              (14 . |green|) (18 . |pastel|) '|defaultLineColor| (23 . |dim|)
              '|defaultAxesColor| (28 . |yellow|) '|defaultUnitsColor|
              (|PositiveInteger|) (|Reference| 20) (32 . |ref|)
              '|defaultPointSize| (|NonNegativeInteger|) (|Reference| 24)
              (37 . |ref|) '|defaultXPos| '|defaultYPos| '|defaultWidth|
              '|defaultHeight| (|List| 88) (|Reference| 31) (42 . |ref|)
              '|defaultThingsToWrite| '|defaultVar1Steps| '|defaultVar2Steps|
              '|defaultTubePoints| (|DoubleFloat|) (|Reference| 38)
              (47 . |ref|) '|defaultTubeRadius| (|Boolean|) (|Reference| 42)
              (52 . |ref|) '|defaultClosed| (57 . |elt|) (|List| 24)
              |VIEWDEF;viewPosDefault;L;1| (62 . |#|) (67 . |setelt!|)
              (73 . |last|) |VIEWDEF;viewPosDefault;2L;2| (78 . |elt|)
              (|List| 20) |VIEWDEF;viewSizeDefault;L;3| (83 . |setelt!|)
              (89 . |last|) |VIEWDEF;viewSizeDefault;2L;4| (|Void|)
              |VIEWDEF;viewDefaults;V;5| (94 . |elt|)
              |VIEWDEF;pointColorDefault;P;6| (99 . |setelt!|)
              |VIEWDEF;pointColorDefault;2P;7| |VIEWDEF;lineColorDefault;P;8|
              |VIEWDEF;lineColorDefault;2P;9| |VIEWDEF;axesColorDefault;P;10|
              |VIEWDEF;axesColorDefault;2P;11| |VIEWDEF;unitsColorDefault;P;12|
              |VIEWDEF;unitsColorDefault;2P;13|
              |VIEWDEF;pointSizeDefault;Pi;14|
              |VIEWDEF;pointSizeDefault;2Pi;15|
              |VIEWDEF;var1StepsDefault;Pi;16|
              |VIEWDEF;var1StepsDefault;2Pi;17|
              |VIEWDEF;var2StepsDefault;Pi;18|
              |VIEWDEF;var2StepsDefault;2Pi;19|
              |VIEWDEF;tubePointsDefault;Pi;20|
              |VIEWDEF;tubePointsDefault;2Pi;21| (105 . |elt|)
              |VIEWDEF;tubeRadiusDefault;Df;22| (|Float|) (110 . |convert|)
              (115 . |setelt!|) |VIEWDEF;tubeRadiusDefault;FDf;23|
              |VIEWDEF;viewWriteAvailable;L;24| (121 . |elt|)
              |VIEWDEF;viewWriteDefault;L;25| (|String|) (126 . |upperCase|)
              (|Integer|) (131 . |position|) (|DisplayPackage|) (137 . |say|)
              (142 . |append|) (148 . |setelt!|)
              |VIEWDEF;viewWriteDefault;2L;26|)
           '#(|viewWriteDefault| 154 |viewWriteAvailable| 163 |viewSizeDefault|
              167 |viewPosDefault| 176 |viewDefaults| 185 |var2StepsDefault|
              189 |var1StepsDefault| 198 |unitsColorDefault| 207
              |tubeRadiusDefault| 216 |tubePointsDefault| 225
              |pointSizeDefault| 234 |pointColorDefault| 243 |lineColorDefault|
              252 |axesColorDefault| 261)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|pointColorDefault| ((|Palette|))) T)
                                   '((|pointColorDefault|
                                      ((|Palette|) (|Palette|)))
                                     T)
                                   '((|lineColorDefault| ((|Palette|))) T)
                                   '((|lineColorDefault|
                                      ((|Palette|) (|Palette|)))
                                     T)
                                   '((|axesColorDefault| ((|Palette|))) T)
                                   '((|axesColorDefault|
                                      ((|Palette|) (|Palette|)))
                                     T)
                                   '((|unitsColorDefault| ((|Palette|))) T)
                                   '((|unitsColorDefault|
                                      ((|Palette|) (|Palette|)))
                                     T)
                                   '((|pointSizeDefault| ((|PositiveInteger|)))
                                     T)
                                   '((|pointSizeDefault|
                                      ((|PositiveInteger|)
                                       (|PositiveInteger|)))
                                     T)
                                   '((|viewPosDefault|
                                      ((|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|viewPosDefault|
                                      ((|List| (|NonNegativeInteger|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|viewSizeDefault|
                                      ((|List| (|PositiveInteger|))))
                                     T)
                                   '((|viewSizeDefault|
                                      ((|List| (|PositiveInteger|))
                                       (|List| (|PositiveInteger|))))
                                     T)
                                   '((|viewDefaults| ((|Void|))) T)
                                   '((|viewWriteDefault| ((|List| (|String|))))
                                     T)
                                   '((|viewWriteDefault|
                                      ((|List| (|String|))
                                       (|List| (|String|))))
                                     T)
                                   '((|viewWriteAvailable|
                                      ((|List| (|String|))))
                                     T)
                                   '((|var1StepsDefault| ((|PositiveInteger|)))
                                     T)
                                   '((|var2StepsDefault| ((|PositiveInteger|)))
                                     T)
                                   '((|var1StepsDefault|
                                      ((|PositiveInteger|)
                                       (|PositiveInteger|)))
                                     T)
                                   '((|var2StepsDefault|
                                      ((|PositiveInteger|)
                                       (|PositiveInteger|)))
                                     T)
                                   '((|tubePointsDefault|
                                      ((|PositiveInteger|)
                                       (|PositiveInteger|)))
                                     T)
                                   '((|tubePointsDefault|
                                      ((|PositiveInteger|)))
                                     T)
                                   '((|tubeRadiusDefault|
                                      ((|DoubleFloat|) (|Float|)))
                                     T)
                                   '((|tubeRadiusDefault| ((|DoubleFloat|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 96
                                            '(0 6 0 7 1 8 0 6 9 1 10 0 8 11 0 6
                                              0 13 1 8 0 6 14 1 8 0 6 16 0 6 0
                                              18 1 21 0 20 22 1 25 0 24 26 1 32
                                              0 31 33 1 39 0 38 40 1 43 0 42 44
                                              1 25 24 0 46 1 47 24 0 49 2 25 24
                                              0 24 50 1 47 24 0 51 1 21 20 0 53
                                              2 21 20 0 20 56 1 54 20 0 57 1 10
                                              8 0 61 2 10 8 0 8 63 1 39 38 0 79
                                              1 81 38 0 82 2 39 38 0 38 83 1 32
                                              31 0 86 1 88 0 0 89 2 31 90 88 0
                                              91 1 92 59 31 93 2 31 0 0 0 94 2
                                              32 31 0 31 95 0 0 31 87 1 0 31 31
                                              96 0 0 31 85 0 0 54 55 1 0 54 54
                                              58 0 0 47 48 1 0 47 47 52 0 0 59
                                              60 0 0 20 75 1 0 20 20 76 0 0 20
                                              73 1 0 20 20 74 0 0 8 69 1 0 8 8
                                              70 0 0 38 80 1 0 38 81 84 0 0 20
                                              77 1 0 20 20 78 0 0 20 71 1 0 20
                                              20 72 0 0 8 62 1 0 8 8 64 0 0 8
                                              65 1 0 8 8 66 1 0 8 8 68 0 0 8
                                              67)))))
           '|lookupComplete|)) 

(MAKEPROP '|ViewDefaultsPackage| 'NILADIC T) 
