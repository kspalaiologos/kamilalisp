
(SDEFUN |STTF;expre|
        ((|r| (|Coef|)) (|e| (|Stream| |Coef|)) (|dx| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL |r| (CONS #'|STTF;expre!0| (VECTOR $ |dx| |e|))
                         (QREFELT $ 20)))) 

(SDEFUN |STTF;expre!0| (($$ NIL))
        (PROG (|e| |dx| $)
          (LETT |e| (QREFELT $$ 2))
          (LETT |dx| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |dx| (QREFELT $ 18)))))) 

(SDEFUN |STTF;exp;2S;2| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24)))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 26)
                                    (QREFELT $ 27))
                          (SPADCALL (CONS #'|STTF;exp;2S;2!0| (VECTOR |z| $))
                                    (QREFELT $ 31)))
                         ((QREFELT $ 7)
                          (SPADCALL
                           (CONS #'|STTF;exp;2S;2!1| (VECTOR |z| $ |coef|))
                           (QREFELT $ 31)))
                         (#1# (|error| (STRCONC "exp: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;exp;2S;2!1| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;expre| (SPADCALL |coef| (QREFELT $ 32)) |y|
             (SPADCALL |z| (QREFELT $ 28)) $))))) 

(SDEFUN |STTF;exp;2S;2!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;expre| (|spadConstant| $ 23) |y|
             (SPADCALL |z| (QREFELT $ 28)) $))))) 

(SDEFUN |STTF;log;2S;3| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (|error| "log: constant coefficient should not be 0"))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 26)
                                    (QREFELT $ 27))
                          (|error|
                           "log: constant coefficient should not be 0"))
                         ((SPADCALL |coef| (|spadConstant| $ 23)
                                    (QREFELT $ 27))
                          (SPADCALL (|spadConstant| $ 26)
                                    (CONS #'|STTF;log;2S;3!0| (VECTOR $ |z|))
                                    (QREFELT $ 20)))
                         ((QREFELT $ 7)
                          (SPADCALL (SPADCALL |coef| (QREFELT $ 35))
                                    (CONS #'|STTF;log;2S;3!1| (VECTOR $ |z|))
                                    (QREFELT $ 20)))
                         (#1# (|error| (STRCONC "log: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;log;2S;3!1| (($$ NIL))
        (PROG (|z| $)
          (LETT |z| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z| (QREFELT $ 28)) |z| (QREFELT $ 34)))))) 

(SDEFUN |STTF;log;2S;3!0| (($$ NIL))
        (PROG (|z| $)
          (LETT |z| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z| (QREFELT $ 28)) |z| (QREFELT $ 34)))))) 

(SDEFUN |STTF;^;3S;4|
        ((|z1| (|Stream| |Coef|)) (|z2| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPADCALL (SPADCALL |z2| (SPADCALL |z1| (QREFELT $ 36)) (QREFELT $ 18))
                  (QREFELT $ 33))) 

(SDEFUN |STTF;sincosre|
        ((|rs| (|Coef|)) (|rc| (|Coef|)) (|sc| (|List| (|Stream| |Coef|)))
         (|dx| (|Stream| |Coef|)) (|sign| (|Coef|))
         ($ (|List| (|Stream| |Coef|))))
        (SPROG NIL
               (LIST
                (SPADCALL |rs| (CONS #'|STTF;sincosre!0| (VECTOR |dx| $ |sc|))
                          (QREFELT $ 20))
                (SPADCALL |rc|
                          (CONS #'|STTF;sincosre!1|
                                (VECTOR |dx| $ |sc| |sign|))
                          (QREFELT $ 20))))) 

(SDEFUN |STTF;sincosre!1| (($$ NIL))
        (PROG (|sign| |sc| $ |dx|)
          (LETT |sign| (QREFELT $$ 3))
          (LETT |sc| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |sign| (SPADCALL |sc| (QREFELT $ 40)) (QREFELT $ 41))
             |dx| (QREFELT $ 18)))))) 

(SDEFUN |STTF;sincosre!0| (($$ NIL))
        (PROG (|sc| $ |dx|)
          (LETT |sc| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |sc| (QREFELT $ 39)) |dx| (QREFELT $ 18)))))) 

(SDEFUN |STTF;sincos;SR;6|
        ((|z| (|Stream| |Coef|))
         ($
          (|Record| (|:| |sin| (|Stream| |Coef|))
                    (|:| |cos| (|Stream| |Coef|)))))
        (SPROG ((|l| (|List| (|Stream| |Coef|))) (|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (CONS (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24))
                        (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))))
                 (#1='T
                  (SEQ
                   (LETT |l|
                         (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                              (EXIT
                               (COND
                                ((SPADCALL |coef| (|spadConstant| $ 26)
                                           (QREFELT $ 27))
                                 (SPADCALL
                                  (CONS #'|STTF;sincos;SR;6!0| (VECTOR |z| $))
                                  2 (QREFELT $ 45)))
                                ((QREFELT $ 7)
                                 (SPADCALL
                                  (CONS #'|STTF;sincos;SR;6!1|
                                        (VECTOR |z| $ |coef|))
                                  2 (QREFELT $ 45)))
                                (#1#
                                 (|error|
                                  (STRCONC "sincos: " (QREFELT $ 8))))))))
                   (EXIT
                    (CONS (|SPADfirst| |l|)
                          (SPADCALL |l| (QREFELT $ 39)))))))))) 

(SDEFUN |STTF;sincos;SR;6!1| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;sincosre| (SPADCALL |coef| (QREFELT $ 46))
             (SPADCALL |coef| (QREFELT $ 47)) |y| (SPADCALL |z| (QREFELT $ 28))
             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 42)) $))))) 

(SDEFUN |STTF;sincos;SR;6!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;sincosre| (|spadConstant| $ 26) (|spadConstant| $ 23) |y|
             (SPADCALL |z| (QREFELT $ 28))
             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 42)) $))))) 

(SDEFUN |STTF;sin;2S;7| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (QCAR (SPADCALL |z| (QREFELT $ 50)))) 

(SDEFUN |STTF;cos;2S;8| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (QCDR (SPADCALL |z| (QREFELT $ 50)))) 

