
(SDEFUN |EFULS;nthRootUTS|
        ((|uts| (UTS)) (|n| (|Integer|)) ($ (|Union| UTS "failed")))
        (COND
         ((OR
           (SPADCALL (SPADCALL |uts| 0 (QREFELT $ 15)) (|spadConstant| $ 16)
                     (QREFELT $ 18))
           (QREFELT $ 9))
          (CONS 0
                (SPADCALL |uts|
                          (SPADCALL (SPADCALL |n| (QREFELT $ 21))
                                    (QREFELT $ 22))
                          (QREFELT $ 23))))
         ('T (CONS 1 "failed")))) 

(SDEFUN |EFULS;nthRootIfCan;ULSNniU;2|
        ((|uls| (ULS)) (|nn| (|NonNegativeInteger|))
         ($ (|Union| ULS "failed")))
        (SPROG
         ((|root| (|Union| UTS "failed")) (|uts| (UTS))
          (|k| (|Union| (|Integer|) "failed")) (|coef| (|Coef|))
          (|deg| (|Integer|)) (|n| (|Integer|)))
         (SEQ (LETT |n| |nn|)
              (EXIT
               (COND ((< |n| 1) (|error| "nthRootIfCan: n must be positive"))
                     ((EQL |n| 1) (CONS 0 |uls|))
                     (#1='T
                      (SEQ (LETT |deg| (SPADCALL |uls| (QREFELT $ 25)))
                           (COND
                            ((SPADCALL
                              (LETT |coef|
                                    (SPADCALL |uls| |deg| (QREFELT $ 26)))
                              (QREFELT $ 27))
                             (SEQ
                              (LETT |uls| (SPADCALL 1000 |uls| (QREFELT $ 28)))
                              (LETT |deg| (SPADCALL |uls| (QREFELT $ 25)))
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |coef|
                                        (SPADCALL |uls| |deg| (QREFELT $ 26)))
                                  (QREFELT $ 27))
                                 (|error|
                                  "root of series with many leading zero coefficients")))))))
                           (LETT |k| (SPADCALL |deg| |n| (QREFELT $ 30)))
                           (EXIT
                            (COND ((QEQCAR |k| 1) (CONS 1 "failed"))
                                  (#1#
                                   (SEQ
                                    (LETT |uts|
                                          (SPADCALL
                                           (SPADCALL |uls|
                                                     (SPADCALL
                                                      (|spadConstant| $ 16)
                                                      (- |deg|) (QREFELT $ 31))
                                                     (QREFELT $ 32))
                                           (QREFELT $ 33)))
                                    (LETT |root|
                                          (|EFULS;nthRootUTS| |uts| |n| $))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |root| 1) (CONS 1 "failed"))
                                      (#1#
                                       (CONS 0
                                             (SPADCALL
                                              (SPADCALL (|spadConstant| $ 16)
                                                        (QCDR |k|)
                                                        (QREFELT $ 31))
                                              (SPADCALL (QCDR |root|)
                                                        (QREFELT $ 34))
                                              (QREFELT $ 32))))))))))))))))) 

(SDEFUN |EFULS;^;ULSFULS;3|
        ((|uls| (ULS)) (|r| (|Fraction| (|Integer|))) ($ (ULS)))
        (SPROG
         ((|uts| (UTS)) (|k| (|Union| (|Integer|) "failed")) (|coef| (|Coef|))
          (|deg| (|Integer|)) (|den| (|Integer|)) (|num| (|Integer|)))
         (SEQ (LETT |num| (SPADCALL |r| (QREFELT $ 37)))
              (LETT |den| (SPADCALL |r| (QREFELT $ 38)))
              (EXIT
               (COND ((EQL |den| 1) (SPADCALL |uls| |num| (QREFELT $ 39)))
                     (#1='T
                      (SEQ (LETT |deg| (SPADCALL |uls| (QREFELT $ 25)))
                           (COND
                            ((SPADCALL
                              (LETT |coef|
                                    (SPADCALL |uls| |deg| (QREFELT $ 26)))
                              (QREFELT $ 27))
                             (SEQ
                              (LETT |uls| (SPADCALL 1000 |uls| (QREFELT $ 28)))
                              (LETT |deg| (SPADCALL |uls| (QREFELT $ 25)))
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |coef|
                                        (SPADCALL |uls| |deg| (QREFELT $ 26)))
                                  (QREFELT $ 27))
                                 (|error|
                                  "power of series with many leading zero coefficients")))))))
                           (LETT |k| (SPADCALL |deg| |den| (QREFELT $ 30)))
                           (EXIT
                            (COND
                             ((QEQCAR |k| 1)
                              (|error| "^: rational power does not exist"))
                             (#1#
                              (SEQ
                               (LETT |uts|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |uls|
                                                 (SPADCALL
                                                  (|spadConstant| $ 16)
                                                  (- |deg|) (QREFELT $ 31))
                                                 (QREFELT $ 32))
                                       (QREFELT $ 33))
                                      |r| (QREFELT $ 23)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 16)
                                           (* (QCDR |k|) |num|) (QREFELT $ 31))
                                 (SPADCALL |uts| (QREFELT $ 34))
                                 (QREFELT $ 32)))))))))))))) 

