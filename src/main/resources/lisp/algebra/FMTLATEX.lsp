
(SDEFUN |FMTLATEX;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (|coerceRe2E| |x|
                      (ELT
                       (|Record| (|:| |prolog| (|OutputBox|))
                                 (|:| |fmt| (|OutputBox|))
                                 (|:| |epilog| (|OutputBox|)))
                       0))) 

(SDEFUN |FMTLATEX;defaultPrologue;SOb;2|
        ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL
         (SPADCALL (LIST "\\begin{fricasmath}{" |label| "}") (QREFELT $ 10))
         (QREFELT $ 12))) 

(SDEFUN |FMTLATEX;defaultEpilogue;SOb;3|
        ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL "\\end{fricasmath}" (QREFELT $ 12))) 

(SDEFUN |FMTLATEX;parenthesize;2S2Ob;4|
        ((|left| #1=(|String|)) (|right| #1#) (|b| (|OutputBox|))
         ($ (|OutputBox|)))
        (SEQ
         (COND
          ((EQUAL |left| "(")
           (COND
            ((EQUAL |right| ")")
             (SEQ (LETT |left| "\\PAREN{") (EXIT (LETT |right| "}")))))))
         (EXIT
          (SPADCALL
           (LIST (SPADCALL |left| (QREFELT $ 12)) |b|
                 (SPADCALL |right| (QREFELT $ 12)))
           (QREFELT $ 15))))) 

(SDEFUN |FMTLATEX;texEscapeString| ((|s| (|String|)) ($ (|String|)))
        (SPROG
         ((|str| (|String|)) (|n| (|Integer|)) (|p| (|Integer|))
          (|cc| (|CharacterClass|)))
         (SEQ (LETT |cc| (SPADCALL " \\{}$^_%~#&" (QREFELT $ 18)))
              (LETT |p| (SPADCALL |cc| |s| 1 (QREFELT $ 20)))
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
                                                    (QREFELT $ 20)))
                                    0))
                                  (GO G191)))
                                (SEQ
                                 (LETT |str|
                                       (STRCONC |str|
                                                (SPADCALL |s|
                                                          (SPADCALL |n|
                                                                    (- |p| 1)
                                                                    (QREFELT $
                                                                             22))
                                                          (QREFELT $ 23))))
                                 (LETT |n| (+ |p| 1))
                                 (EXIT
                                  (LETT |str|
                                        (STRCONC |str|
                                                 (SPADCALL "\\"
                                                           (SPADCALL |s| |p|
                                                                     (QREFELT $
                                                                              25))
                                                           (QREFELT $ 26))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (STRCONC |str|
                                     (SPADCALL |s|
                                               (SPADCALL |n| (QCSIZE |s|)
                                                         (QREFELT $ 22))
                                               (QREFELT $ 23))))))))))) 

