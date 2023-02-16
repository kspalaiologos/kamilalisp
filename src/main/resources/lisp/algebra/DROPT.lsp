
(PUT '|DROPT;length| '|SPADreplace| 'LENGTH) 

(SDEFUN |DROPT;length|
        ((|tup| (|List| (|Segment| (|Float|)))) ($ (|NonNegativeInteger|)))
        (LENGTH |tup|)) 

(PUT '|DROPT;lengthR| '|SPADreplace| 'LENGTH) 

(SDEFUN |DROPT;lengthR|
        ((|tup| (|List| (|Segment| (|Fraction| (|Integer|)))))
         ($ (|NonNegativeInteger|)))
        (LENGTH |tup|)) 

(PUT '|DROPT;lengthI| '|SPADreplace| 'LENGTH) 

(SDEFUN |DROPT;lengthI|
        ((|tup| (|List| (|Integer|))) ($ (|NonNegativeInteger|)))
        (LENGTH |tup|)) 

(SDEFUN |DROPT;viewpoint;R$;4|
        ((|vp|
          (|Record| (|:| |theta| (|DoubleFloat|)) (|:| |phi| (|DoubleFloat|))
                    (|:| |scale| (|DoubleFloat|))
                    (|:| |scaleX| (|DoubleFloat|))
                    (|:| |scaleY| (|DoubleFloat|))
                    (|:| |scaleZ| (|DoubleFloat|))
                    (|:| |deltaX| (|DoubleFloat|))
                    (|:| |deltaY| (|DoubleFloat|))))
         ($ ($)))
        (CONS '|viewpoint| (SPADCALL |vp| (QREFELT $ 10)))) 

(SDEFUN |DROPT;title;S$;5| ((|s| (|String|)) ($ ($)))
        (CONS '|title| (SPADCALL |s| (QREFELT $ 14)))) 

(SDEFUN |DROPT;style;S$;6| ((|s| (|String|)) ($ ($)))
        (CONS '|style| (SPADCALL |s| (QREFELT $ 14)))) 

(SDEFUN |DROPT;toScale;B$;7| ((|b| (|Boolean|)) ($ ($)))
        (CONS '|toScale| (SPADCALL |b| (QREFELT $ 19)))) 

(SDEFUN |DROPT;clip;B$;8| ((|b| (|Boolean|)) ($ ($)))
        (CONS '|clipBoolean| (SPADCALL |b| (QREFELT $ 19)))) 

(SDEFUN |DROPT;adaptive;B$;9| ((|b| (|Boolean|)) ($ ($)))
        (CONS '|adaptive| (SPADCALL |b| (QREFELT $ 19)))) 

(SDEFUN |DROPT;pointColor;F$;10| ((|x| (|Float|)) ($ ($)))
        (CONS '|pointColorFloat| (SPADCALL |x| (QREFELT $ 25)))) 

(SDEFUN |DROPT;pointColor;P$;11| ((|c| (|Palette|)) ($ ($)))
        (CONS '|pointColorPalette| (SPADCALL |c| (QREFELT $ 29)))) 

(SDEFUN |DROPT;curveColor;F$;12| ((|x| (|Float|)) ($ ($)))
        (CONS '|curveColorFloat| (SPADCALL |x| (QREFELT $ 25)))) 

(SDEFUN |DROPT;curveColor;P$;13| ((|c| (|Palette|)) ($ ($)))
        (CONS '|curveColorPalette| (SPADCALL |c| (QREFELT $ 29)))) 

(SDEFUN |DROPT;colorFunction;M$;14|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|))) ($ ($)))
        (CONS '|colorFunction1| (SPADCALL |f| (QREFELT $ 35)))) 

(SDEFUN |DROPT;colorFunction;M$;15|
        ((|f| (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)))
         ($ ($)))
        (CONS '|colorFunction2| (SPADCALL |f| (QREFELT $ 39)))) 

(SDEFUN |DROPT;colorFunction;M$;16|
        ((|f|
          (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                     (|DoubleFloat|)))
         ($ ($)))
        (CONS '|colorFunction3| (SPADCALL |f| (QREFELT $ 43)))) 

(SDEFUN |DROPT;clip;L$;17| ((|tup| (|List| (|Segment| (|Float|)))) ($ ($)))
        (COND
         ((> (|DROPT;length| |tup| $) 3)
          (|error| "clip: at most 3 segments may be specified"))
         ('T (CONS '|clipSegment| (SPADCALL |tup| (QREFELT $ 47)))))) 

(SDEFUN |DROPT;coordinates;M$;18|
        ((|f| (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|))))
         ($ ($)))
        (CONS '|coordinates| (SPADCALL |f| (QREFELT $ 51)))) 

(SDEFUN |DROPT;tubeRadius;F$;19| ((|x| (|Float|)) ($ ($)))
        (CONS '|tubeRadius| (SPADCALL |x| (QREFELT $ 25)))) 

(SDEFUN |DROPT;range;L$;20| ((|tup| (|List| (|Segment| (|Float|)))) ($ ($)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (|DROPT;length| |tup| $))
                    (EXIT
                     (COND
                      ((> |n| 3)
                       (|error| "range: at most 3 segments may be specified"))
                      ((< |n| 2)
                       (|error| "range: at least 2 segments may be specified"))
                      ('T
                       (CONS '|rangeFloat|
                             (SPADCALL |tup| (QREFELT $ 47))))))))) 

(SDEFUN |DROPT;range;L$;21|
        ((|tup| (|List| (|Segment| (|Fraction| (|Integer|))))) ($ ($)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (|DROPT;lengthR| |tup| $))
                    (EXIT
                     (COND
                      ((> |n| 3)
                       (|error| "range: at most 3 segments may be specified"))
                      ((< |n| 2)
                       (|error| "range: at least 2 segments may be specified"))
                      ('T
                       (CONS '|rangeRat| (SPADCALL |tup| (QREFELT $ 57))))))))) 

(SDEFUN |DROPT;ranges;L$;22| ((|s| (|List| (|Segment| (|Float|)))) ($ ($)))
        (CONS '|ranges| (SPADCALL |s| (QREFELT $ 47)))) 

(SDEFUN |DROPT;space;Ts$;23| ((|s| (|ThreeSpace| (|DoubleFloat|))) ($ ($)))
        (CONS '|space| (SPADCALL |s| (QREFELT $ 62)))) 

(SDEFUN |DROPT;var1Steps;Pi$;24| ((|s| (|PositiveInteger|)) ($ ($)))
        (CONS '|var1Steps| (SPADCALL |s| (QREFELT $ 66)))) 

(SDEFUN |DROPT;var2Steps;Pi$;25| ((|s| (|PositiveInteger|)) ($ ($)))
        (CONS '|var2Steps| (SPADCALL |s| (QREFELT $ 66)))) 

(SDEFUN |DROPT;tubePoints;Pi$;26| ((|s| (|PositiveInteger|)) ($ ($)))
        (CONS '|tubePoints| (SPADCALL |s| (QREFELT $ 66)))) 

(SDEFUN |DROPT;coord;M$;27|
        ((|s| (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|))))
         ($ ($)))
        (CONS '|coord| (SPADCALL |s| (QREFELT $ 51)))) 

(SDEFUN |DROPT;unit;L$;28| ((|s| (|List| (|Float|))) ($ ($)))
        (CONS '|unit| (SPADCALL |s| (QREFELT $ 73)))) 

(SDEFUN |DROPT;coerce;$Of;29| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (QCAR |x|) (QREFELT $ 77))
                  (SPADCALL (QCDR |x|) (QREFELT $ 78)) (QREFELT $ 79))) 

(SDEFUN |DROPT;=;2$B;30| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((EQUAL (QCAR |x|) (QCAR |y|))
          (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 81)))
         ('T NIL))) 

(SDEFUN |DROPT;option?;LSB;31|
        ((|l| (|List| $)) (|s| (|Symbol|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G766 NIL) (#2=#:G767 NIL) (#3=#:G768 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |x| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((EQUAL (QCAR |x|) |s|)
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G765)))
                              (GO #5=#:G763))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |DROPT;option;LSU;32|
        ((|l| (|List| $)) (|s| (|Symbol|)) ($ (|Union| (|Any|) "failed")))
        (SPROG ((#1=#:G781 NIL) (#2=#:G782 NIL) (#3=#:G783 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |x| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((EQUAL (QCAR |x|) |s|)
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 0 (QCDR |x|)))
                                     (GO #4=#:G780)))
                              (GO #5=#:G775))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |DrawOption;|)) 

(DEFUN |DrawOption| ()
  (SPROG NIL
         (PROG (#1=#:G785)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|DrawOption|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DrawOption|
                             (LIST (CONS NIL (CONS 1 (|DrawOption;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|DrawOption|)))))))))) 

(DEFUN |DrawOption;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DrawOption|))
          (LETT $ (GETREFV 89))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DrawOption| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |keyword| (|Symbol|))
                              (|:| |value| (|Any|))))
          $))) 

(MAKEPROP '|DrawOption| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Any|)
              (|Record| (|:| |theta| (|DoubleFloat|))
                        (|:| |phi| (|DoubleFloat|))
                        (|:| |scale| (|DoubleFloat|))
                        (|:| |scaleX| (|DoubleFloat|))
                        (|:| |scaleY| (|DoubleFloat|))
                        (|:| |scaleZ| (|DoubleFloat|))
                        (|:| |deltaX| (|DoubleFloat|))
                        (|:| |deltaY| (|DoubleFloat|)))
              (|AnyFunctions1| 8) (0 . |coerce|) |DROPT;viewpoint;R$;4|
              (|String|) (|AnyFunctions1| 12) (5 . |coerce|) |DROPT;title;S$;5|
              |DROPT;style;S$;6| (|Boolean|) (|AnyFunctions1| 17)
              (10 . |coerce|) |DROPT;toScale;B$;7| |DROPT;clip;B$;8|
              |DROPT;adaptive;B$;9| (|Float|) (|AnyFunctions1| 23)
              (15 . |coerce|) |DROPT;pointColor;F$;10| (|Palette|)
              (|AnyFunctions1| 27) (20 . |coerce|) |DROPT;pointColor;P$;11|
              |DROPT;curveColor;F$;12| |DROPT;curveColor;P$;13|
              (|Mapping| (|DoubleFloat|) (|DoubleFloat|)) (|AnyFunctions1| 33)
              (25 . |coerce|) |DROPT;colorFunction;M$;14|
              (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))
              (|AnyFunctions1| 37) (30 . |coerce|) |DROPT;colorFunction;M$;15|
              (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|)
                         (|DoubleFloat|))
              (|AnyFunctions1| 41) (35 . |coerce|) |DROPT;colorFunction;M$;16|
              (|List| (|Segment| 23)) (|AnyFunctions1| 45) (40 . |coerce|)
              |DROPT;clip;L$;17|
              (|Mapping| (|Point| (|DoubleFloat|)) (|Point| (|DoubleFloat|)))
              (|AnyFunctions1| 49) (45 . |coerce|) |DROPT;coordinates;M$;18|
              |DROPT;tubeRadius;F$;19| |DROPT;range;L$;20|
              (|List| (|Segment| (|Fraction| (|Integer|))))
              (|AnyFunctions1| 55) (50 . |coerce|) |DROPT;range;L$;21|
              |DROPT;ranges;L$;22| (|ThreeSpace| (|DoubleFloat|))
              (|AnyFunctions1| 60) (55 . |coerce|) |DROPT;space;Ts$;23|
              (|PositiveInteger|) (|AnyFunctions1| 64) (60 . |coerce|)
              |DROPT;var1Steps;Pi$;24| |DROPT;var2Steps;Pi$;25|
              |DROPT;tubePoints;Pi$;26| |DROPT;coord;M$;27| (|List| 23)
              (|AnyFunctions1| 71) (65 . |coerce|) |DROPT;unit;L$;28|
              (|OutputForm|) (|Symbol|) (70 . |coerce|) (75 . |coerce|)
              (80 . =) |DROPT;coerce;$Of;29| (86 . =) |DROPT;=;2$B;30|
              (|List| $) |DROPT;option?;LSB;31| (|Union| 7 '"failed")
              |DROPT;option;LSU;32| (|SingleInteger|) (|HashState|))
           '#(~= 92 |viewpoint| 98 |var2Steps| 103 |var1Steps| 108 |unit| 113
              |tubeRadius| 118 |tubePoints| 123 |toScale| 128 |title| 133
              |style| 138 |space| 143 |ranges| 148 |range| 153 |pointColor| 163
              |option?| 173 |option| 179 |latex| 185 |hashUpdate!| 190 |hash|
              196 |curveColor| 201 |coordinates| 211 |coord| 216
              |colorFunction| 221 |coerce| 236 |clip| 241 |adaptive| 251 = 256)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 75))
                        (|makeByteWordVec2| 88
                                            '(1 9 7 8 10 1 13 7 12 14 1 18 7 17
                                              19 1 24 7 23 25 1 28 7 27 29 1 34
                                              7 33 35 1 38 7 37 39 1 42 7 41 43
                                              1 46 7 45 47 1 50 7 49 51 1 56 7
                                              55 57 1 61 7 60 62 1 65 7 64 66 1
                                              72 7 71 73 1 76 75 0 77 1 7 75 0
                                              78 2 75 0 0 0 79 2 7 17 0 0 81 2
                                              0 17 0 0 1 1 0 0 8 11 1 0 0 64 68
                                              1 0 0 64 67 1 0 0 71 74 1 0 0 23
                                              53 1 0 0 64 69 1 0 0 17 20 1 0 0
                                              12 15 1 0 0 12 16 1 0 0 60 63 1 0
                                              0 45 59 1 0 0 55 58 1 0 0 45 54 1
                                              0 0 27 30 1 0 0 23 26 2 0 17 83
                                              76 84 2 0 85 83 76 86 1 0 12 0 1
                                              2 0 88 88 0 1 1 0 87 0 1 1 0 0 27
                                              32 1 0 0 23 31 1 0 0 49 52 1 0 0
                                              49 70 1 0 0 37 40 1 0 0 41 44 1 0
                                              0 33 36 1 0 75 0 80 1 0 0 45 48 1
                                              0 0 17 21 1 0 0 17 22 2 0 17 0 0
                                              82)))))
           '|lookupComplete|)) 

(MAKEPROP '|DrawOption| 'NILADIC T) 
