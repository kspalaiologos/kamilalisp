
(SDEFUN |LLLRED;gram_step|
        ((|k| (|Integer|)) (N (|Integer|)) (|bm| (|Matrix| (|Integer|)))
         (|bsm| (|Matrix| (|Float|))) (|mu| (|Matrix| (|Float|)))
         (|nbs| (|Vector| (|Float|))) (|v1| (|Vector| (|Float|))) ($ (|Void|)))
        (SPROG
         ((#1=#:G721 NIL) (|i| NIL) (#2=#:G720 NIL) (|v2| (|Vector| (|Float|)))
          (#3=#:G719 NIL) (|j| NIL) (#4=#:G718 NIL))
         (SEQ (SPADCALL |mu| |k| |k| (|spadConstant| $ 7) (QREFELT $ 10))
              (SEQ (LETT |i| 1) (LETT #4# N) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |v1| |i|
                               (SPADCALL (SPADCALL |bm| |k| |i| (QREFELT $ 12))
                                         (QREFELT $ 13))
                               (QREFELT $ 15))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |j| 1) (LETT #3# (- |k| 1)) G190
                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                   (SEQ (LETT |v2| (SPADCALL |bsm| |j| (QREFELT $ 16)))
                        (SPADCALL |mu| |k| |j|
                                  (SPADCALL (SPADCALL |v1| |v2| (QREFELT $ 17))
                                            (SPADCALL |nbs| |j| (QREFELT $ 18))
                                            (QREFELT $ 19))
                                  (QREFELT $ 10))
                        (EXIT
                         (SEQ (LETT |i| 1) (LETT #2# N) G190
                              (COND ((|greater_SI| |i| #2#) (GO G191)))
                              (SEQ
                               (EXIT
                                (SPADCALL |v1| |i|
                                          (SPADCALL
                                           (SPADCALL |v1| |i| (QREFELT $ 18))
                                           (SPADCALL
                                            (SPADCALL |mu| |k| |j|
                                                      (QREFELT $ 20))
                                            (SPADCALL |v2| |i| (QREFELT $ 18))
                                            (QREFELT $ 21))
                                           (QREFELT $ 22))
                                          (QREFELT $ 15))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| 1) (LETT #1# N) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |bsm| |k| |i| (SPADCALL |v1| |i| (QREFELT $ 18))
                               (QREFELT $ 10))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |nbs| |k| (SPADCALL |v1| |v1| (QREFELT $ 17))
                         (QREFELT $ 15)))))) 

(SDEFUN |LLLRED;extendedLLL!;MNniM;2|
        ((L (|Matrix| (|Integer|))) (N (|NonNegativeInteger|))
         ($ (|Matrix| (|Integer|))))
        (SPROG
         ((|k| (|NonNegativeInteger|)) (|tmp| (|Float|)) (#1=#:G756 NIL)
          (|i| NIL) (#2=#:G755 NIL) (|v2i| #3=(|Float|)) (|v1i| #4=(|Float|))
          (#5=#:G754 NIL) (|m| #6=(|Float|)) (|nv2| #6#) (|nv1| #4#)
          (|k1| (|Integer|)) (|del1| #3#) (#7=#:G753 NIL) (#8=#:G752 NIL)
          (|q| (|Integer|)) (|j| NIL) (|kmax| (|Integer|))
          (|iters| (|Integer|)) (#9=#:G751 NIL) (|v1| #10=(|Vector| (|Float|)))
          (|delta| (|Float|)) (|bm| (|Matrix| (|Integer|)))
          (|mu| #11=(|Matrix| (|Float|))) (|nbs| #10#) (|bsm| #11#)
          (|cols| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (ANROWS L)) (LETT |cols| (ANCOLS L))
              (LETT |bsm| (MAKE_MATRIX1 |n| N (|spadConstant| $ 23)))
              (LETT |nbs| (MAKEARR1 |n| (|spadConstant| $ 23)))
              (LETT |mu| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 23)))
              (LETT |bm| L) (LETT |delta| (SPADCALL 8 -1 10 (QREFELT $ 25)))
              (LETT |v1| (MAKEARR1 N (|spadConstant| $ 23)))
              (SEQ (LETT |k| 1) (LETT #9# |n|) G190
                   (COND ((|greater_SI| |k| #9#) (GO G191)))
                   (SEQ
                    (EXIT
                     (|LLLRED;gram_step| |k| N |bm| |bsm| |mu| |nbs| |v1| $)))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (LETT |kmax| |n|) (LETT |k| 2) (LETT |iters| 0)
              (SEQ G190 (COND ((NULL (<= |k| |n|)) (GO G191)))
                   (SEQ (LETT |iters| (+ |iters| 1))
                        (COND
                         ((> |k| |kmax|)
                          (SEQ
                           (|LLLRED;gram_step| |k| N |bm| |bsm| |mu| |nbs| |v1|
                            $)
                           (EXIT (LETT |kmax| |k|)))))
                        (SEQ (LETT |j| (- |k| 1)) G190
                             (COND ((< |j| 1) (GO G191)))
                             (SEQ
                              (LETT |q|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |mu| |k| |j| (QREFELT $ 20))
                                      (QREFELT $ 26))
                                     (QREFELT $ 27)))
                              (EXIT
                               (COND
                                ((SPADCALL |q| 0 (QREFELT $ 29))
                                 (SEQ
                                  (SEQ (LETT |i| 1) (LETT #8# |cols|) G190
                                       (COND
                                        ((|greater_SI| |i| #8#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SPADCALL |bm| |k| |i|
                                                   (-
                                                    (SPADCALL |bm| |k| |i|
                                                              (QREFELT $ 12))
                                                    (* |q|
                                                       (SPADCALL |bm| |j| |i|
                                                                 (QREFELT $
                                                                          12))))
                                                   (QREFELT $ 30))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT
                                   (SEQ (LETT |i| 1) (LETT #7# |j|) G190
                                        (COND
                                         ((|greater_SI| |i| #7#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (SPADCALL |mu| |k| |i|
                                                    (SPADCALL
                                                     (SPADCALL |mu| |k| |i|
                                                               (QREFELT $ 20))
                                                     (SPADCALL |q|
                                                               (SPADCALL |mu|
                                                                         |j|
                                                                         |i|
                                                                         (QREFELT
                                                                          $
                                                                          20))
                                                               (QREFELT $ 31))
                                                     (QREFELT $ 22))
                                                    (QREFELT $ 10))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))))))))
                             (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
                        (LETT |del1|
                              (SPADCALL |delta|
                                        (SPADCALL
                                         (SPADCALL |mu| |k| (- |k| 1)
                                                   (QREFELT $ 20))
                                         2 (QREFELT $ 32))
                                        (QREFELT $ 22)))
                        (EXIT
                         (COND
                          ((SPADCALL
                            (SPADCALL |del1|
                                      (SPADCALL |nbs| (- |k| 1) (QREFELT $ 18))
                                      (QREFELT $ 21))
                            (SPADCALL |nbs| |k| (QREFELT $ 18)) (QREFELT $ 33))
                           (LETT |k| (+ |k| 1)))
                          ('T
                           (SEQ (LETT |k1| (- |k| 1))
                                (LETT |nv1|
                                      (SPADCALL
                                       (SPADCALL |nbs| |k| (QREFELT $ 18))
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |mu| |k| |k1|
                                                   (QREFELT $ 20))
                                         2 (QREFELT $ 32))
                                        (SPADCALL |nbs| |k1| (QREFELT $ 18))
                                        (QREFELT $ 21))
                                       (QREFELT $ 34)))
                                (LETT |nv2|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |nbs| |k| (QREFELT $ 18))
                                        (SPADCALL |nbs| |k1| (QREFELT $ 18))
                                        (QREFELT $ 21))
                                       |nv1| (QREFELT $ 19)))
                                (LETT |m|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |mu| |k| |k1| (QREFELT $ 20))
                                        (SPADCALL |nbs| |k1| (QREFELT $ 18))
                                        (QREFELT $ 21))
                                       |nv1| (QREFELT $ 19)))
                                (SPADCALL |bm| |k| |k1| (QREFELT $ 35))
                                (SEQ (LETT |i| 1) (LETT #5# N) G190
                                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                                     (SEQ
                                      (LETT |v1i|
                                            (SPADCALL
                                             (SPADCALL |bsm| |k| |i|
                                                       (QREFELT $ 20))
                                             (SPADCALL
                                              (SPADCALL |mu| |k| |k1|
                                                        (QREFELT $ 20))
                                              (SPADCALL |bsm| |k1| |i|
                                                        (QREFELT $ 20))
                                              (QREFELT $ 21))
                                             (QREFELT $ 34)))
                                      (LETT |v2i|
                                            (SPADCALL
                                             (SPADCALL |bsm| |k1| |i|
                                                       (QREFELT $ 20))
                                             (SPADCALL |m| |v1i|
                                                       (QREFELT $ 21))
                                             (QREFELT $ 22)))
                                      (SPADCALL |bsm| |k1| |i| |v1i|
                                                (QREFELT $ 10))
                                      (EXIT
                                       (SPADCALL |bsm| |k| |i| |v2i|
                                                 (QREFELT $ 10))))
                                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                     (EXIT NIL))
                                (SEQ (LETT |i| 1) (LETT #2# (- |k1| 1)) G190
                                     (COND ((|greater_SI| |i| #2#) (GO G191)))
                                     (SEQ
                                      (LETT |tmp|
                                            (SPADCALL |mu| |k| |i|
                                                      (QREFELT $ 20)))
                                      (SPADCALL |mu| |k| |i|
                                                (SPADCALL |mu| |k1| |i|
                                                          (QREFELT $ 20))
                                                (QREFELT $ 10))
                                      (EXIT
                                       (SPADCALL |mu| |k1| |i| |tmp|
                                                 (QREFELT $ 10))))
                                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                     (EXIT NIL))
                                (SEQ (LETT |i| (+ |k| 1)) (LETT #1# |kmax|)
                                     G190 (COND ((> |i| #1#) (GO G191)))
                                     (SEQ
                                      (LETT |tmp|
                                            (SPADCALL |mu| |i| |k|
                                                      (QREFELT $ 20)))
                                      (SPADCALL |mu| |i| |k|
                                                (SPADCALL
                                                 (SPADCALL |mu| |i| |k1|
                                                           (QREFELT $ 20))
                                                 (SPADCALL
                                                  (SPADCALL |mu| |k| |k1|
                                                            (QREFELT $ 20))
                                                  (SPADCALL |mu| |i| |k|
                                                            (QREFELT $ 20))
                                                  (QREFELT $ 21))
                                                 (QREFELT $ 22))
                                                (QREFELT $ 10))
                                      (EXIT
                                       (SPADCALL |mu| |i| |k1|
                                                 (SPADCALL |tmp|
                                                           (SPADCALL |m|
                                                                     (SPADCALL
                                                                      |mu| |i|
                                                                      |k|
                                                                      (QREFELT
                                                                       $ 20))
                                                                     (QREFELT $
                                                                              21))
                                                           (QREFELT $ 34))
                                                 (QREFELT $ 10))))
                                     (LETT |i| (+ |i| 1)) (GO G190) G191
                                     (EXIT NIL))
                                (SPADCALL |mu| |k| |k1| |m| (QREFELT $ 10))
                                (SPADCALL |nbs| |k1| |nv1| (QREFELT $ 15))
                                (SPADCALL |nbs| |k| |nv2| (QREFELT $ 15))
                                (EXIT (LETT |k| (MAX 2 |k1|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |bm|)))) 

(SDEFUN |LLLRED;extendedLLL;MR;3|
        ((L (|Matrix| (|Integer|)))
         ($
          (|Record| (|:| |lll| (|Matrix| (|Integer|)))
                    (|:| |trf| (|Matrix| (|Integer|))))))
        (SPROG
         ((#1=#:G777 NIL) (|j| NIL) (#2=#:G776 NIL) (#3=#:G775 NIL) (|i| NIL)
          (|t| #4=(|Matrix| (|Integer|))) (|l| #4#)
          (|m| (|Matrix| (|Integer|))) (#5=#:G774 NIL) (#6=#:G773 NIL) (LE #4#)
          (|cols| (|NonNegativeInteger|)) (N (|NonNegativeInteger|))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (ANROWS L)) (LETT N (ANCOLS L)) (LETT |cols| (+ N |n|))
              (LETT LE (MAKE_MATRIX1 |n| |cols| 0))
              (SEQ (LETT |i| 1) (LETT #6# |n|) G190
                   (COND ((|greater_SI| |i| #6#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #5# N) G190
                         (COND ((|greater_SI| |j| #5#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF2O LE |i| |j| (QAREF2O L |i| |j| 1 1) 1
                                       1)))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (QSETAREF2O LE |i| (+ N |i|) 1 1 1)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |m| (SPADCALL LE N (QREFELT $ 37)))
              (LETT |l| (MAKE_MATRIX1 |n| N 0))
              (LETT |t| (MAKE_MATRIX1 |n| |n| 0))
              (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #2# N) G190
                         (COND ((|greater_SI| |j| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF2O |l| |i| |j| (QAREF2O |m| |i| |j| 1 1) 1
                                       1)))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (QSETAREF2O |t| |i| |j|
                                        (QAREF2O |m| |i| (+ |j| N) 1 1) 1 1)))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |l| |t|))))) 

(SDEFUN |LLLRED;LLL;2M;4|
        ((L (|Matrix| (|Integer|))) ($ (|Matrix| (|Integer|))))
        (SPADCALL (SPADCALL L (QREFELT $ 40)) (ANCOLS L) (QREFELT $ 37))) 

(SDEFUN |LLLRED;find_relation;LNniL;5|
        ((|la| (|List| (|Float|))) (|k| (|NonNegativeInteger|))
         ($ (|List| (|Integer|))))
        (SPROG
         ((#1=#:G789 NIL) (|i| NIL) (#2=#:G788 NIL)
          (|res| (|Matrix| (|Integer|))) (#3=#:G786 NIL) (#4=#:G787 NIL)
          (|a| NIL) (|tenk| (|NonNegativeInteger|))
          (|m| (|Matrix| (|Integer|))) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |la|))
              (LETT |m| (MAKE_MATRIX1 |n| (+ |n| 1) 0))
              (LETT |tenk| (EXPT 10 |k|))
              (SEQ (LETT |a| NIL) (LETT #4# |la|) (LETT |i| 1) (LETT #3# |n|)
                   G190
                   (COND
                    ((OR (|greater_SI| |i| #3#) (ATOM #4#)
                         (PROGN (LETT |a| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (SPADCALL |m| |i| |i| 1 (QREFELT $ 30))
                        (EXIT
                         (SPADCALL |m| |i| (+ |n| 1)
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL |tenk| |a| (QREFELT $ 42))
                                     (QREFELT $ 26))
                                    (QREFELT $ 27))
                                   (QREFELT $ 30))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #4# (CDR #4#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |res| (SPADCALL |m| (QREFELT $ 41)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS (SPADCALL |res| 1 |i| (QREFELT $ 12))
                                   #2#))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |LLLReduction;|)) 

(DEFUN |LLLReduction| ()
  (SPROG NIL
         (PROG (#1=#:G791)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|LLLReduction|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|LLLReduction|
                             (LIST (CONS NIL (CONS 1 (|LLLReduction;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|LLLReduction|)))))))))) 

(DEFUN |LLLReduction;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|LLLReduction|))
          (LETT $ (GETREFV 46))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LLLReduction| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LLLReduction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Float|) (0 . |One|) (|Integer|)
              (|Matrix| 6) (4 . |setelt!|) (|Matrix| 8) (12 . |elt|)
              (19 . |coerce|) (|Vector| 6) (24 . |setelt!|) (31 . |row|)
              (37 . |dot|) (43 . |elt|) (49 . /) (55 . |elt|) (62 . *) (68 . -)
              (74 . |Zero|) (|PositiveInteger|) (78 . |float|) (85 . |round|)
              (90 . |retract|) (|Boolean|) (95 . ~=) (101 . |setelt!|)
              (109 . *) (115 . ^) (121 . <=) (127 . +) (133 . |swapRows!|)
              (|NonNegativeInteger|) |LLLRED;extendedLLL!;MNniM;2|
              (|Record| (|:| |lll| 11) (|:| |trf| 11))
              |LLLRED;extendedLLL;MR;3| (140 . |copy|) |LLLRED;LLL;2M;4|
              (145 . *) (|List| 8) (|List| 6) |LLLRED;find_relation;LNniL;5|)
           '#(|find_relation| 151 |extendedLLL!| 157 |extendedLLL| 163 LLL 168)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((LLL
                                 ((|Matrix| (|Integer|))
                                  (|Matrix| (|Integer|))))
                                T)
                              '((|extendedLLL!|
                                 ((|Matrix| (|Integer|)) (|Matrix| (|Integer|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|extendedLLL|
                                 ((|Record| (|:| |lll| (|Matrix| (|Integer|)))
                                            (|:| |trf| (|Matrix| (|Integer|))))
                                  (|Matrix| (|Integer|))))
                                T)
                              '((|find_relation|
                                 ((|List| (|Integer|)) (|List| (|Float|))
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 45
                                            '(0 6 0 7 4 9 6 0 8 8 6 10 3 11 8 0
                                              8 8 12 1 6 0 8 13 3 14 6 0 8 6 15
                                              2 9 14 0 8 16 2 14 6 0 0 17 2 14
                                              6 0 8 18 2 6 0 0 0 19 3 9 6 0 8 8
                                              20 2 6 0 0 0 21 2 6 0 0 0 22 0 6
                                              0 23 3 6 0 8 8 24 25 1 6 0 0 26 1
                                              6 8 0 27 2 8 28 0 0 29 4 11 8 0 8
                                              8 8 30 2 6 0 8 0 31 2 6 0 0 8 32
                                              2 6 28 0 0 33 2 6 0 0 0 34 3 11 0
                                              0 8 8 35 1 11 0 0 40 2 6 0 36 0
                                              42 2 0 43 44 36 45 2 0 11 11 36
                                              37 1 0 38 11 39 1 0 11 11 41)))))
           '|lookupComplete|)) 

(MAKEPROP '|LLLReduction| 'NILADIC T) 
