
(SDEFUN |INTG0;kerdiff| ((|sa| (F)) (|a| (F)) ($ (|List| (|Kernel| F))))
        (SPADCALL (SPADCALL |sa| (QREFELT $ 15)) (SPADCALL |a| (QREFELT $ 15))
                  (QREFELT $ 17))) 

(SDEFUN |INTG0;checkroot| ((|f| (F)) (|l| (|List| (|Kernel| F))) ($ (F)))
        (COND ((NULL |l|) |f|)
              ('T (SPADCALL |f| (|SPADfirst| |l|) (QREFELT $ 19))))) 

(SDEFUN |INTG0;univ|
        ((|c| (F)) (|l| (|List| (|Kernel| F))) (|x| (|Kernel| F))
         ($ (|Fraction| (|SparseUnivariatePolynomial| F))))
        (SPADCALL (|INTG0;checkroot| |c| |l| $) |x| (QREFELT $ 22))) 

(SDEFUN |INTG0;univariate;F2KSupSup;4|
        ((|f| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F))
         (|p| (|SparseUnivariatePolynomial| F))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (SPADCALL (SPADCALL |f| |y| |p| (QREFELT $ 25)) |x| (QREFELT $ 27))) 

(SDEFUN |INTG0;lift;SupKSup;5|
        ((|p| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (SPROG NIL
               (SPADCALL (CONS #'|INTG0;lift;SupKSup;5!0| (VECTOR $ |k|)) |p|
                         (QREFELT $ 31)))) 

(SDEFUN |INTG0;lift;SupKSup;5!0| ((|x1| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |k| (QREFELT $ 22)))))) 

(SDEFUN |INTG0;proot|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($
          (|Record| (|:| |coef| (|SparseUnivariatePolynomial| F))
                    (|:| |radicand| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|r1| #1=(|SparseUnivariatePolynomial| F)) (|c1| #1#)
          (|rr1|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F)))
          (|u1| (F)) (|e2| (|NonNegativeInteger|))
          (|e1| (|NonNegativeInteger|)) (|f1| (|SparseUnivariatePolynomial| F))
          (#2=#:G750 NIL) (|fac| NIL)
          (|ff| (|Factored| (|SparseUnivariatePolynomial| F))))
         (SEQ (LETT |ff| (SPADCALL |p| (QREFELT $ 33)))
              (LETT |c1| (|spadConstant| $ 34))
              (LETT |r1| (|spadConstant| $ 34))
              (SEQ (LETT |fac| NIL) (LETT #2# (SPADCALL |ff| (QREFELT $ 39)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |fac| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |f1| (QVELT |fac| 1)) (LETT |e1| (QVELT |fac| 2))
                        (LETT |e2| (QUOTIENT2 |e1| 2))
                        (LETT |c1|
                              (SPADCALL (SPADCALL |f1| |e2| (QREFELT $ 41))
                                        |c1| (QREFELT $ 42)))
                        (EXIT
                         (COND
                          ((SPADCALL |e1| (* 2 |e2|) (QREFELT $ 44))
                           (LETT |r1| (SPADCALL |f1| |r1| (QREFELT $ 42)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |u1|
                    (SPADCALL (SPADCALL |ff| (QREFELT $ 45)) (QREFELT $ 46)))
              (LETT |rr1| (SPADCALL |u1| 2 (QREFELT $ 49)))
              (LETT |c1| (SPADCALL (QVELT |rr1| 1) |c1| (QREFELT $ 50)))
              (LETT |r1| (SPADCALL (QVELT |rr1| 2) |r1| (QREFELT $ 50)))
              (EXIT (CONS |c1| |r1|))))) 

(SDEFUN |INTG0;rationalize_log|
        ((|ll|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         (|k1| (|Kernel| F))
         ($
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| F))
                     (|:| |logand| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| F))
                      (|:| |logand| (|SparseUnivariatePolynomial| F)))))
          (|ppn| (|SparseUnivariatePolynomial| F))
          (|rr1|
           (|Record| (|:| |coef| (|SparseUnivariatePolynomial| F))
                     (|:| |radicand| (|SparseUnivariatePolynomial| F))))
          (|fun2| #1=(|SparseUnivariatePolynomial| F))
          (|fun2c| #2=(|SparseUnivariatePolynomial| F)) (|ppcc| #2#)
          (|c2| (|Fraction| (|Integer|))) (|c1| (|Fraction| (|Integer|)))
          (|fun1| #1#) (|fun1c| #2#) (|fun| (|SparseUnivariatePolynomial| F))
          (|ppc| (|SparseUnivariatePolynomial| F)) (#3=#:G756 NIL)
          (|ppr| (|SparseUnivariatePolynomial| F))
          (|pol1| #4=(|SparseUnivariatePolynomial| F)) (|pol0| #4#)
          (|polu|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (|opol| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |opol| (QVELT |ll| 1))
              (LETT |polu|
                    (SPADCALL
                     (CONS #'|INTG0;rationalize_log!0| (VECTOR $ |k1|)) |opol|
                     (QREFELT $ 56)))
              (LETT |pol0|
                    (SPADCALL (CONS #'|INTG0;rationalize_log!1| $) |polu|
                              (QREFELT $ 63)))
              (LETT |pol1|
                    (SPADCALL (CONS #'|INTG0;rationalize_log!2| $) |polu|
                              (QREFELT $ 63)))
              (LETT |ppr|
                    (COND
                     ((SPADCALL |pol1| (|spadConstant| $ 67) (QREFELT $ 68))
                      |pol0|)
                     (#5='T (SPADCALL |pol0| |pol1| (QREFELT $ 69)))))
              (LETT |ppc|
                    (PROG2 (LETT #3# (SPADCALL |opol| |ppr| (QREFELT $ 71)))
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 0)
                                      (|SparseUnivariatePolynomial|
                                       (QREFELT $ 7))
                                      (|Union|
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 7))
                                       "failed")
                                      #3#)))
              (LETT |fun| (QVELT |ll| 2)) (LETT |res| NIL)
              (COND
               ((> (SPADCALL |ppr| (QREFELT $ 72)) 0)
                (SEQ (LETT |c1| (QVELT |ll| 0))
                     (LETT |fun1| (SPADCALL |fun| |ppr| (QREFELT $ 73)))
                     (LETT |fun1c|
                           (SPADCALL
                            (CONS #'|INTG0;rationalize_log!3| (VECTOR $ |k1|))
                            |fun1| (QREFELT $ 78)))
                     (EXIT
                      (COND
                       ((SPADCALL |fun1c| |fun1| (QREFELT $ 79))
                        (SEQ
                         (LETT |fun1| (SPADCALL |fun1c| |fun1| (QREFELT $ 42)))
                         (LETT |c2|
                               (SPADCALL |c1| (SPADCALL 2 (QREFELT $ 82))
                                         (QREFELT $ 83)))
                         (LETT |rr1| (|INTG0;proot| |fun1| $))
                         (EXIT
                          (COND
                           ((SPADCALL (QCDR |rr1|) (|spadConstant| $ 34)
                                      (QREFELT $ 68))
                            (LETT |res|
                                  (CONS (VECTOR |c1| |ppr| (QCAR |rr1|))
                                        |res|)))
                           (#5#
                            (LETT |res|
                                  (CONS (VECTOR |c2| |ppr| |fun1|) |res|)))))))
                       (#5#
                        (LETT |res|
                              (CONS (VECTOR |c1| |ppr| |fun1|) |res|))))))))
              (COND
               ((> (SPADCALL |ppc| (QREFELT $ 72)) 0)
                (SEQ (LETT |c1| (QVELT |ll| 0))
                     (LETT |c2|
                           (SPADCALL |c1| (SPADCALL 2 (QREFELT $ 82))
                                     (QREFELT $ 83)))
                     (LETT |fun2| (SPADCALL |fun| |ppc| (QREFELT $ 73)))
                     (LETT |ppcc|
                           (SPADCALL
                            (CONS #'|INTG0;rationalize_log!4| (VECTOR $ |k1|))
                            |ppc| (QREFELT $ 78)))
                     (LETT |fun2c|
                           (SPADCALL
                            (CONS #'|INTG0;rationalize_log!5| (VECTOR $ |k1|))
                            |fun2| (QREFELT $ 78)))
                     (LETT |fun2|
                           (SPADCALL (SPADCALL |ppcc| |fun2| (QREFELT $ 42))
                                     (SPADCALL |ppc| |fun2c| (QREFELT $ 42))
                                     (QREFELT $ 84)))
                     (LETT |rr1| (|INTG0;proot| |fun2| $))
                     (LETT |ppn| (SPADCALL |ppc| |ppcc| (QREFELT $ 42)))
                     (EXIT
                      (COND
                       ((SPADCALL (QCDR |rr1|) (|spadConstant| $ 34)
                                  (QREFELT $ 68))
                        (LETT |res|
                              (CONS (VECTOR |c1| |ppn| (QCAR |rr1|)) |res|)))
                       (#5#
                        (LETT |res|
                              (CONS (VECTOR |c2| |ppn| |fun2|) |res|))))))))
              (EXIT |res|)))) 

(SDEFUN |INTG0;rationalize_log!5| ((|c| NIL) ($$ NIL))
        (PROG (|k1| $)
          (LETT |k1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |c| |k1|
                      (SPADCALL (SPADCALL |k1| (QREFELT $ 74)) (QREFELT $ 75))
                      (QREFELT $ 76)))))) 

(SDEFUN |INTG0;rationalize_log!4| ((|c| NIL) ($$ NIL))
        (PROG (|k1| $)
          (LETT |k1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |c| |k1|
                      (SPADCALL (SPADCALL |k1| (QREFELT $ 74)) (QREFELT $ 75))
                      (QREFELT $ 76)))))) 

(SDEFUN |INTG0;rationalize_log!3| ((|c| NIL) ($$ NIL))
        (PROG (|k1| $)
          (LETT |k1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |c| |k1|
                      (SPADCALL (SPADCALL |k1| (QREFELT $ 74)) (QREFELT $ 75))
                      (QREFELT $ 76)))))) 

(SDEFUN |INTG0;rationalize_log!2| ((|c| NIL) ($ NIL))
        (SPADCALL |c| (|spadConstant| $ 66) (QREFELT $ 60))) 

(SDEFUN |INTG0;rationalize_log!1| ((|c| NIL) ($ NIL))
        (SPADCALL |c| (|spadConstant| $ 59) (QREFELT $ 60))) 

(SDEFUN |INTG0;rationalize_log!0| ((|c| NIL) ($$ NIL))
        (PROG (|k1| $)
          (LETT |k1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |c| |k1| (SPADCALL |k1| (QREFELT $ 52))
                      (QREFELT $ 25)))))) 

(SDEFUN |INTG0;rationalize_ir;IrKIr;8|
        ((|irf| (|IntegrationResult| F)) (|k1| (|Kernel| F))
         ($ (|IntegrationResult| F)))
        (SPROG
         ((|lp1|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff| (|SparseUnivariatePolynomial| F))
                      (|:| |logand| (|SparseUnivariatePolynomial| F)))))
          (#1=#:G832 NIL) (|ll| NIL) (|rp1| (F)) (|rp| (F)))
         (SEQ (LETT |rp| (SPADCALL |irf| (QREFELT $ 86)))
              (LETT |rp1|
                    (SPADCALL
                     (SPADCALL |rp|
                               (SPADCALL |rp| |k1|
                                         (SPADCALL
                                          (SPADCALL |k1| (QREFELT $ 74))
                                          (QREFELT $ 75))
                                         (QREFELT $ 76))
                               (QREFELT $ 87))
                     (SPADCALL 2 (QREFELT $ 88)) (QREFELT $ 89)))
              (LETT |lp1| NIL)
              (SEQ (LETT |ll| NIL) (LETT #1# (SPADCALL |irf| (QREFELT $ 92)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |ll| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |lp1|
                           (SPADCALL (|INTG0;rationalize_log| |ll| |k1| $)
                                     |lp1| (QREFELT $ 93)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |rp1| |lp1| (SPADCALL |irf| (QREFELT $ 96))
                         (QREFELT $ 97)))))) 

(SDEFUN |INTG0;field_gens|
        ((|y| (|Kernel| F)) (|lf| (|List| F)) ($ (|List| F)))
        (SPROG
         ((|res| (|List| F)) (#1=#:G837 NIL) (|k| NIL)
          (|at| (|List| (|Kernel| F))))
         (SEQ (LETT |at| (SPADCALL |lf| (QREFELT $ 100))) (LETT |res| NIL)
              (SEQ (LETT |k| NIL) (LETT #1# |at|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND ((SPADCALL |k| |y| (QREFELT $ 101)) "iterate")
                           ('T
                            (LETT |res|
                                  (CONS (SPADCALL |k| (QREFELT $ 74))
                                        |res|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |INTG0;palgint0;F2KFSupIr;10|
        ((|f| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F)) (|den| (F))
         (|radi| (|SparseUnivariatePolynomial| F)) ($ (|IntegrationResult| F)))
        (SPROG
         ((|irf1| (|IntegrationResult| F))
          (|irf|
           (|IntegrationResult| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|rf| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|pr|
           (|Record| (|:| |diff| F)
                     (|:| |subs|
                          (|Record| (|:| |coeff| F)
                                    (|:| |var| (|List| (|Kernel| F)))
                                    (|:| |val| (|List| F))))
                     (|:| |newk| (|List| (|Kernel| F)))))
          (|lc| (|List| F))
          (|f0|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|ff|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|SparseUnivariatePolynomial| F)))))
         (SEQ
          (LETT |ff|
                (SPADCALL |f| |x| |y| (SPADCALL |y| (QREFELT $ 52))
                          (QREFELT $ 28)))
          (LETT |f0| (SPADCALL |ff| (QREFELT $ 102)))
          (LETT |lc| (|INTG0;field_gens| |y| (LIST |f|) $))
          (LETT |pr| (|INTG0;quadsubst| |x| |y| |den| |radi| |lc| $))
          (LETT |rf|
                (|INTG0;mkRat|
                 (SPADCALL (SPADCALL |ff| (QREFELT $ 103)) |x|
                           (SPADCALL |y| (QREFELT $ 74)) (QREFELT $ 104))
                 (QVELT |pr| 1) (QVELT |pr| 2) $))
          (LETT |irf| (SPADCALL |rf| (QREFELT $ 108)))
          (LETT |irf1|
                (SPADCALL
                 (CONS #'|INTG0;palgint0;F2KFSupIr;10!0| (VECTOR $ |pr|)) |irf|
                 (QREFELT $ 113)))
          (COND
           ((NULL (NULL (QVELT |pr| 2)))
            (LETT |irf1|
                  (SPADCALL |irf1| (|SPADfirst| (QVELT |pr| 2))
                            (QREFELT $ 98)))))
          (EXIT
           (SPADCALL
            (SPADCALL (CONS #'|INTG0;palgint0;F2KFSupIr;10!1| (VECTOR $ |x|))
                      (SPADCALL (SPADCALL |f0| (QREFELT $ 114))
                                (QREFELT $ 108))
                      (QREFELT $ 113))
            |irf1| (QREFELT $ 115)))))) 

(SDEFUN |INTG0;palgint0;F2KFSupIr;10!1| ((|f1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |f1| (SPADCALL |x| (QREFELT $ 74)) (QREFELT $ 110)))))) 

(SDEFUN |INTG0;palgint0;F2KFSupIr;10!0| ((|f1| NIL) ($$ NIL))
        (PROG (|pr| $)
          (LETT |pr| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| (QVELT |pr| 0) (QREFELT $ 110)))))) 

(SDEFUN |INTG0;sqrt_in_field| ((|a| (F)) (|lc| (|List| F)) ($ (F)))
        (SPROG
         ((|ff| #1=(|SparseUnivariatePolynomial| F))
          (|lfac|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #1#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|fp| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|pol| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |pol|
                (SPADCALL (SPADCALL (|spadConstant| $ 65) 2 (QREFELT $ 117))
                          (SPADCALL |a| (QREFELT $ 118)) (QREFELT $ 119)))
          (LETT |fp| (SPADCALL |pol| |lc| (QREFELT $ 122)))
          (LETT |lfac| (SPADCALL |fp| (QREFELT $ 39)))
          (LETT |ff| (QVELT (|SPADfirst| |lfac|) 1))
          (EXIT
           (COND
            ((EQL (SPADCALL |ff| (QREFELT $ 72)) 1)
             (SPADCALL
              (SPADCALL (SPADCALL |ff| 0 (QREFELT $ 60))
                        (SPADCALL |ff| 1 (QREFELT $ 60)) (QREFELT $ 89))
              (QREFELT $ 75)))
            ('T (SPADCALL |a| (QREFELT $ 123)))))))) 

(SDEFUN |INTG0;quadsubst|
        ((|x| (|Kernel| F)) (|y| (|Kernel| F)) (|den| (F))
         (|p| (|SparseUnivariatePolynomial| F)) (|lc| (|List| F))
         ($
          (|Record| (|:| |diff| F)
                    (|:| |subs|
                         (|Record| (|:| |coeff| F)
                                   (|:| |var| (|List| (|Kernel| F)))
                                   (|:| |val| (|List| F))))
                    (|:| |newk| (|List| (|Kernel| F))))))
        (SPROG
         ((|yy| (F)) (|ux| (F)) (|q| (F)) (|xx| (F)) (|sc| (F)) (|u2ma| (F))
          (|ua| (F)) (|bm2u| (F)) (|sa| (F)) (|a| (F)) (|c| (F)) (|b| (F))
          (|u| (F)))
         (SEQ (LETT |u| (SPADCALL (QREFELT $ 13) (QREFELT $ 74)))
              (LETT |b| (SPADCALL |p| 1 (QREFELT $ 60)))
              (LETT |c| (SPADCALL |p| 0 (QREFELT $ 60)))
              (LETT |a| (SPADCALL |p| 2 (QREFELT $ 60)))
              (LETT |sa| (|INTG0;sqrt_in_field| |a| |lc| $))
              (EXIT
               (COND
                ((SPADCALL
                  (SPADCALL (SPADCALL |b| |b| (QREFELT $ 124))
                            (SPADCALL (SPADCALL 4 |a| (QREFELT $ 126)) |c|
                                      (QREFELT $ 124))
                            (QREFELT $ 127))
                  (QREFELT $ 128))
                 (VECTOR (SPADCALL |x| (QREFELT $ 74))
                         (VECTOR (|spadConstant| $ 65) (LIST |x| |y|)
                                 (LIST |u|
                                       (SPADCALL
                                        (SPADCALL |sa|
                                                  (SPADCALL |u|
                                                            (SPADCALL |b|
                                                                      (SPADCALL
                                                                       2 |a|
                                                                       (QREFELT
                                                                        $ 126))
                                                                      (QREFELT
                                                                       $ 89))
                                                            (QREFELT $ 87))
                                                  (QREFELT $ 124))
                                        (SPADCALL |den| |x| |u| (QREFELT $ 76))
                                        (QREFELT $ 89))))
                         NIL))
                ((NULL (|INTG0;kerdiff| |sa| |a| $))
                 (SEQ
                  (LETT |bm2u|
                        (SPADCALL |b|
                                  (SPADCALL (SPADCALL 2 |u| (QREFELT $ 126))
                                            |sa| (QREFELT $ 124))
                                  (QREFELT $ 127)))
                  (LETT |q|
                        (SPADCALL |den| |x|
                                  (LETT |xx|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |u| 2 (QREFELT $ 129)) |c|
                                          (QREFELT $ 127))
                                         |bm2u| (QREFELT $ 89)))
                                  (QREFELT $ 76)))
                  (LETT |yy|
                        (SPADCALL
                         (LETT |ua|
                               (SPADCALL |u|
                                         (SPADCALL |xx| |sa| (QREFELT $ 124))
                                         (QREFELT $ 87)))
                         |q| (QREFELT $ 89)))
                  (EXIT
                   (VECTOR
                    (SPADCALL
                     (SPADCALL |den| (SPADCALL |y| (QREFELT $ 74))
                               (QREFELT $ 124))
                     (SPADCALL (SPADCALL |x| (QREFELT $ 74)) |sa|
                               (QREFELT $ 124))
                     (QREFELT $ 127))
                    (VECTOR
                     (SPADCALL (SPADCALL 2 |ua| (QREFELT $ 126)) |bm2u|
                               (QREFELT $ 89))
                     (LIST |x| |y|) (LIST |xx| |yy|))
                    NIL))))
                ('T
                 (SEQ
                  (LETT |u2ma|
                        (SPADCALL (SPADCALL |u| 2 (QREFELT $ 129)) |a|
                                  (QREFELT $ 127)))
                  (LETT |sc| (|INTG0;sqrt_in_field| |c| |lc| $))
                  (LETT |q|
                        (SPADCALL |den| |x|
                                  (LETT |xx|
                                        (SPADCALL
                                         (SPADCALL |b|
                                                   (SPADCALL
                                                    (SPADCALL 2 |u|
                                                              (QREFELT $ 126))
                                                    |sc| (QREFELT $ 124))
                                                   (QREFELT $ 127))
                                         |u2ma| (QREFELT $ 89)))
                                  (QREFELT $ 76)))
                  (LETT |yy|
                        (SPADCALL
                         (LETT |ux|
                               (SPADCALL (SPADCALL |xx| |u| (QREFELT $ 124))
                                         |sc| (QREFELT $ 87)))
                         |q| (QREFELT $ 89)))
                  (EXIT
                   (VECTOR
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL |den| (SPADCALL |y| (QREFELT $ 74))
                                (QREFELT $ 124))
                      |sc| (QREFELT $ 127))
                     (SPADCALL |x| (QREFELT $ 74)) (QREFELT $ 89))
                    (VECTOR
                     (SPADCALL
                      (SPADCALL (SPADCALL 2 |ux| (QREFELT $ 126)) |u2ma|
                                (QREFELT $ 89))
                      (QREFELT $ 75))
                     (LIST |x| |y|) (LIST |xx| |yy|))
                    (|INTG0;kerdiff| |sc| |c| $)))))))))) 

(SDEFUN |INTG0;mkRatlx|
        ((|f| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F)) (|t| (F))
         (|z| (|Kernel| F))
         (|dx| (|Fraction| (|SparseUnivariatePolynomial| F))) (|r| (F))
         ($ (|Fraction| (|SparseUnivariatePolynomial| F))))
        (SPROG ((|f1| (F)))
               (SEQ
                (LETT |f1|
                      (SPADCALL |f| |y|
                                (SPADCALL |r| (SPADCALL |z| (QREFELT $ 74))
                                          (QREFELT $ 124))
                                (QREFELT $ 76)))
                (EXIT
                 (SPADCALL
                  (SPADCALL (SPADCALL |f1| |x| |t| (QREFELT $ 76)) |z|
                            (QREFELT $ 22))
                  |dx| (QREFELT $ 130)))))) 

(SDEFUN |INTG0;mkRat|
        ((|f| (F))
         (|rec|
          (|Record| (|:| |coeff| F) (|:| |var| (|List| (|Kernel| F)))
                    (|:| |val| (|List| F))))
         (|l| (|List| (|Kernel| F)))
         ($ (|Fraction| (|SparseUnivariatePolynomial| F))))
        (SPROG ((|rat| (|Fraction| (|SparseUnivariatePolynomial| F))))
               (SEQ
                (LETT |rat|
                      (SPADCALL
                       (|INTG0;checkroot|
                        (SPADCALL (QVELT |rec| 0)
                                  (SPADCALL |f| (QVELT |rec| 1) (QVELT |rec| 2)
                                            (QREFELT $ 131))
                                  (QREFELT $ 124))
                        |l| $)
                       (QREFELT $ 13) (QREFELT $ 22)))
                (EXIT
                 (SPADCALL (SPADCALL |rat| (QREFELT $ 132))
                           (SPADCALL |rat| (QREFELT $ 133)) (QREFELT $ 134)))))) 

(SDEFUN |INTG0;ev|
        ((|x1| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|y1| (|Fraction| (|SparseUnivariatePolynomial| F))) ($ (F)))
        (SPADCALL
         (SPADCALL (SPADCALL |x1| |y1| (QREFELT $ 135)) (QREFELT $ 136))
         (QREFELT $ 137))) 

(SDEFUN |INTG0;palgint0;F3KFFFIr;16|
        ((|f| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F)) (|z| (|Kernel| F))
         (|xx| (F)) (|dx| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|r| (F)) ($ (|IntegrationResult| F)))
        (SPROG
         ((|pp| (|IntegrationResult| F))
          (|y1| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|res1|
           (|IntegrationResult|
            (|Fraction| (|SparseUnivariatePolynomial| F)))))
         (SEQ
          (LETT |res1|
                (SPADCALL (|INTG0;mkRatlx| |f| |x| |y| |xx| |z| |dx| |r| $)
                          (QREFELT $ 108)))
          (LETT |y1|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |y| (QREFELT $ 74)) |r| (QREFELT $ 89))
                  (QREFELT $ 118))
                 (QREFELT $ 138)))
          (EXIT
           (LETT |pp|
                 (SPADCALL
                  (CONS #'|INTG0;palgint0;F3KFFFIr;16!0| (VECTOR $ |y1|))
                  |res1| (QREFELT $ 113))))))) 

(SDEFUN |INTG0;palgint0;F3KFFFIr;16!0| ((|x1| NIL) ($$ NIL))
        (PROG (|y1| $)
          (LETT |y1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTG0;ev| |x1| |y1| $))))) 

(SDEFUN |INTG0;palgRDE0;2F2KMKFFFU;17|
        ((|f| (F)) (|g| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F))
         (|rischde| (|Mapping| #1=(|Union| F #2="failed") F F (|Symbol|)))
         (|z| (|Kernel| F)) (|xx| (F))
         (|dx| (|Fraction| (|SparseUnivariatePolynomial| F))) (|r| (F))
         ($ (|Union| F #2#)))
        (SPROG ((|u| #1#) (#3=#:G868 NIL) (|g1| (F)) (|f1| (F)))
               (SEQ
                (LETT |f1|
                      (SPADCALL |f| |y|
                                (SPADCALL |r| (SPADCALL |z| (QREFELT $ 74))
                                          (QREFELT $ 124))
                                (QREFELT $ 76)))
                (LETT |g1|
                      (SPADCALL |g| |y|
                                (SPADCALL |r| (SPADCALL |z| (QREFELT $ 74))
                                          (QREFELT $ 124))
                                (QREFELT $ 76)))
                (LETT |u|
                      (SPADCALL (SPADCALL |f1| |x| |xx| (QREFELT $ 76))
                                (SPADCALL (SPADCALL |dx| |z| (QREFELT $ 140))
                                          (SPADCALL |g1| |x| |xx|
                                                    (QREFELT $ 76))
                                          (QREFELT $ 124))
                                (PROG2
                                    (LETT #3# (SPADCALL |z| (QREFELT $ 142)))
                                    (QCDR #3#)
                                  (|check_union2| (QEQCAR #3# 0) (|Symbol|)
                                                  (|Union| (|Symbol|) "failed")
                                                  #3#))
                                |rischde|))
                (EXIT
                 (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                       ('T
                        (CONS 0
                              (SPADCALL (QCDR |u|) |z|
                                        (SPADCALL (SPADCALL |y| (QREFELT $ 74))
                                                  |r| (QREFELT $ 89))
                                        (QREFELT $ 76))))))))) 

(SDEFUN |INTG0;multivariate;SupK2F;18|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|x| (|Kernel| F)) (|y| (F)) ($ (F)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL
                 (CONS #'|INTG0;multivariate;SupK2F;18!0| (VECTOR $ |x|)) |p|
                 (QREFELT $ 147))
                |y| (QREFELT $ 148)))) 

(SDEFUN |INTG0;multivariate;SupK2F;18!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 140)))))) 

(SDEFUN |INTG0;palgRDE0;2F2KMFSupU;19|
        ((|f| (F)) (|g| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F))
         (|rischde| (|Mapping| #1=(|Union| F #2="failed") F F (|Symbol|)))
         (|den| (F)) (|radi| (|SparseUnivariatePolynomial| F))
         ($ (|Union| F #2#)))
        (SPROG
         ((|u| #1#) (#3=#:G892 NIL)
          (|pr|
           (|Record| (|:| |diff| F)
                     (|:| |subs|
                          (|Record| (|:| |coeff| F)
                                    (|:| |var| (|List| (|Kernel| F)))
                                    (|:| |val| (|List| F))))
                     (|:| |newk| (|List| (|Kernel| F)))))
          (|lc| (|List| F)))
         (SEQ (LETT |lc| (|INTG0;field_gens| |y| (LIST |f| |g|) $))
              (LETT |pr| (|INTG0;quadsubst| |x| |y| |den| |radi| |lc| $))
              (LETT |u|
                    (SPADCALL
                     (|INTG0;checkroot|
                      (SPADCALL |f| (QVELT (QVELT |pr| 1) 1)
                                (QVELT (QVELT |pr| 1) 2) (QREFELT $ 131))
                      (QVELT |pr| 2) $)
                     (|INTG0;checkroot|
                      (SPADCALL (QVELT (QVELT |pr| 1) 0)
                                (SPADCALL |g| (QVELT (QVELT |pr| 1) 1)
                                          (QVELT (QVELT |pr| 1) 2)
                                          (QREFELT $ 131))
                                (QREFELT $ 124))
                      (QVELT |pr| 2) $)
                     (PROG2
                         (LETT #3# (SPADCALL (QREFELT $ 13) (QREFELT $ 142)))
                         (QCDR #3#)
                       (|check_union2| (QEQCAR #3# 0) (|Symbol|)
                                       (|Union| (|Symbol|) "failed") #3#))
                     |rischde|))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                     ('T
                      (CONS 0
                            (SPADCALL (QCDR |u|) (QREFELT $ 13) (QVELT |pr| 0)
                                      (QREFELT $ 76))))))))) 

(SDEFUN |INTG0;palgLODE0;LF2KFSupR;20|
        ((|eq| (L)) (|g| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F)) (|den| (F))
         (|radi| (|SparseUnivariatePolynomial| F))
         ($
          (|Record| (|:| |particular| (|Union| F "failed"))
                    (|:| |basis| (|List| F)))))
        (SPROG
         ((#1=#:G909 NIL) (|bas| (|List| F)) (#2=#:G919 NIL) (|b| NIL)
          (#3=#:G918 NIL)
          (|rec|
           (|Record|
            (|:| |particular|
                 (|Union| (|Fraction| (|SparseUnivariatePolynomial| F))
                          #4="failed"))
            (|:| |basis|
                 (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (|di|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|op|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (#5=#:G917 NIL) (|i| NIL)
          (|d|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|pr|
           (|Record| (|:| |diff| F)
                     (|:| |subs|
                          (|Record| (|:| |coeff| F)
                                    (|:| |var| (|List| (|Kernel| F)))
                                    (|:| |val| (|List| F))))
                     (|:| |newk| (|List| (|Kernel| F)))))
          (|lc| (|List| F)))
         (SEQ
          (LETT |lc|
                (|INTG0;field_gens| |y|
                 (CONS |g| (SPADCALL |eq| (QREFELT $ 150))) $))
          (LETT |pr| (|INTG0;quadsubst| |x| |y| |den| |radi| |lc| $))
          (LETT |d|
                (SPADCALL
                 (|INTG0;univ|
                  (SPADCALL (QVELT (QVELT |pr| 1) 0) (QREFELT $ 151))
                  (QVELT |pr| 2) (QREFELT $ 13) $)
                 1 (QREFELT $ 153)))
          (LETT |di| (|spadConstant| $ 154)) (LETT |op| (|spadConstant| $ 155))
          (SEQ (LETT |i| 0) (LETT #5# (SPADCALL |eq| (QREFELT $ 156))) G190
               (COND ((|greater_SI| |i| #5#) (GO G191)))
               (SEQ
                (LETT |op|
                      (SPADCALL |op|
                                (SPADCALL
                                 (|INTG0;univ|
                                  (SPADCALL (SPADCALL |eq| |i| (QREFELT $ 157))
                                            (QVELT (QVELT |pr| 1) 1)
                                            (QVELT (QVELT |pr| 1) 2)
                                            (QREFELT $ 131))
                                  (QVELT |pr| 2) (QREFELT $ 13) $)
                                 |di| (QREFELT $ 158))
                                (QREFELT $ 159)))
                (EXIT (LETT |di| (SPADCALL |d| |di| (QREFELT $ 160)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |rec|
                (SPADCALL |op|
                          (|INTG0;univ|
                           (SPADCALL |g| (QVELT (QVELT |pr| 1) 1)
                                     (QVELT (QVELT |pr| 1) 2) (QREFELT $ 131))
                           (QVELT |pr| 2) (QREFELT $ 13) $)
                          (QREFELT $ 164)))
          (LETT |bas|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |b| NIL) (LETT #2# (QCDR |rec|)) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |b| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL |b| (QVELT |pr| 0) (QREFELT $ 110))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT
           (COND ((QEQCAR (QCAR |rec|) 1) (CONS (CONS 1 "failed") |bas|))
                 ('T
                  (CONS
                   (CONS 0
                         (SPADCALL
                          (PROG2 (LETT #1# (QCAR |rec|))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0)
                                            (|Fraction|
                                             (|SparseUnivariatePolynomial|
                                              (QREFELT $ 7)))
                                            (|Union|
                                             (|Fraction|
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 7)))
                                             #4#)
                                            #1#))
                          (QVELT |pr| 0) (QREFELT $ 110)))
                   |bas|))))))) 

(SDEFUN |INTG0;palgLODE0;LF3KFFFR;21|
        ((|eq| (L)) (|g| (F)) (|x| (|Kernel| F)) (|y| (|Kernel| F))
         (|kz| (|Kernel| F)) (|xx| (F))
         (|dx| (|Fraction| (|SparseUnivariatePolynomial| F))) (|r| (F))
         ($
          (|Record| (|:| |particular| (|Union| F "failed"))
                    (|:| |basis| (|List| F)))))
        (SPROG
         ((#1=#:G928 NIL) (|bas| (|List| F)) (#2=#:G937 NIL) (|b| NIL)
          (#3=#:G936 NIL)
          (|yinv| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|rec|
           (|Record|
            (|:| |particular|
                 (|Union| (|Fraction| (|SparseUnivariatePolynomial| F))
                          #4="failed"))
            (|:| |basis|
                 (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (|g1| (F))
          (|di|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|op|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|c1| (F)) (#5=#:G935 NIL) (|i| NIL) (|y1| (F))
          (|d|
           (|LinearOrdinaryDifferentialOperator1|
            (|Fraction| (|SparseUnivariatePolynomial| F)))))
         (SEQ
          (LETT |d|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |dx| |kz| (QREFELT $ 140))
                            (QREFELT $ 151))
                  |kz| (QREFELT $ 22))
                 1 (QREFELT $ 153)))
          (LETT |di| (|spadConstant| $ 154)) (LETT |op| (|spadConstant| $ 155))
          (LETT |y1|
                (SPADCALL |r| (SPADCALL |kz| (QREFELT $ 74)) (QREFELT $ 124)))
          (SEQ (LETT |i| 0) (LETT #5# (SPADCALL |eq| (QREFELT $ 156))) G190
               (COND ((|greater_SI| |i| #5#) (GO G191)))
               (SEQ
                (LETT |c1|
                      (SPADCALL (SPADCALL |eq| |i| (QREFELT $ 157)) |y| |y1|
                                (QREFELT $ 76)))
                (LETT |op|
                      (SPADCALL |op|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL |c1| |x| |xx| (QREFELT $ 76)) |kz|
                                  (QREFELT $ 22))
                                 |di| (QREFELT $ 158))
                                (QREFELT $ 159)))
                (EXIT (LETT |di| (SPADCALL |d| |di| (QREFELT $ 160)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |g1| (SPADCALL |g| |y| |y1| (QREFELT $ 76)))
          (LETT |rec|
                (SPADCALL |op|
                          (SPADCALL (SPADCALL |g1| |x| |xx| (QREFELT $ 76))
                                    |kz| (QREFELT $ 22))
                          (QREFELT $ 164)))
          (LETT |yinv|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |y| (QREFELT $ 74)) |r| (QREFELT $ 89))
                  (QREFELT $ 118))
                 (QREFELT $ 138)))
          (LETT |bas|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |b| NIL) (LETT #2# (QCDR |rec|)) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |b| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #3# (CONS (|INTG0;ev| |b| |yinv| $) #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT
           (COND ((QEQCAR (QCAR |rec|) 1) (CONS (CONS 1 "failed") |bas|))
                 ('T
                  (CONS
                   (CONS 0
                         (|INTG0;ev|
                          (PROG2 (LETT #1# (QCAR |rec|))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0)
                                            (|Fraction|
                                             (|SparseUnivariatePolynomial|
                                              (QREFELT $ 7)))
                                            (|Union|
                                             (|Fraction|
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 7)))
                                             #4#)
                                            #1#))
                          |yinv| $))
                   |bas|))))))) 

(DECLAIM (NOTINLINE |GenusZeroIntegration;|)) 

(DEFUN |GenusZeroIntegration| (&REST #1=#:G938)
  (SPROG NIL
         (PROG (#2=#:G939)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GenusZeroIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GenusZeroIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GenusZeroIntegration|)))))))))) 

(DEFUN |GenusZeroIntegration;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|GenusZeroIntegration| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 168))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#3|
                                                             (LIST
                                                              '|LinearOrdinaryDifferentialOperatorCategory|
                                                              (|devaluate|
                                                               |#2|)))))))
          (|haddProp| |$ConstructorCache| '|GenusZeroIntegration|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 13 (SPADCALL (SPADCALL (QREFELT $ 10)) (QREFELT $ 12)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 166
                       (CONS
                        (|dispatchFunction| |INTG0;palgLODE0;LF2KFSupR;20|) $))
             (QSETREFV $ 167
                       (CONS (|dispatchFunction| |INTG0;palgLODE0;LF3KFFFR;21|)
                             $)))))
          $))) 

(MAKEPROP '|GenusZeroIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Symbol|) (0 . |new|) (|Kernel| 7) (4 . |kernel|)
              '|dummy| (|List| 21) (9 . |kernels|) (|List| 11)
              (14 . |setDifference|) (|ElementaryFunctionStructurePackage| 6 7)
              (20 . |rootNormalize|) (|Fraction| 51) (|Kernel| $)
              (26 . |univariate|) (|SparseUnivariatePolynomial| 7)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 11) 11
                                                     6
                                                     (|SparseMultivariatePolynomial|
                                                      6 11)
                                                     7)
              (32 . |univariate|) (|SparseUnivariatePolynomial| 106)
              |INTG0;lift;SupKSup;5| |INTG0;univariate;F2KSupSup;4|
              (|Mapping| 106 7) (|SparseUnivariatePolynomialFunctions2| 7 106)
              (39 . |map|) (|Factored| $) (45 . |squareFree|) (50 . |One|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 35) (|:| |factor| 23) (|:| |exponent| 40))
              (|List| 36) (|Factored| 23) (54 . |factorList|)
              (|NonNegativeInteger|) (59 . ^) (65 . *) (|Boolean|) (71 . ~=)
              (77 . |unit|) (82 . |ground|)
              (|Record| (|:| |exponent| 40) (|:| |coef| 7) (|:| |radicand| 7))
              (|PolynomialRoots| (|IndexedExponents| 11) 11 6
                                 (|SparseMultivariatePolynomial| 6 11) 7)
              (87 . |froot|) (93 . *) (|SparseUnivariatePolynomial| $)
              (99 . |minPoly|) (|SparseUnivariatePolynomial| 23)
              (|Mapping| 23 7) (|SparseUnivariatePolynomialFunctions2| 7 23)
              (104 . |map|) (110 . |Zero|) (114 . |Zero|) (118 . |Zero|)
              (122 . |coefficient|) (|Mapping| 7 23)
              (|SparseUnivariatePolynomialFunctions2| 23 7) (128 . |map|)
              (134 . |One|) (138 . |One|) (142 . |One|) (146 . |Zero|)
              (150 . =) (156 . |gcd|) (|Union| $ '"failed") (162 . |exquo|)
              (168 . |degree|) (173 . |rem|) (179 . |coerce|) (184 . -)
              (189 . |eval|) (|Mapping| 7 7) (196 . |map|) (202 . ~=)
              (|Integer|) (|Fraction| 80) (208 . |coerce|) (213 . /) (219 . +)
              (|IntegrationResult| 7) (225 . |ratpart|) (230 . +)
              (236 . |coerce|) (241 . /)
              (|Record| (|:| |scalar| 81) (|:| |coeff| 23) (|:| |logand| 23))
              (|List| 90) (247 . |logpart|) (252 . |concat|)
              (|Record| (|:| |integrand| 7) (|:| |intvar| 7)) (|List| 94)
              (258 . |notelem|) (263 . |mkAnswer|)
              |INTG0;rationalize_ir;IrKIr;8| (|List| $) (270 . |algtower|)
              (275 . =) (281 . |reductum|) (286 . |leadingMonomial|)
              |INTG0;multivariate;SupK2F;18| (|IntegrationResult| 106)
              (|Fraction| 23) (|RationalIntegration| 7 23) (291 . |integrate|)
              (|Fraction| $) (296 . |elt|) (|Mapping| 7 106)
              (|IntegrationResultFunctions2| 106 7) (302 . |map|)
              (308 . |retract|) (313 . +) |INTG0;palgint0;F2KFSupIr;10|
              (319 . |monomial|) (325 . |coerce|) (330 . -) (|List| 7)
              (|ExpressionFactorPolynomial| 6 7) (336 . |factor|)
              (342 . |sqrt|) (347 . *) (|PositiveInteger|) (353 . *) (359 . -)
              (365 . |zero?|) (370 . ^) (376 . *) (382 . |eval|)
              (389 . |numer|) (394 . |denom|) (399 . /) (405 . |elt|)
              (411 . |retract|) (416 . |retract|) (421 . |coerce|)
              |INTG0;palgint0;F3KFFFIr;16| (426 . |multivariate|)
              (|Union| 9 '"failed") (432 . |symbolIfCan|)
              (|Union| 7 '#1="failed") (|Mapping| 143 7 7 9)
              |INTG0;palgRDE0;2F2KMKFFFU;17|
              (|SparseUnivariatePolynomialFunctions2| 106 7) (437 . |map|)
              (443 . |elt|) |INTG0;palgRDE0;2F2KMFSupU;19|
              (449 . |coefficients|) (454 . |inv|)
              (|LinearOrdinaryDifferentialOperator1| 106) (459 . |monomial|)
              (465 . |One|) (469 . |Zero|) (473 . |degree|)
              (478 . |coefficient|) (484 . *) (490 . +) (496 . *)
              (|Union| 106 '"failed")
              (|Record| (|:| |particular| 161) (|:| |basis| (|List| 106)))
              (|RationalLODE| 7 23) (502 . |ratDsolve|)
              (|Record| (|:| |particular| 143) (|:| |basis| 120))
              (508 . |palgLODE0|) (518 . |palgLODE0|))
           '#(|univariate| 530 |rationalize_ir| 538 |palgint0| 544 |palgRDE0|
              564 |palgLODE0| 588 |multivariate| 610 |lift| 617)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|palgint0|
                                 ((|IntegrationResult| |#2|) |#2|
                                  (|Kernel| |#2|) (|Kernel| |#2|) |#2|
                                  (|SparseUnivariatePolynomial| |#2|)))
                                T)
                              '((|palgint0|
                                 ((|IntegrationResult| |#2|) |#2|
                                  (|Kernel| |#2|) (|Kernel| |#2|)
                                  (|Kernel| |#2|) |#2|
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  |#2|))
                                T)
                              '((|palgRDE0|
                                 ((|Union| |#2| #1#) |#2| |#2| (|Kernel| |#2|)
                                  (|Kernel| |#2|)
                                  (|Mapping| (|Union| |#2| #1#) |#2| |#2|
                                             (|Symbol|))
                                  |#2| (|SparseUnivariatePolynomial| |#2|)))
                                T)
                              '((|palgRDE0|
                                 ((|Union| |#2| #1#) |#2| |#2| (|Kernel| |#2|)
                                  (|Kernel| |#2|)
                                  (|Mapping| (|Union| |#2| #1#) |#2| |#2|
                                             (|Symbol|))
                                  (|Kernel| |#2|) |#2|
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  |#2|))
                                T)
                              '((|univariate|
                                 ((|SparseUnivariatePolynomial|
                                   (|Fraction|
                                    (|SparseUnivariatePolynomial| |#2|)))
                                  |#2| (|Kernel| |#2|) (|Kernel| |#2|)
                                  (|SparseUnivariatePolynomial| |#2|)))
                                T)
                              '((|multivariate|
                                 (|#2|
                                  (|SparseUnivariatePolynomial|
                                   (|Fraction|
                                    (|SparseUnivariatePolynomial| |#2|)))
                                  (|Kernel| |#2|) |#2|))
                                T)
                              '((|lift|
                                 ((|SparseUnivariatePolynomial|
                                   (|Fraction|
                                    (|SparseUnivariatePolynomial| |#2|)))
                                  (|SparseUnivariatePolynomial| |#2|)
                                  (|Kernel| |#2|)))
                                T)
                              '((|rationalize_ir|
                                 ((|IntegrationResult| |#2|)
                                  (|IntegrationResult| |#2|) (|Kernel| |#2|)))
                                T)
                              '((|palgLODE0|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| |#2| #2="failed"))
                                   (|:| |basis| (|List| |#2|)))
                                  |#3| |#2| (|Kernel| |#2|) (|Kernel| |#2|)
                                  |#2| (|SparseUnivariatePolynomial| |#2|)))
                                (|has| 8
                                       (|LinearOrdinaryDifferentialOperatorCategory|
                                        7)))
                              '((|palgLODE0|
                                 ((|Record|
                                   (|:| |particular| (|Union| |#2| #2#))
                                   (|:| |basis| (|List| |#2|)))
                                  |#3| |#2| (|Kernel| |#2|) (|Kernel| |#2|)
                                  (|Kernel| |#2|) |#2|
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  |#2|))
                                (|has| 8
                                       (|LinearOrdinaryDifferentialOperatorCategory|
                                        7))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 167
                                            '(0 9 0 10 1 11 0 9 12 1 7 14 0 15
                                              2 16 0 0 0 17 2 18 7 7 11 19 2 7
                                              20 0 21 22 3 24 23 7 11 23 25 2
                                              30 26 29 23 31 1 23 32 0 33 0 23
                                              0 34 1 38 37 0 39 2 23 0 0 40 41
                                              2 23 0 0 0 42 2 40 43 0 0 44 1 38
                                              23 0 45 1 23 7 0 46 2 48 47 7 40
                                              49 2 23 0 7 0 50 1 7 51 21 52 2
                                              55 53 54 23 56 0 6 0 57 0 7 0 58
                                              0 40 0 59 2 23 7 0 40 60 2 62 23
                                              61 53 63 0 6 0 64 0 7 0 65 0 40 0
                                              66 0 23 0 67 2 23 43 0 0 68 2 23
                                              0 0 0 69 2 23 70 0 0 71 1 23 40 0
                                              72 2 23 0 0 0 73 1 7 0 21 74 1 7
                                              0 0 75 3 7 0 0 21 0 76 2 23 0 77
                                              0 78 2 23 43 0 0 79 1 81 0 80 82
                                              2 81 0 0 0 83 2 23 0 0 0 84 1 85
                                              7 0 86 2 7 0 0 0 87 1 7 0 80 88 2
                                              7 0 0 0 89 1 85 91 0 92 2 91 0 0
                                              0 93 1 85 95 0 96 3 85 0 7 91 95
                                              97 1 7 14 99 100 2 11 43 0 0 101
                                              1 26 0 0 102 1 26 0 0 103 1 107
                                              105 106 108 2 23 7 109 7 110 2
                                              112 85 111 105 113 1 26 106 0 114
                                              2 85 0 0 0 115 2 23 0 7 40 117 1
                                              23 0 7 118 2 23 0 0 0 119 2 121
                                              38 23 120 122 1 7 0 0 123 2 7 0 0
                                              0 124 2 7 0 125 0 126 2 7 0 0 0
                                              127 1 7 43 0 128 2 7 0 0 125 129
                                              2 106 0 0 0 130 3 7 0 0 14 99 131
                                              1 106 23 0 132 1 106 23 0 133 2
                                              106 0 23 23 134 2 23 109 109 109
                                              135 1 106 23 0 136 1 23 7 0 137 1
                                              106 0 23 138 2 24 7 106 11 140 1
                                              11 141 0 142 2 146 23 111 26 147
                                              2 23 7 0 7 148 1 8 120 0 150 1 7
                                              0 0 151 2 152 0 106 40 153 0 152
                                              0 154 0 152 0 155 1 8 40 0 156 2
                                              8 7 0 40 157 2 152 0 106 0 158 2
                                              152 0 0 0 159 2 152 0 0 0 160 2
                                              163 162 152 106 164 6 0 165 8 7
                                              11 11 7 23 166 8 0 165 8 7 11 11
                                              11 7 106 7 167 4 0 26 7 11 11 23
                                              28 2 0 85 85 11 98 7 0 85 7 11 11
                                              11 7 106 7 139 5 0 85 7 11 11 7
                                              23 116 7 0 143 7 7 11 11 144 7 23
                                              149 9 0 143 7 7 11 11 144 11 7
                                              106 7 145 8 1 165 8 7 11 11 11 7
                                              106 7 167 6 1 165 8 7 11 11 7 23
                                              166 3 0 7 26 11 7 104 2 0 26 23
                                              11 27)))))
           '|lookupComplete|)) 