(SDEFUN |FMTLATEX;braceBox| ((|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPADCALL "{" "}" |b| (QREFELT $ 16))) 

(SDEFUN |FMTLATEX;tex1|
        ((|cmd| (|String|)) (|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPADCALL
         (LIST (SPADCALL |cmd| (QREFELT $ 12)) (|FMTLATEX;braceBox| |b| $))
         (QREFELT $ 15))) 

(SDEFUN |FMTLATEX;tex1Escape|
        ((|cmd| (|String|)) (|s| (|String|)) ($ (|OutputBox|)))
        (|FMTLATEX;tex1| |cmd|
         (SPADCALL (|FMTLATEX;texEscapeString| |s| $) (QREFELT $ 12)) $)) 

(SDEFUN |FMTLATEX;tex2|
        ((|cmd| (|String|)) (|b1| (|OutputBox|)) (|b2| (|OutputBox|))
         ($ (|OutputBox|)))
        (SPADCALL
         (LIST (|FMTLATEX;tex1| |cmd| |b1| $) (|FMTLATEX;braceBox| |b2| $))
         (QREFELT $ 15))) 

(SDEFUN |FMTLATEX;formatFloat;SOb;10| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (SPADCALL (|STR_to_CHAR| "_") |s| (QREFELT $ 28))
                  (QREFELT $ 12))) 

(SDEFUN |FMTLATEX;formatString;SOb;11| ((|s| (|String|)) ($ (|OutputBox|)))
        (|FMTLATEX;tex1Escape| "\\STRING" |s| $)) 

(SDEFUN |FMTLATEX;formatSymbol;SOb;12| ((|s| (|String|)) ($ (|OutputBox|)))
        (|FMTLATEX;tex1Escape| "\\SYMBOL" |s| $)) 

(SDEFUN |FMTLATEX;formatFunctionSymbol;SOb;13|
        ((|s| (|String|)) ($ (|OutputBox|)))
        (|FMTLATEX;tex1Escape| "\\FUN" |s| $)) 

(SDEFUN |FMTLATEX;integralArgument| ((|a| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|op3| (|OutputForm|)) (|op2| #1=(|OutputForm|))
          (|args| (|List| (|OutputForm|))) (|op| #1#))
         (SEQ
          (COND ((SPADCALL |a| (QREFELT $ 35)) |a|)
                (#2='T
                 (SEQ (LETT |op| (SPADCALL |a| (QREFELT $ 36)))
                      (COND
                       ((NULL (SPADCALL |op| '* (QREFELT $ 38))) (EXIT |a|)))
                      (LETT |args| (SPADCALL |a| (QREFELT $ 40)))
                      (EXIT
                       (COND ((SPADCALL (LENGTH |args|) 2 (QREFELT $ 42)) |a|)
                             (#2#
                              (SEQ
                               (LETT |op2|
                                     (SPADCALL
                                      (SPADCALL |args| 2 (QREFELT $ 43))
                                      (QREFELT $ 36)))
                               (COND
                                ((NULL (SPADCALL |op2| 'CONCAT (QREFELT $ 38)))
                                 (EXIT |a|)))
                               (LETT |op3|
                                     (|SPADfirst|
                                      (SPADCALL
                                       (SPADCALL |args| 2 (QREFELT $ 43))
                                       (QREFELT $ 40))))
                               (COND
                                ((NULL (SPADCALL |op3| '|d| (QREFELT $ 38)))
                                 (EXIT |a|)))
                               (EXIT
                                (SPADCALL (SPADCALL 'INTSEP (QREFELT $ 44))
                                          (LIST
                                           (SPADCALL |args| 1 (QREFELT $ 43))
                                           (SPADCALL |args| 2 (QREFELT $ 43)))
                                          (QREFELT $ 45))))))))))))) 

(SDEFUN |FMTLATEX;integral;IM;15|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTLATEX;integral;IM;15!0| (VECTOR |p| $))))) 

(SDEFUN |FMTLATEX;integral;IM;15!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bu| NIL) (|bl| NIL) (|ba| NIL) (|a| NIL))
                   (SEQ
                    (LETT |bl|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 46)
                                     (QREFELT $ 43))
                           (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                    (LETT |bu|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 43))
                                    (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                    (LETT |a|
                          (|FMTLATEX;integralArgument|
                           (SPADCALL |args| 3 (QREFELT $ 43)) $))
                    (LETT |ba|
                          (SPADCALL |a| (SPADCALL (QREFELT $ 47))
                                    (QREFELT $ 48)))
                    (COND
                     ((NULL (SPADCALL |bl| (QREFELT $ 49)))
                      (LETT |bl| (SPADCALL "_{" "}" |bl| (QREFELT $ 16)))))
                    (COND
                     ((NULL (SPADCALL |bu| (QREFELT $ 49)))
                      (LETT |bu| (SPADCALL "^{" "}" |bu| (QREFELT $ 16)))))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                               (SPADCALL
                                (LIST (SPADCALL "\\int" (QREFELT $ 12)) |bl|
                                      |bu| (|FMTLATEX;braceBox| |ba| $))
                                (QREFELT $ 15))
                               (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;operatorWithLimits|
        ((|s| (|String|)) (|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTLATEX;operatorWithLimits!0| (VECTOR |s| |p| $))))) 

(SDEFUN |FMTLATEX;operatorWithLimits!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
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
                           (SPADCALL |args| (|spadConstant| $ 46)
                                     (QREFELT $ 43))
                           (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                    (LETT |bu| (SPADCALL (QREFELT $ 54)))
                    (LETT |ba|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 43))
                                    (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                    (COND
                     ((SPADCALL (SPADCALL |args| (QREFELT $ 55)) 3
                                (QREFELT $ 56))
                      (SEQ (LETT |bu| |ba|)
                           (EXIT
                            (LETT |ba|
                                  (SPADCALL (SPADCALL |args| 3 (QREFELT $ 43))
                                            (SPADCALL (QREFELT $ 47))
                                            (QREFELT $ 48)))))))
                    (COND
                     ((NULL (SPADCALL |bl| (QREFELT $ 49)))
                      (LETT |bl| (SPADCALL "_{" "}" |bl| (QREFELT $ 16)))))
                    (COND
                     ((NULL (SPADCALL |bu| (QREFELT $ 49)))
                      (LETT |bu| (SPADCALL "^{" "}" |bu| (QREFELT $ 16)))))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                               (SPADCALL
                                (LIST (SPADCALL |s| (QREFELT $ 12)) |bl| |bu|
                                      (|FMTLATEX;braceBox| |ba| $))
                                (QREFELT $ 15))
                               (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;sum;IM;17|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTLATEX;operatorWithLimits| "\\sum" |p| $)) 

(SDEFUN |FMTLATEX;product;IM;18|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTLATEX;operatorWithLimits| "\\prod" |p| $)) 

(SDEFUN |FMTLATEX;theMap;ILOb;19|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG
         ((|p2| (|Integer|)) (|p1| (|Integer|)) (|s| (|String|))
          (|b| (|OutputBox|)) (|a| (|OutputForm|)))
         (SEQ (LETT |a| (|SPADfirst| |args|))
              (LETT |s|
                    (SEQ
                     (COND
                      ((SPADCALL |a| (QREFELT $ 35))
                       (COND
                        ((NULL (SPADCALL |a| (QREFELT $ 59)))
                         (COND
                          ((NULL (SPADCALL |a| (QREFELT $ 60)))
                           (EXIT ";?;")))))))
                     (LETT |b|
                           (SPADCALL |a| (SPADCALL (QREFELT $ 47))
                                     (QREFELT $ 48)))
                     (EXIT (|SPADfirst| (SPADCALL |b| (QREFELT $ 62))))))
              (LETT |p1| (SPADCALL (|STR_to_CHAR| ";") |s| (QREFELT $ 63)))
              (LETT |p2|
                    (SPADCALL (|STR_to_CHAR| ";") |s| (+ |p1| 1)
                              (QREFELT $ 64)))
              (EXIT
               (|FMTLATEX;tex1| "\\theMap"
                (SPADCALL
                 (SPADCALL |s| (SPADCALL (+ |p1| 1) (- |p2| 1) (QREFELT $ 22))
                           (QREFELT $ 23))
                 (QREFELT $ 12))
                $))))) 

(SDEFUN |FMTLATEX;overbar;I2M;20|
        ((|p| #1=(|Integer|))
         (|hh| (|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTLATEX;overbar;I2M;20!0| (VECTOR |hh| $ |p|)))) 

(SDEFUN |FMTLATEX;overbar;I2M;20!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |hh|)
          (LETT |p| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                      (|FMTLATEX;tex1| "\\overline" (SPADCALL |p| |args| |hh|)
                       $)
                      (QREFELT $ 51)))))) 

(SDEFUN |FMTLATEX;box;2M;21|
        ((|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTLATEX;box;2M;21!0| (VECTOR |hh| $)))) 

(SDEFUN |FMTLATEX;box;2M;21!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |hh|)
          (LETT $ (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|FMTLATEX;tex1| "\\BOX"
             (SPADCALL |prec|
                       (LIST
                        (SPADCALL |args| (|spadConstant| $ 46) (QREFELT $ 43)))
                       |hh|)
             $))))) 

(SDEFUN |FMTLATEX;nthRoot;I3M;22|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTLATEX;nthRoot;I3M;22!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMTLATEX;nthRoot;I3M;22!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
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
                                     (SPADCALL |args| (|spadConstant| $ 46)
                                               (QREFELT $ 43)))
                                    (SPADCALL "{" "}" |h1| (QREFELT $ 68))))
                    (LETT |bn| (SPADCALL (QREFELT $ 54)))
                    (COND
                     ((SPADCALL (SPADCALL |args| (QREFELT $ 55))
                                (|spadConstant| $ 46) (QREFELT $ 69))
                      (LETT |bn|
                            (SPADCALL |p|
                                      (LIST (SPADCALL |args| 2 (QREFELT $ 43)))
                                      (SPADCALL "[" "]" |h2|
                                                (QREFELT $ 68))))))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                               (SPADCALL
                                (LIST (SPADCALL "\\sqrt" (QREFELT $ 12)) |bn|
                                      |bx|)
                                (QREFELT $ 15))
                               (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;scripts;IM;23|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTLATEX;scripts;IM;23!0| (VECTOR |p| $))))) 

