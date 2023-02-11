
(SDEFUN |CHVAR;eval;UPUP2FUPUP;1|
        ((|p| (UPUP)) (|x| (|Fraction| UP)) (|y| (|Fraction| UP)) ($ (UPUP)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (CONS #'|CHVAR;eval;UPUP2FUPUP;1!0| (VECTOR $ |x|))
                          |p| (QREFELT $ 12))
                (SPADCALL |y| 1 (QREFELT $ 17)) (QREFELT $ 18)))) 

(SDEFUN |CHVAR;eval;UPUP2FUPUP;1!0| ((|s| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |x| (QREFELT $ 10)))))) 

(SDEFUN |CHVAR;good?| ((|a| (F)) (|p| (UP)) (|lq| (|List| UP)) ($ (|Boolean|)))
        (SPROG ((#1=#:G720 NIL) (#2=#:G721 NIL) (|q| NIL))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |p| |a| (QREFELT $ 20))
                             (|spadConstant| $ 21) (QREFELT $ 23))
                   NIL)
                  ('T
                   (SEQ
                    (SEQ (LETT |q| NIL) (LETT #2# |lq|) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |q| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |q| |a| (QREFELT $ 20))
                                       (|spadConstant| $ 21) (QREFELT $ 23))
                             (PROGN (LETT #1# NIL) (GO #3=#:G719))))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT 'T)))))
                #3# (EXIT #1#)))) 

(SDEFUN |CHVAR;algPoly|
        ((|p| (UPUP))
         ($ (|Record| (|:| |coef| (|Fraction| UP)) (|:| |poly| UPUP))))
        (SPROG ((|q| (UPUP)) (|c| (UP)) (|d| (UP)) (|a| (UP)))
               (SEQ
                (COND
                 ((SPADCALL
                   (LETT |a|
                         (SPADCALL
                          (SPADCALL (LETT |q| (SPADCALL |p| (QREFELT $ 25)))
                                    (QREFELT $ 26))
                          (QREFELT $ 27)))
                   (QREFELT $ 28))
                  (|CHVAR;RPrim| (|spadConstant| $ 14) |a| |q| $))
                 ('T
                  (SEQ (LETT |c| (LETT |d| (SPADCALL |a| (QREFELT $ 29))))
                       (LETT |q|
                             (SPADCALL
                              (SPADCALL |q|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |d| (QREFELT $ 30))
                                          (QREFELT $ 31))
                                         1 (QREFELT $ 17))
                                        (QREFELT $ 18))
                              (QREFELT $ 25)))
                       (SEQ G190
                            (COND
                             ((NULL
                               (NULL
                                (SPADCALL
                                 (LETT |a|
                                       (SPADCALL (SPADCALL |q| (QREFELT $ 26))
                                                 (QREFELT $ 27)))
                                 (QREFELT $ 28))))
                              (GO G191)))
                            (SEQ
                             (LETT |c|
                                   (SPADCALL |c|
                                             (LETT |d|
                                                   (SPADCALL |a| |d|
                                                             (QREFELT $ 32)))
                                             (QREFELT $ 33)))
                             (EXIT
                              (LETT |q|
                                    (SPADCALL
                                     (SPADCALL |q|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |d| (QREFELT $ 30))
                                                 (QREFELT $ 31))
                                                1 (QREFELT $ 17))
                                               (QREFELT $ 18))
                                     (QREFELT $ 25)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (|CHVAR;RPrim| |c| |a| |q| $)))))))) 

(SDEFUN |CHVAR;RPrim|
        ((|c| (UP)) (|a| (UP)) (|q| (UPUP))
         ($ (|Record| (|:| |coef| (|Fraction| UP)) (|:| |poly| UPUP))))
        (COND
         ((SPADCALL |a| (|spadConstant| $ 14) (QREFELT $ 34))
          (CONS (SPADCALL |c| (QREFELT $ 30)) |q|))
         ('T
          (CONS (SPADCALL (SPADCALL |a| |c| (QREFELT $ 33)) (QREFELT $ 30))
                (SPADCALL
                 (SPADCALL |q|
                           (SPADCALL
                            (SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                      (QREFELT $ 31))
                            1 (QREFELT $ 17))
                           (QREFELT $ 18))
                 (QREFELT $ 25)))))) 

(SDEFUN |CHVAR;chvar;LUPUPR;5|
        ((|lf| (|List| UPUP)) (|modulus| (UPUP))
         ($
          (|Record| (|:| |func| (|List| UPUP)) (|:| |poly| UPUP)
                    (|:| |c1| (|Fraction| UP)) (|:| |c2| (|Fraction| UP))
                    (|:| |deg| (|NonNegativeInteger|)))))
        (SPROG
         ((#1=#:G751 NIL) (|f| NIL) (#2=#:G750 NIL) (|ir2| #3=(|Fraction| UP))
          (|im2| (|Fraction| UP)) (|t| #3#) (|r2c| (UP))
          (|r2| #4=(|Record| (|:| |coef| (|Fraction| UP)) (|:| |poly| UPUP)))
          (|x| (|Fraction| UP)) (|a| (F)) (|inf_deg| (|NonNegativeInteger|))
          (|lf1| (|List| UPUP)) (#5=#:G749 NIL) (#6=#:G748 NIL) (|m1| (UPUP))
          (|r1inv| #3#) (|r1| #4#))
         (SEQ (LETT |r1| (SPADCALL |modulus| (QREFELT $ 36)))
              (LETT |r1inv| (SPADCALL (QCAR |r1|) (QREFELT $ 31)))
              (LETT |m1| (SPADCALL |r1inv| 1 (QREFELT $ 17)))
              (LETT |lf1|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |f| NIL) (LETT #5# |lf|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6#
                                  (CONS (SPADCALL |f| |m1| (QREFELT $ 18))
                                        #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (COND
               ((SPADCALL (SPADCALL (QCAR |r1|) (QREFELT $ 37))
                          (|spadConstant| $ 14) (QREFELT $ 34))
                (COND
                 ((SPADCALL (CONS #'|CHVAR;chvar;LUPUPR;5!0| (VECTOR $ |r1|))
                            |lf1| (QREFELT $ 40))
                  (EXIT
                   (SEQ
                    (LETT |inf_deg|
                          (SPADCALL (SPADCALL (QCAR |r1|) (QREFELT $ 41))
                                    (QREFELT $ 42)))
                    (EXIT
                     (VECTOR |lf1| (QCDR |r1|)
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 43))
                              (QREFELT $ 30))
                             (QCAR |r1|) |inf_deg|))))))))
              (LETT |x|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (LETT |a| (SPADCALL |lf1| (QCDR |r1|) (QREFELT $ 44)))
                       (QREFELT $ 45))
                      (QREFELT $ 30))
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 43))
                       (QREFELT $ 30))
                      (QREFELT $ 31))
                     (QREFELT $ 46)))
              (LETT |r2c|
                    (SPADCALL
                     (QCAR
                      (LETT |r2|
                            (SPADCALL
                             (SPADCALL
                              (CONS #'|CHVAR;chvar;LUPUPR;5!1| (VECTOR $ |x|))
                              (QCDR |r1|) (QREFELT $ 12))
                             (QREFELT $ 36))))
                     (QREFELT $ 27)))
              (LETT |t|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 43))
                       (SPADCALL |a| (QREFELT $ 45)) (QREFELT $ 47))
                      (QREFELT $ 30))
                     (QREFELT $ 31)))
              (LETT |im2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 13) 2 (QREFELT $ 43))
                       (QREFELT $ 30))
                      (QREFELT $ 31))
                     (QREFELT $ 48)))
              (LETT |ir2| (SPADCALL (QCAR |r2|) (QREFELT $ 31)))
              (EXIT
               (VECTOR
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL) (LETT #1# |lf1|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL |im2|
                                         (SPADCALL |f| |x| |ir2|
                                                   (QREFELT $ 19))
                                         (QREFELT $ 49))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))
                (QCDR |r2|) |t|
                (SPADCALL (QCAR |r1|) (SPADCALL |r2c| |t| (QREFELT $ 50))
                          (QREFELT $ 51))
                (SPADCALL |r2c| (QREFELT $ 42))))))) 