(SDEFUN |STTF;tanre|
        ((|r| (|Coef|)) (|t| (|Stream| |Coef|)) (|dx| (|Stream| |Coef|))
         (|sign| (|Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL |r| (CONS #'|STTF;tanre!0| (VECTOR |dx| |t| |sign| $))
                         (QREFELT $ 20)))) 

(SDEFUN |STTF;tanre!0| (($$ NIL))
        (PROG ($ |sign| |t| |dx|)
          (LETT $ (QREFELT $$ 3))
          (LETT |sign| (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                       (SPADCALL (SPADCALL |sign| |t| (QREFELT $ 41)) |t|
                                 (QREFELT $ 18))
                       (QREFELT $ 55))
             |dx| (QREFELT $ 18)))))) 

(SDEFUN |STTF;tan;2S;10| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24)))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 26)
                                    (QREFELT $ 27))
                          (SPADCALL (CONS #'|STTF;tan;2S;10!0| (VECTOR |z| $))
                                    (QREFELT $ 31)))
                         ((QREFELT $ 7)
                          (SPADCALL
                           (CONS #'|STTF;tan;2S;10!1| (VECTOR |z| $ |coef|))
                           (QREFELT $ 31)))
                         (#1# (|error| (STRCONC "tan: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;tan;2S;10!1| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;tanre| (SPADCALL |coef| (QREFELT $ 56)) |y|
             (SPADCALL |z| (QREFELT $ 28)) (|spadConstant| $ 23) $))))) 

(SDEFUN |STTF;tan;2S;10!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;tanre| (|spadConstant| $ 26) |y|
             (SPADCALL |z| (QREFELT $ 28)) (|spadConstant| $ 23) $))))) 

(SDEFUN |STTF;cotre|
        ((|r| (|Coef|)) (|t| (|Stream| |Coef|)) (|dx| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL |r| (CONS #'|STTF;cotre!0| (VECTOR |dx| |t| $))
                         (QREFELT $ 20)))) 

(SDEFUN |STTF;cotre!0| (($$ NIL))
        (PROG ($ |t| |dx|)
          (LETT $ (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                        (SPADCALL |t| |t| (QREFELT $ 18)) (QREFELT $ 55))
              |dx| (QREFELT $ 18))
             (QREFELT $ 58)))))) 

(SDEFUN |STTF;cot;2S;12| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (|error| "cot: cot(0) is undefined"))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 26)
                                    (QREFELT $ 27))
                          (|error| (STRCONC "cot: " (QREFELT $ 9))))
                         ((QREFELT $ 7)
                          (SPADCALL
                           (CONS #'|STTF;cot;2S;12!0| (VECTOR |z| $ |coef|))
                           (QREFELT $ 31)))
                         (#1# (|error| (STRCONC "cot: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;cot;2S;12!0| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;cotre| (SPADCALL |coef| (QREFELT $ 59)) |y|
             (SPADCALL |z| (QREFELT $ 28)) $))))) 

