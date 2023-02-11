
(SDEFUN |PFR;firstFactor| ((|x| (|Factored| R)) ($ (R)))
        (QVELT (|SPADfirst| (SPADCALL |x| (QREFELT $ 12))) 1)) 

(SDEFUN |PFR;firstExponent| ((|x| (|Factored| R)) ($ (|NonNegativeInteger|)))
        (QVELT (|SPADfirst| (SPADCALL |x| (QREFELT $ 12))) 2)) 

(SDEFUN |PFR;copypf| ((|a| ($)) ($ ($)))
        (CONS (QCAR |a|) (SPADCALL (QCDR |a|) (QREFELT $ 15)))) 

(SDEFUN |PFR;LessThan|
        ((|s| (|Record| (|:| |num| R) (|:| |den| (|Factored| R))))
         (|t| (|Record| (|:| |num| R) (|:| |den| (|Factored| R))))
         ($ (|Boolean|)))
        (NULL (GGREATERP (QCDR |s|) (QCDR |t|)))) 

(SDEFUN |PFR;multiplyFracTerms|
        ((|s| (|Record| (|:| |num| R) (|:| |den| (|Factored| R))))
         (|t| (|Record| (|:| |num| R) (|:| |den| (|Factored| R)))) ($ ($)))
        (SPROG
         ((|d| ($)) (|c| ($))
          (|coefs| (|Record| (|:| |coef1| R) (|:| |coef2| R)))
          (|i| (|Union| (|Record| (|:| |coef1| R) (|:| |coef2| R)) "failed")))
         (SEQ
          (COND
           ((SPADCALL (|PFR;firstFactor| (QCDR |s|) $)
                      (|PFR;firstFactor| (QCDR |t|) $) (QREFELT $ 17))
            (|PFR;normalizeFracTerm|
             (CONS (SPADCALL (QCAR |s|) (QCAR |t|) (QREFELT $ 18))
                   (SPADCALL (QCDR |s|) (QCDR |t|) (QREFELT $ 19)))
             $))
           (#1='T
            (SEQ
             (LETT |i|
                   (SPADCALL (SPADCALL (QCDR |t|) (QREFELT $ 20))
                             (SPADCALL (QCDR |s|) (QREFELT $ 20))
                             (SPADCALL (QCAR |s|) (QCAR |t|) (QREFELT $ 18))
                             (QREFELT $ 23)))
             (EXIT
              (COND ((QEQCAR |i| 1) (|error| "PartialFraction: not in ideal"))
                    (#1#
                     (SEQ (LETT |coefs| (QCDR |i|))
                          (LETT |c| (|PFR;copypf| (|spadConstant| $ 24) $))
                          (COND
                           ((SPADCALL (QCDR |coefs|) (|spadConstant| $ 25)
                                      (QREFELT $ 26))
                            (LETT |c|
                                  (|PFR;normalizeFracTerm|
                                   (CONS (QCDR |coefs|) (QCDR |t|)) $))))
                          (COND
                           ((SPADCALL (QCAR |coefs|) (|spadConstant| $ 25)
                                      (QREFELT $ 26))
                            (SEQ
                             (LETT |d|
                                   (|PFR;normalizeFracTerm|
                                    (CONS (QCAR |coefs|) (QCDR |s|)) $))
                             (PROGN
                              (RPLACA |c|
                                      (SPADCALL (QCAR |c|) (QCAR |d|)
                                                (QREFELT $ 27)))
                              (QCAR |c|))
                             (EXIT
                              (COND
                               ((NULL (NULL (QCDR |d|)))
                                (PROGN
                                 (RPLACD |c|
                                         (SPADCALL (QCDR |d|) (QCDR |c|)
                                                   (QREFELT $ 28)))
                                 (QCDR |c|))))))))
                          (EXIT |c|))))))))))) 

