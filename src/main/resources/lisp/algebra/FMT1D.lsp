
(SDEFUN |FMT1D;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (|coerceRe2E| |x|
                      (ELT
                       (|Record| (|:| |prolog| (|OutputBox|))
                                 (|:| |fmt| (|OutputBox|))
                                 (|:| |epilog| (|OutputBox|)))
                       0))) 

(SDEFUN |FMT1D;defaultPrologue;SOb;2| ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (QREFELT $ 9))) 

(SDEFUN |FMT1D;defaultEpilogue;SOb;3| ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (QREFELT $ 9))) 

(SDEFUN |FMT1D;fricasEscapeString| ((|s| (|String|)) ($ (|String|)))
        (SPROG
         ((|str| (|String|)) (|esc| (|String|)) (|n| (|Integer|))
          (|p| (|Integer|)) (|cc| (|CharacterClass|)))
         (SEQ (LETT |cc| (SPADCALL "\"_" (QREFELT $ 14)))
              (LETT |p| (SPADCALL |cc| |s| 1 (QREFELT $ 16)))
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
                                                    (QREFELT $ 16)))
                                    0))
                                  (GO G191)))
                                (SEQ
                                 (LETT |str|
                                       (STRCONC |str|
                                                (SPADCALL |s|
                                                          (SPADCALL |n|
                                                                    (- |p| 1)
                                                                    (QREFELT $
                                                                             18))
                                                          (QREFELT $ 19))))
                                 (LETT |n| (+ |p| 1))
                                 (LETT |esc|
                                       (SPADCALL "_"
                                                 (SPADCALL |s| |p|
                                                           (QREFELT $ 21))
                                                 (QREFELT $ 22)))
                                 (EXIT (LETT |str| (STRCONC |str| |esc|))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (STRCONC |str|
                                     (SPADCALL |s|
                                               (SPADCALL |n| (QCSIZE |s|)
                                                         (QREFELT $ 18))
                                               (QREFELT $ 19))))))))))) 

(SDEFUN |FMT1D;formatFloat;SOb;5| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (SPADCALL (|STR_to_CHAR| "_") |s| (QREFELT $ 24))
                  (QREFELT $ 25))) 

(SDEFUN |FMT1D;formatString;SOb;6| ((|s| (|String|)) ($ (|OutputBox|)))
        (SEQ
         (COND
          ((|eql_SI| (SPADCALL |s| 1 (QREFELT $ 21)) (|STR_to_CHAR| "\""))
           (COND
            ((|eql_SI| (SPADCALL |s| (QCSIZE |s|) (QREFELT $ 21))
                       (|STR_to_CHAR| "\""))
             (EXIT
              (SPADCALL "\"" "\""
                        (SPADCALL
                         (|FMT1D;fricasEscapeString|
                          (SPADCALL |s|
                                    (SPADCALL 2 (- (QCSIZE |s|) 1)
                                              (QREFELT $ 18))
                                    (QREFELT $ 19))
                          $)
                         (QREFELT $ 25))
                        (QREFELT $ 27)))))))
         (EXIT (SPADCALL (|FMT1D;fricasEscapeString| |s| $) (QREFELT $ 25))))) 

(SDEFUN |FMT1D;formatSymbol;SOb;7| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 25))) 

(SDEFUN |FMT1D;formatFunctionSymbol;SOb;8| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 25))) 

