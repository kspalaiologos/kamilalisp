
(SDEFUN |FRIMOD;One;$;1| (($ ($))) (QREFELT $ 10)) 

(PUT '|FRIMOD;module;V$;2| '|SPADreplace| '(XLAM (|v|) |v|)) 

(SDEFUN |FRIMOD;module;V$;2| ((|v| (|Vector| A)) ($ ($))) |v|) 

(PUT '|FRIMOD;basis;$V;3| '|SPADreplace| '(XLAM (|m|) |m|)) 

(SDEFUN |FRIMOD;basis;$V;3| ((|m| ($)) ($ (|Vector| A))) |m|) 

(SDEFUN |FRIMOD;rowdiv| ((|r| (|Vector| R)) (|f| (R)) ($ (|Vector| F)))
        (SPROG ((#1=#:G707 NIL) (#2=#:G709 NIL) (|i| NIL) (#3=#:G708 NIL))
               (SEQ
                (PROGN
                 (LETT #3#
                       (GETREFV
                        (|inc_SI|
                         (- #4=(QVSIZE |r|)
                            #5=(SPADCALL |r| (QREFELT $ 23))))))
                 (SEQ (LETT |i| #5#) (LETT #2# #4#) (LETT #1# 0) G190
                      (COND ((> |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL (SPADCALL |r| |i| (QREFELT $ 24)) |f|
                                          (QREFELT $ 25)))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                      (GO G190) G191 (EXIT NIL))
                 #3#)))) 

(SDEFUN |FRIMOD;coerce;$Of;5| ((|m| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |m| (QREFELT $ 20)) (QREFELT $ 27))) 

(SDEFUN |FRIMOD;W2A| ((|v| (|Vector| F)) ($ (A)))
        (SPADCALL (SPADCALL |v| (|FRIMOD;intmat| $) (QREFELT $ 31))
                  (QREFELT $ 32))) 

(SDEFUN |FRIMOD;wmatrix| ((|v| (|Vector| A)) ($ (|Matrix| F)))
        (SPADCALL (SPADCALL |v| (QREFELT $ 34)) (|FRIMOD;invintmat| $)
                  (QREFELT $ 35))) 

(SDEFUN |FRIMOD;getinvintmat| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G723 NIL) (|j| NIL) (#2=#:G722 NIL) (|i| NIL)
          (|m| (|Matrix| F)) (#3=#:G714 NIL))
         (SEQ
          (LETT |m|
                (PROG2 (LETT #3# (SPADCALL (|FRIMOD;intmat| $) (QREFELT $ 37)))
                    (QCDR #3#)
                  (|check_union2| (QEQCAR #3# 0) (|Matrix| (QREFELT $ 7))
                                  (|Union| (|Matrix| (QREFELT $ 7)) "failed")
                                  #3#)))
          (SEQ (LETT |i| (PROGN |m| 1))
               (LETT #2# (SPADCALL |m| (QREFELT $ 38))) G190
               (COND ((> |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| (PROGN |m| 1))
                      (LETT #1# (SPADCALL |m| (QREFELT $ 39))) G190
                      (COND ((> |j| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL (QREFELT $ 15) |i| |j|
                                  (QAREF2O |m| |i| |j| 1 1) (QREFELT $ 40))))
                      (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT NIL)))) 

(SDEFUN |FRIMOD;getintmat| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G731 NIL) (|j| NIL) (#2=#:G730 NIL) (|i| NIL)
          (|m| (|Matrix| F)))
         (SEQ (LETT |m| (SPADCALL (QREFELT $ 10) (QREFELT $ 34)))
              (SEQ (LETT |i| (PROGN |m| 1))
                   (LETT #2# (SPADCALL |m| (QREFELT $ 38))) G190
                   (COND ((> |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| (PROGN |m| 1))
                          (LETT #1# (SPADCALL |m| (QREFELT $ 39))) G190
                          (COND ((> |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL (QREFELT $ 16) |i| |j|
                                      (QAREF2O |m| |i| |j| 1 1)
                                      (QREFELT $ 40))))
                          (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT NIL)))) 

(SDEFUN |FRIMOD;invintmat| (($ (|Matrix| F)))
        (SEQ (COND ((QREFELT $ 12) (SETELT $ 12 (|FRIMOD;getinvintmat| $))))
             (EXIT (QREFELT $ 15)))) 

(SDEFUN |FRIMOD;intmat| (($ (|Matrix| F)))
        (SEQ (COND ((QREFELT $ 13) (SETELT $ 13 (|FRIMOD;getintmat| $))))
             (EXIT (QREFELT $ 16)))) 

(SDEFUN |FRIMOD;vectProd|
        ((|v1| (|Vector| A)) (|v2| (|Vector| A)) ($ (|Vector| A)))
        (SPROG
         ((|k| (|Integer|)) (#1=#:G745 NIL) (|j| NIL) (#2=#:G744 NIL) (|i| NIL)
          (|v| (|Vector| A)))
         (SEQ
          (LETT |k|
                (SPADCALL
                 (LETT |v|
                       (MAKEARR1 (* (QVSIZE |v1|) (QVSIZE |v2|))
                                 (|spadConstant| $ 41)))
                 (QREFELT $ 42)))
          (SEQ (LETT |i| (SPADCALL |v1| (QREFELT $ 43)))
               (LETT #2# (QVSIZE |v1|)) G190 (COND ((> |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| (SPADCALL |v2| (QREFELT $ 43)))
                      (LETT #1# (QVSIZE |v2|)) G190
                      (COND ((> |j| #1#) (GO G191)))
                      (SEQ
                       (QSETAREF1O |v| |k|
                                   (SPADCALL (QAREF1O |v1| |i| 1)
                                             (QAREF1O |v2| |j| 1)
                                             (QREFELT $ 44))
                                   1)
                       (EXIT (LETT |k| (+ |k| 1))))
                      (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT |v|)))) 

(SDEFUN |FRIMOD;norm;$F;13| ((|m| ($)) ($ (F)))
        (COND
         ((SPADCALL (QVSIZE (SPADCALL |m| (QREFELT $ 20)))
                    (QVSIZE (QREFELT $ 10)) (QREFELT $ 48))
          (|error| "Module not of rank n"))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL (SPADCALL |m| (QREFELT $ 20)) (QREFELT $ 34))
                     (|FRIMOD;invintmat| $) (QREFELT $ 35))
           (QREFELT $ 49))))) 

(SDEFUN |FRIMOD;*;3$;14| ((|m1| ($)) (|m2| ($)) ($ ($)))
        (SPROG
         ((|u| (A)) (#1=#:G754 NIL) (|i| NIL) (#2=#:G753 NIL)
          (|m| (|Matrix| R))
          (|cd| (|Record| (|:| |num| (|Matrix| R)) (|:| |den| R))))
         (SEQ
          (LETT |m|
                (SPADCALL
                 (QCAR
                  (LETT |cd|
                        (SPADCALL
                         (|FRIMOD;wmatrix|
                          (|FRIMOD;vectProd| (SPADCALL |m1| (QREFELT $ 20))
                           (SPADCALL |m2| (QREFELT $ 20)) $)
                          $)
                         (QREFELT $ 53))))
                 (QREFELT $ 56)))
          (EXIT
           (SPADCALL
            (LIST2VEC
             (PROGN
              (LETT #2# NIL)
              (SEQ (LETT |i| (PROGN |m| 1))
                   (LETT #1# (SPADCALL |m| (QREFELT $ 57))) G190
                   (COND ((> |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL
                        (LETT |u|
                              (|FRIMOD;W2A|
                               (|FRIMOD;rowdiv|
                                (SPADCALL |m| |i| (QREFELT $ 58)) (QCDR |cd|)
                                $)
                               $))
                        (|spadConstant| $ 41) (QREFELT $ 59))
                       (LETT #2# (CONS |u| #2#))))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT (NREVERSE #2#)))))
            (QREFELT $ 19)))))) 

(SDEFUN |FRIMOD;module;Fi$;15| ((|i| (|FractionalIdeal| R F UP A)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |i| (QREFELT $ 62)) (QREFELT $ 19))
                  (SPADCALL (QREFELT $ 10) (QREFELT $ 19)) (QREFELT $ 60))) 

(DECLAIM (NOTINLINE |FractionalIdealAsModule;|)) 

(DEFUN |FractionalIdealAsModule| (&REST #1=#:G756)
  (SPROG NIL
         (PROG (#2=#:G757)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T T T NIL))
                     (HGET |$ConstructorCache| '|FractionalIdealAsModule|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FractionalIdealAsModule;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FractionalIdealAsModule|)))))))))) 

(DEFUN |FractionalIdealAsModule;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 |#5|)
    (LETT |dv$| (LIST '|FractionalIdealAsModule| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 68))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#4|
                                                       (LIST '|RetractableTo|
                                                             (|devaluate|
                                                              |#2|)))))))
    (|haddProp| |$ConstructorCache| '|FractionalIdealAsModule|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 11 (|Vector| |#4|))
    (QSETREFV $ 12 'T)
    (QSETREFV $ 13 'T)
    (QSETREFV $ 15
              (MAKE_MATRIX1 (QVSIZE |#5|) (QVSIZE |#5|) (|spadConstant| $ 14)))
    (QSETREFV $ 16
              (MAKE_MATRIX1 (QVSIZE |#5|) (QVSIZE |#5|) (|spadConstant| $ 14)))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 63 (CONS (|dispatchFunction| |FRIMOD;module;Fi$;15|) $))))
    $))) 

(MAKEPROP '|FractionalIdealAsModule| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) '|Rep| '|iflag?|
              '|wflag?| (0 . |Zero|) '|imat| '|wmat|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FRIMOD;One;$;1|) $))
              (|Vector| 9) |FRIMOD;module;V$;2| |FRIMOD;basis;$V;3| (|Integer|)
              (|Vector| 6) (4 . |minIndex|) (9 . |elt|) (15 . /) (|OutputForm|)
              (21 . |coerce|) |FRIMOD;coerce;$Of;5| (|Vector| 7) (|Matrix| 7)
              (26 . *) (32 . |represents|) (|Vector| $) (37 . |coordinates|)
              (42 . *) (|Union| $ '"failed") (48 . |inverse|)
              (53 . |maxRowIndex|) (58 . |maxColIndex|) (63 . |setelt!|)
              (71 . |Zero|) (75 . |minIndex|) (80 . |minIndex|) (85 . *)
              (91 . |One|) (|Boolean|) (|NonNegativeInteger|) (95 . ~=)
              (101 . |determinant|) |FRIMOD;norm;$F;13|
              (|Record| (|:| |num| 54) (|:| |den| 6))
              (|MatrixCommonDenominator| 6 7) (106 . |splitDenominator|)
              (|Matrix| 6) (|ModularHermitianRowReduction| 6) (111 . |rowEch|)
              (116 . |maxRowIndex|) (121 . |row|) (127 . ~=) |FRIMOD;*;3$;14|
              (|FractionalIdeal| 6 7 8 9) (133 . |basis|) (138 . |module|)
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 143 |sample| 149 |rightRecip| 153 |rightPower| 158 |recip| 170
              |one?| 175 |norm| 180 |module| 185 |leftRecip| 195 |leftPower|
              200 |latex| 212 |hashUpdate!| 217 |hash| 223 |coerce| 228 |basis|
              233 ^ 238 |One| 250 = 254 * 260)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL NIL |MagmaWithUnit&| |Magma&| |SetCategory&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|Monoid|) (|SemiGroup|) (|MagmaWithUnit|) (|Magma|)
                      (|SetCategory|) (|BasicType|) (|CoercibleTo| 26))
                   (|makeByteWordVec2| 67
                                       '(0 7 0 14 1 22 21 0 23 2 22 6 0 21 24 2
                                         7 0 6 6 25 1 18 26 0 27 2 30 29 29 0
                                         31 1 9 0 29 32 1 9 30 33 34 2 30 0 0 0
                                         35 1 30 36 0 37 1 30 21 0 38 1 30 21 0
                                         39 4 30 7 0 21 21 7 40 0 9 0 41 1 18
                                         21 0 42 1 11 21 0 43 2 9 0 0 0 44 0 9
                                         0 45 2 47 46 0 0 48 1 30 7 0 49 1 52
                                         51 30 53 1 55 54 54 56 1 54 21 0 57 2
                                         54 22 0 21 58 2 9 46 0 0 59 1 61 18 0
                                         62 1 0 0 61 63 2 0 46 0 0 1 0 0 0 1 1
                                         0 36 0 1 2 0 0 0 47 1 2 0 0 0 64 1 1 0
                                         36 0 1 1 0 46 0 1 1 0 7 0 50 1 1 0 61
                                         63 1 0 0 18 19 1 0 36 0 1 2 0 0 0 47 1
                                         2 0 0 0 64 1 1 0 65 0 1 2 0 67 67 0 1
                                         1 0 66 0 1 1 0 26 0 28 1 0 18 0 20 2 0
                                         0 0 47 1 2 0 0 0 64 1 0 0 0 17 2 0 46
                                         0 0 1 2 0 0 0 0 60)))))
           '|lookupComplete|)) 
