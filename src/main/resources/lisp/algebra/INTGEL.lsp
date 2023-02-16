
(SDEFUN |INTGEL;R_to_F| ((|f| (R)) ($ (|Union| F "failed")))
        (SPROG
         ((|f2| (UP)) (|u2| (|Union| UP "failed")) (|f1| (|Fraction| UP))
          (|u1| (|Union| (|Fraction| UP) "failed")))
         (SEQ (LETT |u1| (SPADCALL |f| (QREFELT $ 11)))
              (EXIT
               (COND ((QEQCAR |u1| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ (LETT |f1| (QCDR |u1|))
                           (LETT |u2| (SPADCALL |f1| (QREFELT $ 14)))
                           (EXIT
                            (COND ((QEQCAR |u2| 1) (CONS 1 "failed"))
                                  (#1#
                                   (SEQ (LETT |f2| (QCDR |u2|))
                                        (EXIT
                                         (SPADCALL |f2|
                                                   (QREFELT $ 16)))))))))))))) 

(SDEFUN |INTGEL;get_elliptics;MFL;2|
        ((|der| (|Mapping| UP UP)) (|x| (F))
         ($
          (|List|
           (|Record| (|:| |f_form| R) (|:| |e_form| R) (|:| |f_var| F)
                     (|:| |f_pol| UP)))))
        (SPROG
         ((|kx| (F)) (|ee| (R)) (|ef| (R)) (|dx| (R)) (|e_pol| (R))
          (|e_coeff| (F)) (|nr| (UP)) (|r| (|Fraction| UP)) (|p| (UPUP))
          (|g| (R)))
         (SEQ
          (COND
           ((QREFELT $ 17)
            (SEQ (LETT |g| (SPADCALL (QREFELT $ 18)))
                 (LETT |p| (SPADCALL (QREFELT $ 19)))
                 (LETT |dx|
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 20) 1 (QREFELT $ 23))
                          |der|)
                         (QREFELT $ 24))
                        (QREFELT $ 25)))
                 (EXIT
                  (COND
                   ((SPADCALL |dx| (|spadConstant| $ 26) (QREFELT $ 28))
                    (SEQ
                     (COND
                      ((EQL (SPADCALL |p| (QREFELT $ 29)) 2)
                       (COND
                        ((SPADCALL (SPADCALL |p| 1 (QREFELT $ 30))
                                   (|spadConstant| $ 31) (QREFELT $ 32))
                         (EXIT
                          (SEQ
                           (LETT |r|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |p| 0 (QREFELT $ 30))
                                            (SPADCALL |p| (QREFELT $ 35))
                                            (QREFELT $ 36))
                                  (QREFELT $ 37)))
                           (EXIT
                            (COND
                             ((SPADCALL (SPADCALL |r| (QREFELT $ 38))
                                        (|spadConstant| $ 21) (QREFELT $ 39))
                              (|error|
                               "get_elliptics: Unexpected denominator"))
                             (#1='T
                              (SEQ (LETT |nr| (SPADCALL |r| (QREFELT $ 40)))
                                   (COND
                                    ((NULL
                                      (SPADCALL
                                       (CONS #'|INTGEL;get_elliptics;MFL;2!0|
                                             (VECTOR |der| $))
                                       (SPADCALL |nr| (QREFELT $ 44))
                                       (QREFELT $ 46)))
                                     (EXIT
                                      (SEQ
                                       (SPADCALL
                                        (SPADCALL "nonconstant coefficients"
                                                  (QREFELT $ 49))
                                        (QREFELT $ 51))
                                       (EXIT NIL)))))
                                   (EXIT
                                    (COND
                                     ((EQL (SPADCALL |nr| (QREFELT $ 52)) 4)
                                      (SEQ
                                       (LETT |e_coeff|
                                             (SPADCALL
                                              (SPADCALL |nr| 3 (QREFELT $ 53))
                                              (SPADCALL
                                               (SPADCALL 2 (QREFELT $ 55))
                                               (SPADCALL |nr| 4 (QREFELT $ 53))
                                               (QREFELT $ 56))
                                              (QREFELT $ 57)))
                                       (LETT |e_pol|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          2 (QREFELT $ 23))
                                                (SPADCALL |e_coeff| 1
                                                          (QREFELT $ 23))
                                                (QREFELT $ 58))
                                               (QREFELT $ 24))
                                              (QREFELT $ 25)))
                                       (LETT |ef|
                                             (SPADCALL |dx| |g|
                                                       (QREFELT $ 59)))
                                       (LETT |ee|
                                             (SPADCALL |e_pol| |ef|
                                                       (QREFELT $ 60)))
                                       (LETT |kx| |x|)
                                       (EXIT
                                        (LIST (VECTOR |ef| |ee| |kx| |nr|)))))
                                     ((EQL (SPADCALL |nr| (QREFELT $ 52)) 3)
                                      (SEQ
                                       (LETT |dx|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          1 (QREFELT $ 23))
                                                |der|)
                                               (QREFELT $ 24))
                                              (QREFELT $ 25)))
                                       (LETT |ef|
                                             (SPADCALL |dx| |g|
                                                       (QREFELT $ 59)))
                                       (LETT |ee|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          1 (QREFELT $ 23))
                                                (QREFELT $ 24))
                                               (QREFELT $ 25))
                                              |ef| (QREFELT $ 60)))
                                       (LETT |kx| |x|)
                                       (EXIT
                                        (LIST (VECTOR |ef| |ee| |kx| |nr|)))))
                                     (#1# NIL)))))))))))))
                     (EXIT NIL)))
                   (#1# NIL)))))
           (#1# NIL))))) 

(SDEFUN |INTGEL;get_elliptics;MFL;2!0| ((|c| NIL) ($$ NIL))
        (PROG ($ |der|)
          (LETT $ (QREFELT $$ 1))
          (LETT |der| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL |c| (QREFELT $ 41)) |der|)
                      (QREFELT $ 42)))))) 

