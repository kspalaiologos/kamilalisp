
(PUT '|ULSCONS;getExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |ULSCONS;getExpon| ((|x| ($)) ($ (|Integer|))) (QCAR |x|)) 

(PUT '|ULSCONS;getUTS| '|SPADreplace| 'QCDR) 

(SDEFUN |ULSCONS;getUTS| ((|x| ($)) ($ (UTS))) (QCDR |x|)) 

(PUT '|ULSCONS;laurent;IUTS$;3| '|SPADreplace| 'CONS) 

(SDEFUN |ULSCONS;laurent;IUTS$;3| ((|n| (|Integer|)) (|psr| (UTS)) ($ ($)))
        (CONS |n| |psr|)) 

(SDEFUN |ULSCONS;taylorRep;$UTS;4| ((|x| ($)) ($ (UTS)))
        (|ULSCONS;getUTS| |x| $)) 

(SDEFUN |ULSCONS;degree;$I;5| ((|x| ($)) ($ (|Integer|)))
        (|ULSCONS;getExpon| |x| $)) 

(SDEFUN |ULSCONS;Zero;$;6| (($ ($)))
        (SPADCALL 0 (|spadConstant| $ 15) (QREFELT $ 10))) 

(SDEFUN |ULSCONS;One;$;7| (($ ($)))
        (SPADCALL 0 (|spadConstant| $ 17) (QREFELT $ 10))) 

(SDEFUN |ULSCONS;monomial;CoefI$;8| ((|s| (|Coef|)) (|e| (|Integer|)) ($ ($)))
        (SPADCALL |e| (SPADCALL |s| (QREFELT $ 18)) (QREFELT $ 10))) 

(SDEFUN |ULSCONS;coerce;UTS$;9| ((|uts| (UTS)) ($ ($)))
        (SPADCALL 0 |uts| (QREFELT $ 10))) 

(SDEFUN |ULSCONS;coerce;Coef$;10| ((|r| (|Coef|)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 18)) (QREFELT $ 20))) 

(SDEFUN |ULSCONS;coerce;I$;11| ((|i| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 22)) (QREFELT $ 21))) 

(SDEFUN |ULSCONS;taylorIfCan;$U;12| ((|uls| ($)) ($ (|Union| UTS "failed")))
        (SPROG ((#1=#:G757 NIL) (|n| (|Integer|)))
               (SEQ (LETT |n| (|ULSCONS;getExpon| |uls| $))
                    (EXIT
                     (COND
                      ((< |n| 0)
                       (SEQ
                        (LETT |uls| (SPADCALL (- |n|) |uls| (QREFELT $ 24)))
                        (EXIT
                         (COND
                          ((< (|ULSCONS;getExpon| |uls| $) 0)
                           (CONS 1 "failed"))
                          (#2='T (CONS 0 (|ULSCONS;getUTS| |uls| $)))))))
                      ((EQL |n| 0) (CONS 0 (|ULSCONS;getUTS| |uls| $)))
                      (#2#
                       (CONS 0
                             (SPADCALL (|ULSCONS;getUTS| |uls| $)
                                       (SPADCALL (|spadConstant| $ 25)
                                                 (PROG1 (LETT #1# |n|)
                                                   (|check_subtype2| (>= #1# 0)
                                                                     '(|NonNegativeInteger|)
                                                                     '(|Integer|)
                                                                     #1#))
                                                 (QREFELT $ 27))
                                       (QREFELT $ 28))))))))) 

(SDEFUN |ULSCONS;taylor;$UTS;13| ((|uls| ($)) ($ (UTS)))
        (SPROG ((|uts| (|Union| UTS "failed")))
               (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 30)))
                    (EXIT
                     (COND
                      ((QEQCAR |uts| 1)
                       (|error| "taylor: Laurent series has a pole"))
                      ('T (QCDR |uts|))))))) 

(PUT '|ULSCONS;termExpon| '|SPADreplace| 'QCAR) 

(SDEFUN |ULSCONS;termExpon|
        ((|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
         ($ (|Integer|)))
        (QCAR |term|)) 

(PUT '|ULSCONS;termCoef| '|SPADreplace| 'QCDR) 

(SDEFUN |ULSCONS;termCoef|
        ((|term| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))
         ($ (|Coef|)))
        (QCDR |term|)) 

(PUT '|ULSCONS;rec| '|SPADreplace| 'CONS) 

(SDEFUN |ULSCONS;rec|
        ((|exponent| (|Integer|)) (|coef| (|Coef|))
         ($ (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
        (CONS |exponent| |coef|)) 

(SDEFUN |ULSCONS;recs|
        ((|st| (|Stream| |Coef|)) (|n| (|Integer|))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (SPROG NIL
               (SPADCALL (CONS #'|ULSCONS;recs!0| (VECTOR |n| $ |st|))
                         (QREFELT $ 45)))) 

(SDEFUN |ULSCONS;recs!0| (($$ NIL))
        (PROG (|st| $ |n|)
          (LETT |st| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|coef| NIL))
                   (COND
                    ((SPADCALL |st| (QREFELT $ 34)) (SPADCALL (QREFELT $ 37)))
                    ((SPADCALL (LETT |coef| (SPADCALL |st| (QREFELT $ 38)))
                               (QREFELT $ 39))
                     (|ULSCONS;recs| (SPADCALL |st| (QREFELT $ 40))
                      (SPADCALL |n| (|spadConstant| $ 41) (QREFELT $ 42)) $))
                    ('T
                     (SPADCALL (|ULSCONS;rec| |n| |coef| $)
                               (|ULSCONS;recs| (SPADCALL |st| (QREFELT $ 40))
                                (SPADCALL |n| (|spadConstant| $ 41)
                                          (QREFELT $ 42))
                                $)
                               (QREFELT $ 43))))))))) 

(SDEFUN |ULSCONS;terms;$S;18|
        ((|x| ($))
         ($ (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|)))))
        (|ULSCONS;recs| (SPADCALL (|ULSCONS;getUTS| |x| $) (QREFELT $ 46))
         (|ULSCONS;getExpon| |x| $) $)) 

(SDEFUN |ULSCONS;recsToCoefs|
        ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         (|n| (|Integer|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|ULSCONS;recsToCoefs!0| (VECTOR |n| $ |st|))
                          (QREFELT $ 54))))) 

(SDEFUN |ULSCONS;recsToCoefs!0| (($$ NIL))
        (PROG (|st| $ |n|)
          (LETT |st| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|term| NIL) (|ex| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |st| (QREFELT $ 48)) (SPADCALL (QREFELT $ 49)))
                     ('T
                      (SEQ (LETT |term| (SPADCALL |st| (QREFELT $ 50)))
                           (LETT |ex| (|ULSCONS;termExpon| |term| $))
                           (EXIT
                            (COND
                             ((SPADCALL |n| |ex| (QREFELT $ 51))
                              (SPADCALL (|ULSCONS;termCoef| |term| $)
                                        (|ULSCONS;recsToCoefs|
                                         (SPADCALL |st| (QREFELT $ 52))
                                         (SPADCALL |n| (|spadConstant| $ 41)
                                                   (QREFELT $ 42))
                                         $)
                                        (QREFELT $ 53)))
                             ('T
                              (SPADCALL (|spadConstant| $ 14)
                                        (|ULSCONS;recsToCoefs| |st|
                                         (SPADCALL |n| (|spadConstant| $ 41)
                                                   (QREFELT $ 42))
                                         $)
                                        (QREFELT $ 53)))))))))))))) 

(SDEFUN |ULSCONS;series;S$;20|
        ((|st| (|Stream| (|Record| (|:| |k| (|Integer|)) (|:| |c| |Coef|))))
         ($ ($)))
        (SPROG ((|ex| (|Integer|)))
               (SEQ
                (COND ((SPADCALL |st| (QREFELT $ 48)) (|spadConstant| $ 13))
                      ('T
                       (SEQ
                        (LETT |ex|
                              (|ULSCONS;termExpon|
                               (SPADCALL |st| (QREFELT $ 50)) $))
                        (EXIT
                         (SPADCALL |ex|
                                   (SPADCALL
                                    (|ULSCONS;recsToCoefs| |st| |ex| $)
                                    (QREFELT $ 55))
                                   (QREFELT $ 10))))))))) 

(SDEFUN |ULSCONS;removeZeroes;2$;21| ((|x| ($)) ($ ($)))
        (SPROG ((|xUTS| (UTS)))
               (COND
                ((SPADCALL
                  (SPADCALL (LETT |xUTS| (|ULSCONS;getUTS| |x| $))
                            (QREFELT $ 46))
                  (QREFELT $ 34))
                 (|spadConstant| $ 13))
                ((SPADCALL (SPADCALL |xUTS| 0 (QREFELT $ 57))
                           (|spadConstant| $ 14) (QREFELT $ 58))
                 (SPADCALL
                  (SPADCALL (+ (|ULSCONS;getExpon| |x| $) 1)
                            (SPADCALL |xUTS| (QREFELT $ 59)) (QREFELT $ 10))
                  (QREFELT $ 60)))
                ('T |x|)))) 

(SDEFUN |ULSCONS;removeZeroes;I2$;22| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG ((|xUTS| (UTS)))
               (COND ((<= |n| 0) |x|)
                     ((SPADCALL
                       (SPADCALL (LETT |xUTS| (|ULSCONS;getUTS| |x| $))
                                 (QREFELT $ 46))
                       (QREFELT $ 34))
                      (|spadConstant| $ 13))
                     ((SPADCALL (SPADCALL |xUTS| 0 (QREFELT $ 57))
                                (|spadConstant| $ 14) (QREFELT $ 58))
                      (SPADCALL (- |n| 1)
                                (SPADCALL (+ (|ULSCONS;getExpon| |x| $) 1)
                                          (SPADCALL |xUTS| (QREFELT $ 59))
                                          (QREFELT $ 10))
                                (QREFELT $ 24)))
                     ('T |x|)))) 

(SDEFUN |ULSCONS;=;2$B;23| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G829 NIL) (#2=#:G820 NIL) (|expDiff| (|Integer|)))
               (SEQ
                (COND ((EQ |x| |y|) 'T)
                      (#3='T
                       (SEQ
                        (LETT |expDiff|
                              (- (|ULSCONS;getExpon| |x| $)
                                 (|ULSCONS;getExpon| |y| $)))
                        (EXIT
                         (COND
                          ((EQL |expDiff| 0)
                           (SPADCALL (|ULSCONS;getUTS| |x| $)
                                     (|ULSCONS;getUTS| |y| $) (QREFELT $ 61)))
                          ((> (ABS |expDiff|) |$streamCount|) NIL)
                          ((> |expDiff| 0)
                           (SPADCALL
                            (SPADCALL (|ULSCONS;getUTS| |x| $)
                                      (SPADCALL (|spadConstant| $ 25)
                                                (PROG1 (LETT #2# |expDiff|)
                                                  (|check_subtype2| (>= #2# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #2#))
                                                (QREFELT $ 27))
                                      (QREFELT $ 28))
                            (|ULSCONS;getUTS| |y| $) (QREFELT $ 61)))
                          (#3#
                           (SPADCALL
                            (SPADCALL (|ULSCONS;getUTS| |y| $)
                                      (SPADCALL (|spadConstant| $ 25)
                                                (PROG1 (LETT #1# (- |expDiff|))
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 27))
                                      (QREFELT $ 28))
                            (|ULSCONS;getUTS| |x| $) (QREFELT $ 61))))))))))) 

(SDEFUN |ULSCONS;pole?;$B;24| ((|x| ($)) ($ (|Boolean|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |x| (QREFELT $ 12)))
                    (EXIT
                     (COND ((>= |n| 0) NIL)
                           ('T
                            (SEQ
                             (LETT |x| (SPADCALL (- |n|) |x| (QREFELT $ 24)))
                             (EXIT (< (SPADCALL |x| (QREFELT $ 12)) 0))))))))) 

(SDEFUN |ULSCONS;+;3$;25| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G846 NIL) (#2=#:G842 NIL) (|n| (|Integer|)))
               (SEQ
                (LETT |n|
                      (- (|ULSCONS;getExpon| |x| $)
                         (|ULSCONS;getExpon| |y| $)))
                (EXIT
                 (COND
                  ((>= |n| 0)
                   (SPADCALL (|ULSCONS;getExpon| |y| $)
                             (SPADCALL (|ULSCONS;getUTS| |y| $)
                                       (SPADCALL (|ULSCONS;getUTS| |x| $)
                                                 (SPADCALL
                                                  (|spadConstant| $ 25)
                                                  (PROG1 (LETT #2# |n|)
                                                    (|check_subtype2|
                                                     (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#))
                                                  (QREFELT $ 27))
                                                 (QREFELT $ 28))
                                       (QREFELT $ 64))
                             (QREFELT $ 10)))
                  ('T
                   (SPADCALL (|ULSCONS;getExpon| |x| $)
                             (SPADCALL (|ULSCONS;getUTS| |x| $)
                                       (SPADCALL (|ULSCONS;getUTS| |y| $)
                                                 (SPADCALL
                                                  (|spadConstant| $ 25)
                                                  (PROG1 (LETT #1# (- |n|))
                                                    (|check_subtype2|
                                                     (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                                  (QREFELT $ 27))
                                                 (QREFELT $ 28))
                                       (QREFELT $ 64))
                             (QREFELT $ 10)))))))) 

(SDEFUN |ULSCONS;-;3$;26| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G857 NIL) (#2=#:G853 NIL) (|n| (|Integer|)))
               (SEQ
                (LETT |n|
                      (- (|ULSCONS;getExpon| |x| $)
                         (|ULSCONS;getExpon| |y| $)))
                (EXIT
                 (COND
                  ((>= |n| 0)
                   (SPADCALL (|ULSCONS;getExpon| |y| $)
                             (SPADCALL
                              (SPADCALL (|ULSCONS;getUTS| |x| $)
                                        (SPADCALL (|spadConstant| $ 25)
                                                  (PROG1 (LETT #2# |n|)
                                                    (|check_subtype2|
                                                     (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#))
                                                  (QREFELT $ 27))
                                        (QREFELT $ 28))
                              (|ULSCONS;getUTS| |y| $) (QREFELT $ 66))
                             (QREFELT $ 10)))
                  ('T
                   (SPADCALL (|ULSCONS;getExpon| |x| $)
                             (SPADCALL (|ULSCONS;getUTS| |x| $)
                                       (SPADCALL (|ULSCONS;getUTS| |y| $)
                                                 (SPADCALL
                                                  (|spadConstant| $ 25)
                                                  (PROG1 (LETT #1# (- |n|))
                                                    (|check_subtype2|
                                                     (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                                  (QREFELT $ 27))
                                                 (QREFELT $ 28))
                                       (QREFELT $ 66))
                             (QREFELT $ 10)))))))) 

(SDEFUN |ULSCONS;*;3$;27| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL (+ (|ULSCONS;getExpon| |x| $) (|ULSCONS;getExpon| |y| $))
                  (SPADCALL (|ULSCONS;getUTS| |x| $) (|ULSCONS;getUTS| |y| $)
                            (QREFELT $ 28))
                  (QREFELT $ 10))) 

(SDEFUN |ULSCONS;^;$Nni$;28| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (COND ((ZEROP |n|) (|spadConstant| $ 16))
              ('T
               (SPADCALL (* |n| (|ULSCONS;getExpon| |x| $))
                         (SPADCALL (|ULSCONS;getUTS| |x| $) |n| (QREFELT $ 69))
                         (QREFELT $ 10))))) 

(SDEFUN |ULSCONS;recip;$U;29| ((|x| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|uts| (|Union| UTS #1#)) (|d| (|Integer|)))
               (SEQ (LETT |x| (SPADCALL 1000 |x| (QREFELT $ 24)))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (SPADCALL |x| (LETT |d| (SPADCALL |x| (QREFELT $ 12)))
                                  (QREFELT $ 71))
                        (QREFELT $ 39))
                       (CONS 1 "failed"))
                      (#2='T
                       (SEQ
                        (LETT |uts|
                              (SPADCALL (|ULSCONS;getUTS| |x| $)
                                        (QREFELT $ 73)))
                        (EXIT
                         (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                               (#2#
                                (CONS 0
                                      (SPADCALL (- |d|) (QCDR |uts|)
                                                (QREFELT $ 10))))))))))))) 

(SDEFUN |ULSCONS;elt;3$;30| ((|uls1| ($)) (|uls2| ($)) ($ ($)))
        (SPROG
         ((#1=#:G887 NIL) (|uts1| (UTS)) (|recipr| (|Union| $ "failed"))
          (|deg| (|Integer|)) (|uts2| (UTS)) (|uts| (|Union| UTS "failed")))
         (SEQ (LETT |uts| (SPADCALL |uls2| (QREFELT $ 30)))
              (EXIT
               (COND
                ((QEQCAR |uts| 1)
                 (|error| "elt: second argument must have positive order"))
                (#2='T
                 (SEQ (LETT |uts2| (QCDR |uts|))
                      (COND
                       ((NULL
                         (SPADCALL (SPADCALL |uts2| 0 (QREFELT $ 57))
                                   (QREFELT $ 39)))
                        (EXIT
                         (|error|
                          "elt: second argument must have positive order"))))
                      (SEQ (LETT |deg| (|ULSCONS;getExpon| |uls1| $))
                           (EXIT
                            (COND
                             ((< |deg| 0)
                              (LETT |uls1|
                                    (SPADCALL (- |deg|) |uls1|
                                              (QREFELT $ 24)))))))
                      (LETT |deg| (|ULSCONS;getExpon| |uls1| $))
                      (EXIT
                       (COND
                        ((< |deg| 0)
                         (SEQ
                          (LETT |recipr|
                                (SPADCALL (SPADCALL |uts2| (QREFELT $ 20))
                                          (QREFELT $ 74)))
                          (EXIT
                           (COND
                            ((QEQCAR |recipr| 1)
                             (|error| "elt: second argument not invertible"))
                            (#2#
                             (SEQ
                              (LETT |uts1|
                                    (SPADCALL
                                     (SPADCALL |uls1|
                                               (SPADCALL (|spadConstant| $ 25)
                                                         (- |deg|)
                                                         (QREFELT $ 19))
                                               (QREFELT $ 68))
                                     (QREFELT $ 31)))
                              (EXIT
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |uts1| |uts2| (QREFELT $ 75))
                                 (QREFELT $ 20))
                                (SPADCALL (QCDR |recipr|)
                                          (PROG1 (LETT #1# (- |deg|))
                                            (|check_subtype2| (>= #1# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #1#))
                                          (QREFELT $ 70))
                                (QREFELT $ 68)))))))))
                        (#2#
                         (SPADCALL
                          (SPADCALL (SPADCALL |uls1| (QREFELT $ 31)) |uts2|
                                    (QREFELT $ 75))
                          (QREFELT $ 20)))))))))))) 

(SDEFUN |ULSCONS;eval;$CoefS;31|
        ((|uls| ($)) (|r| (|Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((#1=#:G906 NIL) (#2=#:G899 NIL) (|recipr| (|Union| |Coef| "failed"))
          (|n| (|Integer|)) (|uts| (UTS)))
         (SEQ
          (SEQ (LETT |n| (|ULSCONS;getExpon| |uls| $))
               (EXIT
                (COND
                 ((< |n| 0)
                  (LETT |uls| (SPADCALL (- |n|) |uls| (QREFELT $ 24)))))))
          (LETT |uts| (|ULSCONS;getUTS| |uls| $))
          (LETT |n| (|ULSCONS;getExpon| |uls| $))
          (EXIT
           (COND
            ((< |n| 0)
             (COND
              ((SPADCALL |r| (QREFELT $ 39))
               (|error| "eval: 0 raised to negative power"))
              (#3='T
               (SEQ (LETT |recipr| (SPADCALL |r| (QREFELT $ 77)))
                    (EXIT
                     (COND
                      ((QEQCAR |recipr| 1)
                       (|error| "eval: non-unit raised to negative power"))
                      (#3#
                       (SPADCALL
                        (SPADCALL (QCDR |recipr|)
                                  (PROG1 (LETT #2# (- |n|))
                                    (|check_subtype2| (>= #2# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #2#))
                                  (QREFELT $ 78))
                        (SPADCALL |uts| |r| (QREFELT $ 79))
                        (QREFELT $ 81)))))))))
            ((ZEROP |n|) (SPADCALL |uts| |r| (QREFELT $ 79)))
            (#3#
             (SPADCALL
              (SPADCALL |r|
                        (PROG1 (LETT #1# |n|)
                          (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #1#))
                        (QREFELT $ 78))
              (SPADCALL |uts| |r| (QREFELT $ 79)) (QREFELT $ 81)))))))) 

(SDEFUN |ULSCONS;variable;$S;32| ((|x| ($)) ($ (|Symbol|)))
        (SPADCALL (|ULSCONS;getUTS| |x| $) (QREFELT $ 84))) 

(SDEFUN |ULSCONS;center;$Coef;33| ((|x| ($)) ($ (|Coef|)))
        (SPADCALL (|ULSCONS;getUTS| |x| $) (QREFELT $ 86))) 

(SDEFUN |ULSCONS;coefficient;$ICoef;34|
        ((|x| ($)) (|n| (|Integer|)) ($ (|Coef|)))
        (SPROG ((#1=#:G915 NIL) (|a| (|Integer|)))
               (SEQ (LETT |a| (- |n| (|ULSCONS;getExpon| |x| $)))
                    (EXIT
                     (COND
                      ((>= |a| 0)
                       (SPADCALL (|ULSCONS;getUTS| |x| $)
                                 (PROG1 (LETT #1# |a|)
                                   (|check_subtype2| (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                 (QREFELT $ 57)))
                      ('T (|spadConstant| $ 14))))))) 

(SDEFUN |ULSCONS;elt;$ICoef;35| ((|x| ($)) (|n| (|Integer|)) ($ (|Coef|)))
        (SPADCALL |x| |n| (QREFELT $ 71))) 

(SDEFUN |ULSCONS;order;$I;36| ((|x| ($)) ($ (|Integer|)))
        (+ (|ULSCONS;getExpon| |x| $)
           (SPADCALL (|ULSCONS;getUTS| |x| $) (QREFELT $ 89)))) 

(SDEFUN |ULSCONS;order;$2I;37| ((|x| ($)) (|n| #1=(|Integer|)) ($ #1#))
        (SPROG ((#2=#:G922 NIL) (|m| (|Integer|)) (|e| (|Integer|)))
               (SEQ (LETT |m| (- |n| (LETT |e| (|ULSCONS;getExpon| |x| $))))
                    (EXIT
                     (COND ((< |m| 0) |n|)
                           ('T
                            (+ |e|
                               (SPADCALL (|ULSCONS;getUTS| |x| $)
                                         (PROG1 (LETT #2# |m|)
                                           (|check_subtype2| (>= #2# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #2#))
                                         (QREFELT $ 91))))))))) 

(SDEFUN |ULSCONS;truncate;$I$;38| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G926 NIL) (|m| (|Integer|)) (|e| (|Integer|)))
               (SEQ (LETT |m| (- |n| (LETT |e| (|ULSCONS;getExpon| |x| $))))
                    (EXIT
                     (COND ((< |m| 0) (|spadConstant| $ 13))
                           ('T
                            (SPADCALL |e|
                                      (SPADCALL (|ULSCONS;getUTS| |x| $)
                                                (PROG1 (LETT #1# |m|)
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 93))
                                      (QREFELT $ 10)))))))) 

(SDEFUN |ULSCONS;truncate;$2I$;39|
        ((|x| ($)) (|n1| #1=(|Integer|)) (|n2| #1#) ($ ($)))
        (SPROG
         ((#2=#:G932 NIL) (#3=#:G931 NIL) (|m1| (|Integer|)) (|e| (|Integer|))
          (|#G61| #1#) (|#G60| #1#))
         (SEQ
          (COND
           ((< |n2| |n1|)
            (PROGN
             (LETT |#G60| |n2|)
             (LETT |#G61| |n1|)
             (LETT |n1| |#G60|)
             (LETT |n2| |#G61|))))
          (LETT |m1| (- |n1| (LETT |e| (|ULSCONS;getExpon| |x| $))))
          (EXIT
           (COND ((< |m1| 0) (SPADCALL |x| |n2| (QREFELT $ 94)))
                 ('T
                  (SPADCALL |e|
                            (SPADCALL (|ULSCONS;getUTS| |x| $)
                                      (PROG1 (LETT #3# |m1|)
                                        (|check_subtype2| (>= #3# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #3#))
                                      (PROG1 (LETT #2# (- |n2| |e|))
                                        (|check_subtype2| (>= #2# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #2#))
                                      (QREFELT $ 95))
                            (QREFELT $ 10)))))))) 

(SDEFUN |ULSCONS;rationalFunction;$IF;40|
        ((|x| ($)) (|n| (|Integer|)) ($ (|Fraction| (|Polynomial| |Coef|))))
        (SPROG
         ((#1=#:G943 NIL) (#2=#:G942 NIL)
          (|c| (|Fraction| (|Polynomial| |Coef|)))
          (|v| (|Fraction| (|Polynomial| |Coef|)))
          (|poly| (|Fraction| (|Polynomial| |Coef|))) (#3=#:G939 NIL)
          (|m| (|Integer|)) (|e| (|Integer|)))
         (SEQ (LETT |m| (- |n| (LETT |e| (|ULSCONS;getExpon| |x| $))))
              (EXIT
               (COND ((< |m| 0) (|spadConstant| $ 98))
                     (#4='T
                      (SEQ
                       (LETT |poly|
                             (SPADCALL
                              (SPADCALL (|ULSCONS;getUTS| |x| $)
                                        (PROG1 (LETT #3# |m|)
                                          (|check_subtype2| (>= #3# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #3#))
                                        (QREFELT $ 100))
                              (QREFELT $ 101)))
                       (EXIT
                        (COND ((ZEROP |e|) |poly|)
                              (#4#
                               (SEQ
                                (LETT |v|
                                      (SPADCALL (SPADCALL |x| (QREFELT $ 85))
                                                (QREFELT $ 102)))
                                (LETT |c|
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |x| (QREFELT $ 87))
                                                 (QREFELT $ 103))
                                       (QREFELT $ 101)))
                                (EXIT
                                 (COND
                                  ((PLUSP |e|)
                                   (SPADCALL |poly|
                                             (SPADCALL
                                              (SPADCALL |v| |c|
                                                        (QREFELT $ 104))
                                              (PROG1 (LETT #2# |e|)
                                                (|check_subtype2| (>= #2# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #2#))
                                              (QREFELT $ 105))
                                             (QREFELT $ 106)))
                                  (#4#
                                   (SPADCALL |poly|
                                             (SPADCALL
                                              (SPADCALL |v| |c|
                                                        (QREFELT $ 104))
                                              (PROG1 (LETT #1# (- |e|))
                                                (|check_subtype2| (>= #1# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #1#))
                                              (QREFELT $ 105))
                                             (QREFELT $ 107)))))))))))))))) 

(SDEFUN |ULSCONS;rationalFunction;$2IF;41|
        ((|x| ($)) (|n1| #1=(|Integer|)) (|n2| #1#)
         ($ (|Fraction| (|Polynomial| |Coef|))))
        (SPROG
         ((#2=#:G955 NIL) (#3=#:G954 NIL)
          (|c| (|Fraction| (|Polynomial| |Coef|)))
          (|v| (|Fraction| (|Polynomial| |Coef|)))
          (|poly| (|Fraction| (|Polynomial| |Coef|))) (#4=#:G951 NIL)
          (#5=#:G950 NIL) (|m1| (|Integer|)) (|e| (|Integer|)) (|#G68| #1#)
          (|#G67| #1#))
         (SEQ
          (COND
           ((< |n2| |n1|)
            (PROGN
             (LETT |#G67| |n2|)
             (LETT |#G68| |n1|)
             (LETT |n1| |#G67|)
             (LETT |n2| |#G68|))))
          (LETT |m1| (- |n1| (LETT |e| (|ULSCONS;getExpon| |x| $))))
          (EXIT
           (COND ((< |m1| 0) (SPADCALL |x| |n2| (QREFELT $ 108)))
                 (#6='T
                  (SEQ
                   (LETT |poly|
                         (SPADCALL
                          (SPADCALL (|ULSCONS;getUTS| |x| $)
                                    (PROG1 (LETT #5# |m1|)
                                      (|check_subtype2| (>= #5# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #5#))
                                    (PROG1 (LETT #4# (- |n2| |e|))
                                      (|check_subtype2| (>= #4# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #4#))
                                    (QREFELT $ 109))
                          (QREFELT $ 101)))
                   (EXIT
                    (COND ((ZEROP |e|) |poly|)
                          (#6#
                           (SEQ
                            (LETT |v|
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 85))
                                            (QREFELT $ 102)))
                            (LETT |c|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |x| (QREFELT $ 87))
                                             (QREFELT $ 103))
                                   (QREFELT $ 101)))
                            (EXIT
                             (COND
                              ((PLUSP |e|)
                               (SPADCALL |poly|
                                         (SPADCALL
                                          (SPADCALL |v| |c| (QREFELT $ 104))
                                          (PROG1 (LETT #3# |e|)
                                            (|check_subtype2| (>= #3# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #3#))
                                          (QREFELT $ 105))
                                         (QREFELT $ 106)))
                              (#6#
                               (SPADCALL |poly|
                                         (SPADCALL
                                          (SPADCALL |v| |c| (QREFELT $ 104))
                                          (PROG1 (LETT #2# (- |e|))
                                            (|check_subtype2| (>= #2# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #2#))
                                          (QREFELT $ 105))
                                         (QREFELT $ 107)))))))))))))))) 

(SDEFUN |ULSCONS;exquo;2$U;42|
        ((|x| ($)) (|y| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|uts| (|Union| UTS #1#)) (|d| (|Integer|)))
               (SEQ (LETT |x| (SPADCALL 1000 |x| (QREFELT $ 24)))
                    (LETT |y| (SPADCALL 1000 |y| (QREFELT $ 24)))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (SPADCALL |y| (LETT |d| (SPADCALL |y| (QREFELT $ 12)))
                                  (QREFELT $ 71))
                        (QREFELT $ 39))
                       (CONS 1 "failed"))
                      (#2='T
                       (SEQ
                        (LETT |uts|
                              (SPADCALL (|ULSCONS;getUTS| |x| $)
                                        (|ULSCONS;getUTS| |y| $)
                                        (QREFELT $ 111)))
                        (EXIT
                         (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                               (#2#
                                (CONS 0
                                      (SPADCALL
                                       (- (SPADCALL |x| (QREFELT $ 12)) |d|)
                                       (QCDR |uts|) (QREFELT $ 10))))))))))))) 

(SDEFUN |ULSCONS;approximate;$ICoef;43|
        ((|x| ($)) (|n| (|Integer|)) ($ (|Coef|)))
        (SPROG
         ((|app| (|Coef|)) (#1=#:G971 NIL) (|m| (|Integer|)) (|e| (|Integer|)))
         (SEQ (LETT |m| (- |n| (LETT |e| (|ULSCONS;getExpon| |x| $))))
              (EXIT
               (COND ((< |m| 0) (|spadConstant| $ 14))
                     (#2='T
                      (SEQ
                       (LETT |app|
                             (SPADCALL (|ULSCONS;getUTS| |x| $)
                                       (PROG1 (LETT #1# |m|)
                                         (|check_subtype2| (>= #1# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #1#))
                                       (QREFELT $ 113)))
                       (EXIT
                        (COND ((ZEROP |e|) |app|)
                              (#2#
                               (SPADCALL |app|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |x| (QREFELT $ 85))
                                            (QREFELT $ 114))
                                           (SPADCALL |x| (QREFELT $ 87))
                                           (QREFELT $ 115))
                                          |e| (QREFELT $ 116))
                                         (QREFELT $ 117)))))))))))) 

(SDEFUN |ULSCONS;complete;2$;44| ((|x| ($)) ($ ($)))
        (SPADCALL (|ULSCONS;getExpon| |x| $)
                  (SPADCALL (|ULSCONS;getUTS| |x| $) (QREFELT $ 119))
                  (QREFELT $ 10))) 

(SDEFUN |ULSCONS;extend;$I$;45| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G977 NIL) (|m| (|Integer|)) (|e| (|Integer|)))
               (SEQ (LETT |e| (|ULSCONS;getExpon| |x| $))
                    (LETT |m| (- |n| |e|))
                    (EXIT
                     (COND ((< |m| 0) |x|)
                           ('T
                            (SPADCALL |e|
                                      (SPADCALL (|ULSCONS;getUTS| |x| $)
                                                (PROG1 (LETT #1# |m|)
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 121))
                                      (QREFELT $ 10)))))))) 

(SDEFUN |ULSCONS;map;M2$;46|
        ((|f| (|Mapping| |Coef| |Coef|)) (|x| ($)) ($ ($)))
        (SPADCALL (|ULSCONS;getExpon| |x| $)
                  (SPADCALL |f| (|ULSCONS;getUTS| |x| $) (QREFELT $ 124))
                  (QREFELT $ 10))) 

(SDEFUN |ULSCONS;multiplyCoefficients;M2$;47|
        ((|f| (|Mapping| |Coef| (|Integer|))) (|x| ($)) ($ ($)))
        (SPROG ((|e| (|Integer|)))
               (SEQ (LETT |e| (|ULSCONS;getExpon| |x| $))
                    (EXIT
                     (SPADCALL |e|
                               (SPADCALL
                                (CONS #'|ULSCONS;multiplyCoefficients;M2$;47!0|
                                      (VECTOR |f| $ |e|))
                                (|ULSCONS;getUTS| |x| $) (QREFELT $ 127))
                               (QREFELT $ 10)))))) 

(SDEFUN |ULSCONS;multiplyCoefficients;M2$;47!0| ((|z1| NIL) ($$ NIL))
        (PROG (|e| $ |f|)
          (LETT |e| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |e| |z1| (QREFELT $ 42)) |f|))))) 

(SDEFUN |ULSCONS;multiplyExponents;$Pi$;48|
        ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (* |n| (|ULSCONS;getExpon| |x| $))
                  (SPADCALL (|ULSCONS;getUTS| |x| $) |n| (QREFELT $ 130))
                  (QREFELT $ 10))) 

(SDEFUN |ULSCONS;differentiate;2$;49| ((|x| ($)) ($ ($)))
        (SPROG ((|e| (|Integer|)))
               (SEQ (LETT |e| (|ULSCONS;getExpon| |x| $))
                    (EXIT
                     (SPADCALL (- |e| 1)
                               (SPADCALL
                                (CONS #'|ULSCONS;differentiate;2$;49!0|
                                      (VECTOR $ |e|))
                                (|ULSCONS;getUTS| |x| $) (QREFELT $ 127))
                               (QREFELT $ 10)))))) 

(SDEFUN |ULSCONS;differentiate;2$;49!0| ((|z1| NIL) ($$ NIL))
        (PROG (|e| $)
          (LETT |e| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |e| |z1| (QREFELT $ 42)) (QREFELT $ 22)))))) 

(SDEFUN |ULSCONS;differentiate;$S$;50| ((|x| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPROG NIL
               (COND
                ((EQUAL |s| (SPADCALL |x| (QREFELT $ 85)))
                 (SPADCALL |x| (QREFELT $ 132)))
                ('T
                 (SPADCALL
                  (SPADCALL
                   (CONS #'|ULSCONS;differentiate;$S$;50!0| (VECTOR $ |s|)) |x|
                   (QREFELT $ 125))
                  (SPADCALL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 87)) |s| (QREFELT $ 133))
                   (SPADCALL |x| (QREFELT $ 132)) (QREFELT $ 134))
                  (QREFELT $ 67)))))) 

(SDEFUN |ULSCONS;differentiate;$S$;50!0| ((|z1| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |s| (QREFELT $ 133)))))) 

(SDEFUN |ULSCONS;characteristic;Nni;51| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 136))) 

(SDEFUN |ULSCONS;retract;$UTS;52| ((|x| ($)) ($ (UTS)))
        (SPADCALL |x| (QREFELT $ 31))) 

(SDEFUN |ULSCONS;retractIfCan;$U;53| ((|x| ($)) ($ (|Union| UTS "failed")))
        (SPADCALL |x| (QREFELT $ 30))) 

(SDEFUN |ULSCONS;^;$I$;54| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG
         ((|minusN| (|NonNegativeInteger|)) (#1=#:G1019 NIL) (|xInv| ($))
          (#2=#:G1018 NIL))
         (SEQ
          (COND ((ZEROP |n|) (|spadConstant| $ 16))
                ((> |n| 0)
                 (SPADCALL (* |n| (|ULSCONS;getExpon| |x| $))
                           (SPADCALL (|ULSCONS;getUTS| |x| $)
                                     (PROG1 (LETT #2# |n|)
                                       (|check_subtype2| (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#))
                                     (QREFELT $ 69))
                           (QREFELT $ 10)))
                ('T
                 (SEQ (LETT |xInv| (SPADCALL |x| (QREFELT $ 140)))
                      (LETT |minusN|
                            (PROG1 (LETT #1# (- |n|))
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#)))
                      (EXIT
                       (SPADCALL (* |minusN| (|ULSCONS;getExpon| |xInv| $))
                                 (SPADCALL (|ULSCONS;getUTS| |xInv| $) |minusN|
                                           (QREFELT $ 69))
                                 (QREFELT $ 10))))))))) 

(SDEFUN |ULSCONS;*;UTS2$;55| ((|x| (UTS)) (|y| ($)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 20)) |y| (QREFELT $ 68))) 

(SDEFUN |ULSCONS;*;$UTS$;56| ((|x| ($)) (|y| (UTS)) ($ ($)))
        (SPADCALL |x| (SPADCALL |y| (QREFELT $ 20)) (QREFELT $ 68))) 

(SDEFUN |ULSCONS;inv;2$;57| ((|x| ($)) ($ ($)))
        (SPROG ((|xInv| (|Union| $ "failed")))
               (SEQ (LETT |xInv| (SPADCALL |x| (QREFELT $ 74)))
                    (EXIT
                     (COND
                      ((QEQCAR |xInv| 1)
                       (|error| "multiplicative inverse does not exist"))
                      ('T (QCDR |xInv|))))))) 

(SDEFUN |ULSCONS;/;3$;58| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|yInv| (|Union| $ "failed")))
               (SEQ (LETT |yInv| (SPADCALL |y| (QREFELT $ 74)))
                    (EXIT
                     (COND
                      ((QEQCAR |yInv| 1)
                       (|error| "inv: multiplicative inverse does not exist"))
                      ('T (SPADCALL |x| (QCDR |yInv|) (QREFELT $ 68)))))))) 

(SDEFUN |ULSCONS;/;2UTS$;59| ((|x| (UTS)) (|y| (UTS)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (SPADCALL |y| (QREFELT $ 20))
                  (QREFELT $ 144))) 

(SDEFUN |ULSCONS;numer;$UTS;60| ((|x| ($)) ($ (UTS)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |x| (QREFELT $ 12)))
                    (EXIT
                     (COND ((>= |n| 0) (SPADCALL |x| (QREFELT $ 31)))
                           (#1='T
                            (SEQ
                             (LETT |x| (SPADCALL (- |n|) |x| (QREFELT $ 24)))
                             (LETT |n| (SPADCALL |x| (QREFELT $ 12)))
                             (EXIT
                              (COND ((EQL |n| 0) (SPADCALL |x| (QREFELT $ 31)))
                                    (#1# (|ULSCONS;getUTS| |x| $))))))))))) 

(SDEFUN |ULSCONS;denom;$UTS;61| ((|x| ($)) ($ (UTS)))
        (SPROG ((#1=#:G1042 NIL) (|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |x| (QREFELT $ 12)))
                    (EXIT
                     (COND ((>= |n| 0) (|spadConstant| $ 17))
                           (#2='T
                            (SEQ
                             (LETT |x| (SPADCALL (- |n|) |x| (QREFELT $ 24)))
                             (LETT |n| (SPADCALL |x| (QREFELT $ 12)))
                             (EXIT
                              (COND ((EQL |n| 0) (|spadConstant| $ 17))
                                    (#2#
                                     (SPADCALL (|spadConstant| $ 25)
                                               (PROG1 (LETT #1# (- |n|))
                                                 (|check_subtype2| (>= #1# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #1#))
                                               (QREFELT $ 27)))))))))))) 

(SDEFUN |ULSCONS;coerce;F$;62| ((|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 149)) (QREFELT $ 21))) 

(SDEFUN |ULSCONS;^;$F$;63| ((|x| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL |x| |r| (QREFELT $ 152))) 

(SDEFUN |ULSCONS;exp;2$;64| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 154))) 

(SDEFUN |ULSCONS;log;2$;65| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 156))) 

(SDEFUN |ULSCONS;sin;2$;66| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 158))) 

(SDEFUN |ULSCONS;cos;2$;67| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 160))) 

(SDEFUN |ULSCONS;tan;2$;68| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 162))) 

(SDEFUN |ULSCONS;cot;2$;69| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 164))) 

(SDEFUN |ULSCONS;sec;2$;70| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 166))) 

(SDEFUN |ULSCONS;csc;2$;71| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 168))) 

(SDEFUN |ULSCONS;asin;2$;72| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 170))) 

(SDEFUN |ULSCONS;acos;2$;73| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 172))) 

(SDEFUN |ULSCONS;atan;2$;74| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 174))) 

(SDEFUN |ULSCONS;acot;2$;75| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 176))) 

(SDEFUN |ULSCONS;asec;2$;76| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 178))) 

(SDEFUN |ULSCONS;acsc;2$;77| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 180))) 

(SDEFUN |ULSCONS;sinh;2$;78| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 182))) 

(SDEFUN |ULSCONS;cosh;2$;79| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 184))) 

(SDEFUN |ULSCONS;tanh;2$;80| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 186))) 

(SDEFUN |ULSCONS;coth;2$;81| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 188))) 

(SDEFUN |ULSCONS;sech;2$;82| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 190))) 

(SDEFUN |ULSCONS;csch;2$;83| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 192))) 

(SDEFUN |ULSCONS;asinh;2$;84| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 194))) 

(SDEFUN |ULSCONS;acosh;2$;85| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 196))) 

(SDEFUN |ULSCONS;atanh;2$;86| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 198))) 

(SDEFUN |ULSCONS;acoth;2$;87| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 200))) 

(SDEFUN |ULSCONS;asech;2$;88| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 202))) 

(SDEFUN |ULSCONS;acsch;2$;89| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 204))) 

(SDEFUN |ULSCONS;ratInv| ((|n| (|Integer|)) ($ (|Coef|)))
        (COND ((ZEROP |n|) (|spadConstant| $ 25))
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |n| (QREFELT $ 206)) (QREFELT $ 207))
                (QREFELT $ 149))))) 

(SDEFUN |ULSCONS;integrate;2$;91| ((|x| ($)) ($ ($)))
        (SPROG ((|e| (|Integer|)))
               (SEQ
                (COND
                 ((NULL
                   (SPADCALL (SPADCALL |x| -1 (QREFELT $ 71)) (QREFELT $ 39)))
                  (|error| "integrate: series has term of order -1"))
                 ('T
                  (SEQ (LETT |e| (|ULSCONS;getExpon| |x| $))
                       (EXIT
                        (SPADCALL (+ |e| 1)
                                  (SPADCALL
                                   (CONS #'|ULSCONS;integrate;2$;91!0|
                                         (VECTOR $ |e|))
                                   (|ULSCONS;getUTS| |x| $) (QREFELT $ 127))
                                  (QREFELT $ 10))))))))) 

(SDEFUN |ULSCONS;integrate;2$;91!0| ((|z1| NIL) ($$ NIL))
        (PROG (|e| $)
          (LETT |e| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ULSCONS;ratInv|
             (SPADCALL (SPADCALL |e| (|spadConstant| $ 41) (QREFELT $ 42)) |z1|
                       (QREFELT $ 42))
             $))))) 

(SDEFUN |ULSCONS;integrate;$S$;92| ((|x| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPROG NIL
               (COND
                ((EQUAL |s| (SPADCALL |x| (QREFELT $ 85)))
                 (SPADCALL |x| (QREFELT $ 209)))
                ((NULL
                  (SPADCALL |s|
                            (SPADCALL (SPADCALL |x| (QREFELT $ 87))
                                      (QREFELT $ 211))
                            (QREFELT $ 212)))
                 (SPADCALL (CONS #'|ULSCONS;integrate;$S$;92!0| (VECTOR $ |s|))
                           |x| (QREFELT $ 125)))
                ('T
                 (|error|
                  "integrate: center is a function of variable of integration"))))) 

(SDEFUN |ULSCONS;integrate;$S$;92!0| ((|z1| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |s| (QREFELT $ 213)))))) 

(SDEFUN |ULSCONS;integrateWithOneAnswer|
        ((|f| (|Coef|)) (|s| (|Symbol|)) ($ (|Coef|)))
        (SPROG ((|res| (|Union| |Coef| (|List| |Coef|))))
               (SEQ (LETT |res| (SPADCALL |f| |s| (QREFELT $ 217)))
                    (EXIT
                     (COND ((QEQCAR |res| 0) (QCDR |res|))
                           ('T (|SPADfirst| (QCDR |res|)))))))) 

(SDEFUN |ULSCONS;integrate;$S$;94| ((|x| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPROG NIL
               (COND
                ((EQUAL |s| (SPADCALL |x| (QREFELT $ 85)))
                 (SPADCALL |x| (QREFELT $ 209)))
                ((NULL
                  (SPADCALL |s|
                            (SPADCALL (SPADCALL |x| (QREFELT $ 87))
                                      (QREFELT $ 211))
                            (QREFELT $ 212)))
                 (SPADCALL (CONS #'|ULSCONS;integrate;$S$;94!0| (VECTOR $ |s|))
                           |x| (QREFELT $ 125)))
                ('T
                 (|error|
                  "integrate: center is a function of variable of integration"))))) 

(SDEFUN |ULSCONS;integrate;$S$;94!0| ((|z1| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|ULSCONS;integrateWithOneAnswer| |z1| |s| $))))) 

(SDEFUN |ULSCONS;termOutput|
        ((|k| (|Integer|)) (|c| (|Coef|)) (|vv| (|OutputForm|))
         ($ (|OutputForm|)))
        (SPROG ((|mon| (|OutputForm|)))
               (SEQ
                (COND ((EQL |k| 0) (SPADCALL |c| (QREFELT $ 219)))
                      (#1='T
                       (SEQ
                        (LETT |mon|
                              (COND ((EQL |k| 1) |vv|)
                                    (#1#
                                     (SPADCALL |vv|
                                               (SPADCALL |k| (QREFELT $ 220))
                                               (QREFELT $ 221)))))
                        (EXIT
                         (COND
                          ((SPADCALL |c| (|spadConstant| $ 25) (QREFELT $ 58))
                           |mon|)
                          ((SPADCALL |c|
                                     (SPADCALL (|spadConstant| $ 25)
                                               (QREFELT $ 222))
                                     (QREFELT $ 58))
                           (SPADCALL |mon| (QREFELT $ 223)))
                          (#1#
                           (SPADCALL (SPADCALL |c| (QREFELT $ 219)) |mon|
                                     (QREFELT $ 224))))))))))) 

(PUT '|ULSCONS;showAll?| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |ULSCONS;showAll?| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |ULSCONS;termsToOutputForm|
        ((|m| (|Integer|)) (|uu| (|Stream| |Coef|)) (|xxx| (|OutputForm|))
         ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (|uu1| (|Stream| |Coef|)) (|n| NIL)
          (#1=#:G1127 NIL) (|count| (|NonNegativeInteger|)))
         (SEQ (LETT |l| NIL)
              (EXIT
               (COND
                ((SPADCALL |uu| (QREFELT $ 34))
                 (SPADCALL (|spadConstant| $ 14) (QREFELT $ 219)))
                (#2='T
                 (SEQ (LETT |count| |$streamCount|)
                      (SEQ (LETT |n| 0) (LETT #1# |count|) G190
                           (COND
                            ((OR (|greater_SI| |n| #1#)
                                 (NULL (NULL (SPADCALL |uu| (QREFELT $ 34)))))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL (SPADCALL |uu| (QREFELT $ 38))
                                        (|spadConstant| $ 14) (QREFELT $ 225))
                              (LETT |l|
                                    (CONS
                                     (|ULSCONS;termOutput| (+ |n| |m|)
                                      (SPADCALL |uu| (QREFELT $ 38)) |xxx| $)
                                     |l|))))
                            (EXIT (LETT |uu| (SPADCALL |uu| (QREFELT $ 40)))))
                           (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((|ULSCONS;showAll?| $)
                        (SEQ (LETT |uu1| |uu|)
                             (EXIT
                              (SEQ (LETT |n| (+ |count| 1)) G190
                                   (COND
                                    ((NULL
                                      (COND
                                       ((SPADCALL |uu| (QREFELT $ 226))
                                        (NULL
                                         (SPADCALL |uu1|
                                                   (SPADCALL |uu|
                                                             (QREFELT $ 40))
                                                   (QREFELT $ 227))))
                                       ('T NIL)))
                                     (GO G191)))
                                   (SEQ
                                    (COND
                                     ((SPADCALL (SPADCALL |uu| (QREFELT $ 38))
                                                (|spadConstant| $ 14)
                                                (QREFELT $ 225))
                                      (LETT |l|
                                            (CONS
                                             (|ULSCONS;termOutput| (+ |n| |m|)
                                              (SPADCALL |uu| (QREFELT $ 38))
                                              |xxx| $)
                                             |l|))))
                                    (COND
                                     ((ODDP |n|)
                                      (LETT |uu1|
                                            (SPADCALL |uu1| (QREFELT $ 40)))))
                                    (EXIT
                                     (LETT |uu|
                                           (SPADCALL |uu| (QREFELT $ 40)))))
                                   (LETT |n| (+ |n| 1)) (GO G190) G191
                                   (EXIT NIL))))))
                      (LETT |l|
                            (COND ((SPADCALL |uu| (QREFELT $ 228)) |l|)
                                  (#2#
                                   (SEQ
                                    (COND
                                     ((SPADCALL |uu|
                                                (SPADCALL |uu| (QREFELT $ 40))
                                                (QREFELT $ 227))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |uu| (QREFELT $ 38))
                                         (|spadConstant| $ 14) (QREFELT $ 58))
                                        (EXIT |l|)))))
                                    (EXIT
                                     (CONS
                                      (SPADCALL (SPADCALL 'O (QREFELT $ 229))
                                                (LIST
                                                 (SPADCALL |xxx|
                                                           (SPADCALL
                                                            (+ |n| |m|)
                                                            (QREFELT $ 220))
                                                           (QREFELT $ 221)))
                                                (QREFELT $ 231))
                                      |l|))))))
                      (EXIT
                       (COND
                        ((NULL |l|)
                         (SPADCALL (|spadConstant| $ 14) (QREFELT $ 219)))
                        (#2#
                         (SPADCALL (ELT $ 232) (NREVERSE |l|)
                                   (QREFELT $ 235)))))))))))) 

(SDEFUN |ULSCONS;coerce;$Of;98| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|xxx| (|OutputForm|)) (|cen| (|Coef|)) (|var| (|Symbol|))
          (|p| (|Stream| |Coef|)) (|uts| (UTS)) (|m| (|Integer|)))
         (SEQ (LETT |x| (SPADCALL |$streamCount| |x| (QREFELT $ 24)))
              (LETT |m| (SPADCALL |x| (QREFELT $ 12)))
              (LETT |uts| (|ULSCONS;getUTS| |x| $))
              (LETT |p| (SPADCALL |uts| (QREFELT $ 46)))
              (LETT |var| (SPADCALL |uts| (QREFELT $ 84)))
              (LETT |cen| (SPADCALL |uts| (QREFELT $ 86)))
              (LETT |xxx|
                    (COND
                     ((SPADCALL |cen| (QREFELT $ 39))
                      (SPADCALL |var| (QREFELT $ 229)))
                     ('T
                      (SPADCALL
                       (SPADCALL (SPADCALL |var| (QREFELT $ 229))
                                 (SPADCALL |cen| (QREFELT $ 219))
                                 (QREFELT $ 236))
                       (QREFELT $ 237)))))
              (EXIT (|ULSCONS;termsToOutputForm| |m| |p| |xxx| $))))) 

(DECLAIM (NOTINLINE |UnivariateLaurentSeriesConstructor;|)) 

(DEFUN |UnivariateLaurentSeriesConstructor| (&REST #1=#:G1190)
  (SPROG NIL
         (PROG (#2=#:G1191)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariateLaurentSeriesConstructor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |UnivariateLaurentSeriesConstructor;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariateLaurentSeriesConstructor|)))))))))) 

(DEFUN |UnivariateLaurentSeriesConstructor;| (|#1| |#2|)
  (SPROG
   ((#1=#:G1189 NIL) (|pv$| NIL) (#2=#:G1178 NIL) (#3=#:G1179 NIL)
    (#4=#:G1181 NIL) (#5=#:G1182 NIL) (#6=#:G1183 NIL) (#7=#:G1184 NIL)
    (#8=#:G1185 NIL) (#9=#:G1187 NIL) (#10=#:G1188 NIL) ($ NIL) (|dv$| NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|UnivariateLaurentSeriesConstructor| DV$1 DV$2))
    (LETT $ (GETREFV 278))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| (|Integer|)
                                                       '(|SemiGroup|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|RetractableTo|
                                                              (|Symbol|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|ConvertibleTo|
                                                              (|InputForm|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|RealConstant|)))
                                        (LETT #10#
                                              (AND
                                               (|HasCategory| |#1| '(|Field|))
                                               (|HasCategory| |#2|
                                                              '(|OrderedIntegralDomain|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|)))
                                         #10#)
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|RetractableTo|
                                                              (|Integer|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|StepThrough|)))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            (LIST
                                                             '|InnerEvalable|
                                                             '(|Symbol|)
                                                             (|devaluate|
                                                              |#2|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#2|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            (LIST '|Eltable|
                                                                  (|devaluate|
                                                                   |#2|)
                                                                  (|devaluate|
                                                                   |#2|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|LinearlyExplicitOver|
                                                              (|Integer|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Float|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Integer|)))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|PatternMatchable|
                                                              (|Float|))))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
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
                                             (|HasCategory| |#2|
                                                            '(|Comparable|)))
                                        (LETT #7#
                                              (AND
                                               (|HasCategory| |#1| '(|Field|))
                                               (|HasCategory| |#2|
                                                              '(|OrderedSet|))))
                                        (OR #10# #7#)
                                        (OR
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|Comparable|)))
                                         #10# #7#)
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (LETT #6#
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              #6#))
                                        (LETT #5#
                                              (|HasCategory| |#2|
                                                             '(|PolynomialFactorizationExplicit|)))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             #5#)
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|IntegerNumberSystem|)))
                                        (AND (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|EuclideanDomain|)))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|)))))
                                        (OR #4#
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Float|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Integer|)))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|ConvertibleTo|
                                                              (|InputForm|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            (LIST '|Eltable|
                                                                  (|devaluate|
                                                                   |#2|)
                                                                  (|devaluate|
                                                                   |#2|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#2|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            (LIST
                                                             '|InnerEvalable|
                                                             '(|Symbol|)
                                                             (|devaluate|
                                                              |#2|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|LinearlyExplicitOver|
                                                              (|Integer|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|PatternMatchable|
                                                              (|Float|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|PatternMatchable|
                                                              (|Integer|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|RetractableTo|
                                                              (|Integer|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|RetractableTo|
                                                              (|Symbol|))))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|Comparable|)))
                                            #10# #7#
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             #5#)
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|RealConstant|)))
                                            (AND
                                             (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#2|
                                                            '(|StepThrough|))))
                                        (AND #4#
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
                                              (|HasCategory| |#2|
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))))
                                        (OR
                                         (AND (|HasCategory| |#1| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|DifferentialRing|)))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Integer|)
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (LETT #3#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR #3#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR #4#
                                            (|HasCategory| |#1|
                                                           '(|CharacteristicNonZero|))
                                            (|HasCategory| |#1|
                                                           '(|CharacteristicZero|))
                                            #9# (|HasCategory| |#1| '(|Field|))
                                            #8# #3#
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
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|)))
                                        (OR
                                         (AND #4#
                                              (|HasCategory|
                                               (|Fraction| (|Integer|))
                                               '(|AbelianMonoid|)))
                                         #2#
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
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Integer|)
                                                                   (|devaluate|
                                                                    |#1|)))))))))
    (|haddProp| |$ConstructorCache| '|UnivariateLaurentSeriesConstructor|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 9007199254740992))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|Field|))
                (|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 18014398509481984))
    (AND
     (OR (|HasCategory| |#1| '(|CharacteristicNonZero|))
         (AND (|HasCategory| |#1| '(|Field|)) #6#) #1#)
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
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #3#
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
     (OR #2# (AND #9# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #8# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|) '(|Integer|)
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 4611686018427387904))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|Record| (|:| |expon| (|Integer|)) (|:| |ps| |#2|)))
    (COND
     ((|testBitVector| |pv$| 23)
      (PROGN
       (QSETREFV $ 108
                 (CONS (|dispatchFunction| |ULSCONS;rationalFunction;$IF;40|)
                       $))
       (QSETREFV $ 110
                 (CONS (|dispatchFunction| |ULSCONS;rationalFunction;$2IF;41|)
                       $))
       (QSETREFV $ 112 (CONS (|dispatchFunction| |ULSCONS;exquo;2$U;42|) $)))))
    (COND
     ((|HasSignature| |#1|
                      (LIST '|coerce| (LIST (|devaluate| |#1|) '(|Symbol|))))
      (COND
       ((|testBitVector| |pv$| 21)
        (QSETREFV $ 118
                  (CONS (|dispatchFunction| |ULSCONS;approximate;$ICoef;43|)
                        $))))))
    (COND
     ((|HasCategory| |#1| '(|PartialDifferentialRing| (|Symbol|)))
      (QSETREFV $ 135
                (CONS (|dispatchFunction| |ULSCONS;differentiate;$S$;50|) $))))
    (COND
     ((|testBitVector| |pv$| 2)
      (PROGN
       (QSETREFV $ 138 (CONS (|dispatchFunction| |ULSCONS;retract;$UTS;52|) $))
       (QSETREFV $ 139
                 (CONS (|dispatchFunction| |ULSCONS;retractIfCan;$U;53|) $))
       (QSETREFV $ 141 (CONS (|dispatchFunction| |ULSCONS;^;$I$;54|) $))
       (QSETREFV $ 142 (CONS (|dispatchFunction| |ULSCONS;*;UTS2$;55|) $))
       (QSETREFV $ 143 (CONS (|dispatchFunction| |ULSCONS;*;$UTS$;56|) $))
       (QSETREFV $ 140 (CONS (|dispatchFunction| |ULSCONS;inv;2$;57|) $))
       (QSETREFV $ 144 (CONS (|dispatchFunction| |ULSCONS;/;3$;58|) $))
       (QSETREFV $ 145 (CONS (|dispatchFunction| |ULSCONS;/;2UTS$;59|) $))
       (QSETREFV $ 146 (CONS (|dispatchFunction| |ULSCONS;numer;$UTS;60|) $))
       (QSETREFV $ 147
                 (CONS (|dispatchFunction| |ULSCONS;denom;$UTS;61|) $)))))
    (COND
     ((|testBitVector| |pv$| 37)
      (PROGN
       (QSETREFV $ 150 (CONS (|dispatchFunction| |ULSCONS;coerce;F$;62|) $))
       (COND
        ((|testBitVector| |pv$| 2)
         (QSETREFV $ 153 (CONS (|dispatchFunction| |ULSCONS;^;$F$;63|) $))))
       (QSETREFV $ 155 (CONS (|dispatchFunction| |ULSCONS;exp;2$;64|) $))
       (QSETREFV $ 157 (CONS (|dispatchFunction| |ULSCONS;log;2$;65|) $))
       (QSETREFV $ 159 (CONS (|dispatchFunction| |ULSCONS;sin;2$;66|) $))
       (QSETREFV $ 161 (CONS (|dispatchFunction| |ULSCONS;cos;2$;67|) $))
       (QSETREFV $ 163 (CONS (|dispatchFunction| |ULSCONS;tan;2$;68|) $))
       (QSETREFV $ 165 (CONS (|dispatchFunction| |ULSCONS;cot;2$;69|) $))
       (QSETREFV $ 167 (CONS (|dispatchFunction| |ULSCONS;sec;2$;70|) $))
       (QSETREFV $ 169 (CONS (|dispatchFunction| |ULSCONS;csc;2$;71|) $))
       (QSETREFV $ 171 (CONS (|dispatchFunction| |ULSCONS;asin;2$;72|) $))
       (QSETREFV $ 173 (CONS (|dispatchFunction| |ULSCONS;acos;2$;73|) $))
       (QSETREFV $ 175 (CONS (|dispatchFunction| |ULSCONS;atan;2$;74|) $))
       (QSETREFV $ 177 (CONS (|dispatchFunction| |ULSCONS;acot;2$;75|) $))
       (QSETREFV $ 179 (CONS (|dispatchFunction| |ULSCONS;asec;2$;76|) $))
       (QSETREFV $ 181 (CONS (|dispatchFunction| |ULSCONS;acsc;2$;77|) $))
       (QSETREFV $ 183 (CONS (|dispatchFunction| |ULSCONS;sinh;2$;78|) $))
       (QSETREFV $ 185 (CONS (|dispatchFunction| |ULSCONS;cosh;2$;79|) $))
       (QSETREFV $ 187 (CONS (|dispatchFunction| |ULSCONS;tanh;2$;80|) $))
       (QSETREFV $ 189 (CONS (|dispatchFunction| |ULSCONS;coth;2$;81|) $))
       (QSETREFV $ 191 (CONS (|dispatchFunction| |ULSCONS;sech;2$;82|) $))
       (QSETREFV $ 193 (CONS (|dispatchFunction| |ULSCONS;csch;2$;83|) $))
       (QSETREFV $ 195 (CONS (|dispatchFunction| |ULSCONS;asinh;2$;84|) $))
       (QSETREFV $ 197 (CONS (|dispatchFunction| |ULSCONS;acosh;2$;85|) $))
       (QSETREFV $ 199 (CONS (|dispatchFunction| |ULSCONS;atanh;2$;86|) $))
       (QSETREFV $ 201 (CONS (|dispatchFunction| |ULSCONS;acoth;2$;87|) $))
       (QSETREFV $ 203 (CONS (|dispatchFunction| |ULSCONS;asech;2$;88|) $))
       (QSETREFV $ 205 (CONS (|dispatchFunction| |ULSCONS;acsch;2$;89|) $))
       NIL
       (QSETREFV $ 209 (CONS (|dispatchFunction| |ULSCONS;integrate;2$;91|) $))
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
           (QSETREFV $ 214
                     (CONS (|dispatchFunction| |ULSCONS;integrate;$S$;92|)
                           $))))))
       (COND
        ((|HasCategory| |#1| '(|TranscendentalFunctionCategory|))
         (COND
          ((|HasCategory| |#1| '(|PrimitiveFunctionCategory|))
           (COND
            ((|HasCategory| |#1|
                            '(|AlgebraicallyClosedFunctionSpace| (|Integer|)))
             (PROGN
              (QSETREFV $ 214
                        (CONS (|dispatchFunction| |ULSCONS;integrate;$S$;94|)
                              $))))))))))))
    $))) 

(MAKEPROP '|UnivariateLaurentSeriesConstructor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|Integer|) |ULSCONS;laurent;IUTS$;3| |ULSCONS;taylorRep;$UTS;4|
              |ULSCONS;degree;$I;5|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |ULSCONS;Zero;$;6|) $))
              (0 . |Zero|) (4 . |Zero|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |ULSCONS;One;$;7|) $))
              (8 . |One|) (12 . |coerce|) |ULSCONS;monomial;CoefI$;8|
              |ULSCONS;coerce;UTS$;9| |ULSCONS;coerce;Coef$;10| (17 . |coerce|)
              |ULSCONS;coerce;I$;11| |ULSCONS;removeZeroes;I2$;22| (22 . |One|)
              (|NonNegativeInteger|) (26 . |monomial|) (32 . *)
              (|Union| 7 '"failed") |ULSCONS;taylorIfCan;$U;12|
              |ULSCONS;taylor;$UTS;13| (|Boolean|) (|Stream| 6) (38 . |empty?|)
              (|Record| (|:| |k| 9) (|:| |c| 6)) (|Stream| 35) (43 . |empty|)
              (47 . |frst|) (52 . |zero?|) (57 . |rst|) (62 . |One|) (66 . +)
              (72 . |concat|) (|Mapping| $) (78 . |delay|)
              (83 . |coefficients|) |ULSCONS;terms;$S;18| (88 . |empty?|)
              (93 . |empty|) (97 . |frst|) (102 . =) (108 . |rst|)
              (113 . |concat|) (119 . |delay|) (124 . |series|)
              |ULSCONS;series;S$;20| (129 . |coefficient|) (135 . =)
              (141 . |quoByVar|) |ULSCONS;removeZeroes;2$;21| (146 . =)
              |ULSCONS;=;2$B;23| |ULSCONS;pole?;$B;24| (152 . +)
              |ULSCONS;+;3$;25| (158 . -) |ULSCONS;-;3$;26| |ULSCONS;*;3$;27|
              (164 . ^) |ULSCONS;^;$Nni$;28| |ULSCONS;coefficient;$ICoef;34|
              (|Union| $ '"failed") (170 . |recip|) |ULSCONS;recip;$U;29|
              (175 . |elt|) |ULSCONS;elt;3$;30| (181 . |recip|) (186 . ^)
              (192 . |eval|) (|StreamTaylorSeriesOperations| 6) (198 . *)
              |ULSCONS;eval;$CoefS;31| (|Symbol|) (204 . |variable|)
              |ULSCONS;variable;$S;32| (209 . |center|)
              |ULSCONS;center;$Coef;33| |ULSCONS;elt;$ICoef;35| (214 . |order|)
              |ULSCONS;order;$I;36| (219 . |order|) |ULSCONS;order;$2I;37|
              (225 . |truncate|) |ULSCONS;truncate;$I$;38| (231 . |truncate|)
              |ULSCONS;truncate;$2I$;39| (|Fraction| 99) (238 . |Zero|)
              (|Polynomial| 6) (242 . |polynomial|) (248 . |coerce|)
              (253 . |coerce|) (258 . |coerce|) (263 . -) (269 . ^) (275 . *)
              (281 . /) (287 . |rationalFunction|) (293 . |polynomial|)
              (300 . |rationalFunction|) (307 . |exquo|) (313 . |exquo|)
              (319 . |approximate|) (325 . |coerce|) (330 . -) (336 . ^)
              (342 . *) (348 . |approximate|) (354 . |complete|)
              |ULSCONS;complete;2$;44| (359 . |extend|) |ULSCONS;extend;$I$;45|
              (|Mapping| 6 6) (365 . |map|) |ULSCONS;map;M2$;46|
              (|Mapping| 6 9) (371 . |multiplyCoefficients|)
              |ULSCONS;multiplyCoefficients;M2$;47| (|PositiveInteger|)
              (377 . |multiplyExponents|) |ULSCONS;multiplyExponents;$Pi$;48|
              |ULSCONS;differentiate;2$;49| (383 . |differentiate|) (389 . *)
              (395 . |differentiate|) (401 . |characteristic|)
              |ULSCONS;characteristic;Nni;51| (405 . |retract|)
              (410 . |retractIfCan|) (415 . |inv|) (420 . ^) (426 . *)
              (432 . *) (438 . /) (444 . /) (450 . |numer|) (455 . |denom|)
              (|Fraction| 9) (460 . |coerce|) (465 . |coerce|)
              (|ElementaryFunctionsUnivariateLaurentSeries| 6 7 $$) (470 . ^)
              (476 . ^) (482 . |exp|) (487 . |exp|) (492 . |log|) (497 . |log|)
              (502 . |sin|) (507 . |sin|) (512 . |cos|) (517 . |cos|)
              (522 . |tan|) (527 . |tan|) (532 . |cot|) (537 . |cot|)
              (542 . |sec|) (547 . |sec|) (552 . |csc|) (557 . |csc|)
              (562 . |asin|) (567 . |asin|) (572 . |acos|) (577 . |acos|)
              (582 . |atan|) (587 . |atan|) (592 . |acot|) (597 . |acot|)
              (602 . |asec|) (607 . |asec|) (612 . |acsc|) (617 . |acsc|)
              (622 . |sinh|) (627 . |sinh|) (632 . |cosh|) (637 . |cosh|)
              (642 . |tanh|) (647 . |tanh|) (652 . |coth|) (657 . |coth|)
              (662 . |sech|) (667 . |sech|) (672 . |csch|) (677 . |csch|)
              (682 . |asinh|) (687 . |asinh|) (692 . |acosh|) (697 . |acosh|)
              (702 . |atanh|) (707 . |atanh|) (712 . |acoth|) (717 . |acoth|)
              (722 . |asech|) (727 . |asech|) (732 . |acsch|) (737 . |acsch|)
              (742 . |coerce|) (747 . |inv|) (752 . -) (757 . |integrate|)
              (|List| 83) (762 . |variables|) (767 . |entry?|)
              (773 . |integrate|) (779 . |integrate|) (|Union| 6 (|List| 6))
              (|FunctionSpaceIntegration| 9 6) (785 . |integrate|)
              (|OutputForm|) (791 . |coerce|) (796 . |coerce|) (801 . ^)
              (807 . -) (812 . -) (817 . *) (823 . ~=)
              (829 . |explicitEntries?|) (834 . |eq?|)
              (840 . |explicitlyEmpty?|) (845 . |coerce|) (|List| $)
              (850 . |prefix|) (856 . +) (|Mapping| 218 218 218) (|List| 218)
              (862 . |reduce|) (868 . -) (874 . |paren|)
              |ULSCONS;coerce;$Of;98| (|Union| 249 '#1="failed") (|Matrix| $)
              (|InputForm|) (|Pattern| 256) (|Pattern| 9) (|List| 7)
              (|List| 246) (|Equation| 7) (|Matrix| 9)
              (|Record| (|:| |mat| 247) (|:| |vec| (|Vector| 9))) (|Vector| $)
              (|PatternMatchResult| 256 $) (|PatternMatchResult| 9 $)
              (|Factored| 253) (|SparseUnivariatePolynomial| $)
              (|Union| 255 '#1#) (|List| 253) (|Float|) (|DoubleFloat|)
              (|Union| 148 '#2="failed") (|Union| 9 '#2#) (|Union| 83 '#2#)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|List| 26) (|List| 35) (|Mapping| 7 7)
              (|Record| (|:| |mat| 266) (|:| |vec| (|Vector| 7))) (|Matrix| 7)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |coef| 230) (|:| |generator| $))
              (|Union| 230 '"failed")
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 272 '"failed") (|Factored| $) (|HashState|) (|String|)
              (|SingleInteger|))
           '#(~= 879 |zero?| 885 |wholePart| 890 |variable| 895 |unitNormal|
              900 |unitCanonical| 905 |unit?| 910 |truncate| 915 |terms| 928
              |taylorRep| 933 |taylorIfCan| 938 |taylor| 943 |tanh| 948 |tan|
              953 |subtractIfCan| 958 |squareFreePolynomial| 964
              |squareFreePart| 969 |squareFree| 974 |sqrt| 979
              |solveLinearPolynomialEquation| 984 |smaller?| 990 |sizeLess?|
              996 |sinh| 1002 |sin| 1007 |sign| 1012 |series| 1017 |sech| 1022
              |sec| 1027 |sample| 1032 |rightRecip| 1036 |rightPower| 1041
              |retractIfCan| 1053 |retract| 1073 |removeZeroes| 1093 |rem| 1104
              |reductum| 1110 |reducedSystem| 1115 |recip| 1137
              |rationalFunction| 1142 |quo| 1155 |principalIdeal| 1161 |prime?|
              1166 |positive?| 1171 |pole?| 1176 |pi| 1181 |patternMatch| 1185
              |order| 1199 |opposite?| 1210 |one?| 1216 |numerator| 1221
              |numer| 1226 |nthRoot| 1231 |nextItem| 1237 |negative?| 1242
              |multiplyExponents| 1247 |multiplyCoefficients| 1253
              |multiEuclidean| 1259 |monomial?| 1265 |monomial| 1270 |min| 1276
              |max| 1282 |map| 1288 |log| 1300 |leftRecip| 1305 |leftPower|
              1310 |leadingTerm| 1322 |leadingSupport| 1327 |leadingMonomial|
              1332 |leadingCoefficient| 1337 |lcmCoef| 1342 |lcm| 1348
              |laurent| 1359 |latex| 1371 |inv| 1376 |integrate| 1381 |init|
              1392 |hashUpdate!| 1396 |hash| 1402 |gcdPolynomial| 1407 |gcd|
              1413 |fractionPart| 1424 |floor| 1429
              |factorSquareFreePolynomial| 1434 |factorPolynomial| 1439
              |factor| 1444 |extendedEuclidean| 1449 |extend| 1462 |exquo| 1468
              |expressIdealMember| 1474 |exp| 1480 |eval| 1485 |euclideanSize|
              1531 |elt| 1536 |divide| 1554 |differentiate| 1560 |denominator|
              1610 |denom| 1615 |degree| 1620 |csch| 1625 |csc| 1630 |coth|
              1635 |cot| 1640 |cosh| 1645 |cos| 1650 |convert| 1655
              |constructOrdered| 1680 |construct| 1685 |conditionP| 1690
              |complete| 1695 |commutator| 1700 |coerce| 1706 |coefficient|
              1741 |charthRoot| 1747 |characteristic| 1752 |center| 1756
              |ceiling| 1761 |atanh| 1766 |atan| 1771 |associator| 1776
              |associates?| 1783 |asinh| 1789 |asin| 1794 |asech| 1799 |asec|
              1804 |approximate| 1809 |antiCommutator| 1815 |annihilate?| 1821
              |acsch| 1827 |acsc| 1832 |acoth| 1837 |acot| 1842 |acosh| 1847
              |acos| 1852 |abs| 1857 ^ 1862 |Zero| 1892 |One| 1896 D 1900 >=
              1950 > 1956 = 1962 <= 1968 < 1974 / 1980 - 1998 + 2009 * 2015)
           'NIL
           (CONS
            (|makeByteWordVec2| 53
                                '(0 0 2 0 2 0 2 34 0 2 2 0 2 6 25 2 2 24 6 2 2
                                  20 24 25 38 32 7 2 43 44 2 13 47 42 47 0 20
                                  24 38 2 0 0 0 46 38 6 2 0 0 0 0 0 38 38 6 2 2
                                  47 53 6 52 42 42 6 0 0 51 42 28 2 0 0 29 9 2
                                  16 17 0 0 38 24 3 5 8 8 11 2 0 0 0 0 1 38 38
                                  38 38 38 38 24 25 2 2 46 3 4 5 5 28 8 8 10 11
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
              '#((|UnivariateLaurentSeriesConstructorCategory| 6 7)
                 (|UnivariateLaurentSeriesCategory| 6)
                 (|QuotientFieldCategory| 7)
                 (|UnivariateSeriesWithRationalExponents| 6 9) (|Field|)
                 (|UnivariatePowerSeriesCategory| 6 9) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|)
                 (|PowerSeriesCategory| 6 9 (|SingletonAsOrderedSet|))
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 9) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|) (|LeftOreRing|)
                 (|DivisionRing|) (|CommutativeRing|) (|OrderedRing|)
                 (|DifferentialExtension| 7) (|FullyLinearlyExplicitOver| 7)
                 (|Algebra| 6) (|Algebra| $$) (|EntireRing|) (|Algebra| 148)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 7)
                 (|PartialDifferentialRing| 83) (|DifferentialRing|)
                 (|LinearlyExplicitOver| 7) (|LinearlyExplicitOver| 9) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 6) (|Module| $$)
                 (|Module| 148) (|Module| 7) (|IndexedProductCategory| 6 9)
                 (|BiModule| 6 6) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|BiModule| 148 148) (|OrderedAbelianGroup|) (|BiModule| 7 7)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 148) (|RightModule| 148)
                 (|OrderedCancellationAbelianMonoid|) (|LeftModule| 7)
                 (|RightModule| 7) (|NonAssociativeRng|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|OrderedAbelianSemiGroup|) (|NonAssociativeSemiRng|)
                 (|SemiGroup|) (|AbelianMonoid|) (|MagmaWithUnit|)
                 (|OrderedSet|) (|FullyPatternMatchable| 7) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|FullyEvalableOver| 7) (|PatternMatchable| 256)
                 (|PatternMatchable| 9) (|RetractableTo| 7) (|SetCategory|)
                 (|TranscendentalFunctionCategory|) (|CommutativeStar|)
                 (|RetractableTo| 83) (|RealConstant|) (|RetractableTo| 148)
                 (|RetractableTo| 9) (|Evalable| 7) (|Patternable| 7)
                 (|CoercibleFrom| 7) (|VariablesCommuteWithCoefficients|)
                 (|BasicType|) (|CoercibleTo| 218) (|Eltable| $$ $$)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|)
                 (|TwoSidedRecip|) (|noZeroDivisors|) (|canonicalUnitNormal|)
                 (|canonicalsClosed|) (|unitsKnown|) (|CoercibleFrom| 83)
                 (|ConvertibleTo| 241) (|ConvertibleTo| 257)
                 (|ConvertibleTo| 256) (|PartialOrder|) (|CoercibleFrom| 148)
                 (|CoercibleFrom| 9) (|InnerEvalable| 83 7)
                 (|InnerEvalable| 7 7) (|Eltable| 7 $$) (|ConvertibleTo| 242)
                 (|ConvertibleTo| 243) (|Type|))
              (|makeByteWordVec2| 277
                                  '(0 6 0 14 0 7 0 15 0 7 0 17 1 7 0 6 18 1 6 0
                                    9 22 0 6 0 25 2 7 0 6 26 27 2 7 0 0 0 28 1
                                    33 32 0 34 0 36 0 37 1 33 6 0 38 1 6 32 0
                                    39 1 33 0 0 40 0 9 0 41 2 9 0 0 0 42 2 36 0
                                    35 0 43 1 36 0 44 45 1 7 33 0 46 1 36 32 0
                                    48 0 33 0 49 1 36 35 0 50 2 9 32 0 0 51 1
                                    36 0 0 52 2 33 0 6 0 53 1 33 0 44 54 1 7 0
                                    33 55 2 7 6 0 26 57 2 6 32 0 0 58 1 7 0 0
                                    59 2 7 32 0 0 61 2 7 0 0 0 64 2 7 0 0 0 66
                                    2 7 0 0 26 69 1 7 72 0 73 2 7 0 0 0 75 1 6
                                    72 0 77 2 6 0 0 26 78 2 7 33 0 6 79 2 80 33
                                    6 33 81 1 7 83 0 84 1 7 6 0 86 1 7 26 0 89
                                    2 7 26 0 26 91 2 7 0 0 26 93 3 7 0 0 26 26
                                    95 0 97 0 98 2 7 99 0 26 100 1 97 0 99 101
                                    1 97 0 83 102 1 99 0 6 103 2 97 0 0 0 104 2
                                    97 0 0 9 105 2 97 0 0 0 106 2 97 0 0 0 107
                                    2 0 97 0 9 108 3 7 99 0 26 26 109 3 0 97 0
                                    9 9 110 2 7 72 0 0 111 2 0 72 0 0 112 2 7 6
                                    0 26 113 1 6 0 83 114 2 6 0 0 0 115 2 6 0 0
                                    9 116 2 6 0 0 0 117 2 0 6 0 9 118 1 7 0 0
                                    119 2 7 0 0 26 121 2 7 0 123 0 124 2 7 0
                                    126 0 127 2 7 0 0 129 130 2 6 0 0 83 133 2
                                    0 0 6 0 134 2 0 0 0 83 135 0 6 26 136 1 0 7
                                    0 138 1 0 29 0 139 1 0 0 0 140 2 0 0 0 9
                                    141 2 0 0 7 0 142 2 0 0 0 7 143 2 0 0 0 0
                                    144 2 0 0 7 7 145 1 0 7 0 146 1 0 7 0 147 1
                                    6 0 148 149 1 0 0 148 150 2 151 2 2 148 152
                                    2 0 0 0 148 153 1 151 2 2 154 1 0 0 0 155 1
                                    151 2 2 156 1 0 0 0 157 1 151 2 2 158 1 0 0
                                    0 159 1 151 2 2 160 1 0 0 0 161 1 151 2 2
                                    162 1 0 0 0 163 1 151 2 2 164 1 0 0 0 165 1
                                    151 2 2 166 1 0 0 0 167 1 151 2 2 168 1 0 0
                                    0 169 1 151 2 2 170 1 0 0 0 171 1 151 2 2
                                    172 1 0 0 0 173 1 151 2 2 174 1 0 0 0 175 1
                                    151 2 2 176 1 0 0 0 177 1 151 2 2 178 1 0 0
                                    0 179 1 151 2 2 180 1 0 0 0 181 1 151 2 2
                                    182 1 0 0 0 183 1 151 2 2 184 1 0 0 0 185 1
                                    151 2 2 186 1 0 0 0 187 1 151 2 2 188 1 0 0
                                    0 189 1 151 2 2 190 1 0 0 0 191 1 151 2 2
                                    192 1 0 0 0 193 1 151 2 2 194 1 0 0 0 195 1
                                    151 2 2 196 1 0 0 0 197 1 151 2 2 198 1 0 0
                                    0 199 1 151 2 2 200 1 0 0 0 201 1 151 2 2
                                    202 1 0 0 0 203 1 151 2 2 204 1 0 0 0 205 1
                                    148 0 9 206 1 148 0 0 207 1 0 0 0 208 1 0 0
                                    0 209 1 6 210 0 211 2 210 32 83 0 212 2 6 0
                                    0 83 213 2 0 0 0 83 214 2 216 215 6 83 217
                                    1 6 218 0 219 1 9 218 0 220 2 218 0 0 0 221
                                    1 6 0 0 222 1 218 0 0 223 2 218 0 0 0 224 2
                                    6 32 0 0 225 1 33 32 0 226 2 33 32 0 0 227
                                    1 33 32 0 228 1 83 218 0 229 2 218 0 0 230
                                    231 2 218 0 0 0 232 2 234 218 233 0 235 2
                                    218 0 0 0 236 1 218 0 0 237 2 0 32 0 0 1 1
                                    61 32 0 1 1 36 7 0 1 1 0 83 0 85 1 57 261 0
                                    1 1 57 0 0 1 1 57 32 0 1 3 0 0 0 9 9 96 2 0
                                    0 0 9 94 1 0 36 0 47 1 0 7 0 11 1 0 29 0 30
                                    1 0 7 0 31 1 37 0 0 187 1 37 0 0 163 2 62
                                    72 0 0 1 1 34 252 253 1 1 2 0 0 1 1 2 274 0
                                    1 1 37 0 0 1 2 34 254 255 253 1 2 26 32 0 0
                                    1 2 2 32 0 0 1 1 37 0 0 183 1 37 0 0 159 1
                                    6 9 0 1 1 0 0 36 56 1 37 0 0 191 1 37 0 0
                                    167 0 61 0 1 1 59 72 0 1 2 59 0 0 26 1 2 0
                                    0 0 129 1 1 8 258 0 1 1 8 259 0 1 1 3 260 0
                                    1 1 0 29 0 139 1 8 148 0 1 1 8 9 0 1 1 3 83
                                    0 1 1 0 7 0 138 2 0 0 9 0 24 1 0 0 0 60 2 2
                                    0 0 0 1 1 18 0 0 1 1 13 247 240 1 2 13 248
                                    240 249 1 2 2 265 240 249 1 1 2 266 240 1 1
                                    59 72 0 74 3 23 97 0 9 9 110 2 23 97 0 9
                                    108 2 2 0 0 0 1 1 2 268 230 1 1 2 32 0 1 1
                                    6 32 0 1 1 0 32 0 63 0 37 0 1 3 16 250 0
                                    242 250 1 3 17 251 0 243 251 1 2 0 9 0 9 92
                                    1 0 9 0 90 2 61 32 0 0 1 1 59 32 0 1 1 2 0
                                    0 1 1 2 7 0 146 2 37 0 0 9 1 1 9 72 0 1 1 6
                                    32 0 1 2 0 0 0 129 131 2 0 0 126 0 128 2 2
                                    269 230 0 1 1 0 32 0 1 2 0 0 6 9 19 2 27 0
                                    0 0 1 2 27 0 0 0 1 2 2 0 264 0 1 2 0 0 123
                                    0 125 1 37 0 0 157 1 59 72 0 1 2 59 0 0 26
                                    1 2 0 0 0 129 1 1 18 35 0 1 1 18 9 0 1 1 0
                                    0 0 1 1 0 6 0 1 2 2 267 0 0 1 1 2 0 230 1 2
                                    2 0 0 0 1 2 0 0 9 7 10 2 0 0 9 33 1 1 0 276
                                    0 1 1 2 0 0 140 2 39 0 0 83 214 1 37 0 0
                                    209 0 9 0 1 2 0 275 275 0 1 1 0 277 0 1 2 2
                                    253 253 253 1 2 2 0 0 0 1 1 2 0 230 1 1 36
                                    0 0 1 1 35 7 0 1 1 34 252 253 1 1 34 252
                                    253 1 1 2 274 0 1 2 2 271 0 0 1 3 2 273 0 0
                                    0 1 2 0 0 0 9 122 2 57 72 0 0 112 2 2 269
                                    230 0 1 1 37 0 0 155 3 11 0 0 7 7 1 3 11 0
                                    0 244 244 1 2 11 0 0 245 1 2 11 0 0 246 1 3
                                    10 0 0 83 7 1 3 10 0 0 210 244 1 2 21 33 0
                                    6 82 1 2 26 0 1 2 12 0 0 7 1 2 1 0 0 0 76 2
                                    0 6 0 9 88 2 2 270 0 0 1 1 44 0 0 132 2 44
                                    0 0 26 1 2 43 0 0 210 1 2 43 0 0 83 135 3
                                    43 0 0 83 26 1 3 43 0 0 210 262 1 2 2 0 0
                                    264 1 3 2 0 0 264 26 1 1 2 0 0 1 1 2 7 0
                                    147 1 0 9 0 12 1 37 0 0 193 1 37 0 0 169 1
                                    37 0 0 189 1 37 0 0 165 1 37 0 0 185 1 37 0
                                    0 161 1 4 241 0 1 1 14 242 0 1 1 15 243 0 1
                                    1 5 256 0 1 1 5 257 0 1 1 18 0 263 1 1 0 0
                                    263 1 1 55 239 240 1 1 0 0 0 120 2 60 0 0 0
                                    1 1 54 0 6 21 1 3 0 83 1 1 58 0 0 1 1 60 0
                                    9 23 1 37 0 148 150 1 0 0 7 20 1 0 218 0
                                    238 2 0 6 0 9 71 1 56 72 0 1 0 60 26 137 1
                                    0 6 0 87 1 35 7 0 1 1 37 0 0 199 1 37 0 0
                                    175 3 60 0 0 0 0 1 2 57 32 0 0 1 1 37 0 0
                                    195 1 37 0 0 171 1 37 0 0 203 1 37 0 0 179
                                    2 22 6 0 9 118 2 0 0 0 0 1 2 60 32 0 0 1 1
                                    37 0 0 205 1 37 0 0 181 1 37 0 0 201 1 37 0
                                    0 177 1 37 0 0 197 1 37 0 0 173 1 6 0 0 1 2
                                    59 0 0 26 70 2 37 0 0 148 153 2 37 0 0 0 1
                                    2 2 0 0 9 141 2 0 0 0 129 1 0 61 0 13 0 59
                                    0 16 1 44 0 0 1 2 44 0 0 26 1 2 43 0 0 83 1
                                    3 43 0 0 83 26 1 2 43 0 0 210 1 3 43 0 0
                                    210 262 1 3 2 0 0 264 26 1 2 2 0 0 264 1 2
                                    27 32 0 0 1 2 27 32 0 0 1 2 0 32 0 0 62 2
                                    27 32 0 0 1 2 27 32 0 0 1 2 2 0 7 7 145 2 2
                                    0 0 0 144 2 2 0 0 6 1 1 63 0 0 208 2 63 0 0
                                    0 67 2 0 0 0 0 65 2 63 0 9 0 1 2 61 0 26 0
                                    1 2 37 0 148 0 1 2 37 0 0 148 1 2 2 0 0 7
                                    143 2 2 0 7 0 142 2 0 0 6 0 134 2 0 0 0 6 1
                                    2 0 0 0 0 68 2 0 0 129 0 1)))))
           '|lookupComplete|)) 
