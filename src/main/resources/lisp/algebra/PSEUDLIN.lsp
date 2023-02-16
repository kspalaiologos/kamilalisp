
(SDEFUN |PSEUDLIN;inv| ((|m| (|Matrix| K)) ($ (|Matrix| K)))
        (SPROG ((#1=#:G698 NIL))
               (PROG2 (LETT #1# (SPADCALL |m| (QREFELT $ 9)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (|Matrix| (QREFELT $ 6))
                                 (|Union| (|Matrix| (QREFELT $ 6)) "failed")
                                 #1#)))) 

(SDEFUN |PSEUDLIN;changeBase;2MAMM;2|
        ((M (|Matrix| K)) (A (|Matrix| K)) (|sig| (|Automorphism| K))
         (|der| (|Mapping| K K)) ($ (|Matrix| K)))
        (SPROG NIL
               (SPADCALL (|PSEUDLIN;inv| A $)
                         (SPADCALL
                          (SPADCALL M
                                    (SPADCALL
                                     (CONS #'|PSEUDLIN;changeBase;2MAMM;2!0|
                                           (VECTOR $ |sig|))
                                     A (QREFELT $ 13))
                                    (QREFELT $ 14))
                          (SPADCALL |der| A (QREFELT $ 13)) (QREFELT $ 15))
                         (QREFELT $ 14)))) 

(SDEFUN |PSEUDLIN;changeBase;2MAMM;2!0| ((|k1| NIL) ($$ NIL))
        (PROG (|sig| $)
          (LETT |sig| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |sig| |k1| (QREFELT $ 11)))))) 

(SDEFUN |PSEUDLIN;normalForm;MAMR;3|
        ((M (|Matrix| K)) (|sig| (|Automorphism| K)) (|der| (|Mapping| K K))
         ($
          (|Record| (|:| R (|Matrix| K)) (|:| A (|Matrix| K))
                    (|:| |Ainv| (|Matrix| K)))))
        (|PSEUDLIN;normalForm0| M |sig| (SPADCALL |sig| (QREFELT $ 17)) |der|
         $)) 

(SDEFUN |PSEUDLIN;companionBlocks;MLL;4|
        ((R (|Matrix| K)) (|lw| (|List| (|Vector| K)))
         ($
          (|List|
           (|Record| (|:| C (|Matrix| K)) (|:| |lg| (|List| (|Vector| K)))))))
        (SPROG
         ((|i| #1=(|Integer|))
          (|l|
           (|List|
            (|Record| (|:| C (|Matrix| K)) (|:| |lg| (|List| (|Vector| K))))))
          (|lv| (|List| (|Vector| K))) (#2=#:G762 NIL) (|k| NIL)
          (|v| (|Vector| K)) (#3=#:G748 NIL) (#4=#:G761 NIL) (|w| NIL)
          (|j| #1#) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |i| 1) (LETT |n| (ANROWS R)) (LETT |l| NIL)
              (SEQ G190 (COND ((NULL (<= |i| |n|)) (GO G191)))
                   (SEQ (LETT |j| |i|)
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND
                                 ((<= (+ |j| 1) |n|)
                                  (SPADCALL
                                   (SPADCALL R |j| (+ |j| 1) (QREFELT $ 22))
                                   (|spadConstant| $ 20) (QREFELT $ 24)))
                                 ('T NIL)))
                               (GO G191)))
                             (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL (GO G190)
                             G191 (EXIT NIL))
                        (LETT |lv| NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# |lw|) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |v|
                                    (MAKEARR1
                                     (PROG1 (LETT #3# (+ (- |j| |i|) 1))
                                       (|check_subtype2| (>= #3# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #3#))
                                     (|spadConstant| $ 25)))
                              (SEQ (LETT |k| |i|) (LETT #2# |j|) G190
                                   (COND ((> |k| #2#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (SPADCALL |v| (+ (- |k| |i|) 1)
                                               (SPADCALL |w| |k|
                                                         (QREFELT $ 27))
                                               (QREFELT $ 28))))
                                   (LETT |k| (+ |k| 1)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT (LETT |lv| (CONS |v| |lv|))))
                             (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                        (LETT |lv| (NREVERSE |lv|))
                        (LETT |l|
                              (CONS
                               (CONS
                                (SPADCALL R |i| |j| |i| |j| (QREFELT $ 29))
                                |lv|)
                               |l|))
                        (EXIT (LETT |i| (+ |j| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |l|)))) 

(SDEFUN |PSEUDLIN;normalForm0|
        ((M (|Matrix| K)) (|sig| (|Automorphism| K))
         (|siginv| (|Automorphism| K)) (|der| (|Mapping| K K))
         ($
          (|Record| (|:| R (|Matrix| K)) (|:| A (|Matrix| K))
                    (|:| |Ainv| (|Matrix| K)))))
        (SPROG
         ((|i| (|Integer|)) (|Binv| (|Matrix| K)) (B (|Matrix| K))
          (E (|Matrix| K)) (#1=#:G805 NIL) (#2=#:G807 NIL) (|k| NIL)
          (#3=#:G806 NIL)
          (|recOfMatrices|
           (|Record| (|:| R (|Matrix| K)) (|:| A (|Matrix| K))
                     (|:| |Ainv| (|Matrix| K))))
          (|j| (|Integer|)) (#4=#:G804 NIL) (#5=#:G803 NIL) (#6=#:G799 NIL)
          (#7=#:G800 NIL) (#8=#:G802 NIL) (#9=#:G801 NIL)
          (N (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT N (ANROWS M))
                (LETT B
                      (SPADCALL
                       (PROGN
                        (LETT #9# (GETREFV N))
                        (SEQ (LETT |k| 1) (LETT #8# N) (LETT #7# 0) G190
                             (COND ((|greater_SI| |k| #8#) (GO G191)))
                             (SEQ
                              (EXIT (SETELT #9# #7# (|spadConstant| $ 20))))
                             (LETT #7#
                                   (PROG1 (|inc_SI| #7#)
                                     (LETT |k| (|inc_SI| |k|))))
                             (GO G190) G191 (EXIT NIL))
                        #9#)
                       (QREFELT $ 34)))
                (LETT |Binv| (SPADCALL B (QREFELT $ 35)))
                (COND
                 ((SPADCALL M (QREFELT $ 36))
                  (PROGN (LETT #6# (VECTOR M B |Binv|)) (GO #10=#:G798))))
                (LETT |i| 1)
                (SEQ G190 (COND ((NULL (< |i| N)) (GO G191)))
                     (SEQ (LETT |j| (+ |i| 1))
                          (SEQ G190
                               (COND
                                ((NULL
                                  (COND
                                   ((<= |j| N)
                                    (SPADCALL
                                     (SPADCALL M |i| |j| (QREFELT $ 22))
                                     (|spadConstant| $ 25) (QREFELT $ 24)))
                                   ('T NIL)))
                                 (GO G191)))
                               (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL (GO G190)
                               G191 (EXIT NIL))
                          (EXIT
                           (COND
                            ((<= |j| N)
                             (SEQ
                              (COND
                               ((SPADCALL |j| (+ |i| 1) (QREFELT $ 38))
                                (SEQ
                                 (LETT E
                                       (|PSEUDLIN;permutationMatrix| N
                                        (+ |i| 1) |j| $))
                                 (LETT M
                                       (SPADCALL M E |sig| |der|
                                                 (QREFELT $ 16)))
                                 (LETT B (SPADCALL B E (QREFELT $ 14)))
                                 (EXIT
                                  (LETT |Binv|
                                        (SPADCALL E |Binv| (QREFELT $ 14)))))))
                              (LETT E
                                    (|PSEUDLIN;mulMatrix| N (+ |i| 1)
                                     (SPADCALL |siginv|
                                               (SPADCALL
                                                (SPADCALL M |i| (+ |i| 1)
                                                          (QREFELT $ 22))
                                                (QREFELT $ 39))
                                               (QREFELT $ 11))
                                     $))
                              (LETT M
                                    (SPADCALL M E |sig| |der| (QREFELT $ 16)))
                              (LETT B (SPADCALL B E (QREFELT $ 14)))
                              (LETT |Binv|
                                    (SPADCALL (|PSEUDLIN;inv| E $) |Binv|
                                              (QREFELT $ 14)))
                              (SEQ (LETT |j| 1) (LETT #5# N) G190
                                   (COND ((|greater_SI| |j| #5#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((SPADCALL |j| (+ |i| 1) (QREFELT $ 38))
                                       (SEQ
                                        (LETT E
                                              (|PSEUDLIN;addMatrix| N (+ |i| 1)
                                               |j|
                                               (SPADCALL |siginv|
                                                         (SPADCALL
                                                          (SPADCALL M |i| |j|
                                                                    (QREFELT $
                                                                             22))
                                                          (QREFELT $ 40))
                                                         (QREFELT $ 11))
                                               $))
                                        (LETT M
                                              (SPADCALL M E |sig| |der|
                                                        (QREFELT $ 16)))
                                        (LETT B (SPADCALL B E (QREFELT $ 14)))
                                        (EXIT
                                         (LETT |Binv|
                                               (SPADCALL (|PSEUDLIN;inv| E $)
                                                         |Binv|
                                                         (QREFELT $ 14)))))))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT (LETT |i| (+ |i| 1)))))
                            ('T
                             (SEQ
                              (SEQ (LETT |j| |i|) G190
                                   (COND ((< |j| 2) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (SEQ (LETT |k| (+ |i| 1)) (LETT #4# N)
                                          G190 (COND ((> |k| #4#) (GO G191)))
                                          (SEQ
                                           (LETT E
                                                 (|PSEUDLIN;addMatrix| N |k|
                                                  (- |j| 1)
                                                  (SPADCALL M |k| |j|
                                                            (QREFELT $ 22))
                                                  $))
                                           (LETT M
                                                 (SPADCALL M E |sig| |der|
                                                           (QREFELT $ 16)))
                                           (LETT B
                                                 (SPADCALL B E (QREFELT $ 14)))
                                           (EXIT
                                            (LETT |Binv|
                                                  (SPADCALL
                                                   (|PSEUDLIN;inv| E $) |Binv|
                                                   (QREFELT $ 14)))))
                                          (LETT |k| (+ |k| 1)) (GO G190) G191
                                          (EXIT NIL))))
                                   (LETT |j| (+ |j| -1)) (GO G190) G191
                                   (EXIT NIL))
                              (LETT |j| (+ |i| 1))
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (COND
                                       ((<= |j| N)
                                        (SPADCALL
                                         (SPADCALL M |j| 1 (QREFELT $ 22))
                                         (|spadConstant| $ 25) (QREFELT $ 24)))
                                       ('T NIL)))
                                     (GO G191)))
                                   (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL
                                   (GO G190) G191 (EXIT NIL))
                              (EXIT
                               (COND
                                ((<= |j| N)
                                 (SEQ
                                  (LETT E
                                        (|PSEUDLIN;permutationMatrix| N 1 |j|
                                         $))
                                  (LETT M
                                        (SPADCALL M E |sig| |der|
                                                  (QREFELT $ 16)))
                                  (LETT B (SPADCALL B E (QREFELT $ 14)))
                                  (LETT |Binv|
                                        (SPADCALL E |Binv| (QREFELT $ 14)))
                                  (EXIT (LETT |i| 1))))
                                ('T
                                 (SEQ
                                  (LETT |recOfMatrices|
                                        (SPADCALL
                                         (SPADCALL M (+ |i| 1) N (+ |i| 1) N
                                                   (QREFELT $ 29))
                                         |sig| |der| (QREFELT $ 19)))
                                  (SPADCALL M (+ |i| 1) (+ |i| 1)
                                            (QVELT |recOfMatrices| 0)
                                            (QREFELT $ 41))
                                  (LETT E
                                        (SPADCALL
                                         (PROGN
                                          (LETT #3# (GETREFV N))
                                          (SEQ (LETT |k| 1) (LETT #2# N)
                                               (LETT #1# 0) G190
                                               (COND
                                                ((|greater_SI| |k| #2#)
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (SETELT #3# #1#
                                                         (|spadConstant| $
                                                                         20))))
                                               (LETT #1#
                                                     (PROG1 (|inc_SI| #1#)
                                                       (LETT |k|
                                                             (|inc_SI| |k|))))
                                               (GO G190) G191 (EXIT NIL))
                                          #3#)
                                         (QREFELT $ 34)))
                                  (SPADCALL E (+ |i| 1) (+ |i| 1)
                                            (QVELT |recOfMatrices| 1)
                                            (QREFELT $ 41))
                                  (LETT B (SPADCALL B E (QREFELT $ 14)))
                                  (SPADCALL E (+ |i| 1) (+ |i| 1)
                                            (QVELT |recOfMatrices| 2)
                                            (QREFELT $ 41))
                                  (LETT |Binv|
                                        (SPADCALL E |Binv| (QREFELT $ 14)))
                                  (EXIT (LETT |i| N)))))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (VECTOR M B |Binv|))))
          #10# (EXIT #6#)))) 

(SDEFUN |PSEUDLIN;mulMatrix|
        ((N (|Integer|)) (|i| (|Integer|)) (|a| (K)) ($ (|Matrix| K)))
        (SPROG
         ((M (|Matrix| K)) (#1=#:G812 NIL) (#2=#:G814 NIL) (|j| NIL)
          (#3=#:G813 NIL))
         (SEQ
          (LETT M
                (SPADCALL
                 (PROGN
                  (LETT #3# (GETREFV N))
                  (SEQ (LETT |j| 1) (LETT #2# N) (LETT #1# 0) G190
                       (COND ((|greater_SI| |j| #2#) (GO G191)))
                       (SEQ (EXIT (SETELT #3# #1# (|spadConstant| $ 20))))
                       (LETT #1#
                             (PROG1 (|inc_SI| #1#) (LETT |j| (|inc_SI| |j|))))
                       (GO G190) G191 (EXIT NIL))
                  #3#)
                 (QREFELT $ 34)))
          (SPADCALL M |i| |i| |a| (QREFELT $ 42)) (EXIT M)))) 

(SDEFUN |PSEUDLIN;addMatrix|
        ((N (|Integer|)) (|i| (|Integer|)) (|k| (|Integer|)) (|a| (K))
         ($ (|Matrix| K)))
        (SPROG
         ((A (|Matrix| K)) (#1=#:G819 NIL) (#2=#:G821 NIL) (|j| NIL)
          (#3=#:G820 NIL))
         (SEQ
          (LETT A
                (SPADCALL
                 (PROGN
                  (LETT #3# (GETREFV N))
                  (SEQ (LETT |j| 1) (LETT #2# N) (LETT #1# 0) G190
                       (COND ((|greater_SI| |j| #2#) (GO G191)))
                       (SEQ (EXIT (SETELT #3# #1# (|spadConstant| $ 20))))
                       (LETT #1#
                             (PROG1 (|inc_SI| #1#) (LETT |j| (|inc_SI| |j|))))
                       (GO G190) G191 (EXIT NIL))
                  #3#)
                 (QREFELT $ 34)))
          (SPADCALL A |i| |k| |a| (QREFELT $ 42)) (EXIT A)))) 

(SDEFUN |PSEUDLIN;permutationMatrix|
        ((N (|Integer|)) (|i| (|Integer|)) (|k| (|Integer|)) ($ (|Matrix| K)))
        (SPROG
         ((P (|Matrix| K)) (#1=#:G826 NIL) (#2=#:G828 NIL) (|j| NIL)
          (#3=#:G827 NIL))
         (SEQ
          (LETT P
                (SPADCALL
                 (PROGN
                  (LETT #3# (GETREFV N))
                  (SEQ (LETT |j| 1) (LETT #2# N) (LETT #1# 0) G190
                       (COND ((|greater_SI| |j| #2#) (GO G191)))
                       (SEQ (EXIT (SETELT #3# #1# (|spadConstant| $ 20))))
                       (LETT #1#
                             (PROG1 (|inc_SI| #1#) (LETT |j| (|inc_SI| |j|))))
                       (GO G190) G191 (EXIT NIL))
                  #3#)
                 (QREFELT $ 34)))
          (SPADCALL P |i| |i|
                    (SPADCALL P |k| |k| (|spadConstant| $ 25) (QREFELT $ 42))
                    (QREFELT $ 42))
          (SPADCALL P |i| |k|
                    (SPADCALL P |k| |i| (|spadConstant| $ 20) (QREFELT $ 42))
                    (QREFELT $ 42))
          (EXIT P)))) 

(DECLAIM (NOTINLINE |PseudoLinearNormalForm;|)) 

(DEFUN |PseudoLinearNormalForm| (#1=#:G829)
  (SPROG NIL
         (PROG (#2=#:G830)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PseudoLinearNormalForm|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|PseudoLinearNormalForm;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PseudoLinearNormalForm|)))))))))) 

(DEFUN |PseudoLinearNormalForm;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PseudoLinearNormalForm| DV$1))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PseudoLinearNormalForm| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PseudoLinearNormalForm| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Union| $ '"failed")
              (|Matrix| 6) (0 . |inverse|) (|Automorphism| 6) (5 . |elt|)
              (|Mapping| 6 6) (11 . |map|) (17 . *) (23 . +)
              |PSEUDLIN;changeBase;2MAMM;2| (29 . |inv|)
              (|Record| (|:| R 8) (|:| A 8) (|:| |Ainv| 8))
              |PSEUDLIN;normalForm;MAMR;3| (34 . |One|) (|Integer|)
              (38 . |elt|) (|Boolean|) (45 . =) (51 . |Zero|) (|Vector| 6)
              (55 . |elt|) (61 . |setelt!|) (68 . |subMatrix|)
              (|Record| (|:| C 8) (|:| |lg| 32)) (|List| 30) (|List| 26)
              |PSEUDLIN;companionBlocks;MLL;4| (77 . |diagonalMatrix|)
              (82 . |copy|) (87 . |diagonal?|) (92 . |One|) (96 . ~=)
              (102 . |inv|) (107 . -) (112 . |setsubMatrix!|)
              (120 . |setelt!|))
           '#(|normalForm| 128 |companionBlocks| 135 |changeBase| 141) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|normalForm|
                                 ((|Record| (|:| R (|Matrix| |#1|))
                                            (|:| A (|Matrix| |#1|))
                                            (|:| |Ainv| (|Matrix| |#1|)))
                                  (|Matrix| |#1|) (|Automorphism| |#1|)
                                  (|Mapping| |#1| |#1|)))
                                T)
                              '((|changeBase|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|Matrix| |#1|) (|Automorphism| |#1|)
                                  (|Mapping| |#1| |#1|)))
                                T)
                              '((|companionBlocks|
                                 ((|List|
                                   (|Record| (|:| C (|Matrix| |#1|))
                                             (|:| |lg|
                                                  (|List| (|Vector| |#1|)))))
                                  (|Matrix| |#1|) (|List| (|Vector| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 8 7 0 9 2 10 6 0 6 11 2 8 0 12
                                              0 13 2 8 0 0 0 14 2 8 0 0 0 15 1
                                              10 0 0 17 0 6 0 20 3 8 6 0 21 21
                                              22 2 6 23 0 0 24 0 6 0 25 2 26 6
                                              0 21 27 3 26 6 0 21 6 28 5 8 0 0
                                              21 21 21 21 29 1 8 0 26 34 1 8 0
                                              0 35 1 8 23 0 36 0 10 0 37 2 21
                                              23 0 0 38 1 6 0 0 39 1 6 0 0 40 4
                                              8 0 0 21 21 0 41 4 8 6 0 21 21 6
                                              42 3 0 18 8 10 12 19 2 0 31 8 32
                                              33 4 0 8 8 8 10 12 16)))))
           '|lookupComplete|)) 
