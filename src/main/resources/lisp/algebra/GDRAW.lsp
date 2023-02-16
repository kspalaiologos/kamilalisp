
(SDEFUN |GDRAW;gnuDraw;ESbSLV;1|
        ((|f| (|Expression| (|Float|)))
         (|segbind| (|SegmentBinding| (|Float|))) (|filename| (|String|))
         (|opts| (|List| (|DrawOption|))) ($ (|Void|)))
        (SPROG
         ((#1=#:G713 NIL) (|p| NIL) (#2=#:G712 NIL) (|p1| NIL)
          (|p2| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|f1| (|TextFile|)))
         (SEQ
          (LETT |f1|
                (SPADCALL (SPADCALL |filename| (QREFELT $ 8)) "output"
                          (QREFELT $ 10)))
          (SPADCALL |f1|
                    (SPADCALL
                     (LIST "set title \"" (SPADCALL |opts| "" (QREFELT $ 13))
                           "\"")
                     (QREFELT $ 15))
                    (QREFELT $ 16))
          (SPADCALL |f1| "plot '-' title '' lw 3 with lines" (QREFELT $ 16))
          (LETT |p2|
                (SPADCALL (SPADCALL |f| |segbind| |opts| (QREFELT $ 21))
                          (QREFELT $ 23)))
          (SEQ (LETT |p1| NIL) (LETT #2# |p2|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |p1| (CAR #2#)) NIL)) (GO G191)))
               (SEQ
                (SEQ (LETT |p| NIL) (LETT #1# |p1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |f1|
                                 (SPADCALL
                                  (LIST
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 1 (QREFELT $ 30))
                                              (QREFELT $ 31))
                                    (QREFELT $ 32))
                                   " "
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 2 (QREFELT $ 30))
                                              (QREFELT $ 31))
                                    (QREFELT $ 32)))
                                  (QREFELT $ 15))
                                 (QREFELT $ 16))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |f1| (QREFELT $ 33))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |f1| (QREFELT $ 34)))))) 

