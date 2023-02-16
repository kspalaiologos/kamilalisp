
(SDEFUN |CONTFRAC;reducedForm;2$;1| ((|c| ($)) ($ ($)))
        (COND ((QCDR |c|) |c|)
              ((SPADCALL (QCDR (QCAR |c|)) (QREFELT $ 11))
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |c| (QREFELT $ 13)) (QREFELT $ 14))
                 (QREFELT $ 16))
                (QREFELT $ 17)))
              ((COND
                ((COND
                  ((|HasCategory| (QREFELT $ 6) '(|OrderedRing|))
                   (|HasCategory| (QREFELT $ 6) '(|multiplicativeValuation|)))
                  (#1='T NIL))
                 'T)
                (#1# (|HasCategory| (QREFELT $ 6) '(|additiveValuation|))))
               (|CONTFRAC;genFromSequence| (SPADCALL |c| (QREFELT $ 18)) $))
              (#1#
               (|error|
                "Reduced form not defined for this continued fraction.")))) 

(SDEFUN |CONTFRAC;eucWhole| ((|a| (|Fraction| R)) ($ (R)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 20)) (SPADCALL |a| (QREFELT $ 21))
                  (QREFELT $ 22))) 

(SDEFUN |CONTFRAC;eucWhole0| ((|a| (|Fraction| R)) ($ (R)))
        (SPROG ((|q| (R)) (|r| (R)) (|d| (R)) (|n| (R)))
               (SEQ
                (COND
                 ((COND
                   ((|HasCategory| (QREFELT $ 6) '(|OrderedRing|))
                    (|HasCategory| (QREFELT $ 6) '(|multiplicativeValuation|)))
                   (#1='T NIL))
                  (SEQ (LETT |n| (SPADCALL |a| (QREFELT $ 20)))
                       (LETT |d| (SPADCALL |a| (QREFELT $ 21)))
                       (LETT |q| (SPADCALL |n| |d| (QREFELT $ 22)))
                       (LETT |r|
                             (SPADCALL |n| (SPADCALL |q| |d| (QREFELT $ 23))
                                       (QREFELT $ 24)))
                       (COND
                        ((SPADCALL |r| (|spadConstant| $ 26) (QREFELT $ 27))
                         (LETT |q|
                               (SPADCALL |q| (|spadConstant| $ 29)
                                         (QREFELT $ 24)))))
                       (EXIT |q|)))
                 (#1# (|CONTFRAC;eucWhole| |a| $)))))) 

(SDEFUN |CONTFRAC;=;2$B;4| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG
         ((|yl| #1=(|Stream| (|Record| (|:| |num| R) (|:| |den| R))))
          (|xl| #1#) (#2=#:G740 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |x| (SPADCALL |x| (QREFELT $ 19)))
                (LETT |y| (SPADCALL |y| (QREFELT $ 19)))
                (EXIT
                 (COND
                  ((SPADCALL (QCAR (QCAR |x|)) (QCAR (QCAR |y|))
                             (QREFELT $ 30))
                   NIL)
                  (#3='T
                   (SEQ (LETT |xl| (QCDR (QCAR |x|)))
                        (LETT |yl| (QCDR (QCAR |y|)))
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((SPADCALL |xl| (QREFELT $ 31)) NIL)
                                      ('T
                                       (NULL (SPADCALL |yl| (QREFELT $ 31))))))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (QCDR (SPADCALL |xl| (QREFELT $ 32)))
                                  (QCDR (SPADCALL |yl| (QREFELT $ 32)))
                                  (QREFELT $ 30))
                                 (PROGN (LETT #2# NIL) (GO #4=#:G739)))
                                ('T
                                 (SEQ
                                  (LETT |xl| (SPADCALL |xl| (QREFELT $ 33)))
                                  (EXIT
                                   (LETT |yl|
                                         (SPADCALL |yl| (QREFELT $ 33)))))))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((SPADCALL |xl| (QREFELT $ 31))
                           (SPADCALL |yl| (QREFELT $ 31)))
                          (#3# NIL)))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |CONTFRAC;continuedFraction;F$;5| ((|q| (|Fraction| R)) ($ ($)))
        (SPADCALL |q| (QREFELT $ 35))) 

(SDEFUN |CONTFRAC;continuedFraction;R2S$;6|
        ((|wh| (R)) (|nums| (|Stream| R)) (|dens| (|Stream| R)) ($ ($)))
        (CONS (CONS |wh| (|CONTFRAC;genFractionA| |nums| |dens| $)) NIL)) 

(SDEFUN |CONTFRAC;genFractionA|
        ((|nums| (|Stream| R)) (|dens| (|Stream| R))
         ($ (|Stream| (|Record| (|:| |num| R) (|:| |den| R)))))
        (SPROG ((|d| (R)) (|n| (R)))
               (SEQ
                (COND
                 ((OR (SPADCALL |nums| (QREFELT $ 38))
                      (SPADCALL |dens| (QREFELT $ 38)))
                  (SPADCALL (QREFELT $ 39)))
                 ('T
                  (SEQ (LETT |n| (SPADCALL |nums| (QREFELT $ 40)))
                       (LETT |d| (SPADCALL |dens| (QREFELT $ 40)))
                       (EXIT
                        (COND
                         ((SPADCALL |n| (|spadConstant| $ 26) (QREFELT $ 27))
                          (|error| "Numerators must be greater than 0."))
                         ((SPADCALL |d| (|spadConstant| $ 26) (QREFELT $ 27))
                          (|error| "Denominators must be greater than 0."))
                         ('T
                          (SPADCALL (CONS |n| |d|)
                                    (SPADCALL
                                     (CONS #'|CONTFRAC;genFractionA!0|
                                           (VECTOR |dens| $ |nums|))
                                     (QREFELT $ 43))
                                    (QREFELT $ 44))))))))))) 

(SDEFUN |CONTFRAC;genFractionA!0| (($$ NIL))
        (PROG (|nums| $ |dens|)
          (LETT |nums| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |dens| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|CONTFRAC;genFractionA| (SPADCALL |nums| (QREFELT $ 41))
             (SPADCALL |dens| (QREFELT $ 41)) $))))) 

(SDEFUN |CONTFRAC;continuedFraction;R2S$;8|
        ((|wh| (R)) (|nums| (|Stream| R)) (|dens| (|Stream| R)) ($ ($)))
        (CONS (CONS |wh| (|CONTFRAC;genFractionB| |nums| |dens| $)) NIL)) 

(SDEFUN |CONTFRAC;genFractionB|
        ((|nums| (|Stream| R)) (|dens| (|Stream| R))
         ($ (|Stream| (|Record| (|:| |num| R) (|:| |den| R)))))
        (SPROG ((|d| (R)) (|n| (R)))
               (SEQ
                (COND
                 ((OR (SPADCALL |nums| (QREFELT $ 38))
                      (SPADCALL |dens| (QREFELT $ 38)))
                  (SPADCALL (QREFELT $ 39)))
                 ('T
                  (SEQ (LETT |n| (SPADCALL |nums| (QREFELT $ 40)))
                       (LETT |d| (SPADCALL |dens| (QREFELT $ 40)))
                       (EXIT
                        (SPADCALL (CONS |n| |d|)
                                  (SPADCALL
                                   (CONS #'|CONTFRAC;genFractionB!0|
                                         (VECTOR |dens| $ |nums|))
                                   (QREFELT $ 43))
                                  (QREFELT $ 44))))))))) 

(SDEFUN |CONTFRAC;genFractionB!0| (($$ NIL))
        (PROG (|nums| $ |dens|)
          (LETT |nums| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |dens| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|CONTFRAC;genFractionB| (SPADCALL |nums| (QREFELT $ 41))
             (SPADCALL |dens| (QREFELT $ 41)) $))))) 

(SDEFUN |CONTFRAC;reducedContinuedFraction;RS$;10|
        ((|wh| (R)) (|dens| (|Stream| R)) ($ ($)))
        (SPADCALL |wh| (SPADCALL (LIST (|spadConstant| $ 29)) (QREFELT $ 46))
                  |dens| (QREFELT $ 37))) 

(SDEFUN |CONTFRAC;coerce;I$;11| ((|n| (|Integer|)) ($ ($)))
        (CONS (CONS (SPADCALL |n| (QREFELT $ 49)) (SPADCALL (QREFELT $ 39)))
              'T)) 

(SDEFUN |CONTFRAC;coerce;R$;12| ((|r| (R)) ($ ($)))
        (CONS (CONS |r| (SPADCALL (QREFELT $ 39))) 'T)) 

(SDEFUN |CONTFRAC;coerce;F$;13| ((|a| (|Fraction| R)) ($ ($)))
        (SPROG
         ((|d| (R)) (|n| (R))
          (|l| (|List| (|Record| (|:| |num| R) (|:| |den| R))))
          (|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R)))
          (|fr| (|Fraction| R)) (|wh| (R)))
         (SEQ (LETT |wh| (|CONTFRAC;eucWhole0| |a| $))
              (LETT |fr|
                    (SPADCALL |a| (SPADCALL |wh| (QREFELT $ 52))
                              (QREFELT $ 53)))
              (EXIT
               (COND
                ((SPADCALL |fr| (QREFELT $ 54))
                 (CONS (CONS |wh| (SPADCALL (QREFELT $ 39))) 'T))
                ('T
                 (SEQ (LETT |l| NIL) (LETT |n| (SPADCALL |fr| (QREFELT $ 20)))
                      (LETT |d| (SPADCALL |fr| (QREFELT $ 21)))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |d| (QREFELT $ 55))))
                             (GO G191)))
                           (SEQ (LETT |qr| (SPADCALL |n| |d| (QREFELT $ 57)))
                                (LETT |l|
                                      (CONS
                                       (CONS (|spadConstant| $ 29) (QCAR |qr|))
                                       |l|))
                                (LETT |n| |d|) (EXIT (LETT |d| (QCDR |qr|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (CONS
                        (CONS |wh|
                              (SPADCALL (CDR (NREVERSE |l|)) (QREFELT $ 59)))
                        'T))))))))) 

(SDEFUN |CONTFRAC;characteristic;Nni;14| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 61))) 

(SDEFUN |CONTFRAC;genFromSequence| ((|apps| (|Stream| (|Fraction| R))) ($ ($)))
        (SPROG ((|wh| (R)) (|hi| #1=(|Fraction| R)) (|lo| #1#))
               (SEQ (LETT |lo| (SPADCALL |apps| (QREFELT $ 63)))
                    (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))
                    (LETT |hi| (SPADCALL |apps| (QREFELT $ 63)))
                    (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL (|CONTFRAC;eucWhole0| |lo| $)
                                      (|CONTFRAC;eucWhole0| |hi| $)
                                      (QREFELT $ 30)))
                           (GO G191)))
                         (SEQ (LETT |lo| (SPADCALL |apps| (QREFELT $ 63)))
                              (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))
                              (LETT |hi| (SPADCALL |apps| (QREFELT $ 63)))
                              (EXIT
                               (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |wh| (|CONTFRAC;eucWhole0| |lo| $))
                    (EXIT
                     (CONS
                      (CONS |wh|
                            (|CONTFRAC;genReducedForm|
                             (SPADCALL |wh| (QREFELT $ 52)) |apps|
                             (SPADCALL (|spadConstant| $ 65)
                                       (|spadConstant| $ 66)
                                       (|spadConstant| $ 66)
                                       (|spadConstant| $ 65) (QREFELT $ 68))
                             $))
                      (COND
                       ((COND
                         ((|HasCategory| (QREFELT $ 6) '(|OrderedRing|))
                          (|HasCategory| (QREFELT $ 6)
                                         '(|multiplicativeValuation|)))
                         (#2='T NIL))
                        'T)
                       (#2#
                        (|HasCategory| (QREFELT $ 6)
                                       '(|additiveValuation|))))))))) 

(SDEFUN |CONTFRAC;genReducedForm|
        ((|wh0| (|Fraction| R)) (|apps| (|Stream| (|Fraction| R)))
         (|mt| (|MoebiusTransform| (|Fraction| R)))
         ($ (|Stream| (|Record| (|:| |num| R) (|:| |den| R)))))
        (SPROG ((|whi| (R)) (|wlo| (R)) (|hi| #1=(|Fraction| R)) (|lo| #1#))
               (SEQ
                (LETT |lo|
                      (SPADCALL (SPADCALL |apps| (QREFELT $ 63)) |wh0|
                                (QREFELT $ 53)))
                (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))
                (LETT |hi|
                      (SPADCALL (SPADCALL |apps| (QREFELT $ 63)) |wh0|
                                (QREFELT $ 53)))
                (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))
                (COND
                 ((SPADCALL |lo| |hi| (QREFELT $ 69))
                  (COND
                   ((SPADCALL (SPADCALL |mt| |lo| (QREFELT $ 70))
                              (QREFELT $ 54))
                    (EXIT (SPADCALL (QREFELT $ 39)))))))
                (LETT |mt| (SPADCALL |mt| (QREFELT $ 71)))
                (LETT |wlo|
                      (|CONTFRAC;eucWhole| (SPADCALL |mt| |lo| (QREFELT $ 70))
                       $))
                (LETT |whi|
                      (|CONTFRAC;eucWhole| (SPADCALL |mt| |hi| (QREFELT $ 70))
                       $))
                (SEQ G190
                     (COND
                      ((NULL (SPADCALL |wlo| |whi| (QREFELT $ 30))) (GO G191)))
                     (SEQ
                      (LETT |wlo|
                            (|CONTFRAC;eucWhole|
                             (SPADCALL |mt|
                                       (SPADCALL
                                        (SPADCALL |apps| (QREFELT $ 63)) |wh0|
                                        (QREFELT $ 53))
                                       (QREFELT $ 70))
                             $))
                      (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))
                      (LETT |whi|
                            (|CONTFRAC;eucWhole|
                             (SPADCALL |mt|
                                       (SPADCALL
                                        (SPADCALL |apps| (QREFELT $ 63)) |wh0|
                                        (QREFELT $ 53))
                                       (QREFELT $ 70))
                             $))
                      (EXIT (LETT |apps| (SPADCALL |apps| (QREFELT $ 64)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT
                 (SPADCALL (CONS (|spadConstant| $ 29) |wlo|)
                           (SPADCALL
                            (CONS #'|CONTFRAC;genReducedForm!0|
                                  (VECTOR $ |wlo| |mt| |apps| |wh0|))
                            (QREFELT $ 43))
                           (QREFELT $ 44)))))) 

(SDEFUN |CONTFRAC;genReducedForm!0| (($$ NIL))
        (PROG (|wh0| |apps| |mt| |wlo| $)
          (LETT |wh0| (QREFELT $$ 4))
          (LETT |apps| (QREFELT $$ 3))
          (LETT |mt| (QREFELT $$ 2))
          (LETT |wlo| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|CONTFRAC;genReducedForm| |wh0| |apps|
             (SPADCALL |mt|
                       (SPADCALL (SPADCALL |wlo| (QREFELT $ 52))
                                 (QREFELT $ 72))
                       (QREFELT $ 73))
             $))))) 

(SDEFUN |CONTFRAC;wholePart;$R;17| ((|c| ($)) ($ (R))) (QCAR (QCAR |c|))) 

(SDEFUN |CONTFRAC;partialNumerators;$S;18| ((|c| ($)) ($ (|Stream| R)))
        (SPADCALL (LIST #'|CONTFRAC;partialNumerators;$S;18!0|)
                  (QCDR (QCAR |c|)) (QREFELT $ 77))) 

(SDEFUN |CONTFRAC;partialNumerators;$S;18!0| ((|x| NIL) ($$ NIL)) (QCAR |x|)) 

(SDEFUN |CONTFRAC;partialDenominators;$S;19| ((|c| ($)) ($ (|Stream| R)))
        (SPADCALL (LIST #'|CONTFRAC;partialDenominators;$S;19!0|)
                  (QCDR (QCAR |c|)) (QREFELT $ 77))) 

(SDEFUN |CONTFRAC;partialDenominators;$S;19!0| ((|x| NIL) ($$ NIL)) (QCDR |x|)) 

(SDEFUN |CONTFRAC;partialQuotients;$S;20| ((|c| ($)) ($ (|Stream| R)))
        (SPADCALL (QCAR (QCAR |c|)) (SPADCALL |c| (QREFELT $ 79))
                  (QREFELT $ 80))) 

(SDEFUN |CONTFRAC;approximants;$S;21| ((|c| ($)) ($ (|Stream| (|Fraction| R))))
        (COND
         ((SPADCALL (QCDR (QCAR |c|)) (QREFELT $ 31))
          (SPADCALL (LIST (SPADCALL (QCAR (QCAR |c|)) (QREFELT $ 52)))
                    (QREFELT $ 83)))
         ('T
          (|CONTFRAC;genApproximants| (|spadConstant| $ 29)
           (|spadConstant| $ 26) (QCAR (QCAR |c|)) (|spadConstant| $ 29)
           (QCDR (QCAR |c|)) $)))) 

(SDEFUN |CONTFRAC;convergents;$S;22| ((|c| ($)) ($ (|Stream| (|Fraction| R))))
        (COND
         ((SPADCALL (QCDR (QCAR |c|)) (QREFELT $ 31))
          (SPADCALL (SPADCALL (QCAR (QCAR |c|)) (QREFELT $ 52))
                    (SPADCALL (QREFELT $ 84)) (QREFELT $ 85)))
         ('T
          (|CONTFRAC;genConvergents| (|spadConstant| $ 29)
           (|spadConstant| $ 26) (QCAR (QCAR |c|)) (|spadConstant| $ 29)
           (QCDR (QCAR |c|)) $)))) 

(SDEFUN |CONTFRAC;numerators;$S;23| ((|c| ($)) ($ (|Stream| R)))
        (COND
         ((SPADCALL (QCDR (QCAR |c|)) (QREFELT $ 31))
          (SPADCALL (QCAR (QCAR |c|)) (SPADCALL (QREFELT $ 86))
                    (QREFELT $ 80)))
         ('T
          (|CONTFRAC;genNumDen| (|spadConstant| $ 29) (QCAR (QCAR |c|))
           (QCDR (QCAR |c|)) $)))) 

(SDEFUN |CONTFRAC;denominators;$S;24| ((|c| ($)) ($ (|Stream| R)))
        (|CONTFRAC;genNumDen| (|spadConstant| $ 26) (|spadConstant| $ 29)
         (QCDR (QCAR |c|)) $)) 

(SDEFUN |CONTFRAC;extend;$I$;25| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SEQ (SPADCALL (QCDR (QCAR |x|)) |n| (QREFELT $ 89)) (EXIT |x|))) 

(SDEFUN |CONTFRAC;complete;2$;26| ((|x| ($)) ($ ($)))
        (SEQ (SPADCALL (QCDR (QCAR |x|)) (QREFELT $ 91)) (EXIT |x|))) 

(SDEFUN |CONTFRAC;iGenApproximants|
        ((|pm2| (R)) (|qm2| (R)) (|pm1| (R)) (|qm1| (R))
         (|fr| (|Stream| (|Record| (|:| |num| R) (|:| |den| R))))
         ($ (|Stream| (|Fraction| R))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|CONTFRAC;iGenApproximants!0|
                       (VECTOR |qm1| |qm2| |pm1| |pm2| $ |fr|))
                 (QREFELT $ 94))))) 

(SDEFUN |CONTFRAC;iGenApproximants!0| (($$ NIL))
        (PROG (|fr| $ |pm2| |pm1| |qm2| |qm1|)
          (LETT |fr| (QREFELT $$ 5))
          (LETT $ (QREFELT $$ 4))
          (LETT |pm2| (QREFELT $$ 3))
          (LETT |pm1| (QREFELT $$ 2))
          (LETT |qm2| (QREFELT $$ 1))
          (LETT |qm1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|nd| NIL) (|pm| NIL) (|qm| NIL))
                   (SEQ (LETT |nd| (SPADCALL |fr| (QREFELT $ 32)))
                        (LETT |pm|
                              (SPADCALL
                               (SPADCALL (QCAR |nd|) |pm2| (QREFELT $ 23))
                               (SPADCALL (QCDR |nd|) |pm1| (QREFELT $ 23))
                               (QREFELT $ 93)))
                        (LETT |qm|
                              (SPADCALL
                               (SPADCALL (QCAR |nd|) |qm2| (QREFELT $ 23))
                               (SPADCALL (QCDR |nd|) |qm1| (QREFELT $ 23))
                               (QREFELT $ 93)))
                        (EXIT
                         (|CONTFRAC;genApproximants| |pm1| |qm1| |pm| |qm|
                          (SPADCALL |fr| (QREFELT $ 33)) $)))))))) 

(SDEFUN |CONTFRAC;genApproximants|
        ((|pm2| (R)) (|qm2| (R)) (|pm1| (R)) (|qm1| (R))
         (|fr| (|Stream| (|Record| (|:| |num| R) (|:| |den| R))))
         ($ (|Stream| (|Fraction| R))))
        (COND
         ((SPADCALL |fr| (QREFELT $ 31))
          (SPADCALL (LIST (SPADCALL |pm1| |qm1| (QREFELT $ 95)))
                    (QREFELT $ 83)))
         ('T
          (SPADCALL (SPADCALL |pm1| |qm1| (QREFELT $ 95))
                    (|CONTFRAC;iGenApproximants| |pm2| |qm2| |pm1| |qm1| |fr|
                     $)
                    (QREFELT $ 85))))) 

(SDEFUN |CONTFRAC;iGenConvergents|
        ((|pm2| (R)) (|qm2| (R)) (|pm1| (R)) (|qm1| (R))
         (|fr| (|Stream| (|Record| (|:| |num| R) (|:| |den| R))))
         ($ (|Stream| (|Fraction| R))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|CONTFRAC;iGenConvergents!0|
                       (VECTOR |qm1| |qm2| |pm1| |pm2| $ |fr|))
                 (QREFELT $ 94))))) 

(SDEFUN |CONTFRAC;iGenConvergents!0| (($$ NIL))
        (PROG (|fr| $ |pm2| |pm1| |qm2| |qm1|)
          (LETT |fr| (QREFELT $$ 5))
          (LETT $ (QREFELT $$ 4))
          (LETT |pm2| (QREFELT $$ 3))
          (LETT |pm1| (QREFELT $$ 2))
          (LETT |qm2| (QREFELT $$ 1))
          (LETT |qm1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|nd| NIL) (|pm| NIL) (|qm| NIL))
                   (SEQ (LETT |nd| (SPADCALL |fr| (QREFELT $ 32)))
                        (LETT |pm|
                              (SPADCALL
                               (SPADCALL (QCAR |nd|) |pm2| (QREFELT $ 23))
                               (SPADCALL (QCDR |nd|) |pm1| (QREFELT $ 23))
                               (QREFELT $ 93)))
                        (LETT |qm|
                              (SPADCALL
                               (SPADCALL (QCAR |nd|) |qm2| (QREFELT $ 23))
                               (SPADCALL (QCDR |nd|) |qm1| (QREFELT $ 23))
                               (QREFELT $ 93)))
                        (EXIT
                         (|CONTFRAC;genConvergents| |pm1| |qm1| |pm| |qm|
                          (SPADCALL |fr| (QREFELT $ 33)) $)))))))) 

(SDEFUN |CONTFRAC;genConvergents|
        ((|pm2| (R)) (|qm2| (R)) (|pm1| (R)) (|qm1| (R))
         (|fr| (|Stream| (|Record| (|:| |num| R) (|:| |den| R))))
         ($ (|Stream| (|Fraction| R))))
        (COND
         ((SPADCALL |fr| (QREFELT $ 31))
          (SPADCALL (SPADCALL |pm1| |qm1| (QREFELT $ 95))
                    (SPADCALL (QREFELT $ 84)) (QREFELT $ 85)))
         ('T
          (SPADCALL (SPADCALL |pm1| |qm1| (QREFELT $ 95))
                    (|CONTFRAC;iGenConvergents| |pm2| |qm2| |pm1| |qm1| |fr| $)
                    (QREFELT $ 85))))) 

(SDEFUN |CONTFRAC;genNumDen|
        ((|m2| (R)) (|m1| (R))
         (|fr| (|Stream| (|Record| (|:| |num| R) (|:| |den| R))))
         ($ (|Stream| R)))
        (SPROG NIL
               (COND
                ((SPADCALL |fr| (QREFELT $ 31))
                 (SPADCALL |m1| (SPADCALL (QREFELT $ 86)) (QREFELT $ 80)))
                ('T
                 (SPADCALL |m1|
                           (SPADCALL
                            (CONS #'|CONTFRAC;genNumDen!0|
                                  (VECTOR $ |fr| |m2| |m1|))
                            (QREFELT $ 96))
                           (QREFELT $ 80)))))) 

(SDEFUN |CONTFRAC;genNumDen!0| (($$ NIL))
        (PROG (|m1| |m2| |fr| $)
          (LETT |m1| (QREFELT $$ 3))
          (LETT |m2| (QREFELT $$ 2))
          (LETT |fr| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|CONTFRAC;genNumDen| |m1|
             (SPADCALL
              (SPADCALL |m2| (QCAR (SPADCALL |fr| (QREFELT $ 32)))
                        (QREFELT $ 23))
              (SPADCALL |m1| (QCDR (SPADCALL |fr| (QREFELT $ 32)))
                        (QREFELT $ 23))
              (QREFELT $ 93))
             (SPADCALL |fr| (QREFELT $ 33)) $))))) 

(SDEFUN |CONTFRAC;Zero;$;32| (($ ($)))
        (SPADCALL (|spadConstant| $ 26) (QREFELT $ 51))) 

(SDEFUN |CONTFRAC;One;$;33| (($ ($)))
        (SPADCALL (|spadConstant| $ 29) (QREFELT $ 51))) 

(SDEFUN |CONTFRAC;+;3$;34| ((|c| ($)) (|d| ($)) ($ ($)))
        (|CONTFRAC;genFromSequence|
         (SPADCALL (ELT $ 97) (SPADCALL |c| (QREFELT $ 18))
                   (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 99))
         $)) 

(SDEFUN |CONTFRAC;-;3$;35| ((|c| ($)) (|d| ($)) ($ ($)))
        (|CONTFRAC;genFromSequence|
         (SPADCALL (ELT $ 53) (SPADCALL |c| (QREFELT $ 18))
                   (SPADCALL (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 101))
                   (QREFELT $ 99))
         $)) 

(SDEFUN |CONTFRAC;-;2$;36| ((|c| ($)) ($ ($)))
        (|CONTFRAC;genFromSequence|
         (SPADCALL (ELT $ 72)
                   (SPADCALL (SPADCALL |c| (QREFELT $ 18)) (QREFELT $ 101))
                   (QREFELT $ 104))
         $)) 

(SDEFUN |CONTFRAC;*;3$;37| ((|c| ($)) (|d| ($)) ($ ($)))
        (|CONTFRAC;genFromSequence|
         (SPADCALL (ELT $ 106) (SPADCALL |c| (QREFELT $ 18))
                   (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 99))
         $)) 

(SDEFUN |CONTFRAC;*;R2$;38| ((|a| (R)) (|d| ($)) ($ ($)))
        (SPROG NIL
               (|CONTFRAC;genFromSequence|
                (SPADCALL (CONS #'|CONTFRAC;*;R2$;38!0| (VECTOR $ |a|))
                          (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 104))
                $))) 

(SDEFUN |CONTFRAC;*;R2$;38!0| ((|x| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |x| (QREFELT $ 108)))))) 

(SDEFUN |CONTFRAC;*;F2$;39| ((|q| (|Fraction| R)) (|d| ($)) ($ ($)))
        (SPROG NIL
               (|CONTFRAC;genFromSequence|
                (SPADCALL (CONS #'|CONTFRAC;*;F2$;39!0| (VECTOR $ |q|))
                          (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 104))
                $))) 

(SDEFUN |CONTFRAC;*;F2$;39!0| ((|x| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |q| |x| (QREFELT $ 106)))))) 

(SDEFUN |CONTFRAC;*;I2$;40| ((|n| (|Integer|)) (|d| ($)) ($ ($)))
        (SPROG NIL
               (|CONTFRAC;genFromSequence|
                (SPADCALL (CONS #'|CONTFRAC;*;I2$;40!0| (VECTOR $ |n|))
                          (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 104))
                $))) 

(SDEFUN |CONTFRAC;*;I2$;40!0| ((|x| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |x| (QREFELT $ 111)))))) 

(SDEFUN |CONTFRAC;/;3$;41| ((|c| ($)) (|d| ($)) ($ ($)))
        (|CONTFRAC;genFromSequence|
         (SPADCALL (ELT $ 113) (SPADCALL |c| (QREFELT $ 18))
                   (SPADCALL (SPADCALL |d| (QREFELT $ 18)) (QREFELT $ 101))
                   (QREFELT $ 99))
         $)) 

(SDEFUN |CONTFRAC;recip;$U;42| ((|c| ($)) ($ (|Union| $ "failed")))
        (COND
         ((SPADCALL |c| (|spadConstant| $ 25) (QREFELT $ 34))
          (CONS 1 "failed"))
         ('T
          (CONS 0
                (|CONTFRAC;genFromSequence|
                 (SPADCALL (CONS #'|CONTFRAC;recip;$U;42!0| $)
                           (SPADCALL (SPADCALL |c| (QREFELT $ 18))
                                     (QREFELT $ 101))
                           (QREFELT $ 104))
                 $))))) 

(SDEFUN |CONTFRAC;recip;$U;42!0| ((|x| NIL) ($ NIL))
        (SPADCALL (|spadConstant| $ 65) |x| (QREFELT $ 113))) 

(PUT '|CONTFRAC;showAll?| '|SPADreplace| '(XLAM NIL |$streamsShowAll|)) 

(SDEFUN |CONTFRAC;showAll?| (($ (|Boolean|))) |$streamsShowAll|) 

(SDEFUN |CONTFRAC;zagRec|
        ((|t| (|Record| (|:| |num| R) (|:| |den| R))) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (QCAR |t|) (QREFELT $ 118))
                  (SPADCALL (QCDR |t|) (QREFELT $ 118)) (QREFELT $ 119))) 

(SDEFUN |CONTFRAC;coerce;$Of;45| ((|c| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|e| (|OutputForm|)) (|l| (|List| (|OutputForm|)))
          (|fr| (|Stream| (|Record| (|:| |num| R) (|:| |den| R)))) (|n| NIL)
          (#1=#:G906 NIL) (|count| (|NonNegativeInteger|)) (|wh| (R)))
         (SEQ (LETT |wh| (QCAR (QCAR |c|))) (LETT |fr| (QCDR (QCAR |c|)))
              (EXIT
               (COND
                ((SPADCALL |fr| (QREFELT $ 31))
                 (SPADCALL |wh| (QREFELT $ 118)))
                (#2='T
                 (SEQ (LETT |count| |$streamCount|) (LETT |l| NIL)
                      (SEQ (LETT |n| 1) (LETT #1# |count|) G190
                           (COND
                            ((OR (|greater_SI| |n| #1#)
                                 (NULL (NULL (SPADCALL |fr| (QREFELT $ 31)))))
                             (GO G191)))
                           (SEQ
                            (LETT |l|
                                  (CONS
                                   (|CONTFRAC;zagRec|
                                    (SPADCALL |fr| (QREFELT $ 32)) $)
                                   |l|))
                            (EXIT (LETT |fr| (SPADCALL |fr| (QREFELT $ 33)))))
                           (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                      (COND
                       ((|CONTFRAC;showAll?| $)
                        (SEQ (LETT |n| (+ |count| 1)) G190
                             (COND
                              ((NULL (SPADCALL |fr| (QREFELT $ 120)))
                               (GO G191)))
                             (SEQ
                              (LETT |l|
                                    (CONS
                                     (|CONTFRAC;zagRec|
                                      (SPADCALL |fr| (QREFELT $ 32)) $)
                                     |l|))
                              (EXIT
                               (LETT |fr| (SPADCALL |fr| (QREFELT $ 33)))))
                             (LETT |n| (+ |n| 1)) (GO G190) G191 (EXIT NIL))))
                      (COND
                       ((NULL (SPADCALL |fr| (QREFELT $ 121)))
                        (LETT |l|
                              (CONS (SPADCALL '|...| (QREFELT $ 123)) |l|))))
                      (LETT |l| (NREVERSE |l|))
                      (LETT |e| (SPADCALL (ELT $ 124) |l| (QREFELT $ 127)))
                      (EXIT
                       (COND ((SPADCALL |wh| (QREFELT $ 55)) |e|)
                             (#2#
                              (SPADCALL (SPADCALL |wh| (QREFELT $ 118)) |e|
                                        (QREFELT $ 124)))))))))))) 

(DECLAIM (NOTINLINE |ContinuedFraction;|)) 

(DEFUN |ContinuedFraction| (#1=#:G928)
  (SPROG NIL
         (PROG (#2=#:G929)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ContinuedFraction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|ContinuedFraction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ContinuedFraction|)))))))))) 

(DEFUN |ContinuedFraction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ContinuedFraction| DV$1))
          (LETT $ (GETREFV 144))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ContinuedFraction| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record|
                     (|:| |value|
                          (|Record| (|:| |whole| |#1|)
                                    (|:| |fract|
                                         (|Stream|
                                          (|Record| (|:| |num| |#1|)
                                                    (|:| |den| |#1|))))))
                     (|:| |reduced?| (|Boolean|))))
          (COND
           ((COND
             ((|HasCategory| |#1| '(|OrderedRing|))
              (|HasCategory| |#1| '(|multiplicativeValuation|)))
             ('T NIL))
            (PROGN
             (QSETREFV $ 37
                       (CONS
                        (|dispatchFunction|
                         |CONTFRAC;continuedFraction;R2S$;6|)
                        $))))
           ('T
            (PROGN
             (QSETREFV $ 37
                       (CONS
                        (|dispatchFunction|
                         |CONTFRAC;continuedFraction;R2S$;8|)
                        $)))))
          $))) 

(MAKEPROP '|ContinuedFraction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|)
              (|Record| (|:| |num| 6) (|:| |den| 6)) (|Stream| 9)
              (0 . |explicitlyFinite?|) (|Stream| 15)
              |CONTFRAC;convergents;$S;22| (5 . |complete|) (|Fraction| 6)
              (10 . |last|) |CONTFRAC;continuedFraction;F$;5|
              |CONTFRAC;approximants;$S;21| |CONTFRAC;reducedForm;2$;1|
              (15 . |numer|) (20 . |denom|) (25 . |quo|) (31 . *) (37 . -)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CONTFRAC;Zero;$;32|) $))
              (43 . |Zero|) (47 . <)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |CONTFRAC;One;$;33|) $))
              (53 . |One|) (57 . ~=) (63 . |empty?|) (68 . |frst|) (73 . |rst|)
              |CONTFRAC;=;2$B;4| |CONTFRAC;coerce;F$;13| (|Stream| 6)
              (78 . |continuedFraction|) (85 . |empty?|) (90 . |empty|)
              (94 . |frst|) (99 . |rst|) (|Mapping| $) (104 . |delay|)
              (109 . |concat|) (|List| 6) (115 . |repeating|)
              |CONTFRAC;reducedContinuedFraction;RS$;10| (|Integer|)
              (120 . |coerce|) |CONTFRAC;coerce;I$;11| |CONTFRAC;coerce;R$;12|
              (125 . |coerce|) (130 . -) (136 . |zero?|) (141 . |zero?|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (146 . |divide|) (|List| 9) (152 . |construct|)
              (|NonNegativeInteger|) (157 . |characteristic|)
              |CONTFRAC;characteristic;Nni;14| (161 . |first|) (166 . |rst|)
              (171 . |One|) (175 . |Zero|) (|MoebiusTransform| 15)
              (179 . |moebius|) (187 . =) (193 . |eval|) (199 . |recip|)
              (204 . -) (209 . |shift|) |CONTFRAC;wholePart;$R;17|
              (|Mapping| 6 9) (|StreamFunctions2| 9 6) (215 . |map|)
              |CONTFRAC;partialNumerators;$S;18|
              |CONTFRAC;partialDenominators;$S;19| (221 . |concat|)
              |CONTFRAC;partialQuotients;$S;20| (|List| 15) (227 . |repeating|)
              (232 . |empty|) (236 . |concat|) (242 . |empty|)
              |CONTFRAC;numerators;$S;23| |CONTFRAC;denominators;$S;24|
              (246 . |extend|) |CONTFRAC;extend;$I$;25| (252 . |complete|)
              |CONTFRAC;complete;2$;26| (257 . +) (263 . |delay|) (268 . /)
              (274 . |delay|) (279 . +) (|Mapping| 15 15 15) (285 . |map|)
              |CONTFRAC;+;3$;34| (292 . |rest|) |CONTFRAC;-;3$;35|
              (|Mapping| 15 15) (297 . |map|) |CONTFRAC;-;2$;36| (303 . *)
              |CONTFRAC;*;3$;37| (309 . *) |CONTFRAC;*;R2$;38|
              |CONTFRAC;*;F2$;39| (315 . *) |CONTFRAC;*;I2$;40| (321 . /)
              |CONTFRAC;/;3$;41| (|Union| $ '"failed") |CONTFRAC;recip;$U;42|
              (|OutputForm|) (327 . |coerce|) (332 . |zag|)
              (338 . |explicitEntries?|) (343 . |explicitlyEmpty?|) (|Symbol|)
              (348 . |coerce|) (353 . +) (|Mapping| 117 117 117) (|List| 117)
              (359 . |reduce|) |CONTFRAC;coerce;$Of;45|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |coef| 131) (|:| |generator| $))
              (|Union| 131 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 136 '"failed") (|Factored| $) (|Fraction| 48)
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 365 |zero?| 371 |wholePart| 376 |unitNormal| 381
              |unitCanonical| 386 |unit?| 391 |subtractIfCan| 396
              |squareFreePart| 402 |squareFree| 407 |sizeLess?| 412 |sample|
              418 |rightRecip| 422 |rightPower| 427 |rem| 439 |reducedForm| 445
              |reducedContinuedFraction| 450 |recip| 456 |quo| 461
              |principalIdeal| 467 |prime?| 472 |partialQuotients| 477
              |partialNumerators| 482 |partialDenominators| 487 |opposite?| 492
              |one?| 498 |numerators| 503 |multiEuclidean| 508 |leftRecip| 514
              |leftPower| 519 |lcmCoef| 531 |lcm| 537 |latex| 548 |inv| 553
              |hashUpdate!| 558 |hash| 564 |gcdPolynomial| 569 |gcd| 575
              |factor| 586 |extendedEuclidean| 591 |extend| 604 |exquo| 610
              |expressIdealMember| 616 |euclideanSize| 622 |divide| 627
              |denominators| 633 |convergents| 638 |continuedFraction| 643
              |complete| 655 |commutator| 660 |coerce| 666 |characteristic| 696
              |associator| 700 |associates?| 707 |approximants| 713
              |antiCommutator| 718 |annihilate?| 724 ^ 730 |Zero| 748 |One| 752
              = 756 / 762 - 768 + 779 * 785)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|Field&| |EuclideanDomain&| |UniqueFactorizationDomain&| NIL
                |GcdDomain&| NIL |DivisionRing&| NIL NIL |Algebra&| |Algebra&|
                |EntireRing&| |Algebra&| |Algebra&| NIL |Rng&| NIL |Module&|
                |Module&| |Module&| |Module&| NIL NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| NIL |SetCategory&| NIL NIL NIL NIL
                NIL |BasicType&| NIL)
             (CONS
              '#((|Field|) (|EuclideanDomain|) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|GcdDomain|) (|IntegralDomain|)
                 (|DivisionRing|) (|LeftOreRing|) (|CommutativeRing|)
                 (|Algebra| 6) (|Algebra| 139) (|EntireRing|) (|Algebra| $$)
                 (|Algebra| (|Fraction| 6)) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| 139) (|Module| $$) (|Module| (|Fraction| 6))
                 (|Module| 6) (|SemiRng|) (|BiModule| 139 139)
                 (|BiModule| $$ $$) (|BiModule| (|Fraction| 6) (|Fraction| 6))
                 (|BiModule| 6 6) (|NonAssociativeRing|) (|RightModule| 139)
                 (|LeftModule| 139) (|LeftModule| $$)
                 (|RightModule| (|Fraction| 6)) (|LeftModule| (|Fraction| 6))
                 (|RightModule| 6) (|LeftModule| 6) (|NonAssociativeRng|)
                 (|RightModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|CommutativeStar|) (|SetCategory|) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 117))
              (|makeByteWordVec2| 143
                                  '(1 10 8 0 11 1 12 0 0 14 1 12 15 0 16 1 15 6
                                    0 20 1 15 6 0 21 2 6 0 0 0 22 2 6 0 0 0 23
                                    2 6 0 0 0 24 0 6 0 26 2 6 8 0 0 27 0 6 0 29
                                    2 6 8 0 0 30 1 10 8 0 31 1 10 9 0 32 1 10 0
                                    0 33 3 0 0 6 36 36 37 1 36 8 0 38 0 10 0 39
                                    1 36 6 0 40 1 36 0 0 41 1 10 0 42 43 2 10 0
                                    9 0 44 1 36 0 45 46 1 6 0 48 49 1 15 0 6 52
                                    2 15 0 0 0 53 1 15 8 0 54 1 6 8 0 55 2 6 56
                                    0 0 57 1 10 0 58 59 0 15 60 61 1 12 15 0 63
                                    1 12 0 0 64 0 15 0 65 0 15 0 66 4 67 0 15
                                    15 15 15 68 2 15 8 0 0 69 2 67 15 0 15 70 1
                                    67 0 0 71 1 15 0 0 72 2 67 0 0 15 73 2 76
                                    36 75 10 77 2 36 0 6 0 80 1 12 0 82 83 0 12
                                    0 84 2 12 0 15 0 85 0 36 0 86 2 10 0 0 48
                                    89 1 10 0 0 91 2 6 0 0 0 93 1 12 0 42 94 2
                                    15 0 6 6 95 1 36 0 42 96 2 15 0 0 0 97 3 12
                                    0 98 0 0 99 1 12 0 0 101 2 12 0 103 0 104 2
                                    15 0 0 0 106 2 15 0 6 0 108 2 15 0 48 0 111
                                    2 15 0 0 0 113 1 6 117 0 118 2 117 0 0 0
                                    119 1 10 8 0 120 1 10 8 0 121 1 122 117 0
                                    123 2 117 0 0 0 124 2 126 117 125 0 127 2 0
                                    8 0 0 1 1 0 8 0 1 1 0 6 0 74 1 0 129 0 1 1
                                    0 0 0 1 1 0 8 0 1 2 0 115 0 0 1 1 0 0 0 1 1
                                    0 138 0 1 2 0 8 0 0 1 0 0 0 1 1 0 115 0 1 2
                                    0 0 0 60 1 2 0 0 0 140 1 2 0 0 0 0 1 1 0 0
                                    0 19 2 0 0 6 36 47 1 0 115 0 116 2 0 0 0 0
                                    1 1 0 133 131 1 1 0 8 0 1 1 0 36 0 81 1 0
                                    36 0 78 1 0 36 0 79 2 0 8 0 0 1 1 0 8 0 1 1
                                    0 36 0 87 2 0 134 131 0 1 1 0 115 0 1 2 0 0
                                    0 60 1 2 0 0 0 140 1 2 0 130 0 0 1 2 0 0 0
                                    0 1 1 0 0 131 1 1 0 141 0 1 1 0 0 0 1 2 0
                                    143 143 0 1 1 0 142 0 1 2 0 132 132 132 1 1
                                    0 0 131 1 2 0 0 0 0 1 1 0 138 0 1 2 0 135 0
                                    0 1 3 0 137 0 0 0 1 2 0 0 0 48 90 2 0 115 0
                                    0 1 2 0 134 131 0 1 1 0 60 0 1 2 0 56 0 0 1
                                    1 0 36 0 88 1 0 12 0 13 3 0 0 6 36 36 37 1
                                    0 0 15 17 1 0 0 0 92 2 0 0 0 0 1 1 0 0 0 1
                                    1 0 0 139 1 1 0 0 15 35 1 0 0 6 51 1 0 0 48
                                    50 1 0 117 0 128 0 0 60 62 3 0 0 0 0 0 1 2
                                    0 8 0 0 1 1 0 12 0 18 2 0 0 0 0 1 2 0 8 0 0
                                    1 2 0 0 0 48 1 2 0 0 0 60 1 2 0 0 0 140 1 0
                                    0 0 25 0 0 0 28 2 0 8 0 0 34 2 0 0 0 0 114
                                    2 0 0 0 0 102 1 0 0 0 105 2 0 0 0 0 100 2 0
                                    0 0 139 1 2 0 0 139 0 1 2 0 0 15 0 110 2 0
                                    0 0 15 1 2 0 0 6 0 109 2 0 0 0 6 1 2 0 0 60
                                    0 1 2 0 0 48 0 112 2 0 0 0 0 107 2 0 0 140
                                    0 1)))))
           '|lookupComplete|)) 
