
(SDEFUN |LUD;LUDecomp;MR;1|
        ((AA (|Matrix| D))
         ($
          (|Record| (|:| LU (|Matrix| D)) (|:| |Perm| (|Vector| (|Integer|)))
                    (|:| |Pivots| (|List| D)))))
        (SPROG
         ((#1=#:G736 NIL) (|k| NIL) (|d| (D)) (|Pivs| (|List| D))
          (|i0| (|Integer|)) (|s| (D)) (#2=#:G735 NIL) (#3=#:G734 NIL)
          (|i| NIL) (#4=#:G733 NIL) (#5=#:G732 NIL) (#6=#:G731 NIL) (|j| NIL)
          (|PermV| (|Vector| (|Integer|))) (#7=#:G701 NIL) (|maxC| (|Integer|))
          (|minC| (|Integer|)) (|maxR| (|Integer|)) (|minR| (|Integer|))
          (A (|Matrix| D)))
         (SEQ (LETT A (SPADCALL AA (QREFELT $ 8))) (LETT |minR| (PROGN A 1))
              (LETT |maxR| (SPADCALL A (QREFELT $ 10)))
              (LETT |minC| (PROGN A 1))
              (LETT |maxC| (SPADCALL A (QREFELT $ 11)))
              (EXIT
               (COND
                ((SPADCALL |maxR| |maxC| (QREFELT $ 13))
                 (|error| "LU decomposition only of square matrices"))
                ('T
                 (SEQ
                  (LETT |PermV|
                        (MAKEARR1
                         (PROG1 (LETT #7# (+ (- |maxR| |minR|) 1))
                           (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #7#))
                         0))
                  (LETT |Pivs| NIL)
                  (SEQ (LETT |j| |minC|) (LETT #6# |maxC|) G190
                       (COND ((> |j| #6#) (GO G191)))
                       (SEQ
                        (SEQ (LETT |i| |minR|) (LETT #5# (- |j| 1)) G190
                             (COND ((> |i| #5#) (GO G191)))
                             (SEQ (LETT |s| (QAREF2O A |i| |j| 1 1))
                                  (SEQ (LETT |k| |minR|) (LETT #4# (- |i| 1))
                                       G190 (COND ((> |k| #4#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT |s|
                                               (SPADCALL |s|
                                                         (SPADCALL
                                                          (QAREF2O A |i| |k| 1
                                                                   1)
                                                          (QAREF2O A |k| |j| 1
                                                                   1)
                                                          (QREFELT $ 15))
                                                         (QREFELT $ 16)))))
                                       (LETT |k| (+ |k| 1)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT (QSETAREF2O A |i| |j| |s| 1 1)))
                             (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                        (LETT |i0| -1)
                        (SEQ (LETT |i| |j|) (LETT #3# |maxR|) G190
                             (COND ((> |i| #3#) (GO G191)))
                             (SEQ (LETT |s| (QAREF2O A |i| |j| 1 1))
                                  (SEQ (LETT |k| |minC|) (LETT #2# (- |j| 1))
                                       G190 (COND ((> |k| #2#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT |s|
                                               (SPADCALL |s|
                                                         (SPADCALL
                                                          (QAREF2O A |i| |k| 1
                                                                   1)
                                                          (QAREF2O A |k| |j| 1
                                                                   1)
                                                          (QREFELT $ 15))
                                                         (QREFELT $ 16)))))
                                       (LETT |k| (+ |k| 1)) (GO G190) G191
                                       (EXIT NIL))
                                  (QSETAREF2O A |i| |j| |s| 1 1)
                                  (EXIT
                                   (COND
                                    ((NULL (SPADCALL |s| (QREFELT $ 17)))
                                     (COND ((< |i0| 0) (LETT |i0| |i|)))))))
                             (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((< |i0| 0) (|error| "singular matrix in LUDecomp"))
                          ('T
                           (SEQ
                            (COND
                             ((SPADCALL |j| |i0| (QREFELT $ 13))
                              (SPADCALL A |j| |i0| (QREFELT $ 19))))
                            (QSETAREF1O |PermV| |j| |i0| 1)
                            (LETT |Pivs| (CONS (QAREF2O A |j| |j| 1 1) |Pivs|))
                            (EXIT
                             (COND
                              ((SPADCALL |j| |maxC| (QREFELT $ 13))
                               (SEQ
                                (LETT |d|
                                      (SPADCALL (|spadConstant| $ 14)
                                                (QAREF2O A |j| |j| 1 1)
                                                (QREFELT $ 20)))
                                (EXIT
                                 (SEQ (LETT |k| (+ |j| 1)) (LETT #1# |maxR|)
                                      G190 (COND ((> |k| #1#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (QSETAREF2O A |k| |j|
                                                    (SPADCALL |d|
                                                              (QAREF2O A |k|
                                                                       |j| 1 1)
                                                              (QREFELT $ 15))
                                                    1 1)))
                                      (LETT |k| (+ |k| 1)) (GO G190) G191
                                      (EXIT NIL))))))))))))
                       (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                  (EXIT (VECTOR A |PermV| |Pivs|))))))))) 

(SDEFUN |LUD;LUSolve;MV2V;2|
        ((LU (|Matrix| D)) (|Perm| (|Vector| (|Integer|))) (XX (|Vector| D))
         ($ (|Vector| D)))
        (SPROG
         ((|s| (D)) (#1=#:G754 NIL) (|j| NIL) (#2=#:G753 NIL) (|i| NIL)
          (|ii| (|Integer|)) (#3=#:G752 NIL) (|ip| (|Integer|)) (#4=#:G751 NIL)
          (|maxR| (|Integer|)) (|minR| (|Integer|)) (X (|Vector| D)))
         (SEQ (LETT X (SPADCALL XX (QREFELT $ 24))) (LETT |minR| (PROGN LU 1))
              (LETT |maxR| (SPADCALL LU (QREFELT $ 10)))
              (EXIT
               (COND
                ((SPADCALL (QVSIZE X) |maxR| (QREFELT $ 13))
                 (|error| "Wrong dimensions in LUSolve"))
                ('T
                 (SEQ (LETT |ii| -1)
                      (SEQ (LETT |i| |minR|) (LETT #4# |maxR|) G190
                           (COND ((> |i| #4#) (GO G191)))
                           (SEQ (LETT |ip| (QAREF1O |Perm| |i| 1))
                                (LETT |s| (QAREF1O X |ip| 1))
                                (QSETAREF1O X |ip| (QAREF1O X |i| 1) 1)
                                (COND
                                 ((>= |ii| 0)
                                  (SEQ (LETT |j| |ii|) (LETT #3# (- |i| 1))
                                       G190 (COND ((> |j| #3#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT |s|
                                               (SPADCALL |s|
                                                         (SPADCALL
                                                          (QAREF2O LU |i| |j| 1
                                                                   1)
                                                          (QAREF1O X |j| 1)
                                                          (QREFELT $ 15))
                                                         (QREFELT $ 16)))))
                                       (LETT |j| (+ |j| 1)) (GO G190) G191
                                       (EXIT NIL)))
                                 ((NULL (SPADCALL |s| (QREFELT $ 17)))
                                  (LETT |ii| |i|)))
                                (EXIT (QSETAREF1O X |i| |s| 1)))
                           (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                      (SEQ (LETT |i| |maxR|) (LETT #2# |minR|) G190
                           (COND ((< |i| #2#) (GO G191)))
                           (SEQ (LETT |s| (QAREF1O X |i| 1))
                                (SEQ (LETT |j| (+ |i| 1)) (LETT #1# |maxR|)
                                     G190 (COND ((> |j| #1#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT |s|
                                             (SPADCALL |s|
                                                       (SPADCALL
                                                        (QAREF2O LU |i| |j| 1
                                                                 1)
                                                        (QAREF1O X |j| 1)
                                                        (QREFELT $ 15))
                                                       (QREFELT $ 16)))))
                                     (LETT |j| (+ |j| 1)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT
                                 (QSETAREF1O X |i|
                                             (SPADCALL |s|
                                                       (QAREF2O LU |i| |i| 1 1)
                                                       (QREFELT $ 20))
                                             1)))
                           (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                      (EXIT X)))))))) 

(SDEFUN |LUD;LUInverse;MR;3|
        ((A (|Matrix| D))
         ($ (|Record| (|:| |Inv| (|Matrix| D)) (|:| |Pivots| (|List| D)))))
        (SPROG
         ((|res| (|Matrix| D)) (|v| (|Vector| D)) (#1=#:G763 NIL) (|i| NIL)
          (|n| (|NonNegativeInteger|))
          (|Alu|
           (|Record| (|:| LU (|Matrix| D)) (|:| |Perm| (|Vector| (|Integer|)))
                     (|:| |Pivots| (|List| D)))))
         (SEQ (LETT |Alu| (SPADCALL A (QREFELT $ 22))) (LETT |n| (ANCOLS A))
              (LETT |res| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 18)))
              (SEQ (LETT |i| (PROGN A 1))
                   (LETT #1# (SPADCALL A (QREFELT $ 10))) G190
                   (COND ((> |i| #1#) (GO G191)))
                   (SEQ (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 18)))
                        (QSETAREF1O |v| |i| (|spadConstant| $ 14) 1)
                        (EXIT
                         (LETT |res|
                               (SPADCALL |res| |i|
                                         (SPADCALL (QVELT |Alu| 0)
                                                   (QVELT |Alu| 1) |v|
                                                   (QREFELT $ 26))
                                         (QREFELT $ 27)))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |res| (QVELT |Alu| 2)))))) 

(DECLAIM (NOTINLINE |LUDecomposition;|)) 

(DEFUN |LUDecomposition| (#1=#:G764)
  (SPROG NIL
         (PROG (#2=#:G765)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|LUDecomposition|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|LUDecomposition;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LUDecomposition|)))))))))) 

(DEFUN |LUDecomposition;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|LUDecomposition| DV$1))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LUDecomposition| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LUDecomposition| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Matrix| 6) (0 . |copy|)
              (|Integer|) (5 . |maxRowIndex|) (10 . |maxColIndex|) (|Boolean|)
              (15 . ~=) (21 . |One|) (25 . *) (31 . -) (37 . |zero?|)
              (42 . |Zero|) (46 . |swapRows!|) (53 . /)
              (|Record| (|:| LU 7) (|:| |Perm| 25) (|:| |Pivots| (|List| 6)))
              |LUD;LUDecomp;MR;1| (|Vector| 6) (59 . |copy|) (|Vector| 9)
              |LUD;LUSolve;MV2V;2| (64 . |setColumn!|)
              (|Record| (|:| |Inv| 7) (|:| |Pivots| (|List| 6)))
              |LUD;LUInverse;MR;3|)
           '#(|LUSolve| 71 |LUInverse| 78 |LUDecomp| 83) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|LUDecomp|
                                 ((|Record| (|:| LU (|Matrix| |#1|))
                                            (|:| |Perm| (|Vector| (|Integer|)))
                                            (|:| |Pivots| (|List| |#1|)))
                                  (|Matrix| |#1|)))
                                T)
                              '((|LUSolve|
                                 ((|Vector| |#1|) (|Matrix| |#1|)
                                  (|Vector| (|Integer|)) (|Vector| |#1|)))
                                T)
                              '((|LUInverse|
                                 ((|Record| (|:| |Inv| (|Matrix| |#1|))
                                            (|:| |Pivots| (|List| |#1|)))
                                  (|Matrix| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(1 7 0 0 8 1 7 9 0 10 1 7 9 0 11 2
                                              9 12 0 0 13 0 6 0 14 2 6 0 0 0 15
                                              2 6 0 0 0 16 1 6 12 0 17 0 6 0 18
                                              3 7 0 0 9 9 19 2 6 0 0 0 20 1 23
                                              0 0 24 3 7 0 0 9 23 27 3 0 23 7
                                              25 23 26 1 0 28 7 29 1 0 21 7
                                              22)))))
           '|lookupComplete|)) 
