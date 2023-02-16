
(SDEFUN |INTAF;UPUP2F1|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|t| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|cf| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|kx| (|Kernel| F)) (|k| (|Kernel| F)) ($ (F)))
        (|INTAF;UPUP2F0| (SPADCALL |p| |t| |cf| (QREFELT $ 11)) |kx| |k| $)) 

(SDEFUN |INTAF;UPUP2F0|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|kx| (|Kernel| F)) (|k| (|Kernel| F)) ($ (F)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (CONS #'|INTAF;UPUP2F0!0| (VECTOR $ |kx|)) |p|
                          (QREFELT $ 18))
                (SPADCALL |k| (QREFELT $ 20)) (QREFELT $ 21)))) 

(SDEFUN |INTAF;UPUP2F0!0| ((|x1| NIL) ($$ NIL))
        (PROG (|kx| $)
          (LETT |kx| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |kx| (QREFELT $ 14)))))) 

(SDEFUN |INTAF;F2UPUP|
        ((|f| (F)) (|kx| (|Kernel| F)) (|k| (|Kernel| F))
         (|p| (|SparseUnivariatePolynomial| F))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (|INTAF;UP2UPUP| (SPADCALL |f| |k| |p| (QREFELT $ 22)) |kx| $)) 

(SDEFUN |INTAF;rootintegrate|
        ((|f| (F)) (|t| (|Kernel| F)) (|k| (|Kernel| F))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|rec_int| (|Mapping| (|IntegrationResult| F) F))
         ($ (|IntegrationResult| F)))
        (SPROG
         ((|curve|
           (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                    (|SparseUnivariatePolynomial|
                                     (|Fraction|
                                      (|SparseUnivariatePolynomial| F)))))
          (|q| (|SparseUnivariatePolynomial| F))
          (|r|
           (|Record|
            (|:| |radicand| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |deg| (|NonNegativeInteger|))))
          (#1=#:G718 NIL)
          (|f1|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|r1|
           (|Record| (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |poly|
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (|modulus|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |r1|
                (SPADCALL
                 (LETT |modulus|
                       (|INTAF;UP2UPUP|
                        (LETT |p| (SPADCALL |k| (QREFELT $ 24))) |t| $))
                 (QREFELT $ 26)))
          (LETT |f1|
                (SPADCALL (|INTAF;F2UPUP| |f| |t| |k| |p| $)
                          (SPADCALL (SPADCALL (QCAR |r1|) (QREFELT $ 27)) 1
                                    (QREFELT $ 30))
                          (QREFELT $ 31)))
          (LETT |r|
                (PROG2 (LETT #1# (SPADCALL (QCDR |r1|) (QREFELT $ 34)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|Record|
                                   (|:| |radicand|
                                        (|Fraction|
                                         (|SparseUnivariatePolynomial|
                                          (QREFELT $ 7))))
                                   (|:| |deg| (|NonNegativeInteger|)))
                                  (|Union|
                                   (|Record|
                                    (|:| |radicand|
                                         (|Fraction|
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))))
                                    (|:| |deg| (|NonNegativeInteger|)))
                                   "failed")
                                  #1#)))
          (LETT |q| (SPADCALL (QCAR |r|) (QREFELT $ 35)))
          (LETT |curve|
                (|RadicalFunctionField| (QREFELT $ 7)
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 7))
                                        (|SparseUnivariatePolynomial|
                                         (|Fraction|
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))))
                                        (SPADCALL |q| (QREFELT $ 36))
                                        (QCDR |r|)))
          (EXIT
           (SPADCALL
            (CONS #'|INTAF;rootintegrate!0| (VECTOR |k| |t| |r1| |curve| $))
            (SPADCALL
             (SPADCALL |f1|
                       (|compiledLookupCheck| '|reduce|
                                              (LIST '$
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (LIST '|Fraction|
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (|devaluate|
                                                             (ELT $ 7))))))
                                              |curve|))
             |derivation| |rec_int|
             (|compiledLookupCheck| '|algintegrate|
                                    (LIST
                                     (LIST '|IntegrationResult|
                                           (|devaluate| |curve|))
                                     (|devaluate| |curve|)
                                     (LIST '|Mapping|
                                           (LIST '|SparseUnivariatePolynomial|
                                                 (|devaluate| (ELT $ 7)))
                                           (LIST '|SparseUnivariatePolynomial|
                                                 (|devaluate| (ELT $ 7))))
                                     (LIST '|Mapping|
                                           (LIST '|IntegrationResult|
                                                 (|devaluate| (ELT $ 7)))
                                           (|devaluate| (ELT $ 7))))
                                    (|AlgebraicIntegrate| (ELT $ 6) (ELT $ 7)
                                                          (|SparseUnivariatePolynomial|
                                                           (ELT $ 7))
                                                          (|SparseUnivariatePolynomial|
                                                           (|Fraction|
                                                            (|SparseUnivariatePolynomial|
                                                             (ELT $ 7))))
                                                          |curve|)))
            (|compiledLookupCheck| '|map|
                                   (LIST
                                    (LIST '|IntegrationResult|
                                          (|devaluate| (ELT $ 7)))
                                    (LIST '|Mapping| (|devaluate| (ELT $ 7))
                                          (|devaluate| |curve|))
                                    (LIST '|IntegrationResult|
                                          (|devaluate| |curve|)))
                                   (|IntegrationResultFunctions2| |curve|
                                                                  (ELT $
                                                                       7)))))))) 

