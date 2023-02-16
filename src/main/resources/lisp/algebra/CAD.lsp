
(SDEFUN |CAD;cylindricalDecomposition;LL;1|
        ((|lpols| (|List| (|Polynomial| |TheField|)))
         ($ (|List| (|Cell| |TheField|))))
        (SPROG ((|lv| (|List| (|Symbol|))) (#1=#:G715 NIL) (|pol| NIL))
               (SEQ (LETT |lv| NIL)
                    (SEQ (LETT |pol| NIL) (LETT #1# |lpols|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |pol| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND ((SPADCALL |pol| (QREFELT $ 9)) "next pol")
                                 ('T
                                  (LETT |lv|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |pol| (QREFELT $ 11)) |lv|
                                          (QREFELT $ 12))
                                         (QREFELT $ 13)))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (LETT |lv| (REVERSE (SPADCALL |lv| (QREFELT $ 14))))
                    (EXIT (SPADCALL |lpols| |lv| (QREFELT $ 17)))))) 

(SDEFUN |CAD;cylindricalDecomposition;LLL;2|
        ((|lpols| (|List| (|Polynomial| |TheField|)))
         (|lvars| (|List| (|Symbol|))) ($ (|List| (|Cell| |TheField|))))
        (SPROG
         ((|res| (|List| (|Cell| |TheField|))) (#1=#:G740 NIL) (|scell| NIL)
          (#2=#:G739 NIL)
          (|scells|
           (|List|
            (|SimpleCell| |TheField|
                          (|SparseUnivariatePolynomial| |TheField|))))
          (|lspec| (|List| (|SparseUnivariatePolynomial| |TheField|)))
          (#3=#:G738 NIL) (|cell| NIL)
          (|previousCad| (|List| (|Cell| |TheField|)))
          (|lpols1| (|List| (|Polynomial| |TheField|))) (#4=#:G737 NIL)
          (|pol| NIL) (#5=#:G736 NIL) (#6=#:G735 NIL) (#7=#:G734 NIL)
          (|lp1| (|List| (|SparseUnivariatePolynomial| |TheField|)))
          (#8=#:G733 NIL) (#9=#:G732 NIL) (|lv| (|List| (|Symbol|)))
          (|mv| (|Symbol|)))
         (SEQ
          (COND
           ((SPADCALL |lvars| NIL (QREFELT $ 19))
            (|error| "cylindricalDecomposition: empty list of vars"))
           (#10='T
            (SEQ (LETT |mv| (|SPADfirst| |lvars|)) (LETT |lv| (CDR |lvars|))
                 (EXIT
                  (COND
                   ((SPADCALL |lv| NIL (QREFELT $ 19))
                    (SEQ
                     (LETT |lp1|
                           (PROGN
                            (LETT #9# NIL)
                            (SEQ (LETT |pol| NIL) (LETT #8# |lpols|) G190
                                 (COND
                                  ((OR (ATOM #8#)
                                       (PROGN (LETT |pol| (CAR #8#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #9#
                                         (CONS (SPADCALL |pol| (QREFELT $ 21))
                                               #9#))))
                                 (LETT #8# (CDR #8#)) (GO G190) G191
                                 (EXIT (NREVERSE #9#)))))
                     (LETT |scells| (SPADCALL |lp1| |mv| (QREFELT $ 26)))
                     (EXIT
                      (PROGN
                       (LETT #7# NIL)
                       (SEQ (LETT |scell| NIL) (LETT #6# |scells|) G190
                            (COND
                             ((OR (ATOM #6#)
                                  (PROGN (LETT |scell| (CAR #6#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #7#
                                    (CONS
                                     (SPADCALL (LIST |scell|) (QREFELT $ 29))
                                     #7#))))
                            (LETT #6# (CDR #6#)) (GO G190) G191
                            (EXIT (NREVERSE #7#)))))))
                   (#10#
                    (SEQ
                     (LETT |lpols1|
                           (SPADCALL
                            (PROGN
                             (LETT #5# NIL)
                             (SEQ (LETT |pol| NIL) (LETT #4# |lpols|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |pol| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #5#
                                          (CONS
                                           (SPADCALL |pol| |mv| (QREFELT $ 31))
                                           #5#))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT (NREVERSE #5#))))
                            (QREFELT $ 33)))
                     (LETT |previousCad|
                           (SPADCALL |lpols1| |lv| (QREFELT $ 17)))
                     (LETT |res| NIL)
                     (SEQ (LETT |cell| NIL) (LETT #3# |previousCad|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |cell| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |lspec|
                                 (SPADCALL |lpols| |cell| (QREFELT $ 34)))
                           (LETT |scells|
                                 (SPADCALL |lspec| |mv| (QREFELT $ 26)))
                           (EXIT
                            (LETT |res|
                                  (SPADCALL |res|
                                            (PROGN
                                             (LETT #2# NIL)
                                             (SEQ (LETT |scell| NIL)
                                                  (LETT #1# |scells|) G190
                                                  (COND
                                                   ((OR (ATOM #1#)
                                                        (PROGN
                                                         (LETT |scell|
                                                               (CAR #1#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT #2#
                                                          (CONS
                                                           (SPADCALL |scell|
                                                                     |cell|
                                                                     (QREFELT $
                                                                              35))
                                                           #2#))))
                                                  (LETT #1# (CDR #1#))
                                                  (GO G190) G191
                                                  (EXIT (NREVERSE #2#))))
                                            (QREFELT $ 36)))))
                          (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                     (EXIT |res|))))))))))) 

(SDEFUN |CAD;specialise;LCL;3|
        ((|lpols| (|List| (|Polynomial| |TheField|)))
         (|cell| (|Cell| |TheField|))
         ($ (|List| (|SparseUnivariatePolynomial| |TheField|))))
        (SPROG
         ((|res| (|List| (|SparseUnivariatePolynomial| |TheField|)))
          (|p1| (|SparseUnivariatePolynomial| |TheField|)) (#1=#:G747 NIL)
          (|pol| NIL) (|vl| (|List| (|Symbol|))) (|sp| (|List| |TheField|)))
         (SEQ
          (COND
           ((SPADCALL |lpols| NIL (QREFELT $ 37))
            (|error| "specialise: empty list of pols"))
           ('T
            (SEQ (LETT |sp| (SPADCALL |cell| (QREFELT $ 39)))
                 (LETT |vl| (SPADCALL |cell| (QREFELT $ 40))) (LETT |res| NIL)
                 (SEQ (LETT |pol| NIL) (LETT #1# |lpols|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |pol| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |p1|
                             (SPADCALL
                              (SPADCALL |pol| |vl| |sp| (QREFELT $ 41))
                              (QREFELT $ 21)))
                       (EXIT
                        (COND
                         ((EQL (SPADCALL |p1| (QREFELT $ 43)) 0) "next pol")
                         ('T (LETT |res| (CONS |p1| |res|))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (EXIT |res|))))))) 

(SDEFUN |CAD;coefficientSet;SupL;4|
        ((|pol| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|)))
         ($ (|List| (|Polynomial| |TheField|))))
        (SPROG
         ((|res| (|List| (|Polynomial| |TheField|))) (#1=#:G753 NIL)
          (#2=#:G754 NIL) (|c| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |res| NIL)
                (SEQ (LETT |c| NIL) (LETT #2# (SPADCALL |pol| (QREFELT $ 46)))
                     G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |c| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |c| (QREFELT $ 9))
                         (PROGN (LETT #1# |res|) (GO #3=#:G752)))
                        ('T (LETT |res| (CONS |c| |res|))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #3# (EXIT #1#)))) 

(SDEFUN |CAD;discriminantSet;LL;5|
        ((|lpols|
          (|List| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
         ($ (|List| (|Polynomial| |TheField|))))
        (SPROG
         ((|res| (|List| (|Polynomial| |TheField|))) (#1=#:G766 NIL)
          (|d| (|Polynomial| |TheField|))
          (|v|
           (|PrimitiveArray|
            (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
          (#2=#:G767 NIL) (|p| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |res| NIL)
                (SEQ (LETT |p| NIL) (LETT #2# |lpols|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |v|
                            (SPADCALL |p| (SPADCALL |p| (QREFELT $ 48))
                                      (QREFELT $ 51)))
                      (COND
                       ((NULL (ZEROP (SPADCALL (QAREF1 |v| 0) (QREFELT $ 53))))
                        (EXIT
                         (PROGN
                          (LETT #1# (|error| "Bad discriminant"))
                          (GO #3=#:G765)))))
                      (LETT |d| (SPADCALL (QAREF1 |v| 0) (QREFELT $ 54)))
                      (EXIT
                       (COND
                        ((SPADCALL |d| (QREFELT $ 55))
                         (PROGN
                          (LETT #1# (|error| "Non Square Free polynomial"))
                          (GO #3#)))
                        ((NULL (SPADCALL |d| (QREFELT $ 9)))
                         (LETT |res| (CONS |d| |res|))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #3# (EXIT #1#)))) 

(SDEFUN |CAD;principalSubResultantSet;2SupL;6|
        ((|p| #1=(|SparseUnivariatePolynomial| (|Polynomial| |TheField|)))
         (|q| #2=(|SparseUnivariatePolynomial| (|Polynomial| |TheField|)))
         ($ (|List| (|Polynomial| |TheField|))))
        (SPROG
         ((#3=#:G780 NIL) (#4=#:G775 NIL) (|i| NIL) (#5=#:G779 NIL)
          (|v|
           (|PrimitiveArray|
            (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
          (|#G27| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|)))
          (|#G26| #2#) (|#G25| #1#) (|#G24| #2#))
         (SEQ
          (COND
           ((< (SPADCALL |p| (QREFELT $ 53)) (SPADCALL |q| (QREFELT $ 53)))
            (PROGN
             (LETT |#G24| |q|)
             (LETT |#G25| |p|)
             (LETT |p| |#G24|)
             (LETT |q| |#G25|))))
          (COND
           ((EQL (SPADCALL |p| (QREFELT $ 53)) (SPADCALL |q| (QREFELT $ 53)))
            (PROGN
             (LETT |#G26| |q|)
             (LETT |#G27| (SPADCALL |p| |q| (QREFELT $ 57)))
             (LETT |p| |#G26|)
             (LETT |q| |#G27|))))
          (LETT |v| (SPADCALL |p| |q| (QREFELT $ 51)))
          (EXIT
           (PROGN
            (LETT #5# NIL)
            (SEQ (LETT |i| 0)
                 (LETT #3#
                       (PROG1 (LETT #4# (- (QVSIZE |v|) 2))
                         (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #4#)))
                 G190 (COND ((|greater_SI| |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #5#
                         (CONS (SPADCALL (QAREF1 |v| |i|) |i| (QREFELT $ 58))
                               #5#))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                 (EXIT (NREVERSE #5#)))))))) 

(SDEFUN |CAD;resultantSet;LL;7|
        ((|lpols|
          #1=(|List| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
         ($ (|List| (|Polynomial| |TheField|))))
        (SPROG
         ((|res| (|List| (|Polynomial| |TheField|))) (#2=#:G790 NIL)
          (|r| (|Polynomial| |TheField|)) (#3=#:G792 NIL) (|q| NIL)
          (|laux| #1#) (#4=#:G791 NIL) (|p| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |res| NIL) (LETT |laux| |lpols|)
                (SEQ (LETT |p| NIL) (LETT #4# |lpols|) G190
                     (COND
                      ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |laux| (CDR |laux|))
                          (EXIT
                           (SEQ (LETT |q| NIL) (LETT #3# |laux|) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |q| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |r|
                                       (|SPADfirst|
                                        (SPADCALL |p| |q| (QREFELT $ 59))))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |r| (QREFELT $ 55))
                                    (PROGN
                                     (LETT #2#
                                           (|error|
                                            "Non relatively prime polynomials"))
                                     (GO #5=#:G789)))
                                   ((NULL (SPADCALL |r| (QREFELT $ 9)))
                                    (LETT |res| (CONS |r| |res|))))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT NIL))))
                     (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #5# (EXIT #2#)))) 

(SDEFUN |CAD;projectionSet;LL;8|
        ((|lpols|
          (|List| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
         ($ (|List| (|Polynomial| |TheField|))))
        (SPROG
         ((|res| (|List| (|Polynomial| |TheField|))) (#1=#:G810 NIL) (|p| NIL)
          (|lsqfrb|
           (|List| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
          (|lp1|
           (|List| (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))))
          (|f|
           (|Mapping| (|Boolean|)
                      (|SparseUnivariatePolynomial| (|Polynomial| |TheField|))
                      (|SparseUnivariatePolynomial|
                       (|Polynomial| |TheField|))))
          (#2=#:G809 NIL) (#3=#:G808 NIL) (|c| (|Polynomial| |TheField|))
          (#4=#:G807 NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |p| NIL) (LETT #4# |lpols|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |c| (SPADCALL |p| (QREFELT $ 61)))
                        (EXIT
                         (COND ((SPADCALL |c| (QREFELT $ 9)) "next p")
                               ('T (LETT |res| (CONS |c| |res|))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |lp1|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |p| NIL) (LETT #2# |lpols|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #3#
                                  (CONS (SPADCALL |p| (QREFELT $ 62)) #3#))))
                          (LETT #2# (CDR #2#)) (GO G190) G191
                          (EXIT (NREVERSE #3#)))))
              (LETT |f| (CONS #'|CAD;projectionSet;LL;8!0| $))
              (LETT |lp1| (SPADCALL |f| |lp1| (QREFELT $ 65)))
              (LETT |lsqfrb| (SPADCALL |lp1| (QREFELT $ 67)))
              (LETT |lsqfrb| (SPADCALL |f| |lsqfrb| (QREFELT $ 65)))
              (SEQ (LETT |p| NIL) (LETT #1# |lp1|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res| (SPADCALL |p| (QREFELT $ 47))
                                     (QREFELT $ 68)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |res|
                    (SPADCALL |res| (SPADCALL |lsqfrb| (QREFELT $ 56))
                              (QREFELT $ 68)))
              (EXIT
               (SPADCALL |res| (SPADCALL |lsqfrb| (QREFELT $ 60))
                         (QREFELT $ 68)))))) 

(SDEFUN |CAD;projectionSet;LL;8!0| ((|x1| NIL) (|x2| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x1| (QREFELT $ 53)) (SPADCALL |x2| (QREFELT $ 53))
                  (QREFELT $ 63))) 

(DECLAIM (NOTINLINE |CylindricalAlgebraicDecompositionPackage;|)) 

(DEFUN |CylindricalAlgebraicDecompositionPackage| (#1=#:G811)
  (SPROG NIL
         (PROG (#2=#:G812)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|CylindricalAlgebraicDecompositionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|CylindricalAlgebraicDecompositionPackage;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|CylindricalAlgebraicDecompositionPackage|)))))))))) 

(DEFUN |CylindricalAlgebraicDecompositionPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|CylindricalAlgebraicDecompositionPackage| DV$1))
          (LETT $ (GETREFV 69))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|CylindricalAlgebraicDecompositionPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CylindricalAlgebraicDecompositionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|)
              (|Polynomial| 6) (0 . |ground?|) (|List| 24) (5 . |variables|)
              (10 . |append|) (16 . |removeDuplicates|) (21 . |sort|)
              (|List| 28) (|List| 8) |CAD;cylindricalDecomposition;LLL;2|
              |CAD;cylindricalDecomposition;LL;1| (26 . =)
              (|SparseUnivariatePolynomial| 6) (32 . |univariate|) (|List| $)
              (|List| 20) (|Symbol|) (|SimpleCell| 6 20)
              (37 . |allSimpleCells|) (|List| 25) (|Cell| 6) (43 . |makeCell|)
              (|SparseUnivariatePolynomial| $) (48 . |univariate|) (|List| 45)
              |CAD;projectionSet;LL;8| |CAD;specialise;LCL;3| (54 . |makeCell|)
              (60 . |append|) (66 . =) (|List| 6) (72 . |samplePoint|)
              (77 . |variablesOf|) (82 . |eval|) (|NonNegativeInteger|)
              (89 . |degree|) (94 . |Zero|) (|SparseUnivariatePolynomial| 8)
              (98 . |coefficients|) |CAD;coefficientSet;SupL;4|
              (103 . |differentiate|) (|PrimitiveArray| 45)
              (|SubResultantPackage| 8 45) (108 . |subresultantVector|)
              (114 . |Zero|) (118 . |degree|) (123 . |leadingCoefficient|)
              (128 . |zero?|) |CAD;discriminantSet;LL;5|
              (133 . |pseudoRemainder|) (139 . |coefficient|)
              |CAD;principalSubResultantSet;2SupL;6| |CAD;resultantSet;LL;7|
              (145 . |content|) (150 . |primitivePart|) (155 . <=)
              (|Mapping| 7 45 45) (161 . |sort|)
              (|CylindricalAlgebraicDecompositionUtilities| 8 45)
              (167 . |squareFreeBasis|) (172 . |append|))
           '#(|specialise| 178 |resultantSet| 184 |projectionSet| 189
              |principalSubResultantSet| 194 |discriminantSet| 200
              |cylindricalDecomposition| 205 |coefficientSet| 216)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|cylindricalDecomposition|
                                 ((|List| (|Cell| |#1|))
                                  (|List| (|Polynomial| |#1|))))
                                T)
                              '((|cylindricalDecomposition|
                                 ((|List| (|Cell| |#1|))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Symbol|))))
                                T)
                              '((|projectionSet|
                                 ((|List| (|Polynomial| |#1|))
                                  (|List|
                                   (|SparseUnivariatePolynomial|
                                    (|Polynomial| |#1|)))))
                                T)
                              '((|coefficientSet|
                                 ((|List| (|Polynomial| |#1|))
                                  (|SparseUnivariatePolynomial|
                                   (|Polynomial| |#1|))))
                                T)
                              '((|discriminantSet|
                                 ((|List| (|Polynomial| |#1|))
                                  (|List|
                                   (|SparseUnivariatePolynomial|
                                    (|Polynomial| |#1|)))))
                                T)
                              '((|resultantSet|
                                 ((|List| (|Polynomial| |#1|))
                                  (|List|
                                   (|SparseUnivariatePolynomial|
                                    (|Polynomial| |#1|)))))
                                T)
                              '((|principalSubResultantSet|
                                 ((|List| (|Polynomial| |#1|))
                                  (|SparseUnivariatePolynomial|
                                   (|Polynomial| |#1|))
                                  (|SparseUnivariatePolynomial|
                                   (|Polynomial| |#1|))))
                                T)
                              '((|specialise|
                                 ((|List| (|SparseUnivariatePolynomial| |#1|))
                                  (|List| (|Polynomial| |#1|)) (|Cell| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 68
                                            '(1 8 7 0 9 1 8 10 0 11 2 10 0 0 0
                                              12 1 10 0 0 13 1 10 0 0 14 2 10 7
                                              0 0 19 1 8 20 0 21 2 25 22 23 24
                                              26 1 28 0 27 29 2 8 30 0 24 31 2
                                              28 0 25 0 35 2 15 0 0 0 36 2 16 7
                                              0 0 37 1 28 38 0 39 1 28 10 0 40
                                              3 8 0 0 10 38 41 1 20 42 0 43 0 6
                                              0 44 1 45 16 0 46 1 45 0 0 48 2
                                              50 49 45 45 51 0 8 0 52 1 45 42 0
                                              53 1 45 8 0 54 1 8 7 0 55 2 45 0
                                              0 0 57 2 45 8 0 42 58 1 45 8 0 61
                                              1 45 0 0 62 2 42 7 0 0 63 2 32 0
                                              64 0 65 1 66 32 32 67 2 16 0 0 0
                                              68 2 0 23 16 28 34 1 0 16 32 60 1
                                              0 16 32 33 2 0 16 45 45 59 1 0 16
                                              32 56 2 0 15 16 10 17 1 0 15 16
                                              18 1 0 16 45 47)))))
           '|lookupComplete|)) 
