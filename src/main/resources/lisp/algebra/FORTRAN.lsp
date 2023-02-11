
(SDEFUN |FORTRAN;makeRep| ((|b| (|List| (|FortranCode|))) ($ ($)))
        (CONS (SPADCALL (QREFELT $ 12)) |b|)) 

(PUT '|FORTRAN;codeFrom| '|SPADreplace| 'QCDR) 

(SDEFUN |FORTRAN;codeFrom| ((|u| ($)) ($ (|List| (|FortranCode|)))) (QCDR |u|)) 

(SDEFUN |FORTRAN;outputAsFortran;$V;3| ((|p| ($)) ($ (|Void|)))
        (SPROG
         ((#1=#:G736 NIL) (|expr| NIL) (|intrinsics| (|List| (|String|)))
          (|body| (|List| (|List| (|String|)))) (#2=#:G735 NIL) (|l| NIL)
          (#3=#:G734 NIL) (|tempName| (|Symbol|)))
         (SEQ (SPADCALL 25000 (QREFELT $ 15)) (LETT |tempName| 'FPTEMP)
              (SPADCALL |tempName| (QREFELT $ 19)) (SPADCALL (QREFELT $ 21))
              (LETT |body|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |l| NIL) (LETT #2# (|FORTRAN;codeFrom| |p| $))
                          G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |l| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #3#
                                  (CONS (SPADCALL |l| (QREFELT $ 23)) #3#))))
                          (LETT #2# (CDR #2#)) (GO G190) G191
                          (EXIT (NREVERSE #3#)))))
              (LETT |intrinsics| (SPADCALL (QREFELT $ 24)))
              (SPADCALL (QREFELT $ 25))
              (SPADCALL (QREFELT $ 6) (QREFELT $ 7) (QREFELT $ 8)
                        (QREFELT $ 28))
              (SPADCALL (QREFELT $ 9) (QREFELT $ 29))
              (SPADCALL (QCAR |p|) (QREFELT $ 29))
              (SPADCALL |tempName| (QREFELT $ 30))
              (COND
               ((NULL (NULL |intrinsics|))
                (SPADCALL "INTRINSIC" |intrinsics| (QREFELT $ 32))))
              (SPADCALL |tempName| (QREFELT $ 33))
              (SEQ (LETT |expr| NIL) (LETT #1# |body|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |expr| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |expr| (QREFELT $ 34))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (SPADCALL 'END (QREFELT $ 36)) (QREFELT $ 37)))))) 

(SDEFUN |FORTRAN;mkString| ((|l| (|List| (|Symbol|))) ($ (|String|)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 40)) (QREFELT $ 41))) 

(SDEFUN |FORTRAN;checkVariables|
        ((|user| (|List| (|Symbol|))) (|target| (|List| (|Symbol|)))
         ($ (|Void|)))
        (SPROG ((|s2| #1=(|String|)) (|s1| #1#))
               (SEQ
                (COND
                 ((SPADCALL
                   (SPADCALL (SPADCALL (ELT $ 42) |user| (QREFELT $ 44))
                             |target| (QREFELT $ 45))
                   NIL (QREFELT $ 47))
                  (SEQ (LETT |s1| (|FORTRAN;mkString| |user| $))
                       (LETT |s2| (|FORTRAN;mkString| |target| $))
                       (EXIT
                        (|error|
                         (LIST '|mathprint|
                               (LIST 'CONCAT
                                     (SPADCALL "Incompatible variable lists:"
                                               (QREFELT $ 48))
                                     (SPADCALL |s1| (QREFELT $ 48))
                                     (SPADCALL |s2| (QREFELT $ 48))))))))
                 ('T (SPADCALL (QREFELT $ 49))))))) 

(SDEFUN |FORTRAN;coerce;E$;6| ((|u| (|Expression| (|MachineInteger|))) ($ ($)))
        (SPROG ((|l| (|List| (|FortranCode|))))
               (SEQ
                (|FORTRAN;checkVariables| (SPADCALL |u| (QREFELT $ 51))
                 (QREFELT $ 8) $)
                (LETT |l|
                      (LIST (SPADCALL (QREFELT $ 6) |u| (QREFELT $ 52))
                            (SPADCALL (QREFELT $ 53))))
                (EXIT (|FORTRAN;makeRep| |l| $))))) 

(SDEFUN |FORTRAN;coerce;E$;7|
        ((|u| (|Equation| (|Expression| (|MachineInteger|)))) ($ ($)))
        (SPROG
         ((|eList| (|List| (|Equation| (|Expression| (|MachineInteger|)))))
          (#1=#:G768 NIL) (|w| NIL) (#2=#:G769 NIL) (|v| NIL) (#3=#:G767 NIL)
          (|aeList| (|List| (|Expression| (|MachineInteger|)))) (#4=#:G766 NIL)
          (#5=#:G765 NIL) (|veList| (|List| (|Expression| (|MachineInteger|))))
          (#6=#:G764 NIL) (#7=#:G763 NIL) (|vList| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((QEQCAR (SPADCALL (SPADCALL |u| (QREFELT $ 56)) (QREFELT $ 58)) 1)
            (|error| "left hand side is not a kernel"))
           (#8='T
            (SEQ
             (LETT |vList|
                   (SPADCALL (SPADCALL |u| (QREFELT $ 56)) (QREFELT $ 51)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |vList|) (LENGTH (QREFELT $ 8))
                          (QREFELT $ 60))
                (|error| "Incorrect number of arguments"))
               (#8#
                (SEQ
                 (LETT |veList|
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |w| NIL) (LETT #6# |vList|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (SPADCALL |w| (QREFELT $ 61))
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#)))))
                 (LETT |aeList|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# (QREFELT $ 8)) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #5#
                                     (CONS (SPADCALL |w| (QREFELT $ 61))
                                           #5#))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#)))))
                 (LETT |eList|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |v| NIL) (LETT #2# |aeList|) (LETT |w| NIL)
                             (LETT #1# |veList|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS (SPADCALL |w| |v| (QREFELT $ 62))
                                           #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL (SPADCALL |u| (QREFELT $ 63)) |eList|
                             (QREFELT $ 65))
                   (QREFELT $ 54))))))))))))) 

(SDEFUN |FORTRAN;coerce;E$;8| ((|u| (|Expression| (|MachineFloat|))) ($ ($)))
        (SPROG ((|l| (|List| (|FortranCode|))))
               (SEQ
                (|FORTRAN;checkVariables| (SPADCALL |u| (QREFELT $ 68))
                 (QREFELT $ 8) $)
                (LETT |l|
                      (LIST (SPADCALL (QREFELT $ 6) |u| (QREFELT $ 69))
                            (SPADCALL (QREFELT $ 53))))
                (EXIT (|FORTRAN;makeRep| |l| $))))) 

(SDEFUN |FORTRAN;coerce;E$;9|
        ((|u| (|Equation| (|Expression| (|MachineFloat|)))) ($ ($)))
        (SPROG
         ((|eList| (|List| (|Equation| (|Expression| (|MachineFloat|)))))
          (#1=#:G792 NIL) (|w| NIL) (#2=#:G793 NIL) (|v| NIL) (#3=#:G791 NIL)
          (|aeList| (|List| (|Expression| (|MachineFloat|)))) (#4=#:G790 NIL)
          (#5=#:G789 NIL) (|veList| (|List| (|Expression| (|MachineFloat|))))
          (#6=#:G788 NIL) (#7=#:G787 NIL) (|vList| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((QEQCAR (SPADCALL (SPADCALL |u| (QREFELT $ 72)) (QREFELT $ 73)) 1)
            (|error| "left hand side is not a kernel"))
           (#8='T
            (SEQ
             (LETT |vList|
                   (SPADCALL (SPADCALL |u| (QREFELT $ 72)) (QREFELT $ 68)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |vList|) (LENGTH (QREFELT $ 8))
                          (QREFELT $ 60))
                (|error| "Incorrect number of arguments"))
               (#8#
                (SEQ
                 (LETT |veList|
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |w| NIL) (LETT #6# |vList|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (SPADCALL |w| (QREFELT $ 74))
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#)))))
                 (LETT |aeList|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# (QREFELT $ 8)) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #5#
                                     (CONS (SPADCALL |w| (QREFELT $ 74))
                                           #5#))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#)))))
                 (LETT |eList|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |v| NIL) (LETT #2# |aeList|) (LETT |w| NIL)
                             (LETT #1# |veList|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS (SPADCALL |w| |v| (QREFELT $ 75))
                                           #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL (SPADCALL |u| (QREFELT $ 76)) |eList|
                             (QREFELT $ 77))
                   (QREFELT $ 70))))))))))))) 

(SDEFUN |FORTRAN;coerce;E$;10|
        ((|u| (|Expression| (|MachineComplex|))) ($ ($)))
        (SPROG ((|l| (|List| (|FortranCode|))))
               (SEQ
                (|FORTRAN;checkVariables| (SPADCALL |u| (QREFELT $ 80))
                 (QREFELT $ 8) $)
                (LETT |l|
                      (LIST (SPADCALL (QREFELT $ 6) |u| (QREFELT $ 81))
                            (SPADCALL (QREFELT $ 53))))
                (EXIT (|FORTRAN;makeRep| |l| $))))) 

(SDEFUN |FORTRAN;coerce;E$;11|
        ((|u| (|Equation| (|Expression| (|MachineComplex|)))) ($ ($)))
        (SPROG
         ((|eList| (|List| (|Equation| (|Expression| (|MachineComplex|)))))
          (#1=#:G818 NIL) (|w| NIL) (#2=#:G819 NIL) (|v| NIL) (#3=#:G817 NIL)
          (|aeList| (|List| (|Expression| (|MachineComplex|)))) (#4=#:G816 NIL)
          (#5=#:G815 NIL) (|veList| (|List| (|Expression| (|MachineComplex|))))
          (#6=#:G814 NIL) (#7=#:G813 NIL) (|vList| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((QEQCAR (SPADCALL (SPADCALL |u| (QREFELT $ 84)) (QREFELT $ 85)) 1)
            (|error| "left hand side is not a kernel"))
           (#8='T
            (SEQ
             (LETT |vList|
                   (SPADCALL (SPADCALL |u| (QREFELT $ 84)) (QREFELT $ 80)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |vList|) (LENGTH (QREFELT $ 8))
                          (QREFELT $ 60))
                (|error| "Incorrect number of arguments"))
               (#8#
                (SEQ
                 (LETT |veList|
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |w| NIL) (LETT #6# |vList|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (SPADCALL |w| (QREFELT $ 86))
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#)))))
                 (LETT |aeList|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# (QREFELT $ 8)) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #5#
                                     (CONS (SPADCALL |w| (QREFELT $ 86))
                                           #5#))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#)))))
                 (LETT |eList|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |v| NIL) (LETT #2# |aeList|) (LETT |w| NIL)
                             (LETT #1# |veList|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS (SPADCALL |w| |v| (QREFELT $ 87))
                                           #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL (SPADCALL |u| (QREFELT $ 88)) |eList|
                             (QREFELT $ 89))
                   (QREFELT $ 82))))))))))))) 

(PUT '|FORTRAN;coerce;R$;12| '|SPADreplace| '(XLAM (|u|) |u|)) 

(SDEFUN |FORTRAN;coerce;R$;12|
        ((|u|
          (|Record| (|:| |localSymbols| (|SymbolTable|))
                    (|:| |code| (|List| (|FortranCode|)))))
         ($ ($)))
        |u|) 

(SDEFUN |FORTRAN;coerce;$Of;13| ((|u| ($)) ($ (|OutputForm|)))
        (SPADCALL (QREFELT $ 6) (QREFELT $ 36))) 

(SDEFUN |FORTRAN;coerce;L$;14| ((|c| (|List| (|FortranCode|))) ($ ($)))
        (|FORTRAN;makeRep| |c| $)) 

(SDEFUN |FORTRAN;coerce;Fc$;15| ((|c| (|FortranCode|)) ($ ($)))
        (|FORTRAN;makeRep| (LIST |c|) $)) 

(SDEFUN |FORTRAN;coerce;E$;16| ((|u| (|Expression| (|Integer|))) ($ ($)))
        (SPROG ((|l| (|List| (|FortranCode|))))
               (SEQ
                (|FORTRAN;checkVariables| (SPADCALL |u| (QREFELT $ 98))
                 (QREFELT $ 8) $)
                (LETT |l|
                      (LIST (SPADCALL (QREFELT $ 6) |u| (QREFELT $ 99))
                            (SPADCALL (QREFELT $ 53))))
                (EXIT (|FORTRAN;makeRep| |l| $))))) 

(SDEFUN |FORTRAN;coerce;E$;17|
        ((|u| (|Equation| (|Expression| (|Integer|)))) ($ ($)))
        (SPROG
         ((|eList| (|List| (|Equation| (|Expression| (|Integer|)))))
          (#1=#:G847 NIL) (|w| NIL) (#2=#:G848 NIL) (|v| NIL) (#3=#:G846 NIL)
          (|aeList| (|List| (|Expression| (|Integer|)))) (#4=#:G845 NIL)
          (#5=#:G844 NIL) (|veList| (|List| (|Expression| (|Integer|))))
          (#6=#:G843 NIL) (#7=#:G842 NIL) (|vList| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((QEQCAR (SPADCALL (SPADCALL |u| (QREFELT $ 102)) (QREFELT $ 103))
                    1)
            (|error| "left hand side is not a kernel"))
           (#8='T
            (SEQ
             (LETT |vList|
                   (SPADCALL (SPADCALL |u| (QREFELT $ 102)) (QREFELT $ 98)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |vList|) (LENGTH (QREFELT $ 8))
                          (QREFELT $ 60))
                (|error| "Incorrect number of arguments"))
               (#8#
                (SEQ
                 (LETT |veList|
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |w| NIL) (LETT #6# |vList|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (SPADCALL |w| (QREFELT $ 104))
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#)))))
                 (LETT |aeList|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# (QREFELT $ 8)) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #5#
                                     (CONS (SPADCALL |w| (QREFELT $ 104))
                                           #5#))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#)))))
                 (LETT |eList|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |v| NIL) (LETT #2# |aeList|) (LETT |w| NIL)
                             (LETT #1# |veList|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS (SPADCALL |w| |v| (QREFELT $ 105))
                                           #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL (SPADCALL |u| (QREFELT $ 106)) |eList|
                             (QREFELT $ 107))
                   (QREFELT $ 100))))))))))))) 

(SDEFUN |FORTRAN;coerce;E$;18| ((|u| (|Expression| (|Float|))) ($ ($)))
        (SPROG ((|l| (|List| (|FortranCode|))))
               (SEQ
                (|FORTRAN;checkVariables| (SPADCALL |u| (QREFELT $ 110))
                 (QREFELT $ 8) $)
                (LETT |l|
                      (LIST (SPADCALL (QREFELT $ 6) |u| (QREFELT $ 111))
                            (SPADCALL (QREFELT $ 53))))
                (EXIT (|FORTRAN;makeRep| |l| $))))) 

(SDEFUN |FORTRAN;coerce;E$;19|
        ((|u| (|Equation| (|Expression| (|Float|)))) ($ ($)))
        (SPROG
         ((|eList| (|List| (|Equation| (|Expression| (|Float|)))))
          (#1=#:G871 NIL) (|w| NIL) (#2=#:G872 NIL) (|v| NIL) (#3=#:G870 NIL)
          (|aeList| (|List| (|Expression| (|Float|)))) (#4=#:G869 NIL)
          (#5=#:G868 NIL) (|veList| (|List| (|Expression| (|Float|))))
          (#6=#:G867 NIL) (#7=#:G866 NIL) (|vList| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((QEQCAR (SPADCALL (SPADCALL |u| (QREFELT $ 114)) (QREFELT $ 115))
                    1)
            (|error| "left hand side is not a kernel"))
           (#8='T
            (SEQ
             (LETT |vList|
                   (SPADCALL (SPADCALL |u| (QREFELT $ 114)) (QREFELT $ 110)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |vList|) (LENGTH (QREFELT $ 8))
                          (QREFELT $ 60))
                (|error| "Incorrect number of arguments"))
               (#8#
                (SEQ
                 (LETT |veList|
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |w| NIL) (LETT #6# |vList|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (SPADCALL |w| (QREFELT $ 116))
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#)))))
                 (LETT |aeList|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# (QREFELT $ 8)) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #5#
                                     (CONS (SPADCALL |w| (QREFELT $ 116))
                                           #5#))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#)))))
                 (LETT |eList|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |v| NIL) (LETT #2# |aeList|) (LETT |w| NIL)
                             (LETT #1# |veList|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS (SPADCALL |w| |v| (QREFELT $ 117))
                                           #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL (SPADCALL |u| (QREFELT $ 118)) |eList|
                             (QREFELT $ 119))
                   (QREFELT $ 112))))))))))))) 

(SDEFUN |FORTRAN;coerce;E$;20|
        ((|u| (|Expression| (|Complex| (|Float|)))) ($ ($)))
        (SPROG ((|l| (|List| (|FortranCode|))))
               (SEQ
                (|FORTRAN;checkVariables| (SPADCALL |u| (QREFELT $ 122))
                 (QREFELT $ 8) $)
                (LETT |l|
                      (LIST (SPADCALL (QREFELT $ 6) |u| (QREFELT $ 123))
                            (SPADCALL (QREFELT $ 53))))
                (EXIT (|FORTRAN;makeRep| |l| $))))) 

(SDEFUN |FORTRAN;coerce;E$;21|
        ((|u| (|Equation| (|Expression| (|Complex| (|Float|))))) ($ ($)))
        (SPROG
         ((|eList| (|List| (|Equation| (|Expression| (|Complex| (|Float|))))))
          (#1=#:G899 NIL) (|w| NIL) (#2=#:G900 NIL) (|v| NIL) (#3=#:G898 NIL)
          (|aeList| (|List| (|Expression| (|Complex| (|Float|)))))
          (#4=#:G897 NIL) (#5=#:G896 NIL)
          (|veList| (|List| (|Expression| (|Complex| (|Float|)))))
          (#6=#:G895 NIL) (#7=#:G894 NIL) (|vList| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((QEQCAR (SPADCALL (SPADCALL |u| (QREFELT $ 126)) (QREFELT $ 127))
                    1)
            (|error| "left hand side is not a kernel"))
           (#8='T
            (SEQ
             (LETT |vList|
                   (SPADCALL (SPADCALL |u| (QREFELT $ 126)) (QREFELT $ 122)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |vList|) (LENGTH (QREFELT $ 8))
                          (QREFELT $ 60))
                (|error| "Incorrect number of arguments"))
               (#8#
                (SEQ
                 (LETT |veList|
                       (PROGN
                        (LETT #7# NIL)
                        (SEQ (LETT |w| NIL) (LETT #6# |vList|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #7#
                                     (CONS (SPADCALL |w| (QREFELT $ 128))
                                           #7#))))
                             (LETT #6# (CDR #6#)) (GO G190) G191
                             (EXIT (NREVERSE #7#)))))
                 (LETT |aeList|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |w| NIL) (LETT #4# (QREFELT $ 8)) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |w| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #5#
                                     (CONS (SPADCALL |w| (QREFELT $ 128))
                                           #5#))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#)))))
                 (LETT |eList|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |v| NIL) (LETT #2# |aeList|) (LETT |w| NIL)
                             (LETT #1# |veList|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL)
                                   (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS (SPADCALL |w| |v| (QREFELT $ 129))
                                           #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL (SPADCALL |u| (QREFELT $ 130)) |eList|
                             (QREFELT $ 131))
                   (QREFELT $ 124))))))))))))) 

(DECLAIM (NOTINLINE |FortranProgram;|)) 

(DEFUN |FortranProgram| (&REST #1=#:G901)
  (SPROG NIL
         (PROG (#2=#:G902)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL NIL NIL))
                     (HGET |$ConstructorCache| '|FortranProgram|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FortranProgram;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FortranProgram|)))))))))) 

(DEFUN |FortranProgram;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT |dv$| (LIST '|FortranProgram| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 133))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FortranProgram|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10
              (|Record| (|:| |localSymbols| (|SymbolTable|))
                        (|:| |code| (|List| (|FortranCode|)))))
    $))) 

(MAKEPROP '|FortranProgram| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|Rep| (|SymbolTable|)
              (0 . |empty|) (|SingleInteger|) (|FortranCode|)
              (4 . |setLabelValue|) (|Void|) (|Symbol|) (|TheSymbolTable|)
              (9 . |newSubProgram|) (|FortranCodeTools|)
              (14 . |clear_used_intrinsics|) (|List| 31) (18 . |getCode|)
              (23 . |get_used_intrinsics|) (27 . |endSubProgram|)
              (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| '"void"))
              (|List| 17) (31 . |fortFormatHead|) (38 . |printTypes|)
              (43 . |printTypes|) (|String|) (48 . |fortFormatTypeLines|)
              (54 . |clearTheSymbolTable|) (59 . |displayLines|) (|OutputForm|)
              (64 . |coerce|) (69 . |dispStatement|)
              |FORTRAN;outputAsFortran;$V;3| (|InputForm|) (74 . |convert|)
              (79 . |unparse|) (84 . |name|) (|Mapping| 17 17) (89 . |map|)
              (95 . |setDifference|) (|Boolean|) (101 . ~=) (107 . |coerce|)
              (112 . |void|) (|Expression| (|MachineInteger|))
              (116 . |variables|) (121 . |assign|) (127 . |returns|)
              |FORTRAN;coerce;E$;6| (|Equation| 50) (131 . |lhs|)
              (|Union| (|Kernel| $) '"failed") (136 . |retractIfCan|)
              (|NonNegativeInteger|) (141 . ~=) (147 . |coerce|)
              (152 . |equation|) (158 . |rhs|) (|List| (|Equation| $))
              (163 . |subst|) |FORTRAN;coerce;E$;7|
              (|Expression| (|MachineFloat|)) (169 . |variables|)
              (174 . |assign|) |FORTRAN;coerce;E$;8| (|Equation| 67)
              (180 . |lhs|) (185 . |retractIfCan|) (190 . |coerce|)
              (195 . |equation|) (201 . |rhs|) (206 . |subst|)
              |FORTRAN;coerce;E$;9| (|Expression| (|MachineComplex|))
              (212 . |variables|) (217 . |assign|) |FORTRAN;coerce;E$;10|
              (|Equation| 79) (223 . |lhs|) (228 . |retractIfCan|)
              (233 . |coerce|) (238 . |equation|) (244 . |rhs|) (249 . |subst|)
              |FORTRAN;coerce;E$;11|
              (|Record| (|:| |localSymbols| 11) (|:| |code| 94))
              |FORTRAN;coerce;R$;12| |FORTRAN;coerce;$Of;13| (|List| 14)
              |FORTRAN;coerce;L$;14| |FORTRAN;coerce;Fc$;15|
              (|Expression| (|Integer|)) (255 . |variables|) (260 . |assign|)
              |FORTRAN;coerce;E$;16| (|Equation| 97) (266 . |lhs|)
              (271 . |retractIfCan|) (276 . |coerce|) (281 . |equation|)
              (287 . |rhs|) (292 . |subst|) |FORTRAN;coerce;E$;17|
              (|Expression| (|Float|)) (298 . |variables|) (303 . |assign|)
              |FORTRAN;coerce;E$;18| (|Equation| 109) (309 . |lhs|)
              (314 . |retractIfCan|) (319 . |coerce|) (324 . |equation|)
              (330 . |rhs|) (335 . |subst|) |FORTRAN;coerce;E$;19|
              (|Expression| (|Complex| (|Float|))) (341 . |variables|)
              (346 . |assign|) |FORTRAN;coerce;E$;20| (|Equation| 121)
              (352 . |lhs|) (357 . |retractIfCan|) (362 . |coerce|)
              (367 . |equation|) (373 . |rhs|) (378 . |subst|)
              |FORTRAN;coerce;E$;21|)
           '#(|outputAsFortran| 384 |coerce| 389) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(NIL NIL NIL)
                       (CONS
                        '#((|FortranProgramCategory|) (|Type|)
                           (|CoercibleTo| 35))
                        (|makeByteWordVec2| 132
                                            '(0 11 0 12 1 14 13 13 15 1 18 16
                                              17 19 0 20 16 21 1 14 22 0 23 0
                                              20 22 24 0 18 17 25 3 20 16 17 26
                                              27 28 1 11 16 0 29 1 18 16 17 30
                                              2 20 16 31 22 32 1 18 16 17 33 1
                                              20 16 22 34 1 17 35 0 36 1 20 16
                                              35 37 1 27 39 0 40 1 39 31 0 41 1
                                              17 0 0 42 2 27 0 43 0 44 2 27 0 0
                                              0 45 2 27 46 0 0 47 1 31 35 0 48
                                              0 16 0 49 1 50 27 0 51 2 14 0 17
                                              50 52 0 14 0 53 1 55 50 0 56 1 50
                                              57 0 58 2 59 46 0 0 60 1 50 0 17
                                              61 2 55 0 50 50 62 1 55 50 0 63 2
                                              50 0 0 64 65 1 67 27 0 68 2 14 0
                                              17 67 69 1 71 67 0 72 1 67 57 0
                                              73 1 67 0 17 74 2 71 0 67 67 75 1
                                              71 67 0 76 2 67 0 0 64 77 1 79 27
                                              0 80 2 14 0 17 79 81 1 83 79 0 84
                                              1 79 57 0 85 1 79 0 17 86 2 83 0
                                              79 79 87 1 83 79 0 88 2 79 0 0 64
                                              89 1 97 27 0 98 2 14 0 17 97 99 1
                                              101 97 0 102 1 97 57 0 103 1 97 0
                                              17 104 2 101 0 97 97 105 1 101 97
                                              0 106 2 97 0 0 64 107 1 109 27 0
                                              110 2 14 0 17 109 111 1 113 109 0
                                              114 1 109 57 0 115 1 109 0 17 116
                                              2 113 0 109 109 117 1 113 109 0
                                              118 2 109 0 0 64 119 1 121 27 0
                                              122 2 14 0 17 121 123 1 125 121 0
                                              126 1 121 57 0 127 1 121 0 17 128
                                              2 125 0 121 121 129 1 125 121 0
                                              130 2 121 0 0 64 131 1 0 16 0 38
                                              1 0 0 113 120 1 0 0 125 132 1 0 0
                                              121 124 1 0 0 101 108 1 0 0 97
                                              100 1 0 0 109 112 1 0 0 71 78 1 0
                                              0 83 90 1 0 0 79 82 1 0 0 55 66 1
                                              0 0 50 54 1 0 0 67 70 1 0 0 94 95
                                              1 0 0 91 92 1 0 0 14 96 1 0 35 0
                                              93)))))
           '|lookupComplete|)) 
