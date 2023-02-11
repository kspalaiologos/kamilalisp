
(SDEFUN |FMTMJAX;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (|coerceRe2E| |x|
                      (ELT
                       (|Record| (|:| |prolog| (|OutputBox|))
                                 (|:| |fmt| (|OutputBox|))
                                 (|:| |epilog| (|OutputBox|)))
                       0))) 

(SDEFUN |FMTMJAX;defaultPrologue;SOb;2|
        ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL "\\[" (QREFELT $ 10))) 

(SDEFUN |FMTMJAX;defaultEpilogue;SOb;3|
        ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL "\\]" (QREFELT $ 10))) 

(SDEFUN |FMTMJAX;parenthesize;2S2Ob;4|
        ((|left| #1=(|String|)) (|right| #1#) (|b| (|OutputBox|))
         ($ (|OutputBox|)))
        (SEQ
         (COND
          ((EQUAL |left| "(")
           (COND
            ((EQUAL |right| ")")
             (SEQ (LETT |left| "\\left(") (EXIT (LETT |right| "\\right)")))))))
         (EXIT
          (SPADCALL
           (LIST (SPADCALL |left| (QREFELT $ 10)) |b|
                 (SPADCALL |right| (QREFELT $ 10)))
           (QREFELT $ 14))))) 

(SDEFUN |FMTMJAX;texEscapeString| ((|s| (|String|)) ($ (|String|)))
        (SPROG
         ((|str| (|String|)) (|esc| (|String|)) (|c| (|Character|))
          (|n| (|Integer|)) (|p| (|Integer|)) (|cc| (|CharacterClass|)))
         (SEQ (LETT |cc| (SPADCALL " \\{}$^_%~#&" (QREFELT $ 17)))
              (LETT |p| (SPADCALL |cc| |s| 1 (QREFELT $ 19)))
              (EXIT
               (COND ((ZEROP |p|) |s|)
                     ('T
                      (SEQ (LETT |str| "") (LETT |n| 1)
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (>
                                    (LETT |p|
                                          (SPADCALL |cc| |s| |n|
                                                    (QREFELT $ 19)))
                                    0))
                                  (GO G191)))
                                (SEQ
                                 (LETT |str|
                                       (STRCONC |str|
                                                (SPADCALL |s|
                                                          (SPADCALL |n|
                                                                    (- |p| 1)
                                                                    (QREFELT $
                                                                             21))
                                                          (QREFELT $ 22))))
                                 (LETT |n| (+ |p| 1))
                                 (LETT |c| (SPADCALL |s| |p| (QREFELT $ 24)))
                                 (LETT |esc|
                                       (SPADCALL "\\"
                                                 (SPADCALL |s| |p|
                                                           (QREFELT $ 24))
                                                 (QREFELT $ 25)))
                                 (COND
                                  ((|eql_SI| |c| (|STR_to_CHAR| "^"))
                                   (LETT |esc| "{\\wedge}")))
                                 (COND
                                  ((|eql_SI| |c| (|STR_to_CHAR| "\\"))
                                   (LETT |esc| "{\\backslash}")))
                                 (COND
                                  ((|eql_SI| |c| (|STR_to_CHAR| "~"))
                                   (LETT |esc| "{\\tilde{}}")))
                                 (EXIT (LETT |str| (STRCONC |str| |esc|))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (STRCONC |str|
                                     (SPADCALL |s|
                                               (SPADCALL |n| (QCSIZE |s|)
                                                         (QREFELT $ 21))
                                               (QREFELT $ 22))))))))))) 

(SDEFUN |FMTMJAX;braceBox| ((|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPADCALL "{" "}" |b| (QREFELT $ 15))) 

(SDEFUN |FMTMJAX;tex1|
        ((|cmd| (|String|)) (|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPADCALL
         (LIST (SPADCALL |cmd| (QREFELT $ 10)) (|FMTMJAX;braceBox| |b| $))
         (QREFELT $ 14))) 

(SDEFUN |FMTMJAX;tex1Escape|
        ((|cmd| (|String|)) (|s| (|String|)) ($ (|OutputBox|)))
        (|FMTMJAX;tex1| |cmd|
         (SPADCALL (|FMTMJAX;texEscapeString| |s| $) (QREFELT $ 10)) $)) 

(SDEFUN |FMTMJAX;tex2|
        ((|cmd| (|String|)) (|b1| (|OutputBox|)) (|b2| (|OutputBox|))
         ($ (|OutputBox|)))
        (SPADCALL
         (LIST (|FMTMJAX;tex1| |cmd| |b1| $) (|FMTMJAX;braceBox| |b2| $))
         (QREFELT $ 14))) 

(SDEFUN |FMTMJAX;formatFloat;SOb;10| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (SPADCALL (|STR_to_CHAR| "_") |s| (QREFELT $ 27))
                  (QREFELT $ 10))) 

(SDEFUN |FMTMJAX;duplicateBackslashes| ((|s| (|String|)) ($ (|String|)))
        (SPROG
         ((|p| (|Integer|)) (|t| (|String|)) (|q| (|Integer|))
          (|m| (|Integer|)))
         (SEQ (LETT |m| 1)
              (LETT |p| (SPADCALL (|STR_to_CHAR| "\\") |s| (QREFELT $ 29)))
              (EXIT
               (COND ((< |p| |m|) |s|)
                     ('T
                      (SEQ
                       (LETT |t|
                             (SPADCALL |s| (SPADCALL 1 |p| (QREFELT $ 21))
                                       (QREFELT $ 22)))
                       (SEQ G190
                            (COND
                             ((NULL
                               (>=
                                (LETT |q|
                                      (SPADCALL (|STR_to_CHAR| "\\") |s|
                                                (+ |p| 1) (QREFELT $ 30)))
                                |m|))
                              (GO G191)))
                            (SEQ
                             (LETT |t|
                                   (STRCONC |t|
                                            (SPADCALL |s|
                                                      (SPADCALL |p| |q|
                                                                (QREFELT $ 21))
                                                      (QREFELT $ 22))))
                             (EXIT (LETT |p| |q|)))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (STRCONC |t|
                                 (SPADCALL |s|
                                           (SPADCALL |p| (QCSIZE |s|)
                                                     (QREFELT $ 21))
                                           (QREFELT $ 22))))))))))) 

(SDEFUN |FMTMJAX;formatString;SOb;12| ((|s| (|String|)) ($ (|OutputBox|)))
        (|FMTMJAX;tex1| "\\texttt"
         (SPADCALL (|FMTMJAX;duplicateBackslashes| |s| $) (QREFELT $ 10)) $)) 

(SDEFUN |FMTMJAX;formatSymbol;SOb;13| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (|FMTMJAX;texEscapeString| |s| $) (QREFELT $ 10))) 

