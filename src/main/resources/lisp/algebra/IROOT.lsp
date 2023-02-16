
(SDEFUN |IROOT;perfectSquare?;IB;1| ((|a| (I)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |a| (QREFELT $ 14)) 0)) 

(SDEFUN |IROOT;perfectNthPower?;INniB;2|
        ((|b| (I)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |b| |n| (QREFELT $ 18)) 0)) 

(SDEFUN |IROOT;perfectNthRoot;IR;3|
        ((|n| (I))
         ($ (|Record| (|:| |base| I) (|:| |exponent| (|NonNegativeInteger|)))))
        (SPROG
         ((|p| (|NonNegativeInteger|)) (#1=#:G727 NIL)
          (|e| (|NonNegativeInteger|)) (#2=#:G724 NIL)
          (|r| (|Union| I #3="failed")) (|m| NIL))
         (SEQ
          (COND
           ((OR (SPADCALL |n| (|spadConstant| $ 8) (QREFELT $ 20))
                (OR (SPADCALL |n| (QREFELT $ 21))
                    (SPADCALL |n|
                              (SPADCALL (|spadConstant| $ 8) (QREFELT $ 22))
                              (QREFELT $ 20))))
            (CONS |n| 1))
           ('T
            (SEQ (LETT |e| 1) (LETT |p| 2)
                 (SEQ G190
                      (COND
                       ((NULL
                         (SPADCALL (SPADCALL |p| (QREFELT $ 10))
                                   (SPADCALL (SPADCALL |n| (QREFELT $ 23))
                                             (|spadConstant| $ 8)
                                             (QREFELT $ 24))
                                   (QREFELT $ 25)))
                        (GO G191)))
                      (SEQ
                       (SEQ (LETT |m| 0) G190
                            (COND
                             ((NULL
                               (QEQCAR
                                (LETT |r| (SPADCALL |n| |p| (QREFELT $ 18)))
                                0))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |n|
                                    (PROG2 (LETT #2# |r|)
                                        (QCDR #2#)
                                      (|check_union2| (QEQCAR #2# 0)
                                                      (QREFELT $ 6)
                                                      (|Union| (QREFELT $ 6)
                                                               #3#)
                                                      #2#)))))
                            (LETT |m| (|inc_SI| |m|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |e| (* |e| (EXPT |p| |m|)))
                       (EXIT
                        (LETT |p|
                              (PROG1
                                  (LETT #1#
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |p| (QREFELT $ 10))
                                          (QREFELT $ 27))
                                         (QREFELT $ 28)))
                                (|check_subtype2| (>= #1# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #1#)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS |n| |e|)))))))) 

(SDEFUN |IROOT;approxNthRoot;INniI;4|
        ((|a| (I)) (|n| (|NonNegativeInteger|)) ($ (I)))
        (SPROG
         ((|z| (I)) (|y| (I)) (|xn| (I)) (|x| (I))
          (|n1| (|NonNegativeInteger|)) (#1=#:G734 NIL) (|l| (I)))
         (SEQ
          (COND ((ZEROP |n|) (|error| "invalid arguments")) ((EQL |n| 1) |a|)
                ((EQL |n| 2) (SPADCALL |a| (QREFELT $ 31)))
                (#2='T
                 (COND
                  ((SPADCALL |a| (QREFELT $ 32))
                   (COND
                    ((ODDP |n|)
                     (SPADCALL
                      (SPADCALL (SPADCALL |a| (QREFELT $ 22)) |n|
                                (QREFELT $ 33))
                      (QREFELT $ 22)))
                    (#2# (|spadConstant| $ 7))))
                  ((SPADCALL |a| (QREFELT $ 21)) (|spadConstant| $ 7))
                  ((SPADCALL |a| (|spadConstant| $ 8) (QREFELT $ 20))
                   (|spadConstant| $ 8))
                  (#2#
                   (COND
                    ((SPADCALL
                      (SPADCALL (QUOTIENT2 (* 3 |n|) 2) (QREFELT $ 10))
                      (LETT |l| (SPADCALL |a| (QREFELT $ 23))) (QREFELT $ 34))
                     (QREFELT $ 12))
                    (#2#
                     (SEQ
                      (LETT |y|
                            (SPADCALL (QREFELT $ 12)
                                      (SPADCALL (|spadConstant| $ 8)
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL |n|
                                                             (QREFELT $ 10))
                                                   |l| (QREFELT $ 24))
                                                  (|spadConstant| $ 8)
                                                  (QREFELT $ 35))
                                                 (SPADCALL |n| (QREFELT $ 10))
                                                 (QREFELT $ 36))
                                                (QREFELT $ 37))
                                      (QREFELT $ 38)))
                      (LETT |z| (|spadConstant| $ 8))
                      (LETT |n1|
                            (PROG1 (LETT #1# (- |n| 1))
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL |z| (|spadConstant| $ 7)
                                        (QREFELT $ 39)))
                             (GO G191)))
                           (SEQ (LETT |x| |y|)
                                (LETT |xn| (SPADCALL |x| |n1| (QREFELT $ 40)))
                                (LETT |y|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |n1| |x| (QREFELT $ 41))
                                         |xn| (QREFELT $ 42))
                                        |a| (QREFELT $ 24))
                                       (SPADCALL |n| |xn| (QREFELT $ 41))
                                       (QREFELT $ 36)))
                                (EXIT
                                 (LETT |z| (SPADCALL |x| |y| (QREFELT $ 35)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |x|))))))))))) 

(SDEFUN |IROOT;perfectNthRoot;INniU;5|
        ((|b| (I)) (|n| (|NonNegativeInteger|)) ($ (|Union| I "failed")))
        (SPROG ((|r| (I)))
               (COND
                ((SPADCALL
                  (SPADCALL (LETT |r| (SPADCALL |b| |n| (QREFELT $ 33))) |n|
                            (QREFELT $ 40))
                  |b| (QREFELT $ 20))
                 (CONS 0 |r|))
                ('T (CONS 1 "failed"))))) 

(SDEFUN |IROOT;perfectSqrt;IU;6| ((|a| (I)) ($ (|Union| I "failed")))
        (SPROG ((|s| (I)))
               (COND
                ((OR (SPADCALL |a| (|spadConstant| $ 7) (QREFELT $ 43))
                     (NULL
                      (SPADCALL
                       (SPADCALL |a| (SPADCALL 144 (QREFELT $ 10))
                                 (QREFELT $ 44))
                       (QREFELT $ 11) (QREFELT $ 46))))
                 (CONS 1 "failed"))
                ('T
                 (COND
                  ((SPADCALL
                    (SPADCALL (LETT |s| (SPADCALL |a| (QREFELT $ 31))) |s|
                              (QREFELT $ 42))
                    |a| (QREFELT $ 20))
                   (CONS 0 |s|))
                  ('T (CONS 1 "failed"))))))) 

(SDEFUN |IROOT;approxSqrt;2I;7| ((|a| (I)) ($ (I)))
        (SPROG
         ((|old| (I)) (|new| (I)) (|#G18| (I)) (|#G17| (I)) (|#G16| (I))
          (|#G15| (I)) (#1=#:G761 NIL) (|s| (I)) (|n| (I)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |a| (|spadConstant| $ 8) (QREFELT $ 43))
             (|spadConstant| $ 7))
            ('T
             (SEQ
              (SEQ (LETT |n| (SPADCALL |a| (QREFELT $ 23)))
                   (EXIT
                    (COND
                     ((SPADCALL |n| (SPADCALL 100 (QREFELT $ 10))
                                (QREFELT $ 39))
                      (SEQ
                       (LETT |n|
                             (SPADCALL |n| (SPADCALL 4 (QREFELT $ 10))
                                       (QREFELT $ 36)))
                       (LETT |s|
                             (SPADCALL
                              (SPADCALL |a|
                                        (SPADCALL
                                         (SPADCALL 2 |n| (QREFELT $ 48))
                                         (QREFELT $ 22))
                                        (QREFELT $ 37))
                              (QREFELT $ 31)))
                       (LETT |s| (SPADCALL |s| |n| (QREFELT $ 37)))
                       (EXIT
                        (PROGN
                         (LETT #1#
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 8) |s|
                                           (QREFELT $ 24))
                                 (SPADCALL |a| |s| (QREFELT $ 36))
                                 (QREFELT $ 24))
                                (QREFELT $ 12) (QREFELT $ 36)))
                         (GO #2=#:G760))))))))
              (PROGN
               (LETT |#G15|
                     (SPADCALL (|spadConstant| $ 8)
                               (SPADCALL |n| (QREFELT $ 12) (QREFELT $ 36))
                               (QREFELT $ 37)))
               (LETT |#G16| (|spadConstant| $ 8))
               (LETT |new| |#G15|)
               (LETT |old| |#G16|))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |new| |old| (QREFELT $ 49))) (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (LETT |#G17|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 8) |new|
                                        (QREFELT $ 24))
                              (SPADCALL |a| |new| (QREFELT $ 36))
                              (QREFELT $ 24))
                             (QREFELT $ 12) (QREFELT $ 36)))
                      (LETT |#G18| |new|)
                      (LETT |new| |#G17|)
                      (LETT |old| |#G18|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |new|)))))
          #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |IntegerRoots;|)) 

(DEFUN |IntegerRoots| (#1=#:G762)
  (SPROG NIL
         (PROG (#2=#:G763)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegerRoots|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IntegerRoots;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|IntegerRoots|)))))))))) 

(DEFUN |IntegerRoots;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegerRoots| DV$1))
          (LETT $ (GETREFV 50))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerRoots| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 11
                    (LIST (|spadConstant| $ 7) (|spadConstant| $ 8)
                          (SPADCALL 4 (QREFELT $ 10))
                          (SPADCALL 9 (QREFELT $ 10))
                          (SPADCALL 16 (QREFELT $ 10))
                          (SPADCALL 25 (QREFELT $ 10))
                          (SPADCALL 36 (QREFELT $ 10))
                          (SPADCALL 49 (QREFELT $ 10))
                          (SPADCALL 52 (QREFELT $ 10))
                          (SPADCALL 64 (QREFELT $ 10))
                          (SPADCALL 73 (QREFELT $ 10))
                          (SPADCALL 81 (QREFELT $ 10))
                          (SPADCALL 97 (QREFELT $ 10))
                          (SPADCALL 100 (QREFELT $ 10))
                          (SPADCALL 112 (QREFELT $ 10))
                          (SPADCALL 121 (QREFELT $ 10))))
          (QSETREFV $ 12 (SPADCALL 2 (QREFELT $ 10)))
          $))) 

(MAKEPROP '|IntegerRoots| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (4 . |One|)
              (|Integer|) (8 . |coerce|) '|resMod144| '|two|
              (|Union| 6 '#1="failed") |IROOT;perfectSqrt;IU;6| (|Boolean|)
              |IROOT;perfectSquare?;IB;1| (|NonNegativeInteger|)
              |IROOT;perfectNthRoot;INniU;5| |IROOT;perfectNthPower?;INniB;2|
              (13 . =) (19 . |zero?|) (24 . -) (29 . |length|) (34 . +)
              (40 . <=) (|IntegerPrimesPackage| 6) (46 . |nextPrime|)
              (51 . |convert|) (|Record| (|:| |base| 6) (|:| |exponent| 17))
              |IROOT;perfectNthRoot;IR;3| |IROOT;approxSqrt;2I;7|
              (56 . |negative?|) |IROOT;approxNthRoot;INniI;4| (61 . >=)
              (67 . -) (73 . |quo|) (79 . |shift|) (85 . |max|) (91 . >)
              (97 . ^) (103 . *) (109 . *) (115 . <) (121 . |rem|) (|List| 6)
              (127 . |member?|) (|PositiveInteger|) (133 . *) (139 . ~=))
           '#(|perfectSquare?| 145 |perfectSqrt| 150 |perfectNthRoot| 155
              |perfectNthPower?| 166 |approxSqrt| 172 |approxNthRoot| 177)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|perfectNthPower?|
                                 ((|Boolean|) |#1| (|NonNegativeInteger|)))
                                T)
                              '((|perfectNthRoot|
                                 ((|Union| |#1| "failed") |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|perfectNthRoot|
                                 ((|Record| (|:| |base| |#1|)
                                            (|:| |exponent|
                                                 (|NonNegativeInteger|)))
                                  |#1|))
                                T)
                              '((|approxNthRoot|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|perfectSquare?| ((|Boolean|) |#1|)) T)
                              '((|perfectSqrt| ((|Union| |#1| #1#) |#1|)) T)
                              '((|approxSqrt| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 49
                                            '(0 6 0 7 0 6 0 8 1 6 0 9 10 2 6 15
                                              0 0 20 1 6 15 0 21 1 6 0 0 22 1 6
                                              0 0 23 2 6 0 0 0 24 2 6 15 0 0 25
                                              1 26 6 6 27 1 6 9 0 28 1 6 15 0
                                              32 2 6 15 0 0 34 2 6 0 0 0 35 2 6
                                              0 0 0 36 2 6 0 0 0 37 2 6 0 0 0
                                              38 2 6 15 0 0 39 2 6 0 0 17 40 2
                                              6 0 17 0 41 2 6 0 0 0 42 2 6 15 0
                                              0 43 2 6 0 0 0 44 2 45 15 6 0 46
                                              2 6 0 47 0 48 2 6 15 0 0 49 1 0
                                              15 6 16 1 0 13 6 14 1 0 29 6 30 2
                                              0 13 6 17 18 2 0 15 6 17 19 1 0 6
                                              6 31 2 0 6 6 17 33)))))
           '|lookupComplete|)) 
