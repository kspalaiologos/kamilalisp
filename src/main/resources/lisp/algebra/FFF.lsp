
(SDEFUN |FFF;createLowComplexityNormalBasis;PiU;1|
        ((|n| (|PositiveInteger|))
         ($
          (|Union| (|SparseUnivariatePolynomial| GF)
                   (|Vector|
                    (|List|
                     (|Record| (|:| |value| GF)
                               (|:| |index| (|SingleInteger|))))))))
        (SPROG
         ((|u|
           (|Union|
            (|Vector|
             (|List|
              (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|)))))
            "failed")))
         (SEQ (LETT |u| (SPADCALL |n| (QREFELT $ 10)))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 0 (SPADCALL |n| (QREFELT $ 13))))
                     ('T (CONS 1 (QCDR |u|)))))))) 

(SDEFUN |FFF;createLowComplexityTable;PiU;2|
        ((|n| (|PositiveInteger|))
         ($
          (|Union|
           (|Vector|
            (|List|
             #1=(|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|)))))
           "failed")))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|)))))
          (|term| #1#) (#2=#:G793 NIL) (|j| NIL)
          (|v| (|Vector| (|PrimeField| |p|))) (#3=#:G792 NIL) (|i| NIL)
          (|multtable|
           (|Vector|
            (|List|
             (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|))))))
          (|m| (|NonNegativeInteger|)) (|lvjh| (|Integer|)) (#4=#:G791 NIL)
          (#5=#:G790 NIL) (#6=#:G789 NIL) (#7=#:G788 NIL)
          (|help| (|PrimeField| |p1|)) (#8=#:G787 NIL) (#9=#:G786 NIL)
          (|lvj| (|Matrix| (|Integer|))) (#10=#:G785 NIL) (#11=#:G784 NIL)
          (|x| NIL) (|vec| (|Vector| (|Integer|))) (|vt| (|Integer|))
          (|jt| (|Integer|)) (|t| (|PrimeField| |p1|))
          (|pkn| (|PrimeField| |p1|)) (|p1| (|NonNegativeInteger|))
          (|multmat| (|Matrix| (|PrimeField| |p|))) (#12=#:G782 NIL)
          (|t1| (|PrimeField| (+ (* |k| |n|) (|One|))))
          (|k| (|NonNegativeInteger|)) (|a| (|Integer|)) (#13=#:G783 NIL)
          (|p| (|NonNegativeInteger|)) (|q| (|NonNegativeInteger|)))
         (SEQ (LETT |q| (SPADCALL (QREFELT $ 17)))
              (LETT |p| (SPADCALL (QREFELT $ 18))) (LETT |k| 0)
              (SEQ (LETT |i| 1) (LETT #13# (- |n| 1)) G190
                   (COND
                    ((OR (|greater_SI| |i| #13#) (NULL (EQL |k| 0)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (+ (* |i| |n|) 1) (QREFELT $ 23))
                       (COND
                        ((NULL (EQL |p| (+ (* |i| |n|) 1)))
                         (COND
                          ((SPADCALL
                            (SPADCALL |q|
                                      (|compiledLookupCheck| '|coerce|
                                                             (LIST '$
                                                                   (LIST
                                                                    '|Integer|))
                                                             (|PrimeField|
                                                              (+ (* |i| |n|)
                                                                 (|One|)))))
                            (|compiledLookupCheck| '|primitive?|
                                                   (LIST (LIST '|Boolean|) '$)
                                                   (|PrimeField|
                                                    (+ (* |i| |n|) (|One|)))))
                           (SEQ (LETT |a| 1) (LETT |k| |i|)
                                (EXIT
                                 (LETT |t1|
                                       (SPADCALL
                                        (SPADCALL |q|
                                                  (|compiledLookupCheck|
                                                   '|coerce|
                                                   (LIST '$ (LIST '|Integer|))
                                                   (|PrimeField|
                                                    (+ (* |k| |n|) (|One|)))))
                                        |n|
                                        (|compiledLookupCheck| '^
                                                               (LIST '$ '$
                                                                     (LIST
                                                                      '|Integer|))
                                                               (|PrimeField|
                                                                (+ (* |k| |n|)
                                                                   (|One|)))))))))
                          ('T
                           (SEQ
                            (EXIT
                             (COND
                              ((EQL
                                (GCD |n|
                                     (LETT |a|
                                           (SPADCALL
                                            (SPADCALL |q|
                                                      (|compiledLookupCheck|
                                                       '|coerce|
                                                       (LIST '$
                                                             (LIST '|Integer|))
                                                       (|PrimeField|
                                                        (+ (* |n| |i|)
                                                           (|One|)))))
                                            (|compiledLookupCheck|
                                             '|discreteLog|
                                             (LIST (LIST '|NonNegativeInteger|)
                                                   '$)
                                             (|PrimeField|
                                              (+ (* |n| |i|) (|One|)))))))
                                1)
                               (PROGN
                                (LETT #12#
                                      (SEQ (LETT |k| |i|)
                                           (EXIT
                                            (LETT |t1|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (|compiledLookupCheck|
                                                     '|primitiveElement|
                                                     (LIST '$)
                                                     (|PrimeField|
                                                      (+ (* |k| |n|)
                                                         (|One|)))))
                                                   |n|
                                                   (|compiledLookupCheck| '^
                                                                          (LIST
                                                                           '$
                                                                           '$
                                                                           (LIST
                                                                            '|Integer|))
                                                                          (|PrimeField|
                                                                           (+
                                                                            (*
                                                                             |k|
                                                                             |n|)
                                                                            (|One|)))))))))
                                (GO #14=#:G737)))))
                            #14# (EXIT #12#))))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND ((EQL |k| 0) (CONS 1 "failed"))
                     (#15='T
                      (SEQ
                       (LETT |multmat|
                             (SPADCALL |n| |n|
                                       (|compiledLookupCheck| '|zero|
                                                              (LIST '$
                                                                    (LIST
                                                                     '|NonNegativeInteger|)
                                                                    (LIST
                                                                     '|NonNegativeInteger|))
                                                              (|Matrix|
                                                               (|PrimeField|
                                                                |p|)))))
                       (LETT |p1| (+ (* |k| |n|) 1))
                       (LETT |pkn|
                             (SPADCALL |q|
                                       (|compiledLookupCheck| '|coerce|
                                                              (LIST '$
                                                                    (LIST
                                                                     '|Integer|))
                                                              (|PrimeField|
                                                               |p1|))))
                       (LETT |t| |t1|)
                       (COND
                        ((ODDP |k|)
                         (SEQ (LETT |jt| (+ (QUOTIENT2 |n| 2) 1))
                              (EXIT
                               (LETT |vt|
                                     (+
                                      (SPADCALL (QUOTIENT2 (- |k| |a|) 2) |k|
                                                (QREFELT $ 24))
                                      1)))))
                        (#15#
                         (SEQ (LETT |jt| 1)
                              (EXIT (LETT |vt| (+ (QUOTIENT2 |k| 2) 1))))))
                       (LETT |vec| (SPADCALL |p1| (QREFELT $ 26)))
                       (SEQ (LETT |x| 1) (LETT #11# |k|) G190
                            (COND ((|greater_SI| |x| #11#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |l| 1) (LETT #10# |n|) G190
                                   (COND ((|greater_SI| |l| #10#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (SPADCALL |vec|
                                               (+
                                                (SPADCALL
                                                 (SPADCALL |t| (- |x| 1)
                                                           (|compiledLookupCheck|
                                                            '^
                                                            (LIST '$ '$
                                                                  (LIST
                                                                   '|Integer|))
                                                            (|PrimeField|
                                                             |p1|)))
                                                 (SPADCALL |pkn| (- |l| 1)
                                                           (|compiledLookupCheck|
                                                            '^
                                                            (LIST '$ '$
                                                                  (LIST
                                                                   '|Integer|))
                                                            (|PrimeField|
                                                             |p1|)))
                                                 (|compiledLookupCheck| '*
                                                                        (LIST
                                                                         '$ '$
                                                                         '$)
                                                                        (|PrimeField|
                                                                         (+
                                                                          (*
                                                                           |k|
                                                                           |n|)
                                                                          (|One|)))))
                                                1)
                                               (SPADCALL |l| |p1|
                                                         (QREFELT $ 24))
                                               (QREFELT $ 27))))
                                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |lvj| (SPADCALL |k| |n| (QREFELT $ 29)))
                       (SEQ (LETT |v| 1) (LETT #9# |k|) G190
                            (COND ((|greater_SI| |v| #9#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |j| 1) (LETT #8# |n|) G190
                                   (COND ((|greater_SI| |j| #8#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((OR (SPADCALL |j| |jt| (QREFELT $ 30))
                                           (SPADCALL |v| |vt| (QREFELT $ 30)))
                                       (SEQ
                                        (LETT |help|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL |t| (- |v| 1)
                                                          (|compiledLookupCheck|
                                                           '^
                                                           (LIST '$ '$
                                                                 (LIST
                                                                  '|Integer|))
                                                           (|PrimeField|
                                                            |p1|)))
                                                (SPADCALL |pkn| (- |j| 1)
                                                          (|compiledLookupCheck|
                                                           '^
                                                           (LIST '$ '$
                                                                 (LIST
                                                                  '|Integer|))
                                                           (|PrimeField|
                                                            |p1|)))
                                                (|compiledLookupCheck| '*
                                                                       (LIST '$
                                                                             '$
                                                                             '$)
                                                                       (|PrimeField|
                                                                        (+
                                                                         (* |k|
                                                                            |n|)
                                                                         (|One|)))))
                                               (SPADCALL
                                                (|compiledLookupCheck| '|One|
                                                                       (LIST
                                                                        '$)
                                                                       (|PrimeField|
                                                                        (+
                                                                         (* |k|
                                                                            |n|)
                                                                         (|One|)))))
                                               (|compiledLookupCheck| '+
                                                                      (LIST '$
                                                                            '$
                                                                            '$)
                                                                      (|PrimeField|
                                                                       (+
                                                                        (* |k|
                                                                           |n|)
                                                                        (|One|))))))
                                        (EXIT
                                         (SPADCALL |lvj| |v| |j|
                                                   (SPADCALL |vec| (+ |help| 1)
                                                             (QREFELT $ 31))
                                                   (QREFELT $ 32))))))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                            (EXIT NIL))
                       (SEQ (LETT |j| 1) (LETT #7# |n|) G190
                            (COND ((|greater_SI| |j| #7#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL |j| |jt| (QREFELT $ 30))
                                (SEQ (LETT |v| 1) (LETT #6# |k|) G190
                                     (COND ((|greater_SI| |v| #6#) (GO G191)))
                                     (SEQ
                                      (LETT |lvjh|
                                            (SPADCALL |lvj| |v| |j|
                                                      (QREFELT $ 33)))
                                      (EXIT
                                       (SPADCALL |multmat| |j| |lvjh|
                                                 (SPADCALL
                                                  (SPADCALL |multmat| |j|
                                                            |lvjh|
                                                            (|compiledLookupCheck|
                                                             '|elt|
                                                             (LIST
                                                              (LIST
                                                               '|PrimeField|
                                                               |p|)
                                                              '$
                                                              (LIST '|Integer|)
                                                              (LIST
                                                               '|Integer|))
                                                             (|Matrix|
                                                              (|PrimeField|
                                                               |p|))))
                                                  (SPADCALL
                                                   (|compiledLookupCheck|
                                                    '|One| (LIST '$)
                                                    (|PrimeField| |p|)))
                                                  (|compiledLookupCheck| '+
                                                                         (LIST
                                                                          '$ '$
                                                                          '$)
                                                                         (|PrimeField|
                                                                          |p|)))
                                                 (|compiledLookupCheck|
                                                  '|setelt!|
                                                  (LIST
                                                   (LIST '|PrimeField| |p|) '$
                                                   (LIST '|Integer|)
                                                   (LIST '|Integer|)
                                                   (LIST '|PrimeField| |p|))
                                                  (|Matrix|
                                                   (|PrimeField| |p|))))))
                                     (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                                     (EXIT NIL))))))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))
                       (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                            (COND ((|greater_SI| |i| #5#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |multmat| |jt| |i|
                                        (SPADCALL
                                         (SPADCALL (- |k|) |p| (QREFELT $ 24))
                                         (|compiledLookupCheck| '|coerce|
                                                                (LIST '$
                                                                      (LIST
                                                                       '|Integer|))
                                                                (|PrimeField|
                                                                 |p|)))
                                        (|compiledLookupCheck| '|setelt!|
                                                               (LIST
                                                                (LIST
                                                                 '|PrimeField|
                                                                 |p|)
                                                                '$
                                                                (LIST
                                                                 '|Integer|)
                                                                (LIST
                                                                 '|Integer|)
                                                                (LIST
                                                                 '|PrimeField|
                                                                 |p|))
                                                               (|Matrix|
                                                                (|PrimeField|
                                                                 |p|))))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (SEQ (LETT |v| 1) (LETT #4# |k|) G190
                            (COND ((|greater_SI| |v| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL |v| |vt| (QREFELT $ 30))
                                (SEQ
                                 (LETT |lvjh|
                                       (SPADCALL |lvj| |v| |jt|
                                                 (QREFELT $ 33)))
                                 (EXIT
                                  (SPADCALL |multmat| |jt| |lvjh|
                                            (SPADCALL
                                             (SPADCALL |multmat| |jt| |lvjh|
                                                       (|compiledLookupCheck|
                                                        '|elt|
                                                        (LIST
                                                         (LIST '|PrimeField|
                                                               |p|)
                                                         '$ (LIST '|Integer|)
                                                         (LIST '|Integer|))
                                                        (|Matrix|
                                                         (|PrimeField| |p|))))
                                             (SPADCALL
                                              (|compiledLookupCheck| '|One|
                                                                     (LIST '$)
                                                                     (|PrimeField|
                                                                      |p|)))
                                             (|compiledLookupCheck| '+
                                                                    (LIST '$ '$
                                                                          '$)
                                                                    (|PrimeField|
                                                                     |p|)))
                                            (|compiledLookupCheck| '|setelt!|
                                                                   (LIST
                                                                    (LIST
                                                                     '|PrimeField|
                                                                     |p|)
                                                                    '$
                                                                    (LIST
                                                                     '|Integer|)
                                                                    (LIST
                                                                     '|Integer|)
                                                                    (LIST
                                                                     '|PrimeField|
                                                                     |p|))
                                                                   (|Matrix|
                                                                    (|PrimeField|
                                                                     |p|))))))))))
                            (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |m| (ANROWS |multmat|))
                       (LETT |multtable| (MAKEARR1 |m| NIL))
                       (SEQ (LETT |i| 1) (LETT #3# |m|) G190
                            (COND ((|greater_SI| |i| #3#) (GO G191)))
                            (SEQ (LETT |l| NIL)
                                 (LETT |v|
                                       (SPADCALL |multmat| |i|
                                                 (|compiledLookupCheck| '|row|
                                                                        (LIST
                                                                         (LIST
                                                                          '|Vector|
                                                                          (LIST
                                                                           '|PrimeField|
                                                                           |p|))
                                                                         '$
                                                                         (LIST
                                                                          '|Integer|))
                                                                        (|Matrix|
                                                                         (|PrimeField|
                                                                          |p|)))))
                                 (SEQ (LETT |j| 1) (LETT #2# |m|) G190
                                      (COND ((|greater_SI| |j| #2#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |v| |j|
                                                     (|compiledLookupCheck|
                                                      '|elt|
                                                      (LIST
                                                       (LIST '|PrimeField| |p|)
                                                       '$ (LIST '|Integer|))
                                                      (|Vector|
                                                       (|PrimeField| |p|))))
                                           (SPADCALL
                                            (|compiledLookupCheck| '|Zero|
                                                                   (LIST '$)
                                                                   (|PrimeField|
                                                                    |p|)))
                                           (|compiledLookupCheck| '~=
                                                                  (LIST
                                                                   (LIST
                                                                    '|Boolean|)
                                                                   '$ '$)
                                                                  (|PrimeField|
                                                                   |p|)))
                                          (SEQ
                                           (LETT |term|
                                                 (CONS
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |v| |j|
                                                               (|compiledLookupCheck|
                                                                '|elt|
                                                                (LIST
                                                                 (LIST
                                                                  '|PrimeField|
                                                                  |p|)
                                                                 '$
                                                                 (LIST
                                                                  '|Integer|))
                                                                (|Vector|
                                                                 (|PrimeField|
                                                                  |p|))))
                                                     (|compiledLookupCheck| '-
                                                                            (LIST
                                                                             '$
                                                                             '$)
                                                                            (|PrimeField|
                                                                             |p|)))
                                                    (|compiledLookupCheck|
                                                     '|convert|
                                                     (LIST (LIST '|Integer|)
                                                           '$)
                                                     (|PrimeField| |p|)))
                                                   (QREFELT $ 34))
                                                  (- |j| 2)))
                                           (EXIT
                                            (LETT |l| (CONS |term| |l|))))))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT
                                  (QSETAREF1O |multtable| |i|
                                              (SPADCALL |l| (QREFELT $ 36))
                                              1)))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT (CONS 0 |multtable|))))))))) 

(SDEFUN |FFF;sizeMultiplication;VNni;3|
        ((|m|
          (|Vector|
           (|List|
            (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|))))))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|s| (|NonNegativeInteger|)) (#1=#:G802 NIL) (|i| NIL))
               (SEQ (LETT |s| 0)
                    (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |m|)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |s|
                                 (+ |s|
                                    (LENGTH
                                     (SPADCALL |m| |i| (QREFELT $ 38)))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |s|)))) 

(SDEFUN |FFF;createMultiplicationTable;SupV;4|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($
          (|Vector|
           (|List|
            #1=(|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|)))))))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|)))))
          (|term| #1#) (#2=#:G834 NIL) (|j| NIL) (|v| (|Vector| GF))
          (#3=#:G833 NIL) (|i| NIL)
          (|multtable|
           (|Vector|
            (|List|
             (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|))))))
          (|mat| (|Matrix| GF)) (#4=#:G814 NIL)
          (|mat1| (|Union| (|Matrix| GF) #5="failed"))
          (|h| (|ModMonic| GF (|SparseUnivariatePolynomial| GF)))
          (|g| (|ModMonic| GF (|SparseUnivariatePolynomial| GF)))
          (#6=#:G832 NIL)
          (|qexp|
           #7=(|PrimitiveArray|
               (|ModMonic| GF (|SparseUnivariatePolynomial| GF))))
          (|w| (|ModMonic| GF (|SparseUnivariatePolynomial| GF)))
          (#8=#:G831 NIL) (|qpow| #7#)
          (|e| (|ModMonic| GF (|SparseUnivariatePolynomial| GF)))
          (|m1| (|Integer|)) (|m| (|PositiveInteger|))
          (|sizeGF| (|NonNegativeInteger|)))
         (SEQ (LETT |sizeGF| (SPADCALL (QREFELT $ 17)))
              (LETT |m| (SPADCALL |f| (QREFELT $ 40)))
              (EXIT
               (COND
                ((EQL |m| 1)
                 (VECTOR
                  (LIST
                   (CONS
                    (SPADCALL (SPADCALL |f| 0 (QREFELT $ 43)) (QREFELT $ 44))
                    -1))))
                (#9='T
                 (SEQ (LETT |m1| (- |m| 1)) (SPADCALL |f| (QREFELT $ 46))
                      (LETT |e|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 19) 1 (QREFELT $ 47))
                              (QREFELT $ 48))
                             |sizeGF| (QREFELT $ 49)))
                      (LETT |w| (|spadConstant| $ 50))
                      (LETT |qpow| (MAKEARR1 |m| (|spadConstant| $ 51)))
                      (QSETAREF1 |qpow| 0 (|spadConstant| $ 50))
                      (SEQ (LETT |i| 1) (LETT #8# |m1|) G190
                           (COND ((|greater_SI| |i| #8#) (GO G191)))
                           (SEQ
                            (EXIT
                             (QSETAREF1 |qpow| |i|
                                        (LETT |w|
                                              (SPADCALL |w| |e|
                                                        (QREFELT $ 52))))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |qexp| (MAKEARR1 |m| (|spadConstant| $ 51)))
                      (QSETAREF1 |qexp| 0
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 19) 1
                                            (QREFELT $ 47))
                                  (QREFELT $ 48)))
                      (LETT |mat| (SPADCALL |m| |m| (QREFELT $ 54)))
                      (QSETAREF2O |mat| 2 1 (|spadConstant| $ 19) 1 1)
                      (LETT |h| (QAREF1 |qpow| 1)) (QSETAREF1 |qexp| 1 |h|)
                      (SPADCALL |mat| 2 (SPADCALL |h| (QREFELT $ 56))
                                (QREFELT $ 57))
                      (SEQ (LETT |i| 2) (LETT #6# |m1|) G190
                           (COND ((|greater_SI| |i| #6#) (GO G191)))
                           (SEQ (LETT |g| (|spadConstant| $ 51))
                                (SEQ G190
                                     (COND
                                      ((NULL
                                        (SPADCALL |h| (|spadConstant| $ 51)
                                                  (QREFELT $ 58)))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |g|
                                            (SPADCALL |g|
                                                      (SPADCALL
                                                       (SPADCALL |h|
                                                                 (QREFELT $
                                                                          59))
                                                       (QAREF1 |qpow|
                                                               (SPADCALL |h|
                                                                         (QREFELT
                                                                          $
                                                                          60)))
                                                       (QREFELT $ 61))
                                                      (QREFELT $ 62)))
                                      (EXIT
                                       (LETT |h|
                                             (SPADCALL |h| (QREFELT $ 63)))))
                                     NIL (GO G190) G191 (EXIT NIL))
                                (QSETAREF1 |qexp| |i| |g|)
                                (EXIT
                                 (SPADCALL |mat| (+ |i| 1)
                                           (SPADCALL (LETT |h| |g|)
                                                     (QREFELT $ 56))
                                           (QREFELT $ 57))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |mat1| (SPADCALL |mat| (QREFELT $ 65)))
                      (EXIT
                       (COND
                        ((SPADCALL |mat1| (CONS 1 "failed") (QREFELT $ 67))
                         (|error|
                          "createMultiplicationTable: polynomial must be normal"))
                        (#9#
                         (SEQ
                          (LETT |mat|
                                (PROG2 (LETT #4# |mat1|)
                                    (QCDR #4#)
                                  (|check_union2| (QEQCAR #4# 0)
                                                  (|Matrix| (QREFELT $ 6))
                                                  (|Union|
                                                   (|Matrix| (QREFELT $ 6))
                                                   #5#)
                                                  #4#)))
                          (LETT |multtable| (MAKEARR1 |m| NIL))
                          (SEQ (LETT |i| 1) (LETT #3# |m|) G190
                               (COND ((|greater_SI| |i| #3#) (GO G191)))
                               (SEQ (LETT |l| NIL)
                                    (LETT |v|
                                          (SPADCALL |mat|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (QAREF1 |qexp| (- |i| 1))
                                                      (QAREF1 |qexp| 0)
                                                      (QREFELT $ 52))
                                                     (QREFELT $ 56))
                                                    (QREFELT $ 68)))
                                    (SEQ (LETT |j| 1)
                                         (LETT #2#
                                               (SPADCALL |m| (QREFELT $ 70)))
                                         G190
                                         (COND
                                          ((|greater_SI| |j| #2#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((SPADCALL
                                              (SPADCALL |v| |j| (QREFELT $ 71))
                                              (|spadConstant| $ 20)
                                              (QREFELT $ 72))
                                             (SEQ
                                              (LETT |term|
                                                    (CONS
                                                     (SPADCALL |v| |j|
                                                               (QREFELT $ 71))
                                                     (|sub_SI| |j| 2)))
                                              (EXIT
                                               (LETT |l|
                                                     (CONS |term| |l|))))))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))
                                    (EXIT
                                     (QSETAREF1O |multtable| |i|
                                                 (SPADCALL |l| (QREFELT $ 36))
                                                 1)))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT |multtable|)))))))))))) 

(SDEFUN |FFF;createZechTable;SupPa;5|
        ((|f| (|SparseUnivariatePolynomial| GF))
         ($ (|PrimitiveArray| (|SingleInteger|))))
        (SPROG
         ((|a|
           #1=(|SimpleAlgebraicExtension| GF (|SparseUnivariatePolynomial| GF)
                                          |f|))
          (#2=#:G854 NIL) (|i| NIL) (#3=#:G853 NIL) (#4=#:G852 NIL)
          (|primElement| #1#)
          (|helparr| #5=(|PrimitiveArray| (|SingleInteger|))) (|zechlog| #5#)
          (|qm1| (|SingleInteger|)) (|m| (|PositiveInteger|)) (#6=#:G835 NIL)
          (|sizeGF| (|NonNegativeInteger|)))
         (SEQ (LETT |sizeGF| (SPADCALL (QREFELT $ 17)))
              (LETT |m|
                    (PROG1 (LETT #6# (SPADCALL |f| (QREFELT $ 40)))
                      (|check_subtype2| (> #6# 0) '(|PositiveInteger|)
                                        '(|NonNegativeInteger|) #6#)))
              (LETT |qm1| (- (EXPT |sizeGF| |m|) 1))
              (LETT |zechlog|
                    (MAKEARR1 (QUOTIENT2 (+ (EXPT |sizeGF| |m|) 1) 2) -1))
              (LETT |helparr| (MAKEARR1 (EXPT |sizeGF| |m|) 0))
              (LETT |primElement|
                    (SPADCALL (SPADCALL (|spadConstant| $ 19) 1 (QREFELT $ 47))
                              (|compiledLookupCheck| '|reduce|
                                                     (LIST '$
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (|devaluate|
                                                             (ELT $ 6))))
                                                     (|SimpleAlgebraicExtension|
                                                      (ELT $ 6)
                                                      (|SparseUnivariatePolynomial|
                                                       (ELT $ 6))
                                                      |f|))))
              (LETT |a| |primElement|)
              (SEQ (LETT |i| 1) (LETT #4# (|sub_SI| |qm1| 1)) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (QSETAREF1 |helparr|
                               (SPADCALL
                                (SPADCALL |a|
                                          (SPADCALL
                                           (|compiledLookupCheck| '|One|
                                                                  (LIST '$)
                                                                  (|SimpleAlgebraicExtension|
                                                                   (ELT $ 6)
                                                                   (|SparseUnivariatePolynomial|
                                                                    (ELT $ 6))
                                                                   |f|)))
                                          (|compiledLookupCheck| '-
                                                                 (LIST '$ '$
                                                                       '$)
                                                                 (|SimpleAlgebraicExtension|
                                                                  (ELT $ 6)
                                                                  (|SparseUnivariatePolynomial|
                                                                   (ELT $ 6))
                                                                  |f|)))
                                (|compiledLookupCheck| '|lookup|
                                                       (LIST
                                                        (LIST
                                                         '|PositiveInteger|)
                                                        '$)
                                                       (|SimpleAlgebraicExtension|
                                                        (ELT $ 6)
                                                        (|SparseUnivariatePolynomial|
                                                         (ELT $ 6))
                                                        |f|)))
                               (SPADCALL |i| (QREFELT $ 70)))
                    (EXIT
                     (LETT |a|
                           (SPADCALL |a| |primElement|
                                     (|compiledLookupCheck| '* (LIST '$ '$ '$)
                                                            (|SimpleAlgebraicExtension|
                                                             (ELT $ 6)
                                                             (|SparseUnivariatePolynomial|
                                                              (ELT $ 6))
                                                             |f|))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((EQL (SPADCALL (QREFELT $ 18)) 2)
                 (SEQ (LETT |a| |primElement|)
                      (SEQ (LETT |i| 1) (LETT #3# (|quo_SI| |qm1| 2)) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ
                            (QSETAREF1 |zechlog| |i|
                                       (QAREF1 |helparr|
                                               (SPADCALL |a|
                                                         (|compiledLookupCheck|
                                                          '|lookup|
                                                          (LIST
                                                           (LIST
                                                            '|PositiveInteger|)
                                                           '$)
                                                          (|SimpleAlgebraicExtension|
                                                           (ELT $ 6)
                                                           (|SparseUnivariatePolynomial|
                                                            (ELT $ 6))
                                                           |f|)))))
                            (EXIT
                             (LETT |a|
                                   (SPADCALL |a| |primElement|
                                             (|compiledLookupCheck| '*
                                                                    (LIST '$ '$
                                                                          '$)
                                                                    (|SimpleAlgebraicExtension|
                                                                     (ELT $ 6)
                                                                     (|SparseUnivariatePolynomial|
                                                                      (ELT $
                                                                           6))
                                                                     |f|))))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |zechlog|)))
                ('T
                 (SEQ
                  (LETT |a|
                        (SPADCALL
                         (|compiledLookupCheck| '|One| (LIST '$)
                                                (|SimpleAlgebraicExtension|
                                                 (ELT $ 6)
                                                 (|SparseUnivariatePolynomial|
                                                  (ELT $ 6))
                                                 |f|))))
                  (SEQ (LETT |i| 0) (LETT #2# (|quo_SI| (|sub_SI| |qm1| 2) 2))
                       G190 (COND ((|greater_SI| |i| #2#) (GO G191)))
                       (SEQ
                        (QSETAREF1 |zechlog| |i|
                                   (QAREF1 |helparr|
                                           (SPADCALL |a|
                                                     (|compiledLookupCheck|
                                                      '|lookup|
                                                      (LIST
                                                       (LIST
                                                        '|PositiveInteger|)
                                                       '$)
                                                      (|SimpleAlgebraicExtension|
                                                       (ELT $ 6)
                                                       (|SparseUnivariatePolynomial|
                                                        (ELT $ 6))
                                                       |f|)))))
                        (EXIT
                         (LETT |a|
                               (SPADCALL |a| |primElement|
                                         (|compiledLookupCheck| '*
                                                                (LIST '$ '$ '$)
                                                                (|SimpleAlgebraicExtension|
                                                                 (ELT $ 6)
                                                                 (|SparseUnivariatePolynomial|
                                                                  (ELT $ 6))
                                                                 |f|))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |zechlog|)))))))) 

(SDEFUN |FFF;createMultiplicationMatrix;VM;6|
        ((|m|
          (|Vector|
           (|List|
            (|Record| (|:| |value| GF) (|:| |index| (|SingleInteger|))))))
         ($ (|Matrix| GF)))
        (SPROG
         ((#1=#:G864 NIL) (|t| NIL) (#2=#:G863 NIL) (|i| NIL)
          (|mat| (|Matrix| GF)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVSIZE |m|))
              (LETT |mat| (SPADCALL |n| |n| (QREFELT $ 54)))
              (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |t| NIL)
                          (LETT #1# (SPADCALL |m| |i| (QREFELT $ 38))) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (QSETAREF2O |mat| |i| (|add_SI| (QCDR |t|) 2)
                                        (QCAR |t|) 1 1)))
                          (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |mat|)))) 

(DECLAIM (NOTINLINE |FiniteFieldFunctions;|)) 

(DEFUN |FiniteFieldFunctions| (#1=#:G865)
  (SPROG NIL
         (PROG (#2=#:G866)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteFieldFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|FiniteFieldFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FiniteFieldFunctions|)))))))))) 

(DEFUN |FiniteFieldFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FiniteFieldFunctions| DV$1))
          (LETT $ (GETREFV 77))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteFieldFunctions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FiniteFieldFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Record| (|:| |value| 6) (|:| |index| 69))
              (|Union| 37 '#1="failed") (|PositiveInteger|)
              |FFF;createLowComplexityTable;PiU;2|
              (|SparseUnivariatePolynomial| 6)
              (|FiniteFieldPolynomialPackage| 6) (0 . |createNormalPoly|)
              (|Union| 11 37) |FFF;createLowComplexityNormalBasis;PiU;1|
              (|NonNegativeInteger|) (5 . |size|) (9 . |characteristic|)
              (13 . |One|) (17 . |Zero|) (|Boolean|) (|Integer|)
              (21 . |prime?|) (26 . |positiveRemainder|) (|Vector| 22)
              (32 . |zero|) (37 . |setelt!|) (|Matrix| 22) (44 . |zero|)
              (50 . ~=) (56 . |elt|) (62 . |setelt!|) (70 . |elt|)
              (77 . |coerce|) (|List| 7) (82 . |copy|) (|Vector| 35)
              (87 . |elt|) |FFF;sizeMultiplication;VNni;3| (93 . |degree|)
              (98 . |One|) (102 . |Zero|) (106 . |coefficient|) (112 . -)
              (|ModMonic| 6 11) (117 . |setPoly|) (122 . |monomial|)
              (128 . |reduce|) (133 . ^) (139 . |One|) (143 . |Zero|) (147 . *)
              (|Matrix| 6) (153 . |zero|) (|Vector| 6) (159 . |Vectorise|)
              (164 . |setColumn!|) (171 . ~=) (177 . |leadingCoefficient|)
              (182 . |degree|) (187 . *) (193 . +) (199 . |reductum|)
              (|Union| $ '#2="failed") (204 . |inverse|) (|Union| 53 '#2#)
              (209 . =) (215 . *) (|SingleInteger|) (221 . |coerce|)
              (226 . |elt|) (232 . ~=) |FFF;createMultiplicationTable;SupV;4|
              (|PrimitiveArray| 69) |FFF;createZechTable;SupPa;5|
              |FFF;createMultiplicationMatrix;VM;6|)
           '#(|sizeMultiplication| 238 |createZechTable| 243
              |createMultiplicationTable| 248 |createMultiplicationMatrix| 253
              |createLowComplexityTable| 258 |createLowComplexityNormalBasis|
              263)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|createZechTable|
                                 ((|PrimitiveArray| (|SingleInteger|))
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|createMultiplicationTable|
                                 ((|Vector|
                                   (|List|
                                    (|Record| (|:| |value| |#1|)
                                              (|:| |index|
                                                   (|SingleInteger|)))))
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|createMultiplicationMatrix|
                                 ((|Matrix| |#1|)
                                  (|Vector|
                                   (|List|
                                    (|Record| (|:| |value| |#1|)
                                              (|:| |index|
                                                   (|SingleInteger|)))))))
                                T)
                              '((|sizeMultiplication|
                                 ((|NonNegativeInteger|)
                                  (|Vector|
                                   (|List|
                                    (|Record| (|:| |value| |#1|)
                                              (|:| |index|
                                                   (|SingleInteger|)))))))
                                T)
                              '((|createLowComplexityTable|
                                 ((|Union|
                                   (|Vector|
                                    (|List|
                                     (|Record| (|:| |value| |#1|)
                                               (|:| |index|
                                                    (|SingleInteger|)))))
                                   #1#)
                                  (|PositiveInteger|)))
                                T)
                              '((|createLowComplexityNormalBasis|
                                 ((|Union| (|SparseUnivariatePolynomial| |#1|)
                                           (|Vector|
                                            (|List|
                                             (|Record| (|:| |value| |#1|)
                                                       (|:| |index|
                                                            (|SingleInteger|))))))
                                  (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 76
                                            '(1 12 11 9 13 0 6 16 17 0 6 16 18
                                              0 6 0 19 0 6 0 20 1 22 21 0 23 2
                                              22 0 0 0 24 1 25 0 16 26 3 25 22
                                              0 22 22 27 2 28 0 16 16 29 2 22
                                              21 0 0 30 2 25 22 0 22 31 4 28 22
                                              0 22 22 22 32 3 28 22 0 22 22 33
                                              1 6 0 22 34 1 35 0 0 36 2 37 35 0
                                              22 38 1 11 16 0 40 0 11 0 41 0 11
                                              0 42 2 11 6 0 16 43 1 6 0 0 44 1
                                              45 11 11 46 2 11 0 6 16 47 1 45 0
                                              11 48 2 45 0 0 16 49 0 45 0 50 0
                                              45 0 51 2 45 0 0 0 52 2 53 0 16
                                              16 54 1 45 55 0 56 3 53 0 0 22 55
                                              57 2 45 21 0 0 58 1 45 6 0 59 1
                                              45 16 0 60 2 45 0 6 0 61 2 45 0 0
                                              0 62 1 45 0 0 63 1 53 64 0 65 2
                                              66 21 0 0 67 2 53 55 0 55 68 1 69
                                              0 22 70 2 55 6 0 22 71 2 6 21 0 0
                                              72 1 0 16 37 39 1 0 74 11 75 1 0
                                              37 11 73 1 0 53 37 76 1 0 8 9 10
                                              1 0 14 9 15)))))
           '|lookupComplete|)) 
