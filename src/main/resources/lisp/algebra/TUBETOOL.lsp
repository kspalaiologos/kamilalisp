
(SDEFUN |TUBETOOL;point;4DfP;1|
        ((|x| (|DoubleFloat|)) (|y| (|DoubleFloat|)) (|z| (|DoubleFloat|))
         (|c| #1=(|DoubleFloat|)) ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| #1#)))
               (SPADCALL (LETT |l| (LIST |x| |y| |z| |c|)) (QREFELT $ 8)))) 

(SDEFUN |TUBETOOL;getColor|
        ((|pt| (|Point| (|DoubleFloat|))) ($ (|DoubleFloat|)))
        (COND
         ((> (SPADCALL |pt| (QREFELT $ 12)) 3) (SPADCALL |pt| (QREFELT $ 14)))
         ('T 0.0))) 

(SDEFUN |TUBETOOL;getColor2|
        ((|p0| (|Point| (|DoubleFloat|))) (|p1| (|Point| (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (COND
         ((> (SPADCALL |p0| (QREFELT $ 12)) 3) (SPADCALL |p0| (QREFELT $ 14)))
         ((> (SPADCALL |p1| (QREFELT $ 12)) 3) (SPADCALL |p1| (QREFELT $ 14)))
         ('T 0.0))) 

(SDEFUN |TUBETOOL;*;Df2P;4|
        ((|a| (|DoubleFloat|)) (|p| (|Point| (|DoubleFloat|)))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| (|DoubleFloat|))))
               (SEQ
                (LETT |l|
                      (LIST (|mul_DF| |a| (SPADCALL |p| (QREFELT $ 15)))
                            (|mul_DF| |a| (SPADCALL |p| (QREFELT $ 16)))
                            (|mul_DF| |a| (SPADCALL |p| (QREFELT $ 17)))
                            (|TUBETOOL;getColor| |p| $)))
                (EXIT (SPADCALL |l| (QREFELT $ 8)))))) 

(SDEFUN |TUBETOOL;+;3P;5|
        ((|p0| (|Point| (|DoubleFloat|))) (|p1| (|Point| (|DoubleFloat|)))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| (|DoubleFloat|))))
               (SEQ
                (LETT |l|
                      (LIST
                       (|add_DF| (SPADCALL |p0| (QREFELT $ 15))
                                 (SPADCALL |p1| (QREFELT $ 15)))
                       (|add_DF| (SPADCALL |p0| (QREFELT $ 16))
                                 (SPADCALL |p1| (QREFELT $ 16)))
                       (|add_DF| (SPADCALL |p0| (QREFELT $ 17))
                                 (SPADCALL |p1| (QREFELT $ 17)))
                       (|TUBETOOL;getColor2| |p0| |p1| $)))
                (EXIT (SPADCALL |l| (QREFELT $ 8)))))) 

(SDEFUN |TUBETOOL;-;3P;6|
        ((|p0| (|Point| (|DoubleFloat|))) (|p1| (|Point| (|DoubleFloat|)))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|l| (|List| (|DoubleFloat|))))
               (SEQ
                (LETT |l|
                      (LIST
                       (|sub_DF| (SPADCALL |p0| (QREFELT $ 15))
                                 (SPADCALL |p1| (QREFELT $ 15)))
                       (|sub_DF| (SPADCALL |p0| (QREFELT $ 16))
                                 (SPADCALL |p1| (QREFELT $ 16)))
                       (|sub_DF| (SPADCALL |p0| (QREFELT $ 17))
                                 (SPADCALL |p1| (QREFELT $ 17)))
                       (|TUBETOOL;getColor2| |p0| |p1| $)))
                (EXIT (SPADCALL |l| (QREFELT $ 8)))))) 

(SDEFUN |TUBETOOL;dot;2PDf;7|
        ((|p0| (|Point| (|DoubleFloat|))) (|p1| (|Point| (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (|add_DF|
         (|add_DF|
          (|mul_DF| (SPADCALL |p0| (QREFELT $ 15))
                    (SPADCALL |p1| (QREFELT $ 15)))
          (|mul_DF| (SPADCALL |p0| (QREFELT $ 16))
                    (SPADCALL |p1| (QREFELT $ 16))))
         (|mul_DF| (SPADCALL |p0| (QREFELT $ 17))
                   (SPADCALL |p1| (QREFELT $ 17))))) 

(SDEFUN |TUBETOOL;cross;3P;8|
        ((|p0| (|Point| (|DoubleFloat|))) (|p1| (|Point| (|DoubleFloat|)))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG
         ((|l| (|List| (|DoubleFloat|))) (|z1| #1=(|DoubleFloat|))
          (|y1| #2=(|DoubleFloat|)) (|x1| #3=(|DoubleFloat|)) (|z0| #1#)
          (|y0| #2#) (|x0| #3#))
         (SEQ (LETT |x0| (SPADCALL |p0| (QREFELT $ 15)))
              (LETT |y0| (SPADCALL |p0| (QREFELT $ 16)))
              (LETT |z0| (SPADCALL |p0| (QREFELT $ 17)))
              (LETT |x1| (SPADCALL |p1| (QREFELT $ 15)))
              (LETT |y1| (SPADCALL |p1| (QREFELT $ 16)))
              (LETT |z1| (SPADCALL |p1| (QREFELT $ 17)))
              (LETT |l|
                    (LIST (|sub_DF| (|mul_DF| |y0| |z1|) (|mul_DF| |y1| |z0|))
                          (|sub_DF| (|mul_DF| |z0| |x1|) (|mul_DF| |z1| |x0|))
                          (|sub_DF| (|mul_DF| |x0| |y1|) (|mul_DF| |x1| |y0|))
                          (|TUBETOOL;getColor2| |p0| |p1| $)))
              (EXIT (SPADCALL |l| (QREFELT $ 8)))))) 

(SDEFUN |TUBETOOL;unitVector;2P;9|
        ((|p| (|Point| (|DoubleFloat|))) ($ (|Point| (|DoubleFloat|))))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |p| |p| (QREFELT $ 21)) (QREFELT $ 23))
                   (QREFELT $ 24))
         |p| (QREFELT $ 18))) 

(SDEFUN |TUBETOOL;cosSinInfo;IL;10|
        ((|n| (|Integer|)) ($ (|List| (|List| (|DoubleFloat|)))))
        (SPROG
         ((|ans| (|List| (|List| (|DoubleFloat|)))) (|angle| (|DoubleFloat|))
          (#1=#:G732 NIL) (|i| NIL) (|theta| (|DoubleFloat|)))
         (SEQ (LETT |ans| NIL)
              (LETT |theta|
                    (|div_DF_I|
                     (SPADCALL 2 (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT)
                               (QREFELT $ 27))
                     |n|))
              (SEQ (LETT |i| 1) (LETT #1# (- |n| 1)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ (LETT |angle| (SPADCALL |i| |theta| (QREFELT $ 29)))
                        (EXIT
                         (LETT |ans|
                               (CONS
                                (LIST (|cos_DF| |angle|) (|sin_DF| |angle|))
                                |ans|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |TUBETOOL;loopPoints;3PDfLL;11|
        ((|ctr| (|Point| (|DoubleFloat|))) (|pNorm| (|Point| (|DoubleFloat|)))
         (|bNorm| (|Point| (|DoubleFloat|))) (|rad| (|DoubleFloat|))
         (|cosSin| (|List| (|List| (|DoubleFloat|))))
         ($ (|List| (|Point| (|DoubleFloat|)))))
        (SPROG
         ((|pt| (|Point| (|DoubleFloat|)))
          (|ans| (|List| (|Point| (|DoubleFloat|)))) (|sin| (|DoubleFloat|))
          (|cos| (|DoubleFloat|)) (|cossin| (|List| (|DoubleFloat|))))
         (SEQ (LETT |ans| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |cosSin|))) (GO G191)))
                   (SEQ (LETT |cossin| (|SPADfirst| |cosSin|))
                        (LETT |cos| (|SPADfirst| |cossin|))
                        (LETT |sin| (SPADCALL |cossin| (QREFELT $ 32)))
                        (LETT |ans|
                              (CONS
                               (SPADCALL |ctr|
                                         (SPADCALL |rad|
                                                   (SPADCALL
                                                    (SPADCALL |cos| |pNorm|
                                                              (QREFELT $ 18))
                                                    (SPADCALL |sin| |bNorm|
                                                              (QREFELT $ 18))
                                                    (QREFELT $ 19))
                                                   (QREFELT $ 18))
                                         (QREFELT $ 19))
                               |ans|))
                        (EXIT (LETT |cosSin| (CDR |cosSin|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |pt|
                    (SPADCALL |ctr| (SPADCALL |rad| |pNorm| (QREFELT $ 18))
                              (QREFELT $ 19)))
              (EXIT (CONS |pt| (SPADCALL |ans| |pt| (QREFELT $ 34))))))) 

(DECLAIM (NOTINLINE |TubePlotTools;|)) 

(DEFUN |TubePlotTools| ()
  (SPROG NIL
         (PROG (#1=#:G750)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|TubePlotTools|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|TubePlotTools|
                             (LIST (CONS NIL (CONS 1 (|TubePlotTools;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|TubePlotTools|)))))))))) 

(DEFUN |TubePlotTools;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TubePlotTools|))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TubePlotTools| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TubePlotTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| 9) (|Point| 9) (0 . |point|)
              (|DoubleFloat|) |TUBETOOL;point;4DfP;1| (|Integer|)
              (5 . |maxIndex|) (|PointPackage| 9) (10 . |color|)
              (15 . |xCoord|) (20 . |yCoord|) (25 . |zCoord|)
              |TUBETOOL;*;Df2P;4| |TUBETOOL;+;3P;5| |TUBETOOL;-;3P;6|
              |TUBETOOL;dot;2PDf;7| |TUBETOOL;cross;3P;8| (30 . |sqrt|)
              (35 . |inv|) |TUBETOOL;unitVector;2P;9| (|PositiveInteger|)
              (40 . *) (|NonNegativeInteger|) (46 . *) (|List| 6)
              |TUBETOOL;cosSinInfo;IL;10| (52 . |second|) (|List| 7)
              (57 . |concat|) |TUBETOOL;loopPoints;3PDfLL;11|)
           '#(|unitVector| 63 |point| 68 |loopPoints| 76 |dot| 85 |cross| 91
              |cosSinInfo| 97 - 102 + 108 * 114)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|point|
                                 ((|Point| (|DoubleFloat|)) (|DoubleFloat|)
                                  (|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|)))
                                T)
                              '((*
                                 ((|Point| (|DoubleFloat|)) (|DoubleFloat|)
                                  (|Point| (|DoubleFloat|))))
                                T)
                              '((+
                                 ((|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))))
                                T)
                              '((-
                                 ((|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))))
                                T)
                              '((|dot|
                                 ((|DoubleFloat|) (|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))))
                                T)
                              '((|cross|
                                 ((|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))))
                                T)
                              '((|unitVector|
                                 ((|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))))
                                T)
                              '((|cosSinInfo|
                                 ((|List| (|List| (|DoubleFloat|)))
                                  (|Integer|)))
                                T)
                              '((|loopPoints|
                                 ((|List| (|Point| (|DoubleFloat|)))
                                  (|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|))
                                  (|Point| (|DoubleFloat|)) (|DoubleFloat|)
                                  (|List| (|List| (|DoubleFloat|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(1 7 0 6 8 1 7 11 0 12 1 13 9 7 14
                                              1 13 9 7 15 1 13 9 7 16 1 13 9 7
                                              17 1 9 0 0 23 1 9 0 0 24 2 9 0 26
                                              0 27 2 9 0 28 0 29 1 6 9 0 32 2
                                              33 0 0 7 34 1 0 7 7 25 4 0 7 9 9
                                              9 9 10 5 0 33 7 7 7 9 30 35 2 0 9
                                              7 7 21 2 0 7 7 7 22 1 0 30 11 31
                                              2 0 7 7 7 20 2 0 7 7 7 19 2 0 7 9
                                              7 18)))))
           '|lookupComplete|)) 

(MAKEPROP '|TubePlotTools| 'NILADIC T) 
