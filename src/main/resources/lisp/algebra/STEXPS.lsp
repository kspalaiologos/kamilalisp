
(SDEFUN |STEXPS;zro| (($ (|Stream| |Coef|))) (SPADCALL (QREFELT $ 8))) 

(SDEFUN |STEXPS;stmult|
        ((|n0| (|Integer|)) (|x0| (|Stream| |Coef|)) (|y0| (|Stream| |Coef|))
         (|ll0| (|List| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|STEXPS;stmult!0| (VECTOR $ |ll0| |n0| |y0| |x0|))
                 (QREFELT $ 37))))) 

(SDEFUN |STEXPS;stmult!0| (($$ NIL))
        (PROG (|x0| |y0| |n0| |ll0| $)
          (LETT |x0| (QREFELT $$ 4))
          (LETT |y0| (QREFELT $$ 3))
          (LETT |n0| (QREFELT $$ 2))
          (LETT |ll0| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|x| NIL) (|c| NIL) (|y| NIL) (|ll| NIL) (|n| NIL) (|i| NIL)
              (#1=#:G744 NIL) (#2=#:G743 NIL) (#3=#:G742 NIL) (|res| NIL)
              (|llp| NIL) (|xp| NIL))
             (SEQ
              (EXIT
               (SEQ (LETT |x| |x0|) (LETT |y| |y0|) (LETT |n| |n0|)
                    (LETT |ll| |ll0|)
                    (COND
                     ((SPADCALL |y| (QREFELT $ 10))
                      (COND
                       ((OR (SPADCALL |n| (|spadConstant| $ 23) (QREFELT $ 14))
                            (SPADCALL |x| (QREFELT $ 10)))
                        (PROGN
                         (LETT #2# (SPADCALL (QREFELT $ 8)))
                         (GO #4=#:G741)))
                       ('T (LETT |x| (SPADCALL |x| (QREFELT $ 15))))))
                     ('T
                      (SEQ (LETT |c| (SPADCALL |y| (QREFELT $ 16)))
                           (LETT |y| (SPADCALL |y| (QREFELT $ 15)))
                           (LETT |ll| (SPADCALL |c| |ll| (QREFELT $ 18)))
                           (EXIT
                            (LETT |n|
                                  (SPADCALL |n| (|spadConstant| $ 35)
                                            (QREFELT $ 21)))))))
                    (LETT |res| (|spadConstant| $ 11)) (LETT |xp| |x|)
                    (LETT |llp| |ll|)
                    (SEQ
                     (EXIT
                      (SEQ (LETT |i| (|spadConstant| $ 23)) (LETT #1# |n|) G190
                           (COND ((> |i| #1#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |xp| (QREFELT $ 10))
                               (COND
                                ((SPADCALL |i| (|spadConstant| $ 25)
                                           (QREFELT $ 26))
                                 (PROGN
                                  (LETT #2# (SPADCALL (QREFELT $ 8)))
                                  (GO #4#)))
                                ('T (PROGN (LETT #3# 1) (GO #5=#:G737)))))
                              ('T
                               (SEQ
                                (LETT |res|
                                      (SPADCALL |res|
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |n| |i|
                                                            (QREFELT $ 27))
                                                  (SPADCALL |xp|
                                                            (QREFELT $ 16))
                                                  (QREFELT $ 28))
                                                 (SPADCALL |llp|
                                                           (QREFELT $ 29))
                                                 (QREFELT $ 30))
                                                (QREFELT $ 31)))
                                (LETT |llp| (SPADCALL |llp| (QREFELT $ 32)))
                                (EXIT
                                 (LETT |xp|
                                       (SPADCALL |xp| (QREFELT $ 15)))))))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                     #5# (EXIT #3#))
                    (COND
                     ((SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 33))
                      (COND
                       ((SPADCALL |y| (QREFELT $ 33))
                        (EXIT
                         (SPADCALL |res| (SPADCALL (QREFELT $ 8))
                                   (QREFELT $ 34)))))))
                    (EXIT
                     (SPADCALL |res| (|STEXPS;stmult| |n| |x| |y| |ll| $)
                               (QREFELT $ 34)))))
              #4# (EXIT #2#))))))) 

(SDEFUN |STEXPS;*;3S;3|
        ((|x| (|Stream| |Coef|)) (|y| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL (CONS #'|STEXPS;*;3S;3!0| (VECTOR |x| $ |y|))
                         (QREFELT $ 37)))) 

(SDEFUN |STEXPS;*;3S;3!0| (($$ NIL))
        (PROG (|y| $ |x|)
          (LETT |y| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((OR (SPADCALL |y| (QREFELT $ 10)) (SPADCALL |x| (QREFELT $ 10)))
              (|STEXPS;zro| $))
             ('T
              (|STEXPS;stmult| (SPADCALL (|spadConstant| $ 20) (QREFELT $ 38))
               |x| |y| NIL $))))))) 

(SDEFUN |STEXPS;deriv;2S;4| ((|f| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (COND ((SPADCALL |f| (QREFELT $ 10)) (|STEXPS;zro| $))
              ('T (SPADCALL |f| (QREFELT $ 15))))) 

(SDEFUN |STEXPS;integrate;Coef2S;5|
        ((|a| (|Coef|)) (|x| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPADCALL |a| |x| (QREFELT $ 34))) 

(SDEFUN |STEXPS;lazyIntegrate;CoefMS;6|
        ((|s| (|Coef|)) (|xf| (|Mapping| (|Stream| |Coef|)))
         ($ (|Stream| |Coef|)))
        (SPADCALL |s| (SPADCALL |xf| (QREFELT $ 37)) (QREFELT $ 34))) 

(SDEFUN |STEXPS;exp00| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (COND
                ((SPADCALL |z| (QREFELT $ 10))
                 (SPADCALL (|spadConstant| $ 19) (SPADCALL (QREFELT $ 8))
                           (QREFELT $ 44)))
                ('T
                 (SPADCALL (CONS #'|STEXPS;exp00!1| (VECTOR |z| $))
                           (QREFELT $ 47)))))) 

(SDEFUN |STEXPS;exp00!1| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (|spadConstant| $ 19)
                             (CONS #'|STEXPS;exp00!0| (VECTOR $ |z| |y|))
                             (QREFELT $ 43))))))) 

(SDEFUN |STEXPS;exp00!0| (($$ NIL))
        (PROG (|y| |z| $)
          (LETT |y| (QREFELT $$ 2))
          (LETT |z| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |y| (SPADCALL |z| (QREFELT $ 40)) (QREFELT $ 39)))))) 

(SDEFUN |STEXPS;exp0;2S;8| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (|STEXPS;exp00| (SPADCALL (|spadConstant| $ 11) |z| (QREFELT $ 44)) $)) 

(SDEFUN |STEXPS;log1;2S;9| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (COND ((SPADCALL |z| (QREFELT $ 10)) (|STEXPS;zro| $))
                     ('T
                      (SPADCALL (CONS #'|STEXPS;log1;2S;9!1| (VECTOR |z| $))
                                (QREFELT $ 47)))))) 

(SDEFUN |STEXPS;log1;2S;9!1| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (|spadConstant| $ 11)
                             (CONS #'|STEXPS;log1;2S;9!0| (VECTOR |z| $ |y|))
                             (QREFELT $ 43))))))) 

(SDEFUN |STEXPS;log1;2S;9!0| (($$ NIL))
        (PROG (|y| $ |z|)
          (LETT |y| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|STEXPS;exp00| (SPADCALL |y| (QREFELT $ 50)) $) |z|
                      (QREFELT $ 39)))))) 

(DECLAIM (NOTINLINE |StreamExponentialSeriesOperations;|)) 

(DEFUN |StreamExponentialSeriesOperations| (#1=#:G768)
  (SPROG NIL
         (PROG (#2=#:G769)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StreamExponentialSeriesOperations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|StreamExponentialSeriesOperations;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|StreamExponentialSeriesOperations|)))))))))) 

(DEFUN |StreamExponentialSeriesOperations;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|StreamExponentialSeriesOperations| DV$1))
          (LETT $ (GETREFV 52))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|StreamExponentialSeriesOperations|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StreamExponentialSeriesOperations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Stream| 6) (0 . |empty|)
              (|Boolean|) (4 . |empty?|) (9 . |Zero|) (|Integer|) (13 . |Zero|)
              (17 . <) (23 . |rst|) (28 . |frst|) (|List| 6) (33 . |cons|)
              (39 . |One|) (43 . |One|) (47 . +) (|SingleInteger|)
              (53 . |Zero|) (|NonNegativeInteger|) (57 . |Zero|) (61 . =)
              (67 . |binomial|) (73 . *) (79 . |first|) (84 . *) (90 . +)
              (96 . |rest|) (101 . |explicitlyEmpty?|) (106 . |concat|)
              (112 . |One|) (|Mapping| $) (116 . |delay|) (121 . -)
              |STEXPS;*;3S;3| |STEXPS;deriv;2S;4| |STEXPS;integrate;Coef2S;5|
              (|Mapping| 7) |STEXPS;lazyIntegrate;CoefMS;6| (126 . |cons|)
              (|Mapping| 7 7) (|ParadoxicalCombinatorsForStreams| 6) (132 . Y)
              |STEXPS;exp0;2S;8| (|StreamTaylorSeriesOperations| 6) (137 . -)
              |STEXPS;log1;2S;9|)
           '#(|log1| 142 |lazyIntegrate| 147 |integrate| 153 |exp0| 159 |deriv|
              164 * 169)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((*
                                 ((|Stream| |#1|) (|Stream| |#1|)
                                  (|Stream| |#1|)))
                                T)
                              '((|deriv| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|integrate|
                                 ((|Stream| |#1|) |#1| (|Stream| |#1|)))
                                T)
                              '((|lazyIntegrate|
                                 ((|Stream| |#1|) |#1|
                                  (|Mapping| (|Stream| |#1|))))
                                T)
                              '((|exp0| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|log1| ((|Stream| |#1|) (|Stream| |#1|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 51
                                            '(0 7 0 8 1 7 9 0 10 0 6 0 11 0 12
                                              0 13 2 12 9 0 0 14 1 7 0 0 15 1 7
                                              6 0 16 2 17 0 6 0 18 0 6 0 19 0
                                              12 0 20 2 12 0 0 0 21 0 22 0 23 0
                                              24 0 25 2 24 9 0 0 26 2 12 0 0 0
                                              27 2 6 0 12 0 28 1 17 6 0 29 2 6
                                              0 0 0 30 2 6 0 0 0 31 1 17 0 0 32
                                              1 7 9 0 33 2 7 0 6 0 34 0 22 0 35
                                              1 7 0 36 37 1 12 0 0 38 2 7 0 6 0
                                              44 1 46 7 45 47 1 49 7 7 50 1 0 7
                                              7 51 2 0 7 6 42 43 2 0 7 6 7 41 1
                                              0 7 7 48 1 0 7 7 40 2 0 7 7 7
                                              39)))))
           '|lookupComplete|)) 
