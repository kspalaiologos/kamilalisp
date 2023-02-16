
(PUT '|EXPR;belong?;BoB;1| '|SPADreplace| '(XLAM (|op|) 'T)) 

(SDEFUN |EXPR;belong?;BoB;1| ((|op| (|BasicOperator|)) ($ (|Boolean|))) 'T) 

(SDEFUN |EXPR;retNotUnit| ((|x| ($)) ($ (R)))
        (SPROG ((|u| (|Union| R "failed")) (|k| (|Kernel| $)))
               (SEQ
                (LETT |u|
                      (SPADCALL (LETT |k| (SPADCALL |x| (QREFELT $ 13)))
                                (QREFELT $ 17)))
                (EXIT
                 (COND ((QEQCAR |u| 0) (QCDR |u|))
                       ('T (|error| "Not retractable"))))))) 

(SDEFUN |EXPR;retNotUnitIfCan| ((|x| ($)) ($ (|Union| R "failed")))
        (SPROG ((|r| (|Union| (|Kernel| $) "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 19)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |r|) (QREFELT $ 17)))))))) 

(SDEFUN |EXPR;operator;2Bo;4| ((|op| #1=(|BasicOperator|)) ($ #1#))
        (SPROG ((|n| (|Union| (|NonNegativeInteger|) "failed")))
               (SEQ
                (COND
                 ((SPADCALL |op| (QREFELT $ 21))
                  (SPADCALL |op| (QREFELT $ 22)))
                 ((SPADCALL |op| (QREFELT $ 24))
                  (SPADCALL |op| (QREFELT $ 25)))
                 (#2='T
                  (SEQ
                   (COND
                    ((SPADCALL |op| (QREFELT $ 26))
                     (COND
                      ((SPADCALL |op| (QREFELT $ 7) (QREFELT $ 28))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |op| (QREFELT $ 29))
                                   (QREFELT $ 30))
                         (QREFELT $ 31)))))))
                   (LETT |n| (SPADCALL |op| (QREFELT $ 33)))
                   (EXIT
                    (COND
                     ((QEQCAR |n| 1)
                      (SPADCALL (SPADCALL |op| (QREFELT $ 29)) (QREFELT $ 34)))
                     (#2#
                      (SPADCALL (SPADCALL |op| (QREFELT $ 29)) (QCDR |n|)
                                (QREFELT $ 36))))))))))) 

(SDEFUN |EXPR;poly_to_MP|
        ((|p| (|Polynomial| R))
         ($ (|SparseMultivariatePolynomial| R (|Kernel| $))))
        (SPROG
         ((|vl2| (|List| (|Kernel| $))) (#1=#:G784 NIL) (|z| NIL)
          (#2=#:G783 NIL) (|vl1| (|List| (|Symbol|)))
          (|ps| (|SparseMultivariatePolynomial| R (|Symbol|))))
         (SEQ (LETT |ps| |p|) (LETT |vl1| (SPADCALL |ps| (QREFELT $ 40)))
              (LETT |vl2|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |z| NIL) (LETT #1# |vl1|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |z| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |z| (QREFELT $ 30)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (SPADCALL |ps| |vl1| |vl2| (QREFELT $ 44)))))) 

(SDEFUN |EXPR;Zero;$;6| (($ ($))) (|spadConstant| $ 46)) 

(SDEFUN |EXPR;One;$;7| (($ ($))) (|spadConstant| $ 48)) 

(SDEFUN |EXPR;one?;$B;8| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL |x| (|spadConstant| $ 49) (QREFELT $ 51))) 

(SDEFUN |EXPR;zero?;$B;9| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL |x| (QREFELT $ 53))) 

(SDEFUN |EXPR;-;2$;10| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 55))) 

(SDEFUN |EXPR;*;I2$;11| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL |n| |x| (QREFELT $ 58))) 

(SDEFUN |EXPR;coerce;I$;12| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL |n| (QREFELT $ 60))) 

(SDEFUN |EXPR;*;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (|EXPR;algreduc| (SPADCALL |x| |y| (QREFELT $ 62))
         (|EXPR;commonk| |x| |y| $) $)) 

(SDEFUN |EXPR;+;3$;14| ((|x| ($)) (|y| ($)) ($ ($)))
        (|EXPR;algreduc| (SPADCALL |x| |y| (QREFELT $ 64))
         (|EXPR;commonk| |x| |y| $) $)) 

(SDEFUN |EXPR;-;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (|EXPR;algreduc| (SPADCALL |x| |y| (QREFELT $ 66))
         (|EXPR;commonk| |x| |y| $) $)) 

(SDEFUN |EXPR;/;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (|EXPR;algreduc| (SPADCALL |x| |y| (QREFELT $ 68))
         (|EXPR;commonk| |x| |y| $) $)) 

(SDEFUN |EXPR;number?;$B;17| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((|HasCategory| (QREFELT $ 6) (LIST '|RetractableTo| '(|Integer|)))
          (COND ((SPADCALL |x| (QREFELT $ 70)) 'T)
                (#1='T (QEQCAR (SPADCALL |x| (QREFELT $ 72)) 0))))
         (#1# (SPADCALL |x| (QREFELT $ 70))))) 

(SDEFUN |EXPR;simplifyPower| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((|args| (|List| $)) (|k| (|List| (|Kernel| $))))
               (SEQ (LETT |k| (SPADCALL |x| (QREFELT $ 75)))
                    (EXIT
                     (COND
                      ((SPADCALL |x| '|%power| (QREFELT $ 76))
                       (SEQ
                        (LETT |args|
                              (SPADCALL (SPADCALL |k| (QREFELT $ 77))
                                        (QREFELT $ 79)))
                        (COND
                         ((NULL (EQL (SPADCALL |args| (QREFELT $ 80)) 2))
                          (EXIT (|error| "Too many arguments to ^"))))
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |args| 1 (QREFELT $ 81))
                                     (QREFELT $ 73))
                           (SPADCALL
                            (|EXPR;reduc|
                             (SPADCALL (SPADCALL |args| 1 (QREFELT $ 81)) |n|
                                       (QREFELT $ 82))
                             (SPADCALL (SPADCALL |args| 1 (QREFELT $ 81))
                                       (QREFELT $ 83))
                             $)
                            (SPADCALL |args| 2 (QREFELT $ 81)) (QREFELT $ 84)))
                          (#1='T
                           (SPADCALL (SPADCALL |args| (QREFELT $ 85))
                                     (SPADCALL |n|
                                               (SPADCALL |args| (QREFELT $ 86))
                                               (QREFELT $ 59))
                                     (QREFELT $ 84)))))))
                      (#1#
                       (|EXPR;reduc| (SPADCALL |x| |n| (QREFELT $ 82))
                        (SPADCALL |x| (QREFELT $ 83)) $))))))) 

(SDEFUN |EXPR;^;$Nni$;19| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (COND ((EQL |n| 0) (|spadConstant| $ 49)) ((EQL |n| 1) |x|)
              ('T
               (SPADCALL
                (|EXPR;simplifyPower| (SPADCALL |x| (QREFELT $ 88)) |n| $)
                (|EXPR;simplifyPower| (SPADCALL |x| (QREFELT $ 89)) |n| $)
                (QREFELT $ 69))))) 

(SDEFUN |EXPR;^;$I$;20| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (COND ((EQL |n| 0) (|spadConstant| $ 49)) ((EQL |n| 1) |x|)
              (#1='T
               (COND
                ((EQL |n| -1)
                 (SPADCALL (|spadConstant| $ 49) |x| (QREFELT $ 69)))
                (#1#
                 (SPADCALL
                  (|EXPR;simplifyPower| (SPADCALL |x| (QREFELT $ 88)) |n| $)
                  (|EXPR;simplifyPower| (SPADCALL |x| (QREFELT $ 89)) |n| $)
                  (QREFELT $ 69))))))) 

(SDEFUN |EXPR;^;$Pi$;21| ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (COND ((EQL |n| 1) |x|)
              ('T
               (SPADCALL
                (|EXPR;simplifyPower| (SPADCALL |x| (QREFELT $ 88)) |n| $)
                (|EXPR;simplifyPower| (SPADCALL |x| (QREFELT $ 89)) |n| $)
                (QREFELT $ 69))))) 

(SDEFUN |EXPR;smaller?;2$B;22| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 94))) 

(SDEFUN |EXPR;=;2$B;23| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| |y| (QREFELT $ 67)) (|spadConstant| $ 46)
                  (QREFELT $ 51))) 

(SDEFUN |EXPR;numer;$Smp;24|
        ((|x| ($)) ($ (|SparseMultivariatePolynomial| R (|Kernel| $))))
        (SPADCALL |x| (QREFELT $ 97))) 

(SDEFUN |EXPR;denom;$Smp;25|
        ((|x| ($)) ($ (|SparseMultivariatePolynomial| R (|Kernel| $))))
        (SPADCALL |x| (QREFELT $ 100))) 

(SDEFUN |EXPR;coerce;Smp$;26|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| $))) ($ ($)))
        (CONS |p| (|spadConstant| $ 103))) 

(SDEFUN |EXPR;coerce;P$;27| ((|p| (|Polynomial| R)) ($ ($)))
        (SPROG ((|en| (|SparseMultivariatePolynomial| R (|Kernel| $))))
               (SEQ (LETT |en| (|EXPR;poly_to_MP| |p| $))
                    (EXIT (CONS |en| (|spadConstant| $ 103)))))) 

(SDEFUN |EXPR;coerce;F$;28| ((|pq| (|Fraction| (|Polynomial| R))) ($ ($)))
        (SPROG
         ((|ed| #1=(|SparseMultivariatePolynomial| R (|Kernel| $))) (|en| #1#))
         (SEQ (LETT |en| (|EXPR;poly_to_MP| (SPADCALL |pq| (QREFELT $ 108)) $))
              (LETT |ed| (|EXPR;poly_to_MP| (SPADCALL |pq| (QREFELT $ 109)) $))
              (EXIT (CONS |en| |ed|))))) 

(SDEFUN |EXPR;reduce;2$;29| ((|x| ($)) ($ ($)))
        (|EXPR;reduc| |x| (SPADCALL |x| (QREFELT $ 83)) $)) 

(SDEFUN |EXPR;commonk| ((|x| ($)) (|y| ($)) ($ (|List| (|Kernel| $))))
        (|EXPR;commonk0| (SPADCALL |x| (QREFELT $ 83))
         (SPADCALL |y| (QREFELT $ 83)) $)) 

(SDEFUN |EXPR;algkernels|
        ((|l| (|List| (|Kernel| $))) ($ (|List| (|Kernel| $))))
        (SPROG NIL
               (SPADCALL (CONS #'|EXPR;algkernels!0| (VECTOR (QREFELT $ 8) $))
                         |l| (QREFELT $ 113)))) 

(SDEFUN |EXPR;algkernels!0| ((|x| NIL) ($$ NIL))
        (PROG ($ ALGOP)
          (LETT $ (QREFELT $$ 1))
          (LETT ALGOP (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 31)) ALGOP (QREFELT $ 28)))))) 

(SDEFUN |EXPR;toprat| ((|f| ($)) ($ ($)))
        (SPADCALL |f| (SPADCALL |f| (QREFELT $ 83)) (QREFELT $ 115))) 

(SDEFUN |EXPR;simple_root| ((|r| (|Kernel| $)) ($ (|Boolean|)))
        (SPROG ((|a| ($)) (|al| (|List| $)))
               (SEQ
                (COND
                 ((SPADCALL |r| '|nthRoot| (QREFELT $ 116))
                  (SEQ (LETT |al| (SPADCALL |r| (QREFELT $ 79)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |al| 2 (QREFELT $ 81))
                                    (SPADCALL 2 (QREFELT $ 61))
                                    (QREFELT $ 117))
                          NIL)
                         (#1='T
                          (SEQ (LETT |a| (SPADCALL |al| 1 (QREFELT $ 81)))
                               (EXIT
                                (NULL
                                 (>
                                  (LENGTH
                                   (|EXPR;algkernels|
                                    (SPADCALL |a| (QREFELT $ 75)) $))
                                  0)))))))))
                 (#1# NIL))))) 

(SDEFUN |EXPR;root_reduce| ((|x| ($)) (|r| (|Kernel| $)) ($ ($)))
        (SPROG
         ((|d1| (|SparseMultivariatePolynomial| R (|Kernel| $)))
          (|n1| (|SparseMultivariatePolynomial| R (|Kernel| $)))
          (|c0| #1=(|SparseMultivariatePolynomial| R (|Kernel| $))) (|c1| #1#)
          (|n0| #2=(|SparseMultivariatePolynomial| R (|Kernel| $)))
          (|dp|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| $))))
          (|dn| (|SparseMultivariatePolynomial| R (|Kernel| $))) (|an| #2#)
          (|a| ($)))
         (SEQ
          (LETT |a| (SPADCALL (SPADCALL |r| (QREFELT $ 79)) 1 (QREFELT $ 81)))
          (LETT |an| (SPADCALL |a| (QREFELT $ 99)))
          (LETT |dn| (SPADCALL |a| (QREFELT $ 101)))
          (LETT |dp|
                (SPADCALL (SPADCALL |x| (QREFELT $ 101)) |r| (QREFELT $ 119)))
          (LETT |n0| (SPADCALL |x| (QREFELT $ 99)))
          (LETT |c1| (SPADCALL |dp| (QREFELT $ 121)))
          (LETT |c0|
                (SPADCALL (SPADCALL |dp| (QREFELT $ 122)) (QREFELT $ 121)))
          (LETT |n1|
                (SPADCALL |dn|
                          (SPADCALL (SPADCALL |c0| |n0| (QREFELT $ 123))
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 103) |r| 1
                                                (QREFELT $ 124))
                                      |c1| (QREFELT $ 123))
                                     |n0| (QREFELT $ 123))
                                    (QREFELT $ 125))
                          (QREFELT $ 123)))
          (LETT |d1|
                (SPADCALL
                 (SPADCALL (SPADCALL |c0| |c0| (QREFELT $ 123)) |dn|
                           (QREFELT $ 123))
                 (SPADCALL (SPADCALL |an| |c1| (QREFELT $ 123)) |c1|
                           (QREFELT $ 123))
                 (QREFELT $ 125)))
          (EXIT
           (|EXPR;reduc| (SPADCALL |n1| |d1| (QREFELT $ 126)) (LIST |r|) $))))) 

(PUT '|EXPR;getSimplifyDenomsFlag;B;35| '|SPADreplace|
     '(XLAM NIL |algreduc_flag|)) 

(SDEFUN |EXPR;getSimplifyDenomsFlag;B;35| (($ (|Boolean|))) |algreduc_flag|) 

(SDEFUN |EXPR;setSimplifyDenomsFlag;2B;36| ((|x| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|res| (|Boolean|)))
               (SEQ (LETT |res| (SPADCALL (QREFELT $ 127)))
                    (SETF |algreduc_flag| |x|) (EXIT |res|)))) 

(SDEFUN |EXPR;algreduc| ((|x| ($)) (|ckl| (|List| (|Kernel| $))) ($ ($)))
        (SPROG
         ((|x1| ($)) (|q| (|SparseUnivariatePolynomial| $)) (#1=#:G862 NIL)
          (|k| NIL) (|sas| (|SingletonAsOrderedSet|)) (#2=#:G861 NIL)
          (|r| (|Kernel| $)) (|akl| (|List| (|Kernel| $))))
         (SEQ
          (EXIT
           (SEQ (LETT |x1| (|EXPR;reduc| |x| |ckl| $))
                (EXIT
                 (COND
                  ((SPADCALL (QREFELT $ 127))
                   (SEQ
                    (LETT |akl|
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 103)
                                     (SPADCALL |x1| (QREFELT $ 101))
                                     (QREFELT $ 126))
                           (QREFELT $ 83)))
                    (EXIT
                     (COND ((EQL (LENGTH |akl|) 0) |x1|)
                           (#3='T
                            (SEQ
                             (COND
                              ((EQL (LENGTH |akl|) 1)
                               (SEQ
                                (LETT |r| (SPADCALL |akl| 1 (QREFELT $ 129)))
                                (EXIT
                                 (COND
                                  ((|EXPR;simple_root| |r| $)
                                   (PROGN
                                    (LETT #2# (|EXPR;root_reduce| |x| |r| $))
                                    (GO #4=#:G860))))))))
                             (LETT |sas| (SPADCALL (QREFELT $ 131)))
                             (SEQ (LETT |k| NIL) (LETT #1# |akl|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |k| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |q|
                                         (SPADCALL |x1| |k|
                                                   (SPADCALL |k|
                                                             (QREFELT $ 132))
                                                   (QREFELT $ 135)))
                                   (EXIT
                                    (LETT |x1|
                                          (SPADCALL
                                           (SPADCALL |q| |sas|
                                                     (SPADCALL |k|
                                                               (QREFELT $ 136))
                                                     (QREFELT $ 137))
                                           (QREFELT $ 138)))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT |x1|)))))))
                  (#3# |x1|)))))
          #4# (EXIT #2#)))) 

(SDEFUN |EXPR;/;2Smp$;38|
        ((|x| (|SparseMultivariatePolynomial| R . #1=((|Kernel| $))))
         (|y| (|SparseMultivariatePolynomial| R . #1#)) ($ ($)))
        (|EXPR;reduc| (SPADCALL |x| |y| (QREFELT $ 126))
         (|EXPR;commonk| (SPADCALL |x| (|spadConstant| $ 103) (QREFELT $ 126))
          (SPADCALL |y| (|spadConstant| $ 103) (QREFELT $ 126)) $)
         $)) 

(SDEFUN |EXPR;reducedSystem;MM;39| ((|m| (|Matrix| $)) ($ (|Matrix| R)))
        (SPROG
         ((|mm| (|Matrix| (|SparseMultivariatePolynomial| R (|Kernel| $)))))
         (SEQ
          (LETT |mm|
                (SPADCALL
                 (SPADCALL (CONS (|function| |EXPR;toprat|) $) |m|
                           (QREFELT $ 142))
                 (QREFELT $ 145)))
          (EXIT (SPADCALL |mm| (QREFELT $ 147)))))) 

(SDEFUN |EXPR;reducedSystem;MVR;40|
        ((|m| (|Matrix| $)) (|v| (|Vector| $))
         ($ (|Record| (|:| |mat| (|Matrix| R)) (|:| |vec| (|Vector| R)))))
        (SPROG
         ((|r|
           (|Record|
            (|:| |mat|
                 (|Matrix| (|SparseMultivariatePolynomial| R (|Kernel| $))))
            (|:| |vec|
                 (|Vector| (|SparseMultivariatePolynomial| R (|Kernel| $)))))))
         (SEQ
          (LETT |r|
                (SPADCALL
                 (SPADCALL (CONS (|function| |EXPR;toprat|) $) |m|
                           (QREFELT $ 142))
                 (SPADCALL (CONS (|function| |EXPR;toprat|) $) |v|
                           (QREFELT $ 150))
                 (QREFELT $ 153)))
          (EXIT (SPADCALL (QCAR |r|) (QCDR |r|) (QREFELT $ 155)))))) 

(SDEFUN |EXPR;commonk0|
        ((|x| (|List| (|Kernel| $))) (|y| (|List| (|Kernel| $)))
         ($ (|List| (|Kernel| $))))
        (SPROG ((|ans| (|List| (|Kernel| $))) (#1=#:G879 NIL) (|k| NIL))
               (SEQ (LETT |ans| NIL)
                    (SEQ (LETT |k| NIL) (LETT #1# (NREVERSE |x|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |k| |y| (QREFELT $ 157))
                             (LETT |ans|
                                   (SPADCALL |k| |ans| (QREFELT $ 158)))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |EXPR;rootOf;SupS$;42|
        ((|x| (|SparseUnivariatePolynomial| $)) (|v| (|Symbol|)) ($ ($)))
        (SPADCALL |x| |v| (QREFELT $ 160))) 

(SDEFUN |EXPR;rootSum;$SupS$;43|
        ((|x| ($)) (|p| (|SparseUnivariatePolynomial| $)) (|v| (|Symbol|))
         ($ ($)))
        (SPADCALL |x| |p| |v| (QREFELT $ 162))) 

(SDEFUN |EXPR;pi;$;44| (($ ($))) (SPADCALL (QREFELT $ 165))) 

(SDEFUN |EXPR;exp;2$;45| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 167))) 

(SDEFUN |EXPR;log;2$;46| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 169))) 

(SDEFUN |EXPR;sin;2$;47| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 171))) 

(SDEFUN |EXPR;cos;2$;48| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 173))) 

(SDEFUN |EXPR;tan;2$;49| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 175))) 

(SDEFUN |EXPR;cot;2$;50| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 177))) 

(SDEFUN |EXPR;sec;2$;51| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 179))) 

(SDEFUN |EXPR;csc;2$;52| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 181))) 

(SDEFUN |EXPR;asin;2$;53| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 183))) 

(SDEFUN |EXPR;acos;2$;54| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 185))) 

(SDEFUN |EXPR;atan;2$;55| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 187))) 

(SDEFUN |EXPR;acot;2$;56| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 189))) 

(SDEFUN |EXPR;asec;2$;57| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 191))) 

(SDEFUN |EXPR;acsc;2$;58| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 193))) 

(SDEFUN |EXPR;sinh;2$;59| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 195))) 

