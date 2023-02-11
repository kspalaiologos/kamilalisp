
(SDEFUN |JGB;convert1|
        ((|p| (P)) ($ (|DistributedJetBundlePolynomial| R JB LJV E)))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| P))
          (|res| (|DistributedJetBundlePolynomial| R JB LJV E)) (|x| (JB))
          (|cc| (R)) (|xx| (|Union| JB "failed")))
         (SEQ (LETT |xx| (SPADCALL |p| (QREFELT $ 12)))
              (EXIT
               (COND
                ((QEQCAR |xx| 1)
                 (SEQ (LETT |cc| (SPADCALL |p| (QREFELT $ 13)))
                      (EXIT (SPADCALL |cc| (QREFELT $ 15)))))
                ('T
                 (SEQ (LETT |x| (QCDR |xx|))
                      (COND
                       ((NULL (SPADCALL |x| (QREFELT $ 8) (QREFELT $ 18)))
                        (EXIT (|error| "illegal jet variable"))))
                      (LETT |up| (SPADCALL |p| |x| (QREFELT $ 20)))
                      (LETT |res| (|spadConstant| $ 21))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |up| (QREFELT $ 23))))
                             (GO G191)))
                           (SEQ
                            (LETT |res|
                                  (SPADCALL |res|
                                            (SPADCALL
                                             (|JGB;convert1|
                                              (SPADCALL |up| (QREFELT $ 24)) $)
                                             |x| (SPADCALL |up| (QREFELT $ 26))
                                             (QREFELT $ 27))
                                            (QREFELT $ 28)))
                            (EXIT (LETT |up| (SPADCALL |up| (QREFELT $ 29)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |JGB;convert2|
        ((|p| (|DistributedJetBundlePolynomial| R JB LJV E)) ($ (P)))
        (SPROG
         ((|up|
           (|SparseUnivariatePolynomial|
            (|DistributedJetBundlePolynomial| R JB LJV E)))
          (|res| (P)) (|x| (JB)) (|cc| (R)) (|xx| (|Union| JB "failed")))
         (SEQ (LETT |xx| (SPADCALL |p| (QREFELT $ 30)))
              (EXIT
               (COND
                ((QEQCAR |xx| 1)
                 (SEQ (LETT |cc| (SPADCALL |p| (QREFELT $ 31)))
                      (EXIT (SPADCALL |cc| (QREFELT $ 32)))))
                ('T
                 (SEQ (LETT |x| (QCDR |xx|))
                      (LETT |up| (SPADCALL |p| |x| (QREFELT $ 33)))
                      (LETT |res| (|spadConstant| $ 34))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |up| (QREFELT $ 36))))
                             (GO G191)))
                           (SEQ
                            (LETT |res|
                                  (SPADCALL |res|
                                            (SPADCALL
                                             (|JGB;convert2|
                                              (SPADCALL |up| (QREFELT $ 37)) $)
                                             |x| (SPADCALL |up| (QREFELT $ 38))
                                             (QREFELT $ 39))
                                            (QREFELT $ 40)))
                            (EXIT (LETT |up| (SPADCALL |up| (QREFELT $ 41)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |JGB;groebner;2L;3| ((|lp| (|List| P)) ($ (|List| P)))
        (SPROG
         ((#1=#:G734 NIL) (|dp| NIL) (#2=#:G733 NIL)
          (|gb| (|List| (|DistributedJetBundlePolynomial| R JB LJV E)))
          (|nlp| (|List| (|DistributedJetBundlePolynomial| R JB LJV E)))
          (#3=#:G732 NIL) (|p| NIL) (#4=#:G731 NIL))
         (SEQ
          (LETT |nlp|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |p| NIL) (LETT #3# |lp|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #4# (CONS (|JGB;convert1| |p| $) #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |gb| (SPADCALL |nlp| (QREFELT $ 43)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |dp| NIL) (LETT #1# |gb|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |dp| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ (EXIT (LETT #2# (CONS (|JGB;convert2| |dp| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |JetGroebner;|)) 

(DEFUN |JetGroebner| (&REST #1=#:G735)
  (SPROG NIL
         (PROG (#2=#:G736)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T NIL T T))
                     (HGET |$ConstructorCache| '|JetGroebner|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetGroebner;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|JetGroebner|)))))))))) 

(DEFUN |JetGroebner;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|JetGroebner| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 46))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|JetGroebner|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|JetGroebner| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Union| 7 '"failed") (0 . |mainVariable|) (5 . |retract|)
              (|DistributedJetBundlePolynomial| 6 7 (NRTEVAL (QREFELT $ 8)) 10)
              (10 . |coerce|) (|Boolean|) (|List| 7) (15 . |member?|)
              (|SparseUnivariatePolynomial| $) (21 . |univariate|)
              (27 . |Zero|) (|SparseUnivariatePolynomial| 9) (31 . |zero?|)
              (36 . |leadingCoefficient|) (|NonNegativeInteger|)
              (41 . |degree|) (46 . |monomial|) (53 . +) (59 . |reductum|)
              (64 . |mainVariable|) (69 . |retract|) (74 . |coerce|)
              (79 . |univariate|) (85 . |Zero|)
              (|SparseUnivariatePolynomial| 14) (89 . |zero?|)
              (94 . |leadingCoefficient|) (99 . |degree|) (104 . |monomial|)
              (111 . +) (117 . |reductum|) (|List| $) (122 . |groebner|)
              (|List| 9) |JGB;groebner;2L;3|)
           '#(|groebner| 127) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|groebner| ((|List| |#4|) (|List| |#4|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 45
                                            '(1 9 11 0 12 1 9 6 0 13 1 14 0 6
                                              15 2 17 16 7 0 18 2 9 19 0 7 20 0
                                              14 0 21 1 22 16 0 23 1 22 9 0 24
                                              1 22 25 0 26 3 14 0 0 7 25 27 2
                                              14 0 0 0 28 1 22 0 0 29 1 14 11 0
                                              30 1 14 6 0 31 1 9 0 6 32 2 14 19
                                              0 7 33 0 9 0 34 1 35 16 0 36 1 35
                                              14 0 37 1 35 25 0 38 3 9 0 0 7 25
                                              39 2 9 0 0 0 40 1 35 0 0 41 1 14
                                              42 42 43 1 0 44 44 45)))))
           '|lookupComplete|)) 
