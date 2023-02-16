
(PUT '|SOLVEFOR;part| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |SOLVEFOR;part| ((|s| (F)) ($ (F))) |s|) 

(SDEFUN |SOLVEFOR;sqrt2| ((|s| (F)) ($ (F)))
        (SPROG
         ((|res|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F))))
         (SEQ
          (COND
           ((|domainEqual| (QREFELT $ 7) (|Expression| (QREFELT $ 8)))
            (SEQ (LETT |res| (SPADCALL |s| 2 (QREFELT $ 12)))
                 (EXIT
                  (SPADCALL (QVELT |res| 1)
                            (SPADCALL (QVELT |res| 2)
                                      (SPADCALL 1 (QVELT |res| 0)
                                                (QREFELT $ 17))
                                      (QREFELT $ 18))
                            (QREFELT $ 19)))))
           ('T (SPADCALL |s| (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18))))))) 

(SDEFUN |SOLVEFOR;intsolve| ((|u| (UP)) ($ (|List| F)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ
                (LETT |u|
                      (QVELT
                       (SPADCALL
                        (SPADCALL (SPADCALL |u| (QREFELT $ 21)) (QREFELT $ 26))
                        1 (QREFELT $ 27))
                       1))
                (LETT |n| (SPADCALL |u| (QREFELT $ 28)))
                (EXIT
                 (COND
                  ((EQL |n| 1)
                   (SPADCALL (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 33)))
                  ((EQL |n| 2)
                   (SPADCALL (SPADCALL |u| 2 (QREFELT $ 29))
                             (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 34)))
                  ((EQL |n| 3)
                   (SPADCALL (SPADCALL |u| 3 (QREFELT $ 29))
                             (SPADCALL |u| 2 (QREFELT $ 29))
                             (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 35)))
                  ((EQL |n| 4)
                   (SPADCALL (SPADCALL |u| 4 (QREFELT $ 29))
                             (SPADCALL |u| 3 (QREFELT $ 29))
                             (SPADCALL |u| 2 (QREFELT $ 29))
                             (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 36)))
                  ('T
                   (|error|
                    "All sqfr factors of polynomial must be of degree < 5"))))))) 

(SDEFUN |SOLVEFOR;solve;UPL;4| ((|u| (UP)) ($ (|List| F)))
        (SPROG
         ((|ls| (|List| F)) (#1=#:G748 NIL) (|i| NIL) (|lsf| (|List| F))
          (#2=#:G747 NIL) (|f| NIL))
         (SEQ (LETT |ls| NIL)
              (SEQ (LETT |f| NIL)
                   (LETT #2#
                         (SPADCALL (SPADCALL |u| (QREFELT $ 21))
                                   (QREFELT $ 26)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |lsf| (|SOLVEFOR;intsolve| (QVELT |f| 1) $))
                        (EXIT
                         (SEQ (LETT |i| 1) (LETT #1# (QVELT |f| 2)) G190
                              (COND ((|greater_SI| |i| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT |ls|
                                      (SPADCALL |lsf| |ls| (QREFELT $ 37)))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ls|)))) 

(SDEFUN |SOLVEFOR;particularSolution;UPF;5| ((|u| (UP)) ($ (F)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ
                (LETT |u|
                      (QVELT
                       (SPADCALL
                        (SPADCALL (SPADCALL |u| (QREFELT $ 21)) (QREFELT $ 26))
                        1 (QREFELT $ 27))
                       1))
                (LETT |n| (SPADCALL |u| (QREFELT $ 28)))
                (EXIT
                 (COND
                  ((EQL |n| 1)
                   (SPADCALL (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 39)))
                  ((EQL |n| 2)
                   (SPADCALL (SPADCALL |u| 2 (QREFELT $ 29))
                             (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 40)))
                  ((EQL |n| 3)
                   (SPADCALL (SPADCALL |u| 3 (QREFELT $ 29))
                             (SPADCALL |u| 2 (QREFELT $ 29))
                             (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 41)))
                  ((EQL |n| 4)
                   (SPADCALL (SPADCALL |u| 4 (QREFELT $ 29))
                             (SPADCALL |u| 3 (QREFELT $ 29))
                             (SPADCALL |u| 2 (QREFELT $ 29))
                             (SPADCALL |u| 1 (QREFELT $ 29))
                             (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 42)))
                  ('T
                   (|error|
                    "All sqfr factors of polynomial must be of degree < 5"))))))) 

(SDEFUN |SOLVEFOR;needDegree| ((|n| (|Integer|)) (|u| (UP)) ($ (|Boolean|)))
        (COND ((EQL (SPADCALL |u| (QREFELT $ 28)) |n|) 'T)
              ('T
               (|error|
                (STRCONC "Polynomial must be of degree " (STRINGIMAGE |n|)))))) 

(SDEFUN |SOLVEFOR;needLcoef| ((|cn| (F)) ($ (|Boolean|)))
        (COND ((SPADCALL |cn| (|spadConstant| $ 31) (QREFELT $ 45)) 'T)
              ('T (|error| "Leading coefficient must not be 0.")))) 

(SDEFUN |SOLVEFOR;needChar0| (($ (|Boolean|)))
        (COND ((EQL (SPADCALL (QREFELT $ 46)) 0) 'T)
              ('T
               (|error|
                "Formula defined only for fields of characteristic 0.")))) 

(SDEFUN |SOLVEFOR;linear;UPL;9| ((|u| (UP)) ($ (|List| F)))
        (SEQ (|SOLVEFOR;needDegree| 1 |u| $)
             (EXIT
              (SPADCALL (SPADCALL |u| 1 (QREFELT $ 29))
                        (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 33))))) 

(SDEFUN |SOLVEFOR;quadratic;UPL;10| ((|u| (UP)) ($ (|List| F)))
        (SEQ (|SOLVEFOR;needDegree| 2 |u| $)
             (EXIT
              (SPADCALL (SPADCALL |u| 2 (QREFELT $ 29))
                        (SPADCALL |u| 1 (QREFELT $ 29))
                        (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 34))))) 

(SDEFUN |SOLVEFOR;cubic;UPL;11| ((|u| (UP)) ($ (|List| F)))
        (SEQ (|SOLVEFOR;needDegree| 3 |u| $)
             (EXIT
              (SPADCALL (SPADCALL |u| 3 (QREFELT $ 29))
                        (SPADCALL |u| 2 (QREFELT $ 29))
                        (SPADCALL |u| 1 (QREFELT $ 29))
                        (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 35))))) 

(SDEFUN |SOLVEFOR;quartic;UPL;12| ((|u| (UP)) ($ (|List| F)))
        (SEQ (|SOLVEFOR;needDegree| 4 |u| $)
             (EXIT
              (SPADCALL (SPADCALL |u| 4 (QREFELT $ 29))
                        (SPADCALL |u| 3 (QREFELT $ 29))
                        (SPADCALL |u| 2 (QREFELT $ 29))
                        (SPADCALL |u| 1 (QREFELT $ 29))
                        (SPADCALL |u| 0 (QREFELT $ 29)) (QREFELT $ 36))))) 

(SDEFUN |SOLVEFOR;equ| ((|x| (F)) (|y| (F)) ($ (|Boolean|)))
        (COND
         ((QEQCAR (SPADCALL (SPADCALL |x| |y| (QREFELT $ 51)) (QREFELT $ 53))
                  1)
          'T)
         ('T NIL))) 

(SDEFUN |SOLVEFOR;linear;2FL;14| ((|c1| (F)) (|c0| (F)) ($ (|List| F)))
        (SEQ (|SOLVEFOR;needLcoef| |c1| $)
             (EXIT
              (LIST
               (SPADCALL (SPADCALL |c0| |c1| (QREFELT $ 54)) (QREFELT $ 55)))))) 

(SDEFUN |SOLVEFOR;aLinear;3F;15| ((|c1| (F)) (|c0| (F)) ($ (F)))
        (|SPADfirst| (SPADCALL |c1| |c0| (QREFELT $ 33)))) 

(SDEFUN |SOLVEFOR;quadratic;3FL;16|
        ((|c2| (F)) (|c1| (F)) (|c0| (F)) ($ (|List| F)))
        (SPROG ((D (F)))
               (SEQ (|SOLVEFOR;needLcoef| |c2| $) (|SOLVEFOR;needChar0| $)
                    (EXIT
                     (COND
                      ((SPADCALL |c0| (|spadConstant| $ 31) (QREFELT $ 56))
                       (CONS (|spadConstant| $ 31)
                             (SPADCALL |c2| |c1| (QREFELT $ 33))))
                      ((SPADCALL |c1| (|spadConstant| $ 31) (QREFELT $ 56))
                       (LIST
                        (SPADCALL
                         (SPADCALL (SPADCALL |c0| |c2| (QREFELT $ 54))
                                   (QREFELT $ 55))
                         (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18))
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |c0| |c2| (QREFELT $ 54))
                                    (QREFELT $ 55))
                          (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18))
                         (QREFELT $ 55))))
                      ('T
                       (SEQ
                        (LETT D
                              (|SOLVEFOR;sqrt2|
                               (SPADCALL (SPADCALL |c1| 2 (QREFELT $ 58))
                                         (SPADCALL
                                          (SPADCALL 4 |c2| (QREFELT $ 59)) |c0|
                                          (QREFELT $ 19))
                                         (QREFELT $ 51))
                               $))
                        (EXIT
                         (LIST
                          (SPADCALL
                           (SPADCALL (SPADCALL |c1| (QREFELT $ 55)) D
                                     (QREFELT $ 60))
                           (SPADCALL 2 |c2| (QREFELT $ 59)) (QREFELT $ 54))
                          (SPADCALL
                           (SPADCALL (SPADCALL |c1| (QREFELT $ 55)) D
                                     (QREFELT $ 51))
                           (SPADCALL 2 |c2| (QREFELT $ 59))
                           (QREFELT $ 54))))))))))) 

(SDEFUN |SOLVEFOR;aQuadratic;4F;17| ((|c2| (F)) (|c1| (F)) (|c0| (F)) ($ (F)))
        (SPROG ((D (F)))
               (SEQ (|SOLVEFOR;needLcoef| |c2| $) (|SOLVEFOR;needChar0| $)
                    (EXIT
                     (COND
                      ((SPADCALL |c0| (|spadConstant| $ 31) (QREFELT $ 56))
                       (|spadConstant| $ 31))
                      ((SPADCALL |c1| (|spadConstant| $ 31) (QREFELT $ 56))
                       (SPADCALL
                        (SPADCALL (SPADCALL |c0| |c2| (QREFELT $ 54))
                                  (QREFELT $ 55))
                        (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18)))
                      ('T
                       (SEQ
                        (LETT D
                              (SPADCALL
                               (|SOLVEFOR;part|
                                (SPADCALL (SPADCALL |c1| 2 (QREFELT $ 58))
                                          (SPADCALL
                                           (SPADCALL 4 |c2| (QREFELT $ 59))
                                           |c0| (QREFELT $ 19))
                                          (QREFELT $ 51))
                                $)
                               (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18)))
                        (EXIT
                         (SPADCALL
                          (SPADCALL (SPADCALL |c1| (QREFELT $ 55)) D
                                    (QREFELT $ 60))
                          (SPADCALL 2 |c2| (QREFELT $ 59))
                          (QREFELT $ 54)))))))))) 

(SDEFUN |SOLVEFOR;cubic;4FL;18|
        ((|c3| (F)) (|c2| (F)) (|c1| (F)) (|c0| (F)) ($ (|List| F)))
        (SPROG
         ((#1=#:G795 NIL) (|u| NIL) (#2=#:G794 NIL) (S (F)) (D (F)) (R (F))
          (Q (F)) (#3=#:G793 NIL) (#4=#:G792 NIL) (P (F)) (#5=#:G791 NIL)
          (#6=#:G790 NIL) (|a3| (F)) (|a2| (F)) (|a1| (F)))
         (SEQ (|SOLVEFOR;needLcoef| |c3| $) (|SOLVEFOR;needChar0| $)
              (EXIT
               (COND
                ((SPADCALL |c0| (|spadConstant| $ 31) (QREFELT $ 56))
                 (CONS (|spadConstant| $ 31)
                       (SPADCALL |c3| |c2| |c1| (QREFELT $ 34))))
                (#7='T
                 (SEQ (LETT |a1| (SPADCALL |c2| |c3| (QREFELT $ 54)))
                      (LETT |a2| (SPADCALL |c1| |c3| (QREFELT $ 54)))
                      (LETT |a3| (SPADCALL |c0| |c3| (QREFELT $ 54)))
                      (COND
                       ((SPADCALL |a1| (|spadConstant| $ 31) (QREFELT $ 56))
                        (COND
                         ((SPADCALL |a2| (|spadConstant| $ 31) (QREFELT $ 56))
                          (EXIT
                           (PROGN
                            (LETT #6# NIL)
                            (SEQ (LETT |u| NIL)
                                 (LETT #5#
                                       (LIST (|spadConstant| $ 14)
                                             (QREFELT $ 62)
                                             (SPADCALL (QREFELT $ 62) 2
                                                       (QREFELT $ 58))))
                                 G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT |u| (CAR #5#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #6#
                                         (CONS
                                          (SPADCALL |u|
                                                    (SPADCALL
                                                     (SPADCALL |a3|
                                                               (QREFELT $ 55))
                                                     (SPADCALL 1 3
                                                               (QREFELT $ 17))
                                                     (QREFELT $ 18))
                                                    (QREFELT $ 19))
                                          #6#))))
                                 (LETT #5# (CDR #5#)) (GO G190) G191
                                 (EXIT (NREVERSE #6#)))))))))
                      (LETT P
                            (|SOLVEFOR;part|
                             (SPADCALL
                              (SPADCALL |a1| (SPADCALL 3 (QREFELT $ 61))
                                        (QREFELT $ 54))
                              (QREFELT $ 55))
                             $))
                      (EXIT
                       (COND
                        ((|SOLVEFOR;equ| (SPADCALL |a1| 2 (QREFELT $ 58))
                          (SPADCALL 3 |a2| (QREFELT $ 59)) $)
                         (SEQ
                          (LETT S
                                (|SOLVEFOR;part|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a3| (QREFELT $ 55))
                                            (SPADCALL
                                             (SPADCALL |a1| 3 (QREFELT $ 58))
                                             (SPADCALL 27 (QREFELT $ 61))
                                             (QREFELT $ 54))
                                            (QREFELT $ 60))
                                  (SPADCALL 1 3 (QREFELT $ 17)) (QREFELT $ 18))
                                 $))
                          (EXIT
                           (PROGN
                            (LETT #4# NIL)
                            (SEQ (LETT |u| NIL)
                                 (LETT #3#
                                       (LIST (|spadConstant| $ 14)
                                             (QREFELT $ 62)
                                             (SPADCALL (QREFELT $ 62) 2
                                                       (QREFELT $ 58))))
                                 G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |u| (CAR #3#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #4#
                                         (CONS
                                          (SPADCALL P
                                                    (SPADCALL S |u|
                                                              (QREFELT $ 19))
                                                    (QREFELT $ 60))
                                          #4#))))
                                 (LETT #3# (CDR #3#)) (GO G190) G191
                                 (EXIT (NREVERSE #4#)))))))
                        (#7#
                         (SEQ
                          (LETT Q
                                (|SOLVEFOR;part|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL 3 |a2| (QREFELT $ 59))
                                            (SPADCALL |a1| 2 (QREFELT $ 58))
                                            (QREFELT $ 51))
                                  (SPADCALL 9 (QREFELT $ 61)) (QREFELT $ 54))
                                 $))
                          (LETT R
                                (|SOLVEFOR;part|
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (SPADCALL 9 |a1| (QREFELT $ 59))
                                              |a2| (QREFELT $ 19))
                                    (SPADCALL 27 |a3| (QREFELT $ 59))
                                    (QREFELT $ 51))
                                   (SPADCALL 2 (SPADCALL |a1| 3 (QREFELT $ 58))
                                             (QREFELT $ 59))
                                   (QREFELT $ 51))
                                  (SPADCALL 54 (QREFELT $ 61)) (QREFELT $ 54))
                                 $))
                          (LETT D
                                (SPADCALL
                                 (|SOLVEFOR;part|
                                  (SPADCALL (SPADCALL Q 3 (QREFELT $ 58))
                                            (SPADCALL R 2 (QREFELT $ 58))
                                            (QREFELT $ 60))
                                  $)
                                 (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18)))
                          (LETT S
                                (SPADCALL
                                 (|SOLVEFOR;part| (SPADCALL R D (QREFELT $ 60))
                                  $)
                                 (SPADCALL 1 3 (QREFELT $ 17)) (QREFELT $ 18)))
                          (EXIT
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |u| NIL)
                                 (LETT #1#
                                       (LIST (|spadConstant| $ 14)
                                             (QREFELT $ 62)
                                             (SPADCALL (QREFELT $ 62) 2
                                                       (QREFELT $ 58))))
                                 G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |u| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL P
                                                     (SPADCALL S |u|
                                                               (QREFELT $ 19))
                                                     (QREFELT $ 60))
                                           (SPADCALL Q
                                                     (SPADCALL S |u|
                                                               (QREFELT $ 19))
                                                     (QREFELT $ 54))
                                           (QREFELT $ 51))
                                          #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#)))))))))))))))) 

(SDEFUN |SOLVEFOR;aCubic;5F;19|
        ((|c3| (F)) (|c2| (F)) (|c1| (F)) (|c0| (F)) ($ (F)))
        (SPROG
         ((S (F)) (D (F)) (R (F)) (Q (F)) (P (F)) (|a3| (F)) (|a2| (F))
          (|a1| (F)))
         (SEQ (|SOLVEFOR;needLcoef| |c3| $) (|SOLVEFOR;needChar0| $)
              (EXIT
               (COND
                ((SPADCALL |c0| (|spadConstant| $ 31) (QREFELT $ 56))
                 (|spadConstant| $ 31))
                (#1='T
                 (SEQ (LETT |a1| (SPADCALL |c2| |c3| (QREFELT $ 54)))
                      (LETT |a2| (SPADCALL |c1| |c3| (QREFELT $ 54)))
                      (LETT |a3| (SPADCALL |c0| |c3| (QREFELT $ 54)))
                      (COND
                       ((SPADCALL |a1| (|spadConstant| $ 31) (QREFELT $ 56))
                        (COND
                         ((SPADCALL |a2| (|spadConstant| $ 31) (QREFELT $ 56))
                          (EXIT
                           (SPADCALL (SPADCALL |a3| (QREFELT $ 55))
                                     (SPADCALL 1 3 (QREFELT $ 17))
                                     (QREFELT $ 18)))))))
                      (LETT P
                            (|SOLVEFOR;part|
                             (SPADCALL
                              (SPADCALL |a1| (SPADCALL 3 (QREFELT $ 61))
                                        (QREFELT $ 54))
                              (QREFELT $ 55))
                             $))
                      (EXIT
                       (COND
                        ((|SOLVEFOR;equ| (SPADCALL |a1| 2 (QREFELT $ 58))
                          (SPADCALL 3 |a2| (QREFELT $ 59)) $)
                         (SEQ
                          (LETT S
                                (|SOLVEFOR;part|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a3| (QREFELT $ 55))
                                            (SPADCALL
                                             (SPADCALL |a1| 3 (QREFELT $ 58))
                                             (SPADCALL 27 (QREFELT $ 61))
                                             (QREFELT $ 54))
                                            (QREFELT $ 60))
                                  (SPADCALL 1 3 (QREFELT $ 17)) (QREFELT $ 18))
                                 $))
                          (EXIT (SPADCALL P S (QREFELT $ 60)))))
                        (#1#
                         (SEQ
                          (LETT Q
                                (|SOLVEFOR;part|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL 3 |a2| (QREFELT $ 59))
                                            (SPADCALL |a1| 2 (QREFELT $ 58))
                                            (QREFELT $ 51))
                                  (SPADCALL 9 (QREFELT $ 61)) (QREFELT $ 54))
                                 $))
                          (LETT R
                                (|SOLVEFOR;part|
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (SPADCALL 9 |a1| (QREFELT $ 59))
                                              |a2| (QREFELT $ 19))
                                    (SPADCALL 27 |a3| (QREFELT $ 59))
                                    (QREFELT $ 51))
                                   (SPADCALL 2 (SPADCALL |a1| 3 (QREFELT $ 58))
                                             (QREFELT $ 59))
                                   (QREFELT $ 51))
                                  (SPADCALL 54 (QREFELT $ 61)) (QREFELT $ 54))
                                 $))
                          (LETT D
                                (SPADCALL
                                 (|SOLVEFOR;part|
                                  (SPADCALL (SPADCALL Q 3 (QREFELT $ 58))
                                            (SPADCALL R 2 (QREFELT $ 58))
                                            (QREFELT $ 60))
                                  $)
                                 (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18)))
                          (LETT S
                                (SPADCALL
                                 (|SOLVEFOR;part| (SPADCALL R D (QREFELT $ 60))
                                  $)
                                 (SPADCALL 1 3 (QREFELT $ 17)) (QREFELT $ 18)))
                          (EXIT
                           (SPADCALL (SPADCALL P S (QREFELT $ 60))
                                     (SPADCALL Q S (QREFELT $ 54))
                                     (QREFELT $ 51)))))))))))))) 

(SDEFUN |SOLVEFOR;quartic;5FL;20|
        ((|c4| (F)) (|c3| (F)) (|c2| (F)) (|c1| (F)) (|c0| (F)) ($ (|List| F)))
        (SPROG
         ((#1=#:G808 NIL) (|s| NIL) (#2=#:G807 NIL) (|slist| (|List| F))
          (|rt| (F)) (|t0| (F)) (|r| (F)) (|q| (F)) (|p| (F)) (|a4| (F))
          (|a3| (F)) (|a2| (F)) (|a1| (F)))
         (SEQ (|SOLVEFOR;needLcoef| |c4| $) (|SOLVEFOR;needChar0| $)
              (EXIT
               (COND
                ((SPADCALL |c0| (|spadConstant| $ 31) (QREFELT $ 56))
                 (CONS (|spadConstant| $ 31)
                       (SPADCALL |c4| |c3| |c2| |c1| (QREFELT $ 35))))
                (#3='T
                 (SEQ (LETT |a1| (SPADCALL |c3| |c4| (QREFELT $ 54)))
                      (LETT |a2| (SPADCALL |c2| |c4| (QREFELT $ 54)))
                      (LETT |a3| (SPADCALL |c1| |c4| (QREFELT $ 54)))
                      (LETT |a4| (SPADCALL |c0| |c4| (QREFELT $ 54)))
                      (COND
                       ((SPADCALL |a1| (|spadConstant| $ 31) (QREFELT $ 56))
                        (COND
                         ((SPADCALL |a2| (|spadConstant| $ 31) (QREFELT $ 56))
                          (COND
                           ((SPADCALL |a3| (|spadConstant| $ 31)
                                      (QREFELT $ 56))
                            (EXIT
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 14)
                                        (|spadConstant| $ 31)
                                        (SPADCALL
                                         (SPADCALL |a4| (QREFELT $ 55))
                                         (SPADCALL 1 2 (QREFELT $ 17))
                                         (QREFELT $ 18))
                                        (QREFELT $ 34))
                              (SPADCALL (|spadConstant| $ 14)
                                        (|spadConstant| $ 31)
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |a4| (QREFELT $ 55))
                                          (SPADCALL 1 2 (QREFELT $ 17))
                                          (QREFELT $ 18))
                                         (QREFELT $ 55))
                                        (QREFELT $ 34))
                              (QREFELT $ 37)))))))))
                      (LETT |p|
                            (|SOLVEFOR;part|
                             (SPADCALL |a2|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL 3 |a1| (QREFELT $ 59)) |a1|
                                         (QREFELT $ 19))
                                        (SPADCALL 8 (QREFELT $ 61))
                                        (QREFELT $ 54))
                                       (QREFELT $ 51))
                             $))
                      (LETT |q|
                            (|SOLVEFOR;part|
                             (SPADCALL
                              (SPADCALL |a3|
                                        (SPADCALL
                                         (SPADCALL |a1| |a2| (QREFELT $ 19))
                                         (SPADCALL 2 (QREFELT $ 61))
                                         (QREFELT $ 54))
                                        (QREFELT $ 51))
                              (SPADCALL (SPADCALL |a1| 3 (QREFELT $ 58))
                                        (SPADCALL 8 (QREFELT $ 61))
                                        (QREFELT $ 54))
                              (QREFELT $ 60))
                             $))
                      (LETT |r|
                            (|SOLVEFOR;part|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL |a4|
                                         (SPADCALL
                                          (SPADCALL |a1| |a3| (QREFELT $ 19))
                                          (SPADCALL 4 (QREFELT $ 61))
                                          (QREFELT $ 54))
                                         (QREFELT $ 51))
                               (SPADCALL
                                (SPADCALL (SPADCALL |a1| 2 (QREFELT $ 58)) |a2|
                                          (QREFELT $ 19))
                                (SPADCALL 16 (QREFELT $ 61)) (QREFELT $ 54))
                               (QREFELT $ 60))
                              (SPADCALL
                               (SPADCALL 3 (SPADCALL |a1| 4 (QREFELT $ 58))
                                         (QREFELT $ 59))
                               (SPADCALL 256 (QREFELT $ 61)) (QREFELT $ 54))
                              (QREFELT $ 51))
                             $))
                      (COND
                       ((|SOLVEFOR;equ| |q| (|spadConstant| $ 31) $)
                        (LETT |t0|
                              (|SOLVEFOR;part|
                               (SPADCALL 2
                                         (SPADCALL |r|
                                                   (SPADCALL 1 2
                                                             (QREFELT $ 17))
                                                   (QREFELT $ 18))
                                         (QREFELT $ 59))
                               $)))
                       (#3#
                        (LETT |t0|
                              (SPADCALL (|spadConstant| $ 14)
                                        (SPADCALL |p| (QREFELT $ 55))
                                        (SPADCALL
                                         (SPADCALL 4 |r| (QREFELT $ 59))
                                         (QREFELT $ 55))
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL 4 |p| (QREFELT $ 59)) |r|
                                          (QREFELT $ 19))
                                         (SPADCALL |q| 2 (QREFELT $ 58))
                                         (QREFELT $ 51))
                                        (QREFELT $ 41)))))
                      (LETT |rt|
                            (SPADCALL
                             (|SOLVEFOR;part|
                              (SPADCALL |t0| |p| (QREFELT $ 51)) $)
                             (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18)))
                      (LETT |slist|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 14) |rt|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |q| |rt| (QREFELT $ 54))
                                          (QREFELT $ 55))
                                         |t0| (QREFELT $ 60))
                                        (SPADCALL 2 (QREFELT $ 61))
                                        (QREFELT $ 54))
                                       (QREFELT $ 34))
                             (SPADCALL (|spadConstant| $ 14)
                                       (SPADCALL |rt| (QREFELT $ 55))
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |q| |rt| (QREFELT $ 54))
                                         |t0| (QREFELT $ 60))
                                        (SPADCALL 2 (QREFELT $ 61))
                                        (QREFELT $ 54))
                                       (QREFELT $ 34))
                             (QREFELT $ 37)))
                      (EXIT
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |s| NIL) (LETT #1# |slist|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (SPADCALL |s|
                                                (SPADCALL |a1|
                                                          (SPADCALL 4
                                                                    (QREFELT $
                                                                             61))
                                                          (QREFELT $ 54))
                                                (QREFELT $ 51))
                                      #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#)))))))))))) 

(SDEFUN |SOLVEFOR;aQuartic;6F;21|
        ((|c4| (F)) (|c3| (F)) (|c2| (F)) (|c1| (F)) (|c0| (F)) ($ (F)))
        (SPROG
         ((|s| (F)) (|rt| (F)) (|t0| (F)) (|r| (F)) (|q| (F)) (|p| (F))
          (|a4| (F)) (|a3| (F)) (|a2| (F)) (|a1| (F)))
         (SEQ (|SOLVEFOR;needLcoef| |c4| $) (|SOLVEFOR;needChar0| $)
              (EXIT
               (COND
                ((SPADCALL |c0| (|spadConstant| $ 31) (QREFELT $ 56))
                 (|spadConstant| $ 31))
                (#1='T
                 (SEQ (LETT |a1| (SPADCALL |c3| |c4| (QREFELT $ 54)))
                      (LETT |a2| (SPADCALL |c2| |c4| (QREFELT $ 54)))
                      (LETT |a3| (SPADCALL |c1| |c4| (QREFELT $ 54)))
                      (LETT |a4| (SPADCALL |c0| |c4| (QREFELT $ 54)))
                      (COND
                       ((SPADCALL |a1| (|spadConstant| $ 31) (QREFELT $ 56))
                        (COND
                         ((SPADCALL |a2| (|spadConstant| $ 31) (QREFELT $ 56))
                          (COND
                           ((SPADCALL |a3| (|spadConstant| $ 31)
                                      (QREFELT $ 56))
                            (EXIT
                             (SPADCALL (SPADCALL |a4| (QREFELT $ 55))
                                       (SPADCALL 1 4 (QREFELT $ 17))
                                       (QREFELT $ 18)))))))))
                      (LETT |p|
                            (|SOLVEFOR;part|
                             (SPADCALL |a2|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL 3 |a1| (QREFELT $ 59)) |a1|
                                         (QREFELT $ 19))
                                        (SPADCALL 8 (QREFELT $ 61))
                                        (QREFELT $ 54))
                                       (QREFELT $ 51))
                             $))
                      (LETT |q|
                            (|SOLVEFOR;part|
                             (SPADCALL
                              (SPADCALL |a3|
                                        (SPADCALL
                                         (SPADCALL |a1| |a2| (QREFELT $ 19))
                                         (SPADCALL 2 (QREFELT $ 61))
                                         (QREFELT $ 54))
                                        (QREFELT $ 51))
                              (SPADCALL
                               (SPADCALL (SPADCALL |a1| 2 (QREFELT $ 58)) |a1|
                                         (QREFELT $ 19))
                               (SPADCALL 8 (QREFELT $ 61)) (QREFELT $ 54))
                              (QREFELT $ 60))
                             $))
                      (LETT |r|
                            (|SOLVEFOR;part|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL |a4|
                                         (SPADCALL
                                          (SPADCALL |a1| |a3| (QREFELT $ 19))
                                          (SPADCALL 4 (QREFELT $ 61))
                                          (QREFELT $ 54))
                                         (QREFELT $ 51))
                               (SPADCALL
                                (SPADCALL (SPADCALL |a1| 2 (QREFELT $ 58)) |a2|
                                          (QREFELT $ 19))
                                (SPADCALL 16 (QREFELT $ 61)) (QREFELT $ 54))
                               (QREFELT $ 60))
                              (SPADCALL
                               (SPADCALL 3 (SPADCALL |a1| 4 (QREFELT $ 58))
                                         (QREFELT $ 59))
                               (SPADCALL 256 (QREFELT $ 61)) (QREFELT $ 54))
                              (QREFELT $ 51))
                             $))
                      (COND
                       ((|SOLVEFOR;equ| |q| (|spadConstant| $ 31) $)
                        (LETT |t0|
                              (|SOLVEFOR;part|
                               (SPADCALL 2
                                         (SPADCALL |r|
                                                   (SPADCALL 1 2
                                                             (QREFELT $ 17))
                                                   (QREFELT $ 18))
                                         (QREFELT $ 59))
                               $)))
                       (#1#
                        (LETT |t0|
                              (SPADCALL (|spadConstant| $ 14)
                                        (SPADCALL |p| (QREFELT $ 55))
                                        (SPADCALL
                                         (SPADCALL 4 |r| (QREFELT $ 59))
                                         (QREFELT $ 55))
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL 4 |p| (QREFELT $ 59)) |r|
                                          (QREFELT $ 19))
                                         (SPADCALL |q| 2 (QREFELT $ 58))
                                         (QREFELT $ 51))
                                        (QREFELT $ 41)))))
                      (LETT |rt|
                            (SPADCALL
                             (|SOLVEFOR;part|
                              (SPADCALL |t0| |p| (QREFELT $ 51)) $)
                             (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18)))
                      (LETT |s|
                            (SPADCALL (|spadConstant| $ 14) |rt|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |q| |rt| (QREFELT $ 54))
                                         (QREFELT $ 55))
                                        |t0| (QREFELT $ 60))
                                       (SPADCALL 2 (QREFELT $ 61))
                                       (QREFELT $ 54))
                                      (QREFELT $ 40)))
                      (EXIT
                       (SPADCALL |s|
                                 (SPADCALL |a1| (SPADCALL 4 (QREFELT $ 61))
                                           (QREFELT $ 54))
                                 (QREFELT $ 51)))))))))) 

(DECLAIM (NOTINLINE |PolynomialSolveByFormulas;|)) 

(DEFUN |PolynomialSolveByFormulas| (&REST #1=#:G813)
  (SPROG NIL
         (PROG (#2=#:G814)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialSolveByFormulas|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialSolveByFormulas;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PolynomialSolveByFormulas|)))))))))) 

(DEFUN |PolynomialSolveByFormulas;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PolynomialSolveByFormulas| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialSolveByFormulas|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 62
                    (SPADCALL
                     (SPADCALL (SPADCALL (|spadConstant| $ 14) (QREFELT $ 55))
                               (SPADCALL
                                (SPADCALL (SPADCALL 3 (QREFELT $ 61))
                                          (QREFELT $ 55))
                                (SPADCALL 1 2 (QREFELT $ 17)) (QREFELT $ 18))
                               (QREFELT $ 60))
                     (SPADCALL 2 (QREFELT $ 61)) (QREFELT $ 54)))
          $))) 

(MAKEPROP '|PolynomialSolveByFormulas| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|)
              (|Record| (|:| |exponent| 10) (|:| |coef| 7) (|:| |radicand| 7))
              (|NonNegativeInteger|)
              (|PolynomialRoots| (|IndexedExponents| (|Kernel| 7)) (|Kernel| 7)
                                 8
                                 (|SparseMultivariatePolynomial| 8
                                                                 (|Kernel| 7))
                                 7)
              (0 . |froot|) (6 . |One|) (10 . |One|) (|Integer|)
              (|Fraction| 15) (14 . /) (20 . ^) (26 . *) (|Factored| $)
              (32 . |squareFree|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 22) (|:| |factor| 6) (|:| |exponent| 10))
              (|List| 23) (|Factored| 6) (37 . |factorList|) (42 . |elt|)
              (48 . |degree|) (53 . |coefficient|) (59 . |Zero|) (63 . |Zero|)
              (|List| 7) |SOLVEFOR;linear;2FL;14| |SOLVEFOR;quadratic;3FL;16|
              |SOLVEFOR;cubic;4FL;18| |SOLVEFOR;quartic;5FL;20| (67 . |append|)
              |SOLVEFOR;solve;UPL;4| |SOLVEFOR;aLinear;3F;15|
              |SOLVEFOR;aQuadratic;4F;17| |SOLVEFOR;aCubic;5F;19|
              |SOLVEFOR;aQuartic;6F;21| |SOLVEFOR;particularSolution;UPF;5|
              (|Boolean|) (73 . ~=) (79 . |characteristic|)
              |SOLVEFOR;linear;UPL;9| |SOLVEFOR;quadratic;UPL;10|
              |SOLVEFOR;cubic;UPL;11| |SOLVEFOR;quartic;UPL;12| (83 . -)
              (|Union| $ '"failed") (89 . |recip|) (94 . /) (100 . -) (105 . =)
              (|PositiveInteger|) (111 . ^) (117 . *) (123 . +)
              (129 . |coerce|) '|w3|)
           '#(|solve| 134 |quartic| 139 |quadratic| 153 |particularSolution|
              165 |linear| 170 |cubic| 181 |aQuartic| 194 |aQuadratic| 203
              |aLinear| 210 |aCubic| 216)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|solve| ((|List| |#2|) |#1|)) T)
                                   '((|particularSolution| (|#2| |#1|)) T)
                                   '((|linear| ((|List| |#2|) |#1|)) T)
                                   '((|quadratic| ((|List| |#2|) |#1|)) T)
                                   '((|cubic| ((|List| |#2|) |#1|)) T)
                                   '((|quartic| ((|List| |#2|) |#1|)) T)
                                   '((|linear| ((|List| |#2|) |#2| |#2|)) T)
                                   '((|quadratic|
                                      ((|List| |#2|) |#2| |#2| |#2|))
                                     T)
                                   '((|cubic|
                                      ((|List| |#2|) |#2| |#2| |#2| |#2|))
                                     T)
                                   '((|quartic|
                                      ((|List| |#2|) |#2| |#2| |#2| |#2| |#2|))
                                     T)
                                   '((|aLinear| (|#2| |#2| |#2|)) T)
                                   '((|aQuadratic| (|#2| |#2| |#2| |#2|)) T)
                                   '((|aCubic| (|#2| |#2| |#2| |#2| |#2|)) T)
                                   '((|aQuartic|
                                      (|#2| |#2| |#2| |#2| |#2| |#2|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 61
                                            '(2 11 9 7 10 12 0 6 0 13 0 7 0 14
                                              2 16 0 15 15 17 2 7 0 0 16 18 2 7
                                              0 0 0 19 1 6 20 0 21 1 25 24 0 26
                                              2 24 23 0 15 27 1 6 10 0 28 2 6 7
                                              0 10 29 0 6 0 30 0 7 0 31 2 32 0
                                              0 0 37 2 7 44 0 0 45 0 7 10 46 2
                                              7 0 0 0 51 1 7 52 0 53 2 7 0 0 0
                                              54 1 7 0 0 55 2 7 44 0 0 56 2 7 0
                                              0 57 58 2 7 0 57 0 59 2 7 0 0 0
                                              60 1 7 0 15 61 1 0 32 6 38 1 0 32
                                              6 50 5 0 32 7 7 7 7 7 36 1 0 32 6
                                              48 3 0 32 7 7 7 34 1 0 7 6 43 1 0
                                              32 6 47 2 0 32 7 7 33 1 0 32 6 49
                                              4 0 32 7 7 7 7 35 5 0 7 7 7 7 7 7
                                              42 3 0 7 7 7 7 40 2 0 7 7 7 39 4
                                              0 7 7 7 7 7 41)))))
           '|lookupComplete|)) 