(SDEFUN |CHVAR;chvar;LUPUPR;5!1| ((|s| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |x| (QREFELT $ 10)))))) 

(SDEFUN |CHVAR;chvar;LUPUPR;5!0| ((|f| NIL) ($$ NIL))
        (PROG (|r1| $)
          (LETT |r1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|CHVAR;infIntegral?| |f| (QCDR |r1|) $))))) 

(SDEFUN |CHVAR;chvar;2UPUPR;6|
        ((|f| (UPUP)) (|p| (UPUP))
         ($
          (|Record| (|:| |func| UPUP) (|:| |poly| UPUP)
                    (|:| |c1| (|Fraction| UP)) (|:| |c2| (|Fraction| UP))
                    (|:| |deg| (|NonNegativeInteger|)))))
        (SPROG
         ((|res1|
           (|Record| (|:| |func| (|List| UPUP)) (|:| |poly| UPUP)
                     (|:| |c1| (|Fraction| UP)) (|:| |c2| (|Fraction| UP))
                     (|:| |deg| (|NonNegativeInteger|)))))
         (SEQ (LETT |res1| (SPADCALL (LIST |f|) |p| (QREFELT $ 53)))
              (EXIT
               (VECTOR (|SPADfirst| (QVELT |res1| 0)) (QVELT |res1| 1)
                       (QVELT |res1| 2) (QVELT |res1| 3) (QVELT |res1| 4)))))) 

