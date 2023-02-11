
(SDEFUN |FINGPKG;permutationRepresentation;GP;1|
        ((|x| (G)) ($ (|Permutation| (|Integer|))))
        (SPROG
         ((|p| (|Permutation| (|Integer|))) (|imag| (|List| (|Integer|)))
          (#1=#:G713 NIL) (|a| NIL) (#2=#:G712 NIL)
          (|preimag| (|List| (|Integer|))) (#3=#:G711 NIL) (|k| NIL)
          (#4=#:G710 NIL) (|xall| (|List| G)) (#5=#:G709 NIL) (#6=#:G708 NIL)
          (|n| (|Integer|)) (|all| (|List| G)))
         (SEQ (LETT |all| (SPADCALL (QREFELT $ 8))) (LETT |n| (LENGTH |all|))
              (LETT |xall|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |a| NIL) (LETT #5# |all|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |a| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6#
                                  (CONS (SPADCALL |x| |a| (QREFELT $ 9))
                                        #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (LETT |preimag|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                          (COND ((|greater_SI| |k| #3#) (GO G191)))
                          (SEQ (EXIT (LETT #4# (CONS |k| #4#))))
                          (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |imag|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |a| NIL) (LETT #1# |all|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |a| |xall| (QREFELT $ 12))
                                        #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (LETT |p| (SPADCALL (LIST |preimag| |imag|) (QREFELT $ 15))))))) 

(SDEFUN |FINGPKG;regularRepresentation;GM;2|
        ((|x| (G)) ($ (|Matrix| (|Integer|))))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL (QREFELT $ 18)))
                    (EXIT
                     (SPADCALL (SPADCALL |x| (QREFELT $ 16)) |n|
                               (QREFELT $ 21)))))) 

(DECLAIM (NOTINLINE |FiniteGroupPackage;|)) 

(DEFUN |FiniteGroupPackage| (#1=#:G717)
  (SPROG NIL
         (PROG (#2=#:G718)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteGroupPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FiniteGroupPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FiniteGroupPackage|)))))))))) 

(DEFUN |FiniteGroupPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FiniteGroupPackage| DV$1))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteGroupPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FiniteGroupPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|List| $)
              (0 . |enumerate|) (4 . *) (|Integer|) (|List| 6)
              (10 . |position|) (|List| (|List| 10)) (|Permutation| 10)
              (16 . |coercePreimagesImages|)
              |FINGPKG;permutationRepresentation;GP;1| (|NonNegativeInteger|)
              (21 . |size|) (|Matrix| 10) (|RepresentationPackage1| 10)
              (25 . |permutationRepresentation|)
              |FINGPKG;regularRepresentation;GM;2|)
           '#(|regularRepresentation| 31 |permutationRepresentation| 36) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|permutationRepresentation|
                                 ((|Permutation| (|Integer|)) |#1|))
                                T)
                              '((|regularRepresentation|
                                 ((|Matrix| (|Integer|)) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(0 6 7 8 2 6 0 0 0 9 2 11 10 6 0
                                              12 1 14 0 13 15 0 6 17 18 2 20 19
                                              14 10 21 1 0 19 6 22 1 0 14 6
                                              16)))))
           '|lookupComplete|)) 
