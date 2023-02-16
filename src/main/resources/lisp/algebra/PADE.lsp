
(SDEFUN |PADE;constInner|
        ((|up| (UP))
         ($
          (|Union|
           (|Record| (|:| |ais| (|List| UP))
                     (|:| |degs| (|List| (|NonNegativeInteger|))))
           "failed")))
        (CONS 0 (CONS (LIST |up|) NIL))) 

(SDEFUN |PADE;truncPoly| ((|p| (UP)) (|n| (|NonNegativeInteger|)) ($ (UP)))
        (SEQ
         (SEQ G190
              (COND ((NULL (< |n| (SPADCALL |p| (QREFELT $ 10)))) (GO G191)))
              (SEQ (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 11))))) NIL
              (GO G190) G191 (EXIT NIL))
         (EXIT |p|))) 

(SDEFUN |PADE;truncSeries| ((|s| (PS)) (|n| (|NonNegativeInteger|)) ($ (UP)))
        (SPROG ((|p| (UP)) (#1=#:G719 NIL) (|i| NIL))
               (SEQ (LETT |p| (|spadConstant| $ 12))
                    (SEQ (LETT |i| 0) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |p|
                                 (SPADCALL |p|
                                           (SPADCALL
                                            (SPADCALL |s| |i| (QREFELT $ 13))
                                            |i| (QREFELT $ 14))
                                           (QREFELT $ 15)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |p|)))) 

(SDEFUN |PADE;divOutDegree| ((|s| (PS)) (|n| (|NonNegativeInteger|)) ($ (PS)))
        (SPROG ((#1=#:G724 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (LETT |s| (SPADCALL |s| (QREFELT $ 16)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |s|)))) 

(SDEFUN |PADE;pade;2Nni2PSU;5|
        ((|l| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|)) (|gps| (PS))
         (|dps| (PS)) ($ (|Union| (|Fraction| UP) "failed")))
        (SPROG
         ((|approx| (|Fraction| UP)) (#1=#:G740 NIL) (|d| NIL) (#2=#:G741 NIL)
          (|p| NIL) (|dlist| (|List| (|NonNegativeInteger|)))
          (|plist| (|List| UP))
          (|ad|
           (|Union|
            (|Record| (|:| |ais| (|List| UP))
                      (|:| |degs| (|List| (|NonNegativeInteger|))))
            "failed")))
         (SEQ (LETT |ad| (|PADE;padeNormalize| |l| |m| |gps| |dps| $))
              (EXIT
               (COND ((QEQCAR |ad| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |plist| (QCAR (QCDR |ad|)))
                           (LETT |dlist| (QCDR (QCDR |ad|)))
                           (LETT |approx|
                                 (SPADCALL (|SPADfirst| |plist|)
                                           (QREFELT $ 18)))
                           (SEQ (LETT |p| NIL) (LETT #2# (CDR |plist|))
                                (LETT |d| NIL) (LETT #1# |dlist|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |d| (CAR #1#)) NIL)
                                      (ATOM #2#)
                                      (PROGN (LETT |p| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |approx|
                                        (SPADCALL (SPADCALL |p| (QREFELT $ 18))
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (|spadConstant| $ 19) |d|
                                                     (QREFELT $ 14))
                                                    (QREFELT $ 18))
                                                   |approx| (QREFELT $ 21))
                                                  (QREFELT $ 22)))))
                                (LETT #1#
                                      (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT (CONS 0 |approx|))))))))) 

(SDEFUN |PADE;padecf;2Nni2PSU;6|
        ((|l| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|)) (|gps| (PS))
         (|dps| (PS)) ($ (|Union| (|ContinuedFraction| UP) "failed")))
        (SPROG
         ((|blist| (|List| UP)) (#1=#:G754 NIL) (|d| NIL) (#2=#:G753 NIL)
          (|alist| (|List| UP))
          (|ad|
           (|Union|
            (|Record| (|:| |ais| (|List| UP))
                      (|:| |degs| (|List| (|NonNegativeInteger|))))
            "failed")))
         (SEQ (LETT |ad| (|PADE;padeNormalize| |l| |m| |gps| |dps| $))
              (EXIT
               (COND ((QEQCAR |ad| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |alist| (REVERSE (QCAR (QCDR |ad|))))
                           (LETT |blist|
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |d| NIL)
                                       (LETT #1# (REVERSE (QCDR (QCDR |ad|))))
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |d| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL (|spadConstant| $ 19)
                                                          |d| (QREFELT $ 14))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#)))))
                           (EXIT
                            (CONS 0
                                  (SPADCALL (|SPADfirst| |alist|)
                                            (SPADCALL |blist| (QREFELT $ 27))
                                            (SPADCALL (CDR |alist|)
                                                      (QREFELT $ 27))
                                            (QREFELT $ 29))))))))))) 

(SDEFUN |PADE;padeNormalize|
        ((|l| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|)) (|gps| (PS))
         (|dps| (PS))
         ($
          (|Union|
           (|Record| (|:| |ais| (|List| UP))
                     (|:| |degs| (|List| (|NonNegativeInteger|))))
           "failed")))
        (SPROG ((|ldeg| (|NonNegativeInteger|)))
               (SEQ
                (COND ((SPADCALL |dps| (QREFELT $ 33)) (CONS 1 "failed"))
                      ((SPADCALL |gps| (QREFELT $ 33))
                       (|PADE;constInner| (|spadConstant| $ 12) $))
                      ('T
                       (SEQ
                        (LETT |ldeg|
                              (MIN (SPADCALL |dps| (QREFELT $ 34))
                                   (SPADCALL |gps| (QREFELT $ 34))))
                        (COND
                         ((> |ldeg| 0)
                          (SEQ
                           (LETT |dps| (|PADE;divOutDegree| |dps| |ldeg| $))
                           (EXIT
                            (LETT |gps|
                                  (|PADE;divOutDegree| |gps| |ldeg| $))))))
                        (EXIT (|PADE;padeInner| |l| |m| |gps| |dps| $)))))))) 

(SDEFUN |PADE;padeInner|
        ((|l| #1=(|NonNegativeInteger|)) (|m| #2=(|NonNegativeInteger|))
         (|gps| (PS)) (|dps| (PS))
         ($
          (|Union|
           (|Record| (|:| |ais| (|List| UP))
                     (|:| |degs| (|List| (|NonNegativeInteger|))))
           "failed")))
        (SPROG
         ((|#G44| (|NonNegativeInteger|)) (#3=#:G778 NIL) (|#G43| #2#)
          (|d| (UP)) (|g| (UP)) (|degbd| (|NonNegativeInteger|))
          (#4=#:G777 NIL) (|h| (UP)) (#5=#:G773 NIL)
          (|alist| (|List| (|NonNegativeInteger|))) (#6=#:G785 NIL)
          (|alpha| (|NonNegativeInteger|)) (|plist| (|List| UP)) (|s| (UP))
          (|p| (UP)) (#7=#:G771 NIL) (|pk| (R)) (#8=#:G786 NIL) (|k| NIL)
          (#9=#:G769 NIL) (|d0| (R)) (|j| NIL) (|#G40| (PS)) (|#G39| (PS))
          (|#G38| (|NonNegativeInteger|)) (#10=#:G764 NIL) (|#G37| #2#)
          (|#G36| #1#) (|#G35| #2#) (|#G34| (PS)) (|#G33| (PS)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL (SPADCALL |gps| 0 (QREFELT $ 13)) (QREFELT $ 37))
              (COND
               ((SPADCALL (SPADCALL |dps| 0 (QREFELT $ 13)) (QREFELT $ 37))
                (EXIT (|error| "Pade' problem not normalized."))))))
            (LETT |plist| NIL) (LETT |alist| NIL)
            (COND
             ((SPADCALL (SPADCALL |dps| 0 (QREFELT $ 13)) (QREFELT $ 37))
              (SEQ
               (PROGN
                (LETT |#G33| |dps|)
                (LETT |#G34| |gps|)
                (LETT |gps| |#G33|)
                (LETT |dps| |#G34|))
               (PROGN
                (LETT |#G35| |m|)
                (LETT |#G36| |l|)
                (LETT |l| |#G35|)
                (LETT |m| |#G36|))
               (LETT |plist| (CONS (|spadConstant| $ 12) |plist|))
               (EXIT (LETT |alist| (CONS 0 |alist|))))))
            (COND
             ((< |l| |m|)
              (SEQ (LETT |alpha| (SPADCALL |gps| (QREFELT $ 34)))
                   (COND
                    ((> |alpha| |l|)
                     (PROGN (LETT #6# (CONS 1 "failed")) (GO #11=#:G784))))
                   (LETT |gps| (|PADE;divOutDegree| |gps| |alpha| $))
                   (PROGN
                    (LETT |#G37| |m|)
                    (LETT |#G38|
                          (PROG1 (LETT #10# (- |l| |alpha|))
                            (|check_subtype2| (>= #10# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #10#)))
                    (LETT |l| |#G37|)
                    (LETT |m| |#G38|))
                   (PROGN
                    (LETT |#G39| |dps|)
                    (LETT |#G40| |gps|)
                    (LETT |gps| |#G39|)
                    (LETT |dps| |#G40|))
                   (LETT |plist| (CONS (|spadConstant| $ 12) |plist|))
                   (EXIT (LETT |alist| (CONS |alpha| |alist|))))))
            (LETT |degbd| (+ (+ |l| |m|) 1))
            (LETT |g| (|PADE;truncSeries| |gps| |degbd| $))
            (LETT |d| (|PADE;truncSeries| |dps| |degbd| $))
            (EXIT
             (SEQ (LETT |j| 0) G190 NIL
                  (SEQ (LETT |d0| (SPADCALL |d| 0 (QREFELT $ 38)))
                       (LETT |d|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 39) |d0|
                                        (QREFELT $ 40))
                              |d| (QREFELT $ 41)))
                       (LETT |g|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 39) |d0|
                                        (QREFELT $ 40))
                              |g| (QREFELT $ 41)))
                       (LETT |p| (|spadConstant| $ 12)) (LETT |s| |g|)
                       (COND
                        ((< (+ (- |l| |m|) 1) 0)
                         (|error| "Internal pade error")))
                       (LETT |degbd|
                             (PROG1 (LETT #9# (+ (- |l| |m|) 1))
                               (|check_subtype2| (>= #9# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #9#)))
                       (SEQ (LETT |k| 1) (LETT #8# |degbd|) G190
                            (COND ((|greater_SI| |k| #8#) (GO G191)))
                            (SEQ (LETT |pk| (SPADCALL |s| 0 (QREFELT $ 38)))
                                 (LETT |p|
                                       (SPADCALL |p|
                                                 (SPADCALL |pk|
                                                           (PROG1
                                                               (LETT #7#
                                                                     (- |k| 1))
                                                             (|check_subtype2|
                                                              (>= #7# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #7#))
                                                           (QREFELT $ 14))
                                                 (QREFELT $ 15)))
                                 (LETT |s|
                                       (SPADCALL |s|
                                                 (SPADCALL |pk| |d|
                                                           (QREFELT $ 42))
                                                 (QREFELT $ 43)))
                                 (EXIT
                                  (LETT |s|
                                        (PROG2
                                            (LETT #5#
                                                  (SPADCALL |s|
                                                            (SPADCALL
                                                             (|spadConstant| $
                                                                             19)
                                                             1 (QREFELT $ 14))
                                                            (QREFELT $ 46)))
                                            (QCDR #5#)
                                          (|check_union2| (QEQCAR #5# 0)
                                                          (QREFELT $ 8)
                                                          (|Union|
                                                           (QREFELT $ 8)
                                                           #12="failed")
                                                          #5#)))))
                            (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |plist| (CONS |p| |plist|))
                       (EXIT
                        (COND
                         ((SPADCALL |s| (|spadConstant| $ 12) (QREFELT $ 47))
                          (PROGN
                           (LETT #6# (CONS 0 (CONS |plist| |alist|)))
                           (GO #11#)))
                         ('T
                          (SEQ
                           (LETT |alpha|
                                 (+ (SPADCALL |s| (QREFELT $ 48)) |degbd|))
                           (EXIT
                            (COND
                             ((> |alpha| (+ |l| |m|))
                              (PROGN
                               (LETT #6# (CONS 0 (CONS |plist| |alist|)))
                               (GO #11#)))
                             ((> |alpha| |l|)
                              (PROGN (LETT #6# (CONS 1 "failed")) (GO #11#)))
                             ('T
                              (SEQ (LETT |alist| (CONS |alpha| |alist|))
                                   (LETT |h|
                                         (PROG2
                                             (LETT #5#
                                                   (SPADCALL |s|
                                                             (SPADCALL
                                                              (|spadConstant| $
                                                                              19)
                                                              (SPADCALL |s|
                                                                        (QREFELT
                                                                         $ 48))
                                                              (QREFELT $ 14))
                                                             (QREFELT $ 46)))
                                             (QCDR #5#)
                                           (|check_union2| (QEQCAR #5# 0)
                                                           (QREFELT $ 8)
                                                           (|Union|
                                                            (QREFELT $ 8) #12#)
                                                           #5#)))
                                   (LETT |degbd|
                                         (PROG1
                                             (LETT #4# (- (+ |l| |m|) |alpha|))
                                           (|check_subtype2| (>= #4# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|)
                                                             #4#)))
                                   (LETT |g| (|PADE;truncPoly| |d| |degbd| $))
                                   (LETT |d| (|PADE;truncPoly| |h| |degbd| $))
                                   (EXIT
                                    (PROGN
                                     (LETT |#G43| |m|)
                                     (LETT |#G44|
                                           (PROG1 (LETT #3# (- |l| |alpha|))
                                             (|check_subtype2| (>= #3# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #3#)))
                                     (LETT |l| |#G43|)
                                     (LETT |m| |#G44|))))))))))))
                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL)))))
          #11# (EXIT #6#)))) 

(DECLAIM (NOTINLINE |PadeApproximants;|)) 

(DEFUN |PadeApproximants| (&REST #1=#:G787)
  (SPROG NIL
         (PROG (#2=#:G788)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PadeApproximants|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PadeApproximants;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PadeApproximants|)))))))))) 

(DEFUN |PadeApproximants;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PadeApproximants| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PadeApproximants|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PadeApproximants| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|NonNegativeInteger|) (0 . |degree|)
              (5 . |reductum|) (10 . |Zero|) (14 . |coefficient|)
              (20 . |monomial|) (26 . +) (32 . |quoByVar|) (|Fraction| 8)
              (37 . |coerce|) (42 . |One|) (46 . |One|) (50 . /) (56 . +)
              (|Union| 17 '#1="failed") |PADE;pade;2Nni2PSU;5| (|List| 8)
              (|Stream| 8) (62 . |coerce|) (|ContinuedFraction| 8)
              (67 . |continuedFraction|) (|Union| 28 '#2="failed")
              |PADE;padecf;2Nni2PSU;6| (|Boolean|) (74 . |zero?|)
              (79 . |order|) (84 . |Zero|) (88 . |Zero|) (92 . |zero?|)
              (97 . |coefficient|) (103 . |One|) (107 . /) (113 . *) (119 . *)
              (125 . -) (131 . |monomial|) (|Union| $ '"failed")
              (137 . |exquo|) (143 . =) (149 . |minimumDegree|))
           '#(|padecf| 154 |pade| 162) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|pade|
                                 ((|Union| (|Fraction| |#3|) #1#)
                                  (|NonNegativeInteger|) (|NonNegativeInteger|)
                                  |#2| |#2|))
                                T)
                              '((|padecf|
                                 ((|Union| (|ContinuedFraction| |#3|) #2#)
                                  (|NonNegativeInteger|) (|NonNegativeInteger|)
                                  |#2| |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(1 8 9 0 10 1 8 0 0 11 0 8 0 12 2
                                              7 6 0 9 13 2 8 0 6 9 14 2 8 0 0 0
                                              15 1 7 0 0 16 1 17 0 8 18 0 6 0
                                              19 0 7 0 20 2 17 0 0 0 21 2 17 0
                                              0 0 22 1 26 0 25 27 3 28 0 8 26
                                              26 29 1 7 32 0 33 1 7 9 0 34 0 6
                                              0 35 0 7 0 36 1 6 32 0 37 2 8 6 0
                                              9 38 0 8 0 39 2 8 0 0 6 40 2 8 0
                                              0 0 41 2 8 0 6 0 42 2 8 0 0 0 43
                                              2 7 0 6 9 44 2 8 45 0 0 46 2 8 32
                                              0 0 47 1 8 9 0 48 4 0 30 9 9 7 7
                                              31 4 0 23 9 9 7 7 24)))))
           '|lookupComplete|)) 
