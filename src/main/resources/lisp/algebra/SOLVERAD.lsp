
(SDEFUN |SOLVERAD;New| ((|s| (|Expression| R)) ($ (|Expression| R)))
        (SPROG ((S (|Expression| R)))
               (SEQ
                (COND
                 ((SPADCALL |s| (|spadConstant| $ 13) (QREFELT $ 15))
                  (|spadConstant| $ 13))
                 ('T
                  (SEQ
                   (LETT S
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL (QREFELT $ 17)) (QREFELT $ 19))
                           (QREFELT $ 21))
                          (QREFELT $ 22)))
                   (SETELT $ 7
                           (SPADCALL (LIST (SPADCALL S |s| (QREFELT $ 23)))
                                     (QREFELT $ 7) (QREFELT $ 25)))
                   (EXIT S))))))) 

(SDEFUN |SOLVERAD;linear|
        ((|u| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         ($ (|List| (|Expression| R))))
        (LIST
         (SPADCALL
          (SPADCALL (SPADCALL (SPADCALL |u| 0 (QREFELT $ 28)) (QREFELT $ 29))
                    (QREFELT $ 30))
          (SPADCALL (SPADCALL |u| 1 (QREFELT $ 28)) (QREFELT $ 30))
          (QREFELT $ 33)))) 

(SDEFUN |SOLVERAD;quadratic|
        ((|u| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         ($ (|List| (|Expression| R))))
        (SPADCALL (SPADCALL (ELT $ 30) |u| (QREFELT $ 37)) (QREFELT $ 40))) 

(SDEFUN |SOLVERAD;cubic|
        ((|u| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         ($ (|List| (|Expression| R))))
        (SPADCALL (SPADCALL (ELT $ 30) |u| (QREFELT $ 37)) (QREFELT $ 41))) 

(SDEFUN |SOLVERAD;quartic|
        ((|u| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         ($ (|List| (|Expression| R))))
        (SPADCALL (SPADCALL (ELT $ 30) |u| (QREFELT $ 37)) (QREFELT $ 42))) 

(SDEFUN |SOLVERAD;rad| ((|n| (|PositiveInteger|)) ($ (|Expression| R)))
        (SPADCALL |n| (QREFELT $ 44))) 

(SDEFUN |SOLVERAD;wrap| ((|s| (|Expression| R)) ($ (|Expression| R)))
        (COND ((QREFELT $ 8) (|SOLVERAD;New| |s| $)) ('T |s|))) 

(SDEFUN |SOLVERAD;findGenZeros|
        ((|rlp| (|List| (|Polynomial| R))) (|rlv| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Expression| R)))))
        (SPROG
         ((|res| (|List| (|List| (|Expression| R)))) (#1=#:G748 NIL) (|vv| NIL)
          (#2=#:G749 NIL) (|p| NIL) (#3=#:G747 NIL) (#4=#:G746 NIL) (|r| NIL)
          (#5=#:G745 NIL) (|v| (|Symbol|)) (|pp| (|Polynomial| R)))
         (SEQ (LETT |pp| (|SPADfirst| |rlp|)) (LETT |v| (|SPADfirst| |rlv|))
              (LETT |rlv| (CDR |rlv|)) (LETT |res| NIL)
              (LETT |res|
                    (SPADCALL
                     (PROGN
                      (LETT #5# NIL)
                      (SEQ (LETT |r| NIL)
                           (LETT #4#
                                 (SPADCALL (SPADCALL |pp| (QREFELT $ 21)) |v|
                                           (QREFELT $ 45)))
                           G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |r| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #5#
                                   (CONS
                                    (REVERSE
                                     (CONS |r|
                                           (PROGN
                                            (LETT #3# NIL)
                                            (SEQ (LETT |p| NIL)
                                                 (LETT #2# (CDR |rlp|))
                                                 (LETT |vv| NIL)
                                                 (LETT #1# |rlv|) G190
                                                 (COND
                                                  ((OR (ATOM #1#)
                                                       (PROGN
                                                        (LETT |vv| (CAR #1#))
                                                        NIL)
                                                       (ATOM #2#)
                                                       (PROGN
                                                        (LETT |p| (CAR #2#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #3#
                                                         (CONS
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL |p|
                                                                         |vv|
                                                                         (QREFELT
                                                                          $
                                                                          47))
                                                               0
                                                               (QREFELT $ 28))
                                                              (QREFELT $ 30))
                                                             (QREFELT $ 48))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL |p|
                                                                        |vv|
                                                                        (QREFELT
                                                                         $ 47))
                                                              (QREFELT $ 49))
                                                             (QREFELT $ 30))
                                                            (QREFELT $ 33))
                                                           (SPADCALL |v|
                                                                     (QREFELT $
                                                                              51))
                                                           |r| (QREFELT $ 53))
                                                          #3#))))
                                                 (LETT #1#
                                                       (PROG1 (CDR #1#)
                                                         (LETT #2# (CDR #2#))))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #3#))))))
                                    #5#))))
                           (LETT #4# (CDR #4#)) (GO G190) G191
                           (EXIT (NREVERSE #5#))))
                     |res| (QREFELT $ 55)))
              (EXIT |res|)))) 

(SDEFUN |SOLVERAD;findZeros|
        ((|rlp| (|List| (|Polynomial| R))) (|rlv| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Expression| R)))))
        (SPROG
         ((|res| (|List| (|List| (|Expression| R))))
          (|rlv1| (|List| (|Symbol|)))
          (|lv1| (|List| (|Kernel| (|Expression| R))))
          (|p1| (|List| (|Expression| R))) (|res1| (|List| (|Expression| R)))
          (#1=#:G763 NIL) (|par| NIL)
          (|parRes| (|List| (|List| (|Expression| R)))) (#2=#:G761 NIL)
          (|p| NIL) (#3=#:G762 NIL) (|v| NIL) (#4=#:G760 NIL))
         (SEQ
          (LETT |parRes|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |v| NIL) (LETT #3# |rlv|) (LETT |p| NIL)
                      (LETT #2# |rlp|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL)
                            (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (SPADCALL (SPADCALL |p| (QREFELT $ 21)) |v|
                                         (QREFELT $ 45))
                               #4#))))
                      (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                      (GO G190) G191 (EXIT (NREVERSE #4#)))))
          (LETT |parRes| (|SOLVERAD;select| |parRes| $)) (LETT |res| NIL)
          (SEQ (LETT |par| NIL) (LETT #1# |parRes|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |par| (CAR #1#)) NIL)) (GO G191)))
               (SEQ (LETT |res1| (LIST (|SPADfirst| |par|)))
                    (LETT |lv1|
                          (LIST (SPADCALL (|SPADfirst| |rlv|) (QREFELT $ 51))))
                    (LETT |rlv1| (CDR |rlv|)) (LETT |p1| (CDR |par|))
                    (SEQ G190
                         (COND
                          ((NULL (SPADCALL |p1| NIL (QREFELT $ 56)))
                           (GO G191)))
                         (SEQ
                          (LETT |res1|
                                (CONS
                                 (SPADCALL (|SPADfirst| |p1|) |lv1| |res1|
                                           (QREFELT $ 59))
                                 |res1|))
                          (LETT |p1| (CDR |p1|))
                          (LETT |lv1|
                                (CONS
                                 (SPADCALL (|SPADfirst| |rlv1|) (QREFELT $ 51))
                                 |lv1|))
                          (EXIT (LETT |rlv1| (CDR |rlv1|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |res| (CONS |res1| |res|))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |SOLVERAD;radicalSolve;FSL;10|
        ((|pol| (|Fraction| (|Polynomial| R))) (|v| (|Symbol|))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG ((#1=#:G768 NIL) (|r| NIL) (#2=#:G767 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |r| NIL)
                      (LETT #1# (SPADCALL |pol| |v| (QREFELT $ 45))) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |v| (QREFELT $ 60)) |r|
                                         (QREFELT $ 61))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SOLVERAD;radicalSolve;FL;11|
        ((|p| (|Fraction| (|Polynomial| R)))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG ((|lv| (|List| (|Symbol|))))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 63))
                  (|error| "equation is always satisfied"))
                 (#1='T
                  (SEQ
                   (LETT |lv|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |p| (QREFELT $ 64))
                                     (QREFELT $ 66))
                           (SPADCALL (SPADCALL |p| (QREFELT $ 67))
                                     (QREFELT $ 66))
                           (QREFELT $ 68))
                          (QREFELT $ 69)))
                   (EXIT
                    (COND ((NULL |lv|) (|error| "inconsistent equation"))
                          ((> (LENGTH |lv|) 1) (|error| "too many variables"))
                          (#1#
                           (SPADCALL |p| (|SPADfirst| |lv|)
                                     (QREFELT $ 62))))))))))) 

(SDEFUN |SOLVERAD;radicalSolve;EL;12|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| R))))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPADCALL
         (SPADCALL (SPADCALL |eq| (QREFELT $ 72))
                   (SPADCALL |eq| (QREFELT $ 73)) (QREFELT $ 74))
         (QREFELT $ 70))) 

(SDEFUN |SOLVERAD;radicalSolve;ESL;13|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| R)))) (|v| (|Symbol|))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPADCALL
         (SPADCALL (SPADCALL |eq| (QREFELT $ 72))
                   (SPADCALL |eq| (QREFELT $ 73)) (QREFELT $ 74))
         |v| (QREFELT $ 62))) 

(SDEFUN |SOLVERAD;radicalRoots;LLL;14|
        ((|lp| (|List| (|Fraction| (|Polynomial| R))))
         (|lv| (|List| (|Symbol|))) ($ (|List| (|List| (|Expression| R)))))
        (SPROG
         ((#1=#:G795 NIL) (#2=#:G794 #3=(|List| (|List| (|Expression| R))))
          (#4=#:G796 #3#) (#5=#:G805 NIL) (|res| NIL)
          (|rpRes| (|List| #6=(|List| (|Polynomial| R)))) (#7=#:G804 NIL)
          (|result| (|List| (|List| (|Expression| R)))) (#8=#:G788 NIL)
          (#9=#:G787 #10=(|List| (|List| (|Expression| R)))) (#11=#:G789 #10#)
          (#12=#:G803 NIL) (|listGen| (|List| #6#)) (#13=#:G802 NIL)
          (#14=#:G801 NIL) (#15=#:G800 NIL) (#16=#:G799 NIL)
          (|rlv| (|List| (|Symbol|)))
          (|parRes| (|List| (|List| (|Polynomial| R)))))
         (SEQ (LETT |parRes| (SPADCALL |lp| |lv| (QREFELT $ 80)))
              (LETT |rlv| (REVERSE |lv|))
              (LETT |rpRes|
                    (PROGN
                     (LETT #16# NIL)
                     (SEQ (LETT |res| NIL) (LETT #15# |parRes|) G190
                          (COND
                           ((OR (ATOM #15#)
                                (PROGN (LETT |res| (CAR #15#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #16# (CONS (REVERSE |res|) #16#))))
                          (LETT #15# (CDR #15#)) (GO G190) G191
                          (EXIT (NREVERSE #16#)))))
              (LETT |listGen|
                    (PROGN
                     (LETT #14# NIL)
                     (SEQ (LETT |res| NIL) (LETT #13# |rpRes|) G190
                          (COND
                           ((OR (ATOM #13#)
                                (PROGN (LETT |res| (CAR #13#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((|SOLVERAD;isGeneric?| |res| |rlv| $)
                              (LETT #14# (CONS |res| #14#))))))
                          (LETT #13# (CDR #13#)) (GO G190) G191
                          (EXIT (NREVERSE #14#)))))
              (LETT |result| NIL)
              (COND
               ((SPADCALL |listGen| NIL (QREFELT $ 81))
                (SEQ
                 (LETT |result|
                       (PROGN
                        (LETT #8# NIL)
                        (SEQ (LETT |res| NIL) (LETT #12# |listGen|) G190
                             (COND
                              ((OR (ATOM #12#)
                                   (PROGN (LETT |res| (CAR #12#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (PROGN
                                (LETT #11#
                                      (|SOLVERAD;findGenZeros| |res| |rlv| $))
                                (COND
                                 (#8#
                                  (LETT #9#
                                        (SPADCALL #9# #11# (QREFELT $ 55))))
                                 ('T (PROGN (LETT #9# #11#) (LETT #8# 'T)))))))
                             (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
                        (COND (#8# #9#) (#17='T NIL))))
                 (EXIT
                  (SEQ (LETT |res| NIL) (LETT #7# |listGen|) G190
                       (COND
                        ((OR (ATOM #7#) (PROGN (LETT |res| (CAR #7#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |rpRes|
                               (SPADCALL |rpRes|
                                         (SPADCALL |res| |rpRes|
                                                   (QREFELT $ 83))
                                         (QREFELT $ 84)))))
                       (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))))))
              (EXIT
               (COND ((SPADCALL |rpRes| NIL (QREFELT $ 85)) |result|)
                     (#17#
                      (SPADCALL
                       (PROGN
                        (LETT #1# NIL)
                        (SEQ (LETT |res| NIL) (LETT #5# |rpRes|) G190
                             (COND
                              ((OR (ATOM #5#)
                                   (PROGN (LETT |res| (CAR #5#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (PROGN
                                (LETT #4# (|SOLVERAD;findZeros| |res| |rlv| $))
                                (COND
                                 (#1#
                                  (LETT #2# (SPADCALL #2# #4# (QREFELT $ 55))))
                                 ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                             (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                        (COND (#1# #2#) (#17# NIL)))
                       |result| (QREFELT $ 55)))))))) 

(SDEFUN |SOLVERAD;radicalSolve;LLL;15|
        ((|lp| (|List| (|Fraction| (|Polynomial| R))))
         (|lv| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG ((#1=#:G810 NIL) (|lres| NIL) (#2=#:G809 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |lres| NIL)
                      (LETT #1# (SPADCALL |lp| |lv| (QREFELT $ 86))) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |lres| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (|SOLVERAD;makeEq| |lres| |lv| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SOLVERAD;radicalSolve;LL;16|
        ((|lp| (|List| (|Fraction| (|Polynomial| R))))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((#1=#:G820 NIL) (|lres| NIL) (#2=#:G819 NIL)
          (|lv| #3=(|List| (|Symbol|))) (#4=#:G812 NIL) (#5=#:G811 #3#)
          (#6=#:G813 #3#) (#7=#:G818 NIL) (|p| NIL))
         (SEQ
          (LETT |lv|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |p| NIL) (LETT #7# |lp|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |p| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #6#
                               (SPADCALL
                                (SPADCALL (SPADCALL |p| (QREFELT $ 64))
                                          (QREFELT $ 66))
                                (SPADCALL (SPADCALL |p| (QREFELT $ 67))
                                          (QREFELT $ 66))
                                (QREFELT $ 89)))
                         (COND
                          (#4# (LETT #5# (SPADCALL #5# #6# (QREFELT $ 89))))
                          ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                      (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                 (COND (#4# #5#) ('T (|IdentityError| '|setUnion|)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |lres| NIL)
                 (LETT #1# (SPADCALL |lp| |lv| (QREFELT $ 86))) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |lres| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (|SOLVERAD;makeEq| |lres| |lv| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |SOLVERAD;radicalSolve;LLL;17|
        ((|le| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
         (|lv| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((#1=#:G830 NIL) (|lres| NIL) (#2=#:G829 NIL)
          (|lp| (|List| (|Fraction| (|Polynomial| R)))) (#3=#:G828 NIL)
          (|p| NIL) (#4=#:G827 NIL))
         (SEQ
          (LETT |lp|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |p| NIL) (LETT #3# |le|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (SPADCALL (SPADCALL |p| (QREFELT $ 73))
                                         (SPADCALL |p| (QREFELT $ 72))
                                         (QREFELT $ 74))
                               #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |lres| NIL)
                 (LETT #1# (SPADCALL |lp| |lv| (QREFELT $ 86))) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |lres| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (|SOLVERAD;makeEq| |lres| |lv| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |SOLVERAD;radicalSolve;LL;18|
        ((|le| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))
         ($ (|List| (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((#1=#:G844 NIL) (|lres| NIL) (#2=#:G843 NIL)
          (|lv| #3=(|List| (|Symbol|))) (#4=#:G834 NIL) (#5=#:G833 #3#)
          (#6=#:G835 #3#) (#7=#:G842 NIL) (|p| NIL)
          (|lp| (|List| (|Fraction| (|Polynomial| R)))) (#8=#:G841 NIL)
          (#9=#:G840 NIL))
         (SEQ
          (LETT |lp|
                (PROGN
                 (LETT #9# NIL)
                 (SEQ (LETT |p| NIL) (LETT #8# |le|) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |p| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #9#
                              (CONS
                               (SPADCALL (SPADCALL |p| (QREFELT $ 73))
                                         (SPADCALL |p| (QREFELT $ 72))
                                         (QREFELT $ 74))
                               #9#))))
                      (LETT #8# (CDR #8#)) (GO G190) G191
                      (EXIT (NREVERSE #9#)))))
          (LETT |lv|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |p| NIL) (LETT #7# |lp|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |p| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #6#
                               (SPADCALL
                                (SPADCALL (SPADCALL |p| (QREFELT $ 64))
                                          (QREFELT $ 66))
                                (SPADCALL (SPADCALL |p| (QREFELT $ 67))
                                          (QREFELT $ 66))
                                (QREFELT $ 89)))
                         (COND
                          (#4# (LETT #5# (SPADCALL #5# #6# (QREFELT $ 89))))
                          ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                      (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                 (COND (#4# #5#) ('T (|IdentityError| '|setUnion|)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |lres| NIL)
                 (LETT #1# (SPADCALL |lp| |lv| (QREFELT $ 86))) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |lres| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (|SOLVERAD;makeEq| |lres| |lv| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |SOLVERAD;contractSolve;ESSt;19|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| R)))) (|v| (|Symbol|))
         ($
          (|SuchThat| (|List| (|Expression| R))
                      (|List| (|Equation| (|Expression| R))))))
        (|SOLVERAD;solveInner|
         (SPADCALL
          (SPADCALL (SPADCALL |eq| (QREFELT $ 72))
                    (SPADCALL |eq| (QREFELT $ 73)) (QREFELT $ 74))
          (QREFELT $ 64))
         |v| 'T $)) 

(SDEFUN |SOLVERAD;contractSolve;FSSt;20|
        ((|pq| (|Fraction| (|Polynomial| R))) (|v| (|Symbol|))
         ($
          (|SuchThat| (|List| (|Expression| R))
                      (|List| (|Equation| (|Expression| R))))))
        (|SOLVERAD;solveInner| (SPADCALL |pq| (QREFELT $ 64)) |v| 'T $)) 

(SDEFUN |SOLVERAD;radicalRoots;FSL;21|
        ((|pq| (|Fraction| (|Polynomial| R))) (|v| (|Symbol|))
         ($ (|List| (|Expression| R))))
        (SPADCALL
         (|SOLVERAD;solveInner| (SPADCALL |pq| (QREFELT $ 64)) |v| NIL $)
         (QREFELT $ 97))) 

(SDEFUN |SOLVERAD;isGeneric?|
        ((|rlp| (|List| (|Polynomial| R))) (|rlv| (|List| (|Symbol|)))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G849 NIL) (#2=#:G848 #3=(|Boolean|)) (#4=#:G850 #3#)
          (#5=#:G852 NIL) (|f| NIL) (#6=#:G853 NIL) (|x| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |x| NIL) (LETT #6# (CDR |rlv|)) (LETT |f| NIL)
                (LETT #5# (CDR |rlp|)) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL) (ATOM #6#)
                      (PROGN (LETT |x| (CAR #6#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (EQL (SPADCALL |f| |x| (QREFELT $ 98)) 1))
                   (COND (#1# (LETT #2# (COND (#2# #4#) ('T NIL))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#)))) (GO G190)
                G191 (EXIT NIL))
           (COND (#1# #2#) ('T 'T)))))) 

(SDEFUN |SOLVERAD;select|
        ((|lp| (|List| (|List| (|Expression| R))))
         ($ #1=(|List| (|List| (|Expression| R)))))
        (SPROG
         ((#2=#:G855 NIL) (#3=#:G854 #1#) (#4=#:G856 #1#) (#5=#:G862 NIL)
          (|lsel| NIL) (#6=#:G861 NIL) (#7=#:G860 NIL) (|f| NIL))
         (SEQ
          (COND
           ((SPADCALL |lp| NIL (QREFELT $ 99)) (SPADCALL NIL (QREFELT $ 100)))
           (#8='T
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |f| NIL) (LETT #7# (|SPADfirst| |lp|)) G190
                  (COND
                   ((OR (ATOM #7#) (PROGN (LETT |f| (CAR #7#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (PROGN
                            (LETT #6# NIL)
                            (SEQ (LETT |lsel| NIL)
                                 (LETT #5# (|SOLVERAD;select| (CDR |lp|) $))
                                 G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT |lsel| (CAR #5#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #6# (CONS (CONS |f| |lsel|) #6#))))
                                 (LETT #5# (CDR #5#)) (GO G190) G191
                                 (EXIT (NREVERSE #6#)))))
                     (COND (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 55))))
                           ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                  (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
             (COND (#2# #3#) (#8# NIL)))))))) 

(SDEFUN |SOLVERAD;makeEq|
        ((|nres| (|List| (|Expression| R))) (|lv| (|List| (|Symbol|)))
         ($ (|List| (|Equation| (|Expression| R)))))
        (SPROG
         ((#1=#:G867 NIL) (|x| NIL) (#2=#:G868 NIL) (|r| NIL) (#3=#:G866 NIL))
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
                         (SPADCALL (SPADCALL |x| (QREFELT $ 60)) |r|
                                   (QREFELT $ 61))
                         #3#))))
                (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                G191 (EXIT (NREVERSE #3#))))))) 

(SDEFUN |SOLVERAD;cyclotomic_case?;SupU;25|
        ((|u| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|iu| (|SparseUnivariatePolynomial| (|Integer|))) (#1=#:G879 NIL)
          (|icu| (|Union| (|Integer|) "failed")) (|c| (R))
          (|cp| (|Polynomial| R)))
         (SEQ
          (EXIT
           (SEQ (LETT |iu| (|spadConstant| $ 102))
                (SEQ G190
                     (COND
                      ((NULL
                        (NULL
                         (SPADCALL |u| (|spadConstant| $ 103)
                                   (QREFELT $ 104))))
                       (GO G191)))
                     (SEQ (LETT |cp| (SPADCALL |u| (QREFELT $ 49)))
                          (COND
                           ((NULL (SPADCALL |cp| (QREFELT $ 105)))
                            (EXIT
                             (PROGN
                              (LETT #1# (CONS 1 "failed"))
                              (GO #2=#:G878)))))
                          (LETT |c| (SPADCALL |cp| (QREFELT $ 106)))
                          (LETT |icu| (SPADCALL |c| (QREFELT $ 108)))
                          (EXIT
                           (COND
                            ((QEQCAR |icu| 1)
                             (PROGN (LETT #1# (CONS 1 "failed")) (GO #2#)))
                            ('T
                             (SEQ
                              (LETT |iu|
                                    (SPADCALL |iu|
                                              (SPADCALL (QCDR |icu|)
                                                        (SPADCALL |u|
                                                                  (QREFELT $
                                                                           109))
                                                        (QREFELT $ 110))
                                              (QREFELT $ 111)))
                              (EXIT
                               (LETT |u| (SPADCALL |u| (QREFELT $ 112)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |iu| (QREFELT $ 114)))))
          #2# (EXIT #1#)))) 

(PUT '|SOLVERAD;cyclotomic_case?;SupU;26| '|SPADreplace|
     '(XLAM (|u|) (CONS 1 "failed"))) 

(SDEFUN |SOLVERAD;cyclotomic_case?;SupU;26|
        ((|u| (|SparseUnivariatePolynomial| (|Polynomial| R)))
         ($ (|Union| (|Integer|) "failed")))
        (CONS 1 "failed")) 

(SDEFUN |SOLVERAD;solveInner|
        ((|pq| (|Polynomial| R)) (|v| (|Symbol|)) (|contractFlag| (|Boolean|))
         ($
          (|SuchThat| (|List| (|Expression| R))
                      (|List| (|Equation| (|Expression| R))))))
        (SPROG
         ((|re| (|List| (|Equation| (|Expression| R))))
          (|solutions| (|List| (|Expression| R))) (#1=#:G923 NIL) (|i| NIL)
          (T0 (|List| (|Expression| R))) (|s| (|Expression| R)) (#2=#:G922 NIL)
          (|l| (|List| (|Expression| R)))
          (|unsolved| (|List| (|Polynomial| R))) (#3=#:G921 NIL)
          (#4=#:G904 NIL) (|iu| (|Union| (|Integer|) "failed"))
          (|n| (|NonNegativeInteger|))
          (|u| #5=(|SparseUnivariatePolynomial| (|Polynomial| R)))
          (|t| (|Record| (|:| |pol| #5#) (|:| |deg| (|PositiveInteger|))))
          (|constants| (|List| (|Polynomial| R))) (|ff| #6=(|Polynomial| R))
          (#7=#:G920 NIL) (|f| NIL)
          (|lfactors|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #6#)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ (SETELT $ 7 NIL) (SETELT $ 8 |contractFlag|)
              (LETT |t|
                    (SPADCALL (SPADCALL |pq| |v| (QREFELT $ 47))
                              (QREFELT $ 118)))
              (LETT |u| (QCAR |t|))
              (COND
               ((EQL (SPADCALL |u| (QREFELT $ 109)) 1)
                (COND
                 ((SPADCALL (SPADCALL |u| (QREFELT $ 49))
                            (SPADCALL (SPADCALL |u| 0 (QREFELT $ 28))
                                      (QREFELT $ 29))
                            (QREFELT $ 119))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (|spadConstant| $ 120) (QCDR |t|)
                              (QREFELT $ 122))
                    NIL (QREFELT $ 123)))))))
              (COND
               ((EQL (SPADCALL |u| (QREFELT $ 109)) 1)
                (COND
                 ((SPADCALL (SPADCALL |u| (QREFELT $ 49))
                            (SPADCALL |u| 0 (QREFELT $ 28)) (QREFELT $ 119))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL (|spadConstant| $ 120) (QREFELT $ 48))
                              (QCDR |t|) (QREFELT $ 122))
                    NIL (QREFELT $ 123)))))))
              (LETT |lfactors|
                    (SPADCALL (SPADCALL |pq| (QREFELT $ 126)) (QREFELT $ 130)))
              (LETT |constants| NIL) (LETT |unsolved| NIL)
              (LETT |solutions| NIL)
              (SEQ (LETT |f| NIL) (LETT #7# |lfactors|) G190
                   (COND
                    ((OR (ATOM #7#) (PROGN (LETT |f| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ff| (QVELT |f| 1))
                        (COND
                         ((NULL
                           (SPADCALL |v| (SPADCALL |ff| (QREFELT $ 66))
                                     (QREFELT $ 131)))
                          (EXIT (LETT |constants| (CONS |ff| |constants|)))))
                        (LETT |u| (SPADCALL |ff| |v| (QREFELT $ 47)))
                        (LETT |t| (SPADCALL |u| (QREFELT $ 118)))
                        (LETT |u| (QCAR |t|))
                        (LETT |n| (SPADCALL |u| (QREFELT $ 109)))
                        (LETT |l|
                              (COND ((EQL |n| 1) (|SOLVERAD;linear| |u| $))
                                    ((EQL |n| 2) (|SOLVERAD;quadratic| |u| $))
                                    ('T
                                     (SEQ
                                      (LETT |iu|
                                            (SPADCALL |u| (QREFELT $ 115)))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |iu| 0)
                                         (SEQ
                                          (LETT T0
                                                (SPADCALL
                                                 (* (QCDR |t|)
                                                    (PROG1
                                                        (LETT #4# (QCDR |iu|))
                                                      (|check_subtype2|
                                                       (> #4# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #4#)))
                                                 (QREFELT $ 132)))
                                          (SEQ (LETT |i| 1)
                                               (LETT #3# (QVELT |f| 2)) G190
                                               (COND
                                                ((|greater_SI| |i| #3#)
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT |solutions|
                                                       (SPADCALL T0 |solutions|
                                                                 (QREFELT $
                                                                          133)))))
                                               (LETT |i| (|inc_SI| |i|))
                                               (GO G190) G191 (EXIT NIL))
                                          (EXIT NIL)))
                                        ((EQL |n| 3) (|SOLVERAD;cubic| |u| $))
                                        ((EQL |n| 4)
                                         (|SOLVERAD;quartic| |u| $))
                                        ('T
                                         (SEQ
                                          (LETT |unsolved|
                                                (CONS |ff| |unsolved|))
                                          (EXIT NIL)))))))))
                        (EXIT
                         (SEQ (LETT #2# |l|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |s| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (COND
                                ((> (QCDR |t|) 1)
                                 (LETT |s| (|SOLVERAD;wrap| |s| $))))
                               (LETT T0
                                     (SPADCALL |s| (QCDR |t|) (QREFELT $ 122)))
                               (SEQ (LETT |i| 1) (LETT #1# (QVELT |f| 2)) G190
                                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |solutions|
                                            (SPADCALL T0 |solutions|
                                                      (QREFELT $ 133)))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT (LETT |re| (QREFELT $ 7))))
                              (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |solutions| (QREFELT $ 7) (QREFELT $ 123)))))) 

(DECLAIM (NOTINLINE |RadicalSolvePackage;|)) 

(DEFUN |RadicalSolvePackage| (#1=#:G924)
  (SPROG NIL
         (PROG (#2=#:G925)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RadicalSolvePackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RadicalSolvePackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RadicalSolvePackage|)))))))))) 

(DEFUN |RadicalSolvePackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RadicalSolvePackage| DV$1))
          (LETT $ (GETREFV 134))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RadicalSolvePackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 NIL)
          (QSETREFV $ 8 NIL)
          (COND
           ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
            (QSETREFV $ 115
                      (CONS
                       (|dispatchFunction| |SOLVERAD;cyclotomic_case?;SupU;25|)
                       $)))
           ('T
            (QSETREFV $ 115
                      (CONS
                       (|dispatchFunction| |SOLVERAD;cyclotomic_case?;SupU;26|)
                       $))))
          $))) 

(MAKEPROP '|RadicalSolvePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|SideEquations|
              '|ContractSoln| (0 . |Zero|) (|Equation| 12) (4 . |Zero|)
              (|Expression| 6) (8 . |Zero|) (|Boolean|) (12 . =) (|Symbol|)
              (18 . |new|) (|Polynomial| 6) (22 . |coerce|) (|Fraction| 18)
              (27 . |coerce|) (32 . |coerce|) (37 . =) (|List| 10)
              (43 . |append|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 18) (49 . |coefficient|) (55 . -)
              (60 . |coerce|) (65 . |One|) (69 . |One|) (73 . /)
              (|SparseUnivariatePolynomial| 12) (|Mapping| 12 18)
              (|SparseUnivariatePolynomialFunctions2| 18 12) (79 . |map|)
              (|List| 12) (|PolynomialSolveByFormulas| 34 12 6)
              (85 . |quadratic|) (90 . |cubic|) (95 . |quartic|) (|Integer|)
              (100 . |coerce|) |SOLVERAD;radicalRoots;FSL;21|
              (|SparseUnivariatePolynomial| $) (105 . |univariate|) (111 . -)
              (116 . |leadingCoefficient|) (|Kernel| 12) (121 . |kernel|)
              (|Kernel| $) (126 . |eval|) (|List| 38) (133 . |append|)
              (139 . ~=) (|List| 52) (|List| $) (145 . |eval|) (152 . |coerce|)
              (157 . |equation|) |SOLVERAD;radicalSolve;FSL;10| (163 . |zero?|)
              (168 . |numer|) (|List| 16) (173 . |variables|) (178 . |denom|)
              (183 . |concat|) (189 . |removeDuplicates|)
              |SOLVERAD;radicalSolve;FL;11| (|Equation| 20) (194 . |lhs|)
              (199 . |rhs|) (204 . -) |SOLVERAD;radicalSolve;EL;12|
              |SOLVERAD;radicalSolve;ESL;13| (|List| 82) (|List| 20)
              (|SystemSolvePackage| 6) (210 . |triangularSystems|) (216 . ~=)
              (|List| 18) (222 . |position|) (228 . |delete|) (234 . =)
              |SOLVERAD;radicalRoots;LLL;14| (|List| 24)
              |SOLVERAD;radicalSolve;LLL;15| (240 . |setUnion|)
              |SOLVERAD;radicalSolve;LL;16| (|List| 71)
              |SOLVERAD;radicalSolve;LLL;17| |SOLVERAD;radicalSolve;LL;18|
              (|SuchThat| 38 24) |SOLVERAD;contractSolve;ESSt;19|
              |SOLVERAD;contractSolve;FSSt;20| (246 . |lhs|) (251 . |degree|)
              (257 . =) (263 . |list|) (|SparseUnivariatePolynomial| 43)
              (268 . |Zero|) (272 . |Zero|) (276 . =) (282 . |ground?|)
              (287 . |ground|) (|Union| 43 '"failed") (292 . |retractIfCan|)
              (297 . |degree|) (302 . |monomial|) (308 . +) (314 . |reductum|)
              (|CyclotomicUtilities|) (319 . |cyclotomic?|)
              (324 . |cyclotomic_case?|)
              (|Record| (|:| |pol| 27) (|:| |deg| 121))
              (|DegreeReductionPackage| 18 6) (329 . |reduce|) (334 . =)
              (340 . |One|) (|PositiveInteger|) (344 . |expand|)
              (350 . |construct|) (|Factored| 18)
              (|MultivariateFactorize| 16 (|IndexedExponents| 16) 6 18)
              (356 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 127) (|:| |factor| 18) (|:| |exponent| 26))
              (|List| 128) (361 . |factorList|) (366 . |member?|)
              (372 . |cyclotomic_roots|) (377 . |append|))
           '#(|radicalSolve| 383 |radicalRoots| 427 |cyclotomic_case?| 439
              |contractSolve| 444)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|radicalSolve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|radicalSolve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((|radicalSolve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Equation| (|Fraction| (|Polynomial| |#1|)))
                                  (|Symbol|)))
                                T)
                              '((|radicalSolve|
                                 ((|List| (|Equation| (|Expression| |#1|)))
                                  (|Equation|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|radicalSolve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| (|Symbol|))))
                                T)
                              '((|radicalSolve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|radicalSolve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))
                                  (|List| (|Symbol|))))
                                T)
                              '((|radicalSolve|
                                 ((|List|
                                   (|List| (|Equation| (|Expression| |#1|))))
                                  (|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| |#1|))))))
                                T)
                              '((|radicalRoots|
                                 ((|List| (|Expression| |#1|))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|radicalRoots|
                                 ((|List| (|List| (|Expression| |#1|)))
                                  (|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| (|Symbol|))))
                                T)
                              '((|contractSolve|
                                 ((|SuchThat| (|List| (|Expression| |#1|))
                                              (|List|
                                               (|Equation|
                                                (|Expression| |#1|))))
                                  (|Equation| (|Fraction| (|Polynomial| |#1|)))
                                  (|Symbol|)))
                                T)
                              '((|contractSolve|
                                 ((|SuchThat| (|List| (|Expression| |#1|))
                                              (|List|
                                               (|Equation|
                                                (|Expression| |#1|))))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|cyclotomic_case?|
                                 ((|Union| (|Integer|) "failed")
                                  (|SparseUnivariatePolynomial|
                                   (|Polynomial| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 133
                                            '(0 6 0 9 0 10 0 11 0 12 0 13 2 12
                                              14 0 0 15 0 16 0 17 1 18 0 16 19
                                              1 20 0 18 21 1 12 0 20 22 2 10 0
                                              12 12 23 2 24 0 0 0 25 2 27 18 0
                                              26 28 1 18 0 0 29 1 12 0 18 30 0
                                              6 0 31 0 10 0 32 2 12 0 0 0 33 2
                                              36 34 35 27 37 1 39 38 34 40 1 39
                                              38 34 41 1 39 38 34 42 1 12 0 43
                                              44 2 18 46 0 16 47 1 12 0 0 48 1
                                              27 18 0 49 1 50 0 16 51 3 12 0 0
                                              52 0 53 2 54 0 0 0 55 2 38 14 0 0
                                              56 3 12 0 0 57 58 59 1 12 0 16 60
                                              2 10 0 12 12 61 1 20 14 0 63 1 20
                                              18 0 64 1 18 65 0 66 1 20 18 0 67
                                              2 65 0 0 0 68 1 65 0 0 69 1 71 20
                                              0 72 1 71 20 0 73 2 20 0 0 0 74 2
                                              79 77 78 65 80 2 77 14 0 0 81 2
                                              77 43 82 0 83 2 77 0 0 43 84 2 77
                                              14 0 0 85 2 65 0 0 0 89 1 94 38 0
                                              97 2 18 26 0 16 98 2 54 14 0 0 99
                                              1 54 0 38 100 0 101 0 102 0 27 0
                                              103 2 27 14 0 0 104 1 18 14 0 105
                                              1 18 6 0 106 1 6 107 0 108 1 27
                                              26 0 109 2 101 0 43 26 110 2 101
                                              0 0 0 111 1 27 0 0 112 1 113 107
                                              101 114 1 0 107 27 115 1 117 116
                                              27 118 2 18 14 0 0 119 0 12 0 120
                                              2 117 38 12 121 122 2 94 0 38 24
                                              123 1 125 124 18 126 1 124 129 0
                                              130 2 65 14 16 0 131 1 117 38 121
                                              132 2 38 0 0 0 133 2 0 24 20 16
                                              62 2 0 24 71 16 76 1 0 24 20 70 1
                                              0 24 71 75 1 0 87 78 90 2 0 87 78
                                              65 88 2 0 87 91 65 92 1 0 87 91
                                              93 2 0 38 20 16 45 2 0 54 78 65
                                              86 1 0 107 27 115 2 0 94 71 16 95
                                              2 0 94 20 16 96)))))
           '|lookupComplete|)) 
