
(SDEFUN |ASSOCEQ;makeMatrix|
        ((|v| (|Vector| (|Matrix| R))) (|n| (|NonNegativeInteger|))
         ($ (|Matrix| R)))
        (SPROG ((#1=#:G706 NIL) (|i| NIL) (#2=#:G705 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |v|)) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL
                                 (SPADCALL (SPADCALL |v| |i| (QREFELT $ 13))
                                           |n| (QREFELT $ 15))
                                 (QREFELT $ 17))
                                #2#))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 19))))) 

(SDEFUN |ASSOCEQ;associatedSystem;LPiR;2|
        ((|op| (L)) (|m| (|PositiveInteger|))
         ($
          (|Record| (|:| |mat| (|Matrix| R))
                    (|:| |vec| (|Vector| (|List| (|PositiveInteger|)))))))
        (SPROG
         ((|u| (|Union| S #1="failed")) (#2=#:G735 NIL) (#3=#:G730 NIL)
          (#4=#:G750 NIL) (|j| NIL) (#5=#:G722 NIL) (#6=#:G749 NIL) (|k| NIL)
          (|wi| (S)) (|eq| (|Vector| R)) (#7=#:G748 NIL) (|i| NIL)
          (|a| (|Vector| R)) (#8=#:G716 NIL) (#9=#:G747 NIL) (#10=#:G746 NIL)
          (|an| (R)) (|m1| (|PositiveInteger|)) (#11=#:G713 NIL)
          (M (|Matrix| R)) (|ww| (|Vector| (|List| (|PositiveInteger|))))
          (|s| (|NonNegativeInteger|)) (|w| (|Vector| S))
          (S
           (|Join| (|Finite|)
                   (CATEGORY |domain|
                    (SIGNATURE |incrementKthElement|
                     ((|Union| $ #12="failed") $ (|PositiveInteger|)))
                    (SIGNATURE |replaceKthElement|
                     ((|Union| $ #12#) $ (|PositiveInteger|)
                      (|PositiveInteger|)))
                    (SIGNATURE |elements| ((|List| (|PositiveInteger|)) $))
                    (SIGNATURE |setOfMinN| ($ (|List| (|PositiveInteger|))))
                    (SIGNATURE |enumerate| ((|Vector| $)))
                    (SIGNATURE |member?| ((|Boolean|) (|PositiveInteger|) $))
                    (SIGNATURE |delta|
                     ((|NonNegativeInteger|) $ (|PositiveInteger|)
                      (|PositiveInteger|))))))
          (|n| (|PositiveInteger|)) (#13=#:G712 NIL))
         (SEQ
          (LETT S
                (|SetOfMIntegersInOneToN| |m|
                                          (LETT |n|
                                                (PROG1
                                                    (LETT #13#
                                                          (SPADCALL |op|
                                                                    (QREFELT $
                                                                             21)))
                                                  (|check_subtype2| (> #13# 0)
                                                                    '(|PositiveInteger|)
                                                                    '(|NonNegativeInteger|)
                                                                    #13#)))))
          (LETT |w|
                (SPADCALL
                 (|compiledLookupCheck| '|enumerate| (LIST (LIST '|Vector| '$))
                                        S)))
          (LETT |s|
                (SPADCALL
                 (|compiledLookupCheck| '|size|
                                        (LIST (LIST '|NonNegativeInteger|))
                                        S)))
          (LETT |ww| (MAKEARR1 |s| NIL))
          (LETT M (MAKE_MATRIX1 |s| |s| (|spadConstant| $ 22)))
          (LETT |m1|
                (PROG1 (LETT #11# (- |m| 1))
                  (|check_subtype2| (> #11# 0) '(|PositiveInteger|)
                                    '(|Integer|) #11#)))
          (LETT |an| (SPADCALL |op| (QREFELT $ 26)))
          (LETT |a|
                (PROGN
                 (LETT #10# (GETREFV |n|))
                 (SEQ (LETT |j| 0) (LETT #9# (- |n| 1)) G190
                      (COND ((|greater_SI| |j| #9#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #10# |j|
                                (SPADCALL
                                 (PROG2
                                     (LETT #8#
                                           (SPADCALL
                                            (SPADCALL |op| |j| (QREFELT $ 27))
                                            |an| (QREFELT $ 29)))
                                     (QCDR #8#)
                                   (|check_union2| (QEQCAR #8# 0) (QREFELT $ 6)
                                                   (|Union| (QREFELT $ 6)
                                                            "failed")
                                                   #8#))
                                 (QREFELT $ 30)))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                 #10#))
          (SEQ (LETT |i| 1) (LETT #7# |s|) G190
               (COND ((|greater_SI| |i| #7#) (GO G191)))
               (SEQ (LETT |eq| (MAKEARR1 |s| (|spadConstant| $ 22)))
                    (LETT |wi|
                          (SPADCALL |w| |i|
                                    (|compiledLookupCheck| '|elt|
                                                           (LIST
                                                            (|devaluate| S) '$
                                                            (LIST '|Integer|))
                                                           (|Vector| S))))
                    (SPADCALL |ww| |i|
                              (SPADCALL |wi|
                                        (|compiledLookupCheck| '|elements|
                                                               (LIST
                                                                (LIST '|List|
                                                                      (LIST
                                                                       '|PositiveInteger|))
                                                                '$)
                                                               S))
                              (QREFELT $ 33))
                    (SEQ (LETT |k| 1) (LETT #6# |m1|) G190
                         (COND ((|greater_SI| |k| #6#) (GO G191)))
                         (SEQ
                          (LETT |u|
                                (SPADCALL |wi|
                                          (PROG1 (LETT #5# |k|)
                                            (|check_subtype2| (> #5# 0)
                                                              '(|PositiveInteger|)
                                                              '(|NonNegativeInteger|)
                                                              #5#))
                                          (|compiledLookupCheck|
                                           '|incrementKthElement|
                                           (LIST (LIST '|Union| '$ '#1#) '$
                                                 (LIST '|PositiveInteger|))
                                           S)))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 0)
                             (SPADCALL |eq|
                                       (SPADCALL (QCDR |u|)
                                                 (|compiledLookupCheck|
                                                  '|lookup|
                                                  (LIST
                                                   (LIST '|PositiveInteger|)
                                                   '$)
                                                  S))
                                       (|spadConstant| $ 24)
                                       (QREFELT $ 34))))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (COND
                     ((SPADCALL |n| |wi|
                                (|compiledLookupCheck| '|member?|
                                                       (LIST (LIST '|Boolean|)
                                                             (LIST
                                                              '|PositiveInteger|)
                                                             '$)
                                                       S))
                      (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                           (COND ((|greater_SI| |j| #4#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (SPADCALL |a| |j| (QREFELT $ 35))
                                         (|spadConstant| $ 22) (QREFELT $ 37))
                               (SEQ
                                (LETT |u|
                                      (SPADCALL |wi| |m|
                                                (PROG1 (LETT #3# |j|)
                                                  (|check_subtype2| (> #3# 0)
                                                                    '(|PositiveInteger|)
                                                                    '(|NonNegativeInteger|)
                                                                    #3#))
                                                (|compiledLookupCheck|
                                                 '|replaceKthElement|
                                                 (LIST (LIST '|Union| '$ '#1#)
                                                       '$
                                                       (LIST
                                                        '|PositiveInteger|)
                                                       (LIST
                                                        '|PositiveInteger|))
                                                 S)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |u| 0)
                                   (SPADCALL |eq|
                                             (SPADCALL (QCDR |u|)
                                                       (|compiledLookupCheck|
                                                        '|lookup|
                                                        (LIST
                                                         (LIST
                                                          '|PositiveInteger|)
                                                         '$)
                                                        S))
                                             (COND
                                              ((ODDP
                                                (SPADCALL |wi| |m|
                                                          (PROG1 (LETT #2# |j|)
                                                            (|check_subtype2|
                                                             (> #2# 0)
                                                             '(|PositiveInteger|)
                                                             '(|NonNegativeInteger|)
                                                             #2#))
                                                          (|compiledLookupCheck|
                                                           '|delta|
                                                           (LIST
                                                            (LIST
                                                             '|NonNegativeInteger|)
                                                            '$
                                                            (LIST
                                                             '|PositiveInteger|)
                                                            (LIST
                                                             '|PositiveInteger|))
                                                           S)))
                                               (SPADCALL
                                                (SPADCALL |a| |j|
                                                          (QREFELT $ 35))
                                                (QREFELT $ 30)))
                                              ('T
                                               (SPADCALL |a| |j|
                                                         (QREFELT $ 35))))
                                             (QREFELT $ 34))))))))))
                           (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                           (EXIT NIL)))
                     ('T
                      (SEQ
                       (LETT |u|
                             (SPADCALL |wi| |m|
                                       (|compiledLookupCheck|
                                        '|incrementKthElement|
                                        (LIST (LIST '|Union| '$ '#1#) '$
                                              (LIST '|PositiveInteger|))
                                        S)))
                       (EXIT
                        (COND
                         ((QEQCAR |u| 0)
                          (SPADCALL |eq|
                                    (SPADCALL (QCDR |u|)
                                              (|compiledLookupCheck| '|lookup|
                                                                     (LIST
                                                                      (LIST
                                                                       '|PositiveInteger|)
                                                                      '$)
                                                                     S))
                                    (|spadConstant| $ 24) (QREFELT $ 34))))))))
                    (EXIT (SPADCALL M |i| |eq| (QREFELT $ 38))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS M |ww|))))) 

(SDEFUN |ASSOCEQ;uncouplingMatrices;MV;3|
        ((|m| #1=(|Matrix| R)) ($ (|Vector| (|Matrix| R))))
        (SPROG
         ((#2=#:G759 NIL) (#3=#:G761 NIL) (|i| NIL) (#4=#:G760 NIL) (|mi| #1#)
          (#5=#:G758 NIL) (|v| (|Vector| (|Matrix| R)))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (ANROWS |m|))
              (LETT |v| (MAKEARR1 |n| (SPADCALL 1 0 (QREFELT $ 42))))
              (SPADCALL |v| 1 (LETT |mi| |m|) (QREFELT $ 43))
              (SEQ (LETT |i| 2) (LETT #5# |n|) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |v| |i|
                               (LETT |mi|
                                     (SPADCALL
                                      (SPADCALL
                                       (CONS
                                        #'|ASSOCEQ;uncouplingMatrices;MV;3!0|
                                        (VECTOR $ (QREFELT $ 9)))
                                       |mi| (QREFELT $ 46))
                                      (SPADCALL |mi| |m| (QREFELT $ 47))
                                      (QREFELT $ 48)))
                               (QREFELT $ 43))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (PROGN
                (LETT #4# (GETREFV |n|))
                (SEQ (LETT |i| 1) (LETT #3# |n|) (LETT #2# 0) G190
                     (COND ((|greater_SI| |i| #3#) (GO G191)))
                     (SEQ
                      (EXIT (SETELT #4# #2# (|ASSOCEQ;makeMatrix| |v| |i| $))))
                     (LETT #2#
                           (PROG1 (|inc_SI| #2#) (LETT |i| (|inc_SI| |i|))))
                     (GO G190) G191 (EXIT NIL))
                #4#))))) 

(SDEFUN |ASSOCEQ;uncouplingMatrices;MV;3!0| ((|z1| NIL) ($$ NIL))
        (PROG (|diff| $)
          (LETT |diff| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |diff| |z1| (QREFELT $ 44)))))) 

(SDEFUN |ASSOCEQ;makeeq|
        ((|v| (|Vector| (|List| (|PositiveInteger|)))) (|m| (|Matrix| R))
         (|i| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |minor| (|List| (|PositiveInteger|))) (|:| |eq| L)
                    (|:| |minors| (|List| (|List| (|PositiveInteger|))))
                    (|:| |ops| (|List| L)))))
        (SPROG
         ((#1=#:G771 NIL) (|j| NIL) (#2=#:G770 NIL) (#3=#:G769 NIL)
          (#4=#:G768 NIL))
         (SEQ
          (VECTOR (SPADCALL |v| |i| (QREFELT $ 50))
                  (SPADCALL
                   (|ASSOCEQ;makeop| (SPADCALL |m| |i| (QREFELT $ 15)) $)
                   (|spadConstant| $ 25) (QREFELT $ 51))
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |j| 1) (LETT #3# |n|) G190
                        (COND ((|greater_SI| |j| #3#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL |j| |i| (QREFELT $ 52))
                            (LETT #4#
                                  (CONS (SPADCALL |v| |j| (QREFELT $ 50))
                                        #4#))))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                        (EXIT (NREVERSE #4#))))
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                        (COND ((|greater_SI| |j| #1#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL |j| |i| (QREFELT $ 52))
                            (LETT #2#
                                  (CONS
                                   (|ASSOCEQ;makeop|
                                    (SPADCALL |m| |j| (QREFELT $ 15)) $)
                                   #2#))))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                        (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |ASSOCEQ;associatedEquations;LPiR;5|
        ((|op| (L)) (|m| (|PositiveInteger|))
         ($
          (|Record| (|:| |minor| (|List| (|PositiveInteger|))) (|:| |eq| L)
                    (|:| |minors| (|List| (|List| (|PositiveInteger|))))
                    (|:| |ops| (|List| L)))))
        (SPROG
         ((#1=#:G784 NIL) (|i| NIL)
          (|ww| (|Vector| (|List| (|PositiveInteger|))))
          (|s| (|NonNegativeInteger|)) (|w| (|Vector| S))
          (S
           (|Join| (|Finite|)
                   (CATEGORY |domain|
                    (SIGNATURE |incrementKthElement|
                     ((|Union| $ #2="failed") $ (|PositiveInteger|)))
                    (SIGNATURE |replaceKthElement|
                     ((|Union| $ #2#) $ (|PositiveInteger|)
                      (|PositiveInteger|)))
                    (SIGNATURE |elements| ((|List| (|PositiveInteger|)) $))
                    (SIGNATURE |setOfMinN| ($ (|List| (|PositiveInteger|))))
                    (SIGNATURE |enumerate| ((|Vector| $)))
                    (SIGNATURE |member?| ((|Boolean|) (|PositiveInteger|) $))
                    (SIGNATURE |delta|
                     ((|NonNegativeInteger|) $ (|PositiveInteger|)
                      (|PositiveInteger|))))))
          (#3=#:G776 NIL) (|v| (|Union| (|Matrix| R) "failed"))
          (|u| (|Union| (|Matrix| R) "failed")))
         (SEQ (LETT |u| (SPADCALL |op| |m| (QREFELT $ 55)))
              (EXIT
               (COND ((QEQCAR |u| 1) (|ASSOCEQ;computeIt| |op| |m| 1 $))
                     (#4='T
                      (SEQ (LETT |v| (SPADCALL (QCDR |u|) (QREFELT $ 56)))
                           (EXIT
                            (COND
                             ((QEQCAR |v| 1)
                              (|ASSOCEQ;computeIt| |op| |m| 2 $))
                             (#4#
                              (SEQ
                               (LETT S
                                     (|SetOfMIntegersInOneToN| |m|
                                                               (PROG1
                                                                   (LETT #3#
                                                                         (SPADCALL
                                                                          |op|
                                                                          (QREFELT
                                                                           $
                                                                           21)))
                                                                 (|check_subtype2|
                                                                  (> #3# 0)
                                                                  '(|PositiveInteger|)
                                                                  '(|NonNegativeInteger|)
                                                                  #3#))))
                               (LETT |w|
                                     (SPADCALL
                                      (|compiledLookupCheck| '|enumerate|
                                                             (LIST
                                                              (LIST '|Vector|
                                                                    '$))
                                                             S)))
                               (LETT |s|
                                     (SPADCALL
                                      (|compiledLookupCheck| '|size|
                                                             (LIST
                                                              (LIST
                                                               '|NonNegativeInteger|))
                                                             S)))
                               (LETT |ww| (MAKEARR1 |s| NIL))
                               (SEQ (LETT |i| 1) (LETT #1# |s|) G190
                                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SPADCALL |ww| |i|
                                                (SPADCALL
                                                 (SPADCALL |w| |i|
                                                           (|compiledLookupCheck|
                                                            '|elt|
                                                            (LIST
                                                             (|devaluate| S) '$
                                                             (LIST '|Integer|))
                                                            (|Vector| S)))
                                                 (|compiledLookupCheck|
                                                  '|elements|
                                                  (LIST
                                                   (LIST '|List|
                                                         (LIST
                                                          '|PositiveInteger|))
                                                   '$)
                                                  S))
                                                (QREFELT $ 33))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (|ASSOCEQ;makeeq| |ww| (QCDR |v|) 1 |s|
                                 $))))))))))))) 

(SDEFUN |ASSOCEQ;computeIt|
        ((|op| (L)) (|m| (|PositiveInteger|)) (|k| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |minor| (|List| (|PositiveInteger|))) (|:| |eq| L)
                    (|:| |minors| (|List| (|List| (|PositiveInteger|))))
                    (|:| |ops| (|List| L)))))
        (SPROG
         ((#1=#:G795 NIL) (#2=#:G796 NIL) (|u| (|Union| (|Matrix| R) "failed"))
          (#3=#:G797 NIL) (|i| NIL) (|n| (|NonNegativeInteger|))
          (|a| (|Vector| (|Matrix| R)))
          (|rec|
           (|Record| (|:| |mat| (|Matrix| R))
                     (|:| |vec| (|Vector| (|List| (|PositiveInteger|)))))))
         (SEQ
          (EXIT
           (SEQ (LETT |rec| (SPADCALL |op| |m| (QREFELT $ 41)))
                (LETT |a| (SPADCALL (QCAR |rec|) (QREFELT $ 49)))
                (LETT |n| (QVSIZE |a|))
                (SEQ
                 (EXIT
                  (SEQ (LETT |i| |k|) (LETT #3# |n|) G190
                       (COND ((> |i| #3#) (GO G191)))
                       (SEQ
                        (LETT |u|
                              (SPADCALL (SPADCALL |a| |i| (QREFELT $ 13))
                                        (QREFELT $ 56)))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 0)
                           (PROGN
                            (LETT #1#
                                  (PROGN
                                   (LETT #2#
                                         (|ASSOCEQ;makeeq| (QCDR |rec|)
                                          (QCDR |u|) |i| |n| $))
                                   (GO #4=#:G794)))
                            (GO #5=#:G792))))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                 #5# (EXIT #1#))
                (EXIT (|error| "associatedEquations: full degenerate case"))))
          #4# (EXIT #2#)))) 

(SDEFUN |ASSOCEQ;makeop| ((|v| (|Vector| R)) ($ (L)))
        (SPROG ((|op| (L)) (#1=#:G802 NIL) (|i| NIL))
               (SEQ (LETT |op| (|spadConstant| $ 23))
                    (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |v|)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |op|
                                 (SPADCALL |op|
                                           (SPADCALL
                                            (SPADCALL |v| |i| (QREFELT $ 35))
                                            |i| (QREFELT $ 59))
                                           (QREFELT $ 60)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |op|)))) 

(DECLAIM (NOTINLINE |AssociatedEquations;|)) 

(DEFUN |AssociatedEquations| (&REST #1=#:G803)
  (SPROG NIL
         (PROG (#2=#:G804)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AssociatedEquations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AssociatedEquations;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AssociatedEquations|)))))))))) 

(DEFUN |AssociatedEquations;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|AssociatedEquations| DV$1 DV$2))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache| '|AssociatedEquations|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 58
                       (CONS
                        (|dispatchFunction|
                         |ASSOCEQ;associatedEquations;LPiR;5|)
                        $)))))
          $))) 

(MAKEPROP '|AssociatedEquations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . D)
              '|diff| (|Matrix| 6) (|Integer|) (|Vector| 10) (4 . |elt|)
              (|Vector| 6) (10 . |row|) (|List| 6) (16 . |parts|) (|List| 16)
              (21 . |matrix|) (|NonNegativeInteger|) (26 . |degree|)
              (31 . |Zero|) (35 . |Zero|) (39 . |One|) (43 . |One|)
              (47 . |leadingCoefficient|) (52 . |coefficient|)
              (|Union| $ '"failed") (58 . |exquo|) (64 . -) (|List| 40)
              (|Vector| 31) (69 . |setelt!|) (76 . |setelt!|) (83 . |elt|)
              (|Boolean|) (89 . ~=) (95 . |setRow!|)
              (|Record| (|:| |mat| 10) (|:| |vec| 32)) (|PositiveInteger|)
              |ASSOCEQ;associatedSystem;LPiR;2| (102 . |zero|)
              (108 . |setelt!|) (115 . |elt|) (|Mapping| 6 6) (121 . |map|)
              (127 . *) (133 . +) |ASSOCEQ;uncouplingMatrices;MV;3|
              (139 . |elt|) (145 . -) (151 . ~=) (|Union| 10 '"failed")
              (|PrecomputedAssociatedEquations| 6 7)
              (157 . |firstUncouplingMatrix|) (163 . |inverse|)
              (|Record| (|:| |minor| 31) (|:| |eq| 7)
                        (|:| |minors| (|List| 31)) (|:| |ops| (|List| 7)))
              (168 . |associatedEquations|) (174 . |monomial|) (180 . +))
           '#(|uncouplingMatrices| 186 |associatedSystem| 191
              |associatedEquations| 197)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|associatedSystem|
                                 ((|Record| (|:| |mat| (|Matrix| |#1|))
                                            (|:| |vec|
                                                 (|Vector|
                                                  (|List|
                                                   (|PositiveInteger|)))))
                                  |#2| (|PositiveInteger|)))
                                T)
                              '((|uncouplingMatrices|
                                 ((|Vector| (|Matrix| |#1|)) (|Matrix| |#1|)))
                                T)
                              '((|associatedEquations|
                                 ((|Record|
                                   (|:| |minor| (|List| (|PositiveInteger|)))
                                   (|:| |eq| |#2|)
                                   (|:| |minors|
                                        (|List| (|List| (|PositiveInteger|))))
                                   (|:| |ops| (|List| |#2|)))
                                  |#2| (|PositiveInteger|)))
                                (|has| 6 (|Field|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 60
                                            '(0 7 0 8 2 12 10 0 11 13 2 10 14 0
                                              11 15 1 14 16 0 17 1 10 0 18 19 1
                                              7 20 0 21 0 6 0 22 0 7 0 23 0 6 0
                                              24 0 7 0 25 1 7 6 0 26 2 7 6 0 20
                                              27 2 6 28 0 0 29 1 6 0 0 30 3 32
                                              31 0 11 31 33 3 14 6 0 11 6 34 2
                                              14 6 0 11 35 2 6 36 0 0 37 3 10 0
                                              0 11 14 38 2 10 0 20 20 42 3 12
                                              10 0 11 10 43 2 7 6 0 6 44 2 10 0
                                              45 0 46 2 10 0 0 0 47 2 10 0 0 0
                                              48 2 32 31 0 11 50 2 7 0 0 0 51 2
                                              20 36 0 0 52 2 54 53 7 40 55 1 10
                                              28 0 56 2 0 57 7 40 58 2 7 0 6 20
                                              59 2 7 0 0 0 60 1 0 12 10 49 2 0
                                              39 7 40 41 2 1 57 7 40 58)))))
           '|lookupComplete|)) 