(SDEFUN |FMT1D;parenthesize;2S2Ob;9|
        ((|left| #1=(|String|)) (|right| #1#) (|b| (|OutputBox|))
         ($ (|OutputBox|)))
        (SPADCALL
         (LIST (SPADCALL |left| (QREFELT $ 25)) |b|
               (SPADCALL |right| (QREFELT $ 25)))
         (QREFELT $ 32))) 

(SDEFUN |FMT1D;formatFunction|
        ((|s| (|String|)) (|lb| (|List| (|OutputBox|))) ($ (|OutputBox|)))
        (SPROG ((|bx| (|OutputBox|)) (#1=#:G752 NIL) (|b| NIL))
               (SEQ
                (COND
                 ((NULL |lb|) (SPADCALL (STRCONC |s| "()") (QREFELT $ 25)))
                 ('T
                  (SEQ (LETT |bx| (|SPADfirst| |lb|))
                       (SEQ (LETT |b| NIL) (LETT #1# (CDR |lb|)) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |bx|
                                    (SPADCALL
                                     (LIST |bx| (SPADCALL ", " (QREFELT $ 25))
                                           |b|)
                                     (QREFELT $ 32)))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (SPADCALL
                         (LIST (SPADCALL |s| (QREFELT $ 25))
                               (SPADCALL "(" ")" |bx| (QREFELT $ 27)))
                         (QREFELT $ 32))))))))) 

(SDEFUN |FMT1D;substitute|
        ((|x| (|OutputForm|)) (|y| (|OutputForm|)) (|z| (|OutputForm|))
         ($ (|OutputForm|)))
        (SPROG
         ((|args| (|List| (|OutputForm|))) (#1=#:G760 NIL) (|a| NIL)
          (#2=#:G759 NIL))
         (SEQ
          (COND ((SPADCALL |x| |z| (QREFELT $ 34)) |y|)
                ((SPADCALL |z| (QREFELT $ 36)) |z|)
                ('T
                 (SEQ
                  (LETT |args|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |a| NIL)
                              (LETT #1# (SPADCALL |z| (QREFELT $ 38))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |a| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (|FMT1D;substitute| |x| |y| |a| $)
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (EXIT
                   (SPADCALL
                    (|FMT1D;substitute| |x| |y| (SPADCALL |z| (QREFELT $ 39))
                     $)
                    |args| (QREFELT $ 40))))))))) 

(SDEFUN |FMT1D;getDExpression| ((|e| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|args2| #1=(|List| (|OutputForm|))) (|op2| #2=(|OutputForm|))
          (|args| #1#) (|op| #2#))
         (SEQ
          (COND ((SPADCALL |e| (QREFELT $ 36)) (SPADCALL (QREFELT $ 41)))
                (#3='T
                 (SEQ (LETT |op| (SPADCALL |e| (QREFELT $ 39)))
                      (COND
                       ((NULL (SPADCALL |op| '* (QREFELT $ 43)))
                        (EXIT (SPADCALL (QREFELT $ 41)))))
                      (LETT |args| (SPADCALL |e| (QREFELT $ 38)))
                      (EXIT
                       (COND
                        ((SPADCALL (LENGTH |args|) 2 (QREFELT $ 45))
                         (SPADCALL (QREFELT $ 41)))
                        (#3#
                         (SEQ
                          (LETT |op2|
                                (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                          (QREFELT $ 39)))
                          (COND
                           ((NULL (SPADCALL |op2| 'CONCAT (QREFELT $ 43)))
                            (EXIT (SPADCALL (QREFELT $ 41)))))
                          (LETT |args2|
                                (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                          (QREFELT $ 38)))
                          (COND
                           ((OR (SPADCALL (LENGTH |args2|) 2 (QREFELT $ 45))
                                (NULL
                                 (SPADCALL (|SPADfirst| |args2|) '|d|
                                           (QREFELT $ 43))))
                            (EXIT (SPADCALL (QREFELT $ 41)))))
                          (EXIT (SPADCALL |args2| 2 (QREFELT $ 46))))))))))))) 

(SDEFUN |FMT1D;integral;IM;13|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SEQ (CONS #'|FMT1D;integral;IM;13!0| $))) 

(SDEFUN |FMT1D;integral;IM;13!0| ((|prec| NIL) (|args| NIL) ($ NIL))
        (SPROG
         ((|b2| NIL) (|ba| NIL) (|a| NIL) (|bx| NIL) (|x| NIL) (#1=#:G785 NIL)
          (|lb| NIL) (|bu| NIL) (|bl| NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |bl|
                  (SPADCALL
                   (SPADCALL |args| (|spadConstant| $ 47) (QREFELT $ 46))
                   (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
            (LETT |bu|
                  (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                            (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
            (EXIT
             (COND
              ((SPADCALL |bu| (QREFELT $ 50))
               (SEQ
                (LETT |lb|
                      (LIST
                       (SPADCALL (SPADCALL |args| 3 (QREFELT $ 46))
                                 (SPADCALL (QREFELT $ 48)) (QREFELT $ 49))))
                (COND
                 ((NULL (SPADCALL |bl| (QREFELT $ 50)))
                  (LETT |lb| (SPADCALL |lb| |bl| (QREFELT $ 52)))))
                (EXIT
                 (PROGN
                  (LETT #1# (|FMT1D;formatFunction| "int" |lb| $))
                  (GO #2=#:G784)))))
              ('T
               (SEQ (LETT |b2| |bu|)
                    (LETT |x|
                          (|FMT1D;getDExpression|
                           (SPADCALL |args| 3 (QREFELT $ 46)) $))
                    (LETT |ba|
                          (SPADCALL (SPADCALL |args| 3 (QREFELT $ 46))
                                    (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                    (COND
                     ((SPADCALL |x| (SPADCALL (QREFELT $ 41)) (QREFELT $ 53))
                      (SEQ
                       (LETT |bx|
                             (SPADCALL |x| (SPADCALL (QREFELT $ 48))
                                       (QREFELT $ 49)))
                       (LETT |a|
                             (SPADCALL
                              (SPADCALL (SPADCALL |args| 3 (QREFELT $ 46))
                                        (QREFELT $ 38))
                              (QREFELT $ 54)))
                       (EXIT
                        (COND
                         ((SPADCALL |bl| (QREFELT $ 50))
                          (LETT |ba|
                                (SPADCALL
                                 (|FMT1D;substitute| |x|
                                  (SPADCALL |args| 2 (QREFELT $ 46)) |a| $)
                                 (SPADCALL (QREFELT $ 48)) (QREFELT $ 49))))
                         ('T
                          (SEQ
                           (LETT |ba|
                                 (SPADCALL |a| (SPADCALL (QREFELT $ 48))
                                           (QREFELT $ 49)))
                           (EXIT
                            (LETT |b2|
                                  (SPADCALL
                                   (LIST |bx| (SPADCALL "=" (QREFELT $ 25))
                                         |bl| (SPADCALL ".." (QREFELT $ 25))
                                         |bu|)
                                   (QREFELT $ 32)))))))))))
                    (EXIT
                     (|FMT1D;formatFunction| "integral" (LIST |ba| |b2|)
                      $))))))))
          #2# (EXIT #1#)))) 

(SDEFUN |FMT1D;operatorWithLimits|
        ((|s| (|String|)) (|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT1D;operatorWithLimits!0| (VECTOR |s| $))))) 

(SDEFUN |FMT1D;operatorWithLimits!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |s|)
          (LETT $ (QREFELT $$ 1))
          (LETT |s| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|ba| NIL) (|bu| NIL) (|bl| NIL))
                   (SEQ
                    (LETT |bl|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 47)
                                     (QREFELT $ 46))
                           (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                    (LETT |ba|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                    (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |args| (QREFELT $ 57)) 2
                                 (QREFELT $ 58))
                       (COND
                        ((SPADCALL |bl| (QREFELT $ 50))
                         (|FMT1D;formatFunction| |s| (LIST |ba|) $))
                        ('T (|FMT1D;formatFunction| |s| (LIST |ba| |bl|) $))))
                      ('T
                       (SEQ (LETT |bu| |ba|)
                            (LETT |ba|
                                  (SPADCALL (SPADCALL |args| 3 (QREFELT $ 46))
                                            (SPADCALL (QREFELT $ 48))
                                            (QREFELT $ 49)))
                            (LETT |b2|
                                  (SPADCALL
                                   (LIST |bl| (SPADCALL " .. " (QREFELT $ 25))
                                         |bu|)
                                   (QREFELT $ 32)))
                            (EXIT
                             (|FMT1D;formatFunction| |s| (LIST |ba| |b2|)
                              $)))))))))))) 

(SDEFUN |FMT1D;sum;IM;15|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMT1D;operatorWithLimits| "sum" |p| $)) 

(SDEFUN |FMT1D;product;IM;16|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMT1D;operatorWithLimits| "product" |p| $)) 

(SDEFUN |FMT1D;theMap;ILOb;17|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG
         ((|p2| (|Integer|)) (|p1| (|Integer|)) (|s| (|String|))
          (|b| (|OutputBox|)) (|a| (|OutputForm|)))
         (SEQ (LETT |a| (|SPADfirst| |args|))
              (LETT |s|
                    (SEQ
                     (COND
                      ((SPADCALL |a| (QREFELT $ 36))
                       (COND
                        ((NULL (SPADCALL |a| (QREFELT $ 61)))
                         (COND
                          ((NULL (SPADCALL |a| (QREFELT $ 62)))
                           (EXIT ";?;")))))))
                     (LETT |b|
                           (SPADCALL |a| (SPADCALL (QREFELT $ 48))
                                     (QREFELT $ 49)))
                     (EXIT (|SPADfirst| (SPADCALL |b| (QREFELT $ 64))))))
              (LETT |p1| (SPADCALL (|STR_to_CHAR| ";") |s| (QREFELT $ 65)))
              (LETT |p2|
                    (SPADCALL (|STR_to_CHAR| ";") |s| (+ |p1| 1)
                              (QREFELT $ 66)))
              (EXIT
               (SPADCALL "theMap(" ")"
                         (SPADCALL
                          (SPADCALL |s|
                                    (SPADCALL (+ |p1| 1) (- |p2| 1)
                                              (QREFELT $ 18))
                                    (QREFELT $ 19))
                          (QREFELT $ 25))
                         (QREFELT $ 27)))))) 

(SDEFUN |FMT1D;overbar;I2M;18|
        ((|p| #1=(|Integer|))
         (|hh| (|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMT1D;overbar;I2M;18!0| (VECTOR $ |hh| |p|)))) 

(SDEFUN |FMT1D;overbar;I2M;18!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| |hh| $)
          (LETT |p| (QREFELT $$ 2))
          (LETT |hh| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|FMT1D;formatFunction| "overbar" (LIST (SPADCALL |p| |args| |hh|))
             $))))) 

(SDEFUN |FMT1D;box;2M;19|
        ((|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMT1D;box;2M;19!0| (VECTOR |hh| $)))) 

(SDEFUN |FMT1D;box;2M;19!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |hh|)
          (LETT $ (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|FMT1D;formatFunction| "box"
             (LIST
              (SPADCALL |prec|
                        (LIST
                         (SPADCALL |args| (|spadConstant| $ 47)
                                   (QREFELT $ 46)))
                        |hh|))
             $))))) 

(SDEFUN |FMT1D;nthRoot;I3M;20|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMT1D;nthRoot;I3M;20!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMT1D;nthRoot;I3M;20!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |h1| |h2|)
          (LETT |p| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |h1| (QREFELT $$ 1))
          (LETT |h2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bx| NIL))
                   (SEQ
                    (LETT |bx|
                          (SPADCALL |p|
                                    (LIST
                                     (SPADCALL |args| (|spadConstant| $ 47)
                                               (QREFELT $ 46)))
                                    |h1|))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |args| (QREFELT $ 57))
                                 (QREFELT $ 70))
                       (|FMT1D;formatFunction| "sqrt" (LIST |bx|) $))
                      ('T
                       (|FMT1D;formatFunction| "nthRoot"
                        (LIST |bx|
                              (SPADCALL |p|
                                        (LIST
                                         (SPADCALL |args| 2 (QREFELT $ 46)))
                                        |h2|))
                        $)))))))))) 

(SDEFUN |FMT1D;emptyArgument?| ((|a| (|OutputForm|)) ($ (|Boolean|)))
        (COND
         ((SPADCALL |a| (QREFELT $ 36))
          (COND
           ((SPADCALL |a| (QREFELT $ 61))
            (COND ((EQUAL (SPADCALL |a| (QREFELT $ 72)) " ") 'T)
                  (#1='T (EQUAL (SPADCALL |a| (QREFELT $ 72)) ""))))
           (#1# NIL)))
         (#1#
          (SPADCALL (SPADCALL |a| (QREFELT $ 39)) 'NOTHING (QREFELT $ 43))))) 

(SDEFUN |FMT1D;scripts;IM;22|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SEQ (CONS #'|FMT1D;scripts;IM;22!0| $))) 

(SDEFUN |FMT1D;scripts;IM;22!0| ((|prec| NIL) (|args| NIL) ($ NIL))
        (SPROG ((|bx| NIL) (#1=#:G822 NIL) (|a| NIL) (|b1| NIL))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| (QREFELT $ 54))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (LETT |args| (SPADCALL |args| (QREFELT $ 73)))
                (EXIT
                 (COND ((SPADCALL |args| (QREFELT $ 74)) |b1|)
                       ('T
                        (SEQ
                         (LETT |bx|
                               (SPADCALL (SPADCALL |args| (QREFELT $ 54))
                                         (SPADCALL (QREFELT $ 48))
                                         (QREFELT $ 49)))
                         (SEQ (LETT |a| NIL)
                              (LETT #1# (SPADCALL |args| (QREFELT $ 73))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |a| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((|FMT1D;emptyArgument?| |a| $)
                                  (LETT |bx|
                                        (SPADCALL
                                         (LIST |bx|
                                               (SPADCALL ", empty()$OutputForm"
                                                         (QREFELT $ 25)))
                                         (QREFELT $ 32))))
                                 ('T
                                  (LETT |bx|
                                        (SPADCALL
                                         (LIST |bx|
                                               (SPADCALL ", " (QREFELT $ 25))
                                               (SPADCALL |a|
                                                         (SPADCALL
                                                          (QREFELT $ 48))
                                                         (QREFELT $ 49)))
                                         (QREFELT $ 32)))))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                         (EXIT
                          (|FMT1D;formatFunction| "scripts"
                           (LIST |b1| (SPADCALL "[" "]" |bx| (QREFELT $ 27)))
                           $))))))))) 

(SDEFUN |FMT1D;subscript;IM;23|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SEQ (CONS #'|FMT1D;subscript;IM;23!0| $))) 

(SDEFUN |FMT1D;subscript;IM;23!0| ((|prec| NIL) (|args| NIL) ($ NIL))
        (SPROG ((|b2| NIL) (|b1| NIL))
               (SEQ
                (LETT |b1|
                      (SPADCALL
                       (SPADCALL |args| (|spadConstant| $ 47) (QREFELT $ 46))
                       (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (EXIT
                 (|FMT1D;formatFunction| "subscript"
                  (LIST |b1| (SPADCALL "[" "]" |b2| (QREFELT $ 27))) $))))) 

(SDEFUN |FMT1D;altsupersub;IM;24|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SEQ (CONS #'|FMT1D;altsupersub;IM;24!0| $))) 

(SDEFUN |FMT1D;altsupersub;IM;24!0| ((|prec| NIL) (|args| NIL) ($ NIL))
        (SPROG ((|bx| NIL) (#1=#:G833 NIL) (|a| NIL) (|b1| NIL))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| (QREFELT $ 54))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (LETT |args| (SPADCALL |args| (QREFELT $ 73)))
                (EXIT
                 (COND ((SPADCALL |args| (QREFELT $ 74)) |b1|)
                       ('T
                        (SEQ
                         (LETT |bx|
                               (SPADCALL (SPADCALL |args| (QREFELT $ 54))
                                         (SPADCALL (QREFELT $ 48))
                                         (QREFELT $ 49)))
                         (SEQ (LETT |a| NIL)
                              (LETT #1# (SPADCALL |args| (QREFELT $ 73))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |a| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((|FMT1D;emptyArgument?| |a| $)
                                  (LETT |bx|
                                        (SPADCALL
                                         (LIST |bx|
                                               (SPADCALL ", empty()$OutputForm"
                                                         (QREFELT $ 25)))
                                         (QREFELT $ 32))))
                                 ('T
                                  (LETT |bx|
                                        (SPADCALL
                                         (LIST |bx|
                                               (SPADCALL ", " (QREFELT $ 25))
                                               (SPADCALL |a|
                                                         (SPADCALL
                                                          (QREFELT $ 48))
                                                         (QREFELT $ 49)))
                                         (QREFELT $ 32)))))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                         (EXIT
                          (|FMT1D;formatFunction| "supersub"
                           (LIST |b1| (SPADCALL "[" "]" |bx| (QREFELT $ 27)))
                           $))))))))) 

(SDEFUN |FMT1D;prime;IM;25|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT1D;prime;IM;25!0| (VECTOR |p| $))))) 

(SDEFUN |FMT1D;prime;IM;25!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|n| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 47)
                                     (QREFELT $ 46))
                           (SPADCALL |p| (|spadConstant| $ 47) (QREFELT $ 78))
                           (QREFELT $ 49)))
                    (LETT |n|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                    (QREFELT $ 79)))
                    (EXIT
                     (COND
                      ((SPADCALL |n| (|spadConstant| $ 80) (QREFELT $ 82))
                       (|error| "error in PRIME expression"))
                      ('T
                       (SEQ
                        (LETT |b2|
                              (SPADCALL (SPADCALL |n| (QREFELT $ 83))
                                        (QREFELT $ 25)))
                        (EXIT
                         (|FMT1D;formatFunction| "prime" (LIST |b1| |b2|)
                          $)))))))))))) 

(SDEFUN |FMT1D;power;I3M;26|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ (CONS #'|FMT1D;power;I3M;26!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMT1D;power;I3M;26!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
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
                          (SPADCALL
                           (SPADCALL |p| (|spadConstant| $ 47) (QREFELT $ 78))
                           (LIST
                            (SPADCALL |args| (|spadConstant| $ 47)
                                      (QREFELT $ 46)))
                           |h1|))
                    (LETT |b2|
                          (SPADCALL
                           (SPADCALL |p| (|spadConstant| $ 47) (QREFELT $ 78))
                           (LIST (SPADCALL |args| 2 (QREFELT $ 46))) |h2|))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 82))
                               (SPADCALL
                                (LIST |b1| (SPADCALL "^" (QREFELT $ 25)) |b2|)
                                (QREFELT $ 32))
                               (QREFELT $ 85))))))))) 

(SDEFUN |FMT1D;fraction;I3M;27|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMT1D;fraction;I3M;27!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMT1D;fraction;I3M;27!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
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
                          (SPADCALL
                           (SPADCALL |p| (|spadConstant| $ 47) (QREFELT $ 78))
                           (LIST
                            (SPADCALL |args| (|spadConstant| $ 47)
                                      (QREFELT $ 46)))
                           |h1|))
                    (LETT |b2|
                          (SPADCALL
                           (SPADCALL |p| (|spadConstant| $ 47) (QREFELT $ 78))
                           (LIST (SPADCALL |args| 2 (QREFELT $ 46))) |h2|))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 82))
                               (SPADCALL
                                (LIST |b1| (SPADCALL "/" (QREFELT $ 25)) |b2|)
                                (QREFELT $ 32))
                               (QREFELT $ 85))))))))) 