(SDEFUN |FMTLATEX;scripts;IM;23!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b| NIL) (|a| NIL) (|i| NIL))
                   (SEQ
                    (LETT |b|
                          (|FMTLATEX;tex1| "\\SCRIPTS"
                           (SPADCALL (SPADCALL |args| (QREFELT $ 71)) |p|
                                     (QREFELT $ 48))
                           $))
                    (LETT |args| (SPADCALL |args| (QREFELT $ 72)))
                    (SEQ (LETT |i| (|spadConstant| $ 74)) G190
                         (COND ((|greater_SI| |i| 4) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |args| (QREFELT $ 76))
                             (LETT |b|
                                   (SPADCALL
                                    (LIST |b| (SPADCALL "{}" (QREFELT $ 12)))
                                    (QREFELT $ 15))))
                            ('T
                             (SEQ (LETT |a| (SPADCALL |args| (QREFELT $ 71)))
                                  (LETT |args|
                                        (SPADCALL |args| (QREFELT $ 72)))
                                  (COND
                                   ((SPADCALL |a| (QREFELT $ 59))
                                    (COND
                                     ((SPADCALL (SPADCALL |a| (QREFELT $ 77))
                                                " " (QREFELT $ 78))
                                      (EXIT
                                       (LETT |b|
                                             (SPADCALL
                                              (LIST |b|
                                                    (SPADCALL "{}"
                                                              (QREFELT $ 12)))
                                              (QREFELT $ 15))))))))
                                  (EXIT
                                   (LETT |b|
                                         (SPADCALL
                                          (LIST |b|
                                                (SPADCALL "{" (QREFELT $ 12))
                                                (SPADCALL |a|
                                                          (SPADCALL
                                                           (QREFELT $ 47))
                                                          (QREFELT $ 48))
                                                (SPADCALL "}" (QREFELT $ 12)))
                                          (QREFELT $ 15)))))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50)) |b|
                               (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;subscript;IM;24|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTLATEX;subscript;IM;24!0| (VECTOR |p| $))))) 

