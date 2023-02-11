
(SDEFUN |GENUPS1;genStream|
        ((|f| (|Mapping| R (|Integer|))) (|n| (|Integer|)) ($ (|Stream| R)))
        (SPROG NIL
               (SPADCALL (CONS #'|GENUPS1;genStream!0| (VECTOR $ |f| |n|))
                         (QREFELT $ 14)))) 

(SDEFUN |GENUPS1;genStream!0| (($$ NIL))
        (PROG (|n| |f| $)
          (LETT |n| (QREFELT $$ 2))
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |n| |f|)
                      (|GENUPS1;genStream| |f|
                       (SPADCALL |n| (|spadConstant| $ 9) (QREFELT $ 10)) $)
                      (QREFELT $ 12)))))) 

(SDEFUN |GENUPS1;genFiniteStream|
        ((|f| (|Mapping| R (|Integer|))) (|n| (|Integer|)) (|m| (|Integer|))
         ($ (|Stream| R)))
        (COND ((> |n| |m|) (SPADCALL (QREFELT $ 15)))
              ('T (|GENUPS1;genFiniteStream0| |f| |n| |m| $)))) 

(SDEFUN |GENUPS1;genFiniteStream0|
        ((|f| (|Mapping| R (|Integer|))) (|n| (|Integer|)) (|m| (|Integer|))
         ($ (|Stream| R)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GENUPS1;genFiniteStream0!0| (VECTOR |f| $ |m| |n|))
                (QREFELT $ 14)))) 

(SDEFUN |GENUPS1;genFiniteStream0!0| (($$ NIL))
        (PROG (|n| |m| $ |f|)
          (LETT |n| (QREFELT $$ 3))
          (LETT |m| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL |n| |m| (QREFELT $ 17))
              (SPADCALL (SPADCALL |n| |f|) (SPADCALL (QREFELT $ 15))
                        (QREFELT $ 12)))
             ('T
              (SPADCALL (SPADCALL |n| |f|)
                        (|GENUPS1;genFiniteStream0| |f|
                         (SPADCALL |n| (|spadConstant| $ 9) (QREFELT $ 10)) |m|
                         $)
                        (QREFELT $ 12)))))))) 

