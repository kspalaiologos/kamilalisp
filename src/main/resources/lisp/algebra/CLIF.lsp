
(SDEFUN |CLIF;characteristic;Nni;1| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 22))) 

(SDEFUN |CLIF;dimension| (($ (|CardinalNumber|)))
        (SPADCALL (QREFELT $ 19) (QREFELT $ 25))) 

(SDEFUN |CLIF;=;2$B;3| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G747 NIL) (#2=#:G748 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 19) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (QAREF1 |x| |i|) (QAREF1 |y| |i|)
                                     (QREFELT $ 26))
                           (PROGN (LETT #1# NIL) (GO #3=#:G746))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |CLIF;+;3$;4| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G753 NIL) (|i| NIL) (|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |z| |i|
                                      (SPADCALL (QAREF1 |x| |i|)
                                                (QAREF1 |y| |i|)
                                                (QREFELT $ 29)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;-;3$;5| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G758 NIL) (|i| NIL) (|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |z| |i|
                                      (SPADCALL (QAREF1 |x| |i|)
                                                (QAREF1 |y| |i|)
                                                (QREFELT $ 31)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;-;2$;6| ((|x| ($)) ($ ($)))
        (SPROG ((#1=#:G763 NIL) (|i| NIL) (|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |z| |i|
                                      (SPADCALL (QAREF1 |x| |i|)
                                                (QREFELT $ 33)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;*;I2$;7| ((|m| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG ((#1=#:G768 NIL) (|i| NIL) (|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |z| |i|
                                      (SPADCALL |m| (QAREF1 |x| |i|)
                                                (QREFELT $ 36)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;*;K2$;8| ((|c| (K)) (|x| ($)) ($ ($)))
        (SPROG ((#1=#:G773 NIL) (|i| NIL) (|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |z| |i|
                                      (SPADCALL |c| (QAREF1 |x| |i|)
                                                (QREFELT $ 38)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;Zero;$;9| (($ ($)))
        (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28))) 

(SDEFUN |CLIF;One;$;10| (($ ($)))
        (SPROG ((|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (QSETAREF1 |z| 0 (|spadConstant| $ 41)) (EXIT |z|)))) 

(SDEFUN |CLIF;coerce;I$;11| ((|m| (|Integer|)) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (QSETAREF1 |z| 0 (SPADCALL |m| (QREFELT $ 43)))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;coerce;K$;12| ((|c| (K)) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (QSETAREF1 |z| 0 |c|) (EXIT |z|)))) 

(SDEFUN |CLIF;toStringTerm| ((|c| (K)) (|b| (|SingleInteger|)) ($ (|String|)))
        (SPROG ((|mult| (|String|)) (#1=#:G790 NIL) (|i| NIL))
               (SEQ (LETT |mult| (|mathObject2String| |c|))
                    (EXIT
                     (COND ((|eql_SI| |b| 0) |mult|)
                           ((SPADCALL |c| (|spadConstant| $ 28) (QREFELT $ 46))
                            "0")
                           ('T
                            (SEQ
                             (COND
                              ((SPADCALL |c| (|spadConstant| $ 41)
                                         (QREFELT $ 46))
                               (LETT |mult| "e")))
                             (COND
                              ((SPADCALL |c|
                                         (SPADCALL (|spadConstant| $ 41)
                                                   (QREFELT $ 33))
                                         (QREFELT $ 46))
                               (LETT |mult| "-e")))
                             (COND
                              ((SPADCALL |c| (|spadConstant| $ 41)
                                         (QREFELT $ 26))
                               (COND
                                ((SPADCALL |c|
                                           (SPADCALL (|spadConstant| $ 41)
                                                     (QREFELT $ 33))
                                           (QREFELT $ 26))
                                 (LETT |mult| (STRCONC |mult| "e"))))))
                             (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1))
                                  G190
                                  (COND ((|greater_SI| |i| #1#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL |b| |i| (QREFELT $ 47))
                                      (LETT |mult|
                                            (STRCONC |mult|
                                                     (STRINGIMAGE
                                                      (+ |i| 1))))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT |mult|)))))))) 

(SDEFUN |CLIF;toString| ((|m| ($)) ($ (|String|)))
        (SPROG
         ((|res| (|String|)) (|neg| (|Boolean|)) (|s| (|String|))
          (#1=#:G803 NIL) (|im| NIL))
         (SEQ (LETT |res| "")
              (SEQ (LETT |im| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                   (COND ((|greater_SI| |im| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1 |m| |im|) (|spadConstant| $ 28)
                                 (QREFELT $ 26))
                       (SEQ (LETT |s| (|mathObject2String| (QAREF1 |m| |im|)))
                            (LETT |neg| NIL)
                            (COND
                             ((> (QCSIZE |s|) 0)
                              (LETT |neg|
                                    (|eql_SI| (SPADCALL |s| 1 (QREFELT $ 50))
                                              (|STR_to_CHAR| "-")))))
                            (COND
                             ((SPADCALL |res| "" (QREFELT $ 51))
                              (COND
                               ((NULL |neg|)
                                (LETT |res|
                                      (SPADCALL
                                       (LIST |res| "+"
                                             (|CLIF;toStringTerm|
                                              (QAREF1 |m| |im|)
                                              (SPADCALL |im| (QREFELT $ 53))
                                              $))
                                       (QREFELT $ 55)))))))
                            (EXIT
                             (COND
                              ((OR (EQUAL |res| "") |neg|)
                               (LETT |res|
                                     (STRCONC |res|
                                              (|CLIF;toStringTerm|
                                               (QAREF1 |m| |im|)
                                               (SPADCALL |im| (QREFELT $ 53))
                                               $)))))))))))
                   (LETT |im| (|inc_SI| |im|)) (GO G190) G191 (EXIT NIL))
              (COND ((EQUAL |res| "") (LETT |res| "0"))) (EXIT |res|)))) 

(SDEFUN |CLIF;e;Pi$;15| ((|b| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|z| ($)) (|iz| (|PositiveInteger|)) (#1=#:G805 NIL))
               (SEQ
                (COND ((> |b| (QREFELT $ 6)) (|error| "No such basis element"))
                      ('T
                       (SEQ
                        (LETT |iz|
                              (EXPT 2
                                    (PROG1 (LETT #1# (- |b| 1))
                                      (|check_subtype2| (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#))))
                        (LETT |z|
                              (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                        (QSETAREF1 |z| |iz| (|spadConstant| $ 41))
                        (EXIT |z|))))))) 

(SDEFUN |CLIF;ee;L$;16| ((|l| (|List| (|PositiveInteger|))) ($ ($)))
        (SPROG ((|lst| (|List| $)) (#1=#:G815 NIL) (|i| NIL) (#2=#:G814 NIL))
               (SEQ
                (LETT |lst|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (SPADCALL |i| (QREFELT $ 57)) #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))
                (EXIT
                 (SPADCALL (ELT $ 58) |lst| (|spadConstant| $ 42)
                           (QREFELT $ 61)))))) 

(SDEFUN |CLIF;multivector;L$;17| ((|scalar| (|List| K)) ($ ($)))
        (SPROG ((#1=#:G828 NIL) (|i| NIL) (|z| ($)))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |z| |i|
                                      (SPADCALL |scalar| (+ |i| 1)
                                                (QREFELT $ 65)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;eFromBinaryMap;Nni$;18| ((|b| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ
                (COND ((>= |b| (QREFELT $ 19)) (|error| "Too big"))
                      ('T
                       (SEQ
                        (LETT |z|
                              (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                        (QSETAREF1 |z| |b| (|spadConstant| $ 41))
                        (EXIT |z|))))))) 

(SDEFUN |CLIF;ePseudoscalar;$;19| (($ ($)))
        (SPROG ((|i| (|NonNegativeInteger|)) (#1=#:G831 NIL) (|p| ($)))
               (SEQ (LETT |p| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (LETT |i|
                          (PROG1 (LETT #1# (- (QREFELT $ 19) 1))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#)))
                    (QSETAREF1 |p| |i| (|spadConstant| $ 41)) (EXIT |p|)))) 

(SDEFUN |CLIF;toTable;MM;20| ((|fn| (|Mapping| $ $ $)) ($ (|Matrix| $)))
        (SPROG
         ((#1=#:G849 NIL) (|j| NIL) (#2=#:G848 NIL) (#3=#:G847 NIL) (|k| NIL)
          (#4=#:G846 NIL) (|l| (|List| $)) (#5=#:G845 NIL) (|i| NIL)
          (#6=#:G844 NIL))
         (SEQ
          (LETT |l|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |i| 0) (LETT #5# (- (QREFELT $ 19) 1)) G190
                      (COND ((|greater_SI| |i| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6# (CONS (SPADCALL |i| (QREFELT $ 67)) #6#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (EXIT
           (SPADCALL
            (PROGN
             (LETT #4# NIL)
             (SEQ (LETT |k| NIL) (LETT #3# |l|) G190
                  (COND
                   ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #4#
                          (CONS
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |j| NIL) (LETT #1# |l|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |j| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (SPADCALL |k| |j| |fn|) #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           #4#))))
                  (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT (NREVERSE #4#))))
            (QREFELT $ 71)))))) 

(SDEFUN |CLIF;toTable;MM;21| ((|fn| (|Mapping| $ $)) ($ (|Matrix| $)))
        (SPROG
         ((#1=#:G864 NIL) (|k| NIL) (#2=#:G863 NIL) (#3=#:G862 NIL) (|j| NIL)
          (#4=#:G861 NIL) (|l| (|List| $)) (#5=#:G860 NIL) (|i| NIL)
          (#6=#:G859 NIL))
         (SEQ
          (LETT |l|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |i| 0) (LETT #5# (- (QREFELT $ 19) 1)) G190
                      (COND ((|greater_SI| |i| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6# (CONS (SPADCALL |i| (QREFELT $ 67)) #6#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (EXIT
           (SPADCALL
            (LIST
             (PROGN
              (LETT #4# NIL)
              (SEQ (LETT |j| NIL) (LETT #3# |l|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |j| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT #4# (CONS |j| #4#)))) (LETT #3# (CDR #3#))
                   (GO G190) G191 (EXIT (NREVERSE #4#))))
             (PROGN
              (LETT #2# NIL)
              (SEQ (LETT |k| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT #2# (CONS (SPADCALL |k| |fn|) #2#))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))
            (QREFELT $ 71)))))) 

(SDEFUN |CLIF;gradeTerm| ((|b| (|SingleInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((|grade| (|NonNegativeInteger|)) (#1=#:G870 NIL) (|i| NIL))
               (SEQ (LETT |grade| 0)
                    (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 6) 1)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |b| |i| (QREFELT $ 47))
                             (LETT |grade| (+ |grade| 1))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |grade|)))) 

(SDEFUN |CLIF;grade;$Nni;23| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|gr| (|NonNegativeInteger|)) (#1=#:G876 NIL) (|ix| NIL))
               (SEQ (LETT |gr| 0)
                    (SEQ (LETT |ix| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |ix| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                       (QREFELT $ 26))
                             (LETT |gr|
                                   (MAX |gr|
                                        (|CLIF;gradeTerm|
                                         (SPADCALL |ix| (QREFELT $ 53))
                                         $)))))))
                         (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |gr|)))) 

(SDEFUN |CLIF;gradeInvolutionTerm|
        ((|mult| (K)) (|type1| (|SingleInteger|)) ($ ($)))
        (SPROG
         ((|resul| ($)) (|sign| (|Integer|)) (|g| (|NonNegativeInteger|)))
         (SEQ (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (QSETAREF1 |resul| |type1| |mult|)
              (LETT |g| (|CLIF;gradeTerm| |type1| $))
              (LETT |sign| (COND ((ODDP |g|) -1) ('T 1)))
              (LETT |resul| (SPADCALL |sign| |resul| (QREFELT $ 37)))
              (EXIT |resul|)))) 

(SDEFUN |CLIF;gradeInvolution;2$;25| ((|x| ($)) ($ ($)))
        (SPROG ((|z| ($)) (#1=#:G885 NIL) (|ix| NIL))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |ix| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |ix| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                       (QREFELT $ 26))
                             (LETT |z|
                                   (SPADCALL |z|
                                             (|CLIF;gradeInvolutionTerm|
                                              (QAREF1 |x| |ix|)
                                              (SPADCALL |ix| (QREFELT $ 53)) $)
                                             (QREFELT $ 30)))))))
                         (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;reverseTerm| ((|mult| (K)) (|type1| (|SingleInteger|)) ($ ($)))
        (SPROG ((|resul| ($)) (|sign| (|Integer|)) (|g| (|SingleInteger|)))
               (SEQ
                (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (QSETAREF1 |resul| |type1| |mult|)
                (LETT |g|
                      (SPADCALL (|CLIF;gradeTerm| |type1| $) (QREFELT $ 53)))
                (LETT |sign|
                      (COND ((|odd?_SI| (|lshift_SI| |g| -1)) -1) ('T 1)))
                (LETT |resul| (SPADCALL |sign| |resul| (QREFELT $ 37)))
                (EXIT |resul|)))) 

(SDEFUN |CLIF;reverse;2$;27| ((|x| ($)) ($ ($)))
        (SPROG ((|z| ($)) (#1=#:G894 NIL) (|ix| NIL))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |ix| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |ix| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                       (QREFELT $ 26))
                             (LETT |z|
                                   (SPADCALL |z|
                                             (|CLIF;reverseTerm|
                                              (QAREF1 |x| |ix|)
                                              (SPADCALL |ix| (QREFELT $ 53)) $)
                                             (QREFELT $ 30)))))))
                         (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;conjTerm| ((|mult| (K)) (|type1| (|SingleInteger|)) ($ ($)))
        (SPROG ((|resul| ($)) (|sign| (|Integer|)) (|g| (|SingleInteger|)))
               (SEQ
                (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (QSETAREF1 |resul| |type1| |mult|)
                (LETT |g|
                      (SPADCALL (|CLIF;gradeTerm| |type1| $) (QREFELT $ 53)))
                (LETT |sign|
                      (COND ((|odd?_SI| (|lshift_SI| (|add_SI| |g| 1) -1)) -1)
                            ('T 1)))
                (LETT |resul| (SPADCALL |sign| |resul| (QREFELT $ 37)))
                (EXIT |resul|)))) 

(SDEFUN |CLIF;conj;2$;29| ((|x| ($)) ($ ($)))
        (SPROG ((|z| ($)) (#1=#:G903 NIL) (|ix| NIL))
               (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                    (SEQ (LETT |ix| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                         (COND ((|greater_SI| |ix| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                       (QREFELT $ 26))
                             (LETT |z|
                                   (SPADCALL |z|
                                             (|CLIF;conjTerm| (QAREF1 |x| |ix|)
                                              (SPADCALL |ix| (QREFELT $ 53)) $)
                                             (QREFELT $ 30)))))))
                         (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |CLIF;setMode;S2B;30|
        ((|s| (|String|)) (|val| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G908 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQUAL |s| "orthogonal")
                    (SEQ (SETELT $ 17 |val|)
                         (EXIT (PROGN (LETT #1# 'T) (GO #2=#:G907))))))
                  (COND
                   ((EQUAL |s| "debug")
                    (SEQ (SETELT $ 18 |val|)
                         (EXIT (PROGN (LETT #1# 'T) (GO #2#))))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |CLIF;baseVect| ((|b| (|SingleInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G914 NIL) (#2=#:G915 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 6) 1)) G190
                       (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |b| |i| (QREFELT $ 47))
                           (PROGN (LETT #1# (+ |i| 1)) (GO #3=#:G913))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 0)))
                #3# (EXIT #1#)))) 

(SDEFUN |CLIF;bilinear|
        ((|b1| (|SingleInteger|)) (|b2| (|SingleInteger|)) ($ (K)))
        (SPROG ((#1=#:G920 NIL) (|bv2| #2=(|NonNegativeInteger|)) (|bv1| #2#))
               (SEQ
                (EXIT
                 (SEQ (LETT |bv1| (|CLIF;baseVect| |b1| $))
                      (LETT |bv2| (|CLIF;baseVect| |b2| $))
                      (COND
                       ((EQL |bv1| 0)
                        (PROGN
                         (LETT #1# (|spadConstant| $ 28))
                         (GO #3=#:G919))))
                      (COND
                       ((EQL |bv2| 0)
                        (PROGN (LETT #1# (|spadConstant| $ 28)) (GO #3#))))
                      (EXIT
                       (SPADCALL (QREFELT $ 8) |bv1| |bv2| (QREFELT $ 82)))))
                #3# (EXIT #1#)))) 

(SDEFUN |CLIF;leftMostBase| ((|b| (|SingleInteger|)) ($ (|SingleInteger|)))
        (SPROG
         ((|mask| (|SingleInteger|)) (#1=#:G927 NIL) (#2=#:G928 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |mask| 1)
                (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 6) 1)) G190
                     (COND ((|greater_SI| |i| #2#) (GO G191)))
                     (SEQ
                      (COND
                       ((SPADCALL (|and_SI| |mask| |b|) 0 (QREFELT $ 83))
                        (PROGN (LETT #1# |mask|) (GO #3=#:G926))))
                      (EXIT (LETT |mask| (|lshift_SI| |mask| 1))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT 0)))
          #3# (EXIT #1#)))) 

(SDEFUN |CLIF;rightMostBase| ((|b| (|SingleInteger|)) ($ (|SingleInteger|)))
        (SPROG
         ((|mask| (|SingleInteger|)) (#1=#:G935 NIL) (#2=#:G936 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |mask|
                  (|lshift_SI| 1
                               (SPADCALL (- (QREFELT $ 6) 1) (QREFELT $ 53))))
            (SEQ (LETT |i| 0) (LETT #2# (- (QREFELT $ 6) 1)) G190
                 (COND ((|greater_SI| |i| #2#) (GO G191)))
                 (SEQ
                  (COND
                   ((SPADCALL (|and_SI| |mask| |b|) 0 (QREFELT $ 83))
                    (PROGN (LETT #1# |mask|) (GO #3=#:G934))))
                  (EXIT (LETT |mask| (|lshift_SI| |mask| -1))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (EXIT 0)))
          #3# (EXIT #1#)))) 

(SDEFUN |CLIF;exteriorProdTerm|
        ((|op1mult| (K)) (|op1type| (|SingleInteger|)) (|op2mult| (K))
         (|op2type| (|SingleInteger|)) ($ ($)))
        (SPROG
         ((|c| (K)) (|k| (|NonNegativeInteger|)) (#1=#:G949 NIL) (|j| NIL)
          (#2=#:G948 NIL) (#3=#:G947 NIL) (|i| NIL) (|bz| (|SingleInteger|))
          (|resul| ($)))
         (SEQ (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (EXIT
               (COND
                ((SPADCALL (|and_SI| |op1type| |op2type|) 0 (QREFELT $ 83))
                 |resul|)
                ('T
                 (SEQ (LETT |c| (SPADCALL |op1mult| |op2mult| (QREFELT $ 38)))
                      (LETT |bz| (|or_SI| |op1type| |op2type|))
                      (SEQ (LETT |i| 0) (LETT #3# (- (QREFELT $ 6) 1)) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |op1type| |i| (QREFELT $ 47))
                               (SEQ (LETT |k| 0)
                                    (SEQ (LETT |j| (+ |i| 1))
                                         (LETT #2# (- (QREFELT $ 6) 1)) G190
                                         (COND ((> |j| #2#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((SPADCALL |op1type| |j|
                                                       (QREFELT $ 47))
                                             (LETT |k| (+ |k| 1))))))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (SEQ (LETT |j| 0) (LETT #1# (- |i| 1)) G190
                                         (COND
                                          ((|greater_SI| |j| #1#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((SPADCALL |bz| |j| (QREFELT $ 47))
                                             (LETT |k| (+ |k| 1))))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))
                                    (EXIT
                                     (COND
                                      ((ODDP |k|)
                                       (LETT |c|
                                             (SPADCALL |c|
                                                       (QREFELT $ 33)))))))))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (QSETAREF1 |resul| |bz|
                                 (SPADCALL (QAREF1 |resul| |bz|) |c|
                                           (QREFELT $ 29)))
                      (EXIT |resul|)))))))) 

(SDEFUN |CLIF;regressiveProdTerm|
        ((|op1mult| (K)) (|op1type| (|SingleInteger|)) (|op2mult| (K))
         (|op2type| (|SingleInteger|)) ($ ($)))
        (SPROG ((|res| ($)) (|op2| ($)) (|op1| ($)))
               (SEQ
                (LETT |op1| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (QSETAREF1 |op1| |op1type| (|spadConstant| $ 41))
                (LETT |op2| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (QSETAREF1 |op2| |op2type| (|spadConstant| $ 41))
                (LETT |res|
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL |op2| (SPADCALL (QREFELT $ 68))
                                  (QREFELT $ 84))
                        (SPADCALL |op1| (SPADCALL (QREFELT $ 68))
                                  (QREFELT $ 84))
                        (QREFELT $ 58))
                       (SPADCALL (QREFELT $ 68)) (QREFELT $ 84)))
                (LETT |res|
                      (SPADCALL (SPADCALL |op1mult| |op2mult| (QREFELT $ 38))
                                |res| (QREFELT $ 39)))
                (EXIT |res|)))) 

(SDEFUN |CLIF;/\\;3$;37| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|z| ($)) (#1=#:G961 NIL) (|iy| NIL) (#2=#:G960 NIL) (|ix| NIL))
         (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (SEQ (LETT |ix| 0) (LETT #2# (- (QREFELT $ 19) 1)) G190
                   (COND ((|greater_SI| |ix| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                 (QREFELT $ 26))
                       (SEQ (LETT |iy| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                            (COND ((|greater_SI| |iy| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL (QAREF1 |y| |iy|)
                                          (|spadConstant| $ 28) (QREFELT $ 26))
                                (LETT |z|
                                      (SPADCALL |z|
                                                (|CLIF;exteriorProdTerm|
                                                 (QAREF1 |x| |ix|)
                                                 (SPADCALL |ix| (QREFELT $ 53))
                                                 (QAREF1 |y| |iy|)
                                                 (SPADCALL |iy| (QREFELT $ 53))
                                                 $)
                                                (QREFELT $ 30)))))))
                            (LETT |iy| (|inc_SI| |iy|)) (GO G190) G191
                            (EXIT NIL))))))
                   (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
              (EXIT |z|)))) 

(SDEFUN |CLIF;\\/;3$;38| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|z| ($)) (#1=#:G971 NIL) (|iy| NIL) (#2=#:G970 NIL) (|ix| NIL))
         (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (SEQ (LETT |ix| 0) (LETT #2# (- (QREFELT $ 19) 1)) G190
                   (COND ((|greater_SI| |ix| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                 (QREFELT $ 26))
                       (SEQ (LETT |iy| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                            (COND ((|greater_SI| |iy| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL (QAREF1 |y| |iy|)
                                          (|spadConstant| $ 28) (QREFELT $ 26))
                                (LETT |z|
                                      (SPADCALL |z|
                                                (|CLIF;regressiveProdTerm|
                                                 (QAREF1 |x| |ix|)
                                                 (SPADCALL |ix| (QREFELT $ 53))
                                                 (QAREF1 |y| |iy|)
                                                 (SPADCALL |iy| (QREFELT $ 53))
                                                 $)
                                                (QREFELT $ 30)))))))
                            (LETT |iy| (|inc_SI| |iy|)) (GO G190) G191
                            (EXIT NIL))))))
                   (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
              (EXIT |z|)))) 

(SDEFUN |CLIF;lcProdTerm|
        ((|op1mult| (K)) (|op1type| (|SingleInteger|)) (|op2mult| (K))
         (|op2type| (|SingleInteger|)) ($ ($)))
        (SPROG
         ((|resul| ($)) (|inner2| ($)) (|vType| (|SingleInteger|))
          (|uType| (|SingleInteger|)) (#1=#:G978 NIL) (|inner4| ($))
          (|left| ($)) (|grade2| #2=(|NonNegativeInteger|)) (|grade1| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (LETT |grade1| (|CLIF;gradeTerm| |op1type| $))
                (LETT |grade2| (|CLIF;gradeTerm| |op2type| $))
                (COND
                 ((EQL |grade1| 0)
                  (SEQ
                   (QSETAREF1 |resul| |op2type|
                              (SPADCALL (QAREF1 |resul| |op2type|)
                                        (SPADCALL |op1mult| |op2mult|
                                                  (QREFELT $ 38))
                                        (QREFELT $ 29)))
                   (EXIT (PROGN (LETT #1# |resul|) (GO #3=#:G977))))))
                (EXIT
                 (COND ((EQL |grade2| 0) |resul|)
                       ('T
                        (SEQ
                         (COND
                          ((EQL |grade1| 1)
                           (COND
                            ((EQL |grade2| 1)
                             (SEQ
                              (QSETAREF1 |resul| 0
                                         (SPADCALL (QAREF1 |resul| 0)
                                                   (SPADCALL
                                                    (SPADCALL |op1mult|
                                                              |op2mult|
                                                              (QREFELT $ 38))
                                                    (|CLIF;bilinear| |op1type|
                                                     |op2type| $)
                                                    (QREFELT $ 38))
                                                   (QREFELT $ 29)))
                              (EXIT (PROGN (LETT #1# |resul|) (GO #3#))))))))
                         (COND
                          ((EQL |grade1| 1)
                           (SEQ
                            (LETT |uType| (|CLIF;leftMostBase| |op2type| $))
                            (LETT |vType| (|xor_SI| |op2type| |uType|))
                            (LETT |inner2|
                                  (MAKEARR1 (QREFELT $ 19)
                                            (|spadConstant| $ 28)))
                            (QSETAREF1 |inner2| |vType| (|spadConstant| $ 41))
                            (LETT |left|
                                  (SPADCALL
                                   (|CLIF;lcProdTerm| |op1mult| |op1type|
                                    |op2mult| |uType| $)
                                   |inner2| (QREFELT $ 58)))
                            (LETT |inner4|
                                  (MAKEARR1 (QREFELT $ 19)
                                            (|spadConstant| $ 28)))
                            (QSETAREF1 |inner4| |uType| (|spadConstant| $ 41))
                            (LETT |resul|
                                  (SPADCALL
                                   (SPADCALL |resul| |left| (QREFELT $ 30))
                                   (SPADCALL |inner4|
                                             (|CLIF;lcProdTerm|
                                              (SPADCALL |op1mult|
                                                        (QREFELT $ 33))
                                              |op1type| |op2mult| |vType| $)
                                             (QREFELT $ 58))
                                   (QREFELT $ 30)))
                            (EXIT (PROGN (LETT #1# |resul|) (GO #3#))))))
                         (LETT |uType| (|CLIF;leftMostBase| |op1type| $))
                         (LETT |vType| (|xor_SI| |op1type| |uType|))
                         (LETT |inner2|
                               (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                         (QSETAREF1 |inner2| |uType| (|spadConstant| $ 41))
                         (LETT |resul|
                               (SPADCALL |resul|
                                         (SPADCALL |inner2|
                                                   (|CLIF;lcProdTerm| |op1mult|
                                                    |vType| |op2mult| |op2type|
                                                    $)
                                                   (QREFELT $ 86))
                                         (QREFELT $ 30)))
                         (EXIT |resul|)))))))
          #3# (EXIT #1#)))) 

(SDEFUN |CLIF;rcProdTerm|
        ((|op1mult| (K)) (|op1type| (|SingleInteger|)) (|op2mult| (K))
         (|op2type| (|SingleInteger|)) ($ ($)))
        (SPROG
         ((|s4| (|String|)) (|s3| #1=(|String|)) (|s2| #1#) (|s1| #1#)
          (|resul| ($)) (|inner2| ($)) (|vType| (|SingleInteger|))
          (|uType| (|SingleInteger|)) (#2=#:G987 NIL) (|inner4| ($))
          (|right| ($)) (|grade2| #3=(|NonNegativeInteger|)) (|grade1| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (LETT |grade1| (|CLIF;gradeTerm| |op1type| $))
                (LETT |grade2| (|CLIF;gradeTerm| |op2type| $))
                (COND
                 ((EQL |grade2| 0)
                  (SEQ
                   (QSETAREF1 |resul| |op1type|
                              (SPADCALL (QAREF1 |resul| |op1type|)
                                        (SPADCALL |op1mult| |op2mult|
                                                  (QREFELT $ 38))
                                        (QREFELT $ 29)))
                   (EXIT (PROGN (LETT #2# |resul|) (GO #4=#:G986))))))
                (EXIT
                 (COND ((EQL |grade1| 0) |resul|)
                       ('T
                        (SEQ
                         (COND
                          ((EQL |grade1| 1)
                           (COND
                            ((EQL |grade2| 1)
                             (SEQ
                              (QSETAREF1 |resul| 0
                                         (SPADCALL (QAREF1 |resul| 0)
                                                   (SPADCALL
                                                    (SPADCALL |op1mult|
                                                              |op2mult|
                                                              (QREFELT $ 38))
                                                    (|CLIF;bilinear| |op1type|
                                                     |op2type| $)
                                                    (QREFELT $ 38))
                                                   (QREFELT $ 29)))
                              (EXIT (PROGN (LETT #2# |resul|) (GO #4#))))))))
                         (COND
                          ((EQL |grade2| 1)
                           (SEQ
                            (LETT |uType| (|CLIF;rightMostBase| |op1type| $))
                            (LETT |vType| (|xor_SI| |op1type| |uType|))
                            (LETT |inner2|
                                  (MAKEARR1 (QREFELT $ 19)
                                            (|spadConstant| $ 28)))
                            (QSETAREF1 |inner2| |vType| (|spadConstant| $ 41))
                            (LETT |right|
                                  (SPADCALL |inner2|
                                            (|CLIF;rcProdTerm| |op1mult|
                                             |uType| |op2mult| |op2type| $)
                                            (QREFELT $ 58)))
                            (LETT |inner4|
                                  (MAKEARR1 (QREFELT $ 19)
                                            (|spadConstant| $ 28)))
                            (QSETAREF1 |inner4| |uType| (|spadConstant| $ 41))
                            (LETT |resul|
                                  (SPADCALL
                                   (SPADCALL |resul|
                                             (SPADCALL
                                              (|CLIF;rcProdTerm| |op1mult|
                                               |vType|
                                               (SPADCALL |op2mult|
                                                         (QREFELT $ 33))
                                               |op2type| $)
                                              |inner4| (QREFELT $ 58))
                                             (QREFELT $ 30))
                                   |right| (QREFELT $ 30)))
                            (COND
                             ((QREFELT $ 18)
                              (SEQ
                               (LETT |s1|
                                     (SPADCALL
                                      (LIST
                                       (|CLIF;toStringTerm| |op1mult| |op1type|
                                        $)
                                       "L"
                                       (|CLIF;toStringTerm| |op2mult| |op2type|
                                        $))
                                      (QREFELT $ 55)))
                               (LETT |s2|
                                     (SPADCALL
                                      (LIST "= "
                                            (|CLIF;toStringTerm| |op1mult|
                                             |vType| $)
                                            "L"
                                            (|CLIF;toStringTerm|
                                             (SPADCALL |op2mult|
                                                       (QREFELT $ 33))
                                             |op2type| $))
                                      (QREFELT $ 55)))
                               (LETT |s3|
                                     (SPADCALL
                                      (LIST "/\\" (|CLIF;toString| |inner4| $)
                                            "+" (|CLIF;toString| |right| $))
                                      (QREFELT $ 55)))
                               (LETT |s4|
                                     (STRCONC "=" (|CLIF;toString| |resul| $)))
                               (EXIT
                                (SPADCALL
                                 (LIST "rcProdTerm: " |s1| |s2| |s3| |s4|)
                                 (QREFELT $ 90))))))
                            (EXIT (PROGN (LETT #2# |resul|) (GO #4#))))))
                         (LETT |uType| (|CLIF;rightMostBase| |op2type| $))
                         (LETT |vType| (|xor_SI| |op2type| |uType|))
                         (LETT |inner2|
                               (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                         (QSETAREF1 |inner2| |uType| (|spadConstant| $ 41))
                         (LETT |resul|
                               (SPADCALL |resul|
                                         (SPADCALL
                                          (|CLIF;rcProdTerm| |op1mult|
                                           |op1type| |op2mult| |vType| $)
                                          |inner2| (QREFELT $ 91))
                                         (QREFELT $ 30)))
                         (COND
                          ((QREFELT $ 18)
                           (SEQ
                            (LETT |s1|
                                  (SPADCALL
                                   (LIST
                                    (|CLIF;toStringTerm| |op1mult| |op1type| $)
                                    "L"
                                    (|CLIF;toStringTerm| |op2mult| |op2type|
                                     $))
                                   (QREFELT $ 55)))
                            (LETT |s2|
                                  (SPADCALL
                                   (LIST "= ("
                                         (|CLIF;toStringTerm| |op1mult|
                                          |op1type| $)
                                         "L"
                                         (|CLIF;toStringTerm| |op2mult| |vType|
                                          $))
                                   (QREFELT $ 55)))
                            (LETT |s3|
                                  (STRCONC ") L" (|CLIF;toString| |inner2| $)))
                            (LETT |s4|
                                  (STRCONC "=" (|CLIF;toString| |resul| $)))
                            (EXIT
                             (SPADCALL
                              (LIST "rcProdTerm: " |s1| |s2| |s3| |s4|)
                              (QREFELT $ 90))))))
                         (EXIT |resul|)))))))
          #4# (EXIT #2#)))) 

(SDEFUN |CLIF;lc;3$;41| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|z| ($)) (#1=#:G997 NIL) (|iy| NIL) (#2=#:G996 NIL) (|ix| NIL))
         (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (SEQ (LETT |ix| 0) (LETT #2# (- (QREFELT $ 19) 1)) G190
                   (COND ((|greater_SI| |ix| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                 (QREFELT $ 26))
                       (SEQ (LETT |iy| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                            (COND ((|greater_SI| |iy| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL (QAREF1 |y| |iy|)
                                          (|spadConstant| $ 28) (QREFELT $ 26))
                                (LETT |z|
                                      (SPADCALL |z|
                                                (|CLIF;lcProdTerm|
                                                 (QAREF1 |x| |ix|)
                                                 (SPADCALL |ix| (QREFELT $ 53))
                                                 (QAREF1 |y| |iy|)
                                                 (SPADCALL |iy| (QREFELT $ 53))
                                                 $)
                                                (QREFELT $ 30)))))))
                            (LETT |iy| (|inc_SI| |iy|)) (GO G190) G191
                            (EXIT NIL))))))
                   (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
              (EXIT |z|)))) 

(SDEFUN |CLIF;rc;3$;42| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|z| ($)) (#1=#:G1007 NIL) (|iy| NIL) (#2=#:G1006 NIL) (|ix| NIL))
         (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (SEQ (LETT |ix| 0) (LETT #2# (- (QREFELT $ 19) 1)) G190
                   (COND ((|greater_SI| |ix| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                 (QREFELT $ 26))
                       (SEQ (LETT |iy| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                            (COND ((|greater_SI| |iy| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL (QAREF1 |y| |iy|)
                                          (|spadConstant| $ 28) (QREFELT $ 26))
                                (LETT |z|
                                      (SPADCALL |z|
                                                (|CLIF;rcProdTerm|
                                                 (QAREF1 |x| |ix|)
                                                 (SPADCALL |ix| (QREFELT $ 53))
                                                 (QAREF1 |y| |iy|)
                                                 (SPADCALL |iy| (QREFELT $ 53))
                                                 $)
                                                (QREFELT $ 30)))))))
                            (LETT |iy| (|inc_SI| |iy|)) (GO G190) G191
                            (EXIT NIL))))))
                   (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))
              (EXIT |z|)))) 

(SDEFUN |CLIF;cliffordProdTerm|
        ((|op1mult| (K)) (|op1type| (|SingleInteger|)) (|op2mult| (K))
         (|op2type| (|SingleInteger|)) ($ ($)))
        (SPROG
         ((|resul| ($)) (|s4| #1=(|String|)) (|s3| #1#) (|s2| #1#) (|s1| #1#)
          (|factor2| ($)) (|factor1| ($)) (|vt| ($)) (|ut| ($))
          (|uType| (|SingleInteger|)) (|xType| (|SingleInteger|))
          (#2=#:G1016 NIL) (|xt| ($)) (|vType| (|SingleInteger|))
          (|grade2| #3=(|NonNegativeInteger|)) (|grade1| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |resul| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (LETT |grade1| (|CLIF;gradeTerm| |op1type| $))
                (LETT |grade2| (|CLIF;gradeTerm| |op2type| $))
                (COND
                 ((EQL |grade1| 0)
                  (SEQ
                   (QSETAREF1 |resul| |op2type|
                              (SPADCALL (QAREF1 |resul| |op2type|)
                                        (SPADCALL |op1mult| |op2mult|
                                                  (QREFELT $ 38))
                                        (QREFELT $ 29)))
                   (EXIT (PROGN (LETT #2# |resul|) (GO #4=#:G1015))))))
                (COND
                 ((EQL |grade2| 0)
                  (SEQ
                   (QSETAREF1 |resul| |op1type|
                              (SPADCALL (QAREF1 |resul| |op1type|)
                                        (SPADCALL |op1mult| |op2mult|
                                                  (QREFELT $ 38))
                                        (QREFELT $ 29)))
                   (EXIT (PROGN (LETT #2# |resul|) (GO #4#))))))
                (COND
                 ((EQL |grade1| 1)
                  (COND
                   ((EQL |grade2| 1)
                    (SEQ
                     (QSETAREF1 |resul| 0
                                (SPADCALL (QAREF1 |resul| 0)
                                          (SPADCALL
                                           (SPADCALL |op1mult| |op2mult|
                                                     (QREFELT $ 38))
                                           (|CLIF;bilinear| |op1type| |op2type|
                                            $)
                                           (QREFELT $ 38))
                                          (QREFELT $ 29)))
                     (LETT |resul|
                           (SPADCALL |resul|
                                     (|CLIF;exteriorProdTerm| |op1mult|
                                      |op1type| |op2mult| |op2type| $)
                                     (QREFELT $ 30)))
                     (EXIT (PROGN (LETT #2# |resul|) (GO #4#))))))))
                (COND
                 ((EQL |grade1| 1)
                  (SEQ (LETT |uType| (|CLIF;leftMostBase| |op2type| $))
                       (LETT |vType| (|xor_SI| |op2type| |uType|))
                       (LETT |xt|
                             (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                       (QSETAREF1 |xt| |op1type| (|spadConstant| $ 41))
                       (LETT |ut|
                             (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                       (QSETAREF1 |ut| |uType| (|spadConstant| $ 41))
                       (LETT |vt|
                             (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                       (QSETAREF1 |vt| |vType| (|spadConstant| $ 41))
                       (LETT |resul|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL |xt|
                                         (|CLIF;exteriorProdTerm|
                                          (|spadConstant| $ 41) |uType|
                                          (|spadConstant| $ 41) |vType| $)
                                         (QREFELT $ 58))
                               (SPADCALL
                                (|CLIF;lcProdTerm| (|spadConstant| $ 41)
                                 |op1type| (|spadConstant| $ 41) |uType| $)
                                |vt| (QREFELT $ 58))
                               (QREFELT $ 30))
                              (SPADCALL
                               (|CLIF;gradeInvolutionTerm|
                                (|spadConstant| $ 41) |uType| $)
                               (|CLIF;lcProdTerm| (|spadConstant| $ 41)
                                |op1type| (|spadConstant| $ 41) |vType| $)
                               (QREFELT $ 58))
                              (QREFELT $ 30)))
                       (LETT |resul|
                             (SPADCALL
                              (SPADCALL |op1mult| |op2mult| (QREFELT $ 38))
                              |resul| (QREFELT $ 39)))
                       (EXIT (PROGN (LETT #2# |resul|) (GO #4#))))))
                (COND
                 ((EQL |grade2| 1)
                  (SEQ (LETT |uType| (|CLIF;rightMostBase| |op1type| $))
                       (LETT |vType| (|xor_SI| |op1type| |uType|))
                       (LETT |xt|
                             (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                       (QSETAREF1 |xt| |op2type| (|spadConstant| $ 41))
                       (LETT |ut|
                             (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                       (QSETAREF1 |ut| |uType| (|spadConstant| $ 41))
                       (LETT |vt|
                             (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                       (QSETAREF1 |vt| |vType| (|spadConstant| $ 41))
                       (LETT |resul|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (|CLIF;exteriorProdTerm| (|spadConstant| $ 41)
                                 |vType| (|spadConstant| $ 41) |uType| $)
                                |xt| (QREFELT $ 58))
                               (SPADCALL |vt|
                                         (|CLIF;rcProdTerm|
                                          (|spadConstant| $ 41) |uType|
                                          (|spadConstant| $ 41) |op2type| $)
                                         (QREFELT $ 58))
                               (QREFELT $ 30))
                              (SPADCALL
                               (|CLIF;rcProdTerm| (|spadConstant| $ 41) |vType|
                                (|spadConstant| $ 41) |op2type| $)
                               (|CLIF;gradeInvolutionTerm|
                                (|spadConstant| $ 41) |uType| $)
                               (QREFELT $ 58))
                              (QREFELT $ 30)))
                       (LETT |resul|
                             (SPADCALL
                              (SPADCALL |op1mult| |op2mult| (QREFELT $ 38))
                              |resul| (QREFELT $ 39)))
                       (EXIT (PROGN (LETT #2# |resul|) (GO #4#))))))
                (LETT |xType| (|CLIF;rightMostBase| |op1type| $))
                (LETT |uType| (|xor_SI| |op1type| |xType|))
                (LETT |ut| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (QSETAREF1 |ut| |uType| (|spadConstant| $ 41))
                (LETT |vt| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
                (QSETAREF1 |vt| |op2type| (|spadConstant| $ 41))
                (LETT |factor1|
                      (SPADCALL
                       (|CLIF;lcProdTerm| (|spadConstant| $ 41) |xType|
                        (|spadConstant| $ 41) |op2type| $)
                       (|CLIF;exteriorProdTerm| (|spadConstant| $ 41) |xType|
                        (|spadConstant| $ 41) |op2type| $)
                       (QREFELT $ 30)))
                (LETT |factor2|
                      (|CLIF;rcProdTerm| (|spadConstant| $ 41) |uType|
                       (|spadConstant| $ 41) |xType| $))
                (LETT |resul|
                      (SPADCALL (SPADCALL |ut| |factor1| (QREFELT $ 84))
                                (SPADCALL |factor2| |vt| (QREFELT $ 84))
                                (QREFELT $ 32)))
                (COND
                 ((QREFELT $ 18)
                  (SEQ
                   (LETT |s1|
                         (SPADCALL
                          (LIST (|CLIF;toStringTerm| |op1mult| |op1type| $) "*"
                                (|CLIF;toStringTerm| |op2mult| |op2type| $))
                          (QREFELT $ 55)))
                   (LETT |s2|
                         (SPADCALL
                          (LIST "=" (|CLIF;toString| |ut| $) "*"
                                (|CLIF;toString| |factor1| $))
                          (QREFELT $ 55)))
                   (LETT |s3|
                         (SPADCALL
                          (LIST "-" (|CLIF;toString| |factor2| $) "*"
                                (|CLIF;toString| |vt| $))
                          (QREFELT $ 55)))
                   (LETT |s4|
                         (SPADCALL (LIST "=" (|CLIF;toString| |resul| $))
                                   (QREFELT $ 55)))
                   (EXIT
                    (SPADCALL (LIST "cliffordProdTerm: " |s1| |s2| |s3| |s4|)
                              (QREFELT $ 90))))))
                (LETT |resul|
                      (SPADCALL (SPADCALL |op1mult| |op2mult| (QREFELT $ 38))
                                |resul| (QREFELT $ 39)))
                (EXIT |resul|)))
          #4# (EXIT #2#)))) 

(SDEFUN |CLIF;cliffordDiagonalTerm|
        ((|op1mult| (K)) (|op1type| (|SingleInteger|)) (|op2mult| (K))
         (|op2type| #1=(|SingleInteger|)) ($ ($)))
        (SPROG
         ((|result| ($)) (|bz| #1#) (|c| (K)) (|k| (|NonNegativeInteger|))
          (#2=#:G1030 NIL) (|j| NIL) (#3=#:G1029 NIL) (#4=#:G1028 NIL)
          (|i| NIL))
         (SEQ (LETT |c| (SPADCALL |op1mult| |op2mult| (QREFELT $ 38)))
              (LETT |bz| |op2type|)
              (SEQ (LETT |i| 0) (LETT #4# (- (QREFELT $ 6) 1)) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |op1type| |i| (QREFELT $ 47))
                       (SEQ (LETT |k| 0)
                            (SEQ (LETT |j| (+ |i| 1))
                                 (LETT #3# (- (QREFELT $ 6) 1)) G190
                                 (COND ((> |j| #3#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL |op1type| |j| (QREFELT $ 47))
                                     (LETT |k| (+ |k| 1))))))
                                 (LETT |j| (+ |j| 1)) (GO G190) G191
                                 (EXIT NIL))
                            (SEQ (LETT |j| 0) (LETT #2# (- |i| 1)) G190
                                 (COND ((|greater_SI| |j| #2#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL |bz| |j| (QREFELT $ 47))
                                     (LETT |k| (+ |k| 1))))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))
                            (COND
                             ((ODDP |k|)
                              (LETT |c| (SPADCALL |c| (QREFELT $ 33)))))
                            (EXIT
                             (COND
                              ((SPADCALL |bz| |i| (QREFELT $ 47))
                               (SEQ
                                (LETT |c|
                                      (SPADCALL |c|
                                                (SPADCALL (QREFELT $ 14)
                                                          (+ |i| 1)
                                                          (QREFELT $ 92))
                                                (QREFELT $ 38)))
                                (EXIT
                                 (LETT |bz|
                                       (|sub_SI| |bz|
                                                 (SPADCALL 2 |i|
                                                           (QREFELT $ 93)))))))
                              ('T
                               (LETT |bz|
                                     (|add_SI| |bz|
                                               (SPADCALL 2 |i|
                                                         (QREFELT $
                                                                  93))))))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |result| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (QSETAREF1 |result| |bz| |c|) (EXIT |result|)))) 

(SDEFUN |CLIF;*;3$;45| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|z| ($)) (#1=#:G1048 NIL) (|iy| NIL) (#2=#:G1047 NIL) (|ix| NIL)
          (#3=#:G1046 NIL) (#4=#:G1045 NIL))
         (SEQ (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (COND
               ((QREFELT $ 17)
                (SEQ (LETT |ix| 0) (LETT #4# (- (QREFELT $ 19) 1)) G190
                     (COND ((|greater_SI| |ix| #4#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                   (QREFELT $ 26))
                         (SEQ (LETT |iy| 0) (LETT #3# (- (QREFELT $ 19) 1))
                              G190 (COND ((|greater_SI| |iy| #3#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (QAREF1 |y| |iy|)
                                            (|spadConstant| $ 28)
                                            (QREFELT $ 26))
                                  (LETT |z|
                                        (SPADCALL |z|
                                                  (|CLIF;cliffordDiagonalTerm|
                                                   (QAREF1 |x| |ix|)
                                                   (SPADCALL |ix|
                                                             (QREFELT $ 53))
                                                   (QAREF1 |y| |iy|)
                                                   (SPADCALL |iy|
                                                             (QREFELT $ 53))
                                                   $)
                                                  (QREFELT $ 30)))))))
                              (LETT |iy| (|inc_SI| |iy|)) (GO G190) G191
                              (EXIT NIL))))))
                     (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))))
              (COND
               ((NULL (QREFELT $ 17))
                (SEQ (LETT |ix| 0) (LETT #2# (- (QREFELT $ 19) 1)) G190
                     (COND ((|greater_SI| |ix| #2#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL (QAREF1 |x| |ix|) (|spadConstant| $ 28)
                                   (QREFELT $ 26))
                         (SEQ (LETT |iy| 0) (LETT #1# (- (QREFELT $ 19) 1))
                              G190 (COND ((|greater_SI| |iy| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (QAREF1 |y| |iy|)
                                            (|spadConstant| $ 28)
                                            (QREFELT $ 26))
                                  (LETT |z|
                                        (SPADCALL |z|
                                                  (|CLIF;cliffordProdTerm|
                                                   (QAREF1 |x| |ix|)
                                                   (SPADCALL |ix|
                                                             (QREFELT $ 53))
                                                   (QAREF1 |y| |iy|)
                                                   (SPADCALL |iy|
                                                             (QREFELT $ 53))
                                                   $)
                                                  (QREFELT $ 30)))))))
                              (LETT |iy| (|inc_SI| |iy|)) (GO G190) G191
                              (EXIT NIL))))))
                     (LETT |ix| (|inc_SI| |ix|)) (GO G190) G191 (EXIT NIL))))
              (EXIT |z|)))) 

(SDEFUN |CLIF;~;2$;46| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 68)) (QREFELT $ 84))) 

(SDEFUN |CLIF;canonMonom|
        ((|c| (K)) (|lb| (|List| (|PositiveInteger|)))
         ($ (|Record| (|:| |coef| K) (|:| |basel| (|NonNegativeInteger|)))))
        (SPROG
         ((|bz| #1=(|NonNegativeInteger|)) (#2=#:G1063 NIL)
          (|bn| (|NonNegativeInteger|)) (#3=#:G1062 NIL) (#4=#:G1072 NIL)
          (|b| NIL) (|wasordered| (|Boolean|)) (|exchanges| #1#)
          (|t| (|PositiveInteger|)) (#5=#:G1071 NIL) (|i| NIL) (#6=#:G1069 NIL)
          (#7=#:G1070 NIL))
         (SEQ
          (SEQ
           (EXIT
            (SEQ (LETT |b| NIL) (LETT #7# |lb|) G190
                 (COND
                  ((OR (ATOM #7#) (PROGN (LETT |b| (CAR #7#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((> |b| (QREFELT $ 6))
                     (PROGN
                      (LETT #6# (|error| "No such basis element"))
                      (GO #8=#:G1052))))))
                 (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL)))
           #8# (EXIT #6#))
          (LETT |wasordered| NIL) (LETT |exchanges| 0)
          (SEQ G190 (COND ((NULL (NULL |wasordered|)) (GO G191)))
               (SEQ (LETT |wasordered| 'T)
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #5# (- (LENGTH |lb|) 1)) G190
                          (COND ((|greater_SI| |i| #5#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((> (SPADCALL |lb| |i| (QREFELT $ 95))
                                 (SPADCALL |lb| (+ |i| 1) (QREFELT $ 95)))
                              (SEQ
                               (LETT |t| (SPADCALL |lb| |i| (QREFELT $ 95)))
                               (SPADCALL |lb| |i|
                                         (SPADCALL |lb| (+ |i| 1)
                                                   (QREFELT $ 95))
                                         (QREFELT $ 96))
                               (SPADCALL |lb| (+ |i| 1) |t| (QREFELT $ 96))
                               (LETT |exchanges| (+ |exchanges| 1))
                               (EXIT (LETT |wasordered| NIL)))))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
               NIL (GO G190) G191 (EXIT NIL))
          (COND ((ODDP |exchanges|) (LETT |c| (SPADCALL |c| (QREFELT $ 33)))))
          (LETT |bz| 0)
          (SEQ (LETT |b| NIL) (LETT #4# |lb|) G190
               (COND
                ((OR (ATOM #4#) (PROGN (LETT |b| (CAR #4#)) NIL)) (GO G191)))
               (SEQ
                (LETT |bn|
                      (PROG1 (LETT #3# (- |b| 1))
                        (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #3#)))
                (EXIT
                 (COND
                  ((SPADCALL |bz| |bn| (QREFELT $ 47))
                   (SEQ
                    (LETT |c|
                          (SPADCALL |c|
                                    (SPADCALL (QREFELT $ 14) |bn|
                                              (QREFELT $ 92))
                                    (QREFELT $ 38)))
                    (EXIT
                     (LETT |bz|
                           (PROG1 (LETT #2# (- |bz| (EXPT 2 |bn|)))
                             (|check_subtype2| (>= #2# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #2#))))))
                  ('T (LETT |bz| (+ |bz| (EXPT 2 |bn|)))))))
               (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
          (EXIT (CONS |c| |bz|))))) 

(SDEFUN |CLIF;monomial;KL$;48|
        ((|c| (K)) (|lb| (|List| (|PositiveInteger|))) ($ ($)))
        (SPROG
         ((|z| ($))
          (|r| (|Record| (|:| |coef| K) (|:| |basel| (|NonNegativeInteger|)))))
         (SEQ (LETT |r| (|CLIF;canonMonom| |c| |lb| $))
              (LETT |z| (MAKEARR1 (QREFELT $ 19) (|spadConstant| $ 28)))
              (QSETAREF1 |z| (QCDR |r|) (QCAR |r|)) (EXIT |z|)))) 

(SDEFUN |CLIF;coefficient;$LK;49|
        ((|z| ($)) (|lb| (|List| (|PositiveInteger|))) ($ (K)))
        (SPROG
         ((|r| (|Record| (|:| |coef| K) (|:| |basel| (|NonNegativeInteger|)))))
         (SEQ (LETT |r| (|CLIF;canonMonom| (|spadConstant| $ 41) |lb| $))
              (EXIT
               (COND
                ((SPADCALL (QCAR |r|) (|spadConstant| $ 28) (QREFELT $ 46))
                 (|error| "Cannot take coef of 0"))
                ('T
                 (SPADCALL (QAREF1 |z| (QCDR |r|)) (QCAR |r|)
                           (QREFELT $ 98)))))))) 

(SDEFUN |CLIF;coerceMonom|
        ((|c| (K)) (|b| (|NonNegativeInteger|)) ($ (|OutputForm|)))
        (SPROG
         ((|be| (|OutputForm|)) (|ml| (|List| (|OutputForm|))) (#1=#:G1090 NIL)
          (|i| NIL) (#2=#:G1089 NIL))
         (SEQ
          (COND ((EQL |b| 0) (SPADCALL |c| (QREFELT $ 101)))
                (#3='T
                 (SEQ
                  (LETT |ml|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 6)) G190
                              (COND ((|greater_SI| |i| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |b| (- |i| 1) (QREFELT $ 47))
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL "e" (QREFELT $ 102))
                                          (SPADCALL |i| (QREFELT $ 103))
                                          (QREFELT $ 104))
                                         #2#))))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (LETT |be| (SPADCALL (ELT $ 105) |ml| (QREFELT $ 108)))
                  (EXIT
                   (COND
                    ((SPADCALL |c| (|spadConstant| $ 41) (QREFELT $ 46)) |be|)
                    (#3#
                     (SPADCALL (SPADCALL |c| (QREFELT $ 101)) |be|
                               (QREFELT $ 105))))))))))) 

(SDEFUN |CLIF;coerce;$Of;51| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|tl| (|List| (|OutputForm|))) (#1=#:G1098 NIL) (|i| NIL)
          (#2=#:G1097 NIL))
         (SEQ
          (LETT |tl|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- (QREFELT $ 19) 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (QAREF1 |x| |i|) (|spadConstant| $ 28)
                                    (QREFELT $ 26))
                          (LETT #2#
                                (CONS
                                 (|CLIF;coerceMonom| (QAREF1 |x| |i|) |i| $)
                                 #2#))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (COND ((NULL |tl|) (SPADCALL "0" (QREFELT $ 102)))
                 ('T (SPADCALL (ELT $ 109) |tl| (QREFELT $ 108)))))))) 

(SDEFUN |CLIF;localPowerSets|
        ((|j| (|NonNegativeInteger|))
         ($ #1=(|List| (|List| (|PositiveInteger|)))))
        (SPROG
         ((|Sn| (|List| (|List| (|PositiveInteger|)))) (#2=#:G1105 NIL)
          (|x| NIL) (|Sm| #1#) (#3=#:G1099 NIL)
          (|l| (|List| (|List| (|PositiveInteger|)))))
         (SEQ (LETT |l| (SPADCALL NIL (QREFELT $ 112)))
              (EXIT
               (COND ((EQL |j| 0) |l|)
                     ('T
                      (SEQ
                       (LETT |Sm|
                             (|CLIF;localPowerSets|
                              (PROG1 (LETT #3# (- |j| 1))
                                (|check_subtype2| (>= #3# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #3#))
                              $))
                       (LETT |Sn| NIL)
                       (SEQ (LETT |x| NIL) (LETT #2# |Sm|) G190
                            (COND
                             ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ (EXIT (LETT |Sn| (CONS (CONS |j| |x|) |Sn|))))
                            (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                       (EXIT (SPADCALL |Sn| |Sm| (QREFELT $ 113)))))))))) 

(SDEFUN |CLIF;powerSets|
        ((|j| (|NonNegativeInteger|))
         ($ (|List| (|List| (|PositiveInteger|)))))
        (SPADCALL (ELT $ 114) (|CLIF;localPowerSets| |j| $) (QREFELT $ 116))) 

(SDEFUN |CLIF;recip;$U;54| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG
         ((|ansC| ($)) (|ansP| (|List| K)) (|cj| (K)) (#1=#:G1132 NIL)
          (|pj| NIL) (|ans| (|Union| (|Vector| K) "failed"))
          (|lhsEqs| (|List| (|List| K))) (|lhsEqi| (|List| K)) (#2=#:G1131 NIL)
          (|rhsEqs| (|List| K)) (#3=#:G1130 NIL) (|pi| NIL) (|one| ($)))
         (SEQ (LETT |one| (|spadConstant| $ 42)) (LETT |rhsEqs| NIL)
              (LETT |lhsEqs| NIL)
              (SEQ (LETT |pi| NIL) (LETT #3# (QREFELT $ 117)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |pi| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |rhsEqs|
                          (CONS (SPADCALL |one| |pi| (QREFELT $ 99)) |rhsEqs|))
                    (LETT |lhsEqi| NIL)
                    (SEQ (LETT |pj| NIL) (LETT #2# (QREFELT $ 117)) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |pj| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |lhsEqi|
                                 (CONS
                                  (SPADCALL
                                   (SPADCALL |x|
                                             (SPADCALL (|spadConstant| $ 41)
                                                       |pj| (QREFELT $ 97))
                                             (QREFELT $ 84))
                                   |pi| (QREFELT $ 99))
                                  |lhsEqi|))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |lhsEqs| (CONS (REVERSE |lhsEqi|) |lhsEqs|))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |ans|
                    (SPADCALL (SPADCALL |lhsEqs| (QREFELT $ 120))
                              (SPADCALL |rhsEqs| (QREFELT $ 121))
                              (QREFELT $ 124)))
              (EXIT
               (COND ((QEQCAR |ans| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ
                       (LETT |ansP| (SPADCALL (QCDR |ans|) (QREFELT $ 125)))
                       (LETT |ansC| (|spadConstant| $ 40))
                       (SEQ (LETT |pj| NIL) (LETT #1# (QREFELT $ 117)) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |pj| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ (LETT |cj| (|SPADfirst| |ansP|))
                                 (LETT |ansP| (CDR |ansP|))
                                 (EXIT
                                  (LETT |ansC|
                                        (SPADCALL |ansC|
                                                  (SPADCALL |cj|
                                                            (SPADCALL
                                                             (|spadConstant| $
                                                                             41)
                                                             |pj|
                                                             (QREFELT $ 97))
                                                            (QREFELT $ 39))
                                                  (QREFELT $ 30)))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT (CONS 0 |ansC|))))))))) 

(DECLAIM (NOTINLINE |CliffordAlgebra;|)) 

(DEFUN |CliffordAlgebra| (&REST #1=#:G1133)
  (SPROG NIL
         (PROG (#2=#:G1134)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL T NIL))
                     (HGET |$ConstructorCache| '|CliffordAlgebra|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |CliffordAlgebra;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|CliffordAlgebra|)))))))))) 

(DEFUN |CliffordAlgebra;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 |#3|)
          (LETT |dv$| (LIST '|CliffordAlgebra| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 129))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CliffordAlgebra|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 14
                    (SPADCALL (SPADCALL |#3| (QREFELT $ 11)) (QREFELT $ 13)))
          (QSETREFV $ 17 (SPADCALL |#3| (QREFELT $ 16)))
          (QSETREFV $ 18 NIL)
          (QSETREFV $ 19 (EXPT 2 |#1|))
          (QSETREFV $ 20 (|PrimitiveArray| |#2|))
          (QSETREFV $ 117 (|CLIF;powerSets| |#1| $))
          $))) 

(MAKEPROP '|CliffordAlgebra| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 7)
              (|SquareMatrix| (NRTEVAL (QREFELT $ 6)) 7) (0 . |diagonal|)
              (|Vector| 7) (5 . |coerce|) '|Qeelist| (|Boolean|)
              (10 . |diagonal?|) '|orthogonal| '|debug| '|dim| '|Rep|
              (|NonNegativeInteger|) (15 . |characteristic|)
              |CLIF;characteristic;Nni;1| (|CardinalNumber|) (19 . |coerce|)
              (24 . ~=) |CLIF;=;2$B;3| (30 . |Zero|) (34 . +) |CLIF;+;3$;4|
              (40 . -) |CLIF;-;3$;5| (46 . -) |CLIF;-;2$;6| (|Integer|)
              (51 . *) |CLIF;*;I2$;7| (57 . *) |CLIF;*;K2$;8|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |CLIF;Zero;$;9|) $))
              (63 . |One|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |CLIF;One;$;10|) $))
              (67 . |coerce|) |CLIF;coerce;I$;11| |CLIF;coerce;K$;12| (72 . =)
              (78 . |bit?|) (|Character|) (|String|) (84 . |elt|) (90 . ~=)
              (|SingleInteger|) (96 . |coerce|) (|List| $) (101 . |concat|)
              (|PositiveInteger|) |CLIF;e;Pi$;15| |CLIF;/\\;3$;37|
              (|Mapping| $$ $$ $$) (|List| $$) (106 . |reduce|) (|List| 56)
              |CLIF;ee;L$;16| (|List| 7) (113 . |elt|) |CLIF;multivector;L$;17|
              |CLIF;eFromBinaryMap;Nni$;18| |CLIF;ePseudoscalar;$;19|
              (|List| 60) (|Matrix| $$) (119 . |matrix|) (|Matrix| $)
              (|Mapping| $ $ $) |CLIF;toTable;MM;20| (|Mapping| $ $)
              |CLIF;toTable;MM;21| |CLIF;grade;$Nni;23|
              |CLIF;gradeInvolution;2$;25| |CLIF;reverse;2$;27|
              |CLIF;conj;2$;29| |CLIF;setMode;S2B;30| (124 . |elt|) (131 . ~=)
              |CLIF;*;3$;45| |CLIF;\\/;3$;38| |CLIF;lc;3$;41| (|Void|)
              (|List| 49) (|DisplayPackage|) (137 . |say|) |CLIF;rc;3$;42|
              (142 . |elt|) (148 . ^) |CLIF;~;2$;46| (154 . |elt|)
              (160 . |setelt!|) |CLIF;monomial;KL$;48| (167 . /)
              |CLIF;coefficient;$LK;49| (|OutputForm|) (173 . |coerce|)
              (178 . |message|) (183 . |coerce|) (188 . |sub|) (194 . *)
              (|Mapping| 100 100 100) (|List| 100) (200 . |reduce|) (206 . +)
              |CLIF;coerce;$Of;51| (|List| 62) (212 . |list|) (217 . |append|)
              (223 . |reverse|) (|Mapping| 62 62) (228 . |map|) '|Pn|
              (|List| 64) (|Matrix| 7) (234 . |matrix|) (239 . |vector|)
              (|Union| 12 '"failed") (|LinearSystemMatrixPackage| 7 12 12 119)
              (244 . |particularSolution|) (250 . |parts|)
              (|Union| $ '"failed") |CLIF;recip;$U;54| (|HashState|))
           '#(~= 255 ~ 261 |zero?| 266 |toTable| 271 |subtractIfCan| 281
              |setMode| 287 |sample| 293 |rightRecip| 297 |rightPower| 302
              |reverse| 314 |recip| 319 |rc| 324 |opposite?| 330 |one?| 336
              |multivector| 341 |monomial| 346 |leftRecip| 352 |leftPower| 357
              |lc| 369 |latex| 375 |hashUpdate!| 380 |hash| 386
              |gradeInvolution| 391 |grade| 396 |ee| 401 |ePseudoscalar| 406
              |eFromBinaryMap| 410 |e| 415 |conj| 420 |commutator| 425 |coerce|
              431 |coefficient| 446 |characteristic| 452 |associator| 456
              |antiCommutator| 463 |annihilate?| 469 ^ 475 |\\/| 487 |Zero| 493
              |One| 497 = 501 |/\\| 507 - 513 + 524 * 530)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0))
            (CONS
             '#(|Algebra&| NIL |Rng&| NIL |Module&| NIL NIL
                |NonAssociativeRing&| NIL NIL NIL |NonAssociativeRng&| NIL NIL
                |AbelianGroup&| NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |Magma&|
                |AbelianSemiGroup&| |SetCategory&| NIL |BasicType&| NIL)
             (CONS
              '#((|Algebra| 7) (|Ring|) (|Rng|) (|SemiRing|) (|Module| 7)
                 (|SemiRng|) (|BiModule| 7 7) (|NonAssociativeRing|)
                 (|BiModule| $$ $$) (|RightModule| 7) (|LeftModule| 7)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| $$)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|SetCategory|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 100))
              (|makeByteWordVec2| 128
                                  '(1 10 9 0 11 1 9 12 0 13 1 10 15 0 16 0 7 21
                                    22 1 24 0 21 25 2 7 15 0 0 26 0 7 0 28 2 7
                                    0 0 0 29 2 7 0 0 0 31 1 7 0 0 33 2 7 0 35 0
                                    36 2 7 0 0 0 38 0 7 0 41 1 7 0 35 43 2 7 15
                                    0 0 46 2 35 15 0 0 47 2 49 48 0 35 50 2 49
                                    15 0 0 51 1 52 0 35 53 1 49 0 54 55 3 60 2
                                    59 0 2 61 2 64 7 0 35 65 1 70 0 69 71 3 10
                                    7 0 35 35 82 2 52 15 0 0 83 1 89 87 88 90 2
                                    12 7 0 35 92 2 52 0 0 21 93 2 62 56 0 35 95
                                    3 62 56 0 35 56 96 2 7 0 0 0 98 1 7 100 0
                                    101 1 100 0 49 102 1 21 100 0 103 2 100 0 0
                                    0 104 2 100 0 0 0 105 2 107 100 106 0 108 2
                                    100 0 0 0 109 1 111 0 62 112 2 111 0 0 0
                                    113 1 62 0 0 114 2 111 0 115 0 116 1 119 0
                                    118 120 1 12 0 64 121 2 123 122 119 12 124
                                    1 12 64 0 125 2 0 15 0 0 1 1 0 0 0 94 1 0
                                    15 0 1 1 0 72 75 76 1 0 72 73 74 2 0 126 0
                                    0 1 2 0 15 49 15 81 0 0 0 1 1 0 126 0 1 2 0
                                    0 0 21 1 2 0 0 0 56 1 1 0 0 0 79 1 0 126 0
                                    127 2 0 0 0 0 91 2 0 15 0 0 1 1 0 15 0 1 1
                                    0 0 64 66 2 0 0 7 62 97 1 0 126 0 1 2 0 0 0
                                    21 1 2 0 0 0 56 1 2 0 0 0 0 86 1 0 49 0 1 2
                                    0 128 128 0 1 1 0 52 0 1 1 0 0 0 78 1 0 21
                                    0 77 1 0 0 62 63 0 0 0 68 1 0 0 21 67 1 0 0
                                    56 57 1 0 0 0 80 2 0 0 0 0 1 1 0 0 7 45 1 0
                                    0 35 44 1 0 100 0 110 2 0 7 0 62 99 0 0 21
                                    23 3 0 0 0 0 0 1 2 0 0 0 0 1 2 0 15 0 0 1 2
                                    0 0 0 21 1 2 0 0 0 56 1 2 0 0 0 0 85 0 0 0
                                    40 0 0 0 42 2 0 15 0 0 27 2 0 0 0 0 58 1 0
                                    0 0 34 2 0 0 0 0 32 2 0 0 0 0 30 2 0 0 7 0
                                    39 2 0 0 0 7 1 2 0 0 21 0 1 2 0 0 35 0 37 2
                                    0 0 0 0 84 2 0 0 56 0 1)))))
           '|lookupComplete|)) 