(SDEFUN |FMTLATEX;subscript;IM;24!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 46)
                                     (QREFELT $ 43))
                           (SPADCALL |p| (|spadConstant| $ 46) (QREFELT $ 80))
                           (QREFELT $ 48)))
                    (LETT |b2|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 43))
                                    (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                               (|FMTLATEX;tex2| "\\SUB" |b1| |b2| $)
                               (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;altsupersub;IM;25|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ (CONS #'|FMTLATEX;altsupersub;IM;25!0| (VECTOR |p| $))))) 

(SDEFUN |FMTLATEX;altsupersub;IM;25!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|b2| NIL) (|lb| NIL) (|o| NIL) (#1=#:G817 NIL) (|a| NIL)
              (|i| NIL) (|b1| NIL))
             (SEQ
              (LETT |b1|
                    (SPADCALL (SPADCALL |args| (QREFELT $ 71)) |p|
                              (QREFELT $ 48)))
              (LETT |lb| (SPADCALL (QREFELT $ 83)))
              (SEQ (LETT |i| (|spadConstant| $ 74)) (LETT |a| NIL)
                   (LETT #1# (SPADCALL |args| (QREFELT $ 72))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |o|
                          (COND ((SPADCALL |i| (QREFELT $ 84)) "_") ('T "^")))
                    (EXIT
                     (LETT |lb|
                           (SPADCALL
                            (|FMTLATEX;tex1| |o|
                             (SPADCALL |a| (SPADCALL (QREFELT $ 47))
                                       (QREFELT $ 48))
                             $)
                            |lb| (QREFELT $ 85)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |b2|
                    (SPADCALL (SPADCALL |lb| (QREFELT $ 86)) (QREFELT $ 15)))
              (EXIT
               (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                         (|FMTLATEX;tex2| "\\ALTSUPERSUB" |b1| |b2| $)
                         (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;prime;IM;26|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMTLATEX;prime;IM;26!0| (VECTOR |p| $))))) 

(SDEFUN |FMTLATEX;prime;IM;26!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 46)
                                     (QREFELT $ 43))
                           (SPADCALL |p| (|spadConstant| $ 46) (QREFELT $ 80))
                           (QREFELT $ 48)))
                    (LETT |b2|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 43))
                                    (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                               (|FMTLATEX;tex2| "\\PRIME" |b1| |b2| $)
                               (QREFELT $ 51))))))))) 

(SDEFUN |FMTLATEX;aux2|
        ((|s| (|String|)) (|p| (|Integer|))
         (|h1| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         (|h2| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTLATEX;aux2!0| (VECTOR |h2| |h1| |s| $ |p|)))) 

(SDEFUN |FMTLATEX;aux2!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |s| |h1| |h2|)
          (LETT |p| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |s| (QREFELT $$ 2))
          (LETT |h1| (QREFELT $$ 1))
          (LETT |h2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 50))
                      (|FMTLATEX;tex2| |s|
                       (SPADCALL |p|
                                 (LIST
                                  (SPADCALL |args| (|spadConstant| $ 46)
                                            (QREFELT $ 43)))
                                 |h1|)
                       (SPADCALL |p| (LIST (SPADCALL |args| 2 (QREFELT $ 43)))
                                 |h2|)
                       $)
                      (QREFELT $ 51)))))) 

(SDEFUN |FMTLATEX;power;I3M;28|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTLATEX;aux2| "\\SUPER" |p| |h1| |h2| $)) 

(SDEFUN |FMTLATEX;fraction;I3M;29|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTLATEX;aux2| "\\frac" |p| |h1| |h2| $)) 

(SDEFUN |FMTLATEX;slash;I3M;30|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMTLATEX;aux2| "\\SLASH" |p| |h1| |h2| $)) 

(SDEFUN |FMTLATEX;binomial;ILOb;31|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|b2| #1=(|OutputBox|)) (|b1| #1#))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| 1 (QREFELT $ 43))
                                (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 43))
                                (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                (EXIT (|FMTLATEX;tex2| "\\binom" |b1| |b2| $))))) 

(SDEFUN |FMTLATEX;zag;ILOb;32|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|b2| #1=(|OutputBox|)) (|b1| #1#))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| 1 (QREFELT $ 43))
                                (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 43))
                                (SPADCALL (QREFELT $ 47)) (QREFELT $ 48)))
                (EXIT (|FMTLATEX;tex2| "\\ZAG" |b1| |b2| $))))) 

(SDEFUN |FMTLATEX;environment;3S2M;33|
        ((|env| (|String|)) (|x| (|String|)) (|sep| (|String|))
         (|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTLATEX;environment;3S2M;33!0|
                      (VECTOR |h| |sep| |x| |env| $))))) 