(SDEFUN |GENUPS1;taylor;MSRA;4|
        ((|f| (|Mapping| R (|Integer|))) (|x| (|Symbol|)) (|a| (R))
         ($ (|Any|)))
        (SPADCALL
         (SPADCALL (|GENUPS1;genStream| |f| 0 $)
                   (|compiledLookupCheck| '|series|
                                          (LIST '$
                                                (LIST '|Stream|
                                                      (|devaluate| (ELT $ 6))))
                                          (|UnivariateTaylorSeries| (ELT $ 6)
                                                                    |x| |a|)))
         (|compiledLookupCheck| '|coerce|
                                (LIST (LIST '|Any|)
                                      (LIST '|UnivariateTaylorSeries|
                                            (|devaluate| (ELT $ 6)) |x| |a|))
                                (|AnyFunctions1|
                                 (|UnivariateTaylorSeries| (ELT $ 6) |x|
                                                           |a|))))) 

(SDEFUN |GENUPS1;taylor;MSRUsA;5|
        ((|f| (|Mapping| R (|Integer|))) (|x| (|Symbol|)) (|a| (R))
         (|seg| (|UniversalSegment| (|NonNegativeInteger|))) ($ (|Any|)))
        (SPROG
         ((|uts| (|UnivariateTaylorSeries| R |x| |a|))
          (|n0| #1=(|NonNegativeInteger|)) (|n1| #2=(|NonNegativeInteger|))
          (|#G19| #1#) (|#G18| #2#))
         (SEQ
          (COND
           ((SPADCALL |seg| (QREFELT $ 23))
            (SEQ (LETT |n0| (SPADCALL |seg| (QREFELT $ 25)))
                 (LETT |n1| (SPADCALL |seg| (QREFELT $ 26)))
                 (COND
                  ((< |n1| |n0|)
                   (PROGN
                    (LETT |#G18| |n1|)
                    (LETT |#G19| |n0|)
                    (LETT |n0| |#G18|)
                    (LETT |n1| |#G19|))))
                 (LETT |uts|
                       (SPADCALL (|GENUPS1;genFiniteStream| |f| |n0| |n1| $)
                                 (|compiledLookupCheck| '|series|
                                                        (LIST '$
                                                              (LIST '|Stream|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                        (|UnivariateTaylorSeries|
                                                         (ELT $ 6) |x| |a|))))
                 (LETT |uts|
                       (SPADCALL |uts|
                                 (SPADCALL (|spadConstant| $ 7) |n0|
                                           (|compiledLookupCheck| '|monomial|
                                                                  (LIST '$
                                                                        (|devaluate|
                                                                         (ELT $
                                                                              6))
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (|UnivariateTaylorSeries|
                                                                   (ELT $ 6)
                                                                   |x| |a|)))
                                 (|compiledLookupCheck| '* (LIST '$ '$ '$)
                                                        (|UnivariateTaylorSeries|
                                                         (ELT $ 6) |x| |a|))))
                 (EXIT
                  (SPADCALL |uts|
                            (|compiledLookupCheck| '|coerce|
                                                   (LIST (LIST '|Any|)
                                                         (LIST
                                                          '|UnivariateTaylorSeries|
                                                          (|devaluate|
                                                           (ELT $ 6))
                                                          |x| |a|))
                                                   (|AnyFunctions1|
                                                    (|UnivariateTaylorSeries|
                                                     (ELT $ 6) |x| |a|)))))))
           ('T
            (SEQ (LETT |n0| (SPADCALL |seg| (QREFELT $ 25)))
                 (LETT |uts|
                       (SPADCALL (|GENUPS1;genStream| |f| |n0| $)
                                 (|compiledLookupCheck| '|series|
                                                        (LIST '$
                                                              (LIST '|Stream|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                        (|UnivariateTaylorSeries|
                                                         (ELT $ 6) |x| |a|))))
                 (LETT |uts|
                       (SPADCALL |uts|
                                 (SPADCALL (|spadConstant| $ 7) |n0|
                                           (|compiledLookupCheck| '|monomial|
                                                                  (LIST '$
                                                                        (|devaluate|
                                                                         (ELT $
                                                                              6))
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (|UnivariateTaylorSeries|
                                                                   (ELT $ 6)
                                                                   |x| |a|)))
                                 (|compiledLookupCheck| '* (LIST '$ '$ '$)
                                                        (|UnivariateTaylorSeries|
                                                         (ELT $ 6) |x| |a|))))
                 (EXIT
                  (SPADCALL |uts|
                            (|compiledLookupCheck| '|coerce|
                                                   (LIST (LIST '|Any|)
                                                         (LIST
                                                          '|UnivariateTaylorSeries|
                                                          (|devaluate|
                                                           (ELT $ 6))
                                                          |x| |a|))
                                                   (|AnyFunctions1|
                                                    (|UnivariateTaylorSeries|
                                                     (ELT $ 6) |x|
                                                     |a|))))))))))) 

(SDEFUN |GENUPS1;laurent;MSRUsA;6|
        ((|f| (|Mapping| R (|Integer|))) (|x| (|Symbol|)) (|a| (R))
         (|seg| (|UniversalSegment| (|Integer|))) ($ (|Any|)))
        (SPROG
         ((|uts| (|UnivariateTaylorSeries| R |x| |a|)) (|n0| #1=(|Integer|))
          (|n1| #2=(|Integer|)) (|#G26| #1#) (|#G25| #2#))
         (SEQ
          (COND
           ((SPADCALL |seg| (QREFELT $ 29))
            (SEQ (LETT |n0| (SPADCALL |seg| (QREFELT $ 30)))
                 (LETT |n1| (SPADCALL |seg| (QREFELT $ 31)))
                 (COND
                  ((< |n1| |n0|)
                   (PROGN
                    (LETT |#G25| |n1|)
                    (LETT |#G26| |n0|)
                    (LETT |n0| |#G25|)
                    (LETT |n1| |#G26|))))
                 (LETT |uts|
                       (SPADCALL (|GENUPS1;genFiniteStream| |f| |n0| |n1| $)
                                 (|compiledLookupCheck| '|series|
                                                        (LIST '$
                                                              (LIST '|Stream|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                        (|UnivariateTaylorSeries|
                                                         (ELT $ 6) |x| |a|))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL |n0| |uts|
                             (|compiledLookupCheck| '|laurent|
                                                    (LIST '$ (LIST '|Integer|)
                                                          (LIST
                                                           '|UnivariateTaylorSeries|
                                                           (|devaluate|
                                                            (ELT $ 6))
                                                           |x| |a|))
                                                    (|UnivariateLaurentSeries|
                                                     (ELT $ 6) |x| |a|)))
                   (|compiledLookupCheck| '|coerce|
                                          (LIST (LIST '|Any|)
                                                (LIST
                                                 '|UnivariateLaurentSeries|
                                                 (|devaluate| (ELT $ 6)) |x|
                                                 |a|))
                                          (|AnyFunctions1|
                                           (|UnivariateLaurentSeries| (ELT $ 6)
                                                                      |x|
                                                                      |a|)))))))
           ('T
            (SEQ (LETT |n0| (SPADCALL |seg| (QREFELT $ 30)))
                 (LETT |uts|
                       (SPADCALL (|GENUPS1;genStream| |f| |n0| $)
                                 (|compiledLookupCheck| '|series|
                                                        (LIST '$
                                                              (LIST '|Stream|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                        (|UnivariateTaylorSeries|
                                                         (ELT $ 6) |x| |a|))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL |n0| |uts|
                             (|compiledLookupCheck| '|laurent|
                                                    (LIST '$ (LIST '|Integer|)
                                                          (LIST
                                                           '|UnivariateTaylorSeries|
                                                           (|devaluate|
                                                            (ELT $ 6))
                                                           |x| |a|))
                                                    (|UnivariateLaurentSeries|
                                                     (ELT $ 6) |x| |a|)))
                   (|compiledLookupCheck| '|coerce|
                                          (LIST (LIST '|Any|)
                                                (LIST
                                                 '|UnivariateLaurentSeries|
                                                 (|devaluate| (ELT $ 6)) |x|
                                                 |a|))
                                          (|AnyFunctions1|
                                           (|UnivariateLaurentSeries| (ELT $ 6)
                                                                      |x|
                                                                      |a|))))))))))) 

(SDEFUN |GENUPS1;modifyFcn|
        ((|f| (|Mapping| R (|Fraction| (|Integer|)))) (|n0| (|Integer|))
         (|nn| (|Integer|)) (|q| (|Integer|)) (|m| (|Integer|)) ($ (R)))
        (COND
         ((ZEROP (REM (- |m| |n0|) |nn|))
          (SPADCALL (SPADCALL |m| |q| (QREFELT $ 34)) |f|))
         ('T (|spadConstant| $ 35)))) 

(SDEFUN |GENUPS1;puiseux;MSRUsFA;8|
        ((|f| (|Mapping| R (|Fraction| (|Integer|)))) (|x| (|Symbol|))
         (|a| (R)) (|seg| (|UniversalSegment| (|Fraction| (|Integer|))))
         (|r| (|Fraction| (|Integer|))) ($ (|Any|)))
        (SPROG
         ((|uls| (|UnivariateLaurentSeries| R |x| |a|)) (|ulsUnion| (|Any|))
          (|nn| #1=(|Integer|)) (|n0| #1#) (|q| (|Integer|))
          (|q2| #2=(|Integer|)) (|p2| #3=(|Integer|)) (|q0| #2#) (|p0| #3#)
          (|r0| #4=(|Fraction| (|Integer|))) (|n1| #1#) (|q1| #2#) (|p1| #3#)
          (|r1| #5=(|Fraction| (|Integer|))) (|#G39| #4#) (|#G38| #5#))
         (SEQ
          (COND
           ((NULL (SPADCALL |r| (QREFELT $ 36)))
            (|error| "puiseux: last argument must be positive"))
           ('T
            (COND
             ((SPADCALL |seg| (QREFELT $ 38))
              (SEQ (LETT |r0| (SPADCALL |seg| (QREFELT $ 39)))
                   (LETT |r1| (SPADCALL |seg| (QREFELT $ 40)))
                   (COND
                    ((SPADCALL |r1| |r0| (QREFELT $ 41))
                     (PROGN
                      (LETT |#G38| |r1|)
                      (LETT |#G39| |r0|)
                      (LETT |r0| |#G38|)
                      (LETT |r1| |#G39|))))
                   (LETT |p0| (SPADCALL |r0| (QREFELT $ 42)))
                   (LETT |q0| (SPADCALL |r0| (QREFELT $ 43)))
                   (LETT |p1| (SPADCALL |r1| (QREFELT $ 42)))
                   (LETT |q1| (SPADCALL |r1| (QREFELT $ 43)))
                   (LETT |p2| (SPADCALL |r| (QREFELT $ 42)))
                   (LETT |q2| (SPADCALL |r| (QREFELT $ 43)))
                   (LETT |q|
                         (SPADCALL (SPADCALL |q0| |q1| (QREFELT $ 44)) |q2|
                                   (QREFELT $ 44)))
                   (LETT |n0| (* |p0| (QUOTIENT2 |q| |q0|)))
                   (LETT |n1| (* |p1| (QUOTIENT2 |q| |q1|)))
                   (LETT |nn| (* |p2| (QUOTIENT2 |q| |q2|)))
                   (LETT |ulsUnion|
                         (SPADCALL
                          (CONS #'|GENUPS1;puiseux;MSRUsFA;8!0|
                                (VECTOR $ |q| |nn| |n0| |f|))
                          |x| |a| (SPADCALL |n0| |n1| (QREFELT $ 45))
                          (QREFELT $ 32)))
                   (LETT |uls|
                         (SPADCALL |ulsUnion|
                                   (|compiledLookupCheck| '|retract|
                                                          (LIST
                                                           (LIST
                                                            '|UnivariateLaurentSeries|
                                                            (|devaluate|
                                                             (ELT $ 6))
                                                            |x| |a|)
                                                           (LIST '|Any|))
                                                          (|AnyFunctions1|
                                                           (|UnivariateLaurentSeries|
                                                            (ELT $ 6) |x|
                                                            |a|)))))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL 1 |q| (QREFELT $ 34)) |uls|
                               (|compiledLookupCheck| '|puiseux|
                                                      (LIST '$
                                                            (LIST '|Fraction|
                                                                  (LIST
                                                                   '|Integer|))
                                                            (LIST
                                                             '|UnivariateLaurentSeries|
                                                             (|devaluate|
                                                              (ELT $ 6))
                                                             |x| |a|))
                                                      (|UnivariatePuiseuxSeries|
                                                       (ELT $ 6) |x| |a|)))
                     (|compiledLookupCheck| '|coerce|
                                            (LIST (LIST '|Any|)
                                                  (LIST
                                                   '|UnivariatePuiseuxSeries|
                                                   (|devaluate| (ELT $ 6)) |x|
                                                   |a|))
                                            (|AnyFunctions1|
                                             (|UnivariatePuiseuxSeries|
                                              (ELT $ 6) |x| |a|)))))))
             ('T
              (SEQ
               (LETT |p0|
                     (SPADCALL (LETT |r0| (SPADCALL |seg| (QREFELT $ 39)))
                               (QREFELT $ 42)))
               (LETT |q0| (SPADCALL |r0| (QREFELT $ 43)))
               (LETT |p2| (SPADCALL |r| (QREFELT $ 42)))
               (LETT |q2| (SPADCALL |r| (QREFELT $ 43)))
               (LETT |q| (SPADCALL |q0| |q2| (QREFELT $ 44)))
               (LETT |n0| (* |p0| (QUOTIENT2 |q| |q0|)))
               (LETT |nn| (* |p2| (QUOTIENT2 |q| |q2|)))
               (LETT |ulsUnion|
                     (SPADCALL
                      (CONS #'|GENUPS1;puiseux;MSRUsFA;8!1|
                            (VECTOR $ |q| |nn| |n0| |f|))
                      |x| |a| (SPADCALL |n0| (QREFELT $ 47)) (QREFELT $ 32)))
               (LETT |uls|
                     (SPADCALL |ulsUnion|
                               (|compiledLookupCheck| '|retract|
                                                      (LIST
                                                       (LIST
                                                        '|UnivariateLaurentSeries|
                                                        (|devaluate| (ELT $ 6))
                                                        |x| |a|)
                                                       (LIST '|Any|))
                                                      (|AnyFunctions1|
                                                       (|UnivariateLaurentSeries|
                                                        (ELT $ 6) |x| |a|)))))
               (EXIT
                (SPADCALL
                 (SPADCALL (SPADCALL 1 |q| (QREFELT $ 34)) |uls|
                           (|compiledLookupCheck| '|puiseux|
                                                  (LIST '$
                                                        (LIST '|Fraction|
                                                              (LIST
                                                               '|Integer|))
                                                        (LIST
                                                         '|UnivariateLaurentSeries|
                                                         (|devaluate|
                                                          (ELT $ 6))
                                                         |x| |a|))
                                                  (|UnivariatePuiseuxSeries|
                                                   (ELT $ 6) |x| |a|)))
                 (|compiledLookupCheck| '|coerce|
                                        (LIST (LIST '|Any|)
                                              (LIST '|UnivariatePuiseuxSeries|
                                                    (|devaluate| (ELT $ 6)) |x|
                                                    |a|))
                                        (|AnyFunctions1|
                                         (|UnivariatePuiseuxSeries| (ELT $ 6)
                                                                    |x|
                                                                    |a|))))))))))))) 

(SDEFUN |GENUPS1;puiseux;MSRUsFA;8!1| ((|i| NIL) ($$ NIL))
        (PROG (|f| |n0| |nn| |q| $)
          (LETT |f| (QREFELT $$ 4))
          (LETT |n0| (QREFELT $$ 3))
          (LETT |nn| (QREFELT $$ 2))
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GENUPS1;modifyFcn| |f| |n0| |nn| |q| |i| $))))) 

(SDEFUN |GENUPS1;puiseux;MSRUsFA;8!0| ((|i| NIL) ($$ NIL))
        (PROG (|f| |n0| |nn| |q| $)
          (LETT |f| (QREFELT $$ 4))
          (LETT |n0| (QREFELT $$ 3))
          (LETT |nn| (QREFELT $$ 2))
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GENUPS1;modifyFcn| |f| |n0| |nn| |q| |i| $))))) 

(DECLAIM (NOTINLINE |GenerateUnivariatePowerSeries1;|)) 

(DEFUN |GenerateUnivariatePowerSeries1| (#1=#:G749)
  (SPROG NIL
         (PROG (#2=#:G750)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GenerateUnivariatePowerSeries1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|GenerateUnivariatePowerSeries1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GenerateUnivariatePowerSeries1|)))))))))) 

(DEFUN |GenerateUnivariatePowerSeries1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GenerateUnivariatePowerSeries1| DV$1))
          (LETT $ (GETREFV 50))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GenerateUnivariatePowerSeries1|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GenerateUnivariatePowerSeries1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (|Integer|)
              (4 . |One|) (8 . +) (|Stream| 6) (14 . |concat|) (|Mapping| $)
              (20 . |delay|) (25 . |empty|) (|Boolean|) (29 . =) (|Any|)
              (|Mapping| 6 8) (|Symbol|) |GENUPS1;taylor;MSRA;4|
              (|UniversalSegment| 24) (35 . |hasHi|) (|NonNegativeInteger|)
              (40 . |low|) (45 . |high|) |GENUPS1;taylor;MSRUsA;5|
              (|UniversalSegment| 8) (50 . |hasHi|) (55 . |low|) (60 . |high|)
              |GENUPS1;laurent;MSRUsA;6| (|Fraction| 8) (65 . /) (71 . |Zero|)
              (75 . |positive?|) (|UniversalSegment| 33) (80 . |hasHi|)
              (85 . |low|) (90 . |high|) (95 . <) (101 . |numer|)
              (106 . |denom|) (111 . |lcm|) (117 . |segment|) (123 . |One|)
              (127 . |segment|) (|Mapping| 6 33) |GENUPS1;puiseux;MSRUsFA;8|)
           '#(|taylor| 132 |puiseux| 147 |laurent| 156) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|taylor|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Symbol|) |#1|))
                                T)
                              '((|taylor|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Symbol|) |#1|
                                  (|UniversalSegment| (|NonNegativeInteger|))))
                                T)
                              '((|laurent|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Symbol|) |#1|
                                  (|UniversalSegment| (|Integer|))))
                                T)
                              '((|puiseux|
                                 ((|Any|)
                                  (|Mapping| |#1| (|Fraction| (|Integer|)))
                                  (|Symbol|) |#1|
                                  (|UniversalSegment| (|Fraction| (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 49
                                            '(0 6 0 7 0 8 0 9 2 8 0 0 0 10 2 11
                                              0 6 0 12 1 11 0 13 14 0 11 0 15 2
                                              8 16 0 0 17 1 22 16 0 23 1 22 24
                                              0 25 1 22 24 0 26 1 28 16 0 29 1
                                              28 8 0 30 1 28 8 0 31 2 33 0 8 8
                                              34 0 6 0 35 1 33 16 0 36 1 37 16
                                              0 38 1 37 33 0 39 1 37 33 0 40 2
                                              33 16 0 0 41 1 33 8 0 42 1 33 8 0
                                              43 2 8 0 0 0 44 2 28 0 8 8 45 0
                                              33 0 46 1 28 0 8 47 4 0 18 19 20
                                              6 22 27 3 0 18 19 20 6 21 5 0 18
                                              48 20 6 37 33 49 4 0 18 19 20 6
                                              28 32)))))
           '|lookupComplete|)) 
