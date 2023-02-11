
(SDEFUN |GB;monicize| ((|p| (|Dpol|)) ($ (|Dpol|)))
        (SPROG ((|lc| (|Dom|)))
               (SEQ (LETT |lc| (SPADCALL |p| (QREFELT $ 9)))
                    (EXIT
                     (COND
                      ((SPADCALL |lc| (|spadConstant| $ 10) (QREFELT $ 13))
                       |p|)
                      ('T
                       (SPADCALL (SPADCALL |lc| (QREFELT $ 14)) |p|
                                 (QREFELT $ 15)))))))) 

(SDEFUN |GB;normalForm;DpolLDpol;2|
        ((|p| (|Dpol|)) (|l| (|List| |Dpol|)) ($ (|Dpol|)))
        (SPADCALL |p|
                  (SPADCALL (CONS (|function| |GB;monicize|) $) |l|
                            (QREFELT $ 18))
                  (QREFELT $ 20))) 

(SDEFUN |GB;groebner;2L;3| ((|Pol| (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (SPROG ((#1=#:G708 NIL) (|x| NIL) (#2=#:G707 NIL))
               (SEQ
                (COND ((SPADCALL |Pol| NIL (QREFELT $ 22)) |Pol|)
                      (#3='T
                       (SEQ
                        (LETT |Pol|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |x| NIL) (LETT #1# |Pol|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |x| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |x| (|spadConstant| $ 25)
                                                  (QREFELT $ 26))
                                        (LETT #2# (CONS |x| #2#))))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#)))))
                        (EXIT
                         (COND
                          ((SPADCALL |Pol| NIL (QREFELT $ 22))
                           (LIST (|spadConstant| $ 25)))
                          (#3#
                           (SPADCALL
                            (SPADCALL (CONS #'|GB;groebner;2L;3!0| $)
                                      (SPADCALL |Pol| 0 0 (QREFELT $ 30))
                                      (QREFELT $ 32))
                            (QREFELT $ 33))))))))))) 

(SDEFUN |GB;groebner;2L;3!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;LSL;4|
        ((|Pol| (|List| |Dpol|)) (|xx1| (|String|)) ($ (|List| |Dpol|)))
        (SPROG ((#1=#:G719 NIL) (|x| NIL) (#2=#:G718 NIL))
               (SEQ
                (COND ((SPADCALL |Pol| NIL (QREFELT $ 22)) |Pol|)
                      (#3='T
                       (SEQ
                        (LETT |Pol|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |x| NIL) (LETT #1# |Pol|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |x| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |x| (|spadConstant| $ 25)
                                                  (QREFELT $ 26))
                                        (LETT #2# (CONS |x| #2#))))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#)))))
                        (EXIT
                         (COND
                          ((SPADCALL |Pol| NIL (QREFELT $ 22))
                           (LIST (|spadConstant| $ 25)))
                          ((EQUAL |xx1| "redcrit")
                           (SPADCALL
                            (SPADCALL (CONS #'|GB;groebner;LSL;4!0| $)
                                      (SPADCALL |Pol| 1 0 (QREFELT $ 30))
                                      (QREFELT $ 32))
                            (QREFELT $ 33)))
                          ((EQUAL |xx1| "info")
                           (SPADCALL
                            (SPADCALL (CONS #'|GB;groebner;LSL;4!1| $)
                                      (SPADCALL |Pol| 2 1 (QREFELT $ 30))
                                      (QREFELT $ 32))
                            (QREFELT $ 33)))
                          (#3#
                           (SEQ (SPADCALL "   " (QREFELT $ 38))
                                (SPADCALL
                                 "WARNING: options are - redcrit and/or info - "
                                 (QREFELT $ 38))
                                (SPADCALL
                                 "         you didn't type them correct"
                                 (QREFELT $ 38))
                                (SPADCALL "         please try again"
                                          (QREFELT $ 38))
                                (SPADCALL "   " (QREFELT $ 38))
                                (EXIT NIL))))))))))) 

(SDEFUN |GB;groebner;LSL;4!1| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;LSL;4!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;L2SL;5|
        ((|Pol| (|List| |Dpol|)) (|xx1| (|String|)) (|xx2| (|String|))
         ($ (|List| |Dpol|)))
        (SPROG ((#1=#:G731 NIL) (|x| NIL) (#2=#:G730 NIL))
               (SEQ
                (COND ((SPADCALL |Pol| NIL (QREFELT $ 22)) |Pol|)
                      (#3='T
                       (SEQ
                        (LETT |Pol|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |x| NIL) (LETT #1# |Pol|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |x| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL |x| (|spadConstant| $ 25)
                                                  (QREFELT $ 26))
                                        (LETT #2# (CONS |x| #2#))))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#)))))
                        (EXIT
                         (COND
                          ((SPADCALL |Pol| NIL (QREFELT $ 22))
                           (LIST (|spadConstant| $ 25)))
                          (#3#
                           (SEQ
                            (COND
                             ((EQUAL |xx1| "redcrit")
                              (COND
                               ((EQUAL |xx2| "info")
                                (EXIT
                                 (SPADCALL
                                  (SPADCALL (CONS #'|GB;groebner;L2SL;5!0| $)
                                            (SPADCALL |Pol| 1 1 (QREFELT $ 30))
                                            (QREFELT $ 32))
                                  (QREFELT $ 33))))
                               ((EQUAL |xx1| #4="info")
                                (COND
                                 ((EQUAL |xx2| #5="redcrit")
                                  (EXIT
                                   (SPADCALL
                                    (SPADCALL (CONS #'|GB;groebner;L2SL;5!1| $)
                                              (SPADCALL |Pol| 1 1
                                                        (QREFELT $ 30))
                                              (QREFELT $ 32))
                                    (QREFELT $ 33))))))))
                             ((EQUAL |xx1| #4#)
                              (COND
                               ((EQUAL |xx2| #5#)
                                (EXIT
                                 (SPADCALL
                                  (SPADCALL (CONS #'|GB;groebner;L2SL;5!2| $)
                                            (SPADCALL |Pol| 1 1 (QREFELT $ 30))
                                            (QREFELT $ 32))
                                  (QREFELT $ 33)))))))
                            (COND
                             ((EQUAL |xx1| "redcrit")
                              (COND
                               ((EQUAL |xx2| "redcrit")
                                (EXIT
                                 (SPADCALL
                                  (SPADCALL (CONS #'|GB;groebner;L2SL;5!3| $)
                                            (SPADCALL |Pol| 1 0 (QREFELT $ 30))
                                            (QREFELT $ 32))
                                  (QREFELT $ 33)))))))
                            (COND
                             ((EQUAL |xx1| "info")
                              (COND
                               ((EQUAL |xx2| "info")
                                (EXIT
                                 (SPADCALL
                                  (SPADCALL (CONS #'|GB;groebner;L2SL;5!4| $)
                                            (SPADCALL |Pol| 2 1 (QREFELT $ 30))
                                            (QREFELT $ 32))
                                  (QREFELT $ 33)))))))
                            (SPADCALL "   " (QREFELT $ 38))
                            (SPADCALL
                             "WARNING:  options are - redcrit and/or info - "
                             (QREFELT $ 38))
                            (SPADCALL
                             "          you didn't type them correctly"
                             (QREFELT $ 38))
                            (SPADCALL "          please try again "
                                      (QREFELT $ 38))
                            (SPADCALL "   " (QREFELT $ 38)) (EXIT NIL))))))))))) 

(SDEFUN |GB;groebner;L2SL;5!4| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;L2SL;5!3| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;L2SL;5!2| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;L2SL;5!1| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(SDEFUN |GB;groebner;L2SL;5!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (SPADCALL |y| (QREFELT $ 27))
                  (QREFELT $ 28))) 

(DECLAIM (NOTINLINE |GroebnerPackage;|)) 

(DEFUN |GroebnerPackage| (&REST #1=#:G732)
  (SPROG NIL
         (PROG (#2=#:G733)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GroebnerPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GroebnerPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GroebnerPackage|)))))))))) 

(DEFUN |GroebnerPackage;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|GroebnerPackage| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache| '|GroebnerPackage|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 21
                       (CONS (|dispatchFunction| |GB;normalForm;DpolLDpol;2|)
                             $)))))
          $))) 

(MAKEPROP '|GroebnerPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |leadingCoefficient|) (5 . |One|) (9 . |One|)
              (|Boolean|) (13 . =) (19 . |inv|) (24 . *) (|Mapping| 8 8)
              (|List| 8) (30 . |map|) (|GroebnerInternalPackage| 6 7 8)
              (36 . |redPol|) (42 . |normalForm|) (48 . =) (54 . |Zero|)
              (58 . |Zero|) (62 . |Zero|) (66 . ~=) (72 . |degree|) (77 . >)
              (|Integer|) (83 . |gbasis|) (|Mapping| 12 8 8) (90 . |sort|)
              (96 . |minGbasis|) |GB;groebner;2L;3| (|Void|) (|String|)
              (|OutputForm|) (101 . |messagePrint|) |GB;groebner;LSL;4|
              |GB;groebner;L2SL;5|)
           '#(|normalForm| 106 |groebner| 112) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|groebner| ((|List| |#3|) (|List| |#3|))) T)
                              '((|groebner|
                                 ((|List| |#3|) (|List| |#3|) (|String|)))
                                T)
                              '((|groebner|
                                 ((|List| |#3|) (|List| |#3|) (|String|)
                                  (|String|)))
                                T)
                              '((|normalForm| (|#3| |#3| (|List| |#3|)))
                                (|has| 6 (|Field|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 40
                                            '(1 8 6 0 9 0 6 0 10 0 8 0 11 2 6
                                              12 0 0 13 1 6 0 0 14 2 8 0 6 0 15
                                              2 17 0 16 0 18 2 19 8 8 17 20 2 0
                                              8 8 17 21 2 17 12 0 0 22 0 6 0 23
                                              0 7 0 24 0 8 0 25 2 8 12 0 0 26 1
                                              8 7 0 27 2 7 12 0 0 28 3 19 17 17
                                              29 29 30 2 17 0 31 0 32 1 19 17
                                              17 33 1 37 35 36 38 2 1 8 8 17 21
                                              2 0 17 17 36 39 1 0 17 17 34 3 0
                                              17 17 36 36 40)))))
           '|lookupComplete|)) 
