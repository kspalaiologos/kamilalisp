
(PUT '|NSUP;rep| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |NSUP;rep|
        ((|s| ($))
         ($ (|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R)))))
        |s|) 

(PUT '|NSUP;per| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |NSUP;per|
        ((|l| (|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
         ($ ($)))
        |l|) 

(PUT '|NSUP;coerce;$Sup;3| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |NSUP;coerce;$Sup;3| ((|p| ($)) ($ (|SparseUnivariatePolynomial| R)))
        |p|) 

(PUT '|NSUP;coerce;Sup$;4| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |NSUP;coerce;Sup$;4| ((|p| (|SparseUnivariatePolynomial| R)) ($ ($)))
        |p|) 

(PUT '|NSUP;retractIfCan;$U;5| '|SPADreplace| '(XLAM (|p|) (CONS 0 |p|))) 

(SDEFUN |NSUP;retractIfCan;$U;5|
        ((|p| ($)) ($ (|Union| (|SparseUnivariatePolynomial| R) "failed")))
        (CONS 0 |p|)) 

(SDEFUN |NSUP;monicModulo;3$;6| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((#1=#:G747 NIL)
          (|xx|
           #2=(|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|u| (|Union| (|NonNegativeInteger|) "failed"))
          (|e| (|NonNegativeInteger|)) (|yy| #2#))
         (SEQ
          (COND
           ((SPADCALL |y| (QREFELT $ 12))
            (|error| "in monicModulo$NSUP: division by 0"))
           ((SPADCALL |y| (QREFELT $ 13))
            (|error| "in monicModulo$NSUP: ground? #2"))
           (#3='T
            (SEQ (LETT |yy| (|NSUP;rep| |y| $))
                 (COND
                  ((NULL
                    (SPADCALL (QCDR (|SPADfirst| |yy|)) (|spadConstant| $ 14)
                              (QREFELT $ 15)))
                   (EXIT (|error| "in monicModulo$NSUP: not monic #2"))))
                 (LETT |xx| (|NSUP;rep| |x| $))
                 (EXIT
                  (COND ((NULL |xx|) |x|)
                        (#3#
                         (SEQ (LETT |e| (QCAR (|SPADfirst| |yy|)))
                              (LETT |y| (|NSUP;per| (CDR |yy|) $))
                              (SEQ
                               (EXIT
                                (SEQ G190 NIL
                                     (SEQ
                                      (SEQ
                                       (LETT |u|
                                             (SPADCALL
                                              (QCAR (|SPADfirst| |xx|)) |e|
                                              (QREFELT $ 18)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |u| 1)
                                          (PROGN
                                           (LETT #1# 1)
                                           (GO #4=#:G741))))))
                                      (LETT |xx|
                                            (|NSUP;rep|
                                             (SPADCALL
                                              (|NSUP;per| (CDR |xx|) $)
                                              (QCDR |u|)
                                              (QCDR (|SPADfirst| |xx|)) |y|
                                              (QREFELT $ 19))
                                             $))
                                      (EXIT
                                       (COND
                                        ((NULL |xx|)
                                         (PROGN (LETT #1# 1) (GO #4#))))))
                                     NIL (GO G190) G191 (EXIT NIL)))
                               #4# (EXIT #1#))
                              (EXIT (|NSUP;per| |xx| $)))))))))))) 

(SDEFUN |NSUP;lazyResidueClass;2$R;7|
        ((|x| ($)) (|y| ($))
         ($
          (|Record| (|:| |polnum| $) (|:| |polden| R)
                    (|:| |power| (|NonNegativeInteger|)))))
        (SPROG
         ((#1=#:G762 NIL) (|pow| (|NonNegativeInteger|))
          (|xx|
           #2=(|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|u| (|Union| (|NonNegativeInteger|) "failed"))
          (|e| (|NonNegativeInteger|)) (|co| (R)) (|yy| #2#))
         (SEQ
          (COND
           ((SPADCALL |y| (QREFELT $ 12))
            (|error| "in lazyResidueClass$NSUP: division by 0"))
           ((SPADCALL |y| (QREFELT $ 13))
            (|error| "in lazyResidueClass$NSUP: ground? #2"))
           (#3='T
            (SEQ (LETT |yy| (|NSUP;rep| |y| $))
                 (LETT |co| (QCDR (|SPADfirst| |yy|)))
                 (LETT |xx| (|NSUP;rep| |x| $))
                 (EXIT
                  (COND ((NULL |xx|) (VECTOR |x| |co| 0))
                        (#3#
                         (SEQ (LETT |pow| 0)
                              (LETT |e| (QCAR (|SPADfirst| |yy|)))
                              (LETT |y| (|NSUP;per| (CDR |yy|) $))
                              (SEQ
                               (EXIT
                                (SEQ G190 NIL
                                     (SEQ
                                      (SEQ
                                       (LETT |u|
                                             (SPADCALL
                                              (QCAR (|SPADfirst| |xx|)) |e|
                                              (QREFELT $ 18)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |u| 1)
                                          (PROGN
                                           (LETT #1# 1)
                                           (GO #4=#:G755))))))
                                      (LETT |xx|
                                            (|NSUP;rep|
                                             (SPADCALL
                                              (SPADCALL |co|
                                                        (|NSUP;per| (CDR |xx|)
                                                         $)
                                                        (QREFELT $ 23))
                                              (QCDR |u|)
                                              (QCDR (|SPADfirst| |xx|)) |y|
                                              (QREFELT $ 19))
                                             $))
                                      (LETT |pow| (+ |pow| 1))
                                      (EXIT
                                       (COND
                                        ((NULL |xx|)
                                         (PROGN (LETT #1# 1) (GO #4#))))))
                                     NIL (GO G190) G191 (EXIT NIL)))
                               #4# (EXIT #1#))
                              (EXIT
                               (VECTOR (|NSUP;per| |xx| $) |co|
                                       |pow|)))))))))))) 

(SDEFUN |NSUP;lazyPseudoRemainder;3$;8| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((#1=#:G777 NIL)
          (|xx|
           #2=(|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|u| (|Union| (|NonNegativeInteger|) "failed"))
          (|e| (|NonNegativeInteger|)) (|co| (R)) (|yy| #2#))
         (SEQ
          (COND
           ((SPADCALL |y| (QREFELT $ 12))
            (|error| "in lazyPseudoRemainder$NSUP: division by 0"))
           ((SPADCALL |y| (QREFELT $ 13))
            (|error| "in lazyPseudoRemainder$NSUP: ground? #2"))
           ((SPADCALL |x| (QREFELT $ 13)) |x|)
           (#3='T
            (SEQ (LETT |yy| (|NSUP;rep| |y| $))
                 (LETT |co| (QCDR (|SPADfirst| |yy|)))
                 (EXIT
                  (COND
                   ((SPADCALL |co| (|spadConstant| $ 14) (QREFELT $ 15))
                    (SPADCALL |x| |y| (QREFELT $ 20)))
                   ((SPADCALL |co|
                              (SPADCALL (|spadConstant| $ 14) (QREFELT $ 27))
                              (QREFELT $ 15))
                    (SPADCALL
                     (SPADCALL (SPADCALL |x| (QREFELT $ 28))
                               (SPADCALL |y| (QREFELT $ 28)) (QREFELT $ 20))
                     (QREFELT $ 28)))
                   (#3#
                    (SEQ (LETT |xx| (|NSUP;rep| |x| $))
                         (LETT |e| (QCAR (|SPADfirst| |yy|)))
                         (LETT |y| (|NSUP;per| (CDR |yy|) $))
                         (SEQ
                          (EXIT
                           (SEQ G190 NIL
                                (SEQ
                                 (SEQ
                                  (LETT |u|
                                        (SPADCALL (QCAR (|SPADfirst| |xx|)) |e|
                                                  (QREFELT $ 18)))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |u| 1)
                                     (PROGN (LETT #1# 1) (GO #4=#:G769))))))
                                 (LETT |xx|
                                       (|NSUP;rep|
                                        (SPADCALL
                                         (SPADCALL |co|
                                                   (|NSUP;per| (CDR |xx|) $)
                                                   (QREFELT $ 23))
                                         (QCDR |u|) (QCDR (|SPADfirst| |xx|))
                                         |y| (QREFELT $ 19))
                                        $))
                                 (EXIT
                                  (COND
                                   ((NULL |xx|)
                                    (PROGN (LETT #1# 1) (GO #4#))))))
                                NIL (GO G190) G191 (EXIT NIL)))
                          #4# (EXIT #1#))
                         (EXIT (|NSUP;per| |xx| $)))))))))))) 

(SDEFUN |NSUP;lazyPseudoDivide;2$R;9|
        ((|x| ($)) (|y| ($))
         ($
          (|Record| (|:| |coef| R) (|:| |gap| (|NonNegativeInteger|))
                    (|:| |quotient| $) (|:| |remainder| $))))
        (SPROG
         ((#1=#:G794 NIL) (|pow| (|NonNegativeInteger|)) (#2=#:G782 NIL)
          (|xx|
           #3=(|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|qq|
           (|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|u| (|Union| (|NonNegativeInteger|) #4="failed")) (|co| (R))
          (|e| (|NonNegativeInteger|)) (|yy| #3#))
         (SEQ
          (COND
           ((SPADCALL |y| (QREFELT $ 12))
            (|error| "in lazyPseudoDivide$NSUP: division by 0"))
           ((SPADCALL |y| (QREFELT $ 13))
            (|error| "in lazyPseudoDivide$NSUP: ground? #2"))
           ('T
            (SEQ (LETT |yy| (|NSUP;rep| |y| $))
                 (LETT |e| (QCAR (|SPADfirst| |yy|)))
                 (LETT |xx| (|NSUP;rep| |x| $))
                 (LETT |co| (QCDR (|SPADfirst| |yy|)))
                 (COND
                  ((OR (NULL |xx|) (< (QCAR (|SPADfirst| |xx|)) |e|))
                   (EXIT (VECTOR |co| 0 (|spadConstant| $ 21) |x|))))
                 (LETT |pow|
                       (+
                        (PROG2
                            (LETT #2#
                                  (SPADCALL (QCAR (|SPADfirst| |xx|)) |e|
                                            (QREFELT $ 18)))
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                          (|Union| (|NonNegativeInteger|) #4#)
                                          #2#))
                        1))
                 (LETT |qq| NIL) (LETT |y| (|NSUP;per| (CDR |yy|) $))
                 (SEQ
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (SEQ
                          (LETT |u|
                                (SPADCALL (QCAR (|SPADfirst| |xx|)) |e|
                                          (QREFELT $ 18)))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (PROGN (LETT #1# 1) (GO #5=#:G787))))))
                         (LETT |qq|
                               (CONS
                                (CONS (QCDR |u|) (QCDR (|SPADfirst| |xx|)))
                                (|NSUP;rep|
                                 (SPADCALL |co| (|NSUP;per| |qq| $)
                                           (QREFELT $ 23))
                                 $)))
                         (LETT |xx|
                               (|NSUP;rep|
                                (SPADCALL
                                 (SPADCALL |co| (|NSUP;per| (CDR |xx|) $)
                                           (QREFELT $ 23))
                                 (QCDR |u|) (QCDR (|SPADfirst| |xx|)) |y|
                                 (QREFELT $ 19))
                                $))
                         (LETT |pow|
                               (PROG2
                                   (LETT #2# (SPADCALL |pow| 1 (QREFELT $ 18)))
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0)
                                                 (|NonNegativeInteger|)
                                                 (|Union|
                                                  (|NonNegativeInteger|) #4#)
                                                 #2#)))
                         (EXIT
                          (COND ((NULL |xx|) (PROGN (LETT #1# 1) (GO #5#))))))
                        NIL (GO G190) G191 (EXIT NIL)))
                  #5# (EXIT #1#))
                 (EXIT
                  (VECTOR |co| |pow| (|NSUP;per| (REVERSE |qq|) $)
                          (|NSUP;per| |xx| $))))))))) 

(SDEFUN |NSUP;lazyPseudoQuotient;3$;10| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((#1=#:G809 NIL)
          (|xx|
           #2=(|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|qq|
           (|List| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
          (|u| (|Union| (|NonNegativeInteger|) "failed")) (|co| (R))
          (|e| (|NonNegativeInteger|)) (|yy| #2#))
         (SEQ
          (COND
           ((SPADCALL |y| (QREFELT $ 12))
            (|error| "in lazyPseudoQuotient$NSUP: division by 0"))
           ((SPADCALL |y| (QREFELT $ 13))
            (|error| "in lazyPseudoQuotient$NSUP: ground? #2"))
           ('T
            (SEQ (LETT |yy| (|NSUP;rep| |y| $))
                 (LETT |e| (QCAR (|SPADfirst| |yy|)))
                 (LETT |xx| (|NSUP;rep| |x| $))
                 (COND
                  ((OR (NULL |xx|) (< (QCAR (|SPADfirst| |xx|)) |e|))
                   (EXIT (|spadConstant| $ 21))))
                 (LETT |qq| NIL) (LETT |co| (QCDR (|SPADfirst| |yy|)))
                 (LETT |y| (|NSUP;per| (CDR |yy|) $))
                 (SEQ
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (SEQ
                          (LETT |u|
                                (SPADCALL (QCAR (|SPADfirst| |xx|)) |e|
                                          (QREFELT $ 18)))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (PROGN (LETT #1# 1) (GO #3=#:G803))))))
                         (LETT |qq|
                               (CONS
                                (CONS (QCDR |u|) (QCDR (|SPADfirst| |xx|)))
                                (|NSUP;rep|
                                 (SPADCALL |co| (|NSUP;per| |qq| $)
                                           (QREFELT $ 23))
                                 $)))
                         (LETT |xx|
                               (|NSUP;rep|
                                (SPADCALL
                                 (SPADCALL |co| (|NSUP;per| (CDR |xx|) $)
                                           (QREFELT $ 23))
                                 (QCDR |u|) (QCDR (|SPADfirst| |xx|)) |y|
                                 (QREFELT $ 19))
                                $))
                         (EXIT
                          (COND ((NULL |xx|) (PROGN (LETT #1# 1) (GO #3#))))))
                        NIL (GO G190) G191 (EXIT NIL)))
                  #3# (EXIT #1#))
                 (EXIT (|NSUP;per| (REVERSE |qq|) $)))))))) 

(SDEFUN |NSUP;subResultantGcd;3$;11| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPADCALL |p1| |p2| (QREFELT $ 34))) 

(SDEFUN |NSUP;subResultantsChain;2$L;12| ((|p1| ($)) (|p2| ($)) ($ (|List| $)))
        (SPADCALL |p1| |p2| (QREFELT $ 37))) 

(SDEFUN |NSUP;lastSubResultant;3$;13| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPADCALL |p1| |p2| (QREFELT $ 40))) 

(SDEFUN |NSUP;resultant;2$R;14| ((|p1| ($)) (|p2| ($)) ($ (R)))
        (SPADCALL |p1| |p2| (QREFELT $ 42))) 

(SDEFUN |NSUP;extendedResultant;2$R;15|
        ((|p1| ($)) (|p2| ($))
         ($ (|Record| (|:| |resultant| R) (|:| |coef1| $) (|:| |coef2| $))))
        (SPROG
         ((|re|
           (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |resultant| R))))
         (SEQ (LETT |re| (SPADCALL |p1| |p2| (QREFELT $ 45)))
              (EXIT (VECTOR (QVELT |re| 2) (QVELT |re| 0) (QVELT |re| 1)))))) 

(SDEFUN |NSUP;halfExtendedResultant1;2$R;16|
        ((|p1| ($)) (|p2| ($))
         ($ (|Record| (|:| |resultant| R) (|:| |coef1| $))))
        (SPROG ((|re| (|Record| (|:| |coef1| $) (|:| |resultant| R))))
               (SEQ (LETT |re| (SPADCALL |p1| |p2| (QREFELT $ 49)))
                    (EXIT (CONS (QCDR |re|) (QCAR |re|)))))) 

(SDEFUN |NSUP;halfExtendedResultant2;2$R;17|
        ((|p1| ($)) (|p2| ($))
         ($ (|Record| (|:| |resultant| R) (|:| |coef2| $))))
        (SPROG ((|re| (|Record| (|:| |coef2| $) (|:| |resultant| R))))
               (SEQ (LETT |re| (SPADCALL |p1| |p2| (QREFELT $ 53)))
                    (EXIT (CONS (QCDR |re|) (QCAR |re|)))))) 

(SDEFUN |NSUP;extendedSubResultantGcd;2$R;18|
        ((|p1| ($)) (|p2| ($))
         ($ (|Record| (|:| |gcd| $) (|:| |coef1| $) (|:| |coef2| $))))
        (SPROG
         ((|re| (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |gcd| $))))
         (SEQ (LETT |re| (SPADCALL |p1| |p2| (QREFELT $ 57)))
              (EXIT (VECTOR (QVELT |re| 2) (QVELT |re| 0) (QVELT |re| 1)))))) 

(SDEFUN |NSUP;halfExtendedSubResultantGcd1;2$R;19|
        ((|p1| ($)) (|p2| ($)) ($ (|Record| (|:| |gcd| $) (|:| |coef1| $))))
        (SPROG ((|re| (|Record| (|:| |coef1| $) (|:| |gcd| $))))
               (SEQ (LETT |re| (SPADCALL |p1| |p2| (QREFELT $ 61)))
                    (EXIT (CONS (QCDR |re|) (QCAR |re|)))))) 

(SDEFUN |NSUP;halfExtendedSubResultantGcd2;2$R;20|
        ((|p1| ($)) (|p2| ($)) ($ (|Record| (|:| |gcd| $) (|:| |coef2| $))))
        (SPROG ((|re| (|Record| (|:| |coef2| $) (|:| |gcd| $))))
               (SEQ (LETT |re| (SPADCALL |p1| |p2| (QREFELT $ 65)))
                    (EXIT (CONS (QCDR |re|) (QCAR |re|)))))) 

(DECLAIM (NOTINLINE |NewSparseUnivariatePolynomial;|)) 

(DEFUN |NewSparseUnivariatePolynomial| (#1=#:G917)
  (SPROG NIL
         (PROG (#2=#:G918)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|NewSparseUnivariatePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|NewSparseUnivariatePolynomial;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|NewSparseUnivariatePolynomial|)))))))))) 

(DEFUN |NewSparseUnivariatePolynomial;| (|#1|)
  (SPROG
   ((#1=#:G916 NIL) (|pv$| NIL) (#2=#:G909 NIL) (#3=#:G910 NIL) (#4=#:G911 NIL)
    (#5=#:G912 NIL) (#6=#:G913 NIL) (#7=#:G914 NIL) (#8=#:G915 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|NewSparseUnivariatePolynomial| DV$1))
    (LETT $ (GETREFV 124))
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
                                        (|HasCategory| |#1| '(|Ring|))
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
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory|
                                          (|SingletonAsOrderedSet|)
                                          '(|ConvertibleTo| (|InputForm|))))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|EntireRing|))
                                        (LETT #8#
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|)))
                                        (OR (|HasCategory| |#1| '(|Field|)) #8#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         #8#)
                                        (LETT #7#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1| '(|Field|)) #8#
                                         #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR (|HasCategory| |#1| '(|Field|)) #8#
                                            #7#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #8# #7#)
                                        (|HasCategory| |#1| '(|StepThrough|))
                                        (|HasCategory| |#1|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         (|HasCategory| |#1| '(|Field|)) #8#
                                         #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|Comparable|))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (LETT #6#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Float|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
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
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         #6#)
                                        (LETT #5#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Integer|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|PatternMatchable|
                                                  (|Integer|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Float|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Float|))))))
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
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         #4#)
                                        (LETT #3#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Integer|))))))
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
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         #3#)
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         #2#)
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         #2#)))))
    (|haddProp| |$ConstructorCache| '|NewSparseUnivariatePolynomial|
                (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 4398046511104))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 8796093022208))
    (AND (OR (|HasCategory| |#1| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 17592186044416))
    (AND
     (OR (|HasCategory| |#1| '(|EntireRing|))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 35184372088832))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      #8# (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 70368744177664))
    (AND
     (OR (|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|Ring|)))
     (|augmentPredVector| $ 140737488355328))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#1| '(|SemiRing|)))
     (|augmentPredVector| $ 281474976710656))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#1| '(|Ring|)))
     (|augmentPredVector| $ 562949953421312))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 1125899906842624))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|AbelianGroup|))
           (|HasCategory| |#1| '(|CommutativeRing|)))
      #2#
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 2251799813685248))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianGroup|))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 4503599627370496))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 20)
      (PROGN
       (QSETREFV $ 35
                 (CONS (|dispatchFunction| |NSUP;subResultantGcd;3$;11|) $))
       (QSETREFV $ 39
                 (CONS (|dispatchFunction| |NSUP;subResultantsChain;2$L;12|)
                       $))
       (QSETREFV $ 41
                 (CONS (|dispatchFunction| |NSUP;lastSubResultant;3$;13|) $))
       (QSETREFV $ 43 (CONS (|dispatchFunction| |NSUP;resultant;2$R;14|) $))
       (QSETREFV $ 47
                 (CONS (|dispatchFunction| |NSUP;extendedResultant;2$R;15|) $))
       (QSETREFV $ 51
                 (CONS
                  (|dispatchFunction| |NSUP;halfExtendedResultant1;2$R;16|) $))
       (QSETREFV $ 55
                 (CONS
                  (|dispatchFunction| |NSUP;halfExtendedResultant2;2$R;17|) $))
       (QSETREFV $ 59
                 (CONS
                  (|dispatchFunction| |NSUP;extendedSubResultantGcd;2$R;18|)
                  $))
       (QSETREFV $ 63
                 (CONS
                  (|dispatchFunction|
                   |NSUP;halfExtendedSubResultantGcd1;2$R;19|)
                  $))
       (QSETREFV $ 67
                 (CONS
                  (|dispatchFunction|
                   |NSUP;halfExtendedSubResultantGcd2;2$R;20|)
                  $)))))
    $))) 

(MAKEPROP '|NewSparseUnivariatePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseUnivariatePolynomial| 6)
              (|local| |#1|) |NSUP;coerce;$Sup;3| |NSUP;coerce;Sup$;4|
              (|Union| 5 '"failed") |NSUP;retractIfCan;$U;5| (|Boolean|)
              (0 . |zero?|) (5 . |ground?|) (10 . |One|) (14 . =)
              (|Union| $ '"failed") (|NonNegativeInteger|)
              (20 . |subtractIfCan|) (26 . |fmecg|) |NSUP;monicModulo;3$;6|
              (34 . |Zero|) (38 . |Zero|) (42 . *) (48 . |One|)
              (|Record| (|:| |polnum| $) (|:| |polden| 6) (|:| |power| 17))
              |NSUP;lazyResidueClass;2$R;7| (52 . -) (57 . -)
              |NSUP;lazyPseudoRemainder;3$;8|
              (|Record| (|:| |coef| 6) (|:| |gap| 17) (|:| |quotient| $)
                        (|:| |remainder| $))
              |NSUP;lazyPseudoDivide;2$R;9| |NSUP;lazyPseudoQuotient;3$;10|
              (|PseudoRemainderSequence| 6 $$) (62 . |subResultantGcd|)
              (68 . |subResultantGcd|) (|List| $$) (74 . |chainSubResultants|)
              (|List| $) (80 . |subResultantsChain|) (86 . |lastSubResultant|)
              (92 . |lastSubResultant|) (98 . |resultant|) (104 . |resultant|)
              (|Record| (|:| |coef1| $$) (|:| |coef2| $$) (|:| |resultant| 6))
              (110 . |resultantEuclidean|)
              (|Record| (|:| |resultant| 6) (|:| |coef1| $) (|:| |coef2| $))
              (116 . |extendedResultant|)
              (|Record| (|:| |coef1| $$) (|:| |resultant| 6))
              (122 . |semiResultantEuclidean1|)
              (|Record| (|:| |resultant| 6) (|:| |coef1| $))
              (128 . |halfExtendedResultant1|)
              (|Record| (|:| |coef2| $$) (|:| |resultant| 6))
              (134 . |semiResultantEuclidean2|)
              (|Record| (|:| |resultant| 6) (|:| |coef2| $))
              (140 . |halfExtendedResultant2|)
              (|Record| (|:| |coef1| $$) (|:| |coef2| $$) (|:| |gcd| $$))
              (146 . |subResultantGcdEuclidean|)
              (|Record| (|:| |gcd| $) (|:| |coef1| $) (|:| |coef2| $))
              (152 . |extendedSubResultantGcd|)
              (|Record| (|:| |coef1| $$) (|:| |gcd| $$))
              (158 . |semiSubResultantGcdEuclidean1|)
              (|Record| (|:| |gcd| $) (|:| |coef1| $))
              (164 . |halfExtendedSubResultantGcd1|)
              (|Record| (|:| |coef2| $$) (|:| |gcd| $$))
              (170 . |semiSubResultantGcdEuclidean2|)
              (|Record| (|:| |gcd| $) (|:| |coef2| $))
              (176 . |halfExtendedSubResultantGcd2|) (|Union| 74 '#1="failed")
              (|Matrix| $) (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 81)
              (|Record| (|:| |mat| 75) (|:| |vec| (|Vector| 81))) (|Vector| $)
              (|Matrix| 81) (|Symbol|) (|List| 76) (|List| 17)
              (|PatternMatchResult| (|Float|) $) (|PatternMatchResult| 81 $)
              (|Integer|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 81) (|Record| (|:| |k| 17) (|:| |c| 6)) (|List| 84)
              (|SingletonAsOrderedSet|) (|Mapping| 6 17)
              (|Record| (|:| |coef| 38) (|:| |generator| $))
              (|Union| 38 '"failed")
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 92 '"failed")
              (|Fraction| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |primePart| $) (|:| |commonPart| $))
              (|Factored| $)
              (|Record| (|:| |coef| 6) (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 94 '"failed") (|Factored| 96) (|Union| 103 '#1#)
              (|List| 96) (|Union| 83 '#2="failed") (|Union| 81 '#2#)
              (|Mapping| 6 6) (|List| 86) (|Matrix| 6)
              (|Record| (|:| |mat| 108) (|:| |vec| 115)) (|Union| 86 '#2#)
              (|Equation| $) (|List| 111)
              (|Record| (|:| |var| 86) (|:| |exponent| 17))
              (|Union| 113 '"failed") (|Vector| 6) (|List| 6) (|Mapping| 17 17)
              (|Union| 6 '#2#) (|PositiveInteger|) (|HashState|) (|String|)
              (|OutputForm|) (|SingleInteger|))
           '#(~= 182 |zero?| 188 |vectorise| 193 |variables| 199 |unvectorise|
              204 |unmakeSUP| 209 |univariate| 214 |unitNormal| 225
              |unitCanonical| 230 |unit?| 235 |totalDegreeSorted| 240
              |totalDegree| 246 |support| 257 |subtractIfCan| 262
              |subResultantsChain| 268 |subResultantGcd| 274
              |squareFreePolynomial| 280 |squareFreePart| 285 |squareFree| 290
              |solveLinearPolynomialEquation| 295 |smaller?| 301 |sizeLess?|
              307 |shiftRight| 313 |shiftLeft| 319 |separate| 325 |sample| 331
              |rightRecip| 335 |rightPower| 340 |retractIfCan| 352 |retract|
              377 |resultant| 402 |rem| 415 |reductum| 421 |reducedSystem| 426
              |recip| 448 |quo| 453 |pseudoRemainder| 459 |pseudoQuotient| 465
              |pseudoDivide| 471 |principalIdeal| 477 |primitivePart| 482
              |primitiveMonomials| 493 |prime?| 498 |pomopo!| 503
              |patternMatch| 511 |order| 525 |opposite?| 531 |one?| 537
              |numberOfMonomials| 542 |nextItem| 547 |multivariate| 552
              |multiplyExponents| 564 |multiEuclidean| 570 |monomials| 576
              |monomial?| 581 |monomial| 586 |monicModulo| 606 |monicDivide|
              612 |minimumDegree| 625 |mapExponents| 642 |map| 648 |makeSUP|
              654 |mainVariable| 659 |listOfTerms| 664 |linearExtend| 669
              |leftRecip| 675 |leftPower| 680 |leadingTerm| 692
              |leadingSupport| 697 |leadingMonomial| 702 |leadingCoefficient|
              707 |lcmCoef| 712 |lcm| 718 |lazyResidueClass| 729
              |lazyPseudoRemainder| 735 |lazyPseudoQuotient| 741
              |lazyPseudoDivide| 747 |latex| 753 |lastSubResultant| 758
              |karatsubaDivide| 764 |isTimes| 770 |isPlus| 775 |isExpt| 780
              |integrate| 785 |init| 790 |hashUpdate!| 794 |hash| 800
              |halfExtendedSubResultantGcd2| 805 |halfExtendedSubResultantGcd1|
              811 |halfExtendedResultant2| 817 |halfExtendedResultant1| 823
              |ground?| 829 |ground| 834 |gcdPolynomial| 839 |gcd| 845 |fmecg|
              856 |factorSquareFreePolynomial| 864 |factorPolynomial| 869
              |factor| 874 |extendedSubResultantGcd| 879 |extendedResultant|
              885 |extendedEuclidean| 891 |exquo| 904 |expressIdealMember| 916
              |eval| 922 |euclideanSize| 976 |elt| 981 |divideExponents| 1011
              |divide| 1017 |discriminant| 1023 |differentiate| 1034 |degree|
              1117 |convert| 1134 |content| 1149 |constructOrdered| 1160
              |construct| 1165 |conditionP| 1170 |composite| 1175 |commutator|
              1187 |coerce| 1193 |coefficients| 1233 |coefficient| 1238
              |charthRoot| 1258 |characteristic| 1263 |binomThmExpt| 1267
              |associator| 1274 |associates?| 1281 |antiCommutator| 1287
              |annihilate?| 1293 ^ 1299 |Zero| 1311 |One| 1315 D 1319 = 1395 /
              1401 - 1407 + 1418 * 1424)
           'NIL
           (CONS
            (|makeByteWordVec2| 42
                                '(0 0 0 11 14 0 11 14 0 18 22 4 21 17 4 1 2 3
                                  21 4 10 4 23 19 25 4 26 0 13 26 0 0 1 5 23 0
                                  0 0 1 4 0 0 0 0 0 1 1 26 15 42 13 13 0 0 41
                                  13 0 0 0 9 31 33 24 0 0 0 6 7 13 13 23 0 0 0
                                  0 0 0 0 0 0 0 4 6 7 8 35 37 12 13 13 14 23 16
                                  20))
            (CONS
             '#(|UnivariatePolynomialCategory&| |PolynomialCategory&|
                |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |FiniteAbelianMonoidRing&| |UniqueFactorizationDomain&| NIL
                |AbelianMonoidRing&| |GcdDomain&| NIL
                |FullyLinearlyExplicitOver&| NIL NIL |DifferentialExtension&|
                |Algebra&| NIL NIL |Algebra&| NIL NIL
                |PartialDifferentialRing&| |Algebra&| |EntireRing&|
                |PartialDifferentialRing&| |DifferentialRing&| NIL
                |FreeModuleCategory&| NIL |Rng&| NIL NIL |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&| NIL NIL NIL
                NIL |RetractableTo&| |RetractableTo&| |SetCategory&|
                |RetractableTo&| |RetractableTo&| |Evalable&| |RetractableTo&|
                NIL NIL NIL NIL NIL NIL |InnerEvalable&| |InnerEvalable&| NIL
                |BasicType&| NIL NIL NIL NIL NIL NIL NIL NIL |InnerEvalable&|
                NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariatePolynomialCategory| 6)
                 (|PolynomialCategory| 6 17 86)
                 (|MaybeSkewPolynomialCategory| 6 17 86)
                 (|PolynomialFactorizationExplicit|) (|EuclideanDomain|)
                 (|FiniteAbelianMonoidRing| 6 17) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|AbelianMonoidRing| 6 17)
                 (|GcdDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 6) (|CommutativeRing|)
                 (|LeftOreRing|) (|DifferentialExtension| 6) (|Algebra| 83)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 6)
                 (|LinearlyExplicitOver| 6) (|LinearlyExplicitOver| 81)
                 (|PartialDifferentialRing| 86) (|Algebra| $$) (|EntireRing|)
                 (|PartialDifferentialRing| 76) (|DifferentialRing|) (|Ring|)
                 (|FreeModuleCategory| 6 17) (|SemiRing|) (|Rng|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 6 17) (|Module| 83)
                 (|Module| 6) (|Module| $$) (|IndexedProductCategory| 6 17)
                 (|BiModule| 6 6) (|BiModule| $$ $$) (|BiModule| 83 83)
                 (|NonAssociativeRing|) (|AbelianProductCategory| 6)
                 (|LeftModule| 6) (|RightModule| 6) (|RightModule| $$)
                 (|LeftModule| $$) (|LeftModule| 83) (|RightModule| 83)
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|NonAssociativeSemiRng|) (|SemiGroup|)
                 (|AbelianMonoid|) (|MagmaWithUnit|) (|FullyRetractableTo| 6)
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 81)
                 (|StepThrough|)
                 (|RetractableTo| (|SparseUnivariatePolynomial| 6))
                 (|RetractableTo| 6) (|SetCategory|) (|RetractableTo| 83)
                 (|RetractableTo| 81) (|Evalable| $$) (|RetractableTo| 86)
                 (|CommutativeStar|)
                 (|CoercibleFrom| (|SparseUnivariatePolynomial| 6))
                 (|CoercibleTo| (|SparseUnivariatePolynomial| 6))
                 (|Eltable| $$ $$) (|Eltable| 6 6)
                 (|VariablesCommuteWithCoefficients|) (|InnerEvalable| 86 $$)
                 (|InnerEvalable| 86 6) (|CoercibleFrom| 6) (|BasicType|)
                 (|CoercibleTo| 122) (|unitsKnown|) (|CoercibleFrom| 83)
                 (|CoercibleFrom| 81) (|canonicalUnitNormal|)
                 (|ConvertibleTo| 71) (|ConvertibleTo| 72) (|ConvertibleTo| 70)
                 (|InnerEvalable| $$ $$) (|CoercibleFrom| 86)
                 (|additiveValuation|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|Eltable| (|Fraction| $$) (|Fraction| $$)))
              (|makeByteWordVec2| 123
                                  '(1 0 11 0 12 1 0 11 0 13 0 6 0 14 2 6 11 0 0
                                    15 2 17 16 0 0 18 4 0 0 0 17 6 0 19 0 0 0
                                    21 0 6 0 22 2 0 0 6 0 23 0 0 0 24 1 6 0 0
                                    27 1 0 0 0 28 2 33 2 2 2 34 2 0 0 0 0 35 2
                                    33 36 2 2 37 2 0 38 0 0 39 2 33 2 2 2 40 2
                                    0 0 0 0 41 2 33 6 2 2 42 2 0 6 0 0 43 2 33
                                    44 2 2 45 2 0 46 0 0 47 2 33 48 2 2 49 2 0
                                    50 0 0 51 2 33 52 2 2 53 2 0 54 0 0 55 2 33
                                    56 2 2 57 2 0 58 0 0 59 2 33 60 2 2 61 2 0
                                    62 0 0 63 2 33 64 2 2 65 2 0 66 0 0 67 2 0
                                    11 0 0 1 1 51 11 0 12 2 0 115 0 17 1 1 0
                                    107 0 1 1 0 0 115 1 1 0 0 5 1 2 0 96 0 86 1
                                    1 0 5 0 1 1 46 82 0 1 1 46 0 0 1 1 46 11 0
                                    1 2 0 17 0 107 1 1 0 17 0 1 2 0 17 0 107 1
                                    1 0 78 0 1 2 52 16 0 0 1 2 20 38 0 0 39 2
                                    20 0 0 0 35 1 11 101 96 1 1 17 0 0 1 1 17
                                    98 0 1 2 11 102 103 96 1 2 9 11 0 0 1 2 14
                                    11 0 0 1 2 4 0 0 17 1 2 0 0 0 17 1 2 17 97
                                    0 0 1 0 51 0 1 1 49 16 0 1 2 49 0 0 17 1 2
                                    0 0 0 119 1 1 6 104 0 1 1 7 105 0 1 1 13
                                    110 0 1 1 0 9 0 10 1 0 118 0 1 1 6 83 0 1 1
                                    7 81 0 1 1 13 86 0 1 1 0 5 0 1 1 0 6 0 1 2
                                    5 6 0 0 43 3 5 0 0 0 86 1 2 14 0 0 0 1 1 27
                                    0 0 1 2 29 73 69 74 1 1 29 75 69 1 1 4 108
                                    69 1 2 4 109 69 74 1 1 49 16 0 1 2 14 0 0 0
                                    1 2 4 0 0 0 1 2 20 0 0 0 1 2 20 99 0 0 1 1
                                    14 88 38 1 2 17 0 0 86 1 1 17 0 0 1 1 13 38
                                    0 1 1 11 11 0 1 4 0 0 0 6 17 0 1 3 30 79 0
                                    71 79 1 3 32 80 0 72 80 1 2 20 17 0 0 1 2
                                    51 11 0 0 1 1 49 11 0 1 1 0 17 0 1 1 24 16
                                    0 1 2 0 0 5 86 1 2 0 0 96 86 1 2 0 0 0 17 1
                                    2 14 89 38 0 1 1 0 38 0 1 1 0 11 0 1 3 0 0
                                    0 86 17 1 3 0 0 0 107 78 1 2 0 0 6 17 1 2 0
                                    0 0 0 20 2 4 90 0 0 1 3 4 90 0 0 86 1 2 0
                                    78 0 107 1 2 0 17 0 86 1 1 0 17 0 1 2 0 0
                                    117 0 1 2 0 0 106 0 1 1 0 5 0 1 1 0 110 0 1
                                    1 0 85 0 1 2 5 6 87 0 1 1 49 16 0 1 2 49 0
                                    0 17 1 2 0 0 0 119 1 1 27 84 0 1 1 27 17 0
                                    1 1 27 0 0 1 1 27 6 0 1 2 17 95 0 0 1 2 17
                                    0 0 0 1 1 17 0 38 1 2 0 25 0 0 26 2 0 0 0 0
                                    29 2 0 0 0 0 32 2 0 30 0 0 31 1 0 121 0 1 2
                                    20 0 0 0 41 2 4 90 0 17 1 1 13 89 0 1 1 0
                                    89 0 1 1 13 114 0 1 1 1 0 0 1 0 24 0 1 2 0
                                    120 120 0 1 1 0 123 0 1 2 20 66 0 0 67 2 20
                                    62 0 0 63 2 20 54 0 0 55 2 20 50 0 0 51 1 0
                                    11 0 13 1 0 6 0 1 2 17 96 96 96 1 2 17 0 0
                                    0 1 1 17 0 38 1 4 4 0 0 17 6 0 19 1 11 101
                                    96 1 1 11 101 96 1 1 11 98 0 1 2 20 58 0 0
                                    59 2 20 46 0 0 47 2 14 91 0 0 1 3 14 93 0 0
                                    0 1 2 46 16 0 0 1 2 16 16 0 6 1 2 14 89 38
                                    0 1 3 13 0 0 38 38 1 2 13 0 0 111 1 3 13 0
                                    0 0 0 1 2 13 0 0 112 1 3 0 0 0 86 0 1 3 0 0
                                    0 107 38 1 3 0 0 0 86 6 1 3 0 0 0 107 116 1
                                    1 14 17 0 1 2 14 6 94 6 1 2 20 94 0 94 1 2
                                    20 94 94 94 1 2 0 0 0 0 1 2 0 6 0 6 1 2 0
                                    16 0 17 1 2 14 90 0 0 1 1 5 6 0 1 2 5 0 0
                                    86 1 3 38 0 0 77 78 1 2 38 0 0 77 1 3 38 0
                                    0 76 17 1 2 38 0 0 76 1 1 4 0 0 1 2 4 0 0
                                    17 1 3 4 0 0 106 17 1 2 4 0 0 106 1 3 4 0 0
                                    106 0 1 2 4 0 0 107 1 2 4 0 0 86 1 3 4 0 0
                                    107 78 1 3 4 0 0 86 17 1 2 0 17 0 86 1 2 0
                                    78 0 107 1 1 0 17 0 1 1 12 70 0 1 1 34 71 0
                                    1 1 36 72 0 1 2 17 0 0 86 1 1 17 6 0 1 1 27
                                    0 85 1 1 0 0 85 1 1 44 68 69 1 2 20 16 0 0
                                    1 2 20 100 94 0 1 2 50 0 0 0 1 1 47 0 0 1 1
                                    48 0 81 1 1 28 0 83 1 1 13 0 86 1 1 0 0 5 8
                                    1 0 5 0 7 1 0 0 6 1 1 0 122 0 1 1 0 116 0 1
                                    3 0 0 0 107 78 1 3 0 0 0 86 17 1 2 0 6 0 17
                                    1 1 45 16 0 1 0 50 17 1 3 43 0 0 0 17 1 3
                                    50 0 0 0 0 1 2 46 11 0 0 1 2 0 0 0 0 1 2 50
                                    11 0 0 1 2 49 0 0 17 1 2 0 0 0 119 1 0 51 0
                                    21 0 49 0 24 3 38 0 0 76 17 1 3 38 0 0 77
                                    78 1 2 38 0 0 77 1 2 38 0 0 76 1 1 4 0 0 1
                                    2 4 0 0 17 1 3 4 0 0 106 17 1 2 4 0 0 106 1
                                    2 4 0 0 107 1 2 4 0 0 86 1 3 4 0 0 86 17 1
                                    3 4 0 0 107 78 1 2 0 11 0 0 1 2 14 0 0 6 1
                                    2 53 0 0 0 1 1 53 0 0 28 2 0 0 0 0 1 2 53 0
                                    81 0 1 2 51 0 17 0 1 2 1 0 0 83 1 2 1 0 83
                                    0 1 2 0 0 6 0 23 2 0 0 0 6 1 2 0 0 0 0 1 2
                                    0 0 119 0 1)))))
           '|lookupComplete|)) 
