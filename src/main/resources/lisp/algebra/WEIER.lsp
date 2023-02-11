
(SDEFUN |WEIER;transback|
        ((|smps| (|Stream| (|TaylorSeries| R)))
         ($ (|List| (|TaylorSeries| R))))
        (COND
         ((OR (SPADCALL |smps| (QREFELT $ 9))
              (SPADCALL (SPADCALL |smps| (QREFELT $ 12)) (QREFELT $ 13)))
          NIL)
         ('T
          (CONS (SPADCALL (CONS #'|WEIER;transback!0| $) |smps| (QREFELT $ 19))
                (|WEIER;transback|
                 (SPADCALL (CONS #'|WEIER;transback!1| $) |smps|
                           (QREFELT $ 28))
                 $))))) 

(SDEFUN |WEIER;transback!1| ((|ss| NIL) ($ NIL))
        (SPADCALL |ss| (|spadConstant| $ 24) (QREFELT $ 25))) 

(SDEFUN |WEIER;transback!0| ((|ss| NIL) ($ NIL))
        (COND ((SPADCALL |ss| (QREFELT $ 13)) (|spadConstant| $ 15))
              ('T (SPADCALL |ss| (QREFELT $ 16))))) 

(SDEFUN |WEIER;streamlikeUniv|
        ((|p| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         (|n| (|NonNegativeInteger|)) ($ (|Stream| (|Polynomial| R))))
        (SPROG ((#1=#:G717 NIL))
               (COND
                ((EQL |n| 0)
                 (SPADCALL (SPADCALL |p| 0 (QREFELT $ 32))
                           (SPADCALL (QREFELT $ 33)) (QREFELT $ 34)))
                ('T
                 (SPADCALL (SPADCALL |p| |n| (QREFELT $ 32))
                           (|WEIER;streamlikeUniv| |p|
                            (PROG1 (LETT #1# (- |n| 1))
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#))
                            $)
                           (QREFELT $ 34)))))) 

(SDEFUN |WEIER;transpose|
        ((|s| (|Stream| (|Stream| (|Polynomial| R))))
         ($ (|Stream| (|Stream| (|Polynomial| R)))))
        (SPROG NIL
               (SPADCALL (CONS #'|WEIER;transpose!0| (VECTOR $ |s|))
                         (QREFELT $ 41)))) 

(SDEFUN |WEIER;transpose!0| (($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |s| (QREFELT $ 35)) (SPADCALL (QREFELT $ 36)))
                  ('T
                   (SPADCALL (SPADCALL (ELT $ 16) |s| (QREFELT $ 19))
                             (|WEIER;transpose|
                              (SPADCALL (ELT $ 37)
                                        (SPADCALL |s| (QREFELT $ 38))
                                        (QREFELT $ 28))
                              $)
                             (QREFELT $ 39)))))))) 

(SDEFUN |WEIER;sts2stst|
        ((|var| (|Symbol|)) (|sts| (|Stream| (|Polynomial| R)))
         ($ (|Stream| (|Stream| (|Polynomial| R)))))
        (SPROG ((|si0| (|Stream| (|NonNegativeInteger|))))
               (SEQ (LETT |si0| (SPADCALL 0 (QREFELT $ 45)))
                    (EXIT
                     (SPADCALL (CONS #'|WEIER;sts2stst!0| $)
                               (SPADCALL
                                (CONS #'|WEIER;sts2stst!1| (VECTOR $ |var|))
                                |sts| (QREFELT $ 52))
                               |si0| (QREFELT $ 56)))))) 

(SDEFUN |WEIER;sts2stst!1| ((|p| NIL) ($$ NIL))
        (PROG (|var| $)
          (LETT |var| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |p| |var| (QREFELT $ 48)))))) 

(SDEFUN |WEIER;sts2stst!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (|WEIER;streamlikeUniv| |x| |y| $)) 

(SDEFUN |WEIER;tp|
        ((|v| (|Symbol|)) (|sts| (|Stream| (|Polynomial| R)))
         ($ (|Stream| (|Stream| (|Polynomial| R)))))
        (|WEIER;transpose| (|WEIER;sts2stst| |v| |sts| $) $)) 

(SDEFUN |WEIER;maptake|
        ((|n| (|NonNegativeInteger|))
         (|p| (|Stream| (|Stream| (|Polynomial| R))))
         ($ (|Stream| (|TaylorSeries| R))))
        (SPROG NIL
               (SPADCALL (CONS #'|WEIER;maptake!0| (VECTOR $ |n|)) |p|
                         (QREFELT $ 28)))) 

(SDEFUN |WEIER;maptake!0| ((|ss| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |ss| |n| (QREFELT $ 57)))))) 

(SDEFUN |WEIER;mapdrop|
        ((|n| (|NonNegativeInteger|))
         (|p| (|Stream| (|Stream| (|Polynomial| R))))
         ($ (|Stream| (|TaylorSeries| R))))
        (SPROG NIL
               (SPADCALL (CONS #'|WEIER;mapdrop!0| (VECTOR $ |n|)) |p|
                         (QREFELT $ 28)))) 

(SDEFUN |WEIER;mapdrop!0| ((|ss| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |ss| |n| (QREFELT $ 25)))))) 

(SDEFUN |WEIER;weier|
        ((|v| (|Symbol|)) (|sts| (|Stream| (|Polynomial| R)))
         ($ (|Stream| (|TaylorSeries| R))))
        (SPROG
         ((|q| (|Stream| (|TaylorSeries| R))) (|f| (|Stream| (|Polynomial| R)))
          (|e| (|Union| (|Stream| (|Polynomial| R)) "failed"))
          (|b| (|Stream| (|Polynomial| R))) (#1=#:G760 NIL)
          (|a| (|NonNegativeInteger|)) (|c| (|Union| R "failed"))
          (|b0| (|Polynomial| R)) (|a0| NIL)
          (|p| (|Stream| (|TaylorSeries| R))))
         (SEQ (LETT |p| (|WEIER;tp| |v| |sts| $))
              (LETT |b| (SPADCALL |p| (QREFELT $ 58)))
              (SEQ
               (EXIT
                (SEQ (LETT |a0| 0) G190 NIL
                     (SEQ
                      (EXIT
                       (COND
                        ((OR (EQL |a0| 1000) (SPADCALL |b| (QREFELT $ 13)))
                         (|error|
                          "can not find power of variable with constant coefficient"))
                        ('T
                         (SEQ (LETT |b0| (SPADCALL |b| (QREFELT $ 16)))
                              (EXIT
                               (COND
                                ((SPADCALL |b0| (|spadConstant| $ 15)
                                           (QREFELT $ 59))
                                 (SEQ (LETT |b| (SPADCALL |b| (QREFELT $ 37)))
                                      (EXIT "iterate")))
                                ('T
                                 (SEQ (LETT |c| (SPADCALL |b0| (QREFELT $ 61)))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |c| 0)
                                         (SEQ (LETT |a| |a0|)
                                              (EXIT
                                               (PROGN
                                                (LETT #1# |$NoValue|)
                                                (GO #2=#:G753)))))
                                        ('T
                                         (LETT |b|
                                               (SPADCALL |b|
                                                         (QREFELT $
                                                                  37)))))))))))))))
                     (LETT |a0| (|inc_SI| |a0|)) (GO G190) G191 (EXIT NIL)))
               #2# (EXIT #1#))
              (LETT |e| (SPADCALL |b| (QREFELT $ 63)))
              (LETT |f|
                    (COND ((QEQCAR |e| 1) (|error| "no reciprocal"))
                          ('T (QCDR |e|))))
              (LETT |q|
                    (SPADCALL
                     (|WEIER;qqq| |a| |f| (SPADCALL |p| (QREFELT $ 64)) $)
                     (QREFELT $ 67)))
              (EXIT
               (|WEIER;maptake| |a| (SPADCALL |p| |q| (QREFELT $ 69)) $))))) 

(SDEFUN |WEIER;qq|
        ((|a| (|NonNegativeInteger|)) (|e| (|TaylorSeries| R))
         (|p| (|Stream| (|TaylorSeries| R)))
         (|c| (|Stream| (|TaylorSeries| R))) ($ (|Stream| (|TaylorSeries| R))))
        (SPADCALL |e|
                  (SPADCALL (SPADCALL |e| (QREFELT $ 70))
                            (|WEIER;mapdrop| |a|
                             (SPADCALL |p| |c| (QREFELT $ 69)) $)
                            (QREFELT $ 71))
                  (QREFELT $ 72))) 

(SDEFUN |WEIER;qqq|
        ((|a| (|NonNegativeInteger|)) (|e| (|TaylorSeries| R))
         (|p| (|Stream| (|TaylorSeries| R)))
         ($
          (|Mapping| (|Stream| (|TaylorSeries| R))
                     (|Stream| (|TaylorSeries| R)))))
        (SPROG NIL (CONS #'|WEIER;qqq!0| (VECTOR $ |p| |e| |a|)))) 

(SDEFUN |WEIER;qqq!0| ((|s| NIL) ($$ NIL))
        (PROG (|a| |e| |p| $)
          (LETT |a| (QREFELT $$ 3))
          (LETT |e| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|WEIER;qq| |a| |e| |p| |s| $))))) 

(SDEFUN |WEIER;wei|
        ((|v| (|Symbol|)) (|s| (|TaylorSeries| R))
         ($ (|Stream| (|TaylorSeries| R))))
        (|WEIER;weier| |v| |s| $)) 

(SDEFUN |WEIER;weierstrass;STsL;12|
        ((|v| (|Symbol|)) (|smps| (|TaylorSeries| R))
         ($ (|List| (|TaylorSeries| R))))
        (COND
         ((SPADCALL (SPADCALL |smps| (|spadConstant| $ 74) (QREFELT $ 75))
                    (|spadConstant| $ 29) (QREFELT $ 76))
          NIL)
         ('T (|WEIER;transback| (|WEIER;wei| |v| |smps| $) $)))) 

(DECLAIM (NOTINLINE |WeierstrassPreparation;|)) 

(DEFUN |WeierstrassPreparation| (#1=#:G767)
  (SPROG NIL
         (PROG (#2=#:G768)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|WeierstrassPreparation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|WeierstrassPreparation;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|WeierstrassPreparation|)))))))))) 

(DEFUN |WeierstrassPreparation;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|WeierstrassPreparation| DV$1))
          (LETT $ (GETREFV 79))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|WeierstrassPreparation| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|WeierstrassPreparation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (|Stream| 21)
              (0 . |empty?|) (|Stream| 14) (|Stream| 10) (5 . |first|)
              (10 . |empty?|) (|Polynomial| 6) (15 . |Zero|) (19 . |first|)
              (|Mapping| 14 10) (|StreamFunctions2| 10 14) (24 . |map|)
              (30 . |One|) (|TaylorSeries| 6) (34 . |One|)
              (|NonNegativeInteger|) (38 . |One|) (42 . |rest|)
              (|Mapping| 10 10) (|StreamFunctions2| 10 10) (48 . |map|)
              (54 . |Zero|) (58 . |Zero|) (|SparseUnivariatePolynomial| 14)
              (62 . |coefficient|) (68 . |empty|) (72 . |cons|) (78 . |empty?|)
              (83 . |empty|) (87 . |rest|) (92 . |rst|) (97 . |cons|)
              (|Mapping| $) (103 . |delay|) (|Stream| 43) (|Integer|)
              (|StreamTaylorSeriesOperations| 14) (108 . |integers|)
              (|SparseUnivariatePolynomial| $) (|Symbol|) (113 . |univariate|)
              (|Stream| 31) (|Mapping| 31 14) (|StreamFunctions2| 14 31)
              (119 . |map|) (|Mapping| 10 31 23) (|Stream| 23)
              (|StreamFunctions3| 31 23 10) (125 . |map|) (132 . |first|)
              (138 . |first|) (143 . =) (|Union| 6 '"failed")
              (149 . |retractIfCan|) (|Union| 10 '"failed") (154 . |recip|)
              (159 . |rest|) (|Mapping| 8 8)
              (|ParadoxicalCombinatorsForStreams| 21) (164 . Y)
              (|StreamTaylorSeriesOperations| 21) (169 . *) (175 . -) (180 . *)
              (186 . |cons|) (|IndexedExponents| 47) (192 . |Zero|)
              (196 . |coefficient|) (202 . ~=) (|List| 21)
              |WEIER;weierstrass;STsL;12|)
           '#(|weierstrass| 208) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|weierstrass|
                                 ((|List| (|TaylorSeries| |#1|)) (|Symbol|)
                                  (|TaylorSeries| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 78
                                            '(1 8 7 0 9 1 11 10 0 12 1 10 7 0
                                              13 0 14 0 15 1 10 14 0 16 2 18 10
                                              17 11 19 0 6 0 20 0 21 0 22 0 23
                                              0 24 2 10 0 0 23 25 2 27 11 26 11
                                              28 0 6 0 29 0 21 0 30 2 31 14 0
                                              23 32 0 10 0 33 2 10 0 14 0 34 1
                                              11 7 0 35 0 11 0 36 1 10 0 0 37 1
                                              11 0 0 38 2 11 0 10 0 39 1 11 0
                                              40 41 1 44 42 43 45 2 14 46 0 47
                                              48 2 51 49 50 10 52 3 55 11 53 49
                                              54 56 2 10 0 0 23 57 1 8 21 0 58
                                              2 14 7 0 0 59 1 14 60 0 61 1 44
                                              62 10 63 1 8 0 0 64 1 66 8 65 67
                                              2 68 8 8 8 69 1 21 0 0 70 2 68 8
                                              21 8 71 2 8 0 21 0 72 0 73 0 74 2
                                              21 6 0 73 75 2 6 7 0 0 76 2 0 77
                                              47 21 78)))))
           '|lookupComplete|)) 
