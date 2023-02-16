
(SDEFUN |IJB;setNotation;2S;1| ((|s| (|Symbol|)) ($ (|Symbol|)))
        (SPROG ((|t| (|Symbol|)))
               (SEQ
                (COND
                 ((NULL
                   (SPADCALL |s| (LIST '|Multi| '|Repeated|) (QREFELT $ 16)))
                  (|error| "Unknown notation"))
                 ('T
                  (SEQ (LETT |t| (QREFELT $ 12)) (SETELT $ 12 |s|)
                       (EXIT |t|))))))) 

(SDEFUN |IJB;getNotation;S;2| (($ (|Symbol|))) (QREFELT $ 12)) 

(SDEFUN |IJB;multiIndex;$L;3| ((|jv| ($)) ($ (|List| (|NonNegativeInteger|))))
        (SPADCALL (CDR (CDR |jv|)) (QREFELT $ 19))) 

(SDEFUN |IJB;index;$Pi;4| ((|jv| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G710 NIL))
               (PROG1 (LETT #1# (|SPADfirst| (CDR |jv|)))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |IJB;type;$S;5| ((|jv| ($)) ($ (|Symbol|)))
        (SPROG ((|t| (|NonNegativeInteger|)))
               (SEQ (LETT |t| (|SPADfirst| |jv|))
                    (EXIT
                     (COND ((ZEROP |t|) '|Const|) ((EQL |t| 1) '|Indep|)
                           ((EQL |t| 2) '|Dep|) ('T '|Deriv|)))))) 

(SDEFUN |IJB;CheckZeroIndex|
        ((|il| (|List| (|NonNegativeInteger|))) ($ (|Boolean|)))
        (SPROG ((#1=#:G720 NIL) (#2=#:G721 NIL) (|i| NIL))
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
                           (PROGN (LETT #1# NIL) (GO #3=#:G719))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |IJB;X;Pi$;7| ((|up| (|PositiveInteger|)) ($ ($)))
        (COND ((> |up| (QREFELT $ 9)) (|error| "Improper upper index"))
              ('T (LIST 1 |up|)))) 

(SDEFUN |IJB;U;Pi$;8| ((|up| (|PositiveInteger|)) ($ ($)))
        (SPROG ((#1=#:G729 NIL) (|i| NIL) (#2=#:G728 NIL))
               (SEQ
                (COND
                 ((> |up| (QREFELT $ 10)) (|error| "Improper upper index"))
                 ('T
                  (CONS 2
                        (CONS |up|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 9)) G190
                                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                                    (SEQ (EXIT (LETT #2# (CONS 0 #2#))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |IJB;Pm;PiL$;9|
        ((|up| (|PositiveInteger|)) (|lo| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (COND ((> |up| (QREFELT $ 10)) (|error| "Improper upper index"))
              ((SPADCALL (SPADCALL |lo| (QREFELT $ 28)) (QREFELT $ 9)
                         (QREFELT $ 29))
               (|error| "Improper multi-index"))
              ((|IJB;CheckZeroIndex| |lo| $) (SPADCALL |up| (QREFELT $ 26)))
              ('T (CONS 3 (CONS |up| |lo|))))) 

(PUT '|IJB;One;$;10| '|SPADreplace| '(XLAM NIL (LIST 0 1))) 

(SDEFUN |IJB;One;$;10| (($ ($))) (LIST 0 1)) 

(SDEFUN |IJB;numIndVar;Pi;11| (($ (|PositiveInteger|))) (QREFELT $ 9)) 

(SDEFUN |IJB;numDepVar;Pi;12| (($ (|PositiveInteger|))) (QREFELT $ 10)) 

(SDEFUN |IJB;name;$S;13| ((|jv| ($)) ($ (|Symbol|)))
        (SPROG
         ((#1=#:G761 NIL) (|j| NIL) (#2=#:G760 NIL) (#3=#:G759 NIL)
          (#4=#:G758 NIL) (#5=#:G757 NIL) (|i| NIL) (#6=#:G756 NIL)
          (#7=#:G755 NIL) (#8=#:G754 NIL) (|jt| (|Symbol|)))
         (SEQ (LETT |jt| (SPADCALL |jv| (QREFELT $ 24)))
              (EXIT
               (COND ((EQUAL |jt| '|Const|) '|1|)
                     ((EQUAL |jt| '|Indep|)
                      (COND
                       ((> (QREFELT $ 9) 1)
                        (SPADCALL (QREFELT $ 6)
                                  (LIST
                                   (SPADCALL (SPADCALL |jv| (QREFELT $ 23))
                                             (QREFELT $ 35)))
                                  (QREFELT $ 37)))
                       (#9='T (QREFELT $ 6))))
                     ((EQUAL |jt| '|Dep|)
                      (COND
                       ((> (QREFELT $ 10) 1)
                        (SPADCALL (QREFELT $ 7)
                                  (LIST
                                   (SPADCALL (SPADCALL |jv| (QREFELT $ 23))
                                             (QREFELT $ 35)))
                                  (QREFELT $ 37)))
                       (#9# (QREFELT $ 7))))
                     ((EQUAL (SPADCALL (QREFELT $ 18)) '|Multi|)
                      (COND
                       ((> (QREFELT $ 10) 1)
                        (SPADCALL (QREFELT $ 8)
                                  (VECTOR
                                   (LIST
                                    (SPADCALL
                                     (PROGN
                                      (LETT #8# NIL)
                                      (SEQ (LETT |i| NIL)
                                           (LETT #7#
                                                 (SPADCALL |jv|
                                                           (QREFELT $ 21)))
                                           G190
                                           (COND
                                            ((OR (ATOM #7#)
                                                 (PROGN
                                                  (LETT |i| (CAR #7#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #8#
                                                   (CONS
                                                    (SPADCALL |i|
                                                              (QREFELT $ 38))
                                                    #8#))))
                                           (LETT #7# (CDR #7#)) (GO G190) G191
                                           (EXIT (NREVERSE #8#))))
                                     (QREFELT $ 40)))
                                   (LIST
                                    (SPADCALL (SPADCALL |jv| (QREFELT $ 23))
                                              (QREFELT $ 35)))
                                   NIL NIL NIL)
                                  (QREFELT $ 42)))
                       (#9#
                        (SPADCALL (QREFELT $ 8)
                                  (LIST
                                   (SPADCALL
                                    (PROGN
                                     (LETT #6# NIL)
                                     (SEQ (LETT |i| NIL)
                                          (LETT #5#
                                                (SPADCALL |jv| (QREFELT $ 21)))
                                          G190
                                          (COND
                                           ((OR (ATOM #5#)
                                                (PROGN
                                                 (LETT |i| (CAR #5#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #6#
                                                  (CONS
                                                   (SPADCALL |i|
                                                             (QREFELT $ 38))
                                                   #6#))))
                                          (LETT #5# (CDR #5#)) (GO G190) G191
                                          (EXIT (NREVERSE #6#))))
                                    (QREFELT $ 40)))
                                  (QREFELT $ 43)))))
                     ((> (QREFELT $ 10) 1)
                      (SPADCALL (QREFELT $ 8)
                                (VECTOR
                                 (LIST
                                  (SPADCALL
                                   (PROGN
                                    (LETT #4# NIL)
                                    (SEQ (LETT |j| NIL)
                                         (LETT #3#
                                               (SPADCALL |jv| (QREFELT $ 45)))
                                         G190
                                         (COND
                                          ((OR (ATOM #3#)
                                               (PROGN
                                                (LETT |j| (CAR #3#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #4#
                                                 (CONS
                                                  (SPADCALL |j| (QREFELT $ 35))
                                                  #4#))))
                                         (LETT #3# (CDR #3#)) (GO G190) G191
                                         (EXIT (NREVERSE #4#))))
                                   (QREFELT $ 46)))
                                 (LIST
                                  (SPADCALL (SPADCALL |jv| (QREFELT $ 23))
                                            (QREFELT $ 35)))
                                 NIL NIL NIL)
                                (QREFELT $ 42)))
                     (#9#
                      (SPADCALL (QREFELT $ 8)
                                (LIST
                                 (SPADCALL
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |j| NIL)
                                        (LETT #1#
                                              (SPADCALL |jv| (QREFELT $ 45)))
                                        G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |j| (CAR #1#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL |j| (QREFELT $ 35))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#))))
                                  (QREFELT $ 46)))
                                (QREFELT $ 43)))))))) 

(PUT '|IJB;opdisp| '|SPADreplace| '|SPADfirst|) 

(SDEFUN |IJB;opdisp| ((|l| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (|SPADfirst| |l|)) 

(SDEFUN |IJB;coerce;$E;15| ((|jv| ($)) ($ (|Expression| (|Integer|))))
        (SPROG
         ((|arg| (|List| (|Expression| (|Integer|)))) (#1=#:G775 NIL) (|j| NIL)
          (#2=#:G774 NIL) (#3=#:G773 NIL) (|i| NIL) (#4=#:G772 NIL)
          (|jop| (|BasicOperator|)) (|tmp| (|None|)) (|opname| (|Symbol|)))
         (SEQ
          (COND
           ((EQUAL (SPADCALL |jv| (QREFELT $ 24)) '|Const|)
            (|spadConstant| $ 49))
           (#5='T
            (SEQ (LETT |opname| (SPADCALL |jv| (QREFELT $ 47)))
                 (LETT |jop| (SPADCALL |opname| (QREFELT $ 51)))
                 (SPADCALL |jop| (CONS (|function| |IJB;opdisp|) $)
                           (QREFELT $ 53))
                 (LETT |tmp| (SPADCALL |jv| (QREFELT $ 56)))
                 (LETT |jop| (SPADCALL |jop| '|%symbol| |tmp| (QREFELT $ 57)))
                 (LETT |tmp|
                       (SPADCALL (SPADCALL |jv| (QREFELT $ 58))
                                 (QREFELT $ 60)))
                 (LETT |jop| (SPADCALL |jop| '|%weight| |tmp| (QREFELT $ 57)))
                 (LETT |tmp|
                       (SPADCALL (SPADCALL |jv| (QREFELT $ 24))
                                 (QREFELT $ 62)))
                 (LETT |jop| (SPADCALL |jop| '|%jet| |tmp| (QREFELT $ 57)))
                 (COND
                  ((EQUAL (SPADCALL (QREFELT $ 18)) '|Multi|)
                   (LETT |arg|
                         (PROGN
                          (LETT #4# NIL)
                          (SEQ (LETT |i| NIL)
                               (LETT #3# (SPADCALL |jv| (QREFELT $ 21))) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |i| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #4#
                                       (CONS (SPADCALL |i| (QREFELT $ 64))
                                             #4#))))
                               (LETT #3# (CDR #3#)) (GO G190) G191
                               (EXIT (NREVERSE #4#))))))
                  (#5#
                   (LETT |arg|
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |j| NIL)
                               (LETT #1# (SPADCALL |jv| (QREFELT $ 45))) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |j| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS (SPADCALL |j| (QREFELT $ 64))
                                             #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#)))))))
                 (LETT |arg|
                       (SPADCALL
                        (LIST (SPADCALL |opname| (QREFELT $ 65))
                              (SPADCALL (SPADCALL |jv| (QREFELT $ 23))
                                        (QREFELT $ 64)))
                        |arg| (QREFELT $ 67)))
                 (EXIT (SPADCALL |jop| |arg| (QREFELT $ 68))))))))) 

(DECLAIM (NOTINLINE |IndexedJetBundle;|)) 

(DEFUN |IndexedJetBundle| (&REST #1=#:G782)
  (SPROG NIL
         (PROG (#2=#:G783)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL NIL NIL NIL))
                     (HGET |$ConstructorCache| '|IndexedJetBundle|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |IndexedJetBundle;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IndexedJetBundle|)))))))))) 

(DEFUN |IndexedJetBundle;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT DV$5 |#5|)
    (LETT |dv$| (LIST '|IndexedJetBundle| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 76))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|IndexedJetBundle|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 11 (|List| (|NonNegativeInteger|)))
    (QSETREFV $ 12 '|Repeated|)
    $))) 

(MAKEPROP '|IndexedJetBundle| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) '|Rep| '|notation|
              (|Boolean|) (|Symbol|) (|List| 14) (0 . |member?|)
              |IJB;setNotation;2S;1| |IJB;getNotation;S;2| (6 . |copy|)
              (|List| 27) |IJB;multiIndex;$L;3| (|PositiveInteger|)
              |IJB;index;$Pi;4| |IJB;type;$S;5| |IJB;X;Pi$;7| |IJB;U;Pi$;8|
              (|NonNegativeInteger|) (11 . |#|) (16 . ~=) |IJB;Pm;PiL$;9|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |IJB;One;$;10|) $))
              |IJB;numIndVar;Pi;11| |IJB;numDepVar;Pi;12| (|OutputForm|)
              (22 . |coerce|) (|List| 34) (27 . |superscript|) (33 . |coerce|)
              (|List| $) (38 . |bracket|)
              (|Record| (|:| |sub| 36) (|:| |sup| 36) (|:| |presup| 36)
                        (|:| |presub| 36) (|:| |args| 36))
              (43 . |script|) (49 . |subscript|) (|List| 22)
              (55 . |repeatedIndex|) (60 . |blankSeparate|) |IJB;name;$S;13|
              (|Expression| 63) (65 . |One|) (|BasicOperator|)
              (69 . |operator|) (|Mapping| 34 36) (74 . |display|) (|None|)
              (|NoneFunctions1| $$) (80 . |coerce|) (85 . |setProperty|)
              (92 . |weight|) (|NoneFunctions1| 27) (97 . |coerce|)
              (|NoneFunctions1| 14) (102 . |coerce|) (|Integer|)
              (107 . |coerce|) (112 . |coerce|) (|List| 48) (117 . |concat!|)
              (123 . |kernel|) |IJB;coerce;$E;15| (|Union| $ '"failed")
              (|Union| $ '"0") (|List| 44) (|HashState|) (|String|)
              (|SingleInteger|))
           '#(~= 129 |weight| 135 |variables| 140 |type| 151 |smaller?| 156
              |setNotation| 162 |repeatedIndex| 167 |r2m| 172 |order| 177
              |one?| 182 |numIndVar| 187 |numDepVar| 191 |name| 195
              |multiIndex| 200 |min| 205 |max| 211 |m2r| 217 |latex| 222
              |integrateIfCan| 227 |integrate| 233 |index| 239 |hashUpdate!|
              244 |hash| 250 |getNotation| 255 |dimS| 259 |dimJ| 264
              |differentiate| 269 |derivativeOf?| 275 |coerce| 281 |class| 291
              |allRepeated| 301 X 306 U 315 |Pr| 324 |Pm| 330 P 336 |One| 358
              >= 362 > 368 = 374 <= 380 < 386)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|JetBundleCategory&| |OrderedSet&| NIL |SetCategory&|
                     |BasicType&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|JetBundleCategory|) (|OrderedSet|) (|Comparable|)
                      (|SetCategory|) (|BasicType|) (|CoercibleTo| 48)
                      (|PartialOrder|) (|CoercibleTo| 34))
                   (|makeByteWordVec2| 75
                                       '(2 15 13 14 0 16 1 11 0 0 19 1 11 27 0
                                         28 2 27 13 0 0 29 1 22 34 0 35 2 14 0
                                         0 36 37 1 27 34 0 38 1 34 0 39 40 2 14
                                         0 0 41 42 2 14 0 0 36 43 1 0 44 0 45 1
                                         34 0 39 46 0 48 0 49 1 50 0 14 51 2 50
                                         0 0 52 53 1 55 54 2 56 3 50 0 0 14 54
                                         57 1 0 27 0 58 1 59 54 27 60 1 61 54
                                         14 62 1 48 0 63 64 1 48 0 14 65 2 66 0
                                         0 0 67 2 48 0 50 39 68 2 0 13 0 0 1 1
                                         0 27 0 58 1 0 39 27 1 2 0 39 27 22 1 1
                                         0 14 0 24 2 0 13 0 0 1 1 0 14 14 17 1
                                         0 44 0 45 1 0 20 44 1 1 0 27 0 1 1 0
                                         13 0 1 0 0 22 32 0 0 22 33 1 0 14 0 47
                                         1 0 20 0 21 2 0 0 0 0 1 2 0 0 0 0 1 1
                                         0 44 20 1 1 0 74 0 1 2 0 70 0 22 1 2 0
                                         0 0 22 1 1 0 22 0 23 2 0 73 73 0 1 1 0
                                         75 0 1 0 0 14 18 1 0 27 27 1 1 0 27 27
                                         1 2 0 71 0 22 1 2 0 20 0 0 1 1 0 48 0
                                         69 1 0 34 0 1 1 0 27 0 1 1 0 27 20 1 1
                                         0 72 20 1 0 0 0 1 1 0 0 22 25 0 0 0 1
                                         1 0 0 22 26 2 0 0 22 44 1 2 0 0 22 20
                                         30 1 0 0 27 1 1 0 0 20 1 2 0 0 22 27 1
                                         2 0 0 22 20 1 0 0 0 31 2 0 13 0 0 1 2
                                         0 13 0 0 1 2 0 13 0 0 1 2 0 13 0 0 1 2
                                         0 13 0 0 1)))))
           '|lookupComplete|)) 
