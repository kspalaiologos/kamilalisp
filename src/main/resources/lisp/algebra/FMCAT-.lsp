
(SDEFUN |FMCAT-;support;AL;1| ((|p| (A)) ($ (|List| S)))
        (SPROG ((#1=#:G713 NIL) (|t| NIL) (#2=#:G712 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 11)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCAR |t|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FMCAT-;coefficients;AL;2| ((|p| (A)) ($ (|List| R)))
        (SPROG ((#1=#:G719 NIL) (|t| NIL) (#2=#:G718 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 11)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCDR |t|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FMCAT-;monomials;AL;3| ((|p| (A)) ($ (|List| A)))
        (SPROG ((#1=#:G725 NIL) (|t| NIL) (#2=#:G724 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 11)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (QCDR |t|) (QCAR |t|) (QREFELT $ 16))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FMCAT-;leadingSupport;AS;4| ((|p| (A)) ($ (S)))
        (QCAR (SPADCALL |p| (QREFELT $ 19)))) 

(SDEFUN |FMCAT-;leadingCoefficient;AR;5| ((|p| (A)) ($ (R)))
        (QCDR (SPADCALL |p| (QREFELT $ 19)))) 

(SDEFUN |FMCAT-;leadingMonomial;2A;6| ((|p| (A)) ($ (A)))
        (SPROG ((|t| (|Record| (|:| |k| S) (|:| |c| R))))
               (SEQ (LETT |t| (SPADCALL |p| (QREFELT $ 19)))
                    (EXIT (SPADCALL (QCDR |t|) (QCAR |t|) (QREFELT $ 16)))))) 

(SDEFUN |FMCAT-;smaller?;2AB;7| ((|p| (A)) (|q| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G741 NIL))
               (SEQ
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |q| (QREFELT $ 24))
                          (PROGN (LETT #1# NIL) (GO #2=#:G740)))
                         ((SPADCALL |p| (QREFELT $ 24))
                          (PROGN (LETT #1# 'T) (GO #2#)))
                         ((SPADCALL (SPADCALL |p| (QREFELT $ 25))
                                    (SPADCALL |q| (QREFELT $ 25))
                                    (QREFELT $ 26))
                          (COND
                           ((SPADCALL (SPADCALL |p| (QREFELT $ 27))
                                      (SPADCALL |q| (QREFELT $ 27))
                                      (QREFELT $ 28))
                            (SEQ (LETT |p| (SPADCALL |p| (QREFELT $ 29)))
                                 (EXIT
                                  (LETT |q| (SPADCALL |q| (QREFELT $ 29))))))
                           ('T
                            (PROGN
                             (LETT #1#
                                   (SPADCALL (SPADCALL |p| (QREFELT $ 27))
                                             (SPADCALL |q| (QREFELT $ 27))
                                             (QREFELT $ 30)))
                             (GO #2#)))))
                         ('T
                          (PROGN
                           (LETT #1#
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 25))
                                           (SPADCALL |q| (QREFELT $ 25))
                                           (QREFELT $ 31)))
                           (GO #2#))))))
                      NIL (GO G190) G191 (EXIT NIL)))
                #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |FreeModuleCategory&;|)) 

(DEFUN |FreeModuleCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FreeModuleCategory&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 33))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|CommutativeRing|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#3| '(|Comparable|))
            (PROGN
             (QSETREFV $ 20
                       (CONS (|dispatchFunction| |FMCAT-;leadingSupport;AS;4|)
                             $))
             (QSETREFV $ 21
                       (CONS
                        (|dispatchFunction| |FMCAT-;leadingCoefficient;AR;5|)
                        $))
             (QSETREFV $ 22
                       (CONS (|dispatchFunction| |FMCAT-;leadingMonomial;2A;6|)
                             $)))))
          (COND
           ((|HasCategory| |#2| '(|Comparable|))
            (COND
             ((|HasCategory| |#3| '(|Comparable|))
              (QSETREFV $ 32
                        (CONS (|dispatchFunction| |FMCAT-;smaller?;2AB;7|)
                              $))))))
          $))) 

(MAKEPROP '|FreeModuleCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Record| (|:| |k| 8) (|:| |c| 7)) (|List| 9)
              (0 . |listOfTerms|) (|List| 8) |FMCAT-;support;AL;1| (|List| 7)
              |FMCAT-;coefficients;AL;2| (5 . |monomial|) (|List| $)
              |FMCAT-;monomials;AL;3| (11 . |leadingTerm|)
              (16 . |leadingSupport|) (21 . |leadingCoefficient|)
              (26 . |leadingMonomial|) (|Boolean|) (31 . |zero?|)
              (36 . |leadingSupport|) (41 . =) (47 . |leadingCoefficient|)
              (52 . =) (58 . |reductum|) (63 . |smaller?|) (69 . |smaller?|)
              (75 . |smaller?|))
           '#(|support| 81 |smaller?| 86 |monomials| 92 |leadingSupport| 97
              |leadingMonomial| 102 |leadingCoefficient| 107 |coefficients|
              112)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|monomials| ((|List| |#1|) |#1|)) T)
                                   '((|support| ((|List| |#3|) |#1|)) T)
                                   '((|coefficients| ((|List| |#2|) |#1|)) T)
                                   '((|leadingMonomial| (|#1| |#1|)) T)
                                   '((|leadingCoefficient| (|#2| |#1|)) T)
                                   '((|leadingSupport| (|#3| |#1|)) T)
                                   '((|smaller?| ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 32
                                            '(1 6 10 0 11 2 6 0 7 8 16 1 6 9 0
                                              19 1 0 8 0 20 1 0 7 0 21 1 0 0 0
                                              22 1 6 23 0 24 1 6 8 0 25 2 8 23
                                              0 0 26 1 6 7 0 27 2 7 23 0 0 28 1
                                              6 0 0 29 2 7 23 0 0 30 2 8 23 0 0
                                              31 2 0 23 0 0 32 1 0 12 0 13 2 0
                                              23 0 0 32 1 0 17 0 18 1 0 8 0 20
                                              1 0 0 0 22 1 0 7 0 21 1 0 14 0
                                              15)))))
           '|lookupComplete|)) 
