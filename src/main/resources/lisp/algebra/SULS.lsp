
(SDEFUN |SULS;variable;$S;1| ((|x| ($)) ($ (|Symbol|))) (QREFELT $ 7)) 

(SDEFUN |SULS;center;$Coef;2| ((|x| ($)) ($ (|Coef|))) (QREFELT $ 8)) 

(SDEFUN |SULS;coerce;V$;3| ((|v| (|Variable| |var|)) ($ ($)))
        (COND
         ((SPADCALL (QREFELT $ 8) (QREFELT $ 14))
          (SPADCALL (|spadConstant| $ 15) 1 (QREFELT $ 18)))
         ('T
          (SPADCALL (SPADCALL (|spadConstant| $ 15) 1 (QREFELT $ 18))
                    (SPADCALL (QREFELT $ 8) 0 (QREFELT $ 18)) (QREFELT $ 21))))) 

(SDEFUN |SULS;pole?;$B;4| ((|x| ($)) ($ (|Boolean|)))
        (MINUSP (SPADCALL |x| 0 (QREFELT $ 24)))) 

(PUT '|SULS;coerce;Suts$;5| '|SPADreplace| '(XLAM (|uts|) |uts|)) 

(SDEFUN |SULS;coerce;Suts$;5|
        ((|uts| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)) ($ ($)))
        |uts|) 

