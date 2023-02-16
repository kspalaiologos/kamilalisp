
(SDEFUN |LODOF2;convertUPtoUTS|
        ((|np| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         ($ (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var| |cen|)))
        (SPADCALL |np| (QREFELT $ 10))) 

(SDEFUN |LODOF2;convertUTStoUP|
        ((|ns|
          (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var| |cen|))
         (|n| (|Integer|))
         ($ (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
        (SPADCALL |ns| (- |n| 1) (QREFELT $ 16))) 

(SDEFUN |LODOF2;convertL3toLL|
        ((|f|
          #1=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariatePolynomial|
                                                     |var|
                                                     (|Expression|
                                                      (|Integer|)))
                                                    (|Fraction|
                                                     (|UnivariatePolynomial|
                                                      |var|
                                                      (|Expression|
                                                       (|Integer|))))))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|ftmp| #1#)
          (|apf|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#2=#:G801 NIL)
          (|den|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|lc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (SEQ (LETT |apf| (|spadConstant| $ 18)) (LETT |ftmp| |f|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |ftmp| (|spadConstant| $ 22) (QREFELT $ 24)))
                     (GO G191)))
                   (SEQ (LETT |lc| (SPADCALL |ftmp| (QREFELT $ 26)))
                        (LETT |den|
                              (SPADCALL
                               (|LODOF2;convertUPtoUTS|
                                (SPADCALL |lc| (QREFELT $ 27)) $)
                               (QREFELT $ 28)))
                        (LETT |apf|
                              (SPADCALL |apf|
                                        (SPADCALL
                                         (SPADCALL
                                          (|LODOF2;convertUPtoUTS|
                                           (SPADCALL |lc| (QREFELT $ 29)) $)
                                          (PROG2
                                              (LETT #2#
                                                    (SPADCALL |den|
                                                              (QREFELT $ 31)))
                                              (QCDR #2#)
                                            (|check_union2| (QEQCAR #2# 0)
                                                            (|UnivariateLaurentSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))
                                                            (|Union|
                                                             (|UnivariateLaurentSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7))
                                                             "failed")
                                                            #2#))
                                          (QREFELT $ 32))
                                         (SPADCALL |ftmp| (QREFELT $ 33))
                                         (QREFELT $ 34))
                                        (QREFELT $ 35)))
                        (EXIT (LETT |ftmp| (SPADCALL |ftmp| (QREFELT $ 36)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |apf|)))) 

(SDEFUN |LODOF2;newtonpolygonPoints|
        ((|f|
          #1=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)))
         ($ (|List| (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))))
        (SPROG
         ((|npg|
           (|List| #2=(|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|)))))
          (|ccw| (|Boolean|)) (|sb2| #3=(|Integer|)) (|sb1| #3#) (|p2| #2#)
          (|p1| #2#) (#4=#:G834 NIL) (|i| NIL)
          (|points3|
           (|List| (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|)))))
          (|points|
           (|List| (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|)))))
          (|ftmp| #1#) (|yzero| (|Integer|)) (|yv| (|Integer|))
          (|xv| (|NonNegativeInteger|)))
         (SEQ (LETT |ftmp| |f|) (LETT |points| NIL)
              (LETT |yzero|
                    (SPADCALL (SPADCALL |ftmp| (QREFELT $ 37)) (QREFELT $ 39)))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |ftmp| (|spadConstant| $ 18) (QREFELT $ 40)))
                     (GO G191)))
                   (SEQ (LETT |xv| (SPADCALL |ftmp| (QREFELT $ 41)))
                        (LETT |yv|
                              (SPADCALL (SPADCALL |ftmp| (QREFELT $ 37))
                                        (SPADCALL (SPADCALL |f| (QREFELT $ 37))
                                                  (QREFELT $ 39))
                                        (QREFELT $ 42)))
                        (COND
                         ((SPADCALL |xv| 0 (QREFELT $ 43))
                          (LETT |points| (CONS (CONS |xv| |yv|) |points|))))
                        (LETT |yzero| (MIN |yzero| |yv|))
                        (EXIT (LETT |ftmp| (SPADCALL |ftmp| (QREFELT $ 44)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |points| (CONS (CONS 0 |yzero|) |points|))
              (LETT |npg|
                    (LIST (SPADCALL |points| 2 (QREFELT $ 47))
                          (SPADCALL |points| 1 (QREFELT $ 47))))
              (LETT |points3| (CDR (CDR |points|)))
              (SEQ (LETT |i| NIL) (LETT #4# |points3|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |i| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ccw| 'T)
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((> (LENGTH |npg|) 1) |ccw|) ('T NIL)))
                               (GO G191)))
                             (SEQ (LETT |p1| (SPADCALL |npg| 2 (QREFELT $ 47)))
                                  (LETT |p2| (SPADCALL |npg| 1 (QREFELT $ 47)))
                                  (LETT |sb1|
                                        (* (- (QCAR |p2|) (QCAR |p1|))
                                           (- (QCDR |i|) (QCDR |p1|))))
                                  (LETT |sb2|
                                        (* (- (QCDR |p2|) (QCDR |p1|))
                                           (- (QCAR |i|) (QCAR |p1|))))
                                  (LETT |ccw| (<= (- |sb1| |sb2|) 0))
                                  (EXIT
                                   (COND (|ccw| (LETT |npg| (CDR |npg|))))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT (LETT |npg| (CONS |i| |npg|))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |npg|))))) 

(SDEFUN |LODOF2;newtonpolygon|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         ($
          (|List|
           (|Record|
            (|:| |point|
                 (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
            (|:| |slope| (|Fraction| (|Integer|)))
            (|:| |npoly|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (SPROG
         ((|res|
           (|List|
            (|Record|
             (|:| |point|
                  (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
             (|:| |slope| (|Fraction| (|Integer|)))
             (|:| |npoly|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
          (|npol| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|lsc| (|Expression| (|Integer|)))
          (|opc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|ind| (|NonNegativeInteger|)) (#1=#:G849 NIL) (|j| NIL)
          (|slop| (|Fraction| (|Integer|))) (#2=#:G847 NIL) (|i| NIL)
          (#3=#:G848 NIL) (|nxt| NIL)
          (|restl|
           (|List| (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|)))))
          (|npg|
           (|List| (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))))
         (SEQ (LETT |npg| (|LODOF2;newtonpolygonPoints| |f| $))
              (LETT |res| NIL) (LETT |restl| (CDR |npg|))
              (SEQ (LETT |nxt| NIL) (LETT #3# |restl|) (LETT |i| NIL)
                   (LETT #2# |npg|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL) (ATOM #3#)
                         (PROGN (LETT |nxt| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |slop|
                          (SPADCALL (- (QCDR |nxt|) (QCDR |i|))
                                    (- (QCAR |nxt|) (QCAR |i|))
                                    (QREFELT $ 49)))
                    (LETT |npol| (|spadConstant| $ 50))
                    (SEQ (LETT |j| 0)
                         (LETT #1#
                               (QUOTIENT2 (- (QCAR |nxt|) (QCAR |i|))
                                          (SPADCALL |slop| (QREFELT $ 51))))
                         G190 (COND ((|greater_SI| |j| #1#) (GO G191)))
                         (SEQ
                          (LETT |ind|
                                (+ (* (SPADCALL |slop| (QREFELT $ 51)) |j|)
                                   (QCAR |i|)))
                          (LETT |opc| (SPADCALL |f| |ind| (QREFELT $ 52)))
                          (LETT |lsc|
                                (SPADCALL |opc|
                                          (+
                                           (* |j|
                                              (SPADCALL |slop| (QREFELT $ 53)))
                                           (QCDR |i|))
                                          (QREFELT $ 54)))
                          (EXIT
                           (LETT |npol|
                                 (SPADCALL |npol|
                                           (SPADCALL |lsc| |j| (QREFELT $ 55))
                                           (QREFELT $ 56)))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res| (LIST (VECTOR |i| |slop| |npol|))
                                     (QREFELT $ 59)))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;testnp;LodoL;6|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         ($
          (|List|
           (|Record|
            (|:| |point|
                 (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
            (|:| |slope| (|Fraction| (|Integer|)))
            (|:| |npoly|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (|LODOF2;newtonpolygon| (|LODOF2;convertL3toLL| |f| $) $)) 

(SDEFUN |LODOF2;factor_newton|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|List|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))))
        (SPROG
         ((|res|
           (|List|
            (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    |var| |cen|)
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    |var| |cen|))))
          (#1=#:G894 NIL)
          (|jl|
           (|Record|
            (|:| |Qt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |Rt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (#2=#:G907 NIL) (|i| NIL) (|slo| #3=(|Fraction| (|Integer|)))
          (|v|
           #4=(|List|
               (|Record|
                (|:| |factor|
                     (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
                (|:| |exponent| (|NonNegativeInteger|)))))
          (#5=#:G906 NIL) (#6=#:G905 NIL) (|v_old| #4#)
          (|unsafe|
           (|List|
            (|Record|
             (|:| |factor|
                  #7=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |exponent| (|NonNegativeInteger|)))))
          (|sbt| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|newx| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|ie| (|Integer|)) (|e| (|Expression| (|Integer|)))
          (|d| (|NonNegativeInteger|)) (|vjf| #7#) (#8=#:G903 NIL) (|j| NIL)
          (#9=#:G904 NIL) (|jj| NIL) (|dvif| (|NonNegativeInteger|))
          (|vif| #7#) (#10=#:G900 NIL) (#11=#:G901 NIL) (|ii| NIL)
          (#12=#:G902 NIL) (|restl| NIL) (#13=#:G898 NIL) (#14=#:G899 NIL)
          (|semi|
           (|OneDimensionalArray|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (#15=#:G897 NIL) (|il| NIL) (#16=#:G896 NIL)
          (|npol|
           #17=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (#18=#:G895 NIL) (|k| NIL)
          (|np|
           (|List|
            (|Record|
             (|:| |point|
                  (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
             (|:| |slope| #3#) (|:| |npoly| #17#)))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((<= (SPADCALL |f| (QREFELT $ 41)) 1)
              (PROGN (LETT #1# (LIST |f|)) (GO #19=#:G893))))
            (LETT |np| (|LODOF2;newtonpolygon| |f| $)) (LETT |res| NIL)
            (SEQ (LETT |k| NIL) (LETT #18# |np|) G190
                 (COND
                  ((OR (ATOM #18#) (PROGN (LETT |k| (CAR #18#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |npol| (QVELT |k| 2))
                      (LETT |v|
                            (SPADCALL (|LODOF2;factorUP| |npol| |factorizer| $)
                                      (QREFELT $ 64)))
                      (COND
                       ((SPADCALL (QVELT |k| 1) (|spadConstant| $ 65)
                                  (QREFELT $ 66))
                        (LETT |v|
                              (PROGN
                               (LETT #16# NIL)
                               (SEQ (LETT |il| NIL) (LETT #15# |v|) G190
                                    (COND
                                     ((OR (ATOM #15#)
                                          (PROGN (LETT |il| (CAR #15#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #16#
                                            (CONS
                                             (CONS
                                              (SPADCALL (QCAR |il|) (QCDR |il|)
                                                        (QREFELT $ 67))
                                              0)
                                             #16#))))
                                    (LETT #15# (CDR #15#)) (GO G190) G191
                                    (EXIT (NREVERSE #16#))))))
                       ('T
                        (SEQ (LETT |unsafe| NIL)
                             (LETT |semi|
                                   (MAKEARR1 (LENGTH |v|)
                                             (|spadConstant| $ 50)))
                             (SEQ (LETT |ii| 1) (LETT #14# (LENGTH |v|))
                                  (LETT |i| NIL) (LETT #13# |v|) G190
                                  (COND
                                   ((OR (ATOM #13#)
                                        (PROGN (LETT |i| (CAR #13#)) NIL)
                                        (|greater_SI| |ii| #14#))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SPADCALL |semi| |ii|
                                              (SPADCALL (QCAR |i|) (QCDR |i|)
                                                        (QREFELT $ 67))
                                              (QREFELT $ 69))))
                                  (LETT #13#
                                        (PROG1 (CDR #13#)
                                          (LETT |ii| (|inc_SI| |ii|))))
                                  (GO G190) G191 (EXIT NIL))
                             (SEQ (LETT |restl| NIL)
                                  (LETT #12#
                                        (SPADCALL (CDR |v|) (QREFELT $ 71)))
                                  (LETT |ii| 1) (LETT #11# (LENGTH |v|))
                                  (LETT |i| NIL) (LETT #10# |v|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |i| (CAR #10#)) NIL)
                                        (|greater_SI| |ii| #11#) (ATOM #12#)
                                        (PROGN (LETT |restl| (CAR #12#)) NIL))
                                    (GO G191)))
                                  (SEQ (LETT |vif| (QCAR |i|))
                                       (LETT |dvif|
                                             (SPADCALL |vif| (QREFELT $ 72)))
                                       (EXIT
                                        (SEQ (LETT |jj| (+ |ii| 1))
                                             (LETT #9# (LENGTH |v|))
                                             (LETT |j| NIL) (LETT #8# |restl|)
                                             G190
                                             (COND
                                              ((OR (ATOM #8#)
                                                   (PROGN
                                                    (LETT |j| (CAR #8#))
                                                    NIL)
                                                   (> |jj| #9#))
                                               (GO G191)))
                                             (SEQ (LETT |vjf| (QCAR |j|))
                                                  (EXIT
                                                   (COND
                                                    ((EQL |dvif|
                                                          (SPADCALL |vjf|
                                                                    (QREFELT $
                                                                             72)))
                                                     (SEQ
                                                      (LETT |d| (- |dvif| 1))
                                                      (LETT |e|
                                                            (SPADCALL
                                                             (SPADCALL |vif|
                                                                       |d|
                                                                       (QREFELT
                                                                        $ 73))
                                                             (SPADCALL |vjf|
                                                                       |d|
                                                                       (QREFELT
                                                                        $ 73))
                                                             (QREFELT $ 74)))
                                                      (LETT |e|
                                                            (SPADCALL |e|
                                                                      (SPADCALL
                                                                       |dvif|
                                                                       (QREFELT
                                                                        $ 75))
                                                                      (QREFELT
                                                                       $ 76)))
                                                      (EXIT
                                                       (COND
                                                        ((SPADCALL |e|
                                                                   (QREFELT $
                                                                            78))
                                                         (COND
                                                          ((SPADCALL |e|
                                                                     (|spadConstant|
                                                                      $ 19)
                                                                     (QREFELT $
                                                                              79))
                                                           (SEQ
                                                            (LETT |ie|
                                                                  (SPADCALL |e|
                                                                            (QREFELT
                                                                             $
                                                                             80)))
                                                            (LETT |newx|
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (|spadConstant|
                                                                     $ 12)
                                                                    1
                                                                    (QREFELT $
                                                                             55))
                                                                   (SPADCALL
                                                                    |ie|
                                                                    (QREFELT $
                                                                             81))
                                                                   (QREFELT $
                                                                            56)))
                                                            (LETT |sbt|
                                                                  (SPADCALL
                                                                   |vjf|
                                                                   (SPADCALL
                                                                    (|spadConstant|
                                                                     $ 12)
                                                                    1
                                                                    (QREFELT $
                                                                             55))
                                                                   |newx|
                                                                   (QREFELT $
                                                                            82)))
                                                            (EXIT
                                                             (COND
                                                              ((SPADCALL
                                                                (SPADCALL |vif|
                                                                          |sbt|
                                                                          (QREFELT
                                                                           $
                                                                           83))
                                                                (|spadConstant|
                                                                 $ 50)
                                                                (QREFELT $ 84))
                                                               (COND
                                                                ((> |ie| 0)
                                                                 (SEQ
                                                                  (LETT
                                                                   |unsafe|
                                                                   (CONS |i|
                                                                         |unsafe|))
                                                                  (EXIT
                                                                   (SPADCALL
                                                                    |semi| |jj|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |semi|
                                                                      |jj|
                                                                      (QREFELT
                                                                       $ 85))
                                                                     (SPADCALL
                                                                      |vif|
                                                                      (QCDR
                                                                       |i|)
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              86))
                                                                    (QREFELT $
                                                                             69)))))
                                                                ('T
                                                                 (SEQ
                                                                  (LETT
                                                                   |unsafe|
                                                                   (CONS |j|
                                                                         |unsafe|))
                                                                  (EXIT
                                                                   (SPADCALL
                                                                    |semi| |ii|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |semi|
                                                                      |ii|
                                                                      (QREFELT
                                                                       $ 85))
                                                                     (SPADCALL
                                                                      |vjf|
                                                                      (QCDR
                                                                       |j|)
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              86))
                                                                    (QREFELT $
                                                                             69))))))))))))))))))))
                                             (LETT #8#
                                                   (PROG1 (CDR #8#)
                                                     (LETT |jj| (+ |jj| 1))))
                                             (GO G190) G191 (EXIT NIL))))
                                  (LETT #10#
                                        (PROG1 (CDR #10#)
                                          (LETT |ii|
                                                (PROG1 (|inc_SI| |ii|)
                                                  (LETT #12# (CDR #12#))))))
                                  (GO G190) G191 (EXIT NIL))
                             (LETT |v_old| |v|)
                             (LETT |v| (SPADCALL |v| |unsafe| (QREFELT $ 87)))
                             (EXIT
                              (COND
                               ((EQUAL |option| "semireg")
                                (LETT |v|
                                      (PROGN
                                       (LETT #6# NIL)
                                       (SEQ (LETT |i| NIL) (LETT #5# |v|) G190
                                            (COND
                                             ((OR (ATOM #5#)
                                                  (PROGN
                                                   (LETT |i| (CAR #5#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #6#
                                                    (CONS
                                                     (CONS
                                                      (SPADCALL |semi|
                                                                (SPADCALL |i|
                                                                          |v_old|
                                                                          (QREFELT
                                                                           $
                                                                           88))
                                                                (QREFELT $ 85))
                                                      1)
                                                     #6#))))
                                            (LETT #5# (CDR #5#)) (GO G190) G191
                                            (EXIT (NREVERSE #6#)))))))))))
                      (LETT |slo| (QVELT |k| 1))
                      (COND
                       ((EQL
                         (*
                          (SPADCALL (QCAR (SPADCALL |v| 1 (QREFELT $ 89)))
                                    (QREFELT $ 72))
                          (SPADCALL |slo| (QREFELT $ 51)))
                         (SPADCALL |f| (QREFELT $ 41)))
                        (PROGN (LETT #1# (LIST |f|)) (GO #19#))))
                      (EXIT
                       (SEQ (LETT |i| NIL) (LETT #2# |v|) G190
                            (COND
                             ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |jl|
                                   (|LODOF2;factor_newton2| |f| (QCAR |i|) |k|
                                    $))
                             (COND
                              ((EQUAL |option| "alg factor")
                               (PROGN (LETT #1# (LIST (QCDR |jl|))) (GO #19#)))
                              ((EQUAL |option| "split over k((x))")
                               (PROGN
                                (LETT #1#
                                      (SPADCALL
                                       (|LODOF2;factor_newton| (QCAR |jl|)
                                        |factorizer| |option| $)
                                       (LIST (QCDR |jl|)) (QREFELT $ 91)))
                                (GO #19#))))
                             (EXIT
                              (LETT |res|
                                    (SPADCALL |res| (LIST (QCDR |jl|))
                                              (QREFELT $ 91)))))
                            (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #18# (CDR #18#)) (GO G190) G191 (EXIT NIL))
            (EXIT |res|)))
          #19# (EXIT #1#)))) 

(SDEFUN |LODOF2;testfn;LodoMSL;8|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|List|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))))
        (|LODOF2;factor_newton| (|LODOF2;convertL3toLL| |f| $) |factorizer|
         |option| $)) 

(SDEFUN |LODOF2;factorUP|
        ((|np| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|factorSUP|
          (|Mapping|
           #1=(|Factored|
               (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         ($
          (|Factored|
           (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
        (SPROG
         ((|fsnp| #1#)
          (|snp| (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (SEQ (LETT |snp| (SPADCALL |np| (QREFELT $ 96)))
              (LETT |fsnp| (SPADCALL |snp| |factorSUP|))
              (EXIT (SPADCALL (ELT $ 97) |fsnp| (QREFELT $ 101)))))) 

(SDEFUN |LODOF2;factor_newton2|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|r| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|l|
          (|Record|
           (|:| |point| (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
           (|:| |slope| #1=(|Fraction| (|Integer|)))
           (|:| |npoly|
                #2=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         ($
          (|Record|
           (|:| |Qt|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |Rt|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|))))))
        (SPROG
         ((|right|
           #3=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)))
          (|left| #3#)
          (|llr|
           (|Record|
            (|:| |laurl|
                 (|List|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |laurr|
                 (|List|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (|lcr|
           (|Record|
            (|:| |llc|
                 (|List|
                  (|Stream|
                   (|Record| (|:| |k| (|Integer|))
                             (|:| |c| (|Expression| (|Integer|)))))))
            (|:| |rlc|
                 (|List|
                  (|Stream|
                   (|Record| (|:| |k| (|Integer|))
                             (|:| |c| (|Expression| (|Integer|)))))))))
          (|lwr|
           (|Stream|
            (|Record|
             (|:| |Qt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |Rt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|))))))
          (|ordl| (|Integer|)) (|ordr| (|Integer|))
          (|npor| #4=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|npo| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|mlr| #4#) (|shift| (|Fraction| (|Integer|))) (|npol| #2#)
          (|xcd| (|Integer|)) (|ycd| (|Integer|)) (|slop| #1#))
         (SEQ (LETT |slop| (QVELT |l| 1)) (LETT |ycd| (QCDR (QVELT |l| 0)))
              (LETT |xcd| (QCAR (QVELT |l| 0))) (LETT |npol| (QVELT |l| 2))
              (LETT |shift|
                    (SPADCALL (|spadConstant| $ 65)
                              (SPADCALL (SPADCALL |ycd| (QREFELT $ 102))
                                        (SPADCALL
                                         (- (SPADCALL |f| (QREFELT $ 41))
                                            |xcd|)
                                         |slop| (QREFELT $ 103))
                                        (QREFELT $ 104))
                              (QREFELT $ 105)))
              (LETT |npo|
                    (SPADCALL (|spadConstant| $ 12) |xcd| (QREFELT $ 55)))
              (LETT |mlr|
                    (SPADCALL (SPADCALL |npol| |r| (QREFELT $ 106))
                              (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 55))
                              (SPADCALL (|spadConstant| $ 12)
                                        (SPADCALL |slop| (QREFELT $ 51))
                                        (QREFELT $ 55))
                              (QREFELT $ 82)))
              (LETT |npo| (SPADCALL |npo| |mlr| (QREFELT $ 86)))
              (LETT |npor|
                    (SPADCALL |r|
                              (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 55))
                              (SPADCALL (|spadConstant| $ 12)
                                        (SPADCALL |slop| (QREFELT $ 51))
                                        (QREFELT $ 55))
                              (QREFELT $ 82)))
              (LETT |ordr|
                    (* (SPADCALL |r| (QREFELT $ 72))
                       (SPADCALL |slop| (QREFELT $ 51))))
              (LETT |ordl| (- (SPADCALL |f| (QREFELT $ 41)) |ordr|))
              (LETT |lwr|
                    (|LODOF2;ln_wrapper| |slop| |f| |npo| |npor| |shift| |ordr|
                     $))
              (LETT |lcr|
                    (|LODOF2;listream_coefs| |lwr| |ordl| |ordr| |shift| |slop|
                     $))
              (LETT |llr| (|LODOF2;list_laurent| |lcr| |ordl| |ordr| $))
              (LETT |left| (|LODOF2;laurent_op| (QCAR |llr|) |ordl| $))
              (LETT |right| (|LODOF2;laurent_op| (QCDR |llr|) |ordr| $))
              (EXIT (CONS |left| |right|))))) 

(SDEFUN |LODOF2;testf2;LodoUpFR;11|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|r| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|slop| (|Fraction| (|Integer|)))
         ($
          (|Record|
           (|:| |Qt|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |Rt|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|))))))
        (SPROG
         ((|l|
           #1=(|Record|
               (|:| |point|
                    (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
               (|:| |slope| (|Fraction| (|Integer|)))
               (|:| |npoly|
                    (|UnivariatePolynomial| |var|
                                            (|Expression| (|Integer|))))))
          (#2=#:G927 NIL) (|i| NIL) (|np| (|List| #1#)))
         (SEQ
          (LETT |np| (|LODOF2;newtonpolygon| (|LODOF2;convertL3toLL| |f| $) $))
          (SEQ (LETT |i| NIL) (LETT #2# |np|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL (QVELT |i| 1) |slop| (QREFELT $ 107))
                   (LETT |l| |i|)))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (|LODOF2;factor_newton2| (|LODOF2;convertL3toLL| |f| $) |r| |l|
            $))))) 

(SDEFUN |LODOF2;laurent_op|
        ((|llaur|
          (|List|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|)))
         (|dgf| (|Integer|))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|f|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#1=#:G932 NIL) (|i| NIL))
         (SEQ (LETT |f| (|spadConstant| $ 18))
              (SEQ (LETT |i| 0) (LETT #1# |dgf|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |f|
                           (SPADCALL |f|
                                     (SPADCALL
                                      (SPADCALL |llaur| (+ |i| 1)
                                                (QREFELT $ 111))
                                      |i| (QREFELT $ 34))
                                     (QREFELT $ 35)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |f|)))) 

(SDEFUN |LODOF2;list_laurent|
        ((|lsc|
          (|Record|
           (|:| |llc|
                (|List|
                 (|Stream|
                  (|Record| (|:| |k| (|Integer|))
                            (|:| |c| (|Expression| (|Integer|)))))))
           (|:| |rlc|
                (|List|
                 (|Stream|
                  (|Record| (|:| |k| (|Integer|))
                            (|:| |c| (|Expression| (|Integer|)))))))))
         (|dgl| (|Integer|)) (|dgr| (|Integer|))
         ($
          (|Record|
           (|:| |laurl|
                (|List|
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |laurr|
                (|List|
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|))))))
        (SPROG
         ((|laurer|
           #1=(|List|
               (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                          |cen|)))
          (|laurel| #1#))
         (SEQ (LETT |laurel| (|LODOF2;list_laurentop| (QCAR |lsc|) |dgl| $))
              (LETT |laurer| (|LODOF2;list_laurentop| (QCDR |lsc|) |dgr| $))
              (EXIT (CONS |laurel| |laurer|))))) 

(SDEFUN |LODOF2;testll;FLodo2UpFIR;14|
        ((|slop| (|Fraction| (|Integer|)))
         (|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|l_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|r_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|shift| (|Fraction| (|Integer|))) (|dgr| (|Integer|))
         ($
          (|Record|
           (|:| |laurl|
                (|List|
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |laurr|
                (|List|
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|))))))
        (SPROG
         ((|lcr|
           (|Record|
            (|:| |llc|
                 (|List|
                  (|Stream|
                   (|Record| (|:| |k| (|Integer|))
                             (|:| |c| (|Expression| (|Integer|)))))))
            (|:| |rlc|
                 (|List|
                  (|Stream|
                   (|Record| (|:| |k| (|Integer|))
                             (|:| |c| (|Expression| (|Integer|)))))))))
          (|lwr|
           (|Stream|
            (|Record|
             (|:| |Qt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |Rt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))))))
         (SEQ
          (LETT |lwr|
                (|LODOF2;ln_wrapper| |slop| (|LODOF2;convertL3toLL| |f| $)
                 |l_low| |r_low| |shift| |dgr| $))
          (LETT |lcr|
                (|LODOF2;listream_coefs| |lwr|
                 (- (SPADCALL |f| (QREFELT $ 33)) |dgr|) |dgr| |shift| |slop|
                 $))
          (EXIT
           (|LODOF2;list_laurent| |lcr| (- (SPADCALL |f| (QREFELT $ 33)) |dgr|)
            |dgr| $))))) 

(SDEFUN |LODOF2;list_laurentop|
        ((|lsc|
          (|List|
           (|Stream|
            (|Record| (|:| |k| (|Integer|))
                      (|:| |c| (|Expression| (|Integer|)))))))
         (|dgf| (|Integer|))
         ($
          (|List|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                      |cen|))))
        (SPROG
         ((|res|
           (|List|
            (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                       |cen|)))
          (#1=#:G947 NIL) (|i| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |i| 0) (LETT #1# |dgf|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (LIST
                                      (SPADCALL
                                       (SPADCALL |lsc| (+ |i| 1)
                                                 (QREFELT $ 117))
                                       (QREFELT $ 118)))
                                     (QREFELT $ 119)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;listream_coefs|
        ((|slr|
          (|Stream|
           (|Record|
            (|:| |Qt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |Rt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|))))))
         (|dgl| (|Integer|)) (|dgr| (|Integer|))
         (|shift| (|Fraction| (|Integer|))) (|slop| (|Fraction| (|Integer|)))
         ($
          (|Record|
           (|:| |llc|
                (|List|
                 (|Stream|
                  (|Record| (|:| |k| (|Integer|))
                            (|:| |c| (|Expression| (|Integer|)))))))
           (|:| |rlc|
                (|List|
                 (|Stream|
                  (|Record| (|:| |k| (|Integer|))
                            (|:| |c| (|Expression| (|Integer|))))))))))
        (SPROG
         ((|rsc|
           #1=(|List|
               (|Stream|
                (|Record| (|:| |k| (|Integer|))
                          (|:| |c| (|Expression| (|Integer|)))))))
          (|re| (|Integer|))
          (|sre|
           #2=(|Stream|
               (|LinearOrdinaryDifferentialOperator3|
                (|Expression| (|Integer|))
                (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                          |cen|)
                (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                           |cen|))))
          (|lsc| #1#) (|le| (|Integer|)) (|sle| #2#))
         (SEQ
          (LETT |sle|
                (SPADCALL (LIST #'|LODOF2;listream_coefs!0|) |slr|
                          (QREFELT $ 124)))
          (LETT |le|
                (SPADCALL
                 (SPADCALL (SPADCALL |slop| (QREFELT $ 51)) |shift|
                           (QREFELT $ 103))
                 (QREFELT $ 125)))
          (LETT |le| (- |le| (* (SPADCALL |slop| (QREFELT $ 53)) |dgl|)))
          (LETT |lsc| (|LODOF2;listream_coefsop| |sle| |dgl| |le| |slop| $))
          (LETT |sre|
                (SPADCALL (LIST #'|LODOF2;listream_coefs!1|) |slr|
                          (QREFELT $ 124)))
          (LETT |re| (- (* (SPADCALL |slop| (QREFELT $ 53)) |dgr|)))
          (LETT |rsc| (|LODOF2;listream_coefsop| |sre| |dgr| |re| |slop| $))
          (EXIT (CONS |lsc| |rsc|))))) 

(SDEFUN |LODOF2;listream_coefs!1| ((|landr| NIL) ($$ NIL)) (QCDR |landr|)) 

(SDEFUN |LODOF2;listream_coefs!0| ((|landr| NIL) ($$ NIL)) (QCAR |landr|)) 

(SDEFUN |LODOF2;testlc;FLodo2UpFIR;17|
        ((|slop| (|Fraction| (|Integer|)))
         (|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|l_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|r_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|shift| (|Fraction| (|Integer|))) (|dgr| (|Integer|))
         ($
          (|Record|
           (|:| |llc|
                (|List|
                 (|Stream|
                  (|Record| (|:| |k| (|Integer|))
                            (|:| |c| (|Expression| (|Integer|)))))))
           (|:| |rlc|
                (|List|
                 (|Stream|
                  (|Record| (|:| |k| (|Integer|))
                            (|:| |c| (|Expression| (|Integer|))))))))))
        (SPROG
         ((|lwr|
           (|Stream|
            (|Record|
             (|:| |Qt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |Rt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))))))
         (SEQ
          (LETT |lwr|
                (|LODOF2;ln_wrapper| |slop| (|LODOF2;convertL3toLL| |f| $)
                 |l_low| |r_low| |shift| |dgr| $))
          (EXIT
           (|LODOF2;listream_coefs| |lwr|
            (- (SPADCALL |f| (QREFELT $ 33)) |dgr|) |dgr| |shift| |slop| $))))) 

(SDEFUN |LODOF2;listream_coefsop|
        ((|sfe|
          (|Stream|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|))))
         (|dgf| (|Integer|)) (|fe| (|Integer|))
         (|slop| (|Fraction| (|Integer|)))
         ($
          (|List|
           (|Stream|
            (|Record| (|:| |k| (|Integer|))
                      (|:| |c| (|Expression| (|Integer|))))))))
        (SPROG
         ((|dgc|
           (|List|
            (|Stream|
             (|Record| (|:| |k| (|Integer|))
                       (|:| |c| (|Expression| (|Integer|)))))))
          (|res|
           (|List|
            (|Stream|
             (|Record| (|:| |k| (|Integer|))
                       (|:| |c| (|Expression| (|Integer|)))))))
          (|new_term|
           (|Stream|
            (|Record| (|:| |k| (|Integer|))
                      (|:| |c| (|Expression| (|Integer|))))))
          (|nl_st| (|Stream| (|Integer|))) (#1=#:G986 NIL) (|i| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |i| 0) (LETT #1# (- |dgf| 1)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |nl_st|
                          (SPADCALL (CONS #'|LODOF2;listream_coefsop!0| $) 1
                                    (QREFELT $ 133)))
                    (LETT |new_term|
                          (SPADCALL
                           (CONS #'|LODOF2;listream_coefsop!1|
                                 (VECTOR |i| |fe| |slop| $))
                           |sfe| |nl_st| (QREFELT $ 142)))
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res| (LIST |new_term|)
                                     (QREFELT $ 143)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |dgc|
                    (LIST
                     (SPADCALL (LIST (CONS 0 (|spadConstant| $ 12)))
                               (QREFELT $ 145))))
              (EXIT (SPADCALL |res| |dgc| (QREFELT $ 143)))))) 

(SDEFUN |LODOF2;listream_coefsop!1| ((|x| NIL) (|n_l| NIL) ($$ NIL))
        (PROG ($ |slop| |fe| |i|)
          (LETT $ (QREFELT $$ 3))
          (LETT |slop| (QREFELT $$ 2))
          (LETT |fe| (QREFELT $$ 1))
          (LETT |i| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((#1=#:G972 NIL) (|coefd| NIL) (|cx| NIL) (|deg| NIL)
              (|degn| NIL))
             (SEQ
              (LETT |degn|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL |n_l| (|spadConstant| $ 129) (QREFELT $ 134))
                       (SPADCALL |slop| (QREFELT $ 51)) (QREFELT $ 135))
                      |fe| (QREFELT $ 130))
                     (SPADCALL |i| (SPADCALL |slop| (QREFELT $ 53))
                               (QREFELT $ 136))
                     (QREFELT $ 130)))
              (LETT |deg|
                    (SPADCALL
                     (SPADCALL |degn| (SPADCALL |slop| (QREFELT $ 51))
                               (QREFELT $ 49))
                     (QREFELT $ 138)))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |deg| (CONS 1 "failed") (QREFELT $ 139)))
                     (GO G191)))
                   (SEQ
                    (LETT |degn|
                          (SPADCALL |degn| (|spadConstant| $ 129)
                                    (QREFELT $ 130)))
                    (EXIT
                     (LETT |deg|
                           (SPADCALL
                            (SPADCALL |degn| (SPADCALL |slop| (QREFELT $ 51))
                                      (QREFELT $ 49))
                            (QREFELT $ 138)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |cx| (SPADCALL |x| |i| (QREFELT $ 52)))
              (LETT |coefd|
                    (SPADCALL |cx|
                              (PROG2 (LETT #1# |deg|)
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                                (|Union| (|Integer|)
                                                         #2="failed")
                                                #1#))
                              (QREFELT $ 54)))
              (EXIT
               (CONS
                (PROG2 (LETT #1# |deg|)
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                  (|Union| (|Integer|) #2#) #1#))
                |coefd|)))))))) 

(SDEFUN |LODOF2;listream_coefsop!0| ((|x| NIL) ($ NIL))
        (SPADCALL |x| (|spadConstant| $ 129) (QREFELT $ 130))) 

(SDEFUN |LODOF2;lift_newton|
        ((|slop| (|Fraction| (|Integer|)))
         (|ff|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|l_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|r_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|shift| (|Fraction| (|Integer|))) (|dgr| (|Integer|))
         (|v|
          (|Record|
           (|:| |Qt|
                #1=(|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
           (|:| |Rt|
                #2=(|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))))
         (|ei|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|n_l| (|PositiveInteger|))
         ($
          (|Record|
           (|:| |main|
                (|Record|
                 (|:| |Qt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))
                 (|:| |Rt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))))
           (|:| |nf|
                (|Record|
                 (|:| |Qt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))
                 (|:| |Rt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))))
           (|:| |error|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|))))))
        (SPROG
         ((|ri| #2#) (|li| #1#)
          (|r_extra|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|l_extra|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|pl_extra|
           (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|pr_extra|
           (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|pi| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (#3=#:G1006 NIL) (|i| #4=(|Integer|)) (|fe| #5=(|Integer|))
          (|re| (|Integer|)) (|le| #5#)
          (|c2| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|s|
           (|Record|
            (|:| |coef1|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
            (|:| |coef2|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (#6=#:G996 NIL)
          (|sl_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|dgl| #4#))
         (SEQ (LETT |dgl| (- (SPADCALL |ff| (QREFELT $ 41)) |dgr|))
              (LETT |li| (QCAR |v|)) (LETT |ri| (QCDR |v|))
              (COND
               ((SPADCALL |slop| (|spadConstant| $ 65) (QREFELT $ 107))
                (SEQ (LETT |i| (- |n_l| 1))
                     (COND
                      ((EQL |i| 0)
                       (SEQ (LETT |r_extra| (|LODOF2;plug_delta| |r_low| $))
                            (EXIT
                             (LETT |l_extra|
                                   (SPADCALL (|LODOF2;plug_delta| |l_low| $)
                                             (SPADCALL (|spadConstant| $ 12)
                                                       (SPADCALL |shift|
                                                                 (QREFELT $
                                                                          125))
                                                       (QREFELT $ 146))
                                             (QREFELT $ 147))))))
                      (#7='T
                       (SEQ
                        (LETT |sl_low|
                              (SPADCALL |l_low|
                                        (SPADCALL (|spadConstant| $ 12) 1
                                                  (QREFELT $ 55))
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 12) 1
                                                   (QREFELT $ 55))
                                         (SPADCALL |i| (QREFELT $ 81))
                                         (QREFELT $ 56))
                                        (QREFELT $ 82)))
                        (LETT |s| (SPADCALL |r_low| |sl_low| (QREFELT $ 149)))
                        (COND
                         ((SPADCALL (QVELT |s| 2) (|spadConstant| $ 150)
                                    (QREFELT $ 151))
                          (|error| "unsafe factor")))
                        (LETT |c2| (QVELT |s| 1))
                        (LETT |pi|
                              (|LODOF2;coeffx| |ei|
                               (SPADCALL (SPADCALL |i| (QREFELT $ 102)) |shift|
                                         (QREFELT $ 104))
                               $))
                        (LETT |pr_extra|
                              (SPADCALL
                               (SPADCALL (SPADCALL |c2| |pi| (QREFELT $ 86))
                                         |r_low| (QREFELT $ 152))
                               (QREFELT $ 153)))
                        (LETT |r_extra| (|LODOF2;plug_delta| |pr_extra| $))
                        (LETT |pl_extra|
                              (SPADCALL
                               (SPADCALL |pi|
                                         (SPADCALL |pr_extra| |sl_low|
                                                   (QREFELT $ 86))
                                         (QREFELT $ 56))
                               |r_low| (QREFELT $ 106)))
                        (LETT |l_extra| (|LODOF2;plug_delta| |pl_extra| $))
                        (LETT |l_extra|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 12)
                                          (+ |i|
                                             (SPADCALL |shift|
                                                       (QREFELT $ 125)))
                                          (QREFELT $ 146))
                                |l_extra| (QREFELT $ 157))
                               (QREFELT $ 158)))
                        (EXIT
                         (LETT |r_extra|
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 12) |i|
                                          (QREFELT $ 146))
                                |r_extra| (QREFELT $ 157)))))))
                     (LETT |li| (SPADCALL |li| |l_extra| (QREFELT $ 35)))
                     (LETT |ei|
                           (SPADCALL
                            (SPADCALL |ei|
                                      (SPADCALL |l_extra| |ri| (QREFELT $ 159))
                                      (QREFELT $ 35))
                            (SPADCALL |li| |r_extra| (QREFELT $ 159))
                            (QREFELT $ 35)))
                     (EXIT
                      (LETT |ri| (SPADCALL |ri| |r_extra| (QREFELT $ 35))))))
               (#7#
                (SEQ
                 (LETT |s|
                       (PROG2
                           (LETT #6#
                                 (SPADCALL |r_low| |l_low|
                                           (|spadConstant| $ 150)
                                           (QREFELT $ 162)))
                           (QCDR #6#)
                         (|check_union2| (QEQCAR #6# 0)
                                         (|Record|
                                          (|:| |coef1|
                                               (|UnivariatePolynomial|
                                                (QREFELT $ 6)
                                                (|Expression| (|Integer|))))
                                          (|:| |coef2|
                                               (|UnivariatePolynomial|
                                                (QREFELT $ 6)
                                                (|Expression| (|Integer|)))))
                                         (|Union|
                                          (|Record|
                                           (|:| |coef1|
                                                (|UnivariatePolynomial|
                                                 (QREFELT $ 6)
                                                 (|Expression| (|Integer|))))
                                           (|:| |coef2|
                                                (|UnivariatePolynomial|
                                                 (QREFELT $ 6)
                                                 (|Expression| (|Integer|)))))
                                          "failed")
                                         #6#)))
                 (LETT |c2| (QCDR |s|))
                 (LETT |le|
                       (SPADCALL
                        (SPADCALL (SPADCALL |slop| (QREFELT $ 51)) |shift|
                                  (QREFELT $ 103))
                        (QREFELT $ 125)))
                 (LETT |le|
                       (- |le| (* (SPADCALL |slop| (QREFELT $ 53)) |dgl|)))
                 (LETT |re| (- (* (SPADCALL |slop| (QREFELT $ 53)) |dgr|)))
                 (LETT |fe|
                       (SPADCALL
                        (SPADCALL (SPADCALL |slop| (QREFELT $ 51)) |shift|
                                  (QREFELT $ 103))
                        (QREFELT $ 125)))
                 (LETT |fe|
                       (- |fe|
                          (* (SPADCALL |slop| (QREFELT $ 53))
                             (SPADCALL |ff| (QREFELT $ 41)))))
                 (EXIT
                  (SEQ
                   (LETT |i| (* (- |n_l| 1) (SPADCALL |slop| (QREFELT $ 51))))
                   (LETT #3# (- (* |n_l| (SPADCALL |slop| (QREFELT $ 51))) 1))
                   G190 (COND ((> |i| #3#) (GO G191)))
                   (SEQ
                    (COND
                     ((EQL |i| 0)
                      (SEQ
                       (LETT |r_extra|
                             (|LODOF2;coefs_operator| |r_low| |slop| |re| $))
                       (EXIT
                        (LETT |l_extra|
                              (|LODOF2;coefs_operator| |l_low| |slop| |le|
                               $)))))
                     ('T
                      (SEQ
                       (LETT |pi|
                             (|LODOF2;coefs_poly| |ei| |slop| (+ |i| |fe|) $))
                       (LETT |pr_extra|
                             (SPADCALL (SPADCALL |c2| |pi| (QREFELT $ 86))
                                       |r_low| (QREFELT $ 152)))
                       (LETT |pl_extra|
                             (SPADCALL |pi|
                                       (SPADCALL |pr_extra| |l_low|
                                                 (QREFELT $ 86))
                                       (QREFELT $ 83)))
                       (LETT |pl_extra|
                             (SPADCALL
                              (SPADCALL |pl_extra| |r_low| (QREFELT $ 106))
                              (QREFELT $ 153)))
                       (LETT |l_extra|
                             (|LODOF2;coefs_operator| |pl_extra| |slop|
                              (+ |i| |le|) $))
                       (EXIT
                        (LETT |r_extra|
                              (|LODOF2;coefs_operator|
                               (SPADCALL |pr_extra| (QREFELT $ 153)) |slop|
                               (+ |i| |re|) $))))))
                    (LETT |li| (SPADCALL |li| |l_extra| (QREFELT $ 35)))
                    (LETT |ei|
                          (SPADCALL
                           (SPADCALL |ei|
                                     (SPADCALL |l_extra| |ri| (QREFELT $ 159))
                                     (QREFELT $ 35))
                           (SPADCALL |li| |r_extra| (QREFELT $ 159))
                           (QREFELT $ 35)))
                    (EXIT
                     (LETT |ri| (SPADCALL |ri| |r_extra| (QREFELT $ 35)))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))))))
              (EXIT
               (VECTOR
                (CONS (SPADCALL |li| (QCAR |v|) (QREFELT $ 163))
                      (SPADCALL |ri| (QCDR |v|) (QREFELT $ 163)))
                (CONS |li| |ri|) |ei|))))) 

(SDEFUN |LODOF2;testln;FLodo2UpFIR;20|
        ((|slop| (|Fraction| (|Integer|)))
         (|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|l_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|r_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|shift| (|Fraction| (|Integer|))) (|dgr| (|Integer|))
         ($
          (|Record|
           (|:| |main|
                (|Record|
                 (|:| |Qt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))
                 (|:| |Rt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))))
           (|:| |nf|
                (|Record|
                 (|:| |Qt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))
                 (|:| |Rt|
                      (|LinearOrdinaryDifferentialOperator3|
                       (|Expression| (|Integer|))
                       (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                 |var| |cen|)
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)))))
           (|:| |error|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|))))))
        (SPROG
         ((|ei|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|v|
           (|Record|
            (|:| |Qt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |Rt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (|lnr|
           (|Record|
            (|:| |main|
                 (|Record|
                  (|:| |Qt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))
                  (|:| |Rt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))))
            (|:| |nf|
                 (|Record|
                  (|:| |Qt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))
                  (|:| |Rt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))))
            (|:| |error|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (|i| NIL))
         (SEQ (LETT |v| (CONS (|spadConstant| $ 18) (|spadConstant| $ 18)))
              (LETT |ei|
                    (SPADCALL (|LODOF2;convertL3toLL| |f| $) (QREFELT $ 158)))
              (SEQ (LETT |i| 1) G190 (COND ((|greater_SI| |i| 5) (GO G191)))
                   (SEQ
                    (LETT |lnr|
                          (|LODOF2;lift_newton| |slop|
                           (|LODOF2;convertL3toLL| |f| $) |l_low| |r_low|
                           |shift| |dgr| |v| |ei| |i| $))
                    (SPADCALL (SPADCALL (QCAR (QVELT |lnr| 0)) (QREFELT $ 165))
                              (QREFELT $ 167))
                    (SPADCALL (SPADCALL (QCDR (QVELT |lnr| 0)) (QREFELT $ 165))
                              (QREFELT $ 167))
                    (LETT |v| (QVELT |lnr| 1))
                    (EXIT (LETT |ei| (QVELT |lnr| 2))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |lnr|)))) 

(SDEFUN |LODOF2;ln_wrapper|
        ((|slop| (|Fraction| (|Integer|)))
         (|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|l_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|r_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|shift| (|Fraction| (|Integer|))) (|dgr| (|Integer|))
         ($
          (|Stream|
           (|Record|
            (|:| |Qt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |Rt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))))
        (SPROG
         ((|res|
           (|Stream|
            (|Record|
             (|:| |Qt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |Rt|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|))))))
          (|all|
           (|Stream|
            (|Record|
             (|:| |lr|
                  (|Record|
                   (|:| |main|
                        (|Record|
                         (|:| |Qt|
                              (|LinearOrdinaryDifferentialOperator3|
                               (|Expression| (|Integer|))
                               (|UnivariateTaylorSeries|
                                (|Expression| (|Integer|)) |var| |cen|)
                               (|UnivariateLaurentSeries|
                                (|Expression| (|Integer|)) |var| |cen|)))
                         (|:| |Rt|
                              (|LinearOrdinaryDifferentialOperator3|
                               (|Expression| (|Integer|))
                               (|UnivariateTaylorSeries|
                                (|Expression| (|Integer|)) |var| |cen|)
                               (|UnivariateLaurentSeries|
                                (|Expression| (|Integer|)) |var| |cen|)))))
                   (|:| |nf|
                        (|Record|
                         (|:| |Qt|
                              (|LinearOrdinaryDifferentialOperator3|
                               (|Expression| (|Integer|))
                               (|UnivariateTaylorSeries|
                                (|Expression| (|Integer|)) |var| |cen|)
                               (|UnivariateLaurentSeries|
                                (|Expression| (|Integer|)) |var| |cen|)))
                         (|:| |Rt|
                              (|LinearOrdinaryDifferentialOperator3|
                               (|Expression| (|Integer|))
                               (|UnivariateTaylorSeries|
                                (|Expression| (|Integer|)) |var| |cen|)
                               (|UnivariateLaurentSeries|
                                (|Expression| (|Integer|)) |var| |cen|)))))
                   (|:| |error|
                        (|LinearOrdinaryDifferentialOperator3|
                         (|Expression| (|Integer|))
                         (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))))
             (|:| |n_lifts| (|PositiveInteger|)))))
          (|lni|
           (|Record|
            (|:| |main|
                 (|Record|
                  (|:| |Qt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))
                  (|:| |Rt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))))
            (|:| |nf|
                 (|Record|
                  (|:| |Qt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))
                  (|:| |Rt|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))))
            (|:| |error|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (|n_li| (|PositiveInteger|)))
         (SEQ
          (LETT |lni|
                (VECTOR (CONS (|spadConstant| $ 18) (|spadConstant| $ 18))
                        (CONS (|spadConstant| $ 18) (|spadConstant| $ 18))
                        (SPADCALL |f| (QREFELT $ 158))))
          (LETT |n_li| 1)
          (LETT |lni|
                (|LODOF2;lift_newton| |slop| |f| |l_low| |r_low| |shift| |dgr|
                 (QVELT |lni| 1) (QVELT |lni| 2) |n_li| $))
          (LETT |all|
                (SPADCALL
                 (CONS #'|LODOF2;ln_wrapper!0|
                       (VECTOR |dgr| |shift| |r_low| |l_low| |f| |slop| $))
                 (CONS |lni| |n_li|) (QREFELT $ 176)))
          (LETT |res|
                (SPADCALL (LIST #'|LODOF2;ln_wrapper!1|) |all|
                          (QREFELT $ 179)))
          (EXIT |res|)))) 

(SDEFUN |LODOF2;ln_wrapper!1| ((|rec| NIL) ($$ NIL)) (QVELT (QCAR |rec|) 0)) 

(SDEFUN |LODOF2;ln_wrapper!0| ((|rec| NIL) ($$ NIL))
        (PROG ($ |slop| |f| |l_low| |r_low| |shift| |dgr|)
          (LETT $ (QREFELT $$ 6))
          (LETT |slop| (QREFELT $$ 5))
          (LETT |f| (QREFELT $$ 4))
          (LETT |l_low| (QREFELT $$ 3))
          (LETT |r_low| (QREFELT $$ 2))
          (LETT |shift| (QREFELT $$ 1))
          (LETT |dgr| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|lnr| NIL) (|n_l| NIL))
                   (SEQ (LETT |lnr| (QCAR |rec|))
                        (LETT |n_l|
                              (SPADCALL (QCDR |rec|) (|spadConstant| $ 171)
                                        (QREFELT $ 172)))
                        (LETT |lnr|
                              (|LODOF2;lift_newton| |slop| |f| |l_low| |r_low|
                               |shift| |dgr| (QVELT |lnr| 1) (QVELT |lnr| 2)
                               |n_l| $))
                        (EXIT (CONS |lnr| |n_l|)))))))) 

(SDEFUN |LODOF2;testlw;FLodo2UpFIS;22|
        ((|slop| (|Fraction| (|Integer|)))
         (|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|l_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|r_low| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|shift| (|Fraction| (|Integer|))) (|dgr| (|Integer|))
         ($
          (|Stream|
           (|Record|
            (|:| |Qt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |Rt|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))))
        (|LODOF2;ln_wrapper| |slop| (|LODOF2;convertL3toLL| |f| $) |l_low|
         |r_low| |shift| |dgr| $)) 

(SDEFUN |LODOF2;coefs_poly|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|slop| (|Fraction| (|Integer|))) (|i| (|Integer|))
         ($ (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
        (SPROG
         ((|res| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|npc| (|Expression| (|Integer|)))
          (|fc| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (#1=#:G1035 NIL) (|j| NIL) (|start_x| (|Fraction| (|Integer|)))
          (|start_D| (|Integer|)) (|nsi| (|Integer|)))
         (SEQ
          (LETT |nsi|
                (QVELT
                 (SPADCALL (SPADCALL |slop| (QREFELT $ 53))
                           (SPADCALL |slop| (QREFELT $ 51)) (QREFELT $ 181))
                 0))
          (LETT |start_D|
                (SPADCALL (- (* |i| |nsi|)) (SPADCALL |slop| (QREFELT $ 51))
                          (QREFELT $ 182)))
          (LETT |start_x|
                (SPADCALL (SPADCALL |start_D| |slop| (QREFELT $ 103))
                          (SPADCALL |i| (SPADCALL |slop| (QREFELT $ 51))
                                    (QREFELT $ 49))
                          (QREFELT $ 104)))
          (LETT |res| (|spadConstant| $ 50))
          (SEQ (LETT |j| 0)
               (LETT #1#
                     (SPADCALL
                      (SPADCALL (SPADCALL |f| (QREFELT $ 41))
                                (SPADCALL |slop| (QREFELT $ 51))
                                (QREFELT $ 49))
                      (QREFELT $ 183)))
               G190 (COND ((|greater_SI| |j| #1#) (GO G191)))
               (SEQ
                (LETT |fc|
                      (|LODOF2;coeffx| |f|
                       (SPADCALL |start_x|
                                 (SPADCALL (SPADCALL |slop| (QREFELT $ 53))
                                           (SPADCALL |j| (QREFELT $ 102))
                                           (QREFELT $ 103))
                                 (QREFELT $ 104))
                       $))
                (LETT |npc|
                      (SPADCALL |fc|
                                (+ |start_D|
                                   (* |j| (SPADCALL |slop| (QREFELT $ 51))))
                                (QREFELT $ 73)))
                (EXIT
                 (LETT |res|
                       (SPADCALL |res|
                                 (SPADCALL |npc|
                                           (+ |start_D|
                                              (* |j|
                                                 (SPADCALL |slop|
                                                           (QREFELT $ 51))))
                                           (QREFELT $ 55))
                                 (QREFELT $ 56)))))
               (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |LODOF2;testcp;LodoFILodo;24|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|slop| (|Fraction| (|Integer|))) (|i| (|Integer|))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (|LODOF2;coefs_operator|
         (|LODOF2;coefs_poly| (|LODOF2;convertL3toLL| |f| $) |slop| |i| $)
         |slop| |i| $)) 

(SDEFUN |LODOF2;coefs_operator|
        ((|np| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|slop| (|Fraction| (|Integer|))) (|i| (|Integer|))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|res|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|sc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|npc| (|Expression| (|Integer|))) (#1=#:G1043 NIL) (|j| NIL)
          (|start_x| (|Integer|)) (|start_D| (|Integer|)) (|nsi| (|Integer|)))
         (SEQ
          (LETT |nsi|
                (QVELT
                 (SPADCALL (SPADCALL |slop| (QREFELT $ 53))
                           (SPADCALL |slop| (QREFELT $ 51)) (QREFELT $ 181))
                 0))
          (LETT |start_D|
                (SPADCALL (- (* |i| |nsi|)) (SPADCALL |slop| (QREFELT $ 51))
                          (QREFELT $ 182)))
          (LETT |start_x|
                (SPADCALL
                 (SPADCALL (SPADCALL |start_D| |slop| (QREFELT $ 103))
                           (SPADCALL |i| (SPADCALL |slop| (QREFELT $ 51))
                                     (QREFELT $ 49))
                           (QREFELT $ 104))
                 (QREFELT $ 125)))
          (LETT |res| (|spadConstant| $ 18))
          (SEQ (LETT |j| 0)
               (LETT #1#
                     (SPADCALL
                      (SPADCALL (SPADCALL |np| (QREFELT $ 72))
                                (SPADCALL |slop| (QREFELT $ 51))
                                (QREFELT $ 49))
                      (QREFELT $ 185)))
               G190 (COND ((|greater_SI| |j| #1#) (GO G191)))
               (SEQ
                (LETT |npc|
                      (SPADCALL |np|
                                (+ |start_D|
                                   (* |j| (SPADCALL |slop| (QREFELT $ 51))))
                                (QREFELT $ 73)))
                (LETT |sc|
                      (SPADCALL |npc|
                                (+ |start_x|
                                   (* (SPADCALL |slop| (QREFELT $ 53)) |j|))
                                (QREFELT $ 146)))
                (EXIT
                 (LETT |res|
                       (SPADCALL |res|
                                 (SPADCALL |sc|
                                           (+ |start_D|
                                              (* |j|
                                                 (SPADCALL |slop|
                                                           (QREFELT $ 51))))
                                           (QREFELT $ 34))
                                 (QREFELT $ 35)))))
               (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |LODOF2;testco;LodoFIB;26|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|slop| (|Fraction| (|Integer|))) (|i| (|Integer|)) ($ (|Boolean|)))
        (SPROG
         ((|np| (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
         (SEQ
          (LETT |np|
                (|LODOF2;coefs_poly| (|LODOF2;convertL3toLL| |f| $) |slop| |i|
                 $))
          (EXIT
           (SPADCALL
            (|LODOF2;coefs_poly| (|LODOF2;coefs_operator| |np| |slop| |i| $)
             |slop| |i| $)
            |np| (QREFELT $ 84)))))) 

(SDEFUN |LODOF2;coeffx|
        ((|f|
          #1=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)))
         (|e| (|Fraction| (|Integer|)))
         ($ (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
        (SPROG
         ((|ftmp| #1#)
          (|res| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|dg| (|NonNegativeInteger|))
          (|lc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|ex| (|Integer|)))
         (SEQ (LETT |ftmp| |f|) (LETT |ex| (SPADCALL |e| (QREFELT $ 125)))
              (LETT |res| (|spadConstant| $ 50))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |ftmp| (|spadConstant| $ 18) (QREFELT $ 40)))
                     (GO G191)))
                   (SEQ (LETT |lc| (SPADCALL |ftmp| (QREFELT $ 37)))
                        (LETT |dg| (SPADCALL |ftmp| (QREFELT $ 41)))
                        (LETT |res|
                              (SPADCALL |res|
                                        (SPADCALL
                                         (SPADCALL |lc| |ex| (QREFELT $ 54))
                                         |dg| (QREFELT $ 55))
                                        (QREFELT $ 56)))
                        (EXIT (LETT |ftmp| (SPADCALL |ftmp| (QREFELT $ 44)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;testcx;LodoFUp;28|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|e| (|Fraction| (|Integer|)))
         ($ (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
        (|LODOF2;coeffx| (|LODOF2;convertL3toLL| |f| $) |e| $)) 

(SDEFUN |LODOF2;plug_delta|
        ((|np| #1=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|nptmp| #1#)
          (|f|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|dg| (|NonNegativeInteger|)) (|lc| (|Expression| (|Integer|))))
         (SEQ (LETT |f| (|spadConstant| $ 18)) (LETT |nptmp| |np|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |nptmp| (|spadConstant| $ 50) (QREFELT $ 151)))
                     (GO G191)))
                   (SEQ (LETT |lc| (SPADCALL |nptmp| (QREFELT $ 188)))
                        (LETT |dg| (SPADCALL |nptmp| (QREFELT $ 72)))
                        (LETT |f|
                              (SPADCALL |f|
                                        (SPADCALL
                                         (SPADCALL |lc| (QREFELT $ 189)) |dg|
                                         (QREFELT $ 34))
                                        (QREFELT $ 35)))
                        (EXIT
                         (LETT |nptmp| (SPADCALL |nptmp| (QREFELT $ 190)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |f|)))) 

(SDEFUN |LODOF2;testpd;UpLodo;30|
        ((|np| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (|LODOF2;plug_delta| |np| $)) 

(SDEFUN |LODOF2;factor_riccati|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|Union|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|))))
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))))
        (SPROG
         ((#1=#:G1152 NIL)
          (|res|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (|nt|
           (|Record|
            (|:| |ope|
                 #2=(|LinearOrdinaryDifferentialOperator3|
                     (|Expression| (|Integer|))
                     (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)
                     (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                |var| |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|ir|
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (#3=#:G1163 NIL)
          (|vrs|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (|res_sp|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (#4=#:G1162 NIL) (#5=#:G1161 NIL)
          (|vsp|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (|r| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|v|
           (|Union|
            (|List|
             (|Record|
              (|:| |op|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |ram|
                   (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
              (|:| |expart|
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|))))
            (|List|
             (|Union|
              (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|))
              (|Record|
               (|:| |ope|
                    (|LinearOrdinaryDifferentialOperator3|
                     (|Expression| (|Integer|))
                     (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)
                     (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                |var| |cen|)))
               (|:| |dext| (|PositiveInteger|))
               (|:| |alpha| (|Expression| (|Integer|)))
               (|:| |rami|
                    (|UnivariatePolynomial| |var|
                                            (|Expression| (|Integer|)))))))))
          (|f2r|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|lns|
           #6=(|Record|
               (|:| |point|
                    (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
               (|:| |slope| #7=(|Fraction| (|Integer|)))
               (|:| |npoly|
                    (|UnivariatePolynomial| |var|
                                            (|Expression| (|Integer|))))))
          (#8=#:G1160 NIL) (|np| (|List| #6#))
          (|tosub| (|Expression| (|Integer|))) (|exp| (|Integer|))
          (|ror|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|coefr| (|Expression| (|Integer|))) (|n| (|Integer|))
          (#9=#:G1159 NIL)
          (|npgr| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|gr| (|Expression| (|Integer|)))
          (|rk|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#10=#:G794 NIL) (#11=#:G1158 NIL)
          (|ric|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (#12=#:G1061 NIL)
          (|lk|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|r1|
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (#13=#:G1157 NIL) (#14=#:G1156 NIL)
          (|retv|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))
          (|fullxr|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|xsubsr|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (#15=#:G1155 NIL) (|vi| NIL) (#16=#:G1060 NIL) (#17=#:G793 NIL)
          (|cxs|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|il|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|irred_f| (|Boolean|))
          (|npf|
           (|Record|
            (|:| |flag| (|Union| #18="nil" #19="sqfr" #20="irred" #21="prime"))
            (|:| |factor|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
            (|:| |exponent| (|NonNegativeInteger|))))
          (#22=#:G1154 NIL) (|ip| NIL)
          (|subs|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|sols| (|List| (|Integer|))) (#23=#:G1076 NIL)
          (|fact|
           #24=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|diff| (|Union| (|Integer|) "failed")) (#25=#:G1153 NIL) (|l| NIL)
          (|npf1|
           (|List|
            (|Record| (|:| |flag| (|Union| #18# #19# #20# #21#))
                      (|:| |factor| #24#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|i| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|vr_ope| #2#)
          (|xx| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|vr|
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|va|
           (|Union|
            (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    |var| |cen|)
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    |var| |cen|))
            (|Record|
             (|:| |ope|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |dext| (|PositiveInteger|))
             (|:| |alpha| (|Expression| (|Integer|)))
             (|:| |rami|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
          (|slop| #7#)
          (|np1|
           (|Record|
            (|:| |point|
                 (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
            (|:| |slope| (|Fraction| (|Integer|)))
            (|:| |npoly|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
         (SEQ
          (EXIT
           (SEQ (LETT |np| (|LODOF2;newtonpolygon| |f| $))
                (LETT |np1| (SPADCALL |np| 1 (QREFELT $ 192)))
                (LETT |slop| (QVELT |np1| 1))
                (COND
                 ((EQUAL |option| "semireg")
                  (COND
                   ((SPADCALL |slop| (|spadConstant| $ 65) (QREFELT $ 107))
                    (EXIT
                     (SEQ
                      (LETT |va|
                            (SPADCALL
                             (PROG2
                                 (LETT #12#
                                       (|LODOF2;factor_op| |f| |factorizer|
                                        "alg factor" $))
                                 (QCDR #12#)
                               (|check_union2| (QEQCAR #12# 1)
                                               (|List|
                                                (|Union|
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))
                                                 (|Record|
                                                  (|:| |ope|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))))
                                                  (|:| |dext|
                                                       (|PositiveInteger|))
                                                  (|:| |alpha|
                                                       (|Expression|
                                                        (|Integer|)))
                                                  (|:| |rami|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|)))))))
                                               (|Union|
                                                (|List|
                                                 (|Record|
                                                  (|:| |op|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))))
                                                  (|:| |ram|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))
                                                  (|:| |expart|
                                                       (|UnivariateLaurentSeries|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7)))))
                                                (|List|
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))))
                                               #12#))
                             (QREFELT $ 196)))
                      (LETT |vr|
                            (COND
                             ((QEQCAR |va| 0)
                              (VECTOR (QCDR |va|) 1 (|spadConstant| $ 19)
                                      (SPADCALL (|spadConstant| $ 12) 1
                                                (QREFELT $ 55))))
                             (#26='T (QCDR |va|))))
                      (LETT |xx|
                            (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 55)))
                      (LETT |vr_ope| (QVELT |vr| 0))
                      (LETT |i|
                            (SPADCALL |xx|
                                      (|LODOF2;coeffx| |vr_ope|
                                       (|spadConstant| $ 65) $)
                                      (QREFELT $ 83)))
                      (LETT |n|
                            (QUOTIENT2 (SPADCALL |f| (QREFELT $ 41))
                                       (QVELT |vr| 1)))
                      (COND
                       ((EQL |n| 1)
                        (SEQ
                         (LETT |il|
                               (SPADCALL (|LODOF2;convertUPtoUTS| |i| $)
                                         (QREFELT $ 28)))
                         (EXIT
                          (PROGN
                           (LETT #1#
                                 (CONS 0
                                       (LIST
                                        (VECTOR
                                         (SPADCALL (QVELT |vr| 0)
                                                   (SPADCALL |il|
                                                             (QREFELT $ 197))
                                                   (QREFELT $ 35))
                                         (QVELT |vr| 3) |il|))))
                           (GO #27=#:G1151))))))
                      (LETT |npf1|
                            (SPADCALL
                             (|LODOF2;factorUP|
                              (SPADCALL (QVELT |np1| 2)
                                        (SPADCALL (|spadConstant| $ 12) 1
                                                  (QREFELT $ 55))
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 12) 1
                                                   (QREFELT $ 55))
                                         |i| (QREFELT $ 56))
                                        (QREFELT $ 82))
                              |factorizer| $)
                             (QREFELT $ 201)))
                      (LETT |r| (|spadConstant| $ 150)) (LETT |sols| NIL)
                      (SEQ (LETT |l| NIL) (LETT #25# |npf1|) G190
                           (COND
                            ((OR (ATOM #25#) (PROGN (LETT |l| (CAR #25#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |diff|
                                  (SPADCALL
                                   (SPADCALL |xx| (QVELT |l| 1) (QREFELT $ 83))
                                   (QREFELT $ 202)))
                            (EXIT
                             (COND
                              ((SPADCALL |diff| (CONS 1 "failed")
                                         (QREFELT $ 203))
                               (SEQ (LETT |fact| (QVELT |l| 1))
                                    (LETT |r|
                                          (SPADCALL |r|
                                                    (SPADCALL |fact|
                                                              (QVELT |l| 2)
                                                              (QREFELT $ 67))
                                                    (QREFELT $ 86)))
                                    (EXIT
                                     (LETT |sols|
                                           (CONS
                                            (PROG2 (LETT #23# |diff|)
                                                (QCDR #23#)
                                              (|check_union2| (QEQCAR #23# 0)
                                                              (|Integer|)
                                                              (|Union|
                                                               (|Integer|)
                                                               "failed")
                                                              #23#))
                                            |sols|))))))))
                           (LETT #25# (CDR #25#)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((SPADCALL (SPADCALL |r| (QREFELT $ 72)) |n|
                                  (QREFELT $ 204))
                        (|error| "bug")))
                      (LETT |n| (SPADCALL (ELT $ 205) |sols| (QREFELT $ 208)))
                      (LETT |r|
                            (SPADCALL |r|
                                      (SPADCALL (|spadConstant| $ 12) 1
                                                (QREFELT $ 55))
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 12) 1
                                                 (QREFELT $ 55))
                                       (SPADCALL |n| (QREFELT $ 81))
                                       (QREFELT $ 56))
                                      (QREFELT $ 82)))
                      (LETT |subs|
                            (PROG2
                                (LETT #17#
                                      (|LODOF2;substitute|
                                       (CONS 0
                                             (SPADCALL |i|
                                                       (SPADCALL |n|
                                                                 (QREFELT $
                                                                          81))
                                                       (QREFELT $ 56)))
                                       (CONS 0 |f|) $))
                                (QCDR #17#)
                              (|check_union2| (QEQCAR #17# 0)
                                              (|LinearOrdinaryDifferentialOperator3|
                                               (|Expression| (|Integer|))
                                               (|UnivariateTaylorSeries|
                                                (|Expression| (|Integer|))
                                                (QREFELT $ 6) (QREFELT $ 7))
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|))
                                                (QREFELT $ 6) (QREFELT $ 7)))
                                              (|Union|
                                               (|LinearOrdinaryDifferentialOperator3|
                                                (|Expression| (|Integer|))
                                                (|UnivariateTaylorSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6) (QREFELT $ 7))
                                                (|UnivariateLaurentSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6) (QREFELT $ 7)))
                                               (|Record|
                                                (|:| |ope|
                                                     (|LinearOrdinaryDifferentialOperator3|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (|UnivariateTaylorSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7))
                                                      (|UnivariateLaurentSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7))))
                                                (|:| |dext|
                                                     (|PositiveInteger|))
                                                (|:| |alpha|
                                                     (|Expression|
                                                      (|Integer|)))
                                                (|:| |rami|
                                                     (|UnivariatePolynomial|
                                                      (QREFELT $ 6)
                                                      (|Expression|
                                                       (|Integer|))))))
                                              #17#)))
                      (LETT |np| (|LODOF2;newtonpolygon| |subs| $))
                      (SEQ (LETT |ip| NIL) (LETT #22# |np|) G190
                           (COND
                            ((OR (ATOM #22#)
                                 (PROGN (LETT |ip| (CAR #22#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (QVELT |ip| 1) (|spadConstant| $ 65)
                                         (QREFELT $ 107))
                               (LETT |lns| |ip|)))))
                           (LETT #22# (CDR #22#)) (GO G190) G191 (EXIT NIL))
                      (LETT |f2r|
                            (QCDR
                             (|LODOF2;factor_newton2| |subs| |r| |lns| $)))
                      (EXIT
                       (PROGN
                        (LETT #1#
                              (CONS 0
                                    (LIST
                                     (VECTOR |f2r| (QVELT |vr| 3)
                                             (SPADCALL
                                              (|LODOF2;convertUPtoUTS|
                                               (SPADCALL |i|
                                                         (SPADCALL |n|
                                                                   (QREFELT $
                                                                            81))
                                                         (QREFELT $ 56))
                                               $)
                                              (QREFELT $ 28))))))
                        (GO #27#)))))))))
                (LETT |npf|
                      (SPADCALL
                       (SPADCALL
                        (|LODOF2;factorUP| (QVELT |np1| 2) |factorizer| $)
                        (QREFELT $ 201))
                       1 (QREFELT $ 209)))
                (LETT |irred_f|
                      (COND ((<= (SPADCALL |f| (QREFELT $ 41)) 1) 'T)
                            ((EQL (QVELT |npf| 2) 1)
                             (COND ((EQUAL |option| "split over k((x))") 'T)
                                   (#26#
                                    (EQUAL |option| "all right factors"))))
                            (#26# NIL)))
                (EXIT
                 (COND
                  (|irred_f|
                   (COND
                    ((EQUAL |option| "semireg")
                     (SEQ
                      (LETT |il|
                            (SPADCALL
                             (SPADCALL (SPADCALL |f| 0 (QREFELT $ 52)) 0
                                       (QREFELT $ 210))
                             (QREFELT $ 211)))
                      (EXIT
                       (PROGN
                        (LETT #1#
                              (CONS 0
                                    (LIST
                                     (VECTOR
                                      (SPADCALL |f|
                                                (SPADCALL |il| (QREFELT $ 197))
                                                (QREFELT $ 35))
                                      (SPADCALL (|spadConstant| $ 12) 1
                                                (QREFELT $ 55))
                                      |il|))))
                        (GO #27#)))))
                    (#26# (CONS 1 (LIST (CONS 0 |f|))))))
                  (#26#
                   (SEQ
                    (COND
                     ((EQL (SPADCALL (QVELT |npf| 1) (QREFELT $ 72)) 1)
                      (COND
                       ((EQL (SPADCALL |slop| (QREFELT $ 51)) 1)
                        (EXIT
                         (SEQ
                          (LETT |cxs|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (QVELT |npf| 1) 0 (QREFELT $ 73))
                                  (SPADCALL (|spadConstant| $ 12)
                                            (-
                                             (SPADCALL |slop| (QREFELT $ 53)))
                                            (QREFELT $ 146))
                                  (QREFELT $ 212))
                                 (QREFELT $ 211)))
                          (LETT |v|
                                (|LODOF2;factor_op|
                                 (PROG2
                                     (LETT #17#
                                           (|LODOF2;substitute| (CONS 1 |cxs|)
                                            (CONS 0 |f|) $))
                                     (QCDR #17#)
                                   (|check_union2| (QEQCAR #17# 0)
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Union|
                                                    (|LinearOrdinaryDifferentialOperator3|
                                                     (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)))
                                                    (|Record|
                                                     (|:| |ope|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))))
                                                     (|:| |dext|
                                                          (|PositiveInteger|))
                                                     (|:| |alpha|
                                                          (|Expression|
                                                           (|Integer|)))
                                                     (|:| |rami|
                                                          (|UnivariatePolynomial|
                                                           (QREFELT $ 6)
                                                           (|Expression|
                                                            (|Integer|))))))
                                                   #17#))
                                 |factorizer| |option| $))
                          (COND
                           ((EQUAL |option| "semireg")
                            (SEQ
                             (LETT |vsp|
                                   (PROG2 (LETT #16# |v|)
                                       (QCDR #16#)
                                     (|check_union2| (QEQCAR #16# 0)
                                                     (|List|
                                                      (|Record|
                                                       (|:| |op|
                                                            (|LinearOrdinaryDifferentialOperator3|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (|UnivariateTaylorSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7))
                                                             (|UnivariateLaurentSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7))))
                                                       (|:| |ram|
                                                            (|UnivariatePolynomial|
                                                             (QREFELT $ 6)
                                                             (|Expression|
                                                              (|Integer|))))
                                                       (|:| |expart|
                                                            (|UnivariateLaurentSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7)))))
                                                     (|Union|
                                                      (|List|
                                                       (|Record|
                                                        (|:| |op|
                                                             (|LinearOrdinaryDifferentialOperator3|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|UnivariateTaylorSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))))
                                                        (|:| |ram|
                                                             (|UnivariatePolynomial|
                                                              (QREFELT $ 6)
                                                              (|Expression|
                                                               (|Integer|))))
                                                        (|:| |expart|
                                                             (|UnivariateLaurentSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7)))))
                                                      (|List|
                                                       (|Union|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7)))
                                                        (|Record|
                                                         (|:| |ope|
                                                              (|LinearOrdinaryDifferentialOperator3|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (|UnivariateTaylorSeries|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (QREFELT $ 6)
                                                                (QREFELT $ 7))
                                                               (|UnivariateLaurentSeries|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (QREFELT $ 6)
                                                                (QREFELT $
                                                                         7))))
                                                         (|:| |dext|
                                                              (|PositiveInteger|))
                                                         (|:| |alpha|
                                                              (|Expression|
                                                               (|Integer|)))
                                                         (|:| |rami|
                                                              (|UnivariatePolynomial|
                                                               (QREFELT $ 6)
                                                               (|Expression|
                                                                (|Integer|))))))))
                                                     #16#)))
                             (LETT |retv| NIL)
                             (SEQ (LETT |vi| NIL) (LETT #15# |vsp|) G190
                                  (COND
                                   ((OR (ATOM #15#)
                                        (PROGN (LETT |vi| (CAR #15#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |xsubsr|
                                         (SPADCALL
                                          (SPADCALL
                                           (|LODOF2;convertUPtoUTS|
                                            (QVELT |vi| 1) $)
                                           (QREFELT $ 28))
                                          (- (SPADCALL |slop| (QREFELT $ 53)))
                                          (QREFELT $ 213)))
                                   (LETT |fullxr|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL (QVELT |vi| 1)
                                                     (QREFELT $ 72))
                                           (SPADCALL
                                            (SPADCALL (QVELT |npf| 1) 0
                                                      (QREFELT $ 73))
                                            (QREFELT $ 214))
                                           (QREFELT $ 215))
                                          |xsubsr| (QREFELT $ 212)))
                                   (EXIT
                                    (LETT |retv|
                                          (SPADCALL |retv|
                                                    (LIST
                                                     (VECTOR (QVELT |vi| 0)
                                                             (QVELT |vi| 1)
                                                             (SPADCALL
                                                              (QVELT |vi| 2)
                                                              |fullxr|
                                                              (QREFELT $
                                                                       216))))
                                                    (QREFELT $ 219)))))
                                  (LETT #15# (CDR #15#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (PROGN (LETT #1# (CONS 0 |retv|)) (GO #27#))))))
                          (LETT |vrs|
                                (PROG2 (LETT #12# |v|)
                                    (QCDR #12#)
                                  (|check_union2| (QEQCAR #12# 1)
                                                  (|List|
                                                   (|Union|
                                                    (|LinearOrdinaryDifferentialOperator3|
                                                     (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)))
                                                    (|Record|
                                                     (|:| |ope|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))))
                                                     (|:| |dext|
                                                          (|PositiveInteger|))
                                                     (|:| |alpha|
                                                          (|Expression|
                                                           (|Integer|)))
                                                     (|:| |rami|
                                                          (|UnivariatePolynomial|
                                                           (QREFELT $ 6)
                                                           (|Expression|
                                                            (|Integer|)))))))
                                                  (|Union|
                                                   (|List|
                                                    (|Record|
                                                     (|:| |op|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))))
                                                     (|:| |ram|
                                                          (|UnivariatePolynomial|
                                                           (QREFELT $ 6)
                                                           (|Expression|
                                                            (|Integer|))))
                                                     (|:| |expart|
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7)))))
                                                   (|List|
                                                    (|Union|
                                                     (|LinearOrdinaryDifferentialOperator3|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (|UnivariateTaylorSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7))
                                                      (|UnivariateLaurentSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7)))
                                                     (|Record|
                                                      (|:| |ope|
                                                           (|LinearOrdinaryDifferentialOperator3|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (|UnivariateTaylorSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))
                                                            (|UnivariateLaurentSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))))
                                                      (|:| |dext|
                                                           (|PositiveInteger|))
                                                      (|:| |alpha|
                                                           (|Expression|
                                                            (|Integer|)))
                                                      (|:| |rami|
                                                           (|UnivariatePolynomial|
                                                            (QREFELT $ 6)
                                                            (|Expression|
                                                             (|Integer|))))))))
                                                  #12#)))
                          (EXIT
                           (PROGN
                            (LETT #1#
                                  (CONS 1
                                        (PROGN
                                         (LETT #14# NIL)
                                         (SEQ (LETT #13# |vrs|) G190
                                              (COND
                                               ((OR (ATOM #13#)
                                                    (PROGN
                                                     (LETT |i| (CAR #13#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #14#
                                                      (CONS
                                                       (|LODOF2;substitute|
                                                        (CONS 1
                                                              (SPADCALL |cxs|
                                                                        (QREFELT
                                                                         $
                                                                         211)))
                                                        |i| $)
                                                       #14#))))
                                              (LETT #13# (CDR #13#)) (GO G190)
                                              G191 (EXIT (NREVERSE #14#))))))
                            (GO #27#)))))))))
                    (EXIT
                     (COND
                      ((EQUAL |option| "split over k((x))")
                       (SEQ
                        (LETT |ric|
                              (PROG2
                                  (LETT #12#
                                        (|LODOF2;factor_riccati| |f|
                                         |factorizer| "alg factor" $))
                                  (QCDR #12#)
                                (|check_union2| (QEQCAR #12# 1)
                                                (|List|
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|)))))))
                                                (|Union|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |op|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |ram|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))
                                                   (|:| |expart|
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7)))))
                                                 (|List|
                                                  (|Union|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Record|
                                                    (|:| |ope|
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))))
                                                    (|:| |dext|
                                                         (|PositiveInteger|))
                                                    (|:| |alpha|
                                                         (|Expression|
                                                          (|Integer|)))
                                                    (|:| |rami|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))))
                                                #12#)))
                        (LETT |r1|
                              (PROG2
                                  (LETT #10# (SPADCALL |ric| (QREFELT $ 196)))
                                  (QCDR #10#)
                                (|check_union2| (QEQCAR #10# 1)
                                                (|Record|
                                                 (|:| |ope|
                                                      (|LinearOrdinaryDifferentialOperator3|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (|UnivariateTaylorSeries|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7))
                                                       (|UnivariateLaurentSeries|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7))))
                                                 (|:| |dext|
                                                      (|PositiveInteger|))
                                                 (|:| |alpha|
                                                      (|Expression|
                                                       (|Integer|)))
                                                 (|:| |rami|
                                                      (|UnivariatePolynomial|
                                                       (QREFELT $ 6)
                                                       (|Expression|
                                                        (|Integer|)))))
                                                (|Union|
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))
                                                 (|Record|
                                                  (|:| |ope|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))))
                                                  (|:| |dext|
                                                       (|PositiveInteger|))
                                                  (|:| |alpha|
                                                       (|Expression|
                                                        (|Integer|)))
                                                  (|:| |rami|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))))
                                                #10#)))
                        (LETT |rk| (|LODOF2;make_rightfactor| |f| |r1| $))
                        (EXIT
                         (COND
                          ((SPADCALL |rk| |f| (QREFELT $ 220))
                           (PROGN
                            (LETT #1# (CONS 1 (LIST (CONS 0 |f|))))
                            (GO #27#)))
                          (#26#
                           (SEQ (LETT |lk| (SPADCALL |f| |rk| (QREFELT $ 221)))
                                (EXIT
                                 (PROGN
                                  (LETT #1#
                                        (CONS 1
                                              (SPADCALL
                                               (PROG2
                                                   (LETT #12#
                                                         (|LODOF2;factor_riccati|
                                                          |lk| |factorizer|
                                                          |option| $))
                                                   (QCDR #12#)
                                                 (|check_union2|
                                                  (QEQCAR #12# 1)
                                                  (|List|
                                                   (|Union|
                                                    (|LinearOrdinaryDifferentialOperator3|
                                                     (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)))
                                                    (|Record|
                                                     (|:| |ope|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))))
                                                     (|:| |dext|
                                                          (|PositiveInteger|))
                                                     (|:| |alpha|
                                                          (|Expression|
                                                           (|Integer|)))
                                                     (|:| |rami|
                                                          (|UnivariatePolynomial|
                                                           (QREFELT $ 6)
                                                           (|Expression|
                                                            (|Integer|)))))))
                                                  (|Union|
                                                   (|List|
                                                    (|Record|
                                                     (|:| |op|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))))
                                                     (|:| |ram|
                                                          (|UnivariatePolynomial|
                                                           (QREFELT $ 6)
                                                           (|Expression|
                                                            (|Integer|))))
                                                     (|:| |expart|
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7)))))
                                                   (|List|
                                                    (|Union|
                                                     (|LinearOrdinaryDifferentialOperator3|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (|UnivariateTaylorSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7))
                                                      (|UnivariateLaurentSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7)))
                                                     (|Record|
                                                      (|:| |ope|
                                                           (|LinearOrdinaryDifferentialOperator3|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (|UnivariateTaylorSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))
                                                            (|UnivariateLaurentSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))))
                                                      (|:| |dext|
                                                           (|PositiveInteger|))
                                                      (|:| |alpha|
                                                           (|Expression|
                                                            (|Integer|)))
                                                      (|:| |rami|
                                                           (|UnivariatePolynomial|
                                                            (QREFELT $ 6)
                                                            (|Expression|
                                                             (|Integer|))))))))
                                                  #12#))
                                               (LIST (CONS 0 |rk|))
                                               (QREFELT $ 222))))
                                  (GO #27#)))))))))
                      ((EQUAL |option| "all right factors")
                       (SEQ
                        (LETT |ric|
                              (PROG2
                                  (LETT #12#
                                        (|LODOF2;factor_riccati| |f|
                                         |factorizer| "all alg factors" $))
                                  (QCDR #12#)
                                (|check_union2| (QEQCAR #12# 1)
                                                (|List|
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|)))))))
                                                (|Union|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |op|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |ram|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))
                                                   (|:| |expart|
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7)))))
                                                 (|List|
                                                  (|Union|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Record|
                                                    (|:| |ope|
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))))
                                                    (|:| |dext|
                                                         (|PositiveInteger|))
                                                    (|:| |alpha|
                                                         (|Expression|
                                                          (|Integer|)))
                                                    (|:| |rami|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))))
                                                #12#)))
                        (LETT |res| NIL)
                        (SEQ (LETT #11# |ric|) G190
                             (COND
                              ((OR (ATOM #11#)
                                   (PROGN (LETT |i| (CAR #11#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |rk|
                                    (|LODOF2;make_rightfactor| |f|
                                     (PROG2 (LETT #10# |i|)
                                         (QCDR #10#)
                                       (|check_union2| (QEQCAR #10# 1)
                                                       (|Record|
                                                        (|:| |ope|
                                                             (|LinearOrdinaryDifferentialOperator3|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|UnivariateTaylorSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))))
                                                        (|:| |dext|
                                                             (|PositiveInteger|))
                                                        (|:| |alpha|
                                                             (|Expression|
                                                              (|Integer|)))
                                                        (|:| |rami|
                                                             (|UnivariatePolynomial|
                                                              (QREFELT $ 6)
                                                              (|Expression|
                                                               (|Integer|)))))
                                                       (|Union|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7)))
                                                        (|Record|
                                                         (|:| |ope|
                                                              (|LinearOrdinaryDifferentialOperator3|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (|UnivariateTaylorSeries|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (QREFELT $ 6)
                                                                (QREFELT $ 7))
                                                               (|UnivariateLaurentSeries|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (QREFELT $ 6)
                                                                (QREFELT $
                                                                         7))))
                                                         (|:| |dext|
                                                              (|PositiveInteger|))
                                                         (|:| |alpha|
                                                              (|Expression|
                                                               (|Integer|)))
                                                         (|:| |rami|
                                                              (|UnivariatePolynomial|
                                                               (QREFELT $ 6)
                                                               (|Expression|
                                                                (|Integer|))))))
                                                       #10#))
                                     $))
                              (EXIT
                               (COND
                                ((SPADCALL |rk| |f| (QREFELT $ 220))
                                 (LETT |res| (LIST (CONS 0 |f|))))
                                ('T
                                 (LETT |res|
                                       (SPADCALL |res| (LIST (CONS 0 |rk|))
                                                 (QREFELT $ 222)))))))
                             (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (PROGN (LETT #1# (CONS 1 |res|)) (GO #27#)))))
                      (#26#
                       (COND
                        ((> (SPADCALL (QVELT |npf| 1) (QREFELT $ 72)) 1)
                         (SEQ
                          (LETT |gr|
                                (SPADCALL
                                 (SPADCALL (QVELT |npf| 1) (QREFELT $ 96))
                                 (QREFELT $ 224)))
                          (LETT |npgr|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 12) 1
                                            (QREFELT $ 55))
                                  (SPADCALL |gr| (QREFELT $ 225))
                                  (QREFELT $ 83))
                                 (QVELT |npf| 2) (QREFELT $ 67)))
                          (LETT |f2r|
                                (QCDR
                                 (|LODOF2;factor_newton2| |f| |npgr| |np1| $)))
                          (LETT |v|
                                (|LODOF2;factor_riccati| |f2r| |factorizer|
                                 |option| $))
                          (EXIT
                           (COND
                            ((QEQCAR |v| 0) (PROGN (LETT #1# |v|) (GO #27#)))
                            (#26#
                             (SEQ (LETT |vrs| (QCDR |v|)) (LETT |res| NIL)
                                  (SEQ (LETT #9# |vrs|) G190
                                       (COND
                                        ((OR (ATOM #9#)
                                             (PROGN (LETT |i| (CAR #9#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (COND
                                          ((QEQCAR |i| 0)
                                           (SEQ
                                            (LETT |nt|
                                                  (VECTOR (QCDR |i|)
                                                          (SPADCALL
                                                           (QVELT |npf| 1)
                                                           (QREFELT $ 72))
                                                          |gr|
                                                          (SPADCALL
                                                           (|spadConstant| $
                                                                           12)
                                                           1 (QREFELT $ 55))))
                                            (EXIT
                                             (LETT |res|
                                                   (SPADCALL |res|
                                                             (LIST
                                                              (CONS 1 |nt|))
                                                             (QREFELT $
                                                                      222))))))
                                          ('T
                                           (LETT |res|
                                                 (SPADCALL |res| (LIST |i|)
                                                           (QREFELT $
                                                                    222)))))))
                                       (LETT #9# (CDR #9#)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT
                                   (PROGN
                                    (LETT #1# (CONS 1 |res|))
                                    (GO #27#)))))))))
                        (#26#
                         (SEQ
                          (LETT |n|
                                (QVELT
                                 (SPADCALL (SPADCALL |slop| (QREFELT $ 53))
                                           (SPADCALL |slop| (QREFELT $ 51))
                                           (QREFELT $ 181))
                                 0))
                          (LETT |coefr|
                                (SPADCALL
                                 (SPADCALL (QVELT |npf| 1) 0 (QREFELT $ 73))
                                 (QREFELT $ 214)))
                          (LETT |ror|
                                (|LODOF2;ramification_of| |f|
                                 (SPADCALL |coefr| |n| (QREFELT $ 226))
                                 (SPADCALL |slop| (QREFELT $ 51)) $))
                          (LETT |exp|
                                (SPADCALL
                                 (SPADCALL
                                  (- 1
                                     (* |n| (SPADCALL |slop| (QREFELT $ 53))))
                                  (SPADCALL |slop| (QREFELT $ 51))
                                  (QREFELT $ 49))
                                 (QREFELT $ 125)))
                          (LETT |tosub|
                                (SPADCALL (SPADCALL |slop| (QREFELT $ 51))
                                          (SPADCALL |coefr| |exp|
                                                    (QREFELT $ 226))
                                          (QREFELT $ 227)))
                          (LETT |r|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 12) 1
                                            (QREFELT $ 55))
                                  (SPADCALL |tosub| (QREFELT $ 225))
                                  (QREFELT $ 83))
                                 (QVELT |npf| 2) (QREFELT $ 67)))
                          (LETT |np| (|LODOF2;newtonpolygon| |ror| $))
                          (SEQ (LETT #8# |np|) G190
                               (COND
                                ((OR (ATOM #8#)
                                     (PROGN (LETT |i| (CAR #8#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL (QVELT |i| 1)
                                             (SPADCALL
                                              (SPADCALL |slop| (QREFELT $ 53))
                                              (QREFELT $ 102))
                                             (QREFELT $ 107))
                                   (LETT |lns| |i|)))))
                               (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                          (LETT |f2r|
                                (QCDR
                                 (|LODOF2;factor_newton2| |ror| |r| |lns| $)))
                          (LETT |v|
                                (|LODOF2;factor_riccati| |f2r| |factorizer|
                                 |option| $))
                          (LETT |r|
                                (SPADCALL
                                 (SPADCALL |coefr| |n| (QREFELT $ 226))
                                 (SPADCALL |slop| (QREFELT $ 51))
                                 (QREFELT $ 55)))
                          (EXIT
                           (COND
                            ((QEQCAR |v| 0)
                             (SEQ (LETT |vsp| (QCDR |v|))
                                  (LETT |res_sp|
                                        (PROGN
                                         (LETT #5# NIL)
                                         (SEQ (LETT #4# |vsp|) G190
                                              (COND
                                               ((OR (ATOM #4#)
                                                    (PROGN
                                                     (LETT |i| (CAR #4#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #5#
                                                      (CONS
                                                       (VECTOR (QVELT |i| 0)
                                                               (SPADCALL |r|
                                                                         (SPADCALL
                                                                          (|spadConstant|
                                                                           $
                                                                           12)
                                                                          1
                                                                          (QREFELT
                                                                           $
                                                                           55))
                                                                         (QVELT
                                                                          |i|
                                                                          1)
                                                                         (QREFELT
                                                                          $
                                                                          82))
                                                               (QVELT |i| 2))
                                                       #5#))))
                                              (LETT #4# (CDR #4#)) (GO G190)
                                              G191 (EXIT (NREVERSE #5#)))))
                                  (EXIT
                                   (PROGN
                                    (LETT #1# (CONS 0 |res_sp|))
                                    (GO #27#)))))
                            (#26#
                             (SEQ (LETT |vrs| (QCDR |v|)) (LETT |res| NIL)
                                  (SEQ (LETT #3# |vrs|) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN (LETT |i| (CAR #3#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (COND
                                         ((QEQCAR |i| 0)
                                          (LETT |nt|
                                                (VECTOR (QCDR |i|) 1
                                                        (|spadConstant| $ 19)
                                                        |r|)))
                                         ('T
                                          (SEQ (LETT |ir| (QCDR |i|))
                                               (EXIT
                                                (LETT |nt|
                                                      (VECTOR (QVELT |ir| 0)
                                                              (QVELT |ir| 1)
                                                              (QVELT |ir| 2)
                                                              (SPADCALL |r|
                                                                        (SPADCALL
                                                                         (|spadConstant|
                                                                          $ 12)
                                                                         1
                                                                         (QREFELT
                                                                          $
                                                                          55))
                                                                        (QVELT
                                                                         |ir|
                                                                         3)
                                                                        (QREFELT
                                                                         $
                                                                         82))))))))
                                        (EXIT
                                         (LETT |res|
                                               (SPADCALL |res|
                                                         (LIST (CONS 1 |nt|))
                                                         (QREFELT $ 222)))))
                                       (LETT #3# (CDR #3#)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT
                                   (PROGN
                                    (LETT #1# (CONS 1 |res|))
                                    (GO #27#)))))))))))))))))))
          #27# (EXIT #1#)))) 

(SDEFUN |LODOF2;testfr;LodoMSU;32|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|Union|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|))))
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))))
        (|LODOF2;factor_riccati| (|LODOF2;convertL3toLL| |f| $) |factorizer|
         |option| $)) 

(SDEFUN |LODOF2;substitute|
        ((|a|
          (|Union| (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
         (|f|
          (|Union|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|))
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
         ($
          (|Union|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|))
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (SPROG
         ((#1=#:G1183 NIL)
          (|fr|
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|ftmp|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|res|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|dg| (|NonNegativeInteger|))
          (|lc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|new_mon|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |new_mon| (SPADCALL (|spadConstant| $ 14) 1 (QREFELT $ 34)))
            (COND
             ((QEQCAR |a| 0)
              (LETT |new_mon|
                    (SPADCALL |new_mon|
                              (|LODOF2;convertL3toLL|
                               (SPADCALL (SPADCALL (QCDR |a|) (QREFELT $ 230))
                                         (QREFELT $ 231))
                               $)
                              (QREFELT $ 35))))
             (#2='T
              (LETT |new_mon|
                    (SPADCALL |new_mon| (SPADCALL (QCDR |a|) (QREFELT $ 197))
                              (QREFELT $ 35)))))
            (COND ((QEQCAR |f| 0) (LETT |ftmp| (QCDR |f|)))
                  (#2#
                   (SEQ (LETT |fr| (QCDR |f|)) (LETT |ftmp| (QVELT |fr| 0))
                        (EXIT
                         (LETT |new_mon|
                               (|LODOF2;ramification_of| |new_mon|
                                (SPADCALL (QVELT |fr| 3) (QREFELT $ 188))
                                (SPADCALL (QVELT |fr| 3) (QREFELT $ 72))
                                $))))))
            (LETT |res| (|spadConstant| $ 18))
            (SEQ G190
                 (COND
                  ((NULL
                    (SPADCALL |ftmp| (|spadConstant| $ 18) (QREFELT $ 40)))
                   (GO G191)))
                 (SEQ (LETT |lc| (SPADCALL |ftmp| (QREFELT $ 37)))
                      (LETT |dg| (SPADCALL |ftmp| (QREFELT $ 41)))
                      (LETT |res|
                            (SPADCALL |res|
                                      (SPADCALL |lc|
                                                (SPADCALL |new_mon| |dg|
                                                          (QREFELT $ 232))
                                                (QREFELT $ 157))
                                      (QREFELT $ 35)))
                      (EXIT (LETT |ftmp| (SPADCALL |ftmp| (QREFELT $ 44)))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT
             (COND
              ((QEQCAR |f| 0)
               (PROGN (LETT #1# (CONS 0 |res|)) (GO #3=#:G1182)))
              (#2#
               (SEQ (LETT |fr| (QCDR |f|))
                    (EXIT
                     (PROGN
                      (LETT #1#
                            (CONS 1
                                  (VECTOR |res| (QVELT |fr| 1) (QVELT |fr| 2)
                                          (QVELT |fr| 3))))
                      (GO #3#)))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |LODOF2;testsb;ULodoLodo;34|
        ((|a|
          (|Union| (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
         (|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG ((#1=#:G793 NIL))
               (PROG2
                   (LETT #1#
                         (|LODOF2;substitute| |a|
                          (CONS 0 (|LODOF2;convertL3toLL| |f| $)) $))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|LinearOrdinaryDifferentialOperator3|
                                  (|Expression| (|Integer|))
                                  (|UnivariateTaylorSeries|
                                   (|Expression| (|Integer|)) (QREFELT $ 6)
                                   (QREFELT $ 7))
                                  (|UnivariateLaurentSeries|
                                   (|Expression| (|Integer|)) (QREFELT $ 6)
                                   (QREFELT $ 7)))
                                 (|Union|
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariateTaylorSeries|
                                    (|Expression| (|Integer|)) (QREFELT $ 6)
                                    (QREFELT $ 7))
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) (QREFELT $ 6)
                                    (QREFELT $ 7)))
                                  (|Record|
                                   (|:| |ope|
                                        (|LinearOrdinaryDifferentialOperator3|
                                         (|Expression| (|Integer|))
                                         (|UnivariateTaylorSeries|
                                          (|Expression| (|Integer|))
                                          (QREFELT $ 6) (QREFELT $ 7))
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|))
                                          (QREFELT $ 6) (QREFELT $ 7))))
                                   (|:| |dext| (|PositiveInteger|))
                                   (|:| |alpha| (|Expression| (|Integer|)))
                                   (|:| |rami|
                                        (|UnivariatePolynomial| (QREFELT $ 6)
                                                                (|Expression|
                                                                 (|Integer|))))))
                                 #1#)))) 

(SDEFUN |LODOF2;ramification_of|
        ((|f|
          #1=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)))
         (|coefr| (|Expression| (|Integer|))) (|n| (|PositiveInteger|))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|ftmp| #1#)
          (|res|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|extra|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|mlc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|dg| (|NonNegativeInteger|))
          (|lc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (#2=#:G1197 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |coefr| (|spadConstant| $ 12) (QREFELT $ 235))
              (COND ((EQL |n| 1) (PROGN (LETT #2# |f|) (GO #3=#:G1196))))))
            (LETT |res| (|spadConstant| $ 18)) (LETT |ftmp| |f|)
            (SEQ G190
                 (COND
                  ((NULL
                    (SPADCALL |ftmp| (|spadConstant| $ 18) (QREFELT $ 40)))
                   (GO G191)))
                 (SEQ (LETT |lc| (SPADCALL |ftmp| (QREFELT $ 37)))
                      (LETT |dg| (SPADCALL |ftmp| (QREFELT $ 41)))
                      (LETT |mlc|
                            (SPADCALL
                             (CONS #'|LODOF2;ramification_of!0|
                                   (VECTOR $ |coefr|))
                             |lc| (QREFELT $ 237)))
                      (LETT |mlc| (SPADCALL |mlc| |n| (QREFELT $ 238)))
                      (LETT |extra|
                            (SPADCALL (SPADCALL |mlc| |dg| (QREFELT $ 34))
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL 1 |n| (QREFELT $ 49)) |dg|
                                         (QREFELT $ 239))
                                        (QREFELT $ 240))
                                       (QREFELT $ 189))
                                      (QREFELT $ 147)))
                      (LETT |res| (SPADCALL |res| |extra| (QREFELT $ 35)))
                      (EXIT (LETT |ftmp| (SPADCALL |ftmp| (QREFELT $ 44)))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT
             (SPADCALL (EXPT |n| (SPADCALL |f| (QREFELT $ 41))) |res|
                       (QREFELT $ 241)))))
          #3# (EXIT #2#)))) 

(SDEFUN |LODOF2;ramification_of!0| ((|x| NIL) ($$ NIL))
        (PROG (|coefr| $)
          (LETT |coefr| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |coefr| |x| (QREFELT $ 226)))))) 

(SDEFUN |LODOF2;testro;LodoEPiLodo;36|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|coefr| (|Expression| (|Integer|))) (|n| (|PositiveInteger|))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (|LODOF2;ramification_of| (|LODOF2;convertL3toLL| |f| $) |coefr| |n| $)) 

(SDEFUN |LODOF2;factor_op|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|Union|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|))))
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))))
        (SPROG
         ((#1=#:G1218 NIL)
          (|res|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (#2=#:G1202 NIL) (#3=#:G1220 NIL) (|i| NIL) (#4=#:G1201 NIL)
          (#5=#:G1219 NIL)
          (|fnr|
           (|List|
            (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    |var| |cen|)
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    |var| |cen|)))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |fnr| (|LODOF2;factor_newton| |f| |factorizer| |option| $))
            (EXIT
             (COND
              ((EQUAL |option| "semireg")
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |i| NIL) (LETT #5# |fnr|) G190
                         (COND
                          ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL |res|
                                           (PROG2
                                               (LETT #4#
                                                     (|LODOF2;factor_riccati|
                                                      |i| |factorizer| |option|
                                                      $))
                                               (QCDR #4#)
                                             (|check_union2| (QEQCAR #4# 0)
                                                             (|List|
                                                              (|Record|
                                                               (|:| |op|
                                                                    (|LinearOrdinaryDifferentialOperator3|
                                                                     (|Expression|
                                                                      (|Integer|))
                                                                     (|UnivariateTaylorSeries|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (QREFELT
                                                                       $ 7))
                                                                     (|UnivariateLaurentSeries|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (QREFELT
                                                                       $ 7))))
                                                               (|:| |ram|
                                                                    (|UnivariatePolynomial|
                                                                     (QREFELT $
                                                                              6)
                                                                     (|Expression|
                                                                      (|Integer|))))
                                                               (|:| |expart|
                                                                    (|UnivariateLaurentSeries|
                                                                     (|Expression|
                                                                      (|Integer|))
                                                                     (QREFELT $
                                                                              6)
                                                                     (QREFELT $
                                                                              7)))))
                                                             (|Union|
                                                              (|List|
                                                               (|Record|
                                                                (|:| |op|
                                                                     (|LinearOrdinaryDifferentialOperator3|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (|UnivariateTaylorSeries|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (QREFELT
                                                                        $ 7))
                                                                      (|UnivariateLaurentSeries|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (QREFELT
                                                                        $ 7))))
                                                                (|:| |ram|
                                                                     (|UnivariatePolynomial|
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (|Expression|
                                                                       (|Integer|))))
                                                                (|:| |expart|
                                                                     (|UnivariateLaurentSeries|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (QREFELT
                                                                       $ 7)))))
                                                              (|List|
                                                               (|Union|
                                                                (|LinearOrdinaryDifferentialOperator3|
                                                                 (|Expression|
                                                                  (|Integer|))
                                                                 (|UnivariateTaylorSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7))
                                                                 (|UnivariateLaurentSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7)))
                                                                (|Record|
                                                                 (|:| |ope|
                                                                      (|LinearOrdinaryDifferentialOperator3|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (|UnivariateTaylorSeries|
                                                                        (|Expression|
                                                                         (|Integer|))
                                                                        (QREFELT
                                                                         $ 6)
                                                                        (QREFELT
                                                                         $ 7))
                                                                       (|UnivariateLaurentSeries|
                                                                        (|Expression|
                                                                         (|Integer|))
                                                                        (QREFELT
                                                                         $ 6)
                                                                        (QREFELT
                                                                         $
                                                                         7))))
                                                                 (|:| |dext|
                                                                      (|PositiveInteger|))
                                                                 (|:| |alpha|
                                                                      (|Expression|
                                                                       (|Integer|)))
                                                                 (|:| |rami|
                                                                      (|UnivariatePolynomial|
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (|Expression|
                                                                        (|Integer|))))))))
                                                             #4#))
                                           (QREFELT $ 219)))))
                         (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (PROGN (LETT #1# (CONS 0 |res|)) (GO #6=#:G1217)))))
              ('T
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |i| NIL) (LETT #3# |fnr|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL |res|
                                           (PROG2
                                               (LETT #2#
                                                     (|LODOF2;factor_riccati|
                                                      |i| |factorizer| |option|
                                                      $))
                                               (QCDR #2#)
                                             (|check_union2| (QEQCAR #2# 1)
                                                             (|List|
                                                              (|Union|
                                                               (|LinearOrdinaryDifferentialOperator3|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (|UnivariateTaylorSeries|
                                                                 (|Expression|
                                                                  (|Integer|))
                                                                 (QREFELT $ 6)
                                                                 (QREFELT $ 7))
                                                                (|UnivariateLaurentSeries|
                                                                 (|Expression|
                                                                  (|Integer|))
                                                                 (QREFELT $ 6)
                                                                 (QREFELT $
                                                                          7)))
                                                               (|Record|
                                                                (|:| |ope|
                                                                     (|LinearOrdinaryDifferentialOperator3|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (|UnivariateTaylorSeries|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (QREFELT
                                                                        $ 7))
                                                                      (|UnivariateLaurentSeries|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (QREFELT
                                                                        $ 7))))
                                                                (|:| |dext|
                                                                     (|PositiveInteger|))
                                                                (|:| |alpha|
                                                                     (|Expression|
                                                                      (|Integer|)))
                                                                (|:| |rami|
                                                                     (|UnivariatePolynomial|
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (|Expression|
                                                                       (|Integer|)))))))
                                                             (|Union|
                                                              (|List|
                                                               (|Record|
                                                                (|:| |op|
                                                                     (|LinearOrdinaryDifferentialOperator3|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (|UnivariateTaylorSeries|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (QREFELT
                                                                        $ 7))
                                                                      (|UnivariateLaurentSeries|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (QREFELT
                                                                        $ 7))))
                                                                (|:| |ram|
                                                                     (|UnivariatePolynomial|
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (|Expression|
                                                                       (|Integer|))))
                                                                (|:| |expart|
                                                                     (|UnivariateLaurentSeries|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (QREFELT
                                                                       $ 7)))))
                                                              (|List|
                                                               (|Union|
                                                                (|LinearOrdinaryDifferentialOperator3|
                                                                 (|Expression|
                                                                  (|Integer|))
                                                                 (|UnivariateTaylorSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7))
                                                                 (|UnivariateLaurentSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7)))
                                                                (|Record|
                                                                 (|:| |ope|
                                                                      (|LinearOrdinaryDifferentialOperator3|
                                                                       (|Expression|
                                                                        (|Integer|))
                                                                       (|UnivariateTaylorSeries|
                                                                        (|Expression|
                                                                         (|Integer|))
                                                                        (QREFELT
                                                                         $ 6)
                                                                        (QREFELT
                                                                         $ 7))
                                                                       (|UnivariateLaurentSeries|
                                                                        (|Expression|
                                                                         (|Integer|))
                                                                        (QREFELT
                                                                         $ 6)
                                                                        (QREFELT
                                                                         $
                                                                         7))))
                                                                 (|:| |dext|
                                                                      (|PositiveInteger|))
                                                                 (|:| |alpha|
                                                                      (|Expression|
                                                                       (|Integer|)))
                                                                 (|:| |rami|
                                                                      (|UnivariatePolynomial|
                                                                       (QREFELT
                                                                        $ 6)
                                                                       (|Expression|
                                                                        (|Integer|))))))))
                                                             #2#))
                                           (QREFELT $ 222)))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (PROGN (LETT #1# (CONS 1 |res|)) (GO #6#)))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |LODOF2;testfo;LodoMSU;38|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|Union|
           (|List|
            (|Record|
             (|:| |op|
                  (|LinearOrdinaryDifferentialOperator3|
                   (|Expression| (|Integer|))
                   (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ram|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |expart|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|))))
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))))
        (|LODOF2;factor_op| (|LODOF2;convertL3toLL| |f| $) |factorizer|
         |option| $)) 

(SDEFUN |LODOF2;make_rightfactor|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|ric|
          (|Record|
           (|:| |ope|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |dext| (|PositiveInteger|))
           (|:| |alpha| (|Expression| (|Integer|)))
           (|:| |rami|
                (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG ((#1=#:G1230 NIL) (|d| (|PositiveInteger|)))
               (SEQ
                (EXIT
                 (SEQ (LETT |d| (SPADCALL (QVELT |ric| 3) (QREFELT $ 72)))
                      (LETT |d| (* |d| (QVELT |ric| 1)))
                      (COND
                       ((EQL |d| (SPADCALL |f| (QREFELT $ 41)))
                        (PROGN (LETT #1# |f|) (GO #2=#:G1229))))
                      (EXIT (|LODOF2;lift_rightfactor| |d| |ric| $))))
                #2# (EXIT #1#)))) 

(SDEFUN |LODOF2;lift_rightfactor|
        ((|order| (|PositiveInteger|))
         (|ric|
          (|Record|
           (|:| |ope|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |dext| (|PositiveInteger|))
           (|:| |alpha| (|Expression| (|Integer|)))
           (|:| |rami|
                (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|res|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#1=#:G1343 NIL) (|i| NIL)
          (|num|
           #2=(|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                         |cen|))
          (#3=#:G1342 NIL)
          (|coefs|
           (|List|
            (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                       |cen|)))
          (#4=#:G1341 NIL) (#5=#:G1340 NIL) (|den| #2#) (#6=#:G1339 NIL)
          (|k| NIL) (#7=#:G1338 NIL) (|j| NIL) (#8=#:G1337 NIL)
          (|nums|
           (|List|
            (|SquareMatrix| |order|
                            (|UnivariateLaurentSeries|
                             (|Expression| (|Integer|)) |var| |cen|))))
          (#9=#:G1336 NIL) (#10=#:G1335 NIL)
          (|denm|
           (|SquareMatrix| |order|
                           (|UnivariateLaurentSeries|
                            (|Expression| (|Integer|)) |var| |cen|)))
          (#11=#:G1334 NIL) (#12=#:G1333 NIL)
          (|ll|
           (|List|
            (|List|
             (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                        |cen|))))
          (#13=#:G1332 NIL) (#14=#:G1331 NIL) (#15=#:G1330 NIL)
          (#16=#:G1329 NIL)
          (|nsr|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (#17=#:G1328 NIL)
          (|ser|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (#18=#:G1327 NIL) (#19=#:G1326 NIL)
          (|pa| (|Vector| (|Expression| (|Integer|)))) (#20=#:G1325 NIL)
          (#21=#:G1324 NIL)
          (|system|
           (|List|
            (|Vector|
             (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                        |cen|))))
          (#22=#:G1323 NIL) (#23=#:G1322 NIL)
          (|cst|
           (|Stream|
            (|Record| (|:| |k| (|Integer|))
                      (|:| |c| (|Expression| (|Integer|))))))
          (#24=#:G1321 NIL) (#25=#:G1320 NIL)
          (|nn| (|Stream| (|NonNegativeInteger|)))
          (|sysram|
           (|List|
            (|Vector|
             (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                        |cen|))))
          (#26=#:G1319 NIL) (#27=#:G1318 NIL) (|mindg| (|Integer|))
          (|rp|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (#28=#:G1317 NIL)
          (|s|
           (|Vector|
            (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                       |cen|)))
          (|r|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|ram| (|NonNegativeInteger|)) (|cric| (|Expression| (|Integer|))))
         (SEQ (LETT |cric| (SPADCALL (QVELT |ric| 3) (QREFELT $ 188)))
              (LETT |ram| (SPADCALL (QVELT |ric| 3) (QREFELT $ 72)))
              (LETT |r|
                    (SPADCALL (SPADCALL (QVELT |ric| 0) 0 (QREFELT $ 52))
                              (QREFELT $ 211)))
              (LETT |rp| (|spadConstant| $ 14))
              (LETT |s| (MAKEARR1 (+ |order| 1) (|spadConstant| $ 20)))
              (SPADCALL |s| 1 (|spadConstant| $ 14) (QREFELT $ 245))
              (LETT |mindg| 0)
              (SEQ (LETT |i| 1) (LETT #28# |order|) G190
                   (COND ((|greater_SI| |i| #28#) (GO G191)))
                   (SEQ
                    (LETT |rp|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL (QREFELT $ 246))
                                      (|spadConstant| $ 20) |rp|
                                      (QREFELT $ 247))
                            (SPADCALL |r| |rp| (QREFELT $ 248))
                            (QREFELT $ 216))
                           (SPADCALL |ram| (QREFELT $ 75)) (QREFELT $ 249)))
                    (SPADCALL |s| (+ |i| 1) |rp| (QREFELT $ 245))
                    (EXIT
                     (LETT |mindg|
                           (MIN |mindg| (SPADCALL |rp| 0 (QREFELT $ 42))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SPADCALL (CONS #'|LODOF2;lift_rightfactor!0| (VECTOR |mindg| $))
                        |s| (QREFELT $ 252))
              (LETT |sysram|
                    (PROGN
                     (LETT #27# NIL)
                     (SEQ (LETT |i| 1) (LETT #26# |ram|) G190
                          (COND ((|greater_SI| |i| #26#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #27#
                                  (CONS
                                   (MAKEARR1 (+ |order| 1)
                                             (|spadConstant| $ 20))
                                   #27#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #27#)))))
              (LETT |nn|
                    (SPADCALL (CONS #'|LODOF2;lift_rightfactor!1| $) 0
                              (QREFELT $ 256)))
              (SEQ (LETT |i| 1) (LETT #25# |ram|) G190
                   (COND ((|greater_SI| |i| #25#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #24# (+ |order| 1)) G190
                          (COND ((|greater_SI| |j| #24#) (GO G191)))
                          (SEQ (LETT |ser| (SPADCALL |s| |j| (QREFELT $ 257)))
                               (LETT |cst|
                                     (SPADCALL
                                      (CONS #'|LODOF2;lift_rightfactor!2|
                                            (VECTOR |cric| |ser| |ram| $ |i|))
                                      |nn| (QREFELT $ 262)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL |sysram| |i| (QREFELT $ 264)) |j|
                                 (SPADCALL |cst| (QREFELT $ 118))
                                 (QREFELT $ 245))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |system|
                    (PROGN
                     (LETT #23# NIL)
                     (SEQ (LETT |i| 1) (LETT #22# |order|) G190
                          (COND ((|greater_SI| |i| #22#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #23#
                                  (CONS
                                   (MAKEARR1 (+ |order| 1)
                                             (|spadConstant| $ 20))
                                   #23#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #23#)))))
              (LETT |pa|
                    (PROGN
                     (LETT #21# (GETREFV #29=(QVELT |ric| 1)))
                     (SEQ (LETT |i| 0) (LETT #20# (- #29# 1)) G190
                          (COND ((|greater_SI| |i| #20#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SETELT #21# |i|
                                    (SPADCALL (QVELT |ric| 2) |i|
                                              (QREFELT $ 226)))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                     #21#))
              (SEQ (LETT |i| 1) (LETT #19# |ram|) G190
                   (COND ((|greater_SI| |i| #19#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #18# (+ |order| 1)) G190
                          (COND ((|greater_SI| |j| #18#) (GO G191)))
                          (SEQ
                           (LETT |ser|
                                 (SPADCALL
                                  (SPADCALL |sysram| |i| (QREFELT $ 264)) |j|
                                  (QREFELT $ 257)))
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #17# (QVELT |ric| 1)) G190
                                 (COND ((|greater_SI| |k| #17#) (GO G191)))
                                 (SEQ
                                  (LETT |nsr|
                                        (SPADCALL
                                         (CONS #'|LODOF2;lift_rightfactor!3|
                                               (VECTOR |k| $ |pa|))
                                         |ser| (QREFELT $ 273)))
                                  (EXIT
                                   (SPADCALL
                                    (SPADCALL |system|
                                              (+ (* (- |i| 1) (QVELT |ric| 1))
                                                 |k|)
                                              (QREFELT $ 264))
                                    |j| |nsr| (QREFELT $ 245))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |ll|
                    (PROGN
                     (LETT #16# NIL)
                     (SEQ (LETT |j| 1) (LETT #15# |order|) G190
                          (COND ((|greater_SI| |j| #15#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #16#
                                  (CONS
                                   (PROGN
                                    (LETT #14# NIL)
                                    (SEQ (LETT |i| 1) (LETT #13# |order|) G190
                                         (COND
                                          ((|greater_SI| |i| #13#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #14#
                                                 (CONS (|spadConstant| $ 20)
                                                       #14#))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT (NREVERSE #14#))))
                                   #16#))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT (NREVERSE #16#)))))
              (SEQ (LETT |i| 1) (LETT #12# |order|) G190
                   (COND ((|greater_SI| |i| #12#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #11# |order|) G190
                          (COND ((|greater_SI| |j| #11#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL (SPADCALL |ll| |i| (QREFELT $ 275)) |j|
                                      (SPADCALL
                                       (SPADCALL |system| |i| (QREFELT $ 264))
                                       |j| (QREFELT $ 257))
                                      (QREFELT $ 276))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |denm|
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 278))
                              (|compiledLookupCheck| '|squareMatrix|
                                                     (LIST '$
                                                           (LIST '|Matrix|
                                                                 (LIST
                                                                  '|UnivariateLaurentSeries|
                                                                  (LIST
                                                                   '|Expression|
                                                                   (LIST
                                                                    '|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7))))
                                                     (|SquareMatrix| |order|
                                                                     (|UnivariateLaurentSeries|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (ELT $ 6)
                                                                      (ELT $
                                                                           7))))))
              (LETT |nums|
                    (PROGN
                     (LETT #10# NIL)
                     (SEQ (LETT |i| 1) (LETT #9# |order|) G190
                          (COND ((|greater_SI| |i| #9#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #10#
                                  (CONS
                                   (SPADCALL
                                    (|compiledLookupCheck| '|empty| (LIST '$)
                                                           (|SquareMatrix|
                                                            |order|
                                                            (|UnivariateLaurentSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (ELT $ 6)
                                                             (ELT $ 7)))))
                                   #10#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #10#)))))
              (SEQ (LETT |i| 1) (LETT #8# |order|) G190
                   (COND ((|greater_SI| |i| #8#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #7# |order|) G190
                         (COND ((|greater_SI| |j| #7#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |k| 1) (LETT #6# |order|) G190
                                (COND ((|greater_SI| |k| #6#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((EQL |k| |i|)
                                    (SPADCALL
                                     (SPADCALL |ll| |j| (QREFELT $ 275)) |k|
                                     (SPADCALL
                                      (SPADCALL |system| |j| (QREFELT $ 264))
                                      (+ |order| 1) (QREFELT $ 257))
                                     (QREFELT $ 276)))
                                   ('T
                                    (SPADCALL
                                     (SPADCALL |ll| |j| (QREFELT $ 275)) |k|
                                     (SPADCALL
                                      (SPADCALL |system| |j| (QREFELT $ 264))
                                      |k| (QREFELT $ 257))
                                     (QREFELT $ 276))))))
                                (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                (EXIT NIL))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL |nums| |i|
                               (SPADCALL (SPADCALL |ll| (QREFELT $ 278))
                                         (|compiledLookupCheck| '|squareMatrix|
                                                                (LIST '$
                                                                      (LIST
                                                                       '|Matrix|
                                                                       (LIST
                                                                        '|UnivariateLaurentSeries|
                                                                        (LIST
                                                                         '|Expression|
                                                                         (LIST
                                                                          '|Integer|))
                                                                        (QREFELT
                                                                         $ 6)
                                                                        (QREFELT
                                                                         $
                                                                         7))))
                                                                (|SquareMatrix|
                                                                 |order|
                                                                 (|UnivariateLaurentSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (ELT $ 6)
                                                                  (ELT $ 7)))))
                               (|compiledLookupCheck| '|setelt!|
                                                      (LIST
                                                       (LIST '|SquareMatrix|
                                                             |order|
                                                             (LIST
                                                              '|UnivariateLaurentSeries|
                                                              (LIST
                                                               '|Expression|
                                                               (LIST
                                                                '|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7)))
                                                       '$ (LIST '|Integer|)
                                                       (LIST '|SquareMatrix|
                                                             |order|
                                                             (LIST
                                                              '|UnivariateLaurentSeries|
                                                              (LIST
                                                               '|Expression|
                                                               (LIST
                                                                '|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7))))
                                                      (|List|
                                                       (|SquareMatrix| |order|
                                                                       (|UnivariateLaurentSeries|
                                                                        (|Expression|
                                                                         (|Integer|))
                                                                        (ELT $
                                                                             6)
                                                                        (ELT $
                                                                             7))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |den|
                    (SPADCALL |denm|
                              (|compiledLookupCheck| '|minordet|
                                                     (LIST
                                                      (LIST
                                                       '|UnivariateLaurentSeries|
                                                       (LIST '|Expression|
                                                             (LIST '|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7))
                                                      '$)
                                                     (|SquareMatrix| |order|
                                                                     (|UnivariateLaurentSeries|
                                                                      (|Expression|
                                                                       (|Integer|))
                                                                      (ELT $ 6)
                                                                      (ELT $
                                                                           7))))))
              (LETT |coefs|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |i| 1) (LETT #4# |order|) G190
                          (COND ((|greater_SI| |i| #4#) (GO G191)))
                          (SEQ
                           (EXIT (LETT #5# (CONS (|spadConstant| $ 20) #5#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (SEQ (LETT |i| 1) (LETT #3# |order|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |num|
                          (SPADCALL
                           (SPADCALL |nums| |i|
                                     (|compiledLookupCheck| '|elt|
                                                            (LIST
                                                             (LIST
                                                              '|SquareMatrix|
                                                              |order|
                                                              (LIST
                                                               '|UnivariateLaurentSeries|
                                                               (LIST
                                                                '|Expression|
                                                                (LIST
                                                                 '|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7)))
                                                             '$
                                                             (LIST '|Integer|))
                                                            (|List|
                                                             (|SquareMatrix|
                                                              |order|
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (ELT $ 6)
                                                               (ELT $ 7))))))
                           (|compiledLookupCheck| '|minordet|
                                                  (LIST
                                                   (LIST
                                                    '|UnivariateLaurentSeries|
                                                    (LIST '|Expression|
                                                          (LIST '|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   '$)
                                                  (|SquareMatrix| |order|
                                                                  (|UnivariateLaurentSeries|
                                                                   (|Expression|
                                                                    (|Integer|))
                                                                   (ELT $ 6)
                                                                   (ELT $
                                                                        7))))))
                    (EXIT
                     (SPADCALL |coefs| |i|
                               (SPADCALL (SPADCALL |num| |den| (QREFELT $ 250))
                                         (QREFELT $ 211))
                               (QREFELT $ 276))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |res|
                    (SPADCALL (|spadConstant| $ 14) |order| (QREFELT $ 34)))
              (SEQ (LETT |i| 0) (LETT #1# (- |order| 1)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (SPADCALL
                                      (SPADCALL |coefs| (+ |i| 1)
                                                (QREFELT $ 111))
                                      |i| (QREFELT $ 34))
                                     (QREFELT $ 35)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;lift_rightfactor!3| ((|x| NIL) ($$ NIL))
        (PROG (|pa| $ |k|)
          (LETT |pa| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |k| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1264 NIL) (|psq| NIL))
                   (SEQ (LETT |psq| (SPADCALL |pa| |x| (QREFELT $ 268)))
                        (EXIT
                         (COND
                          ((SPADCALL |psq| (CONS 1 "failed") (QREFELT $ 269))
                           |x|)
                          ('T
                           (SPADCALL
                            (SPADCALL
                             (PROG2 (LETT #1# |psq|)
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0)
                                               (|Vector|
                                                (|Fraction| (|Integer|)))
                                               (|Union|
                                                (|Vector|
                                                 (|Fraction| (|Integer|)))
                                                "failed")
                                               #1#))
                             |k| (QREFELT $ 271))
                            (QREFELT $ 240))))))))))) 

(SDEFUN |LODOF2;lift_rightfactor!2| ((|x| NIL) ($$ NIL))
        (PROG (|i| $ |ram| |ser| |cric|)
          (LETT |i| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |ram| (QREFELT $$ 2))
          (LETT |ser| (QREFELT $$ 1))
          (LETT |cric| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|dg| NIL))
                   (SEQ
                    (LETT |dg|
                          (SPADCALL
                           (SPADCALL |i| (|spadConstant| $ 171)
                                     (QREFELT $ 134))
                           (SPADCALL |x| |ram| (QREFELT $ 258))
                           (QREFELT $ 130)))
                    (EXIT
                     (CONS |x|
                           (SPADCALL (SPADCALL |ser| |dg| (QREFELT $ 54))
                                     (SPADCALL |cric| |x| (QREFELT $ 259))
                                     (QREFELT $ 76)))))))))) 

(SDEFUN |LODOF2;lift_rightfactor!1| ((|x| NIL) ($ NIL))
        (SPADCALL |x| (|spadConstant| $ 171) (QREFELT $ 253))) 

(SDEFUN |LODOF2;lift_rightfactor!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |mindg|)
          (LETT $ (QREFELT $$ 1))
          (LETT |mindg| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x|
                      (SPADCALL (|spadConstant| $ 12) |mindg| (QREFELT $ 146))
                      (QREFELT $ 250)))))) 

(SDEFUN |LODOF2;same_charclass?|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|g|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1381 NIL) (#2=#:G1384 NIL) (|i| NIL)
          (|fff|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor|
                           (|UnivariatePolynomial| |var|
                                                   (|Expression| (|Integer|))))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|ffnp|
           (|List|
            (|Record|
             (|:| |point|
                  (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
             (|:| |slope| (|Fraction| (|Integer|)))
             (|:| |npoly|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
          (|ff|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#3=#:G793 NIL)
          (|gr| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|rr|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|gg|
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (#4=#:G794 NIL) (#5=#:G1368 NIL)
          (|r|
           (|List|
            (|List|
             (|Record|
              (|:| |point|
                   (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
              (|:| |slope| (|Fraction| (|Integer|)))
              (|:| |npoly|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (#6=#:G1383 NIL) (|j| NIL) (#7=#:G1382 NIL)
          (|cx| (|Expression| (|Integer|))) (|fd| (|Expression| (|Integer|)))
          (|dm1| (|NonNegativeInteger|)) (|d| (|NonNegativeInteger|))
          (|c2| #8=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|c| #8#)
          (|r21|
           #9=(|Record|
               (|:| |point|
                    (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
               (|:| |slope| (|Fraction| (|Integer|)))
               (|:| |npoly|
                    (|UnivariatePolynomial| |var|
                                            (|Expression| (|Integer|))))))
          (|r11| #9#)
          (|il|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL (SPADCALL |f| (QREFELT $ 41))
                        (SPADCALL |g| (QREFELT $ 41)) (QREFELT $ 204))
              (PROGN (LETT #1# NIL) (GO #10=#:G1380))))
            (COND
             ((SPADCALL (SPADCALL |f| (QREFELT $ 37)) (|spadConstant| $ 14)
                        (QREFELT $ 279))
              (LETT |f|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 14)
                               (SPADCALL |f| (QREFELT $ 37)) (QREFELT $ 250))
                     |f| (QREFELT $ 157)))))
            (COND
             ((SPADCALL (SPADCALL |g| (QREFELT $ 37)) (|spadConstant| $ 14)
                        (QREFELT $ 279))
              (LETT |g|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 14)
                               (SPADCALL |g| (QREFELT $ 37)) (QREFELT $ 250))
                     |g| (QREFELT $ 157)))))
            (COND
             ((EQL (SPADCALL |f| (QREFELT $ 41)) 1)
              (SEQ
               (LETT |il|
                     (SPADCALL
                      (SPADCALL (SPADCALL |f| |g| (QREFELT $ 163)) 0
                                (QREFELT $ 52))
                      0 (QREFELT $ 210)))
               (EXIT
                (PROGN
                 (LETT #1#
                       (COND
                        ((EQL (SPADCALL |il| 0 (QREFELT $ 42)) 0)
                         (SPADCALL (SPADCALL |il| 0 (QREFELT $ 54))
                                   (QREFELT $ 78)))
                        ('T NIL)))
                 (GO #10#))))))
            (LETT |r|
                  (SPADCALL (CONS (|function| |LODOF2;newtonpolygon|) $)
                            (LIST |f| |g|) (QREFELT $ 287)))
            (LETT |r11|
                  (SPADCALL (SPADCALL |r| 1 (QREFELT $ 288)) 1
                            (QREFELT $ 192)))
            (LETT |r21|
                  (SPADCALL (SPADCALL |r| 2 (QREFELT $ 288)) 1
                            (QREFELT $ 192)))
            (COND
             ((SPADCALL (QVELT |r11| 1) (|spadConstant| $ 65) (QREFELT $ 107))
              (SEQ (LETT |c| (QVELT |r11| 2)) (LETT |c2| (QVELT |r21| 2))
                   (LETT |d| (SPADCALL |c| (QREFELT $ 72)))
                   (LETT |dm1| (- |d| 1))
                   (LETT |fd| (SPADCALL |d| (QREFELT $ 75)))
                   (LETT |cx|
                         (SPADCALL
                          (SPADCALL (SPADCALL |c| |dm1| (QREFELT $ 73))
                                    (SPADCALL |c2| |dm1| (QREFELT $ 73))
                                    (QREFELT $ 74))
                          |fd| (QREFELT $ 76)))
                   (COND
                    ((NULL (SPADCALL |cx| (QREFELT $ 78)))
                     (PROGN (LETT #1# NIL) (GO #10#))))
                   (EXIT
                    (LETT |r|
                          (LIST
                           (CONS
                            (VECTOR (QVELT |r11| 0) (QVELT |r11| 1)
                                    (SPADCALL (QVELT |r11| 2)
                                              (SPADCALL (|spadConstant| $ 12) 1
                                                        (QREFELT $ 55))
                                              (SPADCALL
                                               (SPADCALL (|spadConstant| $ 12)
                                                         1 (QREFELT $ 55))
                                               (SPADCALL |cx| (QREFELT $ 225))
                                               (QREFELT $ 83))
                                              (QREFELT $ 82)))
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT |j| 2)
                                  (LETT #6#
                                        (LENGTH
                                         (SPADCALL |r| 1 (QREFELT $ 288))))
                                  G190
                                  (COND ((|greater_SI| |j| #6#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #7#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL |r| 1 (QREFELT $ 288))
                                            |j| (QREFELT $ 192))
                                           #7#))))
                                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                  (EXIT (NREVERSE #7#)))))
                           (SPADCALL |r| 2 (QREFELT $ 288))))))))
            (COND
             ((SPADCALL (SPADCALL |r| 1 (QREFELT $ 288))
                        (SPADCALL |r| 2 (QREFELT $ 288)) (QREFELT $ 289))
              (PROGN (LETT #1# NIL) (GO #10#))))
            (LETT |gg|
                  (PROG2
                      (LETT #4#
                            (SPADCALL
                             (PROG2
                                 (LETT #5#
                                       (|LODOF2;factor_op| |g| |factorizer|
                                        "alg factor" $))
                                 (QCDR #5#)
                               (|check_union2| (QEQCAR #5# 1)
                                               (|List|
                                                (|Union|
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))
                                                 (|Record|
                                                  (|:| |ope|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))))
                                                  (|:| |dext|
                                                       (|PositiveInteger|))
                                                  (|:| |alpha|
                                                       (|Expression|
                                                        (|Integer|)))
                                                  (|:| |rami|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|)))))))
                                               (|Union|
                                                (|List|
                                                 (|Record|
                                                  (|:| |op|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))))
                                                  (|:| |ram|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))
                                                  (|:| |expart|
                                                       (|UnivariateLaurentSeries|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7)))))
                                                (|List|
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))))
                                               #5#))
                             (QREFELT $ 196)))
                      (QCDR #4#)
                    (|check_union2| (QEQCAR #4# 1)
                                    (|Record|
                                     (|:| |ope|
                                          (|LinearOrdinaryDifferentialOperator3|
                                           (|Expression| (|Integer|))
                                           (|UnivariateTaylorSeries|
                                            (|Expression| (|Integer|))
                                            (QREFELT $ 6) (QREFELT $ 7))
                                           (|UnivariateLaurentSeries|
                                            (|Expression| (|Integer|))
                                            (QREFELT $ 6) (QREFELT $ 7))))
                                     (|:| |dext| (|PositiveInteger|))
                                     (|:| |alpha| (|Expression| (|Integer|)))
                                     (|:| |rami|
                                          (|UnivariatePolynomial| (QREFELT $ 6)
                                                                  (|Expression|
                                                                   (|Integer|)))))
                                    (|Union|
                                     (|LinearOrdinaryDifferentialOperator3|
                                      (|Expression| (|Integer|))
                                      (|UnivariateTaylorSeries|
                                       (|Expression| (|Integer|)) (QREFELT $ 6)
                                       (QREFELT $ 7))
                                      (|UnivariateLaurentSeries|
                                       (|Expression| (|Integer|)) (QREFELT $ 6)
                                       (QREFELT $ 7)))
                                     (|Record|
                                      (|:| |ope|
                                           (|LinearOrdinaryDifferentialOperator3|
                                            (|Expression| (|Integer|))
                                            (|UnivariateTaylorSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))))
                                      (|:| |dext| (|PositiveInteger|))
                                      (|:| |alpha| (|Expression| (|Integer|)))
                                      (|:| |rami|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))
                                    #4#)))
            (LETT |rr|
                  (SPADCALL
                   (SPADCALL (SPADCALL (QVELT |gg| 0) 0 (QREFELT $ 52)) 0
                             (QREFELT $ 210))
                   (QREFELT $ 211)))
            (LETT |gr| (QVELT |gg| 3))
            (LETT |ff|
                  (PROG2
                      (LETT #3#
                            (|LODOF2;substitute| (CONS 1 |rr|)
                             (CONS 0
                                   (|LODOF2;ramification_of| |f|
                                    (SPADCALL |gr| (QREFELT $ 188))
                                    (SPADCALL |gr| (QREFELT $ 72)) $))
                             $))
                      (QCDR #3#)
                    (|check_union2| (QEQCAR #3# 0)
                                    (|LinearOrdinaryDifferentialOperator3|
                                     (|Expression| (|Integer|))
                                     (|UnivariateTaylorSeries|
                                      (|Expression| (|Integer|)) (QREFELT $ 6)
                                      (QREFELT $ 7))
                                     (|UnivariateLaurentSeries|
                                      (|Expression| (|Integer|)) (QREFELT $ 6)
                                      (QREFELT $ 7)))
                                    (|Union|
                                     (|LinearOrdinaryDifferentialOperator3|
                                      (|Expression| (|Integer|))
                                      (|UnivariateTaylorSeries|
                                       (|Expression| (|Integer|)) (QREFELT $ 6)
                                       (QREFELT $ 7))
                                      (|UnivariateLaurentSeries|
                                       (|Expression| (|Integer|)) (QREFELT $ 6)
                                       (QREFELT $ 7)))
                                     (|Record|
                                      (|:| |ope|
                                           (|LinearOrdinaryDifferentialOperator3|
                                            (|Expression| (|Integer|))
                                            (|UnivariateTaylorSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))))
                                      (|:| |dext| (|PositiveInteger|))
                                      (|:| |alpha| (|Expression| (|Integer|)))
                                      (|:| |rami|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))
                                    #3#)))
            (LETT |ffnp| (|LODOF2;newtonpolygon| |ff| $))
            (COND
             ((SPADCALL (QVELT (SPADCALL |ffnp| 1 (QREFELT $ 192)) 1)
                        (|spadConstant| $ 65) (QREFELT $ 66))
              (PROGN (LETT #1# NIL) (GO #10#))))
            (LETT |fff|
                  (SPADCALL
                   (|LODOF2;factorUP|
                    (SPADCALL (QVELT (SPADCALL |ffnp| 1 (QREFELT $ 192)) 2)
                              (SPADCALL
                               (QVELT (SPADCALL |ffnp| 1 (QREFELT $ 192)) 2)
                               (QREFELT $ 188))
                              (QREFELT $ 290))
                    |factorizer| $)
                   (QREFELT $ 201)))
            (SEQ (LETT |i| NIL) (LETT #2# |fff|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((EQL (SPADCALL (QVELT |i| 1) (QREFELT $ 72)) 1)
                     (COND
                      ((SPADCALL
                        (SPADCALL (SPADCALL (QVELT |i| 1) 0 (QREFELT $ 73))
                                  (SPADCALL (QVELT |i| 1) 1 (QREFELT $ 73))
                                  (QREFELT $ 76))
                        (QREFELT $ 78))
                       (PROGN (LETT #1# 'T) (GO #10#))))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT NIL)))
          #10# (EXIT #1#)))) 

(SDEFUN |LODOF2;testsc;2LodoMB;42|
        ((|f|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|g|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariatePolynomial| |var|
                                                                         (|Expression|
                                                                          (|Integer|)))
                                                 (|Fraction|
                                                  (|UnivariatePolynomial| |var|
                                                                          (|Expression|
                                                                           (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         ($ (|Boolean|)))
        (|LODOF2;same_charclass?| (|LODOF2;convertL3toLL| |f| $)
         (|LODOF2;convertL3toLL| |g| $) |factorizer| $)) 

(SDEFUN |LODOF2;try_factorization|
        ((|r|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|max_order| (|Integer|)) (|bound| (|List| (|Fraction| (|Integer|))))
         (|sng|
          (|Record|
           (|:| |point| (|Union| (|Expression| (|Integer|)) #1="infinity"))
           (|:| |lpf|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |dxt| (|PositiveInteger|))))
         (|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|eb| (|Integer|)) (|min_order| (|Integer|)) (|option| (|String|))
         ($
          (|Union|
           (|List|
            (|LinearOrdinaryDifferentialOperator1|
             (|Fraction|
              (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
           "failed")))
        (SPROG
         ((#2=#:G1435 NIL)
          (|re|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|srl|
           #3=(|LinearOrdinaryDifferentialOperator1|
               (|Fraction|
                (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (#4=#:G1415 NIL) (|ftmp| #3#)
          (|slc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|lcd|
           #5=(|Fraction|
               (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|lcn| #5#) (|dg| (|NonNegativeInteger|))
          (|lc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|newd|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|newx|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|old_x| (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
          (|zero_sing| (|Boolean|))
          (|sr|
           #6=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                     (|UnivariatePolynomial|
                                                      |var|
                                                      (|Expression|
                                                       (|Integer|)))
                                                     (|Fraction|
                                                      (|UnivariatePolynomial|
                                                       |var|
                                                       (|Expression|
                                                        (|Integer|))))))
          (#7=#:G1412 NIL) (#8=#:G1411 #6#) (#9=#:G1413 #6#) (#10=#:G1447 NIL)
          (|j| NIL)
          (|flm|
           (|List| (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
          (#11=#:G1406 NIL)
          (|tf2|
           (|Union|
            (|List| (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
            #12="failed"))
          (|n| (|Integer|))
          (|flst|
           (|List|
            (|List|
             (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                       |cen|))))
          (#13=#:G1446 NIL) (|fc| NIL) (#14=#:G1445 NIL) (#15=#:G1444 NIL)
          (|ff| NIL) (#16=#:G1443 NIL)
          (|fls|
           (|List|
            (|List|
             (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                        |cen|))))
          (#17=#:G1442 NIL) (#18=#:G1441 NIL) (#19=#:G1440 NIL)
          (#20=#:G1439 NIL) (#21=#:G1438 NIL) (#22=#:G1437 NIL)
          (#23=#:G1436 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| (MAX (SPADCALL |r| (QREFELT $ 41)) |min_order|))
                 (LETT #23# |max_order|) G190 (COND ((> |i| #23#) (GO G191)))
                 (SEQ (LETT |fls| (|LODOF2;flist| |r| |i| $)) (LETT |n| 0)
                      (SEQ (LETT |ff| NIL) (LETT #22# |fls|) G190
                           (COND
                            ((OR (ATOM #22#)
                                 (PROGN (LETT |ff| (CAR #22#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (SEQ (LETT |fc| NIL) (LETT #21# |ff|) G190
                                  (COND
                                   ((OR (ATOM #21#)
                                        (PROGN (LETT |fc| (CAR #21#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT |n|
                                          (MIN |n|
                                               (SPADCALL |fc| 0
                                                         (QREFELT $ 42))))))
                                  (LETT #21# (CDR #21#)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT #22# (CDR #22#)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((< |n| 0)
                        (LETT |fls|
                              (PROGN
                               (LETT #20# NIL)
                               (SEQ (LETT |ff| NIL) (LETT #19# |fls|) G190
                                    (COND
                                     ((OR (ATOM #19#)
                                          (PROGN (LETT |ff| (CAR #19#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #20#
                                            (CONS
                                             (PROGN
                                              (LETT #18# NIL)
                                              (SEQ (LETT |fc| NIL)
                                                   (LETT #17# |ff|) G190
                                                   (COND
                                                    ((OR (ATOM #17#)
                                                         (PROGN
                                                          (LETT |fc|
                                                                (CAR #17#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #18#
                                                           (CONS
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (|spadConstant| $
                                                                              12)
                                                              (- |n|)
                                                              (QREFELT $ 146))
                                                             |fc|
                                                             (QREFELT $ 248))
                                                            #18#))))
                                                   (LETT #17# (CDR #17#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #18#))))
                                             #20#))))
                                    (LETT #19# (CDR #19#)) (GO G190) G191
                                    (EXIT (NREVERSE #20#)))))))
                      (LETT |flst|
                            (PROGN
                             (LETT #16# NIL)
                             (SEQ (LETT |ff| NIL) (LETT #15# |fls|) G190
                                  (COND
                                   ((OR (ATOM #15#)
                                        (PROGN (LETT |ff| (CAR #15#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #16#
                                          (CONS
                                           (PROGN
                                            (LETT #14# NIL)
                                            (SEQ (LETT |fc| NIL)
                                                 (LETT #13# |ff|) G190
                                                 (COND
                                                  ((OR (ATOM #13#)
                                                       (PROGN
                                                        (LETT |fc| (CAR #13#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #14#
                                                         (CONS
                                                          (SPADCALL |fc|
                                                                    (QREFELT $
                                                                             292))
                                                          #14#))))
                                                 (LETT #13# (CDR #13#))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #14#))))
                                           #16#))))
                                  (LETT #15# (CDR #15#)) (GO G190) G191
                                  (EXIT (NREVERSE #16#)))))
                      (LETT |n| (LENGTH |flst|))
                      (LETT |tf2|
                            (|LODOF2;try_factorization2| |flst| |n| |bound|
                             |eb| $))
                      (EXIT
                       (COND
                        ((SPADCALL |tf2| (CONS 1 "failed") (QREFELT $ 294))
                         (SEQ
                          (LETT |flm|
                                (PROG2 (LETT #11# |tf2|)
                                    (QCDR #11#)
                                  (|check_union2| (QEQCAR #11# 0)
                                                  (|List|
                                                   (|SparseUnivariatePolynomial|
                                                    (|Expression|
                                                     (|Integer|))))
                                                  (|Union|
                                                   (|List|
                                                    (|SparseUnivariatePolynomial|
                                                     (|Expression|
                                                      (|Integer|))))
                                                   #12#)
                                                  #11#)))
                          (LETT |sr|
                                (PROGN
                                 (LETT #7# NIL)
                                 (SEQ (LETT |j| 0)
                                      (LETT #10# (- (LENGTH |flm|) 1)) G190
                                      (COND
                                       ((|greater_SI| |j| #10#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (PROGN
                                         (LETT #9#
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |flm| (+ |j| 1)
                                                            (QREFELT $ 296))
                                                  (QREFELT $ 97))
                                                 (QREFELT $ 230))
                                                (SPADCALL
                                                 (|spadConstant| $ 297) |j|
                                                 (QREFELT $ 298))
                                                (QREFELT $ 299)))
                                         (COND
                                          (#7#
                                           (LETT #8#
                                                 (SPADCALL #8# #9#
                                                           (QREFELT $ 300))))
                                          ('T
                                           (PROGN
                                            (LETT #8# #9#)
                                            (LETT #7# 'T)))))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (COND (#7# #8#) ('T (|spadConstant| $ 22)))))
                          (LETT |sr|
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 297)
                                           (SPADCALL |sr| (QREFELT $ 26))
                                           (QREFELT $ 303))
                                 |sr| (QREFELT $ 299)))
                          (COND
                           ((EQUAL |option| "use adjoint")
                            (LETT |sr| (SPADCALL |sr| (QREFELT $ 304)))))
                          (LETT |srl| (SPADCALL |sr| (QREFELT $ 307)))
                          (LETT |zero_sing|
                                (COND
                                 ((QEQCAR (QVELT |sng| 0) 0)
                                  (SPADCALL
                                   (PROG2 (LETT #4# (QVELT |sng| 0))
                                       (QCDR #4#)
                                     (|check_union2| (QEQCAR #4# 0)
                                                     (|Expression| (|Integer|))
                                                     (|Union|
                                                      (|Expression|
                                                       (|Integer|))
                                                      #1#)
                                                     #4#))
                                   (|spadConstant| $ 19) (QREFELT $ 235)))
                                 ('T NIL)))
                          (COND
                           ((NULL |zero_sing|)
                            (SEQ (LETT |ftmp| |srl|)
                                 (LETT |srl| (|spadConstant| $ 308))
                                 (LETT |old_x|
                                       (SPADCALL (|spadConstant| $ 12) 1
                                                 (QREFELT $ 55)))
                                 (LETT |newx|
                                       (COND
                                        ((SPADCALL (QVELT |sng| 0)
                                                   (CONS 1 "infinity")
                                                   (QREFELT $ 310))
                                         (SPADCALL (|spadConstant| $ 150)
                                                   |old_x| (QREFELT $ 311)))
                                        ('T
                                         (SPADCALL
                                          (SPADCALL |old_x|
                                                    (SPADCALL
                                                     (PROG2
                                                         (LETT #4#
                                                               (QVELT |sng| 0))
                                                         (QCDR #4#)
                                                       (|check_union2|
                                                        (QEQCAR #4# 0)
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|Union|
                                                         (|Expression|
                                                          (|Integer|))
                                                         #1#)
                                                        #4#))
                                                     (QREFELT $ 225))
                                                    (QREFELT $ 83))
                                          (QREFELT $ 230)))))
                                 (LETT |newd|
                                       (COND
                                        ((SPADCALL (QVELT |sng| 0)
                                                   (CONS 1 "infinity")
                                                   (QREFELT $ 310))
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |old_x| 2
                                                      (QREFELT $ 312))
                                            (QREFELT $ 230))
                                           (SPADCALL (QREFELT $ 313))
                                           (QREFELT $ 314))
                                          (QREFELT $ 315)))
                                        ('T (SPADCALL (QREFELT $ 313)))))
                                 (EXIT
                                  (SEQ G190
                                       (COND
                                        ((NULL
                                          (SPADCALL |ftmp|
                                                    (|spadConstant| $ 308)
                                                    (QREFELT $ 316)))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |lc|
                                              (SPADCALL |ftmp|
                                                        (QREFELT $ 317)))
                                        (LETT |dg|
                                              (SPADCALL |ftmp|
                                                        (QREFELT $ 318)))
                                        (LETT |lcn|
                                              (|LODOF2;subsup|
                                               (SPADCALL |lc| (QREFELT $ 29))
                                               |newx| $))
                                        (LETT |lcd|
                                              (|LODOF2;subsup|
                                               (SPADCALL |lc| (QREFELT $ 27))
                                               |newx| $))
                                        (LETT |slc|
                                              (SPADCALL |lcn| |lcd|
                                                        (QREFELT $ 303)))
                                        (LETT |srl|
                                              (SPADCALL |srl|
                                                        (SPADCALL |slc|
                                                                  (SPADCALL
                                                                   |newd| |dg|
                                                                   (QREFELT $
                                                                            319))
                                                                  (QREFELT $
                                                                           314))
                                                        (QREFELT $ 320)))
                                        (EXIT
                                         (LETT |ftmp|
                                               (SPADCALL |ftmp|
                                                         (QREFELT $ 321)))))
                                       NIL (GO G190) G191 (EXIT NIL))))))
                          (EXIT
                           (COND
                            ((SPADCALL |option| "use adjoint" (QREFELT $ 322))
                             (SEQ
                              (LETT |re| (SPADCALL |f| |srl| (QREFELT $ 323)))
                              (EXIT
                               (COND
                                ((> (SPADCALL |re| (QREFELT $ 318)) 0)
                                 (PROGN
                                  (LETT #2#
                                        (CONS 0
                                              (LIST
                                               (SPADCALL |f| |re|
                                                         (QREFELT $ 324))
                                               |re|)))
                                  (GO #24=#:G1434)))))))
                            ('T
                             (SEQ
                              (COND
                               ((SPADCALL (QVELT |sng| 0) (CONS 1 "infinity")
                                          (QREFELT $ 310))
                                (LETT |re|
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 150)
                                                 (SPADCALL
                                                  (|spadConstant| $ 12)
                                                  (SPADCALL |f|
                                                            (QREFELT $ 318))
                                                  (QREFELT $ 55))
                                                 (QREFELT $ 311))
                                       (QREFELT $ 325))))
                               ('T
                                (LETT |re|
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 150)
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (|spadConstant| $ 12) 1
                                                    (QREFELT $ 55))
                                                   (SPADCALL
                                                    (PROG2
                                                        (LETT #4#
                                                              (QVELT |sng| 0))
                                                        (QCDR #4#)
                                                      (|check_union2|
                                                       (QEQCAR #4# 0)
                                                       (|Expression|
                                                        (|Integer|))
                                                       (|Union|
                                                        (|Expression|
                                                         (|Integer|))
                                                        #1#)
                                                       #4#))
                                                    (QREFELT $ 225))
                                                   (QREFELT $ 83))
                                                  (SPADCALL |f|
                                                            (QREFELT $ 318))
                                                  (QREFELT $ 67))
                                                 (QREFELT $ 311))
                                       (QREFELT $ 325)))))
                              (LETT |srl|
                                    (SPADCALL
                                     (SPADCALL |re|
                                               (SPADCALL |f| (QREFELT $ 317))
                                               (QREFELT $ 326))
                                     |srl| (QREFELT $ 327)))
                              (LETT |srl|
                                    (SPADCALL |srl|
                                              (SPADCALL (|spadConstant| $ 297)
                                                        (SPADCALL |srl|
                                                                  (QREFELT $
                                                                           317))
                                                        (QREFELT $ 303))
                                              (QREFELT $ 326)))
                              (LETT |re| (SPADCALL |f| |srl| (QREFELT $ 328)))
                              (EXIT
                               (COND
                                ((> (SPADCALL |re| (QREFELT $ 318)) 0)
                                 (PROGN
                                  (LETT #2#
                                        (CONS 0
                                              (LIST |re|
                                                    (SPADCALL |f| |re|
                                                              (QREFELT $
                                                                       329)))))
                                  (GO #24#))))))))))))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 1 "failed"))))
          #24# (EXIT #2#)))) 

(SDEFUN |LODOF2;try_factorization2|
        ((|fl|
          (|List|
           (|List|
            (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                      |cen|))))
         (|n| (|Integer|)) (|bound| (|List| (|Fraction| (|Integer|))))
         (|eb| (|Integer|))
         ($
          (|Union|
           (|List| (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           "failed")))
        (SPROG
         ((|nstep| (|Integer|)) (|acc| (|Integer|)) (#1=#:G1464 NIL)
          (|hps|
           (|Matrix|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
          (|lv|
           (|List|
            (|Vector|
             (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))))
          (#2=#:G1470 NIL) (|g| NIL) (#3=#:G1469 NIL) (#4=#:G1468 NIL)
          (|f| NIL) (#5=#:G1467 NIL) (|vdim| (|NonNegativeInteger|))
          (|cnt| (|Integer|)) (|eta| (|List| (|NonNegativeInteger|)))
          (#6=#:G1466 NIL) (|i| NIL) (#7=#:G1465 NIL) (|cb| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |cb|
                  (+
                   (SPADCALL
                    (SPADCALL |bound| (- (LENGTH |fl|) 1) (QREFELT $ 331))
                    (QREFELT $ 185))
                   |eb|))
            (LETT |eta|
                  (PROGN
                   (LETT #7# NIL)
                   (SEQ (LETT |i| 1) (LETT #6# |n|) G190
                        (COND ((|greater_SI| |i| #6#) (GO G191)))
                        (SEQ (EXIT (LETT #7# (CONS |cb| #7#))))
                        (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                        (EXIT (NREVERSE #7#)))))
            (LETT |cnt| (* (LENGTH |fl|) (+ |cb| 1)))
            (LETT |vdim| (LENGTH (|SPADfirst| |fl|)))
            (LETT |acc| (QUOTIENT2 (+ (+ |cnt| |vdim|) 3) |vdim|))
            (LETT |nstep|
                  (SPADCALL
                   (SPADCALL (SPADCALL |acc| 2 (QREFELT $ 332)) 3
                             (QREFELT $ 49))
                   (QREFELT $ 185)))
            (EXIT
             (SEQ G190 NIL
                  (SEQ
                   (LETT |lv|
                         (PROGN
                          (LETT #5# NIL)
                          (SEQ (LETT |f| NIL) (LETT #4# |fl|) G190
                               (COND
                                ((OR (ATOM #4#)
                                     (PROGN (LETT |f| (CAR #4#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #5#
                                       (CONS
                                        (SPADCALL
                                         (PROGN
                                          (LETT #3# NIL)
                                          (SEQ (LETT |g| NIL) (LETT #2# |f|)
                                               G190
                                               (COND
                                                ((OR (ATOM #2#)
                                                     (PROGN
                                                      (LETT |g| (CAR #2#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #3#
                                                       (CONS
                                                        (SPADCALL
                                                         (|LODOF2;convertUTStoUP|
                                                          |g| |acc| $)
                                                         (QREFELT $ 96))
                                                        #3#))))
                                               (LETT #2# (CDR #2#)) (GO G190)
                                               G191 (EXIT (NREVERSE #3#))))
                                         (QREFELT $ 334))
                                        #5#))))
                               (LETT #4# (CDR #4#)) (GO G190) G191
                               (EXIT (NREVERSE #5#)))))
                   (LETT |hps| (SPADCALL |lv| |eta| |acc| (QREFELT $ 339)))
                   (EXIT
                    (COND
                     ((EQL (ANCOLS |hps|) 1)
                      (PROGN
                       (LETT #1#
                             (CONS 0
                                   (SPADCALL (SPADCALL |hps| 1 (QREFELT $ 340))
                                             (QREFELT $ 341))))
                       (GO #8=#:G1463)))
                     ((EQL (ANCOLS |hps|) 0)
                      (PROGN (LETT #1# (CONS 1 "failed")) (GO #8#)))
                     ('T
                      (SEQ (LETT |acc| (+ |acc| |nstep|))
                           (EXIT
                            (LETT |nstep|
                                  (+
                                   (SPADCALL
                                    (SPADCALL (SPADCALL 3 2 (QREFELT $ 49))
                                              |nstep| (QREFELT $ 342))
                                    (QREFELT $ 183))
                                   2))))))))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #8# (EXIT #1#)))) 

(SDEFUN |LODOF2;flist|
        ((|r|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|order| (|Integer|))
         ($
          (|List|
           (|List|
            (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                       |cen|)))))
        (SPROG
         ((|res|
           (|List|
            (|List|
             (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                        |cen|))))
          (#1=#:G1480 NIL) (|j| NIL) (#2=#:G1479 NIL)
          (|p|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#3=#:G1478 NIL) (|i| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |i| 0) (LETT #3# |order|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (LETT |p| (|LODOF2;xDn_modr| |i| |r| $))
                        (EXIT
                         (LETT |res|
                               (SPADCALL |res|
                                         (LIST
                                          (PROGN
                                           (LETT #2# NIL)
                                           (SEQ (LETT |j| 0)
                                                (LETT #1#
                                                      (-
                                                       (SPADCALL |r|
                                                                 (QREFELT $
                                                                          41))
                                                       1))
                                                G190
                                                (COND
                                                 ((|greater_SI| |j| #1#)
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #2#
                                                        (CONS
                                                         (SPADCALL |p| |j|
                                                                   (QREFELT $
                                                                            52))
                                                         #2#))))
                                                (LETT |j| (|inc_SI| |j|))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #2#)))))
                                         (QREFELT $ 343)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;xDn_modr|
        ((|n| (|Integer|))
         (|r|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|coefa|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|a|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#1=#:G1484 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((< |n| (SPADCALL |r| (QREFELT $ 41)))
              (PROGN
               (LETT #1# (SPADCALL (|spadConstant| $ 14) |n| (QREFELT $ 34)))
               (GO #2=#:G1483))))
            (LETT |a| (|LODOF2;xDn_modr| (- |n| 1) |r| $))
            (LETT |coefa|
                  (SPADCALL |a| (- (SPADCALL |r| (QREFELT $ 41)) 1)
                            (QREFELT $ 52)))
            (EXIT
             (SPADCALL
              (SPADCALL
               (SPADCALL (SPADCALL (|spadConstant| $ 14) 1 (QREFELT $ 34)) |a|
                         (QREFELT $ 159))
               (SPADCALL |a| (SPADCALL (|spadConstant| $ 14) 1 (QREFELT $ 34))
                         (QREFELT $ 159))
               (QREFELT $ 35))
              (SPADCALL |coefa| |r| (QREFELT $ 157)) (QREFELT $ 163)))))
          #2# (EXIT #1#)))) 

(SDEFUN |LODOF2;factor;LodoMLL;47|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))
           (|List| (|Expression| (|Integer|)))))
         (|y| (|List| (|Expression| (|Integer|))))
         ($
          (|List|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (SPROG
         ((#1=#:G1501 NIL) (#2=#:G1502 NIL) (|i| NIL)
          (|res|
           (|List|
            (|LinearOrdinaryDifferentialOperator1|
             (|Fraction|
              (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
          (|b|
           (|List|
            (|LinearOrdinaryDifferentialOperator1|
             (|Fraction|
              (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
          (|factorizer2|
           (|Mapping|
            (|Factored|
             (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((<= (SPADCALL |f| (QREFELT $ 318)) 1)
              (PROGN (LETT #1# (LIST |f|)) (GO #3=#:G1500))))
            (LETT |factorizer2|
                  (CONS #'|LODOF2;factor;LodoMLL;47!0|
                        (VECTOR |factorizer| |y|)))
            (LETT |b| (|LODOF2;factor_global| |f| |factorizer2| $))
            (EXIT
             (COND ((EQL (LENGTH |b|) 1) (PROGN (LETT #1# |b|) (GO #3#)))
                   ('T
                    (SEQ
                     (LETT |res|
                           (SPADCALL
                            (SPADCALL (SPADCALL |b| 1 (QREFELT $ 345))
                                      |factorizer| |y| (QREFELT $ 348))
                            (SPADCALL (SPADCALL |b| 2 (QREFELT $ 345))
                                      |factorizer| |y| (QREFELT $ 348))
                            (QREFELT $ 349)))
                     (SEQ (LETT |i| 3) (LETT #2# (LENGTH |b|)) G190
                          (COND ((> |i| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |res|
                                      (SPADCALL
                                       (SPADCALL |b| |i| (QREFELT $ 345))
                                       |factorizer| |y| (QREFELT $ 348))
                                      (QREFELT $ 350))))
                          (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                     (EXIT (PROGN (LETT #1# |res|) (GO #3#)))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |LODOF2;factor;LodoMLL;47!0| ((|x| NIL) ($$ NIL))
        (PROG (|y| |factorizer|)
          (LETT |y| (QREFELT $$ 1))
          (LETT |factorizer| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |y| |factorizer|))))) 

(SDEFUN |LODOF2;inf_singularity?|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1511 NIL)
          (|dlc|
           (|List| (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (#2=#:G1514 NIL) (|e| NIL) (#3=#:G1513 NIL)
          (|fi|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|yu|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|slc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|lcd|
           #4=(|Fraction|
               (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|lcn| #4#)
          (|lc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (#5=#:G1512 NIL) (|i| NIL)
          (|ux|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |fi| (|spadConstant| $ 308))
                (LETT |ux|
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 12) 2 (QREFELT $ 55))
                        (QREFELT $ 230))
                       (QREFELT $ 351)))
                (LETT |yu| (|spadConstant| $ 352))
                (SEQ (LETT |i| 0) (LETT #5# (SPADCALL |f| (QREFELT $ 318)))
                     G190 (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ (LETT |lc| (SPADCALL |f| |i| (QREFELT $ 353)))
                          (LETT |lcn|
                                (|LODOF2;subsup| (SPADCALL |lc| (QREFELT $ 29))
                                 (SPADCALL (|spadConstant| $ 150)
                                           (SPADCALL (|spadConstant| $ 12) 1
                                                     (QREFELT $ 55))
                                           (QREFELT $ 311))
                                 $))
                          (LETT |lcd|
                                (|LODOF2;subsup| (SPADCALL |lc| (QREFELT $ 27))
                                 (SPADCALL (|spadConstant| $ 150)
                                           (SPADCALL (|spadConstant| $ 12) 1
                                                     (QREFELT $ 55))
                                           (QREFELT $ 311))
                                 $))
                          (LETT |slc| (SPADCALL |lcn| |lcd| (QREFELT $ 303)))
                          (LETT |fi|
                                (SPADCALL |fi|
                                          (SPADCALL |slc| |yu| (QREFELT $ 314))
                                          (QREFELT $ 320)))
                          (EXIT
                           (LETT |yu|
                                 (SPADCALL
                                  (SPADCALL |ux| (SPADCALL (QREFELT $ 313))
                                            (QREFELT $ 314))
                                  |yu| (QREFELT $ 327)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (LETT |fi|
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 297)
                                 (SPADCALL |fi| (QREFELT $ 317))
                                 (QREFELT $ 303))
                       |fi| (QREFELT $ 314)))
                (LETT |dlc|
                      (PROGN
                       (LETT #3# NIL)
                       (SEQ (LETT |e| (SPADCALL |fi| (QREFELT $ 355)))
                            (LETT #2# (SPADCALL |fi| (QREFELT $ 318))) G190
                            (COND ((> |e| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #3#
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL |fi| |e| (QREFELT $ 353))
                                      (QREFELT $ 27))
                                     #3#))))
                            (LETT |e| (+ |e| 1)) (GO G190) G191
                            (EXIT (NREVERSE #3#)))))
                (COND
                 ((SPADCALL
                   (SPADCALL (SPADCALL |dlc| (QREFELT $ 356))
                             (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 55))
                             (|spadConstant| $ 50) (QREFELT $ 82))
                   (|spadConstant| $ 50) (QREFELT $ 84))
                  (PROGN (LETT #1# 'T) (GO #6=#:G1510))))
                (EXIT NIL)))
          #6# (EXIT #1#)))) 

(SDEFUN |LODOF2;testis;LodoB;49|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         ($ (|Boolean|)))
        (|LODOF2;inf_singularity?| |f| $)) 

(SDEFUN |LODOF2;factor_global|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         ($
          (|List|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (SPROG
         ((#1=#:G1639 NIL) (#2=#:G1598 NIL)
          (|t|
           (|Union|
            (|List|
             (|LinearOrdinaryDifferentialOperator1|
              (|Fraction|
               (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
            #3="failed"))
          (|r_left|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#4=#:G793 NIL) (#5=#:G1663 NIL) (|l| NIL)
          (|vrs|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (#6=#:G1576 NIL)
          (|kk|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|jj|
           (|Record|
            (|:| |ope|
                 (|LinearOrdinaryDifferentialOperator3|
                  (|Expression| (|Integer|))
                  (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |dext| (|PositiveInteger|))
            (|:| |alpha| (|Expression| (|Integer|)))
            (|:| |rami|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (#7=#:G794 NIL)
          (|j1|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (|iarf1|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#8=#:G1662 NIL) (|s| NIL) (#9=#:G1661 NIL) (|sop| NIL)
          (#10=#:G1660 NIL) (#11=#:G1658 NIL) (#12=#:G1659 NIL) (|sa| NIL)
          (#13=#:G1657 NIL)
          (|done_sa|
           (|List|
            (|Record|
             (|:| |sing|
                  (|Record|
                   (|:| |point|
                        (|Union| (|Expression| (|Integer|)) #14="infinity"))
                   (|:| |lpf|
                        (|LinearOrdinaryDifferentialOperator3|
                         (|Expression| (|Integer|))
                         (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))
                   (|:| |dxt| (|PositiveInteger|))))
             (|:| |arf|
                  (|List|
                   (|Union|
                    (|LinearOrdinaryDifferentialOperator3|
                     (|Expression| (|Integer|))
                     (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)
                     (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                |var| |cen|))
                    (|Record|
                     (|:| |ope|
                          (|LinearOrdinaryDifferentialOperator3|
                           (|Expression| (|Integer|))
                           (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                     |var| |cen|)
                           (|UnivariateLaurentSeries|
                            (|Expression| (|Integer|)) |var| |cen|)))
                     (|:| |dext| (|PositiveInteger|))
                     (|:| |alpha| (|Expression| (|Integer|)))
                     (|:| |rami|
                          (|UnivariatePolynomial| |var|
                                                  (|Expression|
                                                   (|Integer|)))))))))))
          (#15=#:G1656 NIL) (|all_one| (|Boolean|)) (#16=#:G1655 NIL)
          (#17=#:G1653 NIL) (|ssp| NIL) (#18=#:G1654 NIL)
          (|done_s|
           (|List|
            (|Record|
             (|:| |sing|
                  (|Record|
                   (|:| |point| (|Union| (|Expression| (|Integer|)) #14#))
                   (|:| |lpf|
                        (|LinearOrdinaryDifferentialOperator3|
                         (|Expression| (|Integer|))
                         (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))
                   (|:| |dxt| (|PositiveInteger|))))
             (|:| |arf|
                  (|List|
                   (|Union|
                    (|LinearOrdinaryDifferentialOperator3|
                     (|Expression| (|Integer|))
                     (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)
                     (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                |var| |cen|))
                    (|Record|
                     (|:| |ope|
                          (|LinearOrdinaryDifferentialOperator3|
                           (|Expression| (|Integer|))
                           (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                     |var| |cen|)
                           (|UnivariateLaurentSeries|
                            (|Expression| (|Integer|)) |var| |cen|)))
                     (|:| |dext| (|PositiveInteger|))
                     (|:| |alpha| (|Expression| (|Integer|)))
                     (|:| |rami|
                          (|UnivariatePolynomial| |var|
                                                  (|Expression|
                                                   (|Integer|)))))))))))
          (|gem|
           #19=(|List|
                (|Record|
                 (|:| |singularity|
                      (|Record|
                       (|:| |point| (|Union| (|Expression| (|Integer|)) #14#))
                       (|:| |lpf|
                            (|LinearOrdinaryDifferentialOperator3|
                             (|Expression| (|Integer|))
                             (|UnivariateTaylorSeries|
                              (|Expression| (|Integer|)) |var| |cen|)
                             (|UnivariateLaurentSeries|
                              (|Expression| (|Integer|)) |var| |cen|)))
                       (|:| |dxt| (|PositiveInteger|))))
                 (|:| |fos|
                      (|List|
                       (|Record|
                        (|:| |op|
                             (|LinearOrdinaryDifferentialOperator3|
                              (|Expression| (|Integer|))
                              (|UnivariateTaylorSeries|
                               (|Expression| (|Integer|)) |var| |cen|)
                              (|UnivariateLaurentSeries|
                               (|Expression| (|Integer|)) |var| |cen|)))
                        (|:| |ram|
                             (|UnivariatePolynomial| |var|
                                                     (|Expression|
                                                      (|Integer|))))
                        (|:| |expart|
                             (|UnivariateLaurentSeries|
                              (|Expression| (|Integer|)) |var| |cen|)))))
                 (|:| |mge|
                      (|List|
                       (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                  |var| |cen|))))))
          (#20=#:G1652 NIL) (|ge| NIL) (|min_deg| (|PositiveInteger|))
          (|dl| (|List| (|PositiveInteger|))) (#21=#:G1651 NIL)
          (#22=#:G1650 NIL) (|eba| (|Integer|)) (|gema| #19#)
          (|eb| (|Integer|)) (|bound| (|List| (|Fraction| (|Integer|))))
          (#23=#:G1649 NIL) (|j| NIL) (#24=#:G1648 NIL) (#25=#:G1647 NIL)
          (|i| NIL) (|v| (|List| (|Fraction| (|Integer|)))) (#26=#:G1646 NIL)
          (|ji1x| #27=(|Integer|)) (|jix| #27#) (|ji1y| #28=(|Integer|))
          (|jiy| #28#) (#29=#:G1645 NIL)
          (|np|
           (|List|
            (|Record|
             (|:| |point|
                  (|Record| (|:| |x| (|Integer|)) (|:| |y| (|Integer|))))
             (|:| |slope| (|Fraction| (|Integer|)))
             (|:| |npoly|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))))
          (#30=#:G1644 NIL) (#31=#:G1643 NIL) (#32=#:G1642 NIL)
          (#33=#:G1641 NIL) (#34=#:G1640 NIL)
          (|a|
           (|List|
            (|LinearOrdinaryDifferentialOperator1|
             (|Fraction|
              (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((<= (SPADCALL |f| (QREFELT $ 318)) 1)
              (PROGN (LETT #1# (LIST |f|)) (GO #35=#:G1638))))
            (COND
             ((SPADCALL (SPADCALL |f| (QREFELT $ 317)) (|spadConstant| $ 297)
                        (QREFELT $ 358))
              (SEQ
               (LETT |a|
                     (|LODOF2;factor_global|
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 297)
                                 (SPADCALL |f| (QREFELT $ 317))
                                 (QREFELT $ 303))
                       |f| (QREFELT $ 314))
                      |factorizer| $))
               (EXIT
                (PROGN
                 (LETT #1#
                       (CONS
                        (SPADCALL (SPADCALL |f| (QREFELT $ 317))
                                  (SPADCALL |a| 1 (QREFELT $ 345))
                                  (QREFELT $ 314))
                        (PROGN
                         (LETT #34# NIL)
                         (SEQ (LETT |i| 2) (LETT #33# (LENGTH |a|)) G190
                              (COND ((|greater_SI| |i| #33#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #34#
                                      (CONS (SPADCALL |a| |i| (QREFELT $ 345))
                                            #34#))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #34#))))))
                 (GO #35#))))))
            (COND
             ((EQL (SPADCALL |f| (QREFELT $ 318)) 2)
              (SPADCALL
               (SPADCALL "Better to use old factorizer" (QREFELT $ 359))
               (QREFELT $ 167))))
            (LETT |gem| (SPADCALL |f| |factorizer| "" (QREFELT $ 363)))
            (LETT |bound|
                  (PROGN
                   (LETT #32# NIL)
                   (SEQ (LETT |i| 1)
                        (LETT #31# (- (SPADCALL |f| (QREFELT $ 318)) 1)) G190
                        (COND ((|greater_SI| |i| #31#) (GO G191)))
                        (SEQ
                         (EXIT (LETT #32# (CONS (|spadConstant| $ 65) #32#))))
                        (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                        (EXIT (NREVERSE #32#)))))
            (LETT |eb| -1)
            (SEQ (LETT |s| NIL) (LETT #30# |gem|) G190
                 (COND
                  ((OR (ATOM #30#) (PROGN (LETT |s| (CAR #30#)) NIL))
                   (GO G191)))
                 (SEQ
                  (LETT |np|
                        (|LODOF2;newtonpolygon| (QVELT (QVELT |s| 0) 1) $))
                  (LETT |np|
                        (SPADCALL |np|
                                  (LIST
                                   (VECTOR
                                    (CONS
                                     (SPADCALL (QVELT (QVELT |s| 0) 1)
                                               (QREFELT $ 41))
                                     0)
                                    (|spadConstant| $ 65)
                                    (|spadConstant| $ 50)))
                                  (QREFELT $ 59)))
                  (LETT |v| NIL)
                  (SEQ (LETT |i| 1) (LETT #29# (- (LENGTH |np|) 1)) G190
                       (COND ((|greater_SI| |i| #29#) (GO G191)))
                       (SEQ
                        (LETT |jiy|
                              (QCDR
                               (QVELT (SPADCALL |np| |i| (QREFELT $ 192)) 0)))
                        (LETT |ji1y|
                              (QCDR
                               (QVELT (SPADCALL |np| (+ |i| 1) (QREFELT $ 192))
                                      0)))
                        (LETT |jix|
                              (QCAR
                               (QVELT (SPADCALL |np| |i| (QREFELT $ 192)) 0)))
                        (LETT |ji1x|
                              (QCAR
                               (QVELT (SPADCALL |np| (+ |i| 1) (QREFELT $ 192))
                                      0)))
                        (EXIT
                         (SEQ (LETT |l| |jix|) (LETT #26# (- |ji1x| 1)) G190
                              (COND ((> |l| #26#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT |v|
                                      (SPADCALL |v|
                                                (LIST
                                                 (SPADCALL
                                                  (SPADCALL |jiy|
                                                            (QREFELT $ 102))
                                                  (SPADCALL
                                                   (* (- |l| |jix|)
                                                      (- |ji1y| |jiy|))
                                                   (- |ji1x| |jix|)
                                                   (QREFELT $ 49))
                                                  (QREFELT $ 104)))
                                                (QREFELT $ 364)))))
                              (LETT |l| (+ |l| 1)) (GO G190) G191 (EXIT NIL))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (SEQ (LETT |i| 1)
                       (LETT #25# (- (SPADCALL |f| (QREFELT $ 318)) 1)) G190
                       (COND ((|greater_SI| |i| #25#) (GO G191)))
                       (SEQ
                        (EXIT
                         (SPADCALL |bound| |i|
                                   (SPADCALL
                                    (SPADCALL |bound| |i| (QREFELT $ 331))
                                    (SPADCALL (QVELT (QVELT |s| 0) 2)
                                              (SPADCALL |v| (+ |i| 1)
                                                        (QREFELT $ 331))
                                              (QREFELT $ 365))
                                    (QREFELT $ 104))
                                   (QREFELT $ 366))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT (LETT |eb| (+ |eb| (QVELT (QVELT |s| 0) 2)))))
                 (LETT #30# (CDR #30#)) (GO G190) G191 (EXIT NIL))
            (LETT |bound|
                  (PROGN
                   (LETT #24# NIL)
                   (SEQ (LETT |j| 1)
                        (LETT #23# (- (SPADCALL |f| (QREFELT $ 318)) 1)) G190
                        (COND ((|greater_SI| |j| #23#) (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #24#
                                (CONS
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL |bound|
                                             (- (SPADCALL |f| (QREFELT $ 318))
                                                |j|)
                                             (QREFELT $ 331))
                                   (QREFELT $ 367))
                                  (SPADCALL |j| (SPADCALL |eb| (QREFELT $ 102))
                                            (QREFELT $ 365))
                                  (QREFELT $ 104))
                                 #24#))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                        (EXIT (NREVERSE #24#)))))
            (LETT |eb| (|LODOF2;compute_bound| |gem| (|spadConstant| $ 19) $))
            (LETT |gema|
                  (SPADCALL |f| |factorizer| "use adjoint" (QREFELT $ 363)))
            (LETT |eba|
                  (|LODOF2;compute_bound| |gema| (|spadConstant| $ 19) $))
            (LETT |all_one| 'T) (LETT |done_s| NIL)
            (SEQ G190 (COND ((NULL (NULL (NULL |gem|))) (GO G191)))
                 (SEQ
                  (LETT |dl|
                        (PROGN
                         (LETT #22# NIL)
                         (SEQ (LETT |s| NIL) (LETT #21# |gem|) G190
                              (COND
                               ((OR (ATOM #21#)
                                    (PROGN (LETT |s| (CAR #21#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #22#
                                      (CONS (QVELT (QVELT |s| 0) 2) #22#))))
                              (LETT #21# (CDR #21#)) (GO G190) G191
                              (EXIT (NREVERSE #22#)))))
                  (LETT |min_deg| (SPADCALL (ELT $ 371) |dl| (QREFELT $ 374)))
                  (EXIT
                   (SEQ (LETT |ge| NIL) (LETT #20# |gem|) G190
                        (COND
                         ((OR (ATOM #20#) (PROGN (LETT |ge| (CAR #20#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((EQL (QVELT (QVELT |ge| 0) 2) |min_deg|)
                            (SEQ
                             (LETT |gem| (SPADCALL |ge| |gem| (QREFELT $ 375)))
                             (LETT |vrs|
                                   (PROG2
                                       (LETT #6#
                                             (|LODOF2;factor_op|
                                              (QVELT (QVELT |ge| 0) 1)
                                              |factorizer| "all right factors"
                                              $))
                                       (QCDR #6#)
                                     (|check_union2| (QEQCAR #6# 1)
                                                     (|List|
                                                      (|Union|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7)))
                                                       (|Record|
                                                        (|:| |ope|
                                                             (|LinearOrdinaryDifferentialOperator3|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|UnivariateTaylorSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))))
                                                        (|:| |dext|
                                                             (|PositiveInteger|))
                                                        (|:| |alpha|
                                                             (|Expression|
                                                              (|Integer|)))
                                                        (|:| |rami|
                                                             (|UnivariatePolynomial|
                                                              (QREFELT $ 6)
                                                              (|Expression|
                                                               (|Integer|)))))))
                                                     (|Union|
                                                      (|List|
                                                       (|Record|
                                                        (|:| |op|
                                                             (|LinearOrdinaryDifferentialOperator3|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|UnivariateTaylorSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))))
                                                        (|:| |ram|
                                                             (|UnivariatePolynomial|
                                                              (QREFELT $ 6)
                                                              (|Expression|
                                                               (|Integer|))))
                                                        (|:| |expart|
                                                             (|UnivariateLaurentSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7)))))
                                                      (|List|
                                                       (|Union|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7)))
                                                        (|Record|
                                                         (|:| |ope|
                                                              (|LinearOrdinaryDifferentialOperator3|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (|UnivariateTaylorSeries|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (QREFELT $ 6)
                                                                (QREFELT $ 7))
                                                               (|UnivariateLaurentSeries|
                                                                (|Expression|
                                                                 (|Integer|))
                                                                (QREFELT $ 6)
                                                                (QREFELT $
                                                                         7))))
                                                         (|:| |dext|
                                                              (|PositiveInteger|))
                                                         (|:| |alpha|
                                                              (|Expression|
                                                               (|Integer|)))
                                                         (|:| |rami|
                                                              (|UnivariatePolynomial|
                                                               (QREFELT $ 6)
                                                               (|Expression|
                                                                (|Integer|))))))))
                                                     #6#)))
                             (LETT |done_s|
                                   (SPADCALL |done_s|
                                             (LIST (CONS (QVELT |ge| 0) |vrs|))
                                             (QREFELT $ 378)))
                             (SEQ (LETT |sop| NIL) (LETT #18# |vrs|)
                                  (LETT |ssp| NIL) (LETT #17# (QVELT |ge| 1))
                                  G190
                                  (COND
                                   ((OR (ATOM #17#)
                                        (PROGN (LETT |ssp| (CAR #17#)) NIL)
                                        (ATOM #18#)
                                        (PROGN (LETT |sop| (CAR #18#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((EQL
                                       (SPADCALL (QVELT |ssp| 0)
                                                 (QREFELT $ 41))
                                       1)
                                      (COND
                                       ((EQL
                                         (SPADCALL
                                          (PROG2 (LETT #4# |sop|)
                                              (QCDR #4#)
                                            (|check_union2| (QEQCAR #4# 0)
                                                            (|LinearOrdinaryDifferentialOperator3|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (|UnivariateTaylorSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7))
                                                             (|UnivariateLaurentSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7)))
                                                            (|Union|
                                                             (|LinearOrdinaryDifferentialOperator3|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|UnivariateTaylorSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7)))
                                                             (|Record|
                                                              (|:| |ope|
                                                                   (|LinearOrdinaryDifferentialOperator3|
                                                                    (|Expression|
                                                                     (|Integer|))
                                                                    (|UnivariateTaylorSeries|
                                                                     (|Expression|
                                                                      (|Integer|))
                                                                     (QREFELT $
                                                                              6)
                                                                     (QREFELT $
                                                                              7))
                                                                    (|UnivariateLaurentSeries|
                                                                     (|Expression|
                                                                      (|Integer|))
                                                                     (QREFELT $
                                                                              6)
                                                                     (QREFELT $
                                                                              7))))
                                                              (|:| |dext|
                                                                   (|PositiveInteger|))
                                                              (|:| |alpha|
                                                                   (|Expression|
                                                                    (|Integer|)))
                                                              (|:| |rami|
                                                                   (|UnivariatePolynomial|
                                                                    (QREFELT $
                                                                             6)
                                                                    (|Expression|
                                                                     (|Integer|))))))
                                                            #4#))
                                          (QREFELT $ 41))
                                         1)
                                        (PROGN
                                         (LETT #1#
                                               (|LODOF2;factor_minmult1|
                                                |bound| (QVELT |ge| 0) |f| |eb|
                                                |eba|
                                                (PROG2 (LETT #4# |sop|)
                                                    (QCDR #4#)
                                                  (|check_union2|
                                                   (QEQCAR #4# 0)
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Union|
                                                    (|LinearOrdinaryDifferentialOperator3|
                                                     (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)))
                                                    (|Record|
                                                     (|:| |ope|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))))
                                                     (|:| |dext|
                                                          (|PositiveInteger|))
                                                     (|:| |alpha|
                                                          (|Expression|
                                                           (|Integer|)))
                                                     (|:| |rami|
                                                          (|UnivariatePolynomial|
                                                           (QREFELT $ 6)
                                                           (|Expression|
                                                            (|Integer|))))))
                                                   #4#))
                                                |factorizer| $))
                                         (GO #35#))))))))
                                  (LETT #17#
                                        (PROG1 (CDR #17#)
                                          (LETT #18# (CDR #18#))))
                                  (GO G190) G191 (EXIT NIL))
                             (EXIT
                              (LETT |all_one|
                                    (COND
                                     (|all_one|
                                      (COND
                                       ((EQL (LENGTH |vrs|) 1)
                                        (EQL
                                         (SPADCALL
                                          (PROG2
                                              (LETT #4#
                                                    (SPADCALL |vrs| 1
                                                              (QREFELT $ 379)))
                                              (QCDR #4#)
                                            (|check_union2| (QEQCAR #4# 0)
                                                            (|LinearOrdinaryDifferentialOperator3|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (|UnivariateTaylorSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7))
                                                             (|UnivariateLaurentSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (QREFELT $ 6)
                                                              (QREFELT $ 7)))
                                                            (|Union|
                                                             (|LinearOrdinaryDifferentialOperator3|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|UnivariateTaylorSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7))
                                                              (|UnivariateLaurentSeries|
                                                               (|Expression|
                                                                (|Integer|))
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 7)))
                                                             (|Record|
                                                              (|:| |ope|
                                                                   (|LinearOrdinaryDifferentialOperator3|
                                                                    (|Expression|
                                                                     (|Integer|))
                                                                    (|UnivariateTaylorSeries|
                                                                     (|Expression|
                                                                      (|Integer|))
                                                                     (QREFELT $
                                                                              6)
                                                                     (QREFELT $
                                                                              7))
                                                                    (|UnivariateLaurentSeries|
                                                                     (|Expression|
                                                                      (|Integer|))
                                                                     (QREFELT $
                                                                              6)
                                                                     (QREFELT $
                                                                              7))))
                                                              (|:| |dext|
                                                                   (|PositiveInteger|))
                                                              (|:| |alpha|
                                                                   (|Expression|
                                                                    (|Integer|)))
                                                              (|:| |rami|
                                                                   (|UnivariatePolynomial|
                                                                    (QREFELT $
                                                                             6)
                                                                    (|Expression|
                                                                     (|Integer|))))))
                                                            #4#))
                                          (QREFELT $ 41))
                                         1))
                                       ('T NIL)))
                                     ('T NIL)))))))))
                        (LETT #20# (CDR #20#)) (GO G190) G191 (EXIT NIL))))
                 NIL (GO G190) G191 (EXIT NIL))
            (COND
             (|all_one|
              (SPADCALL
               (SPADCALL "Better to use old factorizer" (QREFELT $ 359))
               (QREFELT $ 167))))
            (LETT |all_one| 'T) (LETT |done_sa| NIL)
            (SEQ (LETT |s| NIL) (LETT #16# |done_s|) G190
                 (COND
                  ((OR (ATOM #16#) (PROGN (LETT |s| (CAR #16#)) NIL))
                   (GO G191)))
                 (SEQ
                  (LETT |all_one|
                        (COND (|all_one| (EQL (LENGTH (QCDR |s|)) 1))
                              ('T NIL)))
                  (SEQ (LETT |sop| NIL) (LETT #15# (QCDR |s|)) G190
                       (COND
                        ((OR (ATOM #15#) (PROGN (LETT |sop| (CAR #15#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |t|
                              (|LODOF2;try_factorization|
                               (PROG2 (LETT #4# |sop|)
                                   (QCDR #4#)
                                 (|check_union2| (QEQCAR #4# 0)
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                 #4#))
                               (SPADCALL
                                (SPADCALL (SPADCALL |f| (QREFELT $ 318)) 2
                                          (QREFELT $ 49))
                                (QREFELT $ 183))
                               |bound| (QCAR |s|) |f| |eb| 0 "" $))
                        (EXIT
                         (COND
                          ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
                           (PROGN
                            (LETT #1#
                                  (PROG2 (LETT #2# |t|)
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 0)
                                                    (|List|
                                                     (|LinearOrdinaryDifferentialOperator1|
                                                      (|Fraction|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))))
                                                    (|Union|
                                                     (|List|
                                                      (|LinearOrdinaryDifferentialOperator1|
                                                       (|Fraction|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                     #3#)
                                                    #2#)))
                            (GO #35#))))))
                       (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
                  (LETT |vrs|
                        (PROG2
                            (LETT #6#
                                  (|LODOF2;factor_op|
                                   (SPADCALL (QVELT (QCAR |s|) 1)
                                             (QREFELT $ 382))
                                   |factorizer| "all right factors" $))
                            (QCDR #6#)
                          (|check_union2| (QEQCAR #6# 1)
                                          (|List|
                                           (|Union|
                                            (|LinearOrdinaryDifferentialOperator3|
                                             (|Expression| (|Integer|))
                                             (|UnivariateTaylorSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7))
                                             (|UnivariateLaurentSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7)))
                                            (|Record|
                                             (|:| |ope|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))))
                                             (|:| |dext| (|PositiveInteger|))
                                             (|:| |alpha|
                                                  (|Expression| (|Integer|)))
                                             (|:| |rami|
                                                  (|UnivariatePolynomial|
                                                   (QREFELT $ 6)
                                                   (|Expression|
                                                    (|Integer|)))))))
                                          (|Union|
                                           (|List|
                                            (|Record|
                                             (|:| |op|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))))
                                             (|:| |ram|
                                                  (|UnivariatePolynomial|
                                                   (QREFELT $ 6)
                                                   (|Expression| (|Integer|))))
                                             (|:| |expart|
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))))
                                           (|List|
                                            (|Union|
                                             (|LinearOrdinaryDifferentialOperator3|
                                              (|Expression| (|Integer|))
                                              (|UnivariateTaylorSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7))
                                              (|UnivariateLaurentSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7)))
                                             (|Record|
                                              (|:| |ope|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))))
                                              (|:| |dext| (|PositiveInteger|))
                                              (|:| |alpha|
                                                   (|Expression| (|Integer|)))
                                              (|:| |rami|
                                                   (|UnivariatePolynomial|
                                                    (QREFELT $ 6)
                                                    (|Expression|
                                                     (|Integer|))))))))
                                          #6#)))
                  (LETT |done_sa|
                        (SPADCALL |done_sa| (LIST (CONS (QCAR |s|) |vrs|))
                                  (QREFELT $ 378)))
                  (EXIT
                   (SEQ (LETT |sop| NIL) (LETT #13# |vrs|) G190
                        (COND
                         ((OR (ATOM #13#) (PROGN (LETT |sop| (CAR #13#)) NIL))
                          (GO G191)))
                        (SEQ
                         (LETT |t|
                               (|LODOF2;try_factorization|
                                (PROG2 (LETT #4# |sop|)
                                    (QCDR #4#)
                                  (|check_union2| (QEQCAR #4# 0)
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Union|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Record|
                                                    (|:| |ope|
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))))
                                                    (|:| |dext|
                                                         (|PositiveInteger|))
                                                    (|:| |alpha|
                                                         (|Expression|
                                                          (|Integer|)))
                                                    (|:| |rami|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))
                                                  #4#))
                                (SPADCALL
                                 (SPADCALL (SPADCALL |f| (QREFELT $ 318)) 2
                                           (QREFELT $ 49))
                                 (QREFELT $ 183))
                                |bound| (QCAR |s|) |f| |eba| 0 "use adjoint"
                                $))
                         (EXIT
                          (COND
                           ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
                            (PROGN
                             (LETT #1#
                                   (PROG2 (LETT #2# |t|)
                                       (QCDR #2#)
                                     (|check_union2| (QEQCAR #2# 0)
                                                     (|List|
                                                      (|LinearOrdinaryDifferentialOperator1|
                                                       (|Fraction|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                     (|Union|
                                                      (|List|
                                                       (|LinearOrdinaryDifferentialOperator1|
                                                        (|Fraction|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))
                                                      #3#)
                                                     #2#)))
                             (GO #35#))))))
                        (LETT #13# (CDR #13#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #16# (CDR #16#)) (GO G190) G191 (EXIT NIL))
            (SEQ (LETT |sa| NIL) (LETT #12# |done_sa|) (LETT |s| NIL)
                 (LETT #11# |done_s|) G190
                 (COND
                  ((OR (ATOM #11#) (PROGN (LETT |s| (CAR #11#)) NIL)
                       (ATOM #12#) (PROGN (LETT |sa| (CAR #12#)) NIL))
                   (GO G191)))
                 (SEQ
                  (SEQ (LETT |sop| NIL) (LETT #10# (QCDR |s|)) G190
                       (COND
                        ((OR (ATOM #10#) (PROGN (LETT |sop| (CAR #10#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |t|
                              (|LODOF2;try_factorization|
                               (PROG2 (LETT #4# |sop|)
                                   (QCDR #4#)
                                 (|check_union2| (QEQCAR #4# 0)
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                 #4#))
                               (- (SPADCALL |f| (QREFELT $ 318)) 1) |bound|
                               (QCAR |s|) |f| |eb|
                               (+
                                (SPADCALL
                                 (SPADCALL (SPADCALL |f| (QREFELT $ 318)) 2
                                           (QREFELT $ 49))
                                 (QREFELT $ 183))
                                1)
                               "" $))
                        (EXIT
                         (COND
                          ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
                           (PROGN
                            (LETT #1#
                                  (PROG2 (LETT #2# |t|)
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 0)
                                                    (|List|
                                                     (|LinearOrdinaryDifferentialOperator1|
                                                      (|Fraction|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))))
                                                    (|Union|
                                                     (|List|
                                                      (|LinearOrdinaryDifferentialOperator1|
                                                       (|Fraction|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                     #3#)
                                                    #2#)))
                            (GO #35#))))))
                       (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SEQ (LETT |sop| NIL) (LETT #9# (QCDR |sa|)) G190
                        (COND
                         ((OR (ATOM #9#) (PROGN (LETT |sop| (CAR #9#)) NIL))
                          (GO G191)))
                        (SEQ
                         (LETT |t|
                               (|LODOF2;try_factorization|
                                (PROG2 (LETT #4# |sop|)
                                    (QCDR #4#)
                                  (|check_union2| (QEQCAR #4# 0)
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Union|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Record|
                                                    (|:| |ope|
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))))
                                                    (|:| |dext|
                                                         (|PositiveInteger|))
                                                    (|:| |alpha|
                                                         (|Expression|
                                                          (|Integer|)))
                                                    (|:| |rami|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))
                                                  #4#))
                                (- (SPADCALL |f| (QREFELT $ 318)) 1) |bound|
                                (QCAR |s|) |f| |eba|
                                (+
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |f| (QREFELT $ 318)) 2
                                            (QREFELT $ 49))
                                  (QREFELT $ 183))
                                 1)
                                "use adjoint" $))
                         (EXIT
                          (COND
                           ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
                            (PROGN
                             (LETT #1#
                                   (PROG2 (LETT #2# |t|)
                                       (QCDR #2#)
                                     (|check_union2| (QEQCAR #2# 0)
                                                     (|List|
                                                      (|LinearOrdinaryDifferentialOperator1|
                                                       (|Fraction|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                     (|Union|
                                                      (|List|
                                                       (|LinearOrdinaryDifferentialOperator1|
                                                        (|Fraction|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))
                                                      #3#)
                                                     #2#)))
                             (GO #35#))))))
                        (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #11# (PROG1 (CDR #11#) (LETT #12# (CDR #12#))))
                 (GO G190) G191 (EXIT NIL))
            (COND
             (|all_one|
              (SEQ (LETT |s| NIL) (LETT #8# |done_s|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |s| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |iarf1|
                          (PROG2 (LETT #4# (|SPADfirst| (QCDR |s|)))
                              (QCDR #4#)
                            (|check_union2| (QEQCAR #4# 0)
                                            (|LinearOrdinaryDifferentialOperator3|
                                             (|Expression| (|Integer|))
                                             (|UnivariateTaylorSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7))
                                             (|UnivariateLaurentSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7)))
                                            (|Union|
                                             (|LinearOrdinaryDifferentialOperator3|
                                              (|Expression| (|Integer|))
                                              (|UnivariateTaylorSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7))
                                              (|UnivariateLaurentSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7)))
                                             (|Record|
                                              (|:| |ope|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))))
                                              (|:| |dext| (|PositiveInteger|))
                                              (|:| |alpha|
                                                   (|Expression| (|Integer|)))
                                              (|:| |rami|
                                                   (|UnivariatePolynomial|
                                                    (QREFELT $ 6)
                                                    (|Expression|
                                                     (|Integer|))))))
                                            #4#)))
                    (EXIT
                     (COND
                      ((> (SPADCALL |iarf1| (QREFELT $ 41)) 1)
                       (SEQ
                        (LETT |j1|
                              (PROG2
                                  (LETT #6#
                                        (|LODOF2;factor_op| |iarf1|
                                         |factorizer| "alg factor" $))
                                  (QCDR #6#)
                                (|check_union2| (QEQCAR #6# 1)
                                                (|List|
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|)))))))
                                                (|Union|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |op|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |ram|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))
                                                   (|:| |expart|
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7)))))
                                                 (|List|
                                                  (|Union|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Record|
                                                    (|:| |ope|
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))))
                                                    (|:| |dext|
                                                         (|PositiveInteger|))
                                                    (|:| |alpha|
                                                         (|Expression|
                                                          (|Integer|)))
                                                    (|:| |rami|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))))
                                                #6#)))
                        (LETT |jj|
                              (PROG2 (LETT #7# (SPADCALL |j1| (QREFELT $ 196)))
                                  (QCDR #7#)
                                (|check_union2| (QEQCAR #7# 1)
                                                (|Record|
                                                 (|:| |ope|
                                                      (|LinearOrdinaryDifferentialOperator3|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (|UnivariateTaylorSeries|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7))
                                                       (|UnivariateLaurentSeries|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7))))
                                                 (|:| |dext|
                                                      (|PositiveInteger|))
                                                 (|:| |alpha|
                                                      (|Expression|
                                                       (|Integer|)))
                                                 (|:| |rami|
                                                      (|UnivariatePolynomial|
                                                       (QREFELT $ 6)
                                                       (|Expression|
                                                        (|Integer|)))))
                                                (|Union|
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7)))
                                                 (|Record|
                                                  (|:| |ope|
                                                       (|LinearOrdinaryDifferentialOperator3|
                                                        (|Expression|
                                                         (|Integer|))
                                                        (|UnivariateTaylorSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7))))
                                                  (|:| |dext|
                                                       (|PositiveInteger|))
                                                  (|:| |alpha|
                                                       (|Expression|
                                                        (|Integer|)))
                                                  (|:| |rami|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))))
                                                #7#)))
                        (LETT |kk| (|LODOF2;make_rightfactor| |iarf1| |jj| $))
                        (LETT |t|
                              (|LODOF2;try_factorization| |kk|
                               (- (SPADCALL |f| (QREFELT $ 318)) 1) |bound|
                               (QCAR |s|) |f| 0 0 "" $))
                        (COND
                         ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
                          (PROGN
                           (LETT #1#
                                 (PROG2 (LETT #2# |t|)
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|List|
                                                    (|LinearOrdinaryDifferentialOperator1|
                                                     (|Fraction|
                                                      (|UnivariatePolynomial|
                                                       (QREFELT $ 6)
                                                       (|Expression|
                                                        (|Integer|))))))
                                                   (|Union|
                                                    (|List|
                                                     (|LinearOrdinaryDifferentialOperator1|
                                                      (|Fraction|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))))
                                                    #3#)
                                                   #2#)))
                           (GO #35#))))
                        (LETT |vrs|
                              (PROG2
                                  (LETT #6#
                                        (|LODOF2;factor_op|
                                         (SPADCALL (QVELT (QCAR |s|) 1)
                                                   (QREFELT $ 382))
                                         |factorizer| "all right factors" $))
                                  (QCDR #6#)
                                (|check_union2| (QEQCAR #6# 1)
                                                (|List|
                                                 (|Union|
                                                  (|LinearOrdinaryDifferentialOperator3|
                                                   (|Expression| (|Integer|))
                                                   (|UnivariateTaylorSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7))
                                                   (|UnivariateLaurentSeries|
                                                    (|Expression| (|Integer|))
                                                    (QREFELT $ 6)
                                                    (QREFELT $ 7)))
                                                  (|Record|
                                                   (|:| |ope|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |dext|
                                                        (|PositiveInteger|))
                                                   (|:| |alpha|
                                                        (|Expression|
                                                         (|Integer|)))
                                                   (|:| |rami|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|)))))))
                                                (|Union|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |op|
                                                        (|LinearOrdinaryDifferentialOperator3|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (|UnivariateTaylorSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))
                                                         (|UnivariateLaurentSeries|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (QREFELT $ 6)
                                                          (QREFELT $ 7))))
                                                   (|:| |ram|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))
                                                   (|:| |expart|
                                                        (|UnivariateLaurentSeries|
                                                         (|Expression|
                                                          (|Integer|))
                                                         (QREFELT $ 6)
                                                         (QREFELT $ 7)))))
                                                 (|List|
                                                  (|Union|
                                                   (|LinearOrdinaryDifferentialOperator3|
                                                    (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7))
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     (QREFELT $ 6)
                                                     (QREFELT $ 7)))
                                                   (|Record|
                                                    (|:| |ope|
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))))
                                                    (|:| |dext|
                                                         (|PositiveInteger|))
                                                    (|:| |alpha|
                                                         (|Expression|
                                                          (|Integer|)))
                                                    (|:| |rami|
                                                         (|UnivariatePolynomial|
                                                          (QREFELT $ 6)
                                                          (|Expression|
                                                           (|Integer|))))))))
                                                #6#)))
                        (LETT |r_left| (|spadConstant| $ 18))
                        (SEQ (LETT |l| NIL) (LETT #5# |vrs|) G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |l| (CAR #5#)) NIL)
                                   (NULL
                                    (SPADCALL |r_left| (|spadConstant| $ 18)
                                              (QREFELT $ 220))))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((|LODOF2;same_charclass?|
                                  (PROG2 (LETT #4# |l|)
                                      (QCDR #4#)
                                    (|check_union2| (QEQCAR #4# 0)
                                                    (|LinearOrdinaryDifferentialOperator3|
                                                     (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)))
                                                    (|Union|
                                                     (|LinearOrdinaryDifferentialOperator3|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (|UnivariateTaylorSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7))
                                                      (|UnivariateLaurentSeries|
                                                       (|Expression|
                                                        (|Integer|))
                                                       (QREFELT $ 6)
                                                       (QREFELT $ 7)))
                                                     (|Record|
                                                      (|:| |ope|
                                                           (|LinearOrdinaryDifferentialOperator3|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (|UnivariateTaylorSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))
                                                            (|UnivariateLaurentSeries|
                                                             (|Expression|
                                                              (|Integer|))
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 7))))
                                                      (|:| |dext|
                                                           (|PositiveInteger|))
                                                      (|:| |alpha|
                                                           (|Expression|
                                                            (|Integer|)))
                                                      (|:| |rami|
                                                           (|UnivariatePolynomial|
                                                            (QREFELT $ 6)
                                                            (|Expression|
                                                             (|Integer|))))))
                                                    #4#))
                                  (SPADCALL |kk| (QREFELT $ 382)) |factorizer|
                                  $)
                                 (LETT |r_left|
                                       (PROG2 (LETT #4# |l|)
                                           (QCDR #4#)
                                         (|check_union2| (QEQCAR #4# 0)
                                                         (|LinearOrdinaryDifferentialOperator3|
                                                          (|Expression|
                                                           (|Integer|))
                                                          (|UnivariateTaylorSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7))
                                                          (|UnivariateLaurentSeries|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 7)))
                                                         (|Union|
                                                          (|LinearOrdinaryDifferentialOperator3|
                                                           (|Expression|
                                                            (|Integer|))
                                                           (|UnivariateTaylorSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7))
                                                           (|UnivariateLaurentSeries|
                                                            (|Expression|
                                                             (|Integer|))
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 7)))
                                                          (|Record|
                                                           (|:| |ope|
                                                                (|LinearOrdinaryDifferentialOperator3|
                                                                 (|Expression|
                                                                  (|Integer|))
                                                                 (|UnivariateTaylorSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7))
                                                                 (|UnivariateLaurentSeries|
                                                                  (|Expression|
                                                                   (|Integer|))
                                                                  (QREFELT $ 6)
                                                                  (QREFELT $
                                                                           7))))
                                                           (|:| |dext|
                                                                (|PositiveInteger|))
                                                           (|:| |alpha|
                                                                (|Expression|
                                                                 (|Integer|)))
                                                           (|:| |rami|
                                                                (|UnivariatePolynomial|
                                                                 (QREFELT $ 6)
                                                                 (|Expression|
                                                                  (|Integer|))))))
                                                         #4#)))))))
                             (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                        (LETT |t|
                              (|LODOF2;try_factorization| |r_left|
                               (- (SPADCALL |f| (QREFELT $ 318)) 1) |bound|
                               (QCAR |s|) |f| 0 0 "use adjoint" $))
                        (EXIT
                         (COND
                          ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
                           (PROGN
                            (LETT #1#
                                  (PROG2 (LETT #2# |t|)
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 0)
                                                    (|List|
                                                     (|LinearOrdinaryDifferentialOperator1|
                                                      (|Fraction|
                                                       (|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Expression|
                                                         (|Integer|))))))
                                                    (|Union|
                                                     (|List|
                                                      (|LinearOrdinaryDifferentialOperator1|
                                                       (|Fraction|
                                                        (|UnivariatePolynomial|
                                                         (QREFELT $ 6)
                                                         (|Expression|
                                                          (|Integer|))))))
                                                     #3#)
                                                    #2#)))
                            (GO #35#))))))))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))))
            (SPADCALL (SPADCALL "Try the old factorizer" (QREFELT $ 359))
                      (QREFELT $ 167))
            (EXIT (LIST |f|))))
          #35# (EXIT #1#)))) 

(SDEFUN |LODOF2;testfg;LodoML;51|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         ($
          (|List|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (|LODOF2;factor_global| |f| |factorizer| $)) 

(SDEFUN |LODOF2;factor_minmult1|
        ((|bound| (|List| (|Fraction| (|Integer|))))
         (|sng|
          (|Record|
           (|:| |point| (|Union| (|Expression| (|Integer|)) "infinity"))
           (|:| |lpf|
                (|LinearOrdinaryDifferentialOperator3|
                 (|Expression| (|Integer|))
                 (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                           |cen|)
                 (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                            |cen|)))
           (|:| |dxt| (|PositiveInteger|))))
         (|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|eb| (|Integer|)) (|eba| (|Integer|))
         (|r|
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         ($
          (|List|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))))
        (SPROG
         ((#1=#:G1687 NIL) (#2=#:G1668 NIL)
          (|t|
           (|Union|
            (|List|
             (|LinearOrdinaryDifferentialOperator1|
              (|Fraction|
               (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
            #3="failed"))
          (|r_left|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (#4=#:G793 NIL) (#5=#:G1688 NIL) (|i| NIL)
          (|w|
           (|List|
            (|Union|
             (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|))
             (|Record|
              (|:| |ope|
                   (|LinearOrdinaryDifferentialOperator3|
                    (|Expression| (|Integer|))
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)
                    (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                               |cen|)))
              (|:| |dext| (|PositiveInteger|))
              (|:| |alpha| (|Expression| (|Integer|)))
              (|:| |rami|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (#6=#:G1677 NIL) (|fl| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |fl|
                  (SPADCALL
                   (SPADCALL (SPADCALL |f| (QREFELT $ 318)) 2 (QREFELT $ 49))
                   (QREFELT $ 183)))
            (LETT |t|
                  (|LODOF2;try_factorization| |r| |fl| |bound| |sng| |f| |eb| 0
                   "" $))
            (COND
             ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
              (PROGN
               (LETT #1#
                     (PROG2 (LETT #2# |t|)
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0)
                                       (|List|
                                        (|LinearOrdinaryDifferentialOperator1|
                                         (|Fraction|
                                          (|UnivariatePolynomial| (QREFELT $ 6)
                                                                  (|Expression|
                                                                   (|Integer|))))))
                                       (|Union|
                                        (|List|
                                         (|LinearOrdinaryDifferentialOperator1|
                                          (|Fraction|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))
                                        #3#)
                                       #2#)))
               (GO #7=#:G1686))))
            (LETT |w|
                  (PROG2
                      (LETT #6#
                            (|LODOF2;factor_op|
                             (SPADCALL (QVELT |sng| 1) (QREFELT $ 382))
                             |factorizer| "all right factors" $))
                      (QCDR #6#)
                    (|check_union2| (QEQCAR #6# 1)
                                    (|List|
                                     (|Union|
                                      (|LinearOrdinaryDifferentialOperator3|
                                       (|Expression| (|Integer|))
                                       (|UnivariateTaylorSeries|
                                        (|Expression| (|Integer|))
                                        (QREFELT $ 6) (QREFELT $ 7))
                                       (|UnivariateLaurentSeries|
                                        (|Expression| (|Integer|))
                                        (QREFELT $ 6) (QREFELT $ 7)))
                                      (|Record|
                                       (|:| |ope|
                                            (|LinearOrdinaryDifferentialOperator3|
                                             (|Expression| (|Integer|))
                                             (|UnivariateTaylorSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7))
                                             (|UnivariateLaurentSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7))))
                                       (|:| |dext| (|PositiveInteger|))
                                       (|:| |alpha| (|Expression| (|Integer|)))
                                       (|:| |rami|
                                            (|UnivariatePolynomial|
                                             (QREFELT $ 6)
                                             (|Expression| (|Integer|)))))))
                                    (|Union|
                                     (|List|
                                      (|Record|
                                       (|:| |op|
                                            (|LinearOrdinaryDifferentialOperator3|
                                             (|Expression| (|Integer|))
                                             (|UnivariateTaylorSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7))
                                             (|UnivariateLaurentSeries|
                                              (|Expression| (|Integer|))
                                              (QREFELT $ 6) (QREFELT $ 7))))
                                       (|:| |ram|
                                            (|UnivariatePolynomial|
                                             (QREFELT $ 6)
                                             (|Expression| (|Integer|))))
                                       (|:| |expart|
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7)))))
                                     (|List|
                                      (|Union|
                                       (|LinearOrdinaryDifferentialOperator3|
                                        (|Expression| (|Integer|))
                                        (|UnivariateTaylorSeries|
                                         (|Expression| (|Integer|))
                                         (QREFELT $ 6) (QREFELT $ 7))
                                        (|UnivariateLaurentSeries|
                                         (|Expression| (|Integer|))
                                         (QREFELT $ 6) (QREFELT $ 7)))
                                       (|Record|
                                        (|:| |ope|
                                             (|LinearOrdinaryDifferentialOperator3|
                                              (|Expression| (|Integer|))
                                              (|UnivariateTaylorSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7))
                                              (|UnivariateLaurentSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7))))
                                        (|:| |dext| (|PositiveInteger|))
                                        (|:| |alpha|
                                             (|Expression| (|Integer|)))
                                        (|:| |rami|
                                             (|UnivariatePolynomial|
                                              (QREFELT $ 6)
                                              (|Expression| (|Integer|))))))))
                                    #6#)))
            (LETT |r_left| (|spadConstant| $ 18))
            (SEQ (LETT |i| NIL) (LETT #5# |w|) G190
                 (COND
                  ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL)
                       (NULL
                        (SPADCALL |r_left| (|spadConstant| $ 18)
                                  (QREFELT $ 220))))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((|LODOF2;same_charclass?|
                      (PROG2 (LETT #4# |i|)
                          (QCDR #4#)
                        (|check_union2| (QEQCAR #4# 0)
                                        (|LinearOrdinaryDifferentialOperator3|
                                         (|Expression| (|Integer|))
                                         (|UnivariateTaylorSeries|
                                          (|Expression| (|Integer|))
                                          (QREFELT $ 6) (QREFELT $ 7))
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|))
                                          (QREFELT $ 6) (QREFELT $ 7)))
                                        (|Union|
                                         (|LinearOrdinaryDifferentialOperator3|
                                          (|Expression| (|Integer|))
                                          (|UnivariateTaylorSeries|
                                           (|Expression| (|Integer|))
                                           (QREFELT $ 6) (QREFELT $ 7))
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|))
                                           (QREFELT $ 6) (QREFELT $ 7)))
                                         (|Record|
                                          (|:| |ope|
                                               (|LinearOrdinaryDifferentialOperator3|
                                                (|Expression| (|Integer|))
                                                (|UnivariateTaylorSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6) (QREFELT $ 7))
                                                (|UnivariateLaurentSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6) (QREFELT $ 7))))
                                          (|:| |dext| (|PositiveInteger|))
                                          (|:| |alpha|
                                               (|Expression| (|Integer|)))
                                          (|:| |rami|
                                               (|UnivariatePolynomial|
                                                (QREFELT $ 6)
                                                (|Expression| (|Integer|))))))
                                        #4#))
                      (SPADCALL |r| (QREFELT $ 382)) |factorizer| $)
                     (LETT |r_left|
                           (PROG2 (LETT #4# |i|)
                               (QCDR #4#)
                             (|check_union2| (QEQCAR #4# 0)
                                             (|LinearOrdinaryDifferentialOperator3|
                                              (|Expression| (|Integer|))
                                              (|UnivariateTaylorSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7))
                                              (|UnivariateLaurentSeries|
                                               (|Expression| (|Integer|))
                                               (QREFELT $ 6) (QREFELT $ 7)))
                                             (|Union|
                                              (|LinearOrdinaryDifferentialOperator3|
                                               (|Expression| (|Integer|))
                                               (|UnivariateTaylorSeries|
                                                (|Expression| (|Integer|))
                                                (QREFELT $ 6) (QREFELT $ 7))
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|))
                                                (QREFELT $ 6) (QREFELT $ 7)))
                                              (|Record|
                                               (|:| |ope|
                                                    (|LinearOrdinaryDifferentialOperator3|
                                                     (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7))))
                                               (|:| |dext| (|PositiveInteger|))
                                               (|:| |alpha|
                                                    (|Expression| (|Integer|)))
                                               (|:| |rami|
                                                    (|UnivariatePolynomial|
                                                     (QREFELT $ 6)
                                                     (|Expression|
                                                      (|Integer|))))))
                                             #4#)))))))
                 (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL |r_left| (|spadConstant| $ 18) (QREFELT $ 220))
              (|error| "bug")))
            (LETT |t|
                  (|LODOF2;try_factorization| |r_left| |fl| |bound| |sng| |f|
                   |eba| 0 "use adjoint" $))
            (COND
             ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
              (PROGN
               (LETT #1#
                     (PROG2 (LETT #2# |t|)
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0)
                                       (|List|
                                        (|LinearOrdinaryDifferentialOperator1|
                                         (|Fraction|
                                          (|UnivariatePolynomial| (QREFELT $ 6)
                                                                  (|Expression|
                                                                   (|Integer|))))))
                                       (|Union|
                                        (|List|
                                         (|LinearOrdinaryDifferentialOperator1|
                                          (|Fraction|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))
                                        #3#)
                                       #2#)))
               (GO #7#))))
            (LETT |t|
                  (|LODOF2;try_factorization| |r|
                   (- (SPADCALL |f| (QREFELT $ 318)) 1) |bound| |sng| |f| |eb|
                   (+ |fl| 1) "" $))
            (COND
             ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
              (PROGN
               (LETT #1#
                     (PROG2 (LETT #2# |t|)
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0)
                                       (|List|
                                        (|LinearOrdinaryDifferentialOperator1|
                                         (|Fraction|
                                          (|UnivariatePolynomial| (QREFELT $ 6)
                                                                  (|Expression|
                                                                   (|Integer|))))))
                                       (|Union|
                                        (|List|
                                         (|LinearOrdinaryDifferentialOperator1|
                                          (|Fraction|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))
                                        #3#)
                                       #2#)))
               (GO #7#))))
            (LETT |t|
                  (|LODOF2;try_factorization| |r_left|
                   (- (SPADCALL |f| (QREFELT $ 318)) 1) |bound| |sng| |f| |eba|
                   (+ |fl| 1) "use adjoint" $))
            (COND
             ((SPADCALL |t| (CONS 1 "failed") (QREFELT $ 381))
              (PROGN
               (LETT #1#
                     (PROG2 (LETT #2# |t|)
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0)
                                       (|List|
                                        (|LinearOrdinaryDifferentialOperator1|
                                         (|Fraction|
                                          (|UnivariatePolynomial| (QREFELT $ 6)
                                                                  (|Expression|
                                                                   (|Integer|))))))
                                       (|Union|
                                        (|List|
                                         (|LinearOrdinaryDifferentialOperator1|
                                          (|Fraction|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))
                                        #3#)
                                       #2#)))
               (GO #7#))))
            (EXIT (LIST |f|))))
          #7# (EXIT #1#)))) 

(SDEFUN |LODOF2;l_p|
        ((|f|
          #1=(|LinearOrdinaryDifferentialOperator1|
              (|Fraction|
               (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|p| (|Union| (|Expression| (|Integer|)) #2="infinity"))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (SPROG
         ((|llr|
           (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   |var| |cen|)))
          (|ftmp| #1#)
          (|lpf|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|newd|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction|
             (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
          (|slc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|lcd|
           #3=(|Fraction|
               (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|lcn| #3#)
          (|newx|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (#4=#:G1690 NIL) (|dg| (|NonNegativeInteger|))
          (|lc|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (SEQ (LETT |lpf| (|spadConstant| $ 308))
              (COND
               ((SPADCALL |p| (CONS 0 (|spadConstant| $ 19)) (QREFELT $ 310))
                (LETT |lpf| |f|))
               ('T
                (SEQ (LETT |ftmp| |f|)
                     (EXIT
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL |ftmp| (|spadConstant| $ 308)
                                        (QREFELT $ 316)))
                             (GO G191)))
                           (SEQ (LETT |lc| (SPADCALL |ftmp| (QREFELT $ 317)))
                                (LETT |dg| (SPADCALL |ftmp| (QREFELT $ 318)))
                                (COND
                                 ((SPADCALL |p| (CONS 1 "infinity")
                                            (QREFELT $ 310))
                                  (LETT |newx|
                                        (SPADCALL (|spadConstant| $ 150)
                                                  (SPADCALL
                                                   (|spadConstant| $ 12) 1
                                                   (QREFELT $ 55))
                                                  (QREFELT $ 311))))
                                 ('T
                                  (LETT |newx|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL (|spadConstant| $ 12) 1
                                                    (QREFELT $ 55))
                                          (SPADCALL
                                           (PROG2 (LETT #4# |p|)
                                               (QCDR #4#)
                                             (|check_union2| (QEQCAR #4# 0)
                                                             (|Expression|
                                                              (|Integer|))
                                                             (|Union|
                                                              (|Expression|
                                                               (|Integer|))
                                                              #2#)
                                                             #4#))
                                           (QREFELT $ 225))
                                          (QREFELT $ 56))
                                         (QREFELT $ 230)))))
                                (LETT |lcn|
                                      (|LODOF2;subsup|
                                       (SPADCALL |lc| (QREFELT $ 29)) |newx|
                                       $))
                                (LETT |lcd|
                                      (|LODOF2;subsup|
                                       (SPADCALL |lc| (QREFELT $ 27)) |newx|
                                       $))
                                (LETT |slc|
                                      (SPADCALL |lcn| |lcd| (QREFELT $ 303)))
                                (COND
                                 ((SPADCALL |p| (CONS 1 "infinity")
                                            (QREFELT $ 310))
                                  (LETT |newd|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL (|spadConstant| $ 12) 1
                                                      (QREFELT $ 55))
                                            2 (QREFELT $ 67))
                                           (QREFELT $ 230))
                                          (SPADCALL (QREFELT $ 313))
                                          (QREFELT $ 314))
                                         (QREFELT $ 315))))
                                 ('T (LETT |newd| (SPADCALL (QREFELT $ 313)))))
                                (LETT |lpf|
                                      (SPADCALL |lpf|
                                                (SPADCALL |slc|
                                                          (SPADCALL |newd| |dg|
                                                                    (QREFELT $
                                                                             319))
                                                          (QREFELT $ 314))
                                                (QREFELT $ 320)))
                                (EXIT
                                 (LETT |ftmp|
                                       (SPADCALL |ftmp| (QREFELT $ 321)))))
                           NIL (GO G190) G191 (EXIT NIL))))))
              (LETT |llr|
                    (|LODOF2;convertL3toLL| (SPADCALL |lpf| (QREFELT $ 384))
                     $))
              (EXIT
               (SPADCALL
                (SPADCALL (|spadConstant| $ 14) (SPADCALL |llr| (QREFELT $ 37))
                          (QREFELT $ 250))
                |llr| (QREFELT $ 157)))))) 

(SDEFUN |LODOF2;testlp;LodoULodo;54|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|p| (|Union| (|Expression| (|Integer|)) "infinity"))
         ($
          (|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |var| |cen|))))
        (|LODOF2;l_p| |f| |p| $)) 

(SDEFUN |LODOF2;subsup|
        ((|np| #1=(|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
         (|newx|
          (|Fraction|
           (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
         ($
          (|Fraction|
           (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
        (SPROG
         ((|nptmp| #1#)
          (|res|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (|dg| (|NonNegativeInteger|)) (|lc| (|Expression| (|Integer|))))
         (SEQ (LETT |res| (|spadConstant| $ 386)) (LETT |nptmp| |np|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |nptmp| (|spadConstant| $ 50) (QREFELT $ 151)))
                     (GO G191)))
                   (SEQ (LETT |lc| (SPADCALL |nptmp| (QREFELT $ 188)))
                        (LETT |dg| (SPADCALL |nptmp| (QREFELT $ 72)))
                        (LETT |res|
                              (SPADCALL |res|
                                        (SPADCALL
                                         (SPADCALL |lc| (QREFELT $ 225))
                                         (SPADCALL |newx| |dg| (QREFELT $ 387))
                                         (QREFELT $ 388))
                                        (QREFELT $ 389)))
                        (EXIT
                         (LETT |nptmp| (SPADCALL |nptmp| (QREFELT $ 190)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;get_trace|
        ((|f| (|Expression| (|Integer|)))
         (|k| (|Kernel| (|Expression| (|Integer|))))
         ($ (|Expression| (|Integer|))))
        (SPROG
         ((|fa| (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
          (|Sae|
           (|Join|
            (|MonogenicAlgebra| #1=(|Expression| (|Integer|))
                                (|UnivariatePolynomial| |var|
                                                        (|Expression|
                                                         (|Integer|))))
            (CATEGORY |package|
             (IF (|has| #1# (|Field|))
                 (IF (|has| #1# (|PolynomialFactorizationExplicit|))
                     (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                     |noBranch|)
                 |noBranch|))))
          (|min_pol|
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (SEQ (LETT |min_pol| (SPADCALL |k| (QREFELT $ 391)))
              (LETT |Sae|
                    (|SimpleAlgebraicExtension| (|Expression| (|Integer|))
                                                (|UnivariatePolynomial|
                                                 (QREFELT $ 6)
                                                 (|Expression| (|Integer|)))
                                                (SPADCALL |min_pol|
                                                          (QREFELT $ 97))))
              (LETT |fa| (SPADCALL |f| |k| |min_pol| (QREFELT $ 394)))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |fa| (QREFELT $ 97))
                          (|compiledLookupCheck| '|reduce|
                                                 (LIST '$
                                                       (LIST
                                                        '|UnivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (LIST '|Expression|
                                                              (LIST
                                                               '|Integer|))))
                                                 |Sae|))
                (|compiledLookupCheck| '|trace|
                                       (LIST
                                        (LIST '|Expression| (LIST '|Integer|))
                                        '$)
                                       |Sae|)))))) 

(SDEFUN |LODOF2;testgt;EKE;57|
        ((|f| (|Expression| (|Integer|)))
         (|k| (|Kernel| (|Expression| (|Integer|))))
         ($ (|Expression| (|Integer|))))
        (|LODOF2;get_trace| |f| |k| $)) 

(SDEFUN |LODOF2;make_poly|
        ((|f|
          #1=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                    (|UnivariateTaylorSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)
                                                    (|UnivariateLaurentSeries|
                                                     (|Expression| (|Integer|))
                                                     |var| |cen|)))
         ($ (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
        (SPROG
         ((|ftmp| #1#)
          (|res| (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
          (|dg| (|NonNegativeInteger|))
          (|lc|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|)))
         (SEQ (LETT |res| (|spadConstant| $ 396)) (LETT |ftmp| |f|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |ftmp| (|spadConstant| $ 18) (QREFELT $ 40)))
                     (GO G191)))
                   (SEQ (LETT |lc| (SPADCALL |ftmp| (QREFELT $ 37)))
                        (LETT |dg| (SPADCALL |ftmp| (QREFELT $ 41)))
                        (LETT |res|
                              (SPADCALL |res|
                                        (SPADCALL
                                         (SPADCALL |lc| 0 (QREFELT $ 54)) |dg|
                                         (QREFELT $ 397))
                                        (QREFELT $ 398)))
                        (EXIT (LETT |ftmp| (SPADCALL |ftmp| (QREFELT $ 44)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LODOF2;compute_bound|
        ((|gem|
          (|List|
           (|Record|
            (|:| |singularity|
                 (|Record|
                  (|:| |point| (|Union| (|Expression| (|Integer|)) "infinity"))
                  (|:| |lpf|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))
                  (|:| |dxt| (|PositiveInteger|))))
            (|:| |fos|
                 (|List|
                  (|Record|
                   (|:| |op|
                        (|LinearOrdinaryDifferentialOperator3|
                         (|Expression| (|Integer|))
                         (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))
                   (|:| |ram|
                        (|UnivariatePolynomial| |var|
                                                (|Expression| (|Integer|))))
                   (|:| |expart|
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))))
            (|:| |mge|
                 (|List|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|))))))
         (|rlc| (|Expression| (|Integer|))) ($ (|Integer|)))
        (SPROG
         ((|res| (|Fraction| (|Integer|))) (#1=#:G1721 NIL) (#2=#:G1747 NIL)
          (|ma| (|Union| (|Fraction| (|Integer|)) #3="-infinity"))
          (|cq| (|Fraction| (|Integer|))) (|c| (|Expression| (|Integer|)))
          (#4=#:G1754 NIL) (|ke| NIL)
          (|ks| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|vpej| #5=(|Fraction| (|Integer|))) (|vpei| #5#)
          (|rjj| #6=(|NonNegativeInteger|)) (#7=#:G1752 NIL) (|jj| NIL)
          (#8=#:G1753 NIL) (|fpsjj| NIL) (|r| #6#) (#9=#:G1749 NIL) (|f| NIL)
          (#10=#:G1750 NIL) (|fps| NIL) (#11=#:G1751 NIL) (|ji| NIL)
          (#12=#:G1748 NIL) (|ge| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |res| (|spadConstant| $ 65))
                (SEQ (LETT |ge| NIL) (LETT #12# |gem|) G190
                     (COND
                      ((OR (ATOM #12#) (PROGN (LETT |ge| (CAR #12#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |ma| (CONS 1 "-infinity"))
                          (SEQ (LETT |ji| 1)
                               (LETT #11# (LENGTH (QVELT |ge| 2)))
                               (LETT |fps| NIL) (LETT #10# (QVELT |ge| 1))
                               (LETT |f| NIL) (LETT #9# (QVELT |ge| 2)) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |f| (CAR #9#)) NIL)
                                     (ATOM #10#)
                                     (PROGN (LETT |fps| (CAR #10#)) NIL)
                                     (|greater_SI| |ji| #11#))
                                 (GO G191)))
                               (SEQ
                                (LETT |r|
                                      (SPADCALL (QVELT |fps| 1)
                                                (QREFELT $ 72)))
                                (LETT |c| (SPADCALL |f| 0 (QREFELT $ 54)))
                                (SEQ (LETT |fpsjj| NIL)
                                     (LETT #8#
                                           (SPADCALL (QVELT |ge| 1) |ji|
                                                     (QREFELT $ 400)))
                                     (LETT |jj| NIL)
                                     (LETT #7#
                                           (SPADCALL (QVELT |ge| 2) |ji|
                                                     (QREFELT $ 399)))
                                     G190
                                     (COND
                                      ((OR (ATOM #7#)
                                           (PROGN (LETT |jj| (CAR #7#)) NIL)
                                           (ATOM #8#)
                                           (PROGN
                                            (LETT |fpsjj| (CAR #8#))
                                            NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |rjj|
                                            (SPADCALL (QVELT |fpsjj| 1)
                                                      (QREFELT $ 72)))
                                      (LETT |vpei|
                                            (SPADCALL
                                             (SPADCALL |f| 0 (QREFELT $ 42))
                                             |r| (QREFELT $ 49)))
                                      (LETT |vpej|
                                            (SPADCALL
                                             (SPADCALL |jj| 0 (QREFELT $ 42))
                                             |rjj| (QREFELT $ 49)))
                                      (EXIT
                                       (LETT |c|
                                             (SPADCALL |c|
                                                       (SPADCALL
                                                        (SPADCALL |vpei| |vpej|
                                                                  (QREFELT $
                                                                           105))
                                                        (QREFELT $ 240))
                                                       (QREFELT $ 401)))))
                                     (LETT #7#
                                           (PROG1 (CDR #7#)
                                             (LETT #8# (CDR #8#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |ks| (SPADCALL |c| (QREFELT $ 403)))
                                (SEQ (LETT |ke| NIL) (LETT #4# |ks|) G190
                                     (COND
                                      ((OR (ATOM #4#)
                                           (PROGN (LETT |ke| (CAR #4#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((QEQCAR
                                          (SPADCALL
                                           (SPADCALL |ke| (QREFELT $ 404))
                                           (QREFELT $ 406))
                                          1)
                                         (SEQ
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL
                                              (SPADCALL |c| (QREFELT $ 407))
                                              |ke| |rlc| (QREFELT $ 408))
                                             (|spadConstant| $ 19)
                                             (QREFELT $ 235))
                                            (PROGN
                                             (LETT #2#
                                                   (|LODOF2;compute_bound|
                                                    |gem|
                                                    (SPADCALL |rlc|
                                                              (|spadConstant| $
                                                                              12)
                                                              (QREFELT $ 401))
                                                    $))
                                             (GO #13=#:G1746))))
                                          (EXIT
                                           (LETT |c|
                                                 (SPADCALL |c| |ke| |rlc|
                                                           (QREFELT $ 408))))))
                                        ('T
                                         (LETT |c|
                                               (SPADCALL
                                                (|LODOF2;get_trace| |c| |ke| $)
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |ke|
                                                            (QREFELT $ 391))
                                                  (QREFELT $ 409))
                                                 (QREFELT $ 75))
                                                (QREFELT $ 76)))))))
                                     (LETT #4# (CDR #4#)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |cq| (SPADCALL |c| (QREFELT $ 410)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |ma| (CONS 1 "-infinity")
                                             (QREFELT $ 412))
                                   (LETT |ma|
                                         (CONS 0
                                               (SPADCALL |cq|
                                                         (QREFELT $ 367)))))
                                  ('T
                                   (LETT |ma|
                                         (CONS 0
                                               (SPADCALL
                                                (SPADCALL |cq| (QREFELT $ 367))
                                                (PROG2 (LETT #1# |ma|)
                                                    (QCDR #1#)
                                                  (|check_union2|
                                                   (QEQCAR #1# 0)
                                                   (|Fraction| (|Integer|))
                                                   (|Union|
                                                    (|Fraction| (|Integer|))
                                                    #3#)
                                                   #1#))
                                                (QREFELT $ 413))))))))
                               (LETT #9#
                                     (PROG1 (CDR #9#)
                                       (LETT #10#
                                             (PROG1 (CDR #10#)
                                               (LETT |ji| (|inc_SI| |ji|))))))
                               (GO G190) G191 (EXIT NIL))
                          (COND
                           ((SPADCALL |ma| (CONS 1 "-infinity")
                                      (QREFELT $ 412))
                            (PROGN (LETT #2# 0) (GO #13#))))
                          (EXIT
                           (LETT |res|
                                 (SPADCALL |res|
                                           (SPADCALL (QVELT (QVELT |ge| 0) 2)
                                                     (PROG2 (LETT #1# |ma|)
                                                         (QCDR #1#)
                                                       (|check_union2|
                                                        (QEQCAR #1# 0)
                                                        (|Fraction|
                                                         (|Integer|))
                                                        (|Union|
                                                         (|Fraction|
                                                          (|Integer|))
                                                         #3#)
                                                        #1#))
                                                     (QREFELT $ 365))
                                           (QREFELT $ 104)))))
                     (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
                (EXIT (MAX 0 (SPADCALL |res| (QREFELT $ 183))))))
          #13# (EXIT #2#)))) 

(SDEFUN |LODOF2;gen_exp;LodoUMLL;60|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|p| (|Union| (|Expression| (|Integer|)) #1="infinity"))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))
           (|List| (|Expression| (|Integer|)))))
         (|y| (|List| (|Expression| (|Integer|))))
         ($
          (|List|
           (|Record|
            (|:| |ecs|
                 (|List|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))
            (|:| |ecr|
                 (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
            (|:| |ect|
                 (|Fraction|
                  (|UnivariatePolynomial| |var|
                                          (|Expression| (|Integer|)))))))))
        (SPROG
         ((|res|
           (|List|
            (|Record|
             (|:| |ecs|
                  (|List|
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|)))
             (|:| |ecr|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |ect|
                  (|Fraction|
                   (|UnivariatePolynomial| |var|
                                           (|Expression| (|Integer|))))))))
          (|tr|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (#2=#:G1757 NIL)
          (|ss|
           (|List|
            (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                       |cen|)))
          (#3=#:G1782 NIL) (|root| NIL) (#4=#:G1781 NIL)
          (|es| (|List| (|Expression| (|Integer|)))) (#5=#:G1780 NIL) (|g| NIL)
          (#6=#:G1779 NIL)
          (|s|
           #7=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)))
          (|r| (|NonNegativeInteger|)) (#8=#:G1778 NIL) (|e| NIL)
          (|v|
           (|List|
            (|Record| (|:| |op| #7#)
                      (|:| |ram|
                           (|UnivariatePolynomial| |var|
                                                   (|Expression| (|Integer|))))
                      (|:| |expart|
                           (|UnivariateLaurentSeries|
                            (|Expression| (|Integer|)) |var| |cen|)))))
          (#9=#:G1765 NIL)
          (|factorizer2|
           (|Mapping|
            (|Factored|
             (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))))
         (SEQ
          (LETT |factorizer2|
                (CONS #'|LODOF2;gen_exp;LodoUMLL;60!0|
                      (VECTOR |factorizer| |y|)))
          (LETT |v|
                (PROG2
                    (LETT #9#
                          (|LODOF2;factor_op| (|LODOF2;l_p| |f| |p| $)
                           |factorizer2| "semireg" $))
                    (QCDR #9#)
                  (|check_union2| (QEQCAR #9# 0)
                                  (|List|
                                   (|Record|
                                    (|:| |op|
                                         (|LinearOrdinaryDifferentialOperator3|
                                          (|Expression| (|Integer|))
                                          (|UnivariateTaylorSeries|
                                           (|Expression| (|Integer|))
                                           (QREFELT $ 6) (QREFELT $ 7))
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|))
                                           (QREFELT $ 6) (QREFELT $ 7))))
                                    (|:| |ram|
                                         (|UnivariatePolynomial| (QREFELT $ 6)
                                                                 (|Expression|
                                                                  (|Integer|))))
                                    (|:| |expart|
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|))
                                          (QREFELT $ 6) (QREFELT $ 7)))))
                                  (|Union|
                                   (|List|
                                    (|Record|
                                     (|:| |op|
                                          (|LinearOrdinaryDifferentialOperator3|
                                           (|Expression| (|Integer|))
                                           (|UnivariateTaylorSeries|
                                            (|Expression| (|Integer|))
                                            (QREFELT $ 6) (QREFELT $ 7))
                                           (|UnivariateLaurentSeries|
                                            (|Expression| (|Integer|))
                                            (QREFELT $ 6) (QREFELT $ 7))))
                                     (|:| |ram|
                                          (|UnivariatePolynomial| (QREFELT $ 6)
                                                                  (|Expression|
                                                                   (|Integer|))))
                                     (|:| |expart|
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|))
                                           (QREFELT $ 6) (QREFELT $ 7)))))
                                   (|List|
                                    (|Union|
                                     (|LinearOrdinaryDifferentialOperator3|
                                      (|Expression| (|Integer|))
                                      (|UnivariateTaylorSeries|
                                       (|Expression| (|Integer|)) (QREFELT $ 6)
                                       (QREFELT $ 7))
                                      (|UnivariateLaurentSeries|
                                       (|Expression| (|Integer|)) (QREFELT $ 6)
                                       (QREFELT $ 7)))
                                     (|Record|
                                      (|:| |ope|
                                           (|LinearOrdinaryDifferentialOperator3|
                                            (|Expression| (|Integer|))
                                            (|UnivariateTaylorSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))))
                                      (|:| |dext| (|PositiveInteger|))
                                      (|:| |alpha| (|Expression| (|Integer|)))
                                      (|:| |rami|
                                           (|UnivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Expression| (|Integer|))))))))
                                  #9#)))
          (LETT |res| NIL)
          (SEQ (LETT |e| NIL) (LETT #8# |v|) G190
               (COND
                ((OR (ATOM #8#) (PROGN (LETT |e| (CAR #8#)) NIL)) (GO G191)))
               (SEQ (LETT |r| (SPADCALL (QVELT |e| 1) (QREFELT $ 72)))
                    (LETT |s| (QVELT |e| 0))
                    (LETT |es|
                          (PROGN
                           (LETT #6# NIL)
                           (SEQ (LETT |g| NIL)
                                (LETT #5#
                                      (SPADCALL
                                       (SPADCALL (|LODOF2;make_poly| |s| $)
                                                 |factorizer2|)
                                       (QREFELT $ 416)))
                                G190
                                (COND
                                 ((OR (ATOM #5#)
                                      (PROGN (LETT |g| (CAR #5#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #6#
                                        (CONS
                                         (SPADCALL (QVELT |g| 1)
                                                   (QREFELT $ 417))
                                         #6#))))
                                (LETT #5# (CDR #5#)) (GO G190) G191
                                (EXIT (NREVERSE #6#)))))
                    (LETT |ss|
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |root| NIL) (LETT #3# |es|) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |root| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #4#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |root| (QREFELT $ 189))
                                           (QVELT |e| 2) (QREFELT $ 216))
                                          (SPADCALL |r| (QREFELT $ 75))
                                          (QREFELT $ 249))
                                         #4#))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT (NREVERSE #4#)))))
                    (COND
                     ((SPADCALL |p| (CONS 1 "infinity") (QREFELT $ 310))
                      (LETT |tr|
                            (SPADCALL (|spadConstant| $ 150)
                                      (SPADCALL (|spadConstant| $ 12) 1
                                                (QREFELT $ 55))
                                      (QREFELT $ 311))))
                     ('T
                      (LETT |tr|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 55))
                              (SPADCALL
                               (PROG2 (LETT #2# |p|)
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0)
                                                 (|Expression| (|Integer|))
                                                 (|Union|
                                                  (|Expression| (|Integer|))
                                                  #1#)
                                                 #2#))
                               (QREFELT $ 225))
                              (QREFELT $ 83))
                             (QREFELT $ 230)))))
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (LIST (VECTOR |ss| (QVELT |e| 1) |tr|))
                                     (QREFELT $ 420)))))
               (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |LODOF2;gen_exp;LodoUMLL;60!0| ((|x| NIL) ($$ NIL))
        (PROG (|y| |factorizer|)
          (LETT |y| (QREFELT $$ 1))
          (LETT |factorizer| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |y| |factorizer|))))) 

(SDEFUN |LODOF2;ge_minimal;LodoMSL;61|
        ((|f|
          (|LinearOrdinaryDifferentialOperator1|
           (|Fraction|
            (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))))
         (|factorizer|
          (|Mapping|
           (|Factored|
            (|SparseUnivariatePolynomial| (|Expression| (|Integer|))))
           (|SparseUnivariatePolynomial| (|Expression| (|Integer|)))))
         (|option| (|String|))
         ($
          (|List|
           (|Record|
            (|:| |singularity|
                 (|Record|
                  (|:| |point|
                       (|Union| (|Expression| (|Integer|)) #1="infinity"))
                  (|:| |lpf|
                       (|LinearOrdinaryDifferentialOperator3|
                        (|Expression| (|Integer|))
                        (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                  |var| |cen|)
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))
                  (|:| |dxt| (|PositiveInteger|))))
            (|:| |fos|
                 (|List|
                  (|Record|
                   (|:| |op|
                        (|LinearOrdinaryDifferentialOperator3|
                         (|Expression| (|Integer|))
                         (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))
                   (|:| |ram|
                        (|UnivariatePolynomial| |var|
                                                (|Expression| (|Integer|))))
                   (|:| |expart|
                        (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)))))
            (|:| |mge|
                 (|List|
                  (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                             |cen|)))))))
        (SPROG
         ((|res|
           (|List|
            (|Record|
             (|:| |singularity|
                  (|Record|
                   (|:| |point| (|Union| (|Expression| (|Integer|)) #1#))
                   (|:| |lpf|
                        (|LinearOrdinaryDifferentialOperator3|
                         (|Expression| (|Integer|))
                         (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                   |var| |cen|)
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))
                   (|:| |dxt| (|PositiveInteger|))))
             (|:| |fos|
                  (|List|
                   (|Record|
                    (|:| |op|
                         (|LinearOrdinaryDifferentialOperator3|
                          (|Expression| (|Integer|))
                          (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)
                          (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                     |var| |cen|)))
                    (|:| |ram|
                         (|UnivariatePolynomial| |var|
                                                 (|Expression| (|Integer|))))
                    (|:| |expart|
                         (|UnivariateLaurentSeries| (|Expression| (|Integer|))
                                                    |var| |cen|)))))
             (|:| |mge|
                  (|List|
                   (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                              |cen|))))))
          (|mg|
           (|List|
            (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var|
                                       |cen|)))
          (|ss|
           (|UnivariateLaurentSeries| (|Expression| (|Integer|)) |var| |cen|))
          (|ms| (|Expression| (|Integer|)))
          (|es| (|List| (|Fraction| (|Integer|)))) (#2=#:G1849 NIL) (|g| NIL)
          (#3=#:G1848 NIL)
          (|s|
           #4=(|LinearOrdinaryDifferentialOperator3| (|Expression| (|Integer|))
                                                     (|UnivariateTaylorSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)
                                                     (|UnivariateLaurentSeries|
                                                      (|Expression|
                                                       (|Integer|))
                                                      |var| |cen|)))
          (|r| (|NonNegativeInteger|)) (#5=#:G1847 NIL) (|e| NIL)
          (|v|
           (|List|
            (|Record| (|:| |op| #4#)
                      (|:| |ram|
                           (|UnivariatePolynomial| |var|
                                                   (|Expression| (|Integer|))))
                      (|:| |expart|
                           (|UnivariateLaurentSeries|
                            (|Expression| (|Integer|)) |var| |cen|)))))
          (#6=#:G1806 NIL) (#7=#:G1846 NIL) (|sg| NIL)
          (|singularities|
           (|List|
            (|Record| (|:| |point| (|Union| (|Expression| (|Integer|)) #1#))
                      (|:| |lpf|
                           (|LinearOrdinaryDifferentialOperator3|
                            (|Expression| (|Integer|))
                            (|UnivariateTaylorSeries|
                             (|Expression| (|Integer|)) |var| |cen|)
                            (|UnivariateLaurentSeries|
                             (|Expression| (|Integer|)) |var| |cen|)))
                      (|:| |dxt| (|PositiveInteger|)))))
          (#8=#:G1845 NIL) (#9=#:G1844 NIL) (|root| (|Expression| (|Integer|)))
          (#10=#:G1843 NIL)
          (|dnf|
           (|List|
            (|Record|
             (|:| |factor|
                  (|UnivariatePolynomial| |var| (|Expression| (|Integer|))))
             (|:| |exponent| (|NonNegativeInteger|)))))
          (#11=#:G1842 NIL) (|p| NIL)
          (|dlc|
           (|List| (|UnivariatePolynomial| |var| (|Expression| (|Integer|)))))
          (#12=#:G1841 NIL) (#13=#:G1840 NIL))
         (SEQ
          (LETT |dlc|
                (PROGN
                 (LETT #13# NIL)
                 (SEQ (LETT |e| (SPADCALL |f| (QREFELT $ 355)))
                      (LETT #12# (SPADCALL |f| (QREFELT $ 318))) G190
                      (COND ((> |e| #12#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #13#
                              (CONS
                               (SPADCALL (SPADCALL |f| |e| (QREFELT $ 353))
                                         (QREFELT $ 27))
                               #13#))))
                      (LETT |e| (+ |e| 1)) (GO G190) G191
                      (EXIT (NREVERSE #13#)))))
          (LETT |dlc| (SPADCALL |dlc| (QREFELT $ 424))) (LETT |dnf| NIL)
          (SEQ (LETT |p| NIL) (LETT #11# |dlc|) G190
               (COND
                ((OR (ATOM #11#) (PROGN (LETT |p| (CAR #11#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (LETT |dnf|
                       (SPADCALL |dnf|
                                 (SPADCALL
                                  (|LODOF2;factorUP| |p| |factorizer| $)
                                  (QREFELT $ 64))
                                 (QREFELT $ 425)))))
               (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
          (COND
           ((|LODOF2;inf_singularity?| |f| $)
            (LETT |singularities|
                  (LIST
                   (VECTOR (CONS 1 "infinity")
                           (|LODOF2;l_p| |f| (CONS 1 "infinity") $) 1))))
           ('T (LETT |singularities| NIL)))
          (SEQ (LETT |g| NIL) (LETT #10# |dnf|) G190
               (COND
                ((OR (ATOM #10#) (PROGN (LETT |g| (CAR #10#)) NIL)) (GO G191)))
               (SEQ
                (LETT |root|
                      (SPADCALL (SPADCALL (QCAR |g|) (QREFELT $ 96))
                                (QREFELT $ 417)))
                (EXIT
                 (LETT |singularities|
                       (CONS
                        (VECTOR (CONS 0 |root|)
                                (|LODOF2;l_p| |f| (CONS 0 |root|) $)
                                (SPADCALL (QCAR |g|) (QREFELT $ 72)))
                        |singularities|))))
               (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
          (COND
           ((EQUAL |option| "use adjoint")
            (LETT |singularities|
                  (PROGN
                   (LETT #9# NIL)
                   (SEQ (LETT |sg| NIL) (LETT #8# |singularities|) G190
                        (COND
                         ((OR (ATOM #8#) (PROGN (LETT |sg| (CAR #8#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #9#
                                (CONS
                                 (VECTOR (QVELT |sg| 0)
                                         (SPADCALL (QVELT |sg| 1)
                                                   (QREFELT $ 382))
                                         (QVELT |sg| 2))
                                 #9#))))
                        (LETT #8# (CDR #8#)) (GO G190) G191
                        (EXIT (NREVERSE #9#)))))))
          (LETT |res| NIL)
          (SEQ (LETT |sg| NIL) (LETT #7# |singularities|) G190
               (COND
                ((OR (ATOM #7#) (PROGN (LETT |sg| (CAR #7#)) NIL)) (GO G191)))
               (SEQ
                (LETT |v|
                      (PROG2
                          (LETT #6#
                                (|LODOF2;factor_op| (QVELT |sg| 1) |factorizer|
                                 "semireg" $))
                          (QCDR #6#)
                        (|check_union2| (QEQCAR #6# 0)
                                        (|List|
                                         (|Record|
                                          (|:| |op|
                                               (|LinearOrdinaryDifferentialOperator3|
                                                (|Expression| (|Integer|))
                                                (|UnivariateTaylorSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6) (QREFELT $ 7))
                                                (|UnivariateLaurentSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6) (QREFELT $ 7))))
                                          (|:| |ram|
                                               (|UnivariatePolynomial|
                                                (QREFELT $ 6)
                                                (|Expression| (|Integer|))))
                                          (|:| |expart|
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|))
                                                (QREFELT $ 6) (QREFELT $ 7)))))
                                        (|Union|
                                         (|List|
                                          (|Record|
                                           (|:| |op|
                                                (|LinearOrdinaryDifferentialOperator3|
                                                 (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  (QREFELT $ 6) (QREFELT $ 7))
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  (QREFELT $ 6)
                                                  (QREFELT $ 7))))
                                           (|:| |ram|
                                                (|UnivariatePolynomial|
                                                 (QREFELT $ 6)
                                                 (|Expression| (|Integer|))))
                                           (|:| |expart|
                                                (|UnivariateLaurentSeries|
                                                 (|Expression| (|Integer|))
                                                 (QREFELT $ 6)
                                                 (QREFELT $ 7)))))
                                         (|List|
                                          (|Union|
                                           (|LinearOrdinaryDifferentialOperator3|
                                            (|Expression| (|Integer|))
                                            (|UnivariateTaylorSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7))
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|))
                                             (QREFELT $ 6) (QREFELT $ 7)))
                                           (|Record|
                                            (|:| |ope|
                                                 (|LinearOrdinaryDifferentialOperator3|
                                                  (|Expression| (|Integer|))
                                                  (|UnivariateTaylorSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  (|UnivariateLaurentSeries|
                                                   (|Expression| (|Integer|))
                                                   (QREFELT $ 6)
                                                   (QREFELT $ 7))))
                                            (|:| |dext| (|PositiveInteger|))
                                            (|:| |alpha|
                                                 (|Expression| (|Integer|)))
                                            (|:| |rami|
                                                 (|UnivariatePolynomial|
                                                  (QREFELT $ 6)
                                                  (|Expression|
                                                   (|Integer|))))))))
                                        #6#)))
                (LETT |mg| NIL)
                (SEQ (LETT |e| NIL) (LETT #5# |v|) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |e| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |r| (SPADCALL (QVELT |e| 1) (QREFELT $ 72)))
                          (LETT |s| (QVELT |e| 0))
                          (LETT |es|
                                (PROGN
                                 (LETT #3# NIL)
                                 (SEQ (LETT |g| NIL)
                                      (LETT #2#
                                            (SPADCALL
                                             (SPADCALL
                                              (|LODOF2;make_poly| |s| $)
                                              |factorizer|)
                                             (QREFELT $ 416)))
                                      G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN (LETT |g| (CAR #2#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #3#
                                              (CONS
                                               (SPADCALL
                                                (SPADCALL (QVELT |g| 1)
                                                          (QREFELT $ 417))
                                                (QREFELT $ 410))
                                               #3#))))
                                      (LETT #2# (CDR #2#)) (GO G190) G191
                                      (EXIT (NREVERSE #3#)))))
                          (LETT |ms|
                                (SPADCALL
                                 (SPADCALL (ELT $ 105) |es| (QREFELT $ 427))
                                 (QREFELT $ 240)))
                          (LETT |ss|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |ms| (QREFELT $ 189))
                                           (QVELT |e| 2) (QREFELT $ 216))
                                 (SPADCALL |r| (QREFELT $ 75))
                                 (QREFELT $ 249)))
                          (EXIT
                           (LETT |mg|
                                 (SPADCALL |mg| (LIST |ss|) (QREFELT $ 119)))))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (EXIT (LETT |res| (CONS (VECTOR |sg| |v| |mg|) |res|))))
               (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(DECLAIM (NOTINLINE |LinearOrdinaryDifferentialOperatorFactorizer2;|)) 

(DEFUN |LinearOrdinaryDifferentialOperatorFactorizer2| (&REST #1=#:G1850)
  (SPROG NIL
         (PROG (#2=#:G1851)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL NIL))
                                               (HGET |$ConstructorCache|
                                                     '|LinearOrdinaryDifferentialOperatorFactorizer2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |LinearOrdinaryDifferentialOperatorFactorizer2;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearOrdinaryDifferentialOperatorFactorizer2|)))))))))) 

(DEFUN |LinearOrdinaryDifferentialOperatorFactorizer2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 |#2|)
          (LETT |dv$|
                (LIST '|LinearOrdinaryDifferentialOperatorFactorizer2| DV$1
                      DV$2))
          (LETT $ (GETREFV 428))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|LinearOrdinaryDifferentialOperatorFactorizer2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LinearOrdinaryDifferentialOperatorFactorizer2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 11)
              (|UnivariateTaylorSeries| 11 (NRTEVAL (QREFELT $ 6))
                                        (NRTEVAL (QREFELT $ 7)))
              (0 . |coerce|) (|Expression| 38) (5 . |One|)
              (|UnivariateLaurentSeries| 11 (NRTEVAL (QREFELT $ 6))
                                         (NRTEVAL (QREFELT $ 7)))
              (9 . |One|) (|NonNegativeInteger|) (13 . |univariatePolynomial|)
              (|LinearOrdinaryDifferentialOperator3| 11 9 13) (19 . |Zero|)
              (23 . |Zero|) (27 . |Zero|)
              (|LinearOrdinaryDifferentialOperator3| 11 8 25) (31 . |Zero|)
              (|Boolean|) (35 . ~=) (|Fraction| 8) (41 . |leadingCoefficient|)
              (46 . |denom|) (51 . |coerce|) (56 . |numer|)
              (|Union| $ '"failed") (61 . |recip|) (66 . *) (72 . |degree|)
              (77 . |monomial|) (83 . +) (89 . |reductum|)
              (94 . |leadingCoefficient|) (|Integer|) (99 . |order|) (104 . ~=)
              (110 . |degree|) (115 . |order|) (121 . ~=) (127 . |reductum|)
              (|Record| (|:| |x| 38) (|:| |y| 38)) (|List| 45) (132 . |elt|)
              (|Fraction| 38) (138 . /) (144 . |Zero|) (148 . |denom|)
              (153 . |coefficient|) (159 . |numer|) (164 . |coefficient|)
              (170 . |monomial|) (176 . +)
              (|Record| (|:| |point| 45) (|:| |slope| 48) (|:| |npoly| 8))
              (|List| 57) (182 . |append|) |LODOF2;testnp;LodoL;6|
              (|Record| (|:| |factor| 8) (|:| |exponent| 15)) (|List| 61)
              (|Factored| 8) (188 . |factors|) (193 . |Zero|) (197 . ~=)
              (203 . ^) (|OneDimensionalArray| 8) (209 . |setelt!|) (|List| $)
              (216 . |tails|) (221 . |degree|) (226 . |coefficient|) (232 . -)
              (238 . |coerce|) (243 . /) (|IntegerRetractions| 11)
              (249 . |integer?|) (254 . ~=) (260 . |integer|) (265 . |coerce|)
              (270 . |eval|) (277 . -) (283 . =) (289 . |elt|) (295 . *)
              (301 . |setDifference|) (307 . |position|) (313 . |elt|)
              (|List| 17) (319 . |append|) (|Mapping| 99 95) (|String|)
              |LODOF2;testfn;LodoMSL;8| (|SparseUnivariatePolynomial| 11)
              (325 . |makeSUP|) (330 . |unmakeSUP|) (|Mapping| 8 95)
              (|Factored| 95) (|FactoredFunctions2| 95 8) (335 . |map|)
              (341 . |coerce|) (346 . *) (352 . +) (358 . |min|) (364 . |quo|)
              (370 . =) (|Record| (|:| |Qt| 17) (|:| |Rt| 17))
              |LODOF2;testf2;LodoUpFR;11| (|List| 13) (376 . |elt|)
              (|Record| (|:| |laurl| 110) (|:| |laurr| 110))
              |LODOF2;testll;FLodo2UpFIR;14|
              (|Record| (|:| |k| 38) (|:| |c| 11)) (|Stream| 114) (|List| 115)
              (382 . |elt|) (388 . |series|) (393 . |append|) (|Stream| 17)
              (|Mapping| 17 108) (|Stream| 108) (|StreamFunctions2| 108 17)
              (399 . |map|) (405 . |retract|)
              (|Record| (|:| |llc| 116) (|:| |rlc| 116))
              |LODOF2;testlc;FLodo2UpFIR;17| (|SingleInteger|) (410 . |One|)
              (414 . +) (|Mapping| 38 38) (|Stream| 38) (420 . |stream|)
              (426 . -) (432 . *) (438 . *) (|Union| 38 '"failed")
              (444 . |retractIfCan|) (449 . =) (|Mapping| 114 17 38)
              (|StreamFunctions3| 17 38 114) (455 . |map|) (462 . |append|)
              (|List| 114) (468 . |coerce|) (473 . |monomial|) (479 . *)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (485 . |extendedEuclidean|) (491 . |One|) (495 . ~=)
              (501 . |rem|) (507 . -) (512 . |pi|) (516 . |pi|) (520 . |pi|)
              (524 . *) (530 . -) (535 . *)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 160 '"failed") (541 . |extendedEuclidean|) (548 . -)
              (|OutputForm|) (554 . |coerce|) (|Void|) (559 . |print|)
              (|Record| (|:| |main| 108) (|:| |nf| 108) (|:| |error| 17))
              |LODOF2;testln;FLodo2UpFIR;20| (|PositiveInteger|) (564 . |One|)
              (568 . +) (|Record| (|:| |lr| 168) (|:| |n_lifts| 170))
              (|Mapping| 173 173) (|Stream| 173) (574 . |stream|)
              (|Mapping| 108 173) (|StreamFunctions2| 173 108) (580 . |map|)
              |LODOF2;testlw;FLodo2UpFIS;22| (586 . |extendedEuclidean|)
              (592 . |positiveRemainder|) (598 . |floor|)
              |LODOF2;testcp;LodoFILodo;24| (603 . |ceiling|)
              |LODOF2;testco;LodoFIB;26| |LODOF2;testcx;LodoFUp;28|
              (608 . |leadingCoefficient|) (613 . |coerce|) (618 . |reductum|)
              |LODOF2;testpd;UpLodo;30| (623 . |elt|)
              (|Record| (|:| |ope| 17) (|:| |dext| 170) (|:| |alpha| 11)
                        (|:| |rami| 8))
              (|Union| 17 193) (|List| 194) (629 . |value|) (634 . |coerce|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 198) (|:| |factor| 8) (|:| |exponent| 15))
              (|List| 199) (639 . |factorList|) (644 . |retractIfCan|)
              (649 . ~=) (655 . ~=) (661 . |min|) (|Mapping| 38 38 38)
              (|List| 38) (667 . |reduce|) (673 . |elt|) (679 . |truncate|)
              (685 . -) (690 . *) (696 . ^) (702 . -) (707 . *) (713 . +)
              (|Record| (|:| |op| 17) (|:| |ram| 8) (|:| |expart| 13))
              (|List| 217) (719 . |append|) (725 . =) (731 . |rightQuotient|)
              (737 . |append|) (|SparseUnivariatePolynomial| $)
              (743 . |zeroOf|) (748 . |coerce|) (753 . ^) (759 . *)
              (|Union| 218 195) |LODOF2;testfr;LodoMSU;32| (765 . |coerce|)
              (770 . |coerce|) (775 . ^) (|Union| 8 13)
              |LODOF2;testsb;ULodoLodo;34| (781 . =) (|Mapping| 11 38)
              (787 . |multiplyCoefficients|) (793 . |multiplyExponents|)
              (799 . ^) (805 . |coerce|) (810 . *)
              |LODOF2;testro;LodoEPiLodo;36| |LODOF2;testfo;LodoMSU;38|
              (|Vector| 13) (816 . |setelt!|) (823 . D) (827 . |apply|)
              (834 . *) (840 . /) (846 . /) (|Mapping| 13 13) (852 . |map!|)
              (858 . +) (|Mapping| 15 15) (|Stream| 15) (864 . |stream|)
              (870 . |elt|) (876 . *) (882 . ^) (|Mapping| 114 15)
              (|StreamFunctions2| 15 114) (888 . |map|) (|List| 244)
              (894 . |elt|) (|Union| 270 '"failed") (|Vector| 11)
              (|IntegerLinearDependence| 11) (900 . |particularSolutionOverQ|)
              (906 . =) (|Vector| 48) (912 . |elt|) (|Mapping| 11 11)
              (918 . |map|) (|List| 110) (924 . |elt|) (930 . |setelt!|)
              (|Matrix| 13) (937 . |matrix|) (942 . ~=) (948 . |One|) (952 . /)
              (958 . |One|) (962 . |One|) (|List| 58) (|Mapping| 58 17)
              (|ListFunctions2| 17 58) (966 . |map|) (972 . |elt|) (978 . ~=)
              (984 . /) |LODOF2;testsc;2LodoMB;42| (990 . |retract|)
              (|Union| 295 '"failed") (995 . ~=) (|List| 95) (1001 . |elt|)
              (1007 . |One|) (1011 . |monomial|) (1017 . *) (1023 . +)
              (1029 . |One|) (1033 . /) (1039 . /) (1045 . |adjoint|)
              (|LinearOrdinaryDifferentialOperator1| 25)
              (|LODOConvertions| 11 8 25) (1050 . |convert|) (1055 . |Zero|)
              (|Union| 11 '#1="infinity") (1059 . =) (1065 . /) (1071 . ^)
              (1077 . D) (1081 . *) (1087 . -) (1092 . ~=)
              (1098 . |leadingCoefficient|) (1103 . |degree|) (1108 . ^)
              (1114 . +) (1120 . |reductum|) (1125 . ~=) (1131 . |rightGcd|)
              (1137 . |rightQuotient|) (1143 . |coerce|) (1148 . *) (1154 . *)
              (1160 . |leftGcd|) (1166 . |leftQuotient|) (|List| 48)
              (1172 . |elt|) (1178 . *) (|Vector| 95) (1184 . |vector|)
              (|Matrix| 95) (|List| 333) (|List| 15)
              (|VectorHermitePadeSolver|) (1189 . |hp_solve|) (1196 . |column|)
              (1202 . |members|) (1207 . *) (1213 . |append|) (|List| 305)
              (1219 . |elt|) (|Mapping| 99 95 347) (|List| 11)
              |LODOF2;factor;LodoMLL;47| (1225 . |concat|) (1231 . |concat!|)
              (1237 . -) (1242 . |One|) (1246 . |coefficient|) (1252 . /)
              (1258 . |minimumDegree|) (1263 . |lcm|) |LODOF2;testis;LodoB;49|
              (1268 . ~=) (1274 . |message|)
              (|Record| (|:| |point| 309) (|:| |lpf| 17) (|:| |dxt| 170))
              (|Record| (|:| |singularity| 360) (|:| |fos| 218)
                        (|:| |mge| 110))
              (|List| 361) |LODOF2;ge_minimal;LodoMSL;61| (1279 . |append|)
              (1285 . *) (1291 . |setelt!|) (1298 . -) (1303 . |min|)
              (|Character|) (1307 . |min|) (1313 . |min|)
              (|Mapping| 170 170 170) (|List| 170) (1319 . |reduce|)
              (1325 . |remove|) (|Record| (|:| |sing| 360) (|:| |arf| 195))
              (|List| 376) (1331 . |append|) (1337 . |elt|)
              (|Union| 344 '"failed") (1343 . ~=) (1349 . |adjoint|)
              |LODOF2;testfg;LodoML;51| (1354 . |convert|)
              |LODOF2;testlp;LodoULodo;54| (1359 . |Zero|) (1363 . ^)
              (1369 . *) (1375 . +) (|Kernel| $) (1381 . |minPoly|)
              (|Kernel| 11)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 392)
                                                     392 38
                                                     (|SparseMultivariatePolynomial|
                                                      38 392)
                                                     11)
              (1386 . |univariate|) |LODOF2;testgt;EKE;57| (1393 . |Zero|)
              (1397 . |monomial|) (1403 . +) (1409 . |rest|) (1415 . |rest|)
              (1421 . +) (|List| 390) (1427 . |kernels|) (1432 . |coerce|)
              (|Union| (|AlgebraicNumber|) '"failed") (1437 . |retractIfCan|)
              (1442 . |denominator|) (1447 . |eval|) (1454 . |degree|)
              (1459 . |retract|) (|Union| 48 '"-infinity") (1464 . =)
              (1470 . |max|)
              (|Record| (|:| |flag| 198) (|:| |factor| 95) (|:| |exponent| 15))
              (|List| 414) (1476 . |factorList|) (1481 . |rootOf|)
              (|Record| (|:| |ecs| 110) (|:| |ecr| 8) (|:| |ect| 25))
              (|List| 418) (1486 . |append|) |LODOF2;gen_exp;LodoUMLL;60|
              (|List| 8) (|CylindricalAlgebraicDecompositionUtilities| 11 8)
              (1492 . |squareFreeBasis|) (1497 . |append|) (|Mapping| 48 48 48)
              (1503 . |reduce|))
           '#(|testsc| 1509 |testsb| 1516 |testro| 1522 |testpd| 1529 |testnp|
              1534 |testlw| 1539 |testlp| 1549 |testln| 1555 |testll| 1565
              |testlc| 1575 |testis| 1585 |testgt| 1590 |testfr| 1596 |testfo|
              1603 |testfn| 1610 |testfg| 1617 |testf2| 1623 |testcx| 1630
              |testcp| 1636 |testco| 1643 |gen_exp| 1650 |ge_minimal| 1658
              |factor| 1665)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|testnp|
                                 ((|List|
                                   (|Record|
                                    (|:| |point|
                                         (|Record| (|:| |x| (|Integer|))
                                                   (|:| |y| (|Integer|))))
                                    (|:| |slope| (|Fraction| (|Integer|)))
                                    (|:| |npoly|
                                         (|UnivariatePolynomial| |#1|
                                                                 (|Expression|
                                                                  (|Integer|))))))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))))
                                T)
                              '((|testfn|
                                 ((|List|
                                   (|LinearOrdinaryDifferentialOperator3|
                                    (|Expression| (|Integer|))
                                    (|UnivariateTaylorSeries|
                                     (|Expression| (|Integer|)) |#1| |#2|)
                                    (|UnivariateLaurentSeries|
                                     (|Expression| (|Integer|)) |#1| |#2|)))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|))))
                                  (|String|)))
                                T)
                              '((|testf2|
                                 ((|Record|
                                   (|:| |Qt|
                                        (|LinearOrdinaryDifferentialOperator3|
                                         (|Expression| (|Integer|))
                                         (|UnivariateTaylorSeries|
                                          (|Expression| (|Integer|)) |#1| |#2|)
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|)) |#1|
                                          |#2|)))
                                   (|:| |Rt|
                                        (|LinearOrdinaryDifferentialOperator3|
                                         (|Expression| (|Integer|))
                                         (|UnivariateTaylorSeries|
                                          (|Expression| (|Integer|)) |#1| |#2|)
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|)) |#1|
                                          |#2|))))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|testll|
                                 ((|Record|
                                   (|:| |laurl|
                                        (|List|
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|)) |#1|
                                          |#2|)))
                                   (|:| |laurr|
                                        (|List|
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|)) |#1|
                                          |#2|))))
                                  (|Fraction| (|Integer|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|testlc|
                                 ((|Record|
                                   (|:| |llc|
                                        (|List|
                                         (|Stream|
                                          (|Record| (|:| |k| (|Integer|))
                                                    (|:| |c|
                                                         (|Expression|
                                                          (|Integer|)))))))
                                   (|:| |rlc|
                                        (|List|
                                         (|Stream|
                                          (|Record| (|:| |k| (|Integer|))
                                                    (|:| |c|
                                                         (|Expression|
                                                          (|Integer|))))))))
                                  (|Fraction| (|Integer|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|testln|
                                 ((|Record|
                                   (|:| |main|
                                        (|Record|
                                         (|:| |Qt|
                                              (|LinearOrdinaryDifferentialOperator3|
                                               (|Expression| (|Integer|))
                                               (|UnivariateTaylorSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)))
                                         (|:| |Rt|
                                              (|LinearOrdinaryDifferentialOperator3|
                                               (|Expression| (|Integer|))
                                               (|UnivariateTaylorSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)))))
                                   (|:| |nf|
                                        (|Record|
                                         (|:| |Qt|
                                              (|LinearOrdinaryDifferentialOperator3|
                                               (|Expression| (|Integer|))
                                               (|UnivariateTaylorSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)))
                                         (|:| |Rt|
                                              (|LinearOrdinaryDifferentialOperator3|
                                               (|Expression| (|Integer|))
                                               (|UnivariateTaylorSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)
                                               (|UnivariateLaurentSeries|
                                                (|Expression| (|Integer|)) |#1|
                                                |#2|)))))
                                   (|:| |error|
                                        (|LinearOrdinaryDifferentialOperator3|
                                         (|Expression| (|Integer|))
                                         (|UnivariateTaylorSeries|
                                          (|Expression| (|Integer|)) |#1| |#2|)
                                         (|UnivariateLaurentSeries|
                                          (|Expression| (|Integer|)) |#1|
                                          |#2|))))
                                  (|Fraction| (|Integer|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|testlw|
                                 ((|Stream|
                                   (|Record|
                                    (|:| |Qt|
                                         (|LinearOrdinaryDifferentialOperator3|
                                          (|Expression| (|Integer|))
                                          (|UnivariateTaylorSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|)
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|)))
                                    (|:| |Rt|
                                         (|LinearOrdinaryDifferentialOperator3|
                                          (|Expression| (|Integer|))
                                          (|UnivariateTaylorSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|)
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|)))))
                                  (|Fraction| (|Integer|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|testcp|
                                 ((|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariateTaylorSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|)
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|testco|
                                 ((|Boolean|)
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|testcx|
                                 ((|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|testpd|
                                 ((|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariateTaylorSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|)
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|))
                                  (|UnivariatePolynomial| |#1|
                                                          (|Expression|
                                                           (|Integer|)))))
                                T)
                              '((|testfr|
                                 ((|Union|
                                   (|List|
                                    (|Record|
                                     (|:| |op|
                                          (|LinearOrdinaryDifferentialOperator3|
                                           (|Expression| (|Integer|))
                                           (|UnivariateTaylorSeries|
                                            (|Expression| (|Integer|)) |#1|
                                            |#2|)
                                           (|UnivariateLaurentSeries|
                                            (|Expression| (|Integer|)) |#1|
                                            |#2|)))
                                     (|:| |ram|
                                          (|UnivariatePolynomial| |#1|
                                                                  (|Expression|
                                                                   (|Integer|))))
                                     (|:| |expart|
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|))))
                                   (|List|
                                    (|Union|
                                     (|LinearOrdinaryDifferentialOperator3|
                                      (|Expression| (|Integer|))
                                      (|UnivariateTaylorSeries|
                                       (|Expression| (|Integer|)) |#1| |#2|)
                                      (|UnivariateLaurentSeries|
                                       (|Expression| (|Integer|)) |#1| |#2|))
                                     (|Record|
                                      (|:| |ope|
                                           (|LinearOrdinaryDifferentialOperator3|
                                            (|Expression| (|Integer|))
                                            (|UnivariateTaylorSeries|
                                             (|Expression| (|Integer|)) |#1|
                                             |#2|)
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|)) |#1|
                                             |#2|)))
                                      (|:| |dext| (|PositiveInteger|))
                                      (|:| |alpha| (|Expression| (|Integer|)))
                                      (|:| |rami|
                                           (|UnivariatePolynomial| |#1|
                                                                   (|Expression|
                                                                    (|Integer|))))))))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|))))
                                  (|String|)))
                                T)
                              '((|testsb|
                                 ((|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariateTaylorSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|)
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|))
                                  (|Union|
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))))
                                T)
                              '((|testro|
                                 ((|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariateTaylorSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|)
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Expression| (|Integer|))
                                  (|PositiveInteger|)))
                                T)
                              '((|testfo|
                                 ((|Union|
                                   (|List|
                                    (|Record|
                                     (|:| |op|
                                          (|LinearOrdinaryDifferentialOperator3|
                                           (|Expression| (|Integer|))
                                           (|UnivariateTaylorSeries|
                                            (|Expression| (|Integer|)) |#1|
                                            |#2|)
                                           (|UnivariateLaurentSeries|
                                            (|Expression| (|Integer|)) |#1|
                                            |#2|)))
                                     (|:| |ram|
                                          (|UnivariatePolynomial| |#1|
                                                                  (|Expression|
                                                                   (|Integer|))))
                                     (|:| |expart|
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|))))
                                   (|List|
                                    (|Union|
                                     (|LinearOrdinaryDifferentialOperator3|
                                      (|Expression| (|Integer|))
                                      (|UnivariateTaylorSeries|
                                       (|Expression| (|Integer|)) |#1| |#2|)
                                      (|UnivariateLaurentSeries|
                                       (|Expression| (|Integer|)) |#1| |#2|))
                                     (|Record|
                                      (|:| |ope|
                                           (|LinearOrdinaryDifferentialOperator3|
                                            (|Expression| (|Integer|))
                                            (|UnivariateTaylorSeries|
                                             (|Expression| (|Integer|)) |#1|
                                             |#2|)
                                            (|UnivariateLaurentSeries|
                                             (|Expression| (|Integer|)) |#1|
                                             |#2|)))
                                      (|:| |dext| (|PositiveInteger|))
                                      (|:| |alpha| (|Expression| (|Integer|)))
                                      (|:| |rami|
                                           (|UnivariatePolynomial| |#1|
                                                                   (|Expression|
                                                                    (|Integer|))))))))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|))))
                                  (|String|)))
                                T)
                              '((|testsc|
                                 ((|Boolean|)
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariatePolynomial| |#1|
                                                           (|Expression|
                                                            (|Integer|)))
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|))))))
                                T)
                              '((|testfg|
                                 ((|List|
                                   (|LinearOrdinaryDifferentialOperator1|
                                    (|Fraction|
                                     (|UnivariatePolynomial| |#1|
                                                             (|Expression|
                                                              (|Integer|))))))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|))))))
                                T)
                              '((|testlp|
                                 ((|LinearOrdinaryDifferentialOperator3|
                                   (|Expression| (|Integer|))
                                   (|UnivariateTaylorSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|)
                                   (|UnivariateLaurentSeries|
                                    (|Expression| (|Integer|)) |#1| |#2|))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Union| (|Expression| (|Integer|))
                                           "infinity")))
                                T)
                              '((|factor|
                                 ((|List|
                                   (|LinearOrdinaryDifferentialOperator1|
                                    (|Fraction|
                                     (|UnivariatePolynomial| |#1|
                                                             (|Expression|
                                                              (|Integer|))))))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|)))
                                   (|List| (|Expression| (|Integer|))))
                                  (|List| (|Expression| (|Integer|)))))
                                T)
                              '((|testis|
                                 ((|Boolean|)
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))))
                                T)
                              '((|testgt|
                                 ((|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|Kernel| (|Expression| (|Integer|)))))
                                T)
                              '((|gen_exp|
                                 ((|List|
                                   (|Record|
                                    (|:| |ecs|
                                         (|List|
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|)))
                                    (|:| |ecr|
                                         (|UnivariatePolynomial| |#1|
                                                                 (|Expression|
                                                                  (|Integer|))))
                                    (|:| |ect|
                                         (|Fraction|
                                          (|UnivariatePolynomial| |#1|
                                                                  (|Expression|
                                                                   (|Integer|)))))))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Union| (|Expression| (|Integer|))
                                           "infinity")
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|)))
                                   (|List| (|Expression| (|Integer|))))
                                  (|List| (|Expression| (|Integer|)))))
                                T)
                              '((|ge_minimal|
                                 ((|List|
                                   (|Record|
                                    (|:| |singularity|
                                         (|Record|
                                          (|:| |point|
                                               (|Union|
                                                (|Expression| (|Integer|))
                                                #1#))
                                          (|:| |lpf|
                                               (|LinearOrdinaryDifferentialOperator3|
                                                (|Expression| (|Integer|))
                                                (|UnivariateTaylorSeries|
                                                 (|Expression| (|Integer|))
                                                 |#1| |#2|)
                                                (|UnivariateLaurentSeries|
                                                 (|Expression| (|Integer|))
                                                 |#1| |#2|)))
                                          (|:| |dxt| (|PositiveInteger|))))
                                    (|:| |fos|
                                         (|List|
                                          (|Record|
                                           (|:| |op|
                                                (|LinearOrdinaryDifferentialOperator3|
                                                 (|Expression| (|Integer|))
                                                 (|UnivariateTaylorSeries|
                                                  (|Expression| (|Integer|))
                                                  |#1| |#2|)
                                                 (|UnivariateLaurentSeries|
                                                  (|Expression| (|Integer|))
                                                  |#1| |#2|)))
                                           (|:| |ram|
                                                (|UnivariatePolynomial| |#1|
                                                                        (|Expression|
                                                                         (|Integer|))))
                                           (|:| |expart|
                                                (|UnivariateLaurentSeries|
                                                 (|Expression| (|Integer|))
                                                 |#1| |#2|)))))
                                    (|:| |mge|
                                         (|List|
                                          (|UnivariateLaurentSeries|
                                           (|Expression| (|Integer|)) |#1|
                                           |#2|)))))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction|
                                    (|UnivariatePolynomial| |#1|
                                                            (|Expression|
                                                             (|Integer|)))))
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial|
                                     (|Expression| (|Integer|))))
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| (|Integer|))))
                                  (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 427
                                            '(1 9 0 8 10 0 11 0 12 0 13 0 14 2
                                              9 8 0 15 16 0 17 0 18 0 11 0 19 0
                                              13 0 20 0 21 0 22 2 21 23 0 0 24
                                              1 21 25 0 26 1 25 8 0 27 1 13 0 9
                                              28 1 25 8 0 29 1 13 30 0 31 2 13
                                              0 9 0 32 1 21 15 0 33 2 17 0 13
                                              15 34 2 17 0 0 0 35 1 21 0 0 36 1
                                              17 13 0 37 1 13 38 0 39 2 17 23 0
                                              0 40 1 17 15 0 41 2 13 38 0 38 42
                                              2 15 23 0 0 43 1 17 0 0 44 2 46
                                              45 0 38 47 2 48 0 38 38 49 0 8 0
                                              50 1 48 38 0 51 2 17 13 0 15 52 1
                                              48 38 0 53 2 13 11 0 38 54 2 8 0
                                              11 15 55 2 8 0 0 0 56 2 58 0 0 0
                                              59 1 63 62 0 64 0 48 0 65 2 48 23
                                              0 0 66 2 8 0 0 15 67 3 68 8 0 38
                                              8 69 1 62 70 0 71 1 8 15 0 72 2 8
                                              11 0 15 73 2 11 0 0 0 74 1 11 0
                                              38 75 2 11 0 0 0 76 1 77 23 11 78
                                              2 11 23 0 0 79 1 77 38 11 80 1 8
                                              0 38 81 3 8 0 0 0 0 82 2 8 0 0 0
                                              83 2 8 23 0 0 84 2 68 8 0 38 85 2
                                              8 0 0 0 86 2 62 0 0 0 87 2 62 38
                                              61 0 88 2 62 61 0 38 89 2 90 0 0
                                              0 91 1 8 95 0 96 1 8 0 95 97 2
                                              100 63 98 99 101 1 48 0 38 102 2
                                              48 0 38 0 103 2 48 0 0 0 104 2 48
                                              0 0 0 105 2 8 0 0 0 106 2 48 23 0
                                              0 107 2 110 13 0 38 111 2 116 115
                                              0 38 117 1 13 0 115 118 2 110 0 0
                                              0 119 2 123 120 121 122 124 1 48
                                              38 0 125 0 128 0 129 2 38 0 0 0
                                              130 2 132 0 131 38 133 2 38 0 0 0
                                              134 2 38 0 0 0 135 2 38 0 15 0
                                              136 1 48 137 0 138 2 137 23 0 0
                                              139 3 141 115 140 120 132 142 2
                                              116 0 0 0 143 1 115 0 144 145 2
                                              13 0 11 38 146 2 17 0 0 13 147 2
                                              8 148 0 0 149 0 8 0 150 2 8 23 0
                                              0 151 2 8 0 0 0 152 1 8 0 0 153 0
                                              11 0 154 0 13 0 155 0 9 0 156 2
                                              17 0 13 0 157 1 17 0 0 158 2 17 0
                                              0 0 159 3 8 161 0 0 0 162 2 17 0
                                              0 0 163 1 17 164 0 165 1 164 166
                                              0 167 0 170 0 171 2 170 0 0 0 172
                                              2 175 0 174 173 176 2 178 122 177
                                              175 179 2 38 148 0 0 181 2 38 0 0
                                              0 182 1 48 38 0 183 1 48 38 0 185
                                              1 8 11 0 188 1 13 0 11 189 1 8 0
                                              0 190 2 58 57 0 38 192 1 195 194
                                              0 196 1 17 0 13 197 1 63 200 0
                                              201 1 8 137 0 202 2 137 23 0 0
                                              203 2 38 23 0 0 204 2 38 0 0 0
                                              205 2 207 38 206 0 208 2 200 199
                                              0 38 209 2 13 0 0 38 210 1 13 0 0
                                              211 2 13 0 11 0 212 2 13 0 0 38
                                              213 1 11 0 0 214 2 11 0 15 0 215
                                              2 13 0 0 0 216 2 218 0 0 0 219 2
                                              17 23 0 0 220 2 17 0 0 0 221 2
                                              195 0 0 0 222 1 11 0 223 224 1 8
                                              0 11 225 2 11 0 0 38 226 2 11 0
                                              38 0 227 1 25 0 8 230 1 21 0 25
                                              231 2 17 0 0 15 232 2 11 23 0 0
                                              235 2 13 0 236 0 237 2 13 0 0 170
                                              238 2 48 0 0 38 239 1 11 0 48 240
                                              2 17 0 38 0 241 3 244 13 0 38 13
                                              245 0 17 0 246 3 17 13 0 13 13
                                              247 2 13 0 0 0 248 2 13 0 0 11
                                              249 2 13 0 0 0 250 2 244 0 251 0
                                              252 2 15 0 0 0 253 2 255 0 254 15
                                              256 2 244 13 0 38 257 2 15 0 0 0
                                              258 2 11 0 0 15 259 2 261 115 260
                                              255 262 2 263 244 0 38 264 2 267
                                              265 266 11 268 2 265 23 0 0 269 2
                                              270 48 0 38 271 2 13 0 272 0 273
                                              2 274 110 0 38 275 3 110 13 0 38
                                              13 276 1 277 0 274 278 2 13 23 0
                                              0 279 0 17 0 280 2 17 0 0 13 281
                                              0 48 0 282 0 9 0 283 2 286 284
                                              285 90 287 2 284 58 0 38 288 2 58
                                              23 0 0 289 2 8 0 0 11 290 1 13 9
                                              0 292 2 293 23 0 0 294 2 295 95 0
                                              38 296 0 25 0 297 2 21 0 25 15
                                              298 2 21 0 25 0 299 2 21 0 0 0
                                              300 0 21 0 301 2 21 0 0 25 302 2
                                              25 0 0 0 303 1 21 0 0 304 1 306
                                              305 21 307 0 305 0 308 2 309 23 0
                                              0 310 2 25 0 8 8 311 2 8 0 0 170
                                              312 0 305 0 313 2 305 0 25 0 314
                                              1 305 0 0 315 2 305 23 0 0 316 1
                                              305 25 0 317 1 305 15 0 318 2 305
                                              0 0 15 319 2 305 0 0 0 320 1 305
                                              0 0 321 2 93 23 0 0 322 2 305 0 0
                                              0 323 2 305 0 0 0 324 1 305 0 25
                                              325 2 305 0 0 25 326 2 305 0 0 0
                                              327 2 305 0 0 0 328 2 305 0 0 0
                                              329 2 330 48 0 38 331 2 128 0 38
                                              0 332 1 333 0 295 334 3 338 335
                                              336 337 15 339 2 335 333 0 38 340
                                              1 333 295 0 341 2 48 0 0 38 342 2
                                              274 0 0 0 343 2 344 305 0 38 345
                                              2 344 0 0 0 349 2 344 0 0 0 350 1
                                              25 0 0 351 0 305 0 352 2 305 25 0
                                              15 353 2 305 0 0 25 354 1 305 15
                                              0 355 1 8 0 70 356 2 25 23 0 0
                                              358 1 164 0 93 359 2 330 0 0 0
                                              364 2 48 0 15 0 365 3 330 48 0 38
                                              48 366 1 48 0 0 367 0 128 0 368 2
                                              369 0 0 0 370 2 170 0 0 0 371 2
                                              373 170 372 0 374 2 362 0 361 0
                                              375 2 377 0 0 0 378 2 195 194 0
                                              38 379 2 380 23 0 0 381 1 17 0 0
                                              382 1 306 21 305 384 0 25 0 386 2
                                              25 0 0 15 387 2 25 0 8 0 388 2 25
                                              0 0 0 389 1 11 223 390 391 3 393
                                              95 11 392 95 394 0 95 0 396 2 95
                                              0 11 15 397 2 95 0 0 0 398 2 110
                                              0 0 15 399 2 218 0 0 15 400 2 11
                                              0 0 0 401 1 11 402 0 403 1 11 0
                                              390 404 1 11 405 0 406 1 11 0 0
                                              407 3 11 0 0 390 0 408 1 95 15 0
                                              409 1 11 48 0 410 2 411 23 0 0
                                              412 2 48 0 0 0 413 1 99 415 0 416
                                              1 11 0 223 417 2 419 0 0 0 420 1
                                              423 422 422 424 2 62 0 0 0 425 2
                                              330 48 426 0 427 3 0 23 21 21 92
                                              291 2 0 17 233 21 234 3 0 17 21
                                              11 170 242 1 0 17 8 191 1 0 58 21
                                              60 6 0 122 48 21 8 8 48 38 180 2
                                              0 17 305 309 385 6 0 168 48 21 8
                                              8 48 38 169 6 0 112 48 21 8 8 48
                                              38 113 6 0 126 48 21 8 8 48 38
                                              127 1 0 23 305 357 2 0 11 11 392
                                              395 3 0 228 21 92 93 229 3 0 228
                                              21 92 93 243 3 0 90 21 92 93 94 2
                                              0 344 305 92 383 3 0 108 21 8 48
                                              109 2 0 8 21 48 187 3 0 17 21 48
                                              38 184 3 0 23 21 48 38 186 4 0
                                              419 305 309 346 347 421 3 0 362
                                              305 92 93 363 3 0 344 305 346 347
                                              348)))))
           '|lookupComplete|)) 