(SDEFUN |STTF;sec;2S;13| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((#1=#:G806 NIL) (|cosz| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24)))
                 ((SPADCALL (SPADCALL |z| (QREFELT $ 25)) (|spadConstant| $ 26)
                            (QREFELT $ 27))
                  (PROG2
                      (LETT #1#
                            (SPADCALL (SPADCALL |z| (QREFELT $ 52))
                                      (QREFELT $ 62)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                                    (|Union| (|Stream| (QREFELT $ 6))
                                             #2="failed")
                                    #1#)))
                 ((QREFELT $ 7)
                  (SEQ (LETT |cosz| (SPADCALL |z| (QREFELT $ 52)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |cosz| (QREFELT $ 63))
                                    (|spadConstant| $ 26) (QREFELT $ 27))
                          (|error| (STRCONC "sec: " (QREFELT $ 9))))
                         (#3='T
                          (PROG2 (LETT #1# (SPADCALL |cosz| (QREFELT $ 62)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0)
                                            (|Stream| (QREFELT $ 6))
                                            (|Union| (|Stream| (QREFELT $ 6))
                                                     #2#)
                                            #1#)))))))
                 (#3# (|error| (STRCONC "sec: " (QREFELT $ 8)))))))) 

(SDEFUN |STTF;csc;2S;14| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((#1=#:G813 NIL) (|sinz| (|Stream| |Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (|error| "csc: csc(0) is undefined"))
                 ((QREFELT $ 7)
                  (SEQ (LETT |sinz| (SPADCALL |z| (QREFELT $ 51)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |sinz| (QREFELT $ 63))
                                    (|spadConstant| $ 26) (QREFELT $ 27))
                          (|error| (STRCONC "csc: " (QREFELT $ 9))))
                         (#2='T
                          (PROG2 (LETT #1# (SPADCALL |sinz| (QREFELT $ 62)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0)
                                            (|Stream| (QREFELT $ 6))
                                            (|Union| (|Stream| (QREFELT $ 6))
                                                     "failed")
                                            #1#)))))))
                 (#2# (|error| (STRCONC "csc: " (QREFELT $ 8)))))))) 

(SDEFUN |STTF;orderOrFailed|
        ((|x| (|Stream| |Coef|)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((#1=#:G828 NIL) (|n| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |n| 0) G190
                       (COND ((|greater_SI| |n| 1000) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |x| (QREFELT $ 22))
                           (PROGN (LETT #1# (CONS 0 -1)) (GO #2=#:G827)))
                          ((NULL
                            (SPADCALL (SPADCALL |x| (QREFELT $ 25))
                                      (QREFELT $ 66)))
                           (PROGN (LETT #1# (CONS 0 |n|)) (GO #2#)))
                          ('T (LETT |x| (SPADCALL |x| (QREFELT $ 67)))))))
                       (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                  (EXIT (CONS 1 "failed"))))
                #2# (EXIT #1#)))) 

(SDEFUN |STTF;asin;2S;16| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|quot| (|Union| (|Stream| |Coef|) "failed"))
          (|squirt| (|Stream| |Coef|)) (#1=#:G848 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24)))
            (#2='T
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (EXIT
                   (COND
                    ((SPADCALL |coef| (|spadConstant| $ 26) (QREFELT $ 27))
                     (SPADCALL (|spadConstant| $ 26)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                           (QREFELT $ 71))
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 23)
                                            (QREFELT $ 24))
                                  (SPADCALL |z| |z| (QREFELT $ 18))
                                  (QREFELT $ 72))
                                 (QREFELT $ 73))
                                (SPADCALL |z| (QREFELT $ 28)) (QREFELT $ 18))
                               (QREFELT $ 74)))
                    ((QREFELT $ 7)
                     (COND
                      ((OR
                        (SPADCALL |coef| (|spadConstant| $ 23) (QREFELT $ 27))
                        (SPADCALL |coef|
                                  (SPADCALL (|spadConstant| $ 23)
                                            (QREFELT $ 42))
                                  (QREFELT $ 27)))
                       (SEQ
                        (LETT |x|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                               (SPADCALL |z| |z| (QREFELT $ 18))
                               (QREFELT $ 72)))
                        (LETT |ord| (|STTF;orderOrFailed| |x| $))
                        (EXIT
                         (COND
                          ((QEQCAR |ord| 1)
                           (|error| (STRCONC "asin: " (QREFELT $ 11))))
                          ((EQL (LETT |order| (QCDR |ord|)) -1)
                           (PROGN
                            (LETT #1#
                                  (SPADCALL (SPADCALL |coef| (QREFELT $ 75))
                                            (QREFELT $ 24)))
                            (GO #3=#:G847)))
                          ((ODDP |order|)
                           (|error| (STRCONC "asin: " (QREFELT $ 10))))
                          (#2#
                           (SEQ
                            (LETT |squirt|
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                            (QREFELT $ 73)))
                            (LETT |quot|
                                  (SPADCALL (SPADCALL |z| (QREFELT $ 28))
                                            |squirt| (QREFELT $ 76)))
                            (EXIT
                             (COND
                              ((QEQCAR |quot| 1)
                               (|error| (STRCONC "asin: " (QREFELT $ 15))))
                              (#2#
                               (SPADCALL (SPADCALL |coef| (QREFELT $ 75))
                                         (QCDR |quot|) (QREFELT $ 74)))))))))))
                      ('T
                       (SPADCALL (SPADCALL |coef| (QREFELT $ 75))
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                             (QREFELT $ 71))
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 23)
                                              (QREFELT $ 24))
                                    (SPADCALL |z| |z| (QREFELT $ 18))
                                    (QREFELT $ 72))
                                   (QREFELT $ 73))
                                  (SPADCALL |z| (QREFELT $ 28)) (QREFELT $ 18))
                                 (QREFELT $ 74)))))
                    (#2# (|error| (STRCONC "asin: " (QREFELT $ 8))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |STTF;acos;2S;17| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|quot| (|Union| (|Stream| |Coef|) "failed"))
          (|squirt| (|Stream| |Coef|)) (#1=#:G867 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (COND
              ((QREFELT $ 7)
               (SPADCALL (SPADCALL (|spadConstant| $ 26) (QREFELT $ 78))
                         (QREFELT $ 24)))
              (#2='T (|error| (STRCONC "acos: " (QREFELT $ 8))))))
            ((QREFELT $ 7)
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (COND
                   ((OR (SPADCALL |coef| (|spadConstant| $ 23) (QREFELT $ 27))
                        (SPADCALL |coef|
                                  (SPADCALL (|spadConstant| $ 23)
                                            (QREFELT $ 42))
                                  (QREFELT $ 27)))
                    (EXIT
                     (SEQ
                      (LETT |x|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                             (SPADCALL |z| |z| (QREFELT $ 18)) (QREFELT $ 72)))
                      (LETT |ord| (|STTF;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "acos: " (QREFELT $ 11))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |coef| (QREFELT $ 78))
                                          (QREFELT $ 24)))
                          (GO #3=#:G866)))
                        ((ODDP |order|)
                         (|error| (STRCONC "acos: " (QREFELT $ 10))))
                        (#2#
                         (SEQ
                          (LETT |squirt|
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                          (QREFELT $ 73)))
                          (LETT |quot|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |z| (QREFELT $ 28))
                                           (QREFELT $ 58))
                                 |squirt| (QREFELT $ 76)))
                          (EXIT
                           (COND
                            ((QEQCAR |quot| 1)
                             (|error| (STRCONC "acos: " (QREFELT $ 15))))
                            (#2#
                             (SPADCALL (SPADCALL |coef| (QREFELT $ 78))
                                       (QCDR |quot|) (QREFELT $ 74)))))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL |coef| (QREFELT $ 78))
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                          (QREFELT $ 71))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 23)
                                           (QREFELT $ 24))
                                 (SPADCALL |z| |z| (QREFELT $ 18))
                                 (QREFELT $ 72))
                                (QREFELT $ 73))
                               (SPADCALL |z| (QREFELT $ 28)) (QREFELT $ 18))
                              (QREFELT $ 58))
                             (QREFELT $ 74)))))
            (#2# (|error| (STRCONC "acos: " (QREFELT $ 8))))))
          #3# (EXIT #1#)))) 

(SDEFUN |STTF;atan;2S;18| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|y| (|Union| (|Stream| |Coef|) #1="failed")) (#2=#:G869 NIL)
          (|coef| (|Coef|)))
         (SEQ
          (COND
           ((SPADCALL |z| (QREFELT $ 22))
            (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24)))
           (#3='T
            (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                 (EXIT
                  (COND
                   ((SPADCALL |coef| (|spadConstant| $ 26) (QREFELT $ 27))
                    (SPADCALL (|spadConstant| $ 26)
                              (SPADCALL
                               (PROG2
                                   (LETT #2#
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL (|spadConstant| $ 23)
                                                     (QREFELT $ 24))
                                           (SPADCALL |z| |z| (QREFELT $ 18))
                                           (QREFELT $ 55))
                                          (QREFELT $ 62)))
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0)
                                                 (|Stream| (QREFELT $ 6))
                                                 (|Union|
                                                  (|Stream| (QREFELT $ 6)) #1#)
                                                 #2#))
                               (SPADCALL |z| (QREFELT $ 28)) (QREFELT $ 18))
                              (QREFELT $ 74)))
                   ((QREFELT $ 7)
                    (SEQ
                     (LETT |y|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                             (SPADCALL |z| |z| (QREFELT $ 18)) (QREFELT $ 55))
                            (QREFELT $ 62)))
                     (EXIT
                      (COND
                       ((QEQCAR |y| 1)
                        (|error| (STRCONC "atan: " (QREFELT $ 12))))
                       (#3#
                        (SPADCALL (SPADCALL |coef| (QREFELT $ 80))
                                  (SPADCALL (QCDR |y|)
                                            (SPADCALL |z| (QREFELT $ 28))
                                            (QREFELT $ 18))
                                  (QREFELT $ 74)))))))
                   (#3# (|error| (STRCONC "atan: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;acot;2S;19| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|y| (|Union| (|Stream| |Coef|) "failed")))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (COND
                   ((QREFELT $ 7)
                    (SPADCALL (SPADCALL (|spadConstant| $ 26) (QREFELT $ 82))
                              (QREFELT $ 24)))
                   (#1='T (|error| (STRCONC "acot: " (QREFELT $ 8))))))
                 ((QREFELT $ 7)
                  (SEQ
                   (LETT |y|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                           (SPADCALL |z| |z| (QREFELT $ 18)) (QREFELT $ 55))
                          (QREFELT $ 62)))
                   (EXIT
                    (COND
                     ((QEQCAR |y| 1)
                      (|error| (STRCONC "acot: " (QREFELT $ 12))))
                     (#1#
                      (SPADCALL
                       (SPADCALL (SPADCALL |z| (QREFELT $ 25)) (QREFELT $ 82))
                       (SPADCALL
                        (SPADCALL (QCDR |y|) (SPADCALL |z| (QREFELT $ 28))
                                  (QREFELT $ 18))
                        (QREFELT $ 58))
                       (QREFELT $ 74)))))))
                 (#1# (|error| (STRCONC "acot: " (QREFELT $ 8)))))))) 

(SDEFUN |STTF;asec;2S;20| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|quot2| #1=(|Union| (|Stream| |Coef|) "failed")) (|quot| #1#)
          (|squirt| (|Stream| |Coef|)) (#2=#:G902 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (|error| "asec: constant coefficient should not be 0"))
            ((QREFELT $ 7)
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (EXIT
                   (COND
                    ((SPADCALL |coef| (|spadConstant| $ 26) (QREFELT $ 27))
                     (|error| "asec: constant coefficient should not be 0"))
                    ((OR (SPADCALL |coef| (|spadConstant| $ 23) (QREFELT $ 27))
                         (SPADCALL |coef|
                                   (SPADCALL (|spadConstant| $ 23)
                                             (QREFELT $ 42))
                                   (QREFELT $ 27)))
                     (SEQ
                      (LETT |x|
                            (SPADCALL (SPADCALL |z| |z| (QREFELT $ 18))
                                      (SPADCALL (|spadConstant| $ 23)
                                                (QREFELT $ 24))
                                      (QREFELT $ 72)))
                      (LETT |ord| (|STTF;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "asec: " (QREFELT $ 11))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #2#
                                (SPADCALL (SPADCALL |coef| (QREFELT $ 84))
                                          (QREFELT $ 24)))
                          (GO #3=#:G901)))
                        ((ODDP |order|)
                         (|error| (STRCONC "asec: " (QREFELT $ 10))))
                        (#4='T
                         (SEQ
                          (LETT |squirt|
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                          (QREFELT $ 73)))
                          (LETT |quot|
                                (SPADCALL (SPADCALL |z| (QREFELT $ 28))
                                          |squirt| (QREFELT $ 76)))
                          (EXIT
                           (COND
                            ((QEQCAR |quot| 1)
                             (|error| (STRCONC "asec: " (QREFELT $ 15))))
                            (#4#
                             (SEQ
                              (LETT |quot2|
                                    (SPADCALL (QCDR |quot|) |z|
                                              (QREFELT $ 76)))
                              (EXIT
                               (COND
                                ((QEQCAR |quot2| 1)
                                 (|error| (STRCONC "asec: " (QREFELT $ 15))))
                                (#4#
                                 (SPADCALL (SPADCALL |coef| (QREFELT $ 84))
                                           (QCDR |quot2|)
                                           (QREFELT $ 74)))))))))))))))
                    ('T
                     (SPADCALL (SPADCALL |coef| (QREFELT $ 84))
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                            (QREFELT $ 71))
                                  (SPADCALL (SPADCALL |z| |z| (QREFELT $ 18))
                                            (SPADCALL (|spadConstant| $ 23)
                                                      (QREFELT $ 24))
                                            (QREFELT $ 72))
                                  (QREFELT $ 73))
                                 (SPADCALL |z| (QREFELT $ 28)) (QREFELT $ 18))
                                |z| (QREFELT $ 34))
                               (QREFELT $ 74)))))))
            (#4# (|error| (STRCONC "asec: " (QREFELT $ 8))))))
          #3# (EXIT #2#)))) 

(SDEFUN |STTF;acsc;2S;21| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|quot2| #1=(|Union| (|Stream| |Coef|) "failed")) (|quot| #1#)
          (|squirt| (|Stream| |Coef|)) (#2=#:G924 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (|error| "acsc: constant coefficient should not be zero"))
            ((QREFELT $ 7)
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (EXIT
                   (COND
                    ((SPADCALL |coef| (|spadConstant| $ 26) (QREFELT $ 27))
                     (|error| "acsc: constant coefficient should not be zero"))
                    ((OR (SPADCALL |coef| (|spadConstant| $ 23) (QREFELT $ 27))
                         (SPADCALL |coef|
                                   (SPADCALL (|spadConstant| $ 23)
                                             (QREFELT $ 42))
                                   (QREFELT $ 27)))
                     (SEQ
                      (LETT |x|
                            (SPADCALL (SPADCALL |z| |z| (QREFELT $ 18))
                                      (SPADCALL (|spadConstant| $ 23)
                                                (QREFELT $ 24))
                                      (QREFELT $ 72)))
                      (LETT |ord| (|STTF;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "acsc: " (QREFELT $ 11))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #2#
                                (SPADCALL (SPADCALL |coef| (QREFELT $ 86))
                                          (QREFELT $ 24)))
                          (GO #3=#:G923)))
                        ((ODDP |order|)
                         (|error| (STRCONC "acsc: " (QREFELT $ 10))))
                        (#4='T
                         (SEQ
                          (LETT |squirt|
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                          (QREFELT $ 73)))
                          (LETT |quot|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |z| (QREFELT $ 28))
                                           (QREFELT $ 58))
                                 |squirt| (QREFELT $ 76)))
                          (EXIT
                           (COND
                            ((QEQCAR |quot| 1)
                             (|error| (STRCONC "acsc: " (QREFELT $ 15))))
                            (#4#
                             (SEQ
                              (LETT |quot2|
                                    (SPADCALL (QCDR |quot|) |z|
                                              (QREFELT $ 76)))
                              (EXIT
                               (COND
                                ((QEQCAR |quot2| 1)
                                 (|error| (STRCONC "acsc: " (QREFELT $ 15))))
                                (#4#
                                 (SPADCALL (SPADCALL |coef| (QREFELT $ 86))
                                           (QCDR |quot2|)
                                           (QREFELT $ 74)))))))))))))))
                    ('T
                     (SPADCALL (SPADCALL |coef| (QREFELT $ 86))
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                             (QREFELT $ 71))
                                   (SPADCALL (SPADCALL |z| |z| (QREFELT $ 18))
                                             (SPADCALL (|spadConstant| $ 23)
                                                       (QREFELT $ 24))
                                             (QREFELT $ 72))
                                   (QREFELT $ 73))
                                  (SPADCALL |z| (QREFELT $ 28)) (QREFELT $ 18))
                                 |z| (QREFELT $ 34))
                                (QREFELT $ 58))
                               (QREFELT $ 74)))))))
            (#4# (|error| (STRCONC "acsc: " (QREFELT $ 8))))))
          #3# (EXIT #2#)))) 

(SDEFUN |STTF;sinhcosh;SR;22|
        ((|z| (|Stream| |Coef|))
         ($
          (|Record| (|:| |sinh| (|Stream| |Coef|))
                    (|:| |cosh| (|Stream| |Coef|)))))
        (SPROG ((|l| (|List| (|Stream| |Coef|))) (|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (CONS (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24))
                        (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))))
                 (#1='T
                  (SEQ
                   (LETT |l|
                         (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                              (EXIT
                               (COND
                                ((SPADCALL |coef| (|spadConstant| $ 26)
                                           (QREFELT $ 27))
                                 (SPADCALL
                                  (CONS #'|STTF;sinhcosh;SR;22!0|
                                        (VECTOR |z| $))
                                  2 (QREFELT $ 45)))
                                ((QREFELT $ 7)
                                 (SPADCALL
                                  (CONS #'|STTF;sinhcosh;SR;22!1|
                                        (VECTOR |z| $ |coef|))
                                  2 (QREFELT $ 45)))
                                (#1#
                                 (|error|
                                  (STRCONC "sinhcosh: " (QREFELT $ 8))))))))
                   (EXIT
                    (CONS (|SPADfirst| |l|)
                          (SPADCALL |l| (QREFELT $ 39)))))))))) 

(SDEFUN |STTF;sinhcosh;SR;22!1| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;sincosre| (SPADCALL |coef| (QREFELT $ 88))
             (SPADCALL |coef| (QREFELT $ 89)) |y| (SPADCALL |z| (QREFELT $ 28))
             (|spadConstant| $ 23) $))))) 

(SDEFUN |STTF;sinhcosh;SR;22!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;sincosre| (|spadConstant| $ 26) (|spadConstant| $ 23) |y|
             (SPADCALL |z| (QREFELT $ 28)) (|spadConstant| $ 23) $))))) 

