
(PUT '|UTS;stream| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |UTS;stream| ((|x| ($)) ($ (|Stream| |Coef|))) |x|) 

(SDEFUN |UTS;coerce;V$;2| ((|v| (|Variable| |var|)) ($ ($)))
        (COND
         ((SPADCALL (QREFELT $ 8) (QREFELT $ 11))
          (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 15)))
         ('T
          (SPADCALL (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 15))
                    (SPADCALL (QREFELT $ 8) 0 (QREFELT $ 15)) (QREFELT $ 18))))) 

(SDEFUN |UTS;coerce;I$;3| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 22)) (QREFELT $ 23))) 

(SDEFUN |UTS;coerce;Coef$;4| ((|r| (|Coef|)) ($ ($)))
        (SPADCALL |r| (QREFELT $ 27))) 

(SDEFUN |UTS;monomial;CoefNni$;5|
        ((|c| (|Coef|)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |c| |n| (QREFELT $ 28))) 

(PUT '|UTS;getExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |UTS;getExpon|
        ((|term| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|)))
         ($ (|NonNegativeInteger|)))
        (QCAR |term|)) 

(PUT '|UTS;getCoef| '|SPADreplace| 'QCDR) 

(SDEFUN |UTS;getCoef|
        ((|term| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|)))
         ($ (|Coef|)))
        (QCDR |term|)) 

(PUT '|UTS;rec| '|SPADreplace| 'CONS) 

(SDEFUN |UTS;rec|
        ((|expon| (|NonNegativeInteger|)) (|coef| (|Coef|))
         ($ (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|))))
        (CONS |expon| |coef|)) 

(SDEFUN |UTS;recs|
        ((|st| (|Stream| |Coef|)) (|n| (|NonNegativeInteger|))
         ($
          (|Stream|
           (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SPADCALL (CONS #'|UTS;recs!0| (VECTOR |n| $ |st|))
                         (QREFELT $ 41)))) 

(SDEFUN |UTS;recs!0| (($$ NIL))
        (PROG (|st| $ |n|)
          (LETT |st| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|coef| NIL))
                   (COND
                    ((SPADCALL |st| (QREFELT $ 29)) (SPADCALL (QREFELT $ 38)))
                    ((SPADCALL (LETT |coef| (SPADCALL |st| (QREFELT $ 31)))
                               (QREFELT $ 11))
                     (|UTS;recs| (SPADCALL |st| (QREFELT $ 32))
                      (SPADCALL |n| (|spadConstant| $ 33) (QREFELT $ 34)) $))
                    ('T
                     (SPADCALL (|UTS;rec| |n| |coef| $)
                               (|UTS;recs| (SPADCALL |st| (QREFELT $ 32))
                                (SPADCALL |n| (|spadConstant| $ 33)
                                          (QREFELT $ 34))
                                $)
                               (QREFELT $ 39))))))))) 

(SDEFUN |UTS;terms;$S;10|
        ((|x| ($))
         ($
          (|Stream|
           (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|)))))
        (|UTS;recs| (|UTS;stream| |x| $) 0 $)) 

(SDEFUN |UTS;recsToCoefs|
        ((|st|
          (|Stream|
           (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|))))
         (|n| (|NonNegativeInteger|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|UTS;recsToCoefs!0| (VECTOR |n| $ |st|))
                          (QREFELT $ 50))))) 

(SDEFUN |UTS;recsToCoefs!0| (($$ NIL))
        (PROG (|st| $ |n|)
          (LETT |st| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|term| NIL) (|expon| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |st| (QREFELT $ 43)) (SPADCALL (QREFELT $ 48)))
                     ('T
                      (SEQ (LETT |term| (SPADCALL |st| (QREFELT $ 44)))
                           (LETT |expon| (|UTS;getExpon| |term| $))
                           (EXIT
                            (COND
                             ((SPADCALL |n| |expon| (QREFELT $ 45))
                              (SPADCALL (|UTS;getCoef| |term| $)
                                        (|UTS;recsToCoefs|
                                         (SPADCALL |st| (QREFELT $ 46))
                                         (SPADCALL |n| (|spadConstant| $ 33)
                                                   (QREFELT $ 34))
                                         $)
                                        (QREFELT $ 49)))
                             ('T
                              (SPADCALL (|spadConstant| $ 16)
                                        (|UTS;recsToCoefs| |st|
                                         (SPADCALL |n| (|spadConstant| $ 33)
                                                   (QREFELT $ 34))
                                         $)
                                        (QREFELT $ 49)))))))))))))) 

(SDEFUN |UTS;series;S$;12|
        ((|st|
          (|Stream|
           (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|))))
         ($ ($)))
        (|UTS;recsToCoefs| |st| 0 $)) 

(SDEFUN |UTS;stToPoly|
        ((|st| (|Stream| |Coef|)) (|term| (|Polynomial| |Coef|))
         (|n| (|NonNegativeInteger|)) (|n0| (|NonNegativeInteger|))
         ($ (|Polynomial| |Coef|)))
        (COND
         ((OR (> |n| |n0|) (SPADCALL |st| (QREFELT $ 29)))
          (|spadConstant| $ 53))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |st| (QREFELT $ 31))
                     (SPADCALL |term| |n| (QREFELT $ 54)) (QREFELT $ 55))
           (|UTS;stToPoly| (SPADCALL |st| (QREFELT $ 32)) |term| (+ |n| 1) |n0|
            $)
           (QREFELT $ 56))))) 

