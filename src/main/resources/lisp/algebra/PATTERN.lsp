
(SDEFUN |PATTERN;coerce;R$;1| ((|r| (R)) ($ ($)))
        (|PATTERN;mkPat| 'T (CONS 0 |r|) 0 $)) 

(SDEFUN |PATTERN;mkPat|
        ((|c| (|Boolean|))
         (|p|
          (|Union| (|:| |ret| R)
                   (|:| |ker|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |op| (|BasicOperator|))
                                  (|:| |arg| (|List| $))))
                   (|:| |exp|
                        (|Record| (|:| |val| $)
                                  (|:| |exponent| (|NonNegativeInteger|))))
                   (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                   (|:| |sym|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |val| (|Symbol|))
                                  (|:| |pred| (|List| (|Any|)))
                                  (|:| |bad| (|List| (|Any|)))))))
         (|l| (|NonNegativeInteger|)) ($ ($)))
        (VECTOR |c| |p| |l| NIL (QREFELT $ 17))) 

(SDEFUN |PATTERN;hasTopPredicate?;$B;3| ((|x| ($)) ($ (|Boolean|)))
        (NULL (NULL (QVELT |x| 3)))) 

(SDEFUN |PATTERN;topPredicate;$R;4|
        ((|x| ($))
         ($ (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |pred| (|Any|)))))
        (CONS (QVELT |x| 3) (QVELT |x| 4))) 

(SDEFUN |PATTERN;setTopPredicate;$LA$;5|
        ((|x| ($)) (|l| (|List| (|Symbol|))) (|f| (|Any|)) ($ ($)))
        (SEQ (QSETVELT |x| 3 |l|) (QSETVELT |x| 4 |f|) (EXIT |x|))) 

(PUT '|PATTERN;constant?;$B;6| '|SPADreplace| '(XLAM (|p|) (QVELT |p| 0))) 

(SDEFUN |PATTERN;constant?;$B;6| ((|p| ($)) ($ (|Boolean|))) (QVELT |p| 0)) 

(PUT '|PATTERN;depth;$Nni;7| '|SPADreplace| '(XLAM (|p|) (QVELT |p| 2))) 

(SDEFUN |PATTERN;depth;$Nni;7| ((|p| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |p| 2)) 

(SDEFUN |PATTERN;inR?;$B;8| ((|p| ($)) ($ (|Boolean|)))
        (QEQCAR (QVELT |p| 1) 0)) 

(SDEFUN |PATTERN;symbol?;$B;9| ((|p| ($)) ($ (|Boolean|)))
        (QEQCAR (QVELT |p| 1) 4)) 

(SDEFUN |PATTERN;isPlus;$U;10| ((|p| ($)) ($ (|Union| (|List| $) "failed")))
        (|PATTERN;isTaggedOp| |p| 1 $)) 

(SDEFUN |PATTERN;isTimes;$U;11| ((|p| ($)) ($ (|Union| (|List| $) "failed")))
        (|PATTERN;isTaggedOp| |p| 2 $)) 

(SDEFUN |PATTERN;isList;$U;12| ((|p| ($)) ($ (|Union| (|List| $) "failed")))
        (|PATTERN;isTaggedOp| |p| 3 $)) 

(SDEFUN |PATTERN;isExpt;$U;13|
        ((|p| ($))
         ($
          (|Union|
           (|Record| (|:| |val| $) (|:| |exponent| (|NonNegativeInteger|)))
           "failed")))
        (SPROG ((#1=#:G746 NIL))
               (COND
                ((QEQCAR (QVELT |p| 1) 2)
                 (CONS 0
                       (PROG2 (LETT #1# (QVELT |p| 1))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 2)
                                         (|Record| (|:| |val| $)
                                                   (|:| |exponent|
                                                        (|NonNegativeInteger|)))
                                         (|Union| (|:| |ret| (QREFELT $ 6))
                                                  (|:| |ker|
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |op|
                                                             (|BasicOperator|))
                                                        (|:| |arg|
                                                             (|List| $))))
                                                  (|:| |exp|
                                                       (|Record| (|:| |val| $)
                                                                 (|:|
                                                                  |exponent|
                                                                  (|NonNegativeInteger|))))
                                                  (|:| |qot|
                                                       (|Record| (|:| |num| $)
                                                                 (|:| |den|
                                                                      $)))
                                                  (|:| |sym|
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |val| (|Symbol|))
                                                        (|:| |pred|
                                                             (|List| (|Any|)))
                                                        (|:| |bad|
                                                             (|List|
                                                              (|Any|))))))
                                         #1#))))
                ('T (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;isQuotient;$U;14|
        ((|p| ($))
         ($ (|Union| (|Record| (|:| |num| $) (|:| |den| $)) "failed")))
        (SPROG ((#1=#:G747 NIL))
               (COND
                ((QEQCAR (QVELT |p| 1) 3)
                 (CONS 0
                       (PROG2 (LETT #1# (QVELT |p| 1))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 3)
                                         (|Record| (|:| |num| $) (|:| |den| $))
                                         (|Union| (|:| |ret| (QREFELT $ 6))
                                                  (|:| |ker|
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |op|
                                                             (|BasicOperator|))
                                                        (|:| |arg|
                                                             (|List| $))))
                                                  (|:| |exp|
                                                       (|Record| (|:| |val| $)
                                                                 (|:|
                                                                  |exponent|
                                                                  (|NonNegativeInteger|))))
                                                  (|:| |qot|
                                                       (|Record| (|:| |num| $)
                                                                 (|:| |den|
                                                                      $)))
                                                  (|:| |sym|
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |val| (|Symbol|))
                                                        (|:| |pred|
                                                             (|List| (|Any|)))
                                                        (|:| |bad|
                                                             (|List|
                                                              (|Any|))))))
                                         #1#))))
                ('T (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;hasPredicate?;$B;15| ((|p| ($)) ($ (|Boolean|)))
        (NULL (NULL (SPADCALL |p| (QREFELT $ 41))))) 

(SDEFUN |PATTERN;quoted?;$B;16| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 29))
                 (ZEROP
                  (QVELT
                   (PROG2 (LETT #1# (QVELT |p| 1))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 4)
                                     (|Record| (|:| |tag| (|SingleInteger|))
                                               (|:| |val| (|Symbol|))
                                               (|:| |pred| (|List| (|Any|)))
                                               (|:| |bad| (|List| (|Any|))))
                                     (|Union| (|:| |ret| (QREFELT $ 6))
                                              (|:| |ker|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |op|
                                                         (|BasicOperator|))
                                                    (|:| |arg| (|List| $))))
                                              (|:| |exp|
                                                   (|Record| (|:| |val| $)
                                                             (|:| |exponent|
                                                                  (|NonNegativeInteger|))))
                                              (|:| |qot|
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $)))
                                              (|:| |sym|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))))
                                     #1#))
                   0)))
                ('T NIL)))) 

(SDEFUN |PATTERN;generic?;$B;17| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 29))
                 (|PATTERN;bitSet?|
                  (QVELT
                   (PROG2 (LETT #1# (QVELT |p| 1))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 4)
                                     (|Record| (|:| |tag| (|SingleInteger|))
                                               (|:| |val| (|Symbol|))
                                               (|:| |pred| (|List| (|Any|)))
                                               (|:| |bad| (|List| (|Any|))))
                                     (|Union| (|:| |ret| (QREFELT $ 6))
                                              (|:| |ker|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |op|
                                                         (|BasicOperator|))
                                                    (|:| |arg| (|List| $))))
                                              (|:| |exp|
                                                   (|Record| (|:| |val| $)
                                                             (|:| |exponent|
                                                                  (|NonNegativeInteger|))))
                                              (|:| |qot|
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $)))
                                              (|:| |sym|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))))
                                     #1#))
                   0)
                  1 $))
                ('T NIL)))) 

(SDEFUN |PATTERN;multiple?;$B;18| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 29))
                 (|PATTERN;bitSet?|
                  (QVELT
                   (PROG2 (LETT #1# (QVELT |p| 1))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 4)
                                     (|Record| (|:| |tag| (|SingleInteger|))
                                               (|:| |val| (|Symbol|))
                                               (|:| |pred| (|List| (|Any|)))
                                               (|:| |bad| (|List| (|Any|))))
                                     (|Union| (|:| |ret| (QREFELT $ 6))
                                              (|:| |ker|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |op|
                                                         (|BasicOperator|))
                                                    (|:| |arg| (|List| $))))
                                              (|:| |exp|
                                                   (|Record| (|:| |val| $)
                                                             (|:| |exponent|
                                                                  (|NonNegativeInteger|))))
                                              (|:| |qot|
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $)))
                                              (|:| |sym|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))))
                                     #1#))
                   0)
                  2 $))
                ('T NIL)))) 

(SDEFUN |PATTERN;optional?;$B;19| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 29))
                 (|PATTERN;bitSet?|
                  (QVELT
                   (PROG2 (LETT #1# (QVELT |p| 1))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 4)
                                     (|Record| (|:| |tag| (|SingleInteger|))
                                               (|:| |val| (|Symbol|))
                                               (|:| |pred| (|List| (|Any|)))
                                               (|:| |bad| (|List| (|Any|))))
                                     (|Union| (|:| |ret| (QREFELT $ 6))
                                              (|:| |ker|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |op|
                                                         (|BasicOperator|))
                                                    (|:| |arg| (|List| $))))
                                              (|:| |exp|
                                                   (|Record| (|:| |val| $)
                                                             (|:| |exponent|
                                                                  (|NonNegativeInteger|))))
                                              (|:| |qot|
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $)))
                                              (|:| |sym|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))))
                                     #1#))
                   0)
                  4 $))
                ('T NIL)))) 

(SDEFUN |PATTERN;bitSet?|
        ((|a| (|SingleInteger|)) (|b| (|SingleInteger|)) ($ (|Boolean|)))
        (SPADCALL (|and_SI| |a| |b|) 0 (QREFELT $ 48))) 

(SDEFUN |PATTERN;coerce;$Of;21| ((|p| ($)) ($ (|OutputForm|)))
        (|PATTERN;PAT2O| (QVELT |p| 1) $)) 

(SDEFUN |PATTERN;^;3$;22| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (|PATTERN;taggedElt| 6 (LIST |p1| |p2|) $)) 

(SDEFUN |PATTERN;LPAT2O|
        ((|f| (|Mapping| (|OutputForm|) (|OutputForm|) (|OutputForm|)))
         (|l| (|List| $)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G830 NIL) (|x| NIL) (#2=#:G829 NIL))
               (SEQ
                (SPADCALL |f|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |x| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |x| (QREFELT $ 50))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 54))))) 

