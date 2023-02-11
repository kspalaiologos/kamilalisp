
(SDEFUN |FCTOOL;newFortranTempVar;S;1| (($ (|Symbol|)))
        (SPROG ((|def_type| (|Symbol|)) (|new_sym| (|Symbol|)))
               (SEQ (SETELT $ 6 (|add_SI| 1 (QREFELT $ 6)))
                    (LETT |new_sym|
                          (SPADCALL (STRCONC "T" (STRINGIMAGE (QREFELT $ 6)))
                                    (QREFELT $ 9)))
                    (LETT |def_type| |$defaultFortranType|)
                    (SPADCALL |new_sym|
                              (SPADCALL (SPADCALL |def_type| (QREFELT $ 11))
                                        (QREFELT $ 13))
                              (QREFELT $ 15))
                    (EXIT |new_sym|)))) 

(SDEFUN |FCTOOL;checkType;2S;2| ((|t| (|String|)) ($ (|String|)))
        (COND
         ((EQUAL |$fortranPrecision| '|double|)
          (COND ((EQUAL |t| "REAL") "DOUBLE PRECISION")
                ((EQUAL |t| "COMPLEX") "DOUBLE COMPLEX") (#1='T |t|)))
         (#1# |t|))) 

(SDEFUN |FCTOOL;fortranCleanUp|
        ((|l| (|List| (|String|))) ($ (|List| (|String|))))
        (SPROG
         ((|oldTok| (|String|)) (|m| (|List| (|String|))) (#1=#:G859 NIL)
          (|e| NIL))
         (SEQ (LETT |oldTok| "") (LETT |m| NIL)
              (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((EQUAL |oldTok| "-")
                      (COND
                       ((NULL (EQUAL |e| "+")) (LETT |m| (CONS |e| |m|)))))
                     ('T (LETT |m| (CONS |e| |m|))))
                    (EXIT (LETT |oldTok| |e|)))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |m|)))) 

(SDEFUN |FCTOOL;exp2FortFn|
        ((|op| #1=(|String|)) (|args| (|List| (|OutputForm|)))
         (|nargs| (|Integer|)) ($ (|List| (|String|))))
        (SPROG ((|s| (|List| #1#)) (#2=#:G867 NIL) (|arg| NIL))
               (SEQ (LETT |s| (LIST "(" |op|))
                    (EXIT
                     (COND ((EQL |nargs| 0) (CONS ")" |s|))
                           ('T
                            (SEQ
                             (SEQ (LETT |arg| NIL) (LETT #2# |args|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |arg| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT |s|
                                          (CONS ","
                                                (SPADCALL
                                                 (|FCTOOL;exp2Fort2| |arg| 0
                                                  |op| $)
                                                 |s| (QREFELT $ 25))))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT (CONS ")" (CDR |s|)))))))))) 

(SDEFUN |FCTOOL;exp2Fort2|
        ((|e| (|OutputForm|)) (|prec| (|Integer|)) (|oldOp| (|String|))
         ($ (|List| (|String|))))
        (SPROG
         ((|s| (|List| (|String|))) (#1=#:G900 NIL) (|op1| (|String|))
          (|args1| #2=(|List| (|OutputForm|))) (#3=#:G901 NIL) (|arg| NIL)
          (|nprec| (|Integer|)) (|p| (|Integer|)) (|op| (|String|))
          (|nargs| (|NonNegativeInteger|)) (|args| #2#) (|op0| (|OutputForm|)))
         (SEQ
          (COND ((NULL |e|) NIL)
                ((SPADCALL |e| (QREFELT $ 30)) (LIST (|object2String| |e|)))
                (#4='T
                 (SEQ (LETT |op0| (SPADCALL |e| (QREFELT $ 31)))
                      (LETT |args| (SPADCALL |e| (QREFELT $ 33)))
                      (LETT |nargs| (LENGTH |args|))
                      (LETT |op| (|object2String| |op0|))
                      (COND
                       ((EQL |nargs| 2)
                        (COND
                         ((EQUAL |op| "=")
                          (EXIT
                           (CONS "%l"
                                 (SPADCALL
                                  (|FCTOOL;exp2Fort2|
                                   (SPADCALL |args| 2 (QREFELT $ 35)) |prec|
                                   " " $)
                                  (CONS "="
                                        (|FCTOOL;exp2Fort2|
                                         (SPADCALL |args| 1 (QREFELT $ 35))
                                         |prec| " " $))
                                  (QREFELT $ 25))))))))
                      (EXIT
                       (COND
                        ((EQL |nargs| 0) (|FCTOOL;exp2FortFn| |op| |args| 0 $))
                        ((EQL |nargs| 1)
                         (SEQ
                          (LETT |p|
                                (SPADCALL |op| (QREFELT $ 18) (QREFELT $ 36)))
                          (EXIT
                           (COND
                            ((> |p| 0)
                             (SEQ
                              (LETT |nprec|
                                    (SPADCALL (QREFELT $ 19) |p|
                                              (QREFELT $ 38)))
                              (LETT |s|
                                    (SPADCALL
                                     (|FCTOOL;exp2Fort2| (|SPADfirst| |args|)
                                      |nprec| |op| $)
                                     (CONS |op| NIL) (QREFELT $ 25)))
                              (COND
                               ((EQUAL |op| "-")
                                (COND
                                 ((SPADCALL (|SPADfirst| |args|)
                                            (QREFELT $ 30))
                                  (EXIT |s|)))))
                              (EXIT
                               (COND
                                ((<= |nprec| |prec|)
                                 (CONS ")"
                                       (SPADCALL |s| (CONS "(" NIL)
                                                 (QREFELT $ 25))))
                                (#4# |s|)))))
                            (#4#
                             (SEQ
                              (COND
                               ((SPADCALL |op0| (QREFELT $ 39))
                                (COND
                                 ((EQUAL (SPADCALL |op0| (QREFELT $ 40))
                                         'PAREN)
                                  (EXIT
                                   (CONS ")"
                                         (SPADCALL
                                          (|FCTOOL;exp2Fort2|
                                           (|SPADfirst| |args|) -1 |op| $)
                                          (CONS "(" NIL) (QREFELT $ 25))))))))
                              (EXIT
                               (|FCTOOL;exp2FortFn| |op| |args| |nargs|
                                $))))))))
                        ((EQUAL |op| "CMPLX")
                         (COND
                          ((SPADCALL |nargs| 2 (QREFELT $ 42))
                           (|error| "Bad number of arguments to CMPLX"))
                          (#4#
                           (CONS ")"
                                 (SPADCALL
                                  (|FCTOOL;exp2Fort2|
                                   (SPADCALL |args| (QREFELT $ 43)) |prec| |op|
                                   $)
                                  (CONS ","
                                        (SPADCALL
                                         (|FCTOOL;exp2Fort2|
                                          (|SPADfirst| |args|) |prec| |op| $)
                                         (CONS "(" NIL) (QREFELT $ 25)))
                                  (QREFELT $ 25))))))
                        (#4#
                         (COND
                          ((SPADCALL |op| (QREFELT $ 26) (QREFELT $ 44))
                           (SEQ
                            (LETT |p|
                                  (SPADCALL |op| (QREFELT $ 20)
                                            (QREFELT $ 36)))
                            (COND
                             ((EQL |p| 0)
                              (SEQ
                               (LETT |p|
                                     (SPADCALL |op| (QREFELT $ 22)
                                               (QREFELT $ 36)))
                               (EXIT
                                (LETT |nprec|
                                      (SPADCALL (QREFELT $ 23) |p|
                                                (QREFELT $ 38))))))
                             (#4#
                              (LETT |nprec|
                                    (SPADCALL (QREFELT $ 21) |p|
                                              (QREFELT $ 38)))))
                            (LETT |s| NIL)
                            (SEQ (LETT |arg| NIL) (LETT #3# |args|) G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |arg| (CAR #3#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ
                                    (COND
                                     ((EQUAL |op| "+")
                                      (COND
                                       ((NULL (SPADCALL |arg| (QREFELT $ 30)))
                                        (COND
                                         ((EQL
                                           (LENGTH
                                            (LETT |args1|
                                                  (SPADCALL |arg|
                                                            (QREFELT $ 33))))
                                           1)
                                          (SEQ
                                           (LETT |op1|
                                                 (|object2String|
                                                  (SPADCALL |arg|
                                                            (QREFELT $ 31))))
                                           (EXIT
                                            (COND
                                             ((EQUAL |op1| "-")
                                              (PROGN
                                               (LETT #1#
                                                     (SEQ
                                                      (COND
                                                       ((NULL |s|)
                                                        (LETT |s|
                                                              (LIST "junk"))))
                                                      (EXIT
                                                       (LETT |s|
                                                             (CONS |op|
                                                                   (SPADCALL
                                                                    (|FCTOOL;exp2Fort2|
                                                                     (|SPADfirst|
                                                                      |args1|)
                                                                     |nprec|
                                                                     |op| $)
                                                                    (CONS "-"
                                                                          (CDR
                                                                           |s|))
                                                                    (QREFELT $
                                                                             25)))))))
                                               (GO #5=#:G892))))))))))))
                                    (EXIT
                                     (LETT |s|
                                           (CONS |op|
                                                 (SPADCALL
                                                  (|FCTOOL;exp2Fort2| |arg|
                                                   |nprec| |op| $)
                                                  |s| (QREFELT $ 25)))))))
                                  #5# (EXIT #1#))
                                 (LETT #3# (CDR #3#)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |s| (CDR |s|))
                            (COND
                             ((EQUAL |op| |oldOp|)
                              (COND
                               ((OR (EQUAL |op| "*") (EQUAL |op| "+"))
                                (EXIT |s|)))))
                            (EXIT
                             (COND
                              ((<= |nprec| |prec|)
                               (CONS ")"
                                     (SPADCALL |s| (CONS "(" NIL)
                                               (QREFELT $ 25))))
                              (#4# |s|)))))
                          (#4#
                           (|FCTOOL;exp2FortFn| |op| |args| |nargs|
                            $)))))))))))) 

(SDEFUN |FCTOOL;exp2Fort1|
        ((|l| (|List| (|OutputForm|))) ($ (|List| (|String|))))
        (SPROG
         ((|res| (|List| (|String|))) (|l1| (|List| (|String|)))
          (#1=#:G907 NIL) (|e| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |l1| (|FCTOOL;exp2Fort2| |e| 0 "" $))
                        (EXIT
                         (LETT |res| (SPADCALL |l1| |res| (QREFELT $ 25)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FCTOOL;tempLen| (($ (|Integer|)))
        (+ 1 (QCSIZE (STRINGIMAGE (QREFELT $ 6))))) 

(SDEFUN |FCTOOL;fortExpSize_f|
        ((|op| (|OutputForm|)) (|args| (|List| (|OutputForm|)))
         ($ (|Integer|)))
        (SPROG
         ((#1=#:G910 NIL) (#2=#:G909 #3=(|Integer|)) (#4=#:G911 #3#)
          (#5=#:G913 NIL) (|a| NIL))
         (SEQ
          (+ (+ 1 (LENGTH |args|))
             (PROGN
              (LETT #1# NIL)
              (SEQ (LETT |a| NIL) (LETT #5# (CONS |op| |args|)) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |a| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (LETT #4# (|FCTOOL;fortExpSize| |a| $))
                      (COND (#1# (LETT #2# (+ #2# #4#)))
                            ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (COND (#1# #2#) ('T 0))))))) 

(SDEFUN |FCTOOL;same_subtree|
        ((|op| (|String|)) (|e| (|OutputForm|)) ($ (|Boolean|)))
        (SPROG ((|op2| (|String|)))
               (SEQ
                (COND ((SPADCALL |e| (QREFELT $ 30)) NIL)
                      ('T
                       (SEQ
                        (LETT |op2|
                              (STRINGIMAGE (SPADCALL |e| (QREFELT $ 31))))
                        (EXIT (EQUAL |op| |op2|)))))))) 

(SDEFUN |FCTOOL;same_subtree2|
        ((|op| (|Symbol|)) (|e| (|OutputForm|)) ($ (|Boolean|)))
        (SPROG ((|op2| (|OutputForm|)))
               (COND
                ((OR (SPADCALL |e| (QREFELT $ 30))
                     (NULL
                      (SPADCALL (LETT |op2| (SPADCALL |e| (QREFELT $ 31)))
                                (QREFELT $ 39))))
                 NIL)
                ('T (EQUAL |op| (SPADCALL |op2| (QREFELT $ 40))))))) 

(SDEFUN |FCTOOL;fortExpSize| ((|e| (|OutputForm|)) ($ (|Integer|)))
        (SPROG
         ((|narys| (|List| (|String|))) (|ops| (|String|))
          (|arg2| #1=(|OutputForm|)) (|arg1| #1#)
          (|args| (|List| (|OutputForm|))) (|op| (|OutputForm|))
          (|s| (|String|)))
         (SEQ
          (COND
           ((SPADCALL |e| (QREFELT $ 30))
            (SEQ (LETT |s| (STRINGIMAGE |e|)) (EXIT (QCSIZE |s|))))
           (#2='T
            (SEQ (LETT |op| (SPADCALL |e| (QREFELT $ 31)))
                 (LETT |args| (SPADCALL |e| (QREFELT $ 33)))
                 (EXIT
                  (COND
                   ((OR (> (LENGTH |args|) 2) (< (LENGTH |args|) 2))
                    (|FCTOOL;fortExpSize_f| |op| |args| $))
                   ('T
                    (SEQ (LETT |arg1| (SPADCALL |args| 1 (QREFELT $ 35)))
                         (LETT |arg2| (SPADCALL |args| 2 (QREFELT $ 35)))
                         (LETT |ops| (STRINGIMAGE |op|))
                         (EXIT
                          (COND
                           ((EQUAL |ops| "CMPLX")
                            (+ (+ 5 (|FCTOOL;fortExpSize| |arg1| $))
                               (|FCTOOL;fortExpSize| |arg2| $)))
                           (#2#
                            (SEQ (LETT |narys| (LIST "+" "*"))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |ops| |narys| (QREFELT $ 44))
                                    (SEQ
                                     (COND
                                      ((|FCTOOL;same_subtree| |ops| |arg1| $)
                                       (COND
                                        ((NULL
                                          (|FCTOOL;same_subtree| |ops| |arg2|
                                           $))
                                         (EXIT
                                          (|FCTOOL;fortExpSize_f| |op| |args|
                                           $)))))
                                      (#2#
                                       (EXIT
                                        (|FCTOOL;fortExpSize_f| |op| |args|
                                         $))))
                                     (EXIT
                                      (+ (+ 1 (|FCTOOL;fortExpSize| |arg1| $))
                                         (|FCTOOL;fortExpSize| |arg2| $)))))
                                   (#2#
                                    (|FCTOOL;fortExpSize_f| |op| |args|
                                     $)))))))))))))))))) 

(SDEFUN |FCTOOL;mk_assign2|
        ((|name| (|OutputForm|)) (|val| (|OutputForm|)) ($ (|OutputForm|)))
        (SPADCALL (QREFELT $ 46) (LIST |name| |val|) (QREFELT $ 48))) 

(SDEFUN |FCTOOL;mk_assign1|
        ((|name| (|Symbol|)) (|val| (|OutputForm|)) ($ (|OutputForm|)))
        (|FCTOOL;mk_assign2| (SPADCALL |name| (QREFELT $ 45)) |val| $)) 

(SDEFUN |FCTOOL;segment2l|
        ((|op| (|OutputForm|)) (|args| (|List| (|OutputForm|)))
         (|topSize| (|Integer|)) ($ (|List| (|OutputForm|))))
        (SPROG
         ((|newVar| #1=(|Symbol|)) (|new_e1| (|OutputForm|))
          (|newE| (|List| (|OutputForm|))) (|exprs| (|List| (|OutputForm|)))
          (|new_var_f| (|OutputForm|)) (|new_var| #1#) (|subSize| (|Integer|))
          (|subE| (|List| (|OutputForm|))) (#2=#:G943 NIL) (|e| NIL)
          (|maxSize| (|Integer|)))
         (SEQ
          (LETT |maxSize|
                (- (- |$maximumFortranExpressionLength| (|FCTOOL;tempLen| $))
                   1))
          (LETT |exprs| NIL) (LETT |newE| NIL)
          (LETT |topSize|
                (- |topSize|
                   (|FCTOOL;fortExpSize| (SPADCALL |op| NIL (QREFELT $ 48))
                    $)))
          (SEQ (LETT |e| NIL) (LETT #2# |args|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL)) (GO G191)))
               (SEQ (LETT |subSize| (|FCTOOL;fortExpSize| |e| $))
                    (EXIT
                     (COND
                      ((> |subSize| |maxSize|)
                       (SEQ (LETT |subE| (|FCTOOL;segment2| |e| |maxSize| $))
                            (LETT |exprs|
                                  (SPADCALL (CDR |subE|) |exprs|
                                            (QREFELT $ 49)))
                            (LETT |subSize|
                                  (|FCTOOL;fortExpSize| (|SPADfirst| |subE|)
                                   $))
                            (EXIT
                             (COND
                              ((<= |subSize| |topSize|)
                               (SEQ
                                (LETT |newE|
                                      (SPADCALL |newE|
                                                (CONS (|SPADfirst| |subE|) NIL)
                                                (QREFELT $ 49)))
                                (EXIT
                                 (LETT |topSize| (- |topSize| |subSize|)))))
                              ('T
                               (SEQ (LETT |new_var| (SPADCALL (QREFELT $ 16)))
                                    (LETT |new_var_f|
                                          (SPADCALL |new_var| (QREFELT $ 45)))
                                    (LETT |newE|
                                          (SPADCALL |newE|
                                                    (CONS |new_var_f| NIL)
                                                    (QREFELT $ 49)))
                                    (LETT |exprs|
                                          (CONS
                                           (|FCTOOL;mk_assign1| |new_var|
                                            (|SPADfirst| |subE|) $)
                                           |exprs|))
                                    (EXIT
                                     (LETT |topSize|
                                           (- |topSize|
                                              (|FCTOOL;fortExpSize| |new_var_f|
                                               $))))))))))
                      ('T
                       (SEQ
                        (LETT |newE|
                              (SPADCALL |newE| (CONS |e| NIL) (QREFELT $ 49)))
                        (EXIT (LETT |topSize| (- |topSize| |subSize|))))))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (LETT |new_e1| (SPADCALL |op| |newE| (QREFELT $ 48)))
          (EXIT
           (COND ((> |topSize| 0) (CONS |new_e1| |exprs|))
                 ('T
                  (SEQ (LETT |newVar| (SPADCALL (QREFELT $ 16)))
                       (EXIT
                        (CONS (SPADCALL |newVar| (QREFELT $ 45))
                              (CONS (|FCTOOL;mk_assign1| |newVar| |new_e1| $)
                                    |exprs|)))))))))) 

(SDEFUN |FCTOOL;segment2|
        ((|e| (|OutputForm|)) (|topSize| (|Integer|))
         ($ (|List| (|OutputForm|))))
        (COND ((SPADCALL |e| (QREFELT $ 30)) (LIST |e|))
              ('T
               (|FCTOOL;segment2l| (SPADCALL |e| (QREFELT $ 31))
                (SPADCALL |e| (QREFELT $ 33)) |topSize| $)))) 

(SDEFUN |FCTOOL;segment1l|
        ((|op| (|OutputForm|)) (|args| (|List| (|OutputForm|)))
         (|maxSize| (|Integer|)) ($ (|List| (|OutputForm|))))
        (SPROG
         ((|safeSize| (|Integer|)) (|new_args| (|List| (|OutputForm|)))
          (|expressions| (|List| (|OutputForm|)))
          (|exprs| (|List| (|OutputForm|))) (|subSize| (|Integer|))
          (#1=#:G953 NIL) (|e| NIL))
         (SEQ (LETT |expressions| NIL) (LETT |new_args| NIL)
              (LETT |safeSize|
                    (-
                     (- |maxSize|
                        (* (LENGTH |args|) (+ (|FCTOOL;tempLen| $) 1)))
                     (|FCTOOL;fortExpSize| (SPADCALL |op| NIL (QREFELT $ 48))
                      $)))
              (SEQ (LETT |e| NIL) (LETT #1# |args|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |subSize| (|FCTOOL;fortExpSize| |e| $))
                        (EXIT
                         (COND
                          ((<= |subSize| |safeSize|)
                           (SEQ (LETT |safeSize| (- |safeSize| |subSize|))
                                (EXIT
                                 (LETT |new_args|
                                       (SPADCALL |new_args| (CONS |e| NIL)
                                                 (QREFELT $ 49))))))
                          ('T
                           (SEQ
                            (LETT |exprs| (|FCTOOL;segment2| |e| |safeSize| $))
                            (LETT |expressions|
                                  (SPADCALL (CDR |exprs|) |expressions|
                                            (QREFELT $ 49)))
                            (LETT |new_args|
                                  (SPADCALL |new_args|
                                            (CONS (|SPADfirst| |exprs|) NIL)
                                            (QREFELT $ 49)))
                            (EXIT
                             (LETT |safeSize|
                                   (- |safeSize|
                                      (|FCTOOL;fortExpSize|
                                       (|SPADfirst| |exprs|) $)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (CONS (SPADCALL |op| |new_args| (QREFELT $ 48))
                     |expressions|))))) 

(SDEFUN |FCTOOL;segment1|
        ((|e| (|OutputForm|)) (|maxSize| (|Integer|))
         ($ (|List| (|OutputForm|))))
        (COND ((< (|FCTOOL;fortExpSize| |e| $) |maxSize|) (LIST |e|))
              ((SPADCALL |e| (QREFELT $ 30))
               (|error| "segment1 expecting composite form"))
              ('T
               (|FCTOOL;segment1l| (SPADCALL |e| (QREFELT $ 31))
                (SPADCALL |e| (QREFELT $ 33)) |maxSize| $)))) 

(SDEFUN |FCTOOL;segment|
        ((|l| (|List| (|OutputForm|))) ($ (|List| (|OutputForm|))))
        (SPROG
         ((|s| (|List| (|OutputForm|))) (|exprs| (|List| (|OutputForm|)))
          (|var| (|OutputForm|)) (|args| (|List| (|OutputForm|)))
          (|e1s| (|Symbol|)) (|e1f| (|OutputForm|)) (#1=#:G968 NIL) (|e| NIL))
         (SEQ
          (COND ((NULL |$fortranSegment|) |l|)
                ('T
                 (SEQ (LETT |s| NIL)
                      (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |e| (QREFELT $ 30))
                               (LETT |s| (CONS |e| |s|)))
                              ('T
                               (SEQ (LETT |e1f| (SPADCALL |e| (QREFELT $ 31)))
                                    (COND
                                     ((NULL (SPADCALL |e1f| (QREFELT $ 39)))
                                      (EXIT (LETT |s| (CONS |e| |s|)))))
                                    (LETT |e1s|
                                          (SPADCALL |e1f| (QREFELT $ 40)))
                                    (LETT |args| (SPADCALL |e| (QREFELT $ 33)))
                                    (EXIT
                                     (COND
                                      ((EQUAL |e1s| '=)
                                       (SEQ
                                        (LETT |var|
                                              (SPADCALL |args| 1
                                                        (QREFELT $ 35)))
                                        (LETT |exprs|
                                              (|FCTOOL;segment1|
                                               (SPADCALL |args| 2
                                                         (QREFELT $ 35))
                                               (-
                                                (|sub_SI|
                                                 |$maximumFortranExpressionLength|
                                                 1)
                                                (|FCTOOL;fortExpSize| |var| $))
                                               $))
                                        (EXIT
                                         (LETT |s|
                                               (CONS
                                                (SPADCALL |e1f|
                                                          (LIST |var|
                                                                (|SPADfirst|
                                                                 |exprs|))
                                                          (QREFELT $ 48))
                                                (SPADCALL (CDR |exprs|) |s|
                                                          (QREFELT $ 49)))))))
                                      ((EQUAL |e1s| 'RETURN)
                                       (SEQ
                                        (LETT |exprs|
                                              (|FCTOOL;segment1|
                                               (SPADCALL |args| 1
                                                         (QREFELT $ 35))
                                               (-
                                                (|sub_SI|
                                                 |$maximumFortranExpressionLength|
                                                 2)
                                                (|FCTOOL;fortExpSize|
                                                 (SPADCALL |args| 1
                                                           (QREFELT $ 35))
                                                 $))
                                               $))
                                        (EXIT
                                         (LETT |s|
                                               (CONS
                                                (SPADCALL |e1f|
                                                          (LIST
                                                           (|SPADfirst|
                                                            |exprs|))
                                                          (QREFELT $ 48))
                                                (SPADCALL (CDR |exprs|) |s|
                                                          (QREFELT $ 49)))))))
                                      ('T (LETT |s| (CONS |e| |s|))))))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (NREVERSE |s|)))))))) 

(SDEFUN |FCTOOL;fortError2|
        ((|msg| (|String|)) (|e| (|OutputForm|)) ($ (|Exit|)))
        (SEQ (|sayErrorly| "Fortran translation error" |msg|) (|mathPrint| |e|)
             (EXIT (|error| "")))) 

(SDEFUN |FCTOOL;fortError1| ((|e| (|OutputForm|)) ($ (|Exit|)))
        (|FCTOOL;fortError2| "   No corresponding Fortran structure for:" |e|
         $)) 

(SDEFUN |FCTOOL;fortError1l|
        ((|op| (|Symbol|)) (|args| (|List| (|OutputForm|))) ($ (|Exit|)))
        (|FCTOOL;fortError1|
         (SPADCALL (SPADCALL |op| (QREFELT $ 45)) |args| (QREFELT $ 48)) $)) 

(SDEFUN |FCTOOL;push_expr_stack| ((|e| (|OutputForm|)) ($ (|Void|)))
        (SETELT $ 50 (CONS |e| (QREFELT $ 50)))) 

(SDEFUN |FCTOOL;pop_expr_stack| (($ (|OutputForm|)))
        (SPROG ((|res| (|OutputForm|)))
               (SEQ (LETT |res| (|SPADfirst| (QREFELT $ 50)))
                    (SETELT $ 50 (CDR (QREFELT $ 50))) (EXIT |res|)))) 

(SDEFUN |FCTOOL;clear_used_intrinsics;V;24| (($ (|Void|))) (SETELT $ 51 NIL)) 

(SDEFUN |FCTOOL;get_used_intrinsics;L;25| (($ (|List| (|String|))))
        (SPROG ((#1=#:G981 NIL) (|sy| NIL) (#2=#:G980 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |sy| NIL) (LETT #1# (QREFELT $ 51)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |sy| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |sy| (QREFELT $ 54)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FCTOOL;record_intrinsic| ((|sy| (|Symbol|)) ($ (|Void|)))
        (COND
         ((NULL (SPADCALL |sy| (QREFELT $ 51) (QREFELT $ 57)))
          (SETELT $ 51 (CONS |sy| (QREFELT $ 51)))))) 

(SDEFUN |FCTOOL;fortranifyIntrinsicFunctionName|
        ((|sy| (|Symbol|)) (|nargs| (|Integer|)) ($ (|Symbol|)))
        (SPROG
         ((#1=#:G996 NIL) (#2=#:G997 NIL) (|r1| NIL)
          (|use_double| (|Boolean|)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |use_double|
                  (COND (|$useIntrinsicFunctions| NIL)
                        (#3='T (EQUAL |$fortranPrecision| '|double|))))
            (COND
             ((EQUAL |sy| '|atan|)
              (COND
               ((EQL |nargs| 2)
                (EXIT
                 (COND
                  (|$useIntrinsicFunctions|
                   (SEQ (|FCTOOL;record_intrinsic| 'ATAN2 $) (EXIT 'ATAN2)))
                  (|use_double| 'DATAN2) (#3# 'ATAN2)))))))
            (SEQ (LETT |r1| NIL) (LETT #2# (QREFELT $ 58)) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |r1| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((EQUAL (QVELT |r1| 0) |sy|)
                     (COND
                      (|$useIntrinsicFunctions|
                       (SEQ (|FCTOOL;record_intrinsic| (QVELT |r1| 1) $)
                            (EXIT
                             (PROGN
                              (LETT #1# (QVELT |r1| 1))
                              (GO #4=#:G995)))))
                      (|use_double| (PROGN (LETT #1# (QVELT |r1| 2)) (GO #4#)))
                      ('T (PROGN (LETT #1# (QVELT |r1| 1)) (GO #4#))))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT |sy|)))
          #4# (EXIT #1#)))) 

(SDEFUN |FCTOOL;fortranifyFunctionName|
        ((|sy| (|Symbol|)) (|nargs| (|Integer|)) ($ (|Symbol|)))
        (SPROG ((#1=#:G1004 NIL) (#2=#:G1005 NIL) (|p1| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |p1| NIL) (LETT #2# (QREFELT $ 59)) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |p1| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((EQUAL (QCAR |p1|) |sy|)
                           (PROGN (LETT #1# (QCDR |p1|)) (GO #3=#:G1003))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (|FCTOOL;fortranifyIntrinsicFunctionName| |sy| |nargs| $))))
                #3# (EXIT #1#)))) 

(SDEFUN |FCTOOL;mkFortFn|
        ((|name| #1=(|OutputForm|)) (|args| (|List| (|OutputForm|)))
         (|nargs| (|Integer|)) ($ (|OutputForm|)))
        (SPROG ((#2=#:G1013 NIL) (|arg| NIL) (#3=#:G1012 NIL) (|nn| #1#))
               (SEQ
                (LETT |nn|
                      (COND ((NULL (SPADCALL |name| (QREFELT $ 39))) |name|)
                            ('T
                             (SPADCALL
                              (|FCTOOL;fortranifyFunctionName|
                               (SPADCALL |name| (QREFELT $ 40)) |nargs| $)
                              (QREFELT $ 45)))))
                (EXIT
                 (SPADCALL |nn|
                           (PROGN
                            (LETT #3# NIL)
                            (SEQ (LETT |arg| NIL) (LETT #2# |args|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |arg| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #3#
                                         (CONS (|FCTOOL;fortPre1| |arg| $)
                                               #3#))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT (NREVERSE #3#))))
                           (QREFELT $ 48)))))) 

(SDEFUN |FCTOOL;mkMat| ((|args| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (SPROG ((|save_fortInts2Floats| (|Boolean|)))
               (SEQ (LETT |save_fortInts2Floats| |$fortInts2Floats|)
                    (EXIT
                     (|finally|
                      (SEQ (SETF |$fortInts2Floats| NIL)
                           (EXIT
                            (|FCTOOL;mkFortFn| (|SPADfirst| |args|)
                             (CDR |args|) (LENGTH (CDR |args|)) $)))
                      (SETF |$fortInts2Floats| |save_fortInts2Floats|)))))) 

(SDEFUN |FCTOOL;fortPreRoot| ((|e| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG ((|save_fortInts2Floats| (|Boolean|)))
               (SEQ (LETT |save_fortInts2Floats| |$fortInts2Floats|)
                    (EXIT
                     (|finally|
                      (SEQ (SETF |$fortInts2Floats| 'T)
                           (EXIT (|FCTOOL;fortPre1| |e| $)))
                      (SETF |$fortInts2Floats| |save_fortInts2Floats|)))))) 

(SDEFUN |FCTOOL;exp2FortSpecial|
        ((|op| (|Symbol|)) (|args| (|List| (|OutputForm|)))
         (|nargs| (|Integer|)) ($ (|OutputForm|)))
        (SPROG
         ((|as1| (|OutputForm|)) (#1=#:G1105 NIL) (|c| NIL) (|cx| NIL)
          (|rx_f| (|OutputForm|)) (#2=#:G1104 NIL) (|r| NIL) (|rx| NIL)
          (|si| (|Integer|)) (|rows| (|List| (|OutputForm|)))
          (|var| (|OutputForm|)) (#3=#:G1103 NIL) (|e| NIL) (|i| NIL)
          (|elts| #4=(|List| (|OutputForm|))) (#5=#:G1102 NIL) (|ii| NIL)
          (|i2| #6=(|Integer|)) (|i1| #6#) (|sArgs| #4#)
          (|sOp| #7=(|OutputForm|)) (|op1| #7#) (|old_Ints2Floats| (|Boolean|))
          (|tailPart| (|List| (|String|))) (#8=#:G1101 NIL) (|x| NIL)
          (#9=#:G1100 NIL) (|n_args| #4#) (|arg| (|OutputForm|)))
         (SEQ
          (COND
           ((EQUAL |op| 'CONCAT)
            (COND
             ((SPADCALL (SPADCALL |args| 1 (QREFELT $ 35)) (QREFELT $ 39))
              (COND
               ((SPADCALL
                 (SPADCALL (SPADCALL |args| 1 (QREFELT $ 35)) (QREFELT $ 40))
                 (LIST '< '> '<= '>= '~ '|and| '|or|) (QREFELT $ 57))
                (EXIT
                 (SEQ
                  (LETT |n_args|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 35))
                                    (QREFELT $ 33))
                          1 (QREFELT $ 35))
                         (QREFELT $ 33)))
                  (EXIT
                   (|FCTOOL;mkFortFn| (|SPADfirst| |args|) |n_args|
                    (LENGTH |n_args|) $))))))))))
          (COND
           ((EQUAL |op| 'CONCAT)
            (COND
             ((SPADCALL (SPADCALL |args| 2 (QREFELT $ 35)) (QREFELT $ 39))
              (COND
               ((EQUAL
                 (SPADCALL (SPADCALL |args| 2 (QREFELT $ 35)) (QREFELT $ 40))
                 'EQ)
                (EXIT
                 (|FCTOOL;mkFortFn| (SPADCALL |args| 2 (QREFELT $ 35))
                  (LIST (|SPADfirst| |args|)
                        (SPADCALL |args| 3 (QREFELT $ 35)))
                  2 $))))))))
          (EXIT
           (COND
            ((EQUAL |op| 'QUOTE)
             (COND
              ((SPADCALL (LETT |arg| (|SPADfirst| |args|)) (QREFELT $ 30))
               (STRINGIMAGE |arg|))
              (#10='T
               (SEQ (LETT |n_args| (SPADCALL |arg| (QREFELT $ 33)))
                    (LETT |tailPart|
                          (PROGN
                           (LETT #9# NIL)
                           (SEQ (LETT |x| NIL) (LETT #8# |n_args|) G190
                                (COND
                                 ((OR (ATOM #8#)
                                      (PROGN (LETT |x| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #9#
                                        (CONS
                                         (STRCONC ","
                                                  (SPADCALL |x|
                                                            (QREFELT $ 60)))
                                         #9#))))
                                (LETT #8# (CDR #8#)) (GO G190) G191
                                (EXIT (NREVERSE #9#)))))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (CONS "["
                             (CONS
                              (SPADCALL (SPADCALL |arg| (QREFELT $ 31))
                                        (QREFELT $ 60))
                              (SPADCALL |tailPart| (CONS "]" NIL)
                                        (QREFELT $ 25))))
                       (QREFELT $ 61))
                      (QREFELT $ 62)))))))
            ((EQUAL |op| 'PAREN)
             (SEQ
              (LETT |op1|
                    (SPADCALL (SPADCALL |args| 1 (QREFELT $ 35))
                              (QREFELT $ 31)))
              (COND
               ((SPADCALL |op1| (QREFELT $ 39))
                (COND
                 ((NULL (EQUAL (SPADCALL |op1| (QREFELT $ 40)) 'CONCATB))
                  (EXIT
                   (SPADCALL (SPADCALL 'PAREN (QREFELT $ 63))
                             (LIST
                              (|FCTOOL;fortPre1|
                               (SPADCALL |args| 1 (QREFELT $ 35)) $))
                             (QREFELT $ 48))))))
               (#10#
                (EXIT
                 (SPADCALL (SPADCALL 'PAREN (QREFELT $ 63))
                           (LIST
                            (|FCTOOL;fortPre1|
                             (SPADCALL |args| 1 (QREFELT $ 35)) $))
                           (QREFELT $ 48)))))
              (EXIT
               (|FCTOOL;mkMat|
                (SPADCALL (SPADCALL |args| 1 (QREFELT $ 35)) (QREFELT $ 33))
                $))))
            ((EQUAL |op| 'SUB)
             (SEQ (LETT |old_Ints2Floats| |$fortInts2Floats|)
                  (EXIT
                   (|finally|
                    (SEQ (SETF |$fortInts2Floats| NIL)
                         (EXIT
                          (|FCTOOL;mkFortFn| (|SPADfirst| |args|) (CDR |args|)
                           (LENGTH (CDR |args|)) $)))
                    (SETF |$fortInts2Floats| |old_Ints2Floats|)))))
            ((OR (EQUAL |op| 'BRACE) (EQUAL |op| 'BRACKET))
             (SEQ
              (COND
               ((EQL (LENGTH |args|) 2)
                (COND
                 ((NULL
                   (SPADCALL (SPADCALL |args| 2 (QREFELT $ 35))
                             (QREFELT $ 30)))
                  (COND
                   ((SPADCALL
                     (LETT |op1|
                           (SPADCALL (SPADCALL |args| 2 (QREFELT $ 35))
                                     (QREFELT $ 31)))
                     (QREFELT $ 39))
                    (COND
                     ((EQUAL (SPADCALL |op1| (QREFELT $ 40)) 'AGGLST)
                      (EXIT
                       (SEQ (LETT |var| (SPADCALL |args| 1 (QREFELT $ 35)))
                            (LETT |elts|
                                  (SPADCALL (SPADCALL |args| 2 (QREFELT $ 35))
                                            (QREFELT $ 33)))
                            (LETT |si| |$fortranArrayStartingIndex|)
                            (COND
                             ((EQL (LENGTH |elts|) 1)
                              (COND
                               ((NULL
                                 (SPADCALL (SPADCALL |elts| 1 (QREFELT $ 35))
                                           (QREFELT $ 30)))
                                (SEQ
                                 (LETT |sOp|
                                       (SPADCALL
                                        (SPADCALL |elts| 1 (QREFELT $ 35))
                                        (QREFELT $ 31)))
                                 (LETT |sArgs|
                                       (SPADCALL
                                        (SPADCALL |elts| 1 (QREFELT $ 35))
                                        (QREFELT $ 33)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |sOp| (QREFELT $ 39))
                                    (COND
                                     ((EQUAL (SPADCALL |sOp| (QREFELT $ 40))
                                             'SEGMENT)
                                      (COND
                                       ((EQL (LENGTH |sArgs|) 1)
                                        (|FCTOOL;fortError1|
                                         (|SPADfirst| |elts|) $))
                                       (#10#
                                        (SEQ
                                         (COND
                                          ((SPADCALL
                                            (SPADCALL |sArgs| 1 (QREFELT $ 35))
                                            (QREFELT $ 64))
                                           (COND
                                            ((NULL
                                              (SPADCALL
                                               (SPADCALL |sArgs| 2
                                                         (QREFELT $ 35))
                                               (QREFELT $ 64)))
                                             (EXIT
                                              (|FCTOOL;fortError2|
                                               #11="   Cannot expand segment: "
                                               (|SPADfirst| |elts|) $)))))
                                          (#10#
                                           (EXIT
                                            (|FCTOOL;fortError2| #11#
                                             (|SPADfirst| |elts|) $))))
                                         (LETT |i1|
                                               (SPADCALL
                                                (SPADCALL |sArgs| 1
                                                          (QREFELT $ 35))
                                                (QREFELT $ 65)))
                                         (LETT |i2|
                                               (SPADCALL
                                                (SPADCALL |sArgs| 2
                                                          (QREFELT $ 35))
                                                (QREFELT $ 65)))
                                         (EXIT
                                          (COND
                                           ((> |i1| |i2|)
                                            (|FCTOOL;fortError1|
                                             (SPADCALL
                                              "Lower bound of segment exceeds upper bound."
                                              (QREFELT $ 62))
                                             $))
                                           (#10#
                                            (SEQ
                                             (SEQ (LETT |i| |si|)
                                                  (LETT |ii| |i1|)
                                                  (LETT #5# |i2|) G190
                                                  (COND
                                                   ((> |ii| #5#) (GO G191)))
                                                  (SEQ
                                                   (LETT |as1|
                                                         (|FCTOOL;mk_assign2|
                                                          (SPADCALL |var|
                                                                    (LIST
                                                                     (SPADCALL
                                                                      |i|
                                                                      (QREFELT
                                                                       $ 66)))
                                                                    (QREFELT $
                                                                             48))
                                                          (|FCTOOL;fortPre1|
                                                           (SPADCALL |ii|
                                                                     (QREFELT $
                                                                              66))
                                                           $)
                                                          $))
                                                   (EXIT
                                                    (|FCTOOL;push_expr_stack|
                                                     |as1| $)))
                                                  (LETT |ii|
                                                        (PROG1 (+ |ii| 1)
                                                          (LETT |i|
                                                                (+ |i| 1))))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (LETT |elts|
                                                    NIL)))))))))))))))))))
                            (SEQ (LETT |i| |si|) (LETT |e| NIL)
                                 (LETT #3# |elts|) G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |e| (CAR #3#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |as1|
                                        (|FCTOOL;mk_assign2|
                                         (SPADCALL |var|
                                                   (LIST
                                                    (SPADCALL |i|
                                                              (QREFELT $ 66)))
                                                   (QREFELT $ 48))
                                         (|FCTOOL;fortPre1| |e| $) $))
                                  (EXIT (|FCTOOL;push_expr_stack| |as1| $)))
                                 (LETT #3#
                                       (PROG1 (CDR #3#) (LETT |i| (+ |i| 1))))
                                 (GO G190) G191 (EXIT NIL))
                            (EXIT (|FCTOOL;pop_expr_stack| $))))))))))))
              (EXIT
               (PROGN
                (|FCTOOL;fortError1l| |op| |args| $)
                (|userError| #12="Did not really exit.")))))
            ((OR (EQUAL |op| 'CONCAT) (EQUAL |op| 'CONCATB))
             (COND ((EQL |nargs| 0) NIL)
                   ((EQL |nargs| 1) (|FCTOOL;fortPre1| (|SPADfirst| |args|) $))
                   (#10#
                    (SEQ
                     (COND
                      ((EQL |nargs| 2)
                       (COND
                        ((SPADCALL (SPADCALL |args| 2 (QREFELT $ 35))
                                   (QREFELT $ 39))
                         (COND
                          ((EQUAL
                            (SPADCALL (SPADCALL |args| 2 (QREFELT $ 35))
                                      (QREFELT $ 40))
                            '!)
                           (EXIT
                            (|FCTOOL;mkFortFn| 'FACTORIAL
                             (LIST (|SPADfirst| |args|)) 1 $))))))))
                     (EXIT
                      (PROGN
                       (|FCTOOL;fortError1l| |op| |args| $)
                       (|userError| #12#)))))))
            ('T
             (COND
              ((EQUAL |op| 'MATRIX)
               (SEQ (LETT |var| (SPADCALL |args| 1 (QREFELT $ 35)))
                    (LETT |rows| (CDR (CDR |args|)))
                    (LETT |si| |$fortranArrayStartingIndex|)
                    (SEQ (LETT |rx| |si|) (LETT |r| NIL) (LETT #2# |rows|) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |r| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |rx_f| (SPADCALL |rx| (QREFELT $ 66)))
                              (EXIT
                               (SEQ (LETT |cx| |si|) (LETT |c| NIL)
                                    (LETT #1# (SPADCALL |r| (QREFELT $ 33)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |c| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (LETT |as1|
                                           (|FCTOOL;mk_assign2|
                                            (SPADCALL |var|
                                                      (LIST |rx_f|
                                                            (SPADCALL |cx|
                                                                      (QREFELT
                                                                       $ 66)))
                                                      (QREFELT $ 48))
                                            (|FCTOOL;fortPre1| |c| $) $))
                                     (EXIT (|FCTOOL;push_expr_stack| |as1| $)))
                                    (LETT #1#
                                          (PROG1 (CDR #1#)
                                            (LETT |cx| (+ |cx| 1))))
                                    (GO G190) G191 (EXIT NIL))))
                         (LETT #2# (PROG1 (CDR #2#) (LETT |rx| (+ |rx| 1))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT (|FCTOOL;pop_expr_stack| $))))
              (#10#
               (PROGN
                (|FCTOOL;fortError1l| |op| |args| $)
                (|userError| #12#)))))))))) 

(SDEFUN |FCTOOL;is_imaginary| ((|x| (|OutputForm|)) ($ (|Boolean|)))
        (COND ((NULL (SPADCALL |x| (QREFELT $ 39))) NIL)
              ('T (EQUAL (SPADCALL |x| (QREFELT $ 40)) '|%i|)))) 

(SDEFUN |FCTOOL;fix2FortranFloat| ((|i| (|Integer|)) ($ (|OutputForm|)))
        (SPROG ((|ss| (|String|)))
               (SEQ (LETT |ss| (STRINGIMAGE |i|))
                    (LETT |ss|
                          (STRCONC |ss|
                                   (COND
                                    ((EQUAL |$fortranPrecision| '|double|)
                                     ".0D0")
                                    ('T ".0"))))
                    (EXIT (SPADCALL |ss| (QREFELT $ 62)))))) 

(SDEFUN |FCTOOL;checkPrecision1| ((|s| (|String|)) ($ (|String|)))
        (SPROG ((|p2| #1=(|Integer|)) (|p1| #1#) (|s2| (|String|)))
               (SEQ
                (COND
                 ((|eql_SI| (SPADCALL |s| 1 (QREFELT $ 70))
                            (|STR_to_CHAR| "\""))
                  |s|)
                 (#2='T
                  (SEQ
                   (LETT |s2|
                         (SPADCALL (|STR_to_CHAR| " ")
                                   (SPADCALL (|STR_to_CHAR| "_") |s|
                                             (QREFELT $ 72))
                                   (QREFELT $ 72)))
                   (LETT |p1|
                         (SPADCALL (|STR_to_CHAR| ".") |s2| (QREFELT $ 73)))
                   (EXIT
                    (COND ((< |p1| 1) |s|)
                          ((SPADCALL |$fortranPrecision| '|double|
                                     (QREFELT $ 74))
                           |s2|)
                          (#2#
                           (SEQ
                            (LETT |p2|
                                  (SPADCALL (|STR_to_CHAR| "E") |s2|
                                            (QREFELT $ 73)))
                            (EXIT
                             (COND
                              ((> |p2| 0)
                               (SEQ
                                (SPADCALL |s2| |p2|
                                          (SPADCALL "D" 1 (QREFELT $ 70))
                                          (QREFELT $ 75))
                                (EXIT |s2|)))
                              (#2# (STRCONC |s2| "D0")))))))))))))) 

(SDEFUN |FCTOOL;checkPrecision| ((|s| (|String|)) ($ (|OutputForm|)))
        (SPADCALL (|FCTOOL;checkPrecision1| |s| $) (QREFELT $ 62))) 

(SDEFUN |FCTOOL;fortPre1| ((|e| (|OutputForm|)) ($ #1=(|OutputForm|)))
        (SPROG
         ((|n_args| #2=(|List| (|OutputForm|))) (|arg2| #3=(|OutputForm|))
          (|arg1| #3#) (|im_op| (|OutputForm|)) (|binaryExpr| #1#)
          (#4=#:G1164 NIL) (|e1| NIL) (|op| (|OutputForm|))
          (|sy| #5=(|Symbol|)) (#6=#:G1163 NIL) (|sr| #5#) (|exponent| #3#)
          (|rand| #3#) (|args| #2#) (|ss| (|String|)) (|ii| (|Integer|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |e| (QREFELT $ 30))
             (COND
              ((SPADCALL |e| (QREFELT $ 64))
               (COND
                (|$fortInts2Floats|
                 (SEQ (LETT |ii| (SPADCALL |e| (QREFELT $ 65)))
                      (EXIT
                       (COND ((>= |ii| 0) (|FCTOOL;fix2FortranFloat| |ii| $))
                             (#7='T
                              (SPADCALL (SPADCALL '- (QREFELT $ 63))
                                        (LIST
                                         (|FCTOOL;fix2FortranFloat| (- |ii|)
                                          $))
                                        (QREFELT $ 48)))))))
                (#7# |e|)))
              ((SPADCALL |e| (QREFELT $ 76))
               (|FCTOOL;checkPrecision| (SPADCALL |e| (QREFELT $ 60)) $))
              ((SPADCALL |e| (QREFELT $ 39))
               (SEQ (LETT |sy| (SPADCALL |e| (QREFELT $ 40)))
                    (EXIT
                     (COND
                      ((EQUAL |sy| '|%e|)
                       (|FCTOOL;fortPre1|
                        (SPADCALL (SPADCALL '|exp| (QREFELT $ 45))
                                  (LIST (SPADCALL 1 (QREFELT $ 66)))
                                  (QREFELT $ 48))
                        $))
                      ((EQUAL |sy| '|%i|)
                       (SPADCALL (SPADCALL 'CMPLX (QREFELT $ 45))
                                 (LIST
                                  (|FCTOOL;fortPre1|
                                   (SPADCALL 0 (QREFELT $ 66)) $)
                                  (|FCTOOL;fortPre1|
                                   (SPADCALL 1 (QREFELT $ 66)) $))
                                 (QREFELT $ 48)))
                      (#7#
                       (SEQ (LETT |ss| (SPADCALL |sy| (QREFELT $ 54)))
                            (EXIT
                             (COND
                              ((|eql_SI| (SPADCALL |ss| 1 (QREFELT $ 70))
                                         (|STR_to_CHAR| "%"))
                               (SPADCALL
                                (SPADCALL |ss| (SPADCALL 2 (QREFELT $ 78))
                                          (QREFELT $ 79))
                                (QREFELT $ 62)))
                              (#7# |e|)))))))))
              (#7# |e|)))
            (#7#
             (SEQ (LETT |op| (SPADCALL |e| (QREFELT $ 31)))
                  (LETT |args| (SPADCALL |e| (QREFELT $ 33)))
                  (EXIT
                   (COND
                    ((SPADCALL |op| (QREFELT $ 39))
                     (SEQ (LETT |sy| (SPADCALL |op| (QREFELT $ 40)))
                          (EXIT
                           (COND
                            ((EQUAL |sy| '^)
                             (SEQ
                              (LETT |rand| (SPADCALL |args| 1 (QREFELT $ 35)))
                              (LETT |exponent|
                                    (SPADCALL |args| 2 (QREFELT $ 35)))
                              (COND
                               ((SPADCALL |rand| (QREFELT $ 39))
                                (SEQ
                                 (LETT |sr| (SPADCALL |rand| (QREFELT $ 40)))
                                 (EXIT
                                  (COND
                                   ((EQUAL |sr| '|%e|)
                                    (PROGN
                                     (LETT #6#
                                           (|FCTOOL;fortPre1|
                                            (SPADCALL
                                             (SPADCALL '|exp| (QREFELT $ 45))
                                             (LIST |exponent|) (QREFELT $ 48))
                                            $))
                                     (GO #8=#:G1162)))
                                   ((SPADCALL |exponent| (QREFELT $ 64))
                                    (COND
                                     ((EQL (SPADCALL |exponent| (QREFELT $ 65))
                                           2)
                                      (PROGN
                                       (LETT #6#
                                             (SPADCALL
                                              (SPADCALL '* (QREFELT $ 45))
                                              (LIST |rand| |rand|)
                                              (QREFELT $ 48)))
                                       (GO #8#))))))))))
                              (COND
                               ((SPADCALL |exponent| (QREFELT $ 64))
                                (COND
                                 ((< (ABS (SPADCALL |exponent| (QREFELT $ 65)))
                                     32768)
                                  (EXIT
                                   (SPADCALL (QREFELT $ 68)
                                             (LIST (|FCTOOL;fortPre1| |rand| $)
                                                   |exponent|)
                                             (QREFELT $ 48)))))))
                              (EXIT
                               (SPADCALL (QREFELT $ 68)
                                         (LIST (|FCTOOL;fortPre1| |rand| $)
                                               (|FCTOOL;fortPre1| |exponent|
                                                $))
                                         (QREFELT $ 48)))))
                            ((EQUAL |sy| 'ROOT)
                             (COND
                              ((EQL (LENGTH |args|) 1)
                               (|FCTOOL;fortPreRoot|
                                (SPADCALL (SPADCALL '|sqrt| (QREFELT $ 45))
                                          (LIST (|SPADfirst| |args|))
                                          (QREFELT $ 48))
                                $))
                              (#7#
                               (SPADCALL (QREFELT $ 68)
                                         (LIST
                                          (|FCTOOL;fortPreRoot|
                                           (|SPADfirst| |args|) $)
                                          (SPADCALL
                                           (SPADCALL '/ (QREFELT $ 45))
                                           (LIST (SPADCALL 1 (QREFELT $ 66))
                                                 (|FCTOOL;fortPreRoot|
                                                  (SPADCALL |args| 2
                                                            (QREFELT $ 35))
                                                  $))
                                           (QREFELT $ 48)))
                                         (QREFELT $ 48)))))
                            (#7#
                             (SEQ
                              (COND
                               ((OR (EQUAL |sy| 'OVER) (EQUAL |sy| 'SLASH))
                                (SEQ (LETT |sy| '/)
                                     (EXIT
                                      (LETT |op|
                                            (SPADCALL |sy| (QREFELT $ 45)))))))
                              (EXIT
                               (COND
                                ((SPADCALL |sy| (QREFELT $ 67) (QREFELT $ 57))
                                 (|FCTOOL;exp2FortSpecial| |sy| |args|
                                  (LENGTH |args|) $))
                                (#7#
                                 (SEQ
                                  (COND
                                   ((SPADCALL |sy| (LIST '* '+ '-)
                                              (QREFELT $ 57))
                                    (COND
                                     ((> (LENGTH |args|) 2)
                                      (EXIT
                                       (SEQ
                                        (LETT |binaryExpr|
                                              (|FCTOOL;fortPre1|
                                               (SPADCALL |op|
                                                         (LIST
                                                          (SPADCALL |args| 1
                                                                    (QREFELT $
                                                                             35))
                                                          (SPADCALL |args| 2
                                                                    (QREFELT $
                                                                             35)))
                                                         (QREFELT $ 48))
                                               $))
                                        (SEQ (LETT |e1| NIL)
                                             (LETT #4# (CDR (CDR |args|))) G190
                                             (COND
                                              ((OR (ATOM #4#)
                                                   (PROGN
                                                    (LETT |e1| (CAR #4#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT |binaryExpr|
                                                     (SPADCALL |op|
                                                               (LIST
                                                                |binaryExpr|
                                                                (|FCTOOL;fortPre1|
                                                                 |e1| $))
                                                               (QREFELT $
                                                                        48)))))
                                             (LETT #4# (CDR #4#)) (GO G190)
                                             G191 (EXIT NIL))
                                        (EXIT |binaryExpr|)))))))
                                  (EXIT
                                   (COND
                                    ((EQL (LENGTH |args|) 2)
                                     (SEQ
                                      (LETT |im_op|
                                            (SPADCALL 'CMPLX (QREFELT $ 45)))
                                      (LETT |arg1|
                                            (SPADCALL |args| 1 (QREFELT $ 35)))
                                      (LETT |arg2|
                                            (SPADCALL |args| 2 (QREFELT $ 35)))
                                      (EXIT
                                       (COND
                                        ((|FCTOOL;is_imaginary| |arg2| $)
                                         (COND
                                          ((EQUAL |sy| '*)
                                           (SPADCALL |im_op|
                                                     (LIST
                                                      (|FCTOOL;fortPre1|
                                                       (SPADCALL 0
                                                                 (QREFELT $
                                                                          66))
                                                       $)
                                                      (|FCTOOL;fortPre1| |arg1|
                                                       $))
                                                     (QREFELT $ 48)))
                                          ((EQUAL |sy| '+)
                                           (SPADCALL |im_op|
                                                     (LIST
                                                      (|FCTOOL;fortPre1| |arg1|
                                                       $)
                                                      (|FCTOOL;fortPre1|
                                                       (SPADCALL 1
                                                                 (QREFELT $
                                                                          66))
                                                       $))
                                                     (QREFELT $ 48)))
                                          (#7#
                                           (|FCTOOL;mkFortFn| |op| |args| 2
                                            $))))
                                        ((NULL (EQUAL |sy| '+))
                                         (|FCTOOL;mkFortFn| |op| |args| 2 $))
                                        ('T
                                         (COND
                                          ((|FCTOOL;same_subtree2| '* |arg2| $)
                                           (SEQ
                                            (LETT |n_args|
                                                  (SPADCALL |arg2|
                                                            (QREFELT $ 33)))
                                            (EXIT
                                             (COND
                                              ((|FCTOOL;is_imaginary|
                                                (SPADCALL |n_args| 2
                                                          (QREFELT $ 35))
                                                $)
                                               (SPADCALL |im_op|
                                                         (LIST
                                                          (|FCTOOL;fortPre1|
                                                           |arg1| $)
                                                          (|FCTOOL;fortPre1|
                                                           (SPADCALL |n_args| 1
                                                                     (QREFELT $
                                                                              35))
                                                           $))
                                                         (QREFELT $ 48)))
                                              ((|FCTOOL;is_imaginary|
                                                (SPADCALL |n_args| 1
                                                          (QREFELT $ 35))
                                                $)
                                               (SPADCALL |im_op|
                                                         (LIST
                                                          (|FCTOOL;fortPre1|
                                                           |arg1| $)
                                                          (|FCTOOL;fortPre1|
                                                           (SPADCALL |n_args| 2
                                                                     (QREFELT $
                                                                              35))
                                                           $))
                                                         (QREFELT $ 48)))
                                              (#7#
                                               (|FCTOOL;mkFortFn| |op| |args| 2
                                                $))))))
                                          ((|FCTOOL;same_subtree2| '* |arg1| $)
                                           (SEQ
                                            (LETT |n_args|
                                                  (SPADCALL |arg1|
                                                            (QREFELT $ 33)))
                                            (EXIT
                                             (COND
                                              ((|FCTOOL;is_imaginary|
                                                (SPADCALL |n_args| 2
                                                          (QREFELT $ 35))
                                                $)
                                               (SPADCALL |im_op|
                                                         (LIST
                                                          (|FCTOOL;fortPre1|
                                                           |arg2| $)
                                                          (|FCTOOL;fortPre1|
                                                           (SPADCALL |n_args| 1
                                                                     (QREFELT $
                                                                              35))
                                                           $))
                                                         (QREFELT $ 48)))
                                              ((|FCTOOL;is_imaginary|
                                                (SPADCALL |n_args| 1
                                                          (QREFELT $ 35))
                                                $)
                                               (SPADCALL |im_op|
                                                         (LIST
                                                          (|FCTOOL;fortPre1|
                                                           |arg2| $)
                                                          (|FCTOOL;fortPre1|
                                                           (SPADCALL |n_args| 2
                                                                     (QREFELT $
                                                                              35))
                                                           $))
                                                         (QREFELT $ 48)))
                                              (#7#
                                               (|FCTOOL;mkFortFn| |op| |args| 2
                                                $))))))
                                          (#7#
                                           (|FCTOOL;mkFortFn| |op| |args| 2
                                            $))))))))
                                    (#7#
                                     (|FCTOOL;mkFortFn| |op| |args|
                                      (LENGTH |args|) $))))))))))))))
                    (#7#
                     (|FCTOOL;mkFortFn| |op| |args| (LENGTH |args|) $))))))))
          #8# (EXIT #6#)))) 

(SDEFUN |FCTOOL;fortPre|
        ((|l| (|List| (|OutputForm|))) ($ (|List| (|OutputForm|))))
        (SPROG
         ((|res| (|List| (|OutputForm|))) (|new| (|OutputForm|))
          (#1=#:G1170 NIL) (|e| NIL))
         (SEQ (SETELT $ 50 NIL)
              (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |new| (|FCTOOL;fortPre1| |e| $))
                        (EXIT (|FCTOOL;push_expr_stack| |new| $)))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |res| (NREVERSE (QREFELT $ 50))) (SETELT $ 50 NIL)
              (EXIT |res|)))) 

(SDEFUN |FCTOOL;get_fort_indent;I;39| (($ (|Integer|))) (QREFELT $ 80)) 

(SDEFUN |FCTOOL;indentFortLevel;IV;40| ((|i| (|Integer|)) ($ (|Void|)))
        (SEQ
         (SETF |$maximumFortranExpressionLength|
                 (- |$maximumFortranExpressionLength| (* 2 |i|)))
         (EXIT (SETELT $ 80 (+ (QREFELT $ 80) (* 2 |i|)))))) 

(SDEFUN |FCTOOL;make_spaces| ((|x| (|Integer|)) ($ (|String|)))
        (SPROG ((#1=#:G1175 NIL))
               (|make_full_CVEC2|
                (PROG1 (LETT #1# |x|)
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#))
                (SPADCALL (QREFELT $ 83))))) 

(SDEFUN |FCTOOL;fortran2Lines1|
        ((|f| (|List| (|String|))) (|res| (|List| (|String|)))
         ($ (|List| (|String|))))
        (SPROG
         ((|line| #1=(|String|)) (|ll| (|Integer|)) (|ff| (|String|))
          (|spaceLeft| (|Integer|)) (#2=#:G1189 NIL) (|sff| (|Integer|))
          (|contPref| (|String|)) (|normPref| #1#))
         (SEQ (LETT |normPref| (|FCTOOL;make_spaces| (QREFELT $ 80) $))
              (LETT |contPref|
                    (STRCONC "     &"
                             (|FCTOOL;make_spaces| (- (QREFELT $ 80) 6) $)))
              (LETT |ll| (QREFELT $ 80))
              (SEQ G190 (COND ((NULL (NULL (NULL |f|))) (GO G191)))
                   (SEQ (LETT |line| |normPref|) (LETT |ff| (|SPADfirst| |f|))
                        (SEQ
                         (EXIT
                          (SEQ G190 NIL
                               (SEQ
                                (EXIT
                                 (COND
                                  ((<= (+ |ll| (LETT |sff| (QCSIZE |ff|)))
                                       |$fortLength|)
                                   (SEQ (LETT |ll| (+ |ll| |sff|))
                                        (LETT |line| (STRCONC |line| |ff|))
                                        (LETT |f| (CDR |f|))
                                        (EXIT
                                         (COND
                                          ((NULL |f|)
                                           (PROGN
                                            (LETT #2# 1)
                                            (GO #3=#:G1184)))
                                          ('T
                                           (LETT |ff| (|SPADfirst| |f|)))))))
                                  ('T
                                   (SEQ
                                    (LETT |spaceLeft| (- |$fortLength| |ll|))
                                    (EXIT
                                     (COND
                                      ((< |spaceLeft| 0)
                                       (|error| "too deep indentation"))
                                      ('T
                                       (SEQ
                                        (LETT |line|
                                              (STRCONC |line|
                                                       (SPADCALL |ff|
                                                                 (SPADCALL 1
                                                                           |spaceLeft|
                                                                           (QREFELT
                                                                            $
                                                                            84))
                                                                 (QREFELT $
                                                                          79))))
                                        (LETT |ff|
                                              (SPADCALL |ff|
                                                        (SPADCALL
                                                         (+ |spaceLeft| 1)
                                                         (QREFELT $ 78))
                                                        (QREFELT $ 79)))
                                        (LETT |res| (CONS |line| |res|))
                                        (LETT |ll| (QREFELT $ 80))
                                        (EXIT
                                         (LETT |line| |contPref|)))))))))))
                               NIL (GO G190) G191 (EXIT NIL)))
                         #3# (EXIT #2#))
                        (EXIT
                         (COND
                          ((> |ll| (QREFELT $ 80))
                           (LETT |res| (CONS |line| |res|))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FCTOOL;fort_clean_lines;2L;43|
        ((|l| (|List| (|String|))) ($ (|List| (|String|))))
        (SPROG
         ((|nl| (|List| (|String|))) (|res| (|List| (|String|)))
          (|el| (|String|)))
         (SEQ (LETT |nl| NIL) (LETT |res| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |l|))) (GO G191)))
                   (SEQ
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((NULL |l|) NIL)
                                  ('T
                                   (SPADCALL (LETT |el| (|SPADfirst| |l|)) "%l"
                                             (QREFELT $ 85)))))
                           (GO G191)))
                         (SEQ (LETT |nl| (CONS |el| |nl|))
                              (EXIT (LETT |l| (CDR |l|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (COND ((NULL (NULL |l|)) (LETT |l| (CDR |l|))))
                    (LETT |res|
                          (|FCTOOL;fortran2Lines1| (NREVERSE |nl|) |res| $))
                    (EXIT (LETT |nl| NIL)))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |res|))))) 

(SDEFUN |FCTOOL;do_with_error_env2;BML;44|
        ((|int_to_floats?| (|Boolean|)) (|f| (|Mapping| (|List| (|String|))))
         ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL |int_to_floats?|
                         (CONS #'|FCTOOL;do_with_error_env2;BML;44!0|
                               (VECTOR $ |f|))
                         (QREFELT $ 88)))) 

(SDEFUN |FCTOOL;do_with_error_env2;BML;44!0| (($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |f|) (QREFELT $ 86)))))) 

(SDEFUN |FCTOOL;do_with_error_env3;BML;45|
        ((|int_to_floats?| (|Boolean|)) (|f| (|Mapping| (|List| (|String|))))
         ($ (|List| (|String|))))
        (SPROG ((|save_fortInts2Floats| (|Boolean|)))
               (SEQ (LETT |save_fortInts2Floats| |$fortInts2Floats|)
                    (EXIT
                     (|finally|
                      (SEQ (SETF |$fortInts2Floats| |int_to_floats?|)
                           (EXIT (SPADCALL |f|)))
                      (SETF |$fortInts2Floats| |save_fortInts2Floats|)))))) 

(SDEFUN |FCTOOL;do_with_error_env1;ML;46|
        ((|f| (|Mapping| (|List| (|String|)))) ($ (|List| (|String|))))
        (SPADCALL (SPADCALL |f|) (QREFELT $ 86))) 

(SDEFUN |FCTOOL;beenHere|
        ((|e| (|OutputForm|))
         (|n|
          (|Record| (|:| |count| (|SingleInteger|)) (|:| |name| (|Symbol|))
                    (|:| |location| #1=(|List| (|OutputForm|)))))
         (|fortCsList| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (SPROG
         ((|csl1| (|List| (|OutputForm|))) (|loc| #1#) (|var| (|OutputForm|))
          (|nn| (|SingleInteger|)))
         (SEQ (QSETVELT |n| 0 (LETT |nn| (|add_SI| (QVELT |n| 0) 1)))
              (EXIT
               (COND
                ((|eql_SI| |nn| 2)
                 (SEQ (QSETVELT |n| 1 (SPADCALL (QREFELT $ 16)))
                      (LETT |var| (SPADCALL (QVELT |n| 1) (QREFELT $ 63)))
                      (LETT |loc| (QVELT |n| 2))
                      (COND
                       ((NULL (NULL |loc|))
                        (SEQ
                         (LETT |csl1|
                               (CONS
                                (SPADCALL (SPADCALL '= (QREFELT $ 63))
                                          (LIST |var| |e|) (QREFELT $ 91))
                                (CDR |fortCsList|)))
                         (SPADCALL |fortCsList| (COPY-TREE |csl1|)
                                   (QREFELT $ 92))
                         (EXIT (SPADCALL |loc| |var| (QREFELT $ 93))))))
                      (EXIT |var|)))
                ('T (SPADCALL (QVELT |n| 1) (QREFELT $ 63)))))))) 

(SDEFUN |FCTOOL;exp2FortOptimizeCS1|
        ((|e| (|OutputForm|)) (|fortCsHash| (|None|))
         (|fortCsList| (|List| (|OutputForm|))) (|e0| (|List| (|OutputForm|)))
         ($ (|OutputForm|)))
        (SPROG
         ((|n1|
           (|Record| (|:| |count| (|SingleInteger|)) (|:| |name| (|Symbol|))
                     (|:| |location| (|List| (|OutputForm|)))))
          (|n| (|None|)) (|sy| (|Symbol|)) (|f| (|List| (|OutputForm|)))
          (#1=#:G1233 NIL) (|args| (|List| (|OutputForm|)))
          (|op| (|OutputForm|)))
         (SEQ
          (COND ((SPADCALL |e| (QREFELT $ 30)) |e|)
                (#2='T
                 (SEQ
                  (EXIT
                   (SEQ (LETT |op| (SPADCALL |e| (QREFELT $ 31)))
                        (LETT |args| (SPADCALL |e| (QREFELT $ 33)))
                        (COND
                         ((SPADCALL |op| (QREFELT $ 30))
                          (COND ((NULL |args|) (EXIT |e|)))))
                        (COND
                         ((SPADCALL |op| '- (QREFELT $ 94))
                          (COND
                           ((EQL (LENGTH |args|) 1)
                            (COND
                             ((SPADCALL (|SPADfirst| |args|) (QREFELT $ 30))
                              (EXIT |e|)))))))
                        (COND
                         ((SPADCALL |op| (QREFELT $ 39))
                          (COND
                           ((NULL
                             (SPADCALL
                              (LETT |sy| (SPADCALL |op| (QREFELT $ 40)))
                              (LIST 'ROW 'AGGLST) (QREFELT $ 57)))
                            (SEQ (LETT |n| (HGET |fortCsHash| |e|))
                                 (EXIT
                                  (COND
                                   ((NOT (NULL |n|))
                                    (PROGN
                                     (LETT #1#
                                           (|FCTOOL;beenHere| |e| |n|
                                            |fortCsList| $))
                                     (GO #3=#:G1230))))))))))
                        (LETT |f| |e|)
                        (SEQ G190 (COND ((NULL (NULL (NULL |f|))) (GO G191)))
                             (SEQ
                              (SPADCALL |f|
                                        (|FCTOOL;exp2FortOptimizeCS1|
                                         (|SPADfirst| |f|) |fortCsHash|
                                         |fortCsList| |f| $)
                                        (QREFELT $ 93))
                              (LETT |f| (CDR |f|))
                              (EXIT (COND ((ATOM |f|) (LETT |f| NIL)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (COND
                         ((SPADCALL |op| (QREFELT $ 39))
                          (COND
                           ((SPADCALL
                             (LETT |sy| (SPADCALL |op| (QREFELT $ 40)))
                             (LIST 'ROW 'AGGLST) (QREFELT $ 57))
                            (EXIT |e|)))))
                        (LETT |n| (HGET |fortCsHash| |e|))
                        (EXIT
                         (COND
                          ((NULL |n|)
                           (SEQ (LETT |n1| (VECTOR 1 '|dummy| |e0|))
                                (HPUT |fortCsHash| |e| |n1|) (EXIT |e|)))
                          (#2# (|FCTOOL;beenHere| |e| |n| |fortCsList| $))))))
                  #3# (EXIT #1#))))))) 

(SDEFUN |FCTOOL;exp2FortOptimizeCS|
        ((|e| (|OutputForm|)) ($ (|List| (|OutputForm|))))
        (SPROG ((|fortCsHash| (|None|)) (|fortCsList| (|List| (|OutputForm|))))
               (SEQ (LETT |fortCsList| (LIST (SPADCALL (QREFELT $ 95))))
                    (LETT |fortCsHash| (MAKE_HASHTABLE 'EQ))
                    (|FCTOOL;exp2FortOptimizeCS1| |e| |fortCsHash| |fortCsList|
                     NIL $)
                    (EXIT (NREVERSE (CONS |e| (CDR |fortCsList|))))))) 

(SDEFUN |FCTOOL;exp2FortOptimizeArray|
        ((|e| (|OutputForm|)) (|exprStack| (|List| (|OutputForm|)))
         (|fort_name| (|Symbol|)) ($ #1=(|OutputForm|)))
        (SPROG
         ((|res1| (|OutputForm|)) (|var| (|OutputForm|))
          (|op2| #2=(|OutputForm|)) (|arg11| #3=(|OutputForm|))
          (|args1| #4=(|List| (|OutputForm|))) (|op1| #2#) (|arg1| #3#)
          (|sy| (|Symbol|)) (|rargs| (|List| #1#)) (#5=#:G1253 NIL) (|arg| NIL)
          (#6=#:G1252 NIL) (|rop| #1#) (|args| #4#) (|op| #2#))
         (SEQ
          (COND ((SPADCALL |e| (QREFELT $ 30)) |e|)
                (#7='T
                 (SEQ (LETT |op| (SPADCALL |e| (QREFELT $ 31)))
                      (LETT |args| (SPADCALL |e| (QREFELT $ 33)))
                      (LETT |rop|
                            (|FCTOOL;exp2FortOptimizeArray| |op| (QREFELT $ 50)
                             |fort_name| $))
                      (LETT |rargs|
                            (PROGN
                             (LETT #6# NIL)
                             (SEQ (LETT |arg| NIL) (LETT #5# |args|) G190
                                  (COND
                                   ((OR (ATOM #5#)
                                        (PROGN (LETT |arg| (CAR #5#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #6#
                                          (CONS
                                           (|FCTOOL;exp2FortOptimizeArray|
                                            |arg| (QREFELT $ 50) |fort_name| $)
                                           #6#))))
                                  (LETT #5# (CDR #5#)) (GO G190) G191
                                  (EXIT (NREVERSE #6#)))))
                      (EXIT
                       (COND
                        ((SPADCALL |op| (QREFELT $ 39))
                         (SEQ (LETT |sy| (SPADCALL |op| (QREFELT $ 40)))
                              (EXIT
                               (COND
                                ((SPADCALL |sy| (LIST 'BRACE 'BRACKET)
                                           (QREFELT $ 57))
                                 (COND
                                  ((OR
                                    (OR
                                     (SPADCALL (LENGTH |args|) 1
                                               (QREFELT $ 96))
                                     (SPADCALL
                                      (LETT |arg1| (|SPADfirst| |args|))
                                      (QREFELT $ 30)))
                                    (NULL
                                     (SPADCALL
                                      (LETT |op1|
                                            (SPADCALL |arg1| (QREFELT $ 31)))
                                      'AGGLST (QREFELT $ 94))))
                                   (SPADCALL (QREFELT $ 95)))
                                  ('T
                                   (SEQ
                                    (LETT |args1|
                                          (SPADCALL |arg1| (QREFELT $ 33)))
                                    (COND
                                     ((> (LENGTH |args1|) 0)
                                      (COND
                                       ((NULL
                                         (SPADCALL
                                          (LETT |arg11| (|SPADfirst| |args1|))
                                          (QREFELT $ 30)))
                                        (COND
                                         ((SPADCALL
                                           (LETT |op2|
                                                 (SPADCALL |arg11|
                                                           (QREFELT $ 31)))
                                           (QREFELT $ 39))
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL |op2| (QREFELT $ 40))
                                             (LIST 'BRACE 'BRACKET)
                                             (QREFELT $ 57))
                                            (EXIT
                                             (PROGN
                                              (|FCTOOL;fortError1| |e| $)
                                              (|userError|
                                               "Did not really exit.")))))))))))
                                    (LETT |var|
                                          (SPADCALL |fort_name|
                                                    (QREFELT $ 63)))
                                    (LETT |res1|
                                          (SPADCALL |op| (CONS |var| |rargs|)
                                                    (QREFELT $ 91)))
                                    (SPADCALL (QREFELT $ 50)
                                              (CONS |res1|
                                                    (CDR (QREFELT $ 50)))
                                              (QREFELT $ 92))
                                    (EXIT |var|)))))
                                ((EQUAL |sy| 'MATRIX)
                                 (SEQ
                                  (LETT |var|
                                        (SPADCALL |fort_name| (QREFELT $ 63)))
                                  (LETT |res1|
                                        (SPADCALL |op| (CONS |var| |rargs|)
                                                  (QREFELT $ 91)))
                                  (SPADCALL (QREFELT $ 50)
                                            (CONS |res1| (CDR (QREFELT $ 50)))
                                            (QREFELT $ 92))
                                  (EXIT |var|)))
                                (#7#
                                 (SPADCALL |rop| |rargs| (QREFELT $ 91)))))))
                        (#7# (SPADCALL |rop| |rargs| (QREFELT $ 91))))))))))) 

(SDEFUN |FCTOOL;exp2FortOptimize|
        ((|e| (|OutputForm|)) (|fort_name| (|Symbol|))
         ($ (|List| (|OutputForm|))))
        (SPROG ((|e2| #1=(|OutputForm|)) (#2=#:G1262 NIL) (|e1| #1#))
               (SEQ (SETELT $ 50 (LIST (SPADCALL (QREFELT $ 95))))
                    (EXIT
                     (COND ((SPADCALL |e| (QREFELT $ 30)) (LIST |e|))
                           ((EQL |$fortranOptimizationLevel| 0)
                            (SEQ
                             (LETT |e1|
                                   (|FCTOOL;exp2FortOptimizeArray| |e|
                                    (QREFELT $ 50) |fort_name| $))
                             (EXIT
                              (NREVERSE (CONS |e1| (CDR (QREFELT $ 50)))))))
                           ('T
                            (SEQ (LETT |e| (|minimalise| |e|))
                                 (SEQ
                                  (LETT #2#
                                        (|FCTOOL;exp2FortOptimizeCS| |e| $))
                                  G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |e1| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |e2|
                                         (|FCTOOL;exp2FortOptimizeArray| |e1|
                                          (QREFELT $ 50) |fort_name| $))
                                   (EXIT
                                    (SPADCALL (QREFELT $ 50)
                                              (CONS |e2| (CDR (QREFELT $ 50)))
                                              (QREFELT $ 92))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT NIL))
                                 (EXIT (NREVERSE (CDR (QREFELT $ 50))))))))))) 

(SDEFUN |FCTOOL;expression2Fortran1;MOfBL;52|
        ((|nf| (|Mapping| (|Symbol|))) (|of| (|OutputForm|))
         (|int_to_floats?| (|Boolean|)) ($ (|List| (|String|))))
        (SPROG
         ((|ol| (|List| (|OutputForm|)))
          (|save_tmp_var_index| (|SingleInteger|))
          (|save_fortInts2Floats| (|Boolean|)))
         (SEQ (LETT |save_fortInts2Floats| |$fortInts2Floats|)
              (LETT |save_tmp_var_index| (QREFELT $ 6))
              (EXIT
               (|finally|
                (SEQ (SETF |$fortInts2Floats| NIL) (SETELT $ 6 0)
                     (LETT |ol|
                           (|FCTOOL;exp2FortOptimize|
                            (SPADCALL |of| (QREFELT $ 97)) (SPADCALL |nf|) $))
                     (EXIT
                      (|FCTOOL;fortranCleanUp|
                       (|FCTOOL;exp2Fort1|
                        (|FCTOOL;segment| (|FCTOOL;fortPre| |ol| $) $) $)
                       $)))
                (SEQ (SETF |$fortInts2Floats| |save_fortInts2Floats|)
                     (EXIT (SETELT $ 6 |save_tmp_var_index|)))))))) 

(SDEFUN |FCTOOL;statement2Fortran;OfL;53|
        ((|of| (|OutputForm|)) ($ (|List| (|String|))))
        (SPADCALL (LIST #'|FCTOOL;statement2Fortran;OfL;53!0|) |of| NIL
                  (QREFELT $ 99))) 

(SDEFUN |FCTOOL;statement2Fortran;OfL;53!0| (($$ NIL)) 'DUMMY) 

(SDEFUN |FCTOOL;expression2Fortran;OfL;54|
        ((|of| (|OutputForm|)) ($ (|List| (|String|))))
        (SPADCALL (ELT $ 16) |of| NIL (QREFELT $ 99))) 

(SDEFUN |FCTOOL;changeExprLength;IV;55| ((|i| (|Integer|)) ($ (|Void|)))
        (SPROG ((|nl| (|Integer|)))
               (SEQ (LETT |nl| (+ |$maximumFortranExpressionLength| 1))
                    (EXIT (SETF |$maximumFortranExpressionLength| |nl|))))) 

(SDEFUN |FCTOOL;getStatement;OfBL;56|
        ((|of| (|OutputForm|)) (|int_to_floats?| (|Boolean|))
         ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL |int_to_floats?|
                         (CONS #'|FCTOOL;getStatement;OfBL;56!0|
                               (VECTOR $ |of|))
                         (QREFELT $ 89)))) 

(SDEFUN |FCTOOL;getStatement;OfBL;56!0| (($$ NIL))
        (PROG (|of| $)
          (LETT |of| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |of| (QREFELT $ 100)))))) 

(SDEFUN |FCTOOL;displayLines;LV;57| ((|ls| (|List| (|String|))) ($ (|Void|)))
        (SPROG ((#1=#:G1279 NIL) (|l| NIL))
               (SEQ (LETT |l| NIL) (LETT #1# |ls|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |l| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ (|sayString| |l| (|get_fortran_stream|))
                         (EXIT (TERPRI (|get_fortran_stream|))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |FCTOOL;dispStatement;OfV;58| ((|of| (|OutputForm|)) ($ (|Void|)))
        (SPROG ((|l| (|List| (|String|))))
               (SEQ (LETT |l| (SPADCALL |of| NIL (QREFELT $ 103)))
                    (EXIT (SPADCALL |l| (QREFELT $ 104)))))) 

(SDEFUN |FCTOOL;fortFormatHead1|
        ((|name| (|Symbol|)) (|asp| (|List| (|String|)))
         (|args| (|List| (|Symbol|))) ($ (|List| (|String|))))
        (SPROG
         ((|of| (|OutputForm|)) (#1=#:G1287 NIL) (|arg| NIL) (#2=#:G1286 NIL))
         (SEQ
          (LETT |of|
                (SPADCALL (SPADCALL |name| (QREFELT $ 63))
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |arg| NIL) (LETT #1# |args|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |arg| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |arg| (QREFELT $ 63))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 48)))
          (EXIT
           (SPADCALL |asp| (SPADCALL |of| (QREFELT $ 100)) (QREFELT $ 25)))))) 

(SDEFUN |FCTOOL;fortFormatHead;SULV;60|
        ((|name| (|Symbol|))
         (|returnType|
          (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void")))
         (|args| (|List| (|Symbol|))) ($ (|Void|)))
        (SPROG
         ((|lines| (|List| (|String|))) (|l| (|Integer|))
          (|asp| (|List| (|String|))) (|s| (|String|)) (#1=#:G1288 NIL))
         (SEQ
          (COND
           ((QEQCAR |returnType| 1)
            (SEQ (LETT |asp| (LIST "SUBROUTINE "))
                 (EXIT (SPADCALL (LETT |l| -11) (QREFELT $ 102)))))
           ('T
            (SEQ
             (LETT |s|
                   (SPADCALL
                    (SPADCALL
                     (PROG2 (LETT #1# |returnType|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0) (|FortranScalarType|)
                                       (|Union|
                                        (|:| |fst| (|FortranScalarType|))
                                        (|:| |void| "void"))
                                       #1#))
                     (QREFELT $ 106))
                    (QREFELT $ 17)))
             (LETT |asp| (LIST |s| " FUNCTION "))
             (EXIT
              (SPADCALL (LETT |l| (- -10 (QCSIZE |s|))) (QREFELT $ 102))))))
          (LETT |lines|
                (SPADCALL
                 (CONS #'|FCTOOL;fortFormatHead;SULV;60!0|
                       (VECTOR $ |args| |asp| |name|))
                 (QREFELT $ 90)))
          (SPADCALL |lines| (QREFELT $ 104))
          (EXIT (SPADCALL (- |l|) (QREFELT $ 102)))))) 

(SDEFUN |FCTOOL;fortFormatHead;SULV;60!0| (($$ NIL))
        (PROG (|name| |asp| |args| $)
          (LETT |name| (QREFELT $$ 3))
          (LETT |asp| (QREFELT $$ 2))
          (LETT |args| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|FCTOOL;fortFormatHead1| |name| |asp| |args| $))))) 

(SDEFUN |FCTOOL;addCommas| ((|l| (|List| (|String|))) ($ (|List| (|String|))))
        (SPROG ((|r| (|List| (|String|))) (#1=#:G1302 NIL) (|e| NIL))
               (SEQ
                (COND ((NULL |l|) |l|)
                      ('T
                       (SEQ (LETT |r| (LIST (|SPADfirst| |l|)))
                            (SEQ (LETT |e| NIL) (LETT #1# (CDR |l|)) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |e| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT (LETT |r| (CONS |e| (CONS "," |r|)))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT (NREVERSE |r|)))))))) 

(SDEFUN |FCTOOL;nameLen| ((|n| (|List| (|String|))) ($ (|Integer|)))
        (SPROG
         ((#1=#:G1304 NIL) (#2=#:G1303 #3=(|Integer|)) (#4=#:G1305 #3#)
          (#5=#:G1307 NIL) (|u| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |u| NIL) (LETT #5# |n|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |u| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (+ 1 (QCSIZE |u|)))
                   (COND (#1# (LETT #2# (+ #2# #4#)))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T 0)))))) 

(SDEFUN |FCTOOL;fortFormatTypeLines;SLV;63|
        ((|typeName| (|String|)) (|l| (|List| (|String|))) ($ (|Void|)))
        (SPROG ((|l1| (|List| (|String|))))
               (SEQ
                (LETT |l1|
                      (CONS |typeName| (CONS " " (|FCTOOL;addCommas| |l| $))))
                (EXIT
                 (SPADCALL (SPADCALL |l1| (QREFELT $ 86)) (QREFELT $ 104)))))) 

(SDEFUN |FCTOOL;fortFormatTypes1|
        ((|typeName| (|String|)) (|names| (|List| (|String|))) ($ (|Void|)))
        (SPROG ((|n| (|List| (|String|))) (|ln| (|Integer|)) (|l| (|Integer|)))
               (SEQ
                (LETT |l|
                      (- (- |$maximumFortranExpressionLength| 1)
                         (QCSIZE |typeName|)))
                (SEQ G190
                     (COND
                      ((NULL (> (|FCTOOL;nameLen| |names| $) |l|)) (GO G191)))
                     (SEQ (LETT |n| NIL) (LETT |ln| 0)
                          (SEQ G190
                               (COND
                                ((NULL
                                  (<
                                   (LETT |ln|
                                         (+
                                          (+ |ln|
                                             (QCSIZE (|SPADfirst| |names|)))
                                          1))
                                   |l|))
                                 (GO G191)))
                               (SEQ (LETT |n| (CONS (|SPADfirst| |names|) |n|))
                                    (EXIT (LETT |names| (CDR |names|))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (EXIT (SPADCALL |typeName| |n| (QREFELT $ 109))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |typeName| |names| (QREFELT $ 109)))))) 

(SDEFUN |FCTOOL;par2string2| ((|u| (|List| (|OutputForm|))) ($ (|String|)))
        (SPROG
         ((|l| (|List| (|String|))) (|ll| (|List| (|List| (|String|))))
          (#1=#:G1323 NIL) (|v| NIL) (#2=#:G1322 NIL))
         (SEQ
          (LETT |ll|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL) (LETT #1# (CDR |u|)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (CONS "," (SPADCALL |v| (QREFELT $ 100)))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |l|
                (SPADCALL (CDR (SPADCALL |ll| (QREFELT $ 110))) ")"
                          (QREFELT $ 111)))
          (EXIT
           (SPADCALL
            (SPADCALL (LIST (STRINGIMAGE (|SPADfirst| |u|)) "(") |l|
                      (QREFELT $ 25))
            (QREFELT $ 61)))))) 

(SDEFUN |FCTOOL;unravel_par| ((|u| (|OutputForm|)) ($ (|OutputForm|)))
        (SEQ
         (COND ((SPADCALL |u| (QREFELT $ 30)) |u|)
               ('T
                (SEQ (LETT |u| (|SPADfirst| (SPADCALL |u| (QREFELT $ 33))))
                     (EXIT (CDR |u|))))))) 

(SDEFUN |FCTOOL;par2string| ((|u| (|OutputForm|)) ($ (|String|)))
        (COND ((SPADCALL |u| (QREFELT $ 30)) (STRINGIMAGE |u|))
              ('T (|FCTOOL;par2string2| (|FCTOOL;unravel_par| |u| $) $)))) 

(SDEFUN |FCTOOL;mkParameterList|
        ((|l| (|List| (|OutputForm|))) ($ (|List| (|String|))))
        (SPROG ((#1=#:G1333 NIL) (|u| NIL) (#2=#:G1332 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |u| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (|FCTOOL;par2string| |u| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FCTOOL;mkParameterList2|
        ((|l| (|List| (|List| (|OutputForm|)))) ($ (|List| (|String|))))
        (SPROG ((#1=#:G1338 NIL) (|u| NIL) (#2=#:G1337 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |u| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (|FCTOOL;par2string2| |u| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FCTOOL;mkCharName| ((|v| (|Integer|)) ($ (|String|)))
        (STRCONC "CHARACTER*(" (STRCONC (STRINGIMAGE |v|) ")"))) 

(SDEFUN |FCTOOL;insertEntry|
        ((|m| (|Integer|)) (|n| (|OutputForm|))
         (|Tabl| (|AssociationList| (|Integer|) (|List| (|OutputForm|))))
         ($ (|Void|)))
        (SPROG ((|u| (|Union| (|List| (|OutputForm|)) "failed")))
               (SEQ (LETT |u| (SPADCALL |m| |Tabl| (QREFELT $ 114)))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 1)
                       (SPADCALL |Tabl| |m| (LIST |n|) (QREFELT $ 115)))
                      ('T
                       (SPADCALL |Tabl| |m| (CONS |n| (QCDR |u|))
                                 (QREFELT $ 115)))))))) 

(SDEFUN |FCTOOL;fortFormatCharacterTypes|
        ((|names| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPROG
         ((#1=#:G1356 NIL) (|u2| NIL)
          (|genuineArrays| (|List| (|List| (|OutputForm|))))
          (|u1| (|List| (|OutputForm|))) (#2=#:G1355 NIL) (|u| NIL)
          (|sortedByLength|
           (|AssociationList| (|Integer|) (|List| (|OutputForm|)))))
         (SEQ (LETT |sortedByLength| (SPADCALL (QREFELT $ 116)))
              (LETT |genuineArrays| NIL)
              (SEQ (LETT |u| NIL) (LETT #2# |names|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |u| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |u| (QREFELT $ 30))
                       (|FCTOOL;insertEntry| 0 |u| |sortedByLength| $))
                      ('T
                       (SEQ (LETT |u1| |u|)
                            (EXIT
                             (COND
                              ((EQL (LENGTH |u1|) 2)
                               (|FCTOOL;insertEntry|
                                (SPADCALL |u1| (QREFELT $ 43))
                                (|SPADfirst| |u1|) |sortedByLength| $))
                              ('T
                               (LETT |genuineArrays|
                                     (CONS |u1| |genuineArrays|))))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |u2| NIL)
                   (LETT #1# (SPADCALL |sortedByLength| (QREFELT $ 119))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |u2| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (|FCTOOL;fortFormatTypes1|
                      (|FCTOOL;mkCharName| (QCAR |u2|) $)
                      (|FCTOOL;mkParameterList| (QCDR |u2|) $) $)))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((NULL (NULL |genuineArrays|))
                 (|FCTOOL;fortFormatTypes1| "CHARACTER"
                  (|FCTOOL;mkParameterList2| |genuineArrays| $) $))))))) 

(SDEFUN |FCTOOL;fort_format_types1|
        ((|typeName| (|String|)) (|names| (|List| (|OutputForm|)))
         ($ (|Void|)))
        (SPROG ((#1=#:G1361 NIL) (|u| NIL) (#2=#:G1360 NIL))
               (SEQ
                (COND
                 ((EQUAL |typeName| "CHARACTER")
                  (|FCTOOL;fortFormatCharacterTypes|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |u| NIL) (LETT #1# |names|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2# (CONS (|FCTOOL;unravel_par| |u| $) #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   $))
                 ('T
                  (|FCTOOL;fortFormatTypes1| |typeName|
                   (|FCTOOL;mkParameterList| |names| $) $)))))) 

(SDEFUN |FCTOOL;fort_format_types;SLV;74|
        ((|typeName| (|String|)) (|names| (|List| (|OutputForm|)))
         ($ (|Void|)))
        (SPROG ((|save_fortranSegment| (|Boolean|)))
               (SEQ
                (COND ((NULL |names|) (SPADCALL (QREFELT $ 120)))
                      ('T
                       (SEQ (LETT |save_fortranSegment| |$fortranSegment|)
                            (EXIT
                             (|finally|
                              (SEQ (SETF |$fortranSegment| NIL)
                                   (EXIT
                                    (SPADCALL NIL
                                              (CONS
                                               #'|FCTOOL;fort_format_types;SLV;74!0|
                                               (VECTOR |names| $ |typeName|))
                                              (QREFELT $ 88))))
                              (SETF |$fortranSegment|
                                      |save_fortranSegment|))))))))) 

(SDEFUN |FCTOOL;fort_format_types;SLV;74!0| (($$ NIL))
        (PROG (|typeName| $ |names|)
          (LETT |typeName| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |names| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SEQ
             (|FCTOOL;fort_format_types1| (SPADCALL |typeName| (QREFELT $ 17))
              |names| $)
             (EXIT (LIST ""))))))) 

(DECLAIM (NOTINLINE |FortranCodeTools;|)) 

(DEFUN |FortranCodeTools| ()
  (SPROG NIL
         (PROG (#1=#:G1371)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FortranCodeTools|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FortranCodeTools|
                             (LIST (CONS NIL (CONS 1 (|FortranCodeTools;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|FortranCodeTools|)))))))))) 

(DEFUN |FortranCodeTools;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FortranCodeTools|))
          (LETT $ (GETREFV 122))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FortranCodeTools| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 0)
          (QSETREFV $ 18 (LIST #1="-" "~"))
          (QSETREFV $ 19 '(700 50))
          (QSETREFV $ 20
                    (LIST "|" "**" "/" ".LT." ".GT." ".EQ." ".LE." ".GE."
                          ".AND." ".OR."))
          (QSETREFV $ 21 (LIST 0 900 800 400 400 400 400 400 800 70 90))
          (QSETREFV $ 22 (LIST #1# "+" "*" "," " " "ROW" ""))
          (QSETREFV $ 23 (LIST 700 700 800 110 0 0 0))
          (QSETREFV $ 26
                    (SPADCALL (QREFELT $ 20) (QREFELT $ 22) (QREFELT $ 25)))
          (QSETREFV $ 46 (SPADCALL '= (QREFELT $ 45)))
          (QSETREFV $ 50 NIL)
          (QSETREFV $ 51 NIL)
          (QSETREFV $ 58
                    (LIST (VECTOR '|abs| 'ABS 'DABS)
                          (VECTOR '|acos| 'ACOS 'DACOS)
                          (VECTOR '|asin| 'ASIN 'DASIN)
                          (VECTOR '|atan| 'ATAN 'DATAN)
                          (VECTOR '|cos| 'COS 'DCOS)
                          (VECTOR '|cosh| 'COSH 'DCOSH)
                          (VECTOR '|cot| 'COTAN 'DCOTAN)
                          (VECTOR '|erf| 'ERF 'DERF) (VECTOR '|exp| 'EXP 'DEXP)
                          (VECTOR '|log| 'LOG 'DLOG)
                          (VECTOR '|log10| 'LOG10 'DLOG10)
                          (VECTOR '|sin| 'SIN 'DSIN)
                          (VECTOR '|sinh| 'SINH 'DSINH)
                          (VECTOR '|sqrt| 'SQRT 'DSQRT)
                          (VECTOR '|tan| 'TAN 'DTAN)
                          (VECTOR '|tanh| 'TANH 'DTANH)))
          (QSETREFV $ 59
                    (LIST (CONS '< '.LT.) (CONS '> '.GT.) (CONS '<= '.LE.)
                          (CONS '>= '.GE.) (CONS 'EQ '.EQ.)
                          (CONS '|and| '.AND.) (CONS '|or| '.OR.)
                          (CONS '~ '.NOT.)))
          (QSETREFV $ 67
                    '(BRACKET BRACE SUB AGGLST SUPERSUB MATRIX SEGMENT
                      ALTSUPERSUB PAREN CONCAT CONCATB QUOTE STRING SIGMA STEP
                      IN SIGMA2 INTSIGN PI PI2))
          (QSETREFV $ 68 (SPADCALL '** (QREFELT $ 45)))
          (QSETREFV $ 80 6)
          $))) 

(MAKEPROP '|FortranCodeTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|tmp_var_index| (|String|) (|Symbol|)
              (0 . |coerce|) (|FortranScalarType|) (5 . |coerce|)
              (|FortranType|) (10 . |coerce|) (|TheSymbolTable|)
              (15 . |declare!|) |FCTOOL;newFortranTempVar;S;1|
              |FCTOOL;checkType;2S;2| '|unaryOps| '|unaryPrecs| '|binaryOps|
              '|binaryPrecs| '|naryOps| '|naryPrecs| (|List| 7) (21 . |append|)
              '|nonUnaryOps| (|Boolean|) (|OutputForm|) (|OutputFormTools|)
              (27 . |atom?|) (32 . |operator|) (|List| 28) (37 . |arguments|)
              (|Integer|) (42 . |elt|) (48 . |position|) (|List| 34)
              (54 . |elt|) (60 . |symbol?|) (65 . |symbol|)
              (|NonNegativeInteger|) (70 . ~=) (76 . |second|) (81 . |member?|)
              (87 . |outputForm|) '|ass_form| (|List| $) (92 . |elt|)
              (98 . |append|) '|exprStack| '|used_intrinsics| (|Void|)
              |FCTOOL;clear_used_intrinsics;V;24| (104 . |string|)
              |FCTOOL;get_used_intrinsics;L;25| (|List| 8) (109 . |member?|)
              '|fort_intrinsics| '|fort_ops| (115 . |string|) (120 . |concat|)
              (125 . |message|) (130 . |coerce|) (135 . |integer?|)
              (140 . |integer|) (145 . |outputForm|) '|specialOps| '|pow_form|
              (|Character|) (150 . |elt|) (156 . |char|) (161 . |remove|)
              (167 . |position|) (173 . ~=) (179 . |setelt!|) (186 . |string?|)
              (|UniversalSegment| 34) (191 . SEGMENT) (196 . |elt|)
              '|fort_indent| |FCTOOL;get_fort_indent;I;39|
              |FCTOOL;indentFortLevel;IV;40| (202 . |space|) (206 . SEGMENT)
              (212 . ~=) |FCTOOL;fort_clean_lines;2L;43| (|Mapping| 24)
              |FCTOOL;do_with_error_env3;BML;45|
              |FCTOOL;do_with_error_env2;BML;44|
              |FCTOOL;do_with_error_env1;ML;46| (218 . |construct|)
              (224 . |setrest!|) (230 . |setfirst!|) (236 . |is_symbol?|)
              (242 . |empty|) (246 . ~=) (252 . |precondition|) (|Mapping| 8)
              |FCTOOL;expression2Fortran1;MOfBL;52|
              |FCTOOL;statement2Fortran;OfL;53|
              |FCTOOL;expression2Fortran;OfL;54|
              |FCTOOL;changeExprLength;IV;55| |FCTOOL;getStatement;OfBL;56|
              |FCTOOL;displayLines;LV;57| |FCTOOL;dispStatement;OfV;58|
              (257 . |coerce|) (|Union| (|:| |fst| 10) (|:| |void| '#1="void"))
              |FCTOOL;fortFormatHead;SULV;60|
              |FCTOOL;fortFormatTypeLines;SLV;63| (262 . |concat|)
              (267 . |concat|) (|Union| 32 '"failed") (|AssociationList| 34 32)
              (273 . |search|) (279 . |setelt!|) (286 . |empty|)
              (|Record| (|:| |key| 34) (|:| |entry| 32)) (|List| 117)
              (290 . |entries|) (295 . |void|)
              |FCTOOL;fort_format_types;SLV;74|)
           '#(|statement2Fortran| 299 |newFortranTempVar| 304 |indentFortLevel|
              308 |get_used_intrinsics| 313 |get_fort_indent| 317
              |getStatement| 321 |fort_format_types| 327 |fort_clean_lines| 333
              |fortFormatTypeLines| 338 |fortFormatHead| 344
              |expression2Fortran1| 351 |expression2Fortran| 358
              |do_with_error_env3| 363 |do_with_error_env2| 369
              |do_with_error_env1| 375 |displayLines| 380 |dispStatement| 385
              |clear_used_intrinsics| 390 |checkType| 394 |changeExprLength|
              399)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|fort_clean_lines|
                                 ((|List| (|String|)) (|List| (|String|))))
                                T)
                              '((|do_with_error_env3|
                                 ((|List| (|String|)) (|Boolean|)
                                  (|Mapping| (|List| (|String|)))))
                                T)
                              '((|do_with_error_env2|
                                 ((|List| (|String|)) (|Boolean|)
                                  (|Mapping| (|List| (|String|)))))
                                T)
                              '((|do_with_error_env1|
                                 ((|List| (|String|))
                                  (|Mapping| (|List| (|String|)))))
                                T)
                              '((|expression2Fortran1|
                                 ((|List| (|String|)) (|Mapping| (|Symbol|))
                                  (|OutputForm|) (|Boolean|)))
                                T)
                              '((|statement2Fortran|
                                 ((|List| (|String|)) (|OutputForm|)))
                                T)
                              '((|expression2Fortran|
                                 ((|List| (|String|)) (|OutputForm|)))
                                T)
                              '((|getStatement|
                                 ((|List| (|String|)) (|OutputForm|)
                                  (|Boolean|)))
                                T)
                              '((|changeExprLength| ((|Void|) (|Integer|))) T)
                              '((|displayLines| ((|Void|) (|List| (|String|))))
                                T)
                              '((|dispStatement| ((|Void|) (|OutputForm|))) T)
                              '((|fortFormatHead|
                                 ((|Void|) (|Symbol|)
                                  (|Union| (|:| |fst| (|FortranScalarType|))
                                           (|:| |void| #1#))
                                  (|List| (|Symbol|))))
                                T)
                              '((|fortFormatTypeLines|
                                 ((|Void|) (|String|) (|List| (|String|))))
                                T)
                              '((|fort_format_types|
                                 ((|Void|) (|String|) (|List| (|OutputForm|))))
                                T)
                              '((|indentFortLevel| ((|Void|) (|Integer|))) T)
                              '((|checkType| ((|String|) (|String|))) T)
                              '((|newFortranTempVar| ((|Symbol|))) T)
                              '((|clear_used_intrinsics| ((|Void|))) T)
                              '((|get_used_intrinsics| ((|List| (|String|))))
                                T)
                              '((|get_fort_indent| ((|Integer|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 121
                                            '(1 8 0 7 9 1 10 0 8 11 1 12 0 10
                                              13 2 14 12 8 12 15 2 24 0 0 0 25
                                              1 29 27 28 30 1 29 28 28 31 1 29
                                              32 28 33 2 32 28 0 34 35 2 24 34
                                              7 0 36 2 37 34 0 34 38 1 29 27 28
                                              39 1 29 8 28 40 2 41 27 0 0 42 1
                                              32 28 0 43 2 24 27 7 0 44 1 28 0
                                              8 45 2 28 0 0 47 48 2 32 0 0 0 49
                                              1 8 7 0 54 2 56 27 8 0 57 1 29 7
                                              28 60 1 7 0 47 61 1 28 0 7 62 1 8
                                              28 0 63 1 29 27 28 64 1 29 34 28
                                              65 1 28 0 34 66 2 7 69 0 34 70 1
                                              69 0 7 71 2 7 0 69 0 72 2 7 34 69
                                              0 73 2 8 27 0 0 74 3 7 69 0 34 69
                                              75 1 29 27 28 76 1 77 0 34 78 2 7
                                              0 0 77 79 0 69 0 83 2 77 0 34 34
                                              84 2 7 27 0 0 85 2 29 28 28 32 91
                                              2 32 0 0 0 92 2 32 28 0 28 93 2
                                              29 27 28 8 94 0 28 0 95 2 34 27 0
                                              0 96 1 29 28 28 97 1 10 7 0 106 1
                                              24 0 47 110 2 24 0 0 7 111 2 113
                                              112 34 0 114 3 113 32 0 34 32 115
                                              0 113 0 116 1 113 118 0 119 0 52
                                              0 120 1 0 24 28 100 0 0 8 16 1 0
                                              52 34 82 0 0 24 55 0 0 34 81 2 0
                                              24 28 27 103 2 0 52 7 32 121 1 0
                                              24 24 86 2 0 52 7 24 109 3 0 52 8
                                              107 56 108 3 0 24 98 28 27 99 1 0
                                              24 28 101 2 0 24 27 87 88 2 0 24
                                              27 87 89 1 0 24 87 90 1 0 52 24
                                              104 1 0 52 28 105 0 0 52 53 1 0 7
                                              7 17 1 0 52 34 102)))))
           '|lookupComplete|)) 

(MAKEPROP '|FortranCodeTools| 'NILADIC T) 
