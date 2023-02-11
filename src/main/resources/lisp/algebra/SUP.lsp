
(PUT '|SUP;makeSUP;2$;1| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |SUP;makeSUP;2$;1| ((|p| ($)) ($ (|SparseUnivariatePolynomial| R))) |p|) 

(PUT '|SUP;unmakeSUP;2$;2| '|SPADreplace| '(XLAM (|sp|) |sp|)) 

(SDEFUN |SUP;unmakeSUP;2$;2| ((|sp| (|SparseUnivariatePolynomial| R)) ($ ($)))
        |sp|) 

(SDEFUN |SUP;^;$Pi$;3| ((|p| ($)) (|np| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |p| |np| (QREFELT $ 12))) 

(SDEFUN |SUP;^;$Nni$;4| ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|rn| #1=(|NonNegativeInteger|)) (|qn| #2=(|NonNegativeInteger|))
          (|rec| (|Record| (|:| |quotient| #2#) (|:| |remainder| #1#)))
          (#3=#:G761 NIL) (|t| NIL) (#4=#:G760 NIL) (#5=#:G759 NIL) (|y| ($))
          (|cc| (R)))
         (SEQ
          (EXIT
           (COND ((ZEROP |n|) (|spadConstant| $ 15))
                 ((NULL |p|) (|spadConstant| $ 16)) ((EQL |n| 1) |p|)
                 (#6='T
                  (COND
                   ((NULL (CDR |p|))
                    (COND
                     ((SPADCALL
                       (LETT |cc|
                             (SPADCALL (QCDR (|SPADfirst| |p|)) |n|
                                       (QREFELT $ 17)))
                       (QREFELT $ 19))
                      (|spadConstant| $ 16))
                     (#6#
                      (LIST (CONS (* |n| (QCAR (|SPADfirst| |p|))) |cc|)))))
                   ((< (SPADCALL (QREFELT $ 20)) 3)
                    (SPADCALL |p| |n| (QREFELT $ 22)))
                   (#6#
                    (SEQ (LETT |y| (|spadConstant| $ 15))
                         (LETT |rec| (DIVIDE2 |n| (SPADCALL (QREFELT $ 20))))
                         (LETT |qn| (QCAR |rec|)) (LETT |rn| (QCDR |rec|))
                         (SEQ G190 NIL
                              (SEQ
                               (COND
                                ((EQL |rn| 1)
                                 (LETT |y| (SPADCALL |y| |p| (QREFELT $ 23)))))
                               (COND
                                ((> |rn| 1)
                                 (LETT |y|
                                       (SPADCALL |y|
                                                 (SPADCALL
                                                  (LIST (|SPADfirst| |p|))
                                                  (CDR |p|) |rn|
                                                  (QREFELT $ 24))
                                                 (QREFELT $ 23)))))
                               (EXIT
                                (COND
                                 ((ZEROP |qn|)
                                  (PROGN (LETT #5# |y|) (GO #7=#:G758)))
                                 ('T
                                  (SEQ
                                   (LETT |p|
                                         (PROGN
                                          (LETT #4# NIL)
                                          (SEQ (LETT |t| NIL) (LETT #3# |p|)
                                               G190
                                               (COND
                                                ((OR (ATOM #3#)
                                                     (PROGN
                                                      (LETT |t| (CAR #3#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #4#
                                                       (CONS
                                                        (CONS
                                                         (* (QCAR |t|)
                                                            (SPADCALL
                                                             (QREFELT $ 20)))
                                                         (SPADCALL (QCDR |t|)
                                                                   (QREFELT $
                                                                            25)))
                                                        #4#))))
                                               (LETT #3# (CDR #3#)) (GO G190)
                                               G191 (EXIT (NREVERSE #4#)))))
                                   (LETT |rec|
                                         (DIVIDE2 |qn|
                                                  (SPADCALL (QREFELT $ 20))))
                                   (LETT |qn| (QCAR |rec|))
                                   (EXIT (LETT |rn| (QCDR |rec|))))))))
                              NIL (GO G190) G191 (EXIT NIL))
                         (EXIT |y|)))))))
          #7# (EXIT #5#)))) 

(PUT '|SUP;zero?;$B;5| '|SPADreplace| 'NULL) 

(SDEFUN |SUP;zero?;$B;5| ((|p| ($)) ($ (|Boolean|))) (NULL |p|)) 

(SDEFUN |SUP;one?;$B;6| ((|p| ($)) ($ (|Boolean|)))
        (COND
         ((OR (OR (NULL |p|) (NULL (NULL (CDR |p|))))
              (NULL (ZEROP (QCAR (|SPADfirst| |p|)))))
          NIL)
         ('T
          (SPADCALL (QCDR (|SPADfirst| |p|)) (|spadConstant| $ 27)
                    (QREFELT $ 28))))) 

(SDEFUN |SUP;ground?;$B;7| ((|p| ($)) ($ (|Boolean|)))
        (COND ((NULL |p|) 'T)
              ((NULL (CDR |p|)) (ZEROP (QCAR (|SPADfirst| |p|)))) ('T NIL))) 

(SDEFUN |SUP;multiplyExponents;$Nni$;8|
        ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G777 NIL) (|u| NIL) (#2=#:G776 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |u| NIL) (LETT #1# |p|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (CONS (* (QCAR |u|) |n|) (QCDR |u|))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SUP;divideExponents;$NniU;9|
        ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((#2=#:G785 NIL) (|u| (|Union| $ #1#))
          (|m| (|Union| (|Integer|) "failed")))
         (SEQ
          (COND ((NULL |p|) (CONS 0 |p|))
                (#3='T
                 (SEQ
                  (LETT |m|
                        (SPADCALL (QCAR (|SPADfirst| |p|)) |n| (QREFELT $ 34)))
                  (EXIT
                   (COND ((QEQCAR |m| 1) (CONS 1 "failed"))
                         (#3#
                          (SEQ
                           (LETT |u| (SPADCALL (CDR |p|) |n| (QREFELT $ 35)))
                           (EXIT
                            (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                                  (#3#
                                   (CONS 0
                                         (CONS
                                          (CONS
                                           (PROG1 (LETT #2# (QCDR |m|))
                                             (|check_subtype2| (>= #2# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #2#))
                                           (QCDR (|SPADfirst| |p|)))
                                          (QCDR |u|)))))))))))))))) 

(SDEFUN |SUP;karatsubaDivide;$NniR;10|
        ((|p| ($)) (|n| (|NonNegativeInteger|))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPROG
         ((|highp| (|Rep|)) (#1=#:G796 NIL) (|lowp| (|Rep|)) (#2=#:G804 NIL)
          (|t| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R))))
         (SEQ
          (COND ((ZEROP |n|) (CONS |p| (|spadConstant| $ 16)))
                ('T
                 (SEQ (LETT |lowp| |p|) (LETT |highp| NIL)
                      (SEQ
                       (EXIT
                        (SEQ G190 NIL
                             (SEQ
                              (COND
                               ((NULL |lowp|)
                                (PROGN (LETT #2# 1) (GO #3=#:G799))))
                              (LETT |t| (|SPADfirst| |lowp|))
                              (COND
                               ((< (QCAR |t|) |n|)
                                (PROGN (LETT #2# 1) (GO #3#))))
                              (LETT |lowp| (CDR |lowp|))
                              (EXIT
                               (LETT |highp|
                                     (CONS
                                      (CONS
                                       (PROG2
                                           (LETT #1#
                                                 (SPADCALL (QCAR |t|) |n|
                                                           (QREFELT $ 37)))
                                           (QCDR #1#)
                                         (|check_union2| (QEQCAR #1# 0)
                                                         (|NonNegativeInteger|)
                                                         (|Union|
                                                          (|NonNegativeInteger|)
                                                          "failed")
                                                         #1#))
                                       (QCDR |t|))
                                      |highp|))))
                             NIL (GO G190) G191 (EXIT NIL)))
                       #3# (EXIT #2#))
                      (EXIT (CONS (REVERSE |highp|) |lowp|)))))))) 

(SDEFUN |SUP;shiftRight;$Nni$;11|
        ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G808 NIL) (#2=#:G813 NIL) (|t| NIL) (#3=#:G812 NIL))
               (SEQ
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |t| NIL) (LETT #2# |p|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |t| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (CONS
                                (PROG2
                                    (LETT #1#
                                          (SPADCALL (QCAR |t|) |n|
                                                    (QREFELT $ 37)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0)
                                                  (|NonNegativeInteger|)
                                                  (|Union|
                                                   (|NonNegativeInteger|)
                                                   "failed")
                                                  #1#))
                                (QCDR |t|))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#))))))) 

(SDEFUN |SUP;shiftLeft;$Nni$;12|
        ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G819 NIL) (|t| NIL) (#2=#:G818 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |p|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (CONS (+ (QCAR |t|) |n|) (QCDR |t|))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(PUT '|SUP;univariate;2$;13| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |SUP;univariate;2$;13| ((|p| ($)) ($ (|SparseUnivariatePolynomial| R)))
        |p|) 

(PUT '|SUP;multivariate;$Saos$;14| '|SPADreplace| '(XLAM (|sup| |v|) |sup|)) 

(SDEFUN |SUP;multivariate;$Saos$;14|
        ((|sup| (|SparseUnivariatePolynomial| R))
         (|v| (|SingletonAsOrderedSet|)) ($ ($)))
        |sup|) 

(SDEFUN |SUP;univariate;$SaosSup;15|
        ((|p| ($)) (|v| (|SingletonAsOrderedSet|))
         ($ (|SparseUnivariatePolynomial| $)))
        (COND ((SPADCALL |p| (QREFELT $ 26)) (|spadConstant| $ 46))
              ('T
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |p| (QREFELT $ 47)) (QREFELT $ 48))
                 (SPADCALL |p| (QREFELT $ 49)) (QREFELT $ 50))
                (SPADCALL (SPADCALL |p| (QREFELT $ 51)) |v| (QREFELT $ 53))
                (QREFELT $ 54))))) 

(SDEFUN |SUP;multivariate;SupSaos$;16|
        ((|supp| (|SparseUnivariatePolynomial| $))
         (|v| (|SingletonAsOrderedSet|)) ($ ($)))
        (SPROG ((|lc| ($)))
               (SEQ
                (COND ((SPADCALL |supp| (QREFELT $ 55)) (|spadConstant| $ 16))
                      (#1='T
                       (SEQ (LETT |lc| (SPADCALL |supp| (QREFELT $ 56)))
                            (EXIT
                             (COND
                              ((> (SPADCALL |lc| (QREFELT $ 49)) 0)
                               (|error| "bad form polynomial"))
                              (#1#
                               (SPADCALL
                                (SPADCALL (SPADCALL |lc| (QREFELT $ 47))
                                          (SPADCALL |supp| (QREFELT $ 57))
                                          (QREFELT $ 58))
                                (SPADCALL (SPADCALL |supp| (QREFELT $ 59)) |v|
                                          (QREFELT $ 60))
                                (QREFELT $ 61))))))))))) 

(SDEFUN |SUP;squareFreePolynomial;SupF;17|
        ((|pp| #1=(|SparseUnivariatePolynomial| $)) ($ (|Factored| #1#)))
        (SPADCALL |pp| (QREFELT $ 64))) 

(SDEFUN |SUP;factorPolynomial;SupF;18|
        ((|pp| #1=(|SparseUnivariatePolynomial| $)) ($ (|Factored| #1#)))
        (SPADCALL |pp| (QREFELT $ 70))) 

(SDEFUN |SUP;factorSquareFreePolynomial;SupF;19|
        ((|pp| #1=(|SparseUnivariatePolynomial| $)) ($ (|Factored| #1#)))
        (SPADCALL |pp| (QREFELT $ 70))) 

(SDEFUN |SUP;factor;$F;20| ((|p| ($)) ($ (|Factored| $)))
        (SPADCALL |p| (QREFELT $ 75))) 

(SDEFUN |SUP;solveLinearPolynomialEquation;LSupU;21|
        ((|lpp| #1=(|List| #2=(|SparseUnivariatePolynomial| $))) (|pp| #2#)
         ($ (|Union| #1# "failed")))
        (SPADCALL |lpp| |pp| (QREFELT $ 81))) 

(SDEFUN |SUP;init_one| (($ (|Void|)))
        (SEQ
         (COND ((QREFELT $ 87) "done")
               ('T
                (SEQ (QREFELT $ 85)
                     (COND
                      ((|HasCategory| (QREFELT $ 6) '(|Ring|))
                       (SETELT $ 85
                               (SPADCALL (|spadConstant| $ 27)
                                         (QREFELT $ 88)))))
                     (QREFELT $ 86)
                     (COND
                      ((|HasCategory| (QREFELT $ 6) '(|Monoid|))
                       (SETELT $ 86 (|spadConstant| $ 27))))
                     (EXIT (SETELT $ 87 'T))))))) 

(SDEFUN |SUP;toutput|
        ((|t1| (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| R)))
         (|v| #1=(|OutputForm|)) ($ (|OutputForm|)))
        (SPROG ((|mon| #1#))
               (SEQ (COND ((NULL (QREFELT $ 87)) (|SUP;init_one| $)))
                    (EXIT
                     (COND
                      ((EQL (QCAR |t1|) 0)
                       (SPADCALL (QCDR |t1|) (QREFELT $ 90)))
                      (#2='T
                       (SEQ
                        (COND ((EQL (QCAR |t1|) 1) (LETT |mon| |v|))
                              (#2#
                               (LETT |mon|
                                     (SPADCALL |v|
                                               (SPADCALL (QCAR |t1|)
                                                         (QREFELT $ 91))
                                               (QREFELT $ 92)))))
                        (EXIT
                         (COND
                          ((SPADCALL (QCDR |t1|) (|spadConstant| $ 36)
                                     (QREFELT $ 28))
                           (SPADCALL (QREFELT $ 93)))
                          ((SPADCALL (QCDR |t1|) (QREFELT $ 86) (QREFELT $ 28))
                           |mon|)
                          (#2#
                           (SEQ
                            (COND
                             ((SPADCALL (QCDR |t1|) (QREFELT $ 85)
                                        (QREFELT $ 28))
                              (COND
                               ((SPADCALL (SPADCALL (QCDR |t1|) (QREFELT $ 90))
                                          (SPADCALL -1 (QREFELT $ 94))
                                          (QREFELT $ 95))
                                (EXIT (SPADCALL |mon| (QREFELT $ 96)))))))
                            (EXIT
                             (SPADCALL (SPADCALL (QCDR |t1|) (QREFELT $ 90))
                                       |mon| (QREFELT $ 97)))))))))))))) 

(SDEFUN |SUP;outputForm;$2Of;24|
        ((|p| ($)) (|v| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (#1=#:G879 NIL) (|t| NIL)
          (#2=#:G878 NIL))
         (SEQ
          (LETT |l|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |p|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #2# (CONS (|SUP;toutput| |t| |v| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (COND ((NULL |l|) (SPADCALL 0 (QREFELT $ 94)))
                 ('T (SPADCALL (ELT $ 98) |l| (QREFELT $ 101)))))))) 

(SDEFUN |SUP;coerce;$Of;25| ((|p| ($)) ($ (|OutputForm|)))
        (SPADCALL |p| (SPADCALL "?" (QREFELT $ 104)) (QREFELT $ 102))) 

(SDEFUN |SUP;elt;$2R;26| ((|p| ($)) (|val| (R)) ($ (R)))
        (SPROG
         ((#1=#:G886 NIL) (|co| (R)) (#2=#:G883 NIL)
          (|n| (|NonNegativeInteger|)) (#3=#:G890 NIL) (|tm| NIL))
         (SEQ
          (COND ((NULL |p|) (|spadConstant| $ 36))
                (#4='T
                 (SEQ (LETT |co| (QCDR (|SPADfirst| |p|)))
                      (LETT |n| (QCAR (|SPADfirst| |p|)))
                      (SEQ (LETT |tm| NIL) (LETT #3# (CDR |p|)) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |tm| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |co|
                                   (SPADCALL
                                    (SPADCALL |co|
                                              (SPADCALL |val|
                                                        (PROG1
                                                            (LETT #2#
                                                                  (- |n|
                                                                     (LETT |n|
                                                                           (QCAR
                                                                            |tm|))))
                                                          (|check_subtype2|
                                                           (> #2# 0)
                                                           '(|PositiveInteger|)
                                                           '(|Integer|) #2#))
                                                        (QREFELT $ 106))
                                              (QREFELT $ 107))
                                    (QCDR |tm|) (QREFELT $ 108)))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND ((EQL |n| 0) |co|)
                             (#4#
                              (SPADCALL |co|
                                        (SPADCALL |val|
                                                  (PROG1 (LETT #1# |n|)
                                                    (|check_subtype2| (> #1# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|NonNegativeInteger|)
                                                                      #1#))
                                                  (QREFELT $ 106))
                                        (QREFELT $ 107))))))))))) 

(SDEFUN |SUP;elt;3$;27| ((|p| ($)) (|val| ($)) ($ ($)))
        (SPROG
         ((#1=#:G896 NIL) (|coef| ($)) (#2=#:G893 NIL)
          (|n| (|NonNegativeInteger|)) (#3=#:G900 NIL) (|tm| NIL))
         (SEQ
          (COND ((NULL |p|) (|spadConstant| $ 16))
                (#4='T
                 (SEQ
                  (LETT |coef|
                        (SPADCALL (QCDR (|SPADfirst| |p|)) (QREFELT $ 48)))
                  (LETT |n| (QCAR (|SPADfirst| |p|)))
                  (SEQ (LETT |tm| NIL) (LETT #3# (CDR |p|)) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |tm| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |coef|
                               (SPADCALL
                                (SPADCALL |coef|
                                          (SPADCALL |val|
                                                    (PROG1
                                                        (LETT #2#
                                                              (- |n|
                                                                 (LETT |n|
                                                                       (QCAR
                                                                        |tm|))))
                                                      (|check_subtype2|
                                                       (> #2# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #2#))
                                                    (QREFELT $ 14))
                                          (QREFELT $ 23))
                                (SPADCALL (QCDR |tm|) (QREFELT $ 48))
                                (QREFELT $ 61)))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (COND ((EQL |n| 0) |coef|)
                         (#4#
                          (SPADCALL |coef|
                                    (SPADCALL |val|
                                              (PROG1 (LETT #1# |n|)
                                                (|check_subtype2| (> #1# 0)
                                                                  '(|PositiveInteger|)
                                                                  '(|NonNegativeInteger|)
                                                                  #1#))
                                              (QREFELT $ 14))
                                    (QREFELT $ 23))))))))))) 

(SDEFUN |SUP;monicDivide;2$R;28|
        ((|p1| ($)) (|p2| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPROG
         ((|rout| (|Rep|)) (#1=#:G917 NIL)
          (|u| (|Union| (|NonNegativeInteger|) "failed"))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((NULL |p2|) (|error| "monicDivide: division by 0"))
                ((SPADCALL (SPADCALL |p2| (QREFELT $ 47)) (|spadConstant| $ 27)
                           (QREFELT $ 111))
                 (|error| "Divisor Not Monic"))
                ((SPADCALL |p2| (|spadConstant| $ 15) (QREFELT $ 112))
                 (CONS |p1| (|spadConstant| $ 16)))
                (#2='T
                 (COND
                  ((NULL |p1|)
                   (CONS (|spadConstant| $ 16) (|spadConstant| $ 16)))
                  ((< (SPADCALL |p1| (QREFELT $ 49))
                      (LETT |n| (SPADCALL |p2| (QREFELT $ 49))))
                   (CONS (|spadConstant| $ 16) |p1|))
                  (#2#
                   (SEQ (LETT |rout| NIL) (LETT |p2| (CDR |p2|))
                        (SEQ
                         (EXIT
                          (SEQ G190
                               (COND ((NULL (NULL (NULL |p1|))) (GO G191)))
                               (SEQ
                                (LETT |u|
                                      (SPADCALL (QCAR (|SPADfirst| |p1|)) |n|
                                                (QREFELT $ 37)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |u| 1)
                                   (PROGN (LETT #1# 1) (GO #3=#:G910)))
                                  ('T
                                   (SEQ
                                    (LETT |rout|
                                          (CONS
                                           (CONS (QCDR |u|)
                                                 (QCDR (|SPADfirst| |p1|)))
                                           |rout|))
                                    (EXIT
                                     (LETT |p1|
                                           (SPADCALL (CDR |p1|)
                                                     (QCAR
                                                      (|SPADfirst| |rout|))
                                                     (QCDR
                                                      (|SPADfirst| |rout|))
                                                     |p2|
                                                     (QREFELT $ 113)))))))))
                               NIL (GO G190) G191 (EXIT NIL)))
                         #3# (EXIT #1#))
                        (EXIT (CONS (NREVERSE |rout|) |p1|)))))))))) 

(SDEFUN |SUP;discriminant;$R;29| ((|p| ($)) ($ (R)))
        (SPADCALL |p| (QREFELT $ 116))) 

(SDEFUN |SUP;subResultantGcd;3$;30| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPADCALL |p1| |p2| (QREFELT $ 118))) 

(SDEFUN |SUP;resultant;2$R;31| ((|p1| ($)) (|p2| ($)) ($ (R)))
        (SPADCALL |p1| |p2| (QREFELT $ 120))) 

(SDEFUN |SUP;content;$R;32| ((|p| ($)) ($ (R)))
        (SPROG
         ((#1=#:G923 NIL) (#2=#:G922 (R)) (#3=#:G924 (R)) (#4=#:G927 NIL)
          (|tm| NIL))
         (SEQ
          (COND ((NULL |p|) (|spadConstant| $ 36))
                (#5='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |tm| NIL) (LETT #4# |p|) G190
                       (COND
                        ((OR (ATOM #4#) (PROGN (LETT |tm| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #3# (QCDR |tm|))
                          (COND
                           (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 122))))
                           ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                       (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#5# (|spadConstant| $ 36))))))))) 

(SDEFUN |SUP;primitivePart;2$;33| ((|p| ($)) ($ ($)))
        (SPROG ((#1=#:G930 NIL) (|ct| (R)))
               (SEQ
                (COND ((NULL |p|) |p|)
                      ('T
                       (SEQ (LETT |ct| (SPADCALL |p| (QREFELT $ 123)))
                            (EXIT
                             (SPADCALL
                              (PROG2
                                  (LETT #1#
                                        (SPADCALL |p| |ct| (QREFELT $ 124)))
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0) $
                                                (|Union| $ "failed") #1#))
                              (QREFELT $ 125))))))))) 

(SDEFUN |SUP;gcd;3$;34| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPADCALL |p1| |p2| (QREFELT $ 127))) 

(SDEFUN |SUP;divide;2$R;35|
        ((|p1| ($)) (|p2| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPROG
         ((|rout| ($)) (#1=#:G949 NIL)
          (|u| (|Union| (|NonNegativeInteger|) "failed"))
          (|n| (|NonNegativeInteger|)) (|ct| (R)))
         (SEQ
          (COND ((SPADCALL |p2| (QREFELT $ 26)) (|error| "Division by 0"))
                ((SPADCALL |p2| (|spadConstant| $ 15) (QREFELT $ 112))
                 (CONS |p1| (|spadConstant| $ 16)))
                ('T
                 (SEQ
                  (LETT |ct|
                        (SPADCALL (QCDR (|SPADfirst| |p2|)) (QREFELT $ 129)))
                  (LETT |n| (QCAR (|SPADfirst| |p2|))) (LETT |p2| (CDR |p2|))
                  (LETT |rout| NIL)
                  (SEQ
                   (EXIT
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p1| (|spadConstant| $ 16)
                                      (QREFELT $ 130)))
                           (GO G191)))
                         (SEQ
                          (LETT |u|
                                (SPADCALL (QCAR (|SPADfirst| |p1|)) |n|
                                          (QREFELT $ 37)))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (PROGN (LETT #1# 1) (GO #2=#:G945)))
                            ('T
                             (SEQ
                              (LETT |rout|
                                    (CONS
                                     (CONS (QCDR |u|)
                                           (SPADCALL |ct|
                                                     (QCDR (|SPADfirst| |p1|))
                                                     (QREFELT $ 107)))
                                     |rout|))
                              (EXIT
                               (LETT |p1|
                                     (SPADCALL (CDR |p1|)
                                               (QCAR (|SPADfirst| |rout|))
                                               (QCDR (|SPADfirst| |rout|)) |p2|
                                               (QREFELT $ 113)))))))))
                         NIL (GO G190) G191 (EXIT NIL)))
                   #2# (EXIT #1#))
                  (EXIT (CONS (NREVERSE |rout|) |p1|)))))))) 

(SDEFUN |SUP;/;$R$;36| ((|p| ($)) (|co| (R)) ($ ($)))
        (SPADCALL (SPADCALL |co| (QREFELT $ 129)) |p| (QREFELT $ 132))) 

(DECLAIM (NOTINLINE |SparseUnivariatePolynomial;|)) 

(DEFUN |SparseUnivariatePolynomial| (#1=#:G1007)
  (SPROG NIL
         (PROG (#2=#:G1008)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|SparseUnivariatePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|SparseUnivariatePolynomial;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseUnivariatePolynomial|)))))))))) 

(DEFUN |SparseUnivariatePolynomial;| (|#1|)
  (SPROG
   ((#1=#:G1006 NIL) (|pv$| NIL) (#2=#:G999 NIL) (#3=#:G1000 NIL)
    (#4=#:G1001 NIL) (#5=#:G1002 NIL) (#6=#:G1003 NIL) (#7=#:G1004 NIL)
    (#8=#:G1005 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|SparseUnivariatePolynomial| DV$1))
    (LETT $ (GETREFV 180))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#1| '(|Ring|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory|
                                          (|SingletonAsOrderedSet|)
                                          '(|ConvertibleTo| (|InputForm|))))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|EntireRing|))
                                        (LETT #8#
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|)))
                                        (OR (|HasCategory| |#1| '(|Field|)) #8#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         #8#)
                                        (LETT #7#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1| '(|Field|)) #8#
                                         #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR (|HasCategory| |#1| '(|Field|)) #8#
                                            #7#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #8# #7#)
                                        (|HasCategory| |#1| '(|StepThrough|))
                                        (|HasCategory| |#1|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         (|HasCategory| |#1| '(|Field|)) #8#
                                         #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|Comparable|))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (LETT #6#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Float|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|PatternMatchable|
                                                  (|Float|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         #6#)
                                        (LETT #5#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Integer|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|PatternMatchable|
                                                  (|Integer|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Float|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Float|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         #4#)
                                        (LETT #3#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Integer|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         #3#)
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         #2#)
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         #2#)))))
    (|haddProp| |$ConstructorCache| '|SparseUnivariatePolynomial| (LIST DV$1)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 4398046511104))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 8796093022208))
    (AND (OR (|HasCategory| |#1| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 17592186044416))
    (AND
     (OR (|HasCategory| |#1| '(|EntireRing|))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 35184372088832))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      #8# (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 70368744177664))
    (AND
     (OR (|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|Ring|)))
     (|augmentPredVector| $ 140737488355328))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#1| '(|SemiRing|)))
     (|augmentPredVector| $ 281474976710656))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#1| '(|Ring|)))
     (|augmentPredVector| $ 562949953421312))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 1125899906842624))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|AbelianGroup|))
           (|HasCategory| |#1| '(|CommutativeRing|)))
      #2#
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 2251799813685248))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianGroup|))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 4503599627370496))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7
              (|List|
               (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| |#1|))))
    (COND
     ((|HasCategory| |#1| '(|FieldOfPrimeCharacteristic|))
      (PROGN
       (QSETREFV $ 14 (CONS (|dispatchFunction| |SUP;^;$Pi$;3|) $))
       (QSETREFV $ 12 (CONS (|dispatchFunction| |SUP;^;$Nni$;4|) $)))))
    (COND
     ((|testBitVector| |pv$| 13)
      (QSETREFV $ 29 (CONS (|dispatchFunction| |SUP;one?;$B;6|) $))))
    (COND
     ((|HasCategory| |#1| '(|FiniteFieldCategory|))
      (COND
       ((|testBitVector| |pv$| 11)
        (PROGN
         (QSETREFV $ 66
                   (CONS
                    (|dispatchFunction| |SUP;squareFreePolynomial;SupF;17|) $))
         (QSETREFV $ 71
                   (CONS (|dispatchFunction| |SUP;factorPolynomial;SupF;18|)
                         $))
         (QSETREFV $ 72
                   (CONS
                    (|dispatchFunction|
                     |SUP;factorSquareFreePolynomial;SupF;19|)
                    $))
         (QSETREFV $ 77 (CONS (|dispatchFunction| |SUP;factor;$F;20|) $))
         (QSETREFV $ 84
                   (CONS
                    (|dispatchFunction|
                     |SUP;solveLinearPolynomialEquation;LSupU;21|)
                    $)))))))
    (QSETREFV $ 85 (|spadConstant| $ 36))
    (QSETREFV $ 86 (|spadConstant| $ 36))
    (QSETREFV $ 87 NIL)
    (COND
     ((|testBitVector| |pv$| 4)
      (QSETREFV $ 114 (CONS (|dispatchFunction| |SUP;monicDivide;2$R;28|) $))))
    (COND
     ((|testBitVector| |pv$| 20)
      (PROGN
       (QSETREFV $ 117 (CONS (|dispatchFunction| |SUP;discriminant;$R;29|) $))
       (QSETREFV $ 119
                 (CONS (|dispatchFunction| |SUP;subResultantGcd;3$;30|) $))
       (QSETREFV $ 121 (CONS (|dispatchFunction| |SUP;resultant;2$R;31|) $)))))
    (COND
     ((|testBitVector| |pv$| 17)
      (PROGN
       (QSETREFV $ 123 (CONS (|dispatchFunction| |SUP;content;$R;32|) $))
       (QSETREFV $ 126 (CONS (|dispatchFunction| |SUP;primitivePart;2$;33|) $))
       (QSETREFV $ 128 (CONS (|dispatchFunction| |SUP;gcd;3$;34|) $)))))
    (COND
     ((|testBitVector| |pv$| 14)
      (PROGN
       (QSETREFV $ 131 (CONS (|dispatchFunction| |SUP;divide;2$R;35|) $))
       (QSETREFV $ 133 (CONS (|dispatchFunction| |SUP;/;$R$;36|) $)))))
    $))) 

(MAKEPROP '|SparseUnivariatePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|PolynomialRing| 6 11) (|local| |#1|) '|Rep|
              (|SparseUnivariatePolynomial| 6) |SUP;makeSUP;2$;1|
              |SUP;unmakeSUP;2$;2| (|NonNegativeInteger|) (0 . ^)
              (|PositiveInteger|) (6 . ^) (12 . |One|) (16 . |Zero|) (20 . ^)
              (|Boolean|) (26 . |zero?|) (31 . |characteristic|)
              (|RepeatedSquaring| $$) (35 . |expt|) (41 . *)
              (47 . |binomThmExpt|) (54 . |primeFrobenius|) |SUP;zero?;$B;5|
              (59 . |One|) (63 . =) (69 . |one?|) |SUP;ground?;$B;7|
              |SUP;multiplyExponents;$Nni$;8| (|Union| $ '"failed") (|Integer|)
              (74 . |exquo|) |SUP;divideExponents;$NniU;9| (80 . |Zero|)
              (84 . |subtractIfCan|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              |SUP;karatsubaDivide;$NniR;10| |SUP;shiftRight;$Nni$;11|
              |SUP;shiftLeft;$Nni$;12| |SUP;univariate;2$;13|
              (|SingletonAsOrderedSet|) |SUP;multivariate;$Saos$;14|
              (|SparseUnivariatePolynomial| $$) (90 . |Zero|)
              (94 . |leadingCoefficient|) (99 . |coerce|) (104 . |degree|)
              (109 . |monomial|) (115 . |reductum|)
              (|SparseUnivariatePolynomial| $) |SUP;univariate;$SaosSup;15|
              (120 . +) (126 . |zero?|) (131 . |leadingCoefficient|)
              (136 . |degree|) (141 . |monomial|) (147 . |reductum|)
              |SUP;multivariate;SupSaos$;16| (152 . +) (|Factored| 45)
              (|UnivariatePolynomialSquareFree| $$ 45) (158 . |squareFree|)
              (|Factored| 52) (163 . |squareFreePolynomial|) (|Factored| 68)
              (|SparseUnivariatePolynomial| 8) (|TwoFactorize| 6)
              (168 . |generalTwoFactor|) (173 . |factorPolynomial|)
              (178 . |factorSquareFreePolynomial|) (|Factored| $$)
              (|DistinctDegreeFactorize| 6 $$) (183 . |factor|) (|Factored| $)
              (188 . |factor|) (|Union| 79 '"failed") (|List| 45)
              (|FiniteFieldSolveLinearPolynomialEquation| 6 $$ 45)
              (193 . |solveLinearPolynomialEquation|) (|Union| 83 '#1="failed")
              (|List| 52) (199 . |solveLinearPolynomialEquation|) '|mm_one|
              '|m_one| '|one_inited| (205 . -) (|OutputForm|) (210 . |coerce|)
              (215 . |coerce|) (220 . ^) (226 . |empty|) (230 . |coerce|)
              (235 . =) (241 . -) (246 . *) (252 . +) (|Mapping| 89 89 89)
              (|List| 89) (258 . |reduce|) |SUP;outputForm;$2Of;24| (|String|)
              (264 . |message|) |SUP;coerce;$Of;25| (269 . ^) (275 . *)
              (281 . +) |SUP;elt;$2R;26| |SUP;elt;3$;27| (287 . ~=) (293 . =)
              (299 . |fmecg|) (307 . |monicDivide|)
              (|PseudoRemainderSequence| 6 $$) (313 . |discriminant|)
              (318 . |discriminant|) (323 . |subResultantGcd|)
              (329 . |subResultantGcd|) (335 . |resultant|) (341 . |resultant|)
              (347 . |gcd|) (353 . |content|) (358 . |exquo|)
              (364 . |unitCanonical|) (369 . |primitivePart|)
              (374 . |gcdPolynomial|) (380 . |gcd|) (386 . |inv|) (391 . ~=)
              (397 . |divide|) (403 . *) (409 . /) (|Union| 140 '#1#)
              (|Matrix| $) (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 33)
              (|Record| (|:| |mat| 141) (|:| |vec| (|Vector| 33))) (|Vector| $)
              (|Matrix| 33) (|List| 144) (|List| 11) (|Symbol|)
              (|PatternMatchResult| (|Float|) $) (|PatternMatchResult| 33 $)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 33) (|Record| (|:| |k| 11) (|:| |c| 6)) (|List| 149)
              (|Mapping| 6 11) (|Record| (|:| |coef| 153) (|:| |generator| $))
              (|List| $) (|Union| 153 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 155 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Fraction| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |primePart| $) (|:| |commonPart| $))
              (|Record| (|:| |coef| 6) (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 158 '"failed") (|Union| 148 '#2="failed")
              (|Union| 33 '#2#) (|Mapping| 6 6) (|List| 43) (|Matrix| 6)
              (|Record| (|:| |mat| 167) (|:| |vec| 174)) (|Union| 43 '#2#)
              (|List| 171) (|Equation| $)
              (|Record| (|:| |var| 43) (|:| |exponent| 11))
              (|Union| 172 '"failed") (|Vector| 6) (|List| 6) (|Mapping| 11 11)
              (|Union| 6 '#2#) (|HashState|) (|SingleInteger|))
           '#(~= 415 |zero?| 421 |unmakeSUP| 426 |univariate| 431
              |unitCanonical| 442 |subResultantGcd| 447 |squareFreePolynomial|
              453 |solveLinearPolynomialEquation| 458 |shiftRight| 464
              |shiftLeft| 470 |resultant| 476 |reductum| 482 |primitivePart|
              487 |outputForm| 492 |one?| 498 |multivariate| 503
              |multiplyExponents| 515 |monomial| 521 |monicDivide| 527
              |makeSUP| 533 |leadingCoefficient| 538 |karatsubaDivide| 543
              |ground?| 549 |gcd| 554 |fmecg| 560 |factorSquareFreePolynomial|
              568 |factorPolynomial| 573 |factor| 578 |exquo| 583 |elt| 589
              |divideExponents| 601 |divide| 607 |discriminant| 613 |degree|
              618 |content| 623 |coerce| 628 |binomThmExpt| 638 ^ 645 |Zero|
              657 |One| 661 = 665 / 671 + 677 * 683)
           'NIL
           (CONS
            (|makeByteWordVec2| 42
                                '(0 0 0 11 14 0 11 14 0 18 22 4 21 17 4 1 2 3
                                  21 4 10 4 23 19 25 4 26 0 13 26 0 0 1 5 23 0
                                  0 0 1 4 0 0 0 0 0 1 1 26 15 42 13 13 0 0 41
                                  13 0 0 0 9 31 33 24 0 0 6 7 13 13 23 0 0 0 0
                                  0 0 0 0 4 6 7 8 35 37 12 13 13 14 23 16 20))
            (CONS
             '#(|UnivariatePolynomialCategory&| |PolynomialCategory&|
                |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |FiniteAbelianMonoidRing&| |UniqueFactorizationDomain&| NIL
                |AbelianMonoidRing&| |GcdDomain&| NIL
                |FullyLinearlyExplicitOver&| NIL NIL |DifferentialExtension&|
                |Algebra&| NIL NIL |Algebra&| NIL NIL
                |PartialDifferentialRing&| |Algebra&| |EntireRing&|
                |PartialDifferentialRing&| |DifferentialRing&| NIL
                |FreeModuleCategory&| NIL |Rng&| NIL NIL |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&| NIL NIL NIL
                NIL |RetractableTo&| |SetCategory&| |RetractableTo&|
                |RetractableTo&| |Evalable&| |RetractableTo&| NIL NIL NIL NIL
                |InnerEvalable&| |InnerEvalable&| NIL |BasicType&| NIL NIL NIL
                NIL NIL NIL NIL NIL |InnerEvalable&| NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariatePolynomialCategory| 6)
                 (|PolynomialCategory| 6 11 43)
                 (|MaybeSkewPolynomialCategory| 6 11 43)
                 (|PolynomialFactorizationExplicit|) (|EuclideanDomain|)
                 (|FiniteAbelianMonoidRing| 6 11) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|AbelianMonoidRing| 6 11)
                 (|GcdDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 6) (|CommutativeRing|)
                 (|LeftOreRing|) (|DifferentialExtension| 6) (|Algebra| 148)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 6)
                 (|LinearlyExplicitOver| 6) (|LinearlyExplicitOver| 33)
                 (|PartialDifferentialRing| 43) (|Algebra| $$) (|EntireRing|)
                 (|PartialDifferentialRing| 144) (|DifferentialRing|) (|Ring|)
                 (|FreeModuleCategory| 6 11) (|SemiRing|) (|Rng|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 6 11) (|Module| 148)
                 (|Module| 6) (|Module| $$) (|IndexedProductCategory| 6 11)
                 (|BiModule| 6 6) (|BiModule| $$ $$) (|BiModule| 148 148)
                 (|NonAssociativeRing|) (|AbelianProductCategory| 6)
                 (|LeftModule| 6) (|RightModule| 6) (|RightModule| $$)
                 (|LeftModule| $$) (|LeftModule| 148) (|RightModule| 148)
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|NonAssociativeSemiRng|) (|SemiGroup|)
                 (|AbelianMonoid|) (|MagmaWithUnit|) (|FullyRetractableTo| 6)
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 33)
                 (|StepThrough|) (|RetractableTo| 6) (|SetCategory|)
                 (|RetractableTo| 148) (|RetractableTo| 33) (|Evalable| $$)
                 (|RetractableTo| 43) (|CommutativeStar|) (|Eltable| $$ $$)
                 (|Eltable| 6 6) (|VariablesCommuteWithCoefficients|)
                 (|InnerEvalable| 43 $$) (|InnerEvalable| 43 6)
                 (|CoercibleFrom| 6) (|BasicType|) (|CoercibleTo| 89)
                 (|unitsKnown|) (|CoercibleFrom| 148) (|CoercibleFrom| 33)
                 (|canonicalUnitNormal|) (|ConvertibleTo| 137)
                 (|ConvertibleTo| 138) (|ConvertibleTo| 136)
                 (|InnerEvalable| $$ $$) (|CoercibleFrom| 43)
                 (|additiveValuation|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|Eltable| (|Fraction| $$) (|Fraction| $$)))
              (|makeByteWordVec2| 133
                                  '(2 0 0 0 11 12 2 0 0 0 13 14 0 0 0 15 0 0 0
                                    16 2 6 0 0 11 17 1 6 18 0 19 0 6 11 20 2 21
                                    2 2 13 22 2 0 0 0 0 23 3 0 0 0 0 11 24 1 6
                                    0 0 25 0 6 0 27 2 6 18 0 0 28 1 0 18 0 29 2
                                    33 32 0 0 34 0 6 0 36 2 11 32 0 0 37 0 45 0
                                    46 1 0 6 0 47 1 0 0 6 48 1 0 11 0 49 2 45 0
                                    2 11 50 1 0 0 0 51 2 45 0 0 0 54 1 45 18 0
                                    55 1 45 2 0 56 1 45 11 0 57 2 0 0 6 11 58 1
                                    45 0 0 59 2 0 0 0 0 61 1 63 62 45 64 1 0 65
                                    52 66 1 69 67 68 70 1 0 65 52 71 1 0 65 52
                                    72 1 74 73 2 75 1 0 76 0 77 2 80 78 79 45
                                    81 2 0 82 83 52 84 1 6 0 0 88 1 6 89 0 90 1
                                    11 89 0 91 2 89 0 0 0 92 0 89 0 93 1 33 89
                                    0 94 2 89 18 0 0 95 1 89 0 0 96 2 89 0 0 0
                                    97 2 89 0 0 0 98 2 100 89 99 0 101 1 89 0
                                    103 104 2 6 0 0 13 106 2 6 0 0 0 107 2 6 0
                                    0 0 108 2 6 18 0 0 111 2 0 18 0 0 112 4 0 0
                                    0 11 6 0 113 2 0 38 0 0 114 1 115 6 2 116 1
                                    0 6 0 117 2 115 2 2 2 118 2 0 0 0 0 119 2
                                    115 6 2 2 120 2 0 6 0 0 121 2 6 0 0 0 122 1
                                    0 6 0 123 2 0 32 0 6 124 1 0 0 0 125 1 0 0
                                    0 126 2 6 52 52 52 127 2 0 0 0 0 128 1 6 0
                                    0 129 2 0 18 0 0 130 2 0 38 0 0 131 2 0 0 6
                                    0 132 2 0 0 0 6 133 2 0 18 0 0 130 1 51 18
                                    0 26 1 0 0 8 10 1 0 8 0 42 2 0 52 0 43 53 1
                                    46 0 0 125 2 20 0 0 0 119 1 11 65 52 66 2
                                    11 82 83 52 84 2 4 0 0 11 40 2 0 0 0 11 41
                                    2 5 6 0 0 121 1 27 0 0 51 1 17 0 0 126 2 0
                                    89 0 89 102 1 49 18 0 29 2 0 0 52 43 60 2 0
                                    0 8 43 44 2 0 0 0 11 31 2 0 0 6 11 58 2 4
                                    38 0 0 114 1 0 8 0 9 1 27 6 0 47 2 4 38 0
                                    11 39 1 0 18 0 30 2 17 0 0 0 128 4 4 0 0 11
                                    6 0 113 1 11 65 52 72 1 11 65 52 71 1 11 76
                                    0 77 2 16 32 0 6 124 2 0 0 0 0 110 2 0 6 0
                                    6 109 2 0 32 0 11 35 2 14 38 0 0 131 1 5 6
                                    0 117 1 0 11 0 49 1 17 6 0 123 1 0 0 6 48 1
                                    0 89 0 105 3 43 0 0 0 11 24 2 49 0 0 11 12
                                    2 0 0 0 13 14 0 51 0 16 0 49 0 15 2 0 18 0
                                    0 112 2 14 0 0 6 133 2 0 0 0 0 61 2 0 0 6 0
                                    132 2 0 0 0 0 23)))))
           '|lookupIncomplete|)) 
