
(SDEFUN |DFELEM;log_plus_1;2Df;1| ((|x| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (SPROG ((|x2| (|DoubleFloat|)) (|x1| (|DoubleFloat|)))
               (SEQ (LETT |x1| (|add_DF| |x| 1.0))
                    (COND
                     ((OR (SPADCALL |x| (QREFELT $ 8) (QREFELT $ 14))
                          (|less_DF| |x| (|minus_DF| (QREFELT $ 8))))
                      (EXIT (SPADCALL |x1| (QREFELT $ 15)))))
                    (LETT |x2| (|mul_DF| (QREFELT $ 8) (|add_DF| 1.0 |x1|)))
                    (EXIT
                     (|mul_DF| |x|
                               (SPADCALL (|mul_DF| |x2| |x2|) |x1|
                                         (QREFELT $ 19))))))) 

(SDEFUN |DFELEM;atanh;2C;2|
        ((|z| (|Complex| (|DoubleFloat|))) ($ (|Complex| (|DoubleFloat|))))
        (SPROG
         ((|ri| (|DoubleFloat|)) (|t2| #1=(|DoubleFloat|))
          (|rr| (|DoubleFloat|)) (|t| (|DoubleFloat|)) (|sy| (|DoubleFloat|))
          (|u| #1#) (|s| (|DoubleFloat|)) (|ay| (|DoubleFloat|))
          (|y| (|DoubleFloat|)) (|x| (|DoubleFloat|)))
         (SEQ (LETT |x| (SPADCALL |z| (QREFELT $ 22)))
              (LETT |y| (SPADCALL |z| (QREFELT $ 23)))
              (EXIT
               (COND
                ((|less_DF| |x| 0.0)
                 (SPADCALL
                  (SPADCALL (SPADCALL |z| (QREFELT $ 24)) (QREFELT $ 25))
                  (QREFELT $ 24)))
                (#2='T
                 (SEQ (LETT |ay| (|abs_DF| |y|))
                      (COND
                       ((OR (SPADCALL |x| (QREFELT $ 6) (QREFELT $ 14))
                            (SPADCALL |ay| (QREFELT $ 6) (QREFELT $ 14)))
                        (EXIT
                         (SEQ
                          (LETT |s|
                                (|mul_DF_I| (QREFELT $ 9)
                                            (SPADCALL |y| (QREFELT $ 27))))
                          (EXIT
                           (COND
                            ((SPADCALL |x| |ay| (QREFELT $ 14))
                             (SEQ (LETT |t| (|div_DF| |ay| |x|))
                                  (LETT |t|
                                        (|div_DF| 1.0
                                                  (|add_DF| 1.0
                                                            (|mul_DF| |t|
                                                                      |t|))))
                                  (EXIT
                                   (SPADCALL (|div_DF| |t| |x|) |s|
                                             (QREFELT $ 28)))))
                            (#2#
                             (SEQ (LETT |t| (|div_DF| |x| |ay|))
                                  (LETT |t|
                                        (|div_DF| |t|
                                                  (|add_DF| 1.0
                                                            (|mul_DF| |t|
                                                                      |t|))))
                                  (EXIT
                                   (SPADCALL (|div_DF| |t| |ay|) |s|
                                             (QREFELT $ 28)))))))))))
                      (COND
                       ((|less_DF| |x| (QREFELT $ 8))
                        (COND
                         ((|less_DF| |ay| (QREFELT $ 8))
                          (EXIT
                           (SPADCALL |z|
                                     (SPADCALL (|spadConstant| $ 29)
                                               (SPADCALL (|spadConstant| $ 29)
                                                         (SPADCALL |z| |z|
                                                                   (QREFELT $
                                                                            30))
                                                         (QREFELT $ 31))
                                               (QREFELT $ 32))
                                     (QREFELT $ 30)))))))
                      (LETT |u| (|sub_DF| 1.0 |x|))
                      (LETT |sy|
                            (FLOAT (SPADCALL |y| (QREFELT $ 27))
                                   MOST-POSITIVE-DOUBLE-FLOAT))
                      (EXIT
                       (COND
                        ((|eql_DF| |u| 0.0)
                         (COND
                          ((|eql_DF| |y| 0.0)
                           (|error| "atanh: evaluating at pole"))
                          (#2#
                           (SEQ
                            (LETT |t|
                                  (|add_DF| (QREFELT $ 10) (|mul_DF| |y| |y|)))
                            (LETT |rr|
                                  (SPADCALL
                                   (|div_DF|
                                    (SPADCALL (SPADCALL |t| (QREFELT $ 33))
                                              (QREFELT $ 33))
                                    (SPADCALL |ay| (QREFELT $ 33)))
                                   (QREFELT $ 15)))
                            (LETT |ri|
                                  (|mul_DF| (|mul_DF| (QREFELT $ 8) |sy|)
                                            (|add_DF| (QREFELT $ 9)
                                                      (|atan_DF|
                                                       (|mul_DF| (QREFELT $ 8)
                                                                 |ay|)))))
                            (EXIT (SPADCALL |rr| |ri| (QREFELT $ 28)))))))
                        (#2#
                         (SEQ
                          (LETT |t|
                                (|add_DF| (|mul_DF| |u| |u|)
                                          (|mul_DF| |ay| |ay|)))
                          (LETT |rr|
                                (|mul_DF| (QREFELT $ 11)
                                          (SPADCALL
                                           (|div_DF|
                                            (|mul_DF| (QREFELT $ 10) |x|) |t|)
                                           (QREFELT $ 20))))
                          (LETT |t2|
                                (|sub_DF| (|mul_DF| |u| (|add_DF| 1.0 |x|))
                                          (|mul_DF| |ay| |ay|)))
                          (LETT |ri|
                                (COND
                                 ((|less_DF| |ay| |t2|)
                                  (|mul_DF| (QREFELT $ 8)
                                            (|atan_DF|
                                             (|div_DF|
                                              (|mul_DF| (QREFELT $ 7) |y|)
                                              |t2|))))
                                 ((|eql_DF| |y| 0.0)
                                  (|mul_DF| |sy| (QREFELT $ 9)))
                                 (#2#
                                  (|mul_DF| (|mul_DF| (QREFELT $ 8) |sy|)
                                            (|sub_DF| (QREFELT $ 9)
                                                      (|atan_DF|
                                                       (|div_DF| |t2|
                                                                 (|mul_DF|
                                                                  (QREFELT $ 7)
                                                                  |ay|))))))))
                          (EXIT (SPADCALL |rr| |ri| (QREFELT $ 28)))))))))))))) 

(DECLAIM (NOTINLINE |DoubleFloatElementaryFunctions;|)) 

(DEFUN |DoubleFloatElementaryFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G722)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|DoubleFloatElementaryFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|DoubleFloatElementaryFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|DoubleFloatElementaryFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|DoubleFloatElementaryFunctions|)))))))))) 