(SDEFUN |EXPR;cosh;2$;60| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 197))) 

(SDEFUN |EXPR;tanh;2$;61| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 199))) 

(SDEFUN |EXPR;coth;2$;62| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 201))) 

(SDEFUN |EXPR;sech;2$;63| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 203))) 

(SDEFUN |EXPR;csch;2$;64| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 205))) 

(SDEFUN |EXPR;asinh;2$;65| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 207))) 

(SDEFUN |EXPR;acosh;2$;66| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 209))) 

(SDEFUN |EXPR;atanh;2$;67| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 211))) 

(SDEFUN |EXPR;acoth;2$;68| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 213))) 

(SDEFUN |EXPR;asech;2$;69| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 215))) 

(SDEFUN |EXPR;acsch;2$;70| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 217))) 

(SDEFUN |EXPR;abs;2$;71| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 220))) 

(SDEFUN |EXPR;conjugate;2$;72| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 222))) 

(SDEFUN |EXPR;Gamma;2$;73| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 224))) 

(SDEFUN |EXPR;Gamma;3$;74| ((|a| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |a| |x| (QREFELT $ 226))) 

(SDEFUN |EXPR;Beta;3$;75| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 228))) 

(SDEFUN |EXPR;digamma;2$;76| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 230))) 

(SDEFUN |EXPR;polygamma;3$;77| ((|k| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |k| |x| (QREFELT $ 232))) 

(SDEFUN |EXPR;besselJ;3$;78| ((|v| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |v| |x| (QREFELT $ 234))) 

(SDEFUN |EXPR;besselY;3$;79| ((|v| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |v| |x| (QREFELT $ 236))) 

(SDEFUN |EXPR;besselI;3$;80| ((|v| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |v| |x| (QREFELT $ 238))) 

(SDEFUN |EXPR;besselK;3$;81| ((|v| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |v| |x| (QREFELT $ 240))) 

(SDEFUN |EXPR;airyAi;2$;82| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 242))) 

(SDEFUN |EXPR;airyAiPrime;2$;83| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 244))) 

(SDEFUN |EXPR;airyBi;2$;84| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 246))) 

(SDEFUN |EXPR;airyBiPrime;2$;85| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 248))) 

(SDEFUN |EXPR;lambertW;2$;86| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 250))) 

(SDEFUN |EXPR;polylog;3$;87| ((|s| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |s| |x| (QREFELT $ 252))) 

(SDEFUN |EXPR;weierstrassP;4$;88| ((|g2| ($)) (|g3| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |g2| |g3| |x| (QREFELT $ 254))) 

(SDEFUN |EXPR;weierstrassPPrime;4$;89|
        ((|g2| ($)) (|g3| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |g2| |g3| |x| (QREFELT $ 256))) 

(SDEFUN |EXPR;weierstrassSigma;4$;90| ((|g2| ($)) (|g3| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |g2| |g3| |x| (QREFELT $ 258))) 

(SDEFUN |EXPR;weierstrassZeta;4$;91| ((|g2| ($)) (|g3| ($)) (|x| ($)) ($ ($)))
        (SPADCALL |g2| |g3| |x| (QREFELT $ 260))) 

(SDEFUN |EXPR;weierstrassPInverse;4$;92|
        ((|g2| ($)) (|g3| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |g2| |g3| |z| (QREFELT $ 262))) 

(SDEFUN |EXPR;whittakerM;4$;93| ((|k| ($)) (|m| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |k| |m| |z| (QREFELT $ 264))) 

(SDEFUN |EXPR;whittakerW;4$;94| ((|k| ($)) (|m| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |k| |m| |z| (QREFELT $ 266))) 

(SDEFUN |EXPR;angerJ;3$;95| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 268))) 

(SDEFUN |EXPR;weberE;3$;96| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 270))) 

(SDEFUN |EXPR;struveH;3$;97| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 272))) 

(SDEFUN |EXPR;struveL;3$;98| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 274))) 

(SDEFUN |EXPR;hankelH1;3$;99| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 276))) 

(SDEFUN |EXPR;hankelH2;3$;100| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 278))) 

(SDEFUN |EXPR;lommelS1;4$;101| ((|mu| ($)) (|nu| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |mu| |nu| |z| (QREFELT $ 280))) 

(SDEFUN |EXPR;lommelS2;4$;102| ((|mu| ($)) (|nu| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |mu| |nu| |z| (QREFELT $ 282))) 

(SDEFUN |EXPR;kummerM;4$;103| ((|mu| ($)) (|nu| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |mu| |nu| |z| (QREFELT $ 284))) 

(SDEFUN |EXPR;kummerU;4$;104| ((|mu| ($)) (|nu| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |mu| |nu| |z| (QREFELT $ 286))) 

(SDEFUN |EXPR;legendreP;4$;105| ((|nu| ($)) (|mu| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |nu| |mu| |z| (QREFELT $ 288))) 

(SDEFUN |EXPR;legendreQ;4$;106| ((|nu| ($)) (|mu| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |nu| |mu| |z| (QREFELT $ 290))) 

(SDEFUN |EXPR;kelvinBei;3$;107| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 292))) 

(SDEFUN |EXPR;kelvinBer;3$;108| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 294))) 

(SDEFUN |EXPR;kelvinKei;3$;109| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 296))) 

(SDEFUN |EXPR;kelvinKer;3$;110| ((|v| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |v| |z| (QREFELT $ 298))) 

(SDEFUN |EXPR;ellipticK;2$;111| ((|m| ($)) ($ ($)))
        (SPADCALL |m| (QREFELT $ 300))) 

(SDEFUN |EXPR;ellipticE;2$;112| ((|m| ($)) ($ ($)))
        (SPADCALL |m| (QREFELT $ 302))) 

(SDEFUN |EXPR;ellipticE;3$;113| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 304))) 

(SDEFUN |EXPR;ellipticF;3$;114| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 306))) 

(SDEFUN |EXPR;ellipticPi;4$;115| ((|z| ($)) (|n| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |n| |m| (QREFELT $ 308))) 

(SDEFUN |EXPR;jacobiSn;3$;116| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 310))) 

(SDEFUN |EXPR;jacobiCn;3$;117| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 312))) 

(SDEFUN |EXPR;jacobiDn;3$;118| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 314))) 

(SDEFUN |EXPR;jacobiZeta;3$;119| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 316))) 

(SDEFUN |EXPR;jacobiTheta;3$;120| ((|z| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |z| |m| (QREFELT $ 318))) 

(SDEFUN |EXPR;lerchPhi;4$;121| ((|z| ($)) (|s| ($)) (|a| ($)) ($ ($)))
        (SPADCALL |z| |s| |a| (QREFELT $ 320))) 

(SDEFUN |EXPR;riemannZeta;2$;122| ((|z| ($)) ($ ($)))
        (SPADCALL |z| (QREFELT $ 322))) 

(SDEFUN |EXPR;charlierC;4$;123| ((|n| ($)) (|a| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |n| |a| |z| (QREFELT $ 324))) 

(SDEFUN |EXPR;hermiteH;3$;124| ((|n| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |n| |z| (QREFELT $ 326))) 

(SDEFUN |EXPR;jacobiP;5$;125| ((|n| ($)) (|a| ($)) (|b| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |n| |a| |b| |z| (QREFELT $ 328))) 

(SDEFUN |EXPR;laguerreL;4$;126| ((|n| ($)) (|a| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |n| |a| |z| (QREFELT $ 330))) 

(SDEFUN |EXPR;meixnerM;5$;127|
        ((|n| ($)) (|b| ($)) (|c| ($)) (|z| ($)) ($ ($)))
        (SPADCALL |n| |b| |c| |z| (QREFELT $ 332))) 

(SDEFUN |EXPR;hypergeometricF;2L2$;128|
        ((|la| #1=(|List| $)) (|lb| #1#) (|x| ($)) ($ ($)))
        (SPADCALL |la| |lb| |x| (QREFELT $ 334))) 

(SDEFUN |EXPR;meijerG;4L2$;129|
        ((|la| #1=(|List| $)) (|lb| #1#) (|lc| #1#) (|ld| #1#) (|x| ($))
         ($ ($)))
        (SPADCALL |la| |lb| |lc| |ld| |x| (QREFELT $ 337))) 

(SDEFUN |EXPR;^;3$;130| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 340))) 

(SDEFUN |EXPR;factorial;2$;131| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 341))) 

(SDEFUN |EXPR;binomial;3$;132| ((|n| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |n| |m| (QREFELT $ 343))) 

(SDEFUN |EXPR;permutation;3$;133| ((|n| ($)) (|m| ($)) ($ ($)))
        (SPADCALL |n| |m| (QREFELT $ 345))) 

(SDEFUN |EXPR;factorials;2$;134| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 347))) 

(SDEFUN |EXPR;factorials;$S$;135| ((|x| ($)) (|n| (|Symbol|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 349))) 

(SDEFUN |EXPR;summation;$S$;136| ((|x| ($)) (|n| (|Symbol|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 351))) 

(SDEFUN |EXPR;summation;$Sb$;137|
        ((|x| ($)) (|s| (|SegmentBinding| $)) ($ ($)))
        (SPADCALL |x| |s| (QREFELT $ 354))) 

(SDEFUN |EXPR;product;$S$;138| ((|x| ($)) (|n| (|Symbol|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 357))) 

(SDEFUN |EXPR;product;$Sb$;139| ((|x| ($)) (|s| (|SegmentBinding| $)) ($ ($)))
        (SPADCALL |x| |s| (QREFELT $ 359))) 

(SDEFUN |EXPR;erf;2$;140| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 362))) 

(SDEFUN |EXPR;erfi;2$;141| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 364))) 

(SDEFUN |EXPR;Ei;2$;142| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 366))) 

(SDEFUN |EXPR;Si;2$;143| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 368))) 

(SDEFUN |EXPR;Ci;2$;144| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 370))) 

(SDEFUN |EXPR;Shi;2$;145| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 372))) 

(SDEFUN |EXPR;Chi;2$;146| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 374))) 

(SDEFUN |EXPR;li;2$;147| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 376))) 

(SDEFUN |EXPR;dilog;2$;148| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 378))) 

(SDEFUN |EXPR;fresnelS;2$;149| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 380))) 

(SDEFUN |EXPR;fresnelC;2$;150| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 382))) 

(SDEFUN |EXPR;integral;$S$;151| ((|x| ($)) (|n| (|Symbol|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 384))) 

(SDEFUN |EXPR;integral;$Sb$;152| ((|x| ($)) (|s| (|SegmentBinding| $)) ($ ($)))
        (SPADCALL |x| |s| (QREFELT $ 386))) 

(SDEFUN |EXPR;operator;2Bo;153| ((|op| #1=(|BasicOperator|)) ($ #1#))
        (SPROG ((|n| (|Union| (|NonNegativeInteger|) "failed")))
               (SEQ
                (COND
                 ((SPADCALL |op| (QREFELT $ 388))
                  (SPADCALL |op| (QREFELT $ 389)))
                 ((SPADCALL |op| (QREFELT $ 390))
                  (SPADCALL |op| (QREFELT $ 391)))
                 ((SPADCALL |op| (QREFELT $ 392))
                  (SPADCALL |op| (QREFELT $ 393)))
                 ((SPADCALL |op| (QREFELT $ 394))
                  (SPADCALL |op| (QREFELT $ 395)))
                 ((SPADCALL |op| (QREFELT $ 396))
                  (SPADCALL |op| (QREFELT $ 397)))
                 ((SPADCALL |op| (QREFELT $ 21))
                  (SPADCALL |op| (QREFELT $ 22)))
                 ((SPADCALL |op| (QREFELT $ 24))
                  (SPADCALL |op| (QREFELT $ 25)))
                 (#2='T
                  (SEQ
                   (COND
                    ((SPADCALL |op| (QREFELT $ 26))
                     (COND
                      ((SPADCALL |op| (QREFELT $ 7) (QREFELT $ 28))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |op| (QREFELT $ 29))
                                   (QREFELT $ 30))
                         (QREFELT $ 31)))))))
                   (LETT |n| (SPADCALL |op| (QREFELT $ 33)))
                   (EXIT
                    (COND
                     ((QEQCAR |n| 1)
                      (SPADCALL (SPADCALL |op| (QREFELT $ 29)) (QREFELT $ 34)))
                     (#2#
                      (SPADCALL (SPADCALL |op| (QREFELT $ 29)) (QCDR |n|)
                                (QREFELT $ 36))))))))))) 

(SDEFUN |EXPR;reduc| ((|x| ($)) (|l| (|List| (|Kernel| $))) ($ ($)))
        (SPROG
         ((|p| (|SparseUnivariatePolynomial| $)) (#1=#:G1010 NIL) (|k| NIL))
         (SEQ
          (SEQ (LETT |k| NIL) (LETT #1# |l|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL)) (GO G191)))
               (SEQ (LETT |p| (SPADCALL |k| (QREFELT $ 132)))
                    (EXIT
                     (LETT |x|
                           (SPADCALL
                            (|EXPR;evl| (SPADCALL |x| (QREFELT $ 99)) |k| |p|
                             $)
                            (|EXPR;evl| (SPADCALL |x| (QREFELT $ 101)) |k| |p|
                             $)
                            (QREFELT $ 68)))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT |x|)))) 

(SDEFUN |EXPR;evl0|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| $)))
         (|k| (|Kernel| $))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseMultivariatePolynomial| R (|Kernel| $))))))
        (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 399)) |k| (QREFELT $ 402))
                  (QREFELT $ 404))) 

(SDEFUN |EXPR;evl|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| $)))
         (|k| (|Kernel| $)) (|m| (|SparseUnivariatePolynomial| $))
         ($ (|Fraction| (|SparseMultivariatePolynomial| R (|Kernel| $)))))
        (COND
         ((< (SPADCALL |p| |k| (QREFELT $ 405)) (SPADCALL |m| (QREFELT $ 406)))
          (SPADCALL |p| (QREFELT $ 399)))
         ('T
          (SPADCALL (SPADCALL (|EXPR;evl0| |p| |k| $) |m| (QREFELT $ 407))
                    (SPADCALL (SPADCALL |k| (QREFELT $ 408)) (QREFELT $ 399))
                    (QREFELT $ 409))))) 

(SDEFUN |EXPR;noalg?| ((|p| (|SparseUnivariatePolynomial| $)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1020 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ G190
                       (COND
                        ((NULL
                          (SPADCALL |p| (|spadConstant| $ 410)
                                    (QREFELT $ 411)))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL
                            (NULL
                             (|EXPR;algkernels|
                              (SPADCALL (SPADCALL |p| (QREFELT $ 412))
                                        (QREFELT $ 75))
                              $)))
                           (PROGN (LETT #1# NIL) (GO #2=#:G1019)))
                          ('T (LETT |p| (SPADCALL |p| (QREFELT $ 413)))))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |EXPR;algkers|
        ((|p| (|SparseUnivariatePolynomial| $)) ($ (|List| (|Kernel| $))))
        (SPROG ((|res| (|List| (|Kernel| $))) (|lc| ($)))
               (SEQ (LETT |res| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 410)
                                      (QREFELT $ 411)))
                           (GO G191)))
                         (SEQ (LETT |lc| (SPADCALL |p| (QREFELT $ 412)))
                              (LETT |res|
                                    (SPADCALL (SPADCALL |lc| (QREFELT $ 83))
                                              |res| (QREFELT $ 414)))
                              (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 413)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |res| (QREFELT $ 415)))))) 

(SDEFUN |EXPR;algpars| ((|lk| (|List| (|Kernel| $))) ($ (|List| (|Kernel| $))))
        (SPROG
         ((|res| (|List| (|Kernel| $))) (|arg| (|List| $)) (#1=#:G1033 NIL)
          (|k| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |k| NIL) (LETT #1# |lk|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((NULL (SPADCALL |k| '|nthRoot| (QREFELT $ 116)))
                      (COND
                       ((NULL (SPADCALL |k| '|rootOf| (QREFELT $ 116)))
                        (EXIT (|error| "apars: unknown kernel"))))))
                    (LETT |arg| (SPADCALL |k| (QREFELT $ 79)))
                    (EXIT
                     (LETT |res|
                           (SPADCALL
                            (SPADCALL (SPADCALL |arg| 1 (QREFELT $ 81))
                                      (QREFELT $ 75))
                            |res| (QREFELT $ 414)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |res| (QREFELT $ 415)))))) 

(SDEFUN |EXPR;trivial_denoms|
        ((|p| (|SparseUnivariatePolynomial| $)) ($ (|Boolean|)))
        (SPADCALL (CONS #'|EXPR;trivial_denoms!0| $)
                  (SPADCALL |p| (QREFELT $ 417)) (QREFELT $ 419))) 

(SDEFUN |EXPR;trivial_denoms!0| ((|c| NIL) ($ NIL))
        (SPADCALL (SPADCALL |c| (QREFELT $ 101)) (|spadConstant| $ 103)
                  (QREFELT $ 416))) 

(SDEFUN |EXPR;SUP_to_SUPP|
        ((|p| (|SparseUnivariatePolynomial| $))
         ($
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| $)))))
        (SPADCALL (ELT $ 99) |p| (QREFELT $ 422))) 

(SDEFUN |EXPR;def_poly|
        ((|k| (|Kernel| $))
         ($
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| $)))))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (#1=#:G1044 NIL)
          (|p1| (|SparseMultivariatePolynomial| R (|Kernel| $))) (|arg2| ($))
          (|arg1| ($)) (|args| (|List| $)))
         (SEQ (LETT |args| (SPADCALL |k| (QREFELT $ 79)))
              (LETT |arg1| (SPADCALL |args| (QREFELT $ 85)))
              (LETT |arg2| (SPADCALL |args| 2 (QREFELT $ 81)))
              (EXIT
               (COND
                ((SPADCALL |k| '|rootOf| (QREFELT $ 116))
                 (SEQ (LETT |p1| (SPADCALL |arg1| (QREFELT $ 99)))
                      (EXIT
                       (SPADCALL |p1| (SPADCALL |arg2| (QREFELT $ 13))
                                 (QREFELT $ 119)))))
                ((SPADCALL |k| '|nthRoot| (QREFELT $ 116))
                 (SEQ
                  (LETT |n|
                        (PROG1 (LETT #1# (SPADCALL |arg2| (QREFELT $ 423)))
                          (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #1#)))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL |arg1| (QREFELT $ 101)) |n|
                              (QREFELT $ 424))
                    (SPADCALL (SPADCALL |arg1| (QREFELT $ 99)) (QREFELT $ 425))
                    (QREFELT $ 426)))))
                ('T (|error| "def_poly : unknown kernel"))))))) 

(SDEFUN |EXPR;varmap1|
        ((|k0| (|Kernel| $)) (|lk| (|List| (|Kernel| $)))
         (|ls| (|List| (|Symbol|))) ($ (|Symbol|)))
        (SPROG
         ((#1=#:G1053 NIL) (#2=#:G1054 NIL) (|k| NIL) (#3=#:G1055 NIL)
          (|s| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |s| NIL) (LETT #3# |ls|) (LETT |k| NIL) (LETT #2# |lk|)
                 G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL) (ATOM #3#)
                       (PROGN (LETT |s| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |k| |k0| (QREFELT $ 427))
                     (PROGN (LETT #1# |s|) (GO #4=#:G1052))))))
                 (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                 G191 (EXIT NIL))
            (EXIT (|error| "varmap1: kernel not on the list"))))
          #4# (EXIT #1#)))) 

(SDEFUN |EXPR;varmap2|
        ((|s0| (|Symbol|)) (|lk| (|List| (|Kernel| $)))
         (|ls| (|List| (|Symbol|))) ($ (|Kernel| $)))
        (SPROG
         ((#1=#:G1067 NIL) (#2=#:G1068 NIL) (|k| NIL) (#3=#:G1069 NIL)
          (|s| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |s| NIL) (LETT #3# |ls|) (LETT |k| NIL) (LETT #2# |lk|)
                 G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL) (ATOM #3#)
                       (PROGN (LETT |s| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((EQUAL |s| |s0|)
                     (PROGN (LETT #1# |k|) (GO #4=#:G1066))))))
                 (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                 G191 (EXIT NIL))
            (EXIT (|error| "varmap2: symbol not on the list"))))
          #4# (EXIT #1#)))) 

(SDEFUN |EXPR;MP_to_PI|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| $)))
         (|lk| (|List| (|Kernel| $))) (|ls| (|List| (|Symbol|)))
         ($ (|Polynomial| (|Integer|))))
        (SPROG NIL
               (SPADCALL (CONS #'|EXPR;MP_to_PI!0| (VECTOR |ls| |lk| $))
                         (ELT $ 432) |p| (QREFELT $ 436)))) 

(SDEFUN |EXPR;MP_to_PI!0| ((|k| NIL) ($$ NIL))
        (PROG ($ |lk| |ls|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lk| (QREFELT $$ 1))
          (LETT |ls| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|spadConstant| $ 429) (|EXPR;varmap1| |k| |lk| |ls| $)
                      (|spadConstant| $ 430) (QREFELT $ 431)))))) 

(SDEFUN |EXPR;SUPP_to_PI|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| $))))
         (|lk| (|List| (|Kernel| $))) (|ls| (|List| (|Symbol|)))
         (|xk| (|Kernel| $)) ($ (|Polynomial| (|Integer|))))
        (SPROG ((|p2| (|SparseMultivariatePolynomial| R (|Kernel| $))))
               (SEQ (LETT |p2| (SPADCALL |p| |xk| (QREFELT $ 437)))
                    (EXIT (|EXPR;MP_to_PI| |p2| |lk| |ls| $))))) 

(SDEFUN |EXPR;SUP_to_PI|
        ((|p| (|SparseUnivariatePolynomial| $)) (|lk| (|List| (|Kernel| $)))
         (|ls| (|List| (|Symbol|))) (|xk| (|Kernel| $))
         ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|p1|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| $)))))
         (SEQ (LETT |p1| (|EXPR;SUP_to_SUPP| |p| $))
              (EXIT (|EXPR;SUPP_to_PI| |p1| |lk| |ls| |xk| $))))) 

(SDEFUN |EXPR;PI_to_SUP|
        ((|p| (|Polynomial| (|Integer|))) (|lk| (|List| (|Kernel| $)))
         (|ls| (|List| (|Symbol|))) (|xk| (|Kernel| $))
         ($ (|SparseUnivariatePolynomial| $)))
        (SPROG
         ((|p3| (|SparseUnivariatePolynomial| $))
          (|p2|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| $))))
          (|p1| (|SparseMultivariatePolynomial| R (|Kernel| $))))
         (SEQ
          (LETT |p1|
                (SPADCALL (CONS #'|EXPR;PI_to_SUP!0| (VECTOR |ls| |lk| $))
                          (ELT $ 441) |p| (QREFELT $ 445)))
          (LETT |p2| (SPADCALL |p1| |xk| (QREFELT $ 119)))
          (EXIT (LETT |p3| (SPADCALL (ELT $ 104) |p2| (QREFELT $ 448))))))) 

(SDEFUN |EXPR;PI_to_SUP!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |lk| |ls|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lk| (QREFELT $$ 1))
          (LETT |ls| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|spadConstant| $ 103) (|EXPR;varmap2| |s| |lk| |ls| $)
                      (|spadConstant| $ 430) (QREFELT $ 124)))))) 

