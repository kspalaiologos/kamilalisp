
(SDEFUN |OUTFORM;cons_form| ((|x| ($)) (|l| (|List| $)) ($ ($)))
        (SPADCALL |x| |l| (QREFELT $ 7))) 

(PUT '|OUTFORM;print;$V;2| '|SPADreplace| '|mathprint|) 

(SDEFUN |OUTFORM;print;$V;2| ((|x| ($)) ($ (|Void|))) (|mathprint| |x|)) 

(SDEFUN |OUTFORM;message;S$;3| ((|s| (|String|)) ($ ($)))
        (COND ((SPADCALL |s| (QREFELT $ 13)) (SPADCALL (QREFELT $ 14)))
              ('T |s|))) 

(SDEFUN |OUTFORM;messagePrint;SV;4| ((|s| (|String|)) ($ (|Void|)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 15)) (QREFELT $ 10))) 

(PUT '|OUTFORM;=;2$B;5| '|SPADreplace| 'EQUAL) 

(SDEFUN |OUTFORM;=;2$B;5| ((|a| ($)) (|b| ($)) ($ (|Boolean|))) (EQUAL |a| |b|)) 

(SDEFUN |OUTFORM;=;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '= $) |a| |b|) (QREFELT $ 19))) 

(PUT '|OUTFORM;coerce;2$;7| '|SPADreplace| '(XLAM (|a|) |a|)) 

(SDEFUN |OUTFORM;coerce;2$;7| ((|a| ($)) ($ (|OutputForm|))) |a|) 

(PUT '|OUTFORM;outputForm;I$;8| '|SPADreplace| '(XLAM (|n|) |n|)) 

(SDEFUN |OUTFORM;outputForm;I$;8| ((|n| (|Integer|)) ($ ($))) |n|) 

(PUT '|OUTFORM;outputForm;S$;9| '|SPADreplace| '(XLAM (|e|) |e|)) 

(SDEFUN |OUTFORM;outputForm;S$;9| ((|e| (|Symbol|)) ($ ($))) |e|) 

(PUT '|OUTFORM;sform| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |OUTFORM;sform| ((|s| (|String|)) ($ ($))) |s|) 

(PUT '|OUTFORM;eform| '|SPADreplace| '(XLAM (|e|) |e|)) 

(SDEFUN |OUTFORM;eform| ((|e| (|Symbol|)) ($ ($))) |e|) 

(PUT '|OUTFORM;iform| '|SPADreplace| '(XLAM (|n|) |n|)) 

(SDEFUN |OUTFORM;iform| ((|n| (|Integer|)) ($ ($))) |n|) 

(SDEFUN |OUTFORM;outputForm;S$;13| ((|s| (|String|)) ($ ($)))
        (|OUTFORM;sform|
         (SPADCALL (SPADCALL (QREFELT $ 28))
                   (SPADCALL |s| (SPADCALL (QREFELT $ 28)) (QREFELT $ 29))
                   (QREFELT $ 30))
         $)) 

(SDEFUN |OUTFORM;convert;$If;14| ((|a| ($)) ($ (|InputForm|)))
        (SPROG
         ((#1=#:G2423 NIL) (|b| (|SExpression|)) (|d| (|String|))
          (|l| (|Integer|)) (|c| (|String|)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| |a|)
                (COND
                 ((SPADCALL |b| (QREFELT $ 33))
                  (SEQ
                   (COND
                    ((SPADCALL |b| (QREFELT $ 34))
                     (SEQ (LETT |c| (SPADCALL |b| (QREFELT $ 35)))
                          (LETT |l| (SPADCALL |c| (QREFELT $ 36)))
                          (EXIT
                           (COND
                            ((>= |l| 2)
                             (COND
                              ((|eql_SI| (SPADCALL |c| 1 (QREFELT $ 37))
                                         (SPADCALL |c| |l| (QREFELT $ 37)))
                               (COND
                                ((|eql_SI| (SPADCALL |c| 1 (QREFELT $ 37))
                                           (SPADCALL (QREFELT $ 28)))
                                 (SEQ
                                  (LETT |d|
                                        (SPADCALL |c|
                                                  (SPADCALL 2
                                                            (-
                                                             (SPADCALL |c|
                                                                       (QREFELT
                                                                        $ 36))
                                                             1)
                                                            (QREFELT $ 39))
                                                  (QREFELT $ 40)))
                                  (EXIT
                                   (LETT |b|
                                         (SPADCALL |d|
                                                   (QREFELT $ 41)))))))))))))))
                   (EXIT
                    (COND
                     ((NULL (SPADCALL |b| (QREFELT $ 42)))
                      (PROGN
                       (LETT #1# (SPADCALL |b| (QREFELT $ 44)))
                       (GO #2=#:G2422))))))))
                (EXIT
                 (SPADCALL
                  (LIST (SPADCALL 'QUOTE (QREFELT $ 45))
                        (SPADCALL |b| (QREFELT $ 44)))
                  (QREFELT $ 46)))))
          #2# (EXIT #1#)))) 

(PUT '|OUTFORM;width| '|SPADreplace| '|outformWidth|) 

(SDEFUN |OUTFORM;width| ((|a| ($)) ($ (|Integer|))) (|outformWidth| |a|)) 

(PUT '|OUTFORM;width0| '|SPADreplace| '(XLAM NIL $LINELENGTH)) 

(SDEFUN |OUTFORM;width0| (($ (|Integer|))) $LINELENGTH) 

(SDEFUN |OUTFORM;center;$I$;17| ((|a| ($)) (|w| (|Integer|)) ($ ($)))
        (SPADCALL
         (SPADCALL (QUOTIENT2 (- |w| (|OUTFORM;width| |a| $)) 2)
                   (QREFELT $ 48))
         |a| (QREFELT $ 49))) 

(SDEFUN |OUTFORM;left;$I$;18| ((|a| ($)) (|w| (|Integer|)) ($ ($)))
        (SPADCALL |a| (SPADCALL (- |w| (|OUTFORM;width| |a| $)) (QREFELT $ 48))
                  (QREFELT $ 49))) 

(SDEFUN |OUTFORM;right;$I$;19| ((|a| ($)) (|w| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL (- |w| (|OUTFORM;width| |a| $)) (QREFELT $ 48)) |a|
                  (QREFELT $ 49))) 

(SDEFUN |OUTFORM;center;2$;20| ((|a| ($)) ($ ($)))
        (SPADCALL |a| (|OUTFORM;width0| $) (QREFELT $ 50))) 

(SDEFUN |OUTFORM;left;2$;21| ((|a| ($)) ($ ($)))
        (SPADCALL |a| (|OUTFORM;width0| $) (QREFELT $ 51))) 

(SDEFUN |OUTFORM;right;2$;22| ((|a| ($)) ($ ($)))
        (SPADCALL |a| (|OUTFORM;width0| $) (QREFELT $ 52))) 

(SDEFUN |OUTFORM;vspace;I$;23| ((|n| (|Integer|)) ($ ($)))
        (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 14)))
              ('T
               (SPADCALL (|OUTFORM;sform| " " $)
                         (SPADCALL (- |n| 1) (QREFELT $ 56)) (QREFELT $ 57))))) 

(SDEFUN |OUTFORM;hspace;I$;24| ((|n| (|Integer|)) ($ ($)))
        (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 14)))
              ('T (|OUTFORM;sform| (|fillerSpaces| |n| " ") $)))) 

(SDEFUN |OUTFORM;rspace;2I$;25| ((|n| (|Integer|)) (|m| (|Integer|)) ($ ($)))
        (COND ((OR (EQL |n| 0) (EQL |m| 0)) (SPADCALL (QREFELT $ 14)))
              ('T
               (SPADCALL (SPADCALL |n| (QREFELT $ 48))
                         (SPADCALL |n| (- |m| 1) (QREFELT $ 58))
                         (QREFELT $ 57))))) 

(SDEFUN |OUTFORM;matrix;L$;26| ((|ll| (|List| (|List| $))) ($ ($)))
        (SPROG ((|lv| (|List| $)) (#1=#:G2442 NIL) (|l| NIL) (#2=#:G2441 NIL))
               (SEQ
                (COND ((NULL |ll|) (SPADCALL NIL (QREFELT $ 59)))
                      ('T
                       (SEQ
                        (LETT |lv|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |l| NIL) (LETT #1# |ll|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |l| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS
                                             (|OUTFORM;cons_form|
                                              (|OUTFORM;eform| 'ROW $) |l| $)
                                             #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#)))))
                        (EXIT
                         (|OUTFORM;cons_form| (|OUTFORM;eform| 'MATRIX $)
                          (SPADCALL (|OUTFORM;eform| 'NIL $) |lv|
                                    (QREFELT $ 7))
                          $)))))))) 

(SDEFUN |OUTFORM;pile;L$;27| ((|l| (|List| $)) ($ ($)))
        (|OUTFORM;cons_form| (|OUTFORM;eform| 'SC $) |l| $)) 

(SDEFUN |OUTFORM;commaSeparate;L$;28| ((|l| (|List| $)) ($ ($)))
        (|OUTFORM;cons_form| (|OUTFORM;eform| 'AGGLST $) |l| $)) 

(SDEFUN |OUTFORM;semicolonSeparate;L$;29| ((|l| (|List| $)) ($ ($)))
        (|OUTFORM;cons_form| (|OUTFORM;eform| 'AGGSET $) |l| $)) 

(SDEFUN |OUTFORM;blankSeparate;L$;30| ((|l| (|List| $)) ($ ($)))
        (SPROG
         ((|l1| (|List| $)) (|l2| (|List| $)) (|uo| (|OutputForm|))
          (#1=#:G2452 NIL) (|u| NIL) (|c| ($)))
         (SEQ (LETT |c| (|OUTFORM;eform| 'CONCATB $)) (LETT |l1| NIL)
              (SEQ (LETT |u| NIL) (LETT #1# (SPADCALL |l| (QREFELT $ 65))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |uo| |u|)
                        (EXIT
                         (COND
                          ((SPADCALL |uo| 'CONCATB (QREFELT $ 67))
                           (SEQ (LETT |l2| (SPADCALL |uo| (QREFELT $ 69)))
                                (EXIT
                                 (LETT |l1|
                                       (SPADCALL |l2| |l1| (QREFELT $ 70))))))
                          ('T (LETT |l1| (SPADCALL |u| |l1| (QREFELT $ 7)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (|OUTFORM;cons_form| |c| |l1| $))))) 

(SDEFUN |OUTFORM;brace;2$;31| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'BRACE $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;brace;L$;32| ((|l| (|List| $)) ($ ($)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 63)) (QREFELT $ 72))) 

(SDEFUN |OUTFORM;bracket;2$;33| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'BRACKET $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;bracket;L$;34| ((|l| (|List| $)) ($ ($)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 63)) (QREFELT $ 74))) 

(SDEFUN |OUTFORM;paren;2$;35| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'PAREN $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;paren;L$;36| ((|l| (|List| $)) ($ ($)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 63)) (QREFELT $ 75))) 

(SDEFUN |OUTFORM;sub;3$;37| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'SUB $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;super;3$;38| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (LIST (|OUTFORM;eform| 'SUPERSUB $) |a| (|OUTFORM;sform| " " $) |b|)
         (QREFELT $ 19))) 

(SDEFUN |OUTFORM;presub;3$;39| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (LIST (|OUTFORM;eform| 'SUPERSUB $) |a| (|OUTFORM;sform| " " $)
               (|OUTFORM;sform| " " $) (|OUTFORM;sform| " " $) |b|)
         (QREFELT $ 19))) 

(SDEFUN |OUTFORM;presuper;3$;40| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (LIST (|OUTFORM;eform| 'SUPERSUB $) |a| (|OUTFORM;sform| " " $)
               (|OUTFORM;sform| " " $) |b|)
         (QREFELT $ 19))) 

(SDEFUN |OUTFORM;scripts;$L$;41| ((|a| ($)) (|l| (|List| $)) ($ ($)))
        (COND ((SPADCALL |l| (QREFELT $ 81)) |a|)
              ((SPADCALL (SPADCALL |l| (QREFELT $ 82)) (QREFELT $ 81))
               (SPADCALL |a| (SPADCALL |l| (QREFELT $ 83)) (QREFELT $ 77)))
              ('T
               (|OUTFORM;cons_form| (|OUTFORM;eform| 'SUPERSUB $)
                (SPADCALL |a| |l| (QREFELT $ 7)) $)))) 

(SDEFUN |OUTFORM;supersub;$L$;42| ((|a| ($)) (|l| (|List| $)) ($ ($)))
        (SEQ
         (COND
          ((ODDP (SPADCALL |l| (QREFELT $ 86)))
           (LETT |l|
                 (SPADCALL |l| (LIST (SPADCALL (QREFELT $ 14)))
                           (QREFELT $ 87)))))
         (EXIT
          (|OUTFORM;cons_form| (|OUTFORM;eform| 'ALTSUPERSUB $)
           (SPADCALL |a| |l| (QREFELT $ 7)) $)))) 

(SDEFUN |OUTFORM;hconcat;3$;43| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'CONCAT $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;hconcat;L$;44| ((|l| (|List| $)) ($ ($)))
        (|OUTFORM;cons_form| (|OUTFORM;eform| 'CONCAT $) |l| $)) 

(SDEFUN |OUTFORM;vconcat;3$;45| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'VCONCAT $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;vconcat;L$;46| ((|l| (|List| $)) ($ ($)))
        (|OUTFORM;cons_form| (|OUTFORM;eform| 'VCONCAT $) |l| $)) 

(SDEFUN |OUTFORM;~=;3$;47| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '~= $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;<;3$;48| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '< $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;>;3$;49| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '> $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;<=;3$;50| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '<= $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;>=;3$;51| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '>= $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;+;3$;52| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '+ $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;-;3$;53| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '- $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;-;2$;54| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '- $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;*;3$;55| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '* $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;/;3$;56| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '/ $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;^;3$;57| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '^ $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;rem;3$;58| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '|rem| $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;quo;3$;59| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '|quo| $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;exquo;3$;60| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '|exquo| $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;and;3$;61| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '|and| $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;or;3$;62| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '|or| $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;not;2$;63| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| '|not| $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;SEGMENT;3$;64| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'SEGMENT $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;SEGMENT;2$;65| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'SEGMENT $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;binomial;3$;66| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'BINOMIAL $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;empty;$;67| (($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'NOTHING $)) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;infix?;$B;68| ((|a| ($)) ($ (|Boolean|)))
        (SPROG ((|e| ($)) (#1=#:G2498 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (LETT |e|
                        (COND ((IDENTP |a|) |a|) ((STRINGP |a|) (INTERN |a|))
                              (#2='T (PROGN (LETT #1# NIL) (GO #3=#:G2497)))))
                  (EXIT (COND ((GET |e| 'INFIXOP) 'T) (#2# NIL)))))
                #3# (EXIT #1#)))) 

(SDEFUN |OUTFORM;elt;$L$;69| ((|a| ($)) (|l| (|List| $)) ($ ($)))
        (|OUTFORM;cons_form| |a| |l| $)) 

(SDEFUN |OUTFORM;prefix;$L$;70| ((|a| ($)) (|l| (|List| $)) ($ ($)))
        (COND
         ((NULL (SPADCALL |a| (QREFELT $ 111)))
          (|OUTFORM;cons_form| |a| |l| $))
         ('T
          (SPADCALL |a| (SPADCALL (SPADCALL |l| (QREFELT $ 63)) (QREFELT $ 75))
                    (QREFELT $ 49))))) 

(SDEFUN |OUTFORM;infix;$L$;71| ((|a| ($)) (|l| (|List| $)) ($ ($)))
        (COND ((SPADCALL |l| (QREFELT $ 81)) (SPADCALL (QREFELT $ 14)))
              ((SPADCALL (SPADCALL |l| (QREFELT $ 82)) (QREFELT $ 81))
               (SPADCALL |l| (QREFELT $ 83)))
              ((SPADCALL |a| (QREFELT $ 111)) (|OUTFORM;cons_form| |a| |l| $))
              ('T
               (SPADCALL
                (LIST (SPADCALL |l| (QREFELT $ 83)) |a|
                      (SPADCALL |a| (SPADCALL |l| (QREFELT $ 82))
                                (QREFELT $ 114)))
                (QREFELT $ 89))))) 

(SDEFUN |OUTFORM;infix;4$;72| ((|a| ($)) (|b| ($)) (|c| ($)) ($ ($)))
        (COND
         ((SPADCALL |a| (QREFELT $ 111))
          (SPADCALL (LIST |a| |b| |c|) (QREFELT $ 19)))
         ('T (SPADCALL (LIST |b| |a| |c|) (QREFELT $ 89))))) 

(SDEFUN |OUTFORM;postfix;3$;73| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |b| |a| (QREFELT $ 49))) 

(SDEFUN |OUTFORM;add_prime| ((|a| ($)) (|s| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'PRIME $) |a| |s|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;quote;2$;75| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'QUOTE $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;overbar;2$;76| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'OVERBAR $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;dot;2$;77| ((|a| ($)) ($ ($)))
        (SPADCALL |a| (|OUTFORM;sform| "." $) (QREFELT $ 78))) 

(SDEFUN |OUTFORM;prime;2$;78| ((|a| ($)) ($ ($)))
        (SPADCALL |a| 1 (QREFELT $ 120))) 

(SDEFUN |OUTFORM;dot;$Nni$;79|
        ((|a| ($)) (|nn| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|s| (|String|)))
               (SEQ (LETT |s| (|make_full_CVEC2| |nn| (|STR_to_CHAR| ".")))
                    (EXIT
                     (SPADCALL |a| (|OUTFORM;sform| |s| $) (QREFELT $ 78)))))) 

(SDEFUN |OUTFORM;prime;$Nni$;80|
        ((|a| ($)) (|nn| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|s| (|String|)))
               (SEQ (LETT |s| (|make_full_CVEC2| |nn| (|STR_to_CHAR| ",")))
                    (EXIT
                     (|OUTFORM;add_prime| |a| (|OUTFORM;sform| |s| $) $))))) 

(SDEFUN |OUTFORM;overlabel;3$;81| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'OVERLABEL $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;box;2$;82| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'BOX $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;zag;3$;83| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'ZAG $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;root;2$;84| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'ROOT $) |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;root;3$;85| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'ROOT $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;over;3$;86| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'OVER $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;slash;3$;87| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'SLASH $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;assign;3$;88| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'LET $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;label;3$;89| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'EQUATNUM $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;rarrow;3$;90| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'TAG $) |a| |b|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;differentiate;$Nni$;91|
        ((|a| ($)) (|nn| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|s| (|String|)) (|r| (|String|)) (#1=#:G2530 NIL))
               (SEQ
                (COND ((ZEROP |nn|) |a|)
                      ((< |nn| 4) (SPADCALL |a| |nn| (QREFELT $ 120)))
                      ('T
                       (SEQ
                        (LETT |r|
                              (SPADCALL
                               (PROG1 (LETT #1# |nn|)
                                 (|check_subtype2| (> #1# 0)
                                                   '(|PositiveInteger|)
                                                   '(|NonNegativeInteger|)
                                                   #1#))
                               (QREFELT $ 135)))
                        (LETT |s| (SPADCALL |r| (QREFELT $ 136)))
                        (EXIT
                         (|OUTFORM;add_prime| |a|
                          (SPADCALL (|OUTFORM;sform| |s| $) (QREFELT $ 75))
                          $)))))))) 

(SDEFUN |OUTFORM;sum;2$;92| ((|a| ($)) ($ ($)))
        (SPADCALL
         (LIST (|OUTFORM;eform| 'SIGMA $) (SPADCALL (QREFELT $ 14)) |a|)
         (QREFELT $ 19))) 

(SDEFUN |OUTFORM;sum;3$;93| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'SIGMA $) |b| |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;sum;4$;94| ((|a| ($)) (|b| ($)) (|c| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'SIGMA2 $) |b| |c| |a|)
                  (QREFELT $ 19))) 

(SDEFUN |OUTFORM;prod;2$;95| ((|a| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'PI $) (SPADCALL (QREFELT $ 14)) |a|)
                  (QREFELT $ 19))) 

(SDEFUN |OUTFORM;prod;3$;96| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'PI $) |b| |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;prod;4$;97| ((|a| ($)) (|b| ($)) (|c| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'PI2 $) |b| |c| |a|) (QREFELT $ 19))) 

(SDEFUN |OUTFORM;int;2$;98| ((|a| ($)) ($ ($)))
        (SPADCALL
         (LIST (|OUTFORM;eform| 'INTSIGN $) (SPADCALL (QREFELT $ 14))
               (SPADCALL (QREFELT $ 14)) |a|)
         (QREFELT $ 19))) 

(SDEFUN |OUTFORM;int;3$;99| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (LIST (|OUTFORM;eform| 'INTSIGN $) |b| (SPADCALL (QREFELT $ 14)) |a|)
         (QREFELT $ 19))) 

(SDEFUN |OUTFORM;int;4$;100| ((|a| ($)) (|b| ($)) (|c| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'INTSIGN $) |b| |c| |a|)
                  (QREFELT $ 19))) 

(SDEFUN |OUTFORM;tensor;3$;101| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (LIST (|OUTFORM;eform| 'TENSOR $) |a| |b|) (QREFELT $ 19))) 

(DECLAIM (NOTINLINE |OutputForm;|)) 

(DEFUN |OutputForm| ()
  (SPROG NIL
         (PROG (#1=#:G2545)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OutputForm|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OutputForm|
                             (LIST (CONS NIL (CONS 1 (|OutputForm;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|OutputForm|)))))))))) 

(DEFUN |OutputForm;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OutputForm|))
          (LETT $ (GETREFV 150))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OutputForm| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|SExpression|))
          $))) 

(MAKEPROP '|OutputForm| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| $$) (0 . |cons|) '|Rep| (|Void|)
              |OUTFORM;print;$V;2| (|Boolean|) (|String|) (6 . |empty?|)
              |OUTFORM;empty;$;67| |OUTFORM;message;S$;3|
              |OUTFORM;messagePrint;SV;4| |OUTFORM;=;2$B;5| (|List| $)
              (11 . |convert|) |OUTFORM;=;3$;6| (|OutputForm|)
              |OUTFORM;coerce;2$;7| (|Integer|) |OUTFORM;outputForm;I$;8|
              (|Symbol|) |OUTFORM;outputForm;S$;9| (|Character|) (16 . |quote|)
              (20 . |concat|) (26 . |concat|) |OUTFORM;outputForm;S$;13|
              (|SExpression|) (32 . |atom?|) (37 . |string?|) (42 . |string|)
              (47 . |maxIndex|) (52 . |elt|) (|UniversalSegment| 23)
              (58 . SEGMENT) (64 . |elt|) (70 . |convert|) (75 . |symbol?|)
              (|InputForm|) (80 . |convert|) (85 . |convert|) (90 . |convert|)
              |OUTFORM;convert;$If;14| |OUTFORM;hspace;I$;24|
              |OUTFORM;hconcat;3$;43| |OUTFORM;center;$I$;17|
              |OUTFORM;left;$I$;18| |OUTFORM;right;$I$;19|
              |OUTFORM;center;2$;20| |OUTFORM;left;2$;21| |OUTFORM;right;2$;22|
              |OUTFORM;vspace;I$;23| |OUTFORM;vconcat;3$;45|
              |OUTFORM;rspace;2I$;25| |OUTFORM;bracket;L$;34| (|List| 18)
              |OUTFORM;matrix;L$;26| |OUTFORM;pile;L$;27|
              |OUTFORM;commaSeparate;L$;28| |OUTFORM;semicolonSeparate;L$;29|
              (95 . |reverse|) (|OutputFormTools|) (100 . |has_op?|)
              (|List| 21) (106 . |arguments|) (111 . |concat|)
              |OUTFORM;blankSeparate;L$;30| |OUTFORM;brace;2$;31|
              |OUTFORM;brace;L$;32| |OUTFORM;bracket;2$;33|
              |OUTFORM;paren;2$;35| |OUTFORM;paren;L$;36| |OUTFORM;sub;3$;37|
              |OUTFORM;super;3$;38| |OUTFORM;presub;3$;39|
              |OUTFORM;presuper;3$;40| (117 . |empty?|) (122 . |rest|)
              (127 . |first|) |OUTFORM;scripts;$L$;41| (|NonNegativeInteger|)
              (132 . |#|) (137 . |append|) |OUTFORM;supersub;$L$;42|
              |OUTFORM;hconcat;L$;44| |OUTFORM;vconcat;L$;46|
              |OUTFORM;~=;3$;47| |OUTFORM;<;3$;48| |OUTFORM;>;3$;49|
              |OUTFORM;<=;3$;50| |OUTFORM;>=;3$;51| |OUTFORM;+;3$;52|
              |OUTFORM;-;3$;53| |OUTFORM;-;2$;54| |OUTFORM;*;3$;55|
              |OUTFORM;/;3$;56| |OUTFORM;^;3$;57| |OUTFORM;rem;3$;58|
              |OUTFORM;quo;3$;59| |OUTFORM;exquo;3$;60| |OUTFORM;and;3$;61|
              |OUTFORM;or;3$;62| |OUTFORM;not;2$;63| |OUTFORM;SEGMENT;3$;64|
              |OUTFORM;SEGMENT;2$;65| |OUTFORM;binomial;3$;66|
              |OUTFORM;infix?;$B;68| |OUTFORM;elt;$L$;69|
              |OUTFORM;prefix;$L$;70| |OUTFORM;infix;$L$;71|
              |OUTFORM;infix;4$;72| |OUTFORM;postfix;3$;73|
              |OUTFORM;quote;2$;75| |OUTFORM;overbar;2$;76| |OUTFORM;dot;2$;77|
              |OUTFORM;prime;$Nni$;80| |OUTFORM;prime;2$;78|
              |OUTFORM;dot;$Nni$;79| |OUTFORM;overlabel;3$;81|
              |OUTFORM;box;2$;82| |OUTFORM;zag;3$;83| |OUTFORM;root;2$;84|
              |OUTFORM;root;3$;85| |OUTFORM;over;3$;86| |OUTFORM;slash;3$;87|
              |OUTFORM;assign;3$;88| |OUTFORM;label;3$;89|
              |OUTFORM;rarrow;3$;90| (|PositiveInteger|) (|NumberFormats|)
              (143 . |FormatRoman|) (148 . |lowerCase|)
              |OUTFORM;differentiate;$Nni$;91| |OUTFORM;sum;2$;92|
              |OUTFORM;sum;3$;93| |OUTFORM;sum;4$;94| |OUTFORM;prod;2$;95|
              |OUTFORM;prod;3$;96| |OUTFORM;prod;4$;97| |OUTFORM;int;2$;98|
              |OUTFORM;int;3$;99| |OUTFORM;int;4$;100| |OUTFORM;tensor;3$;101|
              (|HashState|) (|SingleInteger|))
           '#(~= 153 |zag| 165 |vspace| 171 |vconcat| 176 |tensor| 187
              |supersub| 193 |super| 199 |sum| 205 |sub| 223 |slash| 229
              |semicolonSeparate| 235 |scripts| 240 |rspace| 246 |root| 252
              |right| 263 |rem| 274 |rarrow| 280 |quote| 286 |quo| 291 |prod|
              297 |print| 315 |prime| 320 |presuper| 331 |presub| 337 |prefix|
              343 |postfix| 349 |pile| 355 |paren| 360 |overlabel| 370
              |overbar| 376 |over| 381 |outputForm| 387 |or| 402 |not| 408
              |messagePrint| 413 |message| 418 |matrix| 423 |left| 428 |latex|
              439 |label| 444 |int| 450 |infix?| 468 |infix| 473 |hspace| 486
              |hconcat| 491 |hashUpdate!| 502 |hash| 508 |exquo| 513 |empty|
              519 |elt| 523 |dot| 529 |differentiate| 540 |convert| 546
              |commaSeparate| 551 |coerce| 556 |center| 561 |bracket| 572
              |brace| 582 |box| 592 |blankSeparate| 597 |binomial| 602 |assign|
              608 |and| 614 ^ 620 SEGMENT 626 >= 637 > 643 = 649 <= 661 < 667 /
              673 - 679 + 690 * 696)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|ConvertibleTo| 43)
                           (|CoercibleTo| 21))
                        (|makeByteWordVec2| 149
                                            '(2 6 0 2 0 7 1 12 11 0 13 1 8 0 18
                                              19 0 27 0 28 2 12 0 0 27 29 2 12
                                              0 27 0 30 1 32 11 0 33 1 32 11 0
                                              34 1 32 12 0 35 1 12 23 0 36 2 12
                                              27 0 23 37 2 38 0 23 23 39 2 12 0
                                              0 38 40 1 32 0 12 41 1 32 11 0 42
                                              1 43 0 32 44 1 43 0 25 45 1 43 0
                                              18 46 1 6 0 0 65 2 66 11 21 25 67
                                              1 66 68 21 69 2 6 0 0 0 70 1 6 11
                                              0 81 1 6 0 0 82 1 6 2 0 83 1 6 85
                                              0 86 2 6 0 0 0 87 1 134 12 133
                                              135 1 12 0 0 136 2 0 0 0 0 91 2 0
                                              11 0 0 1 2 0 0 0 0 125 1 0 0 23
                                              56 1 0 0 18 90 2 0 0 0 0 57 2 0 0
                                              0 0 147 2 0 0 0 18 88 2 0 0 0 0
                                              78 3 0 0 0 0 0 140 1 0 0 0 138 2
                                              0 0 0 0 139 2 0 0 0 0 77 2 0 0 0
                                              0 129 1 0 0 18 64 2 0 0 0 18 84 2
                                              0 0 23 23 58 1 0 0 0 126 2 0 0 0
                                              0 127 1 0 0 0 55 2 0 0 0 23 52 2
                                              0 0 0 0 102 2 0 0 0 0 132 1 0 0 0
                                              117 2 0 0 0 0 103 3 0 0 0 0 0 143
                                              1 0 0 0 141 2 0 0 0 0 142 1 0 9 0
                                              10 2 0 0 0 85 120 1 0 0 0 121 2 0
                                              0 0 0 80 2 0 0 0 0 79 2 0 0 0 18
                                              113 2 0 0 0 0 116 1 0 0 18 62 1 0
                                              0 18 76 1 0 0 0 75 2 0 0 0 0 123
                                              1 0 0 0 118 2 0 0 0 0 128 1 0 0
                                              12 31 1 0 0 23 24 1 0 0 25 26 2 0
                                              0 0 0 106 1 0 0 0 107 1 0 9 12 16
                                              1 0 0 12 15 1 0 0 60 61 1 0 0 0
                                              54 2 0 0 0 23 51 1 0 12 0 1 2 0 0
                                              0 0 131 3 0 0 0 0 0 146 1 0 0 0
                                              144 2 0 0 0 0 145 1 0 11 0 111 2
                                              0 0 0 18 114 3 0 0 0 0 0 115 1 0
                                              0 23 48 1 0 0 18 89 2 0 0 0 0 49
                                              2 0 148 148 0 1 1 0 149 0 1 2 0 0
                                              0 0 104 0 0 0 14 2 0 0 0 18 112 1
                                              0 0 0 119 2 0 0 0 85 122 2 0 0 0
                                              85 137 1 0 43 0 47 1 0 0 18 63 1
                                              0 21 0 22 1 0 0 0 53 2 0 0 0 23
                                              50 1 0 0 18 59 1 0 0 0 74 1 0 0 0
                                              72 1 0 0 18 73 1 0 0 0 124 1 0 0
                                              18 71 2 0 0 0 0 110 2 0 0 0 0 130
                                              2 0 0 0 0 105 2 0 0 0 0 101 1 0 0
                                              0 109 2 0 0 0 0 108 2 0 0 0 0 95
                                              2 0 0 0 0 93 2 0 0 0 0 20 2 0 11
                                              0 0 17 2 0 0 0 0 94 2 0 0 0 0 92
                                              2 0 0 0 0 100 1 0 0 0 98 2 0 0 0
                                              0 97 2 0 0 0 0 96 2 0 0 0 0
                                              99)))))
           '|lookupComplete|)) 

(MAKEPROP '|OutputForm| 'NILADIC T) 
