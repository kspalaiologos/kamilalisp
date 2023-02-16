
(SDEFUN |SOLVETRA;solve;EL;1|
        ((|oside| (|Expression| R)) ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG ((|lv| (|List| (|Symbol|))))
               (SEQ
                (COND
                 ((SPADCALL |oside| (QREFELT $ 9))
                  (|error| "equation is always satisfied"))
                 (#1='T
                  (SEQ (LETT |lv| (SPADCALL |oside| (QREFELT $ 11)))
                       (EXIT
                        (COND ((NULL |lv|) (|error| "inconsistent equation"))
                              ((> (LENGTH |lv|) 1)
                               (|error| "too many variables"))
                              (#1#
                               (SPADCALL |oside| (|SPADfirst| |lv|)
                                         (QREFELT $ 15))))))))))) 

(SDEFUN |SOLVETRA;solve;EL;2|
        ((|equ| (|Equation| (|Expression| R)))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPADCALL
         (SPADCALL (SPADCALL |equ| (QREFELT $ 18))
                   (SPADCALL |equ| (QREFELT $ 19)) (QREFELT $ 20))
         (QREFELT $ 16))) 

(SDEFUN |SOLVETRA;solve;ESL;3|
        ((|equ| (|Equation| (|Expression| R))) (|x| (|Symbol|))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG ((|oneside| (|Expression| R)))
               (SEQ
                (LETT |oneside|
                      (SPADCALL (SPADCALL |equ| (QREFELT $ 18))
                                (SPADCALL |equ| (QREFELT $ 19))
                                (QREFELT $ 20)))
                (EXIT (SPADCALL |oneside| |x| (QREFELT $ 15)))))) 