(SDEFUN |CHVAR;infIntegral?| ((|p| (UPUP)) (|modulus| (UPUP)) ($ (|Boolean|)))
        (SPROG
         ((|degp| (|Fraction| (|Integer|))) (|c| (|Fraction| UP))
          (|degy| (|Fraction| (|Integer|))) (|ninv| (|Fraction| (|Integer|)))
          (|r|
           (|Union|
            (|Record| (|:| |radicand| (|Fraction| UP))
                      (|:| |deg| (|NonNegativeInteger|)))
            "failed")))
         (SEQ (LETT |r| (SPADCALL |modulus| (QREFELT $ 58)))
              (EXIT
               (COND ((QEQCAR |r| 1) NIL)
                     ('T
                      (SEQ
                       (LETT |ninv|
                             (SPADCALL
                              (SPADCALL (QCDR (QCDR |r|)) (QREFELT $ 61))
                              (QREFELT $ 62)))
                       (LETT |degy|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (QCAR (QCDR |r|)) (QREFELT $ 27))
                               (QREFELT $ 42))
                              |ninv| (QREFELT $ 63)))
                       (LETT |degp| (|spadConstant| $ 64))
                       (SEQ G190
                            (COND
                             ((NULL
                               (SPADCALL |p| (|spadConstant| $ 66)
                                         (QREFELT $ 67)))
                              (GO G191)))
                            (SEQ (LETT |c| (SPADCALL |p| (QREFELT $ 26)))
                                 (LETT |degp|
                                       (SPADCALL |degp|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (-
                                                    (+ 2
                                                       (SPADCALL
                                                        (SPADCALL |c|
                                                                  (QREFELT $
                                                                           41))
                                                        (QREFELT $ 42)))
                                                    (SPADCALL
                                                     (SPADCALL |c|
                                                               (QREFELT $ 37))
                                                     (QREFELT $ 42)))
                                                   (QREFELT $ 61))
                                                  (SPADCALL
                                                   (SPADCALL |p|
                                                             (QREFELT $ 68))
                                                   |degy| (QREFELT $ 63))
                                                  (QREFELT $ 69))
                                                 (QREFELT $ 70)))
                                 (EXIT
                                  (LETT |p| (SPADCALL |p| (QREFELT $ 71)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (SPADCALL |degp| |ninv| (QREFELT $ 72)))))))))) 

(SDEFUN |CHVAR;mkIntegral;UPUPR;8|
        ((|p| (UPUP))
         ($ (|Record| (|:| |coef| (|Fraction| UP)) (|:| |poly| UPUP))))
        (SPROG
         ((|rp|
           (|Record| (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coef| (|Fraction| UP)) (|:| |radicand| UP)))
          (|r|
           (|Union|
            (|Record| (|:| |radicand| (|Fraction| UP))
                      (|:| |deg| (|NonNegativeInteger|)))
            "failed")))
         (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 58)))
              (EXIT
               (COND ((QEQCAR |r| 1) (|CHVAR;algPoly| |p| $))
                     ('T
                      (SEQ
                       (LETT |rp|
                             (SPADCALL (QCAR (QCDR |r|)) (QCDR (QCDR |r|))
                                       (QREFELT $ 74)))
                       (EXIT
                        (CONS (QVELT |rp| 1)
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 75) (QVELT |rp| 0)
                                         (QREFELT $ 17))
                               (SPADCALL
                                (SPADCALL (QVELT |rp| 2) (QREFELT $ 30))
                                (QREFELT $ 76))
                               (QREFELT $ 77))))))))))) 

