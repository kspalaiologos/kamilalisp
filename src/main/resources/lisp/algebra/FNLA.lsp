
(SDEFUN |FNLA;dimension;Nni;1| (($ (|NonNegativeInteger|)))
        (QVSIZE (QREFELT $ 14))) 

(SDEFUN |FNLA;have| ((|i| (|Integer|)) (|j| (|Integer|)) ($ ($)))
        (SPROG
         ((|hi| (|Integer|)) (|lo| (|Integer|)) (|mid| (|Integer|))
          (|wt| (|Integer|)))
         (SEQ
          (LETT |wt|
                (+
                 (SPADCALL (SPADCALL (QREFELT $ 14) |i| (QREFELT $ 18)) 2
                           (QREFELT $ 19))
                 (SPADCALL (SPADCALL (QREFELT $ 14) |j| (QREFELT $ 18)) 2
                           (QREFELT $ 19))))
          (EXIT
           (COND ((> |wt| (QREFELT $ 7)) (|spadConstant| $ 20))
                 ('T
                  (SEQ (LETT |lo| 1) (LETT |hi| (SPADCALL (QREFELT $ 15)))
                       (SEQ G190 (COND ((NULL (> (- |hi| |lo|) 1)) (GO G191)))
                            (SEQ (LETT |mid| (QUOTIENT2 (+ |hi| |lo|) 2))
                                 (EXIT
                                  (COND
                                   ((<
                                     (SPADCALL
                                      (SPADCALL (QREFELT $ 14) |mid|
                                                (QREFELT $ 18))
                                      2 (QREFELT $ 19))
                                     |wt|)
                                    (LETT |lo| |mid|))
                                   ('T (LETT |hi| |mid|)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (SEQ G190
                            (COND
                             ((NULL
                               (<
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 14) |hi| (QREFELT $ 18))
                                 1 (QREFELT $ 19))
                                |i|))
                              (GO G191)))
                            (SEQ (EXIT (LETT |hi| (+ |hi| 1)))) NIL (GO G190)
                            G191 (EXIT NIL))
                       (SEQ G190
                            (COND
                             ((NULL
                               (<
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 14) |hi| (QREFELT $ 18))
                                 3 (QREFELT $ 19))
                                |j|))
                              (GO G191)))
                            (SEQ (EXIT (LETT |hi| (+ |hi| 1)))) NIL (GO G190)
                            G191 (EXIT NIL))
                       (EXIT
                        (SPADCALL (|spadConstant| $ 23)
                                  (SPADCALL |hi| (QREFELT $ 22))
                                  (QREFELT $ 24)))))))))) 

(SDEFUN |FNLA;generator;Nni$;3| ((|i| (|NonNegativeInteger|)) ($ ($)))
        (COND ((> |i| (SPADCALL (QREFELT $ 15))) (|spadConstant| $ 25))
              ('T
               (SPADCALL (|spadConstant| $ 23) (SPADCALL |i| (QREFELT $ 22))
                         (QREFELT $ 24))))) 

(SDEFUN |FNLA;putIn| ((|i| (|Integer|)) ($ ($)))
        (SPADCALL (|spadConstant| $ 23) (SPADCALL |i| (QREFELT $ 22))
                  (QREFELT $ 24))) 