(SDEFUN |FMT1D;slash;I3M;28|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL |p| |h1| |h2| (QREFELT $ 87))) 

(SDEFUN |FMT1D;binomial;ILOb;29|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|b2| #1=(|OutputBox|)) (|b1| #1#))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| 1 (QREFELT $ 46))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (EXIT (|FMT1D;formatFunction| "binomial" (LIST |b1| |b2|) $))))) 

(SDEFUN |FMT1D;zag;ILOb;30|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|b2| #1=(|OutputBox|)) (|b1| #1#))
               (SEQ
                (LETT |b1|
                      (SPADCALL (SPADCALL |args| 1 (QREFELT $ 46))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (LETT |b2|
                      (SPADCALL (SPADCALL |args| 2 (QREFELT $ 46))
                                (SPADCALL (QREFELT $ 48)) (QREFELT $ 49)))
                (EXIT (|FMT1D;formatFunction| "zag" (LIST |b1| |b2|) $))))) 

(SDEFUN |FMT1D;vconcat;2M;31|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "vconcat[" "]"
                  (SPADCALL ", " (SPADCALL (QREFELT $ 91))
                            (SPADCALL (SPADCALL (QREFELT $ 48)) (QREFELT $ 92))
                            (QREFELT $ 93))
                  (QREFELT $ 94))) 

(SDEFUN |FMT1D;pile;2M;32|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "pile[" "]"
                  (SPADCALL ", " (SPADCALL (QREFELT $ 91))
                            (SPADCALL (SPADCALL (QREFELT $ 48)) (QREFELT $ 92))
                            (QREFELT $ 93))
                  (QREFELT $ 94))) 