(SDEFUN |EXPR;to_RF|
        ((|c| ($)) (|lk| (|List| (|Kernel| $))) (|ls| (|List| (|Symbol|)))
         ($ (|Fraction| (|Polynomial| (|Integer|)))))
        (SPADCALL (|EXPR;MP_to_PI| (SPADCALL |c| (QREFELT $ 99)) |lk| |ls| $)
                  (|EXPR;MP_to_PI| (SPADCALL |c| (QREFELT $ 101)) |lk| |ls| $)
                  (QREFELT $ 453))) 

(SDEFUN |EXPR;SUPP_to_PT|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| $))))
         (|lk| (|List| (|Kernel| $))) (|ls| (|List| (|Symbol|)))
         (|k| (|Kernel| $)) (|s| (|Symbol|))
         ($
          (|Record| (|:| |var| (|Symbol|))
                    (|:| |coef|
                         (|SparseUnivariatePolynomial|
                          (|Fraction| (|Polynomial| (|Integer|))))))))
        (SPROG
         ((|up|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (|p2| (|SparseMultivariatePolynomial| R (|Kernel| $))))
         (SEQ (LETT |p2| (SPADCALL |p| |k| (QREFELT $ 437)))
              (LETT |up|
                    (SPADCALL
                     (SPADCALL (|EXPR;MP_to_PI| |p2| |lk| |ls| $)
                               (QREFELT $ 454))
                     (QREFELT $ 456)))
              (EXIT (CONS |s| |up|))))) 

(SDEFUN |EXPR;SUP_to_PT|
        ((|p| (|SparseUnivariatePolynomial| $)) (|lk| (|List| (|Kernel| $)))
         (|ls| (|List| (|Symbol|))) (|s| (|Symbol|))
         ($
          (|Record| (|:| |var| (|Symbol|))
                    (|:| |coef|
                         (|SparseUnivariatePolynomial|
                          (|Fraction| (|Polynomial| (|Integer|))))))))
        (SPROG
         ((|up|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|))))))
         (SEQ
          (LETT |up|
                (SPADCALL (CONS #'|EXPR;SUP_to_PT!0| (VECTOR $ |ls| |lk|)) |p|
                          (QREFELT $ 459)))
          (EXIT (CONS |s| |up|))))) 

(SDEFUN |EXPR;SUP_to_PT!0| ((|c| NIL) ($$ NIL))
        (PROG (|lk| |ls| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |ls| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|EXPR;to_RF| |c| |lk| |ls| $))))) 