(DEFUN |DoubleFloatElementaryFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DoubleFloatElementaryFunctions|))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DoubleFloatElementaryFunctions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|mk_DF| 1 30))
          (QSETREFV $ 7 (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT))
          (QSETREFV $ 8 (|div_DF| 1.0 (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT)))
          (QSETREFV $ 9
                    (|div_DF| (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT)
                              (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT)))
          (QSETREFV $ 10 (FLOAT 4 MOST-POSITIVE-DOUBLE-FLOAT))
          (QSETREFV $ 11 (|div_DF| 1.0 (FLOAT 4 MOST-POSITIVE-DOUBLE-FLOAT)))
          $))) 

(MAKEPROP '|DoubleFloatElementaryFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|large| '|two| '|half| '|half_pi|
              '|four| '|fourth| (|Boolean|) (|DoubleFloat|) (0 . >) (6 . |log|)
              (|Fraction| 26) (11 . |One|) (|DoubleFloatEllipticIntegrals|)
              (15 . |ellipticRC|) |DFELEM;log_plus_1;2Df;1| (|Complex| 13)
              (21 . |real|) (26 . |imag|) (31 . -) |DFELEM;atanh;2C;2|
              (|Integer|) (36 . |sign|) (41 . |complex|) (47 . |One|) (51 . *)
              (57 . -) (63 . |ellipticRC|) (69 . |sqrt|))
           '#(|log_plus_1| 74 |atanh| 79) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|log_plus_1|
                                 ((|DoubleFloat|) (|DoubleFloat|)))
                                T)
                              '((|atanh|
                                 ((|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 33
                                            '(2 13 12 0 0 14 1 13 0 0 15 0 16 0
                                              17 2 18 13 13 13 19 1 21 13 0 22
                                              1 21 13 0 23 1 21 0 0 24 1 13 26
                                              0 27 2 21 0 13 13 28 0 21 0 29 2
                                              21 0 0 0 30 2 21 0 0 0 31 2 18 21
                                              21 21 32 1 13 0 0 33 1 0 13 13 20
                                              1 0 21 21 25)))))
           '|lookupComplete|)) 

(MAKEPROP '|DoubleFloatElementaryFunctions| 'NILADIC T) 
