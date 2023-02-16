
(SDEFUN |LAUPOL;Zero;$;1| (($ ($))) (CONS (|spadConstant| $ 11) 0)) 

(SDEFUN |LAUPOL;One;$;2| (($ ($))) (CONS (|spadConstant| $ 14) 0)) 

(SDEFUN |LAUPOL;=;2$B;3| ((|p| ($)) (|q| ($)) ($ (|Boolean|)))
        (COND
         ((EQL (QCDR |p|) (QCDR |q|))
          (SPADCALL (QCAR |p|) (QCAR |q|) (QREFELT $ 16)))
         ('T NIL))) 

(PUT '|LAUPOL;poly| '|SPADreplace| 'QCAR) 

(SDEFUN |LAUPOL;poly| ((|p| ($)) ($ (UP))) (QCAR |p|)) 

(PUT '|LAUPOL;order;$I;5| '|SPADreplace| 'QCDR) 

(SDEFUN |LAUPOL;order;$I;5| ((|p| ($)) ($ (|Integer|))) (QCDR |p|)) 

(PUT '|LAUPOL;gpol| '|SPADreplace| 'CONS) 

(SDEFUN |LAUPOL;gpol| ((|p| (UP)) (|n| (|Integer|)) ($ ($))) (CONS |p| |n|)) 

(SDEFUN |LAUPOL;monomial;RI$;7| ((|r| (R)) (|n| (|Integer|)) ($ ($)))
        (|LAUPOL;check0| |n| (SPADCALL |r| (QREFELT $ 20)) $)) 

(SDEFUN |LAUPOL;coerce;UP$;8| ((|p| (UP)) ($ ($))) (|LAUPOL;mkgpol| 0 |p| $)) 

(SDEFUN |LAUPOL;reductum;2$;9| ((|p| ($)) ($ ($)))
        (|LAUPOL;check0| (SPADCALL |p| (QREFELT $ 19))
         (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 23)) $)) 

(SDEFUN |LAUPOL;*;I2$;10| ((|n| (|Integer|)) (|p| ($)) ($ ($)))
        (|LAUPOL;check0| (SPADCALL |p| (QREFELT $ 19))
         (SPADCALL |n| (|LAUPOL;poly| |p| $) (QREFELT $ 25)) $)) 

(SDEFUN |LAUPOL;characteristic;Nni;11| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 28))) 

(SDEFUN |LAUPOL;coerce;I$;12| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 30)) (QREFELT $ 31))) 

(SDEFUN |LAUPOL;degree;$I;13| ((|p| ($)) ($ (|Integer|)))
        (+ (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 33))
           (SPADCALL |p| (QREFELT $ 19)))) 

(SDEFUN |LAUPOL;monomial?;$B;14| ((|p| ($)) ($ (|Boolean|)))
        (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 35))) 

(SDEFUN |LAUPOL;coerce;R$;15| ((|r| (R)) ($ ($)))
        (|LAUPOL;gpol| (SPADCALL |r| (QREFELT $ 20)) 0 $)) 

(SDEFUN |LAUPOL;convert;$F;16| ((|p| ($)) ($ (|Fraction| UP)))
        (SPADCALL (|LAUPOL;poly| |p| $)
                  (SPADCALL
                   (SPADCALL (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 37))
                             (QREFELT $ 39))
                   (SPADCALL |p| (QREFELT $ 19)) (QREFELT $ 40))
                  (QREFELT $ 41))) 

(SDEFUN |LAUPOL;*;3$;17| ((|p| ($)) (|q| ($)) ($ ($)))
        (|LAUPOL;check0|
         (+ (SPADCALL |p| (QREFELT $ 19)) (SPADCALL |q| (QREFELT $ 19)))
         (SPADCALL (|LAUPOL;poly| |p| $) (|LAUPOL;poly| |q| $) (QREFELT $ 43))
         $)) 

(SDEFUN |LAUPOL;-;2$;18| ((|p| ($)) ($ ($)))
        (|LAUPOL;gpol| (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 45))
         (SPADCALL |p| (QREFELT $ 19)) $)) 

