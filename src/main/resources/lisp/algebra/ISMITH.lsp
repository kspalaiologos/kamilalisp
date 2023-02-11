
(SDEFUN |ISMITH;smith;MMM;1|
        ((|m| (|Matrix| (|Integer|)))
         (|full| (|Mapping| (|Matrix| (|Integer|)) (|Matrix| (|Integer|))))
         ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G706 NIL) (|i| NIL) (|nn2| #2=(|Integer|)) (#3=#:G705 NIL)
          (|res| (|Matrix| (|Integer|))) (|count| #2#)
          (|nn| (|NonNegativeInteger|)) (|k| (|NonNegativeInteger|))
          (|j| (|NonNegativeInteger|)) (|m3| (|Matrix| (|Integer|)))
          (|m2| (|Matrix| (|Integer|))) (|m1| (|Matrix| (|Integer|))))
         (SEQ (LETT |m1| (SPADCALL |m| (QREFELT $ 7)))
              (LETT |m2| (SPADCALL |m1| (QREFELT $ 9)))
              (LETT |m3| (SPADCALL |m2| |full|)) (LETT |j| (ANROWS |m|))
              (LETT |k| (ANCOLS |m|)) (LETT |nn| (MIN |j| |k|))
              (LETT |count| (- |j| (ANROWS |m2|)))
              (LETT |res| (SPADCALL |j| |k| (QREFELT $ 11)))
              (SEQ (LETT |i| 1) (LETT #3# |count|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (EXIT (QSETAREF2O |res| |i| |i| 1 1 1)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |nn2| (- |nn| |count|))
              (SEQ (LETT |i| 1) (LETT #1# |nn2|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF2O |res| (+ |i| |count|) (+ |i| |count|)
                                 (QAREF2O |m3| |i| |i| 1 1) 1 1)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |ISMITH;smith;2M;2|
        ((|m| (|Matrix| (|Integer|))) ($ (|Matrix| (|Integer|))))
        (SPADCALL |m| (ELT $ 15) (QREFELT $ 13))) 

(SDEFUN |ISMITH;completeSmith;MMR;3|
        ((|m| (|Matrix| (|Integer|)))
         (|full|
          (|Mapping|
           (|Record| (|:| |Smith| (|Matrix| (|Integer|)))
                     (|:| |leftEqMat| (|Matrix| (|Integer|)))
                     (|:| |rightEqMat| (|Matrix| (|Integer|))))
           (|Matrix| (|Integer|))))
         ($
          (|Record| (|:| |Smith| (|Matrix| (|Integer|)))
                    (|:| |leftEqMat| (|Matrix| (|Integer|)))
                    (|:| |rightEqMat| (|Matrix| (|Integer|))))))
        (SPROG
         ((#1=#:G775 NIL) (|n| NIL) (#2=#:G774 NIL) (|pp| (|Integer|))
          (#3=#:G773 NIL) (|l| NIL) (#4=#:G772 NIL) (#5=#:G771 NIL)
          (#6=#:G770 NIL) (#7=#:G769 NIL) (|i| NIL)
          (|m16| #8=(|Matrix| (|Integer|))) (|m15| #9=(|Matrix| (|Integer|)))
          (|m14| #8#) (|m13| #9#) (#10=#:G767 NIL) (#11=#:G768 NIL)
          (|m12| (|Matrix| (|Integer|))) (|m11| #12=(|Matrix| (|Integer|)))
          (|m10| #9#) (|m9| #13=(|Matrix| (|Integer|))) (|m8| #12#) (|m7| #9#)
          (|m6| #13#)
          (|res1|
           (|Record| (|:| |Smith| (|Matrix| (|Integer|)))
                     (|:| |leftEqMat| (|Matrix| (|Integer|)))
                     (|:| |rightEqMat| (|Matrix| (|Integer|)))))
          (|m5| #13#) (|count| (|NonNegativeInteger|))
          (|m4| (|Matrix| (|Integer|))) (|m3| (|Matrix| (|Integer|)))
          (|lks| #14=(|List| (|Integer|))) (|ljs| #14#)
          (|lk0| (|List| (|Integer|))) (#15=#:G766 NIL) (#16=#:G765 NIL)
          (|lj2| (|List| (|Integer|))) (#17=#:G764 NIL) (#18=#:G763 NIL)
          (|lj1| (|List| (|Integer|))) (|s| (|Integer|)) (#19=#:G762 NIL)
          (#20=#:G761 NIL) (|lj0| (|List| (|Integer|))) (#21=#:G760 NIL)
          (#22=#:G759 NIL) (|m2| (|Matrix| (|Integer|)))
          (|m1| (|Matrix| (|Integer|))) (|pivotsk| #23=(|Vector| (|Integer|)))
          (|pivotsj| #23#)
          (|res0|
           (|Record| (|:| |Smith| (|Matrix| (|Integer|)))
                     (|:| |leftEqMat| (|Matrix| (|Integer|)))
                     (|:| |rightEqMat| (|Matrix| (|Integer|)))))
          (|k| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|)))
         (SEQ (LETT |j| (ANROWS |m|)) (LETT |k| (ANCOLS |m|))
              (EXIT
               (COND
                ((> |j| |k|)
                 (SEQ
                  (LETT |res0|
                        (SPADCALL (SPADCALL |m| (QREFELT $ 17)) |full|
                                  (QREFELT $ 20)))
                  (EXIT
                   (VECTOR (SPADCALL (QVELT |res0| 0) (QREFELT $ 17))
                           (SPADCALL (QVELT |res0| 2) (QREFELT $ 17))
                           (SPADCALL (QVELT |res0| 1) (QREFELT $ 17))))))
                ('T
                 (SEQ (LETT |pivotsj| (SPADCALL |j| (QREFELT $ 22)))
                      (LETT |pivotsk| (SPADCALL |k| (QREFELT $ 22)))
                      (LETT |m1| (SPADCALL |m| (QREFELT $ 7)))
                      (LETT |m2|
                            (SPADCALL |m1| |pivotsj| |pivotsk| (QREFELT $ 23)))
                      (LETT |lj0|
                            (PROGN
                             (LETT #22# NIL)
                             (SEQ (LETT |i| 1) (LETT #21# |j|) G190
                                  (COND ((|greater_SI| |i| #21#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((EQL
                                       (SPADCALL |pivotsj| |i| (QREFELT $ 25))
                                       0)
                                      (LETT #22# (CONS |i| #22#))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #22#)))))
                      (LETT |lj1|
                            (PROGN
                             (LETT #20# NIL)
                             (SEQ (LETT |i| 1) (LETT #19# |j|) G190
                                  (COND ((|greater_SI| |i| #19#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (LETT |s|
                                             (SPADCALL |pivotsj| |i|
                                                       (QREFELT $ 25)))
                                       0 (QREFELT $ 27))
                                      (LETT #20# (CONS |s| #20#))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #20#)))))
                      (LETT |lj2|
                            (PROGN
                             (LETT #18# NIL)
                             (SEQ (LETT |i| 1) (LETT #17# |j|) G190
                                  (COND ((|greater_SI| |i| #17#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |pivotsj| |i| (QREFELT $ 25))
                                       0 (QREFELT $ 27))
                                      (LETT #18# (CONS |i| #18#))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #18#)))))
                      (LETT |lk0|
                            (PROGN
                             (LETT #16# NIL)
                             (SEQ (LETT |i| 1) (LETT #15# |k|) G190
                                  (COND ((|greater_SI| |i| #15#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((EQL
                                       (SPADCALL |pivotsk| |i| (QREFELT $ 25))
                                       0)
                                      (LETT #16# (CONS |i| #16#))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #16#)))))
                      (LETT |ljs| (SPADCALL |lj2| |lj0| (QREFELT $ 29)))
                      (LETT |lks| (SPADCALL |lj1| |lk0| (QREFELT $ 29)))
                      (LETT |m3| (SPADCALL |m1| |ljs| |lks| (QREFELT $ 30)))
                      (LETT |m4|
                            (SPADCALL |m2| |ljs|
                                      (SPADCALL 1 |j| (QREFELT $ 32))
                                      (QREFELT $ 33)))
                      (LETT |count| (LENGTH |lj2|))
                      (LETT |m5|
                            (SPADCALL |m3|
                                      (SPADCALL (+ |count| 1) |j|
                                                (QREFELT $ 32))
                                      (SPADCALL (+ |count| 1) |k|
                                                (QREFELT $ 32))
                                      (QREFELT $ 34)))
                      (LETT |res1| (SPADCALL |m5| |full|))
                      (LETT |m6|
                            (SPADCALL |m4|
                                      (SPADCALL (+ |count| 1) |j|
                                                (QREFELT $ 32))
                                      (SPADCALL 1 |j| (QREFELT $ 32))
                                      (QREFELT $ 34)))
                      (LETT |m7|
                            (SPADCALL (QVELT |res1| 1) |m6| (QREFELT $ 35)))
                      (LETT |m8|
                            (SPADCALL
                             (SPADCALL |m4| (SPADCALL 1 |count| (QREFELT $ 32))
                                       (SPADCALL 1 |j| (QREFELT $ 32))
                                       (QREFELT $ 34))
                             |m7| (QREFELT $ 36)))
                      (LETT |m9|
                            (SPADCALL |m3|
                                      (SPADCALL (+ |count| 1) |j|
                                                (QREFELT $ 32))
                                      (SPADCALL 1 |k| (QREFELT $ 32))
                                      (QREFELT $ 34)))
                      (LETT |m10|
                            (SPADCALL (QVELT |res1| 1) |m9| (QREFELT $ 35)))
                      (LETT |m11|
                            (SPADCALL
                             (SPADCALL |m3| (SPADCALL 1 |count| (QREFELT $ 32))
                                       (SPADCALL 1 |k| (QREFELT $ 32))
                                       (QREFELT $ 34))
                             |m10| (QREFELT $ 36)))
                      (LETT |m12| (SPADCALL |k| |k| (QREFELT $ 11)))
                      (SEQ (LETT |l| NIL) (LETT #11# |lks|) (LETT |i| 1)
                           (LETT #10# |k|) G190
                           (COND
                            ((OR (|greater_SI| |i| #10#) (ATOM #11#)
                                 (PROGN (LETT |l| (CAR #11#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT (SPADCALL |m12| |l| |i| 1 (QREFELT $ 37))))
                           (LETT |i|
                                 (PROG1 (|inc_SI| |i|) (LETT #11# (CDR #11#))))
                           (GO G190) G191 (EXIT NIL))
                      (LETT |m13|
                            (SPADCALL
                             (SPADCALL |m12| (SPADCALL 1 |k| (QREFELT $ 32))
                                       (SPADCALL (+ |count| 1) |k|
                                                 (QREFELT $ 32))
                                       (QREFELT $ 34))
                             (QVELT |res1| 2) (QREFELT $ 35)))
                      (LETT |m14|
                            (SPADCALL
                             (SPADCALL |m12| (SPADCALL 1 |k| (QREFELT $ 32))
                                       (SPADCALL 1 |count| (QREFELT $ 32))
                                       (QREFELT $ 34))
                             |m13| (QREFELT $ 40)))
                      (LETT |m15|
                            (SPADCALL
                             (SPADCALL |m11| (SPADCALL 1 |j| (QREFELT $ 32))
                                       (SPADCALL (+ |count| 1) |k|
                                                 (QREFELT $ 32))
                                       (QREFELT $ 34))
                             (QVELT |res1| 2) (QREFELT $ 35)))
                      (LETT |m16|
                            (SPADCALL
                             (SPADCALL |m11| (SPADCALL 1 |j| (QREFELT $ 32))
                                       (SPADCALL 1 |count| (QREFELT $ 32))
                                       (QREFELT $ 34))
                             |m15| (QREFELT $ 40)))
                      (SEQ (LETT |i| |count|) G190 (COND ((< |i| 1) (GO G191)))
                           (SEQ
                            (COND
                             ((EQL (QAREF2O |m16| |i| |i| 1 1) -1)
                              (SEQ
                               (SEQ (LETT |l| 1) (LETT #7# |i|) G190
                                    (COND ((|greater_SI| |l| #7#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (QSETAREF2O |m16| |l| |i|
                                                  (-
                                                   (QAREF2O |m16| |l| |i| 1 1))
                                                  1 1)))
                                    (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SEQ (LETT |l| 1) (LETT #6# |k|) G190
                                     (COND ((|greater_SI| |l| #6#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (QSETAREF2O |m14| |l| |i|
                                                   (-
                                                    (QAREF2O |m14| |l| |i| 1
                                                             1))
                                                   1 1)))
                                     (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                     (EXIT NIL))))))
                            (EXIT
                             (COND
                              ((SPADCALL (QAREF2O |m16| |i| |i| 1 1) 1
                                         (QREFELT $ 27))
                               (|error| "completeSmith: wrong diagonal"))
                              ('T
                               (SEQ
                                (SEQ (LETT |l| 1) (LETT #5# (- |i| 1)) G190
                                     (COND ((|greater_SI| |l| #5#) (GO G191)))
                                     (SEQ
                                      (LETT |pp| (QAREF2O |m16| |l| |i| 1 1))
                                      (EXIT
                                       (SEQ (LETT |n| (+ |i| 1)) (LETT #4# |k|)
                                            G190 (COND ((> |n| #4#) (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (QSETAREF2O |m16| |l| |n|
                                                          (-
                                                           (QAREF2O |m16| |l|
                                                                    |n| 1 1)
                                                           (* |pp|
                                                              (QAREF2O |m16|
                                                                       |i| |n|
                                                                       1 1)))
                                                          1 1)))
                                            (LETT |n| (+ |n| 1)) (GO G190) G191
                                            (EXIT NIL))))
                                     (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                     (EXIT NIL))
                                (SEQ (LETT |l| 1) (LETT #3# |k|) G190
                                     (COND ((|greater_SI| |l| #3#) (GO G191)))
                                     (SEQ
                                      (LETT |pp| (QAREF2O |m14| |l| |i| 1 1))
                                      (EXIT
                                       (SEQ (LETT |n| (+ |i| 1)) (LETT #2# |k|)
                                            G190 (COND ((> |n| #2#) (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (QSETAREF2O |m14| |l| |n|
                                                          (-
                                                           (QAREF2O |m14| |l|
                                                                    |n| 1 1)
                                                           (* |pp|
                                                              (QAREF2O |m16|
                                                                       |i| |n|
                                                                       1 1)))
                                                          1 1)))
                                            (LETT |n| (+ |n| 1)) (GO G190) G191
                                            (EXIT NIL))))
                                     (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT
                                 (SEQ (LETT |n| (+ |i| 1)) (LETT #1# |k|) G190
                                      (COND ((> |n| #1#) (GO G191)))
                                      (SEQ
                                       (EXIT (QSETAREF2O |m16| |i| |n| 0 1 1)))
                                      (LETT |n| (+ |n| 1)) (GO G190) G191
                                      (EXIT NIL))))))))
                           (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                      (EXIT (VECTOR |m16| |m8| |m14|))))))))) 

(DECLAIM (NOTINLINE |IntegerSmithNormalForm;|)) 

(DEFUN |IntegerSmithNormalForm| ()
  (SPROG NIL
         (PROG (#1=#:G777)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|IntegerSmithNormalForm|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|IntegerSmithNormalForm|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|IntegerSmithNormalForm;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|IntegerSmithNormalForm|)))))))))) 

(DEFUN |IntegerSmithNormalForm;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|IntegerSmithNormalForm|))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerSmithNormalForm| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegerSmithNormalForm| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Matrix| 24) (0 . |copy|)
              (|UnitGaussianElimination|) (5 . |pre_smith|)
              (|NonNegativeInteger|) (10 . |zero|) (|Mapping| 6 6)
              |ISMITH;smith;MMM;1| (|SmithNormalForm| 24 21 21 6)
              (16 . |smith|) |ISMITH;smith;2M;2| (21 . |transpose|)
              (|Record| (|:| |Smith| 6) (|:| |leftEqMat| 6)
                        (|:| |rightEqMat| 6))
              (|Mapping| 18 6) |ISMITH;completeSmith;MMR;3| (|Vector| 24)
              (26 . |zero|) (31 . |pre_lr|) (|Integer|) (38 . |elt|)
              (|Boolean|) (44 . ~=) (|List| 24) (50 . |concat|) (56 . |elt|)
              (|Segment| 24) (63 . SEGMENT) (69 . |elt|) (76 . |elt|) (83 . *)
              (89 . |vertConcat|) (95 . |setelt!|) (|UniversalSegment| 24)
              (103 . SEGMENT) (109 . |horizConcat|))
           '#(|smith| 115 |completeSmith| 126) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|smith|
                                 ((|Matrix| (|Integer|))
                                  (|Matrix| (|Integer|))))
                                T)
                              '((|smith|
                                 ((|Matrix| (|Integer|)) (|Matrix| (|Integer|))
                                  (|Mapping| (|Matrix| (|Integer|))
                                             (|Matrix| (|Integer|)))))
                                T)
                              '((|completeSmith|
                                 ((|Record|
                                   (|:| |Smith| (|Matrix| (|Integer|)))
                                   (|:| |leftEqMat| (|Matrix| (|Integer|)))
                                   (|:| |rightEqMat| (|Matrix| (|Integer|))))
                                  (|Matrix| (|Integer|))
                                  (|Mapping|
                                   (|Record|
                                    (|:| |Smith| (|Matrix| (|Integer|)))
                                    (|:| |leftEqMat| (|Matrix| (|Integer|)))
                                    (|:| |rightEqMat| (|Matrix| (|Integer|))))
                                   (|Matrix| (|Integer|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 40
                                            '(1 6 0 0 7 1 8 6 6 9 2 6 0 10 10
                                              11 1 14 6 6 15 1 6 0 0 17 1 21 0
                                              10 22 3 8 6 6 21 21 23 2 21 24 0
                                              24 25 2 24 26 0 0 27 2 28 0 0 0
                                              29 3 6 0 0 28 28 30 2 31 0 24 24
                                              32 3 6 0 0 28 31 33 3 6 0 0 31 31
                                              34 2 6 0 0 0 35 2 6 0 0 0 36 4 6
                                              24 0 24 24 24 37 2 38 0 24 24 39
                                              2 6 0 0 0 40 1 0 6 6 16 2 0 6 6
                                              12 13 2 0 18 6 19 20)))))
           '|lookupComplete|)) 

(MAKEPROP '|IntegerSmithNormalForm| 'NILADIC T) 
