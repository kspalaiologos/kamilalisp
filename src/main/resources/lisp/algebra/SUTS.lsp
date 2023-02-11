
(PUT '|SUTS;makeTerm| '|SPADreplace| 'CONS) 

(SDEFUN |SUTS;makeTerm|
        ((|exp| (|Integer|)) (|coef| (|Coef|))
         ($ (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
        (CONS |exp| |coef|)) 

(PUT '|SUTS;getCoef| '|SPADreplace| 'QCDR) 

(SDEFUN |SUTS;getCoef|
        ((|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
         ($ (|Coef|)))
        (QCDR |term|)) 

(PUT '|SUTS;getExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |SUTS;getExpon|
        ((|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
         ($ (|Integer|)))
        (QCAR |term|)) 

(SDEFUN |SUTS;monomial;CoefNni$;4|
        ((|coef| (|Coef|)) (|expon| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |coef| |expon| (QREFELT $ 11))) 

(SDEFUN |SUTS;extend;$Nni$;5| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 14))) 

(SDEFUN |SUTS;Zero;$;6| (($ ($)))
        (SPADCALL (|spadConstant| $ 16) 0 (QREFELT $ 11))) 

(SDEFUN |SUTS;One;$;7| (($ ($)))
        (SPADCALL (|spadConstant| $ 18) 0 (QREFELT $ 11))) 

(SDEFUN |SUTS;recip;$U;8| ((|uts| ($)) ($ (|Union| $ "failed")))
        (SPADCALL (|spadConstant| $ 19) |uts| 'T (QREFELT $ 22))) 

(SDEFUN |SUTS;exquo;2$U;9| ((|uts1| ($)) (|uts2| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |uts1| |uts2| 'T (QREFELT $ 22))) 

(SDEFUN |SUTS;quoByVar;2$;10| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 25))) 

(SDEFUN |SUTS;differentiate;$V$;11|
        ((|x| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 27))) 

(SDEFUN |SUTS;coerce;V$;12| ((|v| (|Variable| |var|)) ($ ($)))
        (COND
         ((SPADCALL (QREFELT $ 8) (QREFELT $ 30))
          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13)))
         ('T
          (SPADCALL (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                    (SPADCALL (QREFELT $ 8) 0 (QREFELT $ 13)) (QREFELT $ 31))))) 

(SDEFUN |SUTS;coerce;Up$;13|
        ((|p| (|UnivariatePolynomial| |var| |Coef|)) ($ ($)))
        (SPROG
         ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 34)) (|spadConstant| $ 17))
                ('T
                 (SEQ
                  (COND
                   ((NULL (SPADCALL (QREFELT $ 8) (QREFELT $ 30)))
                    (LETT |p|
                          (SPADCALL |p|
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 18) 1
                                               (QREFELT $ 35))
                                     (SPADCALL (QREFELT $ 8) 0 (QREFELT $ 35))
                                     (QREFELT $ 36))
                                    (QREFELT $ 37)))))
                  (LETT |st| (SPADCALL (QREFELT $ 40)))
                  (SEQ G190
                       (COND
                        ((NULL (NULL (SPADCALL |p| (QREFELT $ 34))))
                         (GO G191)))
                       (SEQ
                        (LETT |st|
                              (SPADCALL
                               (|SUTS;makeTerm| (SPADCALL |p| (QREFELT $ 41))
                                (SPADCALL |p| (QREFELT $ 42)) $)
                               |st| (QREFELT $ 43)))
                        (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 44)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL (QREFELT $ 46)) (QREFELT $ 48)) |st|
                    (QREFELT $ 49))))))))) 

