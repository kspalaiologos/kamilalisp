
(SDEFUN |FLOATCP;complexRoots;FParL;1|
        ((|q| (|Fraction| (|Polynomial| (|Complex| (|Integer|)))))
         (|eps| (|Par|)) ($ (|List| (|Complex| |Par|))))
        (SPROG ((|p| (|Polynomial| (|Complex| (|Integer|)))))
               (SEQ (LETT |p| (SPADCALL |q| (QREFELT $ 9)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| (QREFELT $ 11)) |eps|
                               (QREFELT $ 14)))))) 

(SDEFUN |FLOATCP;complexRoots;LLParL;2|
        ((|lp| (|List| (|Fraction| (|Polynomial| (|Complex| (|Integer|))))))
         (|lv| (|List| (|Symbol|))) (|eps| (|Par|))
         ($ (|List| (|List| (|Complex| |Par|)))))
        (SPROG
         ((|lden| (|List| #1=(|Polynomial| (|Complex| (|Integer|)))))
          (|dp| #1#) (#2=#:G722 NIL) (|p| NIL) (#3=#:G721 NIL)
          (|lnum| (|List| (|Polynomial| (|Complex| (|Integer|)))))
          (#4=#:G720 NIL) (#5=#:G719 NIL))
         (SEQ
          (LETT |lnum|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |p| NIL) (LETT #4# |lp|) G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #5# (CONS (SPADCALL |p| (QREFELT $ 9)) #5#))))
                      (LETT #4# (CDR #4#)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |lden|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |p| NIL) (LETT #2# |lp|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |dp| (SPADCALL |p| (QREFELT $ 16)))
                                    (|spadConstant| $ 17) (QREFELT $ 19))
                          (LETT #3# (CONS |dp| #3#))))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |lnum| |lden| |lv| |eps| (QREFELT $ 24)))))) 

(SDEFUN |FLOATCP;complexSolve;LParL;3|
        ((|lp| (|List| (|Fraction| (|Polynomial| (|Complex| (|Integer|))))))
         (|eps| (|Par|))
         ($ (|List| (|List| (|Equation| (|Polynomial| (|Complex| |Par|)))))))
        (SPROG
         ((#1=#:G749 NIL) (|x| NIL) (#2=#:G750 NIL) (|r| NIL) (#3=#:G748 NIL)
          (#4=#:G747 NIL) (|nres| NIL) (#5=#:G746 NIL)
          (|lv| #6=(|List| (|Symbol|))) (#7=#:G731 NIL) (#8=#:G730 #6#)
          (#9=#:G732 #6#) (#10=#:G745 NIL) (#11=#:G728 NIL) (#12=#:G727 #6#)
          (#13=#:G729 #6#) (#14=#:G744 NIL) (|np| NIL)
          (|lden| (|List| #15=(|Polynomial| (|Complex| (|Integer|)))))
          (|dp| #15#) (#16=#:G743 NIL) (|p| NIL) (#17=#:G742 NIL)
          (|lnum| (|List| (|Polynomial| (|Complex| (|Integer|)))))
          (#18=#:G741 NIL) (#19=#:G740 NIL))
         (SEQ
          (LETT |lnum|
                (PROGN
                 (LETT #19# NIL)
                 (SEQ (LETT |p| NIL) (LETT #18# |lp|) G190
                      (COND
                       ((OR (ATOM #18#) (PROGN (LETT |p| (CAR #18#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #19# (CONS (SPADCALL |p| (QREFELT $ 9)) #19#))))
                      (LETT #18# (CDR #18#)) (GO G190) G191
                      (EXIT (NREVERSE #19#)))))
          (LETT |lden|
                (PROGN
                 (LETT #17# NIL)
                 (SEQ (LETT |p| NIL) (LETT #16# |lp|) G190
                      (COND
                       ((OR (ATOM #16#) (PROGN (LETT |p| (CAR #16#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |dp| (SPADCALL |p| (QREFELT $ 16)))
                                    (|spadConstant| $ 17) (QREFELT $ 19))
                          (LETT #17# (CONS |dp| #17#))))))
                      (LETT #16# (CDR #16#)) (GO G190) G191
                      (EXIT (NREVERSE #17#)))))
          (LETT |lv|
                (PROGN
                 (LETT #11# NIL)
                 (SEQ (LETT |np| NIL) (LETT #14# |lnum|) G190
                      (COND
                       ((OR (ATOM #14#) (PROGN (LETT |np| (CAR #14#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #13# (SPADCALL |np| (QREFELT $ 27)))
                         (COND
                          (#11#
                           (LETT #12# (SPADCALL #12# #13# (QREFELT $ 28))))
                          ('T (PROGN (LETT #12# #13#) (LETT #11# 'T)))))))
                      (LETT #14# (CDR #14#)) (GO G190) G191 (EXIT NIL))
                 (COND (#11# #12#) (#20='T (|IdentityError| '|setUnion|)))))
          (COND
           ((SPADCALL |lden| NIL (QREFELT $ 29))
            (LETT |lv|
                  (SPADCALL |lv|
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT #10# |lden|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |dp| (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #9# (SPADCALL |dp| (QREFELT $ 27)))
                                     (COND
                                      (#7#
                                       (LETT #8#
                                             (SPADCALL #8# #9#
                                                       (QREFELT $ 28))))
                                      ('T
                                       (PROGN
                                        (LETT #8# #9#)
                                        (LETT #7# 'T)))))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#7# #8#)
                                   (#20# (|IdentityError| '|setUnion|))))
                            (QREFELT $ 28)))))
          (EXIT
           (PROGN
            (LETT #5# NIL)
            (SEQ (LETT |nres| NIL)
                 (LETT #4# (SPADCALL |lnum| |lden| |lv| |eps| (QREFELT $ 24)))
                 G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |nres| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #5#
                         (CONS
                          (PROGN
                           (LETT #3# NIL)
                           (SEQ (LETT |r| NIL) (LETT #2# |nres|) (LETT |x| NIL)
                                (LETT #1# |lv|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |x| (CAR #1#)) NIL)
                                      (ATOM #2#)
                                      (PROGN (LETT |r| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #3#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |x| (QREFELT $ 32))
                                          (SPADCALL |r| (QREFELT $ 34))
                                          (QREFELT $ 36))
                                         #3#))))
                                (LETT #1#
                                      (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                                (GO G190) G191 (EXIT (NREVERSE #3#))))
                          #5#))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT (NREVERSE #5#)))))))) 

(SDEFUN |FLOATCP;complexSolve;LParL;4|
        ((|le|
          (|List|
           (|Equation| (|Fraction| (|Polynomial| (|Complex| (|Integer|)))))))
         (|eps| (|Par|))
         ($ (|List| (|List| (|Equation| (|Polynomial| (|Complex| |Par|)))))))
        (SPROG
         ((#1=#:G781 NIL) (|x| NIL) (#2=#:G782 NIL) (|r| NIL) (#3=#:G780 NIL)
          (#4=#:G779 NIL) (|nres| NIL) (#5=#:G778 NIL)
          (|lv| #6=(|List| (|Symbol|))) (#7=#:G761 NIL) (#8=#:G760 #6#)
          (#9=#:G762 #6#) (#10=#:G777 NIL) (#11=#:G758 NIL) (#12=#:G757 #6#)
          (#13=#:G759 #6#) (#14=#:G776 NIL) (|np| NIL)
          (|lden| (|List| #15=(|Polynomial| (|Complex| (|Integer|)))))
          (|dp| #15#) (#16=#:G775 NIL) (|p| NIL) (#17=#:G774 NIL)
          (|lnum| (|List| (|Polynomial| (|Complex| (|Integer|)))))
          (#18=#:G773 NIL) (#19=#:G772 NIL)
          (|lp| (|List| (|Fraction| (|Polynomial| (|Complex| (|Integer|))))))
          (#20=#:G771 NIL) (|ep| NIL) (#21=#:G770 NIL))
         (SEQ
          (LETT |lp|
                (PROGN
                 (LETT #21# NIL)
                 (SEQ (LETT |ep| NIL) (LETT #20# |le|) G190
                      (COND
                       ((OR (ATOM #20#) (PROGN (LETT |ep| (CAR #20#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #21#
                              (CONS
                               (SPADCALL (SPADCALL |ep| (QREFELT $ 40))
                                         (SPADCALL |ep| (QREFELT $ 41))
                                         (QREFELT $ 42))
                               #21#))))
                      (LETT #20# (CDR #20#)) (GO G190) G191
                      (EXIT (NREVERSE #21#)))))
          (LETT |lnum|
                (PROGN
                 (LETT #19# NIL)
                 (SEQ (LETT |p| NIL) (LETT #18# |lp|) G190
                      (COND
                       ((OR (ATOM #18#) (PROGN (LETT |p| (CAR #18#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #19# (CONS (SPADCALL |p| (QREFELT $ 9)) #19#))))
                      (LETT #18# (CDR #18#)) (GO G190) G191
                      (EXIT (NREVERSE #19#)))))
          (LETT |lden|
                (PROGN
                 (LETT #17# NIL)
                 (SEQ (LETT |p| NIL) (LETT #16# |lp|) G190
                      (COND
                       ((OR (ATOM #16#) (PROGN (LETT |p| (CAR #16#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |dp| (SPADCALL |p| (QREFELT $ 16)))
                                    (|spadConstant| $ 17) (QREFELT $ 19))
                          (LETT #17# (CONS |dp| #17#))))))
                      (LETT #16# (CDR #16#)) (GO G190) G191
                      (EXIT (NREVERSE #17#)))))
          (LETT |lv|
                (PROGN
                 (LETT #11# NIL)
                 (SEQ (LETT |np| NIL) (LETT #14# |lnum|) G190
                      (COND
                       ((OR (ATOM #14#) (PROGN (LETT |np| (CAR #14#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #13# (SPADCALL |np| (QREFELT $ 27)))
                         (COND
                          (#11#
                           (LETT #12# (SPADCALL #12# #13# (QREFELT $ 28))))
                          ('T (PROGN (LETT #12# #13#) (LETT #11# 'T)))))))
                      (LETT #14# (CDR #14#)) (GO G190) G191 (EXIT NIL))
                 (COND (#11# #12#) (#22='T (|IdentityError| '|setUnion|)))))
          (COND
           ((SPADCALL |lden| NIL (QREFELT $ 29))
            (LETT |lv|
                  (SPADCALL |lv|
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT #10# |lden|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |dp| (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #9# (SPADCALL |dp| (QREFELT $ 27)))
                                     (COND
                                      (#7#
                                       (LETT #8#
                                             (SPADCALL #8# #9#
                                                       (QREFELT $ 28))))
                                      ('T
                                       (PROGN
                                        (LETT #8# #9#)
                                        (LETT #7# 'T)))))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#7# #8#)
                                   (#22# (|IdentityError| '|setUnion|))))
                            (QREFELT $ 28)))))
          (EXIT
           (PROGN
            (LETT #5# NIL)
            (SEQ (LETT |nres| NIL)
                 (LETT #4# (SPADCALL |lnum| |lden| |lv| |eps| (QREFELT $ 24)))
                 G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |nres| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #5#
                         (CONS
                          (PROGN
                           (LETT #3# NIL)
                           (SEQ (LETT |r| NIL) (LETT #2# |nres|) (LETT |x| NIL)
                                (LETT #1# |lv|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |x| (CAR #1#)) NIL)
                                      (ATOM #2#)
                                      (PROGN (LETT |r| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #3#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |x| (QREFELT $ 32))
                                          (SPADCALL |r| (QREFELT $ 34))
                                          (QREFELT $ 36))
                                         #3#))))
                                (LETT #1#
                                      (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                                (GO G190) G191 (EXIT (NREVERSE #3#))))
                          #5#))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT (NREVERSE #5#)))))))) 

(SDEFUN |FLOATCP;complexSolve;FParL;5|
        ((|p| (|Fraction| (|Polynomial| (|Complex| (|Integer|)))))
         (|eps| (|Par|))
         ($ (|List| (|Equation| (|Polynomial| (|Complex| |Par|))))))
        (SPROG
         ((#1=#:G792 NIL) (|val| NIL) (#2=#:G791 NIL)
          (|x| (|Polynomial| (|Complex| |Par|)))
          (|mvar| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |mvar| (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 46)))
          (EXIT
           (COND ((QEQCAR |mvar| 1) (|error| "no variable found"))
                 ('T
                  (SEQ (LETT |x| (SPADCALL (QCDR |mvar|) (QREFELT $ 32)))
                       (EXIT
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |val| NIL)
                              (LETT #1# (SPADCALL |p| |eps| (QREFELT $ 15)))
                              G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |val| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (SPADCALL |x|
                                                 (SPADCALL |val|
                                                           (QREFELT $ 34))
                                                 (QREFELT $ 36))
                                       #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))))))))) 

(SDEFUN |FLOATCP;complexSolve;EParL;6|
        ((|eq|
          (|Equation| (|Fraction| (|Polynomial| (|Complex| (|Integer|))))))
         (|eps| (|Par|))
         ($ (|List| (|Equation| (|Polynomial| (|Complex| |Par|))))))
        (SPADCALL
         (SPADCALL (SPADCALL |eq| (QREFELT $ 40))
                   (SPADCALL |eq| (QREFELT $ 41)) (QREFELT $ 42))
         |eps| (QREFELT $ 48))) 

(DECLAIM (NOTINLINE |FloatingComplexPackage;|)) 

(DEFUN |FloatingComplexPackage| (#1=#:G794)
  (SPROG NIL
         (PROG (#2=#:G795)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FloatingComplexPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|FloatingComplexPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FloatingComplexPackage|)))))))))) 

(DEFUN |FloatingComplexPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FloatingComplexPackage| DV$1))
          (LETT $ (GETREFV 50))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FloatingComplexPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FloatingComplexPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Polynomial| (|Complex| (|Integer|))) (|Fraction| 7)
              (0 . |numer|)
              (|SparseUnivariatePolynomial| (|Complex| (|Integer|)))
              (5 . |univariate|) (|List| 33) (|ComplexRootPackage| 10 6)
              (10 . |complexZeros|) |FLOATCP;complexRoots;FParL;1|
              (16 . |denom|) (21 . |One|) (|Boolean|) (25 . ~=) (|List| 12)
              (|List| 7) (|List| 30)
              (|InnerNumericFloatSolvePackage| (|Complex| (|Integer|)) 33 6)
              (31 . |innerSolve|) (|List| 8) |FLOATCP;complexRoots;LLParL;2|
              (39 . |variables|) (44 . |setUnion|) (50 . ~=) (|Symbol|)
              (|Polynomial| 33) (56 . |coerce|) (|Complex| 6) (61 . |coerce|)
              (|Equation| 31) (66 . |equation|) (|List| 47)
              |FLOATCP;complexSolve;LParL;3| (|Equation| 8) (72 . |lhs|)
              (77 . |rhs|) (82 . -) (|List| 39) |FLOATCP;complexSolve;LParL;4|
              (|Union| 30 '"failed") (88 . |mainVariable|) (|List| 35)
              |FLOATCP;complexSolve;FParL;5| |FLOATCP;complexSolve;EParL;6|)
           '#(|complexSolve| 93 |complexRoots| 117) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|complexSolve|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Polynomial| (|Complex| |#1|)))))
                                  (|List|
                                   (|Fraction|
                                    (|Polynomial| (|Complex| (|Integer|)))))
                                  |#1|))
                                T)
                              '((|complexSolve|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Polynomial| (|Complex| |#1|)))))
                                  (|List|
                                   (|Equation|
                                    (|Fraction|
                                     (|Polynomial| (|Complex| (|Integer|))))))
                                  |#1|))
                                T)
                              '((|complexSolve|
                                 ((|List|
                                   (|Equation|
                                    (|Polynomial| (|Complex| |#1|))))
                                  (|Fraction|
                                   (|Polynomial| (|Complex| (|Integer|))))
                                  |#1|))
                                T)
                              '((|complexSolve|
                                 ((|List|
                                   (|Equation|
                                    (|Polynomial| (|Complex| |#1|))))
                                  (|Equation|
                                   (|Fraction|
                                    (|Polynomial| (|Complex| (|Integer|)))))
                                  |#1|))
                                T)
                              '((|complexRoots|
                                 ((|List| (|Complex| |#1|))
                                  (|Fraction|
                                   (|Polynomial| (|Complex| (|Integer|))))
                                  |#1|))
                                T)
                              '((|complexRoots|
                                 ((|List| (|List| (|Complex| |#1|)))
                                  (|List|
                                   (|Fraction|
                                    (|Polynomial| (|Complex| (|Integer|)))))
                                  (|List| (|Symbol|)) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 49
                                            '(1 8 7 0 9 1 7 10 0 11 2 13 12 10
                                              6 14 1 8 7 0 16 0 7 0 17 2 7 18 0
                                              0 19 4 23 20 21 21 22 6 24 1 7 22
                                              0 27 2 22 0 0 0 28 2 21 18 0 0 29
                                              1 31 0 30 32 1 31 0 33 34 2 35 0
                                              31 31 36 1 39 8 0 40 1 39 8 0 41
                                              2 8 0 0 0 42 1 7 45 0 46 2 0 37
                                              25 6 38 2 0 47 8 6 48 2 0 37 43 6
                                              44 2 0 47 39 6 49 3 0 20 25 22 6
                                              26 2 0 12 8 6 15)))))
           '|lookupComplete|)) 
