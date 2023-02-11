
(SDEFUN |NFINTBAS;frobMatrix|
        ((|rb| (|Matrix| (|Integer|))) (|rbinv| (|Matrix| (|Integer|)))
         (|rbden| (|Integer|)) (|p| (|NonNegativeInteger|))
         ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G718 NIL) (|mat| (|Matrix| (|Integer|))) (|a| (F))
          (#2=#:G724 NIL) (|j| NIL) (#3=#:G725 NIL) (|jj| NIL) (#4=#:G722 NIL)
          (|i| NIL) (#5=#:G723 NIL) (|ii| NIL) (|v| (|Vector| F))
          (|b| (|Vector| F)) (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
              (LETT |b| (SPADCALL (QREFELT $ 11)))
              (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 13)))
              (SEQ (LETT |ii| (PROGN |rb| 1))
                   (LETT #5# (SPADCALL |rb| (QREFELT $ 18)))
                   (LETT |i| (SPADCALL |v| (QREFELT $ 16)))
                   (LETT #4# (QVSIZE |v|)) G190
                   (COND ((OR (> |i| #4#) (> |ii| #5#)) (GO G191)))
                   (SEQ (LETT |a| (|spadConstant| $ 13))
                        (SEQ (LETT |jj| (PROGN |rb| 1))
                             (LETT #3# (SPADCALL |rb| (QREFELT $ 19)))
                             (LETT |j| (SPADCALL |b| (QREFELT $ 16)))
                             (LETT #2# (QVSIZE |b|)) G190
                             (COND ((OR (> |j| #2#) (> |jj| #3#)) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |a|
                                     (SPADCALL |a|
                                               (SPADCALL
                                                (QAREF2O |rb| |ii| |jj| 1 1)
                                                (QAREF1O |b| |j| 1)
                                                (QREFELT $ 20))
                                               (QREFELT $ 21)))))
                             (LETT |j|
                                   (PROG1 (+ |j| 1) (LETT |jj| (+ |jj| 1))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (QSETAREF1O |v| |i| (SPADCALL |a| |p| (QREFELT $ 23))
                                     1)))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |ii| (+ |ii| 1))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |mat|
                    (SPADCALL (SPADCALL |v| (QREFELT $ 24)) (QREFELT $ 25)))
              (EXIT
               (PROG2
                   (LETT #1#
                         (SPADCALL
                          (SPADCALL (SPADCALL |rbinv| (QREFELT $ 25)) |mat|
                                    (QREFELT $ 26))
                          (EXPT |rbden| |p|) (QREFELT $ 28)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (|Matrix| (|Integer|))
                                 (|Union| (|Matrix| (|Integer|)) "failed")
                                 #1#)))))) 

(SDEFUN |NFINTBAS;wildPrimes|
        ((|factoredDisc| (|Factored| (|Integer|))) (|n| (|Integer|))
         ($ (|List| (|Integer|))))
        (SPROG ((|ans| (|List| (|Integer|))) (#1=#:G746 NIL) (|f| NIL))
               (SEQ (LETT |ans| NIL)
                    (SEQ (LETT |f| NIL)
                         (LETT #1# (SPADCALL |factoredDisc| (QREFELT $ 33)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((> (QVELT |f| 2) 1)
                             (COND
                              ((<= (QVELT |f| 1) |n|)
                               (LETT |ans| (CONS (QVELT |f| 1) |ans|))))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |NFINTBAS;tameProduct|
        ((|factoredDisc| (|Factored| (|Integer|))) (|n| (|Integer|))
         ($ (|Integer|)))
        (SPROG ((|ans| (|Integer|)) (#1=#:G754 NIL) (|f| NIL))
               (SEQ (LETT |ans| 1)
                    (SEQ (LETT |f| NIL)
                         (LETT #1# (SPADCALL |factoredDisc| (QREFELT $ 33)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((> (QVELT |f| 2) 1)
                             (COND
                              ((> (QVELT |f| 1) |n|)
                               (LETT |ans| (* (QVELT |f| 1) |ans|))))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |NFINTBAS;integralBasis;R;4|
        (($
          (|Record| (|:| |basis| (|Matrix| (|Integer|)))
                    (|:| |basisDen| (|Integer|))
                    (|:| |basisInv| (|Matrix| (|Integer|))))))
        (SPROG
         ((|runningRbinv| #1=(|Matrix| (|Integer|))) (|runningRb| #1#)
          (|runningRbden| (|Integer|)) (|mat| (|Matrix| (|Integer|)))
          (|disc| #2=(|Integer|)) (|rbden| #3=(|Integer|))
          (|rb| #4=(|Matrix| (|Integer|)))
          (|lb|
           (|Record| (|:| |basis| #4#) (|:| |basisDen| #3#)
                     (|:| |basisInv| (|Matrix| (|Integer|)))
                     (|:| |discr| (|Integer|))))
          (#5=#:G767 NIL) (|p| NIL) (|matrixOut| #1#) (|sing| (|Integer|))
          (|wilds| (|List| (|Integer|)))
          (|factoredDisc| (|Factored| (|Integer|))) (|disc0| #2#)
          (|n| (|PositiveInteger|)) (|traceMat| (|Matrix| (|Integer|))))
         (SEQ (LETT |traceMat| (SPADCALL (QREFELT $ 34)))
              (LETT |n| (SPADCALL (QREFELT $ 9)))
              (LETT |disc| (SPADCALL |traceMat| (QREFELT $ 35)))
              (LETT |disc0| |disc|)
              (LETT |factoredDisc| (SPADCALL |disc0| (QREFELT $ 37)))
              (LETT |wilds| (|NFINTBAS;wildPrimes| |factoredDisc| |n| $))
              (LETT |sing| (|NFINTBAS;tameProduct| |factoredDisc| |n| $))
              (LETT |runningRb| (SPADCALL |n| 1 (QREFELT $ 40)))
              (LETT |runningRbinv| (SPADCALL |n| 1 (QREFELT $ 40)))
              (LETT |runningRbden| 1)
              (COND
               ((EQL |sing| 1)
                (COND
                 ((NULL |wilds|)
                  (EXIT (VECTOR |runningRb| |runningRbden| |runningRbinv|))))))
              (LETT |matrixOut| (SPADCALL |n| 0 (QREFELT $ 40)))
              (SEQ (LETT |p| NIL) (LETT #5# |wilds|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |lb|
                          (|NFINTBAS;iWildLocalIntegralBasis| |matrixOut|
                           |disc| |p| $))
                    (LETT |rb| (QVELT |lb| 0)) (LETT |rbden| (QVELT |lb| 1))
                    (LETT |disc| (QVELT |lb| 3))
                    (EXIT
                     (COND
                      ((SPADCALL 1 |rbden| (QREFELT $ 42))
                       (SEQ
                        (LETT |mat|
                              (SPADCALL
                               (SPADCALL |rbden| |runningRb| (QREFELT $ 43))
                               (SPADCALL |runningRbden| |rb| (QREFELT $ 43))
                               (QREFELT $ 44)))
                        (LETT |runningRbden| (* |runningRbden| |rbden|))
                        (LETT |runningRb|
                              (SPADCALL
                               (SPADCALL |mat| |runningRbden| (QREFELT $ 46))
                               (QREFELT $ 47)))
                        (EXIT
                         (LETT |runningRbinv|
                               (SPADCALL |runningRb| |runningRbden|
                                         (QREFELT $ 49)))))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |lb|
                    (|NFINTBAS;iTameLocalIntegralBasis| |traceMat| |disc|
                     |sing| $))
              (LETT |rb| (QVELT |lb| 0)) (LETT |rbden| (QVELT |lb| 1))
              (LETT |disc| (QVELT |lb| 3))
              (COND
               ((SPADCALL 1 |rbden| (QREFELT $ 42))
                (SEQ
                 (LETT |mat|
                       (SPADCALL (SPADCALL |rbden| |runningRb| (QREFELT $ 43))
                                 (SPADCALL |runningRbden| |rb| (QREFELT $ 43))
                                 (QREFELT $ 44)))
                 (LETT |runningRbden| (* |runningRbden| |rbden|))
                 (LETT |runningRb|
                       (SPADCALL (SPADCALL |mat| |runningRbden| (QREFELT $ 46))
                                 (QREFELT $ 47)))
                 (EXIT
                  (LETT |runningRbinv|
                        (SPADCALL |runningRb| |runningRbden|
                                  (QREFELT $ 49)))))))
              (EXIT (VECTOR |runningRb| |runningRbden| |runningRbinv|))))) 

(SDEFUN |NFINTBAS;localIntegralBasis;IR;5|
        ((|p| (|Integer|))
         ($
          (|Record| (|:| |basis| (|Matrix| (|Integer|)))
                    (|:| |basisDen| (|Integer|))
                    (|:| |basisInv| (|Matrix| (|Integer|))))))
        (SPROG
         ((|lb|
           (|Record| (|:| |basis| (|Matrix| (|Integer|)))
                     (|:| |basisDen| (|Integer|))
                     (|:| |basisInv| (|Matrix| (|Integer|)))
                     (|:| |discr| (|Integer|))))
          (|disc| (|Integer|)) (|n| (|PositiveInteger|))
          (|traceMat| (|Matrix| (|Integer|))))
         (SEQ (LETT |traceMat| (SPADCALL (QREFELT $ 34)))
              (LETT |n| (SPADCALL (QREFELT $ 9)))
              (LETT |disc| (SPADCALL |traceMat| (QREFELT $ 35)))
              (EXIT
               (COND
                ((QEQCAR (SPADCALL |disc| (* |p| |p|) (QREFELT $ 52)) 1)
                 (VECTOR (SPADCALL |n| 1 (QREFELT $ 40)) 1
                         (SPADCALL |n| 1 (QREFELT $ 40))))
                (#1='T
                 (SEQ
                  (LETT |lb|
                        (COND
                         ((> |p| (SPADCALL (QREFELT $ 9)))
                          (|NFINTBAS;iTameLocalIntegralBasis| |traceMat| |disc|
                           |p| $))
                         (#1#
                          (|NFINTBAS;iWildLocalIntegralBasis|
                           (SPADCALL |n| 0 (QREFELT $ 40)) |disc| |p| $))))
                  (EXIT
                   (VECTOR (QVELT |lb| 0) (QVELT |lb| 1) (QVELT |lb| 2)))))))))) 

(SDEFUN |NFINTBAS;iTameLocalIntegralBasis|
        ((|traceMat| #1=(|Matrix| (|Integer|))) (|disc| #2=(|Integer|))
         (|sing| (|Integer|))
         ($
          (|Record| (|:| |basis| (|Matrix| (|Integer|)))
                    (|:| |basisDen| (|Integer|))
                    (|:| |basisInv| (|Matrix| (|Integer|)))
                    (|:| |discr| (|Integer|)))))
        (SPROG
         ((|tfm| #1#) (#3=#:G779 NIL) (#4=#:G786 NIL) (|oldIndex| (|Integer|))
          (|indexChange| (|Integer|)) (|rbinv| #5=(|Matrix| (|Integer|)))
          (|rbden| (|Integer|)) (|rb| #5#) (|g| (|Integer|))
          (|index| (|Integer|)) (|idinv| (|Matrix| (|Integer|)))
          (|id| (|Matrix| (|Integer|))) (|disc0| #2#)
          (|n| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL (QREFELT $ 9))) (LETT |disc0| |disc|)
                (LETT |rb| (SPADCALL |n| 1 (QREFELT $ 40)))
                (LETT |rbinv| (SPADCALL |n| 1 (QREFELT $ 40))) (LETT |rbden| 1)
                (LETT |index| 1) (LETT |oldIndex| 1) (LETT |tfm| |traceMat|)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (LETT |idinv|
                             (SPADCALL
                              (SPADCALL (SPADCALL |tfm| |sing| (QREFELT $ 46))
                                        (QREFELT $ 47))
                              (QREFELT $ 25)))
                       (LETT |id|
                             (SPADCALL (SPADCALL |idinv| |sing| (QREFELT $ 54))
                                       (QREFELT $ 55)))
                       (LETT |idinv| (SPADCALL |id| |sing| (QREFELT $ 49)))
                       (LETT |rbinv|
                             (SPADCALL (SPADCALL |id| |rb| (QREFELT $ 26))
                                       (SPADCALL |rbinv| |idinv|
                                                 (QREFELT $ 26))
                                       (* |sing| |rbden|) (QREFELT $ 57)))
                       (LETT |index| (SPADCALL |rbinv| (QREFELT $ 58)))
                       (LETT |rb|
                             (SPADCALL
                              (SPADCALL |rbinv| (* |sing| |rbden|)
                                        (QREFELT $ 54))
                              (QREFELT $ 55)))
                       (LETT |g| (SPADCALL |rb| |sing| |n| (QREFELT $ 59)))
                       (COND
                        ((SPADCALL 1 |g| (QREFELT $ 42))
                         (LETT |rb|
                               (PROG2
                                   (LETT #3#
                                         (SPADCALL |rb| |g| (QREFELT $ 28)))
                                   (QCDR #3#)
                                 (|check_union2| (QEQCAR #3# 0)
                                                 (|Matrix| (|Integer|))
                                                 (|Union|
                                                  (|Matrix| (|Integer|))
                                                  #6="failed")
                                                 #3#)))))
                       (LETT |rbden| (* |rbden| (QUOTIENT2 |sing| |g|)))
                       (LETT |rbinv| (SPADCALL |rb| |rbden| (QREFELT $ 49)))
                       (LETT |disc| (QUOTIENT2 |disc0| (* |index| |index|)))
                       (LETT |indexChange| (QUOTIENT2 |index| |oldIndex|))
                       (LETT |oldIndex| |index|)
                       (EXIT
                        (COND
                         ((EQL |indexChange| 1)
                          (PROGN
                           (LETT #4# (VECTOR |rb| |rbden| |rbinv| |disc|))
                           (GO #7=#:G785)))
                         ('T
                          (LETT |tfm|
                                (PROG2
                                    (LETT #3#
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |rb| |traceMat|
                                                      (QREFELT $ 26))
                                            (SPADCALL |rb| (QREFELT $ 25))
                                            (QREFELT $ 26))
                                           (* |rbden| |rbden|) (QREFELT $ 28)))
                                    (QCDR #3#)
                                  (|check_union2| (QEQCAR #3# 0)
                                                  (|Matrix| (|Integer|))
                                                  (|Union|
                                                   (|Matrix| (|Integer|)) #6#)
                                                  #3#)))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #7# (EXIT #4#)))) 

(SDEFUN |NFINTBAS;iWildLocalIntegralBasis|
        ((|matrixOut| (|Matrix| (|Integer|))) (|disc| (|Integer|))
         (|p| (|Integer|))
         ($
          (|Record| (|:| |basis| (|Matrix| (|Integer|)))
                    (|:| |basisDen| (|Integer|))
                    (|:| |basisInv| (|Matrix| (|Integer|)))
                    (|:| |discr| (|Integer|)))))
        (SPROG
         ((#1=#:G831 NIL) (#2=#:G832 NIL) (|oldIndex| (|Integer|))
          (|indexChange| (|Integer|)) (|rbinv| #3=(|Matrix| (|Integer|)))
          (|rbden| (|Integer|)) (|rb| #3#) (|index| (|Integer|))
          (|idinv| (|Matrix| (|Integer|))) (|id| (|Matrix| (|Integer|)))
          (|tfm| (|Matrix| (|Integer|))) (#4=#:G824 NIL)
          (|lp| (|NonNegativeInteger|)) (#5=#:G789 NIL) (|p2| (|Integer|))
          (|n| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
                (LETT |rb| (SPADCALL |n| 1 (QREFELT $ 40)))
                (LETT |rbinv| (SPADCALL |n| 1 (QREFELT $ 40))) (LETT |rbden| 1)
                (LETT |index| 1) (LETT |oldIndex| 1) (LETT |p2| (* |p| |p|))
                (LETT |lp|
                      (SPADCALL
                       (PROG1 (LETT #5# |p|)
                         (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #5#))
                       |n| (QREFELT $ 60)))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (LETT |tfm|
                             (SPADCALL
                              (|NFINTBAS;frobMatrix| |rb| |rbinv| |rbden|
                               (PROG1 (LETT #4# |p|)
                                 (|check_subtype2| (>= #4# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #4#))
                               $)
                              |lp| (QREFELT $ 61)))
                       (LETT |idinv|
                             (SPADCALL
                              (SPADCALL (SPADCALL |tfm| |p| (QREFELT $ 46))
                                        (QREFELT $ 47))
                              (QREFELT $ 25)))
                       (LETT |id|
                             (SPADCALL (SPADCALL |idinv| |p| (QREFELT $ 54))
                                       (QREFELT $ 55)))
                       (LETT |idinv| (SPADCALL |id| |p| (QREFELT $ 49)))
                       (LETT |rbinv|
                             (SPADCALL (SPADCALL |id| |rb| (QREFELT $ 26))
                                       (SPADCALL |rbinv| |idinv|
                                                 (QREFELT $ 26))
                                       (* |p| |rbden|) (QREFELT $ 57)))
                       (LETT |index| (SPADCALL |rbinv| (QREFELT $ 58)))
                       (LETT |rb|
                             (SPADCALL
                              (SPADCALL |rbinv| (* |p| |rbden|) (QREFELT $ 54))
                              (QREFELT $ 55)))
                       (COND
                        ((EQL
                          (SPADCALL |rb| |matrixOut| |p| |n| (QREFELT $ 62)) 1)
                         (LETT |rb| |matrixOut|))
                        ('T (LETT |rbden| (* |p| |rbden|))))
                       (LETT |rbinv| (SPADCALL |rb| |rbden| (QREFELT $ 49)))
                       (LETT |indexChange| (QUOTIENT2 |index| |oldIndex|))
                       (LETT |oldIndex| |index|)
                       (LETT |disc|
                             (QUOTIENT2 |disc|
                                        (* |indexChange| |indexChange|)))
                       (EXIT
                        (COND
                         ((EQL |indexChange| 1)
                          (PROGN
                           (LETT #2# (VECTOR |rb| |rbden| |rbinv| |disc|))
                           (GO #6=#:G830)))
                         ('T
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL (GCD |p2| |disc|) |p2| (QREFELT $ 63))
                              (PROGN
                               (LETT #1#
                                     (PROGN
                                      (LETT #2#
                                            (VECTOR |rb| |rbden| |rbinv|
                                                    |disc|))
                                      (GO #6#)))
                               (GO #7=#:G826)))))
                           #7# (EXIT #1#))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #6# (EXIT #2#)))) 

(SDEFUN |NFINTBAS;discriminant;I;8| (($ (|Integer|)))
        (SPROG
         ((#1=#:G835 NIL) (|index| (|Integer|)) (|rbden| #2=(|Integer|))
          (|rb| #3=(|Matrix| (|Integer|)))
          (|intBas|
           (|Record| (|:| |basis| #3#) (|:| |basisDen| #2#)
                     (|:| |basisInv| (|Matrix| (|Integer|)))))
          (|disc| (|Integer|)))
         (SEQ (LETT |disc| (SPADCALL (SPADCALL (QREFELT $ 34)) (QREFELT $ 35)))
              (LETT |intBas| (SPADCALL (QREFELT $ 51)))
              (LETT |rb| (QVELT |intBas| 0)) (LETT |rbden| (QVELT |intBas| 1))
              (LETT |index|
                    (PROG2
                        (LETT #1#
                              (SPADCALL (EXPT |rbden| (SPADCALL (QREFELT $ 9)))
                                        (SPADCALL |rb| (QREFELT $ 35))
                                        (QREFELT $ 52)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                      (|Union| (|Integer|) #4="failed") #1#)))
              (EXIT
               (PROG2
                   (LETT #1#
                         (SPADCALL |disc| (* |index| |index|) (QREFELT $ 52)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                 (|Union| (|Integer|) #4#) #1#)))))) 

(DECLAIM (NOTINLINE |NumberFieldIntegralBasis;|)) 

(DEFUN |NumberFieldIntegralBasis| (&REST #1=#:G839)
  (SPROG NIL
         (PROG (#2=#:G840)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|NumberFieldIntegralBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |NumberFieldIntegralBasis;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|NumberFieldIntegralBasis|)))))))))) 

(DEFUN |NumberFieldIntegralBasis;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|NumberFieldIntegralBasis| DV$1 DV$2))
          (LETT $ (GETREFV 65))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NumberFieldIntegralBasis|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NumberFieldIntegralBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) (0 . |rank|) (|Vector| $) (4 . |basis|)
              (8 . |Zero|) (12 . |Zero|) (|Integer|) (|Vector| 7)
              (16 . |minIndex|) (|Matrix| 14) (21 . |maxRowIndex|)
              (26 . |maxColIndex|) (31 . *) (37 . +) (|NonNegativeInteger|)
              (43 . ^) (49 . |coordinates|) (54 . |transpose|) (59 . *)
              (|Union| $ '"failed") (65 . |exquo|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 29) (|:| |factor| 14) (|:| |exponent| 22))
              (|List| 30) (|Factored| 14) (71 . |factorList|)
              (76 . |traceMatrix|) (80 . |determinant|)
              (|IntegerFactorizationPackage| 14) (85 . |factor|) (90 . |One|)
              (94 . |One|) (98 . |scalarMatrix|) (|Boolean|)
              (104 . |sizeLess?|) (110 . *) (116 . |vertConcat|)
              (|ModularHermitianRowReduction| 14) (122 . |rowEchelon|)
              (128 . |squareTop|)
              (|TriangularMatrixOperations| 14 (|Vector| 14) (|Vector| 14) 17)
              (133 . |UpTriBddDenomInv|)
              (|Record| (|:| |basis| 17) (|:| |basisDen| 14)
                        (|:| |basisInv| 17))
              |NFINTBAS;integralBasis;R;4| (139 . |exquo|)
              |NFINTBAS;localIntegralBasis;IR;5| (145 . |LowTriBddDenomInv|)
              (151 . |rowEchelon|) (|IntegralBasisTools| 14 6 7)
              (156 . |idealiser|) (163 . |diagonalProduct|) (168 . |matrixGcd|)
              (175 . |leastPower|) (181 . ^) (187 . |divideIfCan!|) (195 . ~=)
              |NFINTBAS;discriminant;I;8|)
           '#(|localIntegralBasis| 201 |integralBasis| 206 |discriminant| 210)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|discriminant| ((|Integer|))) T)
                                   '((|integralBasis|
                                      ((|Record|
                                        (|:| |basis| (|Matrix| (|Integer|)))
                                        (|:| |basisDen| (|Integer|))
                                        (|:| |basisInv|
                                             (|Matrix| (|Integer|))))))
                                     T)
                                   '((|localIntegralBasis|
                                      ((|Record|
                                        (|:| |basis| (|Matrix| (|Integer|)))
                                        (|:| |basisDen| (|Integer|))
                                        (|:| |basisInv|
                                             (|Matrix| (|Integer|))))
                                       (|Integer|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 64
                                            '(0 7 8 9 0 7 10 11 0 6 0 12 0 7 0
                                              13 1 15 14 0 16 1 17 14 0 18 1 17
                                              14 0 19 2 7 0 14 0 20 2 7 0 0 0
                                              21 2 7 0 0 22 23 1 7 17 10 24 1
                                              17 0 0 25 2 17 0 0 0 26 2 17 27 0
                                              14 28 1 32 31 0 33 0 7 17 34 1 17
                                              14 0 35 1 36 32 14 37 0 6 0 38 0
                                              7 0 39 2 17 0 22 14 40 2 14 41 0
                                              0 42 2 17 0 14 0 43 2 17 0 0 0 44
                                              2 45 17 17 14 46 1 17 0 0 47 2 48
                                              17 17 14 49 2 14 27 0 0 52 2 48
                                              17 17 14 54 1 17 0 0 55 3 56 17
                                              17 17 14 57 1 56 14 17 58 3 56 14
                                              17 14 22 59 2 56 22 22 22 60 2 17
                                              0 0 22 61 4 56 14 17 17 14 14 62
                                              2 14 41 0 0 63 1 0 50 14 53 0 0
                                              50 51 0 0 14 64)))))
           '|lookupComplete|)) 
