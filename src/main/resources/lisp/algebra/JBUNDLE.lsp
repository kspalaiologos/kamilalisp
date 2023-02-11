
(SDEFUN |JBUNDLE;setNotation;2S;1| ((|s| (|Symbol|)) ($ (|Symbol|)))
        (SEQ
         (SPADCALL
          (SPADCALL "only repeated index notation possible" (QREFELT $ 18))
          (QREFELT $ 20))
         (EXIT '|Repeated|))) 

(PUT '|JBUNDLE;getNotation;S;2| '|SPADreplace| '(XLAM NIL '|Repeated|)) 

(SDEFUN |JBUNDLE;getNotation;S;2| (($ (|Symbol|))) '|Repeated|) 

(SDEFUN |JBUNDLE;multiIndex;$L;3|
        ((|jv| ($)) ($ (|List| (|NonNegativeInteger|))))
        (SPADCALL (CDR (CDR |jv|)) (QREFELT $ 24))) 

(SDEFUN |JBUNDLE;index;$Pi;4| ((|jv| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G715 NIL))
               (PROG1 (LETT #1# (|SPADfirst| (CDR |jv|)))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |JBUNDLE;type;$S;5| ((|jv| ($)) ($ (|Symbol|)))
        (SPROG ((|t| (|NonNegativeInteger|)))
               (SEQ (LETT |t| (|SPADfirst| |jv|))
                    (EXIT
                     (COND ((ZEROP |t|) '|Const|) ((EQL |t| 1) '|Indep|)
                           ((EQL |t| 2) '|Dep|) ('T '|Deriv|)))))) 

(SDEFUN |JBUNDLE;CheckZeroIndex|
        ((|il| (|List| (|NonNegativeInteger|))) ($ (|Boolean|)))
        (SPROG ((#1=#:G725 NIL) (#2=#:G726 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| NIL) (LETT #2# |il|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL (ZEROP |i|))
                           (PROGN (LETT #1# NIL) (GO #3=#:G724))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |JBUNDLE;X;Pi$;7| ((|up| (|PositiveInteger|)) ($ ($)))
        (COND ((> |up| (QREFELT $ 8)) (|error| "Improper upper index"))
              ('T (LIST 1 |up|)))) 

(SDEFUN |JBUNDLE;U;Pi$;8| ((|up| (|PositiveInteger|)) ($ ($)))
        (SPROG ((#1=#:G734 NIL) (|i| NIL) (#2=#:G733 NIL))
               (SEQ
                (COND ((> |up| (QREFELT $ 9)) (|error| "Improper upper index"))
                      ('T
                       (CONS 2
                             (CONS |up|
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 8))
                                         G190
                                         (COND
                                          ((|greater_SI| |i| #1#) (GO G191)))
                                         (SEQ (EXIT (LETT #2# (CONS 0 #2#))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |JBUNDLE;Pm;PiL$;9|
        ((|up| (|PositiveInteger|)) (|lo| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (COND ((> |up| (QREFELT $ 9)) (|error| "Improper upper index"))
              ((SPADCALL (SPADCALL |lo| (QREFELT $ 34)) (QREFELT $ 8)
                         (QREFELT $ 36))
               (|error| "Improper multi-index"))
              ((|JBUNDLE;CheckZeroIndex| |lo| $)
               (SPADCALL |up| (QREFELT $ 32)))
              ('T (CONS 3 (CONS |up| |lo|))))) 

(SDEFUN |JBUNDLE;coerce;S$;10| ((|s| (|Symbol|)) ($ ($)))
        (SPROG ((#1=#:G744 NIL) (#2=#:G741 NIL) (|pos| (|Integer|)))
               (SEQ (LETT |pos| (SPADCALL |s| (QREFELT $ 6) (QREFELT $ 39)))
                    (EXIT
                     (COND
                      ((< |pos| (PROGN (QREFELT $ 6) 1))
                       (SEQ
                        (LETT |pos|
                              (SPADCALL |s| (QREFELT $ 7) (QREFELT $ 39)))
                        (EXIT
                         (COND
                          ((< |pos| (PROGN (QREFELT $ 7) 1))
                           (|error| "illegal symbol in JetBundle"))
                          (#3='T
                           (SPADCALL
                            (PROG1 (LETT #2# |pos|)
                              (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                                '(|Integer|) #2#))
                            (QREFELT $ 32)))))))
                      (#3#
                       (SPADCALL
                        (PROG1 (LETT #1# |pos|)
                          (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                            '(|Integer|) #1#))
                        (QREFELT $ 31)))))))) 

(SDEFUN |JBUNDLE;D;SL$;11|
        ((|u| (|Symbol|)) (|der| (|List| (|Symbol|))) ($ ($)))
        (SPROG
         ((#1=#:G753 NIL) (|lower| (|List| (|PositiveInteger|)))
          (#2=#:G749 NIL) (|pos| #3=(|Integer|)) (#4=#:G757 NIL) (|d| NIL)
          (|up| #3#))
         (SEQ (LETT |up| (SPADCALL |u| (QREFELT $ 7) (QREFELT $ 39)))
              (EXIT
               (COND
                ((< |up| (PROGN (QREFELT $ 7) 1))
                 (|error| #5="illegal symbol in JetBundle"))
                ('T
                 (SEQ (LETT |lower| NIL)
                      (SEQ (LETT |d| NIL) (LETT #4# |der|) G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |d| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |pos|
                                  (SPADCALL |d| (QREFELT $ 6) (QREFELT $ 39)))
                            (EXIT
                             (COND
                              ((< |pos| (PROGN (QREFELT $ 6) 1)) (|error| #5#))
                              ('T
                               (LETT |lower|
                                     (CONS
                                      (PROG1 (LETT #2# |pos|)
                                        (|check_subtype2| (> #2# 0)
                                                          '(|PositiveInteger|)
                                                          '(|Integer|) #2#))
                                      |lower|))))))
                           (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                      (LETT |lower| (NREVERSE |lower|))
                      (EXIT
                       (SPADCALL
                        (PROG1 (LETT #1# |up|)
                          (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                            '(|Integer|) #1#))
                        |lower| (QREFELT $ 42)))))))))) 

(PUT '|JBUNDLE;One;$;12| '|SPADreplace| '(XLAM NIL (LIST 0 1))) 

(SDEFUN |JBUNDLE;One;$;12| (($ ($))) (LIST 0 1)) 

(SDEFUN |JBUNDLE;numIndVar;Pi;13| (($ (|PositiveInteger|)))
        (SPROG ((#1=#:G759 NIL))
               (PROG1 (LETT #1# (QREFELT $ 8))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |JBUNDLE;numDepVar;Pi;14| (($ (|PositiveInteger|)))
        (SPROG ((#1=#:G761 NIL))
               (PROG1 (LETT #1# (QREFELT $ 9))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |JBUNDLE;name;$S;15| ((|jv| ($)) ($ (|Symbol|)))
        (SPROG
         ((|lower| (|List| (|OutputForm|))) (#1=#:G775 NIL) (|j| NIL)
          (|res| (|Symbol|)) (|mu| (|List| (|PositiveInteger|)))
          (|i| (|PositiveInteger|)) (|jt| (|Symbol|)))
         (SEQ
          (COND
           ((EQUAL (LETT |jt| (SPADCALL |jv| (QREFELT $ 29))) '|Const|) '|1|)
           (#2='T
            (SEQ (LETT |i| (SPADCALL |jv| (QREFELT $ 28)))
                 (EXIT
                  (COND ((EQUAL |jt| '|Indep|) (QAREF1O (QREFELT $ 13) |i| 1))
                        ((EQUAL |jt| '|Dep|) (QAREF1O (QREFELT $ 14) |i| 1))
                        (#2#
                         (SEQ (LETT |mu| (SPADCALL |jv| (QREFELT $ 46)))
                              (LETT |res| (QAREF1O (QREFELT $ 14) |i| 1))
                              (LETT |lower| NIL)
                              (SEQ (LETT |j| NIL) (LETT #1# |mu|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |j| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |lower|
                                           (CONS
                                            (SPADCALL
                                             (QAREF1O (QREFELT $ 13) |j| 1)
                                             (QREFELT $ 47))
                                            |lower|))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT NIL))
                              (LETT |lower| (NREVERSE |lower|))
                              (EXIT
                               (SPADCALL |res| |lower|
                                         (QREFELT $ 49))))))))))))) 

(PUT '|JBUNDLE;opdisp| '|SPADreplace| '|SPADfirst|) 

(SDEFUN |JBUNDLE;opdisp| ((|l| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (|SPADfirst| |l|)) 

(SDEFUN |JBUNDLE;coerce;$E;17| ((|jv| ($)) ($ (|Expression| (|Integer|))))
        (SPROG
         ((|arg| (|List| (|Expression| (|Integer|)))) (#1=#:G786 NIL) (|i| NIL)
          (#2=#:G785 NIL) (|jop| (|BasicOperator|)) (|tmp| (|None|))
          (|opname| (|Symbol|)))
         (SEQ
          (COND
           ((EQUAL (SPADCALL |jv| (QREFELT $ 29)) '|Const|)
            (|spadConstant| $ 52))
           ('T
            (SEQ (LETT |opname| (SPADCALL |jv| (QREFELT $ 50)))
                 (LETT |jop| (SPADCALL |opname| (QREFELT $ 54)))
                 (SPADCALL |jop| (CONS (|function| |JBUNDLE;opdisp|) $)
                           (QREFELT $ 56))
                 (LETT |tmp| (SPADCALL |jv| (QREFELT $ 59)))
                 (LETT |jop| (SPADCALL |jop| '|%symbol| |tmp| (QREFELT $ 60)))
                 (LETT |tmp|
                       (SPADCALL (SPADCALL |jv| (QREFELT $ 61))
                                 (QREFELT $ 63)))
                 (LETT |jop| (SPADCALL |jop| '|%weight| |tmp| (QREFELT $ 60)))
                 (LETT |tmp|
                       (SPADCALL (SPADCALL |jv| (QREFELT $ 29))
                                 (QREFELT $ 65)))
                 (LETT |jop| (SPADCALL |jop| '|%jet| |tmp| (QREFELT $ 60)))
                 (LETT |arg|
                       (SPADCALL
                        (LIST (SPADCALL |opname| (QREFELT $ 66))
                              (SPADCALL (SPADCALL |jv| (QREFELT $ 28))
                                        (QREFELT $ 67)))
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |i| NIL)
                              (LETT #1# (SPADCALL |jv| (QREFELT $ 46))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |i| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |i| (QREFELT $ 67))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QREFELT $ 69)))
                 (EXIT (SPADCALL |jop| |arg| (QREFELT $ 71))))))))) 

(DECLAIM (NOTINLINE |JetBundle;|)) 

(DEFUN |JetBundle| (&REST #1=#:G793)
  (SPROG NIL
         (PROG (#2=#:G794)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL NIL))
                                               (HGET |$ConstructorCache|
                                                     '|JetBundle|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetBundle;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|JetBundle|)))))))))) 

(DEFUN |JetBundle;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 |#2|)
          (LETT |dv$| (LIST '|JetBundle| DV$1 DV$2))
          (LETT $ (GETREFV 78))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|JetBundle| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (LENGTH |#1|))
          (QSETREFV $ 9 (LENGTH |#2|))
          (QSETREFV $ 13 (SPADCALL |#1| (QREFELT $ 12)))
          (QSETREFV $ 14 (SPADCALL |#2| (QREFELT $ 12)))
          (QSETREFV $ 15 (|List| (|NonNegativeInteger|)))
          $))) 

(MAKEPROP '|JetBundle| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|nn| '|mm|
              (|List| 21) (|Vector| 21) (0 . |construct|) '|nameX| '|nameU|
              '|Rep| (|String|) (|OutputForm|) (5 . |message|) (|Void|)
              (10 . |print|) (|Symbol|) |JBUNDLE;setNotation;2S;1|
              |JBUNDLE;getNotation;S;2| (15 . |copy|) (|List| 33)
              |JBUNDLE;multiIndex;$L;3| (|PositiveInteger|)
              |JBUNDLE;index;$Pi;4| |JBUNDLE;type;$S;5|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |JBUNDLE;One;$;12|) $))
              |JBUNDLE;X;Pi$;7| |JBUNDLE;U;Pi$;8| (|NonNegativeInteger|)
              (20 . |#|) (|Boolean|) (25 . ~=) |JBUNDLE;Pm;PiL$;9| (|Integer|)
              (31 . |position|) |JBUNDLE;coerce;S$;10| (|List| 27) (37 . |Pr|)
              |JBUNDLE;D;SL$;11| |JBUNDLE;numIndVar;Pi;13|
              |JBUNDLE;numDepVar;Pi;14| (43 . |repeatedIndex|) (48 . |coerce|)
              (|List| 17) (53 . |subscript|) |JBUNDLE;name;$S;15|
              (|Expression| 38) (59 . |One|) (|BasicOperator|)
              (63 . |operator|) (|Mapping| 17 48) (68 . |display|) (|None|)
              (|NoneFunctions1| $$) (74 . |coerce|) (79 . |setProperty|)
              (86 . |weight|) (|NoneFunctions1| 33) (91 . |coerce|)
              (|NoneFunctions1| 21) (96 . |coerce|) (101 . |coerce|)
              (106 . |coerce|) (|List| 51) (111 . |concat!|) (|List| $)
              (117 . |kernel|) |JBUNDLE;coerce;$E;17| (|Union| $ '"failed")
              (|Union| $ '"0") (|List| 41) (|HashState|) (|SingleInteger|))
           '#(~= 123 |weight| 129 |variables| 134 |type| 145 |smaller?| 150
              |setNotation| 156 |repeatedIndex| 161 |r2m| 166 |order| 171
              |one?| 176 |numIndVar| 181 |numDepVar| 185 |name| 189
              |multiIndex| 194 |min| 199 |max| 205 |m2r| 211 |latex| 216
              |integrateIfCan| 221 |integrate| 227 |index| 233 |hashUpdate!|
              238 |hash| 244 |getNotation| 249 |dimS| 253 |dimJ| 258
              |differentiate| 263 |derivativeOf?| 269 |coerce| 275 |class| 290
              |allRepeated| 300 X 305 U 314 |Pr| 323 |Pm| 329 P 335 |One| 357 D
              361 >= 367 > 373 = 379 <= 385 < 391)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|JetBundleCategory&| |OrderedSet&| NIL |SetCategory&|
                     |BasicType&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|JetBundleCategory|) (|OrderedSet|) (|Comparable|)
                      (|SetCategory|) (|BasicType|) (|CoercibleTo| 51)
                      (|PartialOrder|) (|CoercibleTo| 17))
                   (|makeByteWordVec2| 77
                                       '(1 11 0 10 12 1 17 0 16 18 1 17 19 0 20
                                         1 15 0 0 24 1 15 33 0 34 2 33 35 0 0
                                         36 2 10 38 21 0 39 2 0 0 27 41 42 1 0
                                         41 0 46 1 21 17 0 47 2 21 0 0 48 49 0
                                         51 0 52 1 53 0 21 54 2 53 0 0 55 56 1
                                         58 57 2 59 3 53 0 0 21 57 60 1 0 33 0
                                         61 1 62 57 33 63 1 64 57 21 65 1 51 0
                                         21 66 1 51 0 38 67 2 68 0 0 0 69 2 51
                                         0 53 70 71 2 0 35 0 0 1 1 0 33 0 61 2
                                         0 70 33 27 1 1 0 70 33 1 1 0 21 0 29 2
                                         0 35 0 0 1 1 0 21 21 22 1 0 41 0 46 1
                                         0 25 41 1 1 0 33 0 1 1 0 35 0 1 0 0 27
                                         44 0 0 27 45 1 0 21 0 50 1 0 25 0 26 2
                                         0 0 0 0 1 2 0 0 0 0 1 1 0 41 25 1 1 0
                                         16 0 1 2 0 73 0 27 1 2 0 0 0 27 1 1 0
                                         27 0 28 2 0 76 76 0 1 1 0 77 0 1 0 0
                                         21 23 1 0 33 33 1 1 0 33 33 1 2 0 74 0
                                         27 1 2 0 25 0 0 1 1 0 0 21 40 1 0 51 0
                                         72 1 0 17 0 1 1 0 33 0 1 1 0 33 25 1 1
                                         0 75 25 1 0 0 0 1 1 0 0 27 31 0 0 0 1
                                         1 0 0 27 32 2 0 0 27 41 42 2 0 0 27 25
                                         37 1 0 0 33 1 1 0 0 25 1 2 0 0 27 33 1
                                         2 0 0 27 25 1 0 0 0 30 2 0 0 21 10 43
                                         2 0 35 0 0 1 2 0 35 0 0 1 2 0 35 0 0 1
                                         2 0 35 0 0 1 2 0 35 0 0 1)))))
           '|lookupComplete|)) 