(SDEFUN |FMTMJAX;formatFunctionSymbol;SOb;14|
        ((|s| (|String|)) ($ (|OutputBox|)))
        (SPROG ((|b| (|OutputBox|)))
               (SEQ
                (LETT |b|
                      (SPADCALL (|FMTMJAX;texEscapeString| |s| $)
                                (QREFELT $ 10)))
                (EXIT
                 (COND ((EQL (SPADCALL |b| (QREFELT $ 34)) 1) |b|)
                       ('T (|FMTMJAX;tex1| "\\operatorname" |b| $))))))) 

(SDEFUN |FMTMJAX;integralArgument| ((|a| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|op3| (|OutputForm|)) (|op2| #1=(|OutputForm|))
          (|args| (|List| (|OutputForm|))) (|op| #1#))
         (SEQ
          (COND ((SPADCALL |a| (QREFELT $ 38)) |a|)
                (#2='T
                 (SEQ (LETT |op| (SPADCALL |a| (QREFELT $ 39)))
                      (COND
                       ((NULL (SPADCALL |op| '* (QREFELT $ 41))) (EXIT |a|)))
                      (LETT |args| (SPADCALL |a| (QREFELT $ 43)))
                      (EXIT
                       (COND ((SPADCALL (LENGTH |args|) 2 (QREFELT $ 44)) |a|)
                             (#2#
                              (SEQ
                               (LETT |op2|
                                     (SPADCALL
                                      (SPADCALL |args| 2 (QREFELT $ 45))
                                      (QREFELT $ 39)))
                               (COND
                                ((NULL (SPADCALL |op2| 'CONCAT (QREFELT $ 41)))
                                 (EXIT |a|)))
                               (LETT |op3|
                                     (|SPADfirst|
                                      (SPADCALL
                                       (SPADCALL |args| 2 (QREFELT $ 45))
                                       (QREFELT $ 43))))
                               (COND
                                ((NULL (SPADCALL |op3| '|d| (QREFELT $ 41)))
                                 (EXIT |a|)))
                               (EXIT
                                (SPADCALL (SPADCALL 'INTSEP (QREFELT $ 46))
                                          (LIST
                                           (SPADCALL |args| 1 (QREFELT $ 45))
                                           (SPADCALL |args| 2 (QREFELT $ 45)))
                                          (QREFELT $ 47))))))))))))) 

(SDEFUN |FMTMJAX;integral;IM;16|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTMJAX;integral;IM;16!0| (VECTOR |p| $))))) 

(SDEFUN |FMTMJAX;integral;IM;16!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bu| NIL) (|bl| NIL) (|ba| NIL) (|a| NIL))
                   (SEQ
                    (LETT |bl|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 48)
                                     (QREFELT $ 45))
                           (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                    (LETT |bu|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 45))
                                    (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                    (LETT |a|
                          (|FMTMJAX;integralArgument|
                           (SPADCALL |args| 3 (QREFELT $ 45)) $))
                    (LETT |ba|
                          (SPADCALL |a| (SPADCALL (QREFELT $ 49))
                                    (QREFELT $ 50)))
                    (COND
                     ((NULL (SPADCALL |bl| (QREFELT $ 51)))
                      (LETT |bl| (SPADCALL "_{" "}" |bl| (QREFELT $ 15)))))
                    (COND
                     ((NULL (SPADCALL |bu| (QREFELT $ 51)))
                      (LETT |bu| (SPADCALL "^{" "}" |bu| (QREFELT $ 15)))))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                               (SPADCALL
                                (LIST (SPADCALL "\\int" (QREFELT $ 10)) |bl|
                                      |bu| (|FMTMJAX;braceBox| |ba| $))
                                (QREFELT $ 14))
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;operatorWithLimits|
        ((|s| (|String|)) (|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTMJAX;operatorWithLimits!0| (VECTOR |s| |p| $))))) 

(SDEFUN |FMTMJAX;operatorWithLimits!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p| |s|)
          (LETT $ (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT |s| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bu| NIL) (|bl| NIL) (|ba| NIL))
                   (SEQ
                    (LETT |bl|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 48)
                                     (QREFELT $ 45))
                           (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                    (LETT |bu| (SPADCALL (QREFELT $ 56)))
                    (LETT |ba|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 45))
                                    (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                    (COND
                     ((SPADCALL (SPADCALL |args| (QREFELT $ 57)) 3
                                (QREFELT $ 58))
                      (SEQ (LETT |bu| |ba|)
                           (EXIT
                            (LETT |ba|
                                  (SPADCALL (SPADCALL |args| 3 (QREFELT $ 45))
                                            (SPADCALL (QREFELT $ 49))
                                            (QREFELT $ 50)))))))
                    (COND
                     ((NULL (SPADCALL |bl| (QREFELT $ 51)))
                      (LETT |bl| (SPADCALL "_{" "}" |bl| (QREFELT $ 15)))))
                    (COND
                     ((NULL (SPADCALL |bu| (QREFELT $ 51)))
                      (LETT |bu| (SPADCALL "^{" "}" |bu| (QREFELT $ 15)))))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                               (SPADCALL
                                (LIST (SPADCALL |s| (QREFELT $ 10)) |bl| |bu|
                                      (|FMTMJAX;braceBox| |ba| $))
                                (QREFELT $ 14))
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;sum;IM;18|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTMJAX;operatorWithLimits| "\\sum" |p| $)) 

(SDEFUN |FMTMJAX;product;IM;19|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTMJAX;operatorWithLimits| "\\prod" |p| $)) 

(SDEFUN |FMTMJAX;theMap;ILOb;20|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG
         ((|p2| (|Integer|)) (|p1| (|Integer|)) (|s| (|String|))
          (|b| (|OutputBox|)) (|a| (|OutputForm|)))
         (SEQ (LETT |a| (|SPADfirst| |args|))
              (LETT |s|
                    (SEQ
                     (COND
                      ((SPADCALL |a| (QREFELT $ 38))
                       (COND
                        ((NULL (SPADCALL |a| (QREFELT $ 61)))
                         (COND
                          ((NULL (SPADCALL |a| (QREFELT $ 62)))
                           (EXIT ";?;")))))))
                     (LETT |b|
                           (SPADCALL |a| (SPADCALL (QREFELT $ 49))
                                     (QREFELT $ 50)))
                     (EXIT (|SPADfirst| (SPADCALL |b| (QREFELT $ 64))))))
              (LETT |p1| (SPADCALL (|STR_to_CHAR| ";") |s| (QREFELT $ 29)))
              (LETT |p2|
                    (SPADCALL (|STR_to_CHAR| ";") |s| (+ |p1| 1)
                              (QREFELT $ 30)))
              (EXIT
               (SPADCALL "\\operatorname{theMap}(" ")"
                         (SPADCALL
                          (SPADCALL |s|
                                    (SPADCALL (+ |p1| 1) (- |p2| 1)
                                              (QREFELT $ 21))
                                    (QREFELT $ 22))
                          (QREFELT $ 10))
                         (QREFELT $ 15)))))) 

(SDEFUN |FMTMJAX;overbar;I2M;21|
        ((|p| #1=(|Integer|))
         (|hh| (|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTMJAX;overbar;I2M;21!0| (VECTOR |hh| $ |p|)))) 

(SDEFUN |FMTMJAX;overbar;I2M;21!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |hh|)
          (LETT |p| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                      (|FMTMJAX;tex1| "\\overline" (SPADCALL |p| |args| |hh|)
                       $)
                      (QREFELT $ 53)))))) 

(SDEFUN |FMTMJAX;box;2M;22|
        ((|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTMJAX;box;2M;22!0| (VECTOR |hh| $)))) 

(SDEFUN |FMTMJAX;box;2M;22!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |hh|)
          (LETT $ (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|FMTMJAX;tex1| "\\boxed"
             (SPADCALL |prec|
                       (LIST
                        (SPADCALL |args| (|spadConstant| $ 48) (QREFELT $ 45)))
                       |hh|)
             $))))) 

(SDEFUN |FMTMJAX;nthRoot;I3M;23|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTMJAX;nthRoot;I3M;23!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMTMJAX;nthRoot;I3M;23!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |h1| |h2|)
          (LETT |p| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |h1| (QREFELT $$ 1))
          (LETT |h2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bn| NIL) (|bx| NIL))
                   (SEQ
                    (LETT |bx|
                          (SPADCALL |p|
                                    (LIST
                                     (SPADCALL |args| (|spadConstant| $ 48)
                                               (QREFELT $ 45)))
                                    (SPADCALL "{" "}" |h1| (QREFELT $ 68))))
                    (LETT |bn| (SPADCALL (QREFELT $ 56)))
                    (COND
                     ((SPADCALL (SPADCALL |args| (QREFELT $ 57))
                                (|spadConstant| $ 48) (QREFELT $ 69))
                      (LETT |bn|
                            (SPADCALL |p|
                                      (LIST (SPADCALL |args| 2 (QREFELT $ 45)))
                                      (SPADCALL "[" "]" |h2|
                                                (QREFELT $ 68))))))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                               (SPADCALL
                                (LIST (SPADCALL "\\sqrt" (QREFELT $ 10)) |bn|
                                      |bx|)
                                (QREFELT $ 14))
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;emptyArgs?| ((|args| (|List| (|OutputForm|))) ($ (|Boolean|)))
        (COND ((NULL |args|) 'T)
              ((SPADCALL (|SPADfirst| |args|) (QREFELT $ 61))
               (EQUAL (SPADCALL (|SPADfirst| |args|) (QREFELT $ 71)) " "))
              ('T NIL))) 

(SDEFUN |FMTMJAX;scripts;IM;25|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTMJAX;scripts;IM;25!0| (VECTOR |p| $))))) 

(SDEFUN |FMTMJAX;scripts;IM;25!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|s| NIL) (|b| NIL) (|pre| NIL) (|bx| NIL) (|i| NIL) (|v| NIL))
             (SEQ
              (LETT |b|
                    (|FMTMJAX;braceBox|
                     (SPADCALL (SPADCALL |args| (QREFELT $ 72)) |p|
                               (QREFELT $ 50))
                     $))
              (LETT |v|
                    (SPADCALL (LIST (SPADCALL "\\vphantom" (QREFELT $ 10)) |b|)
                              (QREFELT $ 14)))
              (SEQ (LETT |i| (|spadConstant| $ 74)) G190
                   (COND ((|greater_SI| |i| 4) (GO G191)))
                   (SEQ (LETT |args| (SPADCALL |args| (QREFELT $ 76)))
                        (EXIT
                         (COND
                          ((NULL (|FMTMJAX;emptyArgs?| |args| $))
                           (SEQ
                            (LETT |bx|
                                  (|FMTMJAX;braceBox|
                                   (SPADCALL (SPADCALL |args| (QREFELT $ 72))
                                             (SPADCALL (QREFELT $ 49))
                                             (QREFELT $ 50))
                                   $))
                            (LETT |pre|
                                  (COND
                                   ((OR
                                     (SPADCALL |i| (|spadConstant| $ 75)
                                               (QREFELT $ 58))
                                     (SPADCALL |i| 4 (QREFELT $ 58)))
                                    (SPADCALL "_" (QREFELT $ 10)))
                                   ('T (SPADCALL "^" (QREFELT $ 10)))))
                            (EXIT
                             (COND
                              ((SPADCALL |i| 3 (QREFELT $ 77))
                               (SEQ
                                (LETT |b|
                                      (SPADCALL (LIST |b| |pre| |bx|)
                                                (QREFELT $ 14)))
                                (EXIT
                                 (LETT |s| (SPADCALL "" (QREFELT $ 10))))))
                              ('T
                               (SEQ
                                (LETT |b|
                                      (SPADCALL (LIST |pre| |bx| |b|)
                                                (QREFELT $ 14)))
                                (EXIT (LETT |s| |v|)))))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                         (SPADCALL (LIST |s| |b|) (QREFELT $ 14))
                         (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;subscript;IM;26|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTMJAX;subscript;IM;26!0| (VECTOR |p| $))))) 

(SDEFUN |FMTMJAX;subscript;IM;26!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (|FMTMJAX;braceBox|
                           (SPADCALL
                            (SPADCALL |args| (|spadConstant| $ 48)
                                      (QREFELT $ 45))
                            (SPADCALL |p| (|spadConstant| $ 48) (QREFELT $ 79))
                            (QREFELT $ 50))
                           $))
                    (LETT |b2|
                          (|FMTMJAX;braceBox|
                           (SPADCALL (SPADCALL |args| 2 (QREFELT $ 45))
                                     (SPADCALL (QREFELT $ 49)) (QREFELT $ 50))
                           $))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                               (SPADCALL
                                (LIST |b1| (SPADCALL "_" (QREFELT $ 10)) |b2|)
                                (QREFELT $ 14))
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;altsupersub;IM;27|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTMJAX;altsupersub;IM;27!0| (VECTOR |p| $))))) 

(SDEFUN |FMTMJAX;altsupersub;IM;27!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|bx| NIL) (|tu| NIL) (|tl| NIL) (#1=#:G843 NIL) (|l| NIL)
              (#2=#:G844 NIL) (|u| NIL) (|bu| NIL) (|lu| NIL) (|bl| NIL)
              (|ll| NIL) (|b| NIL) (#3=#:G842 NIL) (|a| NIL) (|i| NIL)
              (|ba| NIL))
             (SEQ
              (LETT |ba|
                    (SPADCALL (SPADCALL |args| (QREFELT $ 72)) |p|
                              (QREFELT $ 50)))
              (EXIT
               (COND
                ((SPADCALL (LETT |args| (SPADCALL |args| (QREFELT $ 76)))
                           (QREFELT $ 81))
                 (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52)) |ba|
                           (QREFELT $ 53)))
                ('T
                 (SEQ (LETT |bx| |ba|)
                      (LETT |ba| (|FMTMJAX;tex1| "\\vphantom" |ba| $))
                      (LETT |ll| (SPADCALL (QREFELT $ 83)))
                      (LETT |lu| (SPADCALL (QREFELT $ 83)))
                      (SEQ (LETT |i| (|spadConstant| $ 74)) (LETT |a| NIL)
                           (LETT #3# |args|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |b|
                                  (|FMTMJAX;braceBox|
                                   (SPADCALL |a| (SPADCALL (QREFELT $ 49))
                                             (QREFELT $ 50))
                                   $))
                            (EXIT
                             (COND
                              ((SPADCALL |i| (QREFELT $ 84))
                               (LETT |ll| (SPADCALL |b| |ll| (QREFELT $ 85))))
                              ('T
                               (LETT |lu|
                                     (SPADCALL |b| |lu| (QREFELT $ 85)))))))
                           (LETT #3#
                                 (PROG1 (CDR #3#) (LETT |i| (|inc_SI| |i|))))
                           (GO G190) G191 (EXIT NIL))
                      (COND
                       ((SPADCALL (SPADCALL |args| (QREFELT $ 57))
                                  (QREFELT $ 84))
                        (SPADCALL (SPADCALL (QREFELT $ 56)) |lu|
                                  (QREFELT $ 85))))
                      (LETT |ll| (SPADCALL |ll| (QREFELT $ 87)))
                      (LETT |bl|
                            (|FMTMJAX;tex1| "\\vphantom"
                             (SPADCALL |ll| (QREFELT $ 14)) $))
                      (LETT |lu| (SPADCALL |lu| (QREFELT $ 87)))
                      (LETT |bu|
                            (|FMTMJAX;tex1| "\\vphantom"
                             (SPADCALL |lu| (QREFELT $ 14)) $))
                      (LETT |tl|
                            (|FMTMJAX;tex1| "_"
                             (SPADCALL
                              (LIST (SPADCALL |ll| (QREFELT $ 88)) |bl|)
                              (QREFELT $ 14))
                             $))
                      (LETT |tu|
                            (|FMTMJAX;tex1| "^"
                             (SPADCALL
                              (LIST (SPADCALL |lu| (QREFELT $ 88)) |bu|)
                              (QREFELT $ 14))
                             $))
                      (LETT |bx|
                            (SPADCALL
                             (LIST (|FMTMJAX;braceBox| |bx| $) |tl| |tu|)
                             (QREFELT $ 14)))
                      (SEQ (LETT |u| NIL)
                           (LETT #2# (SPADCALL |lu| (QREFELT $ 89)))
                           (LETT |l| NIL)
                           (LETT #1# (SPADCALL |ll| (QREFELT $ 89))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |l| (CAR #1#)) NIL)
                                 (ATOM #2#) (PROGN (LETT |u| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |tl|
                                  (|FMTMJAX;tex1| "_"
                                   (SPADCALL (LIST |l| |bl|) (QREFELT $ 14))
                                   $))
                            (LETT |tu|
                                  (|FMTMJAX;tex1| "^"
                                   (SPADCALL (LIST |u| |bu|) (QREFELT $ 14))
                                   $))
                            (EXIT
                             (LETT |bx|
                                   (SPADCALL (LIST |bx| |ba| |tl| |tu|)
                                             (QREFELT $ 14)))))
                           (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52)) |bx|
                                 (QREFELT $ 53))))))))))))) 

(SDEFUN |FMTMJAX;prime;IM;28|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTMJAX;prime;IM;28!0| (VECTOR |p| $))))) 

