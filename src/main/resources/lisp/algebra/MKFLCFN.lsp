
(SDEFUN |MKFLCFN;streq?|
        ((|s| (|InputForm|)) (|st| (|String|)) ($ (|Boolean|)))
        (SPADCALL |s| (SPADCALL (SPADCALL |st| (QREFELT $ 14)) (QREFELT $ 9))
                  (QREFELT $ 16))) 

(SDEFUN |MKFLCFN;gencode|
        ((|s| (|String|)) (|l| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPADCALL
         (CONS (SPADCALL (SPADCALL |s| (QREFELT $ 14)) (QREFELT $ 9)) |l|)
         (QREFELT $ 11))) 

(SDEFUN |MKFLCFN;streqlist?|
        ((|s| (|InputForm|)) (|l| (|List| (|String|))) ($ (|Boolean|)))
        (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 17)) (QREFELT $ 18)) |l|
                  (QREFELT $ 20))) 

(SDEFUN |MKFLCFN;mkPretend| ((|form| (|InputForm|)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|pretend| (QREFELT $ 9)) |form| (QREFELT $ 12))
         (QREFELT $ 11))) 

(SDEFUN |MKFLCFN;mkCTOR| ((|form| (|InputForm|)) ($ (|InputForm|)))
        (SPADCALL (LIST (SPADCALL '|c_to_rf| (QREFELT $ 9)) |form|)
                  (QREFELT $ 11))) 

(SDEFUN |MKFLCFN;mkLispCall| ((|name| (|InputForm|)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|$elt| (QREFELT $ 9))
               (SPADCALL '|Lisp| (QREFELT $ 9)) |name|)
         (QREFELT $ 11))) 

(SDEFUN |MKFLCFN;mkDefun|
        ((|s| (|InputForm|)) (|lv| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPROG ((|fun| (|InputForm|)) (|name| (|InputForm|)))
               (SEQ
                (LETT |name|
                      (SPADCALL (SPADCALL (QREFELT $ 21)) (QREFELT $ 9)))
                (LETT |fun|
                      (SPADCALL
                       (LIST (SPADCALL 'DEFUN (QREFELT $ 9)) |name|
                             (SPADCALL |lv| (QREFELT $ 11))
                             (|MKFLCFN;gencode| "DECLARE"
                              (LIST (|MKFLCFN;gencode| "DOUBLE-FLOAT" |lv| $))
                              $)
                             (|MKFLCFN;mkCTOR| |s| $))
                       (QREFELT $ 11)))
                (EVAL |fun|)
                (COND (|$compileDontDefineFunctions| (COMPILE |name|)))
                (EXIT |name|)))) 

(SDEFUN |MKFLCFN;makeFloatFunction;S2SM;8|
        ((|f| (S)) (|x| (|Symbol|)) (|y| (|Symbol|))
         ($ (|Mapping| (|DoubleFloat|) (|DoubleFloat|) (|DoubleFloat|))))
        (SPROG
         ((|spadform| (|InputForm|)) (|spadname| (|Symbol|))
          (|t| (|List| (|InputForm|))) (|name| (|InputForm|))
          (|iy| #1=(|InputForm|)) (|ix| #1#)
          (|u| (|Union| (|InputForm|) "failed")))
         (SEQ (LETT |u| (|MKFLCFN;mkLisp| (SPADCALL |f| (QREFELT $ 22)) $))
              (EXIT
               (COND ((QEQCAR |u| 1) (SPADCALL |f| |x| |y| (QREFELT $ 25)))
                     ('T
                      (SEQ
                       (LETT |name|
                             (|MKFLCFN;mkDefun| (QCDR |u|)
                              (LIST (LETT |ix| (SPADCALL |x| (QREFELT $ 9)))
                                    (LETT |iy| (SPADCALL |y| (QREFELT $ 9))))
                              $))
                       (LETT |t| (LIST (QREFELT $ 12) (QREFELT $ 12)))
                       (LETT |spadname|
                             (SPADCALL
                              (|devaluate|
                               (|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                          (|DoubleFloat|)))
                              (QREFELT $ 26)))
                       (LETT |spadform|
                             (|MKFLCFN;mkPretend|
                              (SPADCALL
                               (LIST (|MKFLCFN;mkLispCall| |name| $) |ix| |iy|)
                               (QREFELT $ 11))
                              $))
                       (SPADCALL
                        (SPADCALL |spadform| (LIST |x| |y|) |spadname|
                                  (QREFELT $ 28))
                        (QREFELT $ 30))
                       (EXIT
                        (SPADCALL (SPADCALL |spadname| |t| (QREFELT $ 31))
                                  (QREFELT $ 32)))))))))) 

(SDEFUN |MKFLCFN;makeFloatFunction;SSM;9|
        ((|f| (S)) (|var| (|Symbol|))
         ($ (|Mapping| (|DoubleFloat|) (|DoubleFloat|))))
        (SPROG
         ((|spadform| (|InputForm|)) (|spadname| (|Symbol|))
          (|t| (|List| (|InputForm|))) (|name| (|InputForm|))
          (|ivar| (|InputForm|)) (|u| (|Union| (|InputForm|) "failed")))
         (SEQ (LETT |u| (|MKFLCFN;mkLisp| (SPADCALL |f| (QREFELT $ 22)) $))
              (EXIT
               (COND ((QEQCAR |u| 1) (SPADCALL |f| |var| (QREFELT $ 36)))
                     ('T
                      (SEQ
                       (LETT |name|
                             (|MKFLCFN;mkDefun| (QCDR |u|)
                              (LIST
                               (LETT |ivar| (SPADCALL |var| (QREFELT $ 9))))
                              $))
                       (LETT |t| (LIST (QREFELT $ 12)))
                       (LETT |spadname|
                             (SPADCALL
                              (|devaluate|
                               (|Mapping| (|DoubleFloat|) (|DoubleFloat|)))
                              (QREFELT $ 26)))
                       (LETT |spadform|
                             (|MKFLCFN;mkPretend|
                              (SPADCALL
                               (LIST (|MKFLCFN;mkLispCall| |name| $) |ivar|)
                               (QREFELT $ 11))
                              $))
                       (SPADCALL
                        (SPADCALL |spadform| (LIST |var|) |spadname|
                                  (QREFELT $ 28))
                        (QREFELT $ 30))
                       (EXIT
                        (SPADCALL (SPADCALL |spadname| |t| (QREFELT $ 31))
                                  (QREFELT $ 37)))))))))) 

(SDEFUN |MKFLCFN;mkLispList|
        ((|l| (|List| (|InputForm|)))
         ($ (|Union| (|List| (|InputForm|)) "failed")))
        (SPROG
         ((|ans| (|List| (|InputForm|))) (#1=#:G756 NIL)
          (|u| (|Union| (|InputForm|) "failed")) (#2=#:G757 NIL) (|s| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| NIL)
                (SEQ (LETT |s| NIL) (LETT #2# |l|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |u| (|MKFLCFN;mkLisp| |s| $))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (PROGN
                              (LETT #1# (CONS 1 "failed"))
                              (GO #3=#:G755)))
                            ('T (LETT |ans| (CONS (QCDR |u|) |ans|))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (NREVERSE |ans|)))))
          #3# (EXIT #1#)))) 

(SDEFUN |MKFLCFN;mkLisp|
        ((|s| (|InputForm|)) ($ (|Union| (|InputForm|) "failed")))
        (SPROG
         ((|b| (|DoubleFloat|)) (|e| #1=(|InputForm|)) (|a| #1#) (|ii| #1#)
          (|ll| (|List| (|InputForm|)))
          (|u| (|Union| (|List| (|InputForm|)) "failed")) (|op| (|InputForm|))
          (|l| (|List| (|InputForm|))))
         (SEQ
          (COND
           ((SPADCALL |s| (QREFELT $ 39))
            (COND
             ((SPADCALL |s| (QREFELT $ 40))
              (CONS 0
                    (SPADCALL
                     (FLOAT (SPADCALL |s| (QREFELT $ 42))
                            MOST-POSITIVE-DOUBLE-FLOAT)
                     (QREFELT $ 44))))
             (#2='T (CONS 0 |s|))))
           (#2#
            (SEQ
             (LETT |op| (|SPADfirst| (LETT |l| (SPADCALL |s| (QREFELT $ 45)))))
             (LETT |u| (|MKFLCFN;mkLispList| (CDR |l|) $))
             (EXIT
              (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                    (#2#
                     (SEQ (LETT |ll| (QCDR |u|))
                          (EXIT
                           (COND
                            ((|MKFLCFN;streqlist?| |op| (LIST "+" "*" "/" "-")
                              $)
                             (CONS 0
                                   (SPADCALL (CONS |op| |ll|) (QREFELT $ 11))))
                            ((|MKFLCFN;streq?| |op| "^" $)
                             (COND
                              ((SPADCALL
                                (LETT |ii| (SPADCALL |l| 3 (QREFELT $ 47)))
                                (QREFELT $ 40))
                               (CONS 0
                                     (|MKFLCFN;gencode| "EXPT"
                                      (LIST (SPADCALL |ll| 1 (QREFELT $ 47))
                                            |ii|)
                                      $)))
                              (#2#
                               (CONS 0 (|MKFLCFN;gencode| "EXPT" |ll| $)))))
                            ((|MKFLCFN;streqlist?| |op|
                              (LIST "exp" "sin" "cos" "tan" "atan" "asin"
                                    "acos" "log" "sinh" "cosh" "tanh" "asinh"
                                    "acosh" "atanh" "sqrt")
                              $)
                             (CONS 0
                                   (|MKFLCFN;gencode|
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |op| (QREFELT $ 17))
                                               (QREFELT $ 18))
                                     (QREFELT $ 49))
                                    |ll| $)))
                            ((|MKFLCFN;streq?| |op| "nthRoot" $)
                             (COND
                              ((SPADCALL (SPADCALL (CDR |l|) (QREFELT $ 50))
                                         (SPADCALL 2 (QREFELT $ 51))
                                         (QREFELT $ 16))
                               (CONS 0
                                     (|MKFLCFN;gencode| "SQRT"
                                      (LIST (|SPADfirst| |ll|)) $)))
                              (#2#
                               (CONS 0
                                     (|MKFLCFN;gencode| "EXPT"
                                      (CONS (|SPADfirst| |ll|)
                                            (LIST
                                             (SPADCALL (|spadConstant| $ 48)
                                                       (SPADCALL |ll|
                                                                 (QREFELT $
                                                                          50))
                                                       (QREFELT $ 52))))
                                      $)))))
                            ((|MKFLCFN;streq?| |op| "float" $)
                             (SEQ (LETT |a| (SPADCALL |ll| 1 (QREFELT $ 47)))
                                  (LETT |e| (SPADCALL |ll| 2 (QREFELT $ 47)))
                                  (LETT |b|
                                        (FLOAT (SPADCALL |ll| 3 (QREFELT $ 47))
                                               MOST-POSITIVE-DOUBLE-FLOAT))
                                  (EXIT (CONS 0 (* |a| (EXPT |b| |e|))))))
                            (#2# (CONS 1 "failed")))))))))))))) 

(DECLAIM (NOTINLINE |MakeFloatCompiledFunction;|)) 

(DEFUN |MakeFloatCompiledFunction| (#1=#:G788)
  (SPROG NIL
         (PROG (#2=#:G789)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MakeFloatCompiledFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|MakeFloatCompiledFunction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|MakeFloatCompiledFunction|)))))))))) 

(DEFUN |MakeFloatCompiledFunction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MakeFloatCompiledFunction| DV$1))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MakeFloatCompiledFunction|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 12
                    (SPADCALL (LIST (SPADCALL '|DoubleFloat| (QREFELT $ 9)))
                              (QREFELT $ 11)))
          $))) 

(MAKEPROP '|MakeFloatCompiledFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (|InputForm|)
              (0 . |convert|) (|List| $) (5 . |convert|) '|lsf| (|String|)
              (10 . |coerce|) (|Boolean|) (15 . =) (21 . |symbol|)
              (26 . |string|) (|List| 13) (31 . |member?|) (37 . |new|)
              (41 . |convert|) (|Mapping| 43 43 43)
              (|MakeBinaryCompiledFunction| 6 43 43 43)
              (46 . |compiledFunction|) (53 . |declare|) (|List| 7)
              (58 . |function|) (|Any|) (65 . |interpret|) (70 . |compile|)
              (76 . |binaryFunction|) |MKFLCFN;makeFloatFunction;S2SM;8|
              (|Mapping| 43 43) (|MakeUnaryCompiledFunction| 6 43 43)
              (81 . |compiledFunction|) (87 . |unaryFunction|)
              |MKFLCFN;makeFloatFunction;SSM;9| (92 . |atom?|)
              (97 . |integer?|) (|Integer|) (102 . |integer|) (|DoubleFloat|)
              (107 . |convert|) (112 . |destruct|) (|List| 8) (117 . |elt|)
              (123 . |One|) (127 . |upperCase|) (132 . |second|)
              (137 . |convert|) (142 . /))
           '#(|makeFloatFunction| 148) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|makeFloatFunction|
                                 ((|Mapping| (|DoubleFloat|) (|DoubleFloat|))
                                  |#1| (|Symbol|)))
                                T)
                              '((|makeFloatFunction|
                                 ((|Mapping| (|DoubleFloat|) (|DoubleFloat|)
                                             (|DoubleFloat|))
                                  |#1| (|Symbol|) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 52
                                            '(1 8 0 7 9 1 8 0 10 11 1 7 0 13 14
                                              2 8 15 0 0 16 1 8 7 0 17 1 7 13 0
                                              18 2 19 15 13 0 20 0 7 0 21 1 6 8
                                              0 22 3 24 23 6 7 7 25 1 8 7 10 26
                                              3 8 0 0 27 7 28 1 8 29 0 30 2 8 7
                                              7 10 31 1 24 23 7 32 2 35 34 6 7
                                              36 1 35 34 7 37 1 8 15 0 39 1 8
                                              15 0 40 1 8 41 0 42 1 8 0 43 44 1
                                              8 10 0 45 2 46 8 0 41 47 0 8 0 48
                                              1 13 0 0 49 1 46 8 0 50 1 8 0 41
                                              51 2 8 0 0 0 52 3 0 23 6 7 7 33 2
                                              0 34 6 7 38)))))
           '|lookupComplete|)) 
