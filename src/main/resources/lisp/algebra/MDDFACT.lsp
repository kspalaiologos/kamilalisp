
(SDEFUN |MDDFACT;reduction| ((|u| (U)) (|p| (|Integer|)) ($ (U)))
        (SPROG NIL
               (COND ((ZEROP |p|) |u|)
                     ('T
                      (SPADCALL (CONS #'|MDDFACT;reduction!0| (VECTOR $ |p|))
                                |u| (QREFELT $ 10)))))) 

(SDEFUN |MDDFACT;reduction!0| ((|i1| NIL) ($$ NIL))
        (PROG (|p| $)
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |i1| |p| (QREFELT $ 8)))))) 

(SDEFUN |MDDFACT;merge|
        ((|p| (|Integer|)) (|q| (|Integer|))
         ($ (|Union| (|Integer|) "failed")))
        (COND ((EQL |p| |q|) (CONS 0 |p|)) ((EQL |p| 0) (CONS 0 |q|))
              ((EQL |q| 0) (CONS 0 |p|)) ('T (CONS 1 "failed")))) 

(SDEFUN |MDDFACT;modInverse|
        ((|c| (|Integer|)) (|p| (|Integer|)) ($ (|Integer|)))
        (SPROG ((#1=#:G713 NIL))
               (QCAR
                (PROG2 (LETT #1# (SPADCALL |c| |p| 1 (QREFELT $ 15)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|Record| (|:| |coef1| (|Integer|))
                                            (|:| |coef2| (|Integer|)))
                                  (|Union|
                                   (|Record| (|:| |coef1| (|Integer|))
                                             (|:| |coef2| (|Integer|)))
                                   "failed")
                                  #1#))))) 

(SDEFUN |MDDFACT;exactquo|
        ((|u| (U)) (|v| (U)) (|p| (|Integer|)) ($ (|Union| U "failed")))
        (SPROG
         ((|r| (|Record| (|:| |quotient| U) (|:| |remainder| U)))
          (|invlcv| (|Integer|)))
         (SEQ
          (LETT |invlcv|
                (|MDDFACT;modInverse| (SPADCALL |v| (QREFELT $ 16)) |p| $))
          (LETT |r|
                (SPADCALL |u|
                          (|MDDFACT;reduction|
                           (SPADCALL |invlcv| |v| (QREFELT $ 17)) |p| $)
                          (QREFELT $ 19)))
          (EXIT
           (COND
            ((SPADCALL (|MDDFACT;reduction| (QCDR |r|) |p| $)
                       (|spadConstant| $ 11) (QREFELT $ 21))
             (CONS 1 "failed"))
            ('T
             (CONS 0
                   (|MDDFACT;reduction|
                    (SPADCALL |invlcv| (QCAR |r|) (QREFELT $ 17)) |p| $)))))))) 

(SDEFUN |MDDFACT;lc| ((|u| (EMR)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 23)) (QREFELT $ 16))) 

(SDEFUN |MDDFACT;degree| ((|u| (EMR)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 23)) (QREFELT $ 25))) 

(SDEFUN |MDDFACT;makeMonic| ((|u| (EMR)) ($ (EMR)))
        (SPADCALL
         (|MDDFACT;modInverse| (|MDDFACT;lc| |u| $)
          (SPADCALL |u| (QREFELT $ 26)) $)
         |u| (QREFELT $ 27))) 

(SDEFUN |MDDFACT;exptmod|
        ((|u1| (EMR)) (|i| (|Integer|)) (|u2| (EMR)) ($ (EMR)))
        (SPROG ((|ans| (EMR)))
               (SEQ
                (COND
                 ((< |i| 0)
                  (|error| "negative exponentiation not allowed for exptMod"))
                 ('T
                  (SEQ (LETT |ans| (|spadConstant| $ 28))
                       (SEQ G190 (COND ((NULL (> |i| 0)) (GO G191)))
                            (SEQ
                             (COND
                              ((ODDP |i|)
                               (LETT |ans|
                                     (SPADCALL
                                      (SPADCALL |ans| |u1| (QREFELT $ 29)) |u2|
                                      (QREFELT $ 30)))))
                             (LETT |i| (QUOTIENT2 |i| 2))
                             (EXIT
                              (LETT |u1|
                                    (SPADCALL
                                     (SPADCALL |u1| |u1| (QREFELT $ 29)) |u2|
                                     (QREFELT $ 30)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |ans|))))))) 

(SDEFUN |MDDFACT;ddfactor| ((|u| (EMR)) ($ (|List| EMR)))
        (SPROG
         ((#1=#:G758 NIL) (|f| NIL) (#2=#:G757 NIL) (|ans| (|List| EMR))
          (|c| (|Integer|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |c| (|MDDFACT;lc| |u| $)) 1 (QREFELT $ 31))
            (LETT |u| (|MDDFACT;makeMonic| |u| $))))
          (LETT |ans| (|MDDFACT;sepfact| (|MDDFACT;ddfact| |u| $) $))
          (EXIT
           (CONS (SPADCALL |c| (QREFELT $ 32))
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |f| NIL) (LETT #1# |ans|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((> (|MDDFACT;degree| |f| $) 0)
                           (LETT #2#
                                 (CONS (|MDDFACT;makeMonic| |f| $) #2#))))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |MDDFACT;gcd;2UIU;10| ((|u| (U)) (|v| (U)) (|q| (|Integer|)) ($ (U)))
        (SPADCALL
         (SPADCALL (SPADCALL |u| |q| (QREFELT $ 33))
                   (SPADCALL |v| |q| (QREFELT $ 33)) (QREFELT $ 34))
         (QREFELT $ 23))) 

(SDEFUN |MDDFACT;ddfact|
        ((|u| (EMR))
         ($ (|List| (|Record| (|:| |factor| EMR) (|:| |degree| (|Integer|))))))
        (SPROG
         ((#1=#:G770 NIL) (#2=#:G771 NIL) (|d| (|Integer|))
          (|ans|
           (|List| (|Record| (|:| |factor| EMR) (|:| |degree| (|Integer|)))))
          (|g| (EMR)) (|w| (EMR)) (|c| (|Integer|)) (|m| (EMR))
          (|p| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |p| (SPADCALL |u| (QREFELT $ 26)))
                (LETT |w|
                      (SPADCALL (SPADCALL 1 1 (QREFELT $ 36)) |p|
                                (QREFELT $ 33)))
                (LETT |m| |w|) (LETT |d| 1)
                (COND
                 ((SPADCALL (LETT |c| (|MDDFACT;lc| |u| $)) 1 (QREFELT $ 31))
                  (LETT |u| (|MDDFACT;makeMonic| |u| $))))
                (LETT |ans| NIL)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |w| (|MDDFACT;exptmod| |w| |p| |u| $))
                           (LETT |g|
                                 (SPADCALL (SPADCALL |w| |m| (QREFELT $ 37))
                                           |u| (QREFELT $ 34)))
                           (COND
                            ((> (|MDDFACT;degree| |g| $) 0)
                             (SEQ (LETT |g| (|MDDFACT;makeMonic| |g| $))
                                  (LETT |ans| (CONS (CONS |g| |d|) |ans|))
                                  (EXIT
                                   (LETT |u|
                                         (SPADCALL |u| |g| (QREFELT $ 38)))))))
                           (EXIT
                            (COND
                             ((EQL (|MDDFACT;degree| |u| $) 0)
                              (PROGN
                               (LETT #2#
                                     (CONS
                                      (CONS (SPADCALL |c| (QREFELT $ 32)) 0)
                                      |ans|))
                               (GO #3=#:G769)))
                             ('T
                              (SEQ
                               (EXIT
                                (SEQ (LETT |d| (+ |d| 1))
                                     (EXIT
                                      (COND
                                       ((> |d|
                                           (QUOTIENT2 (|MDDFACT;degree| |u| $)
                                                      2))
                                        (PROGN
                                         (LETT #1#
                                               (PROGN
                                                (LETT #2#
                                                      (CONS
                                                       (CONS
                                                        (SPADCALL |c|
                                                                  (QREFELT $
                                                                           32))
                                                        0)
                                                       (CONS
                                                        (CONS |u|
                                                              (|MDDFACT;degree|
                                                               |u| $))
                                                        |ans|)))
                                                (GO #3#)))
                                         (GO #4=#:G765)))))))
                               #4# (EXIT #1#))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #3# (EXIT #2#)))) 

(SDEFUN |MDDFACT;ddFact;UIL;12|
        ((|u| (U)) (|q| (|Integer|))
         ($ (|List| (|Record| (|:| |factor| U) (|:| |degree| (|Integer|))))))
        (SPROG
         ((#1=#:G785 NIL) (|dd| NIL) (#2=#:G784 NIL)
          (|ans|
           (|List| (|Record| (|:| |factor| EMR) (|:| |degree| (|Integer|))))))
         (SEQ
          (LETT |ans| (|MDDFACT;ddfact| (SPADCALL |u| |q| (QREFELT $ 33)) $))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |dd| NIL) (LETT #1# |ans|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |dd| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (CONS (SPADCALL (QCAR |dd|) (QREFELT $ 23))
                                (QCDR |dd|))
                          #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |MDDFACT;sepfact|
        ((|factList|
          (|List| (|Record| (|:| |factor| EMR) (|:| |degree| (|Integer|)))))
         ($ (|List| EMR)))
        (SPROG
         ((#1=#:G788 NIL) (#2=#:G787 #3=(|List| EMR)) (#4=#:G789 #3#)
          (#5=#:G791 NIL) (|f| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |f| NIL) (LETT #5# |factList|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (|MDDFACT;sepFact1| |f| $))
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 43))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T NIL)))))) 

(SDEFUN |MDDFACT;separateFactors;LIL;14|
        ((|uddList|
          (|List| (|Record| (|:| |factor| U) (|:| |degree| (|Integer|)))))
         (|q| (|Integer|)) ($ (|List| U)))
        (SPROG
         ((#1=#:G803 NIL) (|f| NIL) (#2=#:G802 NIL) (|ans| (|List| EMR))
          (#3=#:G801 NIL) (|udd| NIL) (#4=#:G800 NIL))
         (SEQ
          (LETT |ans|
                (|MDDFACT;sepfact|
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |udd| NIL) (LETT #3# |uddList|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |udd| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (CONS
                                 (SPADCALL (QCAR |udd|) |q| (QREFELT $ 33))
                                 (QCDR |udd|))
                                #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))
                 $))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |f| NIL) (LETT #1# |ans|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT (LETT #2# (CONS (SPADCALL |f| (QREFELT $ 23)) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |MDDFACT;decode|
        ((|s| (|Integer|)) (|p| (|Integer|)) (|x| (U)) ($ (U)))
        (SPROG
         ((|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|)))))
         (SEQ
          (COND ((< |s| |p|) (SPADCALL |s| (QREFELT $ 46)))
                ('T
                 (SEQ (LETT |qr| (DIVIDE2 |s| |p|))
                      (EXIT
                       (SPADCALL (SPADCALL (QCDR |qr|) (QREFELT $ 46))
                                 (SPADCALL |x|
                                           (|MDDFACT;decode| (QCAR |qr|) |p|
                                            |x| $)
                                           (QREFELT $ 47))
                                 (QREFELT $ 48))))))))) 

(SDEFUN |MDDFACT;sepFact1|
        ((|f| (|Record| (|:| |factor| EMR) (|:| |degree| #1=(|Integer|))))
         ($ (|List| EMR)))
        (SPROG
         ((#2=#:G835 NIL) (|x| (U)) (|ss| (|Integer|)) (|s| (|Integer|))
          (|ans| (|List| EMR)) (|stack| (|List| EMR)) (|df1| #3=(|Integer|))
          (|f1| (EMR)) (#4=#:G837 NIL) (|fact| NIL)
          (|flist| (|Union| (|List| EMR) "failed")) (|t| (EMR)) (#5=#:G836 NIL)
          (|y| (U)) (|du| #3#) (|i| NIL) (|u| (EMR)) (|c| (|Integer|))
          (|d| #1#) (|p| (|Integer|)))
         (SEQ (LETT |u| (QCAR |f|)) (LETT |p| (SPADCALL |u| (QREFELT $ 26)))
              (LETT |d| (QCDR |f|))
              (EXIT
               (COND ((EQL |d| 0) (LIST |u|))
                     (#6='T
                      (SEQ
                       (COND
                        ((SPADCALL (LETT |c| (|MDDFACT;lc| |u| $)) 1
                                   (QREFELT $ 31))
                         (LETT |u| (|MDDFACT;makeMonic| |u| $))))
                       (LETT |du| (|MDDFACT;degree| |u| $))
                       (EXIT
                        (COND ((EQL |d| |du|) (LIST |u|))
                              (#6#
                               (SEQ (LETT |ans| NIL)
                                    (LETT |x| (SPADCALL 1 1 (QREFELT $ 36)))
                                    (COND
                                     ((EQL |d| 1)
                                      (COND
                                       ((< |p| 1000)
                                        (EXIT
                                         (SEQ
                                          (SEQ (LETT |i| 0) G190
                                               (COND
                                                ((NULL (> |du| 0)) (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (COND
                                                  ((SPADCALL
                                                    (SPADCALL |u|
                                                              (SPADCALL |i|
                                                                        (QREFELT
                                                                         $ 46))
                                                              (QREFELT $ 49))
                                                    (|spadConstant| $ 11)
                                                    (QREFELT $ 50))
                                                   (SEQ
                                                    (LETT |ans|
                                                          (CONS
                                                           (SPADCALL
                                                            (SPADCALL |x|
                                                                      (SPADCALL
                                                                       |i|
                                                                       (QREFELT
                                                                        $ 46))
                                                                      (QREFELT
                                                                       $ 51))
                                                            |p| (QREFELT $ 33))
                                                           |ans|))
                                                    (EXIT
                                                     (LETT |du|
                                                           (- |du| 1))))))))
                                               (LETT |i| (|inc_SI| |i|))
                                               (GO G190) G191 (EXIT NIL))
                                          (EXIT |ans|)))))))
                                    (LETT |y| |x|) (LETT |s| 0) (LETT |ss| 1)
                                    (LETT |stack| (LIST |u|))
                                    (SEQ (LETT #5# NIL) G190
                                         (COND (#5# (GO G191)))
                                         (SEQ
                                          (LETT |t|
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |s| (QREFELT $ 46))
                                                  |x| (QREFELT $ 48))
                                                 |p| (QREFELT $ 33)))
                                          (SEQ
                                           (LETT |flist|
                                                 (|MDDFACT;probSplit|
                                                  (|SPADfirst| |stack|) |t| |d|
                                                  $))
                                           (EXIT
                                            (COND
                                             ((NULL (QEQCAR |flist| 1))
                                              (SEQ (LETT |stack| (CDR |stack|))
                                                   (EXIT
                                                    (SEQ (LETT |fact| NIL)
                                                         (LETT #4#
                                                               (QCDR |flist|))
                                                         G190
                                                         (COND
                                                          ((OR (ATOM #4#)
                                                               (PROGN
                                                                (LETT |fact|
                                                                      (CAR
                                                                       #4#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (LETT |f1|
                                                                (|MDDFACT;makeMonic|
                                                                 |fact| $))
                                                          (LETT |df1|
                                                                (|MDDFACT;degree|
                                                                 |f1| $))
                                                          (EXIT
                                                           (COND
                                                            ((EQL |df1| 0) NIL)
                                                            ((> |df1| |d|)
                                                             (LETT |stack|
                                                                   (CONS |f1|
                                                                         |stack|)))
                                                            ('T
                                                             (LETT |ans|
                                                                   (CONS |f1|
                                                                         |ans|))))))
                                                         (LETT #4# (CDR #4#))
                                                         (GO G190) G191
                                                         (EXIT NIL))))))))
                                          (EXIT
                                           (COND
                                            ((EQL |p| 2)
                                             (SEQ (LETT |ss| (+ |ss| 1))
                                                  (EXIT
                                                   (LETT |x|
                                                         (SPADCALL |y|
                                                                   (|MDDFACT;decode|
                                                                    |ss| |p|
                                                                    |y| $)
                                                                   (QREFELT $
                                                                            47))))))
                                            ('T
                                             (SEQ (LETT |s| (+ |s| 1))
                                                  (EXIT
                                                   (COND
                                                    ((EQL |s| |p|)
                                                     (SEQ
                                                      (EXIT
                                                       (SEQ (LETT |s| 0)
                                                            (LETT |ss|
                                                                  (+ |ss| 1))
                                                            (LETT |x|
                                                                  (SPADCALL |y|
                                                                            (|MDDFACT;decode|
                                                                             |ss|
                                                                             |p|
                                                                             |y|
                                                                             $)
                                                                            (QREFELT
                                                                             $
                                                                             47)))
                                                            (EXIT
                                                             (COND
                                                              ((NULL
                                                                (EQL
                                                                 (SPADCALL |x|
                                                                           (QREFELT
                                                                            $
                                                                            16))
                                                                 1))
                                                               (PROGN
                                                                (LETT #2#
                                                                      (SEQ
                                                                       (LETT
                                                                        |ss|
                                                                        (EXPT
                                                                         |p|
                                                                         (SPADCALL
                                                                          |x|
                                                                          (QREFELT
                                                                           $
                                                                           25))))
                                                                       (EXIT
                                                                        (LETT
                                                                         |x|
                                                                         (SPADCALL
                                                                          |y|
                                                                          (+
                                                                           (SPADCALL
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             25))
                                                                           1)
                                                                          (QREFELT
                                                                           $
                                                                           52))))))
                                                                (GO
                                                                 #7=#:G827)))))))
                                                      #7# (EXIT #2#))))))))))
                                         (LETT #5# (NULL |stack|)) (GO G190)
                                         G191 (EXIT NIL))
                                    (EXIT
                                     (CONS
                                      (SPADCALL |c| (|SPADfirst| |ans|)
                                                (QREFELT $ 27))
                                      (CDR |ans|)))))))))))))) 

(SDEFUN |MDDFACT;probSplit|
        ((|u| (EMR)) (|t| (EMR)) (|d| (|Integer|))
         ($ (|Union| (|List| EMR) "failed")))
        (SPROG
         ((|g| (EMR)) (|f2| (EMR)) (|n| (EMR)) (|r| (|NonNegativeInteger|))
          (#1=#:G909 NIL) (#2=#:G908 NIL) (|f1| (EMR)) (|p| (|Integer|)))
         (SEQ (LETT |p| (SPADCALL |u| (QREFELT $ 26)))
              (EXIT
               (COND ((EQL |p| 2) (|MDDFACT;probSplit2| |u| |t| |d| $))
                     ('T
                      (SEQ (LETT |f1| (SPADCALL |u| |t| (QREFELT $ 34)))
                           (LETT |r|
                                 (PROG1
                                     (LETT #1#
                                           (QUOTIENT2
                                            (-
                                             (EXPT |p|
                                                   (PROG1 (LETT #2# |d|)
                                                     (|check_subtype2|
                                                      (>= #2# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #2#)))
                                             1)
                                            2))
                                   (|check_subtype2| (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#)))
                           (LETT |n| (|MDDFACT;exptmod| |t| |r| |u| $))
                           (LETT |f2|
                                 (SPADCALL |u|
                                           (SPADCALL |n| (|spadConstant| $ 28)
                                                     (QREFELT $ 53))
                                           (QREFELT $ 34)))
                           (LETT |g| (SPADCALL |f1| |f2| (QREFELT $ 29)))
                           (EXIT
                            (COND
                             ((OR
                               (SPADCALL |g| (|spadConstant| $ 28)
                                         (QREFELT $ 54))
                               (SPADCALL |g| |u| (QREFELT $ 54)))
                              (CONS 1 "failed"))
                             ('T
                              (CONS 0
                                    (LIST |f1| |f2|
                                          (SPADCALL |u| |g|
                                                    (QREFELT $ 38)))))))))))))) 

(SDEFUN |MDDFACT;probSplit2|
        ((|u| (EMR)) (|t| (EMR)) (|d| (|Integer|))
         ($ (|Union| (|List| EMR) "failed")))
        (SPROG ((|f| (EMR)))
               (SEQ
                (LETT |f|
                      (SPADCALL |u| (|MDDFACT;trace| |t| |d| |u| $)
                                (QREFELT $ 34)))
                (EXIT
                 (COND
                  ((OR (SPADCALL |f| (|spadConstant| $ 28) (QREFELT $ 54))
                       (EQL (|MDDFACT;degree| |u| $) (|MDDFACT;degree| |f| $)))
                   (CONS 1 "failed"))
                  ('T
                   (CONS 0
                         (LIST (|spadConstant| $ 28) |f|
                               (SPADCALL |u| |f| (QREFELT $ 38)))))))))) 

(SDEFUN |MDDFACT;trace| ((|t| (EMR)) (|d| (|Integer|)) (|u| (EMR)) ($ (EMR)))
        (SPROG ((|tt| (EMR)) (|p| (|Integer|)))
               (SEQ (LETT |p| (SPADCALL |t| (QREFELT $ 26)))
                    (LETT |d| (- |d| 1)) (LETT |tt| |t|)
                    (SEQ G190 (COND ((NULL (> |d| 0)) (GO G191)))
                         (SEQ
                          (LETT |tt|
                                (SPADCALL
                                 (SPADCALL |tt|
                                           (LETT |t|
                                                 (|MDDFACT;exptmod| |t| |p| |u|
                                                  $))
                                           (QREFELT $ 53))
                                 |u| (QREFELT $ 30)))
                          (EXIT (LETT |d| (- |d| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |tt|)))) 

(DECLAIM (NOTINLINE |ModularDistinctDegreeFactorizer;|)) 

(DEFUN |ModularDistinctDegreeFactorizer| (#1=#:G924)
  (SPROG NIL
         (PROG (#2=#:G925)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ModularDistinctDegreeFactorizer|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|ModularDistinctDegreeFactorizer;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ModularDistinctDegreeFactorizer|)))))))))) 

(DEFUN |ModularDistinctDegreeFactorizer;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ModularDistinctDegreeFactorizer| DV$1))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularDistinctDegreeFactorizer|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 22
                    (|EuclideanModularRing| (|Integer|) |#1| (|Integer|)
                                            (CONS
                                             (|function| |MDDFACT;reduction|)
                                             $)
                                            (CONS (|function| |MDDFACT;merge|)
                                                  $)
                                            (CONS
                                             (|function| |MDDFACT;exactquo|)
                                             $)))
          $))) 

(MAKEPROP '|ModularDistinctDegreeFactorizer| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              (0 . |positiveRemainder|) (|Mapping| 7 7) (6 . |map|)
              (12 . |Zero|) (16 . |One|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 13 '"failed")
              (20 . |extendedEuclidean|) (27 . |leadingCoefficient|) (32 . *)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (38 . |monicDivide|) (|Boolean|) (44 . ~=) 'EMR (50 . |coerce|)
              (|NonNegativeInteger|) (55 . |degree|) (60 . |modulus|) (65 . *)
              (71 . |One|) (75 . *) (81 . |rem|) (87 . ~=) (93 . |coerce|)
              (98 . |reduce|) (104 . |gcd|) |MDDFACT;gcd;2UIU;10|
              (110 . |monomial|) (116 . -) (122 . |quo|)
              (|Record| (|:| |factor| 6) (|:| |degree| 7)) (|List| 39)
              |MDDFACT;ddFact;UIL;12| (|List| 22) (128 . |append|) (|List| 6)
              |MDDFACT;separateFactors;LIL;14| (134 . |coerce|) (139 . *)
              (145 . +) (151 . |elt|) (157 . =) (163 . -) (169 . ^) (175 . +)
              (181 . =))
           '#(|separateFactors| 187 |gcd| 193 |ddFact| 200) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|gcd| (|#1| |#1| |#1| (|Integer|))) T)
                                   '((|ddFact|
                                      ((|List|
                                        (|Record| (|:| |factor| |#1|)
                                                  (|:| |degree| (|Integer|))))
                                       |#1| (|Integer|)))
                                     T)
                                   '((|separateFactors|
                                      ((|List| |#1|)
                                       (|List|
                                        (|Record| (|:| |factor| |#1|)
                                                  (|:| |degree| (|Integer|))))
                                       (|Integer|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(2 7 0 0 0 8 2 6 0 9 0 10 0 6 0 11
                                              0 6 0 12 3 7 14 0 0 0 15 1 6 7 0
                                              16 2 6 0 7 0 17 2 6 18 0 0 19 2 6
                                              20 0 0 21 1 22 6 0 23 1 6 24 0 25
                                              1 22 7 0 26 2 22 0 7 0 27 0 22 0
                                              28 2 22 0 0 0 29 2 22 0 0 0 30 2
                                              7 20 0 0 31 1 22 0 7 32 2 22 0 6
                                              7 33 2 22 0 0 0 34 2 6 0 7 24 36
                                              2 22 0 0 0 37 2 22 0 0 0 38 2 42
                                              0 0 0 43 1 6 0 7 46 2 6 0 0 0 47
                                              2 6 0 0 0 48 2 22 6 0 6 49 2 6 20
                                              0 0 50 2 6 0 0 0 51 2 6 0 0 24 52
                                              2 22 0 0 0 53 2 22 20 0 0 54 2 0
                                              44 40 7 45 3 0 6 6 6 7 35 2 0 40
                                              6 7 41)))))
           '|lookupComplete|)) 
