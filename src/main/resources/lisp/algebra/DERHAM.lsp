
(SDEFUN |DERHAM;totalDifferential;E$;1|
        ((|f| (|Expression| |CoefRing|)) ($ ($)))
        (SPROG ((|divs| (|List| $)) (#1=#:G719 NIL) (|i| NIL) (#2=#:G718 NIL))
               (SEQ
                (LETT |divs|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 9)) G190
                            (COND ((|greater_SI| |i| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL |f|
                                                (SPADCALL (QREFELT $ 7) |i|
                                                          (QREFELT $ 13))
                                                (QREFELT $ 15))
                                      (SPADCALL |i| (QREFELT $ 17))
                                      (QREFELT $ 18))
                                     #2#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))
                (EXIT (SPADCALL (ELT $ 19) |divs| (QREFELT $ 22)))))) 

(SDEFUN |DERHAM;termDiff| ((|r| (|Expression| |CoefRing|)) (|e| ($)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 23)) |e| (QREFELT $ 24))) 

(SDEFUN |DERHAM;exteriorDifferential;2$;3| ((|x| ($)) ($ ($)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 25) (QREFELT $ 28))
          (|spadConstant| $ 25))
         ('T
          (SPADCALL
           (|DERHAM;termDiff| (SPADCALL |x| (QREFELT $ 29))
            (SPADCALL |x| (QREFELT $ 30)) $)
           (SPADCALL (SPADCALL |x| (QREFELT $ 31)) (QREFELT $ 32))
           (QREFELT $ 19))))) 

(SDEFUN |DERHAM;d| ((|s| (|Symbol|)) ($ (|Symbol|)))
        (SPROG ((|ds| (|Symbol|)))
               (SEQ
                (LETT |ds|
                      (SPADCALL
                       (SPADCALL
                        (LIST "d"
                              (SPADCALL (SPADCALL |s| (QREFELT $ 33))
                                        (QREFELT $ 35)))
                        (QREFELT $ 37))
                       (QREFELT $ 38)))
                (EXIT
                 (SPADCALL |ds| (SPADCALL |s| (QREFELT $ 40))
                           (QREFELT $ 41)))))) 