(SDEFUN |GDRAW;gnuDraw;2LSLV;2|
        ((|l1| (|List| (|DoubleFloat|))) (|l2| (|List| (|DoubleFloat|)))
         (|filename| (|String|)) (|opts| (|List| (|DrawOption|))) ($ (|Void|)))
        (SPROG
         ((#1=#:G727 NIL) (|p| NIL) (#2=#:G726 NIL) (|p1| NIL)
          (|p2| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|lp| (|List| (|Point| (|DoubleFloat|)))) (#3=#:G724 NIL) (|x| NIL)
          (#4=#:G725 NIL) (|y| NIL) (#5=#:G723 NIL) (|f1| (|TextFile|)))
         (SEQ
          (LETT |f1|
                (SPADCALL (SPADCALL |filename| (QREFELT $ 8)) "output"
                          (QREFELT $ 10)))
          (SPADCALL |f1|
                    (SPADCALL
                     (LIST "set title \"" (SPADCALL |opts| "" (QREFELT $ 13))
                           "\"")
                     (QREFELT $ 15))
                    (QREFELT $ 16))
          (SPADCALL |f1| "plot '-' title '' lw 3 with lines" (QREFELT $ 16))
          (LETT |lp|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |y| NIL) (LETT #4# |l2|) (LETT |x| NIL)
                      (LETT #3# |l1|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)
                            (ATOM #4#) (PROGN (LETT |y| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #5#
                              (CONS (SPADCALL (LIST |x| |y|) (QREFELT $ 38))
                                    #5#))))
                      (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                      (GO G190) G191 (EXIT (NREVERSE #5#)))))
          (LETT |p2|
                (SPADCALL (SPADCALL (LIST |lp|) (QREFELT $ 39))
                          (QREFELT $ 23)))
          (SEQ (LETT |p1| NIL) (LETT #2# |p2|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |p1| (CAR #2#)) NIL)) (GO G191)))
               (SEQ
                (SEQ (LETT |p| NIL) (LETT #1# |p1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |f1|
                                 (SPADCALL
                                  (LIST
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 1 (QREFELT $ 30))
                                              (QREFELT $ 40))
                                    (QREFELT $ 32))
                                   " "
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 2 (QREFELT $ 30))
                                              (QREFELT $ 40))
                                    (QREFELT $ 32)))
                                  (QREFELT $ 15))
                                 (QREFELT $ 16))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |f1| (QREFELT $ 33))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |f1| (QREFELT $ 34)))))) 

(SDEFUN |GDRAW;gnuDraw;ESbSV;3|
        ((|f| (|Expression| (|Float|)))
         (|segbind| (|SegmentBinding| (|Float|))) (|filename| (|String|))
         ($ (|Void|)))
        (SPADCALL |f| |segbind| |filename| (LIST (SPADCALL "" (QREFELT $ 43)))
                  (QREFELT $ 36))) 

(SDEFUN |GDRAW;gnuDraw;2LSV;4|
        ((|l1| (|List| (|DoubleFloat|))) (|l2| (|List| (|DoubleFloat|)))
         (|filename| (|String|)) ($ (|Void|)))
        (SPADCALL |l1| |l2| |filename| (LIST (SPADCALL "" (QREFELT $ 43)))
                  (QREFELT $ 41))) 

(SDEFUN |GDRAW;gnuDraw;E2SbSLV;5|
        ((|f| (|Expression| (|Float|)))
         (|segbind1| (|SegmentBinding| (|Float|)))
         (|segbind2| (|SegmentBinding| (|Float|))) (|filename| (|String|))
         (|opts| (|List| (|DrawOption|))) ($ (|Void|)))
        (SPROG
         ((#1=#:G738 NIL) (|p| NIL) (#2=#:G737 NIL) (|p1| NIL)
          (|p2| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|f1| (|TextFile|)))
         (SEQ
          (LETT |f1|
                (SPADCALL (SPADCALL |filename| (QREFELT $ 8)) "output"
                          (QREFELT $ 10)))
          (SPADCALL |f1|
                    (SPADCALL
                     (LIST "set title \"" (SPADCALL |opts| "" (QREFELT $ 13))
                           "\"")
                     (QREFELT $ 15))
                    (QREFELT $ 16))
          (SPADCALL |f1| "splot '-' title '' with pm3d" (QREFELT $ 16))
          (LETT |p2|
                (SPADCALL (SPADCALL |f| |segbind1| |segbind2| (QREFELT $ 47))
                          (QREFELT $ 48)))
          (SEQ (LETT |p1| NIL) (LETT #2# |p2|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |p1| (CAR #2#)) NIL)) (GO G191)))
               (SEQ
                (SEQ (LETT |p| NIL) (LETT #1# |p1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |f1|
                                 (SPADCALL
                                  (LIST
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 1 (QREFELT $ 30))
                                              (QREFELT $ 31))
                                    (QREFELT $ 32))
                                   " "
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 2 (QREFELT $ 30))
                                              (QREFELT $ 31))
                                    (QREFELT $ 32))
                                   " "
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| 3 (QREFELT $ 30))
                                              (QREFELT $ 31))
                                    (QREFELT $ 32)))
                                  (QREFELT $ 15))
                                 (QREFELT $ 16))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |f1| (QREFELT $ 33))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |f1| (QREFELT $ 34)))))) 

(SDEFUN |GDRAW;gnuDraw;E2SbSV;6|
        ((|f| (|Expression| (|Float|)))
         (|segbind1| (|SegmentBinding| (|Float|)))
         (|segbind2| (|SegmentBinding| (|Float|))) (|filename| (|String|))
         ($ (|Void|)))
        (SPADCALL |f| |segbind1| |segbind2| |filename|
                  (LIST (SPADCALL "" (QREFELT $ 43))) (QREFELT $ 49))) 