(SDEFUN |FMTMJAX;prime;IM;28!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|b2| NIL) (|r| NIL) (#1=#:G849 NIL) (#2=#:G847 NIL) (|n| NIL)
              (|b1| NIL))
             (SEQ
              (LETT |b1|
                    (SPADCALL
                     (SPADCALL |args| (|spadConstant| $ 48) (QREFELT $ 45))
                     (SPADCALL |p| (|spadConstant| $ 48) (QREFELT $ 79))
                     (QREFELT $ 50)))
              (LETT |n|
                    (SPADCALL (SPADCALL |args| 2 (QREFELT $ 45))
                              (QREFELT $ 91)))
              (EXIT
               (COND
                ((SPADCALL |n| (|spadConstant| $ 92) (QREFELT $ 52))
                 (|error| "error in PRIME expression"))
                ('T
                 (SEQ
                  (COND
                   ((SPADCALL |n| 4 (QREFELT $ 52))
                    (LETT |b2|
                          (SPADCALL
                           (SPADCALL
                            (PROG1 (LETT #2# |n|)
                              (|check_subtype2| (>= #2# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #2#))
                            (SPADCALL "'" (QREFELT $ 26)) (QREFELT $ 94))
                           (QREFELT $ 10))))
                   ('T
                    (SEQ
                     (LETT |r|
                           (SPADCALL
                            (SPADCALL
                             (PROG1 (LETT #1# |n|)
                               (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                                 '(|Integer|) #1#))
                             (QREFELT $ 97))
                            (QREFELT $ 98)))
                     (EXIT
                      (LETT |b2|
                            (SPADCALL
                             (SPADCALL (LIST "^{(" |r| ")}") (QREFELT $ 99))
                             (QREFELT $ 10)))))))
                  (EXIT
                   (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                             (SPADCALL (LIST |b1| |b2|) (QREFELT $ 14))
                             (QREFELT $ 53))))))))))))) 

(SDEFUN |FMTMJAX;power;I3M;29|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTMJAX;power;I3M;29!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMTMJAX;power;I3M;29!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |h1| |h2|)
          (LETT |p| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |h1| (QREFELT $$ 1))
          (LETT |h2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (|FMTMJAX;braceBox|
                           (SPADCALL
                            (SPADCALL |p| (|spadConstant| $ 48) (QREFELT $ 79))
                            (LIST
                             (SPADCALL |args| (|spadConstant| $ 48)
                                       (QREFELT $ 45)))
                            |h1|)
                           $))
                    (LETT |b2|
                          (|FMTMJAX;braceBox|
                           (SPADCALL (SPADCALL (QREFELT $ 49))
                                     (LIST (SPADCALL |args| 2 (QREFELT $ 45)))
                                     |h2|)
                           $))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                               (SPADCALL
                                (LIST |b1| (SPADCALL "^" (QREFELT $ 10)) |b2|)
                                (QREFELT $ 14))
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;fraction;I3M;30|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTMJAX;fraction;I3M;30!0| (VECTOR |p| |h2| |h1| $))))) 