(SDEFUN |STTF;sinh;2S;23| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (QCAR (SPADCALL |z| (QREFELT $ 91)))) 

(SDEFUN |STTF;cosh;2S;24| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (QCDR (SPADCALL |z| (QREFELT $ 91)))) 

(SDEFUN |STTF;tanh;2S;25| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24)))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 26)
                                    (QREFELT $ 27))
                          (SPADCALL (CONS #'|STTF;tanh;2S;25!0| (VECTOR |z| $))
                                    (QREFELT $ 31)))
                         ((QREFELT $ 7)
                          (SPADCALL
                           (CONS #'|STTF;tanh;2S;25!1| (VECTOR |z| $ |coef|))
                           (QREFELT $ 31)))
                         (#1#
                          (|error| (STRCONC "tanh: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;tanh;2S;25!1| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;tanre| (SPADCALL |coef| (QREFELT $ 94)) |y|
             (SPADCALL |z| (QREFELT $ 28))
             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 42)) $))))) 

(SDEFUN |STTF;tanh;2S;25!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STTF;tanre| (|spadConstant| $ 26) |y|
             (SPADCALL |z| (QREFELT $ 28))
             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 42)) $))))) 

(SDEFUN |STTF;coth;2S;26| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((#1=#:G943 NIL) (|tanhz| (|Stream| |Coef|)))
               (SEQ (LETT |tanhz| (SPADCALL |z| (QREFELT $ 95)))
                    (EXIT
                     (COND
                      ((SPADCALL |tanhz| (QREFELT $ 22))
                       (|error| "coth: coth(0) is undefined"))
                      ((SPADCALL (SPADCALL |tanhz| (QREFELT $ 25))
                                 (|spadConstant| $ 26) (QREFELT $ 27))
                       (|error| (STRCONC "coth: " (QREFELT $ 9))))
                      ('T
                       (PROG2 (LETT #1# (SPADCALL |tanhz| (QREFELT $ 62)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0)
                                         (|Stream| (QREFELT $ 6))
                                         (|Union| (|Stream| (QREFELT $ 6))
                                                  "failed")
                                         #1#)))))))) 

(SDEFUN |STTF;sech;2S;27| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((#1=#:G951 NIL) (|coshz| (|Stream| |Coef|)))
               (SEQ (LETT |coshz| (SPADCALL |z| (QREFELT $ 93)))
                    (COND
                     ((OR (SPADCALL |coshz| (QREFELT $ 22))
                          (SPADCALL (SPADCALL |coshz| (QREFELT $ 25))
                                    (|spadConstant| $ 26) (QREFELT $ 27)))
                      (EXIT (|error| (STRCONC "sech: " (QREFELT $ 9))))))
                    (EXIT
                     (PROG2 (LETT #1# (SPADCALL |coshz| (QREFELT $ 62)))
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                                       (|Union| (|Stream| (QREFELT $ 6))
                                                "failed")
                                       #1#)))))) 

(SDEFUN |STTF;csch;2S;28| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((#1=#:G958 NIL) (|sinhz| (|Stream| |Coef|)))
               (SEQ (LETT |sinhz| (SPADCALL |z| (QREFELT $ 92)))
                    (COND
                     ((OR (SPADCALL |sinhz| (QREFELT $ 22))
                          (SPADCALL (SPADCALL |sinhz| (QREFELT $ 25))
                                    (|spadConstant| $ 26) (QREFELT $ 27)))
                      (EXIT (|error| (STRCONC "csch: " (QREFELT $ 9))))))
                    (EXIT
                     (PROG2 (LETT #1# (SPADCALL |sinhz| (QREFELT $ 62)))
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                                       (|Union| (|Stream| (QREFELT $ 6))
                                                "failed")
                                       #1#)))))) 

(SDEFUN |STTF;asinh;2S;29| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((#1=#:G971 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24)))
            (#2='T
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (EXIT
                   (COND
                    ((SPADCALL |coef| (|spadConstant| $ 26) (QREFELT $ 27))
                     (SPADCALL
                      (SPADCALL |z|
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                          (SPADCALL
                                           (SPADCALL (|spadConstant| $ 23)
                                                     (QREFELT $ 24))
                                           (SPADCALL |z| |z| (QREFELT $ 18))
                                           (QREFELT $ 55))
                                          (QREFELT $ 73))
                                (QREFELT $ 55))
                      (QREFELT $ 36)))
                    ((QREFELT $ 7)
                     (SEQ
                      (LETT |x|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                             (SPADCALL |z| |z| (QREFELT $ 18)) (QREFELT $ 55)))
                      (LETT |ord| (|STTF;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "asinh: " (QREFELT $ 11))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |coef| (QREFELT $ 99))
                                          (QREFELT $ 24)))
                          (GO #3=#:G970)))
                        ((ODDP |order|)
                         (|error| (STRCONC "asinh: " (QREFELT $ 10))))
                        (#2#
                         (SPADCALL
                          (SPADCALL |z|
                                    (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                              (QREFELT $ 73))
                                    (QREFELT $ 55))
                          (QREFELT $ 36)))))))
                    (#2# (|error| (STRCONC "asinh: " (QREFELT $ 8))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |STTF;acosh;2S;30| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((#1=#:G985 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (COND
              ((QREFELT $ 7)
               (SPADCALL (SPADCALL (|spadConstant| $ 26) (QREFELT $ 101))
                         (QREFELT $ 24)))
              (#2='T (|error| (STRCONC "acosh: " (QREFELT $ 8))))))
            ((QREFELT $ 7)
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (COND
                   ((OR (SPADCALL |coef| (|spadConstant| $ 23) (QREFELT $ 27))
                        (SPADCALL |coef|
                                  (SPADCALL (|spadConstant| $ 23)
                                            (QREFELT $ 42))
                                  (QREFELT $ 27)))
                    (EXIT
                     (SEQ
                      (LETT |x|
                            (SPADCALL (SPADCALL |z| |z| (QREFELT $ 18))
                                      (SPADCALL (|spadConstant| $ 23)
                                                (QREFELT $ 24))
                                      (QREFELT $ 72)))
                      (LETT |ord| (|STTF;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "acosh: " (QREFELT $ 11))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |coef| (QREFELT $ 101))
                                          (QREFELT $ 24)))
                          (GO #3=#:G984)))
                        ((ODDP |order|)
                         (|error| (STRCONC "acosh: " (QREFELT $ 10))))
                        (#2#
                         (SPADCALL
                          (SPADCALL |z|
                                    (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                              (QREFELT $ 73))
                                    (QREFELT $ 55))
                          (QREFELT $ 36)))))))))
                  (EXIT
                   (SPADCALL
                    (SPADCALL |z|
                              (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                        (SPADCALL
                                         (SPADCALL |z| |z| (QREFELT $ 18))
                                         (SPADCALL (|spadConstant| $ 23)
                                                   (QREFELT $ 24))
                                         (QREFELT $ 72))
                                        (QREFELT $ 73))
                              (QREFELT $ 55))
                    (QREFELT $ 36)))))
            (#2# (|error| (STRCONC "acosh: " (QREFELT $ 8))))))
          #3# (EXIT #1#)))) 

(SDEFUN |STTF;atanh;2S;31| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 22))
                  (SPADCALL (|spadConstant| $ 26) (QREFELT $ 24)))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 26)
                                    (QREFELT $ 27))
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL 2 (QREFELT $ 103))
                                      (QREFELT $ 104))
                            (QREFELT $ 105))
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                              |z| (QREFELT $ 55))
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                              |z| (QREFELT $ 72))
                             (QREFELT $ 34))
                            (QREFELT $ 36))
                           (QREFELT $ 41)))
                         ((QREFELT $ 7)
                          (COND
                           ((OR
                             (SPADCALL |coef| (|spadConstant| $ 23)
                                       (QREFELT $ 27))
                             (SPADCALL |coef|
                                       (SPADCALL (|spadConstant| $ 23)
                                                 (QREFELT $ 42))
                                       (QREFELT $ 27)))
                            (|error| (STRCONC "atanh: " (QREFELT $ 12))))
                           ('T
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (SPADCALL 2 (QREFELT $ 103))
                                        (QREFELT $ 104))
                              (QREFELT $ 105))
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                                |z| (QREFELT $ 55))
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                                |z| (QREFELT $ 72))
                               (QREFELT $ 34))
                              (QREFELT $ 36))
                             (QREFELT $ 41)))))
                         (#1#
                          (|error| (STRCONC "atanh: " (QREFELT $ 8)))))))))))) 

