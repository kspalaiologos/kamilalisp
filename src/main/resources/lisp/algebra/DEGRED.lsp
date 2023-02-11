
(SDEFUN |DEGRED;degrees|
        ((|u| (|SparseUnivariatePolynomial| R1)) ($ (|List| (|Integer|))))
        (SPROG ((|l| (|List| (|Integer|))))
               (SEQ (LETT |l| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |u| (|spadConstant| $ 11)
                                      (QREFELT $ 13)))
                           (GO G191)))
                         (SEQ
                          (LETT |l| (CONS (SPADCALL |u| (QREFELT $ 15)) |l|))
                          (EXIT (LETT |u| (SPADCALL |u| (QREFELT $ 16)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |l|)))) 

(SDEFUN |DEGRED;reduce;SupR;2|
        ((|u| (|SparseUnivariatePolynomial| R1))
         ($
          (|Record| (|:| |pol| (|SparseUnivariatePolynomial| R1))
                    (|:| |deg| (|PositiveInteger|)))))
        (SPROG
         ((#1=#:G718 NIL) (#2=#:G715 NIL) (#3=#:G713 NIL) (|g| #4=(|Integer|))
          (#5=#:G706 NIL) (#6=#:G705 #4#) (#7=#:G707 #4#) (#8=#:G722 NIL)
          (|d| NIL))
         (SEQ
          (LETT |g|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |d| NIL) (LETT #8# (|DEGRED;degrees| |u| $)) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |d| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #7# |d|)
                         (COND (#5# (LETT #6# (GCD #6# #7#)))
                               ('T (PROGN (LETT #6# #7#) (LETT #5# 'T)))))))
                      (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                 (COND (#5# #6#) ('T 0))))
          (LETT |u|
                (PROG2
                    (LETT #2#
                          (SPADCALL |u|
                                    (PROG1 (LETT #3# |g|)
                                      (|check_subtype2| (> #3# 0)
                                                        '(|PositiveInteger|)
                                                        '(|Integer|) #3#))
                                    (QREFELT $ 18)))
                    (QCDR #2#)
                  (|check_union2| (QEQCAR #2# 0)
                                  (|SparseUnivariatePolynomial| (QREFELT $ 6))
                                  (|Union|
                                   (|SparseUnivariatePolynomial| (QREFELT $ 6))
                                   "failed")
                                  #2#)))
          (EXIT
           (CONS |u|
                 (PROG1 (LETT #1# |g|)
                   (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                     '(|Integer|) #1#))))))) 

(SDEFUN |DEGRED;rootOfUnity|
        ((|j| (|Integer|)) (|n| (|Integer|)) ($ (|Expression| R2)))
        (SPROG ((|arg| (|Expression| R2)))
               (SEQ
                (COND ((EQL |j| 0) (|spadConstant| $ 22))
                      ('T
                       (SEQ
                        (LETT |arg|
                              (SPADCALL
                               (SPADCALL (* 2 |j|) (SPADCALL (QREFELT $ 23))
                                         (QREFELT $ 25))
                               (SPADCALL |n| (QREFELT $ 26)) (QREFELT $ 27)))
                        (EXIT
                         (SPADCALL (SPADCALL |arg| (QREFELT $ 28))
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 22)
                                               (QREFELT $ 35))
                                     (SPADCALL 1 2 (QREFELT $ 34))
                                     (QREFELT $ 38))
                                    (SPADCALL |arg| (QREFELT $ 39))
                                    (QREFELT $ 40))
                                   (QREFELT $ 41))))))))) 

(SDEFUN |DEGRED;even_part| ((|gp| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((|res| (|PositiveInteger|)) (|g| (|NonNegativeInteger|)))
               (SEQ (LETT |g| |gp|) (LETT |res| 1)
                    (SEQ G190 (COND ((NULL (EVENP |g|)) (GO G191)))
                         (SEQ (LETT |g| (QUOTIENT2 |g| 2))
                              (EXIT (LETT |res| (* |res| 2))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |DEGRED;expand;EPiL;5|
        ((|s| (|Expression| R2)) (|g| (|PositiveInteger|))
         ($ (|List| (|Expression| R2))))
        (SPROG
         ((#1=#:G747 NIL) (|i| NIL) (#2=#:G746 NIL) (|sr| (|Expression| R2))
          (|g2| (|PositiveInteger|)))
         (SEQ
          (COND ((EQL |g| 1) (LIST |s|))
                (#3='T
                 (SEQ
                  (LETT |sr|
                        (COND
                         ((SPADCALL |s|
                                    (SPADCALL (|spadConstant| $ 22)
                                              (QREFELT $ 35))
                                    (QREFELT $ 42))
                          (SEQ (LETT |g2| (|DEGRED;even_part| |g| $))
                               (EXIT
                                (COND ((EQL |g2| 1) |s|)
                                      (#3#
                                       (SPADCALL |s|
                                                 (SPADCALL 1 |g2|
                                                           (QREFELT $ 34))
                                                 (QREFELT $ 38)))))))
                         (#3#
                          (SPADCALL |s| (SPADCALL 1 |g| (QREFELT $ 34))
                                    (QREFELT $ 38)))))
                  (EXIT
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |i| 0) (LETT #1# (- |g| 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2#
                                 (CONS
                                  (SPADCALL (|DEGRED;rootOfUnity| |i| |g| $)
                                            |sr| (QREFELT $ 40))
                                  #2#))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |DEGRED;cyclotomic_roots;PiL;6|
        ((|n| (|PositiveInteger|)) ($ (|List| (|Expression| R2))))
        (SPROG ((#1=#:G752 NIL) (|i| NIL) (#2=#:G751 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- |n| 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((EQL (GCD |i| |n|) 1)
                          (LETT #2#
                                (CONS (|DEGRED;rootOfUnity| |i| |n| $)
                                      #2#))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |DegreeReductionPackage;|)) 

(DEFUN |DegreeReductionPackage| (&REST #1=#:G753)
  (SPROG NIL
         (PROG (#2=#:G754)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DegreeReductionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DegreeReductionPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DegreeReductionPackage|)))))))))) 

(DEFUN |DegreeReductionPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|DegreeReductionPackage| DV$1 DV$2))
          (LETT $ (GETREFV 47))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DegreeReductionPackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DegreeReductionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |Zero|) (4 . |Zero|) (|SparseUnivariatePolynomial| 6)
              (8 . |Zero|) (|Boolean|) (12 . ~=) (|NonNegativeInteger|)
              (18 . |degree|) (23 . |reductum|) (|Union| $ '"failed")
              (28 . |divideExponents|) (|Record| (|:| |pol| 10) (|:| |deg| 44))
              |DEGRED;reduce;SupR;2| (|Expression| 7) (34 . |One|) (38 . |pi|)
              (|Integer|) (42 . *) (48 . |coerce|) (53 . /) (59 . |cos|)
              (64 . |One|) (68 . |One|) (72 . -) (77 . -) (|Fraction| 24)
              (82 . /) (88 . -)
              (|SparseMultivariatePolynomial| 7 (|Kernel| 21)) (93 . |One|)
              (97 . ^) (103 . |sin|) (108 . *) (114 . +) (120 . =) (|List| 21)
              (|PositiveInteger|) |DEGRED;expand;EPiL;5|
              |DEGRED;cyclotomic_roots;PiL;6|)
           '#(|reduce| 126 |expand| 131 |cyclotomic_roots| 137) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|reduce|
                                 ((|Record|
                                   (|:| |pol|
                                        (|SparseUnivariatePolynomial| |#1|))
                                   (|:| |deg| (|PositiveInteger|)))
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|expand|
                                 ((|List| (|Expression| |#2|))
                                  (|Expression| |#2|) (|PositiveInteger|)))
                                T)
                              '((|cyclotomic_roots|
                                 ((|List| (|Expression| |#2|))
                                  (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(0 6 0 8 0 7 0 9 0 10 0 11 2 10 12
                                              0 0 13 1 10 14 0 15 1 10 0 0 16 2
                                              10 17 0 14 18 0 21 0 22 0 21 0 23
                                              2 21 0 24 0 25 1 21 0 24 26 2 21
                                              0 0 0 27 1 21 0 0 28 0 6 0 29 0 7
                                              0 30 1 7 0 0 31 1 6 0 0 32 2 33 0
                                              24 24 34 1 21 0 0 35 0 36 0 37 2
                                              21 0 0 33 38 1 21 0 0 39 2 21 0 0
                                              0 40 2 21 0 0 0 41 2 21 12 0 0 42
                                              1 0 19 10 20 2 0 43 21 44 45 1 0
                                              43 44 46)))))
           '|lookupComplete|)) 