(SDEFUN |PFR;normalizeFracTerm|
        ((|s| (|Record| (|:| |num| R) (|:| |den| (|Factored| R)))) ($ ($)))
        (SPROG
         ((#1=#:G770 NIL)
          (|q| #2=(|Record| (|:| |quotient| R) (|:| |remainder| R)))
          (|expon| (|NonNegativeInteger|)) (|nexpon| (|NonNegativeInteger|))
          (|f| (R)) (|qr| #2#))
         (SEQ
          (LETT |qr|
                (SPADCALL (QCAR |s|) (SPADCALL (QCDR |s|) (QREFELT $ 20))
                          (QREFELT $ 30)))
          (EXIT
           (COND
            ((SPADCALL (QCDR |qr|) (|spadConstant| $ 25) (QREFELT $ 17))
             (CONS (QCAR |qr|) NIL))
            (#3='T
             (SEQ (LETT |f| (|PFR;firstFactor| (QCDR |s|) $))
                  (LETT |nexpon| (|PFR;firstExponent| (QCDR |s|) $))
                  (LETT |expon| 0)
                  (LETT |q| (SPADCALL (QCDR |qr|) |f| (QREFELT $ 30)))
                  (SEQ G190
                       (COND
                        ((NULL
                          (COND
                           ((SPADCALL (QCDR |q|) (|spadConstant| $ 25)
                                      (QREFELT $ 17))
                            (< |expon| |nexpon|))
                           ('T NIL)))
                         (GO G191)))
                       (SEQ (LETT |expon| (+ |expon| 1))
                            (PROGN (RPLACD |qr| (QCAR |q|)) (QCDR |qr|))
                            (EXIT
                             (LETT |q|
                                   (SPADCALL (QCDR |qr|) |f| (QREFELT $ 30)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (COND
                    ((EQL |expon| 0)
                     (CONS (QCAR |qr|) (LIST (CONS (QCDR |qr|) (QCDR |s|)))))
                    ((EQL |expon| |nexpon|)
                     (SPADCALL
                      (SPADCALL (QCAR |qr|) (QCDR |qr|) (QREFELT $ 27))
                      (QREFELT $ 33)))
                    (#3#
                     (CONS (QCAR |qr|)
                           (LIST
                            (CONS (QCDR |qr|)
                                  (SPADCALL |f|
                                            (PROG1
                                                (LETT #1# (- |nexpon| |expon|))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 35))))))))))))))) 

(SDEFUN |PFR;partialFractionNormalized|
        ((|nm| (R)) (|dn| (|Factored| R)) ($ ($)))
        (SPROG
         ((|c| ($)) (|d| ($)) (#1=#:G785 NIL) (|i| NIL)
          (|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R))))
         (SEQ
          (COND
           ((SPADCALL |nm| (|spadConstant| $ 25) (QREFELT $ 17))
            (|spadConstant| $ 24))
           ((SPADCALL |dn| (|spadConstant| $ 36) (QREFELT $ 37))
            (SPADCALL |nm| (QREFELT $ 33)))
           ('T
            (SEQ
             (LETT |qr|
                   (SPADCALL |nm| (SPADCALL |dn| (QREFELT $ 20))
                             (QREFELT $ 30)))
             (LETT |c|
                   (CONS (|spadConstant| $ 25)
                         (LIST
                          (CONS (QCDR |qr|)
                                (SPADCALL (|PFR;firstFactor| |dn| $)
                                          (|PFR;firstExponent| |dn| $)
                                          (QREFELT $ 35))))))
             (SEQ (LETT |i| NIL)
                  (LETT #1# (CDR (SPADCALL |dn| (QREFELT $ 12)))) G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ
                   (LETT |d|
                         (CONS (|spadConstant| $ 25)
                               (LIST
                                (CONS (|spadConstant| $ 32)
                                      (SPADCALL (QVELT |i| 1) (QVELT |i| 2)
                                                (QREFELT $ 35))))))
                   (EXIT (LETT |c| (SPADCALL |c| |d| (QREFELT $ 38)))))
                  (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
             (EXIT
              (SPADCALL (SPADCALL (QCAR |qr|) (QREFELT $ 33)) |c|
                        (QREFELT $ 39))))))))) 

(SDEFUN |PFR;padicFraction;2$;8| ((|a| ($)) ($ ($)))
        (SPROG
         ((|d| #1=(|Integer|)) (|sp| (|SparseUnivariatePolynomial| R))
          (|l| (|List| (|Record| (|:| |num| R) (|:| |den| (|Factored| R)))))
          (#2=#:G790 NIL) (|f| (R)) (|e| #1#) (#3=#:G802 NIL) (|s| NIL)
          (|b| ($)))
         (SEQ (LETT |b| (SPADCALL |a| (QREFELT $ 40)))
              (EXIT
               (COND ((NULL (QCDR |b|)) |b|)
                     ('T
                      (SEQ (LETT |l| NIL)
                           (SEQ (LETT |s| NIL) (LETT #3# (QCDR |b|)) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |s| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |e| (|PFR;firstExponent| (QCDR |s|) $))
                                 (EXIT
                                  (COND ((EQL |e| 1) (LETT |l| (CONS |s| |l|)))
                                        ('T
                                         (SEQ
                                          (LETT |f|
                                                (|PFR;firstFactor| (QCDR |s|)
                                                 $))
                                          (LETT |d|
                                                (SPADCALL
                                                 (LETT |sp|
                                                       (SPADCALL |f| (QCAR |s|)
                                                                 (QREFELT $
                                                                          42)))
                                                 (QREFELT $ 43)))
                                          (EXIT
                                           (SEQ G190
                                                (COND
                                                 ((NULL
                                                   (SPADCALL |sp|
                                                             (|spadConstant| $
                                                                             44)
                                                             (QREFELT $ 45)))
                                                  (GO G191)))
                                                (SEQ
                                                 (LETT |l|
                                                       (CONS
                                                        (CONS
                                                         (SPADCALL |sp|
                                                                   (QREFELT $
                                                                            46))
                                                         (SPADCALL |f|
                                                                   (PROG1
                                                                       (LETT
                                                                        #2#
                                                                        (- |e|
                                                                           |d|))
                                                                     (|check_subtype2|
                                                                      (>= #2#
                                                                          0)
                                                                      '(|NonNegativeInteger|)
                                                                      '(|Integer|)
                                                                      #2#))
                                                                   (QREFELT $
                                                                            35)))
                                                        |l|))
                                                 (EXIT
                                                  (LETT |d|
                                                        (SPADCALL
                                                         (LETT |sp|
                                                               (SPADCALL |sp|
                                                                         (QREFELT
                                                                          $
                                                                          47)))
                                                         (QREFELT $ 43)))))
                                                NIL (GO G190) G191
                                                (EXIT NIL))))))))
                                (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (CONS (QCAR |b|)
                                  (SPADCALL
                                   (CONS (|function| |PFR;LessThan|) $) |l|
                                   (QREFELT $ 49))))))))))) 

(SDEFUN |PFR;compactFraction;2$;9| ((|a| ($)) ($ ($)))
        (SPROG
         ((|b| ($)) (|e| (|Integer|)) (|f| (R))
          (|s| (|Record| (|:| |num| R) (|:| |den| (|Factored| R))))
          (|bf| (|List| (|Record| (|:| |num| R) (|:| |den| (|Factored| R)))))
          (|bw| (R)) (#1=#:G808 NIL) (#2=#:G816 NIL) (|t| NIL)
          (|af| (|List| (|Record| (|:| |num| R) (|:| |den| (|Factored| R))))))
         (SEQ
          (COND ((> 2 (LENGTH (QCDR |a|))) |a|)
                ('T
                 (SEQ (LETT |af| (REVERSE (QCDR |a|))) (LETT |bf| NIL)
                      (LETT |bw| (QCAR |a|))
                      (LETT |s|
                            (CONS (QCAR (|SPADfirst| |af|))
                                  (QCDR (|SPADfirst| |af|))))
                      (LETT |f| (|PFR;firstFactor| (QCDR |s|) $))
                      (LETT |e| (|PFR;firstExponent| (QCDR |s|) $))
                      (SEQ (LETT |t| NIL) (LETT #2# (CDR |af|)) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |t| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |f| (|PFR;firstFactor| (QCDR |t|) $)
                                         (QREFELT $ 17))
                               (PROGN
                                (RPLACA |s|
                                        (SPADCALL (QCAR |s|)
                                                  (SPADCALL (QCAR |t|)
                                                            (SPADCALL |f|
                                                                      (PROG1
                                                                          (LETT
                                                                           #1#
                                                                           (-
                                                                            |e|
                                                                            (|PFR;firstExponent|
                                                                             (QCDR
                                                                              |t|)
                                                                             $)))
                                                                        (|check_subtype2|
                                                                         (>=
                                                                          #1#
                                                                          0)
                                                                         '(|NonNegativeInteger|)
                                                                         '(|Integer|)
                                                                         #1#))
                                                                      (QREFELT
                                                                       $ 51))
                                                            (QREFELT $ 18))
                                                  (QREFELT $ 27)))
                                (QCAR |s|)))
                              ('T
                               (SEQ (LETT |b| (|PFR;normalizeFracTerm| |s| $))
                                    (LETT |bw|
                                          (SPADCALL |bw| (QCAR |b|)
                                                    (QREFELT $ 27)))
                                    (COND
                                     ((NULL (NULL (QCDR |b|)))
                                      (LETT |bf|
                                            (CONS (|SPADfirst| (QCDR |b|))
                                                  |bf|))))
                                    (LETT |s| (CONS (QCAR |t|) (QCDR |t|)))
                                    (LETT |f| (|PFR;firstFactor| (QCDR |s|) $))
                                    (EXIT
                                     (LETT |e|
                                           (|PFR;firstExponent| (QCDR |s|)
                                            $))))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (LETT |b| (|PFR;normalizeFracTerm| |s| $))
                      (EXIT
                       (CONS (SPADCALL |bw| (QCAR |b|) (QREFELT $ 27))
                             (SPADCALL (QCDR |b|) |bf| (QREFELT $ 28)))))))))) 

(SDEFUN |PFR;Zero;$;10| (($ ($))) (CONS (|spadConstant| $ 25) NIL)) 

(SDEFUN |PFR;One;$;11| (($ ($))) (CONS (|spadConstant| $ 32) NIL)) 

(SDEFUN |PFR;characteristic;Nni;12| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 52))) 

(PUT '|PFR;coerce;R$;13| '|SPADreplace| '(XLAM (|r|) (CONS |r| NIL))) 

(SDEFUN |PFR;coerce;R$;13| ((|r| (R)) ($ ($))) (CONS |r| NIL)) 

(SDEFUN |PFR;coerce;I$;14| ((|n| (|Integer|)) ($ ($)))
        (CONS (SPADCALL |n| (QREFELT $ 55)) NIL)) 

(SDEFUN |PFR;coerce;$F;15| ((|a| ($)) ($ (|Fraction| R)))
        (SPROG ((|q| (|Fraction| R)) (#1=#:G835 NIL) (|s| NIL))
               (SEQ (LETT |q| (SPADCALL (QCAR |a|) (QREFELT $ 58)))
                    (SEQ (LETT |s| NIL) (LETT #1# (QCDR |a|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |q|
                                 (SPADCALL |q|
                                           (SPADCALL (QCAR |s|)
                                                     (SPADCALL (QCDR |s|)
                                                               (QREFELT $ 20))
                                                     (QREFELT $ 59))
                                           (QREFELT $ 60)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |q|)))) 

(SDEFUN |PFR;coerce;F$;16| ((|q| (|Fraction| (|Factored| R))) ($ ($)))
        (SPROG ((|r1| (R)) (|u| (R)) (#1=#:G838 NIL))
               (SEQ
                (LETT |u|
                      (PROG2
                          (LETT #1#
                                (SPADCALL
                                 (SPADCALL (SPADCALL |q| (QREFELT $ 63))
                                           (QREFELT $ 64))
                                 (QREFELT $ 66)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                        (|Union| (QREFELT $ 6) "failed") #1#)))
                (LETT |r1|
                      (SPADCALL |u|
                                (SPADCALL (SPADCALL |q| (QREFELT $ 67))
                                          (QREFELT $ 20))
                                (QREFELT $ 18)))
                (EXIT
                 (|PFR;partialFractionNormalized| |r1|
                  (SPADCALL |u| (SPADCALL |q| (QREFELT $ 63)) (QREFELT $ 68))
                  $))))) 

(SDEFUN |PFR;exquo;2$U;17| ((|a| ($)) (|b| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|br| (|Fraction| R)))
               (SEQ
                (COND
                 ((SPADCALL |b| (|spadConstant| $ 24) (QREFELT $ 70))
                  (CONS 1 "failed"))
                 ((SPADCALL |b| (|spadConstant| $ 31) (QREFELT $ 70))
                  (CONS 0 |a|))
                 ('T
                  (SEQ
                   (LETT |br|
                         (SPADCALL (SPADCALL |b| (QREFELT $ 61))
                                   (QREFELT $ 71)))
                   (EXIT
                    (CONS 0
                          (SPADCALL |a|
                                    (SPADCALL (SPADCALL |br| (QREFELT $ 72))
                                              (SPADCALL
                                               (SPADCALL |br| (QREFELT $ 73))
                                               (QREFELT $ 74))
                                              (QREFELT $ 75))
                                    (QREFELT $ 38)))))))))) 

(SDEFUN |PFR;recip;$U;18| ((|a| ($)) ($ (|Union| $ "failed")))
        (SPADCALL (|spadConstant| $ 31) |a| (QREFELT $ 76))) 

(SDEFUN |PFR;numberOfFractionalTerms;$I;19| ((|a| ($)) ($ (|Integer|)))
        (LENGTH (QCDR |a|))) 

(PUT '|PFR;wholePart;$R;20| '|SPADreplace| 'QCAR) 

(SDEFUN |PFR;wholePart;$R;20| ((|a| ($)) ($ (R))) (QCAR |a|)) 

(PUT '|PFR;fractionalTerms;$L;21| '|SPADreplace| 'QCDR) 

(SDEFUN |PFR;fractionalTerms;$L;21|
        ((|a| ($))
         ($ (|List| (|Record| (|:| |num| R) (|:| |den| (|Factored| R))))))
        (QCDR |a|)) 

(SDEFUN |PFR;partialFraction;RF$;22| ((|nm| (R)) (|dn| (|Factored| R)) ($ ($)))
        (SPROG ((|u| (R)) (#1=#:G860 NIL))
               (SEQ
                (COND
                 ((SPADCALL |nm| (|spadConstant| $ 25) (QREFELT $ 17))
                  (|spadConstant| $ 24))
                 ('T
                  (SEQ (LETT |u| (SPADCALL |dn| (QREFELT $ 64)))
                       (LETT |u|
                             (PROG2 (LETT #1# (SPADCALL |u| (QREFELT $ 66)))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                               (|Union| (QREFELT $ 6) "failed")
                                               #1#)))
                       (EXIT
                        (|PFR;partialFractionNormalized|
                         (SPADCALL |u| |nm| (QREFELT $ 18))
                         (SPADCALL |u| |dn| (QREFELT $ 68)) $)))))))) 

(SDEFUN |PFR;padicallyExpand;2RSup;23|
        ((|p| (R)) (|r| (R)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG ((|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R))))
               (SEQ (LETT |qr| (SPADCALL |r| |p| (QREFELT $ 30)))
                    (EXIT
                     (COND
                      ((SPADCALL (QCAR |qr|) (|spadConstant| $ 25)
                                 (QREFELT $ 17))
                       (SPADCALL (QCDR |qr|) (QREFELT $ 81)))
                      ('T
                       (SPADCALL (SPADCALL (QCDR |qr|) (QREFELT $ 81))
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 32) 1
                                            (QREFELT $ 82))
                                  (SPADCALL |p| (QCAR |qr|) (QREFELT $ 42))
                                  (QREFELT $ 83))
                                 (QREFELT $ 84)))))))) 

(SDEFUN |PFR;=;2$B;24| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 26)) NIL)
              ((NULL (QCDR |a|))
               (COND
                ((NULL (QCDR |b|))
                 (SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 17)))
                (#1='T NIL)))
              ((NULL (QCDR |b|)) NIL)
              (#1#
               (SPADCALL (SPADCALL |a| (QREFELT $ 61))
                         (SPADCALL |b| (QREFELT $ 61)) (QREFELT $ 85))))) 

(SDEFUN |PFR;-;2$;25| ((|a| ($)) ($ ($)))
        (SPROG
         ((|l| (|List| (|Record| (|:| |num| R) (|:| |den| (|Factored| R)))))
          (#1=#:G882 NIL) (|s| NIL))
         (SEQ (LETT |l| NIL)
              (SEQ (LETT |s| NIL) (LETT #1# (REVERSE (QCDR |a|))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |l|
                           (CONS
                            (CONS (SPADCALL (QCAR |s|) (QREFELT $ 86))
                                  (QCDR |s|))
                            |l|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (SPADCALL (QCAR |a|) (QREFELT $ 86)) |l|))))) 

(SDEFUN |PFR;*;R2$;26| ((|r| (R)) (|a| ($)) ($ ($)))
        (SPROG ((#1=#:G893 NIL) (|c| ($)) (#2=#:G894 NIL) (|s| NIL) (|b| ($)))
               (SEQ
                (COND
                 ((SPADCALL |r| (|spadConstant| $ 25) (QREFELT $ 17))
                  (|spadConstant| $ 24))
                 ((SPADCALL |r| (|spadConstant| $ 32) (QREFELT $ 17)) |a|)
                 ('T
                  (SEQ
                   (LETT |b|
                         (SPADCALL (SPADCALL |r| (QCAR |a|) (QREFELT $ 18))
                                   (QREFELT $ 33)))
                   (SEQ (LETT |s| NIL) (LETT #2# (REVERSE (QCDR |a|))) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ
                           (LETT |c|
                                 (|PFR;normalizeFracTerm|
                                  (CONS
                                   (SPADCALL |r| (QCAR |s|) (QREFELT $ 18))
                                   (QCDR |s|))
                                  $))
                           (PROGN
                            (RPLACA |b|
                                    (SPADCALL (QCAR |b|) (QCAR |c|)
                                              (QREFELT $ 27)))
                            (QCAR |b|))
                           (EXIT
                            (COND
                             ((NULL (NULL (QCDR |c|)))
                              (PROGN
                               (LETT #1#
                                     (PROGN
                                      (RPLACD |b|
                                              (SPADCALL (QCDR |c|) (QCDR |b|)
                                                        (QREFELT $ 28)))
                                      (QCDR |b|)))
                               (GO #3=#:G887)))))))
                         #3# (EXIT #1#))
                        (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                   (EXIT |b|))))))) 

(SDEFUN |PFR;*;I2$;27| ((|n| (|Integer|)) (|a| ($)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 55)) |a| (QREFELT $ 88))) 

(SDEFUN |PFR;+;3$;28| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (CONS (SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 27))
               (SPADCALL (CONS (|function| |PFR;LessThan|) $)
                         (SPADCALL (QCDR |a|)
                                   (SPADCALL (QCDR |b|) (QREFELT $ 15))
                                   (QREFELT $ 28))
                         (QREFELT $ 49)))
         (QREFELT $ 40))) 

(SDEFUN |PFR;*;3$;29| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|c| ($)) (#1=#:G912 NIL) (|t| NIL) (#2=#:G911 NIL) (|s| NIL)
          (|af| ($)))
         (SEQ
          (COND ((NULL (QCDR |a|)) (SPADCALL (QCAR |a|) |b| (QREFELT $ 88)))
                ((NULL (QCDR |b|)) (SPADCALL (QCAR |b|) |a| (QREFELT $ 88)))
                ('T
                 (SEQ (LETT |af| (CONS (|spadConstant| $ 25) (QCDR |a|)))
                      (LETT |c|
                            (SPADCALL (SPADCALL (QCAR |a|) |b| (QREFELT $ 88))
                                      (SPADCALL (QCAR |b|) |af| (QREFELT $ 88))
                                      (QREFELT $ 39)))
                      (SEQ (LETT |s| NIL) (LETT #2# (QCDR |a|)) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (SEQ (LETT |t| NIL) (LETT #1# (QCDR |b|)) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |t| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT |c|
                                          (SPADCALL |c|
                                                    (|PFR;multiplyFracTerms|
                                                     |s| |t| $)
                                                    (QREFELT $ 39)))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |c|))))))) 

(SDEFUN |PFR;coerce;$Of;30| ((|a| ($)) ($ (|OutputForm|)))
        (SPROG ((|l| (|List| (|OutputForm|))) (#1=#:G926 NIL) (|s| NIL))
               (SEQ
                (COND ((NULL (QCDR |a|)) (SPADCALL (QCAR |a|) (QREFELT $ 91)))
                      (#2='T
                       (SEQ
                        (COND
                         ((SPADCALL (QCAR |a|) (|spadConstant| $ 25)
                                    (QREFELT $ 17))
                          (LETT |l| NIL))
                         (#2#
                          (LETT |l|
                                (LIST (SPADCALL (QCAR |a|) (QREFELT $ 91))))))
                        (SEQ (LETT |s| NIL) (LETT #1# (QCDR |a|)) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL (QCDR |s|) (|spadConstant| $ 36)
                                           (QREFELT $ 37))
                                 (LETT |l|
                                       (CONS
                                        (SPADCALL (QCAR |s|) (QREFELT $ 91))
                                        |l|)))
                                ('T
                                 (LETT |l|
                                       (CONS
                                        (SPADCALL
                                         (SPADCALL (QCAR |s|) (QREFELT $ 91))
                                         (SPADCALL (QCDR |s|) (QREFELT $ 92))
                                         (QREFELT $ 93))
                                        |l|))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND ((EQL (LENGTH |l|) 1) (|SPADfirst| |l|))
                               (#2#
                                (SPADCALL (ELT $ 94) (REVERSE |l|)
                                          (QREFELT $ 97))))))))))) 

(SDEFUN |PFR;partialFraction;F$;31| ((|f| (|Fraction| R)) ($ ($)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 72))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 73)) (QREFELT $ 100))
                  (QREFELT $ 75))) 

(DECLAIM (NOTINLINE |PartialFraction;|)) 

(DEFUN |PartialFraction| (#1=#:G937)
  (SPROG NIL
         (PROG (#2=#:G938)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PartialFraction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PartialFraction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PartialFraction|)))))))))) 

(DEFUN |PartialFraction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PartialFraction| DV$1))
          (LETT $ (GETREFV 114))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|UniqueFactorizationDomain|))))))
          (|haddProp| |$ConstructorCache| '|PartialFraction| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |whole| |#1|)
                              (|:| |fract|
                                   (|List|
                                    (|Record| (|:| |num| |#1|)
                                              (|:| |den|
                                                   (|Factored| |#1|)))))))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 101
                      (CONS (|dispatchFunction| |PFR;partialFraction;F$;31|)
                            $))))
          $))) 

(MAKEPROP '|PartialFraction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 8) (|:| |factor| 6) (|:| |exponent| 34))
              (|List| 9) (|Factored| 6) (0 . |factorList|)
              (|Record| (|:| |num| 6) (|:| |den| 11)) (|List| 13) (5 . |copy|)
              (|Boolean|) (10 . =) (16 . *) (22 . *) (28 . |expand|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 21 '#1="failed") (33 . |extendedEuclidean|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |PFR;Zero;$;10|) $))
              (40 . |Zero|) (44 . ~=) (50 . +) (56 . |append|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $)) (62 . |divide|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |PFR;One;$;11|) $))
              (68 . |One|) |PFR;coerce;R$;13| (|NonNegativeInteger|)
              (72 . |nilFactor|) (78 . |One|) (82 . =) |PFR;*;3$;29|
              |PFR;+;3$;28| |PFR;compactFraction;2$;9|
              (|SparseUnivariatePolynomial| 6) |PFR;padicallyExpand;2RSup;23|
              (88 . |degree|) (93 . |Zero|) (97 . ~=)
              (103 . |leadingCoefficient|) (108 . |reductum|)
              (|Mapping| 16 13 13) (113 . |sort|) |PFR;padicFraction;2$;8|
              (119 . ^) (125 . |characteristic|) |PFR;characteristic;Nni;12|
              (|Integer|) (129 . |coerce|) |PFR;coerce;I$;14| (|Fraction| 6)
              (134 . |coerce|) (139 . /) (145 . +) |PFR;coerce;$F;15|
              (|Fraction| 11) (151 . |denom|) (156 . |unit|)
              (|Union| $ '"failed") (161 . |recip|) (166 . |numer|) (171 . *)
              |PFR;coerce;F$;16| |PFR;=;2$B;24| (177 . |inv|) (182 . |numer|)
              (187 . |denom|) (192 . |coerce|) |PFR;partialFraction;RF$;22|
              |PFR;exquo;2$U;17| |PFR;recip;$U;18|
              |PFR;numberOfFractionalTerms;$I;19| |PFR;wholePart;$R;20|
              |PFR;fractionalTerms;$L;21| (197 . |coerce|) (202 . |monomial|)
              (208 . *) (214 . +) (220 . =) (226 . -) |PFR;-;2$;25|
              |PFR;*;R2$;26| |PFR;*;I2$;27| (|OutputForm|) (231 . |coerce|)
              (236 . |coerce|) (241 . /) (247 . +) (|Mapping| 90 90 90)
              (|List| 90) (253 . |reduce|) |PFR;coerce;$Of;30| (|Factored| $)
              (259 . |factor|) (264 . |partialFraction|) (|Fraction| 54)
              (|Union| 104 '#1#) (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef| 104) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 269 |zero?| 275 |wholePart| 280 |unitNormal| 285
              |unitCanonical| 290 |unit?| 295 |subtractIfCan| 300
              |squareFreePart| 306 |squareFree| 311 |sizeLess?| 316 |sample|
              322 |rightRecip| 326 |rightPower| 331 |rem| 343 |recip| 349 |quo|
              354 |principalIdeal| 360 |prime?| 365 |partialFraction| 370
              |padicallyExpand| 381 |padicFraction| 387 |opposite?| 392 |one?|
              398 |numberOfFractionalTerms| 403 |multiEuclidean| 408
              |leftRecip| 414 |leftPower| 419 |lcmCoef| 431 |lcm| 437 |latex|
              448 |inv| 453 |hashUpdate!| 458 |hash| 464 |gcdPolynomial| 469
              |gcd| 475 |fractionalTerms| 486 |factor| 491 |extendedEuclidean|
              496 |exquo| 509 |expressIdealMember| 515 |euclideanSize| 521
              |divide| 526 |compactFraction| 532 |commutator| 537 |coerce| 543
              |characteristic| 578 |associator| 582 |associates?| 589
              |antiCommutator| 595 |annihilate?| 601 ^ 607 |Zero| 625 |One| 629
              = 633 / 639 - 645 + 656 * 662)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0))
            (CONS
             '#(|Field&| |EuclideanDomain&| NIL |UniqueFactorizationDomain&|
                |GcdDomain&| NIL |DivisionRing&| NIL NIL |Algebra&| |Algebra&|
                |EntireRing&| |Algebra&| NIL |Rng&| NIL |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL |NonAssociativeRng&| NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| NIL |SetCategory&| NIL NIL NIL NIL
                NIL |BasicType&| NIL)
             (CONS
              '#((|Field|) (|EuclideanDomain|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|) (|IntegralDomain|)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|Algebra| 6) (|Algebra| 102) (|EntireRing|) (|Algebra| $$)
                 (|Ring|) (|Rng|) (|SemiRing|) (|Module| 6) (|Module| 102)
                 (|Module| $$) (|SemiRng|) (|BiModule| 6 6)
                 (|BiModule| 102 102) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|RightModule| 6) (|LeftModule| 6) (|RightModule| 102)
                 (|LeftModule| 102) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|CommutativeStar|) (|SetCategory|) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 90))
              (|makeByteWordVec2| 113
                                  '(1 11 10 0 12 1 14 0 0 15 2 6 16 0 0 17 2 6
                                    0 0 0 18 2 11 0 0 0 19 1 11 6 0 20 3 6 22 0
                                    0 0 23 0 6 0 25 2 6 16 0 0 26 2 6 0 0 0 27
                                    2 14 0 0 0 28 2 6 29 0 0 30 0 6 0 32 2 11 0
                                    6 34 35 0 11 0 36 2 11 16 0 0 37 1 41 34 0
                                    43 0 41 0 44 2 41 16 0 0 45 1 41 6 0 46 1
                                    41 0 0 47 2 14 0 48 0 49 2 6 0 0 34 51 0 6
                                    34 52 1 6 0 54 55 1 57 0 6 58 2 57 0 6 6 59
                                    2 57 0 0 0 60 1 62 11 0 63 1 11 6 0 64 1 6
                                    65 0 66 1 62 11 0 67 2 11 0 6 0 68 1 57 0 0
                                    71 1 57 6 0 72 1 57 6 0 73 1 11 0 6 74 1 41
                                    0 6 81 2 41 0 6 34 82 2 41 0 0 0 83 2 41 0
                                    0 0 84 2 57 16 0 0 85 1 6 0 0 86 1 6 90 0
                                    91 1 11 90 0 92 2 90 0 0 0 93 2 90 0 0 0 94
                                    2 96 90 95 0 97 1 6 99 0 100 1 0 0 57 101 2
                                    0 16 0 0 1 1 0 16 0 1 1 0 6 0 79 1 0 109 0
                                    1 1 0 0 0 1 1 0 16 0 1 2 0 65 0 0 1 1 0 0 0
                                    1 1 0 99 0 1 2 0 16 0 0 1 0 0 0 1 1 0 65 0
                                    1 2 0 0 0 34 1 2 0 0 0 110 1 2 0 0 0 0 1 1
                                    0 65 0 77 2 0 0 0 0 1 1 0 106 104 1 1 0 16
                                    0 1 1 1 0 57 101 2 0 0 6 11 75 2 0 41 6 6
                                    42 1 0 0 0 50 2 0 16 0 0 1 1 0 16 0 1 1 0
                                    54 0 78 2 0 103 104 0 1 1 0 65 0 1 2 0 0 0
                                    34 1 2 0 0 0 110 1 2 0 108 0 0 1 1 0 0 104
                                    1 2 0 0 0 0 1 1 0 111 0 1 1 0 0 0 1 2 0 113
                                    113 0 1 1 0 112 0 1 2 0 107 107 107 1 1 0 0
                                    104 1 2 0 0 0 0 1 1 0 14 0 80 1 0 99 0 1 3
                                    0 22 0 0 0 1 2 0 105 0 0 1 2 0 65 0 0 76 2
                                    0 103 104 0 1 1 0 34 0 1 2 0 29 0 0 1 1 0 0
                                    0 40 2 0 0 0 0 1 1 0 57 0 61 1 0 0 62 69 1
                                    0 0 6 33 1 0 0 102 1 1 0 0 0 1 1 0 0 54 56
                                    1 0 90 0 98 0 0 34 53 3 0 0 0 0 0 1 2 0 16
                                    0 0 1 2 0 0 0 0 1 2 0 16 0 0 1 2 0 0 0 54 1
                                    2 0 0 0 34 1 2 0 0 0 110 1 0 0 0 24 0 0 0
                                    31 2 0 16 0 0 70 2 0 0 0 0 1 1 0 0 0 87 2 0
                                    0 0 0 1 2 0 0 0 0 39 2 0 0 6 0 88 2 0 0 0 6
                                    1 2 0 0 0 102 1 2 0 0 102 0 1 2 0 0 34 0 1
                                    2 0 0 54 0 89 2 0 0 0 0 38 2 0 0 110 0
                                    1)))))
           '|lookupComplete|)) 
