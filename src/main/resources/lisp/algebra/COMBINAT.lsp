
(SDEFUN |COMBINAT;partition;2I;1| ((|n| (I)) ($ (I)))
        (SPROG
         ((|s| (I)) (|t| (I)) (#1=#:G730 NIL) (|u| (|Integer|))
          (|l| (|Integer|)) (|k| NIL) (#2=#:G731 NIL) (|i| NIL) (#3=#:G710 NIL)
          (|m| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL (QREFELT $ 18) (QREFELT $ 20)) 0
                      (QREFELT $ 22))
            (|error| "Partition: must have minIndex of 0"))
           (#4='T
            (SEQ (LETT |m| (SPADCALL (QREFELT $ 18) (QREFELT $ 23)))
                 (EXIT
                  (COND
                   ((SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 24))
                    (|error| "partition is not defined for negative integers"))
                   ((SPADCALL |n| (SPADCALL |m| (QREFELT $ 25)) (QREFELT $ 24))
                    (SPADCALL (QREFELT $ 18) (SPADCALL |n| (QREFELT $ 26))
                              (QREFELT $ 27)))
                   (#4#
                    (SEQ
                     (SPADCALL (QREFELT $ 18)
                               (SPADCALL
                                (PROG1
                                    (LETT #3#
                                          (-
                                           (SPADCALL
                                            (SPADCALL |n| (|spadConstant| $ 8)
                                                      (QREFELT $ 28))
                                            (QREFELT $ 26))
                                           |m|))
                                  (|check_subtype2| (>= #3# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #3#))
                                (|spadConstant| $ 7) (QREFELT $ 17))
                               (QREFELT $ 29))
                     (SEQ (LETT |i| |m|)
                          (LETT #2# (SPADCALL |n| (QREFELT $ 26))) G190
                          (COND ((> |i| #2#) (GO G191)))
                          (SEQ (LETT |s| (|spadConstant| $ 8))
                               (LETT |t| (|spadConstant| $ 7))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |k| 1) G190 NIL
                                      (SEQ
                                       (LETT |l|
                                             (QUOTIENT2
                                              (- (* (* 3 |k|) |k|) |k|) 2))
                                       (EXIT
                                        (COND
                                         ((> |l| |i|)
                                          (PROGN
                                           (LETT #1# |$NoValue|)
                                           (GO #5=#:G723)))
                                         ('T
                                          (SEQ (LETT |u| (+ |l| |k|))
                                               (LETT |t|
                                                     (SPADCALL |t|
                                                               (SPADCALL |s|
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $
                                                                           18)
                                                                          (-
                                                                           |i|
                                                                           |l|)
                                                                          (QREFELT
                                                                           $
                                                                           27))
                                                                         (QREFELT
                                                                          $
                                                                          30))
                                                               (QREFELT $ 28)))
                                               (EXIT
                                                (COND
                                                 ((> |u| |i|)
                                                  (PROGN
                                                   (LETT #1# |$NoValue|)
                                                   (GO #5#)))
                                                 ('T
                                                  (SEQ
                                                   (LETT |t|
                                                         (SPADCALL |t|
                                                                   (SPADCALL
                                                                    |s|
                                                                    (SPADCALL
                                                                     (QREFELT $
                                                                              18)
                                                                     (- |i|
                                                                        |u|)
                                                                     (QREFELT $
                                                                              27))
                                                                    (QREFELT $
                                                                             30))
                                                                   (QREFELT $
                                                                            28)))
                                                   (EXIT
                                                    (LETT |s|
                                                          (SPADCALL |s|
                                                                    (QREFELT $
                                                                             31)))))))))))))
                                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                      (EXIT NIL)))
                                #5# (EXIT #1#))
                               (EXIT
                                (SPADCALL (QREFELT $ 18) |i| |t|
                                          (QREFELT $ 32))))
                          (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (SPADCALL (QREFELT $ 18) (SPADCALL |n| (QREFELT $ 26))
                                (QREFELT $ 27))))))))))))) 

(SDEFUN |COMBINAT;distinct_partition;2I;2| ((|n| (I)) ($ (I)))
        (SPROG
         ((|s| (I)) (|t| (I)) (#1=#:G745 NIL) (|u| (|Integer|))
          (|l| (|Integer|)) (|l1| (|Integer|)) (|k| NIL) (#2=#:G746 NIL)
          (|i| NIL) (Q (|IndexedOneDimensionalArray| I (|Zero|)))
          (#3=#:G732 NIL) (|nz| (|Integer|)))
         (SEQ (LETT |nz| (SPADCALL |n| (QREFELT $ 26)))
              (EXIT
               (COND
                ((< |nz| 0)
                 (|error|
                  "distinct_partition is not defined for negative integers"))
                ('T
                 (SEQ
                  (LETT Q
                        (SPADCALL
                         (PROG1 (LETT #3# (+ |nz| 1))
                           (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #3#))
                         (|spadConstant| $ 7) (QREFELT $ 35)))
                  (SPADCALL Q 0
                            (SPADCALL Q 1 (|spadConstant| $ 8) (QREFELT $ 36))
                            (QREFELT $ 36))
                  (SEQ (LETT |i| 2) (LETT #2# |nz|) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ (LETT |s| (|spadConstant| $ 8))
                            (LETT |t| (|spadConstant| $ 7))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) G190 NIL
                                   (SEQ (LETT |l1| (- (* (* 3 |k|) |k|) |k|))
                                        (COND
                                         ((OR (EQL |l1| |i|)
                                              (EQL (+ |l1| (* 2 |k|)) |i|))
                                          (LETT |t|
                                                (SPADCALL |t| |s|
                                                          (QREFELT $ 37)))))
                                        (LETT |l| (QUOTIENT2 |l1| 2))
                                        (EXIT
                                         (COND
                                          ((> |l| |i|)
                                           (PROGN
                                            (LETT #1# |$NoValue|)
                                            (GO #4=#:G739)))
                                          ('T
                                           (SEQ (LETT |u| (+ |l| |k|))
                                                (LETT |t|
                                                      (SPADCALL |t|
                                                                (SPADCALL |s|
                                                                          (SPADCALL
                                                                           Q
                                                                           (-
                                                                            |i|
                                                                            |l|)
                                                                           (QREFELT
                                                                            $
                                                                            38))
                                                                          (QREFELT
                                                                           $
                                                                           30))
                                                                (QREFELT $
                                                                         28)))
                                                (EXIT
                                                 (COND
                                                  ((> |u| |i|)
                                                   (PROGN
                                                    (LETT #1# |$NoValue|)
                                                    (GO #4#)))
                                                  ('T
                                                   (SEQ
                                                    (LETT |t|
                                                          (SPADCALL |t|
                                                                    (SPADCALL
                                                                     |s|
                                                                     (SPADCALL
                                                                      Q
                                                                      (- |i|
                                                                         |u|)
                                                                      (QREFELT
                                                                       $ 38))
                                                                     (QREFELT $
                                                                              30))
                                                                    (QREFELT $
                                                                             28)))
                                                    (EXIT
                                                     (LETT |s|
                                                           (SPADCALL |s|
                                                                     (QREFELT $
                                                                              31)))))))))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #4# (EXIT #1#))
                            (EXIT (SPADCALL Q |i| |t| (QREFELT $ 36))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT (SPADCALL Q |nz| (QREFELT $ 38)))))))))) 

(SDEFUN |COMBINAT;factorial;2I;3| ((|n| (I)) ($ (I)))
        (SPROG
         ((|f| (I)) (|t| (I)) (#1=#:G754 NIL) (|k| NIL) (|s| (I))
          (|#G10| (|Record| (|:| |Fn| I) (|:| |Fv| I))))
         (SEQ
          (COND
           ((SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 24))
            (|error| "factorial not defined for negative integers"))
           (#2='T
            (SEQ
             (COND
              ((SPADCALL |n| (QCAR (QREFELT $ 9)) (QREFELT $ 40))
               (LETT |s| (LETT |f| (|spadConstant| $ 8))))
              (#2#
               (PROGN
                (LETT |#G10| (QREFELT $ 9))
                (LETT |s| (QCAR |#G10|))
                (LETT |f| (QCDR |#G10|))
                |#G10|)))
             (SEQ
              (LETT |k|
                    (SPADCALL
                     (SPADCALL |s| (|spadConstant| $ 8) (QREFELT $ 28))
                     (QREFELT $ 26)))
              (LETT #1# (SPADCALL |n| (QREFELT $ 26))) G190
              (COND ((> |k| #1#) (GO G191)))
              (SEQ
               (COND
                ((SPADCALL (SPADCALL |k| (QREFELT $ 25)) |n| (QREFELT $ 41))
                 (LETT |t| |n|))
                ('T
                 (LETT |t|
                       (SPADCALL (SPADCALL |k| (QREFELT $ 25))
                                 (SPADCALL (+ |k| 1) (QREFELT $ 25))
                                 (QREFELT $ 30)))))
               (EXIT (LETT |f| (SPADCALL |t| |f| (QREFELT $ 30)))))
              (LETT |k| (+ |k| 2)) (GO G190) G191 (EXIT NIL))
             (PROGN (RPLACA (QREFELT $ 9) |n|) (QCAR (QREFELT $ 9)))
             (EXIT
              (PROGN (RPLACD (QREFELT $ 9) |f|) (QCDR (QREFELT $ 9)))))))))) 

(SDEFUN |COMBINAT;binomial;3I;4| ((|n| (I)) (|m| (I)) ($ (I)))
        (SPROG
         ((|b| (I)) (#1=#:G767 NIL) (|k| NIL) (|s| (I)) (|#G20| (I))
          (|#G19| (I)) (#2=#:G766 NIL) (|#G18| (I)) (|#G17| (I)))
         (SEQ
          (EXIT
           (COND
            ((OR
              (OR (SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 24))
                  (SPADCALL |m| (|spadConstant| $ 7) (QREFELT $ 24)))
              (SPADCALL |m| |n| (QREFELT $ 43)))
             (|spadConstant| $ 7))
            ('T
             (COND
              ((SPADCALL |m| (|spadConstant| $ 7) (QREFELT $ 41))
               (|spadConstant| $ 8))
              ((SPADCALL |n| (SPADCALL 2 |m| (QREFELT $ 45)) (QREFELT $ 24))
               (SPADCALL |n| (SPADCALL |n| |m| (QREFELT $ 37)) (QREFELT $ 46)))
              (#3='T
               (SEQ
                (PROGN
                 (LETT |#G17| (|spadConstant| $ 7))
                 (LETT |#G18| (|spadConstant| $ 8))
                 (LETT |s| |#G17|)
                 (LETT |b| |#G18|))
                (COND
                 ((SPADCALL (QVELT (QREFELT $ 10) 0) |n| (QREFELT $ 41))
                  (COND
                   ((SPADCALL (QVELT (QREFELT $ 10) 1)
                              (SPADCALL |m| (|spadConstant| $ 8)
                                        (QREFELT $ 28))
                              (QREFELT $ 41))
                    (SEQ
                     (LETT |b|
                           (SPADCALL
                            (SPADCALL (QVELT (QREFELT $ 10) 2)
                                      (SPADCALL |m| (|spadConstant| $ 8)
                                                (QREFELT $ 28))
                                      (QREFELT $ 30))
                            (SPADCALL |n| |m| (QREFELT $ 37)) (QREFELT $ 47)))
                     (QSETVELT (QREFELT $ 10) 0 |n|)
                     (QSETVELT (QREFELT $ 10) 1 |m|)
                     (EXIT
                      (PROGN
                       (LETT #2# (QSETVELT (QREFELT $ 10) 2 |b|))
                       (GO #4=#:G765)))))
                   ((SPADCALL |m| (QVELT (QREFELT $ 10) 1) (QREFELT $ 48))
                    (SEQ (LETT |s| (QVELT (QREFELT $ 10) 1))
                         (EXIT (LETT |b| (QVELT (QREFELT $ 10) 2)))))
                   (#3#
                    (PROGN
                     (LETT |#G19| (|spadConstant| $ 7))
                     (LETT |#G20| (|spadConstant| $ 8))
                     (LETT |s| |#G19|)
                     (LETT |b| |#G20|))))))
                (SEQ
                 (LETT |k|
                       (SPADCALL
                        (SPADCALL |s| (|spadConstant| $ 8) (QREFELT $ 28))
                        (QREFELT $ 26)))
                 (LETT #1# (SPADCALL |m| (QREFELT $ 26))) G190
                 (COND ((> |k| #1#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT |b|
                         (SPADCALL
                          (SPADCALL |b|
                                    (SPADCALL
                                     (SPADCALL |n|
                                               (SPADCALL |k| (QREFELT $ 25))
                                               (QREFELT $ 37))
                                     (|spadConstant| $ 8) (QREFELT $ 28))
                                    (QREFELT $ 30))
                          (SPADCALL |k| (QREFELT $ 25)) (QREFELT $ 47)))))
                 (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                (QSETVELT (QREFELT $ 10) 0 |n|) (QSETVELT (QREFELT $ 10) 1 |m|)
                (EXIT (QSETVELT (QREFELT $ 10) 2 |b|))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |COMBINAT;multinomial;ILI;5| ((|n| (I)) (|m| (|List| I)) ($ (I)))
        (SPROG
         ((|s| (I)) (#1=#:G786 NIL) (|t| NIL) (#2=#:G775 NIL) (#3=#:G774 (I))
          (#4=#:G776 (I)) (#5=#:G785 NIL) (#6=#:G689 NIL) (#7=#:G782 NIL)
          (#8=#:G783 NIL) (#9=#:G784 NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |t| NIL) (LETT #9# |m|) G190
                   (COND
                    ((OR (ATOM #9#) (PROGN (LETT |t| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |t| (|spadConstant| $ 7) (QREFELT $ 24))
                       (PROGN
                        (LETT #7#
                              (PROGN
                               (LETT #8# (|spadConstant| $ 7))
                               (GO #10=#:G781)))
                        (GO #11=#:G773))))))
                   (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL)))
             #11# (EXIT #7#))
            (EXIT
             (COND
              ((SPADCALL |n|
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT #6# NIL) (LETT #5# |m|) G190
                               (COND
                                ((OR (ATOM #5#)
                                     (PROGN (LETT #6# (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #4# #6#)
                                  (COND
                                   (#2#
                                    (LETT #3#
                                          (SPADCALL #3# #4# (QREFELT $ 28))))
                                   ('T
                                    (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                          (COND (#2# #3#) (#12='T (|spadConstant| $ 7))))
                         (QREFELT $ 24))
               (|spadConstant| $ 7))
              (#12#
               (SEQ (LETT |s| (|spadConstant| $ 8))
                    (SEQ (LETT |t| NIL) (LETT #1# |m|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |s|
                                 (SPADCALL |s| (SPADCALL |t| (QREFELT $ 42))
                                           (QREFELT $ 30)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (SPADCALL |n| (QREFELT $ 42)) |s|
                               (QREFELT $ 47)))))))))
          #10# (EXIT #8#)))) 

(SDEFUN |COMBINAT;permutation;3I;6| ((|n| (I)) (|m| (I)) ($ (I)))
        (SPROG ((|p| (I)) (|t| (I)) (#1=#:G792 NIL) (|k| NIL))
               (SEQ
                (COND
                 ((OR (SPADCALL |m| (|spadConstant| $ 7) (QREFELT $ 24))
                      (SPADCALL |n| |m| (QREFELT $ 24)))
                  (|spadConstant| $ 7))
                 ('T
                  (SEQ (LETT |m| (SPADCALL |n| |m| (QREFELT $ 37)))
                       (LETT |p| (|spadConstant| $ 8))
                       (SEQ
                        (LETT |k|
                              (SPADCALL
                               (SPADCALL |m| (|spadConstant| $ 8)
                                         (QREFELT $ 28))
                               (QREFELT $ 26)))
                        (LETT #1# (SPADCALL |n| (QREFELT $ 26))) G190
                        (COND ((> |k| #1#) (GO G191)))
                        (SEQ
                         (COND
                          ((SPADCALL (SPADCALL |k| (QREFELT $ 25)) |n|
                                     (QREFELT $ 41))
                           (LETT |t| |n|))
                          ('T
                           (LETT |t|
                                 (SPADCALL (* |k| (+ |k| 1)) (QREFELT $ 25)))))
                         (EXIT (LETT |p| (SPADCALL |p| |t| (QREFELT $ 30)))))
                        (LETT |k| (+ |k| 2)) (GO G190) G191 (EXIT NIL))
                       (EXIT |p|))))))) 

(SDEFUN |COMBINAT;stirling1;3I;7| ((|n| (I)) (|m| (I)) ($ (I)))
        (SPROG
         ((#1=#:G796 NIL) (#2=#:G801 NIL) (|k| NIL)
          (|x| (|SparseUnivariatePolynomial| I)) (#3=#:G793 NIL))
         (SEQ
          (COND
           ((OR
             (OR (SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 24))
                 (SPADCALL |m| (|spadConstant| $ 8) (QREFELT $ 24)))
             (SPADCALL |m| |n| (QREFELT $ 43)))
            (|spadConstant| $ 7))
           ('T
            (COND ((SPADCALL |m| |n| (QREFELT $ 41)) (|spadConstant| $ 8))
                  ((SPADCALL (QCAR (QREFELT $ 13)) |n| (QREFELT $ 41))
                   (SPADCALL (QCDR (QREFELT $ 13))
                             (PROG1 (LETT #3# (SPADCALL |m| (QREFELT $ 26)))
                               (|check_subtype2| (>= #3# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #3#))
                             (QREFELT $ 52)))
                  ('T
                   (SEQ
                    (LETT |x| (SPADCALL (|spadConstant| $ 8) 1 (QREFELT $ 53)))
                    (PROGN (RPLACA (QREFELT $ 13) |n|) (QCAR (QREFELT $ 13)))
                    (PROGN (RPLACD (QREFELT $ 13) |x|) (QCDR (QREFELT $ 13)))
                    (SEQ (LETT |k| 1)
                         (LETT #2#
                               (SPADCALL
                                (SPADCALL |n| (|spadConstant| $ 8)
                                          (QREFELT $ 37))
                                (QREFELT $ 26)))
                         G190 (COND ((|greater_SI| |k| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (PROGN
                            (RPLACD (QREFELT $ 13)
                                    (SPADCALL (QCDR (QREFELT $ 13))
                                              (SPADCALL |x|
                                                        (SPADCALL |k|
                                                                  (QREFELT $
                                                                           54))
                                                        (QREFELT $ 55))
                                              (QREFELT $ 56)))
                            (QCDR (QREFELT $ 13)))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (QCDR (QREFELT $ 13))
                               (PROG1 (LETT #1# (SPADCALL |m| (QREFELT $ 26)))
                                 (|check_subtype2| (>= #1# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #1#))
                               (QREFELT $ 52))))))))))) 

(SDEFUN |COMBINAT;stirling2;3I;8| ((|n| (I)) (|m| (I)) ($ (I)))
        (SPROG ((|t| (I)) (#1=#:G805 NIL) (|s| (I)) (#2=#:G810 NIL) (|k| NIL))
               (SEQ
                (COND
                 ((OR
                   (OR (SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 24))
                       (SPADCALL |m| (|spadConstant| $ 8) (QREFELT $ 24)))
                   (SPADCALL |m| |n| (QREFELT $ 43)))
                  (|spadConstant| $ 7))
                 ((OR (SPADCALL |m| (|spadConstant| $ 8) (QREFELT $ 41))
                      (SPADCALL |n| |m| (QREFELT $ 41)))
                  (|spadConstant| $ 8))
                 ('T
                  (SEQ
                   (LETT |s|
                         (COND
                          ((SPADCALL |m| (QREFELT $ 58))
                           (SPADCALL (|spadConstant| $ 8) (QREFELT $ 31)))
                          ('T (|spadConstant| $ 8))))
                   (LETT |t| (|spadConstant| $ 7))
                   (SEQ (LETT |k| 1) (LETT #2# (SPADCALL |m| (QREFELT $ 26)))
                        G190 (COND ((|greater_SI| |k| #2#) (GO G191)))
                        (SEQ (LETT |s| (SPADCALL |s| (QREFELT $ 31)))
                             (EXIT
                              (LETT |t|
                                    (SPADCALL |t|
                                              (SPADCALL
                                               (SPADCALL |s|
                                                         (SPADCALL |m|
                                                                   (SPADCALL
                                                                    |k|
                                                                    (QREFELT $
                                                                             25))
                                                                   (QREFELT $
                                                                            46))
                                                         (QREFELT $ 30))
                                               (SPADCALL
                                                (SPADCALL |k| (QREFELT $ 25))
                                                (PROG1
                                                    (LETT #1#
                                                          (SPADCALL |n|
                                                                    (QREFELT $
                                                                             26)))
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 59))
                                               (QREFELT $ 30))
                                              (QREFELT $ 28)))))
                        (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                   (EXIT
                    (SPADCALL |t| (SPADCALL |m| (QREFELT $ 42))
                              (QREFELT $ 47))))))))) 

(SDEFUN |COMBINAT;catalan;2I;9| ((|n| (I)) ($ (I)))
        (SPROG ((#1=#:G812 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL
                          (SPADCALL (SPADCALL 2 |n| (QREFELT $ 45)) |n|
                                    (QREFELT $ 46))
                          (SPADCALL |n| (|spadConstant| $ 8) (QREFELT $ 28))
                          (QREFELT $ 62)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                 (|Union| (QREFELT $ 6) "failed") #1#)))) 

(DECLAIM (NOTINLINE |IntegerCombinatoricFunctions;|)) 

(DEFUN |IntegerCombinatoricFunctions| (#1=#:G815)
  (SPROG NIL
         (PROG (#2=#:G816)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegerCombinatoricFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IntegerCombinatoricFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IntegerCombinatoricFunctions|)))))))))) 

(DEFUN |IntegerCombinatoricFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegerCombinatoricFunctions| DV$1))
          (LETT $ (GETREFV 64))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerCombinatoricFunctions|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (CONS (|spadConstant| $ 7) (|spadConstant| $ 8)))
          (QSETREFV $ 10
                    (VECTOR (|spadConstant| $ 7) (|spadConstant| $ 7)
                            (|spadConstant| $ 7)))
          (QSETREFV $ 13 (CONS (|spadConstant| $ 7) (|spadConstant| $ 12)))
          (QSETREFV $ 18 (SPADCALL 1 (|spadConstant| $ 8) (QREFELT $ 17)))
          $))) 

(MAKEPROP '|IntegerCombinatoricFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (4 . |One|)
              'F 'B (|SparseUnivariatePolynomial| 6) (8 . |Zero|) 'S
              (12 . |One|) (|NonNegativeInteger|)
              (|IndexedFlexibleArray| 6 (NRTEVAL 0)) (16 . |new|) 'P
              (|Integer|) (22 . |minIndex|) (|Boolean|) (27 . ~=) (33 . |#|)
              (38 . <) (44 . |coerce|) (49 . |convert|) (54 . |elt|) (60 . +)
              (66 . |concat!|) (72 . *) (78 . -) (83 . |setelt!|)
              |COMBINAT;partition;2I;1|
              (|IndexedOneDimensionalArray| 6 (NRTEVAL 0)) (90 . |new|)
              (96 . |setelt!|) (103 . -) (109 . |elt|)
              |COMBINAT;distinct_partition;2I;2| (115 . <=) (121 . =)
              |COMBINAT;factorial;2I;3| (127 . >) (|PositiveInteger|) (133 . *)
              |COMBINAT;binomial;3I;4| (139 . |quo|) (145 . >=) (|List| 6)
              |COMBINAT;multinomial;ILI;5| |COMBINAT;permutation;3I;6|
              (151 . |coefficient|) (157 . |monomial|) (163 . |coerce|)
              (168 . -) (174 . *) |COMBINAT;stirling1;3I;7| (180 . |odd?|)
              (185 . ^) |COMBINAT;stirling2;3I;8| (|Union| $ '"failed")
              (191 . |exquo|) |COMBINAT;catalan;2I;9|)
           '#(|stirling2| 197 |stirling1| 203 |permutation| 209 |partition| 215
              |multinomial| 220 |factorial| 226 |distinct_partition| 231
              |catalan| 236 |binomial| 241)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|binomial| (|#1| |#1| |#1|)) T)
                                   '((|factorial| (|#1| |#1|)) T)
                                   '((|multinomial| (|#1| |#1| (|List| |#1|)))
                                     T)
                                   '((|partition| (|#1| |#1|)) T)
                                   '((|distinct_partition| (|#1| |#1|)) T)
                                   '((|permutation| (|#1| |#1| |#1|)) T)
                                   '((|stirling1| (|#1| |#1| |#1|)) T)
                                   '((|stirling2| (|#1| |#1| |#1|)) T)
                                   '((|catalan| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 63
                                            '(0 6 0 7 0 6 0 8 0 11 0 12 0 11 0
                                              14 2 16 0 15 6 17 1 16 19 0 20 2
                                              19 21 0 0 22 1 16 15 0 23 2 6 21
                                              0 0 24 1 6 0 19 25 1 6 19 0 26 2
                                              16 6 0 19 27 2 6 0 0 0 28 2 16 0
                                              0 0 29 2 6 0 0 0 30 1 6 0 0 31 3
                                              16 6 0 19 6 32 2 34 0 15 6 35 3
                                              34 6 0 19 6 36 2 6 0 0 0 37 2 34
                                              6 0 19 38 2 6 21 0 0 40 2 6 21 0
                                              0 41 2 6 21 0 0 43 2 6 0 44 0 45
                                              2 6 0 0 0 47 2 6 21 0 0 48 2 11 6
                                              0 15 52 2 11 0 6 15 53 1 11 0 19
                                              54 2 11 0 0 0 55 2 11 0 0 0 56 1
                                              6 21 0 58 2 6 0 0 15 59 2 6 61 0
                                              0 62 2 0 6 6 6 60 2 0 6 6 6 57 2
                                              0 6 6 6 51 1 0 6 6 33 2 0 6 6 49
                                              50 1 0 6 6 42 1 0 6 6 39 1 0 6 6
                                              63 2 0 6 6 6 46)))))
           '|lookupComplete|)) 
