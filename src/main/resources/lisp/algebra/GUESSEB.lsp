
(SDEFUN |GUESSEB;ord1|
        ((|x| (|List| (|Integer|))) (|i| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((#1=#:G761 NIL) (|k| NIL) (#2=#:G760 NIL) (#3=#:G759 NIL) (|j| NIL)
          (#4=#:G758 NIL) (#5=#:G757 NIL) (#6=#:G756 NIL) (|n| (|Integer|)))
         (SEQ (LETT |n| (- (- (LENGTH |x|) 3) |i|))
              (EXIT
               (+
                (* (SPADCALL |x| (+ |n| 1) (QREFELT $ 15))
                   (SPADCALL (ELT $ 16)
                             (PROGN
                              (LETT #6# NIL)
                              (SEQ (LETT |j| 1) (LETT #5# |n|) G190
                                   (COND ((|greater_SI| |j| #5#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #6#
                                           (CONS
                                            (SPADCALL |x| |j| (QREFELT $ 15))
                                            #6#))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT (NREVERSE #6#))))
                             0 (QREFELT $ 18)))
                (* 2
                   (SPADCALL (ELT $ 16)
                             (PROGN
                              (LETT #4# NIL)
                              (SEQ (LETT |j| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #4#
                                           (CONS
                                            (SPADCALL (ELT $ 16)
                                                      (PROGN
                                                       (LETT #2# NIL)
                                                       (SEQ (LETT |k| 1)
                                                            (LETT #1#
                                                                  (- |j| 1))
                                                            G190
                                                            (COND
                                                             ((|greater_SI| |k|
                                                                            #1#)
                                                              (GO G191)))
                                                            (SEQ
                                                             (EXIT
                                                              (LETT #2#
                                                                    (CONS
                                                                     (*
                                                                      (SPADCALL
                                                                       |x| |k|
                                                                       (QREFELT
                                                                        $ 15))
                                                                      (SPADCALL
                                                                       |x| |j|
                                                                       (QREFELT
                                                                        $ 15)))
                                                                     #2#))))
                                                            (LETT |k|
                                                                  (|inc_SI|
                                                                   |k|))
                                                            (GO G190) G191
                                                            (EXIT
                                                             (NREVERSE #2#))))
                                                      0 (QREFELT $ 18))
                                            #4#))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT (NREVERSE #4#))))
                             0 (QREFELT $ 18)))))))) 

(SDEFUN |GUESSEB;ord2|
        ((|x| (|List| (|Integer|))) (|i| (|Integer|)) ($ (|Integer|)))
        (SPROG ((#1=#:G770 NIL) (|j| NIL) (#2=#:G769 NIL) (|n| (|Integer|)))
               (SEQ
                (COND
                 ((ZEROP |i|)
                  (SEQ (LETT |n| (- (- (LENGTH |x|) 3) |i|))
                       (EXIT
                        (+ (|GUESSEB;ord1| |x| |i| $)
                           (*
                            (SPADCALL (ELT $ 16)
                                      (PROGN
                                       (LETT #2# NIL)
                                       (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                                            (COND
                                             ((|greater_SI| |j| #1#)
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #2#
                                                    (CONS
                                                     (SPADCALL |x| |j|
                                                               (QREFELT $ 15))
                                                     #2#))))
                                            (LETT |j| (|inc_SI| |j|)) (GO G190)
                                            G191 (EXIT (NREVERSE #2#))))
                                      0 (QREFELT $ 18))
                            (- (SPADCALL |x| (+ |n| 2) (QREFELT $ 15))
                               (SPADCALL |x| (+ |n| 1) (QREFELT $ 15))))))))
                 ('T (|GUESSEB;ord1| |x| |i| $)))))) 

(SDEFUN |GUESSEB;deg1|
        ((|x| (|List| (|Integer|))) (|i| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((#1=#:G790 NIL) (|k| NIL) (#2=#:G789 NIL) (#3=#:G788 NIL) (|j| NIL)
          (#4=#:G787 NIL) (#5=#:G786 NIL) (#6=#:G785 NIL) (|m| (|Integer|)))
         (SEQ (LETT |m| (- (LENGTH |x|) 3))
              (EXIT
               (+
                (+
                 (*
                  (+
                   (+ (SPADCALL |x| (+ |m| 3) (QREFELT $ 15))
                      (SPADCALL |x| (+ |m| 1) (QREFELT $ 15)))
                   (SPADCALL |x| (+ 1 |i|) (QREFELT $ 15)))
                  (SPADCALL (ELT $ 16)
                            (PROGN
                             (LETT #6# NIL)
                             (SEQ (LETT |j| (+ 2 |i|)) (LETT #5# |m|) G190
                                  (COND ((> |j| #5#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #6#
                                          (CONS
                                           (SPADCALL |x| |j| (QREFELT $ 15))
                                           #6#))))
                                  (LETT |j| (+ |j| 1)) (GO G190) G191
                                  (EXIT (NREVERSE #6#))))
                            0 (QREFELT $ 18)))
                 (* (SPADCALL |x| (+ |m| 3) (QREFELT $ 15))
                    (SPADCALL |x| (+ |m| 1) (QREFELT $ 15))))
                (* 2
                   (SPADCALL (ELT $ 16)
                             (PROGN
                              (LETT #4# NIL)
                              (SEQ (LETT |j| (+ 2 |i|)) (LETT #3# |m|) G190
                                   (COND ((> |j| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #4#
                                           (CONS
                                            (SPADCALL (ELT $ 16)
                                                      (PROGN
                                                       (LETT #2# NIL)
                                                       (SEQ
                                                        (LETT |k| (+ 2 |i|))
                                                        (LETT #1# (- |j| 1))
                                                        G190
                                                        (COND
                                                         ((> |k| #1#)
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (LETT #2#
                                                                (CONS
                                                                 (*
                                                                  (SPADCALL |x|
                                                                            |k|
                                                                            (QREFELT
                                                                             $
                                                                             15))
                                                                  (SPADCALL |x|
                                                                            |j|
                                                                            (QREFELT
                                                                             $
                                                                             15)))
                                                                 #2#))))
                                                        (LETT |k| (+ |k| 1))
                                                        (GO G190) G191
                                                        (EXIT (NREVERSE #2#))))
                                                      0 (QREFELT $ 18))
                                            #4#))))
                                   (LETT |j| (+ |j| 1)) (GO G190) G191
                                   (EXIT (NREVERSE #4#))))
                             0 (QREFELT $ 18)))))))) 

(SDEFUN |GUESSEB;deg2|
        ((|x| (|List| (|Integer|))) (|i| (|Integer|)) ($ (|Integer|)))
        (SPROG ((#1=#:G798 NIL) (|j| NIL) (#2=#:G797 NIL) (|m| (|Integer|)))
               (SEQ (LETT |m| (- (LENGTH |x|) 3))
                    (EXIT
                     (+ (|GUESSEB;deg1| |x| |i| $)
                        (*
                         (+ (SPADCALL |x| (+ |m| 3) (QREFELT $ 15))
                            (SPADCALL (ELT $ 16)
                                      (PROGN
                                       (LETT #2# NIL)
                                       (SEQ (LETT |j| (+ 2 |i|)) (LETT #1# |m|)
                                            G190 (COND ((> |j| #1#) (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #2#
                                                    (CONS
                                                     (SPADCALL |x| |j|
                                                               (QREFELT $ 15))
                                                     #2#))))
                                            (LETT |j| (+ |j| 1)) (GO G190) G191
                                            (EXIT (NREVERSE #2#))))
                                      0 (QREFELT $ 18)))
                         (- (SPADCALL |x| (+ |m| 2) (QREFELT $ 15))
                            (SPADCALL |x| (+ |m| 1) (QREFELT $ 15))))))))) 

(SDEFUN |GUESSEB;checkResult|
        ((|res| (EXPRR)) (|n| (|Symbol|)) (|l| (|Integer|)) (|list| (|List| F))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G806 NIL) (#2=#:G801 NIL) (|num| (EXPRR)) (#3=#:G800 NIL)
          (|den| (EXPRR)) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| |l|) G190 (COND ((< |i| 1) (GO G191)))
                 (SEQ
                  (LETT |den|
                        (SPADCALL (SPADCALL |res| (QREFELT $ 19))
                                  (SPADCALL |n| (QREFELT $ 21))
                                  (SPADCALL (- |i| 1) (QREFELT $ 22))
                                  (QREFELT $ 23)))
                  (COND
                   ((SPADCALL |den| (|spadConstant| $ 26) (QREFELT $ 28))
                    (PROGN
                     (LETT #1#
                           (PROG1 (LETT #3# |i|)
                             (|check_subtype2| (>= #3# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #3#)))
                     (GO #4=#:G805))))
                  (LETT |num|
                        (SPADCALL (SPADCALL |res| (QREFELT $ 29))
                                  (SPADCALL |n| (QREFELT $ 21))
                                  (SPADCALL (- |i| 1) (QREFELT $ 22))
                                  (QREFELT $ 23)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |list| |i| (QREFELT $ 31))
                               (SPADCALL (SPADCALL |num| |den| (QREFELT $ 32))
                                         (QREFELT $ 9))
                               (QREFELT $ 33))
                     (PROGN
                      (LETT #1#
                            (PROG1 (LETT #2# |i|)
                              (|check_subtype2| (>= #2# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #2#)))
                      (GO #4#))))))
                 (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
            (EXIT 0)))
          #4# (EXIT #1#)))) 

(SDEFUN |GUESSEB;SUPS2SUPF|
        ((|p| (|SparseUnivariatePolynomial| S))
         ($ (|SparseUnivariatePolynomial| F)))
        (COND ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7)) |p|)
              ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
               (SPADCALL (ELT $ 35) |p| (QREFELT $ 40)))
              ('T
               (|error|
                (SPADCALL
                 "Guess: type parameter F should be either equal to S or"
                 " equal to Fraction S" (QREFELT $ 42)))))) 

(SDEFUN |GUESSEB;F2FPOLYS|
        ((|p| (F))
         ($
          (|Fraction|
           (|SparseMultivariatePolynomial| S
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))))
        (COND
         ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7))
          (SPADCALL (SPADCALL |p| (QREFELT $ 44)) (QREFELT $ 46)))
         ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
          (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 47)) (QREFELT $ 49))
                    (SPADCALL (SPADCALL |p| (QREFELT $ 50)) (QREFELT $ 49))
                    (QREFELT $ 52)))
         ('T
          (|error|
           (SPADCALL "Guess: type parameter F should be either equal to S or"
                     " equal to Fraction S" (QREFELT $ 42)))))) 

(SDEFUN |GUESSEB;SUPF2EXPRR|
        ((|xx| (|Symbol|)) (|p| (|SparseUnivariatePolynomial| F)) ($ (EXPRR)))
        (COND ((SPADCALL |p| (QREFELT $ 53)) (|spadConstant| $ 26))
              ('T
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |p| (QREFELT $ 54)) (QREFELT $ 10))
                 (SPADCALL (SPADCALL |xx| (QREFELT $ 21))
                           (SPADCALL |p| (QREFELT $ 56)) (QREFELT $ 57))
                 (QREFELT $ 58))
                (|GUESSEB;SUPF2EXPRR| |xx| (SPADCALL |p| (QREFELT $ 59)) $)
                (QREFELT $ 60))))) 

(SDEFUN |GUESSEB;FSUPF2EXPRR|
        ((|xx| (|Symbol|)) (|p| (|Fraction| (|SparseUnivariatePolynomial| F)))
         ($ (EXPRR)))
        (SPADCALL (|GUESSEB;SUPF2EXPRR| |xx| (SPADCALL |p| (QREFELT $ 62)) $)
                  (|GUESSEB;SUPF2EXPRR| |xx| (SPADCALL |p| (QREFELT $ 63)) $)
                  (QREFELT $ 32))) 

(SDEFUN |GUESSEB;POLYS2POLYF|
        ((|p|
          (|SparseMultivariatePolynomial| S
                                          (|OrderedVariableList|
                                           (|construct| '|a1| 'A))))
         ($
          (|SparseMultivariatePolynomial| F
                                          (|OrderedVariableList|
                                           (|construct| '|a1| 'A)))))
        (COND ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7)) |p|)
              ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
               (SPADCALL (ELT $ 35) |p| (QREFELT $ 65)))
              ('T
               (|error|
                (SPADCALL
                 "Guess: type parameter F should be either equal to S or"
                 " equal to Fraction S" (QREFELT $ 42)))))) 

(SDEFUN |GUESSEB;SUPPOLYS2SUPF|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| S
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A)))))
         (|a1v| (F)) (|Av| (F)) ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((|lc|
           (|SparseMultivariatePolynomial| F
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A)))))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 67)) (|spadConstant| $ 68))
                ('T
                 (SEQ
                  (LETT |lc|
                        (|GUESSEB;POLYS2POLYF| (SPADCALL |p| (QREFELT $ 69))
                         $))
                  (EXIT
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL |lc|
                                (LIST (SPADCALL 1 (QREFELT $ 72))
                                      (SPADCALL 2 (QREFELT $ 72)))
                                (LIST |a1v| |Av|) (QREFELT $ 74))
                      (QREFELT $ 75))
                     (SPADCALL |p| (QREFELT $ 76)) (QREFELT $ 77))
                    (|GUESSEB;SUPPOLYS2SUPF| (SPADCALL |p| (QREFELT $ 78))
                     |a1v| |Av| $)
                    (QREFELT $ 79))))))))) 

(SDEFUN |GUESSEB;SUPFPOLYS2FSUPPOLYS|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|Fraction|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A))))))
         ($
          (|Fraction|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A)))))))
        (SPROG
         ((|pden|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A)))))
          (|pnum|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A)))))
          (|cden|
           (|Record|
            (|:| |num|
                 (|SparseUnivariatePolynomial|
                  (|Fraction|
                   (|SparseMultivariatePolynomial| S
                                                   (|OrderedVariableList|
                                                    (|construct| '|a1| 'A))))))
            (|:| |den|
                 (|SparseMultivariatePolynomial| S
                                                 (|OrderedVariableList|
                                                  (|construct| '|a1| 'A)))))))
         (SEQ (LETT |cden| (SPADCALL |p| (QREFELT $ 83)))
              (LETT |pnum|
                    (SPADCALL
                     (CONS #'|GUESSEB;SUPFPOLYS2FSUPPOLYS!0| (VECTOR $ |cden|))
                     |p| (QREFELT $ 88)))
              (LETT |pden| (SPADCALL (QCDR |cden|) (QREFELT $ 89)))
              (EXIT (SPADCALL |pnum| |pden| (QREFELT $ 91)))))) 

(SDEFUN |GUESSEB;SUPFPOLYS2FSUPPOLYS!0| ((|z1| NIL) ($$ NIL))
        (PROG (|cden| $)
          (LETT |cden| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| (QCDR |cden|) (QREFELT $ 84))
                      (QREFELT $ 85)))))) 

(PUT '|GUESSEB;defaultD| '|SPADreplace| '(XLAM (|expr|) |expr|)) 

(SDEFUN |GUESSEB;defaultD| ((|expr| (EXPRR)) ($ (EXPRR))) |expr|) 

(SDEFUN |GUESSEB;DN2DL|
        ((DN (|Mapping| EXPRR EXPRR)) (|i| (|Integer|)) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |i| (QREFELT $ 22)) DN) (QREFELT $ 9))) 

(SDEFUN |GUESSEB;evalResultant|
        ((|p1|
          (|SparseMultivariatePolynomial| S
                                          (|OrderedVariableList|
                                           (|construct| '|a1| 'A))))
         (|p2|
          (|SparseMultivariatePolynomial| S
                                          (|OrderedVariableList|
                                           (|construct| '|a1| 'A))))
         (|o| (|Integer|)) (|d| (|Integer|))
         (|va1| (|OrderedVariableList| (|construct| '|a1| 'A)))
         (|vA| (|OrderedVariableList| (|construct| '|a1| 'A))) ($ (|List| S)))
        (SPROG
         ((|res| (|List| S)) (#1=#:G838 NIL) (#2=#:G836 NIL) (|lead| (S))
          (#3=#:G834 NIL) (#4=#:G832 NIL) (|d2atk| #5=(|NonNegativeInteger|))
          (|d1atk| #5#) (|p2atk| #6=(|SparseUnivariatePolynomial| S))
          (|p1atk| #6#) (#7=#:G844 NIL) (|k| NIL)
          (|d2| #8=(|NonNegativeInteger|)) (|d1| #8#))
         (SEQ (LETT |res| NIL) (LETT |d1| (SPADCALL |p1| |va1| (QREFELT $ 92)))
              (LETT |d2| (SPADCALL |p2| |va1| (QREFELT $ 92)))
              (SEQ (LETT |k| 1) (LETT #7# (+ (- |d| |o|) 1)) G190
                   (COND ((|greater_SI| |k| #7#) (GO G191)))
                   (SEQ
                    (LETT |p1atk|
                          (SPADCALL
                           (SPADCALL |p1| |vA| (SPADCALL |k| (QREFELT $ 93))
                                     (QREFELT $ 94))
                           (QREFELT $ 95)))
                    (LETT |p2atk|
                          (SPADCALL
                           (SPADCALL |p2| |vA| (SPADCALL |k| (QREFELT $ 93))
                                     (QREFELT $ 94))
                           (QREFELT $ 95)))
                    (LETT |d1atk| (SPADCALL |p1atk| (QREFELT $ 96)))
                    (LETT |d2atk| (SPADCALL |p2atk| (QREFELT $ 96)))
                    (COND
                     ((< |d2atk| |d2|)
                      (COND
                       ((< |d1atk| |d1|) (LETT |lead| (|spadConstant| $ 25)))
                       ('T
                        (LETT |lead|
                              (SPADCALL (SPADCALL |p1atk| (QREFELT $ 97))
                                        (PROG1 (LETT #4# (- |d2| |d2atk|))
                                          (|check_subtype2| (>= #4# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #4#))
                                        (QREFELT $ 98))))))
                     ((< |d1atk| |d1|)
                      (LETT |lead|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 12) (QREFELT $ 99))
                              |d2| (QREFELT $ 98))
                             (SPADCALL (SPADCALL |p2atk| (QREFELT $ 97))
                                       (PROG1 (LETT #3# (- |d1| |d1atk|))
                                         (|check_subtype2| (>= #3# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #3#))
                                       (QREFELT $ 98))
                             (QREFELT $ 100))))
                     ('T (LETT |lead| (|spadConstant| $ 12))))
                    (EXIT
                     (COND
                      ((SPADCALL |lead| (QREFELT $ 101))
                       (LETT |res| (CONS (|spadConstant| $ 25) |res|)))
                      ('T
                       (LETT |res|
                             (CONS
                              (SPADCALL |lead|
                                        (PROG2
                                            (LETT #1#
                                                  (SPADCALL
                                                   (SPADCALL |p1atk| |p2atk|
                                                             (QREFELT $ 102))
                                                   (SPADCALL
                                                    (SPADCALL |k|
                                                              (QREFELT $ 93))
                                                    (PROG1 (LETT #2# |o|)
                                                      (|check_subtype2|
                                                       (>= #2# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #2#))
                                                    (QREFELT $ 98))
                                                   (QREFELT $ 104)))
                                            (QCDR #1#)
                                          (|check_union2| (QEQCAR #1# 0)
                                                          (QREFELT $ 7)
                                                          (|Union|
                                                           (QREFELT $ 7)
                                                           "failed")
                                                          #1#))
                                        (QREFELT $ 100))
                              |res|))))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (REVERSE |res|))))) 

(SDEFUN |GUESSEB;p_subst|
        ((|xm| (|Integer|)) (|i| (|Integer|))
         (|va1| (|OrderedVariableList| (|construct| '|a1| 'A)))
         (|vA| (|OrderedVariableList| (|construct| '|a1| 'A)))
         (|basis| (|Mapping| EXPRR EXPRR))
         ($
          (|Fraction|
           (|SparseMultivariatePolynomial| S
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))))
        (SPADCALL (SPADCALL (SPADCALL |vA| (QREFELT $ 105)) (QREFELT $ 106))
                  (SPADCALL
                   (SPADCALL (SPADCALL |va1| (QREFELT $ 105)) (QREFELT $ 106))
                   (|GUESSEB;F2FPOLYS|
                    (SPADCALL (|GUESSEB;DN2DL| |basis| |i| $)
                              (|GUESSEB;DN2DL| |basis| |xm| $) (QREFELT $ 107))
                    $)
                   (QREFELT $ 108))
                  (QREFELT $ 109))) 

(SDEFUN |GUESSEB;p2_subst|
        ((|xm| (|Integer|)) (|i| (|Symbol|)) (|a1v| (F)) (|Av| (F))
         (|basis| (|Mapping| EXPRR EXPRR)) ($ (EXPRR)))
        (SPADCALL (SPADCALL |Av| (QREFELT $ 10))
                  (SPADCALL (SPADCALL |a1v| (QREFELT $ 10))
                            (SPADCALL
                             (SPADCALL (SPADCALL |i| (QREFELT $ 21)) |basis|)
                             (SPADCALL (SPADCALL |xm| (QREFELT $ 22)) |basis|)
                             (QREFELT $ 110))
                            (QREFELT $ 58))
                  (QREFELT $ 60))) 

(SDEFUN |GUESSEB;guessExpRatAux|
        ((|xx| (|Symbol|)) (|list| (|List| F))
         (|basis| (|Mapping| EXPRR EXPRR)) (|xValues| (|List| (|Integer|)))
         (|options| (|List| (|GuessOption|))) ($ (|List| EXPRR)))
        (SPROG
         ((#1=#:G920 NIL) (|res| (|List| EXPRR)) (|res4| (EXPRR))
          (|denr| #2=(|SparseUnivariatePolynomial| F)) (|numr| #2#)
          (|ri1|
           (|Fraction|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| S
                                             (|OrderedVariableList|
                                              (|construct| '|a1| 'A))))))
          (|t2|
           #3=(|SparseMultivariatePolynomial| F
                                              (|OrderedVariableList|
                                               (|construct| '|a1| 'A))))
          (|t1| #3#) (|a1v| (F)) (#4=#:G927 NIL) (|g| NIL)
          (|evalPoly|
           (|SparseMultivariatePolynomial| F
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))
          (|Av| (F)) (#5=#:G926 NIL) (|f| NIL)
          (|res3| (|SparseUnivariatePolynomial| F))
          (|res2| #6=(|SparseUnivariatePolynomial| S)) (|res1| #6#)
          (|d2| (|Integer|)) (|o2| (|Integer|)) (|d1| (|Integer|))
          (|o1| (|Integer|))
          (|poly3|
           #7=(|SparseMultivariatePolynomial| S
                                              (|OrderedVariableList|
                                               (|construct| '|a1| 'A))))
          (|poly2| #7#) (|poly1| #7#)
          (|ri|
           (|Fraction|
            (|SparseUnivariatePolynomial|
             (|Fraction|
              (|SparseMultivariatePolynomial| S
                                              (|OrderedVariableList|
                                               (|construct| '|a1| 'A)))))))
          (#8=#:G894 NIL) (#9=#:G925 NIL) (|i| NIL) (|maxDeg| (|Integer|))
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (|y3|
           #10=(|Fraction|
                (|SparseMultivariatePolynomial| S
                                                (|OrderedVariableList|
                                                 (|construct| '|a1| 'A)))))
          (|y2| #10#) (|y1| #10#)
          (|ylist|
           (|List|
            (|Fraction|
             (|SparseMultivariatePolynomial| S
                                             (|OrderedVariableList|
                                              (|construct| '|a1| 'A))))))
          (#11=#:G924 NIL) (#12=#:G923 NIL)
          (|y| (|Mapping| #10# (|NonNegativeInteger|)))
          (|x3|
           #13=(|Fraction|
                (|SparseMultivariatePolynomial| S
                                                (|OrderedVariableList|
                                                 (|construct| '|a1| 'A)))))
          (|x2| #13#) (|x1| #13#) (|xlist| (|List| #13#)) (#14=#:G922 NIL)
          (#15=#:G921 NIL) (|len| (|NonNegativeInteger|)) (#16=#:G866 NIL)
          (A #17=(|OrderedVariableList| (|construct| '|a1| 'A))) (|a1| #17#))
         (SEQ
          (EXIT
           (SEQ (LETT |a1| (SPADCALL 1 (QREFELT $ 72)))
                (LETT A (SPADCALL 2 (QREFELT $ 72)))
                (LETT |len| (LENGTH |list|))
                (COND ((< |len| 4) (PROGN (LETT #1# NIL) (GO #18=#:G919)))
                      (#19='T
                       (LETT |len|
                             (PROG1 (LETT #16# (- |len| 3))
                               (|check_subtype2| (>= #16# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #16#)))))
                (LETT |xlist|
                      (PROGN
                       (LETT #15# NIL)
                       (SEQ (LETT |i| 1) (LETT #14# |len|) G190
                            (COND ((|greater_SI| |i| #14#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #15#
                                    (CONS
                                     (|GUESSEB;F2FPOLYS|
                                      (|GUESSEB;DN2DL| |basis|
                                       (SPADCALL |xValues| |i| (QREFELT $ 15))
                                       $)
                                      $)
                                     #15#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #15#)))))
                (LETT |x1|
                      (|GUESSEB;F2FPOLYS|
                       (|GUESSEB;DN2DL| |basis|
                        (SPADCALL |xValues| (+ |len| 1) (QREFELT $ 15)) $)
                       $))
                (LETT |x2|
                      (|GUESSEB;F2FPOLYS|
                       (|GUESSEB;DN2DL| |basis|
                        (SPADCALL |xValues| (+ |len| 2) (QREFELT $ 15)) $)
                       $))
                (LETT |x3|
                      (|GUESSEB;F2FPOLYS|
                       (|GUESSEB;DN2DL| |basis|
                        (SPADCALL |xValues| (+ |len| 3) (QREFELT $ 15)) $)
                       $))
                (LETT |y|
                      (CONS #'|GUESSEB;guessExpRatAux!0|
                            (VECTOR |basis| A |a1| |xValues| $ |list|)))
                (LETT |ylist|
                      (PROGN
                       (LETT #12# NIL)
                       (SEQ (LETT |i| 1) (LETT #11# |len|) G190
                            (COND ((|greater_SI| |i| #11#) (GO G191)))
                            (SEQ
                             (EXIT (LETT #12# (CONS (SPADCALL |i| |y|) #12#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #12#)))))
                (LETT |y1| (SPADCALL (+ |len| 1) |y|))
                (LETT |y2| (SPADCALL (+ |len| 2) |y|))
                (LETT |y3| (SPADCALL (+ |len| 3) |y|)) (LETT |res| NIL)
                (SEQ (LETT |maxD| (SPADCALL |options| (QREFELT $ 117)))
                     (EXIT
                      (COND
                       ((QEQCAR |maxD| 0)
                        (LETT |maxDeg| (MIN (QCDR |maxD|) (- |len| 1))))
                       (#19# (LETT |maxDeg| (- |len| 1))))))
                (SEQ (LETT |i| 0) (LETT #9# |maxDeg|) G190
                     (COND ((|greater_SI| |i| #9#) (GO G191)))
                     (SEQ
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: degree ExpRat "
                                  (SPADCALL |i| (QREFELT $ 120))
                                  (QREFELT $ 123))))
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: interpolating..." (QREFELT $ 124))))
                      (LETT |ri|
                            (SPADCALL |xlist| |ylist|
                                      (PROG1 (LETT #8# (- (- |len| 1) |i|))
                                        (|check_subtype2| (>= #8# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #8#))
                                      (QREFELT $ 128)))
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: polynomials..." (QREFELT $ 124))))
                      (LETT |poly1|
                            (SPADCALL
                             (SPADCALL (SPADCALL |ri| |x1| (QREFELT $ 130))
                                       |y1| (QREFELT $ 131))
                             (QREFELT $ 132)))
                      (LETT |poly2|
                            (SPADCALL
                             (SPADCALL (SPADCALL |ri| |x2| (QREFELT $ 130))
                                       |y2| (QREFELT $ 131))
                             (QREFELT $ 132)))
                      (LETT |poly3|
                            (SPADCALL
                             (SPADCALL (SPADCALL |ri| |x3| (QREFELT $ 130))
                                       |y3| (QREFELT $ 131))
                             (QREFELT $ 132)))
                      (LETT |o1| (|GUESSEB;ord1| |xValues| |i| $))
                      (LETT |d1| (|GUESSEB;deg1| |xValues| |i| $))
                      (LETT |o2| (|GUESSEB;ord2| |xValues| |i| $))
                      (LETT |d2| (|GUESSEB;deg2| |xValues| |i| $))
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: interpolating resultants..."
                                  (QREFELT $ 124))))
                      (LETT |res1|
                            (SPADCALL
                             (|GUESSEB;evalResultant| |poly1| |poly3| |o1| |d1|
                              |a1| A $)
                             (QREFELT $ 135)))
                      (LETT |res2|
                            (SPADCALL
                             (|GUESSEB;evalResultant| |poly2| |poly3| |o2| |d2|
                              |a1| A $)
                             (QREFELT $ 135)))
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: computing gcd..." (QREFELT $ 124))))
                      (LETT |res3|
                            (|GUESSEB;SUPS2SUPF|
                             (SPADCALL (SPADCALL |res1| |res2| (QREFELT $ 136))
                                       (QREFELT $ 137))
                             $))
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: solving..." (QREFELT $ 124))))
                      (SEQ (LETT |f| NIL)
                           (LETT #5#
                                 (SPADCALL (SPADCALL |res3| (QREFELT $ 139))
                                           (QREFELT $ 144)))
                           G190
                           (COND
                            ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((EQL (SPADCALL (QVELT |f| 1) (QREFELT $ 56)) 1)
                               (SEQ
                                (LETT |Av|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL (QVELT |f| 1) 0
                                                  (QREFELT $ 145))
                                        (SPADCALL (QVELT |f| 1) (QREFELT $ 54))
                                        (QREFELT $ 146))
                                       (QREFELT $ 147)))
                                (LETT |evalPoly|
                                      (SPADCALL
                                       (|GUESSEB;POLYS2POLYF| |poly3| $) A |Av|
                                       (QREFELT $ 148)))
                                (COND
                                 ((SPADCALL |evalPoly| (QREFELT $ 149))
                                  (LETT |evalPoly|
                                        (SPADCALL
                                         (|GUESSEB;POLYS2POLYF| |poly1| $) A
                                         |Av| (QREFELT $ 148)))))
                                (EXIT
                                 (SEQ (LETT |g| NIL)
                                      (LETT #4#
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |evalPoly|
                                                        (QREFELT $ 150))
                                              (QREFELT $ 139))
                                             (QREFELT $ 144)))
                                      G190
                                      (COND
                                       ((OR (ATOM #4#)
                                            (PROGN (LETT |g| (CAR #4#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((EQL
                                           (SPADCALL (QVELT |g| 1)
                                                     (QREFELT $ 56))
                                           1)
                                          (SEQ
                                           (LETT |a1v|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL (QVELT |g| 1) 0
                                                             (QREFELT $ 145))
                                                   (SPADCALL (QVELT |g| 1)
                                                             (QREFELT $ 54))
                                                   (QREFELT $ 146))
                                                  (QREFELT $ 147)))
                                           (LETT |t1|
                                                 (SPADCALL
                                                  (|GUESSEB;POLYS2POLYF|
                                                   |poly1| $)
                                                  (LIST |a1| A)
                                                  (LIST |a1v| |Av|)
                                                  (QREFELT $ 74)))
                                           (COND
                                            ((NULL
                                              (SPADCALL |t1| (QREFELT $ 149)))
                                             (EXIT "iterate")))
                                           (LETT |t2|
                                                 (SPADCALL
                                                  (|GUESSEB;POLYS2POLYF|
                                                   |poly2| $)
                                                  (LIST |a1| A)
                                                  (LIST |a1v| |Av|)
                                                  (QREFELT $ 74)))
                                           (EXIT
                                            (COND
                                             ((SPADCALL |t2| (QREFELT $ 149))
                                              (SEQ
                                               (LETT |ri1|
                                                     (SPADCALL
                                                      (|GUESSEB;SUPFPOLYS2FSUPPOLYS|
                                                       (SPADCALL |ri|
                                                                 (QREFELT $
                                                                          151))
                                                       $)
                                                      (|GUESSEB;SUPFPOLYS2FSUPPOLYS|
                                                       (SPADCALL |ri|
                                                                 (QREFELT $
                                                                          152))
                                                       $)
                                                      (QREFELT $ 153)))
                                               (LETT |numr|
                                                     (|GUESSEB;SUPPOLYS2SUPF|
                                                      (SPADCALL |ri1|
                                                                (QREFELT $
                                                                         154))
                                                      |a1v| |Av| $))
                                               (LETT |denr|
                                                     (|GUESSEB;SUPPOLYS2SUPF|
                                                      (SPADCALL |ri1|
                                                                (QREFELT $
                                                                         155))
                                                      |a1v| |Av| $))
                                               (EXIT
                                                (COND
                                                 ((SPADCALL |denr|
                                                            (QREFELT $ 53))
                                                  (COND
                                                   ((SPADCALL |numr|
                                                              (QREFELT $ 53))
                                                    (COND
                                                     ((SPADCALL |options|
                                                                (QREFELT $
                                                                         118))
                                                      (SPADCALL
                                                       "Guess: numerator and denominator vanish!"
                                                       (QREFELT $ 124)))))))
                                                 ('T
                                                  (SEQ
                                                   (LETT |res4|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (|GUESSEB;FSUPF2EXPRR|
                                                            |xx|
                                                            (SPADCALL |numr|
                                                                      |denr|
                                                                      (QREFELT
                                                                       $ 156))
                                                            $)
                                                           (SPADCALL |xx|
                                                                     (QREFELT $
                                                                              158))
                                                           (SPADCALL
                                                            (SPADCALL |xx|
                                                                      (QREFELT
                                                                       $ 21))
                                                            |basis|)
                                                           (QREFELT $ 160))
                                                          (SPADCALL
                                                           (|GUESSEB;p2_subst|
                                                            (SPADCALL |xValues|
                                                                      (QREFELT
                                                                       $ 111))
                                                            |xx| |a1v| |Av|
                                                            |basis| $)
                                                           (SPADCALL |xx|
                                                                     (QREFELT $
                                                                              21))
                                                           (QREFELT $ 161))
                                                          (QREFELT $ 58)))
                                                   (EXIT
                                                    (LETT |res|
                                                          (CONS |res4|
                                                                |res|))))))))))))))))
                                      (LETT #4# (CDR #4#)) (GO G190) G191
                                      (EXIT NIL))))))))
                           (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL (NULL |res|))
                         (COND
                          ((SPADCALL |options| (QREFELT $ 162))
                           (PROGN (LETT #1# |res|) (GO #18#))))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #18# (EXIT #1#)))) 

(SDEFUN |GUESSEB;guessExpRatAux!0| ((|z1| NIL) ($$ NIL))
        (PROG (|list| $ |xValues| |a1| A |basis|)
          (LETT |list| (QREFELT $$ 5))
          (LETT $ (QREFELT $$ 4))
          (LETT |xValues| (QREFELT $$ 3))
          (LETT |a1| (QREFELT $$ 2))
          (LETT A (QREFELT $$ 1))
          (LETT |basis| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (|GUESSEB;F2FPOLYS| (SPADCALL |list| |z1| (QREFELT $ 31)) $)
             (SPADCALL
              (|GUESSEB;p_subst| (SPADCALL |xValues| (QREFELT $ 111))
               (SPADCALL |xValues| |z1| (QREFELT $ 15)) |a1| A |basis| $)
              (SPADCALL (SPADCALL |xValues| |z1| (QREFELT $ 15))
                        (QREFELT $ 112))
              (QREFELT $ 113))
             (QREFELT $ 108)))))) 

(SDEFUN |GUESSEB;guessExpRatAux0|
        ((|list| (|List| F)) (|basis| (|Mapping| EXPRR EXPRR))
         (|options| (|List| (|GuessOption|))) ($ (|List| EXPRR)))
        (SPROG
         ((|res| (|List| EXPRR)) (#1=#:G948 NIL) (|f| NIL) (#2=#:G947 NIL)
          (|xValues| (|List| (|Integer|))) (|newlist| (|List| F))
          (|i| (|Integer|)) (#3=#:G946 NIL) (|x| NIL) (|zeros| (EXPRR))
          (#4=#:G945 NIL) (|shortlist| (|List| F)) (#5=#:G930 NIL)
          (#6=#:G944 NIL) (|len| (|Integer|)) (|xx| (|Symbol|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((ZEROP (SPADCALL |options| (QREFELT $ 163)))
              (|error| "Guess: guessExpRat does not support zero safety")))
            (LETT |xx| (SPADCALL |options| (QREFELT $ 164)))
            (LETT |len| (LENGTH |list|))
            (COND
             ((< (+ (- |len| (SPADCALL |options| (QREFELT $ 163))) 1) 0)
              (PROGN (LETT #6# NIL) (GO #7=#:G943))))
            (LETT |shortlist|
                  (SPADCALL |list|
                            (PROG1
                                (LETT #5#
                                      (+
                                       (- |len|
                                          (SPADCALL |options| (QREFELT $ 163)))
                                       1))
                              (|check_subtype2| (>= #5# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #5#))
                            (QREFELT $ 165)))
            (LETT |zeros| (|spadConstant| $ 166)) (LETT |i| -1)
            (SEQ (LETT |x| NIL) (LETT #4# |shortlist|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL)) (GO G191)))
                 (SEQ (LETT |i| (+ |i| 1))
                      (EXIT
                       (COND
                        ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 167))
                         (LETT |zeros|
                               (SPADCALL |zeros|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |xx| (QREFELT $ 21))
                                           |basis|)
                                          (SPADCALL
                                           (SPADCALL |i| (QREFELT $ 22))
                                           |basis|)
                                          (QREFELT $ 110))
                                         (QREFELT $ 58)))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (LETT |i| -1)
            (SEQ (LETT |x| NIL) (LETT #3# |shortlist|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ (LETT |i| (+ |i| 1))
                      (EXIT
                       (COND
                        ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 33))
                         (SEQ
                          (LETT |newlist|
                                (CONS
                                 (SPADCALL |x|
                                           (SPADCALL
                                            (SPADCALL |zeros|
                                                      (SPADCALL |xx|
                                                                (QREFELT $ 21))
                                                      (SPADCALL |i|
                                                                (QREFELT $ 22))
                                                      (QREFELT $ 23))
                                            (QREFELT $ 9))
                                           (QREFELT $ 146))
                                 |newlist|))
                          (EXIT (LETT |xValues| (CONS |i| |xValues|))))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (LETT |newlist| (REVERSE |newlist|))
            (LETT |xValues| (REVERSE |xValues|))
            (LETT |res|
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |f| NIL)
                        (LETT #1#
                              (|GUESSEB;guessExpRatAux| |xx| |newlist| |basis|
                               |xValues| |options| $))
                        G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS
                                 (SPADCALL
                                  (SPADCALL |zeros| |f| (QREFELT $ 58))
                                  (SPADCALL |xx| (QREFELT $ 21))
                                  (SPADCALL |xx| (QREFELT $ 21))
                                  (QREFELT $ 23))
                                 #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#)))))
            (EXIT
             (SPADCALL
              (CONS #'|GUESSEB;guessExpRatAux0!0|
                    (VECTOR |options| $ |list| |len| |xx|))
              |res| (QREFELT $ 172)))))
          #7# (EXIT #6#)))) 

(SDEFUN |GUESSEB;guessExpRatAux0!0| ((|z1| NIL) ($$ NIL))
        (PROG (|xx| |len| |list| $ |options|)
          (LETT |xx| (QREFELT $$ 4))
          (LETT |len| (QREFELT $$ 3))
          (LETT |list| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |options| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|GUESSEB;checkResult| |z1| |xx| |len| |list| $)
                      (SPADCALL |len| (SPADCALL |options| (QREFELT $ 163))
                                (QREFELT $ 168))
                      (QREFELT $ 169)))))) 

(SDEFUN |GUESSEB;guessExpRat;LLL;20|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (|GUESSEB;guessExpRatAux0| |list|
         (CONS (|function| |GUESSEB;defaultD|) $) |options| $)) 

(SDEFUN |GUESSEB;guessExpRat;SM;21|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (CONS #'|GUESSEB;guessExpRat;SM;21!1| (VECTOR |q| $)))) 

(SDEFUN |GUESSEB;guessExpRat;SM;21!1| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|GUESSEB;guessExpRatAux0| |z1|
                    (CONS #'|GUESSEB;guessExpRat;SM;21!0| (VECTOR $ |q|)) |z2|
                    $)))))) 

(SDEFUN |GUESSEB;guessExpRat;SM;21!0| ((|i1| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |q| (QREFELT $ 21)) |i1| (QREFELT $ 161)))))) 

(SDEFUN |GUESSEB;binExt|
        ((|i| (|Integer|))
         (|va1| (|OrderedVariableList| (|construct| '|a1| 'A)))
         (|vA| (|OrderedVariableList| (|construct| '|a1| 'A)))
         ($
          (|Fraction|
           (|SparseMultivariatePolynomial| S
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))))
        (SPROG
         ((|num|
           (|SparseMultivariatePolynomial| S
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))
          (|numl|
           (|List|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A)))))
          (#1=#:G962 NIL) (|l| NIL) (#2=#:G961 NIL))
         (SEQ
          (LETT |numl|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |l| 0) (LETT #1# (- |i| 1)) G190
                      (COND ((|greater_SI| |l| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL
                                (SPADCALL (SPADCALL |vA| (QREFELT $ 105))
                                          (SPADCALL |i|
                                                    (SPADCALL |va1|
                                                              (QREFELT $ 105))
                                                    (QREFELT $ 176))
                                          (QREFELT $ 177))
                                (SPADCALL |l| (QREFELT $ 178)) (QREFELT $ 179))
                               #2#))))
                      (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |num|
                (SPADCALL (ELT $ 180) |numl| (|spadConstant| $ 181)
                          (QREFELT $ 184)))
          (EXIT
           (SPADCALL |num|
                     (SPADCALL (SPADCALL |i| (QREFELT $ 185)) (QREFELT $ 178))
                     (QREFELT $ 52)))))) 

(SDEFUN |GUESSEB;binExtEXPR|
        ((|i| (|Symbol|)) (|a1v| (F)) (|Av| (F)) ($ (EXPRR)))
        (SPADCALL
         (SPADCALL (SPADCALL |Av| (QREFELT $ 10))
                   (SPADCALL (SPADCALL |a1v| (QREFELT $ 10))
                             (SPADCALL |i| (QREFELT $ 21)) (QREFELT $ 58))
                   (QREFELT $ 60))
         (SPADCALL |i| (QREFELT $ 21)) (QREFELT $ 186))) 

(SDEFUN |GUESSEB;guessBinRatAux|
        ((|xx| (|Symbol|)) (|list| (|List| F))
         (|basis| (|Mapping| EXPRR EXPRR))
         (|ext|
          (|Mapping|
           (|Fraction|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A))))
           (|Integer|) (|OrderedVariableList| (|construct| '|a1| 'A))
           (|OrderedVariableList| (|construct| '|a1| 'A))))
         (|extEXPR| (|Mapping| EXPRR (|Symbol|) F F))
         (|xValues| (|List| (|Integer|))) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((#1=#:G999 NIL) (|res| (|List| EXPRR)) (|res4| (EXPRR))
          (|denr| #2=(|SparseUnivariatePolynomial| F)) (|numr| #2#)
          (|ri1|
           (|Fraction|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| S
                                             (|OrderedVariableList|
                                              (|construct| '|a1| 'A))))))
          (|t2|
           #3=(|SparseMultivariatePolynomial| F
                                              (|OrderedVariableList|
                                               (|construct| '|a1| 'A))))
          (|t1| #3#) (|a1v| (F)) (#4=#:G1006 NIL) (|g| NIL)
          (|evalPoly|
           (|SparseMultivariatePolynomial| F
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))
          (|Av| (F)) (#5=#:G1005 NIL) (|f| NIL)
          (|res3| (|SparseUnivariatePolynomial| F))
          (|res2| #6=(|SparseUnivariatePolynomial| S)) (|res1| #6#)
          (|poly3|
           #7=(|SparseMultivariatePolynomial| S
                                              (|OrderedVariableList|
                                               (|construct| '|a1| 'A))))
          (|poly2| #7#) (|poly1| #7#)
          (|ri|
           (|Fraction|
            (|SparseUnivariatePolynomial|
             (|Fraction|
              (|SparseMultivariatePolynomial| S
                                              (|OrderedVariableList|
                                               (|construct| '|a1| 'A)))))))
          (#8=#:G979 NIL) (#9=#:G1004 NIL) (|i| NIL) (|maxDeg| (|Integer|))
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (|y3|
           #10=(|Fraction|
                (|SparseMultivariatePolynomial| S
                                                (|OrderedVariableList|
                                                 (|construct| '|a1| 'A)))))
          (|y2| #10#) (|y1| #10#)
          (|ylist|
           (|List|
            (|Fraction|
             (|SparseMultivariatePolynomial| S
                                             (|OrderedVariableList|
                                              (|construct| '|a1| 'A))))))
          (#11=#:G1003 NIL) (#12=#:G1002 NIL)
          (|y| (|Mapping| #10# (|NonNegativeInteger|)))
          (|x3|
           #13=(|Fraction|
                (|SparseMultivariatePolynomial| S
                                                (|OrderedVariableList|
                                                 (|construct| '|a1| 'A)))))
          (|x2| #13#) (|x1| #13#) (|xlist| (|List| #13#)) (#14=#:G1001 NIL)
          (#15=#:G1000 NIL) (|len| (|NonNegativeInteger|)) (#16=#:G964 NIL)
          (A #17=(|OrderedVariableList| (|construct| '|a1| 'A))) (|a1| #17#))
         (SEQ
          (EXIT
           (SEQ (LETT |a1| (SPADCALL 1 (QREFELT $ 72)))
                (LETT A (SPADCALL 2 (QREFELT $ 72)))
                (LETT |len| (LENGTH |list|))
                (COND ((< |len| 4) (PROGN (LETT #1# NIL) (GO #18=#:G998)))
                      (#19='T
                       (LETT |len|
                             (PROG1 (LETT #16# (- |len| 3))
                               (|check_subtype2| (>= #16# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #16#)))))
                (LETT |xlist|
                      (PROGN
                       (LETT #15# NIL)
                       (SEQ (LETT |i| 1) (LETT #14# |len|) G190
                            (COND ((|greater_SI| |i| #14#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #15#
                                    (CONS
                                     (|GUESSEB;F2FPOLYS|
                                      (|GUESSEB;DN2DL| |basis|
                                       (SPADCALL |xValues| |i| (QREFELT $ 15))
                                       $)
                                      $)
                                     #15#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #15#)))))
                (LETT |x1|
                      (|GUESSEB;F2FPOLYS|
                       (|GUESSEB;DN2DL| |basis|
                        (SPADCALL |xValues| (+ |len| 1) (QREFELT $ 15)) $)
                       $))
                (LETT |x2|
                      (|GUESSEB;F2FPOLYS|
                       (|GUESSEB;DN2DL| |basis|
                        (SPADCALL |xValues| (+ |len| 2) (QREFELT $ 15)) $)
                       $))
                (LETT |x3|
                      (|GUESSEB;F2FPOLYS|
                       (|GUESSEB;DN2DL| |basis|
                        (SPADCALL |xValues| (+ |len| 3) (QREFELT $ 15)) $)
                       $))
                (LETT |y|
                      (CONS #'|GUESSEB;guessBinRatAux!0|
                            (VECTOR |ext| A |a1| |xValues| $ |list|)))
                (LETT |ylist|
                      (PROGN
                       (LETT #12# NIL)
                       (SEQ (LETT |i| 1) (LETT #11# |len|) G190
                            (COND ((|greater_SI| |i| #11#) (GO G191)))
                            (SEQ
                             (EXIT (LETT #12# (CONS (SPADCALL |i| |y|) #12#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #12#)))))
                (LETT |y1| (SPADCALL (+ |len| 1) |y|))
                (LETT |y2| (SPADCALL (+ |len| 2) |y|))
                (LETT |y3| (SPADCALL (+ |len| 3) |y|)) (LETT |res| NIL)
                (SEQ (LETT |maxD| (SPADCALL |options| (QREFELT $ 117)))
                     (EXIT
                      (COND
                       ((QEQCAR |maxD| 0)
                        (LETT |maxDeg| (MIN (QCDR |maxD|) (- |len| 1))))
                       (#19# (LETT |maxDeg| (- |len| 1))))))
                (SEQ (LETT |i| 0) (LETT #9# |maxDeg|) G190
                     (COND ((|greater_SI| |i| #9#) (GO G191)))
                     (SEQ
                      (LETT |ri|
                            (SPADCALL |xlist| |ylist|
                                      (PROG1 (LETT #8# (- (- |len| 1) |i|))
                                        (|check_subtype2| (>= #8# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #8#))
                                      (QREFELT $ 128)))
                      (LETT |poly1|
                            (SPADCALL
                             (SPADCALL (SPADCALL |ri| |x1| (QREFELT $ 130))
                                       |y1| (QREFELT $ 131))
                             (QREFELT $ 132)))
                      (LETT |poly2|
                            (SPADCALL
                             (SPADCALL (SPADCALL |ri| |x2| (QREFELT $ 130))
                                       |y2| (QREFELT $ 131))
                             (QREFELT $ 132)))
                      (LETT |poly3|
                            (SPADCALL
                             (SPADCALL (SPADCALL |ri| |x3| (QREFELT $ 130))
                                       |y3| (QREFELT $ 131))
                             (QREFELT $ 132)))
                      (LETT |res1|
                            (SPADCALL
                             (SPADCALL |poly1| |poly3| |a1| (QREFELT $ 188))
                             (QREFELT $ 95)))
                      (LETT |res2|
                            (SPADCALL
                             (SPADCALL |poly2| |poly3| |a1| (QREFELT $ 188))
                             (QREFELT $ 95)))
                      (COND
                       ((SPADCALL |options| (QREFELT $ 118))
                        (SPADCALL "Guess: computing gcd..." (QREFELT $ 124))))
                      (LETT |res3|
                            (|GUESSEB;SUPS2SUPF|
                             (SPADCALL (SPADCALL |res1| |res2| (QREFELT $ 136))
                                       (QREFELT $ 137))
                             $))
                      (SEQ (LETT |f| NIL)
                           (LETT #5#
                                 (SPADCALL (SPADCALL |res3| (QREFELT $ 139))
                                           (QREFELT $ 144)))
                           G190
                           (COND
                            ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((EQL (SPADCALL (QVELT |f| 1) (QREFELT $ 56)) 1)
                               (SEQ
                                (LETT |Av|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL (QVELT |f| 1) 0
                                                  (QREFELT $ 145))
                                        (SPADCALL (QVELT |f| 1) (QREFELT $ 54))
                                        (QREFELT $ 146))
                                       (QREFELT $ 147)))
                                (LETT |evalPoly|
                                      (SPADCALL
                                       (|GUESSEB;POLYS2POLYF| |poly3| $) A |Av|
                                       (QREFELT $ 148)))
                                (COND
                                 ((SPADCALL |evalPoly| (QREFELT $ 149))
                                  (LETT |evalPoly|
                                        (SPADCALL
                                         (|GUESSEB;POLYS2POLYF| |poly1| $) A
                                         |Av| (QREFELT $ 148)))))
                                (EXIT
                                 (SEQ (LETT |g| NIL)
                                      (LETT #4#
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |evalPoly|
                                                        (QREFELT $ 150))
                                              (QREFELT $ 139))
                                             (QREFELT $ 144)))
                                      G190
                                      (COND
                                       ((OR (ATOM #4#)
                                            (PROGN (LETT |g| (CAR #4#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((EQL
                                           (SPADCALL (QVELT |g| 1)
                                                     (QREFELT $ 56))
                                           1)
                                          (SEQ
                                           (LETT |a1v|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL (QVELT |g| 1) 0
                                                             (QREFELT $ 145))
                                                   (SPADCALL (QVELT |g| 1)
                                                             (QREFELT $ 54))
                                                   (QREFELT $ 146))
                                                  (QREFELT $ 147)))
                                           (LETT |t1|
                                                 (SPADCALL
                                                  (|GUESSEB;POLYS2POLYF|
                                                   |poly1| $)
                                                  (LIST |a1| A)
                                                  (LIST |a1v| |Av|)
                                                  (QREFELT $ 74)))
                                           (COND
                                            ((NULL
                                              (SPADCALL |t1| (QREFELT $ 149)))
                                             (EXIT "iterate")))
                                           (LETT |t2|
                                                 (SPADCALL
                                                  (|GUESSEB;POLYS2POLYF|
                                                   |poly2| $)
                                                  (LIST |a1| A)
                                                  (LIST |a1v| |Av|)
                                                  (QREFELT $ 74)))
                                           (EXIT
                                            (COND
                                             ((SPADCALL |t2| (QREFELT $ 149))
                                              (SEQ
                                               (LETT |ri1|
                                                     (SPADCALL
                                                      (|GUESSEB;SUPFPOLYS2FSUPPOLYS|
                                                       (SPADCALL |ri|
                                                                 (QREFELT $
                                                                          151))
                                                       $)
                                                      (|GUESSEB;SUPFPOLYS2FSUPPOLYS|
                                                       (SPADCALL |ri|
                                                                 (QREFELT $
                                                                          152))
                                                       $)
                                                      (QREFELT $ 153)))
                                               (LETT |numr|
                                                     (|GUESSEB;SUPPOLYS2SUPF|
                                                      (SPADCALL |ri1|
                                                                (QREFELT $
                                                                         154))
                                                      |a1v| |Av| $))
                                               (LETT |denr|
                                                     (|GUESSEB;SUPPOLYS2SUPF|
                                                      (SPADCALL |ri1|
                                                                (QREFELT $
                                                                         155))
                                                      |a1v| |Av| $))
                                               (EXIT
                                                (COND
                                                 ((SPADCALL |denr|
                                                            (QREFELT $ 53))
                                                  (COND
                                                   ((SPADCALL |numr|
                                                              (QREFELT $ 53))
                                                    (COND
                                                     ((SPADCALL |options|
                                                                (QREFELT $
                                                                         118))
                                                      (SPADCALL
                                                       "Guess: numerator and denominator vanish!"
                                                       (QREFELT $ 124)))))))
                                                 ('T
                                                  (SEQ
                                                   (LETT |res4|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (|GUESSEB;FSUPF2EXPRR|
                                                            |xx|
                                                            (SPADCALL |numr|
                                                                      |denr|
                                                                      (QREFELT
                                                                       $ 156))
                                                            $)
                                                           (SPADCALL |xx|
                                                                     (QREFELT $
                                                                              158))
                                                           (SPADCALL
                                                            (SPADCALL |xx|
                                                                      (QREFELT
                                                                       $ 21))
                                                            |basis|)
                                                           (QREFELT $ 160))
                                                          (SPADCALL |xx| |a1v|
                                                                    |Av|
                                                                    |extEXPR|)
                                                          (QREFELT $ 58)))
                                                   (EXIT
                                                    (LETT |res|
                                                          (CONS |res4|
                                                                |res|))))))))))))))))
                                      (LETT #4# (CDR #4#)) (GO G190) G191
                                      (EXIT NIL))))))))
                           (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL (NULL |res|))
                         (COND
                          ((SPADCALL |options| (QREFELT $ 162))
                           (PROGN (LETT #1# |res|) (GO #18#))))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #18# (EXIT #1#)))) 

(SDEFUN |GUESSEB;guessBinRatAux!0| ((|z1| NIL) ($$ NIL))
        (PROG (|list| $ |xValues| |a1| A |ext|)
          (LETT |list| (QREFELT $$ 5))
          (LETT $ (QREFELT $$ 4))
          (LETT |xValues| (QREFELT $$ 3))
          (LETT |a1| (QREFELT $$ 2))
          (LETT A (QREFELT $$ 1))
          (LETT |ext| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (|GUESSEB;F2FPOLYS| (SPADCALL |list| |z1| (QREFELT $ 31)) $)
             (SPADCALL (SPADCALL |xValues| |z1| (QREFELT $ 15)) |a1| A |ext|)
             (QREFELT $ 187)))))) 

(SDEFUN |GUESSEB;guessBinRatAux0|
        ((|list| (|List| F)) (|basis| (|Mapping| EXPRR EXPRR))
         (|ext|
          (|Mapping|
           (|Fraction|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A))))
           (|Integer|) (|OrderedVariableList| (|construct| '|a1| 'A))
           (|OrderedVariableList| (|construct| '|a1| 'A))))
         (|extEXPR| (|Mapping| EXPRR (|Symbol|) F F))
         (|options| (|List| (|GuessOption|))) ($ (|List| EXPRR)))
        (SPROG
         ((|res| (|List| EXPRR)) (#1=#:G1033 NIL) (|f| NIL) (#2=#:G1032 NIL)
          (|xValues| (|List| (|Integer|))) (|newlist| (|List| F))
          (|i| (|Integer|)) (#3=#:G1031 NIL) (|x| NIL) (|zeros| (EXPRR))
          (#4=#:G1030 NIL) (|shortlist| (|List| F)) (#5=#:G1009 NIL)
          (#6=#:G1029 NIL) (|len| (|Integer|)) (|xx| (|Symbol|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((ZEROP (SPADCALL |options| (QREFELT $ 163)))
              (|error| "Guess: guessBinRat does not support zero safety")))
            (LETT |xx| (SPADCALL |options| (QREFELT $ 164)))
            (LETT |len| (LENGTH |list|))
            (COND
             ((< (+ (- |len| (SPADCALL |options| (QREFELT $ 163))) 1) 0)
              (PROGN (LETT #6# NIL) (GO #7=#:G1028))))
            (LETT |shortlist|
                  (SPADCALL |list|
                            (PROG1
                                (LETT #5#
                                      (+
                                       (- |len|
                                          (SPADCALL |options| (QREFELT $ 163)))
                                       1))
                              (|check_subtype2| (>= #5# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #5#))
                            (QREFELT $ 165)))
            (LETT |zeros| (|spadConstant| $ 166)) (LETT |i| -1)
            (SEQ (LETT |x| NIL) (LETT #4# |shortlist|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL)) (GO G191)))
                 (SEQ (LETT |i| (+ |i| 1))
                      (EXIT
                       (COND
                        ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 167))
                         (LETT |zeros|
                               (SPADCALL |zeros|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |xx| (QREFELT $ 21))
                                           |basis|)
                                          (SPADCALL
                                           (SPADCALL |i| (QREFELT $ 22))
                                           |basis|)
                                          (QREFELT $ 110))
                                         (QREFELT $ 58)))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (LETT |i| -1)
            (SEQ (LETT |x| NIL) (LETT #3# |shortlist|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ (LETT |i| (+ |i| 1))
                      (EXIT
                       (COND
                        ((SPADCALL |x| (|spadConstant| $ 24) (QREFELT $ 33))
                         (SEQ
                          (LETT |newlist|
                                (CONS
                                 (SPADCALL |x|
                                           (SPADCALL
                                            (SPADCALL |zeros|
                                                      (SPADCALL |xx|
                                                                (QREFELT $ 21))
                                                      (SPADCALL |i|
                                                                (QREFELT $ 22))
                                                      (QREFELT $ 23))
                                            (QREFELT $ 9))
                                           (QREFELT $ 146))
                                 |newlist|))
                          (EXIT (LETT |xValues| (CONS |i| |xValues|))))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (LETT |newlist| (REVERSE |newlist|))
            (LETT |xValues| (REVERSE |xValues|))
            (LETT |res|
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |f| NIL)
                        (LETT #1#
                              (|GUESSEB;guessBinRatAux| |xx| |newlist| |basis|
                               |ext| |extEXPR| |xValues| |options| $))
                        G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS
                                 (SPADCALL
                                  (SPADCALL |zeros| |f| (QREFELT $ 58))
                                  (SPADCALL |xx| (QREFELT $ 21))
                                  (SPADCALL |xx| (QREFELT $ 21))
                                  (QREFELT $ 23))
                                 #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#)))))
            (EXIT
             (SPADCALL
              (CONS #'|GUESSEB;guessBinRatAux0!0|
                    (VECTOR |options| $ |list| |len| |xx|))
              |res| (QREFELT $ 172)))))
          #7# (EXIT #6#)))) 

(SDEFUN |GUESSEB;guessBinRatAux0!0| ((|z1| NIL) ($$ NIL))
        (PROG (|xx| |len| |list| $ |options|)
          (LETT |xx| (QREFELT $$ 4))
          (LETT |len| (QREFELT $$ 3))
          (LETT |list| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |options| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|GUESSEB;checkResult| |z1| |xx| |len| |list| $)
                      (SPADCALL |len| (SPADCALL |options| (QREFELT $ 163))
                                (QREFELT $ 168))
                      (QREFELT $ 169)))))) 

(SDEFUN |GUESSEB;guessBinRat;LLL;26|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (|GUESSEB;guessBinRatAux0| |list|
         (CONS (|function| |GUESSEB;defaultD|) $)
         (CONS (|function| |GUESSEB;binExt|) $)
         (CONS (|function| |GUESSEB;binExtEXPR|) $) |options| $)) 

(SDEFUN |GUESSEB;qD| ((|q| (|Symbol|)) ($ (|Mapping| EXPRR EXPRR)))
        (SPROG NIL (CONS #'|GUESSEB;qD!0| (VECTOR $ |q|)))) 

(SDEFUN |GUESSEB;qD!0| ((|z1| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |q| (QREFELT $ 21)) |z1| (QREFELT $ 161)))))) 

(SDEFUN |GUESSEB;qBinExtAux|
        ((|q| (|Symbol|)) (|i| (|Integer|))
         (|va1| (|OrderedVariableList| (|construct| '|a1| 'A)))
         (|vA| (|OrderedVariableList| (|construct| '|a1| 'A)))
         ($
          (|Fraction|
           (|SparseMultivariatePolynomial| S
                                           (|OrderedVariableList|
                                            (|construct| '|a1| 'A))))))
        (SPROG
         ((|fl|
           (|List|
            (|Fraction|
             (|SparseMultivariatePolynomial| S
                                             (|OrderedVariableList|
                                              (|construct| '|a1| 'A))))))
          (#1=#:G1051 NIL) (|l| NIL) (#2=#:G1050 NIL))
         (SEQ
          (LETT |fl|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |l| 1) (LETT #1# |i|) G190
                      (COND ((|greater_SI| |l| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 190)
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |va1| (QREFELT $ 105))
                                             (QREFELT $ 106))
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |vA| (QREFELT $ 105))
                                              (QREFELT $ 106))
                                             (- |i| 1) (QREFELT $ 113))
                                            (QREFELT $ 108))
                                           (SPADCALL
                                            (|GUESSEB;F2FPOLYS|
                                             (SPADCALL |q| (QREFELT $ 191)) $)
                                            |l| (QREFELT $ 113))
                                           (QREFELT $ 108))
                                          (QREFELT $ 131))
                                (SPADCALL (|spadConstant| $ 190)
                                          (SPADCALL
                                           (|GUESSEB;F2FPOLYS|
                                            (SPADCALL |q| (QREFELT $ 191)) $)
                                           |l| (QREFELT $ 113))
                                          (QREFELT $ 131))
                                (QREFELT $ 187))
                               #2#))))
                      (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (SPADCALL (ELT $ 108) |fl| (|spadConstant| $ 190)
                     (QREFELT $ 193)))))) 

(SDEFUN |GUESSEB;qBinExt|
        ((|q| (|Symbol|))
         ($
          (|Mapping|
           (|Fraction|
            (|SparseMultivariatePolynomial| S
                                            (|OrderedVariableList|
                                             (|construct| '|a1| 'A))))
           (|Integer|) (|OrderedVariableList| (|construct| '|a1| 'A))
           (|OrderedVariableList| (|construct| '|a1| 'A)))))
        (SPROG NIL (CONS #'|GUESSEB;qBinExt!0| (VECTOR $ |q|)))) 

(SDEFUN |GUESSEB;qBinExt!0| ((|z1| NIL) (|z2| NIL) (|z3| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESSEB;qBinExtAux| |q| |z1| |z2| |z3| $))))) 

(SDEFUN |GUESSEB;qBinExtEXPRaux|
        ((|q| (|Symbol|)) (|i| (|Symbol|)) (|a1v| (F)) (|Av| (F)) ($ (EXPRR)))
        (SPROG ((|l| (|Symbol|)))
               (SEQ (LETT |l| '|l|)
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 166)
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a1v| (QREFELT $ 10))
                                            (SPADCALL
                                             (SPADCALL |Av| (QREFELT $ 10))
                                             (SPADCALL
                                              (SPADCALL |i| (QREFELT $ 21))
                                              (|spadConstant| $ 166)
                                              (QREFELT $ 110))
                                             (QREFELT $ 161))
                                            (QREFELT $ 58))
                                  (SPADCALL (SPADCALL |q| (QREFELT $ 21))
                                            (SPADCALL |l| (QREFELT $ 21))
                                            (QREFELT $ 161))
                                  (QREFELT $ 58))
                                 (QREFELT $ 110))
                       (SPADCALL (|spadConstant| $ 166)
                                 (SPADCALL (SPADCALL |q| (QREFELT $ 21))
                                           (SPADCALL |l| (QREFELT $ 21))
                                           (QREFELT $ 161))
                                 (QREFELT $ 110))
                       (QREFELT $ 32))
                      (SPADCALL |l|
                                (SPADCALL (|spadConstant| $ 166)
                                          (SPADCALL |i| (QREFELT $ 21))
                                          (QREFELT $ 195))
                                (QREFELT $ 197))
                      (QREFELT $ 199)))))) 

(SDEFUN |GUESSEB;qBinExtEXPR|
        ((|q| (|Symbol|)) ($ (|Mapping| EXPRR (|Symbol|) F F)))
        (SPROG NIL (CONS #'|GUESSEB;qBinExtEXPR!0| (VECTOR $ |q|)))) 

(SDEFUN |GUESSEB;qBinExtEXPR!0| ((|z1| NIL) (|z2| NIL) (|z3| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESSEB;qBinExtEXPRaux| |q| |z1| |z2| |z3| $))))) 

(SDEFUN |GUESSEB;guessBinRat;SM;32|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (CONS #'|GUESSEB;guessBinRat;SM;32!0| (VECTOR $ |q|)))) 

(SDEFUN |GUESSEB;guessBinRat;SM;32!0| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESSEB;guessBinRatAux0| |z1| (|GUESSEB;qD| |q| $)
             (|GUESSEB;qBinExt| |q| $) (|GUESSEB;qBinExtEXPR| |q| $) |z2| $))))) 

(DECLAIM (NOTINLINE |GuessExpBin;|)) 

(DEFUN |GuessExpBin| (&REST #1=#:G1067)
  (SPROG NIL
         (PROG (#2=#:G1068)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T T NIL NIL))
                     (HGET |$ConstructorCache| '|GuessExpBin|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GuessExpBin;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|GuessExpBin|)))))))))) 

(DEFUN |GuessExpBin;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 |#4|)
    (LETT DV$5 |#5|)
    (LETT |dv$| (LIST '|GuessExpBin| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 201))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2|
                                                        '(|RetractableTo|
                                                          (|Symbol|))))))))
    (|haddProp| |$ConstructorCache| '|GuessExpBin|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (QSETREFV $ 175
                  (CONS (|dispatchFunction| |GUESSEB;guessExpRat;SM;21|)
                        $))))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (PROGN
         (QSETREFV $ 200
                   (CONS (|dispatchFunction| |GUESSEB;guessBinRat;SM;32|)
                         $)))))))
    $))) 

(MAKEPROP '|GuessExpBin| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (0 . |One|)
              (4 . |One|) (|Integer|) (|List| 13) (8 . |elt|) (14 . +)
              (|Mapping| 13 13 13) (20 . |reduce|) (27 . |denominator|)
              (|Symbol|) (32 . |coerce|) (37 . |coerce|) (42 . |eval|)
              (49 . |Zero|) (53 . |Zero|) (57 . |Zero|) (|Boolean|) (61 . =)
              (67 . |numerator|) (|List| 6) (72 . |elt|) (78 . /) (84 . ~=)
              (|Fraction| 7) (90 . |coerce|) (|SparseUnivariatePolynomial| 6)
              (|Mapping| 6 7) (|SparseUnivariatePolynomial| 7)
              (|SparseUnivariatePolynomialFunctions2| 7 6) (95 . |map|)
              (|String|) (101 . |elt|) (|SparseMultivariatePolynomial| 6 71)
              (107 . |coerce|) (|Fraction| 43) (112 . |coerce|) (117 . |numer|)
              (|SparseMultivariatePolynomial| 7 71) (122 . |coerce|)
              (127 . |denom|) (|Fraction| 48) (132 . /) (138 . |zero?|)
              (143 . |leadingCoefficient|) (|NonNegativeInteger|)
              (148 . |degree|) (153 . ^) (159 . *) (165 . |reductum|) (170 . +)
              (|Fraction| 36) (176 . |numer|) (181 . |denom|)
              (|MPolyCatFunctions2| 71 (|IndexedExponents| 71)
                                    (|IndexedExponents| 71) 7 6 48 43)
              (186 . |map|) (|SparseUnivariatePolynomial| 48) (192 . |zero?|)
              (197 . |Zero|) (201 . |leadingCoefficient|) (|PositiveInteger|)
              (|OrderedVariableList| (NRTEVAL (LIST '|a1| 'A))) (206 . |index|)
              (|List| 71) (211 . |eval|) (218 . |retract|) (223 . |degree|)
              (228 . |monomial|) (234 . |reductum|) (239 . +)
              (|Record| (|:| |num| 81) (|:| |den| 48))
              (|SparseUnivariatePolynomial| 51)
              (|UnivariatePolynomialCommonDenominator| 48 51 81)
              (245 . |splitDenominator|) (250 . *) (256 . |retract|)
              (|Mapping| 48 51) (|SparseUnivariatePolynomialFunctions2| 51 48)
              (261 . |map|) (267 . |coerce|) (|Fraction| 66) (272 . /)
              (278 . |degree|) (284 . |coerce|) (289 . |eval|)
              (296 . |univariate|) (301 . |degree|)
              (306 . |leadingCoefficient|) (311 . ^) (317 . -) (322 . *)
              (328 . |zero?|) (333 . |resultant|) (|Union| $ '"failed")
              (339 . |exquo|) (345 . |coerce|) (350 . |coerce|) (355 . -)
              (361 . *) (367 . +) (373 . -) (379 . |last|) (384 . -) (389 . ^)
              (|Union| 55 '"arbitrary") (|List| (|GuessOption|))
              (|GuessOptionFunctions0|) (395 . |maxDegree|) (400 . |debug|)
              (|OutputForm|) (405 . |coerce|) (|Void|) (|OutputPackage|)
              (410 . |output|) (416 . |output|) (|Fraction| 81) (|List| 51)
              (|FractionFreeFastGaussian| 51 81) (421 . |interpolate|)
              (|Fraction| $) (428 . |elt|) (434 . -) (440 . |numer|) (|List| 7)
              (|NewtonInterpolation| 7) (445 . |newton|) (450 . |gcd|)
              (456 . |primitivePart|) (|Factored| $) (461 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 140) (|:| |factor| 36) (|:| |exponent| 55))
              (|List| 141) (|Factored| 36) (466 . |factorList|)
              (471 . |coefficient|) (477 . /) (483 . -) (488 . |eval|)
              (495 . |zero?|) (500 . |univariate|) (505 . |numer|)
              (510 . |denom|) (515 . /) (521 . |numer|) (526 . |denom|)
              (531 . /) (|Kernel| 8) (537 . |kernel|) (|Kernel| $)
              (542 . |eval|) (549 . ^) (555 . |one|) (560 . |safety|)
              (565 . |indexName|) (570 . |first|) (576 . |One|) (580 . =)
              (586 . -) (592 . <) (|Mapping| 27 8) (|List| 8) (598 . |select|)
              |GUESSEB;guessExpRat;LLL;20| (|Mapping| 171 30 115)
              (604 . |guessExpRat|) (609 . *) (615 . +) (621 . |coerce|)
              (626 . -) (632 . *) (638 . |One|) (|Mapping| 48 48 48)
              (|List| 48) (642 . |reduce|) (649 . |factorial|)
              (654 . |binomial|) (660 . /) (666 . |resultant|)
              |GUESSEB;guessBinRat;LLL;26| (673 . |One|) (677 . |coerce|)
              (|Mapping| 51 51 51) (682 . |reduce|) (|Segment| 8)
              (689 . SEGMENT) (|SegmentBinding| 8) (695 . |equation|)
              (|SegmentBinding| $) (701 . |product|) (707 . |guessBinRat|))
           '#(|guessExpRat| 712 |guessBinRat| 723) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|guessExpRat|
                                 ((|List| |#3|) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessBinRat|
                                 ((|List| |#3|) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessExpRat|
                                 ((|Mapping| (|List| |#3|) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 7 (|RetractableTo| 20))
                                     (|has| 6 (|RetractableTo| 20))))
                              '((|guessBinRat|
                                 ((|Mapping| (|List| |#3|) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 7 (|RetractableTo| 20))
                                     (|has| 6 (|RetractableTo| 20)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 200
                                            '(0 6 0 11 0 7 0 12 2 14 13 0 13 15
                                              2 13 0 0 0 16 3 14 13 17 0 13 18
                                              1 8 0 0 19 1 8 0 20 21 1 8 0 13
                                              22 3 8 0 0 0 0 23 0 6 0 24 0 7 0
                                              25 0 8 0 26 2 8 27 0 0 28 1 8 0 0
                                              29 2 30 6 0 13 31 2 8 0 0 0 32 2
                                              6 27 0 0 33 1 34 0 7 35 2 39 36
                                              37 38 40 2 41 0 0 0 42 1 43 0 6
                                              44 1 45 0 43 46 1 34 7 0 47 1 48
                                              0 7 49 1 34 7 0 50 2 51 0 48 48
                                              52 1 36 27 0 53 1 36 6 0 54 1 36
                                              55 0 56 2 8 0 0 55 57 2 8 0 0 0
                                              58 1 36 0 0 59 2 8 0 0 0 60 1 61
                                              36 0 62 1 61 36 0 63 2 64 43 37
                                              48 65 1 66 27 0 67 0 36 0 68 1 66
                                              48 0 69 1 71 0 70 72 3 43 0 0 73
                                              30 74 1 43 6 0 75 1 66 55 0 76 2
                                              36 0 6 55 77 1 66 0 0 78 2 36 0 0
                                              0 79 1 82 80 81 83 2 51 0 0 48 84
                                              1 51 48 0 85 2 87 66 86 81 88 1
                                              66 0 48 89 2 90 0 66 66 91 2 48
                                              55 0 71 92 1 7 0 13 93 3 48 0 0
                                              71 7 94 1 48 38 0 95 1 38 55 0 96
                                              1 38 7 0 97 2 7 0 0 55 98 1 7 0 0
                                              99 2 7 0 0 0 100 1 7 27 0 101 2
                                              38 7 0 0 102 2 7 103 0 0 104 1 48
                                              0 71 105 1 51 0 48 106 2 6 0 0 0
                                              107 2 51 0 0 0 108 2 51 0 0 0 109
                                              2 8 0 0 0 110 1 14 13 0 111 1 13
                                              0 0 112 2 51 0 0 13 113 1 116 114
                                              115 117 1 116 27 115 118 1 55 119
                                              0 120 2 122 121 41 119 123 1 122
                                              121 41 124 3 127 125 126 126 55
                                              128 2 81 51 129 51 130 2 51 0 0 0
                                              131 1 51 48 0 132 1 134 38 133
                                              135 2 38 0 0 0 136 1 38 0 0 137 1
                                              36 138 0 139 1 143 142 0 144 2 36
                                              6 0 55 145 2 6 0 0 0 146 1 6 0 0
                                              147 3 43 0 0 71 6 148 1 43 27 0
                                              149 1 43 36 0 150 1 125 81 0 151
                                              1 125 81 0 152 2 90 0 0 0 153 1
                                              90 66 0 154 1 90 66 0 155 2 61 0
                                              36 36 156 1 157 0 20 158 3 8 0 0
                                              159 0 160 2 8 0 0 0 161 1 116 27
                                              115 162 1 116 55 115 163 1 116 20
                                              115 164 2 30 0 0 55 165 0 8 0 166
                                              2 6 27 0 0 167 2 13 0 0 0 168 2
                                              13 27 0 0 169 2 171 0 170 0 172 1
                                              0 174 20 175 2 48 0 13 0 176 2 48
                                              0 0 0 177 1 48 0 13 178 2 48 0 0
                                              0 179 2 48 0 0 0 180 0 48 0 181 3
                                              183 48 182 0 48 184 1 13 0 0 185
                                              2 8 0 0 0 186 2 51 0 0 0 187 3 48
                                              0 0 0 71 188 0 51 0 190 1 6 0 20
                                              191 3 126 51 192 0 51 193 2 194 0
                                              8 8 195 2 196 0 20 194 197 2 8 0
                                              0 198 199 1 0 174 20 200 1 1 174
                                              20 175 2 0 171 30 115 173 1 1 174
                                              20 200 2 0 171 30 115 189)))))
           '|lookupComplete|)) 