(SDEFUN |PATTERN;retract;$R;24| ((|p| ($)) ($ (R)))
        (SPROG ((#1=#:G744 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 28))
                 (PROG2 (LETT #1# (QVELT |p| 1))
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                   (|Union| (|:| |ret| (QREFELT $ 6))
                                            (|:| |ker|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $))))
                                            (|:| |exp|
                                                 (|Record| (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                            (|:| |qot|
                                                 (|Record| (|:| |num| $)
                                                           (|:| |den| $)))
                                            (|:| |sym|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad|
                                                       (|List| (|Any|))))))
                                   #1#)))
                ('T (|error| "Not retractable"))))) 

(SDEFUN |PATTERN;convert;L$;25| ((|l| (|List| $)) ($ ($)))
        (|PATTERN;taggedElt| 3 |l| $)) 

(SDEFUN |PATTERN;retractIfCan;$U;26| ((|p| ($)) ($ (|Union| R "failed")))
        (SPROG ((#1=#:G744 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 28))
                 (CONS 0
                       (PROG2 (LETT #1# (QVELT |p| 1))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                         (|Union| (|:| |ret| (QREFELT $ 6))
                                                  (|:| |ker|
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |op|
                                                             (|BasicOperator|))
                                                        (|:| |arg|
                                                             (|List| $))))
                                                  (|:| |exp|
                                                       (|Record| (|:| |val| $)
                                                                 (|:|
                                                                  |exponent|
                                                                  (|NonNegativeInteger|))))
                                                  (|:| |qot|
                                                       (|Record| (|:| |num| $)
                                                                 (|:| |den|
                                                                      $)))
                                                  (|:| |sym|
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |val| (|Symbol|))
                                                        (|:| |pred|
                                                             (|List| (|Any|)))
                                                        (|:| |bad|
                                                             (|List|
                                                              (|Any|))))))
                                         #1#))))
                ('T (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;withPredicates;$L$;27|
        ((|p| ($)) (|l| (|List| (|Any|))) ($ ($)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 60)) |l| (QREFELT $ 61))) 

(SDEFUN |PATTERN;coerce;S$;28| ((|sy| (|Symbol|)) ($ ($)))
        (SPADCALL |sy| NIL NIL NIL (QREFELT $ 63))) 

(SDEFUN |PATTERN;copy;2$;29| ((|p| ($)) ($ ($)))
        (VECTOR (SPADCALL |p| (QREFELT $ 25))
                (|PATTERN;patcopy| (QVELT |p| 1) $) (QVELT |p| 2) (QVELT |p| 3)
                (QVELT |p| 4))) 

(SDEFUN |PATTERN;optpair;LU;30|
        ((|l| (|List| $)) ($ (|Union| (|List| $) "failed")))
        (SPROG ((|a| ($)) (|b| ($)))
               (SEQ
                (COND
                 ((SPADCALL
                   (SPADCALL (SPADCALL |l| (QREFELT $ 66)) (QREFELT $ 66))
                   (QREFELT $ 67))
                  (SEQ
                   (LETT |b|
                         (SPADCALL (SPADCALL |l| (QREFELT $ 66))
                                   (QREFELT $ 68)))
                   (EXIT
                    (COND
                     ((SPADCALL (LETT |a| (SPADCALL |l| (QREFELT $ 68)))
                                (QREFELT $ 46))
                      (CONS 0 |l|))
                     ((SPADCALL |b| (QREFELT $ 46))
                      (CONS 0 (SPADCALL |l| (QREFELT $ 69))))
                     (#1='T (CONS 1 "failed"))))))
                 (#1# (CONS 1 "failed")))))) 

(SDEFUN |PATTERN;incmax| ((|l| (|List| $)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G858 NIL) (|p| NIL) (#2=#:G857 NIL))
               (SEQ
                (+ 1
                   (SPADCALL (ELT $ 72)
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |p| NIL) (LETT #1# |l|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |p| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT (LETT #2# (CONS (QVELT |p| 2) #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#))))
                             0 (QREFELT $ 75)))))) 

(SDEFUN |PATTERN;=;2$B;32| ((|p1| ($)) (|p2| ($)) ($ (|Boolean|)))
        (COND
         ((|BooleanEquality| (QVELT |p1| 0) (QVELT |p2| 0))
          (COND
           ((EQL (QVELT |p1| 2) (QVELT |p2| 2))
            (COND
             ((SPADCALL (QVELT |p1| 3) (QVELT |p2| 3) (QREFELT $ 76))
              (COND
               ((EQ (QVELT |p1| 4) (QVELT |p2| 4))
                (|PATTERN;pateq?| (QVELT |p1| 1) (QVELT |p2| 1) $))
               (#1='T NIL)))
             (#1# NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |PATTERN;isPower;$U;33|
        ((|p| ($))
         ($ (|Union| (|Record| (|:| |val| $) (|:| |exponent| $)) "failed")))
        (SPROG ((|u| (|Union| (|List| $) "failed")))
               (SEQ (LETT |u| (|PATTERN;isTaggedOp| |p| 6 $))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (CONS (SPADCALL (QCDR |u|) (QREFELT $ 68))
                                        (SPADCALL (QCDR |u|)
                                                  (QREFELT $ 78)))))))))) 

(SDEFUN |PATTERN;taggedElt| ((|n| (|SingleInteger|)) (|l| (|List| $)) ($ ($)))
        (|PATTERN;mkPat| (SPADCALL (ELT $ 25) |l| (QREFELT $ 83))
         (CONS 1 (VECTOR |n| (QREFELT $ 12) |l|)) (|PATTERN;incmax| |l| $) $)) 

(SDEFUN |PATTERN;elt;BoL$;35|
        ((|o| (|BasicOperator|)) (|l| (|List| $)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |o| '|%power| (QREFELT $ 84))
           (COND
            ((EQL (SPADCALL |l| (QREFELT $ 85)) 2)
             (EXIT
              (SPADCALL (SPADCALL |l| (QREFELT $ 68))
                        (SPADCALL |l| (QREFELT $ 86)) (QREFELT $ 51)))))))
         (EXIT
          (|PATTERN;mkPat| (SPADCALL (ELT $ 25) |l| (QREFELT $ 83))
           (CONS 1 (VECTOR 0 |o| |l|)) (|PATTERN;incmax| |l| $) $)))) 

(SDEFUN |PATTERN;isOp;$U;36|
        ((|p| ($))
         ($
          (|Union|
           (|Record| (|:| |op| (|BasicOperator|)) (|:| |arg| (|List| $)))
           "failed")))
        (SPROG ((#1=#:G745 NIL))
               (SEQ
                (COND
                 ((QEQCAR (QVELT |p| 1) 1)
                  (COND
                   ((ZEROP
                     (QVELT
                      (PROG2 (LETT #1# (QVELT |p| 1))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 1)
                                        (|Record| (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $)))
                                        (|Union| (|:| |ret| (QREFELT $ 6))
                                                 (|:| |ker|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |op|
                                                            (|BasicOperator|))
                                                       (|:| |arg| (|List| $))))
                                                 (|:| |exp|
                                                      (|Record| (|:| |val| $)
                                                                (|:| |exponent|
                                                                     (|NonNegativeInteger|))))
                                                 (|:| |qot|
                                                      (|Record| (|:| |num| $)
                                                                (|:| |den| $)))
                                                 (|:| |sym|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |val| (|Symbol|))
                                                       (|:| |pred|
                                                            (|List| (|Any|)))
                                                       (|:| |bad|
                                                            (|List|
                                                             (|Any|))))))
                                        #1#))
                      0))
                    (EXIT
                     (CONS 0
                           (CONS
                            (QVELT
                             (PROG2 (LETT #1# (QVELT |p| 1))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 1)
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |op| (|BasicOperator|))
                                                (|:| |arg| (|List| $)))
                                               (|Union|
                                                (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                               #1#))
                             1)
                            (QVELT
                             (PROG2 (LETT #1# (QVELT |p| 1))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 1)
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |op| (|BasicOperator|))
                                                (|:| |arg| (|List| $)))
                                               (|Union|
                                                (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                               #1#))
                             2))))))))
                (EXIT (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;isTaggedOp|
        ((|p| ($)) (|t| (|SingleInteger|)) ($ (|Union| (|List| $) "failed")))
        (SPROG ((#1=#:G745 NIL))
               (SEQ
                (COND
                 ((QEQCAR (QVELT |p| 1) 1)
                  (COND
                   ((|eql_SI|
                     (QVELT
                      (PROG2 (LETT #1# (QVELT |p| 1))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 1)
                                        (|Record| (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $)))
                                        (|Union| (|:| |ret| (QREFELT $ 6))
                                                 (|:| |ker|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |op|
                                                            (|BasicOperator|))
                                                       (|:| |arg| (|List| $))))
                                                 (|:| |exp|
                                                      (|Record| (|:| |val| $)
                                                                (|:| |exponent|
                                                                     (|NonNegativeInteger|))))
                                                 (|:| |qot|
                                                      (|Record| (|:| |num| $)
                                                                (|:| |den| $)))
                                                 (|:| |sym|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |val| (|Symbol|))
                                                       (|:| |pred|
                                                            (|List| (|Any|)))
                                                       (|:| |bad|
                                                            (|List|
                                                             (|Any|))))))
                                        #1#))
                      0)
                     |t|)
                    (EXIT
                     (CONS 0
                           (QVELT
                            (PROG2 (LETT #1# (QVELT |p| 1))
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 1)
                                              (|Record|
                                               (|:| |tag| (|SingleInteger|))
                                               (|:| |op| (|BasicOperator|))
                                               (|:| |arg| (|List| $)))
                                              (|Union|
                                               (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                              #1#))
                            2)))))))
                (EXIT (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;One;$;38| (($ ($)))
        (SPADCALL (|spadConstant| $ 92) (QREFELT $ 18))) 

(SDEFUN |PATTERN;One;$;39| (($ ($)))
        (|PATTERN;taggedElt| 5 (SPADCALL (QREFELT $ 93)) $)) 

(SDEFUN |PATTERN;Zero;$;40| (($ ($)))
        (SPADCALL (|spadConstant| $ 94) (QREFELT $ 18))) 

(SDEFUN |PATTERN;Zero;$;41| (($ ($)))
        (|PATTERN;taggedElt| 4 (SPADCALL (QREFELT $ 93)) $)) 

(SDEFUN |PATTERN;^;$Nni$;42| ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (|spadConstant| $ 87) (QREFELT $ 77))
           (COND ((> |n| 0) (EXIT (|spadConstant| $ 87))))))
         (COND
          ((OR (SPADCALL |p| (|spadConstant| $ 71) (QREFELT $ 77)) (ZEROP |n|))
           (EXIT (|spadConstant| $ 71))))
         (EXIT
          (COND ((EQL |n| 1) |p|)
                ('T
                 (|PATTERN;mkPat| (SPADCALL |p| (QREFELT $ 25))
                  (CONS 2 (CONS |p| |n|)) (+ 1 (QVELT |p| 2)) $)))))) 

(SDEFUN |PATTERN;/;3$;43| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (COND ((SPADCALL |p2| (|spadConstant| $ 71) (QREFELT $ 77)) |p1|)
              (#1='T
               (|PATTERN;mkPat|
                (COND
                 ((SPADCALL |p1| (QREFELT $ 25))
                  (SPADCALL |p2| (QREFELT $ 25)))
                 (#1# NIL))
                (CONS 3 (CONS |p1| |p2|))
                (+ 1 (MAX (QVELT |p1| 2) (QVELT |p2| 2))) $)))) 

(SDEFUN |PATTERN;+;3$;44| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG ((|u2| #1=(|Union| (|List| $) "failed")) (|u1| #1#))
               (SEQ
                (COND
                 ((SPADCALL |p1| (|spadConstant| $ 87) (QREFELT $ 77)) |p2|)
                 ((SPADCALL |p2| (|spadConstant| $ 87) (QREFELT $ 77)) |p1|)
                 (#2='T
                  (SEQ (LETT |u1| (SPADCALL |p1| (QREFELT $ 31)))
                       (EXIT
                        (COND
                         ((QEQCAR |u1| 0)
                          (SEQ (LETT |u2| (SPADCALL |p2| (QREFELT $ 31)))
                               (EXIT
                                (COND
                                 ((QEQCAR |u2| 0)
                                  (|PATTERN;taggedElt| 1
                                   (SPADCALL (QCDR |u1|) (QCDR |u2|)
                                             (QREFELT $ 97))
                                   $))
                                 (#2#
                                  (|PATTERN;taggedElt| 1
                                   (SPADCALL (QCDR |u1|) |p2| (QREFELT $ 98))
                                   $))))))
                         (#2#
                          (SEQ (LETT |u2| (SPADCALL |p2| (QREFELT $ 31)))
                               (EXIT
                                (COND
                                 ((QEQCAR |u2| 0)
                                  (|PATTERN;taggedElt| 1
                                   (SPADCALL |p1| (QCDR |u2|) (QREFELT $ 99))
                                   $))
                                 (#2#
                                  (|PATTERN;taggedElt| 1 (LIST |p1| |p2|)
                                   $)))))))))))))) 

(SDEFUN |PATTERN;*;3$;45| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG ((|u2| #1=(|Union| (|List| $) "failed")) (|u1| #1#))
               (SEQ
                (COND
                 ((OR (SPADCALL |p1| (|spadConstant| $ 87) (QREFELT $ 77))
                      (SPADCALL |p2| (|spadConstant| $ 87) (QREFELT $ 77)))
                  (|spadConstant| $ 87))
                 ('T
                  (COND
                   ((SPADCALL |p1| (|spadConstant| $ 71) (QREFELT $ 77)) |p2|)
                   ((SPADCALL |p2| (|spadConstant| $ 71) (QREFELT $ 77)) |p1|)
                   (#2='T
                    (SEQ (LETT |u1| (SPADCALL |p1| (QREFELT $ 32)))
                         (EXIT
                          (COND
                           ((QEQCAR |u1| 0)
                            (SEQ (LETT |u2| (SPADCALL |p2| (QREFELT $ 32)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |u2| 0)
                                    (|PATTERN;taggedElt| 2
                                     (SPADCALL (QCDR |u1|) (QCDR |u2|)
                                               (QREFELT $ 97))
                                     $))
                                   (#2#
                                    (|PATTERN;taggedElt| 2
                                     (SPADCALL (QCDR |u1|) |p2| (QREFELT $ 98))
                                     $))))))
                           (#2#
                            (SEQ (LETT |u2| (SPADCALL |p2| (QREFELT $ 32)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |u2| 0)
                                    (|PATTERN;taggedElt| 2
                                     (SPADCALL |p1| (QCDR |u2|) (QREFELT $ 99))
                                     $))
                                   (#2#
                                    (|PATTERN;taggedElt| 2 (LIST |p1| |p2|)
                                     $)))))))))))))))) 

(SDEFUN |PATTERN;isOp;$BoU;46|
        ((|p| ($)) (|o| (|BasicOperator|)) ($ (|Union| (|List| $) "failed")))
        (SPROG ((#1=#:G745 NIL))
               (SEQ
                (COND
                 ((QEQCAR (QVELT |p| 1) 1)
                  (COND
                   ((ZEROP
                     (QVELT
                      (PROG2 (LETT #1# (QVELT |p| 1))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 1)
                                        (|Record| (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $)))
                                        (|Union| (|:| |ret| (QREFELT $ 6))
                                                 (|:| |ker|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |op|
                                                            (|BasicOperator|))
                                                       (|:| |arg| (|List| $))))
                                                 (|:| |exp|
                                                      (|Record| (|:| |val| $)
                                                                (|:| |exponent|
                                                                     (|NonNegativeInteger|))))
                                                 (|:| |qot|
                                                      (|Record| (|:| |num| $)
                                                                (|:| |den| $)))
                                                 (|:| |sym|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |val| (|Symbol|))
                                                       (|:| |pred|
                                                            (|List| (|Any|)))
                                                       (|:| |bad|
                                                            (|List|
                                                             (|Any|))))))
                                        #1#))
                      0))
                    (COND
                     ((SPADCALL
                       (QVELT
                        (PROG2 (LETT #1# (QVELT |p| 1))
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 1)
                                          (|Record|
                                           (|:| |tag| (|SingleInteger|))
                                           (|:| |op| (|BasicOperator|))
                                           (|:| |arg| (|List| $)))
                                          (|Union| (|:| |ret| (QREFELT $ 6))
                                                   (|:| |ker|
                                                        (|Record|
                                                         (|:| |tag|
                                                              (|SingleInteger|))
                                                         (|:| |op|
                                                              (|BasicOperator|))
                                                         (|:| |arg|
                                                              (|List| $))))
                                                   (|:| |exp|
                                                        (|Record| (|:| |val| $)
                                                                  (|:|
                                                                   |exponent|
                                                                   (|NonNegativeInteger|))))
                                                   (|:| |qot|
                                                        (|Record| (|:| |num| $)
                                                                  (|:| |den|
                                                                       $)))
                                                   (|:| |sym|
                                                        (|Record|
                                                         (|:| |tag|
                                                              (|SingleInteger|))
                                                         (|:| |val| (|Symbol|))
                                                         (|:| |pred|
                                                              (|List| (|Any|)))
                                                         (|:| |bad|
                                                              (|List|
                                                               (|Any|))))))
                                          #1#))
                        1)
                       |o| (QREFELT $ 102))
                      (EXIT
                       (CONS 0
                             (QVELT
                              (PROG2 (LETT #1# (QVELT |p| 1))
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 1)
                                                (|Record|
                                                 (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                                (|Union|
                                                 (|:| |ret| (QREFELT $ 6))
                                                 (|:| |ker|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |op|
                                                            (|BasicOperator|))
                                                       (|:| |arg| (|List| $))))
                                                 (|:| |exp|
                                                      (|Record| (|:| |val| $)
                                                                (|:| |exponent|
                                                                     (|NonNegativeInteger|))))
                                                 (|:| |qot|
                                                      (|Record| (|:| |num| $)
                                                                (|:| |den| $)))
                                                 (|:| |sym|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |val| (|Symbol|))
                                                       (|:| |pred|
                                                            (|List| (|Any|)))
                                                       (|:| |bad|
                                                            (|List|
                                                             (|Any|))))))
                                                #1#))
                              2)))))))))
                (EXIT (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;predicates;$L;47| ((|p| ($)) ($ (|List| (|Any|))))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 29))
                 (QVELT
                  (PROG2 (LETT #1# (QVELT |p| 1))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 4)
                                    (|Record| (|:| |tag| (|SingleInteger|))
                                              (|:| |val| (|Symbol|))
                                              (|:| |pred| (|List| (|Any|)))
                                              (|:| |bad| (|List| (|Any|))))
                                    (|Union| (|:| |ret| (QREFELT $ 6))
                                             (|:| |ker|
                                                  (|Record|
                                                   (|:| |tag|
                                                        (|SingleInteger|))
                                                   (|:| |op| (|BasicOperator|))
                                                   (|:| |arg| (|List| $))))
                                             (|:| |exp|
                                                  (|Record| (|:| |val| $)
                                                            (|:| |exponent|
                                                                 (|NonNegativeInteger|))))
                                             (|:| |qot|
                                                  (|Record| (|:| |num| $)
                                                            (|:| |den| $)))
                                             (|:| |sym|
                                                  (|Record|
                                                   (|:| |tag|
                                                        (|SingleInteger|))
                                                   (|:| |val| (|Symbol|))
                                                   (|:| |pred|
                                                        (|List| (|Any|)))
                                                   (|:| |bad|
                                                        (|List| (|Any|))))))
                                    #1#))
                  2))
                ('T NIL)))) 

(SDEFUN |PATTERN;setPredicates;$L$;48|
        ((|p| ($)) (|l| (|List| (|Any|))) ($ ($)))
        (SPROG ((#1=#:G748 NIL))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 44))
                  (SEQ
                   (QSETVELT
                    (PROG2 (LETT #1# (QVELT |p| 1))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 4)
                                      (|Record| (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #1#))
                    2 |l|)
                   (EXIT |p|)))
                 ('T
                  (|error| "Can only attach predicates to generic symbol")))))) 

(SDEFUN |PATTERN;resetBadValues;2$;49| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G748 NIL))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 44))
                  (SEQ
                   (QSETVELT
                    (PROG2 (LETT #1# (QVELT |p| 1))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 4)
                                      (|Record| (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #1#))
                    3 NIL)
                   (EXIT |p|)))
                 ('T
                  (|error| "Can only attach bad values to generic symbol")))))) 

(SDEFUN |PATTERN;addBadValue;$A$;50| ((|p| ($)) (|a| (|Any|)) ($ ($)))
        (SPROG ((#1=#:G748 NIL))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 44))
                  (SEQ
                   (COND
                    ((NULL
                      (SPADCALL |a|
                                (QVELT
                                 (PROG2 (LETT #1# (QVELT |p| 1))
                                     (QCDR #1#)
                                   (|check_union2| (QEQCAR #1# 4)
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))
                                                   (|Union|
                                                    (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                                   #1#))
                                 3)
                                (QREFELT $ 105)))
                     (QSETVELT
                      (PROG2 (LETT #1# (QVELT |p| 1))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 4)
                                        (|Record| (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad| (|List| (|Any|))))
                                        (|Union| (|:| |ret| (QREFELT $ 6))
                                                 (|:| |ker|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |op|
                                                            (|BasicOperator|))
                                                       (|:| |arg| (|List| $))))
                                                 (|:| |exp|
                                                      (|Record| (|:| |val| $)
                                                                (|:| |exponent|
                                                                     (|NonNegativeInteger|))))
                                                 (|:| |qot|
                                                      (|Record| (|:| |num| $)
                                                                (|:| |den| $)))
                                                 (|:| |sym|
                                                      (|Record|
                                                       (|:| |tag|
                                                            (|SingleInteger|))
                                                       (|:| |val| (|Symbol|))
                                                       (|:| |pred|
                                                            (|List| (|Any|)))
                                                       (|:| |bad|
                                                            (|List|
                                                             (|Any|))))))
                                        #1#))
                      3
                      (CONS |a|
                            (QVELT
                             (PROG2 (LETT #1# (QVELT |p| 1))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 4)
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))
                                               (|Union|
                                                (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                               #1#))
                             3)))))
                   (EXIT |p|)))
                 ('T
                  (|error| "Can only attach bad values to generic symbol")))))) 

(SDEFUN |PATTERN;getBadValues;$L;51| ((|p| ($)) ($ (|List| (|Any|))))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 44))
                 (QVELT
                  (PROG2 (LETT #1# (QVELT |p| 1))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 4)
                                    (|Record| (|:| |tag| (|SingleInteger|))
                                              (|:| |val| (|Symbol|))
                                              (|:| |pred| (|List| (|Any|)))
                                              (|:| |bad| (|List| (|Any|))))
                                    (|Union| (|:| |ret| (QREFELT $ 6))
                                             (|:| |ker|
                                                  (|Record|
                                                   (|:| |tag|
                                                        (|SingleInteger|))
                                                   (|:| |op| (|BasicOperator|))
                                                   (|:| |arg| (|List| $))))
                                             (|:| |exp|
                                                  (|Record| (|:| |val| $)
                                                            (|:| |exponent|
                                                                 (|NonNegativeInteger|))))
                                             (|:| |qot|
                                                  (|Record| (|:| |num| $)
                                                            (|:| |den| $)))
                                             (|:| |sym|
                                                  (|Record|
                                                   (|:| |tag|
                                                        (|SingleInteger|))
                                                   (|:| |val| (|Symbol|))
                                                   (|:| |pred|
                                                        (|List| (|Any|)))
                                                   (|:| |bad|
                                                        (|List| (|Any|))))))
                                    #1#))
                  3))
                ('T (|error| "Not a generic symbol"))))) 

(SDEFUN |PATTERN;SYM2O|
        ((|p|
          (|Record| (|:| |tag| (|SingleInteger|)) (|:| |val| (|Symbol|))
                    (|:| |pred| (|List| (|Any|)))
                    (|:| |bad| (|List| (|Any|)))))
         ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G978 NIL) (|i| NIL) (#2=#:G977 NIL) (|sy| (|OutputForm|)))
         (SEQ (LETT |sy| (SPADCALL (QVELT |p| 1) (QREFELT $ 108)))
              (EXIT
               (COND ((NULL (QVELT |p| 2)) |sy|)
                     ('T
                      (SPADCALL
                       (SPADCALL (SPADCALL " | " (QREFELT $ 110)) |sy|
                                 (SPADCALL (ELT $ 111)
                                           (PROGN
                                            (LETT #2# NIL)
                                            (SEQ (LETT |i| 1)
                                                 (LETT #1#
                                                       (LENGTH (QVELT |p| 2)))
                                                 G190
                                                 (COND
                                                  ((|greater_SI| |i| #1#)
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #2#
                                                         (CONS
                                                          (SPADCALL
                                                           (SPADCALL "f"
                                                                     (QREFELT $
                                                                              110))
                                                           (SPADCALL |i|
                                                                     (QREFELT $
                                                                              112))
                                                           (QREFELT $ 113))
                                                          #2#))))
                                                 (LETT |i| (|inc_SI| |i|))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #2#))))
                                           (QREFELT $ 54))
                                 (QREFELT $ 114))
                       (QREFELT $ 115)))))))) 

(SDEFUN |PATTERN;variables;$L;53| ((|p| ($)) ($ (|List| $)))
        (SPROG
         ((#1=#:G987 NIL) (#2=#:G745 NIL) (|r| NIL) (#3=#:G986 NIL)
          (#4=#:G747 NIL) (#5=#:G746 NIL)
          (|q|
           (|Union| (|:| |ret| R)
                    (|:| |ker|
                         (|Record| (|:| |tag| (|SingleInteger|))
                                   (|:| |op| (|BasicOperator|))
                                   (|:| |arg| (|List| $))))
                    (|:| |exp|
                         (|Record| (|:| |val| $)
                                   (|:| |exponent| (|NonNegativeInteger|))))
                    (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                    (|:| |sym|
                         (|Record| (|:| |tag| (|SingleInteger|))
                                   (|:| |val| (|Symbol|))
                                   (|:| |pred| (|List| (|Any|)))
                                   (|:| |bad| (|List| (|Any|))))))))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 25)) (SPADCALL (QREFELT $ 93)))
                ((SPADCALL |p| (QREFELT $ 44)) (LIST |p|))
                (#6='T
                 (SEQ (LETT |q| (QVELT |p| 1))
                      (EXIT
                       (COND ((QEQCAR |q| 0) (SPADCALL (QREFELT $ 93)))
                             ((QEQCAR |q| 2)
                              (SPADCALL
                               (QCAR
                                (PROG2 (LETT #5# |q|)
                                    (QCDR #5#)
                                  (|check_union2| (QEQCAR #5# 2)
                                                  (|Record| (|:| |val| $)
                                                            (|:| |exponent|
                                                                 (|NonNegativeInteger|)))
                                                  (|Union|
                                                   (|:| |ret| (QREFELT $ 6))
                                                   (|:| |ker|
                                                        (|Record|
                                                         (|:| |tag|
                                                              (|SingleInteger|))
                                                         (|:| |op|
                                                              (|BasicOperator|))
                                                         (|:| |arg|
                                                              (|List| $))))
                                                   (|:| |exp|
                                                        (|Record| (|:| |val| $)
                                                                  (|:|
                                                                   |exponent|
                                                                   (|NonNegativeInteger|))))
                                                   (|:| |qot|
                                                        (|Record| (|:| |num| $)
                                                                  (|:| |den|
                                                                       $)))
                                                   (|:| |sym|
                                                        (|Record|
                                                         (|:| |tag|
                                                              (|SingleInteger|))
                                                         (|:| |val| (|Symbol|))
                                                         (|:| |pred|
                                                              (|List| (|Any|)))
                                                         (|:| |bad|
                                                              (|List|
                                                               (|Any|))))))
                                                  #5#)))
                               (QREFELT $ 116)))
                             ((QEQCAR |q| 3)
                              (SPADCALL
                               (SPADCALL
                                (QCAR
                                 (PROG2 (LETT #4# |q|)
                                     (QCDR #4#)
                                   (|check_union2| (QEQCAR #4# 3)
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $))
                                                   (|Union|
                                                    (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                                   #4#)))
                                (QREFELT $ 116))
                               (SPADCALL
                                (QCDR
                                 (PROG2 (LETT #4# |q|)
                                     (QCDR #4#)
                                   (|check_union2| (QEQCAR #4# 3)
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $))
                                                   (|Union|
                                                    (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                                   #4#)))
                                (QREFELT $ 116))
                               (QREFELT $ 117)))
                             ((QEQCAR |q| 1)
                              (SPADCALL
                               (PROGN
                                (LETT #3# NIL)
                                (SEQ (LETT |r| NIL)
                                     (LETT #1#
                                           (QVELT
                                            (PROG2 (LETT #2# |q|)
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 1)
                                                              (|Record|
                                                               (|:| |tag|
                                                                    (|SingleInteger|))
                                                               (|:| |op|
                                                                    (|BasicOperator|))
                                                               (|:| |arg|
                                                                    (|List|
                                                                     $)))
                                                              (|Union|
                                                               (|:| |ret|
                                                                    (QREFELT $
                                                                             6))
                                                               (|:| |ker|
                                                                    (|Record|
                                                                     (|:| |tag|
                                                                          (|SingleInteger|))
                                                                     (|:| |op|
                                                                          (|BasicOperator|))
                                                                     (|:| |arg|
                                                                          (|List|
                                                                           $))))
                                                               (|:| |exp|
                                                                    (|Record|
                                                                     (|:| |val|
                                                                          $)
                                                                     (|:|
                                                                      |exponent|
                                                                      (|NonNegativeInteger|))))
                                                               (|:| |qot|
                                                                    (|Record|
                                                                     (|:| |num|
                                                                          $)
                                                                     (|:| |den|
                                                                          $)))
                                                               (|:| |sym|
                                                                    (|Record|
                                                                     (|:| |tag|
                                                                          (|SingleInteger|))
                                                                     (|:| |val|
                                                                          (|Symbol|))
                                                                     (|:|
                                                                      |pred|
                                                                      (|List|
                                                                       (|Any|)))
                                                                     (|:| |bad|
                                                                          (|List|
                                                                           (|Any|))))))
                                                              #2#))
                                            2))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |r| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #3#
                                             (CONS
                                              (SPADCALL |r| (QREFELT $ 116))
                                              #3#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #3#))))
                               (QREFELT $ 118)))
                             (#6# (SPADCALL (QREFELT $ 93))))))))))) 

(SDEFUN |PATTERN;PAT2O|
        ((|p|
          (|Union| (|:| |ret| R)
                   (|:| |ker|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |op| (|BasicOperator|))
                                  (|:| |arg| (|List| $))))
                   (|:| |exp|
                        (|Record| (|:| |val| $)
                                  (|:| |exponent| (|NonNegativeInteger|))))
                   (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                   (|:| |sym|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |val| (|Symbol|))
                                  (|:| |pred| (|List| (|Any|)))
                                  (|:| |bad| (|List| (|Any|)))))))
         ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G745 NIL)
          (|u|
           (|Union| (|Mapping| (|OutputForm|) (|List| (|OutputForm|)))
                    "failed"))
          (|l| (|List| (|OutputForm|))) (#2=#:G1007 NIL) (|x| NIL)
          (#3=#:G1006 NIL) (#4=#:G747 NIL) (#5=#:G746 NIL) (#6=#:G748 NIL))
         (SEQ
          (COND ((QEQCAR |p| 0) (SPADCALL (CDR |p|) (QREFELT $ 119)))
                ((QEQCAR |p| 4)
                 (|PATTERN;SYM2O|
                  (PROG2 (LETT #6# |p|)
                      (QCDR #6#)
                    (|check_union2| (QEQCAR #6# 4)
                                    (|Record| (|:| |tag| (|SingleInteger|))
                                              (|:| |val| (|Symbol|))
                                              (|:| |pred| (|List| (|Any|)))
                                              (|:| |bad| (|List| (|Any|))))
                                    (|Union| (|:| |ret| (QREFELT $ 6))
                                             (|:| |ker|
                                                  (|Record|
                                                   (|:| |tag|
                                                        (|SingleInteger|))
                                                   (|:| |op| (|BasicOperator|))
                                                   (|:| |arg| (|List| $))))
                                             (|:| |exp|
                                                  (|Record| (|:| |val| $)
                                                            (|:| |exponent|
                                                                 (|NonNegativeInteger|))))
                                             (|:| |qot|
                                                  (|Record| (|:| |num| $)
                                                            (|:| |den| $)))
                                             (|:| |sym|
                                                  (|Record|
                                                   (|:| |tag|
                                                        (|SingleInteger|))
                                                   (|:| |val| (|Symbol|))
                                                   (|:| |pred|
                                                        (|List| (|Any|)))
                                                   (|:| |bad|
                                                        (|List| (|Any|))))))
                                    #6#))
                  $))
                ((QEQCAR |p| 2)
                 (SPADCALL
                  (SPADCALL
                   (QCAR
                    (PROG2 (LETT #5# |p|)
                        (QCDR #5#)
                      (|check_union2| (QEQCAR #5# 2)
                                      (|Record| (|:| |val| $)
                                                (|:| |exponent|
                                                     (|NonNegativeInteger|)))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #5#)))
                   (QREFELT $ 50))
                  (SPADCALL
                   (QCDR
                    (PROG2 (LETT #5# |p|)
                        (QCDR #5#)
                      (|check_union2| (QEQCAR #5# 2)
                                      (|Record| (|:| |val| $)
                                                (|:| |exponent|
                                                     (|NonNegativeInteger|)))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #5#)))
                   (QREFELT $ 112))
                  (QREFELT $ 120)))
                ((QEQCAR |p| 3)
                 (SPADCALL
                  (SPADCALL
                   (QCAR
                    (PROG2 (LETT #4# |p|)
                        (QCDR #4#)
                      (|check_union2| (QEQCAR #4# 3)
                                      (|Record| (|:| |num| $) (|:| |den| $))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #4#)))
                   (QREFELT $ 50))
                  (SPADCALL
                   (QCDR
                    (PROG2 (LETT #4# |p|)
                        (QCDR #4#)
                      (|check_union2| (QEQCAR #4# 3)
                                      (|Record| (|:| |num| $) (|:| |den| $))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #4#)))
                   (QREFELT $ 50))
                  (QREFELT $ 121)))
                (#7='T
                 (COND
                  ((EQL
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     0)
                    1)
                   (|PATTERN;LPAT2O| (ELT $ 122)
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     2)
                    $))
                  ((|eql_SI|
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     0)
                    2)
                   (|PATTERN;LPAT2O| (ELT $ 123)
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     2)
                    $))
                  ((|eql_SI|
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     0)
                    3)
                   (SPADCALL
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     2)
                    (QREFELT $ 124)))
                  ((|eql_SI|
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     0)
                    4)
                   (SPADCALL 0 (QREFELT $ 125)))
                  ((|eql_SI|
                    (QVELT
                     (PROG2 (LETT #1# |p|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |tag| (|SingleInteger|))
                                                 (|:| |op| (|BasicOperator|))
                                                 (|:| |arg| (|List| $)))
                                       (|Union| (|:| |ret| (QREFELT $ 6))
                                                (|:| |ker|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |op|
                                                           (|BasicOperator|))
                                                      (|:| |arg| (|List| $))))
                                                (|:| |exp|
                                                     (|Record| (|:| |val| $)
                                                               (|:| |exponent|
                                                                    (|NonNegativeInteger|))))
                                                (|:| |qot|
                                                     (|Record| (|:| |num| $)
                                                               (|:| |den| $)))
                                                (|:| |sym|
                                                     (|Record|
                                                      (|:| |tag|
                                                           (|SingleInteger|))
                                                      (|:| |val| (|Symbol|))
                                                      (|:| |pred|
                                                           (|List| (|Any|)))
                                                      (|:| |bad|
                                                           (|List| (|Any|))))))
                                       #1#))
                     0)
                    5)
                   (SPADCALL 1 (QREFELT $ 125)))
                  (#7#
                   (SEQ
                    (LETT |l|
                          (PROGN
                           (LETT #3# NIL)
                           (SEQ (LETT |x| NIL)
                                (LETT #2#
                                      (QVELT
                                       (PROG2 (LETT #1# |p|)
                                           (QCDR #1#)
                                         (|check_union2| (QEQCAR #1# 1)
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $)))
                                                         (|Union|
                                                          (|:| |ret|
                                                               (QREFELT $ 6))
                                                          (|:| |ker|
                                                               (|Record|
                                                                (|:| |tag|
                                                                     (|SingleInteger|))
                                                                (|:| |op|
                                                                     (|BasicOperator|))
                                                                (|:| |arg|
                                                                     (|List|
                                                                      $))))
                                                          (|:| |exp|
                                                               (|Record|
                                                                (|:| |val| $)
                                                                (|:| |exponent|
                                                                     (|NonNegativeInteger|))))
                                                          (|:| |qot|
                                                               (|Record|
                                                                (|:| |num| $)
                                                                (|:| |den| $)))
                                                          (|:| |sym|
                                                               (|Record|
                                                                (|:| |tag|
                                                                     (|SingleInteger|))
                                                                (|:| |val|
                                                                     (|Symbol|))
                                                                (|:| |pred|
                                                                     (|List|
                                                                      (|Any|)))
                                                                (|:| |bad|
                                                                     (|List|
                                                                      (|Any|))))))
                                                         #1#))
                                       2))
                                G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |x| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #3#
                                        (CONS (SPADCALL |x| (QREFELT $ 50))
                                              #3#))))
                                (LETT #2# (CDR #2#)) (GO G190) G191
                                (EXIT (NREVERSE #3#)))))
                    (LETT |u|
                          (SPADCALL
                           (QVELT
                            (PROG2 (LETT #1# |p|)
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 1)
                                              (|Record|
                                               (|:| |tag| (|SingleInteger|))
                                               (|:| |op| (|BasicOperator|))
                                               (|:| |arg| (|List| $)))
                                              (|Union|
                                               (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                              #1#))
                            1)
                           (QREFELT $ 128)))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 1)
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (QVELT
                           (PROG2 (LETT #1# |p|)
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 1)
                                             (|Record|
                                              (|:| |tag| (|SingleInteger|))
                                              (|:| |op| (|BasicOperator|))
                                              (|:| |arg| (|List| $)))
                                             (|Union| (|:| |ret| (QREFELT $ 6))
                                                      (|:| |ker|
                                                           (|Record|
                                                            (|:| |tag|
                                                                 (|SingleInteger|))
                                                            (|:| |op|
                                                                 (|BasicOperator|))
                                                            (|:| |arg|
                                                                 (|List| $))))
                                                      (|:| |exp|
                                                           (|Record|
                                                            (|:| |val| $)
                                                            (|:| |exponent|
                                                                 (|NonNegativeInteger|))))
                                                      (|:| |qot|
                                                           (|Record|
                                                            (|:| |num| $)
                                                            (|:| |den| $)))
                                                      (|:| |sym|
                                                           (|Record|
                                                            (|:| |tag|
                                                                 (|SingleInteger|))
                                                            (|:| |val|
                                                                 (|Symbol|))
                                                            (|:| |pred|
                                                                 (|List|
                                                                  (|Any|)))
                                                            (|:| |bad|
                                                                 (|List|
                                                                  (|Any|))))))
                                             #1#))
                           1)
                          (QREFELT $ 129))
                         (QREFELT $ 108))
                        |l| (QREFELT $ 130)))
                      (#7# (SPADCALL |l| (QCDR |u|))))))))))))) 

(SDEFUN |PATTERN;patcopy|
        ((|p|
          (|Union| (|:| |ret| R)
                   (|:| |ker|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |op| (|BasicOperator|))
                                  (|:| |arg| (|List| $))))
                   (|:| |exp|
                        (|Record| (|:| |val| $)
                                  (|:| |exponent| (|NonNegativeInteger|))))
                   (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                   (|:| |sym|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |val| (|Symbol|))
                                  (|:| |pred| (|List| (|Any|)))
                                  (|:| |bad| (|List| (|Any|)))))))
         ($
          (|Union| (|:| |ret| R)
                   (|:| |ker|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |op| (|BasicOperator|))
                                  (|:| |arg| (|List| $))))
                   (|:| |exp|
                        (|Record| (|:| |val| $)
                                  (|:| |exponent| (|NonNegativeInteger|))))
                   (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                   (|:| |sym|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |val| (|Symbol|))
                                  (|:| |pred| (|List| (|Any|)))
                                  (|:| |bad| (|List| (|Any|))))))))
        (SPROG
         ((#1=#:G746 NIL) (#2=#:G747 NIL) (#3=#:G1018 NIL) (#4=#:G745 NIL)
          (|x| NIL) (#5=#:G1017 NIL) (#6=#:G748 NIL))
         (SEQ
          (COND ((QEQCAR |p| 0) (CONS 0 (CDR |p|)))
                ((QEQCAR |p| 4)
                 (CONS 4
                       (VECTOR
                        (QVELT
                         (PROG2 (LETT #6# |p|)
                             (QCDR #6#)
                           (|check_union2| (QEQCAR #6# 4)
                                           (|Record|
                                            (|:| |tag| (|SingleInteger|))
                                            (|:| |val| (|Symbol|))
                                            (|:| |pred| (|List| (|Any|)))
                                            (|:| |bad| (|List| (|Any|))))
                                           (|Union| (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                           #6#))
                         0)
                        (QVELT
                         (PROG2 (LETT #6# |p|)
                             (QCDR #6#)
                           (|check_union2| (QEQCAR #6# 4)
                                           (|Record|
                                            (|:| |tag| (|SingleInteger|))
                                            (|:| |val| (|Symbol|))
                                            (|:| |pred| (|List| (|Any|)))
                                            (|:| |bad| (|List| (|Any|))))
                                           (|Union| (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                           #6#))
                         1)
                        (SPADCALL
                         (QVELT
                          (PROG2 (LETT #6# |p|)
                              (QCDR #6#)
                            (|check_union2| (QEQCAR #6# 4)
                                            (|Record|
                                             (|:| |tag| (|SingleInteger|))
                                             (|:| |val| (|Symbol|))
                                             (|:| |pred| (|List| (|Any|)))
                                             (|:| |bad| (|List| (|Any|))))
                                            (|Union| (|:| |ret| (QREFELT $ 6))
                                                     (|:| |ker|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |op|
                                                                (|BasicOperator|))
                                                           (|:| |arg|
                                                                (|List| $))))
                                                     (|:| |exp|
                                                          (|Record|
                                                           (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                                     (|:| |qot|
                                                          (|Record|
                                                           (|:| |num| $)
                                                           (|:| |den| $)))
                                                     (|:| |sym|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |val|
                                                                (|Symbol|))
                                                           (|:| |pred|
                                                                (|List|
                                                                 (|Any|)))
                                                           (|:| |bad|
                                                                (|List|
                                                                 (|Any|))))))
                                            #6#))
                          2)
                         (QREFELT $ 131))
                        (SPADCALL
                         (QVELT
                          (PROG2 (LETT #6# |p|)
                              (QCDR #6#)
                            (|check_union2| (QEQCAR #6# 4)
                                            (|Record|
                                             (|:| |tag| (|SingleInteger|))
                                             (|:| |val| (|Symbol|))
                                             (|:| |pred| (|List| (|Any|)))
                                             (|:| |bad| (|List| (|Any|))))
                                            (|Union| (|:| |ret| (QREFELT $ 6))
                                                     (|:| |ker|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |op|
                                                                (|BasicOperator|))
                                                           (|:| |arg|
                                                                (|List| $))))
                                                     (|:| |exp|
                                                          (|Record|
                                                           (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                                     (|:| |qot|
                                                          (|Record|
                                                           (|:| |num| $)
                                                           (|:| |den| $)))
                                                     (|:| |sym|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |val|
                                                                (|Symbol|))
                                                           (|:| |pred|
                                                                (|List|
                                                                 (|Any|)))
                                                           (|:| |bad|
                                                                (|List|
                                                                 (|Any|))))))
                                            #6#))
                          3)
                         (QREFELT $ 131)))))
                ((QEQCAR |p| 1)
                 (CONS 1
                       (VECTOR
                        (QVELT
                         (PROG2 (LETT #4# |p|)
                             (QCDR #4#)
                           (|check_union2| (QEQCAR #4# 1)
                                           (|Record|
                                            (|:| |tag| (|SingleInteger|))
                                            (|:| |op| (|BasicOperator|))
                                            (|:| |arg| (|List| $)))
                                           (|Union| (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                           #4#))
                         0)
                        (QVELT
                         (PROG2 (LETT #4# |p|)
                             (QCDR #4#)
                           (|check_union2| (QEQCAR #4# 1)
                                           (|Record|
                                            (|:| |tag| (|SingleInteger|))
                                            (|:| |op| (|BasicOperator|))
                                            (|:| |arg| (|List| $)))
                                           (|Union| (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                           #4#))
                         1)
                        (PROGN
                         (LETT #5# NIL)
                         (SEQ (LETT |x| NIL)
                              (LETT #3#
                                    (QVELT
                                     (PROG2 (LETT #4# |p|)
                                         (QCDR #4#)
                                       (|check_union2| (QEQCAR #4# 1)
                                                       (|Record|
                                                        (|:| |tag|
                                                             (|SingleInteger|))
                                                        (|:| |op|
                                                             (|BasicOperator|))
                                                        (|:| |arg| (|List| $)))
                                                       (|Union|
                                                        (|:| |ret|
                                                             (QREFELT $ 6))
                                                        (|:| |ker|
                                                             (|Record|
                                                              (|:| |tag|
                                                                   (|SingleInteger|))
                                                              (|:| |op|
                                                                   (|BasicOperator|))
                                                              (|:| |arg|
                                                                   (|List|
                                                                    $))))
                                                        (|:| |exp|
                                                             (|Record|
                                                              (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                                        (|:| |qot|
                                                             (|Record|
                                                              (|:| |num| $)
                                                              (|:| |den| $)))
                                                        (|:| |sym|
                                                             (|Record|
                                                              (|:| |tag|
                                                                   (|SingleInteger|))
                                                              (|:| |val|
                                                                   (|Symbol|))
                                                              (|:| |pred|
                                                                   (|List|
                                                                    (|Any|)))
                                                              (|:| |bad|
                                                                   (|List|
                                                                    (|Any|))))))
                                                       #4#))
                                     2))
                              G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |x| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #5#
                                      (CONS (SPADCALL |x| (QREFELT $ 60))
                                            #5#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #5#)))))))
                ((QEQCAR |p| 3)
                 (CONS 3
                       (CONS
                        (SPADCALL
                         (QCAR
                          (PROG2 (LETT #2# |p|)
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 3)
                                            (|Record| (|:| |num| $)
                                                      (|:| |den| $))
                                            (|Union| (|:| |ret| (QREFELT $ 6))
                                                     (|:| |ker|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |op|
                                                                (|BasicOperator|))
                                                           (|:| |arg|
                                                                (|List| $))))
                                                     (|:| |exp|
                                                          (|Record|
                                                           (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                                     (|:| |qot|
                                                          (|Record|
                                                           (|:| |num| $)
                                                           (|:| |den| $)))
                                                     (|:| |sym|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |val|
                                                                (|Symbol|))
                                                           (|:| |pred|
                                                                (|List|
                                                                 (|Any|)))
                                                           (|:| |bad|
                                                                (|List|
                                                                 (|Any|))))))
                                            #2#)))
                         (QREFELT $ 60))
                        (SPADCALL
                         (QCDR
                          (PROG2 (LETT #2# |p|)
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 3)
                                            (|Record| (|:| |num| $)
                                                      (|:| |den| $))
                                            (|Union| (|:| |ret| (QREFELT $ 6))
                                                     (|:| |ker|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |op|
                                                                (|BasicOperator|))
                                                           (|:| |arg|
                                                                (|List| $))))
                                                     (|:| |exp|
                                                          (|Record|
                                                           (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                                     (|:| |qot|
                                                          (|Record|
                                                           (|:| |num| $)
                                                           (|:| |den| $)))
                                                     (|:| |sym|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |val|
                                                                (|Symbol|))
                                                           (|:| |pred|
                                                                (|List|
                                                                 (|Any|)))
                                                           (|:| |bad|
                                                                (|List|
                                                                 (|Any|))))))
                                            #2#)))
                         (QREFELT $ 60)))))
                ('T
                 (CONS 2
                       (CONS
                        (SPADCALL
                         (QCAR
                          (PROG2 (LETT #1# |p|)
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 2)
                                            (|Record| (|:| |val| $)
                                                      (|:| |exponent|
                                                           (|NonNegativeInteger|)))
                                            (|Union| (|:| |ret| (QREFELT $ 6))
                                                     (|:| |ker|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |op|
                                                                (|BasicOperator|))
                                                           (|:| |arg|
                                                                (|List| $))))
                                                     (|:| |exp|
                                                          (|Record|
                                                           (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                                     (|:| |qot|
                                                          (|Record|
                                                           (|:| |num| $)
                                                           (|:| |den| $)))
                                                     (|:| |sym|
                                                          (|Record|
                                                           (|:| |tag|
                                                                (|SingleInteger|))
                                                           (|:| |val|
                                                                (|Symbol|))
                                                           (|:| |pred|
                                                                (|List|
                                                                 (|Any|)))
                                                           (|:| |bad|
                                                                (|List|
                                                                 (|Any|))))))
                                            #1#)))
                         (QREFELT $ 60))
                        (QCDR
                         (PROG2 (LETT #1# |p|)
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 2)
                                           (|Record| (|:| |val| $)
                                                     (|:| |exponent|
                                                          (|NonNegativeInteger|)))
                                           (|Union| (|:| |ret| (QREFELT $ 6))
                                                    (|:| |ker|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |op|
                                                               (|BasicOperator|))
                                                          (|:| |arg|
                                                               (|List| $))))
                                                    (|:| |exp|
                                                         (|Record|
                                                          (|:| |val| $)
                                                          (|:| |exponent|
                                                               (|NonNegativeInteger|))))
                                                    (|:| |qot|
                                                         (|Record|
                                                          (|:| |num| $)
                                                          (|:| |den| $)))
                                                    (|:| |sym|
                                                         (|Record|
                                                          (|:| |tag|
                                                               (|SingleInteger|))
                                                          (|:| |val|
                                                               (|Symbol|))
                                                          (|:| |pred|
                                                               (|List|
                                                                (|Any|)))
                                                          (|:| |bad|
                                                               (|List|
                                                                (|Any|))))))
                                           #1#)))))))))) 

(SDEFUN |PATTERN;pateq?|
        ((|p1|
          (|Union| (|:| |ret| R)
                   (|:| |ker|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |op| (|BasicOperator|))
                                  (|:| |arg| (|List| $))))
                   (|:| |exp|
                        (|Record| (|:| |val| $)
                                  (|:| |exponent| (|NonNegativeInteger|))))
                   (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                   (|:| |sym|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |val| (|Symbol|))
                                  (|:| |pred| (|List| (|Any|)))
                                  (|:| |bad| (|List| (|Any|)))))))
         (|p2|
          (|Union| (|:| |ret| R)
                   (|:| |ker|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |op| (|BasicOperator|))
                                  (|:| |arg| (|List| $))))
                   (|:| |exp|
                        (|Record| (|:| |val| $)
                                  (|:| |exponent| (|NonNegativeInteger|))))
                   (|:| |qot| (|Record| (|:| |num| $) (|:| |den| $)))
                   (|:| |sym|
                        (|Record| (|:| |tag| (|SingleInteger|))
                                  (|:| |val| (|Symbol|))
                                  (|:| |pred| (|List| (|Any|)))
                                  (|:| |bad| (|List| (|Any|)))))))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G746 NIL) (#2=#:G745 NIL) (#3=#:G748 NIL) (#4=#:G747 NIL))
         (COND
          ((QEQCAR |p1| 0)
           (COND
            ((QEQCAR |p2| 0) (SPADCALL (CDR |p1|) (CDR |p2|) (QREFELT $ 132)))
            (#5='T NIL)))
          ((QEQCAR |p1| 3)
           (COND
            ((QEQCAR |p2| 3)
             (COND
              ((SPADCALL
                (QCAR
                 (PROG2 (LETT #4# |p1|)
                     (QCDR #4#)
                   (|check_union2| (QEQCAR #4# 3)
                                   (|Record| (|:| |num| $) (|:| |den| $))
                                   (|Union| (|:| |ret| (QREFELT $ 6))
                                            (|:| |ker|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $))))
                                            (|:| |exp|
                                                 (|Record| (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                            (|:| |qot|
                                                 (|Record| (|:| |num| $)
                                                           (|:| |den| $)))
                                            (|:| |sym|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad|
                                                       (|List| (|Any|))))))
                                   #4#)))
                (QCAR (CDR |p2|)) (QREFELT $ 77))
               (SPADCALL
                (QCDR
                 (PROG2 (LETT #4# |p1|)
                     (QCDR #4#)
                   (|check_union2| (QEQCAR #4# 3)
                                   (|Record| (|:| |num| $) (|:| |den| $))
                                   (|Union| (|:| |ret| (QREFELT $ 6))
                                            (|:| |ker|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $))))
                                            (|:| |exp|
                                                 (|Record| (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                            (|:| |qot|
                                                 (|Record| (|:| |num| $)
                                                           (|:| |den| $)))
                                            (|:| |sym|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad|
                                                       (|List| (|Any|))))))
                                   #4#)))
                (QCDR (CDR |p2|)) (QREFELT $ 77)))
              (#5# NIL)))
            (#5# NIL)))
          ((QEQCAR |p1| 4)
           (COND
            ((QEQCAR |p2| 4)
             (COND
              ((EQUAL
                (QVELT
                 (PROG2 (LETT #3# |p1|)
                     (QCDR #3#)
                   (|check_union2| (QEQCAR #3# 4)
                                   (|Record| (|:| |tag| (|SingleInteger|))
                                             (|:| |val| (|Symbol|))
                                             (|:| |pred| (|List| (|Any|)))
                                             (|:| |bad| (|List| (|Any|))))
                                   (|Union| (|:| |ret| (QREFELT $ 6))
                                            (|:| |ker|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $))))
                                            (|:| |exp|
                                                 (|Record| (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                            (|:| |qot|
                                                 (|Record| (|:| |num| $)
                                                           (|:| |den| $)))
                                            (|:| |sym|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad|
                                                       (|List| (|Any|))))))
                                   #3#))
                 1)
                (QVELT (CDR |p2|) 1))
               (COND
                ((SPADCALL
                  (SPADCALL
                   (QVELT
                    (PROG2 (LETT #3# |p1|)
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 4)
                                      (|Record| (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #3#))
                    2)
                   (QREFELT $ 134))
                  (SPADCALL (QVELT (CDR |p2|) 2) (QREFELT $ 134))
                  (QREFELT $ 135))
                 (SPADCALL
                  (SPADCALL
                   (QVELT
                    (PROG2 (LETT #3# |p1|)
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 4)
                                      (|Record| (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))
                                      (|Union| (|:| |ret| (QREFELT $ 6))
                                               (|:| |ker|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |op|
                                                          (|BasicOperator|))
                                                     (|:| |arg| (|List| $))))
                                               (|:| |exp|
                                                    (|Record| (|:| |val| $)
                                                              (|:| |exponent|
                                                                   (|NonNegativeInteger|))))
                                               (|:| |qot|
                                                    (|Record| (|:| |num| $)
                                                              (|:| |den| $)))
                                               (|:| |sym|
                                                    (|Record|
                                                     (|:| |tag|
                                                          (|SingleInteger|))
                                                     (|:| |val| (|Symbol|))
                                                     (|:| |pred|
                                                          (|List| (|Any|)))
                                                     (|:| |bad|
                                                          (|List| (|Any|))))))
                                      #3#))
                    3)
                   (QREFELT $ 134))
                  (SPADCALL (QVELT (CDR |p2|) 3) (QREFELT $ 134))
                  (QREFELT $ 135)))
                (#5# NIL)))
              (#5# NIL)))
            (#5# NIL)))
          ((QEQCAR |p1| 1)
           (COND
            ((QEQCAR |p2| 1)
             (COND
              ((EQL
                (QVELT
                 (PROG2 (LETT #2# |p1|)
                     (QCDR #2#)
                   (|check_union2| (QEQCAR #2# 1)
                                   (|Record| (|:| |tag| (|SingleInteger|))
                                             (|:| |op| (|BasicOperator|))
                                             (|:| |arg| (|List| $)))
                                   (|Union| (|:| |ret| (QREFELT $ 6))
                                            (|:| |ker|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $))))
                                            (|:| |exp|
                                                 (|Record| (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                            (|:| |qot|
                                                 (|Record| (|:| |num| $)
                                                           (|:| |den| $)))
                                            (|:| |sym|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad|
                                                       (|List| (|Any|))))))
                                   #2#))
                 0)
                (QVELT (CDR |p2|) 0))
               (COND
                ((SPADCALL
                  (QVELT
                   (PROG2 (LETT #2# |p1|)
                       (QCDR #2#)
                     (|check_union2| (QEQCAR #2# 1)
                                     (|Record| (|:| |tag| (|SingleInteger|))
                                               (|:| |op| (|BasicOperator|))
                                               (|:| |arg| (|List| $)))
                                     (|Union| (|:| |ret| (QREFELT $ 6))
                                              (|:| |ker|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |op|
                                                         (|BasicOperator|))
                                                    (|:| |arg| (|List| $))))
                                              (|:| |exp|
                                                   (|Record| (|:| |val| $)
                                                             (|:| |exponent|
                                                                  (|NonNegativeInteger|))))
                                              (|:| |qot|
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $)))
                                              (|:| |sym|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))))
                                     #2#))
                   1)
                  (QVELT (CDR |p2|) 1) (QREFELT $ 102))
                 (SPADCALL
                  (QVELT
                   (PROG2 (LETT #2# |p1|)
                       (QCDR #2#)
                     (|check_union2| (QEQCAR #2# 1)
                                     (|Record| (|:| |tag| (|SingleInteger|))
                                               (|:| |op| (|BasicOperator|))
                                               (|:| |arg| (|List| $)))
                                     (|Union| (|:| |ret| (QREFELT $ 6))
                                              (|:| |ker|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |op|
                                                         (|BasicOperator|))
                                                    (|:| |arg| (|List| $))))
                                              (|:| |exp|
                                                   (|Record| (|:| |val| $)
                                                             (|:| |exponent|
                                                                  (|NonNegativeInteger|))))
                                              (|:| |qot|
                                                   (|Record| (|:| |num| $)
                                                             (|:| |den| $)))
                                              (|:| |sym|
                                                   (|Record|
                                                    (|:| |tag|
                                                         (|SingleInteger|))
                                                    (|:| |val| (|Symbol|))
                                                    (|:| |pred|
                                                         (|List| (|Any|)))
                                                    (|:| |bad|
                                                         (|List| (|Any|))))))
                                     #2#))
                   2)
                  (QVELT (CDR |p2|) 2) (QREFELT $ 136)))
                (#5# NIL)))
              (#5# NIL)))
            (#5# NIL)))
          ((QEQCAR |p2| 2)
           (COND
            ((EQL
              (QCDR
               (PROG2 (LETT #1# |p1|)
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 2)
                                 (|Record| (|:| |val| $)
                                           (|:| |exponent|
                                                (|NonNegativeInteger|)))
                                 (|Union| (|:| |ret| (QREFELT $ 6))
                                          (|:| |ker|
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |op| (|BasicOperator|))
                                                (|:| |arg| (|List| $))))
                                          (|:| |exp|
                                               (|Record| (|:| |val| $)
                                                         (|:| |exponent|
                                                              (|NonNegativeInteger|))))
                                          (|:| |qot|
                                               (|Record| (|:| |num| $)
                                                         (|:| |den| $)))
                                          (|:| |sym|
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))))
                                 #1#)))
              (QCDR (CDR |p2|)))
             (SPADCALL
              (QCAR
               (PROG2 (LETT #1# |p1|)
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 2)
                                 (|Record| (|:| |val| $)
                                           (|:| |exponent|
                                                (|NonNegativeInteger|)))
                                 (|Union| (|:| |ret| (QREFELT $ 6))
                                          (|:| |ker|
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |op| (|BasicOperator|))
                                                (|:| |arg| (|List| $))))
                                          (|:| |exp|
                                               (|Record| (|:| |val| $)
                                                         (|:| |exponent|
                                                              (|NonNegativeInteger|))))
                                          (|:| |qot|
                                               (|Record| (|:| |num| $)
                                                         (|:| |den| $)))
                                          (|:| |sym|
                                               (|Record|
                                                (|:| |tag| (|SingleInteger|))
                                                (|:| |val| (|Symbol|))
                                                (|:| |pred| (|List| (|Any|)))
                                                (|:| |bad| (|List| (|Any|))))))
                                 #1#)))
              (QCAR (CDR |p2|)) (QREFELT $ 77)))
            (#5# NIL)))
          (#5# NIL)))) 

(SDEFUN |PATTERN;retractIfCan;$U;57|
        ((|p| ($)) ($ (|Union| (|Symbol|) "failed")))
        (SPROG ((#1=#:G748 NIL))
               (COND
                ((SPADCALL |p| (QREFELT $ 29))
                 (CONS 0
                       (QVELT
                        (PROG2 (LETT #1# (QVELT |p| 1))
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 4)
                                          (|Record|
                                           (|:| |tag| (|SingleInteger|))
                                           (|:| |val| (|Symbol|))
                                           (|:| |pred| (|List| (|Any|)))
                                           (|:| |bad| (|List| (|Any|))))
                                          (|Union| (|:| |ret| (QREFELT $ 6))
                                                   (|:| |ker|
                                                        (|Record|
                                                         (|:| |tag|
                                                              (|SingleInteger|))
                                                         (|:| |op|
                                                              (|BasicOperator|))
                                                         (|:| |arg|
                                                              (|List| $))))
                                                   (|:| |exp|
                                                        (|Record| (|:| |val| $)
                                                                  (|:|
                                                                   |exponent|
                                                                   (|NonNegativeInteger|))))
                                                   (|:| |qot|
                                                        (|Record| (|:| |num| $)
                                                                  (|:| |den|
                                                                       $)))
                                                   (|:| |sym|
                                                        (|Record|
                                                         (|:| |tag|
                                                              (|SingleInteger|))
                                                         (|:| |val| (|Symbol|))
                                                         (|:| |pred|
                                                              (|List| (|Any|)))
                                                         (|:| |bad|
                                                              (|List|
                                                               (|Any|))))))
                                          #1#))
                        1)))
                ('T (CONS 1 "failed"))))) 

(SDEFUN |PATTERN;mkrsy|
        ((|t| (|Symbol|)) (|c?| (|Boolean|)) (|o?| (|Boolean|))
         (|m?| (|Boolean|))
         ($
          (|Record| (|:| |tag| (|SingleInteger|)) (|:| |val| (|Symbol|))
                    (|:| |pred| (|List| (|Any|)))
                    (|:| |bad| (|List| (|Any|))))))
        (SPROG ((|opt| #1=(|SingleInteger|)) (|mlt| #1#))
               (SEQ
                (COND (|c?| (VECTOR 0 |t| NIL NIL))
                      (#2='T
                       (SEQ (LETT |mlt| (COND (|m?| 2) (#2# 0)))
                            (LETT |opt| (COND (|o?| 4) (#2# 0)))
                            (EXIT
                             (VECTOR (|or_SI| (|or_SI| 1 |mlt|) |opt|) |t| NIL
                                     NIL)))))))) 

(SDEFUN |PATTERN;patternVariable;S3B$;59|
        ((|sy| (|Symbol|)) (|c?| (|Boolean|)) (|o?| (|Boolean|))
         (|m?| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rsy|
           (|Record| (|:| |tag| (|SingleInteger|)) (|:| |val| (|Symbol|))
                     (|:| |pred| (|List| (|Any|)))
                     (|:| |bad| (|List| (|Any|))))))
         (SEQ (LETT |rsy| (|PATTERN;mkrsy| |sy| |c?| |o?| |m?| $))
              (EXIT
               (|PATTERN;mkPat| (ZEROP (QVELT |rsy| 0)) (CONS 4 |rsy|) 0 $))))) 

(DECLAIM (NOTINLINE |Pattern;|)) 

(DEFUN |Pattern| (#1=#:G1039)
  (SPROG NIL
         (PROG (#2=#:G1040)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Pattern|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Pattern;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Pattern|)))))))))) 

(DEFUN |Pattern;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Pattern| DV$1))
          (LETT $ (GETREFV 140))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Pattern| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |cons?| (|Boolean|))
                              (|:| |pat|
                                   (|Union| (|:| |ret| |#1|)
                                            (|:| |ker|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |op| (|BasicOperator|))
                                                  (|:| |arg| (|List| $))))
                                            (|:| |exp|
                                                 (|Record| (|:| |val| $)
                                                           (|:| |exponent|
                                                                (|NonNegativeInteger|))))
                                            (|:| |qot|
                                                 (|Record| (|:| |num| $)
                                                           (|:| |den| $)))
                                            (|:| |sym|
                                                 (|Record|
                                                  (|:| |tag| (|SingleInteger|))
                                                  (|:| |val| (|Symbol|))
                                                  (|:| |pred| (|List| (|Any|)))
                                                  (|:| |bad|
                                                       (|List| (|Any|)))))))
                              (|:| |lev| (|NonNegativeInteger|))
                              (|:| |topvar| (|List| (|Symbol|)))
                              (|:| |toppred| (|Any|))))
          (QSETREFV $ 12 (SPADCALL (SPADCALL (QREFELT $ 9)) (QREFELT $ 11)))
          (QSETREFV $ 17 (SPADCALL 0 (QREFELT $ 16)))
          (COND
           ((|HasCategory| |#1| '(|Monoid|))
            (QSETREFV $ 71
                      (CONS #'|makeSpadConstant|
                            (LIST (|dispatchFunction| |PATTERN;One;$;38|) $
                                  71))))
           ('T
            (QSETREFV $ 71
                      (CONS #'|makeSpadConstant|
                            (LIST (|dispatchFunction| |PATTERN;One;$;39|) $
                                  71)))))
          (COND
           ((|HasCategory| |#1| '(|AbelianMonoid|))
            (QSETREFV $ 87
                      (CONS #'|makeSpadConstant|
                            (LIST (|dispatchFunction| |PATTERN;Zero;$;40|) $
                                  87))))
           ('T
            (QSETREFV $ 87
                      (CONS #'|makeSpadConstant|
                            (LIST (|dispatchFunction| |PATTERN;Zero;$;41|) $
                                  87)))))
          $))) 

(MAKEPROP '|Pattern| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Symbol|)
              (0 . |new|) (|BasicOperator|) (4 . |operator|) '|dummy| (|Any|)
              (|Integer|) (|AnyFunctions1| 14) (9 . |coerce|) '|nopred|
              |PATTERN;coerce;R$;1| (|Boolean|) |PATTERN;hasTopPredicate?;$B;3|
              (|Record| (|:| |var| 23) (|:| |pred| 13))
              |PATTERN;topPredicate;$R;4| (|List| 8)
              |PATTERN;setTopPredicate;$LA$;5| |PATTERN;constant?;$B;6|
              (|NonNegativeInteger|) |PATTERN;depth;$Nni;7| |PATTERN;inR?;$B;8|
              |PATTERN;symbol?;$B;9| (|Union| 56 '"failed")
              |PATTERN;isPlus;$U;10| |PATTERN;isTimes;$U;11|
              |PATTERN;isList;$U;12|
              (|Record| (|:| |val| $) (|:| |exponent| 26))
              (|Union| 34 '"failed") |PATTERN;isExpt;$U;13|
              (|Record| (|:| |num| $) (|:| |den| $)) (|Union| 37 '"failed")
              |PATTERN;isQuotient;$U;14| (|List| 13) |PATTERN;predicates;$L;47|
              |PATTERN;hasPredicate?;$B;15| |PATTERN;quoted?;$B;16|
              |PATTERN;generic?;$B;17| |PATTERN;multiple?;$B;18|
              |PATTERN;optional?;$B;19| (|SingleInteger|) (14 . ~=)
              (|OutputForm|) |PATTERN;coerce;$Of;21| |PATTERN;^;3$;22|
              (|Mapping| 49 49 49) (|List| 49) (20 . |reduce|)
              |PATTERN;retract;$R;24| (|List| $) |PATTERN;convert;L$;25|
              (|Union| 6 '"failed") |PATTERN;retractIfCan;$U;26|
              |PATTERN;copy;2$;29| |PATTERN;setPredicates;$L$;48|
              |PATTERN;withPredicates;$L$;27| |PATTERN;patternVariable;S3B$;59|
              |PATTERN;coerce;S$;28| (|List| $$) (26 . |rest|) (31 . |empty?|)
              (36 . |first|) (41 . |reverse|) |PATTERN;optpair;LU;30|
              (46 . |One|) (50 . |max|) (|Mapping| 26 26 26) (|List| 26)
              (56 . |reduce|) (63 . =) |PATTERN;=;2$B;32| (69 . |second|)
              (|Record| (|:| |val| $) (|:| |exponent| $))
              (|Union| 79 '"failed") |PATTERN;isPower;$U;33| (|Mapping| 19 $$)
              (74 . |every?|) (80 . |is?|) (86 . |#|) (91 . |last|)
              (96 . |Zero|) |PATTERN;elt;BoL$;35|
              (|Record| (|:| |op| 10) (|:| |arg| 56)) (|Union| 89 '"failed")
              |PATTERN;isOp;$U;36| (100 . |One|) (104 . |empty|) (108 . |Zero|)
              |PATTERN;^;$Nni$;42| |PATTERN;/;3$;43| (112 . |concat|)
              (118 . |concat|) (124 . |concat|) |PATTERN;+;3$;44|
              |PATTERN;*;3$;45| (130 . =) |PATTERN;isOp;$BoU;46|
              |PATTERN;resetBadValues;2$;49| (136 . |member?|)
              |PATTERN;addBadValue;$A$;50| |PATTERN;getBadValues;$L;51|
              (142 . |coerce|) (|String|) (147 . |message|) (152 . |and|)
              (158 . |coerce|) (163 . |sub|) (169 . |infix|) (176 . |paren|)
              |PATTERN;variables;$L;53| (181 . |concat!|) (187 . |concat|)
              (192 . |coerce|) (197 . ^) (203 . /) (209 . +) (215 . *)
              (221 . |coerce|) (226 . |coerce|) (|Mapping| 49 53)
              (|Union| 126 '"failed") (231 . |display|) (236 . |name|)
              (241 . |prefix|) (247 . |copy|) (252 . =) (|Set| 13)
              (258 . |set|) (263 . =) (269 . =) (|Union| 8 '"failed")
              |PATTERN;retractIfCan;$U;57| (|HashState|))
           '#(~= 275 |withPredicates| 281 |variables| 287 |topPredicate| 292
              |symbol?| 297 |setTopPredicate| 302 |setPredicates| 309
              |retractIfCan| 315 |retract| 325 |resetBadValues| 335 |quoted?|
              340 |predicates| 345 |patternVariable| 350 |optpair| 358
              |optional?| 363 |multiple?| 368 |latex| 373 |isTimes| 378
              |isQuotient| 383 |isPower| 388 |isPlus| 393 |isOp| 398 |isList|
              409 |isExpt| 414 |inR?| 419 |hashUpdate!| 424 |hash| 430
              |hasTopPredicate?| 435 |hasPredicate?| 440 |getBadValues| 445
              |generic?| 450 |elt| 455 |depth| 461 |copy| 466 |convert| 471
              |constant?| 476 |coerce| 481 |addBadValue| 496 ^ 502 |Zero| 514
              |One| 518 = 522 / 528 + 534 * 540)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0))
                 (CONS
                  '#(|SetCategory&| |RetractableTo&| |RetractableTo&|
                     |BasicType&| NIL NIL NIL)
                  (CONS
                   '#((|SetCategory|) (|RetractableTo| 8) (|RetractableTo| 6)
                      (|BasicType|) (|CoercibleFrom| 8) (|CoercibleFrom| 6)
                      (|CoercibleTo| 49))
                   (|makeByteWordVec2| 139
                                       '(0 8 0 9 1 10 0 8 11 1 15 13 14 16 2 47
                                         19 0 0 48 2 53 49 52 0 54 1 65 0 0 66
                                         1 65 19 0 67 1 65 2 0 68 1 65 0 0 69 0
                                         0 0 71 2 26 0 0 0 72 3 74 26 73 0 26
                                         75 2 23 19 0 0 76 1 65 2 0 78 2 65 19
                                         82 0 83 2 10 19 0 8 84 1 65 26 0 85 1
                                         65 2 0 86 0 0 0 87 0 6 0 92 0 65 0 93
                                         0 6 0 94 2 65 0 0 0 97 2 65 0 0 2 98 2
                                         65 0 2 0 99 2 10 19 0 0 102 2 40 19 13
                                         0 105 1 8 49 0 108 1 49 0 109 110 2 49
                                         0 0 0 111 1 26 49 0 112 2 49 0 0 0 113
                                         3 49 0 0 0 0 114 1 49 0 0 115 2 65 0 0
                                         0 117 1 65 0 56 118 1 6 49 0 119 2 49
                                         0 0 0 120 2 49 0 0 0 121 2 49 0 0 0
                                         122 2 49 0 0 0 123 1 65 49 0 124 1 14
                                         49 0 125 1 10 127 0 128 1 10 8 0 129 2
                                         49 0 0 56 130 1 40 0 0 131 2 6 19 0 0
                                         132 1 133 0 40 134 2 133 19 0 0 135 2
                                         65 19 0 0 136 2 0 19 0 0 1 2 0 0 0 40
                                         62 1 0 56 0 116 1 0 21 0 22 1 0 19 0
                                         29 3 0 0 0 23 13 24 2 0 0 0 40 61 1 0
                                         137 0 138 1 0 58 0 59 1 0 8 0 1 1 0 6
                                         0 55 1 0 0 0 104 1 0 19 0 43 1 0 40 0
                                         41 4 0 0 8 19 19 19 63 1 0 30 56 70 1
                                         0 19 0 46 1 0 19 0 45 1 0 109 0 1 1 0
                                         30 0 32 1 0 38 0 39 1 0 80 0 81 1 0 30
                                         0 31 1 0 90 0 91 2 0 30 0 10 103 1 0
                                         30 0 33 1 0 35 0 36 1 0 19 0 28 2 0
                                         139 139 0 1 1 0 47 0 1 1 0 19 0 20 1 0
                                         19 0 42 1 0 40 0 107 1 0 19 0 44 2 0 0
                                         10 56 88 1 0 26 0 27 1 0 0 0 60 1 0 0
                                         56 57 1 0 19 0 25 1 0 0 8 64 1 0 0 6
                                         18 1 0 49 0 50 2 0 0 0 13 106 2 0 0 0
                                         0 51 2 0 0 0 26 95 0 0 0 87 0 0 0 71 2
                                         0 19 0 0 77 2 0 0 0 0 96 2 0 0 0 0 100
                                         2 0 0 0 0 101)))))
           '|lookupComplete|)) 
