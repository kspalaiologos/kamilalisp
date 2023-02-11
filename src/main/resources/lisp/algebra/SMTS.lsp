
(PUT '|SMTS;coefficients;$S;1| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |SMTS;coefficients;$S;1| ((|s| ($)) ($ (|Stream| SMP))) |s|) 

(PUT '|SMTS;series;S$;2| '|SPADreplace| '(XLAM (|st|) |st|)) 

(SDEFUN |SMTS;series;S$;2| ((|st| (|Stream| SMP)) ($ ($))) |st|) 

(SDEFUN |SMTS;extend;$Nni$;3| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |x| (+ |n| 1) (QREFELT $ 16))) 

(SDEFUN |SMTS;complete;2$;4| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 19))) 

(SDEFUN |SMTS;evalstream|
        ((|s| ($)) (|lv| (|List| |Var|)) (|lsmp| (|List| SMP))
         ($ (|Stream| SMP)))
        (SPROG NIL
               (SPADCALL (|spadConstant| $ 23) (ELT $ 24)
                         (SPADCALL
                          (CONS #'|SMTS;evalstream!0| (VECTOR $ |lsmp| |lv|))
                          |s| (QREFELT $ 29))
                         (QREFELT $ 32)))) 

(SDEFUN |SMTS;evalstream!0| ((|z1| NIL) ($$ NIL))
        (PROG (|lv| |lsmp| $)
          (LETT |lv| (QREFELT $$ 2))
          (LETT |lsmp| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |lv| |lsmp| (QREFELT $ 27)))))) 

(SDEFUN |SMTS;addvariable|
        ((|v| (|Var|)) (|s| (|InnerTaylorSeries| |Coef|)) ($ ($)))
        (SPROG ((|ints| (|Stream| (|NonNegativeInteger|))))
               (SEQ (LETT |ints| (SPADCALL 0 (QREFELT $ 35)))
                    (EXIT
                     (SPADCALL (CONS #'|SMTS;addvariable!0| (VECTOR |v| $))
                               |ints| |s| (QREFELT $ 42)))))) 

(SDEFUN |SMTS;addvariable!0| ((|n1| NIL) (|c2| NIL) ($$ NIL))
        (PROG ($ |v|)
          (LETT $ (QREFELT $$ 1))
          (LETT |v| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c2| (QREFELT $ 36)) |v| |n1|
                      (QREFELT $ 37)))))) 

(SDEFUN |SMTS;coefficient;$NniSMP;7|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (SMP)))
        (SPROG ((#1=#:G741 NIL) (|u| (|Rep|)))
               (SEQ (LETT |u| |x|)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((SPADCALL |u| (QREFELT $ 44)) NIL)
                                  ('T (> |n| 0))))
                           (GO G191)))
                         (SEQ (LETT |u| (SPADCALL |u| (QREFELT $ 45)))
                              (EXIT
                               (LETT |n|
                                     (PROG1 (LETT #1# (- |n| 1))
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (COND
                     ((OR (SPADCALL |u| (QREFELT $ 44))
                          (SPADCALL |n| 0 (QREFELT $ 46)))
                      (EXIT (|spadConstant| $ 23))))
                    (EXIT (SPADCALL |u| (QREFELT $ 47)))))) 

(SDEFUN |SMTS;coefficient;$LL$;8|
        ((|s| ($)) (|lv| (|List| |Var|)) (|ln| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|SMTS;coefficient;$LL$;8!0| (VECTOR $ |ln| |lv|))
                (SPADCALL |s| (SPADCALL (ELT $ 51) |ln| (QREFELT $ 53))
                          (QREFELT $ 54))
                (QREFELT $ 55)))) 

(SDEFUN |SMTS;coefficient;$LL$;8!0| ((|z1| NIL) ($$ NIL))
        (PROG (|lv| |ln| $)
          (LETT |lv| (QREFELT $$ 2))
          (LETT |ln| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |lv| |ln| (QREFELT $ 50)))))) 

(SDEFUN |SMTS;coefficient;$IeCoef;9|
        ((|s| ($)) (|m| (|IndexedExponents| |Var|)) ($ (|Coef|)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (|mon| (|IndexedExponents| |Var|)))
         (SEQ (LETT |n| (SPADCALL (LETT |mon| |m|) (QREFELT $ 58)))
              (SEQ G190
                   (COND
                    ((NULL
                      (NULL
                       (SPADCALL (LETT |mon| (SPADCALL |mon| (QREFELT $ 59)))
                                 (QREFELT $ 60))))
                     (GO G191)))
                   (SEQ
                    (EXIT (LETT |n| (+ |n| (SPADCALL |mon| (QREFELT $ 58))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |s| |n| (QREFELT $ 48)) |m|
                         (QREFELT $ 61)))))) 

(SDEFUN |SMTS;coerce;Coef$;10| ((|r| (|Coef|)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 36)) 0 (QREFELT $ 63))) 

(SDEFUN |SMTS;*;SMP2$;11| ((|smp| (SMP)) (|p| ($)) ($ ($)))
        (SPADCALL |smp| |p| (QREFELT $ 65))) 

(SDEFUN |SMTS;*;Coef2$;12| ((|r| (|Coef|)) (|p| ($)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 36)) |p| (QREFELT $ 65))) 

(SDEFUN |SMTS;*;$Coef$;13| ((|p| ($)) (|r| (|Coef|)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 36)) |p| (QREFELT $ 65))) 

(SDEFUN |SMTS;mts| ((|p| (SMP)) ($ ($)))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| SMP)) (|s| ($)) (|v| (|Var|))
          (|uv| (|Union| |Var| "failed")))
         (SEQ (LETT |uv| (SPADCALL |p| (QREFELT $ 70)))
              (EXIT
               (COND ((QEQCAR |uv| 1) (SPADCALL |p| 0 (QREFELT $ 63)))
                     ('T
                      (SEQ (LETT |v| (QCDR |uv|))
                           (LETT |s| (|spadConstant| $ 21))
                           (LETT |up| (SPADCALL |p| |v| (QREFELT $ 72)))
                           (SEQ G190
                                (COND
                                 ((NULL (NULL (SPADCALL |up| (QREFELT $ 74))))
                                  (GO G191)))
                                (SEQ
                                 (LETT |s|
                                       (SPADCALL |s|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (|spadConstant| $ 13) |v|
                                                   (SPADCALL |up|
                                                             (QREFELT $ 75))
                                                   (QREFELT $ 76))
                                                  (|SMTS;mts|
                                                   (SPADCALL |up|
                                                             (QREFELT $ 77))
                                                   $)
                                                  (QREFELT $ 78))
                                                 (QREFELT $ 79)))
                                 (EXIT
                                  (LETT |up| (SPADCALL |up| (QREFELT $ 80)))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT |s|)))))))) 

