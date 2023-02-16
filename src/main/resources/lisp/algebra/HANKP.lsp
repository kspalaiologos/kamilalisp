
(SDEFUN |HANKP;HankelMatrix;LM;1| ((|l| (|List| R)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G718 NIL) (|x| NIL) (#2=#:G719 NIL) (|i| NIL) (#3=#:G717 NIL)
          (|lloc| (|List| R)) (#4=#:G716 NIL) (|j| NIL) (#5=#:G715 NIL)
          (|n| (|Integer|)) (#6=#:G702 NIL))
         (SEQ
          (COND ((NULL (ODDP (LENGTH |l|))) (|error| "n must be odd"))
                ('T
                 (SEQ
                  (LETT |n|
                        (PROG2
                            (LETT #6#
                                  (SPADCALL (+ (LENGTH |l|) 1) 2
                                            (QREFELT $ 10)))
                            (QCDR #6#)
                          (|check_union2| (QEQCAR #6# 0) (|NonNegativeInteger|)
                                          (|Union| (|NonNegativeInteger|)
                                                   "failed")
                                          #6#)))
                  (LETT |lloc| (CONS (|spadConstant| $ 11) |l|))
                  (EXIT
                   (SPADCALL (ELT $ 13)
                             (PROGN
                              (LETT #5# NIL)
                              (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                                   (COND ((|greater_SI| |j| #4#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #5#
                                           (CONS
                                            (SEQ (LETT |lloc| (CDR |lloc|))
                                                 (EXIT
                                                  (SPADCALL
                                                   (LIST
                                                    (PROGN
                                                     (LETT #3# NIL)
                                                     (SEQ (LETT |i| 1)
                                                          (LETT #2# |n|)
                                                          (LETT |x| NIL)
                                                          (LETT #1# |lloc|)
                                                          G190
                                                          (COND
                                                           ((OR (ATOM #1#)
                                                                (PROGN
                                                                 (LETT |x|
                                                                       (CAR
                                                                        #1#))
                                                                 NIL)
                                                                (|greater_SI|
                                                                 |i| #2#))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #3#
                                                                  (CONS |x|
                                                                        #3#))))
                                                          (LETT #1#
                                                                (PROG1
                                                                    (CDR #1#)
                                                                  (LETT |i|
                                                                        (|inc_SI|
                                                                         |i|))))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #3#)))))
                                                   (QREFELT $ 15))))
                                            #5#))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT (NREVERSE #5#))))
                             (QREFELT $ 18))))))))) 

(DECLAIM (NOTINLINE |HankelPackage;|)) 

(DEFUN |HankelPackage| (#1=#:G720)
  (SPROG NIL
         (PROG (#2=#:G721)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|HankelPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|HankelPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|HankelPackage|)))))))))) 

(DEFUN |HankelPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|HankelPackage| DV$1))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|HankelPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|HankelPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|)
              (|Union| $ '"failed") (|NonNegativeInteger|) (4 . |exquo|)
              (10 . |Zero|) (|Matrix| 6) (14 . |vertConcat|) (|List| 19)
              (20 . |matrix|) (|Mapping| 12 12 12) (|List| 12) (25 . |reduce|)
              (|List| 6) |HANKP;HankelMatrix;LM;1|)
           '#(|HankelMatrix| 31) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|HankelMatrix|
                                 ((|Matrix| |#1|) (|List| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(0 6 0 7 2 9 8 0 0 10 0 6 0 11 2
                                              12 0 0 0 13 1 12 0 14 15 2 17 12
                                              16 0 18 1 0 12 19 20)))))
           '|lookupComplete|)) 