(SDEFUN |FMTMJAX;fraction;I3M;30!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |h1| |h2| |p|)
          (LETT $ (QREFELT $$ 3))
          (LETT |h1| (QREFELT $$ 2))
          (LETT |h2| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL (SPADCALL (QREFELT $ 49))
                                    (LIST
                                     (SPADCALL |args| (|spadConstant| $ 48)
                                               (QREFELT $ 45)))
                                    |h1|))
                    (LETT |b2|
                          (SPADCALL (SPADCALL (QREFELT $ 49))
                                    (LIST (SPADCALL |args| 2 (QREFELT $ 45)))
                                    |h2|))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52))
                               (|FMTMJAX;tex2| "\\frac" |b1| |b2| $)
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;slash;I3M;31|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTMJAX;slash;I3M;31!0| (VECTOR |p| |h2| |h1| $))))) 

(SDEFUN |FMTMJAX;slash;I3M;31!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |h1| |h2| |p|)
          (LETT $ (QREFELT $$ 3))
          (LETT |h1| (QREFELT $$ 2))
          (LETT |h2| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b| NIL) (|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (|FMTMJAX;braceBox|
                           (SPADCALL (SPADCALL (QREFELT $ 49))
                                     (LIST
                                      (SPADCALL |args| (|spadConstant| $ 48)
                                                (QREFELT $ 45)))
                                     |h1|)
                           $))
                    (LETT |b2|
                          (|FMTMJAX;braceBox|
                           (SPADCALL (SPADCALL (QREFELT $ 49))
                                     (LIST (SPADCALL |args| 2 (QREFELT $ 45)))
                                     |h2|)
                           $))
                    (LETT |b|
                          (|FMTMJAX;tex1| "\\vphantom"
                           (SPADCALL (LIST |b1| |b2|) (QREFELT $ 14)) $))
                    (LETT |b|
                          (SPADCALL
                           (LIST (SPADCALL "\\left." (QREFELT $ 10)) |b1| |b|
                                 (SPADCALL "\\right/" (QREFELT $ 10)) |b2|)
                           (QREFELT $ 14)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 52)) |b|
                               (QREFELT $ 53))))))))) 