(SDEFUN |FMTLATEX;environment;3S2M;33!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
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
                     ((SPADCALL |args| (QREFELT $ 76))
                      (SPADCALL (QREFELT $ 54)))
                     ('T
                      (SEQ
                       (LETT |b|
                             (SPADCALL
                              (SPADCALL (LIST "\\begin{" |env| "}" |x|)
                                        (QREFELT $ 10))
                              (QREFELT $ 12)))
                       (LETT |e|
                             (SPADCALL
                              (SPADCALL (LIST "\\end{" |env| "}")
                                        (QREFELT $ 10))
                              (QREFELT $ 12)))
                       (LETT |entries|
                             (SPADCALL (SPADCALL (QREFELT $ 47)) |args|
                                       (SPADCALL |sep|
                                                 (SPADCALL (QREFELT $ 47)) |h|
                                                 (QREFELT $ 94))))
                       (EXIT
                        (SPADCALL (LIST |b| |entries| |e|)
                                  (QREFELT $ 15)))))))))))) 

(SDEFUN |FMTLATEX;vconcat;2M;34|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "VCONCAT" "" "\\\\" |h| (QREFELT $ 95))) 

(SDEFUN |FMTLATEX;pile;2M;35|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "PILE" "" "\\\\" |h| (QREFELT $ 95))) 

(SDEFUN |FMTLATEX;matrix;2SM;36|
        ((|left| #1=(|String|)) (|right| #1#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SEQ (CONS #'|FMTLATEX;matrix;2SM;36!0| $))) 

(SDEFUN |FMTLATEX;matrix;2SM;36!0| ((|prec| NIL) (|args| NIL) ($ NIL))
        (SPROG ((|n| NIL))
               (SEQ
                (LETT |n|
                      (SPADCALL
                       (LIST "{"
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL |args| (QREFELT $ 72))
                                          (QREFELT $ 71))
                                (QREFELT $ 40))
                               (QREFELT $ 55))
                              (QREFELT $ 98))
                             "}")
                       (QREFELT $ 10)))
                (EXIT
                 (SPADCALL (SPADCALL (QREFELT $ 47))
                           (SPADCALL |args| (QREFELT $ 72))
                           (SPADCALL "MATRIX" |n| "\\\\"
                                     (SPADCALL (SPADCALL (QREFELT $ 47))
                                               (QREFELT $ 99))
                                     (QREFELT $ 95))))))) 

