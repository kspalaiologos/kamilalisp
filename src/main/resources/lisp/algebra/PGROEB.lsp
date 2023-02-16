
(SDEFUN |PGROEB;lexGroebner;LLL;1|
        ((|lp| (|List| (|Polynomial| F))) (|lv| (|List| (|Symbol|)))
         ($ (|List| (|Polynomial| F))))
        (SPROG
         ((#1=#:G711 NIL) (|pp| NIL) (#2=#:G710 NIL) (|gb| (|List| |DPoly|))
          (|b| (|List| |DPoly|)) (#3=#:G709 NIL) (|pol| NIL) (#4=#:G708 NIL)
          (DP
           (|DirectProductCategory| (|call| LENGTH |lv|)
                                    (|NonNegativeInteger|)))
          (|DPoly|
           (|Join|
            (|PolynomialCategory| F
                                  (|DirectProduct| (|#| |lv|)
                                                   (|NonNegativeInteger|))
                                  (|OrderedVariableList| |lv|))
            (CATEGORY |domain|
             (SIGNATURE |reorder| ($ $ (|List| (|Integer|)))))))
          (PP
           (CATEGORY |package|
            (SIGNATURE |dmpToHdmp|
             ((|HomogeneousDistributedMultivariatePolynomial| |lv| F)
              (|DistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |hdmpToDmp|
             ((|DistributedMultivariatePolynomial| |lv| F)
              (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |pToHdmp|
             ((|HomogeneousDistributedMultivariatePolynomial| |lv| F)
              (|Polynomial| F)))
            (SIGNATURE |hdmpToP|
             ((|Polynomial| F)
              (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |dmpToP|
             ((|Polynomial| F) (|DistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |pToDmp|
             ((|DistributedMultivariatePolynomial| |lv| F)
              (|Polynomial| F))))))
         (SEQ (LETT PP (|PolToPol| |lv| (QREFELT $ 6)))
              (LETT |DPoly|
                    (|DistributedMultivariatePolynomial| |lv| (QREFELT $ 6)))
              (LETT DP (|DirectProduct| (LENGTH |lv|) (|NonNegativeInteger|)))
              (LETT |b|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |pol| NIL) (LETT #3# |lp|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |pol| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL |pol|
                                             (|compiledLookupCheck| '|pToDmp|
                                                                    (LIST
                                                                     (LIST
                                                                      '|DistributedMultivariatePolynomial|
                                                                      |lv|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            6)))
                                                                     (LIST
                                                                      '|Polynomial|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            6))))
                                                                    PP))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |gb|
                    (SPADCALL |b|
                              (|compiledLookupCheck| '|groebner|
                                                     (LIST
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |DPoly|))
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |DPoly|)))
                                                     (|GroebnerPackage|
                                                      (ELT $ 6) DP |DPoly|))))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |pp| NIL) (LETT #1# |gb|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |pp| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (SPADCALL |pp|
                                        (|compiledLookupCheck| '|dmpToP|
                                                               (LIST
                                                                (LIST
                                                                 '|Polynomial|
                                                                 (|devaluate|
                                                                  (ELT $ 6)))
                                                                (LIST
                                                                 '|DistributedMultivariatePolynomial|
                                                                 |lv|
                                                                 (|devaluate|
                                                                  (ELT $ 6))))
                                                               PP))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |PGROEB;totalGroebner;LLL;2|
        ((|lp| (|List| (|Polynomial| F))) (|lv| (|List| (|Symbol|)))
         ($ (|List| (|Polynomial| F))))
        (SPROG
         ((#1=#:G723 NIL) (|pp| NIL) (#2=#:G722 NIL) (|gb| (|List| |HDPoly|))
          (|b| (|List| |HDPoly|)) (#3=#:G721 NIL) (|pol| NIL) (#4=#:G720 NIL)
          (HDP
           (|DirectProductCategory| (|call| LENGTH |lv|)
                                    (|NonNegativeInteger|)))
          (|HDPoly|
           (|Join|
            (|PolynomialCategory| F
                                  (|HomogeneousDirectProduct| (|#| |lv|)
                                                              (|NonNegativeInteger|))
                                  (|OrderedVariableList| |lv|))
            (CATEGORY |domain|
             (SIGNATURE |reorder| ($ $ (|List| (|Integer|)))))))
          (PP
           (CATEGORY |package|
            (SIGNATURE |dmpToHdmp|
             ((|HomogeneousDistributedMultivariatePolynomial| |lv| F)
              (|DistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |hdmpToDmp|
             ((|DistributedMultivariatePolynomial| |lv| F)
              (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |pToHdmp|
             ((|HomogeneousDistributedMultivariatePolynomial| |lv| F)
              (|Polynomial| F)))
            (SIGNATURE |hdmpToP|
             ((|Polynomial| F)
              (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |dmpToP|
             ((|Polynomial| F) (|DistributedMultivariatePolynomial| |lv| F)))
            (SIGNATURE |pToDmp|
             ((|DistributedMultivariatePolynomial| |lv| F)
              (|Polynomial| F))))))
         (SEQ (LETT PP (|PolToPol| |lv| (QREFELT $ 6)))
              (LETT |HDPoly|
                    (|HomogeneousDistributedMultivariatePolynomial| |lv|
                                                                    (QREFELT $
                                                                             6)))
              (LETT HDP
                    (|HomogeneousDirectProduct| (LENGTH |lv|)
                                                (|NonNegativeInteger|)))
              (LETT |b|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |pol| NIL) (LETT #3# |lp|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |pol| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL |pol|
                                             (|compiledLookupCheck| '|pToHdmp|
                                                                    (LIST
                                                                     (LIST
                                                                      '|HomogeneousDistributedMultivariatePolynomial|
                                                                      |lv|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            6)))
                                                                     (LIST
                                                                      '|Polynomial|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            6))))
                                                                    PP))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |gb|
                    (SPADCALL |b|
                              (|compiledLookupCheck| '|groebner|
                                                     (LIST
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |HDPoly|))
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |HDPoly|)))
                                                     (|GroebnerPackage|
                                                      (ELT $ 6) HDP
                                                      |HDPoly|))))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |pp| NIL) (LETT #1# |gb|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |pp| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (SPADCALL |pp|
                                        (|compiledLookupCheck| '|hdmpToP|
                                                               (LIST
                                                                (LIST
                                                                 '|Polynomial|
                                                                 (|devaluate|
                                                                  (ELT $ 6)))
                                                                (LIST
                                                                 '|HomogeneousDistributedMultivariatePolynomial|
                                                                 |lv|
                                                                 (|devaluate|
                                                                  (ELT $ 6))))
                                                               PP))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |PolyGroebner;|)) 

(DEFUN |PolyGroebner| (#1=#:G724)
  (SPROG NIL
         (PROG (#2=#:G725)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PolyGroebner|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PolyGroebner;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|PolyGroebner|)))))))))) 

(DEFUN |PolyGroebner;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PolyGroebner| DV$1))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolyGroebner| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolyGroebner| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|List| (|Polynomial| 6))
              (|List| (|Symbol|)) |PGROEB;lexGroebner;LLL;1|
              |PGROEB;totalGroebner;LLL;2|)
           '#(|totalGroebner| 0 |lexGroebner| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|lexGroebner|
                                 ((|List| (|Polynomial| |#1|))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Symbol|))))
                                T)
                              '((|totalGroebner|
                                 ((|List| (|Polynomial| |#1|))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10 '(2 0 7 7 8 10 2 0 7 7 8 9)))))
           '|lookupComplete|)) 