(SDEFUN |LAUPOL;check0| ((|n| (|Integer|)) (|p| (UP)) ($ ($)))
        (COND ((SPADCALL |p| (QREFELT $ 47)) (|spadConstant| $ 9))
              ('T (|LAUPOL;gpol| |p| |n| $)))) 

(SDEFUN |LAUPOL;trailingCoefficient;$R;20| ((|p| ($)) ($ (R)))
        (SPADCALL (|LAUPOL;poly| |p| $) 0 (QREFELT $ 48))) 

(SDEFUN |LAUPOL;leadingCoefficient;$R;21| ((|p| ($)) ($ (R)))
        (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 50))) 

(SDEFUN |LAUPOL;coerce;$Of;22| ((|p| ($)) ($ (|OutputForm|)))
        (SPROG ((|l| (|List| (|OutputForm|))) (|v| (|OutputForm|)))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 52)) (SPADCALL 0 (QREFELT $ 54)))
                 ('T
                  (SEQ (LETT |l| NIL)
                       (LETT |v|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 37))
                              (QREFELT $ 55)))
                       (SEQ G190
                            (COND
                             ((NULL
                               (SPADCALL |p| (|spadConstant| $ 9)
                                         (QREFELT $ 56)))
                              (GO G191)))
                            (SEQ
                             (LETT |l|
                                   (SPADCALL |l|
                                             (|LAUPOL;toutput|
                                              (SPADCALL |p| (QREFELT $ 51))
                                              (SPADCALL |p| (QREFELT $ 34)) |v|
                                              $)
                                             (QREFELT $ 58)))
                             (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 24)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (SPADCALL (ELT $ 59) |l| (QREFELT $ 61))))))))) 