(SDEFUN |SOLVETRA;testZero?|
        ((|lside| (|Expression| R)) (|sol| (|Equation| (|Expression| R)))
         ($ (|Boolean|)))
        (SEQ
         (COND
          ((|HasCategory| (QREFELT $ 6)
                          (LIST '|QuotientFieldCategory| '(|Integer|)))
           (COND
            ((QEQCAR (SPADCALL (SPADCALL |sol| (QREFELT $ 19)) (QREFELT $ 24))
                     1)
             (EXIT 'T))))
          ((QEQCAR (SPADCALL (SPADCALL |sol| (QREFELT $ 19)) (QREFELT $ 26)) 1)
           (EXIT 'T)))
         (EXIT
          (COND
           ((SPADCALL
             (SPADCALL (SPADCALL |lside| |sol| (QREFELT $ 28)) (QREFELT $ 30))
             (QREFELT $ 9))
            'T)
           ('T NIL))))) 

(SDEFUN |SOLVETRA;solve;ESL;5|
        ((|lside| (|Expression| R)) (|x| (|Symbol|))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG ((#1=#:G815 NIL) (|sol| NIL) (#2=#:G814 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |sol| NIL)
                      (LETT #1# (|SOLVETRA;solveInner| |lside| |x| $)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |sol| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((|SOLVETRA;testZero?| |lside| |sol| $)
                          (LETT #2# (CONS |sol| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SOLVETRA;solveInner|
        ((|lside| (|Expression| R)) (|x| (|Symbol|))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG
         ((#1=#:G876 NIL) (|sols| (|List| (|Equation| (|Expression| R))))
          (#2=#:G883 NIL) (|frec| NIL)
          (|lfacts|
           (|List|
            (|Record|
             (|:| |flag| (|Union| #3="nil" #4="sqfr" #5="irred" #6="prime"))
             (|:| |factor|
                  (|SparseMultivariatePolynomial| R
                                                  (|Kernel| (|Expression| R))))
             (|:| |exponent| (|NonNegativeInteger|)))))
          (|listofkernels| #7=(|List| (|Expression| R)))
          (|newlside| (|Expression| R))
          (|newlist| (|List| (|Equation| (|Expression| R)))) (#8=#:G882 NIL)
          (|j| NIL) (|secondsol| #9=(|List| (|Expression| R))) (#10=#:G860 NIL)
          (#11=#:G859 #9#) (#12=#:G861 #9#) (#13=#:G881 NIL) (|ff| NIL)
          (|lfatt|
           (|List|
            (|Record| (|:| |flag| (|Union| #3# #4# #5# #6#))
                      (|:| |factor|
                           (|SparseUnivariatePolynomial| (|Expression| R)))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
          (|elR| (|Expression| R)) (#14=#:G880 NIL) (|i| NIL) (#15=#:G851 NIL)
          (#16=#:G850 #17=(|List| (|Equation| (|Expression| R))))
          (#18=#:G852 #17#) (#19=#:G879 NIL) (|ri| NIL)
          (|bigX_back| (|Expression| R)) (#20=#:G846 NIL)
          (|r1| (|List| (|Expression| R)))
          (|finv| (|Union| (|Expression| R) #21="failed")) (#22=#:G878 NIL)
          (|lr| #9#) (#23=#:G834 NIL) (#24=#:G833 #9#) (#25=#:G835 #9#)
          (#26=#:G877 NIL) (|fatt| NIL) (|eq1| (|Expression| R))
          (|bigX| (|Expression| R)) (X (|Symbol|)) (|ausgabe1| #7#))
         (SEQ
          (EXIT
           (SEQ (LETT |lside| (|SOLVETRA;eliminateRoot| |lside| |x| $))
                (LETT |ausgabe1| (|SOLVETRA;tableXkernels| |lside| |x| $))
                (LETT X (SPADCALL (QREFELT $ 31)))
                (EXIT
                 (COND
                  ((EQL (LENGTH |ausgabe1|) 1)
                   (SEQ (LETT |bigX| (|SPADfirst| |ausgabe1|))
                        (LETT |eq1|
                              (SPADCALL |lside|
                                        (SPADCALL |bigX|
                                                  (SPADCALL X (QREFELT $ 32))
                                                  (QREFELT $ 33))
                                        (QREFELT $ 28)))
                        (LETT |f|
                              (SPADCALL |eq1| (SPADCALL X (QREFELT $ 36))
                                        (QREFELT $ 39)))
                        (LETT |lfatt|
                              (SPADCALL
                               (SPADCALL (SPADCALL |f| (QREFELT $ 42))
                                         (QREFELT $ 45))
                               (QREFELT $ 49)))
                        (LETT |lr|
                              (PROGN
                               (LETT #23# NIL)
                               (SEQ (LETT |fatt| NIL) (LETT #26# |lfatt|) G190
                                    (COND
                                     ((OR (ATOM #26#)
                                          (PROGN (LETT |fatt| (CAR #26#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #25#
                                             (SPADCALL (QVELT |fatt| 1) |x|
                                                       (QREFELT $ 52)))
                                       (COND
                                        (#23#
                                         (LETT #24#
                                               (SPADCALL #24# #25#
                                                         (QREFELT $ 54))))
                                        ('T
                                         (PROGN
                                          (LETT #24# #25#)
                                          (LETT #23# 'T)))))))
                                    (LETT #26# (CDR #26#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#23# #24#) (#27='T NIL))))
                        (LETT |r1| NIL)
                        (SEQ (LETT |i| 1) (LETT #22# (LENGTH |lr|)) G190
                             (COND ((|greater_SI| |i| #22#) (GO G191)))
                             (SEQ
                              (LETT |finv|
                                    (|SOLVETRA;funcinv| |bigX|
                                     (SPADCALL |lr| |i| (QREFELT $ 56)) $))
                              (EXIT
                               (COND
                                ((QEQCAR |finv| 0)
                                 (LETT |r1| (CONS (QCDR |finv|) |r1|))))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |bigX_back|
                              (PROG2
                                  (LETT #20#
                                        (|SOLVETRA;funcinv| |bigX| |bigX| $))
                                  (QCDR #20#)
                                (|check_union2| (QEQCAR #20# 0)
                                                (|Expression| (QREFELT $ 6))
                                                (|Union|
                                                 (|Expression| (QREFELT $ 6))
                                                 #21#)
                                                #20#)))
                        (COND
                         ((NULL (|SOLVETRA;testkernel| |bigX_back| |x| $))
                          (SEQ
                           (COND
                            ((SPADCALL |bigX| |bigX_back| (QREFELT $ 34))
                             (PROGN (LETT #1# NIL) (GO #28=#:G875))))
                           (EXIT
                            (PROGN
                             (LETT #1#
                                   (PROGN
                                    (LETT #15# NIL)
                                    (SEQ (LETT |ri| NIL) (LETT #19# |r1|) G190
                                         (COND
                                          ((OR (ATOM #19#)
                                               (PROGN
                                                (LETT |ri| (CAR #19#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (PROGN
                                            (LETT #18#
                                                  (SPADCALL
                                                   (SPADCALL |bigX_back| |ri|
                                                             (QREFELT $ 20))
                                                   |x| (QREFELT $ 15)))
                                            (COND
                                             (#15#
                                              (LETT #16#
                                                    (SPADCALL #16# #18#
                                                              (QREFELT $ 57))))
                                             ('T
                                              (PROGN
                                               (LETT #16# #18#)
                                               (LETT #15# 'T)))))))
                                         (LETT #19# (CDR #19#)) (GO G190) G191
                                         (EXIT NIL))
                                    (COND (#15# #16#) (#27# NIL))))
                             (GO #28#))))))
                        (LETT |newlist| NIL)
                        (SEQ (LETT |i| 1) (LETT #14# (LENGTH |r1|)) G190
                             (COND ((|greater_SI| |i| #14#) (GO G191)))
                             (SEQ
                              (LETT |elR|
                                    (|SOLVETRA;eliminateRoot|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |bigX_back|
                                                 (SPADCALL |r1| |i|
                                                           (QREFELT $ 56))
                                                 (QREFELT $ 20))
                                       (QREFELT $ 59))
                                      (QREFELT $ 60))
                                     |x| $))
                              (LETT |f|
                                    (SPADCALL |elR|
                                              (SPADCALL |x| (QREFELT $ 36))
                                              (QREFELT $ 39)))
                              (LETT |lfatt|
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |f| (QREFELT $ 42))
                                               (QREFELT $ 62))
                                     (QREFELT $ 49)))
                              (LETT |secondsol|
                                    (PROGN
                                     (LETT #10# NIL)
                                     (SEQ (LETT |ff| NIL) (LETT #13# |lfatt|)
                                          G190
                                          (COND
                                           ((OR (ATOM #13#)
                                                (PROGN
                                                 (LETT |ff| (CAR #13#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (PROGN
                                             (LETT #12#
                                                   (SPADCALL (QVELT |ff| 1) |x|
                                                             (QREFELT $ 52)))
                                             (COND
                                              (#10#
                                               (LETT #11#
                                                     (SPADCALL #11# #12#
                                                               (QREFELT $
                                                                        54))))
                                              ('T
                                               (PROGN
                                                (LETT #11# #12#)
                                                (LETT #10# 'T)))))))
                                          (LETT #13# (CDR #13#)) (GO G190) G191
                                          (EXIT NIL))
                                     (COND (#10# #11#) ('T NIL))))
                              (EXIT
                               (SEQ (LETT |j| 1)
                                    (LETT #8# (LENGTH |secondsol|)) G190
                                    (COND ((|greater_SI| |j| #8#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |newlist|
                                            (CONS
                                             (SPADCALL
                                              (SPADCALL |x| (QREFELT $ 32))
                                              (SPADCALL
                                               (SPADCALL |secondsol| |j|
                                                         (QREFELT $ 56))
                                               (QREFELT $ 64))
                                              (QREFELT $ 33))
                                             |newlist|))))
                                    (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT |newlist|)))
                  (#27#
                   (SEQ (LETT |newlside| (|SOLVETRA;tryToTrans| |lside| |x| $))
                        (LETT |listofkernels|
                              (|SOLVETRA;tableXkernels| |newlside| |x| $))
                        (EXIT
                         (COND
                          ((EQL (LENGTH |listofkernels|) 1)
                           (SPADCALL |newlside| |x| (QREFELT $ 15)))
                          (#27#
                           (SEQ
                            (LETT |lfacts|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |lside| (QREFELT $ 59))
                                             (QREFELT $ 68))
                                   (QREFELT $ 71)))
                            (EXIT
                             (COND
                              ((> (LENGTH |lfacts|) 1)
                               (SEQ (LETT |sols| NIL)
                                    (SEQ (LETT |frec| NIL) (LETT #2# |lfacts|)
                                         G190
                                         (COND
                                          ((OR (ATOM #2#)
                                               (PROGN
                                                (LETT |frec| (CAR #2#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT |sols|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL (QVELT |frec| 1)
                                                             (QREFELT $ 60))
                                                   |x| (QREFELT $ 15))
                                                  |sols| (QREFELT $ 57)))))
                                         (LETT #2# (CDR #2#)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT |sols|)))
                              (#27#
                               (PROGN (LETT #1# NIL) (GO #28#)))))))))))))))
          #28# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;simplifyingLog| ((|f| (|Expression| R)) ($ (|Expression| R)))
        (SPROG
         ((|rec|
           (|Record| (|:| |var| (|Kernel| (|Expression| R)))
                     (|:| |exponent| (|Integer|))))
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| (|Expression| R)))
                      (|:| |exponent| (|Integer|)))
            "failed")))
         (SEQ (LETT |u| (SPADCALL |f| '|exp| (QREFELT $ 74)))
              (EXIT
               (COND
                ((QEQCAR |u| 0)
                 (SEQ (LETT |rec| (QCDR |u|))
                      (EXIT
                       (SPADCALL (QCDR |rec|)
                                 (|SPADfirst|
                                  (SPADCALL (QCAR |rec|) (QREFELT $ 75)))
                                 (QREFELT $ 76)))))
                ('T (SPADCALL |f| (QREFELT $ 77)))))))) 

(SDEFUN |SOLVETRA;testkernel|
        ((|var1| (|Expression| R)) (|y| (|Symbol|)) ($ (|Boolean|)))
        (SPROG ((|listvar1| (|List| (|Expression| R))))
               (SEQ (LETT |var1| (|SOLVETRA;eliminateRoot| |var1| |y| $))
                    (LETT |listvar1| (|SOLVETRA;tableXkernels| |var1| |y| $))
                    (EXIT
                     (COND
                      ((EQL (LENGTH |listvar1|) 1)
                       (COND
                        ((OR
                          (SPADCALL (SPADCALL |listvar1| 1 (QREFELT $ 56))
                                    (SPADCALL |y| (QREFELT $ 32))
                                    (QREFELT $ 34))
                          (EQL (LENGTH |listvar1|) 0))
                         'T)
                        ('T NIL)))
                      ((EQL (LENGTH |listvar1|) 0) 'T) ('T NIL)))))) 

(SDEFUN |SOLVETRA;solveRetract|
        ((|lexpr| (|List| (|Expression| R))) (|lvar| (|List| (|Symbol|)))
         ($
          (|Union| (|List| (|List| (|Equation| (|Expression| R)))) "failed")))
        (SPROG
         ((|nlexpr| (|List| (|Fraction| (|Polynomial| R)))) (#1=#:G907 NIL)
          (|rf| (|Union| (|Fraction| (|Polynomial| R)) "failed"))
          (#2=#:G908 NIL) (|expr| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |nlexpr| NIL)
                (SEQ (LETT |expr| NIL) (LETT #2# |lexpr|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |expr| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |rf| (SPADCALL |expr| (QREFELT $ 81)))
                          (EXIT
                           (COND
                            ((QEQCAR |rf| 1)
                             (PROGN
                              (LETT #1# (CONS 1 "failed"))
                              (GO #3=#:G906)))
                            ('T (LETT |nlexpr| (CONS (QCDR |rf|) |nlexpr|))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (SPADCALL |nlexpr| |lvar| (QREFELT $ 85))))))
          #3# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;tryToTrans|
        ((|lside| (|Expression| R)) (|x| (|Symbol|)) ($ (|Expression| R)))
        (SPROG
         ((|resultLside| #1=(|Expression| R)) (|numlside| (|Expression| R))
          (|listcnorm| #2=(|List| (|Expression| R)))
          (|cnormConvLside| (|Expression| R)) (|listConvLside| #2#)
          (|NormConvLside| (|Expression| R)) (|convLside| #1#))
         (SEQ
          (COND
           ((OR (|SOLVETRA;testTrig| |lside| |x| $)
                (|SOLVETRA;testHTrig| |lside| |x| $))
            (SEQ (LETT |convLside| (SPADCALL |lside| (QREFELT $ 87)))
                 (LETT |resultLside| |convLside|)
                 (LETT |listConvLside|
                       (|SOLVETRA;tableXkernels| |convLside| |x| $))
                 (EXIT
                  (COND
                   ((> (LENGTH |listConvLside|) 1)
                    (SEQ
                     (LETT |NormConvLside|
                           (SPADCALL |convLside| |x| (QREFELT $ 88)))
                     (LETT |NormConvLside| |NormConvLside|)
                     (EXIT
                      (LETT |resultLside|
                            (|SOLVETRA;subsTan| |NormConvLside| |x| $)))))))))
           ((|SOLVETRA;testLog| |lside| |x| $)
            (SEQ
             (LETT |numlside|
                   (SPADCALL (SPADCALL |lside| (QREFELT $ 59)) (QREFELT $ 60)))
             (EXIT
              (LETT |resultLside| (|SOLVETRA;combineLog| |numlside| |x| $)))))
           ('T
            (SEQ (LETT |NormConvLside| (SPADCALL |lside| |x| (QREFELT $ 88)))
                 (LETT |NormConvLside| |NormConvLside|)
                 (LETT |resultLside| |NormConvLside|)
                 (LETT |listConvLside|
                       (|SOLVETRA;tableXkernels| |NormConvLside| |x| $))
                 (EXIT
                  (COND
                   ((> (LENGTH |listConvLside|) 1)
                    (SEQ
                     (LETT |cnormConvLside|
                           (SPADCALL |lside| |x| (QREFELT $ 90)))
                     (LETT |cnormConvLside| |cnormConvLside|)
                     (LETT |resultLside| |cnormConvLside|)
                     (LETT |listcnorm|
                           (|SOLVETRA;tableXkernels| |cnormConvLside| |x| $))
                     (EXIT
                      (COND
                       ((> (LENGTH |listcnorm|) 1)
                        (COND
                         ((|SOLVETRA;testLog| |cnormConvLside| |x| $)
                          (SEQ
                           (LETT |numlside|
                                 (SPADCALL
                                  (SPADCALL |cnormConvLside| (QREFELT $ 59))
                                  (QREFELT $ 60)))
                           (EXIT
                            (LETT |resultLside|
                                  (|SOLVETRA;combineLog| |numlside| |x|
                                   $))))))))))))))))
          (EXIT |resultLside|)))) 

(SDEFUN |SOLVETRA;subsTan|
        ((|exprvar| (|Expression| R)) (|y| (|Symbol|)) ($ (|Expression| R)))
        (SPROG
         ((#1=#:G928 NIL) (|resultnew| #2=(|Expression| R))
          (|result1| (|Expression| R))
          (|result|
           (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
          (|newH|
           #3=(|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
          (H (|Expression| R)) (|g| #3#) (|secondfun| (|Expression| R))
          (|f| #3#) (|fN| #4=(|Expression| R)) (|fZ| #2#) (|test| (|Boolean|))
          (Y #4#) (|varkern| (|Expression| R))
          (|listofkern| (|List| (|Expression| R))) (Z (|Symbol|)))
         (SEQ
          (EXIT
           (SEQ (LETT Z (SPADCALL (QREFELT $ 31)))
                (LETT |listofkern| (|SOLVETRA;tableXkernels| |exprvar| |y| $))
                (LETT |varkern| (|SPADfirst| |listofkern|))
                (LETT Y
                      (SPADCALL
                       (|SPADfirst|
                        (SPADCALL
                         (|SPADfirst| (SPADCALL |varkern| (QREFELT $ 92)))
                         (QREFELT $ 75)))
                       (QREFELT $ 93)))
                (LETT |test|
                      (SPADCALL |varkern|
                                (SPADCALL
                                 (SPADCALL Y (SPADCALL 2 (QREFELT $ 94))
                                           (QREFELT $ 95))
                                 (QREFELT $ 96))
                                (QREFELT $ 34)))
                (COND
                 ((EQL (LENGTH |listofkern|) 1)
                  (COND
                   ((NULL |test|)
                    (PROGN (LETT #1# |exprvar|) (GO #5=#:G927)))))
                 (#6='T (PROGN (LETT #1# |exprvar|) (GO #5#))))
                (LETT |fZ|
                      (SPADCALL |exprvar|
                                (SPADCALL |varkern| (SPADCALL Z (QREFELT $ 32))
                                          (QREFELT $ 33))
                                (QREFELT $ 28)))
                (LETT |fN| (SPADCALL |fZ| (QREFELT $ 93)))
                (LETT |f|
                      (SPADCALL |fN| (SPADCALL Z (QREFELT $ 36))
                                (QREFELT $ 39)))
                (LETT |secondfun|
                      (SPADCALL
                       (SPADCALL (SPADCALL 2 Y (QREFELT $ 98))
                                 (SPADCALL (SPADCALL Y 2 (QREFELT $ 99))
                                           (|spadConstant| $ 102)
                                           (QREFELT $ 20))
                                 (QREFELT $ 95))
                       (QREFELT $ 103)))
                (LETT |g|
                      (SPADCALL |secondfun| (SPADCALL |y| (QREFELT $ 36))
                                (QREFELT $ 39)))
                (LETT H (SPADCALL (SPADCALL (QREFELT $ 31)) (QREFELT $ 32)))
                (LETT |newH|
                      (SPADCALL H (SPADCALL Z (QREFELT $ 36)) (QREFELT $ 39)))
                (LETT |result| (SPADCALL |f| |g| |newH| (QREFELT $ 105)))
                (EXIT
                 (COND
                  ((SPADCALL |result| |f| (QREFELT $ 106))
                   (SEQ (LETT |result1| (SPADCALL |result| H (QREFELT $ 108)))
                        (EXIT
                         (LETT |resultnew|
                               (SPADCALL |result1|
                                         (SPADCALL H
                                                   (SPADCALL Y (QREFELT $ 96))
                                                   (QREFELT $ 33))
                                         (QREFELT $ 28))))))
                  (#6# (PROGN (LETT #1# |exprvar|) (GO #5#)))))))
          #5# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;eliminateKernRoot|
        ((|var| (|Expression| R)) (|varkern| (|Kernel| (|Expression| R)))
         ($ (|Expression| R)))
        (SPROG
         ((|resultvar| (|Expression| R))
          (|var3| (|SparseUnivariatePolynomial| (|Expression| R)))
          (#1=#:G939 NIL)
          (|var2| (|SparseUnivariatePolynomial| (|Expression| R)))
          (|var1| (|Expression| R)) (X (|Symbol|)))
         (SEQ (LETT X (SPADCALL (QREFELT $ 31)))
              (LETT |var1|
                    (SPADCALL |var|
                              (SPADCALL (SPADCALL |varkern| (QREFELT $ 109))
                                        (SPADCALL X (QREFELT $ 32))
                                        (QREFELT $ 33))
                              (QREFELT $ 28)))
              (LETT |var2|
                    (SPADCALL
                     (SPADCALL |var1| (SPADCALL X (QREFELT $ 36))
                               (QREFELT $ 39))
                     (QREFELT $ 42)))
              (LETT |var3|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 102)
                               (PROG1
                                   (LETT #1#
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |varkern| (QREFELT $ 75))
                                           (QREFELT $ 110))
                                          (QREFELT $ 111)))
                                 (|check_subtype2| (>= #1# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #1#))
                               (QREFELT $ 113))
                     (SPADCALL
                      (|SPADfirst| (SPADCALL |varkern| (QREFELT $ 75))) 0
                      (QREFELT $ 113))
                     (QREFELT $ 114)))
              (EXIT
               (LETT |resultvar| (SPADCALL |var2| |var3| (QREFELT $ 115))))))) 

(SDEFUN |SOLVETRA;eliminateRoot|
        ((|var| #1=(|Expression| R)) (|y| (|Symbol|)) ($ (|Expression| R)))
        (SPROG
         ((|var1| #1#) (#2=#:G950 NIL) (|i| NIL)
          (|varlistk1| (|List| (|Expression| R))))
         (SEQ (LETT |var1| |var|)
              (SEQ G190
                   (COND
                    ((NULL (|SOLVETRA;testRootk| |var1| |y| $)) (GO G191)))
                   (SEQ
                    (LETT |varlistk1| (|SOLVETRA;tableXkernels| |var1| |y| $))
                    (EXIT
                     (SEQ (LETT |i| NIL) (LETT #2# |varlistk1|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL |i| '|nthRoot| (QREFELT $ 116))
                              (LETT |var1|
                                    (|SOLVETRA;eliminateKernRoot| |var1|
                                     (|SPADfirst|
                                      (SPADCALL |i| (QREFELT $ 92)))
                                     $))))))
                          (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |var1|)))) 

(SDEFUN |SOLVETRA;logsumtolog| ((|var| (|Expression| R)) ($ (|Expression| R)))
        (SPROG
         ((|var2| (|Expression| R)) (#1=#:G967 NIL) (|i| NIL)
          (|kernelofvar| (|List| (|Kernel| (|Expression| R))))
          (|newexpr| (|Expression| R)) (|exprlist| (|List| (|Expression| R)))
          (#2=#:G966 NIL) (|gcdcoeff| (|Expression| R))
          (|listforgcd| (|List| R)) (|exprcoeff| (R)) (#3=#:G965 NIL)
          (|listofexpr| (|Union| (|List| (|Expression| R)) "failed")))
         (SEQ (LETT |listofexpr| (SPADCALL |var| (QREFELT $ 118)))
              (EXIT
               (COND ((QEQCAR |listofexpr| 1) |var|)
                     ('T
                      (SEQ (LETT |listofexpr| (CONS 0 (QCDR |listofexpr|)))
                           (LETT |listforgcd| NIL)
                           (SEQ (LETT |i| NIL) (LETT #3# (QCDR |listofexpr|))
                                G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |i| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |exprcoeff|
                                       (SPADCALL (SPADCALL |i| (QREFELT $ 59))
                                                 (QREFELT $ 119)))
                                 (EXIT
                                  (LETT |listforgcd|
                                        (CONS |exprcoeff| |listforgcd|))))
                                (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                           (LETT |gcdcoeff|
                                 (SPADCALL
                                  (SPADCALL |listforgcd| (QREFELT $ 120))
                                  (QREFELT $ 121)))
                           (LETT |newexpr| (|spadConstant| $ 122))
                           (SEQ (LETT |i| NIL) (LETT #2# (QCDR |listofexpr|))
                                G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |i| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |exprlist| (|SOLVETRA;splitExpr| |i| $))
                                 (EXIT
                                  (LETT |newexpr|
                                        (SPADCALL |newexpr|
                                                  (|SOLVETRA;logexpp|
                                                   (SPADCALL |exprlist| 2
                                                             (QREFELT $ 56))
                                                   (SPADCALL
                                                    (SPADCALL |exprlist| 1
                                                              (QREFELT $ 56))
                                                    |gcdcoeff| (QREFELT $ 95))
                                                   $)
                                                  (QREFELT $ 123)))))
                                (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                           (LETT |kernelofvar|
                                 (SPADCALL |newexpr| (QREFELT $ 92)))
                           (LETT |var2| (|spadConstant| $ 102))
                           (SEQ (LETT |i| NIL) (LETT #1# |kernelofvar|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |i| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |var2|
                                        (SPADCALL |var2|
                                                  (|SPADfirst|
                                                   (SPADCALL |i|
                                                             (QREFELT $ 75)))
                                                  (QREFELT $ 124)))))
                                (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (SPADCALL |gcdcoeff|
                                      (SPADCALL |var2| (QREFELT $ 77))
                                      (QREFELT $ 124)))))))))) 

(SDEFUN |SOLVETRA;testLog|
        ((|expr| (|Expression| R)) (Z (|Symbol|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G975 NIL) (#2=#:G976 NIL) (|i| NIL)
          (|kernelofexpr| (|List| (|Expression| R)))
          (|testList| (|List| (|Symbol|))))
         (SEQ
          (EXIT
           (SEQ (LETT |testList| (LIST '|log|))
                (LETT |kernelofexpr| (|SOLVETRA;tableXkernels| |expr| Z $))
                (COND
                 ((EQL (LENGTH |kernelofexpr|) 0)
                  (PROGN (LETT #1# NIL) (GO #3=#:G974))))
                (SEQ (LETT |i| NIL) (LETT #2# |kernelofexpr|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL
                          (SPADCALL (|SPADfirst| (SPADCALL |i| (QREFELT $ 92)))
                                    (QREFELT $ 126))
                          |testList| (QREFELT $ 127))
                         (COND
                          ((NULL
                            (|SOLVETRA;testkernel|
                             (|SPADfirst|
                              (SPADCALL
                               (|SPADfirst| (SPADCALL |i| (QREFELT $ 92)))
                               (QREFELT $ 75)))
                             Z $))
                           (PROGN (LETT #1# NIL) (GO #3#)))))
                        ('T (PROGN (LETT #1# NIL) (GO #3#))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #3# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;splitExpr|
        ((|expr| #1=(|Expression| R)) ($ (|List| (|Expression| R))))
        (SPROG
         ((|listexpr| (|Union| (|List| (|Expression| R)) "failed"))
          (|exprwcoeff| #1#) (|lcoeff| (R)))
         (SEQ
          (LETT |lcoeff|
                (SPADCALL (SPADCALL |expr| (QREFELT $ 59)) (QREFELT $ 119)))
          (LETT |exprwcoeff| |expr|)
          (LETT |listexpr| (SPADCALL |exprwcoeff| (QREFELT $ 128)))
          (EXIT
           (COND ((QEQCAR |listexpr| 1) (LIST (|spadConstant| $ 102) |expr|))
                 ('T
                  (SEQ
                   (LETT |listexpr|
                         (CONS 0
                               (SPADCALL (SPADCALL |lcoeff| (QREFELT $ 121))
                                         (QCDR |listexpr|) (QREFELT $ 129))))
                   (EXIT
                    (CONS (SPADCALL |lcoeff| (QREFELT $ 121))
                          (QCDR |listexpr|)))))))))) 

(SDEFUN |SOLVETRA;buildnexpr|
        ((|expr| (|Expression| R)) (Z (|Symbol|))
         ($ (|List| (|Expression| R))))
        (SPROG
         ((|ansmant| (|Expression| R)) (|anscoeff| (|Expression| R))
          (#1=#:G992 NIL) (|i| NIL) (|n2list| (|List| (|Expression| R)))
          (|nlist| (|List| (|Expression| R))))
         (SEQ (LETT |nlist| (|SOLVETRA;splitExpr| |expr| $))
              (LETT |n2list|
                    (SPADCALL (SPADCALL |nlist| 1 (QREFELT $ 56)) |nlist|
                              (QREFELT $ 129)))
              (LETT |anscoeff| (|spadConstant| $ 102))
              (LETT |ansmant| (|spadConstant| $ 122))
              (SEQ (LETT |i| NIL) (LETT #1# |n2list|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |i| Z (QREFELT $ 131))
                       (LETT |anscoeff|
                             (SPADCALL |i| |anscoeff| (QREFELT $ 124))))
                      ('T (LETT |ansmant| |i|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (LIST |anscoeff|
                     (SPADCALL |ansmant| (SPADCALL |nlist| 1 (QREFELT $ 56))
                               (QREFELT $ 124))))))) 

(SDEFUN |SOLVETRA;logexpp|
        ((|expr1| (|Expression| R)) (|expr2| (|Expression| R))
         ($ (|Expression| R)))
        (SPADCALL
         (SPADCALL
          (|SPADfirst|
           (SPADCALL (|SPADfirst| (SPADCALL |expr1| (QREFELT $ 92)))
                     (QREFELT $ 75)))
          |expr2| (QREFELT $ 132))
         (QREFELT $ 77))) 

(SDEFUN |SOLVETRA;combineLog|
        ((|expr| (|Expression| R)) (Y (|Symbol|)) ($ (|Expression| R)))
        (SPROG
         ((|ansexpr| #1=(|Expression| R)) (#2=#:G1012 NIL) (|i| NIL)
          (|ans| #1#) (|exprr| (|List| (|Expression| R)))
          (|loopexpr| (|Expression| R))
          (|exprtable| (|Table| (|Expression| R) (|Expression| R))))
         (SEQ (LETT |exprtable| (SPADCALL (QREFELT $ 134)))
              (EXIT
               (COND ((QEQCAR (SPADCALL |expr| (QREFELT $ 118)) 1) |expr|)
                     ('T
                      (SEQ (LETT |ans| (|spadConstant| $ 122))
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (SPADCALL |expr| (|spadConstant| $ 122)
                                             (QREFELT $ 136)))
                                  (GO G191)))
                                (SEQ
                                 (LETT |loopexpr|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |expr| (QREFELT $ 59))
                                         (QREFELT $ 137))
                                        (QREFELT $ 60)))
                                 (COND
                                  ((|SOLVETRA;testLog| |loopexpr| Y $)
                                   (COND
                                    ((EQL
                                      (LENGTH
                                       (|SOLVETRA;tableXkernels| |loopexpr| Y
                                        $))
                                      1)
                                     (SEQ
                                      (LETT |exprr|
                                            (|SOLVETRA;buildnexpr| |loopexpr| Y
                                             $))
                                      (COND
                                       ((QEQCAR
                                         (SPADCALL
                                          (SPADCALL |exprr| 1 (QREFELT $ 56))
                                          |exprtable| (QREFELT $ 139))
                                         1)
                                        (SPADCALL |exprtable|
                                                  (SPADCALL |exprr| 1
                                                            (QREFELT $ 56))
                                                  (|spadConstant| $ 122)
                                                  (QREFELT $ 140))))
                                      (EXIT
                                       (SPADCALL |exprtable|
                                                 (SPADCALL |exprr| 1
                                                           (QREFELT $ 56))
                                                 (SPADCALL
                                                  (SPADCALL |exprtable|
                                                            (SPADCALL |exprr| 1
                                                                      (QREFELT
                                                                       $ 56))
                                                            (QREFELT $ 141))
                                                  (SPADCALL |exprr| 2
                                                            (QREFELT $ 56))
                                                  (QREFELT $ 123))
                                                 (QREFELT $ 140)))))
                                    ('T
                                     (LETT |ans|
                                           (SPADCALL |ans| |loopexpr|
                                                     (QREFELT $ 123))))))
                                  ('T
                                   (LETT |ans|
                                         (SPADCALL |ans| |loopexpr|
                                                   (QREFELT $ 123)))))
                                 (EXIT
                                  (LETT |expr|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |expr| (QREFELT $ 59))
                                          (QREFELT $ 142))
                                         (QREFELT $ 60)))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (LETT |ansexpr| (|spadConstant| $ 122))
                           (SEQ (LETT |i| NIL)
                                (LETT #2#
                                      (SPADCALL |exprtable| (QREFELT $ 143)))
                                G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |i| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |ansexpr|
                                        (SPADCALL |ansexpr|
                                                  (SPADCALL
                                                   (|SOLVETRA;logsumtolog|
                                                    (SPADCALL |exprtable| |i|
                                                              (QREFELT $ 141))
                                                    $)
                                                   |i| (QREFELT $ 124))
                                                  (QREFELT $ 123)))))
                                (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (LETT |ansexpr|
                                  (SPADCALL |ansexpr| |ans|
                                            (QREFELT $ 123))))))))))) 

(SDEFUN |SOLVETRA;testRootk|
        ((|varlistk| (|Expression| R)) (|y| (|Symbol|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1019 NIL) (#2=#:G1020 NIL) (|i| NIL)
          (|kernelofeqnvar| (|List| (|Expression| R))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |kernelofeqnvar| (|SOLVETRA;tableXkernels| |varlistk| |y| $))
            (EXIT
             (COND ((NULL |kernelofeqnvar|) NIL)
                   ('T
                    (SEQ
                     (SEQ (LETT |i| NIL) (LETT #2# |kernelofeqnvar|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL
                               (|SPADfirst| (SPADCALL |i| (QREFELT $ 92)))
                               '|nthRoot| (QREFELT $ 144))
                              (PROGN (LETT #1# 'T) (GO #3=#:G1018))))))
                          (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                     (EXIT NIL)))))))
          #3# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;tableXkernels|
        ((|evar| (|Expression| R)) (Z (|Symbol|))
         ($ (|List| (|Expression| R))))
        (SPROG
         ((|listkOfvar| (|List| (|Expression| R))) (#1=#:G1026 NIL) (|i| NIL)
          (|kOfvar| (|List| (|Kernel| (|Expression| R)))))
         (SEQ (LETT |kOfvar| (SPADCALL |evar| (QREFELT $ 92)))
              (LETT |listkOfvar| NIL)
              (SEQ (LETT |i| NIL) (LETT #1# |kOfvar|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |i| (QREFELT $ 109)) Z
                                  (QREFELT $ 131)))
                       (LETT |listkOfvar|
                             (CONS (SPADCALL |i| (QREFELT $ 109))
                                   |listkOfvar|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |listkOfvar|)))) 

(SDEFUN |SOLVETRA;testTrig|
        ((|eqnvar| (|Expression| R)) (Z (|Symbol|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1034 NIL) (#2=#:G1035 NIL) (|i| NIL)
          (|testList| (|List| (|Symbol|)))
          (|kernelofeqnvar| (|List| (|Expression| R))))
         (SEQ
          (EXIT
           (SEQ (LETT |kernelofeqnvar| (|SOLVETRA;tableXkernels| |eqnvar| Z $))
                (EXIT
                 (COND ((NULL |kernelofeqnvar|) NIL)
                       ('T
                        (SEQ
                         (LETT |testList|
                               (LIST '|sin| '|cos| '|tan| '|cot| '|sec|
                                     '|csc|))
                         (SEQ (LETT |i| NIL) (LETT #2# |kernelofeqnvar|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |i| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (SPADCALL
                                    (|SPADfirst| (SPADCALL |i| (QREFELT $ 92)))
                                    (QREFELT $ 126))
                                   |testList| (QREFELT $ 127))
                                  (COND
                                   ((NULL
                                     (|SOLVETRA;testkernel|
                                      (|SPADfirst|
                                       (SPADCALL
                                        (|SPADfirst|
                                         (SPADCALL |i| (QREFELT $ 92)))
                                        (QREFELT $ 75)))
                                      Z $))
                                    (PROGN (LETT #1# NIL) (GO #3=#:G1033)))))
                                 ('T (PROGN (LETT #1# NIL) (GO #3#))))))
                              (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                         (EXIT 'T)))))))
          #3# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;testHTrig|
        ((|eqnvar| (|Expression| R)) (Z (|Symbol|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1043 NIL) (#2=#:G1044 NIL) (|i| NIL)
          (|testList| (|List| (|Symbol|)))
          (|kernelofeqnvar| (|List| (|Expression| R))))
         (SEQ
          (EXIT
           (SEQ (LETT |kernelofeqnvar| (|SOLVETRA;tableXkernels| |eqnvar| Z $))
                (EXIT
                 (COND ((NULL |kernelofeqnvar|) NIL)
                       ('T
                        (SEQ
                         (LETT |testList|
                               (LIST '|sinh| '|cosh| '|tanh| '|coth| '|sech|
                                     '|csch|))
                         (SEQ (LETT |i| NIL) (LETT #2# |kernelofeqnvar|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |i| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (SPADCALL
                                    (|SPADfirst| (SPADCALL |i| (QREFELT $ 92)))
                                    (QREFELT $ 126))
                                   |testList| (QREFELT $ 127))
                                  (COND
                                   ((NULL
                                     (|SOLVETRA;testkernel|
                                      (|SPADfirst|
                                       (SPADCALL
                                        (|SPADfirst|
                                         (SPADCALL |i| (QREFELT $ 92)))
                                        (QREFELT $ 75)))
                                      Z $))
                                    (PROGN (LETT #1# NIL) (GO #3=#:G1042)))))
                                 ('T (PROGN (LETT #1# NIL) (GO #3#))))))
                              (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                         (EXIT 'T)))))))
          #3# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;makeInterval|
        ((|l| (R)) ($ (|Complex| (|Interval| (|Float|)))))
        (COND
         ((|HasCategory| (QREFELT $ 6)
                         (LIST '|ConvertibleTo| (LIST '|Complex| '(|Float|))))
          (SPADCALL (ELT $ 147) (SPADCALL |l| (QREFELT $ 149))
                    (QREFELT $ 153)))
         ('T (|error| "This should never happen")))) 

(SDEFUN |SOLVETRA;dropfun| ((|x| (|Expression| R)) ($ (|Expression| R)))
        (SPROG
         ((#1=#:G1060 NIL)
          (|k| (|Union| (|Kernel| (|Expression| R)) "failed")))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |k| (SPADCALL |x| (QREFELT $ 155)))
                 (EXIT
                  (COND
                   ((OR (QEQCAR |k| 1)
                        (NULL (SPADCALL (QCDR |k|) (QREFELT $ 75))))
                    (PROGN
                     (LETT #1# (|spadConstant| $ 122))
                     (GO #2=#:G1058))))))
            (EXIT (|SPADfirst| (SPADCALL (QCDR |k|) (QREFELT $ 75))))))
          #2# (EXIT #1#)))) 

(SDEFUN |SOLVETRA;funcinv|
        ((|k| (|Expression| R)) (|l| (|Expression| R))
         ($ (|Union| (|Expression| R) "failed")))
        (SPROG
         ((|t| (|Expression| R)) (|fpi| (|Float|))
          (|im| (|Interval| (|Float|)))
          (|z| (|Union| (|Complex| (|Interval| (|Float|))) "failed"))
          (|ze| (|Expression| (|Complex| (|Interval| (|Float|))))))
         (SEQ
          (COND
           ((SPADCALL |k| '|sin| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|sin| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1='T (CONS 0 (SPADCALL |l| (QREFELT $ 156))))))
           ((SPADCALL |k| '|cos| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|cos| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 157))))))
           ((SPADCALL |k| '|tan| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|tan| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 158))))))
           ((SPADCALL |k| '|cot| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|cot| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 159))))))
           ((SPADCALL |k| '|sec| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             ((SPADCALL |l| '|sec| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 160))))))
           ((SPADCALL |k| '|csc| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             ((SPADCALL |l| '|csc| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 161))))))
           ((SPADCALL |k| '|sinh| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|sinh| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 162))))))
           ((SPADCALL |k| '|cosh| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|cosh| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 163))))))
           ((SPADCALL |k| '|tanh| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|tanh| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 164))))))
           ((SPADCALL |k| '|coth| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|coth| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 165))))))
           ((SPADCALL |k| '|sech| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|sech| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 166))))))
           ((SPADCALL |k| '|csch| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| '|csch| (QREFELT $ 116))
              (CONS 0 (|SOLVETRA;dropfun| |l| $)))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 167))))))
           ((SPADCALL |k| '|atan| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 96))))
           ((SPADCALL |k| '|acot| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 168))))))
           ((SPADCALL |k| '|asin| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 169))))
           ((SPADCALL |k| '|acos| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 170))))
           ((SPADCALL |k| '|asec| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 171))))
           ((SPADCALL |k| '|acsc| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 172))))))
           ((SPADCALL |k| '|asinh| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 173))))
           ((SPADCALL |k| '|acosh| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 174))))
           ((SPADCALL |k| '|atanh| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 175))))
           ((SPADCALL |k| '|acoth| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 176))))))
           ((SPADCALL |k| '|asech| (QREFELT $ 116))
            (CONS 0 (SPADCALL |l| (QREFELT $ 177))))
           ((SPADCALL |k| '|acsch| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 178))))))
           ((SPADCALL |k| '|exp| (QREFELT $ 116))
            (COND
             ((SPADCALL |l| (|spadConstant| $ 122) (QREFELT $ 34))
              (CONS 1 "failed"))
             (#1# (CONS 0 (|SOLVETRA;simplifyingLog| |l| $)))))
           ((SPADCALL |k| '|log| (QREFELT $ 116))
            (COND
             ((|HasCategory| (QREFELT $ 6)
                             (LIST '|ConvertibleTo|
                                   (LIST '|Complex| '(|Float|))))
              (SEQ
               (LETT |ze|
                     (SPADCALL (CONS (|function| |SOLVETRA;makeInterval|) $)
                               |l| (QREFELT $ 182)))
               (LETT |z| (SPADCALL |ze| (QREFELT $ 184)))
               (EXIT
                (COND ((QEQCAR |z| 1) (CONS 0 (SPADCALL |l| (QREFELT $ 185))))
                      (#1#
                       (SEQ (LETT |im| (SPADCALL (QCDR |z|) (QREFELT $ 186)))
                            (LETT |fpi| (SPADCALL (QREFELT $ 187)))
                            (COND
                             ((SPADCALL (SPADCALL |fpi| (QREFELT $ 188))
                                        (SPADCALL |im| (QREFELT $ 189))
                                        (QREFELT $ 190))
                              (COND
                               ((SPADCALL (SPADCALL |im| (QREFELT $ 191)) |fpi|
                                          (QREFELT $ 192))
                                (EXIT
                                 (CONS 0 (SPADCALL |l| (QREFELT $ 185))))))))
                            (EXIT (CONS 1 "failed"))))))))
             (#1# (CONS 0 (SPADCALL |l| (QREFELT $ 185))))))
           ((SPADCALL |k| '|%power| (QREFELT $ 116))
            (SEQ (LETT |t| (SPADCALL |l| (QREFELT $ 30)))
                 (EXIT
                  (COND
                   ((SPADCALL |t| (|spadConstant| $ 122) (QREFELT $ 34))
                    (CONS 1 "failed"))
                   (#1# (CONS 0 (SPADCALL |t| (QREFELT $ 77))))))))
           (#1# (CONS 0 |l|)))))) 

(SDEFUN |SOLVETRA;ker2Poly|
        ((|k| (|Kernel| (|Expression| R))) (|lvar| (|List| (|Symbol|)))
         ($ (|Polynomial| (|Expression| R))))
        (SPROG ((|nm| (|Symbol|)))
               (COND
                ((SPADCALL (LETT |nm| (SPADCALL |k| (QREFELT $ 126))) |lvar|
                           (QREFELT $ 127))
                 (SPADCALL |nm| (QREFELT $ 194)))
                ('T
                 (SPADCALL (SPADCALL |k| (QREFELT $ 109)) (QREFELT $ 195)))))) 

(SDEFUN |SOLVETRA;smp2Poly|
        ((|pol| (|SparseMultivariatePolynomial| R (|Kernel| (|Expression| R))))
         (|lvar| (|List| (|Symbol|))) ($ (|Polynomial| (|Expression| R))))
        (SPROG NIL
               (SPADCALL (CONS #'|SOLVETRA;smp2Poly!0| (VECTOR $ |lvar|))
                         (CONS #'|SOLVETRA;smp2Poly!1| $) |pol|
                         (QREFELT $ 199)))) 

(SDEFUN |SOLVETRA;smp2Poly!1| ((|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |y| (QREFELT $ 121)) (QREFELT $ 195))) 

(SDEFUN |SOLVETRA;smp2Poly!0| ((|x| NIL) ($$ NIL))
        (PROG (|lvar| $)
          (LETT |lvar| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|SOLVETRA;ker2Poly| |x| |lvar| $))))) 

(SDEFUN |SOLVETRA;makeFracPoly|
        ((|expr| (|Expression| R)) (|lvar| (|List| (|Symbol|)))
         ($ (|Fraction| (|Polynomial| (|Expression| R)))))
        (SPADCALL
         (|SOLVETRA;smp2Poly| (SPADCALL |expr| (QREFELT $ 59)) |lvar| $)
         (|SOLVETRA;smp2Poly| (SPADCALL |expr| (QREFELT $ 200)) |lvar| $)
         (QREFELT $ 202))) 

(SDEFUN |SOLVETRA;makeREpol|
        ((|pol| (|Polynomial| (|Expression| R))) ($ (|Expression| R)))
        (SPROG
         ((|lval| (|List| (|Expression| R))) (#1=#:G1127 NIL) (|v| NIL)
          (#2=#:G1126 NIL) (|lvar| (|List| (|Symbol|))))
         (SEQ (LETT |lvar| (SPADCALL |pol| (QREFELT $ 203)))
              (LETT |lval|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |v| NIL) (LETT #1# |lvar|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |v| (QREFELT $ 32)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (SPADCALL (SPADCALL |pol| |lvar| |lval| (QREFELT $ 204))
                         (QREFELT $ 205)))))) 

(SDEFUN |SOLVETRA;makeRE|
        ((|frac| (|Fraction| (|Polynomial| (|Expression| R))))
         ($ (|Expression| R)))
        (SPADCALL (|SOLVETRA;makeREpol| (SPADCALL |frac| (QREFELT $ 206)) $)
                  (|SOLVETRA;makeREpol| (SPADCALL |frac| (QREFELT $ 207)) $)
                  (QREFELT $ 95))) 

(SDEFUN |SOLVETRA;solve1Pol|
        ((|pol| (|Polynomial| (|Expression| R))) (|var| (|Symbol|))
         (|sol| (|List| (|Equation| (|Expression| R))))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((#1=#:G1134 NIL) (|vsol| NIL) (#2=#:G1133 NIL)
          (|vsols| (|List| (|Equation| (|Expression| R))))
          (|repol| (|Expression| R)))
         (SEQ
          (LETT |repol|
                (SPADCALL (|SOLVETRA;makeREpol| |pol| $) |sol|
                          (QREFELT $ 209)))
          (LETT |vsols| (SPADCALL |repol| |var| (QREFELT $ 15)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |vsol| NIL) (LETT #1# |vsols|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |vsol| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ (EXIT (LETT #2# (CONS (CONS |vsol| |sol|) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |SOLVETRA;solve1Sys|
        ((|plist| (|List| (|Polynomial| (|Expression| R))))
         (|lvar| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((|sols| (|List| (|List| (|Equation| (|Expression| R)))))
          (#1=#:G1137 NIL)
          (#2=#:G1136 #3=(|List| (|List| (|Equation| (|Expression| R)))))
          (#4=#:G1138 #3#) (#5=#:G1144 NIL) (|sol| NIL) (#6=#:G1142 NIL)
          (|p| NIL) (#7=#:G1143 NIL) (|v| NIL) (|rlvar| (|List| (|Symbol|)))
          (|rplist| (|List| (|Polynomial| (|Expression| R)))))
         (SEQ (LETT |rplist| (REVERSE |plist|)) (LETT |rlvar| (REVERSE |lvar|))
              (LETT |sols| (SPADCALL NIL (QREFELT $ 210)))
              (SEQ (LETT |v| NIL) (LETT #7# |rlvar|) (LETT |p| NIL)
                   (LETT #6# |rplist|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |p| (CAR #6#)) NIL) (ATOM #7#)
                         (PROGN (LETT |v| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |sols|
                           (PROGN
                            (LETT #1# NIL)
                            (SEQ (LETT |sol| NIL) (LETT #5# |sols|) G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT |sol| (CAR #5#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (PROGN
                                    (LETT #4#
                                          (|SOLVETRA;solve1Pol| |p| |v| |sol|
                                           $))
                                    (COND
                                     (#1#
                                      (LETT #2#
                                            (SPADCALL #2# #4#
                                                      (QREFELT $ 211))))
                                     ('T
                                      (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                                 (LETT #5# (CDR #5#)) (GO G190) G191
                                 (EXIT NIL))
                            (COND (#1# #2#) ('T NIL))))))
                   (LETT #6# (PROG1 (CDR #6#) (LETT #7# (CDR #7#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |sols|)))) 

(SDEFUN |SOLVETRA;frac_to_expr|
        ((|q|
          (|Fraction|
           (|SparseMultivariatePolynomial| R (|Kernel| (|Expression| R)))))
         ($ (|Expression| R)))
        (SPADCALL (SPADCALL |q| (QREFELT $ 213)) (SPADCALL |q| (QREFELT $ 214))
                  (QREFELT $ 215))) 

(SDEFUN |SOLVETRA;tryLinear|
        ((|lexpr| (|List| (|Expression| R))) (|lvar| (|List| (|Symbol|)))
         ($
          (|Union| (|List| (|List| (|Equation| (|Expression| R)))) "failed")))
        (SPROG
         ((|eqs| (|List| (|Equation| (|Expression| R)))) (#1=#:G1220 NIL)
          (|i| NIL) (#2=#:G1219 NIL) (|sym| (|Expression| R)) (#3=#:G1218 NIL)
          (|p| NIL) (|zeron| (|Vector| (|Expression| R)))
          (|rhs| (|Vector| (|Expression| R))) (#4=#:G1188 NIL)
          (|sol|
           (|Record|
            (|:| |particular|
                 (|Union| (|Vector| (|Expression| R)) #5="failed"))
            (|:| |basis| (|List| (|Vector| (|Expression| R))))))
          (|vece| (|Vector| (|Expression| R))) (#6=#:G1217 NIL) (|q| NIL)
          (#7=#:G1216 NIL) (|mate| (|Matrix| (|Expression| R)))
          (#8=#:G1215 NIL) (#9=#:G1214 NIL) (#10=#:G1213 NIL) (|row| NIL)
          (#11=#:G1212 NIL)
          (|r|
           (|Record|
            (|:| |mat|
                 (|Matrix|
                  (|Fraction|
                   (|SparseMultivariatePolynomial| R
                                                   (|Kernel|
                                                    (|Expression| R))))))
            (|:| |vec|
                 (|Vector|
                  (|Fraction|
                   (|SparseMultivariatePolynomial| R
                                                   (|Kernel|
                                                    (|Expression| R))))))))
          (|ps|
           (|List|
            (|SparseMultivariatePolynomial| R (|Kernel| (|Expression| R)))))
          (#12=#:G1211 NIL) (|expr| NIL) (#13=#:G1210 NIL) (#14=#:G1202 NIL)
          (#15=#:G1209 NIL) (|ker| NIL)
          (|kers| (|List| (|Kernel| (|Expression| R))))
          (|llk| (|List| (|List| (|Kernel| (|Expression| R)))))
          (#16=#:G1208 NIL) (#17=#:G1207 NIL) (#18=#:G1152 NIL)
          (#19=#:G1151 #20=(|Boolean|)) (#21=#:G1153 #20#) (#22=#:G1206 NIL)
          (#23=#:G1149 NIL) (#24=#:G1148 #25=(|Boolean|)) (#26=#:G1150 #25#)
          (#27=#:G1205 NIL) (|lvk| (|List| (|Kernel| (|Expression| R))))
          (#28=#:G1204 NIL) (|v| NIL) (#29=#:G1203 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lvk|
                  (PROGN
                   (LETT #29# NIL)
                   (SEQ (LETT |v| NIL) (LETT #28# |lvar|) G190
                        (COND
                         ((OR (ATOM #28#) (PROGN (LETT |v| (CAR #28#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #29#
                                (CONS (SPADCALL |v| (QREFELT $ 36)) #29#))))
                        (LETT #28# (CDR #28#)) (GO G190) G191
                        (EXIT (NREVERSE #29#)))))
            (EXIT
             (COND
              ((OR
                (PROGN
                 (LETT #23# NIL)
                 (SEQ (LETT |expr| NIL) (LETT #27# |lexpr|) G190
                      (COND
                       ((OR (ATOM #27#) (PROGN (LETT |expr| (CAR #27#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #26#
                               (>
                                (SPADCALL (SPADCALL |expr| (QREFELT $ 59))
                                          |lvk| (QREFELT $ 217))
                                1))
                         (COND (#23# (LETT #24# (COND (#24# 'T) ('T #26#))))
                               ('T (PROGN (LETT #24# #26#) (LETT #23# 'T)))))))
                      (LETT #27# (CDR #27#)) (GO G190) G191 (EXIT NIL))
                 (COND (#23# #24#) (#30='T NIL)))
                (PROGN
                 (LETT #18# NIL)
                 (SEQ (LETT |expr| NIL) (LETT #22# |lexpr|) G190
                      (COND
                       ((OR (ATOM #22#) (PROGN (LETT |expr| (CAR #22#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #21#
                               (NULL
                                (NULL
                                 (SPADCALL |lvk|
                                           (SPADCALL
                                            (SPADCALL |expr| (QREFELT $ 200))
                                            (QREFELT $ 218))
                                           (QREFELT $ 219)))))
                         (COND (#18# (LETT #19# (COND (#19# 'T) ('T #21#))))
                               ('T (PROGN (LETT #19# #21#) (LETT #18# 'T)))))))
                      (LETT #22# (CDR #22#)) (GO G190) G191 (EXIT NIL))
                 (COND (#18# #19#) (#30# NIL))))
               (CONS 1 "failed"))
              ('T
               (SEQ
                (LETT |llk|
                      (PROGN
                       (LETT #17# NIL)
                       (SEQ (LETT |expr| NIL) (LETT #16# |lexpr|) G190
                            (COND
                             ((OR (ATOM #16#)
                                  (PROGN (LETT |expr| (CAR #16#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #17#
                                    (CONS (SPADCALL |expr| (QREFELT $ 220))
                                          #17#))))
                            (LETT #16# (CDR #16#)) (GO G190) G191
                            (EXIT (NREVERSE #17#)))))
                (LETT |kers| (SPADCALL (ELT $ 222) |llk| (QREFELT $ 225)))
                (SEQ (LETT |ker| NIL) (LETT #15# |kers|) G190
                     (COND
                      ((OR (ATOM #15#) (PROGN (LETT |ker| (CAR #15#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((QEQCAR (SPADCALL |ker| (QREFELT $ 227)) 0) "iterate")
                        ((NULL
                          (NULL
                           (SPADCALL |lvar|
                                     (SPADCALL (SPADCALL |ker| (QREFELT $ 109))
                                               (QREFELT $ 11))
                                     (QREFELT $ 228))))
                         (PROGN
                          (LETT #14# (CONS 1 "failed"))
                          (GO #31=#:G1201))))))
                     (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
                (LETT |ps|
                      (PROGN
                       (LETT #13# NIL)
                       (SEQ (LETT |expr| NIL) (LETT #12# |lexpr|) G190
                            (COND
                             ((OR (ATOM #12#)
                                  (PROGN (LETT |expr| (CAR #12#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #13#
                                    (CONS (SPADCALL |expr| (QREFELT $ 59))
                                          #13#))))
                            (LETT #12# (CDR #12#)) (GO G190) G191
                            (EXIT (NREVERSE #13#)))))
                (LETT |r| (SPADCALL |ps| |lvk| (QREFELT $ 232)))
                (LETT |mate|
                      (SPADCALL
                       (PROGN
                        (LETT #11# NIL)
                        (SEQ (LETT |row| NIL)
                             (LETT #10# (SPADCALL (QCAR |r|) (QREFELT $ 235)))
                             G190
                             (COND
                              ((OR (ATOM #10#)
                                   (PROGN (LETT |row| (CAR #10#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #11#
                                     (CONS
                                      (PROGN
                                       (LETT #9# NIL)
                                       (SEQ (LETT |q| NIL) (LETT #8# |row|)
                                            G190
                                            (COND
                                             ((OR (ATOM #8#)
                                                  (PROGN
                                                   (LETT |q| (CAR #8#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #9#
                                                    (CONS
                                                     (|SOLVETRA;frac_to_expr|
                                                      |q| $)
                                                     #9#))))
                                            (LETT #8# (CDR #8#)) (GO G190) G191
                                            (EXIT (NREVERSE #9#))))
                                      #11#))))
                             (LETT #10# (CDR #10#)) (GO G190) G191
                             (EXIT (NREVERSE #11#))))
                       (QREFELT $ 238)))
                (LETT |vece|
                      (SPADCALL
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |q| NIL)
                             (LETT #6# (SPADCALL (QCDR |r|) (QREFELT $ 241)))
                             G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |q| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (|SOLVETRA;frac_to_expr| |q| $)
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#))))
                       (QREFELT $ 243)))
                (LETT |sol| (SPADCALL |mate| |vece| (QREFELT $ 247)))
                (EXIT
                 (COND ((QEQCAR (QCAR |sol|) 1) (CONS 0 NIL))
                       (#30#
                        (SEQ
                         (LETT |rhs|
                               (PROG2 (LETT #4# (QCAR |sol|))
                                   (QCDR #4#)
                                 (|check_union2| (QEQCAR #4# 0)
                                                 (|Vector|
                                                  (|Expression| (QREFELT $ 6)))
                                                 (|Union|
                                                  (|Vector|
                                                   (|Expression|
                                                    (QREFELT $ 6)))
                                                  #5#)
                                                 #4#)))
                         (LETT |zeron|
                               (SPADCALL (LENGTH |lvar|) (QREFELT $ 248)))
                         (SEQ (LETT |p| NIL) (LETT #3# (QCDR |sol|)) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |p| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |p| |zeron| (QREFELT $ 251))
                                  (SEQ
                                   (LETT |sym|
                                         (SPADCALL (SPADCALL (QREFELT $ 31))
                                                   (QREFELT $ 32)))
                                   (EXIT
                                    (SEQ (LETT |i| 1)
                                         (LETT #2# (LENGTH |lvar|)) G190
                                         (COND
                                          ((|greater_SI| |i| #2#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (SPADCALL |rhs| |i|
                                                     (SPADCALL
                                                      (SPADCALL |rhs| |i|
                                                                (QREFELT $
                                                                         252))
                                                      (SPADCALL |sym|
                                                                (SPADCALL |p|
                                                                          |i|
                                                                          (QREFELT
                                                                           $
                                                                           252))
                                                                (QREFELT $
                                                                         124))
                                                      (QREFELT $ 123))
                                                     (QREFELT $ 253))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT NIL))))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                         (LETT |eqs| NIL)
                         (SEQ (LETT |i| 1) (LETT #1# (LENGTH |lvar|)) G190
                              (COND ((|greater_SI| |i| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT |eqs|
                                      (SPADCALL |eqs|
                                                (LIST
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL |lvar| |i|
                                                             (QREFELT $ 254))
                                                   (QREFELT $ 32))
                                                  (SPADCALL |rhs| |i|
                                                            (QREFELT $ 252))
                                                  (QREFELT $ 33)))
                                                (QREFELT $ 57)))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT (CONS 0 (LIST |eqs|)))))))))))))
          #31# (EXIT #14#)))) 

(SDEFUN |SOLVETRA;solveList|
        ((|lexpr| (|List| (|Expression| R))) (|lvar| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((|l| (|List| (|List| (|List| (|Equation| (|Expression| R))))))
          (#1=#:G1234 NIL) (|plist| NIL) (#2=#:G1233 NIL)
          (|trianglist| (|List| (|List| (|Polynomial| (|Expression| R)))))
          (|lfrac| (|List| (|Fraction| (|Polynomial| (|Expression| R)))))
          (#3=#:G1232 NIL) (|expr| NIL) (#4=#:G1231 NIL)
          (|ans1|
           (|Union| (|List| (|List| (|Equation| (|Expression| R)))) "failed")))
         (SEQ (LETT |ans1| (|SOLVETRA;solveRetract| |lexpr| |lvar| $))
              (EXIT
               (COND
                ((QEQCAR |ans1| 1)
                 (SEQ (LETT |ans1| (|SOLVETRA;tryLinear| |lexpr| |lvar| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ans1| 1)
                         (SEQ
                          (LETT |lfrac|
                                (PROGN
                                 (LETT #4# NIL)
                                 (SEQ (LETT |expr| NIL) (LETT #3# |lexpr|) G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN
                                             (LETT |expr| (CAR #3#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #4#
                                              (CONS
                                               (|SOLVETRA;makeFracPoly| |expr|
                                                |lvar| $)
                                               #4#))))
                                      (LETT #3# (CDR #3#)) (GO G190) G191
                                      (EXIT (NREVERSE #4#)))))
                          (LETT |trianglist|
                                (SPADCALL |lfrac| |lvar| (QREFELT $ 258)))
                          (LETT |l|
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |plist| NIL)
                                      (LETT #1# |trianglist|) G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN
                                             (LETT |plist| (CAR #1#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #2#
                                              (CONS
                                               (|SOLVETRA;solve1Sys| |plist|
                                                |lvar| $)
                                               #2#))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT (NREVERSE #2#)))))
                          (EXIT
                           (SPADCALL (ELT $ 211) |l| NIL (QREFELT $ 261)))))
                        (#5='T (QCDR |ans1|))))))
                (#5# (QCDR |ans1|))))))) 

(SDEFUN |SOLVETRA;solve;LLL;37|
        ((|leqs| (|List| (|Equation| (|Expression| R))))
         (|lvar| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((|lexpr| (|List| (|Expression| R))) (#1=#:G1240 NIL) (|eq| NIL)
          (#2=#:G1239 NIL))
         (SEQ
          (LETT |lexpr|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |eq| NIL) (LETT #1# |leqs|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |eq| (QREFELT $ 18))
                                         (SPADCALL |eq| (QREFELT $ 19))
                                         (QREFELT $ 20))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (|SOLVETRA;solveList| |lexpr| |lvar| $))))) 

(SDEFUN |SOLVETRA;solve;LLL;38|
        ((|leqs| (|List| (|Equation| (|Expression| R))))
         (|lker| (|List| (|Kernel| (|Expression| R))))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((#1=#:G1275 NIL) (|neq| NIL) (#2=#:G1274 NIL) (#3=#:G1273 NIL)
          (|sol| NIL) (#4=#:G1272 NIL) (|lval2| (|List| (|Expression| R)))
          (#5=#:G1271 NIL) (|k| NIL) (#6=#:G1270 NIL)
          (|lker2| (|List| (|Kernel| (|Expression| R)))) (#7=#:G1269 NIL)
          (|v| NIL) (#8=#:G1268 NIL)
          (|ans| (|List| (|List| (|Equation| (|Expression| R)))))
          (|nlexpr| (|List| (|Expression| R))) (#9=#:G1267 NIL) (|expr| NIL)
          (#10=#:G1266 NIL) (|lval| (|List| (|Expression| R)))
          (#11=#:G1265 NIL) (#12=#:G1264 NIL) (|lvar| (|List| (|Symbol|)))
          (#13=#:G1263 NIL) (#14=#:G1262 NIL)
          (|lexpr| (|List| (|Expression| R))) (#15=#:G1261 NIL) (|eq| NIL)
          (#16=#:G1260 NIL))
         (SEQ
          (LETT |lexpr|
                (PROGN
                 (LETT #16# NIL)
                 (SEQ (LETT |eq| NIL) (LETT #15# |leqs|) G190
                      (COND
                       ((OR (ATOM #15#) (PROGN (LETT |eq| (CAR #15#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #16#
                              (CONS
                               (SPADCALL (SPADCALL |eq| (QREFELT $ 18))
                                         (SPADCALL |eq| (QREFELT $ 19))
                                         (QREFELT $ 20))
                               #16#))))
                      (LETT #15# (CDR #15#)) (GO G190) G191
                      (EXIT (NREVERSE #16#)))))
          (LETT |lvar|
                (PROGN
                 (LETT #14# NIL)
                 (SEQ (LETT |k| NIL) (LETT #13# |lker|) G190
                      (COND
                       ((OR (ATOM #13#) (PROGN (LETT |k| (CAR #13#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #14# (CONS (SPADCALL (QREFELT $ 31)) #14#))))
                      (LETT #13# (CDR #13#)) (GO G190) G191
                      (EXIT (NREVERSE #14#)))))
          (LETT |lval|
                (PROGN
                 (LETT #12# NIL)
                 (SEQ (LETT |v| NIL) (LETT #11# |lvar|) G190
                      (COND
                       ((OR (ATOM #11#) (PROGN (LETT |v| (CAR #11#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #12# (CONS (SPADCALL |v| (QREFELT $ 32)) #12#))))
                      (LETT #11# (CDR #11#)) (GO G190) G191
                      (EXIT (NREVERSE #12#)))))
          (LETT |nlexpr|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |expr| NIL) (LETT #9# |lexpr|) G190
                      (COND
                       ((OR (ATOM #9#) (PROGN (LETT |expr| (CAR #9#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #10#
                              (CONS
                               (SPADCALL |expr| |lker| |lval| (QREFELT $ 263))
                               #10#))))
                      (LETT #9# (CDR #9#)) (GO G190) G191
                      (EXIT (NREVERSE #10#)))))
          (LETT |ans| (|SOLVETRA;solveList| |nlexpr| |lvar| $))
          (LETT |lker2|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |v| NIL) (LETT #7# |lvar|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |v| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8# (CONS (SPADCALL |v| (QREFELT $ 36)) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |lval2|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |k| NIL) (LETT #5# |lker|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |k| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6# (CONS (SPADCALL |k| (QREFELT $ 109)) #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (EXIT
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |sol| NIL) (LETT #3# |ans|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |sol| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |neq| NIL) (LETT #1# |sol|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |neq| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (CONS #'|SOLVETRA;solve;LLL;38!0|
                                                (VECTOR $ |lval2| |lker2|))
                                          |neq| (QREFELT $ 265))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          #4#))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT (NREVERSE #4#)))))))) 

(SDEFUN |SOLVETRA;solve;LLL;38!0| ((|e| NIL) ($$ NIL))
        (PROG (|lker2| |lval2| $)
          (LETT |lker2| (QREFELT $$ 2))
          (LETT |lval2| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |lker2| |lval2| (QREFELT $ 263)))))) 

(SDEFUN |SOLVETRA;retract2|
        ((|e| (|Expression| R)) ($ (|Kernel| (|Expression| R))))
        (SPROG ((|k| (|Union| (|Kernel| (|Expression| R)) "failed")))
               (SEQ (LETT |k| (SPADCALL |e| (QREFELT $ 155)))
                    (EXIT
                     (COND
                      ((QEQCAR |k| 1)
                       (|error|
                        "solve$TransSolvePackage: variable is not a single kernel"))
                      ('T (QCDR |k|))))))) 

(SDEFUN |SOLVETRA;solve;LLL;40|
        ((|leqs| (|List| (|Equation| (|Expression| R))))
         (|lexpr| (|List| (|Expression| R)))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((|lker| (|List| (|Kernel| (|Expression| R)))) (#1=#:G1286 NIL)
          (|e| NIL) (#2=#:G1285 NIL))
         (SEQ
          (LETT |lker|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |e| NIL) (LETT #1# |lexpr|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (|SOLVETRA;retract2| |e| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL |leqs| |lker| (QREFELT $ 266)))))) 

(DECLAIM (NOTINLINE |TransSolvePackage;|)) 

(DEFUN |TransSolvePackage| (#1=#:G1287)
  (SPROG NIL
         (PROG (#2=#:G1288)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TransSolvePackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|TransSolvePackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|TransSolvePackage|)))))))))) 

(DEFUN |TransSolvePackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TransSolvePackage| DV$1))
          (LETT $ (GETREFV 268))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TransSolvePackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TransSolvePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|)
              (|Expression| 6) (0 . |zero?|) (|List| 14) (5 . |variables|)
              (10 . |One|) (|List| 17) (|Symbol|) |SOLVETRA;solve;ESL;5|
              |SOLVETRA;solve;EL;1| (|Equation| 8) (14 . |lhs|) (19 . |rhs|)
              (24 . -) |SOLVETRA;solve;EL;2| |SOLVETRA;solve;ESL;3|
              (|Union| 55 '#1="failed") (30 . |retractIfCan|)
              (|Union| (|Fraction| 55) '#1#) (35 . |retractIfCan|)
              (|Equation| $) (40 . |eval|)
              (|ElementaryFunctionStructurePackage| 6 8) (46 . |normalize|)
              (51 . |new|) (55 . |coerce|) (60 . =) (66 . =) (|Kernel| 8)
              (72 . |kernel|) (|Fraction| 51) (|Kernel| $) (77 . |univariate|)
              (|SparseUnivariatePolynomial| 8) (|Fraction| 40) (83 . |numer|)
              (|Factored| 40) (|ExpressionFactorPolynomial| 6 8)
              (88 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 46) (|:| |factor| 40) (|:| |exponent| 112))
              (|List| 47) (93 . |factorList|) (|List| $)
              (|SparseUnivariatePolynomial| $) (98 . |zerosOf|) (|List| 8)
              (104 . |append|) (|Integer|) (110 . |elt|) (116 . |append|)
              (|SparseMultivariatePolynomial| 6 38) (122 . |numer|)
              (127 . |coerce|) (|Factored| 51) (132 . |factorPolynomial|)
              (|AlgebraicManipulations| 6 8) (137 . |rootSimp|) (|Factored| 66)
              (|SparseMultivariatePolynomial| 6 35)
              (|MultivariateFactorize| 35 (|IndexedExponents| 35) 6 66)
              (142 . |factor|)
              (|Record| (|:| |flag| 46) (|:| |factor| 66) (|:| |exponent| 112))
              (|List| 69) (147 . |factorList|)
              (|Record| (|:| |var| 38) (|:| |exponent| 55))
              (|Union| 72 '"failed") (152 . |isExpt|) (158 . |argument|)
              (163 . *) (169 . |log|) (|SparseUnivariatePolynomial| 6)
              (174 . |One|) (|Union| (|Fraction| (|Polynomial| 6)) '#1#)
              (178 . |retractIfCan|) (|List| 13)
              (|List| (|Fraction| (|Polynomial| 6))) (|RadicalSolvePackage| 6)
              (183 . |radicalSolve|) (|TranscendentalManipulations| 6 8)
              (189 . |simplify|) (194 . |normalize|)
              (|TrigonometricManipulations| 6 8) (200 . |complexNormalize|)
              (|List| 38) (206 . |kernels|) (211 . |numerator|)
              (216 . |coerce|) (221 . /) (227 . |tan|) (|PositiveInteger|)
              (232 . *) (238 . ^) (244 . |One|) (248 . -) (254 . |One|)
              (258 . -) (|TransSolvePackageService| 6) (263 . |decomposeFunc|)
              (270 . ~=) (|Fraction| $) (276 . |elt|) (282 . |coerce|)
              (287 . |second|) (292 . |retract|) (|NonNegativeInteger|)
              (297 . |monomial|) (303 . -) (309 . |resultant|) (315 . |is?|)
              (|Union| 50 '"failed") (321 . |isPlus|)
              (326 . |leadingCoefficient|) (331 . |gcd|) (336 . |coerce|)
              (341 . |Zero|) (345 . +) (351 . *) (357 . |Zero|) (361 . |name|)
              (366 . |member?|) (372 . |isTimes|) (377 . |remove!|)
              (383 . |One|) (387 . |freeOf?|) (393 . ^) (|Table| 8 8)
              (399 . |table|) (403 . |Zero|) (407 . ~=)
              (413 . |leadingMonomial|) (|Union| 8 '"failed") (418 . |search|)
              (424 . |setelt!|) (431 . |elt|) (437 . |reductum|) (442 . |keys|)
              (447 . |is?|) (|Float|) (|Interval| 145) (453 . |interval|)
              (|Complex| 145) (458 . |convert|) (|Complex| 146)
              (|Mapping| 146 145) (|ComplexFunctions2| 145 146) (463 . |map|)
              (|Union| 38 '#1#) (469 . |retractIfCan|) (474 . |asin|)
              (479 . |acos|) (484 . |atan|) (489 . |acot|) (494 . |asec|)
              (499 . |acsc|) (504 . |asinh|) (509 . |acosh|) (514 . |atanh|)
              (519 . |acoth|) (524 . |asech|) (529 . |acsch|) (534 . |cot|)
              (539 . |sin|) (544 . |cos|) (549 . |sec|) (554 . |csc|)
              (559 . |sinh|) (564 . |cosh|) (569 . |tanh|) (574 . |coth|)
              (579 . |sech|) (584 . |csch|) (|Expression| 150)
              (|Mapping| 150 6) (|ExpressionFunctions2| 6 150) (589 . |map|)
              (|Union| 150 '#1#) (595 . |retractIfCan|) (600 . |exp|)
              (605 . |imag|) (610 . |pi|) (614 . -) (619 . |inf|) (624 . <)
              (630 . |sup|) (635 . <=) (|Polynomial| 8) (641 . |coerce|)
              (646 . |coerce|) (|Mapping| 193 35) (|Mapping| 193 6)
              (|PolynomialCategoryLifting| (|IndexedExponents| 35) 35 6 66 193)
              (651 . |map|) (658 . |denom|) (|Fraction| 193) (663 . /)
              (669 . |variables|) (674 . |eval|) (681 . |ground|)
              (686 . |numer|) (691 . |denom|) (|List| 27) (696 . |eval|)
              (702 . |list|) (707 . |append|) (|Fraction| 66) (713 . |numer|)
              (718 . |denom|) (723 . /) (|List| 35) (729 . |totalDegree|)
              (735 . |variables|) (740 . |setIntersection|) (746 . |tower|)
              (751 . |setUnion|) (757 . |setUnion|) (|Mapping| 216 216 216)
              (|List| 216) (763 . |reduce|) (|Union| 14 '"failed")
              (769 . |symbolIfCan|) (774 . |setIntersection|)
              (|Record| (|:| |mat| 234) (|:| |vec| 240)) (|List| 66)
              (|LinearSystemPolynomialPackage| 6 (|IndexedExponents| 35) 35 66)
              (780 . |intoMatrix|) (|List| 239) (|Matrix| 212)
              (786 . |listOfLists|) (|List| 53) (|Matrix| 8) (791 . |matrix|)
              (|List| 212) (|Vector| 212) (796 . |parts|) (|Vector| 8)
              (801 . |vector|) (|Union| 242 '"failed")
              (|Record| (|:| |particular| 244) (|:| |basis| (|List| 242)))
              (|LinearSystemMatrixPackage| 8 242 242 237) (806 . |solve|)
              (812 . |zero|) (|Vector| $) (817 . |basis|) (821 . ~=)
              (827 . |elt|) (833 . |setelt!|) (840 . |elt|)
              (|List| (|List| 193)) (|List| 201) (|SystemSolvePackage| 8)
              (846 . |triangularSystems|) (|Mapping| 82 82 82) (|List| 82)
              (852 . |reduce|) |SOLVETRA;solve;LLL;37| (859 . |eval|)
              (|Mapping| 8 8) (866 . |map|) |SOLVETRA;solve;LLL;38|
              |SOLVETRA;solve;LLL;40|)
           '#(|solve| 872) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Expression| |#1|)))
                                T)
                              '((|solve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Equation| (|Expression| |#1|))))
                                T)
                              '((|solve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Equation| (|Expression| |#1|)) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Expression| |#1|) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List| (|Equation| (|Expression| |#1|)))
                                  (|List| (|Symbol|))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List| (|Equation| (|Expression| |#1|)))
                                  (|List| (|Kernel| (|Expression| |#1|)))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List| (|Equation| (|Expression| |#1|)))
                                  (|List| (|Expression| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 267
                                            '(1 8 7 0 9 1 8 10 0 11 0 6 0 12 1
                                              17 8 0 18 1 17 8 0 19 2 8 0 0 0
                                              20 1 8 23 0 24 1 8 25 0 26 2 8 0
                                              0 27 28 1 29 8 8 30 0 14 0 31 1 8
                                              0 14 32 2 17 0 8 8 33 2 8 7 0 0
                                              34 1 35 0 14 36 2 8 37 0 38 39 1
                                              41 40 0 42 1 44 43 40 45 1 43 48
                                              0 49 2 8 50 51 14 52 2 53 0 0 0
                                              54 2 53 8 0 55 56 2 13 0 0 0 57 1
                                              8 58 0 59 1 8 0 58 60 1 8 61 51
                                              62 1 63 8 8 64 1 67 65 66 68 1 65
                                              70 0 71 2 8 73 0 14 74 1 35 53 0
                                              75 2 8 0 55 0 76 1 8 0 0 77 0 78
                                              0 79 1 8 80 0 81 2 84 82 83 10 85
                                              1 86 8 8 87 2 29 8 8 14 88 2 89 8
                                              8 14 90 1 8 91 0 92 1 8 0 0 93 1
                                              8 0 55 94 2 8 0 0 0 95 1 8 0 0 96
                                              2 8 0 97 0 98 2 8 0 0 97 99 0 17
                                              0 100 2 17 0 8 0 101 0 8 0 102 1
                                              8 0 0 103 3 104 41 41 41 41 105 2
                                              41 7 0 0 106 2 40 8 107 8 108 1 8
                                              0 38 109 1 53 8 0 110 1 8 55 0
                                              111 2 40 0 8 112 113 2 40 0 0 0
                                              114 2 40 8 0 0 115 2 8 7 0 14 116
                                              1 8 117 0 118 1 66 6 0 119 1 6 0
                                              50 120 1 8 0 6 121 0 8 0 122 2 8
                                              0 0 0 123 2 8 0 0 0 124 0 6 0 125
                                              1 35 14 0 126 2 10 7 14 0 127 1 8
                                              117 0 128 2 53 0 8 0 129 0 55 0
                                              130 2 8 7 0 14 131 2 8 0 0 0 132
                                              0 133 0 134 0 78 0 135 2 8 7 0 0
                                              136 1 66 0 0 137 2 133 138 8 0
                                              139 3 133 8 0 8 8 140 2 133 8 0 8
                                              141 1 66 0 0 142 1 133 53 0 143 2
                                              35 7 0 14 144 1 146 0 145 147 1 6
                                              148 0 149 2 152 150 151 148 153 1
                                              8 154 0 155 1 8 0 0 156 1 8 0 0
                                              157 1 8 0 0 158 1 8 0 0 159 1 8 0
                                              0 160 1 8 0 0 161 1 8 0 0 162 1 8
                                              0 0 163 1 8 0 0 164 1 8 0 0 165 1
                                              8 0 0 166 1 8 0 0 167 1 8 0 0 168
                                              1 8 0 0 169 1 8 0 0 170 1 8 0 0
                                              171 1 8 0 0 172 1 8 0 0 173 1 8 0
                                              0 174 1 8 0 0 175 1 8 0 0 176 1 8
                                              0 0 177 1 8 0 0 178 2 181 179 180
                                              8 182 1 179 183 0 184 1 8 0 0 185
                                              1 150 146 0 186 0 145 0 187 1 145
                                              0 0 188 1 146 145 0 189 2 145 7 0
                                              0 190 1 146 145 0 191 2 145 7 0 0
                                              192 1 193 0 14 194 1 193 0 8 195
                                              3 198 193 196 197 66 199 1 8 58 0
                                              200 2 201 0 193 193 202 1 193 10
                                              0 203 3 193 0 0 10 53 204 1 193 8
                                              0 205 1 201 193 0 206 1 201 193 0
                                              207 2 8 0 0 208 209 1 82 0 13 210
                                              2 82 0 0 0 211 1 212 66 0 213 1
                                              212 66 0 214 2 8 0 58 58 215 2 66
                                              112 0 216 217 1 66 216 0 218 2
                                              216 0 0 0 219 1 8 91 0 220 2 13 0
                                              0 0 221 2 216 0 0 0 222 2 224 216
                                              223 0 225 1 35 226 0 227 2 10 0 0
                                              0 228 2 231 229 230 216 232 1 234
                                              233 0 235 1 237 0 236 238 1 240
                                              239 0 241 1 242 0 53 243 2 246
                                              245 237 242 247 1 242 0 112 248 0
                                              150 249 250 2 242 7 0 0 251 2 242
                                              8 0 55 252 3 242 8 0 55 8 253 2
                                              10 14 0 55 254 2 257 255 256 10
                                              258 3 260 82 259 0 82 261 3 8 0 0
                                              91 50 263 2 17 0 264 0 265 1 0 13
                                              8 16 2 0 13 17 14 22 1 0 13 17 21
                                              2 0 82 13 10 262 2 0 13 8 14 15 2
                                              0 82 13 53 267 2 0 82 13 216
                                              266)))))
           '|lookupComplete|)) 