(SDEFUN |FMTMJAX;binomial;ILOb;32|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|b2| #1=(|OutputBox|)) (|b1| #1#))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| 1 (QREFELT $ 45))
                                (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 45))
                                (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                (EXIT (|FMTMJAX;tex2| "\\binom" |b1| |b2| $))))) 

(SDEFUN |FMTMJAX;zag;ILOb;33|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|b2| #1=(|OutputBox|)) (|b1| #1#))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| 1 (QREFELT $ 45))
                                (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 45))
                                (SPADCALL (QREFELT $ 49)) (QREFELT $ 50)))
                (LETT |b1| (SPADCALL "\\left." "\\right|" |b1| (QREFELT $ 15)))
                (LETT |b2| (SPADCALL "\\left|" "\\right." |b2| (QREFELT $ 15)))
                (EXIT (|FMTMJAX;tex2| "\\frac" |b1| |b2| $))))) 

(SDEFUN |FMTMJAX;environment;3S2M;34|
        ((|env| (|String|)) (|x| (|String|)) (|sep| (|String|))
         (|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTMJAX;environment;3S2M;34!0|
                      (VECTOR |h| |sep| |x| |env| $))))) 

(SDEFUN |FMTMJAX;environment;3S2M;34!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |env| |x| |sep| |h|)
          (LETT $ (QREFELT $$ 4))
          (LETT |env| (QREFELT $$ 3))
          (LETT |x| (QREFELT $$ 2))
          (LETT |sep| (QREFELT $$ 1))
          (LETT |h| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|entries| NIL) (|e| NIL) (|b| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |args| (QREFELT $ 81))
                      (SPADCALL (QREFELT $ 56)))
                     ('T
                      (SEQ
                       (LETT |b|
                             (SPADCALL
                              (SPADCALL (LIST "\\begin{" |env| "}" |x|)
                                        (QREFELT $ 99))
                              (QREFELT $ 10)))
                       (LETT |e|
                             (SPADCALL
                              (SPADCALL (LIST "\\end{" |env| "}")
                                        (QREFELT $ 99))
                              (QREFELT $ 10)))
                       (LETT |entries|
                             (SPADCALL (SPADCALL (QREFELT $ 49)) |args|
                                       (SPADCALL |sep|
                                                 (SPADCALL (QREFELT $ 49)) |h|
                                                 (QREFELT $ 106))))
                       (EXIT
                        (SPADCALL (LIST |b| |entries| |e|)
                                  (QREFELT $ 14)))))))))))) 

(SDEFUN |FMTMJAX;vconcat;2M;35|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "array" "[t]{c}" "\\\\" |h| (QREFELT $ 107))) 

(SDEFUN |FMTMJAX;pile;2M;36|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "array" "[t]{l}" "\\\\" |h| (QREFELT $ 107))) 