(SDEFUN |INTAF;rootintegrate!0| ((|x1| NIL) ($$ NIL))
        (PROG ($ |curve| |r1| |t| |k|)
          (LETT $ (QREFELT $$ 4))
          (LETT |curve| (QREFELT $$ 3))
          (LETT |r1| (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT |k| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|INTAF;UPUP2F|
             (SPADCALL |x1|
                       (|compiledLookupCheck| '|lift|
                                              (LIST
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (LIST '|Fraction|
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (|devaluate|
                                                        (ELT $ 7)))))
                                               '$)
                                              |curve|))
             (QCAR |r1|) |t| |k| $))))) 

(SDEFUN |INTAF;algintegrate|
        ((|f| (F)) (|t| (|Kernel| F)) (|k| (|Kernel| F))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|rec_int| (|Mapping| (|IntegrationResult| F) F))
         ($ (|IntegrationResult| F)))
        (SPROG
         ((|curve|
           (|Join|
            (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                     (|SparseUnivariatePolynomial|
                                      (|Fraction|
                                       (|SparseUnivariatePolynomial| F))))
            (CATEGORY |package|
             (SIGNATURE |knownInfBasis| ((|Void|) (|NonNegativeInteger|))))))
          (|f1|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|r1|
           (|Record| (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |poly|
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (|modulus|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |r1|
                (SPADCALL
                 (LETT |modulus|
                       (|INTAF;UP2UPUP|
                        (LETT |p| (SPADCALL |k| (QREFELT $ 24))) |t| $))
                 (QREFELT $ 26)))
          (LETT |f1|
                (SPADCALL (|INTAF;F2UPUP| |f| |t| |k| |p| $)
                          (SPADCALL (SPADCALL (QCAR |r1|) (QREFELT $ 27)) 1
                                    (QREFELT $ 30))
                          (QREFELT $ 31)))
          (LETT |curve|
                (|AlgebraicFunctionField| (QREFELT $ 7)
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))
                                          (|SparseUnivariatePolynomial|
                                           (|Fraction|
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 7))))
                                          (QCDR |r1|)))
          (EXIT
           (SPADCALL
            (CONS #'|INTAF;algintegrate!0| (VECTOR |k| |t| |r1| |curve| $))
            (SPADCALL
             (SPADCALL |f1|
                       (|compiledLookupCheck| '|reduce|
                                              (LIST '$
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (LIST '|Fraction|
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (|devaluate|
                                                             (ELT $ 7))))))
                                              |curve|))
             |derivation| |rec_int|
             (|compiledLookupCheck| '|algintegrate|
                                    (LIST
                                     (LIST '|IntegrationResult|
                                           (|devaluate| |curve|))
                                     (|devaluate| |curve|)
                                     (LIST '|Mapping|
                                           (LIST '|SparseUnivariatePolynomial|
                                                 (|devaluate| (ELT $ 7)))
                                           (LIST '|SparseUnivariatePolynomial|
                                                 (|devaluate| (ELT $ 7))))
                                     (LIST '|Mapping|
                                           (LIST '|IntegrationResult|
                                                 (|devaluate| (ELT $ 7)))
                                           (|devaluate| (ELT $ 7))))
                                    (|AlgebraicIntegrate| (ELT $ 6) (ELT $ 7)
                                                          (|SparseUnivariatePolynomial|
                                                           (ELT $ 7))
                                                          (|SparseUnivariatePolynomial|
                                                           (|Fraction|
                                                            (|SparseUnivariatePolynomial|
                                                             (ELT $ 7))))
                                                          |curve|)))
            (|compiledLookupCheck| '|map|
                                   (LIST
                                    (LIST '|IntegrationResult|
                                          (|devaluate| (ELT $ 7)))
                                    (LIST '|Mapping| (|devaluate| (ELT $ 7))
                                          (|devaluate| |curve|))
                                    (LIST '|IntegrationResult|
                                          (|devaluate| |curve|)))
                                   (|IntegrationResultFunctions2| |curve|
                                                                  (ELT $
                                                                       7)))))))) 