(SDEFUN |CHVAR;goodPoint;LUPUPF;9|
        ((|lp| (|List| UPUP)) (|modulus| (UPUP)) ($ (F)))
        (SPROG
         ((#1=#:G791 NIL) (#2=#:G792 NIL) (|a| (F)) (|i| NIL)
          (|ld| (|List| UP)) (#3=#:G794 NIL) (|p| NIL) (#4=#:G793 NIL)
          (|q| (UP))
          (|r|
           (|Union|
            (|Record| (|:| |radicand| (|Fraction| UP))
                      (|:| |deg| (|NonNegativeInteger|)))
            "failed")))
         (SEQ
          (EXIT
           (SEQ
            (LETT |q|
                  (SEQ (LETT |r| (SPADCALL |modulus| (QREFELT $ 58)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (SPADCALL
                           (SPADCALL |modulus|
                                     (SPADCALL |modulus| (QREFELT $ 78))
                                     (QREFELT $ 79))
                           (QREFELT $ 27)))
                         ('T (SPADCALL (QCAR (QCDR |r|)) (QREFELT $ 27)))))))
            (LETT |ld|
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |p| NIL) (LETT #3# |lp|) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #4# (CONS (SPADCALL |p| (QREFELT $ 80)) #4#))))
                        (LETT #3# (CDR #3#)) (GO G190) G191
                        (EXIT (NREVERSE #4#)))))
            (EXIT
             (SEQ (LETT |i| 0) G190 NIL
                  (SEQ
                   (EXIT
                    (COND
                     ((|CHVAR;good?| (LETT |a| (SPADCALL |i| (QREFELT $ 81)))
                       |q| |ld| $)
                      (PROGN (LETT #2# |a|) (GO #5=#:G790)))
                     ('T
                      (SEQ
                       (EXIT
                        (COND
                         ((|CHVAR;good?| (SPADCALL |a| (QREFELT $ 82)) |q| |ld|
                           $)
                          (PROGN
                           (LETT #1#
                                 (PROGN
                                  (LETT #2# (SPADCALL |a| (QREFELT $ 82)))
                                  (GO #5#)))
                           (GO #6=#:G786)))))
                       #6# (EXIT #1#))))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |CHVAR;radPoly;UPUPU;10|
        ((|p| (UPUP))
         ($
          (|Union|
           (|Record| (|:| |radicand| (|Fraction| UP))
                     (|:| |deg| (|NonNegativeInteger|)))
           "failed")))
        (SPROG ((|r| (|Union| (|Fraction| UP) "failed")))
               (SEQ
                (LETT |r|
                      (SPADCALL (SPADCALL |p| (QREFELT $ 71)) (QREFELT $ 84)))
                (EXIT
                 (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                       ('T
                        (CONS 0
                              (CONS (SPADCALL (QCDR |r|) (QREFELT $ 48))
                                    (SPADCALL |p| (QREFELT $ 68)))))))))) 

(SDEFUN |CHVAR;rootPoly;FNniR;11|
        ((|g| (|Fraction| UP)) (|m| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|))
                    (|:| |coef| (|Fraction| UP)) (|:| |radicand| UP))))
        (SPROG
         ((#1=#:G818 NIL) (#2=#:G817 (UP)) (#3=#:G819 (UP)) (#4=#:G823 NIL)
          (#5=#:G689 NIL)
          (|pr|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| UP)
                     (|:| |radicand| (|List| UP))))
          (#6=#:G815 NIL) (|d| (UP)))
         (SEQ
          (COND ((SPADCALL |g| (QREFELT $ 85)) (|error| "Should not happen"))
                (#7='T
                 (SEQ
                  (LETT |pr|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |g| (QREFELT $ 41))
                                    (SPADCALL
                                     (LETT |d| (SPADCALL |g| (QREFELT $ 37)))
                                     (PROG1 (LETT #6# (- |m| 1))
                                       (|check_subtype2| (>= #6# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #6#))
                                     (QREFELT $ 86))
                                    (QREFELT $ 33))
                          (QREFELT $ 88))
                         |m| (QREFELT $ 92)))
                  (EXIT
                   (VECTOR (QVELT |pr| 0)
                           (SPADCALL |d| (QVELT |pr| 1) (QREFELT $ 93))
                           (PROGN
                            (LETT #1# NIL)
                            (SEQ (LETT #5# NIL) (LETT #4# (QVELT |pr| 2)) G190
                                 (COND
                                  ((OR (ATOM #4#)
                                       (PROGN (LETT #5# (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (PROGN
                                    (LETT #3# #5#)
                                    (COND
                                     (#1#
                                      (LETT #2#
                                            (SPADCALL #2# #3# (QREFELT $ 33))))
                                     ('T
                                      (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                                 (LETT #4# (CDR #4#)) (GO G190) G191
                                 (EXIT NIL))
                            (COND (#1# #2#)
                                  (#7# (|spadConstant| $ 14)))))))))))) 

(DECLAIM (NOTINLINE |ChangeOfVariable;|)) 

(DEFUN |ChangeOfVariable| (&REST #1=#:G824)
  (SPROG NIL
         (PROG (#2=#:G825)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ChangeOfVariable|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ChangeOfVariable;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ChangeOfVariable|)))))))))) 

(DEFUN |ChangeOfVariable;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ChangeOfVariable| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 94))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ChangeOfVariable|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ChangeOfVariable| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Fraction| $) (0 . |elt|) (|Mapping| 15 15)
              (6 . |map|) (12 . |One|) (16 . |One|) (|Fraction| 7)
              (|NonNegativeInteger|) (20 . |monomial|) (26 . |elt|)
              |CHVAR;eval;UPUP2FUPUP;1| (32 . |elt|) (38 . |Zero|) (|Boolean|)
              (42 . =) (|UnivariatePolynomialCommonDenominator| 7 15 8)
              (48 . |clearDenominator|) (53 . |leadingCoefficient|)
              (58 . |retract|) (63 . |ground?|) (68 . |squareFreePart|)
              (73 . |coerce|) (78 . |inv|) (83 . |gcd|) (89 . *) (95 . =)
              (|Record| (|:| |coef| 15) (|:| |poly| 8))
              |CHVAR;mkIntegral;UPUPR;8| (101 . |denom|) (|Mapping| 22 8)
              (|List| 8) (106 . |every?|) (112 . |numer|) (117 . |degree|)
              (122 . |monomial|) |CHVAR;goodPoint;LUPUPF;9| (128 . |coerce|)
              (133 . +) (139 . -) (145 . -) (150 . *) (156 . |elt|) (162 . *)
              (|Record| (|:| |func| 39) (|:| |poly| 8) (|:| |c1| 15)
                        (|:| |c2| 15) (|:| |deg| 16))
              |CHVAR;chvar;LUPUPR;5|
              (|Record| (|:| |func| 8) (|:| |poly| 8) (|:| |c1| 15)
                        (|:| |c2| 15) (|:| |deg| 16))
              |CHVAR;chvar;2UPUPR;6|
              (|Record| (|:| |radicand| 15) (|:| |deg| 16))
              (|Union| 56 '#1="failed") |CHVAR;radPoly;UPUPU;10| (|Integer|)
              (|Fraction| 59) (168 . |coerce|) (173 . |inv|) (178 . *)
              (184 . |Zero|) (188 . |Zero|) (192 . |Zero|) (196 . ~=)
              (202 . |degree|) (207 . +) (213 . |max|) (219 . |reductum|)
              (224 . <=)
              (|Record| (|:| |exponent| 16) (|:| |coef| 15) (|:| |radicand| 7))
              |CHVAR;rootPoly;FNniR;11| (230 . |One|) (234 . |coerce|)
              (239 . -) (245 . |differentiate|) (250 . |resultant|)
              (256 . |commonDenominator|) (261 . |coerce|) (266 . -)
              (|Union| 15 '"failed") (271 . |retractIfCan|) (276 . |zero?|)
              (281 . ^) (|Factored| $) (287 . |squareFree|)
              (|Record| (|:| |exponent| 16) (|:| |coef| 7)
                        (|:| |radicand| (|List| 7)))
              (|Factored| 7) (|FactoredFunctions| 7) (292 . |nthRoot|)
              (298 . /))
           '#(|rootPoly| 304 |radPoly| 310 |mkIntegral| 315 |goodPoint| 320
              |eval| 326 |chvar| 333)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|mkIntegral|
                                 ((|Record| (|:| |coef| (|Fraction| |#2|))
                                            (|:| |poly| |#3|))
                                  |#3|))
                                T)
                              '((|radPoly|
                                 ((|Union|
                                   (|Record| (|:| |radicand| (|Fraction| |#2|))
                                             (|:| |deg|
                                                  (|NonNegativeInteger|)))
                                   #1#)
                                  |#3|))
                                T)
                              '((|rootPoly|
                                 ((|Record|
                                   (|:| |exponent| (|NonNegativeInteger|))
                                   (|:| |coef| (|Fraction| |#2|))
                                   (|:| |radicand| |#2|))
                                  (|Fraction| |#2|) (|NonNegativeInteger|)))
                                T)
                              '((|goodPoint| (|#1| (|List| |#3|) |#3|)) T)
                              '((|eval|
                                 (|#3| |#3| (|Fraction| |#2|)
                                  (|Fraction| |#2|)))
                                T)
                              '((|chvar|
                                 ((|Record| (|:| |func| |#3|) (|:| |poly| |#3|)
                                            (|:| |c1| (|Fraction| |#2|))
                                            (|:| |c2| (|Fraction| |#2|))
                                            (|:| |deg| (|NonNegativeInteger|)))
                                  |#3| |#3|))
                                T)
                              '((|chvar|
                                 ((|Record| (|:| |func| (|List| |#3|))
                                            (|:| |poly| |#3|)
                                            (|:| |c1| (|Fraction| |#2|))
                                            (|:| |c2| (|Fraction| |#2|))
                                            (|:| |deg| (|NonNegativeInteger|)))
                                  (|List| |#3|) |#3|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 93
                                            '(2 7 9 9 9 10 2 8 0 11 0 12 0 6 0
                                              13 0 7 0 14 2 8 0 15 16 17 2 8 0
                                              0 0 18 2 7 6 0 6 20 0 6 0 21 2 6
                                              22 0 0 23 1 24 8 8 25 1 8 15 0 26
                                              1 15 7 0 27 1 7 22 0 28 1 7 0 0
                                              29 1 15 0 7 30 1 15 0 0 31 2 7 0
                                              0 0 32 2 7 0 0 0 33 2 7 22 0 0 34
                                              1 15 7 0 37 2 39 22 38 0 40 1 15
                                              7 0 41 1 7 16 0 42 2 7 0 6 16 43
                                              1 7 0 6 45 2 15 0 0 0 46 2 7 0 0
                                              0 47 1 15 0 0 48 2 8 0 15 0 49 2
                                              7 9 0 9 50 2 15 0 0 0 51 1 60 0
                                              59 61 1 60 0 0 62 2 60 0 16 0 63
                                              0 60 0 64 0 7 0 65 0 8 0 66 2 8
                                              22 0 0 67 1 8 16 0 68 2 60 0 0 0
                                              69 2 60 0 0 0 70 1 8 0 0 71 2 60
                                              22 0 0 72 0 15 0 75 1 8 0 15 76 2
                                              8 0 0 0 77 1 8 0 0 78 2 8 15 0 0
                                              79 1 24 7 8 80 1 6 0 59 81 1 6 0
                                              0 82 1 8 83 0 84 1 15 22 0 85 2 7
                                              0 0 16 86 1 7 87 0 88 2 91 89 90
                                              16 92 2 15 0 7 7 93 2 0 73 15 16
                                              74 1 0 57 8 58 1 0 35 8 36 2 0 6
                                              39 8 44 3 0 8 8 15 15 19 2 0 52
                                              39 8 53 2 0 54 8 8 55)))))
           '|lookupComplete|)) 