(SDEFUN |SUTS;univariatePolynomial;$NniUp;14|
        ((|x| ($)) (|n| (|NonNegativeInteger|))
         ($ (|UnivariatePolynomial| |var| |Coef|)))
        (SPROG
         ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|ans| (|UnivariatePolynomial| |var| |Coef|))
          (|monPow| (|UnivariatePolynomial| |var| |Coef|))
          (|oldDeg| (|Integer|)) (|pow| (|NonNegativeInteger|)) (#1=#:G768 NIL)
          (#2=#:G778 NIL) (|xExpon| (|Integer|))
          (|xTerm| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
          (|mon| (|UnivariatePolynomial| |var| |Coef|)))
         (SEQ
          (EXIT
           (SEQ (SPADCALL |x| |n| (QREFELT $ 15))
                (LETT |st| (SPADCALL |x| (QREFELT $ 51)))
                (LETT |ans| (|spadConstant| $ 52)) (LETT |oldDeg| 0)
                (LETT |mon|
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 35))
                       (SPADCALL (SPADCALL |x| (QREFELT $ 53)) 0
                                 (QREFELT $ 35))
                       (QREFELT $ 54)))
                (LETT |monPow| (|spadConstant| $ 55))
                (SEQ G190
                     (COND ((NULL (SPADCALL |st| (QREFELT $ 56))) (GO G191)))
                     (SEQ
                      (LETT |xExpon|
                            (|SUTS;getExpon|
                             (LETT |xTerm| (SPADCALL |st| (QREFELT $ 57))) $))
                      (EXIT
                       (COND
                        ((> |xExpon| |n|)
                         (PROGN (LETT #2# |ans|) (GO #3=#:G777)))
                        ('T
                         (SEQ
                          (LETT |pow|
                                (PROG1 (LETT #1# (- |xExpon| |oldDeg|))
                                  (|check_subtype2| (>= #1# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #1#)))
                          (LETT |oldDeg| |xExpon|)
                          (LETT |monPow|
                                (SPADCALL |monPow|
                                          (SPADCALL |mon| |pow| (QREFELT $ 58))
                                          (QREFELT $ 59)))
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL (|SUTS;getCoef| |xTerm| $)
                                                    |monPow| (QREFELT $ 60))
                                          (QREFELT $ 36)))
                          (EXIT
                           (LETT |st| (SPADCALL |st| (QREFELT $ 61)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))
          #3# (EXIT #2#)))) 

(SDEFUN |SUTS;polynomial;$NniP;15|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Polynomial| |Coef|)))
        (SPROG
         ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|ans| (|Polynomial| |Coef|)) (|monPow| (|Polynomial| |Coef|))
          (|oldDeg| (|Integer|)) (|pow| (|NonNegativeInteger|)) (#1=#:G784 NIL)
          (#2=#:G790 NIL) (|xExpon| (|Integer|))
          (|xTerm| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
          (|mon| (|Polynomial| |Coef|)))
         (SEQ
          (EXIT
           (SEQ (SPADCALL |x| |n| (QREFELT $ 15))
                (LETT |st| (SPADCALL |x| (QREFELT $ 51)))
                (LETT |ans| (|spadConstant| $ 64)) (LETT |oldDeg| 0)
                (LETT |mon|
                      (SPADCALL (SPADCALL (QREFELT $ 7) (QREFELT $ 66))
                                (SPADCALL (SPADCALL |x| (QREFELT $ 53))
                                          (QREFELT $ 67))
                                (QREFELT $ 68)))
                (LETT |monPow| (|spadConstant| $ 69))
                (SEQ G190
                     (COND ((NULL (SPADCALL |st| (QREFELT $ 56))) (GO G191)))
                     (SEQ
                      (LETT |xExpon|
                            (|SUTS;getExpon|
                             (LETT |xTerm| (SPADCALL |st| (QREFELT $ 57))) $))
                      (EXIT
                       (COND
                        ((> |xExpon| |n|)
                         (PROGN (LETT #2# |ans|) (GO #3=#:G789)))
                        ('T
                         (SEQ
                          (LETT |pow|
                                (PROG1 (LETT #1# (- |xExpon| |oldDeg|))
                                  (|check_subtype2| (>= #1# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #1#)))
                          (LETT |oldDeg| |xExpon|)
                          (LETT |monPow|
                                (SPADCALL |monPow|
                                          (SPADCALL |mon| |pow| (QREFELT $ 70))
                                          (QREFELT $ 71)))
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL (|SUTS;getCoef| |xTerm| $)
                                                    |monPow| (QREFELT $ 72))
                                          (QREFELT $ 73)))
                          (EXIT
                           (LETT |st| (SPADCALL |st| (QREFELT $ 61)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))
          #3# (EXIT #2#)))) 

(SDEFUN |SUTS;polynomial;$2NniP;16|
        ((|x| ($)) (|n1| #1=(|NonNegativeInteger|)) (|n2| #1#)
         ($ (|Polynomial| |Coef|)))
        (SPADCALL (SPADCALL |x| |n1| |n2| (QREFELT $ 75)) |n2| (QREFELT $ 74))) 

(SDEFUN |SUTS;truncate;$Nni$;17|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 77))) 

(SDEFUN |SUTS;truncate;$2Nni$;18|
        ((|x| ($)) (|n1| #1=(|NonNegativeInteger|)) (|n2| #1#) ($ ($)))
        (SPADCALL |x| |n1| |n2| (QREFELT $ 79))) 

(SDEFUN |SUTS;iCoefficients|
        ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         (|n| (|Integer|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|SUTS;iCoefficients!0| (VECTOR |refer| |n| $ |x|))
                 (QREFELT $ 92))))) 

(SDEFUN |SUTS;iCoefficients!0| (($$ NIL))
        (PROG (|x| $ |n| |refer|)
          (LETT |x| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT |refer| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|nn| NIL) (|nx| NIL) (|xTerm| NIL) (|xCoef| NIL) (|xExpon| NIL))
             (SEQ
              (COND ((SPADCALL |x| (QREFELT $ 80)) (SPADCALL (QREFELT $ 82)))
                    ('T
                     (SEQ (LETT |nn| (SPADCALL |n| (QREFELT $ 83)))
                          (SEQ G190
                               (COND
                                ((NULL
                                  (SPADCALL
                                   (LETT |nx|
                                         (SPADCALL |refer| (QREFELT $ 84)))
                                   |nn| (QREFELT $ 85)))
                                 (GO G191)))
                               (SEQ (EXIT (SPADCALL |x| (QREFELT $ 86)))) NIL
                               (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (COND
                            ((SPADCALL |x| (QREFELT $ 56))
                             (SEQ
                              (LETT |xCoef|
                                    (|SUTS;getCoef|
                                     (LETT |xTerm|
                                           (SPADCALL |x| (QREFELT $ 57)))
                                     $))
                              (LETT |xExpon| (|SUTS;getExpon| |xTerm| $))
                              (EXIT
                               (COND
                                ((SPADCALL |xExpon| |n| (QREFELT $ 87))
                                 (SPADCALL |xCoef|
                                           (|SUTS;iCoefficients|
                                            (SPADCALL |x| (QREFELT $ 61))
                                            |refer|
                                            (SPADCALL |n| (|spadConstant| $ 88)
                                                      (QREFELT $ 89))
                                            $)
                                           (QREFELT $ 90)))
                                ('T
                                 (SPADCALL (|spadConstant| $ 16)
                                           (|SUTS;iCoefficients| |x| |refer|
                                            (SPADCALL |n| (|spadConstant| $ 88)
                                                      (QREFELT $ 89))
                                            $)
                                           (QREFELT $ 90)))))))
                            ('T
                             (SPADCALL (|spadConstant| $ 16)
                                       (|SUTS;iCoefficients| |x| |refer|
                                        (SPADCALL |n| (|spadConstant| $ 88)
                                                  (QREFELT $ 89))
                                        $)
                                       (QREFELT $ 90)))))))))))))) 

(SDEFUN |SUTS;coefficients;$S;20| ((|uts| ($)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|x| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
          (|refer| (|Reference| (|OrderedCompletion| (|Integer|)))))
         (SEQ (LETT |refer| (SPADCALL |uts| (QREFELT $ 93)))
              (LETT |x| (SPADCALL |uts| (QREFELT $ 51)))
              (EXIT (|SUTS;iCoefficients| |x| |refer| 0 $))))) 

(SDEFUN |SUTS;terms;$S;21|
        ((|uts| ($))
         ($
          (|Stream|
           (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|)))))
        (SPADCALL |uts| (QREFELT $ 95))) 

(SDEFUN |SUTS;iSeries|
        ((|st| (|Stream| |Coef|)) (|n| (|Integer|))
         (|refer| (|Reference| (|OrderedCompletion| (|Integer|))))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|SUTS;iSeries!0| (VECTOR |n| |refer| $ |st|))
                          (QREFELT $ 103))))) 

(SDEFUN |SUTS;iSeries!0| (($$ NIL))
        (PROG (|st| $ |refer| |n|)
          (LETT |st| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |refer| (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|coef| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |st| (QREFELT $ 99))
                      (SEQ
                       (SPADCALL |refer| (SPADCALL (QREFELT $ 46))
                                 (QREFELT $ 100))
                       (EXIT (SPADCALL (QREFELT $ 40)))))
                     ('T
                      (SEQ
                       (SPADCALL |refer| (SPADCALL |n| (QREFELT $ 83))
                                 (QREFELT $ 100))
                       (EXIT
                        (COND
                         ((SPADCALL
                           (LETT |coef| (SPADCALL |st| (QREFELT $ 101)))
                           (QREFELT $ 30))
                          (|SUTS;iSeries| (SPADCALL |st| (QREFELT $ 102))
                           (SPADCALL |n| (|spadConstant| $ 88) (QREFELT $ 89))
                           |refer| $))
                         ('T
                          (SPADCALL (|SUTS;makeTerm| |n| |coef| $)
                                    (|SUTS;iSeries|
                                     (SPADCALL |st| (QREFELT $ 102))
                                     (SPADCALL |n| (|spadConstant| $ 88)
                                               (QREFELT $ 89))
                                     |refer| $)
                                    (QREFELT $ 43)))))))))))))) 

(SDEFUN |SUTS;series;S$;23| ((|st| (|Stream| |Coef|)) ($ ($)))
        (SPROG ((|refer| (|Reference| (|OrderedCompletion| (|Integer|)))))
               (SEQ
                (LETT |refer|
                      (SPADCALL (SPADCALL -1 (QREFELT $ 83)) (QREFELT $ 48)))
                (EXIT
                 (SPADCALL |refer| (|SUTS;iSeries| |st| 0 |refer| $)
                           (QREFELT $ 49)))))) 

(SDEFUN |SUTS;series;S$;24|
        ((|st|
          (|Stream|
           (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |Coef|))))
         ($ ($)))
        (SPADCALL |st| (QREFELT $ 105))) 

(SDEFUN |SUTS;variable;$S;25| ((|x| ($)) ($ (|Symbol|))) (QREFELT $ 7)) 

(SDEFUN |SUTS;center;$Coef;26| ((|x| ($)) ($ (|Coef|))) (QREFELT $ 8)) 

(SDEFUN |SUTS;coefficient;$NniCoef;27|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Coef|)))
        (SPADCALL |x| |n| (QREFELT $ 108))) 

(SDEFUN |SUTS;elt;$NniCoef;28|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Coef|)))
        (SPADCALL |x| |n| (QREFELT $ 109))) 

(PUT '|SUTS;pole?;$B;29| '|SPADreplace| '(XLAM (|x|) NIL)) 

(SDEFUN |SUTS;pole?;$B;29| ((|x| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |SUTS;order;$Nni;30| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G837 NIL))
               (PROG1 (LETT #1# (SPADCALL |x| (QREFELT $ 112)))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |SUTS;order;$2Nni;31|
        ((|x| ($)) (|n| #1=(|NonNegativeInteger|)) ($ #1#))
        (SPROG ((#2=#:G839 NIL))
               (PROG1 (LETT #2# (SPADCALL |x| |n| (QREFELT $ 114)))
                 (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #2#)))) 

(SDEFUN |SUTS;elt;3$;32| ((|uts1| ($)) (|uts2| ($)) ($ ($)))
        (COND
         ((SPADCALL |uts2| (QREFELT $ 116))
          (SPADCALL (SPADCALL |uts1| 0 (QREFELT $ 109)) (QREFELT $ 117)))
         ((NULL (SPADCALL (SPADCALL |uts2| 0 (QREFELT $ 109)) (QREFELT $ 30)))
          (|error| "elt: second argument must have positive order"))
         ('T (SPADCALL |uts1| |uts2| (QREFELT $ 118))))) 

(SDEFUN |SUTS;integrate;$V$;33| ((|x| ($)) (|v| (|Variable| |var|)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 120))) 

(SDEFUN |SUTS;^;3$;34| ((|uts1| ($)) (|uts2| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |uts1| (QREFELT $ 122)) |uts2| (QREFELT $ 123))
         (QREFELT $ 124))) 

(SDEFUN |SUTS;^;$F$;35| ((|uts| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL |uts| |r| (QREFELT $ 127))) 

(SDEFUN |SUTS;exp;2$;36| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 129))) 

(SDEFUN |SUTS;log;2$;37| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 130))) 

(SDEFUN |SUTS;sin;2$;38| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 131))) 

(SDEFUN |SUTS;cos;2$;39| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 133))) 

(SDEFUN |SUTS;tan;2$;40| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 135))) 

(SDEFUN |SUTS;cot;2$;41| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 137))) 

(SDEFUN |SUTS;sec;2$;42| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 139))) 

(SDEFUN |SUTS;csc;2$;43| ((|uts| ($)) ($ ($))) (SPADCALL |uts| (QREFELT $ 141))) 

(SDEFUN |SUTS;asin;2$;44| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 143))) 

(SDEFUN |SUTS;acos;2$;45| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 145))) 

(SDEFUN |SUTS;atan;2$;46| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 147))) 

(SDEFUN |SUTS;acot;2$;47| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 149))) 

(SDEFUN |SUTS;asec;2$;48| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 151))) 

(SDEFUN |SUTS;acsc;2$;49| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 153))) 

