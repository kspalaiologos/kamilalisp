
(PUT '|FMTCAT-;minPrecedence;I;1| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |FMTCAT-;minPrecedence;I;1| (($ (|Integer|))) 0) 

(PUT '|FMTCAT-;maxPrecedence;I;2| '|SPADreplace| '(XLAM NIL 10000)) 

(SDEFUN |FMTCAT-;maxPrecedence;I;2| (($ (|Integer|))) 10000) 

(SDEFUN |FMTCAT-;numberOfPrimes;OfI;3| ((|a2| (|OutputForm|)) ($ (|Integer|)))
        (SPROG
         ((|aa2| (|List| (|OutputForm|))) (|o2| (|String|))
          (|opex| (|OutputForm|)) (#1=#:G757 NIL) (#2=#:G758 NIL) (|i| NIL)
          (|n| (|NonNegativeInteger|)) (|s2| (|String|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |a2| (QREFELT $ 13))
             (COND
              ((NULL (SPADCALL |a2| (QREFELT $ 14)))
               (PROGN (LETT #1# -1) (GO #3=#:G756)))
              ('T
               (SEQ (LETT |s2| (SPADCALL |a2| (QREFELT $ 16)))
                    (LETT |n| (QCSIZE |s2|))
                    (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |s2| |i| (QREFELT $ 18))
                                       (|STR_to_CHAR| ",") (QREFELT $ 19))
                             (PROGN (LETT #1# -1) (GO #3#))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (PROGN (LETT #1# |n|) (GO #3#)))))))
            ('T
             (SEQ (LETT |opex| (SPADCALL |a2| (QREFELT $ 20)))
                  (COND ((NULL (SPADCALL |opex| (QREFELT $ 21))) (EXIT -1)))
                  (LETT |o2|
                        (SPADCALL (SPADCALL |opex| (QREFELT $ 23))
                                  (QREFELT $ 24)))
                  (EXIT
                   (COND
                    ((OR (SPADCALL |o2| "PAREN" (QREFELT $ 25))
                         (OR
                          (>
                           (LENGTH (LETT |aa2| (SPADCALL |a2| (QREFELT $ 27))))
                           1)
                          (NULL
                           (SPADCALL (|SPADfirst| |aa2|) (QREFELT $ 14)))))
                     -1)
                    ('T
                     (SPADCALL (SPADCALL (|SPADfirst| |aa2|) (QREFELT $ 16))
                               (QREFELT $ 30)))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |FMTCAT-;float?| ((|s| (|String|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G788 NIL) (|i| (|Integer|)) (#2=#:G786 NIL) (#3=#:G787 NIL)
          (|n| (|NonNegativeInteger|)) (#4=#:G789 NIL) (|d| (|Integer|)))
         (SEQ
          (EXIT
           (COND
            ((ZEROP
              (LETT |d| (SPADCALL (|STR_to_CHAR| ".") |s| (QREFELT $ 33))))
             NIL)
            (#5='T
             (SEQ
              (SEQ (LETT |i| 1) (LETT #4# (- |d| 1)) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |s| |i| (QREFELT $ 18))
                                  (QREFELT $ 34)))
                       (PROGN (LETT #1# NIL) (GO #6=#:G785))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |i| (+ |d| 1)) (LETT |n| (QCSIZE |s|))
              (LETT |s| (COPY-SEQ |s|))
              (SEQ G190 (COND ((NULL (<= |i| |n|)) (GO G191)))
                   (SEQ
                    (COND
                     ((|eql_SI| (SPADCALL |s| |i| (QREFELT $ 18))
                                (|STR_to_CHAR| "_"))
                      (SEQ
                       (SPADCALL |s| |i| (SPADCALL (QREFELT $ 35))
                                 (QREFELT $ 36))
                       (EXIT (LETT |i| (+ |i| 1))))))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |i| (+ |d| 1))
              (SEQ
               (EXIT
                (SEQ G190 (COND ((NULL (<= |i| |n|)) (GO G191)))
                     (SEQ
                      (COND
                       ((NULL
                         (SPADCALL (SPADCALL |s| |i| (QREFELT $ 18))
                                   (QREFELT $ 34)))
                        (COND
                         ((NULL
                           (|eql_SI| (SPADCALL |s| |i| (QREFELT $ 18))
                                     (SPADCALL (QREFELT $ 35))))
                          (PROGN (LETT #3# |$NoValue|) (GO #7=#:G773))))))
                      (EXIT (LETT |i| (+ |i| 1))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #7# (EXIT #3#))
              (EXIT
               (COND ((> |i| |n|) (PROGN (LETT #1# 'T) (GO #6#)))
                     ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 18))
                                (|STR_to_CHAR| "E") (QREFELT $ 19))
                      NIL)
                     (#5#
                      (SEQ
                       (SEQ
                        (EXIT
                         (SEQ G190 (COND ((NULL (< |i| |n|)) (GO G191)))
                              (SEQ (LETT |i| (+ |i| 1))
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |s| |i| (QREFELT $ 18))
                                       (SPADCALL (QREFELT $ 35))
                                       (QREFELT $ 19))
                                      (PROGN (LETT #2# 1) (GO #8=#:G776))))))
                              NIL (GO G190) G191 (EXIT NIL)))
                        #8# (EXIT #2#))
                       (COND
                        ((|eql_SI| (SPADCALL |s| |i| (QREFELT $ 18))
                                   (|STR_to_CHAR| "-"))
                         (LETT |i| (+ |i| 1))))
                       (SEQ G190 (COND ((NULL (<= |i| |n|)) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL (SPADCALL |s| |i| (QREFELT $ 18))
                                          (QREFELT $ 34))
                                (LETT |i| (+ |i| 1)))
                               ('T (PROGN (LETT #1# NIL) (GO #6#))))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (PROGN (LETT #1# 'T) (GO #6#)))))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |FMTCAT-;formatInteger;IOb;5| ((|n| (|Integer|)) ($ (|OutputBox|)))
        (SPADCALL (STRINGIMAGE |n|) (QREFELT $ 38))) 

(SDEFUN |FMTCAT-;formatFloat;SOb;6| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 38))) 

(SDEFUN |FMTCAT-;formatString;SOb;7| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 38))) 

(SDEFUN |FMTCAT-;formatSymbol;SOb;8| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 38))) 

(SDEFUN |FMTCAT-;formatFunctionSymbol;SOb;9|
        ((|s| (|String|)) ($ (|OutputBox|))) (SPADCALL |s| (QREFELT $ 38))) 

(SDEFUN |FMTCAT-;formatFunction|
        ((|b| (|OutputBox|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|a| (|OutputBox|)) (|m| (|Integer|)))
               (SEQ (LETT |m| (SPADCALL (QREFELT $ 44)))
                    (LETT |a|
                          (SPADCALL |m| |args|
                                    (SPADCALL ", " (SPADCALL (QREFELT $ 45))
                                              (SPADCALL |m| (QREFELT $ 47))
                                              (QREFELT $ 48))))
                    (EXIT
                     (SPADCALL (LIST |b| (SPADCALL "(" ")" |a| (QREFELT $ 49)))
                               (QREFELT $ 51)))))) 

(SDEFUN |FMTCAT-;parenthesizeIf;B2Ob;11|
        ((|needParen?| (|Boolean|)) (|bx| (|OutputBox|)) ($ (|OutputBox|)))
        (COND (|needParen?| (SPADCALL "(" ")" |bx| (QREFELT $ 49))) ('T |bx|))) 

(SDEFUN |FMTCAT-;formatExpression;OfIOb;12|
        ((|expr| (|OutputForm|)) (|prec| (|Integer|)) ($ (|OutputBox|)))
        (SPROG
         ((|op| #1=(|String|)) (|nargs| (|Integer|))
          (|args| (|List| (|OutputForm|))) (|opex| (|OutputForm|)) (|str| #1#)
          (|s| (|String|))
          (|operatorData|
           (|OperatorHandlers|
            (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
         (SEQ (LETT |operatorData| (SPADCALL (QREFELT $ 54)))
              (EXIT
               (COND
                ((SPADCALL |expr| (QREFELT $ 13))
                 (COND
                  ((SPADCALL |expr| (QREFELT $ 55))
                   (SPADCALL (SPADCALL |expr| (QREFELT $ 56)) (QREFELT $ 57)))
                  ((SPADCALL |expr| (QREFELT $ 14))
                   (SEQ (LETT |s| (SPADCALL |expr| (QREFELT $ 16)))
                        (EXIT
                         (COND
                          ((|FMTCAT-;float?| |s| $)
                           (SPADCALL |s| (QREFELT $ 58)))
                          (#2='T (SPADCALL |s| (QREFELT $ 59)))))))
                  ((NULL (SPADCALL |expr| (QREFELT $ 21)))
                   (SPADCALL "[[BAD OUTPUTFORM]]" (QREFELT $ 38)))
                  ('T
                   (SEQ
                    (LETT |str|
                          (SPADCALL (SPADCALL |expr| (QREFELT $ 23))
                                    (QREFELT $ 24)))
                    (EXIT
                     (COND
                      ((SPADCALL |operatorData| 0 |str| (QREFELT $ 60))
                       (SPADCALL |prec| NIL
                                 (SPADCALL |operatorData| 0 |str|
                                           (QREFELT $ 61))))
                      (#2# (SPADCALL |str| (QREFELT $ 62)))))))))
                (#2#
                 (SEQ (LETT |opex| (SPADCALL |expr| (QREFELT $ 20)))
                      (LETT |args| (SPADCALL |expr| (QREFELT $ 27)))
                      (COND
                       ((NULL (SPADCALL |opex| (QREFELT $ 21)))
                        (EXIT
                         (|FMTCAT-;formatFunction|
                          (SPADCALL |opex| (SPADCALL (QREFELT $ 44))
                                    (QREFELT $ 63))
                          |args| $))))
                      (LETT |nargs| (LENGTH |args|))
                      (LETT |op|
                            (SPADCALL (SPADCALL |opex| (QREFELT $ 23))
                                      (QREFELT $ 24)))
                      (EXIT
                       (COND
                        ((SPADCALL |operatorData| |nargs| |op| (QREFELT $ 60))
                         (SPADCALL |prec| |args|
                                   (SPADCALL |operatorData| |nargs| |op|
                                             (QREFELT $ 61))))
                        ((SPADCALL |operatorData| -1 |op| (QREFELT $ 60))
                         (SPADCALL |prec| |args|
                                   (SPADCALL |operatorData| -1 |op|
                                             (QREFELT $ 61))))
                        (#2#
                         (|FMTCAT-;formatFunction|
                          (SPADCALL |op| (QREFELT $ 64)) |args| $))))))))))) 

(SDEFUN |FMTCAT-;formatExpression;OfOb;13|
        ((|expr| (|OutputForm|)) ($ (|OutputBox|)))
        (SPADCALL |expr| (SPADCALL (QREFELT $ 44)) (QREFELT $ 63))) 

(SDEFUN |FMTCAT-;nothing;M;14|
        (($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (CONS #'|FMTCAT-;nothing;M;14!0| $)) 

(SDEFUN |FMTCAT-;nothing;M;14!0| ((|prec| NIL) (|args| NIL) ($ NIL))
        (SPADCALL (QREFELT $ 67))) 

(SDEFUN |FMTCAT-;formatConstant;SM;15|
        ((|op| (|String|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTCAT-;formatConstant;SM;15!0| (VECTOR $ |op|)))) 

(SDEFUN |FMTCAT-;formatConstant;SM;15!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|op| $)
          (LETT |op| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |op| (QREFELT $ 38)))))) 

(SDEFUN |FMTCAT-;formatExpression;IM;16|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTCAT-;formatExpression;IM;16!0| (VECTOR |p| $)))) 

(SDEFUN |FMTCAT-;formatExpression;IM;16!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |args| (QREFELT $ 70)) |p| (QREFELT $ 63)))))) 

(SDEFUN |FMTCAT-;precedence;I2M;17|
        ((|p| (|Integer|))
         (|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMTCAT-;precedence;I2M;17!0| (VECTOR |h| |p|)))) 

(SDEFUN |FMTCAT-;precedence;I2M;17!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| |h|)
          (LETT |p| (QREFELT $$ 1))
          (LETT |h| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |p| |args| |h|))))) 

(SDEFUN |FMTCAT-;bracket;2S2M;18|
        ((|left| (|String|)) (|right| (|String|))
         (|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (CONS #'|FMTCAT-;bracket;2S2M;18!0|
                     (VECTOR $ |h| |right| |left|)))) 

(SDEFUN |FMTCAT-;bracket;2S2M;18!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|left| |right| |h| $)
          (LETT |left| (QREFELT $$ 3))
          (LETT |right| (QREFELT $$ 2))
          (LETT |h| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |left| |right| (SPADCALL |prec| |args| |h|)
                      (QREFELT $ 49)))))) 

(SDEFUN |FMTCAT-;prefix;SI2M;19|
        ((|op| (|String|)) (|p| (|Integer|))
         (|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (CONS #'|FMTCAT-;prefix;SI2M;19!0| (VECTOR |hh| |op| $ |p|)))) 

(SDEFUN |FMTCAT-;prefix;SI2M;19!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |op| |hh|)
          (LETT |p| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |op| (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 74))
                      (SPADCALL
                       (LIST (SPADCALL |op| (QREFELT $ 38))
                             (SPADCALL |prec| |args| |hh|))
                       (QREFELT $ 51))
                      (QREFELT $ 75)))))) 

(SDEFUN |FMTCAT-;infix;SI3M;20|
        ((|op| (|String|)) (|p| (|Integer|))
         (|h1| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         (|h2| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTCAT-;infix;SI3M;20!0|
                      (VECTOR |op| |p| |h2| |h1| $))))) 

(SDEFUN |FMTCAT-;infix;SI3M;20!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |h1| |h2| |p| |op|)
          (LETT $ (QREFELT $$ 4))
          (LETT |h1| (QREFELT $$ 3))
          (LETT |h2| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT |op| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL |prec|
                                    (LIST
                                     (SPADCALL |args| (|spadConstant| $ 77)
                                               (QREFELT $ 78)))
                                    |h1|))
                    (LETT |b2|
                          (SPADCALL |prec|
                                    (LIST (SPADCALL |args| 2 (QREFELT $ 78)))
                                    |h2|))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 74))
                               (SPADCALL
                                (LIST |b1| (SPADCALL |op| (QREFELT $ 38)) |b2|)
                                (QREFELT $ 51))
                               (QREFELT $ 75))))))))) 

(SDEFUN |FMTCAT-;binary;3M;21|
        ((|h1| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         (|h2| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL "" (SPADCALL (QREFELT $ 45)) |h1| |h2| (QREFELT $ 80))) 

(SDEFUN |FMTCAT-;nary;SI2M;22|
        ((|sep| (|String|)) (|p| (|Integer|))
         (|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTCAT-;nary;SI2M;22!0| (VECTOR |hh| |p| |sep| $))))) 

(SDEFUN |FMTCAT-;nary;SI2M;22!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |sep| |p| |hh|)
          (LETT $ (QREFELT $$ 3))
          (LETT |sep| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|l| NIL) (#1=#:G839 NIL) (|a| NIL) (|sepbox| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |args| (QREFELT $ 82))
                      (SPADCALL "" (QREFELT $ 38)))
                     ('T
                      (SEQ (LETT |sepbox| (SPADCALL |sep| (QREFELT $ 38)))
                           (LETT |l|
                                 (LIST
                                  (SPADCALL |p|
                                            (LIST
                                             (SPADCALL |args| (QREFELT $ 70)))
                                            |hh|)))
                           (SEQ (LETT |a| NIL)
                                (LETT #1# (SPADCALL |args| (QREFELT $ 83)))
                                G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |a| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |l|
                                        (SPADCALL
                                         (SPADCALL |prec| (LIST |a|) |hh|)
                                         (SPADCALL |sepbox| |l| (QREFELT $ 85))
                                         (QREFELT $ 85)))))
                                (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 74))
                                      (SPADCALL (SPADCALL |l| (QREFELT $ 86))
                                                (QREFELT $ 51))
                                      (QREFELT $ 75)))))))))))) 

(SDEFUN |FMTCAT-;unaryMinus?| ((|a| (|OutputForm|)) ($ (|Boolean|)))
        (SPROG ((|opa| (|OutputForm|)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 13)) NIL)
                      (#1='T
                       (SEQ (LETT |opa| (SPADCALL |a| (QREFELT $ 20)))
                            (COND
                             ((NULL (SPADCALL |opa| (QREFELT $ 21)))
                              (EXIT NIL)))
                            (EXIT
                             (COND
                              ((EQUAL
                                (SPADCALL (SPADCALL |opa| (QREFELT $ 23))
                                          (QREFELT $ 24))
                                "-")
                               (EQL (LENGTH (SPADCALL |a| (QREFELT $ 27))) 1))
                              (#1# NIL))))))))) 

(SDEFUN |FMTCAT-;naryPlus;2SI2M;24|
        ((|plus| (|String|)) (|minus| (|String|)) (|p| (|Integer|))
         (|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMTCAT-;naryPlus;2SI2M;24!0|
                      (VECTOR |plus| |minus| |hh| |p| $))))) 

(SDEFUN |FMTCAT-;naryPlus;2SI2M;24!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p| |hh| |minus| |plus|)
          (LETT $ (QREFELT $$ 4))
          (LETT |p| (QREFELT $$ 3))
          (LETT |hh| (QREFELT $$ 2))
          (LETT |minus| (QREFELT $$ 1))
          (LETT |plus| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|l| NIL) (|sep| NIL) (|a| NIL) (#1=#:G853 NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |args| (QREFELT $ 82))
                      (SPADCALL (QREFELT $ 67)))
                     ('T
                      (SEQ
                       (LETT |l|
                             (LIST
                              (SPADCALL |p|
                                        (LIST (SPADCALL |args| (QREFELT $ 70)))
                                        |hh|)))
                       (SEQ (LETT |a| NIL)
                            (LETT #1# (SPADCALL |args| (QREFELT $ 83))) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (COND
                              ((|FMTCAT-;unaryMinus?| |a| $)
                               (SEQ
                                (LETT |sep| (SPADCALL |minus| (QREFELT $ 38)))
                                (EXIT
                                 (LETT |a|
                                       (SPADCALL (SPADCALL |a| (QREFELT $ 27))
                                                 (QREFELT $ 70))))))
                              ('T
                               (LETT |sep| (SPADCALL |plus| (QREFELT $ 38)))))
                             (EXIT
                              (LETT |l|
                                    (SPADCALL (SPADCALL |p| (LIST |a|) |hh|)
                                              (SPADCALL |sep| |l|
                                                        (QREFELT $ 85))
                                              (QREFELT $ 85)))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 74))
                                  (SPADCALL (SPADCALL |l| (QREFELT $ 86))
                                            (QREFELT $ 51))
                                  (QREFELT $ 75)))))))))))) 

(DECLAIM (NOTINLINE |FormatterCategory&;|)) 

(DEFUN |FormatterCategory&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FormatterCategory&| DV$1))
          (LETT $ (GETREFV 89))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FormatterCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              |FMTCAT-;minPrecedence;I;1| |FMTCAT-;maxPrecedence;I;2|
              (|Boolean|) (|OutputForm|) (|OutputFormTools|) (0 . |atom?|)
              (5 . |string?|) (|String|) (10 . |string|) (|Character|)
              (15 . |elt|) (21 . ~=) (27 . |operator|) (32 . |symbol?|)
              (|Symbol|) (37 . |symbol|) (42 . |string|) (47 . ~=) (|List| 11)
              (53 . |arguments|) (|PositiveInteger|) (|NumberFormats|)
              (58 . |ScanRoman|) |FMTCAT-;numberOfPrimes;OfI;3| (63 . |char|)
              (68 . |position|) (74 . |digit?|) (79 . |space|) (83 . |setelt!|)
              (|OutputBox|) (90 . |box|) |FMTCAT-;formatInteger;IOb;5|
              |FMTCAT-;formatFloat;SOb;6| |FMTCAT-;formatString;SOb;7|
              |FMTCAT-;formatSymbol;SOb;8| |FMTCAT-;formatFunctionSymbol;SOb;9|
              (95 . |minPrecedence|) (99 . |maxPrecedence|) (|Mapping| 37 7 26)
              (103 . |formatExpression|) (108 . |nary|) (115 . |parenthesize|)
              (|List| $) (122 . |hconcat|) |FMTCAT-;parenthesizeIf;B2Ob;11|
              (|OperatorHandlers| 46) (127 . |operatorHandlers|)
              (131 . |integer?|) (136 . |integer|) (141 . |formatInteger|)
              (146 . |formatFloat|) (151 . |formatString|)
              (156 . |knownHandler?|) (163 . |handler|) (170 . |formatSymbol|)
              (175 . |formatExpression|) (181 . |formatFunctionSymbol|)
              |FMTCAT-;formatExpression;OfIOb;12|
              |FMTCAT-;formatExpression;OfOb;13| (186 . |empty|)
              |FMTCAT-;nothing;M;14| |FMTCAT-;formatConstant;SM;15|
              (190 . |first|) |FMTCAT-;formatExpression;IM;16|
              |FMTCAT-;precedence;I2M;17| |FMTCAT-;bracket;2S2M;18| (195 . <)
              (201 . |parenthesizeIf|) |FMTCAT-;prefix;SI2M;19| (207 . |One|)
              (211 . |elt|) |FMTCAT-;infix;SI3M;20| (217 . |infix|)
              |FMTCAT-;binary;3M;21| (225 . |empty?|) (230 . |rest|)
              (|List| 37) (235 . |cons|) (241 . |reverse!|)
              |FMTCAT-;nary;SI2M;22| |FMTCAT-;naryPlus;2SI2M;24|)
           '#(|prefix| 246 |precedence| 253 |parenthesizeIf| 259
              |numberOfPrimes| 265 |nothing| 270 |naryPlus| 274 |nary| 282
              |minPrecedence| 289 |maxPrecedence| 293 |infix| 297
              |formatSymbol| 305 |formatString| 310 |formatInteger| 315
              |formatFunctionSymbol| 320 |formatFloat| 325 |formatExpression|
              330 |formatConstant| 346 |bracket| 351 |binary| 358)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|numberOfPrimes| ((|Integer|) (|OutputForm|)))
                                T)
                              '((|naryPlus|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|String|) (|String|) (|Integer|)
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|nary|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|String|) (|Integer|)
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|infix|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|String|) (|Integer|)
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|binary|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|prefix|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|String|) (|Integer|)
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|bracket|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|String|) (|String|)
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|precedence|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|Integer|)
                                  (|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|formatExpression|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|Integer|)))
                                T)
                              '((|formatConstant|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))
                                  (|String|)))
                                T)
                              '((|nothing|
                                 ((|Mapping| (|OutputBox|) (|Integer|)
                                             (|List| (|OutputForm|)))))
                                T)
                              '((|parenthesizeIf|
                                 ((|OutputBox|) (|Boolean|) (|OutputBox|)))
                                T)
                              '((|formatFunctionSymbol|
                                 ((|OutputBox|) (|String|)))
                                T)
                              '((|formatSymbol| ((|OutputBox|) (|String|))) T)
                              '((|formatString| ((|OutputBox|) (|String|))) T)
                              '((|formatFloat| ((|OutputBox|) (|String|))) T)
                              '((|formatInteger| ((|OutputBox|) (|Integer|)))
                                T)
                              '((|formatExpression|
                                 ((|OutputBox|) (|OutputForm|)))
                                T)
                              '((|formatExpression|
                                 ((|OutputBox|) (|OutputForm|) (|Integer|)))
                                T)
                              '((|maxPrecedence| ((|Integer|))) T)
                              '((|minPrecedence| ((|Integer|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 88
                                            '(1 12 10 11 13 1 12 10 11 14 1 12
                                              15 11 16 2 15 17 0 7 18 2 17 10 0
                                              0 19 1 12 11 11 20 1 12 10 11 21
                                              1 12 22 11 23 1 22 15 0 24 2 15
                                              10 0 0 25 1 12 26 11 27 1 29 28
                                              15 30 1 17 0 15 32 2 15 7 17 0 33
                                              1 17 10 0 34 0 17 0 35 3 15 17 0
                                              7 17 36 1 37 0 15 38 0 6 7 44 0 6
                                              7 45 1 6 46 7 47 3 6 46 15 7 46
                                              48 3 6 37 15 15 37 49 1 37 0 50
                                              51 0 6 53 54 1 12 10 11 55 1 12 7
                                              11 56 1 6 37 7 57 1 6 37 15 58 1
                                              6 37 15 59 3 53 10 0 7 15 60 3 53
                                              46 0 7 15 61 1 6 37 15 62 2 6 37
                                              11 7 63 1 6 37 15 64 0 37 0 67 1
                                              26 11 0 70 2 7 10 0 0 74 2 6 37
                                              10 37 75 0 7 0 77 2 26 11 0 7 78
                                              4 6 46 15 7 46 46 80 1 26 10 0 82
                                              1 26 0 0 83 2 84 0 37 0 85 1 84 0
                                              0 86 3 0 46 15 7 46 76 2 0 46 7
                                              46 72 2 0 37 10 37 52 1 0 7 11 31
                                              0 0 46 68 4 0 46 15 15 7 46 88 3
                                              0 46 15 7 46 87 0 0 7 8 0 0 7 9 4
                                              0 46 15 7 46 46 79 1 0 37 15 42 1
                                              0 37 15 41 1 0 37 7 39 1 0 37 15
                                              43 1 0 37 15 40 1 0 46 7 71 1 0
                                              37 11 66 2 0 37 11 7 65 1 0 46 15
                                              69 3 0 46 15 15 46 73 2 0 46 46
                                              46 81)))))
           '|lookupComplete|)) 