(SDEFUN |SULS;taylorIfCan;$U;6|
        ((|uls| ($))
         ($
          (|Union| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)
                   "failed")))
        (COND ((SPADCALL |uls| (QREFELT $ 25)) (CONS 1 "failed"))
              ('T (CONS 0 |uls|)))) 

(SDEFUN |SULS;taylor;$Suts;7|
        ((|uls| ($)) ($ (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)))
        (SPROG
         ((|uts|
           (|Union| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)
                    "failed")))
         (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 29)))
              (EXIT
               (COND
                ((QEQCAR |uts| 1)
                 (|error| "taylor: Laurent series has a pole"))
                ('T (QCDR |uts|))))))) 

(SDEFUN |SULS;retractIfCan;$U;8|
        ((|x| ($))
         ($
          (|Union| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)
                   "failed")))
        (SPADCALL |x| (QREFELT $ 29))) 

(SDEFUN |SULS;laurent;ISuts$;9|
        ((|n| (|Integer|))
         (|uts| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)) ($ ($)))
        (SPADCALL (SPADCALL (|spadConstant| $ 15) |n| (QREFELT $ 18))
                  (SPADCALL |uts| (QREFELT $ 27)) (QREFELT $ 32))) 

(PUT '|SULS;removeZeroes;2$;10| '|SPADreplace| '(XLAM (|uls|) |uls|)) 

(SDEFUN |SULS;removeZeroes;2$;10| ((|uls| ($)) ($ ($))) |uls|) 

(PUT '|SULS;removeZeroes;I2$;11| '|SPADreplace| '(XLAM (|n| |uls|) |uls|)) 

(SDEFUN |SULS;removeZeroes;I2$;11| ((|n| (|Integer|)) (|uls| ($)) ($ ($)))
        |uls|) 

(SDEFUN |SULS;taylorRep;$Suts;12|
        ((|uls| ($)) ($ (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (|spadConstant| $ 15) (- (SPADCALL |uls| 0 (QREFELT $ 24)))
                    (QREFELT $ 18))
          |uls| (QREFELT $ 32))
         (QREFELT $ 30))) 

(SDEFUN |SULS;degree;$I;13| ((|uls| ($)) ($ (|Integer|)))
        (SPADCALL |uls| 0 (QREFELT $ 24))) 

(SDEFUN |SULS;numer;$Suts;14|
        ((|uls| ($)) ($ (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)))
        (SPADCALL |uls| (QREFELT $ 36))) 

(SDEFUN |SULS;denom;$Suts;15|
        ((|uls| ($)) ($ (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)))
        (SPROG ((#1=#:G735 NIL))
               (SPADCALL (|spadConstant| $ 15)
                         (PROG1
                             (LETT #1# (- (SPADCALL |uls| 0 (QREFELT $ 24))))
                           (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #1#))
                         (QREFELT $ 40)))) 

(SDEFUN |SULS;*;Suts2$;16|
        ((|uts| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|))
         (|uls| ($)) ($ ($)))
        (SPADCALL (SPADCALL |uts| (QREFELT $ 27)) |uls| (QREFELT $ 32))) 

(SDEFUN |SULS;*;$Suts$;17|
        ((|uls| ($))
         (|uts| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|)) ($ ($)))
        (SPADCALL |uls| (SPADCALL |uts| (QREFELT $ 27)) (QREFELT $ 32))) 

(SDEFUN |SULS;/;2Suts$;18|
        ((|uts1| #1=(|SparseUnivariateTaylorSeries| |Coef| |var| |cen|))
         (|uts2| #1#) ($ ($)))
        (SPADCALL (SPADCALL |uts1| (QREFELT $ 27))
                  (SPADCALL |uts2| (QREFELT $ 27)) (QREFELT $ 44))) 

(SDEFUN |SULS;recip;$U;19| ((|uls| ($)) ($ (|Union| $ "failed")))
        (SPADCALL (|spadConstant| $ 16) |uls| NIL (QREFELT $ 47))) 

(SDEFUN |SULS;exquo;2$U;20|
        ((|uls1| ($)) (|uls2| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |uls1| |uls2| NIL (QREFELT $ 47))) 

(SDEFUN |SULS;/;3$;21| ((|uls1| ($)) (|uls2| ($)) ($ ($)))
        (SPROG ((|q| (|Union| $ "failed")))
               (SEQ (LETT |q| (SPADCALL |uls1| |uls2| (QREFELT $ 49)))
                    (EXIT
                     (COND
                      ((QEQCAR |q| 1) (|error| "quotient cannot be computed"))
                      ('T (QCDR |q|))))))) 

(SDEFUN |SULS;differentiate;$V$;22|
        ((|uls| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 50))) 

(SDEFUN |SULS;elt;3$;23| ((|uls1| ($)) (|uls2| ($)) ($ ($)))
        (SPROG
         ((#1=#:G766 NIL) (|uls3| ($)) (|recipr| (|Union| $ "failed"))
          (|ord| (|Integer|)))
         (SEQ
          (COND
           ((< (SPADCALL |uls2| 1 (QREFELT $ 24)) 1)
            (|error| "elt: second argument must have positive order"))
           ((MINUSP (LETT |ord| (SPADCALL |uls1| 0 (QREFELT $ 24))))
            (SEQ (LETT |recipr| (SPADCALL |uls2| (QREFELT $ 48)))
                 (EXIT
                  (COND
                   ((QEQCAR |recipr| 1)
                    (|error| "elt: second argument not invertible"))
                   (#2='T
                    (SEQ
                     (LETT |uls3|
                           (SPADCALL |uls1|
                                     (SPADCALL (|spadConstant| $ 15) (- |ord|)
                                               (QREFELT $ 18))
                                     (QREFELT $ 32)))
                     (EXIT
                      (SPADCALL (SPADCALL |uls3| |uls2| (QREFELT $ 52))
                                (SPADCALL (QCDR |recipr|)
                                          (PROG1 (LETT #1# (- |ord|))
                                            (|check_subtype2| (>= #1# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #1#))
                                          (QREFELT $ 53))
                                (QREFELT $ 32)))))))))
           (#2# (SPADCALL |uls1| |uls2| (QREFELT $ 52))))))) 

(SDEFUN |SULS;rationalFunction;$IF;24|
        ((|uls| ($)) (|n| (|Integer|)) ($ (|Fraction| (|Polynomial| |Coef|))))
        (SPROG
         ((#1=#:G780 NIL) (|c| (|Fraction| (|Polynomial| |Coef|)))
          (|v| (|Fraction| (|Polynomial| |Coef|)))
          (|poly| (|Fraction| (|Polynomial| |Coef|))) (#2=#:G779 NIL)
          (|m| (|Integer|)) (#3=#:G776 NIL) (|e| (|Integer|)))
         (SEQ
          (COND
           ((ZEROP (LETT |e| (SPADCALL |uls| 0 (QREFELT $ 24))))
            (COND ((MINUSP |n|) (|spadConstant| $ 56))
                  (#4='T
                   (SPADCALL
                    (SPADCALL (SPADCALL |uls| (QREFELT $ 30))
                              (PROG1 (LETT #3# |n|)
                                (|check_subtype2| (>= #3# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #3#))
                              (QREFELT $ 58))
                    (QREFELT $ 59)))))
           ((MINUSP (LETT |m| (- |n| |e|))) (|spadConstant| $ 56))
           (#4#
            (SEQ
             (LETT |poly|
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 15) (- |e|) (QREFELT $ 18))
                       |uls| (QREFELT $ 32))
                      (QREFELT $ 30))
                     (PROG1 (LETT #2# |m|)
                       (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #2#))
                     (QREFELT $ 58))
                    (QREFELT $ 59)))
             (LETT |v|
                   (SPADCALL (SPADCALL |uls| (QREFELT $ 11)) (QREFELT $ 60)))
             (LETT |c|
                   (SPADCALL
                    (SPADCALL (SPADCALL |uls| (QREFELT $ 12)) (QREFELT $ 61))
                    (QREFELT $ 59)))
             (EXIT
              (SPADCALL |poly|
                        (SPADCALL (SPADCALL |v| |c| (QREFELT $ 62))
                                  (PROG1 (LETT #1# (- |e|))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  (QREFELT $ 63))
                        (QREFELT $ 64))))))))) 

(SDEFUN |SULS;rationalFunction;$2IF;25|
        ((|uls| ($)) (|n1| #1=(|Integer|)) (|n2| #1#)
         ($ (|Fraction| (|Polynomial| |Coef|))))
        (SPADCALL (SPADCALL |uls| |n1| |n2| (QREFELT $ 66)) |n2|
                  (QREFELT $ 65))) 

(SDEFUN |SULS;integrate;2$;26| ((|uls| ($)) ($ ($)))
        (COND
         ((SPADCALL (SPADCALL |uls| -1 (QREFELT $ 68)) (QREFELT $ 14))
          (|error| "integrate: series has term of order -1"))
         ('T (SPADCALL |uls| (QREFELT $ 69))))) 

(SDEFUN |SULS;integrate;$V$;27| ((|uls| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 70))) 

(SDEFUN |SULS;^;3$;28| ((|uls1| ($)) (|uls2| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |uls1| (QREFELT $ 72)) |uls2| (QREFELT $ 32))
         (QREFELT $ 73))) 

(SDEFUN |SULS;exp;2$;29| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 76))) 

(SDEFUN |SULS;log;2$;30| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 77))) 

(SDEFUN |SULS;sin;2$;31| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 78))) 

(SDEFUN |SULS;cos;2$;32| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 80))) 

(SDEFUN |SULS;tan;2$;33| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 82))) 

(SDEFUN |SULS;cot;2$;34| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 84))) 

(SDEFUN |SULS;sec;2$;35| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 86))) 

(SDEFUN |SULS;csc;2$;36| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 88))) 

(SDEFUN |SULS;asin;2$;37| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 90))) 

(SDEFUN |SULS;acos;2$;38| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 92))) 

(SDEFUN |SULS;atan;2$;39| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 94))) 

(SDEFUN |SULS;acot;2$;40| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 96))) 

(SDEFUN |SULS;asec;2$;41| ((|uls| ($)) ($ ($))) (SPADCALL |uls| (QREFELT $ 98))) 

(SDEFUN |SULS;acsc;2$;42| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 100))) 

(SDEFUN |SULS;sinh;2$;43| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 102))) 

(SDEFUN |SULS;cosh;2$;44| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 104))) 

(SDEFUN |SULS;tanh;2$;45| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 106))) 

(SDEFUN |SULS;coth;2$;46| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 108))) 

(SDEFUN |SULS;sech;2$;47| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 110))) 

(SDEFUN |SULS;csch;2$;48| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 112))) 

(SDEFUN |SULS;asinh;2$;49| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 114))) 

(SDEFUN |SULS;acosh;2$;50| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 116))) 

(SDEFUN |SULS;atanh;2$;51| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 118))) 

(SDEFUN |SULS;acoth;2$;52| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 120))) 

(SDEFUN |SULS;asech;2$;53| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 122))) 

(SDEFUN |SULS;acsch;2$;54| ((|uls| ($)) ($ ($)))
        (SPADCALL |uls| (QREFELT $ 124))) 

