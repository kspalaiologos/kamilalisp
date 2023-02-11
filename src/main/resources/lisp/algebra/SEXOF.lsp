
(SDEFUN |SEXOF;coerce;$Of;1| ((|b| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l1| (|List| (|OutputForm|))) (#1=#:G734 NIL) (|l| (|List| $))
          (|b1| NIL) (#2=#:G733 NIL) (|r| ($)))
         (SEQ
          (COND ((SPADCALL |b| (QREFELT $ 12)) (SPADCALL NIL (QREFELT $ 15)))
                ((SPADCALL |b| (QREFELT $ 16)) (SPADCALL |b| (QREFELT $ 18)))
                ((SPADCALL |b| (QREFELT $ 19)) |b|)
                ('T
                 (SEQ (LETT |r| |b|)
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |r| (QREFELT $ 19))))
                             (GO G191)))
                           (SEQ
                            (EXIT (LETT |r| (SPADCALL |r| (QREFELT $ 20)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |l1|
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |b1| NIL)
                                  (LETT #1#
                                        (LETT |l|
                                              (SPADCALL |b| (QREFELT $ 21))))
                                  G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |b1| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS (SPADCALL |b1| (QREFELT $ 22))
                                                #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#)))))
                      (COND
                       ((NULL (SPADCALL |r| (QREFELT $ 12)))
                        (EXIT
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL |l1|
                                     (LIST (QREFELT $ 10)
                                           (SPADCALL |r| (QREFELT $ 22)))
                                     (QREFELT $ 24))
                           (QREFELT $ 25))
                          (QREFELT $ 26)))))
                      (COND
                       ((EQL (SPADCALL |l| (QREFELT $ 29)) 2)
                        (COND
                         ((SPADCALL (|SPADfirst| |l1|)
                                    (SPADCALL 'QUOTE (QREFELT $ 31))
                                    (QREFELT $ 32))
                          (EXIT
                           (SPADCALL (|SPADfirst| (CDR |l1|))
                                     (QREFELT $ 33)))))))
                      (EXIT
                       (SPADCALL (SPADCALL |l1| (QREFELT $ 25))
                                 (QREFELT $ 26))))))))) 