(SDEFUN |SUTS;sinh;2$;50| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 155))) 

(SDEFUN |SUTS;cosh;2$;51| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 157))) 

(SDEFUN |SUTS;tanh;2$;52| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 159))) 

(SDEFUN |SUTS;coth;2$;53| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 161))) 

(SDEFUN |SUTS;sech;2$;54| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 163))) 

(SDEFUN |SUTS;csch;2$;55| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 165))) 

(SDEFUN |SUTS;asinh;2$;56| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 167))) 

(SDEFUN |SUTS;acosh;2$;57| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 169))) 

(SDEFUN |SUTS;atanh;2$;58| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 171))) 

(SDEFUN |SUTS;acoth;2$;59| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 173))) 

(SDEFUN |SUTS;asech;2$;60| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 175))) 

(SDEFUN |SUTS;acsch;2$;61| ((|uts| ($)) ($ ($)))
        (SPADCALL |uts| (QREFELT $ 177))) 

(SDEFUN |SUTS;^;$F$;62| ((|uts| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPROG ((|ratPow| ($)))
               (SEQ
                (COND
                 ((NULL
                   (SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109))
                             (|spadConstant| $ 18) (QREFELT $ 182)))
                  (|error| "^: constant coefficient must be one"))
                 ('T
                  (SEQ
                   (LETT |ratPow|
                         (SPADCALL |uts| (SPADCALL |r| (QREFELT $ 183))
                                   (QREFELT $ 184)))
                   (EXIT
                    (SPADCALL |ratPow|
                              (SPADCALL |uts| (|spadConstant| $ 19)
                                        (QREFELT $ 185))
                              (QREFELT $ 118))))))))) 