(SDEFUN |SULS;^;$F$;55| ((|uls| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL |uls| |r| (QREFELT $ 127))) 

(SDEFUN |SULS;^;$F$;56| ((|uls| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPROG
         ((|uts| (|SparseUnivariateTaylorSeries| |Coef| |var| |cen|))
          (|utsPow| ($)) (|n| (|Union| (|Integer|) "failed"))
          (|order| #1=(|Integer|)) (|ord0| #1#))
         (SEQ
          (COND
           ((MINUSP (LETT |ord0| (SPADCALL |uls| 0 (QREFELT $ 24))))
            (SEQ (LETT |order| |ord0|)
                 (LETT |n|
                       (SPADCALL |order| (SPADCALL |r| (QREFELT $ 129))
                                 (QREFELT $ 130)))
                 (EXIT
                  (COND
                   ((QEQCAR |n| 1)
                    (|error| "^: rational power does not exist"))
                   (#2='T
                    (SEQ
                     (LETT |uts|
                           (SPADCALL
                            (SPADCALL |uls|
                                      (SPADCALL (|spadConstant| $ 15)
                                                (- |order|) (QREFELT $ 18))
                                      (QREFELT $ 32))
                            (QREFELT $ 131)))
                     (LETT |utsPow|
                           (SPADCALL (SPADCALL |uts| |r| (QREFELT $ 132))
                                     (QREFELT $ 27)))
                     (EXIT
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 15)
                                 (* (QCDR |n|) (SPADCALL |r| (QREFELT $ 133)))
                                 (QREFELT $ 18))
                       |utsPow| (QREFELT $ 32)))))))))
           (#2#
            (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 131)))
                 (EXIT
                  (SPADCALL (SPADCALL |uts| |r| (QREFELT $ 132))
                            (QREFELT $ 27))))))))) 

