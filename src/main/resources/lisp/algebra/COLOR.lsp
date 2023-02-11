
(SDEFUN |COLOR;*;Df2$;1| ((|f| (|DoubleFloat|)) (|c| ($)) ($ ($)))
        (COND ((|zero?_DF| |f|) |c|)
              ('T (CONS (QCAR |c|) (|mul_DF| |f| (QCDR |c|)))))) 

(SDEFUN |COLOR;+;3$;2| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|ans| #1=(|Integer|)) (|offset| (|Integer|)) (|diff| #1#)
          (|moreThanHalf| (|Boolean|)) (|xHueSmaller| (|Boolean|)) (|c| ($)))
         (SEQ
          (COND
           ((EQL (QCAR |x|) (QCAR |y|))
            (CONS (QCAR |x|) (|add_DF| (QCDR |x|) (QCDR |y|))))
           (#2='T
            (SEQ
             (COND
              ((SPADCALL (QCDR |y|) (QCDR |x|) (QREFELT $ 10))
               (SEQ (LETT |c| |x|) (LETT |x| |y|) (EXIT (LETT |y| |c|)))))
             (LETT |diff| (- (QCAR |x|) (QCAR |y|)))
             (SEQ (LETT |xHueSmaller| (< |diff| 0))
                  (EXIT (COND (|xHueSmaller| (LETT |diff| (- |diff|))))))
             (SEQ (LETT |moreThanHalf| (> |diff| (QUOTIENT2 27 2)))
                  (EXIT (COND (|moreThanHalf| (LETT |diff| (- 27 |diff|))))))
             (LETT |offset|
                   (TRUNCATE
                    (SPADCALL
                     (|div_DF| (FLOAT |diff| MOST-POSITIVE-DOUBLE-FLOAT)
                               (SPADCALL (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT)
                                         (|div_DF| (QCDR |x|) (QCDR |y|))
                                         (QREFELT $ 11)))
                     (QREFELT $ 12))))
             (COND
              (|xHueSmaller|
               (COND
                (|moreThanHalf|
                 (COND
                  ((OR |xHueSmaller| (NULL |moreThanHalf|))
                   (LETT |ans| (- (QCAR |x|) |offset|)))
                  ('T (LETT |ans| (+ (QCAR |x|) |offset|)))))
                (#2# (LETT |ans| (+ (QCAR |x|) |offset|)))))
              (|moreThanHalf| (LETT |ans| (+ (QCAR |x|) |offset|)))
              (#2# (LETT |ans| (- (QCAR |x|) |offset|))))
             (COND ((< |ans| 0) (LETT |ans| (+ 27 |ans|)))
                   ((> |ans| 27) (LETT |ans| (- |ans| 27))))
             (EXIT (CONS |ans| 1.0)))))))) 

(SDEFUN |COLOR;=;2$B;3| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((EQL (QCAR |x|) (QCAR |y|)) (|eql_DF| (QCDR |x|) (QCDR |y|)))
              ('T NIL))) 

(PUT '|COLOR;red;$;4| '|SPADreplace| '(XLAM NIL (CONS 1 1.0))) 

(SDEFUN |COLOR;red;$;4| (($ ($))) (CONS 1 1.0)) 

(PUT '|COLOR;yellow;$;5| '|SPADreplace| '(XLAM NIL (CONS 11 1.0))) 

(SDEFUN |COLOR;yellow;$;5| (($ ($))) (CONS 11 1.0)) 

(PUT '|COLOR;green;$;6| '|SPADreplace| '(XLAM NIL (CONS 14 1.0))) 

(SDEFUN |COLOR;green;$;6| (($ ($))) (CONS 14 1.0)) 

(PUT '|COLOR;blue;$;7| '|SPADreplace| '(XLAM NIL (CONS 22 1.0))) 

(SDEFUN |COLOR;blue;$;7| (($ ($))) (CONS 22 1.0)) 

(PUT '|COLOR;hue;$I;8| '|SPADreplace| 'QCAR) 

(SDEFUN |COLOR;hue;$I;8| ((|c| ($)) ($ (|Integer|))) (QCAR |c|)) 

(SDEFUN |COLOR;*;Pi2$;9| ((|i| (|PositiveInteger|)) (|c| ($)) ($ ($)))
        (SPADCALL (FLOAT |i| MOST-POSITIVE-DOUBLE-FLOAT) |c| (QREFELT $ 8))) 

(PUT '|COLOR;numberOfHues;Pi;10| '|SPADreplace| '(XLAM NIL 27)) 

(SDEFUN |COLOR;numberOfHues;Pi;10| (($ (|PositiveInteger|))) 27) 

(SDEFUN |COLOR;color;I$;11| ((|i| (|Integer|)) ($ ($)))
        (SEQ
         (COND
          ((OR (< |i| 0) (> |i| 27))
           (|error|
            (STRCONC "Color should be in the range 1.." (STRINGIMAGE 27)))))
         (EXIT (CONS |i| 1.0)))) 

(SDEFUN |COLOR;coerce;$Of;12| ((|c| ($)) ($ (|OutputForm|)))
        (SPADCALL
         (LIST (SPADCALL "Hue: " (QREFELT $ 27))
               (SPADCALL (QCAR |c|) (QREFELT $ 28))
               (SPADCALL "  Weight: " (QREFELT $ 27))
               (SPADCALL (QCDR |c|) (QREFELT $ 29)))
         (QREFELT $ 31))) 

(DECLAIM (NOTINLINE |Color;|)) 

(DEFUN |Color| ()
  (SPROG NIL
         (PROG (#1=#:G737)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Color|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Color|
                             (LIST (CONS NIL (CONS 1 (|Color;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Color|)))))))))) 

(DEFUN |Color;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Color|))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Color| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |hue| (|Integer|))
                              (|:| |weight| (|DoubleFloat|))))
          $))) 

(MAKEPROP '|Color| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|DoubleFloat|) |COLOR;*;Df2$;1|
              (|Boolean|) (0 . >) (6 . ^) (12 . |round|) |COLOR;+;3$;2|
              |COLOR;=;2$B;3| |COLOR;red;$;4| |COLOR;yellow;$;5|
              |COLOR;green;$;6| |COLOR;blue;$;7| (|Integer|) |COLOR;hue;$I;8|
              (|PositiveInteger|) |COLOR;*;Pi2$;9| |COLOR;numberOfHues;Pi;10|
              |COLOR;color;I$;11| (|String|) (|OutputForm|) (17 . |message|)
              (22 . |coerce|) (27 . |coerce|) (|List| $) (32 . |hconcat|)
              |COLOR;coerce;$Of;12| (|HashState|) (|SingleInteger|))
           '#(~= 37 |yellow| 43 |red| 47 |numberOfHues| 51 |latex| 55 |hue| 60
              |hashUpdate!| 65 |hash| 71 |green| 76 |color| 80 |coerce| 85
              |blue| 90 = 94 + 100 * 106)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|AbelianSemiGroup&| |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|AbelianSemiGroup|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 26))
                        (|makeByteWordVec2| 34
                                            '(2 7 9 0 0 10 2 7 0 0 0 11 1 7 0 0
                                              12 1 26 0 25 27 1 19 26 0 28 1 7
                                              26 0 29 1 26 0 30 31 2 0 9 0 0 1
                                              0 0 0 16 0 0 0 15 0 0 21 23 1 0
                                              25 0 1 1 0 19 0 20 2 0 33 33 0 1
                                              1 0 34 0 1 0 0 0 17 1 0 0 19 24 1
                                              0 26 0 32 0 0 0 18 2 0 9 0 0 14 2
                                              0 0 0 0 13 2 0 0 7 0 8 2 0 0 21 0
                                              22)))))
           '|lookupComplete|)) 

(MAKEPROP '|Color| 'NILADIC T) 