(SDEFUN |STTF;acoth;2S;32| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (COND
         ((SPADCALL |z| (QREFELT $ 22))
          (COND
           ((QREFELT $ 7)
            (SPADCALL (SPADCALL (|spadConstant| $ 26) (QREFELT $ 107))
                      (QREFELT $ 24)))
           (#1='T (|error| (STRCONC "acoth: " (QREFELT $ 8))))))
         ((QREFELT $ 7)
          (COND
           ((OR
             (SPADCALL (SPADCALL |z| (QREFELT $ 25)) (|spadConstant| $ 23)
                       (QREFELT $ 27))
             (SPADCALL (SPADCALL |z| (QREFELT $ 25))
                       (SPADCALL (|spadConstant| $ 23) (QREFELT $ 42))
                       (QREFELT $ 27)))
            (|error| (STRCONC "acoth: " (QREFELT $ 12))))
           ('T
            (SPADCALL
             (SPADCALL (SPADCALL (SPADCALL 2 (QREFELT $ 103)) (QREFELT $ 104))
                       (QREFELT $ 105))
             (SPADCALL
              (SPADCALL
               (SPADCALL |z| (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                         (QREFELT $ 55))
               (SPADCALL |z| (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                         (QREFELT $ 72))
               (QREFELT $ 34))
              (QREFELT $ 36))
             (QREFELT $ 41)))))
         (#1# (|error| (STRCONC "acoth: " (QREFELT $ 8)))))) 

(SDEFUN |STTF;asech;2S;33| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((#1=#:G1010 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|))
          (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (|error| "asech: asech(0) is undefined"))
            ((QREFELT $ 7)
             (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 25)))
                  (EXIT
                   (COND
                    ((SPADCALL |coef| (|spadConstant| $ 26) (QREFELT $ 27))
                     (|error| (STRCONC "asech: " (QREFELT $ 13))))
                    ((OR (SPADCALL |coef| (|spadConstant| $ 23) (QREFELT $ 27))
                         (SPADCALL |coef|
                                   (SPADCALL (|spadConstant| $ 23)
                                             (QREFELT $ 42))
                                   (QREFELT $ 27)))
                     (SEQ
                      (LETT |x|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                             (SPADCALL |z| |z| (QREFELT $ 18)) (QREFELT $ 72)))
                      (LETT |ord| (|STTF;orderOrFailed| |x| $))
                      (EXIT
                       (COND
                        ((QEQCAR |ord| 1)
                         (|error| (STRCONC "asech: " (QREFELT $ 11))))
                        ((EQL (LETT |order| (QCDR |ord|)) -1)
                         (PROGN
                          (LETT #1#
                                (SPADCALL (SPADCALL |coef| (QREFELT $ 109))
                                          (QREFELT $ 24)))
                          (GO #2=#:G1009)))
                        ((ODDP |order|)
                         (|error| (STRCONC "asech: " (QREFELT $ 10))))
                        (#3='T
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                            (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                      (QREFELT $ 73))
                            (QREFELT $ 55))
                           |z| (QREFELT $ 34))
                          (QREFELT $ 36)))))))
                    ('T
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                        (SPADCALL (SPADCALL 1 2 (QREFELT $ 70))
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 23)
                                             (QREFELT $ 24))
                                   (SPADCALL |z| |z| (QREFELT $ 18))
                                   (QREFELT $ 72))
                                  (QREFELT $ 73))
                        (QREFELT $ 55))
                       |z| (QREFELT $ 34))
                      (QREFELT $ 36)))))))
            (#3# (|error| (STRCONC "asech: " (QREFELT $ 8))))))
          #2# (EXIT #1#)))) 

(SDEFUN |STTF;acsch;2S;34| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((#1=#:G1020 NIL) (|order| (|Integer|))
          (|ord| (|Union| (|Integer|) "failed")) (|x| (|Stream| |Coef|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |z| (QREFELT $ 22))
             (|error| "acsch: acsch(0) is undefined"))
            ((QREFELT $ 7)
             (COND
              ((SPADCALL (SPADCALL |z| (QREFELT $ 25)) (|spadConstant| $ 26)
                         (QREFELT $ 27))
               (|error| (STRCONC "acsch: " (QREFELT $ 13))))
              (#2='T
               (SEQ
                (LETT |x|
                      (SPADCALL (SPADCALL |z| |z| (QREFELT $ 18))
                                (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                                (QREFELT $ 55)))
                (LETT |ord| (|STTF;orderOrFailed| |x| $))
                (EXIT
                 (COND
                  ((QEQCAR |ord| 1)
                   (|error| (STRCONC "acsc: " (QREFELT $ 11))))
                  ((EQL (LETT |order| (QCDR |ord|)) -1)
                   (PROGN
                    (LETT #1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |z| (QREFELT $ 25))
                                     (QREFELT $ 111))
                           (QREFELT $ 24)))
                    (GO #3=#:G1019)))
                  ((ODDP |order|) (|error| (STRCONC "acsch: " (QREFELT $ 10))))
                  (#2#
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (SPADCALL (|spadConstant| $ 23) (QREFELT $ 24))
                               (SPADCALL (SPADCALL 1 2 (QREFELT $ 70)) |x|
                                         (QREFELT $ 73))
                               (QREFELT $ 55))
                     |z| (QREFELT $ 34))
                    (QREFELT $ 36)))))))))
            (#2# (|error| (STRCONC "acsch: " (QREFELT $ 8))))))
          #3# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |StreamTranscendentalFunctions;|)) 

(DEFUN |StreamTranscendentalFunctions| (#1=#:G1021)
  (SPROG NIL
         (PROG (#2=#:G1022)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StreamTranscendentalFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|StreamTranscendentalFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|StreamTranscendentalFunctions|)))))))))) 

(DEFUN |StreamTranscendentalFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|StreamTranscendentalFunctions| DV$1))
          (LETT $ (GETREFV 113))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|StreamTranscendentalFunctions|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|HasCategory| |#1| '(|TranscendentalFunctionCategory|)))
          (QSETREFV $ 8 "series expansion involves transcendental constants")
          (QSETREFV $ 9 "series expansion has terms of negative degree")
          (QSETREFV $ 10 "series expansion has terms of fractional degree")
          (QSETREFV $ 11
                    "series expansion may have terms of fractional degree")
          (QSETREFV $ 12 "series expansion has logarithmic term")
          (QSETREFV $ 13
                    "series expansion has terms of negative degree or logarithmic term")
          (QSETREFV $ 14
                    "series expansion has terms of fractional degree or logarithmic term")
          (QSETREFV $ 15 "leading coefficient not invertible")
          $))) 

(MAKEPROP '|StreamTranscendentalFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'TRANSFCN 'TRCONST
              'NPOWERS 'FPOWERS 'MAYFPOW 'LOGS 'NPOWLOG 'FPOWLOG 'NOTINV
              (|Stream| 6) (|StreamTaylorSeriesOperations| 6) (0 . *)
              (|Mapping| 16) (6 . |lazyIntegrate|) (|Boolean|) (12 . |empty?|)
              (17 . |One|) (21 . |coerce|) (26 . |frst|) (31 . |Zero|) (35 . =)
              (41 . |deriv|) (|Mapping| 16 16)
              (|ParadoxicalCombinatorsForStreams| 6) (46 . Y) (51 . |exp|)
              |STTF;exp;2S;2| (56 . /) (62 . |log|) |STTF;log;2S;3|
              |STTF;^;3S;4| (|List| 16) (67 . |second|) (72 . |first|) (77 . *)
              (83 . -) (|Mapping| 38 38) (|Integer|) (88 . Y) (94 . |sin|)
              (99 . |cos|) (104 . |One|)
              (|Record| (|:| |sin| 16) (|:| |cos| 16)) |STTF;sincos;SR;6|
              |STTF;sin;2S;7| |STTF;cos;2S;8| (|PositiveInteger|) (108 . |One|)
              (112 . +) (118 . |tan|) |STTF;tan;2S;10| (123 . -) (128 . |cot|)
              |STTF;cot;2S;12| (|Union| 16 '"failed") (133 . |recip|)
              (138 . |first|) |STTF;sec;2S;13| |STTF;csc;2S;14| (143 . |zero?|)
              (148 . |rst|) (|Fraction| 44) (153 . |One|) (157 . /) (163 . -)
              (168 . -) (174 . |powern|) (180 . |integrate|) (186 . |asin|)
              (191 . |exquo|) |STTF;asin;2S;16| (197 . |acos|)
              |STTF;acos;2S;17| (202 . |atan|) |STTF;atan;2S;18| (207 . |acot|)
              |STTF;acot;2S;19| (212 . |asec|) |STTF;asec;2S;20| (217 . |acsc|)
              |STTF;acsc;2S;21| (222 . |sinh|) (227 . |cosh|)
              (|Record| (|:| |sinh| 16) (|:| |cosh| 16)) |STTF;sinhcosh;SR;22|
              |STTF;sinh;2S;23| |STTF;cosh;2S;24| (232 . |tanh|)
              |STTF;tanh;2S;25| |STTF;coth;2S;26| |STTF;sech;2S;27|
              |STTF;csch;2S;28| (237 . |asinh|) |STTF;asinh;2S;29|
              (242 . |acosh|) |STTF;acosh;2S;30| (247 . |coerce|) (252 . |inv|)
              (257 . |coerce|) |STTF;atanh;2S;31| (262 . |acoth|)
              |STTF;acoth;2S;32| (267 . |asech|) |STTF;asech;2S;33|
              (272 . |acsch|) |STTF;acsch;2S;34|)
           '#(|tanh| 277 |tan| 282 |sinhcosh| 287 |sinh| 292 |sincos| 297 |sin|
              302 |sech| 307 |sec| 312 |log| 317 |exp| 322 |csch| 327 |csc| 332
              |coth| 337 |cot| 342 |cosh| 347 |cos| 352 |atanh| 357 |atan| 362
              |asinh| 367 |asin| 372 |asech| 377 |asec| 382 |acsch| 387 |acsc|
              392 |acoth| 397 |acot| 402 |acosh| 407 |acos| 412 ^ 417)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|exp| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|log| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((^
                                 ((|Stream| |#1|) (|Stream| |#1|)
                                  (|Stream| |#1|)))
                                T)
                              '((|sincos|
                                 ((|Record| (|:| |sin| (|Stream| |#1|))
                                            (|:| |cos| (|Stream| |#1|)))
                                  (|Stream| |#1|)))
                                T)
                              '((|sin| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|cos| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|tan| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|cot| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|sec| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|csc| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asin| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acos| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|atan| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acot| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asec| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acsc| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|sinhcosh|
                                 ((|Record| (|:| |sinh| (|Stream| |#1|))
                                            (|:| |cosh| (|Stream| |#1|)))
                                  (|Stream| |#1|)))
                                T)
                              '((|sinh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|cosh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|tanh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|coth| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|sech| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|csch| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asinh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acosh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|atanh| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acoth| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|asech| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|acsch| ((|Stream| |#1|) (|Stream| |#1|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 112
                                            '(2 17 16 16 16 18 2 17 16 6 19 20
                                              1 16 21 0 22 0 6 0 23 1 17 16 6
                                              24 1 16 6 0 25 0 6 0 26 2 6 21 0
                                              0 27 1 17 16 16 28 1 30 16 29 31
                                              1 6 0 0 32 2 17 16 16 16 34 1 6 0
                                              0 35 1 38 16 0 39 1 38 16 0 40 2
                                              17 16 6 16 41 1 6 0 0 42 2 30 38
                                              43 44 45 1 6 0 0 46 1 6 0 0 47 0
                                              44 0 48 0 53 0 54 2 17 16 16 16
                                              55 1 6 0 0 56 1 17 16 16 58 1 6 0
                                              0 59 1 17 61 16 62 1 16 6 0 63 1
                                              6 21 0 66 1 16 0 0 67 0 68 0 69 2
                                              68 0 44 44 70 1 68 0 0 71 2 17 16
                                              16 16 72 2 17 16 68 16 73 2 17 16
                                              6 16 74 1 6 0 0 75 2 17 61 16 16
                                              76 1 6 0 0 78 1 6 0 0 80 1 6 0 0
                                              82 1 6 0 0 84 1 6 0 0 86 1 6 0 0
                                              88 1 6 0 0 89 1 6 0 0 94 1 6 0 0
                                              99 1 6 0 0 101 1 68 0 44 103 1 68
                                              0 0 104 1 6 0 68 105 1 6 0 0 107
                                              1 6 0 0 109 1 6 0 0 111 1 0 16 16
                                              95 1 0 16 16 57 1 0 90 16 91 1 0
                                              16 16 92 1 0 49 16 50 1 0 16 16
                                              51 1 0 16 16 97 1 0 16 16 64 1 0
                                              16 16 36 1 0 16 16 33 1 0 16 16
                                              98 1 0 16 16 65 1 0 16 16 96 1 0
                                              16 16 60 1 0 16 16 93 1 0 16 16
                                              52 1 0 16 16 106 1 0 16 16 81 1 0
                                              16 16 100 1 0 16 16 77 1 0 16 16
                                              110 1 0 16 16 85 1 0 16 16 112 1
                                              0 16 16 87 1 0 16 16 108 1 0 16
                                              16 83 1 0 16 16 102 1 0 16 16 79
                                              2 0 16 16 16 37)))))
           '|lookupComplete|)) 
