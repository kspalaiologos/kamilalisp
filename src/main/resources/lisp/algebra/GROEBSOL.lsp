
(SDEFUN |GROEBSOL;testPower|
        ((|uf|
          (|SparseUnivariatePolynomial|
           (|DistributedMultivariatePolynomial| |lv| F)))
         (|x| (|OrderedVariableList| |lv|))
         (|lpol| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         ($
          (|Union| (|DistributedMultivariatePolynomial| |lv| F) #1="failed")))
        (SPROG
         ((|g| (|DistributedMultivariatePolynomial| |lv| F))
          (|linp|
           (|SparseUnivariatePolynomial|
            (|DistributedMultivariatePolynomial| |lv| F)))
          (|lc| (|DistributedMultivariatePolynomial| |lv| F)) (#2=#:G717 NIL)
          (|trailp| (|DistributedMultivariatePolynomial| |lv| F))
          (|gg| (|DistributedMultivariatePolynomial| |lv| F))
          (|testquo|
           (|Union| (|DistributedMultivariatePolynomial| |lv| F) "failed"))
          (#3=#:G720 NIL) (|df| (|NonNegativeInteger|)))
         (SEQ (LETT |df| (SPADCALL |uf| (QREFELT $ 12)))
              (LETT |trailp|
                    (SPADCALL |uf|
                              (PROG1 (LETT #3# (- |df| 1))
                                (|check_subtype2| (>= #3# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #3#))
                              (QREFELT $ 16)))
              (LETT |testquo|
                    (SPADCALL |trailp| (SPADCALL |df| (QREFELT $ 18))
                              (QREFELT $ 20)))
              (EXIT
               (COND ((QEQCAR |testquo| 1) (CONS 1 "failed"))
                     (#4='T
                      (SEQ (LETT |trailp| (QCDR |testquo|))
                           (LETT |gg|
                                 (SPADCALL
                                  (LETT |lc| (SPADCALL |uf| (QREFELT $ 21)))
                                  |trailp| (QREFELT $ 22)))
                           (LETT |trailp|
                                 (PROG2
                                     (LETT #2#
                                           (SPADCALL |trailp| |gg|
                                                     (QREFELT $ 23)))
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|DistributedMultivariatePolynomial|
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|Union|
                                                    (|DistributedMultivariatePolynomial|
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    #1#)
                                                   #2#)))
                           (LETT |lc|
                                 (PROG2
                                     (LETT #2#
                                           (SPADCALL |lc| |gg| (QREFELT $ 23)))
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|DistributedMultivariatePolynomial|
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|Union|
                                                    (|DistributedMultivariatePolynomial|
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    #1#)
                                                   #2#)))
                           (LETT |linp|
                                 (SPADCALL (SPADCALL |lc| 1 (QREFELT $ 24))
                                           (SPADCALL |trailp| 0 (QREFELT $ 24))
                                           (QREFELT $ 25)))
                           (LETT |g|
                                 (SPADCALL
                                  (SPADCALL |uf|
                                            (SPADCALL |linp| |df|
                                                      (QREFELT $ 26))
                                            (QREFELT $ 27))
                                  |x| (QREFELT $ 30)))
                           (EXIT
                            (COND
                             ((SPADCALL (SPADCALL |g| |lpol| (QREFELT $ 33))
                                        (|spadConstant| $ 34) (QREFELT $ 36))
                              (CONS 1 "failed"))
                             (#4#
                              (CONS 0
                                    (SPADCALL |linp| |x|
                                              (QREFELT $ 30))))))))))))) 

(SDEFUN |GROEBSOL;testGenPos|
        ((|lpol| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         (|lvar| (|List| (|OrderedVariableList| |lv|)))
         ($
          (|Union| (|List| (|DistributedMultivariatePolynomial| |lv| F))
                   "failed")))
        (SPROG
         ((#1=#:G740 NIL) (|rlvar| (|List| (|OrderedVariableList| |lv|)))
          (|newlpol| (|List| #2=(|DistributedMultivariatePolynomial| |lv| F)))
          (|g| (|Union| (|DistributedMultivariatePolynomial| |lv| F) "failed"))
          (|fi|
           (|SparseUnivariatePolynomial|
            (|DistributedMultivariatePolynomial| |lv| F)))
          (|x| (|OrderedVariableList| |lv|)) (#3=#:G741 NIL) (|f| #2#)
          (|rlpol| (|List| (|DistributedMultivariatePolynomial| |lv| F))))
         (SEQ
          (EXIT
           (SEQ (LETT |rlpol| (REVERSE |lpol|))
                (LETT |f| (|SPADfirst| |rlpol|))
                (EXIT
                 (COND ((EQL (LENGTH |lvar|) 1) (CONS 0 (LIST |f|)))
                       ('T
                        (SEQ (LETT |rlvar| (CDR (REVERSE |lvar|)))
                             (LETT |newlpol| (LIST |f|))
                             (SEQ (LETT #3# (CDR |rlpol|)) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |f| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ (LETT |x| (|SPADfirst| |rlvar|))
                                       (LETT |fi|
                                             (SPADCALL |f| |x| (QREFELT $ 37)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR
                                           (SPADCALL
                                            (SPADCALL |fi| (QREFELT $ 21))
                                            (QREFELT $ 39))
                                           1)
                                          (SEQ
                                           (SEQ
                                            (LETT |g|
                                                  (|GROEBSOL;testPower| |fi|
                                                   |x| |newlpol| $))
                                            (EXIT
                                             (COND
                                              ((QEQCAR |g| 1)
                                               (PROGN
                                                (LETT #1# (CONS 1 "failed"))
                                                (GO #4=#:G739))))))
                                           (LETT |newlpol|
                                                 (CONS
                                                  (SPADCALL (QCDR |g|)
                                                            |newlpol|
                                                            (QREFELT $ 33))
                                                  |newlpol|))
                                           (EXIT
                                            (LETT |rlvar| (CDR |rlvar|)))))
                                         ((SPADCALL
                                           (SPADCALL |f| |newlpol|
                                                     (QREFELT $ 33))
                                           (|spadConstant| $ 34)
                                           (QREFELT $ 36))
                                          (PROGN
                                           (LETT #1# (CONS 1 "failed"))
                                           (GO #4#))))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT (CONS 0 |newlpol|))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |GROEBSOL;genPos|
        ((|lp| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         (|lvar| (|List| (|OrderedVariableList| |lv|)))
         ($
          (|Record|
           (|:| |polys|
                (|List|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
           (|:| |lpolys| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
           (|:| |coord| (|List| (|Integer|)))
           (|:| |univp|
                (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))))
        (SPROG
         ((#1=#:G726 NIL) (|testfail| (|Boolean|))
          (|gb1|
           (|Union| (|List| (|DistributedMultivariatePolynomial| |lv| F))
                    #2="failed"))
          (|gbt| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
          (|gb|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#3=#:G774 NIL) (|p| NIL) (#4=#:G773 NIL)
          (|val| #5=(|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#6=#:G752 NIL) (#7=#:G751 #5#) (#8=#:G753 #5#) (#9=#:G771 NIL)
          (|vv| NIL) (#10=#:G772 NIL) (|rv| NIL)
          (|ranvals| (|List| (|Integer|))) (#11=#:G770 NIL) (#12=#:G769 NIL)
          (|count| NIL) (|rlvar| (|List| (|OrderedVariableList| |lv|)))
          (|x| (|OrderedVariableList| |lv|))
          (|lnp|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#13=#:G768 NIL) (|f| NIL) (#14=#:G767 NIL))
         (SEQ (LETT |rlvar| (REVERSE |lvar|))
              (LETT |lnp|
                    (PROGN
                     (LETT #14# NIL)
                     (SEQ (LETT |f| NIL) (LETT #13# |lp|) G190
                          (COND
                           ((OR (ATOM #13#) (PROGN (LETT |f| (CAR #13#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #14#
                                  (CONS (SPADCALL |f| (QREFELT $ 42)) #14#))))
                          (LETT #13# (CDR #13#)) (GO G190) G191
                          (EXIT (NREVERSE #14#)))))
              (LETT |x| (|SPADfirst| |rlvar|)) (LETT |rlvar| (CDR |rlvar|))
              (LETT |testfail| 'T)
              (SEQ (LETT |count| 1) G190 (COND ((NULL |testfail|) (GO G191)))
                   (SEQ
                    (LETT |ranvals|
                          (PROGN
                           (LETT #12# NIL)
                           (SEQ (LETT |vv| NIL) (LETT #11# |rlvar|) G190
                                (COND
                                 ((OR (ATOM #11#)
                                      (PROGN (LETT |vv| (CAR #11#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #12#
                                        (CONS
                                         (+ 1
                                            (RANDOM
                                             (* |count| (LENGTH |lvar|))))
                                         #12#))))
                                (LETT #11# (CDR #11#)) (GO G190) G191
                                (EXIT (NREVERSE #12#)))))
                    (LETT |val|
                          (PROGN
                           (LETT #6# NIL)
                           (SEQ (LETT |rv| NIL) (LETT #10# |ranvals|)
                                (LETT |vv| NIL) (LETT #9# |rlvar|) G190
                                (COND
                                 ((OR (ATOM #9#)
                                      (PROGN (LETT |vv| (CAR #9#)) NIL)
                                      (ATOM #10#)
                                      (PROGN (LETT |rv| (CAR #10#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #8#
                                         (SPADCALL |rv|
                                                   (SPADCALL |vv|
                                                             (QREFELT $ 43))
                                                   (QREFELT $ 44)))
                                   (COND
                                    (#6#
                                     (LETT #7#
                                           (SPADCALL #7# #8# (QREFELT $ 45))))
                                    ('T
                                     (PROGN (LETT #7# #8#) (LETT #6# 'T)))))))
                                (LETT #9#
                                      (PROG1 (CDR #9#) (LETT #10# (CDR #10#))))
                                (GO G190) G191 (EXIT NIL))
                           (COND (#6# #7#) ('T (|spadConstant| $ 46)))))
                    (LETT |val|
                          (SPADCALL |val| (SPADCALL |x| (QREFELT $ 43))
                                    (QREFELT $ 45)))
                    (LETT |gb|
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |p| NIL) (LETT #3# |lnp|) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |p| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #4#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |p| |x| (QREFELT $ 47))
                                          |val| (QREFELT $ 49))
                                         #4#))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT (NREVERSE #4#)))))
                    (LETT |gb| (SPADCALL |gb| (QREFELT $ 52)))
                    (LETT |gbt| (SPADCALL |gb| (QREFELT $ 54)))
                    (LETT |gb1| (|GROEBSOL;testGenPos| |gbt| |lvar| $))
                    (EXIT
                     (COND ((QEQCAR |gb1| 1) "try again")
                           ('T (LETT |testfail| NIL)))))
                   (LETT |count| (|inc_SI| |count|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (VECTOR |gb| |gbt| |ranvals|
                       (SPADCALL
                        (SPADCALL
                         (PROG2 (LETT #1# |gb1|)
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0)
                                           (|List|
                                            (|DistributedMultivariatePolynomial|
                                             (QREFELT $ 6) (QREFELT $ 7)))
                                           (|Union|
                                            (|List|
                                             (|DistributedMultivariatePolynomial|
                                              (QREFELT $ 6) (QREFELT $ 7)))
                                            #2#)
                                           #1#))
                         (QREFELT $ 55))
                        (QREFELT $ 42))))))) 

(SDEFUN |GROEBSOL;genericPosition;LLR;4|
        ((|lp| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         (|lvar| (|List| (|OrderedVariableList| |lv|)))
         ($
          (|Record|
           (|:| |dpolys| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
           (|:| |coords| (|List| (|Integer|))))))
        (SPROG
         ((|nans|
           (|Record|
            (|:| |polys|
                 (|List|
                  (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
            (|:| |lpolys|
                 (|List| (|DistributedMultivariatePolynomial| |lv| F)))
            (|:| |coord| (|List| (|Integer|)))
            (|:| |univp|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))))
         (SEQ (LETT |nans| (|GROEBSOL;genPos| |lp| |lvar| $))
              (EXIT (CONS (QVELT |nans| 1) (QVELT |nans| 2)))))) 

(SDEFUN |GROEBSOL;select|
        ((|lup|
          (|List|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
         ($
          #1=(|List|
              (|List|
               (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))))
        (SPROG
         ((#2=#:G780 NIL) (#3=#:G779 #1#) (#4=#:G781 #1#) (#5=#:G787 NIL)
          (|lsel| NIL) (#6=#:G786 NIL) (#7=#:G785 NIL) (|f| NIL))
         (SEQ
          (COND
           ((SPADCALL |lup| NIL (QREFELT $ 60)) (SPADCALL NIL (QREFELT $ 61)))
           (#8='T
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |f| NIL) (LETT #7# (|SPADfirst| |lup|)) G190
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
                                 (LETT #5# (|GROEBSOL;select| (CDR |lup|) $))
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
                     (COND (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 62))))
                           ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                  (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
             (COND (#2# #3#) (#8# NIL)))))))) 

(SDEFUN |GROEBSOL;findCompon|
        ((|leq|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|lvar| (|List| (|OrderedVariableList| |lv|)))
         ($ (|List| (|List| (|DistributedMultivariatePolynomial| |lv| F)))))
        (SPROG
         ((#1=#:G826 NIL) (|ll| NIL) (#2=#:G825 NIL)
          (|ans|
           (|List| #3=(|List| (|DistributedMultivariatePolynomial| |lv| F))))
          (#4=#:G824 NIL) (|p| NIL) (#5=#:G823 NIL) (#6=#:G822 NIL) (|lp| NIL)
          (#7=#:G821 NIL)
          (|val| #8=(|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#9=#:G804 NIL) (#10=#:G803 #8#) (#11=#:G805 #8#) (#12=#:G819 NIL)
          (|vv| NIL) (#13=#:G820 NIL) (|rv| NIL)
          (|rlvar| (|List| (|OrderedVariableList| |lv|)))
          (|x| (|OrderedVariableList| |lv|)) (|ranvals| (|List| (|Integer|)))
          (|result|
           (|List|
            (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
          (|tlfact|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#14=#:G818 NIL) (|tfact| NIL)
          (|lfact|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#15=#:G817 NIL) (|ff| NIL) (#16=#:G816 NIL)
          (|fg|
           (|Factored|
            (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (|g| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (|lgp|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (|gp|
           (|Record|
            (|:| |polys|
                 (|List|
                  (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
            (|:| |lpolys|
                 (|List| (|DistributedMultivariatePolynomial| |lv| F)))
            (|:| |coord| (|List| (|Integer|)))
            (|:| |univp|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
          (|teq| #3#))
         (SEQ (LETT |teq| (SPADCALL |leq| (QREFELT $ 54)))
              (EXIT
               (COND ((EQL (LENGTH |teq|) (LENGTH |lvar|)) (LIST |teq|))
                     (#17='T
                      (SEQ (LETT |gp| (|GROEBSOL;genPos| |teq| |lvar| $))
                           (LETT |lgp| (QVELT |gp| 0))
                           (LETT |g| (QVELT |gp| 3))
                           (LETT |fg| (SPADCALL |g| (QREFELT $ 65)))
                           (LETT |lfact|
                                 (PROGN
                                  (LETT #16# NIL)
                                  (SEQ (LETT |ff| NIL)
                                       (LETT #15#
                                             (SPADCALL |fg| (QREFELT $ 69)))
                                       G190
                                       (COND
                                        ((OR (ATOM #15#)
                                             (PROGN
                                              (LETT |ff| (CAR #15#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #16#
                                               (CONS (QVELT |ff| 1) #16#))))
                                       (LETT #15# (CDR #15#)) (GO G190) G191
                                       (EXIT (NREVERSE #16#)))))
                           (LETT |result| NIL)
                           (EXIT
                            (COND ((EQL (LENGTH |lfact|) 1) (LIST |teq|))
                                  (#17#
                                   (SEQ
                                    (SEQ (LETT |tfact| NIL) (LETT #14# |lfact|)
                                         G190
                                         (COND
                                          ((OR (ATOM #14#)
                                               (PROGN
                                                (LETT |tfact| (CAR #14#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (LETT |tlfact| (CONS |tfact| |lgp|))
                                          (EXIT
                                           (LETT |result|
                                                 (CONS |tlfact| |result|))))
                                         (LETT #14# (CDR #14#)) (GO G190) G191
                                         (EXIT NIL))
                                    (LETT |ranvals| (QVELT |gp| 2))
                                    (LETT |rlvar| (REVERSE |lvar|))
                                    (LETT |x| (|SPADfirst| |rlvar|))
                                    (LETT |rlvar| (CDR |rlvar|))
                                    (LETT |val|
                                          (PROGN
                                           (LETT #9# NIL)
                                           (SEQ (LETT |rv| NIL)
                                                (LETT #13# |ranvals|)
                                                (LETT |vv| NIL)
                                                (LETT #12# |rlvar|) G190
                                                (COND
                                                 ((OR (ATOM #12#)
                                                      (PROGN
                                                       (LETT |vv| (CAR #12#))
                                                       NIL)
                                                      (ATOM #13#)
                                                      (PROGN
                                                       (LETT |rv| (CAR #13#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (PROGN
                                                   (LETT #11#
                                                         (SPADCALL |rv|
                                                                   (SPADCALL
                                                                    |vv|
                                                                    (QREFELT $
                                                                             43))
                                                                   (QREFELT $
                                                                            44)))
                                                   (COND
                                                    (#9#
                                                     (LETT #10#
                                                           (SPADCALL #10# #11#
                                                                     (QREFELT $
                                                                              45))))
                                                    ('T
                                                     (PROGN
                                                      (LETT #10# #11#)
                                                      (LETT #9# 'T)))))))
                                                (LETT #12#
                                                      (PROG1 (CDR #12#)
                                                        (LETT #13#
                                                              (CDR #13#))))
                                                (GO G190) G191 (EXIT NIL))
                                           (COND (#9# #10#)
                                                 (#17#
                                                  (|spadConstant| $ 46)))))
                                    (LETT |val|
                                          (SPADCALL
                                           (SPADCALL |x| (QREFELT $ 43)) |val|
                                           (QREFELT $ 70)))
                                    (LETT |ans|
                                          (PROGN
                                           (LETT #7# NIL)
                                           (SEQ (LETT |lp| NIL)
                                                (LETT #6# |result|) G190
                                                (COND
                                                 ((OR (ATOM #6#)
                                                      (PROGN
                                                       (LETT |lp| (CAR #6#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #7#
                                                        (CONS
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (PROGN
                                                            (LETT #5# NIL)
                                                            (SEQ (LETT |p| NIL)
                                                                 (LETT #4#
                                                                       |lp|)
                                                                 G190
                                                                 (COND
                                                                  ((OR
                                                                    (ATOM #4#)
                                                                    (PROGN
                                                                     (LETT |p|
                                                                           (CAR
                                                                            #4#))
                                                                     NIL))
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (EXIT
                                                                   (LETT #5#
                                                                         (CONS
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            |p|
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             47))
                                                                           |val|
                                                                           (QREFELT
                                                                            $
                                                                            49))
                                                                          #5#))))
                                                                 (LETT #4#
                                                                       (CDR
                                                                        #4#))
                                                                 (GO G190) G191
                                                                 (EXIT
                                                                  (NREVERSE
                                                                   #5#))))
                                                           (QREFELT $ 52))
                                                          (QREFELT $ 54))
                                                         #7#))))
                                                (LETT #6# (CDR #6#)) (GO G190)
                                                G191 (EXIT (NREVERSE #7#)))))
                                    (EXIT
                                     (PROGN
                                      (LETT #2# NIL)
                                      (SEQ (LETT |ll| NIL) (LETT #1# |ans|)
                                           G190
                                           (COND
                                            ((OR (ATOM #1#)
                                                 (PROGN
                                                  (LETT |ll| (CAR #1#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (COND
                                              ((SPADCALL |ll|
                                                         (LIST
                                                          (|spadConstant| $
                                                                          71))
                                                         (QREFELT $ 72))
                                               (LETT #2# (CONS |ll| #2#))))))
                                           (LETT #1# (CDR #1#)) (GO G190) G191
                                           (EXIT (NREVERSE #2#)))))))))))))))) 

(SDEFUN |GROEBSOL;zeroDim?|
        ((|lp|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|lvar| #1=(|List| (|OrderedVariableList| |lv|))) ($ (|Boolean|)))
        (SPROG
         ((|lvint1| #1#) (|x| (|OrderedVariableList| |lv|)) (#2=#:G830 NIL)
          (|g| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#3=#:G838 NIL) (|f| NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((NULL |lp|) NIL)
                (#4='T
                 (SEQ (LETT |n| (LENGTH |lvar|))
                      (EXIT
                       (COND ((< (LENGTH |lp|) |n|) NIL)
                             (#4#
                              (SEQ (LETT |lvint1| |lvar|)
                                   (SEQ (LETT |f| NIL) (LETT #3# |lp|) G190
                                        (COND
                                         ((OR (ATOM #3#)
                                              (PROGN (LETT |f| (CAR #3#)) NIL)
                                              (NULL (NULL (NULL |lvint1|))))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |g|
                                               (SPADCALL |f|
                                                         (SPADCALL |f|
                                                                   (QREFELT $
                                                                            73))
                                                         (QREFELT $ 70)))
                                         (LETT |x|
                                               (PROG2
                                                   (LETT #2#
                                                         (SPADCALL |g|
                                                                   (QREFELT $
                                                                            74)))
                                                   (QCDR #2#)
                                                 (|check_union2| (QEQCAR #2# 0)
                                                                 (|OrderedVariableList|
                                                                  (QREFELT $
                                                                           6))
                                                                 (|Union|
                                                                  (|OrderedVariableList|
                                                                   (QREFELT $
                                                                            6))
                                                                  "failed")
                                                                 #2#)))
                                         (EXIT
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL
                                              (SPADCALL |g| |x| (QREFELT $ 47))
                                              (QREFELT $ 75))
                                             (QREFELT $ 76))
                                            (LETT |lvint1|
                                                  (SPADCALL |x| |lvint1|
                                                            (QREFELT $
                                                                     77)))))))
                                        (LETT #3# (CDR #3#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT (NULL |lvint1|)))))))))))) 

(SDEFUN |GROEBSOL;groebSolve;LLL;8|
        ((|leq| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         (|lvar| (|List| (|OrderedVariableList| |lv|)))
         ($ (|List| (|List| (|DistributedMultivariatePolynomial| |lv| F)))))
        (SPROG
         ((|result|
           (|List| (|List| (|DistributedMultivariatePolynomial| |lv| F))))
          (|tfact|
           #1=(|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#2=#:G873 NIL)
          (|lfact|
           (|List|
            (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
          (#3=#:G872 NIL) (|ff| NIL) (#4=#:G871 NIL) (#5=#:G870 NIL)
          (|llf| NIL) (#6=#:G869 NIL) (#7=#:G865 NIL)
          (|llfact|
           (|List|
            (|Factored|
             (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
          (|fg|
           (|Factored|
            (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (|g| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#8=#:G868 NIL) (|x| NIL)
          (|basis|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (|leq1| #1#)
          (|lnp|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#9=#:G867 NIL) (|f| NIL) (#10=#:G866 NIL))
         (SEQ
          (LETT |lnp|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |f| NIL) (LETT #9# |leq|) G190
                      (COND
                       ((OR (ATOM #9#) (PROGN (LETT |f| (CAR #9#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #10# (CONS (SPADCALL |f| (QREFELT $ 42)) #10#))))
                      (LETT #9# (CDR #9#)) (GO G190) G191
                      (EXIT (NREVERSE #10#)))))
          (LETT |leq1| (SPADCALL |lnp| (QREFELT $ 52)))
          (COND
           ((EQL (LENGTH |leq1|) 1)
            (COND
             ((SPADCALL (|SPADfirst| |leq1|) (|spadConstant| $ 78)
                        (QREFELT $ 79))
              (EXIT NIL)))))
          (COND
           ((NULL (|GROEBSOL;zeroDim?| |leq1| |lvar| $))
            (EXIT
             (|error| "system does not have a finite number of solutions"))))
          (LETT |basis| (SPADCALL |leq1| (QREFELT $ 80))) (LETT |llfact| NIL)
          (SEQ
           (EXIT
            (SEQ (LETT |x| NIL) (LETT #8# |lvar|) G190
                 (COND
                  ((OR (ATOM #8#) (PROGN (LETT |x| (CAR #8#)) NIL)) (GO G191)))
                 (SEQ (LETT |g| (SPADCALL |leq1| |basis| |x| (QREFELT $ 81)))
                      (LETT |fg| (SPADCALL |g| (QREFELT $ 65)))
                      (LETT |llfact| (CONS |fg| |llfact|))
                      (EXIT
                       (COND
                        ((EQL (SPADCALL |g| |x| (QREFELT $ 82))
                              (LENGTH |basis|))
                         (PROGN (LETT #7# 1) (GO #11=#:G846))))))
                 (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL)))
           #11# (EXIT #7#))
          (LETT |result| NIL)
          (LETT |lfact|
                (|GROEBSOL;select|
                 (PROGN
                  (LETT #6# NIL)
                  (SEQ (LETT |llf| NIL) (LETT #5# |llfact|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |llf| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #6#
                               (CONS
                                (PROGN
                                 (LETT #4# NIL)
                                 (SEQ (LETT |ff| NIL)
                                      (LETT #3#
                                            (SPADCALL |llf| (QREFELT $ 69)))
                                      G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN (LETT |ff| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #4# (CONS (QVELT |ff| 1) #4#))))
                                      (LETT #3# (CDR #3#)) (GO G190) G191
                                      (EXIT (NREVERSE #4#))))
                                #6#))))
                       (LETT #5# (CDR #5#)) (GO G190) G191
                       (EXIT (NREVERSE #6#))))
                 $))
          (SEQ (LETT #2# |lfact|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |tfact| (CAR #2#)) NIL))
                 (GO G191)))
               (SEQ
                (LETT |tfact|
                      (SPADCALL (SPADCALL |tfact| |leq1| (QREFELT $ 83))
                                (QREFELT $ 52)))
                (EXIT
                 (COND
                  ((SPADCALL |tfact| (LIST (|spadConstant| $ 78))
                             (QREFELT $ 84))
                   "next value")
                  ('T
                   (LETT |result|
                         (SPADCALL |result|
                                   (|GROEBSOL;findCompon| |tfact| |lvar| $)
                                   (QREFELT $ 86)))))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (EXIT |result|)))) 

(SDEFUN |GROEBSOL;testDim;LLU;9|
        ((|leq|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|lvar| (|List| (|OrderedVariableList| |lv|)))
         ($
          (|Union|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
           "failed")))
        (SPROG
         ((|leq1|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
         (SEQ (LETT |leq1| (SPADCALL |leq| (QREFELT $ 52)))
              (COND
               ((EQL (LENGTH |leq1|) 1)
                (COND
                 ((SPADCALL (|SPADfirst| |leq1|) (|spadConstant| $ 78)
                            (QREFELT $ 79))
                  (EXIT (CONS 0 NIL))))))
              (COND
               ((NULL (|GROEBSOL;zeroDim?| |leq1| |lvar| $))
                (EXIT (CONS 1 "failed"))))
              (EXIT (CONS 0 |leq1|))))) 

(DECLAIM (NOTINLINE |GroebnerSolve;|)) 

(DEFUN |GroebnerSolve| (&REST #1=#:G885)
  (SPROG NIL
         (PROG (#2=#:G886)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T T))
                                               (HGET |$ConstructorCache|
                                                     '|GroebnerSolve|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GroebnerSolve;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|GroebnerSolve|)))))))))) 

(DEFUN |GroebnerSolve;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|GroebnerSolve| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 90))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GroebnerSolve|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (LENGTH |#1|))
          $))) 

(MAKEPROP '|GroebnerSolve| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|nv| (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 15) (0 . |degree|) (5 . |One|)
              (9 . |One|)
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 7)
              (13 . |coefficient|) (|Integer|) (19 . |coerce|)
              (|Union| $ '"failed") (24 . |exquo|) (30 . |leadingCoefficient|)
              (35 . |gcd|) (41 . |exquo|) (47 . |monomial|) (53 . +) (59 . ^)
              (65 . -) (|SparseUnivariatePolynomial| $)
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 6)))
              (71 . |multivariate|) (|List| 15)
              (|GroebnerInternalPackage| 7
                                         (|DirectProduct|
                                          (NRTEVAL (LENGTH (QREFELT $ 6))) 10)
                                         15)
              (77 . |redPol|) (83 . |Zero|) (|Boolean|) (87 . ~=)
              (93 . |univariate|) (|Union| 29 '"failed") (99 . |mainVariable|)
              (|HomogeneousDistributedMultivariatePolynomial|
               (NRTEVAL (QREFELT $ 6)) 7)
              (|PolToPol| (NRTEVAL (QREFELT $ 6)) 7) (104 . |dmpToHdmp|)
              (109 . |coerce|) (114 . *) (120 . +) (126 . |Zero|)
              (130 . |univariate|) (|SparseUnivariatePolynomial| 40)
              (136 . |elt|) (|List| 40)
              (|GroebnerPackage| 7
                                 (|HomogeneousDirectProduct|
                                  (NRTEVAL (LENGTH (QREFELT $ 6))) 10)
                                 40)
              (142 . |groebner|)
              (|LinGroebnerPackage| (NRTEVAL (QREFELT $ 6)) 7)
              (147 . |totolex|) (152 . |last|)
              (|Record| (|:| |dpolys| 31) (|:| |coords| (|List| 17)))
              (|List| 29) |GROEBSOL;genericPosition;LLR;4| (|List| 50)
              (157 . =) (163 . |list|) (168 . |append|) (|Factored| 40)
              (|GeneralizedMultivariateFactorize| 29
                                                  (|HomogeneousDirectProduct|
                                                   (NRTEVAL
                                                    (LENGTH (QREFELT $ 6)))
                                                   10)
                                                  8 7 40)
              (174 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 66) (|:| |factor| 40) (|:| |exponent| 10))
              (|List| 67) (179 . |factorList|) (184 . -) (190 . |One|)
              (194 . ~=) (200 . |reductum|) (205 . |mainVariable|)
              (210 . |leadingCoefficient|) (215 . |ground?|) (220 . |remove|)
              (226 . |One|) (230 . =) (236 . |computeBasis|) (241 . |minPol|)
              (248 . |degree|) (254 . |concat|) (260 . =) (|List| 31)
              (266 . |concat|) |GROEBSOL;groebSolve;LLL;8|
              (|Union| 50 '"failed") |GROEBSOL;testDim;LLU;9|)
           '#(|testDim| 272 |groebSolve| 278 |genericPosition| 284) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|groebSolve|
                                 ((|List|
                                   (|List|
                                    (|DistributedMultivariatePolynomial| |#1|
                                                                         |#2|)))
                                  (|List|
                                   (|DistributedMultivariatePolynomial| |#1|
                                                                        |#2|))
                                  (|List| (|OrderedVariableList| |#1|))))
                                T)
                              '((|testDim|
                                 ((|Union|
                                   (|List|
                                    (|HomogeneousDistributedMultivariatePolynomial|
                                     |#1| |#2|))
                                   "failed")
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|List| (|OrderedVariableList| |#1|))))
                                T)
                              '((|genericPosition|
                                 ((|Record|
                                   (|:| |dpolys|
                                        (|List|
                                         (|DistributedMultivariatePolynomial|
                                          |#1| |#2|)))
                                   (|:| |coords| (|List| (|Integer|))))
                                  (|List|
                                   (|DistributedMultivariatePolynomial| |#1|
                                                                        |#2|))
                                  (|List| (|OrderedVariableList| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 89
                                            '(1 11 10 0 12 0 7 0 13 0 8 0 14 2
                                              11 15 0 10 16 1 7 0 17 18 2 15 19
                                              0 7 20 1 11 15 0 21 2 15 0 0 0 22
                                              2 15 19 0 0 23 2 11 0 15 10 24 2
                                              11 0 0 0 25 2 11 0 0 10 26 2 11 0
                                              0 0 27 2 15 0 28 29 30 2 32 15 15
                                              31 33 0 15 0 34 2 15 35 0 0 36 2
                                              15 28 0 29 37 1 15 38 0 39 1 41
                                              40 15 42 1 40 0 29 43 2 40 0 17 0
                                              44 2 40 0 0 0 45 0 40 0 46 2 40
                                              28 0 29 47 2 48 40 0 40 49 1 51
                                              50 50 52 1 53 31 50 54 1 31 15 0
                                              55 2 59 35 0 0 60 1 59 0 50 61 2
                                              59 0 0 0 62 1 64 63 40 65 1 63 68
                                              0 69 2 40 0 0 0 70 0 15 0 71 2 31
                                              35 0 0 72 1 40 0 0 73 1 40 38 0
                                              74 1 48 40 0 75 1 40 35 0 76 2 57
                                              0 29 0 77 0 40 0 78 2 40 35 0 0
                                              79 1 53 50 50 80 3 53 40 50 50 29
                                              81 2 40 10 0 29 82 2 50 0 0 0 83
                                              2 50 35 0 0 84 2 85 0 0 0 86 2 0
                                              88 50 57 89 2 0 85 31 57 87 2 0
                                              56 31 57 58)))))
           '|lookupComplete|)) 
