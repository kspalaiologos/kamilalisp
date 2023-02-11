
(SDEFUN |PERMAN;permanent3| ((|x| (|SquareMatrix| |n| R)) ($ (R)))
        (SPROG
         ((|a| (R)) (|j| (|Integer|)) (|vv| (|Vector| (|Vector| (|Integer|))))
          (|b| (R)) (#1=#:G714 NIL) (|i| NIL) (|k| (R)) (|sgn| (R))
          (|w| (|Vector| R)))
         (SEQ (LETT |sgn| (|spadConstant| $ 8)) (LETT |a| (|spadConstant| $ 9))
              (LETT |vv| (SPADCALL (QREFELT $ 6) (QREFELT $ 13)))
              (LETT |w| (MAKEARR1 (QREFELT $ 6) (|spadConstant| $ 9)))
              (LETT |j| 1)
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |j| (+ (QREFELT $ 6) 1) (QREFELT $ 16)))
                     (GO G191)))
                   (SEQ (LETT |sgn| (SPADCALL |sgn| (QREFELT $ 17)))
                        (LETT |b| |sgn|)
                        (COND
                         ((EQL
                           (SPADCALL (SPADCALL |vv| 1 (QREFELT $ 19)) |j|
                                     (QREFELT $ 20))
                           1)
                          (LETT |k|
                                (SPADCALL (|spadConstant| $ 8)
                                          (QREFELT $ 17))))
                         ('T (LETT |k| (|spadConstant| $ 8))))
                        (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 6)) G190
                             (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ
                              (SPADCALL |w| |i|
                                        (SPADCALL
                                         (SPADCALL |w| |i| (QREFELT $ 22))
                                         (SPADCALL |k|
                                                   (SPADCALL |x| |i| |j|
                                                             (QREFELT $ 24))
                                                   (QREFELT $ 25))
                                         (QREFELT $ 26))
                                        (QREFELT $ 27))
                              (EXIT
                               (LETT |b|
                                     (SPADCALL |b|
                                               (SPADCALL |w| |i|
                                                         (QREFELT $ 22))
                                               (QREFELT $ 25)))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |a| (SPADCALL |a| |b| (QREFELT $ 26)))
                        (LETT |vv|
                              (SPADCALL |vv| (QREFELT $ 6) (QREFELT $ 28)))
                        (EXIT
                         (LETT |j|
                               (SPADCALL (SPADCALL |vv| 2 (QREFELT $ 19)) 1
                                         (QREFELT $ 20)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((ODDP (QREFELT $ 6)) (LETT |a| (SPADCALL |a| (QREFELT $ 17)))))
              (EXIT |a|)))) 

(SDEFUN |PERMAN;permanent;SmR;2| ((|x| (|SquareMatrix| |n| R)) ($ (R)))
        (SPROG
         ((|a| (R)) (|j| #1=(|Integer|))
          (|vv| (|Vector| (|Vector| (|Integer|)))) (#2=#:G732 NIL) (|b| (R))
          (#3=#:G742 NIL) (|i| NIL) (|k| #1#) (|sgn| (R)) (#4=#:G741 NIL)
          (#5=#:G724 NIL) (#6=#:G740 NIL) (|rowi| #7=(|Vector| R))
          (#8=#:G739 NIL) (|w| #7#) (#9=#:G738 NIL)
          (|half| (|Union| R "failed")) (|two| (R)))
         (SEQ
          (EXIT
           (COND ((EQL (QREFELT $ 6) 1) (SPADCALL |x| 1 1 (QREFELT $ 24)))
                 (#10='T
                  (SEQ (LETT |two| (SPADCALL 2 (QREFELT $ 29)))
                       (LETT |half| (SPADCALL |two| (QREFELT $ 31)))
                       (COND
                        ((QEQCAR |half| 1)
                         (COND
                          ((< (QREFELT $ 6) 7)
                           (PROGN
                            (LETT #9# (|PERMAN;permanent3| |x| $))
                            (GO #11=#:G737)))
                          (#10#
                           (PROGN
                            (LETT #9# (|PERMAN;permanent2| |x| $))
                            (GO #11#))))))
                       (LETT |sgn| (|spadConstant| $ 8))
                       (LETT |a| (|spadConstant| $ 9))
                       (LETT |w| (MAKEARR1 (QREFELT $ 6) (|spadConstant| $ 9)))
                       (LETT |rowi|
                             (MAKEARR1 (QREFELT $ 6) (|spadConstant| $ 9)))
                       (SEQ (LETT |i| 1) (LETT #8# (QREFELT $ 6)) G190
                            (COND ((|greater_SI| |i| #8#) (GO G191)))
                            (SEQ
                             (LETT |rowi|
                                   (SPADCALL (SPADCALL |x| |i| (QREFELT $ 33))
                                             (QREFELT $ 34)))
                             (LETT |b| (|spadConstant| $ 9))
                             (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 6)) G190
                                  (COND ((|greater_SI| |j| #6#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT |b|
                                          (SPADCALL |b|
                                                    (SPADCALL |rowi| |j|
                                                              (QREFELT $ 22))
                                                    (QREFELT $ 26)))))
                                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (SPADCALL |w| |i|
                                        (SPADCALL
                                         (SPADCALL |rowi| (QREFELT $ 6)
                                                   (QREFELT $ 22))
                                         (SPADCALL (QCDR |half|) |b|
                                                   (QREFELT $ 25))
                                         (QREFELT $ 35))
                                        (QREFELT $ 27))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |vv|
                             (SPADCALL
                              (PROG1 (LETT #5# (- (QREFELT $ 6) 1))
                                (|check_subtype2| (> #5# 0)
                                                  '(|PositiveInteger|)
                                                  '(|Integer|) #5#))
                              (QREFELT $ 13)))
                       (QREFELT $ 6) (LETT |b| (|spadConstant| $ 8))
                       (SEQ (LETT |i| 1) (LETT #4# (QREFELT $ 6)) G190
                            (COND ((|greater_SI| |i| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |b|
                                    (SPADCALL |b|
                                              (SPADCALL |w| |i| (QREFELT $ 22))
                                              (QREFELT $ 25)))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |a| (SPADCALL |a| |b| (QREFELT $ 26)))
                       (LETT |j| 1)
                       (SEQ G190
                            (COND
                             ((NULL
                               (SPADCALL |j| (QREFELT $ 6) (QREFELT $ 16)))
                              (GO G191)))
                            (SEQ (LETT |sgn| (SPADCALL |sgn| (QREFELT $ 17)))
                                 (LETT |b| |sgn|)
                                 (COND
                                  ((EQL
                                    (SPADCALL (SPADCALL |vv| 1 (QREFELT $ 19))
                                              |j| (QREFELT $ 20))
                                    1)
                                   (LETT |k| -1))
                                  ('T (LETT |k| 1)))
                                 (SEQ (LETT |i| 1) (LETT #3# (QREFELT $ 6))
                                      G190
                                      (COND ((|greater_SI| |i| #3#) (GO G191)))
                                      (SEQ
                                       (SPADCALL |w| |i|
                                                 (SPADCALL
                                                  (SPADCALL |w| |i|
                                                            (QREFELT $ 22))
                                                  (SPADCALL |k|
                                                            (SPADCALL |x| |i|
                                                                      |j|
                                                                      (QREFELT
                                                                       $ 24))
                                                            (QREFELT $ 36))
                                                  (QREFELT $ 26))
                                                 (QREFELT $ 27))
                                       (EXIT
                                        (LETT |b|
                                              (SPADCALL |b|
                                                        (SPADCALL |w| |i|
                                                                  (QREFELT $
                                                                           22))
                                                        (QREFELT $ 25)))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT NIL))
                                 (LETT |a| (SPADCALL |a| |b| (QREFELT $ 26)))
                                 (LETT |vv|
                                       (SPADCALL |vv|
                                                 (PROG1
                                                     (LETT #2#
                                                           (- (QREFELT $ 6) 1))
                                                   (|check_subtype2| (> #2# 0)
                                                                     '(|PositiveInteger|)
                                                                     '(|Integer|)
                                                                     #2#))
                                                 (QREFELT $ 28)))
                                 (EXIT
                                  (LETT |j|
                                        (SPADCALL
                                         (SPADCALL |vv| 2 (QREFELT $ 19)) 1
                                         (QREFELT $ 20)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (COND
                        ((NULL (ODDP (QREFELT $ 6)))
                         (LETT |a| (SPADCALL |a| (QREFELT $ 17)))))
                       (EXIT (SPADCALL |two| |a| (QREFELT $ 25)))))))
          #11# (EXIT #9#)))) 

(SDEFUN |PERMAN;permanent2| ((|x| (|SquareMatrix| |n| R)) ($ (R)))
        (SPROG
         ((#1=#:G764 NIL) (|b| (R)) (#2=#:G762 NIL) (|a| (R))
          (|j| #3=(|Integer|)) (|vv| (|Vector| (|Vector| (|Integer|))))
          (#4=#:G757 NIL) (#5=#:G773 NIL) (|i| NIL) (|c| (R)) (|k| #3#)
          (|sgn| (R)) (#6=#:G772 NIL) (#7=#:G749 NIL) (#8=#:G771 NIL)
          (|rowi| #9=(|Vector| R)) (#10=#:G770 NIL) (|w| #9#) (|two| (R))
          (#11=#:G769 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |c| (|spadConstant| $ 9))
                (LETT |sgn| (|spadConstant| $ 8))
                (COND
                 ((|HasCategory| (QREFELT $ 7) '(|IntegralDomain|))
                  (COND
                   ((SPADCALL (SPADCALL |sgn| |sgn| (QREFELT $ 26)) |c|
                              (QREFELT $ 38))
                    (PROGN
                     (LETT #11# (|PERMAN;permanent3| |x| $))
                     (GO #12=#:G768)))))
                 (#13='T
                  (PROGN (LETT #11# (|PERMAN;permanent3| |x| $)) (GO #12#))))
                (EXIT
                 (COND
                  ((EQL (QREFELT $ 6) 1) (SPADCALL |x| 1 1 (QREFELT $ 24)))
                  (#13#
                   (SEQ (LETT |two| (SPADCALL 2 (QREFELT $ 29)))
                        (LETT |a| (|spadConstant| $ 9))
                        (LETT |w|
                              (MAKEARR1 (QREFELT $ 6) (|spadConstant| $ 9)))
                        (LETT |rowi|
                              (MAKEARR1 (QREFELT $ 6) (|spadConstant| $ 9)))
                        (SEQ (LETT |i| 1) (LETT #10# (QREFELT $ 6)) G190
                             (COND ((|greater_SI| |i| #10#) (GO G191)))
                             (SEQ
                              (LETT |rowi|
                                    (SPADCALL (SPADCALL |x| |i| (QREFELT $ 33))
                                              (QREFELT $ 34)))
                              (LETT |b| (|spadConstant| $ 9))
                              (SEQ (LETT |j| 1) (LETT #8# (QREFELT $ 6)) G190
                                   (COND ((|greater_SI| |j| #8#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |b|
                                           (SPADCALL |b|
                                                     (SPADCALL |rowi| |j|
                                                               (QREFELT $ 22))
                                                     (QREFELT $ 26)))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT
                               (SPADCALL |w| |i|
                                         (SPADCALL
                                          (SPADCALL |two|
                                                    (SPADCALL |rowi|
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 22))
                                                    (QREFELT $ 25))
                                          |b| (QREFELT $ 35))
                                         (QREFELT $ 27))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |vv|
                              (SPADCALL
                               (PROG1 (LETT #7# (- (QREFELT $ 6) 1))
                                 (|check_subtype2| (> #7# 0)
                                                   '(|PositiveInteger|)
                                                   '(|Integer|) #7#))
                               (QREFELT $ 13)))
                        (QREFELT $ 6) (LETT |b| (|spadConstant| $ 8))
                        (SEQ (LETT |i| 1) (LETT #6# (QREFELT $ 6)) G190
                             (COND ((|greater_SI| |i| #6#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |b|
                                     (SPADCALL |b|
                                               (SPADCALL |w| |i|
                                                         (QREFELT $ 22))
                                               (QREFELT $ 25)))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |a| (SPADCALL |a| |b| (QREFELT $ 26)))
                        (LETT |j| 1)
                        (SEQ G190
                             (COND
                              ((NULL
                                (SPADCALL |j| (QREFELT $ 6) (QREFELT $ 16)))
                               (GO G191)))
                             (SEQ (LETT |sgn| (SPADCALL |sgn| (QREFELT $ 17)))
                                  (LETT |b| |sgn|)
                                  (COND
                                   ((EQL
                                     (SPADCALL (SPADCALL |vv| 1 (QREFELT $ 19))
                                               |j| (QREFELT $ 20))
                                     1)
                                    (LETT |k| -1))
                                   ('T (LETT |k| 1)))
                                  (LETT |c|
                                        (SPADCALL |k| |two| (QREFELT $ 36)))
                                  (SEQ (LETT |i| 1) (LETT #5# (QREFELT $ 6))
                                       G190
                                       (COND
                                        ((|greater_SI| |i| #5#) (GO G191)))
                                       (SEQ
                                        (SPADCALL |w| |i|
                                                  (SPADCALL
                                                   (SPADCALL |w| |i|
                                                             (QREFELT $ 22))
                                                   (SPADCALL |c|
                                                             (SPADCALL |x| |i|
                                                                       |j|
                                                                       (QREFELT
                                                                        $ 24))
                                                             (QREFELT $ 25))
                                                   (QREFELT $ 26))
                                                  (QREFELT $ 27))
                                        (EXIT
                                         (LETT |b|
                                               (SPADCALL |b|
                                                         (SPADCALL |w| |i|
                                                                   (QREFELT $
                                                                            22))
                                                         (QREFELT $ 25)))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT NIL))
                                  (LETT |a| (SPADCALL |a| |b| (QREFELT $ 26)))
                                  (LETT |vv|
                                        (SPADCALL |vv|
                                                  (PROG1
                                                      (LETT #4#
                                                            (- (QREFELT $ 6)
                                                               1))
                                                    (|check_subtype2| (> #4# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|Integer|)
                                                                      #4#))
                                                  (QREFELT $ 28)))
                                  (EXIT
                                   (LETT |j|
                                         (SPADCALL
                                          (SPADCALL |vv| 2 (QREFELT $ 19)) 1
                                          (QREFELT $ 20)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (COND
                         ((NULL (ODDP (QREFELT $ 6)))
                          (LETT |a| (SPADCALL |a| (QREFELT $ 17)))))
                        (LETT |b|
                              (SPADCALL |two|
                                        (PROG1 (LETT #2# (- (QREFELT $ 6) 1))
                                          (|check_subtype2| (>= #2# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #2#))
                                        (QREFELT $ 40)))
                        (EXIT
                         (PROG2 (LETT #1# (SPADCALL |a| |b| (QREFELT $ 41)))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                           (|Union| (QREFELT $ 7) "failed")
                                           #1#)))))))))
          #12# (EXIT #11#)))) 

(DECLAIM (NOTINLINE |Permanent;|)) 

(DEFUN |Permanent| (&REST #1=#:G774)
  (SPROG NIL
         (PROG (#2=#:G775)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|Permanent|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |Permanent;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Permanent|)))))))))) 

(DEFUN |Permanent;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Permanent| DV$1 DV$2))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Permanent| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Permanent| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (4 . |Zero|) (|Vector| 18) (|PositiveInteger|) (|GrayCode|)
              (8 . |firstSubsetGray|) (|Boolean|) (|Integer|) (13 . ~=)
              (19 . -) (|Vector| 15) (24 . |elt|) (30 . |elt|) (|Vector| 7)
              (36 . |elt|) (|SquareMatrix| (NRTEVAL (QREFELT $ 6)) 7)
              (42 . |elt|) (49 . *) (55 . +) (61 . |setelt!|)
              (68 . |nextSubsetGray|) (74 . |coerce|) (|Union| $ '"failed")
              (79 . |recip|) (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 7)
              (84 . |row|) (90 . |coerce|) (95 . -) (101 . *)
              |PERMAN;permanent;SmR;2| (107 . =) (|NonNegativeInteger|)
              (113 . ^) (119 . |exquo|))
           '#(|permanent| 125) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|permanent| (|#2| (|SquareMatrix| |#1| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 41
                                            '(0 7 0 8 0 7 0 9 1 12 10 11 13 2
                                              15 14 0 0 16 1 7 0 0 17 2 10 18 0
                                              15 19 2 18 15 0 15 20 2 21 7 0 15
                                              22 3 23 7 0 15 15 24 2 7 0 0 0 25
                                              2 7 0 0 0 26 3 21 7 0 15 7 27 2
                                              12 10 10 11 28 1 7 0 15 29 1 7 30
                                              0 31 2 23 32 0 15 33 1 32 21 0 34
                                              2 7 0 0 0 35 2 7 0 15 0 36 2 7 14
                                              0 0 38 2 7 0 0 39 40 2 7 30 0 0
                                              41 1 0 7 23 37)))))
           '|lookupComplete|)) 