(SDEFUN |EFULS;applyIfCan|
        ((|fcn| (|Mapping| UTS UTS)) (|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG ((|uts| (|Union| UTS "failed")))
               (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 42)))
                    (EXIT
                     (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (SPADCALL (SPADCALL (QCDR |uts|) |fcn|)
                                            (QREFELT $ 34))))))))) 

(SDEFUN |EFULS;expIfCan;ULSU;5| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 43) |uls| $)) 

(SDEFUN |EFULS;sinIfCan;ULSU;6| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 45) |uls| $)) 

(SDEFUN |EFULS;cosIfCan;ULSU;7| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 47) |uls| $)) 

(SDEFUN |EFULS;asinIfCan;ULSU;8| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 49) |uls| $)) 

(SDEFUN |EFULS;acosIfCan;ULSU;9| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 51) |uls| $)) 

(SDEFUN |EFULS;asecIfCan;ULSU;10| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 53) |uls| $)) 

(SDEFUN |EFULS;acscIfCan;ULSU;11| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 55) |uls| $)) 

(SDEFUN |EFULS;sinhIfCan;ULSU;12| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 57) |uls| $)) 

(SDEFUN |EFULS;coshIfCan;ULSU;13| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 59) |uls| $)) 

(SDEFUN |EFULS;asinhIfCan;ULSU;14| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 61) |uls| $)) 

(SDEFUN |EFULS;acoshIfCan;ULSU;15| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 63) |uls| $)) 

(SDEFUN |EFULS;atanhIfCan;ULSU;16| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 65) |uls| $)) 

(SDEFUN |EFULS;acothIfCan;ULSU;17| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 67) |uls| $)) 

(SDEFUN |EFULS;asechIfCan;ULSU;18| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 69) |uls| $)) 

(SDEFUN |EFULS;acschIfCan;ULSU;19| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (|EFULS;applyIfCan| (ELT $ 71) |uls| $)) 

(SDEFUN |EFULS;logIfCan;ULSU;20| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG ((|ts| (UTS)) (|uts| (|Union| UTS "failed")))
               (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 42)))
                    (EXIT
                     (COND
                      ((OR (QEQCAR |uts| 1)
                           (SPADCALL
                            (SPADCALL (LETT |ts| (QCDR |uts|)) 0
                                      (QREFELT $ 15))
                            (QREFELT $ 27)))
                       (CONS 1 "failed"))
                      ('T
                       (CONS 0
                             (SPADCALL (SPADCALL |ts| (QREFELT $ 73))
                                       (QREFELT $ 34))))))))) 

(SDEFUN |EFULS;tanIfCan;ULSU;21| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG
         ((|cosInv| (|Union| ULS "failed"))
          (|sc|
           (|Record| (|:| |sin| (|Stream| |Coef|))
                     (|:| |cos| (|Stream| |Coef|))))
          (|uts| (|Union| UTS "failed")))
         (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 42)))
              (EXIT
               (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ
                       (LETT |sc|
                             (SPADCALL (SPADCALL (QCDR |uts|) (QREFELT $ 76))
                                       (QREFELT $ 79)))
                       (LETT |cosInv|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QCDR |sc|) (QREFELT $ 80))
                                        (QREFELT $ 34))
                              (QREFELT $ 81)))
                       (EXIT
                        (COND ((QEQCAR |cosInv| 1) (CONS 1 "failed"))
                              (#1#
                               (CONS 0
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (QCAR |sc|) (QREFELT $ 80))
                                       (QREFELT $ 34))
                                      (QCDR |cosInv|) (QREFELT $ 32))))))))))))) 

(SDEFUN |EFULS;cotIfCan;ULSU;22| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG
         ((|sinInv| (|Union| ULS "failed"))
          (|sc|
           (|Record| (|:| |sin| (|Stream| |Coef|))
                     (|:| |cos| (|Stream| |Coef|))))
          (|uts| (|Union| UTS "failed")))
         (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 42)))
              (EXIT
               (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ
                       (LETT |sc|
                             (SPADCALL (SPADCALL (QCDR |uts|) (QREFELT $ 76))
                                       (QREFELT $ 79)))
                       (LETT |sinInv|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QCAR |sc|) (QREFELT $ 80))
                                        (QREFELT $ 34))
                              (QREFELT $ 81)))
                       (EXIT
                        (COND ((QEQCAR |sinInv| 1) (CONS 1 "failed"))
                              (#1#
                               (CONS 0
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (QCDR |sc|) (QREFELT $ 80))
                                       (QREFELT $ 34))
                                      (QCDR |sinInv|) (QREFELT $ 32))))))))))))) 

