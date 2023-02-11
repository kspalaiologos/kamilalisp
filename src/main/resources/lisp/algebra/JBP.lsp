
(SDEFUN |JBP;jetVariables;$L;1| ((|p| ($)) ($ (|List| JB)))
        (SPADCALL |p| (QREFELT $ 10))) 

(SDEFUN |JBP;subst;$JB2$;2| ((|p| ($)) (|jv| (JB)) (|exp| ($)) ($ ($)))
        (SPADCALL |p| |jv| |exp| (QREFELT $ 12))) 

(PUT '|JBP;numerator;2$;3| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |JBP;numerator;2$;3| ((|l| ($)) ($ ($))) |l|) 

(SDEFUN |JBP;denominator;2$;4| ((|l| ($)) ($ ($))) (|spadConstant| $ 15)) 

(SDEFUN |JBP;solveFor;$JBU;5| ((|p| ($)) (|jv| (JB)) ($ (|Union| $ "failed")))
        (SPROG ((|cc| (R)) (|c| ($)))
               (SEQ (LETT |c| (SPADCALL |p| |jv| (QREFELT $ 17)))
                    (EXIT
                     (COND
                      ((SPADCALL |c| (QREFELT $ 19))
                       (SEQ (LETT |cc| (SPADCALL |c| (QREFELT $ 20)))
                            (EXIT
                             (CONS 0
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 15) |cc|
                                               (QREFELT $ 22))
                                     |p| (QREFELT $ 23))
                                    (SPADCALL |jv| (QREFELT $ 24))
                                    (QREFELT $ 25))))))
                      ('T (CONS 1 "failed"))))))) 

(SDEFUN |JBP;solveFor;$JBU;6| ((|p| ($)) (|jv| (JB)) ($ (|Union| $ "failed")))
        (SPROG ((|rc| (|Union| R "failed")) (|cc| (R)) (|c| ($)))
               (SEQ (LETT |c| (SPADCALL |p| |jv| (QREFELT $ 17)))
                    (EXIT
                     (COND
                      ((SPADCALL |c| (QREFELT $ 19))
                       (SEQ (LETT |cc| (SPADCALL |c| (QREFELT $ 20)))
                            (LETT |rc| (SPADCALL |cc| (QREFELT $ 28)))
                            (EXIT
                             (COND ((QEQCAR |rc| 1) (CONS 1 "failed"))
                                   (#1='T
                                    (CONS 0
                                          (SPADCALL
                                           (SPADCALL (QCDR |rc|) |p|
                                                     (QREFELT $ 29))
                                           (SPADCALL |jv| (QREFELT $ 24))
                                           (QREFELT $ 25))))))))
                      (#1# (CONS 1 "failed"))))))) 

(SDEFUN |JBP;groebner;2L;7| ((|lp| (|List| $)) ($ (|List| $)))
        (SPROG
         ((LJV (|List| JB)) (|lj| (|List| (|List| JB))) (#1=#:G736 NIL)
          (|p| NIL) (#2=#:G735 NIL))
         (SEQ (SPADCALL (SPADCALL "groebner" (QREFELT $ 32)) (QREFELT $ 34))
              (LETT |lj|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |p| (QREFELT $ 11)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT LJV (SPADCALL (ELT $ 35) |lj| NIL (QREFELT $ 38)))
              (SPADCALL
               (SPADCALL (SPADCALL "LJV" (QREFELT $ 32))
                         (SPADCALL LJV (QREFELT $ 39)) (QREFELT $ 40))
               (QREFELT $ 34))
              (EXIT
               (SPADCALL |lp|
                         (|compiledLookupCheck| '|groebner|
                                                (LIST
                                                 (LIST '|List| (|devaluate| $))
                                                 (LIST '|List|
                                                       (|devaluate| $)))
                                                (|JetGroebner| (ELT $ 6)
                                                               (ELT $ 7) LJV $
                                                               (|DirectProduct|
                                                                (|#| LJV)
                                                                (|NonNegativeInteger|))))))))) 

(DECLAIM (NOTINLINE |JetBundlePolynomial;|)) 

(DEFUN |JetBundlePolynomial| (&REST #1=#:G794)
  (SPROG NIL
         (PROG (#2=#:G795)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|JetBundlePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetBundlePolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|JetBundlePolynomial|)))))))))) 

(DEFUN |JetBundlePolynomial;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G793 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|JetBundlePolynomial| DV$1 DV$2))
    (LETT $ (GETREFV 95))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1| '(|Ring|))
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory| |#2|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|))))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|Pattern|
                                                           (|Integer|))))
                                         (|HasCategory| |#1| '(|Ring|))
                                         (|HasCategory| |#2|
                                                        '(|ConvertibleTo|
                                                          (|Pattern|
                                                           (|Integer|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|Pattern|
                                                           (|Float|))))
                                         (|HasCategory| |#1| '(|Ring|))
                                         (|HasCategory| |#2|
                                                        '(|ConvertibleTo|
                                                          (|Pattern|
                                                           (|Float|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PatternMatchable|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|Ring|))
                                         (|HasCategory| |#2|
                                                        '(|PatternMatchable|
                                                          (|Integer|))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PatternMatchable|
                                                          (|Float|)))
                                         (|HasCategory| |#1| '(|Ring|))
                                         (|HasCategory| |#2|
                                                        '(|PatternMatchable|
                                                          (|Float|))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| |#1| '(|EntireRing|))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory|
                                         (|IndexedExponents| |#2|)
                                         '(|Comparable|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #1#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #1#
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1| '(|Ring|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #1#
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1| '(|Ring|))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #1#
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1| '(|Ring|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #1#
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1| '(|Ring|))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))))))))
    (|haddProp| |$ConstructorCache| '|JetBundlePolynomial| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
         (|HasCategory| $ '(|CharacteristicNonZero|))
         (|augmentPredVector| $ 268435456))
    (AND
     (OR (|HasCategory| |#1| '(|CharacteristicNonZero|))
         (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
              (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 536870912))
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 1073741824))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|SparseMultivariatePolynomial| |#1| |#2|))
    (COND
     ((|testBitVector| |pv$| 21)
      (QSETREFV $ 27 (CONS (|dispatchFunction| |JBP;solveFor;$JBU;5|) $)))
     ('T (QSETREFV $ 27 (CONS (|dispatchFunction| |JBP;solveFor;$JBU;6|) $))))
    (COND
     ((|testBitVector| |pv$| 23)
      (QSETREFV $ 42 (CONS (|dispatchFunction| |JBP;groebner;2L;7|) $))))
    $))) 

(MAKEPROP '|JetBundlePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseMultivariatePolynomial| 6 7)
              (|local| |#1|) (|local| |#2|) '|Rep| (|List| 7) (0 . |variables|)
              |JBP;jetVariables;$L;1| (5 . |eval|) |JBP;subst;$JB2$;2|
              |JBP;numerator;2$;3| (12 . |One|) |JBP;denominator;2$;4|
              (16 . |differentiate|) (|Boolean|) (22 . |ground?|)
              (27 . |retract|) (32 . |One|) (36 . /) (42 . *) (48 . |coerce|)
              (53 . -) (|Union| $ '"failed") (59 . |solveFor|) (65 . |recip|)
              (70 . *) (|String|) (|OutputForm|) (76 . |message|) (|Void|)
              (81 . |print|) (86 . |setUnion|) (|Mapping| 9 9 9) (|List| 9)
              (92 . |reduce|) (99 . |coerce|) (104 . |assign|) (|List| $)
              (110 . |groebner|) (|Union| 52 '#1="failed") (|Matrix| $)
              (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 66)
              (|PatternMatchResult| (|Float|) $) (|PatternMatchResult| 66 $)
              (|Matrix| 66) (|Record| (|:| |mat| 50) (|:| |vec| (|Vector| 66)))
              (|Vector| $) (|Fraction| 66) (|Record| (|:| |k| 56) (|:| |c| 6))
              (|List| 54) (|IndexedExponents| 7) (|NonNegativeInteger|)
              (|Mapping| 6 56) (|Factored| $) (|Factored| 61)
              (|SparseUnivariatePolynomial| $) (|Union| 63 '#1#) (|List| 61)
              (|Union| 53 '#2="failed") (|Union| 66 '#2#) (|Integer|)
              (|Matrix| 6) (|Record| (|:| |mat| 67) (|:| |vec| (|Vector| 6)))
              (|Record| (|:| |quotient| $) (|:| |remainder| $)) (|List| 57)
              (|Record| (|:| |var| 7) (|:| |exponent| 57))
              (|Union| 71 '#3="failed") (|Union| 41 '#3#) (|Equation| $)
              (|List| 74) (|Mapping| 6 6) (|List| 56) (|List| 6)
              (|Union| 6 '#2#) (|Mapping| 56 56) (|Union| 7 '"failed")
              (|SparseUnivariatePolynomial| 6) (|Union| '"failed" (|List| 70))
              (|Record| (|:| |Sys| 41) (|:| JM 85) (|:| |Depend| 83))
              (|SparseEchelonMatrix| 7 $)
              (|Record| (|:| |DPhi| $) (|:| |JVars| 9)) (|PositiveInteger|)
              (|Record| (|:| |DSys| 41) (|:| |JVars| 37)) (|Symbol|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| 89) (|HashState|) (|SingleInteger|))
           '#(|variables| 115 |subst| 120 |solveFor| 127 |retract| 133
              |numerator| 138 |jetVariables| 143 |ground?| 148 |groebner| 153
              |eval| 158 |differentiate| 165 |denominator| 171 |coerce| 176
              |One| 181 / 185 - 191 * 197)
           'NIL
           (CONS
            (|makeByteWordVec2| 28
                                '(0 0 11 0 0 11 0 0 0 0 0 9 0 0 0 1 2 3 24 9 10
                                  9 0 0 0 0 0 0 0 1 4 0 0 0 0 1 0 0 0 0 0 0 1 1
                                  0 0 0 0 0 0 0 0 0 0 0 8 25 26 0 0 0 0 5 6 13
                                  0 0 0 0 0 0 0 0 0 0 5 6 7 27 28 12 13))
            (CONS
             '#(|PolynomialCategory&| |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |JetBundleFunctionCategory&|
                |FiniteAbelianMonoidRing&| |UniqueFactorizationDomain&|
                |AbelianMonoidRing&| |GcdDomain&| NIL NIL NIL
                |FullyLinearlyExplicitOver&| |PartialDifferentialRing&|
                |EntireRing&| |Algebra&| |Algebra&| NIL NIL |Algebra&| NIL NIL
                |PartialDifferentialRing&| NIL |FreeModuleCategory&| |Rng&| NIL
                NIL NIL |Module&| |Module&| |Module&| NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL |NonAssociativeRng&|
                NIL NIL NIL |AbelianGroup&| NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |FullyRetractableTo&|
                |Magma&| |AbelianSemiGroup&| NIL NIL NIL |RetractableTo&|
                |RetractableTo&| NIL |SetCategory&| |RetractableTo&|
                |RetractableTo&| |Evalable&| NIL |InnerEvalable&|
                |InnerEvalable&| NIL NIL NIL NIL NIL |BasicType&| NIL NIL NIL
                NIL NIL NIL NIL |InnerEvalable&|)
             (CONS
              '#((|PolynomialCategory| 6 (|IndexedExponents| 7) 7)
                 (|MaybeSkewPolynomialCategory| 6 (|IndexedExponents| 7) 7)
                 (|PolynomialFactorizationExplicit|)
                 (|JetBundleFunctionCategory| 7)
                 (|FiniteAbelianMonoidRing| 6 (|IndexedExponents| 7))
                 (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 (|IndexedExponents| 7)) (|GcdDomain|)
                 (|IntegralDomain|) (|LeftOreRing|) (|CommutativeRing|)
                 (|FullyLinearlyExplicitOver| 6) (|PartialDifferentialRing| 89)
                 (|EntireRing|) (|Algebra| $$) (|Algebra| 53)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 6)
                 (|LinearlyExplicitOver| 6) (|LinearlyExplicitOver| 66)
                 (|PartialDifferentialRing| 7) (|Ring|)
                 (|FreeModuleCategory| 6 (|IndexedExponents| 7)) (|Rng|)
                 (|SemiRing|)
                 (|IndexedDirectProductCategory| 6 (|IndexedExponents| 7))
                 (|SemiRng|) (|Module| $$) (|Module| 53) (|Module| 6)
                 (|IndexedProductCategory| 6 (|IndexedExponents| 7))
                 (|BiModule| 6 6) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|BiModule| 53 53) (|AbelianProductCategory| 6)
                 (|LeftModule| 6) (|RightModule| 6) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| 53)
                 (|RightModule| 53) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|FullyRetractableTo| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 66)
                 (|RetractableTo| 6) (|RetractableTo| 7) (|CommutativeStar|)
                 (|SetCategory|) (|RetractableTo| 53) (|RetractableTo| 66)
                 (|Evalable| $$) (|VariablesCommuteWithCoefficients|)
                 (|InnerEvalable| 7 $$) (|InnerEvalable| 7 6)
                 (|CoercibleFrom| 6) (|CoercibleFrom| 7) (|noZeroDivisors|)
                 (|TwoSidedRecip|) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 31) (|CoercibleFrom| 53) (|CoercibleFrom| 66)
                 (|canonicalUnitNormal|) (|ConvertibleTo| 46)
                 (|ConvertibleTo| 47) (|ConvertibleTo| 45)
                 (|InnerEvalable| $$ $$))
              (|makeByteWordVec2| 42
                                  '(1 0 9 0 10 3 0 0 0 7 0 12 0 0 0 15 2 0 0 0
                                    7 17 1 0 18 0 19 1 0 6 0 20 0 6 0 21 2 0 0
                                    0 6 22 2 0 0 0 0 23 1 0 0 7 24 2 0 0 0 0 25
                                    2 0 26 0 7 27 1 6 26 0 28 2 0 0 6 0 29 1 31
                                    0 30 32 1 31 33 0 34 2 9 0 0 0 35 3 37 9 36
                                    0 9 38 1 9 31 0 39 2 31 0 0 0 40 1 0 41 41
                                    42 1 0 9 0 10 3 0 0 0 7 0 13 2 0 26 0 7 27
                                    1 0 6 0 20 1 0 0 0 14 1 0 9 0 11 1 0 18 0
                                    19 1 23 41 41 42 3 0 0 0 7 0 12 2 0 0 0 7
                                    17 1 0 0 0 16 1 0 0 7 24 0 0 0 15 2 21 0 0
                                    6 22 2 0 0 0 0 25 2 0 0 6 0 29 2 0 0 0 0
                                    23)))))
           '|lookupIncomplete|)) 
