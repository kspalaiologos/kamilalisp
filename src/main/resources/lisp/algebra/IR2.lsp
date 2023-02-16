
(SDEFUN |IR2;NLE2F|
        ((|func| (|Mapping| F E))
         (|r| (|Record| (|:| |coeff| E) (|:| |logand| E)))
         ($ (|Record| (|:| |coeff| F) (|:| |logand| F))))
        (CONS (SPADCALL (QCAR |r|) |func|) (SPADCALL (QCDR |r|) |func|))) 

(SDEFUN |IR2;NEE2F|
        ((|func| (|Mapping| F E))
         (|n| (|Record| (|:| |integrand| E) (|:| |intvar| E)))
         ($ (|Record| (|:| |integrand| F) (|:| |intvar| F))))
        (CONS (SPADCALL (QCAR |n|) |func|) (SPADCALL (QCDR |n|) |func|))) 

(SDEFUN |IR2;map;MUU;3|
        ((|func| (|Mapping| F E)) (|u| (|Union| E "failed"))
         ($ (|Union| F "failed")))
        (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
              ('T (CONS 0 (SPADCALL (QCDR |u|) |func|))))) 

(SDEFUN |IR2;map;MIrIr;4|
        ((|func| (|Mapping| F E)) (|ir| (|IntegrationResult| E))
         ($ (|IntegrationResult| F)))
        (SPROG
         ((#1=#:G727 NIL) (|g| NIL) (#2=#:G726 NIL) (#3=#:G725 NIL) (|f| NIL)
          (#4=#:G724 NIL))
         (SEQ
          (SPADCALL (SPADCALL (SPADCALL |ir| (QREFELT $ 13)) |func|)
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |f| NIL)
                          (LETT #3# (SPADCALL |ir| (QREFELT $ 16))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4# (CONS (|IR2;LGE2F| |func| |f| $) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |g| NIL)
                          (LETT #1# (SPADCALL |ir| (QREFELT $ 19))) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2# (CONS (|IR2;NEE2F| |func| |g| $) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 25))))) 

(SDEFUN |IR2;map;MUU;5|
        ((|func| (|Mapping| F E))
         (|u| (|Union| (|Record| (|:| |ratpart| E) (|:| |coeff| E)) "failed"))
         ($ (|Union| (|Record| (|:| |ratpart| F) (|:| |coeff| F)) "failed")))
        (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
              ('T
               (CONS 0
                     (CONS (SPADCALL (QCAR (QCDR |u|)) |func|)
                           (SPADCALL (QCDR (QCDR |u|)) |func|)))))) 

(SDEFUN |IR2;map;MUU;6|
        ((|func| (|Mapping| F E))
         (|u|
          (|Union|
           (|Record| (|:| |mainpart| E)
                     (|:| |limitedlogs|
                          (|List|
                           (|Record| (|:| |coeff| E) (|:| |logand| E)))))
           "failed"))
         ($
          (|Union|
           (|Record| (|:| |mainpart| F)
                     (|:| |limitedlogs|
                          (|List|
                           (|Record| (|:| |coeff| F) (|:| |logand| F)))))
           "failed")))
        (SPROG ((#1=#:G770 NIL) (|f| NIL) (#2=#:G769 NIL))
               (SEQ
                (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                      ('T
                       (CONS 0
                             (CONS (SPADCALL (QCAR (QCDR |u|)) |func|)
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |f| NIL)
                                         (LETT #1# (QCDR (QCDR |u|))) G190
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
                                                  (|IR2;NLE2F| |func| |f| $)
                                                  #2#))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |IR2;LGE2F|
        ((|func| (|Mapping| F E))
         (|lg|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| E))
                    (|:| |logand| (|SparseUnivariatePolynomial| E))))
         ($
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F)))))
        (VECTOR (QVELT |lg| 0) (SPADCALL |func| (QVELT |lg| 1) (QREFELT $ 42))
                (SPADCALL |func| (QVELT |lg| 2) (QREFELT $ 42)))) 

(DECLAIM (NOTINLINE |IntegrationResultFunctions2;|)) 

(DEFUN |IntegrationResultFunctions2| (&REST #1=#:G781)
  (SPROG NIL
         (PROG (#2=#:G782)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IntegrationResultFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |IntegrationResultFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IntegrationResultFunctions2|)))))))))) 

(DEFUN |IntegrationResultFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|IntegrationResultFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegrationResultFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegrationResultFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| 7 '#1="failed") (|Mapping| 7 6) (|Union| 6 '#2="failed")
              |IR2;map;MUU;3| (|IntegrationResult| 6) (0 . |ratpart|)
              (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                        (|:| |coeff| 40) (|:| |logand| 40))
              (|List| 14) (5 . |logpart|)
              (|Record| (|:| |integrand| 6) (|:| |intvar| 6)) (|List| 17)
              (10 . |notelem|)
              (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                        (|:| |coeff| 39) (|:| |logand| 39))
              (|List| 20) (|Record| (|:| |integrand| 7) (|:| |intvar| 7))
              (|List| 22) (|IntegrationResult| 7) (15 . |mkAnswer|)
              |IR2;map;MIrIr;4| (|Record| (|:| |ratpart| 7) (|:| |coeff| 7))
              (|Union| 27 '#3="failed")
              (|Record| (|:| |ratpart| 6) (|:| |coeff| 6))
              (|Union| 29 '#4="failed") |IR2;map;MUU;5|
              (|Record| (|:| |coeff| 7) (|:| |logand| 7))
              (|Record| (|:| |mainpart| 7) (|:| |limitedlogs| (|List| 32)))
              (|Union| 33 '#5="failed")
              (|Record| (|:| |coeff| 6) (|:| |logand| 6))
              (|Record| (|:| |mainpart| 6) (|:| |limitedlogs| (|List| 35)))
              (|Union| 36 '#6="failed") |IR2;map;MUU;6|
              (|SparseUnivariatePolynomial| 7) (|SparseUnivariatePolynomial| 6)
              (|SparseUnivariatePolynomialFunctions2| 6 7) (22 . |map|))
           '#(|map| 28) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|IntegrationResult| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|IntegrationResult| |#1|)))
                                T)
                              '((|map|
                                 ((|Union|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeff| |#2|))
                                   #3#)
                                  (|Mapping| |#2| |#1|)
                                  (|Union|
                                   (|Record| (|:| |ratpart| |#1|)
                                             (|:| |coeff| |#1|))
                                   #4#)))
                                T)
                              '((|map|
                                 ((|Union| |#2| #1#) (|Mapping| |#2| |#1|)
                                  (|Union| |#1| #2#)))
                                T)
                              '((|map|
                                 ((|Union|
                                   (|Record| (|:| |mainpart| |#2|)
                                             (|:| |limitedlogs|
                                                  (|List|
                                                   (|Record| (|:| |coeff| |#2|)
                                                             (|:| |logand|
                                                                  |#2|)))))
                                   #5#)
                                  (|Mapping| |#2| |#1|)
                                  (|Union|
                                   (|Record| (|:| |mainpart| |#1|)
                                             (|:| |limitedlogs|
                                                  (|List|
                                                   (|Record| (|:| |coeff| |#1|)
                                                             (|:| |logand|
                                                                  |#1|)))))
                                   #6#)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 12 6 0 13 1 12 15 0 16 1 12 18
                                              0 19 3 24 0 7 21 23 25 2 41 39 9
                                              40 42 2 0 28 9 30 31 2 0 24 9 12
                                              26 2 0 34 9 37 38 2 0 8 9 10
                                              11)))))
           '|lookupComplete|)) 
