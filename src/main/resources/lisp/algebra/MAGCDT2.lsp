
(SDEFUN |MAGCDT2;pack_modulus;LLIU;1|
        ((|lm| (|List| (|Polynomial| (|Integer|)))) (|lvz| (|List| (|Symbol|)))
         (|p| (|Integer|))
         ($
          (|Union|
           (|Record| (|:| |svz| (|Symbol|)) (|:| |sm| (|U32Vector|))
                     (|:| |sp| (|Integer|)))
           "failed")))
        (SPROG ((|m| (|U32Vector|)) (|vz| (|Symbol|)))
               (SEQ
                (COND
                 ((SPADCALL (LENGTH |lvz|) 1 (QREFELT $ 8))
                  (|error| "unsupported"))
                 ((SPADCALL (LENGTH |lvz|) (LENGTH |lm|) (QREFELT $ 8))
                  (|error| "pack_modulus: #lvz ~= #lm"))
                 ('T
                  (SEQ (LETT |vz| (|SPADfirst| |lvz|))
                       (LETT |m|
                             (SPADCALL
                              (SPADCALL (|SPADfirst| |lm|) (QREFELT $ 11)) |p|
                              (QREFELT $ 14)))
                       (EXIT (CONS 0 (VECTOR |vz| |m| |p|))))))))) 