(SDEFUN |LAUPOL;coefficient;$IR;23| ((|p| ($)) (|n| (|Integer|)) ($ (R)))
        (SPROG ((#1=#:G761 NIL) (|m| (|Integer|)))
               (SEQ (LETT |m| (- |n| (SPADCALL |p| (QREFELT $ 19))))
                    (EXIT
                     (COND ((< |m| 0) (|spadConstant| $ 10))
                           ('T
                            (SPADCALL (|LAUPOL;poly| |p| $)
                                      (PROG1 (LETT #1# |m|)
                                        (|check_subtype2| (>= #1# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #1#))
                                      (QREFELT $ 48)))))))) 

(SDEFUN |LAUPOL;differentiate;$M$;24|
        ((|p| ($)) (|derivation| (|Mapping| UP UP)) ($ ($)))
        (SPROG ((|t| (UP)))
               (SEQ
                (LETT |t| (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 37)))
                (EXIT
                 (|LAUPOL;mkgpol| (- (SPADCALL |p| (QREFELT $ 19)) 1)
                  (SPADCALL
                   (SPADCALL (SPADCALL (|LAUPOL;poly| |p| $) |derivation|) |t|
                             (QREFELT $ 43))
                   (SPADCALL
                    (SPADCALL (SPADCALL |p| (QREFELT $ 19))
                              (|LAUPOL;poly| |p| $) (QREFELT $ 25))
                    (SPADCALL |t| |derivation|) (QREFELT $ 43))
                   (QREFELT $ 64))
                  $))))) 

(SDEFUN |LAUPOL;monTerm|
        ((|r| (R)) (|n| (|Integer|)) (|v| (|OutputForm|)) ($ (|OutputForm|)))
        (COND ((ZEROP |n|) (SPADCALL |r| (QREFELT $ 67))) ((EQL |n| 1) |v|)
              ('T (SPADCALL |v| (SPADCALL |n| (QREFELT $ 54)) (QREFELT $ 68))))) 

(SDEFUN |LAUPOL;toutput|
        ((|r| (R)) (|n| (|Integer|)) (|v| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG ((|mon| (|OutputForm|)))
               (SEQ (LETT |mon| (|LAUPOL;monTerm| |r| |n| |v| $))
                    (COND
                     ((OR (ZEROP |n|)
                          (SPADCALL |r| (|spadConstant| $ 13) (QREFELT $ 69)))
                      (EXIT |mon|)))
                    (EXIT
                     (COND
                      ((SPADCALL |r|
                                 (SPADCALL (|spadConstant| $ 13)
                                           (QREFELT $ 70))
                                 (QREFELT $ 69))
                       (SPADCALL |mon| (QREFELT $ 71)))
                      ('T
                       (SPADCALL (SPADCALL |r| (QREFELT $ 67)) |mon|
                                 (QREFELT $ 72)))))))) 

(SDEFUN |LAUPOL;recip;$U;27| ((|p| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|q| (|Union| UP #1#)))
               (SEQ (LETT |q| (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 74)))
                    (EXIT
                     (COND ((QEQCAR |q| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (|LAUPOL;gpol| (QCDR |q|)
                                   (- (SPADCALL |p| (QREFELT $ 19))) $)))))))) 

(SDEFUN |LAUPOL;+;3$;28| ((|p| ($)) (|q| ($)) ($ ($)))
        (SPROG ((#1=#:G783 NIL) (#2=#:G782 NIL) (|d| (|Integer|)))
               (SEQ
                (COND ((SPADCALL |q| (QREFELT $ 52)) |p|)
                      ((SPADCALL |p| (QREFELT $ 52)) |q|)
                      (#3='T
                       (SEQ
                        (LETT |d|
                              (- (SPADCALL |p| (QREFELT $ 19))
                                 (SPADCALL |q| (QREFELT $ 19))))
                        (EXIT
                         (COND
                          ((> |d| 0)
                           (|LAUPOL;gpol|
                            (SPADCALL
                             (SPADCALL (|LAUPOL;poly| |p| $)
                                       (SPADCALL (|spadConstant| $ 13)
                                                 (PROG1 (LETT #2# |d|)
                                                   (|check_subtype2| (>= #2# 0)
                                                                     '(|NonNegativeInteger|)
                                                                     '(|Integer|)
                                                                     #2#))
                                                 (QREFELT $ 37))
                                       (QREFELT $ 43))
                             (|LAUPOL;poly| |q| $) (QREFELT $ 64))
                            (SPADCALL |q| (QREFELT $ 19)) $))
                          ((< |d| 0)
                           (|LAUPOL;gpol|
                            (SPADCALL (|LAUPOL;poly| |p| $)
                                      (SPADCALL (|LAUPOL;poly| |q| $)
                                                (SPADCALL (|spadConstant| $ 13)
                                                          (PROG1
                                                              (LETT #1#
                                                                    (- |d|))
                                                            (|check_subtype2|
                                                             (>= #1# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #1#))
                                                          (QREFELT $ 37))
                                                (QREFELT $ 43))
                                      (QREFELT $ 64))
                            (SPADCALL |p| (QREFELT $ 19)) $))
                          (#3#
                           (|LAUPOL;mkgpol| (SPADCALL |p| (QREFELT $ 19))
                            (SPADCALL (|LAUPOL;poly| |p| $)
                                      (|LAUPOL;poly| |q| $) (QREFELT $ 64))
                            $)))))))))) 

(SDEFUN |LAUPOL;mkgpol| ((|n| (|Integer|)) (|p| (UP)) ($ ($)))
        (SPROG ((#1=#:G789 NIL) (|d| (|NonNegativeInteger|)))
               (SEQ
                (COND ((SPADCALL |p| (QREFELT $ 47)) (|spadConstant| $ 9))
                      ('T
                       (SEQ
                        (LETT |d|
                              (SPADCALL |p|
                                        (SPADCALL (|spadConstant| $ 13) 1
                                                  (QREFELT $ 37))
                                        (QREFELT $ 77)))
                        (EXIT
                         (|LAUPOL;gpol|
                          (PROG2
                              (LETT #1#
                                    (SPADCALL |p|
                                              (SPADCALL (|spadConstant| $ 13)
                                                        |d| (QREFELT $ 37))
                                              (QREFELT $ 78)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                            (|Union| (QREFELT $ 7) "failed")
                                            #1#))
                          (+ |n| |d|) $)))))))) 

(SDEFUN |LAUPOL;exquo;2$U;30| ((|p| ($)) (|q| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|r| (|Union| UP #1#)))
               (SEQ
                (LETT |r|
                      (SPADCALL (|LAUPOL;poly| |p| $) (|LAUPOL;poly| |q| $)
                                (QREFELT $ 78)))
                (EXIT
                 (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                       ('T
                        (CONS 0
                              (|LAUPOL;check0|
                               (- (SPADCALL |p| (QREFELT $ 19))
                                  (SPADCALL |q| (QREFELT $ 19)))
                               (QCDR |r|) $)))))))) 

(SDEFUN |LAUPOL;retractIfCan;$U;31| ((|p| ($)) ($ (|Union| UP "failed")))
        (SPROG ((#1=#:G806 NIL))
               (COND
                ((< (SPADCALL |p| (QREFELT $ 19)) 0)
                 (|error| "Not retractable"))
                ('T
                 (CONS 0
                       (SPADCALL (|LAUPOL;poly| |p| $)
                                 (SPADCALL (|spadConstant| $ 13)
                                           (PROG1
                                               (LETT #1#
                                                     (SPADCALL |p|
                                                               (QREFELT $ 19)))
                                             (|check_subtype2| (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                           (QREFELT $ 37))
                                 (QREFELT $ 43))))))) 

(SDEFUN |LAUPOL;retractIfCan;$U;32| ((|p| ($)) ($ (|Union| R "failed")))
        (COND
         ((SPADCALL (SPADCALL |p| (QREFELT $ 19)) 0 (QREFELT $ 82))
          (CONS 1 "failed"))
         ('T (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 84))))) 

(SDEFUN |LAUPOL;gcd;3$;33| ((|p| ($)) (|q| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (|LAUPOL;poly| |p| $) (|LAUPOL;poly| |q| $) (QREFELT $ 86))
         (QREFELT $ 22))) 

(SDEFUN |LAUPOL;separate;FR;34|
        ((|f| (|Fraction| UP))
         ($ (|Record| (|:| |polyPart| $) (|:| |fracPart| (|Fraction| UP)))))
        (SPROG
         ((|qr| (|Record| (|:| |quotient| UP) (|:| |remainder| UP)))
          (|bc| (|Record| (|:| |coef1| UP) (|:| |coef2| UP))) (#1=#:G826 NIL)
          (|q| (UP)) (#2=#:G822 NIL) (|tn| (UP)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (LETT |n|
                (SPADCALL (LETT |q| (SPADCALL |f| (QREFELT $ 88)))
                          (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 37))
                          (QREFELT $ 77)))
          (LETT |q|
                (PROG2
                    (LETT #2#
                          (SPADCALL |q|
                                    (LETT |tn|
                                          (SPADCALL (|spadConstant| $ 13) |n|
                                                    (QREFELT $ 37)))
                                    (QREFELT $ 78)))
                    (QCDR #2#)
                  (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                  (|Union| (QREFELT $ 7) "failed") #2#)))
          (LETT |bc|
                (PROG2
                    (LETT #1#
                          (SPADCALL |tn| |q| (SPADCALL |f| (QREFELT $ 89))
                                    (QREFELT $ 92)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|Record| (|:| |coef1| (QREFELT $ 7))
                                            (|:| |coef2| (QREFELT $ 7)))
                                  (|Union|
                                   (|Record| (|:| |coef1| (QREFELT $ 7))
                                             (|:| |coef2| (QREFELT $ 7)))
                                   "failed")
                                  #1#)))
          (LETT |qr| (SPADCALL (QCAR |bc|) |q| (QREFELT $ 94)))
          (EXIT
           (CONS
            (|LAUPOL;mkgpol| (- |n|)
             (SPADCALL (QCDR |bc|) (SPADCALL |tn| (QCAR |qr|) (QREFELT $ 43))
                       (QREFELT $ 64))
             $)
            (SPADCALL (QCDR |qr|) |q| (QREFELT $ 95))))))) 

(SDEFUN |LAUPOL;divide;2$R;35|
        ((|p| ($)) (|q| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPROG
         ((|qr| (|Record| (|:| |quotient| UP) (|:| |remainder| UP)))
          (#1=#:G837 NIL) (|c| (|Integer|)))
         (SEQ
          (LETT |c|
                (MIN (SPADCALL |p| (QREFELT $ 19))
                     (SPADCALL |q| (QREFELT $ 19))))
          (LETT |qr|
                (SPADCALL
                 (SPADCALL (|LAUPOL;poly| |p| $)
                           (SPADCALL (|spadConstant| $ 13)
                                     (PROG1
                                         (LETT #1#
                                               (- (SPADCALL |p| (QREFELT $ 19))
                                                  |c|))
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                     (QREFELT $ 37))
                           (QREFELT $ 43))
                 (|LAUPOL;poly| |q| $) (QREFELT $ 94)))
          (EXIT
           (CONS
            (|LAUPOL;mkgpol| (- |c| (SPADCALL |q| (QREFELT $ 19))) (QCAR |qr|)
             $)
            (|LAUPOL;mkgpol| |c| (QCDR |qr|) $)))))) 

(SDEFUN |LAUPOL;euclideanSize;$Nni;36| ((|p| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL (|LAUPOL;poly| |p| $) (QREFELT $ 33))) 

(SDEFUN |LAUPOL;extendedEuclidean;3$U;37|
        ((|a| ($)) (|b| ($)) (|c| ($))
         ($ (|Union| (|Record| (|:| |coef1| $) (|:| |coef2| $)) #1="failed")))
        (SPROG
         ((|bc| (|Union| (|Record| (|:| |coef1| UP) (|:| |coef2| UP)) #1#)))
         (SEQ
          (LETT |bc|
                (SPADCALL (|LAUPOL;poly| |a| $) (|LAUPOL;poly| |b| $)
                          (|LAUPOL;poly| |c| $) (QREFELT $ 92)))
          (EXIT
           (COND ((QEQCAR |bc| 1) (CONS 1 "failed"))
                 ('T
                  (CONS 0
                        (CONS
                         (|LAUPOL;mkgpol|
                          (- (SPADCALL |c| (QREFELT $ 19))
                             (SPADCALL |a| (QREFELT $ 19)))
                          (QCAR (QCDR |bc|)) $)
                         (|LAUPOL;mkgpol|
                          (- (SPADCALL |c| (QREFELT $ 19))
                             (SPADCALL |b| (QREFELT $ 19)))
                          (QCDR (QCDR |bc|)) $))))))))) 

(DECLAIM (NOTINLINE |LaurentPolynomial;|)) 

(DEFUN |LaurentPolynomial| (&REST #1=#:G869)
  (SPROG NIL
         (PROG (#2=#:G870)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LaurentPolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LaurentPolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LaurentPolynomial|)))))))))) 

(DEFUN |LaurentPolynomial;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|LaurentPolynomial| DV$1 DV$2))
          (LETT $ (GETREFV 118))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasCategory| |#2|
                                                             '(|DifferentialRing|))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicZero|))))))
          (|haddProp| |$ConstructorCache| '|LaurentPolynomial| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record| (|:| |polypart| |#2|)
                              (|:| |order0| (|Integer|))))
          (COND
           ((|testBitVector| |pv$| 5)
            (PROGN
             (QSETREFV $ 87 (CONS (|dispatchFunction| |LAUPOL;gcd;3$;33|) $))
             (QSETREFV $ 97
                       (CONS (|dispatchFunction| |LAUPOL;separate;FR;34|) $))
             (QSETREFV $ 98
                       (CONS (|dispatchFunction| |LAUPOL;divide;2$R;35|) $))
             (QSETREFV $ 99
                       (CONS
                        (|dispatchFunction| |LAUPOL;euclideanSize;$Nni;36|) $))
             (QSETREFV $ 100
                       (CONS
                        (|dispatchFunction| |LAUPOL;extendedEuclidean;3$U;37|)
                        $)))))
          $))) 

(MAKEPROP '|LaurentPolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |LAUPOL;Zero;$;1|) $))
              (0 . |Zero|) (4 . |Zero|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |LAUPOL;One;$;2|) $))
              (8 . |One|) (12 . |One|) (|Boolean|) (16 . =) |LAUPOL;=;2$B;3|
              (|Integer|) |LAUPOL;order;$I;5| (22 . |coerce|)
              |LAUPOL;monomial;RI$;7| |LAUPOL;coerce;UP$;8| (27 . |reductum|)
              |LAUPOL;reductum;2$;9| (32 . *) |LAUPOL;*;I2$;10|
              (|NonNegativeInteger|) (38 . |characteristic|)
              |LAUPOL;characteristic;Nni;11| (42 . |coerce|)
              |LAUPOL;coerce;R$;15| |LAUPOL;coerce;I$;12| (47 . |degree|)
              |LAUPOL;degree;$I;13| (52 . |monomial?|) |LAUPOL;monomial?;$B;14|
              (57 . |monomial|) (|Fraction| 7) (63 . |coerce|) (68 . ^)
              (74 . *) |LAUPOL;convert;$F;16| (80 . *) |LAUPOL;*;3$;17|
              (86 . -) |LAUPOL;-;2$;18| (91 . |zero?|) (96 . |coefficient|)
              |LAUPOL;trailingCoefficient;$R;20| (102 . |leadingCoefficient|)
              |LAUPOL;leadingCoefficient;$R;21| (107 . |zero?|) (|OutputForm|)
              (112 . |coerce|) (117 . |coerce|) (122 . ~=) (|List| 53)
              (128 . |concat|) (134 . +) (|Mapping| 53 53 53) (140 . |reduce|)
              |LAUPOL;coerce;$Of;22| |LAUPOL;coefficient;$IR;23| (146 . +)
              (|Mapping| 7 7) |LAUPOL;differentiate;$M$;24| (152 . |coerce|)
              (157 . ^) (163 . =) (169 . -) (174 . -) (179 . *)
              (|Union| $ '"failed") (185 . |recip|) |LAUPOL;recip;$U;27|
              |LAUPOL;+;3$;28| (190 . |order|) (196 . |exquo|)
              |LAUPOL;exquo;2$U;30| (|Union| 7 '"failed")
              |LAUPOL;retractIfCan;$U;31| (202 . ~=) (|Union| 6 '#1="failed")
              (208 . |retractIfCan|) |LAUPOL;retractIfCan;$U;32| (213 . |gcd|)
              (219 . |gcd|) (225 . |denom|) (230 . |numer|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 90 '#2="failed") (235 . |extendedEuclidean|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (242 . |divide|) (248 . /)
              (|Record| (|:| |polyPart| $) (|:| |fracPart| 38))
              (254 . |separate|) (259 . |divide|) (265 . |euclideanSize|)
              (270 . |extendedEuclidean|) (|Union| 102 '#2#) (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |coef| 102) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Fraction| 18) (|Union| 107 '#1#) (|Union| 18 '#1#) (|List| 111)
              (|Symbol|) (|List| 27)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 277 |zero?| 283 |unitNormal| 288 |unitCanonical| 293 |unit?|
              298 |trailingCoefficient| 303 |subtractIfCan| 308 |sizeLess?| 314
              |separate| 320 |sample| 325 |rightRecip| 329 |rightPower| 334
              |retractIfCan| 346 |retract| 366 |rem| 386 |reductum| 392 |recip|
              397 |quo| 402 |principalIdeal| 408 |order| 413 |opposite?| 418
              |one?| 424 |multiEuclidean| 429 |monomial?| 435 |monomial| 440
              |leftRecip| 446 |leftPower| 451 |leadingCoefficient| 463
              |lcmCoef| 468 |lcm| 474 |latex| 485 |hashUpdate!| 490 |hash| 496
              |gcdPolynomial| 501 |gcd| 507 |extendedEuclidean| 518 |exquo| 531
              |expressIdealMember| 537 |euclideanSize| 543 |divide| 548
              |differentiate| 554 |degree| 604 |convert| 609 |commutator| 614
              |coerce| 620 |coefficient| 650 |charthRoot| 656 |characteristic|
              661 |associator| 665 |associates?| 672 |antiCommutator| 678
              |annihilate?| 684 ^ 690 |Zero| 702 |One| 706 D 710 = 760 - 766 +
              777 * 783)
           'NIL
           (CONS
            (|makeByteWordVec2| 7
                                '(5 5 5 0 0 0 5 0 0 1 2 6 7 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 4 0 0 0 0 0 0
                                  0 0 3 4))
            (CONS
             '#(|EuclideanDomain&| NIL |GcdDomain&| NIL
                |DifferentialExtension&| NIL NIL |EntireRing&| |Algebra&|
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL NIL
                |Rng&| NIL |Module&| NIL NIL |NonAssociativeRing&| NIL
                |NonAssociativeRng&| NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&|
                |RetractableTo&| |RetractableTo&| NIL |SetCategory&|
                |RetractableTo&| |RetractableTo&| NIL NIL NIL NIL NIL NIL
                |BasicType&| NIL NIL NIL)
             (CONS
              '#((|EuclideanDomain|) (|PrincipalIdealDomain|) (|GcdDomain|)
                 (|IntegralDomain|) (|DifferentialExtension| 7)
                 (|CommutativeRing|) (|LeftOreRing|) (|EntireRing|)
                 (|Algebra| $$) (|PartialDifferentialRing| 111)
                 (|DifferentialRing|) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| $$) (|SemiRng|) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|FullyRetractableTo| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|RetractableTo| 7) (|RetractableTo| 6)
                 (|CommutativeStar|) (|SetCategory|) (|RetractableTo| 107)
                 (|RetractableTo| 18) (|CoercibleFrom| 7) (|CoercibleFrom| 6)
                 (|ConvertibleTo| (|Fraction| 7)) (|noZeroDivisors|)
                 (|TwoSidedRecip|) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 53) (|CoercibleFrom| 107) (|CoercibleFrom| 18))
              (|makeByteWordVec2| 117
                                  '(0 6 0 10 0 7 0 11 0 6 0 13 0 7 0 14 2 7 15
                                    0 0 16 1 7 0 6 20 1 7 0 0 23 2 7 0 18 0 25
                                    0 6 27 28 1 6 0 18 30 1 7 27 0 33 1 7 15 0
                                    35 2 7 0 6 27 37 1 38 0 7 39 2 38 0 0 18 40
                                    2 38 0 7 0 41 2 7 0 0 0 43 1 7 0 0 45 1 7
                                    15 0 47 2 7 6 0 27 48 1 7 6 0 50 1 0 15 0
                                    52 1 18 53 0 54 1 7 53 0 55 2 0 15 0 0 56 2
                                    57 0 0 53 58 2 53 0 0 0 59 2 57 53 60 0 61
                                    2 7 0 0 0 64 1 6 53 0 67 2 53 0 0 0 68 2 6
                                    15 0 0 69 1 6 0 0 70 1 53 0 0 71 2 53 0 0 0
                                    72 1 7 73 0 74 2 7 27 0 0 77 2 7 73 0 0 78
                                    2 18 15 0 0 82 1 7 83 0 84 2 7 0 0 0 86 2 0
                                    0 0 0 87 1 38 7 0 88 1 38 7 0 89 3 7 91 0 0
                                    0 92 2 7 93 0 0 94 2 38 0 7 7 95 1 0 96 38
                                    97 2 0 93 0 0 98 1 0 27 0 99 3 0 91 0 0 0
                                    100 2 0 15 0 0 56 1 0 15 0 52 1 0 113 0 1 1
                                    0 0 0 1 1 0 15 0 1 1 0 6 0 49 2 0 73 0 0 1
                                    2 5 15 0 0 1 1 5 96 38 97 0 0 0 1 1 0 73 0
                                    1 2 0 0 0 27 1 2 0 0 0 114 1 1 3 108 0 1 1
                                    4 109 0 1 1 0 80 0 81 1 0 83 0 85 1 3 107 0
                                    1 1 4 18 0 1 1 0 7 0 1 1 0 6 0 1 2 5 0 0 0
                                    1 1 0 0 0 24 1 0 73 0 75 2 5 0 0 0 1 1 5
                                    105 102 1 1 0 18 0 19 2 0 15 0 0 1 1 0 15 0
                                    1 2 5 101 102 0 1 1 0 15 0 36 2 0 0 6 18 21
                                    1 0 73 0 1 2 0 0 0 27 1 2 0 0 0 114 1 1 0 6
                                    0 51 2 5 106 0 0 1 1 5 0 102 1 2 5 0 0 0 1
                                    1 0 115 0 1 2 0 117 117 0 1 1 0 116 0 1 2 5
                                    104 104 104 1 1 5 0 102 1 2 5 0 0 0 87 3 5
                                    91 0 0 0 100 2 5 103 0 0 1 2 0 73 0 0 79 2
                                    5 101 102 0 1 1 5 27 0 99 2 5 93 0 0 98 1 2
                                    0 0 1 2 2 0 0 27 1 2 1 0 0 110 1 2 1 0 0
                                    111 1 3 1 0 0 111 27 1 3 1 0 0 110 112 1 3
                                    0 0 0 65 27 1 2 0 0 0 65 66 1 0 18 0 34 1 0
                                    38 0 42 2 0 0 0 0 1 1 3 0 107 1 1 0 0 7 22
                                    1 0 0 6 31 1 0 0 0 1 1 0 0 18 32 1 0 53 0
                                    62 2 0 6 0 18 63 1 6 73 0 1 0 0 27 29 3 0 0
                                    0 0 0 1 2 0 15 0 0 1 2 0 0 0 0 1 2 0 15 0 0
                                    1 2 0 0 0 27 1 2 0 0 0 114 1 0 0 0 9 0 0 0
                                    12 1 2 0 0 1 2 2 0 0 27 1 2 1 0 0 111 1 2 1
                                    0 0 110 1 3 1 0 0 110 112 1 3 1 0 0 111 27
                                    1 3 0 0 0 65 27 1 2 0 0 0 65 1 2 0 15 0 0
                                    17 1 0 0 0 46 2 0 0 0 0 1 2 0 0 0 0 76 2 0
                                    0 27 0 1 2 0 0 18 0 26 2 0 0 0 0 44 2 0 0
                                    114 0 1)))))
           '|lookupComplete|)) 
