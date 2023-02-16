
(SDEFUN |XPR;One;$;1| (($ ($)))
        (LIST (CONS (|spadConstant| $ 9) (|spadConstant| $ 10)))) 

(SDEFUN |XPR;characteristic;Nni;2| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 13))) 

(PUT '|XPR;#;$Nni;3| '|SPADreplace| 'LENGTH) 

(SDEFUN |XPR;#;$Nni;3| ((|x| ($)) ($ (|NonNegativeInteger|))) (LENGTH |x|)) 

(SDEFUN |XPR;maxdeg;$E;4| ((|p| ($)) ($ (E)))
        (COND ((NULL |p|) (|error| "zero polynomial !!"))
              ('T (QCAR (|SPADfirst| |p|))))) 

(SDEFUN |XPR;mindeg;$E;5| ((|p| ($)) ($ (E)))
        (COND ((NULL |p|) (|error| "zero polynomial !!"))
              ('T (QCAR (SPADCALL |p| (QREFELT $ 18)))))) 

(SDEFUN |XPR;coef;$ER;6| ((|p| ($)) (|e| (E)) ($ (R)))
        (SPROG ((#1=#:G736 NIL) (#2=#:G737 NIL) (#3=#:G738 NIL) (|tm| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |tm| NIL) (LETT #3# |p|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |tm| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (QCAR |tm|) |e| (QREFELT $ 21))
                           (PROGN (LETT #2# (QCDR |tm|)) (GO #4=#:G735)))
                          ('T
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (QCAR |tm|) |e| (QREFELT $ 22))
                               (PROGN
                                (LETT #1#
                                      (PROGN
                                       (LETT #2# (|spadConstant| $ 23))
                                       (GO #4#)))
                                (GO #5=#:G731)))))
                            #5# (EXIT #1#))))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (|spadConstant| $ 23))))
                #4# (EXIT #2#)))) 

(SDEFUN |XPR;constant?;$B;7| ((|p| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |p| (|spadConstant| $ 25) (QREFELT $ 26)) 'T)
              ('T
               (SPADCALL (SPADCALL |p| (QREFELT $ 16)) (|spadConstant| $ 9)
                         (QREFELT $ 21))))) 

(SDEFUN |XPR;constant;$R;8| ((|p| ($)) ($ (R)))
        (SPADCALL |p| (|spadConstant| $ 9) (QREFELT $ 24))) 

(SDEFUN |XPR;quasiRegular?;$B;9| ((|p| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |p| (|spadConstant| $ 25) (QREFELT $ 26)) 'T)
              ('T
               (SPADCALL (QCAR (SPADCALL |p| (QREFELT $ 18)))
                         (|spadConstant| $ 9) (QREFELT $ 29))))) 

(SDEFUN |XPR;quasiRegular;2$;10| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G751 NIL) (|t| NIL) (#2=#:G750 NIL))
               (SEQ
                (COND ((SPADCALL |p| (QREFELT $ 30)) |p|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |t| NIL) (LETT #1# |p|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL
                                  (SPADCALL (QCAR |t|) (|spadConstant| $ 9)
                                            (QREFELT $ 21)))
                                 (LETT #2# (CONS |t| #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |XPR;recip;$U;11| ((|p| ($)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((|u| (|Union| R #1#)) (|p1| (|Record| (|:| |k| E) (|:| |c| R))))
         (SEQ
          (COND
           ((SPADCALL |p| (|spadConstant| $ 25) (QREFELT $ 26))
            (CONS 1 "failed"))
           (#2='T
            (SEQ (LETT |p1| (|SPADfirst| |p|))
                 (EXIT
                  (COND
                   ((SPADCALL (QCAR |p1|) (|spadConstant| $ 9) (QREFELT $ 32))
                    (CONS 1 "failed"))
                   (#2#
                    (SEQ (LETT |u| (SPADCALL (QCDR |p1|) (QREFELT $ 34)))
                         (EXIT
                          (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                                (#2#
                                 (CONS 0
                                       (SPADCALL (QCDR |u|)
                                                 (QREFELT $ 35)))))))))))))))) 

(SDEFUN |XPR;leftRecip;$U;12| ((|p| ($)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((|u| (|Union| R #1#)) (|p1| (|Record| (|:| |k| E) (|:| |c| R))))
         (SEQ
          (COND
           ((SPADCALL |p| (|spadConstant| $ 25) (QREFELT $ 26))
            (CONS 1 "failed"))
           (#2='T
            (SEQ (LETT |p1| (|SPADfirst| |p|))
                 (EXIT
                  (COND
                   ((SPADCALL (QCAR |p1|) (|spadConstant| $ 9) (QREFELT $ 32))
                    (CONS 1 "failed"))
                   (#2#
                    (SEQ
                     (LETT |u|
                           (SPADCALL (QCDR (|SPADfirst| |p|)) (QREFELT $ 37)))
                     (EXIT
                      (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                            (#2#
                             (CONS 0
                                   (SPADCALL (QCDR |u|)
                                             (QREFELT $ 35)))))))))))))))) 

(SDEFUN |XPR;rightRecip;$U;13| ((|p| ($)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((|u| (|Union| R #1#)) (|p1| (|Record| (|:| |k| E) (|:| |c| R))))
         (SEQ
          (COND
           ((SPADCALL |p| (|spadConstant| $ 25) (QREFELT $ 26))
            (CONS 1 "failed"))
           (#2='T
            (SEQ (LETT |p1| (|SPADfirst| |p|))
                 (EXIT
                  (COND
                   ((SPADCALL (QCAR |p1|) (|spadConstant| $ 9) (QREFELT $ 32))
                    (CONS 1 "failed"))
                   (#2#
                    (SEQ
                     (LETT |u|
                           (SPADCALL (QCDR (|SPADfirst| |p|)) (QREFELT $ 39)))
                     (EXIT
                      (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                            (#2#
                             (CONS 0
                                   (SPADCALL (QCDR |u|)
                                             (QREFELT $ 35)))))))))))))))) 

(SDEFUN |XPR;coerce;R$;14| ((|r| (R)) ($ ($)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 23) (QREFELT $ 41))
          (|spadConstant| $ 25))
         ('T (LIST (CONS (|spadConstant| $ 9) |r|))))) 

(SDEFUN |XPR;coerce;I$;15| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 43)) (QREFELT $ 35))) 

(SDEFUN |XPR;*;3$;16| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG
         ((#1=#:G790 NIL) (#2=#:G789 ($)) (#3=#:G791 ($)) (#4=#:G800 NIL)
          (|t2| NIL) (#5=#:G799 NIL) (#6=#:G798 NIL) (|t1| NIL))
         (SEQ
          (COND ((OR (NULL |p1|) (NULL |p2|)) (|spadConstant| $ 25))
                ((SPADCALL (QCAR (|SPADfirst| |p1|)) (|spadConstant| $ 9)
                           (QREFELT $ 21))
                 (SPADCALL (QCDR (|SPADfirst| |p1|)) |p2| (QREFELT $ 45)))
                ((SPADCALL |p2| (|spadConstant| $ 11) (QREFELT $ 26)) |p1|)
                (#7='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |t1| NIL) (LETT #6# |p1|) G190
                       (COND
                        ((OR (ATOM #6#) (PROGN (LETT |t1| (CAR #6#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #3#
                                (PROGN
                                 (LETT #5# NIL)
                                 (SEQ (LETT |t2| NIL) (LETT #4# |p2|) G190
                                      (COND
                                       ((OR (ATOM #4#)
                                            (PROGN (LETT |t2| (CAR #4#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #5#
                                              (CONS
                                               (CONS
                                                (SPADCALL (QCAR |t1|)
                                                          (QCAR |t2|)
                                                          (QREFELT $ 46))
                                                (SPADCALL (QCDR |t1|)
                                                          (QCDR |t2|)
                                                          (QREFELT $ 47)))
                                               #5#))))
                                      (LETT #4# (CDR #4#)) (GO G190) G191
                                      (EXIT (NREVERSE #5#)))))
                          (COND
                           (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 48))))
                           ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                       (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#7# (|spadConstant| $ 25))))))))) 

(SDEFUN |XPR;*;3$;17| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG
         ((#1=#:G803 NIL) (#2=#:G802 ($)) (#3=#:G804 ($)) (|r| (R))
          (#4=#:G814 NIL) (|t2| NIL) (#5=#:G813 NIL) (#6=#:G812 NIL)
          (|t1| NIL))
         (SEQ
          (COND ((OR (NULL |p1|) (NULL |p2|)) (|spadConstant| $ 25))
                ((SPADCALL (QCAR (|SPADfirst| |p1|)) (|spadConstant| $ 9)
                           (QREFELT $ 21))
                 (SPADCALL (QCDR (|SPADfirst| |p1|)) |p2| (QREFELT $ 45)))
                ((SPADCALL |p2| (|spadConstant| $ 11) (QREFELT $ 26)) |p1|)
                (#7='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |t1| NIL) (LETT #6# |p1|) G190
                       (COND
                        ((OR (ATOM #6#) (PROGN (LETT |t1| (CAR #6#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #3#
                                (PROGN
                                 (LETT #5# NIL)
                                 (SEQ (LETT |t2| NIL) (LETT #4# |p2|) G190
                                      (COND
                                       ((OR (ATOM #4#)
                                            (PROGN (LETT |t2| (CAR #4#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SEQ
                                           (LETT |r|
                                                 (SPADCALL (QCDR |t1|)
                                                           (QCDR |t2|)
                                                           (QREFELT $ 47)))
                                           (EXIT
                                            (NULL
                                             (SPADCALL |r|
                                                       (|spadConstant| $ 23)
                                                       (QREFELT $ 41)))))
                                          (LETT #5#
                                                (CONS
                                                 (CONS
                                                  (SPADCALL (QCAR |t1|)
                                                            (QCAR |t2|)
                                                            (QREFELT $ 46))
                                                  |r|)
                                                 #5#))))))
                                      (LETT #4# (CDR #4#)) (GO G190) G191
                                      (EXIT (NREVERSE #5#)))))
                          (COND
                           (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 48))))
                           ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                       (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#7# (|spadConstant| $ 25))))))))) 

(SDEFUN |XPR;^;$Nni$;18| ((|p| ($)) (|nn| (|NonNegativeInteger|)) ($ ($)))
        (|XPR;repeatMultExpt| |p| |nn| $)) 

(SDEFUN |XPR;repeatMultExpt| ((|x| ($)) (|nn| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|y| ($)) (#1=#:G822 NIL) (|i| NIL))
               (SEQ
                (COND ((EQL |nn| 0) (|spadConstant| $ 11))
                      ('T
                       (SEQ (LETT |y| |x|)
                            (SEQ (LETT |i| 2) (LETT #1# |nn|) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |y|
                                         (SPADCALL |x| |y| (QREFELT $ 49)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |y|))))))) 

(SDEFUN |XPR;outTerm| ((|r| (R)) (|m| (E)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 10) (QREFELT $ 41))
          (SPADCALL |m| (QREFELT $ 52)))
         ((SPADCALL |m| (|spadConstant| $ 9) (QREFELT $ 21))
          (SPADCALL |r| (QREFELT $ 53)))
         ('T
          (SPADCALL (SPADCALL |r| (QREFELT $ 53)) (SPADCALL |m| (QREFELT $ 52))
                    (QREFELT $ 54))))) 

(SDEFUN |XPR;coerce;$Of;21| ((|a| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G832 NIL) (|t| NIL) (#2=#:G831 NIL))
               (SEQ
                (COND
                 ((NULL |a|) (SPADCALL (|spadConstant| $ 23) (QREFELT $ 53)))
                 ('T
                  (SPADCALL (ELT $ 55)
                            (NREVERSE
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |t| NIL) (LETT #1# |a|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |t| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (|XPR;outTerm| (QCDR |t|)
                                             (QCAR |t|) $)
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                            (QREFELT $ 58))))))) 

(SDEFUN |XPR;/;$R$;22| ((|x| ($)) (|r| (R)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 60)) |x| (QREFELT $ 45))) 

(DECLAIM (NOTINLINE |XPolynomialRing;|)) 

(DEFUN |XPolynomialRing| (&REST #1=#:G839)
  (SPROG NIL
         (PROG (#2=#:G840)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|XPolynomialRing|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |XPolynomialRing;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|XPolynomialRing|)))))))))) 

(DEFUN |XPolynomialRing;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G838 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|XPolynomialRing| DV$1 DV$2))
    (LETT $ (GETREFV 72))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#1|
                                                       '(|noZeroDivisors|))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|Comparable|)))
                                        (AND
                                         (|HasCategory| |#1| '(|Comparable|))
                                         #1#)
                                        (|HasCategory| |#1| '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|XPolynomialRing| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|List| (|Record| (|:| |k| |#2|) (|:| |c| |#1|))))
    (COND
     ((|testBitVector| |pv$| 3)
      (QSETREFV $ 49 (CONS (|dispatchFunction| |XPR;*;3$;16|) $)))
     ('T (QSETREFV $ 49 (CONS (|dispatchFunction| |XPR;*;3$;17|) $))))
    (COND
     ((|testBitVector| |pv$| 6)
      (QSETREFV $ 61 (CONS (|dispatchFunction| |XPR;/;$R$;22|) $))))
    $))) 

(MAKEPROP '|XPolynomialRing| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FreeModule| 6 7) (|local| |#1|)
              (|local| |#2|) '|Rep| (0 . |One|) (4 . |One|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |XPR;One;$;1|) $))
              (|NonNegativeInteger|) (8 . |characteristic|)
              |XPR;characteristic;Nni;2| |XPR;#;$Nni;3| |XPR;maxdeg;$E;4|
              (|Record| (|:| |k| 7) (|:| |c| 6)) (12 . |last|)
              |XPR;mindeg;$E;5| (|Boolean|) (17 . =) (23 . <) (29 . |Zero|)
              |XPR;coef;$ER;6| (33 . |Zero|) (37 . =) |XPR;constant?;$B;7|
              |XPR;constant;$R;8| (43 . ~=) |XPR;quasiRegular?;$B;9|
              |XPR;quasiRegular;2$;10| (49 . >) (|Union| $ '"failed")
              (55 . |recip|) |XPR;coerce;R$;14| |XPR;recip;$U;11|
              (60 . |leftRecip|) |XPR;leftRecip;$U;12| (65 . |rightRecip|)
              |XPR;rightRecip;$U;13| (70 . =) (|Integer|) (76 . |coerce|)
              |XPR;coerce;I$;15| (81 . *) (87 . *) (93 . *) (99 . +) (105 . *)
              |XPR;^;$Nni$;18| (|OutputForm|) (111 . |coerce|) (116 . |coerce|)
              (121 . *) (127 . +) (|Mapping| 51 51 51) (|List| 51)
              (133 . |reduce|) |XPR;coerce;$Of;21| (139 . |inv|) (144 . /)
              (|List| 17) (|Mapping| 6 7) (|List| 6) (|Mapping| 6 6) (|List| $)
              (|List| 7) (|PositiveInteger|) (|String|) (|SingleInteger|)
              (|HashState|))
           '#(~= 150 |zero?| 156 |support| 161 |subtractIfCan| 166 |smaller?|
              172 |sample| 178 |rightRecip| 182 |rightPower| 187 |reductum| 199
              |recip| 204 |quasiRegular?| 209 |quasiRegular| 214 |opposite?|
              219 |one?| 225 |numberOfMonomials| 230 |monomials| 235
              |monomial?| 240 |monomial| 245 |mindeg| 251 |maxdeg| 256 |map|
              261 |listOfTerms| 267 |linearExtend| 272 |leftRecip| 278
              |leftPower| 283 |leadingTerm| 295 |leadingSupport| 300
              |leadingMonomial| 305 |leadingCoefficient| 310 |latex| 315
              |hashUpdate!| 320 |hash| 326 |constructOrdered| 331 |construct|
              336 |constant?| 341 |constant| 346 |commutator| 351 |coerce| 357
              |coefficients| 377 |coefficient| 382 |coef| 388 |characteristic|
              394 |associator| 398 |antiCommutator| 405 |annihilate?| 411 ^ 417
              |Zero| 429 |One| 433 = 437 / 443 - 449 + 460 * 466 |#| 502)
           'NIL
           (CONS
            (|makeByteWordVec2| 5
                                '(0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 5 0 0 0 0 2 3))
            (CONS
             '#(NIL |Algebra&| NIL |Rng&| |FreeModuleCategory&| NIL NIL NIL
                |Module&| NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| NIL |SetCategory&| NIL
                |BasicType&| NIL NIL NIL)
             (CONS
              '#((|XAlgebra| 6) (|Algebra| 6) (|Ring|) (|Rng|)
                 (|FreeModuleCategory| 6 7) (|SemiRing|)
                 (|IndexedDirectProductCategory| 6 7) (|SemiRng|) (|Module| 6)
                 (|IndexedProductCategory| 6 7) (|BiModule| 6 6)
                 (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|NonAssociativeRng|) (|RightModule| $$)
                 (|LeftModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|Comparable|) (|SetCategory|) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 51) (|canonicalUnitNormal|) (|noZeroDivisors|))
              (|makeByteWordVec2| 71
                                  '(0 7 0 9 0 6 0 10 0 6 12 13 1 8 17 0 18 2 7
                                    20 0 0 21 2 7 20 0 0 22 0 6 0 23 0 0 0 25 2
                                    0 20 0 0 26 2 7 20 0 0 29 2 7 20 0 0 32 1 6
                                    33 0 34 1 6 33 0 37 1 6 33 0 39 2 6 20 0 0
                                    41 1 6 0 42 43 2 0 0 6 0 45 2 7 0 0 0 46 2
                                    6 0 0 0 47 2 0 0 0 0 48 2 0 0 0 0 49 1 7 51
                                    0 52 1 6 51 0 53 2 51 0 0 0 54 2 51 0 0 0
                                    55 2 57 51 56 0 58 1 6 0 0 60 2 0 0 0 6 61
                                    2 0 20 0 0 1 1 0 20 0 1 1 0 67 0 1 2 0 33 0
                                    0 1 2 5 20 0 0 1 0 0 0 1 1 0 33 0 40 2 0 0
                                    0 12 1 2 0 0 0 68 1 1 0 0 0 1 1 0 33 0 36 1
                                    0 20 0 30 1 0 0 0 31 2 0 20 0 0 1 1 0 20 0
                                    1 1 0 12 0 1 1 0 66 0 1 1 0 20 0 1 2 0 0 6
                                    7 1 1 0 7 0 19 1 0 7 0 16 2 0 0 65 0 1 1 0
                                    62 0 1 2 1 6 63 0 1 1 0 33 0 38 2 0 0 0 12
                                    1 2 0 0 0 68 1 1 4 17 0 1 1 4 7 0 1 1 4 0 0
                                    1 1 4 6 0 1 1 0 69 0 1 2 0 71 71 0 1 1 0 70
                                    0 1 1 4 0 62 1 1 0 0 62 1 1 0 20 0 27 1 0 6
                                    0 28 2 0 0 0 0 1 1 0 0 7 1 1 0 0 6 35 1 0 0
                                    42 44 1 0 51 0 59 1 0 64 0 1 2 0 6 0 7 1 2
                                    0 6 0 7 24 0 0 12 14 3 0 0 0 0 0 1 2 0 0 0
                                    0 1 2 0 20 0 0 1 2 0 0 0 12 50 2 0 0 0 68 1
                                    0 0 0 25 0 0 0 11 2 0 20 0 0 26 2 6 0 0 6
                                    61 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 48 2 0 0
                                    6 0 45 2 0 0 0 6 1 2 0 0 12 0 1 2 0 0 42 0
                                    1 2 0 0 0 0 49 2 0 0 68 0 1 1 0 12 0
                                    15)))))
           '|lookupComplete|)) 