(SDEFUN |SMTS;coerce;SMP$;15| ((|p| (SMP)) ($ ($))) (|SMTS;mts| |p| $)) 

(SDEFUN |SMTS;coerce;Var$;16| ((|v| (|Var|)) ($ ($)))
        (SPADCALL (SPADCALL |v| (QREFELT $ 82)) (QREFELT $ 81))) 

(SDEFUN |SMTS;monomial;$VarNni$;17|
        ((|r| ($)) (|v| (|Var|)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |r|
                  (SPADCALL
                   (SPADCALL (|spadConstant| $ 84) |v| |n| (QREFELT $ 37)) |n|
                   (QREFELT $ 63))
                  (QREFELT $ 78))) 

(SDEFUN |SMTS;monomial;$LL$;18|
        ((|r| ($)) (|lv| (|List| |Var|)) (|ln| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (SPADCALL (ELT $ 51) |ln| 0 (QREFELT $ 85)))
                    (EXIT
                     (SPADCALL |r|
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 84) |lv| |ln|
                                          (QREFELT $ 86))
                                |n| (QREFELT $ 63))
                               (QREFELT $ 78)))))) 

(SDEFUN |SMTS;monomial;CoefIe$;19|
        ((|r| (|Coef|)) (|d| (|IndexedExponents| |Var|)) ($ ($)))
        (SPROG ((|mp| (SMP)))
               (SEQ (LETT |mp| (SPADCALL |r| |d| (QREFELT $ 88)))
                    (EXIT
                     (SPADCALL |mp| (SPADCALL |mp| (QREFELT $ 89))
                               (QREFELT $ 63)))))) 

(SDEFUN |SMTS;substvar|
        ((|p| (SMP)) (|vl| (|List| |Var|)) (|q| (|List| $)) ($ ($)))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| SMP)) (|s| ($)) (|c| (SMP))
          (|v| (|Var|)) (|uv| (|Union| |Var| "failed")))
         (SEQ
          (COND ((NULL |vl|) (SPADCALL |p| 0 (QREFELT $ 63)))
                (#1='T
                 (SEQ (LETT |uv| (SPADCALL |p| (QREFELT $ 70)))
                      (EXIT
                       (COND ((QEQCAR |uv| 1) (SPADCALL |p| 0 (QREFELT $ 63)))
                             (#1#
                              (SEQ (LETT |v| (QCDR |uv|))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |v| (|SPADfirst| |vl|)
                                                (QREFELT $ 91))
                                      (SEQ (LETT |s| (|spadConstant| $ 21))
                                           (LETT |up|
                                                 (SPADCALL |p| |v|
                                                           (QREFELT $ 72)))
                                           (SEQ G190
                                                (COND
                                                 ((NULL
                                                   (NULL
                                                    (SPADCALL |up|
                                                              (QREFELT $ 74))))
                                                  (GO G191)))
                                                (SEQ
                                                 (LETT |c|
                                                       (SPADCALL |up|
                                                                 (QREFELT $
                                                                          77)))
                                                 (LETT |s|
                                                       (SPADCALL |s|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |q|
                                                                    (QREFELT $
                                                                             93))
                                                                   (SPADCALL
                                                                    |up|
                                                                    (QREFELT $
                                                                             75))
                                                                   (QREFELT $
                                                                            94))
                                                                  (|SMTS;substvar|
                                                                   |c|
                                                                   (CDR |vl|)
                                                                   (SPADCALL
                                                                    |q|
                                                                    (QREFELT $
                                                                             95))
                                                                   $)
                                                                  (QREFELT $
                                                                           78))
                                                                 (QREFELT $
                                                                          79)))
                                                 (EXIT
                                                  (LETT |up|
                                                        (SPADCALL |up|
                                                                  (QREFELT $
                                                                           80)))))
                                                NIL (GO G190) G191 (EXIT NIL))
                                           (EXIT |s|)))
                                     (#1#
                                      (|SMTS;substvar| |p| (CDR |vl|)
                                       (SPADCALL |q| (QREFELT $ 95))
                                       $)))))))))))))) 

(SDEFUN |SMTS;sortmfirst|
        ((|p| (SMP)) (|vl| (|List| |Var|)) (|q| (|List| $)) ($ ($)))
        (SPROG
         ((|nq| (|List| $)) (#1=#:G820 NIL) (|i| NIL) (#2=#:G819 NIL)
          (|nlv| (|List| |Var|)))
         (SEQ (LETT |nlv| (SPADCALL (ELT $ 96) |vl| (QREFELT $ 98)))
              (LETT |nq|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| NIL) (LETT #1# |nlv|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL |q|
                                             (SPADCALL |i| |vl| (QREFELT $ 99))
                                             (QREFELT $ 100))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (|SMTS;substvar| |p| |nlv| |nq| $))))) 

(SDEFUN |SMTS;csubst;LLM;22|
        ((|vl| (|List| |Var|)) (|q| (|List| (|Stream| SMP)))
         ($ (|Mapping| (|Stream| SMP) SMP)))
        (SPROG NIL (CONS #'|SMTS;csubst;LLM;22!0| (VECTOR $ |q| |vl|)))) 

(SDEFUN |SMTS;csubst;LLM;22!0| ((|p1| NIL) ($$ NIL))
        (PROG (|vl| |q| $)
          (LETT |vl| (QREFELT $$ 2))
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|SMTS;sortmfirst| |p1| |vl| |q| $))))) 

