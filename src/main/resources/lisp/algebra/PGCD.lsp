
(SDEFUN |PGCD;failtest|
        ((|f| (|SparseUnivariatePolynomial| P))
         (|p1| (|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P)) ($ (|Boolean|)))
        (COND ((QEQCAR (SPADCALL |p1| |f| (QREFELT $ 13)) 1) 'T)
              ('T (QEQCAR (SPADCALL |p2| |f| (QREFELT $ 13)) 1)))) 

(SDEFUN |PGCD;chooseVal|
        ((|p1| (|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P)) (|lvr| (|List| OV))
         (|ltry| (|List| (|List| R)))
         ($
          (|Union|
           (|Record| (|:| |lpol| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |lint| (|List| (|List| R)))
                     (|:| |mpol| (|SparseUnivariatePolynomial| P)))
           "failed")))
        (SPROG
         ((|dd| (|NonNegativeInteger|)) (#1=#:G779 NIL) (#2=#:G770 NIL)
          (|f| (|Union| (|SparseUnivariatePolynomial| P) #3="failed"))
          (#4=#:G767 NIL)
          (|uterm|
           (|Record| (|:| |lpol| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |lint| (|List| (|List| R)))
                     (|:| |mpol| (|SparseUnivariatePolynomial| P))))
          (|ugcd| (|List| (|SparseUnivariatePolynomial| R))) (#5=#:G761 NIL)
          (|du| (|NonNegativeInteger|)) (|u| (|SparseUnivariatePolynomial| R))
          (|uf2| #6=(|SparseUnivariatePolynomial| R)) (|uf1| #6#)
          (|lval| (|List| R)) (#7=#:G781 NIL) (|i| NIL) (#8=#:G780 NIL)
          (|range| (|Integer|)) (|nvr| (|NonNegativeInteger|))
          (|d2| #9=(|NonNegativeInteger|)) (|d1| #9#))
         (SEQ
          (EXIT
           (SEQ (LETT |d1| (SPADCALL |p1| (QREFELT $ 15)))
                (LETT |d2| (SPADCALL |p2| (QREFELT $ 15))) (LETT |dd| 0)
                (LETT |nvr| (LENGTH |lvr|)) (LETT |lval| NIL) (LETT |range| 8)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |range| (* 2 |range|))
                           (LETT |lval|
                                 (PROGN
                                  (LETT #8# NIL)
                                  (SEQ (LETT |i| 1) (LETT #7# |nvr|) G190
                                       (COND
                                        ((|greater_SI| |i| #7#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #8#
                                               (CONS
                                                (SPADCALL |range|
                                                          (QREFELT $ 18))
                                                #8#))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT (NREVERSE #8#)))))
                           (EXIT
                            (COND
                             ((SPADCALL |lval| |ltry| (QREFELT $ 22))
                              "new point")
                             ('T
                              (SEQ (LETT |ltry| (CONS |lval| |ltry|))
                                   (LETT |uf1|
                                         (SPADCALL |p1| |lvr| |lval|
                                                   (QREFELT $ 25)))
                                   (EXIT
                                    (COND
                                     ((SPADCALL (SPADCALL |uf1| (QREFELT $ 26))
                                                |d1| (QREFELT $ 27))
                                      "new point")
                                     ('T
                                      (SEQ
                                       (LETT |uf2|
                                             (SPADCALL |p2| |lvr| |lval|
                                                       (QREFELT $ 25)))
                                       (EXIT
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |uf2| (QREFELT $ 26)) |d2|
                                           (QREFELT $ 27))
                                          "new point")
                                         ('T
                                          (SEQ
                                           (LETT |u|
                                                 (SPADCALL |uf1| |uf2|
                                                           (QREFELT $ 28)))
                                           (LETT |du|
                                                 (SPADCALL |u| (QREFELT $ 26)))
                                           (COND
                                            ((EQL |du| 0)
                                             (PROGN
                                              (LETT #1#
                                                    (CONS 0
                                                          (VECTOR
                                                           (LIST
                                                            (|spadConstant| $
                                                                            31))
                                                           |ltry|
                                                           (|spadConstant| $
                                                                           32))))
                                              (GO #10=#:G778))))
                                           (LETT |ugcd|
                                                 (LIST |u|
                                                       (PROG2
                                                           (LETT #5#
                                                                 (SPADCALL
                                                                  |uf1| |u|
                                                                  (QREFELT $
                                                                           33)))
                                                           (QCDR #5#)
                                                         (|check_union2|
                                                          (QEQCAR #5# 0)
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 8))
                                                          (|Union|
                                                           (|SparseUnivariatePolynomial|
                                                            (QREFELT $ 8))
                                                           #3#)
                                                          #5#))
                                                       (PROG2
                                                           (LETT #5#
                                                                 (SPADCALL
                                                                  |uf2| |u|
                                                                  (QREFELT $
                                                                           33)))
                                                           (QCDR #5#)
                                                         (|check_union2|
                                                          (QEQCAR #5# 0)
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 8))
                                                          (|Union|
                                                           (|SparseUnivariatePolynomial|
                                                            (QREFELT $ 8))
                                                           #3#)
                                                          #5#))))
                                           (LETT |uterm|
                                                 (VECTOR |ugcd| |ltry|
                                                         (|spadConstant| $
                                                                         32)))
                                           (EXIT
                                            (COND
                                             ((EQL |dd| 0) (LETT |dd| |du|))
                                             ((EQL |du| |dd|)
                                              (COND
                                               ((EQL |dd| |d1|)
                                                (SEQ
                                                 (SEQ
                                                  (LETT |f|
                                                        (SPADCALL |p2| |p1|
                                                                  (QREFELT $
                                                                           13)))
                                                  (EXIT
                                                   (COND
                                                    ((NULL (QEQCAR |f| 1))
                                                     (PROGN
                                                      (LETT #1#
                                                            (CONS 0
                                                                  (VECTOR
                                                                   (LIST |u|)
                                                                   |ltry|
                                                                   |p1|)))
                                                      (GO #10#))))))
                                                 (EXIT
                                                  (COND
                                                   ((SPADCALL |dd| |d2|
                                                              (QREFELT $ 27))
                                                    (LETT |dd|
                                                          (PROG1
                                                              (LETT #4#
                                                                    (- |dd| 1))
                                                            (|check_subtype2|
                                                             (>= #4# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|)
                                                             #4#))))))))
                                               ((EQL |dd| |d2|)
                                                (SEQ
                                                 (SEQ
                                                  (LETT |f|
                                                        (SPADCALL |p1| |p2|
                                                                  (QREFELT $
                                                                           13)))
                                                  (EXIT
                                                   (COND
                                                    ((NULL (QEQCAR |f| 1))
                                                     (PROGN
                                                      (LETT #1#
                                                            (CONS 0
                                                                  (VECTOR
                                                                   (LIST |u|)
                                                                   |ltry|
                                                                   |p2|)))
                                                      (GO #10#))))))
                                                 (EXIT
                                                  (LETT |dd|
                                                        (PROG1
                                                            (LETT #2#
                                                                  (- |dd| 1))
                                                          (|check_subtype2|
                                                           (>= #2# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|)
                                                           #2#))))))
                                               ('T
                                                (PROGN
                                                 (LETT #1# (CONS 0 |uterm|))
                                                 (GO #10#)))))
                                             ((< |du| |dd|)
                                              (LETT |dd| |du|)))))))))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #10# (EXIT #1#)))) 

(SDEFUN |PGCD;good|
        ((|f| (|SparseUnivariatePolynomial| P)) (|lvr| (|List| OV))
         (|ltry| (|List| (|List| R)))
         ($
          (|Record| (|:| |upol| (|SparseUnivariatePolynomial| R))
                    (|:| |inval| (|List| (|List| R))))))
        (SPROG
         ((#1=#:G791 NIL) (|uf| (|SparseUnivariatePolynomial| R))
          (|lval| (|List| R)) (#2=#:G793 NIL) (|i| NIL) (#3=#:G792 NIL)
          (|range| (|Integer|)) (|nvr| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |nvr| (LENGTH |lvr|)) (LETT |range| 1)
                (EXIT
                 (SEQ G190 (COND ((NULL 'T) (GO G191)))
                      (SEQ (LETT |range| (* 2 |range|))
                           (LETT |lval|
                                 (PROGN
                                  (LETT #3# NIL)
                                  (SEQ (LETT |i| 1) (LETT #2# |nvr|) G190
                                       (COND
                                        ((|greater_SI| |i| #2#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #3#
                                               (CONS
                                                (SPADCALL |range|
                                                          (QREFELT $ 18))
                                                #3#))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT (NREVERSE #3#)))))
                           (EXIT
                            (COND
                             ((SPADCALL |lval| |ltry| (QREFELT $ 22))
                              "new point")
                             ('T
                              (SEQ (LETT |ltry| (CONS |lval| |ltry|))
                                   (LETT |uf|
                                         (SPADCALL |f| |lvr| |lval|
                                                   (QREFELT $ 25)))
                                   (EXIT
                                    (COND
                                     ((EQL
                                       (SPADCALL
                                        (SPADCALL |uf|
                                                  (SPADCALL |uf|
                                                            (QREFELT $ 36))
                                                  (QREFELT $ 28))
                                        (QREFELT $ 26))
                                       0)
                                      (PROGN
                                       (LETT #1# (CONS |uf| |ltry|))
                                       (GO #4=#:G790))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #4# (EXIT #1#)))) 

(SDEFUN |PGCD;imposelc|
        ((|lipol| (|List| (|SparseUnivariatePolynomial| R)))
         (|lvar| (|List| OV)) (|lval| (|List| R)) (|leadc| (|List| P))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed")))
        (SPROG
         ((|result| (|List| (|SparseUnivariatePolynomial| R))) (#1=#:G809 NIL)
          (|p1u| (|Union| (|SparseUnivariatePolynomial| R) "failed"))
          (|p1| (|SparseUnivariatePolynomial| R)) (#2=#:G810 NIL) (|pol| NIL)
          (#3=#:G811 NIL) (|leadpol| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |result| NIL)
                (SEQ (LETT |leadpol| NIL) (LETT #3# |leadc|) (LETT |pol| NIL)
                     (LETT #2# |lipol|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |pol| (CAR #2#)) NIL)
                           (ATOM #3#) (PROGN (LETT |leadpol| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |p1|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL |leadpol| |lvar| |lval| (QREFELT $ 37))
                              (QREFELT $ 38))
                             |pol| (QREFELT $ 39)))
                      (LETT |p1u|
                            (SPADCALL |p1| (SPADCALL |pol| (QREFELT $ 40))
                                      (QREFELT $ 41)))
                      (EXIT
                       (COND
                        ((QEQCAR |p1u| 1)
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #4=#:G808)))
                        ('T (LETT |result| (CONS (QCDR |p1u|) |result|))))))
                     (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (REVERSE |result|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |PGCD;notCoprime|
        ((|g| (|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P))
         (|ldeg| (|List| (|NonNegativeInteger|))) (|lvar1| (|List| OV))
         (|ltry| (|List| (|List| R))) (|npmod| (R))
         ($ (|Union| (|SparseUnivariatePolynomial| P) #1="failed")))
        (SPROG
         ((#2=#:G826 NIL)
          (|resu| (|Union| (|SparseUnivariatePolynomial| P) "failed"))
          (|ug2| #3=(|SparseUnivariatePolynomial| R)) (|ug1| #3#)
          (|lcpol| (|List| P)) (|ul| #3#)
          (|p2l| (|SparseUnivariatePolynomial| P))
          (|dl| (|NonNegativeInteger|)) (|lval| (|List| R))
          (|p2u| (|Union| (|SparseUnivariatePolynomial| P) "failed"))
          (|l| #4=(|SparseUnivariatePolynomial| P))
          (|#G31|
           (|Record| (|:| |locgcd| (|SparseUnivariatePolynomial| P))
                     (|:| |goodint| (|List| (|List| R)))))
          (|lgu|
           (|Union|
            (|Record| (|:| |locgcd| #4#) (|:| |goodint| (|List| (|List| R))))
            "failed"))
          (|l1| (|SparseUnivariatePolynomial| P)) (#5=#:G813 NIL)
          (|g1| (|SparseUnivariatePolynomial| P)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |g1|
                  (SPADCALL |g| (SPADCALL |g| (QREFELT $ 42)) (QREFELT $ 43)))
            (LETT |l1|
                  (PROG2 (LETT #5# (SPADCALL |g| |g1| (QREFELT $ 13)))
                      (QCDR #5#)
                    (|check_union2| (QEQCAR #5# 0)
                                    (|SparseUnivariatePolynomial|
                                     (QREFELT $ 9))
                                    (|Union|
                                     (|SparseUnivariatePolynomial|
                                      (QREFELT $ 9))
                                     #1#)
                                    #5#)))
            (LETT |lgu| (|PGCD;localgcd| |l1| |p2| |lvar1| |ltry| |npmod| $))
            (EXIT
             (COND ((QEQCAR |lgu| 1) (CONS 1 "failed"))
                   (#6='T
                    (SEQ
                     (PROGN
                      (LETT |#G31| (QCDR |lgu|))
                      (LETT |l| (QCAR |#G31|))
                      (LETT |ltry| (QCDR |#G31|))
                      |#G31|)
                     (LETT |p2u| (SPADCALL |p2| |l| (QREFELT $ 13)))
                     (EXIT
                      (COND ((QEQCAR |p2u| 1) (CONS 1 "failed"))
                            (#6#
                             (SEQ (LETT |lval| (|SPADfirst| |ltry|))
                                  (LETT |dl| (SPADCALL |l| (QREFELT $ 15)))
                                  (LETT |p2l| (QCDR |p2u|))
                                  (LETT |ul|
                                        (SPADCALL |l| |lvar1| |lval|
                                                  (QREFELT $ 25)))
                                  (LETT |lcpol|
                                        (LIST (SPADCALL |g1| (QREFELT $ 44))
                                              (SPADCALL |p2| (QREFELT $ 44))))
                                  (COND
                                   ((EQL |dl| (SPADCALL |ul| (QREFELT $ 26)))
                                    (COND
                                     ((EQL
                                       (SPADCALL
                                        (SPADCALL |ul|
                                                  (SPADCALL |ul|
                                                            (QREFELT $ 36))
                                                  (QREFELT $ 28))
                                        (QREFELT $ 26))
                                       0)
                                      (SEQ
                                       (LETT |ug1|
                                             (SPADCALL |g1| |lvar1| |lval|
                                                       (QREFELT $ 25)))
                                       (LETT |ug2|
                                             (SPADCALL |p2l| |lvar1| |lval|
                                                       (QREFELT $ 25)))
                                       (LETT |resu|
                                             (|PGCD;not_coprime2| |l| |ul|
                                              (LIST |ug1| |ug2|) |lcpol| |ldeg|
                                              |lvar1| |lval| |npmod| $))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |resu| 0)
                                          (PROGN
                                           (LETT #2# (CONS 0 (QCDR |resu|)))
                                           (GO #7=#:G825))))))))))
                                  (EXIT (CONS 1 "failed"))))))))))))
          #7# (EXIT #2#)))) 

(SDEFUN |PGCD;not_coprime2|
        ((|l| #1=(|SparseUnivariatePolynomial| P))
         (|ul| (|SparseUnivariatePolynomial| R))
         (|ulist| (|List| (|SparseUnivariatePolynomial| R)))
         (|lcpol| (|List| P)) (|ldeg| (|List| (|NonNegativeInteger|)))
         (|lvar1| (|List| OV)) (|lval| (|List| R)) (|npmod| (R))
         ($ (|Union| (|SparseUnivariatePolynomial| P) "failed")))
        (SPROG
         ((#2=#:G830 NIL) (#3=#:G843 NIL) (|uf| NIL) (#4=#:G842 NIL)
          (|gd1| #1#) (#5=#:G841 NIL)
          (|gdl| (|Union| (|SparseUnivariatePolynomial| P) "failed"))
          (|lgcd| (P)) (|lquo| (|SparseUnivariatePolynomial| R))
          (|d| (|SparseUnivariatePolynomial| R)))
         (SEQ
          (EXIT
           (SEQ (LETT |gd1| |l|)
                (EXIT
                 (SEQ G190 (COND ((NULL 'T) (GO G191)))
                      (SEQ
                       (LETT |d| (SPADCALL (CONS |ul| |ulist|) (QREFELT $ 46)))
                       (COND
                        ((EQL (SPADCALL |d| (QREFELT $ 26)) 0)
                         (PROGN (LETT #5# (CONS 0 |gd1|)) (GO #6=#:G840))))
                       (LETT |lquo|
                             (PROG2
                                 (LETT #2# (SPADCALL |ul| |d| (QREFELT $ 33)))
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 0)
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 8))
                                               (|Union|
                                                (|SparseUnivariatePolynomial|
                                                 (QREFELT $ 8))
                                                #7="failed")
                                               #2#)))
                       (COND
                        ((SPADCALL (SPADCALL |lquo| (QREFELT $ 26)) 0
                                   (QREFELT $ 27))
                         (SEQ
                          (LETT |lgcd|
                                (SPADCALL
                                 (CONS (SPADCALL |l| (QREFELT $ 44)) |lcpol|)
                                 (QREFELT $ 48)))
                          (LETT |gdl|
                                (|PGCD;lift| |l| |d| |lquo| |lgcd| |lvar1|
                                 |ldeg| |lval| |npmod| $))
                          (EXIT
                           (COND
                            ((QEQCAR |gdl| 1)
                             (PROGN (LETT #5# (CONS 1 "failed")) (GO #6#)))
                            ('T
                             (SEQ (LETT |l| (QCDR |gdl|))
                                  (EXIT
                                   (LETT |ul|
                                         (SPADCALL |l| |lvar1| |lval|
                                                   (QREFELT $ 25)))))))))))
                       (LETT |gd1| (SPADCALL |gd1| |l| (QREFELT $ 49)))
                       (EXIT
                        (LETT |ulist|
                              (PROGN
                               (LETT #4# NIL)
                               (SEQ (LETT |uf| NIL) (LETT #3# |ulist|) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |uf| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #4#
                                            (CONS
                                             (PROG2
                                                 (LETT #2#
                                                       (SPADCALL |uf| |d|
                                                                 (QREFELT $
                                                                          33)))
                                                 (QCDR #2#)
                                               (|check_union2| (QEQCAR #2# 0)
                                                               (|SparseUnivariatePolynomial|
                                                                (QREFELT $ 8))
                                                               (|Union|
                                                                (|SparseUnivariatePolynomial|
                                                                 (QREFELT $ 8))
                                                                #7#)
                                                               #2#))
                                             #4#))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT (NREVERSE #4#)))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #6# (EXIT #5#)))) 

(SDEFUN |PGCD;next_mod| ((|m| (|Integer|)) ($ (|Integer|)))
        (SPROG ((#1=#:G848 NIL))
               (SEQ
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |m| (SPADCALL |m| (QREFELT $ 51)))
                           (EXIT
                            (COND
                             ((EQL (REM (- |m| 3) 4) 0)
                              (PROGN (LETT #1# |m|) (GO #2=#:G847))))))
                      NIL (GO G190) G191 (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |PGCD;gcdPrimitive;3Sup;8|
        ((|p1| (|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((|npmod| (|Integer|)) (#1=#:G865 NIL) (|ltry| (|List| (|List| R)))
          (|result| #2=(|SparseUnivariatePolynomial| P))
          (|#G48|
           (|Record| (|:| |locgcd| (|SparseUnivariatePolynomial| P))
                     (|:| |goodint| (|List| (|List| R)))))
          (|lgu|
           (|Union|
            (|Record| (|:| |locgcd| #2#) (|:| |goodint| (|List| (|List| R))))
            "failed"))
          (|lvar| (|List| OV)) (|d2| #3=(|NonNegativeInteger|)) (|d1| #3#)
          (|#G47| #3#) (|#G46| #3#) (|#G45| (|SparseUnivariatePolynomial| P))
          (|#G44| (|SparseUnivariatePolynomial| P)))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |d1| (SPADCALL |p1| (QREFELT $ 15)))
                 (LETT |d2| (SPADCALL |p2| (QREFELT $ 15)))
                 (EXIT
                  (COND
                   ((> |d1| |d2|)
                    (SEQ
                     (PROGN
                      (LETT |#G44| |p2|)
                      (LETT |#G45| |p1|)
                      (LETT |p1| |#G44|)
                      (LETT |p2| |#G45|))
                     (EXIT
                      (PROGN
                       (LETT |#G46| |d2|)
                       (LETT |#G47| |d1|)
                       (LETT |d1| |#G46|)
                       (LETT |d2| |#G47|))))))))
            (EXIT
             (COND
              ((EQL (SPADCALL |p1| (QREFELT $ 15)) 0)
               (COND
                ((SPADCALL |p1| (|spadConstant| $ 32) (QREFELT $ 52))
                 (SPADCALL |p2| (QREFELT $ 53)))
                (#4='T (SPADCALL |p1| (QREFELT $ 53)))))
              (#4#
               (SEQ
                (LETT |lvar|
                      (SPADCALL (ELT $ 54)
                                (SPADCALL (SPADCALL |p1| (QREFELT $ 55))
                                          (SPADCALL |p2| (QREFELT $ 55))
                                          (QREFELT $ 56))
                                (QREFELT $ 58)))
                (EXIT
                 (COND
                  ((NULL |lvar|)
                   (SPADCALL
                    (SPADCALL (SPADCALL |p1| (QREFELT $ 59))
                              (SPADCALL |p2| (QREFELT $ 59)) (QREFELT $ 28))
                    (QREFELT $ 60)))
                  ((QEQCAR (SPADCALL |p2| |p1| (QREFELT $ 13)) 0)
                   (SPADCALL |p1| (QREFELT $ 53)))
                  (#4#
                   (SEQ (LETT |ltry| NIL) (LETT |npmod| (QREFELT $ 10))
                        (EXIT
                         (SEQ G190 NIL
                              (SEQ
                               (LETT |lgu|
                                     (|PGCD;localgcd| |p1| |p2| |lvar| |ltry|
                                      (SPADCALL |npmod| (QREFELT $ 61)) $))
                               (COND
                                ((QEQCAR |lgu| 0)
                                 (SEQ
                                  (PROGN
                                   (LETT |#G48| (QCDR |lgu|))
                                   (LETT |result| (QCAR |#G48|))
                                   (LETT |ltry| (QCDR |#G48|))
                                   |#G48|)
                                  (EXIT
                                   (COND
                                    ((SPADCALL |result| (|spadConstant| $ 62)
                                               (QREFELT $ 52))
                                     (PROGN
                                      (LETT #1# (|spadConstant| $ 62))
                                      (GO #5=#:G864)))
                                    ((NULL
                                      (|PGCD;failtest| |result| |p1| |p2| $))
                                     (PROGN (LETT #1# |result|) (GO #5#))))))))
                               (EXIT
                                (LETT |npmod| (|PGCD;next_mod| |npmod| $))))
                              NIL (GO G190) G191 (EXIT NIL)))))))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |PGCD;localgcd|
        ((|p1| (|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|ltry| (|List| (|List| R))) (|npmod| (R))
         ($
          (|Union|
           (|Record| (|:| |locgcd| (|SparseUnivariatePolynomial| P))
                     (|:| |goodint| (|List| (|List| R))))
           "failed")))
        (SPROG
         ((#1=#:G874 NIL)
          (|res1u| (|Union| (|SparseUnivariatePolynomial| P) "failed"))
          (|h|
           (|Union| (|:| |s| (|SparseUnivariatePolynomial| P))
                    (|:| |failed| #2="failed")
                    (|:| |notCoprime| #3="notCoprime")))
          (|ldeg| (|List| (|NonNegativeInteger|)))
          (|dd| (|NonNegativeInteger|)) (|ud| (|SparseUnivariatePolynomial| R))
          (|listpol| (|List| (|SparseUnivariatePolynomial| R)))
          (|uterm|
           (|Record| (|:| |lpol| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |lint| (|List| (|List| R)))
                     (|:| |mpol| (|SparseUnivariatePolynomial| P))))
          (#4=#:G747 NIL))
         (SEQ
          (LETT |uterm|
                (PROG2 (LETT #4# (|PGCD;chooseVal| |p1| |p2| |lvar| |ltry| $))
                    (QCDR #4#)
                  (|check_union2| (QEQCAR #4# 0)
                                  (|Record|
                                   (|:| |lpol|
                                        (|List|
                                         (|SparseUnivariatePolynomial|
                                          (QREFELT $ 8))))
                                   (|:| |lint| (|List| (|List| (QREFELT $ 8))))
                                   (|:| |mpol|
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 9))))
                                  (|Union|
                                   (|Record|
                                    (|:| |lpol|
                                         (|List|
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 8))))
                                    (|:| |lint|
                                         (|List| (|List| (QREFELT $ 8))))
                                    (|:| |mpol|
                                         (|SparseUnivariatePolynomial|
                                          (QREFELT $ 9))))
                                   "failed")
                                  #4#)))
          (LETT |ltry| (QVELT |uterm| 1)) (LETT |listpol| (QVELT |uterm| 0))
          (LETT |ud| (|SPADfirst| |listpol|))
          (LETT |dd| (SPADCALL |ud| (QREFELT $ 26)))
          (EXIT
           (COND ((EQL |dd| 0) (CONS 0 (CONS (|spadConstant| $ 62) |ltry|)))
                 ((OR (EQL |dd| (SPADCALL |p1| (QREFELT $ 15)))
                      (EQL |dd| (SPADCALL |p2| (QREFELT $ 15))))
                  (CONS 0 (CONS (QVELT |uterm| 2) |ltry|)))
                 ('T
                  (SEQ
                   (LETT |ldeg|
                         (SPADCALL (ELT $ 64)
                                   (SPADCALL |p1| |lvar| (QREFELT $ 66))
                                   (SPADCALL |p2| |lvar| (QREFELT $ 66))
                                   (QREFELT $ 68)))
                   (LETT |h|
                         (|PGCD;lift?| |p1| |p2| |uterm| |ldeg| |lvar| |npmod|
                          $))
                   (EXIT
                    (COND
                     ((QEQCAR |h| 2)
                      (SEQ
                       (LETT |res1u|
                             (|PGCD;notCoprime| |p1| |p2| |ldeg| |lvar| |ltry|
                              |npmod| $))
                       (EXIT
                        (COND ((QEQCAR |res1u| 1) (CONS 1 "failed"))
                              (#5='T (CONS 0 (CONS (QCDR |res1u|) |ltry|)))))))
                     ((QEQCAR |h| 1) (CONS 1 "failed"))
                     (#5#
                      (CONS 0
                            (CONS
                             (PROG2 (LETT #1# |h|)
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0)
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 9))
                                               (|Union|
                                                (|:| |s|
                                                     (|SparseUnivariatePolynomial|
                                                      (QREFELT $ 9)))
                                                (|:| |failed| #2#)
                                                (|:| |notCoprime| #3#))
                                               #1#))
                             |ltry|)))))))))))) 

(SDEFUN |PGCD;monomContent|
        ((|p| (|SparseUnivariatePolynomial| P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG ((|md| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((EQL (SPADCALL |p| (QREFELT $ 15)) 0) (|spadConstant| $ 62))
                 ('T
                  (SEQ (LETT |md| (SPADCALL |p| (QREFELT $ 69)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |p| (QREFELT $ 70))
                                   (QREFELT $ 48))
                         |md| (QREFELT $ 71))))))))) 

(SDEFUN |PGCD;better| ((|p1| (P)) (|p2| (P)) ($ (|Boolean|)))
        (SPROG ((#1=#:G885 NIL))
               (COND ((SPADCALL |p1| (QREFELT $ 72)) 'T)
                     ((SPADCALL |p2| (QREFELT $ 72)) NIL)
                     ('T
                      (<
                       (SPADCALL |p1|
                                 (PROG2
                                     (LETT #1# (SPADCALL |p1| (QREFELT $ 74)))
                                     (QCDR #1#)
                                   (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                                   (|Union| (QREFELT $ 7)
                                                            #2="failed")
                                                   #1#))
                                 (QREFELT $ 75))
                       (SPADCALL |p2|
                                 (PROG2
                                     (LETT #1# (SPADCALL |p2| (QREFELT $ 74)))
                                     (QCDR #1#)
                                   (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                                   (|Union| (QREFELT $ 7) #2#)
                                                   #1#))
                                 (QREFELT $ 75))))))) 

(SDEFUN |PGCD;best_to_front| ((|l| (|List| P)) ($ (|List| P)))
        (SPROG ((|ress| (|List| P)) (|best| (P)) (#1=#:G896 NIL) (|p| NIL))
               (SEQ (LETT |ress| NIL) (LETT |best| (|SPADfirst| |l|))
                    (SEQ (LETT |p| NIL) (LETT #1# (CDR |l|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|PGCD;better| |p| |best| $)
                             (SEQ (LETT |ress| (CONS |best| |ress|))
                                  (EXIT (LETT |best| |p|))))
                            ('T (LETT |ress| (CONS |p| |ress|))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (CONS |best| |ress|))))) 

(SDEFUN |PGCD;gcdTermList| ((|p1| (P)) (|p2| (P)) ($ (P)))
        (SPROG
         ((|q| (P)) (#1=#:G904 NIL) (|term| NIL) (#2=#:G905 NIL)
          (|termList| (|List| P)) (#3=#:G898 NIL))
         (SEQ
          (LETT |termList|
                (|PGCD;best_to_front|
                 (CONS |p1|
                       (SPADCALL
                        (SPADCALL |p2|
                                  (PROG2
                                      (LETT #3# (SPADCALL |p2| (QREFELT $ 74)))
                                      (QCDR #3#)
                                    (|check_union2| (QEQCAR #3# 0)
                                                    (QREFELT $ 7)
                                                    (|Union| (QREFELT $ 7)
                                                             "failed")
                                                    #3#))
                                  (QREFELT $ 77))
                        (QREFELT $ 70)))
                 $))
          (LETT |q| (|SPADfirst| |termList|))
          (SEQ (LETT #2# NIL) (LETT |term| NIL) (LETT #1# (CDR |termList|))
               G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |term| (CAR #1#)) NIL) #2#)
                 (GO G191)))
               (SEQ (EXIT (LETT |q| (SPADCALL |q| |term| (QREFELT $ 78)))))
               (LETT #1#
                     (PROG1 (CDR #1#)
                       (LETT #2#
                             (SPADCALL |q| (|spadConstant| $ 35)
                                       (QREFELT $ 79)))))
               (GO G190) G191 (EXIT NIL))
          (EXIT |q|)))) 

(SDEFUN |PGCD;gcd;3Sup;14|
        ((|p1| (|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((#1=#:G813 NIL) (|c2| #2=(|SparseUnivariatePolynomial| P)) (|c1| #2#)
          (|#G67| (|SparseUnivariatePolynomial| P))
          (|#G66| (|SparseUnivariatePolynomial| P)))
         (SEQ
          (COND
           ((> (SPADCALL |p1| (QREFELT $ 15)) (SPADCALL |p2| (QREFELT $ 15)))
            (PROGN
             (LETT |#G66| |p2|)
             (LETT |#G67| |p1|)
             (LETT |p1| |#G66|)
             (LETT |p2| |#G67|))))
          (EXIT
           (COND
            ((EQL (SPADCALL |p1| (QREFELT $ 15)) 0)
             (COND
              ((SPADCALL |p1| (|spadConstant| $ 32) (QREFELT $ 52))
               (SPADCALL |p2| (QREFELT $ 53)))
              ((SPADCALL |p1| (|spadConstant| $ 62) (QREFELT $ 52))
               (SPADCALL |p1| (QREFELT $ 53)))
              (#3='T
               (SPADCALL
                (SPADCALL (SPADCALL |p1| (QREFELT $ 44))
                          (SPADCALL |p2| (QREFELT $ 80)) (QREFELT $ 78))
                (QREFELT $ 81)))))
            ((SPADCALL (SPADCALL |p1| (QREFELT $ 82)) (|spadConstant| $ 32)
                       (QREFELT $ 52))
             (|PGCD;gcdMonom| |p1| (|PGCD;monomContent| |p2| $) $))
            (#3#
             (SEQ (LETT |c1| (|PGCD;monomContent| |p1| $))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |p2| (QREFELT $ 82))
                               (|spadConstant| $ 32) (QREFELT $ 52))
                     (|PGCD;gcdMonom| |c1| |p2| $))
                    (#3#
                     (SEQ (LETT |c2| (|PGCD;monomContent| |p2| $))
                          (LETT |p1|
                                (PROG2
                                    (LETT #1#
                                          (SPADCALL |p1| |c1| (QREFELT $ 13)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0)
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 9))
                                                  (|Union|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 9))
                                                   #4="failed")
                                                  #1#)))
                          (LETT |p2|
                                (PROG2
                                    (LETT #1#
                                          (SPADCALL |p2| |c2| (QREFELT $ 13)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0)
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 9))
                                                  (|Union|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 9))
                                                   #4#)
                                                  #1#)))
                          (EXIT
                           (SPADCALL (SPADCALL |p1| |p2| (QREFELT $ 63))
                                     (|PGCD;gcdMonom| |c1| |c2| $)
                                     (QREFELT $ 49)))))))))))))) 

(SDEFUN |PGCD;gcdMonom|
        ((|m1| (|SparseUnivariatePolynomial| P))
         (|m2| (|SparseUnivariatePolynomial| P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPADCALL
         (SPADCALL (SPADCALL |m1| (QREFELT $ 44))
                   (SPADCALL |m2| (QREFELT $ 44)) (QREFELT $ 78))
         (MIN (SPADCALL |m1| (QREFELT $ 15)) (SPADCALL |m2| (QREFELT $ 15)))
         (QREFELT $ 71))) 

(SDEFUN |PGCD;lift?|
        ((|p1| #1=(|SparseUnivariatePolynomial| P))
         (|p2| (|SparseUnivariatePolynomial| P))
         (|uterm|
          (|Record| (|:| |lpol| (|List| (|SparseUnivariatePolynomial| R)))
                    (|:| |lint| (|List| (|List| R)))
                    (|:| |mpol| (|SparseUnivariatePolynomial| P))))
         (|ldeg| (|List| (|NonNegativeInteger|))) (|lvar| (|List| OV))
         (|npmod| (R))
         ($
          (|Union| (|:| |s| (|SparseUnivariatePolynomial| P))
                   (|:| |failed| #2="failed")
                   (|:| |notCoprime| #3="notCoprime"))))
        (SPROG
         ((|l| (|Union| (|SparseUnivariatePolynomial| P) "failed"))
          (|lgcd| (P)) (#4=#:G928 NIL) (|f| #1#)
          (|uf| (|SparseUnivariatePolynomial| R))
          (|listpol| #5=(|List| (|SparseUnivariatePolynomial| R)))
          (|d| (|SparseUnivariatePolynomial| R)) (|lval| #6=(|List| R))
          (|#G77| #6#) (|#G76| #5#))
         (SEQ
          (EXIT
           (SEQ
            (PROGN
             (LETT |#G76| (QVELT |uterm| 0))
             (LETT |#G77| (|SPADfirst| (QVELT |uterm| 1)))
             (LETT |listpol| |#G76|)
             (LETT |lval| |#G77|))
            (LETT |d| (|SPADfirst| |listpol|)) (LETT |listpol| (CDR |listpol|))
            (LETT |uf| (SPADCALL |listpol| 1 (QREFELT $ 84))) (LETT |f| |p1|)
            (COND
             ((SPADCALL
               (SPADCALL (SPADCALL |uf| |d| (QREFELT $ 28)) (QREFELT $ 26)) 0
               (QREFELT $ 27))
              (SEQ (LETT |uf| (SPADCALL |listpol| 2 (QREFELT $ 84)))
                   (LETT |f| |p2|)
                   (EXIT
                    (COND
                     ((SPADCALL
                       (SPADCALL (SPADCALL |uf| |d| (QREFELT $ 28))
                                 (QREFELT $ 26))
                       0 (QREFELT $ 27))
                      (PROGN (LETT #4# (CONS 2 #3#)) (GO #7=#:G927))))))))
            (LETT |lgcd|
                  (SPADCALL (SPADCALL |p1| (QREFELT $ 44))
                            (SPADCALL |p2| (QREFELT $ 44)) (QREFELT $ 78)))
            (LETT |l|
                  (|PGCD;lift| |f| |d| |uf| |lgcd| |lvar| |ldeg| |lval| |npmod|
                   $))
            (EXIT
             (COND ((QEQCAR |l| 1) (CONS 1 #2#)) ('T (CONS 0 (QCDR |l|)))))))
          #7# (EXIT #4#)))) 

(SDEFUN |PGCD;lift|
        ((|f| (|SparseUnivariatePolynomial| P))
         (|d| (|SparseUnivariatePolynomial| R))
         (|uf| (|SparseUnivariatePolynomial| R)) (|lgcd| (P))
         (|lvar| (|List| OV)) (|ldeg| (|List| (|NonNegativeInteger|)))
         (|lval| (|List| R)) (|npmod| (R))
         ($ (|Union| (|SparseUnivariatePolynomial| P) "failed")))
        (SPROG
         ((|p1| #1=(|SparseUnivariatePolynomial| P))
          (|p0| #2=(|SparseUnivariatePolynomial| P)) (|#G91| #2#) (|#G90| #1#)
          (|#G89| #1#) (|#G88| #2#)
          (|plist| (|List| (|SparseUnivariatePolynomial| P)))
          (|pl| (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed"))
          (|lg| (|List| (|SparseUnivariatePolynomial| R)))
          (|lgu| (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed"))
          (|leadlist| (|List| P))
          (|du| (|Union| (|SparseUnivariatePolynomial| R) "failed"))
          (|lgcd1| (R)) (|lcd| (R)) (#3=#:G947 NIL) (|n0| NIL) (#4=#:G948 NIL)
          (|n1| NIL) (#5=#:G946 NIL) (|leadpol| (|Boolean|)) (|lcf| (P)))
         (SEQ (LETT |leadpol| NIL) (LETT |lcf| (SPADCALL |f| (QREFELT $ 44)))
              (LETT |leadlist| NIL)
              (COND
               ((SPADCALL |lgcd| (|spadConstant| $ 35) (QREFELT $ 85))
                (SEQ (LETT |leadpol| 'T)
                     (LETT |f| (SPADCALL |lgcd| |f| (QREFELT $ 86)))
                     (LETT |ldeg|
                           (PROGN
                            (LETT #5# NIL)
                            (SEQ (LETT |n1| NIL)
                                 (LETT #4#
                                       (SPADCALL |lgcd| |lvar| (QREFELT $ 87)))
                                 (LETT |n0| NIL) (LETT #3# |ldeg|) G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |n0| (CAR #3#)) NIL)
                                       (ATOM #4#)
                                       (PROGN (LETT |n1| (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT (LETT #5# (CONS (+ |n0| |n1|) #5#))))
                                 (LETT #3#
                                       (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                                 (GO G190) G191 (EXIT (NREVERSE #5#)))))
                     (LETT |lcd| (SPADCALL |d| (QREFELT $ 40)))
                     (LETT |lgcd1|
                           (COND
                            ((SPADCALL (SPADCALL |lgcd| (QREFELT $ 88))
                                       (|spadConstant| $ 29) (QREFELT $ 89))
                             (SPADCALL |lgcd| (QREFELT $ 90)))
                            (#6='T
                             (SPADCALL
                              (SPADCALL |lgcd| |lvar| |lval| (QREFELT $ 37))
                              (QREFELT $ 90)))))
                     (LETT |du|
                           (SPADCALL (SPADCALL |lgcd1| |d| (QREFELT $ 91))
                                     |lcd| (QREFELT $ 41)))
                     (EXIT
                      (COND ((QEQCAR |du| 1) "failed")
                            (#6#
                             (SEQ (LETT |d| (QCDR |du|))
                                  (EXIT
                                   (LETT |uf|
                                         (SPADCALL |lcd| |uf|
                                                   (QREFELT $ 91)))))))))))
              (LETT |leadlist| (LIST |lgcd| |lcf|))
              (LETT |lgu|
                    (|PGCD;imposelc| (LIST |d| |uf|) |lvar| |lval| |leadlist|
                     $))
              (EXIT
               (COND ((QEQCAR |lgu| 1) (CONS 1 "failed"))
                     (#6#
                      (SEQ (LETT |lg| (QCDR |lgu|))
                           (LETT |pl|
                                 (SPADCALL |f| |lvar| |lg| |lval| |leadlist|
                                           |ldeg| |npmod| (QREFELT $ 94)))
                           (EXIT
                            (COND ((QEQCAR |pl| 1) (CONS 1 "failed"))
                                  (#6#
                                   (SEQ (LETT |plist| (QCDR |pl|))
                                        (PROGN
                                         (LETT |#G88| (|SPADfirst| |plist|))
                                         (LETT |#G89|
                                               (SPADCALL |plist| 2
                                                         (QREFELT $ 96)))
                                         (LETT |p0| |#G88|)
                                         (LETT |p1| |#G89|))
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |p0| |lvar| |lval|
                                                     (QREFELT $ 25))
                                           (|SPADfirst| |lg|) (QREFELT $ 97))
                                          (PROGN
                                           (LETT |#G90| |p1|)
                                           (LETT |#G91| |p0|)
                                           (LETT |p0| |#G90|)
                                           (LETT |p1| |#G91|))))
                                        (EXIT
                                         (COND
                                          (|leadpol|
                                           (SPADCALL |p0|
                                                     (SPADCALL |p0|
                                                               (QREFELT $ 80))
                                                     (QREFELT $ 98)))
                                          (#6# (CONS 0 |p0|))))))))))))))) 

(SDEFUN |PGCD;gcd;3P;18| ((|p1| (P)) (|p2| (P)) ($ (P)))
        (SPROG ((|mv2| (OV)) (#1=#:G955 NIL) (|mv1| (OV)))
               (SEQ
                (COND
                 ((SPADCALL |p1| (QREFELT $ 72))
                  (SEQ (LETT |p1| (SPADCALL |p1| (QREFELT $ 99)))
                       (EXIT
                        (COND
                         ((SPADCALL |p1| (|spadConstant| $ 35) (QREFELT $ 79))
                          |p1|)
                         ((SPADCALL |p1| (|spadConstant| $ 100) (QREFELT $ 79))
                          (SPADCALL |p2| (QREFELT $ 99)))
                         ((SPADCALL |p2| (QREFELT $ 72))
                          (SPADCALL
                           (SPADCALL (SPADCALL |p1| (QREFELT $ 90))
                                     (SPADCALL |p2| (QREFELT $ 90))
                                     (QREFELT $ 101))
                           (QREFELT $ 102)))
                         (#2='T (|PGCD;gcdTermList| |p1| |p2| $))))))
                 ((SPADCALL |p2| (QREFELT $ 72))
                  (SEQ (LETT |p2| (SPADCALL |p2| (QREFELT $ 99)))
                       (EXIT
                        (COND
                         ((SPADCALL |p2| (|spadConstant| $ 35) (QREFELT $ 79))
                          |p2|)
                         ((SPADCALL |p2| (|spadConstant| $ 100) (QREFELT $ 79))
                          (SPADCALL |p1| (QREFELT $ 99)))
                         (#2# (|PGCD;gcdTermList| |p2| |p1| $))))))
                 (#2#
                  (SEQ (LETT |p1| (SPADCALL |p1| (QREFELT $ 99)))
                       (LETT |p2| (SPADCALL |p2| (QREFELT $ 99)))
                       (EXIT
                        (COND ((SPADCALL |p1| |p2| (QREFELT $ 79)) |p1|)
                              (#2#
                               (SEQ
                                (LETT |mv1|
                                      (PROG2
                                          (LETT #1#
                                                (SPADCALL |p1| (QREFELT $ 74)))
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 #3="failed")
                                                        #1#)))
                                (LETT |mv2|
                                      (PROG2
                                          (LETT #1#
                                                (SPADCALL |p2| (QREFELT $ 74)))
                                          (QCDR #1#)
                                        (|check_union2| (QEQCAR #1# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 #3#)
                                                        #1#)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |mv1| |mv2| (QREFELT $ 103))
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL |p1| |mv1| (QREFELT $ 77))
                                     (SPADCALL |p2| |mv1| (QREFELT $ 77))
                                     (QREFELT $ 43))
                                    |mv1| (QREFELT $ 104)))
                                  ((SPADCALL |mv1| |mv2| (QREFELT $ 105))
                                   (|PGCD;gcdTermList| |p1| |p2| $))
                                  (#2#
                                   (|PGCD;gcdTermList| |p2| |p1| $)))))))))))))) 

(SDEFUN |PGCD;gcd;LP;19| ((|listp| (|List| P)) ($ (P)))
        (SPROG
         ((#1=#:G967 NIL) (|f| (P)) (#2=#:G968 NIL) (|g| NIL)
          (|lf| (|List| P)))
         (SEQ
          (EXIT
           (SEQ (LETT |lf| (|PGCD;best_to_front| |listp| $))
                (LETT |f| (|SPADfirst| |lf|))
                (SEQ (LETT |g| NIL) (LETT #2# (CDR |lf|)) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |g| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |f| (SPADCALL |f| |g| (QREFELT $ 78)))
                          (EXIT
                           (COND
                            ((SPADCALL |f| (|spadConstant| $ 35)
                                       (QREFELT $ 79))
                             (PROGN (LETT #1# |f|) (GO #3=#:G966))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT |f|)))
          #3# (EXIT #1#)))) 

(SDEFUN |PGCD;gcd;LSup;20|
        ((|listp| (|List| (|SparseUnivariatePolynomial| P)))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((#1=#:G979 NIL) (|f| (|SparseUnivariatePolynomial| P))
          (#2=#:G980 NIL) (|g| NIL)
          (|lf| (|List| (|SparseUnivariatePolynomial| P))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lf|
                  (SPADCALL (CONS #'|PGCD;gcd;LSup;20!0| $) |listp|
                            (QREFELT $ 108)))
            (LETT |f| (|SPADfirst| |lf|))
            (SEQ (LETT |g| NIL) (LETT #2# (CDR |lf|)) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |g| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ (LETT |f| (SPADCALL |f| |g| (QREFELT $ 43)))
                      (EXIT
                       (COND
                        ((SPADCALL |f| (|spadConstant| $ 62) (QREFELT $ 52))
                         (PROGN (LETT #1# |f|) (GO #3=#:G978))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT |f|)))
          #3# (EXIT #1#)))) 

(SDEFUN |PGCD;gcd;LSup;20!0| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 15)) (SPADCALL |z2| (QREFELT $ 15))
                  (QREFELT $ 106))) 

(SDEFUN |PGCD;gcdPrimitive;3P;21| ((|p1| (P)) (|p2| (P)) ($ (P)))
        (SPROG
         ((|up2| #1=(|SparseUnivariatePolynomial| P)) (|up1| #1#)
          (#2=#:G988 NIL) (|mp| (P)) (|md| (|NonNegativeInteger|)) (|mv2| (OV))
          (#3=#:G985 NIL) (|mv1| (OV)))
         (SEQ (LETT |p1| (SPADCALL |p1| (QREFELT $ 99)))
              (LETT |p2| (SPADCALL |p2| (QREFELT $ 99)))
              (EXIT
               (COND ((SPADCALL |p1| |p2| (QREFELT $ 79)) |p1|)
                     ((SPADCALL |p1| (QREFELT $ 72))
                      (COND
                       ((SPADCALL |p2| (QREFELT $ 72))
                        (SPADCALL
                         (SPADCALL (SPADCALL |p1| (QREFELT $ 90))
                                   (SPADCALL |p2| (QREFELT $ 90))
                                   (QREFELT $ 101))
                         (QREFELT $ 102)))
                       ((SPADCALL |p1| (|spadConstant| $ 100) (QREFELT $ 79))
                        |p2|)
                       (#4='T (|spadConstant| $ 35))))
                     ((SPADCALL |p2| (QREFELT $ 72))
                      (COND
                       ((SPADCALL |p2| (|spadConstant| $ 100) (QREFELT $ 79))
                        |p1|)
                       (#4# (|spadConstant| $ 35))))
                     (#4#
                      (SEQ
                       (LETT |mv1|
                             (PROG2 (LETT #3# (SPADCALL |p1| (QREFELT $ 74)))
                                 (QCDR #3#)
                               (|check_union2| (QEQCAR #3# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7)
                                                        #5="failed")
                                               #3#)))
                       (LETT |mv2|
                             (PROG2 (LETT #3# (SPADCALL |p2| (QREFELT $ 74)))
                                 (QCDR #3#)
                               (|check_union2| (QEQCAR #3# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7) #5#)
                                               #3#)))
                       (EXIT
                        (COND
                         ((SPADCALL |mv1| |mv2| (QREFELT $ 103))
                          (SEQ
                           (LETT |md|
                                 (MIN (SPADCALL |p1| |mv1| (QREFELT $ 110))
                                      (SPADCALL |p2| |mv2| (QREFELT $ 110))))
                           (LETT |mp| (|spadConstant| $ 35))
                           (COND
                            ((> |md| 1)
                             (SEQ
                              (LETT |mp|
                                    (SPADCALL (SPADCALL |mv1| (QREFELT $ 111))
                                              |md| (QREFELT $ 112)))
                              (LETT |p1|
                                    (PROG2
                                        (LETT #2#
                                              (SPADCALL |p1| |mp|
                                                        (QREFELT $ 113)))
                                        (QCDR #2#)
                                      (|check_union2| (QEQCAR #2# 0)
                                                      (QREFELT $ 9)
                                                      (|Union| (QREFELT $ 9)
                                                               #6="failed")
                                                      #2#)))
                              (EXIT
                               (LETT |p2|
                                     (PROG2
                                         (LETT #2#
                                               (SPADCALL |p2| |mp|
                                                         (QREFELT $ 113)))
                                         (QCDR #2#)
                                       (|check_union2| (QEQCAR #2# 0)
                                                       (QREFELT $ 9)
                                                       (|Union| (QREFELT $ 9)
                                                                #6#)
                                                       #2#)))))))
                           (LETT |up1| (SPADCALL |p1| |mv1| (QREFELT $ 77)))
                           (LETT |up2| (SPADCALL |p2| |mv2| (QREFELT $ 77)))
                           (EXIT
                            (SPADCALL |mp|
                                      (SPADCALL
                                       (SPADCALL |up1| |up2| (QREFELT $ 63))
                                       |mv1| (QREFELT $ 104))
                                      (QREFELT $ 114)))))
                         (#4# (|spadConstant| $ 35))))))))))) 

(SDEFUN |PGCD;gcdPrimitive;LP;22| ((|listp| (|List| P)) ($ (P)))
        (SPROG
         ((#1=#:G1004 NIL) (|f| (P)) (#2=#:G1005 NIL) (|g| NIL)
          (|lf| (|List| P)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lf|
                  (SPADCALL (CONS (|function| |PGCD;better|) $) |listp|
                            (QREFELT $ 117)))
            (LETT |f| (|SPADfirst| |lf|))
            (SEQ (LETT |g| NIL) (LETT #2# (CDR |lf|)) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |g| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ (LETT |f| (SPADCALL |f| |g| (QREFELT $ 115)))
                      (EXIT
                       (COND
                        ((SPADCALL |f| (|spadConstant| $ 35) (QREFELT $ 79))
                         (PROGN (LETT #1# |f|) (GO #3=#:G1003))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT |f|)))
          #3# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |PolynomialGcdPackage;|)) 

(DEFUN |PolynomialGcdPackage| (&REST #1=#:G1006)
  (SPROG NIL
         (PROG (#2=#:G1007)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialGcdPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialGcdPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PolynomialGcdPackage|)))))))))) 

(DEFUN |PolynomialGcdPackage;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|PolynomialGcdPackage| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 119))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PolynomialGcdPackage|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 8388619)
    $))) 

(MAKEPROP '|PolynomialGcdPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|pmod| (|Union| $ '"failed")
              (|SparseUnivariatePolynomial| 9) (0 . |exquo|)
              (|NonNegativeInteger|) (6 . |degree|) (|Integer|)
              (|FactoringUtilities| 6 7 8 9) (11 . |ran|) (|Boolean|)
              (|List| 8) (|List| 20) (16 . |member?|)
              (|SparseUnivariatePolynomial| 8) (|List| 7) (22 . |completeEval|)
              (29 . |degree|) (34 . ~=) (40 . |gcd|) (46 . |Zero|)
              (50 . |Zero|) (54 . |One|) (58 . |Zero|) (62 . |exquo|)
              (68 . |One|) (72 . |One|) (76 . |differentiate|) (81 . |eval|)
              (88 . |univariate|) (93 . *) (99 . |leadingCoefficient|)
              (104 . |exquo|) (110 . |differentiate|) |PGCD;gcd;3Sup;14|
              (115 . |leadingCoefficient|) (|List| $) (120 . |gcd|) (|List| 9)
              |PGCD;gcd;LP;19| (125 . *) (|IntegerPrimesPackage| 16)
              (131 . |nextPrime|) (136 . =) (142 . |unitCanonical|) (147 . >)
              (153 . |variables|) (158 . |setUnion|) (|Mapping| 19 7 7)
              (164 . |sort|) (170 . |lowerPolynomial|)
              (175 . |raisePolynomial|) (180 . |coerce|) (185 . |One|)
              |PGCD;gcdPrimitive;3Sup;8| (189 . |min|) (|List| 14)
              (195 . |degree|) (|Mapping| 14 14 14) (201 . |map|)
              (208 . |minimumDegree|) (213 . |coefficients|) (218 . |monomial|)
              (224 . |ground?|) (|Union| 7 '"failed") (229 . |mainVariable|)
              (234 . |degree|) (|SparseUnivariatePolynomial| $)
              (240 . |univariate|) |PGCD;gcd;3P;18| (246 . =) (252 . |content|)
              (257 . |coerce|) (262 . |reductum|) (|List| 23) (267 . |elt|)
              (273 . ~=) (279 . *) (285 . |degree|) (291 . |degree|) (296 . =)
              (302 . |retract|) (307 . *) (|Union| 95 '"failed")
              (|MultivariateLifting| 6 7 8 9) (313 . |lifting|) (|List| 12)
              (324 . |elt|) (330 . ~=) (336 . |exquo|) (342 . |unitCanonical|)
              (347 . |Zero|) (351 . |gcd|) (357 . |coerce|) (362 . =)
              (368 . |multivariate|) (374 . <) (380 . <) (|Mapping| 19 12 12)
              (386 . |sort|) |PGCD;gcd;LSup;20| (392 . |minimumDegree|)
              (398 . |coerce|) (403 . ^) (409 . |exquo|) (415 . *)
              |PGCD;gcdPrimitive;3P;21| (|Mapping| 19 9 9) (421 . |sort|)
              |PGCD;gcdPrimitive;LP;22|)
           '#(|gcdPrimitive| 427 |gcd| 444) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|gcd| (|#4| |#4| |#4|)) T)
                                   '((|gcd| (|#4| (|List| |#4|))) T)
                                   '((|gcd|
                                      ((|SparseUnivariatePolynomial| |#4|)
                                       (|SparseUnivariatePolynomial| |#4|)
                                       (|SparseUnivariatePolynomial| |#4|)))
                                     T)
                                   '((|gcd|
                                      ((|SparseUnivariatePolynomial| |#4|)
                                       (|List|
                                        (|SparseUnivariatePolynomial| |#4|))))
                                     T)
                                   '((|gcdPrimitive| (|#4| |#4| |#4|)) T)
                                   '((|gcdPrimitive|
                                      ((|SparseUnivariatePolynomial| |#4|)
                                       (|SparseUnivariatePolynomial| |#4|)
                                       (|SparseUnivariatePolynomial| |#4|)))
                                     T)
                                   '((|gcdPrimitive| (|#4| (|List| |#4|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 118
                                            '(2 12 11 0 0 13 1 12 14 0 15 1 17
                                              8 16 18 2 21 19 20 0 22 3 17 23
                                              12 24 20 25 1 23 14 0 26 2 14 19
                                              0 0 27 2 23 0 0 0 28 0 6 0 29 0 8
                                              0 30 0 23 0 31 0 12 0 32 2 23 11
                                              0 0 33 0 8 0 34 0 9 0 35 1 23 0 0
                                              36 3 9 0 0 24 20 37 1 9 23 0 38 2
                                              23 0 0 0 39 1 23 8 0 40 2 23 11 0
                                              8 41 1 12 0 0 42 1 12 9 0 44 1 23
                                              0 45 46 2 12 0 0 0 49 1 50 16 16
                                              51 2 12 19 0 0 52 1 12 0 0 53 2 7
                                              19 0 0 54 1 17 24 12 55 2 24 0 0
                                              0 56 2 24 0 57 0 58 1 17 23 12 59
                                              1 17 12 23 60 1 8 0 16 61 0 12 0
                                              62 2 14 0 0 0 64 2 17 65 12 24 66
                                              3 65 0 67 0 0 68 1 12 14 0 69 1
                                              12 47 0 70 2 12 0 9 14 71 1 9 19
                                              0 72 1 9 73 0 74 2 9 14 0 7 75 2
                                              9 76 0 7 77 2 9 19 0 0 79 1 12 9
                                              0 80 1 12 0 9 81 1 12 0 0 82 2 83
                                              23 0 16 84 2 9 19 0 0 85 2 12 0 9
                                              0 86 2 9 65 0 24 87 1 9 6 0 88 2
                                              6 19 0 0 89 1 9 8 0 90 2 23 0 8 0
                                              91 7 93 92 12 24 83 20 47 65 8 94
                                              2 95 12 0 16 96 2 23 19 0 0 97 2
                                              12 11 0 9 98 1 9 0 0 99 0 9 0 100
                                              2 8 0 0 0 101 1 9 0 8 102 2 7 19
                                              0 0 103 2 9 0 76 7 104 2 7 19 0 0
                                              105 2 16 19 0 0 106 2 95 0 107 0
                                              108 2 9 14 0 7 110 1 9 0 7 111 2
                                              9 0 0 14 112 2 9 11 0 0 113 2 9 0
                                              0 0 114 2 47 0 116 0 117 2 0 9 9
                                              9 115 1 0 9 47 118 2 0 12 12 12
                                              63 2 0 9 9 9 78 2 0 12 12 12 43 1
                                              0 9 47 48 1 0 12 95 109)))))
           '|lookupComplete|)) 