(SDEFUN |FNLA;brkt| ((|k| (|Integer|)) (|f| ($)) ($ ($)))
        (SPROG ((|dg| (|Integer|)))
               (SEQ
                (COND
                 ((SPADCALL |f| (|spadConstant| $ 20) (QREFELT $ 28))
                  (|spadConstant| $ 20))
                 (#1='T
                  (SEQ
                   (LETT |dg|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 29))
                                   (QREFELT $ 30)))
                   (EXIT
                    (COND
                     ((SPADCALL (SPADCALL |f| (QREFELT $ 31))
                                (|spadConstant| $ 20) (QREFELT $ 28))
                      (COND ((EQL |k| |dg|) (|spadConstant| $ 20))
                            ((> |k| |dg|)
                             (SPADCALL
                              (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                                        (|FNLA;brkt| |dg| (|FNLA;putIn| |k| $)
                                         $)
                                        (QREFELT $ 33))
                              (QREFELT $ 34)))
                            (#1#
                             (COND
                              ((SPADCALL (QREFELT $ 6) |k| |dg|
                                         (SPADCALL
                                          (SPADCALL (QREFELT $ 14) |dg|
                                                    (QREFELT $ 18))
                                          1 (QREFELT $ 19))
                                         (QREFELT $ 35))
                               (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                                         (|FNLA;have| |k| |dg| $)
                                         (QREFELT $ 33)))
                              (#1#
                               (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                                         (SPADCALL
                                          (|FNLA;brkt|
                                           (SPADCALL
                                            (SPADCALL (QREFELT $ 14) |dg|
                                                      (QREFELT $ 18))
                                            1 (QREFELT $ 19))
                                           (|FNLA;brkt| |k|
                                            (|FNLA;putIn|
                                             (SPADCALL
                                              (SPADCALL (QREFELT $ 14) |dg|
                                                        (QREFELT $ 18))
                                              3 (QREFELT $ 19))
                                             $)
                                            $)
                                           $)
                                          (|FNLA;brkt|
                                           (SPADCALL
                                            (SPADCALL (QREFELT $ 14) |dg|
                                                      (QREFELT $ 18))
                                            3 (QREFELT $ 19))
                                           (|FNLA;brkt| |k|
                                            (|FNLA;putIn|
                                             (SPADCALL
                                              (SPADCALL (QREFELT $ 14) |dg|
                                                        (QREFELT $ 18))
                                              1 (QREFELT $ 19))
                                             $)
                                            $)
                                           $)
                                          (QREFELT $ 36))
                                         (QREFELT $ 33)))))))
                     (#1#
                      (SPADCALL
                       (|FNLA;brkt| |k|
                        (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                                  (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 24))
                        $)
                       (|FNLA;brkt| |k| (SPADCALL |f| (QREFELT $ 31)) $)
                       (QREFELT $ 37))))))))))) 

(SDEFUN |FNLA;*;3$;6| ((|f| ($)) (|g| ($)) ($ ($)))
        (COND
         ((SPADCALL (SPADCALL |f| (QREFELT $ 31)) (|spadConstant| $ 20)
                    (QREFELT $ 28))
          (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                    (|FNLA;brkt|
                     (SPADCALL (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 30))
                     |g| $)
                    (QREFELT $ 33)))
         ('T
          (SPADCALL
           (SPADCALL
            (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                      (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 24))
            |g| (QREFELT $ 38))
           (SPADCALL (SPADCALL |f| (QREFELT $ 31)) |g| (QREFELT $ 38))
           (QREFELT $ 37))))) 

(SDEFUN |FNLA;Fac| ((|m| (|Integer|)) ($ (|Commutator|)))
        (COND
         ((EQL
           (SPADCALL (SPADCALL (QREFELT $ 14) |m| (QREFELT $ 18)) 1
                     (QREFELT $ 19))
           0)
          (SPADCALL |m| (QREFELT $ 40)))
         ('T
          (SPADCALL
           (|FNLA;Fac|
            (SPADCALL (SPADCALL (QREFELT $ 14) |m| (QREFELT $ 18)) 1
                      (QREFELT $ 19))
            $)
           (|FNLA;Fac|
            (SPADCALL (SPADCALL (QREFELT $ 14) |m| (QREFELT $ 18)) 3
                      (QREFELT $ 19))
            $)
           (QREFELT $ 41))))) 

(SDEFUN |FNLA;shallowE| ((|r| (R)) (|s| (|OrdSetInts|)) ($ (|OutputForm|)))
        (SPROG ((|k| (|Integer|)))
               (SEQ (LETT |k| (SPADCALL |s| (QREFELT $ 30)))
                    (EXIT
                     (COND
                      ((SPADCALL |r| (|spadConstant| $ 23) (QREFELT $ 42))
                       (COND
                        ((<= |k| (QREFELT $ 6)) (SPADCALL |s| (QREFELT $ 44)))
                        (#1='T
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (QREFELT $ 14) |k| (QREFELT $ 18)) 1
                             (QREFELT $ 19))
                            (QREFELT $ 40))
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (QREFELT $ 14) |k| (QREFELT $ 18)) 3
                             (QREFELT $ 19))
                            (QREFELT $ 40))
                           (QREFELT $ 41))
                          (QREFELT $ 45)))))
                      ((<= |k| (QREFELT $ 6))
                       (SPADCALL (SPADCALL |r| (QREFELT $ 46))
                                 (SPADCALL |s| (QREFELT $ 44)) (QREFELT $ 47)))
                      (#1#
                       (SPADCALL (SPADCALL |r| (QREFELT $ 46))
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (QREFELT $ 14) |k|
                                               (QREFELT $ 18))
                                     1 (QREFELT $ 19))
                                    (QREFELT $ 40))
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (QREFELT $ 14) |k|
                                               (QREFELT $ 18))
                                     3 (QREFELT $ 19))
                                    (QREFELT $ 40))
                                   (QREFELT $ 41))
                                  (QREFELT $ 45))
                                 (QREFELT $ 47)))))))) 