(SDEFUN |SMTS;restCheck| ((|s| (|Stream| SMP)) ($ (|Stream| SMP)))
        (COND ((SPADCALL |s| (QREFELT $ 44)) |s|)
              ((NULL (SPADCALL (SPADCALL |s| (QREFELT $ 47)) (QREFELT $ 104)))
               (|error| "eval: constant coefficient should be 0"))
              ('T (SPADCALL |s| (QREFELT $ 105))))) 

(SDEFUN |SMTS;eval;$LL$;24|
        ((|s| ($)) (|v| (|List| |Var|)) (|q| (|List| $)) ($ ($)))
        (SPROG
         ((|nq| (|List| (|Stream| SMP))) (#1=#:G836 NIL) (|i| NIL)
          (#2=#:G835 NIL))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |v|) (SPADCALL |q| (QREFELT $ 106))
                      (QREFELT $ 46))
            (|error|
             "eval: number of variables should equal number of values"))
           ('T
            (SEQ
             (LETT |nq|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |i| NIL) (LETT #1# |q|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2# (CONS (|SMTS;restCheck| |i| $) #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#)))))
             (EXIT
              (SPADCALL
               (SPADCALL (SPADCALL |v| |nq| (QREFELT $ 103)) |s|
                         (QREFELT $ 109))
               (QREFELT $ 110))))))))) 

(SDEFUN |SMTS;substmts| ((|v| (|Var|)) (|p| (SMP)) (|q| ($)) ($ ($)))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| SMP)) (|ss| ($)) (|c| (SMP))
          (|d| (|NonNegativeInteger|)))
         (SEQ (LETT |up| (SPADCALL |p| |v| (QREFELT $ 72)))
              (LETT |ss| (|spadConstant| $ 21))
              (SEQ G190
                   (COND
                    ((NULL (NULL (SPADCALL |up| (QREFELT $ 74)))) (GO G191)))
                   (SEQ (LETT |d| (SPADCALL |up| (QREFELT $ 75)))
                        (LETT |c| (SPADCALL |up| (QREFELT $ 77)))
                        (LETT |ss|
                              (SPADCALL |ss|
                                        (SPADCALL |c|
                                                  (SPADCALL |q| |d|
                                                            (QREFELT $ 94))
                                                  (QREFELT $ 66))
                                        (QREFELT $ 79)))
                        (EXIT (LETT |up| (SPADCALL |up| (QREFELT $ 80)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |ss|)))) 

(SDEFUN |SMTS;subststream|
        ((|v| (|Var|)) (|p| (SMP)) (|q| (|Stream| SMP)) ($ (|Stream| SMP)))
        (|SMTS;substmts| |v| |p| |q| $)) 

(SDEFUN |SMTS;comp1|
        ((|v| (|Var|)) (|r| (|Stream| SMP)) (|t| (|Stream| SMP))
         ($ (|Stream| SMP)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (CONS #'|SMTS;comp1!0| (VECTOR $ |t| |v|)) |r|
                          (QREFELT $ 109))
                (QREFELT $ 110)))) 

(SDEFUN |SMTS;comp1!0| ((|p1| NIL) ($$ NIL))
        (PROG (|v| |t| $)
          (LETT |v| (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|SMTS;subststream| |v| |p1| |t| $))))) 

(SDEFUN |SMTS;comp|
        ((|v| (|Var|)) (|s| (|Stream| SMP)) (|t| (|Stream| SMP))
         ($ (|Stream| SMP)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|SMTS;comp!0| (VECTOR |v| |t| $ |s|))
                          (QREFELT $ 116))))) 

(SDEFUN |SMTS;comp!0| (($$ NIL))
        (PROG (|s| $ |t| |v|)
          (LETT |s| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT |v| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|f| NIL) (|r| NIL))
                   (SEQ
                    (COND ((SPADCALL |s| (QREFELT $ 44)) |s|)
                          ('T
                           (SEQ (LETT |f| (SPADCALL |s| (QREFELT $ 47)))
                                (LETT |r| (SPADCALL |s| (QREFELT $ 105)))
                                (EXIT
                                 (COND ((SPADCALL |r| (QREFELT $ 44)) |s|)
                                       ((SPADCALL |t| (QREFELT $ 44))
                                        (SPADCALL |f|
                                                  (|SMTS;comp1| |v| |r|
                                                   (SPADCALL (QREFELT $ 112))
                                                   $)
                                                  (QREFELT $ 114)))
                                       ((NULL
                                         (SPADCALL
                                          (SPADCALL |t| (QREFELT $ 47))
                                          (QREFELT $ 104)))
                                        (|error|
                                         "eval: constant coefficient should be zero"))
                                       ('T
                                        (SPADCALL |f|
                                                  (|SMTS;comp1| |v| |r|
                                                   (SPADCALL |t|
                                                             (QREFELT $ 105))
                                                   $)
                                                  (QREFELT $ 114)))))))))))))) 

(SDEFUN |SMTS;eval;$Var2$;29| ((|s| ($)) (|v| (|Var|)) (|t| ($)) ($ ($)))
        (|SMTS;comp| |v| |s| |t| $)) 

(SDEFUN |SMTS;differentiate;$Var$;30| ((|s| ($)) (|v| (|Var|)) ($ ($)))
        (SPROG NIL
               (COND ((SPADCALL |s| (QREFELT $ 44)) (|spadConstant| $ 21))
                     ('T
                      (SPADCALL
                       (CONS #'|SMTS;differentiate;$Var$;30!0| (VECTOR $ |v|))
                       (SPADCALL |s| (QREFELT $ 45)) (QREFELT $ 55)))))) 

(SDEFUN |SMTS;differentiate;$Var$;30!0| ((|z1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |v| (QREFELT $ 118)))))) 

(PUT '|SMTS;stream| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |SMTS;stream| ((|x| ($)) ($ (|Rep|))) |x|) 

(SDEFUN |SMTS;^;$F$;32| ((|x| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL |r| (|SMTS;stream| |x| $) (QREFELT $ 121))) 

(SDEFUN |SMTS;*;F2$;33| ((|r| (|Fraction| (|Integer|))) (|x| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|SMTS;*;F2$;33!0| (VECTOR $ |r|))
                         (|SMTS;stream| |x| $) (QREFELT $ 124)))) 

(SDEFUN |SMTS;*;F2$;33!0| ((|z1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r| |z1| (QREFELT $ 123)))))) 

(SDEFUN |SMTS;*;$F$;34| ((|x| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|SMTS;*;$F$;34!0| (VECTOR $ |r|))
                         (|SMTS;stream| |x| $) (QREFELT $ 124)))) 

(SDEFUN |SMTS;*;$F$;34!0| ((|z1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |r| (QREFELT $ 126)))))) 

(SDEFUN |SMTS;exp;2$;35| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 129))) 

(SDEFUN |SMTS;log;2$;36| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 131))) 

(SDEFUN |SMTS;sin;2$;37| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 133))) 

(SDEFUN |SMTS;cos;2$;38| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 135))) 

(SDEFUN |SMTS;tan;2$;39| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 137))) 

(SDEFUN |SMTS;cot;2$;40| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 139))) 

