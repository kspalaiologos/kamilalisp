
(SDEFUN |SYSSOLP;makeR2F| ((|r| (R)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (SPADCALL |r| (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |SYSSOLP;makeP2F|
        ((|p| (|Polynomial| (|Fraction| (|Polynomial| R))))
         ($ (|Fraction| (|Polynomial| R))))
        (SPROG ((#1=#:G725 NIL) (|v| NIL) (|lv| (|List| (|Symbol|))))
               (SEQ (LETT |lv| (SPADCALL |p| (QREFELT $ 13)))
                    (EXIT
                     (COND
                      ((SPADCALL |lv| NIL (QREFELT $ 15))
                       (SPADCALL |p| (QREFELT $ 16)))
                      ('T
                       (SEQ
                        (SEQ (LETT |v| NIL) (LETT #1# |lv|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |p| (SPADCALL |p| |v| (QREFELT $ 19)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (SPADCALL |p| (QREFELT $ 16)))))))))) 

(SDEFUN |SYSSOLP;makeEq|
        ((|p| (|Polynomial| (|Fraction| (|Polynomial| R))))
         (|lv| (|List| (|Symbol|)))
         ($ (|Equation| (|Fraction| (|Polynomial| R)))))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| (|Polynomial| R)))
          (#1=#:G733 NIL) (#2=#:G734 NIL) (|x| NIL) (|lx| (|List| (|Symbol|)))
          (|np| (|Polynomial| R)))
         (SEQ (LETT |np| (SPADCALL (|SYSSOLP;makeP2F| |p| $) (QREFELT $ 20)))
              (LETT |lx| (SPADCALL |np| (QREFELT $ 21)))
              (SEQ
               (EXIT
                (SEQ (LETT |x| NIL) (LETT #2# |lv|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |x| |lx| (QREFELT $ 22))
                         (PROGN (LETT #1# 1) (GO #3=#:G728))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL)))
               #3# (EXIT #1#))
              (LETT |up| (SPADCALL |np| |x| (QREFELT $ 24)))
              (EXIT
               (COND
                ((EQL (SPADCALL |up| (QREFELT $ 27)) 1)
                 (SPADCALL
                  (SPADCALL (SPADCALL |x| (QREFELT $ 29)) (QREFELT $ 10))
                  (SPADCALL
                   (SPADCALL (SPADCALL |up| 0 (QREFELT $ 32))
                             (SPADCALL |up| (QREFELT $ 33)) (QREFELT $ 34))
                   (QREFELT $ 35))
                  (QREFELT $ 37)))
                ('T
                 (SPADCALL (SPADCALL |np| (QREFELT $ 10)) (|spadConstant| $ 31)
                           (QREFELT $ 37)))))))) 

(SDEFUN |SYSSOLP;varInF| ((|v| (|Symbol|)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (SPADCALL |v| (QREFELT $ 29)) (QREFELT $ 10))) 

(SDEFUN |SYSSOLP;newInF| ((|n| (|Integer|)) ($ (|Fraction| (|Polynomial| R))))
        (|SYSSOLP;varInF| (SPADCALL (QREFELT $ 38)) $)) 

(SDEFUN |SYSSOLP;testDegree|
        ((|f| (|Polynomial| R)) (|lv| (|List| (|Symbol|))) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G745 NIL) (#2=#:G744 #3=(|Boolean|)) (#4=#:G746 #3#)
          (#5=#:G748 NIL) (|vv| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |vv| NIL) (LETT #5# |lv|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |vv| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (> (SPADCALL |f| |vv| (QREFELT $ 39)) 0))
                   (COND (#1# (LETT #2# (COND (#2# 'T) ('T #4#))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T NIL)))))) 

(SDEFUN |SYSSOLP;triangularSystems;LLL;7|
        ((|lf| (|List| (|Fraction| (|Polynomial| R))))
         (|lv| (|List| (|Symbol|))) ($ (|List| (|List| (|Polynomial| R)))))
        (SPROG
         ((#1=#:G803 NIL) (|pf| NIL) (#2=#:G802 NIL) (#3=#:G801 NIL) (|pr| NIL)
          (#4=#:G800 NIL)
          (|parRes|
           (|List|
            (|List|
             (|DistributedMultivariatePolynomial| |lv| (|Polynomial| R)))))
          (#5=#:G775 NIL) (#6=#:G774 #7=(|Boolean|)) (#8=#:G776 #7#)
          (#9=#:G799 NIL) (|fq| NIL) (#10=#:G798 NIL) (#11=#:G797 NIL)
          (|gb|
           (CATEGORY |package|
            (SIGNATURE |credPol| (|dmp| |dmp| (|List| |dmp|)))
            (SIGNATURE |redPol| (|dmp| |dmp| (|List| |dmp|)))
            (SIGNATURE |gbasis|
             ((|List| |dmp|) (|List| |dmp|) (|Integer|) (|Integer|)))
            (SIGNATURE |gbasisExtend|
             ((|List| |dmp|) (|List| |dmp|) (|List| |dmp|) (|Integer|)
              (|Integer|)))
            (SIGNATURE |critT|
             ((|Boolean|)
              (|Record|
               (|:| |lcmfij|
                    #12=(|DirectProduct| (|call| LENGTH |lv|)
                                         (|NonNegativeInteger|)))
               (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |dmp|)
               (|:| |polj| |dmp|))))
            (SIGNATURE |critM| ((|Boolean|) #12# #12#))
            (SIGNATURE |critB| ((|Boolean|) #12# #12# #12# #12#))
            (SIGNATURE |critBonD|
             ((|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              |dmp|
              (|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |critMTonD1|
             ((|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              (|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |critMonD1|
             ((|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              #12#
              (|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |redPo|
             ((|Record| (|:| |poly| |dmp|) (|:| |mult| (|Polynomial| R))) |dmp|
              (|List| |dmp|)))
            (SIGNATURE |hMonic| (|dmp| |dmp|))
            (SIGNATURE |updatF|
             ((|List|
               (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |pol| |dmp|)))
              |dmp| (|NonNegativeInteger|)
              (|List|
               (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |pol| |dmp|)))))
            (SIGNATURE |sPol|
             (|dmp|
              (|Record| (|:| |lcmfij| #12#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))))
            (SIGNATURE |updatD|
             ((|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              (|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              (|List|
               (|Record| (|:| |lcmfij| #12#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |minGbasis| ((|List| |dmp|) (|List| |dmp|)))
            (SIGNATURE |lepol| ((|Integer|) |dmp|))
            (SIGNATURE |prinshINFO| ((|Void|) |dmp|))
            (SIGNATURE |prindINFO|
             ((|Integer|)
              (|Record| (|:| |lcmfij| #12#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              |dmp| |dmp| (|Integer|) (|Integer|) (|Integer|)))
            (SIGNATURE |fprindINFO|
             ((|Integer|)
              (|Record| (|:| |lcmfij| #12#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              |dmp| |dmp| (|Integer|) (|Integer|) (|Integer|) (|Integer|)))
            (SIGNATURE |prinpolINFO| ((|Void|) (|List| |dmp|)))
            (SIGNATURE |prinb| ((|Void|) (|Integer|)))
            (SIGNATURE |critpOrder|
             ((|Boolean|)
              (|Record| (|:| |lcmfij| #12#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              (|Record| (|:| |lcmfij| #12#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))))
            (SIGNATURE |makeCrit|
             ((|Record| (|:| |lcmfij| #12#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |pol| |dmp|))
              |dmp| (|NonNegativeInteger|)))
            (SIGNATURE |virtualDegree| ((|NonNegativeInteger|) |dmp|))))
          (|lp| (|List| |dmp|)) (#13=#:G796 NIL) (|f| NIL) (#14=#:G795 NIL)
          (|lq| (|List| |dmp|)) (|df| (|Polynomial| R)) (#15=#:G794 NIL)
          (#16=#:G793 NIL) (|lvv| (|List| OV)) (#17=#:G766 NIL)
          (#18=#:G792 NIL) (|vv| NIL) (#19=#:G791 NIL)
          (|push|
           (CATEGORY |package| (SIGNATURE |pushdown| (|dmp| |dmp| (|List| OV)))
            (SIGNATURE |pushup| (|dmp| |dmp| (|List| OV)))
            (SIGNATURE |map|
             (|dmp| (|Mapping| |dmp| (|Polynomial| R)) |dmp|))))
          (DP
           (|DirectProductCategory| (|call| LENGTH |lv|)
                                    (|NonNegativeInteger|)))
          (OV
           (|Join| (|OrderedFinite|) (|ConvertibleTo| (|Symbol|))
                   (|ConvertibleTo| (|InputForm|))
                   (|ConvertibleTo| (|Pattern| (|Float|)))
                   (|ConvertibleTo| (|Pattern| (|Integer|)))
                   (CATEGORY |domain|
                    (SIGNATURE |variable| ((|Union| $ "failed") (|Symbol|))))))
          (|dmp|
           (|Join|
            (|PolynomialCategory| (|Polynomial| R)
                                  (|DirectProduct| (|#| |lv|)
                                                   (|NonNegativeInteger|))
                                  (|OrderedVariableList| |lv|))
            (CATEGORY |domain|
             (SIGNATURE |reorder| ($ $ (|List| (|Integer|)))))))
          (#20=#:G790 NIL) (|ff| NIL) (#21=#:G789 NIL)
          (|fp| (|Factored| (|Polynomial| R))) (|p| (|Polynomial| R)))
         (SEQ
          (COND ((OR (NULL |lv|) (NULL |lf|)) NIL)
                ((EQL (LENGTH |lf|) 1)
                 (SEQ (LETT |p| (SPADCALL (|SPADfirst| |lf|) (QREFELT $ 20)))
                      (LETT |fp| (SPADCALL |p| (QREFELT $ 42)))
                      (EXIT
                       (PROGN
                        (LETT #21# NIL)
                        (SEQ (LETT |ff| NIL)
                             (LETT #20# (SPADCALL |fp| (QREFELT $ 46))) G190
                             (COND
                              ((OR (ATOM #20#)
                                   (PROGN (LETT |ff| (CAR #20#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((|SYSSOLP;testDegree| (QVELT |ff| 1) |lv| $)
                                 (LETT #21#
                                       (CONS (LIST (QVELT |ff| 1)) #21#))))))
                             (LETT #20# (CDR #20#)) (GO G190) G191
                             (EXIT (NREVERSE #21#)))))))
                (#22='T
                 (SEQ
                  (LETT |dmp|
                        (|DistributedMultivariatePolynomial| |lv|
                                                             (|Polynomial|
                                                              (QREFELT $ 6))))
                  (LETT OV (|OrderedVariableList| |lv|))
                  (LETT DP
                        (|DirectProduct| (LENGTH |lv|) (|NonNegativeInteger|)))
                  (LETT |push| (|PushVariables| (QREFELT $ 6) DP OV |dmp|))
                  (LETT |lvv|
                        (PROGN
                         (LETT #19# NIL)
                         (SEQ (LETT |vv| NIL) (LETT #18# |lv|) G190
                              (COND
                               ((OR (ATOM #18#)
                                    (PROGN (LETT |vv| (CAR #18#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #19#
                                      (CONS
                                       (PROG2
                                           (LETT #17#
                                                 (SPADCALL |vv|
                                                           (|compiledLookupCheck|
                                                            '|variable|
                                                            (LIST
                                                             (LIST '|Union| '$
                                                                   '#23="failed")
                                                             (LIST '|Symbol|))
                                                            OV)))
                                           (QCDR #17#)
                                         (|check_union2| (QEQCAR #17# 0) OV
                                                         (|Union| OV #23#)
                                                         #17#))
                                       #19#))))
                              (LETT #18# (CDR #18#)) (GO G190) G191
                              (EXIT (NREVERSE #19#)))))
                  (LETT |lq|
                        (PROGN
                         (LETT #16# NIL)
                         (SEQ (LETT |f| NIL) (LETT #15# |lf|) G190
                              (COND
                               ((OR (ATOM #15#)
                                    (PROGN (LETT |f| (CAR #15#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (LETT |df| (SPADCALL |f| (QREFELT $ 47)))
                                   (|spadConstant| $ 48) (QREFELT $ 49))
                                  (LETT #16#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |df|
                                                    (|compiledLookupCheck|
                                                     '|coerce|
                                                     (LIST '$
                                                           (LIST '|Polynomial|
                                                                 (|devaluate|
                                                                  (ELT $ 6))))
                                                     |dmp|))
                                          |lvv|
                                          (|compiledLookupCheck| '|pushup|
                                                                 (LIST
                                                                  (|devaluate|
                                                                   |dmp|)
                                                                  (|devaluate|
                                                                   |dmp|)
                                                                  (LIST '|List|
                                                                        (|devaluate|
                                                                         OV)))
                                                                 |push|))
                                         #16#))))))
                              (LETT #15# (CDR #15#)) (GO G190) G191
                              (EXIT (NREVERSE #16#)))))
                  (LETT |lp|
                        (PROGN
                         (LETT #14# NIL)
                         (SEQ (LETT |f| NIL) (LETT #13# |lf|) G190
                              (COND
                               ((OR (ATOM #13#)
                                    (PROGN (LETT |f| (CAR #13#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #14#
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL (SPADCALL |f| (QREFELT $ 20))
                                                  (|compiledLookupCheck|
                                                   '|coerce|
                                                   (LIST '$
                                                         (LIST '|Polynomial|
                                                               (|devaluate|
                                                                (ELT $ 6))))
                                                   |dmp|))
                                        |lvv|
                                        (|compiledLookupCheck| '|pushup|
                                                               (LIST
                                                                (|devaluate|
                                                                 |dmp|)
                                                                (|devaluate|
                                                                 |dmp|)
                                                                (LIST '|List|
                                                                      (|devaluate|
                                                                       OV)))
                                                               |push|))
                                       #14#))))
                              (LETT #13# (CDR #13#)) (GO G190) G191
                              (EXIT (NREVERSE #14#)))))
                  (LETT |parRes|
                        (SPADCALL |lp| |lvv|
                                  (|compiledLookupCheck| '|groebSolve|
                                                         (LIST
                                                          (LIST '|List|
                                                                (LIST '|List|
                                                                      (LIST
                                                                       '|DistributedMultivariatePolynomial|
                                                                       |lv|
                                                                       (LIST
                                                                        '|Polynomial|
                                                                        (|devaluate|
                                                                         (ELT $
                                                                              6))))))
                                                          (LIST '|List|
                                                                (LIST
                                                                 '|DistributedMultivariatePolynomial|
                                                                 |lv|
                                                                 (LIST
                                                                  '|Polynomial|
                                                                  (|devaluate|
                                                                   (ELT $
                                                                        6)))))
                                                          (LIST '|List|
                                                                (LIST
                                                                 '|OrderedVariableList|
                                                                 |lv|)))
                                                         (|GroebnerSolve| |lv|
                                                                          (|Polynomial|
                                                                           (ELT
                                                                            $
                                                                            6))
                                                                          (ELT
                                                                           $
                                                                           6)))))
                  (COND
                   ((SPADCALL |lq| NIL
                              (|compiledLookupCheck| '~=
                                                     (LIST (LIST '|Boolean|) '$
                                                           '$)
                                                     (|List| |dmp|)))
                    (SEQ
                     (LETT |gb|
                           (|GroebnerInternalPackage|
                            (|Polynomial| (QREFELT $ 6))
                            (|DirectProduct| (LENGTH |lv|)
                                             (|NonNegativeInteger|))
                            |dmp|))
                     (EXIT
                      (LETT |parRes|
                            (PROGN
                             (LETT #11# NIL)
                             (SEQ (LETT |pr| NIL) (LETT #10# |parRes|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |pr| (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |fq| NIL) (LETT #9# |lq|)
                                            G190
                                            (COND
                                             ((OR (ATOM #9#)
                                                  (PROGN
                                                   (LETT |fq| (CAR #9#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (PROGN
                                               (LETT #8#
                                                     (SPADCALL
                                                      (SPADCALL |fq| |pr|
                                                                (|compiledLookupCheck|
                                                                 '|redPol|
                                                                 (LIST
                                                                  (|devaluate|
                                                                   |dmp|)
                                                                  (|devaluate|
                                                                   |dmp|)
                                                                  (LIST '|List|
                                                                        (|devaluate|
                                                                         |dmp|)))
                                                                 |gb|))
                                                      (SPADCALL
                                                       (|compiledLookupCheck|
                                                        '|Zero| (LIST '$)
                                                        |dmp|))
                                                      (|compiledLookupCheck|
                                                       '~=
                                                       (LIST (LIST '|Boolean|)
                                                             '$ '$)
                                                       |dmp|)))
                                               (COND
                                                (#5#
                                                 (LETT #6#
                                                       (COND (#6# #8#)
                                                             ('T NIL))))
                                                ('T
                                                 (PROGN
                                                  (LETT #6# #8#)
                                                  (LETT #5# 'T)))))))
                                            (LETT #9# (CDR #9#)) (GO G190) G191
                                            (EXIT NIL))
                                       (COND (#5# #6#) (#22# 'T)))
                                      (LETT #11# (CONS |pr| #11#))))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT (NREVERSE #11#)))))))))
                  (EXIT
                   (PROGN
                    (LETT #4# NIL)
                    (SEQ (LETT |pr| NIL) (LETT #3# |parRes|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |pr| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #4#
                                 (CONS
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |pf| NIL) (LETT #1# |pr|) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN
                                               (LETT |pf| (CAR #1#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL
                                                  (SPADCALL |pf| |lvv|
                                                            (|compiledLookupCheck|
                                                             '|pushdown|
                                                             (LIST
                                                              (|devaluate|
                                                               |dmp|)
                                                              (|devaluate|
                                                               |dmp|)
                                                              (LIST '|List|
                                                                    (|devaluate|
                                                                     OV)))
                                                             |push|))
                                                  (|compiledLookupCheck|
                                                   '|retract|
                                                   (LIST
                                                    (LIST '|Polynomial|
                                                          (|devaluate|
                                                           (ELT $ 6)))
                                                    '$)
                                                   |dmp|))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#))))
                                  #4#))))
                         (LETT #3# (CDR #3#)) (GO G190) G191
                         (EXIT (NREVERSE #4#))))))))))) 

(SDEFUN |SYSSOLP;solve;FL;8|
        ((|pol| (|Fraction| (|Polynomial| R)))
         ($ (|List| (|Equation| (|Fraction| (|Polynomial| R))))))
        (SPROG ((|lv| (|List| (|Symbol|))))
               (SEQ
                (COND
                 ((SPADCALL |pol| (QREFELT $ 53))
                  (|error| "equation is always satisfied"))
                 (#1='T
                  (SEQ
                   (LETT |lv|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |pol| (QREFELT $ 20))
                                     (QREFELT $ 21))
                           (SPADCALL (SPADCALL |pol| (QREFELT $ 47))
                                     (QREFELT $ 21))
                           (QREFELT $ 54))
                          (QREFELT $ 55)))
                   (EXIT
                    (COND ((NULL |lv|) (|error| "inconsistent equation"))
                          ((> (LENGTH |lv|) 1) (|error| "too many variables"))
                          (#1#
                           (SPADCALL |pol| (|SPADfirst| |lv|)
                                     (QREFELT $ 57))))))))))) 

(SDEFUN |SYSSOLP;solve;EL;9|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| R))))
         ($ (|List| (|Equation| (|Fraction| (|Polynomial| R))))))
        (SPROG
         ((|lv| (|List| (|Symbol|))) (|pol| (|Fraction| (|Polynomial| R))))
         (SEQ
          (LETT |pol|
                (SPADCALL (SPADCALL |eq| (QREFELT $ 59))
                          (SPADCALL |eq| (QREFELT $ 60)) (QREFELT $ 61)))
          (EXIT
           (COND
            ((SPADCALL |pol| (QREFELT $ 53))
             (|error| "equation is always satisfied"))
            (#1='T
             (SEQ
              (LETT |lv|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |pol| (QREFELT $ 20)) (QREFELT $ 21))
                      (SPADCALL (SPADCALL |pol| (QREFELT $ 47)) (QREFELT $ 21))
                      (QREFELT $ 54))
                     (QREFELT $ 55)))
              (EXIT
               (COND ((NULL |lv|) (|error| "inconsistent equation"))
                     ((> (LENGTH |lv|) 1) (|error| "too many variables"))
                     (#1#
                      (SPADCALL |pol| (|SPADfirst| |lv|)
                                (QREFELT $ 57)))))))))))) 

(SDEFUN |SYSSOLP;solve;ESL;10|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| R)))) (|var| (|Symbol|))
         ($ (|List| (|Equation| (|Fraction| (|Polynomial| R))))))
        (SPADCALL
         (SPADCALL (SPADCALL |eq| (QREFELT $ 59))
                   (SPADCALL |eq| (QREFELT $ 60)) (QREFELT $ 61))
         |var| (QREFELT $ 57))) 

(SDEFUN |SYSSOLP;solve;FSL;11|
        ((|pol| (|Fraction| (|Polynomial| R))) (|var| (|Symbol|))
         ($ (|List| (|Equation| (|Fraction| (|Polynomial| R))))))
        (SPROG
         ((#1=#:G828 NIL) (|ff| NIL) (#2=#:G827 NIL)
          (|fp| (|Factored| (|Polynomial| R))) (|p| (|Polynomial| R)))
         (SEQ
          (COND
           ((|HasCategory| (QREFELT $ 6) '(|GcdDomain|))
            (SEQ
             (LETT |p|
                   (SPADCALL (SPADCALL |pol| (QREFELT $ 20)) |var|
                             (QREFELT $ 64)))
             (LETT |fp| (SPADCALL |p| (QREFELT $ 42)))
             (EXIT
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |ff| NIL) (LETT #1# (SPADCALL |fp| (QREFELT $ 46)))
                    G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |ff| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #2#
                            (CONS
                             (|SYSSOLP;makeEq|
                              (SPADCALL (CONS (|function| |SYSSOLP;makeR2F|) $)
                                        (QVELT |ff| 1) (QREFELT $ 67))
                              (LIST |var|) $)
                             #2#))))
                    (LETT #1# (CDR #1#)) (GO G190) G191
                    (EXIT (NREVERSE #2#)))))))
           ('T NIL))))) 

(SDEFUN |SYSSOLP;makePolys|
        ((|l| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
         ($ (|List| (|Fraction| (|Polynomial| R)))))
        (SPROG ((#1=#:G833 NIL) (|e| NIL) (#2=#:G832 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |e| (QREFELT $ 59))
                                         (SPADCALL |e| (QREFELT $ 60))
                                         (QREFELT $ 61))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SYSSOLP;linSolve|
        ((|lp| (|List| (|Fraction| (|Polynomial| R))))
         (|lv| (|List| (|Symbol|)))
         ($
          (|Union| (|List| (|Equation| (|Fraction| (|Polynomial| R))))
                   "failed")))
        (SPROG
         ((|eqs| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
          (#1=#:G857 NIL) (|i| NIL) (#2=#:G856 NIL)
          (|sym| (|Fraction| (|Polynomial| R))) (#3=#:G855 NIL) (|p| NIL)
          (|zeron| (|Vector| (|Fraction| (|Polynomial| R))))
          (|rhs| (|Vector| (|Fraction| (|Polynomial| R)))) (#4=#:G841 NIL)
          (|rec|
           (|Record|
            (|:| |particular|
                 (|Union| (|Vector| (|Fraction| (|Polynomial| R))) "failed"))
            (|:| |basis| (|List| (|Vector| (|Fraction| (|Polynomial| R)))))))
          (|lr| (|List| (|Polynomial| R))) (#5=#:G854 NIL) (|f| NIL)
          (#6=#:G853 NIL))
         (SEQ
          (LETT |lr|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |f| NIL) (LETT #5# |lp|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6# (CONS (SPADCALL |f| (QREFELT $ 20)) #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |rec| (SPADCALL |lr| |lv| (QREFELT $ 72)))
          (EXIT
           (COND ((QEQCAR (QCAR |rec|) 1) (CONS 1 "failed"))
                 ('T
                  (SEQ
                   (LETT |rhs|
                         (PROG2 (LETT #4# (QCAR |rec|))
                             (QCDR #4#)
                           (|check_union2| (QEQCAR #4# 0)
                                           (|Vector|
                                            (|Fraction|
                                             (|Polynomial| (QREFELT $ 6))))
                                           (|Union|
                                            (|Vector|
                                             (|Fraction|
                                              (|Polynomial| (QREFELT $ 6))))
                                            "failed")
                                           #4#)))
                   (LETT |zeron| (SPADCALL (LENGTH |lv|) (QREFELT $ 74)))
                   (SEQ (LETT |p| NIL) (LETT #3# (QCDR |rec|)) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL |p| |zeron| (QREFELT $ 75))
                            (SEQ (LETT |sym| (|SYSSOLP;newInF| 1 $))
                                 (EXIT
                                  (SEQ (LETT |i| 1) (LETT #2# (LENGTH |lv|))
                                       G190
                                       (COND
                                        ((|greater_SI| |i| #2#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SPADCALL |rhs| |i|
                                                   (SPADCALL
                                                    (SPADCALL |rhs| |i|
                                                              (QREFELT $ 77))
                                                    (SPADCALL |sym|
                                                              (SPADCALL |p| |i|
                                                                        (QREFELT
                                                                         $ 77))
                                                              (QREFELT $ 78))
                                                    (QREFELT $ 79))
                                                   (QREFELT $ 80))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT NIL))))))))
                        (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                   (LETT |eqs| NIL)
                   (SEQ (LETT |i| 1) (LETT #1# (LENGTH |lv|)) G190
                        (COND ((|greater_SI| |i| #1#) (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |eqs|
                                (SPADCALL |eqs|
                                          (LIST
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |lv| |i|
                                                        (QREFELT $ 81))
                                              (QREFELT $ 29))
                                             (QREFELT $ 10))
                                            (SPADCALL |rhs| |i| (QREFELT $ 77))
                                            (QREFELT $ 82)))
                                          (QREFELT $ 83)))))
                        (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                   (EXIT (CONS 0 |eqs|))))))))) 

(SDEFUN |SYSSOLP;solve;LL;14|
        ((|lr| (|List| (|Fraction| (|Polynomial| R))))
         ($ (|List| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))))
        (SPROG
         ((|lv| #1=(|List| (|Symbol|))) (#2=#:G859 NIL) (#3=#:G858 #1#)
          (#4=#:G860 #1#) (#5=#:G863 NIL) (|p| NIL))
         (SEQ
          (LETT |lv|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |p| NIL) (LETT #5# |lr|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4#
                               (SPADCALL
                                (SPADCALL (SPADCALL |p| (QREFELT $ 20))
                                          (QREFELT $ 21))
                                (SPADCALL (SPADCALL |p| (QREFELT $ 47))
                                          (QREFELT $ 21))
                                (QREFELT $ 84)))
                         (COND
                          (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 84))))
                          ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (COND (#2# #3#) ('T (|IdentityError| '|setUnion|)))))
          (EXIT (SPADCALL |lr| |lv| (QREFELT $ 86)))))) 

(SDEFUN |SYSSOLP;solve;LL;15|
        ((|le| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
         ($ (|List| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))))
        (SPROG
         ((|lv| #1=(|List| (|Symbol|))) (#2=#:G865 NIL) (#3=#:G864 #1#)
          (#4=#:G866 #1#) (#5=#:G869 NIL) (|p| NIL)
          (|lr| (|List| (|Fraction| (|Polynomial| R)))))
         (SEQ (LETT |lr| (|SYSSOLP;makePolys| |le| $))
              (LETT |lv|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |p| NIL) (LETT #5# |lr|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |p| (QREFELT $ 20))
                                              (QREFELT $ 21))
                                    (SPADCALL (SPADCALL |p| (QREFELT $ 47))
                                              (QREFELT $ 21))
                                    (QREFELT $ 84)))
                             (COND
                              (#2#
                               (LETT #3# (SPADCALL #3# #4# (QREFELT $ 84))))
                              ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#2# #3#) ('T (|IdentityError| '|setUnion|)))))
              (EXIT (SPADCALL |lr| |lv| (QREFELT $ 86)))))) 

(SDEFUN |SYSSOLP;solve;LLL;16|
        ((|le| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
         (|lv| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))))
        (SPADCALL (|SYSSOLP;makePolys| |le| $) |lv| (QREFELT $ 86))) 

(SDEFUN |SYSSOLP;checkLinear|
        ((|lr| (|List| (|Fraction| (|Polynomial| R))))
         (|vl| (|List| (|Symbol|))) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G880 NIL) (#2=#:G879 #3=(|Boolean|)) (#4=#:G881 #3#)
          (#5=#:G890 NIL) (|pol| NIL) (#6=#:G885 NIL) (#7=#:G875 NIL)
          (#8=#:G874 #9=(|Boolean|)) (#10=#:G876 #9#) (#11=#:G889 NIL)
          (|x| NIL) (#12=#:G888 NIL) (|f| NIL) (|ld| (|List| (|Polynomial| R)))
          (#13=#:G887 NIL) (#14=#:G886 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ld|
                  (PROGN
                   (LETT #14# NIL)
                   (SEQ (LETT |pol| NIL) (LETT #13# |lr|) G190
                        (COND
                         ((OR (ATOM #13#) (PROGN (LETT |pol| (CAR #13#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #14#
                                (CONS (SPADCALL |pol| (QREFELT $ 47)) #14#))))
                        (LETT #13# (CDR #13#)) (GO G190) G191
                        (EXIT (NREVERSE #14#)))))
            (SEQ (LETT |f| NIL) (LETT #12# |ld|) G190
                 (COND
                  ((OR (ATOM #12#) (PROGN (LETT |f| (CAR #12#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((PROGN
                      (LETT #7# NIL)
                      (SEQ (LETT |x| NIL)
                           (LETT #11# (SPADCALL |f| (QREFELT $ 21))) G190
                           (COND
                            ((OR (ATOM #11#) (PROGN (LETT |x| (CAR #11#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #10# (SPADCALL |x| |vl| (QREFELT $ 22)))
                              (COND (#7# (LETT #8# (COND (#8# 'T) ('T #10#))))
                                    ('T
                                     (PROGN (LETT #8# #10#) (LETT #7# 'T)))))))
                           (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                      (COND (#7# #8#) ('T NIL)))
                     (PROGN (LETT #6# NIL) (GO #15=#:G884))))))
                 (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
            (EXIT
             (PROGN
              (LETT #1# NIL)
              (SEQ (LETT |pol| NIL) (LETT #5# |lr|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |pol| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (LETT #4#
                            (<
                             (SPADCALL (SPADCALL |pol| (QREFELT $ 20)) |vl|
                                       (QREFELT $ 90))
                             2))
                      (COND (#1# (LETT #2# (COND (#2# #4#) ('T NIL))))
                            ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (COND (#1# #2#) ('T 'T))))))
          #15# (EXIT #6#)))) 

(SDEFUN |SYSSOLP;solve;LLL;18|
        ((|lr| (|List| (|Fraction| (|Polynomial| R))))
         (|vl| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))))
        (SPROG
         ((#1=#:G909 NIL) (|f| NIL) (#2=#:G908 NIL) (#3=#:G907 NIL) (|pr| NIL)
          (#4=#:G906 NIL) (|parRes| (|List| (|List| (|Polynomial| R))))
          (|eqns| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
          (|rhs| (|Fraction| (|Polynomial| R)))
          (|lhs| (|Fraction| (|Polynomial| R))) (#5=#:G905 NIL) (|i| NIL)
          (|soln|
           (|Union| (|List| (|Equation| (|Fraction| (|Polynomial| R))))
                    "failed")))
         (SEQ
          (COND ((NULL |vl|) NIL)
                ((|SYSSOLP;checkLinear| |lr| |vl| $)
                 (SEQ (LETT |soln| (|SYSSOLP;linSolve| |lr| |vl| $))
                      (EXIT
                       (COND ((QEQCAR |soln| 1) NIL)
                             (#6='T
                              (SEQ (LETT |eqns| NIL)
                                   (SEQ (LETT |i| 1) (LETT #5# (LENGTH |vl|))
                                        G190
                                        (COND
                                         ((|greater_SI| |i| #5#) (GO G191)))
                                        (SEQ
                                         (LETT |lhs|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |vl| |i|
                                                           (QREFELT $ 81))
                                                 (QREFELT $ 29))
                                                (QREFELT $ 10)))
                                         (LETT |rhs|
                                               (SPADCALL
                                                (SPADCALL (QCDR |soln|) |i|
                                                          (QREFELT $ 91))
                                                (QREFELT $ 60)))
                                         (EXIT
                                          (LETT |eqns|
                                                (SPADCALL |eqns|
                                                          (LIST
                                                           (SPADCALL |lhs|
                                                                     |rhs|
                                                                     (QREFELT $
                                                                              82)))
                                                          (QREFELT $ 83)))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))
                                   (EXIT (LIST |eqns|))))))))
                ((|HasCategory| (QREFELT $ 6) '(|GcdDomain|))
                 (SEQ (LETT |parRes| (SPADCALL |lr| |vl| (QREFELT $ 52)))
                      (EXIT
                       (PROGN
                        (LETT #4# NIL)
                        (SEQ (LETT |pr| NIL) (LETT #3# |parRes|) G190
                             (COND
                              ((OR (ATOM #3#)
                                   (PROGN (LETT |pr| (CAR #3#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #4#
                                     (CONS
                                      (PROGN
                                       (LETT #2# NIL)
                                       (SEQ (LETT |f| NIL) (LETT #1# |pr|) G190
                                            (COND
                                             ((OR (ATOM #1#)
                                                  (PROGN
                                                   (LETT |f| (CAR #1#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #2#
                                                    (CONS
                                                     (|SYSSOLP;makeEq|
                                                      (SPADCALL
                                                       (CONS
                                                        (|function|
                                                         |SYSSOLP;makeR2F|)
                                                        $)
                                                       |f| (QREFELT $ 67))
                                                      |vl| $)
                                                     #2#))))
                                            (LETT #1# (CDR #1#)) (GO G190) G191
                                            (EXIT (NREVERSE #2#))))
                                      #4#))))
                             (LETT #3# (CDR #3#)) (GO G190) G191
                             (EXIT (NREVERSE #4#)))))))
                (#6# (LIST NIL)))))) 

(DECLAIM (NOTINLINE |SystemSolvePackage;|)) 

(DEFUN |SystemSolvePackage| (#1=#:G910)
  (SPROG NIL
         (PROG (#2=#:G911)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|SystemSolvePackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|SystemSolvePackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|SystemSolvePackage|)))))))))) 

(DEFUN |SystemSolvePackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|SystemSolvePackage| DV$1))
          (LETT $ (GETREFV 92))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SystemSolvePackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SystemSolvePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Polynomial| 6)
              (0 . |coerce|) (|Fraction| 7) (5 . |coerce|) (|List| 17)
              (|Polynomial| 9) (10 . |variables|) (|Boolean|) (15 . =)
              (21 . |retract|) (|Symbol|)
              (|MPolyCatRationalFunctionFactorizer| (|IndexedExponents| 17) 17
                                                    6 12)
              (26 . |pushdown|) (32 . |numer|) (37 . |variables|)
              (42 . |member?|) (|SparseUnivariatePolynomial| $)
              (48 . |univariate|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 7) (54 . |degree|) (59 . |One|)
              (63 . |coerce|) (68 . |Zero|) (72 . |Zero|) (76 . |coefficient|)
              (82 . |leadingCoefficient|) (87 . /) (93 . -) (|Equation| 9)
              (98 . |equation|) (104 . |new|) (108 . |degree|) (|Factored| 7)
              (|GeneralizedMultivariateFactorize| 17 (|IndexedExponents| 17) 6
                                                  6 7)
              (114 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 43) (|:| |factor| 7) (|:| |exponent| 25))
              (|List| 44) (119 . |factorList|) (124 . |denom|) (129 . |One|)
              (133 . ~=) (|List| 70) (|List| 9)
              |SYSSOLP;triangularSystems;LLL;7| (139 . |zero?|)
              (144 . |concat|) (150 . |removeDuplicates|) (|List| 36)
              |SYSSOLP;solve;FSL;11| |SYSSOLP;solve;FL;8| (155 . |lhs|)
              (160 . |rhs|) (165 . -) |SYSSOLP;solve;EL;9|
              |SYSSOLP;solve;ESL;10| (171 . |primitivePart|) (|Mapping| 9 6)
              (|PolynomialFunctions2| 6 9) (177 . |map|) (|Union| 73 '"failed")
              (|Record| (|:| |particular| 68) (|:| |basis| (|List| 73)))
              (|List| 7)
              (|LinearSystemPolynomialPackage| 6 (|IndexedExponents| 17) 17 7)
              (183 . |linSolve|) (|Vector| 9) (189 . |zero|) (194 . ~=)
              (|Integer|) (200 . |elt|) (206 . *) (212 . +) (218 . |setelt!|)
              (225 . |elt|) (231 . =) (237 . |append|) (243 . |setUnion|)
              (|List| 56) |SYSSOLP;solve;LLL;18| |SYSSOLP;solve;LL;14|
              |SYSSOLP;solve;LL;15| |SYSSOLP;solve;LLL;16|
              (249 . |totalDegree|) (255 . |elt|))
           '#(|triangularSystems| 261 |solve| 267) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Fraction| (|Polynomial| |#1|)))))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| (|Symbol|))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Fraction| (|Polynomial| |#1|)))))
                                  (|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|List| (|Symbol|))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Fraction| (|Polynomial| |#1|)))))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Fraction| (|Polynomial| |#1|)))))
                                  (|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|Equation| (|Fraction| (|Polynomial| |#1|)))
                                  (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|Equation|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|triangularSystems|
                                 ((|List| (|List| (|Polynomial| |#1|)))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 91
                                            '(1 7 0 6 8 1 9 0 7 10 1 12 11 0 13
                                              2 11 14 0 0 15 1 12 9 0 16 2 18
                                              12 12 17 19 1 9 7 0 20 1 7 11 0
                                              21 2 11 14 17 0 22 2 7 23 0 17 24
                                              1 26 25 0 27 0 6 0 28 1 7 0 17 29
                                              0 6 0 30 0 9 0 31 2 26 7 0 25 32
                                              1 26 7 0 33 2 9 0 7 7 34 1 9 0 0
                                              35 2 36 0 9 9 37 0 17 0 38 2 7 25
                                              0 17 39 1 41 40 7 42 1 40 45 0 46
                                              1 9 7 0 47 0 7 0 48 2 7 14 0 0 49
                                              1 9 14 0 53 2 11 0 0 0 54 1 11 0
                                              0 55 1 36 9 0 59 1 36 9 0 60 2 9
                                              0 0 0 61 2 7 0 0 17 64 2 66 12 65
                                              7 67 2 71 69 70 11 72 1 73 0 25
                                              74 2 73 14 0 0 75 2 73 9 0 76 77
                                              2 9 0 0 0 78 2 9 0 0 0 79 3 73 9
                                              0 76 9 80 2 11 17 0 76 81 2 36 0
                                              9 9 82 2 56 0 0 0 83 2 11 0 0 0
                                              84 2 7 25 0 11 90 2 56 36 0 76 91
                                              2 0 50 51 11 52 2 0 85 56 11 89 2
                                              0 85 51 11 86 1 0 85 56 88 1 0 85
                                              51 87 2 0 56 36 17 63 2 0 56 9 17
                                              57 1 0 56 9 58 1 0 56 36 62)))))
           '|lookupComplete|)) 
