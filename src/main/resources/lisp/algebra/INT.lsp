
(SDEFUN |INT;writeOMInt| ((|dev| (|OpenMathDevice|)) (|x| ($)) ($ (|Void|)))
        (SEQ
         (COND
          ((< |x| 0)
           (SEQ (SPADCALL |dev| (QREFELT $ 8))
                (SPADCALL |dev| "arith1" "unary_minus" (QREFELT $ 10))
                (SPADCALL |dev| (- |x|) (QREFELT $ 12))
                (EXIT (SPADCALL |dev| (QREFELT $ 13)))))
          ('T (SPADCALL |dev| |x| (QREFELT $ 12)))))) 

(SDEFUN |INT;OMwrite;Omd$BV;2|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 14))))
             (|INT;writeOMInt| |dev| |x| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 15))))))) 

(PUT '|INT;zero?;$B;3| '|SPADreplace| 'ZEROP) 

(SDEFUN |INT;zero?;$B;3| ((|x| ($)) ($ (|Boolean|))) (ZEROP |x|)) 

(PUT '|INT;one?;$B;4| '|SPADreplace| '(XLAM (|x|) (EQL |x| 1))) 

(SDEFUN |INT;one?;$B;4| ((|x| ($)) ($ (|Boolean|))) (EQL |x| 1)) 

(PUT '|INT;Zero;$;5| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |INT;Zero;$;5| (($ ($))) 0) 

(PUT '|INT;One;$;6| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |INT;One;$;6| (($ ($))) 1) 

(PUT '|INT;base;$;7| '|SPADreplace| '(XLAM NIL 2)) 

(SDEFUN |INT;base;$;7| (($ ($))) 2) 

(PUT '|INT;copy;2$;8| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |INT;copy;2$;8| ((|x| ($)) ($ ($))) |x|) 

(PUT '|INT;inc;2$;9| '|SPADreplace| '(XLAM (|x|) (+ |x| 1))) 

(SDEFUN |INT;inc;2$;9| ((|x| ($)) ($ ($))) (+ |x| 1)) 

(PUT '|INT;dec;2$;10| '|SPADreplace| '(XLAM (|x|) (- |x| 1))) 

(SDEFUN |INT;dec;2$;10| ((|x| ($)) ($ ($))) (- |x| 1)) 

(SDEFUN |INT;hashUpdate!;Hs$Hs;11| ((|hs| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (HASHSTATEUPDATE |hs| (SXHASH |s|))) 

(PUT '|INT;negative?;$B;12| '|SPADreplace| 'MINUSP) 

(SDEFUN |INT;negative?;$B;12| ((|x| ($)) ($ (|Boolean|))) (MINUSP |x|)) 

(PUT '|INT;positive?;$B;13| '|SPADreplace| 'PLUSP) 

(SDEFUN |INT;positive?;$B;13| ((|x| ($)) ($ (|Boolean|))) (PLUSP |x|)) 

(SDEFUN |INT;coerce;$Of;14| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 31))) 

(PUT '|INT;coerce;2$;15| '|SPADreplace| '(XLAM (|m|) |m|)) 

(SDEFUN |INT;coerce;2$;15| ((|m| (|Integer|)) ($ ($))) |m|) 

(PUT '|INT;convert;2$;16| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |INT;convert;2$;16| ((|x| ($)) ($ (|Integer|))) |x|) 

(PUT '|INT;length;2$;17| '|SPADreplace| 'INTEGER-LENGTH) 

(SDEFUN |INT;length;2$;17| ((|a| ($)) ($ ($))) (INTEGER-LENGTH |a|)) 

(SDEFUN |INT;addmod;4$;18| ((|a| ($)) (|b| ($)) (|p| ($)) ($ ($)))
        (SPROG ((|c| ($)))
               (SEQ (LETT |c| (+ |a| |b|))
                    (EXIT (COND ((>= |c| |p|) (- |c| |p|)) ('T |c|)))))) 

(SDEFUN |INT;submod;4$;19| ((|a| ($)) (|b| ($)) (|p| ($)) ($ ($)))
        (SPROG ((|c| ($)))
               (SEQ (LETT |c| (- |a| |b|))
                    (EXIT (COND ((< |c| 0) (+ |c| |p|)) ('T |c|)))))) 

(SDEFUN |INT;mulmod;4$;20| ((|a| ($)) (|b| ($)) (|p| ($)) ($ ($)))
        (REM (* |a| |b|) |p|)) 

(SDEFUN |INT;convert;$F;21| ((|x| ($)) ($ (|Float|)))
        (SPADCALL |x| (QREFELT $ 40))) 

(PUT '|INT;convert;$Df;22| '|SPADreplace|
     '(XLAM (|x|) (FLOAT |x| MOST-POSITIVE-DOUBLE-FLOAT))) 

(SDEFUN |INT;convert;$Df;22| ((|x| ($)) ($ (|DoubleFloat|)))
        (FLOAT |x| MOST-POSITIVE-DOUBLE-FLOAT)) 

(SDEFUN |INT;convert;$If;23| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL |x| (QREFELT $ 45))) 

(PUT '|INT;convert;$S;24| '|SPADreplace| 'STRINGIMAGE) 

(SDEFUN |INT;convert;$S;24| ((|x| ($)) ($ (|String|))) (STRINGIMAGE |x|)) 

(SDEFUN |INT;latex;$S;25| ((|x| ($)) ($ (|String|)))
        (SPROG ((|s| (|String|)))
               (SEQ (LETT |s| (STRINGIMAGE |x|))
                    (COND ((<= 0 |x|) (COND ((< |x| 10) (EXIT |s|)))))
                    (EXIT (STRCONC "{" (STRCONC |s| "}")))))) 

(SDEFUN |INT;positiveRemainder;3$;26| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (COND
                ((MINUSP (LETT |r| (REM |a| |b|)))
                 (COND ((MINUSP |b|) (- |r| |b|)) (#1='T (+ |r| |b|))))
                (#1# |r|)))) 

(PUT '|INT;reducedSystem;2M;27| '|SPADreplace| '(XLAM (|m|) |m|)) 

(SDEFUN |INT;reducedSystem;2M;27|
        ((|m| (|Matrix| $)) ($ (|Matrix| (|Integer|)))) |m|) 

(PUT '|INT;reducedSystem;MVR;28| '|SPADreplace| 'CONS) 

(SDEFUN |INT;reducedSystem;MVR;28|
        ((|m| (|Matrix| $)) (|vec| (|Vector| $))
         ($
          (|Record| (|:| |mat| (|Matrix| (|Integer|)))
                    (|:| |vec| (|Vector| (|Integer|))))))
        (CONS |m| |vec|)) 

(PUT '|INT;abs;2$;29| '|SPADreplace| 'ABS) 

(SDEFUN |INT;abs;2$;29| ((|x| ($)) ($ ($))) (ABS |x|)) 

(PUT '|INT;random;2$;30| '|SPADreplace| 'RANDOM) 

(SDEFUN |INT;random;2$;30| ((|x| ($)) ($ ($))) (RANDOM |x|)) 

(PUT '|INT;seedRandom;V;31| '|SPADreplace| 'SEEDRANDOM) 

(SDEFUN |INT;seedRandom;V;31| (($ (|Void|))) (SEEDRANDOM)) 

(PUT '|INT;=;2$B;32| '|SPADreplace| 'EQL) 

(SDEFUN |INT;=;2$B;32| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQL |x| |y|)) 

(PUT '|INT;<;2$B;33| '|SPADreplace| '<) 

(SDEFUN |INT;<;2$B;33| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (< |x| |y|)) 

(PUT '|INT;>;2$B;34| '|SPADreplace| '>) 

(SDEFUN |INT;>;2$B;34| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (> |x| |y|)) 

(PUT '|INT;>=;2$B;35| '|SPADreplace| '>=) 

(SDEFUN |INT;>=;2$B;35| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (>= |x| |y|)) 

(PUT '|INT;<=;2$B;36| '|SPADreplace| '<=) 

(SDEFUN |INT;<=;2$B;36| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (<= |x| |y|)) 

(PUT '|INT;-;2$;37| '|SPADreplace| '-) 

(SDEFUN |INT;-;2$;37| ((|x| ($)) ($ ($))) (- |x|)) 

(PUT '|INT;+;3$;38| '|SPADreplace| '+) 

(SDEFUN |INT;+;3$;38| ((|x| ($)) (|y| ($)) ($ ($))) (+ |x| |y|)) 

(PUT '|INT;-;3$;39| '|SPADreplace| '-) 

(SDEFUN |INT;-;3$;39| ((|x| ($)) (|y| ($)) ($ ($))) (- |x| |y|)) 

(PUT '|INT;*;3$;40| '|SPADreplace| '*) 

(SDEFUN |INT;*;3$;40| ((|x| ($)) (|y| ($)) ($ ($))) (* |x| |y|)) 

(PUT '|INT;*;3$;41| '|SPADreplace| '*) 

(SDEFUN |INT;*;3$;41| ((|m| (|Integer|)) (|y| ($)) ($ ($))) (* |m| |y|)) 

(PUT '|INT;*;Pi2$;42| '|SPADreplace| '*) 

(SDEFUN |INT;*;Pi2$;42| ((|m| (|PositiveInteger|)) (|y| ($)) ($ ($)))
        (* |m| |y|)) 

(PUT '|INT;*;Nni2$;43| '|SPADreplace| '*) 

(SDEFUN |INT;*;Nni2$;43| ((|m| (|NonNegativeInteger|)) (|y| ($)) ($ ($)))
        (* |m| |y|)) 

(PUT '|INT;^;$Nni$;44| '|SPADreplace| 'EXPT) 

(SDEFUN |INT;^;$Nni$;44| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (EXPT |x| |n|)) 

(PUT '|INT;^;$Pi$;45| '|SPADreplace| 'EXPT) 

(SDEFUN |INT;^;$Pi$;45| ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (EXPT |x| |n|)) 

(PUT '|INT;odd?;$B;46| '|SPADreplace| 'ODDP) 

(SDEFUN |INT;odd?;$B;46| ((|x| ($)) ($ (|Boolean|))) (ODDP |x|)) 

(PUT '|INT;even?;$B;47| '|SPADreplace| 'EVENP) 

(SDEFUN |INT;even?;$B;47| ((|x| ($)) ($ (|Boolean|))) (EVENP |x|)) 

(PUT '|INT;max;3$;48| '|SPADreplace| 'MAX) 

(SDEFUN |INT;max;3$;48| ((|x| ($)) (|y| ($)) ($ ($))) (MAX |x| |y|)) 

(PUT '|INT;min;3$;49| '|SPADreplace| 'MIN) 

(SDEFUN |INT;min;3$;49| ((|x| ($)) (|y| ($)) ($ ($))) (MIN |x| |y|)) 

(PUT '|INT;divide;2$R;50| '|SPADreplace| 'DIVIDE2) 

(SDEFUN |INT;divide;2$R;50|
        ((|x| ($)) (|y| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (DIVIDE2 |x| |y|)) 

(PUT '|INT;quo;3$;51| '|SPADreplace| 'QUOTIENT2) 

(SDEFUN |INT;quo;3$;51| ((|x| ($)) (|y| ($)) ($ ($))) (QUOTIENT2 |x| |y|)) 

(PUT '|INT;rem;3$;52| '|SPADreplace| 'REM) 

(SDEFUN |INT;rem;3$;52| ((|x| ($)) (|y| ($)) ($ ($))) (REM |x| |y|)) 

(PUT '|INT;shift;3$;53| '|SPADreplace| 'ASH) 

(SDEFUN |INT;shift;3$;53| ((|x| ($)) (|y| ($)) ($ ($))) (ASH |x| |y|)) 

(SDEFUN |INT;exquo;2$U;54| ((|x| ($)) (|y| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|z| (|SExpression|)))
               (SEQ
                (COND ((ZEROP |y|) (CONS 1 "failed"))
                      (#1='T
                       (SEQ (LETT |z| (INTEXQUO |x| |y|))
                            (EXIT
                             (COND ((SPADCALL |z| (QREFELT $ 85)) (CONS 0 |z|))
                                   (#1# (CONS 1 "failed")))))))))) 

(SDEFUN |INT;recip;$U;55| ((|x| ($)) ($ (|Union| $ "failed")))
        (COND ((OR (EQL |x| 1) (EQL |x| -1)) (CONS 0 |x|))
              ('T (CONS 1 "failed")))) 

(PUT '|INT;gcd;3$;56| '|SPADreplace| 'GCD) 

(SDEFUN |INT;gcd;3$;56| ((|x| ($)) (|y| ($)) ($ ($))) (GCD |x| |y|)) 

(SDEFUN |INT;unitNormal;$R;57|
        ((|x| ($))
         ($ (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))))
        (COND ((< |x| 0) (VECTOR -1 (- |x|) -1)) ('T (VECTOR 1 |x| 1)))) 

(PUT '|INT;unitCanonical;2$;58| '|SPADreplace| 'ABS) 

(SDEFUN |INT;unitCanonical;2$;58| ((|x| ($)) ($ ($))) (ABS |x|)) 

(SDEFUN |INT;solveLinearPolynomialEquation;LSupU;59|
        ((|lp| (|List| #1=(|SparseUnivariatePolynomial| $))) (|p| #1#)
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| $)) "failed")))
        (SPADCALL |lp| |p| (QREFELT $ 97))) 

(SDEFUN |INT;squareFreePolynomial;SupF;60|
        ((|p| (|SparseUnivariatePolynomial| $))
         ($ (|Factored| (|SparseUnivariatePolynomial| $))))
        (SPADCALL |p| (QREFELT $ 105))) 

(SDEFUN |INT;factorPolynomial;SupF;61|
        ((|p| (|SparseUnivariatePolynomial| $))
         ($ (|Factored| (|SparseUnivariatePolynomial| $))))
        (SPROG ((#1=#:G2042 NIL) (|pp| (|SparseUnivariatePolynomial| $)))
               (SEQ (LETT |pp| (SPADCALL |p| (QREFELT $ 108)))
                    (EXIT
                     (COND
                      ((EQL (SPADCALL |pp| (QREFELT $ 109))
                            (SPADCALL |p| (QREFELT $ 109)))
                       (SPADCALL |p| (QREFELT $ 111)))
                      ('T
                       (SPADCALL (SPADCALL |pp| (QREFELT $ 111))
                                 (SPADCALL (ELT $ 112)
                                           (SPADCALL
                                            (PROG2
                                                (LETT #1#
                                                      (SPADCALL
                                                       (SPADCALL |p|
                                                                 (QREFELT $
                                                                          109))
                                                       (SPADCALL |pp|
                                                                 (QREFELT $
                                                                          109))
                                                       (QREFELT $ 87)))
                                                (QCDR #1#)
                                              (|check_union2| (QEQCAR #1# 0) $
                                                              (|Union| $
                                                                       "failed")
                                                              #1#))
                                            (QREFELT $ 114))
                                           (QREFELT $ 118))
                                 (QREFELT $ 119)))))))) 

(SDEFUN |INT;factorSquareFreePolynomial;SupF;62|
        ((|p| (|SparseUnivariatePolynomial| $))
         ($ (|Factored| (|SparseUnivariatePolynomial| $))))
        (SPADCALL |p| (QREFELT $ 121))) 

(SDEFUN |INT;gcdPolynomial;3Sup;63|
        ((|p| #1=(|SparseUnivariatePolynomial| $)) (|q| #1#)
         ($ (|SparseUnivariatePolynomial| $)))
        (COND ((SPADCALL |p| (QREFELT $ 123)) (SPADCALL |q| (QREFELT $ 124)))
              ((SPADCALL |q| (QREFELT $ 123)) (SPADCALL |p| (QREFELT $ 124)))
              ('T (SPADCALL (LIST |p| |q|) (QREFELT $ 127))))) 

(SDEFUN |INT;opposite?;2$B;64| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (EQL |x| (- |y|))) 

(SDEFUN |INT;annihilate?;2$B;65| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((ZEROP |x|) 'T) ('T (ZEROP |y|)))) 

(SDEFUN |INT;powmod;4$;66| ((|x| ($)) (|n| ($)) (|p| ($)) ($ ($)))
        (SPROG ((|z| ($)) (#1=#:G2062 NIL) (|y| ($)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((MINUSP |x|) (LETT |x| (SPADCALL |x| |p| (QREFELT $ 49)))))
                  (EXIT
                   (COND ((ZEROP |x|) 0) ((ZEROP |n|) 1)
                         ('T
                          (SEQ (LETT |y| 1) (LETT |z| |x|)
                               (EXIT
                                (SEQ G190 NIL
                                     (SEQ
                                      (COND
                                       ((ODDP |n|)
                                        (LETT |y|
                                              (SPADCALL |y| |z| |p|
                                                        (QREFELT $ 38)))))
                                      (EXIT
                                       (COND
                                        ((ZEROP (LETT |n| (ASH |n| -1)))
                                         (PROGN
                                          (LETT #1# |y|)
                                          (GO #2=#:G2061)))
                                        ('T
                                         (LETT |z|
                                               (SPADCALL |z| |z| |p|
                                                         (QREFELT $ 38)))))))
                                     NIL (GO G190) G191 (EXIT NIL)))))))))
                #2# (EXIT #1#)))) 

(SDEFUN |INT;symmetricRemainder;3$;67| ((|x| ($)) (|n| ($)) ($ ($)))
        (SPROG ((|r| ($)))
               (SEQ (LETT |r| (REM |x| |n|))
                    (EXIT
                     (COND ((EQL |r| 0) 0)
                           (#1='T
                            (SEQ (COND ((< |n| 0) (LETT |n| (- |n|))))
                                 (EXIT
                                  (COND
                                   ((> |r| 0)
                                    (COND ((> (* 2 |r|) |n|) (- |r| |n|))
                                          (#1# |r|)))
                                   ((<= (+ (* 2 |r|) |n|) 0) (+ |r| |n|))
                                   (#1# |r|)))))))))) 

(DECLAIM (NOTINLINE |Integer;|)) 

(DEFUN |Integer| ()
  (SPROG NIL
         (PROG (#1=#:G2088)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Integer|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Integer|
                             (LIST (CONS NIL (CONS 1 (|Integer;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Integer|)))))))))) 

(DEFUN |Integer;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Integer|))
          (LETT $ (GETREFV 147))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Integer| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|CharacteristicNonZero|))
               (|augmentPredVector| $ 1))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 67
                    (QSETREFV $ 68
                              (CONS (|dispatchFunction| |INT;*;3$;41|) $)))
          $))) 

(MAKEPROP '|Integer| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Void|) (|OpenMathDevice|)
              (0 . |OMputApp|) (|String|) (5 . |OMputSymbol|) (|Integer|)
              (12 . |OMputInteger|) (18 . |OMputEndApp|) (23 . |OMputObject|)
              (28 . |OMputEndObject|) (|Boolean|) |INT;OMwrite;Omd$BV;2|
              |INT;zero?;$B;3| |INT;one?;$B;4|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |INT;Zero;$;5|) $))
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |INT;One;$;6|) $))
              |INT;base;$;7| |INT;copy;2$;8| |INT;inc;2$;9| |INT;dec;2$;10|
              (|HashState|) |INT;hashUpdate!;Hs$Hs;11| |INT;negative?;$B;12|
              |INT;positive?;$B;13| (|OutputForm|) (33 . |outputForm|)
              |INT;coerce;$Of;14| |INT;coerce;2$;15| |INT;convert;2$;16|
              |INT;length;2$;17| |INT;addmod;4$;18| |INT;submod;4$;19|
              |INT;mulmod;4$;20| (|Float|) (38 . |coerce|) |INT;convert;$F;21|
              (|DoubleFloat|) |INT;convert;$Df;22| (|InputForm|)
              (43 . |convert|) |INT;convert;$If;23| |INT;convert;$S;24|
              |INT;latex;$S;25| |INT;positiveRemainder;3$;26| (|Matrix| 11)
              (|Matrix| $) |INT;reducedSystem;2M;27|
              (|Record| (|:| |mat| 50) (|:| |vec| (|Vector| 11))) (|Vector| $)
              |INT;reducedSystem;MVR;28| |INT;abs;2$;29| |INT;random;2$;30|
              |INT;seedRandom;V;31| |INT;=;2$B;32| |INT;<;2$B;33|
              |INT;>;2$B;34| |INT;>=;2$B;35| |INT;<=;2$B;36| |INT;-;2$;37|
              |INT;+;3$;38| |INT;-;3$;39| NIL NIL (|PositiveInteger|)
              |INT;*;Pi2$;42| (|NonNegativeInteger|) |INT;*;Nni2$;43|
              |INT;^;$Nni$;44| |INT;^;$Pi$;45| |INT;odd?;$B;46|
              |INT;even?;$B;47| |INT;max;3$;48| |INT;min;3$;49|
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              |INT;divide;2$R;50| |INT;quo;3$;51| |INT;rem;3$;52|
              |INT;shift;3$;53| (|SExpression|) (48 . |integer?|)
              (|Union| $ '"failed") |INT;exquo;2$U;54| |INT;recip;$U;55|
              |INT;gcd;3$;56|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              |INT;unitNormal;$R;57| |INT;unitCanonical;2$;58|
              (|Union| 94 '"failed") (|List| 95)
              (|SparseUnivariatePolynomial| 11)
              (|IntegerSolveLinearPolynomialEquation|)
              (53 . |solveLinearPolynomialEquation|) (|Union| 99 '"failed")
              (|List| 100) (|SparseUnivariatePolynomial| $)
              |INT;solveLinearPolynomialEquation;LSupU;59| (|Factored| 103)
              (|SparseUnivariatePolynomial| $$)
              (|UnivariatePolynomialSquareFree| $$ 103) (59 . |squareFree|)
              (|Factored| 100) |INT;squareFreePolynomial;SupF;60|
              (64 . |primitivePart|) (69 . |leadingCoefficient|)
              (|GaloisGroupFactorizer| 103) (74 . |factor|) (79 . |coerce|)
              (|Factored| $) (84 . |factor|) (|Mapping| 103 $$) (|Factored| $$)
              (|FactoredFunctions2| $$ 103) (89 . |map|) (95 . |mergeFactors|)
              |INT;factorPolynomial;SupF;61| (101 . |factorSquareFree|)
              |INT;factorSquareFreePolynomial;SupF;62| (106 . |zero?|)
              (111 . |unitCanonical|) (|List| 103) (|HeuGcd| 103) (116 . |gcd|)
              |INT;gcdPolynomial;3Sup;63| |INT;opposite?;2$B;64|
              |INT;annihilate?;2$B;65| |INT;powmod;4$;66|
              |INT;symmetricRemainder;3$;67| (|Union| 54 '"failed")
              (|Union| 135 '"failed") (|Fraction| 11) (|Pattern| 11)
              (|PatternMatchResult| 11 $) (|Union| 11 '"failed")
              (|Record| (|:| |coef| 140) (|:| |generator| $)) (|List| $)
              (|Union| 140 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 142 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|SingleInteger|))
           '#(~= 121 |zero?| 127 |unitNormal| 132 |unitCanonical| 137 |unit?|
              142 |symmetricRemainder| 147 |subtractIfCan| 153 |submod| 159
              |squareFreePolynomial| 166 |squareFreePart| 171 |squareFree| 176
              |solveLinearPolynomialEquation| 181 |smaller?| 187 |sizeLess?|
              193 |sign| 199 |shift| 204 |seedRandom| 210 |sample| 214
              |rightRecip| 218 |rightPower| 223 |retractIfCan| 235 |retract|
              240 |rem| 245 |reducedSystem| 251 |recip| 262 |rationalIfCan| 267
              |rational?| 272 |rational| 277 |random| 282 |quo| 287
              |principalIdeal| 293 |prime?| 298 |powmod| 303
              |positiveRemainder| 310 |positive?| 316 |permutation| 321
              |patternMatch| 327 |opposite?| 334 |one?| 340 |odd?| 345
              |nextItem| 350 |negative?| 355 |multiEuclidean| 360 |mulmod| 366
              |min| 373 |max| 379 |mask| 385 |length| 390 |leftRecip| 395
              |leftPower| 400 |lcmCoef| 412 |lcm| 418 |latex| 429 |invmod| 434
              |init| 440 |inc| 444 |hashUpdate!| 449 |hash| 455 |gcdPolynomial|
              460 |gcd| 466 |factorial| 477 |factorSquareFreePolynomial| 482
              |factorPolynomial| 487 |factor| 492 |extendedEuclidean| 497
              |exquo| 510 |expressIdealMember| 516 |even?| 522 |euclideanSize|
              527 |divide| 532 |differentiate| 538 |dec| 549 |copy| 554
              |convert| 559 |conditionP| 589 |commutator| 594 |coerce| 600
              |charthRoot| 615 |characteristic| 620 |bit?| 624 |binomial| 630
              |base| 636 |associator| 640 |associates?| 647 |antiCommutator|
              653 |annihilate?| 659 |addmod| 665 |abs| 672 ^ 677 |Zero| 689
              |One| 693 |OMwrite| 697 D 721 >= 732 > 738 = 744 <= 750 < 756 -
              762 + 773 * 779)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|IntegerNumberSystem&| |PolynomialFactorizationExplicit&|
                |EuclideanDomain&| |UniqueFactorizationDomain&| NIL NIL
                |GcdDomain&| NIL |OrderedRing&| NIL NIL NIL |DifferentialRing&|
                NIL |EntireRing&| |Algebra&| NIL |Rng&| NIL |Module&| NIL NIL
                NIL |NonAssociativeRing&| NIL NIL |NonAssociativeRng&| NIL NIL
                |AbelianGroup&| NIL NIL NIL NIL |OrderedSet&| NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&| NIL
                NIL NIL |Magma&| |AbelianSemiGroup&| NIL |RetractableTo&| NIL
                |SetCategory&| NIL NIL |OpenMath&| NIL NIL NIL NIL NIL NIL NIL
                NIL NIL NIL |PartialOrder&| NIL NIL NIL |BasicType&| NIL)
             (CONS
              '#((|IntegerNumberSystem|) (|PolynomialFactorizationExplicit|)
                 (|EuclideanDomain|) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|OrderedIntegralDomain|)
                 (|GcdDomain|) (|IntegralDomain|) (|OrderedRing|)
                 (|CommutativeRing|) (|LeftOreRing|)
                 (|LinearlyExplicitOver| 11) (|DifferentialRing|)
                 (|CharacteristicZero|) (|EntireRing|) (|Algebra| $$) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| $$) (|SemiRng|)
                 (|OrderedAbelianGroup|) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|OrderedCancellationAbelianMonoid|)
                 (|LeftModule| $$) (|NonAssociativeRng|) (|RightModule| $$)
                 (|OrderedAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianSemiGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedSet|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|StepThrough|)
                 (|PatternMatchable| 11) (|Comparable|) (|Magma|)
                 (|AbelianSemiGroup|) (|RealConstant|) (|RetractableTo| 11)
                 (|CommutativeStar|) (|SetCategory|) (|canonicalsClosed|)
                 (|Canonical|) (|OpenMath|) (|ConvertibleTo| 9)
                 (|multiplicativeValuation|) (|canonicalUnitNormal|)
                 (|ConvertibleTo| 39) (|ConvertibleTo| 42)
                 (|CombinatorialFunctionCategory|) (|ConvertibleTo| 136)
                 (|ConvertibleTo| 44) (|CoercibleFrom| 11) (|ConvertibleTo| 11)
                 (|PartialOrder|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 30))
              (|makeByteWordVec2| 146
                                  '(1 7 6 0 8 3 7 6 0 9 9 10 2 7 6 0 11 12 1 7
                                    6 0 13 1 7 6 0 14 1 7 6 0 15 1 30 0 11 31 1
                                    39 0 11 40 1 44 0 11 45 1 84 16 0 85 2 96
                                    93 94 95 97 1 104 102 103 105 1 103 0 0 108
                                    1 103 2 0 109 1 110 102 103 111 1 103 0 2
                                    112 1 0 113 0 114 2 117 102 115 116 118 2
                                    102 0 0 0 119 1 110 102 103 121 1 103 16 0
                                    123 1 103 0 0 124 1 126 103 125 127 2 0 16
                                    0 0 1 1 0 16 0 18 1 0 90 0 91 1 0 0 0 92 1
                                    0 16 0 1 2 0 0 0 0 132 2 0 86 0 0 1 3 0 0 0
                                    0 0 37 1 0 106 100 107 1 0 0 0 1 1 0 113 0
                                    1 2 0 98 99 100 101 2 0 16 0 0 1 2 0 16 0 0
                                    1 1 0 11 0 1 2 0 0 0 0 83 0 0 6 58 0 0 0 1
                                    1 0 86 0 1 2 0 0 0 71 1 2 0 0 0 69 1 1 0
                                    138 0 1 1 0 11 0 1 2 0 0 0 0 82 1 0 50 51
                                    52 2 0 53 51 54 55 1 0 86 0 88 1 0 134 0 1
                                    1 0 16 0 1 1 0 135 0 1 1 0 0 0 57 2 0 0 0 0
                                    81 1 0 139 140 1 1 0 16 0 1 3 0 0 0 0 0 131
                                    2 0 0 0 0 49 1 0 16 0 29 2 0 0 0 0 1 3 0
                                    137 0 136 137 1 2 0 16 0 0 129 1 0 16 0 19
                                    1 0 16 0 75 1 0 86 0 1 1 0 16 0 28 2 0 141
                                    140 0 1 3 0 0 0 0 0 38 2 0 0 0 0 78 2 0 0 0
                                    0 77 1 0 0 0 1 1 0 0 0 35 1 0 86 0 1 2 0 0
                                    0 71 1 2 0 0 0 69 1 2 0 145 0 0 1 2 0 0 0 0
                                    1 1 0 0 140 1 1 0 9 0 48 2 0 0 0 0 1 0 0 0
                                    1 1 0 0 0 24 2 0 26 26 0 27 1 0 146 0 1 2 0
                                    100 100 100 128 2 0 0 0 0 89 1 0 0 140 1 1
                                    0 0 0 1 1 0 106 100 122 1 0 106 100 120 1 0
                                    113 0 114 3 0 143 0 0 0 1 2 0 144 0 0 1 2 0
                                    86 0 0 87 2 0 141 140 0 1 1 0 16 0 76 1 0
                                    71 0 1 2 0 79 0 0 80 1 0 0 0 1 2 0 0 0 71 1
                                    1 0 0 0 25 1 0 0 0 23 1 0 9 0 47 1 0 42 0
                                    43 1 0 39 0 41 1 0 136 0 1 1 0 44 0 46 1 0
                                    11 0 34 1 1 133 51 1 2 0 0 0 0 1 1 0 0 11
                                    33 1 0 0 0 1 1 0 30 0 32 1 1 86 0 1 0 0 71
                                    1 2 0 16 0 0 1 2 0 0 0 0 1 0 0 0 22 3 0 0 0
                                    0 0 1 2 0 16 0 0 1 2 0 0 0 0 1 2 0 16 0 0
                                    130 3 0 0 0 0 0 36 1 0 0 0 56 2 0 0 0 71 73
                                    2 0 0 0 69 74 0 0 0 20 0 0 0 21 2 0 6 7 0 1
                                    3 0 6 7 0 16 17 1 0 9 0 1 2 0 9 0 16 1 1 0
                                    0 0 1 2 0 0 0 71 1 2 0 16 0 0 62 2 0 16 0 0
                                    61 2 0 16 0 0 59 2 0 16 0 0 63 2 0 16 0 0
                                    60 2 0 0 0 0 66 1 0 0 0 64 2 0 0 0 0 65 2 0
                                    0 71 0 72 2 0 0 11 0 68 2 0 0 0 0 67 2 0 0
                                    69 0 70)))))
           '|lookupComplete|)) 

(MAKEPROP '|Integer| 'NILADIC T) 
