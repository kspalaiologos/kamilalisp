
(SDEFUN |GRIMAGE;numberCheck| ((|nums| (|Point| (|DoubleFloat|))) ($ (|Void|)))
        (SPROG ((#1=#:G722 NIL) (#2=#:G718 NIL) (#3=#:G723 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |i| (SPADCALL |nums| (QREFELT $ 9)))
                      (LETT #3# (SPADCALL |nums| (QREFELT $ 10))) G190
                      (COND ((> |i| #3#) (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((COMPLEXP
                           (SPADCALL |nums|
                                     (PROG1 (LETT #2# |i|)
                                       (|check_subtype2| (> #2# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #2#))
                                     (QREFELT $ 12)))
                          (PROGN
                           (LETT #1#
                                 (|error|
                                  "An unexpected complex number was encountered in the calculations."))
                           (GO #4=#:G720))))))
                      (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                #4# (EXIT #1#)))) 

(SDEFUN |GRIMAGE;doOptions| ((|g| (|Rep|)) ($ (|Void|)))
        (SPROG
         ((|lu| (|List| (|Float|))) (|lr| (|List| (|Segment| (|Float|)))))
         (SEQ
          (LETT |lr|
                (SPADCALL (QVELT |g| 7) (SPADCALL |g| (QREFELT $ 14))
                          (QREFELT $ 17)))
          (COND
           ((> (LENGTH |lr|) 1)
            (QSETVELT |g| 1
                      (LIST
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |lr| 1 (QREFELT $ 19))
                                   (QREFELT $ 21))
                         (QREFELT $ 22))
                        (SPADCALL
                         (SPADCALL (SPADCALL |lr| 1 (QREFELT $ 19))
                                   (QREFELT $ 23))
                         (QREFELT $ 22))
                        (QREFELT $ 25))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |lr| 2 (QREFELT $ 19))
                                   (QREFELT $ 21))
                         (QREFELT $ 22))
                        (SPADCALL
                         (SPADCALL (SPADCALL |lr| 2 (QREFELT $ 19))
                                   (QREFELT $ 23))
                         (QREFELT $ 22))
                        (QREFELT $ 25)))))
           (#1='T (QSETVELT |g| 1 NIL)))
          (LETT |lu|
                (SPADCALL (QVELT |g| 7) (SPADCALL |g| (QREFELT $ 27))
                          (QREFELT $ 28)))
          (EXIT
           (COND
            ((> (LENGTH |lu|) 1)
             (QSETVELT |g| 2
                       (LIST
                        (SPADCALL (SPADCALL |lu| 1 (QREFELT $ 29))
                                  (QREFELT $ 22))
                        (SPADCALL (SPADCALL |lu| 2 (QREFELT $ 29))
                                  (QREFELT $ 22)))))
            (#1# (QSETVELT |g| 2 NIL))))))) 

(SDEFUN |GRIMAGE;putColorInfo;LLL;3|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|listOfPalettes| (|List| (|Palette|)))
         ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|llp2| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|lp2| (|List| (|Point| (|DoubleFloat|))))
          (|p| (|Point| (|DoubleFloat|))) (|d| (|PositiveInteger|))
          (#1=#:G753 NIL) (|daShade| (|DoubleFloat|)) (|daHue| (|DoubleFloat|))
          (#2=#:G751 NIL) (|lp| NIL) (#3=#:G752 NIL) (|pal| NIL))
         (SEQ (LETT |llp2| NIL)
              (SEQ (LETT |pal| NIL) (LETT #3# |listOfPalettes|) (LETT |lp| NIL)
                   (LETT #2# |llp|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |lp| (CAR #2#)) NIL)
                         (ATOM #3#) (PROGN (LETT |pal| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |lp2| NIL)
                        (LETT |daHue|
                              (FLOAT
                               (SPADCALL (SPADCALL |pal| (QREFELT $ 32))
                                         (QREFELT $ 33))
                               MOST-POSITIVE-DOUBLE-FLOAT))
                        (LETT |daShade|
                              (FLOAT (SPADCALL |pal| (QREFELT $ 34))
                                     MOST-POSITIVE-DOUBLE-FLOAT))
                        (SEQ (LETT #1# |lp|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (SEQ (LETT |d| (SPADCALL |p| (QREFELT $ 36)))
                                   (EXIT
                                    (COND
                                     ((< |d| 3)
                                      (LETT |p|
                                            (SPADCALL |p|
                                                      (LIST |daHue| |daShade|)
                                                      (QREFELT $ 38))))
                                     ('T
                                      (SEQ
                                       (SPADCALL |p| 3 |daHue| (QREFELT $ 39))
                                       (EXIT
                                        (COND
                                         ((< |d| 4)
                                          (LETT |p|
                                                (SPADCALL |p| (LIST |daShade|)
                                                          (QREFELT $ 38))))
                                         ('T
                                          (SPADCALL |p| 4 |daShade|
                                                    (QREFELT $ 39))))))))))
                              (EXIT (LETT |lp2| (CONS |p| |lp2|))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (LETT |llp2| (CONS (NREVERSE |lp2|) |llp2|))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (NREVERSE |llp2|))))) 

(SDEFUN |GRIMAGE;graph| ((|demRanges| (|List| (|Segment| (|Float|)))) ($ ($)))
        (SPROG ((|demRangesSF| (|List| (|Segment| (|DoubleFloat|)))))
               (SEQ
                (COND
                 ((NULL |demRanges|) (VECTOR 0 NIL NIL NIL NIL NIL NIL NIL))
                 ('T
                  (SEQ
                   (LETT |demRangesSF|
                         (LIST
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |demRanges| 1 (QREFELT $ 19))
                                      (QREFELT $ 21))
                            (QREFELT $ 22))
                           (SPADCALL
                            (SPADCALL (SPADCALL |demRanges| 1 (QREFELT $ 19))
                                      (QREFELT $ 23))
                            (QREFELT $ 22))
                           (QREFELT $ 25))
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |demRanges| 1 (QREFELT $ 19))
                                      (QREFELT $ 21))
                            (QREFELT $ 22))
                           (SPADCALL
                            (SPADCALL (SPADCALL |demRanges| 1 (QREFELT $ 19))
                                      (QREFELT $ 23))
                            (QREFELT $ 22))
                           (QREFELT $ 25))))
                   (EXIT (VECTOR 0 |demRangesSF| NIL NIL NIL NIL NIL NIL)))))))) 

(SDEFUN |GRIMAGE;scaleStep|
        ((|range_seg| (|Segment| (|DoubleFloat|))) ($ (|DoubleFloat|)))
        (SPROG
         ((|scaleDown| (|DoubleFloat|)) (|numerals| (|String|))
          (|tryStep| (|DoubleFloat|)) (|range| (|DoubleFloat|))
          (|adjust| (|NonNegativeInteger|)))
         (SEQ
          (LETT |range|
                (|sub_DF| (SPADCALL |range_seg| (QREFELT $ 43))
                          (SPADCALL |range_seg| (QREFELT $ 44))))
          (LETT |adjust| 0)
          (SEQ G190
               (COND ((NULL (|less_DF| |range| (|mk_DF| 100 0))) (GO G191)))
               (SEQ (LETT |adjust| (+ |adjust| 1))
                    (EXIT (LETT |range| (|mul_DF| |range| (|mk_DF| 10 0)))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT |tryStep| (|div_DF| |range| (|mk_DF| 10 0)))
          (LETT |numerals|
                (STRINGIMAGE
                 (SPADCALL (SPADCALL |tryStep| (QREFELT $ 45))
                           (QREFELT $ 46))))
          (LETT |scaleDown|
                (FLOAT (EXPT 10 (- (QCSIZE |numerals|) 1))
                       MOST-POSITIVE-DOUBLE-FLOAT))
          (EXIT
           (|div_DF|
            (|mul_DF| |scaleDown|
                      (SPADCALL
                       (|sub_DF| (|div_DF| |tryStep| |scaleDown|)
                                 (|mk_DF| 5 -1))
                       (QREFELT $ 45)))
            (FLOAT (EXPT 10 |adjust|) MOST-POSITIVE-DOUBLE-FLOAT)))))) 

(SDEFUN |GRIMAGE;figureUnits|
        ((|ranges| (|List| (|Segment| (|DoubleFloat|))))
         ($ (|List| (|DoubleFloat|))))
        (LIST (|GRIMAGE;scaleStep| (|SPADfirst| |ranges|) $)
              (|GRIMAGE;scaleStep| (SPADCALL |ranges| (QREFELT $ 48)) $))) 

(SDEFUN |GRIMAGE;roundRange|
        ((|range| (|Segment| (|DoubleFloat|))) ($ (|Segment| (|DoubleFloat|))))
        (SPROG
         ((|high| (|DoubleFloat|)) (|low| (|DoubleFloat|))
          (|single_eps| (|DoubleFloat|)))
         (SEQ (LETT |single_eps| (|expt_DF_I| (|mk_DF| 2 0) -19))
              (LETT |low| (SPADCALL |range| (QREFELT $ 44)))
              (LETT |low|
                    (COND
                     ((|less_DF| (|abs_DF| |low|) 1.0)
                      (|sub_DF| |low| |single_eps|))
                     ((|less_DF| |low| 0.0)
                      (|mul_DF| (|add_DF| (|mk_DF| 1 0) |single_eps|) |low|))
                     (#1='T
                      (|mul_DF| (|sub_DF| (|mk_DF| 1 0) |single_eps|) |low|))))
              (LETT |high| (SPADCALL |range| (QREFELT $ 43)))
              (LETT |high|
                    (COND
                     ((|less_DF| (|abs_DF| |high|) 1.0)
                      (|add_DF| |high| |single_eps|))
                     ((|less_DF| |high| 0.0)
                      (|mul_DF| (|sub_DF| (|mk_DF| 1 0) |single_eps|) |high|))
                     (#1#
                      (|mul_DF| (|add_DF| (|mk_DF| 1 0) |single_eps|)
                                |high|))))
              (EXIT (SPADCALL |low| |high| (QREFELT $ 49)))))) 

(SDEFUN |GRIMAGE;roundRanges|
        ((|ranges| (|List| (|Segment| (|DoubleFloat|))))
         ($ (|List| (|Segment| (|DoubleFloat|)))))
        (LIST (|GRIMAGE;roundRange| (|SPADfirst| |ranges|) $)
              (|GRIMAGE;roundRange| (SPADCALL |ranges| (QREFELT $ 48)) $))) 

(SDEFUN |GRIMAGE;plotLists|
        ((|graf| (|Rep|))
         (|listOfListsOfPoints| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|listOfPointColors| (|List| (|Palette|)))
         (|listOfLineColors| (|List| (|Palette|)))
         (|listOfPointSizes| (|List| (|PositiveInteger|))) ($ ($)))
        (SPROG
         ((#1=#:G808 NIL) (|givenLen| #2=(|NonNegativeInteger|))
          (#3=#:G798 NIL) (#4=#:G788 NIL) (|len| #2#) (#5=#:G813 NIL) (|l| NIL)
          (#6=#:G812 NIL))
         (SEQ (LETT |givenLen| (LENGTH |listOfListsOfPoints|))
              (LETT |listOfListsOfPoints|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |l| NIL) (LETT #5# |listOfListsOfPoints|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |l| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((NULL (NULL |l|)) (LETT #6# (CONS |l| #6#))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (COND
               ((NULL |listOfListsOfPoints|)
                (|error|
                 "GraphImage was given a list that contained no valid point lists")))
              (COND
               ((SPADCALL (LETT |len| (LENGTH |listOfListsOfPoints|))
                          |givenLen| (QREFELT $ 52))
                (SPADCALL "   Warning: Ignoring pointless point list"
                          (QREFELT $ 56))))
              (QSETVELT |graf| 3 |listOfListsOfPoints|)
              (SEQ (LETT |givenLen| (LENGTH |listOfPointColors|))
                   (EXIT
                    (COND
                     ((> |givenLen| |len|)
                      (QSETVELT |graf| 4
                                (SPADCALL |listOfPointColors|
                                          (SPADCALL
                                           (+
                                            (PROG1
                                                (LETT #4# (- |len| |givenLen|))
                                              (|check_subtype2| (>= #4# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #4#))
                                            1)
                                           (SPADCALL (QREFELT $ 58))
                                           (QREFELT $ 59))
                                          (QREFELT $ 60))))
                     (#7='T
                      (QSETVELT |graf| 4
                                (SPADCALL |listOfPointColors| |len|
                                          (QREFELT $ 61)))))))
              (SEQ (LETT |givenLen| (LENGTH |listOfLineColors|))
                   (EXIT
                    (COND
                     ((> |givenLen| |len|)
                      (QSETVELT |graf| 5
                                (SPADCALL |listOfLineColors|
                                          (SPADCALL
                                           (+
                                            (PROG1
                                                (LETT #3# (- |len| |givenLen|))
                                              (|check_subtype2| (>= #3# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #3#))
                                            1)
                                           (SPADCALL (QREFELT $ 62))
                                           (QREFELT $ 59))
                                          (QREFELT $ 60))))
                     (#7#
                      (QSETVELT |graf| 5
                                (SPADCALL |listOfLineColors| |len|
                                          (QREFELT $ 61)))))))
              (SEQ (LETT |givenLen| (LENGTH |listOfPointSizes|))
                   (EXIT
                    (COND
                     ((> |givenLen| |len|)
                      (QSETVELT |graf| 6
                                (SPADCALL |listOfPointSizes|
                                          (SPADCALL
                                           (+
                                            (PROG1
                                                (LETT #1# (- |len| |givenLen|))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            1)
                                           (SPADCALL (QREFELT $ 63))
                                           (QREFELT $ 65))
                                          (QREFELT $ 66))))
                     (#7#
                      (QSETVELT |graf| 6
                                (SPADCALL |listOfPointSizes| |len|
                                          (QREFELT $ 67)))))))
              (EXIT |graf|)))) 

(SDEFUN |GRIMAGE;sendGraphImage;$V;10| ((|graf| ($)) ($ (|Void|)))
        (SPROG
         ((|hueShade| (|Integer|)) (|aPoint| #1=(|Point| (|DoubleFloat|)))
          (#2=#:G832 NIL) (|p| NIL) (#3=#:G828 NIL) (|aList| NIL)
          (#4=#:G829 NIL) (|pColor| NIL) (#5=#:G830 NIL) (|lColor| NIL)
          (#6=#:G831 NIL) (|tonto| (|List| (|Segment| (|DoubleFloat|))))
          (|transform| (|Mapping| #1# (|Point| (|DoubleFloat|))))
          (|s| (|NonNegativeInteger|)))
         (SEQ (|GRIMAGE;doOptions| |graf| $)
              (LETT |s| (LENGTH (QVELT |graf| 3)))
              (EXIT
               (COND
                ((EQL |s| 0)
                 (|error| "You are trying to make a graph with no points"))
                ((SPADCALL (SPADCALL |graf| (QREFELT $ 68)) 0 (QREFELT $ 69))
                 (|error| "You are trying to draw over an existing graph"))
                ('T
                 (SEQ
                  (LETT |transform|
                        (SPADCALL (QVELT |graf| 7) (ELT $ 71) (QREFELT $ 73)))
                  (QSETVELT |graf| 3
                            (SPADCALL (QVELT |graf| 3) (QVELT |graf| 4)
                                      (QREFELT $ 42)))
                  (COND
                   ((NULL (SPADCALL |graf| (QREFELT $ 14)))
                    (QSETVELT |graf| 1
                              (SPADCALL (QVELT |graf| 3) (QREFELT $ 75)))))
                  (QSETVELT |graf| 1
                            (|GRIMAGE;roundRanges| (QVELT |graf| 1) $))
                  (COND
                   ((NULL (SPADCALL |graf| (QREFELT $ 27)))
                    (QSETVELT |graf| 2
                              (|GRIMAGE;figureUnits| (QVELT |graf| 1) $))))
                  (SPADCALL
                   "   Graph data being transmitted to the viewport manager..."
                   (QREFELT $ 56))
                  (|sockSendInt| |$ViewportServer| 2)
                  (|sockSendInt| |$ViewportServer| -1)
                  (LETT |tonto| (QVELT |graf| 1))
                  (|sockSendFloat| |$ViewportServer|
                                   (SPADCALL (|SPADfirst| |tonto|)
                                             (QREFELT $ 44)))
                  (|sockSendFloat| |$ViewportServer|
                                   (SPADCALL (|SPADfirst| |tonto|)
                                             (QREFELT $ 43)))
                  (|sockSendFloat| |$ViewportServer|
                                   (SPADCALL (SPADCALL |tonto| (QREFELT $ 48))
                                             (QREFELT $ 44)))
                  (|sockSendFloat| |$ViewportServer|
                                   (SPADCALL (SPADCALL |tonto| (QREFELT $ 48))
                                             (QREFELT $ 43)))
                  (|sockSendFloat| |$ViewportServer|
                                   (|SPADfirst| (QVELT |graf| 2)))
                  (|sockSendFloat| |$ViewportServer|
                                   (SPADCALL (QVELT |graf| 2) (QREFELT $ 76)))
                  (|sockSendInt| |$ViewportServer| |s|)
                  (SEQ (LETT #6# (QVELT |graf| 6)) (LETT |lColor| NIL)
                       (LETT #5# (QVELT |graf| 5)) (LETT |pColor| NIL)
                       (LETT #4# (QVELT |graf| 4)) (LETT |aList| NIL)
                       (LETT #3# (QVELT |graf| 3)) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |aList| (CAR #3#)) NIL)
                             (ATOM #4#) (PROGN (LETT |pColor| (CAR #4#)) NIL)
                             (ATOM #5#) (PROGN (LETT |lColor| (CAR #5#)) NIL)
                             (ATOM #6#) (PROGN (LETT |s| (CAR #6#)) NIL))
                         (GO G191)))
                       (SEQ (|sockSendInt| |$ViewportServer| (LENGTH |aList|))
                            (SEQ (LETT |p| NIL) (LETT #2# |aList|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |p| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |aPoint| (SPADCALL |p| |transform|))
                                  (|sockSendFloat| |$ViewportServer|
                                                   (SPADCALL |aPoint|
                                                             (QREFELT $ 78)))
                                  (|sockSendFloat| |$ViewportServer|
                                                   (SPADCALL |aPoint|
                                                             (QREFELT $ 79)))
                                  (|sockSendFloat| |$ViewportServer|
                                                   (SPADCALL |p|
                                                             (QREFELT $ 80)))
                                  (EXIT
                                   (|sockSendFloat| |$ViewportServer|
                                                    (SPADCALL |p|
                                                              (QREFELT $
                                                                       81)))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |hueShade|
                                  (+
                                   (SPADCALL (SPADCALL |pColor| (QREFELT $ 32))
                                             (QREFELT $ 33))
                                   (* (SPADCALL |pColor| (QREFELT $ 34))
                                      (SPADCALL (QREFELT $ 82)))))
                            (|sockSendInt| |$ViewportServer| |hueShade|)
                            (LETT |hueShade|
                                  (+
                                   (SPADCALL
                                    (-
                                     (SPADCALL
                                      (SPADCALL |lColor| (QREFELT $ 32))
                                      (QREFELT $ 33))
                                     1)
                                    5 (QREFELT $ 84))
                                   (SPADCALL |lColor| (QREFELT $ 34))))
                            (|sockSendInt| |$ViewportServer| |hueShade|)
                            (EXIT (|sockSendInt| |$ViewportServer| |s|)))
                       (LETT #3#
                             (PROG1 (CDR #3#)
                               (LETT #4#
                                     (PROG1 (CDR #4#)
                                       (LETT #5#
                                             (PROG1 (CDR #5#)
                                               (LETT #6# (CDR #6#))))))))
                       (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (QSETVELT |graf| 0 (|sockGetInt| |$ViewportServer|)))))))))) 

(PUT '|GRIMAGE;key;$I;11| '|SPADreplace| '(XLAM (|graf|) (QVELT |graf| 0))) 

(SDEFUN |GRIMAGE;key;$I;11| ((|graf| ($)) ($ (|Integer|))) (QVELT |graf| 0)) 

(PUT '|GRIMAGE;pointLists;$L;12| '|SPADreplace|
     '(XLAM (|graf|) (QVELT |graf| 3))) 

(SDEFUN |GRIMAGE;pointLists;$L;12|
        ((|graf| ($)) ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (QVELT |graf| 3)) 

(SDEFUN |GRIMAGE;ranges;$L;13|
        ((|graf| ($)) ($ (|List| (|Segment| (|Float|)))))
        (COND ((NULL (QVELT |graf| 1)) NIL)
              ('T
               (LIST
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL (QVELT |graf| 1) 1 (QREFELT $ 87))
                            (QREFELT $ 44))
                  (QREFELT $ 88))
                 (SPADCALL
                  (SPADCALL (SPADCALL (QVELT |graf| 1) 1 (QREFELT $ 87))
                            (QREFELT $ 43))
                  (QREFELT $ 88))
                 (QREFELT $ 89))
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL (QVELT |graf| 1) 2 (QREFELT $ 87))
                            (QREFELT $ 44))
                  (QREFELT $ 88))
                 (SPADCALL
                  (SPADCALL (SPADCALL (QVELT |graf| 1) 2 (QREFELT $ 87))
                            (QREFELT $ 43))
                  (QREFELT $ 88))
                 (QREFELT $ 89)))))) 

(SDEFUN |GRIMAGE;ranges;$2L;14|
        ((|graf| ($)) (|rangesList| (|List| (|Segment| (|Float|))))
         ($ (|List| (|Segment| (|Float|)))))
        (SEQ
         (QSETVELT |graf| 1
                   (LIST
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |rangesList| 1 (QREFELT $ 19))
                                (QREFELT $ 21))
                      (QREFELT $ 22))
                     (SPADCALL
                      (SPADCALL (SPADCALL |rangesList| 1 (QREFELT $ 19))
                                (QREFELT $ 23))
                      (QREFELT $ 22))
                     (QREFELT $ 25))
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |rangesList| 2 (QREFELT $ 19))
                                (QREFELT $ 21))
                      (QREFELT $ 22))
                     (SPADCALL
                      (SPADCALL (SPADCALL |rangesList| 2 (QREFELT $ 19))
                                (QREFELT $ 23))
                      (QREFELT $ 22))
                     (QREFELT $ 25))))
         (EXIT |rangesList|))) 

(SDEFUN |GRIMAGE;units;$L;15| ((|graf| ($)) ($ (|List| (|Float|))))
        (COND ((NULL (QVELT |graf| 2)) NIL)
              ('T
               (LIST
                (SPADCALL (SPADCALL (QVELT |graf| 2) 1 (QREFELT $ 91))
                          (QREFELT $ 88))
                (SPADCALL (SPADCALL (QVELT |graf| 2) 2 (QREFELT $ 91))
                          (QREFELT $ 88)))))) 

(SDEFUN |GRIMAGE;units;$2L;16|
        ((|graf| ($)) (|unitsToBe| (|List| (|Float|))) ($ (|List| (|Float|))))
        (SEQ
         (QSETVELT |graf| 2
                   (LIST
                    (SPADCALL (SPADCALL |unitsToBe| 1 (QREFELT $ 29))
                              (QREFELT $ 22))
                    (SPADCALL (SPADCALL |unitsToBe| 2 (QREFELT $ 29))
                              (QREFELT $ 22))))
         (EXIT |unitsToBe|))) 

(SDEFUN |GRIMAGE;graphImage;$;17| (($ ($))) (|GRIMAGE;graph| NIL $)) 

(SDEFUN |GRIMAGE;makeGraphImage;L$;18|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|))))) ($ ($)))
        (SPROG
         ((#1=#:G857 NIL) (|i| NIL) (#2=#:G856 NIL) (#3=#:G855 NIL)
          (#4=#:G854 NIL) (#5=#:G853 NIL) (|l| (|Integer|)) (#6=#:G852 NIL))
         (SEQ
          (SPADCALL |llp|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |i| 1) (LETT #5# (LETT |l| (LENGTH |llp|)))
                          G190 (COND ((|greater_SI| |i| #5#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6# (CONS (SPADCALL (QREFELT $ 58)) #6#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #6#))))
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |i| 1) (LETT #3# |l|) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4# (CONS (SPADCALL (QREFELT $ 62)) #4#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 1) (LETT #1# |l|) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2# (CONS (SPADCALL (QREFELT $ 63)) #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 95))))) 

(SDEFUN |GRIMAGE;makeGraphImage;L2LL$;19|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|lpc| (|List| (|Palette|))) (|llc| (|List| (|Palette|)))
         (|lps| (|List| (|PositiveInteger|))) ($ ($)))
        (SPADCALL |llp| |lpc| |llc| |lps| NIL (QREFELT $ 97))) 

(SDEFUN |GRIMAGE;makeGraphImage;L2LLL$;20|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|)))))
         (|lpc| (|List| (|Palette|))) (|llc| (|List| (|Palette|)))
         (|lps| (|List| (|PositiveInteger|))) (|opts| (|List| (|DrawOption|)))
         ($ ($)))
        (SPROG
         ((|aPoint| #1=(|Point| (|DoubleFloat|))) (#2=#:G868 NIL) (|p| NIL)
          (#3=#:G867 NIL) (|aList| NIL)
          (|transform| (|Mapping| #1# (|Point| (|DoubleFloat|)))) (|graf| ($)))
         (SEQ
          (LETT |graf|
                (|GRIMAGE;graph| (SPADCALL |opts| NIL (QREFELT $ 17)) $))
          (QSETVELT |graf| 7 |opts|)
          (LETT |graf| (|GRIMAGE;plotLists| |graf| |llp| |lpc| |llc| |lps| $))
          (LETT |transform|
                (SPADCALL (QVELT |graf| 7) (ELT $ 71) (QREFELT $ 73)))
          (SEQ (LETT |aList| NIL) (LETT #3# (QVELT |graf| 3)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |aList| (CAR #3#)) NIL))
                 (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |p| NIL) (LETT #2# |aList|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |aPoint| (SPADCALL |p| |transform|))
                           (EXIT (|GRIMAGE;numberCheck| |aPoint| $)))
                      (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT |graf|)))) 

(SDEFUN |GRIMAGE;component;$L2PPiV;21|
        ((|graf| ($)) (|ListOfPoints| (|List| (|Point| (|DoubleFloat|))))
         (|PointColor| (|Palette|)) (|LineColor| (|Palette|))
         (|PointSize| (|PositiveInteger|)) ($ (|Void|)))
        (SEQ
         (QSETVELT |graf| 3
                   (SPADCALL (QVELT |graf| 3) (LIST |ListOfPoints|)
                             (QREFELT $ 98)))
         (QSETVELT |graf| 4
                   (SPADCALL (QVELT |graf| 4) (LIST |PointColor|)
                             (QREFELT $ 99)))
         (QSETVELT |graf| 5
                   (SPADCALL (QVELT |graf| 5) (LIST |LineColor|)
                             (QREFELT $ 99)))
         (EXIT
          (QSETVELT |graf| 6
                    (SPADCALL (QVELT |graf| 6) (LIST |PointSize|)
                              (QREFELT $ 100)))))) 

(SDEFUN |GRIMAGE;component;$PV;22|
        ((|graf| ($)) (|aPoint| (|Point| (|DoubleFloat|))) ($ (|Void|)))
        (SPADCALL |graf| |aPoint| (SPADCALL (QREFELT $ 58))
                  (SPADCALL (QREFELT $ 62)) (SPADCALL (QREFELT $ 63))
                  (QREFELT $ 103))) 

(SDEFUN |GRIMAGE;component;$P2PPiV;23|
        ((|graf| ($)) (|aPoint| (|Point| (|DoubleFloat|)))
         (|PointColor| (|Palette|)) (|LineColor| (|Palette|))
         (|PointSize| (|PositiveInteger|)) ($ (|Void|)))
        (SPADCALL |graf| (LIST |aPoint|) |PointColor| |LineColor| |PointSize|
                  (QREFELT $ 102))) 

(SDEFUN |GRIMAGE;appendPoint;$PV;24|
        ((|graf| ($)) (|aPoint| (|Point| (|DoubleFloat|))) ($ (|Void|)))
        (SPROG ((|num| (|Integer|)))
               (SEQ (LETT |num| (- (LENGTH (QVELT |graf| 3)) 1))
                    (EXIT
                     (COND
                      ((< |num| 0) (|error| "No point lists to append to!"))
                      ('T
                       (SPADCALL (QVELT |graf| 3) |num|
                                 (SPADCALL
                                  (SPADCALL (QVELT |graf| 3) |num|
                                            (QREFELT $ 105))
                                  (LIST |aPoint|) (QREFELT $ 106))
                                 (QREFELT $ 107)))))))) 

(SDEFUN |GRIMAGE;point;$PPV;25|
        ((|graf| ($)) (|aPoint| (|Point| (|DoubleFloat|)))
         (|PointColor| (|Palette|)) ($ (|Void|)))
        (SPADCALL |graf| |aPoint| |PointColor| (SPADCALL (QREFELT $ 62))
                  (SPADCALL (QREFELT $ 63)) (QREFELT $ 103))) 

(SDEFUN |GRIMAGE;coerce;L$;26|
        ((|llp| (|List| (|List| (|Point| (|DoubleFloat|))))) ($ ($)))
        (SPROG
         ((#1=#:G889 NIL) (|i| NIL) (#2=#:G888 NIL) (#3=#:G887 NIL)
          (#4=#:G886 NIL) (#5=#:G885 NIL) (|l| (|Integer|)) (#6=#:G884 NIL))
         (SEQ
          (SPADCALL |llp|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |i| 1) (LETT #5# (LETT |l| (LENGTH |llp|)))
                          G190 (COND ((|greater_SI| |i| #5#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6# (CONS (SPADCALL (QREFELT $ 58)) #6#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #6#))))
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |i| 1) (LETT #3# |l|) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4# (CONS (SPADCALL (QREFELT $ 62)) #4#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 1) (LETT #1# |l|) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2# (CONS (SPADCALL (QREFELT $ 63)) #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 95))))) 

(SDEFUN |GRIMAGE;coerce;$Of;27| ((|graf| ($)) ($ (|OutputForm|)))
        (SPROG ((|p| (|NonNegativeInteger|)))
               (SPADCALL
                (LIST (SPADCALL "Graph with " (QREFELT $ 112))
                      (SPADCALL
                       (LETT |p| (LENGTH (SPADCALL |graf| (QREFELT $ 86))))
                       (QREFELT $ 113))
                      (SPADCALL
                       (COND ((EQL |p| 1) " point list") ('T " point lists"))
                       (QREFELT $ 112)))
                (QREFELT $ 115)))) 

(DECLAIM (NOTINLINE |GraphImage;|)) 

(DEFUN |GraphImage| ()
  (SPROG NIL
         (PROG (#1=#:G892)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GraphImage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GraphImage|
                             (LIST (CONS NIL (CONS 1 (|GraphImage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|GraphImage|)))))))))) 

(DEFUN |GraphImage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GraphImage|))
          (LETT $ (GETREFV 118))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GraphImage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |key| (|Integer|))
                              (|:| |rangesField|
                                   (|List| (|Segment| (|DoubleFloat|))))
                              (|:| |unitsField| (|List| (|DoubleFloat|)))
                              (|:| |llPoints|
                                   (|List| (|List| (|Point| (|DoubleFloat|)))))
                              (|:| |pointColors| (|List| (|Palette|)))
                              (|:| |lineColors| (|List| (|Palette|)))
                              (|:| |pointSizes| (|List| (|PositiveInteger|)))
                              (|:| |optionsField| (|List| (|DrawOption|)))))
          $))) 

(MAKEPROP '|GraphImage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Integer|) (|Point| 11)
              (0 . |minIndex|) (5 . |maxIndex|) (|DoubleFloat|) (10 . |elt|)
              (|List| 18) |GRIMAGE;ranges;$L;13| (|List| (|DrawOption|))
              (|DrawOptionFunctions0|) (16 . |ranges|) (|Segment| 20)
              (22 . |elt|) (|Float|) (28 . |low|) (33 . |convert|)
              (38 . |high|) (|Segment| 11) (43 . |segment|) (|List| 20)
              |GRIMAGE;units;$L;15| (49 . |units|) (55 . |elt|) (|Color|)
              (|Palette|) (61 . |hue|) (66 . |hue|) (71 . |shade|)
              (|PositiveInteger|) (76 . |dimension|) (|List| 11)
              (81 . |extend|) (87 . |setelt!|) (|List| 101) (|List| 31)
              |GRIMAGE;putColorInfo;LLL;3| (94 . |high|) (99 . |low|)
              (104 . |ceiling|) (109 . |retract|) (|List| 24) (114 . |second|)
              (119 . SEGMENT) (|Boolean|) (|NonNegativeInteger|) (125 . ~=)
              (|Void|) (|String|) (|DisplayPackage|) (131 . |say|)
              (|ViewDefaultsPackage|) (136 . |pointColorDefault|) (140 . |new|)
              (146 . |concat|) (152 . |first|) (158 . |lineColorDefault|)
              (162 . |pointSizeDefault|) (|List| 35) (166 . |new|)
              (172 . |concat|) (178 . |first|) |GRIMAGE;key;$I;11| (184 . ~=)
              (|CoordinateSystems| 11) (190 . |cartesian|) (|Mapping| 8 8)
              (195 . |coord|) (|PlotTools|) (201 . |calcRanges|)
              (206 . |second|) (|PointPackage| 11) (211 . |xCoord|)
              (216 . |yCoord|) (221 . |hue|) (226 . |shade|)
              (231 . |numberOfHues|) (|SingleInteger|) (235 . *)
              |GRIMAGE;sendGraphImage;$V;10| |GRIMAGE;pointLists;$L;12|
              (241 . |elt|) (247 . |convert|) (252 . |segment|)
              |GRIMAGE;ranges;$2L;14| (258 . |elt|) (264 . |One|)
              |GRIMAGE;units;$2L;16| |GRIMAGE;graphImage;$;17|
              |GRIMAGE;makeGraphImage;L2LL$;19| |GRIMAGE;makeGraphImage;L$;18|
              |GRIMAGE;makeGraphImage;L2LLL$;20| (268 . |append|)
              (274 . |append|) (280 . |append|) (|List| 8)
              |GRIMAGE;component;$L2PPiV;21| |GRIMAGE;component;$P2PPiV;23|
              |GRIMAGE;component;$PV;22| (286 . |elt|) (292 . |append|)
              (298 . |setelt!|) |GRIMAGE;appendPoint;$PV;24|
              |GRIMAGE;point;$PPV;25| |GRIMAGE;coerce;L$;26| (|OutputForm|)
              (305 . |message|) (310 . |coerce|) (|List| $) (315 . |hconcat|)
              |GRIMAGE;coerce;$Of;27| (|HashState|))
           '#(~= 320 |units| 326 |sendGraphImage| 337 |ranges| 342
              |putColorInfo| 353 |pointLists| 359 |point| 364 |makeGraphImage|
              371 |latex| 393 |key| 398 |hashUpdate!| 403 |hash| 409
              |graphImage| 414 |component| 418 |coerce| 442 |appendPoint| 452 =
              458)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 111))
                        (|makeByteWordVec2| 117
                                            '(1 8 7 0 9 1 8 7 0 10 2 8 11 0 7
                                              12 2 16 13 15 13 17 2 13 18 0 7
                                              19 1 18 20 0 21 1 20 11 0 22 1 18
                                              20 0 23 2 24 0 11 11 25 2 16 26
                                              15 26 28 2 26 20 0 7 29 1 31 30 0
                                              32 1 30 7 0 33 1 31 7 0 34 1 8 35
                                              0 36 2 8 0 0 37 38 3 8 11 0 7 11
                                              39 1 24 11 0 43 1 24 11 0 44 1 11
                                              0 0 45 1 11 7 0 46 1 47 24 0 48 2
                                              24 0 11 11 49 2 51 50 0 0 52 1 55
                                              53 54 56 0 57 31 58 2 41 0 51 31
                                              59 2 41 0 0 0 60 2 41 0 0 51 61 0
                                              57 31 62 0 57 35 63 2 64 0 51 35
                                              65 2 64 0 0 0 66 2 64 0 0 51 67 2
                                              7 50 0 0 69 1 70 8 8 71 2 16 72
                                              15 72 73 1 74 47 40 75 1 37 11 0
                                              76 1 77 11 8 78 1 77 11 8 79 1 77
                                              11 8 80 1 77 11 8 81 0 30 35 82 2
                                              83 0 7 0 84 2 47 24 0 7 87 1 11
                                              20 0 88 2 18 0 20 20 89 2 37 11 0
                                              7 91 0 20 0 92 2 40 0 0 0 98 2 41
                                              0 0 0 99 2 64 0 0 0 100 2 40 101
                                              0 7 105 2 101 0 0 0 106 3 40 101
                                              0 7 101 107 1 111 0 54 112 1 51
                                              111 0 113 1 111 0 114 115 2 0 50
                                              0 0 1 1 0 26 0 27 2 0 26 0 26 93
                                              1 0 53 0 85 2 0 13 0 13 90 1 0 13
                                              0 14 2 0 40 40 41 42 1 0 40 0 86
                                              3 0 53 0 8 31 109 4 0 0 40 41 41
                                              64 95 5 0 0 40 41 41 64 15 97 1 0
                                              0 40 96 1 0 54 0 1 1 0 7 0 68 2 0
                                              117 117 0 1 1 0 83 0 1 0 0 0 94 2
                                              0 53 0 8 104 5 0 53 0 8 31 31 35
                                              103 5 0 53 0 101 31 31 35 102 1 0
                                              0 40 110 1 0 111 0 116 2 0 53 0 8
                                              108 2 0 50 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|GraphImage| 'NILADIC T) 
