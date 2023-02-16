
(SDEFUN |TWOFACT;pthRoot|
        ((|poly| (|SparseUnivariatePolynomial| F)) (|p| (|NonNegativeInteger|))
         (|PthRootPow| (|NonNegativeInteger|))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPROG ((|tmp| (|Union| (|SparseUnivariatePolynomial| F) "failed")))
               (SEQ
                (LETT |tmp|
                      (SPADCALL
                       (SPADCALL
                        (CONS #'|TWOFACT;pthRoot!0| (VECTOR $ |PthRootPow|))
                        |poly| (QREFELT $ 11))
                       |p| (QREFELT $ 13)))
                (EXIT
                 (COND
                  ((QEQCAR |tmp| 1) (|error| "consistency error in TwoFactor"))
                  ('T (QCDR |tmp|))))))) 

(SDEFUN |TWOFACT;pthRoot!0| ((|x| NIL) ($$ NIL))
        (PROG (|PthRootPow| $)
          (LETT |PthRootPow| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |PthRootPow| (QREFELT $ 8)))))) 

(SDEFUN |TWOFACT;tryTwoFactor;SupF;2|
        ((|m| (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (|TWOFACT;doTwoFactor| |m| NIL $)) 

(SDEFUN |TWOFACT;generalTwoFactor;SupF;3|
        ((|m| (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (|TWOFACT;doTwoFactor| |m| 'T $)) 

(SDEFUN |TWOFACT;doTwoFactor|
        ((|m| (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         (|do_ext| (|Boolean|))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|ll|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor|
                           (|SparseUnivariatePolynomial|
                            (|SparseUnivariatePolynomial| F)))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G807 NIL) (|v| NIL) (#2=#:G806 NIL)
          (|unitPart|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (#3=#:G795 NIL)
          (|nfl|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor|
                           (|SparseUnivariatePolynomial|
                            (|SparseUnivariatePolynomial| F)))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|twoF|
           (|Factored|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (|ydeg| #4=(|NonNegativeInteger|)) (#5=#:G773 NIL) (#6=#:G772 #4#)
          (#7=#:G774 #4#) (#8=#:G805 NIL) (|w| NIL) (#9=#:G804 NIL)
          (#10=#:G803 NIL)
          (|m2|
           #11=(|Factored|
                (|SparseUnivariatePolynomial|
                 (|SparseUnivariatePolynomial| F))))
          (#12=#:G802 NIL) (#13=#:G801 NIL) (|res| #11#)
          (|m1|
           (|Union|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))
            "failed"))
          (|PthRootPow| (|NonNegativeInteger|)) (#14=#:G757 NIL)
          (|p| (|NonNegativeInteger|))
          (|fac|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (|expon| (|NonNegativeInteger|)) (#15=#:G800 NIL) (|u| NIL)
          (|sqfrm|
           (|Factored|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (#16=#:G799 NIL) (#17=#:G798 NIL)
          (|contfact| #18=(|Factored| (|SparseUnivariatePolynomial| F)))
          (|cont| (|SparseUnivariatePolynomial| F)) (#19=#:G797 NIL)
          (#20=#:G796 NIL) (|l| #18#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 22))
             (|spadConstant| $ 23))
            ((EQL (SPADCALL |m| (QREFELT $ 24)) 0)
             (SEQ
              (LETT |l|
                    (SPADCALL (SPADCALL |m| (QREFELT $ 25)) (QREFELT $ 28)))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |l| (QREFELT $ 29)) (QREFELT $ 30))
                (PROGN
                 (LETT #20# NIL)
                 (SEQ (LETT |u| NIL) (LETT #19# (SPADCALL |l| (QREFELT $ 34)))
                      G190
                      (COND
                       ((OR (ATOM #19#) (PROGN (LETT |u| (CAR #19#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #20#
                              (CONS
                               (VECTOR (QVELT |u| 0)
                                       (SPADCALL (QVELT |u| 1) (QREFELT $ 30))
                                       (QVELT |u| 2))
                               #20#))))
                      (LETT #19# (CDR #19#)) (GO G190) G191
                      (EXIT (NREVERSE #20#))))
                (QREFELT $ 37)))))
            (#21='T
             (SEQ (LETT |ll| NIL) (LETT |cont| (SPADCALL |m| (QREFELT $ 38)))
                  (COND
                   ((> (SPADCALL |cont| (QREFELT $ 39)) 0)
                    (SEQ (LETT |m1| (SPADCALL |m| |cont| (QREFELT $ 40)))
                         (EXIT
                          (COND
                           ((QEQCAR |m1| 1) (|error| "content doesn't divide"))
                           (#21#
                            (SEQ (LETT |m| (QCDR |m1|))
                                 (LETT |contfact|
                                       (SPADCALL |cont| (QREFELT $ 28)))
                                 (LETT |unitPart|
                                       (SPADCALL
                                        (SPADCALL |contfact| (QREFELT $ 29))
                                        (QREFELT $ 30)))
                                 (EXIT
                                  (LETT |ll|
                                        (PROGN
                                         (LETT #17# NIL)
                                         (SEQ (LETT |w| NIL)
                                              (LETT #16#
                                                    (SPADCALL |contfact|
                                                              (QREFELT $ 34)))
                                              G190
                                              (COND
                                               ((OR (ATOM #16#)
                                                    (PROGN
                                                     (LETT |w| (CAR #16#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #17#
                                                      (CONS
                                                       (VECTOR (QVELT |w| 0)
                                                               (SPADCALL
                                                                (QVELT |w| 1)
                                                                (QREFELT $ 30))
                                                               (QVELT |w| 2))
                                                       #17#))))
                                              (LETT #16# (CDR #16#)) (GO G190)
                                              G191
                                              (EXIT (NREVERSE #17#))))))))))))
                   (#21# (LETT |unitPart| (SPADCALL |cont| (QREFELT $ 30)))))
                  (LETT |sqfrm| (SPADCALL |m| (QREFELT $ 42)))
                  (SEQ (LETT |u| NIL)
                       (LETT #15# (SPADCALL |sqfrm| (QREFELT $ 43))) G190
                       (COND
                        ((OR (ATOM #15#) (PROGN (LETT |u| (CAR #15#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |expon| (QVELT |u| 2))
                            (LETT |fac| (QVELT |u| 1))
                            (EXIT
                             (COND
                              ((EQL (SPADCALL |fac| (QREFELT $ 24)) 1)
                               (LETT |ll|
                                     (CONS
                                      (VECTOR (CONS 2 "irred") |fac| |expon|)
                                      |ll|)))
                              ((SPADCALL (SPADCALL |fac| (QREFELT $ 44))
                                         (|spadConstant| $ 20) (QREFELT $ 22))
                               (COND
                                ((SPADCALL
                                  (SPADCALL (ELT $ 46) |fac| (QREFELT $ 48))
                                  (|spadConstant| $ 20) (QREFELT $ 22))
                                 (SEQ (LETT |p| (SPADCALL (QREFELT $ 49)))
                                      (LETT |PthRootPow|
                                            (PROG2
                                                (LETT #14#
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (QREFELT $ 50))
                                                       |p| (QREFELT $ 51)))
                                                (QCDR #14#)
                                              (|check_union2| (QEQCAR #14# 0)
                                                              (|NonNegativeInteger|)
                                                              (|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              #14#)))
                                      (LETT |m1|
                                            (SPADCALL
                                             (SPADCALL
                                              (CONS #'|TWOFACT;doTwoFactor!0|
                                                    (VECTOR $ |PthRootPow|
                                                            |p|))
                                              |fac| (QREFELT $ 48))
                                             |p| (QREFELT $ 52)))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |m1| 1)
                                         (|error|
                                          "consistency error in TwoFactor"))
                                        ('T
                                         (SEQ
                                          (LETT |res|
                                                (SPADCALL (QCDR |m1|)
                                                          (QREFELT $ 17)))
                                          (LETT |unitPart|
                                                (SPADCALL |unitPart|
                                                          (SPADCALL
                                                           (SPADCALL |res|
                                                                     (QREFELT $
                                                                              53))
                                                           (* |p| |expon|)
                                                           (QREFELT $ 54))
                                                          (QREFELT $ 55)))
                                          (EXIT
                                           (LETT |ll|
                                                 (SPADCALL
                                                  (PROGN
                                                   (LETT #13# NIL)
                                                   (SEQ (LETT |v| NIL)
                                                        (LETT #12#
                                                              (SPADCALL |res|
                                                                        (QREFELT
                                                                         $
                                                                         43)))
                                                        G190
                                                        (COND
                                                         ((OR (ATOM #12#)
                                                              (PROGN
                                                               (LETT |v|
                                                                     (CAR
                                                                      #12#))
                                                               NIL))
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (LETT #13#
                                                                (CONS
                                                                 (VECTOR
                                                                  (QVELT |v| 0)
                                                                  (QVELT |v| 1)
                                                                  (*
                                                                   (* |expon|
                                                                      |p|)
                                                                   (QVELT |v|
                                                                          2)))
                                                                 #13#))))
                                                        (LETT #12# (CDR #12#))
                                                        (GO G190) G191
                                                        (EXIT
                                                         (NREVERSE #13#))))
                                                  |ll| (QREFELT $ 56))))))))))
                                ('T
                                 (SEQ
                                  (LETT |m2|
                                        (SPADCALL
                                         (SPADCALL |fac| (QREFELT $ 58))
                                         (QREFELT $ 17)))
                                  (LETT |unitPart|
                                        (SPADCALL |unitPart|
                                                  (SPADCALL
                                                   (SPADCALL |m2|
                                                             (QREFELT $ 53))
                                                   |expon| (QREFELT $ 54))
                                                  (QREFELT $ 55)))
                                  (EXIT
                                   (LETT |ll|
                                         (SPADCALL
                                          (PROGN
                                           (LETT #10# NIL)
                                           (SEQ (LETT |v| NIL)
                                                (LETT #9#
                                                      (SPADCALL |m2|
                                                                (QREFELT $
                                                                         43)))
                                                G190
                                                (COND
                                                 ((OR (ATOM #9#)
                                                      (PROGN
                                                       (LETT |v| (CAR #9#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #10#
                                                        (CONS
                                                         (VECTOR (QVELT |v| 0)
                                                                 (SPADCALL
                                                                  (QVELT |v| 1)
                                                                  (QREFELT $
                                                                           58))
                                                                 (* |expon|
                                                                    (QVELT |v|
                                                                           2)))
                                                         #10#))))
                                                (LETT #9# (CDR #9#)) (GO G190)
                                                G191 (EXIT (NREVERSE #10#))))
                                          |ll| (QREFELT $ 56))))))))
                              ('T
                               (SEQ
                                (LETT |ydeg|
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |w| NIL)
                                            (LETT #8#
                                                  (SPADCALL |fac|
                                                            (QREFELT $ 60)))
                                            G190
                                            (COND
                                             ((OR (ATOM #8#)
                                                  (PROGN
                                                   (LETT |w| (CAR #8#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (PROGN
                                               (LETT #7#
                                                     (SPADCALL |w|
                                                               (QREFELT $ 39)))
                                               (COND
                                                (#5# (LETT #6# (MAX #6# #7#)))
                                                ('T
                                                 (PROGN
                                                  (LETT #6# #7#)
                                                  (LETT #5# 'T)))))))
                                            (LETT #8# (CDR #8#)) (GO G190) G191
                                            (EXIT NIL))
                                       (COND (#5# #6#)
                                             ('T (|IdentityError| '|max|)))))
                                (LETT |twoF|
                                      (SPADCALL |fac| |ydeg| |do_ext|
                                                (QREFELT $ 62)))
                                (LETT |nfl| (SPADCALL |twoF| (QREFELT $ 43)))
                                (COND
                                 ((EQL (LENGTH |nfl|) 1)
                                  (COND
                                   ((QEQCAR
                                     (QVELT (SPADCALL |nfl| 1 (QREFELT $ 65))
                                            0)
                                     0)
                                    (EXIT
                                     (PROGN
                                      (LETT #3# |twoF|)
                                      (GO #22=#:G794)))))))
                                (LETT |unitPart|
                                      (SPADCALL |unitPart|
                                                (SPADCALL
                                                 (SPADCALL |twoF|
                                                           (QREFELT $ 53))
                                                 |expon| (QREFELT $ 54))
                                                (QREFELT $ 55)))
                                (EXIT
                                 (LETT |ll|
                                       (SPADCALL
                                        (PROGN
                                         (LETT #2# NIL)
                                         (SEQ (LETT |v| NIL)
                                              (LETT #1#
                                                    (SPADCALL |twoF|
                                                              (QREFELT $ 43)))
                                              G190
                                              (COND
                                               ((OR (ATOM #1#)
                                                    (PROGN
                                                     (LETT |v| (CAR #1#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #2#
                                                      (CONS
                                                       (VECTOR (QVELT |v| 0)
                                                               (QVELT |v| 1)
                                                               (* |expon|
                                                                  (QVELT |v|
                                                                         2)))
                                                       #2#))))
                                              (LETT #1# (CDR #1#)) (GO G190)
                                              G191 (EXIT (NREVERSE #2#))))
                                        |ll| (QREFELT $ 56)))))))))
                       (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (SPADCALL |unitPart| |ll| (QREFELT $ 37)))))))
          #22# (EXIT #3#)))) 

(SDEFUN |TWOFACT;doTwoFactor!0| ((|x| NIL) ($$ NIL))
        (PROG (|p| |PthRootPow| $)
          (LETT |p| (QREFELT $$ 2))
          (LETT |PthRootPow| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|TWOFACT;pthRoot| |x| |p| |PthRootPow| $))))) 

(SDEFUN |TWOFACT;twoFactor;SupIF;5|
        ((|m| (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         (|dx| (|Integer|))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (SPADCALL |m| |dx| 'T (QREFELT $ 62))) 

(SDEFUN |TWOFACT;doExtension1|
        ((|m|
          #1=(|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         (|n| (|PositiveInteger|)) (|dx| (|Integer|))
         (|extField| (|FiniteAlgebraicExtensionField| F))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#2=#:G840 NIL)
          (#3=#:G839
           #4=(|Factored|
               (|SparseUnivariatePolynomial|
                (|SparseUnivariatePolynomial| F))))
          (#5=#:G841 #4#) (#6=#:G851 NIL) (|ff1| NIL)
          (|lfactk|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (#7=#:G828 NIL) (|ffn| (TP)) (#8=#:G835 NIL) (#9=#:G834 (TP))
          (#10=#:G836 (TP)) (#11=#:G850 NIL) (#12=#:G689 NIL)
          (|lfacth|
           (|List|
            #13=(|SparseUnivariatePolynomial|
                 (|SparseUnivariatePolynomial| |extField|))))
          (#14=#:G849 NIL) (|g| NIL) (#15=#:G848 NIL) (|normfacs| (|List| TP))
          (#16=#:G845 NIL)
          (|ffu|
           (|Union|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))
            #17="failed"))
          (|ff|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| |extField|)))
          (|c| (|extField|)) (#18=#:G847 NIL) (|fac| NIL) (#19=#:G846 NIL)
          (|Normp|
           (CATEGORY |package| (SIGNATURE |normFactors| ((|List| TP) TP))
            (SIGNATURE |retractIfCan|
             ((|Union|
               (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))
               "failed")
              TP))
            (SIGNATURE |Frobenius| (TP TP))))
          (|flist|
           (|List|
            (|Record|
             (|:| |flag|
                  (|Union| #20="nil" #21="sqfr" #22="irred" #23="prime"))
             (|:| |factor| #13#) (|:| |exponent| (|NonNegativeInteger|)))))
          (|res1|
           (|Factored|
            (|SparseUnivariatePolynomial|
             (|SparseUnivariatePolynomial| |extField|))))
          (|m1| #1#) (|mm| (TP))
          (TP
           (|Join| (|UnivariatePolynomialCategory| |SUEx|)
                   . #24=((CATEGORY |domain|
                           (SIGNATURE |outputForm|
                            ((|OutputForm|) $ (|OutputForm|)))))))
          (|SUEx| (|Join| (|UnivariatePolynomialCategory| |extField|) . #24#)))
         (SEQ (LETT |SUEx| (|SparseUnivariatePolynomial| |extField|))
              (LETT TP (|SparseUnivariatePolynomial| |SUEx|))
              (LETT |mm|
                    (SPADCALL (|compiledLookupCheck| '|Zero| (LIST '$) TP)))
              (LETT |m1| |m|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |m1| (|spadConstant| $ 20) (QREFELT $ 67)))
                     (GO G191)))
                   (SEQ
                    (LETT |mm|
                          (SPADCALL |mm|
                                    (SPADCALL
                                     (SPADCALL
                                      (|compiledLookupCheck| '|coerce|
                                                             (LIST '$
                                                                   (|devaluate|
                                                                    (ELT $ 6)))
                                                             |extField|)
                                      (SPADCALL |m1| (QREFELT $ 25))
                                      (|compiledLookupCheck| '|map|
                                                             (LIST
                                                              (|devaluate|
                                                               |SUEx|)
                                                              (LIST '|Mapping|
                                                                    (|devaluate|
                                                                     |extField|)
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6)))
                                                              (LIST
                                                               '|SparseUnivariatePolynomial|
                                                               (|devaluate|
                                                                (ELT $ 6))))
                                                             (|UnivariatePolynomialCategoryFunctions2|
                                                              (ELT $ 6)
                                                              (|SparseUnivariatePolynomial|
                                                               (ELT $ 6))
                                                              |extField|
                                                              |SUEx|)))
                                     (SPADCALL |m1| (QREFELT $ 24))
                                     (|compiledLookupCheck| '|monomial|
                                                            (LIST '$
                                                                  (|devaluate|
                                                                   |SUEx|)
                                                                  (LIST
                                                                   '|NonNegativeInteger|))
                                                            TP))
                                    (|compiledLookupCheck| '+ (LIST '$ '$ '$)
                                                           TP)))
                    (EXIT (LETT |m1| (SPADCALL |m1| (QREFELT $ 68)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |res1|
                    (SPADCALL |mm| |dx| NIL
                              (|compiledLookupCheck| '|doFactor|
                                                     (LIST
                                                      (LIST '|Factored|
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (LIST
                                                              '|SparseUnivariatePolynomial|
                                                              (|devaluate|
                                                               |extField|))))
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (LIST
                                                        '|SparseUnivariatePolynomial|
                                                        (|devaluate|
                                                         |extField|)))
                                                      (LIST '|Integer|)
                                                      (LIST '|Boolean|))
                                                     (|TwoFactorize|
                                                      |extField|))))
              (LETT |flist|
                    (SPADCALL |res1|
                              (|compiledLookupCheck| '|factorList|
                                                     (LIST
                                                      (LIST '|List|
                                                            (LIST '|Record|
                                                                  (LIST '|:|
                                                                        '|flag|
                                                                        (LIST
                                                                         '|Union|
                                                                         '#20#
                                                                         '#21#
                                                                         '#22#
                                                                         '#23#))
                                                                  (LIST '|:|
                                                                        '|factor|
                                                                        (LIST
                                                                         '|SparseUnivariatePolynomial|
                                                                         (LIST
                                                                          '|SparseUnivariatePolynomial|
                                                                          (|devaluate|
                                                                           |extField|))))
                                                                  (LIST '|:|
                                                                        '|exponent|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))))
                                                      '$)
                                                     (|Factored|
                                                      (|SparseUnivariatePolynomial|
                                                       (|SparseUnivariatePolynomial|
                                                        |extField|))))))
              (EXIT
               (COND
                ((EQL (LENGTH |flist|) 1)
                 (COND
                  ((SPADCALL (QVELT (|SPADfirst| |flist|) 0) (CONS 3 "prime")
                             (QREFELT $ 69))
                   (SPADCALL |m| 1 (QREFELT $ 70)))
                  (#25='T (SPADCALL |m| 1 (QREFELT $ 71)))))
                (#25#
                 (SEQ
                  (LETT |Normp|
                        (|NormRetractPackage| (QREFELT $ 6) |extField| |SUEx|
                                              TP |n|))
                  (LETT |lfacth|
                        (PROGN
                         (LETT #19# NIL)
                         (SEQ (LETT |fac| NIL) (LETT #18# |flist|) G190
                              (COND
                               ((OR (ATOM #18#)
                                    (PROGN (LETT |fac| (CAR #18#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT (LETT #19# (CONS (QVELT |fac| 1) #19#))))
                              (LETT #18# (CDR #18#)) (GO G190) G191
                              (EXIT (NREVERSE #19#)))))
                  (LETT |lfactk| NIL)
                  (SEQ G190 (COND ((NULL (NULL (NULL |lfacth|))) (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |ff| (|SPADfirst| |lfacth|))
                              (LETT |lfacth| (CDR |lfacth|))
                              (COND
                               ((SPADCALL
                                 (LETT |c|
                                       (SPADCALL
                                        (SPADCALL |ff|
                                                  (|compiledLookupCheck|
                                                   '|leadingCoefficient|
                                                   (LIST
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (|devaluate| |extField|))
                                                    '$)
                                                   (|SparseUnivariatePolynomial|
                                                    (|SparseUnivariatePolynomial|
                                                     |extField|))))
                                        (|compiledLookupCheck|
                                         '|leadingCoefficient|
                                         (LIST (|devaluate| |extField|) '$)
                                         |SUEx|)))
                                 (SPADCALL
                                  (|compiledLookupCheck| '|One| (LIST '$)
                                                         |extField|))
                                 (|compiledLookupCheck| '~=
                                                        (LIST (LIST '|Boolean|)
                                                              '$ '$)
                                                        |extField|))
                                (LETT |ff|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |c|
                                                  (|compiledLookupCheck| '|inv|
                                                                         (LIST
                                                                          '$
                                                                          '$)
                                                                         |extField|))
                                        (|compiledLookupCheck| '|coerce|
                                                               (LIST '$
                                                                     (|devaluate|
                                                                      |extField|))
                                                               |SUEx|))
                                       |ff|
                                       (|compiledLookupCheck| '*
                                                              (LIST '$
                                                                    (|devaluate|
                                                                     |SUEx|)
                                                                    '$)
                                                              TP)))))
                              (SEQ
                               (LETT |ffu|
                                     (SPADCALL |ff|
                                               (|compiledLookupCheck|
                                                '|retractIfCan|
                                                (LIST
                                                 (LIST '|Union|
                                                       (LIST
                                                        '|SparseUnivariatePolynomial|
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (|devaluate|
                                                          (ELT $ 6))))
                                                       '#17#)
                                                 (|devaluate| TP))
                                                |Normp|)))
                               (EXIT
                                (COND
                                 ((NULL (QEQCAR |ffu| 1))
                                  (PROGN
                                   (LETT #16#
                                         (LETT |lfactk|
                                               (CONS (QCDR |ffu|) |lfactk|)))
                                   (GO #26=#:G837))))))
                              (LETT |normfacs|
                                    (SPADCALL |ff|
                                              (|compiledLookupCheck|
                                               '|normFactors|
                                               (LIST
                                                (LIST '|List| (|devaluate| TP))
                                                (|devaluate| TP))
                                               |Normp|)))
                              (LETT |lfacth|
                                    (PROGN
                                     (LETT #15# NIL)
                                     (SEQ (LETT |g| NIL) (LETT #14# |lfacth|)
                                          G190
                                          (COND
                                           ((OR (ATOM #14#)
                                                (PROGN
                                                 (LETT |g| (CAR #14#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (COND
                                             ((NULL
                                               (SPADCALL |g| |normfacs|
                                                         (|compiledLookupCheck|
                                                          '|member?|
                                                          (LIST
                                                           (LIST '|Boolean|)
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (|devaluate|
                                                              |extField|)))
                                                           '$)
                                                          (|List|
                                                           (|SparseUnivariatePolynomial|
                                                            (|SparseUnivariatePolynomial|
                                                             |extField|))))))
                                              (LETT #15# (CONS |g| #15#))))))
                                          (LETT #14# (CDR #14#)) (GO G190) G191
                                          (EXIT (NREVERSE #15#)))))
                              (LETT |ffn|
                                    (PROGN
                                     (LETT #8# NIL)
                                     (SEQ (LETT #12# NIL)
                                          (LETT #11# |normfacs|) G190
                                          (COND
                                           ((OR (ATOM #11#)
                                                (PROGN
                                                 (LETT #12# (CAR #11#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (PROGN
                                             (LETT #10# #12#)
                                             (COND
                                              (#8#
                                               (LETT #9#
                                                     (SPADCALL #9# #10#
                                                               (|compiledLookupCheck|
                                                                '*
                                                                (LIST '$ '$ '$)
                                                                TP))))
                                              ('T
                                               (PROGN
                                                (LETT #9# #10#)
                                                (LETT #8# 'T)))))))
                                          (LETT #11# (CDR #11#)) (GO G190) G191
                                          (EXIT NIL))
                                     (COND (#8# #9#)
                                           ('T
                                            (SPADCALL
                                             (|compiledLookupCheck| '|One|
                                                                    (LIST '$)
                                                                    TP))))))
                              (EXIT
                               (LETT |lfactk|
                                     (CONS
                                      (PROG2
                                          (LETT #7#
                                                (SPADCALL |ffn|
                                                          (|compiledLookupCheck|
                                                           '|retractIfCan|
                                                           (LIST
                                                            (LIST '|Union|
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (LIST
                                                                    '|SparseUnivariatePolynomial|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                                  '#17#)
                                                            (|devaluate| TP))
                                                           |Normp|)))
                                          (QCDR #7#)
                                        (|check_union2| (QEQCAR #7# 0)
                                                        (|SparseUnivariatePolynomial|
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 6)))
                                                        (|Union|
                                                         (|SparseUnivariatePolynomial|
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 6)))
                                                         #17#)
                                                        #7#))
                                      |lfactk|)))))
                        #26# (EXIT #16#))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |ff1| NIL) (LETT #6# |lfactk|) G190
                         (COND
                          ((OR (ATOM #6#) (PROGN (LETT |ff1| (CAR #6#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (PROGN
                            (LETT #5# (SPADCALL |ff1| 1 (QREFELT $ 70)))
                            (COND
                             (#2# (LETT #3# (SPADCALL #3# #5# (QREFELT $ 72))))
                             ('T (PROGN (LETT #3# #5#) (LETT #2# 'T)))))))
                         (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                    (COND (#2# #3#) (#25# (|spadConstant| $ 73)))))))))))) 

(SDEFUN |TWOFACT;doExtension|
        ((|m| (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         (|dx| (|Integer|))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#1=#:G863 NIL) (#2=#:G864 NIL)
          (|res1|
           (|Factored|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (|nsize| (|NonNegativeInteger|)) (#3=#:G865 NIL) (|n| NIL)
          (|ln| (|List| (|PositiveInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |ln| (LIST 2 3 5 7 9 11 13 17 19 23 29))
                (SEQ (LETT |n| NIL) (LETT #3# |ln|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |n| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |nsize| (EXPT (SPADCALL (QREFELT $ 50)) |n|))
                            (LETT |res1|
                                  (COND
                                   ((< |nsize| 1000)
                                    (|TWOFACT;doExtension1| |m| |n| |dx|
                                     (|FiniteFieldCyclicGroupExtension|
                                      (QREFELT $ 6) |n|)
                                     $))
                                   ('T
                                    (|TWOFACT;doExtension1| |m| |n| |dx|
                                     (|FiniteFieldExtension| (QREFELT $ 6) |n|)
                                     $))))
                            (EXIT
                             (COND
                              ((SPADCALL
                                (QVELT
                                 (|SPADfirst| (SPADCALL |res1| (QREFELT $ 43)))
                                 0)
                                (CONS 3 "prime") (QREFELT $ 69))
                               (PROGN
                                (LETT #1#
                                      (PROGN (LETT #2# |res1|) (GO #4=#:G862)))
                                (GO #5=#:G859)))))))
                      #5# (EXIT #1#))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT (|error| "doExtension : Impossible"))))
          #4# (EXIT #2#)))) 

(SDEFUN |TWOFACT;doFactor;SupIBF;8|
        ((|m| (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
         (|dx| (|Integer|)) (|do_ext| (|Boolean|))
         ($
          (|Factored|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#1=#:G884 NIL)
          (#2=#:G883
           #3=(|Factored|
               (|SparseUnivariatePolynomial|
                (|SparseUnivariatePolynomial| F))))
          (#4=#:G885 #3#) (#5=#:G893 NIL) (|ff1| NIL)
          (|lfactk|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (|ff|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (|c| (F))
          (|lfacth|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (|dx1| (|PositiveInteger|)) (#6=#:G877 NIL)
          (|lfact|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (#7=#:G892 NIL) (|lf| NIL) (#8=#:G891 NIL)
          (|lfact1|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|fumv| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|prime| (|SparseUnivariatePolynomial| F)) (#9=#:G890 NIL)
          (|look| (|Boolean|)) (|umv| (|SparseUnivariatePolynomial| F))
          (|val| (F)) (|i| (|Integer|)) (|use_random| (|Boolean|))
          (|lcm| (|SparseUnivariatePolynomial| F)) (|try_max| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |look| 'T)
                (LETT |try_max| (MIN (+ |dx| 5) (SPADCALL (QREFELT $ 50))))
                (LETT |i| 0) (LETT |lcm| (SPADCALL |m| (QREFELT $ 25)))
                (LETT |use_random|
                      (< (* 2 |try_max|) (SPADCALL (QREFELT $ 50))))
                (SEQ G190
                     (COND
                      ((NULL (COND (|look| (< |i| |try_max|)) ('T NIL)))
                       (GO G191)))
                     (SEQ (LETT |i| (+ |i| 1))
                          (COND
                           (|use_random|
                            (LETT |val| (SPADCALL (QREFELT $ 74))))
                           ('T (LETT |val| (SPADCALL |i| (QREFELT $ 76)))))
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |lcm| |val| (QREFELT $ 77))
                                       (QREFELT $ 78))
                             "next value")
                            ('T
                             (SEQ
                              (LETT |umv|
                                    (SPADCALL
                                     (CONS #'|TWOFACT;doFactor;SupIBF;8!0|
                                           (VECTOR $ |val|))
                                     |m| (QREFELT $ 81)))
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (SPADCALL
                                   (SPADCALL |umv|
                                             (SPADCALL |umv| (QREFELT $ 46))
                                             (QREFELT $ 82))
                                   (QREFELT $ 39))
                                  0 (QREFELT $ 83))
                                 "next val")
                                ('T (LETT |look| NIL)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 (|look|
                  (COND
                   ((NULL |do_ext|)
                    (EXIT
                     (PROGN
                      (LETT #9# (SPADCALL |m| 1 (QREFELT $ 71)))
                      (GO #10=#:G889)))))))
                (EXIT
                 (COND (|look| (|TWOFACT;doExtension| |m| |dx| $))
                       (#11='T
                        (SEQ
                         (LETT |prime|
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 63) 1
                                          (QREFELT $ 84))
                                (SPADCALL |val| 0 (QREFELT $ 84))
                                (QREFELT $ 85)))
                         (LETT |fumv| (SPADCALL |umv| (QREFELT $ 28)))
                         (LETT |lfact1| (SPADCALL |fumv| (QREFELT $ 34)))
                         (EXIT
                          (COND
                           ((EQL (LENGTH |lfact1|) 1)
                            (SPADCALL |m| 1 (QREFELT $ 70)))
                           (#11#
                            (SEQ
                             (LETT |lfact|
                                   (PROGN
                                    (LETT #8# NIL)
                                    (SEQ (LETT |lf| NIL) (LETT #7# |lfact1|)
                                         G190
                                         (COND
                                          ((OR (ATOM #7#)
                                               (PROGN
                                                (LETT |lf| (CAR #7#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #8#
                                                 (CONS
                                                  (SPADCALL (ELT $ 86)
                                                            (QVELT |lf| 1)
                                                            (QREFELT $ 89))
                                                  #8#))))
                                         (LETT #7# (CDR #7#)) (GO G190) G191
                                         (EXIT (NREVERSE #8#)))))
                             (LETT |lfact|
                                   (CONS
                                    (SPADCALL (ELT $ 86)
                                              (SPADCALL |fumv| (QREFELT $ 29))
                                              (QREFELT $ 89))
                                    |lfact|))
                             (LETT |dx1|
                                   (PROG1 (LETT #6# (+ |dx| 1))
                                     (|check_subtype2| (> #6# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #6#)))
                             (LETT |lfacth|
                                   (SPADCALL |m| |lfact| |prime| |dx1|
                                             (QREFELT $ 92)))
                             (LETT |lfactk| NIL)
                             (SEQ G190
                                  (COND
                                   ((NULL (NULL (NULL |lfacth|))) (GO G191)))
                                  (SEQ (LETT |ff| (|SPADfirst| |lfacth|))
                                       (LETT |lfacth| (CDR |lfacth|))
                                       (COND
                                        ((SPADCALL
                                          (LETT |c|
                                                (SPADCALL
                                                 (SPADCALL |ff| (QREFELT $ 25))
                                                 (QREFELT $ 93)))
                                          (|spadConstant| $ 63) (QREFELT $ 94))
                                         (LETT |ff|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |c| (QREFELT $ 95))
                                                 (QREFELT $ 86))
                                                |ff| (QREFELT $ 96)))))
                                       (EXIT
                                        (LETT |lfactk| (CONS |ff| |lfactk|))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT
                              (PROGN
                               (LETT #1# NIL)
                               (SEQ (LETT |ff1| NIL) (LETT #5# |lfactk|) G190
                                    (COND
                                     ((OR (ATOM #5#)
                                          (PROGN (LETT |ff1| (CAR #5#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #4#
                                             (SPADCALL |ff1| 1 (QREFELT $ 70)))
                                       (COND
                                        (#1#
                                         (LETT #2#
                                               (SPADCALL #2# #4#
                                                         (QREFELT $ 72))))
                                        ('T
                                         (PROGN
                                          (LETT #2# #4#)
                                          (LETT #1# 'T)))))))
                                    (LETT #5# (CDR #5#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#1# #2#)
                                     (#11# (|spadConstant| $ 73)))))))))))))))
          #10# (EXIT #9#)))) 

(SDEFUN |TWOFACT;doFactor;SupIBF;8!0| ((|x| NIL) ($$ NIL))
        (PROG (|val| $)
          (LETT |val| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |val| (QREFELT $ 77)))))) 

(DECLAIM (NOTINLINE |TwoFactorize;|)) 

(DEFUN |TwoFactorize| (#1=#:G894)
  (SPROG NIL
         (PROG (#2=#:G895)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TwoFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|TwoFactorize;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|TwoFactorize|)))))))))) 

(DEFUN |TwoFactorize;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TwoFactorize| DV$1))
          (LETT $ (GETREFV 97))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TwoFactorize| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TwoFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              (0 . ^) (|Mapping| 6 6) (|SparseUnivariatePolynomial| 6)
              (6 . |map|) (|Union| $ '"failed") (12 . |divideExponents|)
              (|Factored| 15) (|SparseUnivariatePolynomial| 10)
              |TWOFACT;tryTwoFactor;SupF;2| |TWOFACT;generalTwoFactor;SupF;3|
              (18 . |Zero|) (22 . |Zero|) (26 . |Zero|) (|Boolean|) (30 . =)
              (36 . |Zero|) (40 . |degree|) (45 . |leadingCoefficient|)
              (|Factored| 10) (|DistinctDegreeFactorize| 6 10) (50 . |factor|)
              (55 . |unit|) (60 . |coerce|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 31) (|:| |factor| 10) (|:| |exponent| 7))
              (|List| 32) (65 . |factorList|)
              (|Record| (|:| |flag| 31) (|:| |factor| 15) (|:| |exponent| 7))
              (|List| 35) (70 . |makeFR|) (76 . |content|) (81 . |degree|)
              (86 . |exquo|) (|Factored| $) (92 . |squareFree|)
              (97 . |factorList|) (102 . |differentiate|)
              (107 . |differentiate|) (112 . |differentiate|) (|Mapping| 10 10)
              (117 . |map|) (123 . |characteristic|) (127 . |size|)
              (131 . |exquo|) (137 . |divideExponents|) (143 . |unit|)
              (148 . ^) (154 . *) (160 . |append|)
              (|CommuteUnivariatePolynomialCategory| 6 10 15) (166 . |swap|)
              (|List| 10) (171 . |coefficients|) (|Integer|)
              |TWOFACT;doFactor;SupIBF;8| (176 . |One|) (180 . |One|)
              (184 . |elt|) |TWOFACT;twoFactor;SupIF;5| (190 . ~=)
              (196 . |reductum|) (201 . =) (207 . |primeFactor|)
              (213 . |nilFactor|) (219 . *) (225 . |One|) (229 . |random|)
              (|PositiveInteger|) (233 . |index|) (238 . |elt|) (244 . |zero?|)
              (|Mapping| 6 10)
              (|UnivariatePolynomialCategoryFunctions2| 10 15 6 10)
              (249 . |map|) (255 . |gcd|) (261 . ~=) (267 . |monomial|)
              (273 . -) (279 . |coerce|) (|Mapping| 10 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 10 10 15)
              (284 . |map|) (|List| 15) (|GeneralHenselPackage| 10 15)
              (290 . |completeHensel|) (298 . |leadingCoefficient|) (303 . ~=)
              (309 . |inv|) (314 . *))
           '#(|twoFactor| 320 |tryTwoFactor| 326 |generalTwoFactor| 331
              |doFactor| 336)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|generalTwoFactor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|SparseUnivariatePolynomial|
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T)
                              '((|tryTwoFactor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|SparseUnivariatePolynomial|
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T)
                              '((|twoFactor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|SparseUnivariatePolynomial|
                                   (|SparseUnivariatePolynomial| |#1|))
                                  (|Integer|)))
                                T)
                              '((|doFactor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial|
                                    (|SparseUnivariatePolynomial| |#1|)))
                                  (|SparseUnivariatePolynomial|
                                   (|SparseUnivariatePolynomial| |#1|))
                                  (|Integer|) (|Boolean|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 96
                                            '(2 6 0 0 7 8 2 10 0 9 0 11 2 10 12
                                              0 7 13 0 6 0 18 0 10 0 19 0 15 0
                                              20 2 15 21 0 0 22 0 14 0 23 1 15
                                              7 0 24 1 15 10 0 25 1 27 26 10 28
                                              1 26 10 0 29 1 15 0 10 30 1 26 33
                                              0 34 2 14 0 15 36 37 1 15 10 0 38
                                              1 10 7 0 39 2 15 12 0 10 40 1 15
                                              41 0 42 1 14 36 0 43 1 15 0 0 44
                                              1 6 0 0 45 1 10 0 0 46 2 15 0 47
                                              0 48 0 6 7 49 0 6 7 50 2 7 12 0 0
                                              51 2 15 12 0 7 52 1 14 15 0 53 2
                                              15 0 0 7 54 2 15 0 0 0 55 2 36 0
                                              0 0 56 1 57 15 15 58 1 15 59 0 60
                                              0 6 0 63 0 10 0 64 2 36 35 0 61
                                              65 2 15 21 0 0 67 1 15 0 0 68 2
                                              31 21 0 0 69 2 14 0 15 7 70 2 14
                                              0 15 7 71 2 14 0 0 0 72 0 14 0 73
                                              0 6 0 74 1 6 0 75 76 2 10 6 0 6
                                              77 1 6 21 0 78 2 80 10 79 15 81 2
                                              10 0 0 0 82 2 7 21 0 0 83 2 10 0
                                              6 7 84 2 10 0 0 0 85 1 10 0 6 86
                                              2 88 15 87 10 89 4 91 90 15 90 10
                                              75 92 1 10 6 0 93 2 6 21 0 0 94 1
                                              6 0 0 95 2 15 0 10 0 96 2 0 14 15
                                              61 66 1 0 14 15 16 1 0 14 15 17 3
                                              0 14 15 61 21 62)))))
           '|lookupComplete|)) 