(SDEFUN |DERHAM;displayList| ((|x| (|ExtAlgBasis|)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G739 NIL) (|i| NIL) (#2=#:G738 NIL)
          (|le| (|List| (|Integer|))))
         (SEQ (LETT |le| (SPADCALL |x| (QREFELT $ 45)))
              (EXIT
               (SPADCALL (ELT $ 47)
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 9)) G190
                               (COND ((|greater_SI| |i| #1#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((EQL (SPADCALL |le| |i| (QREFELT $ 48)) 1)
                                   (LETT #2#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL (QREFELT $ 42) |i|
                                                     (QREFELT $ 13))
                                           (QREFELT $ 49))
                                          #2#))))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 52)))))) 

(SDEFUN |DERHAM;makeTerm|
        ((|r| (|Expression| |CoefRing|)) (|x| (|ExtAlgBasis|))
         ($ (|OutputForm|)))
        (COND
         ((SPADCALL |x| (SPADCALL (QREFELT $ 9) (QREFELT $ 53)) (QREFELT $ 54))
          (SPADCALL |r| (QREFELT $ 55)))
         ((SPADCALL |r| (|spadConstant| $ 58) (QREFELT $ 59))
          (|DERHAM;displayList| |x| $))
         ('T
          (SPADCALL (SPADCALL |r| (QREFELT $ 55)) (|DERHAM;displayList| |x| $)
                    (QREFELT $ 47))))) 

(PUT '|DERHAM;terms| '|SPADreplace| '(XLAM (|a|) |a|)) 

(SDEFUN |DERHAM;terms|
        ((|a| ($))
         ($
          (|List|
           (|Record| (|:| |k| (|ExtAlgBasis|))
                     (|:| |c| (|Expression| |CoefRing|))))))
        |a|) 

(SDEFUN |DERHAM;coerce;$Of;8| ((|a| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G753 NIL) (|t| NIL) (#2=#:G752 NIL)
          (|ta|
           (|List|
            (|Record| (|:| |k| (|ExtAlgBasis|))
                      (|:| |c| (|Expression| |CoefRing|))))))
         (SEQ
          (COND
           ((SPADCALL |a| (|spadConstant| $ 60) (QREFELT $ 28))
            (SPADCALL 0 (QREFELT $ 61)))
           (#3='T
            (SEQ (LETT |ta| (|DERHAM;terms| |a| $))
                 (EXIT
                  (COND
                   ((NULL (CDR |ta|))
                    (|DERHAM;makeTerm| (QCDR (|SPADfirst| |ta|))
                     (QCAR (|SPADfirst| |ta|)) $))
                   (#3#
                    (SPADCALL (ELT $ 62)
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |t| NIL) (LETT #1# |ta|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |t| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS
                                             (|DERHAM;makeTerm| (QCDR |t|)
                                              (QCAR |t|) $)
                                             #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 52))))))))))) 

(DECLAIM (NOTINLINE |DeRhamComplex;|)) 

(DEFUN |DeRhamComplex| (&REST #1=#:G763)
  (SPROG NIL
         (PROG (#2=#:G764)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|DeRhamComplex|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DeRhamComplex;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|DeRhamComplex|)))))))))) 

(DEFUN |DeRhamComplex;| (|#1| |#2|)
  (SPROG
   ((#1=#:G762 NIL) (|liv| NIL) (#2=#:G761 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL)
    (DV$2 NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 (|devaluate| |#1|))
     (LETT DV$2 |#2|)
     (LETT |dv$| (LIST '|DeRhamComplex| DV$1 DV$2))
     (LETT $ (GETREFV 70))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
     (|haddProp| |$ConstructorCache| '|DeRhamComplex| (LIST DV$1 DV$2)
                 (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (QSETREFV $ 7 |#2|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 8 (|AntiSymm| (|Expression| |#1|) |#2|))
     (QSETREFV $ 9 (LENGTH |#2|))
     (QSETREFV $ 42
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |liv| NIL) (LETT #1# |#2|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |liv| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT #2# (CONS (|DERHAM;d| |liv| $) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))
     $)))) 

(MAKEPROP '|DeRhamComplex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|AntiSymm| 14 (NRTEVAL (QREFELT $ 7)))
              (|local| |#1|) (|local| |#2|) '|Rep| '|dim| (|Symbol|)
              (|Integer|) (|List| 10) (0 . |elt|) (|Expression| 6)
              (6 . |differentiate|) (|NonNegativeInteger|) (12 . |generator|)
              (17 . *) (23 . +) (|Mapping| $$ $$ $$) (|List| $$)
              (29 . |reduce|) |DERHAM;totalDifferential;E$;1| (35 . *)
              (41 . |Zero|) (45 . |Zero|) (|Boolean|) (49 . =)
              (55 . |leadingCoefficient|) (60 . |leadingBasisTerm|)
              (65 . |reductum|) |DERHAM;exteriorDifferential;2$;3|
              (70 . |name|) (|String|) (75 . |string|) (|List| $)
              (80 . |concat|) (85 . |coerce|)
              (|Record| (|:| |sub| 51) (|:| |sup| 51) (|:| |presup| 51)
                        (|:| |presub| 51) (|:| |args| 51))
              (90 . |scripts|) (95 . |script|) '|lv| (|List| 11)
              (|ExtAlgBasis|) (101 . |exponents|) (|OutputForm|) (106 . *)
              (112 . |elt|) (118 . |coerce|) (|Mapping| 46 46 46) (|List| 46)
              (123 . |reduce|) (129 . |Nul|) (134 . =) (140 . |coerce|)
              (145 . |One|) (149 . |One|) (153 . |One|) (157 . =)
              (163 . |Zero|) (167 . |coerce|) (172 . +) |DERHAM;coerce;$Of;8|
              (|Mapping| 14 14) (|Union| 14 '"failed") (|Union| $ '"failed")
              (|PositiveInteger|) (|HashState|) (|SingleInteger|))
           '#(~= 178 |zero?| 184 |totalDifferential| 189 |subtractIfCan| 194
              |sample| 200 |rightRecip| 204 |rightPower| 209 |retractable?| 221
              |retractIfCan| 226 |retract| 231 |reductum| 236 |recip| 241
              |opposite?| 246 |one?| 252 |map| 257 |leftRecip| 263 |leftPower|
              268 |leadingCoefficient| 280 |leadingBasisTerm| 285 |latex| 290
              |homogeneous?| 295 |hashUpdate!| 300 |hash| 306 |generator| 311
              |exteriorDifferential| 316 |degree| 321 |commutator| 326 |coerce|
              332 |coefficient| 347 |characteristic| 353 |associator| 357
              |antiCommutator| 364 |annihilate?| 370 ^ 376 |Zero| 388 |One| 392
              = 396 - 402 + 413 * 419)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0))
            (CONS
             '#(|LeftAlgebra&| NIL |Rng&| NIL NIL |NonAssociativeRing&| NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| |RetractableTo&| |SetCategory&|
                NIL NIL |BasicType&| NIL)
             (CONS
              '#((|LeftAlgebra| (|Expression| 6)) (|Ring|) (|Rng|) (|SemiRing|)
                 (|SemiRng|) (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|LeftModule| (|Expression| 6)) (|NonAssociativeRng|)
                 (|RightModule| $$) (|LeftModule| $$) (|AbelianGroup|)
                 (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|RetractableTo| (|Expression| 6))
                 (|SetCategory|) (|CoercibleFrom| (|Expression| 6))
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 46))
              (|makeByteWordVec2| 69
                                  '(2 12 10 0 11 13 2 14 0 0 10 15 1 5 0 16 17
                                    2 0 0 14 0 18 2 0 0 0 0 19 2 21 2 20 0 22 2
                                    0 0 0 0 24 0 0 0 25 0 6 0 26 2 0 27 0 0 28
                                    1 8 14 0 29 1 0 0 0 30 1 0 0 0 31 1 10 0 0
                                    33 1 10 34 0 35 1 34 0 36 37 1 10 0 34 38 1
                                    10 39 0 40 2 10 0 0 39 41 1 44 43 0 45 2 46
                                    0 0 0 47 2 43 11 0 11 48 1 10 46 0 49 2 51
                                    46 50 0 52 1 44 0 16 53 2 44 27 0 0 54 1 14
                                    46 0 55 0 0 0 56 0 6 0 57 0 14 0 58 2 14 27
                                    0 0 59 0 8 0 60 1 11 46 0 61 2 46 0 0 0 62
                                    2 0 27 0 0 1 1 0 27 0 1 1 0 0 14 23 2 0 66
                                    0 0 1 0 0 0 1 1 0 66 0 1 2 0 0 0 16 1 2 0 0
                                    0 67 1 1 0 27 0 1 1 0 65 0 1 1 0 14 0 1 1 0
                                    0 0 31 1 0 66 0 1 2 0 27 0 0 1 1 0 27 0 1 2
                                    0 0 64 0 1 1 0 66 0 1 2 0 0 0 16 1 2 0 0 0
                                    67 1 1 0 14 0 1 1 0 0 0 30 1 0 34 0 1 1 0
                                    27 0 1 2 0 68 68 0 1 1 0 69 0 1 1 0 0 16 1
                                    1 0 0 0 32 1 0 16 0 1 2 0 0 0 0 1 1 0 0 14
                                    1 1 0 0 11 1 1 0 46 0 63 2 0 14 0 0 1 0 0
                                    16 1 3 0 0 0 0 0 1 2 0 0 0 0 1 2 0 27 0 0 1
                                    2 0 0 0 16 1 2 0 0 0 67 1 0 0 0 25 0 0 0 56
                                    2 0 27 0 0 28 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0
                                    0 19 2 0 0 14 0 18 2 0 0 16 0 1 2 0 0 11 0
                                    1 2 0 0 0 0 24 2 0 0 67 0 1)))))
           '|lookupComplete|)) 