(SDEFUN |SMTS;sec;2$;41| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 141))) 

(SDEFUN |SMTS;csc;2$;42| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 143))) 

(SDEFUN |SMTS;asin;2$;43| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 145))) 

(SDEFUN |SMTS;acos;2$;44| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 147))) 

(SDEFUN |SMTS;atan;2$;45| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 149))) 

(SDEFUN |SMTS;acot;2$;46| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 151))) 

(SDEFUN |SMTS;asec;2$;47| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 153))) 

(SDEFUN |SMTS;acsc;2$;48| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 155))) 

(SDEFUN |SMTS;sinh;2$;49| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 157))) 

(SDEFUN |SMTS;cosh;2$;50| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 159))) 

(SDEFUN |SMTS;tanh;2$;51| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 161))) 

(SDEFUN |SMTS;coth;2$;52| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 163))) 

(SDEFUN |SMTS;sech;2$;53| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 165))) 

(SDEFUN |SMTS;csch;2$;54| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 167))) 

(SDEFUN |SMTS;asinh;2$;55| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 169))) 

(SDEFUN |SMTS;acosh;2$;56| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 171))) 

(SDEFUN |SMTS;atanh;2$;57| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 173))) 

(SDEFUN |SMTS;acoth;2$;58| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 175))) 

(SDEFUN |SMTS;asech;2$;59| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 177))) 

(SDEFUN |SMTS;acsch;2$;60| ((|x| ($)) ($ ($)))
        (SPADCALL (|SMTS;stream| |x| $) (QREFELT $ 179))) 

(SDEFUN |SMTS;intsmp| ((|v| (|Var|)) (|p| (SMP)) ($ (SMP)))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| SMP)) (|ss| (SMP)) (|c| (SMP))
          (|d| (|NonNegativeInteger|)))
         (SEQ (LETT |up| (SPADCALL |p| |v| (QREFELT $ 72)))
              (LETT |ss| (|spadConstant| $ 23))
              (SEQ G190
                   (COND
                    ((NULL (NULL (SPADCALL |up| (QREFELT $ 74)))) (GO G191)))
                   (SEQ (LETT |d| (SPADCALL |up| (QREFELT $ 75)))
                        (LETT |c| (SPADCALL |up| (QREFELT $ 77)))
                        (LETT |ss|
                              (SPADCALL |ss|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL (+ |d| 1) (QREFELT $ 181))
                                          (QREFELT $ 182))
                                         (SPADCALL |c| |v| (+ |d| 1)
                                                   (QREFELT $ 37))
                                         (QREFELT $ 123))
                                        (QREFELT $ 24)))
                        (EXIT (LETT |up| (SPADCALL |up| (QREFELT $ 80)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |ss|)))) 

(SDEFUN |SMTS;fintegrate;MVarCoef$;62|
        ((|f| (|Mapping| $)) (|v| (|Var|)) (|r| (|Coef|)) ($ ($)))
        (SPROG NIL
               (SPADCALL (SPADCALL |r| (QREFELT $ 36))
                         (SPADCALL
                          (CONS #'|SMTS;fintegrate;MVarCoef$;62!1|
                                (VECTOR |f| |v| $))
                          (QREFELT $ 183))
                         (QREFELT $ 113)))) 

(SDEFUN |SMTS;fintegrate;MVarCoef$;62!1| (($$ NIL))
        (PROG ($ |v| |f|)
          (LETT $ (QREFELT $$ 2))
          (LETT |v| (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL
                    (CONS #'|SMTS;fintegrate;MVarCoef$;62!0| (VECTOR $ |v|))
                    (SPADCALL |f|) (QREFELT $ 55))))))) 

(SDEFUN |SMTS;fintegrate;MVarCoef$;62!0| ((|z1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|SMTS;intsmp| |v| |z1| $))))) 

(SDEFUN |SMTS;integrate;$VarCoef$;63|
        ((|s| ($)) (|v| (|Var|)) (|r| (|Coef|)) ($ ($)))
        (SPROG NIL
               (SPADCALL (SPADCALL |r| (QREFELT $ 36))
                         (SPADCALL
                          (CONS #'|SMTS;integrate;$VarCoef$;63!0|
                                (VECTOR $ |v|))
                          |s| (QREFELT $ 55))
                         (QREFELT $ 113)))) 

(SDEFUN |SMTS;integrate;$VarCoef$;63!0| ((|z1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|SMTS;intsmp| |v| |z1| $))))) 

(SDEFUN |SMTS;integrate;$Var$;64| ((|s| ($)) (|v| (|Var|)) ($ ($)))
        (SPADCALL |s| |v| (|spadConstant| $ 22) (QREFELT $ 185))) 

