
(SDEFUN |OMEXPR;outputOMArith1|
        ((|dev| (|OpenMathDevice|)) (|sym| (|String|))
         (|args| (|List| (|Expression| R))) ($ (|Void|)))
        (SPROG ((#1=#:G722 NIL) (|arg| NIL))
               (SEQ (SPADCALL |dev| (QREFELT $ 16))
                    (SPADCALL |dev| "arith1" |sym| (QREFELT $ 18))
                    (SEQ (LETT |arg| NIL) (LETT #1# |args|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |arg| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (EXIT (SPADCALL |dev| |arg| NIL (QREFELT $ 21))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |dev| (QREFELT $ 22)))))) 

(SDEFUN |OMEXPR;outputOMLambda|
        ((|dev| (|OpenMathDevice|)) (|ex| (|Expression| R))
         (|var| (|Expression| R)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 23))
             (SPADCALL |dev| "fns1" "lambda" (QREFELT $ 18))
             (SPADCALL |dev| (QREFELT $ 24))
             (SPADCALL |dev| |var| NIL (QREFELT $ 21))
             (SPADCALL |dev| (QREFELT $ 25))
             (SPADCALL |dev| |ex| NIL (QREFELT $ 21))
             (EXIT (SPADCALL |dev| (QREFELT $ 26))))) 

(SDEFUN |OMEXPR;outputOMInterval|
        ((|dev| (|OpenMathDevice|)) (|lo| (|Expression| R))
         (|hi| (|Expression| R)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 16))
             (SPADCALL |dev| "interval1" "interval" (QREFELT $ 18))
             (SPADCALL |dev| |lo| NIL (QREFELT $ 21))
             (SPADCALL |dev| |hi| NIL (QREFELT $ 21))
             (EXIT (SPADCALL |dev| (QREFELT $ 22))))) 

(SDEFUN |OMEXPR;outputOMIntInterval|
        ((|dev| (|OpenMathDevice|)) (|lo| (|Expression| R))
         (|hi| (|Expression| R)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 16))
             (SPADCALL |dev| "interval1" "integer_interval" (QREFELT $ 18))
             (SPADCALL |dev| |lo| NIL (QREFELT $ 21))
             (SPADCALL |dev| |hi| NIL (QREFELT $ 21))
             (EXIT (SPADCALL |dev| (QREFELT $ 22))))) 

(SDEFUN |OMEXPR;outputOMBinomial|
        ((|dev| (|OpenMathDevice|)) (|args| (|List| (|Expression| R)))
         ($ (|Void|)))
        (SPROG ((#1=#:G739 NIL) (|arg| NIL))
               (SEQ
                (COND
                 ((NULL (EQL (LENGTH |args|) 2))
                  (|error| "Wrong number of arguments to binomial"))
                 ('T
                  (SEQ (SPADCALL |dev| (QREFELT $ 16))
                       (SPADCALL |dev| "combinat1" "binomial" (QREFELT $ 18))
                       (SEQ (LETT |arg| NIL) (LETT #1# |args|) G190
                            (COND
                             ((OR (ATOM #1#)
                                  (PROGN (LETT |arg| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT (SPADCALL |dev| |arg| NIL (QREFELT $ 21))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT (SPADCALL |dev| (QREFELT $ 22))))))))) 

(SDEFUN |OMEXPR;outputOMPower|
        ((|dev| (|OpenMathDevice|)) (|args| (|List| (|Expression| R)))
         ($ (|Void|)))
        (COND
         ((NULL (EQL (LENGTH |args|) 2))
          (|error| "Wrong number of arguments to power"))
         ('T (|OMEXPR;outputOMArith1| |dev| "power" |args| $)))) 

(SDEFUN |OMEXPR;outputOMDefsum|
        ((|dev| (|OpenMathDevice|)) (|args| (|List| (|Expression| R)))
         ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (LENGTH |args|) 5 (QREFELT $ 28))
           (|error| "Unexpected number of arguments to a defsum"))
          ('T
           (SEQ (SPADCALL |dev| (QREFELT $ 16))
                (SPADCALL |dev| "arith1" "sum" (QREFELT $ 18))
                (|OMEXPR;outputOMIntInterval| |dev|
                 (SPADCALL |args| 4 (QREFELT $ 31))
                 (SPADCALL |args| 5 (QREFELT $ 31)) $)
                (|OMEXPR;outputOMLambda| |dev|
                 (SPADCALL (SPADCALL |args| 1 (QREFELT $ 31))
                           (SPADCALL |args| 2 (QREFELT $ 31))
                           (SPADCALL |args| 3 (QREFELT $ 31)) (QREFELT $ 34))
                 (SPADCALL |args| 3 (QREFELT $ 31)) $)
                (EXIT (SPADCALL |dev| (QREFELT $ 22)))))))) 

(SDEFUN |OMEXPR;outputOMDefprod|
        ((|dev| (|OpenMathDevice|)) (|args| (|List| (|Expression| R)))
         ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (LENGTH |args|) 5 (QREFELT $ 28))
           (|error| "Unexpected number of arguments to a defprod"))
          ('T
           (SEQ (SPADCALL |dev| (QREFELT $ 16))
                (SPADCALL |dev| "arith1" "product" (QREFELT $ 18))
                (|OMEXPR;outputOMIntInterval| |dev|
                 (SPADCALL |args| 4 (QREFELT $ 31))
                 (SPADCALL |args| 5 (QREFELT $ 31)) $)
                (|OMEXPR;outputOMLambda| |dev|
                 (SPADCALL (SPADCALL |args| 1 (QREFELT $ 31))
                           (SPADCALL |args| 2 (QREFELT $ 31))
                           (SPADCALL |args| 3 (QREFELT $ 31)) (QREFELT $ 34))
                 (SPADCALL |args| 3 (QREFELT $ 31)) $)
                (EXIT (SPADCALL |dev| (QREFELT $ 22)))))))) 

(SDEFUN |OMEXPR;outputOMDefint|
        ((|dev| (|OpenMathDevice|)) (|args| (|List| (|Expression| R)))
         ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (LENGTH |args|) 5 (QREFELT $ 28))
           (|error| "Unexpected number of arguments to a defint"))
          ('T
           (SEQ (SPADCALL |dev| (QREFELT $ 16))
                (SPADCALL |dev| "calculus1" "defint" (QREFELT $ 18))
                (|OMEXPR;outputOMInterval| |dev|
                 (SPADCALL |args| 4 (QREFELT $ 31))
                 (SPADCALL |args| 5 (QREFELT $ 31)) $)
                (|OMEXPR;outputOMLambda| |dev|
                 (SPADCALL (SPADCALL |args| 1 (QREFELT $ 31))
                           (SPADCALL |args| 2 (QREFELT $ 31))
                           (SPADCALL |args| 3 (QREFELT $ 31)) (QREFELT $ 34))
                 (SPADCALL |args| 3 (QREFELT $ 31)) $)
                (EXIT (SPADCALL |dev| (QREFELT $ 22)))))))) 

(SDEFUN |OMEXPR;outputOMInt|
        ((|dev| (|OpenMathDevice|)) (|args| (|List| (|Expression| R)))
         ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (LENGTH |args|) 3 (QREFELT $ 28))
           (|error| "Unexpected number of arguments to a defint"))
          ('T
           (SEQ (SPADCALL |dev| (QREFELT $ 16))
                (SPADCALL |dev| "calculus1" "int" (QREFELT $ 18))
                (|OMEXPR;outputOMLambda| |dev|
                 (SPADCALL (SPADCALL |args| 1 (QREFELT $ 31))
                           (SPADCALL |args| 2 (QREFELT $ 31))
                           (SPADCALL |args| 3 (QREFELT $ 31)) (QREFELT $ 34))
                 (SPADCALL |args| 3 (QREFELT $ 31)) $)
                (EXIT (SPADCALL |dev| (QREFELT $ 22)))))))) 

(SDEFUN |OMEXPR;outputOMFunction|
        ((|dev| (|OpenMathDevice|)) (|op| (|Symbol|))
         (|args| (|List| (|Expression| R))) ($ (|Void|)))
        (SPROG
         ((#1=#:G781 NIL) (|arg| NIL)
          (|omOp|
           (|Union| (|Record| (|:| |cd| (|String|)) (|:| |name| (|String|)))
                    "failed"))
          (|nargs| (|NonNegativeInteger|)))
         (SEQ (LETT |nargs| (LENGTH |args|))
              (EXIT
               (COND
                ((ZEROP |nargs|)
                 (SEQ
                  (LETT |omOp| (SPADCALL |op| (QREFELT $ 12) (QREFELT $ 37)))
                  (EXIT
                   (COND
                    ((QEQCAR |omOp| 1)
                     (|error|
                      (STRCONC "No OpenMath definition for nullary function "
                               (SPADCALL |op| (QREFELT $ 38)))))
                    (#2='T
                     (SPADCALL |dev| (QCAR (QCDR |omOp|)) (QCDR (QCDR |omOp|))
                               (QREFELT $ 18)))))))
                ((EQL |nargs| 1)
                 (SEQ
                  (LETT |omOp| (SPADCALL |op| (QREFELT $ 13) (QREFELT $ 37)))
                  (EXIT
                   (COND
                    ((QEQCAR |omOp| 1)
                     (|error|
                      (STRCONC "No OpenMath definition for unary function "
                               (SPADCALL |op| (QREFELT $ 38)))))
                    (#2#
                     (SEQ (SPADCALL |dev| (QREFELT $ 16))
                          (SPADCALL |dev| (QCAR (QCDR |omOp|))
                                    (QCDR (QCDR |omOp|)) (QREFELT $ 18))
                          (SEQ (LETT |arg| NIL) (LETT #1# |args|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |arg| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (SPADCALL |dev| |arg| NIL (QREFELT $ 21))))
                               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                          (EXIT (SPADCALL |dev| (QREFELT $ 22)))))))))
                (#2#
                 (COND
                  ((EQUAL |op| '|%defint|)
                   (|OMEXPR;outputOMDefint| |dev| |args| $))
                  ((EQUAL |op| '|integral|)
                   (|OMEXPR;outputOMInt| |dev| |args| $))
                  ((EQUAL |op| '|%defsum|)
                   (|OMEXPR;outputOMDefsum| |dev| |args| $))
                  ((EQUAL |op| '|%defprod|)
                   (|OMEXPR;outputOMDefprod| |dev| |args| $))
                  ((EQUAL |op| '|%power|)
                   (|OMEXPR;outputOMPower| |dev| |args| $))
                  ((EQUAL |op| '|binomial|)
                   (|OMEXPR;outputOMBinomial| |dev| |args| $))
                  (#2#
                   (|error|
                    (STRCONC "No OpenMath definition for function "
                             (SPADCALL |op| (QREFELT $ 38)))))))))))) 

(SDEFUN |OMEXPR;outputOMExpr|
        ((|dev| (|OpenMathDevice|)) (|ex| (|Expression| R)) ($ (|Void|)))
        (SPROG
         ((|k| (|Kernel| (|Expression| R))) (#1=#:G808 NIL)
          (|z|
           (|Union|
            (|Record| (|:| |val| (|Expression| R))
                      (|:| |exponent| (|Integer|)))
            "failed"))
          (|s| (|Union| (|Symbol|) "failed"))
          (|x|
           (|Union|
            (|Record| (|:| |var| (|Kernel| (|Expression| R)))
                      (|:| |exponent| (|Integer|)))
            "failed"))
          (|w| (|Union| (|List| (|Expression| R)) "failed"))
          (|v| (|Union| (|Symbol|) "failed")))
         (SEQ
          (COND
           ((SPADCALL |ex| (QREFELT $ 39))
            (SPADCALL |dev| (SPADCALL |ex| (QREFELT $ 40)) NIL (QREFELT $ 41)))
           ('T
            (SEQ
             (EXIT
              (SEQ
               (SEQ (LETT |v| (SPADCALL |ex| (QREFELT $ 43)))
                    (EXIT
                     (COND
                      ((NULL (QEQCAR |v| 1))
                       (PROGN
                        (LETT #1# (SPADCALL |dev| (QCDR |v|) (QREFELT $ 44)))
                        (GO #2=#:G805))))))
               (SEQ (LETT |w| (SPADCALL |ex| (QREFELT $ 46)))
                    (EXIT
                     (COND
                      ((NULL (QEQCAR |w| 1))
                       (PROGN
                        (LETT #1#
                              (|OMEXPR;outputOMArith1| |dev| "plus" (QCDR |w|)
                               $))
                        (GO #2#))))))
               (SEQ (LETT |w| (SPADCALL |ex| (QREFELT $ 47)))
                    (EXIT
                     (COND
                      ((NULL (QEQCAR |w| 1))
                       (PROGN
                        (LETT #1#
                              (|OMEXPR;outputOMArith1| |dev| "times" (QCDR |w|)
                               $))
                        (GO #2#))))))
               (SEQ (LETT |x| (SPADCALL |ex| (QREFELT $ 50)))
                    (EXIT
                     (COND
                      ((NULL (QEQCAR |x| 1))
                       (COND
                        ((NULL (EQL (QCDR (QCDR |x|)) 1))
                         (PROGN
                          (LETT #1#
                                (SEQ
                                 (LETT |s|
                                       (SPADCALL (QCAR (QCDR |x|))
                                                 (QREFELT $ 52)))
                                 (EXIT
                                  (COND
                                   ((NULL (QEQCAR |s| 1))
                                    (PROGN
                                     (LETT #1#
                                           (SEQ (SPADCALL |dev| (QREFELT $ 16))
                                                (SPADCALL |dev| "arith1"
                                                          "power"
                                                          (QREFELT $ 18))
                                                (SPADCALL |dev| (QCDR |s|)
                                                          (QREFELT $ 44))
                                                (SPADCALL |dev|
                                                          (QCDR (QCDR |x|))
                                                          (QREFELT $ 53))
                                                (EXIT
                                                 (SPADCALL |dev|
                                                           (QREFELT $ 22)))))
                                     (GO #2#)))))))
                          (GO #2#))))))))
               (SEQ (LETT |z| (SPADCALL |ex| (QREFELT $ 56)))
                    (EXIT
                     (COND
                      ((NULL (QEQCAR |z| 1))
                       (COND
                        ((NULL (EQL (QCDR (QCDR |z|)) 1))
                         (PROGN
                          (LETT #1#
                                (|OMEXPR;outputOMPower| |dev|
                                 (LIST (QCAR (QCDR |z|))
                                       (SPADCALL (QCDR (QCDR |z|))
                                                 (QREFELT $ 57)))
                                 $))
                          (GO #2#))))))))
               (LETT |k| (|SPADfirst| (SPADCALL |ex| (QREFELT $ 59))))
               (EXIT
                (|OMEXPR;outputOMFunction| |dev|
                 (SPADCALL (SPADCALL |k| (QREFELT $ 61)) (QREFELT $ 62))
                 (SPADCALL |k| (QREFELT $ 63)) $))))
             #2# (EXIT #1#))))))) 

(SDEFUN |OMEXPR;OMwrite;EBS;13|
        ((|ex| (|Expression| R)) (|wholeObj| (|Boolean|)) ($ (|String|)))
        (SPROG ((|s| (|String|)) (|dev| (|OpenMathDevice|)) (|sp| (|None|)))
               (SEQ (LETT |s| "") (LETT |sp| (OM-STRINGTOSTRINGPTR |s|))
                    (LETT |dev|
                          (SPADCALL |sp| (SPADCALL (QREFELT $ 65))
                                    (QREFELT $ 66)))
                    (SPADCALL |dev| |ex| |wholeObj| (QREFELT $ 21))
                    (SPADCALL |dev| (QREFELT $ 67))
                    (LETT |s| (OM-STRINGPTRTOSTRING |sp|)) (EXIT |s|)))) 

(SDEFUN |OMEXPR;OMwrite;OmdEV;14|
        ((|dev| (|OpenMathDevice|)) (|ex| (|Expression| R)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 69))
             (|OMEXPR;outputOMExpr| |dev| |ex| $)
             (EXIT (SPADCALL |dev| (QREFELT $ 70))))) 

(SDEFUN |OMEXPR;OMwrite;OmdEBV;15|
        ((|dev| (|OpenMathDevice|)) (|ex| (|Expression| R))
         (|wholeObj| (|Boolean|)) ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 69))))
             (|OMEXPR;outputOMExpr| |dev| |ex| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 70))))))) 

(SDEFUN |OMEXPR;OMwrite;OmdEV;16|
        ((|dev| (|OpenMathDevice|)) (|ex| (|Expression| R)) ($ (|Void|)))
        (SPADCALL |dev| |ex| 'T (QREFELT $ 21))) 

(SDEFUN |OMEXPR;OMwrite;ES;17| ((|ex| (|Expression| R)) ($ (|String|)))
        (SPADCALL |ex| 'T (QREFELT $ 68))) 

(DECLAIM (NOTINLINE |ExpressionToOpenMath;|)) 

(DEFUN |ExpressionToOpenMath| (#1=#:G817)
  (SPROG NIL
         (PROG (#2=#:G818)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ExpressionToOpenMath|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|ExpressionToOpenMath;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ExpressionToOpenMath|)))))))))) 

(DEFUN |ExpressionToOpenMath;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ExpressionToOpenMath| DV$1))
          (LETT $ (GETREFV 73))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExpressionToOpenMath| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 12
                    (SPADCALL (LIST (CONS '|pi| (CONS "nums1" "pi")))
                              (QREFELT $ 11)))
          (QSETREFV $ 13
                    (SPADCALL
                     (LIST (CONS '|exp| (CONS #1="transc1" "exp"))
                           (CONS '|log| (CONS #1# "ln"))
                           (CONS '|sin| (CONS #1# "sin"))
                           (CONS '|cos| (CONS #1# "cos"))
                           (CONS '|tan| (CONS #1# "tan"))
                           (CONS '|cot| (CONS #1# "cot"))
                           (CONS '|sec| (CONS #1# "sec"))
                           (CONS '|csc| (CONS #1# "csc"))
                           (CONS '|asin| (CONS #1# "arcsin"))
                           (CONS '|acos| (CONS #1# "arccos"))
                           (CONS '|atan| (CONS #1# "arctan"))
                           (CONS '|acot| (CONS #1# "arccot"))
                           (CONS '|asec| (CONS #1# "arcsec"))
                           (CONS '|acsc| (CONS #1# "arccsc"))
                           (CONS '|sinh| (CONS #1# "sinh"))
                           (CONS '|cosh| (CONS #1# "cosh"))
                           (CONS '|tanh| (CONS #1# "tanh"))
                           (CONS '|coth| (CONS #1# "coth"))
                           (CONS '|sech| (CONS #1# "sech"))
                           (CONS '|csch| (CONS #1# "csch"))
                           (CONS '|asinh| (CONS #1# "arcsinh"))
                           (CONS '|acosh| (CONS #1# "arccosh"))
                           (CONS '|atanh| (CONS #1# "arctanh"))
                           (CONS '|acoth| (CONS #1# "arccoth"))
                           (CONS '|asech| (CONS #1# "arcsech"))
                           (CONS '|acsch| (CONS #1# "arccsch"))
                           (CONS '|factorial| (CONS "integer1" "factorial"))
                           (CONS '|abs| (CONS "arith1" "abs")))
                     (QREFELT $ 11)))
          $))) 

(MAKEPROP '|ExpressionToOpenMath| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Record| (|:| |cd| 17) (|:| |name| 17))
              (|Record| (|:| |key| 36) (|:| |entry| 7)) (|List| 8)
              (|AssociationList| 36 7) (0 . |construct|)
              '|nullaryFunctionAList| '|unaryFunctionAList| (|Void|)
              (|OpenMathDevice|) (5 . |OMputApp|) (|String|)
              (10 . |OMputSymbol|) (|Expression| 6) (|Boolean|)
              |OMEXPR;OMwrite;OmdEBV;15| (17 . |OMputEndApp|)
              (22 . |OMputBind|) (27 . |OMputBVar|) (32 . |OMputEndBVar|)
              (37 . |OMputEndBind|) (|NonNegativeInteger|) (42 . ~=)
              (|Integer|) (|List| 19) (48 . |elt|) (54 . |One|) (58 . |One|)
              (62 . |eval|) (|Union| 7 '"failed") (|Symbol|) (69 . |search|)
              (75 . |string|) (80 . |ground?|) (85 . |ground|) (90 . |OMwrite|)
              (|Union| 36 '"failed") (97 . |retractIfCan|)
              (102 . |OMputVariable|) (|Union| (|List| $) '"failed")
              (108 . |isPlus|) (113 . |isTimes|)
              (|Record| (|:| |var| (|Kernel| $)) (|:| |exponent| 29))
              (|Union| 48 '"failed") (118 . |isExpt|) (|Kernel| 19)
              (123 . |symbolIfCan|) (128 . |OMputInteger|)
              (|Record| (|:| |val| $) (|:| |exponent| 29))
              (|Union| 54 '"failed") (134 . |isPower|) (139 . |coerce|)
              (|List| (|Kernel| $)) (144 . |kernels|) (|BasicOperator|)
              (149 . |operator|) (154 . |name|) (159 . |argument|)
              (|OpenMathEncoding|) (164 . |OMencodingXML|)
              (168 . |OMopenString|) (174 . |OMclose|) |OMEXPR;OMwrite;EBS;13|
              (179 . |OMputObject|) (184 . |OMputEndObject|)
              |OMEXPR;OMwrite;OmdEV;16| |OMEXPR;OMwrite;ES;17|)
           '#(|OMwrite| 189) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|OMwrite| ((|String|) (|Expression| |#1|))) T)
                              '((|OMwrite|
                                 ((|String|) (|Expression| |#1|) (|Boolean|)))
                                T)
                              '((|OMwrite|
                                 ((|Void|) (|OpenMathDevice|)
                                  (|Expression| |#1|)))
                                T)
                              '((|OMwrite|
                                 ((|Void|) (|OpenMathDevice|)
                                  (|Expression| |#1|) (|Boolean|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 72
                                            '(1 10 0 9 11 1 15 14 0 16 3 15 14
                                              0 17 17 18 1 15 14 0 22 1 15 14 0
                                              23 1 15 14 0 24 1 15 14 0 25 1 15
                                              14 0 26 2 27 20 0 0 28 2 30 19 0
                                              29 31 0 6 0 32 0 19 0 33 3 19 0 0
                                              0 0 34 2 10 35 36 0 37 1 36 17 0
                                              38 1 19 20 0 39 1 19 6 0 40 3 6
                                              14 15 0 20 41 1 19 42 0 43 2 15
                                              14 0 36 44 1 19 45 0 46 1 19 45 0
                                              47 1 19 49 0 50 1 51 42 0 52 2 15
                                              14 0 29 53 1 19 55 0 56 1 19 0 29
                                              57 1 19 58 0 59 1 51 60 0 61 1 60
                                              36 0 62 1 51 30 0 63 0 64 0 65 2
                                              15 0 17 64 66 1 15 14 0 67 1 15
                                              14 0 69 1 15 14 0 70 2 0 17 19 20
                                              68 1 0 17 19 72 3 0 14 15 19 20
                                              21 2 0 14 15 19 71)))))
           '|lookupComplete|)) 
