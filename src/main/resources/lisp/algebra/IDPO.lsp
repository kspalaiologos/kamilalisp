
(SDEFUN |IDPO;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G774 NIL) (|t| NIL) (#2=#:G773 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |t| NIL) (LETT #1# |x|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL (QCAR |t|) (QREFELT $ 10))
                                          (SPADCALL (QCDR |t|) (QREFELT $ 11))
                                          (QREFELT $ 12))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 14))))) 

(PUT '|IDPO;listOfTerms;$L;2| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |IDPO;listOfTerms;$L;2|
        ((|x| ($)) ($ (|List| (|Record| (|:| |k| S) (|:| |c| A))))) |x|) 

(SDEFUN |IDPO;monomial?;$B;3| ((|x| ($)) ($ (|Boolean|)))
        (COND ((NULL |x|) NIL) ('T (NULL (CDR |x|))))) 

(PUT '|IDPO;numberOfMonomials;$Nni;4| '|SPADreplace| 'LENGTH) 

(SDEFUN |IDPO;numberOfMonomials;$Nni;4| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH |x|)) 

(SDEFUN |IDPO;monomial;AS$;5| ((|r| (A)) (|s| (S)) ($ ($)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 24) (QREFELT $ 25))
          (|spadConstant| $ 23))
         ('T (LIST (CONS |s| |r|))))) 

(SDEFUN |IDPO;map;M2$;6| ((|f| (|Mapping| A A)) (|x| ($)) ($ ($)))
        (SPROG ((|a| (A)) (#1=#:G795 NIL) (|tm| NIL) (#2=#:G794 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |tm| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |tm| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL
                           (SPADCALL (LETT |a| (SPADCALL (QCDR |tm|) |f|))
                                     (|spadConstant| $ 24) (QREFELT $ 25)))
                          (LETT #2# (CONS (CONS (QCAR |tm|) |a|) #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IDPO;monomial;AS$;7| ((|r| (A)) (|s| (S)) ($ ($)))
        (LIST (CONS |s| |r|))) 

(SDEFUN |IDPO;map;M2$;8| ((|f| (|Mapping| A A)) (|x| ($)) ($ ($)))
        (SPROG ((#1=#:G803 NIL) (|tm| NIL) (#2=#:G802 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |tm| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |tm| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (CONS (QCAR |tm|) (SPADCALL (QCDR |tm|) |f|))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IDPO;=;2$B;9| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G814 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ G190
                       (COND
                        ((NULL (COND ((NULL |x|) NIL) ('T (NULL (NULL |y|)))))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((OR
                            (SPADCALL (QCAR (|SPADfirst| |x|))
                                      (QCAR (|SPADfirst| |y|)) (QREFELT $ 29))
                            (SPADCALL (QCDR (|SPADfirst| |x|))
                                      (QCDR (|SPADfirst| |y|)) (QREFELT $ 30)))
                           (PROGN (LETT #1# NIL) (GO #2=#:G813)))
                          ('T
                           (SEQ (LETT |x| (CDR |x|))
                                (EXIT (LETT |y| (CDR |y|))))))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT (COND ((NULL |x|) (NULL |y|)) ('T NIL)))))
                #2# (EXIT #1#)))) 

(SDEFUN |IDPO;reductum;2$;10| ((|x| ($)) ($ ($)))
        (COND ((NULL |x|) (|spadConstant| $ 23)) ('T (CDR |x|)))) 

(SDEFUN |IDPO;leadingCoefficient;$A;11| ((|x| ($)) ($ (A)))
        (COND ((NULL |x|) (|spadConstant| $ 24)) ('T (QCDR (|SPADfirst| |x|))))) 

(SDEFUN |IDPO;smaller?;2$B;12| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G829 NIL))
               (SEQ
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL |y|)
                          (COND
                           ((NULL |x|) (PROGN (LETT #1# NIL) (GO #2=#:G828)))
                           ('T
                            (PROGN
                             (LETT #1#
                                   (SPADCALL (QCDR (|SPADfirst| |x|))
                                             (|spadConstant| $ 24)
                                             (QREFELT $ 34)))
                             (GO #2#)))))
                         ((NULL |x|)
                          (PROGN
                           (LETT #1#
                                 (SPADCALL (|spadConstant| $ 24)
                                           (QCDR (|SPADfirst| |y|))
                                           (QREFELT $ 34)))
                           (GO #2#)))
                         ((SPADCALL (QCAR (|SPADfirst| |x|))
                                    (QCAR (|SPADfirst| |y|)) (QREFELT $ 35))
                          (COND
                           ((SPADCALL (QCDR (|SPADfirst| |x|))
                                      (QCDR (|SPADfirst| |y|)) (QREFELT $ 25))
                            (SEQ (LETT |x| (CDR |x|))
                                 (EXIT (LETT |y| (CDR |y|)))))
                           ('T
                            (PROGN
                             (LETT #1#
                                   (SPADCALL (QCDR (|SPADfirst| |x|))
                                             (QCDR (|SPADfirst| |y|))
                                             (QREFELT $ 34)))
                             (GO #2#)))))
                         ((SPADCALL (QCAR (|SPADfirst| |x|))
                                    (QCAR (|SPADfirst| |y|)) (QREFELT $ 36))
                          (PROGN
                           (LETT #1#
                                 (SPADCALL (|spadConstant| $ 24)
                                           (QCDR (|SPADfirst| |y|))
                                           (QREFELT $ 34)))
                           (GO #2#)))
                         ('T
                          (PROGN
                           (LETT #1#
                                 (SPADCALL (QCDR (|SPADfirst| |x|))
                                           (|spadConstant| $ 24)
                                           (QREFELT $ 34)))
                           (GO #2#))))))
                      NIL (GO G190) G191 (EXIT NIL)))
                #2# (EXIT #1#)))) 

(PUT '|IDPO;reductum;2$;13| '|SPADreplace| 'CDR) 

(SDEFUN |IDPO;reductum;2$;13| ((|x| ($)) ($ ($))) (CDR |x|)) 

(SDEFUN |IDPO;leadingCoefficient;$A;14| ((|x| ($)) ($ (A)))
        (COND
         ((NULL |x|)
          (|error| "Can't take leadingCoefficient of empty product element"))
         ('T (QCDR (|SPADfirst| |x|))))) 

(SDEFUN |IDPO;smaller?;2$B;15| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G843 NIL))
               (SEQ
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL |y|)
                          (COND
                           ((OR (NULL |x|) 'T)
                            (PROGN (LETT #1# NIL) (GO #2=#:G842)))))
                         ((NULL |x|) (PROGN (LETT #1# 'T) (GO #2#)))
                         ((SPADCALL (QCAR (|SPADfirst| |x|))
                                    (QCAR (|SPADfirst| |y|)) (QREFELT $ 35))
                          (COND
                           ((SPADCALL (QCDR (|SPADfirst| |x|))
                                      (QCDR (|SPADfirst| |y|)) (QREFELT $ 25))
                            (SEQ (LETT |x| (CDR |x|))
                                 (EXIT (LETT |y| (CDR |y|)))))
                           ('T
                            (PROGN
                             (LETT #1#
                                   (SPADCALL (QCDR (|SPADfirst| |x|))
                                             (QCDR (|SPADfirst| |y|))
                                             (QREFELT $ 34)))
                             (GO #2#)))))
                         ((SPADCALL (QCAR (|SPADfirst| |x|))
                                    (QCAR (|SPADfirst| |y|)) (QREFELT $ 36))
                          (PROGN (LETT #1# 'T) (GO #2#)))
                         ('T (PROGN (LETT #1# NIL) (GO #2#))))))
                      NIL (GO G190) G191 (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |IDPO;leadingSupport;$S;16| ((|x| ($)) ($ (S)))
        (COND
         ((NULL |x|)
          (|error| "Can't take leadingCoefficient of empty product element"))
         ('T (QCAR (|SPADfirst| |x|))))) 

(SDEFUN |IDPO;leadingMonomial;2$;17| ((|x| ($)) ($ ($)))
        (SPADCALL (QCDR (|SPADfirst| |x|)) (QCAR (|SPADfirst| |x|))
                  (QREFELT $ 26))) 

(SDEFUN |IDPO;compareterm|
        ((|a| (|Record| (|:| |k| S) (|:| |c| A)))
         (|b| (|Record| (|:| |k| S) (|:| |c| A))) ($ (|Boolean|)))
        (SPADCALL (QCAR |b|) (QCAR |a|) (QREFELT $ 36))) 

(SDEFUN |IDPO;construct;L$;19|
        ((|lx| (|List| (|Record| (|:| |k| S) (|:| |c| A)))) ($ ($)))
        (SPADCALL (CONS (|function| |IDPO;compareterm|) $) |lx| (QREFELT $ 41))) 

(PUT '|IDPO;constructOrdered;L$;20| '|SPADreplace| '(XLAM (|lx|) |lx|)) 

(SDEFUN |IDPO;constructOrdered;L$;20|
        ((|lx| (|List| (|Record| (|:| |k| S) (|:| |c| A)))) ($ ($))) |lx|) 

(SDEFUN |IDPO;leadingTerm;$R;21|
        ((|x| ($)) ($ (|Record| (|:| |k| S) (|:| |c| A))))
        (COND
         ((NULL |x|)
          (|error| "Can't take leadingCoefficient of empty product element"))
         ('T (|SPADfirst| |x|)))) 

(SDEFUN |IDPO;hashUpdate!;Hs$Hs;22|
        ((|s| (|HashState|)) (|x| ($)) ($ (|HashState|)))
        (SPROG ((#1=#:G859 NIL) (|t| NIL) (|xl| (|Rep|)))
               (SEQ (LETT |xl| |x|)
                    (SEQ (LETT |t| NIL) (LETT #1# |xl|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |s| (SPADCALL |s| (QCAR |t|) (QREFELT $ 46)))
                          (EXIT
                           (LETT |s|
                                 (SPADCALL |s| (QCDR |t|) (QREFELT $ 47)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |s|)))) 

(PUT '|IDPO;Zero;$;23| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |IDPO;Zero;$;23| (($ ($))) NIL) 

(PUT '|IDPO;zero?;$B;24| '|SPADreplace| 'NULL) 

(SDEFUN |IDPO;zero?;$B;24| ((|x| ($)) ($ (|Boolean|))) (NULL |x|)) 

(SDEFUN |IDPO;add_gen| ((|x| (|Rep|)) (|y| (|Rep|)) ($ (|Rep|)))
        (SPROG
         ((|res| (|Rep|)) (|end| (|Rep|)) (|endcell| (|Rep|))
          (|newcell| (|Rep|)) (|r| (A)))
         (SEQ
          (COND ((NULL |x|) |y|) ((NULL |y|) |x|)
                (#1='T
                 (SEQ (LETT |endcell| NIL) (LETT |res| NIL)
                      (SEQ G190
                           (COND
                            ((NULL
                              (COND ((NULL |x|) NIL) ('T (NULL (NULL |y|)))))
                             (GO G191)))
                           (SEQ (LETT |newcell| NIL)
                                (COND
                                 ((SPADCALL (QCAR (|SPADfirst| |x|))
                                            (QCAR (|SPADfirst| |y|))
                                            (QREFELT $ 35))
                                  (SEQ
                                   (LETT |r|
                                         (SPADCALL (QCDR (|SPADfirst| |x|))
                                                   (QCDR (|SPADfirst| |y|))
                                                   (QREFELT $ 50)))
                                   (COND
                                    ((NULL (SPADCALL |r| (QREFELT $ 51)))
                                     (LETT |newcell|
                                           (CONS
                                            (CONS (QCAR (|SPADfirst| |x|)) |r|)
                                            NIL))))
                                   (LETT |x| (CDR |x|))
                                   (EXIT (LETT |y| (CDR |y|)))))
                                 ((SPADCALL (QCAR (|SPADfirst| |y|))
                                            (QCAR (|SPADfirst| |x|))
                                            (QREFELT $ 36))
                                  (SEQ
                                   (LETT |newcell|
                                         (CONS (|SPADfirst| |x|) NIL))
                                   (EXIT (LETT |x| (CDR |x|)))))
                                 ('T
                                  (SEQ
                                   (LETT |newcell|
                                         (CONS (|SPADfirst| |y|) NIL))
                                   (EXIT (LETT |y| (CDR |y|))))))
                                (EXIT
                                 (COND
                                  ((NULL (NULL |newcell|))
                                   (COND
                                    ((NULL |endcell|)
                                     (SEQ (LETT |res| |newcell|)
                                          (EXIT (LETT |endcell| |res|))))
                                    ('T
                                     (SEQ (RPLACD |endcell| |newcell|)
                                          (EXIT
                                           (LETT |endcell| |newcell|)))))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (COND ((NULL |x|) (LETT |end| |y|))
                            (#1# (LETT |end| |x|)))
                      (COND ((NULL |res|) (LETT |res| |end|))
                            (#1# (RPLACD |endcell| |end|)))
                      (EXIT |res|))))))) 

(SDEFUN |IDPO;add_si|
        ((|x| (|List| (|Record| (|:| |k| (|SingleInteger|)) (|:| |c| A))))
         (|y| #1=(|List| (|Record| (|:| |k| (|SingleInteger|)) (|:| |c| A))))
         ($ (|List| (|Record| (|:| |k| (|SingleInteger|)) (|:| |c| A)))))
        (SPROG
         ((|res|
           #2=(|List| (|Record| (|:| |k| (|SingleInteger|)) (|:| |c| A))))
          (|end| #1#) (|endcell| #2#) (|newcell| #2#) (|r| (A)))
         (SEQ (LETT |endcell| NIL) (LETT |res| NIL)
              (SEQ G190
                   (COND
                    ((NULL (COND ((NULL |x|) NIL) ('T (NULL (NULL |y|)))))
                     (GO G191)))
                   (SEQ (LETT |newcell| NIL)
                        (COND
                         ((|eql_SI| (QCAR (|SPADfirst| |x|))
                                    (QCAR (|SPADfirst| |y|)))
                          (SEQ
                           (LETT |r|
                                 (SPADCALL (QCDR (|SPADfirst| |x|))
                                           (QCDR (|SPADfirst| |y|))
                                           (QREFELT $ 50)))
                           (COND
                            ((NULL (SPADCALL |r| (QREFELT $ 51)))
                             (LETT |newcell|
                                   (CONS (CONS (QCAR (|SPADfirst| |x|)) |r|)
                                         NIL))))
                           (LETT |x| (CDR |x|)) (EXIT (LETT |y| (CDR |y|)))))
                         ((SPADCALL (QCAR (|SPADfirst| |y|))
                                    (QCAR (|SPADfirst| |x|)) (QREFELT $ 53))
                          (SEQ (LETT |newcell| (CONS (|SPADfirst| |x|) NIL))
                               (EXIT (LETT |x| (CDR |x|)))))
                         ('T
                          (SEQ (LETT |newcell| (CONS (|SPADfirst| |y|) NIL))
                               (EXIT (LETT |y| (CDR |y|))))))
                        (EXIT
                         (COND
                          ((NULL (NULL |newcell|))
                           (COND
                            ((NULL |endcell|)
                             (SEQ (LETT |res| |newcell|)
                                  (EXIT (LETT |endcell| |res|))))
                            ('T
                             (SEQ (RPLACD |endcell| |newcell|)
                                  (EXIT (LETT |endcell| |newcell|)))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND ((NULL |x|) (LETT |end| |y|)) (#3='T (LETT |end| |x|)))
              (COND ((NULL |res|) (LETT |res| |end|))
                    (#3# (RPLACD |endcell| |end|)))
              (EXIT |res|)))) 

(SDEFUN |IDPO;+;3$;27| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((#1=#:G909 NIL) (|msi| (|SingleInteger|)) (|degy| (|Integer|))
          (|degx| (|Integer|)))
         (SEQ
          (EXIT
           (COND ((NULL |x|) |y|) ((NULL |y|) |x|)
                 ('T
                  (SEQ (LETT |degx| (QCAR (|SPADfirst| |x|)))
                       (LETT |degy| (QCAR (|SPADfirst| |y|)))
                       (LETT |msi| MOST-POSITIVE-FIXNUM)
                       (COND
                        ((< |degx| |msi|)
                         (COND
                          ((< |degy| |msi|)
                           (EXIT
                            (PROGN
                             (LETT #1# (|IDPO;add_si| |x| |y| $))
                             (GO #2=#:G908)))))))
                       (EXIT (|IDPO;add_gen| |x| |y| $))))))
          #2# (EXIT #1#)))) 

(SDEFUN |IDPO;+;3$;28| ((|x| ($)) (|y| ($)) ($ ($))) (|IDPO;add_gen| |x| |y| $)) 

(SDEFUN |IDPO;*;Nni2$;29| ((|n| (|NonNegativeInteger|)) (|x| ($)) ($ ($)))
        (SPROG ((|a| (A)) (#1=#:G916 NIL) (|u| NIL) (#2=#:G915 NIL))
               (SEQ
                (COND ((EQL |n| 0) (|spadConstant| $ 23)) ((EQL |n| 1) |x|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |a|
                                        (SPADCALL |n| (QCDR |u|)
                                                  (QREFELT $ 55)))
                                  (|spadConstant| $ 24) (QREFELT $ 30))
                                 (LETT #2#
                                       (CONS (CONS (QCAR |u|) |a|) #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |IDPO;-;2$;30| ((|x| ($)) ($ ($)))
        (SPROG ((#1=#:G921 NIL) (|u| NIL) (#2=#:G920 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (CONS (QCAR |u|)
                                     (SPADCALL (QCDR |u|) (QREFELT $ 57)))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IDPO;*;I2$;31| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG ((|a| (A)) (#1=#:G926 NIL) (|u| NIL) (#2=#:G925 NIL))
               (SEQ
                (COND ((EQL |n| 0) (|spadConstant| $ 23)) ((EQL |n| 1) |x|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |u| NIL) (LETT #1# |x|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (LETT |a|
                                        (SPADCALL |n| (QCDR |u|)
                                                  (QREFELT $ 60)))
                                  (|spadConstant| $ 24) (QREFELT $ 30))
                                 (LETT #2#
                                       (CONS (CONS (QCAR |u|) |a|) #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |IDPO;-;3$;32| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|res| (|Rep|)) (|end| ($)) (|endcell| (|Rep|)) (|newcell| ($))
          (|r| (A)))
         (SEQ
          (COND ((NULL |x|) (SPADCALL |y| (QREFELT $ 58))) ((NULL |y|) |x|)
                (#1='T
                 (SEQ (LETT |endcell| NIL) (LETT |res| NIL)
                      (SEQ G190
                           (COND
                            ((NULL
                              (COND ((NULL |x|) NIL) ('T (NULL (NULL |y|)))))
                             (GO G191)))
                           (SEQ (LETT |newcell| NIL)
                                (COND
                                 ((SPADCALL (QCAR (|SPADfirst| |x|))
                                            (QCAR (|SPADfirst| |y|))
                                            (QREFELT $ 35))
                                  (SEQ
                                   (LETT |r|
                                         (SPADCALL (QCDR (|SPADfirst| |x|))
                                                   (QCDR (|SPADfirst| |y|))
                                                   (QREFELT $ 62)))
                                   (COND
                                    ((NULL (SPADCALL |r| (QREFELT $ 51)))
                                     (LETT |newcell|
                                           (CONS
                                            (CONS (QCAR (|SPADfirst| |x|)) |r|)
                                            NIL))))
                                   (LETT |x| (CDR |x|))
                                   (EXIT (LETT |y| (CDR |y|)))))
                                 ((SPADCALL (QCAR (|SPADfirst| |y|))
                                            (QCAR (|SPADfirst| |x|))
                                            (QREFELT $ 36))
                                  (SEQ
                                   (LETT |newcell|
                                         (CONS (|SPADfirst| |x|) NIL))
                                   (EXIT (LETT |x| (CDR |x|)))))
                                 ('T
                                  (SEQ
                                   (LETT |newcell|
                                         (CONS
                                          (CONS (QCAR (|SPADfirst| |y|))
                                                (SPADCALL
                                                 (QCDR (|SPADfirst| |y|))
                                                 (QREFELT $ 57)))
                                          NIL))
                                   (EXIT (LETT |y| (CDR |y|))))))
                                (EXIT
                                 (COND
                                  ((NULL (NULL |newcell|))
                                   (COND
                                    ((NULL |endcell|)
                                     (SEQ (LETT |res| |newcell|)
                                          (EXIT (LETT |endcell| |res|))))
                                    ('T
                                     (SEQ (RPLACD |endcell| |newcell|)
                                          (EXIT
                                           (LETT |endcell| |newcell|)))))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (COND
                       ((NULL |x|) (LETT |end| (SPADCALL |y| (QREFELT $ 58))))
                       (#1# (LETT |end| |x|)))
                      (COND ((NULL |res|) (LETT |res| |end|))
                            (#1# (RPLACD |endcell| |end|)))
                      (EXIT |res|))))))) 

(SDEFUN |IDPO;subtractIfCan;2$U;33|
        ((|x| ($)) (|y| ($)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((|res| (|Rep|)) (|endcell| (|Rep|)) (|newcell| ($)) (|r| (A))
          (#2=#:G982 NIL) (|ru| (|Union| A #1#)))
         (SEQ
          (EXIT
           (COND ((NULL |y|) (CONS 0 |x|))
                 (#3='T
                  (SEQ (LETT |endcell| NIL) (LETT |res| NIL)
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND ((NULL |x|) NIL) ('T (NULL (NULL |y|)))))
                              (GO G191)))
                            (SEQ (LETT |newcell| NIL)
                                 (COND
                                  ((SPADCALL (QCAR (|SPADfirst| |x|))
                                             (QCAR (|SPADfirst| |y|))
                                             (QREFELT $ 35))
                                   (SEQ
                                    (LETT |ru|
                                          (SPADCALL (QCDR (|SPADfirst| |x|))
                                                    (QCDR (|SPADfirst| |y|))
                                                    (QREFELT $ 65)))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |ru| 1)
                                       (PROGN
                                        (LETT #2# (CONS 1 "failed"))
                                        (GO #4=#:G981)))
                                      ('T
                                       (SEQ (LETT |r| (QCDR |ru|))
                                            (COND
                                             ((NULL
                                               (SPADCALL |r| (QREFELT $ 51)))
                                              (LETT |newcell|
                                                    (CONS
                                                     (CONS
                                                      (QCAR (|SPADfirst| |x|))
                                                      |r|)
                                                     NIL))))
                                            (LETT |x| (CDR |x|))
                                            (EXIT (LETT |y| (CDR |y|)))))))))
                                  ((SPADCALL (QCAR (|SPADfirst| |y|))
                                             (QCAR (|SPADfirst| |x|))
                                             (QREFELT $ 36))
                                   (SEQ
                                    (LETT |newcell|
                                          (CONS (|SPADfirst| |x|) NIL))
                                    (EXIT (LETT |x| (CDR |x|)))))
                                  ('T
                                   (SEQ
                                    (LETT |ru|
                                          (SPADCALL (|spadConstant| $ 24)
                                                    (QCDR (|SPADfirst| |y|))
                                                    (QREFELT $ 65)))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |ru| 1)
                                       (PROGN
                                        (LETT #2# (CONS 1 "failed"))
                                        (GO #4#)))
                                      ('T
                                       (SEQ (LETT |r| (QCDR |ru|))
                                            (LETT |newcell|
                                                  (CONS
                                                   (CONS
                                                    (QCAR (|SPADfirst| |y|))
                                                    |r|)
                                                   NIL))
                                            (EXIT (LETT |y| (CDR |y|))))))))))
                                 (EXIT
                                  (COND
                                   ((NULL (NULL |newcell|))
                                    (COND
                                     ((NULL |endcell|)
                                      (SEQ (LETT |res| |newcell|)
                                           (EXIT (LETT |endcell| |res|))))
                                     ('T
                                      (SEQ (RPLACD |endcell| |newcell|)
                                           (EXIT
                                            (LETT |endcell| |newcell|)))))))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (COND
                         ((NULL |x|)
                          (SEQ
                           (SEQ G190
                                (COND ((NULL (NULL (NULL |y|))) (GO G191)))
                                (SEQ
                                 (LETT |ru|
                                       (SPADCALL (|spadConstant| $ 24)
                                                 (QCDR (|SPADfirst| |y|))
                                                 (QREFELT $ 65)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |ru| 1)
                                    (PROGN
                                     (LETT #2# (CONS 1 "failed"))
                                     (GO #4#)))
                                   ('T
                                    (SEQ (LETT |r| (QCDR |ru|))
                                         (LETT |newcell|
                                               (CONS
                                                (CONS (QCAR (|SPADfirst| |y|))
                                                      |r|)
                                                NIL))
                                         (LETT |y| (CDR |y|))
                                         (EXIT
                                          (COND
                                           ((NULL |endcell|)
                                            (SEQ (LETT |res| |newcell|)
                                                 (EXIT
                                                  (LETT |endcell| |res|))))
                                           ('T
                                            (SEQ (RPLACD |endcell| |newcell|)
                                                 (EXIT
                                                  (LETT |endcell|
                                                        |newcell|)))))))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT (CONS 0 |res|))))
                         (#3#
                          (SEQ
                           (COND ((NULL |res|) (LETT |res| |x|))
                                 (#3# (RPLACD |endcell| |x|)))
                           (EXIT (CONS 0 |res|))))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |IDPO;<;2$B;34| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 37))) 

(SDEFUN |IDPO;sup;3$;35| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|u| (A)))
               (SEQ
                (COND ((NULL |y|) |x|) ((NULL |x|) |y|)
                      ((SPADCALL (QCAR (|SPADfirst| |x|))
                                 (QCAR (|SPADfirst| |y|)) (QREFELT $ 68))
                       (CONS (|SPADfirst| |y|)
                             (SPADCALL |x| (CDR |y|) (QREFELT $ 69))))
                      ((SPADCALL (QCAR (|SPADfirst| |x|))
                                 (QCAR (|SPADfirst| |y|)) (QREFELT $ 70))
                       (CONS (|SPADfirst| |x|)
                             (SPADCALL (CDR |x|) |y| (QREFELT $ 69))))
                      ('T
                       (SEQ
                        (LETT |u|
                              (SPADCALL (QCDR (|SPADfirst| |x|))
                                        (QCDR (|SPADfirst| |y|))
                                        (QREFELT $ 71)))
                        (EXIT
                         (CONS (CONS (QCAR (|SPADfirst| |x|)) |u|)
                               (SPADCALL (CDR |x|) (CDR |y|)
                                         (QREFELT $ 69)))))))))) 

(SDEFUN |IDPO;inf;3$;36| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|yr| (|Rep|)) (|xr| (|Rep|)) (|res| (|Rep|))
          (|y1| #1=(|Record| (|:| |k| S) (|:| |c| A))) (|x1| #1#))
         (SEQ (LETT |xr| |x|) (LETT |yr| |y|) (LETT |res| NIL)
              (SEQ G190
                   (COND
                    ((NULL (COND ((NULL |x|) NIL) ('T (NULL (NULL |yr|)))))
                     (GO G191)))
                   (SEQ (LETT |x1| (|SPADfirst| |xr|))
                        (LETT |y1| (|SPADfirst| |yr|))
                        (EXIT
                         (COND
                          ((SPADCALL (QCAR |x1|) (QCAR |y1|) (QREFELT $ 68))
                           (LETT |xr| (CDR |xr|)))
                          ((SPADCALL (QCAR |x1|) (QCAR |y1|) (QREFELT $ 70))
                           (LETT |yr| (CDR |yr|)))
                          ('T
                           (SEQ
                            (LETT |res|
                                  (CONS
                                   (CONS (QCAR |x1|)
                                         (SPADCALL (QCDR |x1|) (QCDR |y1|)
                                                   (QREFELT $ 72)))
                                   |res|))
                            (LETT |xr| (CDR |xr|))
                            (EXIT (LETT |yr| (CDR |yr|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |res|))))) 

(PUT '|IDPO;construct;L$;37| '|SPADreplace| '(XLAM (|lx|) |lx|)) 

(SDEFUN |IDPO;construct;L$;37|
        ((|lx| (|List| (|Record| (|:| |k| S) (|:| |c| A)))) ($ ($))) |lx|) 

(PUT '|IDPO;Zero;$;38| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |IDPO;Zero;$;38| (($ ($))) NIL) 

(SDEFUN |IDPO;do_copy| ((|xr| (|Rep|)) ($ (|Rep|)))
        (SPROG ((|res| ($)) (#1=#:G1007 NIL) (|t| NIL))
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |t| NIL) (LETT #1# |xr|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (CONS (CONS (QCAR |t|) (QCDR |t|)) |res|))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |res|))))) 

(SDEFUN |IDPO;+;3$;40| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|xr| (|Rep|)) (|cxr| (|Rep|)) (|pxr| (|Rep|))
          (|first_time| #1=(|Boolean|)) (|done| #1#) (|nxr| (|Rep|)) (|tc| (A))
          (|t| (|Record| (|:| |k| S) (|:| |c| A))) (|sc| (A)) (|sk| (S))
          (#2=#:G1023 NIL) (|s| NIL) (|yr| (|Rep|)) (|xxr| (|Rep|)))
         (SEQ (LETT |xxr| |x|) (LETT |yr| |y|)
              (EXIT
               (COND ((NULL |xxr|) |y|) ((NULL |yr|) |x|)
                     ((> (LENGTH |yr|) (LENGTH |xxr|))
                      (SPADCALL |y| |x| (QREFELT $ 54)))
                     ('T
                      (SEQ (LETT |xr| (|IDPO;do_copy| |xxr| $))
                           (SEQ (LETT |s| NIL) (LETT #2# |yr|) G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |s| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |sk| (QCAR |s|))
                                     (LETT |sc| (QCDR |s|)) (LETT |done| NIL)
                                     (LETT |first_time| 'T) (LETT |nxr| |xr|)
                                     (LETT |cxr| |xr|)
                                     (SEQ G190
                                          (COND
                                           ((NULL
                                             (NULL (OR (NULL |cxr|) |done|)))
                                            (GO G191)))
                                          (SEQ (LETT |t| (|SPADfirst| |cxr|))
                                               (COND
                                                ((SPADCALL (QCAR |t|) |sk|
                                                           (QREFELT $ 35))
                                                 (SEQ
                                                  (LETT |tc|
                                                        (SPADCALL (QCDR |t|)
                                                                  |sc|
                                                                  (QREFELT $
                                                                           50)))
                                                  (COND
                                                   ((SPADCALL |tc|
                                                              (|spadConstant| $
                                                                              24)
                                                              (QREFELT $ 25))
                                                    (COND
                                                     (|first_time|
                                                      (LETT |nxr| (CDR |cxr|)))
                                                     ('T
                                                      (|qset_rest| |pxr|
                                                                   (CDR
                                                                    |cxr|)))))
                                                   ('T
                                                    (PROGN
                                                     (RPLACD |t| |tc|)
                                                     (QCDR |t|))))
                                                  (EXIT (LETT |done| 'T)))))
                                               (LETT |first_time| NIL)
                                               (LETT |pxr| |cxr|)
                                               (EXIT (LETT |cxr| (CDR |cxr|))))
                                          NIL (GO G190) G191 (EXIT NIL))
                                     (LETT |xr| |nxr|)
                                     (EXIT
                                      (COND
                                       ((NULL |done|)
                                        (LETT |xr|
                                              (CONS (CONS |sk| |sc|) |xr|))))))
                                (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |xr|)))))))) 

(SDEFUN |IDPO;=;2$B;41| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1035 NIL) (|done| (|Boolean|)) (#2=#:G1037 NIL) (|t| NIL)
          (|sc| (A)) (|sk| (S)) (#3=#:G1036 NIL) (|s| NIL) (|yr| (|Rep|))
          (|xr| (|Rep|)))
         (SEQ
          (EXIT
           (SEQ (LETT |xr| |x|) (LETT |yr| |y|)
                (EXIT
                 (COND
                  ((SPADCALL (LENGTH |xr|) (LENGTH |yr|) (QREFELT $ 74)) NIL)
                  ('T
                   (SEQ
                    (SEQ (LETT |s| NIL) (LETT #3# |yr|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |sk| (QCAR |s|)) (LETT |sc| (QCDR |s|))
                              (LETT |done| NIL)
                              (SEQ (LETT |t| NIL) (LETT #2# |xr|) G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |t| (CAR #2#)) NIL)
                                         (NULL (NULL |done|)))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((SPADCALL (QCAR |t|) |sk|
                                                 (QREFELT $ 35))
                                       (COND
                                        ((SPADCALL (QCDR |t|) |sc|
                                                   (QREFELT $ 25))
                                         (LETT |done| 'T))
                                        ('T
                                         (PROGN
                                          (LETT #1# NIL)
                                          (GO #4=#:G1034))))))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT
                               (COND
                                ((NULL |done|)
                                 (PROGN (LETT #1# NIL) (GO #4#))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                    (EXIT 'T)))))))
          #4# (EXIT #1#)))) 

(SDEFUN |IDPO;subtractIfCan;2$U;42|
        ((|x| ($)) (|y| ($)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((|xr| (|Rep|)) (#2=#:G1059 NIL) (|tcu| (|Union| A #1#))
          (|cxr| (|Rep|)) (|pxr| (|Rep|)) (|first_time| #3=(|Boolean|))
          (|done| #3#) (|nxr| (|Rep|)) (|tc| (A))
          (|t| (|Record| (|:| |k| S) (|:| |c| A))) (|sc| (A)) (|sk| (S))
          (#4=#:G1060 NIL) (|s| NIL) (|yr| (|Rep|)))
         (SEQ
          (EXIT
           (SEQ (LETT |yr| |y|)
                (EXIT
                 (COND ((NULL |yr|) (CONS 0 |x|))
                       ('T
                        (SEQ (LETT |xr| (|IDPO;do_copy| |x| $))
                             (SEQ (LETT |s| NIL) (LETT #4# |yr|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |s| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ (LETT |sk| (QCAR |s|))
                                       (LETT |sc| (QCDR |s|)) (LETT |done| NIL)
                                       (LETT |first_time| 'T) (LETT |nxr| |xr|)
                                       (LETT |cxr| |xr|)
                                       (SEQ G190
                                            (COND
                                             ((NULL
                                               (NULL (OR (NULL |cxr|) |done|)))
                                              (GO G191)))
                                            (SEQ (LETT |t| (|SPADfirst| |cxr|))
                                                 (COND
                                                  ((SPADCALL (QCAR |t|) |sk|
                                                             (QREFELT $ 35))
                                                   (SEQ
                                                    (LETT |tcu|
                                                          (SPADCALL (QCDR |t|)
                                                                    |sc|
                                                                    (QREFELT $
                                                                             65)))
                                                    (EXIT
                                                     (COND
                                                      ((QEQCAR |tcu| 1)
                                                       (PROGN
                                                        (LETT #2#
                                                              (CONS 1
                                                                    "failed"))
                                                        (GO #5=#:G1058)))
                                                      ('T
                                                       (SEQ
                                                        (LETT |tc|
                                                              (QCDR |tcu|))
                                                        (COND
                                                         ((SPADCALL |tc|
                                                                    (|spadConstant|
                                                                     $ 24)
                                                                    (QREFELT $
                                                                             25))
                                                          (COND
                                                           (|first_time|
                                                            (LETT |nxr|
                                                                  (CDR |cxr|)))
                                                           ('T
                                                            (|qset_rest| |pxr|
                                                                         (CDR
                                                                          |cxr|)))))
                                                         ('T
                                                          (PROGN
                                                           (RPLACD |t| |tc|)
                                                           (QCDR |t|))))
                                                        (EXIT
                                                         (LETT |done|
                                                               'T)))))))))
                                                 (LETT |first_time| NIL)
                                                 (LETT |pxr| |cxr|)
                                                 (EXIT
                                                  (LETT |cxr| (CDR |cxr|))))
                                            NIL (GO G190) G191 (EXIT NIL))
                                       (LETT |xr| |nxr|)
                                       (EXIT
                                        (COND
                                         ((NULL |done|)
                                          (SEQ
                                           (LETT |tcu|
                                                 (SPADCALL
                                                  (|spadConstant| $ 24) |sc|
                                                  (QREFELT $ 65)))
                                           (EXIT
                                            (COND
                                             ((QEQCAR |tcu| 1)
                                              (PROGN
                                               (LETT #2# (CONS 1 "failed"))
                                               (GO #5#)))
                                             ('T
                                              (LETT |xr|
                                                    (CONS
                                                     (CONS |sk| (QCDR |tcu|))
                                                     |xr|))))))))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT (CONS 0 |xr|))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |IDPO;-;2$;43| ((|x| ($)) ($ ($)))
        (SPADCALL (ELT $ 57) |x| (QREFELT $ 28))) 

(DECLAIM (NOTINLINE |IndexedDirectProductObject;|)) 

(DEFUN |IndexedDirectProductObject| (&REST #1=#:G1064)
  (SPROG NIL
         (PROG (#2=#:G1065)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IndexedDirectProductObject|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |IndexedDirectProductObject;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IndexedDirectProductObject|)))))))))) 

(DEFUN |IndexedDirectProductObject;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G1063 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|IndexedDirectProductObject| DV$1 DV$2))
    (LETT $ (GETREFV 77))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|OrderedAbelianMonoidSup|))
                                         (|HasCategory| |#2| '(|OrderedSet|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|)))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|Comparable|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#))
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1| '(|Comparable|))
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoid|))
                                          (|HasCategory| |#2| '(|OrderedSet|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CancellationAbelianMonoid|))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|OrderedAbelianMonoidSup|))
                                          (|HasCategory| |#2|
                                                         '(|OrderedSet|))))))))
    (|haddProp| |$ConstructorCache| '|IndexedDirectProductObject|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|List| (|Record| (|:| |k| |#2|) (|:| |c| |#1|))))
    (COND
     ((|HasCategory| |#1| '(|AbelianMonoid|))
      (PROGN
       (QSETREFV $ 26 (CONS (|dispatchFunction| |IDPO;monomial;AS$;5|) $))
       (QSETREFV $ 28 (CONS (|dispatchFunction| |IDPO;map;M2$;6|) $))))
     ('T
      (PROGN
       (QSETREFV $ 26 (CONS (|dispatchFunction| |IDPO;monomial;AS$;7|) $))
       (QSETREFV $ 28 (CONS (|dispatchFunction| |IDPO;map;M2$;8|) $)))))
    (COND
     ((|testBitVector| |pv$| 6)
      (PROGN
       (QSETREFV $ 31 (CONS (|dispatchFunction| |IDPO;=;2$B;9|) $))
       (COND
        ((|HasCategory| |#1| '(|AbelianMonoid|))
         (PROGN
          (QSETREFV $ 32 (CONS (|dispatchFunction| |IDPO;reductum;2$;10|) $))
          (QSETREFV $ 33
                    (CONS (|dispatchFunction| |IDPO;leadingCoefficient;$A;11|)
                          $))
          (COND
           ((|HasCategory| |#1| '(|Comparable|))
            (PROGN
             (QSETREFV $ 37
                       (CONS (|dispatchFunction| |IDPO;smaller?;2$B;12|)
                             $)))))))
        ('T
         (PROGN
          (QSETREFV $ 32 (CONS (|dispatchFunction| |IDPO;reductum;2$;13|) $))
          (QSETREFV $ 33
                    (CONS (|dispatchFunction| |IDPO;leadingCoefficient;$A;14|)
                          $))
          (COND
           ((|HasCategory| |#1| '(|Comparable|))
            (PROGN
             (QSETREFV $ 37
                       (CONS (|dispatchFunction| |IDPO;smaller?;2$B;15|)
                             $))))))))
       (QSETREFV $ 38
                 (CONS (|dispatchFunction| |IDPO;leadingSupport;$S;16|) $))
       (QSETREFV $ 39
                 (CONS (|dispatchFunction| |IDPO;leadingMonomial;2$;17|) $))
       NIL
       (QSETREFV $ 42 (CONS (|dispatchFunction| |IDPO;construct;L$;19|) $))
       (QSETREFV $ 43
                 (CONS (|dispatchFunction| |IDPO;constructOrdered;L$;20|) $))
       (QSETREFV $ 44 (CONS (|dispatchFunction| |IDPO;leadingTerm;$R;21|) $))
       (QSETREFV $ 48
                 (CONS (|dispatchFunction| |IDPO;hashUpdate!;Hs$Hs;22|) $))
       (COND
        ((|HasCategory| |#1| '(|AbelianMonoid|))
         (PROGN
          (QSETREFV $ 23
                    (CONS #'|makeSpadConstant|
                          (LIST (|dispatchFunction| |IDPO;Zero;$;23|) $ 23)))
          (QSETREFV $ 49 (CONS (|dispatchFunction| |IDPO;zero?;$B;24|) $))
          (COND
           ((|domainEqual| |#2| (|NonNegativeInteger|))
            (PROGN
             (QSETREFV $ 54 (CONS (|dispatchFunction| |IDPO;+;3$;27|) $))))
           ('T (QSETREFV $ 54 (CONS (|dispatchFunction| |IDPO;+;3$;28|) $))))
          (QSETREFV $ 56 (CONS (|dispatchFunction| |IDPO;*;Nni2$;29|) $)))))
       (COND
        ((|testBitVector| |pv$| 1)
         (PROGN
          (QSETREFV $ 58 (CONS (|dispatchFunction| |IDPO;-;2$;30|) $))
          (QSETREFV $ 61 (CONS (|dispatchFunction| |IDPO;*;I2$;31|) $))
          (QSETREFV $ 63 (CONS (|dispatchFunction| |IDPO;-;3$;32|) $)))))
       (COND
        ((|HasCategory| |#1| '(|CancellationAbelianMonoid|))
         (QSETREFV $ 66
                   (CONS (|dispatchFunction| |IDPO;subtractIfCan;2$U;33|) $))))
       (COND
        ((|HasCategory| |#1| '(|OrderedAbelianMonoid|))
         (QSETREFV $ 67 (CONS (|dispatchFunction| |IDPO;<;2$B;34|) $))))
       (COND
        ((|HasCategory| |#2| '(|OrderedSet|))
         (COND
          ((|HasCategory| |#1| '(|OrderedAbelianMonoidSup|))
           (PROGN
            (QSETREFV $ 69 (CONS (|dispatchFunction| |IDPO;sup;3$;35|) $))
            (QSETREFV $ 73
                      (CONS (|dispatchFunction| |IDPO;inf;3$;36|) $)))))))))
     ('T
      (PROGN
       (QSETREFV $ 42 (CONS (|dispatchFunction| |IDPO;construct;L$;37|) $))
       (COND
        ((|HasCategory| |#1| '(|AbelianMonoid|))
         (PROGN
          (QSETREFV $ 23
                    (CONS #'|makeSpadConstant|
                          (LIST (|dispatchFunction| |IDPO;Zero;$;38|) $ 23)))
          (QSETREFV $ 54 (CONS (|dispatchFunction| |IDPO;+;3$;40|) $))
          (QSETREFV $ 31 (CONS (|dispatchFunction| |IDPO;=;2$B;41|) $))
          (COND
           ((|HasCategory| |#1| '(|CancellationAbelianMonoid|))
            (QSETREFV $ 66
                      (CONS (|dispatchFunction| |IDPO;subtractIfCan;2$U;42|)
                            $))))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 58
                      (CONS (|dispatchFunction| |IDPO;-;2$;43|) $))))))))))
    $))) 

(MAKEPROP '|IndexedDirectProductObject| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|OutputForm|) (0 . |coerce|) (5 . |coerce|) (10 . |rarrow|)
              (|List| $) (16 . |bracket|) |IDPO;coerce;$Of;1|
              (|Record| (|:| |k| 7) (|:| |c| 6)) (|List| 16)
              |IDPO;listOfTerms;$L;2| (|Boolean|) |IDPO;monomial?;$B;3|
              (|NonNegativeInteger|) |IDPO;numberOfMonomials;$Nni;4|
              (21 . |Zero|) (25 . |Zero|) (29 . =) (35 . |monomial|)
              (|Mapping| 6 6) (41 . |map|) (47 . ~=) (53 . ~=) (59 . =)
              (65 . |reductum|) (70 . |leadingCoefficient|) (75 . |smaller?|)
              (81 . =) (87 . |smaller?|) (93 . |smaller?|)
              (99 . |leadingSupport|) (104 . |leadingMonomial|)
              (|Mapping| 19 16 16) (109 . |sort|) (115 . |construct|)
              (120 . |constructOrdered|) (125 . |leadingTerm|) (|HashState|)
              (130 . |hashUpdate!|) (136 . |hashUpdate!|) (142 . |hashUpdate!|)
              (148 . |zero?|) (153 . +) (159 . |zero?|) (|SingleInteger|)
              (164 . |smaller?|) (170 . +) (176 . *) (182 . *) (188 . -)
              (193 . -) (|Integer|) (198 . *) (204 . *) (210 . -) (216 . -)
              (|Union| $ '"failed") (222 . |subtractIfCan|)
              (228 . |subtractIfCan|) (234 . <) (240 . <) (246 . |sup|)
              (252 . >) (258 . |sup|) (264 . |inf|) (270 . |inf|) (276 . ~=)
              (|String|) (|PositiveInteger|))
           '#(~= 282 |zero?| 288 |sup| 293 |subtractIfCan| 299 |smaller?| 305
              |sample| 311 |reductum| 315 |opposite?| 320 |numberOfMonomials|
              326 |monomial?| 331 |monomial| 336 |min| 342 |max| 348 |map| 354
              |listOfTerms| 360 |leadingTerm| 365 |leadingSupport| 370
              |leadingMonomial| 375 |leadingCoefficient| 380 |latex| 385 |inf|
              390 |hashUpdate!| 396 |hash| 402 |constructOrdered| 407
              |construct| 412 |coerce| 417 |Zero| 422 >= 426 > 432 = 438 <= 444
              < 450 - 456 + 467 * 473)
           'NIL
           (CONS (|makeByteWordVec2| 9 '(0 0 2 0 2 1 3 3 4 3 5 7 5 9 8 3 9))
                 (CONS
                  '#(NIL NIL NIL NIL NIL |AbelianGroup&| NIL NIL NIL
                     |OrderedSet&| |AbelianMonoid&| NIL |AbelianSemiGroup&|
                     |SetCategory&| NIL |PartialOrder&| |BasicType&|)
                  (CONS
                   '#((|IndexedDirectProductCategory| 6 7)
                      (|IndexedProductCategory| 6 7)
                      (|OrderedAbelianMonoidSup|) (|AbelianProductCategory| 6)
                      (|OrderedCancellationAbelianMonoid|) (|AbelianGroup|)
                      (|OrderedAbelianMonoid|) (|OrderedAbelianSemiGroup|)
                      (|CancellationAbelianMonoid|) (|OrderedSet|)
                      (|AbelianMonoid|) (|Comparable|) (|AbelianSemiGroup|)
                      (|SetCategory|) (|CoercibleTo| 9) (|PartialOrder|)
                      (|BasicType|))
                   (|makeByteWordVec2| 76
                                       '(1 7 9 0 10 1 6 9 0 11 2 9 0 0 0 12 1 9
                                         0 13 14 0 0 0 23 0 6 0 24 2 6 19 0 0
                                         25 2 0 0 6 7 26 2 0 0 27 0 28 2 7 19 0
                                         0 29 2 6 19 0 0 30 2 0 19 0 0 31 1 0 0
                                         0 32 1 0 6 0 33 2 6 19 0 0 34 2 7 19 0
                                         0 35 2 7 19 0 0 36 2 0 19 0 0 37 1 0 7
                                         0 38 1 0 0 0 39 2 8 0 40 0 41 1 0 0 17
                                         42 1 0 0 17 43 1 0 16 0 44 2 7 45 45 0
                                         46 2 6 45 45 0 47 2 0 45 45 0 48 1 0
                                         19 0 49 2 6 0 0 0 50 1 6 19 0 51 2 52
                                         19 0 0 53 2 0 0 0 0 54 2 6 0 21 0 55 2
                                         0 0 21 0 56 1 6 0 0 57 1 0 0 0 58 2 6
                                         0 59 0 60 2 0 0 59 0 61 2 6 0 0 0 62 2
                                         0 0 0 0 63 2 6 64 0 0 65 2 0 64 0 0 66
                                         2 0 19 0 0 67 2 7 19 0 0 68 2 0 0 0 0
                                         69 2 7 19 0 0 70 2 6 0 0 0 71 2 6 0 0
                                         0 72 2 0 0 0 0 73 2 21 19 0 0 74 2 10
                                         19 0 0 1 1 12 19 0 49 2 2 0 0 0 69 2
                                         13 64 0 0 66 2 11 19 0 0 37 0 12 0 1 1
                                         6 0 0 32 2 12 19 0 0 1 1 0 21 0 22 1 0
                                         19 0 20 2 0 0 6 7 26 2 3 0 0 0 1 2 3 0
                                         0 0 1 2 0 0 27 0 28 1 0 17 0 18 1 6 16
                                         0 44 1 6 7 0 38 1 6 0 0 39 1 6 6 0 33
                                         1 10 75 0 1 2 2 0 0 0 73 2 10 45 45 0
                                         48 1 10 52 0 1 1 6 0 17 43 1 0 0 17 42
                                         1 10 9 0 15 0 12 0 23 2 3 19 0 0 1 2 3
                                         19 0 0 1 2 10 19 0 0 31 2 3 19 0 0 1 2
                                         3 19 0 0 67 1 1 0 0 58 2 1 0 0 0 63 2
                                         12 0 0 0 54 2 12 0 21 0 56 2 12 0 76 0
                                         1 2 1 0 59 0 61)))))
           '|lookupComplete|)) 
