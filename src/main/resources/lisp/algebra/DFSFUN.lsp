
(PUT '|DFSFUN;polygamma;Nni2C;1| '|SPADreplace| '|c_psi|) 

(SDEFUN |DFSFUN;polygamma;Nni2C;1|
        ((|k| (|NonNegativeInteger|)) (|z| (|Complex| (|DoubleFloat|)))
         ($ (|Complex| (|DoubleFloat|))))
        (|c_psi| |k| |z|)) 

(PUT '|DFSFUN;besselJ;3C;2| '|SPADreplace| '|c_besselj|) 

(SDEFUN |DFSFUN;besselJ;3C;2|
        ((|v| (|Complex| (|DoubleFloat|))) (|z| (|Complex| (|DoubleFloat|)))
         ($ (|Complex| (|DoubleFloat|))))
        (|c_besselj| |v| |z|)) 

(PUT '|DFSFUN;besselJ;3Df;3| '|SPADreplace| '|r_besselj|) 

(SDEFUN |DFSFUN;besselJ;3Df;3|
        ((|n| (|DoubleFloat|)) (|x| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (|r_besselj| |n| |x|)) 

(PUT '|DFSFUN;besselI;3C;4| '|SPADreplace| '|c_besseli|) 

(SDEFUN |DFSFUN;besselI;3C;4|
        ((|v| (|Complex| (|DoubleFloat|))) (|z| (|Complex| (|DoubleFloat|)))
         ($ (|Complex| (|DoubleFloat|))))
        (|c_besseli| |v| |z|)) 

(PUT '|DFSFUN;besselI;3Df;5| '|SPADreplace| '|r_besseli|) 

(SDEFUN |DFSFUN;besselI;3Df;5|
        ((|n| (|DoubleFloat|)) (|x| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (|r_besseli| |n| |x|)) 

(SDEFUN |DFSFUN;digamma;2C;6|
        ((|z| (|Complex| (|DoubleFloat|))) ($ (|Complex| (|DoubleFloat|))))
        (SPADCALL 0 |z| (QREFELT $ 8))) 

(SDEFUN |DFSFUN;besselY;3Df;7|
        ((|n| (|DoubleFloat|)) (|x| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (SPROG ((|vp| (|DoubleFloat|)))
               (SEQ
                (COND
                 ((SPADCALL |n| (QREFELT $ 19))
                  (LETT |n| (|add_DF| |n| (QREFELT $ 16)))))
                (LETT |vp|
                      (|mul_DF| |n| (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT)))
                (EXIT
                 (|div_DF|
                  (|sub_DF|
                   (|mul_DF| (|cos_DF| |vp|) (SPADCALL |n| |x| (QREFELT $ 11)))
                   (SPADCALL (|minus_DF| |n|) |x| (QREFELT $ 11)))
                  (|sin_DF| |vp|)))))) 

(SDEFUN |DFSFUN;besselY;3C;8|
        ((|v| (|Complex| (|DoubleFloat|))) (|z| (|Complex| (|DoubleFloat|)))
         ($ (|Complex| (|DoubleFloat|))))
        (SPROG ((|vp| (|Complex| (|DoubleFloat|))))
               (SEQ
                (COND
                 ((SPADCALL |v| (QREFELT $ 22))
                  (LETT |v|
                        (SPADCALL |v| (SPADCALL (QREFELT $ 16) (QREFELT $ 23))
                                  (QREFELT $ 24)))))
                (LETT |vp|
                      (SPADCALL |v| (SPADCALL (QREFELT $ 25)) (QREFELT $ 26)))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL |vp| (QREFELT $ 27))
                             (SPADCALL |v| |z| (QREFELT $ 9)) (QREFELT $ 26))
                   (SPADCALL (SPADCALL |v| (QREFELT $ 28)) |z| (QREFELT $ 9))
                   (QREFELT $ 29))
                  (SPADCALL |vp| (QREFELT $ 30)) (QREFELT $ 31)))))) 

(SDEFUN |DFSFUN;besselK;3Df;9|
        ((|n| (|DoubleFloat|)) (|x| (|DoubleFloat|)) ($ (|DoubleFloat|)))
        (SPROG
         ((|ahalf| (|DoubleFloat|)) (|vp| (|DoubleFloat|))
          (|p| (|DoubleFloat|)))
         (SEQ
          (COND
           ((SPADCALL |n| (QREFELT $ 19))
            (LETT |n| (|add_DF| |n| (QREFELT $ 16)))))
          (LETT |p| (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT))
          (LETT |vp| (|mul_DF| |n| |p|))
          (LETT |ahalf| (|div_DF| 1.0 (FLOAT 2 MOST-POSITIVE-DOUBLE-FLOAT)))
          (EXIT
           (|div_DF|
            (|mul_DF| (|mul_DF| |p| |ahalf|)
                      (|sub_DF| (SPADCALL (|minus_DF| |n|) |x| (QREFELT $ 13))
                                (SPADCALL |n| |x| (QREFELT $ 13))))
            (|sin_DF| |vp|)))))) 

(SDEFUN |DFSFUN;besselK;3C;10|
        ((|v| (|Complex| (|DoubleFloat|))) (|z| (|Complex| (|DoubleFloat|)))
         ($ (|Complex| (|DoubleFloat|))))
        (SPROG
         ((|ahalf| (|Complex| (|DoubleFloat|)))
          (|vp| (|Complex| (|DoubleFloat|))) (|p| (|Complex| (|DoubleFloat|))))
         (SEQ
          (COND
           ((SPADCALL |v| (QREFELT $ 22))
            (LETT |v|
                  (SPADCALL |v| (SPADCALL (QREFELT $ 16) (QREFELT $ 23))
                            (QREFELT $ 24)))))
          (LETT |p| (SPADCALL (QREFELT $ 25)))
          (LETT |vp| (SPADCALL |v| |p| (QREFELT $ 26)))
          (LETT |ahalf|
                (SPADCALL (|spadConstant| $ 33) (SPADCALL 2 (QREFELT $ 36))
                          (QREFELT $ 31)))
          (EXIT
           (SPADCALL
            (SPADCALL (SPADCALL |p| |ahalf| (QREFELT $ 26))
                      (SPADCALL
                       (SPADCALL (SPADCALL |v| (QREFELT $ 28)) |z|
                                 (QREFELT $ 12))
                       (SPADCALL |v| |z| (QREFELT $ 12)) (QREFELT $ 29))
                      (QREFELT $ 26))
            (SPADCALL |vp| (QREFELT $ 30)) (QREFELT $ 31)))))) 

(DECLAIM (NOTINLINE |DoubleFloatSpecialFunctions;|)) 

(DEFUN |DoubleFloatSpecialFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G729)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|DoubleFloatSpecialFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DoubleFloatSpecialFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|DoubleFloatSpecialFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|DoubleFloatSpecialFunctions|)))))))))) 