(SDEFUN |INTGEL;fsqrt;2F;3| ((|f| (F)) ($ (F)))
        (SPROG
         ((#1=#:G756 NIL)
          (|ur|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F))))
         (SEQ
          (EXIT
           (SEQ (LETT |ur| (SPADCALL |f| 2 (QREFELT $ 67)))
                (EXIT
                 (COND
                  ((SPADCALL (QVELT |ur| 2) (|spadConstant| $ 20)
                             (QREFELT $ 68))
                   (PROGN (LETT #1# (QVELT |ur| 1)) (GO #2=#:G755)))
                  ('T (SPADCALL |f| (QREFELT $ 70)))))))
          #2# (EXIT #1#)))) 

(SDEFUN |INTGEL;fsqrt;2F;4| ((|f| (F)) ($ (F)))
        (SPROG
         ((#1=#:G760 NIL)
          (|ur|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F))))
         (SEQ
          (EXIT
           (SEQ (LETT |ur| (SPADCALL |f| 2 (QREFELT $ 73)))
                (EXIT
                 (COND
                  ((SPADCALL (QVELT |ur| 2) (|spadConstant| $ 20)
                             (QREFELT $ 68))
                   (PROGN (LETT #1# (QVELT |ur| 1)) (GO #2=#:G759)))
                  ('T (SPADCALL |f| (QREFELT $ 75)))))))
          #2# (EXIT #1#)))) 

(PUT '|INTGEL;fsqrt;2F;5| '|SPADreplace|
     '(XLAM (|f|) (|error| "unimplemented"))) 

(SDEFUN |INTGEL;fsqrt;2F;5| ((|f| (F)) ($ (F))) (|error| "unimplemented")) 

(SDEFUN |INTGEL;gen_ef4l|
        ((|f_var| (F)) (|f_pol| (UP)) (|cf| (F)) (|ce| (F)) ($ (F)))
        (SPROG
         ((|res| (F)) (|et| (F)) (|ft| (F)) (|ca| (F)) (|f_par| (F))
          (|var| (F)) (|c22| (F)) (|c2| (F)) (|d2| (F)) (|c2a| (F)) (|del| (F))
          (C (F)) (B (F)) (A (F)))
         (SEQ (LETT A (SPADCALL |f_pol| 0 (QREFELT $ 53)))
              (LETT B
                    (SPADCALL (SPADCALL |f_pol| 2 (QREFELT $ 53)) A
                              (QREFELT $ 57)))
              (LETT C
                    (SPADCALL (SPADCALL |f_pol| (QREFELT $ 76)) A
                              (QREFELT $ 57)))
              (LETT |del|
                    (SPADCALL (SPADCALL B 2 (QREFELT $ 78))
                              (SPADCALL (SPADCALL 4 (QREFELT $ 55)) C
                                        (QREFELT $ 56))
                              (QREFELT $ 79)))
              (LETT |d2| (SPADCALL |del| (QREFELT $ 71)))
              (LETT |c2a|
                    (SPADCALL
                     (SPADCALL (SPADCALL |d2| (QREFELT $ 80)) B (QREFELT $ 79))
                     (SPADCALL 2 (QREFELT $ 55)) (QREFELT $ 57)))
              (LETT |c2|
                    (COND
                     ((SPADCALL |c2a| (|spadConstant| $ 20) (QREFELT $ 68))
                      (SEQ (LETT |d2| (SPADCALL |d2| (QREFELT $ 80)))
                           (EXIT |c2a|)))
                     ('T
                      (SPADCALL (SPADCALL |d2| B (QREFELT $ 79))
                                (SPADCALL 2 (QREFELT $ 55)) (QREFELT $ 57)))))
              (LETT |c22| (SPADCALL |c2| (QREFELT $ 71)))
              (LETT |var| (SPADCALL |c22| |f_var| (QREFELT $ 56)))
              (LETT |f_par|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL B |d2| (QREFELT $ 56))
                                (SPADCALL (SPADCALL 2 (QREFELT $ 55)) C
                                          (QREFELT $ 56))
                                (QREFELT $ 79))
                      (SPADCALL B B (QREFELT $ 56)) (QREFELT $ 81))
                     (SPADCALL (SPADCALL 2 (QREFELT $ 55)) C (QREFELT $ 56))
                     (QREFELT $ 57)))
              (LETT |ca|
                    (SPADCALL (|spadConstant| $ 20)
                              (SPADCALL (SPADCALL A (QREFELT $ 71)) |c22|
                                        (QREFELT $ 56))
                              (QREFELT $ 57)))
              (LETT |ce|
                    (SPADCALL (SPADCALL |ce| |f_par| (QREFELT $ 57))
                              (QREFELT $ 80)))
              (LETT |cf| (SPADCALL |cf| |ce| (QREFELT $ 79)))
              (LETT |ft| (SPADCALL |var| |f_par| (QREFELT $ 82)))
              (LETT |et| (SPADCALL |var| |f_par| (QREFELT $ 83)))
              (LETT |res|
                    (SPADCALL |ca|
                              (SPADCALL (SPADCALL |cf| |ft| (QREFELT $ 56))
                                        (SPADCALL |ce| |et| (QREFELT $ 56))
                                        (QREFELT $ 81))
                              (QREFELT $ 56)))
              (EXIT |res|)))) 

(SDEFUN |INTGEL;gen_ef3|
        ((|f_var| (F)) (|f_pol| (UP)) (|cf| (F)) (|ce| (F)) ($ (F)))
        (SPROG
         ((|fi| (F)) (|p_inv| (F)) (|ca| (F)) (|g3| (F)) (|g2| (F))
          (|f_pol2| (UP)) (|shift| (F)) (B (F)) (A (F)))
         (SEQ (LETT A (SPADCALL |f_pol| (QREFELT $ 76)))
              (LETT B (SPADCALL |f_pol| 2 (QREFELT $ 53)))
              (LETT |shift|
                    (SPADCALL B
                              (SPADCALL (SPADCALL 3 (QREFELT $ 55)) A
                                        (QREFELT $ 56))
                              (QREFELT $ 57)))
              (LETT |f_pol2|
                    (SPADCALL |f_pol| (QREFELT $ 86)
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 20) 1
                                         (QREFELT $ 23))
                               (SPADCALL |shift| (QREFELT $ 41))
                               (QREFELT $ 87))
                              (QREFELT $ 88)))
              (LETT |f_pol2|
                    (SPADCALL
                     (SPADCALL (SPADCALL 4 (QREFELT $ 55)) A (QREFELT $ 57))
                     |f_pol2| (QREFELT $ 89)))
              (LETT |g2|
                    (SPADCALL (SPADCALL |f_pol2| 1 (QREFELT $ 53))
                              (QREFELT $ 80)))
              (LETT |g3|
                    (SPADCALL (SPADCALL |f_pol2| 0 (QREFELT $ 53))
                              (QREFELT $ 80)))
              (LETT |ca|
                    (SPADCALL (SPADCALL 2 (QREFELT $ 55))
                              (SPADCALL A (QREFELT $ 71)) (QREFELT $ 57)))
              (LETT |p_inv|
                    (SPADCALL |g2| |g3|
                              (SPADCALL |f_var| |shift| (QREFELT $ 81))
                              (QREFELT $ 90)))
              (LETT |fi|
                    (SPADCALL |ca|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL |cf|
                                          (SPADCALL |ce| |shift|
                                                    (QREFELT $ 56))
                                          (QREFELT $ 79))
                                |p_inv| (QREFELT $ 56))
                               (SPADCALL |ce|
                                         (SPADCALL |g2| |g3| |p_inv|
                                                   (QREFELT $ 91))
                                         (QREFELT $ 56))
                               (QREFELT $ 79))
                              (QREFELT $ 56)))
              (EXIT |fi|)))) 

(SDEFUN |INTGEL;gen_ef4|
        ((|f_var| (F)) (|f_pol| (UP)) (|cf| (F)) (|ce| (F))
         ($
          (|Union| (|Record| (|:| |result1| (|Fraction| UP)) (|:| |result2| F))
                   "failed")))
        (SPROG
         ((|ans1| (|Fraction| UP)) (|f_pol1| (UP)) (|c4| (F)) (|c3| (F))
          (|c2| (F)) (|c1| (F)) (|c0| (F)))
         (SEQ (LETT |c0| (SPADCALL |f_pol| 0 (QREFELT $ 53)))
              (LETT |c1| (SPADCALL |f_pol| 1 (QREFELT $ 53)))
              (LETT |c2| (SPADCALL |f_pol| 2 (QREFELT $ 53)))
              (LETT |c3| (SPADCALL |f_pol| 3 (QREFELT $ 53)))
              (LETT |c4| (SPADCALL |f_pol| 4 (QREFELT $ 53)))
              (EXIT
               (COND
                ((SPADCALL |c0| (|spadConstant| $ 33) (QREFELT $ 68))
                 (SEQ
                  (LETT |f_pol1|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |c1| 3 (QREFELT $ 23))
                                    (SPADCALL |c2| 2 (QREFELT $ 23))
                                    (QREFELT $ 58))
                          (SPADCALL |c3| 1 (QREFELT $ 23)) (QREFELT $ 58))
                         (SPADCALL |c4| (QREFELT $ 41)) (QREFELT $ 58)))
                  (LETT |ans1|
                        (SPADCALL
                         (SPADCALL (SPADCALL |ce| |c4| (QREFELT $ 57))
                                   (QREFELT $ 41))
                         (SPADCALL (|spadConstant| $ 20) 1 (QREFELT $ 23))
                         (QREFELT $ 92)))
                  (EXIT
                   (CONS 0
                         (CONS |ans1|
                               (SPADCALL
                                (|INTGEL;gen_ef3|
                                 (SPADCALL (|spadConstant| $ 20) |f_var|
                                           (QREFELT $ 57))
                                 |f_pol1| |cf|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |ce| |c4| (QREFELT $ 57))
                                            |c1| (QREFELT $ 56))
                                  (SPADCALL 2 (QREFELT $ 55)) (QREFELT $ 57))
                                 $)
                                (QREFELT $ 80)))))))
                ((OR (SPADCALL |c1| (|spadConstant| $ 33) (QREFELT $ 93))
                     (SPADCALL |c3| (|spadConstant| $ 33) (QREFELT $ 93)))
                 (CONS 1 "failed"))
                ('T
                 (CONS 0
                       (CONS (|spadConstant| $ 31)
                             (|INTGEL;gen_ef4l| |f_var| |f_pol| |cf| |ce|
                              $))))))))) 

(SDEFUN |INTGEL;gen_ef;FUP2RU;9|
        ((|f_var| (F)) (|f_pol| (UP)) (|cfr| (R)) (|cer| (R))
         ($
          (|Union| (|Record| (|:| |result1| (|Fraction| UP)) (|:| |result2| F))
                   "failed")))
        (SPROG
         ((|ce| (F)) (|ceu| #1=(|Union| F "failed")) (|cf| (F)) (|cfu| #1#))
         (SEQ (LETT |cfu| (|INTGEL;R_to_F| |cfr| $))
              (EXIT
               (COND
                ((QEQCAR |cfu| 1)
                 (|error| "gen_ef: Constant not in base field"))
                (#2='T
                 (SEQ (LETT |cf| (QCDR |cfu|))
                      (LETT |ceu| (|INTGEL;R_to_F| |cer| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ceu| 1)
                         (|error| "gen_ef: Constant not in base field"))
                        (#2#
                         (SEQ (LETT |ce| (QCDR |ceu|))
                              (EXIT
                               (COND
                                ((EQL (SPADCALL |f_pol| (QREFELT $ 52)) 4)
                                 (|INTGEL;gen_ef4| |f_var| |f_pol| |cf| |ce|
                                  $))
                                ((EQL (SPADCALL |f_pol| (QREFELT $ 52)) 3)
                                 (CONS 0
                                       (CONS (|spadConstant| $ 31)
                                             (|INTGEL;gen_ef3| |f_var| |f_pol|
                                              |cf| |ce| $))))
                                (#2#
                                 (|error|
                                  "gen_ef: unsupported case"))))))))))))))) 

(PUT '|INTGEL;gen_ef;FUP2RU;10| '|SPADreplace|
     '(XLAM (|f_var| |f_pol| |cfr| |cer|)
       (|error| "gen_ef: unimplemented for F"))) 

(SDEFUN |INTGEL;gen_ef;FUP2RU;10|
        ((|f_var| (F)) (|f_pol| (UP)) (|cfr| (R)) (|cer| (R))
         ($
          (|Union| (|Record| (|:| |result1| (|Fraction| UP)) (|:| |result2| F))
                   "failed")))
        (|error| "gen_ef: unimplemented for F")) 

(DECLAIM (NOTINLINE |GenerateEllipticIntegrals;|)) 

(DEFUN |GenerateEllipticIntegrals| (&REST #1=#:G791)
  (SPROG NIL
         (PROG (#2=#:G792)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GenerateEllipticIntegrals|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GenerateEllipticIntegrals;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GenerateEllipticIntegrals|)))))))))) 

(DEFUN |GenerateEllipticIntegrals;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|GenerateEllipticIntegrals| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 97))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|GenerateEllipticIntegrals|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 17
              (COND ((|domainEqual| |#1| (|Expression| (|Integer|))) 'T)
                    ('T
                     (|domainEqual| |#1|
                                    (|Expression| (|Complex| (|Integer|)))))))
    (COND
     ((|domainEqual| |#1| (|Expression| (|Integer|)))
      (QSETREFV $ 71 (CONS (|dispatchFunction| |INTGEL;fsqrt;2F;3|) $)))
     ((|domainEqual| |#1| (|Expression| (|Complex| (|Integer|))))
      (QSETREFV $ 71 (CONS (|dispatchFunction| |INTGEL;fsqrt;2F;4|) $)))
     ('T (QSETREFV $ 71 (CONS (|dispatchFunction| |INTGEL;fsqrt;2F;5|) $))))
    (COND
     ((|HasCategory| |#1| '(|SpecialFunctionCategory|))
      (PROGN
       (QSETREFV $ 86 (SPADCALL (QREFELT $ 85)))
       (QSETREFV $ 96 (CONS (|dispatchFunction| |INTGEL;gen_ef;FUP2RU;9|) $))))
     ('T
      (QSETREFV $ 96 (CONS (|dispatchFunction| |INTGEL;gen_ef;FUP2RU;10|) $))))
    $))) 

(MAKEPROP '|GenerateEllipticIntegrals| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Union| 13 '#1="failed")
              (0 . |retractIfCan|) (|Union| 7 '"failed") (|Fraction| 7)
              (5 . |retractIfCan|) (|Union| 6 '#1#) (10 . |retractIfCan|)
              '|good_F| (15 . |generator|) (19 . |definingPolynomial|)
              (23 . |One|) (27 . |One|) (|NonNegativeInteger|)
              (31 . |monomial|) (37 . |coerce|) (42 . |coerce|) (47 . |One|)
              (|Boolean|) (51 . =) (57 . |degree|) (62 . |coefficient|)
              (68 . |Zero|) (72 . =) (78 . |Zero|) (82 . |Zero|)
              (86 . |leadingCoefficient|) (91 . /) (97 . -) (102 . |denom|)
              (107 . ~=) (113 . |numer|) (118 . |coerce|) (123 . |zero?|)
              (|List| 6) (128 . |coefficients|) (|Mapping| 27 6)
              (133 . |every?|) (|String|) (|OutputForm|) (139 . |message|)
              (|Void|) (144 . |print|) (149 . |degree|) (154 . |coefficient|)
              (|Integer|) (160 . |coerce|) (165 . *) (171 . /) (177 . +)
              (183 . /) (189 . *)
              (|Record| (|:| |f_form| 9) (|:| |e_form| 9) (|:| |f_var| 6)
                        (|:| |f_pol| 7))
              (|List| 61) (|Mapping| 7 7) |INTGEL;get_elliptics;MFL;2|
              (|Record| (|:| |exponent| 22) (|:| |coef| 6) (|:| |radicand| 6))
              (|PolynomialRoots| (|IndexedExponents| (|Kernel| 6)) (|Kernel| 6)
                                 54
                                 (|SparseMultivariatePolynomial| 54
                                                                 (|Kernel| 6))
                                 6)
              (195 . |froot|) (201 . =) (|Expression| 54) (207 . |sqrt|)
              (212 . |fsqrt|)
              (|PolynomialRoots| (|IndexedExponents| (|Kernel| 6)) (|Kernel| 6)
                                 (|Complex| 54)
                                 (|SparseMultivariatePolynomial| (|Complex| 54)
                                                                 (|Kernel| 6))
                                 6)
              (217 . |froot|) (|Expression| (|Complex| 54)) (223 . |sqrt|)
              (228 . |leadingCoefficient|) (|PositiveInteger|) (233 . ^)
              (239 . -) (245 . -) (250 . +) (256 . |ellipticF|)
              (262 . |ellipticE|) (|SingletonAsOrderedSet|) (268 . |create|)
              '|d_var| (272 . -) (278 . |eval|) (285 . *)
              (291 . |weierstrassPInverse|) (298 . |weierstrassZeta|) (305 . /)
              (311 . ~=) (|Record| (|:| |result1| 13) (|:| |result2| 6))
              (|Union| 94 '"failed") (317 . |gen_ef|))
           '#(|get_elliptics| 325 |gen_ef| 331 |fsqrt| 339) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|get_elliptics|
                                 ((|List|
                                   (|Record| (|:| |f_form| |#4|)
                                             (|:| |e_form| |#4|)
                                             (|:| |f_var| |#1|)
                                             (|:| |f_pol| |#2|)))
                                  (|Mapping| |#2| |#2|) |#1|))
                                T)
                              '((|gen_ef|
                                 ((|Union|
                                   (|Record| (|:| |result1| (|Fraction| |#2|))
                                             (|:| |result2| |#1|))
                                   "failed")
                                  |#1| |#2| |#4| |#4|))
                                T)
                              '((|fsqrt| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 96
                                            '(1 9 10 0 11 1 13 12 0 14 1 7 15 0
                                              16 0 9 0 18 0 9 8 19 0 6 0 20 0 7
                                              0 21 2 7 0 6 22 23 1 13 0 7 24 1
                                              9 0 13 25 0 9 0 26 2 9 27 0 0 28
                                              1 8 22 0 29 2 8 13 0 22 30 0 13 0
                                              31 2 13 27 0 0 32 0 6 0 33 0 7 0
                                              34 1 8 13 0 35 2 13 0 0 0 36 1 13
                                              0 0 37 1 13 7 0 38 2 7 27 0 0 39
                                              1 13 7 0 40 1 7 0 6 41 1 7 27 0
                                              42 1 7 43 0 44 2 43 27 45 0 46 1
                                              48 0 47 49 1 48 50 0 51 1 7 22 0
                                              52 2 7 6 0 22 53 1 6 0 54 55 2 6
                                              0 0 0 56 2 6 0 0 0 57 2 7 0 0 0
                                              58 2 9 0 0 0 59 2 9 0 0 0 60 2 66
                                              65 6 22 67 2 6 27 0 0 68 1 69 0 0
                                              70 1 0 6 6 71 2 72 65 6 22 73 1
                                              74 0 0 75 1 7 6 0 76 2 6 0 0 77
                                              78 2 6 0 0 0 79 1 6 0 0 80 2 6 0
                                              0 0 81 2 6 0 0 0 82 2 6 0 0 0 83
                                              0 84 0 85 2 7 0 0 0 87 3 7 0 0 84
                                              0 88 2 7 0 6 0 89 3 6 0 0 0 0 90
                                              3 6 0 0 0 0 91 2 13 0 7 7 92 2 6
                                              27 0 0 93 4 0 95 6 7 9 9 96 2 0
                                              62 63 6 64 4 0 95 6 7 9 9 96 1 0
                                              6 6 71)))))
           '|lookupComplete|)) 