(SDEFUN |EXPR;gcdPolynomial;3Sup;172|
        ((|p| #1=(|SparseUnivariatePolynomial| $)) (|q| #1#) ($ #1#))
        (SPROG
         ((|g2| (|Polynomial| (|Integer|)))
          (|lm2|
           (|List|
            (|Record| (|:| |var| (|Symbol|))
                      (|:| |coef|
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|Polynomial| (|Integer|))))))))
          (#2=#:G1127 NIL) (|m| NIL) (#3=#:G1128 NIL) (|k| NIL)
          (#4=#:G1126 NIL)
          (|q2|
           #5=(|Record| (|:| |var| (|Symbol|))
                        (|:| |coef|
                             (|SparseUnivariatePolynomial|
                              (|Fraction| (|Polynomial| (|Integer|)))))))
          (|p2| #5#) (|g1| (|Polynomial| (|Integer|)))
          (|p_syms| (|List| (|Symbol|))) (|a_syms| (|List| (|Symbol|)))
          (#6=#:G1125 NIL) (#7=#:G1124 NIL)
          (|lm1| (|List| (|Polynomial| (|Integer|)))) (#8=#:G1122 NIL)
          (#9=#:G1123 NIL) (#10=#:G1121 NIL)
          (|q1| #11=(|Polynomial| (|Integer|))) (|p1| #11#) (#12=#:G1120 NIL)
          (#13=#:G1119 NIL)
          (|lm|
           (|List|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| R (|Kernel| $)))))
          (#14=#:G1118 NIL) (#15=#:G1117 NIL) (|all_syms| (|List| (|Symbol|)))
          (|all_kers| (|List| (|Kernel| $))) (|xk| (|Kernel| $))
          (|x| #16=(|Symbol|)) (|all_syms0| (|List| #16#)) (#17=#:G1116 NIL)
          (#18=#:G1115 NIL) (|akers| (|List| (|Kernel| $)))
          (|all_kers0| (|List| (|Kernel| $))) (|apars| (|List| (|Kernel| $)))
          (|cl| (|List| $)))
         (SEQ
          (COND ((SPADCALL |p| (|spadConstant| $ 410) (QREFELT $ 460)) |q|)
                ((EQL (SPADCALL |p| (QREFELT $ 406)) 0) (|spadConstant| $ 461))
                ((SPADCALL |q| (|spadConstant| $ 410) (QREFELT $ 460)) |p|)
                (#19='T
                 (COND
                  ((EQL (SPADCALL |q| (QREFELT $ 406)) 0)
                   (|spadConstant| $ 461))
                  (#19#
                   (SEQ
                    (COND
                     ((|EXPR;noalg?| |p| $)
                      (COND
                       ((|EXPR;noalg?| |q| $)
                        (EXIT (SPADCALL |p| |q| (QREFELT $ 462)))))))
                    (LETT |cl|
                          (SPADCALL (SPADCALL |p| (QREFELT $ 417))
                                    (SPADCALL |q| (QREFELT $ 417))
                                    (QREFELT $ 463)))
                    (LETT |akers| (SPADCALL |cl| (QREFELT $ 464)))
                    (LETT |apars| (|EXPR;algpars| |akers| $))
                    (LETT |all_kers0|
                          (SPADCALL (SPADCALL |cl| (QREFELT $ 465)) |apars|
                                    (QREFELT $ 466)))
                    (LETT |akers| (REVERSE (SPADCALL |akers| (QREFELT $ 467))))
                    (LETT |all_syms0|
                          (PROGN
                           (LETT #18# NIL)
                           (SEQ (LETT |k| NIL) (LETT #17# |all_kers0|) G190
                                (COND
                                 ((OR (ATOM #17#)
                                      (PROGN (LETT |k| (CAR #17#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #18#
                                        (CONS (SPADCALL (QREFELT $ 468))
                                              #18#))))
                                (LETT #17# (CDR #17#)) (GO G190) G191
                                (EXIT (NREVERSE #18#)))))
                    (LETT |x| (SPADCALL (QREFELT $ 468)))
                    (LETT |xk| (SPADCALL |x| (QREFELT $ 30)))
                    (LETT |all_kers|
                          (SPADCALL |xk| |all_kers0| (QREFELT $ 469)))
                    (LETT |all_syms| (CONS |x| |all_syms0|))
                    (LETT |lm|
                          (PROGN
                           (LETT #15# NIL)
                           (SEQ (LETT |k| NIL) (LETT #14# |akers|) G190
                                (COND
                                 ((OR (ATOM #14#)
                                      (PROGN (LETT |k| (CAR #14#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #15#
                                        (CONS (|EXPR;def_poly| |k| $) #15#))))
                                (LETT #14# (CDR #14#)) (GO G190) G191
                                (EXIT (NREVERSE #15#)))))
                    (LETT |a_syms|
                          (PROGN
                           (LETT #13# NIL)
                           (SEQ (LETT |k| NIL) (LETT #12# |akers|) G190
                                (COND
                                 ((OR (ATOM #12#)
                                      (PROGN (LETT |k| (CAR #12#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #13#
                                        (CONS
                                         (|EXPR;varmap1| |k| |all_kers|
                                          |all_syms| $)
                                         #13#))))
                                (LETT #12# (CDR #12#)) (GO G190) G191
                                (EXIT (NREVERSE #13#)))))
                    (LETT |p_syms|
                          (SPADCALL |all_syms0| |a_syms| (QREFELT $ 470)))
                    (COND
                     ((|EXPR;trivial_denoms| |p| $)
                      (COND
                       ((|EXPR;trivial_denoms| |q| $)
                        (EXIT
                         (SEQ
                          (LETT |p1|
                                (|EXPR;SUP_to_PI| |p| |all_kers| |all_syms|
                                 |xk| $))
                          (LETT |q1|
                                (|EXPR;SUP_to_PI| |q| |all_kers| |all_syms|
                                 |xk| $))
                          (LETT |lm1|
                                (PROGN
                                 (LETT #10# NIL)
                                 (SEQ (LETT |k| NIL) (LETT #9# |akers|)
                                      (LETT |m| NIL) (LETT #8# |lm|) G190
                                      (COND
                                       ((OR (ATOM #8#)
                                            (PROGN (LETT |m| (CAR #8#)) NIL)
                                            (ATOM #9#)
                                            (PROGN (LETT |k| (CAR #9#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #10#
                                              (CONS
                                               (|EXPR;SUPP_to_PI| |m|
                                                |all_kers| |all_syms| |k| $)
                                               #10#))))
                                      (LETT #8#
                                            (PROG1 (CDR #8#)
                                              (LETT #9# (CDR #9#))))
                                      (GO G190) G191 (EXIT (NREVERSE #10#)))))
                          (LETT |a_syms|
                                (PROGN
                                 (LETT #7# NIL)
                                 (SEQ (LETT |k| NIL) (LETT #6# |akers|) G190
                                      (COND
                                       ((OR (ATOM #6#)
                                            (PROGN (LETT |k| (CAR #6#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #7#
                                              (CONS
                                               (|EXPR;varmap1| |k| |all_kers|
                                                |all_syms| $)
                                               #7#))))
                                      (LETT #6# (CDR #6#)) (GO G190) G191
                                      (EXIT (NREVERSE #7#)))))
                          (LETT |p_syms|
                                (SPADCALL |all_syms0| |a_syms|
                                          (QREFELT $ 470)))
                          (LETT |g1|
                                (SPADCALL |p1| |q1| |lm1| |p_syms| |x| |a_syms|
                                          (QREFELT $ 472)))
                          (EXIT
                           (|EXPR;PI_to_SUP| |g1| |all_kers| |all_syms| |xk|
                            $))))))))
                    (LETT |p2|
                          (|EXPR;SUP_to_PT| |p| |all_kers0| |all_syms0| |x| $))
                    (LETT |q2|
                          (|EXPR;SUP_to_PT| |q| |all_kers0| |all_syms0| |x| $))
                    (LETT |lm2|
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |k| NIL) (LETT #3# |akers|)
                                (LETT |m| NIL) (LETT #2# |lm|) G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |m| (CAR #2#)) NIL)
                                      (ATOM #3#)
                                      (PROGN (LETT |k| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #4#
                                        (CONS
                                         (|EXPR;SUPP_to_PT| |m| |all_kers0|
                                          |all_syms0| |k| |x| $)
                                         #4#))))
                                (LETT #2#
                                      (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                                (GO G190) G191 (EXIT (NREVERSE #4#)))))
                    (LETT |g2|
                          (SPADCALL |p2| |q2| |lm2| |p_syms| |x| |a_syms|
                                    (QREFELT $ 475)))
                    (EXIT
                     (|EXPR;PI_to_SUP| |g2| |all_kers| |all_syms| |xk|
                      $)))))))))) 

(SDEFUN |EXPR;gcdPolynomial;3Sup;173|
        ((|p| #1=(|SparseUnivariatePolynomial| $)) (|q| #1#) ($ #1#))
        (SEQ
         (COND
          ((|EXPR;noalg?| |p| $)
           (COND
            ((|EXPR;noalg?| |q| $)
             (EXIT (SPADCALL |p| |q| (QREFELT $ 462)))))))
         (EXIT (SPADCALL |p| |q| (QREFELT $ 478))))) 

(SDEFUN |EXPR;factorPolynomial;SupF;174|
        ((|x| (|SparseUnivariatePolynomial| $))
         ($ (|Factored| (|SparseUnivariatePolynomial| $))))
        (SPADCALL |x| (QREFELT $ 481))) 

(SDEFUN |EXPR;coerce;An$;175| ((|x| (|AlgebraicNumber|)) ($ ($)))
        (SPADCALL (SPADCALL |x| (|spadConstant| $ 485) (QREFELT $ 486))
                  (QREFELT $ 104))) 

(SDEFUN |EXPR;^;$F$;176| ((|x| ($)) (|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL |x| |r| (QREFELT $ 490))) 

(SDEFUN |EXPR;minPoly;KSup;177|
        ((|k| (|Kernel| $)) ($ (|SparseUnivariatePolynomial| $)))
        (SPADCALL |k| (QREFELT $ 492))) 

(SDEFUN |EXPR;definingPolynomial;2$;178| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 493))) 

(SDEFUN |EXPR;retract;$F;179| ((|x| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL |x| (QREFELT $ 495))) 

(SDEFUN |EXPR;retractIfCan;$U;180|
        ((|x| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPADCALL |x| (QREFELT $ 497))) 

(SDEFUN |EXPR;coerce;An$;181| ((|x| (|AlgebraicNumber|)) ($ ($)))
        (SPADCALL (|EXPR;smp2expr| (SPADCALL |x| (QREFELT $ 499)) $)
                  (|EXPR;smp2expr| (SPADCALL |x| (QREFELT $ 500)) $)
                  (QREFELT $ 69))) 

(SDEFUN |EXPR;k2expr| ((|k| (|Kernel| (|AlgebraicNumber|))) ($ ($)))
        (SPADCALL (ELT $ 488) |k| (QREFELT $ 504))) 

(SDEFUN |EXPR;smp2expr|
        ((|p|
          (|SparseMultivariatePolynomial| (|Integer|)
                                          (|Kernel| (|AlgebraicNumber|))))
         ($ ($)))
        (SPADCALL (CONS (|function| |EXPR;k2expr|) $) (ELT $ 61) |p|
                  (QREFELT $ 509))) 

(SDEFUN |EXPR;retractIfCan;$U;184|
        ((|x| ($)) ($ (|Union| (|AlgebraicNumber|) "failed")))
        (SPROG
         ((#1=#:G1167 NIL) (|d| #2=(|Union| (|AlgebraicNumber|) "failed"))
          (|n| #2#))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |n| (|EXPR;smp2an| (SPADCALL |x| (QREFELT $ 99)) $))
                 (EXIT
                  (COND
                   ((QEQCAR |n| 0)
                    (SEQ
                     (LETT |d|
                           (|EXPR;smp2an| (SPADCALL |x| (QREFELT $ 101)) $))
                     (EXIT
                      (COND
                       ((QEQCAR |d| 0)
                        (PROGN
                         (LETT #1#
                               (CONS 0
                                     (SPADCALL (QCDR |n|) (QCDR |d|)
                                               (QREFELT $ 510))))
                         (GO #3=#:G1162))))))))))
            (EXIT (CONS 1 "failed"))))
          #3# (EXIT #1#)))) 

(SDEFUN |EXPR;R2AN| ((|r| (R)) ($ (|Union| (|AlgebraicNumber|) "failed")))
        (SPROG ((|u| (|Union| (|Fraction| (|Integer|)) "failed")))
               (SEQ
                (LETT |u|
                      (SPADCALL (SPADCALL |r| (QREFELT $ 513)) (QREFELT $ 72)))
                (EXIT
                 (COND
                  ((QEQCAR |u| 0)
                   (CONS 0 (SPADCALL (QCDR |u|) (QREFELT $ 514))))
                  ('T (CONS 1 "failed"))))))) 

(SDEFUN |EXPR;k2an|
        ((|k| (|Kernel| $)) ($ (|Union| (|AlgebraicNumber|) "failed")))
        (SPROG
         ((|arg| (|List| (|AlgebraicNumber|))) (#1=#:G1201 NIL)
          (|a| #2=(|Union| (|AlgebraicNumber|) #3="failed")) (#4=#:G1202 NIL)
          (|x| NIL)
          (|eq|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| $))))
          (|eqa| (|SparseUnivariatePolynomial| (|AlgebraicNumber|)))
          (|ccu| #2#) (|cc| ($)) (|a1| ($)) (|s1| (|Symbol|))
          (|s1u| (|Union| (|Symbol|) #3#)) (|k1| (|Kernel| $))
          (|k1u| (|Union| (|Kernel| $) #3#)) (|a2| ($)) (|args| (|List| $))
          (|op| (|BasicOperator|)))
         (SEQ
          (EXIT
           (COND
            ((NULL
              (SPADCALL (LETT |op| (SPADCALL |k| (QREFELT $ 31)))
                        (QREFELT $ 515)))
             (CONS 1 "failed"))
            ('T
             (COND
              ((SPADCALL |op| '|rootOf| (QREFELT $ 516))
               (SEQ (LETT |args| (SPADCALL |k| (QREFELT $ 79)))
                    (LETT |a2| (SPADCALL |args| 2 (QREFELT $ 81)))
                    (LETT |k1u| (SPADCALL |a2| (QREFELT $ 19)))
                    (EXIT
                     (COND ((QEQCAR |k1u| 1) (CONS 1 "failed"))
                           (#5='T
                            (SEQ (LETT |k1| (QCDR |k1u|))
                                 (LETT |s1u| (SPADCALL |a2| (QREFELT $ 518)))
                                 (EXIT
                                  (COND ((QEQCAR |s1u| 1) (CONS 1 "failed"))
                                        (#5#
                                         (SEQ (LETT |s1| (QCDR |s1u|))
                                              (LETT |a1|
                                                    (SPADCALL |args| 1
                                                              (QREFELT $ 81)))
                                              (EXIT
                                               (COND
                                                ((SPADCALL
                                                  (SPADCALL |a1|
                                                            (QREFELT $ 101))
                                                  (|spadConstant| $ 103)
                                                  (QREFELT $ 519))
                                                 (|error|
                                                  "Bad argument to rootOf"))
                                                (#5#
                                                 (SEQ
                                                  (LETT |eq|
                                                        (SPADCALL
                                                         (SPADCALL |a1|
                                                                   (QREFELT $
                                                                            99))
                                                         |k1| (QREFELT $ 119)))
                                                  (LETT |eqa|
                                                        (|spadConstant| $ 521))
                                                  (SEQ G190
                                                       (COND
                                                        ((NULL
                                                          (SPADCALL |eq|
                                                                    (|spadConstant|
                                                                     $ 522)
                                                                    (QREFELT $
                                                                             523)))
                                                         (GO G191)))
                                                       (SEQ
                                                        (LETT |cc|
                                                              (SPADCALL
                                                               (SPADCALL |eq|
                                                                         (QREFELT
                                                                          $
                                                                          121))
                                                               (QREFELT $
                                                                        104)))
                                                        (LETT |ccu|
                                                              (SPADCALL |cc|
                                                                        (QREFELT
                                                                         $
                                                                         512)))
                                                        (EXIT
                                                         (COND
                                                          ((QEQCAR |ccu| 1)
                                                           (PROGN
                                                            (LETT #1#
                                                                  (CONS 1
                                                                        "failed"))
                                                            (GO #6=#:G1200)))
                                                          ('T
                                                           (SEQ
                                                            (LETT |eqa|
                                                                  (SPADCALL
                                                                   |eqa|
                                                                   (SPADCALL
                                                                    (QCDR
                                                                     |ccu|)
                                                                    (SPADCALL
                                                                     |eq|
                                                                     (QREFELT $
                                                                              524))
                                                                    (QREFELT $
                                                                             525))
                                                                   (QREFELT $
                                                                            526)))
                                                            (EXIT
                                                             (LETT |eq|
                                                                   (SPADCALL
                                                                    |eq|
                                                                    (QREFELT $
                                                                             122)))))))))
                                                       NIL (GO G190) G191
                                                       (EXIT NIL))
                                                  (EXIT
                                                   (CONS 0
                                                         (SPADCALL |eqa| |s1|
                                                                   (QREFELT $
                                                                            527))))))))))))))))))
              (#5#
               (SEQ (LETT |arg| NIL)
                    (SEQ (LETT |x| NIL)
                         (LETT #4# (SPADCALL |k| (QREFELT $ 79))) G190
                         (COND
                          ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |a| (SPADCALL |x| (QREFELT $ 512)))
                              (EXIT
                               (COND
                                ((QEQCAR |a| 1)
                                 (PROGN (LETT #1# (CONS 1 "failed")) (GO #6#)))
                                ('T (LETT |arg| (CONS (QCDR |a|) |arg|))))))
                         (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (CONS 0
                           (SPADCALL (SPADCALL |op| (QREFELT $ 528))
                                     (NREVERSE |arg|) (QREFELT $ 529))))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |EXPR;smp2an|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| $)))
         ($ (|Union| (|AlgebraicNumber|) #1="failed")))
        (SPROG
         ((|c| (|Union| (|AlgebraicNumber|) #1#))
          (|up|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| $))))
          (|ans| (|AlgebraicNumber|)) (#2=#:G1218 NIL)
          (|t| (|Union| (|AlgebraicNumber|) "failed")) (|k| (|Kernel| $))
          (|x1| (|Union| (|Kernel| $) "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |x1| (SPADCALL |p| (QREFELT $ 531)))
                (EXIT
                 (COND
                  ((QEQCAR |x1| 1)
                   (|EXPR;R2AN| (SPADCALL |p| (QREFELT $ 532)) $))
                  (#3='T
                   (SEQ
                    (LETT |up|
                          (SPADCALL |p| (LETT |k| (QCDR |x1|))
                                    (QREFELT $ 119)))
                    (LETT |t| (|EXPR;k2an| |k| $))
                    (EXIT
                     (COND ((QEQCAR |t| 1) (CONS 1 "failed"))
                           (#3#
                            (SEQ (LETT |ans| (|spadConstant| $ 533))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (NULL
                                          (SPADCALL |up| (QREFELT $ 534))))
                                        (GO G191)))
                                      (SEQ
                                       (LETT |c|
                                             (|EXPR;smp2an|
                                              (SPADCALL |up| (QREFELT $ 121))
                                              $))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |c| 1)
                                          (PROGN
                                           (LETT #2# (CONS 1 "failed"))
                                           (GO #4=#:G1217)))
                                         ('T
                                          (SEQ
                                           (LETT |ans|
                                                 (SPADCALL |ans|
                                                           (SPADCALL (QCDR |c|)
                                                                     (SPADCALL
                                                                      (QCDR
                                                                       |t|)
                                                                      (SPADCALL
                                                                       |up|
                                                                       (QREFELT
                                                                        $ 524))
                                                                      (QREFELT
                                                                       $ 535))
                                                                     (QREFELT $
                                                                              536))
                                                           (QREFELT $ 537)))
                                           (EXIT
                                            (LETT |up|
                                                  (SPADCALL |up|
                                                            (QREFELT $
                                                                     122)))))))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (LETT |c|
                                       (|EXPR;smp2an|
                                        (SPADCALL |up| (QREFELT $ 121)) $))
                                 (EXIT
                                  (COND ((QEQCAR |c| 1) (CONS 1 "failed"))
                                        (#3#
                                         (CONS 0
                                               (SPADCALL |ans| (QCDR |c|)
                                                         (QREFELT $
                                                                  537))))))))))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |EXPR;convert;$If;188| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL |x| (QREFELT $ 539))) 

(SDEFUN |EXPR;eval;$Bo$S$;189|
        ((|f| ($)) (|op| (|BasicOperator|)) (|g| ($)) (|x| (|Symbol|)) ($ ($)))
        (SPADCALL |f| (LIST |op|) (LIST |g|) |x| (QREFELT $ 542))) 

(SDEFUN |EXPR;eval;$LLS$;190|
        ((|f| ($)) (|ls| (|List| (|BasicOperator|))) (|lg| (|List| $))
         (|x| (|Symbol|)) ($ ($)))
        (SPROG
         ((|res| ($)) (#1=#:G1256 NIL) (|g| NIL) (#2=#:G1255 NIL)
          (|nlg| (|List| $)) (#3=#:G1254 NIL) (#4=#:G1253 NIL)
          (|lbackwardSubs| (|List| (|Equation| $))) (#5=#:G1251 NIL) (|i| NIL)
          (#6=#:G1252 NIL) (|j| NIL) (#7=#:G1250 NIL)
          (|lforwardSubs| (|List| (|Equation| $))) (#8=#:G1248 NIL)
          (#9=#:G1249 NIL) (#10=#:G1247 NIL) (|ns| (|List| (|Symbol|)))
          (#11=#:G1246 NIL) (#12=#:G1245 NIL) (#13=#:G1244 NIL)
          (#14=#:G1243 NIL) (|lsd| (|List| (|Symbol|)))
          (|lsym| (|List| (|Symbol|))) (|llsym| (|List| (|List| (|Symbol|))))
          (#15=#:G1242 NIL) (#16=#:G1241 NIL))
         (SEQ
          (LETT |llsym|
                (PROGN
                 (LETT #16# NIL)
                 (SEQ (LETT |g| NIL) (LETT #15# |lg|) G190
                      (COND
                       ((OR (ATOM #15#) (PROGN (LETT |g| (CAR #15#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #16#
                              (CONS (SPADCALL |g| (QREFELT $ 544)) #16#))))
                      (LETT #15# (CDR #15#)) (GO G190) G191
                      (EXIT (NREVERSE #16#)))))
          (LETT |lsym|
                (SPADCALL (SPADCALL |llsym| (QREFELT $ 545)) (QREFELT $ 546)))
          (LETT |lsd| (SPADCALL (ELT $ 547) |lsym| (QREFELT $ 549)))
          (EXIT
           (COND
            ((NULL |lsd|)
             (SPADCALL |f| |ls|
                       (PROGN
                        (LETT #14# NIL)
                        (SEQ (LETT |g| NIL) (LETT #13# |lg|) G190
                             (COND
                              ((OR (ATOM #13#)
                                   (PROGN (LETT |g| (CAR #13#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #14#
                                     (CONS (SPADCALL |g| |x| (QREFELT $ 551))
                                           #14#))))
                             (LETT #13# (CDR #13#)) (GO G190) G191
                             (EXIT (NREVERSE #14#))))
                       (QREFELT $ 554)))
            ('T
             (SEQ
              (LETT |ns|
                    (PROGN
                     (LETT #12# NIL)
                     (SEQ (LETT |i| NIL) (LETT #11# |lsd|) G190
                          (COND
                           ((OR (ATOM #11#) (PROGN (LETT |i| (CAR #11#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #12#
                                  (CONS (SPADCALL (QREFELT $ 468)) #12#))))
                          (LETT #11# (CDR #11#)) (GO G190) G191
                          (EXIT (NREVERSE #12#)))))
              (LETT |lforwardSubs|
                    (PROGN
                     (LETT #10# NIL)
                     (SEQ (LETT |j| NIL) (LETT #9# |ns|) (LETT |i| NIL)
                          (LETT #8# |lsd|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |i| (CAR #8#)) NIL)
                                (ATOM #9#) (PROGN (LETT |j| (CAR #9#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #10#
                                  (CONS
                                   (SPADCALL (SPADCALL |i| (QREFELT $ 555))
                                             (SPADCALL |j| (QREFELT $ 555))
                                             (QREFELT $ 557))
                                   #10#))))
                          (LETT #8# (PROG1 (CDR #8#) (LETT #9# (CDR #9#))))
                          (GO G190) G191 (EXIT (NREVERSE #10#)))))
              (LETT |lbackwardSubs|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |j| NIL) (LETT #6# |ns|) (LETT |i| NIL)
                          (LETT #5# |lsd|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL)
                                (ATOM #6#) (PROGN (LETT |j| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS
                                   (SPADCALL (SPADCALL |j| (QREFELT $ 555))
                                             (SPADCALL |i| (QREFELT $ 555))
                                             (QREFELT $ 557))
                                   #7#))))
                          (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                          (GO G190) G191 (EXIT (NREVERSE #7#)))))
              (LETT |nlg|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |g| NIL) (LETT #3# |lg|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |g| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL |g| |lforwardSubs|
                                             (QREFELT $ 559))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |res|
                    (SPADCALL |f| |ls|
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |g| NIL) (LETT #1# |nlg|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |g| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS
                                             (SPADCALL |g| |x| (QREFELT $ 551))
                                             #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 554)))
              (EXIT (SPADCALL |res| |lbackwardSubs| (QREFELT $ 559)))))))))) 

(SDEFUN |EXPR;patternMatch;$P2Pmr;191|
        ((|x| ($)) (|p| (|Pattern| #1=(|Integer|)))
         (|l| (|PatternMatchResult| #1# . #2=($)))
         ($ (|PatternMatchResult| #1# . #2#)))
        (SPADCALL |x| |p| |l| (QREFELT $ 563))) 

(SDEFUN |EXPR;patternMatch;$P2Pmr;192|
        ((|x| ($)) (|p| (|Pattern| #1=(|Float|)))
         (|l| (|PatternMatchResult| #1# . #2=($)))
         ($ (|PatternMatchResult| #1# . #2#)))
        (SPADCALL |x| |p| |l| (QREFELT $ 569))) 

(SDEFUN |EXPR;Zero;$;193| (($ ($))) (|spadConstant| $ 46)) 

(SDEFUN |EXPR;One;$;194| (($ ($))) (|spadConstant| $ 48)) 

(SDEFUN |EXPR;-;2$;195| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 55))) 

(SDEFUN |EXPR;*;I2$;196| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPADCALL |n| |x| (QREFELT $ 58))) 

(SDEFUN |EXPR;*;3$;197| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 62))) 

(SDEFUN |EXPR;+;3$;198| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 64))) 

(SDEFUN |EXPR;=;2$B;199| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 51))) 

(SDEFUN |EXPR;smaller?;2$B;200| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 94))) 

(PUT '|EXPR;numer;$Smp;201| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |EXPR;numer;$Smp;201|
        ((|x| ($)) ($ (|SparseMultivariatePolynomial| R (|Kernel| $)))) |x|) 

(PUT '|EXPR;coerce;Smp$;202| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |EXPR;coerce;Smp$;202|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| $))) ($ ($))) |p|) 

(SDEFUN |EXPR;coerce;P$;203| ((|p| (|Polynomial| R)) ($ ($)))
        (|EXPR;poly_to_MP| |p| $)) 

(SDEFUN |EXPR;reducedSystem;MM;204| ((|m| (|Matrix| $)) ($ (|Matrix| R)))
        (SPADCALL |m| (QREFELT $ 572))) 

(SDEFUN |EXPR;reducedSystem;MVR;205|
        ((|m| (|Matrix| $)) (|v| (|Vector| $))
         ($ (|Record| (|:| |mat| (|Matrix| R)) (|:| |vec| (|Vector| R)))))
        (SPADCALL |m| |v| (QREFELT $ 573))) 

(SDEFUN |EXPR;convert;$If;206| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL |x| (QREFELT $ 539))) 

(SDEFUN |EXPR;kintmatch|
        ((|k| (|Kernel| $)) (|p| (|Pattern| (|Integer|)))
         (|l| (|PatternMatchResult| (|Integer|) |Rep|))
         ($ (|PatternMatchResult| (|Integer|) |Rep|)))
        (SPADCALL |k| |p| |l| (QREFELT $ 575))) 

(SDEFUN |EXPR;patternMatch;$P2Pmr;208|
        ((|x| ($)) (|p| (|Pattern| #1=(|Integer|)))
         (|l| (|PatternMatchResult| #1# . #2=($)))
         ($ (|PatternMatchResult| #1# . #2#)))
        (SPADCALL |x| |p| |l| (CONS (|function| |EXPR;kintmatch|) $)
                  (QREFELT $ 579))) 

(SDEFUN |EXPR;kfltmatch|
        ((|k| (|Kernel| $)) (|p| (|Pattern| (|Float|)))
         (|l| (|PatternMatchResult| (|Float|) |Rep|))
         ($ (|PatternMatchResult| (|Float|) |Rep|)))
        (SPADCALL |k| |p| |l| (QREFELT $ 581))) 

(SDEFUN |EXPR;patternMatch;$P2Pmr;210|
        ((|x| ($)) (|p| (|Pattern| #1=(|Float|)))
         (|l| (|PatternMatchResult| #1# . #2=($)))
         ($ (|PatternMatchResult| #1# . #2#)))
        (SPADCALL |x| |p| |l| (CONS (|function| |EXPR;kfltmatch|) $)
                  (QREFELT $ 585))) 

(SDEFUN |EXPR;Zero;$;211| (($ ($))) (|spadConstant| $ 46)) 

(SDEFUN |EXPR;+;3$;212| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 64))) 

(SDEFUN |EXPR;=;2$B;213| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 51))) 

(SDEFUN |EXPR;smaller?;2$B;214| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 94))) 

(SDEFUN |EXPR;coerce;K$;215| ((|k| (|Kernel| $)) ($ ($)))
        (SPADCALL 1 |k| (QREFELT $ 586))) 

(SDEFUN |EXPR;kernels;$L;216| ((|x| ($)) ($ (|List| (|Kernel| $))))
        (SPROG ((#1=#:G1296 NIL) (|f| NIL) (#2=#:G1295 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 589)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCAR |f|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EXPR;coerce;R$;217| ((|x| (R)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 590)) (|spadConstant| $ 47))
              ('T (SPADCALL (SPADCALL |x| (QREFELT $ 591)) (QREFELT $ 136))))) 

(SDEFUN |EXPR;retract;$R;218| ((|x| ($)) ($ (R)))
        (COND ((SPADCALL |x| (QREFELT $ 54)) (|spadConstant| $ 87))
              ('T (|EXPR;retNotUnit| |x| $)))) 

(SDEFUN |EXPR;coerce;$Of;219| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 593))) 

(SDEFUN |EXPR;kereval|
        ((|k| (|Kernel| $)) (|lk| (|List| (|Kernel| $))) (|lv| (|List| $))
         ($ ($)))
        (SPROG NIL
               (SPADCALL |lk| |lv| |k|
                         (CONS #'|EXPR;kereval!1| (VECTOR |lk| |lv| $))
                         (QREFELT $ 599)))) 

(SDEFUN |EXPR;kereval!1| ((|x2| NIL) ($$ NIL))
        (PROG ($ |lv| |lk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT |lk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|EXPR;kereval!0| (VECTOR $ |lv| |lk|))
                             |x2| (QREFELT $ 596))))))) 

(SDEFUN |EXPR;kereval!0| ((|x1| NIL) ($$ NIL))
        (PROG (|lk| |lv| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |lk| |lv| (QREFELT $ 595)))))) 

(SDEFUN |EXPR;subeval|
        ((|k| (|Kernel| $)) (|lk| (|List| (|Kernel| $))) (|lv| (|List| $))
         ($ ($)))
        (SPROG NIL
               (SEQ
                (SPADCALL |lk| |lv| |k|
                          (CONS #'|EXPR;subeval!0| (VECTOR |lv| |lk| $))
                          (QREFELT $ 599))))) 

(SDEFUN |EXPR;subeval!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |lk| |lv|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lk| (QREFELT $$ 1))
          (LETT |lv| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1329 NIL) (|a| NIL) (#2=#:G1328 NIL))
                   (SEQ
                    (SPADCALL (SPADCALL |x| (QREFELT $ 31))
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |a| NIL)
                                    (LETT #1# (SPADCALL |x| (QREFELT $ 79)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |a| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS
                                             (SPADCALL |a| |lk| |lv|
                                                       (QREFELT $ 600))
                                             #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 601)))))))) 

(SDEFUN |EXPR;isPlus;$U;222| ((|x| ($)) ($ (|Union| (|List| $) "failed")))
        (SPROG
         ((#1=#:G1345 NIL) (|t| NIL) (#2=#:G1344 NIL)
          (|l|
           (|List| (|Record| (|:| |k| (|Kernel| $)) (|:| |c| (|Integer|))))))
         (SEQ
          (COND
           ((OR (NULL (LETT |l| (SPADCALL |x| (QREFELT $ 589))))
                (NULL (CDR |l|)))
            (CONS 1 "failed"))
           ('T
            (CONS 0
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |t| NIL) (LETT #1# |l|) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS
                                 (SPADCALL (QCDR |t|) (QCAR |t|)
                                           (QREFELT $ 586))
                                 #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |EXPR;isMult;$U;223|
        ((|x| ($))
         ($
          (|Union| (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| $)))
                   "failed")))
        (SPROG
         ((|t| (|Record| (|:| |k| (|Kernel| $)) (|:| |c| (|Integer|))))
          (|l|
           (|List| (|Record| (|:| |k| (|Kernel| $)) (|:| |c| (|Integer|))))))
         (SEQ
          (COND
           ((OR (NULL (LETT |l| (SPADCALL |x| (QREFELT $ 589))))
                (NULL (NULL (CDR |l|))))
            (CONS 1 "failed"))
           ('T
            (SEQ (LETT |t| (SPADCALL |l| (QREFELT $ 604)))
                 (EXIT (CONS 0 (CONS (QCDR |t|) (QCAR |t|)))))))))) 

(SDEFUN |EXPR;eval;$LL$;224|
        ((|x| ($)) (|lk| (|List| (|Kernel| $))) (|lv| (|List| $)) ($ ($)))
        (SPROG
         ((#1=#:G1361 NIL) (#2=#:G1360 ($)) (#3=#:G1362 ($)) (#4=#:G1364 NIL)
          (|t| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |t| NIL) (LETT #4# (SPADCALL |x| (QREFELT $ 589))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |t| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (QCDR |t|)
                                   (|EXPR;kereval| (QCAR |t|) |lk| |lv| $)
                                   (QREFELT $ 58)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 65))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 47))))))) 

(SDEFUN |EXPR;subst;$LL$;225|
        ((|x| ($)) (|lk| (|List| (|Kernel| $))) (|lv| (|List| $)) ($ ($)))
        (SPROG
         ((#1=#:G1367 NIL) (#2=#:G1366 ($)) (#3=#:G1368 ($)) (#4=#:G1370 NIL)
          (|t| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |t| NIL) (LETT #4# (SPADCALL |x| (QREFELT $ 589))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |t| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (QCDR |t|)
                                   (|EXPR;subeval| (QCAR |t|) |lk| |lv| $)
                                   (QREFELT $ 58)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 65))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 47))))))) 

(SDEFUN |EXPR;retractIfCan;$U;226| ((|x| ($)) ($ (|Union| R "failed")))
        (COND ((SPADCALL |x| (QREFELT $ 54)) (CONS 0 (|spadConstant| $ 87)))
              ('T (|EXPR;retNotUnitIfCan| |x| $)))) 

(SDEFUN |EXPR;-;2$;227| ((|x| ($)) ($ ($))) (SPADCALL |x| (QREFELT $ 55))) 

(SDEFUN |EXPR;smaller?;2$B;228| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 94))) 

(SDEFUN |EXPR;=;2$B;229| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 51))) 

(PUT '|EXPR;coerce;K$;230| '|SPADreplace| '(XLAM (|k|) |k|)) 

(SDEFUN |EXPR;coerce;K$;230| ((|k| (|Kernel| $)) ($ ($))) |k|) 

(PUT '|EXPR;kernels;$L;231| '|SPADreplace| 'LIST) 

(SDEFUN |EXPR;kernels;$L;231| ((|x| ($)) ($ (|List| (|Kernel| $)))) (LIST |x|)) 

(SDEFUN |EXPR;coerce;R$;232| ((|x| (R)) ($ ($))) (SPADCALL |x| (QREFELT $ 591))) 

(SDEFUN |EXPR;retract;$R;233| ((|x| ($)) ($ (R))) (|EXPR;retNotUnit| |x| $)) 

(SDEFUN |EXPR;retractIfCan;$U;234| ((|x| ($)) ($ (|Union| R "failed")))
        (|EXPR;retNotUnitIfCan| |x| $)) 

(SDEFUN |EXPR;coerce;$Of;235| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 593))) 

(SDEFUN |EXPR;eval;$LL$;236|
        ((|x| ($)) (|lk| (|List| (|Kernel| $))) (|lv| (|List| $)) ($ ($)))
        (SPROG NIL
               (SPADCALL |lk| |lv| |x|
                         (CONS #'|EXPR;eval;$LL$;236!1| (VECTOR |lk| |lv| $))
                         (QREFELT $ 599)))) 

(SDEFUN |EXPR;eval;$LL$;236!1| ((|x1| NIL) ($$ NIL))
        (PROG ($ |lv| |lk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT |lk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL
                    (CONS #'|EXPR;eval;$LL$;236!0| (VECTOR $ |lv| |lk|)) |x1|
                    (QREFELT $ 596))))))) 

(SDEFUN |EXPR;eval;$LL$;236!0| ((|x2| NIL) ($$ NIL))
        (PROG (|lk| |lv| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x2| |lk| |lv| (QREFELT $ 595)))))) 

(SDEFUN |EXPR;subst;$LL$;237|
        ((|x| ($)) (|lk| (|List| (|Kernel| $))) (|lv| (|List| $)) ($ ($)))
        (SPROG NIL
               (SEQ
                (SPADCALL |lk| |lv| |x|
                          (CONS #'|EXPR;subst;$LL$;237!0| (VECTOR |lv| |lk| $))
                          (QREFELT $ 599))))) 

(SDEFUN |EXPR;subst;$LL$;237!0| ((|x1| NIL) ($$ NIL))
        (PROG ($ |lk| |lv|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lk| (QREFELT $$ 1))
          (LETT |lv| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1415 NIL) (|a| NIL) (#2=#:G1414 NIL))
                   (SEQ
                    (SPADCALL (SPADCALL |x1| (QREFELT $ 31))
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |a| NIL)
                                    (LETT #1# (SPADCALL |x1| (QREFELT $ 79)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |a| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS
                                             (SPADCALL |a| |lk| |lv|
                                                       (QREFELT $ 600))
                                             #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 601)))))))) 

(SDEFUN |EXPR;convert;$If;238| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL |x| (QREFELT $ 539))) 

(DECLAIM (NOTINLINE |Expression;|)) 

(DEFUN |Expression| (#1=#:G1461)
  (SPROG NIL
         (PROG (#2=#:G1462)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Expression|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Expression;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Expression|)))))))))) 

(DEFUN |Expression;| (|#1|)
  (SPROG
   ((#1=#:G1460 NIL) (|pv$| NIL) (#2=#:G1456 NIL) (#3=#:G1457 NIL)
    (#4=#:G1458 NIL) (#5=#:G1459 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Expression| DV$1))
    (LETT $ (GETREFV 642))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (LETT #5#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         #5#)
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1| '(|Group|))
                                        (OR (|HasCategory| |#1| '(|Group|))
                                            (|HasCategory| |#1|
                                                           '(|IntegralDomain|)))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Float|))))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|PatternMatchable|
                                                         (|Float|)))
                                        (|HasCategory| |#1|
                                                       '(|PatternMatchable|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|SemiGroup|))
                                        (OR (|HasCategory| |#1| '(|Group|))
                                            (|HasCategory| |#1|
                                                           '(|SemiGroup|)))
                                        (OR (|HasCategory| |#1| '(|Group|))
                                            #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|RetractableTo|
                                                                (|Integer|)))
                                               (|HasCategory| |#1|
                                                              '(|IntegralDomain|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         #4#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         #5#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Integer|)))
                                         #5#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         #5#)
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|PolynomialFactorizationExplicit|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         #3#)
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|AbelianSemiGroup|)))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         #2#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         #2#
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         #5#)
                                        (OR #2#
                                            (|HasCategory| |#1|
                                                           '(|SemiGroup|)))))))
    (|haddProp| |$ConstructorCache| '|Expression| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|RetractableTo| (|Integer|)))
         (|augmentPredVector| $ 2147483648))
    (AND (|HasCategory| $ '(|Ring|)) (|augmentPredVector| $ 4294967296))
    (AND (|HasCategory| |#1| '(|IntegralDomain|))
         (|HasCategory| $ '(|RetractableTo| (|Integer|)))
         (|augmentPredVector| $ 8589934592))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|IntegralDomain|))
                (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 17179869184))
    (AND (OR (|HasCategory| |#1| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 34359738368))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 '|%symbol|)
    (QSETREFV $ 8 '|%alg|)
    (COND ((|testBitVector| |pv$| 1))
          ('T
           (QSETREFV $ 37
                     (CONS (|dispatchFunction| |EXPR;operator;2Bo;4|) $))))
    (COND
     ((|testBitVector| |pv$| 5)
      (PROGN
       (COND
        ((|testBitVector| |pv$| 1)
         (PROGN
          (QSETREFV $ 45
                    (|Fraction|
                     (|SparseMultivariatePolynomial| |#1| (|Kernel| $))))
          (QSETREFV $ 47
                    (CONS #'|makeSpadConstant|
                          (LIST (|dispatchFunction| |EXPR;Zero;$;6|) $ 47)))
          (QSETREFV $ 49
                    (CONS #'|makeSpadConstant|
                          (LIST (|dispatchFunction| |EXPR;One;$;7|) $ 49)))
          (QSETREFV $ 52 (CONS (|dispatchFunction| |EXPR;one?;$B;8|) $))
          (QSETREFV $ 54 (CONS (|dispatchFunction| |EXPR;zero?;$B;9|) $))
          (QSETREFV $ 56 (CONS (|dispatchFunction| |EXPR;-;2$;10|) $))
          (QSETREFV $ 59 (CONS (|dispatchFunction| |EXPR;*;I2$;11|) $))
          (QSETREFV $ 61 (CONS (|dispatchFunction| |EXPR;coerce;I$;12|) $))
          (QSETREFV $ 63 (CONS (|dispatchFunction| |EXPR;*;3$;13|) $))
          (QSETREFV $ 65 (CONS (|dispatchFunction| |EXPR;+;3$;14|) $))
          (QSETREFV $ 67 (CONS (|dispatchFunction| |EXPR;-;3$;15|) $))
          (QSETREFV $ 69 (CONS (|dispatchFunction| |EXPR;/;3$;16|) $))
          (QSETREFV $ 73 (CONS (|dispatchFunction| |EXPR;number?;$B;17|) $))
          (QSETREFV $ 90 (CONS (|dispatchFunction| |EXPR;^;$Nni$;19|) $))
          (QSETREFV $ 91 (CONS (|dispatchFunction| |EXPR;^;$I$;20|) $))
          (QSETREFV $ 93 (CONS (|dispatchFunction| |EXPR;^;$Pi$;21|) $))
          (QSETREFV $ 95 (CONS (|dispatchFunction| |EXPR;smaller?;2$B;22|) $))
          (QSETREFV $ 96 (CONS (|dispatchFunction| |EXPR;=;2$B;23|) $))
          (QSETREFV $ 99 (CONS (|dispatchFunction| |EXPR;numer;$Smp;24|) $))
          (QSETREFV $ 101 (CONS (|dispatchFunction| |EXPR;denom;$Smp;25|) $))
          (QSETREFV $ 102
                    (|Record|
                     (|:| |num|
                          (|SparseMultivariatePolynomial| |#1| (|Kernel| $)))
                     (|:| |den|
                          (|SparseMultivariatePolynomial| |#1| (|Kernel| $)))))
          (QSETREFV $ 104 (CONS (|dispatchFunction| |EXPR;coerce;Smp$;26|) $))
          (QSETREFV $ 106 (CONS (|dispatchFunction| |EXPR;coerce;P$;27|) $))
          (QSETREFV $ 110 (CONS (|dispatchFunction| |EXPR;coerce;F$;28|) $))
          (QSETREFV $ 111 (CONS (|dispatchFunction| |EXPR;reduce;2$;29|) $))
          (DEFVAR |algreduc_flag| 'NIL)
          (QSETREFV $ 127
                    (CONS
                     (|dispatchFunction| |EXPR;getSimplifyDenomsFlag;B;35|) $))
          (QSETREFV $ 128
                    (CONS
                     (|dispatchFunction| |EXPR;setSimplifyDenomsFlag;2B;36|)
                     $))
          (QSETREFV $ 139 (CONS (|dispatchFunction| |EXPR;/;2Smp$;38|) $))
          (QSETREFV $ 148
                    (CONS (|dispatchFunction| |EXPR;reducedSystem;MM;39|) $))
          (QSETREFV $ 156
                    (CONS (|dispatchFunction| |EXPR;reducedSystem;MVR;40|) $))
          (QSETREFV $ 161 (CONS (|dispatchFunction| |EXPR;rootOf;SupS$;42|) $))
          (QSETREFV $ 163
                    (CONS (|dispatchFunction| |EXPR;rootSum;$SupS$;43|) $))
          (QSETREFV $ 166 (CONS (|dispatchFunction| |EXPR;pi;$;44|) $))
          (QSETREFV $ 168 (CONS (|dispatchFunction| |EXPR;exp;2$;45|) $))
          (QSETREFV $ 170 (CONS (|dispatchFunction| |EXPR;log;2$;46|) $))
          (QSETREFV $ 172 (CONS (|dispatchFunction| |EXPR;sin;2$;47|) $))
          (QSETREFV $ 174 (CONS (|dispatchFunction| |EXPR;cos;2$;48|) $))
          (QSETREFV $ 176 (CONS (|dispatchFunction| |EXPR;tan;2$;49|) $))
          (QSETREFV $ 178 (CONS (|dispatchFunction| |EXPR;cot;2$;50|) $))
          (QSETREFV $ 180 (CONS (|dispatchFunction| |EXPR;sec;2$;51|) $))
          (QSETREFV $ 182 (CONS (|dispatchFunction| |EXPR;csc;2$;52|) $))
          (QSETREFV $ 184 (CONS (|dispatchFunction| |EXPR;asin;2$;53|) $))
          (QSETREFV $ 186 (CONS (|dispatchFunction| |EXPR;acos;2$;54|) $))
          (QSETREFV $ 188 (CONS (|dispatchFunction| |EXPR;atan;2$;55|) $))
          (QSETREFV $ 190 (CONS (|dispatchFunction| |EXPR;acot;2$;56|) $))
          (QSETREFV $ 192 (CONS (|dispatchFunction| |EXPR;asec;2$;57|) $))
          (QSETREFV $ 194 (CONS (|dispatchFunction| |EXPR;acsc;2$;58|) $))
          (QSETREFV $ 196 (CONS (|dispatchFunction| |EXPR;sinh;2$;59|) $))
          (QSETREFV $ 198 (CONS (|dispatchFunction| |EXPR;cosh;2$;60|) $))
          (QSETREFV $ 200 (CONS (|dispatchFunction| |EXPR;tanh;2$;61|) $))
          (QSETREFV $ 202 (CONS (|dispatchFunction| |EXPR;coth;2$;62|) $))
          (QSETREFV $ 204 (CONS (|dispatchFunction| |EXPR;sech;2$;63|) $))
          (QSETREFV $ 206 (CONS (|dispatchFunction| |EXPR;csch;2$;64|) $))
          (QSETREFV $ 208 (CONS (|dispatchFunction| |EXPR;asinh;2$;65|) $))
          (QSETREFV $ 210 (CONS (|dispatchFunction| |EXPR;acosh;2$;66|) $))
          (QSETREFV $ 212 (CONS (|dispatchFunction| |EXPR;atanh;2$;67|) $))
          (QSETREFV $ 214 (CONS (|dispatchFunction| |EXPR;acoth;2$;68|) $))
          (QSETREFV $ 216 (CONS (|dispatchFunction| |EXPR;asech;2$;69|) $))
          (QSETREFV $ 218 (CONS (|dispatchFunction| |EXPR;acsch;2$;70|) $))
          (QSETREFV $ 221 (CONS (|dispatchFunction| |EXPR;abs;2$;71|) $))
          (QSETREFV $ 223 (CONS (|dispatchFunction| |EXPR;conjugate;2$;72|) $))
          (QSETREFV $ 225 (CONS (|dispatchFunction| |EXPR;Gamma;2$;73|) $))
          (QSETREFV $ 227 (CONS (|dispatchFunction| |EXPR;Gamma;3$;74|) $))
          (QSETREFV $ 229 (CONS (|dispatchFunction| |EXPR;Beta;3$;75|) $))
          (QSETREFV $ 231 (CONS (|dispatchFunction| |EXPR;digamma;2$;76|) $))
          (QSETREFV $ 233 (CONS (|dispatchFunction| |EXPR;polygamma;3$;77|) $))
          (QSETREFV $ 235 (CONS (|dispatchFunction| |EXPR;besselJ;3$;78|) $))
          (QSETREFV $ 237 (CONS (|dispatchFunction| |EXPR;besselY;3$;79|) $))
          (QSETREFV $ 239 (CONS (|dispatchFunction| |EXPR;besselI;3$;80|) $))
          (QSETREFV $ 241 (CONS (|dispatchFunction| |EXPR;besselK;3$;81|) $))
          (QSETREFV $ 243 (CONS (|dispatchFunction| |EXPR;airyAi;2$;82|) $))
          (QSETREFV $ 245
                    (CONS (|dispatchFunction| |EXPR;airyAiPrime;2$;83|) $))
          (QSETREFV $ 247 (CONS (|dispatchFunction| |EXPR;airyBi;2$;84|) $))
          (QSETREFV $ 249
                    (CONS (|dispatchFunction| |EXPR;airyBiPrime;2$;85|) $))
          (QSETREFV $ 251 (CONS (|dispatchFunction| |EXPR;lambertW;2$;86|) $))
          (QSETREFV $ 253 (CONS (|dispatchFunction| |EXPR;polylog;3$;87|) $))
          (QSETREFV $ 255
                    (CONS (|dispatchFunction| |EXPR;weierstrassP;4$;88|) $))
          (QSETREFV $ 257
                    (CONS (|dispatchFunction| |EXPR;weierstrassPPrime;4$;89|)
                          $))
          (QSETREFV $ 259
                    (CONS (|dispatchFunction| |EXPR;weierstrassSigma;4$;90|)
                          $))
          (QSETREFV $ 261
                    (CONS (|dispatchFunction| |EXPR;weierstrassZeta;4$;91|) $))
          (QSETREFV $ 263
                    (CONS (|dispatchFunction| |EXPR;weierstrassPInverse;4$;92|)
                          $))
          (QSETREFV $ 265
                    (CONS (|dispatchFunction| |EXPR;whittakerM;4$;93|) $))
          (QSETREFV $ 267
                    (CONS (|dispatchFunction| |EXPR;whittakerW;4$;94|) $))
          (QSETREFV $ 269 (CONS (|dispatchFunction| |EXPR;angerJ;3$;95|) $))
          (QSETREFV $ 271 (CONS (|dispatchFunction| |EXPR;weberE;3$;96|) $))
          (QSETREFV $ 273 (CONS (|dispatchFunction| |EXPR;struveH;3$;97|) $))
          (QSETREFV $ 275 (CONS (|dispatchFunction| |EXPR;struveL;3$;98|) $))
          (QSETREFV $ 277 (CONS (|dispatchFunction| |EXPR;hankelH1;3$;99|) $))
          (QSETREFV $ 279 (CONS (|dispatchFunction| |EXPR;hankelH2;3$;100|) $))
          (QSETREFV $ 281 (CONS (|dispatchFunction| |EXPR;lommelS1;4$;101|) $))
          (QSETREFV $ 283 (CONS (|dispatchFunction| |EXPR;lommelS2;4$;102|) $))
          (QSETREFV $ 285 (CONS (|dispatchFunction| |EXPR;kummerM;4$;103|) $))
          (QSETREFV $ 287 (CONS (|dispatchFunction| |EXPR;kummerU;4$;104|) $))
          (QSETREFV $ 289
                    (CONS (|dispatchFunction| |EXPR;legendreP;4$;105|) $))
          (QSETREFV $ 291
                    (CONS (|dispatchFunction| |EXPR;legendreQ;4$;106|) $))
          (QSETREFV $ 293
                    (CONS (|dispatchFunction| |EXPR;kelvinBei;3$;107|) $))
          (QSETREFV $ 295
                    (CONS (|dispatchFunction| |EXPR;kelvinBer;3$;108|) $))
          (QSETREFV $ 297
                    (CONS (|dispatchFunction| |EXPR;kelvinKei;3$;109|) $))
          (QSETREFV $ 299
                    (CONS (|dispatchFunction| |EXPR;kelvinKer;3$;110|) $))
          (QSETREFV $ 301
                    (CONS (|dispatchFunction| |EXPR;ellipticK;2$;111|) $))
          (QSETREFV $ 303
                    (CONS (|dispatchFunction| |EXPR;ellipticE;2$;112|) $))
          (QSETREFV $ 305
                    (CONS (|dispatchFunction| |EXPR;ellipticE;3$;113|) $))
          (QSETREFV $ 307
                    (CONS (|dispatchFunction| |EXPR;ellipticF;3$;114|) $))
          (QSETREFV $ 309
                    (CONS (|dispatchFunction| |EXPR;ellipticPi;4$;115|) $))
          (QSETREFV $ 311 (CONS (|dispatchFunction| |EXPR;jacobiSn;3$;116|) $))
          (QSETREFV $ 313 (CONS (|dispatchFunction| |EXPR;jacobiCn;3$;117|) $))
          (QSETREFV $ 315 (CONS (|dispatchFunction| |EXPR;jacobiDn;3$;118|) $))
          (QSETREFV $ 317
                    (CONS (|dispatchFunction| |EXPR;jacobiZeta;3$;119|) $))
          (QSETREFV $ 319
                    (CONS (|dispatchFunction| |EXPR;jacobiTheta;3$;120|) $))
          (QSETREFV $ 321 (CONS (|dispatchFunction| |EXPR;lerchPhi;4$;121|) $))
          (QSETREFV $ 323
                    (CONS (|dispatchFunction| |EXPR;riemannZeta;2$;122|) $))
          (QSETREFV $ 325
                    (CONS (|dispatchFunction| |EXPR;charlierC;4$;123|) $))
          (QSETREFV $ 327 (CONS (|dispatchFunction| |EXPR;hermiteH;3$;124|) $))
          (QSETREFV $ 329 (CONS (|dispatchFunction| |EXPR;jacobiP;5$;125|) $))
          (QSETREFV $ 331
                    (CONS (|dispatchFunction| |EXPR;laguerreL;4$;126|) $))
          (QSETREFV $ 333 (CONS (|dispatchFunction| |EXPR;meixnerM;5$;127|) $))
          (COND
           ((|testBitVector| |pv$| 32)
            (PROGN
             (QSETREFV $ 336
                       (CONS
                        (|dispatchFunction| |EXPR;hypergeometricF;2L2$;128|)
                        (|getDomainView| $ '(|RetractableTo| (|Integer|)))))
             (QSETREFV $ 338
                       (CONS (|dispatchFunction| |EXPR;meijerG;4L2$;129|)
                             (|getDomainView| $
                                              '(|RetractableTo|
                                                (|Integer|))))))))
          (QSETREFV $ 84 (CONS (|dispatchFunction| |EXPR;^;3$;130|) $))
          (QSETREFV $ 342
                    (CONS (|dispatchFunction| |EXPR;factorial;2$;131|) $))
          (QSETREFV $ 344 (CONS (|dispatchFunction| |EXPR;binomial;3$;132|) $))
          (QSETREFV $ 346
                    (CONS (|dispatchFunction| |EXPR;permutation;3$;133|) $))
          (QSETREFV $ 348
                    (CONS (|dispatchFunction| |EXPR;factorials;2$;134|) $))
          (QSETREFV $ 350
                    (CONS (|dispatchFunction| |EXPR;factorials;$S$;135|) $))
          (QSETREFV $ 352
                    (CONS (|dispatchFunction| |EXPR;summation;$S$;136|) $))
          (QSETREFV $ 356
                    (CONS (|dispatchFunction| |EXPR;summation;$Sb$;137|) $))
          (QSETREFV $ 358 (CONS (|dispatchFunction| |EXPR;product;$S$;138|) $))
          (QSETREFV $ 360
                    (CONS (|dispatchFunction| |EXPR;product;$Sb$;139|) $))
          (QSETREFV $ 363 (CONS (|dispatchFunction| |EXPR;erf;2$;140|) $))
          (QSETREFV $ 365 (CONS (|dispatchFunction| |EXPR;erfi;2$;141|) $))
          (QSETREFV $ 367 (CONS (|dispatchFunction| |EXPR;Ei;2$;142|) $))
          (QSETREFV $ 369 (CONS (|dispatchFunction| |EXPR;Si;2$;143|) $))
          (QSETREFV $ 371 (CONS (|dispatchFunction| |EXPR;Ci;2$;144|) $))
          (QSETREFV $ 373 (CONS (|dispatchFunction| |EXPR;Shi;2$;145|) $))
          (QSETREFV $ 375 (CONS (|dispatchFunction| |EXPR;Chi;2$;146|) $))
          (QSETREFV $ 377 (CONS (|dispatchFunction| |EXPR;li;2$;147|) $))
          (QSETREFV $ 379 (CONS (|dispatchFunction| |EXPR;dilog;2$;148|) $))
          (QSETREFV $ 381 (CONS (|dispatchFunction| |EXPR;fresnelS;2$;149|) $))
          (QSETREFV $ 383 (CONS (|dispatchFunction| |EXPR;fresnelC;2$;150|) $))
          (QSETREFV $ 385
                    (CONS (|dispatchFunction| |EXPR;integral;$S$;151|) $))
          (QSETREFV $ 387
                    (CONS (|dispatchFunction| |EXPR;integral;$Sb$;152|) $))
          (QSETREFV $ 37 (CONS (|dispatchFunction| |EXPR;operator;2Bo;153|) $))
          (COND
           ((|HasCategory| |#1| '(|GcdDomain|))
            (PROGN
             (COND
              ((|domainEqual| |#1| (|Integer|))
               (PROGN
                (QSETREFV $ 438
                          (|Record| (|:| |svz| (|List| (|Symbol|)))
                                    (|:| |sm|
                                         (|List| (|Polynomial| (|Integer|))))
                                    (|:| |msizes| (|List| (|Integer|)))
                                    (|:| |sp| (|Integer|))))
                (QSETREFV $ 439 (|ModularAlgebraicGcdTools3|))
                (QSETREFV $ 440
                          (|ModularAlgebraicGcd|
                           (|SparseUnivariatePolynomial|
                            (|Polynomial| (|Integer|)))
                           (QREFELT $ 438) (QREFELT $ 439)))
                (QSETREFV $ 449 (|ModularEvaluation2|))
                (QSETREFV $ 450 (|ModularAlgebraicGcdTools4|))
                (QSETREFV $ 451
                          (|ModularAlgebraicGcd2|
                           (|Record| (|:| |var| (|Symbol|))
                                     (|:| |coef|
                                          (|SparseUnivariatePolynomial|
                                           (|Fraction|
                                            (|Polynomial| (|Integer|))))))
                           (|FakePolynomial|)
                           (|SparseUnivariatePolynomial|
                            (|Polynomial| (|Integer|)))
                           (QREFELT $ 438) (QREFELT $ 449) (QREFELT $ 450)))
                (QSETREFV $ 476
                          (CONS
                           (|dispatchFunction| |EXPR;gcdPolynomial;3Sup;172|)
                           $))))
              ('T
               (QSETREFV $ 476
                         (CONS
                          (|dispatchFunction| |EXPR;gcdPolynomial;3Sup;173|)
                          $))))
             (COND
              ((|testBitVector| |pv$| 26)
               (QSETREFV $ 483
                         (CONS
                          (|dispatchFunction| |EXPR;factorPolynomial;SupF;174|)
                          $)))))))
          (COND
           ((|domainEqual| |#1| (|AlgebraicNumber|))
            (QSETREFV $ 488
                      (CONS (|dispatchFunction| |EXPR;coerce;An$;175|) $))))
          (COND
           ((|testBitVector| |pv$| 15)
            (PROGN
             (QSETREFV $ 491 (CONS (|dispatchFunction| |EXPR;^;$F$;176|) $))
             (QSETREFV $ 132
                       (CONS (|dispatchFunction| |EXPR;minPoly;KSup;177|) $))
             (QSETREFV $ 494
                       (CONS
                        (|dispatchFunction| |EXPR;definingPolynomial;2$;178|)
                        $))
             (QSETREFV $ 496
                       (CONS (|dispatchFunction| |EXPR;retract;$F;179|) $))
             (QSETREFV $ 72
                       (CONS (|dispatchFunction| |EXPR;retractIfCan;$U;180|)
                             $))
             (COND ((|domainEqual| |#1| (|AlgebraicNumber|)))
                   ('T
                    (PROGN
                     (QSETREFV $ 488
                               (CONS (|dispatchFunction| |EXPR;coerce;An$;181|)
                                     $))
                     (QSETREFV $ 512
                               (CONS
                                (|dispatchFunction| |EXPR;retractIfCan;$U;184|)
                                $))))))))
          (COND
           ((|testBitVector| |pv$| 10)
            (PROGN
             (QSETREFV $ 540
                       (CONS (|dispatchFunction| |EXPR;convert;$If;188|) $))
             (QSETREFV $ 543
                       (CONS (|dispatchFunction| |EXPR;eval;$Bo$S$;189|) $))
             (QSETREFV $ 542
                       (CONS (|dispatchFunction| |EXPR;eval;$LLS$;190|) $)))))
          (COND
           ((|testBitVector| |pv$| 14)
            (QSETREFV $ 565
                      (CONS (|dispatchFunction| |EXPR;patternMatch;$P2Pmr;191|)
                            $))))
          (COND
           ((|testBitVector| |pv$| 13)
            (QSETREFV $ 571
                      (CONS (|dispatchFunction| |EXPR;patternMatch;$P2Pmr;192|)
                            $))))))
        ('T
         (PROGN
          (SETELT $ 45 (|SparseMultivariatePolynomial| |#1| (|Kernel| $)))
          (QSETREFV $ 47
                    (CONS #'|makeSpadConstant|
                          (LIST (|dispatchFunction| |EXPR;Zero;$;193|) $ 47)))
          (QSETREFV $ 49
                    (CONS #'|makeSpadConstant|
                          (LIST (|dispatchFunction| |EXPR;One;$;194|) $ 49)))
          (QSETREFV $ 56 (CONS (|dispatchFunction| |EXPR;-;2$;195|) $))
          (QSETREFV $ 59 (CONS (|dispatchFunction| |EXPR;*;I2$;196|) $))
          (QSETREFV $ 63 (CONS (|dispatchFunction| |EXPR;*;3$;197|) $))
          (QSETREFV $ 65 (CONS (|dispatchFunction| |EXPR;+;3$;198|) $))
          (QSETREFV $ 96 (CONS (|dispatchFunction| |EXPR;=;2$B;199|) $))
          (QSETREFV $ 95 (CONS (|dispatchFunction| |EXPR;smaller?;2$B;200|) $))
          (QSETREFV $ 99 (CONS (|dispatchFunction| |EXPR;numer;$Smp;201|) $))
          (QSETREFV $ 104 (CONS (|dispatchFunction| |EXPR;coerce;Smp$;202|) $))
          (QSETREFV $ 106 (CONS (|dispatchFunction| |EXPR;coerce;P$;203|) $))
          (QSETREFV $ 148
                    (CONS (|dispatchFunction| |EXPR;reducedSystem;MM;204|) $))
          (QSETREFV $ 156
                    (CONS (|dispatchFunction| |EXPR;reducedSystem;MVR;205|) $))
          (COND
           ((|testBitVector| |pv$| 10)
            (QSETREFV $ 540
                      (CONS (|dispatchFunction| |EXPR;convert;$If;206|) $))))
          (COND
           ((|testBitVector| |pv$| 14)
            (PROGN
             (QSETREFV $ 565
                       (CONS
                        (|dispatchFunction| |EXPR;patternMatch;$P2Pmr;208|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 13)
            (PROGN
             (QSETREFV $ 571
                       (CONS
                        (|dispatchFunction| |EXPR;patternMatch;$P2Pmr;210|)
                        $))))))))))
     ((|HasCategory| |#1| '(|AbelianMonoid|))
      (PROGN
       (SETELT $ 45 (|FreeModule| (|Integer|) (|Kernel| $)))
       (QSETREFV $ 47
                 (CONS #'|makeSpadConstant|
                       (LIST (|dispatchFunction| |EXPR;Zero;$;211|) $ 47)))
       (QSETREFV $ 65 (CONS (|dispatchFunction| |EXPR;+;3$;212|) $))
       (QSETREFV $ 96 (CONS (|dispatchFunction| |EXPR;=;2$B;213|) $))
       (QSETREFV $ 95 (CONS (|dispatchFunction| |EXPR;smaller?;2$B;214|) $))
       (QSETREFV $ 136 (CONS (|dispatchFunction| |EXPR;coerce;K$;215|) $))
       (QSETREFV $ 75 (CONS (|dispatchFunction| |EXPR;kernels;$L;216|) $))
       (QSETREFV $ 513 (CONS (|dispatchFunction| |EXPR;coerce;R$;217|) $))
       (QSETREFV $ 423 (CONS (|dispatchFunction| |EXPR;retract;$R;218|) $))
       (QSETREFV $ 594 (CONS (|dispatchFunction| |EXPR;coerce;$Of;219|) $))
       (QSETREFV $ 603 (CONS (|dispatchFunction| |EXPR;isPlus;$U;222|) $))
       (QSETREFV $ 607 (CONS (|dispatchFunction| |EXPR;isMult;$U;223|) $))
       (QSETREFV $ 595 (CONS (|dispatchFunction| |EXPR;eval;$LL$;224|) $))
       (QSETREFV $ 600 (CONS (|dispatchFunction| |EXPR;subst;$LL$;225|) $))
       (QSETREFV $ 608
                 (CONS (|dispatchFunction| |EXPR;retractIfCan;$U;226|) $))
       (COND
        ((|testBitVector| |pv$| 16)
         (QSETREFV $ 56 (CONS (|dispatchFunction| |EXPR;-;2$;227|) $))))))
     ('T
      (PROGN
       (SETELT $ 45 (|Kernel| $))
       (QSETREFV $ 95 (CONS (|dispatchFunction| |EXPR;smaller?;2$B;228|) $))
       (QSETREFV $ 96 (CONS (|dispatchFunction| |EXPR;=;2$B;229|) $))
       (QSETREFV $ 136 (CONS (|dispatchFunction| |EXPR;coerce;K$;230|) $))
       (QSETREFV $ 75 (CONS (|dispatchFunction| |EXPR;kernels;$L;231|) $))
       (QSETREFV $ 513 (CONS (|dispatchFunction| |EXPR;coerce;R$;232|) $))
       (QSETREFV $ 423 (CONS (|dispatchFunction| |EXPR;retract;$R;233|) $))
       (QSETREFV $ 608
                 (CONS (|dispatchFunction| |EXPR;retractIfCan;$U;234|) $))
       (QSETREFV $ 594 (CONS (|dispatchFunction| |EXPR;coerce;$Of;235|) $))
       (QSETREFV $ 595 (CONS (|dispatchFunction| |EXPR;eval;$LL$;236|) $))
       (QSETREFV $ 600 (CONS (|dispatchFunction| |EXPR;subst;$LL$;237|) $))
       (COND
        ((|testBitVector| |pv$| 10)
         (QSETREFV $ 540
                   (CONS (|dispatchFunction| |EXPR;convert;$If;238|) $)))))))
    $))) 

(MAKEPROP '|Expression| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'SYMBOL 'ALGOP (|Boolean|)
              (|BasicOperator|) |EXPR;belong?;BoB;1| (|Kernel| $)
              (0 . |retract|) (|Union| 6 '"failed") (|Kernel| $$)
              (|KernelFunctions2| 6 $$) (5 . |constantIfCan|)
              (|Union| 12 '#1="failed") (10 . |retractIfCan|)
              (|FunctionSpace&| $$ 6) (15 . |belong?|) (20 . |operator|)
              (|ExpressionSpace&| $$) (25 . |belong?|) (30 . |operator|)
              (35 . |nullary?|) (|Symbol|) (40 . |has?|) (46 . |name|)
              (51 . |kernel|) (56 . |operator|) (|Union| 35 '"failed")
              (61 . |arity|) (66 . |operator|) (|NonNegativeInteger|)
              (71 . |operator|) (77 . |operator|) (|List| 27)
              (|SparseMultivariatePolynomial| 6 27) (82 . |variables|)
              (|SparseMultivariatePolynomial| 6 15) (|List| 15)
              (|SparsePolynomialCoercionHelpers| 6 27 15)
              (87 . |remap_variables|) '|Rep| (94 . |Zero|) (98 . |Zero|)
              (102 . |One|) (106 . |One|) (110 . |One|) (114 . =)
              (120 . |one?|) (125 . |zero?|) (130 . |zero?|) (135 . -)
              (140 . -) (|Integer|) (145 . *) (151 . *) (157 . |coerce|)
              (162 . |coerce|) (167 . *) (173 . *) (179 . +) (185 . +)
              (191 . -) (197 . -) (203 . /) (209 . /) (215 . |ground?|)
              (|Union| 489 '#1#) (220 . |retractIfCan|) (225 . |number?|)
              (|List| 12) (230 . |kernels|) (235 . |is?|) (241 . |first|)
              (|List| $$) (246 . |argument|) (251 . |#|) (256 . |elt|)
              (262 . ^) (268 . |algtower|) (273 . ^) (279 . |first|)
              (284 . |second|) (289 . |Zero|) (293 . |numerator|)
              (298 . |denominator|) (303 . ^) (309 . ^) (|PositiveInteger|)
              (315 . ^) (321 . |smaller?|) (327 . |smaller?|) (333 . =)
              (339 . |numer|) (|SparseMultivariatePolynomial| 6 12)
              (344 . |numer|) (349 . |denom|) (354 . |denom|) 'EREP
              (359 . |One|) (363 . |coerce|) (|Polynomial| 6) (368 . |coerce|)
              (|Fraction| 105) (373 . |numer|) (378 . |denom|) (383 . |coerce|)
              (388 . |reduce|) (|Mapping| 9 15) (393 . |select!|)
              (|AlgebraicManipulations| 6 $$) (399 . |ratDenom|) (405 . |is?|)
              (411 . ~=) (|SparseUnivariatePolynomial| $) (417 . |univariate|)
              (|SparseUnivariatePolynomial| 41) (423 . |leadingCoefficient|)
              (428 . |reductum|) (433 . *) (439 . |monomial|) (446 . -)
              (452 . /) (458 . |getSimplifyDenomsFlag|)
              (462 . |setSimplifyDenomsFlag|) (467 . |elt|)
              (|SingletonAsOrderedSet|) (473 . |create|) (477 . |minPoly|)
              (|SparseUnivariatePolynomial| $$)
              (|PolynomialCategoryQuotientFunctions| 484 15 6 41 $$)
              (482 . |univariate|) (489 . |coerce|) (494 . |eval|)
              (501 . |retract|) (506 . /) (|Mapping| $$ $$) (|Matrix| $$)
              (512 . |map|) (|Matrix| 41) (|Matrix| $) (518 . |reducedSystem|)
              (|Matrix| 6) (523 . |reducedSystem|) (528 . |reducedSystem|)
              (|Vector| $$) (533 . |map|)
              (|Record| (|:| |mat| 143) (|:| |vec| (|Vector| 41))) (|Vector| $)
              (539 . |reducedSystem|)
              (|Record| (|:| |mat| 146) (|:| |vec| (|Vector| 6)))
              (545 . |reducedSystem|) (551 . |reducedSystem|) (557 . |member?|)
              (563 . |concat|) (|AlgebraicFunction| 6 $$) (569 . |rootOf|)
              (575 . |rootOf|) (581 . |rootSum|) (588 . |rootSum|)
              (|ElementaryFunction| 6 $$) (595 . |pi|) (599 . |pi|)
              (603 . |exp|) (608 . |exp|) (613 . |log|) (618 . |log|)
              (623 . |sin|) (628 . |sin|) (633 . |cos|) (638 . |cos|)
              (643 . |tan|) (648 . |tan|) (653 . |cot|) (658 . |cot|)
              (663 . |sec|) (668 . |sec|) (673 . |csc|) (678 . |csc|)
              (683 . |asin|) (688 . |asin|) (693 . |acos|) (698 . |acos|)
              (703 . |atan|) (708 . |atan|) (713 . |acot|) (718 . |acot|)
              (723 . |asec|) (728 . |asec|) (733 . |acsc|) (738 . |acsc|)
              (743 . |sinh|) (748 . |sinh|) (753 . |cosh|) (758 . |cosh|)
              (763 . |tanh|) (768 . |tanh|) (773 . |coth|) (778 . |coth|)
              (783 . |sech|) (788 . |sech|) (793 . |csch|) (798 . |csch|)
              (803 . |asinh|) (808 . |asinh|) (813 . |acosh|) (818 . |acosh|)
              (823 . |atanh|) (828 . |atanh|) (833 . |acoth|) (838 . |acoth|)
              (843 . |asech|) (848 . |asech|) (853 . |acsch|) (858 . |acsch|)
              (|FunctionalSpecialFunction| 6 $$) (863 . |abs|) (868 . |abs|)
              (873 . |conjugate|) (878 . |conjugate|) (883 . |Gamma|)
              (888 . |Gamma|) (893 . |Gamma|) (899 . |Gamma|) (905 . |Beta|)
              (911 . |Beta|) (917 . |digamma|) (922 . |digamma|)
              (927 . |polygamma|) (933 . |polygamma|) (939 . |besselJ|)
              (945 . |besselJ|) (951 . |besselY|) (957 . |besselY|)
              (963 . |besselI|) (969 . |besselI|) (975 . |besselK|)
              (981 . |besselK|) (987 . |airyAi|) (992 . |airyAi|)
              (997 . |airyAiPrime|) (1002 . |airyAiPrime|) (1007 . |airyBi|)
              (1012 . |airyBi|) (1017 . |airyBiPrime|) (1022 . |airyBiPrime|)
              (1027 . |lambertW|) (1032 . |lambertW|) (1037 . |polylog|)
              (1043 . |polylog|) (1049 . |weierstrassP|)
              (1056 . |weierstrassP|) (1063 . |weierstrassPPrime|)
              (1070 . |weierstrassPPrime|) (1077 . |weierstrassSigma|)
              (1084 . |weierstrassSigma|) (1091 . |weierstrassZeta|)
              (1098 . |weierstrassZeta|) (1105 . |weierstrassPInverse|)
              (1112 . |weierstrassPInverse|) (1119 . |whittakerM|)
              (1126 . |whittakerM|) (1133 . |whittakerW|) (1140 . |whittakerW|)
              (1147 . |angerJ|) (1153 . |angerJ|) (1159 . |weberE|)
              (1165 . |weberE|) (1171 . |struveH|) (1177 . |struveH|)
              (1183 . |struveL|) (1189 . |struveL|) (1195 . |hankelH1|)
              (1201 . |hankelH1|) (1207 . |hankelH2|) (1213 . |hankelH2|)
              (1219 . |lommelS1|) (1226 . |lommelS1|) (1233 . |lommelS2|)
              (1240 . |lommelS2|) (1247 . |kummerM|) (1254 . |kummerM|)
              (1261 . |kummerU|) (1268 . |kummerU|) (1275 . |legendreP|)
              (1282 . |legendreP|) (1289 . |legendreQ|) (1296 . |legendreQ|)
              (1303 . |kelvinBei|) (1309 . |kelvinBei|) (1315 . |kelvinBer|)
              (1321 . |kelvinBer|) (1327 . |kelvinKei|) (1333 . |kelvinKei|)
              (1339 . |kelvinKer|) (1345 . |kelvinKer|) (1351 . |ellipticK|)
              (1356 . |ellipticK|) (1361 . |ellipticE|) (1366 . |ellipticE|)
              (1371 . |ellipticE|) (1377 . |ellipticE|) (1383 . |ellipticF|)
              (1389 . |ellipticF|) (1395 . |ellipticPi|) (1402 . |ellipticPi|)
              (1409 . |jacobiSn|) (1415 . |jacobiSn|) (1421 . |jacobiCn|)
              (1427 . |jacobiCn|) (1433 . |jacobiDn|) (1439 . |jacobiDn|)
              (1445 . |jacobiZeta|) (1451 . |jacobiZeta|)
              (1457 . |jacobiTheta|) (1463 . |jacobiTheta|) (1469 . |lerchPhi|)
              (1476 . |lerchPhi|) (1483 . |riemannZeta|) (1488 . |riemannZeta|)
              (1493 . |charlierC|) (1500 . |charlierC|) (1507 . |hermiteH|)
              (1513 . |hermiteH|) (1519 . |jacobiP|) (1527 . |jacobiP|)
              (1535 . |laguerreL|) (1542 . |laguerreL|) (1549 . |meixnerM|)
              (1557 . |meixnerM|) (1565 . |hypergeometricF|) (|List| $)
              (1572 . |hypergeometricF|) (1579 . |meijerG|) (1588 . |meijerG|)
              (|CombinatorialFunction| 6 $$) (1597 . ^) (1603 . |factorial|)
              (1608 . |factorial|) (1613 . |binomial|) (1619 . |binomial|)
              (1625 . |permutation|) (1631 . |permutation|)
              (1637 . |factorials|) (1642 . |factorials|) (1647 . |factorials|)
              (1653 . |factorials|) (1659 . |summation|) (1665 . |summation|)
              (|SegmentBinding| $$) (1671 . |summation|) (|SegmentBinding| $)
              (1677 . |summation|) (1683 . |product|) (1689 . |product|)
              (1695 . |product|) (1701 . |product|)
              (|LiouvillianFunction| 6 $$) (1707 . |erf|) (1712 . |erf|)
              (1717 . |erfi|) (1722 . |erfi|) (1727 . |Ei|) (1732 . |Ei|)
              (1737 . |Si|) (1742 . |Si|) (1747 . |Ci|) (1752 . |Ci|)
              (1757 . |Shi|) (1762 . |Shi|) (1767 . |Chi|) (1772 . |Chi|)
              (1777 . |li|) (1782 . |li|) (1787 . |dilog|) (1792 . |dilog|)
              (1797 . |fresnelS|) (1802 . |fresnelS|) (1807 . |fresnelC|)
              (1812 . |fresnelC|) (1817 . |integral|) (1823 . |integral|)
              (1829 . |integral|) (1835 . |integral|) (1841 . |belong?|)
              (1846 . |operator|) (1851 . |belong?|) (1856 . |operator|)
              (1861 . |belong?|) (1866 . |operator|) (1871 . |belong?|)
              (1876 . |operator|) (1881 . |belong?|) (1886 . |operator|)
              (|Fraction| 41) (1891 . |coerce|) (|Fraction| 403)
              (|PolynomialCategoryQuotientFunctions| 484 15 6 41 398)
              (1896 . |univariate|) (|SparseUnivariatePolynomial| 398)
              (1902 . |numer|) (1907 . |degree|) (1913 . |degree|)
              (1918 . |rem|) (1924 . |coerce|) (1929 . |elt|) (1935 . |Zero|)
              (1939 . ~=) (1945 . |leadingCoefficient|) (1950 . |reductum|)
              (1955 . |concat|) (1961 . |removeDuplicates|) (1966 . =)
              (1972 . |coefficients|) (|Mapping| 9 $$) (1977 . |every?|)
              (|Mapping| 41 $$)
              (|UnivariatePolynomialCategoryFunctions2| $$ 133 41 120)
              (1983 . |map|) (1989 . |retract|) (1994 . |monomial|)
              (2000 . |coerce|) (2005 . -) (2011 . =) (|Polynomial| 57)
              (2017 . |One|) (2021 . |One|) (2025 . |monomial|)
              (2032 . |coerce|) (|Mapping| 428 15) (|Mapping| 428 57)
              (|PolynomialCategoryLifting| 484 15 57 41 428) (2037 . |map|)
              (2044 . |multivariate|) 'MD 'MOP1 'MGCD1 (2050 . |coerce|)
              (|Mapping| 41 27) (|Mapping| 41 57)
              (|PolynomialCategoryLifting| (|IndexedExponents| 27) 27 57 428
                                           41)
              (2055 . |map|) (|Mapping| $$ 41)
              (|UnivariatePolynomialCategoryFunctions2| 41 120 $$ 133)
              (2062 . |map|) 'MEV2 'MOP2 'MGCD2 (|Fraction| 428) (2068 . /)
              (2074 . |coerce|) (|SparseUnivariatePolynomial| 452)
              (2079 . |coerce|) (|Mapping| 452 $$)
              (|UnivariatePolynomialCategoryFunctions2| $$ 133 452 455)
              (2084 . |map|) (2090 . =) (2096 . |One|) (2100 . |gcdPolynomial|)
              (2106 . |concat|) (2112 . |algtower|) (2117 . |kernels|)
              (2122 . |setUnion|) (2128 . |sort|) (2133 . |new|)
              (2137 . |cons|) (2143 . |setDifference|) (|List| 428)
              (2149 . |algebraicGcd|)
              (|Record| (|:| |var| 27) (|:| |coef| 455)) (|List| 473)
              (2159 . |algebraicGcd|) (2169 . |gcdPolynomial|)
              (|GcdDomain&| $$) (2175 . |gcdPolynomial|) (|Factored| 133)
              (|ExpressionFactorPolynomial| 6 $$) (2181 . |factorPolynomial|)
              (|Factored| 118) (2186 . |factorPolynomial|)
              (|IndexedExponents| 15) (2191 . |Zero|) (2195 . |monomial|)
              (|AlgebraicNumber|) (2201 . |coerce|) (|Fraction| 57) (2206 . ^)
              (2212 . ^) (2218 . |minPoly|) (2223 . |definingPolynomial|)
              (2228 . |definingPolynomial|) (2233 . |retract|)
              (2238 . |retract|) (2243 . |retractIfCan|)
              (|SparseMultivariatePolynomial| 57 12) (2248 . |numer|)
              (2253 . |denom|) (|Mapping| $$ 487) (|Kernel| 487)
              (|ExpressionSpaceFunctions2| 487 $$) (2258 . |map|)
              (|Mapping| $$ 502) (|Mapping| $$ 57)
              (|SparseMultivariatePolynomial| 57 502)
              (|PolynomialCategoryLifting| (|IndexedExponents| 502) 502 57 507
                                           $$)
              (2264 . |map|) (2271 . /) (|Union| 487 '"failed")
              (2277 . |retractIfCan|) (2282 . |coerce|) (2287 . |coerce|)
              (2292 . |belong?|) (2297 . |is?|) (|Union| 27 '#1#)
              (2303 . |retractIfCan|) (2308 . ~=)
              (|SparseUnivariatePolynomial| 487) (2314 . |Zero|)
              (2318 . |Zero|) (2322 . ~=) (2328 . |degree|) (2333 . |monomial|)
              (2339 . +) (2345 . |rootOf|) (2351 . |operator|) (2356 . |elt|)
              (|Union| 15 '"failed") (2362 . |mainVariable|)
              (2367 . |leadingCoefficient|) (2372 . |Zero|) (2376 . |ground?|)
              (2381 . ^) (2387 . *) (2393 . +) (|InputForm|) (2399 . |convert|)
              (2404 . |convert|) (|List| 10) (2409 . |eval|) (2417 . |eval|)
              (2425 . |variables|) (2430 . |concat|)
              (2435 . |removeDuplicates|) (2440 . |scripted?|) (|Mapping| 9 27)
              (2445 . |select|) (|MakeUnaryCompiledFunction| $$ $$ $$)
              (2451 . |compiledFunction|) (|Mapping| $ $) (|List| 552)
              (2457 . |eval|) (2464 . |coerce|) (|Equation| $$) (2469 . =)
              (|List| 638) (2475 . |subst|) (|PatternMatchResult| 57 $$)
              (|Pattern| 57) (|PatternMatchFunctionSpace| 57 6 $$)
              (2481 . |patternMatch|) (|PatternMatchResult| 57 $)
              (2488 . |patternMatch|) (|PatternMatchResult| (|Float|) $$)
              (|Pattern| (|Float|))
              (|PatternMatchFunctionSpace| (|Float|) 6 $$)
              (2495 . |patternMatch|) (|PatternMatchResult| (|Float|) $)
              (2502 . |patternMatch|) (2509 . |reducedSystem|)
              (2514 . |reducedSystem|) (|PatternMatchKernel| 57 $$)
              (2520 . |patternMatch|) (|PatternMatchResult| 57 45)
              (|Mapping| 576 15 561 576)
              (|PatternMatchPolynomialCategory| 57 484 15 6 45)
              (2527 . |patternMatch|) (|PatternMatchKernel| (|Float|) $$)
              (2535 . |patternMatch|) (|PatternMatchResult| (|Float|) 45)
              (|Mapping| 582 15 567 582)
              (|PatternMatchPolynomialCategory| (|Float|) 484 15 6 45)
              (2542 . |patternMatch|) (2550 . |monomial|)
              (|Record| (|:| |k| 15) (|:| |c| 57)) (|List| 587)
              (2556 . |listOfTerms|) (2561 . |zero?|) (2566 . |constantKernel|)
              (|OutputForm|) (2571 . |coerce|) (2576 . |coerce|)
              (2581 . |eval|) (2588 . |map|) (|Mapping| $$ 15)
              (|ListToMap| 15 $$) (2594 . |match|) (2602 . |subst|)
              (2609 . |kernel|) (|Union| 335 '#2="failed") (2615 . |isPlus|)
              (2620 . |first|) (|Record| (|:| |coef| 57) (|:| |var| 12))
              (|Union| 605 '#2#) (2625 . |isMult|) (2630 . |retractIfCan|)
              (|Union| 152 '#3="failed") (|Union| 611 '#3#) (|List| 118)
              (|Record| (|:| |mat| 613) (|:| |vec| (|Vector| 57)))
              (|Matrix| 57) (|Union| $ '"failed") (|Factored| $) (|Fraction| 6)
              (|Polynomial| 616) (|Fraction| 118) (|Fraction| 617)
              (|Union| 107 '#1#) (|Polynomial| $)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |coef| 335) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 627 '"failed") (|Union| 57 '#1#)
              (|Record| (|:| |var| 12) (|:| |exponent| 57)) (|Union| 630 '#2#)
              (|Record| (|:| |val| $) (|:| |exponent| 57)) (|Union| 632 '#2#)
              (|List| 35) (|Mapping| $ 335) (|List| 635) (|Union| 105 '#1#)
              (|Equation| $) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 2635 |zerosOf| 2641 |zeroOf| 2668 |zero?| 2695 |whittakerW|
              2700 |whittakerM| 2707 |weierstrassZeta| 2714 |weierstrassSigma|
              2721 |weierstrassPPrime| 2728 |weierstrassPInverse| 2735
              |weierstrassP| 2742 |weberE| 2749 |variables| 2755 |univariate|
              2765 |unitNormal| 2771 |unitCanonical| 2776 |unit?| 2781 |tower|
              2786 |tanh| 2796 |tan| 2801 |summation| 2806 |subtractIfCan| 2818
              |subst| 2824 |struveL| 2843 |struveH| 2849 |squareFreePolynomial|
              2855 |squareFreePart| 2860 |squareFree| 2865 |sqrt| 2870
              |solveLinearPolynomialEquation| 2875 |smaller?| 2881 |sizeLess?|
              2887 |sinh| 2893 |sin| 2898 |setSimplifyDenomsFlag| 2903 |sech|
              2908 |sec| 2913 |sample| 2918 |rootsOf| 2922 |rootSum| 2949
              |rootOf| 2956 |rightRecip| 2983 |rightPower| 2988 |riemannZeta|
              3000 |retractIfCan| 3005 |retract| 3045 |rem| 3085
              |reducedSystem| 3091 |reduce| 3113 |recip| 3118 |quo| 3123
              |product| 3129 |principalIdeal| 3141 |prime?| 3146 |polylog| 3151
              |polygamma| 3157 |pi| 3163 |permutation| 3167 |patternMatch| 3173
              |paren| 3187 |opposite?| 3192 |operators| 3198 |operator| 3203
              |one?| 3208 |odd?| 3213 |numerator| 3218 |numer| 3223 |number?|
              3228 |nthRoot| 3233 |multiEuclidean| 3239 |minPoly| 3245
              |meixnerM| 3250 |meijerG| 3258 |map| 3267 |mainKernel| 3273
              |lommelS2| 3278 |lommelS1| 3285 |log| 3292 |li| 3297 |lerchPhi|
              3302 |legendreQ| 3309 |legendreP| 3316 |leftRecip| 3323
              |leftPower| 3328 |lcmCoef| 3340 |lcm| 3346 |latex| 3357
              |lambertW| 3362 |laguerreL| 3367 |kummerU| 3374 |kummerM| 3381
              |kernels| 3388 |kernel| 3398 |kelvinKer| 3410 |kelvinKei| 3416
              |kelvinBer| 3422 |kelvinBei| 3428 |jacobiZeta| 3434 |jacobiTheta|
              3440 |jacobiSn| 3446 |jacobiP| 3452 |jacobiDn| 3460 |jacobiCn|
              3466 |isTimes| 3472 |isPower| 3477 |isPlus| 3482 |isMult| 3487
              |isExpt| 3492 |is?| 3509 |inv| 3521 |integral| 3526
              |hypergeometricF| 3538 |hermiteH| 3545 |height| 3551
              |hashUpdate!| 3556 |hash| 3562 |hankelH2| 3567 |hankelH1| 3573
              |ground?| 3579 |ground| 3584 |getSimplifyDenomsFlag| 3589
              |gcdPolynomial| 3593 |gcd| 3599 |fresnelS| 3610 |fresnelC| 3615
              |freeOf?| 3620 |factorials| 3632 |factorial| 3643
              |factorSquareFreePolynomial| 3648 |factorPolynomial| 3653
              |factor| 3658 |extendedEuclidean| 3663 |exquo| 3676
              |expressIdealMember| 3682 |exp| 3688 |even?| 3693 |eval| 3698
              |euclideanSize| 3842 |erfi| 3847 |erf| 3852 |elt| 3857
              |ellipticPi| 3953 |ellipticK| 3960 |ellipticF| 3965 |ellipticE|
              3971 |divide| 3982 |distribute| 3988 |dilog| 3999 |digamma| 4004
              |differentiate| 4009 |denominator| 4035 |denom| 4040
              |definingPolynomial| 4045 |csch| 4050 |csc| 4055 |coth| 4060
              |cot| 4065 |cosh| 4070 |cos| 4075 |convert| 4080 |conjugate| 4100
              |conditionP| 4111 |commutator| 4116 |coerce| 4122 |charthRoot|
              4192 |charlierC| 4197 |characteristic| 4204 |box| 4208 |binomial|
              4213 |besselY| 4219 |besselK| 4225 |besselJ| 4231 |besselI| 4237
              |belong?| 4243 |atanh| 4248 |atan| 4253 |associator| 4258
              |associates?| 4265 |asinh| 4271 |asin| 4276 |asech| 4281 |asec|
              4286 |applyQuote| 4291 |antiCommutator| 4327 |annihilate?| 4333
              |angerJ| 4339 |algtower| 4345 |airyBiPrime| 4355 |airyBi| 4360
              |airyAiPrime| 4365 |airyAi| 4370 |acsch| 4375 |acsc| 4380 |acoth|
              4385 |acot| 4390 |acosh| 4395 |acos| 4400 |abs| 4405 ^ 4410
              |Zero| 4440 |Si| 4444 |Shi| 4449 |One| 4454 |Gamma| 4458 |Ei|
              4469 D 4474 |Ci| 4500 |Chi| 4505 |Beta| 4510 = 4516 / 4522 - 4534
              + 4545 * 4551)
           'NIL
           (CONS
            (|makeByteWordVec2| 30
                                '(1 0 1 1 27 1 1 1 1 1 1 1 5 1 1 1 1 2 3 4 5 7
                                  5 22 5 22 1 1 2 5 1 6 2 5 1 1 6 2 2 5 22 8 16
                                  16 5 18 0 0 29 17 18 22 0 0 13 14 18 1 30 0 0
                                  0 0 0 0 21 1 1 5 15 1 1 20 0 0 0 0 0 0 0 0 21
                                  1 1 1 1 5 9 10 11 12 15 19 1 1 1 1 1 1 1 1 1
                                  20))
            (CONS
             '#(|AlgebraicallyClosedFunctionSpace&| |FunctionSpace&|
                |AlgebraicallyClosedField&| |Field&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |UniqueFactorizationDomain&| NIL |GcdDomain&| NIL NIL
                |DivisionRing&| |FullyLinearlyExplicitOver&| NIL |Algebra&|
                |EntireRing&| |Algebra&| |Algebra&| NIL NIL NIL NIL
                |PartialDifferentialRing&| NIL NIL |Rng&| |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL NIL |NonAssociativeRng&| |Group&| |AbelianGroup&| NIL NIL
                NIL |ExpressionSpace&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                NIL |NonAssociativeSemiRng&| NIL |FullyRetractableTo&| NIL NIL
                |Magma&| NIL |AbelianSemiGroup&| |SetCategory&|
                |RetractableTo&| NIL |RetractableTo&| |Evalable&|
                |RetractableTo&| |RetractableTo&| |RetractableTo&| NIL
                |RetractableTo&| |RetractableTo&|
                |TranscendentalFunctionCategory&| NIL |RetractableTo&|
                |BasicType&| NIL NIL NIL |InnerEvalable&| |InnerEvalable&| NIL
                NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                NIL |RadicalCategory&| NIL)
             (CONS
              '#((|AlgebraicallyClosedFunctionSpace| 6) (|FunctionSpace| 6)
                 (|AlgebraicallyClosedField|) (|Field|)
                 (|PolynomialFactorizationExplicit|) (|EuclideanDomain|)
                 (|UniqueFactorizationDomain|) (|PrincipalIdealDomain|)
                 (|GcdDomain|) (|IntegralDomain|) (|LeftOreRing|)
                 (|DivisionRing|) (|FullyLinearlyExplicitOver| 6)
                 (|CommutativeRing|) (|Algebra| $$) (|EntireRing|)
                 (|Algebra| 489) (|Algebra| 6) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|LinearlyExplicitOver| 6)
                 (|LinearlyExplicitOver| 57) (|PartialDifferentialRing| 27)
                 (|Ring|) (|SemiRing|) (|Rng|) (|Module| $$) (|Module| 489)
                 (|Module| 6) (|SemiRng|) (|BiModule| 489 489)
                 (|BiModule| $$ $$) (|BiModule| 6 6) (|NonAssociativeRing|)
                 (|LeftModule| 489) (|RightModule| 489) (|LeftModule| $$)
                 (|LeftModule| 6) (|RightModule| 6) (|RightModule| $$)
                 (|NonAssociativeRng|) (|Group|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|ExpressionSpace|) (|FullyPatternMatchable| 6)
                 (|AbelianMonoid|) (|MagmaWithUnit|) (|SemiGroup|)
                 (|NonAssociativeSemiRng|) (|Comparable|)
                 (|FullyRetractableTo| 6) (|PatternMatchable| (|Float|))
                 (|PatternMatchable| 57) (|Magma|)
                 (|LiouvillianFunctionCategory|) (|AbelianSemiGroup|)
                 (|SetCategory|) (|RetractableTo| 6) (|Patternable| 6)
                 (|RetractableTo| 27) (|Evalable| $$) (|RetractableTo| 15)
                 (|RetractableTo| 489)
                 (|RetractableTo| (|Fraction| (|Polynomial| 6)))
                 (|CommutativeStar|) (|RetractableTo| (|Polynomial| 6))
                 (|RetractableTo| 57) (|TranscendentalFunctionCategory|)
                 (|CombinatorialOpsCategory|) (|RetractableTo| 487)
                 (|BasicType|) (|CoercibleFrom| 6) (|Type|)
                 (|CoercibleFrom| 27) (|InnerEvalable| $$ $$)
                 (|InnerEvalable| 15 $$) (|CoercibleFrom| 15)
                 (|CoercibleTo| 592) (|CoercibleFrom| 489)
                 (|CoercibleFrom| (|Fraction| (|Polynomial| 6)))
                 (|noZeroDivisors|) (|canonicalUnitNormal|)
                 (|canonicalsClosed|) (|CoercibleFrom| (|Polynomial| 6))
                 (|TwoSidedRecip|) (|ConvertibleTo| 538) (|ConvertibleTo| 567)
                 (|ConvertibleTo| 561) (|CoercibleFrom| 57) (|unitsKnown|)
                 (|SpecialFunctionCategory|) (|PrimitiveFunctionCategory|)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|)
                 (|CombinatorialFunctionCategory|) (|RadicalCategory|)
                 (|CoercibleFrom| 487))
              (|makeByteWordVec2| 641
                                  '(1 0 12 0 13 1 16 14 15 17 1 0 18 0 19 1 20
                                    9 10 21 1 20 10 10 22 1 23 9 10 24 1 23 10
                                    10 25 1 10 9 0 26 2 10 9 0 27 28 1 10 27 0
                                    29 1 15 0 27 30 1 15 10 0 31 1 10 32 0 33 1
                                    10 0 27 34 2 10 0 27 35 36 1 0 10 10 37 1
                                    39 38 0 40 3 43 41 39 38 42 44 0 45 0 46 0
                                    0 0 47 0 45 0 48 0 0 0 49 0 6 0 50 2 45 9 0
                                    0 51 1 0 9 0 52 1 45 9 0 53 1 0 9 0 54 1 45
                                    0 0 55 1 0 0 0 56 2 45 0 57 0 58 2 0 0 57 0
                                    59 1 45 0 57 60 1 0 0 57 61 2 45 0 0 0 62 2
                                    0 0 0 0 63 2 45 0 0 0 64 2 0 0 0 0 65 2 45
                                    0 0 0 66 2 0 0 0 0 67 2 45 0 0 0 68 2 0 0 0
                                    0 69 1 0 9 0 70 1 0 71 0 72 1 0 9 0 73 1 0
                                    74 0 75 2 0 9 0 27 76 1 42 15 0 77 1 15 78
                                    0 79 1 78 35 0 80 2 78 2 0 57 81 2 45 0 0
                                    57 82 1 0 74 0 83 2 0 0 0 0 84 1 78 2 0 85
                                    1 78 2 0 86 0 6 0 87 1 0 0 0 88 1 0 0 0 89
                                    2 0 0 0 35 90 2 0 0 0 57 91 2 0 0 0 92 93 2
                                    45 9 0 0 94 2 0 9 0 0 95 2 0 9 0 0 96 1 45
                                    41 0 97 1 0 98 0 99 1 45 41 0 100 1 0 98 0
                                    101 0 41 0 103 1 0 0 98 104 1 0 0 105 106 1
                                    107 105 0 108 1 107 105 0 109 1 0 0 107 110
                                    1 0 0 0 111 2 42 0 112 0 113 2 114 2 2 42
                                    115 2 15 9 0 27 116 2 0 9 0 0 117 2 41 118
                                    0 15 119 1 120 41 0 121 1 120 0 0 122 2 41
                                    0 0 0 123 3 41 0 0 15 35 124 2 41 0 0 0 125
                                    2 45 0 41 41 126 0 0 9 127 1 0 9 9 128 2 42
                                    15 0 57 129 0 130 0 131 1 0 118 12 132 3
                                    134 133 2 15 133 135 1 0 0 12 136 3 133 0 0
                                    130 2 137 1 133 2 0 138 2 0 0 98 98 139 2
                                    141 0 140 0 142 1 45 143 144 145 1 41 146
                                    144 147 1 0 146 144 148 2 149 0 140 0 150 2
                                    45 151 144 152 153 2 41 154 144 152 155 2 0
                                    154 144 152 156 2 42 9 15 0 157 2 42 0 15 0
                                    158 2 159 2 133 27 160 2 0 0 118 27 161 3
                                    159 2 2 133 27 162 3 0 0 0 118 27 163 0 164
                                    2 165 0 0 0 166 1 164 2 2 167 1 0 0 0 168 1
                                    164 2 2 169 1 0 0 0 170 1 164 2 2 171 1 0 0
                                    0 172 1 164 2 2 173 1 0 0 0 174 1 164 2 2
                                    175 1 0 0 0 176 1 164 2 2 177 1 0 0 0 178 1
                                    164 2 2 179 1 0 0 0 180 1 164 2 2 181 1 0 0
                                    0 182 1 164 2 2 183 1 0 0 0 184 1 164 2 2
                                    185 1 0 0 0 186 1 164 2 2 187 1 0 0 0 188 1
                                    164 2 2 189 1 0 0 0 190 1 164 2 2 191 1 0 0
                                    0 192 1 164 2 2 193 1 0 0 0 194 1 164 2 2
                                    195 1 0 0 0 196 1 164 2 2 197 1 0 0 0 198 1
                                    164 2 2 199 1 0 0 0 200 1 164 2 2 201 1 0 0
                                    0 202 1 164 2 2 203 1 0 0 0 204 1 164 2 2
                                    205 1 0 0 0 206 1 164 2 2 207 1 0 0 0 208 1
                                    164 2 2 209 1 0 0 0 210 1 164 2 2 211 1 0 0
                                    0 212 1 164 2 2 213 1 0 0 0 214 1 164 2 2
                                    215 1 0 0 0 216 1 164 2 2 217 1 0 0 0 218 1
                                    219 2 2 220 1 0 0 0 221 1 219 2 2 222 1 0 0
                                    0 223 1 219 2 2 224 1 0 0 0 225 2 219 2 2 2
                                    226 2 0 0 0 0 227 2 219 2 2 2 228 2 0 0 0 0
                                    229 1 219 2 2 230 1 0 0 0 231 2 219 2 2 2
                                    232 2 0 0 0 0 233 2 219 2 2 2 234 2 0 0 0 0
                                    235 2 219 2 2 2 236 2 0 0 0 0 237 2 219 2 2
                                    2 238 2 0 0 0 0 239 2 219 2 2 2 240 2 0 0 0
                                    0 241 1 219 2 2 242 1 0 0 0 243 1 219 2 2
                                    244 1 0 0 0 245 1 219 2 2 246 1 0 0 0 247 1
                                    219 2 2 248 1 0 0 0 249 1 219 2 2 250 1 0 0
                                    0 251 2 219 2 2 2 252 2 0 0 0 0 253 3 219 2
                                    2 2 2 254 3 0 0 0 0 0 255 3 219 2 2 2 2 256
                                    3 0 0 0 0 0 257 3 219 2 2 2 2 258 3 0 0 0 0
                                    0 259 3 219 2 2 2 2 260 3 0 0 0 0 0 261 3
                                    219 2 2 2 2 262 3 0 0 0 0 0 263 3 219 2 2 2
                                    2 264 3 0 0 0 0 0 265 3 219 2 2 2 2 266 3 0
                                    0 0 0 0 267 2 219 2 2 2 268 2 0 0 0 0 269 2
                                    219 2 2 2 270 2 0 0 0 0 271 2 219 2 2 2 272
                                    2 0 0 0 0 273 2 219 2 2 2 274 2 0 0 0 0 275
                                    2 219 2 2 2 276 2 0 0 0 0 277 2 219 2 2 2
                                    278 2 0 0 0 0 279 3 219 2 2 2 2 280 3 0 0 0
                                    0 0 281 3 219 2 2 2 2 282 3 0 0 0 0 0 283 3
                                    219 2 2 2 2 284 3 0 0 0 0 0 285 3 219 2 2 2
                                    2 286 3 0 0 0 0 0 287 3 219 2 2 2 2 288 3 0
                                    0 0 0 0 289 3 219 2 2 2 2 290 3 0 0 0 0 0
                                    291 2 219 2 2 2 292 2 0 0 0 0 293 2 219 2 2
                                    2 294 2 0 0 0 0 295 2 219 2 2 2 296 2 0 0 0
                                    0 297 2 219 2 2 2 298 2 0 0 0 0 299 1 219 2
                                    2 300 1 0 0 0 301 1 219 2 2 302 1 0 0 0 303
                                    2 219 2 2 2 304 2 0 0 0 0 305 2 219 2 2 2
                                    306 2 0 0 0 0 307 3 219 2 2 2 2 308 3 0 0 0
                                    0 0 309 2 219 2 2 2 310 2 0 0 0 0 311 2 219
                                    2 2 2 312 2 0 0 0 0 313 2 219 2 2 2 314 2 0
                                    0 0 0 315 2 219 2 2 2 316 2 0 0 0 0 317 2
                                    219 2 2 2 318 2 0 0 0 0 319 3 219 2 2 2 2
                                    320 3 0 0 0 0 0 321 1 219 2 2 322 1 0 0 0
                                    323 3 219 2 2 2 2 324 3 0 0 0 0 0 325 2 219
                                    2 2 2 326 2 0 0 0 0 327 4 219 2 2 2 2 2 328
                                    4 0 0 0 0 0 0 329 3 219 2 2 2 2 330 3 0 0 0
                                    0 0 331 4 219 2 2 2 2 2 332 4 0 0 0 0 0 0
                                    333 3 219 2 78 78 2 334 3 0 0 335 335 0 336
                                    5 219 2 78 78 78 78 2 337 5 0 0 335 335 335
                                    335 0 338 2 339 2 2 2 340 1 339 2 2 341 1 0
                                    0 0 342 2 339 2 2 2 343 2 0 0 0 0 344 2 339
                                    2 2 2 345 2 0 0 0 0 346 1 339 2 2 347 1 0 0
                                    0 348 2 339 2 2 27 349 2 0 0 0 27 350 2 339
                                    2 2 27 351 2 0 0 0 27 352 2 339 2 2 353 354
                                    2 0 0 0 355 356 2 339 2 2 27 357 2 0 0 0 27
                                    358 2 339 2 2 353 359 2 0 0 0 355 360 1 361
                                    2 2 362 1 0 0 0 363 1 361 2 2 364 1 0 0 0
                                    365 1 361 2 2 366 1 0 0 0 367 1 361 2 2 368
                                    1 0 0 0 369 1 361 2 2 370 1 0 0 0 371 1 361
                                    2 2 372 1 0 0 0 373 1 361 2 2 374 1 0 0 0
                                    375 1 361 2 2 376 1 0 0 0 377 1 361 2 2 378
                                    1 0 0 0 379 1 361 2 2 380 1 0 0 0 381 1 361
                                    2 2 382 1 0 0 0 383 2 361 2 2 27 384 2 0 0
                                    0 27 385 2 361 2 2 353 386 2 0 0 0 355 387
                                    1 159 9 10 388 1 159 10 10 389 1 164 9 10
                                    390 1 164 10 10 391 1 339 9 10 392 1 339 10
                                    10 393 1 361 9 10 394 1 361 10 10 395 1 219
                                    9 10 396 1 219 10 10 397 1 398 0 41 399 2
                                    401 400 398 15 402 1 400 403 0 404 2 41 35
                                    0 15 405 1 133 35 0 406 2 133 0 0 0 407 1
                                    41 0 15 408 2 403 398 0 398 409 0 133 0 410
                                    2 133 9 0 0 411 1 133 2 0 412 1 133 0 0 413
                                    2 42 0 0 0 414 1 42 0 0 415 2 41 9 0 0 416
                                    1 133 78 0 417 2 78 9 418 0 419 2 421 120
                                    420 133 422 1 0 6 0 423 2 120 0 41 35 424 1
                                    120 0 41 425 2 120 0 0 0 426 2 15 9 0 0 427
                                    0 428 0 429 0 35 0 430 3 428 0 0 27 35 431
                                    1 428 0 57 432 3 435 428 433 434 41 436 2
                                    41 0 118 15 437 1 41 0 57 441 3 444 41 442
                                    443 428 445 2 447 133 446 120 448 2 452 0
                                    428 428 453 1 452 0 428 454 1 455 0 452 456
                                    2 458 455 457 133 459 2 133 9 0 0 460 0 133
                                    0 461 2 45 118 118 118 462 2 78 0 0 0 463 1
                                    0 74 335 464 1 0 74 335 465 2 42 0 0 0 466
                                    1 42 0 0 467 0 27 0 468 2 42 0 15 0 469 2
                                    38 0 0 0 470 6 440 428 428 428 471 38 27 38
                                    472 6 451 428 473 473 474 38 27 38 475 2 0
                                    118 118 118 476 2 477 118 118 118 478 1 480
                                    479 133 481 1 0 482 118 483 0 484 0 485 2
                                    41 0 6 484 486 1 0 0 487 488 2 159 2 2 489
                                    490 2 0 0 0 489 491 1 159 133 15 492 1 159
                                    2 2 493 1 0 0 0 494 1 45 489 0 495 1 0 489
                                    0 496 1 45 71 0 497 1 487 498 0 499 1 487
                                    498 0 500 2 503 2 501 502 504 3 508 2 505
                                    506 507 509 2 487 0 0 0 510 1 0 511 0 512 1
                                    0 0 6 513 1 487 0 489 514 1 487 9 10 515 2
                                    10 9 0 27 516 1 0 517 0 518 2 41 9 0 0 519
                                    0 520 0 521 0 120 0 522 2 120 9 0 0 523 1
                                    120 35 0 524 2 520 0 487 35 525 2 520 0 0 0
                                    526 2 487 0 118 27 527 1 487 10 10 528 2
                                    487 0 10 335 529 1 41 530 0 531 1 41 6 0
                                    532 0 487 0 533 1 120 9 0 534 2 487 0 0 35
                                    535 2 487 0 0 0 536 2 487 0 0 0 537 1 45
                                    538 0 539 1 0 538 0 540 4 0 0 0 541 335 27
                                    542 4 0 0 0 10 0 27 543 1 0 38 0 544 1 38 0
                                    335 545 1 38 0 0 546 1 27 9 0 547 2 38 0
                                    548 0 549 2 550 140 2 27 551 3 0 0 0 541
                                    553 554 1 0 0 27 555 2 556 0 2 2 557 2 0 0
                                    0 558 559 3 562 560 2 561 560 563 3 0 564 0
                                    561 564 565 3 568 566 2 567 566 569 3 0 570
                                    0 567 570 571 1 45 146 144 572 2 45 154 144
                                    152 573 3 574 560 15 561 560 575 4 578 576
                                    45 561 576 577 579 3 580 566 15 567 566 581
                                    4 584 582 45 567 582 583 585 2 45 0 57 15
                                    586 1 45 588 0 589 1 6 9 0 590 1 16 15 6
                                    591 1 45 592 0 593 1 0 592 0 594 3 0 0 0 74
                                    335 595 2 0 0 552 12 596 4 598 2 42 78 15
                                    597 599 3 0 0 0 74 335 600 2 0 0 10 335 601
                                    1 0 602 0 603 1 588 587 0 604 1 0 606 0 607
                                    1 0 14 0 608 2 0 9 0 0 117 2 1 335 0 27 1 1
                                    1 335 0 1 2 1 335 118 27 1 1 1 335 118 1 1
                                    1 335 621 1 2 1 0 0 27 1 1 1 0 0 1 2 1 0
                                    118 27 1 1 1 0 621 1 1 1 0 118 1 1 28 9 0
                                    54 3 1 0 0 0 0 267 3 1 0 0 0 0 265 3 1 0 0
                                    0 0 261 3 1 0 0 0 0 259 3 1 0 0 0 0 257 3 1
                                    0 0 0 0 263 3 1 0 0 0 0 255 2 1 0 0 0 271 1
                                    0 38 335 1 1 0 38 0 544 2 1 618 0 12 1 1 1
                                    622 0 1 1 1 0 0 1 1 1 9 0 1 1 0 74 335 1 1
                                    0 74 0 1 1 1 0 0 200 1 1 0 0 176 2 1 0 0
                                    355 356 2 1 0 0 27 352 2 16 614 0 0 1 3 0 0
                                    0 74 335 600 2 0 0 0 558 559 2 0 0 0 638 1
                                    2 1 0 0 0 275 2 1 0 0 0 273 1 27 482 118 1
                                    1 1 0 0 1 1 1 615 0 1 1 1 0 0 1 2 27 610
                                    611 118 1 2 0 9 0 0 95 2 1 9 0 0 1 1 1 0 0
                                    196 1 1 0 0 172 1 1 9 9 128 1 1 0 0 204 1 1
                                    0 0 180 0 31 0 1 2 1 335 0 27 1 1 1 335 0 1
                                    2 1 335 118 27 1 1 1 335 621 1 1 1 335 118
                                    1 3 1 0 0 118 27 163 2 1 0 0 27 1 1 1 0 0 1
                                    1 1 0 118 1 2 1 0 118 27 161 1 1 0 621 1 1
                                    17 614 0 1 2 17 0 0 35 1 2 17 0 0 92 1 1 1
                                    0 0 323 1 20 511 0 512 1 21 71 0 72 1 1 620
                                    0 1 1 15 629 0 1 1 5 637 0 1 1 0 14 0 608 1
                                    0 517 0 518 1 0 18 0 19 1 20 487 0 1 1 21
                                    489 0 496 1 1 107 0 1 1 15 57 0 1 1 5 105 0
                                    1 1 0 6 0 423 1 0 27 0 1 1 0 12 0 13 2 1 0
                                    0 0 1 2 25 612 144 152 1 1 25 613 144 1 2 5
                                    154 144 152 156 1 5 146 144 148 1 1 0 0 111
                                    1 17 614 0 1 2 1 0 0 0 1 2 1 0 0 355 360 2
                                    1 0 0 27 358 1 1 624 335 1 1 1 9 0 1 2 1 0
                                    0 0 253 2 1 0 0 0 233 0 1 0 166 2 1 0 0 0
                                    346 3 13 570 0 567 570 571 3 14 564 0 561
                                    564 565 1 0 0 0 1 2 28 9 0 0 1 1 0 541 0 1
                                    1 0 10 10 37 1 17 9 0 52 1 32 9 0 1 1 5 0 0
                                    88 1 5 98 0 99 1 1 9 0 73 2 1 0 0 57 1 2 1
                                    602 335 0 1 1 33 118 12 132 4 1 0 0 0 0 0
                                    333 5 34 0 335 335 335 335 0 338 2 0 0 552
                                    12 596 1 0 18 0 1 3 1 0 0 0 0 283 3 1 0 0 0
                                    0 281 1 1 0 0 170 1 1 0 0 377 3 1 0 0 0 0
                                    321 3 1 0 0 0 0 291 3 1 0 0 0 0 289 1 17
                                    614 0 1 2 17 0 0 35 1 2 17 0 0 92 1 2 1 623
                                    0 0 1 2 1 0 0 0 1 1 1 0 335 1 1 0 639 0 1 1
                                    1 0 0 251 3 1 0 0 0 0 331 3 1 0 0 0 0 287 3
                                    1 0 0 0 0 285 1 0 74 335 465 1 0 74 0 75 2
                                    0 0 10 335 601 2 0 0 10 0 1 2 1 0 0 0 299 2
                                    1 0 0 0 297 2 1 0 0 0 295 2 1 0 0 0 293 2 1
                                    0 0 0 317 2 1 0 0 0 319 2 1 0 0 0 311 4 1 0
                                    0 0 0 0 329 2 1 0 0 0 315 2 1 0 0 0 313 1
                                    17 602 0 1 1 5 633 0 1 1 28 602 0 603 1 28
                                    606 0 607 2 5 631 0 10 1 2 5 631 0 27 1 1
                                    17 631 0 1 2 0 9 0 27 76 2 0 9 0 10 1 1 9 0
                                    0 1 2 1 0 0 27 385 2 1 0 0 355 387 3 34 0
                                    335 335 0 336 2 1 0 0 0 327 1 0 35 0 1 2 0
                                    641 641 0 1 1 0 640 0 1 2 1 0 0 0 279 2 1 0
                                    0 0 277 1 0 9 0 70 1 0 6 0 1 0 1 9 127 2 1
                                    118 118 118 476 1 1 0 335 1 2 1 0 0 0 1 1 1
                                    0 0 381 1 1 0 0 383 2 0 9 0 27 1 2 0 9 0 0
                                    1 1 1 0 0 348 2 1 0 0 27 350 1 1 0 0 342 1
                                    27 482 118 1 1 27 482 118 483 1 1 615 0 1 2
                                    1 626 0 0 1 3 1 628 0 0 0 1 2 1 614 0 0 1 2
                                    1 602 335 0 1 1 1 0 0 168 1 32 9 0 1 4 10 0
                                    0 10 0 27 543 4 10 0 0 541 335 27 542 4 5 0
                                    0 38 634 553 1 4 5 0 0 27 35 635 1 4 5 0 0
                                    38 634 636 1 4 5 0 0 27 35 552 1 3 0 0 0 10
                                    552 1 3 0 0 0 541 636 1 3 0 0 0 10 635 1 3
                                    0 0 0 27 552 1 3 0 0 0 541 553 554 3 0 0 0
                                    27 635 1 3 0 0 0 38 553 1 3 0 0 0 38 636 1
                                    3 0 0 0 0 0 1 3 0 0 0 335 335 1 2 0 0 0 638
                                    1 3 0 0 0 74 335 595 2 0 0 0 558 1 3 0 0 0
                                    12 0 1 1 1 35 0 1 1 1 0 0 365 1 1 0 0 363 2
                                    0 0 10 335 1 10 0 0 10 0 0 0 0 0 0 0 0 0 1
                                    8 0 0 10 0 0 0 0 0 0 0 1 9 0 0 10 0 0 0 0 0
                                    0 0 0 1 6 0 0 10 0 0 0 0 0 1 7 0 0 10 0 0 0
                                    0 0 0 1 5 0 0 10 0 0 0 0 1 3 0 0 10 0 0 1 4
                                    0 0 10 0 0 0 1 2 0 0 10 0 1 3 1 0 0 0 0 309
                                    1 1 0 0 301 2 1 0 0 0 307 2 1 0 0 0 305 1 1
                                    0 0 303 2 1 625 0 0 1 1 0 0 0 1 2 0 0 0 0 1
                                    1 1 0 0 379 1 1 0 0 231 3 5 0 0 27 35 1 3 5
                                    0 0 38 634 1 2 5 0 0 38 1 2 5 0 0 27 1 1 1
                                    0 0 89 1 1 98 0 101 1 33 0 0 494 1 1 0 0
                                    206 1 1 0 0 182 1 1 0 0 202 1 1 0 0 178 1 1
                                    0 0 198 1 1 0 0 174 1 10 538 0 540 1 11 567
                                    0 1 1 12 561 0 1 1 1 0 615 1 2 8 0 0 0 1 1
                                    1 0 0 223 1 35 609 144 1 2 19 0 0 0 1 1 20
                                    0 487 488 1 24 0 489 1 1 23 0 57 61 1 1 0
                                    616 1 1 1 0 617 1 1 1 0 619 1 1 1 0 107 110
                                    1 1 0 0 1 1 5 0 98 104 1 5 0 105 106 1 0 0
                                    6 513 1 0 0 27 555 1 0 0 12 136 1 0 592 0
                                    594 1 36 614 0 1 3 1 0 0 0 0 325 0 5 35 1 1
                                    0 0 0 1 2 1 0 0 0 344 2 1 0 0 0 237 2 1 0 0
                                    0 241 2 1 0 0 0 235 2 1 0 0 0 239 1 0 9 10
                                    11 1 1 0 0 212 1 1 0 0 188 3 5 0 0 0 0 1 2
                                    1 9 0 0 1 1 1 0 0 208 1 1 0 0 184 1 1 0 0
                                    216 1 1 0 0 192 5 0 0 27 0 0 0 0 1 2 0 0 27
                                    335 1 4 0 0 27 0 0 0 1 2 0 0 27 0 1 3 0 0
                                    27 0 0 1 2 5 0 0 0 1 2 5 9 0 0 1 2 1 0 0 0
                                    269 1 1 74 335 464 1 1 74 0 83 1 1 0 0 249
                                    1 1 0 0 247 1 1 0 0 245 1 1 0 0 243 1 1 0 0
                                    218 1 1 0 0 194 1 1 0 0 214 1 1 0 0 190 1 1
                                    0 0 210 1 1 0 0 186 1 1 0 0 221 2 9 0 0 57
                                    91 2 1 0 0 0 84 2 1 0 0 489 491 2 17 0 0 35
                                    90 2 17 0 0 92 93 0 28 0 47 1 1 0 0 369 1 1
                                    0 0 373 0 17 0 49 1 1 0 0 225 2 1 0 0 0 227
                                    1 1 0 0 367 3 5 0 0 38 634 1 2 5 0 0 38 1 3
                                    5 0 0 27 35 1 2 5 0 0 27 1 1 1 0 0 371 1 1
                                    0 0 375 2 1 0 0 0 229 2 0 9 0 0 96 2 9 0 0
                                    0 69 2 1 0 98 98 139 1 16 0 0 56 2 16 0 0 0
                                    67 2 28 0 0 0 65 2 16 0 57 0 59 2 28 0 35 0
                                    1 2 28 0 92 0 1 2 2 0 6 0 1 2 2 0 0 6 1 2 1
                                    0 0 489 1 2 1 0 489 0 1 2 17 0 0 0 63)))))
           '|lookupComplete|)) 
