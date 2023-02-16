
(SDEFUN |FLOATRP;makeEq|
        ((|nres| (|List| |Par|)) (|lv| (|List| (|Symbol|)))
         ($ (|List| (|Equation| (|Polynomial| |Par|)))))
        (SPROG
         ((#1=#:G702 NIL) (|x| NIL) (#2=#:G703 NIL) (|r| NIL) (#3=#:G701 NIL))
         (SEQ
          (PROGN
           (LETT #3# NIL)
           (SEQ (LETT |r| NIL) (LETT #2# |nres|) (LETT |x| NIL) (LETT #1# |lv|)
                G190
                (COND
                 ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL) (ATOM #2#)
                      (PROGN (LETT |r| (CAR #2#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (LETT #3#
                        (CONS
                         (SPADCALL (SPADCALL |x| (QREFELT $ 9))
                                   (SPADCALL |r| (QREFELT $ 10))
                                   (QREFELT $ 12))
                         #3#))))
                (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                G191 (EXIT (NREVERSE #3#))))))) 

(SDEFUN |FLOATRP;realRoots;FParL;2|
        ((|p| (|Fraction| (|Polynomial| (|Integer|)))) (|eps| (|Par|))
         ($ (|List| |Par|)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 15)) |eps| (QREFELT $ 18))) 

(SDEFUN |FLOATRP;realRoots;LLParL;3|
        ((|lp| (|List| (|Fraction| (|Polynomial| (|Integer|)))))
         (|lv| (|List| (|Symbol|))) (|eps| (|Par|))
         ($ (|List| (|List| |Par|))))
        (SPROG
         ((|lden| (|List| #1=(|Polynomial| (|Integer|)))) (|dp| #1#)
          (#2=#:G722 NIL) (|p| NIL) (#3=#:G721 NIL)
          (|lnum| (|List| (|Polynomial| (|Integer|)))) (#4=#:G720 NIL)
          (#5=#:G719 NIL))
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
                        (LETT #5# (CONS (SPADCALL |p| (QREFELT $ 15)) #5#))))
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
                         ((SPADCALL (LETT |dp| (SPADCALL |p| (QREFELT $ 20)))
                                    (|spadConstant| $ 21) (QREFELT $ 23))
                          (LETT #3# (CONS |dp| #3#))))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |lnum| |lden| |lv| |eps| (QREFELT $ 27)))))) 

(SDEFUN |FLOATRP;solve;LParL;4|
        ((|lp| (|List| (|Fraction| (|Polynomial| (|Integer|)))))
         (|eps| (|Par|))
         ($ (|List| (|List| (|Equation| (|Polynomial| |Par|))))))
        (SPROG
         ((#1=#:G745 NIL) (|numres| NIL) (#2=#:G744 NIL)
          (|lv| #3=(|List| (|Symbol|))) (#4=#:G731 NIL) (#5=#:G730 #3#)
          (#6=#:G732 #3#) (#7=#:G743 NIL) (#8=#:G728 NIL) (#9=#:G727 #3#)
          (#10=#:G729 #3#) (#11=#:G742 NIL) (|np| NIL)
          (|lden| (|List| #12=(|Polynomial| (|Integer|)))) (|dp| #12#)
          (#13=#:G741 NIL) (|p| NIL) (#14=#:G740 NIL)
          (|lnum| (|List| (|Polynomial| (|Integer|)))) (#15=#:G739 NIL)
          (#16=#:G738 NIL))
         (SEQ
          (LETT |lnum|
                (PROGN
                 (LETT #16# NIL)
                 (SEQ (LETT |p| NIL) (LETT #15# |lp|) G190
                      (COND
                       ((OR (ATOM #15#) (PROGN (LETT |p| (CAR #15#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #16# (CONS (SPADCALL |p| (QREFELT $ 15)) #16#))))
                      (LETT #15# (CDR #15#)) (GO G190) G191
                      (EXIT (NREVERSE #16#)))))
          (LETT |lden|
                (PROGN
                 (LETT #14# NIL)
                 (SEQ (LETT |p| NIL) (LETT #13# |lp|) G190
                      (COND
                       ((OR (ATOM #13#) (PROGN (LETT |p| (CAR #13#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |dp| (SPADCALL |p| (QREFELT $ 20)))
                                    (|spadConstant| $ 21) (QREFELT $ 23))
                          (LETT #14# (CONS |dp| #14#))))))
                      (LETT #13# (CDR #13#)) (GO G190) G191
                      (EXIT (NREVERSE #14#)))))
          (LETT |lv|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |np| NIL) (LETT #11# |lnum|) G190
                      (COND
                       ((OR (ATOM #11#) (PROGN (LETT |np| (CAR #11#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #10# (SPADCALL |np| (QREFELT $ 30)))
                         (COND
                          (#8# (LETT #9# (SPADCALL #9# #10# (QREFELT $ 31))))
                          ('T (PROGN (LETT #9# #10#) (LETT #8# 'T)))))))
                      (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                 (COND (#8# #9#) (#17='T (|IdentityError| '|setUnion|)))))
          (COND
           ((SPADCALL |lden| NIL (QREFELT $ 32))
            (LETT |lv|
                  (SPADCALL |lv|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT #7# |lden|) G190
                                  (COND
                                   ((OR (ATOM #7#)
                                        (PROGN (LETT |dp| (CAR #7#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #6# (SPADCALL |dp| (QREFELT $ 30)))
                                     (COND
                                      (#4#
                                       (LETT #5#
                                             (SPADCALL #5# #6#
                                                       (QREFELT $ 31))))
                                      ('T
                                       (PROGN
                                        (LETT #5# #6#)
                                        (LETT #4# 'T)))))))
                                  (LETT #7# (CDR #7#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#4# #5#)
                                   (#17# (|IdentityError| '|setUnion|))))
                            (QREFELT $ 31)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |numres| NIL)
                 (LETT #1# (SPADCALL |lnum| |lden| |lv| |eps| (QREFELT $ 27)))
                 G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |numres| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (|FLOATRP;makeEq| |numres| |lv| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |FLOATRP;solve;LParL;5|
        ((|le| (|List| (|Equation| (|Fraction| (|Polynomial| (|Integer|))))))
         (|eps| (|Par|))
         ($ (|List| (|List| (|Equation| (|Polynomial| |Par|))))))
        (SPROG
         ((#1=#:G772 NIL) (|numres| NIL) (#2=#:G771 NIL)
          (|lv| #3=(|List| (|Symbol|))) (#4=#:G756 NIL) (#5=#:G755 #3#)
          (#6=#:G757 #3#) (#7=#:G770 NIL) (#8=#:G753 NIL) (#9=#:G752 #3#)
          (#10=#:G754 #3#) (#11=#:G769 NIL) (|np| NIL)
          (|lden| (|List| #12=(|Polynomial| (|Integer|)))) (|dp| #12#)
          (#13=#:G768 NIL) (|p| NIL) (#14=#:G767 NIL)
          (|lnum| (|List| (|Polynomial| (|Integer|)))) (#15=#:G766 NIL)
          (#16=#:G765 NIL)
          (|lp| (|List| (|Fraction| (|Polynomial| (|Integer|)))))
          (#17=#:G764 NIL) (|ep| NIL) (#18=#:G763 NIL))
         (SEQ
          (LETT |lp|
                (PROGN
                 (LETT #18# NIL)
                 (SEQ (LETT |ep| NIL) (LETT #17# |le|) G190
                      (COND
                       ((OR (ATOM #17#) (PROGN (LETT |ep| (CAR #17#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #18#
                              (CONS
                               (SPADCALL (SPADCALL |ep| (QREFELT $ 36))
                                         (SPADCALL |ep| (QREFELT $ 37))
                                         (QREFELT $ 38))
                               #18#))))
                      (LETT #17# (CDR #17#)) (GO G190) G191
                      (EXIT (NREVERSE #18#)))))
          (LETT |lnum|
                (PROGN
                 (LETT #16# NIL)
                 (SEQ (LETT |p| NIL) (LETT #15# |lp|) G190
                      (COND
                       ((OR (ATOM #15#) (PROGN (LETT |p| (CAR #15#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #16# (CONS (SPADCALL |p| (QREFELT $ 15)) #16#))))
                      (LETT #15# (CDR #15#)) (GO G190) G191
                      (EXIT (NREVERSE #16#)))))
          (LETT |lden|
                (PROGN
                 (LETT #14# NIL)
                 (SEQ (LETT |p| NIL) (LETT #13# |lp|) G190
                      (COND
                       ((OR (ATOM #13#) (PROGN (LETT |p| (CAR #13#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |dp| (SPADCALL |p| (QREFELT $ 20)))
                                    (|spadConstant| $ 21) (QREFELT $ 23))
                          (LETT #14# (CONS |dp| #14#))))))
                      (LETT #13# (CDR #13#)) (GO G190) G191
                      (EXIT (NREVERSE #14#)))))
          (LETT |lv|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |np| NIL) (LETT #11# |lnum|) G190
                      (COND
                       ((OR (ATOM #11#) (PROGN (LETT |np| (CAR #11#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #10# (SPADCALL |np| (QREFELT $ 30)))
                         (COND
                          (#8# (LETT #9# (SPADCALL #9# #10# (QREFELT $ 31))))
                          ('T (PROGN (LETT #9# #10#) (LETT #8# 'T)))))))
                      (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                 (COND (#8# #9#) (#19='T (|IdentityError| '|setUnion|)))))
          (COND
           ((SPADCALL |lden| NIL (QREFELT $ 32))
            (LETT |lv|
                  (SPADCALL |lv|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT #7# |lden|) G190
                                  (COND
                                   ((OR (ATOM #7#)
                                        (PROGN (LETT |dp| (CAR #7#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #6# (SPADCALL |dp| (QREFELT $ 30)))
                                     (COND
                                      (#4#
                                       (LETT #5#
                                             (SPADCALL #5# #6#
                                                       (QREFELT $ 31))))
                                      ('T
                                       (PROGN
                                        (LETT #5# #6#)
                                        (LETT #4# 'T)))))))
                                  (LETT #7# (CDR #7#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#4# #5#)
                                   (#19# (|IdentityError| '|setUnion|))))
                            (QREFELT $ 31)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |numres| NIL)
                 (LETT #1# (SPADCALL |lnum| |lden| |lv| |eps| (QREFELT $ 27)))
                 G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |numres| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (|FLOATRP;makeEq| |numres| |lv| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |FLOATRP;solve;FParL;6|
        ((|p| (|Fraction| (|Polynomial| (|Integer|)))) (|eps| (|Par|))
         ($ (|List| (|Equation| (|Polynomial| |Par|)))))
        (SPROG
         ((#1=#:G782 NIL) (|val| NIL) (#2=#:G781 NIL)
          (|x| (|Polynomial| |Par|)) (|mvar| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |mvar| (SPADCALL (SPADCALL |p| (QREFELT $ 15)) (QREFELT $ 42)))
          (EXIT
           (COND ((QEQCAR |mvar| 1) (|error| "no variable found"))
                 ('T
                  (SEQ (LETT |x| (SPADCALL (QCDR |mvar|) (QREFELT $ 9)))
                       (EXIT
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |val| NIL)
                              (LETT #1# (SPADCALL |p| |eps| (QREFELT $ 19)))
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
                                                           (QREFELT $ 10))
                                                 (QREFELT $ 12))
                                       #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))))))))) 

(SDEFUN |FLOATRP;solve;EParL;7|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| (|Integer|)))))
         (|eps| (|Par|)) ($ (|List| (|Equation| (|Polynomial| |Par|)))))
        (SPADCALL
         (SPADCALL (SPADCALL |eq| (QREFELT $ 36))
                   (SPADCALL |eq| (QREFELT $ 37)) (QREFELT $ 38))
         |eps| (QREFELT $ 44))) 

(DECLAIM (NOTINLINE |FloatingRealPackage;|)) 

(DEFUN |FloatingRealPackage| (#1=#:G784)
  (SPROG NIL
         (PROG (#2=#:G785)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FloatingRealPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FloatingRealPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FloatingRealPackage|)))))))))) 

(DEFUN |FloatingRealPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FloatingRealPackage| DV$1))
          (LETT $ (GETREFV 46))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FloatingRealPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FloatingRealPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|)
              (|Polynomial| 6) (0 . |coerce|) (5 . |coerce|) (|Equation| 8)
              (10 . |equation|) (|Polynomial| (|Integer|)) (|Fraction| 13)
              (16 . |numer|) (|List| 6)
              (|InnerNumericFloatSolvePackage| (|Integer|) 6 6)
              (21 . |innerSolve1|) |FLOATRP;realRoots;FParL;2| (27 . |denom|)
              (32 . |One|) (|Boolean|) (36 . ~=) (|List| 16) (|List| 13)
              (|List| 7) (42 . |innerSolve|) (|List| 14)
              |FLOATRP;realRoots;LLParL;3| (50 . |variables|) (55 . |setUnion|)
              (61 . ~=) (|List| 43) |FLOATRP;solve;LParL;4| (|Equation| 14)
              (67 . |lhs|) (72 . |rhs|) (77 . -) (|List| 35)
              |FLOATRP;solve;LParL;5| (|Union| 7 '"failed")
              (83 . |mainVariable|) (|List| 11) |FLOATRP;solve;FParL;6|
              |FLOATRP;solve;EParL;7|)
           '#(|solve| 88 |realRoots| 112) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|List|
                                   (|List| (|Equation| (|Polynomial| |#1|))))
                                  (|List|
                                   (|Fraction| (|Polynomial| (|Integer|))))
                                  |#1|))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|List| (|Equation| (|Polynomial| |#1|))))
                                  (|List|
                                   (|Equation|
                                    (|Fraction| (|Polynomial| (|Integer|)))))
                                  |#1|))
                                T)
                              '((|solve|
                                 ((|List| (|Equation| (|Polynomial| |#1|)))
                                  (|Fraction| (|Polynomial| (|Integer|)))
                                  |#1|))
                                T)
                              '((|solve|
                                 ((|List| (|Equation| (|Polynomial| |#1|)))
                                  (|Equation|
                                   (|Fraction| (|Polynomial| (|Integer|))))
                                  |#1|))
                                T)
                              '((|realRoots|
                                 ((|List| (|List| |#1|))
                                  (|List|
                                   (|Fraction| (|Polynomial| (|Integer|))))
                                  (|List| (|Symbol|)) |#1|))
                                T)
                              '((|realRoots|
                                 ((|List| |#1|)
                                  (|Fraction| (|Polynomial| (|Integer|)))
                                  |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 45
                                            '(1 8 0 7 9 1 8 0 6 10 2 11 0 8 8
                                              12 1 14 13 0 15 2 17 16 13 6 18 1
                                              14 13 0 20 0 13 0 21 2 13 22 0 0
                                              23 4 17 24 25 25 26 6 27 1 13 26
                                              0 30 2 26 0 0 0 31 2 25 22 0 0 32
                                              1 35 14 0 36 1 35 14 0 37 2 14 0
                                              0 0 38 1 13 41 0 42 2 0 33 28 6
                                              34 2 0 43 14 6 44 2 0 33 39 6 40
                                              2 0 43 35 6 45 2 0 16 14 6 19 3 0
                                              24 28 26 6 29)))))
           '|lookupComplete|)) 