(PUT '|SEXOF;=;2$B;2| '|SPADreplace| 'EQUAL) 

(SDEFUN |SEXOF;=;2$B;2| ((|b1| ($)) (|b2| ($)) ($ (|Boolean|)))
        (EQUAL |b1| |b2|)) 

(PUT '|SEXOF;eq;2$B;3| '|SPADreplace| 'EQ) 

(SDEFUN |SEXOF;eq;2$B;3| ((|b1| ($)) (|b2| ($)) ($ (|Boolean|))) (EQ |b1| |b2|)) 

(PUT '|SEXOF;null?;$B;4| '|SPADreplace| 'NULL) 

(SDEFUN |SEXOF;null?;$B;4| ((|b| ($)) ($ (|Boolean|))) (NULL |b|)) 

(PUT '|SEXOF;atom?;$B;5| '|SPADreplace| 'ATOM) 

(SDEFUN |SEXOF;atom?;$B;5| ((|b| ($)) ($ (|Boolean|))) (ATOM |b|)) 

(PUT '|SEXOF;pair?;$B;6| '|SPADreplace| 'PAIRP) 

(SDEFUN |SEXOF;pair?;$B;6| ((|b| ($)) ($ (|Boolean|))) (PAIRP |b|)) 

(SDEFUN |SEXOF;list?;$B;7| ((|b| ($)) ($ (|Boolean|)))
        (COND ((PAIRP |b|) 'T) ('T (NULL |b|)))) 

(PUT '|SEXOF;string?;$B;8| '|SPADreplace| 'STRINGP) 

(SDEFUN |SEXOF;string?;$B;8| ((|b| ($)) ($ (|Boolean|))) (STRINGP |b|)) 

(PUT '|SEXOF;symbol?;$B;9| '|SPADreplace| 'IDENTP) 

(SDEFUN |SEXOF;symbol?;$B;9| ((|b| ($)) ($ (|Boolean|))) (IDENTP |b|)) 

(PUT '|SEXOF;integer?;$B;10| '|SPADreplace| 'INTEGERP) 

(SDEFUN |SEXOF;integer?;$B;10| ((|b| ($)) ($ (|Boolean|))) (INTEGERP |b|)) 

(PUT '|SEXOF;float?;$B;11| '|SPADreplace| 'FLOATP) 

(SDEFUN |SEXOF;float?;$B;11| ((|b| ($)) ($ (|Boolean|))) (FLOATP |b|)) 

(SDEFUN |SEXOF;destruct;$L;12| ((|b| ($)) ($ (|List| $)))
        (COND ((SPADCALL |b| (QREFELT $ 37)) |b|) ('T (|error| "Non-list")))) 

(SDEFUN |SEXOF;string;$Str;13| ((|b| ($)) ($ (|Str|)))
        (COND ((STRINGP |b|) |b|) ('T (|error| "Non-string")))) 

(SDEFUN |SEXOF;symbol;$Sym;14| ((|b| ($)) ($ (|Sym|)))
        (COND ((IDENTP |b|) |b|) ('T (|error| "Non-symbol")))) 

(SDEFUN |SEXOF;float;$Flt;15| ((|b| ($)) ($ (|Flt|)))
        (COND ((FLOATP |b|) |b|) ('T (|error| "Non-float")))) 

(SDEFUN |SEXOF;integer;$Int;16| ((|b| ($)) ($ (|Int|)))
        (COND ((INTEGERP |b|) |b|) ('T (|error| "Non-integer")))) 

(PUT '|SEXOF;convert;L$;17| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |SEXOF;convert;L$;17| ((|l| (|List| $)) ($ ($))) |l|) 

(PUT '|SEXOF;convert;Str$;18| '|SPADreplace| '(XLAM (|st|) |st|)) 

(SDEFUN |SEXOF;convert;Str$;18| ((|st| (|Str|)) ($ ($))) |st|) 

(PUT '|SEXOF;convert;Sym$;19| '|SPADreplace| '(XLAM (|sy|) |sy|)) 

(SDEFUN |SEXOF;convert;Sym$;19| ((|sy| (|Sym|)) ($ ($))) |sy|) 

(PUT '|SEXOF;convert;Int$;20| '|SPADreplace| '(XLAM (|n|) |n|)) 

(SDEFUN |SEXOF;convert;Int$;20| ((|n| (|Int|)) ($ ($))) |n|) 

(PUT '|SEXOF;convert;Flt$;21| '|SPADreplace| '(XLAM (|f|) |f|)) 

(SDEFUN |SEXOF;convert;Flt$;21| ((|f| (|Flt|)) ($ ($))) |f|) 

(PUT '|SEXOF;car;2$;22| '|SPADreplace| 'CAR) 

(SDEFUN |SEXOF;car;2$;22| ((|b| ($)) ($ ($))) (CAR |b|)) 

(PUT '|SEXOF;cdr;2$;23| '|SPADreplace| 'CDR) 

(SDEFUN |SEXOF;cdr;2$;23| ((|b| ($)) ($ ($))) (CDR |b|)) 

(PUT '|SEXOF;#;$I;24| '|SPADreplace| 'LENGTH) 

(SDEFUN |SEXOF;#;$I;24| ((|b| ($)) ($ (|Integer|))) (LENGTH |b|)) 

(SDEFUN |SEXOF;elt;$I$;25| ((|b| ($)) (|i| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |b| (QREFELT $ 21)) |i| (QREFELT $ 53))) 

(SDEFUN |SEXOF;elt;$L$;26| ((|b| ($)) (|li| (|List| (|Integer|))) ($ ($)))
        (SPROG ((#1=#:G777 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| NIL) (LETT #1# |li|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |b|
                             (SPADCALL (SPADCALL |b| (QREFELT $ 21)) |i|
                                       (QREFELT $ 53)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |b|)))) 

(SDEFUN |SEXOF;hashUpdate!;Hs$Hs;27|
        ((|hs| (|HashState|)) (|s| ($)) ($ (|HashState|)))
        (HASHSTATEUPDATE |hs| (SXHASH |s|))) 

(DECLAIM (NOTINLINE |SExpressionOf;|)) 

(DEFUN |SExpressionOf| (&REST #1=#:G779)
  (SPROG NIL
         (PROG (#2=#:G780)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SExpressionOf|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SExpressionOf;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SExpressionOf|)))))))))) 

(DEFUN |SExpressionOf;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|SExpressionOf| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 60))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|SExpressionOf| (LIST DV$1 DV$2 DV$3 DV$4)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (INTERN "."))
    $))) 

(MAKEPROP '|SExpressionOf| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|dotex| (|Boolean|)
              |SEXOF;null?;$B;4| (|List| $) (|OutputForm|) (0 . |paren|)
              |SEXOF;string?;$B;8| (|String|) (5 . |outputForm|)
              |SEXOF;atom?;$B;5| |SEXOF;cdr;2$;23| |SEXOF;destruct;$L;12|
              |SEXOF;coerce;$Of;1| (|List| 14) (10 . |concat!|)
              (16 . |blankSeparate|) (21 . |paren|) (|NonNegativeInteger|)
              (|List| $$) (26 . |#|) (|Symbol|) (31 . |coerce|) (36 . =)
              (42 . |quote|) |SEXOF;=;2$B;2| |SEXOF;eq;2$B;3|
              |SEXOF;pair?;$B;6| |SEXOF;list?;$B;7| |SEXOF;symbol?;$B;9|
              |SEXOF;integer?;$B;10| |SEXOF;float?;$B;11|
              |SEXOF;string;$Str;13| |SEXOF;symbol;$Sym;14|
              |SEXOF;float;$Flt;15| |SEXOF;integer;$Int;16|
              |SEXOF;convert;L$;17| |SEXOF;convert;Str$;18|
              |SEXOF;convert;Sym$;19| |SEXOF;convert;Int$;20|
              |SEXOF;convert;Flt$;21| |SEXOF;car;2$;22| (|Integer|)
              |SEXOF;#;$I;24| (47 . |elt|) |SEXOF;elt;$I$;25| (|List| 51)
              |SEXOF;elt;$L$;26| (|HashState|) |SEXOF;hashUpdate!;Hs$Hs;27|
              (|SingleInteger|))
           '#(~= 53 |symbol?| 59 |symbol| 64 |string?| 69 |string| 74 |pair?|
              79 |null?| 84 |list?| 89 |latex| 94 |integer?| 99 |integer| 104
              |hashUpdate!| 109 |hash| 115 |float?| 120 |float| 125 |eq| 130
              |elt| 136 |destruct| 148 |convert| 153 |coerce| 178 |cdr| 183
              |car| 188 |atom?| 193 = 198 |#| 204)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SExpressionCategory| 6 7 8 9) (|SetCategory|)
                           (|BasicType|) (|CoercibleTo| 14))
                        (|makeByteWordVec2| 59
                                            '(1 14 0 13 15 1 14 0 17 18 2 23 0
                                              0 0 24 1 14 0 13 25 1 14 0 0 26 1
                                              28 27 0 29 1 30 14 0 31 2 14 11 0
                                              0 32 1 14 0 0 33 2 28 2 0 51 53 2
                                              0 11 0 0 1 1 0 11 0 38 1 0 7 0 42
                                              1 0 11 0 16 1 0 6 0 41 1 0 11 0
                                              36 1 0 11 0 12 1 0 11 0 37 1 0 17
                                              0 1 1 0 11 0 39 1 0 8 0 44 2 0 57
                                              57 0 58 1 0 59 0 1 1 0 11 0 40 1
                                              0 9 0 43 2 0 11 0 0 35 2 0 0 0 55
                                              56 2 0 0 0 51 54 1 0 13 0 21 1 0
                                              0 8 48 1 0 0 9 49 1 0 0 6 46 1 0
                                              0 7 47 1 0 0 13 45 1 0 14 0 22 1
                                              0 0 0 20 1 0 0 0 50 1 0 11 0 19 2
                                              0 11 0 0 34 1 0 51 0 52)))))
           '|lookupComplete|)) 