(SDEFUN |UTS;polynomial;$NniP;14|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Polynomial| |Coef|)))
        (|UTS;stToPoly| (|UTS;stream| |x| $)
         (SPADCALL (SPADCALL (QREFELT $ 7) (QREFELT $ 58))
                   (SPADCALL (QREFELT $ 8) (QREFELT $ 59)) (QREFELT $ 60))
         0 |n| $)) 

(SDEFUN |UTS;polynomial;$2NniP;15|
        ((|x| ($)) (|n1| #1=(|NonNegativeInteger|)) (|n2| #1#)
         ($ (|Polynomial| |Coef|)))
        (SPROG ((|#G31| #1#) (|#G30| #1#))
               (SEQ
                (COND
                 ((> |n1| |n2|)
                  (PROGN
                   (LETT |#G30| |n2|)
                   (LETT |#G31| |n1|)
                   (LETT |n1| |#G30|)
                   (LETT |n2| |#G31|))))
                (EXIT
                 (|UTS;stToPoly|
                  (SPADCALL (|UTS;stream| |x| $) |n1| (QREFELT $ 62))
                  (SPADCALL (SPADCALL (QREFELT $ 7) (QREFELT $ 58))
                            (SPADCALL (QREFELT $ 8) (QREFELT $ 59))
                            (QREFELT $ 60))
                  |n1| |n2| $))))) 

(SDEFUN |UTS;univariatePolynomial;$NniUp;16|
        ((|x| ($)) (|n| (|NonNegativeInteger|))
         ($ (|UnivariatePolynomial| |var| |Coef|)))
        (SPROG
         ((|st| ($)) (|term| (|UnivariatePolynomial| |var| |Coef|))
          (|ress| (|UnivariatePolynomial| |var| |Coef|)) (#1=#:G775 NIL)
          (#2=#:G777 NIL) (|k| NIL)
          (|t1| (|UnivariatePolynomial| |var| |Coef|)) (#3=#:G776 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ress| (|spadConstant| $ 65))
                (LETT |st| (|UTS;stream| |x| $))
                (EXIT
                 (COND
                  ((SPADCALL (QREFELT $ 8) (|spadConstant| $ 16)
                             (QREFELT $ 66))
                   (SEQ
                    (SEQ (LETT |k| 0) (LETT #3# |n|) G190
                         (COND ((|greater_SI| |k| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |st| (QREFELT $ 29))
                             (PROGN (LETT #1# |ress|) (GO #4=#:G774)))
                            ('T
                             (SEQ
                              (LETT |term|
                                    (SPADCALL (SPADCALL |st| (QREFELT $ 31))
                                              |k| (QREFELT $ 67)))
                              (LETT |ress|
                                    (SPADCALL |term| |ress| (QREFELT $ 68)))
                              (EXIT
                               (LETT |st| (SPADCALL |st| (QREFELT $ 35)))))))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ress|)))
                  ('T
                   (SEQ |ress|
                        (LETT |t1|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 12) 1
                                         (QREFELT $ 67))
                               (SPADCALL (QREFELT $ 8) 0 (QREFELT $ 67))
                               (QREFELT $ 69)))
                        (LETT |term| (|spadConstant| $ 70))
                        (SEQ (LETT |k| 1) (LETT #2# |n|) G190
                             (COND ((|greater_SI| |k| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |st| (QREFELT $ 29))
                                 (PROGN (LETT #1# |ress|) (GO #4#)))
                                ('T
                                 (SEQ
                                  (LETT |ress|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |st| (QREFELT $ 31)) |term|
                                          (QREFELT $ 71))
                                         |ress| (QREFELT $ 68)))
                                  (LETT |term|
                                        (SPADCALL |term| |t1| (QREFELT $ 72)))
                                  (EXIT
                                   (LETT |st|
                                         (SPADCALL |st| (QREFELT $ 35)))))))))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT |ress|)))))))
          #4# (EXIT #1#)))) 

(SDEFUN |UTS;coerce;Up$;17|
        ((|p| (|UnivariatePolynomial| |var| |Coef|)) ($ ($)))
        (SPROG
         ((|st| (|Stream| |Coef|)) (#1=#:G792 NIL) (|i| NIL)
          (|oldDeg| (|NonNegativeInteger|)) (#2=#:G791 NIL)
          (|delta| (|NonNegativeInteger|)) (#3=#:G781 NIL)
          (|deg| (|NonNegativeInteger|)))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 74)) (|spadConstant| $ 17))
                ('T
                 (SEQ
                  (COND
                   ((NULL (SPADCALL (QREFELT $ 8) (QREFELT $ 11)))
                    (LETT |p|
                          (SPADCALL |p|
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 12) 1
                                               (QREFELT $ 67))
                                     (SPADCALL (QREFELT $ 8) 0 (QREFELT $ 67))
                                     (QREFELT $ 68))
                                    (QREFELT $ 75)))))
                  (LETT |st| (SPADCALL (QREFELT $ 48)))
                  (LETT |oldDeg| (+ (SPADCALL |p| (QREFELT $ 76)) 1))
                  (SEQ G190
                       (COND
                        ((NULL (NULL (SPADCALL |p| (QREFELT $ 74))))
                         (GO G191)))
                       (SEQ (LETT |deg| (SPADCALL |p| (QREFELT $ 76)))
                            (LETT |delta|
                                  (PROG1 (LETT #3# (- (- |oldDeg| |deg|) 1))
                                    (|check_subtype2| (>= #3# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #3#)))
                            (SEQ (LETT |i| 1) (LETT #2# |delta|) G190
                                 (COND ((|greater_SI| |i| #2#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |st|
                                         (SPADCALL (|spadConstant| $ 16) |st|
                                                   (QREFELT $ 49)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |st|
                                  (SPADCALL (SPADCALL |p| (QREFELT $ 77)) |st|
                                            (QREFELT $ 49)))
                            (LETT |oldDeg| |deg|)
                            (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 78)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (SEQ (LETT |i| 1) (LETT #1# |oldDeg|) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |st|
                               (SPADCALL (|spadConstant| $ 16) |st|
                                         (QREFELT $ 49)))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |st|))))))) 

(SDEFUN |UTS;stToCoef|
        ((|st| (|Stream| |Coef|)) (|term| (|Coef|))
         (|n| (|NonNegativeInteger|)) (|n0| (|NonNegativeInteger|))
         ($ (|Coef|)))
        (COND
         ((OR (> |n| |n0|) (SPADCALL |st| (QREFELT $ 29)))
          (|spadConstant| $ 16))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |st| (QREFELT $ 31))
                     (SPADCALL |term| |n| (QREFELT $ 80)) (QREFELT $ 81))
           (|UTS;stToCoef| (SPADCALL |st| (QREFELT $ 32)) |term| (+ |n| 1) |n0|
            $)
           (QREFELT $ 82))))) 

(SDEFUN |UTS;approximate;$NniCoef;19|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Coef|)))
        (|UTS;stToCoef| (|UTS;stream| |x| $)
         (SPADCALL (SPADCALL (QREFELT $ 7) (QREFELT $ 83)) (QREFELT $ 8)
                   (QREFELT $ 84))
         0 |n| $)) 

(SDEFUN |UTS;variable;$S;20| ((|x| ($)) ($ (|Symbol|))) (QREFELT $ 7)) 

(SDEFUN |UTS;center;$Coef;21| ((|s| ($)) ($ (|Coef|))) (QREFELT $ 8)) 

(SDEFUN |UTS;coefficient;$NniCoef;22|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Coef|)))
        (SPROG ((#1=#:G802 NIL) (|u| ($)))
               (SEQ (LETT |u| (|UTS;stream| |x| $))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((SPADCALL |u| (QREFELT $ 29)) NIL)
                                  ('T (> |n| 0))))
                           (GO G191)))
                         (SEQ (LETT |u| (SPADCALL |u| (QREFELT $ 35)))
                              (EXIT
                               (LETT |n|
                                     (PROG1 (LETT #1# (- |n| 1))
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (COND
                     ((OR (SPADCALL |u| (QREFELT $ 29))
                          (SPADCALL |n| 0 (QREFELT $ 88)))
                      (EXIT (|spadConstant| $ 16))))
                    (EXIT (SPADCALL |u| (QREFELT $ 31)))))) 

(SDEFUN |UTS;elt;$NniCoef;23|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Coef|)))
        (SPADCALL |x| |n| (QREFELT $ 89))) 

(SDEFUN |UTS;map;M2$;24| ((|f| (|Mapping| |Coef| |Coef|)) (|x| ($)) ($ ($)))
        (SPADCALL |f| |x| (QREFELT $ 92))) 

(SDEFUN |UTS;eval;$CoefS;25| ((|x| ($)) (|r| (|Coef|)) ($ (|Stream| |Coef|)))
        (SPADCALL (|UTS;stream| |x| $)
                  (SPADCALL |r| (QREFELT $ 8) (QREFELT $ 84)) (QREFELT $ 94))) 

(SDEFUN |UTS;differentiate;2$;26| ((|x| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (QREFELT $ 96))) 

(SDEFUN |UTS;differentiate;$V$;27| ((|x| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 97))) 

(SDEFUN |UTS;differentiate;$S$;28| ((|x| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPROG NIL
               (COND
                ((EQUAL |s| (SPADCALL |x| (QREFELT $ 86)))
                 (SPADCALL |x| (QREFELT $ 97)))
                ('T
                 (SPADCALL
                  (SPADCALL
                   (CONS #'|UTS;differentiate;$S$;28!0| (VECTOR $ |s|)) |x|
                   (QREFELT $ 93))
                  (SPADCALL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 87)) |s| (QREFELT $ 99))
                   (SPADCALL |x| (QREFELT $ 97)) (QREFELT $ 100))
                  (QREFELT $ 101)))))) 

(SDEFUN |UTS;differentiate;$S$;28!0| ((|y| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| |s| (QREFELT $ 99)))))) 

(SDEFUN |UTS;multiplyCoefficients;M2$;29|
        ((|f| (|Mapping| |Coef| (|Integer|))) (|x| ($)) ($ ($)))
        (SPADCALL |f| (|UTS;stream| |x| $) (QREFELT $ 104))) 

(SDEFUN |UTS;lagrange;2$;30| ((|x| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (QREFELT $ 106))) 

(SDEFUN |UTS;lambert;2$;31| ((|x| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (QREFELT $ 108))) 

(SDEFUN |UTS;oddlambert;2$;32| ((|x| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (QREFELT $ 110))) 

(SDEFUN |UTS;evenlambert;2$;33| ((|x| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (QREFELT $ 112))) 

(SDEFUN |UTS;generalLambert;$2I$;34|
        ((|x| ($)) (|a| (|Integer|)) (|d| (|Integer|)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) |a| |d| (QREFELT $ 114))) 

(SDEFUN |UTS;extend;$Nni$;35| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |x| (+ |n| 1) (QREFELT $ 116))) 

(SDEFUN |UTS;complete;2$;36| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 118))) 

(SDEFUN |UTS;truncate;$Nni$;37|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (+ |n| 1) (QREFELT $ 120))) 

(SDEFUN |UTS;truncate;$2Nni$;38|
        ((|x| ($)) (|n1| #1=(|NonNegativeInteger|)) (|n2| #1#) ($ ($)))
        (SPROG
         ((|st| ($)) (#2=#:G842 NIL) (|i| NIL) (|m| (|NonNegativeInteger|))
          (#3=#:G837 NIL) (|#G84| #1#) (|#G83| #1#))
         (SEQ
          (COND
           ((< |n2| |n1|)
            (PROGN
             (LETT |#G83| |n2|)
             (LETT |#G84| |n1|)
             (LETT |n1| |#G83|)
             (LETT |n2| |#G84|))))
          (LETT |m|
                (PROG1 (LETT #3# (- |n2| |n1|))
                  (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #3#)))
          (LETT |st|
                (SPADCALL (SPADCALL (|UTS;stream| |x| $) |n1| (QREFELT $ 122))
                          (+ |m| 1) (QREFELT $ 120)))
          (SEQ (LETT |i| 1) (LETT #2# |n1|) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (LETT |st|
                       (SPADCALL (|spadConstant| $ 16) |st| (QREFELT $ 47)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |st|)))) 

(SDEFUN |UTS;elt;3$;39| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (|UTS;stream| |y| $) (QREFELT $ 124))) 

(SDEFUN |UTS;revert;2$;40| ((|x| ($)) ($ ($)))
        (SPADCALL (|UTS;stream| |x| $) (QREFELT $ 126))) 

(SDEFUN |UTS;multisect;2I2$;41|
        ((|a| (|Integer|)) (|b| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL |a| |b| (|UTS;stream| |x| $) (QREFELT $ 128))) 

(SDEFUN |UTS;invmultisect;2I2$;42|
        ((|a| (|Integer|)) (|b| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL |a| |b| (|UTS;stream| |x| $) (QREFELT $ 130))) 

(SDEFUN |UTS;multiplyExponents;$Pi$;43|
        ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |n| 0 |x| (QREFELT $ 131))) 

(SDEFUN |UTS;quoByVar;2$;44| ((|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 29)) (|spadConstant| $ 17))
              ('T (SPADCALL |x| (QREFELT $ 35))))) 

(SDEFUN |UTS;unit?;$B;45| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| 0 (QREFELT $ 89)) (QREFELT $ 135))) 

(SDEFUN |UTS;^;$Coef$;46| ((|x| ($)) (|s| (|Coef|)) ($ ($)))
        (SPADCALL |s| (|UTS;stream| |x| $) (QREFELT $ 138))) 

(SDEFUN |UTS;^;$Coef$;47| ((|x| ($)) (|s| (|Coef|)) ($ ($)))
        (SPADCALL |s| (|UTS;stream| |x| $) (QREFELT $ 140))) 

(SDEFUN |UTS;coerce;F$;48| ((|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 141)) (QREFELT $ 23))) 

(SDEFUN |UTS;integrate;2$;49| ((|x| ($)) ($ ($)))
        (SPADCALL (|spadConstant| $ 16) (|UTS;stream| |x| $) (QREFELT $ 143))) 

(SDEFUN |UTS;integrate;$V$;50| ((|x| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 144))) 

(SDEFUN |UTS;integrate;$S$;51| ((|x| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPROG NIL
               (COND
                ((EQUAL |s| (SPADCALL |x| (QREFELT $ 86)))
                 (SPADCALL |x| (QREFELT $ 144)))
                ((NULL
                  (SPADCALL |s|
                            (SPADCALL (SPADCALL |x| (QREFELT $ 87))
                                      (QREFELT $ 147))
                            (QREFELT $ 148)))
                 (SPADCALL (CONS #'|UTS;integrate;$S$;51!0| (VECTOR $ |s|)) |x|
                           (QREFELT $ 93)))
                ('T
                 (|error|
                  "integrate: center is a function of variable of integration"))))) 

(SDEFUN |UTS;integrate;$S$;51!0| ((|y| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| |s| (QREFELT $ 149)))))) 

(SDEFUN |UTS;integrateWithOneAnswer|
        ((|f| (|Coef|)) (|s| (|Symbol|)) ($ (|Coef|)))
        (SPROG ((|res| (|Union| |Coef| (|List| |Coef|))))
               (SEQ (LETT |res| (SPADCALL |f| |s| (QREFELT $ 153)))
                    (EXIT
                     (COND ((QEQCAR |res| 0) (QCDR |res|))
                           ('T (|SPADfirst| (QCDR |res|)))))))) 

(SDEFUN |UTS;integrate;$S$;53| ((|x| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPROG NIL
               (COND
                ((EQUAL |s| (SPADCALL |x| (QREFELT $ 86)))
                 (SPADCALL |x| (QREFELT $ 144)))
                ((NULL
                  (SPADCALL |s|
                            (SPADCALL (SPADCALL |x| (QREFELT $ 87))
                                      (QREFELT $ 147))
                            (QREFELT $ 148)))
                 (SPADCALL (CONS #'|UTS;integrate;$S$;53!0| (VECTOR $ |s|)) |x|
                           (QREFELT $ 93)))
                ('T
                 (|error|
                  "integrate: center is a function of variable of integration"))))) 

(SDEFUN |UTS;integrate;$S$;53!0| ((|y| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTS;integrateWithOneAnswer| |y| |s| $))))) 

(DECLAIM (NOTINLINE |UnivariateTaylorSeries;|)) 

(DEFUN |UnivariateTaylorSeries| (&REST #1=#:G882)
  (SPROG NIL
         (PROG (#2=#:G883)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache| '|UnivariateTaylorSeries|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |UnivariateTaylorSeries;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|UnivariateTaylorSeries|)))))))))) 

(DEFUN |UnivariateTaylorSeries;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G876 NIL) (#2=#:G877 NIL) (#3=#:G878 NIL) (#4=#:G881 NIL)
    ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|UnivariateTaylorSeries| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 162))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #4#
                                            (|HasCategory| |#1|
                                                           '(|IntegralDomain|)))
                                        (|HasSignature| |#1|
                                                        (LIST '*
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|NonNegativeInteger|)
                                                               (|devaluate|
                                                                |#1|))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|NonNegativeInteger|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|SemiGroup|))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|Comparable|))
                                        (|HasSignature| |#1|
                                                        (LIST '^
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|NonNegativeInteger|))))
                                        (AND
                                         (|HasSignature| |#1|
                                                         (LIST '^
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|NonNegativeInteger|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|coerce|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|)))))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SemiRing|)))
                                        (OR #3#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|NonNegativeInteger|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (LETT #2#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR #2#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|NonNegativeInteger|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         #4#
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         #2#
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|NonNegativeInteger|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (|HasCategory| |#1|
                                                       '(|CancellationAbelianMonoid|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         #1#
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|NonNegativeInteger|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (OR #1#
                                            (|HasCategory| |#1|
                                                           '(|CancellationAbelianMonoid|))
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|NonNegativeInteger|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR #1#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|NonNegativeInteger|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|integrate|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|variables|
                                                               (LIST
                                                                '(|List|
                                                                  (|Symbol|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| |#1| '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|UnivariateTaylorSeries|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND (|HasCategory| |#1| '(|IntegralDomain|))
         (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 33554432))
    (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 67108864))
    (AND
     (OR (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 134217728))
    (AND
     (OR (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         #3#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|NonNegativeInteger|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 268435456))
    (AND
     (OR (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         #2#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|NonNegativeInteger|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 536870912))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|NonNegativeInteger|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 1073741824))
    (AND
     (OR (|HasCategory| |#1| '(|CancellationAbelianMonoid|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|NonNegativeInteger|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 2147483648))
    (AND
     (OR #1# (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#1| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|NonNegativeInteger|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 4294967296))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9 (|Stream| |#1|))
    (COND
     ((|HasSignature| |#1|
                      (LIST '|coerce| (LIST (|devaluate| |#1|) '(|Symbol|))))
      (COND
       ((|testBitVector| |pv$| 11)
        (PROGN
         (QSETREFV $ 85
                   (CONS (|dispatchFunction| |UTS;approximate;$NniCoef;19|)
                         $)))))))
    (COND
     ((|HasCategory| |#1| '(|PartialDifferentialRing| (|Symbol|)))
      (QSETREFV $ 102
                (CONS (|dispatchFunction| |UTS;differentiate;$S$;28|) $))))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 136 (CONS (|dispatchFunction| |UTS;unit?;$B;45|) $))))
    (COND
     ((|testBitVector| |pv$| 25)
      (COND
       ((|domainEqual| |#1| (|Fraction| (|Integer|)))
        (QSETREFV $ 139 (CONS (|dispatchFunction| |UTS;^;$Coef$;46|) $)))
       ('T (QSETREFV $ 139 (CONS (|dispatchFunction| |UTS;^;$Coef$;47|) $))))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 142 (CONS (|dispatchFunction| |UTS;coerce;F$;48|) $))
       (QSETREFV $ 144 (CONS (|dispatchFunction| |UTS;integrate;2$;49|) $))
       (QSETREFV $ 145 (CONS (|dispatchFunction| |UTS;integrate;$V$;50|) $))
       (COND
        ((|HasSignature| |#1|
                         (LIST '|integrate|
                               (LIST (|devaluate| |#1|) (|devaluate| |#1|)
                                     '(|Symbol|))))
         (COND
          ((|HasSignature| |#1|
                           (LIST '|variables|
                                 (LIST '(|List| (|Symbol|))
                                       (|devaluate| |#1|))))
           (QSETREFV $ 150
                     (CONS (|dispatchFunction| |UTS;integrate;$S$;51|) $))))))
       (COND
        ((|HasCategory| |#1| '(|TranscendentalFunctionCategory|))
         (COND
          ((|HasCategory| |#1| '(|PrimitiveFunctionCategory|))
           (COND
            ((|HasCategory| |#1|
                            '(|AlgebraicallyClosedFunctionSpace| (|Integer|)))
             (PROGN
              (QSETREFV $ 150
                        (CONS (|dispatchFunction| |UTS;integrate;$S$;53|)
                              $))))))))))))
    $))) 

(MAKEPROP '|UnivariateTaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|InnerTaylorSeries| 6) (|local| |#1|)
              (|local| |#2|) (|local| |#3|) '|Rep| (|Boolean|) (0 . |zero?|)
              (5 . |One|) (9 . |One|) (|NonNegativeInteger|)
              |UTS;monomial;CoefNni$;5| (13 . |Zero|) (17 . |Zero|) (21 . +)
              (|Variable| (NRTEVAL (QREFELT $ 7))) |UTS;coerce;V$;2|
              (|Integer|) (27 . |coerce|) |UTS;coerce;Coef$;4|
              |UTS;coerce;I$;3| (|Stream| 6) (|StreamTaylorSeriesOperations| 6)
              (32 . |coerce|) (37 . |monom|) (43 . |empty?|) (48 . |empty|)
              (52 . |frst|) (57 . |rst|) (62 . |One|) (66 . +) (72 . |rst|)
              (|Record| (|:| |k| 14) (|:| |c| 6)) (|Stream| 36) (77 . |empty|)
              (81 . |concat|) (|Mapping| $) (87 . |delay|) |UTS;terms;$S;10|
              (92 . |empty?|) (97 . |frst|) (102 . =) (108 . |rst|)
              (113 . |concat|) (119 . |empty|) (123 . |concat|) (129 . |delay|)
              |UTS;series;S$;12| (|Polynomial| 6) (134 . |Zero|) (138 . ^)
              (144 . *) (150 . +) (|Symbol|) (156 . |coerce|) (161 . |coerce|)
              (166 . -) |UTS;polynomial;$NniP;14| (172 . |rest|)
              |UTS;polynomial;$2NniP;15|
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 7)) 6) (178 . |Zero|)
              (182 . =) (188 . |monomial|) (194 . +) (200 . -) (206 . |One|)
              (210 . *) (216 . *) |UTS;univariatePolynomial;$NniUp;16|
              (222 . |zero?|) (227 . |elt|) (233 . |degree|)
              (238 . |leadingCoefficient|) (243 . |reductum|)
              |UTS;coerce;Up$;17| (248 . ^) (254 . *) (260 . +)
              (266 . |coerce|) (271 . -) (277 . |approximate|)
              |UTS;variable;$S;20| |UTS;center;$Coef;21| (283 . ~=)
              |UTS;coefficient;$NniCoef;22| |UTS;elt;$NniCoef;23|
              (|Mapping| 6 6) (289 . |map|) |UTS;map;M2$;24| (295 . |eval|)
              |UTS;eval;$CoefS;25| (301 . |deriv|) |UTS;differentiate;2$;26|
              |UTS;differentiate;$V$;27| (306 . |differentiate|) (312 . *)
              (318 . -) (324 . |differentiate|) (|Mapping| 6 21)
              (330 . |gderiv|) |UTS;multiplyCoefficients;M2$;29|
              (336 . |lagrange|) |UTS;lagrange;2$;30| (341 . |lambert|)
              |UTS;lambert;2$;31| (346 . |oddlambert|) |UTS;oddlambert;2$;32|
              (351 . |evenlambert|) |UTS;evenlambert;2$;33|
              (356 . |generalLambert|) |UTS;generalLambert;$2I$;34|
              (363 . |extend|) |UTS;extend;$Nni$;35| (369 . |complete|)
              |UTS;complete;2$;36| (374 . |first|) |UTS;truncate;$Nni$;37|
              (380 . |rest|) |UTS;truncate;$2Nni$;38| (386 . |compose|)
              |UTS;elt;3$;39| (392 . |revert|) |UTS;revert;2$;40|
              (397 . |multisect|) |UTS;multisect;2I2$;41|
              (404 . |invmultisect|) |UTS;invmultisect;2I2$;42|
              (|PositiveInteger|) |UTS;multiplyExponents;$Pi$;43|
              |UTS;quoByVar;2$;44| (411 . |unit?|) (416 . |unit?|)
              (|Fraction| 21) (421 . |powern|) (427 . ^) (433 . |power|)
              (439 . |coerce|) (444 . |coerce|) (449 . |integrate|)
              (455 . |integrate|) (460 . |integrate|) (|List| 57)
              (466 . |variables|) (471 . |entry?|) (477 . |integrate|)
              (483 . |integrate|) (|Union| 6 (|List| 6))
              (|FunctionSpaceIntegration| 21 6) (489 . |integrate|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Union| $ '"failed") (|List| 14) (|List| 36) (|String|)
              (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#(~= 495 |zero?| 501 |variable| 506 |univariatePolynomial| 511
              |unitNormal| 517 |unitCanonical| 522 |unit?| 527 |truncate| 532
              |terms| 545 |tanh| 550 |tan| 555 |subtractIfCan| 560 |sqrt| 566
              |sinh| 571 |sin| 576 |series| 581 |sech| 591 |sec| 596 |sample|
              601 |rightRecip| 605 |rightPower| 610 |revert| 622 |reductum| 627
              |recip| 632 |quoByVar| 637 |polynomial| 642 |pole?| 655 |pi| 660
              |order| 664 |opposite?| 675 |one?| 681 |oddlambert| 686 |nthRoot|
              691 |multisect| 697 |multiplyExponents| 704
              |multiplyCoefficients| 710 |monomial?| 716 |monomial| 721 |map|
              727 |log| 733 |leftRecip| 738 |leftPower| 743 |leadingTerm| 755
              |leadingSupport| 760 |leadingMonomial| 765 |leadingCoefficient|
              770 |latex| 775 |lambert| 780 |lagrange| 785 |invmultisect| 790
              |integrate| 797 |hashUpdate!| 814 |hash| 820 |generalLambert| 825
              |extend| 832 |exquo| 838 |exp| 844 |evenlambert| 849 |eval| 854
              |elt| 860 |differentiate| 872 |degree| 915 |csch| 920 |csc| 925
              |coth| 930 |cot| 935 |cosh| 940 |cos| 945 |constructOrdered| 950
              |construct| 955 |complete| 960 |commutator| 965 |coerce| 971
              |coefficients| 1006 |coefficient| 1011 |charthRoot| 1017
              |characteristic| 1022 |center| 1026 |atanh| 1031 |atan| 1036
              |associator| 1041 |associates?| 1048 |asinh| 1054 |asin| 1059
              |asech| 1064 |asec| 1069 |approximate| 1074 |antiCommutator| 1080
              |annihilate?| 1086 |acsch| 1092 |acsc| 1097 |acoth| 1102 |acot|
              1107 |acosh| 1112 |acos| 1117 ^ 1122 |Zero| 1152 |One| 1156 D
              1160 = 1197 / 1203 - 1209 + 1220 * 1226)
           'NIL
           (CONS
            (|makeByteWordVec2| 23
                                '(0 0 0 0 0 2 6 1 6 2 3 4 5 8 7 17 14 17 0 1 6
                                  5 0 0 0 1 16 0 0 0 0 0 1 1 17 23 22 14 14 0 0
                                  21 14 0 0 0 6 1 0 0 0 6 2 16 9 1 1 1 1 1 1))
            (CONS
             '#(|UnivariateTaylorSeriesCategory&| NIL
                |UnivariatePowerSeriesCategory&| |PowerSeriesCategory&|
                |AbelianMonoidRing&| NIL NIL |Algebra&| |Algebra&|
                |EntireRing&| NIL NIL |Algebra&| |PartialDifferentialRing&|
                |DifferentialRing&| NIL NIL |Rng&| NIL |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |Magma&| |AbelianSemiGroup&| |SetCategory&| NIL
                |TranscendentalFunctionCategory&| NIL |BasicType&| NIL NIL NIL
                NIL NIL |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                |RadicalCategory&|)
             (CONS
              '#((|UnivariateTaylorSeriesCategory| 6)
                 (|UnivariateSeriesWithRationalExponents| 6 14)
                 (|UnivariatePowerSeriesCategory| 6 14)
                 (|PowerSeriesCategory| 6 14 (|SingletonAsOrderedSet|))
                 (|AbelianMonoidRing| 6 14) (|IntegralDomain|)
                 (|CommutativeRing|) (|Algebra| 137) (|Algebra| $$)
                 (|EntireRing|) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6)
                 (|PartialDifferentialRing| 57) (|DifferentialRing|) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 137) (|Module| $$)
                 (|Module| 6) (|IndexedProductCategory| 6 14) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 137 137) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 137) (|RightModule| 137) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|Magma|) (|AbelianSemiGroup|)
                 (|SetCategory|) (|CommutativeStar|)
                 (|TranscendentalFunctionCategory|)
                 (|VariablesCommuteWithCoefficients|) (|BasicType|)
                 (|CoercibleTo| 161) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|unitsKnown|) (|Eltable| $$ $$)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|))
              (|makeByteWordVec2| 161
                                  '(1 6 10 0 11 0 6 0 12 0 0 0 13 0 6 0 16 0 0
                                    0 17 2 0 0 0 0 18 1 6 0 21 22 1 26 25 6 27
                                    2 26 25 6 21 28 1 9 10 0 29 0 9 0 30 1 9 6
                                    0 31 1 25 0 0 32 0 14 0 33 2 14 0 0 0 34 1
                                    9 0 0 35 0 37 0 38 2 37 0 36 0 39 1 37 0 40
                                    41 1 37 10 0 43 1 37 36 0 44 2 14 10 0 0 45
                                    1 37 0 0 46 2 9 0 6 0 47 0 25 0 48 2 25 0 6
                                    0 49 1 25 0 40 50 0 52 0 53 2 52 0 0 14 54
                                    2 52 0 6 0 55 2 52 0 0 0 56 1 52 0 57 58 1
                                    52 0 6 59 2 52 0 0 0 60 2 25 0 0 14 62 0 64
                                    0 65 2 6 10 0 0 66 2 64 0 6 14 67 2 64 0 0
                                    0 68 2 64 0 0 0 69 0 64 0 70 2 64 0 6 0 71
                                    2 64 0 0 0 72 1 64 10 0 74 2 64 0 0 0 75 1
                                    64 14 0 76 1 64 6 0 77 1 64 0 0 78 2 6 0 0
                                    14 80 2 6 0 0 0 81 2 6 0 0 0 82 1 6 0 57 83
                                    2 6 0 0 0 84 2 0 6 0 14 85 2 14 10 0 0 88 2
                                    9 0 91 0 92 2 26 25 25 6 94 1 26 25 25 96 2
                                    6 0 0 57 99 2 0 0 6 0 100 2 0 0 0 0 101 2 0
                                    0 0 57 102 2 26 25 103 25 104 1 26 25 25
                                    106 1 26 25 25 108 1 26 25 25 110 1 26 25
                                    25 112 3 26 25 25 21 21 114 2 9 0 0 21 116
                                    1 9 0 0 118 2 9 0 0 14 120 2 9 0 0 14 122 2
                                    26 25 25 25 124 1 26 25 25 126 3 26 25 21
                                    21 25 128 3 26 25 21 21 25 130 1 6 10 0 135
                                    1 0 10 0 136 2 26 25 137 25 138 2 0 0 0 6
                                    139 2 26 25 6 25 140 1 6 0 137 141 1 0 0
                                    137 142 2 26 25 6 25 143 1 0 0 0 144 2 0 0
                                    0 19 145 1 6 146 0 147 2 146 10 57 0 148 2
                                    6 0 0 57 149 2 0 0 0 57 150 2 152 151 6 57
                                    153 2 0 10 0 0 1 1 31 10 0 1 1 0 57 0 86 2
                                    0 64 0 14 73 1 26 154 0 1 1 26 0 0 1 1 26
                                    10 0 136 2 0 0 0 14 121 3 0 0 0 14 14 123 1
                                    0 37 0 42 1 1 0 0 1 1 1 0 0 1 2 32 155 0 0
                                    1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 0 0 25 1
                                    1 0 0 37 51 1 1 0 0 1 1 1 0 0 1 0 31 0 1 1
                                    29 155 0 1 2 29 0 0 14 1 2 0 0 0 132 1 1 0
                                    0 0 127 1 10 0 0 1 1 29 155 0 1 1 0 0 0 134
                                    3 0 52 0 14 14 63 2 0 52 0 14 61 1 0 10 0 1
                                    0 1 0 1 2 0 14 0 14 1 1 0 14 0 1 2 31 10 0
                                    0 1 1 29 10 0 1 1 0 0 0 111 2 1 0 0 21 1 3
                                    0 0 21 21 0 129 2 0 0 0 132 133 2 0 0 103 0
                                    105 1 0 10 0 1 2 0 0 6 14 15 2 0 0 91 0 93
                                    1 1 0 0 1 1 29 155 0 1 2 29 0 0 14 1 2 0 0
                                    0 132 1 1 10 36 0 1 1 10 14 0 1 1 0 0 0 1 1
                                    0 6 0 1 1 0 158 0 1 1 0 0 0 109 1 0 0 0 107
                                    3 0 0 21 21 0 131 2 24 0 0 57 150 2 1 0 0
                                    19 145 1 1 0 0 144 2 0 160 160 0 1 1 0 159
                                    0 1 3 0 0 0 21 21 115 2 0 0 0 14 117 2 26
                                    155 0 0 1 1 1 0 0 1 1 0 0 0 113 2 11 25 0 6
                                    95 2 9 0 0 0 125 2 0 6 0 14 90 2 8 0 0 146
                                    1 2 8 0 0 57 102 3 8 0 0 146 156 1 3 8 0 0
                                    57 14 1 1 7 0 0 97 2 7 0 0 14 1 2 0 0 0 19
                                    98 1 0 14 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1
                                    1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 10 0 157 1
                                    1 0 0 157 1 1 0 0 0 119 2 30 0 0 0 1 1 27 0
                                    6 23 1 30 0 21 24 1 28 0 0 1 1 1 0 137 142
                                    1 0 0 19 20 1 0 0 64 79 1 0 161 0 1 1 0 25
                                    0 1 2 0 6 0 14 89 1 3 155 0 1 0 30 14 1 1 0
                                    6 0 87 1 1 0 0 1 1 1 0 0 1 3 30 0 0 0 0 1 2
                                    26 10 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1
                                    1 0 0 1 2 12 6 0 14 85 2 0 0 0 0 1 2 30 10
                                    0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0
                                    1 1 1 0 0 1 1 1 0 0 1 2 29 0 0 14 1 2 1 0 0
                                    137 1 2 1 0 0 0 1 2 25 0 0 6 139 2 0 0 0
                                    132 1 0 31 0 17 0 29 0 13 2 8 0 0 57 1 3 8
                                    0 0 57 14 1 2 8 0 0 146 1 3 8 0 0 146 156 1
                                    1 7 0 0 1 2 7 0 0 14 1 2 0 10 0 0 1 2 25 0
                                    0 6 1 2 33 0 0 0 101 1 33 0 0 1 2 0 0 0 0
                                    18 2 33 0 21 0 1 2 31 0 14 0 1 2 1 0 137 0
                                    1 2 1 0 0 137 1 2 0 0 6 0 100 2 0 0 0 6 1 2
                                    0 0 0 0 1 2 0 0 132 0 1)))))
           '|lookupComplete|)) 
