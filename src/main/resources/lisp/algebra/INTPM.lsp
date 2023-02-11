
(SDEFUN |INTPM;mkalist|
        ((|res| (|PatternMatchResult| (|Integer|) F))
         ($ (|AssociationList| (|Symbol|) F)))
        (SPADCALL (SPADCALL |res| (QREFELT $ 53)) (QREFELT $ 55))) 

(SDEFUN |INTPM;splitConstant;FSR;2|
        ((|f| (F)) (|x| (|Symbol|))
         ($ (|Record| (|:| |const| F) (|:| |nconst| F))))
        (SPROG
         ((#1=#:G770 NIL) (|rec| (|Record| (|:| |const| F) (|:| |nconst| F)))
          (|vv| (|Record| (|:| |val| F) (|:| |exponent| (|Integer|))))
          (|v|
           (|Union| (|Record| (|:| |val| F) (|:| |exponent| (|Integer|)))
                    #2="failed"))
          (|cc| (F)) (#3=#:G772 NIL) (|g| NIL) (|nc| (F))
          (|u| (|Union| (|List| F) #2#)) (#4=#:G771 NIL))
         (SEQ
          (EXIT
           (COND
            ((NULL (SPADCALL |x| (SPADCALL |f| (QREFELT $ 23)) (QREFELT $ 56)))
             (CONS |f| (|spadConstant| $ 44)))
            ('T
             (COND
              ((QEQCAR (SPADCALL |f| (QREFELT $ 59)) 0)
               (CONS (|spadConstant| $ 44) |f|))
              (#5='T
               (SEQ (LETT |u| (SPADCALL |f| (QREFELT $ 61)))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 0)
                       (SEQ (LETT |cc| (LETT |nc| (|spadConstant| $ 44)))
                            (SEQ (LETT |g| NIL) (LETT #4# (QCDR |u|)) G190
                                 (COND
                                  ((OR (ATOM #4#)
                                       (PROGN (LETT |g| (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |rec|
                                        (SPADCALL |g| |x| (QREFELT $ 63)))
                                  (LETT |cc|
                                        (SPADCALL |cc| (QCAR |rec|)
                                                  (QREFELT $ 64)))
                                  (EXIT
                                   (LETT |nc|
                                         (SPADCALL |nc| (QCDR |rec|)
                                                   (QREFELT $ 64)))))
                                 (LETT #4# (CDR #4#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT (CONS |cc| |nc|))))
                      (#5#
                       (SEQ (LETT |u| (SPADCALL |f| (QREFELT $ 65)))
                            (EXIT
                             (COND
                              ((QEQCAR |u| 0)
                               (SEQ
                                (LETT |rec|
                                      (SPADCALL (|SPADfirst| (QCDR |u|)) |x|
                                                (QREFELT $ 63)))
                                (LETT |cc| (QCAR |rec|))
                                (LETT |nc| (QCDR |rec|))
                                (SEQ (LETT |g| NIL) (LETT #3# (CDR (QCDR |u|)))
                                     G190
                                     (COND
                                      ((OR (ATOM #3#)
                                           (PROGN (LETT |g| (CAR #3#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |rec|
                                            (SPADCALL |g| |x| (QREFELT $ 63)))
                                      (EXIT
                                       (COND
                                        ((SPADCALL (QCDR |rec|) |nc|
                                                   (QREFELT $ 66))
                                         (LETT |cc|
                                               (SPADCALL |cc| (QCAR |rec|)
                                                         (QREFELT $ 67))))
                                        ((SPADCALL (QCDR |rec|)
                                                   (SPADCALL |nc|
                                                             (QREFELT $ 68))
                                                   (QREFELT $ 66))
                                         (LETT |cc|
                                               (SPADCALL |cc| (QCAR |rec|)
                                                         (QREFELT $ 69))))
                                        ('T
                                         (PROGN
                                          (LETT #1#
                                                (CONS (|spadConstant| $ 44)
                                                      |f|))
                                          (GO #6=#:G769))))))
                                     (LETT #3# (CDR #3#)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT (CONS |cc| |nc|))))
                              (#5#
                               (SEQ
                                (SEQ (LETT |v| (SPADCALL |f| (QREFELT $ 72)))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |v| 0)
                                        (SEQ (LETT |vv| (QCDR |v|))
                                             (EXIT
                                              (COND
                                               ((SPADCALL (QCDR |vv|) 1
                                                          (QREFELT $ 73))
                                                (SEQ
                                                 (LETT |rec|
                                                       (SPADCALL (QCAR |vv|)
                                                                 |x|
                                                                 (QREFELT $
                                                                          63)))
                                                 (EXIT
                                                  (PROGN
                                                   (LETT #1#
                                                         (CONS
                                                          (SPADCALL
                                                           (QCAR |rec|)
                                                           (QCDR |vv|)
                                                           (QREFELT $ 74))
                                                          (SPADCALL
                                                           (QCDR |rec|)
                                                           (QCDR |vv|)
                                                           (QREFELT $ 74))))
                                                   (GO #6#))))))))))))
                                (EXIT
                                 (|error|
                                  "splitConstant: should not happen"))))))))))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |INTPM;formula1|
        ((|f| (F)) (|x| (|Symbol|)) (|t| (F)) (|cc| (F))
         ($ (|Union| F "failed")))
        (SPROG
         ((#1=#:G794 NIL) (|mmi| (|Integer|)) (|mm| (F)) (#2=#:G798 NIL)
          (|sgz| #3=(|Union| (|Integer|) "failed")) (|z| (F)) (|sgs| #3#)
          (|ms| (F)) (|mw| (F)) (|l| (|List| F)))
         (SEQ
          (COND
           ((NULL (LETT |l| (|INTPM;match1| |f| |x| |t| |cc| $)))
            (CONS 1 "failed"))
           (#4='T
            (SEQ
             (EXIT
              (SEQ (LETT |mw| (|SPADfirst| |l|))
                   (COND
                    ((SPADCALL (LETT |ms| (SPADCALL |l| (QREFELT $ 76)))
                               (QREFELT $ 77))
                     (EXIT (CONS 1 #5="failed")))
                    (#4#
                     (SEQ (LETT |sgs| (SPADCALL |ms| (QREFELT $ 79)))
                          (EXIT
                           (COND
                            ((QEQCAR |sgs| 1)
                             (PROGN
                              (LETT #2# (CONS 1 #5#))
                              (GO #6=#:G795))))))))
                   (SEQ
                    (LETT |sgz|
                          (SPADCALL
                           (LETT |z|
                                 (SPADCALL
                                  (SPADCALL |mw| (|spadConstant| $ 44)
                                            (QREFELT $ 67))
                                  |ms| (QREFELT $ 46)))
                           (QREFELT $ 79)))
                    (EXIT
                     (COND
                      ((OR (QEQCAR |sgz| 1) (< (QCDR |sgz|) 0))
                       (PROGN (LETT #2# (CONS 1 "failed")) (GO #6#))))))
                   (LETT |mmi|
                         (SPADCALL (LETT |mm| (SPADCALL |l| (QREFELT $ 80)))
                                   (QREFELT $ 81)))
                   (EXIT
                    (CONS 0
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (QCDR |sgs|)
                                      (SPADCALL |l| (QREFELT $ 82))
                                      (QREFELT $ 83))
                            (SPADCALL |ms| (- (- |mmi|) 1) (QREFELT $ 74))
                            (QREFELT $ 64))
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                                       (QREFELT $ 84))
                             |x|
                             (PROG1 (LETT #1# |mmi|)
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#))
                             (QREFELT $ 86))
                            (LIST (SPADCALL |x| (QREFELT $ 88))) (LIST |z|)
                            (QREFELT $ 91))
                           (QREFELT $ 64))))))
             #6# (EXIT #2#))))))) 

(SDEFUN |INTPM;match1|
        ((|f| (F)) (|x| (|Symbol|)) (|t| (F)) (|cc| (F)) ($ (|List| F)))
        (SPROG
         ((|l| (|AssociationList| (|Symbol|) F))
          (|res| (|PatternMatchResult| (|Integer|) F)) (|pat| (F))
          (|res0| (|PatternMatchResult| (|Integer|) F)))
         (SEQ (LETT |res0| (SPADCALL (QREFELT $ 92)))
              (LETT |pat|
                    (SPADCALL
                     (SPADCALL |cc|
                               (SPADCALL (SPADCALL |t| (QREFELT $ 93))
                                         (QREFELT $ 40) (QREFELT $ 94))
                               (QREFELT $ 64))
                     (SPADCALL
                      (SPADCALL (SPADCALL |t| (QREFELT $ 32) (QREFELT $ 94))
                                (QREFELT $ 68))
                      (QREFELT $ 95))
                     (QREFELT $ 64)))
              (COND
               ((NULL
                 (SPADCALL
                  (LETT |res|
                        (SPADCALL |f| (SPADCALL |pat| (QREFELT $ 97)) |res0|
                                  (QREFELT $ 99)))
                  (QREFELT $ 100)))
                (EXIT
                 (SEQ (LETT |l| (|INTPM;mkalist| |res| $))
                      (EXIT
                       (LIST (|spadConstant| $ 36)
                             (SPADCALL |l| (QREFELT $ 13) (QREFELT $ 101))
                             (SPADCALL |l| (QREFELT $ 14) (QREFELT $ 101))
                             (SPADCALL |l| (QREFELT $ 15)
                                       (QREFELT $ 101))))))))
              (LETT |pat|
                    (SPADCALL
                     (SPADCALL |cc|
                               (SPADCALL |t| (QREFELT $ 29) (QREFELT $ 94))
                               (QREFELT $ 64))
                     (SPADCALL
                      (SPADCALL (SPADCALL |t| (QREFELT $ 32) (QREFELT $ 94))
                                (QREFELT $ 68))
                      (QREFELT $ 95))
                     (QREFELT $ 64)))
              (COND
               ((NULL
                 (SPADCALL
                  (LETT |res|
                        (SPADCALL |f| (SPADCALL |pat| (QREFELT $ 97)) |res0|
                                  (QREFELT $ 99)))
                  (QREFELT $ 100)))
                (EXIT
                 (SEQ (LETT |l| (|INTPM;mkalist| |res| $))
                      (EXIT
                       (LIST (SPADCALL |l| (QREFELT $ 12) (QREFELT $ 101))
                             (|spadConstant| $ 36)
                             (SPADCALL |l| (QREFELT $ 14) (QREFELT $ 101))
                             (SPADCALL |l| (QREFELT $ 15)
                                       (QREFELT $ 101))))))))
              (LETT |pat|
                    (SPADCALL
                     (SPADCALL |cc|
                               (SPADCALL |t| (QREFELT $ 29) (QREFELT $ 94))
                               (QREFELT $ 46))
                     (SPADCALL
                      (SPADCALL (SPADCALL |t| (QREFELT $ 32) (QREFELT $ 94))
                                (QREFELT $ 68))
                      (QREFELT $ 95))
                     (QREFELT $ 64)))
              (COND
               ((NULL
                 (SPADCALL
                  (LETT |res|
                        (SPADCALL |f| (SPADCALL |pat| (QREFELT $ 97)) |res0|
                                  (QREFELT $ 99)))
                  (QREFELT $ 100)))
                (EXIT
                 (SEQ (LETT |l| (|INTPM;mkalist| |res| $))
                      (EXIT
                       (LIST
                        (SPADCALL (SPADCALL |l| (QREFELT $ 12) (QREFELT $ 101))
                                  (QREFELT $ 68))
                        (|spadConstant| $ 36)
                        (SPADCALL |l| (QREFELT $ 14) (QREFELT $ 101))
                        (SPADCALL |l| (QREFELT $ 15) (QREFELT $ 101))))))))
              (LETT |pat|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL |cc|
                                (SPADCALL |t| (QREFELT $ 29) (QREFELT $ 94))
                                (QREFELT $ 64))
                      (SPADCALL (SPADCALL |t| (QREFELT $ 93)) (QREFELT $ 40)
                                (QREFELT $ 94))
                      (QREFELT $ 64))
                     (SPADCALL
                      (SPADCALL (SPADCALL |t| (QREFELT $ 32) (QREFELT $ 94))
                                (QREFELT $ 68))
                      (QREFELT $ 95))
                     (QREFELT $ 64)))
              (COND
               ((NULL
                 (SPADCALL
                  (LETT |res|
                        (SPADCALL |f| (SPADCALL |pat| (QREFELT $ 97)) |res0|
                                  (QREFELT $ 99)))
                  (QREFELT $ 100)))
                (EXIT
                 (SEQ (LETT |l| (|INTPM;mkalist| |res| $))
                      (EXIT
                       (LIST (SPADCALL |l| (QREFELT $ 12) (QREFELT $ 101))
                             (SPADCALL |l| (QREFELT $ 13) (QREFELT $ 101))
                             (SPADCALL |l| (QREFELT $ 14) (QREFELT $ 101))
                             (SPADCALL |l| (QREFELT $ 15)
                                       (QREFELT $ 101))))))))
              (LETT |pat|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL |cc|
                                (SPADCALL |t| (QREFELT $ 29) (QREFELT $ 94))
                                (QREFELT $ 46))
                      (SPADCALL (SPADCALL |t| (QREFELT $ 93)) (QREFELT $ 40)
                                (QREFELT $ 94))
                      (QREFELT $ 64))
                     (SPADCALL
                      (SPADCALL (SPADCALL |t| (QREFELT $ 32) (QREFELT $ 94))
                                (QREFELT $ 68))
                      (QREFELT $ 95))
                     (QREFELT $ 64)))
              (COND
               ((NULL
                 (SPADCALL
                  (LETT |res|
                        (SPADCALL |f| (SPADCALL |pat| (QREFELT $ 97)) |res0|
                                  (QREFELT $ 99)))
                  (QREFELT $ 100)))
                (EXIT
                 (SEQ (LETT |l| (|INTPM;mkalist| |res| $))
                      (EXIT
                       (LIST
                        (SPADCALL (SPADCALL |l| (QREFELT $ 12) (QREFELT $ 101))
                                  (QREFELT $ 68))
                        (SPADCALL |l| (QREFELT $ 13) (QREFELT $ 101))
                        (SPADCALL |l| (QREFELT $ 14) (QREFELT $ 101))
                        (SPADCALL |l| (QREFELT $ 15) (QREFELT $ 101))))))))
              (EXIT NIL)))) 

(SDEFUN |INTPM;pmintegrate;FS2OcU;5|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) ($ (|Union| F "failed")))
        (SPROG NIL
               (SEQ
                (COND
                 ((EQL (SPADCALL |a| (QREFELT $ 104)) 0)
                  (COND
                   ((SPADCALL (SPADCALL |a| (QREFELT $ 105)) (QREFELT $ 77))
                    (COND
                     ((EQL (SPADCALL |b| (QREFELT $ 104)) 1)
                      (EXIT
                       (|INTPM;formula1| |f| |x|
                        (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                                  (QREFELT $ 106))
                        (SPADCALL (QREFELT $ 21)
                                  (CONS #'|INTPM;pmintegrate;FS2OcU;5!0|
                                        (VECTOR $ |x|))
                                  (QREFELT $ 28))
                        $))))))))
                (EXIT (CONS 1 "failed"))))) 

(SDEFUN |INTPM;pmintegrate;FS2OcU;5!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 107)))))) 

(DECLAIM (NOTINLINE |PatternMatchIntegration;|)) 

(DEFUN |PatternMatchIntegration| (&REST #1=#:G825)
  (SPROG NIL
         (PROG (#2=#:G826)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatchIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternMatchIntegration|)))))))))) 

(DEFUN |PatternMatchIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (SEQ
          (PROGN
           (LETT DV$1 (|devaluate| |#1|))
           (LETT DV$2 (|devaluate| |#2|))
           (LETT |dv$| (LIST '|PatternMatchIntegration| DV$1 DV$2))
           (LETT $ (GETREFV 110))
           (QSETREFV $ 0 |dv$|)
           (QSETREFV $ 3
                     (LETT |pv$|
                           (|buildPredVector| 0 0
                                              (LIST
                                               (AND
                                                (|HasCategory| |#1|
                                                               '(|ConvertibleTo|
                                                                 (|Pattern|
                                                                  (|Integer|))))
                                                (|HasCategory| |#1|
                                                               '(|PatternMatchable|
                                                                 (|Integer|)))
                                                (|HasCategory| |#2|
                                                               '(|SpecialFunctionCategory|)))))))
           (|haddProp| |$ConstructorCache| '|PatternMatchIntegration|
                       (LIST DV$1 DV$2) (CONS 1 $))
           (|stuffDomainSlots| $)
           (QSETREFV $ 6 |#1|)
           (QSETREFV $ 7 |#2|)
           (SETF |pv$| (QREFELT $ 3))
           (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
           (QSETREFV $ 12 (SPADCALL (QREFELT $ 10) (QREFELT $ 11)))
           (QSETREFV $ 13 (SPADCALL (QREFELT $ 10) (QREFELT $ 11)))
           (QSETREFV $ 14 (SPADCALL (QREFELT $ 10) (QREFELT $ 11)))
           (QSETREFV $ 15 (SPADCALL (QREFELT $ 10) (QREFELT $ 11)))
           (QSETREFV $ 16 (SPADCALL (QREFELT $ 10) (QREFELT $ 11)))
           (QSETREFV $ 17 (SPADCALL (QREFELT $ 10) (QREFELT $ 11)))
           (QSETREFV $ 21
                     (SPADCALL (SPADCALL (QREFELT $ 15) (QREFELT $ 18))
                               (QREFELT $ 20)))
           (QSETREFV $ 29
                     (SPADCALL
                      (SPADCALL (SPADCALL (QREFELT $ 12) (QREFELT $ 18))
                                (QREFELT $ 20))
                      (CONS #'|PatternMatchIntegration!0| $) (QREFELT $ 28)))
           (QSETREFV $ 32
                     (SPADCALL
                      (SPADCALL (SPADCALL (QREFELT $ 14) (QREFELT $ 18))
                                (QREFELT $ 20))
                      (CONS #'|PatternMatchIntegration!1| $) (QREFELT $ 28)))
           (QSETREFV $ 40
                     (SPADCALL
                      (SPADCALL (SPADCALL (QREFELT $ 13) (QREFELT $ 18))
                                (QREFELT $ 20))
                      (CONS #'|PatternMatchIntegration!2| $) (QREFELT $ 28)))
           (QSETREFV $ 43 (SPADCALL (SPADCALL (QREFELT $ 41)) (QREFELT $ 42)))
           (QSETREFV $ 47
                     (SPADCALL (|spadConstant| $ 44)
                               (SPADCALL 2 (QREFELT $ 45)) (QREFELT $ 46)))
           (QSETREFV $ 48
                     (SPADCALL
                      (SPADCALL (SPADCALL (QREFELT $ 41))
                                (SPADCALL 2 (QREFELT $ 45)) (QREFELT $ 46))
                      (QREFELT $ 42)))
           (QSETREFV $ 49
                     (SPADCALL
                      (SPADCALL (SPADCALL 2 (QREFELT $ 45))
                                (SPADCALL (QREFELT $ 41)) (QREFELT $ 46))
                      (QREFELT $ 42)))
           (COND
            ((|HasCategory| |#1| '(|ConvertibleTo| (|Pattern| (|Integer|))))
             (COND
              ((|HasCategory| |#1| '(|PatternMatchable| (|Integer|)))
               (COND
                ((|HasCategory| |#2| '(|SpecialFunctionCategory|))
                 (PROGN
                  (QSETREFV $ 109
                            (CONS
                             (|dispatchFunction| |INTPM;pmintegrate;FS2OcU;5|)
                             $)))))))))
           $)))) 

(DEFUN |PatternMatchIntegration!2| (|x1| $)
  (SPROG ((|zz| NIL))
         (SEQ (LETT |zz| (SPADCALL |x1| (QREFELT $ 34)))
              (EXIT
               (COND
                ((QEQCAR |zz| 0)
                 (SPADCALL (QCDR |zz|) (|spadConstant| $ 38)
                           (QREFELT $ 39)))))))) 

(DEFUN |PatternMatchIntegration!1| (|x1| $)
  (COND
   ((SPADCALL (SPADCALL |x1| (QREFELT $ 23)) (QREFELT $ 25))
    (SPADCALL |x1| (QREFELT $ 31))))) 

(DEFUN |PatternMatchIntegration!0| (|x1| $)
  (SPADCALL (SPADCALL |x1| (QREFELT $ 23)) (QREFELT $ 25))) 

(MAKEPROP '|PatternMatchIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (0 . |new|) '|pm| (4 . |new|) '|pmw| '|pmm| '|pms| '|pmc| '|pma|
              '|pmb| (9 . |coerce|) (|FunctionSpaceAssertions| 6 7)
              (14 . |optional|) '|c| (|List| 8) (19 . |variables|) (|Boolean|)
              (24 . |empty?|) (|Mapping| 24 7)
              (|FunctionSpaceAttachPredicates| 6 7 7) (29 . |suchThat|) '|w|
              (|TrigonometricManipulations| 6 7) (35 . |real?|) '|s|
              (|Union| 37 '#1="failed") (40 . |retractIfCan|) (45 . |Zero|)
              (49 . |Zero|) (|Integer|) (53 . |Zero|) (57 . >=) '|m|
              (63 . |pi|) (67 . |sqrt|) '|spi| (72 . |One|) (76 . |coerce|)
              (81 . /) '|half| '|spio2| '|s2opi|
              (|Record| (|:| |key| 8) (|:| |entry| 7)) (|List| 50)
              (|PatternMatchResult| 37 7) (87 . |destruct|)
              (|AssociationList| 8 7) (92 . |construct|) (97 . |member?|)
              (103 . |One|) (|Union| (|Kernel| $) '#1#) (107 . |retractIfCan|)
              (|Union| 90 '#2="failed") (112 . |isTimes|)
              (|Record| (|:| |const| 7) (|:| |nconst| 7))
              |INTPM;splitConstant;FSR;2| (117 . *) (123 . |isPlus|) (128 . =)
              (134 . +) (140 . -) (145 . -)
              (|Record| (|:| |val| $) (|:| |exponent| 37)) (|Union| 70 '#2#)
              (151 . |isPower|) (156 . ~=) (162 . ^) (|List| 7) (168 . |third|)
              (173 . |zero?|) (|ElementaryFunctionSign| 6 7) (178 . |sign|)
              (183 . |second|) (188 . |retract|) (193 . |last|) (198 . *)
              (204 . |Gamma|) (|NonNegativeInteger|) (209 . |differentiate|)
              (|Kernel| 7) (216 . |kernel|) (|List| (|Kernel| $)) (|List| $)
              (221 . |eval|) (228 . |new|) (232 . |log|) (237 . ^)
              (243 . |exp|) (|Pattern| 37) (248 . |convert|)
              (|PatternMatchResult| 37 $) (253 . |patternMatch|)
              (260 . |failed?|) (265 . |elt|) (|SingleInteger|)
              (|OrderedCompletion| 7) (271 . |whatInfinity|) (276 . |retract|)
              (281 . |constant|) (286 . |freeOf?|) (|Union| 7 '#3="failed")
              (292 . |pmintegrate|))
           '#(|splitConstant| 300 |pmintegrate| 306) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|splitConstant|
                                 ((|Record| (|:| |const| |#2|)
                                            (|:| |nconst| |#2|))
                                  |#2| (|Symbol|)))
                                T)
                              '((|pmintegrate|
                                 ((|Union| |#2| #3#) |#2| (|Symbol|)
                                  (|OrderedCompletion| |#2|)
                                  (|OrderedCompletion| |#2|)))
                                (AND (|has| 7 (|SpecialFunctionCategory|))
                                     (|has| 6 (|PatternMatchable| 37))
                                     (|has| 6 (|ConvertibleTo| 96)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 109
                                            '(0 8 0 9 1 8 0 0 11 1 7 0 8 18 1
                                              19 7 7 20 1 7 22 0 23 1 22 24 0
                                              25 2 27 7 7 26 28 1 30 24 7 31 1
                                              7 33 0 34 0 6 0 35 0 7 0 36 0 37
                                              0 38 2 37 24 0 0 39 0 7 0 41 1 7
                                              0 0 42 0 7 0 44 1 7 0 37 45 2 7 0
                                              0 0 46 1 52 51 0 53 1 54 0 51 55
                                              2 22 24 8 0 56 0 6 0 57 1 7 58 0
                                              59 1 7 60 0 61 2 7 0 0 0 64 1 7
                                              60 0 65 2 7 24 0 0 66 2 7 0 0 0
                                              67 1 7 0 0 68 2 7 0 0 0 69 1 7 71
                                              0 72 2 37 24 0 0 73 2 7 0 0 37 74
                                              1 75 7 0 76 1 7 24 0 77 1 78 33 7
                                              79 1 75 7 0 80 1 7 37 0 81 1 75 7
                                              0 82 2 7 0 37 0 83 1 7 0 0 84 3 7
                                              0 0 8 85 86 1 87 0 8 88 3 7 0 0
                                              89 90 91 0 52 0 92 1 7 0 0 93 2 7
                                              0 0 0 94 1 7 0 0 95 1 7 96 0 97 3
                                              7 98 0 96 98 99 1 52 24 0 100 2
                                              54 7 0 8 101 1 103 102 0 104 1
                                              103 7 0 105 1 19 7 7 106 2 7 24 0
                                              8 107 4 0 108 7 8 103 103 109 2 0
                                              62 7 8 63 4 1 108 7 8 103 103
                                              109)))))
           '|lookupComplete|)) 