(SDEFUN |FNLA;shallowExpand;$Of;9| ((|f| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |f| (|spadConstant| $ 20) (QREFELT $ 28))
          (SPADCALL 0 (QREFELT $ 48)))
         ((SPADCALL (SPADCALL |f| (QREFELT $ 31)) (|spadConstant| $ 20)
                    (QREFELT $ 28))
          (|FNLA;shallowE| (SPADCALL |f| (QREFELT $ 32))
           (SPADCALL |f| (QREFELT $ 29)) $))
         ('T
          (SPADCALL
           (|FNLA;shallowE| (SPADCALL |f| (QREFELT $ 32))
            (SPADCALL |f| (QREFELT $ 29)) $)
           (SPADCALL (SPADCALL |f| (QREFELT $ 31)) (QREFELT $ 49))
           (QREFELT $ 50))))) 

(SDEFUN |FNLA;deepExpand;$Of;10| ((|f| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |f| (|spadConstant| $ 20) (QREFELT $ 28))
          (SPADCALL 0 (QREFELT $ 48)))
         ((SPADCALL (SPADCALL |f| (QREFELT $ 31)) (|spadConstant| $ 20)
                    (QREFELT $ 28))
          (COND
           ((SPADCALL (SPADCALL |f| (QREFELT $ 32)) (|spadConstant| $ 23)
                      (QREFELT $ 42))
            (SPADCALL
             (|FNLA;Fac|
              (SPADCALL (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 30)) $)
             (QREFELT $ 45)))
           (#1='T
            (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 46))
                      (SPADCALL
                       (|FNLA;Fac|
                        (SPADCALL (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 30))
                        $)
                       (QREFELT $ 45))
                      (QREFELT $ 47)))))
         ((SPADCALL (SPADCALL |f| (QREFELT $ 32)) (|spadConstant| $ 23)
                    (QREFELT $ 42))
          (SPADCALL
           (SPADCALL
            (|FNLA;Fac| (SPADCALL (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 30))
             $)
            (QREFELT $ 45))
           (SPADCALL (SPADCALL |f| (QREFELT $ 31)) (QREFELT $ 51))
           (QREFELT $ 50)))
         (#1#
          (SPADCALL
           (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 46))
                     (SPADCALL
                      (|FNLA;Fac|
                       (SPADCALL (SPADCALL |f| (QREFELT $ 29)) (QREFELT $ 30))
                       $)
                      (QREFELT $ 45))
                     (QREFELT $ 47))
           (SPADCALL (SPADCALL |f| (QREFELT $ 31)) (QREFELT $ 51))
           (QREFELT $ 50))))) 

(DECLAIM (NOTINLINE |FreeNilpotentLie;|)) 

