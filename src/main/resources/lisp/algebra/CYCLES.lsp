
(SDEFUN |CYCLES;trm|
        ((|pt| (|Partition|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |pt| (QREFELT $ 8)) (QREFELT $ 10))
                   (QREFELT $ 11))
         |pt| (QREFELT $ 13))) 

(SDEFUN |CYCLES;list|
        ((|st| (|Stream| (|List| (|Integer|))))
         ($ (|List| (|List| (|Integer|)))))
        (SPADCALL (SPADCALL |st| (QREFELT $ 15)) (QREFELT $ 17))) 

(SDEFUN |CYCLES;sorted_partitions|
        ((|i| (|Integer|)) ($ (|List| (|Partition|))))
        (SPROG
         ((|lp| (|List| (|Partition|))) (|lli| (|List| (|List| (|Integer|)))))
         (SEQ (LETT |lli| (|CYCLES;list| (SPADCALL |i| (QREFELT $ 19)) $))
              (LETT |lp| (SPADCALL (ELT $ 21) |lli| (QREFELT $ 25)))
              (EXIT (SPADCALL (REVERSE |lp|) (QREFELT $ 26)))))) 

(SDEFUN |CYCLES;complete;ISp;4|
        ((|i| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((#1=#:G719 NIL)
          (#2=#:G718 #3=(|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (#4=#:G720 #3#) (#5=#:G722 NIL) (|pt| NIL))
         (SEQ
          (COND ((EQL |i| 0) (|spadConstant| $ 29))
                ((< |i| 0) (|spadConstant| $ 28))
                (#6='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |pt| NIL)
                       (LETT #5# (|CYCLES;sorted_partitions| |i| $)) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |pt| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# (|CYCLES;trm| |pt| $))
                          (COND
                           (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 30))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#6# (|spadConstant| $ 28))))))))) 

(SDEFUN |CYCLES;even?| ((|li| (|List| #1=(|Integer|))) ($ (|Boolean|)))
        (SPROG ((|le| (|List| #1#)) (#2=#:G728 NIL) (|i| NIL) (#3=#:G727 NIL))
               (SEQ
                (LETT |le|
                      (PROGN
                       (LETT #3# NIL)
                       (SEQ (LETT |i| NIL) (LETT #2# |li|) G190
                            (COND
                             ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND ((EVENP |i|) (LETT #3# (CONS |i| #3#))))))
                            (LETT #2# (CDR #2#)) (GO G190) G191
                            (EXIT (NREVERSE #3#)))))
                (EXIT (EVENP (LENGTH |le|)))))) 

(SDEFUN |CYCLES;alternating;ISp;6|
        ((|i| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((#1=#:G732 NIL)
          (#2=#:G731 #3=(|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (#4=#:G733 #3#) (#5=#:G735 NIL) (|pt| NIL))
         (SEQ
          (SPADCALL 2
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |pt| NIL)
                          (LETT #5# (|CYCLES;sorted_partitions| |i| $)) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |pt| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((|CYCLES;even?| (SPADCALL |pt| (QREFELT $ 32)) $)
                              (PROGN
                               (LETT #4# (|CYCLES;trm| |pt| $))
                               (COND
                                (#1#
                                 (LETT #2# (SPADCALL #2# #4# (QREFELT $ 30))))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T (|spadConstant| $ 28))))
                    (QREFELT $ 34))))) 

(SDEFUN |CYCLES;elementary;ISp;7|
        ((|i| (|Integer|))
         ($ #1=(|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((#2=#:G737 NIL) (#3=#:G736 #1#) (#4=#:G738 #1#)
          (|spol| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (#5=#:G741 NIL) (|pt| NIL))
         (SEQ
          (COND ((EQL |i| 0) (|spadConstant| $ 29))
                ((< |i| 0) (|spadConstant| $ 28))
                (#6='T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |pt| NIL)
                       (LETT #5# (|CYCLES;sorted_partitions| |i| $)) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |pt| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4#
                                (SEQ (LETT |spol| (|CYCLES;trm| |pt| $))
                                     (EXIT
                                      (COND
                                       ((|CYCLES;even?|
                                         (SPADCALL |pt| (QREFELT $ 32)) $)
                                        |spol|)
                                       ('T
                                        (SPADCALL |spol| (QREFELT $ 36)))))))
                          (COND
                           (#2# (LETT #3# (SPADCALL #3# #4# (QREFELT $ 30))))
                           ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#2# #3#) (#6# (|spadConstant| $ 28))))))))) 

(SDEFUN |CYCLES;divisors| ((|n| (|Integer|)) ($ (|List| (|Integer|))))
        (SPROG
         ((|c| (|List| (|Integer|))) (#1=#:G753 NIL)
          (#2=#:G752 #3=(|List| (|Integer|))) (#4=#:G754 #3#) (#5=#:G764 NIL)
          (|j| NIL) (#6=#:G763 NIL) (#7=#:G762 NIL) (|a| NIL)
          (|b|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|Integer|))
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (LETT |b| (SPADCALL (SPADCALL |n| (QREFELT $ 39)) (QREFELT $ 44)))
          (LETT |c|
                (CONS 1
                      (PROGN
                       (LETT #1# NIL)
                       (SEQ (LETT |a| NIL) (LETT #7# |b|) G190
                            (COND
                             ((OR (ATOM #7#) (PROGN (LETT |a| (CAR #7#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (PROGN
                               (LETT #4#
                                     (PROGN
                                      (LETT #6# NIL)
                                      (SEQ (LETT |j| 1)
                                           (LETT #5# (QVELT |a| 2)) G190
                                           (COND
                                            ((|greater_SI| |j| #5#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #6#
                                                   (CONS
                                                    (EXPT (QVELT |a| 1) |j|)
                                                    #6#))))
                                           (LETT |j| (|inc_SI| |j|)) (GO G190)
                                           G191 (EXIT (NREVERSE #6#)))))
                               (COND
                                (#1#
                                 (LETT #2# (SPADCALL #2# #4# (QREFELT $ 46))))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                            (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                       (COND (#1# #2#) (#8='T NIL)))))
          (EXIT (COND ((EQL (LENGTH |b|) 1) |c|) (#8# (CONS |n| |c|))))))) 

(SDEFUN |CYCLES;ss|
        ((|n| (|Integer|)) (|m| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|li| (|List| (|Integer|))) (#1=#:G770 NIL) (|j| NIL)
          (#2=#:G769 NIL))
         (SEQ
          (LETT |li|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |j| 1) (LETT #1# |m|) G190
                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS |n| #2#))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (SPADCALL (|spadConstant| $ 47) (SPADCALL |li| (QREFELT $ 21))
                     (QREFELT $ 13)))))) 

(SDEFUN |CYCLES;powerSum;ISp;10|
        ((|n| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (|CYCLES;ss| |n| 1 $)) 

(SDEFUN |CYCLES;cyclic;ISp;11|
        ((|n| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((#1=#:G773 NIL)
          (#2=#:G772 #3=(|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (#4=#:G774 #3#) (#5=#:G776 NIL) (|i| NIL))
         (SEQ
          (COND ((EQL |n| 1) (SPADCALL 1 (QREFELT $ 48)))
                (#6='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |i| NIL) (LETT #5# (|CYCLES;divisors| |n| $)) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4#
                                (SPADCALL
                                 (SPADCALL (SPADCALL |i| (QREFELT $ 50)) |n|
                                           (QREFELT $ 51))
                                 (|CYCLES;ss| |i|
                                  (SPADCALL (SPADCALL |n| |i| (QREFELT $ 51))
                                            (QREFELT $ 52))
                                  $)
                                 (QREFELT $ 53)))
                          (COND
                           (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 30))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#6# (|spadConstant| $ 28))))))))) 

(SDEFUN |CYCLES;dihedral;ISp;12|
        ((|n| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG ((|k| (|Integer|)))
               (SEQ (LETT |k| (QUOTIENT2 |n| 2))
                    (EXIT
                     (COND
                      ((ODDP |n|)
                       (SPADCALL
                        (SPADCALL (SPADCALL 1 2 (QREFELT $ 51))
                                  (SPADCALL |n| (QREFELT $ 54)) (QREFELT $ 53))
                        (SPADCALL
                         (SPADCALL (SPADCALL 1 2 (QREFELT $ 51))
                                   (|CYCLES;ss| 2 |k| $) (QREFELT $ 53))
                         (SPADCALL 1 (QREFELT $ 48)) (QREFELT $ 55))
                        (QREFELT $ 30)))
                      ('T
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL 1 2 (QREFELT $ 51))
                                   (SPADCALL |n| (QREFELT $ 54))
                                   (QREFELT $ 53))
                         (SPADCALL (SPADCALL 1 4 (QREFELT $ 51))
                                   (|CYCLES;ss| 2 |k| $) (QREFELT $ 53))
                         (QREFELT $ 30))
                        (SPADCALL
                         (SPADCALL (SPADCALL 1 4 (QREFELT $ 51))
                                   (|CYCLES;ss| 2 (- |k| 1) $) (QREFELT $ 53))
                         (|CYCLES;ss| 1 2 $) (QREFELT $ 55))
                        (QREFELT $ 30)))))))) 

(SDEFUN |CYCLES;trm2|
        ((|li| (|List| (|Integer|)))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|prod| #1=(|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (|prod2| #1#) (|pp1| (|Integer|)) (|r1| #2=(|Integer|))
          (|r0| #3=(|Integer|)) (#4=#:G791 NIL) (|r| NIL)
          (|c| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (|qq1| #5=(|Integer|)) (|k| #5#) (|ll1| #2#) (|ll0| #3#)
          (#6=#:G790 NIL) (|ll| NIL) (|xx| (|Fraction| (|Integer|)))
          (|lli| (|List| (|List| (|Integer|)))))
         (SEQ (LETT |lli| (SPADCALL |li| (QREFELT $ 57)))
              (LETT |xx|
                    (SPADCALL 1
                              (SPADCALL (SPADCALL |li| (QREFELT $ 21))
                                        (QREFELT $ 8))
                              (QREFELT $ 51)))
              (LETT |prod| (|spadConstant| $ 29))
              (SEQ (LETT |ll| NIL) (LETT #6# |lli|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |ll| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ll0| (|SPADfirst| |ll|))
                        (LETT |ll1| (SPADCALL |ll| (QREFELT $ 58)))
                        (LETT |k| (QUOTIENT2 |ll0| 2))
                        (LETT |c|
                              (COND
                               ((ODDP |ll0|)
                                (|CYCLES;ss| |ll0| (* |ll1| |k|) $))
                               ('T
                                (SPADCALL (|CYCLES;ss| |k| |ll1| $)
                                          (|CYCLES;ss| |ll0|
                                           (* |ll1| (- |k| 1)) $)
                                          (QREFELT $ 55)))))
                        (LETT |qq1| (QUOTIENT2 (* |ll1| (- |ll1| 1)) 2))
                        (LETT |c|
                              (SPADCALL |c|
                                        (|CYCLES;ss| |ll0| (* |ll0| |qq1|) $)
                                        (QREFELT $ 55)))
                        (LETT |prod2| (|spadConstant| $ 29))
                        (SEQ (LETT |r| NIL) (LETT #4# |lli|) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |r| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((< (|SPADfirst| |r|) |ll0|)
                                 (SEQ (LETT |r0| (|SPADfirst| |r|))
                                      (LETT |r1| (SPADCALL |r| (QREFELT $ 58)))
                                      (LETT |pp1|
                                            (* (* (GCD |r0| |ll0|) |r1|)
                                               |ll1|))
                                      (EXIT
                                       (LETT |prod2|
                                             (SPADCALL
                                              (|CYCLES;ss|
                                               (SPADCALL |r0| |ll0|
                                                         (QREFELT $ 59))
                                               |pp1| $)
                                              |prod2| (QREFELT $ 55)))))))))
                             (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |prod|
                               (SPADCALL (SPADCALL |c| |prod2| (QREFELT $ 55))
                                         |prod| (QREFELT $ 55)))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |xx| |prod| (QREFELT $ 53)))))) 

(SDEFUN |CYCLES;graphs;ISp;14|
        ((|n| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((#1=#:G793 NIL)
          (#2=#:G792 #3=(|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (#4=#:G794 #3#) (#5=#:G796 NIL) (|li| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |li| NIL)
                (LETT #5# (|CYCLES;list| (SPADCALL |n| (QREFELT $ 19)) $)) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |li| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (|CYCLES;trm2| |li| $))
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 30))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 28))))))) 

(SDEFUN |CYCLES;cupp|
        ((|pt| (|Partition|))
         (|spol| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG ((|dg| (|Partition|)))
               (SEQ
                (COND ((SPADCALL |spol| (QREFELT $ 62)) (|spadConstant| $ 28))
                      (#1='T
                       (SEQ (LETT |dg| (SPADCALL |spol| (QREFELT $ 63)))
                            (EXIT
                             (COND
                              ((SPADCALL |dg| |pt| (QREFELT $ 64))
                               (|spadConstant| $ 28))
                              ((SPADCALL |dg| |pt| (QREFELT $ 65))
                               (SPADCALL (SPADCALL |pt| (QREFELT $ 8))
                                         (SPADCALL
                                          (SPADCALL |spol| (QREFELT $ 66)) |dg|
                                          (QREFELT $ 13))
                                         (QREFELT $ 67)))
                              (#1#
                               (|CYCLES;cupp| |pt|
                                (SPADCALL |spol| (QREFELT $ 68)) $)))))))))) 

(SDEFUN |CYCLES;cup;3Sp;16|
        ((|spol1| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         (|spol2| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG ((|p| (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
               (SEQ
                (COND ((SPADCALL |spol1| (QREFELT $ 62)) (|spadConstant| $ 28))
                      ('T
                       (SEQ
                        (LETT |p|
                              (SPADCALL (SPADCALL |spol1| (QREFELT $ 66))
                                        (|CYCLES;cupp|
                                         (SPADCALL |spol1| (QREFELT $ 63))
                                         |spol2| $)
                                        (QREFELT $ 53)))
                        (EXIT
                         (SPADCALL |p|
                                   (SPADCALL (SPADCALL |spol1| (QREFELT $ 68))
                                             |spol2| (QREFELT $ 69))
                                   (QREFELT $ 30))))))))) 

(SDEFUN |CYCLES;eval;SpF;17|
        ((|spol| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|Fraction| (|Integer|))))
        (COND ((SPADCALL |spol| (QREFELT $ 62)) (|spadConstant| $ 70))
              ('T
               (SPADCALL (SPADCALL |spol| (QREFELT $ 66))
                         (SPADCALL (SPADCALL |spol| (QREFELT $ 68))
                                   (QREFELT $ 71))
                         (QREFELT $ 72))))) 

(SDEFUN |CYCLES;cap;2SpF;18|
        ((|spol1| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         (|spol2| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL |spol1| |spol2| (QREFELT $ 69)) (QREFELT $ 71))) 

(SDEFUN |CYCLES;mtpol|
        ((|n| (|Integer|))
         (|spol| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|deg| (|Partition|)) (#1=#:G812 NIL) (|k| NIL) (#2=#:G811 NIL))
         (SEQ
          (COND ((SPADCALL |spol| (QREFELT $ 62)) (|spadConstant| $ 28))
                ('T
                 (SEQ
                  (LETT |deg|
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |k| NIL)
                               (LETT #1#
                                     (SPADCALL (SPADCALL |spol| (QREFELT $ 63))
                                               (QREFELT $ 32)))
                               G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |k| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ (EXIT (LETT #2# (CONS (* |n| |k|) #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 21)))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL |spol| (QREFELT $ 66)) |deg|
                              (QREFELT $ 13))
                    (|CYCLES;mtpol| |n| (SPADCALL |spol| (QREFELT $ 68)) $)
                    (QREFELT $ 30))))))))) 

(SDEFUN |CYCLES;evspol|
        ((|fn2|
          (|Mapping| (|SymmetricPolynomial| (|Fraction| (|Integer|)))
                     (|Integer|)))
         (|spol| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|prod| #1=(|SymmetricPolynomial| (|Fraction| (|Integer|))))
          (#2=#:G814 NIL) (#3=#:G813 #1#) (#4=#:G815 #1#) (#5=#:G820 NIL)
          (|i| NIL) (|lc| (|Fraction| (|Integer|))))
         (SEQ
          (COND ((SPADCALL |spol| (QREFELT $ 62)) (|spadConstant| $ 28))
                (#6='T
                 (SEQ (LETT |lc| (SPADCALL |spol| (QREFELT $ 66)))
                      (LETT |prod|
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |i| NIL)
                                  (LETT #5#
                                        (SPADCALL
                                         (SPADCALL |spol| (QREFELT $ 63))
                                         (QREFELT $ 32)))
                                  G190
                                  (COND
                                   ((OR (ATOM #5#)
                                        (PROGN (LETT |i| (CAR #5#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #4# (SPADCALL |i| |fn2|))
                                     (COND
                                      (#2#
                                       (LETT #3#
                                             (SPADCALL #3# #4#
                                                       (QREFELT $ 55))))
                                      ('T
                                       (PROGN
                                        (LETT #3# #4#)
                                        (LETT #2# 'T)))))))
                                  (LETT #5# (CDR #5#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#2# #3#) (#6# (|spadConstant| $ 29)))))
                      (EXIT
                       (SPADCALL (SPADCALL |lc| |prod| (QREFELT $ 53))
                                 (|CYCLES;evspol| |fn2|
                                  (SPADCALL |spol| (QREFELT $ 68)) $)
                                 (QREFELT $ 30))))))))) 

(SDEFUN |CYCLES;wreath;3Sp;21|
        ((|spol1| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         (|spol2| (|SymmetricPolynomial| (|Fraction| (|Integer|))))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG NIL
               (|CYCLES;evspol|
                (CONS #'|CYCLES;wreath;3Sp;21!0| (VECTOR $ |spol2|)) |spol1|
                $))) 

(SDEFUN |CYCLES;wreath;3Sp;21!0| ((|x| NIL) ($$ NIL))
        (PROG (|spol2| $)
          (LETT |spol2| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|CYCLES;mtpol| |x| |spol2| $))))) 

(SDEFUN |CYCLES;hh|
        ((|n| (|Integer|))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (COND ((EQL |n| 0) (|spadConstant| $ 29))
              ((< |n| 0) (|spadConstant| $ 28))
              ('T (SPADCALL |n| (QREFELT $ 31))))) 

(SDEFUN |CYCLES;SFunction;LSp;23|
        ((|li| (|List| (|Integer|)))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|a| (|Matrix| (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
          (#1=#:G834 NIL) (|k| NIL) (#2=#:G835 NIL) (|j| NIL) (#3=#:G833 NIL)
          (#4=#:G832 NIL) (|i| NIL) (#5=#:G831 NIL))
         (SEQ
          (LETT |a|
                (SPADCALL
                 (PROGN
                  (LETT #5# NIL)
                  (SEQ (LETT |i| 1) (LETT #4# (LENGTH |li|)) G190
                       (COND ((|greater_SI| |i| #4#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #5#
                               (CONS
                                (PROGN
                                 (LETT #3# NIL)
                                 (SEQ (LETT |j| 1) (LETT #2# (LENGTH |li|))
                                      (LETT |k| NIL) (LETT #1# |li|) G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |k| (CAR #1#)) NIL)
                                            (|greater_SI| |j| #2#))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #3#
                                              (CONS
                                               (|CYCLES;hh| (+ (- |k| |j|) |i|)
                                                $)
                                               #3#))))
                                      (LETT #1#
                                            (PROG1 (CDR #1#)
                                              (LETT |j| (|inc_SI| |j|))))
                                      (GO G190) G191 (EXIT (NREVERSE #3#))))
                                #5#))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                       (EXIT (NREVERSE #5#))))
                 (QREFELT $ 77)))
          (EXIT (SPADCALL |a| (QREFELT $ 78)))))) 

(SDEFUN |CYCLES;roundup|
        ((|li1| (|List| (|Integer|))) (|li2| (|List| (|Integer|)))
         ($ (|List| (|Integer|))))
        (COND
         ((> (LENGTH |li1|) (LENGTH |li2|))
          (|CYCLES;roundup| |li1| (SPADCALL |li2| 0 (QREFELT $ 80)) $))
         ('T |li2|))) 

(SDEFUN |CYCLES;skewSFunction;2LSp;25|
        ((|li1| (|List| (|Integer|))) (|li2| (|List| (|Integer|)))
         ($ (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|a| (|Matrix| (|SymmetricPolynomial| (|Fraction| (|Integer|)))))
          (#1=#:G856 NIL) (|k| NIL) (#2=#:G857 NIL) (|j| NIL) (#3=#:G855 NIL)
          (#4=#:G854 NIL) (|i| NIL) (#5=#:G853 NIL))
         (SEQ
          (COND
           ((< (LENGTH |li1|) (LENGTH |li2|))
            (|error| "skewSFunction: partition1 does not include partition2"))
           ('T
            (SEQ (LETT |li2| (|CYCLES;roundup| |li1| |li2| $))
                 (LETT |a|
                       (SPADCALL
                        (PROGN
                         (LETT #5# NIL)
                         (SEQ (LETT |i| 1) (LETT #4# (LENGTH |li1|)) G190
                              (COND ((|greater_SI| |i| #4#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #5#
                                      (CONS
                                       (PROGN
                                        (LETT #3# NIL)
                                        (SEQ (LETT |j| 1)
                                             (LETT #2# (LENGTH |li1|))
                                             (LETT |k| NIL) (LETT #1# |li1|)
                                             G190
                                             (COND
                                              ((OR (ATOM #1#)
                                                   (PROGN
                                                    (LETT |k| (CAR #1#))
                                                    NIL)
                                                   (|greater_SI| |j| #2#))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #3#
                                                     (CONS
                                                      (|CYCLES;hh|
                                                       (+
                                                        (-
                                                         (- |k|
                                                            (SPADCALL |li2| |i|
                                                                      (QREFELT
                                                                       $ 81)))
                                                         |j|)
                                                        |i|)
                                                       $)
                                                      #3#))))
                                             (LETT #1#
                                                   (PROG1 (CDR #1#)
                                                     (LETT |j|
                                                           (|inc_SI| |j|))))
                                             (GO G190) G191
                                             (EXIT (NREVERSE #3#))))
                                       #5#))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #5#))))
                        (QREFELT $ 77)))
                 (EXIT (SPADCALL |a| (QREFELT $ 78))))))))) 

(DECLAIM (NOTINLINE |CycleIndicators;|)) 

(DEFUN |CycleIndicators| ()
  (SPROG NIL
         (PROG (#1=#:G859)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|CycleIndicators|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|CycleIndicators|
                             (LIST (CONS NIL (CONS 1 (|CycleIndicators;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|CycleIndicators|)))))))))) 

(DEFUN |CycleIndicators;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|CycleIndicators|))
          (LETT $ (GETREFV 83))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CycleIndicators| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| (|SymmetricPolynomial| (|Fraction| (|Integer|)))
                           '(|CommutativeRing|))
            (PROGN
             (QSETREFV $ 79
                       (CONS (|dispatchFunction| |CYCLES;SFunction;LSp;23|) $))
             NIL
             (QSETREFV $ 82
                       (CONS
                        (|dispatchFunction| |CYCLES;skewSFunction;2LSp;25|)
                        $)))))
          $))) 

(MAKEPROP '|CycleIndicators| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) (|Partition|) (0 . |pdct|)
              (|Fraction| 6) (5 . |coerce|) (10 . |inv|)
              (|SymmetricPolynomial| 9) (15 . |monomial|) (|Stream| 20)
              (21 . |complete|) (|List| 20) (26 . |entries|)
              (|PartitionsAndPermutations|) (31 . |partitions|) (|List| 6)
              (36 . |partition|) (|List| 7) (|Mapping| 7 20)
              (|ListFunctions2| 20 7) (41 . |map|) (47 . |sort|) (52 . |Zero|)
              (56 . |Zero|) (60 . |One|) (64 . +) |CYCLES;complete;ISp;4|
              (70 . |coerce|) (|PositiveInteger|) (75 . *)
              |CYCLES;alternating;ISp;6| (81 . -) |CYCLES;elementary;ISp;7|
              (|Factored| $) (86 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 40) (|:| |factor| 6)
                        (|:| |exponent| (|NonNegativeInteger|)))
              (|List| 41) (|Factored| 6) (91 . |factorList|) (96 . |One|)
              (100 . |append|) (106 . |One|) |CYCLES;powerSum;ISp;10|
              (|IntegerNumberTheoryFunctions|) (110 . |eulerPhi|) (115 . /)
              (121 . |numer|) (126 . *) |CYCLES;cyclic;ISp;11| (132 . *)
              |CYCLES;dihedral;ISp;12| (138 . |powers|) (143 . |second|)
              (148 . |lcm|) |CYCLES;graphs;ISp;14| (|Boolean|) (154 . |zero?|)
              (159 . |degree|) (164 . <) (170 . =) (176 . |leadingCoefficient|)
              (181 . *) (187 . |reductum|) |CYCLES;cup;3Sp;16| (192 . |Zero|)
              |CYCLES;eval;SpF;17| (196 . +) |CYCLES;cap;2SpF;18|
              |CYCLES;wreath;3Sp;21| (|List| (|List| 12)) (|Matrix| 12)
              (202 . |matrix|) (207 . |determinant|) (212 . |SFunction|)
              (217 . |concat|) (223 . |elt|) (229 . |skewSFunction|))
           '#(|wreath| 235 |skewSFunction| 241 |powerSum| 247 |graphs| 252
              |eval| 257 |elementary| 262 |dihedral| 267 |cyclic| 272 |cup| 277
              |complete| 283 |cap| 288 |alternating| 294 |SFunction| 299)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|complete|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|powerSum|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|elementary|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|alternating|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|cyclic|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|dihedral|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|graphs|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|cap|
                                 ((|Fraction| (|Integer|))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))))
                                T)
                              '((|cup|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))))
                                T)
                              '((|eval|
                                 ((|Fraction| (|Integer|))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))))
                                T)
                              '((|wreath|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))))
                                T)
                              '((|SFunction|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|List| (|Integer|))))
                                T)
                              '((|skewSFunction|
                                 ((|SymmetricPolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|List| (|Integer|)) (|List| (|Integer|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 82
                                            '(1 7 6 0 8 1 9 0 6 10 1 9 0 0 11 2
                                              12 0 9 7 13 1 14 0 0 15 1 14 16 0
                                              17 1 18 14 6 19 1 7 0 20 21 2 24
                                              22 23 16 25 1 22 0 0 26 0 7 0 27
                                              0 12 0 28 0 12 0 29 2 12 0 0 0 30
                                              1 7 20 0 32 2 12 0 33 0 34 1 12 0
                                              0 36 1 6 38 0 39 1 43 42 0 44 0
                                              43 0 45 2 20 0 0 0 46 0 9 0 47 1
                                              49 6 6 50 2 9 0 6 6 51 1 9 6 0 52
                                              2 12 0 9 0 53 2 12 0 0 0 55 1 7
                                              16 20 57 1 20 6 0 58 2 6 0 0 0 59
                                              1 12 61 0 62 1 12 7 0 63 2 7 61 0
                                              0 64 2 7 61 0 0 65 1 12 9 0 66 2
                                              12 0 6 0 67 1 12 0 0 68 0 9 0 70
                                              2 9 0 0 0 72 1 76 0 75 77 1 76 12
                                              0 78 1 0 12 20 79 2 20 0 0 6 80 2
                                              20 6 0 6 81 2 0 12 20 20 82 2 0
                                              12 12 12 74 2 0 12 20 20 82 1 0
                                              12 6 48 1 0 12 6 60 1 0 9 12 71 1
                                              0 12 6 37 1 0 12 6 56 1 0 12 6 54
                                              2 0 12 12 12 69 1 0 12 6 31 2 0 9
                                              12 12 73 1 0 12 6 35 1 0 12 20
                                              79)))))
           '|lookupComplete|)) 

(MAKEPROP '|CycleIndicators| 'NILADIC T) 
