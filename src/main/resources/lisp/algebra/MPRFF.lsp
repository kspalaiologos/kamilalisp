
(SDEFUN |MPRFF;factor;PRFF;1| ((|p| (PRF)) ($ (|Factored| PRF)))
        (SPROG
         ((#1=#:G728 NIL) (#2=#:G727 #3=(|Factored| PRF)) (#4=#:G729 #3#)
          (#5=#:G737 NIL) (|ff| NIL)
          (|ffact|
           (|List|
            (|Record| (|:| |irr| PRF) (|:| |pow| (|NonNegativeInteger|)))))
          (#6=#:G736 NIL) (#7=#:G735 NIL) (|fcont| (PRF)) (#8=#:G734 NIL)
          (|x| NIL) (#9=#:G733 NIL) (|u| NIL) (#10=#:G732 NIL)
          (|flist| (|Factored| (|Polynomial| R)))
          (|denp| (|Fraction| (|Polynomial| R))) (|nump| #11=(|Polynomial| R))
          (|tp| (|Record| (|:| |sup| #11#) (|:| |inf| (|Polynomial| R))))
          (|truelist| (|List| OV)))
         (SEQ (LETT |truelist| (SPADCALL |p| (QREFELT $ 11)))
              (LETT |tp| (SPADCALL |p| (QREFELT $ 13)))
              (LETT |nump| (QCAR |tp|))
              (LETT |denp|
                    (SPADCALL (SPADCALL (QCDR |tp|) (QREFELT $ 16))
                              (QREFELT $ 17)))
              (COND
               ((|domainEqual| (QREFELT $ 8) (|Fraction| (|Integer|)))
                (LETT |flist| (SPADCALL |nump| (QREFELT $ 20))))
               ((|HasCategory| (QREFELT $ 8) '(|FiniteFieldCategory|))
                (LETT |flist| (SPADCALL |nump| (QREFELT $ 22))))
               ((|HasCategory| (QREFELT $ 8) '(|Field|))
                (|error| "not done yet"))
               ((|HasCategory| (QREFELT $ 8) '(|CharacteristicZero|))
                (LETT |flist| (SPADCALL |nump| (QREFELT $ 24))))
               (#12='T (|error| "can't happen")))
              (LETT |ffact|
                    (PROGN
                     (LETT #10# NIL)
                     (SEQ (LETT |u| NIL)
                          (LETT #9# (SPADCALL |flist| (QREFELT $ 28))) G190
                          (COND
                           ((OR (ATOM #9#) (PROGN (LETT |u| (CAR #9#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #10#
                                  (CONS
                                   (CONS
                                    (SPADCALL
                                     (SPADCALL (QVELT |u| 1) (QREFELT $ 16))
                                     (QREFELT $ 29))
                                    (QVELT |u| 2))
                                   #10#))))
                          (LETT #9# (CDR #9#)) (GO G190) G191
                          (EXIT (NREVERSE #10#)))))
              (LETT |fcont|
                    (SPADCALL
                     (SPADCALL (SPADCALL |flist| (QREFELT $ 30))
                               (QREFELT $ 16))
                     (QREFELT $ 29)))
              (SEQ (LETT |x| NIL) (LETT #8# |truelist|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |x| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |fcont| (SPADCALL |fcont| |x| (QREFELT $ 31)))
                        (EXIT
                         (LETT |ffact|
                               (PROGN
                                (LETT #7# NIL)
                                (SEQ (LETT |ff| NIL) (LETT #6# |ffact|) G190
                                     (COND
                                      ((OR (ATOM #6#)
                                           (PROGN (LETT |ff| (CAR #6#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #7#
                                             (CONS
                                              (CONS
                                               (SPADCALL (QCAR |ff|) |x|
                                                         (QREFELT $ 31))
                                               (QCDR |ff|))
                                              #7#))))
                                     (LETT #6# (CDR #6#)) (GO G190) G191
                                     (EXIT (NREVERSE #7#)))))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |denp| |fcont| (QREFELT $ 32))
                         (PROGN
                          (LETT #1# NIL)
                          (SEQ (LETT |ff| NIL) (LETT #5# |ffact|) G190
                               (COND
                                ((OR (ATOM #5#)
                                     (PROGN (LETT |ff| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #4#
                                        (SPADCALL (QCAR |ff|) (QCDR |ff|)
                                                  (QREFELT $ 35)))
                                  (COND
                                   (#1#
                                    (LETT #2#
                                          (SPADCALL #2# #4# (QREFELT $ 36))))
                                   ('T
                                    (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                          (COND (#1# #2#) (#12# (|spadConstant| $ 37))))
                         (QREFELT $ 38)))))) 

(SDEFUN |MPRFF;pushdown;PRFOVPRF;2| ((|g| (PRF)) (|x| (OV)) ($ (PRF)))
        (SPROG ((|ug| (|SparseUnivariatePolynomial| PRF)) (|rf| (PRF)))
               (SEQ
                (COND ((SPADCALL |g| (QREFELT $ 41)) |g|)
                      ('T
                       (SEQ (LETT |rf| (|spadConstant| $ 42))
                            (LETT |ug| (SPADCALL |g| |x| (QREFELT $ 44)))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (SPADCALL |ug| (|spadConstant| $ 48)
                                              (QREFELT $ 49)))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |rf|
                                        (SPADCALL |rf|
                                                  (SPADCALL |ug| |x|
                                                            (QREFELT $ 50))
                                                  (QREFELT $ 51)))
                                  (EXIT
                                   (LETT |ug| (SPADCALL |ug| (QREFELT $ 52)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT |rf|))))))) 

(SDEFUN |MPRFF;pushdterm;SupOVPRF;3|
        ((|t| (|SparseUnivariatePolynomial| PRF)) (|x| (OV)) ($ (PRF)))
        (SPROG
         ((|cf| (|Fraction| (|Polynomial| R))) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |t| (QREFELT $ 54)))
              (LETT |cf|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 59)
                               (SPADCALL |x| (QREFELT $ 58)) |n|
                               (QREFELT $ 60))
                     (QREFELT $ 16)))
              (EXIT
               (SPADCALL |cf| (SPADCALL |t| (QREFELT $ 61)) (QREFELT $ 32)))))) 

(SDEFUN |MPRFF;pushup;PRFOVPRF;4| ((|f| (PRF)) (|x| (OV)) ($ (PRF)))
        (SPROG
         ((|g| (|SparseUnivariatePolynomial| PRF)) (|v| (OV)) (#1=#:G748 NIL))
         (SEQ
          (COND
           ((SPADCALL |f| (QREFELT $ 41))
            (SPADCALL (SPADCALL |f| (QREFELT $ 62)) |x| (QREFELT $ 63)))
           ('T
            (SEQ
             (LETT |v|
                   (PROG2 (LETT #1# (SPADCALL |f| (QREFELT $ 65)))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                     (|Union| (QREFELT $ 7) "failed") #1#)))
             (LETT |g| (SPADCALL |f| |v| (QREFELT $ 44)))
             (EXIT
              (SPADCALL
               (SPADCALL (CONS #'|MPRFF;pushup;PRFOVPRF;4!0| (VECTOR $ |x|))
                         |g| (QREFELT $ 67))
               |v| (QREFELT $ 68))))))))) 

(SDEFUN |MPRFF;pushup;PRFOVPRF;4!0| ((|y| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| |x| (QREFELT $ 31)))))) 

(SDEFUN |MPRFF;pushuconst;FOVPRF;5|
        ((|r| (|Fraction| (|Polynomial| R))) (|x| (OV)) ($ (PRF)))
        (SPROG ((|xs| (|Symbol|)))
               (SEQ (LETT |xs| (SPADCALL |x| (QREFELT $ 58)))
                    (EXIT
                     (COND
                      ((>
                        (SPADCALL (SPADCALL |r| (QREFELT $ 69)) |xs|
                                  (QREFELT $ 70))
                        0)
                       (|error| "bad polynomial form"))
                      ('T
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |r| (QREFELT $ 69))
                                   (QREFELT $ 16))
                         (QREFELT $ 17))
                        (SPADCALL
                         (SPADCALL (SPADCALL |r| (QREFELT $ 71)) |xs|
                                   (QREFELT $ 72))
                         |x| (QREFELT $ 74))
                        (QREFELT $ 32)))))))) 

(SDEFUN |MPRFF;pushucoef;SupOVPRF;6|
        ((|c| (|SparseUnivariatePolynomial| (|Polynomial| R))) (|x| (OV))
         ($ (PRF)))
        (COND
         ((SPADCALL |c| (|spadConstant| $ 75) (QREFELT $ 76))
          (|spadConstant| $ 42))
         ('T
          (SPADCALL
           (SPADCALL
            (SPADCALL (SPADCALL (SPADCALL |c| (QREFELT $ 77)) (QREFELT $ 16))
                      (QREFELT $ 29))
            |x| (SPADCALL |c| (QREFELT $ 78)) (QREFELT $ 79))
           (SPADCALL (SPADCALL |c| (QREFELT $ 80)) |x| (QREFELT $ 74))
           (QREFELT $ 51))))) 

(SDEFUN |MPRFF;totalfract;PRFR;7|
        ((|p| (PRF))
         ($
          (|Record| (|:| |sup| (|Polynomial| R))
                    (|:| |inf| (|Polynomial| R)))))
        (SPROG ((|g| (|Fraction| (|Polynomial| R))) (#1=#:G767 NIL) (|x| NIL))
               (SEQ
                (COND
                 ((SPADCALL |p| (|spadConstant| $ 42) (QREFELT $ 81))
                  (CONS (|spadConstant| $ 82) (|spadConstant| $ 59)))
                 ('T
                  (SEQ
                   (SEQ (LETT |x| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 11)))
                        G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT (LETT |p| (SPADCALL |p| |x| (QREFELT $ 53)))))
                        (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                   (LETT |g| (SPADCALL |p| (QREFELT $ 62)))
                   (EXIT
                    (CONS (SPADCALL |g| (QREFELT $ 71))
                          (SPADCALL |g| (QREFELT $ 69)))))))))) 

(DECLAIM (NOTINLINE |MPolyCatRationalFunctionFactorizer;|)) 

(DEFUN |MPolyCatRationalFunctionFactorizer| (&REST #1=#:G768)
  (SPROG NIL
         (PROG (#2=#:G769)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MPolyCatRationalFunctionFactorizer|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |MPolyCatRationalFunctionFactorizer;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|MPolyCatRationalFunctionFactorizer|)))))))))) 

(DEFUN |MPolyCatRationalFunctionFactorizer;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$|
          (LIST '|MPolyCatRationalFunctionFactorizer| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 83))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|MPolyCatRationalFunctionFactorizer|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|MPolyCatRationalFunctionFactorizer| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 7) (0 . |variables|)
              (|Record| (|:| |sup| 14) (|:| |inf| 14))
              |MPRFF;totalfract;PRFR;7| (|Polynomial| 8) (|Fraction| 14)
              (5 . |coerce|) (10 . |inv|) (|Factored| 14)
              (|MRationalFactorize| (|IndexedExponents| 57) 57 (|Integer|) 14)
              (15 . |factor|)
              (|MultFiniteFactorize| 57 (|IndexedExponents| 57) 8 14)
              (20 . |factor|)
              (|MultivariateFactorize| 57 (|IndexedExponents| 57) 8 14)
              (25 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 25) (|:| |factor| 14) (|:| |exponent| 33))
              (|List| 26) (30 . |factorList|) (35 . |coerce|) (40 . |unit|)
              |MPRFF;pushup;PRFOVPRF;4| (45 . *) (|NonNegativeInteger|)
              (|Factored| 9) (51 . |primeFactor|) (57 . *) (63 . |One|)
              (67 . *) |MPRFF;factor;PRFF;1| (|Boolean|) (73 . |ground?|)
              (78 . |Zero|) (|SparseUnivariatePolynomial| $)
              (82 . |univariate|) (88 . |Zero|) (92 . |Zero|)
              (|SparseUnivariatePolynomial| 9) (96 . |Zero|) (100 . ~=)
              |MPRFF;pushdterm;SupOVPRF;3| (106 . +) (112 . |reductum|)
              |MPRFF;pushdown;PRFOVPRF;2| (117 . |degree|) (122 . |One|)
              (126 . |One|) (|Symbol|) (130 . |convert|) (135 . |One|)
              (139 . |monomial|) (146 . |leadingCoefficient|) (151 . |retract|)
              |MPRFF;pushuconst;FOVPRF;5| (|Union| 7 '"failed")
              (156 . |mainVariable|) (|Mapping| 9 9) (161 . |map|)
              (167 . |multivariate|) (173 . |denom|) (178 . |degree|)
              (184 . |numer|) (189 . |univariate|)
              (|SparseUnivariatePolynomial| 14) |MPRFF;pushucoef;SupOVPRF;6|
              (195 . |Zero|) (199 . =) (205 . |leadingCoefficient|)
              (210 . |degree|) (215 . |monomial|) (222 . |reductum|) (227 . =)
              (233 . |Zero|))
           '#(|totalfract| 237 |pushup| 242 |pushuconst| 248 |pushucoef| 254
              |pushdterm| 260 |pushdown| 266 |factor| 272)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|totalfract|
                                 ((|Record| (|:| |sup| (|Polynomial| |#3|))
                                            (|:| |inf| (|Polynomial| |#3|)))
                                  |#4|))
                                T)
                              '((|pushdown| (|#4| |#4| |#2|)) T)
                              '((|pushdterm|
                                 (|#4| (|SparseUnivariatePolynomial| |#4|)
                                  |#2|))
                                T)
                              '((|pushup| (|#4| |#4| |#2|)) T)
                              '((|pushucoef|
                                 (|#4|
                                  (|SparseUnivariatePolynomial|
                                   (|Polynomial| |#3|))
                                  |#2|))
                                T)
                              '((|pushuconst|
                                 (|#4| (|Fraction| (|Polynomial| |#3|)) |#2|))
                                T)
                              '((|factor| ((|Factored| |#4|) |#4|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 82
                                            '(1 9 10 0 11 1 15 0 14 16 1 15 0 0
                                              17 1 19 18 14 20 1 21 18 14 22 1
                                              23 18 14 24 1 18 27 0 28 1 9 0 15
                                              29 1 18 14 0 30 2 9 0 15 0 32 2
                                              34 0 9 33 35 2 34 0 0 0 36 0 34 0
                                              37 2 34 0 9 0 38 1 9 40 0 41 0 9
                                              0 42 2 9 43 0 7 44 0 6 0 45 0 8 0
                                              46 0 47 0 48 2 47 40 0 0 49 2 9 0
                                              0 0 51 1 47 0 0 52 1 47 33 0 54 0
                                              8 0 55 0 9 0 56 1 7 57 0 58 0 14
                                              0 59 3 14 0 0 57 33 60 1 47 9 0
                                              61 1 9 15 0 62 1 9 64 0 65 2 47 0
                                              66 0 67 2 9 0 43 7 68 1 15 14 0
                                              69 2 14 33 0 57 70 1 15 14 0 71 2
                                              14 43 0 57 72 0 73 0 75 2 73 40 0
                                              0 76 1 73 14 0 77 1 73 33 0 78 3
                                              9 0 0 7 33 79 1 73 0 0 80 2 9 40
                                              0 0 81 0 14 0 82 1 0 12 9 13 2 0
                                              9 9 7 31 2 0 9 15 7 63 2 0 9 73 7
                                              74 2 0 9 47 7 50 2 0 9 9 7 53 1 0
                                              34 9 39)))))
           '|lookupComplete|)) 
