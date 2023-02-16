
(SDEFUN |STREAM;explicitlyEmpty?;$B;1| ((|x| ($)) ($ (|Boolean|)))
        (EQ (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 7))) 

(SDEFUN |STREAM;lazy?;$B;2| ((|x| ($)) ($ (|Boolean|)))
        (EQ (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 8))) 

(SDEFUN |STREAM;uninitialized?| ((|x| ($)) ($ (|Boolean|)))
        (EQ (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 9))) 

(PUT '|STREAM;frst;$S;4| '|SPADreplace| 'QCAR) 

(SDEFUN |STREAM;frst;$S;4| ((|x| ($)) ($ (S))) (QCAR |x|)) 

(PUT '|STREAM;rst;2$;5| '|SPADreplace| 'QCDR) 

(SDEFUN |STREAM;rst;2$;5| ((|x| ($)) ($ ($))) (QCDR |x|)) 

(SDEFUN |STREAM;setfrst!| ((|x| ($)) (|s| (S)) ($ (S)))
        (PROGN (RPLACA |x| |s|) (QCAR |x|))) 

(SDEFUN |STREAM;setrst!| ((|x| ($)) (|y| ($)) ($ ($)))
        (PROGN (RPLACD |x| |y|) (QCDR |x|))) 

(SDEFUN |STREAM;setToNil!| ((|x| ($)) ($ ($)))
        (SEQ (|STREAM;setfrst!| |x| (QREFELT $ 7) $)
             (|STREAM;setrst!| |x| NIL $) (EXIT |x|))) 

(SDEFUN |STREAM;getm|
        ((|x| ($)) (|le| (|List| (|OutputForm|))) (|n| (|Integer|))
         ($ (|List| (|OutputForm|))))
        (COND ((SPADCALL |x| (QREFELT $ 13)) |le|)
              ((SPADCALL |x| (QREFELT $ 14))
               (COND
                ((> |n| 0)
                 (COND ((SPADCALL |x| (QREFELT $ 16)) |le|)
                       (#1='T
                        (|STREAM;getm| (SPADCALL |x| (QREFELT $ 15))
                         (CONS
                          (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                    (QREFELT $ 18))
                          |le|)
                         (- |n| 1) $))))
                (#1# (CONS (SPADCALL '|...| (QREFELT $ 20)) |le|))))
              ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 21))
               (CONS
                (SPADCALL
                 (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 18))
                 (QREFELT $ 22))
                |le|))
              ((> |n| 0)
               (|STREAM;getm| (SPADCALL |x| (QREFELT $ 15))
                (CONS (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 18))
                      |le|)
                (- |n| 1) $))
              (#1# (CONS (SPADCALL '|...| (QREFELT $ 20)) |le|)))) 

(SDEFUN |STREAM;showElements;Nni$Of;10|
        ((|count| (|NonNegativeInteger|)) (|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|pp| (|OutputForm|)) (|pl| #1=(|List| (|OutputForm|)))
          (#2=#:G820 NIL) (|i| NIL) (|le| #1#) (#3=#:G819 NIL)
          (|fc|
           (|Record| (|:| |cycle?| (|Boolean|))
                     (|:| |prefix| (|NonNegativeInteger|))
                     (|:| |period| (|NonNegativeInteger|))))
          (|y| ($)) (#4=#:G818 NIL))
         (SEQ (LETT |y| |x|)
              (SEQ (LETT |i| 1) (LETT #4# |count|) G190
                   (COND
                    ((OR (|greater_SI| |i| #4#)
                         (NULL (NULL (SPADCALL |y| (QREFELT $ 16)))))
                     (GO G191)))
                   (SEQ (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 15)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |fc| (SPADCALL |count| |x| (QREFELT $ 25)))
              (COND
               ((NULL (QVELT |fc| 0))
                (EXIT
                 (SPADCALL (NREVERSE (|STREAM;getm| |x| NIL |count| $))
                           (QREFELT $ 27)))))
              (LETT |le| NIL)
              (SEQ (LETT |i| 1) (LETT #3# (QVELT |fc| 1)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |le|
                          (CONS
                           (SPADCALL (SPADCALL |x| (QREFELT $ 28))
                                     (QREFELT $ 18))
                           |le|))
                    (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 29)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |pp|
                    (COND
                     ((EQL (QVELT |fc| 2) 1)
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 18))
                       (QREFELT $ 22)))
                     ('T
                      (SEQ (LETT |pl| NIL)
                           (SEQ (LETT |i| 1) (LETT #2# (QVELT |fc| 2)) G190
                                (COND ((|greater_SI| |i| #2#) (GO G191)))
                                (SEQ
                                 (LETT |pl|
                                       (CONS
                                        (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                                  (QREFELT $ 18))
                                        |pl|))
                                 (EXIT
                                  (LETT |x| (SPADCALL |x| (QREFELT $ 29)))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (SPADCALL (SPADCALL (NREVERSE |pl|) (QREFELT $ 30))
                                      (QREFELT $ 22)))))))
              (EXIT (SPADCALL (NREVERSE (CONS |pp| |le|)) (QREFELT $ 27)))))) 

(SDEFUN |STREAM;streamCountCoerce| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|count| (|NonNegativeInteger|)))
               (SEQ (LETT |count| |$streamCount|)
                    (EXIT (SPADCALL |count| |x| (QREFELT $ 31)))))) 

(SDEFUN |STREAM;listm|
        ((|x| ($)) (|le| (|List| (|OutputForm|))) (|n| (|Integer|))
         ($ (|List| (|OutputForm|))))
        (COND ((SPADCALL |x| (QREFELT $ 13)) |le|)
              ((SPADCALL |x| (QREFELT $ 14))
               (COND
                ((> |n| 0)
                 (COND ((SPADCALL |x| (QREFELT $ 16)) |le|)
                       (#1='T
                        (|STREAM;listm| (SPADCALL |x| (QREFELT $ 15))
                         (CONS
                          (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                    (QREFELT $ 18))
                          |le|)
                         (- |n| 1) $))))
                (#1# (CONS (SPADCALL '|...| (QREFELT $ 20)) |le|))))
              (#1#
               (|STREAM;listm| (SPADCALL |x| (QREFELT $ 15))
                (CONS (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 18))
                      |le|)
                (- |n| 1) $)))) 

(SDEFUN |STREAM;showAllElements;$Of;13| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|pp| (|OutputForm|)) (|pl| (|List| (|OutputForm|))) (#1=#:G842 NIL)
          (|i| NIL) (|len| (|NonNegativeInteger|))
          (|le| (|List| (|OutputForm|))) (|cycEnt| ($))
          (|cycElt| (|Union| $ "failed")))
         (SEQ (SPADCALL |x| |$streamCount| (QREFELT $ 33))
              (LETT |cycElt| (SPADCALL |x| (QREFELT $ 36)))
              (EXIT
               (COND
                ((QEQCAR |cycElt| 1)
                 (SEQ (LETT |le| (|STREAM;listm| |x| NIL |$streamCount| $))
                      (EXIT (SPADCALL (NREVERSE |le|) (QREFELT $ 27)))))
                (#2='T
                 (SEQ
                  (LETT |cycEnt| (SPADCALL |x| (QCDR |cycElt|) (QREFELT $ 37)))
                  (LETT |le| NIL)
                  (SEQ G190
                       (COND
                        ((NULL (NULL (SPADCALL |x| |cycEnt| (QREFELT $ 21))))
                         (GO G191)))
                       (SEQ
                        (LETT |le|
                              (CONS
                               (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                         (QREFELT $ 18))
                               |le|))
                        (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 15)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (LETT |len| (SPADCALL (QCDR |cycElt|) (QREFELT $ 38)))
                  (LETT |pp|
                        (COND
                         ((EQL |len| 1)
                          (SPADCALL
                           (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                     (QREFELT $ 18))
                           (QREFELT $ 22)))
                         (#2#
                          (SEQ (LETT |pl| NIL)
                               (SEQ (LETT |i| 1) (LETT #1# |len|) G190
                                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                                    (SEQ
                                     (LETT |pl|
                                           (CONS
                                            (SPADCALL
                                             (SPADCALL |x| (QREFELT $ 11))
                                             (QREFELT $ 18))
                                            |pl|))
                                     (EXIT
                                      (LETT |x|
                                            (SPADCALL |x| (QREFELT $ 15)))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL (NREVERSE |pl|) (QREFELT $ 30))
                                 (QREFELT $ 22)))))))
                  (EXIT
                   (SPADCALL (NREVERSE (CONS |pp| |le|)) (QREFELT $ 27)))))))))) 

(PUT '|STREAM;showAll?;B;14| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |STREAM;showAll?;B;14| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |STREAM;coerce;$Of;15| ((|x| ($)) ($ (|OutputForm|)))
        (COND ((SPADCALL (QREFELT $ 40)) (SPADCALL |x| (QREFELT $ 39)))
              ('T (|STREAM;streamCountCoerce| |x| $)))) 

(SDEFUN |STREAM;lazyCopy| ((|x| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;lazyCopy!0| (VECTOR $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;lazyCopy!0| (($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 16)) (SPADCALL (QREFELT $ 42)))
                  ('T
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                       (QREFELT $ 43))
                             (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;copy;2$;17| ((|x| ($)) ($ ($)))
        (SPROG
         ((|head| ($)) (#1=#:G858 NIL) (|cycle| ($)) (|d| (|Integer|))
          (|e| ($)) (|len| (|NonNegativeInteger|)) (|ce| ($))
          (|cycElt| (|Union| $ "failed")))
         (SEQ (LETT |cycElt| (SPADCALL |x| (QREFELT $ 36)))
              (EXIT
               (COND ((QEQCAR |cycElt| 1) (|STREAM;lazyCopy| |x| $))
                     (#2='T
                      (SEQ (LETT |ce| (QCDR |cycElt|))
                           (LETT |len| (SPADCALL |ce| (QREFELT $ 38)))
                           (LETT |e| (SPADCALL |x| |ce| (QREFELT $ 37)))
                           (LETT |d| (SPADCALL |x| |e| (QREFELT $ 47)))
                           (LETT |cycle|
                                 (SPADCALL (SPADCALL |e| |len| (QREFELT $ 48))
                                           (QREFELT $ 49)))
                           (|STREAM;setrst!| (SPADCALL |cycle| (QREFELT $ 50))
                            |cycle| $)
                           (EXIT
                            (COND ((EQL |d| 0) |cycle|)
                                  (#2#
                                   (SEQ
                                    (LETT |head|
                                          (SPADCALL
                                           (SPADCALL |x|
                                                     (PROG1 (LETT #1# |d|)
                                                       (|check_subtype2|
                                                        (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#))
                                                     (QREFELT $ 48))
                                           (QREFELT $ 49)))
                                    (|STREAM;setrst!|
                                     (SPADCALL |head| (QREFELT $ 50)) |cycle|
                                     $)
                                    (EXIT |head|)))))))))))) 

(SDEFUN |STREAM;construct;L$;18| ((|l| (|List| S)) ($ ($)))
        (APPEND |l| (SPADCALL (QREFELT $ 42)))) 

(SDEFUN |STREAM;elt;$IS;19| ((|x| ($)) (|n| (|Integer|)) ($ (S)))
        (COND
         ((OR (< |n| 1) (SPADCALL |x| (QREFELT $ 16)))
          (|error| "elt: no such element"))
         ('T
          (COND ((EQL |n| 1) (SPADCALL |x| (QREFELT $ 11)))
                ('T
                 (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (- |n| 1)
                           (QREFELT $ 53))))))) 

(SDEFUN |STREAM;seteltt| ((|x| ($)) (|n| (|Integer|)) (|s| (S)) ($ (S)))
        (COND ((EQL |n| 1) (|STREAM;setfrst!| |x| |s| $))
              ('T
               (|STREAM;seteltt| (SPADCALL |x| (QREFELT $ 15)) (- |n| 1) |s|
                $)))) 

(SDEFUN |STREAM;setelt!;$I2S;21|
        ((|x| ($)) (|n| (|Integer|)) (|s| (S)) ($ (S)))
        (SEQ
         (COND
          ((OR (< |n| 1) (SPADCALL |x| (QREFELT $ 16)))
           (|error| "setelt!: no such element"))
          ('T
           (SEQ (LETT |x| (|STREAM;expand!| |x| (+ (- |n| 1) 1) $))
                (EXIT (|STREAM;seteltt| |x| |n| |s| $))))))) 

(SDEFUN |STREAM;removee| ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;removee!0| (VECTOR |p| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;removee!0| (($$ NIL))
        (PROG (|x| $ |p|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 16)) (SPADCALL (QREFELT $ 42)))
                  ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|)
                   (SPADCALL |p| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 56)))
                  ('T
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL |p| (SPADCALL |x| (QREFELT $ 15))
                                       (QREFELT $ 56))
                             (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;remove;M2$;23|
        ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) (SPADCALL (QREFELT $ 42)))
              ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 21))
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|)
                 (SPADCALL (QREFELT $ 42)))
                (#1='T |x|)))
              (#1# (|STREAM;removee| |p| |x| $)))) 

(SDEFUN |STREAM;selectt| ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;selectt!0| (VECTOR |p| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;selectt!0| (($$ NIL))
        (PROG (|x| $ |p|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 16)) (SPADCALL (QREFELT $ 42)))
                  ((NULL (SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|))
                   (SPADCALL |p| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 57)))
                  ('T
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL |p| (SPADCALL |x| (QREFELT $ 15))
                                       (QREFELT $ 57))
                             (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;select;M2$;25|
        ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) (SPADCALL (QREFELT $ 42)))
              ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 21))
               (COND ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|) |x|)
                     (#1='T (SPADCALL (QREFELT $ 42)))))
              (#1# (|STREAM;selectt| |p| |x| $)))) 

(SDEFUN |STREAM;map;M2$;26| ((|f| (|Mapping| S S)) (|x| ($)) ($ ($)))
        (SPADCALL |f| |x| (QREFELT $ 61))) 

(SDEFUN |STREAM;map;M3$;27|
        ((|g| (|Mapping| S S S)) (|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|ys| (|Stream| S)) (|xs| (|Stream| S)))
               (SEQ (LETT |xs| |x|) (LETT |ys| |y|)
                    (EXIT (SPADCALL |g| |xs| |ys| (QREFELT $ 65)))))) 

(SDEFUN |STREAM;fill!;$S$;28| ((|x| ($)) (|s| (S)) ($ ($)))
        (SEQ (|STREAM;setfrst!| |x| |s| $) (EXIT (|STREAM;setrst!| |x| |x| $)))) 

(SDEFUN |STREAM;map!;M2$;29| ((|f| (|Mapping| S S)) (|x| ($)) ($ ($)))
        (SPROG ((|y| ($)) (#1=#:G963 NIL) (|tail| ($)))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 68))
                  (SEQ (LETT |tail| (SPADCALL |x| (QREFELT $ 69)))
                       (LETT |y| |x|)
                       (SEQ (LETT #1# NIL) G190 (COND (#1# (GO G191)))
                            (SEQ
                             (|STREAM;setfrst!| |y|
                              (SPADCALL (SPADCALL |y| (QREFELT $ 11)) |f|) $)
                             (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 15)))))
                            (LETT #1# (SPADCALL |y| |tail| (QREFELT $ 70)))
                            (GO G190) G191 (EXIT NIL))
                       (EXIT |x|)))
                 ((SPADCALL |x| (QREFELT $ 71))
                  (SEQ (LETT |y| |x|)
                       (SEQ G190
                            (COND
                             ((NULL (NULL (SPADCALL |y| (QREFELT $ 16))))
                              (GO G191)))
                            (SEQ
                             (|STREAM;setfrst!| |y|
                              (SPADCALL (SPADCALL |y| (QREFELT $ 11)) |f|) $)
                             (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 15)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |x|)))
                 ('T (|error| "map!: stream with lazy evaluation")))))) 

(SDEFUN |STREAM;swap!;$2IV;30|
        ((|x| ($)) (|m| #1=(|Integer|)) (|n| #1#) ($ (|Void|)))
        (SPROG ((|xn| (S)) (|xm| (S)))
               (SEQ
                (COND
                 ((SPADCALL |m| |x| (QREFELT $ 73))
                  (COND
                   ((NULL (SPADCALL |n| |x| (QREFELT $ 73)))
                    (EXIT (|error| #2="swap!: no such elements")))))
                 ('T (EXIT (|error| #2#))))
                (LETT |x| (|STREAM;expand!| |x| (+ (- (MAX |m| |n|) 1) 1) $))
                (LETT |xm| (SPADCALL |x| |m| (QREFELT $ 53)))
                (LETT |xn| (SPADCALL |x| |n| (QREFELT $ 53)))
                (SPADCALL |x| |m| |xn| (QREFELT $ 54))
                (SPADCALL |x| |n| |xm| (QREFELT $ 54)) (EXIT |x|)))) 

(SDEFUN |STREAM;concat;$S$;31| ((|x| ($)) (|s| (S)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;concat;$S$;31!0| (VECTOR |s| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;concat;$S$;31!0| (($$ NIL))
        (PROG (|x| $ |s|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |s| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL |x| (QREFELT $ 16))
              (SPADCALL |s| (SPADCALL (QREFELT $ 42)) (QREFELT $ 44)))
             ('T
              (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                        (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |s|
                                  (QREFELT $ 76))
                        (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;concat;3$;32| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;concat;3$;32!0| (VECTOR |y| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;concat;3$;32!0| (($$ NIL))
        (PROG (|x| $ |y|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |y| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 16)) (SPADCALL |y| (QREFELT $ 43)))
                  ('T
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |y|
                                       (QREFELT $ 77))
                             (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;concat;L$;33| ((|l| (|List| $)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;concat;L$;33!0| (VECTOR $ |l|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;concat;L$;33!0| (($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|x| NIL))
                   (COND
                    ((SPADCALL |l| (QREFELT $ 79)) (SPADCALL (QREFELT $ 42)))
                    ((SPADCALL (LETT |x| (SPADCALL |l| (QREFELT $ 80)))
                               (QREFELT $ 16))
                     (SPADCALL (SPADCALL |l| (QREFELT $ 81)) (QREFELT $ 82)))
                    ('T
                     (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                               (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                         (SPADCALL
                                          (SPADCALL |l| (QREFELT $ 81))
                                          (QREFELT $ 82))
                                         (QREFELT $ 77))
                               (QREFELT $ 44))))))))) 

(SDEFUN |STREAM;setelt!;$Us2S;34|
        ((|x| ($)) (|seg| (|UniversalSegment| (|Integer|))) (|s| (S)) ($ (S)))
        (SPROG
         ((#1=#:G1010 NIL) (|y| ($)) (#2=#:G1014 NIL) (|i| NIL)
          (#3=#:G1003 NIL) (|h| (|Integer|)) (|l| (|Integer|)))
         (SEQ (LETT |l| (SPADCALL |seg| (QREFELT $ 84)))
              (EXIT
               (COND
                ((SPADCALL |seg| (QREFELT $ 85))
                 (SEQ (LETT |h| (SPADCALL |seg| (QREFELT $ 86)))
                      (EXIT
                       (COND ((< |h| |l|) |s|)
                             (#4='T
                              (SEQ
                               (COND
                                ((SPADCALL |l| |x| (QREFELT $ 73))
                                 (COND
                                  ((NULL (SPADCALL |h| |x| (QREFELT $ 73)))
                                   (EXIT
                                    (|error|
                                     #5="setelt!: index out of range")))))
                                (#4# (EXIT (|error| #5#))))
                               (LETT |x|
                                     (|STREAM;expand!| |x| (+ (- |h| 1) 1) $))
                               (LETT |y|
                                     (SPADCALL |x|
                                               (PROG1 (LETT #3# (- |l| 1))
                                                 (|check_subtype2| (>= #3# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #3#))
                                               (QREFELT $ 87)))
                               (SEQ (LETT |i| 0) (LETT #2# (- |h| |l|)) G190
                                    (COND ((|greater_SI| |i| #2#) (GO G191)))
                                    (SEQ (|STREAM;setfrst!| |y| |s| $)
                                         (EXIT
                                          (LETT |y|
                                                (SPADCALL |y|
                                                          (QREFELT $ 15)))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT |s|)))))))
                ((NULL (SPADCALL |l| |x| (QREFELT $ 73)))
                 (|error| "setelt!: index out of range"))
                ('T
                 (SEQ
                  (LETT |x|
                        (SPADCALL |x|
                                  (PROG1 (LETT #1# (- |l| 1))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  (QREFELT $ 87)))
                  (|STREAM;setrst!| |x| |x| $)
                  (EXIT (|STREAM;setfrst!| |x| |s| $))))))))) 

(SDEFUN |STREAM;empty;$;35| (($ ($))) (CONS (QREFELT $ 7) NIL)) 

(SDEFUN |STREAM;lazyEval| ((|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 15)))) 

(SDEFUN |STREAM;lazyEvaluate;2$;37| ((|x| ($)) ($ ($)))
        (SPROG ((|st| ($)))
               (SEQ (LETT |st| (|STREAM;lazyEval| |x| $))
                    (|STREAM;setfrst!| |x| (SPADCALL |st| (QREFELT $ 11)) $)
                    (|STREAM;setrst!| |x|
                     (COND ((EQ (SPADCALL |st| (QREFELT $ 15)) |st|) |x|)
                           ('T (SPADCALL |st| (QREFELT $ 15))))
                     $)
                    (EXIT |x|)))) 

(SDEFUN |STREAM;empty?;$B;38| ((|x| ($)) ($ (|Boolean|)))
        (SPROG ((|st| ($)))
               (SEQ
                (SEQ G190
                     (COND ((NULL (SPADCALL |x| (QREFELT $ 14))) (GO G191)))
                     (SEQ (LETT |st| (|STREAM;lazyEval| |x| $))
                          (|STREAM;setfrst!| |x| (SPADCALL |st| (QREFELT $ 11))
                           $)
                          (EXIT
                           (|STREAM;setrst!| |x|
                            (COND
                             ((EQ (SPADCALL |st| (QREFELT $ 15)) |st|) |x|)
                             ('T (SPADCALL |st| (QREFELT $ 15))))
                            $)))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT
                 (COND
                  ((|STREAM;uninitialized?| |x| $)
                   (|error| "Trying to use uninitialized stream"))
                  ('T (SPADCALL |x| (QREFELT $ 13)))))))) 

(SDEFUN |STREAM;first;$Nni$;39|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;first;$Nni$;39!0| (VECTOR |x| $ |n|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;first;$Nni$;39!0| (($$ NIL))
        (PROG (|n| $ |x|)
          (LETT |n| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1043 NIL))
                   (COND
                    ((OR (SPADCALL |n| (|spadConstant| $ 90) (QREFELT $ 92))
                         (SPADCALL |x| (QREFELT $ 16)))
                     (SPADCALL (QREFELT $ 42)))
                    ('T
                     (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                               (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                         (PROG1
                                             (LETT #1#
                                                   (SPADCALL |n|
                                                             (|spadConstant| $
                                                                             93)
                                                             (QREFELT $ 95)))
                                           (|check_subtype2| (>= #1# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #1#))
                                         (QREFELT $ 48))
                               (QREFELT $ 44))))))))) 

(PUT '|STREAM;concat;S2$;40| '|SPADreplace| 'CONS) 

(SDEFUN |STREAM;concat;S2$;40| ((|s| (S)) (|x| ($)) ($ ($))) (CONS |s| |x|)) 

(SDEFUN |STREAM;cons;S2$;41| ((|s| (S)) (|x| ($)) ($ ($)))
        (SPADCALL |s| |x| (QREFELT $ 44))) 

(SDEFUN |STREAM;cycleSplit!;2$;42| ((|x| ($)) ($ ($)))
        (SPROG
         ((|z| ($)) (#1=#:G1062 NIL) (|y| ($)) (|cycElt| (|Union| $ "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |cycElt| (SPADCALL |x| (QREFELT $ 36)))
                (EXIT
                 (COND
                  ((QEQCAR |cycElt| 1)
                   (|error| "cycleSplit!: non-cyclic stream"))
                  (#2='T
                   (SEQ
                    (LETT |y| (SPADCALL |x| (QCDR |cycElt|) (QREFELT $ 37)))
                    (EXIT
                     (COND
                      ((SPADCALL |x| |y| (QREFELT $ 21))
                       (SEQ (|STREAM;setToNil!| |x| $)
                            (EXIT (PROGN (LETT #1# |y|) (GO #3=#:G1061)))))
                      (#2#
                       (SEQ (LETT |z| (SPADCALL |x| (QREFELT $ 15)))
                            (EXIT
                             (SEQ G190 NIL
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL |y| |z| (QREFELT $ 21))
                                      (SEQ
                                       (SPADCALL |x| (SPADCALL (QREFELT $ 42))
                                                 (QREFELT $ 97))
                                       (EXIT (PROGN (LETT #1# |y|) (GO #3#)))))
                                     ('T
                                      (SEQ (LETT |x| |z|)
                                           (EXIT
                                            (LETT |z|
                                                  (SPADCALL |z|
                                                            (QREFELT $
                                                                     15)))))))))
                                  NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |STREAM;expand!| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG
         ((#1=#:G1074 NIL) (|e| ($)) (|y| ($))
          (|nLessD| (|NonNegativeInteger|)) (#2=#:G1073 NIL) (|t| ($))
          (|d| (|Integer|)) (|cycElt| (|Union| $ "failed")) (#3=#:G1079 NIL)
          (|i| NIL))
         (SEQ
          (COND ((< |n| 1) |x|)
                (#4='T
                 (SEQ (LETT |y| |x|)
                      (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                           (COND
                            ((OR (|greater_SI| |i| #3#)
                                 (NULL (NULL (SPADCALL |y| (QREFELT $ 16)))))
                             (GO G191)))
                           (SEQ
                            (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 15)))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |cycElt| (SPADCALL |x| (QREFELT $ 36)))
                      (EXIT
                       (COND ((QEQCAR |cycElt| 1) |x|)
                             (#4#
                              (SEQ
                               (LETT |e|
                                     (SPADCALL |x| (QCDR |cycElt|)
                                               (QREFELT $ 37)))
                               (LETT |d| (SPADCALL |x| |e| (QREFELT $ 47)))
                               (EXIT
                                (COND ((>= |d| |n|) |x|)
                                      (#4#
                                       (SEQ
                                        (COND
                                         ((EQL |d| 0)
                                          (SEQ (LETT |d| 1)
                                               (LETT |t|
                                                     (SPADCALL |e|
                                                               (QREFELT $ 69)))
                                               (EXIT
                                                (COND
                                                 ((SPADCALL |t| |e|
                                                            (QREFELT $ 21))
                                                  (SEQ
                                                   (LETT |t|
                                                         (SPADCALL
                                                          (SPADCALL |t|
                                                                    (QREFELT $
                                                                             11))
                                                          (SPADCALL
                                                           (QREFELT $ 42))
                                                          (QREFELT $ 44)))
                                                   (LETT |e|
                                                         (|STREAM;setrst!| |t|
                                                          |t| $))
                                                   (EXIT
                                                    (|STREAM;setrst!| |x| |e|
                                                     $))))
                                                 (#4#
                                                  (SEQ
                                                   (|STREAM;setrst!| |t|
                                                    (SPADCALL
                                                     (SPADCALL |e|
                                                               (QREFELT $ 11))
                                                     (SPADCALL |e|
                                                               (QREFELT $ 15))
                                                     (QREFELT $ 44))
                                                    $)
                                                   (EXIT
                                                    (LETT |e|
                                                          (SPADCALL |e|
                                                                    (QREFELT $
                                                                             15)))))))))))
                                        (LETT |nLessD|
                                              (PROG1 (LETT #2# (- |n| |d|))
                                                (|check_subtype2| (>= #2# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #2#)))
                                        (LETT |y|
                                              (SPADCALL
                                               (SPADCALL |e| |nLessD|
                                                         (QREFELT $ 48))
                                               (QREFELT $ 49)))
                                        (LETT |e|
                                              (SPADCALL |e| |nLessD|
                                                        (QREFELT $ 87)))
                                        (|STREAM;setrst!|
                                         (SPADCALL |y| (QREFELT $ 50)) |e| $)
                                        (|STREAM;setrst!|
                                         (SPADCALL |x|
                                                   (PROG1 (LETT #1# (- |d| 1))
                                                     (|check_subtype2|
                                                      (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                                   (QREFELT $ 87))
                                         |y| $)
                                        (EXIT |x|))))))))))))))) 

(SDEFUN |STREAM;first;$S;44| ((|x| ($)) ($ (S)))
        (COND
         ((SPADCALL |x| (QREFELT $ 16))
          (|error| "Can't take the first of an empty stream."))
         ('T (SPADCALL |x| (QREFELT $ 11))))) 

(SDEFUN |STREAM;concat!;3$;45| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 16)) |y|)
              ('T (|STREAM;setrst!| (SPADCALL |x| (QREFELT $ 50)) |y| $)))) 

(SDEFUN |STREAM;concat!;$S$;46| ((|x| ($)) (|s| (S)) ($ ($)))
        (SPADCALL |x| (SPADCALL |s| (SPADCALL (QREFELT $ 42)) (QREFELT $ 44))
                  (QREFELT $ 99))) 

(SDEFUN |STREAM;setfirst!;$2S;47| ((|x| ($)) (|s| (S)) ($ (S)))
        (SPADCALL |x| 0 |s| (QREFELT $ 54))) 

(SDEFUN |STREAM;setelt!;$first2S;48|
        ((|x| ($)) (T3 ("first")) (|s| (S)) ($ (S)))
        (SPADCALL |x| |s| (QREFELT $ 101))) 

(SDEFUN |STREAM;setrest!;3$;49| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND
         ((SPADCALL |x| (QREFELT $ 16)) (|error| "setrest!: empty stream"))
         ('T (|STREAM;setrst!| |x| |y| $)))) 

(SDEFUN |STREAM;setelt!;$rest2$;50| ((|x| ($)) (T4 ("rest")) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 97))) 

(SDEFUN |STREAM;setlast!;$2S;51| ((|x| ($)) (|s| (S)) ($ (S)))
        (COND
         ((SPADCALL |x| (QREFELT $ 16)) (|error| "setlast!: empty stream"))
         ('T (|STREAM;setfrst!| (SPADCALL |x| (QREFELT $ 50)) |s| $)))) 

(SDEFUN |STREAM;setelt!;$last2S;52| ((|x| ($)) (T5 ("last")) (|s| (S)) ($ (S)))
        (SPADCALL |x| |s| (QREFELT $ 106))) 

(SDEFUN |STREAM;split!;$Nni$;53|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|y| ($)) (#1=#:G1094 NIL))
               (SEQ
                (COND ((< |n| 1) (|error| "split!: index out of range"))
                      ((EQL |n| 1)
                       (SEQ (LETT |y| (SPADCALL (QREFELT $ 42)))
                            (|STREAM;setfrst!| |y|
                             (SPADCALL |x| (QREFELT $ 11)) $)
                            (|STREAM;setrst!| |y| (SPADCALL |x| (QREFELT $ 15))
                             $)
                            (|STREAM;setToNil!| |x| $) (EXIT |y|)))
                      ('T
                       (SEQ (LETT |x| (|STREAM;expand!| |x| (- |n| 1) $))
                            (LETT |x|
                                  (SPADCALL |x|
                                            (PROG1 (LETT #1# (- (- |n| 1) 1))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 87)))
                            (LETT |y| (SPADCALL |x| (QREFELT $ 29)))
                            (|STREAM;setrst!| |x| (SPADCALL (QREFELT $ 42)) $)
                            (EXIT |y|))))))) 

(SDEFUN |STREAM;coerce;L$;54| ((|l| (|List| S)) ($ ($)))
        (SPADCALL |l| (QREFELT $ 52))) 

(SDEFUN |STREAM;repeating;L$;55| ((|l| (|List| S)) ($ ($)))
        (SPROG ((|x| ($)) (|x0| ($)))
               (SEQ
                (COND
                 ((NULL |l|)
                  (|error| "Need a non-null list to make a repeating stream."))
                 ('T
                  (SEQ (LETT |x0| (LETT |x| (SPADCALL |l| (QREFELT $ 52))))
                       (SEQ G190
                            (COND
                             ((NULL
                               (NULL
                                (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                          (QREFELT $ 16))))
                              (GO G191)))
                            (SEQ
                             (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 15)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (|STREAM;setrst!| |x| |x0| $)))))))) 

(SDEFUN |STREAM;repeating?;L$B;56| ((|l| (|List| S)) (|x| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1116 NIL) (#2=#:G1117 NIL) (|s| NIL) (|x0| ($)))
               (SEQ
                (EXIT
                 (COND
                  ((NULL |l|)
                   (|error|
                    "Need a non-empty? list to make a repeating stream."))
                  ((NULL (CDR |l|))
                   (COND
                    ((OR (SPADCALL |x| (QREFELT $ 16))
                         (NULL
                          (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                    (|SPADfirst| |l|) (QREFELT $ 112))))
                     NIL)
                    ('T
                     (SPADCALL |x| (SPADCALL |x| (QREFELT $ 15))
                               (QREFELT $ 113)))))
                  ('T
                   (SEQ (LETT |x0| |x|)
                        (SEQ (LETT |s| NIL) (LETT #2# |l|) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((OR (SPADCALL |x| (QREFELT $ 16))
                                     (SPADCALL |s|
                                               (SPADCALL |x| (QREFELT $ 11))
                                               (QREFELT $ 114)))
                                 (PROGN (LETT #1# NIL) (GO #3=#:G1115)))
                                ('T
                                 (LETT |x| (SPADCALL |x| (QREFELT $ 15)))))))
                             (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (SPADCALL |x| |x0| (QREFELT $ 21)))))))
                #3# (EXIT #1#)))) 

(SDEFUN |STREAM;findCycle;Nni$R;57|
        ((|n| (|NonNegativeInteger|)) (|x| ($))
         ($
          (|Record| (|:| |cycle?| (|Boolean|))
                    (|:| |prefix| (|NonNegativeInteger|))
                    (|:| |period| (|NonNegativeInteger|)))))
        (SPROG
         ((|npp| #1=(|NonNegativeInteger|)) (|xp| ($))
          (|per| (|NonNegativeInteger|)) (|i| #1#) (|tl| ($)) (|hd| ($)))
         (SEQ (LETT |hd| |x|) (LETT |tl| (SPADCALL |x| |n| (QREFELT $ 87)))
              (EXIT
               (COND ((SPADCALL |tl| (QREFELT $ 13)) (VECTOR NIL 0 0))
                     (#2='T
                      (SEQ (LETT |i| 0)
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (NULL (SPADCALL |x| |tl| (QREFELT $ 21))))
                                  (GO G191)))
                                (SEQ (LETT |x| (SPADCALL |x| (QREFELT $ 15)))
                                     (EXIT (LETT |i| (+ |i| 1))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND ((EQL |i| |n|) (VECTOR NIL 0 0))
                                  (#2#
                                   (SEQ
                                    (LETT |x| (SPADCALL |x| (QREFELT $ 15)))
                                    (LETT |per| 1)
                                    (SEQ G190
                                         (COND
                                          ((NULL
                                            (NULL
                                             (SPADCALL |x| |tl|
                                                       (QREFELT $ 21))))
                                           (GO G191)))
                                         (SEQ
                                          (LETT |x|
                                                (SPADCALL |x| (QREFELT $ 15)))
                                          (EXIT (LETT |per| (+ |per| 1))))
                                         NIL (GO G190) G191 (EXIT NIL))
                                    (LETT |x| |hd|)
                                    (LETT |xp|
                                          (SPADCALL |hd| |per| (QREFELT $ 87)))
                                    (LETT |npp| 0)
                                    (SEQ G190
                                         (COND
                                          ((NULL
                                            (NULL
                                             (SPADCALL |x| |xp|
                                                       (QREFELT $ 21))))
                                           (GO G191)))
                                         (SEQ
                                          (LETT |x|
                                                (SPADCALL |x| (QREFELT $ 15)))
                                          (LETT |xp|
                                                (SPADCALL |xp| (QREFELT $ 15)))
                                          (EXIT (LETT |npp| (+ |npp| 1))))
                                         NIL (GO G190) G191 (EXIT NIL))
                                    (EXIT (VECTOR 'T |npp| |per|))))))))))))) 

(SDEFUN |STREAM;delay;M$;58| ((|fs| (|Mapping| $)) ($ ($)))
        (CONS (QREFELT $ 8) |fs|)) 

(SDEFUN |STREAM;explicitEntries?;$B;59| ((|x| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) NIL)
              ('T (NULL (SPADCALL |x| (QREFELT $ 14)))))) 

(SDEFUN |STREAM;numberOfComputedEntries;$Nni;60|
        ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|count| (|NonNegativeInteger|)))
               (SEQ (LETT |count| 0)
                    (SEQ G190
                         (COND
                          ((NULL (SPADCALL |x| (QREFELT $ 116))) (GO G191)))
                         (SEQ (LETT |count| (+ |count| 1))
                              (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 15)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |count|)))) 

(SDEFUN |STREAM;setrestt!| ((|x| ($)) (|n| (|Integer|)) (|y| ($)) ($ ($)))
        (COND ((EQL |n| 0) (|STREAM;setrst!| |x| |y| $))
              ('T
               (|STREAM;setrestt!| (SPADCALL |x| (QREFELT $ 15)) (- |n| 1) |y|
                $)))) 

(SDEFUN |STREAM;setrest!;$I2$;62|
        ((|x| ($)) (|n| (|Integer|)) (|y| ($)) ($ ($)))
        (SEQ
         (COND
          ((OR (< |n| 0) (SPADCALL |x| (QREFELT $ 16)))
           (|error| "setrest!: no such rest"))
          ('T
           (SEQ (LETT |x| (|STREAM;expand!| |x| (+ |n| 1) $))
                (EXIT (|STREAM;setrestt!| |x| |n| |y| $))))))) 

(SDEFUN |STREAM;stream;M$;63| ((|f| (|Mapping| S)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;stream;M$;63!0| (VECTOR $ |f|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;stream;M$;63!0| (($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |f|) (SPADCALL |f| (QREFELT $ 120))
                      (QREFELT $ 44)))))) 

(SDEFUN |STREAM;gen| ((|f| (|Mapping| S S)) (|s| (S)) ($ ($)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|STREAM;gen!0| (VECTOR $ |f| |s|))
                          (QREFELT $ 46))))) 

(SDEFUN |STREAM;gen!0| (($$ NIL))
        (PROG (|s| |f| $)
          (LETT |s| (QREFELT $$ 2))
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|ss| NIL))
                   (SEQ (LETT |ss| (SPADCALL |s| |f|))
                        (EXIT
                         (SPADCALL |ss| (|STREAM;gen| |f| |ss| $)
                                   (QREFELT $ 44))))))))) 

(SDEFUN |STREAM;stream;MS$;65| ((|f| (|Mapping| S S)) (|s| (S)) ($ ($)))
        (SPADCALL |s| (|STREAM;gen| |f| |s| $) (QREFELT $ 44))) 

(SDEFUN |STREAM;concat;3$;66| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;concat;3$;66!0| (VECTOR |y| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;concat;3$;66!0| (($$ NIL))
        (PROG (|x| $ |y|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |y| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 16)) |y|)
                  ('T
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |y|
                                       (QREFELT $ 77))
                             (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;swhilee| ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;swhilee!0| (VECTOR |p| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;swhilee!0| (($$ NIL))
        (PROG (|x| $ |p|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((OR (SPADCALL |x| (QREFELT $ 16))
                  (NULL (SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|)))
              (SPADCALL (QREFELT $ 42)))
             ('T
              (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                        (SPADCALL |p| (SPADCALL |x| (QREFELT $ 15))
                                  (QREFELT $ 122))
                        (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;filterWhile;M2$;68|
        ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) (SPADCALL (QREFELT $ 42)))
              ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 21))
               (COND ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|) |x|)
                     (#1='T (SPADCALL (QREFELT $ 42)))))
              (#1# (|STREAM;swhilee| |p| |x| $)))) 

(SDEFUN |STREAM;suntill| ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;suntill!0| (VECTOR |p| $ |x|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;suntill!0| (($$ NIL))
        (PROG (|x| $ |p|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 16)) (SPADCALL (QREFELT $ 42)))
                  ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|)
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL (QREFELT $ 42)) (QREFELT $ 44)))
                  ('T
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL |p| (SPADCALL |x| (QREFELT $ 15))
                                       (QREFELT $ 123))
                             (QREFELT $ 44)))))))) 

(SDEFUN |STREAM;filterUntil;M2$;70|
        ((|p| (|Mapping| (|Boolean|) S)) (|x| ($)) ($ ($)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) (SPADCALL (QREFELT $ 42)))
              ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 21))
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) |p|)
                 (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                           (SPADCALL (QREFELT $ 42)) (QREFELT $ 44)))
                (#1='T |x|)))
              (#1# (|STREAM;suntill| |p| |x| $)))) 

(SDEFUN |STREAM;ms| ((|m| (|Integer|)) (|n| (|Integer|)) (|s| ($)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM;ms!0| (VECTOR |m| |n| $ |s|))
                         (QREFELT $ 46)))) 

(SDEFUN |STREAM;ms!0| (($$ NIL))
        (PROG (|s| $ |n| |m|)
          (LETT |s| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT |m| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |s| (QREFELT $ 16)) (SPADCALL (QREFELT $ 42)))
                  ((SPADCALL |n| (QREFELT $ 124))
                   (SPADCALL (SPADCALL |s| (QREFELT $ 11))
                             (|STREAM;ms| |m|
                              (SPADCALL |m| (|spadConstant| $ 94)
                                        (QREFELT $ 95))
                              (SPADCALL |s| (QREFELT $ 15)) $)
                             (QREFELT $ 44)))
                  ('T
                   (|STREAM;ms| |m|
                    (SPADCALL |n| (|spadConstant| $ 94) (QREFELT $ 95))
                    (SPADCALL |s| (QREFELT $ 15)) $))))))) 

(SDEFUN |STREAM;eltPositiveStep|
        ((|x| ($)) (|seg| (|UniversalSegment| (|Integer|))) ($ ($)))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|STREAM;eltPositiveStep!0| (VECTOR |x| $ |seg|))
                 (QREFELT $ 46))))) 

(SDEFUN |STREAM;eltPositiveStep!0| (($$ NIL))
        (PROG (|seg| $ |x|)
          (LETT |seg| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|step| NIL) (|lo| NIL) (|hi| NIL) (#1=#:G1288 NIL)
              (#2=#:G1289 NIL) (#3=#:G1292 NIL) (|z| NIL))
             (SEQ (LETT |step| (SPADCALL |seg| (QREFELT $ 125)))
                  (LETT |lo| (SPADCALL |seg| (QREFELT $ 84)))
                  (EXIT
                   (COND
                    ((SPADCALL |seg| (QREFELT $ 85))
                     (SEQ (LETT |hi| (SPADCALL |seg| (QREFELT $ 86)))
                          (EXIT
                           (COND
                            ((SPADCALL |hi| |lo| (QREFELT $ 126))
                             (SPADCALL (QREFELT $ 42)))
                            ('T
                             (SEQ
                              (LETT |hi|
                                    (SPADCALL |lo|
                                              (SPADCALL |step|
                                                        (SPADCALL
                                                         (SPADCALL |hi| |lo|
                                                                   (QREFELT $
                                                                            95))
                                                         |step|
                                                         (QREFELT $ 127))
                                                        (QREFELT $ 128))
                                              (QREFELT $ 129)))
                              (LETT |z|
                                    (SPADCALL
                                     (SPADCALL |x|
                                               (PROG1
                                                   (LETT #1#
                                                         (SPADCALL |lo|
                                                                   (|spadConstant|
                                                                    $ 93)
                                                                   (QREFELT $
                                                                            95)))
                                                 (|check_subtype2| (>= #1# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #1#))
                                               (QREFELT $ 87))
                                     (PROG1
                                         (LETT #2#
                                               (SPADCALL
                                                (SPADCALL |hi| |lo|
                                                          (QREFELT $ 95))
                                                (|spadConstant| $ 93)
                                                (QREFELT $ 129)))
                                       (|check_subtype2| (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#))
                                     (QREFELT $ 48)))
                              (EXIT
                               (COND ((SPADCALL |step| (QREFELT $ 130)) |z|)
                                     ('T
                                      (|STREAM;ms| |step| (|spadConstant| $ 90)
                                       |z| $))))))))))
                    ('T
                     (SEQ
                      (LETT |z|
                            (SPADCALL |x|
                                      (PROG1
                                          (LETT #3#
                                                (SPADCALL |lo|
                                                          (|spadConstant| $ 93)
                                                          (QREFELT $ 95)))
                                        (|check_subtype2| (>= #3# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #3#))
                                      (QREFELT $ 87)))
                      (EXIT
                       (COND
                        ((SPADCALL |step| (QREFELT $ 130))
                         (SPADCALL |z| (QREFELT $ 43)))
                        ('T
                         (|STREAM;ms| |step| (|spadConstant| $ 90) |z|
                          $)))))))))))))) 

(SDEFUN |STREAM;errorStream| (($ ($)))
        (SPADCALL (LIST #'|STREAM;errorStream!0|) (QREFELT $ 46))) 

(SDEFUN |STREAM;errorStream!0| (($$ NIL))
        (|error| "elt: no evaluation possible")) 

(SDEFUN |STREAM;eltNegativeStep|
        ((|x| ($)) (|seg| (|UniversalSegment| (|Integer|))) ($ ($)))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|STREAM;eltNegativeStep!0| (VECTOR |x| $ |seg|))
                 (QREFELT $ 46))))) 

(SDEFUN |STREAM;eltNegativeStep!0| (($$ NIL))
        (PROG (|seg| $ |x|)
          (LETT |seg| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|step| NIL) (|hi| NIL) (|mustEventuallyFail?| NIL)
              (#1=#:G1347 NIL) (|l| NIL) (#2=#:G1350 NIL) (|z| NIL) (|lo| NIL)
              (|result| NIL))
             (SEQ
              (LETT |step|
                    (SPADCALL (SPADCALL |seg| (QREFELT $ 125))
                              (QREFELT $ 131)))
              (LETT |hi| (SPADCALL |seg| (QREFELT $ 84)))
              (LETT |lo|
                    (COND
                     ((SPADCALL |seg| (QREFELT $ 85))
                      (SPADCALL |seg| (QREFELT $ 86)))
                     ('T (|spadConstant| $ 93))))
              (EXIT
               (COND
                ((SPADCALL |lo| |hi| (QREFELT $ 132))
                 (SPADCALL (QREFELT $ 42)))
                ('T
                 (SEQ
                  (LETT |lo|
                        (SPADCALL |hi|
                                  (SPADCALL |step|
                                            (SPADCALL
                                             (SPADCALL |hi| |lo|
                                                       (QREFELT $ 95))
                                             |step| (QREFELT $ 127))
                                            (QREFELT $ 128))
                                  (QREFELT $ 95)))
                  (LETT |mustEventuallyFail?|
                        (SPADCALL |lo| (|spadConstant| $ 93) (QREFELT $ 126)))
                  (COND
                   (|mustEventuallyFail?|
                    (LETT |lo|
                          (SPADCALL |hi|
                                    (SPADCALL |step|
                                              (SPADCALL
                                               (SPADCALL |hi|
                                                         (|spadConstant| $ 93)
                                                         (QREFELT $ 95))
                                               |step| (QREFELT $ 127))
                                              (QREFELT $ 128))
                                    (QREFELT $ 95)))))
                  (LETT |z|
                        (SPADCALL |x|
                                  (PROG1
                                      (LETT #1#
                                            (SPADCALL |lo|
                                                      (|spadConstant| $ 93)
                                                      (QREFELT $ 95)))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  (QREFELT $ 87)))
                  (LETT |l| (SPADCALL (QREFELT $ 42)))
                  (SEQ G190
                       (COND
                        ((NULL (SPADCALL |lo| |hi| (QREFELT $ 126)))
                         (GO G191)))
                       (SEQ
                        (LETT |l|
                              (SPADCALL (SPADCALL |z| (QREFELT $ 28)) |l|
                                        (QREFELT $ 44)))
                        (LETT |z|
                              (SPADCALL |z|
                                        (PROG1 (LETT #2# |step|)
                                          (|check_subtype2| (>= #2# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #2#))
                                        (QREFELT $ 87)))
                        (EXIT
                         (LETT |lo| (SPADCALL |lo| |step| (QREFELT $ 129)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (LETT |result|
                        (SPADCALL (SPADCALL |z| (QREFELT $ 28)) |l|
                                  (QREFELT $ 44)))
                  (EXIT
                   (COND
                    (|mustEventuallyFail?|
                     (SPADCALL |result| (|STREAM;errorStream| $)
                               (QREFELT $ 77)))
                    ('T |result|))))))))))))) 

(SDEFUN |STREAM;elt;$Us$;75|
        ((|x| ($)) (|seg| (|UniversalSegment| (|Integer|))) ($ ($)))
        (SPROG ((|step| (|Integer|)))
               (SEQ (LETT |step| (SPADCALL |seg| (QREFELT $ 125)))
                    (EXIT
                     (COND ((ZEROP |step|) (|error| "zero step size"))
                           ((> |step| 0)
                            (|STREAM;eltPositiveStep| |x| |seg| $))
                           ('T (|STREAM;eltNegativeStep| |x| |seg| $))))))) 

(DECLAIM (NOTINLINE |Stream;|)) 

(DEFUN |Stream| (#1=#:G1369)
  (SPROG NIL
         (PROG (#2=#:G1370)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Stream|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Stream;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Stream|)))))))))) 

(DEFUN |Stream;| (|#1|)
  (SPROG
   ((#1=#:G1365 NIL) (#2=#:G1366 NIL) (#3=#:G1368 NIL) (#4=#:G1367 NIL)
    (|pv$| NIL) (#5=#:G1363 NIL) (#6=#:G1364 NIL) ($ NIL) (|dv$| NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Stream| DV$1))
    (LETT $ (GETREFV 144))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #6#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #6#)
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #5# #6#)
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))))))
    (|haddProp| |$ConstructorCache| '|Stream| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (LETT #4# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 512))
    (AND
     (LETT #3#
           (AND (|HasCategory| |#1| '(|OrderedSet|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 1024))
    (AND (OR #5# (AND (|HasCategory| |#1| '(|Comparable|)) #4#) #3#)
         (|augmentPredVector| $ 2048))
    (AND (OR (AND (|HasCategory| |#1| '(|Comparable|)) #4#) #3# #6#)
         (|augmentPredVector| $ 4096))
    (AND (OR (AND (|HasCategory| |#1| '(|Comparable|)) #4#) #3#)
         (|augmentPredVector| $ 8192))
    (AND
     (LETT #2#
           (AND (|HasCategory| |#1| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 16384))
    (AND (OR #2# (AND (|HasCategory| |#1| '(|Comparable|)) #4#) #3# #6#)
         (|augmentPredVector| $ 32768))
    (AND (LETT #1# (|HasCategory| $ '(|shallowlyMutable|)))
         (|augmentPredVector| $ 65536))
    (AND (|HasCategory| |#1| '(|OrderedSet|)) #4# #1#
         (|augmentPredVector| $ 131072))
    (AND #4# #1# (|augmentPredVector| $ 262144))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 |$NullStream|)
    (QSETREFV $ 8 |$NonNullStream|)
    (QSETREFV $ 9 |$UninitializedStream|)
    (QSETREFV $ 10 (|Record| (|:| |firstElt| |#1|) (|:| |restOfStream| $)))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 31
                 (CONS (|dispatchFunction| |STREAM;showElements;Nni$Of;10|) $))
       (QSETREFV $ 39
                 (CONS (|dispatchFunction| |STREAM;showAllElements;$Of;13|) $))
       (QSETREFV $ 40 (CONS (|dispatchFunction| |STREAM;showAll?;B;14|) $))
       (QSETREFV $ 41 (CONS (|dispatchFunction| |STREAM;coerce;$Of;15|) $)))))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 115
                (CONS (|dispatchFunction| |STREAM;repeating?;L$B;56|) $))))
    $))) 

(MAKEPROP '|Stream| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|NullStream|
              '|NonNullStream| '|UninitializedStream| '|Rep| |STREAM;frst;$S;4|
              (|Boolean|) |STREAM;explicitlyEmpty?;$B;1| |STREAM;lazy?;$B;2|
              |STREAM;rst;2$;5| |STREAM;empty?;$B;38| (|OutputForm|)
              (0 . |coerce|) (|Symbol|) (5 . |coerce|) (10 . |eq?|)
              (16 . |overbar|)
              (|Record| (|:| |cycle?| 12) (|:| |prefix| 24) (|:| |period| 24))
              (|NonNegativeInteger|) |STREAM;findCycle;Nni$R;57| (|List| $)
              (21 . |bracket|) |STREAM;first;$S;44| (26 . |rest|)
              (31 . |commaSeparate|) (36 . |showElements|) (|Integer|)
              (42 . |extend|) (|Union| $$ '"failed") (|CyclicStreamTools| 6 $$)
              (48 . |cycleElt|) (53 . |computeCycleEntry|)
              (59 . |computeCycleLength|) (64 . |showAllElements|)
              (69 . |showAll?|) (73 . |coerce|) |STREAM;empty;$;35|
              |STREAM;copy;2$;17| |STREAM;concat;S2$;40| (|Mapping| $)
              |STREAM;delay;M$;58| (78 . |distance|) |STREAM;first;$Nni$;39|
              (84 . |complete|) (89 . |tail|) (|List| 6)
              |STREAM;construct;L$;18| |STREAM;elt;$IS;19|
              |STREAM;setelt!;$I2S;21| (|Mapping| 12 6) |STREAM;remove;M2$;23|
              |STREAM;select;M2$;25| (|Stream| 6) (|Mapping| 6 6)
              (|StreamFunctions2| 6 6) (94 . |map|) |STREAM;map;M2$;26|
              (|Mapping| 6 6 6) (|StreamFunctions3| 6 6 6) (100 . |map|)
              |STREAM;map;M3$;27| |STREAM;fill!;$S$;28| (107 . |cyclic?|)
              (112 . |cycleTail|) (117 . =) (123 . |explicitlyFinite?|)
              |STREAM;map!;M2$;29| (128 . |index?|) (|Void|)
              |STREAM;swap!;$2IV;30| |STREAM;concat;$S$;31|
              |STREAM;concat;3$;66| (|List| $$) (134 . |empty?|)
              (139 . |first|) (144 . |rest|) |STREAM;concat;L$;33|
              (|UniversalSegment| 32) (149 . |low|) (154 . |hasHi|)
              (159 . |high|) (164 . |rest|) |STREAM;setelt!;$Us2S;34|
              |STREAM;lazyEvaluate;2$;37| (170 . |Zero|) (174 . |Zero|)
              (178 . =) (184 . |One|) (188 . |One|) (192 . -)
              |STREAM;cons;S2$;41| |STREAM;setrest!;3$;49|
              |STREAM;cycleSplit!;2$;42| |STREAM;concat!;3$;45|
              |STREAM;concat!;$S$;46| |STREAM;setfirst!;$2S;47| '"first"
              |STREAM;setelt!;$first2S;48| '"rest" |STREAM;setelt!;$rest2$;50|
              |STREAM;setlast!;$2S;51| '"last" |STREAM;setelt!;$last2S;52|
              |STREAM;split!;$Nni$;53| |STREAM;coerce;L$;54|
              |STREAM;repeating;L$;55| (198 . =) (204 . =) (210 . ~=)
              (216 . |repeating?|) |STREAM;explicitEntries?;$B;59|
              |STREAM;numberOfComputedEntries;$Nni;60|
              |STREAM;setrest!;$I2$;62| (|Mapping| 6) |STREAM;stream;M$;63|
              |STREAM;stream;MS$;65| |STREAM;filterWhile;M2$;68|
              |STREAM;filterUntil;M2$;70| (222 . |zero?|) (227 . |incr|)
              (232 . <) (238 . |quo|) (244 . *) (250 . +) (256 . |one?|)
              (261 . -) (266 . >) |STREAM;elt;$Us$;75| (|Mapping| 12 6 6)
              (|Equation| 6) (|List| 135) (|HashState|) (|String|)
              (|SingleInteger|) '"value" (|InputForm|) (|List| 32)
              (|Union| 6 '"failed"))
           '#(~= 272 |value| 278 |trim| 283 |third| 289 |tail| 294 |swap!| 299
              |stream| 306 |split!| 317 |sorted?| 323 |sort!| 334 |sort| 345
              |smaller?| 356 |size?| 362 |showElements| 368 |showAllElements|
              374 |showAll?| 379 |setvalue!| 383 |setrest!| 389 |setlast!| 402
              |setfirst!| 408 |setelt!| 414 |setchildren!| 456 |select| 462
              |second| 468 |sample| 473 |rst| 477 |rightTrim| 482 |reverse!|
              488 |reverse| 493 |rest| 498 |repeating?| 509 |repeating| 515
              |removeDuplicates| 520 |remove| 525 |reduce| 537 |qsetrest!| 558
              |qsetfirst!| 564 |qsetelt!| 570 |qelt| 577 |possiblyInfinite?|
              583 |position| 588 |parts| 607 |numberOfComputedEntries| 612
              |nodes| 617 |node?| 622 |new| 628 |more?| 634 |minIndex| 640
              |min| 645 |merge| 656 |members| 669 |member?| 674 |maxIndex| 680
              |max| 685 |map!| 702 |map| 708 |less?| 721 |leftTrim| 727
              |leaves| 733 |leaf?| 738 |lazyEvaluate| 743 |lazy?| 748 |latex|
              753 |last| 758 |insert| 769 |indices| 783 |index?| 788
              |hashUpdate!| 794 |hash| 800 |frst| 805 |first| 810 |findCycle|
              821 |find| 827 |filterWhile| 833 |filterUntil| 839 |fill!| 845
              |extend| 851 |explicitlyFinite?| 857 |explicitlyEmpty?| 862
              |explicitEntries?| 867 |every?| 872 |eval| 878 |eq?| 904 |entry?|
              910 |entries| 916 |empty?| 921 |empty| 926 |elt| 930 |distance|
              973 |delete| 979 |delay| 991 |cyclic?| 996 |cycleTail| 1001
              |cycleSplit!| 1006 |cycleLength| 1011 |cycleEntry| 1016 |count|
              1021 |copyInto!| 1033 |copy| 1040 |convert| 1045 |construct| 1050
              |cons| 1055 |concat!| 1061 |concat| 1078 |complete| 1101 |coerce|
              1106 |children| 1116 |child?| 1121 |any?| 1127 >= 1133 > 1139 =
              1145 <= 1151 < 1157 |#| 1163)
           'NIL
           (CONS
            (|makeByteWordVec2| 8 '(0 0 0 0 0 0 0 0 0 0 2 1 0 0 0 0 2 1 8 3))
            (CONS
             '#(|LazyStreamAggregate&| |StreamAggregate&|
                |UnaryRecursiveAggregate&| |LinearAggregate&|
                |RecursiveAggregate&| |Collection&| |IndexedAggregate&|
                |HomogeneousAggregate&| |EltableAggregate&| |Aggregate&|
                |Evalable&| |SetCategory&| NIL NIL NIL NIL |InnerEvalable&|
                |BasicType&| NIL NIL)
             (CONS
              '#((|LazyStreamAggregate| 6) (|StreamAggregate| 6)
                 (|UnaryRecursiveAggregate| 6) (|LinearAggregate| 6)
                 (|RecursiveAggregate| 6) (|Collection| 6)
                 (|IndexedAggregate| 32 6) (|HomogeneousAggregate| 6)
                 (|EltableAggregate| 32 6) (|Aggregate|) (|Evalable| 6)
                 (|SetCategory|) (|shallowlyMutable|) (|Eltable| 83 $$)
                 (|Eltable| 32 6) (|Type|) (|InnerEvalable| 6 6) (|BasicType|)
                 (|CoercibleTo| 17) (|ConvertibleTo| 141))
              (|makeByteWordVec2| 143
                                  '(1 6 17 0 18 1 19 17 0 20 2 0 12 0 0 21 1 17
                                    0 0 22 1 17 0 26 27 1 0 0 0 29 1 17 0 26 30
                                    2 0 17 24 0 31 2 0 0 0 32 33 1 35 34 2 36 2
                                    35 2 2 2 37 1 35 24 2 38 1 0 17 0 39 0 0 12
                                    40 1 0 17 0 41 2 0 32 0 0 47 1 0 0 0 49 1 0
                                    0 0 50 2 60 58 59 58 61 3 64 58 63 58 58 65
                                    1 0 12 0 68 1 0 0 0 69 2 10 12 2 2 70 1 0
                                    12 0 71 2 0 12 32 0 73 1 78 12 0 79 1 78 2
                                    0 80 1 78 0 0 81 1 83 32 0 84 1 83 12 0 85
                                    1 83 32 0 86 2 0 0 0 24 87 0 24 0 90 0 32 0
                                    91 2 24 12 0 0 92 0 24 0 93 0 32 0 94 2 32
                                    0 0 0 95 2 6 12 0 0 112 2 0 12 0 0 113 2 6
                                    12 0 0 114 2 0 12 51 0 115 1 32 12 0 124 1
                                    83 32 0 125 2 32 12 0 0 126 2 32 0 0 0 127
                                    2 32 0 0 0 128 2 32 0 0 0 129 1 32 12 0 130
                                    1 32 0 0 131 2 32 12 0 0 132 2 16 12 0 0 1
                                    1 0 6 0 1 2 15 0 0 6 1 1 0 6 0 1 1 0 0 0 50
                                    3 17 74 0 32 32 75 1 0 0 119 120 2 0 0 59 6
                                    121 2 17 0 0 24 109 1 11 12 0 1 2 10 12 134
                                    0 1 1 18 0 0 1 2 19 0 134 0 1 1 11 0 0 1 2
                                    10 0 134 0 1 2 14 12 0 0 1 2 0 12 0 24 1 2
                                    1 17 24 0 31 1 1 17 0 39 0 1 12 40 2 17 6 0
                                    6 1 2 17 0 0 0 97 3 0 0 0 32 0 118 2 17 6 0
                                    6 106 2 17 6 0 6 101 3 17 6 0 32 6 54 3 17
                                    6 0 83 6 88 3 17 6 0 107 6 108 3 17 0 0 104
                                    0 105 3 17 6 0 102 6 103 3 17 6 0 140 6 1 2
                                    17 0 0 26 1 2 0 0 55 0 57 1 0 6 0 1 0 0 0 1
                                    1 0 0 0 15 2 15 0 0 6 1 1 19 0 0 1 1 10 0 0
                                    1 2 0 0 0 24 87 1 0 0 0 29 2 1 12 51 0 115
                                    1 0 0 51 111 1 15 0 0 1 2 15 0 6 0 1 2 0 0
                                    55 0 56 4 15 6 63 0 6 6 1 3 10 6 63 0 6 1 2
                                    10 6 63 0 1 2 17 0 0 0 1 2 17 6 0 6 1 3 17
                                    6 0 32 6 1 2 0 6 0 32 1 1 0 12 0 1 3 15 32
                                    6 0 32 1 2 15 32 6 0 1 2 10 32 55 0 1 1 10
                                    51 0 1 1 0 24 0 117 1 0 26 0 1 2 4 12 0 0 1
                                    2 0 0 24 6 1 2 0 12 0 24 1 1 9 32 0 1 2 11
                                    0 0 0 1 1 11 6 0 1 2 11 0 0 0 1 3 10 0 134
                                    0 0 1 1 10 51 0 1 2 15 12 6 0 1 1 9 32 0 1
                                    2 11 0 0 0 1 1 11 6 0 1 2 10 6 134 0 1 2 17
                                    0 59 0 72 3 0 0 63 0 0 66 2 0 0 59 0 62 2 0
                                    12 0 24 1 2 15 0 0 6 1 1 0 51 0 1 1 0 12 0
                                    1 1 0 0 0 89 1 0 12 0 14 1 13 138 0 1 2 0 0
                                    0 24 1 1 0 6 0 1 3 0 0 6 0 32 1 3 0 0 0 0
                                    32 1 1 0 142 0 1 2 0 12 32 0 73 2 13 137
                                    137 0 1 1 13 139 0 1 1 0 6 0 11 2 0 0 0 24
                                    48 1 0 6 0 28 2 0 23 24 0 25 2 0 143 55 0 1
                                    2 0 0 55 0 122 2 0 0 55 0 123 2 17 0 0 6 67
                                    2 0 0 0 32 33 1 0 12 0 71 1 0 12 0 13 1 0
                                    12 0 116 2 10 12 55 0 1 3 2 0 0 6 6 1 3 2 0
                                    0 51 51 1 2 2 0 0 135 1 2 2 0 0 136 1 2 0
                                    12 0 0 21 2 15 12 6 0 1 1 0 51 0 1 1 0 12 0
                                    16 0 0 0 42 3 0 6 0 32 6 1 2 0 6 0 32 53 2
                                    0 0 0 83 133 2 0 6 0 107 1 2 0 0 0 104 1 2
                                    0 6 0 102 1 2 0 6 0 140 1 2 0 32 0 0 47 2 0
                                    0 0 83 1 2 0 0 0 32 1 1 0 0 45 46 1 0 12 0
                                    68 1 0 0 0 69 1 17 0 0 98 1 0 24 0 1 1 0 0
                                    0 1 2 15 24 6 0 1 2 10 24 55 0 1 3 19 0 0 0
                                    32 1 1 0 0 0 43 1 3 141 0 1 1 0 0 51 52 2 0
                                    0 6 0 96 1 17 0 26 1 2 17 0 0 6 100 2 17 0
                                    0 0 99 2 0 0 0 6 76 1 0 0 26 82 2 0 0 6 0
                                    44 2 0 0 0 0 77 1 0 0 0 49 1 12 17 0 41 1 0
                                    0 51 110 1 0 26 0 1 2 4 12 0 0 1 2 10 12 55
                                    0 1 2 11 12 0 0 1 2 11 12 0 0 1 2 16 12 0 0
                                    113 2 11 12 0 0 1 2 11 12 0 0 1 1 10 24 0
                                    1)))))
           '|lookupComplete|)) 