(SDEFUN |FMTMJAX;matrix;2SM;37|
        ((|left| #1=(|String|)) (|right| #1#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTMJAX;matrix;2SM;37!0| (VECTOR |left| $))))) 

(SDEFUN |FMTMJAX;matrix;2SM;37!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |left|)
          (LETT $ (QREFELT $$ 1))
          (LETT |left| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|matrixtype| NIL) (|h| NIL))
                   (SEQ
                    (LETT |h|
                          (SPADCALL (SPADCALL (QREFELT $ 49)) (QREFELT $ 110)))
                    (LETT |matrixtype| "bmatrix")
                    (COND
                     ((SPADCALL |left| "(" (QREFELT $ 111))
                      (LETT |matrixtype| "pmatrix")))
                    (EXIT
                     (SPADCALL (SPADCALL (QREFELT $ 49))
                               (SPADCALL |args| (QREFELT $ 76))
                               (SPADCALL |matrixtype| "" "\\\\" |h|
                                         (QREFELT $ 107)))))))))) 

(SDEFUN |FMTMJAX;setOperatorHandlers!|
        ((|oh|
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
         ($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (SPROG ((#1=#:G1270 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SPADCALL |oh| 0 "NOTHING" (SPADCALL (QREFELT $ 113))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 0 "%pi" (SPADCALL "\\pi " (QREFELT $ 116))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 0 "%e" (SPADCALL "e" (QREFELT $ 116))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 0 "%i" (SPADCALL "i" (QREFELT $ 116))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 0 "%Infinity"
                            (SPADCALL "\\infty " (QREFELT $ 116))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 0 "infinity"
                            (SPADCALL "\\infty " (QREFELT $ 116))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 0 "..." (SPADCALL "\\ldots " (QREFELT $ 116))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "cos"
                            (SPADCALL "\\cos" 900
                                      (SPADCALL #2="\\left(" #3="\\right)"
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "cot"
                            (SPADCALL "\\cot" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "csc"
                            (SPADCALL "\\csc" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "log"
                            (SPADCALL "\\log" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "sec"
                            (SPADCALL "\\sin" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "sin"
                            (SPADCALL "\\sin" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "tan"
                            (SPADCALL "\\tan" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "cosh"
                            (SPADCALL "\\cosh" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "coth"
                            (SPADCALL "\\coth" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "csch"
                            (SPADCALL "\\csch" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "sech"
                            (SPADCALL "\\sech" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "sinh"
                            (SPADCALL "\\sinh" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "tanh"
                            (SPADCALL "\\tanh" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "acos"
                            (SPADCALL "\\arccos" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "asin"
                            (SPADCALL "\\arcsin" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "atan"
                            (SPADCALL "\\arctan" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "erf"
                            (SPADCALL "\\operatorname{erf}" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 49))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 68))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "-"
                            (SPADCALL "-" 710 (SPADCALL 715 (QREFELT $ 110))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "not"
                            (SPADCALL "\\lnot " 710
                                      (SPADCALL 715 (QREFELT $ 110))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "QUOTE"
                            (SPADCALL "\\texttt{'}" 710
                                      (SPADCALL 960 (QREFELT $ 110))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "OVERBAR"
                            (SPADCALL (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 66))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "BOX"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 49))
                                       (QREFELT $ 110))
                             (QREFELT $ 67))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "Aleph"
                            (SPADCALL "\\aleph_{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "BRACE"
                            (SPADCALL "\\left\\{" "\\right\\}"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "BRACKET"
                            (SPADCALL "\\left[" "\\right]"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "PAREN"
                            (SPADCALL "\\left(" "\\right)"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "Gamma"
                            (SPADCALL "\\Gamma\\left(" "\\right)"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "ROOT"
                            (SPADCALL "\\sqrt{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "SEGMENT"
                            (SPADCALL "" "{\\operatorname{..}}"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 1 "STRING"
                            (SPADCALL "\\STRING{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 68))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "rem"
                            (SPADCALL "\\mathbin{\\operatorname{rem}}" 810
                                      (SPADCALL 811 (QREFELT $ 110))
                                      (SPADCALL 811 (QREFELT $ 110))
                                      (QREFELT $ 119))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "quo"
                            (SPADCALL "\\mathbin{\\operatorname{quo}}" 810
                                      (SPADCALL 811 (QREFELT $ 110))
                                      (SPADCALL 811 (QREFELT $ 110))
                                      (QREFELT $ 119))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "exquo"
                            (SPADCALL "\\mathbin{\\operatorname{exquo}}" 810
                                      (SPADCALL 811 (QREFELT $ 110))
                                      (SPADCALL 811 (QREFELT $ 110))
                                      (QREFELT $ 119))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "^"
                            (SPADCALL 950 (SPADCALL 960 (QREFELT $ 110))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 101))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "/"
                            (SPADCALL 910
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 102))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "OVER"
                            (SPADCALL 910
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 102))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "SLASH"
                            (SPADCALL 880 (SPADCALL 881 (QREFELT $ 110))
                                      (SPADCALL 882 (QREFELT $ 110))
                                      (QREFELT $ 103))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "ZAG" (ELT $ 105) (QREFELT $ 115))
                  (SPADCALL |oh| 2 "BINOMIAL" (ELT $ 104) (QREFELT $ 115))
                  (SPADCALL |oh| 2 "PRIME" (SPADCALL 950 (QREFELT $ 100))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "ROOT"
                            (SPADCALL 970
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 70))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "SUB" (SPADCALL 950 (QREFELT $ 80))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "SEGMENT"
                            (SPADCALL "\\mathbin{\\operatorname{..}}" 100
                                      (SPADCALL 100 (QREFELT $ 110))
                                      (SPADCALL 100 (QREFELT $ 110))
                                      (QREFELT $ 119))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "TENSOR"
                            (SPADCALL "\\otimes " 850
                                      (SPADCALL 850 (QREFELT $ 110))
                                      (SPADCALL 850 (QREFELT $ 110))
                                      (QREFELT $ 119))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "EQUATNUM"
                            (SPADCALL "\\EQUATNUM" (SPADCALL (QREFELT $ 118))
                                      (SPADCALL
                                       (SPADCALL #4="{" #5="}"
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 49))
                                                  (QREFELT $ 110))
                                                 (QREFELT $ 68))
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 49))
                                                  (QREFELT $ 110))
                                                 (QREFELT $ 68))
                                       (QREFELT $ 120))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "OVERLABEL"
                            (SPADCALL "\\OVERLABEL" (SPADCALL (QREFELT $ 118))
                                      (SPADCALL
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 49))
                                                  (QREFELT $ 110))
                                                 (QREFELT $ 68))
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 49))
                                                  (QREFELT $ 110))
                                                 (QREFELT $ 68))
                                       (QREFELT $ 120))
                                      (QREFELT $ 117))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "=="
                            (SPADCALL "==" 400 (SPADCALL 401 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "="
                            (SPADCALL "=" 400 (SPADCALL 400 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "~="
                            (SPADCALL "\\ne " 400
                                      (SPADCALL 400 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "<"
                            (SPADCALL "<" 400 (SPADCALL 400 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 ">"
                            (SPADCALL ">" 400 (SPADCALL 400 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "<="
                            (SPADCALL "\\leq " 400
                                      (SPADCALL 400 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 ">="
                            (SPADCALL "\\geq " 400
                                      (SPADCALL 400 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "and"
                            (SPADCALL "\\land " 300
                                      (SPADCALL 300 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "or"
                            (SPADCALL "\\lor " 200
                                      (SPADCALL 200 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "LET"
                            (SPADCALL ":=" 125 (SPADCALL 125 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "TAG"
                            (SPADCALL "\\to " 100
                                      (SPADCALL 100 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "+->"
                            (SPADCALL "\\mapsto " 100
                                      (SPADCALL 100 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "|"
                            (SPADCALL "\\mid " 100
                                      (SPADCALL 100 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "SIGMA" (SPADCALL 750 (QREFELT $ 59))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "PI" (SPADCALL 750 (QREFELT $ 60))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 3 "SIGMA2" (SPADCALL 750 (QREFELT $ 59))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 3 "PI2" (SPADCALL 750 (QREFELT $ 60))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 3 "INTSIGN" (SPADCALL 700 (QREFELT $ 55))
                            (QREFELT $ 115))
                  (SPADCALL |oh| 2 "INTSEP"
                            (SPADCALL "\\, " (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 119))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "+"
                            (SPADCALL "+" "-" 700
                                      (SPADCALL 700 (QREFELT $ 110))
                                      (QREFELT $ 121))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "-"
                            (SPADCALL "+" "-" 700
                                      (SPADCALL 700 (QREFELT $ 110))
                                      (QREFELT $ 121))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "*"
                            (SPADCALL "\\, " 800 (SPADCALL 800 (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "AGGLST"
                            (SPADCALL ", " (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "AGGSET"
                            (SPADCALL "; " (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "CONCAT"
                            (SPADCALL "" (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "CONCATB"
                            (SPADCALL "\\ " (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "ALTSUPERSUB" (SPADCALL 900 (QREFELT $ 90))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "SUPERSUB" (SPADCALL 900 (QREFELT $ 78))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "SC"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 49))
                                       (QREFELT $ 110))
                             (QREFELT $ 109))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "VCONCAT"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 49))
                                       (QREFELT $ 110))
                             (QREFELT $ 108))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "ROW"
                            (SPADCALL "&" (SPADCALL (QREFELT $ 118))
                                      (SPADCALL (SPADCALL (QREFELT $ 49))
                                                (QREFELT $ 110))
                                      (QREFELT $ 106))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "MATRIX" (SPADCALL "[" "]" (QREFELT $ 112))
                            (QREFELT $ 115))
                  (SPADCALL |oh| -1 "theMap" (ELT $ 65) (QREFELT $ 115))
                  (EXIT (PROGN (LETT #1# |oh|) (GO #6=#:G1269)))))
                #6# (EXIT #1#)))) 

(SDEFUN |FMTMJAX;operatorHandlers;Oh;39|
        (($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (QREFELT $ 123)) 

(DECLAIM (NOTINLINE |FormatMathJax;|)) 

(DEFUN |FormatMathJax| ()
  (SPROG NIL
         (PROG (#1=#:G1273)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FormatMathJax|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FormatMathJax|
                             (LIST (CONS NIL (CONS 1 (|FormatMathJax;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|FormatMathJax|)))))))))) 

(DEFUN |FormatMathJax;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FormatMathJax|))
          (LETT $ (GETREFV 125))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FormatMathJax| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 123
                    (|FMTMJAX;setOperatorHandlers!| (SPADCALL (QREFELT $ 122))
                     $))
          $))) 

(MAKEPROP '|FormatMathJax| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) |FMTMJAX;coerce;$Of;1|
              (|String|) (|OutputBox|) (0 . |box|)
              |FMTMJAX;defaultPrologue;SOb;2| |FMTMJAX;defaultEpilogue;SOb;3|
              (|List| $) (5 . |hconcat|) |FMTMJAX;parenthesize;2S2Ob;4|
              (|CharacterClass|) (10 . |charClass|) (|Integer|)
              (15 . |position|) (|UniversalSegment| 18) (22 . SEGMENT)
              (28 . |elt|) (|Character|) (34 . |elt|) (40 . |concat|)
              (46 . |char|) (51 . |remove|) |FMTMJAX;formatFloat;SOb;10|
              (57 . |position|) (63 . |position|) |FMTMJAX;formatString;SOb;12|
              |FMTMJAX;formatSymbol;SOb;13| (|NonNegativeInteger|)
              (70 . |width|) |FMTMJAX;formatFunctionSymbol;SOb;14| (|Boolean|)
              (|OutputFormTools|) (75 . |atom?|) (80 . |operator|) (|Symbol|)
              (85 . |is_symbol?|) (|List| 6) (91 . |arguments|) (96 . ~=)
              (102 . |elt|) (108 . |coerce|) (113 . |elt|) (119 . |One|)
              (123 . |minPrecedence|) (127 . |formatExpression|)
              (133 . |empty?|) (138 . <) (144 . |parenthesizeIf|)
              (|Mapping| 9 18 42) |FMTMJAX;integral;IM;16| (150 . |empty|)
              (154 . |#|) (159 . =) |FMTMJAX;sum;IM;18| |FMTMJAX;product;IM;19|
              (165 . |string?|) (170 . |symbol?|) (|List| 8) (175 . |lines|)
              |FMTMJAX;theMap;ILOb;20| |FMTMJAX;overbar;I2M;21|
              |FMTMJAX;box;2M;22| (180 . |bracket|) (187 . >)
              |FMTMJAX;nthRoot;I3M;23| (193 . |string|) (198 . |first|)
              (|SingleInteger|) (203 . |One|) (207 . |One|) (211 . |rest|)
              (216 . <) |FMTMJAX;scripts;IM;25| (222 . +)
              |FMTMJAX;subscript;IM;26| (228 . |empty?|) (|List| 9)
              (233 . |empty|) (237 . |odd?|) (242 . |cons|) (248 . |empty|)
              (252 . |reverse!|) (257 . |first|) (262 . |rest|)
              |FMTMJAX;altsupersub;IM;27| (267 . |numberOfPrimes|)
              (272 . |Zero|) (276 . |Zero|) (280 . |new|) (|PositiveInteger|)
              (|NumberFormats|) (286 . |FormatRoman|) (291 . |lowerCase|)
              (296 . |concat|) |FMTMJAX;prime;IM;28| |FMTMJAX;power;I3M;29|
              |FMTMJAX;fraction;I3M;30| |FMTMJAX;slash;I3M;31|
              |FMTMJAX;binomial;ILOb;32| |FMTMJAX;zag;ILOb;33| (301 . |nary|)
              |FMTMJAX;environment;3S2M;34| |FMTMJAX;vconcat;2M;35|
              |FMTMJAX;pile;2M;36| (308 . |formatExpression|) (313 . =)
              |FMTMJAX;matrix;2SM;37| (319 . |nothing|) (|OperatorHandlers| 54)
              (323 . |setHandler!|) (331 . |formatConstant|) (336 . |prefix|)
              (343 . |maxPrecedence|) (347 . |infix|) (355 . |binary|)
              (361 . |naryPlus|) (369 . |new|) '|operatorData|
              |FMTMJAX;operatorHandlers;Oh;39|)
           '#(|zag| 373 |vconcat| 379 |theMap| 384 |sum| 390 |subscript| 395
              |slash| 400 |scripts| 407 |product| 412 |prime| 417 |prefix| 422
              |precedence| 429 |power| 435 |pile| 442 |parenthesizeIf| 447
              |parenthesize| 453 |overbar| 460 |operatorHandlers| 466
              |numberOfPrimes| 470 |nthRoot| 475 |nothing| 482 |naryPlus| 486
              |nary| 494 |minPrecedence| 501 |maxPrecedence| 505 |matrix| 509
              |integral| 515 |infix| 520 |fraction| 528 |formatSymbol| 535
              |formatString| 540 |formatInteger| 545 |formatFunctionSymbol| 550
              |formatFloat| 555 |formatExpression| 560 |formatConstant| 576
              |environment| 581 |defaultPrologue| 589 |defaultEpilogue| 594
              |coerce| 599 |bracket| 604 |box| 611 |binomial| 616 |binary| 622
              |altsupersub| 628)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(|FormatterCategory&| NIL)
                       (CONS '#((|FormatterCategory|) (|CoercibleTo| 6))
                             (|makeByteWordVec2| 124
                                                 '(1 9 0 8 10 1 9 0 13 14 1 16
                                                   0 8 17 3 8 18 16 0 18 19 2
                                                   20 0 18 18 21 2 8 0 0 20 22
                                                   2 8 23 0 18 24 2 8 0 0 23 25
                                                   1 23 0 8 26 2 8 0 23 0 27 2
                                                   8 18 23 0 29 3 8 18 23 0 18
                                                   30 1 9 33 0 34 1 37 36 6 38
                                                   1 37 6 6 39 2 37 36 6 40 41
                                                   1 37 42 6 43 2 33 36 0 0 44
                                                   2 42 6 0 18 45 1 40 6 0 46 2
                                                   6 0 0 13 47 0 18 0 48 0 0 18
                                                   49 2 0 9 6 18 50 1 9 36 0 51
                                                   2 18 36 0 0 52 2 0 9 36 9 53
                                                   0 9 0 56 1 42 33 0 57 2 33
                                                   36 0 0 58 1 37 36 6 61 1 37
                                                   36 6 62 1 9 63 0 64 3 0 54 8
                                                   8 54 68 2 18 36 0 0 69 1 37
                                                   8 6 71 1 42 6 0 72 0 73 0 74
                                                   0 33 0 75 1 42 0 0 76 2 33
                                                   36 0 0 77 2 18 0 0 0 79 1 42
                                                   36 0 81 0 82 0 83 1 18 36 0
                                                   84 2 82 0 9 0 85 0 6 0 86 1
                                                   82 0 0 87 1 82 9 0 88 1 82 0
                                                   0 89 1 0 18 6 91 0 33 0 92 0
                                                   18 0 93 2 8 0 33 23 94 1 96
                                                   8 95 97 1 8 0 0 98 1 8 0 13
                                                   99 3 0 54 8 18 54 106 1 0 54
                                                   18 110 2 8 36 0 0 111 0 0 54
                                                   113 4 114 54 0 18 8 54 115 1
                                                   0 54 8 116 3 0 54 8 18 54
                                                   117 0 0 18 118 4 0 54 8 18
                                                   54 54 119 2 0 54 54 54 120 4
                                                   0 54 8 8 18 54 121 0 114 0
                                                   122 2 0 9 18 42 105 1 0 54
                                                   54 108 2 0 9 18 42 65 1 0 54
                                                   18 59 1 0 54 18 80 3 0 54 18
                                                   54 54 103 1 0 54 18 78 1 0
                                                   54 18 60 1 0 54 18 100 3 0
                                                   54 8 18 54 117 2 0 54 18 54
                                                   1 3 0 54 18 54 54 101 1 0 54
                                                   54 109 2 0 9 36 9 53 3 0 9 8
                                                   8 9 15 2 0 54 18 54 66 0 0
                                                   114 124 1 0 18 6 91 3 0 54
                                                   18 54 54 70 0 0 54 113 4 0
                                                   54 8 8 18 54 121 3 0 54 8 18
                                                   54 106 0 0 18 49 0 0 18 118
                                                   2 0 54 8 8 112 1 0 54 18 55
                                                   4 0 54 8 18 54 54 119 3 0 54
                                                   18 54 54 102 1 0 9 8 32 1 0
                                                   9 8 31 1 0 9 18 1 1 0 9 8 35
                                                   1 0 9 8 28 1 0 54 18 110 1 0
                                                   9 6 1 2 0 9 6 18 50 1 0 54 8
                                                   116 4 0 54 8 8 8 54 107 1 0
                                                   9 8 11 1 0 9 8 12 1 0 6 0 7
                                                   3 0 54 8 8 54 68 1 0 54 54
                                                   67 2 0 9 18 42 104 2 0 54 54
                                                   54 120 1 0 54 18 90)))))
           '|lookupComplete|)) 

(MAKEPROP '|FormatMathJax| 'NILADIC T) 
