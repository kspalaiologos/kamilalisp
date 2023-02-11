
(SDEFUN |IRURPK;checkRur;TSLB;1|
        ((|ts| (TS)) (|lts| (|List| TS)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G736 NIL) (#2=#:G737 NIL) (|rems| (|List| P)) (#3=#:G740 NIL)
          (|p| NIL) (#4=#:G739 NIL) (|dlts| (|NonNegativeInteger|))
          (#5=#:G738 NIL) (|us| NIL) (|lp| (|List| P))
          (|dts| (|NonNegativeInteger|)) (|z| (V)) (|f0| (P)) (#6=#:G719 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |f0|
                  (PROG2 (LETT #6# (SPADCALL |ts| (QREFELT $ 12)))
                      (QCDR #6#)
                    (|check_union2| (QEQCAR #6# 0) (QREFELT $ 9)
                                    (|Union| (QREFELT $ 9) "failed") #6#)))
            (LETT |z| (SPADCALL |f0| (QREFELT $ 13)))
            (LETT |ts| (SPADCALL |ts| |z| (QREFELT $ 14)))
            (LETT |dts| (SPADCALL |ts| (QREFELT $ 16)))
            (LETT |lp| (SPADCALL |ts| (QREFELT $ 18))) (LETT |dlts| 0)
            (SEQ (LETT |us| NIL) (LETT #5# |lts|) G190
                 (COND
                  ((OR (ATOM #5#) (PROGN (LETT |us| (CAR #5#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |dlts| (+ |dlts| (SPADCALL |us| (QREFELT $ 16))))
                        (LETT |rems|
                              (PROGN
                               (LETT #4# NIL)
                               (SEQ (LETT |p| NIL) (LETT #3# |lp|) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |p| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #4#
                                            (CONS
                                             (SPADCALL |p| |us| (QREFELT $ 19))
                                             #4#))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT (NREVERSE #4#)))))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL (ELT $ 21) |rems| (QREFELT $ 23)))
                           (PROGN
                            (LETT #1#
                                  (SEQ
                                   (SPADCALL (SPADCALL |us| (QREFELT $ 25))
                                             (QREFELT $ 28))
                                   (EXIT
                                    (PROGN (LETT #2# NIL) (GO #7=#:G735)))))
                            (GO #8=#:G732)))))))
                  #8# (EXIT #1#))
                 (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
            (EXIT (EQL |dts| |dlts|))))
          #7# (EXIT #2#)))) 

(SDEFUN |IRURPK;convert| ((|p| (P)) (|sqfr?| (|Boolean|)) ($ (TS)))
        (SPROG ((|newts| (TS)))
               (SEQ (LETT |newts| (SPADCALL (QREFELT $ 31)))
                    (EXIT
                     (COND (|sqfr?| (SPADCALL |p| |newts| (QREFELT $ 32)))
                           ('T
                            (SEQ (LETT |p| (SPADCALL |p| (QREFELT $ 33)))
                                 (EXIT
                                  (SPADCALL |p| |newts| (QREFELT $ 32)))))))))) 

(SDEFUN |IRURPK;prepareRur|
        ((|ts| (TS))
         ($ (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))))
        (SPROG
         ((|toSave|
           (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|newf0| (P)) (#1=#:G758 NIL) (|ff1| NIL) (|newf1| (P)) (|x1| (V))
          (|lp| (|List| P)) (|f1| (P)) (|z| (V)) (|f0| (P)))
         (SEQ
          (COND
           ((NULL (SPADCALL |ts| (QREFELT $ 34)))
            (|error| "rur$IRURPK: #1 is not zero-dimensional"))
           ('T
            (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 18)))
                 (LETT |lp| (SPADCALL (ELT $ 35) |lp| (QREFELT $ 37)))
                 (EXIT
                  (COND ((NULL |lp|) (|error| "rur$IRURPK: #1 is empty"))
                        (#2='T
                         (SEQ (LETT |f0| (|SPADfirst| |lp|))
                              (LETT |lp| (CDR |lp|))
                              (COND
                               ((SPADCALL (SPADCALL |f0| (QREFELT $ 38))
                                          (|spadConstant| $ 39) (QREFELT $ 40))
                                (COND
                                 ((EQL (SPADCALL |f0| (QREFELT $ 41)) 1)
                                  (COND
                                   ((NULL
                                     (SPADCALL (SPADCALL |f0| (QREFELT $ 43))
                                               (QREFELT $ 21)))
                                    (EXIT
                                     (|error|
                                      #3="rur$IRURPK: #1 has no generating root.")))))
                                 (#2# (EXIT (|error| #3#)))))
                               (#2# (EXIT (|error| #3#))))
                              (EXIT
                               (COND
                                ((NULL |lp|)
                                 (|error|
                                  "rur$IRURPK: #1 has a generating root but no indeterminates"))
                                (#2#
                                 (SEQ (LETT |z| (SPADCALL |f0| (QREFELT $ 13)))
                                      (LETT |f1| (|SPADfirst| |lp|))
                                      (LETT |lp| (CDR |lp|))
                                      (LETT |x1|
                                            (SPADCALL |f1| (QREFELT $ 13)))
                                      (LETT |newf1|
                                            (SPADCALL
                                             (SPADCALL |x1| (QREFELT $ 44))
                                             (SPADCALL |z| (QREFELT $ 44))
                                             (QREFELT $ 45)))
                                      (LETT |toSave| NIL)
                                      (SEQ (LETT |ff1| NIL)
                                           (LETT #1#
                                                 (SPADCALL (LIST |f1|)
                                                           (QREFELT $ 47)))
                                           G190
                                           (COND
                                            ((OR (ATOM #1#)
                                                 (PROGN
                                                  (LETT |ff1| (CAR #1#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (LETT |newf0|
                                                  (SPADCALL |ff1|
                                                            (SPADCALL |f1|
                                                                      (QREFELT
                                                                       $ 13))
                                                            |f0|
                                                            (QREFELT $ 48)))
                                            (LETT |ts|
                                                  (SPADCALL |newf1|
                                                            (|IRURPK;convert|
                                                             |newf0| 'T $)
                                                            (QREFELT $ 32)))
                                            (EXIT
                                             (LETT |toSave|
                                                   (CONS (CONS |lp| |ts|)
                                                         |toSave|))))
                                           (LETT #1# (CDR #1#)) (GO G190) G191
                                           (EXIT NIL))
                                      (EXIT |toSave|))))))))))))))) 

(SDEFUN |IRURPK;makeMonic|
        ((|z| (V)) (|c| (P)) (|r| (P)) (|ts| (TS)) (|s| (P))
         (|univ?| (|Boolean|)) ($ (TS)))
        (SPROG ((|newts| (TS)) (|p| (P)) (#1=#:G767 NIL) (|lp| (|List| P)))
               (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 18)))
                    (LETT |lp| (SPADCALL (ELT $ 35) |lp| (QREFELT $ 37)))
                    (LETT |newts| (|IRURPK;convert| |r| 'T $))
                    (LETT |s| (QVELT (SPADCALL |s| |newts| (QREFELT $ 50)) 1))
                    (COND
                     (|univ?|
                      (LETT |s| (SPADCALL |s| |newts| (QREFELT $ 52)))))
                    (SEQ (LETT #1# |lp|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |p|
                                (SPADCALL (SPADCALL |p| |z| |c| (QREFELT $ 48))
                                          |s| (QREFELT $ 53)))
                          (LETT |p|
                                (QVELT (SPADCALL |p| |newts| (QREFELT $ 50))
                                       1))
                          (EXIT
                           (LETT |newts|
                                 (SPADCALL |p| |newts| (QREFELT $ 32)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |s| |newts| (QREFELT $ 32)))))) 

(SDEFUN |IRURPK;next| ((|lambda| (|Integer|)) ($ (|Integer|)))
        (COND ((< |lambda| 0) (LETT |lambda| (+ (- |lambda|) 1)))
              ('T (LETT |lambda| (- |lambda|))))) 

(SDEFUN |IRURPK;makeLinearAndMonic|
        ((|p| (P)) (|xi| (V)) (|ts| (TS)) (|univ?| (|Boolean|))
         (|check?| (|Boolean|)) (|info?| (|Boolean|)) ($ (|List| TS)))
        (SPROG
         ((|toSee|
           (|List|
            (|Record| (|:| |pol| P) (|:| |gap| #1=(|Integer|))
                      (|:| |tower| TS))))
          (|toSave| (|List| TS)) (#2=#:G798 NIL) (|fr| NIL) (|r| (P)) (|h| (P))
          (|s| (P)) (|prs| (|List| P)) (|q| (P)) (|f| (P)) (|c| (P))
          (|lambda| (|Integer|)) (|f0| (P)) (|#G35| (TS)) (|#G34| #1#)
          (|#G33| (P))
          (|wip|
           (|Record| (|:| |pol| P) (|:| |gap| (|Integer|)) (|:| |tower| TS)))
          (|z| (V)) (#3=#:G770 NIL))
         (SEQ
          (LETT |f0|
                (PROG2 (LETT #3# (SPADCALL |ts| (QREFELT $ 12)))
                    (QCDR #3#)
                  (|check_union2| (QEQCAR #3# 0) (QREFELT $ 9)
                                  (|Union| (QREFELT $ 9) "failed") #3#)))
          (LETT |z| (SPADCALL |f0| (QREFELT $ 13))) (LETT |lambda| 1)
          (LETT |ts| (SPADCALL |ts| |z| (QREFELT $ 14)))
          (LETT |toSee| (LIST (VECTOR |f0| |lambda| |ts|))) (LETT |toSave| NIL)
          (SEQ G190 (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
               (SEQ (LETT |wip| (|SPADfirst| |toSee|))
                    (LETT |toSee| (CDR |toSee|))
                    (PROGN
                     (LETT |#G33| (QVELT |wip| 0))
                     (LETT |#G34| (QVELT |wip| 1))
                     (LETT |#G35| (QVELT |wip| 2))
                     (LETT |f0| |#G33|)
                     (LETT |lambda| |#G34|)
                     (LETT |ts| |#G35|))
                    (COND
                     (|check?|
                      (COND
                       ((SPADCALL |f0| (QREFELT $ 56))
                        (COND
                         ((SPADCALL (SPADCALL |f0| (QREFELT $ 13)) |z|
                                    (QREFELT $ 57))
                          (SEQ (SPADCALL #4="Bad f0: " (QREFELT $ 59))
                               (EXIT
                                (SPADCALL (SPADCALL |f0| (QREFELT $ 60))
                                          (QREFELT $ 28)))))))
                       ('T
                        (SEQ (SPADCALL #4# (QREFELT $ 59))
                             (EXIT
                              (SPADCALL (SPADCALL |f0| (QREFELT $ 60))
                                        (QREFELT $ 28))))))))
                    (LETT |c|
                          (SPADCALL
                           (SPADCALL |lambda| (SPADCALL |xi| (QREFELT $ 44))
                                     (QREFELT $ 62))
                           (SPADCALL |z| (QREFELT $ 44)) (QREFELT $ 63)))
                    (LETT |f| (SPADCALL |f0| |z| |c| (QREFELT $ 48)))
                    (LETT |q| (SPADCALL |p| |z| |c| (QREFELT $ 48)))
                    (LETT |prs| (SPADCALL |q| |f| (QREFELT $ 65)))
                    (LETT |r| (|SPADfirst| |prs|)) (LETT |prs| (CDR |prs|))
                    (COND
                     (|check?|
                      (COND
                       ((ZEROP (SPADCALL |r| |xi| (QREFELT $ 66)))
                        (COND
                         ((NULL |prs|)
                          (EXIT
                           (|error| #5="rur$IRURPK: should never happen !")))))
                       ('T (EXIT (|error| #5#))))))
                    (LETT |s| (|SPADfirst| |prs|)) (LETT |prs| (CDR |prs|))
                    (COND
                     (|check?|
                      (COND
                       ((ZEROP (SPADCALL |s| |xi| (QREFELT $ 66)))
                        (COND
                         ((NULL |prs|)
                          (EXIT
                           (|error|
                            "rur$IRURPK: should never happen !!"))))))))
                    (COND
                     ((ZEROP (SPADCALL |s| |xi| (QREFELT $ 66)))
                      (LETT |s| (|SPADfirst| |prs|))))
                    (COND
                     ((NULL (EQL (SPADCALL |s| |xi| (QREFELT $ 66)) 1))
                      (EXIT
                       (LETT |toSee|
                             (CONS
                              (VECTOR |f0| (|IRURPK;next| |lambda| $) |ts|)
                              |toSee|)))))
                    (LETT |h| (SPADCALL |s| (QREFELT $ 38)))
                    (LETT |r| (SPADCALL |r| (QREFELT $ 33)))
                    (COND
                     ((OR (SPADCALL |h| (QREFELT $ 67))
                          (SPADCALL (SPADCALL |h| |r| (QREFELT $ 68))
                                    (QREFELT $ 67)))
                      (EXIT
                       (SEQ (LETT |fr| NIL)
                            (LETT #2# (SPADCALL (LIST |r|) (QREFELT $ 47)))
                            G190
                            (COND
                             ((OR (ATOM #2#) (PROGN (LETT |fr| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND ((SPADCALL |fr| (QREFELT $ 67)) "iterate")
                                    ('T
                                     (LETT |toSave|
                                           (CONS
                                            (|IRURPK;makeMonic| |z| |c| |fr|
                                             |ts| |s| |univ?| $)
                                            |toSave|))))))
                            (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL)))))
                    (COND
                     (|info?|
                      (SEQ (SPADCALL "Unlucky lambda" (QREFELT $ 59))
                           (SPADCALL (SPADCALL |h| (QREFELT $ 60))
                                     (QREFELT $ 28))
                           (EXIT
                            (SPADCALL (SPADCALL |r| (QREFELT $ 60))
                                      (QREFELT $ 28))))))
                    (EXIT
                     (LETT |toSee|
                           (CONS (VECTOR |f0| (|IRURPK;next| |lambda| $) |ts|)
                                 |toSee|))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT |toSave|)))) 

(SDEFUN |IRURPK;rur;TSBL;7| ((|ts| (TS)) (|univ?| (|Boolean|)) ($ (|List| TS)))
        (SPROG
         ((|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|wip| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
          (#1=#:G815 NIL) (|lts| (|List| TS)) (|p| (P)) (|xi| (V))
          (|lp| (|List| P)) (|toSave| (|List| TS)))
         (SEQ (LETT |toSee| (|IRURPK;prepareRur| |ts| $)) (LETT |toSave| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                   (SEQ (LETT |wip| (|SPADfirst| |toSee|))
                        (LETT |toSee| (CDR |toSee|)) (LETT |ts| (QCDR |wip|))
                        (LETT |lp| (QCAR |wip|))
                        (EXIT
                         (COND
                          ((NULL |lp|) (LETT |toSave| (CONS |ts| |toSave|)))
                          ('T
                           (SEQ (LETT |p| (|SPADfirst| |lp|))
                                (LETT |lp| (CDR |lp|))
                                (LETT |xi| (SPADCALL |p| (QREFELT $ 13)))
                                (LETT |p|
                                      (QVELT (SPADCALL |p| |ts| (QREFELT $ 50))
                                             1))
                                (COND
                                 ((NULL |univ?|)
                                  (LETT |p|
                                        (SPADCALL
                                         (SPADCALL |p| |ts| (QREFELT $ 69))
                                         (QREFELT $ 70)))))
                                (COND
                                 ((OR (SPADCALL |p| (QREFELT $ 67))
                                      (SPADCALL (SPADCALL |p| (QREFELT $ 13))
                                                |xi| (QREFELT $ 71)))
                                  (EXIT
                                   (|error|
                                    "rur$IRUROK: should never happen"))))
                                (COND
                                 ((EQL (SPADCALL |p| (QREFELT $ 41)) 1)
                                  (COND
                                   ((SPADCALL (SPADCALL |p| (QREFELT $ 38))
                                              (QREFELT $ 67))
                                    (EXIT
                                     (SEQ
                                      (LETT |ts|
                                            (SPADCALL |p| |ts| (QREFELT $ 32)))
                                      (LETT |wip| (CONS |lp| |ts|))
                                      (EXIT
                                       (LETT |toSee|
                                             (CONS |wip| |toSee|)))))))))
                                (LETT |lts|
                                      (|IRURPK;makeLinearAndMonic| |p| |xi|
                                       |ts| |univ?| NIL NIL $))
                                (EXIT
                                 (SEQ (LETT #1# |lts|) G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |ts| (CAR #1#)) NIL))
                                        (GO G191)))
                                      (SEQ (LETT |wip| (CONS |lp| |ts|))
                                           (EXIT
                                            (LETT |toSee|
                                                  (CONS |wip| |toSee|))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT NIL))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |toSave|)))) 

(DECLAIM (NOTINLINE |InternalRationalUnivariateRepresentationPackage;|)) 

(DEFUN |InternalRationalUnivariateRepresentationPackage| (&REST #1=#:G816)
  (SPROG NIL
         (PROG (#2=#:G817)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InternalRationalUnivariateRepresentationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |InternalRationalUnivariateRepresentationPackage;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InternalRationalUnivariateRepresentationPackage|)))))))))) 

(DEFUN |InternalRationalUnivariateRepresentationPackage;|
       (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$|
          (LIST '|InternalRationalUnivariateRepresentationPackage| DV$1 DV$2
                DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 73))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache|
                '|InternalRationalUnivariateRepresentationPackage|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|InternalRationalUnivariateRepresentationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Union| 9 '"failed") (0 . |last|) (5 . |mvar|)
              (10 . |collectUpper|) (|NonNegativeInteger|) (16 . |degree|)
              (|List| 9) (21 . |parts|) (26 . |removeZero|) (|Boolean|)
              (32 . |zero?|) (|Mapping| 20 9) (37 . |every?|) (|OutputForm|)
              (43 . |coerce|) (|Void|) (|OutputPackage|) (48 . |output|)
              (|List| 10) |IRURPK;checkRur;TSLB;1| (53 . |empty|)
              (57 . |internalAugment|) (63 . |squareFreePart|)
              (68 . |purelyAlgebraic?|) (73 . |infRittWu?|) (|Mapping| 20 9 9)
              (79 . |sort|) (85 . |init|) (90 . |One|) (94 . =) (100 . |mdeg|)
              (105 . |One|) (109 . |tail|) (114 . |coerce|) (119 . -)
              (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (125 . |irreducibleFactors|) (130 . |eval|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (137 . |remainder|) (|NormalizationPackage| 6 7 8 9 10)
              (143 . |normalizedAssociate|) (149 . |lazyPrem|) (155 . |Zero|)
              (159 . |Zero|) (163 . |univariate?|) (168 . ~=) (|String|)
              (174 . |output|) (179 . |coerce|) (|Integer|) (184 . *) (190 . +)
              (|List| $) (196 . |subResultantChain|) (202 . |degree|)
              (208 . |ground?|) (213 . |gcd|) (219 . |stronglyReduce|)
              (225 . |primitivePart|) (230 . <) |IRURPK;rur;TSBL;7|)
           '#(|rur| 236 |checkRur| 242) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rur| ((|List| |#5|) |#5| (|Boolean|))) T)
                              '((|checkRur| ((|Boolean|) |#5| (|List| |#5|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 72
                                            '(1 10 11 0 12 1 9 8 0 13 2 10 0 0
                                              8 14 1 10 15 0 16 1 10 17 0 18 2
                                              10 9 9 0 19 1 9 20 0 21 2 17 20
                                              22 0 23 1 10 24 0 25 1 27 26 24
                                              28 0 10 0 31 2 10 0 9 0 32 1 9 0
                                              0 33 1 10 20 0 34 2 9 20 0 0 35 2
                                              17 0 36 0 37 1 9 0 0 38 0 9 0 39
                                              2 9 20 0 0 40 1 9 15 0 41 0 6 0
                                              42 1 9 0 0 43 1 9 0 8 44 2 9 0 0
                                              0 45 1 46 17 17 47 3 9 0 0 8 0 48
                                              2 10 49 9 0 50 2 51 9 9 10 52 2 9
                                              0 0 0 53 0 6 0 54 0 7 0 55 1 46
                                              20 9 56 2 8 20 0 0 57 1 27 26 58
                                              59 1 9 24 0 60 2 9 0 61 0 62 2 9
                                              0 0 0 63 2 9 64 0 0 65 2 9 15 0 8
                                              66 1 9 20 0 67 2 9 0 0 0 68 2 10
                                              9 9 0 69 1 9 0 0 70 2 8 20 0 0 71
                                              2 0 29 10 20 72 2 0 20 10 29
                                              30)))))
           '|lookupComplete|)) 
