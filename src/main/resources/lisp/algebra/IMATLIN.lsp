
(SDEFUN |IMATLIN;rowAllZeroes?| ((|x| (M)) (|i| (|Integer|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G717 NIL) (#2=#:G718 NIL) (#3=#:G719 NIL) (|j| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 11)))
                         (LETT #3# (SPADCALL |x| (QREFELT $ 12))) G190
                         (COND ((> |j| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                       (|spadConstant| $ 14) (QREFELT $ 16))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G716)))
                              (GO #5=#:G714))))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |IMATLIN;colAllZeroes?| ((|x| (M)) (|j| (|Integer|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G725 NIL) (#2=#:G726 NIL) (#3=#:G727 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                         (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                       (|spadConstant| $ 14) (QREFELT $ 16))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G724)))
                              (GO #5=#:G722))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |IMATLIN;row_operation_base;M4IRV;3|
        ((|x| (M)) (|i| (|Integer|)) (|j| (|Integer|)) (|k| (|Integer|))
         (|maxC| (|Integer|)) (|pp| (R)) ($ (|Void|)))
        (SPROG ((#1=#:G732 NIL) (|k1| NIL))
               (SEQ (LETT |k1| |j|) (LETT #1# |maxC|) G190
                    (COND ((> |k1| #1#) (GO G191)))
                    (SEQ
                     (EXIT
                      (QSETAREF2O |x| |k| |k1|
                                  (SPADCALL (QAREF2O |x| |k| |k1| 1 1)
                                            (SPADCALL |pp|
                                                      (QAREF2O |x| |i| |k1| 1
                                                               1)
                                                      (QREFELT $ 19))
                                            (QREFELT $ 20))
                                  1 1)))
                    (LETT |k1| (+ |k1| 1)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |IMATLIN;row_operation_modular;M4IRIV;4|
        ((|x| (M)) (|i| (|Integer|)) (|j| (|Integer|)) (|k| (|Integer|))
         (|maxC| (|Integer|)) (|pp| (R)) (|p| (|Integer|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G737 NIL) (|k1| NIL) (|ms| #2=(|SingleInteger|)) (|js| #2#)
          (|pp1| (|Integer|)))
         (SEQ (LETT |pp1| (- |p| |pp|)) (LETT |js| |j|) (LETT |ms| |maxC|)
              (EXIT
               (SEQ (LETT |k1| |js|) (LETT #1# |ms|) G190
                    (COND ((|greater_SI| |k1| #1#) (GO G191)))
                    (SEQ
                     (EXIT
                      (QSETAREF2O |x| |k| |k1|
                                  (QSMULADDMOD64_32 |pp1|
                                                    (QAREF2O |x| |i| |k1| 1 1)
                                                    (QAREF2O |x| |k| |k1| 1 1)
                                                    |p|)
                                  1 1)))
                    (LETT |k1| (|inc_SI| |k1|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |IMATLIN;rowEchelon;2M;5| ((|y| (M)) ($ (M)))
        (SPROG
         ((|i| #1=(|Integer|)) (|pp| (R)) (#2=#:G782 NIL) (|k| NIL)
          (#3=#:G781 NIL) (|b| (R)) (#4=#:G777 NIL) (|n| (|Integer|))
          (#5=#:G780 NIL) (#6=#:G778 NIL) (#7=#:G779 NIL) (|j| NIL)
          (|maxC| (|Integer|)) (|minC| (|Integer|)) (|maxR| (|Integer|))
          (|minR| #1#) (|x| (M))
          (|row_op|
           (|Mapping| (|Void|) M (|Integer|) (|Integer|) (|Integer|)
                      (|Integer|) R))
          (#8=#:G749 NIL) (|cc| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |row_op|
                  (SEQ (LETT |cc| (SPADCALL (QREFELT $ 25)))
                       (COND
                        ((SPADCALL |cc| (|spadConstant| $ 26) (QREFELT $ 27))
                         (COND
                          ((SPADCALL |cc| 1000000000 (QREFELT $ 28))
                           (COND
                            ((|domainEqual| (QREFELT $ 6)
                                            (|PrimeField|
                                             (PROG1 (LETT #8# |cc|)
                                               (|check_subtype2| (> #8# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|NonNegativeInteger|)
                                                                 #8#))))
                             (EXIT
                              (CONS #'|IMATLIN;rowEchelon;2M;5!0|
                                    (VECTOR $ |cc|)))))))))
                       (EXIT (ELT $ 22))))
            (LETT |x| (SPADCALL |y| (QREFELT $ 29)))
            (LETT |minR| (PROGN |x| 1))
            (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
            (LETT |minC| (PROGN |x| 1))
            (LETT |maxC| (SPADCALL |x| (QREFELT $ 12))) (LETT |i| |minR|)
            (LETT |n| (- |minR| 1))
            (SEQ (LETT |j| |minC|) (LETT #7# |maxC|) G190
                 (COND ((> |j| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND ((> |i| |maxR|) (PROGN (LETT #6# |x|) (GO #9=#:G776)))
                         ('T
                          (SEQ (LETT |n| (- |minR| 1))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |k| |i|) (LETT #5# |maxR|) G190
                                      (COND ((> |k| #5#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                                    (|spadConstant| $ 14)
                                                    (QREFELT $ 16))
                                          (SEQ (LETT |n| |k|)
                                               (EXIT
                                                (PROGN
                                                 (LETT #4# 1)
                                                 (GO #10=#:G763))))))))
                                      (LETT |k| (+ |k| 1)) (GO G190) G191
                                      (EXIT NIL)))
                                #10# (EXIT #4#))
                               (EXIT
                                (COND ((EQL |n| (- |minR| 1)) "no non-zeroes")
                                      ('T
                                       (SEQ
                                        (COND
                                         ((SPADCALL |i| |n| (QREFELT $ 31))
                                          (SPADCALL |x| |i| |n|
                                                    (QREFELT $ 32))))
                                        (LETT |b|
                                              (SPADCALL
                                               (QAREF2O |x| |i| |j| 1 1)
                                               (QREFELT $ 33)))
                                        (QSETAREF2O |x| |i| |j|
                                                    (|spadConstant| $ 30) 1 1)
                                        (SEQ (LETT |k| (+ |j| 1))
                                             (LETT #3# |maxC|) G190
                                             (COND ((> |k| #3#) (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (QSETAREF2O |x| |i| |k|
                                                           (SPADCALL |b|
                                                                     (QAREF2O
                                                                      |x| |i|
                                                                      |k| 1 1)
                                                                     (QREFELT $
                                                                              19))
                                                           1 1)))
                                             (LETT |k| (+ |k| 1)) (GO G190)
                                             G191 (EXIT NIL))
                                        (SEQ (LETT |k| |minR|)
                                             (LETT #2# |maxR|) G190
                                             (COND ((> |k| #2#) (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((SPADCALL |k| |i|
                                                           (QREFELT $ 31))
                                                 (SEQ
                                                  (LETT |pp|
                                                        (QAREF2O |x| |k| |j| 1
                                                                 1))
                                                  (EXIT
                                                   (COND
                                                    ((NULL
                                                      (SPADCALL |pp|
                                                                (|spadConstant|
                                                                 $ 14)
                                                                (QREFELT $
                                                                         34)))
                                                     (SEQ
                                                      (SPADCALL |x| |i|
                                                                (+ |j| 1) |k|
                                                                |maxC| |pp|
                                                                |row_op|)
                                                      (EXIT
                                                       (QSETAREF2O |x| |k| |j|
                                                                   (|spadConstant|
                                                                    $ 14)
                                                                   1
                                                                   1)))))))))))
                                             (LETT |k| (+ |k| 1)) (GO G190)
                                             G191 (EXIT NIL))
                                        (EXIT (LETT |i| (+ |i| 1))))))))))))
                 (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT |x|)))
          #9# (EXIT #6#)))) 

(SDEFUN |IMATLIN;rowEchelon;2M;5!0|
        ((|x| NIL) (|i| NIL) (|j| NIL) (|k| NIL) (|maxC| NIL) (|pp| NIL)
         ($$ NIL))
        (PROG (|cc| $)
          (LETT |cc| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (SPADCALL |x| |i| |j| |k| |maxC| |pp| |cc| (QREFELT $ 23)))))) 

(SDEFUN |IMATLIN;nullSpace;ML;6| ((|y| (M)) ($ (|List| |Col|)))
        (SPROG
         ((|l| (|Integer|)) (|j| #1=(|Integer|)) (|basis| (|List| |Col|))
          (#2=#:G816 NIL) (|k| NIL) (#3=#:G817 NIL) (|ll| NIL) (|w| (|Col|))
          (#4=#:G815 NIL) (|i| NIL)
          (|v| (|IndexedOneDimensionalArray| (|Integer|) |minC|))
          (#5=#:G814 NIL) (|row| #6=(|Integer|)) (#7=#:G789 NIL)
          (|rk| #8=(|NonNegativeInteger|)) (#9=#:G788 NIL)
          (|ncol| (|NonNegativeInteger|)) (|nrow| #8#) (|maxC| #1#)
          (|minC| (|Integer|)) (|maxR| #6#) (|minR| (|Integer|)) (|x| (M)))
         (SEQ (LETT |x| (SPADCALL |y| (QREFELT $ 35)))
              (LETT |minR| (PROGN |x| 1))
              (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
              (LETT |minC| (PROGN |x| 1))
              (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
              (LETT |nrow| (ANROWS |x|)) (LETT |ncol| (ANCOLS |x|))
              (LETT |basis| NIL) (LETT |rk| |nrow|) (LETT |row| |maxR|)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND ((> |rk| 0) (|IMATLIN;rowAllZeroes?| |x| |row| $))
                            ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (LETT |rk|
                          (PROG1 (LETT #9# (- |rk| 1))
                            (|check_subtype2| (>= #9# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #9#)))
                    (EXIT
                     (LETT |row|
                           (PROG1 (LETT #7# (- |row| 1))
                             (|check_subtype2| (>= #7# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #7#)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND ((<= |ncol| |nrow|) (COND ((EQL |rk| |ncol|) (EXIT NIL)))))
              (EXIT
               (COND
                ((EQL |rk| 0)
                 (SEQ
                  (SEQ (LETT |j| |minC|) (LETT #5# |maxC|) G190
                       (COND ((> |j| #5#) (GO G191)))
                       (SEQ
                        (LETT |w|
                              (SPADCALL |ncol| (|spadConstant| $ 14)
                                        (QREFELT $ 36)))
                        (SPADCALL |w| |j| (|spadConstant| $ 30) (QREFELT $ 37))
                        (EXIT (LETT |basis| (CONS |w| |basis|))))
                       (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                  (EXIT |basis|)))
                ('T
                 (SEQ
                  (LETT |v|
                        (SPADCALL |ncol| (- |minR| 1)
                                  (|compiledLookupCheck| '|new|
                                                         (LIST '$
                                                               (LIST
                                                                '|NonNegativeInteger|)
                                                               (LIST
                                                                '|Integer|))
                                                         (|IndexedOneDimensionalArray|
                                                          (|Integer|)
                                                          |minC|))))
                  (SEQ (LETT |i| |minR|) (LETT #4# (- (+ |minR| |rk|) 1)) G190
                       (COND ((> |i| #4#) (GO G191)))
                       (SEQ
                        (SEQ (LETT |j| |minC|) G190
                             (COND
                              ((NULL
                                (SPADCALL (QAREF2O |x| |i| |j| 1 1)
                                          (|spadConstant| $ 14)
                                          (QREFELT $ 34)))
                               (GO G191)))
                             (SEQ (EXIT |j|)) (LETT |j| (+ |j| 1)) (GO G190)
                             G191 (EXIT NIL))
                        (EXIT
                         (SPADCALL |v| |j| |i|
                                   (|compiledLookupCheck| '|qsetelt!|
                                                          (LIST
                                                           (LIST '|Integer|) '$
                                                           (LIST '|Integer|)
                                                           (LIST '|Integer|))
                                                          (|IndexedOneDimensionalArray|
                                                           (|Integer|)
                                                           |minC|)))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (LETT |j| |maxC|) (LETT |l| (- (+ |minR| |ncol|) 1))
                  (SEQ G190 (COND ((NULL (>= |j| |minC|)) (GO G191)))
                       (SEQ
                        (LETT |w|
                              (SPADCALL |ncol| (|spadConstant| $ 14)
                                        (QREFELT $ 36)))
                        (COND
                         ((EQL
                           (SPADCALL |v| |j|
                                     (|compiledLookupCheck| '|qelt|
                                                            (LIST
                                                             (LIST '|Integer|)
                                                             '$
                                                             (LIST '|Integer|))
                                                            (|IndexedOneDimensionalArray|
                                                             (|Integer|)
                                                             |minC|)))
                           (- |minR| 1))
                          (COND
                           ((|IMATLIN;colAllZeroes?| |x| |j| $)
                            (SEQ
                             (SPADCALL |w| |l| (|spadConstant| $ 30)
                                       (QREFELT $ 37))
                             (EXIT (LETT |basis| (CONS |w| |basis|)))))
                           ('T
                            (SEQ
                             (SEQ (LETT |ll| |minR|) (LETT #3# (- |l| 1))
                                  (LETT |k| |minC|) (LETT #2# (- |j| 1)) G190
                                  (COND
                                   ((OR (> |k| #2#) (> |ll| #3#)) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |v| |k|
                                                 (|compiledLookupCheck| '|qelt|
                                                                        (LIST
                                                                         (LIST
                                                                          '|Integer|)
                                                                         '$
                                                                         (LIST
                                                                          '|Integer|))
                                                                        (|IndexedOneDimensionalArray|
                                                                         (|Integer|)
                                                                         |minC|)))
                                       (- |minR| 1) (QREFELT $ 31))
                                      (SPADCALL |w| |ll|
                                                (SPADCALL
                                                 (QAREF2O |x|
                                                          (SPADCALL |v| |k|
                                                                    (|compiledLookupCheck|
                                                                     '|qelt|
                                                                     (LIST
                                                                      (LIST
                                                                       '|Integer|)
                                                                      '$
                                                                      (LIST
                                                                       '|Integer|))
                                                                     (|IndexedOneDimensionalArray|
                                                                      (|Integer|)
                                                                      |minC|)))
                                                          |j| 1 1)
                                                 (QREFELT $ 38))
                                                (QREFELT $ 37))))))
                                  (LETT |k|
                                        (PROG1 (+ |k| 1)
                                          (LETT |ll| (+ |ll| 1))))
                                  (GO G190) G191 (EXIT NIL))
                             (SPADCALL |w| |l| (|spadConstant| $ 30)
                                       (QREFELT $ 37))
                             (EXIT (LETT |basis| (CONS |w| |basis|))))))))
                        (LETT |j| (- |j| 1)) (EXIT (LETT |l| (- |l| 1))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT |basis|)))))))) 

(SDEFUN |IMATLIN;determinant;MR;7| ((|y| (M)) ($ (R)))
        (SPROG
         ((#1=#:G845 NIL) (|l| NIL) (|b| (R)) (#2=#:G844 NIL) (|k| NIL)
          (#3=#:G843 NIL) (|ans| (R)) (#4=#:G839 NIL) (#5=#:G838 NIL)
          (|rown| (|Integer|)) (#6=#:G842 NIL) (#7=#:G840 NIL) (|i| NIL)
          (#8=#:G841 NIL) (|j| NIL) (|maxC| (|Integer|)) (|minC| (|Integer|))
          (|maxR| (|Integer|)) (|minR| (|Integer|)) (|x| (M))
          (|ndim| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |ndim| (ANROWS |y|)) (ANCOLS |y|) (QREFELT $ 41))
             (|error| "determinant: matrix must be square"))
            ((EQL |ndim| 0) (|spadConstant| $ 30))
            ((EQL |ndim| 1) (QAREF2O |y| (PROGN |y| 1) (PROGN |y| 1) 1 1))
            ('T
             (SEQ (LETT |x| (SPADCALL |y| (QREFELT $ 29)))
                  (LETT |minR| (PROGN |x| 1))
                  (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
                  (LETT |minC| (PROGN |x| 1))
                  (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
                  (LETT |ans| (|spadConstant| $ 30))
                  (SEQ (LETT |j| |minC|) (LETT #8# (- |maxC| 1))
                       (LETT |i| |minR|) (LETT #7# (- |maxR| 1)) G190
                       (COND ((OR (> |i| #7#) (> |j| #8#)) (GO G191)))
                       (SEQ
                        (COND
                         ((SPADCALL (QAREF2O |x| |i| |j| 1 1)
                                    (|spadConstant| $ 14) (QREFELT $ 34))
                          (SEQ (LETT |rown| (- |minR| 1))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |k| (+ |i| 1)) (LETT #6# |maxR|)
                                      G190 (COND ((> |k| #6#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                                    (|spadConstant| $ 14)
                                                    (QREFELT $ 16))
                                          (PROGN
                                           (LETT #5#
                                                 (SEQ (LETT |rown| |k|)
                                                      (EXIT
                                                       (PROGN
                                                        (LETT #5# 1)
                                                        (GO #9=#:G822)))))
                                           (GO #9#))))))
                                      (LETT |k| (+ |k| 1)) (GO G190) G191
                                      (EXIT NIL)))
                                #9# (EXIT #5#))
                               (COND
                                ((EQL |rown| (- |minR| 1))
                                 (PROGN
                                  (LETT #4# (|spadConstant| $ 14))
                                  (GO #10=#:G837))))
                               (SPADCALL |x| |i| |rown| (QREFELT $ 32))
                               (EXIT
                                (LETT |ans|
                                      (SPADCALL |ans| (QREFELT $ 38)))))))
                        (LETT |ans|
                              (SPADCALL (QAREF2O |x| |i| |j| 1 1) |ans|
                                        (QREFELT $ 19)))
                        (LETT |b|
                              (SPADCALL
                               (SPADCALL (QAREF2O |x| |i| |j| 1 1)
                                         (QREFELT $ 33))
                               (QREFELT $ 38)))
                        (SEQ (LETT |l| (+ |j| 1)) (LETT #3# |maxC|) G190
                             (COND ((> |l| #3#) (GO G191)))
                             (SEQ
                              (EXIT
                               (QSETAREF2O |x| |i| |l|
                                           (SPADCALL |b|
                                                     (QAREF2O |x| |i| |l| 1 1)
                                                     (QREFELT $ 19))
                                           1 1)))
                             (LETT |l| (+ |l| 1)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (SEQ (LETT |k| (+ |i| 1)) (LETT #2# |maxR|) G190
                              (COND ((> |k| #2#) (GO G191)))
                              (SEQ (LETT |b| (QAREF2O |x| |k| |j| 1 1))
                                   (EXIT
                                    (COND
                                     ((NULL
                                       (SPADCALL |b| (|spadConstant| $ 14)
                                                 (QREFELT $ 34)))
                                      (SEQ (LETT |l| (+ |j| 1))
                                           (LETT #1# |maxC|) G190
                                           (COND ((> |l| #1#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (QSETAREF2O |x| |k| |l|
                                                         (SPADCALL
                                                          (QAREF2O |x| |k| |l|
                                                                   1 1)
                                                          (SPADCALL |b|
                                                                    (QAREF2O
                                                                     |x| |i|
                                                                     |l| 1 1)
                                                                    (QREFELT $
                                                                             19))
                                                          (QREFELT $ 42))
                                                         1 1)))
                                           (LETT |l| (+ |l| 1)) (GO G190) G191
                                           (EXIT NIL))))))
                              (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))))
                       (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                       (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SPADCALL (QAREF2O |x| |maxR| |maxC| 1 1) |ans|
                             (QREFELT $ 19)))))))
          #10# (EXIT #4#)))) 

(SDEFUN |IMATLIN;row_operation_base;M4IRV;8|
        ((|x| (M)) (|i| (|Integer|)) (|j| (|Integer|)) (|k| (|Integer|))
         (|maxC| (|Integer|)) (|pp| (R)) ($ (|Void|)))
        (SPROG ((#1=#:G849 NIL) (|k1| NIL))
               (SEQ (LETT |k1| |j|) (LETT #1# |maxC|) G190
                    (COND ((> |k1| #1#) (GO G191)))
                    (SEQ
                     (EXIT
                      (SPADCALL |x| |k| |k1|
                                (SPADCALL
                                 (SPADCALL |x| |k| |k1| (QREFELT $ 13))
                                 (SPADCALL |pp|
                                           (SPADCALL |x| |i| |k1|
                                                     (QREFELT $ 13))
                                           (QREFELT $ 19))
                                 (QREFELT $ 20))
                                (QREFELT $ 44))))
                    (LETT |k1| (+ |k1| 1)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |IMATLIN;row_operation_modular;M4IRIV;9|
        ((|x| (M)) (|i| (|Integer|)) (|j| (|Integer|)) (|k| (|Integer|))
         (|maxC| (|Integer|)) (|pp| (R)) (|p| (|Integer|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G854 NIL) (|k1| NIL) (|ms| #2=(|SingleInteger|)) (|js| #2#)
          (|pp1| (|Integer|)))
         (SEQ (LETT |pp1| (- |p| |pp|)) (LETT |js| |j|) (LETT |ms| |maxC|)
              (EXIT
               (SEQ (LETT |k1| |js|) (LETT #1# |ms|) G190
                    (COND ((|greater_SI| |k1| #1#) (GO G191)))
                    (SEQ
                     (EXIT
                      (SPADCALL |x| |k| |k1|
                                (QSMULADDMOD64_32 |pp1|
                                                  (SPADCALL |x| |i| |k1|
                                                            (QREFELT $ 13))
                                                  (SPADCALL |x| |k| |k1|
                                                            (QREFELT $ 13))
                                                  |p|)
                                (QREFELT $ 44))))
                    (LETT |k1| (|inc_SI| |k1|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |IMATLIN;rowEchelon;2M;10| ((|y| (M)) ($ (M)))
        (SPROG
         ((|i| #1=(|Integer|)) (|pp| (R)) (#2=#:G894 NIL) (|k| NIL)
          (#3=#:G893 NIL) (|b| (R)) (#4=#:G889 NIL) (|n| (|Integer|))
          (#5=#:G892 NIL) (#6=#:G890 NIL) (#7=#:G891 NIL) (|j| NIL)
          (|maxC| (|Integer|)) (|minC| (|Integer|)) (|maxR| (|Integer|))
          (|minR| #1#) (|x| (M))
          (|row_op|
           (|Mapping| (|Void|) M (|Integer|) (|Integer|) (|Integer|)
                      (|Integer|) R))
          (#8=#:G861 NIL) (|cc| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |row_op|
                  (SEQ (LETT |cc| (SPADCALL (QREFELT $ 25)))
                       (COND
                        ((SPADCALL |cc| (|spadConstant| $ 26) (QREFELT $ 27))
                         (COND
                          ((SPADCALL |cc| 1000000000 (QREFELT $ 28))
                           (COND
                            ((|domainEqual| (QREFELT $ 6)
                                            (|PrimeField|
                                             (PROG1 (LETT #8# |cc|)
                                               (|check_subtype2| (> #8# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|NonNegativeInteger|)
                                                                 #8#))))
                             (EXIT
                              (CONS #'|IMATLIN;rowEchelon;2M;10!0|
                                    (VECTOR $ |cc|)))))))))
                       (EXIT (ELT $ 22))))
            (LETT |x| (SPADCALL |y| (QREFELT $ 29)))
            (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
            (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
            (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
            (LETT |maxC| (SPADCALL |x| (QREFELT $ 12))) (LETT |i| |minR|)
            (LETT |n| (- |minR| 1))
            (SEQ (LETT |j| |minC|) (LETT #7# |maxC|) G190
                 (COND ((> |j| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND ((> |i| |maxR|) (PROGN (LETT #6# |x|) (GO #9=#:G888)))
                         ('T
                          (SEQ (LETT |n| (- |minR| 1))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |k| |i|) (LETT #5# |maxR|) G190
                                      (COND ((> |k| #5#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |x| |k| |j|
                                                     (QREFELT $ 13))
                                           (|spadConstant| $ 14)
                                           (QREFELT $ 16))
                                          (SEQ (LETT |n| |k|)
                                               (EXIT
                                                (PROGN
                                                 (LETT #4# 1)
                                                 (GO #10=#:G875))))))))
                                      (LETT |k| (+ |k| 1)) (GO G190) G191
                                      (EXIT NIL)))
                                #10# (EXIT #4#))
                               (EXIT
                                (COND ((EQL |n| (- |minR| 1)) "no non-zeroes")
                                      ('T
                                       (SEQ
                                        (COND
                                         ((SPADCALL |i| |n| (QREFELT $ 31))
                                          (SPADCALL |x| |i| |n|
                                                    (QREFELT $ 32))))
                                        (LETT |b|
                                              (SPADCALL
                                               (SPADCALL |x| |i| |j|
                                                         (QREFELT $ 13))
                                               (QREFELT $ 33)))
                                        (SPADCALL |x| |i| |j|
                                                  (|spadConstant| $ 30)
                                                  (QREFELT $ 44))
                                        (SEQ (LETT |k| (+ |j| 1))
                                             (LETT #3# |maxC|) G190
                                             (COND ((> |k| #3#) (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (SPADCALL |x| |i| |k|
                                                         (SPADCALL |b|
                                                                   (SPADCALL
                                                                    |x| |i| |k|
                                                                    (QREFELT $
                                                                             13))
                                                                   (QREFELT $
                                                                            19))
                                                         (QREFELT $ 44))))
                                             (LETT |k| (+ |k| 1)) (GO G190)
                                             G191 (EXIT NIL))
                                        (SEQ (LETT |k| |minR|)
                                             (LETT #2# |maxR|) G190
                                             (COND ((> |k| #2#) (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((SPADCALL |k| |i|
                                                           (QREFELT $ 31))
                                                 (SEQ
                                                  (LETT |pp|
                                                        (SPADCALL |x| |k| |j|
                                                                  (QREFELT $
                                                                           13)))
                                                  (EXIT
                                                   (COND
                                                    ((NULL
                                                      (SPADCALL |pp|
                                                                (|spadConstant|
                                                                 $ 14)
                                                                (QREFELT $
                                                                         34)))
                                                     (SEQ
                                                      (SPADCALL |x| |i|
                                                                (+ |j| 1) |k|
                                                                |maxC| |pp|
                                                                |row_op|)
                                                      (EXIT
                                                       (SPADCALL |x| |k| |j|
                                                                 (|spadConstant|
                                                                  $ 14)
                                                                 (QREFELT $
                                                                          44))))))))))))
                                             (LETT |k| (+ |k| 1)) (GO G190)
                                             G191 (EXIT NIL))
                                        (EXIT (LETT |i| (+ |i| 1))))))))))))
                 (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT |x|)))
          #9# (EXIT #6#)))) 

(SDEFUN |IMATLIN;rowEchelon;2M;10!0|
        ((|x| NIL) (|i| NIL) (|j| NIL) (|k| NIL) (|maxC| NIL) (|pp| NIL)
         ($$ NIL))
        (PROG (|cc| $)
          (LETT |cc| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (SPADCALL |x| |i| |j| |k| |maxC| |pp| |cc| (QREFELT $ 23)))))) 

(SDEFUN |IMATLIN;nullSpace;ML;11| ((|y| (M)) ($ (|List| |Col|)))
        (SPROG
         ((|l| (|Integer|)) (|j| #1=(|Integer|)) (|basis| (|List| |Col|))
          (#2=#:G924 NIL) (|k| NIL) (#3=#:G925 NIL) (|ll| NIL) (|w| (|Col|))
          (#4=#:G923 NIL) (|i| NIL)
          (|v| (|IndexedOneDimensionalArray| (|Integer|) |minC|))
          (#5=#:G922 NIL) (|row| #6=(|Integer|)) (#7=#:G897 NIL)
          (|rk| #8=(|NonNegativeInteger|)) (#9=#:G896 NIL)
          (|ncol| (|NonNegativeInteger|)) (|nrow| #8#) (|maxC| #1#)
          (|minC| (|Integer|)) (|maxR| #6#) (|minR| (|Integer|)) (|x| (M)))
         (SEQ (LETT |x| (SPADCALL |y| (QREFELT $ 35)))
              (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
              (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
              (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
              (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
              (LETT |nrow| (SPADCALL |x| (QREFELT $ 45)))
              (LETT |ncol| (SPADCALL |x| (QREFELT $ 46))) (LETT |basis| NIL)
              (LETT |rk| |nrow|) (LETT |row| |maxR|)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND ((> |rk| 0) (|IMATLIN;rowAllZeroes?| |x| |row| $))
                            ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (LETT |rk|
                          (PROG1 (LETT #9# (- |rk| 1))
                            (|check_subtype2| (>= #9# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #9#)))
                    (EXIT
                     (LETT |row|
                           (PROG1 (LETT #7# (- |row| 1))
                             (|check_subtype2| (>= #7# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #7#)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND ((<= |ncol| |nrow|) (COND ((EQL |rk| |ncol|) (EXIT NIL)))))
              (EXIT
               (COND
                ((EQL |rk| 0)
                 (SEQ
                  (SEQ (LETT |j| |minC|) (LETT #5# |maxC|) G190
                       (COND ((> |j| #5#) (GO G191)))
                       (SEQ
                        (LETT |w|
                              (SPADCALL |ncol| (|spadConstant| $ 14)
                                        (QREFELT $ 36)))
                        (SPADCALL |w| |j| (|spadConstant| $ 30) (QREFELT $ 37))
                        (EXIT (LETT |basis| (CONS |w| |basis|))))
                       (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                  (EXIT |basis|)))
                ('T
                 (SEQ
                  (LETT |v|
                        (SPADCALL |ncol| (- |minR| 1)
                                  (|compiledLookupCheck| '|new|
                                                         (LIST '$
                                                               (LIST
                                                                '|NonNegativeInteger|)
                                                               (LIST
                                                                '|Integer|))
                                                         (|IndexedOneDimensionalArray|
                                                          (|Integer|)
                                                          |minC|))))
                  (SEQ (LETT |i| |minR|) (LETT #4# (- (+ |minR| |rk|) 1)) G190
                       (COND ((> |i| #4#) (GO G191)))
                       (SEQ
                        (SEQ (LETT |j| |minC|) G190
                             (COND
                              ((NULL
                                (SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                          (|spadConstant| $ 14)
                                          (QREFELT $ 34)))
                               (GO G191)))
                             (SEQ (EXIT |j|)) (LETT |j| (+ |j| 1)) (GO G190)
                             G191 (EXIT NIL))
                        (EXIT
                         (SPADCALL |v| |j| |i|
                                   (|compiledLookupCheck| '|qsetelt!|
                                                          (LIST
                                                           (LIST '|Integer|) '$
                                                           (LIST '|Integer|)
                                                           (LIST '|Integer|))
                                                          (|IndexedOneDimensionalArray|
                                                           (|Integer|)
                                                           |minC|)))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (LETT |j| |maxC|) (LETT |l| (- (+ |minR| |ncol|) 1))
                  (SEQ G190 (COND ((NULL (>= |j| |minC|)) (GO G191)))
                       (SEQ
                        (LETT |w|
                              (SPADCALL |ncol| (|spadConstant| $ 14)
                                        (QREFELT $ 36)))
                        (COND
                         ((EQL
                           (SPADCALL |v| |j|
                                     (|compiledLookupCheck| '|qelt|
                                                            (LIST
                                                             (LIST '|Integer|)
                                                             '$
                                                             (LIST '|Integer|))
                                                            (|IndexedOneDimensionalArray|
                                                             (|Integer|)
                                                             |minC|)))
                           (- |minR| 1))
                          (COND
                           ((|IMATLIN;colAllZeroes?| |x| |j| $)
                            (SEQ
                             (SPADCALL |w| |l| (|spadConstant| $ 30)
                                       (QREFELT $ 37))
                             (EXIT (LETT |basis| (CONS |w| |basis|)))))
                           ('T
                            (SEQ
                             (SEQ (LETT |ll| |minR|) (LETT #3# (- |l| 1))
                                  (LETT |k| |minC|) (LETT #2# (- |j| 1)) G190
                                  (COND
                                   ((OR (> |k| #2#) (> |ll| #3#)) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |v| |k|
                                                 (|compiledLookupCheck| '|qelt|
                                                                        (LIST
                                                                         (LIST
                                                                          '|Integer|)
                                                                         '$
                                                                         (LIST
                                                                          '|Integer|))
                                                                        (|IndexedOneDimensionalArray|
                                                                         (|Integer|)
                                                                         |minC|)))
                                       (- |minR| 1) (QREFELT $ 31))
                                      (SPADCALL |w| |ll|
                                                (SPADCALL
                                                 (SPADCALL |x|
                                                           (SPADCALL |v| |k|
                                                                     (|compiledLookupCheck|
                                                                      '|qelt|
                                                                      (LIST
                                                                       (LIST
                                                                        '|Integer|)
                                                                       '$
                                                                       (LIST
                                                                        '|Integer|))
                                                                      (|IndexedOneDimensionalArray|
                                                                       (|Integer|)
                                                                       |minC|)))
                                                           |j| (QREFELT $ 13))
                                                 (QREFELT $ 38))
                                                (QREFELT $ 37))))))
                                  (LETT |k|
                                        (PROG1 (+ |k| 1)
                                          (LETT |ll| (+ |ll| 1))))
                                  (GO G190) G191 (EXIT NIL))
                             (SPADCALL |w| |l| (|spadConstant| $ 30)
                                       (QREFELT $ 37))
                             (EXIT (LETT |basis| (CONS |w| |basis|))))))))
                        (LETT |j| (- |j| 1)) (EXIT (LETT |l| (- |l| 1))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT |basis|)))))))) 

(SDEFUN |IMATLIN;determinant;MR;12| ((|y| (M)) ($ (R)))
        (SPROG
         ((#1=#:G953 NIL) (|l| NIL) (|b| (R)) (#2=#:G952 NIL) (|k| NIL)
          (#3=#:G951 NIL) (|ans| (R)) (#4=#:G947 NIL) (#5=#:G946 NIL)
          (|rown| (|Integer|)) (#6=#:G950 NIL) (#7=#:G948 NIL) (|i| NIL)
          (#8=#:G949 NIL) (|j| NIL) (|maxC| (|Integer|)) (|minC| (|Integer|))
          (|maxR| (|Integer|)) (|minR| (|Integer|)) (|x| (M))
          (|ndim| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |ndim| (SPADCALL |y| (QREFELT $ 45)))
                       (SPADCALL |y| (QREFELT $ 46)) (QREFELT $ 41))
             (|error| "determinant: matrix must be square"))
            ((EQL |ndim| 0) (|spadConstant| $ 30))
            ((EQL |ndim| 1)
             (SPADCALL |y| (SPADCALL |y| (QREFELT $ 17))
                       (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 13)))
            ('T
             (SEQ (LETT |x| (SPADCALL |y| (QREFELT $ 29)))
                  (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
                  (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
                  (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
                  (LETT |ans| (|spadConstant| $ 30))
                  (SEQ (LETT |j| |minC|) (LETT #8# (- |maxC| 1))
                       (LETT |i| |minR|) (LETT #7# (- |maxR| 1)) G190
                       (COND ((OR (> |i| #7#) (> |j| #8#)) (GO G191)))
                       (SEQ
                        (COND
                         ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                    (|spadConstant| $ 14) (QREFELT $ 34))
                          (SEQ (LETT |rown| (- |minR| 1))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |k| (+ |i| 1)) (LETT #6# |maxR|)
                                      G190 (COND ((> |k| #6#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |x| |k| |j|
                                                     (QREFELT $ 13))
                                           (|spadConstant| $ 14)
                                           (QREFELT $ 16))
                                          (PROGN
                                           (LETT #5#
                                                 (SEQ (LETT |rown| |k|)
                                                      (EXIT
                                                       (PROGN
                                                        (LETT #5# 1)
                                                        (GO #9=#:G930)))))
                                           (GO #9#))))))
                                      (LETT |k| (+ |k| 1)) (GO G190) G191
                                      (EXIT NIL)))
                                #9# (EXIT #5#))
                               (COND
                                ((EQL |rown| (- |minR| 1))
                                 (PROGN
                                  (LETT #4# (|spadConstant| $ 14))
                                  (GO #10=#:G945))))
                               (SPADCALL |x| |i| |rown| (QREFELT $ 32))
                               (EXIT
                                (LETT |ans|
                                      (SPADCALL |ans| (QREFELT $ 38)))))))
                        (LETT |ans|
                              (SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                        |ans| (QREFELT $ 19)))
                        (LETT |b|
                              (SPADCALL
                               (SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                         (QREFELT $ 33))
                               (QREFELT $ 38)))
                        (SEQ (LETT |l| (+ |j| 1)) (LETT #3# |maxC|) G190
                             (COND ((> |l| #3#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |x| |i| |l|
                                         (SPADCALL |b|
                                                   (SPADCALL |x| |i| |l|
                                                             (QREFELT $ 13))
                                                   (QREFELT $ 19))
                                         (QREFELT $ 44))))
                             (LETT |l| (+ |l| 1)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (SEQ (LETT |k| (+ |i| 1)) (LETT #2# |maxR|) G190
                              (COND ((> |k| #2#) (GO G191)))
                              (SEQ
                               (LETT |b| (SPADCALL |x| |k| |j| (QREFELT $ 13)))
                               (EXIT
                                (COND
                                 ((NULL
                                   (SPADCALL |b| (|spadConstant| $ 14)
                                             (QREFELT $ 34)))
                                  (SEQ (LETT |l| (+ |j| 1)) (LETT #1# |maxC|)
                                       G190 (COND ((> |l| #1#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SPADCALL |x| |k| |l|
                                                   (SPADCALL
                                                    (SPADCALL |x| |k| |l|
                                                              (QREFELT $ 13))
                                                    (SPADCALL |b|
                                                              (SPADCALL |x| |i|
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 13))
                                                              (QREFELT $ 19))
                                                    (QREFELT $ 42))
                                                   (QREFELT $ 44))))
                                       (LETT |l| (+ |l| 1)) (GO G190) G191
                                       (EXIT NIL))))))
                              (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))))
                       (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                       (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SPADCALL (SPADCALL |x| |maxR| |maxC| (QREFELT $ 13)) |ans|
                             (QREFELT $ 19)))))))
          #10# (EXIT #4#)))) 

(SDEFUN |IMATLIN;rank;MNni;13| ((|x| (M)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|rk| (|NonNegativeInteger|)) (#1=#:G957 NIL) (|i| (|Integer|))
          (|y| (M)) (|rh| (|NonNegativeInteger|)))
         (SEQ
          (LETT |y|
                (SEQ (LETT |rk| (SPADCALL |x| (QREFELT $ 45)))
                     (LETT |rh| (SPADCALL |x| (QREFELT $ 46)))
                     (EXIT
                      (COND
                       ((> |rk| |rh|)
                        (SEQ (LETT |rk| |rh|)
                             (EXIT (SPADCALL |x| (QREFELT $ 47)))))
                       ('T (SPADCALL |x| (QREFELT $ 29)))))))
          (LETT |y| (SPADCALL |y| (QREFELT $ 35)))
          (LETT |i| (SPADCALL |y| (QREFELT $ 18)))
          (SEQ G190
               (COND
                ((NULL
                  (COND ((> |rk| 0) (|IMATLIN;rowAllZeroes?| |y| |i| $))
                        ('T NIL)))
                 (GO G191)))
               (SEQ (LETT |i| (- |i| 1))
                    (EXIT
                     (LETT |rk|
                           (PROG1 (LETT #1# (- |rk| 1))
                             (|check_subtype2| (>= #1# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #1#)))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT |rk|)))) 

(SDEFUN |IMATLIN;nullity;MNni;14| ((|x| (M)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G962 NIL))
               (PROG1
                   (LETT #1#
                         (- (SPADCALL |x| (QREFELT $ 46))
                            (SPADCALL |x| (QREFELT $ 48))))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |IMATLIN;generalizedInverse;2M;15| ((|x| (M)) ($ (M)))
        (SPROG
         ((|yy| (|Matrix| FSUP)) (#1=#:G971 NIL) (|var| (|Fraction| SUP))
          (|ty| (|Matrix| FSUP)) (|y| (|Matrix| FSUP))
          (MATCAT22
           (CATEGORY |package|
            (SIGNATURE |map| (M (|Mapping| R FSUP) #2=(|Matrix| FSUP)))
            (SIGNATURE |map|
             ((|Union| M . #3=("failed"))
              (|Mapping| (|Union| R . #4=("failed")) FSUP) #2#))
            (SIGNATURE |reduce| (R (|Mapping| R FSUP R) #2# R))))
          (MATCAT2
           (CATEGORY |package|
            (SIGNATURE |map| (#5=(|Matrix| FSUP) (|Mapping| FSUP R) M))
            (SIGNATURE |map|
             ((|Union| #5# . #3#) (|Mapping| (|Union| FSUP . #4#) R) M))
            (SIGNATURE |reduce| (FSUP (|Mapping| FSUP R FSUP) M FSUP))))
          (VFSUP
           (|Join| (|VectorCategory| FSUP)
                   (CATEGORY |domain| (SIGNATURE |vector| ($ (|List| FSUP))))))
          (FSUP
           (|Join| (|QuotientFieldCategory| SUP)
                   (CATEGORY |domain|
                    (IF (|has| SUP (|IntegerNumberSystem|))
                        (IF (|has| SUP (|OpenMath|))
                            (ATTRIBUTE (|OpenMath|))
                            |noBranch|)
                        |noBranch|)
                    (IF (|has| SUP (|Canonical|))
                        (IF (|has| SUP (|GcdDomain|))
                            (IF (|has| SUP (|canonicalUnitNormal|))
                                (ATTRIBUTE (|Canonical|))
                                |noBranch|)
                            |noBranch|)
                        |noBranch|)
                    (IF (|has| SUP (|UniqueFactorizationDomain|))
                        (SIGNATURE |factorFraction|
                         ((|Fraction| (|Factored| SUP)) $))
                        |noBranch|))))
          (SUP
           (|Join| (|UnivariatePolynomialCategory| R)
                   (CATEGORY |domain|
                    (SIGNATURE |outputForm|
                     ((|OutputForm|) $ (|OutputForm|)))))))
         (SEQ (LETT SUP (|SparseUnivariatePolynomial| (QREFELT $ 6)))
              (LETT FSUP (|Fraction| SUP)) (LETT VFSUP (|Vector| FSUP))
              (LETT MATCAT2
                    (|MatrixCategoryFunctions2| (QREFELT $ 6) (QREFELT $ 7)
                                                (QREFELT $ 8) (QREFELT $ 9)
                                                FSUP VFSUP VFSUP
                                                (|Matrix| FSUP)))
              (LETT MATCAT22
                    (|MatrixCategoryFunctions2| FSUP VFSUP VFSUP
                                                (|Matrix| FSUP) (QREFELT $ 6)
                                                (QREFELT $ 7) (QREFELT $ 8)
                                                (QREFELT $ 9)))
              (LETT |y|
                    (SPADCALL
                     (CONS #'|IMATLIN;generalizedInverse;2M;15!0|
                           (VECTOR FSUP SUP $))
                     |x|
                     (|compiledLookupCheck| '|map|
                                            (LIST
                                             (LIST '|Matrix|
                                                   (|devaluate| FSUP))
                                             (LIST '|Mapping|
                                                   (|devaluate| FSUP)
                                                   (|devaluate| (ELT $ 6)))
                                             (|devaluate| (ELT $ 9)))
                                            MATCAT2)))
              (LETT |ty|
                    (SPADCALL |y|
                              (|compiledLookupCheck| '|transpose| (LIST '$ '$)
                                                     (|Matrix| FSUP))))
              (LETT |yy|
                    (SPADCALL |ty| |y|
                              (|compiledLookupCheck| '* (LIST '$ '$ '$)
                                                     (|Matrix| FSUP))))
              (LETT |var|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 30) 1
                               (|compiledLookupCheck| '|monomial|
                                                      (LIST '$
                                                            (|devaluate|
                                                             (ELT $ 6))
                                                            (LIST
                                                             '|NonNegativeInteger|))
                                                      SUP))
                     (|compiledLookupCheck| '|coerce|
                                            (LIST '$ (|devaluate| SUP))
                                            (|Fraction| SUP))))
              (LETT |yy|
                    (SPADCALL
                     (PROG2
                         (LETT #1#
                               (SPADCALL
                                (SPADCALL |yy|
                                          (SPADCALL (ANCOLS |yy|) |var|
                                                    (|compiledLookupCheck|
                                                     '|scalarMatrix|
                                                     (LIST '$
                                                           (LIST
                                                            '|NonNegativeInteger|)
                                                           (|devaluate| FSUP))
                                                     (|Matrix| FSUP)))
                                          (|compiledLookupCheck| '+
                                                                 (LIST '$ '$
                                                                       '$)
                                                                 (|Matrix|
                                                                  FSUP)))
                                (|compiledLookupCheck| '|inverse|
                                                       (LIST
                                                        (LIST '|Union| '$
                                                              '#6="failed")
                                                        '$)
                                                       (|Matrix| FSUP))))
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0) (|Matrix| FSUP)
                                       (|Union| (|Matrix| FSUP) #6#) #1#))
                     |ty|
                     (|compiledLookupCheck| '* (LIST '$ '$ '$)
                                            (|Matrix| FSUP))))
              (EXIT
               (SPADCALL
                (CONS #'|IMATLIN;generalizedInverse;2M;15!1| (VECTOR SUP $))
                |yy|
                (|compiledLookupCheck| '|map|
                                       (LIST (|devaluate| (ELT $ 9))
                                             (LIST '|Mapping|
                                                   (|devaluate| (ELT $ 6))
                                                   (|devaluate| FSUP))
                                             (LIST '|Matrix|
                                                   (|devaluate| FSUP)))
                                       MATCAT22)))))) 

(SDEFUN |IMATLIN;generalizedInverse;2M;15!1| ((|z1| NIL) ($$ NIL))
        (PROG ($ SUP)
          (LETT $ (QREFELT $$ 1))
          (LETT SUP (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |z1| (|spadConstant| $ 14)
                      (|compiledLookupCheck| '|elt|
                                             (LIST (|devaluate| (ELT $ 6))
                                                   (LIST '|Fraction| '$)
                                                   (|devaluate| (ELT $ 6)))
                                             SUP)))))) 

(SDEFUN |IMATLIN;generalizedInverse;2M;15!0| ((|r1| NIL) ($$ NIL))
        (PROG ($ SUP FSUP)
          (LETT $ (QREFELT $$ 2))
          (LETT SUP (QREFELT $$ 1))
          (LETT FSUP (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |r1|
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (|devaluate| (ELT $ 6)))
                                              SUP))
             (|compiledLookupCheck| '|coerce| (LIST '$ (|devaluate| SUP))
                                    FSUP)))))) 

(SDEFUN |IMATLIN;inv_gen| ((|x| (M)) ($ (|Union| M "failed")))
        (SPROG
         ((AB (M)) (#1=#:G989 NIL) (|j| NIL) (#2=#:G990 NIL) (|l| NIL)
          (#3=#:G987 NIL) (|i| NIL) (#4=#:G988 NIL) (|k| NIL)
          (|lmax| #5=(|Integer|)) (|lmin| #6=(|Integer|)) (|kmax| #5#)
          (|kmin| #7=(|Integer|)) (|maxC| (|Integer|)) (|minC| #6#)
          (|maxR| (|Integer|)) (|minR| #7#) (|ndim| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |ndim| (SPADCALL |x| (QREFELT $ 45)))
                      (SPADCALL |x| (QREFELT $ 46)) (QREFELT $ 41))
            (|error| "inverse: matrix must be square"))
           ((EQL |ndim| 0) (CONS 0 |x|))
           (#8='T
            (SEQ (LETT AB (SPADCALL |ndim| (+ |ndim| |ndim|) (QREFELT $ 51)))
                 (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
                 (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
                 (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
                 (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
                 (LETT |kmin| (SPADCALL AB (QREFELT $ 17)))
                 (LETT |kmax| (- (+ |kmin| |ndim|) 1))
                 (LETT |lmin| (SPADCALL AB (QREFELT $ 11)))
                 (LETT |lmax| (- (+ |lmin| |ndim|) 1))
                 (SEQ (LETT |k| |kmin|) (LETT #4# |kmax|) (LETT |i| |minR|)
                      (LETT #3# |maxR|) G190
                      (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
                      (SEQ
                       (SEQ (LETT |l| |lmin|) (LETT #2# |lmax|)
                            (LETT |j| |minC|) (LETT #1# |maxC|) G190
                            (COND ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL AB |k| |l|
                                        (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                        (QREFELT $ 44))))
                            (LETT |j| (PROG1 (+ |j| 1) (LETT |l| (+ |l| 1))))
                            (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (SPADCALL AB |k| (- (+ (+ |lmin| |ndim|) |k|) |kmin|)
                                  (|spadConstant| $ 30) (QREFELT $ 44))))
                      (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1))))
                      (GO G190) G191 (EXIT NIL))
                 (LETT AB (SPADCALL AB (QREFELT $ 35)))
                 (EXIT
                  (COND
                   ((SPADCALL (SPADCALL AB |kmax| |lmax| (QREFELT $ 52))
                              (|spadConstant| $ 14) (QREFELT $ 34))
                    (CONS 1 "failed"))
                   (#8#
                    (CONS 0
                          (SPADCALL AB |kmin| |kmax| (+ |lmin| |ndim|)
                                    (+ |lmax| |ndim|) (QREFELT $ 53)))))))))))) 

(SDEFUN |IMATLIN;inverse;MU;17| ((|x| (M)) ($ (|Union| M "failed")))
        (SPROG ((|detinv| (R)) (|det| (R)) (|ans2| (M)))
               (SEQ
                (COND
                 ((EQL (ANROWS |x|) 2)
                  (COND
                   ((EQL (ANCOLS |x|) 2)
                    (EXIT
                     (SEQ (LETT |ans2| (SPADCALL 2 2 (QREFELT $ 51)))
                          (EXIT
                           (COND
                            ((SPADCALL
                              (LETT |det|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |x| 1 1 (QREFELT $ 52))
                                      (SPADCALL |x| 2 2 (QREFELT $ 52))
                                      (QREFELT $ 19))
                                     (SPADCALL
                                      (SPADCALL |x| 1 2 (QREFELT $ 52))
                                      (SPADCALL |x| 2 1 (QREFELT $ 52))
                                      (QREFELT $ 19))
                                     (QREFELT $ 20)))
                              (QREFELT $ 54))
                             (CONS 1 "failed"))
                            ('T
                             (SEQ
                              (LETT |detinv| (SPADCALL |det| (QREFELT $ 33)))
                              (SPADCALL |ans2| 1 1
                                        (SPADCALL
                                         (SPADCALL |x| 2 2 (QREFELT $ 52))
                                         |detinv| (QREFELT $ 19))
                                        (QREFELT $ 55))
                              (SPADCALL |ans2| 1 2
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |x| 1 2 (QREFELT $ 52))
                                          |detinv| (QREFELT $ 19))
                                         (QREFELT $ 38))
                                        (QREFELT $ 55))
                              (SPADCALL |ans2| 2 1
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |x| 2 1 (QREFELT $ 52))
                                          |detinv| (QREFELT $ 19))
                                         (QREFELT $ 38))
                                        (QREFELT $ 55))
                              (SPADCALL |ans2| 2 2
                                        (SPADCALL
                                         (SPADCALL |x| 1 1 (QREFELT $ 52))
                                         |detinv| (QREFELT $ 19))
                                        (QREFELT $ 55))
                              (EXIT (CONS 0 |ans2|))))))))))))
                (EXIT (|IMATLIN;inv_gen| |x| $))))) 

(SDEFUN |IMATLIN;inverse;MU;18| ((|x| (M)) ($ (|Union| M "failed")))
        (|IMATLIN;inv_gen| |x| $)) 

(SDEFUN |IMATLIN;inverse;MU;19| ((|x| (M)) ($ (|Union| M "failed")))
        (|IMATLIN;inv_gen| |x| $)) 

(DECLAIM (NOTINLINE |InnerMatrixLinearAlgebraFunctions;|)) 

(DEFUN |InnerMatrixLinearAlgebraFunctions| (&REST #1=#:G1002)
  (SPROG NIL
         (PROG (#2=#:G1003)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerMatrixLinearAlgebraFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |InnerMatrixLinearAlgebraFunctions;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerMatrixLinearAlgebraFunctions|)))))))))) 

(DEFUN |InnerMatrixLinearAlgebraFunctions;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$|
          (LIST '|InnerMatrixLinearAlgebraFunctions| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 58))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#3|
                                                            '(|shallowlyMutable|))))))
    (|haddProp| |$ConstructorCache| '|InnerMatrixLinearAlgebraFunctions|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|domainEqual| |#4| (|Matrix| |#1|))
      (PROGN
       (QSETREFV $ 22
                 (CONS
                  (|dispatchFunction| |IMATLIN;row_operation_base;M4IRV;3|) $))
       (QSETREFV $ 23
                 (CONS
                  (|dispatchFunction| |IMATLIN;row_operation_modular;M4IRIV;4|)
                  $))
       (QSETREFV $ 35 (CONS (|dispatchFunction| |IMATLIN;rowEchelon;2M;5|) $))
       (COND
        ((|testBitVector| |pv$| 2)
         (QSETREFV $ 40
                   (CONS (|dispatchFunction| |IMATLIN;nullSpace;ML;6|) $))))
       (QSETREFV $ 43
                 (CONS (|dispatchFunction| |IMATLIN;determinant;MR;7|) $))))
     ('T
      (PROGN
       (QSETREFV $ 22
                 (CONS
                  (|dispatchFunction| |IMATLIN;row_operation_base;M4IRV;8|) $))
       (QSETREFV $ 23
                 (CONS
                  (|dispatchFunction| |IMATLIN;row_operation_modular;M4IRIV;9|)
                  $))
       (QSETREFV $ 35 (CONS (|dispatchFunction| |IMATLIN;rowEchelon;2M;10|) $))
       (COND
        ((|testBitVector| |pv$| 2)
         (QSETREFV $ 40
                   (CONS (|dispatchFunction| |IMATLIN;nullSpace;ML;11|) $))))
       (QSETREFV $ 43
                 (CONS (|dispatchFunction| |IMATLIN;determinant;MR;12|) $)))))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 50
                (CONS (|dispatchFunction| |IMATLIN;generalizedInverse;2M;15|)
                      $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (COND
       ((|domainEqual| |#4| (|Matrix| |#1|))
        (QSETREFV $ 57 (CONS (|dispatchFunction| |IMATLIN;inverse;MU;17|) $)))
       ('T
        (QSETREFV $ 57
                  (CONS (|dispatchFunction| |IMATLIN;inverse;MU;18|) $)))))
     ('T
      (QSETREFV $ 57 (CONS (|dispatchFunction| |IMATLIN;inverse;MU;19|) $))))
    $))) 

(MAKEPROP '|InnerMatrixLinearAlgebraFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Integer|) (0 . |minColIndex|)
              (5 . |maxColIndex|) (10 . |qelt|) (17 . |Zero|) (|Boolean|)
              (21 . ~=) (27 . |minRowIndex|) (32 . |maxRowIndex|) (37 . *)
              (43 . -) (|Void|) (49 . |row_operation_base|)
              (59 . |row_operation_modular|) (|NonNegativeInteger|)
              (70 . |characteristic|) (74 . |Zero|) (78 . >) (84 . <)
              (90 . |copy|) (95 . |One|) (99 . ~=) (105 . |swapRows!|)
              (112 . |inv|) (117 . =) (123 . |rowEchelon|) (128 . |new|)
              (134 . |qsetelt!|) (141 . -) (|List| 8) (146 . |nullSpace|)
              (151 . ~=) (157 . +) (163 . |determinant|) (168 . |qsetelt!|)
              (176 . |nrows|) (181 . |ncols|) (186 . |transpose|)
              |IMATLIN;rank;MNni;13| |IMATLIN;nullity;MNni;14|
              (191 . |generalizedInverse|) (196 . |zero|) (202 . |elt|)
              (209 . |subMatrix|) (218 . |zero?|) (223 . |setelt!|)
              (|Union| 9 '#1="failed") (231 . |inverse|))
           '#(|row_operation_modular| 236 |row_operation_base| 247 |rowEchelon|
              257 |rank| 262 |nullity| 267 |nullSpace| 272 |inverse| 277
              |generalizedInverse| 282 |determinant| 287)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|rowEchelon| (|#4| |#4|)) T)
                                   '((|rank| ((|NonNegativeInteger|) |#4|)) T)
                                   '((|nullity| ((|NonNegativeInteger|) |#4|))
                                     T)
                                   '((|nullSpace| ((|List| |#3|) |#4|))
                                     (|has| 8 (|shallowlyMutable|)))
                                   '((|determinant| (|#1| |#4|))
                                     (|has| 6 (|Field|)))
                                   '((|generalizedInverse| (|#4| |#4|))
                                     (|has| 6 (|Field|)))
                                   '((|inverse| ((|Union| |#4| #1#) |#4|)) T)
                                   '((|row_operation_base|
                                      ((|Void|) |#4| (|Integer|) (|Integer|)
                                       (|Integer|) (|Integer|) |#1|))
                                     T)
                                   '((|row_operation_modular|
                                      ((|Void|) |#4| (|Integer|) (|Integer|)
                                       (|Integer|) (|Integer|) |#1|
                                       (|Integer|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 57
                                            '(1 9 10 0 11 1 9 10 0 12 3 9 6 0
                                              10 10 13 0 6 0 14 2 6 15 0 0 16 1
                                              9 10 0 17 1 9 10 0 18 2 6 0 0 0
                                              19 2 6 0 0 0 20 6 0 21 9 10 10 10
                                              10 6 22 7 0 21 9 10 10 10 10 6 10
                                              23 0 6 24 25 0 24 0 26 2 24 15 0
                                              0 27 2 24 15 0 0 28 1 9 0 0 29 0
                                              6 0 30 2 10 15 0 0 31 3 9 0 0 10
                                              10 32 1 6 0 0 33 2 6 15 0 0 34 1
                                              0 9 9 35 2 8 0 24 6 36 3 8 6 0 10
                                              6 37 1 6 0 0 38 1 0 39 9 40 2 24
                                              15 0 0 41 2 6 0 0 0 42 1 0 6 9 43
                                              4 9 6 0 10 10 6 44 1 9 24 0 45 1
                                              9 24 0 46 1 9 0 0 47 1 0 9 9 50 2
                                              9 0 24 24 51 3 9 6 0 10 10 52 5 9
                                              0 0 10 10 10 10 53 1 6 15 0 54 4
                                              9 6 0 10 10 6 55 1 0 56 9 57 7 0
                                              21 9 10 10 10 10 6 10 23 6 0 21 9
                                              10 10 10 10 6 22 1 0 9 9 35 1 0
                                              24 9 48 1 0 24 9 49 1 2 39 9 40 1
                                              0 56 9 57 1 1 9 9 50 1 1 6 9
                                              43)))))
           '|lookupComplete|)) 