(SDEFUN |INTAF;algintegrate!0| ((|x1| NIL) ($$ NIL))
        (PROG ($ |curve| |r1| |t| |k|)
          (LETT $ (QREFELT $$ 4))
          (LETT |curve| (QREFELT $$ 3))
          (LETT |r1| (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT |k| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|INTAF;UPUP2F|
             (SPADCALL |x1|
                       (|compiledLookupCheck| '|lift|
                                              (LIST
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (LIST '|Fraction|
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (|devaluate|
                                                        (ELT $ 7)))))
                                               '$)
                                              |curve|))
             (QCAR |r1|) |t| |k| $))))) 

(SDEFUN |INTAF;rootcurve|
        ((|lf| (|List| F)) (|t| (|Kernel| F)) (|k| (|Kernel| F))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Record|
           (|:| |funs|
                (|List|
                 (|SparseUnivariatePolynomial|
                  (|Fraction| (|SparseUnivariatePolynomial| F)))))
           (|:| |irec|
                (|Record|
                 (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                 (|:| |poly|
                      (|SparseUnivariatePolynomial|
                       (|Fraction| (|SparseUnivariatePolynomial| F))))))
           (|:| |curve_dom|
                (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                         (|SparseUnivariatePolynomial|
                                          (|Fraction|
                                           (|SparseUnivariatePolynomial|
                                            F))))))))
        (SPROG
         ((|curve|
           (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                    (|SparseUnivariatePolynomial|
                                     (|Fraction|
                                      (|SparseUnivariatePolynomial| F)))))
          (|q| (|SparseUnivariatePolynomial| F))
          (|r|
           (|Record|
            (|:| |radicand| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |deg| (|NonNegativeInteger|))))
          (#1=#:G746 NIL)
          (|lf1|
           (|List|
            (|SparseUnivariatePolynomial|
             (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (#2=#:G751 NIL) (|f| NIL) (#3=#:G750 NIL)
          (|mon1|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|r1|
           (|Record| (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |poly|
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (|modulus|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |r1|
                (SPADCALL
                 (LETT |modulus|
                       (|INTAF;UP2UPUP|
                        (LETT |p| (SPADCALL |k| (QREFELT $ 24))) |t| $))
                 (QREFELT $ 26)))
          (LETT |mon1|
                (SPADCALL (SPADCALL (QCAR |r1|) (QREFELT $ 27)) 1
                          (QREFELT $ 30)))
          (LETT |lf1|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |f| NIL) (LETT #2# |lf|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL (|INTAF;F2UPUP| |f| |t| |k| |p| $)
                                         |mon1| (QREFELT $ 31))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (LETT |r|
                (PROG2 (LETT #1# (SPADCALL (QCDR |r1|) (QREFELT $ 34)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|Record|
                                   (|:| |radicand|
                                        (|Fraction|
                                         (|SparseUnivariatePolynomial|
                                          (QREFELT $ 7))))
                                   (|:| |deg| (|NonNegativeInteger|)))
                                  (|Union|
                                   (|Record|
                                    (|:| |radicand|
                                         (|Fraction|
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))))
                                    (|:| |deg| (|NonNegativeInteger|)))
                                   "failed")
                                  #1#)))
          (LETT |q| (SPADCALL (QCAR |r|) (QREFELT $ 35)))
          (LETT |curve|
                (|RadicalFunctionField| (QREFELT $ 7)
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 7))
                                        (|SparseUnivariatePolynomial|
                                         (|Fraction|
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))))
                                        (SPADCALL |q| (QREFELT $ 36))
                                        (QCDR |r|)))
          (EXIT (VECTOR |lf1| |r1| |curve|))))) 

(SDEFUN |INTAF;algcurve|
        ((|lf| (|List| F)) (|t| (|Kernel| F)) (|k| (|Kernel| F))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Record|
           (|:| |funs|
                (|List|
                 (|SparseUnivariatePolynomial|
                  (|Fraction| (|SparseUnivariatePolynomial| F)))))
           (|:| |irec|
                (|Record|
                 (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                 (|:| |poly|
                      (|SparseUnivariatePolynomial|
                       (|Fraction| (|SparseUnivariatePolynomial| F))))))
           (|:| |curve_dom|
                (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                         (|SparseUnivariatePolynomial|
                                          (|Fraction|
                                           (|SparseUnivariatePolynomial|
                                            F))))))))
        (SPROG
         ((|curve|
           (|Join|
            (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                     (|SparseUnivariatePolynomial|
                                      (|Fraction|
                                       (|SparseUnivariatePolynomial| F))))
            (CATEGORY |package|
             (SIGNATURE |knownInfBasis| ((|Void|) (|NonNegativeInteger|))))))
          (|lf1|
           (|List|
            (|SparseUnivariatePolynomial|
             (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (#1=#:G758 NIL) (|f| NIL) (#2=#:G757 NIL)
          (|mon1|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|r1|
           (|Record| (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |poly|
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (|modulus|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |r1|
                (SPADCALL
                 (LETT |modulus|
                       (|INTAF;UP2UPUP|
                        (LETT |p| (SPADCALL |k| (QREFELT $ 24))) |t| $))
                 (QREFELT $ 26)))
          (LETT |mon1|
                (SPADCALL (SPADCALL (QCAR |r1|) (QREFELT $ 27)) 1
                          (QREFELT $ 30)))
          (LETT |lf1|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (|INTAF;F2UPUP| |f| |t| |k| |p| $)
                                         |mon1| (QREFELT $ 31))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |curve|
                (|AlgebraicFunctionField| (QREFELT $ 7)
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))
                                          (|SparseUnivariatePolynomial|
                                           (|Fraction|
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 7))))
                                          (QCDR |r1|)))
          (EXIT (VECTOR |lf1| |r1| |curve|))))) 

(SDEFUN |INTAF;algextint;2KMMMMLL;8|
        ((|t| (|Kernel| F)) (|y| (|Kernel| F))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|ext|
          (|Mapping|
           (|List|
            (|Record|
             (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coeffs| (|Vector| F))))
           (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
         (|rde|
          (|Mapping|
           (|List|
            (|Record|
             (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coeffs| (|Vector| F))))
           (|Fraction| (|SparseUnivariatePolynomial| F))
           (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G790 NIL) (|be| NIL) (#2=#:G789 NIL)
          (|res1|
           (|List|
            (|Record| (|:| |ratpart| |curve|) (|:| |coeffs| (|Vector| F)))))
          (#3=#:G788 NIL) (|f| NIL) (#4=#:G787 NIL)
          (|cc| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|red|
           (|Mapping| |curve|
                      (|SparseUnivariatePolynomial|
                       (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|curve|
           (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                    (|SparseUnivariatePolynomial|
                                     (|Fraction|
                                      (|SparseUnivariatePolynomial| F)))))
          (|c_rec|
           (|Record|
            (|:| |funs|
                 (|List|
                  (|SparseUnivariatePolynomial|
                   (|Fraction| (|SparseUnivariatePolynomial| F)))))
            (|:| |irec|
                 (|Record|
                  (|:| |coef| (|Fraction| (|SparseUnivariatePolynomial| F)))
                  (|:| |poly|
                       (|SparseUnivariatePolynomial|
                        (|Fraction| (|SparseUnivariatePolynomial| F))))))
            (|:| |curve_dom|
                 (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                          (|SparseUnivariatePolynomial|
                                           (|Fraction|
                                            (|SparseUnivariatePolynomial|
                                             F))))))))
         (SEQ
          (LETT |c_rec|
                (COND
                 ((SPADCALL |y| '|nthRoot| (QREFELT $ 39))
                  (|INTAF;rootcurve| |lg| |t| |y| |der| $))
                 ((SPADCALL |y| '|rootOf| (QREFELT $ 39))
                  (|INTAF;algcurve| |lg| |t| |y| |der| $))
                 ('T (|error| "failed - cannot handle that integrand"))))
          (LETT |curve| (QVELT |c_rec| 2))
          (LETT |red|
                (|compiledLookupCheck| '|reduce|
                                       (LIST '$
                                             (LIST
                                              '|SparseUnivariatePolynomial|
                                              (LIST '|Fraction|
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (|devaluate|
                                                      (ELT $ 7))))))
                                       |curve|))
          (LETT |cc| (QCAR (QVELT |c_rec| 1)))
          (LETT |res1|
                (SPADCALL |der| |ext| |rde| |csolve|
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |f| NIL) (LETT #3# (QVELT |c_rec| 0))
                                G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |f| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #4# (CONS (SPADCALL |f| |red|) #4#))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT (NREVERSE #4#))))
                          (|compiledLookupCheck| '|algextint|
                                                 (LIST
                                                  (LIST '|List|
                                                        (LIST '|Record|
                                                              (LIST '|:|
                                                                    '|ratpart|
                                                                    (|devaluate|
                                                                     |curve|))
                                                              (LIST '|:|
                                                                    '|coeffs|
                                                                    (LIST
                                                                     '|Vector|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           7))))))
                                                  (LIST '|Mapping|
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (|devaluate|
                                                          (ELT $ 7)))
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (|devaluate|
                                                          (ELT $ 7))))
                                                  (LIST '|Mapping|
                                                        (LIST '|List|
                                                              (LIST '|Record|
                                                                    (LIST '|:|
                                                                          '|ratpart|
                                                                          (LIST
                                                                           '|Fraction|
                                                                           (LIST
                                                                            '|SparseUnivariatePolynomial|
                                                                            (|devaluate|
                                                                             (ELT
                                                                              $
                                                                              7)))))
                                                                    (LIST '|:|
                                                                          '|coeffs|
                                                                          (LIST
                                                                           '|Vector|
                                                                           (|devaluate|
                                                                            (ELT
                                                                             $
                                                                             7))))))
                                                        (LIST '|List|
                                                              (LIST '|Fraction|
                                                                    (LIST
                                                                     '|SparseUnivariatePolynomial|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           7))))))
                                                  (LIST '|Mapping|
                                                        (LIST '|List|
                                                              (LIST '|Record|
                                                                    (LIST '|:|
                                                                          '|ratpart|
                                                                          (LIST
                                                                           '|Fraction|
                                                                           (LIST
                                                                            '|SparseUnivariatePolynomial|
                                                                            (|devaluate|
                                                                             (ELT
                                                                              $
                                                                              7)))))
                                                                    (LIST '|:|
                                                                          '|coeffs|
                                                                          (LIST
                                                                           '|Vector|
                                                                           (|devaluate|
                                                                            (ELT
                                                                             $
                                                                             7))))))
                                                        (LIST '|Fraction|
                                                              (LIST
                                                               '|SparseUnivariatePolynomial|
                                                               (|devaluate|
                                                                (ELT $ 7))))
                                                        (LIST '|List|
                                                              (LIST '|Fraction|
                                                                    (LIST
                                                                     '|SparseUnivariatePolynomial|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           7))))))
                                                  (LIST '|Mapping|
                                                        (LIST '|List|
                                                              (LIST '|Vector|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          7))))
                                                        (LIST '|Matrix|
                                                              (|devaluate|
                                                               (ELT $ 7))))
                                                  (LIST '|List|
                                                        (|devaluate| |curve|)))
                                                 (|AlgebraicIntegrate2|
                                                  (ELT $ 6) (ELT $ 7)
                                                  (|SparseUnivariatePolynomial|
                                                   (ELT $ 7))
                                                  (|SparseUnivariatePolynomial|
                                                   (|Fraction|
                                                    (|SparseUnivariatePolynomial|
                                                     (ELT $ 7))))
                                                  |curve|))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |be| NIL) (LETT #1# |res1|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |be| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (CONS
                           (|INTAF;UPUP2F|
                            (SPADCALL (QCAR |be|)
                                      (|compiledLookupCheck| '|lift|
                                                             (LIST
                                                              (LIST
                                                               '|SparseUnivariatePolynomial|
                                                               (LIST
                                                                '|Fraction|
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  (ELT $ 7)))))
                                                              '$)
                                                             |curve|))
                            |cc| |t| |y| $)
                           (QCDR |be|))
                          #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTAF;algextint_base;2KMMLL;9|
        ((|x| (|Kernel| F)) (|y| (|Kernel| F))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G817 NIL) (|be| NIL) (#2=#:G816 NIL)
          (|res1|
           (|List|
            (|Record| (|:| |ratpart| |curve|) (|:| |coeffs| (|Vector| F)))))
          (#3=#:G815 NIL) (|f| NIL) (#4=#:G814 NIL)
          (|red|
           (|Mapping| |curve|
                      (|SparseUnivariatePolynomial|
                       (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|curve|
           (|FunctionFieldCategory| F (|SparseUnivariatePolynomial| F)
                                    (|SparseUnivariatePolynomial|
                                     (|Fraction|
                                      (|SparseUnivariatePolynomial| F)))))
          (|r|
           (|Record|
            (|:| |radicand| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |deg| (|NonNegativeInteger|))))
          (#5=#:G797 NIL)
          (|cv|
           (|Record|
            (|:| |func|
                 (|List|
                  (|SparseUnivariatePolynomial|
                   (|Fraction| (|SparseUnivariatePolynomial| F)))))
            (|:| |poly|
                 (|SparseUnivariatePolynomial|
                  (|Fraction| (|SparseUnivariatePolynomial| F))))
            (|:| |c1| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |c2| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |deg| (|NonNegativeInteger|))))
          (|lg1|
           (|List|
            (|SparseUnivariatePolynomial|
             (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (#6=#:G813 NIL) (|g| NIL) (#7=#:G812 NIL)
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |p| (SPADCALL |y| (QREFELT $ 24)))
              (LETT |lg1|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |g| NIL) (LETT #6# |lg|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |g| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS (|INTAF;F2UPUP| |g| |x| |y| |p| $)
                                        #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |cv|
                    (SPADCALL |lg1| (|INTAF;UP2UPUP| |p| |x| $)
                              (QREFELT $ 51)))
              (LETT |curve|
                    (COND
                     ((SPADCALL |y| '|rootOf| (QREFELT $ 39))
                      (|AlgebraicFunctionField| (QREFELT $ 7)
                                                (|SparseUnivariatePolynomial|
                                                 (QREFELT $ 7))
                                                (|SparseUnivariatePolynomial|
                                                 (|Fraction|
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 7))))
                                                (QVELT |cv| 1)))
                     ((SPADCALL |y| '|nthRoot| (QREFELT $ 39))
                      (SEQ
                       (LETT |r|
                             (PROG2
                                 (LETT #5#
                                       (SPADCALL (QVELT |cv| 1)
                                                 (QREFELT $ 34)))
                                 (QCDR #5#)
                               (|check_union2| (QEQCAR #5# 0)
                                               (|Record|
                                                (|:| |radicand|
                                                     (|Fraction|
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 7))))
                                                (|:| |deg|
                                                     (|NonNegativeInteger|)))
                                               (|Union|
                                                (|Record|
                                                 (|:| |radicand|
                                                      (|Fraction|
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 7))))
                                                 (|:| |deg|
                                                      (|NonNegativeInteger|)))
                                                "failed")
                                               #5#)))
                       (EXIT
                        (|RadicalFunctionField| (QREFELT $ 7)
                                                (|SparseUnivariatePolynomial|
                                                 (QREFELT $ 7))
                                                (|SparseUnivariatePolynomial|
                                                 (|Fraction|
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 7))))
                                                (QCAR |r|) (QCDR |r|)))))
                     ('T (|error| "failed - cannot handle that integrand"))))
              (LETT |red|
                    (|compiledLookupCheck| '|reduce|
                                           (LIST '$
                                                 (LIST
                                                  '|SparseUnivariatePolynomial|
                                                  (LIST '|Fraction|
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (|devaluate|
                                                          (ELT $ 7))))))
                                           |curve|))
              (LETT |res1|
                    (SPADCALL |der| |csolve|
                              (PROGN
                               (LETT #4# NIL)
                               (SEQ (LETT |f| NIL) (LETT #3# (QVELT |cv| 0))
                                    G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |f| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #4#
                                            (CONS (SPADCALL |f| |red|) #4#))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT (NREVERSE #4#))))
                              (|compiledLookupCheck| '|algextint_base|
                                                     (LIST
                                                      (LIST '|List|
                                                            (LIST '|Record|
                                                                  (LIST '|:|
                                                                        '|ratpart|
                                                                        (|devaluate|
                                                                         |curve|))
                                                                  (LIST '|:|
                                                                        '|coeffs|
                                                                        (LIST
                                                                         '|Vector|
                                                                         (|devaluate|
                                                                          (ELT
                                                                           $
                                                                           7))))))
                                                      (LIST '|Mapping|
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (|devaluate|
                                                              (ELT $ 7)))
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (|devaluate|
                                                              (ELT $ 7))))
                                                      (LIST '|Mapping|
                                                            (LIST '|List|
                                                                  (LIST
                                                                   '|Vector|
                                                                   (|devaluate|
                                                                    (ELT $
                                                                         7))))
                                                            (LIST '|Matrix|
                                                                  (|devaluate|
                                                                   (ELT $ 7))))
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |curve|)))
                                                     (|AlgebraicIntegrate2|
                                                      (ELT $ 6) (ELT $ 7)
                                                      (|SparseUnivariatePolynomial|
                                                       (ELT $ 7))
                                                      (|SparseUnivariatePolynomial|
                                                       (|Fraction|
                                                        (|SparseUnivariatePolynomial|
                                                         (ELT $ 7))))
                                                      |curve|))))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |be| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |be| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (CONS
                               (|INTAF;UPUP2F1|
                                (SPADCALL (QCAR |be|)
                                          (|compiledLookupCheck| '|lift|
                                                                 (LIST
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (LIST
                                                                    '|Fraction|
                                                                    (LIST
                                                                     '|SparseUnivariatePolynomial|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           7)))))
                                                                  '$)
                                                                 |curve|))
                                (QVELT |cv| 2) (QVELT |cv| 3) |x| |y| $)
                               (QCDR |be|))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTAF;UP2UPUP|
        ((|p| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (SPROG NIL
               (SPADCALL (CONS #'|INTAF;UP2UPUP!0| (VECTOR $ |k|)) |p|
                         (QREFELT $ 57)))) 

(SDEFUN |INTAF;UP2UPUP!0| ((|x1| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |k| (QREFELT $ 54)))))) 

(SDEFUN |INTAF;UPUP2F|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|cf| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|t| (|Kernel| F)) (|k| (|Kernel| F)) ($ (F)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (CONS #'|INTAF;UPUP2F!0| (VECTOR $ |t|)) |p|
                          (QREFELT $ 18))
                (SPADCALL (SPADCALL |cf| |t| (QREFELT $ 14))
                          (SPADCALL |k| (QREFELT $ 20)) (QREFELT $ 58))
                (QREFELT $ 21)))) 

(SDEFUN |INTAF;UPUP2F!0| ((|x1| NIL) ($$ NIL))
        (PROG (|t| $)
          (LETT |t| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |t| (QREFELT $ 14)))))) 

(SDEFUN |INTAF;algint;F2KMMIr;12|
        ((|f| (F)) (|t| (|Kernel| F)) (|y| (|Kernel| F))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|rec_int| (|Mapping| (|IntegrationResult| F) F))
         ($ (|IntegrationResult| F)))
        (COND
         ((SPADCALL |y| '|nthRoot| (QREFELT $ 39))
          (|INTAF;rootintegrate| |f| |t| |y| |derivation| |rec_int| $))
         ((SPADCALL |y| '|rootOf| (QREFELT $ 39))
          (|INTAF;algintegrate| |f| |t| |y| |derivation| |rec_int| $))
         ('T (|error| "failed - cannot handle that integrand")))) 

(DECLAIM (NOTINLINE |AlgebraicIntegration;|)) 

(DEFUN |AlgebraicIntegration| (&REST #1=#:G835)
  (SPROG NIL
         (PROG (#2=#:G836)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AlgebraicIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AlgebraicIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AlgebraicIntegration|)))))))))) 

(DEFUN |AlgebraicIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|AlgebraicIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 62))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|AlgebraicIntegration|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|AlgebraicIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseUnivariatePolynomial| 9) (|Fraction| 15)
              (|ChangeOfVariable| 7 15 8) (0 . |eval|) (|Kernel| 7)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 12) 12
                                                     6
                                                     (|SparseMultivariatePolynomial|
                                                      6 12)
                                                     7)
              (7 . |multivariate|) (|SparseUnivariatePolynomial| 7)
              (|Mapping| 7 9) (|SparseUnivariatePolynomialFunctions2| 9 7)
              (13 . |map|) (|Kernel| $) (19 . |coerce|) (24 . |elt|)
              (30 . |univariate|) (|SparseUnivariatePolynomial| $)
              (37 . |minPoly|) (|Record| (|:| |coef| 9) (|:| |poly| 8))
              (42 . |mkIntegral|) (47 . |inv|) (52 . |One|)
              (|NonNegativeInteger|) (56 . |monomial|) (62 . |elt|)
              (|Record| (|:| |radicand| 9) (|:| |deg| 29))
              (|Union| 32 '"failed") (68 . |radPoly|) (73 . |retract|)
              (78 . |coerce|) (|Boolean|) (|Symbol|) (83 . |is?|)
              (|Record| (|:| |ratpart| 7) (|:| |coeffs| (|Vector| 7)))
              (|List| 40) (|Mapping| 15 15)
              (|Record| (|:| |ratpart| 9) (|:| |coeffs| (|Vector| 7)))
              (|Mapping| (|List| 43) (|List| 9))
              (|Mapping| (|List| 43) 9 (|List| 9))
              (|Mapping| (|List| (|Vector| 7)) (|Matrix| 7)) (|List| 7)
              |INTAF;algextint;2KMMMMLL;8|
              (|Record| (|:| |func| 50) (|:| |poly| 8) (|:| |c1| 9)
                        (|:| |c2| 9) (|:| |deg| 29))
              (|List| 8) (89 . |chvar|) |INTAF;algextint_base;2KMMLL;9|
              (|Fraction| 23) (95 . |univariate|) (|Mapping| 9 7)
              (|SparseUnivariatePolynomialFunctions2| 7 9) (101 . |map|)
              (107 . *) (|IntegrationResult| 7) (|Mapping| 59 7)
              |INTAF;algint;F2KMMIr;12|)
           '#(|algint| 113 |algextint_base| 122 |algextint| 131) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|algint|
                                 ((|IntegrationResult| |#2|) |#2|
                                  (|Kernel| |#2|) (|Kernel| |#2|)
                                  (|Mapping|
                                   (|SparseUnivariatePolynomial| |#2|)
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|Mapping| (|IntegrationResult| |#2|) |#2|)))
                                T)
                              '((|algextint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  (|Kernel| |#2|) (|Kernel| |#2|)
                                  (|Mapping|
                                   (|SparseUnivariatePolynomial| |#2|)
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|Mapping|
                                   (|List|
                                    (|Record|
                                     (|:| |ratpart|
                                          (|Fraction|
                                           (|SparseUnivariatePolynomial|
                                            |#2|)))
                                     (|:| |coeffs| (|Vector| |#2|))))
                                   (|List|
                                    (|Fraction|
                                     (|SparseUnivariatePolynomial| |#2|))))
                                  (|Mapping|
                                   (|List|
                                    (|Record|
                                     (|:| |ratpart|
                                          (|Fraction|
                                           (|SparseUnivariatePolynomial|
                                            |#2|)))
                                     (|:| |coeffs| (|Vector| |#2|))))
                                   (|Fraction|
                                    (|SparseUnivariatePolynomial| |#2|))
                                   (|List|
                                    (|Fraction|
                                     (|SparseUnivariatePolynomial| |#2|))))
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#2|))
                                  (|List| |#2|)))
                                T)
                              '((|algextint_base|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  (|Kernel| |#2|) (|Kernel| |#2|)
                                  (|Mapping|
                                   (|SparseUnivariatePolynomial| |#2|)
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#2|))
                                  (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 61
                                            '(3 10 8 8 9 9 11 2 13 7 9 12 14 2
                                              17 15 16 8 18 1 7 0 19 20 2 15 7
                                              0 7 21 3 13 15 7 12 15 22 1 7 23
                                              19 24 1 10 25 8 26 1 9 0 0 27 0 6
                                              0 28 2 8 0 9 29 30 2 8 0 0 0 31 1
                                              10 33 8 34 1 9 15 0 35 1 9 0 15
                                              36 2 12 37 0 38 39 2 10 49 50 8
                                              51 2 7 53 0 19 54 2 56 8 55 15 57
                                              2 7 0 0 0 58 5 0 59 7 12 12 42 60
                                              61 5 0 41 12 12 42 46 47 52 7 0
                                              41 12 12 42 44 45 46 47 48)))))
           '|lookupComplete|)) 