(SDEFUN |MAGCDT2;pack_exps;2IRSev;2|
        ((|dg| #1=(|Integer|)) (|msize| #1#)
         (|mu|
          (|Record| (|:| |svz| (|Symbol|)) (|:| |sm| (|U32Vector|))
                    (|:| |sp| (|Integer|))))
         ($ (|SortedExponentVector|)))
        (SPROG
         ((|ii| (|Integer|)) (#2=#:G734 NIL) (|j| NIL) (#3=#:G733 NIL)
          (|i| NIL) (|exps| (|SortedExponentVector|))
          (|nsize| (|NonNegativeInteger|)))
         (SEQ (LETT |nsize| (* (+ |dg| 1) |msize|))
              (LETT |exps| (GETREFV_U32 (* 2 |nsize|) 0))
              (SEQ (LETT |i| 0) (LETT #3# |dg|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 0) (LETT #2# (- |msize| 1)) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ (LETT |ii| (+ (* |i| |msize|) |j|))
                               (SETELT_U32 |exps| (* 2 |ii|) |i|)
                               (EXIT (SETELT_U32 |exps| (+ (* 2 |ii|) 1) |j|)))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |exps|)))) 

(SDEFUN |MAGCDT2;repack1;PaUvIRV;3|
        ((|res0| (|PrimitiveArray| (|U32Vector|))) (|coeffs| (|U32Vector|))
         (|dg| (|Integer|))
         (|mu|
          (|Record| (|:| |svz| (|Symbol|)) (|:| |sm| (|U32Vector|))
                    (|:| |sp| (|Integer|))))
         ($ (|Void|)))
        (SPROG
         ((|ii| (|Integer|)) (#1=#:G745 NIL) (|j| NIL) (|di| #2=(|Integer|))
          (|ci| (|U32Vector|)) (#3=#:G744 NIL) (|i| NIL) (|msize| #2#))
         (SEQ (LETT |msize| (SPADCALL (QVELT |mu| 1) (QREFELT $ 22)))
              (EXIT
               (SEQ (LETT |i| 0) (LETT #3# |dg|) G190
                    (COND ((|greater_SI| |i| #3#) (GO G191)))
                    (SEQ (LETT |ci| (QAREF1 |res0| |i|))
                         (LETT |di| (SPADCALL |ci| (QREFELT $ 22)))
                         (EXIT
                          (SEQ (LETT |j| 0) (LETT #1# (- |msize| 1)) G190
                               (COND ((|greater_SI| |j| #1#) (GO G191)))
                               (SEQ (LETT |ii| (+ (* |i| |msize|) |j|))
                                    (EXIT
                                     (COND
                                      ((<= |j| |di|)
                                       (SETELT_U32 |coeffs| |ii|
                                                   (ELT_U32 |ci| |j|)))
                                      ('T (SETELT_U32 |coeffs| |ii| 0)))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |MAGCDT2;MPtoMPT;PSLRU;4|
        ((|x| (|Polynomial| (|Integer|))) (|ivx| #1=(|Symbol|))
         (|ivz| (|List| #1#))
         (|mu|
          (|Record| (|:| |svz| (|Symbol|)) (|:| |sm| (|U32Vector|))
                    (|:| |sp| (|Integer|))))
         ($ (|Union| (|PrimitiveArray| (|U32Vector|)) "failed")))
        (SPROG
         ((|xu| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|k| (|NonNegativeInteger|)) (|cl| (|Polynomial| (|Integer|)))
          (|res| (|PrimitiveArray| (|U32Vector|))) (|zz| (|U32Vector|))
          (|p| (|Integer|)))
         (SEQ (LETT |p| (QVELT |mu| 2))
              (LETT |xu| (SPADCALL |x| |ivx| (QREFELT $ 28)))
              (LETT |zz| (GETREFV_U32 1 0))
              (LETT |res| (MAKEARR1 (+ (SPADCALL |xu| (QREFELT $ 32)) 1) |zz|))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |xu| (|spadConstant| $ 34) (QREFELT $ 35)))
                     (GO G191)))
                   (SEQ (LETT |cl| (SPADCALL |xu| (QREFELT $ 36)))
                        (LETT |k| (SPADCALL |xu| (QREFELT $ 32)))
                        (QSETAREF1 |res| |k|
                                   (SPADCALL (SPADCALL |cl| (QREFELT $ 11)) |p|
                                             (QREFELT $ 14)))
                        (EXIT (LETT |xu| (SPADCALL |xu| (QREFELT $ 37)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (CONS 0 |res|))))) 

(SDEFUN |MAGCDT2;is_zero?| ((|v| (|U32Vector|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G763 NIL) (#2=#:G764 NIL) (|i| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QV_LEN_U32 |v|))
                (SEQ
                 (EXIT
                  (SEQ (LETT |i| (- |n| 1)) G190 (COND ((< |i| 0) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (ELT_U32 |v| |i|) 0 (QREFELT $ 8))
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# NIL) (GO #3=#:G762)))
                            (GO #4=#:G760))))))
                       (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL)))
                 #4# (EXIT #1#))
                (EXIT 'T)))
          #3# (EXIT #2#)))) 

(SDEFUN |MAGCDT2;zero?;PaB;6|
        ((|v| (|PrimitiveArray| (|U32Vector|))) ($ (|Boolean|)))
        (EQL (SPADCALL |v| (QREFELT $ 40)) -1)) 

(SDEFUN |MAGCDT2;degree;PaI;7|
        ((|v| (|PrimitiveArray| (|U32Vector|))) ($ (|Integer|)))
        (SPROG
         ((#1=#:G771 NIL) (#2=#:G772 NIL) (|i| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVSIZE |v|))
                (SEQ
                 (EXIT
                  (SEQ (LETT |i| (- |n| 1)) G190 (COND ((< |i| 0) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL (|MAGCDT2;is_zero?| (QAREF1 |v| |i|) $))
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# |i|) (GO #3=#:G770)))
                            (GO #4=#:G768))))))
                       (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL)))
                 #4# (EXIT #1#))
                (EXIT -1)))
          #3# (EXIT #2#)))) 

(SDEFUN |MAGCDT2;leadingCoefficient|
        ((|v| (|PrimitiveArray| (|U32Vector|))) ($ (|U32Vector|)))
        (SPROG
         ((#1=#:G778 NIL) (#2=#:G779 NIL) (|pp| (|U32Vector|)) (|i| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVSIZE |v|))
                (SEQ
                 (EXIT
                  (SEQ (LETT |i| (- |n| 1)) G190 (COND ((< |i| 0) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL
                            (|MAGCDT2;is_zero?| (LETT |pp| (QAREF1 |v| |i|))
                             $))
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# |pp|) (GO #3=#:G777)))
                            (GO #4=#:G775))))))
                       (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL)))
                 #4# (EXIT #1#))
                (EXIT (GETREFV_U32 1 0))))
          #3# (EXIT #2#)))) 

(SDEFUN |MAGCDT2;canonicalIfCan;PaRU;9|
        ((|x| (|PrimitiveArray| (|U32Vector|)))
         (|mu|
          (|Record| (|:| |svz| (|Symbol|)) (|:| |sm| (|U32Vector|))
                    (|:| |sp| (|Integer|))))
         ($ (|Union| (|PrimitiveArray| (|U32Vector|)) "failed")))
        (SPROG
         ((|npp| (|U32Vector|)) (|dnpp| #1=(|Integer|)) (|dpp| #1#)
          (|pp| (|U32Vector|)) (#2=#:G799 NIL) (|l| NIL)
          (|res| (|PrimitiveArray| (|U32Vector|))) (|dx| (|Integer|))
          (|icl| (|U32Vector|)) (|rr1| (|U32Vector|))
          (|rr| (|List| (|U32Vector|))) (|cl| (|U32Vector|)) (|p| (|Integer|))
          (|m| (|U32Vector|)))
         (SEQ (LETT |m| (QVELT |mu| 1)) (LETT |p| (QVELT |mu| 2))
              (LETT |cl| (|MAGCDT2;leadingCoefficient| |x| $))
              (LETT |rr| (SPADCALL |cl| |m| |p| (QREFELT $ 43)))
              (LETT |rr1| (|SPADfirst| |rr|))
              (EXIT
               (COND
                ((OR (SPADCALL (SPADCALL |rr1| (QREFELT $ 22)) 0 (QREFELT $ 8))
                     (SPADCALL (ELT_U32 |rr1| 0) 1 (QREFELT $ 8)))
                 (CONS 1 "failed"))
                ('T
                 (SEQ (LETT |icl| (SPADCALL |rr| 2 (QREFELT $ 44)))
                      (LETT |dx| (SPADCALL |x| (QREFELT $ 40)))
                      (LETT |res| (MAKEARR1 (+ |dx| 1) (QAREF1 |x| 0)))
                      (SEQ (LETT |l| 0) (LETT #2# (- |dx| 1)) G190
                           (COND ((|greater_SI| |l| #2#) (GO G191)))
                           (SEQ
                            (LETT |pp|
                                  (SPADCALL |icl| (QAREF1 |x| |l|) |p|
                                            (QREFELT $ 45)))
                            (SPADCALL |pp| |m| |p| (QREFELT $ 46))
                            (LETT |dpp| (SPADCALL |pp| (QREFELT $ 22)))
                            (LETT |dnpp| (COND ((< |dpp| 0) 0) ('T |dpp|)))
                            (LETT |npp| (GETREFV_U32 (+ |dnpp| 1) 0))
                            (SPADCALL |npp| |pp| (+ |dpp| 1) (QREFELT $ 47))
                            (EXIT (QSETAREF1 |res| |l| |npp|)))
                           (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                      (QSETAREF1 |res| |dx| (GETREFV_U32 1 1))
                      (EXIT (CONS 0 |res|))))))))) 

(SDEFUN |MAGCDT2;pseudoRem;2PaRPa;10|
        ((|x| #1=(|PrimitiveArray| (|U32Vector|))) (|y| #1#)
         (|mu|
          (|Record| (|:| |svz| (|Symbol|)) (|:| |sm| (|U32Vector|))
                    (|:| |sp| (|Integer|))))
         ($ (|PrimitiveArray| (|U32Vector|))))
        (SPROG
         ((|npp1| (|U32Vector|)) (|degnpp1| #2=(|Integer|)) (|degpp1| #2#)
          (|pp1| #3=(|U32Vector|)) (|dp2| #2#) (|dp1| #2#) (|pp2| #3#)
          (|l1| (|NonNegativeInteger|)) (#4=#:G812 NIL) (|l| NIL)
          (#5=#:G811 NIL) (|del| #6=(|NonNegativeInteger|)) (|p| (|Integer|))
          (|m| (|U32Vector|)) (|res| (|PrimitiveArray| (|U32Vector|)))
          (|i1| #6#) (|c| #7=(|U32Vector|)) (|cy| #7#) (|j| #8=(|Integer|))
          (|i| #8#))
         (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 40)))
              (LETT |j| (SPADCALL |y| (QREFELT $ 40)))
              (EXIT
               (COND ((EQL |j| 0) (MAKEARR1 1 (GETREFV_U32 1 0)))
                     ((< |i| |j|) |x|)
                     ('T
                      (SEQ (LETT |cy| (|MAGCDT2;leadingCoefficient| |y| $))
                           (LETT |c| (|MAGCDT2;leadingCoefficient| |x| $))
                           (LETT |i1| (- |i| 1))
                           (LETT |res| (MAKEARR1 (+ |i1| 1) (QAREF1 |x| 0)))
                           (LETT |m| (QVELT |mu| 1)) (LETT |p| (QVELT |mu| 2))
                           (LETT |del| (- |i| |j|))
                           (SEQ (LETT |l| 0) (LETT #5# (- |del| 1)) G190
                                (COND ((|greater_SI| |l| #5#) (GO G191)))
                                (SEQ
                                 (LETT |pp1|
                                       (SPADCALL |cy| (QAREF1 |x| |l|) |p|
                                                 (QREFELT $ 45)))
                                 (SPADCALL |pp1| |m| |p| (QREFELT $ 46))
                                 (LETT |degpp1|
                                       (SPADCALL |pp1| (QREFELT $ 22)))
                                 (LETT |degnpp1|
                                       (COND ((< |degpp1| 0) 0) ('T |degpp1|)))
                                 (LETT |npp1| (GETREFV_U32 (+ |degnpp1| 1) 0))
                                 (SPADCALL |npp1| |pp1| (+ |degpp1| 1)
                                           (QREFELT $ 47))
                                 (EXIT (QSETAREF1 |res| |l| |npp1|)))
                                (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                (EXIT NIL))
                           (SEQ (LETT |l| 0) (LETT #4# (- |j| 1)) G190
                                (COND ((|greater_SI| |l| #4#) (GO G191)))
                                (SEQ (LETT |l1| (+ |l| |del|))
                                     (LETT |pp1|
                                           (SPADCALL |cy| (QAREF1 |x| |l1|) |p|
                                                     (QREFELT $ 45)))
                                     (LETT |pp2|
                                           (SPADCALL |c| (QAREF1 |y| |l|) |p|
                                                     (QREFELT $ 45)))
                                     (LETT |dp1|
                                           (SPADCALL |pp1| (QREFELT $ 22)))
                                     (LETT |dp2|
                                           (SPADCALL |pp2| (QREFELT $ 22)))
                                     (COND
                                      ((>= |dp1| |dp2|)
                                       (SPADCALL |pp1| |pp2| 0 |dp2| (- |p| 1)
                                                 |p| (QREFELT $ 49)))
                                      ('T
                                       (SEQ
                                        (SPADCALL |pp2| |pp1| 0 |dp1| (- |p| 1)
                                                  |p| (QREFELT $ 49))
                                        (SPADCALL |pp2| |dp2| (- |p| 1) |p|
                                                  (QREFELT $ 50))
                                        (EXIT (LETT |pp1| |pp2|)))))
                                     (SPADCALL |pp1| |m| |p| (QREFELT $ 46))
                                     (LETT |degpp1|
                                           (SPADCALL |pp1| (QREFELT $ 22)))
                                     (LETT |degnpp1|
                                           (COND ((< |degpp1| 0) 0)
                                                 ('T |degpp1|)))
                                     (LETT |npp1|
                                           (GETREFV_U32 (+ |degnpp1| 1) 0))
                                     (SPADCALL |npp1| |pp1| (+ |degpp1| 1)
                                               (QREFELT $ 47))
                                     (EXIT (QSETAREF1 |res| |l1| |npp1|)))
                                (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT |res|)))))))) 

(DECLAIM (NOTINLINE |ModularAlgebraicGcdTools2;|)) 

(DEFUN |ModularAlgebraicGcdTools2| ()
  (SPROG NIL
         (PROG (#1=#:G816)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|ModularAlgebraicGcdTools2|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ModularAlgebraicGcdTools2|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|ModularAlgebraicGcdTools2;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|ModularAlgebraicGcdTools2|)))))))))) 

(DEFUN |ModularAlgebraicGcdTools2;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ModularAlgebraicGcdTools2|))
          (LETT $ (GETREFV 52))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularAlgebraicGcdTools2| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ModularAlgebraicGcdTools2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) (|Integer|) (0 . ~=)
              (|SparseUnivariatePolynomial| 7) (|Polynomial| 7)
              (6 . |univariate|) (|U32Vector|)
              (|U32VectorPolynomialOperations|) (11 . |to_mod_pa|)
              (|Record| (|:| |svz| 27) (|:| |sm| 12) (|:| |sp| 7))
              (|Union| 15 '"failed") (|List| 10) (|List| 27)
              |MAGCDT2;pack_modulus;LLIU;1| (|SortedExponentVector|)
              |MAGCDT2;pack_exps;2IRSev;2| (17 . |degree|) (|Void|)
              (|PrimitiveArray| 12) |MAGCDT2;repack1;PaUvIRV;3|
              (|SparseUnivariatePolynomial| $) (|Symbol|) (22 . |univariate|)
              (28 . |One|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 10) (32 . |degree|) (37 . |Zero|)
              (41 . |Zero|) (45 . ~=) (51 . |leadingCoefficient|)
              (56 . |reductum|) (|Union| 24 '"failed")
              |MAGCDT2;MPtoMPT;PSLRU;4| |MAGCDT2;degree;PaI;7|
              |MAGCDT2;zero?;PaB;6| (|List| 12) (61 . |extended_gcd|)
              (68 . |elt|) (74 . |mul|) (81 . |remainder!|) (88 . |copy_first|)
              |MAGCDT2;canonicalIfCan;PaRU;9| (95 . |vector_add_mul|)
              (105 . |mul_by_scalar|) |MAGCDT2;pseudoRem;2PaRPa;10|)
           '#(|zero?| 113 |repack1| 118 |pseudoRem| 126 |pack_modulus| 133
              |pack_exps| 140 |degree| 147 |canonicalIfCan| 152 |MPtoMPT| 158)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|ModularAlgebraicGcdOperations| 10 24 15))
                             (|makeByteWordVec2| 51
                                                 '(2 7 6 0 0 8 1 10 9 0 11 2 13
                                                   12 9 7 14 1 13 7 12 22 2 10
                                                   26 0 27 28 0 10 0 29 1 31 30
                                                   0 32 0 10 0 33 0 31 0 34 2
                                                   31 6 0 0 35 1 31 10 0 36 1
                                                   31 0 0 37 3 13 42 12 12 7 43
                                                   2 42 12 0 7 44 3 13 12 12 12
                                                   7 45 3 13 23 12 12 7 46 3 13
                                                   23 12 12 7 47 6 13 23 12 12
                                                   7 7 7 7 49 4 13 23 12 7 7 7
                                                   50 1 0 6 24 41 4 0 23 24 12
                                                   7 15 25 3 0 24 24 24 15 51 3
                                                   0 16 17 18 7 19 3 0 20 7 7
                                                   15 21 1 0 7 24 40 2 0 38 24
                                                   15 48 4 0 38 10 27 18 15
                                                   39)))))
           '|lookupComplete|)) 

(MAKEPROP '|ModularAlgebraicGcdTools2| 'NILADIC T) 
