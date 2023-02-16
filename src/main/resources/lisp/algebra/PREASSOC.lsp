
(SDEFUN |PREASSOC;firstUncouplingMatrix;LPiU;1|
        ((|op| (L)) (|m| (|PositiveInteger|))
         ($ (|Union| (|Matrix| R) "failed")))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (SPADCALL |op| (QREFELT $ 11)))
                    (COND
                     ((EQL |n| 3)
                      (COND ((EQL |m| 2) (EXIT (|PREASSOC;A32| |op| $))))))
                    (COND
                     ((EQL |n| 4)
                      (COND ((EQL |m| 2) (EXIT (|PREASSOC;A42| |op| $))))))
                    (EXIT (CONS 1 "failed"))))) 

(SDEFUN |PREASSOC;makeMonic|
        ((|op| (L)) ($ (|Union| (|PrimitiveArray| R) "failed")))
        (SPROG
         ((#1=#:G718 NIL) (|u| (|Union| R "failed")) (#2=#:G719 NIL)
          (#3=#:G710 NIL) (|i| NIL) (|a| (|PrimitiveArray| R))
          (|n| (|NonNegativeInteger|)) (|lc| (R)))
         (SEQ
          (EXIT
           (SEQ (LETT |lc| (SPADCALL |op| (QREFELT $ 15)))
                (LETT |a|
                      (MAKEARR1 (LETT |n| (SPADCALL |op| (QREFELT $ 11)))
                                (|spadConstant| $ 16)))
                (SEQ (LETT |i| 0)
                     (LETT #2#
                           (PROG1 (LETT #3# (- |n| 1))
                             (|check_subtype2| (>= #3# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #3#)))
                     G190 (COND ((|greater_SI| |i| #2#) (GO G191)))
                     (SEQ
                      (LETT |u|
                            (SPADCALL (SPADCALL |op| |i| (QREFELT $ 19)) |lc|
                                      (QREFELT $ 21)))
                      (EXIT
                       (COND
                        ((QEQCAR |u| 1)
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #4=#:G717)))
                        ('T
                         (QSETAREF1 |a| |i|
                                    (SPADCALL (QCDR |u|) (QREFELT $ 22)))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |a|))))
          #4# (EXIT #1#)))) 

(SDEFUN |PREASSOC;A32| ((|op| (L)) ($ (|Union| (|Matrix| R) "failed")))
        (SPROG
         ((|a| (|PrimitiveArray| R))
          (|u| (|Union| (|PrimitiveArray| R) "failed")))
         (SEQ (LETT |u| (|PREASSOC;makeMonic| |op| $))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |a| (QCDR |u|))
                           (EXIT
                            (CONS 0
                                  (SPADCALL
                                   (LIST
                                    (LIST (|spadConstant| $ 16)
                                          (|spadConstant| $ 17)
                                          (|spadConstant| $ 16))
                                    (LIST (QAREF1 |a| 1) (QAREF1 |a| 2)
                                          (|spadConstant| $ 17))
                                    (LIST
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (QREFELT $ 9) (QAREF1 |a| 1)
                                                 (QREFELT $ 23))
                                       (SPADCALL (QAREF1 |a| 1) (QAREF1 |a| 2)
                                                 (QREFELT $ 24))
                                       (QREFELT $ 25))
                                      (QAREF1 |a| 0) (QREFELT $ 27))
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (QREFELT $ 9) (QAREF1 |a| 2)
                                                 (QREFELT $ 23))
                                       (SPADCALL (QAREF1 |a| 2) 2
                                                 (QREFELT $ 28))
                                       (QREFELT $ 25))
                                      (QAREF1 |a| 1) (QREFELT $ 25))
                                     (SPADCALL 2 (QAREF1 |a| 2)
                                               (QREFELT $ 29))))
                                   (QREFELT $ 32))))))))))) 

(SDEFUN |PREASSOC;A42| ((|op| (L)) ($ (|Union| (|Matrix| R) "failed")))
        (SPROG
         ((|i| NIL) (|a''| #1=(|PrimitiveArray| R)) (|a'| #1#)
          (|a| (|PrimitiveArray| R))
          (|u| (|Union| (|PrimitiveArray| R) "failed")))
         (SEQ (LETT |u| (|PREASSOC;makeMonic| |op| $))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |a| (QCDR |u|))
                           (LETT |a'| (MAKEARR1 4 (|spadConstant| $ 16)))
                           (LETT |a''| (MAKEARR1 4 (|spadConstant| $ 16)))
                           (SEQ (LETT |i| 0) G190
                                (COND ((|greater_SI| |i| 3) (GO G191)))
                                (SEQ
                                 (QSETAREF1 |a'| |i|
                                            (SPADCALL (QREFELT $ 9)
                                                      (QAREF1 |a| |i|)
                                                      (QREFELT $ 23)))
                                 (EXIT
                                  (QSETAREF1 |a''| |i|
                                             (SPADCALL (QREFELT $ 9)
                                                       (QAREF1 |a'| |i|)
                                                       (QREFELT $ 23)))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (CONS 0
                                  (SPADCALL
                                   (LIST
                                    (LIST (|spadConstant| $ 16)
                                          (|spadConstant| $ 17)
                                          (|spadConstant| $ 16)
                                          (|spadConstant| $ 16)
                                          (|spadConstant| $ 16)
                                          (|spadConstant| $ 16))
                                    (LIST (|spadConstant| $ 16)
                                          (|spadConstant| $ 16)
                                          (|spadConstant| $ 17)
                                          (|spadConstant| $ 17)
                                          (|spadConstant| $ 16)
                                          (|spadConstant| $ 16))
                                    (LIST (QAREF1 |a| 1) (QAREF1 |a| 2)
                                          (|spadConstant| $ 16) (QAREF1 |a| 3)
                                          (SPADCALL 2 (QREFELT $ 34))
                                          (|spadConstant| $ 16))
                                    (LIST
                                     (SPADCALL
                                      (SPADCALL (QAREF1 |a'| 1)
                                                (SPADCALL (QAREF1 |a| 1)
                                                          (QAREF1 |a| 3)
                                                          (QREFELT $ 24))
                                                (QREFELT $ 25))
                                      (SPADCALL 2 (QAREF1 |a| 0)
                                                (QREFELT $ 29))
                                      (QREFELT $ 27))
                                     (SPADCALL
                                      (SPADCALL (QAREF1 |a'| 2)
                                                (SPADCALL (QAREF1 |a| 2)
                                                          (QAREF1 |a| 3)
                                                          (QREFELT $ 24))
                                                (QREFELT $ 25))
                                      (QAREF1 |a| 1) (QREFELT $ 25))
                                     (SPADCALL 3 (QAREF1 |a| 2) (QREFELT $ 29))
                                     (SPADCALL
                                      (SPADCALL (QAREF1 |a'| 3)
                                                (SPADCALL (QAREF1 |a| 3) 2
                                                          (QREFELT $ 28))
                                                (QREFELT $ 25))
                                      (QAREF1 |a| 2) (QREFELT $ 25))
                                     (SPADCALL 3 (QAREF1 |a| 3) (QREFELT $ 29))
                                     (SPADCALL 2 (QREFELT $ 34)))
                                    (|PREASSOC;A425| |a| |a'| |a''| $)
                                    (|PREASSOC;A426| |a| |a'| |a''| $))
                                   (QREFELT $ 32))))))))))) 

(SDEFUN |PREASSOC;A425|
        ((|a| (|PrimitiveArray| R)) (|a'| (|PrimitiveArray| R))
         (|a''| (|PrimitiveArray| R)) ($ (|List| R)))
        (LIST
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL (QAREF1 |a''| 1)
                        (SPADCALL (SPADCALL 2 (QAREF1 |a| 1) (QREFELT $ 29))
                                  (QAREF1 |a'| 3) (QREFELT $ 24))
                        (QREFELT $ 25))
              (SPADCALL (QAREF1 |a| 3) (QAREF1 |a'| 1) (QREFELT $ 24))
              (QREFELT $ 25))
             (SPADCALL 2 (QAREF1 |a'| 0) (QREFELT $ 29)) (QREFELT $ 27))
            (SPADCALL (QAREF1 |a| 1) (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                      (QREFELT $ 24))
            (QREFELT $ 25))
           (SPADCALL (SPADCALL 3 (QAREF1 |a| 0) (QREFELT $ 29)) (QAREF1 |a| 3)
                     (QREFELT $ 24))
           (QREFELT $ 27))
          (SPADCALL (QAREF1 |a| 1) (QAREF1 |a| 2) (QREFELT $ 24))
          (QREFELT $ 25))
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL (QAREF1 |a''| 2)
                         (SPADCALL (SPADCALL 2 (QAREF1 |a| 2) (QREFELT $ 29))
                                   (QAREF1 |a'| 3) (QREFELT $ 24))
                         (QREFELT $ 25))
               (SPADCALL (QAREF1 |a| 3) (QAREF1 |a'| 2) (QREFELT $ 24))
               (QREFELT $ 25))
              (SPADCALL 2 (QAREF1 |a'| 1) (QREFELT $ 29)) (QREFELT $ 25))
             (SPADCALL (QAREF1 |a| 2)
                       (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                       (QREFELT $ 24))
             (QREFELT $ 25))
            (SPADCALL (QAREF1 |a| 1) (QAREF1 |a| 3) (QREFELT $ 24))
            (QREFELT $ 25))
           (SPADCALL (QAREF1 |a| 2) 2 (QREFELT $ 28)) (QREFELT $ 25))
          (SPADCALL 4 (QAREF1 |a| 0) (QREFELT $ 29)) (QREFELT $ 27))
         (SPADCALL
          (SPADCALL (SPADCALL 4 (QAREF1 |a'| 2) (QREFELT $ 29))
                    (SPADCALL (SPADCALL 4 (QAREF1 |a| 2) (QREFELT $ 29))
                              (QAREF1 |a| 3) (QREFELT $ 24))
                    (QREFELT $ 25))
          (QAREF1 |a| 1) (QREFELT $ 27))
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL (QAREF1 |a''| 3)
                       (SPADCALL (SPADCALL 3 (QAREF1 |a| 3) (QREFELT $ 29))
                                 (QAREF1 |a'| 3) (QREFELT $ 24))
                       (QREFELT $ 25))
             (SPADCALL 2 (QAREF1 |a'| 2) (QREFELT $ 29)) (QREFELT $ 25))
            (SPADCALL (QAREF1 |a| 3) 3 (QREFELT $ 28)) (QREFELT $ 25))
           (SPADCALL (SPADCALL 2 (QAREF1 |a| 2) (QREFELT $ 29)) (QAREF1 |a| 3)
                     (QREFELT $ 24))
           (QREFELT $ 25))
          (QAREF1 |a| 1) (QREFELT $ 25))
         (SPADCALL
          (SPADCALL (SPADCALL 4 (QAREF1 |a'| 3) (QREFELT $ 29))
                    (SPADCALL 4 (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                              (QREFELT $ 29))
                    (QREFELT $ 25))
          (SPADCALL 4 (QAREF1 |a| 2) (QREFELT $ 29)) (QREFELT $ 25))
         (SPADCALL 5 (QAREF1 |a| 3) (QREFELT $ 29)))) 

(SDEFUN |PREASSOC;A426|
        ((|a| (|PrimitiveArray| R)) (|a'| (|PrimitiveArray| R))
         (|a''| (|PrimitiveArray| R)) ($ (|List| R)))
        (LIST
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (QREFELT $ 9) (QAREF1 |a''| 1) (QREFELT $ 23))
                     (SPADCALL (SPADCALL 3 (QAREF1 |a| 1) (QREFELT $ 29))
                               (QAREF1 |a''| 3) (QREFELT $ 24))
                     (QREFELT $ 25))
                    (SPADCALL (QAREF1 |a| 3) (QAREF1 |a''| 1) (QREFELT $ 24))
                    (QREFELT $ 25))
                   (SPADCALL 2 (QAREF1 |a''| 0) (QREFELT $ 29)) (QREFELT $ 27))
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (SPADCALL 3 (QAREF1 |a'| 1) (QREFELT $ 29))
                              (SPADCALL
                               (SPADCALL 5 (QAREF1 |a| 1) (QREFELT $ 29))
                               (QAREF1 |a| 3) (QREFELT $ 24))
                              (QREFELT $ 25))
                    (SPADCALL 7 (QAREF1 |a| 0) (QREFELT $ 29)) (QREFELT $ 27))
                   (QAREF1 |a'| 3) (QREFELT $ 24))
                  (QREFELT $ 25))
                 (SPADCALL (SPADCALL 3 (QAREF1 |a| 1) (QREFELT $ 29))
                           (QAREF1 |a'| 2) (QREFELT $ 24))
                 (QREFELT $ 25))
                (SPADCALL
                 (SPADCALL (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                           (QAREF1 |a| 2) (QREFELT $ 25))
                 (QAREF1 |a'| 1) (QREFELT $ 24))
                (QREFELT $ 25))
               (SPADCALL (SPADCALL 3 (QAREF1 |a| 3) (QREFELT $ 29))
                         (QAREF1 |a'| 0) (QREFELT $ 24))
               (QREFELT $ 27))
              (SPADCALL (QAREF1 |a| 1)
                        (SPADCALL (QAREF1 |a| 3) 3 (QREFELT $ 28))
                        (QREFELT $ 24))
              (QREFELT $ 25))
             (SPADCALL (SPADCALL 4 (QAREF1 |a| 0) (QREFELT $ 29))
                       (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                       (QREFELT $ 24))
             (QREFELT $ 27))
            (SPADCALL
             (SPADCALL (SPADCALL 2 (QAREF1 |a| 1) (QREFELT $ 29))
                       (QAREF1 |a| 2) (QREFELT $ 24))
             (QAREF1 |a| 3) (QREFELT $ 24))
            (QREFELT $ 25))
           (SPADCALL (SPADCALL 4 (QAREF1 |a| 0) (QREFELT $ 29)) (QAREF1 |a| 2)
                     (QREFELT $ 24))
           (QREFELT $ 27))
          (SPADCALL (QAREF1 |a| 1) 2 (QREFELT $ 28)) (QREFELT $ 25))
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (QREFELT $ 9) (QAREF1 |a''| 2) (QREFELT $ 23))
                    (SPADCALL (SPADCALL 3 (QAREF1 |a| 2) (QREFELT $ 29))
                              (QAREF1 |a''| 3) (QREFELT $ 24))
                    (QREFELT $ 25))
                   (SPADCALL (QAREF1 |a| 3) (QAREF1 |a''| 2) (QREFELT $ 24))
                   (QREFELT $ 25))
                  (SPADCALL 3 (QAREF1 |a''| 1) (QREFELT $ 29)) (QREFELT $ 25))
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL 3 (QAREF1 |a'| 2) (QREFELT $ 29))
                             (SPADCALL
                              (SPADCALL 5 (QAREF1 |a| 2) (QREFELT $ 29))
                              (QAREF1 |a| 3) (QREFELT $ 24))
                             (QREFELT $ 25))
                   (SPADCALL 3 (QAREF1 |a| 1) (QREFELT $ 29)) (QREFELT $ 25))
                  (QAREF1 |a'| 3) (QREFELT $ 24))
                 (QREFELT $ 25))
                (SPADCALL
                 (SPADCALL (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                           (SPADCALL 4 (QAREF1 |a| 2) (QREFELT $ 29))
                           (QREFELT $ 25))
                 (QAREF1 |a'| 2) (QREFELT $ 24))
                (QREFELT $ 25))
               (SPADCALL (SPADCALL 2 (QAREF1 |a| 3) (QREFELT $ 29))
                         (QAREF1 |a'| 1) (QREFELT $ 24))
               (QREFELT $ 25))
              (SPADCALL 6 (QAREF1 |a'| 0) (QREFELT $ 29)) (QREFELT $ 27))
             (SPADCALL (QAREF1 |a| 2)
                       (SPADCALL (QAREF1 |a| 3) 3 (QREFELT $ 28))
                       (QREFELT $ 24))
             (QREFELT $ 25))
            (SPADCALL (QAREF1 |a| 1) (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                      (QREFELT $ 24))
            (QREFELT $ 25))
           (SPADCALL
            (SPADCALL
             (SPADCALL 2 (SPADCALL (QAREF1 |a| 2) 2 (QREFELT $ 28))
                       (QREFELT $ 29))
             (SPADCALL 8 (QAREF1 |a| 0) (QREFELT $ 29)) (QREFELT $ 27))
            (QAREF1 |a| 3) (QREFELT $ 24))
           (QREFELT $ 25))
          (SPADCALL (SPADCALL 2 (QAREF1 |a| 1) (QREFELT $ 29)) (QAREF1 |a| 2)
                    (QREFELT $ 24))
          (QREFELT $ 25))
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL (SPADCALL 5 (QAREF1 |a''| 2) (QREFELT $ 29))
                         (SPADCALL (SPADCALL 10 (QAREF1 |a| 2) (QREFELT $ 29))
                                   (QAREF1 |a'| 3) (QREFELT $ 24))
                         (QREFELT $ 25))
               (SPADCALL (SPADCALL 5 (QAREF1 |a| 3) (QREFELT $ 29))
                         (QAREF1 |a'| 2) (QREFELT $ 24))
               (QREFELT $ 25))
              (QAREF1 |a'| 1) (QREFELT $ 25))
             (SPADCALL (SPADCALL 5 (QAREF1 |a| 2) (QREFELT $ 29))
                       (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                       (QREFELT $ 24))
             (QREFELT $ 25))
            (SPADCALL (SPADCALL 4 (QAREF1 |a| 1) (QREFELT $ 29)) (QAREF1 |a| 3)
                      (QREFELT $ 24))
            (QREFELT $ 27))
           (SPADCALL 5 (SPADCALL (QAREF1 |a| 2) 2 (QREFELT $ 28))
                     (QREFELT $ 29))
           (QREFELT $ 25))
          (SPADCALL 4 (QAREF1 |a| 0) (QREFELT $ 29)) (QREFELT $ 27))
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (QREFELT $ 9) (QAREF1 |a''| 3) (QREFELT $ 23))
                    (SPADCALL (SPADCALL 4 (QAREF1 |a| 3) (QREFELT $ 29))
                              (QAREF1 |a''| 3) (QREFELT $ 24))
                    (QREFELT $ 25))
                   (SPADCALL 3 (QAREF1 |a''| 2) (QREFELT $ 29)) (QREFELT $ 25))
                  (SPADCALL 3 (SPADCALL (QAREF1 |a'| 3) 2 (QREFELT $ 28))
                            (QREFELT $ 29))
                  (QREFELT $ 25))
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL 6 (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                             (QREFELT $ 29))
                   (SPADCALL 4 (QAREF1 |a| 2) (QREFELT $ 29)) (QREFELT $ 25))
                  (QAREF1 |a'| 3) (QREFELT $ 24))
                 (QREFELT $ 25))
                (SPADCALL (SPADCALL 5 (QAREF1 |a| 3) (QREFELT $ 29))
                          (QAREF1 |a'| 2) (QREFELT $ 24))
                (QREFELT $ 25))
               (SPADCALL 3 (QAREF1 |a'| 1) (QREFELT $ 29)) (QREFELT $ 25))
              (SPADCALL (QAREF1 |a| 3) 4 (QREFELT $ 28)) (QREFELT $ 25))
             (SPADCALL (SPADCALL 3 (QAREF1 |a| 2) (QREFELT $ 29))
                       (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                       (QREFELT $ 24))
             (QREFELT $ 25))
            (SPADCALL (SPADCALL 2 (QAREF1 |a| 1) (QREFELT $ 29)) (QAREF1 |a| 3)
                      (QREFELT $ 24))
            (QREFELT $ 25))
           (SPADCALL (QAREF1 |a| 2) 2 (QREFELT $ 28)) (QREFELT $ 25))
          (SPADCALL 4 (QAREF1 |a| 0) (QREFELT $ 29)) (QREFELT $ 27))
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL (SPADCALL 5 (QAREF1 |a''| 3) (QREFELT $ 29))
                      (SPADCALL (SPADCALL 15 (QAREF1 |a| 3) (QREFELT $ 29))
                                (QAREF1 |a'| 3) (QREFELT $ 24))
                      (QREFELT $ 25))
            (SPADCALL 10 (QAREF1 |a'| 2) (QREFELT $ 29)) (QREFELT $ 25))
           (SPADCALL 5 (SPADCALL (QAREF1 |a| 3) 3 (QREFELT $ 28))
                     (QREFELT $ 29))
           (QREFELT $ 25))
          (SPADCALL (SPADCALL 10 (QAREF1 |a| 2) (QREFELT $ 29)) (QAREF1 |a| 3)
                    (QREFELT $ 24))
          (QREFELT $ 25))
         (SPADCALL
          (SPADCALL (SPADCALL 9 (QAREF1 |a'| 3) (QREFELT $ 29))
                    (SPADCALL 9 (SPADCALL (QAREF1 |a| 3) 2 (QREFELT $ 28))
                              (QREFELT $ 29))
                    (QREFELT $ 25))
          (SPADCALL 4 (QAREF1 |a| 2) (QREFELT $ 29)) (QREFELT $ 25)))) 

(DECLAIM (NOTINLINE |PrecomputedAssociatedEquations;|)) 

(DEFUN |PrecomputedAssociatedEquations| (&REST #1=#:G747)
  (SPROG NIL
         (PROG (#2=#:G748)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PrecomputedAssociatedEquations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PrecomputedAssociatedEquations;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PrecomputedAssociatedEquations|)))))))))) 

(DEFUN |PrecomputedAssociatedEquations;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PrecomputedAssociatedEquations| DV$1 DV$2))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PrecomputedAssociatedEquations|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          $))) 

(MAKEPROP '|PrecomputedAssociatedEquations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . D)
              '|diff| (|NonNegativeInteger|) (4 . |degree|)
              (|Union| 31 '#1="failed") (|PositiveInteger|)
              |PREASSOC;firstUncouplingMatrix;LPiU;1|
              (9 . |leadingCoefficient|) (14 . |Zero|) (18 . |One|)
              (22 . |One|) (26 . |coefficient|) (|Union| $ '"failed")
              (32 . |exquo|) (38 . -) (43 . |elt|) (49 . *) (55 . +)
              (61 . |Zero|) (65 . -) (71 . ^) (77 . *) (|List| (|List| 6))
              (|Matrix| 6) (83 . |matrix|) (|Integer|) (88 . |coerce|))
           '#(|firstUncouplingMatrix| 93) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|firstUncouplingMatrix|
                                 ((|Union| (|Matrix| |#1|) #1#) |#2|
                                  (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 34
                                            '(0 7 0 8 1 7 10 0 11 1 7 6 0 15 0
                                              6 0 16 0 6 0 17 0 7 0 18 2 7 6 0
                                              10 19 2 6 20 0 0 21 1 6 0 0 22 2
                                              7 6 0 6 23 2 6 0 0 0 24 2 6 0 0 0
                                              25 0 7 0 26 2 6 0 0 0 27 2 6 0 0
                                              13 28 2 6 0 13 0 29 1 31 0 30 32
                                              1 6 0 33 34 2 0 12 7 13 14)))))
           '|lookupComplete|)) 
