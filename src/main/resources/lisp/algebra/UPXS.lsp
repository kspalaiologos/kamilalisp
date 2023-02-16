
(PUT '|UPXS;getExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |UPXS;getExpon| ((|pxs| ($)) ($ (|Fraction| (|Integer|)))) (QCAR |pxs|)) 

(SDEFUN |UPXS;variable;$S;2| ((|upxs| ($)) ($ (|Symbol|))) (QREFELT $ 7)) 

(SDEFUN |UPXS;center;$Coef;3| ((|upxs| ($)) ($ (|Coef|))) (QREFELT $ 8)) 

(SDEFUN |UPXS;coerce;Uts$;4|
        ((|uts| (|UnivariateTaylorSeries| |Coef| |var| |cen|)) ($ ($)))
        (SPADCALL (SPADCALL |uts| (QREFELT $ 15)) (QREFELT $ 16))) 

(SDEFUN |UPXS;retractIfCan;$U;5|
        ((|upxs| ($))
         ($ (|Union| (|UnivariateTaylorSeries| |Coef| |var| |cen|) "failed")))
        (SPROG
         ((|ulsIfCan|
           (|Union| (|UnivariateLaurentSeries| |Coef| |var| |cen|) "failed")))
         (SEQ (LETT |ulsIfCan| (SPADCALL |upxs| (QREFELT $ 19)))
              (EXIT
               (COND ((QEQCAR |ulsIfCan| 1) (CONS 1 "failed"))
                     ('T (SPADCALL (QCDR |ulsIfCan|) (QREFELT $ 21)))))))) 

(SDEFUN |UPXS;coerce;V$;6| ((|v| (|Variable| |var|)) ($ ($)))
        (COND
         ((SPADCALL (QREFELT $ 8) (QREFELT $ 24))
          (SPADCALL (|spadConstant| $ 25) (|spadConstant| $ 28)
                    (QREFELT $ 29)))
         ('T
          (SPADCALL
           (SPADCALL (|spadConstant| $ 25) (|spadConstant| $ 28)
                     (QREFELT $ 29))
           (SPADCALL (QREFELT $ 8) (|spadConstant| $ 32) (QREFELT $ 29))
           (QREFELT $ 33))))) 

(SDEFUN |UPXS;differentiate;$V$;7|
        ((|upxs| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |upxs| (QREFELT $ 36))) 

(SDEFUN |UPXS;integrate;$V$;8| ((|upxs| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |upxs| (QREFELT $ 38))) 

(SDEFUN |UPXS;roundDown| ((|rn| (|Fraction| (|Integer|))) ($ (|Integer|)))
        (SPROG ((|n| (|Integer|)) (|num| (|Integer|)) (|den| (|Integer|)))
               (SEQ (LETT |den| (SPADCALL |rn| (QREFELT $ 41)))
                    (EXIT
                     (COND ((EQL |den| 1) (SPADCALL |rn| (QREFELT $ 42)))
                           (#1='T
                            (SEQ
                             (LETT |n|
                                   (QUOTIENT2
                                    (LETT |num| (SPADCALL |rn| (QREFELT $ 42)))
                                    |den|))
                             (EXIT
                              (COND ((PLUSP |num|) |n|) (#1# (- |n| 1))))))))))) 

(SDEFUN |UPXS;stToCoef|
        ((|st| (|Stream| |Coef|)) (|term| (|Coef|))
         (|n| (|NonNegativeInteger|)) (|n0| (|NonNegativeInteger|))
         ($ (|Coef|)))
        (COND
         ((OR (> |n| |n0|) (SPADCALL |st| (QREFELT $ 44)))
          (|spadConstant| $ 30))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |st| (QREFELT $ 45))
                     (SPADCALL |term| |n| (QREFELT $ 47)) (QREFELT $ 48))
           (|UPXS;stToCoef| (SPADCALL |st| (QREFELT $ 49)) |term| (+ |n| 1)
            |n0| $)
           (QREFELT $ 50))))) 

(SDEFUN |UPXS;approximateLaurent|
        ((|x| (|UnivariateLaurentSeries| |Coef| |var| |cen|)) (|term| (|Coef|))
         (|n| (|Integer|)) ($ (|Coef|)))
        (SPROG
         ((|app| (|Coef|)) (#1=#:G749 NIL) (|m| (|Integer|)) (|e| (|Integer|)))
         (SEQ (LETT |m| (- |n| (LETT |e| (SPADCALL |x| (QREFELT $ 51)))))
              (EXIT
               (COND ((< |m| 0) (|spadConstant| $ 30))
                     (#2='T
                      (SEQ
                       (LETT |app|
                             (|UPXS;stToCoef|
                              (SPADCALL (SPADCALL |x| (QREFELT $ 52))
                                        (QREFELT $ 53))
                              |term| 0
                              (PROG1 (LETT #1# |m|)
                                (|check_subtype2| (>= #1# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #1#))
                              $))
                       (EXIT
                        (COND ((ZEROP |e|) |app|)
                              (#2#
                               (SPADCALL |app|
                                         (SPADCALL |term|
                                                   (SPADCALL |e|
                                                             (QREFELT $ 54))
                                                   (QREFELT $ 55))
                                         (QREFELT $ 48)))))))))))) 

(SDEFUN |UPXS;approximate;$FCoef;12|
        ((|x| ($)) (|r| (|Fraction| (|Integer|))) ($ (|Coef|)))
        (SPROG ((|term| (|Coef|)) (|e| (|Fraction| (|Integer|))))
               (SEQ (LETT |e| (SPADCALL |x| (QREFELT $ 56)))
                    (LETT |term|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                      (QREFELT $ 57))
                            (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 58))
                           |e| (QREFELT $ 55)))
                    (EXIT
                     (|UPXS;approximateLaurent| (SPADCALL |x| (QREFELT $ 59))
                      |term|
                      (|UPXS;roundDown| (SPADCALL |r| |e| (QREFELT $ 60)) $)
                      $))))) 

(SDEFUN |UPXS;termOutput|
        ((|k| (|Fraction| (|Integer|))) (|c| (|Coef|)) (|vv| (|OutputForm|))
         ($ (|OutputForm|)))
        (SPROG ((|mon| (|OutputForm|)))
               (SEQ
                (COND
                 ((SPADCALL |k| (|spadConstant| $ 32) (QREFELT $ 62))
                  (SPADCALL |c| (QREFELT $ 64)))
                 (#1='T
                  (SEQ
                   (LETT |mon|
                         (COND
                          ((SPADCALL |k| (|spadConstant| $ 28) (QREFELT $ 62))
                           |vv|)
                          (#1#
                           (SPADCALL |vv| (SPADCALL |k| (QREFELT $ 65))
                                     (QREFELT $ 66)))))
                   (EXIT
                    (COND
                     ((SPADCALL |c| (|spadConstant| $ 25) (QREFELT $ 67))
                      |mon|)
                     ((SPADCALL |c|
                                (SPADCALL (|spadConstant| $ 25) (QREFELT $ 68))
                                (QREFELT $ 67))
                      (SPADCALL |mon| (QREFELT $ 69)))
                     (#1#
                      (SPADCALL (SPADCALL |c| (QREFELT $ 64)) |mon|
                                (QREFELT $ 70))))))))))) 

(PUT '|UPXS;showAll?| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |UPXS;showAll?| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |UPXS;termsToOutputForm|
        ((|m| (|Fraction| (|Integer|))) (|rat| (|Fraction| (|Integer|)))
         (|uu| (|Stream| |Coef|)) (|xxx| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|uu1| (|Stream| |Coef|)) (|n| NIL)
          (#1=#:G794 NIL) (|count| (|NonNegativeInteger|)))
         (SEQ (LETT |l| NIL)
              (EXIT
               (COND
                ((SPADCALL |uu| (QREFELT $ 44))
                 (SPADCALL (|spadConstant| $ 30) (QREFELT $ 64)))
                (#2='T
                 (SEQ (LETT |count| |$streamCount|)
                      (SEQ (LETT |n| 0) (LETT #1# |count|) G190
                           (COND
                            ((OR (|greater_SI| |n| #1#)
                                 (NULL (NULL (SPADCALL |uu| (QREFELT $ 44)))))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL (SPADCALL |uu| (QREFELT $ 45))
                                        (|spadConstant| $ 30) (QREFELT $ 71))
                              (LETT |l|
                                    (CONS
                                     (|UPXS;termOutput|
                                      (SPADCALL
                                       (SPADCALL |n| |rat| (QREFELT $ 72)) |m|
                                       (QREFELT $ 73))
                                      (SPADCALL |uu| (QREFELT $ 45)) |xxx| $)
                                     |l|))))
                            (EXIT (LETT |uu| (SPADCALL |uu| (QREFELT $ 49)))))
                           (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((|UPXS;showAll?| $)
                        (SEQ (LETT |uu1| |uu|)
                             (EXIT
                              (SEQ (LETT |n| (+ |count| 1)) G190
                                   (COND
                                    ((NULL
                                      (COND
                                       ((SPADCALL |uu| (QREFELT $ 74))
                                        (NULL
                                         (SPADCALL |uu1|
                                                   (SPADCALL |uu|
                                                             (QREFELT $ 49))
                                                   (QREFELT $ 75))))
                                       ('T NIL)))
                                     (GO G191)))
                                   (SEQ
                                    (COND
                                     ((SPADCALL (SPADCALL |uu| (QREFELT $ 45))
                                                (|spadConstant| $ 30)
                                                (QREFELT $ 71))
                                      (LETT |l|
                                            (CONS
                                             (|UPXS;termOutput|
                                              (SPADCALL
                                               (SPADCALL |n| |rat|
                                                         (QREFELT $ 72))
                                               |m| (QREFELT $ 73))
                                              (SPADCALL |uu| (QREFELT $ 45))
                                              |xxx| $)
                                             |l|))))
                                    (COND
                                     ((ODDP |n|)
                                      (LETT |uu1|
                                            (SPADCALL |uu1| (QREFELT $ 49)))))
                                    (EXIT
                                     (LETT |uu|
                                           (SPADCALL |uu| (QREFELT $ 49)))))
                                   (LETT |n| (+ |n| 1)) (GO G190) G191
                                   (EXIT NIL))))))
                      (LETT |l|
                            (COND ((SPADCALL |uu| (QREFELT $ 76)) |l|)
                                  (#2#
                                   (SEQ
                                    (COND
                                     ((SPADCALL |uu|
                                                (SPADCALL |uu| (QREFELT $ 49))
                                                (QREFELT $ 75))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |uu| (QREFELT $ 45))
                                         (|spadConstant| $ 30) (QREFELT $ 67))
                                        (EXIT |l|)))))
                                    (EXIT
                                     (CONS
                                      (SPADCALL (SPADCALL 'O (QREFELT $ 77))
                                                (LIST
                                                 (SPADCALL |xxx|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL |n|
                                                                       |rat|
                                                                       (QREFELT
                                                                        $ 72))
                                                             |m|
                                                             (QREFELT $ 73))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 66)))
                                                (QREFELT $ 79))
                                      |l|))))))
                      (EXIT
                       (COND
                        ((NULL |l|)
                         (SPADCALL (|spadConstant| $ 30) (QREFELT $ 64)))
                        (#2#
                         (SPADCALL (ELT $ 80) (NREVERSE |l|)
                                   (QREFELT $ 83)))))))))))) 

(SDEFUN |UPXS;coerce;$Of;16| ((|upxs| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|xxx| (|OutputForm|)) (|p| (|Stream| |Coef|))
          (|m| (|Fraction| (|Integer|)))
          (|uls| (|UnivariateLaurentSeries| |Coef| |var| |cen|))
          (|count| (|Integer|)) (|rat| (|Fraction| (|Integer|))))
         (SEQ (LETT |rat| (|UPXS;getExpon| |upxs| $))
              (LETT |uls| (SPADCALL |upxs| (QREFELT $ 59)))
              (LETT |count| |$streamCount|)
              (LETT |uls| (SPADCALL |count| |uls| (QREFELT $ 84)))
              (LETT |m|
                    (SPADCALL (SPADCALL |uls| (QREFELT $ 51)) |rat|
                              (QREFELT $ 72)))
              (LETT |p|
                    (SPADCALL (SPADCALL |uls| (QREFELT $ 52)) (QREFELT $ 53)))
              (LETT |xxx|
                    (COND
                     ((SPADCALL (QREFELT $ 8) (QREFELT $ 24))
                      (SPADCALL (QREFELT $ 7) (QREFELT $ 77)))
                     ('T
                      (SPADCALL
                       (SPADCALL (SPADCALL (QREFELT $ 7) (QREFELT $ 77))
                                 (SPADCALL (QREFELT $ 8) (QREFELT $ 64))
                                 (QREFELT $ 85))
                       (QREFELT $ 86)))))
              (EXIT (|UPXS;termsToOutputForm| |m| |rat| |p| |xxx| $))))) 

(DECLAIM (NOTINLINE |UnivariatePuiseuxSeries;|)) 

(DEFUN |UnivariatePuiseuxSeries| (&REST #1=#:G835)
  (SPROG NIL
         (PROG (#2=#:G836)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache| '|UnivariatePuiseuxSeries|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |UnivariatePuiseuxSeries;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|UnivariatePuiseuxSeries|)))))))))) 

(DEFUN |UnivariatePuiseuxSeries;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G828 NIL) (#2=#:G829 NIL) (#3=#:G830 NIL) (#4=#:G831 NIL)
    (#5=#:G833 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|UnivariatePuiseuxSeries| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 109))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasSignature| |#1|
                                                        (LIST '*
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Fraction|
                                                                 (|Integer|))
                                                               (|devaluate|
                                                                |#1|))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| (|Fraction| (|Integer|))
                                                       '(|SemiGroup|))
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory| (|Fraction| (|Integer|))
                                                       '(|Comparable|))
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #5#
                                            (|HasCategory| |#1| '(|Field|)))
                                        (|HasSignature| |#1|
                                                        (LIST '^
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Fraction|
                                                                 (|Integer|)))))
                                        (AND
                                         (|HasSignature| |#1|
                                                         (LIST '^
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|)))))
                                         (|HasSignature| |#1|
                                                         (LIST '|coerce|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|integrate|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|variables|
                                                               (LIST
                                                                '(|List|
                                                                  (|Symbol|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR #5# (|HasCategory| |#1| '(|Field|))
                                            #4#)
                                        (OR (|HasCategory| |#1| '(|Field|))
                                            #4#)
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SemiRing|)))
                                        (OR #3#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (LETT #2#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR #2#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         #5# (|HasCategory| |#1| '(|Field|))
                                         #4# #2#
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (|HasCategory| |#1|
                                                       '(|CancellationAbelianMonoid|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         #1#
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (OR #1#
                                            (|HasCategory| |#1|
                                                           '(|CancellationAbelianMonoid|))
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR #1#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))))))
    (|haddProp| |$ConstructorCache| '|UnivariatePuiseuxSeries|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 134217728))
    (AND
     (OR (|HasCategory| |#1| '(|Field|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 268435456))
    (AND
     (OR (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|Field|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 536870912))
    (AND
     (OR (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #3#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 1073741824))
    (AND
     (OR (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #2#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 2147483648))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 4294967296))
    (AND
     (OR (|HasCategory| |#1| '(|CancellationAbelianMonoid|))
         (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 8589934592))
    (AND
     (OR #1# (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 17179869184))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9
              (|Record| (|:| |expon| (|Fraction| (|Integer|)))
                        (|:| |lSeries|
                             (|UnivariateLaurentSeries| |#1| |#2| |#3|))))
    (COND
     ((|testBitVector| |pv$| 3)
      (QSETREFV $ 37
                (CONS (|dispatchFunction| |UPXS;differentiate;$V$;7|) $))))
    (COND
     ((|testBitVector| |pv$| 6)
      (QSETREFV $ 39 (CONS (|dispatchFunction| |UPXS;integrate;$V$;8|) $))))
    (COND
     ((|HasSignature| |#1|
                      (LIST '|coerce| (LIST (|devaluate| |#1|) '(|Symbol|))))
      (COND
       ((|testBitVector| |pv$| 11)
        (PROGN
         (QSETREFV $ 61
                   (CONS (|dispatchFunction| |UPXS;approximate;$FCoef;12|)
                         $)))))))
    $))) 

(MAKEPROP '|UnivariatePuiseuxSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|UnivariatePuiseuxSeriesConstructor| 6 14)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) '|Rep| (|Symbol|)
              |UPXS;variable;$S;2| |UPXS;center;$Coef;3|
              (|UnivariateTaylorSeries| 6 (NRTEVAL (QREFELT $ 7))
                                        (NRTEVAL (QREFELT $ 8)))
              (|UnivariateLaurentSeries| 6 (NRTEVAL (QREFELT $ 7))
                                         (NRTEVAL (QREFELT $ 8)))
              (0 . |coerce|) (5 . |coerce|) |UPXS;coerce;Uts$;4|
              (|Union| 14 '"failed") (10 . |retractIfCan|)
              (|Union| 13 '"failed") (15 . |retractIfCan|)
              |UPXS;retractIfCan;$U;5| (|Boolean|) (20 . |zero?|) (25 . |One|)
              (29 . |One|) (|Fraction| 40) (33 . |One|) (37 . |monomial|)
              (43 . |Zero|) (47 . |Zero|) (51 . |Zero|) (55 . +)
              (|Variable| (NRTEVAL (QREFELT $ 7))) |UPXS;coerce;V$;6|
              (61 . |differentiate|) (66 . |differentiate|) (72 . |integrate|)
              (77 . |integrate|) (|Integer|) (83 . |denom|) (88 . |numer|)
              (|Stream| 6) (93 . |empty?|) (98 . |frst|) (|NonNegativeInteger|)
              (103 . ^) (109 . *) (115 . |rst|) (120 . +) (126 . |degree|)
              (131 . |taylorRep|) (136 . |coefficients|) (141 . |coerce|)
              (146 . ^) (152 . |rationalPower|) (157 . |coerce|) (162 . -)
              (168 . |laurentRep|) (173 . /) (179 . |approximate|) (185 . =)
              (|OutputForm|) (191 . |coerce|) (196 . |coerce|) (201 . ^)
              (207 . =) (213 . -) (218 . -) (223 . *) (229 . ~=) (235 . *)
              (241 . +) (247 . |explicitEntries?|) (252 . |eq?|)
              (258 . |explicitlyEmpty?|) (263 . |coerce|) (|List| $)
              (268 . |prefix|) (274 . +) (|Mapping| 63 63 63) (|List| 63)
              (280 . |reduce|) (286 . |removeZeroes|) (292 . -) (298 . |paren|)
              |UPXS;coerce;$Of;16| (|List| 10) (|List| 46)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |k| 27) (|:| |c| 6)) (|List| 92)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|SparseUnivariatePolynomial| $) (|Union| 78 '"failed")
              (|Record| (|:| |coef| 78) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 99 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Factored| $) (|Stream| 92) (|PositiveInteger|) (|Mapping| 6 6)
              (|String|) (|SingleInteger|) (|HashState|))
           '#(|variable| 303 |retractIfCan| 308 |rationalPower| 318 |monomial|
              323 |laurentRep| 329 |integrate| 334 |differentiate| 345 |coerce|
              356 |center| 376 |approximate| 381 |Zero| 387 |One| 391 + 395)
           'NIL
           (CONS
            (|makeByteWordVec2| 27
                                '(0 0 0 7 0 7 0 7 7 0 7 16 7 15 7 1 2 10 4 3 15
                                  16 6 21 18 21 0 10 15 6 0 0 0 20 6 0 0 0 0 0
                                  21 6 6 27 26 18 18 0 0 25 18 0 0 0 0 0 6 15 0
                                  0 0 0 0 5 6 6 6 6 6 6 20 15 16 7 7))
            (CONS
             '#(|UnivariatePuiseuxSeriesConstructorCategory&| NIL NIL |Field&|
                |UnivariatePowerSeriesCategory&| |EuclideanDomain&|
                |PowerSeriesCategory&| NIL |UniqueFactorizationDomain&|
                |AbelianMonoidRing&| |GcdDomain&| NIL NIL NIL |DivisionRing&|
                NIL NIL |Algebra&| |PartialDifferentialRing&|
                |DifferentialRing&| |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |Rng&| NIL |Module&| |Module&| |Module&| NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |Magma&| |AbelianSemiGroup&| |RetractableTo&| |RetractableTo&|
                |SetCategory&| |TranscendentalFunctionCategory&| NIL NIL NIL
                NIL |BasicType&| NIL NIL |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                |RadicalCategory&| NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariatePuiseuxSeriesConstructorCategory| 6
                                                               (|UnivariateLaurentSeries|
                                                                6 7 8))
                 (|UnivariatePuiseuxSeriesCategory| 6)
                 (|UnivariateSeriesWithRationalExponents| 6 27) (|Field|)
                 (|UnivariatePowerSeriesCategory| 6 27) (|EuclideanDomain|)
                 (|PowerSeriesCategory| 6 27 (|SingletonAsOrderedSet|))
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 27) (|GcdDomain|) (|IntegralDomain|)
                 (|LeftOreRing|) (|CommutativeRing|) (|DivisionRing|)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 6)
                 (|PartialDifferentialRing| 10) (|DifferentialRing|)
                 (|Algebra| $$) (|EntireRing|) (|Algebra| 27) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 6) (|Module| $$)
                 (|Module| 27) (|IndexedProductCategory| 6 27) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|BiModule| 27 27)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|LeftModule| 27) (|RightModule| 27)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|Magma|) (|AbelianSemiGroup|)
                 (|RetractableTo| (|UnivariateTaylorSeries| 6 7 8))
                 (|RetractableTo| (|UnivariateLaurentSeries| 6 7 8))
                 (|SetCategory|) (|TranscendentalFunctionCategory|)
                 (|CommutativeStar|)
                 (|CoercibleFrom| (|UnivariateTaylorSeries| 6 7 8))
                 (|CoercibleFrom| (|UnivariateLaurentSeries| 6 7 8))
                 (|VariablesCommuteWithCoefficients|) (|BasicType|)
                 (|CoercibleTo| 63) (|Eltable| $$ $$)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|)
                 (|unitsKnown|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|canonicalUnitNormal|) (|canonicalsClosed|))
              (|makeByteWordVec2| 87
                                  '(1 14 0 13 15 1 0 0 14 16 1 0 18 0 19 1 14
                                    20 0 21 1 6 23 0 24 0 6 0 25 0 0 0 26 0 27
                                    0 28 2 0 0 6 27 29 0 6 0 30 0 0 0 31 0 27 0
                                    32 2 0 0 0 0 33 1 0 0 0 36 2 0 0 0 34 37 1
                                    0 0 0 38 2 0 0 0 34 39 1 27 40 0 41 1 27 40
                                    0 42 1 43 23 0 44 1 43 6 0 45 2 6 0 0 46 47
                                    2 6 0 0 0 48 1 43 0 0 49 2 6 0 0 0 50 1 14
                                    40 0 51 1 14 13 0 52 1 13 43 0 53 1 27 0 40
                                    54 2 6 0 0 27 55 1 0 27 0 56 1 6 0 10 57 2
                                    6 0 0 0 58 1 0 14 0 59 2 27 0 0 0 60 2 0 6
                                    0 27 61 2 27 23 0 0 62 1 6 63 0 64 1 27 63
                                    0 65 2 63 0 0 0 66 2 6 23 0 0 67 1 6 0 0 68
                                    1 63 0 0 69 2 63 0 0 0 70 2 6 23 0 0 71 2
                                    27 0 40 0 72 2 27 0 0 0 73 1 43 23 0 74 2
                                    43 23 0 0 75 1 43 23 0 76 1 10 63 0 77 2 63
                                    0 0 78 79 2 63 0 0 0 80 2 82 63 81 0 83 2
                                    14 0 40 0 84 2 63 0 0 0 85 1 63 0 0 86 1 0
                                    10 0 11 1 0 20 0 22 1 0 18 0 19 1 0 27 0 56
                                    2 0 0 6 27 29 1 0 14 0 59 2 6 0 0 34 39 1 6
                                    0 0 38 1 3 0 0 36 2 0 0 0 34 37 1 0 0 34 35
                                    1 0 0 13 17 1 0 0 14 16 1 0 63 0 87 1 0 6 0
                                    12 2 12 6 0 27 61 0 33 0 31 0 31 0 26 2 0 0
                                    0 0 33)))))
           '|lookupIncomplete|)) 
