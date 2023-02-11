
(SDEFUN |INFORM;Zero;$;1| (($ ($))) (SPADCALL 0 (QREFELT $ 8))) 

(SDEFUN |INFORM;One;$;2| (($ ($))) (SPADCALL 1 (QREFELT $ 8))) 

(PUT '|INFORM;convert;$Se;3| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |INFORM;convert;$Se;3| ((|x| ($)) ($ (|SExpression|))) |x|) 

(PUT '|INFORM;convert;Se$;4| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |INFORM;convert;Se$;4| ((|x| (|SExpression|)) ($ ($))) |x|) 

(SDEFUN |INFORM;convert;S$;5| ((|x| (|Symbol|)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 15))) 

(SDEFUN |INFORM;conv| ((|ll| (|List| $)) ($ ($)))
        (SPADCALL |ll| (QREFELT $ 18))) 

(SDEFUN |INFORM;lambda;$L$;7| ((|f| ($)) (|l| (|List| (|Symbol|))) ($ ($)))
        (|INFORM;conv|
         (LIST (SPADCALL '+-> (QREFELT $ 16)) (|INFORM;tuplify| |l| $) |f|) $)) 

(SDEFUN |INFORM;interpret;$A;8| ((|x| ($)) ($ (|Any|)))
        (SPROG ((|v| (|None|)))
               (SEQ (LETT |v| (|interpret| |x| NIL))
                    (EXIT
                     (|mkObj| (|unwrap| (|objVal| |v|)) (|objMode| |v|)))))) 

(SDEFUN |INFORM;convert;Df$;9| ((|x| (|DoubleFloat|)) ($ ($)))
        (COND ((|zero?_DF| |x|) (|spadConstant| $ 9))
              ((|eql_DF| |x| 1.0) (|spadConstant| $ 10))
              ('T (SPADCALL |x| (QREFELT $ 24))))) 

(SDEFUN |INFORM;flatten;2$;10| ((|s| ($)) ($ ($)))
        (SPROG
         ((#1=#:G754 NIL) (|u| NIL) (#2=#:G753 NIL) (#3=#:G752 NIL)
          (#4=#:G751 NIL)
          (|l2| (|List| (|Record| (|:| |lst| (|List| $)) (|:| |symb| $))))
          (|n| (|NonNegativeInteger|)) (#5=#:G750 NIL) (|l| (|List| $))
          (|x| NIL) (#6=#:G749 NIL) (|sy| (|Symbol|)))
         (SEQ
          (COND
           ((OR (SPADCALL |s| (QREFELT $ 27))
                (SPADCALL (ELT $ 27) (SPADCALL |s| (QREFELT $ 28))
                          (QREFELT $ 31)))
            |s|)
           ('T
            (SEQ (LETT |sy| (SPADCALL (QREFELT $ 32))) (LETT |n| 0)
                 (LETT |l2|
                       (PROGN
                        (LETT #6# NIL)
                        (SEQ (LETT |x| NIL)
                             (LETT #5#
                                   (SPADCALL
                                    (LETT |l| (SPADCALL |s| (QREFELT $ 28)))
                                    (QREFELT $ 33)))
                             G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |x| (CAR #5#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #6#
                                     (CONS
                                      (|INFORM;flatten0| |x| |sy|
                                       (LETT |n| (+ |n| 1)) $)
                                      #6#))))
                             (LETT #5# (CDR #5#)) (GO G190) G191
                             (EXIT (NREVERSE #6#)))))
                 (EXIT
                  (|INFORM;conv|
                   (SPADCALL (SPADCALL 'SEQ (QREFELT $ 16))
                             (SPADCALL
                              (SPADCALL
                               (PROGN
                                (LETT #4# NIL)
                                (SEQ (LETT |u| NIL) (LETT #3# |l2|) G190
                                     (COND
                                      ((OR (ATOM #3#)
                                           (PROGN (LETT |u| (CAR #3#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT (LETT #4# (CONS (QCAR |u|) #4#))))
                                     (LETT #3# (CDR #3#)) (GO G190) G191
                                     (EXIT (NREVERSE #4#))))
                               (QREFELT $ 34))
                              (|INFORM;conv|
                               (LIST (SPADCALL '|exit| (QREFELT $ 16))
                                     (|spadConstant| $ 10)
                                     (|INFORM;conv|
                                      (SPADCALL (SPADCALL |l| (QREFELT $ 35))
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (SEQ (LETT |u| NIL)
                                                      (LETT #1# |l2|) G190
                                                      (COND
                                                       ((OR (ATOM #1#)
                                                            (PROGN
                                                             (LETT |u|
                                                                   (CAR #1#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (LETT #2#
                                                              (CONS (QCDR |u|)
                                                                    #2#))))
                                                      (LETT #1# (CDR #1#))
                                                      (GO G190) G191
                                                      (EXIT (NREVERSE #2#))))
                                                (QREFELT $ 36))
                                      $))
                               $)
                              (QREFELT $ 37))
                             (QREFELT $ 36))
                   $)))))))) 

(SDEFUN |INFORM;flatten0|
        ((|s| ($)) (|sy| (|Symbol|)) (|n| (|NonNegativeInteger|))
         ($ (|Record| (|:| |lst| (|List| $)) (|:| |symb| $))))
        (SPROG
         ((#1=#:G770 NIL) (|u| NIL) (#2=#:G769 NIL) (#3=#:G768 NIL)
          (#4=#:G767 NIL)
          (|l2| (|List| (|Record| (|:| |lst| (|List| $)) (|:| |symb| $))))
          (#5=#:G766 NIL) (|l| (|List| $)) (|x| NIL) (#6=#:G765 NIL) (|a| ($)))
         (SEQ
          (COND ((SPADCALL |s| (QREFELT $ 27)) (CONS NIL |s|))
                ('T
                 (SEQ
                  (LETT |a|
                        (SPADCALL
                         (SPADCALL
                          (STRCONC (SPADCALL |sy| (QREFELT $ 40))
                                   (STRINGIMAGE |n|))
                          (QREFELT $ 41))
                         (QREFELT $ 16)))
                  (LETT |l2|
                        (PROGN
                         (LETT #6# NIL)
                         (SEQ (LETT |x| NIL)
                              (LETT #5#
                                    (SPADCALL
                                     (LETT |l| (SPADCALL |s| (QREFELT $ 28)))
                                     (QREFELT $ 33)))
                              G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |x| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #6#
                                      (CONS
                                       (|INFORM;flatten0| |x| |sy|
                                        (LETT |n| (+ |n| 1)) $)
                                       #6#))))
                              (LETT #5# (CDR #5#)) (GO G190) G191
                              (EXIT (NREVERSE #6#)))))
                  (EXIT
                   (CONS
                    (SPADCALL
                     (SPADCALL
                      (PROGN
                       (LETT #4# NIL)
                       (SEQ (LETT |u| NIL) (LETT #3# |l2|) G190
                            (COND
                             ((OR (ATOM #3#) (PROGN (LETT |u| (CAR #3#)) NIL))
                              (GO G191)))
                            (SEQ (EXIT (LETT #4# (CONS (QCAR |u|) #4#))))
                            (LETT #3# (CDR #3#)) (GO G190) G191
                            (EXIT (NREVERSE #4#))))
                      (QREFELT $ 34))
                     (|INFORM;conv|
                      (LIST (SPADCALL 'LET (QREFELT $ 16)) |a|
                            (|INFORM;conv|
                             (SPADCALL (SPADCALL |l| (QREFELT $ 35))
                                       (PROGN
                                        (LETT #2# NIL)
                                        (SEQ (LETT |u| NIL) (LETT #1# |l2|)
                                             G190
                                             (COND
                                              ((OR (ATOM #1#)
                                                   (PROGN
                                                    (LETT |u| (CAR #1#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #2#
                                                     (CONS (QCDR |u|) #2#))))
                                             (LETT #1# (CDR #1#)) (GO G190)
                                             G191 (EXIT (NREVERSE #2#))))
                                       (QREFELT $ 36))
                             $))
                      $)
                     (QREFELT $ 37))
                    |a|)))))))) 

(SDEFUN |INFORM;strsym| ((|s| ($)) ($ (|String|)))
        (COND ((SPADCALL |s| (QREFELT $ 42)) (SPADCALL |s| (QREFELT $ 43)))
              ((SPADCALL |s| (QREFELT $ 44))
               (SPADCALL (SPADCALL |s| (QREFELT $ 45)) (QREFELT $ 40)))
              ('T (|error| "strsym: form is neither a string or symbol")))) 

(SDEFUN |INFORM;unparse;$S;13| ((|x| ($)) ($ (|String|)))
        (SPROG ((#1=#:G779 NIL) (|a| NIL) (#2=#:G778 NIL) (|s| ($)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |s| (|unparseInputForm| |x|)) (QREFELT $ 27))
                  (|INFORM;strsym| |s| $))
                 ('T
                  (SPADCALL
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |a| NIL)
                         (LETT #1# (SPADCALL |s| (QREFELT $ 28))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT #2# (CONS (|INFORM;strsym| |a| $) #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   (QREFELT $ 46))))))) 

(PUT '|INFORM;parse;S$;14| '|SPADreplace| '|ncParseFromString|) 

(SDEFUN |INFORM;parse;S$;14| ((|s| (|String|)) ($ ($)))
        (|ncParseFromString| |s|)) 

(SDEFUN |INFORM;declare;LS;15| ((|signature| (|List| $)) ($ (|Symbol|)))
        (SPROG ((|name| (|Symbol|)))
               (SEQ
                (|declare| (LETT |name| (SPADCALL (QREFELT $ 32))) |signature|)
                (EXIT |name|)))) 

(SDEFUN |INFORM;compile;SLS;16|
        ((|name| (|Symbol|)) (|types| (|List| $)) ($ (|Symbol|)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (|selectLocalMms| (|INFORM;mkProperOp| |name| $)
                              (SPADCALL |name| (QREFELT $ 16)) |types| NIL)
            (QREFELT $ 50))
           (QREFELT $ 51))
          (QREFELT $ 50))
         (QREFELT $ 45))) 

(SDEFUN |INFORM;mkProperOp| ((|name| (|Symbol|)) ($ ($)))
        (SPROG ((|op| ($)) (|nme| ($)))
               (SEQ
                (LETT |op|
                      (|mkAtree|
                       (LETT |nme| (SPADCALL |name| (QREFELT $ 16)))))
                (|transferPropsToNode| |nme| |op|) (EXIT |op|)))) 

(SDEFUN |INFORM;binary;$L$;18| ((|op| ($)) (|args| (|List| $)) ($ ($)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (SPADCALL |args| (QREFELT $ 54)))
                    (EXIT
                     (COND ((< |n| 2) (|error| "Need at least 2 arguments"))
                           ((EQL |n| 2)
                            (SPADCALL
                             (LIST |op| (SPADCALL |args| (QREFELT $ 35))
                                   (SPADCALL |args| (QREFELT $ 55)))
                             (QREFELT $ 56)))
                           ('T
                            (SPADCALL
                             (LIST |op| (SPADCALL |args| (QREFELT $ 35))
                                   (SPADCALL |op|
                                             (SPADCALL |args| (QREFELT $ 33))
                                             (QREFELT $ 57)))
                             (QREFELT $ 56)))))))) 

(SDEFUN |INFORM;tuplify| ((|l| (|List| (|Symbol|))) ($ ($)))
        (SPROG ((#1=#:G794 NIL) (|x| NIL) (#2=#:G793 NIL))
               (SEQ
                (COND
                 ((NULL (CDR |l|)) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 16)))
                 ('T
                  (|INFORM;conv|
                   (SPADCALL (SPADCALL '|Tuple| (QREFELT $ 16))
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |x| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS (SPADCALL |x| (QREFELT $ 16))
                                                 #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#))))
                             (QREFELT $ 36))
                   $)))))) 

(SDEFUN |INFORM;function;$LS$;20|
        ((|f| ($)) (|l| (|List| (|Symbol|))) (|name| (|Symbol|)) ($ ($)))
        (SPROG ((#1=#:G800 NIL) (|x| NIL) (#2=#:G799 NIL) (|nn| ($)))
               (SEQ
                (LETT |nn|
                      (SPADCALL
                       (SPADCALL (+ 1 (LENGTH |l|))
                                 (SPADCALL NIL (QREFELT $ 56)) (QREFELT $ 58))
                       (QREFELT $ 56)))
                (EXIT
                 (|INFORM;conv|
                  (LIST (SPADCALL 'DEF (QREFELT $ 16))
                        (|INFORM;conv|
                         (SPADCALL (SPADCALL |name| (QREFELT $ 16))
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN
                                                (LETT |x| (CAR #1#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2#
                                                 (CONS
                                                  (SPADCALL |x| (QREFELT $ 16))
                                                  #2#))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT (NREVERSE #2#))))
                                   (QREFELT $ 59))
                         $)
                        |nn| |nn| |f|)
                  $))))) 

(SDEFUN |INFORM;+;3$;21| ((|s1| ($)) (|s2| ($)) ($ ($)))
        (COND ((SPADCALL |s1| (|spadConstant| $ 9) (QREFELT $ 61)) |s2|)
              ((SPADCALL |s2| (|spadConstant| $ 9) (QREFELT $ 61)) |s1|)
              ('T
               (|INFORM;conv| (LIST (SPADCALL '+ (QREFELT $ 16)) |s1| |s2|)
                $)))) 

(SDEFUN |INFORM;*;3$;22| ((|s1| ($)) (|s2| ($)) ($ ($)))
        (COND
         ((OR (SPADCALL |s1| (|spadConstant| $ 9) (QREFELT $ 61))
              (SPADCALL |s2| (|spadConstant| $ 9) (QREFELT $ 61)))
          (|spadConstant| $ 9))
         ('T
          (COND ((SPADCALL |s1| (|spadConstant| $ 10) (QREFELT $ 61)) |s2|)
                ((SPADCALL |s2| (|spadConstant| $ 10) (QREFELT $ 61)) |s1|)
                ('T
                 (|INFORM;conv| (LIST (SPADCALL '* (QREFELT $ 16)) |s1| |s2|)
                  $)))))) 

(SDEFUN |INFORM;^;$I$;23| ((|s1| ($)) (|n| (|Integer|)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |s1| (|spadConstant| $ 9) (QREFELT $ 61))
           (COND ((> |n| 0) (EXIT (|spadConstant| $ 9))))))
         (COND
          ((OR (SPADCALL |s1| (|spadConstant| $ 10) (QREFELT $ 61))
               (ZEROP |n|))
           (EXIT (|spadConstant| $ 10))))
         (EXIT
          (COND ((EQL |n| 1) |s1|)
                ('T
                 (|INFORM;conv|
                  (LIST (SPADCALL '^ (QREFELT $ 16)) |s1|
                        (SPADCALL |n| (QREFELT $ 8)))
                  $)))))) 

(SDEFUN |INFORM;^;$Nni$;24| ((|s1| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |s1| |n| (QREFELT $ 64))) 

(SDEFUN |INFORM;/;3$;25| ((|s1| ($)) (|s2| ($)) ($ ($)))
        (COND ((SPADCALL |s2| (|spadConstant| $ 10) (QREFELT $ 61)) |s1|)
              ('T
               (|INFORM;conv| (LIST (SPADCALL '/ (QREFELT $ 16)) |s1| |s2|)
                $)))) 

(DECLAIM (NOTINLINE |InputForm;|)) 

(DEFUN |InputForm| ()
  (SPROG NIL
         (PROG (#1=#:G810)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|InputForm|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|InputForm|
                             (LIST (CONS NIL (CONS 1 (|InputForm;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|InputForm|)))))))))) 

(DEFUN |InputForm;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|InputForm|))
          (LETT $ (GETREFV 71))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InputForm| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|SExpression|))
          $))) 

(MAKEPROP '|InputForm| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SExpression|) '|Rep| (|Integer|)
              (0 . |convert|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |INFORM;Zero;$;1|) $))
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |INFORM;One;$;2|) $))
              |INFORM;convert;$Se;3| |INFORM;convert;Se$;4| (|InputForm|)
              (|Symbol|) (5 . |convert|) |INFORM;convert;S$;5| (|List| $)
              (10 . |convert|) (|List| 14) |INFORM;lambda;$L$;7| (|Any|)
              |INFORM;interpret;$A;8| (|DoubleFloat|) (15 . |convert|)
              |INFORM;convert;Df$;9| (|Boolean|) (20 . |atom?|)
              (25 . |destruct|) (|Mapping| 26 $$) (|List| $$) (30 . |every?|)
              (36 . |new|) (40 . |rest|) (45 . |concat|) (50 . |first|)
              (55 . |concat|) (61 . |concat|) |INFORM;flatten;2$;10| (|String|)
              (67 . |string|) (72 . |coerce|) (77 . |string?|) (82 . |string|)
              (87 . |symbol?|) (92 . |symbol|) (97 . |concat|)
              |INFORM;unparse;$S;13| |INFORM;parse;S$;14|
              |INFORM;declare;LS;15| (102 . |car|) (107 . |cdr|)
              |INFORM;compile;SLS;16| (|NonNegativeInteger|) (112 . |#|)
              (117 . |last|) (122 . |convert|) |INFORM;binary;$L$;18|
              (127 . |new|) (133 . |cons|) |INFORM;function;$LS$;20| (139 . =)
              |INFORM;+;3$;21| |INFORM;*;3$;22| |INFORM;^;$I$;23|
              |INFORM;^;$Nni$;24| |INFORM;/;3$;25| (|List| 7) (|SingleInteger|)
              (|HashState|) (|OutputForm|))
           '#(|unparse| 145 |symbol?| 150 |symbol| 155 |string?| 160 |string|
              165 |parse| 170 |lambda| 175 |interpret| 181 |function| 186
              |flatten| 193 |destruct| 198 |declare| 203 |convert| 208
              |compile| 238 |cdr| 244 |car| 249 |binary| 254 |atom?| 260 ^ 265
              |Zero| 277 |One| 281 = 285 / 291 + 297 * 303)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL NIL)
                       (CONS
                        '#((|SExpressionCategory| 39 14 7 23) (|SetCategory|)
                           (|BasicType|) (|ConvertibleTo| 5)
                           (|CoercibleTo| 70))
                        (|makeByteWordVec2| 66
                                            '(1 0 0 7 8 1 14 13 0 15 1 5 0 17
                                              18 1 6 0 23 24 1 0 26 0 27 1 0 17
                                              0 28 2 30 26 29 0 31 0 14 0 32 1
                                              30 0 0 33 1 30 0 17 34 1 30 2 0
                                              35 2 30 0 2 0 36 2 30 0 0 2 37 1
                                              14 39 0 40 1 14 0 39 41 1 0 26 0
                                              42 1 0 39 0 43 1 0 26 0 44 1 0 14
                                              0 45 1 39 0 17 46 1 0 0 0 50 1 0
                                              0 0 51 1 30 53 0 54 1 30 2 0 55 1
                                              0 0 17 56 2 30 0 53 2 58 2 30 0 2
                                              0 59 2 0 26 0 0 61 1 0 39 0 47 1
                                              0 26 0 44 1 0 14 0 45 1 0 26 0 42
                                              1 0 39 0 43 1 0 0 39 48 2 0 0 0
                                              19 20 1 0 21 0 22 3 0 0 0 19 14
                                              60 1 0 0 0 38 1 0 17 0 28 1 0 14
                                              17 49 1 0 0 5 12 1 0 5 0 11 1 0 0
                                              23 25 1 0 0 7 8 1 0 0 14 16 1 0 0
                                              17 56 2 0 14 14 17 52 1 0 0 0 51
                                              1 0 0 0 50 2 0 0 0 17 57 1 0 26 0
                                              27 2 0 0 0 53 65 2 0 0 0 7 64 0 0
                                              0 9 0 0 0 10 2 0 26 0 0 61 2 0 0
                                              0 0 66 2 0 0 0 0 62 2 0 0 0 0
                                              63)))))
           '|lookupIncomplete|)) 

(MAKEPROP '|InputForm| 'NILADIC T) 