(SDEFUN |FMTLATEX;setOperatorHandlers!|
        ((|oh|
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
         ($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (SPROG ((#1=#:G1267 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SPADCALL |oh| 0 "NOTHING" (SPADCALL (QREFELT $ 101))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 0 "%pi" (SPADCALL "\\pi " (QREFELT $ 104))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 0 "%e" (SPADCALL "\\EulerE " (QREFELT $ 104))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 0 "%i"
                            (SPADCALL "\\ImaginaryI " (QREFELT $ 104))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 0 "%Infinity"
                            (SPADCALL "\\infty " (QREFELT $ 104))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 0 "infinity"
                            (SPADCALL "\\infty " (QREFELT $ 104))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 0 "..." (SPADCALL "\\ldots " (QREFELT $ 104))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "cos"
                            (SPADCALL "\\cos" 900
                                      (SPADCALL #2="\\PAREN{" #3="}"
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "cot"
                            (SPADCALL "\\cot" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "csc"
                            (SPADCALL "\\csc" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "log"
                            (SPADCALL "\\log" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "sec"
                            (SPADCALL "\\sin" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "sin"
                            (SPADCALL "\\sin" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "tan"
                            (SPADCALL "\\tan" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "cosh"
                            (SPADCALL "\\cosh" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "coth"
                            (SPADCALL "\\coth" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "csch"
                            (SPADCALL "\\csch" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "sech"
                            (SPADCALL "\\sech" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "sinh"
                            (SPADCALL "\\sinh" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "tanh"
                            (SPADCALL "\\tanh" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "acos"
                            (SPADCALL "\\arccos" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "asin"
                            (SPADCALL "\\arcsin" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "atan"
                            (SPADCALL "\\arctan" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "erf"
                            (SPADCALL "\\erf" 900
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 47))
                                                 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "-"
                            (SPADCALL "-" 710 (SPADCALL 715 (QREFELT $ 99))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "not"
                            (SPADCALL "\\lnot " 710
                                      (SPADCALL 715 (QREFELT $ 99))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "QUOTE"
                            (SPADCALL "\\QUOTE{" "}"
                                      (SPADCALL 990 (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "OVERBAR"
                            (SPADCALL (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 66))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "BOX"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 47))
                                       (QREFELT $ 99))
                             (QREFELT $ 67))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "Aleph"
                            (SPADCALL "\\SUB{\\aleph}{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "BRACE"
                            (SPADCALL "\\BRACE{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "BRACKET"
                            (SPADCALL "\\BRACKET{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "PAREN"
                            (SPADCALL "\\PAREN{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "Gamma"
                            (SPADCALL "\\Gamma\\PAREN{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "ROOT"
                            (SPADCALL "\\sqrt{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "SEGMENT"
                            (SPADCALL "\\SEGMENTi{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 1 "STRING"
                            (SPADCALL "\\STRING{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 68))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "rem"
                            (SPADCALL "" 810
                                      (SPADCALL "\\REM{" "}"
                                                (SPADCALL 811 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (SPADCALL #4="{" #5="}"
                                                (SPADCALL 811 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 107))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "quo"
                            (SPADCALL "" 810
                                      (SPADCALL "\\QUO{" "}"
                                                (SPADCALL 811 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (SPADCALL #4# #5#
                                                (SPADCALL 811 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 107))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "exquo"
                            (SPADCALL "" 810
                                      (SPADCALL "\\EXQUO{" "}"
                                                (SPADCALL 811 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (SPADCALL #4# #5#
                                                (SPADCALL 811 (QREFELT $ 99))
                                                (QREFELT $ 68))
                                      (QREFELT $ 107))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "^"
                            (SPADCALL 950 (SPADCALL 960 (QREFELT $ 99))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 89))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "/"
                            (SPADCALL 910
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 90))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "OVER"
                            (SPADCALL 910
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 90))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "SLASH"
                            (SPADCALL 880 (SPADCALL 881 (QREFELT $ 99))
                                      (SPADCALL 882 (QREFELT $ 99))
                                      (QREFELT $ 91))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "ZAG" (ELT $ 93) (QREFELT $ 103))
                  (SPADCALL |oh| 2 "BINOMIAL" (ELT $ 92) (QREFELT $ 103))
                  (SPADCALL |oh| 2 "PRIME" (SPADCALL 950 (QREFELT $ 88))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "ROOT"
                            (SPADCALL 970
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 70))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "SUB" (SPADCALL 950 (QREFELT $ 81))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "SEGMENT"
                            (SPADCALL "\\SEGMENTii" 100
                                      (SPADCALL
                                       (SPADCALL #4# #5#
                                                 (SPADCALL 100 (QREFELT $ 99))
                                                 (QREFELT $ 68))
                                       (SPADCALL #4# #5#
                                                 (SPADCALL 100 (QREFELT $ 99))
                                                 (QREFELT $ 68))
                                       (QREFELT $ 108))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "TENSOR"
                            (SPADCALL "\\otimes " 850
                                      (SPADCALL 850 (QREFELT $ 99))
                                      (SPADCALL 850 (QREFELT $ 99))
                                      (QREFELT $ 107))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "EQUATNUM"
                            (SPADCALL "\\EQUATNUM" (SPADCALL (QREFELT $ 106))
                                      (SPADCALL
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 47))
                                                  (QREFELT $ 99))
                                                 (QREFELT $ 68))
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 47))
                                                  (QREFELT $ 99))
                                                 (QREFELT $ 68))
                                       (QREFELT $ 108))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "OVERLABEL"
                            (SPADCALL "\\OVERLABEL" (SPADCALL (QREFELT $ 106))
                                      (SPADCALL
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 47))
                                                  (QREFELT $ 99))
                                                 (QREFELT $ 68))
                                       (SPADCALL #4# #5#
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 47))
                                                  (QREFELT $ 99))
                                                 (QREFELT $ 68))
                                       (QREFELT $ 108))
                                      (QREFELT $ 105))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "=="
                            (SPADCALL "==" 400 (SPADCALL 401 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "="
                            (SPADCALL "=" 400 (SPADCALL 400 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "~="
                            (SPADCALL "\\ne " 400 (SPADCALL 400 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "<"
                            (SPADCALL "<" 400 (SPADCALL 400 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 ">"
                            (SPADCALL ">" 400 (SPADCALL 400 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "<="
                            (SPADCALL "\\leq " 400
                                      (SPADCALL 400 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 ">="
                            (SPADCALL "\\geq " 400
                                      (SPADCALL 400 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "and"
                            (SPADCALL "\\land " 300
                                      (SPADCALL 300 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "or"
                            (SPADCALL "\\lor " 200
                                      (SPADCALL 200 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "LET"
                            (SPADCALL "\\coloneqq " 125
                                      (SPADCALL 125 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "TAG"
                            (SPADCALL "\\to " 100 (SPADCALL 100 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "+->"
                            (SPADCALL "\\mapsto " 100
                                      (SPADCALL 100 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "|"
                            (SPADCALL "\\mid " 100
                                      (SPADCALL 100 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "SIGMA" (SPADCALL 750 (QREFELT $ 57))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "PI" (SPADCALL 750 (QREFELT $ 58))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 3 "SIGMA2" (SPADCALL 750 (QREFELT $ 57))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 3 "PI2" (SPADCALL 750 (QREFELT $ 58))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 3 "INTSIGN" (SPADCALL 700 (QREFELT $ 53))
                            (QREFELT $ 103))
                  (SPADCALL |oh| 2 "INTSEP"
                            (SPADCALL "\\, " (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 107))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "+"
                            (SPADCALL "+" "-" 700 (SPADCALL 700 (QREFELT $ 99))
                                      (QREFELT $ 109))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "-"
                            (SPADCALL "+" "-" 700 (SPADCALL 700 (QREFELT $ 99))
                                      (QREFELT $ 109))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "*"
                            (SPADCALL "\\TIMES " 800
                                      (SPADCALL 800 (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "AGGLST"
                            (SPADCALL "\\COMMA " (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "AGGSET"
                            (SPADCALL "\\SEMICOLON " (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "CONCAT"
                            (SPADCALL "" (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "CONCATB"
                            (SPADCALL "\\ " (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "ALTSUPERSUB" (SPADCALL 900 (QREFELT $ 87))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "SUPERSUB" (SPADCALL 900 (QREFELT $ 79))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "SC"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 47))
                                       (QREFELT $ 99))
                             (QREFELT $ 97))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "VCONCAT"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 47))
                                       (QREFELT $ 99))
                             (QREFELT $ 96))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "ROW"
                            (SPADCALL "&" (SPADCALL (QREFELT $ 106))
                                      (SPADCALL (SPADCALL (QREFELT $ 47))
                                                (QREFELT $ 99))
                                      (QREFELT $ 94))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "MATRIX" (SPADCALL "[" "]" (QREFELT $ 100))
                            (QREFELT $ 103))
                  (SPADCALL |oh| -1 "theMap" (ELT $ 65) (QREFELT $ 103))
                  (EXIT (PROGN (LETT #1# |oh|) (GO #6=#:G1266)))))
                #6# (EXIT #1#)))) 

(SDEFUN |FMTLATEX;operatorHandlers;Oh;38|
        (($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (QREFELT $ 111)) 

(DECLAIM (NOTINLINE |FormatLaTeX;|)) 

(DEFUN |FormatLaTeX| ()
  (SPROG NIL
         (PROG (#1=#:G1270)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FormatLaTeX|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FormatLaTeX|
                             (LIST (CONS NIL (CONS 1 (|FormatLaTeX;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|FormatLaTeX|)))))))))) 

(DEFUN |FormatLaTeX;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FormatLaTeX|))
          (LETT $ (GETREFV 113))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FormatLaTeX| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 111
                    (|FMTLATEX;setOperatorHandlers!| (SPADCALL (QREFELT $ 110))
                     $))
          $))) 

(MAKEPROP '|FormatLaTeX| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) |FMTLATEX;coerce;$Of;1|
              (|List| $) (|String|) (0 . |concat|) (|OutputBox|) (5 . |box|)
              |FMTLATEX;defaultPrologue;SOb;2| |FMTLATEX;defaultEpilogue;SOb;3|
              (10 . |hconcat|) |FMTLATEX;parenthesize;2S2Ob;4|
              (|CharacterClass|) (15 . |charClass|) (|Integer|)
              (20 . |position|) (|UniversalSegment| 19) (27 . SEGMENT)
              (33 . |elt|) (|Character|) (39 . |elt|) (45 . |concat|)
              (51 . |char|) (56 . |remove|) |FMTLATEX;formatFloat;SOb;10|
              |FMTLATEX;formatString;SOb;11| |FMTLATEX;formatSymbol;SOb;12|
              |FMTLATEX;formatFunctionSymbol;SOb;13| (|Boolean|)
              (|OutputFormTools|) (62 . |atom?|) (67 . |operator|) (|Symbol|)
              (72 . |is_symbol?|) (|List| 6) (78 . |arguments|)
              (|NonNegativeInteger|) (83 . ~=) (89 . |elt|) (95 . |coerce|)
              (100 . |elt|) (106 . |One|) (110 . |minPrecedence|)
              (114 . |formatExpression|) (120 . |empty?|) (125 . <)
              (131 . |parenthesizeIf|) (|Mapping| 11 19 39)
              |FMTLATEX;integral;IM;15| (137 . |empty|) (141 . |#|) (146 . =)
              |FMTLATEX;sum;IM;17| |FMTLATEX;product;IM;18| (152 . |string?|)
              (157 . |symbol?|) (|List| 9) (162 . |lines|) (167 . |position|)
              (173 . |position|) |FMTLATEX;theMap;ILOb;19|
              |FMTLATEX;overbar;I2M;20| |FMTLATEX;box;2M;21| (180 . |bracket|)
              (187 . >) |FMTLATEX;nthRoot;I3M;22| (193 . |first|)
              (198 . |rest|) (|SingleInteger|) (203 . |One|) (207 . |One|)
              (211 . |empty?|) (216 . |string|) (221 . =)
              |FMTLATEX;scripts;IM;23| (227 . +) |FMTLATEX;subscript;IM;24|
              (|List| 11) (233 . |empty|) (237 . |odd?|) (242 . |cons|)
              (248 . |reverse!|) |FMTLATEX;altsupersub;IM;25|
              |FMTLATEX;prime;IM;26| |FMTLATEX;power;I3M;28|
              |FMTLATEX;fraction;I3M;29| |FMTLATEX;slash;I3M;30|
              |FMTLATEX;binomial;ILOb;31| |FMTLATEX;zag;ILOb;32| (253 . |nary|)
              |FMTLATEX;environment;3S2M;33| |FMTLATEX;vconcat;2M;34|
              |FMTLATEX;pile;2M;35| (260 . |convert|)
              (265 . |formatExpression|) |FMTLATEX;matrix;2SM;36|
              (270 . |nothing|) (|OperatorHandlers| 52) (274 . |setHandler!|)
              (282 . |formatConstant|) (287 . |prefix|) (294 . |maxPrecedence|)
              (298 . |infix|) (306 . |binary|) (312 . |naryPlus|) (320 . |new|)
              '|operatorData| |FMTLATEX;operatorHandlers;Oh;38|)
           '#(|zag| 324 |vconcat| 330 |theMap| 335 |sum| 341 |subscript| 346
              |slash| 351 |scripts| 358 |product| 363 |prime| 368 |prefix| 373
              |precedence| 380 |power| 386 |pile| 393 |parenthesizeIf| 398
              |parenthesize| 404 |overbar| 411 |operatorHandlers| 417
              |numberOfPrimes| 421 |nthRoot| 426 |nothing| 433 |naryPlus| 437
              |nary| 445 |minPrecedence| 452 |maxPrecedence| 456 |matrix| 460
              |integral| 466 |infix| 471 |fraction| 479 |formatSymbol| 486
              |formatString| 491 |formatInteger| 496 |formatFunctionSymbol| 501
              |formatFloat| 506 |formatExpression| 511 |formatConstant| 527
              |environment| 532 |defaultPrologue| 540 |defaultEpilogue| 545
              |coerce| 550 |bracket| 555 |box| 562 |binomial| 567 |binary| 573
              |altsupersub| 579)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(|FormatterCategory&| NIL)
                       (CONS '#((|FormatterCategory|) (|CoercibleTo| 6))
                             (|makeByteWordVec2| 112
                                                 '(1 9 0 8 10 1 11 0 9 12 1 11
                                                   0 8 15 1 17 0 9 18 3 9 19 17
                                                   0 19 20 2 21 0 19 19 22 2 9
                                                   0 0 21 23 2 9 24 0 19 25 2 9
                                                   0 0 24 26 1 24 0 9 27 2 9 0
                                                   24 0 28 1 34 33 6 35 1 34 6
                                                   6 36 2 34 33 6 37 38 1 34 39
                                                   6 40 2 41 33 0 0 42 2 39 6 0
                                                   19 43 1 37 6 0 44 2 6 0 0 8
                                                   45 0 19 0 46 0 0 19 47 2 0
                                                   11 6 19 48 1 11 33 0 49 2 19
                                                   33 0 0 50 2 0 11 33 11 51 0
                                                   11 0 54 1 39 41 0 55 2 41 33
                                                   0 0 56 1 34 33 6 59 1 34 33
                                                   6 60 1 11 61 0 62 2 9 19 24
                                                   0 63 3 9 19 24 0 19 64 3 0
                                                   52 9 9 52 68 2 19 33 0 0 69
                                                   1 39 6 0 71 1 39 0 0 72 0 73
                                                   0 74 0 41 0 75 1 39 33 0 76
                                                   1 34 9 6 77 2 9 33 0 0 78 2
                                                   19 0 0 0 80 0 82 0 83 1 19
                                                   33 0 84 2 82 0 11 0 85 1 82
                                                   0 0 86 3 0 52 9 19 52 94 1
                                                   19 9 0 98 1 0 52 19 99 0 0
                                                   52 101 4 102 52 0 19 9 52
                                                   103 1 0 52 9 104 3 0 52 9 19
                                                   52 105 0 0 19 106 4 0 52 9
                                                   19 52 52 107 2 0 52 52 52
                                                   108 4 0 52 9 9 19 52 109 0
                                                   102 0 110 2 0 11 19 39 93 1
                                                   0 52 52 96 2 0 11 19 39 65 1
                                                   0 52 19 57 1 0 52 19 81 3 0
                                                   52 19 52 52 91 1 0 52 19 79
                                                   1 0 52 19 58 1 0 52 19 88 3
                                                   0 52 9 19 52 105 2 0 52 19
                                                   52 1 3 0 52 19 52 52 89 1 0
                                                   52 52 97 2 0 11 33 11 51 3 0
                                                   11 9 9 11 16 2 0 52 19 52 66
                                                   0 0 102 112 1 0 19 6 1 3 0
                                                   52 19 52 52 70 0 0 52 101 4
                                                   0 52 9 9 19 52 109 3 0 52 9
                                                   19 52 94 0 0 19 47 0 0 19
                                                   106 2 0 52 9 9 100 1 0 52 19
                                                   53 4 0 52 9 19 52 52 107 3 0
                                                   52 19 52 52 90 1 0 11 9 31 1
                                                   0 11 9 30 1 0 11 19 1 1 0 11
                                                   9 32 1 0 11 9 29 1 0 52 19
                                                   99 1 0 11 6 1 2 0 11 6 19 48
                                                   1 0 52 9 104 4 0 52 9 9 9 52
                                                   95 1 0 11 9 13 1 0 11 9 14 1
                                                   0 6 0 7 3 0 52 9 9 52 68 1 0
                                                   52 52 67 2 0 11 19 39 92 2 0
                                                   52 52 52 108 1 0 52 19
                                                   87)))))
           '|lookupComplete|)) 

(MAKEPROP '|FormatLaTeX| 'NILADIC T) 