(DECLAIM (NOTINLINE |GnuDraw;|)) 

(DEFUN |GnuDraw| ()
  (SPROG NIL
         (PROG (#1=#:G741)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GnuDraw|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GnuDraw|
                             (LIST (CONS NIL (CONS 1 (|GnuDraw;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|GnuDraw|)))))))))) 

(DEFUN |GnuDraw;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GnuDraw|))
          (LETT $ (GETREFV 51))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GnuDraw| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GnuDraw| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|String|) (|FileName|) (0 . |coerce|)
              (|TextFile|) (5 . |open|) (|List| 42) (|DrawOptionFunctions0|)
              (11 . |title|) (|List| $) (17 . |concat|) (22 . |writeLine!|)
              (|GraphImage|) (|Expression| (|Float|))
              (|SegmentBinding| (|Float|)) (|TopLevelDrawFunctions| 18)
              (28 . |makeObject|) (|List| (|List| 29)) (35 . |pointLists|)
              (40 . |One|) (|InputForm|) (44 . |One|) (|DoubleFloat|)
              (|Integer|) (|Point| 27) (48 . |elt|) (54 . |convert|)
              (59 . |unparse|) (64 . |writeLine!|) (69 . |close!|) (|Void|)
              |GDRAW;gnuDraw;ESbSLV;1| (|List| 27) (74 . |point|)
              (79 . |makeGraphImage|) (84 . |convert|) |GDRAW;gnuDraw;2LSLV;2|
              (|DrawOption|) (89 . |title|) |GDRAW;gnuDraw;ESbSV;3|
              |GDRAW;gnuDraw;2LSV;4| (|ThreeSpace| 27) (94 . |makeObject|)
              (101 . |mesh|) |GDRAW;gnuDraw;E2SbSLV;5|
              |GDRAW;gnuDraw;E2SbSV;6|)
           '#(|gnuDraw| 106) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|gnuDraw|
                                 ((|Void|) (|Expression| (|Float|))
                                  (|SegmentBinding| (|Float|)) (|String|)
                                  (|List| (|DrawOption|))))
                                T)
                              '((|gnuDraw|
                                 ((|Void|) (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|)) (|String|)
                                  (|List| (|DrawOption|))))
                                T)
                              '((|gnuDraw|
                                 ((|Void|) (|Expression| (|Float|))
                                  (|SegmentBinding| (|Float|)) (|String|)))
                                T)
                              '((|gnuDraw|
                                 ((|Void|) (|List| (|DoubleFloat|))
                                  (|List| (|DoubleFloat|)) (|String|)))
                                T)
                              '((|gnuDraw|
                                 ((|Void|) (|Expression| (|Float|))
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|)) (|String|)
                                  (|List| (|DrawOption|))))
                                T)
                              '((|gnuDraw|
                                 ((|Void|) (|Expression| (|Float|))
                                  (|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Float|)) (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 50
                                            '(1 7 0 6 8 2 9 0 7 6 10 2 12 6 11
                                              6 13 1 6 0 14 15 2 9 6 0 6 16 3
                                              20 17 18 19 11 21 1 17 22 0 23 0
                                              18 0 24 0 25 0 26 2 29 27 0 28 30
                                              1 25 0 27 31 1 25 6 0 32 1 9 6 0
                                              33 1 9 0 0 34 1 29 0 37 38 1 17 0
                                              22 39 1 27 25 0 40 1 42 0 6 43 3
                                              20 46 18 19 19 47 1 46 22 0 48 4
                                              0 35 18 19 6 11 36 3 0 35 18 19 6
                                              44 4 0 35 37 37 6 11 41 3 0 35 37
                                              37 6 45 4 0 35 18 19 19 6 50 5 0
                                              35 18 19 19 6 11 49)))))
           '|lookupComplete|)) 

(MAKEPROP '|GnuDraw| 'NILADIC T) 