(DEFUN |DoubleFloatSpecialFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DoubleFloatSpecialFunctions|))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DoubleFloatSpecialFunctions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 16
                    (|expt_DF_I| (FLOAT 10 MOST-POSITIVE-DOUBLE-FLOAT) -7))
          $))) 

(MAKEPROP '|DoubleFloatSpecialFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Complex| 10) (|NonNegativeInteger|)
              |DFSFUN;polygamma;Nni2C;1| |DFSFUN;besselJ;3C;2| (|DoubleFloat|)
              |DFSFUN;besselJ;3Df;3| |DFSFUN;besselI;3C;4|
              |DFSFUN;besselI;3Df;5| (0 . |Zero|) |DFSFUN;digamma;2C;6| '|fuzz|
              (|Boolean|) (|IntegerRetractions| 10) (4 . |integer?|)
              |DFSFUN;besselY;3Df;7| (|IntegerRetractions| 6) (9 . |integer?|)
              (14 . |coerce|) (19 . +) (25 . |pi|) (29 . *) (35 . |cos|)
              (40 . -) (45 . -) (51 . |sin|) (56 . /) |DFSFUN;besselY;3C;8|
              (62 . |One|) |DFSFUN;besselK;3Df;9| (|Integer|) (66 . |coerce|)
              |DFSFUN;besselK;3C;10|)
           '#(|polygamma| 71 |digamma| 77 |besselY| 82 |besselK| 94 |besselJ|
              106 |besselI| 118)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|digamma|
                                 ((|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))))
                                T)
                              '((|polygamma|
                                 ((|Complex| (|DoubleFloat|))
                                  (|NonNegativeInteger|)
                                  (|Complex| (|DoubleFloat|))))
                                T)
                              '((|besselJ|
                                 ((|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|)))
                                T)
                              '((|besselJ|
                                 ((|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))))
                                T)
                              '((|besselY|
                                 ((|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|)))
                                T)
                              '((|besselY|
                                 ((|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))))
                                T)
                              '((|besselI|
                                 ((|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|)))
                                T)
                              '((|besselI|
                                 ((|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))))
                                T)
                              '((|besselK|
                                 ((|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|)))
                                T)
                              '((|besselK|
                                 ((|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))
                                  (|Complex| (|DoubleFloat|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 37
                                            '(0 6 0 14 1 18 17 10 19 1 21 17 6
                                              22 1 6 0 10 23 2 6 0 0 0 24 0 6 0
                                              25 2 6 0 0 0 26 1 6 0 0 27 1 6 0
                                              0 28 2 6 0 0 0 29 1 6 0 0 30 2 6
                                              0 0 0 31 0 6 0 33 1 6 0 35 36 2 0
                                              6 7 6 8 1 0 6 6 15 2 0 10 10 10
                                              20 2 0 6 6 6 32 2 0 6 6 6 37 2 0
                                              10 10 10 34 2 0 10 10 10 11 2 0 6
                                              6 6 9 2 0 10 10 10 13 2 0 6 6 6
                                              12)))))
           '|lookupComplete|)) 

(MAKEPROP '|DoubleFloatSpecialFunctions| 'NILADIC T) 
