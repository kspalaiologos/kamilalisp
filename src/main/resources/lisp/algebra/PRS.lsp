
(SDEFUN |PRS;*| ((|r| (R)) (|v| (|Vector| |polR|)) ($ (|Vector| |polR|)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 12)) |v| (QREFELT $ 14))) 

(SDEFUN |PRS;exquo| ((|v| (|Vector| |polR|)) (|r| (R)) ($ (|Vector| |polR|)))
        (SPROG NIL
               (SPADCALL (CONS #'|PRS;exquo!0| (VECTOR (QREFELT $ 7) $ |r|))
                         |v| (QREFELT $ 18)))) 

(SDEFUN |PRS;exquo!0| ((|p1| NIL) ($$ NIL))
        (PROG (|r| $ |polR|)
          (LETT |r| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |polR| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G863 NIL))
                   (PROG2 (LETT #1# (SPADCALL |p1| |r| (QREFELT $ 16)))
                       (QCDR #1#)
                     (|check_union2| (QEQCAR #1# 0) |polR|
                                     (|Union| |polR| "failed") #1#))))))) 

(SDEFUN |PRS;divide;2polRR;3|
        ((F (|polR|)) (G (|polR|))
         ($ (|Record| (|:| |quotient| |polR|) (|:| |remainder| |polR|))))
        (SPROG
         ((#1=#:G883 NIL) (|quot| (|polR|)) (|mon| (|polR|)) (#2=#:G876 NIL)
          (#3=#:G874 NIL) (|delta| (|Integer|)) (#4=#:G869 NIL)
          (|degG| (|NonNegativeInteger|)) (|lcG| (R)))
         (SEQ
          (EXIT
           (SEQ (LETT |lcG| (SPADCALL G (QREFELT $ 19)))
                (LETT |degG| (SPADCALL G (QREFELT $ 20)))
                (EXIT
                 (COND
                  ((ZEROP |degG|)
                   (SEQ
                    (LETT F
                          (PROG2 (LETT #4# (SPADCALL F |lcG| (QREFELT $ 16)))
                              (QCDR #4#)
                            (|check_union2| (QEQCAR #4# 0) (QREFELT $ 7)
                                            (|Union| (QREFELT $ 7) "failed")
                                            #4#)))
                    (EXIT
                     (PROGN
                      (LETT #1# (CONS F (|spadConstant| $ 22)))
                      (GO #5=#:G882)))))
                  ('T
                   (SEQ (LETT G (SPADCALL G (QREFELT $ 23)))
                        (LETT |quot| (|spadConstant| $ 22))
                        (SEQ G190
                             (COND
                              ((NULL
                                (>=
                                 (LETT |delta|
                                       (- (SPADCALL F (QREFELT $ 20)) |degG|))
                                 0))
                               (GO G191)))
                             (SEQ
                              (LETT |mon|
                                    (SPADCALL
                                     (PROG2
                                         (LETT #3#
                                               (SPADCALL
                                                (SPADCALL F (QREFELT $ 19))
                                                |lcG| (QREFELT $ 24)))
                                         (QCDR #3#)
                                       (|check_union2| (QEQCAR #3# 0)
                                                       (QREFELT $ 6)
                                                       (|Union| (QREFELT $ 6)
                                                                "failed")
                                                       #3#))
                                     (PROG1 (LETT #2# |delta|)
                                       (|check_subtype2| (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#))
                                     (QREFELT $ 10)))
                              (LETT |quot|
                                    (SPADCALL |quot| |mon| (QREFELT $ 25)))
                              (EXIT
                               (LETT F
                                     (SPADCALL (SPADCALL F (QREFELT $ 23))
                                               (SPADCALL |mon| G
                                                         (QREFELT $ 26))
                                               (QREFELT $ 27)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (PROGN (LETT #1# (CONS |quot| F)) (GO #5#)))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |PRS;resultant_naif| ((P (|polR|)) (Q (|polR|)) ($ (R)))
        (SPROG
         ((|#G19| (|polR|)) (|#G18| (|polR|)) (|a| (R)) (#1=#:G891 NIL)
          (U (|polR|)) (#2=#:G898 NIL) (|degQ| #3=(|NonNegativeInteger|))
          (|degP| #3#) (|#G17| #3#) (|#G16| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |a| (|spadConstant| $ 8))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL Q (QREFELT $ 31))
                          (PROGN
                           (LETT #2# (|spadConstant| $ 21))
                           (GO #4=#:G897)))
                         ('T
                          (SEQ
                           (PROGN
                            (LETT |#G16| (SPADCALL P (QREFELT $ 20)))
                            (LETT |#G17| (SPADCALL Q (QREFELT $ 20)))
                            (LETT |degP| |#G16|)
                            (LETT |degQ| |#G17|))
                           (COND
                            ((ODDP |degP|)
                             (COND
                              ((ODDP |degQ|)
                               (LETT |a| (SPADCALL |a| (QREFELT $ 32)))))))
                           (EXIT
                            (COND
                             ((ZEROP |degQ|)
                              (PROGN
                               (LETT #2#
                                     (SPADCALL |a|
                                               (SPADCALL
                                                (SPADCALL Q (QREFELT $ 19))
                                                |degP| (QREFELT $ 33))
                                               (QREFELT $ 34)))
                               (GO #4#)))
                             ('T
                              (SEQ
                               (LETT U (QCDR (SPADCALL P Q (QREFELT $ 29))))
                               (LETT |a|
                                     (SPADCALL |a|
                                               (SPADCALL
                                                (SPADCALL Q (QREFELT $ 19))
                                                (PROG1
                                                    (LETT #1#
                                                          (- |degP|
                                                             (SPADCALL U
                                                                       (QREFELT
                                                                        $
                                                                        20))))
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 33))
                                               (QREFELT $ 34)))
                               (EXIT
                                (PROGN
                                 (LETT |#G18| Q)
                                 (LETT |#G19| U)
                                 (LETT P |#G18|)
                                 (LETT Q |#G19|))))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #4# (EXIT #2#)))) 

(SDEFUN |PRS;resultantEuclidean_naif|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |resultant| R))))
        (SPROG
         ((|cf2| (|polR|)) (|cf1| (|polR|)) (|old_cf2| (|polR|))
          (|old_cf1| (|polR|)) (|#G29| (|polR|)) (|#G28| (|polR|))
          (|#G27| (|polR|)) (|#G26| (|polR|)) (|#G25| (|polR|))
          (|#G24| (|polR|)) (|a| (R)) (#1=#:G911 NIL)
          (|divid| (|Record| (|:| |quotient| |polR|) (|:| |remainder| |polR|)))
          (#2=#:G917 NIL) (#3=#:G905 NIL) (|degQ| #4=(|NonNegativeInteger|))
          (|degP| #4#) (|#G23| #4#) (|#G22| #4#))
         (SEQ
          (EXIT
           (SEQ (LETT |a| (|spadConstant| $ 8))
                (LETT |old_cf1| (|spadConstant| $ 35))
                (LETT |cf1| (|spadConstant| $ 22))
                (LETT |old_cf2| (|spadConstant| $ 22))
                (LETT |cf2| (|spadConstant| $ 35))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL Q (QREFELT $ 31))
                          (PROGN
                           (LETT #2#
                                 (VECTOR (|spadConstant| $ 22)
                                         (|spadConstant| $ 22)
                                         (|spadConstant| $ 21)))
                           (GO #5=#:G916)))
                         ('T
                          (SEQ
                           (PROGN
                            (LETT |#G22| (SPADCALL P (QREFELT $ 20)))
                            (LETT |#G23| (SPADCALL Q (QREFELT $ 20)))
                            (LETT |degP| |#G22|)
                            (LETT |degQ| |#G23|))
                           (COND
                            ((ODDP |degP|)
                             (COND
                              ((ODDP |degQ|)
                               (LETT |a| (SPADCALL |a| (QREFELT $ 32)))))))
                           (COND
                            ((ZEROP |degQ|)
                             (SEQ
                              (LETT |a|
                                    (SPADCALL |a|
                                              (SPADCALL
                                               (SPADCALL Q (QREFELT $ 19))
                                               (PROG1 (LETT #3# (- |degP| 1))
                                                 (|check_subtype2| (>= #3# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #3#))
                                               (QREFELT $ 33))
                                              (QREFELT $ 34)))
                              (EXIT
                               (PROGN
                                (LETT #2#
                                      (VECTOR
                                       (SPADCALL |a| |cf1| (QREFELT $ 36))
                                       (SPADCALL |a| |cf2| (QREFELT $ 36))
                                       (SPADCALL |a|
                                                 (SPADCALL Q (QREFELT $ 19))
                                                 (QREFELT $ 34))))
                                (GO #5#))))))
                           (LETT |divid| (SPADCALL P Q (QREFELT $ 29)))
                           (LETT |a|
                                 (SPADCALL |a|
                                           (SPADCALL
                                            (SPADCALL Q (QREFELT $ 19))
                                            (PROG1
                                                (LETT #1#
                                                      (- |degP|
                                                         (SPADCALL
                                                          (QCDR |divid|)
                                                          (QREFELT $ 20))))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 33))
                                           (QREFELT $ 34)))
                           (PROGN
                            (LETT |#G24| Q)
                            (LETT |#G25| (QCDR |divid|))
                            (LETT P |#G24|)
                            (LETT Q |#G25|))
                           (EXIT
                            (PROGN
                             (LETT |#G26| |cf1|)
                             (LETT |#G27| |cf2|)
                             (LETT |#G28|
                                   (SPADCALL |old_cf1|
                                             (SPADCALL (QCAR |divid|) |cf1|
                                                       (QREFELT $ 26))
                                             (QREFELT $ 27)))
                             (LETT |#G29|
                                   (SPADCALL |old_cf2|
                                             (SPADCALL (QCAR |divid|) |cf2|
                                                       (QREFELT $ 26))
                                             (QREFELT $ 27)))
                             (LETT |old_cf1| |#G26|)
                             (LETT |old_cf2| |#G27|)
                             (LETT |cf1| |#G28|)
                             (LETT |cf2| |#G29|))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |PRS;semiResultantEuclidean_naif|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |resultant| R))))
        (SPROG
         ((|cf2| (|polR|)) (|old_cf2| (|polR|)) (|#G37| (|polR|))
          (|#G36| (|polR|)) (|#G35| (|polR|)) (|#G34| (|polR|)) (|a| (R))
          (#1=#:G930 NIL)
          (|divid| (|Record| (|:| |quotient| |polR|) (|:| |remainder| |polR|)))
          (#2=#:G936 NIL) (#3=#:G924 NIL) (|degQ| #4=(|NonNegativeInteger|))
          (|degP| #4#) (|#G33| #4#) (|#G32| #4#))
         (SEQ
          (EXIT
           (SEQ (LETT |a| (|spadConstant| $ 8))
                (LETT |old_cf2| (|spadConstant| $ 22))
                (LETT |cf2| (|spadConstant| $ 35))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL Q (QREFELT $ 31))
                          (PROGN
                           (LETT #2#
                                 (CONS (|spadConstant| $ 22)
                                       (|spadConstant| $ 21)))
                           (GO #5=#:G935)))
                         ('T
                          (SEQ
                           (PROGN
                            (LETT |#G32| (SPADCALL P (QREFELT $ 20)))
                            (LETT |#G33| (SPADCALL Q (QREFELT $ 20)))
                            (LETT |degP| |#G32|)
                            (LETT |degQ| |#G33|))
                           (COND
                            ((ODDP |degP|)
                             (COND
                              ((ODDP |degQ|)
                               (LETT |a| (SPADCALL |a| (QREFELT $ 32)))))))
                           (COND
                            ((ZEROP |degQ|)
                             (SEQ
                              (LETT |a|
                                    (SPADCALL |a|
                                              (SPADCALL
                                               (SPADCALL Q (QREFELT $ 19))
                                               (PROG1 (LETT #3# (- |degP| 1))
                                                 (|check_subtype2| (>= #3# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #3#))
                                               (QREFELT $ 33))
                                              (QREFELT $ 34)))
                              (EXIT
                               (PROGN
                                (LETT #2#
                                      (CONS (SPADCALL |a| |cf2| (QREFELT $ 36))
                                            (SPADCALL |a|
                                                      (SPADCALL Q
                                                                (QREFELT $ 19))
                                                      (QREFELT $ 34))))
                                (GO #5#))))))
                           (LETT |divid| (SPADCALL P Q (QREFELT $ 29)))
                           (LETT |a|
                                 (SPADCALL |a|
                                           (SPADCALL
                                            (SPADCALL Q (QREFELT $ 19))
                                            (PROG1
                                                (LETT #1#
                                                      (- |degP|
                                                         (SPADCALL
                                                          (QCDR |divid|)
                                                          (QREFELT $ 20))))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 33))
                                           (QREFELT $ 34)))
                           (PROGN
                            (LETT |#G34| Q)
                            (LETT |#G35| (QCDR |divid|))
                            (LETT P |#G34|)
                            (LETT Q |#G35|))
                           (EXIT
                            (PROGN
                             (LETT |#G36| |cf2|)
                             (LETT |#G37|
                                   (SPADCALL |old_cf2|
                                             (SPADCALL (QCAR |divid|) |cf2|
                                                       (QREFELT $ 26))
                                             (QREFELT $ 27)))
                             (LETT |old_cf2| |#G36|)
                             (LETT |cf2| |#G37|))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |PRS;exactQuo| ((|x| (R)) (|y| (R)) ($ (R)))
        (SPROG ((|ex| (|Union| R "failed")))
               (SEQ (LETT |ex| (SPADCALL |x| |y| (QREFELT $ 24)))
                    (EXIT
                     (COND ((QEQCAR |ex| 0) (QCDR |ex|))
                           ('T (|error| "exactQuo$PRS: bad args"))))))) 

(SDEFUN |PRS;LazardQuotient;2RNniR;8|
        ((|x| (R)) (|y| (R)) (|n| (|NonNegativeInteger|)) ($ (R)))
        (SPROG
         ((#1=#:G946 NIL) (|c| (R)) (|a| (|NonNegativeInteger|))
          (#2=#:G953 NIL) (#3=#:G944 NIL) (|b| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND ((ZEROP |n|) (|error| "Lazard$PRS : n = 0")) ((EQL |n| 1) |x|)
                 ('T
                  (SEQ (LETT |a| 1)
                       (SEQ G190
                            (COND
                             ((NULL (>= |n| (LETT |b| (* 2 |a|)))) (GO G191)))
                            (SEQ (EXIT (LETT |a| |b|))) NIL (GO G190) G191
                            (EXIT NIL))
                       (LETT |c| |x|)
                       (LETT |n|
                             (PROG1 (LETT #3# (- |n| |a|))
                               (|check_subtype2| (>= #3# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #3#)))
                       (EXIT
                        (SEQ G190 NIL
                             (SEQ
                              (EXIT
                               (COND
                                ((EQL |a| 1)
                                 (PROGN (LETT #2# |c|) (GO #4=#:G952)))
                                ('T
                                 (SEQ (LETT |a| (QUOTIENT2 |a| 2))
                                      (LETT |c|
                                            (|PRS;exactQuo|
                                             (SPADCALL |c| |c| (QREFELT $ 34))
                                             |y| $))
                                      (EXIT
                                       (COND
                                        ((>= |n| |a|)
                                         (SEQ
                                          (LETT |c|
                                                (|PRS;exactQuo|
                                                 (SPADCALL |c| |x|
                                                           (QREFELT $ 34))
                                                 |y| $))
                                          (EXIT
                                           (LETT |n|
                                                 (PROG1 (LETT #1# (- |n| |a|))
                                                   (|check_subtype2| (>= #1# 0)
                                                                     '(|NonNegativeInteger|)
                                                                     '(|Integer|)
                                                                     #1#)))))))))))))
                             NIL (GO G190) G191 (EXIT NIL)))))))
          #4# (EXIT #2#)))) 

(SDEFUN |PRS;LazardQuotient2;polR2RNnipolR;9|
        ((F (|polR|)) (|x| (R)) (|y| (R)) (|n| (|NonNegativeInteger|))
         ($ (|polR|)))
        (SPROG ((#1=#:G961 NIL) (#2=#:G956 NIL) (#3=#:G954 NIL))
               (SEQ
                (EXIT
                 (COND ((ZEROP |n|) (|error| "LazardQuotient2$PRS : n = 0"))
                       ((EQL |n| 1) F)
                       ('T
                        (SEQ
                         (LETT |x|
                               (SPADCALL |x| |y|
                                         (PROG1 (LETT #3# (- |n| 1))
                                           (|check_subtype2| (>= #3# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #3#))
                                         (QREFELT $ 37)))
                         (EXIT
                          (PROGN
                           (LETT #1#
                                 (PROG2
                                     (LETT #2#
                                           (SPADCALL
                                            (SPADCALL |x| F (QREFELT $ 36)) |y|
                                            (QREFELT $ 16)))
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                                   (|Union| (QREFELT $ 7)
                                                            "failed")
                                                   #2#)))
                           (GO #4=#:G960)))))))
                #4# (EXIT #1#)))) 

(SDEFUN |PRS;Lazard3|
        ((V (|Vector| |polR|)) (|x| (R)) (|y| (R)) (|n| (|NonNegativeInteger|))
         ($ (|Vector| |polR|)))
        (SPROG ((#1=#:G962 NIL))
               (SEQ
                (COND ((ZEROP |n|) (|error| "Lazard3$prs : n = 0"))
                      ((EQL |n| 1) V)
                      ('T
                       (SEQ
                        (LETT |x|
                              (SPADCALL |x| |y|
                                        (PROG1 (LETT #1# (- |n| 1))
                                          (|check_subtype2| (>= #1# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #1#))
                                        (QREFELT $ 37)))
                        (EXIT (|PRS;exquo| (|PRS;*| |x| V $) |y| $)))))))) 

(SDEFUN |PRS;next_sousResultant2;3polRRpolR;11|
        ((P (|polR|)) (Q (|polR|)) (Z (|polR|)) (|s| (R)) ($ (|polR|)))
        (SPROG
         ((#1=#:G981 NIL) (A (|polR|)) (#2=#:G970 NIL) (H (|polR|))
          (#3=#:G982 NIL) (|i| NIL) (|#G64| (|polR|)) (|#G63| (|polR|))
          (|#G62| (|polR|)) (|e| #4=(|NonNegativeInteger|)) (|d| #4#)
          (|#G61| #4#) (|#G60| #4#) (|se| (R)) (|c| (R)) (|lcP| (R))
          (|#G59| (R)) (|#G58| (R)) (|#G57| (R)))
         (SEQ
          (EXIT
           (SEQ
            (PROGN
             (LETT |#G57| (SPADCALL P (QREFELT $ 19)))
             (LETT |#G58| (SPADCALL Q (QREFELT $ 19)))
             (LETT |#G59| (SPADCALL Z (QREFELT $ 19)))
             (LETT |lcP| |#G57|)
             (LETT |c| |#G58|)
             (LETT |se| |#G59|))
            (PROGN
             (LETT |#G60| (SPADCALL P (QREFELT $ 20)))
             (LETT |#G61| (SPADCALL Q (QREFELT $ 20)))
             (LETT |d| |#G60|)
             (LETT |e| |#G61|))
            (PROGN
             (LETT |#G62| (SPADCALL P (QREFELT $ 23)))
             (LETT |#G63| (SPADCALL Q (QREFELT $ 23)))
             (LETT |#G64|
                   (SPADCALL (SPADCALL Z (QREFELT $ 23)) (QREFELT $ 39)))
             (LETT P |#G62|)
             (LETT Q |#G63|)
             (LETT H |#G64|))
            (LETT A
                  (SPADCALL (SPADCALL P |e| (QREFELT $ 40)) H (QREFELT $ 36)))
            (SEQ (LETT |i| (+ |e| 1)) (LETT #3# (- |d| 1)) G190
                 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (LETT H
                        (COND
                         ((EQL (SPADCALL H (QREFELT $ 20)) (- |e| 1))
                          (SPADCALL
                           (SPADCALL (QREFELT $ 11) (SPADCALL H (QREFELT $ 23))
                                     (QREFELT $ 26))
                           (PROG2
                               (LETT #2#
                                     (SPADCALL
                                      (SPADCALL (SPADCALL H (QREFELT $ 19)) Q
                                                (QREFELT $ 36))
                                      |c| (QREFELT $ 16)))
                               (QCDR #2#)
                             (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                             (|Union| (QREFELT $ 7)
                                                      #5="failed")
                                             #2#))
                           (QREFELT $ 27)))
                         ('T (SPADCALL (QREFELT $ 11) H (QREFELT $ 26)))))
                  (EXIT
                   (LETT A
                         (SPADCALL
                          (SPADCALL (SPADCALL P |i| (QREFELT $ 40)) H
                                    (QREFELT $ 36))
                          A (QREFELT $ 25)))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (SEQ G190
                 (COND ((NULL (>= (SPADCALL P (QREFELT $ 20)) |e|)) (GO G191)))
                 (SEQ (EXIT (LETT P (SPADCALL P (QREFELT $ 23))))) NIL
                 (GO G190) G191 (EXIT NIL))
            (LETT A
                  (SPADCALL A (SPADCALL |se| P (QREFELT $ 36)) (QREFELT $ 25)))
            (LETT A
                  (PROG2 (LETT #2# (SPADCALL A |lcP| (QREFELT $ 16)))
                      (QCDR #2#)
                    (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                    (|Union| (QREFELT $ 7) #5#) #2#)))
            (LETT A
                  (COND
                   ((EQL (SPADCALL H (QREFELT $ 20)) (- |e| 1))
                    (SPADCALL
                     (SPADCALL |c|
                               (SPADCALL
                                (SPADCALL (QREFELT $ 11)
                                          (SPADCALL H (QREFELT $ 23))
                                          (QREFELT $ 26))
                                A (QREFELT $ 25))
                               (QREFELT $ 36))
                     (SPADCALL (SPADCALL H (QREFELT $ 19)) Q (QREFELT $ 36))
                     (QREFELT $ 27)))
                   (#6='T
                    (SPADCALL |c|
                              (SPADCALL
                               (SPADCALL (QREFELT $ 11) H (QREFELT $ 26)) A
                               (QREFELT $ 25))
                              (QREFELT $ 36)))))
            (LETT A
                  (PROG2 (LETT #2# (SPADCALL A |s| (QREFELT $ 16)))
                      (QCDR #2#)
                    (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                    (|Union| (QREFELT $ 7) #5#) #2#)))
            (EXIT
             (PROGN
              (LETT #1#
                    (COND ((ODDP (- |d| |e|)) A)
                          (#6# (SPADCALL A (QREFELT $ 39)))))
              (GO #7=#:G980)))))
          #7# (EXIT #1#)))) 

(SDEFUN |PRS;next_sousResultant3|
        ((VP (|Vector| |polR|)) (VQ (|Vector| |polR|)) (|s| (R)) (|ss| (R))
         ($ (|Vector| |polR|)))
        (SPROG
         ((#1=#:G1001 NIL) (#2=#:G987 NIL) (#3=#:G1002 NIL) (|i| NIL)
          (|divid| (|Record| (|:| |quotient| |polR|) (|:| |remainder| |polR|)))
          (|rr| (R)) (|r| (R)) (|#G75| (R)) (|#G74| (R)) (#4=#:G983 NIL)
          (|delta| (|Integer|)) (|e| (|NonNegativeInteger|)) (|c| (R))
          (|lcP| (R)) (|#G73| (R)) (|#G72| (R)) (Q (|polR|)) (P (|polR|))
          (|#G71| (|polR|)) (|#G70| (|polR|)))
         (SEQ
          (EXIT
           (SEQ
            (PROGN
             (LETT |#G70| (SPADCALL VP 1 (QREFELT $ 43)))
             (LETT |#G71| (SPADCALL VQ 1 (QREFELT $ 43)))
             (LETT P |#G70|)
             (LETT Q |#G71|))
            (PROGN
             (LETT |#G72| (SPADCALL P (QREFELT $ 19)))
             (LETT |#G73| (SPADCALL Q (QREFELT $ 19)))
             (LETT |lcP| |#G72|)
             (LETT |c| |#G73|))
            (LETT |e| (SPADCALL Q (QREFELT $ 20)))
            (SEQ (LETT |delta| (- (SPADCALL P (QREFELT $ 20)) |e|))
                 (EXIT
                  (COND
                   ((EQL |delta| 1)
                    (SEQ
                     (LETT VP
                           (SPADCALL (|PRS;*| |c| VP $)
                                     (|PRS;*| (SPADCALL P |e| (QREFELT $ 40))
                                      VQ $)
                                     (QREFELT $ 44)))
                     (LETT VP (|PRS;exquo| VP |lcP| $))
                     (LETT VP
                           (SPADCALL
                            (|PRS;*| |c|
                             (SPADCALL VP
                                       (SPADCALL (QREFELT $ 11) VQ
                                                 (QREFELT $ 14))
                                       (QREFELT $ 44))
                             $)
                            (|PRS;*|
                             (SPADCALL Q
                                       (PROG1 (LETT #4# (- |e| 1))
                                         (|check_subtype2| (>= #4# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #4#))
                                       (QREFELT $ 40))
                             VQ $)
                            (QREFELT $ 45)))
                     (EXIT (LETT VP (|PRS;exquo| VP |s| $)))))
                   (#5='T
                    (SEQ
                     (PROGN
                      (LETT |#G74| (SPADCALL |s| |lcP| (QREFELT $ 34)))
                      (LETT |#G75| (SPADCALL |ss| |c| (QREFELT $ 34)))
                      (LETT |r| |#G74|)
                      (LETT |rr| |#G75|))
                     (LETT |divid|
                           (SPADCALL (SPADCALL |rr| P (QREFELT $ 36)) Q
                                     (QREFELT $ 29)))
                     (SPADCALL VP 1
                               (PROG2
                                   (LETT #2#
                                         (SPADCALL (QCDR |divid|) |r|
                                                   (QREFELT $ 16)))
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                                 (|Union| (QREFELT $ 7)
                                                          #6="failed")
                                                 #2#))
                               (QREFELT $ 46))
                     (EXIT
                      (SEQ (LETT |i| 2) (LETT #3# (QVSIZE VP)) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ
                            (SPADCALL VP |i|
                                      (SPADCALL
                                       (SPADCALL |rr|
                                                 (SPADCALL VP |i|
                                                           (QREFELT $ 43))
                                                 (QREFELT $ 36))
                                       (SPADCALL
                                        (SPADCALL VQ |i| (QREFELT $ 43))
                                        (QCAR |divid|) (QREFELT $ 26))
                                       (QREFELT $ 27))
                                      (QREFELT $ 46))
                            (EXIT
                             (SPADCALL VP |i|
                                       (PROG2
                                           (LETT #2#
                                                 (SPADCALL
                                                  (SPADCALL VP |i|
                                                            (QREFELT $ 43))
                                                  |r| (QREFELT $ 16)))
                                           (QCDR #2#)
                                         (|check_union2| (QEQCAR #2# 0)
                                                         (QREFELT $ 7)
                                                         (|Union| (QREFELT $ 7)
                                                                  #6#)
                                                         #2#))
                                       (QREFELT $ 46))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                           (EXIT NIL))))))))
            (EXIT
             (PROGN
              (LETT #1#
                    (COND ((ODDP |delta|) VP)
                          (#5# (SPADCALL VP (QREFELT $ 47)))))
              (GO #7=#:G1000)))))
          #7# (EXIT #1#)))) 

(SDEFUN |PRS;algo_new| ((P (|polR|)) (Q (|polR|)) ($ (R)))
        (SPROG
         ((|s| (R)) (|#G82| (|polR|)) (|#G81| (|polR|)) (#1=#:G1012 NIL)
          (Z (|polR|)) (|delta| (|NonNegativeInteger|)) (#2=#:G1005 NIL)
          (|#G80| (|polR|)) (|#G79| (|polR|)) (#3=#:G1003 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |delta|
                  (PROG1
                      (LETT #3#
                            (- (SPADCALL P (QREFELT $ 20))
                               (SPADCALL Q (QREFELT $ 20))))
                    (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #3#)))
            (LETT |s|
                  (SPADCALL (SPADCALL Q (QREFELT $ 19)) |delta|
                            (QREFELT $ 33)))
            (PROGN
             (LETT |#G79| Q)
             (LETT |#G80|
                   (SPADCALL P (SPADCALL Q (QREFELT $ 39)) (QREFELT $ 48)))
             (LETT P |#G79|)
             (LETT Q |#G80|))
            (EXIT
             (SEQ G190 NIL
                  (SEQ
                   (EXIT
                    (COND
                     ((SPADCALL Q (QREFELT $ 31))
                      (PROGN (LETT #1# (|spadConstant| $ 21)) (GO #4=#:G1011)))
                     ('T
                      (SEQ
                       (LETT |delta|
                             (PROG1
                                 (LETT #2#
                                       (- (SPADCALL P (QREFELT $ 20))
                                          (SPADCALL Q (QREFELT $ 20))))
                               (|check_subtype2| (>= #2# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #2#)))
                       (LETT Z
                             (SPADCALL Q (SPADCALL Q (QREFELT $ 19)) |s|
                                       |delta| (QREFELT $ 38)))
                       (EXIT
                        (COND
                         ((ZEROP (SPADCALL Z (QREFELT $ 20)))
                          (PROGN
                           (LETT #1# (SPADCALL Z (QREFELT $ 19)))
                           (GO #4#)))
                         ('T
                          (SEQ
                           (PROGN
                            (LETT |#G81| Q)
                            (LETT |#G82| (SPADCALL P Q Z |s| (QREFELT $ 41)))
                            (LETT P |#G81|)
                            (LETT Q |#G82|))
                           (EXIT
                            (LETT |s| (SPADCALL Z (QREFELT $ 19)))))))))))))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRS;resultant;2polRR;14| ((P (|polR|)) (Q (|polR|)) ($ (R)))
        (SPROG
         ((|degQ| #1=(|NonNegativeInteger|)) (|degP| #1#) (|#G90| #1#)
          (|#G89| #1#) (|#G88| (|polR|)) (|#G87| (|polR|)) (|#G86| #1#)
          (|#G85| #1#))
         (SEQ
          (COND
           ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
            (|spadConstant| $ 21))
           ('T
            (SEQ
             (PROGN
              (LETT |#G85| (SPADCALL P (QREFELT $ 20)))
              (LETT |#G86| (SPADCALL Q (QREFELT $ 20)))
              (LETT |degP| |#G85|)
              (LETT |degQ| |#G86|))
             (COND
              ((< |degP| |degQ|)
               (SEQ
                (PROGN
                 (LETT |#G87| Q)
                 (LETT |#G88| P)
                 (LETT P |#G87|)
                 (LETT Q |#G88|))
                (PROGN
                 (LETT |#G89| |degQ|)
                 (LETT |#G90| |degP|)
                 (LETT |degP| |#G89|)
                 (LETT |degQ| |#G90|))
                (EXIT
                 (COND
                  ((ODDP |degP|)
                   (COND
                    ((ODDP |degQ|) (LETT Q (SPADCALL Q (QREFELT $ 39)))))))))))
             (EXIT
              (COND
               ((ZEROP |degQ|)
                (SPADCALL (SPADCALL Q (QREFELT $ 19)) |degP| (QREFELT $ 49)))
               ('T (|PRS;resultant_naif| P Q $)))))))))) 

(SDEFUN |PRS;resultant;2polRR;15| ((P (|polR|)) (Q (|polR|)) ($ (R)))
        (SPROG
         ((|degQ| #1=(|NonNegativeInteger|)) (|degP| #1#) (|#G98| #1#)
          (|#G97| #1#) (|#G96| (|polR|)) (|#G95| (|polR|)) (|#G94| #1#)
          (|#G93| #1#))
         (SEQ
          (COND
           ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
            (|spadConstant| $ 21))
           ('T
            (SEQ
             (PROGN
              (LETT |#G93| (SPADCALL P (QREFELT $ 20)))
              (LETT |#G94| (SPADCALL Q (QREFELT $ 20)))
              (LETT |degP| |#G93|)
              (LETT |degQ| |#G94|))
             (COND
              ((< |degP| |degQ|)
               (SEQ
                (PROGN
                 (LETT |#G95| Q)
                 (LETT |#G96| P)
                 (LETT P |#G95|)
                 (LETT Q |#G96|))
                (PROGN
                 (LETT |#G97| |degQ|)
                 (LETT |#G98| |degP|)
                 (LETT |degP| |#G97|)
                 (LETT |degQ| |#G98|))
                (EXIT
                 (COND
                  ((ODDP |degP|)
                   (COND
                    ((ODDP |degQ|) (LETT Q (SPADCALL Q (QREFELT $ 39)))))))))))
             (EXIT
              (COND
               ((ZEROP |degQ|)
                (SPADCALL (SPADCALL Q (QREFELT $ 19)) |degP| (QREFELT $ 33)))
               ('T (|PRS;algo_new| P Q $)))))))))) 

(SDEFUN |PRS;subResultantEuclidean|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |resultant| R))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G104| (|Vector| |polR|)) (|#G103| #1#) (|ss| (R)) (#2=#:G1037 NIL)
          (|l| (|Vector| |polR|)) (|delta| (|NonNegativeInteger|))
          (#3=#:G1029 NIL) (|degQ| (|NonNegativeInteger|)) (|#G102| (|polR|))
          (|#G101| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1026 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |s|
                  (SPADCALL (SPADCALL Q (QREFELT $ 19))
                            (PROG1
                                (LETT #4#
                                      (- (SPADCALL P (QREFELT $ 20))
                                         (SPADCALL Q (QREFELT $ 20))))
                              (|check_subtype2| (>= #4# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #4#))
                            (QREFELT $ 33)))
            (LETT VP (VECTOR Q (|spadConstant| $ 22) (|spadConstant| $ 35)))
            (LETT |pdiv|
                  (SPADCALL P (SPADCALL Q (QREFELT $ 39)) (QREFELT $ 52)))
            (LETT VQ
                  (VECTOR (QVELT |pdiv| 2)
                          (SPADCALL (QVELT |pdiv| 0) (QREFELT $ 12))
                          (QVELT |pdiv| 1)))
            (EXIT
             (SEQ G190 NIL
                  (SEQ
                   (PROGN
                    (LETT |#G101| (SPADCALL VP 1 (QREFELT $ 43)))
                    (LETT |#G102| (SPADCALL VQ 1 (QREFELT $ 43)))
                    (LETT P |#G101|)
                    (LETT Q |#G102|))
                   (EXIT
                    (COND
                     ((SPADCALL Q (QREFELT $ 31))
                      (PROGN
                       (LETT #2#
                             (VECTOR (|spadConstant| $ 22)
                                     (|spadConstant| $ 22)
                                     (|spadConstant| $ 21)))
                       (GO #5=#:G1036)))
                     ('T
                      (SEQ (LETT |degQ| (SPADCALL Q (QREFELT $ 20)))
                           (LETT |delta|
                                 (PROG1
                                     (LETT #3#
                                           (- (SPADCALL P (QREFELT $ 20))
                                              |degQ|))
                                   (|check_subtype2| (>= #3# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #3#)))
                           (EXIT
                            (COND
                             ((ZEROP |degQ|)
                              (SEQ
                               (LETT |l|
                                     (|PRS;Lazard3| VQ
                                      (SPADCALL Q (QREFELT $ 19)) |s| |delta|
                                      $))
                               (EXIT
                                (PROGN
                                 (LETT #2#
                                       (VECTOR (SPADCALL |l| 2 (QREFELT $ 43))
                                               (SPADCALL |l| 3 (QREFELT $ 43))
                                               (SPADCALL
                                                (SPADCALL |l| 1 (QREFELT $ 43))
                                                (QREFELT $ 19))))
                                 (GO #5#)))))
                             ('T
                              (SEQ
                               (LETT |ss|
                                     (SPADCALL (SPADCALL Q (QREFELT $ 19)) |s|
                                               |delta| (QREFELT $ 37)))
                               (PROGN
                                (LETT |#G103| VQ)
                                (LETT |#G104|
                                      (|PRS;next_sousResultant3| VP VQ |s| |ss|
                                       $))
                                (LETT VP |#G103|)
                                (LETT VQ |#G104|))
                               (EXIT (LETT |s| |ss|)))))))))))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |PRS;resultantEuclidean;2polRR;17|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |resultant| R))))
        (SPROG
         ((|s| (R)) (#1=#:G1043 NIL)
          (|l|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |resultant| R)))
          (|e| (|Integer|)) (|degQ| #2=(|NonNegativeInteger|)) (|degP| #2#)
          (|#G108| #2#) (|#G107| #2#))
         (SEQ
          (COND
           ((OR (SPADCALL P (QREFELT $ 31)) (SPADCALL Q (QREFELT $ 31)))
            (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                    (|spadConstant| $ 21)))
           ('T
            (SEQ
             (PROGN
              (LETT |#G107| (SPADCALL P (QREFELT $ 20)))
              (LETT |#G108| (SPADCALL Q (QREFELT $ 20)))
              (LETT |degP| |#G107|)
              (LETT |degQ| |#G108|))
             (EXIT
              (COND
               ((< |degP| |degQ|)
                (SEQ
                 (LETT |e|
                       (COND
                        ((ODDP |degP|) (COND ((ODDP |degQ|) -1) (#3='T 1)))
                        (#3# 1)))
                 (LETT |l|
                       (SPADCALL Q (SPADCALL |e| P (QREFELT $ 53))
                                 (QREFELT $ 55)))
                 (EXIT
                  (VECTOR (SPADCALL |e| (QVELT |l| 1) (QREFELT $ 53))
                          (QVELT |l| 0) (QVELT |l| 2)))))
               ((ZEROP |degQ|)
                (COND
                 ((ZEROP |degP|)
                  (|error| "resultantEuclidean$PRS : constant polynomials"))
                 (#3#
                  (SEQ
                   (LETT |s|
                         (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                   (PROG1 (LETT #1# (- |degP| 1))
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 49)))
                   (EXIT
                    (VECTOR (|spadConstant| $ 22) (SPADCALL |s| (QREFELT $ 12))
                            (SPADCALL |s| (SPADCALL Q (QREFELT $ 19))
                                      (QREFELT $ 34))))))))
               (#3# (|PRS;resultantEuclidean_naif| P Q $)))))))))) 

(SDEFUN |PRS;resultantEuclidean;2polRR;18|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |resultant| R))))
        (SPROG
         ((|s| (R)) (#1=#:G1055 NIL)
          (|l|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |resultant| R)))
          (|e| (|Integer|)) (|degQ| #2=(|NonNegativeInteger|)) (|degP| #2#)
          (|#G112| #2#) (|#G111| #2#))
         (SEQ
          (COND
           ((OR (SPADCALL P (QREFELT $ 31)) (SPADCALL Q (QREFELT $ 31)))
            (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                    (|spadConstant| $ 21)))
           ('T
            (SEQ
             (PROGN
              (LETT |#G111| (SPADCALL P (QREFELT $ 20)))
              (LETT |#G112| (SPADCALL Q (QREFELT $ 20)))
              (LETT |degP| |#G111|)
              (LETT |degQ| |#G112|))
             (EXIT
              (COND
               ((< |degP| |degQ|)
                (SEQ
                 (LETT |e|
                       (COND
                        ((ODDP |degP|) (COND ((ODDP |degQ|) -1) (#3='T 1)))
                        (#3# 1)))
                 (LETT |l|
                       (SPADCALL Q (SPADCALL |e| P (QREFELT $ 53))
                                 (QREFELT $ 55)))
                 (EXIT
                  (VECTOR (SPADCALL |e| (QVELT |l| 1) (QREFELT $ 53))
                          (QVELT |l| 0) (QVELT |l| 2)))))
               ((ZEROP |degQ|)
                (COND
                 ((ZEROP |degP|)
                  (|error| "resultantEuclidean$PRS : constant polynomials"))
                 (#3#
                  (SEQ
                   (LETT |s|
                         (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                   (PROG1 (LETT #1# (- |degP| 1))
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 33)))
                   (EXIT
                    (VECTOR (|spadConstant| $ 22) (SPADCALL |s| (QREFELT $ 12))
                            (SPADCALL |s| (SPADCALL Q (QREFELT $ 19))
                                      (QREFELT $ 34))))))))
               (#3# (|PRS;subResultantEuclidean| P Q $)))))))))) 

(SDEFUN |PRS;semiSubResultantEuclidean|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |resultant| R))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G118| (|Vector| |polR|)) (|#G117| #1#) (|ss| (R)) (#2=#:G1073 NIL)
          (|l| (|Vector| |polR|)) (|delta| (|NonNegativeInteger|))
          (#3=#:G1065 NIL) (|degQ| (|NonNegativeInteger|)) (|#G116| (|polR|))
          (|#G115| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1062 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |s|
                  (SPADCALL (SPADCALL Q (QREFELT $ 19))
                            (PROG1
                                (LETT #4#
                                      (- (SPADCALL P (QREFELT $ 20))
                                         (SPADCALL Q (QREFELT $ 20))))
                              (|check_subtype2| (>= #4# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #4#))
                            (QREFELT $ 33)))
            (LETT VP (VECTOR Q (|spadConstant| $ 35)))
            (LETT |pdiv|
                  (SPADCALL P (SPADCALL Q (QREFELT $ 39)) (QREFELT $ 52)))
            (LETT VQ (VECTOR (QVELT |pdiv| 2) (QVELT |pdiv| 1)))
            (EXIT
             (SEQ G190 NIL
                  (SEQ
                   (PROGN
                    (LETT |#G115| (SPADCALL VP 1 (QREFELT $ 43)))
                    (LETT |#G116| (SPADCALL VQ 1 (QREFELT $ 43)))
                    (LETT P |#G115|)
                    (LETT Q |#G116|))
                   (EXIT
                    (COND
                     ((SPADCALL Q (QREFELT $ 31))
                      (PROGN
                       (LETT #2#
                             (CONS (|spadConstant| $ 22)
                                   (|spadConstant| $ 21)))
                       (GO #5=#:G1072)))
                     ('T
                      (SEQ (LETT |degQ| (SPADCALL Q (QREFELT $ 20)))
                           (LETT |delta|
                                 (PROG1
                                     (LETT #3#
                                           (- (SPADCALL P (QREFELT $ 20))
                                              |degQ|))
                                   (|check_subtype2| (>= #3# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #3#)))
                           (COND
                            ((ZEROP |degQ|)
                             (SEQ
                              (LETT |l|
                                    (|PRS;Lazard3| VQ
                                     (SPADCALL Q (QREFELT $ 19)) |s| |delta|
                                     $))
                              (EXIT
                               (PROGN
                                (LETT #2#
                                      (CONS (SPADCALL |l| 2 (QREFELT $ 43))
                                            (SPADCALL
                                             (SPADCALL |l| 1 (QREFELT $ 43))
                                             (QREFELT $ 19))))
                                (GO #5#))))))
                           (LETT |ss|
                                 (SPADCALL (SPADCALL Q (QREFELT $ 19)) |s|
                                           |delta| (QREFELT $ 37)))
                           (PROGN
                            (LETT |#G117| VQ)
                            (LETT |#G118|
                                  (|PRS;next_sousResultant3| VP VQ |s| |ss| $))
                            (LETT VP |#G117|)
                            (LETT VQ |#G118|))
                           (EXIT (LETT |s| |ss|)))))))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |PRS;semiResultantEuclidean2;2polRR;20|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |resultant| R))))
        (SPROG
         ((|s| (R)) (#1=#:G1076 NIL) (|degQ| #2=(|NonNegativeInteger|))
          (|degP| #2#) (|#G122| #2#) (|#G121| #2#))
         (SEQ
          (COND
           ((OR (SPADCALL P (QREFELT $ 31)) (SPADCALL Q (QREFELT $ 31)))
            (CONS (|spadConstant| $ 22) (|spadConstant| $ 21)))
           ('T
            (SEQ
             (PROGN
              (LETT |#G121| (SPADCALL P (QREFELT $ 20)))
              (LETT |#G122| (SPADCALL Q (QREFELT $ 20)))
              (LETT |degP| |#G121|)
              (LETT |degQ| |#G122|))
             (EXIT
              (COND
               ((< |degP| |degQ|)
                (|error| "semiResultantEuclidean2 : bad degrees"))
               ((ZEROP |degQ|)
                (COND
                 ((ZEROP |degP|)
                  (|error| "semiResultantEuclidean2 : constant polynomials"))
                 (#3='T
                  (SEQ
                   (LETT |s|
                         (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                   (PROG1 (LETT #1# (- |degP| 1))
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 49)))
                   (EXIT
                    (CONS (SPADCALL |s| (QREFELT $ 12))
                          (SPADCALL |s| (SPADCALL Q (QREFELT $ 19))
                                    (QREFELT $ 34))))))))
               (#3# (|PRS;semiResultantEuclidean_naif| P Q $)))))))))) 

(SDEFUN |PRS;semiResultantEuclidean2;2polRR;21|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |resultant| R))))
        (SPROG
         ((|s| (R)) (#1=#:G1086 NIL) (|degQ| #2=(|NonNegativeInteger|))
          (|degP| #2#) (|#G126| #2#) (|#G125| #2#))
         (SEQ
          (COND
           ((OR (SPADCALL P (QREFELT $ 31)) (SPADCALL Q (QREFELT $ 31)))
            (CONS (|spadConstant| $ 22) (|spadConstant| $ 21)))
           ('T
            (SEQ
             (PROGN
              (LETT |#G125| (SPADCALL P (QREFELT $ 20)))
              (LETT |#G126| (SPADCALL Q (QREFELT $ 20)))
              (LETT |degP| |#G125|)
              (LETT |degQ| |#G126|))
             (EXIT
              (COND
               ((< |degP| |degQ|)
                (|error| "semiResultantEuclidean2 : bad degrees"))
               ((ZEROP |degQ|)
                (COND
                 ((ZEROP |degP|)
                  (|error| "semiResultantEuclidean2 : constant polynomials"))
                 (#3='T
                  (SEQ
                   (LETT |s|
                         (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                   (PROG1 (LETT #1# (- |degP| 1))
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 33)))
                   (EXIT
                    (CONS (SPADCALL |s| (QREFELT $ 12))
                          (SPADCALL |s| (SPADCALL Q (QREFELT $ 19))
                                    (QREFELT $ 34))))))))
               (#3# (|PRS;semiSubResultantEuclidean| P Q $)))))))))) 

(SDEFUN |PRS;semiResultantEuclidean1;2polRR;22|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef1| |polR|) (|:| |resultant| R))))
        (SPROG
         ((|result|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |resultant| R))))
         (SEQ (LETT |result| (SPADCALL P Q (QREFELT $ 55)))
              (EXIT (CONS (QVELT |result| 0) (QVELT |result| 2)))))) 

(SDEFUN |PRS;indiceSubResultant;2polRNnipolR;23|
        ((P (|polR|)) (Q (|polR|)) (|i| (|NonNegativeInteger|)) ($ (|polR|)))
        (SPROG
         ((|s| (R)) (|#G139| (|polR|)) (|#G138| (|polR|)) (#1=#:G1119 NIL)
          (Z (|polR|)) (#2=#:G1111 NIL) (|degQ| #3=(|NonNegativeInteger|))
          (|degP| #3#) (|#G137| #3#) (|#G136| #3#) (|#G135| (|polR|))
          (|#G134| (|polR|)) (#4=#:G1108 NIL) (#5=#:G1103 NIL)
          (|delta| (|NonNegativeInteger|)) (#6=#:G1101 NIL) (|#G133| (|polR|))
          (|#G132| (|polR|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (|spadConstant| $ 22))
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (PROGN
                  (LETT |#G132| Q)
                  (LETT |#G133| P)
                  (LETT P |#G132|)
                  (LETT Q |#G133|))
                 (EXIT
                  (COND
                   ((ODDP (- (SPADCALL P (QREFELT $ 20)) |i|))
                    (COND
                     ((ODDP (- (SPADCALL Q (QREFELT $ 20)) |i|))
                      (LETT Q (SPADCALL Q (QREFELT $ 39)))))))))))
              (COND
               ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (LETT |delta|
                       (PROG1
                           (LETT #6#
                                 (- (SPADCALL P (QREFELT $ 20))
                                    (SPADCALL Q (QREFELT $ 20))))
                         (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #6#)))
                 (EXIT
                  (COND
                   ((ZEROP |delta|)
                    (|error| "indiceSubResultant$PRS : bad degrees"))
                   (#7='T
                    (SEQ
                     (LETT |s|
                           (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                     (PROG1 (LETT #5# (- |delta| 1))
                                       (|check_subtype2| (>= #5# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #5#))
                                     (QREFELT $ 33)))
                     (EXIT
                      (PROGN
                       (LETT #1# (SPADCALL |s| Q (QREFELT $ 36)))
                       (GO #8=#:G1118))))))))))
              (EXIT
               (COND
                ((> |i| (SPADCALL Q (QREFELT $ 20))) (|spadConstant| $ 22))
                (#7#
                 (SEQ
                  (LETT |s|
                        (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                  (PROG1
                                      (LETT #4#
                                            (- (SPADCALL P (QREFELT $ 20))
                                               (SPADCALL Q (QREFELT $ 20))))
                                    (|check_subtype2| (>= #4# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #4#))
                                  (QREFELT $ 33)))
                  (PROGN
                   (LETT |#G134| Q)
                   (LETT |#G135|
                         (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                   (QREFELT $ 48)))
                   (LETT P |#G134|)
                   (LETT Q |#G135|))
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (PROGN
                          (LETT |#G136| (SPADCALL P (QREFELT $ 20)))
                          (LETT |#G137| (SPADCALL Q (QREFELT $ 20)))
                          (LETT |degP| |#G136|)
                          (LETT |degQ| |#G137|))
                         (EXIT
                          (COND
                           ((EQL |i| (- |degP| 1))
                            (PROGN (LETT #1# Q) (GO #8#)))
                           ((OR (SPADCALL Q (QREFELT $ 31)) (> |i| |degQ|))
                            (PROGN (LETT #1# (|spadConstant| $ 22)) (GO #8#)))
                           ('T
                            (SEQ
                             (LETT Z
                                   (SPADCALL Q (SPADCALL Q (QREFELT $ 19)) |s|
                                             (PROG1
                                                 (LETT #2# (- |degP| |degQ|))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (QREFELT $ 38)))
                             (EXIT
                              (COND
                               ((EQL |i| |degQ|) (PROGN (LETT #1# Z) (GO #8#)))
                               ('T
                                (SEQ
                                 (PROGN
                                  (LETT |#G138| Q)
                                  (LETT |#G139|
                                        (SPADCALL P Q Z |s| (QREFELT $ 41)))
                                  (LETT P |#G138|)
                                  (LETT Q |#G139|))
                                 (EXIT
                                  (LETT |s|
                                        (SPADCALL Z (QREFELT $ 19)))))))))))))
                        NIL (GO G190) G191 (EXIT NIL)))))))))))
          #8# (EXIT #1#)))) 

(SDEFUN |PRS;indiceSubResultantEuclidean;2polRNniR;24|
        ((P (|polR|)) (Q (|polR|)) (|i| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |subResultant| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G152| (|Vector| |polR|)) (|#G151| #1#) (|ss| (R)) (#2=#:G1146 NIL)
          (VZ (|Vector| |polR|)) (#3=#:G1137 NIL)
          (|degQ| #4=(|NonNegativeInteger|)) (|degP| #4#) (|#G150| #4#)
          (|#G149| #4#) (|#G148| (|polR|)) (|#G147| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#5=#:G1134 NIL) (#6=#:G1129 NIL) (|delta| (|NonNegativeInteger|))
          (#7=#:G1127 NIL)
          (|l|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |subResultant| |polR|)))
          (|e| (R)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                     (|spadConstant| $ 22)))
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (LETT |e|
                       (COND
                        ((ODDP (- (SPADCALL P (QREFELT $ 20)) |i|))
                         (COND
                          ((ODDP (- (SPADCALL Q (QREFELT $ 20)) |i|))
                           (SPADCALL (|spadConstant| $ 8) (QREFELT $ 32)))
                          (#8='T (|spadConstant| $ 8))))
                        (#8# (|spadConstant| $ 8))))
                 (LETT |l|
                       (SPADCALL Q (SPADCALL |e| P (QREFELT $ 36)) |i|
                                 (QREFELT $ 62)))
                 (EXIT
                  (PROGN
                   (LETT #2#
                         (VECTOR (SPADCALL |e| (QVELT |l| 1) (QREFELT $ 36))
                                 (QVELT |l| 0) (QVELT |l| 2)))
                   (GO #9=#:G1145))))))
              (COND
               ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (LETT |delta|
                       (PROG1
                           (LETT #7#
                                 (- (SPADCALL P (QREFELT $ 20))
                                    (SPADCALL Q (QREFELT $ 20))))
                         (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #7#)))
                 (EXIT
                  (COND
                   ((ZEROP |delta|)
                    (|error| "indiceSubResultantEuclidean$PRS : bad degrees"))
                   (#8#
                    (SEQ
                     (LETT |s|
                           (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                     (PROG1 (LETT #6# (- |delta| 1))
                                       (|check_subtype2| (>= #6# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #6#))
                                     (QREFELT $ 33)))
                     (EXIT
                      (PROGN
                       (LETT #2#
                             (VECTOR (|spadConstant| $ 22)
                                     (SPADCALL |s| (QREFELT $ 12))
                                     (SPADCALL |s| Q (QREFELT $ 36))))
                       (GO #9#))))))))))
              (EXIT
               (COND
                ((> |i| (SPADCALL Q (QREFELT $ 20)))
                 (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                         (|spadConstant| $ 22)))
                (#8#
                 (SEQ
                  (LETT |s|
                        (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                  (PROG1
                                      (LETT #5#
                                            (- (SPADCALL P (QREFELT $ 20))
                                               (SPADCALL Q (QREFELT $ 20))))
                                    (|check_subtype2| (>= #5# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #5#))
                                  (QREFELT $ 33)))
                  (LETT VP
                        (VECTOR Q (|spadConstant| $ 22) (|spadConstant| $ 35)))
                  (LETT |pdiv|
                        (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                  (QREFELT $ 52)))
                  (LETT VQ
                        (VECTOR (QVELT |pdiv| 2)
                                (SPADCALL (QVELT |pdiv| 0) (QREFELT $ 12))
                                (QVELT |pdiv| 1)))
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (PROGN
                          (LETT |#G147| (SPADCALL VP 1 (QREFELT $ 43)))
                          (LETT |#G148| (SPADCALL VQ 1 (QREFELT $ 43)))
                          (LETT P |#G147|)
                          (LETT Q |#G148|))
                         (EXIT
                          (COND
                           ((SPADCALL Q (QREFELT $ 31))
                            (PROGN
                             (LETT #2#
                                   (VECTOR (|spadConstant| $ 22)
                                           (|spadConstant| $ 22)
                                           (|spadConstant| $ 22)))
                             (GO #9#)))
                           ('T
                            (SEQ
                             (PROGN
                              (LETT |#G149| (SPADCALL P (QREFELT $ 20)))
                              (LETT |#G150| (SPADCALL Q (QREFELT $ 20)))
                              (LETT |degP| |#G149|)
                              (LETT |degQ| |#G150|))
                             (EXIT
                              (COND
                               ((EQL |i| (- |degP| 1))
                                (PROGN
                                 (LETT #2#
                                       (VECTOR (SPADCALL VQ 2 (QREFELT $ 43))
                                               (SPADCALL VQ 3 (QREFELT $ 43))
                                               (SPADCALL VQ 1 (QREFELT $ 43))))
                                 (GO #9#)))
                               ((> |i| |degQ|)
                                (PROGN
                                 (LETT #2#
                                       (VECTOR (|spadConstant| $ 22)
                                               (|spadConstant| $ 22)
                                               (|spadConstant| $ 22)))
                                 (GO #9#)))
                               ('T
                                (SEQ
                                 (LETT VZ
                                       (|PRS;Lazard3| VQ
                                        (SPADCALL Q (QREFELT $ 19)) |s|
                                        (PROG1 (LETT #3# (- |degP| |degQ|))
                                          (|check_subtype2| (>= #3# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #3#))
                                        $))
                                 (EXIT
                                  (COND
                                   ((EQL |i| |degQ|)
                                    (PROGN
                                     (LETT #2#
                                           (VECTOR
                                            (SPADCALL VZ 2 (QREFELT $ 43))
                                            (SPADCALL VZ 3 (QREFELT $ 43))
                                            (SPADCALL VZ 1 (QREFELT $ 43))))
                                     (GO #9#)))
                                   ('T
                                    (SEQ
                                     (LETT |ss|
                                           (SPADCALL
                                            (SPADCALL VZ 1 (QREFELT $ 43))
                                            (QREFELT $ 19)))
                                     (PROGN
                                      (LETT |#G151| VQ)
                                      (LETT |#G152|
                                            (|PRS;next_sousResultant3| VP VQ
                                             |s| |ss| $))
                                      (LETT VP |#G151|)
                                      (LETT VQ |#G152|))
                                     (EXIT (LETT |s| |ss|)))))))))))))))
                        NIL (GO G190) G191 (EXIT NIL)))))))))))
          #9# (EXIT #2#)))) 

(SDEFUN |PRS;semiIndiceSubResultantEuclidean;2polRNniR;25|
        ((P (|polR|)) (Q (|polR|)) (|i| (|NonNegativeInteger|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |subResultant| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G161| (|Vector| |polR|)) (|#G160| #1#) (|ss| (R)) (#2=#:G1171 NIL)
          (VZ (|Vector| |polR|)) (#3=#:G1160 NIL)
          (|degQ| #4=(|NonNegativeInteger|)) (|degP| #4#) (|#G159| #4#)
          (|#G158| #4#) (|#G157| (|polR|)) (|#G156| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#5=#:G1157 NIL) (#6=#:G1152 NIL) (|delta| (|NonNegativeInteger|))
          (#7=#:G1150 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (CONS (|spadConstant| $ 22) (|spadConstant| $ 22)))
            ('T
             (COND
              ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
               (|error| "semiIndiceSubResultantEuclidean$PRS : bad degrees"))
              (#8='T
               (SEQ
                (COND
                 ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                  (SEQ
                   (LETT |delta|
                         (PROG1
                             (LETT #7#
                                   (- (SPADCALL P (QREFELT $ 20))
                                      (SPADCALL Q (QREFELT $ 20))))
                           (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #7#)))
                   (EXIT
                    (COND
                     ((ZEROP |delta|)
                      (|error|
                       "semiIndiceSubResultantEuclidean$PRS : bad degrees"))
                     (#8#
                      (SEQ
                       (LETT |s|
                             (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                       (PROG1 (LETT #6# (- |delta| 1))
                                         (|check_subtype2| (>= #6# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #6#))
                                       (QREFELT $ 33)))
                       (EXIT
                        (PROGN
                         (LETT #2#
                               (CONS (SPADCALL |s| (QREFELT $ 12))
                                     (SPADCALL |s| Q (QREFELT $ 36))))
                         (GO #9=#:G1170))))))))))
                (EXIT
                 (COND
                  ((> |i| (SPADCALL Q (QREFELT $ 20)))
                   (CONS (|spadConstant| $ 22) (|spadConstant| $ 22)))
                  (#8#
                   (SEQ
                    (LETT |s|
                          (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                    (PROG1
                                        (LETT #5#
                                              (- (SPADCALL P (QREFELT $ 20))
                                                 (SPADCALL Q (QREFELT $ 20))))
                                      (|check_subtype2| (>= #5# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #5#))
                                    (QREFELT $ 33)))
                    (LETT VP (VECTOR Q (|spadConstant| $ 35)))
                    (LETT |pdiv|
                          (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                    (QREFELT $ 52)))
                    (LETT VQ (VECTOR (QVELT |pdiv| 2) (QVELT |pdiv| 1)))
                    (EXIT
                     (SEQ G190 NIL
                          (SEQ
                           (PROGN
                            (LETT |#G156| (SPADCALL VP 1 (QREFELT $ 43)))
                            (LETT |#G157| (SPADCALL VQ 1 (QREFELT $ 43)))
                            (LETT P |#G156|)
                            (LETT Q |#G157|))
                           (EXIT
                            (COND
                             ((SPADCALL Q (QREFELT $ 31))
                              (PROGN
                               (LETT #2#
                                     (CONS (|spadConstant| $ 22)
                                           (|spadConstant| $ 22)))
                               (GO #9#)))
                             ('T
                              (SEQ
                               (PROGN
                                (LETT |#G158| (SPADCALL P (QREFELT $ 20)))
                                (LETT |#G159| (SPADCALL Q (QREFELT $ 20)))
                                (LETT |degP| |#G158|)
                                (LETT |degQ| |#G159|))
                               (EXIT
                                (COND
                                 ((EQL |i| (- |degP| 1))
                                  (PROGN
                                   (LETT #2#
                                         (CONS (SPADCALL VQ 2 (QREFELT $ 43))
                                               (SPADCALL VQ 1 (QREFELT $ 43))))
                                   (GO #9#)))
                                 ((> |i| |degQ|)
                                  (PROGN
                                   (LETT #2#
                                         (CONS (|spadConstant| $ 22)
                                               (|spadConstant| $ 22)))
                                   (GO #9#)))
                                 ('T
                                  (SEQ
                                   (LETT VZ
                                         (|PRS;Lazard3| VQ
                                          (SPADCALL Q (QREFELT $ 19)) |s|
                                          (PROG1 (LETT #3# (- |degP| |degQ|))
                                            (|check_subtype2| (>= #3# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #3#))
                                          $))
                                   (EXIT
                                    (COND
                                     ((EQL |i| |degQ|)
                                      (PROGN
                                       (LETT #2#
                                             (CONS
                                              (SPADCALL VZ 2 (QREFELT $ 43))
                                              (SPADCALL VZ 1 (QREFELT $ 43))))
                                       (GO #9#)))
                                     ('T
                                      (SEQ
                                       (LETT |ss|
                                             (SPADCALL
                                              (SPADCALL VZ 1 (QREFELT $ 43))
                                              (QREFELT $ 19)))
                                       (PROGN
                                        (LETT |#G160| VQ)
                                        (LETT |#G161|
                                              (|PRS;next_sousResultant3| VP VQ
                                               |s| |ss| $))
                                        (LETT VP |#G160|)
                                        (LETT VQ |#G161|))
                                       (EXIT (LETT |s| |ss|)))))))))))))))
                          NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #9# (EXIT #2#)))) 

(SDEFUN |PRS;degreeSubResultant;2polRNnipolR;26|
        ((P (|polR|)) (Q (|polR|)) (|i| (|NonNegativeInteger|)) ($ (|polR|)))
        (SPROG
         ((|s| (R)) (|#G174| (|polR|)) (|#G173| (|polR|)) (Z (|polR|))
          (#1=#:G1186 NIL) (#2=#:G1193 NIL) (|#G172| (|polR|))
          (|#G171| (|polR|)) (#3=#:G1182 NIL) (#4=#:G1177 NIL)
          (|delta| (|NonNegativeInteger|)) (#5=#:G1175 NIL) (|#G170| (|polR|))
          (|#G169| (|polR|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (|spadConstant| $ 22))
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (PROGN
                 (LETT |#G169| Q)
                 (LETT |#G170| P)
                 (LETT P |#G169|)
                 (LETT Q |#G170|))))
              (COND
               ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (LETT |delta|
                       (PROG1
                           (LETT #5#
                                 (- (SPADCALL P (QREFELT $ 20))
                                    (SPADCALL Q (QREFELT $ 20))))
                         (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #5#)))
                 (EXIT
                  (COND
                   ((ZEROP |delta|)
                    (|error| "degreeSubResultant$PRS : bad degrees"))
                   (#6='T
                    (SEQ
                     (LETT |s|
                           (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                     (PROG1 (LETT #4# (- |delta| 1))
                                       (|check_subtype2| (>= #4# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #4#))
                                     (QREFELT $ 33)))
                     (EXIT
                      (PROGN
                       (LETT #2# (SPADCALL |s| Q (QREFELT $ 36)))
                       (GO #7=#:G1192))))))))))
              (EXIT
               (COND
                ((> |i| (SPADCALL Q (QREFELT $ 20))) (|spadConstant| $ 22))
                (#6#
                 (SEQ
                  (LETT |s|
                        (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                  (PROG1
                                      (LETT #3#
                                            (- (SPADCALL P (QREFELT $ 20))
                                               (SPADCALL Q (QREFELT $ 20))))
                                    (|check_subtype2| (>= #3# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #3#))
                                  (QREFELT $ 33)))
                  (PROGN
                   (LETT |#G171| Q)
                   (LETT |#G172|
                         (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                   (QREFELT $ 48)))
                   (LETT P |#G171|)
                   (LETT Q |#G172|))
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (EXIT
                          (COND
                           ((OR (SPADCALL Q (QREFELT $ 31))
                                (> |i| (SPADCALL Q (QREFELT $ 20))))
                            (PROGN (LETT #2# (|spadConstant| $ 22)) (GO #7#)))
                           ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                            (PROGN (LETT #2# Q) (GO #7#)))
                           ('T
                            (SEQ
                             (LETT Z
                                   (SPADCALL Q (SPADCALL Q (QREFELT $ 19)) |s|
                                             (PROG1
                                                 (LETT #1#
                                                       (-
                                                        (SPADCALL P
                                                                  (QREFELT $
                                                                           20))
                                                        (SPADCALL Q
                                                                  (QREFELT $
                                                                           20))))
                                               (|check_subtype2| (>= #1# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #1#))
                                             (QREFELT $ 38)))
                             (PROGN
                              (LETT |#G173| Q)
                              (LETT |#G174|
                                    (SPADCALL P Q Z |s| (QREFELT $ 41)))
                              (LETT P |#G173|)
                              (LETT Q |#G174|))
                             (EXIT (LETT |s| (SPADCALL Z (QREFELT $ 19)))))))))
                        NIL (GO G190) G191 (EXIT NIL)))))))))))
          #7# (EXIT #2#)))) 

(SDEFUN |PRS;degreeSubResultantEuclidean;2polRNniR;27|
        ((P (|polR|)) (Q (|polR|)) (|i| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |subResultant| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G184| (|Vector| |polR|)) (|#G183| #1#) (|ss| (R)) (#2=#:G1211 NIL)
          (#3=#:G1218 NIL) (|#G182| (|polR|)) (|#G181| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1206 NIL) (#5=#:G1201 NIL) (|delta| (|NonNegativeInteger|))
          (#6=#:G1199 NIL)
          (|l|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |subResultant| |polR|))))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                     (|spadConstant| $ 22)))
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (SEQ (LETT |l| (SPADCALL Q P |i| (QREFELT $ 66)))
                     (EXIT
                      (PROGN
                       (LETT #3#
                             (VECTOR (QVELT |l| 1) (QVELT |l| 0)
                                     (QVELT |l| 2)))
                       (GO #7=#:G1217))))))
              (COND
               ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (LETT |delta|
                       (PROG1
                           (LETT #6#
                                 (- (SPADCALL P (QREFELT $ 20))
                                    (SPADCALL Q (QREFELT $ 20))))
                         (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #6#)))
                 (EXIT
                  (COND
                   ((ZEROP |delta|)
                    (|error| "degreeSubResultantEuclidean$PRS : bad degrees"))
                   (#8='T
                    (SEQ
                     (LETT |s|
                           (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                     (PROG1 (LETT #5# (- |delta| 1))
                                       (|check_subtype2| (>= #5# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #5#))
                                     (QREFELT $ 33)))
                     (EXIT
                      (PROGN
                       (LETT #3#
                             (VECTOR (|spadConstant| $ 22)
                                     (SPADCALL |s| (QREFELT $ 12))
                                     (SPADCALL |s| Q (QREFELT $ 36))))
                       (GO #7#))))))))))
              (EXIT
               (COND
                ((> |i| (SPADCALL Q (QREFELT $ 20)))
                 (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                         (|spadConstant| $ 22)))
                (#8#
                 (SEQ
                  (LETT |s|
                        (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                  (PROG1
                                      (LETT #4#
                                            (- (SPADCALL P (QREFELT $ 20))
                                               (SPADCALL Q (QREFELT $ 20))))
                                    (|check_subtype2| (>= #4# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #4#))
                                  (QREFELT $ 33)))
                  (LETT VP
                        (VECTOR Q (|spadConstant| $ 22) (|spadConstant| $ 35)))
                  (LETT |pdiv|
                        (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                  (QREFELT $ 52)))
                  (LETT VQ
                        (VECTOR (QVELT |pdiv| 2)
                                (SPADCALL (QVELT |pdiv| 0) (QREFELT $ 12))
                                (QVELT |pdiv| 1)))
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (PROGN
                          (LETT |#G181| (SPADCALL VP 1 (QREFELT $ 43)))
                          (LETT |#G182| (SPADCALL VQ 1 (QREFELT $ 43)))
                          (LETT P |#G181|)
                          (LETT Q |#G182|))
                         (COND
                          ((OR (SPADCALL Q (QREFELT $ 31))
                               (> |i| (SPADCALL Q (QREFELT $ 20))))
                           (EXIT
                            (PROGN
                             (LETT #3#
                                   (VECTOR (|spadConstant| $ 22)
                                           (|spadConstant| $ 22)
                                           (|spadConstant| $ 22)))
                             (GO #7#)))))
                         (EXIT
                          (COND
                           ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                            (PROGN
                             (LETT #3#
                                   (VECTOR (SPADCALL VQ 2 (QREFELT $ 43))
                                           (SPADCALL VQ 3 (QREFELT $ 43))
                                           (SPADCALL VQ 1 (QREFELT $ 43))))
                             (GO #7#)))
                           ('T
                            (SEQ
                             (LETT |ss|
                                   (SPADCALL (SPADCALL Q (QREFELT $ 19)) |s|
                                             (PROG1
                                                 (LETT #2#
                                                       (-
                                                        (SPADCALL P
                                                                  (QREFELT $
                                                                           20))
                                                        (SPADCALL Q
                                                                  (QREFELT $
                                                                           20))))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (QREFELT $ 37)))
                             (PROGN
                              (LETT |#G183| VQ)
                              (LETT |#G184|
                                    (|PRS;next_sousResultant3| VP VQ |s| |ss|
                                     $))
                              (LETT VP |#G183|)
                              (LETT VQ |#G184|))
                             (EXIT (LETT |s| |ss|)))))))
                        NIL (GO G190) G191 (EXIT NIL)))))))))))
          #7# (EXIT #3#)))) 

(SDEFUN |PRS;semiDegreeSubResultantEuclidean;2polRNniR;28|
        ((P (|polR|)) (Q (|polR|)) (|i| (|NonNegativeInteger|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |subResultant| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G191| (|Vector| |polR|)) (|#G190| #1#) (|ss| (R)) (#2=#:G1234 NIL)
          (#3=#:G1242 NIL) (|#G189| (|polR|)) (|#G188| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1229 NIL) (#5=#:G1224 NIL) (|delta| (|NonNegativeInteger|))
          (#6=#:G1222 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (CONS (|spadConstant| $ 22) (|spadConstant| $ 22)))
            ('T
             (COND
              ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
               (|error| "semiDegreeSubResultantEuclidean$PRS : bad degrees"))
              (#7='T
               (SEQ
                (COND
                 ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                  (SEQ
                   (LETT |delta|
                         (PROG1
                             (LETT #6#
                                   (- (SPADCALL P (QREFELT $ 20))
                                      (SPADCALL Q (QREFELT $ 20))))
                           (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #6#)))
                   (EXIT
                    (COND
                     ((ZEROP |delta|)
                      (|error|
                       "semiDegreeSubResultantEuclidean$PRS : bad degrees"))
                     (#7#
                      (SEQ
                       (LETT |s|
                             (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                       (PROG1 (LETT #5# (- |delta| 1))
                                         (|check_subtype2| (>= #5# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #5#))
                                       (QREFELT $ 33)))
                       (EXIT
                        (PROGN
                         (LETT #3#
                               (CONS (SPADCALL |s| (QREFELT $ 12))
                                     (SPADCALL |s| Q (QREFELT $ 36))))
                         (GO #8=#:G1241))))))))))
                (EXIT
                 (COND
                  ((> |i| (SPADCALL Q (QREFELT $ 20)))
                   (CONS (|spadConstant| $ 22) (|spadConstant| $ 22)))
                  (#7#
                   (SEQ
                    (LETT |s|
                          (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                    (PROG1
                                        (LETT #4#
                                              (- (SPADCALL P (QREFELT $ 20))
                                                 (SPADCALL Q (QREFELT $ 20))))
                                      (|check_subtype2| (>= #4# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #4#))
                                    (QREFELT $ 33)))
                    (LETT VP (VECTOR Q (|spadConstant| $ 35)))
                    (LETT |pdiv|
                          (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                    (QREFELT $ 52)))
                    (LETT VQ (VECTOR (QVELT |pdiv| 2) (QVELT |pdiv| 1)))
                    (EXIT
                     (SEQ G190 NIL
                          (SEQ
                           (PROGN
                            (LETT |#G188| (SPADCALL VP 1 (QREFELT $ 43)))
                            (LETT |#G189| (SPADCALL VQ 1 (QREFELT $ 43)))
                            (LETT P |#G188|)
                            (LETT Q |#G189|))
                           (COND
                            ((OR (SPADCALL Q (QREFELT $ 31))
                                 (> |i| (SPADCALL Q (QREFELT $ 20))))
                             (EXIT
                              (PROGN
                               (LETT #3#
                                     (CONS (|spadConstant| $ 22)
                                           (|spadConstant| $ 22)))
                               (GO #8#)))))
                           (EXIT
                            (COND
                             ((EQL |i| (SPADCALL Q (QREFELT $ 20)))
                              (PROGN
                               (LETT #3#
                                     (CONS (SPADCALL VQ 2 (QREFELT $ 43))
                                           (SPADCALL VQ 1 (QREFELT $ 43))))
                               (GO #8#)))
                             ('T
                              (SEQ
                               (LETT |ss|
                                     (SPADCALL (SPADCALL Q (QREFELT $ 19)) |s|
                                               (PROG1
                                                   (LETT #2#
                                                         (-
                                                          (SPADCALL P
                                                                    (QREFELT $
                                                                             20))
                                                          (SPADCALL Q
                                                                    (QREFELT $
                                                                             20))))
                                                 (|check_subtype2| (>= #2# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #2#))
                                               (QREFELT $ 37)))
                               (PROGN
                                (LETT |#G190| VQ)
                                (LETT |#G191|
                                      (|PRS;next_sousResultant3| VP VQ |s| |ss|
                                       $))
                                (LETT VP |#G190|)
                                (LETT VQ |#G191|))
                               (EXIT (LETT |s| |ss|)))))))
                          NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #8# (EXIT #3#)))) 

(SDEFUN |PRS;lastSubResultant;3polR;29|
        ((P (|polR|)) (Q (|polR|)) ($ (|polR|)))
        (SPROG
         ((|s| (R)) (|#G202| (|polR|)) (|#G201| (|polR|)) (#1=#:G1257 NIL)
          (Z (|polR|)) (#2=#:G1249 NIL) (|#G200| (|polR|)) (|#G199| (|polR|))
          (#3=#:G1247 NIL) (|#G198| (|polR|)) (|#G197| (|polR|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (|spadConstant| $ 22))
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (PROGN
                 (LETT |#G197| Q)
                 (LETT |#G198| P)
                 (LETT P |#G197|)
                 (LETT Q |#G198|))))
              (EXIT
               (COND
                ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                 (SPADCALL
                  (SPADCALL (SPADCALL Q (QREFELT $ 19))
                            (SPADCALL P (QREFELT $ 20)) (QREFELT $ 33))
                  (QREFELT $ 12)))
                ('T
                 (SEQ
                  (LETT |s|
                        (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                  (PROG1
                                      (LETT #3#
                                            (- (SPADCALL P (QREFELT $ 20))
                                               (SPADCALL Q (QREFELT $ 20))))
                                    (|check_subtype2| (>= #3# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #3#))
                                  (QREFELT $ 33)))
                  (PROGN
                   (LETT |#G199| Q)
                   (LETT |#G200|
                         (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                   (QREFELT $ 48)))
                   (LETT P |#G199|)
                   (LETT Q |#G200|))
                  (LETT Z P)
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL Q (QREFELT $ 31))
                            (PROGN (LETT #1# Z) (GO #4=#:G1256)))
                           ('T
                            (SEQ
                             (LETT Z
                                   (SPADCALL Q (SPADCALL Q (QREFELT $ 19)) |s|
                                             (PROG1
                                                 (LETT #2#
                                                       (-
                                                        (SPADCALL P
                                                                  (QREFELT $
                                                                           20))
                                                        (SPADCALL Q
                                                                  (QREFELT $
                                                                           20))))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (QREFELT $ 38)))
                             (EXIT
                              (COND
                               ((ZEROP (SPADCALL Z (QREFELT $ 20)))
                                (PROGN (LETT #1# Z) (GO #4#)))
                               ('T
                                (SEQ
                                 (PROGN
                                  (LETT |#G201| Q)
                                  (LETT |#G202|
                                        (SPADCALL P Q Z |s| (QREFELT $ 41)))
                                  (LETT P |#G201|)
                                  (LETT Q |#G202|))
                                 (EXIT
                                  (LETT |s|
                                        (SPADCALL Z (QREFELT $ 19)))))))))))))
                        NIL (GO G190) G191 (EXIT NIL)))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRS;lastSubResultantEuclidean;2polRR;30|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |subResultant| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G208| (|Vector| |polR|)) (|#G207| #1#) (|ss| (R)) (#2=#:G1279 NIL)
          (VZ (|Vector| |polR|)) (#3=#:G1272 NIL) (Z (|polR|))
          (|#G206| (|polR|)) (|#G205| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1269 NIL) (#5=#:G1264 NIL) (|degP| (|NonNegativeInteger|))
          (|l|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |subResultant| |polR|))))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                     (|spadConstant| $ 22)))
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (SEQ (LETT |l| (SPADCALL Q P (QREFELT $ 69)))
                     (EXIT
                      (PROGN
                       (LETT #2#
                             (VECTOR (QVELT |l| 1) (QVELT |l| 0)
                                     (QVELT |l| 2)))
                       (GO #6=#:G1278))))))
              (COND
               ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                (SEQ (LETT |degP| (SPADCALL P (QREFELT $ 20)))
                     (EXIT
                      (COND
                       ((ZEROP |degP|)
                        (|error|
                         "lastSubResultantEuclidean$PRS : constant polynomials"))
                       ('T
                        (SEQ
                         (LETT |s|
                               (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                         (PROG1 (LETT #5# (- |degP| 1))
                                           (|check_subtype2| (>= #5# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #5#))
                                         (QREFELT $ 33)))
                         (EXIT
                          (PROGN
                           (LETT #2#
                                 (VECTOR (|spadConstant| $ 22)
                                         (SPADCALL |s| (QREFELT $ 12))
                                         (SPADCALL |s| Q (QREFELT $ 36))))
                           (GO #6#))))))))))
              (LETT |s|
                    (SPADCALL (SPADCALL Q (QREFELT $ 19))
                              (PROG1
                                  (LETT #4#
                                        (- (SPADCALL P (QREFELT $ 20))
                                           (SPADCALL Q (QREFELT $ 20))))
                                (|check_subtype2| (>= #4# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #4#))
                              (QREFELT $ 33)))
              (LETT VP (VECTOR Q (|spadConstant| $ 22) (|spadConstant| $ 35)))
              (LETT |pdiv|
                    (SPADCALL P (SPADCALL Q (QREFELT $ 39)) (QREFELT $ 52)))
              (LETT VQ
                    (VECTOR (QVELT |pdiv| 2)
                            (SPADCALL (QVELT |pdiv| 0) (QREFELT $ 12))
                            (QVELT |pdiv| 1)))
              (LETT VZ (SPADCALL VP (QREFELT $ 70)))
              (EXIT
               (SEQ G190 NIL
                    (SEQ
                     (PROGN
                      (LETT |#G205| (SPADCALL VQ 1 (QREFELT $ 43)))
                      (LETT |#G206| (SPADCALL VZ 1 (QREFELT $ 43)))
                      (LETT Q |#G205|)
                      (LETT Z |#G206|))
                     (EXIT
                      (COND
                       ((SPADCALL Q (QREFELT $ 31))
                        (PROGN
                         (LETT #2#
                               (VECTOR (SPADCALL VZ 2 (QREFELT $ 43))
                                       (SPADCALL VZ 3 (QREFELT $ 43))
                                       (SPADCALL VZ 1 (QREFELT $ 43))))
                         (GO #6#)))
                       ('T
                        (SEQ
                         (LETT VZ
                               (|PRS;Lazard3| VQ (SPADCALL Q (QREFELT $ 19))
                                |s|
                                (PROG1
                                    (LETT #3#
                                          (- (SPADCALL Z (QREFELT $ 20))
                                             (SPADCALL Q (QREFELT $ 20))))
                                  (|check_subtype2| (>= #3# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #3#))
                                $))
                         (EXIT
                          (COND
                           ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                            (PROGN
                             (LETT #2#
                                   (VECTOR (SPADCALL VZ 2 (QREFELT $ 43))
                                           (SPADCALL VZ 3 (QREFELT $ 43))
                                           (SPADCALL VZ 1 (QREFELT $ 43))))
                             (GO #6#)))
                           ('T
                            (SEQ
                             (LETT |ss|
                                   (SPADCALL (SPADCALL VZ 1 (QREFELT $ 43))
                                             (QREFELT $ 19)))
                             (PROGN
                              (LETT |#G207| VQ)
                              (LETT |#G208|
                                    (|PRS;next_sousResultant3| VP VQ |s| |ss|
                                     $))
                              (LETT VP |#G207|)
                              (LETT VQ |#G208|))
                             (EXIT (LETT |s| |ss|)))))))))))
                    NIL (GO G190) G191 (EXIT NIL)))))))
          #6# (EXIT #2#)))) 

(SDEFUN |PRS;semiLastSubResultantEuclidean;2polRR;31|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |subResultant| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G214| (|Vector| |polR|)) (|#G213| #1#) (|ss| (R)) (#2=#:G1300 NIL)
          (VZ (|Vector| |polR|)) (#3=#:G1292 NIL) (Z (|polR|))
          (|#G212| (|polR|)) (|#G211| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1289 NIL) (#5=#:G1284 NIL) (|degP| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31)))
             (CONS (|spadConstant| $ 22) (|spadConstant| $ 22)))
            ('T
             (COND
              ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
               (|error| "semiLastSubResultantEuclidean$PRS : bad degrees"))
              (#6='T
               (SEQ
                (COND
                 ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                  (SEQ (LETT |degP| (SPADCALL P (QREFELT $ 20)))
                       (EXIT
                        (COND
                         ((ZEROP |degP|)
                          (|error|
                           "semiLastSubResultantEuclidean$PRS : constant polynomials"))
                         (#6#
                          (SEQ
                           (LETT |s|
                                 (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                           (PROG1 (LETT #5# (- |degP| 1))
                                             (|check_subtype2| (>= #5# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #5#))
                                           (QREFELT $ 33)))
                           (EXIT
                            (PROGN
                             (LETT #2#
                                   (CONS (SPADCALL |s| (QREFELT $ 12))
                                         (SPADCALL |s| Q (QREFELT $ 36))))
                             (GO #7=#:G1299))))))))))
                (LETT |s|
                      (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                (PROG1
                                    (LETT #4#
                                          (- (SPADCALL P (QREFELT $ 20))
                                             (SPADCALL Q (QREFELT $ 20))))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#))
                                (QREFELT $ 33)))
                (LETT VP (VECTOR Q (|spadConstant| $ 35)))
                (LETT |pdiv|
                      (SPADCALL P (SPADCALL Q (QREFELT $ 39)) (QREFELT $ 52)))
                (LETT VQ (VECTOR (QVELT |pdiv| 2) (QVELT |pdiv| 1)))
                (LETT VZ (SPADCALL VP (QREFELT $ 70)))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (PROGN
                        (LETT |#G211| (SPADCALL VQ 1 (QREFELT $ 43)))
                        (LETT |#G212| (SPADCALL VZ 1 (QREFELT $ 43)))
                        (LETT Q |#G211|)
                        (LETT Z |#G212|))
                       (EXIT
                        (COND
                         ((SPADCALL Q (QREFELT $ 31))
                          (PROGN
                           (LETT #2#
                                 (CONS (SPADCALL VZ 2 (QREFELT $ 43))
                                       (SPADCALL VZ 1 (QREFELT $ 43))))
                           (GO #7#)))
                         ('T
                          (SEQ
                           (LETT VZ
                                 (|PRS;Lazard3| VQ (SPADCALL Q (QREFELT $ 19))
                                  |s|
                                  (PROG1
                                      (LETT #3#
                                            (- (SPADCALL Z (QREFELT $ 20))
                                               (SPADCALL Q (QREFELT $ 20))))
                                    (|check_subtype2| (>= #3# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #3#))
                                  $))
                           (EXIT
                            (COND
                             ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                              (PROGN
                               (LETT #2#
                                     (CONS (SPADCALL VZ 2 (QREFELT $ 43))
                                           (SPADCALL VZ 1 (QREFELT $ 43))))
                               (GO #7#)))
                             ('T
                              (SEQ
                               (LETT |ss|
                                     (SPADCALL (SPADCALL VZ 1 (QREFELT $ 43))
                                               (QREFELT $ 19)))
                               (PROGN
                                (LETT |#G213| VQ)
                                (LETT |#G214|
                                      (|PRS;next_sousResultant3| VP VQ |s| |ss|
                                       $))
                                (LETT VP |#G213|)
                                (LETT VQ |#G214|))
                               (EXIT (LETT |s| |ss|)))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))))))
          #7# (EXIT #2#)))) 

(SDEFUN |PRS;chainSubResultants;2polRL;32|
        ((P (|polR|)) (Q (|polR|)) ($ (|List| |polR|)))
        (SPROG
         ((|s| (R)) (|#G224| (|polR|)) (|#G223| (|polR|)) (#1=#:G1321 NIL)
          (L (|List| |polR|)) (Z (|polR|)) (|delta| (|NonNegativeInteger|))
          (#2=#:G1313 NIL) (|#G222| (|polR|)) (|#G221| (|polR|))
          (#3=#:G1311 NIL) (|#G220| (|polR|)) (|#G219| (|polR|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31))) NIL)
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (SEQ
                 (PROGN
                  (LETT |#G219| Q)
                  (LETT |#G220| P)
                  (LETT P |#G219|)
                  (LETT Q |#G220|))
                 (EXIT
                  (COND
                   ((ODDP (SPADCALL P (QREFELT $ 20)))
                    (COND
                     ((ODDP (SPADCALL Q (QREFELT $ 20)))
                      (LETT Q (SPADCALL Q (QREFELT $ 39)))))))))))
              (LETT L NIL)
              (EXIT
               (COND ((ZEROP (SPADCALL Q (QREFELT $ 20))) L)
                     ('T
                      (SEQ (LETT L (LIST Q))
                           (LETT |s|
                                 (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                           (PROG1
                                               (LETT #3#
                                                     (-
                                                      (SPADCALL P
                                                                (QREFELT $ 20))
                                                      (SPADCALL Q
                                                                (QREFELT $
                                                                         20))))
                                             (|check_subtype2| (>= #3# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #3#))
                                           (QREFELT $ 33)))
                           (PROGN
                            (LETT |#G221| Q)
                            (LETT |#G222|
                                  (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                            (QREFELT $ 48)))
                            (LETT P |#G221|)
                            (LETT Q |#G222|))
                           (EXIT
                            (SEQ G190 NIL
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL Q (QREFELT $ 31))
                                     (PROGN (LETT #1# L) (GO #4=#:G1320)))
                                    ('T
                                     (SEQ (LETT L (CONS Q L))
                                          (LETT |delta|
                                                (PROG1
                                                    (LETT #2#
                                                          (-
                                                           (SPADCALL P
                                                                     (QREFELT $
                                                                              20))
                                                           (SPADCALL Q
                                                                     (QREFELT $
                                                                              20))))
                                                  (|check_subtype2| (>= #2# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #2#)))
                                          (LETT Z
                                                (SPADCALL Q
                                                          (SPADCALL Q
                                                                    (QREFELT $
                                                                             19))
                                                          |s| |delta|
                                                          (QREFELT $ 38)))
                                          (COND
                                           ((> |delta| 1) (LETT L (CONS Z L))))
                                          (EXIT
                                           (COND
                                            ((ZEROP
                                              (SPADCALL Z (QREFELT $ 20)))
                                             (PROGN (LETT #1# L) (GO #4#)))
                                            ('T
                                             (SEQ
                                              (PROGN
                                               (LETT |#G223| Q)
                                               (LETT |#G224|
                                                     (SPADCALL P Q Z |s|
                                                               (QREFELT $ 41)))
                                               (LETT P |#G223|)
                                               (LETT Q |#G224|))
                                              (EXIT
                                               (LETT |s|
                                                     (SPADCALL Z
                                                               (QREFELT $
                                                                        19)))))))))))))
                                 NIL (GO G190) G191 (EXIT NIL)))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRS;schema;2polRL;33|
        ((P (|polR|)) (Q (|polR|)) ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|s| (R)) (|#G232| (|polR|)) (|#G231| (|polR|)) (#1=#:G1336 NIL)
          (L (|List| (|NonNegativeInteger|))) (Z (|polR|))
          (|delta| (|NonNegativeInteger|)) (#2=#:G1328 NIL)
          (|e| (|NonNegativeInteger|)) (|#G230| (|polR|)) (|#G229| (|polR|))
          (#3=#:G1326 NIL) (|#G228| (|polR|)) (|#G227| (|polR|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL Q (QREFELT $ 31)) (SPADCALL P (QREFELT $ 31))) NIL)
            ('T
             (SEQ
              (COND
               ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                (PROGN
                 (LETT |#G227| Q)
                 (LETT |#G228| P)
                 (LETT P |#G227|)
                 (LETT Q |#G228|))))
              (EXIT
               (COND ((ZEROP (SPADCALL Q (QREFELT $ 20))) (LIST 0))
                     ('T
                      (SEQ (LETT L NIL)
                           (LETT |s|
                                 (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                           (PROG1
                                               (LETT #3#
                                                     (-
                                                      (SPADCALL P
                                                                (QREFELT $ 20))
                                                      (SPADCALL Q
                                                                (QREFELT $
                                                                         20))))
                                             (|check_subtype2| (>= #3# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #3#))
                                           (QREFELT $ 33)))
                           (PROGN
                            (LETT |#G229| Q)
                            (LETT |#G230| (SPADCALL P Q (QREFELT $ 48)))
                            (LETT P |#G229|)
                            (LETT Q |#G230|))
                           (EXIT
                            (SEQ G190 NIL
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL Q (QREFELT $ 31))
                                     (PROGN (LETT #1# L) (GO #4=#:G1335)))
                                    ('T
                                     (SEQ
                                      (LETT |e| (SPADCALL Q (QREFELT $ 20)))
                                      (LETT L (CONS |e| L))
                                      (LETT |delta|
                                            (PROG1
                                                (LETT #2#
                                                      (-
                                                       (SPADCALL P
                                                                 (QREFELT $
                                                                          20))
                                                       |e|))
                                              (|check_subtype2| (>= #2# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #2#)))
                                      (LETT Z
                                            (SPADCALL Q
                                                      (SPADCALL Q
                                                                (QREFELT $ 19))
                                                      |s| |delta|
                                                      (QREFELT $ 38)))
                                      (COND
                                       ((> |delta| 1) (LETT L (CONS |e| L))))
                                      (EXIT
                                       (COND
                                        ((ZEROP |e|)
                                         (PROGN (LETT #1# L) (GO #4#)))
                                        ('T
                                         (SEQ
                                          (PROGN
                                           (LETT |#G231| Q)
                                           (LETT |#G232|
                                                 (SPADCALL P Q Z |s|
                                                           (QREFELT $ 41)))
                                           (LETT P |#G231|)
                                           (LETT Q |#G232|))
                                          (EXIT
                                           (LETT |s|
                                                 (SPADCALL Z
                                                           (QREFELT $
                                                                    19)))))))))))))
                                 NIL (GO G190) G191 (EXIT NIL)))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRS;subResultantGcd;3polR;34| ((P (|polR|)) (Q (|polR|)) ($ (|polR|)))
        (SPROG
         ((|s| (R)) (|#G240| (|polR|)) (|#G239| (|polR|)) (Z (|polR|))
          (#1=#:G1343 NIL) (#2=#:G1353 NIL) (|#G238| (|polR|))
          (|#G237| (|polR|)) (#3=#:G1341 NIL) (|#G236| (|polR|))
          (|#G235| (|polR|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL P (QREFELT $ 31))
              (COND
               ((SPADCALL Q (QREFELT $ 31)) (EXIT (|spadConstant| $ 22))))))
            (EXIT
             (COND ((SPADCALL P (QREFELT $ 31)) Q)
                   ((SPADCALL Q (QREFELT $ 31)) P)
                   (#4='T
                    (SEQ
                     (COND
                      ((< (SPADCALL P (QREFELT $ 20))
                          (SPADCALL Q (QREFELT $ 20)))
                       (PROGN
                        (LETT |#G235| Q)
                        (LETT |#G236| P)
                        (LETT P |#G235|)
                        (LETT Q |#G236|))))
                     (EXIT
                      (COND
                       ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                        (|spadConstant| $ 35))
                       (#4#
                        (SEQ
                         (LETT |s|
                               (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                         (PROG1
                                             (LETT #3#
                                                   (-
                                                    (SPADCALL P (QREFELT $ 20))
                                                    (SPADCALL Q
                                                              (QREFELT $ 20))))
                                           (|check_subtype2| (>= #3# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #3#))
                                         (QREFELT $ 33)))
                         (PROGN
                          (LETT |#G237| Q)
                          (LETT |#G238|
                                (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                          (QREFELT $ 48)))
                          (LETT P |#G237|)
                          (LETT Q |#G238|))
                         (EXIT
                          (SEQ G190 NIL
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL Q (QREFELT $ 31))
                                   (PROGN (LETT #2# P) (GO #5=#:G1352)))
                                  ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                                   (PROGN
                                    (LETT #2# (|spadConstant| $ 35))
                                    (GO #5#)))
                                  ('T
                                   (SEQ
                                    (LETT Z
                                          (SPADCALL Q
                                                    (SPADCALL Q (QREFELT $ 19))
                                                    |s|
                                                    (PROG1
                                                        (LETT #1#
                                                              (-
                                                               (SPADCALL P
                                                                         (QREFELT
                                                                          $
                                                                          20))
                                                               (SPADCALL Q
                                                                         (QREFELT
                                                                          $
                                                                          20))))
                                                      (|check_subtype2|
                                                       (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                                    (QREFELT $ 38)))
                                    (PROGN
                                     (LETT |#G239| Q)
                                     (LETT |#G240|
                                           (SPADCALL P Q Z |s| (QREFELT $ 41)))
                                     (LETT P |#G239|)
                                     (LETT Q |#G240|))
                                    (EXIT
                                     (LETT |s|
                                           (SPADCALL Z (QREFELT $ 19)))))))))
                               NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |PRS;subResultantGcdEuclidean;2polRR;35|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |gcd| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G246| (|Vector| |polR|)) (|#G245| #1#) (|ss| (R)) (#2=#:G1363 NIL)
          (#3=#:G1373 NIL) (|e| (|NonNegativeInteger|)) (|#G244| (|polR|))
          (|#G243| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1360 NIL)
          (|l|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |gcd| |polR|))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL P (QREFELT $ 31))
              (COND
               ((SPADCALL Q (QREFELT $ 31))
                (EXIT
                 (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                         (|spadConstant| $ 22)))))))
            (EXIT
             (COND
              ((SPADCALL P (QREFELT $ 31))
               (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 35) Q))
              ((SPADCALL Q (QREFELT $ 31))
               (VECTOR (|spadConstant| $ 35) (|spadConstant| $ 22) P))
              (#5='T
               (SEQ
                (COND
                 ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                  (SEQ (LETT |l| (SPADCALL Q P (QREFELT $ 78)))
                       (EXIT
                        (PROGN
                         (LETT #3#
                               (VECTOR (QVELT |l| 1) (QVELT |l| 0)
                                       (QVELT |l| 2)))
                         (GO #6=#:G1372))))))
                (EXIT
                 (COND
                  ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                   (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 35) Q))
                  (#5#
                   (SEQ
                    (LETT |s|
                          (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                    (PROG1
                                        (LETT #4#
                                              (- (SPADCALL P (QREFELT $ 20))
                                                 (SPADCALL Q (QREFELT $ 20))))
                                      (|check_subtype2| (>= #4# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #4#))
                                    (QREFELT $ 33)))
                    (LETT VP
                          (VECTOR Q (|spadConstant| $ 22)
                                  (|spadConstant| $ 35)))
                    (LETT |pdiv|
                          (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                    (QREFELT $ 52)))
                    (LETT VQ
                          (VECTOR (QVELT |pdiv| 2)
                                  (SPADCALL (QVELT |pdiv| 0) (QREFELT $ 12))
                                  (QVELT |pdiv| 1)))
                    (EXIT
                     (SEQ G190 NIL
                          (SEQ
                           (PROGN
                            (LETT |#G243| (SPADCALL VP 1 (QREFELT $ 43)))
                            (LETT |#G244| (SPADCALL VQ 1 (QREFELT $ 43)))
                            (LETT P |#G243|)
                            (LETT Q |#G244|))
                           (EXIT
                            (COND
                             ((SPADCALL Q (QREFELT $ 31))
                              (PROGN
                               (LETT #3#
                                     (VECTOR (SPADCALL VP 2 (QREFELT $ 43))
                                             (SPADCALL VP 3 (QREFELT $ 43)) P))
                               (GO #6#)))
                             ('T
                              (SEQ (LETT |e| (SPADCALL Q (QREFELT $ 20)))
                                   (EXIT
                                    (COND
                                     ((ZEROP |e|)
                                      (PROGN
                                       (LETT #3#
                                             (VECTOR
                                              (SPADCALL VQ 2 (QREFELT $ 43))
                                              (SPADCALL VQ 3 (QREFELT $ 43))
                                              Q))
                                       (GO #6#)))
                                     ('T
                                      (SEQ
                                       (LETT |ss|
                                             (SPADCALL
                                              (SPADCALL Q (QREFELT $ 19)) |s|
                                              (PROG1
                                                  (LETT #2#
                                                        (-
                                                         (SPADCALL P
                                                                   (QREFELT $
                                                                            20))
                                                         |e|))
                                                (|check_subtype2| (>= #2# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #2#))
                                              (QREFELT $ 37)))
                                       (PROGN
                                        (LETT |#G245| VQ)
                                        (LETT |#G246|
                                              (|PRS;next_sousResultant3| VP VQ
                                               |s| |ss| $))
                                        (LETT VP |#G245|)
                                        (LETT VQ |#G246|))
                                       (EXIT (LETT |s| |ss|)))))))))))
                          NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #6# (EXIT #3#)))) 

(SDEFUN |PRS;semiSubResultantGcdEuclidean2;2polRR;36|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |gcd| |polR|))))
        (SPROG
         ((|s| (R)) (VQ #1=(|Vector| |polR|)) (VP (|Vector| |polR|))
          (|#G252| (|Vector| |polR|)) (|#G251| #1#) (|ss| (R)) (#2=#:G1381 NIL)
          (#3=#:G1393 NIL) (|e| (|NonNegativeInteger|)) (|#G250| (|polR|))
          (|#G249| (|polR|))
          (|pdiv|
           (|Record| (|:| |coef| R) (|:| |quotient| |polR|)
                     (|:| |remainder| |polR|)))
          (#4=#:G1378 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL P (QREFELT $ 31))
              (COND
               ((SPADCALL Q (QREFELT $ 31))
                (EXIT (CONS (|spadConstant| $ 22) (|spadConstant| $ 22)))))))
            (EXIT
             (COND ((SPADCALL P (QREFELT $ 31)) (CONS (|spadConstant| $ 35) Q))
                   ((SPADCALL Q (QREFELT $ 31)) (CONS (|spadConstant| $ 22) P))
                   ((< (SPADCALL P (QREFELT $ 20)) (SPADCALL Q (QREFELT $ 20)))
                    (|error|
                     "semiSubResultantGcdEuclidean2$PRS : bad degrees"))
                   ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                    (CONS (|spadConstant| $ 35) Q))
                   ('T
                    (SEQ
                     (LETT |s|
                           (SPADCALL (SPADCALL Q (QREFELT $ 19))
                                     (PROG1
                                         (LETT #4#
                                               (- (SPADCALL P (QREFELT $ 20))
                                                  (SPADCALL Q (QREFELT $ 20))))
                                       (|check_subtype2| (>= #4# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #4#))
                                     (QREFELT $ 33)))
                     (LETT VP (VECTOR Q (|spadConstant| $ 35)))
                     (LETT |pdiv|
                           (SPADCALL P (SPADCALL Q (QREFELT $ 39))
                                     (QREFELT $ 52)))
                     (LETT VQ (VECTOR (QVELT |pdiv| 2) (QVELT |pdiv| 1)))
                     (EXIT
                      (SEQ G190 NIL
                           (SEQ
                            (PROGN
                             (LETT |#G249| (SPADCALL VP 1 (QREFELT $ 43)))
                             (LETT |#G250| (SPADCALL VQ 1 (QREFELT $ 43)))
                             (LETT P |#G249|)
                             (LETT Q |#G250|))
                            (EXIT
                             (COND
                              ((SPADCALL Q (QREFELT $ 31))
                               (PROGN
                                (LETT #3#
                                      (CONS (SPADCALL VP 2 (QREFELT $ 43)) P))
                                (GO #5=#:G1392)))
                              ('T
                               (SEQ (LETT |e| (SPADCALL Q (QREFELT $ 20)))
                                    (EXIT
                                     (COND
                                      ((ZEROP |e|)
                                       (PROGN
                                        (LETT #3#
                                              (CONS
                                               (SPADCALL VQ 2 (QREFELT $ 43))
                                               Q))
                                        (GO #5#)))
                                      ('T
                                       (SEQ
                                        (LETT |ss|
                                              (SPADCALL
                                               (SPADCALL Q (QREFELT $ 19)) |s|
                                               (PROG1
                                                   (LETT #2#
                                                         (-
                                                          (SPADCALL P
                                                                    (QREFELT $
                                                                             20))
                                                          |e|))
                                                 (|check_subtype2| (>= #2# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #2#))
                                               (QREFELT $ 37)))
                                        (PROGN
                                         (LETT |#G251| VQ)
                                         (LETT |#G252|
                                               (|PRS;next_sousResultant3| VP VQ
                                                |s| |ss| $))
                                         (LETT VP |#G251|)
                                         (LETT VQ |#G252|))
                                        (EXIT (LETT |s| |ss|)))))))))))
                           NIL (GO G190) G191 (EXIT NIL)))))))))
          #5# (EXIT #3#)))) 

(SDEFUN |PRS;semiSubResultantGcdEuclidean1;2polRR;37|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef1| |polR|) (|:| |gcd| |polR|))))
        (SPROG
         ((|result|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |gcd| |polR|))))
         (SEQ (LETT |result| (SPADCALL P Q (QREFELT $ 78)))
              (EXIT (CONS (QVELT |result| 0) (QVELT |result| 2)))))) 

(SDEFUN |PRS;discriminant;polRR;38| ((P (|polR|)) ($ (R)))
        (SPROG
         ((#1=#:G1410 NIL) (#2=#:G1405 NIL) (#3=#:G1401 NIL) (|d| (|Integer|))
          (|r| (R)) (|dP| (|polR|)) (|a| (|Integer|)) (#4=#:G1399 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |d| (SPADCALL P (QREFELT $ 20)))
                (EXIT
                 (COND
                  ((ZEROP |d|)
                   (|error| "cannot take discriminant of constants"))
                  (#5='T
                   (SEQ (LETT |a| (QUOTIENT2 (* |d| (- |d| 1)) 2))
                        (LETT |a|
                              (EXPT -1
                                    (PROG1 (LETT #4# |a|)
                                      (|check_subtype2| (>= #4# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #4#))))
                        (LETT |dP| (SPADCALL P (QREFELT $ 83)))
                        (LETT |r| (SPADCALL P |dP| (QREFELT $ 50)))
                        (LETT |d| (- (- |d| (SPADCALL |dP| (QREFELT $ 20))) 1))
                        (EXIT
                         (PROGN
                          (LETT #1#
                                (COND
                                 ((ZEROP |d|)
                                  (SPADCALL |a|
                                            (PROG2
                                                (LETT #3#
                                                      (SPADCALL |r|
                                                                (SPADCALL P
                                                                          (QREFELT
                                                                           $
                                                                           19))
                                                                (QREFELT $
                                                                         24)))
                                                (QCDR #3#)
                                              (|check_union2| (QEQCAR #3# 0)
                                                              (QREFELT $ 6)
                                                              (|Union|
                                                               (QREFELT $ 6)
                                                               "failed")
                                                              #3#))
                                            (QREFELT $ 84)))
                                 (#5#
                                  (SPADCALL (SPADCALL |a| |r| (QREFELT $ 84))
                                            (SPADCALL
                                             (SPADCALL P (QREFELT $ 19))
                                             (PROG1 (LETT #2# (- |d| 1))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (QREFELT $ 33))
                                            (QREFELT $ 34)))))
                          (GO #6=#:G1409)))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |PRS;discriminantEuclidean;polRR;39|
        ((P (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |discriminant| R))))
        (SPROG
         ((#1=#:G1437 NIL) (|cr| (R)) (#2=#:G1430 NIL) (|c2| (|polR|))
          (#3=#:G1427 NIL) (|c1| (|polR|)) (#4=#:G1423 NIL) (#5=#:G1417 NIL)
          (#6=#:G1414 NIL) (|d| (|Integer|))
          (|rE|
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |resultant| R)))
          (|dP| (|polR|)) (|a| (|Integer|)) (#7=#:G1412 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |d| (SPADCALL P (QREFELT $ 20)))
                (EXIT
                 (COND
                  ((ZEROP |d|)
                   (|error| "cannot take discriminant of constants"))
                  (#8='T
                   (SEQ (LETT |a| (QUOTIENT2 (* |d| (- |d| 1)) 2))
                        (LETT |a|
                              (EXPT -1
                                    (PROG1 (LETT #7# |a|)
                                      (|check_subtype2| (>= #7# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #7#))))
                        (LETT |dP| (SPADCALL P (QREFELT $ 83)))
                        (LETT |rE| (SPADCALL P |dP| (QREFELT $ 55)))
                        (LETT |d| (- (- |d| (SPADCALL |dP| (QREFELT $ 20))) 1))
                        (COND
                         ((ZEROP |d|)
                          (SEQ
                           (LETT |c1|
                                 (SPADCALL |a|
                                           (PROG2
                                               (LETT #6#
                                                     (SPADCALL (QVELT |rE| 0)
                                                               (SPADCALL P
                                                                         (QREFELT
                                                                          $
                                                                          19))
                                                               (QREFELT $ 16)))
                                               (QCDR #6#)
                                             (|check_union2| (QEQCAR #6# 0)
                                                             (QREFELT $ 7)
                                                             (|Union|
                                                              (QREFELT $ 7)
                                                              #9="failed")
                                                             #6#))
                                           (QREFELT $ 53)))
                           (LETT |c2|
                                 (SPADCALL |a|
                                           (PROG2
                                               (LETT #6#
                                                     (SPADCALL (QVELT |rE| 1)
                                                               (SPADCALL P
                                                                         (QREFELT
                                                                          $
                                                                          19))
                                                               (QREFELT $ 16)))
                                               (QCDR #6#)
                                             (|check_union2| (QEQCAR #6# 0)
                                                             (QREFELT $ 7)
                                                             (|Union|
                                                              (QREFELT $ 7)
                                                              #9#)
                                                             #6#))
                                           (QREFELT $ 53)))
                           (EXIT
                            (LETT |cr|
                                  (SPADCALL |a|
                                            (PROG2
                                                (LETT #5#
                                                      (SPADCALL (QVELT |rE| 2)
                                                                (SPADCALL P
                                                                          (QREFELT
                                                                           $
                                                                           19))
                                                                (QREFELT $
                                                                         24)))
                                                (QCDR #5#)
                                              (|check_union2| (QEQCAR #5# 0)
                                                              (QREFELT $ 6)
                                                              (|Union|
                                                               (QREFELT $ 6)
                                                               "failed")
                                                              #5#))
                                            (QREFELT $ 84))))))
                         (#8#
                          (SEQ
                           (LETT |c1|
                                 (SPADCALL
                                  (SPADCALL |a| (QVELT |rE| 0) (QREFELT $ 53))
                                  (SPADCALL (SPADCALL P (QREFELT $ 19))
                                            (PROG1 (LETT #4# (- |d| 1))
                                              (|check_subtype2| (>= #4# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #4#))
                                            (QREFELT $ 33))
                                  (QREFELT $ 86)))
                           (LETT |c2|
                                 (SPADCALL
                                  (SPADCALL |a| (QVELT |rE| 1) (QREFELT $ 53))
                                  (SPADCALL (SPADCALL P (QREFELT $ 19))
                                            (PROG1 (LETT #3# (- |d| 1))
                                              (|check_subtype2| (>= #3# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #3#))
                                            (QREFELT $ 33))
                                  (QREFELT $ 86)))
                           (EXIT
                            (LETT |cr|
                                  (SPADCALL
                                   (SPADCALL |a| (QVELT |rE| 2) (QREFELT $ 84))
                                   (SPADCALL (SPADCALL P (QREFELT $ 19))
                                             (PROG1 (LETT #2# (- |d| 1))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (QREFELT $ 33))
                                   (QREFELT $ 34)))))))
                        (EXIT
                         (PROGN
                          (LETT #1# (VECTOR |c1| |c2| |cr|))
                          (GO #10=#:G1436)))))))))
          #10# (EXIT #1#)))) 

(SDEFUN |PRS;semiDiscriminantEuclidean;polRR;40|
        ((P (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |discriminant| R))))
        (SPROG
         ((#1=#:G1460 NIL) (|cr| (R)) (#2=#:G1453 NIL) (|c2| (|polR|))
          (#3=#:G1450 NIL) (#4=#:G1444 NIL) (#5=#:G1441 NIL) (|d| (|Integer|))
          (|rE| (|Record| (|:| |coef2| |polR|) (|:| |resultant| R)))
          (|dP| (|polR|)) (|a| (|Integer|)) (#6=#:G1439 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |d| (SPADCALL P (QREFELT $ 20)))
                (EXIT
                 (COND
                  ((ZEROP |d|)
                   (|error| "cannot take discriminant of constants"))
                  (#7='T
                   (SEQ (LETT |a| (QUOTIENT2 (* |d| (- |d| 1)) 2))
                        (LETT |a|
                              (EXPT -1
                                    (PROG1 (LETT #6# |a|)
                                      (|check_subtype2| (>= #6# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #6#))))
                        (LETT |dP| (SPADCALL P (QREFELT $ 83)))
                        (LETT |rE| (SPADCALL P |dP| (QREFELT $ 57)))
                        (LETT |d| (- (- |d| (SPADCALL |dP| (QREFELT $ 20))) 1))
                        (COND
                         ((ZEROP |d|)
                          (SEQ
                           (LETT |c2|
                                 (SPADCALL |a|
                                           (PROG2
                                               (LETT #5#
                                                     (SPADCALL (QCAR |rE|)
                                                               (SPADCALL P
                                                                         (QREFELT
                                                                          $
                                                                          19))
                                                               (QREFELT $ 16)))
                                               (QCDR #5#)
                                             (|check_union2| (QEQCAR #5# 0)
                                                             (QREFELT $ 7)
                                                             (|Union|
                                                              (QREFELT $ 7)
                                                              "failed")
                                                             #5#))
                                           (QREFELT $ 53)))
                           (EXIT
                            (LETT |cr|
                                  (SPADCALL |a|
                                            (PROG2
                                                (LETT #4#
                                                      (SPADCALL (QCDR |rE|)
                                                                (SPADCALL P
                                                                          (QREFELT
                                                                           $
                                                                           19))
                                                                (QREFELT $
                                                                         24)))
                                                (QCDR #4#)
                                              (|check_union2| (QEQCAR #4# 0)
                                                              (QREFELT $ 6)
                                                              (|Union|
                                                               (QREFELT $ 6)
                                                               "failed")
                                                              #4#))
                                            (QREFELT $ 84))))))
                         (#7#
                          (SEQ
                           (LETT |c2|
                                 (SPADCALL
                                  (SPADCALL |a| (QCAR |rE|) (QREFELT $ 53))
                                  (SPADCALL (SPADCALL P (QREFELT $ 19))
                                            (PROG1 (LETT #3# (- |d| 1))
                                              (|check_subtype2| (>= #3# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #3#))
                                            (QREFELT $ 33))
                                  (QREFELT $ 86)))
                           (EXIT
                            (LETT |cr|
                                  (SPADCALL
                                   (SPADCALL |a| (QCDR |rE|) (QREFELT $ 84))
                                   (SPADCALL (SPADCALL P (QREFELT $ 19))
                                             (PROG1 (LETT #2# (- |d| 1))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             (QREFELT $ 33))
                                   (QREFELT $ 34)))))))
                        (EXIT
                         (PROGN
                          (LETT #1# (CONS |c2| |cr|))
                          (GO #8=#:G1459)))))))))
          #8# (EXIT #1#)))) 

(SDEFUN |PRS;resultantReduit;2polRR;41| ((P (|polR|)) (Q (|polR|)) ($ (R)))
        (SPROG
         ((#1=#:G1476 NIL) (#2=#:G1471 NIL) (|l| (|List| R)) (|UVs| (|polR|))
          (UV
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |gcd| |polR|))))
         (SEQ
          (EXIT
           (SEQ (LETT UV (SPADCALL P Q (QREFELT $ 78)))
                (LETT |UVs| (QVELT UV 2))
                (EXIT
                 (COND
                  ((> (SPADCALL |UVs| (QREFELT $ 20)) 0) (|spadConstant| $ 21))
                  ('T
                   (SEQ
                    (LETT |l|
                          (SPADCALL (SPADCALL (QVELT UV 0) (QREFELT $ 92))
                                    (SPADCALL (QVELT UV 1) (QREFELT $ 92))
                                    (QREFELT $ 93)))
                    (EXIT
                     (PROGN
                      (LETT #1#
                            (PROG2
                                (LETT #2#
                                      (SPADCALL (SPADCALL |UVs| (QREFELT $ 19))
                                                (SPADCALL |l| (QREFELT $ 95))
                                                (QREFELT $ 24)))
                                (QCDR #2#)
                              (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                              (|Union| (QREFELT $ 6) "failed")
                                              #2#)))
                      (GO #3=#:G1475)))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |PRS;resultantReduitEuclidean;2polRR;42|
        ((P (|polR|)) (Q (|polR|))
         ($
          (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                    (|:| |resultantReduit| R))))
        (SPROG
         ((#1=#:G1489 NIL) (|rr| (R)) (#2=#:G1483 NIL) (|c2| (|polR|))
          (#3=#:G1480 NIL) (|c1| (|polR|)) (|gl| (R)) (|l| (|List| R))
          (|UVs| (|polR|))
          (UV
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |gcd| |polR|))))
         (SEQ
          (EXIT
           (SEQ (LETT UV (SPADCALL P Q (QREFELT $ 78)))
                (LETT |UVs| (QVELT UV 2))
                (EXIT
                 (COND
                  ((> (SPADCALL |UVs| (QREFELT $ 20)) 0)
                   (VECTOR (|spadConstant| $ 22) (|spadConstant| $ 22)
                           (|spadConstant| $ 21)))
                  ('T
                   (SEQ
                    (LETT |l|
                          (SPADCALL (SPADCALL (QVELT UV 0) (QREFELT $ 92))
                                    (SPADCALL (QVELT UV 1) (QREFELT $ 92))
                                    (QREFELT $ 93)))
                    (LETT |gl| (SPADCALL |l| (QREFELT $ 95)))
                    (LETT |c1|
                          (PROG2
                              (LETT #3#
                                    (SPADCALL (QVELT UV 0) |gl|
                                              (QREFELT $ 16)))
                              (QCDR #3#)
                            (|check_union2| (QEQCAR #3# 0) (QREFELT $ 7)
                                            (|Union| (QREFELT $ 7) #4="failed")
                                            #3#)))
                    (LETT |c2|
                          (PROG2
                              (LETT #3#
                                    (SPADCALL (QVELT UV 1) |gl|
                                              (QREFELT $ 16)))
                              (QCDR #3#)
                            (|check_union2| (QEQCAR #3# 0) (QREFELT $ 7)
                                            (|Union| (QREFELT $ 7) #4#) #3#)))
                    (LETT |rr|
                          (PROG2
                              (LETT #2#
                                    (SPADCALL (SPADCALL |UVs| (QREFELT $ 19))
                                              |gl| (QREFELT $ 24)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                            (|Union| (QREFELT $ 6) "failed")
                                            #2#)))
                    (EXIT
                     (PROGN
                      (LETT #1# (VECTOR |c1| |c2| |rr|))
                      (GO #5=#:G1488)))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |PRS;semiResultantReduitEuclidean;2polRR;43|
        ((P (|polR|)) (Q (|polR|))
         ($ (|Record| (|:| |coef2| |polR|) (|:| |resultantReduit| R))))
        (SPROG
         ((#1=#:G1502 NIL) (|rr| (R)) (#2=#:G1496 NIL) (|c2| (|polR|))
          (#3=#:G1493 NIL) (|gl| (R)) (|l| (|List| R)) (|UVs| (|polR|))
          (UV
           (|Record| (|:| |coef1| |polR|) (|:| |coef2| |polR|)
                     (|:| |gcd| |polR|))))
         (SEQ
          (EXIT
           (SEQ (LETT UV (SPADCALL P Q (QREFELT $ 78)))
                (LETT |UVs| (QVELT UV 2))
                (EXIT
                 (COND
                  ((> (SPADCALL |UVs| (QREFELT $ 20)) 0)
                   (CONS (|spadConstant| $ 22) (|spadConstant| $ 21)))
                  ('T
                   (SEQ
                    (LETT |l|
                          (SPADCALL (SPADCALL (QVELT UV 0) (QREFELT $ 92))
                                    (SPADCALL (QVELT UV 1) (QREFELT $ 92))
                                    (QREFELT $ 93)))
                    (LETT |gl| (SPADCALL |l| (QREFELT $ 95)))
                    (LETT |c2|
                          (PROG2
                              (LETT #3#
                                    (SPADCALL (QVELT UV 1) |gl|
                                              (QREFELT $ 16)))
                              (QCDR #3#)
                            (|check_union2| (QEQCAR #3# 0) (QREFELT $ 7)
                                            (|Union| (QREFELT $ 7) "failed")
                                            #3#)))
                    (LETT |rr|
                          (PROG2
                              (LETT #2#
                                    (SPADCALL (SPADCALL |UVs| (QREFELT $ 19))
                                              |gl| (QREFELT $ 24)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                            (|Union| (QREFELT $ 6) "failed")
                                            #2#)))
                    (EXIT
                     (PROGN (LETT #1# (CONS |c2| |rr|)) (GO #4=#:G1501)))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRS;gcd_naif| ((P (|polR|)) (Q (|polR|)) ($ (|polR|)))
        (SPROG
         ((|#G272| (|polR|)) (|#G271| (|polR|)) (#1=#:G1513 NIL)
          (#2=#:G1504 NIL))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL P (QREFELT $ 31))
             (PROG2
                 (LETT #2#
                       (SPADCALL Q (SPADCALL Q (QREFELT $ 19)) (QREFELT $ 16)))
                 (QCDR #2#)
               (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                               (|Union| (QREFELT $ 7) #3="failed") #2#)))
            ('T
             (SEQ G190 NIL
                  (SEQ
                   (EXIT
                    (COND
                     ((SPADCALL Q (QREFELT $ 31))
                      (PROGN
                       (LETT #1#
                             (PROG2
                                 (LETT #2#
                                       (SPADCALL P (SPADCALL P (QREFELT $ 19))
                                                 (QREFELT $ 16)))
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7) #3#)
                                               #2#)))
                       (GO #4=#:G1512)))
                     ((ZEROP (SPADCALL Q (QREFELT $ 20)))
                      (PROGN (LETT #1# (|spadConstant| $ 35)) (GO #4#)))
                     ('T
                      (PROGN
                       (LETT |#G271| Q)
                       (LETT |#G272| (QCDR (SPADCALL P Q (QREFELT $ 29))))
                       (LETT P |#G271|)
                       (LETT Q |#G272|))))))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRS;gcd;3polR;45| ((P (|polR|)) (Q (|polR|)) ($ (|polR|)))
        (|PRS;gcd_naif| P Q $)) 

(SDEFUN |PRS;gcd;3polR;46| ((P (|polR|)) (Q (|polR|)) ($ (|polR|)))
        (SPROG ((G (|polR|)) (#1=#:G1516 NIL) (|cQ| (R)) (|cP| (R)))
               (SEQ
                (COND ((SPADCALL P (QREFELT $ 31)) Q)
                      ((SPADCALL Q (QREFELT $ 31)) P)
                      ('T
                       (SEQ (LETT |cP| (SPADCALL P (QREFELT $ 102)))
                            (LETT |cQ| (SPADCALL Q (QREFELT $ 102)))
                            (LETT P
                                  (PROG2
                                      (LETT #1#
                                            (SPADCALL P |cP| (QREFELT $ 16)))
                                      (QCDR #1#)
                                    (|check_union2| (QEQCAR #1# 0)
                                                    (QREFELT $ 7)
                                                    (|Union| (QREFELT $ 7)
                                                             #2="failed")
                                                    #1#)))
                            (LETT Q
                                  (PROG2
                                      (LETT #1#
                                            (SPADCALL Q |cQ| (QREFELT $ 16)))
                                      (QCDR #1#)
                                    (|check_union2| (QEQCAR #1# 0)
                                                    (QREFELT $ 7)
                                                    (|Union| (QREFELT $ 7) #2#)
                                                    #1#)))
                            (LETT G (SPADCALL P Q (QREFELT $ 76)))
                            (EXIT
                             (SPADCALL (SPADCALL |cP| |cQ| (QREFELT $ 103))
                                       (SPADCALL G (QREFELT $ 104))
                                       (QREFELT $ 36))))))))) 

(DECLAIM (NOTINLINE |PseudoRemainderSequence;|)) 

(DEFUN |PseudoRemainderSequence| (&REST #1=#:G1522)
  (SPROG NIL
         (PROG (#2=#:G1523)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PseudoRemainderSequence|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PseudoRemainderSequence;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PseudoRemainderSequence|)))))))))) 

(DEFUN |PseudoRemainderSequence;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PseudoRemainderSequence| DV$1 DV$2))
          (LETT $ (GETREFV 105))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|))))))
          (|haddProp| |$ConstructorCache| '|PseudoRemainderSequence|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 11 (SPADCALL (|spadConstant| $ 8) 1 (QREFELT $ 10)))
          (COND
           ((|HasCategory| |#1| '(|FiniteFieldCategory|))
            (QSETREFV $ 50
                      (CONS (|dispatchFunction| |PRS;resultant;2polRR;14|) $)))
           ('T
            (QSETREFV $ 50
                      (CONS (|dispatchFunction| |PRS;resultant;2polRR;15|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|FiniteFieldCategory|))
            (QSETREFV $ 55
                      (CONS
                       (|dispatchFunction| |PRS;resultantEuclidean;2polRR;17|)
                       $)))
           ('T
            (QSETREFV $ 55
                      (CONS
                       (|dispatchFunction| |PRS;resultantEuclidean;2polRR;18|)
                       $))))
          (COND
           ((|HasCategory| |#1| '(|FiniteFieldCategory|))
            (QSETREFV $ 57
                      (CONS
                       (|dispatchFunction|
                        |PRS;semiResultantEuclidean2;2polRR;20|)
                       $)))
           ('T
            (QSETREFV $ 57
                      (CONS
                       (|dispatchFunction|
                        |PRS;semiResultantEuclidean2;2polRR;21|)
                       $))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 96
                       (CONS
                        (|dispatchFunction| |PRS;resultantReduit;2polRR;41|)
                        $))
             (QSETREFV $ 98
                       (CONS
                        (|dispatchFunction|
                         |PRS;resultantReduitEuclidean;2polRR;42|)
                        $))
             (QSETREFV $ 100
                       (CONS
                        (|dispatchFunction|
                         |PRS;semiResultantReduitEuclidean;2polRR;43|)
                        $))
             (COND
              ((|HasCategory| |#1| '(|FiniteFieldCategory|))
               (QSETREFV $ 101
                         (CONS (|dispatchFunction| |PRS;gcd;3polR;45|) $)))
              ('T
               (QSETREFV $ 101
                         (CONS (|dispatchFunction| |PRS;gcd;3polR;46|) $)))))))
          $))) 

(MAKEPROP '|PseudoRemainderSequence| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (|NonNegativeInteger|) (4 . |monomial|) 'X (10 . |coerce|)
              (|Vector| 7) (15 . *) (|Union| $ '"failed") (21 . |exquo|)
              (|Mapping| 7 7) (27 . |map|) (33 . |leadingCoefficient|)
              (38 . |degree|) (43 . |Zero|) (47 . |Zero|) (51 . |reductum|)
              (56 . |exquo|) (62 . +) (68 . *) (74 . -)
              (|Record| (|:| |quotient| 7) (|:| |remainder| 7))
              |PRS;divide;2polRR;3| (|Boolean|) (80 . |zero?|) (85 . -)
              (90 . ^) (96 . *) (102 . |One|) (106 . *)
              |PRS;LazardQuotient;2RNniR;8|
              |PRS;LazardQuotient2;polR2RNnipolR;9| (112 . -)
              (117 . |coefficient|) |PRS;next_sousResultant2;3polRRpolR;11|
              (|Integer|) (123 . |elt|) (129 . -) (135 . +) (141 . |setelt!|)
              (148 . -) (153 . |pseudoRemainder|) (159 . ^) (165 . |resultant|)
              (|Record| (|:| |coef| 6) (|:| |quotient| $) (|:| |remainder| $))
              (171 . |pseudoDivide|) (177 . *)
              (|Record| (|:| |coef1| 7) (|:| |coef2| 7) (|:| |resultant| 6))
              (183 . |resultantEuclidean|)
              (|Record| (|:| |coef2| 7) (|:| |resultant| 6))
              (189 . |semiResultantEuclidean2|)
              (|Record| (|:| |coef1| 7) (|:| |resultant| 6))
              |PRS;semiResultantEuclidean1;2polRR;22|
              |PRS;indiceSubResultant;2polRNnipolR;23|
              (|Record| (|:| |coef1| 7) (|:| |coef2| 7) (|:| |subResultant| 7))
              |PRS;indiceSubResultantEuclidean;2polRNniR;24|
              (|Record| (|:| |coef2| 7) (|:| |subResultant| 7))
              |PRS;semiIndiceSubResultantEuclidean;2polRNniR;25|
              |PRS;degreeSubResultant;2polRNnipolR;26|
              |PRS;degreeSubResultantEuclidean;2polRNniR;27|
              |PRS;semiDegreeSubResultantEuclidean;2polRNniR;28|
              |PRS;lastSubResultant;3polR;29|
              |PRS;lastSubResultantEuclidean;2polRR;30| (195 . |copy|)
              |PRS;semiLastSubResultantEuclidean;2polRR;31| (|List| 7)
              |PRS;chainSubResultants;2polRL;32| (|List| 9)
              |PRS;schema;2polRL;33| |PRS;subResultantGcd;3polR;34|
              (|Record| (|:| |coef1| 7) (|:| |coef2| 7) (|:| |gcd| 7))
              |PRS;subResultantGcdEuclidean;2polRR;35|
              (|Record| (|:| |coef2| 7) (|:| |gcd| 7))
              |PRS;semiSubResultantGcdEuclidean2;2polRR;36|
              (|Record| (|:| |coef1| 7) (|:| |gcd| 7))
              |PRS;semiSubResultantGcdEuclidean1;2polRR;37|
              (200 . |differentiate|) (205 . *) |PRS;discriminant;polRR;38|
              (211 . *)
              (|Record| (|:| |coef1| 7) (|:| |coef2| 7) (|:| |discriminant| 6))
              |PRS;discriminantEuclidean;polRR;39|
              (|Record| (|:| |coef2| 7) (|:| |discriminant| 6))
              |PRS;semiDiscriminantEuclidean;polRR;40| (|List| 6)
              (217 . |coefficients|) (222 . |concat|) (|List| $) (228 . |gcd|)
              (233 . |resultantReduit|)
              (|Record| (|:| |coef1| 7) (|:| |coef2| 7)
                        (|:| |resultantReduit| 6))
              (239 . |resultantReduitEuclidean|)
              (|Record| (|:| |coef2| 7) (|:| |resultantReduit| 6))
              (245 . |semiResultantReduitEuclidean|) (251 . |gcd|)
              (257 . |content|) (262 . |gcd|) (268 . |primitivePart|))
           '#(|subResultantGcdEuclidean| 273 |subResultantGcd| 279
              |semiSubResultantGcdEuclidean2| 285
              |semiSubResultantGcdEuclidean1| 291
              |semiResultantReduitEuclidean| 297 |semiResultantEuclidean2| 303
              |semiResultantEuclidean1| 309 |semiLastSubResultantEuclidean| 315
              |semiIndiceSubResultantEuclidean| 321 |semiDiscriminantEuclidean|
              328 |semiDegreeSubResultantEuclidean| 333 |schema| 340
              |resultantReduitEuclidean| 346 |resultantReduit| 352
              |resultantEuclidean| 358 |resultant| 364 |next_sousResultant2|
              370 |lastSubResultantEuclidean| 378 |lastSubResultant| 384
              |indiceSubResultantEuclidean| 390 |indiceSubResultant| 397 |gcd|
              404 |divide| 410 |discriminantEuclidean| 416 |discriminant| 421
              |degreeSubResultantEuclidean| 426 |degreeSubResultant| 433
              |chainSubResultants| 440 |LazardQuotient2| 446 |LazardQuotient|
              454)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|resultant| (|#1| |#2| |#2|)) T)
                                   '((|resultantEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |resultant| |#1|))
                                       |#2| |#2|))
                                     T)
                                   '((|semiResultantEuclidean2|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |resultant| |#1|))
                                       |#2| |#2|))
                                     T)
                                   '((|semiResultantEuclidean1|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |resultant| |#1|))
                                       |#2| |#2|))
                                     T)
                                   '((|indiceSubResultant|
                                      (|#2| |#2| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|indiceSubResultantEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |subResultant| |#2|))
                                       |#2| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|semiIndiceSubResultantEuclidean|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |subResultant| |#2|))
                                       |#2| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|degreeSubResultant|
                                      (|#2| |#2| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|degreeSubResultantEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |subResultant| |#2|))
                                       |#2| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|semiDegreeSubResultantEuclidean|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |subResultant| |#2|))
                                       |#2| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|lastSubResultant| (|#2| |#2| |#2|)) T)
                                   '((|lastSubResultantEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |subResultant| |#2|))
                                       |#2| |#2|))
                                     T)
                                   '((|semiLastSubResultantEuclidean|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |subResultant| |#2|))
                                       |#2| |#2|))
                                     T)
                                   '((|subResultantGcd| (|#2| |#2| |#2|)) T)
                                   '((|subResultantGcdEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |gcd| |#2|))
                                       |#2| |#2|))
                                     T)
                                   '((|semiSubResultantGcdEuclidean2|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |gcd| |#2|))
                                       |#2| |#2|))
                                     T)
                                   '((|semiSubResultantGcdEuclidean1|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |gcd| |#2|))
                                       |#2| |#2|))
                                     T)
                                   '((|discriminant| (|#1| |#2|)) T)
                                   '((|discriminantEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |discriminant| |#1|))
                                       |#2|))
                                     T)
                                   '((|semiDiscriminantEuclidean|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |discriminant| |#1|))
                                       |#2|))
                                     T)
                                   '((|chainSubResultants|
                                      ((|List| |#2|) |#2| |#2|))
                                     T)
                                   '((|schema|
                                      ((|List| (|NonNegativeInteger|)) |#2|
                                       |#2|))
                                     T)
                                   '((|resultantReduit| (|#1| |#2| |#2|))
                                     (|has| 6 (|GcdDomain|)))
                                   '((|resultantReduitEuclidean|
                                      ((|Record| (|:| |coef1| |#2|)
                                                 (|:| |coef2| |#2|)
                                                 (|:| |resultantReduit| |#1|))
                                       |#2| |#2|))
                                     (|has| 6 (|GcdDomain|)))
                                   '((|semiResultantReduitEuclidean|
                                      ((|Record| (|:| |coef2| |#2|)
                                                 (|:| |resultantReduit| |#1|))
                                       |#2| |#2|))
                                     (|has| 6 (|GcdDomain|)))
                                   '((|gcd| (|#2| |#2| |#2|))
                                     (|has| 6 (|GcdDomain|)))
                                   '((|divide|
                                      ((|Record| (|:| |quotient| |#2|)
                                                 (|:| |remainder| |#2|))
                                       |#2| |#2|))
                                     T)
                                   '((|LazardQuotient|
                                      (|#1| |#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((|LazardQuotient2|
                                      (|#2| |#2| |#1| |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|next_sousResultant2|
                                      (|#2| |#2| |#2| |#2| |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 104
                                            '(0 6 0 8 2 7 0 6 9 10 1 7 0 6 12 2
                                              13 0 7 0 14 2 7 15 0 6 16 2 13 0
                                              17 0 18 1 7 6 0 19 1 7 9 0 20 0 6
                                              0 21 0 7 0 22 1 7 0 0 23 2 6 15 0
                                              0 24 2 7 0 0 0 25 2 7 0 0 0 26 2
                                              7 0 0 0 27 1 7 30 0 31 1 6 0 0 32
                                              2 6 0 0 9 33 2 6 0 0 0 34 0 7 0
                                              35 2 7 0 6 0 36 1 7 0 0 39 2 7 6
                                              0 9 40 2 13 7 0 42 43 2 13 0 0 0
                                              44 2 13 0 0 0 45 3 13 7 0 42 7 46
                                              1 13 0 0 47 2 7 0 0 0 48 2 6 0 0
                                              42 49 2 0 6 7 7 50 2 7 51 0 0 52
                                              2 7 0 42 0 53 2 0 54 7 7 55 2 0
                                              56 7 7 57 1 13 0 0 70 1 7 0 0 83
                                              2 6 0 42 0 84 2 7 0 0 6 86 1 7 91
                                              0 92 2 91 0 0 0 93 1 6 0 94 95 2
                                              0 6 7 7 96 2 0 97 7 7 98 2 0 99 7
                                              7 100 2 0 7 7 7 101 1 7 6 0 102 2
                                              6 0 0 0 103 1 7 0 0 104 2 0 77 7
                                              7 78 2 0 7 7 7 76 2 0 79 7 7 80 2
                                              0 81 7 7 82 2 1 99 7 7 100 2 0 56
                                              7 7 57 2 0 58 7 7 59 2 0 63 7 7
                                              71 3 0 63 7 7 9 64 1 0 89 7 90 3
                                              0 63 7 7 9 67 2 0 74 7 7 75 2 1
                                              97 7 7 98 2 1 6 7 7 96 2 0 54 7 7
                                              55 2 0 6 7 7 50 4 0 7 7 7 7 6 41
                                              2 0 61 7 7 69 2 0 7 7 7 68 3 0 61
                                              7 7 9 62 3 0 7 7 7 9 60 2 1 7 7 7
                                              101 2 0 28 7 7 29 1 0 87 7 88 1 0
                                              6 7 85 3 0 61 7 7 9 66 3 0 7 7 7
                                              9 65 2 0 72 7 7 73 4 0 7 7 6 6 9
                                              38 3 0 6 6 6 9 37)))))
           '|lookupComplete|)) 