(SDEFUN |FMT1D;matrix;2SM;33|
        ((|left| #1=(|String|)) (|right| #1#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMT1D;matrix;2SM;33!0| (VECTOR |right| |left| $))))) 

(SDEFUN |FMT1D;matrix;2SM;33!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |left| |right|)
          (LETT $ (QREFELT $$ 2))
          (LETT |left| (QREFELT $$ 1))
          (LETT |right| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|entries| NIL))
                   (SEQ
                    (LETT |entries|
                          (SPADCALL |prec| (SPADCALL |args| (QREFELT $ 73))
                                    (SPADCALL ", " (SPADCALL (QREFELT $ 91))
                                              (SPADCALL
                                               (SPADCALL (QREFELT $ 48))
                                               (QREFELT $ 92))
                                              (QREFELT $ 93))))
                    (EXIT
                     (SPADCALL (SPADCALL "matrix" |left| (QREFELT $ 97))
                               |right| |entries| (QREFELT $ 27))))))))) 

(SDEFUN |FMT1D;setOperatorHandlers!|
        ((|oh|
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
         ($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (SPROG ((#1=#:G1260 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SPADCALL |oh| 0 "NOTHING" (SPADCALL (QREFELT $ 99))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 0 "%pi" (SPADCALL "%pi" (QREFELT $ 102))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 0 "%e" (SPADCALL "%e" (QREFELT $ 102))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 0 "%i" (SPADCALL "%i" (QREFELT $ 102))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 0 "%Infinity"
                            (SPADCALL "%Infinity" (QREFELT $ 102))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 0 "infinity"
                            (SPADCALL "%Infinity" (QREFELT $ 102))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 0 "..." (SPADCALL "..." (QREFELT $ 102))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "cos"
                            (SPADCALL "cos" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2="(" #3=")"
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "cot"
                            (SPADCALL "cot" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "csc"
                            (SPADCALL "csc" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "log"
                            (SPADCALL "log" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "sec"
                            (SPADCALL "sin" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "sin"
                            (SPADCALL "sin" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "tan"
                            (SPADCALL "tan" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "cosh"
                            (SPADCALL "cosh" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "coth"
                            (SPADCALL "coth" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "csch"
                            (SPADCALL "csch" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "sech"
                            (SPADCALL "sech" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "sinh"
                            (SPADCALL "sinh" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "tanh"
                            (SPADCALL "tanh" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "acos"
                            (SPADCALL "acos" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "asin"
                            (SPADCALL "asin" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "atan"
                            (SPADCALL "atan" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "erf"
                            (SPADCALL "erf" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "-"
                            (SPADCALL "-" 710 (SPADCALL 715 (QREFELT $ 92))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "not"
                            (SPADCALL "not " 710 (SPADCALL 715 (QREFELT $ 92))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "QUOTE"
                            (SPADCALL "quote" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "OVERBAR"
                            (SPADCALL (SPADCALL (QREFELT $ 91))
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 68))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "BOX"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 48))
                                       (QREFELT $ 92))
                             (QREFELT $ 69))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "Aleph"
                            (SPADCALL "Aleph" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "BRACE"
                            (SPADCALL "set" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL "[" "]"
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "BRACKET"
                            (SPADCALL "[" "]"
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 94))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "PAREN"
                            (SPADCALL "(" ")"
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 94))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "Gamma"
                            (SPADCALL "Gamma" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "ROOT"
                            (SPADCALL "sqrt" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "SEGMENT"
                            (SPADCALL "" " .. " (SPADCALL 990 (QREFELT $ 92))
                                      (QREFELT $ 94))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 1 "STRING"
                            (SPADCALL "\"" "\""
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 94))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "rem"
                            (SPADCALL " rem " 810 (SPADCALL 811 (QREFELT $ 92))
                                      (SPADCALL 811 (QREFELT $ 92))
                                      (QREFELT $ 104))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "quo"
                            (SPADCALL " quo " 810 (SPADCALL 811 (QREFELT $ 92))
                                      (SPADCALL 811 (QREFELT $ 92))
                                      (QREFELT $ 104))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "exquo"
                            (SPADCALL " exquo " 810
                                      (SPADCALL 811 (QREFELT $ 92))
                                      (SPADCALL 811 (QREFELT $ 92))
                                      (QREFELT $ 104))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "^"
                            (SPADCALL 950 (SPADCALL 960 (QREFELT $ 92))
                                      (SPADCALL 960 (QREFELT $ 92))
                                      (QREFELT $ 86))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "/"
                            (SPADCALL 910 (SPADCALL 910 (QREFELT $ 92))
                                      (SPADCALL 910 (QREFELT $ 92))
                                      (QREFELT $ 87))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "OVER"
                            (SPADCALL 910 (SPADCALL 910 (QREFELT $ 92))
                                      (SPADCALL 910 (QREFELT $ 92))
                                      (QREFELT $ 87))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "SLASH"
                            (SPADCALL 910 (SPADCALL 910 (QREFELT $ 92))
                                      (SPADCALL 910 (QREFELT $ 92))
                                      (QREFELT $ 88))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "ZAG" (ELT $ 90) (QREFELT $ 101))
                  (SPADCALL |oh| 2 "BINOMIAL" (ELT $ 89) (QREFELT $ 101))
                  (SPADCALL |oh| 2 "PRIME"
                            (SPADCALL (SPADCALL (QREFELT $ 91)) (QREFELT $ 84))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "ROOT"
                            (SPADCALL 970
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 71))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "SUB" (SPADCALL 950 (QREFELT $ 76))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "SEGMENT"
                            (SPADCALL " .. " 100 (SPADCALL 100 (QREFELT $ 92))
                                      (SPADCALL 100 (QREFELT $ 92))
                                      (QREFELT $ 104))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "TENSOR"
                            (SPADCALL "tensor" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #4="(" #5=")"
                                                (SPADCALL #6=", "
                                                          (SPADCALL
                                                           (QREFELT $ 91))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 48))
                                                           (QREFELT $ 92))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 48))
                                                           (QREFELT $ 92))
                                                          (QREFELT $ 104))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "EQUATNUM"
                            (SPADCALL "\\EQUATNUM" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #4# #5#
                                                (SPADCALL #6#
                                                          (SPADCALL
                                                           (QREFELT $ 91))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 48))
                                                           (QREFELT $ 92))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 48))
                                                           (QREFELT $ 92))
                                                          (QREFELT $ 104))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "OVERLABEL"
                            (SPADCALL "\\OVERLABEL" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL #4# #5#
                                                (SPADCALL #6#
                                                          (SPADCALL
                                                           (QREFELT $ 91))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 48))
                                                           (QREFELT $ 92))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 48))
                                                           (QREFELT $ 92))
                                                          (QREFELT $ 104))
                                                (QREFELT $ 94))
                                      (QREFELT $ 103))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "=="
                            (SPADCALL "==" 400 (SPADCALL 401 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "="
                            (SPADCALL "=" 400 (SPADCALL 400 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "~="
                            (SPADCALL "~= " 400 (SPADCALL 400 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "<"
                            (SPADCALL "<" 400 (SPADCALL 400 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 ">"
                            (SPADCALL ">" 400 (SPADCALL 400 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "<="
                            (SPADCALL "<=" 400 (SPADCALL 400 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 ">="
                            (SPADCALL ">=" 400 (SPADCALL 400 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "and"
                            (SPADCALL " and " 300 (SPADCALL 300 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "or"
                            (SPADCALL " or " 200 (SPADCALL 200 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "LET"
                            (SPADCALL ":=" 125 (SPADCALL 125 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "TAG"
                            (SPADCALL " -> " 100 (SPADCALL 100 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "+->"
                            (SPADCALL " +-> " 100 (SPADCALL 100 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "|"
                            (SPADCALL " | " 100 (SPADCALL 100 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "SIGMA" (SPADCALL 750 (QREFELT $ 59))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 2 "PI" (SPADCALL 750 (QREFELT $ 60))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 3 "SIGMA2" (SPADCALL 750 (QREFELT $ 59))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 3 "PI2" (SPADCALL 750 (QREFELT $ 60))
                            (QREFELT $ 101))
                  (SPADCALL |oh| 3 "INTSIGN" (SPADCALL 700 (QREFELT $ 56))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "+"
                            (SPADCALL "+" "-" 700 (SPADCALL 700 (QREFELT $ 92))
                                      (QREFELT $ 105))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "-"
                            (SPADCALL "+" "-" 700 (SPADCALL 700 (QREFELT $ 92))
                                      (QREFELT $ 105))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "*"
                            (SPADCALL "*" 800 (SPADCALL 800 (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "AGGLST"
                            (SPADCALL ", " (SPADCALL (QREFELT $ 91))
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "AGGSET"
                            (SPADCALL "; " (SPADCALL (QREFELT $ 91))
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "CONCAT"
                            (SPADCALL "" (SPADCALL (QREFELT $ 91))
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "CONCATB"
                            (SPADCALL " " (SPADCALL (QREFELT $ 91))
                                      (SPADCALL (SPADCALL (QREFELT $ 48))
                                                (QREFELT $ 92))
                                      (QREFELT $ 93))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "ALTSUPERSUB" (SPADCALL 900 (QREFELT $ 77))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "SUPERSUB" (SPADCALL 900 (QREFELT $ 75))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "SC"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 48))
                                       (QREFELT $ 92))
                             (QREFELT $ 96))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "VCONCAT"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 48))
                                       (QREFELT $ 92))
                             (QREFELT $ 95))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "ROW"
                            (SPADCALL "[" "]"
                                      (SPADCALL ", " (SPADCALL (QREFELT $ 91))
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 48))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 93))
                                      (QREFELT $ 94))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "MATRIX" (SPADCALL "[" "]" (QREFELT $ 98))
                            (QREFELT $ 101))
                  (SPADCALL |oh| -1 "theMap" (ELT $ 67) (QREFELT $ 101))
                  (EXIT (PROGN (LETT #1# |oh|) (GO #7=#:G1259)))))
                #7# (EXIT #1#)))) 

(SDEFUN |FMT1D;operatorHandlers;Oh;35|
        (($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (QREFELT $ 107)) 

(DECLAIM (NOTINLINE |Format1D;|)) 

(DEFUN |Format1D| ()
  (SPROG NIL
         (PROG (#1=#:G1263)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Format1D|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Format1D|
                             (LIST (CONS NIL (CONS 1 (|Format1D;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Format1D|)))))))))) 

(DEFUN |Format1D;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Format1D|))
          (LETT $ (GETREFV 109))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Format1D| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 107
                    (|FMT1D;setOperatorHandlers!| (SPADCALL (QREFELT $ 106))
                     $))
          $))) 

(MAKEPROP '|Format1D| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) |FMT1D;coerce;$Of;1|
              (|OutputBox|) (0 . |empty|) (|String|)
              |FMT1D;defaultPrologue;SOb;2| |FMT1D;defaultEpilogue;SOb;3|
              (|CharacterClass|) (4 . |charClass|) (|Integer|) (9 . |position|)
              (|UniversalSegment| 15) (16 . SEGMENT) (22 . |elt|) (|Character|)
              (28 . |elt|) (34 . |concat|) (40 . |char|) (45 . |remove|)
              (51 . |box|) |FMT1D;formatFloat;SOb;5|
              |FMT1D;parenthesize;2S2Ob;9| |FMT1D;formatString;SOb;6|
              |FMT1D;formatSymbol;SOb;7| |FMT1D;formatFunctionSymbol;SOb;8|
              (|List| $) (56 . |hconcat|) (|Boolean|) (61 . =)
              (|OutputFormTools|) (67 . |atom?|) (|List| 6) (72 . |arguments|)
              (77 . |operator|) (82 . |elt|) (88 . |empty|) (|Symbol|)
              (92 . |is_symbol?|) (|NonNegativeInteger|) (98 . ~=)
              (104 . |elt|) (110 . |One|) (114 . |minPrecedence|)
              (118 . |formatExpression|) (124 . |empty?|) (|List| 8)
              (129 . |concat|) (135 . ~=) (141 . |first|) (|Mapping| 8 15 37)
              |FMT1D;integral;IM;13| (146 . |#|) (151 . =) |FMT1D;sum;IM;15|
              |FMT1D;product;IM;16| (157 . |string?|) (162 . |symbol?|)
              (|List| 10) (167 . |lines|) (172 . |position|) (178 . |position|)
              |FMT1D;theMap;ILOb;17| |FMT1D;overbar;I2M;18| |FMT1D;box;2M;19|
              (185 . |one?|) |FMT1D;nthRoot;I3M;20| (190 . |string|)
              (195 . |rest|) (200 . |empty?|) |FMT1D;scripts;IM;22|
              |FMT1D;subscript;IM;23| |FMT1D;altsupersub;IM;24| (205 . +)
              (211 . |numberOfPrimes|) (216 . |Zero|) (220 . |Zero|) (224 . <)
              (230 . |convert|) |FMT1D;prime;IM;25| (235 . |parenthesizeIf|)
              |FMT1D;power;I3M;26| |FMT1D;fraction;I3M;27| |FMT1D;slash;I3M;28|
              |FMT1D;binomial;ILOb;29| |FMT1D;zag;ILOb;30|
              (241 . |maxPrecedence|) (245 . |formatExpression|) (250 . |nary|)
              (257 . |bracket|) |FMT1D;vconcat;2M;31| |FMT1D;pile;2M;32|
              (264 . |concat|) |FMT1D;matrix;2SM;33| (270 . |nothing|)
              (|OperatorHandlers| 55) (274 . |setHandler!|)
              (282 . |formatConstant|) (287 . |prefix|) (294 . |infix|)
              (302 . |naryPlus|) (310 . |new|) '|operatorData|
              |FMT1D;operatorHandlers;Oh;35|)
           '#(|zag| 314 |vconcat| 320 |theMap| 325 |sum| 331 |subscript| 336
              |slash| 341 |scripts| 348 |product| 353 |prime| 358 |prefix| 363
              |precedence| 370 |power| 376 |pile| 383 |parenthesizeIf| 388
              |parenthesize| 394 |overbar| 401 |operatorHandlers| 407
              |numberOfPrimes| 411 |nthRoot| 416 |nothing| 423 |naryPlus| 427
              |nary| 435 |minPrecedence| 442 |maxPrecedence| 446 |matrix| 450
              |integral| 456 |infix| 461 |fraction| 469 |formatSymbol| 476
              |formatString| 481 |formatInteger| 486 |formatFunctionSymbol| 491
              |formatFloat| 496 |formatExpression| 501 |formatConstant| 517
              |defaultPrologue| 522 |defaultEpilogue| 527 |coerce| 532
              |bracket| 537 |box| 544 |binomial| 549 |binary| 555 |altsupersub|
              561)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(|FormatterCategory&| NIL)
                       (CONS '#((|FormatterCategory|) (|CoercibleTo| 6))
                             (|makeByteWordVec2| 108
                                                 '(0 8 0 9 1 13 0 10 14 3 10 15
                                                   13 0 15 16 2 17 0 15 15 18 2
                                                   10 0 0 17 19 2 10 20 0 15 21
                                                   2 10 0 0 20 22 1 20 0 10 23
                                                   2 10 0 20 0 24 1 8 0 10 25 1
                                                   8 0 31 32 2 6 33 0 0 34 1 35
                                                   33 6 36 1 35 37 6 38 1 35 6
                                                   6 39 2 6 0 0 31 40 0 6 0 41
                                                   2 35 33 6 42 43 2 44 33 0 0
                                                   45 2 37 6 0 15 46 0 15 0 47
                                                   0 0 15 48 2 0 8 6 15 49 1 8
                                                   33 0 50 2 51 0 0 8 52 2 6 33
                                                   0 0 53 1 37 6 0 54 1 37 44 0
                                                   57 2 44 33 0 0 58 1 35 33 6
                                                   61 1 35 33 6 62 1 8 63 0 64
                                                   2 10 15 20 0 65 3 10 15 20 0
                                                   15 66 1 15 33 0 70 1 35 10 6
                                                   72 1 37 0 0 73 1 37 33 0 74
                                                   2 15 0 0 0 78 1 0 15 6 79 0
                                                   44 0 80 0 15 0 81 2 15 33 0
                                                   0 82 1 15 10 0 83 2 0 8 33 8
                                                   85 0 0 15 91 1 0 55 15 92 3
                                                   0 55 10 15 55 93 3 0 55 10
                                                   10 55 94 2 10 0 0 0 97 0 0
                                                   55 99 4 100 55 0 15 10 55
                                                   101 1 0 55 10 102 3 0 55 10
                                                   15 55 103 4 0 55 10 15 55 55
                                                   104 4 0 55 10 10 15 55 105 0
                                                   100 0 106 2 0 8 15 37 90 1 0
                                                   55 55 95 2 0 8 15 37 67 1 0
                                                   55 15 59 1 0 55 15 76 3 0 55
                                                   15 55 55 88 1 0 55 15 75 1 0
                                                   55 15 60 1 0 55 15 84 3 0 55
                                                   10 15 55 103 2 0 55 15 55 1
                                                   3 0 55 15 55 55 86 1 0 55 55
                                                   96 2 0 8 33 8 85 3 0 8 10 10
                                                   8 27 2 0 55 15 55 68 0 0 100
                                                   108 1 0 15 6 79 3 0 55 15 55
                                                   55 71 0 0 55 99 4 0 55 10 10
                                                   15 55 105 3 0 55 10 15 55 93
                                                   0 0 15 48 0 0 15 91 2 0 55
                                                   10 10 98 1 0 55 15 56 4 0 55
                                                   10 15 55 55 104 3 0 55 15 55
                                                   55 87 1 0 8 10 29 1 0 8 10
                                                   28 1 0 8 15 1 1 0 8 10 30 1
                                                   0 8 10 26 1 0 55 15 92 1 0 8
                                                   6 1 2 0 8 6 15 49 1 0 55 10
                                                   102 1 0 8 10 11 1 0 8 10 12
                                                   1 0 6 0 7 3 0 55 10 10 55 94
                                                   1 0 55 55 69 2 0 8 15 37 89
                                                   2 0 55 55 55 1 1 0 55 15
                                                   77)))))
           '|lookupComplete|)) 

(MAKEPROP '|Format1D| 'NILADIC T) 
