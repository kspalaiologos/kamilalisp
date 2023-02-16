
(SDEFUN |UPDECOMP;rightFactorIfCan0|
        ((|p| (UP)) (|dq| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         (|lcq| (R)) ($ (|Union| UP "failed")))
        (SPROG
         ((|q| (UP)) (#1=#:G704 NIL) (#2=#:G719 NIL)
          (|cquo| (|Union| R "failed")) (|c| (R)) (#3=#:G721 NIL) (|i| NIL)
          (#4=#:G720 NIL) (|k| NIL) (|lcp| (R)) (|s| (|NonNegativeInteger|))
          (|dp| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |dp| (SPADCALL |p| (QREFELT $ 9)))
                (LETT |s|
                      (PROG2 (LETT #1# (SPADCALL |dq| 1 (QREFELT $ 13)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                        (|Union| (|NonNegativeInteger|)
                                                 #5="failed")
                                        #1#)))
                (LETT |lcp| (SPADCALL |p| (QREFELT $ 14)))
                (LETT |q| (SPADCALL |lcq| |dq| (QREFELT $ 15)))
                (SEQ (LETT |k| 1) (LETT #4# |s|) G190
                     (COND ((|greater_SI| |k| #4#) (GO G191)))
                     (SEQ (LETT |c| (|spadConstant| $ 16))
                          (SEQ (LETT |i| 0)
                               (LETT #3#
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |k| 1 (QREFELT $ 13)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (|NonNegativeInteger|)
                                                       (|Union|
                                                        (|NonNegativeInteger|)
                                                        #5#)
                                                       #1#)))
                               G190 (COND ((|greater_SI| |i| #3#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT |c|
                                       (SPADCALL |c|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |k|
                                                              (QREFELT $ 18))
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL |n|
                                                                (QREFELT $ 18))
                                                      (|spadConstant| $ 10)
                                                      (QREFELT $ 19))
                                                     (SPADCALL |i|
                                                               (QREFELT $ 18))
                                                     (QREFELT $ 20))
                                                    (QREFELT $ 21))
                                                   (SPADCALL |q|
                                                             (PROG2
                                                                 (LETT #1#
                                                                       (SPADCALL
                                                                        |dq|
                                                                        |i|
                                                                        (QREFELT
                                                                         $
                                                                         13)))
                                                                 (QCDR #1#)
                                                               (|check_union2|
                                                                (QEQCAR #1# 0)
                                                                (|NonNegativeInteger|)
                                                                (|Union|
                                                                 (|NonNegativeInteger|)
                                                                 #5#)
                                                                #1#))
                                                             (QREFELT $ 22))
                                                   (QREFELT $ 20))
                                                  (SPADCALL |p|
                                                            (PROG2
                                                                (LETT #1#
                                                                      (SPADCALL
                                                                       (+ |dp|
                                                                          |i|)
                                                                       |k|
                                                                       (QREFELT
                                                                        $ 13)))
                                                                (QCDR #1#)
                                                              (|check_union2|
                                                               (QEQCAR #1# 0)
                                                               (|NonNegativeInteger|)
                                                               (|Union|
                                                                (|NonNegativeInteger|)
                                                                #5#)
                                                               #1#))
                                                            (QREFELT $ 22))
                                                  (QREFELT $ 20))
                                                 (QREFELT $ 19)))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT NIL))
                          (LETT |cquo|
                                (SPADCALL |c|
                                          (SPADCALL
                                           (SPADCALL (* |k| |n|)
                                                     (QREFELT $ 18))
                                           |lcp| (QREFELT $ 20))
                                          (QREFELT $ 23)))
                          (EXIT
                           (COND
                            ((QEQCAR |cquo| 1)
                             (PROGN
                              (LETT #2# (CONS 1 "failed"))
                              (GO #6=#:G718)))
                            ('T
                             (LETT |q|
                                   (SPADCALL |q|
                                             (SPADCALL (QCDR |cquo|)
                                                       (PROG2
                                                           (LETT #1#
                                                                 (SPADCALL |dq|
                                                                           |k|
                                                                           (QREFELT
                                                                            $
                                                                            13)))
                                                           (QCDR #1#)
                                                         (|check_union2|
                                                          (QEQCAR #1# 0)
                                                          (|NonNegativeInteger|)
                                                          (|Union|
                                                           (|NonNegativeInteger|)
                                                           #5#)
                                                          #1#))
                                                       (QREFELT $ 15))
                                             (QREFELT $ 24)))))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |q|))))
          #6# (EXIT #2#)))) 

(SDEFUN |UPDECOMP;rightFactorIfCan;UPNniRU;2|
        ((|p| (UP)) (|dq| (|NonNegativeInteger|)) (|lcq| (R))
         ($ (|Union| UP "failed")))
        (SPROG
         ((|q| (UP)) (#1=#:G746 NIL) (|cu| #2=(|Union| R "failed")) (|c| (R))
          (#3=#:G748 NIL) (|j| NIL) (|k| (|NonNegativeInteger|))
          (|k1| (|NonNegativeInteger|)) (|p1| (UP)) (|qn| (UP)) (|qn1| (UP))
          (#4=#:G747 NIL) (|i| NIL) (|cc2| (R)) (|cc1| (R)) (|cc0| (R))
          (|cc0u| #2#) (|lcn1| (R)) (|lcn| (R)) (|n1| (|NonNegativeInteger|))
          (#5=#:G727 NIL) (|nr| (R)) (|n| (|NonNegativeInteger|))
          (|nc| (|Union| (|NonNegativeInteger|) "failed"))
          (|dp| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |dp| (SPADCALL |p| (QREFELT $ 9)))
                (EXIT
                 (COND
                  ((SPADCALL |lcq| (QREFELT $ 28))
                   (|error|
                    "rightFactorIfCan: leading coefficient may not be zero"))
                  ((OR (ZEROP |dp|) (ZEROP |dq|)) (CONS 1 "failed"))
                  ('T
                   (SEQ (LETT |nc| (SPADCALL |dp| |dq| (QREFELT $ 29)))
                        (EXIT
                         (COND ((QEQCAR |nc| 1) (CONS 1 "failed"))
                               (#6='T
                                (SEQ (LETT |n| (QCDR |nc|))
                                     (COND
                                      ((OR (EQL (QREFELT $ 26) 0)
                                           (< |n| (QREFELT $ 26)))
                                       (EXIT
                                        (|UPDECOMP;rightFactorIfCan0| |p| |dq|
                                         |n| |lcq| $))))
                                     (LETT |nr| (SPADCALL |n| (QREFELT $ 18)))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |nr| (|spadConstant| $ 16)
                                                  (QREFELT $ 31))
                                        (CONS 1 "failed"))
                                       (#6#
                                        (SEQ
                                         (LETT |q|
                                               (SPADCALL |lcq| |dq|
                                                         (QREFELT $ 15)))
                                         (LETT |n1|
                                               (PROG1 (LETT #5# (- |n| 1))
                                                 (|check_subtype2| (>= #5# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #5#)))
                                         (LETT |qn1|
                                               (SPADCALL |q| |n1|
                                                         (QREFELT $ 32)))
                                         (LETT |qn|
                                               (SPADCALL |q| |qn1|
                                                         (QREFELT $ 33)))
                                         (LETT |lcn|
                                               (SPADCALL |qn| (QREFELT $ 14)))
                                         (LETT |lcn1|
                                               (SPADCALL |nr|
                                                         (SPADCALL |qn1|
                                                                   (QREFELT $
                                                                            14))
                                                         (QREFELT $ 20)))
                                         (LETT |cc0u|
                                               (SPADCALL
                                                (SPADCALL |p| (QREFELT $ 14))
                                                |lcn| (QREFELT $ 23)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |cc0u| 1)
                                            (CONS 1 "failed"))
                                           (#6#
                                            (SEQ (LETT |cc0| (QCDR |cc0u|))
                                                 (LETT |cc1|
                                                       (SPADCALL |cc0| |nr|
                                                                 (QREFELT $
                                                                          20)))
                                                 (LETT |cc2|
                                                       (SPADCALL |cc0| |lcn1|
                                                                 (QREFELT $
                                                                          20)))
                                                 (LETT |p1|
                                                       (SPADCALL |p|
                                                                 (SPADCALL
                                                                  |cc0| |qn|
                                                                  (QREFELT $
                                                                           34))
                                                                 (QREFELT $
                                                                          35)))
                                                 (LETT |k1| 1) (LETT |k| 2)
                                                 (LETT |qn1|
                                                       (|spadConstant| $ 30))
                                                 (SEQ (LETT |i| 1)
                                                      (LETT #4# (- |dq| 1))
                                                      G190
                                                      (COND
                                                       ((|greater_SI| |i| #4#)
                                                        (GO G191)))
                                                      (SEQ
                                                       (COND
                                                        ((EQL |i| |k|)
                                                         (SEQ
                                                          (LETT |qn1|
                                                                (SPADCALL |q|
                                                                          |n1|
                                                                          (QREFELT
                                                                           $
                                                                           32)))
                                                          (LETT |qn|
                                                                (SPADCALL |q|
                                                                          |qn1|
                                                                          (QREFELT
                                                                           $
                                                                           33)))
                                                          (LETT |p1|
                                                                (SPADCALL |p|
                                                                          (SPADCALL
                                                                           |cc0|
                                                                           |qn|
                                                                           (QREFELT
                                                                            $
                                                                            34))
                                                                          (QREFELT
                                                                           $
                                                                           35)))
                                                          (LETT |k1| |k|)
                                                          (EXIT
                                                           (LETT |k|
                                                                 (* 2 |k|))))))
                                                       (LETT |c|
                                                             (SPADCALL |p1|
                                                                       (- |dp|
                                                                          |i|)
                                                                       (QREFELT
                                                                        $ 22)))
                                                       (SEQ (LETT |j| |k1|)
                                                            (LETT #3#
                                                                  (- |i| 1))
                                                            G190
                                                            (COND
                                                             ((> |j| #3#)
                                                              (GO G191)))
                                                            (SEQ
                                                             (EXIT
                                                              (LETT |c|
                                                                    (SPADCALL
                                                                     |c|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       |cc1|
                                                                       (SPADCALL
                                                                        |q|
                                                                        (- |dq|
                                                                           |j|)
                                                                        (QREFELT
                                                                         $ 22))
                                                                       (QREFELT
                                                                        $ 20))
                                                                      (SPADCALL
                                                                       |qn1|
                                                                       (+
                                                                        (-
                                                                         (-
                                                                          |dp|
                                                                          |dq|)
                                                                         |i|)
                                                                        |j|)
                                                                       (QREFELT
                                                                        $ 22))
                                                                      (QREFELT
                                                                       $ 20))
                                                                     (QREFELT $
                                                                              21)))))
                                                            (LETT |j|
                                                                  (+ |j| 1))
                                                            (GO G190) G191
                                                            (EXIT NIL))
                                                       (LETT |cu|
                                                             (SPADCALL |c|
                                                                       |cc2|
                                                                       (QREFELT
                                                                        $ 23)))
                                                       (EXIT
                                                        (COND
                                                         ((QEQCAR |cu| 1)
                                                          (PROGN
                                                           (LETT #1#
                                                                 (CONS 1
                                                                       "failed"))
                                                           (GO #7=#:G745)))
                                                         ('T
                                                          (LETT |q|
                                                                (SPADCALL |q|
                                                                          (SPADCALL
                                                                           (QCDR
                                                                            |cu|)
                                                                           (-
                                                                            |dq|
                                                                            |i|)
                                                                           (QREFELT
                                                                            $
                                                                            15))
                                                                          (QREFELT
                                                                           $
                                                                           24)))))))
                                                      (LETT |i| (|inc_SI| |i|))
                                                      (GO G190) G191
                                                      (EXIT NIL))
                                                 (EXIT
                                                  (CONS 0
                                                        |q|))))))))))))))))))))
          #7# (EXIT #1#)))) 

(SDEFUN |UPDECOMP;monicRightFactorIfCan;UPNniU;3|
        ((|p| (UP)) (|dq| (|NonNegativeInteger|)) ($ (|Union| UP "failed")))
        (SPADCALL |p| |dq| (|spadConstant| $ 10) (QREFELT $ 37))) 

(SDEFUN |UPDECOMP;leftFactorIfCan;2UPU;4|
        ((|f| (UP)) (|h| (UP)) ($ (|Union| UP "failed")))
        (SPROG
         ((|g| (UP)) (#1=#:G763 NIL) (|r| (UP))
          (|qr| (|Record| (|:| |quotient| UP) (|:| |remainder| UP)))
          (|qrf|
           (|Union| (|Record| (|:| |quotient| UP) (|:| |remainder| UP))
                    "failed"))
          (|i| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |g| (|spadConstant| $ 30))
                (EXIT
                 (COND ((ZEROP (SPADCALL |h| (QREFELT $ 9))) (CONS 1 "failed"))
                       ('T
                        (SEQ
                         (SEQ (LETT |i| 0) G190
                              (COND
                               ((NULL (NULL (SPADCALL |f| (QREFELT $ 39))))
                                (GO G191)))
                              (SEQ
                               (LETT |qrf| (SPADCALL |f| |h| (QREFELT $ 43)))
                               (EXIT
                                (COND
                                 ((QEQCAR |qrf| 1)
                                  (PROGN
                                   (LETT #1# (CONS 1 "failed"))
                                   (GO #2=#:G762)))
                                 ('T
                                  (SEQ (LETT |qr| (QCDR |qrf|))
                                       (LETT |r| (QCDR |qr|))
                                       (COND
                                        ((NULL (SPADCALL |r| (QREFELT $ 44)))
                                         (EXIT
                                          (PROGN
                                           (LETT #1# (CONS 1 "failed"))
                                           (GO #2#)))))
                                       (LETT |g|
                                             (SPADCALL |g|
                                                       (SPADCALL
                                                        (SPADCALL |r|
                                                                  (QREFELT $
                                                                           45))
                                                        |i| (QREFELT $ 15))
                                                       (QREFELT $ 24)))
                                       (EXIT (LETT |f| (QCAR |qr|))))))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT (CONS 0 |g|))))))))
          #2# (EXIT #1#)))) 

(SDEFUN |UPDECOMP;monicDecomposeIfCan;UPU;5|
        ((|f| (UP))
         ($ (|Union| (|Record| (|:| |left| UP) (|:| |right| UP)) "failed")))
        (SPROG
         ((#1=#:G782 NIL) (|g| (|Union| UP "failed"))
          (|h| (|Union| UP "failed")) (#2=#:G783 NIL) (#3=#:G770 NIL)
          (|dh| NIL) (|df| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |df| (SPADCALL |f| (QREFELT $ 9)))
                (EXIT
                 (COND ((ZEROP |df|) (CONS 1 "failed"))
                       ('T
                        (SEQ
                         (SEQ (LETT |dh| 2)
                              (LETT #2#
                                    (PROG2
                                        (LETT #3#
                                              (SPADCALL |df| 1 (QREFELT $ 13)))
                                        (QCDR #3#)
                                      (|check_union2| (QEQCAR #3# 0)
                                                      (|NonNegativeInteger|)
                                                      (|Union|
                                                       (|NonNegativeInteger|)
                                                       "failed")
                                                      #3#)))
                              G190 (COND ((|greater_SI| |dh| #2#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((ZEROP (REM |df| |dh|))
                                  (SEQ
                                   (LETT |h|
                                         (SPADCALL |f| |dh| (QREFELT $ 38)))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |h| 0)
                                      (SEQ
                                       (LETT |g|
                                             (SPADCALL |f| (QCDR |h|)
                                                       (QREFELT $ 46)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |g| 0)
                                          (PROGN
                                           (LETT #1#
                                                 (CONS 0
                                                       (CONS (QCDR |g|)
                                                             (QCDR |h|))))
                                           (GO #4=#:G781))))))))))))))
                              (LETT |dh| (|inc_SI| |dh|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT (CONS 1 "failed"))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |UPDECOMP;monicCompleteDecompose;UPL;6| ((|f| (UP)) ($ (|List| UP)))
        (SPROG
         ((|lr| (|Record| (|:| |left| UP) (|:| |right| UP)))
          (|cf|
           (|Union| (|Record| (|:| |left| UP) (|:| |right| UP)) "failed")))
         (SEQ (LETT |cf| (SPADCALL |f| (QREFELT $ 49)))
              (EXIT
               (COND ((QEQCAR |cf| 1) (LIST |f|))
                     ('T
                      (SEQ (LETT |lr| (QCDR |cf|))
                           (EXIT
                            (SPADCALL (SPADCALL (QCAR |lr|) (QREFELT $ 51))
                                      (LIST (QCDR |lr|)) (QREFELT $ 52)))))))))) 

(SDEFUN |UPDECOMP;decomposeIfCan;UPU;7|
        ((|f| (UP))
         ($ (|Union| (|Record| (|:| |left| UP) (|:| |right| UP)) "failed")))
        (SPROG
         ((|lr| (|Record| (|:| |left| UP) (|:| |right| UP)))
          (|res1|
           (|Union| (|Record| (|:| |left| UP) (|:| |right| UP)) "failed"))
          (|lc| (R)))
         (SEQ (LETT |lc| (SPADCALL |f| (QREFELT $ 14)))
              (LETT |f| (SPADCALL |f| |lc| (QREFELT $ 53)))
              (LETT |res1| (SPADCALL |f| (QREFELT $ 49)))
              (EXIT
               (COND ((QEQCAR |res1| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |lr| (QCDR |res1|))
                           (EXIT
                            (CONS 0
                                  (CONS
                                   (SPADCALL |lc| (QCAR |lr|) (QREFELT $ 34))
                                   (QCDR |lr|))))))))))) 

(SDEFUN |UPDECOMP;completeDecompose;UPL;8| ((|f| (UP)) ($ (|List| UP)))
        (SPROG ((|res1| (|List| UP)) (|lc| (R)))
               (SEQ (LETT |lc| (SPADCALL |f| (QREFELT $ 14)))
                    (LETT |f| (SPADCALL |f| |lc| (QREFELT $ 53)))
                    (LETT |res1| (SPADCALL |f| (QREFELT $ 51)))
                    (EXIT
                     (CONS (SPADCALL |lc| (|SPADfirst| |res1|) (QREFELT $ 34))
                           (CDR |res1|)))))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialDecompositionPackage;|)) 

(DEFUN |UnivariatePolynomialDecompositionPackage| (&REST #1=#:G804)
  (SPROG NIL
         (PROG (#2=#:G805)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomialDecompositionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |UnivariatePolynomialDecompositionPackage;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialDecompositionPackage|)))))))))) 

(DEFUN |UnivariatePolynomialDecompositionPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|UnivariatePolynomialDecompositionPackage| DV$1 DV$2))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache|
                      '|UnivariatePolynomialDecompositionPackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 26 (SPADCALL (QREFELT $ 25)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 54
                       (CONS
                        (|dispatchFunction| |UPDECOMP;decomposeIfCan;UPU;7|)
                        $))
             (QSETREFV $ 55
                       (CONS
                        (|dispatchFunction| |UPDECOMP;completeDecompose;UPL;8|)
                        $)))))
          $))) 

(MAKEPROP '|UnivariatePolynomialDecompositionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |degree|) (5 . |One|) (9 . |One|)
              (|Union| $ '"failed") (13 . |subtractIfCan|)
              (19 . |leadingCoefficient|) (24 . |monomial|) (30 . |Zero|)
              (|Integer|) (34 . |coerce|) (39 . +) (45 . *) (51 . -)
              (57 . |coefficient|) (63 . |exquo|) (69 . +)
              (75 . |characteristic|) '|char_R| (|Boolean|) (79 . |zero?|)
              (84 . |exquo|) (90 . |Zero|) (94 . =) (100 . ^) (106 . *)
              (112 . *) (118 . -) (|Union| 7 '#1="failed")
              |UPDECOMP;rightFactorIfCan;UPNniRU;2|
              |UPDECOMP;monicRightFactorIfCan;UPNniU;3| (124 . |zero?|)
              (|Record| (|:| |quotient| 7) (|:| |remainder| 7))
              (|Union| 40 '"failed")
              (|UnivariatePolynomialDivisionPackage| 6 7) (129 . |divideIfCan|)
              (135 . |ground?|) (140 . |ground|)
              |UPDECOMP;leftFactorIfCan;2UPU;4|
              (|Record| (|:| |left| 7) (|:| |right| 7))
              (|Union| 47 '#2="failed") |UPDECOMP;monicDecomposeIfCan;UPU;5|
              (|List| 7) |UPDECOMP;monicCompleteDecompose;UPL;6|
              (145 . |append|) (151 . /) (157 . |decomposeIfCan|)
              (162 . |completeDecompose|))
           '#(|rightFactorIfCan| 167 |monicRightFactorIfCan| 174
              |monicDecomposeIfCan| 180 |monicCompleteDecompose| 185
              |leftFactorIfCan| 190 |decomposeIfCan| 196 |completeDecompose|
              201)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|monicRightFactorIfCan|
                                 ((|Union| |#2| "failed") |#2|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|rightFactorIfCan|
                                 ((|Union| |#2| #1#) |#2|
                                  (|NonNegativeInteger|) |#1|))
                                T)
                              '((|leftFactorIfCan|
                                 ((|Union| |#2| "failed") |#2| |#2|))
                                T)
                              '((|monicDecomposeIfCan|
                                 ((|Union|
                                   (|Record| (|:| |left| |#2|)
                                             (|:| |right| |#2|))
                                   #2#)
                                  |#2|))
                                T)
                              '((|monicCompleteDecompose| ((|List| |#2|) |#2|))
                                T)
                              '((|decomposeIfCan|
                                 ((|Union|
                                   (|Record| (|:| |left| |#2|)
                                             (|:| |right| |#2|))
                                   "failed")
                                  |#2|))
                                (|has| 6 (|Field|)))
                              '((|completeDecompose| ((|List| |#2|) |#2|))
                                (|has| 6 (|Field|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 55
                                            '(1 7 8 0 9 0 6 0 10 0 7 0 11 2 8
                                              12 0 0 13 1 7 6 0 14 2 7 0 6 8 15
                                              0 6 0 16 1 6 0 17 18 2 6 0 0 0 19
                                              2 6 0 0 0 20 2 6 0 0 0 21 2 7 6 0
                                              8 22 2 6 12 0 0 23 2 7 0 0 0 24 0
                                              6 8 25 1 6 27 0 28 2 8 12 0 0 29
                                              0 7 0 30 2 6 27 0 0 31 2 7 0 0 8
                                              32 2 7 0 0 0 33 2 7 0 6 0 34 2 7
                                              0 0 0 35 1 7 27 0 39 2 42 41 7 7
                                              43 1 7 27 0 44 1 7 6 0 45 2 50 0
                                              0 0 52 2 7 0 0 6 53 1 0 48 7 54 1
                                              0 50 7 55 3 0 36 7 8 6 37 2 0 36
                                              7 8 38 1 0 48 7 49 1 0 50 7 51 2
                                              0 36 7 7 46 1 1 48 7 54 1 1 50 7
                                              55)))))
           '|lookupComplete|)) 