(DEFUN |FreeNilpotentLie| (&REST #1=#:G748)
  (SPROG NIL
         (PROG (#2=#:G749)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL T))
                     (HGET |$ConstructorCache| '|FreeNilpotentLie|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FreeNilpotentLie;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FreeNilpotentLie|)))))))))) 

(DEFUN |FreeNilpotentLie;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 |#2|)
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FreeNilpotentLie| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FreeNilpotentLie|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (|FreeModule| |#3| (|OrdSetInts|)))
          (QSETREFV $ 14 (SPADCALL |#1| |#2| (QREFELT $ 13)))
          $))) 

(MAKEPROP '|FreeNilpotentLie| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FreeModule| 8 21) (|local| |#1|)
              (|local| |#2|) (|local| |#3|) '|Rep| (|Vector| 16)
              (|NonNegativeInteger|) (|HallBasis|) (0 . |basis|) '|coms|
              |FNLA;dimension;Nni;1| (|List| 17) (|Integer|) (6 . |elt|)
              (12 . |elt|) (18 . |Zero|) (|OrdSetInts|) (22 . |coerce|)
              (27 . |One|) (31 . |monomial|) (37 . |Zero|)
              |FNLA;generator;Nni$;3| (|Boolean|) (41 . =)
              (47 . |leadingSupport|) (52 . |value|) (57 . |reductum|)
              (62 . |leadingCoefficient|) (67 . *) (73 . -)
              (78 . |inHallBasis?|) (86 . -) (92 . +) |FNLA;*;3$;6|
              (|Commutator|) (98 . |mkcomm|) (103 . |mkcomm|) (109 . =)
              (|OutputForm|) (115 . |coerce|) (120 . |coerce|) (125 . |coerce|)
              (130 . *) (136 . |coerce|) |FNLA;shallowExpand;$Of;9| (141 . +)
              |FNLA;deepExpand;$Of;10| (|PositiveInteger|)
              (|Union| $ '"failed") (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 147 |zero?| 153 |subtractIfCan| 158 |shallowExpand| 164
              |sample| 169 |rightPower| 173 |plenaryPower| 179 |opposite?| 185
              |leftPower| 191 |latex| 197 |hashUpdate!| 202 |hash| 208
              |generator| 213 |dimension| 218 |deepExpand| 222 |commutator| 227
              |coerce| 233 |associator| 238 |antiCommutator| 245 ^ 251 |Zero|
              257 = 261 - 267 + 278 * 284)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|NonAssociativeAlgebra&| |Module&| NIL
                     |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL
                     |NonAssociativeSemiRng&| |AbelianMonoid&|
                     |AbelianSemiGroup&| |Magma&| |SetCategory&| |BasicType&|
                     NIL)
                  (CONS
                   '#((|NonAssociativeAlgebra| 8) (|Module| 8) (|BiModule| 8 8)
                      (|NonAssociativeRng|) (|RightModule| 8) (|LeftModule| 8)
                      (|AbelianGroup|) (|CancellationAbelianMonoid|)
                      (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                      (|AbelianSemiGroup|) (|Magma|) (|SetCategory|)
                      (|BasicType|) (|CoercibleTo| 43))
                   (|makeByteWordVec2| 56
                                       '(2 12 10 11 11 13 2 10 16 0 17 18 2 16
                                         17 0 17 19 0 0 0 20 1 21 0 17 22 0 8 0
                                         23 2 5 0 8 21 24 0 9 0 25 2 0 27 0 0
                                         28 1 9 21 0 29 1 21 17 0 30 1 9 0 0 31
                                         1 9 8 0 32 2 0 0 8 0 33 1 0 0 0 34 4
                                         12 27 17 17 17 17 35 2 0 0 0 0 36 2 0
                                         0 0 0 37 1 39 0 17 40 2 39 0 0 0 41 2
                                         8 27 0 0 42 1 21 43 0 44 1 39 43 0 45
                                         1 8 43 0 46 2 43 0 0 0 47 1 11 43 0 48
                                         2 43 0 0 0 50 2 0 27 0 0 1 1 0 27 0 1
                                         2 0 53 0 0 1 1 0 43 0 49 0 0 0 1 2 0 0
                                         0 52 1 2 0 0 0 52 1 2 0 27 0 0 1 2 0 0
                                         0 52 1 1 0 55 0 1 2 0 54 54 0 1 1 0 56
                                         0 1 1 0 0 11 26 0 0 11 15 1 0 43 0 51
                                         2 0 0 0 0 1 1 0 43 0 1 3 0 0 0 0 0 1 2
                                         0 0 0 0 1 2 0 0 0 52 1 0 0 0 20 2 0 27
                                         0 0 28 2 0 0 0 0 36 1 0 0 0 34 2 0 0 0
                                         0 37 2 0 0 0 8 1 2 0 0 8 0 33 2 0 0 11
                                         0 1 2 0 0 17 0 1 2 0 0 0 0 38 2 0 0 52
                                         0 1)))))
           '|lookupComplete|)) 