(SDEFUN |SMTS;tout| ((|p| (SMP)) ($ (|OutputForm|)))
        (SPROG ((|pe| (|OutputForm|)))
               (SEQ (LETT |pe| (SPADCALL |p| (QREFELT $ 188)))
                    (EXIT
                     (COND ((SPADCALL |p| (QREFELT $ 189)) |pe|)
                           ('T (SPADCALL |pe| (QREFELT $ 190)))))))) 

(PUT '|SMTS;showAll?| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |SMTS;showAll?| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |SMTS;coerce;$Of;67| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|uu| ($)) (|uu1| ($)) (|n| NIL)
          (#1=#:G994 NIL) (|count| (|NonNegativeInteger|)))
         (SEQ (LETT |uu| |s|)
              (EXIT
               (COND
                ((SPADCALL |uu| (QREFELT $ 44))
                 (SPADCALL (|spadConstant| $ 23) (QREFELT $ 188)))
                (#2='T
                 (SEQ (LETT |count| |$streamCount|) (LETT |l| NIL)
                      (SEQ (LETT |n| 0) (LETT #1# |count|) G190
                           (COND
                            ((OR (|greater_SI| |n| #1#)
                                 (NULL (NULL (SPADCALL |uu| (QREFELT $ 44)))))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL (SPADCALL |uu| (QREFELT $ 47))
                                        (|spadConstant| $ 23) (QREFELT $ 191))
                              (LETT |l|
                                    (CONS
                                     (|SMTS;tout|
                                      (SPADCALL |uu| (QREFELT $ 47)) $)
                                     |l|))))
                            (EXIT (LETT |uu| (SPADCALL |uu| (QREFELT $ 45)))))
                           (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((|SMTS;showAll?| $)
                        (SEQ (LETT |uu1| |uu|)
                             (EXIT
                              (SEQ (LETT |n| |n|) G190
                                   (COND
                                    ((NULL
                                      (COND
                                       ((SPADCALL |uu| (QREFELT $ 192))
                                        (NULL
                                         (SPADCALL |uu1|
                                                   (SPADCALL |uu|
                                                             (QREFELT $ 45))
                                                   (QREFELT $ 193))))
                                       ('T NIL)))
                                     (GO G191)))
                                   (SEQ
                                    (COND
                                     ((SPADCALL (SPADCALL |uu| (QREFELT $ 47))
                                                (|spadConstant| $ 23)
                                                (QREFELT $ 191))
                                      (LETT |l|
                                            (CONS
                                             (|SMTS;tout|
                                              (SPADCALL |uu| (QREFELT $ 47)) $)
                                             |l|))))
                                    (COND
                                     ((ODDP |n|)
                                      (LETT |uu1|
                                            (SPADCALL |uu1| (QREFELT $ 45)))))
                                    (EXIT
                                     (LETT |uu|
                                           (SPADCALL |uu| (QREFELT $ 45)))))
                                   (LETT |n| (+ |n| 1)) (GO G190) G191
                                   (EXIT NIL))))))
                      (LETT |l|
                            (COND ((SPADCALL |uu| (QREFELT $ 194)) |l|)
                                  (#2#
                                   (SEQ
                                    (COND
                                     ((SPADCALL |uu|
                                                (SPADCALL |uu| (QREFELT $ 45))
                                                (QREFELT $ 193))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |uu| (QREFELT $ 47))
                                         (|spadConstant| $ 23) (QREFELT $ 195))
                                        (EXIT |l|)))))
                                    (EXIT
                                     (CONS
                                      (SPADCALL (SPADCALL 'O (QREFELT $ 197))
                                                (LIST
                                                 (SPADCALL |n|
                                                           (QREFELT $ 198)))
                                                (QREFELT $ 199))
                                      |l|))))))
                      (EXIT
                       (COND
                        ((NULL |l|)
                         (SPADCALL (|spadConstant| $ 23) (QREFELT $ 188)))
                        (#2#
                         (SPADCALL (ELT $ 200) (NREVERSE |l|)
                                   (QREFELT $ 203)))))))))))) 

(SDEFUN |SMTS;/;$Coef$;68| ((|p| ($)) (|r| (|Coef|)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|SMTS;/;$Coef$;68!0| (VECTOR $ |r|))
                         (|SMTS;stream| |p| $) (QREFELT $ 124)))) 

(SDEFUN |SMTS;/;$Coef$;68!0| ((|z1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |r| (QREFELT $ 205)))))) 

(DECLAIM (NOTINLINE |SparseMultivariateTaylorSeries;|)) 

(DEFUN |SparseMultivariateTaylorSeries| (&REST #1=#:G1010)
  (SPROG NIL
         (PROG (#2=#:G1011)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SparseMultivariateTaylorSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |SparseMultivariateTaylorSeries;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseMultivariateTaylorSeries|)))))))))) 

(DEFUN |SparseMultivariateTaylorSeries;| (|#1| |#2| |#3|)
  (SPROG
   ((#1=#:G1009 NIL) (|pv$| NIL) (#2=#:G1008 NIL) ($ NIL) (|dv$| NIL)
    (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT |dv$| (LIST '|SparseMultivariateTaylorSeries| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 219))
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
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #2#
                                            (|HasCategory| |#1|
                                                           '(|IntegralDomain|)))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory|
                                         (|IndexedExponents| |#2|)
                                         '(|Comparable|))))))
    (|haddProp| |$ConstructorCache| '|SparseMultivariateTaylorSeries|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND #2# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 256))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|IntegralDomain|))
                (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 512))
    (AND
     (OR (AND #2# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #1#)
     (|augmentPredVector| $ 1024))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9 (|Stream| |#3|))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 122 (CONS (|dispatchFunction| |SMTS;^;$F$;32|) $))
       (QSETREFV $ 125 (CONS (|dispatchFunction| |SMTS;*;F2$;33|) $))
       (QSETREFV $ 127 (CONS (|dispatchFunction| |SMTS;*;$F$;34|) $))
       (QSETREFV $ 130 (CONS (|dispatchFunction| |SMTS;exp;2$;35|) $))
       (QSETREFV $ 132 (CONS (|dispatchFunction| |SMTS;log;2$;36|) $))
       (QSETREFV $ 134 (CONS (|dispatchFunction| |SMTS;sin;2$;37|) $))
       (QSETREFV $ 136 (CONS (|dispatchFunction| |SMTS;cos;2$;38|) $))
       (QSETREFV $ 138 (CONS (|dispatchFunction| |SMTS;tan;2$;39|) $))
       (QSETREFV $ 140 (CONS (|dispatchFunction| |SMTS;cot;2$;40|) $))
       (QSETREFV $ 142 (CONS (|dispatchFunction| |SMTS;sec;2$;41|) $))
       (QSETREFV $ 144 (CONS (|dispatchFunction| |SMTS;csc;2$;42|) $))
       (QSETREFV $ 146 (CONS (|dispatchFunction| |SMTS;asin;2$;43|) $))
       (QSETREFV $ 148 (CONS (|dispatchFunction| |SMTS;acos;2$;44|) $))
       (QSETREFV $ 150 (CONS (|dispatchFunction| |SMTS;atan;2$;45|) $))
       (QSETREFV $ 152 (CONS (|dispatchFunction| |SMTS;acot;2$;46|) $))
       (QSETREFV $ 154 (CONS (|dispatchFunction| |SMTS;asec;2$;47|) $))
       (QSETREFV $ 156 (CONS (|dispatchFunction| |SMTS;acsc;2$;48|) $))
       (QSETREFV $ 158 (CONS (|dispatchFunction| |SMTS;sinh;2$;49|) $))
       (QSETREFV $ 160 (CONS (|dispatchFunction| |SMTS;cosh;2$;50|) $))
       (QSETREFV $ 162 (CONS (|dispatchFunction| |SMTS;tanh;2$;51|) $))
       (QSETREFV $ 164 (CONS (|dispatchFunction| |SMTS;coth;2$;52|) $))
       (QSETREFV $ 166 (CONS (|dispatchFunction| |SMTS;sech;2$;53|) $))
       (QSETREFV $ 168 (CONS (|dispatchFunction| |SMTS;csch;2$;54|) $))
       (QSETREFV $ 170 (CONS (|dispatchFunction| |SMTS;asinh;2$;55|) $))
       (QSETREFV $ 172 (CONS (|dispatchFunction| |SMTS;acosh;2$;56|) $))
       (QSETREFV $ 174 (CONS (|dispatchFunction| |SMTS;atanh;2$;57|) $))
       (QSETREFV $ 176 (CONS (|dispatchFunction| |SMTS;acoth;2$;58|) $))
       (QSETREFV $ 178 (CONS (|dispatchFunction| |SMTS;asech;2$;59|) $))
       (QSETREFV $ 180 (CONS (|dispatchFunction| |SMTS;acsch;2$;60|) $))
       (QSETREFV $ 184
                 (CONS (|dispatchFunction| |SMTS;fintegrate;MVarCoef$;62|) $))
       (QSETREFV $ 185
                 (CONS (|dispatchFunction| |SMTS;integrate;$VarCoef$;63|) $))
       (QSETREFV $ 186
                 (CONS (|dispatchFunction| |SMTS;integrate;$Var$;64|) $)))))
    (COND
     ((|testBitVector| |pv$| 7)
      (PROGN
       (QSETREFV $ 206 (CONS (|dispatchFunction| |SMTS;/;$Coef$;68|) $)))))
    $))) 

(MAKEPROP '|SparseMultivariateTaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|InnerTaylorSeries| 8) (|local| |#1|)
              (|local| |#2|) (|local| |#3|) '|Rep| (|Stream| 8)
              |SMTS;coefficients;$S;1| |SMTS;series;S$;2| (0 . |One|)
              (4 . |One|) (|Integer|) (8 . |extend|) (|NonNegativeInteger|)
              |SMTS;extend;$Nni$;3| (14 . |complete|) |SMTS;complete;2$;4|
              (19 . |Zero|) (23 . |Zero|) (27 . |Zero|) (31 . +) (|List| 7)
              (|List| $) (37 . |eval|) (|Mapping| 8 8) (44 . |map|)
              (|Mapping| 8 8 8) (|StreamFunctions2| 8 8) (50 . |scan|)
              (|Stream| 15) (|StreamTaylorSeriesOperations| 8)
              (57 . |integers|) (62 . |coerce|) (67 . |monomial|)
              (|Mapping| 8 17 6) (|Stream| 17) (|Stream| 6)
              (|StreamFunctions3| 17 6 8) (74 . |map|) (|Boolean|)
              (81 . |empty?|) (86 . |rst|) (91 . ~=) (97 . |frst|)
              |SMTS;coefficient;$NniSMP;7| (|List| 17) (102 . |coefficient|)
              (109 . +) (|Mapping| 17 17 17) (115 . |reduce|) (121 . |rest|)
              (127 . |map|) |SMTS;coefficient;$LL$;8| (|IndexedExponents| 7)
              (133 . |leadingCoefficient|) (138 . |reductum|) (143 . |zero?|)
              (148 . |coefficient|) |SMTS;coefficient;$IeCoef;9|
              (154 . |monom|) |SMTS;coerce;Coef$;10| (160 . *)
              |SMTS;*;SMP2$;11| |SMTS;*;Coef2$;12| |SMTS;*;$Coef$;13|
              (|Union| 7 '"failed") (166 . |mainVariable|)
              (|SparseUnivariatePolynomial| $) (171 . |univariate|)
              (|SparseUnivariatePolynomial| 8) (177 . |zero?|) (182 . |degree|)
              |SMTS;monomial;$VarNni$;17| (187 . |leadingCoefficient|)
              (192 . *) (198 . +) (204 . |reductum|) |SMTS;coerce;SMP$;15|
              (209 . |coerce|) |SMTS;coerce;Var$;16| (214 . |One|)
              (218 . |reduce|) (225 . |monomial|) |SMTS;monomial;$LL$;18|
              (232 . |monomial|) (238 . |totalDegree|)
              |SMTS;monomial;CoefIe$;19| (243 . =) (|List| $$) (249 . |first|)
              (254 . ^) (260 . |rest|) (265 . >) (|Mapping| 43 7 7)
              (271 . |sort|) (277 . |position|) (283 . |elt|) (|Mapping| 10 8)
              (|List| 10) |SMTS;csubst;LLM;22| (289 . |zero?|) (294 . |rst|)
              (299 . |#|) (|Stream| 10) (|StreamFunctions2| 8 10) (304 . |map|)
              (310 . |addiag|) |SMTS;eval;$LL$;24| (315 . |empty|)
              (319 . |concat|) (325 . |concat|) (|Mapping| $) (331 . |delay|)
              |SMTS;eval;$Var2$;29| (336 . |differentiate|)
              |SMTS;differentiate;$Var$;30| (|Fraction| 15) (342 . |powern|)
              (348 . ^) (354 . *) (360 . |map|) (366 . *) (372 . *) (378 . *)
              (|StreamTranscendentalFunctions| 8) (384 . |exp|) (389 . |exp|)
              (394 . |log|) (399 . |log|) (404 . |sin|) (409 . |sin|)
              (414 . |cos|) (419 . |cos|) (424 . |tan|) (429 . |tan|)
              (434 . |cot|) (439 . |cot|) (444 . |sec|) (449 . |sec|)
              (454 . |csc|) (459 . |csc|) (464 . |asin|) (469 . |asin|)
              (474 . |acos|) (479 . |acos|) (484 . |atan|) (489 . |atan|)
              (494 . |acot|) (499 . |acot|) (504 . |asec|) (509 . |asec|)
              (514 . |acsc|) (519 . |acsc|) (524 . |sinh|) (529 . |sinh|)
              (534 . |cosh|) (539 . |cosh|) (544 . |tanh|) (549 . |tanh|)
              (554 . |coth|) (559 . |coth|) (564 . |sech|) (569 . |sech|)
              (574 . |csch|) (579 . |csch|) (584 . |asinh|) (589 . |asinh|)
              (594 . |acosh|) (599 . |acosh|) (604 . |atanh|) (609 . |atanh|)
              (614 . |acoth|) (619 . |acoth|) (624 . |asech|) (629 . |asech|)
              (634 . |acsch|) (639 . |acsch|) (644 . |coerce|) (649 . |inv|)
              (654 . |delay|) (659 . |fintegrate|) (666 . |integrate|)
              (673 . |integrate|) (|OutputForm|) (679 . |coerce|)
              (684 . |monomial?|) (689 . |paren|) (694 . ~=)
              (700 . |explicitEntries?|) (705 . |eq?|)
              (711 . |explicitlyEmpty?|) (716 . =) (|Symbol|) (722 . |coerce|)
              (727 . |coerce|) (732 . |prefix|) (738 . +)
              (|Mapping| 187 187 187) (|List| 187) (744 . |reduce|)
              |SMTS;coerce;$Of;67| (750 . /) (756 . /) (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |k| 57) (|:| |c| 6)) (|List| 209) (|Polynomial| 6)
              (|Equation| $) (|List| 212) (|Mapping| 6 6) (|PositiveInteger|)
              (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 762 |zero?| 768 |unitNormal| 773 |unitCanonical| 778 |unit?|
              783 |tanh| 788 |tan| 793 |subtractIfCan| 798 |sqrt| 804 |sinh|
              809 |sin| 814 |series| 819 |sech| 824 |sec| 829 |sample| 834
              |rightRecip| 838 |rightPower| 843 |reductum| 855 |recip| 860
              |polynomial| 865 |pole?| 878 |pi| 883 |order| 887 |opposite?| 900
              |one?| 906 |nthRoot| 911 |monomial?| 917 |monomial| 922 |map| 942
              |log| 948 |leftRecip| 953 |leftPower| 958 |leadingTerm| 970
              |leadingSupport| 975 |leadingMonomial| 980 |leadingCoefficient|
              985 |latex| 990 |integrate| 995 |hashUpdate!| 1008 |hash| 1014
              |fintegrate| 1019 |extend| 1026 |exquo| 1032 |exp| 1038 |eval|
              1043 |differentiate| 1083 |degree| 1109 |csubst| 1114 |csch| 1120
              |csc| 1125 |coth| 1130 |cot| 1135 |cosh| 1140 |cos| 1145
              |constructOrdered| 1150 |construct| 1155 |complete| 1160
              |commutator| 1165 |coerce| 1171 |coefficients| 1206 |coefficient|
              1211 |charthRoot| 1237 |characteristic| 1242 |atanh| 1246 |atan|
              1251 |associator| 1256 |associates?| 1263 |asinh| 1269 |asin|
              1274 |asech| 1279 |asec| 1284 |antiCommutator| 1289 |annihilate?|
              1295 |acsch| 1301 |acsc| 1306 |acoth| 1311 |acot| 1316 |acosh|
              1321 |acos| 1326 ^ 1331 |Zero| 1355 |One| 1359 D 1363 = 1389 /
              1395 - 1401 + 1412 * 1418)
           'NIL
           (CONS
            (|makeByteWordVec2| 6
                                '(0 0 0 2 6 0 1 6 2 3 4 5 0 0 0 0 1 6 5 0 0 0 0
                                  1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 6
                                  0 0 0 0 0 0 1 1 1 1 1 1 6 2))
            (CONS
             '#(|MultivariateTaylorSeriesCategory&| |PowerSeriesCategory&|
                |AbelianMonoidRing&| NIL NIL |PartialDifferentialRing&|
                |Algebra&| |Algebra&| |EntireRing&| NIL NIL |Algebra&| NIL
                |Rng&| NIL NIL |Module&| |Module&| |Module&| NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL |NonAssociativeRng&|
                NIL NIL NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| |Evalable&| |SetCategory&|
                |TranscendentalFunctionCategory&| NIL |InnerEvalable&|
                |InnerEvalable&| NIL NIL |BasicType&| NIL
                |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                |RadicalCategory&| NIL NIL)
             (CONS
              '#((|MultivariateTaylorSeriesCategory| 6 7)
                 (|PowerSeriesCategory| 6 (|IndexedExponents| 7) 7)
                 (|AbelianMonoidRing| 6 (|IndexedExponents| 7))
                 (|IntegralDomain|) (|CommutativeRing|)
                 (|PartialDifferentialRing| 7) (|Algebra| 120) (|Algebra| $$)
                 (|EntireRing|) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6) (|Ring|) (|Rng|)
                 (|SemiRing|) (|SemiRng|) (|Module| 120) (|Module| $$)
                 (|Module| 6)
                 (|IndexedProductCategory| 6 (|IndexedExponents| 7))
                 (|BiModule| 6 6) (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|BiModule| 120 120) (|AbelianProductCategory| 6)
                 (|LeftModule| 6) (|RightModule| 6) (|NonAssociativeRng|)
                 (|RightModule| $$) (|LeftModule| $$) (|LeftModule| 120)
                 (|RightModule| 120) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|Evalable| $$) (|SetCategory|)
                 (|TranscendentalFunctionCategory|) (|CommutativeStar|)
                 (|InnerEvalable| $$ $$) (|InnerEvalable| 7 $$)
                 (|VariablesCommuteWithCoefficients|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 187)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|)
                 (|TwoSidedRecip|) (|noZeroDivisors|))
              (|makeByteWordVec2| 218
                                  '(0 0 0 13 0 6 0 14 2 9 0 0 15 16 1 9 0 0 19
                                    0 0 0 21 0 6 0 22 0 8 0 23 2 8 0 0 0 24 3 8
                                    0 0 25 26 27 2 10 0 28 0 29 3 31 10 8 30 10
                                    32 1 34 33 15 35 1 8 0 6 36 3 8 0 0 7 17 37
                                    3 41 10 38 39 40 42 1 9 43 0 44 1 9 0 0 45
                                    2 17 43 0 0 46 1 9 8 0 47 3 8 0 0 25 49 50
                                    2 17 0 0 0 51 2 49 17 52 0 53 2 9 0 0 17 54
                                    2 9 0 28 0 55 1 57 17 0 58 1 57 0 0 59 1 57
                                    43 0 60 2 8 6 0 57 61 2 34 10 8 15 63 2 34
                                    10 8 10 65 1 8 69 0 70 2 8 71 0 7 72 1 73
                                    43 0 74 1 73 17 0 75 1 73 8 0 77 2 0 0 0 0
                                    78 2 0 0 0 0 79 1 73 0 0 80 1 8 0 7 82 0 8
                                    0 84 3 49 17 52 0 17 85 3 8 0 0 25 49 86 2
                                    8 0 6 57 88 1 8 17 0 89 2 7 43 0 0 91 1 92
                                    2 0 93 2 0 0 0 17 94 1 92 0 0 95 2 7 43 0 0
                                    96 2 25 0 97 0 98 2 25 15 7 0 99 2 92 2 0
                                    15 100 1 8 43 0 104 1 10 0 0 105 1 92 17 0
                                    106 2 108 107 101 10 109 1 34 10 107 110 0
                                    10 0 112 2 9 0 8 0 113 2 10 0 8 0 114 1 10
                                    0 115 116 2 8 0 0 7 118 2 34 10 120 10 121
                                    2 0 0 0 120 122 2 8 0 120 0 123 2 31 10 28
                                    10 124 2 0 0 120 0 125 2 8 0 0 120 126 2 0
                                    0 0 120 127 1 128 10 10 129 1 0 0 0 130 1
                                    128 10 10 131 1 0 0 0 132 1 128 10 10 133 1
                                    0 0 0 134 1 128 10 10 135 1 0 0 0 136 1 128
                                    10 10 137 1 0 0 0 138 1 128 10 10 139 1 0 0
                                    0 140 1 128 10 10 141 1 0 0 0 142 1 128 10
                                    10 143 1 0 0 0 144 1 128 10 10 145 1 0 0 0
                                    146 1 128 10 10 147 1 0 0 0 148 1 128 10 10
                                    149 1 0 0 0 150 1 128 10 10 151 1 0 0 0 152
                                    1 128 10 10 153 1 0 0 0 154 1 128 10 10 155
                                    1 0 0 0 156 1 128 10 10 157 1 0 0 0 158 1
                                    128 10 10 159 1 0 0 0 160 1 128 10 10 161 1
                                    0 0 0 162 1 128 10 10 163 1 0 0 0 164 1 128
                                    10 10 165 1 0 0 0 166 1 128 10 10 167 1 0 0
                                    0 168 1 128 10 10 169 1 0 0 0 170 1 128 10
                                    10 171 1 0 0 0 172 1 128 10 10 173 1 0 0 0
                                    174 1 128 10 10 175 1 0 0 0 176 1 128 10 10
                                    177 1 0 0 0 178 1 128 10 10 179 1 0 0 0 180
                                    1 120 0 15 181 1 120 0 0 182 1 9 0 115 183
                                    3 0 0 115 7 6 184 3 0 0 0 7 6 185 2 0 0 0 7
                                    186 1 8 187 0 188 1 8 43 0 189 1 187 0 0
                                    190 2 8 43 0 0 191 1 9 43 0 192 2 9 43 0 0
                                    193 1 9 43 0 194 2 8 43 0 0 195 1 196 187 0
                                    197 1 17 187 0 198 2 187 0 0 26 199 2 187 0
                                    0 0 200 2 202 187 201 0 203 2 8 0 0 6 205 2
                                    0 0 0 6 206 2 0 43 0 0 1 1 0 43 0 1 1 10
                                    208 0 1 1 10 0 0 1 1 10 43 0 1 1 1 0 0 162
                                    1 1 0 0 138 2 0 207 0 0 1 1 1 0 0 1 1 1 0 0
                                    158 1 1 0 0 134 1 0 0 10 12 1 1 0 0 166 1 1
                                    0 0 142 0 0 0 1 1 0 207 0 1 2 0 0 0 17 1 2
                                    0 0 0 215 1 1 8 0 0 1 1 0 207 0 1 2 0 211 0
                                    17 1 3 0 211 0 17 17 1 1 0 43 0 1 0 1 0 1 2
                                    0 17 0 7 1 3 0 17 0 7 17 1 2 0 43 0 0 1 1 0
                                    43 0 1 2 1 0 0 15 1 1 0 43 0 1 3 0 0 0 7 17
                                    76 3 0 0 0 25 49 87 2 0 0 6 57 90 2 0 0 214
                                    0 1 1 1 0 0 132 1 0 207 0 1 2 0 0 0 17 1 2
                                    0 0 0 215 1 1 8 209 0 1 1 8 57 0 1 1 0 0 0
                                    1 1 0 6 0 1 1 0 217 0 1 3 1 0 0 7 6 185 2 1
                                    0 0 7 186 2 0 216 216 0 1 1 0 218 0 1 3 1 0
                                    115 7 6 184 2 0 0 0 17 18 2 10 207 0 0 1 1
                                    1 0 0 130 3 0 0 0 26 26 1 2 0 0 0 212 1 3 0
                                    0 0 0 0 1 3 0 0 0 25 26 111 2 0 0 0 213 1 3
                                    0 0 0 7 0 117 3 0 0 0 25 49 1 2 0 0 0 25 1
                                    3 0 0 0 7 17 1 2 0 0 0 7 119 1 0 57 0 1 2 0
                                    101 25 102 103 1 1 0 0 168 1 1 0 0 144 1 1
                                    0 0 164 1 1 0 0 140 1 1 0 0 160 1 1 0 0 136
                                    1 8 0 210 1 1 0 0 210 1 1 0 0 0 20 2 0 0 0
                                    0 1 1 9 0 6 64 1 11 0 0 1 1 1 0 120 1 1 0 0
                                    8 81 1 0 0 7 83 1 0 0 15 1 1 0 187 0 204 1
                                    0 10 0 11 2 0 8 0 17 48 3 0 0 0 25 49 56 3
                                    0 0 0 7 17 1 2 0 6 0 57 62 1 3 207 0 1 0 0
                                    17 1 1 1 0 0 174 1 1 0 0 150 3 0 0 0 0 0 1
                                    2 10 43 0 0 1 1 1 0 0 170 1 1 0 0 146 1 1 0
                                    0 178 1 1 0 0 154 2 0 0 0 0 1 2 0 43 0 0 1
                                    1 1 0 0 180 1 1 0 0 156 1 1 0 0 176 1 1 0 0
                                    152 1 1 0 0 172 1 1 0 0 148 2 1 0 0 120 122
                                    2 1 0 0 0 1 2 0 0 0 17 94 2 0 0 0 215 1 0 0
                                    0 21 0 0 0 13 3 0 0 0 25 49 1 2 0 0 0 25 1
                                    3 0 0 0 7 17 1 2 0 0 0 7 1 2 0 43 0 0 1 2 7
                                    0 0 6 206 2 0 0 0 0 1 1 0 0 0 1 2 0 0 0 0
                                    79 2 1 0 120 0 125 2 1 0 0 120 127 2 0 0 8
                                    0 66 2 0 0 0 6 68 2 0 0 6 0 67 2 0 0 17 0 1
                                    2 0 0 15 0 1 2 0 0 0 0 78 2 0 0 215 0
                                    1)))))
           '|lookupComplete|)) 