(SDEFUN |SUTS;exp;2$;63| ((|uts| ($)) ($ ($)))
        (SPROG ((|expx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |expx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 129)))
                   (EXIT (SPADCALL |expx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "exp: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;log;2$;64| ((|uts| ($)) ($ ($)))
        (SPROG ((|log1PlusX| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109))
                            (|spadConstant| $ 18) (QREFELT $ 182))
                  (SEQ
                   (LETT |log1PlusX|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 18) 0 (QREFELT $ 13))
                           (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                           (QREFELT $ 31))
                          (QREFELT $ 130)))
                   (EXIT
                    (SPADCALL |log1PlusX|
                              (SPADCALL |uts| (|spadConstant| $ 19)
                                        (QREFELT $ 185))
                              (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "log: " (QREFELT $ 180)))))))) 

(SDEFUN |SUTS;sin;2$;65| ((|uts| ($)) ($ ($)))
        (SPROG ((|sinx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |sinx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 131)))
                   (EXIT (SPADCALL |sinx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "sin: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;cos;2$;66| ((|uts| ($)) ($ ($)))
        (SPROG ((|cosx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |cosx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 133)))
                   (EXIT (SPADCALL |cosx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "cos: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;tan;2$;67| ((|uts| ($)) ($ ($)))
        (SPROG ((|tanx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |tanx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 135)))
                   (EXIT (SPADCALL |tanx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "tan: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;cot;2$;68| ((|uts| ($)) ($ ($)))
        (COND
         ((SPADCALL |uts| (QREFELT $ 116))
          (|error| "cot: cot(0) is undefined"))
         ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
          (|error| (STRCONC "cot: " (QREFELT $ 181))))
         ('T (|error| (STRCONC "cot: " (QREFELT $ 179)))))) 

(SDEFUN |SUTS;sec;2$;69| ((|uts| ($)) ($ ($)))
        (SPROG ((|secx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |secx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 139)))
                   (EXIT (SPADCALL |secx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "sec: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;csc;2$;70| ((|uts| ($)) ($ ($)))
        (COND
         ((SPADCALL |uts| (QREFELT $ 116))
          (|error| "csc: csc(0) is undefined"))
         ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
          (|error| (STRCONC "csc: " (QREFELT $ 181))))
         ('T (|error| (STRCONC "csc: " (QREFELT $ 179)))))) 

(SDEFUN |SUTS;asin;2$;71| ((|uts| ($)) ($ ($)))
        (SPROG ((|asinx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |asinx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 143)))
                   (EXIT (SPADCALL |asinx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "asin: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;atan;2$;72| ((|uts| ($)) ($ ($)))
        (SPROG ((|atanx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |atanx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 147)))
                   (EXIT (SPADCALL |atanx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "atan: " (QREFELT $ 179)))))))) 

(PUT '|SUTS;acos;2$;73| '|SPADreplace|
     '(XLAM (|z|) (|error| "acos: acos undefined on this coefficient domain"))) 

(SDEFUN |SUTS;acos;2$;73| ((|z| ($)) ($ ($)))
        (|error| "acos: acos undefined on this coefficient domain")) 

(PUT '|SUTS;acot;2$;74| '|SPADreplace|
     '(XLAM (|z|) (|error| "acot: acot undefined on this coefficient domain"))) 

(SDEFUN |SUTS;acot;2$;74| ((|z| ($)) ($ ($)))
        (|error| "acot: acot undefined on this coefficient domain")) 

(PUT '|SUTS;asec;2$;75| '|SPADreplace|
     '(XLAM (|z|) (|error| "asec: asec undefined on this coefficient domain"))) 

(SDEFUN |SUTS;asec;2$;75| ((|z| ($)) ($ ($)))
        (|error| "asec: asec undefined on this coefficient domain")) 

(PUT '|SUTS;acsc;2$;76| '|SPADreplace|
     '(XLAM (|z|) (|error| "acsc: acsc undefined on this coefficient domain"))) 

(SDEFUN |SUTS;acsc;2$;76| ((|z| ($)) ($ ($)))
        (|error| "acsc: acsc undefined on this coefficient domain")) 

(SDEFUN |SUTS;sinh;2$;77| ((|uts| ($)) ($ ($)))
        (SPROG ((|sinhx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |sinhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 155)))
                   (EXIT (SPADCALL |sinhx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "sinh: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;cosh;2$;78| ((|uts| ($)) ($ ($)))
        (SPROG ((|coshx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |coshx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 157)))
                   (EXIT (SPADCALL |coshx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "cosh: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;tanh;2$;79| ((|uts| ($)) ($ ($)))
        (SPROG ((|tanhx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |tanhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 159)))
                   (EXIT (SPADCALL |tanhx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "tanh: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;coth;2$;80| ((|uts| ($)) ($ ($)))
        (COND
         ((SPADCALL |uts| (QREFELT $ 116))
          (|error| "coth: coth(0) is undefined"))
         ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
          (|error| (STRCONC "coth: " (QREFELT $ 181))))
         ('T (|error| (STRCONC "coth: " (QREFELT $ 179)))))) 

(SDEFUN |SUTS;sech;2$;81| ((|uts| ($)) ($ ($)))
        (SPROG ((|sechx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |sechx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 163)))
                   (EXIT (SPADCALL |sechx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "sech: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;csch;2$;82| ((|uts| ($)) ($ ($)))
        (COND
         ((SPADCALL |uts| (QREFELT $ 116))
          (|error| "csch: csch(0) is undefined"))
         ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
          (|error| (STRCONC "csch: " (QREFELT $ 181))))
         ('T (|error| (STRCONC "csch: " (QREFELT $ 179)))))) 

(SDEFUN |SUTS;asinh;2$;83| ((|uts| ($)) ($ ($)))
        (SPROG ((|asinhx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |asinhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 167)))
                   (EXIT (SPADCALL |asinhx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "asinh: " (QREFELT $ 179)))))))) 

(SDEFUN |SUTS;atanh;2$;84| ((|uts| ($)) ($ ($)))
        (SPROG ((|atanhx| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |uts| 0 (QREFELT $ 109)) (QREFELT $ 30))
                  (SEQ
                   (LETT |atanhx|
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 18) 1 (QREFELT $ 13))
                          (QREFELT $ 171)))
                   (EXIT (SPADCALL |atanhx| |uts| (QREFELT $ 118)))))
                 ('T (|error| (STRCONC "atanh: " (QREFELT $ 179)))))))) 

(PUT '|SUTS;acosh;2$;85| '|SPADreplace|
     '(XLAM (|uts|)
       (|error| "acosh: acosh undefined on this coefficient domain"))) 

(SDEFUN |SUTS;acosh;2$;85| ((|uts| ($)) ($ ($)))
        (|error| "acosh: acosh undefined on this coefficient domain")) 

(PUT '|SUTS;acoth;2$;86| '|SPADreplace|
     '(XLAM (|uts|)
       (|error| "acoth: acoth undefined on this coefficient domain"))) 

(SDEFUN |SUTS;acoth;2$;86| ((|uts| ($)) ($ ($)))
        (|error| "acoth: acoth undefined on this coefficient domain")) 

(PUT '|SUTS;asech;2$;87| '|SPADreplace|
     '(XLAM (|uts|)
       (|error| "asech: asech undefined on this coefficient domain"))) 

(SDEFUN |SUTS;asech;2$;87| ((|uts| ($)) ($ ($)))
        (|error| "asech: asech undefined on this coefficient domain")) 

(PUT '|SUTS;acsch;2$;88| '|SPADreplace|
     '(XLAM (|uts|)
       (|error| "acsch: acsch undefined on this coefficient domain"))) 

(SDEFUN |SUTS;acsch;2$;88| ((|uts| ($)) ($ ($)))
        (|error| "acsch: acsch undefined on this coefficient domain")) 

(SDEFUN |SUTS;^;$Coef$;89| ((|uts| ($)) (|r| (|Coef|)) ($ ($)))
        (COND
         ((NULL
           (SPADCALL (SPADCALL |uts| 1 (QREFELT $ 109)) (|spadConstant| $ 18)
                     (QREFELT $ 182)))
          (|error| "^: constant coefficient should be 1"))
         ('T (SPADCALL |uts| |r| (QREFELT $ 184))))) 

(SDEFUN |SUTS;coerce;$Of;90| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|count| (|NonNegativeInteger|)))
               (SEQ (LETT |count| |$streamCount|)
                    (SPADCALL |x| |count| (QREFELT $ 15))
                    (EXIT
                     (SPADCALL (SPADCALL |x| (QREFELT $ 51))
                               (SPADCALL |x| (QREFELT $ 93))
                               (SPADCALL |x| (QREFELT $ 107))
                               (SPADCALL |x| (QREFELT $ 53))
                               (|spadConstant| $ 187) (QREFELT $ 189)))))) 

(DECLAIM (NOTINLINE |SparseUnivariateTaylorSeries;|)) 

(DEFUN |SparseUnivariateTaylorSeries| (&REST #1=#:G961)
  (SPROG NIL
         (PROG (#2=#:G962)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache| '|SparseUnivariateTaylorSeries|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |SparseUnivariateTaylorSeries;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseUnivariateTaylorSeries|)))))))))) 

(DEFUN |SparseUnivariateTaylorSeries;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G955 NIL) (#2=#:G956 NIL) (#3=#:G957 NIL) (#4=#:G960 NIL)
    ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|SparseUnivariateTaylorSeries| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 201))
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
    (|haddProp| |$ConstructorCache| '|SparseUnivariateTaylorSeries|
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
    (QSETREFV $ 9 (|InnerSparseUnivariatePowerSeries| |#1|))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 24 (CONS (|dispatchFunction| |SUTS;exquo;2$U;9|) $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 121 (CONS (|dispatchFunction| |SUTS;integrate;$V$;33|) $))
       (QSETREFV $ 125 (CONS (|dispatchFunction| |SUTS;^;3$;34|) $))
       (COND
        ((|testBitVector| |pv$| 5)
         (PROGN
          (QSETREFV $ 128 (CONS (|dispatchFunction| |SUTS;^;$F$;35|) $))
          (QSETREFV $ 124 (CONS (|dispatchFunction| |SUTS;exp;2$;36|) $))
          (QSETREFV $ 122 (CONS (|dispatchFunction| |SUTS;log;2$;37|) $))
          (QSETREFV $ 132 (CONS (|dispatchFunction| |SUTS;sin;2$;38|) $))
          (QSETREFV $ 134 (CONS (|dispatchFunction| |SUTS;cos;2$;39|) $))
          (QSETREFV $ 136 (CONS (|dispatchFunction| |SUTS;tan;2$;40|) $))
          (QSETREFV $ 138 (CONS (|dispatchFunction| |SUTS;cot;2$;41|) $))
          (QSETREFV $ 140 (CONS (|dispatchFunction| |SUTS;sec;2$;42|) $))
          (QSETREFV $ 142 (CONS (|dispatchFunction| |SUTS;csc;2$;43|) $))
          (QSETREFV $ 144 (CONS (|dispatchFunction| |SUTS;asin;2$;44|) $))
          (QSETREFV $ 146 (CONS (|dispatchFunction| |SUTS;acos;2$;45|) $))
          (QSETREFV $ 148 (CONS (|dispatchFunction| |SUTS;atan;2$;46|) $))
          (QSETREFV $ 150 (CONS (|dispatchFunction| |SUTS;acot;2$;47|) $))
          (QSETREFV $ 152 (CONS (|dispatchFunction| |SUTS;asec;2$;48|) $))
          (QSETREFV $ 154 (CONS (|dispatchFunction| |SUTS;acsc;2$;49|) $))
          (QSETREFV $ 156 (CONS (|dispatchFunction| |SUTS;sinh;2$;50|) $))
          (QSETREFV $ 158 (CONS (|dispatchFunction| |SUTS;cosh;2$;51|) $))
          (QSETREFV $ 160 (CONS (|dispatchFunction| |SUTS;tanh;2$;52|) $))
          (QSETREFV $ 162 (CONS (|dispatchFunction| |SUTS;coth;2$;53|) $))
          (QSETREFV $ 164 (CONS (|dispatchFunction| |SUTS;sech;2$;54|) $))
          (QSETREFV $ 166 (CONS (|dispatchFunction| |SUTS;csch;2$;55|) $))
          (QSETREFV $ 168 (CONS (|dispatchFunction| |SUTS;asinh;2$;56|) $))
          (QSETREFV $ 170 (CONS (|dispatchFunction| |SUTS;acosh;2$;57|) $))
          (QSETREFV $ 172 (CONS (|dispatchFunction| |SUTS;atanh;2$;58|) $))
          (QSETREFV $ 174 (CONS (|dispatchFunction| |SUTS;acoth;2$;59|) $))
          (QSETREFV $ 176 (CONS (|dispatchFunction| |SUTS;asech;2$;60|) $))
          (QSETREFV $ 178 (CONS (|dispatchFunction| |SUTS;acsch;2$;61|) $))))
        ('T
         (PROGN
          (QSETREFV $ 179 "series must have constant coefficient zero")
          (QSETREFV $ 180 "series must have constant coefficient one")
          (QSETREFV $ 181 "series expansion has terms of negative degree")
          (QSETREFV $ 128 (CONS (|dispatchFunction| |SUTS;^;$F$;62|) $))
          (QSETREFV $ 124 (CONS (|dispatchFunction| |SUTS;exp;2$;63|) $))
          (QSETREFV $ 122 (CONS (|dispatchFunction| |SUTS;log;2$;64|) $))
          (QSETREFV $ 132 (CONS (|dispatchFunction| |SUTS;sin;2$;65|) $))
          (QSETREFV $ 134 (CONS (|dispatchFunction| |SUTS;cos;2$;66|) $))
          (QSETREFV $ 136 (CONS (|dispatchFunction| |SUTS;tan;2$;67|) $))
          (QSETREFV $ 138 (CONS (|dispatchFunction| |SUTS;cot;2$;68|) $))
          (QSETREFV $ 140 (CONS (|dispatchFunction| |SUTS;sec;2$;69|) $))
          (QSETREFV $ 142 (CONS (|dispatchFunction| |SUTS;csc;2$;70|) $))
          (QSETREFV $ 144 (CONS (|dispatchFunction| |SUTS;asin;2$;71|) $))
          (QSETREFV $ 148 (CONS (|dispatchFunction| |SUTS;atan;2$;72|) $))
          (QSETREFV $ 146 (CONS (|dispatchFunction| |SUTS;acos;2$;73|) $))
          (QSETREFV $ 150 (CONS (|dispatchFunction| |SUTS;acot;2$;74|) $))
          (QSETREFV $ 152 (CONS (|dispatchFunction| |SUTS;asec;2$;75|) $))
          (QSETREFV $ 154 (CONS (|dispatchFunction| |SUTS;acsc;2$;76|) $))
          (QSETREFV $ 156 (CONS (|dispatchFunction| |SUTS;sinh;2$;77|) $))
          (QSETREFV $ 158 (CONS (|dispatchFunction| |SUTS;cosh;2$;78|) $))
          (QSETREFV $ 160 (CONS (|dispatchFunction| |SUTS;tanh;2$;79|) $))
          (QSETREFV $ 162 (CONS (|dispatchFunction| |SUTS;coth;2$;80|) $))
          (QSETREFV $ 164 (CONS (|dispatchFunction| |SUTS;sech;2$;81|) $))
          (QSETREFV $ 166 (CONS (|dispatchFunction| |SUTS;csch;2$;82|) $))
          (QSETREFV $ 168 (CONS (|dispatchFunction| |SUTS;asinh;2$;83|) $))
          (QSETREFV $ 172 (CONS (|dispatchFunction| |SUTS;atanh;2$;84|) $))
          (QSETREFV $ 170 (CONS (|dispatchFunction| |SUTS;acosh;2$;85|) $))
          (QSETREFV $ 174 (CONS (|dispatchFunction| |SUTS;acoth;2$;86|) $))
          (QSETREFV $ 176 (CONS (|dispatchFunction| |SUTS;asech;2$;87|) $))
          (QSETREFV $ 178
                    (CONS (|dispatchFunction| |SUTS;acsch;2$;88|) $))))))))
    (COND
     ((|testBitVector| |pv$| 25)
      (COND
       ((|testBitVector| |pv$| 1)
        (QSETREFV $ 186 (CONS (|dispatchFunction| |SUTS;^;$Coef$;89|) $))))))
    $))) 

(MAKEPROP '|SparseUnivariateTaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|InnerSparseUnivariatePowerSeries| 6)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) '|Rep| (|Integer|)
              (0 . |monomial|) (|NonNegativeInteger|)
              |SUTS;monomial;CoefNni$;4| (6 . |extend|) |SUTS;extend;$Nni$;5|
              (12 . |Zero|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |SUTS;Zero;$;6|) $))
              (16 . |One|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |SUTS;One;$;7|) $))
              (|Union| $ '"failed") (|Boolean|) (20 . |iExquo|)
              |SUTS;recip;$U;8| (27 . |exquo|) (33 . |taylorQuoByVar|)
              |SUTS;quoByVar;2$;10| (38 . |differentiate|)
              (|Variable| (NRTEVAL (QREFELT $ 7))) |SUTS;differentiate;$V$;11|
              (43 . |zero?|) (48 . +) |SUTS;coerce;V$;12|
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 7)) 6) (54 . |zero?|)
              (59 . |monomial|) (65 . +) (71 . |elt|)
              (|Record| (|:| |k| 10) (|:| |c| 6)) (|Stream| 38) (77 . |empty|)
              (81 . |degree|) (86 . |leadingCoefficient|) (91 . |concat|)
              (97 . |reductum|) (|OrderedCompletion| 10) (102 . |plusInfinity|)
              (|Reference| 45) (106 . |ref|) (111 . |makeSeries|)
              |SUTS;coerce;Up$;13| (117 . |getStream|) (122 . |Zero|)
              |SUTS;center;$Coef;26| (126 . -) (132 . |One|)
              (136 . |explicitEntries?|) (141 . |frst|) (146 . ^) (152 . *)
              (158 . *) (164 . |rst|) |SUTS;univariatePolynomial;$NniUp;14|
              (|Polynomial| 6) (169 . |Zero|) (|Symbol|) (173 . |coerce|)
              (178 . |coerce|) (183 . -) (189 . |One|) (193 . ^) (199 . *)
              (205 . *) (211 . +) |SUTS;polynomial;$NniP;15|
              |SUTS;truncate;$2Nni$;18| |SUTS;polynomial;$2NniP;16|
              (217 . |truncate|) |SUTS;truncate;$Nni$;17| (223 . |truncate|)
              (230 . |explicitlyEmpty?|) (|Stream| 6) (235 . |empty|)
              (239 . |coerce|) (244 . |elt|) (249 . <) (255 . |lazyEvaluate|)
              (260 . =) (266 . |One|) (270 . +) (276 . |concat|) (|Mapping| $)
              (282 . |delay|) (287 . |getRef|) |SUTS;coefficients;$S;20|
              (292 . |terms|) (|Record| (|:| |k| 12) (|:| |c| 6)) (|Stream| 96)
              |SUTS;terms;$S;21| (297 . |empty?|) (302 . |setelt!|)
              (308 . |frst|) (313 . |rst|) (318 . |delay|) |SUTS;series;S$;23|
              (323 . |series|) |SUTS;series;S$;24| |SUTS;variable;$S;25|
              (328 . |coefficient|) |SUTS;coefficient;$NniCoef;27|
              |SUTS;elt;$NniCoef;28| |SUTS;pole?;$B;29| (334 . |order|)
              |SUTS;order;$Nni;30| (339 . |order|) |SUTS;order;$2Nni;31|
              (345 . |zero?|) (350 . |coerce|) (355 . |iCompose|)
              |SUTS;elt;3$;32| (361 . |integrate|) (366 . |integrate|)
              (372 . |log|) (377 . *) (383 . |exp|) (388 . ^) (|Fraction| 10)
              (394 . |cRationalPower|) (400 . ^) (406 . |cExp|) (411 . |cLog|)
              (416 . |cSin|) (421 . |sin|) (426 . |cCos|) (431 . |cos|)
              (436 . |cTan|) (441 . |tan|) (446 . |cCot|) (451 . |cot|)
              (456 . |cSec|) (461 . |sec|) (466 . |cCsc|) (471 . |csc|)
              (476 . |cAsin|) (481 . |asin|) (486 . |cAcos|) (491 . |acos|)
              (496 . |cAtan|) (501 . |atan|) (506 . |cAcot|) (511 . |acot|)
              (516 . |cAsec|) (521 . |asec|) (526 . |cAcsc|) (531 . |acsc|)
              (536 . |cSinh|) (541 . |sinh|) (546 . |cCosh|) (551 . |cosh|)
              (556 . |cTanh|) (561 . |tanh|) (566 . |cCoth|) (571 . |coth|)
              (576 . |cSech|) (581 . |sech|) (586 . |cCsch|) (591 . |csch|)
              (596 . |cAsinh|) (601 . |asinh|) (606 . |cAcosh|) (611 . |acosh|)
              (616 . |cAtanh|) (621 . |atanh|) (626 . |cAcoth|) (631 . |acoth|)
              (636 . |cAsech|) (641 . |asech|) (646 . |cAcsch|) (651 . |acsch|)
              'ZERO 'ONE 'NPOWERS (656 . =) (662 . |coerce|) (667 . |cPower|)
              (673 . -) (679 . ^) (685 . |One|) (|OutputForm|)
              (689 . |seriesToOutputForm|) |SUTS;coerce;$Of;90|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|List| 65) (|List| 12) (|List| 96) (|Mapping| 6 10)
              (|PositiveInteger|) (|Mapping| 6 6) (|String|) (|SingleInteger|)
              (|HashState|))
           '#(~= 698 |zero?| 704 |variable| 709 |univariatePolynomial| 714
              |unitNormal| 720 |unitCanonical| 725 |unit?| 730 |truncate| 735
              |terms| 748 |tanh| 753 |tan| 758 |subtractIfCan| 763 |sqrt| 769
              |sinh| 774 |sin| 779 |series| 784 |sech| 794 |sec| 799 |sample|
              804 |rightRecip| 808 |rightPower| 813 |reductum| 825 |recip| 830
              |quoByVar| 835 |polynomial| 840 |pole?| 853 |pi| 858 |order| 862
              |opposite?| 873 |one?| 879 |nthRoot| 884 |multiplyExponents| 890
              |multiplyCoefficients| 896 |monomial?| 902 |monomial| 907 |map|
              913 |log| 919 |leftRecip| 924 |leftPower| 929 |leadingTerm| 941
              |leadingSupport| 946 |leadingMonomial| 951 |leadingCoefficient|
              956 |latex| 961 |integrate| 966 |hashUpdate!| 983 |hash| 989
              |extend| 994 |exquo| 1000 |exp| 1006 |eval| 1011 |elt| 1017
              |differentiate| 1029 |degree| 1072 |csch| 1077 |csc| 1082 |coth|
              1087 |cot| 1092 |cosh| 1097 |cos| 1102 |constructOrdered| 1107
              |construct| 1112 |complete| 1117 |commutator| 1122 |coerce| 1128
              |coefficients| 1163 |coefficient| 1168 |charthRoot| 1174
              |characteristic| 1179 |center| 1183 |atanh| 1188 |atan| 1193
              |associator| 1198 |associates?| 1205 |asinh| 1211 |asin| 1216
              |asech| 1221 |asec| 1226 |approximate| 1231 |antiCommutator| 1237
              |annihilate?| 1243 |acsch| 1249 |acsc| 1254 |acoth| 1259 |acot|
              1264 |acosh| 1269 |acos| 1274 ^ 1279 |Zero| 1309 |One| 1313 D
              1317 = 1354 / 1360 - 1366 + 1377 * 1383)
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
                 (|UnivariateSeriesWithRationalExponents| 6 12)
                 (|UnivariatePowerSeriesCategory| 6 12)
                 (|PowerSeriesCategory| 6 12 (|SingletonAsOrderedSet|))
                 (|AbelianMonoidRing| 6 12) (|IntegralDomain|)
                 (|CommutativeRing|) (|Algebra| 126) (|Algebra| $$)
                 (|EntireRing|) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6)
                 (|PartialDifferentialRing| 65) (|DifferentialRing|) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 126) (|Module| $$)
                 (|Module| 6) (|IndexedProductCategory| 6 12) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 126 126) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 126) (|RightModule| 126) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|Magma|) (|AbelianSemiGroup|)
                 (|SetCategory|) (|CommutativeStar|)
                 (|TranscendentalFunctionCategory|)
                 (|VariablesCommuteWithCoefficients|) (|BasicType|)
                 (|CoercibleTo| 188) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|unitsKnown|) (|Eltable| $$ $$)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|))
              (|makeByteWordVec2| 200
                                  '(2 9 0 6 10 11 2 9 0 0 10 14 0 6 0 16 0 6 0
                                    18 3 9 20 0 0 21 22 2 0 20 0 0 24 1 9 0 0
                                    25 1 0 0 0 27 1 6 21 0 30 2 0 0 0 0 31 1 33
                                    21 0 34 2 33 0 6 12 35 2 33 0 0 0 36 2 33 0
                                    0 0 37 0 39 0 40 1 33 12 0 41 1 33 6 0 42 2
                                    39 0 38 0 43 1 33 0 0 44 0 45 0 46 1 47 0
                                    45 48 2 9 0 47 39 49 1 9 39 0 51 0 33 0 52
                                    2 33 0 0 0 54 0 33 0 55 1 39 21 0 56 1 39
                                    38 0 57 2 33 0 0 12 58 2 33 0 0 0 59 2 33 0
                                    6 0 60 1 39 0 0 61 0 63 0 64 1 63 0 65 66 1
                                    63 0 6 67 2 63 0 0 0 68 0 63 0 69 2 63 0 0
                                    12 70 2 63 0 0 0 71 2 63 0 6 0 72 2 63 0 0
                                    0 73 2 9 0 0 10 77 3 9 0 0 10 10 79 1 39 21
                                    0 80 0 81 0 82 1 45 0 10 83 1 47 45 0 84 2
                                    45 21 0 0 85 1 39 0 0 86 2 10 21 0 0 87 0
                                    10 0 88 2 10 0 0 0 89 2 81 0 6 0 90 1 81 0
                                    91 92 1 9 47 0 93 1 9 39 0 95 1 81 21 0 99
                                    2 47 45 0 45 100 1 81 6 0 101 1 81 0 0 102
                                    1 39 0 91 103 1 9 0 39 105 2 9 6 0 10 108 1
                                    9 10 0 112 2 9 10 0 10 114 1 0 21 0 116 1 0
                                    0 6 117 2 9 0 0 0 118 1 0 0 0 120 2 0 0 0
                                    28 121 1 0 0 0 122 2 0 0 0 0 123 1 0 0 0
                                    124 2 0 0 0 0 125 2 9 0 0 126 127 2 0 0 0
                                    126 128 1 9 0 0 129 1 9 0 0 130 1 9 0 0 131
                                    1 0 0 0 132 1 9 0 0 133 1 0 0 0 134 1 9 0 0
                                    135 1 0 0 0 136 1 9 0 0 137 1 0 0 0 138 1 9
                                    0 0 139 1 0 0 0 140 1 9 0 0 141 1 0 0 0 142
                                    1 9 0 0 143 1 0 0 0 144 1 9 0 0 145 1 0 0 0
                                    146 1 9 0 0 147 1 0 0 0 148 1 9 0 0 149 1 0
                                    0 0 150 1 9 0 0 151 1 0 0 0 152 1 9 0 0 153
                                    1 0 0 0 154 1 9 0 0 155 1 0 0 0 156 1 9 0 0
                                    157 1 0 0 0 158 1 9 0 0 159 1 0 0 0 160 1 9
                                    0 0 161 1 0 0 0 162 1 9 0 0 163 1 0 0 0 164
                                    1 9 0 0 165 1 0 0 0 166 1 9 0 0 167 1 0 0 0
                                    168 1 9 0 0 169 1 0 0 0 170 1 9 0 0 171 1 0
                                    0 0 172 1 9 0 0 173 1 0 0 0 174 1 9 0 0 175
                                    1 0 0 0 176 1 9 0 0 177 1 0 0 0 178 2 6 21
                                    0 0 182 1 6 0 126 183 2 9 0 0 6 184 2 0 0 0
                                    0 185 2 0 0 0 6 186 0 126 0 187 5 9 188 39
                                    47 65 6 126 189 2 0 21 0 0 1 1 31 21 0 116
                                    1 0 65 0 107 2 0 33 0 12 62 1 26 191 0 1 1
                                    26 0 0 1 1 26 21 0 1 3 0 0 0 12 12 75 2 0 0
                                    0 12 78 1 0 97 0 98 1 1 0 0 160 1 1 0 0 136
                                    2 32 20 0 0 1 1 1 0 0 1 1 1 0 0 156 1 1 0 0
                                    132 1 0 0 81 104 1 0 0 97 106 1 1 0 0 164 1
                                    1 0 0 140 0 31 0 1 1 29 20 0 1 2 29 0 0 12
                                    1 2 0 0 0 196 1 1 10 0 0 1 1 29 20 0 23 1 0
                                    0 0 26 2 0 63 0 12 74 3 0 63 0 12 12 76 1 0
                                    21 0 111 0 1 0 1 2 0 12 0 12 115 1 0 12 0
                                    113 2 31 21 0 0 1 1 29 21 0 1 2 1 0 0 10 1
                                    2 0 0 0 196 1 2 0 0 195 0 1 1 0 21 0 1 2 0
                                    0 6 12 13 2 0 0 197 0 1 1 1 0 0 122 1 29 20
                                    0 1 2 29 0 0 12 1 2 0 0 0 196 1 1 10 96 0 1
                                    1 10 12 0 1 1 0 0 0 1 1 0 6 0 1 1 0 198 0 1
                                    2 24 0 0 65 1 2 1 0 0 28 121 1 1 0 0 120 2
                                    0 200 200 0 1 1 0 199 0 1 2 0 0 0 12 15 2
                                    26 20 0 0 24 1 1 0 0 124 2 11 81 0 6 1 2 9
                                    0 0 0 119 2 0 6 0 12 110 2 8 0 0 192 1 2 8
                                    0 0 65 1 3 8 0 0 192 193 1 3 8 0 0 65 12 1
                                    1 7 0 0 27 2 7 0 0 12 1 2 0 0 0 28 29 1 0
                                    12 0 1 1 1 0 0 166 1 1 0 0 142 1 1 0 0 162
                                    1 1 0 0 138 1 1 0 0 158 1 1 0 0 134 1 10 0
                                    194 1 1 0 0 194 1 1 0 0 0 1 2 30 0 0 0 1 1
                                    27 0 6 117 1 30 0 10 1 1 28 0 0 1 1 1 0 126
                                    1 1 0 0 28 32 1 0 0 33 50 1 0 188 0 190 1 0
                                    81 0 94 2 0 6 0 12 109 1 3 20 0 1 0 30 12 1
                                    1 0 6 0 53 1 1 0 0 172 1 1 0 0 148 3 30 0 0
                                    0 0 1 2 26 21 0 0 1 1 1 0 0 168 1 1 0 0 144
                                    1 1 0 0 176 1 1 0 0 152 2 12 6 0 12 1 2 0 0
                                    0 0 1 2 30 21 0 0 1 1 1 0 0 178 1 1 0 0 154
                                    1 1 0 0 174 1 1 0 0 150 1 1 0 0 170 1 1 0 0
                                    146 2 29 0 0 12 1 2 1 0 0 126 128 2 1 0 0 0
                                    125 2 25 0 0 6 186 2 0 0 0 196 1 0 31 0 17
                                    0 29 0 19 2 8 0 0 192 1 2 8 0 0 65 1 3 8 0
                                    0 192 193 1 3 8 0 0 65 12 1 1 7 0 0 1 2 7 0
                                    0 12 1 2 0 21 0 0 1 2 25 0 0 6 1 1 33 0 0 1
                                    2 33 0 0 0 185 2 0 0 0 0 31 2 33 0 10 0 1 2
                                    31 0 12 0 1 2 1 0 0 126 1 2 1 0 126 0 1 2 0
                                    0 0 6 1 2 0 0 6 0 1 2 0 0 0 0 123 2 0 0 196
                                    0 1)))))
           '|lookupComplete|)) 
