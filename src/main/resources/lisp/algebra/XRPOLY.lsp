
(SDEFUN |XRPOLY;=;2$B;1| ((|p1| ($)) (|p2| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |p1| 0)
          (COND
           ((QEQCAR |p2| 0) (SPADCALL (QCDR |p1|) (QCDR |p2|) (QREFELT $ 10)))
           (#1='T NIL)))
         ((QEQCAR |p2| 0) NIL)
         (#1#
          (COND
           ((SPADCALL (QCAR (QCDR |p1|)) (QCAR (QCDR |p2|)) (QREFELT $ 10))
            (SPADCALL (QCDR (QCDR |p1|)) (QCDR (QCDR |p2|)) (QREFELT $ 12)))
           (#1# NIL))))) 

(SDEFUN |XRPOLY;monom0| ((|w| (|FreeMonoid| |VarSet|)) (|r| (R)) ($ ($)))
        (COND
         ((SPADCALL |r| (QCDR (|spadConstant| $ 14)) (QREFELT $ 10))
          (|spadConstant| $ 14))
         ((SPADCALL |w| (QREFELT $ 17)) (CONS 0 |r|))
         ('T
          (CONS 1
                (CONS (QCDR (|spadConstant| $ 14))
                      (SPADCALL
                       (|XRPOLY;monom0| (SPADCALL |w| (QREFELT $ 18)) |r| $)
                       (SPADCALL |w| (QREFELT $ 19)) (QREFELT $ 20))))))) 

(SDEFUN |XRPOLY;monomial;RFm$;3|
        ((|r| (R)) (|w| (|FreeMonoid| |VarSet|)) ($ ($)))
        (|XRPOLY;monom0| (SPADCALL |w| (QREFELT $ 21)) |r| $)) 

(SDEFUN |XRPOLY;coeff0| ((|p| ($)) (|w| (|FreeMonoid| |VarSet|)) ($ (R)))
        (COND
         ((SPADCALL |w| (|spadConstant| $ 23) (QREFELT $ 24))
          (COND ((QEQCAR |p| 0) (QCDR |p|)) (#1='T (QCAR (QCDR |p|)))))
         ((QEQCAR |p| 0) (QCDR (|spadConstant| $ 14)))
         (#1#
          (|XRPOLY;coeff0|
           (SPADCALL (QCDR (QCDR |p|)) (SPADCALL |w| (QREFELT $ 19))
                     (QREFELT $ 25))
           (SPADCALL |w| (QREFELT $ 18)) $)))) 

(SDEFUN |XRPOLY;coefficient;$FmR;5|
        ((|p| ($)) (|w| (|FreeMonoid| |VarSet|)) ($ (R)))
        (|XRPOLY;coeff0| |p| (SPADCALL |w| (QREFELT $ 21)) $)) 

(SDEFUN |XRPOLY;construct;L$;6|
        ((|lt|
          (|List| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R))))
         ($ ($)))
        (SPADCALL (SPADCALL |lt| (QREFELT $ 30)) (QREFELT $ 31))) 

(SDEFUN |XRPOLY;constructOrdered;L$;7|
        ((|lt|
          (|List| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R))))
         ($ ($)))
        (SPADCALL (SPADCALL |lt| (QREFELT $ 33)) (QREFELT $ 31))) 

(SDEFUN |XRPOLY;listOfTerms;$L;8|
        ((|p| ($))
         ($ (|List| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R)))))
        (SPADCALL (SPADCALL |p| (QREFELT $ 35)) (QREFELT $ 36))) 

(SDEFUN |XRPOLY;reductum;2$;9| ((|p| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 35)) (QREFELT $ 38))
                  (QREFELT $ 31))) 

(SDEFUN |XRPOLY;linearExtend;M$R;10|
        ((|f| (|Mapping| R (|FreeMonoid| |VarSet|))) (|p| ($)) ($ (R)))
        (SPADCALL |f| (SPADCALL |p| (QREFELT $ 35)) (QREFELT $ 41))) 

(SDEFUN |XRPOLY;numberOfMonomials;$Nni;11|
        ((|p| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G761 NIL) (#2=#:G760 #3=(|NonNegativeInteger|)) (#4=#:G762 #3#)
          (#5=#:G765 NIL) (|t| NIL) (|res| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((QEQCAR |p| 0)
            (COND
             ((SPADCALL (CONS 0 (QCDR |p|)) (|spadConstant| $ 14)
                        (QREFELT $ 13))
              0)
             (#6='T 1)))
           (#6#
            (SEQ
             (LETT |res|
                   (COND
                    ((SPADCALL (CONS 0 (QCAR (QCDR |p|))) (|spadConstant| $ 14)
                               (QREFELT $ 13))
                     0)
                    (#6# 1)))
             (EXIT
              (+ |res|
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |t| NIL)
                       (LETT #5# (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                       G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |t| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# (SPADCALL (QCDR |t|) (QREFELT $ 47)))
                          (COND (#1# (LETT #2# (+ #2# #4#)))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#6# 0))))))))))) 

(SDEFUN |XRPOLY;lquo;3$;12| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG
         ((|x| (|FreeModule| $ |VarSet|)) (|a| ($)) (#1=#:G776 NIL) (|t| NIL)
          (#2=#:G775 NIL))
         (SEQ
          (COND ((QEQCAR |p2| 0) (SPADCALL (QCDR |p2|) |p1| (QREFELT $ 48)))
                ((QEQCAR |p1| 0)
                 (SPADCALL (CONS 0 (QCAR (QCDR |p2|))) |p1| (QREFELT $ 49)))
                ('T
                 (SEQ
                  (LETT |x|
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |t| NIL)
                               (LETT #1#
                                     (SPADCALL (QCDR (QCDR |p1|))
                                               (QREFELT $ 45)))
                               G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |t| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (LETT |a|
                                          (SPADCALL (QCDR |t|) |p2|
                                                    (QREFELT $ 50)))
                                    (|spadConstant| $ 14) (QREFELT $ 51))
                                   (LETT #2#
                                         (CONS (CONS (QCAR |t|) |a|) #2#))))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 52)))
                  (EXIT
                   (|XRPOLY;simplifie|
                    (CONS (SPADCALL |p2| |p1| (QREFELT $ 53)) |x|) $)))))))) 

(SDEFUN |XRPOLY;trunc;$Nni$;13|
        ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|x| (|FreeModule| $ |VarSet|))
          (|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))) (|r| ($))
          (#1=#:G787 NIL) (|t| NIL) (#2=#:G786 NIL)
          (|n1| (|NonNegativeInteger|)) (#3=#:G780 NIL))
         (SEQ
          (COND
           ((OR (EQL |n| 0) (QEQCAR |p| 0))
            (CONS 0 (SPADCALL |p| (QREFELT $ 54))))
           ('T
            (SEQ
             (LETT |n1|
                   (PROG1 (LETT #3# (- |n| 1))
                     (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #3#)))
             (LETT |lt|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |t| NIL)
                         (LETT #1# (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL
                              (LETT |r|
                                    (SPADCALL (QCDR |t|) |n1| (QREFELT $ 57)))
                              (|spadConstant| $ 14) (QREFELT $ 51))
                             (LETT #2# (CONS (CONS (QCAR |t|) |r|) #2#))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#)))))
             (LETT |x| (SPADCALL |lt| (QREFELT $ 52)))
             (EXIT
              (|XRPOLY;simplifie| (CONS (SPADCALL |p| (QREFELT $ 54)) |x|)
               $)))))))) 

(SDEFUN |XRPOLY;unexpand;Xdp$;14|
        ((|p| (|XDistributedPolynomial| |VarSet| R)) ($ ($)))
        (SPROG
         ((|x| (|FreeModule| $ |VarSet|))
          (|r| (|XDistributedPolynomial| |VarSet| R)) (#1=#:G798 NIL) (|v| NIL)
          (#2=#:G797 NIL) (|vl| (|List| |VarSet|)))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 58))
            (CONS 0 (SPADCALL |p| (QREFELT $ 59))))
           ('T
            (SEQ
             (LETT |vl|
                   (SPADCALL (ELT $ 60) (SPADCALL |p| (QREFELT $ 62))
                             (QREFELT $ 64)))
             (LETT |x|
                   (SPADCALL
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |v| NIL) (LETT #1# |vl|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL
                               (LETT |r| (SPADCALL |p| |v| (QREFELT $ 65)))
                               (|spadConstant| $ 66) (QREFELT $ 67))
                              (LETT #2#
                                    (CONS
                                     (CONS |v| (SPADCALL |r| (QREFELT $ 31)))
                                     #2#))))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 52)))
             (EXIT (CONS 1 (CONS (SPADCALL |p| (QREFELT $ 59)) |x|))))))))) 

(SDEFUN |XRPOLY;sh;$Nni$;15| ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $))))
          (#1=#:G809 NIL) (|t| NIL) (#2=#:G808 NIL) (|p1| ($))
          (|n1| (|NonNegativeInteger|)) (#3=#:G802 NIL))
         (SEQ
          (COND ((EQL |n| 0) (|spadConstant| $ 55))
                ((QEQCAR |p| 0)
                 (SPADCALL (CONS 0 (QCDR |p|)) |n| (QREFELT $ 68)))
                ('T
                 (SEQ
                  (LETT |n1|
                        (PROG1 (LETT #3# (- |n| 1))
                          (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #3#)))
                  (LETT |p1|
                        (SPADCALL |n| (SPADCALL |p| |n1| (QREFELT $ 69))
                                  (QREFELT $ 70)))
                  (LETT |lt|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |t| NIL)
                              (LETT #1#
                                    (SPADCALL (QCDR (QCDR |p|))
                                              (QREFELT $ 45)))
                              G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |t| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (CONS (QCAR |t|)
                                             (SPADCALL (QCDR |t|) |p1|
                                                       (QREFELT $ 71)))
                                       #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (EXIT
                   (|XRPOLY;simplifie|
                    (CONS
                     (QCDR
                      (SPADCALL (CONS 0 (QCAR (QCDR |p|))) |n| (QREFELT $ 68)))
                     (SPADCALL |lt| (QREFELT $ 52)))
                    $)))))))) 

(SDEFUN |XRPOLY;sh;3$;16| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG
         ((|y| #1=(|FreeModule| $ |VarSet|)) (#2=#:G820 NIL) (|t| NIL)
          (#3=#:G819 NIL) (|x| #1#) (#4=#:G818 NIL) (#5=#:G817 NIL)
          (|lt2| #6=(|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $))))
          (|lt1| #6#))
         (SEQ
          (COND ((QEQCAR |p1| 0) (SPADCALL (QCDR |p1|) |p2| (QREFELT $ 48)))
                ((QEQCAR |p2| 0) (SPADCALL |p1| (QCDR |p2|) (QREFELT $ 72)))
                ('T
                 (SEQ (LETT |lt1| (SPADCALL (QCDR (QCDR |p1|)) (QREFELT $ 45)))
                      (LETT |lt2| (SPADCALL (QCDR (QCDR |p2|)) (QREFELT $ 45)))
                      (LETT |x|
                            (SPADCALL
                             (PROGN
                              (LETT #5# NIL)
                              (SEQ (LETT |t| NIL) (LETT #4# |lt1|) G190
                                   (COND
                                    ((OR (ATOM #4#)
                                         (PROGN (LETT |t| (CAR #4#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #5#
                                           (CONS
                                            (CONS (QCAR |t|)
                                                  (SPADCALL (QCDR |t|) |p2|
                                                            (QREFELT $ 71)))
                                            #5#))))
                                   (LETT #4# (CDR #4#)) (GO G190) G191
                                   (EXIT (NREVERSE #5#))))
                             (QREFELT $ 52)))
                      (LETT |y|
                            (SPADCALL
                             (PROGN
                              (LETT #3# NIL)
                              (SEQ (LETT |t| NIL) (LETT #2# |lt2|) G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |t| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #3#
                                           (CONS
                                            (CONS (QCAR |t|)
                                                  (SPADCALL |p1| (QCDR |t|)
                                                            (QREFELT $ 71)))
                                            #3#))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT (NREVERSE #3#))))
                             (QREFELT $ 52)))
                      (EXIT
                       (|XRPOLY;simplifie|
                        (CONS
                         (QCDR
                          (SPADCALL (CONS 0 (QCAR (QCDR |p1|)))
                                    (CONS 0 (QCAR (QCDR |p2|)))
                                    (QREFELT $ 49)))
                         (SPADCALL |x| |y| (QREFELT $ 73)))
                        $)))))))) 

(SDEFUN |XRPOLY;RemainderList;$L;17|
        ((|p| ($)) ($ (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
        (COND ((QEQCAR |p| 0) NIL)
              ('T (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45))))) 

(SDEFUN |XRPOLY;rquo;3$;18| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (COND ((QEQCAR |p2| 0) (SPADCALL |p1| |p2| (QREFELT $ 49)))
              ((QEQCAR |p1| 0)
               (CONS 0
                     (SPADCALL (QCDR |p1|) (QCAR (QCDR |p2|)) (QREFELT $ 77))))
              ('T
               (SPADCALL
                (SPADCALL |p1| (CONS 0 (QCAR (QCDR |p2|))) (QREFELT $ 49))
                (|XRPOLY;rquo1| (SPADCALL (QCDR (QCDR |p1|)) (QREFELT $ 45))
                 (SPADCALL (QCDR (QCDR |p2|)) (QREFELT $ 45)) $)
                (QREFELT $ 78))))) 

(SDEFUN |XRPOLY;rquo1|
        ((|x| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $))))
         (|y| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))) ($ ($)))
        (SPROG ((|y1| #1=(|Record| (|:| |k| |VarSet|) (|:| |c| $))) (|x1| #1#))
               (SEQ
                (COND ((OR (NULL |x|) (NULL |y|)) (|spadConstant| $ 14))
                      ('T
                       (SEQ (LETT |x1| (SPADCALL |x| (QREFELT $ 80)))
                            (LETT |y1| (SPADCALL |y| (QREFELT $ 80)))
                            (EXIT
                             (COND
                              ((SPADCALL (QCAR |x1|) (QCAR |y1|)
                                         (QREFELT $ 81))
                               (|XRPOLY;rquo1| |x| (CDR |y|) $))
                              ((SPADCALL (QCAR |x1|) (QCAR |y1|)
                                         (QREFELT $ 82))
                               (SPADCALL
                                (SPADCALL (QCDR |x1|) (QCDR |y1|)
                                          (QREFELT $ 79))
                                (|XRPOLY;rquo1| (CDR |x|) (CDR |y|) $)
                                (QREFELT $ 78)))
                              ('T (|XRPOLY;rquo1| (CDR |x|) |y| $)))))))))) 

(SDEFUN |XRPOLY;coef;2$R;20| ((|p1| ($)) (|p2| ($)) ($ (R)))
        (COND
         ((QEQCAR |p1| 0)
          (QCDR
           (SPADCALL (QCDR |p1|) (CONS 0 (SPADCALL |p2| (QREFELT $ 54)))
                     (QREFELT $ 48))))
         ((QEQCAR |p2| 0)
          (QCDR
           (SPADCALL (CONS 0 (QCAR (QCDR |p1|))) (CONS 0 (QCDR |p2|))
                     (QREFELT $ 49))))
         ('T
          (SPADCALL
           (QCDR
            (SPADCALL (CONS 0 (QCAR (QCDR |p1|))) (CONS 0 (QCAR (QCDR |p2|)))
                      (QREFELT $ 49)))
           (|XRPOLY;coef1| (SPADCALL (QCDR (QCDR |p1|)) (QREFELT $ 45))
            (SPADCALL (QCDR (QCDR |p2|)) (QREFELT $ 45)) $)
           (QREFELT $ 83))))) 

(SDEFUN |XRPOLY;coef1|
        ((|x| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $))))
         (|y| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))) ($ (R)))
        (SPROG ((#1=#:G857 NIL))
               (SEQ
                (EXIT
                 (COND ((OR (NULL |x|) (NULL |y|)) (|spadConstant| $ 15))
                       ((SPADCALL (QCAR (SPADCALL |x| '|first| (QREFELT $ 85)))
                                  (QCAR (SPADCALL |y| '|first| (QREFELT $ 85)))
                                  (QREFELT $ 81))
                        (|XRPOLY;coef1| |x| (CDR |y|) $))
                       ((SPADCALL (QCAR (SPADCALL |x| '|first| (QREFELT $ 85)))
                                  (QCAR (SPADCALL |y| '|first| (QREFELT $ 85)))
                                  (QREFELT $ 82))
                        (QCDR
                         (SPADCALL
                          (CONS 0
                                (SPADCALL
                                 (QCDR (SPADCALL |x| '|first| (QREFELT $ 85)))
                                 (QCDR (SPADCALL |y| '|first| (QREFELT $ 85)))
                                 (QREFELT $ 53)))
                          (CONS 0 (|XRPOLY;coef1| (CDR |x|) (CDR |y|) $))
                          (QREFELT $ 78))))
                       ('T
                        (PROGN
                         (LETT #1# (|XRPOLY;coef1| (CDR |x|) |y| $))
                         (GO #2=#:G856)))))
                #2# (EXIT #1#)))) 

(SDEFUN |XRPOLY;outForm| ((|p| (|FreeModule| $ |VarSet|)) ($ (|OutputForm|)))
        (SPROG
         ((|le| (|List| (|OutputForm|))) (#1=#:G866 NIL) (|t| NIL)
          (#2=#:G865 NIL))
         (SEQ
          (LETT |le|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 45)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL (QCDR |t|) (QREFELT $ 87))
                                         (SPADCALL (QCAR |t|) (QREFELT $ 88))
                                         (QREFELT $ 89))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL (ELT $ 90) (NREVERSE |le|) (QREFELT $ 93)))))) 

(SDEFUN |XRPOLY;coerce;$Of;23| ((|p| ($)) ($ (|OutputForm|)))
        (COND ((QEQCAR |p| 0) (SPADCALL (QCDR |p|) (QREFELT $ 94)))
              ((SPADCALL (CONS 0 (QCAR (QCDR |p|))) (|spadConstant| $ 14)
                         (QREFELT $ 13))
               (|XRPOLY;outForm| (QCDR (QCDR |p|)) $))
              ('T
               (SPADCALL (SPADCALL (QCAR (QCDR |p|)) (QREFELT $ 94))
                         (|XRPOLY;outForm| (QCDR (QCDR |p|)) $)
                         (QREFELT $ 90))))) 

(SDEFUN |XRPOLY;Zero;$;24| (($ ($))) (CONS 0 (|spadConstant| $ 15))) 

(SDEFUN |XRPOLY;One;$;25| (($ ($))) (CONS 0 (|spadConstant| $ 56))) 

(PUT '|XRPOLY;constant?;$B;26| '|SPADreplace| '(XLAM (|p|) (QEQCAR |p| 0))) 

(SDEFUN |XRPOLY;constant?;$B;26| ((|p| ($)) ($ (|Boolean|))) (QEQCAR |p| 0)) 

(SDEFUN |XRPOLY;constant;$R;27| ((|p| ($)) ($ (R)))
        (COND ((QEQCAR |p| 0) (QCDR |p|)) ('T (QCAR (QCDR |p|))))) 

(SDEFUN |XRPOLY;retractIfCan;$U;28| ((|p| ($)) ($ (|Union| R "failed")))
        (COND ((QEQCAR |p| 0) (CONS 0 (QCDR |p|))) ('T (CONS 1 "failed")))) 

(SDEFUN |XRPOLY;retractIfCan;$U;29|
        ((|p| ($)) ($ (|Union| (|FreeMonoid| |VarSet|) "failed")))
        (SPROG
         ((|ru| (|Union| (|FreeMonoid| |VarSet|) "failed"))
          (|t1| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))
          (|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
         (SEQ
          (COND
           ((QEQCAR |p| 0)
            (COND
             ((SPADCALL (CONS 0 (QCDR |p|)) (|spadConstant| $ 55)
                        (QREFELT $ 51))
              (CONS 1 "failed"))
             (#1='T (CONS 0 (|spadConstant| $ 23)))))
           ((SPADCALL (CONS 0 (QCAR (QCDR |p|))) (|spadConstant| $ 14)
                      (QREFELT $ 51))
            (CONS 1 "failed"))
           (#1#
            (SEQ (LETT |lt| (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                 (COND ((NULL (NULL (CDR |lt|))) (EXIT (CONS 1 "failed"))))
                 (LETT |t1| (SPADCALL |lt| (QREFELT $ 80)))
                 (LETT |ru| (SPADCALL (QCDR |t1|) (QREFELT $ 99)))
                 (EXIT
                  (COND ((QEQCAR |ru| 1) (CONS 1 "failed"))
                        (#1#
                         (CONS 0
                               (SPADCALL (QCDR |ru|) (QCAR |t1|)
                                         (QREFELT $ 100)))))))))))) 

(SDEFUN |XRPOLY;monomial?;$B;30| ((|p| ($)) ($ (|Boolean|)))
        (SPROG ((|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
               (SEQ
                (COND ((QEQCAR |p| 0) 'T)
                      ((SPADCALL (CONS 0 (QCAR (QCDR |p|)))
                                 (|spadConstant| $ 14) (QREFELT $ 51))
                       NIL)
                      ('T
                       (SEQ
                        (LETT |lt| (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                        (COND ((NULL (NULL (CDR |lt|))) (EXIT NIL)))
                        (EXIT
                         (SPADCALL (QCDR (SPADCALL |lt| (QREFELT $ 80)))
                                   (QREFELT $ 101))))))))) 

(SDEFUN |XRPOLY;simplifie|
        ((|p| (|Record| (|:| |c0| R) (|:| |reg| (|FreeModule| $ |VarSet|))))
         ($ ($)))
        (COND
         ((SPADCALL (QCDR |p|) (|spadConstant| $ 102) (QREFELT $ 12))
          (CONS 0 (QCAR |p|)))
         ('T (CONS 1 |p|)))) 

(SDEFUN |XRPOLY;coerce;VarSet$;32| ((|v| (|VarSet|)) ($ ($)))
        (CONS 1
              (CONS (|spadConstant| $ 15)
                    (SPADCALL (|spadConstant| $ 55) |v| (QREFELT $ 20))))) 

(PUT '|XRPOLY;coerce;R$;33| '|SPADreplace| '(XLAM (|r|) (CONS 0 |r|))) 

(SDEFUN |XRPOLY;coerce;R$;33| ((|r| (R)) ($ ($))) (CONS 0 |r|)) 

(SDEFUN |XRPOLY;coerce;I$;34| ((|n| (|Integer|)) ($ ($)))
        (CONS 0 (SPADCALL |n| (QREFELT $ 106)))) 

(SDEFUN |XRPOLY;coerce;Fm$;35| ((|w| (|FreeMonoid| |VarSet|)) ($ ($)))
        (SPROG ((|res| ($)))
               (SEQ (LETT |res| (|spadConstant| $ 55))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |w| (|spadConstant| $ 23)
                                      (QREFELT $ 108)))
                           (GO G191)))
                         (SEQ
                          (LETT |res|
                                (CONS 1
                                      (CONS (QCDR (|spadConstant| $ 14))
                                            (SPADCALL |res|
                                                      (SPADCALL |w|
                                                                (QREFELT $ 19))
                                                      (QREFELT $ 20)))))
                          (EXIT (LETT |w| (SPADCALL |w| (QREFELT $ 18)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |XRPOLY;expand;$Xdp;36|
        ((|p| ($)) ($ (|XDistributedPolynomial| |VarSet| R)))
        (SPROG
         ((|ep| (|XDistributedPolynomial| |VarSet| R)) (#1=#:G918 NIL)
          (|t| NIL) (|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
         (SEQ
          (COND ((QEQCAR |p| 0) (SPADCALL (QCDR |p|) (QREFELT $ 110)))
                ('T
                 (SEQ (LETT |lt| (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                      (LETT |ep| (SPADCALL (QCAR (QCDR |p|)) (QREFELT $ 110)))
                      (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |ep|
                                   (SPADCALL |ep|
                                             (SPADCALL
                                              (SPADCALL (QCDR |t|)
                                                        (QREFELT $ 35))
                                              (SPADCALL
                                               (QCDR (|spadConstant| $ 55))
                                               (SPADCALL (QCAR |t|)
                                                         (QREFELT $ 111))
                                               (QREFELT $ 112))
                                              (QREFELT $ 113))
                                             (QREFELT $ 114)))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |ep|))))))) 

(SDEFUN |XRPOLY;mirror;2$;37| ((|p| ($)) ($ ($)))
        (SPROG
         ((#1=#:G926 NIL) (#2=#:G925 ($)) (#3=#:G927 ($)) (#4=#:G932 NIL)
          (#5=#:G689 NIL) (|lt1| (|List| $)) (#6=#:G931 NIL) (|t| NIL)
          (#7=#:G930 NIL)
          (|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
         (SEQ
          (COND ((QEQCAR |p| 0) |p|)
                (#8='T
                 (SEQ (LETT |lt| (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                      (LETT |lt1|
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT |t| NIL) (LETT #6# |lt|) G190
                                  (COND
                                   ((OR (ATOM #6#)
                                        (PROGN (LETT |t| (CAR #6#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #7#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL (QCAR |t|)
                                                      (QREFELT $ 103))
                                            (SPADCALL (QCDR |t|)
                                                      (QREFELT $ 115))
                                            (QREFELT $ 49))
                                           #7#))))
                                  (LETT #6# (CDR #6#)) (GO G190) G191
                                  (EXIT (NREVERSE #7#)))))
                      (EXIT
                       (SPADCALL (CONS 0 (QCAR (QCDR |p|)))
                                 (PROGN
                                  (LETT #1# NIL)
                                  (SEQ (LETT #5# NIL) (LETT #4# |lt1|) G190
                                       (COND
                                        ((OR (ATOM #4#)
                                             (PROGN (LETT #5# (CAR #4#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (PROGN
                                          (LETT #3# #5#)
                                          (COND
                                           (#1#
                                            (LETT #2#
                                                  (SPADCALL #2# #3#
                                                            (QREFELT $ 78))))
                                           ('T
                                            (PROGN
                                             (LETT #2# #3#)
                                             (LETT #1# 'T)))))))
                                       (LETT #4# (CDR #4#)) (GO G190) G191
                                       (EXIT NIL))
                                  (COND (#1# #2#) (#8# (|spadConstant| $ 14))))
                                 (QREFELT $ 78))))))))) 

(SDEFUN |XRPOLY;-;2$;38| ((|p| ($)) ($ ($)))
        (COND ((QEQCAR |p| 0) (CONS 0 (SPADCALL (QCDR |p|) (QREFELT $ 116))))
              ('T
               (CONS 1
                     (CONS
                      (QCDR
                       (SPADCALL (CONS 0 (QCAR (QCDR |p|))) (QREFELT $ 117)))
                      (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 118))))))) 

(SDEFUN |XRPOLY;+;3$;39| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SEQ
         (COND
          ((QEQCAR |p1| 0)
           (COND
            ((QEQCAR |p2| 0)
             (EXIT
              (CONS 0 (SPADCALL (QCDR |p1|) (QCDR |p2|) (QREFELT $ 83))))))))
         (EXIT
          (COND
           ((QEQCAR |p1| 0)
            (CONS 1
                  (CONS
                   (SPADCALL (QCDR |p1|) (QCAR (QCDR |p2|)) (QREFELT $ 83))
                   (QCDR (QCDR |p2|)))))
           ((QEQCAR |p2| 0)
            (CONS 1
                  (CONS
                   (SPADCALL (QCDR |p2|) (QCAR (QCDR |p1|)) (QREFELT $ 83))
                   (QCDR (QCDR |p1|)))))
           ('T
            (|XRPOLY;simplifie|
             (CONS
              (QCDR
               (SPADCALL (CONS 0 (QCAR (QCDR |p1|)))
                         (CONS 0 (QCAR (QCDR |p2|))) (QREFELT $ 78)))
              (SPADCALL (QCDR (QCDR |p1|)) (QCDR (QCDR |p2|)) (QREFELT $ 73)))
             $)))))) 

(SDEFUN |XRPOLY;-;3$;40| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SEQ
         (COND
          ((QEQCAR |p1| 0)
           (COND
            ((QEQCAR |p2| 0)
             (EXIT
              (CONS 0 (SPADCALL (QCDR |p1|) (QCDR |p2|) (QREFELT $ 119))))))))
         (EXIT
          (COND
           ((QEQCAR |p1| 0)
            (CONS 1
                  (CONS
                   (SPADCALL (QCDR |p1|) (QCAR (QCDR |p2|)) (QREFELT $ 119))
                   (SPADCALL (QCDR (QCDR |p2|)) (QREFELT $ 118)))))
           ((QEQCAR |p2| 0)
            (CONS 1
                  (CONS
                   (QCDR
                    (SPADCALL (CONS 0 (QCAR (QCDR |p1|))) |p2|
                              (QREFELT $ 120)))
                   (QCDR (QCDR |p1|)))))
           ('T
            (|XRPOLY;simplifie|
             (CONS
              (QCDR
               (SPADCALL (CONS 0 (QCAR (QCDR |p1|)))
                         (CONS 0 (QCAR (QCDR |p2|))) (QREFELT $ 120)))
              (SPADCALL (QCDR (QCDR |p1|)) (QCDR (QCDR |p2|)) (QREFELT $ 121)))
             $)))))) 

(SDEFUN |XRPOLY;*;I2$;41| ((|n| (|Integer|)) (|p| ($)) ($ ($)))
        (COND ((EQL |n| 0) (|spadConstant| $ 14))
              ((QEQCAR |p| 0)
               (CONS 0 (SPADCALL |n| (QCDR |p|) (QREFELT $ 122))))
              ('T
               (|XRPOLY;simplifie|
                (CONS
                 (QCDR
                  (SPADCALL |n| (CONS 0 (QCAR (QCDR |p|))) (QREFELT $ 123)))
                 (SPADCALL |n| (QCDR (QCDR |p|)) (QREFELT $ 124)))
                $)))) 

(SDEFUN |XRPOLY;*;R2$;42| ((|r| (R)) (|p| ($)) ($ ($)))
        (COND
         ((SPADCALL |r| (QCDR (|spadConstant| $ 14)) (QREFELT $ 10))
          (|spadConstant| $ 14))
         ((QEQCAR |p| 0) (CONS 0 (SPADCALL |r| (QCDR |p|) (QREFELT $ 77))))
         ('T
          (|XRPOLY;simplifie|
           (CONS
            (QCDR (SPADCALL |r| (CONS 0 (QCAR (QCDR |p|))) (QREFELT $ 48)))
            (SPADCALL (CONS 0 |r|) (QCDR (QCDR |p|)) (QREFELT $ 125)))
           $)))) 

(SDEFUN |XRPOLY;*;$R$;43| ((|p| ($)) (|r| (R)) ($ ($)))
        (COND
         ((SPADCALL |r| (QCDR (|spadConstant| $ 14)) (QREFELT $ 10))
          (|spadConstant| $ 14))
         ((QEQCAR |p| 0) (CONS 0 (SPADCALL (QCDR |p|) |r| (QREFELT $ 77))))
         ('T
          (|XRPOLY;simplifie|
           (CONS
            (QCDR
             (SPADCALL (CONS 0 (QCAR (QCDR |p|))) (CONS 0 |r|) (QREFELT $ 49)))
            (SPADCALL (QCDR (QCDR |p|)) (CONS 0 |r|) (QREFELT $ 126)))
           $)))) 

(SDEFUN |XRPOLY;*;VarSet2$;44| ((|v| (|VarSet|)) (|p| ($)) ($ ($)))
        (SPADCALL (SPADCALL |v| (QREFELT $ 103)) |p| (QREFELT $ 49))) 

(SDEFUN |XRPOLY;*;3$;45| ((|p1| ($)) (|p2| ($)) ($ ($)))
        (SPROG
         ((|y| (|FreeModule| $ |VarSet|)) (|x| (|FreeModule| $ |VarSet|)))
         (SEQ
          (COND ((QEQCAR |p1| 0) (SPADCALL (QCDR |p1|) |p2| (QREFELT $ 48)))
                ((QEQCAR |p2| 0) (SPADCALL |p1| (QCDR |p2|) (QREFELT $ 72)))
                ('T
                 (SEQ
                  (LETT |x| (SPADCALL |p1| (QCDR (QCDR |p2|)) (QREFELT $ 125)))
                  (LETT |y|
                        (SPADCALL (QCDR (QCDR |p1|))
                                  (CONS 0 (QCAR (QCDR |p2|))) (QREFELT $ 126)))
                  (EXIT
                   (|XRPOLY;simplifie|
                    (CONS
                     (QCDR
                      (SPADCALL (CONS 0 (QCAR (QCDR |p1|)))
                                (CONS 0 (QCAR (QCDR |p2|))) (QREFELT $ 49)))
                     (SPADCALL |x| |y| (QREFELT $ 73)))
                    $)))))))) 

(SDEFUN |XRPOLY;rquo;$VarSet$;46| ((|p| ($)) (|v| (|VarSet|)) ($ ($)))
        (COND ((QEQCAR |p| 0) (|spadConstant| $ 14))
              ('T (SPADCALL (QCDR (QCDR |p|)) |v| (QREFELT $ 25))))) 

(SDEFUN |XRPOLY;rquo;$Fm$;47| ((|p| ($)) (|w| (|FreeMonoid| |VarSet|)) ($ ($)))
        (COND ((SPADCALL |w| (|spadConstant| $ 23) (QREFELT $ 24)) |p|)
              ('T
               (SPADCALL
                (SPADCALL |p| (SPADCALL |w| (QREFELT $ 18)) (QREFELT $ 129))
                (SPADCALL |w| (QREFELT $ 19)) (QREFELT $ 128))))) 

(SDEFUN |XRPOLY;lquo;$VarSet$;48| ((|p| ($)) (|v| (|VarSet|)) ($ ($)))
        (SPROG
         ((|x| (|FreeModule| $ |VarSet|)) (|a| ($)) (#1=#:G962 NIL) (|t| NIL)
          (#2=#:G961 NIL))
         (SEQ
          (COND ((QEQCAR |p| 0) (|spadConstant| $ 14))
                ('T
                 (SEQ
                  (LETT |x|
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |t| NIL)
                               (LETT #1#
                                     (SPADCALL (QCDR (QCDR |p|))
                                               (QREFELT $ 45)))
                               G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |t| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (LETT |a|
                                          (SPADCALL (QCDR |t|) |v|
                                                    (QREFELT $ 130)))
                                    (|spadConstant| $ 14) (QREFELT $ 51))
                                   (LETT #2#
                                         (CONS (CONS (QCAR |t|) |a|) #2#))))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 52)))
                  (EXIT
                   (|XRPOLY;simplifie|
                    (CONS
                     (SPADCALL (SPADCALL (QCDR (QCDR |p|)) |v| (QREFELT $ 25))
                               (QREFELT $ 54))
                     |x|)
                    $)))))))) 

(SDEFUN |XRPOLY;lquo;$Fm$;49| ((|p| ($)) (|w| (|FreeMonoid| |VarSet|)) ($ ($)))
        (COND ((SPADCALL |w| (|spadConstant| $ 23) (QREFELT $ 24)) |p|)
              ('T
               (SPADCALL
                (SPADCALL |p| (SPADCALL |w| (QREFELT $ 19)) (QREFELT $ 130))
                (SPADCALL |w| (QREFELT $ 18)) (QREFELT $ 131))))) 

(SDEFUN |XRPOLY;coef;$FmR;50| ((|p| ($)) (|w| (|FreeMonoid| |VarSet|)) ($ (R)))
        (SPADCALL (SPADCALL |p| |w| (QREFELT $ 129)) (QREFELT $ 54))) 

(SDEFUN |XRPOLY;quasiRegular?;$B;51| ((|p| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |p| 0)
          (SPADCALL |p| (CONS 0 (|spadConstant| $ 15)) (QREFELT $ 13)))
         ('T
          (SPADCALL (CONS 0 (QCAR (QCDR |p|))) (CONS 0 (|spadConstant| $ 15))
                    (QREFELT $ 13))))) 

(SDEFUN |XRPOLY;quasiRegular;2$;52| ((|p| ($)) ($ ($)))
        (COND ((QEQCAR |p| 0) (|spadConstant| $ 14))
              ('T (CONS 1 (CONS (|spadConstant| $ 15) (QCDR (QCDR |p|))))))) 

(SDEFUN |XRPOLY;characteristic;Nni;53| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 135))) 

(SDEFUN |XRPOLY;recip;$U;54| ((|p| ($)) ($ (|Union| $ "failed")))
        (COND ((QEQCAR |p| 0) (SPADCALL (CONS 0 (QCDR |p|)) (QREFELT $ 138)))
              ('T (CONS 1 "failed")))) 

(SDEFUN |XRPOLY;leftRecip;$U;55| ((|p| ($)) ($ (|Union| $ "failed")))
        (COND ((QEQCAR |p| 0) (SPADCALL (CONS 0 (QCDR |p|)) (QREFELT $ 139)))
              ('T (CONS 1 "failed")))) 

(SDEFUN |XRPOLY;rightRecip;$U;56| ((|p| ($)) ($ (|Union| $ "failed")))
        (COND ((QEQCAR |p| 0) (SPADCALL (CONS 0 (QCDR |p|)) (QREFELT $ 140)))
              ('T (CONS 1 "failed")))) 

(SDEFUN |XRPOLY;mindeg;$Fm;57| ((|p| ($)) ($ (|FreeMonoid| |VarSet|)))
        (SPROG
         ((#1=#:G986 NIL) (#2=#:G985 #3=(|FreeMonoid| |VarSet|))
          (#4=#:G987 #3#) (#5=#:G990 NIL) (|t| NIL))
         (SEQ
          (COND
           ((QEQCAR |p| 0)
            (COND
             ((SPADCALL |p| (|spadConstant| $ 14) (QREFELT $ 13))
              (|error| "XRPOLY.mindeg: zero polynomial !!"))
             (#6='T (|spadConstant| $ 23))))
           ((SPADCALL (CONS 0 (QCAR (QCDR |p|))) (|spadConstant| $ 14)
                      (QREFELT $ 51))
            (|spadConstant| $ 23))
           (#6#
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT |t| NIL)
                  (LETT #5# (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45))) G190
                  (COND
                   ((OR (ATOM #5#) (PROGN (LETT |t| (CAR #5#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (SPADCALL (SPADCALL (QCDR |t|) (QREFELT $ 141))
                                     (QCAR |t|) (QREFELT $ 100)))
                     (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 142))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                  (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) (#6# (|IdentityError| '|min|))))))))) 

(SDEFUN |XRPOLY;mindegTerm;$R;58|
        ((|p| ($))
         ($ #1=(|Record| (|:| |k| #2=(|FreeMonoid| |VarSet|)) (|:| |c| R))))
        (SPROG
         ((|rd| #2#)
          (|res| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R)))
          (#3=#:G1008 NIL) (|lm| (|List| #1#)) (|tp| (|FreeMonoid| |VarSet|))
          (|mt| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R)))
          (#4=#:G1007 NIL) (|t| NIL) (#5=#:G1006 NIL)
          (|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
         (SEQ
          (COND ((QEQCAR |p| 0) (CONS (|spadConstant| $ 23) (QCDR |p|)))
                ((SPADCALL (CONS 0 (QCAR (QCDR |p|))) (|spadConstant| $ 14)
                           (QREFELT $ 51))
                 (CONS (|spadConstant| $ 23) (QCAR (QCDR |p|))))
                ('T
                 (SEQ (LETT |lt| (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                      (LETT |lm|
                            (PROGN
                             (LETT #5# NIL)
                             (SEQ (LETT |t| NIL) (LETT #4# |lt|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |t| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SEQ
                                       (LETT |mt|
                                             (SPADCALL (QCDR |t|)
                                                       (QREFELT $ 143)))
                                       (LETT |tp|
                                             (SPADCALL (QCAR |mt|) (QCAR |t|)
                                                       (QREFELT $ 100)))
                                       (EXIT 'T))
                                      (LETT #5#
                                            (CONS (CONS |tp| (QCDR |mt|))
                                                  #5#))))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT (NREVERSE #5#)))))
                      (LETT |res| (|SPADfirst| |lm|)) (LETT |rd| (QCAR |res|))
                      (SEQ (LETT #3# (CDR |lm|)) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |mt| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (QCAR |mt|) |rd| (QREFELT $ 144))
                               (SEQ (LETT |res| |mt|)
                                    (EXIT (LETT |rd| (QCAR |res|))))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |res|))))))) 

(SDEFUN |XRPOLY;maxdeg;$Fm;59| ((|p| ($)) ($ (|FreeMonoid| |VarSet|)))
        (SPROG
         ((#1=#:G1014 NIL) (#2=#:G1013 #3=(|FreeMonoid| |VarSet|))
          (#4=#:G1015 #3#) (#5=#:G1017 NIL) (|t| NIL))
         (SEQ
          (COND
           ((QEQCAR |p| 0)
            (COND
             ((SPADCALL |p| (|spadConstant| $ 14) (QREFELT $ 13))
              (|error| "XRPOLY.maxdeg: zero polynomial !!"))
             (#6='T (|spadConstant| $ 23))))
           (#6#
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT |t| NIL)
                  (LETT #5# (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45))) G190
                  (COND
                   ((OR (ATOM #5#) (PROGN (LETT |t| (CAR #5#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (SPADCALL (SPADCALL (QCDR |t|) (QREFELT $ 145))
                                     (QCAR |t|) (QREFELT $ 100)))
                     (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 146))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                  (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) (#6# (|IdentityError| '|max|))))))))) 

(SDEFUN |XRPOLY;leadingTerm;$R;60|
        ((|p| ($))
         ($ #1=(|Record| (|:| |k| #2=(|FreeMonoid| |VarSet|)) (|:| |c| R))))
        (SPROG
         ((|rd| #2#)
          (|res| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R)))
          (#3=#:G1034 NIL) (|lm| (|List| #1#)) (|tp| (|FreeMonoid| |VarSet|))
          (|mt| (|Record| (|:| |k| (|FreeMonoid| |VarSet|)) (|:| |c| R)))
          (#4=#:G1033 NIL) (|t| NIL) (#5=#:G1032 NIL)
          (|lt| (|List| (|Record| (|:| |k| |VarSet|) (|:| |c| $)))))
         (SEQ
          (COND ((QEQCAR |p| 0) (CONS (|spadConstant| $ 23) (QCDR |p|)))
                ('T
                 (SEQ (LETT |lt| (SPADCALL (QCDR (QCDR |p|)) (QREFELT $ 45)))
                      (LETT |lm|
                            (PROGN
                             (LETT #5# NIL)
                             (SEQ (LETT |t| NIL) (LETT #4# |lt|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |t| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SEQ
                                       (LETT |mt|
                                             (SPADCALL (QCDR |t|)
                                                       (QREFELT $ 147)))
                                       (LETT |tp|
                                             (SPADCALL (QCAR |mt|) (QCAR |t|)
                                                       (QREFELT $ 100)))
                                       (EXIT 'T))
                                      (LETT #5#
                                            (CONS (CONS |tp| (QCDR |mt|))
                                                  #5#))))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT (NREVERSE #5#)))))
                      (LETT |res| (|SPADfirst| |lm|)) (LETT |rd| (QCAR |res|))
                      (SEQ (LETT #3# (CDR |lm|)) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |mt| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |rd| (QCAR |mt|) (QREFELT $ 144))
                               (SEQ (LETT |res| |mt|)
                                    (EXIT (LETT |rd| (QCAR |res|))))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |res|))))))) 

(SDEFUN |XRPOLY;degree;$Nni;61| ((|p| ($)) ($ (|NonNegativeInteger|)))
        (COND
         ((SPADCALL |p| (|spadConstant| $ 14) (QREFELT $ 13))
          (|error| "XRPOLY.degree: zero polynomial !!"))
         ('T (SPADCALL (SPADCALL |p| (QREFELT $ 145)) (QREFELT $ 148))))) 

(SDEFUN |XRPOLY;map;M2$;62| ((|fn| (|Mapping| R R)) (|p| ($)) ($ ($)))
        (SPROG
         ((|x| (|FreeModule| $ |VarSet|)) (|a| ($)) (#1=#:G1046 NIL) (|t| NIL)
          (#2=#:G1045 NIL))
         (SEQ
          (COND ((QEQCAR |p| 0) (CONS 0 (SPADCALL (QCDR |p|) |fn|)))
                ('T
                 (SEQ
                  (LETT |x|
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |t| NIL)
                               (LETT #1#
                                     (SPADCALL (QCDR (QCDR |p|))
                                               (QREFELT $ 45)))
                               G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |t| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (LETT |a|
                                          (SPADCALL |fn| (QCDR |t|)
                                                    (QREFELT $ 151)))
                                    (|spadConstant| $ 14) (QREFELT $ 51))
                                   (LETT #2#
                                         (CONS (CONS (QCAR |t|) |a|) #2#))))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 52)))
                  (EXIT
                   (|XRPOLY;simplifie|
                    (CONS (SPADCALL (QCAR (QCDR |p|)) |fn|) |x|) $)))))))) 

(SDEFUN |XRPOLY;varList;$L;63| ((|p| ($)) ($ (|List| |VarSet|)))
        (SPROG
         ((|lv| #1=(|List| |VarSet|)) (#2=#:G1060 NIL) (|t| NIL)
          (#3=#:G1059 NIL) (#4=#:G1052 NIL) (#5=#:G1051 #1#) (#6=#:G1053 #1#)
          (#7=#:G1058 NIL))
         (SEQ
          (COND ((QEQCAR |p| 0) NIL)
                (#8='T
                 (SEQ
                  (LETT |lv|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |t| NIL)
                              (LETT #7#
                                    (SPADCALL (QCDR (QCDR |p|))
                                              (QREFELT $ 45)))
                              G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |t| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #6#
                                       (SPADCALL (QCDR |t|) (QREFELT $ 152)))
                                 (COND
                                  (#4#
                                   (LETT #5#
                                         (SPADCALL #5# #6# (QREFELT $ 153))))
                                  ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                              (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                         (COND (#4# #5#) (#8# (|IdentityError| '|setUnion|)))))
                  (LETT |lv|
                        (SPADCALL |lv|
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT |t| NIL)
                                        (LETT #2#
                                              (SPADCALL (QCDR (QCDR |p|))
                                                        (QREFELT $ 45)))
                                        G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT |t| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #3# (CONS (QCAR |t|) #3#))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT (NREVERSE #3#))))
                                  (QREFELT $ 153)))
                  (EXIT (SPADCALL |lv| (QREFELT $ 154))))))))) 

(DECLAIM (NOTINLINE |XRecursivePolynomial;|)) 

(DEFUN |XRecursivePolynomial| (&REST #1=#:G1064)
  (SPROG NIL
         (PROG (#2=#:G1065)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|XRecursivePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |XRecursivePolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|XRecursivePolynomial|)))))))))) 

(DEFUN |XRecursivePolynomial;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G1063 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|XRecursivePolynomial| DV$1 DV$2))
    (LETT $ (GETREFV 162))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#2|
                                                       '(|noZeroDivisors|))
                                        (LETT #1#
                                              (|HasCategory|
                                               (|FreeMonoid| |#1|)
                                               '(|Comparable|)))
                                        (AND
                                         (|HasCategory| |#2| '(|Comparable|))
                                         #1#)))))
    (|haddProp| |$ConstructorCache| '|XRecursivePolynomial| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8
              (|Union| |#2|
                       (|Record| (|:| |c0| |#2|)
                                 (|:| |reg| (|FreeModule| $ |#1|)))))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 42
                (CONS (|dispatchFunction| |XRPOLY;linearExtend;M$R;10|) $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 69 (CONS (|dispatchFunction| |XRPOLY;sh;$Nni$;15|) $))
       (QSETREFV $ 71 (CONS (|dispatchFunction| |XRPOLY;sh;3$;16|) $)))))
    $))) 

(MAKEPROP '|XRecursivePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|Boolean|) (0 . =) (|FreeModule| $$ 6) (6 . =) |XRPOLY;=;2$B;1|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |XRPOLY;Zero;$;24|) $))
              (12 . |Zero|) (|FreeMonoid| 6) (16 . |one?|) (21 . |rest|)
              (26 . |first|) (31 . |monomial|) (37 . |mirror|)
              |XRPOLY;monomial;RFm$;3| (42 . |One|) (46 . =)
              (52 . |coefficient|) |XRPOLY;coefficient;$FmR;5|
              (|Record| (|:| |k| 16) (|:| |c| 7)) (|List| 27)
              (|XDistributedPolynomial| 6 7) (58 . |construct|)
              |XRPOLY;unexpand;Xdp$;14| |XRPOLY;construct;L$;6|
              (63 . |constructOrdered|) |XRPOLY;constructOrdered;L$;7|
              |XRPOLY;expand;$Xdp;36| (68 . |listOfTerms|)
              |XRPOLY;listOfTerms;$L;8| (73 . |reductum|)
              |XRPOLY;reductum;2$;9| (|Mapping| 7 16) (78 . |linearExtend|)
              (84 . |linearExtend|) (|Record| (|:| |k| 6) (|:| |c| $$))
              (|List| 43) (90 . |listOfTerms|) (|NonNegativeInteger|)
              |XRPOLY;numberOfMonomials;$Nni;11| |XRPOLY;*;R2$;42|
              |XRPOLY;*;3$;45| |XRPOLY;lquo;3$;12| (95 . ~=)
              (101 . |construct|) |XRPOLY;coef;2$R;20| |XRPOLY;constant;$R;27|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |XRPOLY;One;$;25|) $))
              (106 . |One|) |XRPOLY;trunc;$Nni$;13| (110 . |constant?|)
              (115 . |constant|) (120 . >) (|List| 6) (126 . |varList|)
              (|Mapping| 9 6 6) (131 . |sort|) (137 . |rquo|) (143 . |Zero|)
              (147 . ~=) (153 . ^) (159 . |sh|) (165 . *) (171 . |sh|)
              |XRPOLY;*;$R$;43| (177 . +) (|Record| (|:| |k| 6) (|:| |c| $))
              (|List| 74) |XRPOLY;RemainderList;$L;17| (183 . *)
              |XRPOLY;+;3$;39| |XRPOLY;rquo;3$;18| (189 . |first|) (194 . <)
              (200 . =) (206 . +) '"first" (212 . |elt|) (|OutputForm|)
              |XRPOLY;coerce;$Of;23| (218 . |coerce|) (223 . *) (229 . +)
              (|Mapping| 86 86 86) (|List| 86) (235 . |reduce|)
              (241 . |coerce|) |XRPOLY;constant?;$B;26| (|Union| 7 '"failed")
              |XRPOLY;retractIfCan;$U;28| (|Union| 16 '"failed")
              |XRPOLY;retractIfCan;$U;29| (246 . *) |XRPOLY;monomial?;$B;30|
              (252 . |Zero|) |XRPOLY;coerce;VarSet$;32| |XRPOLY;coerce;R$;33|
              (|Integer|) (256 . |coerce|) |XRPOLY;coerce;I$;34| (261 . ~=)
              |XRPOLY;coerce;Fm$;35| (267 . |coerce|) (272 . |coerce|)
              (277 . |monomial|) (283 . *) (289 . +) |XRPOLY;mirror;2$;37|
              (295 . -) |XRPOLY;-;2$;38| (300 . -) (305 . -) |XRPOLY;-;3$;40|
              (311 . -) (317 . *) |XRPOLY;*;I2$;41| (323 . *) (329 . *)
              (335 . *) |XRPOLY;*;VarSet2$;44| |XRPOLY;rquo;$VarSet$;46|
              |XRPOLY;rquo;$Fm$;47| |XRPOLY;lquo;$VarSet$;48|
              |XRPOLY;lquo;$Fm$;49| |XRPOLY;coef;$FmR;50|
              |XRPOLY;quasiRegular?;$B;51| |XRPOLY;quasiRegular;2$;52|
              (341 . |characteristic|) |XRPOLY;characteristic;Nni;53|
              (|Union| $ '"failed") |XRPOLY;recip;$U;54|
              |XRPOLY;leftRecip;$U;55| |XRPOLY;rightRecip;$U;56|
              |XRPOLY;mindeg;$Fm;57| (345 . |min|) |XRPOLY;mindegTerm;$R;58|
              (351 . <) |XRPOLY;maxdeg;$Fm;59| (357 . |max|)
              |XRPOLY;leadingTerm;$R;60| (363 . |length|)
              |XRPOLY;degree;$Nni;61| (|Mapping| 7 7) |XRPOLY;map;M2$;62|
              |XRPOLY;varList;$L;63| (368 . |setUnion|) (374 . |sort!|)
              (|List| 16) (|List| 7) (|List| $) (|PositiveInteger|) (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 379 |zero?| 385 |varList| 390 |unexpand| 395 |trunc| 400
              |support| 406 |subtractIfCan| 411 |smaller?| 417 |sh| 423
              |sample| 435 |rquo| 439 |rightRecip| 457 |rightPower| 462
              |retractIfCan| 474 |retract| 484 |reductum| 494 |recip| 499
              |quasiRegular?| 504 |quasiRegular| 509 |opposite?| 514 |one?| 520
              |numberOfMonomials| 525 |monomials| 530 |monomial?| 535
              |monomial| 540 |mirror| 546 |mindegTerm| 551 |mindeg| 556
              |maxdeg| 561 |map| 566 |lquo| 572 |listOfTerms| 590
              |linearExtend| 595 |leftRecip| 601 |leftPower| 606 |leadingTerm|
              618 |leadingSupport| 623 |leadingMonomial| 628
              |leadingCoefficient| 633 |latex| 638 |hashUpdate!| 643 |hash| 649
              |expand| 654 |degree| 659 |constructOrdered| 664 |construct| 669
              |constant?| 674 |constant| 679 |commutator| 684 |coerce| 690
              |coefficients| 715 |coefficient| 720 |coef| 726 |characteristic|
              738 |associator| 742 |antiCommutator| 749 |annihilate?| 755 ^ 761
              |Zero| 773 |RemainderList| 777 |One| 782 = 786 - 792 + 803 * 809)
           'NIL
           (CONS
            (|makeByteWordVec2| 4
                                '(0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 2))
            (CONS
             '#(NIL NIL NIL |Algebra&| NIL |Rng&| |FreeModuleCategory&| NIL NIL
                NIL |Module&| NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| NIL |RetractableTo&|
                |RetractableTo&| |SetCategory&| NIL NIL NIL |BasicType&| NIL
                NIL)
             (CONS
              '#((|XPolynomialsCat| 6 7) (|XFreeAlgebra| 6 7) (|XAlgebra| 7)
                 (|Algebra| 7) (|Ring|) (|Rng|)
                 (|FreeModuleCategory| 7 (|FreeMonoid| 6)) (|SemiRing|)
                 (|IndexedDirectProductCategory| 7 (|FreeMonoid| 6))
                 (|SemiRng|) (|Module| 7)
                 (|IndexedProductCategory| 7 (|FreeMonoid| 6)) (|BiModule| 7 7)
                 (|NonAssociativeRing|) (|BiModule| $$ $$)
                 (|AbelianProductCategory| 7) (|LeftModule| 7)
                 (|RightModule| 7) (|NonAssociativeRng|) (|RightModule| $$)
                 (|LeftModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|Comparable|) (|RetractableTo| (|FreeMonoid| 6))
                 (|RetractableTo| 7) (|SetCategory|)
                 (|CoercibleFrom| (|FreeMonoid| 6)) (|CoercibleFrom| 7)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 86)
                 (|noZeroDivisors|))
              (|makeByteWordVec2| 161
                                  '(2 7 9 0 0 10 2 11 9 0 0 12 0 7 0 15 1 16 9
                                    0 17 1 16 0 0 18 1 16 6 0 19 2 11 0 2 6 20
                                    1 16 0 0 21 0 16 0 23 2 16 9 0 0 24 2 11 2
                                    0 6 25 1 29 0 28 30 1 29 0 28 33 1 29 28 0
                                    36 1 29 0 0 38 2 29 7 40 0 41 2 0 7 40 0 42
                                    1 11 44 0 45 2 0 9 0 0 51 1 11 0 44 52 0 7
                                    0 56 1 29 9 0 58 1 29 7 0 59 2 6 9 0 0 60 1
                                    29 61 0 62 2 61 0 63 0 64 2 29 0 0 6 65 0
                                    29 0 66 2 29 9 0 0 67 2 0 0 0 46 68 2 0 0 0
                                    46 69 2 0 0 46 0 70 2 0 0 0 0 71 2 11 0 0 0
                                    73 2 7 0 0 0 77 1 44 43 0 80 2 6 9 0 0 81 2
                                    6 9 0 0 82 2 7 0 0 0 83 2 44 43 0 84 85 1 6
                                    86 0 88 2 86 0 0 0 89 2 86 0 0 0 90 2 92 86
                                    91 0 93 1 7 86 0 94 2 16 0 0 6 100 0 11 0
                                    102 1 7 0 105 106 2 16 9 0 0 108 1 29 0 7
                                    110 1 16 0 6 111 2 29 0 7 16 112 2 29 0 0 0
                                    113 2 29 0 0 0 114 1 7 0 0 116 1 11 0 0 118
                                    2 7 0 0 0 119 2 11 0 0 0 121 2 7 0 105 0
                                    122 2 11 0 105 0 124 2 11 0 2 0 125 2 11 0
                                    0 2 126 0 7 46 135 2 16 0 0 0 142 2 16 9 0
                                    0 144 2 16 0 0 0 146 1 16 46 0 148 2 61 0 0
                                    0 153 1 61 0 0 154 2 0 9 0 0 51 1 0 9 0 1 1
                                    0 61 0 152 1 0 0 29 31 2 0 0 0 46 57 1 0
                                    155 0 1 2 0 137 0 0 1 2 4 9 0 0 1 2 1 0 0
                                    46 69 2 1 0 0 0 71 0 0 0 1 2 0 0 0 0 79 2 0
                                    0 0 16 129 2 0 0 0 6 128 1 0 137 0 140 2 0
                                    0 0 46 1 2 0 0 0 158 1 1 0 98 0 99 1 0 96 0
                                    97 1 0 16 0 1 1 0 7 0 1 1 3 0 0 39 1 0 137
                                    0 138 1 0 9 0 133 1 0 0 0 134 2 0 9 0 0 1 1
                                    0 9 0 1 1 0 46 0 47 1 0 157 0 1 1 0 9 0 101
                                    2 0 0 7 16 22 1 0 0 0 115 1 0 27 0 143 1 0
                                    16 0 141 1 0 16 0 145 2 0 0 150 0 151 2 0 0
                                    0 0 50 2 0 0 0 16 131 2 0 0 0 6 130 1 0 28
                                    0 37 2 1 7 40 0 42 1 0 137 0 139 2 0 0 0 46
                                    1 2 0 0 0 158 1 1 3 27 0 147 1 3 16 0 1 1 3
                                    0 0 1 1 3 7 0 1 1 0 159 0 1 2 0 161 161 0 1
                                    1 0 160 0 1 1 0 29 0 35 1 0 46 0 149 1 3 0
                                    28 34 1 0 0 28 32 1 0 9 0 95 1 0 7 0 54 2 0
                                    0 0 0 1 1 0 0 6 103 1 0 0 16 109 1 0 0 7
                                    104 1 0 0 105 107 1 0 86 0 87 1 0 156 0 1 2
                                    0 7 0 16 26 2 0 7 0 0 53 2 0 7 0 16 132 0 0
                                    46 136 3 0 0 0 0 0 1 2 0 0 0 0 1 2 0 9 0 0
                                    1 2 0 0 0 46 68 2 0 0 0 158 1 0 0 0 14 1 0
                                    75 0 76 0 0 0 55 2 0 9 0 0 13 2 0 0 0 0 120
                                    1 0 0 0 117 2 0 0 0 0 78 2 0 0 6 0 127 2 0
                                    0 7 0 48 2 0 0 0 7 72 2 0 0 46 0 70 2 0 0
                                    105 0 123 2 0 0 0 0 49 2 0 0 158 0 1)))))
           '|lookupComplete|)) 
