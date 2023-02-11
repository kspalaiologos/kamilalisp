
(SDEFUN |CADU;squareFreeBasis;2L;1| ((|lpols| (|List| P)) ($ (|List| P)))
        (SPROG ((|sqpol| (P)) (|pol| (P)))
               (SEQ
                (COND ((SPADCALL |lpols| NIL (QREFELT $ 10)) NIL)
                      ('T
                       (SEQ (LETT |pol| (|SPADfirst| |lpols|))
                            (LETT |sqpol|
                                  (SPADCALL (SPADCALL |pol| (QREFELT $ 11))
                                            (QREFELT $ 12)))
                            (EXIT
                             (SPADCALL
                              (CONS |sqpol|
                                    (SPADCALL (CDR |lpols|) (QREFELT $ 13)))
                              (QREFELT $ 14))))))))) 

(SDEFUN |CADU;gcdBasisAdd| ((|p| (P)) (|lpols| (|List| P)) ($ (|List| P)))
        (SPROG ((|basis| (|List| P)) (|p1| (P)) (#1=#:G705 NIL) (|g| (P)))
               (SEQ
                (COND ((EQL (SPADCALL |p| (QREFELT $ 16)) 0) |lpols|)
                      ((NULL |lpols|) (LIST (SPADCALL |p| (QREFELT $ 12))))
                      (#2='T
                       (SEQ (LETT |p1| (|SPADfirst| |lpols|))
                            (LETT |g| (SPADCALL |p| |p1| (QREFELT $ 18)))
                            (EXIT
                             (COND
                              ((EQL (SPADCALL |g| (QREFELT $ 16)) 0)
                               (CONS |p1|
                                     (|CADU;gcdBasisAdd| |p| (CDR |lpols|) $)))
                              (#2#
                               (SEQ
                                (LETT |p|
                                      (PROG2
                                          (LETT #1#
                                                (SPADCALL |p| |g|
                                                          (QREFELT $ 20)))
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 #3="failed")
                                                        #1#)))
                                (LETT |p1|
                                      (PROG2
                                          (LETT #1#
                                                (SPADCALL |p1| |g|
                                                          (QREFELT $ 20)))
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 #3#)
                                                        #1#)))
                                (LETT |basis|
                                      (|CADU;gcdBasisAdd| |p| (CDR |lpols|) $))
                                (COND
                                 ((> (SPADCALL |p1| (QREFELT $ 16)) 0)
                                  (LETT |basis| (CONS |p1| |basis|))))
                                (EXIT
                                 (|CADU;gcdBasisAdd| |g| |basis| $)))))))))))) 

(SDEFUN |CADU;gcdBasis;2L;3| ((|lpols| (|List| P)) ($ (|List| P)))
        (SPROG ((|basis| (|List| P)))
               (SEQ
                (COND ((<= (LENGTH |lpols|) 1) |lpols|)
                      ('T
                       (SEQ
                        (LETT |basis| (SPADCALL (CDR |lpols|) (QREFELT $ 14)))
                        (EXIT
                         (|CADU;gcdBasisAdd| (|SPADfirst| |lpols|) |basis|
                          $)))))))) 

(DECLAIM (NOTINLINE |CylindricalAlgebraicDecompositionUtilities;|)) 

(DEFUN |CylindricalAlgebraicDecompositionUtilities| (&REST #1=#:G716)
  (SPROG NIL
         (PROG (#2=#:G717)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|CylindricalAlgebraicDecompositionUtilities|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |CylindricalAlgebraicDecompositionUtilities;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|CylindricalAlgebraicDecompositionUtilities|)))))))))) 

(DEFUN |CylindricalAlgebraicDecompositionUtilities;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|CylindricalAlgebraicDecompositionUtilities| DV$1 DV$2))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|CylindricalAlgebraicDecompositionUtilities|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CylindricalAlgebraicDecompositionUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (|List| 7) (0 . =) (6 . |squareFreePart|) (11 . |unitCanonical|)
              |CADU;squareFreeBasis;2L;1| |CADU;gcdBasis;2L;3|
              (|NonNegativeInteger|) (16 . |degree|) (21 . |Zero|) (25 . |gcd|)
              (|Union| $ '"failed") (31 . |exquo|) (37 . |One|))
           '#(|squareFreeBasis| 41 |gcdBasis| 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|squareFreeBasis|
                                 ((|List| |#2|) (|List| |#2|)))
                                T)
                              '((|gcdBasis| ((|List| |#2|) (|List| |#2|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(2 9 8 0 0 10 1 7 0 0 11 1 7 0 0
                                              12 1 7 15 0 16 0 6 0 17 2 7 0 0 0
                                              18 2 7 19 0 0 20 0 6 0 21 1 0 9 9
                                              13 1 0 9 9 14)))))
           '|lookupComplete|)) 
