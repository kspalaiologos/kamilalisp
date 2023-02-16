
(SDEFUN |INFSP;numeric| ((|r| (K)) ($ (F)))
        (SPROG ((|gr| (|Complex| (|Integer|))))
               (SEQ
                (COND
                 ((|domainEqual| (QREFELT $ 6) (|Integer|))
                  (COND
                   ((|domainEqual| (QREFELT $ 7) (|Float|))
                    (SPADCALL |r| (QREFELT $ 11)))
                   ((|domainEqual| (QREFELT $ 7) (|Fraction| (|Integer|)))
                    (SPADCALL |r| (QREFELT $ 13)))
                   ((|domainEqual| (QREFELT $ 7) (|Complex| (|Float|)))
                    (SPADCALL |r| (QREFELT $ 15)))
                   ((|domainEqual| (QREFELT $ 7)
                                   (|Complex| (|Fraction| (|Integer|))))
                    (SPADCALL |r| (QREFELT $ 17)))))
                 ((|domainEqual| (QREFELT $ 6) (|Complex| (|Integer|)))
                  (SEQ (LETT |gr| |r|)
                       (EXIT
                        (COND
                         ((|domainEqual| (QREFELT $ 7)
                                         (|Complex| (|Fraction| (|Integer|))))
                          (SPADCALL
                           (SPADCALL (SPADCALL |gr| (QREFELT $ 19))
                                     (QREFELT $ 13))
                           (SPADCALL (SPADCALL |gr| (QREFELT $ 20))
                                     (QREFELT $ 13))
                           (QREFELT $ 21)))
                         ((|domainEqual| (QREFELT $ 7) (|Complex| (|Float|)))
                          (SPADCALL |gr| (QREFELT $ 22)))))))
                 ('T (|error| "case not handled")))))) 

(SDEFUN |INFSP;makeEq;LLL;2|
        ((|nres| (|List| F)) (|lv| (|List| (|Symbol|)))
         ($ (|List| (|Equation| (|Polynomial| F)))))
        (SPROG
         ((#1=#:G725 NIL) (|x| NIL) (#2=#:G726 NIL) (|r| NIL) (#3=#:G724 NIL))
         (SEQ
          (PROGN
           (LETT #3# NIL)
           (SEQ (LETT |r| NIL) (LETT #2# |nres|) (LETT |x| NIL) (LETT #1# |lv|)
                G190
                (COND
                 ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL) (ATOM #2#)
                      (PROGN (LETT |r| (CAR #2#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (LETT #3#
                        (CONS
                         (SPADCALL (SPADCALL |x| (QREFELT $ 25))
                                   (SPADCALL |r| (QREFELT $ 26))
                                   (QREFELT $ 28))
                         #3#))))
                (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                G191 (EXIT (NREVERSE #3#))))))) 

(SDEFUN |INFSP;evaluate|
        ((|pol| (|Polynomial| K)) (|xvar| (|Symbol|)) (|zvar| (|Symbol|))
         (|z| (F)) ($ (F)))
        (SPROG
         ((|upol| (|SparseUnivariatePolynomial| (|Polynomial| F)))
          (|rpp| (|Polynomial| F)))
         (SEQ
          (LETT |rpp|
                (SPADCALL (CONS (|function| |INFSP;numeric|) $) |pol|
                          (QREFELT $ 36)))
          (LETT |rpp| (SPADCALL |rpp| |zvar| |z| (QREFELT $ 37)))
          (LETT |upol| (SPADCALL |rpp| |xvar| (QREFELT $ 39)))
          (EXIT
           (SPADCALL
            (SPADCALL
             (SPADCALL (SPADCALL |upol| 0 (QREFELT $ 44)) (QREFELT $ 45))
             (QREFELT $ 46))
            (SPADCALL (SPADCALL |upol| (QREFELT $ 47)) (QREFELT $ 46))
            (QREFELT $ 48)))))) 

(SDEFUN |INFSP;myConvert| ((|eps| (|Par|)) ($ (|Fraction| (|Integer|))))
        (COND ((|domainEqual| (QREFELT $ 8) (|Fraction| (|Integer|))) |eps|)
              ((|domainEqual| (QREFELT $ 8) (|Float|))
               (SPADCALL |eps| (QREFELT $ 49))))) 

(SDEFUN |INFSP;innerSolve1;PParL;5|
        ((|pol| (|Polynomial| K)) (|eps| (|Par|)) ($ (|List| F)))
        (SPADCALL (SPADCALL |pol| (QREFELT $ 51)) |eps| (QREFELT $ 52))) 

(SDEFUN |INFSP;innerSolve1;SupParL;6|
        ((|upol| (|SparseUnivariatePolynomial| K)) (|eps| (|Par|))
         ($ (|List| F)))
        (SPROG
         ((#1=#:G747 NIL) (|x| NIL) (#2=#:G746 NIL)
          (|z|
           (|List|
            (|Record| (|:| |left| (|Fraction| (|Integer|)))
                      (|:| |right| (|Fraction| (|Integer|))))))
          (#3=#:G745 NIL) (#4=#:G744 NIL))
         (SEQ
          (COND
           ((|domainEqual| (QREFELT $ 6) (|Complex| (|Integer|)))
            (COND
             ((OR (|domainEqual| (QREFELT $ 8) (|Fraction| (|Integer|)))
                  (|domainEqual| (QREFELT $ 8) (|Float|)))
              (EXIT (SPADCALL |upol| |eps| (QREFELT $ 56)))))))
          (EXIT
           (COND
            ((|domainEqual| (QREFELT $ 6) (|Integer|))
             (COND
              ((|domainEqual| (QREFELT $ 7) (|Float|))
               (SEQ
                (LETT |z|
                      (SPADCALL |upol| (|INFSP;myConvert| |eps| $)
                                (QREFELT $ 61)))
                (EXIT
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |x| NIL) (LETT #3# |z|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (SPADCALL
                                 (SPADCALL (SPADCALL 1 2 (QREFELT $ 63))
                                           (SPADCALL (QCAR |x|) (QCDR |x|)
                                                     (QREFELT $ 64))
                                           (QREFELT $ 65))
                                 (QREFELT $ 66))
                                #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#)))))))
              ((|domainEqual| (QREFELT $ 7) (|Fraction| (|Integer|)))
               (SEQ
                (LETT |z|
                      (SPADCALL |upol| (|INFSP;myConvert| |eps| $)
                                (QREFELT $ 61)))
                (EXIT
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |x| NIL) (LETT #1# |z|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 63))
                                          (SPADCALL (QCAR |x|) (QCDR |x|)
                                                    (QREFELT $ 67))
                                          (QREFELT $ 68))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))
              (#5='T (|error| "improper arguments to INFSP"))))
            (#5# (|error| "improper arguments to INFSP"))))))) 

(SDEFUN |INFSP;K_to_CI| ((|x| (K)) ($ (|Complex| (|Interval| (|Float|)))))
        (COND
         ((|domainEqual| (QREFELT $ 6) (|Integer|))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 70))
                    (|spadConstant| $ 71) (QREFELT $ 73)))
         ((|domainEqual| (QREFELT $ 6) (|Complex| (|Integer|)))
          (SPADCALL
           (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 13))
                     (QREFELT $ 70))
           (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 13))
                     (QREFELT $ 70))
           (QREFELT $ 73)))
         ('T (|error| "improper arguments to INFSP")))) 

(SDEFUN |INFSP;F_to_CI| ((|x| (F)) ($ (|Complex| (|Interval| (|Float|)))))
        (COND
         ((|domainEqual| (QREFELT $ 7) (|Float|))
          (SPADCALL (SPADCALL |x| (QREFELT $ 74)) (|spadConstant| $ 71)
                    (QREFELT $ 73)))
         ((|domainEqual| (QREFELT $ 7) (|Fraction| (|Integer|)))
          (SPADCALL (SPADCALL |x| (QREFELT $ 70)) (|spadConstant| $ 71)
                    (QREFELT $ 73)))
         ((|domainEqual| (QREFELT $ 7) (|Complex| (|Float|)))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 75)) (QREFELT $ 74))
                    (SPADCALL (SPADCALL |x| (QREFELT $ 76)) (QREFELT $ 74))
                    (QREFELT $ 73)))
         ((|domainEqual| (QREFELT $ 7) (|Complex| (|Fraction| (|Integer|))))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 77)) (QREFELT $ 70))
                    (SPADCALL (SPADCALL |x| (QREFELT $ 78)) (QREFELT $ 70))
                    (QREFELT $ 73)))
         ('T (|error| "improper arguments to INFSP")))) 

(SDEFUN |INFSP;F_to_CI1|
        ((|x| (F)) (|eps| (|Float|)) ($ (|Complex| (|Interval| (|Float|)))))
        (SPROG
         ((|fuzz| (|Complex| (|Interval| (|Float|))))
          (|fuzz1| (|Interval| (|Float|))))
         (SEQ
          (LETT |fuzz1|
                (SPADCALL (SPADCALL |eps| (QREFELT $ 79)) |eps|
                          (QREFELT $ 80)))
          (LETT |fuzz|
                (COND
                 ((OR (|domainEqual| (QREFELT $ 7) (|Float|))
                      (|domainEqual| (QREFELT $ 7) (|Fraction| (|Integer|))))
                  (SPADCALL |fuzz1| (|spadConstant| $ 71) (QREFELT $ 73)))
                 ((OR (|domainEqual| (QREFELT $ 7) (|Complex| (|Float|)))
                      (|domainEqual| (QREFELT $ 7)
                                     (|Complex| (|Fraction| (|Integer|)))))
                  (SPADCALL |fuzz1| |fuzz1| (QREFELT $ 73)))
                 ('T (|error| "improper arguments to INFSP"))))
          (EXIT (SPADCALL (|INFSP;F_to_CI| |x| $) |fuzz| (QREFELT $ 81)))))) 

(SDEFUN |INFSP;iF_to_Float| ((|x| (|Interval| (|Float|))) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 82)) (SPADCALL |x| (QREFELT $ 83))
                   (QREFELT $ 84))
         2 (QREFELT $ 85))) 

(SDEFUN |INFSP;iF_to_RN|
        ((|x| (|Interval| (|Float|))) ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|bx| (|PositiveInteger|)) (|ex| (|Integer|)) (|mx| (|Integer|))
          (|fx| (|Float|)))
         (SEQ (LETT |fx| (|INFSP;iF_to_Float| |x| $))
              (LETT |mx| (SPADCALL |fx| (QREFELT $ 86)))
              (LETT |ex| (SPADCALL |fx| (QREFELT $ 87)))
              (LETT |bx| (SPADCALL (QREFELT $ 89)))
              (EXIT
               (SPADCALL |mx|
                         (SPADCALL (SPADCALL |bx| (QREFELT $ 13)) |ex|
                                   (QREFELT $ 90))
                         (QREFELT $ 91)))))) 

(SDEFUN |INFSP;CI_to_F| ((|x| (|Complex| (|Interval| (|Float|)))) ($ (F)))
        (SPROG ((|ix| (|Interval| (|Float|))) (|rx| (|Interval| (|Float|))))
               (SEQ (LETT |rx| (SPADCALL |x| (QREFELT $ 92)))
                    (LETT |ix| (SPADCALL |x| (QREFELT $ 93)))
                    (EXIT
                     (COND
                      ((|domainEqual| (QREFELT $ 7) (|Float|))
                       (|INFSP;iF_to_Float| |rx| $))
                      ((|domainEqual| (QREFELT $ 7) (|Complex| (|Float|)))
                       (SPADCALL (|INFSP;iF_to_Float| |rx| $)
                                 (|INFSP;iF_to_Float| |ix| $) (QREFELT $ 94)))
                      ((|domainEqual| (QREFELT $ 7) (|Fraction| (|Integer|)))
                       (|INFSP;iF_to_RN| |rx| $))
                      ((|domainEqual| (QREFELT $ 7)
                                      (|Complex| (|Fraction| (|Integer|))))
                       (SPADCALL (|INFSP;iF_to_RN| |rx| $)
                                 (|INFSP;iF_to_RN| |ix| $) (QREFELT $ 21)))
                      ('T (|error| "improper arguments to INFSP"))))))) 

(SDEFUN |INFSP;ieval0|
        ((|pol| (|Polynomial| K)) (|xvar| (|Symbol|)) (|zvar| (|Symbol|))
         (|z| (|Complex| (|Interval| (|Float|))))
         ($ (|Union| (|Complex| (|Interval| (|Float|))) "failed")))
        (SPROG
         ((|iden| (|Union| (|Complex| (|Interval| (|Float|))) "failed"))
          (|upol|
           (|SparseUnivariatePolynomial|
            (|Polynomial| (|Complex| (|Interval| (|Float|))))))
          (|rpp| (|Polynomial| (|Complex| (|Interval| (|Float|))))))
         (SEQ
          (LETT |rpp|
                (SPADCALL (CONS (|function| |INFSP;K_to_CI|) $) |pol|
                          (QREFELT $ 98)))
          (LETT |rpp| (SPADCALL |rpp| |zvar| |z| (QREFELT $ 99)))
          (LETT |upol| (SPADCALL |rpp| |xvar| (QREFELT $ 100)))
          (LETT |iden|
                (SPADCALL
                 (SPADCALL (SPADCALL |upol| (QREFELT $ 102)) (QREFELT $ 103))
                 (QREFELT $ 105)))
          (EXIT
           (COND ((QEQCAR |iden| 1) (CONS 1 "failed"))
                 ('T
                  (CONS 0
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |upol| 0 (QREFELT $ 106))
                                    (QREFELT $ 107))
                          (QREFELT $ 103))
                         (QCDR |iden|) (QREFELT $ 108))))))))) 

(SDEFUN |INFSP;ieval|
        ((|pol| (|Polynomial| K)) (|xvar| (|Symbol|)) (|zvar| (|Symbol|))
         (|z| (F)) (|eps| (|Float|))
         ($ (|Union| (|Complex| (|Interval| (|Float|))) "failed")))
        (SPROG ((|nz| (|Complex| (|Interval| (|Float|)))))
               (SEQ (LETT |nz| (|INFSP;F_to_CI1| |z| |eps| $))
                    (EXIT (|INFSP;ieval0| |pol| |xvar| |zvar| |nz| $))))) 

(SDEFUN |INFSP;findGenZeros|
        ((|lp| (|List| (|Polynomial| K))) (|rlvar| (|List| (|Symbol|)))
         (|eps| (|Par|)) ($ (|List| (|List| F))))
        (SPROG
         ((|ebits| (|PositiveInteger|)) (|etol| (|Integer|)) (#1=#:G786 NIL)
          (|sol| (|List| (|List| F))) (|sol1| (|List| F)) (#2=#:G785 NIL)
          (|ok| (|Boolean|)) (|ppi| (|Complex| (|Interval| (|Float|))))
          (|pp| (|Union| (|Complex| (|Interval| (|Float|))) "failed"))
          (#3=#:G788 NIL) (|pol| NIL) (#4=#:G789 NIL) (|xvar| NIL)
          (#5=#:G787 NIL) (|z| NIL) (|lz| (|List| F)) (|nfeps| (|Float|))
          (|neps| (|Par|)) (|obits| (|PositiveInteger|)) (|feps| (|Float|))
          (|rlp| (|List| (|Polynomial| K))) (|zvar| (|Symbol|))
          (|f| (|Polynomial| K)))
         (SEQ
          (EXIT
           (SEQ (LETT |rlp| (REVERSE |lp|)) (LETT |f| (|SPADfirst| |rlp|))
                (LETT |zvar| (|SPADfirst| |rlvar|)) (LETT |rlp| (CDR |rlp|))
                (LETT |etol| 10000)
                (LETT |feps|
                      (COND ((|domainEqual| (QREFELT $ 8) (|Float|)) |eps|)
                            ((|domainEqual| (QREFELT $ 8)
                                            (|Fraction| (|Integer|)))
                             (SPADCALL |eps| (QREFELT $ 109)))))
                (LETT |neps|
                      (SPADCALL (SPADCALL 1 4 (QREFELT $ 63)) |eps|
                                (QREFELT $ 112)))
                (LETT |nfeps|
                      (LETT |feps|
                            (SPADCALL (SPADCALL 1 4 (QREFELT $ 63)) |feps|
                                      (QREFELT $ 113))))
                (LETT |obits| (SPADCALL (QREFELT $ 114))) (LETT |ebits| 100)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (SPADCALL (+ |obits| |ebits|) (QREFELT $ 115))
                           (LETT |neps|
                                 (SPADCALL (SPADCALL 1 |etol| (QREFELT $ 63))
                                           |neps| (QREFELT $ 112)))
                           (LETT |nfeps|
                                 (SPADCALL (SPADCALL 1 |etol| (QREFELT $ 63))
                                           |nfeps| (QREFELT $ 113)))
                           (LETT |lz| (SPADCALL |f| |neps| (QREFELT $ 53)))
                           (LETT |ok| 'T) (LETT |sol| NIL)
                           (SEQ (LETT |z| NIL) (LETT #5# |lz|) G190
                                (COND
                                 ((OR (ATOM #5#)
                                      (PROGN (LETT |z| (CAR #5#)) NIL)
                                      (NULL |ok|))
                                  (GO G191)))
                                (SEQ
                                 (LETT |sol1|
                                       (LIST
                                        (|INFSP;CI_to_F|
                                         (|INFSP;F_to_CI1| |z| |feps| $) $)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |xvar| NIL)
                                        (LETT #4# (CDR |rlvar|))
                                        (LETT |pol| NIL) (LETT #3# |rlp|) G190
                                        (COND
                                         ((OR (ATOM #3#)
                                              (PROGN
                                               (LETT |pol| (CAR #3#))
                                               NIL)
                                              (ATOM #4#)
                                              (PROGN
                                               (LETT |xvar| (CAR #4#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |pp|
                                               (|INFSP;ieval| |pol| |xvar|
                                                |zvar| |z| |nfeps| $))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |pp| 1)
                                            (SEQ (LETT |ok| NIL)
                                                 (EXIT
                                                  (PROGN
                                                   (LETT #2# |$NoValue|)
                                                   (GO #6=#:G776)))))
                                           ('T
                                            (SEQ (LETT |ppi| (QCDR |pp|))
                                                 (COND
                                                  ((SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |ppi|
                                                               (QREFELT $ 92))
                                                     (QREFELT $ 116))
                                                    |feps| (QREFELT $ 118))
                                                   (EXIT
                                                    (SEQ (LETT |ok| NIL)
                                                         (EXIT
                                                          (PROGN
                                                           (LETT #2#
                                                                 |$NoValue|)
                                                           (GO #6#))))))
                                                  ((SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |ppi|
                                                               (QREFELT $ 93))
                                                     (QREFELT $ 116))
                                                    |feps| (QREFELT $ 118))
                                                   (EXIT
                                                    (SEQ (LETT |ok| NIL)
                                                         (EXIT
                                                          (PROGN
                                                           (LETT #2# 1)
                                                           (GO #6#)))))))
                                                 (EXIT
                                                  (LETT |sol1|
                                                        (CONS
                                                         (|INFSP;CI_to_F| |ppi|
                                                          $)
                                                         |sol1|))))))))
                                        (LETT #3#
                                              (PROG1 (CDR #3#)
                                                (LETT #4# (CDR #4#))))
                                        (GO G190) G191 (EXIT NIL)))
                                  #6# (EXIT #2#))
                                 (EXIT (LETT |sol| (CONS |sol1| |sol|))))
                                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND
                             (|ok|
                              (SEQ (SPADCALL |obits| (QREFELT $ 115))
                                   (EXIT
                                    (PROGN
                                     (LETT #1# (REVERSE |sol|))
                                     (GO #7=#:G784)))))
                             ('T
                              (SEQ (LETT |etol| (EXPT |etol| 2))
                                   (EXIT (LETT |ebits| (* 2 |ebits|))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #7# (EXIT #1#)))) 

(SDEFUN |INFSP;oldCoord|
        ((|numres| (|List| F)) (|lval| (|List| (|Integer|))) ($ (|List| F)))
        (SPROG
         ((#1=#:G791 NIL) (#2=#:G790 (F)) (#3=#:G792 (F)) (#4=#:G795 NIL)
          (|n| NIL) (#5=#:G796 NIL) (|nr| NIL) (|rnumres| (|List| F)))
         (SEQ (LETT |rnumres| (REVERSE |numres|))
              (SPADCALL |rnumres| '|first|
                        (SPADCALL (|SPADfirst| |rnumres|)
                                  (PROGN
                                   (LETT #1# NIL)
                                   (SEQ (LETT |nr| NIL)
                                        (LETT #5# (CDR |rnumres|))
                                        (LETT |n| NIL) (LETT #4# |lval|) G190
                                        (COND
                                         ((OR (ATOM #4#)
                                              (PROGN (LETT |n| (CAR #4#)) NIL)
                                              (ATOM #5#)
                                              (PROGN
                                               (LETT |nr| (CAR #5#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #3#
                                                 (SPADCALL |n| |nr|
                                                           (QREFELT $ 119)))
                                           (COND
                                            (#1#
                                             (LETT #2#
                                                   (SPADCALL #2# #3#
                                                             (QREFELT $ 67))))
                                            ('T
                                             (PROGN
                                              (LETT #2# #3#)
                                              (LETT #1# 'T)))))))
                                        (LETT #4#
                                              (PROG1 (CDR #4#)
                                                (LETT #5# (CDR #5#))))
                                        (GO G190) G191 (EXIT NIL))
                                   (COND (#1# #2#) ('T (|spadConstant| $ 41))))
                                  (QREFELT $ 67))
                        (QREFELT $ 121))
              (EXIT (REVERSE |rnumres|))))) 

(SDEFUN |INFSP;innerSolve2|
        ((|lp| (|List| (|Polynomial| K))) (|lv| (|List| (|Symbol|)))
         (|eps| (|Par|)) ($ (|List| (|List| F))))
        (SPROG
         ((|p1| (|Polynomial| K)) (|p0| (|Polynomial| K))
          (|vec|
           (|PrimitiveArray| (|SparseUnivariatePolynomial| (|Polynomial| K))))
          (|up2| #1=(|SparseUnivariatePolynomial| (|Polynomial| K)))
          (|up1| #1#) (|mainvar| (|Symbol|)))
         (SEQ (LETT |mainvar| (|SPADfirst| |lv|))
              (LETT |up1|
                    (SPADCALL (SPADCALL |lp| 1 (QREFELT $ 123)) |mainvar|
                              (QREFELT $ 124)))
              (LETT |up2|
                    (SPADCALL (SPADCALL |lp| 2 (QREFELT $ 123)) |mainvar|
                              (QREFELT $ 124)))
              (LETT |vec| (SPADCALL |up1| |up2| (QREFELT $ 128)))
              (LETT |p0|
                    (SPADCALL
                     (SPADCALL (QAREF1 |vec| 0) |mainvar| (QREFELT $ 129))
                     (QREFELT $ 130)))
              (LETT |p1|
                    (SPADCALL
                     (SPADCALL (QAREF1 |vec| 1) |mainvar| (QREFELT $ 129))
                     |mainvar| (QREFELT $ 131)))
              (COND
               ((OR (SPADCALL |p1| (QREFELT $ 132))
                    (SPADCALL
                     (SPADCALL |p0|
                               (SPADCALL
                                (SPADCALL |p1| |mainvar| (QREFELT $ 124))
                                (QREFELT $ 136))
                               (QREFELT $ 137))
                     (|spadConstant| $ 138) (QREFELT $ 139)))
                (EXIT
                 (SPADCALL (CONS (|spadConstant| $ 133) |lp|) NIL |lv| |eps|
                           (QREFELT $ 135)))))
              (EXIT
               (|INFSP;findGenZeros| (LIST |p1| |p0|) (REVERSE |lv|) |eps|
                $))))) 

(SDEFUN |INFSP;innerSolve;2LLParL;18|
        ((|lp| (|List| (|Polynomial| K))) (|ld| (|List| (|Polynomial| K)))
         (|lv| (|List| (|Symbol|))) (|eps| (|Par|)) ($ (|List| (|List| F))))
        (SPROG
         ((|result| (|List| (|List| F))) (#1=#:G986 NIL) (|r| NIL)
          (#2=#:G985 NIL) (|lris| #3=(|List| (|List| F)))
          (|lgen1| (|List| (|Polynomial| K))) (#4=#:G984 NIL) (|pf| NIL)
          (#5=#:G983 NIL) (|neps| (|Par|)) (|lnorm| (|Integer|))
          (|laval| (|List| (|Integer|))) (#6=#:G982 NIL) (|i| NIL)
          (#7=#:G981 NIL) (|lval| #8=(|List| (|Integer|)))
          (|lgen| #9=(|List| (|DistributedMultivariatePolynomial| |lv| K)))
          (|genRecord| (|Record| (|:| |dpolys| #9#) (|:| |coords| #8#)))
          (#10=#:G980 NIL) (|gres| NIL)
          (|partRes|
           (|List| (|List| (|DistributedMultivariatePolynomial| |lv| K))))
          (#11=#:G979 NIL) (#12=#:G929 NIL) (#13=#:G928 #3#) (#14=#:G930 #3#)
          (#15=#:G978 NIL) (|res| NIL)
          (|listG| (|List| (|List| (|Polynomial| K)))) (#16=#:G977 NIL)
          (#17=#:G976 NIL) (#18=#:G975 NIL) (|pr| NIL) (#19=#:G974 NIL)
          (#20=#:G961 NIL) (|listGen| (|List| (|List| |dmp|))) (#21=#:G830 NIL)
          (#22=#:G829 #23=(|Boolean|)) (#24=#:G831 #23#) (#25=#:G920 NIL)
          (#26=#:G919 #27=(|NonNegativeInteger|)) (#28=#:G921 #27#)
          (#29=#:G973 NIL) (#30=#:G689 NIL) (#31=#:G972 NIL) (|f| NIL)
          (|res1| (|List| (|DistributedMultivariatePolynomial| |lv| K)))
          (#32=#:G971 NIL) (|rrlvv| (|List| OV)) (|rlv| (|List| (|Symbol|)))
          (#33=#:G823 NIL) (#34=#:G822 #35=(|Boolean|)) (#36=#:G824 #35#)
          (#37=#:G970 NIL) (|fq| NIL) (#38=#:G969 NIL) (#39=#:G968 NIL)
          (|gb|
           (CATEGORY |package|
            (SIGNATURE |credPol| (|dmp| |dmp| (|List| |dmp|)))
            (SIGNATURE |redPol| (|dmp| |dmp| (|List| |dmp|)))
            (SIGNATURE |gbasis|
             ((|List| |dmp|) (|List| |dmp|) (|Integer|) (|Integer|)))
            (SIGNATURE |gbasisExtend|
             ((|List| |dmp|) (|List| |dmp|) (|List| |dmp|) (|Integer|)
              (|Integer|)))
            (SIGNATURE |critT|
             ((|Boolean|)
              (|Record|
               (|:| |lcmfij|
                    #40=(|DirectProduct| (|call| LENGTH |lv|)
                                         (|NonNegativeInteger|)))
               (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |dmp|)
               (|:| |polj| |dmp|))))
            (SIGNATURE |critM| ((|Boolean|) #40# #40#))
            (SIGNATURE |critB| ((|Boolean|) #40# #40# #40# #40#))
            (SIGNATURE |critBonD|
             ((|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              |dmp|
              (|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |critMTonD1|
             ((|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              (|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |critMonD1|
             ((|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              #40#
              (|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |redPo|
             ((|Record| (|:| |poly| |dmp|) (|:| |mult| K)) |dmp|
              (|List| |dmp|)))
            (SIGNATURE |hMonic| (|dmp| |dmp|))
            (SIGNATURE |updatF|
             ((|List|
               (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |pol| |dmp|)))
              |dmp| (|NonNegativeInteger|)
              (|List|
               (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |pol| |dmp|)))))
            (SIGNATURE |sPol|
             (|dmp|
              (|Record| (|:| |lcmfij| #40#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))))
            (SIGNATURE |updatD|
             ((|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              (|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))
              (|List|
               (|Record| (|:| |lcmfij| #40#)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |dmp|) (|:| |polj| |dmp|)))))
            (SIGNATURE |minGbasis| ((|List| |dmp|) (|List| |dmp|)))
            (SIGNATURE |lepol| ((|Integer|) |dmp|))
            (SIGNATURE |prinshINFO| ((|Void|) |dmp|))
            (SIGNATURE |prindINFO|
             ((|Integer|)
              (|Record| (|:| |lcmfij| #40#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              |dmp| |dmp| (|Integer|) (|Integer|) (|Integer|)))
            (SIGNATURE |fprindINFO|
             ((|Integer|)
              (|Record| (|:| |lcmfij| #40#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              |dmp| |dmp| (|Integer|) (|Integer|) (|Integer|) (|Integer|)))
            (SIGNATURE |prinpolINFO| ((|Void|) (|List| |dmp|)))
            (SIGNATURE |prinb| ((|Void|) (|Integer|)))
            (SIGNATURE |critpOrder|
             ((|Boolean|)
              (|Record| (|:| |lcmfij| #40#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              (|Record| (|:| |lcmfij| #40#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))))
            (SIGNATURE |makeCrit|
             ((|Record| (|:| |lcmfij| #40#)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |dmp|) (|:| |polj| |dmp|))
              (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |pol| |dmp|))
              |dmp| (|NonNegativeInteger|)))
            (SIGNATURE |virtualDegree| ((|NonNegativeInteger|) |dmp|))))
          (|lq| (|List| |dmp|)) (#41=#:G967 NIL) (|q1| NIL) (#42=#:G966 NIL)
          (|dmp|
           (|Join|
            (|PolynomialCategory| K
                                  (|DirectProduct| (|#| |lv|)
                                                   (|NonNegativeInteger|))
                                  (|OrderedVariableList| |lv|))
            (CATEGORY |domain|
             (SIGNATURE |reorder| ($ $ (|List| (|Integer|)))))))
          (|lvv| (|List| OV)) (#43=#:G814 NIL) (#44=#:G965 NIL) (|vv| NIL)
          (#45=#:G964 NIL)
          (OV
           (|Join| (|OrderedFinite|) (|ConvertibleTo| (|Symbol|))
                   (|ConvertibleTo| (|InputForm|))
                   (|ConvertibleTo| (|Pattern| (|Float|)))
                   (|ConvertibleTo| (|Pattern| (|Integer|)))
                   (CATEGORY |domain|
                    (SIGNATURE |variable| ((|Union| $ "failed") (|Symbol|))))))
          (|lnp| (|List| (|DistributedMultivariatePolynomial| |lv| K)))
          (#46=#:G963 NIL) (|p| NIL) (#47=#:G962 NIL))
         (SEQ
          (LETT |lnp|
                (PROGN
                 (LETT #47# NIL)
                 (SEQ (LETT |p| NIL) (LETT #46# |lp|) G190
                      (COND
                       ((OR (ATOM #46#) (PROGN (LETT |p| (CAR #46#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #47#
                              (CONS
                               (SPADCALL |p|
                                         (|compiledLookupCheck| '|pToDmp|
                                                                (LIST
                                                                 (LIST
                                                                  '|DistributedMultivariatePolynomial|
                                                                  |lv|
                                                                  (|devaluate|
                                                                   (ELT $ 6)))
                                                                 (LIST
                                                                  '|Polynomial|
                                                                  (|devaluate|
                                                                   (ELT $ 6))))
                                                                (|PolToPol|
                                                                 |lv|
                                                                 (ELT $ 6))))
                               #47#))))
                      (LETT #46# (CDR #46#)) (GO G190) G191
                      (EXIT (NREVERSE #47#)))))
          (LETT OV (|OrderedVariableList| |lv|))
          (LETT |lvv|
                (PROGN
                 (LETT #45# NIL)
                 (SEQ (LETT |vv| NIL) (LETT #44# |lv|) G190
                      (COND
                       ((OR (ATOM #44#) (PROGN (LETT |vv| (CAR #44#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #45#
                              (CONS
                               (PROG2
                                   (LETT #43#
                                         (SPADCALL |vv|
                                                   (|compiledLookupCheck|
                                                    '|variable|
                                                    (LIST
                                                     (LIST '|Union| '$
                                                           '#48="failed")
                                                     (LIST '|Symbol|))
                                                    OV)))
                                   (QCDR #43#)
                                 (|check_union2| (QEQCAR #43# 0) OV
                                                 (|Union| OV #48#) #43#))
                               #45#))))
                      (LETT #44# (CDR #44#)) (GO G190) G191
                      (EXIT (NREVERSE #45#)))))
          (LETT |dmp| (|DistributedMultivariatePolynomial| |lv| (QREFELT $ 6)))
          (LETT |lq| NIL)
          (COND
           ((SPADCALL |ld| NIL (QREFELT $ 140))
            (LETT |lq|
                  (PROGN
                   (LETT #42# NIL)
                   (SEQ (LETT |q1| NIL) (LETT #41# |ld|) G190
                        (COND
                         ((OR (ATOM #41#) (PROGN (LETT |q1| (CAR #41#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #42#
                                (CONS
                                 (SPADCALL |q1|
                                           (|compiledLookupCheck| '|pToDmp|
                                                                  (LIST
                                                                   (LIST
                                                                    '|DistributedMultivariatePolynomial|
                                                                    |lv|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6)))
                                                                   (LIST
                                                                    '|Polynomial|
                                                                    (|devaluate|
                                                                     (ELT $
                                                                          6))))
                                                                  (|PolToPol|
                                                                   |lv|
                                                                   (ELT $ 6))))
                                 #42#))))
                        (LETT #41# (CDR #41#)) (GO G190) G191
                        (EXIT (NREVERSE #42#)))))))
          (LETT |partRes|
                (SPADCALL |lnp| |lvv|
                          (|compiledLookupCheck| '|groebSolve|
                                                 (LIST
                                                  (LIST '|List|
                                                        (LIST '|List|
                                                              (LIST
                                                               '|DistributedMultivariatePolynomial|
                                                               |lv|
                                                               (|devaluate|
                                                                (ELT $ 6)))))
                                                  (LIST '|List|
                                                        (LIST
                                                         '|DistributedMultivariatePolynomial|
                                                         |lv|
                                                         (|devaluate|
                                                          (ELT $ 6))))
                                                  (LIST '|List|
                                                        (LIST
                                                         '|OrderedVariableList|
                                                         |lv|)))
                                                 (|GroebnerSolve| |lv|
                                                                  (ELT $ 6)
                                                                  (ELT $ 6)))))
          (EXIT
           (COND
            ((SPADCALL |partRes|
                       (SPADCALL NIL
                                 (|compiledLookupCheck| '|list|
                                                        (LIST '$
                                                              (LIST '|List|
                                                                    (LIST
                                                                     '|DistributedMultivariatePolynomial|
                                                                     |lv|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           6)))))
                                                        (|List|
                                                         (|List|
                                                          (|DistributedMultivariatePolynomial|
                                                           |lv| (ELT $ 6))))))
                       (|compiledLookupCheck| '= (LIST (LIST '|Boolean|) '$ '$)
                                              (|List|
                                               (|List|
                                                (|DistributedMultivariatePolynomial|
                                                 |lv| (ELT $ 6))))))
             NIL)
            (#49='T
             (SEQ
              (COND
               ((SPADCALL |lq| NIL
                          (|compiledLookupCheck| '~=
                                                 (LIST (LIST '|Boolean|) '$ '$)
                                                 (|List| |dmp|)))
                (SEQ
                 (LETT |gb|
                       (|GroebnerInternalPackage| (QREFELT $ 6)
                                                  (|DirectProduct|
                                                   (LENGTH |lv|)
                                                   (|NonNegativeInteger|))
                                                  |dmp|))
                 (EXIT
                  (LETT |partRes|
                        (PROGN
                         (LETT #39# NIL)
                         (SEQ (LETT |pr| NIL) (LETT #38# |partRes|) G190
                              (COND
                               ((OR (ATOM #38#)
                                    (PROGN (LETT |pr| (CAR #38#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((PROGN
                                   (LETT #33# NIL)
                                   (SEQ (LETT |fq| NIL) (LETT #37# |lq|) G190
                                        (COND
                                         ((OR (ATOM #37#)
                                              (PROGN
                                               (LETT |fq| (CAR #37#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #36#
                                                 (SPADCALL
                                                  (SPADCALL |fq| |pr|
                                                            (|compiledLookupCheck|
                                                             '|redPol|
                                                             (LIST
                                                              (|devaluate|
                                                               |dmp|)
                                                              (|devaluate|
                                                               |dmp|)
                                                              (LIST '|List|
                                                                    (|devaluate|
                                                                     |dmp|)))
                                                             |gb|))
                                                  (SPADCALL
                                                   (|compiledLookupCheck|
                                                    '|Zero| (LIST '$)
                                                    (|DistributedMultivariatePolynomial|
                                                     |lv| (ELT $ 6))))
                                                  (|compiledLookupCheck| '~=
                                                                         (LIST
                                                                          (LIST
                                                                           '|Boolean|)
                                                                          '$
                                                                          '$)
                                                                         (|DistributedMultivariatePolynomial|
                                                                          |lv|
                                                                          (ELT
                                                                           $
                                                                           6)))))
                                           (COND
                                            (#33#
                                             (LETT #34#
                                                   (COND (#34# #36#)
                                                         ('T NIL))))
                                            ('T
                                             (PROGN
                                              (LETT #34# #36#)
                                              (LETT #33# 'T)))))))
                                        (LETT #37# (CDR #37#)) (GO G190) G191
                                        (EXIT NIL))
                                   (COND (#33# #34#) (#49# 'T)))
                                  (LETT #39# (CONS |pr| #39#))))))
                              (LETT #38# (CDR #38#)) (GO G190) G191
                              (EXIT (NREVERSE #39#)))))))))
              (LETT |rlv| (REVERSE |lv|)) (LETT |rrlvv| (CDR (REVERSE |lvv|)))
              (LETT |listGen| NIL)
              (SEQ (LETT |res| NIL) (LETT #32# |partRes|) G190
                   (COND
                    ((OR (ATOM #32#) (PROGN (LETT |res| (CAR #32#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |res1| (CDR (REVERSE |res|)))
                          (EXIT
                           (COND
                            ((PROGN
                              (LETT #21# NIL)
                              (SEQ (LETT |f| NIL) (LETT #31# |res1|) G190
                                   (COND
                                    ((OR (ATOM #31#)
                                         (PROGN (LETT |f| (CAR #31#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (PROGN
                                      (LETT #24#
                                            (EQL
                                             (PROGN
                                              (LETT #25# NIL)
                                              (SEQ (LETT #30# NIL)
                                                   (LETT #29#
                                                         (SPADCALL |f| |rrlvv|
                                                                   (|compiledLookupCheck|
                                                                    '|degree|
                                                                    (LIST
                                                                     (LIST
                                                                      '|List|
                                                                      (LIST
                                                                       '|NonNegativeInteger|))
                                                                     '$
                                                                     (LIST
                                                                      '|List|
                                                                      (LIST
                                                                       '|OrderedVariableList|
                                                                       |lv|)))
                                                                    (|DistributedMultivariatePolynomial|
                                                                     |lv|
                                                                     (ELT $
                                                                          6)))))
                                                   G190
                                                   (COND
                                                    ((OR (ATOM #29#)
                                                         (PROGN
                                                          (LETT #30#
                                                                (CAR #29#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (PROGN
                                                      (LETT #28# #30#)
                                                      (COND
                                                       (#25#
                                                        (LETT #26#
                                                              (MAX #26# #28#)))
                                                       ('T
                                                        (PROGN
                                                         (LETT #26# #28#)
                                                         (LETT #25# 'T)))))))
                                                   (LETT #29# (CDR #29#))
                                                   (GO G190) G191 (EXIT NIL))
                                              (COND (#25# #26#)
                                                    ('T
                                                     (|IdentityError|
                                                      '|max|))))
                                             1))
                                      (COND
                                       (#21#
                                        (LETT #22#
                                              (COND (#22# #24#) ('T NIL))))
                                       ('T
                                        (PROGN
                                         (LETT #22# #24#)
                                         (LETT #21# 'T)))))))
                                   (LETT #31# (CDR #31#)) (GO G190) G191
                                   (EXIT NIL))
                              (COND (#21# #22#) ('T 'T)))
                             (PROGN
                              (LETT #20#
                                    (LETT |listGen| (CONS |res| |listGen|)))
                              (GO #50=#:G922)))))))
                    #50# (EXIT #20#))
                   (LETT #32# (CDR #32#)) (GO G190) G191 (EXIT NIL))
              (LETT |result| NIL)
              (COND
               ((SPADCALL |listGen| NIL
                          (|compiledLookupCheck| '~=
                                                 (LIST (LIST '|Boolean|) '$ '$)
                                                 (|List| (|List| |dmp|))))
                (SEQ
                 (LETT |listG|
                       (PROGN
                        (LETT #19# NIL)
                        (SEQ (LETT |pr| NIL) (LETT #18# |listGen|) G190
                             (COND
                              ((OR (ATOM #18#)
                                   (PROGN (LETT |pr| (CAR #18#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #19#
                                     (CONS
                                      (PROGN
                                       (LETT #17# NIL)
                                       (SEQ (LETT |pf| NIL) (LETT #16# |pr|)
                                            G190
                                            (COND
                                             ((OR (ATOM #16#)
                                                  (PROGN
                                                   (LETT |pf| (CAR #16#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #17#
                                                    (CONS
                                                     (SPADCALL |pf|
                                                               (|compiledLookupCheck|
                                                                '|dmpToP|
                                                                (LIST
                                                                 (LIST
                                                                  '|Polynomial|
                                                                  (|devaluate|
                                                                   (ELT $ 6)))
                                                                 (LIST
                                                                  '|DistributedMultivariatePolynomial|
                                                                  |lv|
                                                                  (|devaluate|
                                                                   (ELT $ 6))))
                                                                (|PolToPol|
                                                                 |lv|
                                                                 (ELT $ 6))))
                                                     #17#))))
                                            (LETT #16# (CDR #16#)) (GO G190)
                                            G191 (EXIT (NREVERSE #17#))))
                                      #19#))))
                             (LETT #18# (CDR #18#)) (GO G190) G191
                             (EXIT (NREVERSE #19#)))))
                 (LETT |result|
                       (PROGN
                        (LETT #12# NIL)
                        (SEQ (LETT |res| NIL) (LETT #15# |listG|) G190
                             (COND
                              ((OR (ATOM #15#)
                                   (PROGN (LETT |res| (CAR #15#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (PROGN
                                (LETT #14#
                                      (|INFSP;findGenZeros| |res| |rlv| |eps|
                                       $))
                                (COND
                                 (#12#
                                  (LETT #13#
                                        (SPADCALL #13# #14# (QREFELT $ 141))))
                                 ('T
                                  (PROGN (LETT #13# #14#) (LETT #12# 'T)))))))
                             (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
                        (COND (#12# #13#) (#49# NIL))))
                 (EXIT
                  (SEQ (LETT |gres| NIL) (LETT #11# |listGen|) G190
                       (COND
                        ((OR (ATOM #11#) (PROGN (LETT |gres| (CAR #11#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |partRes|
                               (SPADCALL |partRes|
                                         (SPADCALL |gres| |partRes|
                                                   (|compiledLookupCheck|
                                                    '|position|
                                                    (LIST (LIST '|Integer|)
                                                          (LIST '|List|
                                                                (LIST
                                                                 '|DistributedMultivariatePolynomial|
                                                                 |lv|
                                                                 (|devaluate|
                                                                  (ELT $ 6))))
                                                          '$)
                                                    (|List|
                                                     (|List|
                                                      (|DistributedMultivariatePolynomial|
                                                       |lv| (ELT $ 6))))))
                                         (|compiledLookupCheck| '|delete|
                                                                (LIST '$ '$
                                                                      (LIST
                                                                       '|Integer|))
                                                                (|List|
                                                                 (|List|
                                                                  (|DistributedMultivariatePolynomial|
                                                                   |lv|
                                                                   (ELT $
                                                                        6)))))))))
                       (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))))))
              (SEQ (LETT |gres| NIL) (LETT #10# |partRes|) G190
                   (COND
                    ((OR (ATOM #10#) (PROGN (LETT |gres| (CAR #10#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |genRecord|
                          (SPADCALL |gres| |lvv|
                                    (|compiledLookupCheck| '|genericPosition|
                                                           (LIST
                                                            (LIST '|Record|
                                                                  (LIST '|:|
                                                                        '|dpolys|
                                                                        (LIST
                                                                         '|List|
                                                                         (LIST
                                                                          '|DistributedMultivariatePolynomial|
                                                                          |lv|
                                                                          (|devaluate|
                                                                           (ELT
                                                                            $
                                                                            6)))))
                                                                  (LIST '|:|
                                                                        '|coords|
                                                                        (LIST
                                                                         '|List|
                                                                         (LIST
                                                                          '|Integer|))))
                                                            (LIST '|List|
                                                                  (LIST
                                                                   '|DistributedMultivariatePolynomial|
                                                                   |lv|
                                                                   (|devaluate|
                                                                    (ELT $
                                                                         6))))
                                                            (LIST '|List|
                                                                  (LIST
                                                                   '|OrderedVariableList|
                                                                   |lv|)))
                                                           (|GroebnerSolve|
                                                            |lv| (ELT $ 6)
                                                            (ELT $ 6)))))
                    (LETT |lgen| (QCAR |genRecord|))
                    (LETT |lval| (QCDR |genRecord|))
                    (LETT |laval|
                          (PROGN
                           (LETT #7# NIL)
                           (SEQ (LETT |i| NIL) (LETT #6# |lval|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |i| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ (EXIT (LETT #7# (CONS (ABS |i|) #7#))))
                                (LETT #6# (CDR #6#)) (GO G190) G191
                                (EXIT (NREVERSE #7#)))))
                    (LETT |lnorm|
                          (SPADCALL (ELT $ 143) |laval| (QREFELT $ 146)))
                    (LETT |neps|
                          (SPADCALL (SPADCALL 1 (+ 1 |lnorm|) (QREFELT $ 63))
                                    |eps| (QREFELT $ 112)))
                    (LETT |lgen1|
                          (PROGN
                           (LETT #5# NIL)
                           (SEQ (LETT |pf| NIL) (LETT #4# |lgen|) G190
                                (COND
                                 ((OR (ATOM #4#)
                                      (PROGN (LETT |pf| (CAR #4#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #5#
                                        (CONS
                                         (SPADCALL |pf|
                                                   (|compiledLookupCheck|
                                                    '|dmpToP|
                                                    (LIST
                                                     (LIST '|Polynomial|
                                                           (|devaluate|
                                                            (ELT $ 6)))
                                                     (LIST
                                                      '|DistributedMultivariatePolynomial|
                                                      |lv|
                                                      (|devaluate| (ELT $ 6))))
                                                    (|PolToPol| |lv|
                                                                (ELT $ 6))))
                                         #5#))))
                                (LETT #4# (CDR #4#)) (GO G190) G191
                                (EXIT (NREVERSE #5#)))))
                    (LETT |lris| (|INFSP;findGenZeros| |lgen1| |rlv| |neps| $))
                    (EXIT
                     (LETT |result|
                           (SPADCALL
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |r| NIL) (LETT #1# |lris|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |r| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS (|INFSP;oldCoord| |r| |lval| $)
                                                #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            |result| (QREFELT $ 141)))))
                   (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
              (EXIT |result|)))))))) 

(DECLAIM (NOTINLINE |InnerNumericFloatSolvePackage;|)) 

(DEFUN |InnerNumericFloatSolvePackage| (&REST #1=#:G987)
  (SPROG NIL
         (PROG (#2=#:G988)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerNumericFloatSolvePackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |InnerNumericFloatSolvePackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerNumericFloatSolvePackage|)))))))))) 

(DEFUN |InnerNumericFloatSolvePackage;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|InnerNumericFloatSolvePackage| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 150))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InnerNumericFloatSolvePackage|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|InnerNumericFloatSolvePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Integer|) (|Float|) (0 . |coerce|)
              (|Fraction| 9) (5 . |coerce|) (|Complex| 10) (10 . |coerce|)
              (|Complex| 12) (15 . |coerce|) (|Complex| 9) (20 . |real|)
              (25 . |imag|) (30 . |complex|) (36 . |convert|) (|Symbol|)
              (|Polynomial| 7) (41 . |coerce|) (46 . |coerce|) (|Equation| 24)
              (51 . |equation|) (|List| 27) (|List| 7) (|List| 23)
              |INFSP;makeEq;LLL;2| (|Mapping| 7 6) (|Polynomial| 6)
              (|PolynomialFunctions2| 6 7) (57 . |map|) (63 . |eval|)
              (|SparseUnivariatePolynomial| $) (70 . |univariate|)
              (76 . |Zero|) (80 . |Zero|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 24) (84 . |coefficient|) (90 . -)
              (95 . |retract|) (100 . |leadingCoefficient|) (105 . /)
              (111 . |retract|) (|SparseUnivariatePolynomial| 6)
              (116 . |univariate|) |INFSP;innerSolve1;SupParL;6|
              |INFSP;innerSolve1;PParL;5| (|List| (|Complex| 8))
              (|ComplexRootPackage| 50 8) (121 . |complexZeros|)
              (|Record| (|:| |left| 12) (|:| |right| 12)) (|List| 57)
              (|SparseUnivariatePolynomial| 9) (|RealZeroPackage| 59)
              (127 . |realZeros|) (133 . |One|) (137 . /) (143 . +) (149 . *)
              (155 . |convert|) (160 . +) (166 . *) (|Interval| 10)
              (172 . |interval|) (177 . |Zero|) (|Complex| 69)
              (181 . |complex|) (187 . |interval|) (192 . |real|)
              (197 . |imag|) (202 . |real|) (207 . |imag|) (212 . -)
              (217 . |interval|) (223 . +) (229 . |sup|) (234 . |inf|)
              (239 . +) (245 . /) (251 . |mantissa|) (256 . |exponent|)
              (|PositiveInteger|) (261 . |base|) (265 . ^) (271 . *)
              (277 . |real|) (282 . |imag|) (287 . |complex|) (|Polynomial| 72)
              (|Mapping| 72 6) (|PolynomialFunctions2| 6 72) (293 . |map|)
              (299 . |eval|) (306 . |univariate|)
              (|SparseUnivariatePolynomial| 95) (312 . |leadingCoefficient|)
              (317 . |retract|) (|Union| $ '"failed") (322 . |recip|)
              (327 . |coefficient|) (333 . -) (338 . *) (344 . |coerce|)
              (349 . |One|) (353 . |One|) (357 . *) (363 . *) (369 . |bits|)
              (373 . |bits|) (378 . |width|) (|Boolean|) (383 . >) (389 . *)
              '"first" (395 . |setelt!|) (|List| 34) (402 . |elt|)
              (408 . |univariate|) (|PrimitiveArray| 126)
              (|SparseUnivariatePolynomial| 34) (|SubResultantPackage| 34 126)
              (414 . |subresultantVector|) (420 . |multivariate|)
              (426 . |primitivePart|) (431 . |primitivePart|) (437 . |zero?|)
              (442 . |Zero|) (|List| 30) |INFSP;innerSolve;2LLParL;18|
              (446 . |leadingCoefficient|) (451 . |gcd|) (457 . |One|)
              (461 . ~=) (467 . ~=) (473 . |append|) (479 . +) (485 . +)
              (|Mapping| 9 9 9) (|List| 9) (491 . |reduce|) (497 . |One|)
              (501 . |One|) (505 . |One|))
           '#(|makeEq| 509 |innerSolve1| 515 |innerSolve| 527) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|innerSolve1|
                                 ((|List| |#2|)
                                  (|SparseUnivariatePolynomial| |#1|) |#3|))
                                T)
                              '((|innerSolve1|
                                 ((|List| |#2|) (|Polynomial| |#1|) |#3|))
                                T)
                              '((|innerSolve|
                                 ((|List| (|List| |#2|))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Symbol|)) |#3|))
                                T)
                              '((|makeEq|
                                 ((|List| (|Equation| (|Polynomial| |#2|)))
                                  (|List| |#2|) (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 149
                                            '(1 10 0 9 11 1 12 0 9 13 1 14 0 9
                                              15 1 16 0 9 17 1 18 9 0 19 1 18 9
                                              0 20 2 16 0 12 12 21 1 18 14 0 22
                                              1 24 0 23 25 1 24 0 7 26 2 27 0
                                              24 24 28 2 35 24 33 34 36 3 24 0
                                              0 23 7 37 2 24 38 0 23 39 0 6 0
                                              40 0 7 0 41 2 43 24 0 42 44 1 24
                                              0 0 45 1 24 7 0 46 1 43 24 0 47 2
                                              7 0 0 0 48 1 10 12 0 49 1 34 50 0
                                              51 2 55 54 50 8 56 2 60 58 59 12
                                              61 0 7 0 62 2 12 0 9 9 63 2 12 0
                                              0 0 64 2 12 0 0 12 65 1 12 10 0
                                              66 2 7 0 0 0 67 2 7 0 0 0 68 1 69
                                              0 12 70 0 69 0 71 2 72 0 69 69 73
                                              1 69 0 10 74 1 14 10 0 75 1 14 10
                                              0 76 1 16 12 0 77 1 16 12 0 78 1
                                              10 0 0 79 2 69 0 10 10 80 2 72 0
                                              0 0 81 1 69 10 0 82 1 69 10 0 83
                                              2 10 0 0 0 84 2 10 0 0 9 85 1 10
                                              9 0 86 1 10 9 0 87 0 10 88 89 2
                                              12 0 0 9 90 2 12 0 9 0 91 1 72 69
                                              0 92 1 72 69 0 93 2 14 0 10 10 94
                                              2 97 95 96 34 98 3 95 0 0 23 72
                                              99 2 95 38 0 23 100 1 101 95 0
                                              102 1 95 72 0 103 1 72 104 0 105
                                              2 101 95 0 42 106 1 95 0 0 107 2
                                              72 0 0 0 108 1 10 0 12 109 0 6 0
                                              110 0 8 0 111 2 8 0 12 0 112 2 10
                                              0 12 0 113 0 10 88 114 1 10 88 88
                                              115 1 69 10 0 116 2 10 117 0 0
                                              118 2 7 0 9 0 119 3 30 7 0 120 7
                                              121 2 122 34 0 9 123 2 34 38 0 23
                                              124 2 127 125 126 126 128 2 34 0
                                              38 23 129 1 34 0 0 130 2 34 0 0
                                              23 131 1 34 117 0 132 0 34 0 133
                                              1 126 34 0 136 2 34 0 0 0 137 0
                                              34 0 138 2 34 117 0 0 139 2 122
                                              117 0 0 140 2 134 0 0 0 141 2 42
                                              0 0 0 142 2 9 0 0 0 143 2 145 9
                                              144 0 146 0 12 0 147 0 72 0 148 0
                                              10 0 149 2 0 29 30 31 32 2 0 30
                                              34 8 53 2 0 30 50 8 52 4 0 134
                                              122 122 31 8 135)))))
           '|lookupComplete|)) 