(SDEFUN |EFULS;secIfCan;ULSU;23| ((|uls| (ULS)) ($ (|Union| ULS #1="failed")))
        (SPROG ((|cosInv| (|Union| ULS "failed")) (|cos| (|Union| ULS #1#)))
               (SEQ (LETT |cos| (SPADCALL |uls| (QREFELT $ 48)))
                    (EXIT
                     (COND ((QEQCAR |cos| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |cosInv|
                                   (SPADCALL (QCDR |cos|) (QREFELT $ 81)))
                             (EXIT
                              (COND ((QEQCAR |cosInv| 1) (CONS 1 "failed"))
                                    (#2# (CONS 0 (QCDR |cosInv|)))))))))))) 

(SDEFUN |EFULS;cscIfCan;ULSU;24| ((|uls| (ULS)) ($ (|Union| ULS #1="failed")))
        (SPROG ((|sinInv| (|Union| ULS "failed")) (|sin| (|Union| ULS #1#)))
               (SEQ (LETT |sin| (SPADCALL |uls| (QREFELT $ 46)))
                    (EXIT
                     (COND ((QEQCAR |sin| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |sinInv|
                                   (SPADCALL (QCDR |sin|) (QREFELT $ 81)))
                             (EXIT
                              (COND ((QEQCAR |sinInv| 1) (CONS 1 "failed"))
                                    (#2# (CONS 0 (QCDR |sinInv|)))))))))))) 

(SDEFUN |EFULS;atanIfCan;ULSU;25| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG
         ((|z| (|Union| ULS "failed")) (|cc| (|Coef|)) (#1=#:G881 NIL)
          (|rat| (|Union| (|Fraction| (|Integer|)) "failed")) (|lc| (|Coef|))
          (#2=#:G880 NIL) (|ord| (|Integer|)) (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (SEQ
            (EXIT
             (SEQ (LETT |coef| (SPADCALL |uls| 0 (QREFELT $ 26)))
                  (SEQ (LETT |ord| (SPADCALL |uls| 0 (QREFELT $ 86)))
                       (EXIT
                        (COND
                         ((EQL |ord| 0)
                          (COND
                           ((SPADCALL (SPADCALL |coef| |coef| (QREFELT $ 87))
                                      (SPADCALL (|spadConstant| $ 16)
                                                (QREFELT $ 88))
                                      (QREFELT $ 18))
                            (PROGN
                             (LETT #2# (CONS 1 "failed"))
                             (GO #3=#:G878))))))))
                  (LETT |cc|
                        (COND
                         ((< |ord| 0)
                          (COND
                           ((QREFELT $ 10)
                            (COND
                             ((QREFELT $ 11)
                              (SEQ
                               (LETT |lc|
                                     (SPADCALL |uls| |ord| (QREFELT $ 26)))
                               (LETT |rat| (SPADCALL |lc| (QREFELT $ 90)))
                               (EXIT
                                (COND
                                 ((OR (QEQCAR |rat| 1)
                                      (SPADCALL (QCDR |rat|)
                                                (|spadConstant| $ 94)
                                                (QREFELT $ 95)))
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 91))
                                            (SPADCALL (QREFELT $ 92))
                                            (QREFELT $ 93)))
                                 ('T
                                  (SPADCALL
                                   (SPADCALL (SPADCALL 1 2 (QREFELT $ 91))
                                             (QREFELT $ 97))
                                   (SPADCALL (QREFELT $ 92))
                                   (QREFELT $ 93)))))))
                             (#4='T
                              (SPADCALL (SPADCALL 1 2 (QREFELT $ 91))
                                        (SPADCALL (QREFELT $ 92))
                                        (QREFELT $ 93)))))
                           (#4#
                            (PROGN
                             (LETT #1# (CONS 1 "failed"))
                             (GO #5=#:G879)))))
                         ((SPADCALL |coef| (|spadConstant| $ 12)
                                    (QREFELT $ 18))
                          (|spadConstant| $ 12))
                         ((QREFELT $ 10) (SPADCALL |coef| (QREFELT $ 98)))
                         (#4# (PROGN (LETT #1# (CONS 1 "failed")) (GO #5#)))))
                  (LETT |z|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 96)
                                   (SPADCALL |uls| |uls| (QREFELT $ 32))
                                   (QREFELT $ 99))
                         (QREFELT $ 81)))
                  (EXIT
                   (COND ((QEQCAR |z| 1) (CONS 1 "failed"))
                         (#4#
                          (CONS 0
                                (SPADCALL (SPADCALL |cc| (QREFELT $ 100))
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |uls| (QREFELT $ 101))
                                            (QCDR |z|) (QREFELT $ 32))
                                           (QREFELT $ 102))
                                          (QREFELT $ 99))))))))
            #3# (EXIT #2#)))
          #5# (EXIT #1#)))) 

(SDEFUN |EFULS;acotIfCan;ULSU;26| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG
         ((|z| (|Union| ULS "failed")) (|cc| (|Coef|)) (#1=#:G895 NIL)
          (|rat| (|Union| (|Fraction| (|Integer|)) "failed")) (|lc| (|Coef|))
          (#2=#:G894 NIL) (|ord| (|Integer|)) (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (SEQ
            (EXIT
             (SEQ (LETT |coef| (SPADCALL |uls| 0 (QREFELT $ 26)))
                  (SEQ (LETT |ord| (SPADCALL |uls| 0 (QREFELT $ 86)))
                       (EXIT
                        (COND
                         ((EQL |ord| 0)
                          (COND
                           ((SPADCALL (SPADCALL |coef| |coef| (QREFELT $ 87))
                                      (SPADCALL (|spadConstant| $ 16)
                                                (QREFELT $ 88))
                                      (QREFELT $ 18))
                            (PROGN
                             (LETT #2# (CONS 1 "failed"))
                             (GO #3=#:G892))))))))
                  (LETT |cc|
                        (COND
                         ((< |ord| 0)
                          (COND
                           ((QREFELT $ 11)
                            (SEQ
                             (LETT |lc| (SPADCALL |uls| |ord| (QREFELT $ 26)))
                             (LETT |rat| (SPADCALL |lc| (QREFELT $ 90)))
                             (EXIT
                              (COND
                               ((OR (QEQCAR |rat| 1)
                                    (SPADCALL (QCDR |rat|)
                                              (|spadConstant| $ 94)
                                              (QREFELT $ 95)))
                                (|spadConstant| $ 12))
                               ((QREFELT $ 10) (SPADCALL (QREFELT $ 92)))
                               (#4='T
                                (PROGN
                                 (LETT #1# (CONS 1 "failed"))
                                 (GO #5=#:G893)))))))
                           (#4# (|spadConstant| $ 12))))
                         ((QREFELT $ 10) (SPADCALL |coef| (QREFELT $ 104)))
                         (#4# (PROGN (LETT #1# (CONS 1 "failed")) (GO #5#)))))
                  (LETT |z|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 96)
                                   (SPADCALL |uls| |uls| (QREFELT $ 32))
                                   (QREFELT $ 99))
                         (QREFELT $ 81)))
                  (EXIT
                   (COND ((QEQCAR |z| 1) (CONS 1 "failed"))
                         (#4#
                          (CONS 0
                                (SPADCALL (SPADCALL |cc| (QREFELT $ 100))
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |uls| (QREFELT $ 101))
                                            (QCDR |z|) (QREFELT $ 32))
                                           (QREFELT $ 102))
                                          (QREFELT $ 105))))))))
            #3# (EXIT #2#)))
          #5# (EXIT #1#)))) 

(SDEFUN |EFULS;tanhIfCan;ULSU;27| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG
         ((|coshInv| (|Union| ULS "failed"))
          (|sc|
           (|Record| (|:| |sinh| (|Stream| |Coef|))
                     (|:| |cosh| (|Stream| |Coef|))))
          (|uts| (|Union| UTS "failed")))
         (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 42)))
              (EXIT
               (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ
                       (LETT |sc|
                             (SPADCALL (SPADCALL (QCDR |uts|) (QREFELT $ 76))
                                       (QREFELT $ 108)))
                       (LETT |coshInv|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QCDR |sc|) (QREFELT $ 80))
                                        (QREFELT $ 34))
                              (QREFELT $ 81)))
                       (EXIT
                        (COND ((QEQCAR |coshInv| 1) (CONS 1 "failed"))
                              (#1#
                               (CONS 0
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (QCAR |sc|) (QREFELT $ 80))
                                       (QREFELT $ 34))
                                      (QCDR |coshInv|)
                                      (QREFELT $ 32))))))))))))) 

(SDEFUN |EFULS;cothIfCan;ULSU;28| ((|uls| (ULS)) ($ (|Union| ULS "failed")))
        (SPROG
         ((|sinhInv| (|Union| ULS "failed"))
          (|sc|
           (|Record| (|:| |sinh| (|Stream| |Coef|))
                     (|:| |cosh| (|Stream| |Coef|))))
          (|uts| (|Union| UTS "failed")))
         (SEQ (LETT |uts| (SPADCALL |uls| (QREFELT $ 42)))
              (EXIT
               (COND ((QEQCAR |uts| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ
                       (LETT |sc|
                             (SPADCALL (SPADCALL (QCDR |uts|) (QREFELT $ 76))
                                       (QREFELT $ 108)))
                       (LETT |sinhInv|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QCAR |sc|) (QREFELT $ 80))
                                        (QREFELT $ 34))
                              (QREFELT $ 81)))
                       (EXIT
                        (COND ((QEQCAR |sinhInv| 1) (CONS 1 "failed"))
                              (#1#
                               (CONS 0
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (QCDR |sc|) (QREFELT $ 80))
                                       (QREFELT $ 34))
                                      (QCDR |sinhInv|)
                                      (QREFELT $ 32))))))))))))) 

(SDEFUN |EFULS;sechIfCan;ULSU;29| ((|uls| (ULS)) ($ (|Union| ULS #1="failed")))
        (SPROG ((|coshInv| (|Union| ULS "failed")) (|cosh| (|Union| ULS #1#)))
               (SEQ (LETT |cosh| (SPADCALL |uls| (QREFELT $ 60)))
                    (EXIT
                     (COND ((QEQCAR |cosh| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |coshInv|
                                   (SPADCALL (QCDR |cosh|) (QREFELT $ 81)))
                             (EXIT
                              (COND ((QEQCAR |coshInv| 1) (CONS 1 "failed"))
                                    (#2# (CONS 0 (QCDR |coshInv|)))))))))))) 

(SDEFUN |EFULS;cschIfCan;ULSU;30| ((|uls| (ULS)) ($ (|Union| ULS #1="failed")))
        (SPROG ((|sinhInv| (|Union| ULS "failed")) (|sinh| (|Union| ULS #1#)))
               (SEQ (LETT |sinh| (SPADCALL |uls| (QREFELT $ 58)))
                    (EXIT
                     (COND ((QEQCAR |sinh| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |sinhInv|
                                   (SPADCALL (QCDR |sinh|) (QREFELT $ 81)))
                             (EXIT
                              (COND ((QEQCAR |sinhInv| 1) (CONS 1 "failed"))
                                    (#2# (CONS 0 (QCDR |sinhInv|)))))))))))) 

(SDEFUN |EFULS;applyOrError|
        ((|fcn| (|Mapping| #1=(|Union| ULS "failed") ULS)) (|name| (|String|))
         (|uls| (ULS)) ($ (ULS)))
        (SPROG ((|ans| #1#))
               (SEQ (LETT |ans| (SPADCALL |uls| |fcn|))
                    (EXIT
                     (COND
                      ((QEQCAR |ans| 1)
                       (|error|
                        (STRCONC |name| " of function with singularity")))
                      ('T (QCDR |ans|))))))) 

(SDEFUN |EFULS;exp;2ULS;32| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 44) "exp" |uls| $)) 

(SDEFUN |EFULS;log;2ULS;33| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 74) "log" |uls| $)) 

(SDEFUN |EFULS;sin;2ULS;34| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 46) "sin" |uls| $)) 

(SDEFUN |EFULS;cos;2ULS;35| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 48) "cos" |uls| $)) 

(SDEFUN |EFULS;tan;2ULS;36| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 82) "tan" |uls| $)) 

(SDEFUN |EFULS;cot;2ULS;37| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 83) "cot" |uls| $)) 

(SDEFUN |EFULS;sec;2ULS;38| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 84) "sec" |uls| $)) 

(SDEFUN |EFULS;csc;2ULS;39| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 85) "csc" |uls| $)) 

(SDEFUN |EFULS;asin;2ULS;40| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 50) "asin" |uls| $)) 

(SDEFUN |EFULS;acos;2ULS;41| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 52) "acos" |uls| $)) 

(SDEFUN |EFULS;asec;2ULS;42| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 54) "asec" |uls| $)) 

(SDEFUN |EFULS;acsc;2ULS;43| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 56) "acsc" |uls| $)) 

(SDEFUN |EFULS;sinh;2ULS;44| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 58) "sinh" |uls| $)) 

(SDEFUN |EFULS;cosh;2ULS;45| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 60) "cosh" |uls| $)) 

(SDEFUN |EFULS;tanh;2ULS;46| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 109) "tanh" |uls| $)) 

(SDEFUN |EFULS;coth;2ULS;47| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 110) "coth" |uls| $)) 

(SDEFUN |EFULS;sech;2ULS;48| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 111) "sech" |uls| $)) 

(SDEFUN |EFULS;csch;2ULS;49| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 112) "csch" |uls| $)) 

(SDEFUN |EFULS;asinh;2ULS;50| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 62) "asinh" |uls| $)) 

(SDEFUN |EFULS;acosh;2ULS;51| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 64) "acosh" |uls| $)) 

(SDEFUN |EFULS;atanh;2ULS;52| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 66) "atanh" |uls| $)) 

(SDEFUN |EFULS;acoth;2ULS;53| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 68) "acoth" |uls| $)) 

(SDEFUN |EFULS;asech;2ULS;54| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 70) "asech" |uls| $)) 

(SDEFUN |EFULS;acsch;2ULS;55| ((|uls| (ULS)) ($ (ULS)))
        (|EFULS;applyOrError| (ELT $ 72) "acsch" |uls| $)) 

(SDEFUN |EFULS;atan;2ULS;56| ((|uls| (ULS)) ($ (ULS)))
        (SPROG
         ((|z| (|Union| ULS "failed")) (|cc| (|Coef|))
          (|rat| (|Union| (|Fraction| (|Integer|)) "failed")) (|lc| (|Coef|))
          (#1=#:G1067 NIL) (|ord| (|Integer|)) (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (SEQ (LETT |coef| (SPADCALL |uls| 0 (QREFELT $ 26)))
                (SEQ (LETT |ord| (SPADCALL |uls| 0 (QREFELT $ 86)))
                     (EXIT
                      (COND
                       ((EQL |ord| 0)
                        (COND
                         ((SPADCALL (SPADCALL |coef| |coef| (QREFELT $ 87))
                                    (SPADCALL (|spadConstant| $ 16)
                                              (QREFELT $ 88))
                                    (QREFELT $ 18))
                          (PROGN
                           (LETT #1#
                                 (|error|
                                  "atan: series expansion has logarithmic term"))
                           (GO #2=#:G1065))))))))
                (LETT |cc|
                      (COND
                       ((< |ord| 0)
                        (COND
                         ((QREFELT $ 10)
                          (COND
                           ((QREFELT $ 11)
                            (SEQ
                             (LETT |lc| (SPADCALL |uls| |ord| (QREFELT $ 26)))
                             (LETT |rat| (SPADCALL |lc| (QREFELT $ 90)))
                             (EXIT
                              (COND
                               ((OR (QEQCAR |rat| 1)
                                    (SPADCALL (QCDR |rat|)
                                              (|spadConstant| $ 94)
                                              (QREFELT $ 95)))
                                (SPADCALL (SPADCALL 1 2 (QREFELT $ 91))
                                          (SPADCALL (QREFELT $ 92))
                                          (QREFELT $ 93)))
                               ('T
                                (SPADCALL
                                 (SPADCALL (SPADCALL 1 2 (QREFELT $ 91))
                                           (QREFELT $ 97))
                                 (SPADCALL (QREFELT $ 92)) (QREFELT $ 93)))))))
                           (#3='T
                            (SPADCALL (SPADCALL 1 2 (QREFELT $ 91))
                                      (SPADCALL (QREFELT $ 92))
                                      (QREFELT $ 93)))))
                         (#3#
                          (|error|
                           "atan: series expansion involves transcendental constants"))))
                       ((SPADCALL |coef| (|spadConstant| $ 12) (QREFELT $ 18))
                        (|spadConstant| $ 12))
                       ((QREFELT $ 10) (SPADCALL |coef| (QREFELT $ 98)))
                       (#3#
                        (|error|
                         "atan: series expansion involves transcendental constants"))))
                (LETT |z|
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 96)
                                 (SPADCALL |uls| |uls| (QREFELT $ 32))
                                 (QREFELT $ 99))
                       (QREFELT $ 81)))
                (EXIT
                 (COND
                  ((QEQCAR |z| 1)
                   (|error| "atan: leading coefficient not invertible"))
                  (#3#
                   (SPADCALL (SPADCALL |cc| (QREFELT $ 100))
                             (SPADCALL
                              (SPADCALL (SPADCALL |uls| (QREFELT $ 101))
                                        (QCDR |z|) (QREFELT $ 32))
                              (QREFELT $ 102))
                             (QREFELT $ 99)))))))
          #2# (EXIT #1#)))) 

(SDEFUN |EFULS;acot;2ULS;57| ((|uls| (ULS)) ($ (ULS)))
        (SPROG
         ((|z| (|Union| ULS "failed")) (|cc| (|Coef|))
          (|rat| (|Union| (|Fraction| (|Integer|)) "failed")) (|lc| (|Coef|))
          (#1=#:G1080 NIL) (|ord| (|Integer|)) (|coef| (|Coef|)))
         (SEQ
          (EXIT
           (SEQ (LETT |coef| (SPADCALL |uls| 0 (QREFELT $ 26)))
                (SEQ (LETT |ord| (SPADCALL |uls| 0 (QREFELT $ 86)))
                     (EXIT
                      (COND
                       ((EQL |ord| 0)
                        (COND
                         ((SPADCALL (SPADCALL |coef| |coef| (QREFELT $ 87))
                                    (SPADCALL (|spadConstant| $ 16)
                                              (QREFELT $ 88))
                                    (QREFELT $ 18))
                          (PROGN
                           (LETT #1#
                                 (|error|
                                  "acot: series expansion has logarithmic term"))
                           (GO #2=#:G1078))))))))
                (LETT |cc|
                      (COND
                       ((< |ord| 0)
                        (COND
                         ((QREFELT $ 11)
                          (SEQ
                           (LETT |lc| (SPADCALL |uls| |ord| (QREFELT $ 26)))
                           (LETT |rat| (SPADCALL |lc| (QREFELT $ 90)))
                           (EXIT
                            (COND
                             ((OR (QEQCAR |rat| 1)
                                  (SPADCALL (QCDR |rat|) (|spadConstant| $ 94)
                                            (QREFELT $ 95)))
                              (|spadConstant| $ 12))
                             ((QREFELT $ 10) (SPADCALL (QREFELT $ 92)))
                             (#3='T
                              (|error|
                               "acot: series expansion involves transcendental constants"))))))
                         (#3# (|spadConstant| $ 12))))
                       ((QREFELT $ 10) (SPADCALL |coef| (QREFELT $ 104)))
                       (#3#
                        (|error|
                         "acot: series expansion involves transcendental constants"))))
                (LETT |z|
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 96)
                                 (SPADCALL |uls| |uls| (QREFELT $ 32))
                                 (QREFELT $ 99))
                       (QREFELT $ 81)))
                (EXIT
                 (COND
                  ((QEQCAR |z| 1)
                   (|error| "acot: leading coefficient not invertible"))
                  (#3#
                   (SPADCALL (SPADCALL |cc| (QREFELT $ 100))
                             (SPADCALL
                              (SPADCALL (SPADCALL |uls| (QREFELT $ 101))
                                        (QCDR |z|) (QREFELT $ 32))
                              (QREFELT $ 102))
                             (QREFELT $ 105)))))))
          #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |ElementaryFunctionsUnivariateLaurentSeries;|)) 

(DEFUN |ElementaryFunctionsUnivariateLaurentSeries| (&REST #1=#:G1081)
  (SPROG NIL
         (PROG (#2=#:G1082)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryFunctionsUnivariateLaurentSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |ElementaryFunctionsUnivariateLaurentSeries;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ElementaryFunctionsUnivariateLaurentSeries|)))))))))) 

(DEFUN |ElementaryFunctionsUnivariateLaurentSeries;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|ElementaryFunctionsUnivariateLaurentSeries| DV$1 DV$2
                      DV$3))
          (LETT $ (GETREFV 139))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache|
                      '|ElementaryFunctionsUnivariateLaurentSeries|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (|HasSignature| |#1|
                                    (LIST '^
                                          (LIST (|devaluate| |#1|)
                                                (|devaluate| |#1|)
                                                '(|Fraction| (|Integer|))))))
          (QSETREFV $ 10
                    (|HasCategory| |#1| '(|TranscendentalFunctionCategory|)))
          (QSETREFV $ 11
                    (|HasSignature| |#1|
                                    (LIST '|retractIfCan|
                                          (LIST
                                           (LIST '|Union|
                                                 '(|Fraction| (|Integer|))
                                                 (|devaluate| "failed"))
                                           (|devaluate| |#1|)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 40 (CONS (|dispatchFunction| |EFULS;^;ULSFULS;3|) $))))
          $))) 

(MAKEPROP '|ElementaryFunctionsUnivariateLaurentSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) 'RATPOWERS 'TRANSFCN 'RATS (0 . |Zero|)
              (4 . |Zero|) (|NonNegativeInteger|) (8 . |coefficient|)
              (14 . |One|) (|Boolean|) (18 . =) (|Integer|) (|Fraction| 19)
              (24 . |coerce|) (29 . |inv|) (34 . ^) (40 . |One|)
              (44 . |degree|) (49 . |coefficient|) (55 . |zero?|)
              (60 . |removeZeroes|) (|Union| $ '"failed") (66 . |exquo|)
              (72 . |monomial|) (78 . *) (84 . |taylor|) (89 . |coerce|)
              (|Union| 8 '"failed") |EFULS;nthRootIfCan;ULSNniU;2|
              (94 . |numer|) (99 . |denom|) (104 . ^) (110 . ^)
              (|Union| 7 '"failed") (116 . |taylorIfCan|) (121 . |exp|)
              |EFULS;expIfCan;ULSU;5| (126 . |sin|) |EFULS;sinIfCan;ULSU;6|
              (131 . |cos|) |EFULS;cosIfCan;ULSU;7| (136 . |asin|)
              |EFULS;asinIfCan;ULSU;8| (141 . |acos|) |EFULS;acosIfCan;ULSU;9|
              (146 . |asec|) |EFULS;asecIfCan;ULSU;10| (151 . |acsc|)
              |EFULS;acscIfCan;ULSU;11| (156 . |sinh|)
              |EFULS;sinhIfCan;ULSU;12| (161 . |cosh|)
              |EFULS;coshIfCan;ULSU;13| (166 . |asinh|)
              |EFULS;asinhIfCan;ULSU;14| (171 . |acosh|)
              |EFULS;acoshIfCan;ULSU;15| (176 . |atanh|)
              |EFULS;atanhIfCan;ULSU;16| (181 . |acoth|)
              |EFULS;acothIfCan;ULSU;17| (186 . |asech|)
              |EFULS;asechIfCan;ULSU;18| (191 . |acsch|)
              |EFULS;acschIfCan;ULSU;19| (196 . |log|) |EFULS;logIfCan;ULSU;20|
              (|Stream| 6) (201 . |coefficients|)
              (|Record| (|:| |sin| 75) (|:| |cos| 75))
              (|StreamTranscendentalFunctions| 6) (206 . |sincos|)
              (211 . |series|) (216 . |recip|) |EFULS;tanIfCan;ULSU;21|
              |EFULS;cotIfCan;ULSU;22| |EFULS;secIfCan;ULSU;23|
              |EFULS;cscIfCan;ULSU;24| (221 . |order|) (227 . *) (233 . -)
              (|Union| 20 '"failed") (238 . |retractIfCan|) (243 . /)
              (249 . |pi|) (253 . *) (259 . |Zero|) (263 . >) (269 . |One|)
              (273 . -) (278 . |atan|) (283 . +) (289 . |coerce|)
              (294 . |differentiate|) (299 . |integrate|)
              |EFULS;atanIfCan;ULSU;25| (304 . |acot|) (309 . -)
              |EFULS;acotIfCan;ULSU;26|
              (|Record| (|:| |sinh| 75) (|:| |cosh| 75)) (315 . |sinhcosh|)
              |EFULS;tanhIfCan;ULSU;27| |EFULS;cothIfCan;ULSU;28|
              |EFULS;sechIfCan;ULSU;29| |EFULS;cschIfCan;ULSU;30|
              |EFULS;exp;2ULS;32| |EFULS;log;2ULS;33| |EFULS;sin;2ULS;34|
              |EFULS;cos;2ULS;35| |EFULS;tan;2ULS;36| |EFULS;cot;2ULS;37|
              |EFULS;sec;2ULS;38| |EFULS;csc;2ULS;39| |EFULS;asin;2ULS;40|
              |EFULS;acos;2ULS;41| |EFULS;asec;2ULS;42| |EFULS;acsc;2ULS;43|
              |EFULS;sinh;2ULS;44| |EFULS;cosh;2ULS;45| |EFULS;tanh;2ULS;46|
              |EFULS;coth;2ULS;47| |EFULS;sech;2ULS;48| |EFULS;csch;2ULS;49|
              |EFULS;asinh;2ULS;50| |EFULS;acosh;2ULS;51| |EFULS;atanh;2ULS;52|
              |EFULS;acoth;2ULS;53| |EFULS;asech;2ULS;54| |EFULS;acsch;2ULS;55|
              |EFULS;atan;2ULS;56| |EFULS;acot;2ULS;57|)
           '#(|tanhIfCan| 320 |tanh| 325 |tanIfCan| 330 |tan| 335 |sinhIfCan|
              340 |sinh| 345 |sinIfCan| 350 |sin| 355 |sechIfCan| 360 |sech|
              365 |secIfCan| 370 |sec| 375 |nthRootIfCan| 380 |logIfCan| 386
              |log| 391 |expIfCan| 396 |exp| 401 |cschIfCan| 406 |csch| 411
              |cscIfCan| 416 |csc| 421 |cothIfCan| 426 |coth| 431 |cotIfCan|
              436 |cot| 441 |coshIfCan| 446 |cosh| 451 |cosIfCan| 456 |cos| 461
              |atanhIfCan| 466 |atanh| 471 |atanIfCan| 476 |atan| 481
              |asinhIfCan| 486 |asinh| 491 |asinIfCan| 496 |asin| 501
              |asechIfCan| 506 |asech| 511 |asecIfCan| 516 |asec| 521
              |acschIfCan| 526 |acsch| 531 |acscIfCan| 536 |acsc| 541
              |acothIfCan| 546 |acoth| 551 |acotIfCan| 556 |acot| 561
              |acoshIfCan| 566 |acosh| 571 |acosIfCan| 576 |acos| 581 ^ 586)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|PartialTranscendentalFunctions| 8))
                             (|makeByteWordVec2| 138
                                                 '(0 6 0 12 0 7 0 13 2 7 6 0 14
                                                   15 0 6 0 16 2 6 17 0 0 18 1
                                                   20 0 19 21 1 20 0 0 22 2 7 0
                                                   0 20 23 0 7 0 24 1 8 19 0 25
                                                   2 8 6 0 19 26 1 6 17 0 27 2
                                                   8 0 19 0 28 2 19 29 0 0 30 2
                                                   8 0 6 19 31 2 8 0 0 0 32 1 8
                                                   7 0 33 1 8 0 7 34 1 20 19 0
                                                   37 1 20 19 0 38 2 8 0 0 19
                                                   39 2 0 8 8 20 40 1 8 41 0 42
                                                   1 7 0 0 43 1 7 0 0 45 1 7 0
                                                   0 47 1 7 0 0 49 1 7 0 0 51 1
                                                   7 0 0 53 1 7 0 0 55 1 7 0 0
                                                   57 1 7 0 0 59 1 7 0 0 61 1 7
                                                   0 0 63 1 7 0 0 65 1 7 0 0 67
                                                   1 7 0 0 69 1 7 0 0 71 1 7 0
                                                   0 73 1 7 75 0 76 1 78 77 75
                                                   79 1 7 0 75 80 1 8 29 0 81 2
                                                   8 19 0 19 86 2 6 0 0 0 87 1
                                                   6 0 0 88 1 6 89 0 90 2 20 0
                                                   19 19 91 0 6 0 92 2 6 0 20 0
                                                   93 0 20 0 94 2 20 17 0 0 95
                                                   0 8 0 96 1 20 0 0 97 1 6 0 0
                                                   98 2 8 0 0 0 99 1 8 0 6 100
                                                   1 8 0 0 101 1 8 0 0 102 1 6
                                                   0 0 104 2 8 0 0 0 105 1 78
                                                   107 75 108 1 0 35 8 109 1 0
                                                   8 8 127 1 0 35 8 82 1 0 8 8
                                                   117 1 0 35 8 58 1 0 8 8 125
                                                   1 0 35 8 46 1 0 8 8 115 1 0
                                                   35 8 111 1 0 8 8 129 1 0 35
                                                   8 84 1 0 8 8 119 2 0 35 8 14
                                                   36 1 0 35 8 74 1 0 8 8 114 1
                                                   0 35 8 44 1 0 8 8 113 1 0 35
                                                   8 112 1 0 8 8 130 1 0 35 8
                                                   85 1 0 8 8 120 1 0 35 8 110
                                                   1 0 8 8 128 1 0 35 8 83 1 0
                                                   8 8 118 1 0 35 8 60 1 0 8 8
                                                   126 1 0 35 8 48 1 0 8 8 116
                                                   1 0 35 8 66 1 0 8 8 133 1 0
                                                   35 8 103 1 0 8 8 137 1 0 35
                                                   8 62 1 0 8 8 131 1 0 35 8 50
                                                   1 0 8 8 121 1 0 35 8 70 1 0
                                                   8 8 135 1 0 35 8 54 1 0 8 8
                                                   123 1 0 35 8 72 1 0 8 8 136
                                                   1 0 35 8 56 1 0 8 8 124 1 0
                                                   35 8 68 1 0 8 8 134 1 0 35 8
                                                   106 1 0 8 8 138 1 0 35 8 64
                                                   1 0 8 8 132 1 0 35 8 52 1 0
                                                   8 8 122 2 1 8 8 20 40)))))
           '|lookupComplete|)) 
