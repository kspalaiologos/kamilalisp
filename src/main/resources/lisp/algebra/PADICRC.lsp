
(PUT '|PADICRC;getExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |PADICRC;getExpon| ((|x| ($)) ($ (|Integer|))) (QCAR |x|)) 

(PUT '|PADICRC;getZp| '|SPADreplace| 'QCDR) 

(SDEFUN |PADICRC;getZp| ((|x| ($)) ($ (PADIC))) (QCDR |x|)) 

(PUT '|PADICRC;makeQp| '|SPADreplace| 'CONS) 

(SDEFUN |PADICRC;makeQp| ((|r| (|Integer|)) (|int| (PADIC)) ($ ($)))
        (CONS |r| |int|)) 

(SDEFUN |PADICRC;Zero;$;4| (($ ($)))
        (|PADICRC;makeQp| 0 (|spadConstant| $ 13) $)) 

(SDEFUN |PADICRC;One;$;5| (($ ($)))
        (|PADICRC;makeQp| 0 (|spadConstant| $ 15) $)) 

(SDEFUN |PADICRC;coerce;I$;6| ((|x| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 18))) 

(SDEFUN |PADICRC;coerce;F$;7| ((|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |r| (QREFELT $ 21)) (QREFELT $ 19))
                  (SPADCALL (SPADCALL |r| (QREFELT $ 22)) (QREFELT $ 19))
                  (QREFELT $ 23))) 

(SDEFUN |PADICRC;coerce;PADIC$;8| ((|x| (PADIC)) ($ ($)))
        (|PADICRC;makeQp| 0 |x| $)) 

(SDEFUN |PADICRC;removeZeroes;2$;9| ((|x| ($)) ($ ($)))
        (SPROG ((|xx| (PADIC)))
               (COND
                ((SPADCALL
                  (SPADCALL (LETT |xx| (|PADICRC;getZp| |x| $)) (QREFELT $ 26))
                  (QREFELT $ 28))
                 (|spadConstant| $ 14))
                ((ZEROP (SPADCALL |xx| (QREFELT $ 29)))
                 (SPADCALL
                  (|PADICRC;makeQp| (+ (|PADICRC;getExpon| |x| $) 1)
                   (SPADCALL |xx| (QREFELT $ 30)) $)
                  (QREFELT $ 31)))
                ('T |x|)))) 

(SDEFUN |PADICRC;removeZeroes;I2$;10| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG ((|xx| (PADIC)))
               (COND ((<= |n| 0) |x|)
                     ((SPADCALL
                       (SPADCALL (LETT |xx| (|PADICRC;getZp| |x| $))
                                 (QREFELT $ 26))
                       (QREFELT $ 28))
                      (|spadConstant| $ 14))
                     ((ZEROP (SPADCALL |xx| (QREFELT $ 29)))
                      (SPADCALL (- |n| 1)
                                (|PADICRC;makeQp|
                                 (+ (|PADICRC;getExpon| |x| $) 1)
                                 (SPADCALL |xx| (QREFELT $ 30)) $)
                                (QREFELT $ 32)))
                     ('T |x|)))) 

(SDEFUN |PADICRC;=;2$B;11| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G914 NIL) (#2=#:G853 NIL) (|n| (|Integer|)))
               (SEQ
                (COND ((EQ |x| |y|) 'T)
                      (#3='T
                       (SEQ
                        (LETT |n|
                              (- (|PADICRC;getExpon| |x| $)
                                 (|PADICRC;getExpon| |y| $)))
                        (EXIT
                         (COND
                          ((>= |n| 0)
                           (SPADCALL
                            (SPADCALL
                             (EXPT (QREFELT $ 6)
                                   (PROG1 (LETT #2# |n|)
                                     (|check_subtype2| (>= #2# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #2#)))
                             (|PADICRC;getZp| |x| $) (QREFELT $ 33))
                            (|PADICRC;getZp| |y| $) (QREFELT $ 34)))
                          (#3#
                           (SPADCALL
                            (SPADCALL
                             (EXPT (QREFELT $ 6)
                                   (PROG1 (LETT #1# (- |n|))
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#)))
                             (|PADICRC;getZp| |y| $) (QREFELT $ 33))
                            (|PADICRC;getZp| |x| $) (QREFELT $ 34))))))))))) 

(SDEFUN |PADICRC;+;3$;12| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G932 NIL) (#2=#:G928 NIL) (|n| (|Integer|)))
               (SEQ
                (LETT |n|
                      (- (|PADICRC;getExpon| |x| $)
                         (|PADICRC;getExpon| |y| $)))
                (EXIT
                 (COND
                  ((>= |n| 0)
                   (|PADICRC;makeQp| (|PADICRC;getExpon| |y| $)
                    (SPADCALL (|PADICRC;getZp| |y| $)
                              (SPADCALL
                               (EXPT (QREFELT $ 6)
                                     (PROG1 (LETT #2# |n|)
                                       (|check_subtype2| (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#)))
                               (|PADICRC;getZp| |x| $) (QREFELT $ 33))
                              (QREFELT $ 36))
                    $))
                  ('T
                   (|PADICRC;makeQp| (|PADICRC;getExpon| |x| $)
                    (SPADCALL (|PADICRC;getZp| |x| $)
                              (SPADCALL
                               (EXPT (QREFELT $ 6)
                                     (PROG1 (LETT #1# (- |n|))
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#)))
                               (|PADICRC;getZp| |y| $) (QREFELT $ 33))
                              (QREFELT $ 36))
                    $))))))) 

(SDEFUN |PADICRC;-;2$;13| ((|x| ($)) ($ ($)))
        (|PADICRC;makeQp| (|PADICRC;getExpon| |x| $)
         (SPADCALL (|PADICRC;getZp| |x| $) (QREFELT $ 38)) $)) 

(SDEFUN |PADICRC;-;3$;14| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G950 NIL) (#2=#:G946 NIL) (|n| (|Integer|)))
               (SEQ
                (LETT |n|
                      (- (|PADICRC;getExpon| |x| $)
                         (|PADICRC;getExpon| |y| $)))
                (EXIT
                 (COND
                  ((>= |n| 0)
                   (|PADICRC;makeQp| (|PADICRC;getExpon| |y| $)
                    (SPADCALL
                     (SPADCALL
                      (EXPT (QREFELT $ 6)
                            (PROG1 (LETT #2# |n|)
                              (|check_subtype2| (>= #2# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #2#)))
                      (|PADICRC;getZp| |x| $) (QREFELT $ 33))
                     (|PADICRC;getZp| |y| $) (QREFELT $ 40))
                    $))
                  ('T
                   (|PADICRC;makeQp| (|PADICRC;getExpon| |x| $)
                    (SPADCALL (|PADICRC;getZp| |x| $)
                              (SPADCALL
                               (EXPT (QREFELT $ 6)
                                     (PROG1 (LETT #1# (- |n|))
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#)))
                               (|PADICRC;getZp| |y| $) (QREFELT $ 33))
                              (QREFELT $ 40))
                    $))))))) 

(SDEFUN |PADICRC;*;I2$;15| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (|PADICRC;makeQp| (|PADICRC;getExpon| |x| $)
         (SPADCALL |n| (|PADICRC;getZp| |x| $) (QREFELT $ 33)) $)) 

(SDEFUN |PADICRC;*;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (|PADICRC;makeQp|
         (+ (|PADICRC;getExpon| |x| $) (|PADICRC;getExpon| |y| $))
         (SPADCALL (|PADICRC;getZp| |x| $) (|PADICRC;getZp| |y| $)
                   (QREFELT $ 43))
         $)) 

(SDEFUN |PADICRC;^;$I$;17| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G957 NIL) (#2=#:G956 NIL))
               (COND ((ZEROP |n|) (|spadConstant| $ 16))
                     ((PLUSP |n|)
                      (SPADCALL |x|
                                (PROG1 (LETT #2# |n|)
                                  (|check_subtype2| (> #2# 0)
                                                    '(|PositiveInteger|)
                                                    '(|Integer|) #2#))
                                (QREFELT $ 47)))
                     ('T
                      (SPADCALL
                       (SPADCALL |x|
                                 (PROG1 (LETT #1# (- |n|))
                                   (|check_subtype2| (> #1# 0)
                                                     '(|PositiveInteger|)
                                                     '(|Integer|) #1#))
                                 (QREFELT $ 47))
                       (QREFELT $ 48)))))) 

(SDEFUN |PADICRC;recip;$U;18| ((|x| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|inv| (|Union| PADIC #1#)) (|xx| (PADIC)))
               (SEQ (LETT |x| (SPADCALL 1000 |x| (QREFELT $ 32)))
                    (EXIT
                     (COND
                      ((ZEROP
                        (SPADCALL (LETT |xx| (|PADICRC;getZp| |x| $))
                                  (QREFELT $ 29)))
                       (CONS 1 "failed"))
                      (#2='T
                       (SEQ (LETT |inv| (SPADCALL |xx| (QREFELT $ 51)))
                            (EXIT
                             (COND ((QEQCAR |inv| 1) (CONS 1 "failed"))
                                   (#2#
                                    (CONS 0
                                          (|PADICRC;makeQp|
                                           (- (|PADICRC;getExpon| |x| $))
                                           (QCDR |inv|) $)))))))))))) 

(SDEFUN |PADICRC;inv;2$;19| ((|x| ($)) ($ ($)))
        (SPROG ((|inv| (|Union| $ "failed")))
               (SEQ (LETT |inv| (SPADCALL |x| (QREFELT $ 52)))
                    (EXIT
                     (COND ((QEQCAR |inv| 1) (|error| "inv: no inverse"))
                           ('T (QCDR |inv|))))))) 

(SDEFUN |PADICRC;/;3$;20| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| (SPADCALL |y| (QREFELT $ 48)) (QREFELT $ 44))) 

(SDEFUN |PADICRC;/;2PADIC$;21| ((|x| (PADIC)) (|y| (PADIC)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 18)) (SPADCALL |y| (QREFELT $ 18))
                  (QREFELT $ 23))) 

(SDEFUN |PADICRC;*;PADIC2$;22| ((|x| (PADIC)) (|y| ($)) ($ ($)))
        (|PADICRC;makeQp| (|PADICRC;getExpon| |y| $)
         (SPADCALL |x| (|PADICRC;getZp| |y| $) (QREFELT $ 43)) $)) 

(SDEFUN |PADICRC;approximate;$IF;23|
        ((|x| ($)) (|n| (|Integer|)) ($ (|Fraction| (|Integer|))))
        (SPROG ((|k| (|Integer|)))
               (SEQ (LETT |k| (|PADICRC;getExpon| |x| $))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL (QREFELT $ 6) (QREFELT $ 55)) |k|
                                (QREFELT $ 56))
                      (SPADCALL (|PADICRC;getZp| |x| $) (- |n| |k|)
                                (QREFELT $ 57))
                      (QREFELT $ 58)))))) 

(SDEFUN |PADICRC;cfStream| ((|x| ($)) ($ (|Stream| (|Fraction| (|Integer|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|PADICRC;cfStream!0| (VECTOR $ |x|))
                          (QREFELT $ 64))))) 

(SDEFUN |PADICRC;cfStream!0| (($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|invx| NIL) (|x0| NIL))
                   (SEQ (LETT |invx| (SPADCALL |x| (QREFELT $ 48)))
                        (LETT |x0|
                              (SPADCALL |invx| (|spadConstant| $ 60)
                                        (QREFELT $ 59)))
                        (EXIT
                         (SPADCALL |x0|
                                   (|PADICRC;cfStream|
                                    (SPADCALL |invx|
                                              (SPADCALL |x0| (QREFELT $ 24))
                                              (QREFELT $ 41))
                                    $)
                                   (QREFELT $ 62))))))))) 

(SDEFUN |PADICRC;continuedFraction;$Cf;25|
        ((|x| ($)) ($ (|ContinuedFraction| (|Fraction| (|Integer|)))))
        (SPROG ((|x0| (|Fraction| (|Integer|))))
               (SEQ (LETT |x0| (SPADCALL |x| 1 (QREFELT $ 59)))
                    (EXIT
                     (SPADCALL |x0|
                               (|PADICRC;cfStream|
                                (SPADCALL |x| (SPADCALL |x0| (QREFELT $ 24))
                                          (QREFELT $ 41))
                                $)
                               (QREFELT $ 66)))))) 

(SDEFUN |PADICRC;termOutput|
        ((|k| (|Integer|)) (|c| (|Integer|)) ($ (|OutputForm|)))
        (SPROG ((|mon| (|OutputForm|)))
               (SEQ
                (COND ((EQL |k| 0) (SPADCALL |c| (QREFELT $ 10)))
                      (#1='T
                       (SEQ
                        (LETT |mon|
                              (COND ((EQL |k| 1) (QREFELT $ 11))
                                    (#1#
                                     (SPADCALL (QREFELT $ 11)
                                               (SPADCALL |k| (QREFELT $ 10))
                                               (QREFELT $ 68)))))
                        (EXIT
                         (COND ((EQL |c| 1) |mon|)
                               ((EQL |c| -1) (SPADCALL |mon| (QREFELT $ 69)))
                               (#1#
                                (SPADCALL (SPADCALL |c| (QREFELT $ 10)) |mon|
                                          (QREFELT $ 70))))))))))) 

(PUT '|PADICRC;showAll?| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |PADICRC;showAll?| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |PADICRC;coerce;$Of;28| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|uu| (|Stream| (|Integer|)))
          (|uu1| (|Stream| (|Integer|))) (|n| NIL) (#1=#:G1027 NIL)
          (|count| (|NonNegativeInteger|)) (|zp| (PADIC)) (|m| (|Integer|)))
         (SEQ (LETT |x| (SPADCALL |$streamCount| |x| (QREFELT $ 32)))
              (LETT |m| (|PADICRC;getExpon| |x| $))
              (LETT |zp| (|PADICRC;getZp| |x| $))
              (LETT |uu| (SPADCALL |zp| (QREFELT $ 26))) (LETT |l| NIL)
              (EXIT
               (COND
                ((SPADCALL |uu| (QREFELT $ 28)) (SPADCALL 0 (QREFELT $ 10)))
                (#2='T
                 (SEQ (LETT |count| |$streamCount|)
                      (SEQ (LETT |n| 0) (LETT #1# |count|) G190
                           (COND
                            ((OR (|greater_SI| |n| #1#)
                                 (NULL (NULL (SPADCALL |uu| (QREFELT $ 28)))))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL (SPADCALL |uu| (QREFELT $ 71)) 0
                                        (QREFELT $ 72))
                              (LETT |l|
                                    (CONS
                                     (|PADICRC;termOutput| (+ |n| |m|)
                                      (SPADCALL |uu| (QREFELT $ 71)) $)
                                     |l|))))
                            (EXIT (LETT |uu| (SPADCALL |uu| (QREFELT $ 73)))))
                           (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((|PADICRC;showAll?| $)
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
                                                             (QREFELT $ 73))
                                                   (QREFELT $ 75))))
                                       ('T NIL)))
                                     (GO G191)))
                                   (SEQ
                                    (COND
                                     ((SPADCALL (SPADCALL |uu| (QREFELT $ 71))
                                                0 (QREFELT $ 72))
                                      (LETT |l|
                                            (CONS
                                             (|PADICRC;termOutput| (+ |n| |m|)
                                              (SPADCALL |uu| (QREFELT $ 71)) $)
                                             |l|))))
                                    (COND
                                     ((ODDP |n|)
                                      (LETT |uu1|
                                            (SPADCALL |uu1| (QREFELT $ 73)))))
                                    (EXIT
                                     (LETT |uu|
                                           (SPADCALL |uu| (QREFELT $ 73)))))
                                   (LETT |n| (+ |n| 1)) (GO G190) G191
                                   (EXIT NIL))))))
                      (LETT |l|
                            (COND ((SPADCALL |uu| (QREFELT $ 76)) |l|)
                                  (#2#
                                   (SEQ
                                    (COND
                                     ((SPADCALL |uu|
                                                (SPADCALL |uu| (QREFELT $ 73))
                                                (QREFELT $ 75))
                                      (COND
                                       ((EQL (SPADCALL |uu| (QREFELT $ 71)) 0)
                                        (EXIT |l|)))))
                                    (EXIT
                                     (CONS
                                      (SPADCALL (SPADCALL 'O (QREFELT $ 78))
                                                (LIST
                                                 (SPADCALL (QREFELT $ 11)
                                                           (SPADCALL
                                                            (+ |n| |m|)
                                                            (QREFELT $ 10))
                                                           (QREFELT $ 68)))
                                                (QREFELT $ 80))
                                      |l|))))))
                      (EXIT
                       (COND ((NULL |l|) (SPADCALL 0 (QREFELT $ 82)))
                             (#2#
                              (SPADCALL (ELT $ 83) (NREVERSE |l|)
                                        (QREFELT $ 86)))))))))))) 

(DECLAIM (NOTINLINE |PAdicRationalConstructor;|)) 

(DEFUN |PAdicRationalConstructor| (&REST #1=#:G1078)
  (SPROG NIL
         (PROG (#2=#:G1079)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|PAdicRationalConstructor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PAdicRationalConstructor;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PAdicRationalConstructor|)))))))))) 

(DEFUN |PAdicRationalConstructor;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G1077 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|PAdicRationalConstructor| DV$1 DV$2))
    (LETT $ (GETREFV 128))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Symbol|)))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#2|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#2| '(|RealConstant|))
                                        (|HasCategory| |#2|
                                                       '(|OrderedIntegralDomain|))
                                        (|HasCategory| |#2| '(|OrderedSet|))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|OrderedIntegralDomain|))
                                         (|HasCategory| |#2| '(|OrderedSet|)))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#2| '(|StepThrough|))
                                        (|HasCategory| |#2|
                                                       (LIST '|InnerEvalable|
                                                             '(|Symbol|)
                                                             (|devaluate|
                                                              |#2|)))
                                        (|HasCategory| |#2|
                                                       (LIST '|Evalable|
                                                             (|devaluate|
                                                              |#2|)))
                                        (|HasCategory| |#2|
                                                       (LIST '|Eltable|
                                                             (|devaluate| |#2|)
                                                             (|devaluate|
                                                              |#2|)))
                                        (|HasCategory| |#2|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (|HasCategory| |#2|
                                                       '(|DifferentialRing|))
                                        (|HasCategory| |#2|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Float|))))
                                        (|HasCategory| |#2|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Integer|))))
                                        (|HasCategory| |#2|
                                                       '(|PatternMatchable|
                                                         (|Float|)))
                                        (|HasCategory| |#2|
                                                       '(|PatternMatchable|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#2|
                                                       '(|IntegerNumberSystem|))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|Comparable|)))
                                        (OR #1#
                                            (|HasCategory| |#2|
                                                           '(|OrderedIntegralDomain|))
                                            (|HasCategory| |#2|
                                                           '(|OrderedSet|)))))))
    (|haddProp| |$ConstructorCache| '|PAdicRationalConstructor|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
         (|HasCategory| $ '(|CharacteristicNonZero|))
         (|augmentPredVector| $ 33554432))
    (AND
     (OR (|HasCategory| |#2| '(|CharacteristicNonZero|))
         (AND (|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
              (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 67108864))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 11 (SPADCALL |#1| (QREFELT $ 10)))
    (QSETREFV $ 12 (|Record| (|:| |expon| (|Integer|)) (|:| |pint| |#2|)))
    $))) 

(MAKEPROP '|PAdicRationalConstructor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|OutputForm|) (|Integer|) (0 . |coerce|) 'PEXPR '|Rep|
              (5 . |Zero|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |PADICRC;Zero;$;4|) $))
              (9 . |One|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |PADICRC;One;$;5|) $))
              (13 . |coerce|) |PADICRC;coerce;PADIC$;8| |PADICRC;coerce;I$;6|
              (|Fraction| 9) (18 . |numer|) (23 . |denom|) |PADICRC;/;3$;20|
              |PADICRC;coerce;F$;7| (|Stream| 9) (28 . |digits|) (|Boolean|)
              (33 . |empty?|) (38 . |moduloP|) (43 . |quotientByP|)
              |PADICRC;removeZeroes;2$;9| |PADICRC;removeZeroes;I2$;10|
              (48 . *) (54 . =) |PADICRC;=;2$B;11| (60 . +) |PADICRC;+;3$;12|
              (66 . -) |PADICRC;-;2$;13| (71 . -) |PADICRC;-;3$;14|
              |PADICRC;*;I2$;15| (77 . *) |PADICRC;*;3$;16| (|PositiveInteger|)
              (|RepeatedSquaring| $$) (83 . |expt|) |PADICRC;inv;2$;19|
              |PADICRC;^;$I$;17| (|Union| $ '"failed") (89 . |recip|)
              |PADICRC;recip;$U;18| |PADICRC;/;2PADIC$;21|
              |PADICRC;*;PADIC2$;22| (94 . |coerce|) (99 . ^)
              (105 . |approximate|) (111 . *) |PADICRC;approximate;$IF;23|
              (117 . |One|) (|Stream| 20) (121 . |concat|) (|Mapping| $)
              (127 . |delay|) (|ContinuedFraction| 20)
              (132 . |reducedContinuedFraction|)
              |PADICRC;continuedFraction;$Cf;25| (138 . ^) (144 . -) (149 . *)
              (155 . |frst|) (160 . ~=) (166 . |rst|)
              (171 . |explicitEntries?|) (176 . |eq?|)
              (182 . |explicitlyEmpty?|) (|Symbol|) (187 . |coerce|) (|List| $)
              (192 . |prefix|) (|NonNegativeInteger|) (198 . |coerce|)
              (203 . +) (|Mapping| 8 8 8) (|List| 8) (209 . |reduce|)
              |PADICRC;coerce;$Of;28| (|Union| 98 '#1="failed") (|Matrix| $)
              (|InputForm|) (|Pattern| 108) (|Pattern| 9) (|List| 94)
              (|Equation| 7) (|List| 7) (|List| 77)
              (|Record| (|:| |mat| 99) (|:| |vec| (|Vector| 9))) (|Vector| $)
              (|Matrix| 9) (|List| 81) (|PatternMatchResult| 108 $)
              (|PatternMatchResult| 9 $) (|Factored| 104)
              (|SparseUnivariatePolynomial| $) (|Union| 106 '#1#) (|List| 104)
              (|DoubleFloat|) (|Float|) (|Union| 9 '#2="failed")
              (|Union| 20 '#2#) (|Union| 77 '#2#) (|Matrix| 7)
              (|Record| (|:| |mat| 112) (|:| |vec| (|Vector| 7)))
              (|Mapping| 7 7) (|Union| 7 '#2#) (|Factored| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 117 '#3="failed") (|Union| 79 '#3#)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 79) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 215 |zero?| 221 |wholePart| 226 |unitNormal| 231
              |unitCanonical| 236 |unit?| 241 |subtractIfCan| 246
              |squareFreePolynomial| 252 |squareFreePart| 257 |squareFree| 262
              |solveLinearPolynomialEquation| 267 |smaller?| 273 |sizeLess?|
              279 |sign| 285 |sample| 290 |rightRecip| 294 |rightPower| 299
              |retractIfCan| 311 |retract| 331 |removeZeroes| 351 |rem| 362
              |reducedSystem| 368 |recip| 390 |quo| 395 |principalIdeal| 401
              |prime?| 406 |positive?| 411 |patternMatch| 416 |opposite?| 430
              |one?| 436 |numerator| 441 |numer| 446 |nextItem| 451 |negative?|
              456 |multiEuclidean| 461 |min| 467 |max| 473 |map| 479
              |leftRecip| 485 |leftPower| 490 |lcmCoef| 502 |lcm| 508 |latex|
              519 |inv| 524 |init| 529 |hashUpdate!| 533 |hash| 539
              |gcdPolynomial| 544 |gcd| 550 |fractionPart| 561 |floor| 566
              |factorSquareFreePolynomial| 571 |factorPolynomial| 576 |factor|
              581 |extendedEuclidean| 586 |exquo| 599 |expressIdealMember| 605
              |eval| 611 |euclideanSize| 651 |elt| 656 |divide| 662
              |differentiate| 668 |denominator| 718 |denom| 723 |convert| 728
              |continuedFraction| 753 |conditionP| 758 |commutator| 763
              |coerce| 769 |charthRoot| 799 |characteristic| 804 |ceiling| 808
              |associator| 813 |associates?| 820 |approximate| 826
              |antiCommutator| 832 |annihilate?| 838 |abs| 844 ^ 849 |Zero| 867
              |One| 871 D 875 >= 925 > 931 = 937 <= 943 < 949 / 955 - 967 + 978
              * 984)
           'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 0 0 1 0 0 0 7 0 0 0 0 0 0 7 0 0 0 0 0 3 4
                                  15 16 17 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0
                                  0 7 0 7 0 0 0 7 0 0 0 0 0 9 0 0 0 25 11 20 21
                                  0 0 0 0 2 6 10 10 13 0 0 0 0 0 0 0 0 0 2 5 6
                                  6 8 10 10 12 13 14 18 19))
            (CONS
             '#(|QuotientFieldCategory&| |Field&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |FullyLinearlyExplicitOver&| |DifferentialExtension&|
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                NIL |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |OrderedSet&| |FullyEvalableOver&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL NIL |RetractableTo&| NIL
                |SetCategory&| |RetractableTo&| NIL |RetractableTo&|
                |RetractableTo&| |Evalable&| NIL NIL NIL NIL NIL NIL NIL
                |BasicType&| NIL NIL NIL NIL NIL |PartialOrder&| NIL NIL
                |InnerEvalable&| |InnerEvalable&| NIL NIL NIL)
             (CONS
              '#((|QuotientFieldCategory| 7) (|Field|) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 7) (|DifferentialExtension| 7)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|OrderedRing|) (|LinearlyExplicitOver| 7) (|Algebra| 7)
                 (|Algebra| 20) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|PartialDifferentialRing| 77) (|DifferentialRing|)
                 (|LinearlyExplicitOver| 9) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| 7) (|Module| 20) (|Module| $$) (|SemiRng|)
                 (|BiModule| 7 7) (|BiModule| 20 20) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|OrderedAbelianGroup|)
                 (|RightModule| 7) (|LeftModule| 7) (|RightModule| 20)
                 (|LeftModule| 20) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|OrderedCancellationAbelianMonoid|)
                 (|AbelianGroup|) (|OrderedAbelianMonoid|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedAbelianSemiGroup|) (|FullyPatternMatchable| 7)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|OrderedSet|) (|FullyEvalableOver| 7)
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|PatternMatchable| 108) (|PatternMatchable| 9)
                 (|Patternable| 7) (|RetractableTo| 7) (|CommutativeStar|)
                 (|SetCategory|) (|RetractableTo| 77) (|RealConstant|)
                 (|RetractableTo| 20) (|RetractableTo| 9) (|Evalable| 7)
                 (|Type|) (|CoercibleFrom| 7) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 8)
                 (|CoercibleFrom| 77) (|ConvertibleTo| 90)
                 (|ConvertibleTo| 107) (|ConvertibleTo| 108) (|PartialOrder|)
                 (|CoercibleFrom| 20) (|CoercibleFrom| 9)
                 (|InnerEvalable| 77 7) (|InnerEvalable| 7 7) (|Eltable| 7 $$)
                 (|ConvertibleTo| 91) (|ConvertibleTo| 92))
              (|makeByteWordVec2| 127
                                  '(1 9 8 0 10 0 7 0 13 0 7 0 15 1 7 0 9 17 1
                                    20 9 0 21 1 20 9 0 22 1 7 25 0 26 1 25 27 0
                                    28 1 7 9 0 29 1 7 0 0 30 2 7 0 9 0 33 2 7
                                    27 0 0 34 2 7 0 0 0 36 1 7 0 0 38 2 7 0 0 0
                                    40 2 7 0 0 0 43 2 46 2 2 45 47 1 7 50 0 51
                                    1 20 0 9 55 2 20 0 0 9 56 2 7 9 0 9 57 2 20
                                    0 0 9 58 0 9 0 60 2 61 0 20 0 62 1 61 0 63
                                    64 2 65 0 20 61 66 2 8 0 0 0 68 1 8 0 0 69
                                    2 8 0 0 0 70 1 25 9 0 71 2 9 27 0 0 72 1 25
                                    0 0 73 1 25 27 0 74 2 25 27 0 0 75 1 25 27
                                    0 76 1 77 8 0 78 2 8 0 0 79 80 1 81 8 0 82
                                    2 8 0 0 0 83 2 85 8 84 0 86 2 0 27 0 0 1 1
                                    0 27 0 1 1 22 7 0 1 1 0 124 0 1 1 0 0 0 1 1
                                    0 27 0 1 2 0 50 0 0 1 1 1 103 104 1 1 0 0 0
                                    1 1 0 116 0 1 2 1 105 106 104 1 2 24 27 0 0
                                    1 2 0 27 0 0 1 1 7 9 0 1 0 0 0 1 1 0 50 0 1
                                    2 0 0 0 81 1 2 0 0 0 45 1 1 10 109 0 1 1 10
                                    110 0 1 1 2 111 0 1 1 0 115 0 1 1 10 9 0 1
                                    1 10 20 0 1 1 2 77 0 1 1 0 7 0 1 1 0 0 0 31
                                    2 0 0 9 0 32 2 0 0 0 0 1 2 17 97 89 98 1 1
                                    17 99 89 1 1 0 112 89 1 2 0 113 89 98 1 1 0
                                    50 0 52 2 0 0 0 0 1 1 0 122 79 1 1 0 27 0 1
                                    1 7 27 0 1 3 20 101 0 91 101 1 3 21 102 0
                                    92 102 1 2 0 27 0 0 1 1 0 27 0 1 1 0 0 0 1
                                    1 0 7 0 1 1 11 50 0 1 1 7 27 0 1 2 0 119 79
                                    0 1 2 8 0 0 0 1 2 8 0 0 0 1 2 0 0 114 0 1 1
                                    0 50 0 1 2 0 0 0 81 1 2 0 0 0 45 1 2 0 123
                                    0 0 1 2 0 0 0 0 1 1 0 0 79 1 1 0 125 0 1 1
                                    0 0 0 48 0 11 0 1 2 0 127 127 0 1 1 0 126 0
                                    1 2 0 104 104 104 1 2 0 0 0 0 1 1 0 0 79 1
                                    1 22 0 0 1 1 23 7 0 1 1 1 103 104 1 1 1 103
                                    104 1 1 0 116 0 1 3 0 118 0 0 0 1 2 0 120 0
                                    0 1 2 0 50 0 0 1 2 0 119 79 0 1 2 13 0 0 93
                                    1 2 13 0 0 94 1 3 13 0 0 95 95 1 3 13 0 0 7
                                    7 1 3 12 0 0 77 7 1 3 12 0 0 96 95 1 1 0 81
                                    0 1 2 14 0 0 7 1 2 0 121 0 0 1 2 16 0 0 81
                                    1 1 16 0 0 1 3 15 0 0 77 81 1 3 15 0 0 96
                                    100 1 2 15 0 0 96 1 2 15 0 0 77 1 2 0 0 0
                                    114 1 3 0 0 0 114 81 1 1 0 0 0 1 1 0 7 0 1
                                    1 5 90 0 1 1 18 91 0 1 1 19 92 0 1 1 6 107
                                    0 1 1 6 108 0 1 1 0 65 0 67 1 26 88 89 1 2
                                    0 0 0 0 1 1 2 0 77 1 1 0 0 7 18 1 0 0 20 24
                                    1 0 0 0 1 1 0 0 9 19 1 0 8 0 87 1 27 50 0 1
                                    0 0 81 1 1 23 7 0 1 3 0 0 0 0 0 1 2 0 27 0
                                    0 1 2 0 20 0 9 59 2 0 0 0 0 1 2 0 27 0 0 1
                                    1 7 0 0 1 2 0 0 0 9 49 2 0 0 0 81 1 2 0 0 0
                                    45 1 0 0 0 14 0 0 0 16 2 16 0 0 81 1 1 16 0
                                    0 1 3 15 0 0 77 81 1 3 15 0 0 96 100 1 2 15
                                    0 0 77 1 2 15 0 0 96 1 3 0 0 0 114 81 1 2 0
                                    0 0 114 1 2 8 27 0 0 1 2 8 27 0 0 1 2 0 27
                                    0 0 35 2 8 27 0 0 1 2 8 27 0 0 1 2 0 0 7 7
                                    53 2 0 0 0 0 23 1 0 0 0 39 2 0 0 0 0 41 2 0
                                    0 0 0 37 2 0 0 0 7 1 2 0 0 7 0 54 2 0 0 20
                                    0 1 2 0 0 0 20 1 2 0 0 81 0 1 2 0 0 9 0 42
                                    2 0 0 0 0 44 2 0 0 45 0 1)))))
           '|lookupComplete|)) 