(SDEFUN |SULS;coerce;$Of;57| ((|uls| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|degr| (|Integer|)) (#1=#:G826 NIL) (|count| (|NonNegativeInteger|))
          (|nx| (|Union| (|Integer|) "failed"))
          (|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ (LETT |st| (SPADCALL |uls| (QREFELT $ 136)))
              (COND
               ((NULL (SPADCALL |st| (QREFELT $ 137)))
                (COND
                 ((NULL (SPADCALL |st| (QREFELT $ 138)))
                  (COND
                   ((QEQCAR
                     (LETT |nx|
                           (SPADCALL
                            (SPADCALL (SPADCALL |uls| (QREFELT $ 140))
                                      (QREFELT $ 142))
                            (QREFELT $ 144)))
                     0)
                    (SEQ (LETT |count| |$streamCount|)
                         (LETT |degr|
                               (MIN |count|
                                    (+
                                     (+
                                      (PROG2 (LETT #1# |nx|)
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (|Integer|)
                                                        (|Union| (|Integer|)
                                                                 "failed")
                                                        #1#))
                                      |count|)
                                     1)))
                         (EXIT (SPADCALL |uls| |degr| (QREFELT $ 145))))))))))
              (EXIT
               (SPADCALL |st| (SPADCALL |uls| (QREFELT $ 140))
                         (SPADCALL |uls| (QREFELT $ 11))
                         (SPADCALL |uls| (QREFELT $ 12)) (|spadConstant| $ 146)
                         (QREFELT $ 148)))))) 

(DECLAIM (NOTINLINE |SparseUnivariateLaurentSeries;|)) 

(DEFUN |SparseUnivariateLaurentSeries| (&REST #1=#:G899)
  (SPROG NIL
         (PROG (#2=#:G900)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache|
                           '|SparseUnivariateLaurentSeries|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |SparseUnivariateLaurentSeries;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseUnivariateLaurentSeries|)))))))))) 

(DEFUN |SparseUnivariateLaurentSeries;| (|#1| |#2| |#3|)
  (SPROG
   ((#1=#:G898 NIL) (|pv$| NIL) (#2=#:G887 NIL) (#3=#:G888 NIL) (#4=#:G889 NIL)
    (#5=#:G891 NIL) (#6=#:G892 NIL) (#7=#:G893 NIL) (#8=#:G894 NIL)
    (#9=#:G896 NIL) (#10=#:G897 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|SparseUnivariateLaurentSeries| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 194))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| (|Integer|)
                                                       '(|SemiGroup|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|RetractableTo| (|Symbol|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|ConvertibleTo|
                                                (|InputForm|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|RealConstant|)))
                                        (LETT #10#
                                              (AND
                                               (|HasCategory| |#1| '(|Field|))
                                               (|HasCategory|
                                                (|SparseUnivariateTaylorSeries|
                                                 |#1| |#2| |#3|)
                                                '(|OrderedIntegralDomain|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory|
                                               (|SparseUnivariateTaylorSeries|
                                                |#1| |#2| |#3|)
                                               '(|CharacteristicZero|)))
                                         #10#)
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|RetractableTo| (|Integer|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|StepThrough|)))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              (LIST '|InnerEvalable|
                                                    '(|Symbol|)
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              (LIST '|Evalable|
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              (LIST '|Eltable|
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|))
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|LinearlyExplicitOver|
                                                (|Integer|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|ConvertibleTo|
                                                (|Pattern| (|Float|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|ConvertibleTo|
                                                (|Pattern| (|Integer|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|PatternMatchable| (|Float|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|PatternMatchable|
                                                (|Integer|))))
                                        (|HasCategory| (|Integer|)
                                                       '(|Comparable|))
                                        (LETT #9#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #9#
                                            (|HasCategory| |#1| '(|Field|)))
                                        (|HasSignature| |#1|
                                                        (LIST '^
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Integer|))))
                                        (AND
                                         (|HasSignature| |#1|
                                                         (LIST '^
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|coerce|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|)))))
                                        (LETT #8#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR #9# (|HasCategory| |#1| '(|Field|))
                                            #8#)
                                        (OR (|HasCategory| |#1| '(|Field|))
                                            #8#)
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|Comparable|)))
                                        (LETT #7#
                                              (AND
                                               (|HasCategory| |#1| '(|Field|))
                                               (|HasCategory|
                                                (|SparseUnivariateTaylorSeries|
                                                 |#1| |#2| |#3|)
                                                '(|OrderedSet|))))
                                        (OR #10# #7#)
                                        (OR
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory|
                                               (|SparseUnivariateTaylorSeries|
                                                |#1| |#2| |#3|)
                                               '(|Comparable|)))
                                         #10# #7#)
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (LETT #6#
                                              (|HasCategory|
                                               (|SparseUnivariateTaylorSeries|
                                                |#1| |#2| |#3|)
                                               '(|PolynomialFactorizationExplicit|)))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             #6#)
                                        (LETT #5#
                                              (|HasCategory|
                                               (|SparseUnivariateTaylorSeries|
                                                |#1| |#2| |#3|)
                                               '(|CharacteristicNonZero|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              #5#))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|IntegerNumberSystem|)))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|EuclideanDomain|)))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (|HasSignature| |#1|
                                                        (LIST '*
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Integer|)
                                                               (|devaluate|
                                                                |#1|))))
                                        (OR (|HasCategory| |#1| '(|SemiRing|))
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasSignature| |#1|
                                                          (LIST '*
                                                                (LIST
                                                                 (|devaluate|
                                                                  |#1|)
                                                                 '(|Integer|)
                                                                 (|devaluate|
                                                                  |#1|)))))
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory|
                                               (|SparseUnivariateTaylorSeries|
                                                |#1| |#2| |#3|)
                                               '(|PartialDifferentialRing|
                                                 (|Symbol|)))))
                                        (OR
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory|
                                               (|SparseUnivariateTaylorSeries|
                                                |#1| |#2| |#3|)
                                               '(|DifferentialRing|)))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (LETT #4#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR #4#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (|HasCategory| |#1|
                                                       '(|CancellationAbelianMonoid|))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|)))
                                        (OR #3#
                                            (|HasCategory| |#1|
                                                           '(|CancellationAbelianMonoid|))
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR #3#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|)))))
                                        (OR #2#
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|ConvertibleTo|
                                                (|Pattern| (|Float|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|ConvertibleTo|
                                                (|Pattern| (|Integer|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|ConvertibleTo|
                                                (|InputForm|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              (LIST '|Eltable|
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|))
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              (LIST '|Evalable|
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              (LIST '|InnerEvalable|
                                                    '(|Symbol|)
                                                    (LIST
                                                     '|SparseUnivariateTaylorSeries|
                                                     (|devaluate| |#1|)
                                                     (|devaluate| |#2|)
                                                     (|devaluate| |#3|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|LinearlyExplicitOver|
                                                (|Integer|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|PatternMatchable| (|Float|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|PatternMatchable|
                                                (|Integer|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|RetractableTo| (|Integer|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|RetractableTo| (|Symbol|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|Comparable|)))
                                            #10# #7#
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             #6#)
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|RealConstant|)))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory|
                                              (|SparseUnivariateTaylorSeries|
                                               |#1| |#2| |#3|)
                                              '(|StepThrough|))))
                                        (OR
                                         (AND #2#
                                              (|HasCategory|
                                               (|Fraction| (|Integer|))
                                               '(|AbelianMonoid|)))
                                         #3#
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (OR #2#
                                            (|HasCategory| |#1|
                                                           '(|CharacteristicNonZero|))
                                            (|HasCategory| |#1|
                                                           '(|CharacteristicZero|))
                                            #9# (|HasCategory| |#1| '(|Field|))
                                            #8# #4#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (AND #2#
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
                                                                     |#1|)))))))))
    (|haddProp| |$ConstructorCache| '|SparseUnivariateLaurentSeries|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 9007199254740992))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|Field|))
                (|HasCategory| $ '(|CharacteristicNonZero|))
                (|HasCategory| (|SparseUnivariateTaylorSeries| |#1| |#2| |#3|)
                               '(|PolynomialFactorizationExplicit|))))
     (|augmentPredVector| $ 18014398509481984))
    (AND
     (OR (|HasCategory| |#1| '(|CharacteristicNonZero|)) #1#
         (AND (|HasCategory| |#1| '(|Field|)) #5#))
     (|augmentPredVector| $ 36028797018963968))
    (AND
     (OR (|HasCategory| |#1| '(|Field|))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 72057594037927936))
    (AND
     (OR (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|Field|))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 144115188075855872))
    (AND
     (OR (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|SemiRing|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 288230376151711744))
    (AND
     (OR (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #4#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 576460752303423488))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 1152921504606846976))
    (AND
     (OR (|HasCategory| |#1| '(|CancellationAbelianMonoid|))
         (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 2305843009213693952))
    (AND
     (OR #3# (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 4611686018427387904))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9 (|InnerSparseUnivariatePowerSeries| |#1|))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 45 (CONS (|dispatchFunction| |SULS;/;2Suts$;18|) $))))
    (COND
     ((|testBitVector| |pv$| 23)
      (QSETREFV $ 49 (CONS (|dispatchFunction| |SULS;exquo;2$U;20|) $))))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 44 (CONS (|dispatchFunction| |SULS;/;3$;21|) $))))
    (COND
     ((|testBitVector| |pv$| 23)
      (PROGN
       (QSETREFV $ 65
                 (CONS (|dispatchFunction| |SULS;rationalFunction;$IF;24|) $))
       (QSETREFV $ 67
                 (CONS (|dispatchFunction| |SULS;rationalFunction;$2IF;25|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 49)
      (PROGN
       (QSETREFV $ 70 (CONS (|dispatchFunction| |SULS;integrate;2$;26|) $))
       (QSETREFV $ 71 (CONS (|dispatchFunction| |SULS;integrate;$V$;27|) $))
       (QSETREFV $ 74 (CONS (|dispatchFunction| |SULS;^;3$;28|) $))
       (QSETREFV $ 73 (CONS (|dispatchFunction| |SULS;exp;2$;29|) $))
       (QSETREFV $ 72 (CONS (|dispatchFunction| |SULS;log;2$;30|) $))
       (QSETREFV $ 79 (CONS (|dispatchFunction| |SULS;sin;2$;31|) $))
       (QSETREFV $ 81 (CONS (|dispatchFunction| |SULS;cos;2$;32|) $))
       (QSETREFV $ 83 (CONS (|dispatchFunction| |SULS;tan;2$;33|) $))
       (QSETREFV $ 85 (CONS (|dispatchFunction| |SULS;cot;2$;34|) $))
       (QSETREFV $ 87 (CONS (|dispatchFunction| |SULS;sec;2$;35|) $))
       (QSETREFV $ 89 (CONS (|dispatchFunction| |SULS;csc;2$;36|) $))
       (QSETREFV $ 91 (CONS (|dispatchFunction| |SULS;asin;2$;37|) $))
       (QSETREFV $ 93 (CONS (|dispatchFunction| |SULS;acos;2$;38|) $))
       (QSETREFV $ 95 (CONS (|dispatchFunction| |SULS;atan;2$;39|) $))
       (QSETREFV $ 97 (CONS (|dispatchFunction| |SULS;acot;2$;40|) $))
       (QSETREFV $ 99 (CONS (|dispatchFunction| |SULS;asec;2$;41|) $))
       (QSETREFV $ 101 (CONS (|dispatchFunction| |SULS;acsc;2$;42|) $))
       (QSETREFV $ 103 (CONS (|dispatchFunction| |SULS;sinh;2$;43|) $))
       (QSETREFV $ 105 (CONS (|dispatchFunction| |SULS;cosh;2$;44|) $))
       (QSETREFV $ 107 (CONS (|dispatchFunction| |SULS;tanh;2$;45|) $))
       (QSETREFV $ 109 (CONS (|dispatchFunction| |SULS;coth;2$;46|) $))
       (QSETREFV $ 111 (CONS (|dispatchFunction| |SULS;sech;2$;47|) $))
       (QSETREFV $ 113 (CONS (|dispatchFunction| |SULS;csch;2$;48|) $))
       (QSETREFV $ 115 (CONS (|dispatchFunction| |SULS;asinh;2$;49|) $))
       (QSETREFV $ 117 (CONS (|dispatchFunction| |SULS;acosh;2$;50|) $))
       (QSETREFV $ 119 (CONS (|dispatchFunction| |SULS;atanh;2$;51|) $))
       (QSETREFV $ 121 (CONS (|dispatchFunction| |SULS;acoth;2$;52|) $))
       (QSETREFV $ 123 (CONS (|dispatchFunction| |SULS;asech;2$;53|) $))
       (QSETREFV $ 125 (CONS (|dispatchFunction| |SULS;acsch;2$;54|) $))
       (COND
        ((|testBitVector| |pv$| 19)
         (QSETREFV $ 128 (CONS (|dispatchFunction| |SULS;^;$F$;55|) $)))
        ('T (QSETREFV $ 128 (CONS (|dispatchFunction| |SULS;^;$F$;56|) $)))))))
    $))) 

(MAKEPROP '|SparseUnivariateLaurentSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|InnerSparseUnivariatePowerSeries| 6)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) '|Rep| (|Symbol|)
              |SULS;variable;$S;1| |SULS;center;$Coef;2| (|Boolean|)
              (0 . |zero?|) (5 . |One|) (9 . |One|) (|Integer|)
              (13 . |monomial|) (19 . |Zero|) (23 . |Zero|) (27 . +)
              (|Variable| (NRTEVAL (QREFELT $ 7))) |SULS;coerce;V$;3|
              (33 . |order|) |SULS;pole?;$B;4|
              (|SparseUnivariateTaylorSeries| 6 (NRTEVAL (QREFELT $ 7))
                                              (NRTEVAL (QREFELT $ 8)))
              |SULS;coerce;Suts$;5| (|Union| 26 '"failed")
              |SULS;taylorIfCan;$U;6| |SULS;taylor;$Suts;7|
              |SULS;retractIfCan;$U;8| (39 . *) |SULS;laurent;ISuts$;9|
              |SULS;removeZeroes;2$;10| |SULS;removeZeroes;I2$;11|
              |SULS;taylorRep;$Suts;12| |SULS;degree;$I;13|
              |SULS;numer;$Suts;14| (|NonNegativeInteger|) (45 . |monomial|)
              |SULS;denom;$Suts;15| |SULS;*;Suts2$;16| |SULS;*;$Suts$;17|
              (51 . /) (57 . /) (|Union| $ '"failed") (63 . |iExquo|)
              |SULS;recip;$U;19| (70 . |exquo|) (76 . |differentiate|)
              |SULS;differentiate;$V$;22| (81 . |iCompose|) (87 . ^)
              |SULS;elt;3$;23| (|Fraction| 57) (93 . |Zero|) (|Polynomial| 6)
              (97 . |polynomial|) (103 . |coerce|) (108 . |coerce|)
              (113 . |coerce|) (118 . -) (124 . ^) (130 . /)
              (136 . |rationalFunction|) (142 . |truncate|)
              (149 . |rationalFunction|) (156 . |coefficient|)
              (162 . |integrate|) (167 . |integrate|) (172 . |integrate|)
              (178 . |log|) (183 . |exp|) (188 . ^)
              (|ElementaryFunctionsUnivariateLaurentSeries| 6 26 $$)
              (194 . |exp|) (199 . |log|) (204 . |sin|) (209 . |sin|)
              (214 . |cos|) (219 . |cos|) (224 . |tan|) (229 . |tan|)
              (234 . |cot|) (239 . |cot|) (244 . |sec|) (249 . |sec|)
              (254 . |csc|) (259 . |csc|) (264 . |asin|) (269 . |asin|)
              (274 . |acos|) (279 . |acos|) (284 . |atan|) (289 . |atan|)
              (294 . |acot|) (299 . |acot|) (304 . |asec|) (309 . |asec|)
              (314 . |acsc|) (319 . |acsc|) (324 . |sinh|) (329 . |sinh|)
              (334 . |cosh|) (339 . |cosh|) (344 . |tanh|) (349 . |tanh|)
              (354 . |coth|) (359 . |coth|) (364 . |sech|) (369 . |sech|)
              (374 . |csch|) (379 . |csch|) (384 . |asinh|) (389 . |asinh|)
              (394 . |acosh|) (399 . |acosh|) (404 . |atanh|) (409 . |atanh|)
              (414 . |acoth|) (419 . |acoth|) (424 . |asech|) (429 . |asech|)
              (434 . |acsch|) (439 . |acsch|) (|Fraction| 17)
              (444 . |cRationalPower|) (450 . ^) (456 . |denom|)
              (461 . |exquo|) (467 . |retract|) (472 . ^) (478 . |numer|)
              (|Record| (|:| |k| 17) (|:| |c| 6)) (|Stream| 134)
              (483 . |getStream|) (488 . |explicitlyEmpty?|)
              (493 . |explicitEntries?|) (|Reference| 141) (498 . |getRef|)
              (|OrderedCompletion| 17) (503 . |elt|) (|Union| 17 '"failed")
              (508 . |retractIfCan|) (513 . |extend|) (519 . |One|)
              (|OutputForm|) (523 . |seriesToOutputForm|) |SULS;coerce;$Of;57|
              (|Union| 161 '#1="failed") (|Matrix| $) (|InputForm|)
              (|Pattern| 169) (|Pattern| 17) (|List| 26) (|List| 157)
              (|Equation| 26) (|List| 10) (|Matrix| 17)
              (|Record| (|:| |mat| 159) (|:| |vec| (|Vector| 17))) (|Vector| $)
              (|PatternMatchResult| 169 $) (|PatternMatchResult| 17 $)
              (|Factored| 165) (|SparseUnivariatePolynomial| $)
              (|Union| 167 '#1#) (|List| 165) (|DoubleFloat|) (|Float|)
              (|Union| 126 '#2="failed") (|Union| 10 '#2#)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|List| 39) (|List| 134) (|Mapping| 26 26) (|Matrix| 26)
              (|Record| (|:| |mat| 176) (|:| |vec| (|Vector| 26)))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|Union| 179 '"failed")
              (|Record| (|:| |coef| 179) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 183 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Factored| $) (|Stream| 6) (|Mapping| 6 17) (|PositiveInteger|)
              (|Mapping| 6 6) (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 532 |zero?| 538 |wholePart| 543 |variable| 548 |unitNormal|
              553 |unitCanonical| 558 |unit?| 563 |truncate| 568 |terms| 581
              |taylorRep| 586 |taylorIfCan| 591 |taylor| 596 |tanh| 601 |tan|
              606 |subtractIfCan| 611 |squareFreePolynomial| 617
              |squareFreePart| 622 |squareFree| 627 |sqrt| 632
              |solveLinearPolynomialEquation| 637 |smaller?| 643 |sizeLess?|
              649 |sinh| 655 |sin| 660 |sign| 665 |series| 670 |sech| 675 |sec|
              680 |sample| 685 |rightRecip| 689 |rightPower| 694 |retractIfCan|
              706 |retract| 726 |removeZeroes| 746 |rem| 757 |reductum| 763
              |reducedSystem| 768 |recip| 790 |rationalFunction| 795 |quo| 808
              |principalIdeal| 814 |prime?| 819 |positive?| 824 |pole?| 829
              |pi| 834 |patternMatch| 838 |order| 852 |opposite?| 863 |one?|
              869 |numerator| 874 |numer| 879 |nthRoot| 884 |nextItem| 890
              |negative?| 895 |multiplyExponents| 900 |multiplyCoefficients|
              906 |multiEuclidean| 912 |monomial?| 918 |monomial| 923 |min| 929
              |max| 935 |map| 941 |log| 953 |leftRecip| 958 |leftPower| 963
              |leadingTerm| 975 |leadingSupport| 980 |leadingMonomial| 985
              |leadingCoefficient| 990 |lcmCoef| 995 |lcm| 1001 |laurent| 1012
              |latex| 1024 |inv| 1029 |integrate| 1034 |init| 1051
              |hashUpdate!| 1055 |hash| 1061 |gcdPolynomial| 1066 |gcd| 1072
              |fractionPart| 1083 |floor| 1088 |factorSquareFreePolynomial|
              1093 |factorPolynomial| 1098 |factor| 1103 |extendedEuclidean|
              1108 |extend| 1121 |exquo| 1127 |expressIdealMember| 1133 |exp|
              1139 |eval| 1144 |euclideanSize| 1190 |elt| 1195 |divide| 1213
              |differentiate| 1219 |denominator| 1275 |denom| 1280 |degree|
              1285 |csch| 1290 |csc| 1295 |coth| 1300 |cot| 1305 |cosh| 1310
              |cos| 1315 |convert| 1320 |constructOrdered| 1345 |construct|
              1350 |conditionP| 1355 |complete| 1360 |commutator| 1365 |coerce|
              1371 |coefficient| 1411 |charthRoot| 1417 |characteristic| 1422
              |center| 1426 |ceiling| 1431 |atanh| 1436 |atan| 1441
              |associator| 1446 |associates?| 1453 |asinh| 1459 |asin| 1464
              |asech| 1469 |asec| 1474 |approximate| 1479 |antiCommutator| 1485
              |annihilate?| 1491 |acsch| 1497 |acsc| 1502 |acoth| 1507 |acot|
              1512 |acosh| 1517 |acos| 1522 |abs| 1527 ^ 1532 |Zero| 1562 |One|
              1566 D 1570 >= 1620 > 1626 = 1632 <= 1638 < 1644 / 1650 - 1668 +
              1679 * 1685)
           'NIL
           (CONS
            (|makeByteWordVec2| 52
                                '(0 0 2 0 2 0 2 32 0 2 2 0 2 6 25 2 2 24 6 2 2
                                  20 24 25 50 34 7 2 40 41 2 13 52 39 52 0 20
                                  24 50 2 0 0 0 43 50 6 2 0 0 0 0 0 50 50 6 2 2
                                  52 48 6 47 39 39 6 0 0 51 39 28 2 0 0 29 9 2
                                  16 17 0 0 50 24 3 5 8 8 11 2 0 0 0 0 1 50 50
                                  50 50 50 50 24 25 2 2 43 3 4 5 5 28 8 8 10 11
                                  12 14 15 2))
            (CONS
             '#(|UnivariateLaurentSeriesConstructorCategory&|
                |UnivariateLaurentSeriesCategory&| |QuotientFieldCategory&| NIL
                |Field&| |UnivariatePowerSeriesCategory&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| |PowerSeriesCategory&| NIL
                |UniqueFactorizationDomain&| |AbelianMonoidRing&| |GcdDomain&|
                NIL NIL NIL |DivisionRing&| NIL |OrderedRing&|
                |DifferentialExtension&| |FullyLinearlyExplicitOver&|
                |Algebra&| |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |Algebra&| |PartialDifferentialRing&| |DifferentialRing&| NIL
                NIL NIL NIL |Rng&| NIL |Module&| |Module&| |Module&| |Module&|
                NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL NIL
                NIL NIL NIL NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&|
                NIL NIL NIL NIL NIL |NonAssociativeSemiRng&| NIL
                |AbelianMonoid&| |MagmaWithUnit&| |OrderedSet&| NIL |Magma&|
                |AbelianSemiGroup&| NIL NIL |FullyEvalableOver&| NIL NIL
                |RetractableTo&| |SetCategory&|
                |TranscendentalFunctionCategory&| NIL |RetractableTo&| NIL
                |RetractableTo&| |RetractableTo&| |Evalable&| NIL NIL NIL
                |BasicType&| NIL NIL |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                |RadicalCategory&| NIL NIL NIL NIL NIL NIL NIL NIL NIL
                |PartialOrder&| NIL NIL |InnerEvalable&| |InnerEvalable&| NIL
                NIL NIL NIL)
             (CONS
              '#((|UnivariateLaurentSeriesConstructorCategory| 6
                                                               (|SparseUnivariateTaylorSeries|
                                                                6 7 8))
                 (|UnivariateLaurentSeriesCategory| 6)
                 (|QuotientFieldCategory|
                  (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|UnivariateSeriesWithRationalExponents| 6 17) (|Field|)
                 (|UnivariatePowerSeriesCategory| 6 17) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|)
                 (|PowerSeriesCategory| 6 17 (|SingletonAsOrderedSet|))
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 17) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|) (|LeftOreRing|)
                 (|DivisionRing|) (|CommutativeRing|) (|OrderedRing|)
                 (|DifferentialExtension|
                  (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|FullyLinearlyExplicitOver|
                  (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|Algebra| 6) (|Algebra| $$) (|EntireRing|) (|Algebra| 126)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|Algebra| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|PartialDifferentialRing| 10) (|DifferentialRing|)
                 (|LinearlyExplicitOver|
                  (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|LinearlyExplicitOver| 17) (|Ring|) (|SemiRing|) (|Rng|)
                 (|SemiRng|) (|Module| 6) (|Module| $$) (|Module| 126)
                 (|Module| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|IndexedProductCategory| 6 17) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|BiModule| 126 126)
                 (|OrderedAbelianGroup|)
                 (|BiModule| (|SparseUnivariateTaylorSeries| 6 7 8)
                             (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 126) (|RightModule| 126)
                 (|OrderedCancellationAbelianMonoid|)
                 (|LeftModule| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|RightModule| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|OrderedAbelianSemiGroup|) (|NonAssociativeSemiRng|)
                 (|SemiGroup|) (|AbelianMonoid|) (|MagmaWithUnit|)
                 (|OrderedSet|)
                 (|FullyPatternMatchable|
                  (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|FullyEvalableOver| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|PatternMatchable| 169) (|PatternMatchable| 17)
                 (|RetractableTo| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|SetCategory|) (|TranscendentalFunctionCategory|)
                 (|CommutativeStar|) (|RetractableTo| 10) (|RealConstant|)
                 (|RetractableTo| 126) (|RetractableTo| 17)
                 (|Evalable| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|Patternable| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|CoercibleFrom| (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|VariablesCommuteWithCoefficients|) (|BasicType|)
                 (|CoercibleTo| 147) (|Eltable| $$ $$)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|)
                 (|TwoSidedRecip|) (|noZeroDivisors|) (|canonicalUnitNormal|)
                 (|canonicalsClosed|) (|unitsKnown|) (|CoercibleFrom| 10)
                 (|ConvertibleTo| 152) (|ConvertibleTo| 168)
                 (|ConvertibleTo| 169) (|PartialOrder|) (|CoercibleFrom| 126)
                 (|CoercibleFrom| 17)
                 (|InnerEvalable| 10 (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|InnerEvalable| (|SparseUnivariateTaylorSeries| 6 7 8)
                                  (|SparseUnivariateTaylorSeries| 6 7 8))
                 (|Eltable| (|SparseUnivariateTaylorSeries| 6 7 8) $$)
                 (|ConvertibleTo| 153) (|ConvertibleTo| 154) (|Type|))
              (|makeByteWordVec2| 193
                                  '(1 6 13 0 14 0 6 0 15 0 0 0 16 2 0 0 6 17 18
                                    0 6 0 19 0 0 0 20 2 0 0 0 0 21 2 0 17 0 17
                                    24 2 0 0 0 0 32 2 26 0 6 39 40 2 0 0 0 0 44
                                    2 0 0 26 26 45 3 9 46 0 0 13 47 2 0 46 0 0
                                    49 1 0 0 0 50 2 9 0 0 0 52 2 0 0 0 39 53 0
                                    55 0 56 2 26 57 0 39 58 1 55 0 57 59 1 55 0
                                    10 60 1 57 0 6 61 2 55 0 0 0 62 2 55 0 0 17
                                    63 2 55 0 0 0 64 2 0 55 0 17 65 3 0 0 0 17
                                    17 66 3 0 55 0 17 17 67 2 0 6 0 17 68 1 9 0
                                    0 69 1 0 0 0 70 2 0 0 0 22 71 1 0 0 0 72 1
                                    0 0 0 73 2 0 0 0 0 74 1 75 2 2 76 1 75 2 2
                                    77 1 75 2 2 78 1 0 0 0 79 1 75 2 2 80 1 0 0
                                    0 81 1 75 2 2 82 1 0 0 0 83 1 75 2 2 84 1 0
                                    0 0 85 1 75 2 2 86 1 0 0 0 87 1 75 2 2 88 1
                                    0 0 0 89 1 75 2 2 90 1 0 0 0 91 1 75 2 2 92
                                    1 0 0 0 93 1 75 2 2 94 1 0 0 0 95 1 75 2 2
                                    96 1 0 0 0 97 1 75 2 2 98 1 0 0 0 99 1 75 2
                                    2 100 1 0 0 0 101 1 75 2 2 102 1 0 0 0 103
                                    1 75 2 2 104 1 0 0 0 105 1 75 2 2 106 1 0 0
                                    0 107 1 75 2 2 108 1 0 0 0 109 1 75 2 2 110
                                    1 0 0 0 111 1 75 2 2 112 1 0 0 0 113 1 75 2
                                    2 114 1 0 0 0 115 1 75 2 2 116 1 0 0 0 117
                                    1 75 2 2 118 1 0 0 0 119 1 75 2 2 120 1 0 0
                                    0 121 1 75 2 2 122 1 0 0 0 123 1 75 2 2 124
                                    1 0 0 0 125 2 9 0 0 126 127 2 0 0 0 126 128
                                    1 126 17 0 129 2 17 46 0 0 130 1 0 26 0 131
                                    2 26 0 0 126 132 1 126 17 0 133 1 9 135 0
                                    136 1 135 13 0 137 1 135 13 0 138 1 9 139 0
                                    140 1 139 141 0 142 1 141 143 0 144 2 0 0 0
                                    17 145 0 126 0 146 5 9 147 135 139 10 6 126
                                    148 2 0 13 0 0 1 1 61 13 0 1 1 36 26 0 1 1
                                    0 10 0 11 1 57 172 0 1 1 57 0 0 1 1 57 13 0
                                    1 3 0 0 0 17 17 66 2 0 0 0 17 1 1 0 135 0 1
                                    1 0 26 0 36 1 0 28 0 29 1 0 26 0 30 1 49 0
                                    0 107 1 49 0 0 83 2 62 46 0 0 1 1 32 164
                                    165 1 1 2 0 0 1 1 2 186 0 1 1 49 0 0 1 2 32
                                    166 167 165 1 2 26 13 0 0 1 2 2 13 0 0 1 1
                                    49 0 0 103 1 49 0 0 79 1 6 17 0 1 1 0 0 135
                                    1 1 49 0 0 111 1 49 0 0 87 0 61 0 1 1 59 46
                                    0 1 2 59 0 0 39 1 2 0 0 0 189 1 1 8 170 0 1
                                    1 8 143 0 1 1 3 171 0 1 1 0 28 0 31 1 8 126
                                    0 1 1 8 17 0 1 1 3 10 0 1 1 0 26 0 131 1 0
                                    0 0 34 2 0 0 17 0 35 2 2 0 0 0 1 1 18 0 0 1
                                    1 13 159 151 1 2 13 160 151 161 1 1 2 176
                                    151 1 2 2 177 151 161 1 1 59 46 0 48 2 23
                                    55 0 17 65 3 23 55 0 17 17 67 2 2 0 0 0 1 1
                                    2 181 179 1 1 2 13 0 1 1 6 13 0 1 1 0 13 0
                                    25 0 49 0 1 3 16 162 0 153 162 1 3 17 163 0
                                    154 163 1 2 0 17 0 17 24 1 0 17 0 1 2 61 13
                                    0 0 1 1 59 13 0 1 1 2 0 0 1 1 2 26 0 38 2
                                    49 0 0 17 1 1 9 46 0 1 1 6 13 0 1 2 0 0 0
                                    189 1 2 0 0 188 0 1 2 2 180 179 0 1 1 0 13
                                    0 1 2 0 0 6 17 18 2 27 0 0 0 1 2 27 0 0 0 1
                                    2 2 0 175 0 1 2 0 0 190 0 1 1 49 0 0 72 1
                                    59 46 0 1 2 59 0 0 39 1 2 0 0 0 189 1 1 18
                                    134 0 1 1 18 17 0 1 1 0 0 0 1 1 0 6 0 1 2 2
                                    178 0 0 1 2 2 0 0 0 1 1 2 0 179 1 2 0 0 17
                                    26 33 2 0 0 17 187 1 1 0 192 0 1 1 2 0 0 1
                                    2 53 0 0 10 1 2 49 0 0 22 71 1 49 0 0 70 0
                                    9 0 1 2 0 191 191 0 1 1 0 193 0 1 2 2 165
                                    165 165 1 2 2 0 0 0 1 1 2 0 179 1 1 36 0 0
                                    1 1 35 26 0 1 1 32 164 165 1 1 32 164 165 1
                                    1 2 186 0 1 3 2 184 0 0 0 1 2 2 185 0 0 1 2
                                    0 0 0 17 145 2 57 46 0 0 49 2 2 180 179 0 1
                                    1 49 0 0 73 3 11 0 0 26 26 1 3 11 0 0 155
                                    155 1 2 11 0 0 156 1 2 11 0 0 157 1 3 10 0
                                    0 158 155 1 3 10 0 0 10 26 1 2 21 187 0 6 1
                                    1 2 39 0 1 2 12 0 0 26 1 2 1 0 0 0 54 2 0 6
                                    0 17 1 2 2 182 0 0 1 1 41 0 0 50 2 41 0 0
                                    39 1 2 40 0 0 10 1 3 40 0 0 10 39 1 2 40 0
                                    0 158 1 3 40 0 0 158 173 1 3 2 0 0 175 39 1
                                    2 2 0 0 175 1 2 0 0 0 22 51 1 2 0 0 1 1 2
                                    26 0 41 1 0 17 0 37 1 49 0 0 113 1 49 0 0
                                    89 1 49 0 0 109 1 49 0 0 85 1 49 0 0 105 1
                                    49 0 0 81 1 4 152 0 1 1 14 153 0 1 1 15 154
                                    0 1 1 5 168 0 1 1 5 169 0 1 1 18 0 174 1 1
                                    0 0 174 1 1 55 150 151 1 1 0 0 0 1 2 60 0 0
                                    0 1 1 54 0 6 1 1 3 0 10 1 1 58 0 0 1 1 60 0
                                    17 1 1 49 0 126 1 1 0 0 22 23 1 0 0 26 27 1
                                    0 147 0 149 2 0 6 0 17 68 1 56 46 0 1 0 60
                                    39 1 1 0 6 0 12 1 35 26 0 1 1 49 0 0 119 1
                                    49 0 0 95 3 60 0 0 0 0 1 2 57 13 0 0 1 1 49
                                    0 0 115 1 49 0 0 91 1 49 0 0 123 1 49 0 0
                                    99 2 22 6 0 17 1 2 0 0 0 0 1 2 60 13 0 0 1
                                    1 49 0 0 125 1 49 0 0 101 1 49 0 0 121 1 49
                                    0 0 97 1 49 0 0 117 1 49 0 0 93 1 6 0 0 1 2
                                    59 0 0 39 53 2 49 0 0 126 128 2 49 0 0 0 74
                                    2 2 0 0 17 1 2 0 0 0 189 1 0 61 0 20 0 59 0
                                    16 1 41 0 0 1 2 41 0 0 39 1 2 40 0 0 10 1 3
                                    40 0 0 10 39 1 2 40 0 0 158 1 3 40 0 0 158
                                    173 1 2 2 0 0 175 1 3 2 0 0 175 39 1 2 27
                                    13 0 0 1 2 27 13 0 0 1 2 0 13 0 0 1 2 27 13
                                    0 0 1 2 27 13 0 0 1 2 2 0 26 26 45 2 2 0 0
                                    0 44 2 2 0 0 6 1 1 63 0 0 1 2 63 0 0 0 1 2
                                    0 0 0 0 21 2 63 0 17 0 1 2 61 0 39 0 1 2 49
                                    0 0 126 1 2 49 0 126 0 1 2 2 0 26 0 42 2 2
                                    0 0 26 43 2 0 0 6 0 1 2 0 0 0 6 1 2 0 0 0 0
                                    32 2 0 0 189 0 1)))))
           '|lookupComplete|)) 
