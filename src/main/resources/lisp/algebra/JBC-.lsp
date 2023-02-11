
(SDEFUN |JBC-;m2r;LL;1|
        ((|mi| (|List| (|NonNegativeInteger|)))
         ($ (|List| (|PositiveInteger|))))
        (SPROG
         ((|k| (|PositiveInteger|)) (|ri| (|List| (|PositiveInteger|)))
          (#1=#:G739 NIL) (|j| NIL) (#2=#:G738 NIL) (|i| NIL))
         (SEQ (LETT |ri| NIL) (LETT |k| 1)
              (SEQ (LETT |i| NIL) (LETT #2# |mi|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #1# |i|) G190
                         (COND ((|greater_SI| |j| #1#) (GO G191)))
                         (SEQ (EXIT (LETT |ri| (CONS |k| |ri|))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |k| (+ |k| 1))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ri|)))) 

(SDEFUN |JBC-;r2m;LL;2|
        ((|ri| (|List| (|PositiveInteger|)))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((#1=#:G752 NIL) (|i| NIL) (|mi| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |mi| (SPADCALL (SPADCALL (QREFELT $ 8)) 0 (QREFELT $ 17)))
              (SEQ (LETT |i| NIL) (LETT #1# |ri|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> |i| (QREFELT $ 9)) (|error| "Improper multi-index"))
                      ('T
                       (SPADCALL |mi| |i|
                                 (+ 1 (SPADCALL |mi| |i| (QREFELT $ 19)))
                                 (QREFELT $ 20))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |mi|)))) 

(SDEFUN |JBC-;allRepeated;LL;3|
        ((|mu| (|List| (|NonNegativeInteger|)))
         ($ (|List| (|List| (|PositiveInteger|)))))
        (SPROG
         ((|res| (|List| (|List| (|PositiveInteger|))))
          (|tmp| (|List| (|List| (|PositiveInteger|)))) (#1=#:G754 NIL)
          (|nu| (|List| (|NonNegativeInteger|))) (#2=#:G778 NIL) (|i| NIL)
          (#3=#:G779 NIL) (|k| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |k| NIL) (LETT #3# |mu|) (LETT |i| 1)
                   (LETT #2# (QREFELT $ 9)) G190
                   (COND
                    ((OR (|greater_SI| |i| #2#) (ATOM #3#)
                         (PROGN (LETT |k| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (ZEROP |k|))
                       (SEQ (LETT |nu| (SPADCALL |mu| (QREFELT $ 22)))
                            (SPADCALL |nu| |i|
                                      (PROG1 (LETT #1# (- |k| 1))
                                        (|check_subtype2| (>= #1# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #1#))
                                      (QREFELT $ 20))
                            (LETT |tmp| (SPADCALL |nu| (QREFELT $ 24)))
                            (EXIT
                             (LETT |res|
                                   (SPADCALL |res|
                                             (SPADCALL
                                              (CONS #'|JBC-;allRepeated;LL;3!0|
                                                    (VECTOR $ |i|))
                                              |tmp| (QREFELT $ 27))
                                             (QREFELT $ 28)))))))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #3# (CDR #3#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (COND ((NULL |res|) (LIST NIL)) ('T |res|)))))) 

(SDEFUN |JBC-;allRepeated;LL;3!0| ((|x| NIL) ($$ NIL))
        (PROG (|i| $)
          (LETT |i| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G771 NIL))
                   (SPADCALL
                    (PROG1 (LETT #1# |i|)
                      (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                        '(|NonNegativeInteger|) #1#))
                    |x| (QREFELT $ 25))))))) 

(SDEFUN |JBC-;repeatedIndex;SL;4| ((|jv| (S)) ($ (|List| (|PositiveInteger|))))
        (SPADCALL (SPADCALL |jv| (QREFELT $ 30)) (QREFELT $ 31))) 

(SDEFUN |JBC-;class;LNni;5|
        ((|l| (|List| (|NonNegativeInteger|))) ($ (|NonNegativeInteger|)))
        (SPROG ((|res| (|PositiveInteger|)) (#1=#:G785 NIL) (|i| NIL))
               (SEQ (LETT |res| 1)
                    (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL)
                               (NULL (ZEROP |i|)))
                           (GO G191)))
                         (SEQ (EXIT (LETT |res| (+ |res| 1))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |JBC-;class;SNni;6| ((|jv| (S)) ($ (|NonNegativeInteger|)))
        (COND
         ((SPADCALL (SPADCALL |jv| (QREFELT $ 35)) '|Deriv| (QREFELT $ 37)) 0)
         ('T (SPADCALL (SPADCALL |jv| (QREFELT $ 30)) (QREFELT $ 38))))) 

(SDEFUN |JBC-;order;SNni;7| ((|jv| (S)) ($ (|NonNegativeInteger|)))
        (SPROG ((|sum| (|NonNegativeInteger|)) (#1=#:G798 NIL) (|i| NIL))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |jv| (QREFELT $ 35)) '|Deriv|
                            (QREFELT $ 37))
                  0)
                 ('T
                  (SEQ (LETT |sum| 0)
                       (SEQ (LETT |i| NIL)
                            (LETT #1# (SPADCALL |jv| (QREFELT $ 30))) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ (EXIT (LETT |sum| (+ |sum| |i|))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |sum|))))))) 

(SDEFUN |JBC-;dimJ;2Nni;8|
        ((|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G800 NIL))
               (* (QREFELT $ 11)
                  (PROG1
                      (LETT #1#
                            (SPADCALL (+ |q| (QREFELT $ 9)) (QREFELT $ 9)
                                      (QREFELT $ 41)))
                    (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #1#))))) 

(SDEFUN |JBC-;dimS;2Nni;9|
        ((|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G803 NIL))
               (* (QREFELT $ 11)
                  (PROG1
                      (LETT #1#
                            (SPADCALL (- (+ |q| (QREFELT $ 9)) 1)
                                      (- (QREFELT $ 9) 1) (QREFELT $ 41)))
                    (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #1#))))) 

(SDEFUN |JBC-;X;S;10| (($ (S))) (SPADCALL 1 (QREFELT $ 44))) 

(SDEFUN |JBC-;U;S;11| (($ (S))) (SPADCALL 1 (QREFELT $ 46))) 

(SDEFUN |JBC-;P;LS;12| ((|lo| (|List| (|NonNegativeInteger|))) ($ (S)))
        (SPADCALL 1 |lo| (QREFELT $ 48))) 

(SDEFUN |JBC-;P;PiNniS;13|
        ((|up| (|PositiveInteger|)) (|lo| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL |up| (LIST |lo|) (QREFELT $ 50))) 

(SDEFUN |JBC-;P;NniS;14| ((|lo| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL 1 (LIST |lo|) (QREFELT $ 50))) 

(SDEFUN |JBC-;P;PiLS;15|
        ((|up| (|PositiveInteger|)) (|lo| (|List| (|NonNegativeInteger|)))
         ($ (S)))
        (SPROG
         ((|lop| (|List| (|PositiveInteger|))) (#1=#:G812 NIL) (#2=#:G817 NIL)
          (|i| NIL))
         (SEQ
          (COND
           ((EQUAL (SPADCALL (QREFELT $ 53)) '|Multi|)
            (SPADCALL |up| |lo| (QREFELT $ 50)))
           ('T
            (SEQ (LETT |lop| NIL)
                 (SEQ (LETT |i| NIL) (LETT #2# |lo|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND ((ZEROP |i|) (|error| "Improper multi-index"))
                              ('T
                               (LETT |lop|
                                     (CONS
                                      (PROG1 (LETT #1# |i|)
                                        (|check_subtype2| (> #1# 0)
                                                          '(|PositiveInteger|)
                                                          '(|NonNegativeInteger|)
                                                          #1#))
                                      |lop|))))))
                      (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                 (EXIT (SPADCALL |up| (NREVERSE |lop|) (QREFELT $ 54))))))))) 

(SDEFUN |JBC-;Pr;PiLS;16|
        ((|up| (|PositiveInteger|)) (|lo| (|List| (|PositiveInteger|)))
         ($ (S)))
        (SPADCALL |up| (SPADCALL |lo| (QREFELT $ 56)) (QREFELT $ 50))) 

(SDEFUN |JBC-;coerce;SOf;17| ((|jv| (S)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |jv| (QREFELT $ 58)) (QREFELT $ 60))) 

(SDEFUN |JBC-;dimJ;2Nni;18|
        ((|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|NonNegativeInteger|)) (#1=#:G827 NIL) (#2=#:G831 NIL)
          (|qq| NIL) (|oldJV| (|Vector| (|NonNegativeInteger|)))
          (#3=#:G821 NIL))
         (SEQ
          (COND
           ((< |q| (SPADCALL (QREFELT $ 64) (QREFELT $ 68)))
            (SEQ (LETT |res| (QAREF1O (QREFELT $ 64) (+ (QREFELT $ 67) |q|) 1))
                 (EXIT
                  (COND ((> |res| 0) |res|)
                        (#4='T
                         (SEQ
                          (LETT |res|
                                (* (QREFELT $ 11)
                                   (PROG1
                                       (LETT #3#
                                             (SPADCALL (+ |q| (QREFELT $ 9))
                                                       (QREFELT $ 9)
                                                       (QREFELT $ 41)))
                                     (|check_subtype2| (>= #3# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #3#))))
                          (QSETAREF1O (QREFELT $ 64) (+ (QREFELT $ 67) |q|)
                                      |res| 1)
                          (EXIT |res|)))))))
           (#4#
            (SEQ (LETT |oldJV| (SPADCALL (QREFELT $ 64) (QREFELT $ 69)))
                 (SETELT $ 64 (SPADCALL (+ |q| 1) 0 (QREFELT $ 63)))
                 (SEQ (LETT |qq| (QREFELT $ 67))
                      (LETT #2#
                            (-
                             (+ (QREFELT $ 67)
                                (SPADCALL |oldJV| (QREFELT $ 68)))
                             1))
                      G190 (COND ((> |qq| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF1O (QREFELT $ 64) |qq|
                                    (QAREF1O |oldJV| |qq| 1) 1)))
                      (LETT |qq| (+ |qq| 1)) (GO G190) G191 (EXIT NIL))
                 (LETT |res|
                       (* (QREFELT $ 11)
                          (PROG1
                              (LETT #1#
                                    (SPADCALL (+ |q| (QREFELT $ 9))
                                              (QREFELT $ 9) (QREFELT $ 41)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))))
                 (QSETAREF1O (QREFELT $ 64) (+ (QREFELT $ 67) |q|) |res| 1)
                 (EXIT |res|))))))) 

(SDEFUN |JBC-;dimS;2Nni;19|
        ((|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|NonNegativeInteger|)) (#1=#:G839 NIL) (#2=#:G843 NIL)
          (|qq| NIL) (|oldSV| (|Vector| (|NonNegativeInteger|)))
          (#3=#:G833 NIL))
         (SEQ
          (COND
           ((< |q| (SPADCALL (QREFELT $ 65) (QREFELT $ 68)))
            (SEQ (LETT |res| (QAREF1O (QREFELT $ 65) (+ (QREFELT $ 67) |q|) 1))
                 (EXIT
                  (COND ((> |res| 0) |res|)
                        (#4='T
                         (SEQ
                          (LETT |res|
                                (* (QREFELT $ 11)
                                   (PROG1
                                       (LETT #3#
                                             (SPADCALL
                                              (- (+ |q| (QREFELT $ 9)) 1)
                                              (- (QREFELT $ 9) 1)
                                              (QREFELT $ 41)))
                                     (|check_subtype2| (>= #3# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #3#))))
                          (QSETAREF1O (QREFELT $ 65) (+ (QREFELT $ 67) |q|)
                                      |res| 1)
                          (EXIT |res|)))))))
           (#4#
            (SEQ (LETT |oldSV| (SPADCALL (QREFELT $ 65) (QREFELT $ 69)))
                 (SETELT $ 65 (SPADCALL (+ |q| 1) 0 (QREFELT $ 63)))
                 (SEQ (LETT |qq| (QREFELT $ 67))
                      (LETT #2#
                            (-
                             (+ (QREFELT $ 67)
                                (SPADCALL |oldSV| (QREFELT $ 68)))
                             1))
                      G190 (COND ((> |qq| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF1O (QREFELT $ 65) |qq|
                                    (QAREF1O |oldSV| |qq| 1) 1)))
                      (LETT |qq| (+ |qq| 1)) (GO G190) G191 (EXIT NIL))
                 (LETT |res|
                       (* (QREFELT $ 11)
                          (PROG1
                              (LETT #1#
                                    (SPADCALL (- (+ |q| (QREFELT $ 9)) 1)
                                              (- (QREFELT $ 9) 1)
                                              (QREFELT $ 41)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))))
                 (QSETAREF1O (QREFELT $ 65) (+ (QREFELT $ 67) |q|) |res| 1)
                 (EXIT |res|))))))) 

(SDEFUN |JBC-;differentiate;SPiU;20|
        ((|jv| (S)) (|i| (|PositiveInteger|)) ($ (|Union| S "0")))
        (SPROG
         ((|nind| (|List| (|PositiveInteger|)))
          (|rind| (|List| (|PositiveInteger|)))
          (|mind| (|List| (|NonNegativeInteger|))) (|jt| (|Symbol|)))
         (SEQ
          (COND ((> |i| (QREFELT $ 9)) (|error| "Improper upper index"))
                (#1='T
                 (SEQ (LETT |jt| (SPADCALL |jv| (QREFELT $ 35)))
                      (EXIT
                       (COND ((EQUAL |jt| '|Const|) (CONS 1 "0"))
                             ((EQUAL |jt| '|Indep|)
                              (COND
                               ((EQL (SPADCALL |jv| (QREFELT $ 70)) |i|)
                                (CONS 0 (|spadConstant| $ 12)))
                               (#1# (CONS 1 "0"))))
                             ((EQUAL (SPADCALL (QREFELT $ 53)) '|Multi|)
                              (SEQ (LETT |mind| (SPADCALL |jv| (QREFELT $ 30)))
                                   (SPADCALL |mind| |i|
                                             (+
                                              (SPADCALL |mind|
                                                        (+ (- |i| 1)
                                                           (PROGN |mind| 1))
                                                        (QREFELT $ 19))
                                              1)
                                             (QREFELT $ 20))
                                   (EXIT
                                    (CONS 0
                                          (SPADCALL
                                           (SPADCALL |jv| (QREFELT $ 70))
                                           |mind| (QREFELT $ 50))))))
                             (#1#
                              (SEQ (LETT |rind| (SPADCALL |jv| (QREFELT $ 71)))
                                   (EXIT
                                    (COND
                                     ((NULL |rind|)
                                      (CONS 0
                                            (SPADCALL
                                             (SPADCALL |jv| (QREFELT $ 70))
                                             (LIST |i|) (QREFELT $ 54))))
                                     (#1#
                                      (SEQ (LETT |nind| NIL)
                                           (SEQ G190
                                                (COND
                                                 ((OR
                                                   (NULL (NULL (NULL |rind|)))
                                                   (NULL
                                                    (> (|SPADfirst| |rind|)
                                                       |i|)))
                                                  (GO G191)))
                                                (SEQ
                                                 (LETT |nind|
                                                       (CONS
                                                        (|SPADfirst| |rind|)
                                                        |nind|))
                                                 (EXIT
                                                  (LETT |rind| (CDR |rind|))))
                                                NIL (GO G190) G191 (EXIT NIL))
                                           (LETT |nind|
                                                 (SPADCALL (NREVERSE |nind|)
                                                           (CONS |i| |rind|)
                                                           (QREFELT $ 72)))
                                           (EXIT
                                            (CONS 0
                                                  (SPADCALL
                                                   (SPADCALL |jv|
                                                             (QREFELT $ 70))
                                                   |nind|
                                                   (QREFELT $
                                                            54)))))))))))))))))) 

(SDEFUN |JBC-;derivativeOf?;2SL;21|
        ((|jv1| (S)) (|jv2| (S)) ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|))) (#1=#:G863 NIL)
          (#2=#:G869 NIL) (#3=#:G870 NIL) (|i1| NIL) (#4=#:G871 NIL) (|i2| NIL)
          (|jt| (|Symbol|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |jv1| (QREFELT $ 35)) '|Deriv| (QREFELT $ 37))
             NIL)
            (#5='T
             (SEQ (LETT |jt| (SPADCALL |jv2| (QREFELT $ 35)))
                  (COND
                   ((SPADCALL |jt| '|Deriv| (QREFELT $ 37))
                    (COND ((SPADCALL |jt| '|Dep| (QREFELT $ 37)) (EXIT NIL)))))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |jv1| (QREFELT $ 70))
                               (SPADCALL |jv2| (QREFELT $ 70)) (QREFELT $ 75))
                     NIL)
                    (#5#
                     (SEQ (LETT |res| NIL)
                          (SEQ (LETT |i2| NIL)
                               (LETT #4# (SPADCALL |jv2| (QREFELT $ 30)))
                               (LETT |i1| NIL)
                               (LETT #3# (SPADCALL |jv1| (QREFELT $ 30))) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |i1| (CAR #3#)) NIL)
                                     (ATOM #4#)
                                     (PROGN (LETT |i2| (CAR #4#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((< |i1| |i2|)
                                   (PROGN (LETT #2# NIL) (GO #6=#:G868)))
                                  ('T
                                   (LETT |res|
                                         (CONS
                                          (PROG1 (LETT #1# (- |i1| |i2|))
                                            (|check_subtype2| (>= #1# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #1#))
                                          |res|))))))
                               (LETT #3#
                                     (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                               (GO G190) G191 (EXIT NIL))
                          (EXIT (NREVERSE |res|))))))))))
          #6# (EXIT #2#)))) 

(SDEFUN |JBC-;integrateIfCan;SPiU;22|
        ((|jv| (S)) (|i| (|PositiveInteger|)) ($ (|Union| S "failed")))
        (SPROG
         ((|rind| (|List| (|PositiveInteger|))) (|pos| (|Integer|))
          (#1=#:G875 NIL) (|mi| (|NonNegativeInteger|))
          (|mind| (|List| (|NonNegativeInteger|))))
         (SEQ
          (COND ((> |i| (QREFELT $ 9)) (|error| "Improper upper index"))
                ((SPADCALL (SPADCALL |jv| (QREFELT $ 35)) '|Deriv|
                           (QREFELT $ 37))
                 (CONS 1 "failed"))
                ((EQUAL (SPADCALL (QREFELT $ 53)) '|Multi|)
                 (SEQ (LETT |mind| (SPADCALL |jv| (QREFELT $ 30)))
                      (LETT |pos| (+ (- |i| 1) (PROGN |mind| 1)))
                      (LETT |mi| (SPADCALL |mind| |pos| (QREFELT $ 77)))
                      (EXIT
                       (COND ((ZEROP |mi|) (CONS 1 "failed"))
                             (#2='T
                              (SEQ
                               (SPADCALL |mind| |pos|
                                         (PROG1 (LETT #1# (- |mi| 1))
                                           (|check_subtype2| (>= #1# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #1#))
                                         (QREFELT $ 20))
                               (EXIT
                                (CONS 0
                                      (SPADCALL (SPADCALL |jv| (QREFELT $ 70))
                                                |mind| (QREFELT $ 50))))))))))
                (#2#
                 (SEQ (LETT |rind| (SPADCALL |jv| (QREFELT $ 71)))
                      (LETT |pos| (SPADCALL |i| |rind| (QREFELT $ 78)))
                      (EXIT
                       (COND ((< |pos| (PROGN |rind| 1)) (CONS 1 "failed"))
                             (#2#
                              (SEQ
                               (LETT |rind|
                                     (SPADCALL |rind| |pos| (QREFELT $ 79)))
                               (EXIT
                                (CONS 0
                                      (SPADCALL (SPADCALL |jv| (QREFELT $ 70))
                                                |rind|
                                                (QREFELT $ 54)))))))))))))) 

(SDEFUN |JBC-;integrate;SPiS;23| ((|jv| (S)) (|i| (|PositiveInteger|)) ($ (S)))
        (SPROG ((|ji| (|Union| S "failed")))
               (SEQ (LETT |ji| (SPADCALL |jv| |i| (QREFELT $ 82)))
                    (EXIT
                     (COND
                      ((QEQCAR |ji| 1) (|error| "Integration not possible"))
                      ('T (QCDR |ji|))))))) 

(SDEFUN |JBC-;weight;SNni;24| ((|jv| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|PositiveInteger|)) (|pos| (|PositiveInteger|))
          (#1=#:G896 NIL) (|i| NIL) (|t| (|Symbol|)))
         (SEQ (LETT |t| (SPADCALL |jv| (QREFELT $ 35)))
              (EXIT
               (COND ((EQUAL |t| '|Const|) 0)
                     ((EQUAL |t| '|Indep|) (SPADCALL |jv| (QREFELT $ 70)))
                     ((EQUAL |t| '|Dep|)
                      (* (+ (QREFELT $ 9) 1) (SPADCALL |jv| (QREFELT $ 70))))
                     ('T
                      (SEQ (LETT |pos| (+ (QREFELT $ 9) 1))
                           (LETT |res|
                                 (* |pos| (SPADCALL |jv| (QREFELT $ 70))))
                           (SEQ (LETT |i| NIL)
                                (LETT #1# (SPADCALL |jv| (QREFELT $ 71))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |i| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |pos| (* |pos| (+ (QREFELT $ 9) 1)))
                                     (EXIT
                                      (LETT |res| (+ |res| (* |i| |pos|)))))
                                (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |res|)))))))) 

(SDEFUN |JBC-;one?;SB;25| ((|jv| (S)) ($ (|Boolean|)))
        (EQUAL (SPADCALL |jv| (QREFELT $ 35)) '|Const|)) 

(SDEFUN |JBC-;=;2SB;26| ((|jv1| (S)) (|jv2| (S)) ($ (|Boolean|)))
        (SPROG ((|t1| (|Symbol|)))
               (SEQ (LETT |t1| (SPADCALL |jv1| (QREFELT $ 35)))
                    (EXIT
                     (COND
                      ((EQUAL |t1| '|Const|)
                       (EQUAL (SPADCALL |jv2| (QREFELT $ 35)) '|Const|))
                      ((EQUAL |t1| '|Indep|)
                       (COND
                        ((EQUAL (SPADCALL |jv2| (QREFELT $ 35)) '|Indep|)
                         (EQL (SPADCALL |jv1| (QREFELT $ 70))
                              (SPADCALL |jv2| (QREFELT $ 70))))
                        (#1='T NIL)))
                      (#1#
                       (COND
                        ((EQL (SPADCALL |jv1| (QREFELT $ 70))
                              (SPADCALL |jv2| (QREFELT $ 70)))
                         (SPADCALL (SPADCALL |jv1| (QREFELT $ 30))
                                   (SPADCALL |jv2| (QREFELT $ 30))
                                   (QREFELT $ 86)))
                        (#1# NIL)))))))) 

(SDEFUN |JBC-;<;2SB;27| ((|jv1| (S)) (|jv2| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G909 NIL) (#2=#:G910 NIL) (|i1| NIL) (#3=#:G911 NIL) (|i2| NIL)
          (|o2| #4=(|NonNegativeInteger|)) (|o1| #4#) (|t2| #5=(|Symbol|))
          (|t1| #5#))
         (SEQ
          (EXIT
           (SEQ (LETT |t1| (SPADCALL |jv1| (QREFELT $ 35)))
                (LETT |t2| (SPADCALL |jv2| (QREFELT $ 35)))
                (EXIT
                 (COND ((EQUAL |t2| '|Const|) NIL) ((EQUAL |t1| '|Const|) 'T)
                       ((EQUAL |t1| '|Indep|)
                        (COND
                         ((EQUAL |t2| '|Indep|)
                          (< (SPADCALL |jv1| (QREFELT $ 70))
                             (SPADCALL |jv2| (QREFELT $ 70))))
                         (#6='T 'T)))
                       ((EQUAL |t1| '|Dep|)
                        (COND ((EQUAL |t2| '|Indep|) NIL)
                              ((EQUAL |t2| '|Dep|)
                               (< (SPADCALL |jv1| (QREFELT $ 70))
                                  (SPADCALL |jv2| (QREFELT $ 70))))
                              (#6# 'T)))
                       (#6#
                        (COND
                         ((OR (EQUAL |t2| '|Indep|) (EQUAL |t2| '|Dep|)) NIL)
                         ('T
                          (SEQ (LETT |o1| (SPADCALL |jv1| (QREFELT $ 88)))
                               (LETT |o2| (SPADCALL |jv2| (QREFELT $ 88)))
                               (EXIT
                                (COND
                                 ((EQL |o1| |o2|)
                                  (SEQ
                                   (SEQ (LETT |i2| NIL)
                                        (LETT #3#
                                              (SPADCALL |jv2| (QREFELT $ 30)))
                                        (LETT |i1| NIL)
                                        (LETT #2#
                                              (SPADCALL |jv1| (QREFELT $ 30)))
                                        G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT |i1| (CAR #2#)) NIL)
                                              (ATOM #3#)
                                              (PROGN
                                               (LETT |i2| (CAR #3#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |i1| |i2| (QREFELT $ 89))
                                            (PROGN
                                             (LETT #1# (> |i1| |i2|))
                                             (GO #7=#:G908))))))
                                        (LETT #2#
                                              (PROG1 (CDR #2#)
                                                (LETT #3# (CDR #3#))))
                                        (GO G190) G191 (EXIT NIL))
                                   (EXIT
                                    (< (SPADCALL |jv1| (QREFELT $ 70))
                                       (SPADCALL |jv2| (QREFELT $ 70))))))
                                 (#6# (< |o1| |o2|))))))))))))
          #7# (EXIT #1#)))) 

(SDEFUN |JBC-;>;2SB;28| ((|jv1| (S)) (|jv2| (S)) ($ (|Boolean|)))
        (SPADCALL |jv2| |jv1| (QREFELT $ 91))) 

(SDEFUN |JBC-;variables;NniL;29| ((|q| (|NonNegativeInteger|)) ($ (|List| S)))
        (SPROG
         ((#1=#:G964 NIL) (#2=#:G981 NIL) (|i| NIL) (#3=#:G980 NIL)
          (#4=#:G960 NIL) (#5=#:G979 NIL) (#6=#:G978 NIL) (JV (|List| S))
          (#7=#:G935 NIL) (#8=#:G977 NIL) (|k| NIL) (#9=#:G976 NIL) (|ind| NIL)
          (|IndList| (|List| (|List| (|PositiveInteger|))))
          (|OIndList| (|List| (|List| (|PositiveInteger|))))
          (|NIndList| (|List| (|List| (|PositiveInteger|)))) (#10=#:G927 NIL)
          (#11=#:G975 NIL) (|j| NIL) (#12=#:G974 NIL) (#13=#:G973 NIL)
          (|qq| NIL) (#14=#:G921 NIL) (#15=#:G972 NIL) (#16=#:G918 NIL)
          (#17=#:G971 NIL) (#18=#:G970 NIL) (#19=#:G915 NIL) (#20=#:G969 NIL))
         (SEQ
          (COND
           ((ZEROP |q|)
            (PROGN
             (LETT #20# NIL)
             (SEQ (LETT |i| (QREFELT $ 9)) G190 (COND ((< |i| 1) (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #20#
                          (CONS
                           (SPADCALL
                            (PROG1 (LETT #19# |i|)
                              (|check_subtype2| (> #19# 0) '(|PositiveInteger|)
                                                '(|NonNegativeInteger|) #19#))
                            (QREFELT $ 44))
                           #20#))))
                  (LETT |i| (+ |i| -1)) (GO G190) G191
                  (EXIT (NREVERSE #20#)))))
           ('T
            (SEQ
             (LETT |OIndList|
                   (PROGN
                    (LETT #18# NIL)
                    (SEQ (LETT |i| 1) (LETT #17# (QREFELT $ 9)) G190
                         (COND ((|greater_SI| |i| #17#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #18#
                                 (CONS
                                  (LIST
                                   (PROG1 (LETT #16# |i|)
                                     (|check_subtype2| (> #16# 0)
                                                       '(|PositiveInteger|)
                                                       '(|NonNegativeInteger|)
                                                       #16#)))
                                  #18#))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                         (EXIT (NREVERSE #18#)))))
             (LETT |IndList|
                   (PROGN
                    (LETT #15# NIL)
                    (SEQ (LETT |i| (QREFELT $ 9)) G190
                         (COND ((< |i| 1) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #15#
                                 (CONS
                                  (LIST
                                   (PROG1 (LETT #14# |i|)
                                     (|check_subtype2| (> #14# 0)
                                                       '(|PositiveInteger|)
                                                       '(|NonNegativeInteger|)
                                                       #14#)))
                                  #15#))))
                         (LETT |i| (+ |i| -1)) (GO G190) G191
                         (EXIT (NREVERSE #15#)))))
             (SEQ (LETT |qq| 2) (LETT #13# |q|) G190
                  (COND ((|greater_SI| |qq| #13#) (GO G191)))
                  (SEQ (LETT |NIndList| NIL)
                       (SEQ (LETT |ind| NIL) (LETT #12# |OIndList|) G190
                            (COND
                             ((OR (ATOM #12#)
                                  (PROGN (LETT |ind| (CAR #12#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |j| (|SPADfirst| |ind|))
                                   (LETT #11# (QREFELT $ 9)) G190
                                   (COND ((> |j| #11#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |NIndList|
                                           (CONS
                                            (CONS
                                             (PROG1 (LETT #10# |j|)
                                               (|check_subtype2| (> #10# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|NonNegativeInteger|)
                                                                 #10#))
                                             |ind|)
                                            |NIndList|))))
                                   (LETT |j| (+ |j| 1)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
                       (LETT |OIndList| (REVERSE |NIndList|))
                       (EXIT
                        (LETT |IndList|
                              (SPADCALL |NIndList| |IndList| (QREFELT $ 28)))))
                  (LETT |qq| (|inc_SI| |qq|)) (GO G190) G191 (EXIT NIL))
             (LETT JV NIL)
             (SEQ (LETT |ind| NIL) (LETT #9# |IndList|) G190
                  (COND
                   ((OR (ATOM #9#) (PROGN (LETT |ind| (CAR #9#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |k| 1) (LETT #8# (QREFELT $ 11)) G190
                         (COND ((|greater_SI| |k| #8#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT JV
                                 (CONS
                                  (SPADCALL
                                   (PROG1 (LETT #7# |k|)
                                     (|check_subtype2| (> #7# 0)
                                                       '(|PositiveInteger|)
                                                       '(|NonNegativeInteger|)
                                                       #7#))
                                   |ind| (QREFELT $ 54))
                                  JV))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))))
                  (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
             (EXIT
              (SPADCALL
               (SPADCALL
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |i| 1) (LETT #5# (QREFELT $ 9)) G190
                      (COND ((|greater_SI| |i| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS
                               (SPADCALL
                                (PROG1 (LETT #4# |i|)
                                  (|check_subtype2| (> #4# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #4#))
                                (QREFELT $ 44))
                               #6#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #6#))))
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 11)) G190
                      (COND ((|greater_SI| |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL
                                (PROG1 (LETT #1# |i|)
                                  (|check_subtype2| (> #1# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #1#))
                                (QREFELT $ 46))
                               #3#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #3#))))
                (QREFELT $ 94))
               JV (QREFELT $ 94))))))))) 

(SDEFUN |JBC-;variables;NniPiL;30|
        ((|q| (|NonNegativeInteger|)) (|c| (|PositiveInteger|)) ($ (|List| S)))
        (SPROG
         ((JV (|List| S)) (#1=#:G997 NIL) (#2=#:G1009 NIL) (|k| NIL)
          (#3=#:G1008 NIL) (|ind| NIL)
          (|OIndList| (|List| (|List| (|PositiveInteger|))))
          (|NIndList| (|List| (|List| (|PositiveInteger|)))) (#4=#:G989 NIL)
          (#5=#:G1007 NIL) (|j| NIL) (#6=#:G1006 NIL) (#7=#:G1005 NIL)
          (|qq| NIL) (#8=#:G983 NIL) (#9=#:G1004 NIL) (|i| NIL)
          (#10=#:G1003 NIL))
         (SEQ
          (COND ((ZEROP |q|) NIL)
                ('T
                 (SEQ
                  (LETT |OIndList|
                        (PROGN
                         (LETT #10# NIL)
                         (SEQ (LETT |i| |c|) (LETT #9# (QREFELT $ 9)) G190
                              (COND ((> |i| #9#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #10#
                                      (CONS
                                       (LIST
                                        (PROG1 (LETT #8# |i|)
                                          (|check_subtype2| (> #8# 0)
                                                            '(|PositiveInteger|)
                                                            '(|NonNegativeInteger|)
                                                            #8#)))
                                       #10#))))
                              (LETT |i| (+ |i| 1)) (GO G190) G191
                              (EXIT (NREVERSE #10#)))))
                  (SEQ (LETT |qq| 2) (LETT #7# |q|) G190
                       (COND ((|greater_SI| |qq| #7#) (GO G191)))
                       (SEQ (LETT |NIndList| NIL)
                            (SEQ (LETT |ind| NIL) (LETT #6# |OIndList|) G190
                                 (COND
                                  ((OR (ATOM #6#)
                                       (PROGN (LETT |ind| (CAR #6#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |j| (|SPADfirst| |ind|))
                                        (LETT #5# (QREFELT $ 9)) G190
                                        (COND ((> |j| #5#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT |NIndList|
                                                (CONS
                                                 (CONS
                                                  (PROG1 (LETT #4# |j|)
                                                    (|check_subtype2| (> #4# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|NonNegativeInteger|)
                                                                      #4#))
                                                  |ind|)
                                                 |NIndList|))))
                                        (LETT |j| (+ |j| 1)) (GO G190) G191
                                        (EXIT NIL))))
                                 (LETT #6# (CDR #6#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT (LETT |OIndList| (NREVERSE |NIndList|))))
                       (LETT |qq| (|inc_SI| |qq|)) (GO G190) G191 (EXIT NIL))
                  (LETT JV NIL)
                  (SEQ (LETT |ind| NIL) (LETT #3# |OIndList|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |ind| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |k| 1) (LETT #2# (QREFELT $ 11)) G190
                              (COND ((|greater_SI| |k| #2#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT JV
                                      (CONS
                                       (SPADCALL
                                        (PROG1 (LETT #1# |k|)
                                          (|check_subtype2| (> #1# 0)
                                                            '(|PositiveInteger|)
                                                            '(|NonNegativeInteger|)
                                                            #1#))
                                        |ind| (QREFELT $ 54))
                                       JV))))
                              (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                              (EXIT NIL))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT JV))))))) 

(DECLAIM (NOTINLINE |JetBundleCategory&;|)) 

(DEFUN |JetBundleCategory&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|JetBundleCategory&| DV$1))
          (LETT $ (GETREFV 99))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 64 (SPADCALL 1 (QREFELT $ 11) (QREFELT $ 63)))
          (QSETREFV $ 65 (SPADCALL 1 (QREFELT $ 11) (QREFELT $ 63)))
          (QSETREFV $ 67 (SPADCALL (QREFELT $ 64) (QREFELT $ 66)))
          $))) 

(MAKEPROP '|JetBundleCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|PositiveInteger|)
              (0 . |numIndVar|) '|nn| (4 . |numDepVar|) '|mm| (8 . |One|)
              (|List| 7) (|List| 16) |JBC-;m2r;LL;1| (|NonNegativeInteger|)
              (12 . |new|) (|Integer|) (18 . |elt|) (24 . |setelt!|)
              |JBC-;r2m;LL;2| (31 . |copy|) (|List| 13) (36 . |allRepeated|)
              (41 . |cons|) (|Mapping| 13 13) (47 . |map|) (53 . |concat!|)
              |JBC-;allRepeated;LL;3| (59 . |multiIndex|) (64 . |m2r|)
              |JBC-;repeatedIndex;SL;4| |JBC-;class;LNni;5| (|Symbol|)
              (69 . |type|) (|Boolean|) (74 . ~=) (80 . |class|)
              |JBC-;class;SNni;6| |JBC-;order;SNni;7| (85 . |binomial|)
              |JBC-;dimJ;2Nni;18| |JBC-;dimS;2Nni;19| (91 . X) |JBC-;X;S;10|
              (96 . U) |JBC-;U;S;11| (101 . P) |JBC-;P;LS;12| (107 . |Pm|)
              |JBC-;P;PiNniS;13| |JBC-;P;NniS;14| (113 . |getNotation|)
              (117 . |Pr|) |JBC-;P;PiLS;15| (123 . |r2m|) |JBC-;Pr;PiLS;16|
              (128 . |name|) (|OutputForm|) (133 . |coerce|)
              |JBC-;coerce;SOf;17| (|Vector| 16) (138 . |new|) '|dimJV|
              '|dimSV| (144 . |minIndex|) '|mn| (149 . |#|) (154 . |copy|)
              (159 . |index|) (164 . |repeatedIndex|) (169 . |concat!|)
              (|Union| $ '"0") |JBC-;differentiate;SPiU;20| (175 . ~=)
              |JBC-;derivativeOf?;2SL;21| (181 . |qelt|) (187 . |position|)
              (193 . |delete|) (|Union| $ '"failed")
              |JBC-;integrateIfCan;SPiU;22| (199 . |integrateIfCan|)
              |JBC-;integrate;SPiS;23| |JBC-;weight;SNni;24| |JBC-;one?;SB;25|
              (205 . =) |JBC-;=;2SB;26| (211 . |order|) (216 . ~=)
              |JBC-;<;2SB;27| (222 . <) |JBC-;>;2SB;28| (|List| 6)
              (228 . |concat!|) (|List| $) |JBC-;variables;NniL;29|
              |JBC-;variables;NniPiL;30| (|Expression| 18))
           '#(|weight| 234 |variables| 239 |repeatedIndex| 250 |r2m| 255
              |order| 260 |one?| 265 |m2r| 270 |integrateIfCan| 275 |integrate|
              281 |dimS| 287 |dimJ| 292 |differentiate| 297 |derivativeOf?| 303
              |coerce| 309 |class| 314 |allRepeated| 324 X 329 U 333 |Pr| 337 P
              343 > 365 = 371 < 377)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|dimS|
                                 ((|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|dimJ|
                                 ((|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|variables|
                                 ((|List| |#1|) (|NonNegativeInteger|)
                                  (|PositiveInteger|)))
                                T)
                              '((|variables|
                                 ((|List| |#1|) (|NonNegativeInteger|)))
                                T)
                              '((P (|#1| (|NonNegativeInteger|))) T)
                              '((P
                                 (|#1| (|PositiveInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((P (|#1| (|List| (|NonNegativeInteger|)))) T)
                              '((U (|#1|)) T) '((X (|#1|)) T)
                              '((|one?| ((|Boolean|) |#1|)) T)
                              '((|Pr|
                                 (|#1| (|PositiveInteger|)
                                  (|List| (|PositiveInteger|))))
                                T)
                              '((P
                                 (|#1| (|PositiveInteger|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((U (|#1| (|PositiveInteger|))) T)
                              '((X (|#1| (|PositiveInteger|))) T)
                              '((|integrate| (|#1| |#1| (|PositiveInteger|)))
                                T)
                              '((|integrateIfCan|
                                 ((|Union| |#1| "failed") |#1|
                                  (|PositiveInteger|)))
                                T)
                              '((|derivativeOf?|
                                 ((|List| (|NonNegativeInteger|)) |#1| |#1|))
                                T)
                              '((|differentiate|
                                 ((|Union| |#1| "0") |#1| (|PositiveInteger|)))
                                T)
                              '((|weight| ((|NonNegativeInteger|) |#1|)) T)
                              '((|order| ((|NonNegativeInteger|) |#1|)) T)
                              '((|class| ((|NonNegativeInteger|) |#1|)) T)
                              '((|class|
                                 ((|NonNegativeInteger|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|allRepeated|
                                 ((|List| (|List| (|PositiveInteger|)))
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|m2r|
                                 ((|List| (|PositiveInteger|))
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|r2m|
                                 ((|List| (|NonNegativeInteger|))
                                  (|List| (|PositiveInteger|))))
                                T)
                              '((|repeatedIndex|
                                 ((|List| (|PositiveInteger|)) |#1|))
                                T)
                              '((|coerce| ((|Expression| (|Integer|)) |#1|)) T)
                              '((> ((|Boolean|) |#1| |#1|)) T)
                              '((< ((|Boolean|) |#1| |#1|)) T)
                              '((|coerce| ((|OutputForm|) |#1|)) T)
                              '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 97
                                            '(0 6 7 8 0 6 7 10 0 6 0 12 2 14 0
                                              16 16 17 2 14 16 0 18 19 3 14 16
                                              0 18 16 20 1 14 0 0 22 1 6 23 14
                                              24 2 13 0 7 0 25 2 23 0 26 0 27 2
                                              23 0 0 0 28 1 6 14 0 30 1 6 13 14
                                              31 1 6 34 0 35 2 34 36 0 0 37 1 6
                                              16 14 38 2 18 0 0 0 41 1 6 0 7 44
                                              1 6 0 7 46 2 6 0 7 14 48 2 6 0 7
                                              14 50 0 6 34 53 2 6 0 7 13 54 1 6
                                              14 13 56 1 6 34 0 58 1 34 59 0 60
                                              2 62 0 16 16 63 1 62 18 0 66 1 62
                                              16 0 68 1 62 0 0 69 1 6 7 0 70 1
                                              6 13 0 71 2 13 0 0 0 72 2 7 36 0
                                              0 75 2 14 16 0 18 77 2 13 18 7 0
                                              78 2 13 0 0 18 79 2 6 80 0 7 82 2
                                              14 36 0 0 86 1 6 16 0 88 2 16 36
                                              0 0 89 2 6 36 0 0 91 2 93 0 0 0
                                              94 1 0 16 0 84 2 0 95 16 7 97 1 0
                                              95 16 96 1 0 13 0 32 1 0 14 13 21
                                              1 0 16 0 40 1 0 36 0 85 1 0 13 14
                                              15 2 0 80 0 7 81 2 0 0 0 7 83 1 0
                                              16 16 43 1 0 16 16 42 2 0 73 0 7
                                              74 2 0 14 0 0 76 1 0 59 0 61 1 0
                                              16 0 39 1 0 16 14 33 1 0 23 14 29
                                              0 0 0 45 0 0 0 47 2 0 0 7 13 57 1
                                              0 0 16 52 1 0 0 14 49 2 0 0 7 16
                                              51 2 0 0 7 14 55 2 0 36 0 0 92 2
                                              0 36 0 0 87 2 0 36 0 0 90)))))
           '|lookupComplete|)) 
