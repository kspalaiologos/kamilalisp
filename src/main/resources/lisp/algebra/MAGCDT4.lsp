
(SDEFUN |MAGCDT4;FP_to_MP|
        ((|p| (|FakePolynomial|)) ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|p2|
           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                     (|:| |denom| (|Polynomial| (|Integer|))))))
         (SEQ (LETT |p2| (SPADCALL |p| (QREFELT $ 8)))
              (COND
               ((NULL
                 (SPADCALL (QCDR |p2|) (|spadConstant| $ 10) (QREFELT $ 12)))
                (EXIT (|error| "FP_to_MP: denom(p2) = 1"))))
              (EXIT (QCAR |p2|))))) 

(SDEFUN |MAGCDT4;pack_modulus;LLIU;2|
        ((|lm| (|List| (|FakePolynomial|))) (|lvz| (|List| (|Symbol|)))
         (|p| (|Integer|))
         ($
          (|Union|
           (|Record| (|:| |svz| (|List| (|Symbol|)))
                     (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                     (|:| |msizes| (|List| (|Integer|)))
                     (|:| |sp| (|Integer|)))
           "failed")))
        (SPROG
         ((|lm2| (|List| (|Polynomial| (|Integer|)))) (#1=#:G718 NIL) (|m| NIL)
          (#2=#:G717 NIL))
         (SEQ
          (LETT |lm2|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |m| NIL) (LETT #1# |lm|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |m| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #2# (CONS (|MAGCDT4;FP_to_MP| |m| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL |lm2| |lvz| |p| (QREFELT $ 18)))))) 

(SDEFUN |MAGCDT4;FrP_to_MP|
        ((|c|
          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                    (|:| |denom| (|Polynomial| (|Integer|)))))
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($ (|Union| (|Polynomial| (|Integer|)) "failed")))
        (SPROG
         ((|res1|
           (|Union| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))
                    "failed"))
          (|p1| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))))
         (SEQ
          (COND
           ((SPADCALL (QCDR |c|) (|spadConstant| $ 21) (QREFELT $ 12))
            (CONS 1 "failed"))
           (#1='T
            (SEQ
             (LETT |p1|
                   (SPADCALL (SPADCALL (QCDR |c|) 1 (QREFELT $ 24))
                             (SPADCALL (QCAR |c|) (QREFELT $ 25))
                             (QREFELT $ 26)))
             (LETT |res1| (SPADCALL |p1| |mu| (QREFELT $ 28)))
             (EXIT
              (COND ((QEQCAR |res1| 1) (CONS 1 "failed"))
                    (#1#
                     (CONS 0 (SPADCALL (QCDR |res1|) 0 (QREFELT $ 30)))))))))))) 

(SDEFUN |MAGCDT4;MPtoMPT;FpSLRU;4|
        ((|p| (|FakePolynomial|)) (|ivx| #1=(|Symbol|)) (|ivz| (|List| #1#))
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($
          (|Union| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))
                   "failed")))
        (SPROG NIL
               (SPADCALL (CONS #'|MAGCDT4;MPtoMPT;FpSLRU;4!0| (VECTOR $ |mu|))
                         |p| (QREFELT $ 33)))) 

(SDEFUN |MAGCDT4;MPtoMPT;FpSLRU;4!0| ((|c| NIL) ($$ NIL))
        (PROG (|mu| $)
          (LETT |mu| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT4;FrP_to_MP| |c| |mu| $))))) 

(DECLAIM (NOTINLINE |ModularAlgebraicGcdTools4;|)) 

(DEFUN |ModularAlgebraicGcdTools4| ()
  (SPROG NIL
         (PROG (#1=#:G741)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|ModularAlgebraicGcdTools4|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ModularAlgebraicGcdTools4|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|ModularAlgebraicGcdTools4;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|ModularAlgebraicGcdTools4|)))))))))) 

(DEFUN |ModularAlgebraicGcdTools4;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ModularAlgebraicGcdTools4|))
          (LETT $ (GETREFV 39))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularAlgebraicGcdTools4| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ModularAlgebraicGcdTools4| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|ModularAlgebraicGcdTools3|)
              (|Record| (|:| |numer| 9) (|:| |denom| 9)) (|FakePolynomial|)
              (0 . |ground|) (|Polynomial| 17) (5 . |One|) (|Boolean|) (9 . =)
              (|Record| (|:| |svz| 16) (|:| |sm| 15) (|:| |msizes| (|List| 17))
                        (|:| |sp| 17))
              (|Union| 13 '#1="failed") (|List| 9) (|List| 34) (|Integer|)
              (15 . |pack_modulus|) (|List| 7) |MAGCDT4;pack_modulus;LLIU;2|
              (22 . |Zero|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 9) (26 . |monomial|)
              (32 . |coerce|) (37 . +) (|Union| 23 '#1#)
              (43 . |canonicalIfCan|) (49 . |Zero|) (53 . |coefficient|)
              (|Union| 9 '"failed") (|Mapping| 31 6) (59 . |map|) (|Symbol|)
              |MAGCDT4;MPtoMPT;FpSLRU;4| (|Void|) (|U32Vector|)
              (|SortedExponentVector|))
           '#(|zero?| 65 |repack1| 70 |pseudoRem| 78 |pack_modulus| 85
              |pack_exps| 92 |degree| 99 |canonicalIfCan| 104 |MPtoMPT| 110)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|ModularAlgebraicGcdOperations| 7 23 13))
                             (|makeByteWordVec2| 38
                                                 '(1 7 6 0 8 0 9 0 10 2 9 11 0
                                                   0 12 3 5 14 15 16 17 18 0 9
                                                   0 21 2 23 0 9 22 24 1 23 0 9
                                                   25 2 23 0 0 0 26 2 5 27 23
                                                   13 28 0 23 0 29 2 23 9 0 22
                                                   30 2 7 27 32 0 33 1 0 11 23
                                                   1 4 0 36 23 37 17 13 1 3 0
                                                   23 23 23 13 1 3 0 14 19 16
                                                   17 20 3 0 38 17 17 13 1 1 0
                                                   17 23 1 2 0 27 23 13 1 4 0
                                                   27 7 34 16 13 35)))))
           '|lookupComplete|)) 

(MAKEPROP '|ModularAlgebraicGcdTools4| 'NILADIC T) 
