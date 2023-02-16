
(SDEFUN |PSETCAT-;elements| ((|ps| (S)) ($ (|List| P)))
        (SPROG ((|lp| (|List| P))) (LETT |lp| (SPADCALL |ps| (QREFELT $ 12))))) 

(SDEFUN |PSETCAT-;variables1| ((|lp| (|List| P)) ($ (|List| |VarSet|)))
        (SPROG
         ((|lvars| (|List| (|List| |VarSet|))) (#1=#:G766 NIL) (|p| NIL)
          (#2=#:G765 NIL))
         (SEQ
          (LETT |lvars|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |p| (QREFELT $ 14)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (SPADCALL (ELT $ 16)
                     (SPADCALL (SPADCALL |lvars| (QREFELT $ 18))
                               (QREFELT $ 19))
                     (QREFELT $ 21)))))) 

(SDEFUN |PSETCAT-;variables2| ((|lp| (|List| P)) ($ (|List| |VarSet|)))
        (SPROG
         ((|lvars| (|List| |VarSet|)) (#1=#:G772 NIL) (|p| NIL)
          (#2=#:G771 NIL))
         (SEQ
          (LETT |lvars|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |p| (QREFELT $ 22)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (SPADCALL (ELT $ 16) (SPADCALL |lvars| (QREFELT $ 19))
                     (QREFELT $ 21)))))) 

(SDEFUN |PSETCAT-;variables;SL;4| ((|ps| (S)) ($ (|List| |VarSet|)))
        (|PSETCAT-;variables1| (|PSETCAT-;elements| |ps| $) $)) 

(SDEFUN |PSETCAT-;mainVariables;SL;5| ((|ps| (S)) ($ (|List| |VarSet|)))
        (|PSETCAT-;variables2|
         (SPADCALL (ELT $ 24) (|PSETCAT-;elements| |ps| $) (QREFELT $ 26)) $)) 

(SDEFUN |PSETCAT-;mainVariable?;VarSetSB;6|
        ((|v| (|VarSet|)) (|ps| (S)) ($ (|Boolean|)))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (LETT |lp|
                      (SPADCALL (ELT $ 24) (|PSETCAT-;elements| |ps| $)
                                (QREFELT $ 26)))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |lp|) NIL)
                              ('T
                               (NULL
                                (SPADCALL
                                 (SPADCALL (|SPADfirst| |lp|) (QREFELT $ 22))
                                 |v| (QREFELT $ 28))))))
                       (GO G191)))
                     (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL (GO G190) G191
                     (EXIT NIL))
                (EXIT (NULL (NULL |lp|)))))) 

(SDEFUN |PSETCAT-;collectUnder;SVarSetS;7|
        ((|ps| (S)) (|v| (|VarSet|)) ($ (S)))
        (SPROG ((|lq| (|List| P)) (|lp| (|List| P)) (|p| (P)))
               (SEQ (LETT |lp| (|PSETCAT-;elements| |ps| $)) (LETT |lq| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                         (SEQ (LETT |p| (|SPADfirst| |lp|))
                              (LETT |lp| (CDR |lp|))
                              (EXIT
                               (COND
                                ((OR (SPADCALL |p| (QREFELT $ 24))
                                     (SPADCALL (SPADCALL |p| (QREFELT $ 22))
                                               |v| (QREFELT $ 30)))
                                 (LETT |lq| (CONS |p| |lq|))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |lq| (QREFELT $ 31)))))) 

(SDEFUN |PSETCAT-;collectUpper;SVarSetS;8|
        ((|ps| (S)) (|v| (|VarSet|)) ($ (S)))
        (SPROG ((|lq| (|List| P)) (|lp| (|List| P)) (|p| (P)))
               (SEQ (LETT |lp| (|PSETCAT-;elements| |ps| $)) (LETT |lq| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                         (SEQ (LETT |p| (|SPADfirst| |lp|))
                              (LETT |lp| (CDR |lp|))
                              (EXIT
                               (COND
                                ((NULL (SPADCALL |p| (QREFELT $ 24)))
                                 (COND
                                  ((SPADCALL (SPADCALL |p| (QREFELT $ 22)) |v|
                                             (QREFELT $ 16))
                                   (LETT |lq| (CONS |p| |lq|))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |lq| (QREFELT $ 31)))))) 

(SDEFUN |PSETCAT-;collect;SVarSetS;9| ((|ps| (S)) (|v| (|VarSet|)) ($ (S)))
        (SPROG ((|lq| (|List| P)) (|lp| (|List| P)) (|p| (P)))
               (SEQ (LETT |lp| (|PSETCAT-;elements| |ps| $)) (LETT |lq| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                         (SEQ (LETT |p| (|SPADfirst| |lp|))
                              (LETT |lp| (CDR |lp|))
                              (EXIT
                               (COND
                                ((NULL (SPADCALL |p| (QREFELT $ 24)))
                                 (COND
                                  ((SPADCALL (SPADCALL |p| (QREFELT $ 22)) |v|
                                             (QREFELT $ 28))
                                   (LETT |lq| (CONS |p| |lq|))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |lq| (QREFELT $ 31)))))) 

(SDEFUN |PSETCAT-;sort;SVarSetR;10|
        ((|ps| (S)) (|v| (|VarSet|))
         ($ (|Record| (|:| |under| S) (|:| |floor| S) (|:| |upper| S))))
        (SPROG
         ((|ws| (|List| P)) (|vs| (|List| P)) (|us| (|List| P))
          (|lp| (|List| P)) (|p| (P)))
         (SEQ (LETT |lp| (|PSETCAT-;elements| |ps| $)) (LETT |us| NIL)
              (LETT |vs| NIL) (LETT |ws| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                   (SEQ (LETT |p| (|SPADfirst| |lp|)) (LETT |lp| (CDR |lp|))
                        (EXIT
                         (COND
                          ((OR (SPADCALL |p| (QREFELT $ 24))
                               (SPADCALL (SPADCALL |p| (QREFELT $ 22)) |v|
                                         (QREFELT $ 30)))
                           (LETT |us| (CONS |p| |us|)))
                          ((SPADCALL (SPADCALL |p| (QREFELT $ 22)) |v|
                                     (QREFELT $ 28))
                           (LETT |vs| (CONS |p| |vs|)))
                          ('T (LETT |ws| (CONS |p| |ws|))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (VECTOR (SPADCALL |us| (QREFELT $ 31))
                       (SPADCALL |vs| (QREFELT $ 31))
                       (SPADCALL |ws| (QREFELT $ 31))))))) 

(SDEFUN |PSETCAT-;=;2SB;11| ((|ps1| (S)) (|ps2| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G822 NIL) (|p| NIL) (#2=#:G821 NIL) (#3=#:G820 NIL)
          (#4=#:G819 NIL))
         (SEQ
          (SPADCALL
           (SPADCALL
            (PROGN
             (LETT #4# NIL)
             (SEQ (LETT |p| NIL) (LETT #3# (|PSETCAT-;elements| |ps1| $)) G190
                  (COND
                   ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                    (GO G191)))
                  (SEQ (EXIT (LETT #4# (CONS |p| #4#)))) (LETT #3# (CDR #3#))
                  (GO G190) G191 (EXIT (NREVERSE #4#))))
            (QREFELT $ 38))
           (SPADCALL
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |p| NIL) (LETT #1# (|PSETCAT-;elements| |ps2| $)) G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ (EXIT (LETT #2# (CONS |p| #2#)))) (LETT #1# (CDR #1#))
                  (GO G190) G191 (EXIT (NREVERSE #2#))))
            (QREFELT $ 38))
           (QREFELT $ 39))))) 

(SDEFUN |PSETCAT-;localInf?| ((|p| (P)) (|q| (P)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 41)) (SPADCALL |q| (QREFELT $ 41))
                  (QREFELT $ 42))) 

(SDEFUN |PSETCAT-;localTriangular?| ((|lp| (|List| P)) ($ (|Boolean|)))
        (SPROG ((|p| (P)) (|q| (P)))
               (SEQ (LETT |lp| (SPADCALL (ELT $ 43) |lp| (QREFELT $ 26)))
                    (EXIT
                     (COND ((NULL |lp|) 'T)
                           ((SPADCALL (ELT $ 24) |lp| (QREFELT $ 44)) NIL)
                           ('T
                            (SEQ
                             (LETT |lp|
                                   (SPADCALL
                                    (CONS #'|PSETCAT-;localTriangular?!0| $)
                                    |lp| (QREFELT $ 46)))
                             (LETT |p| (|SPADfirst| |lp|))
                             (LETT |lp| (CDR |lp|))
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (COND ((NULL |lp|) NIL)
                                           ('T
                                            (SPADCALL
                                             (SPADCALL |p| (QREFELT $ 22))
                                             (SPADCALL
                                              (LETT |q| (|SPADfirst| |lp|))
                                              (QREFELT $ 22))
                                             (QREFELT $ 16)))))
                                    (GO G191)))
                                  (SEQ (LETT |p| |q|)
                                       (EXIT (LETT |lp| (CDR |lp|))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT (NULL |lp|))))))))) 

(SDEFUN |PSETCAT-;localTriangular?!0| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 22)) (SPADCALL |z2| (QREFELT $ 22))
                  (QREFELT $ 16))) 

(SDEFUN |PSETCAT-;triangular?;SB;14| ((|ps| (S)) ($ (|Boolean|)))
        (|PSETCAT-;localTriangular?| (|PSETCAT-;elements| |ps| $) $)) 

(SDEFUN |PSETCAT-;trivialIdeal?;SB;15| ((|ps| (S)) ($ (|Boolean|)))
        (NULL
         (SPADCALL (ELT $ 43) (|PSETCAT-;elements| |ps| $) (QREFELT $ 26)))) 

(SDEFUN |PSETCAT-;roughUnitIdeal?;SB;16| ((|ps| (S)) ($ (|Boolean|)))
        (SPADCALL (ELT $ 24)
                  (SPADCALL (ELT $ 43) (|PSETCAT-;elements| |ps| $)
                            (QREFELT $ 26))
                  (QREFELT $ 44))) 

(SDEFUN |PSETCAT-;relativelyPrimeLeadingMonomials?|
        ((|p| (P)) (|q| (P)) ($ (|Boolean|)))
        (SPROG ((|dq| (E)) (|dp| (E)))
               (SEQ (LETT |dp| (SPADCALL |p| (QREFELT $ 41)))
                    (LETT |dq| (SPADCALL |q| (QREFELT $ 41)))
                    (EXIT
                     (SPADCALL (SPADCALL |dp| |dq| (QREFELT $ 50))
                               (SPADCALL |dp| |dq| (QREFELT $ 51))
                               (QREFELT $ 52)))))) 

(SDEFUN |PSETCAT-;roughBase?;SB;18| ((|ps| (S)) ($ (|Boolean|)))
        (SPROG
         ((|copylp| (|List| P)) (|rB?| (|Boolean|)) (|lp| (|List| P))
          (|p| (P)))
         (SEQ
          (LETT |lp|
                (SPADCALL (ELT $ 43) (|PSETCAT-;elements| |ps| $)
                          (QREFELT $ 26)))
          (EXIT
           (COND ((NULL |lp|) 'T)
                 ('T
                  (SEQ (LETT |rB?| 'T)
                       (SEQ G190
                            (COND
                             ((NULL (COND ((NULL |lp|) NIL) ('T |rB?|)))
                              (GO G191)))
                            (SEQ (LETT |p| (|SPADfirst| |lp|))
                                 (LETT |lp| (CDR |lp|)) (LETT |copylp| |lp|)
                                 (EXIT
                                  (SEQ G190
                                       (COND
                                        ((NULL
                                          (COND ((NULL |copylp|) NIL)
                                                ('T |rB?|)))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |rB?|
                                              (|PSETCAT-;relativelyPrimeLeadingMonomials?|
                                               |p| (|SPADfirst| |copylp|) $))
                                        (EXIT (LETT |copylp| (CDR |copylp|))))
                                       NIL (GO G190) G191 (EXIT NIL))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |rB?|)))))))) 

(SDEFUN |PSETCAT-;roughSubIdeal?;2SB;19|
        ((|ps1| (S)) (|ps2| (S)) ($ (|Boolean|)))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (LETT |lp|
                      (SPADCALL (|PSETCAT-;elements| |ps1| $) |ps2|
                                (QREFELT $ 54)))
                (EXIT (NULL (SPADCALL (ELT $ 43) |lp| (QREFELT $ 26))))))) 

(SDEFUN |PSETCAT-;roughEqualIdeals?;2SB;20|
        ((|ps1| (S)) (|ps2| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |ps1| |ps2| (QREFELT $ 56)) 'T)
              ((SPADCALL |ps1| |ps2| (QREFELT $ 57))
               (SPADCALL |ps2| |ps1| (QREFELT $ 57)))
              ('T NIL))) 

(SDEFUN |PSETCAT-;iexactQuo;3R;21| ((|r| (R)) (|s| (R)) ($ (R)))
        (SPADCALL |r| |s| (QREFELT $ 59))) 

(SDEFUN |PSETCAT-;iexactQuo;3R;22| ((|r| (R)) (|s| (R)) ($ (R)))
        (SPROG ((#1=#:G865 NIL))
               (PROG2 (LETT #1# (SPADCALL |r| |s| (QREFELT $ 62)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                 (|Union| (QREFELT $ 7) "failed") #1#)))) 

(SDEFUN |PSETCAT-;exactQuo| ((|r| (R)) (|s| (R)) ($ (R)))
        (SPADCALL |r| |s| (QREFELT $ 63))) 

(SDEFUN |PSETCAT-;headRemainder;PSR;24|
        ((|a| (P)) (|ps| (S)) ($ (|Record| (|:| |num| P) (|:| |den| R))))
        (SPROG
         ((|lp2| (|List| P)) (|r| (R)) (|lcp| (R)) (|lca| (R)) (|#G50| (R))
          (|#G49| (R)) (|g| (R)) (|e| (|Union| E "failed")) (|p| (P))
          (|lp1| (|List| P)))
         (SEQ
          (LETT |lp1|
                (SPADCALL (ELT $ 43) (|PSETCAT-;elements| |ps| $)
                          (QREFELT $ 26)))
          (EXIT
           (COND ((NULL |lp1|) (CONS |a| (|spadConstant| $ 64)))
                 ((SPADCALL (ELT $ 24) |lp1| (QREFELT $ 44))
                  (CONS (SPADCALL |a| (QREFELT $ 65)) (|spadConstant| $ 64)))
                 ('T
                  (SEQ (LETT |r| (|spadConstant| $ 64))
                       (LETT |lp1|
                             (SPADCALL
                              (CONS (|function| |PSETCAT-;localInf?|) $)
                              (REVERSE (|PSETCAT-;elements| |ps| $))
                              (QREFELT $ 46)))
                       (LETT |lp2| |lp1|)
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND ((SPADCALL |a| (QREFELT $ 43)) NIL)
                                     ('T (NULL (NULL |lp2|)))))
                              (GO G191)))
                            (SEQ (LETT |p| (|SPADfirst| |lp2|))
                                 (LETT |e|
                                       (SPADCALL (SPADCALL |a| (QREFELT $ 41))
                                                 (SPADCALL |p| (QREFELT $ 41))
                                                 (QREFELT $ 66)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |e| 0)
                                    (SEQ
                                     (LETT |g|
                                           (SPADCALL
                                            (LETT |lca|
                                                  (SPADCALL |a|
                                                            (QREFELT $ 67)))
                                            (LETT |lcp|
                                                  (SPADCALL |p|
                                                            (QREFELT $ 67)))
                                            (QREFELT $ 68)))
                                     (PROGN
                                      (LETT |#G49|
                                            (|PSETCAT-;exactQuo| |lca| |g| $))
                                      (LETT |#G50|
                                            (|PSETCAT-;exactQuo| |lcp| |g| $))
                                      (LETT |lca| |#G49|)
                                      (LETT |lcp| |#G50|))
                                     (LETT |a|
                                           (SPADCALL
                                            (SPADCALL |lcp|
                                                      (SPADCALL |a|
                                                                (QREFELT $ 65))
                                                      (QREFELT $ 69))
                                            (SPADCALL
                                             (SPADCALL |lca| (QCDR |e|)
                                                       (QREFELT $ 70))
                                             (SPADCALL |p| (QREFELT $ 65))
                                             (QREFELT $ 71))
                                            (QREFELT $ 72)))
                                     (LETT |r|
                                           (SPADCALL |r| |lcp| (QREFELT $ 73)))
                                     (EXIT (LETT |lp2| |lp1|))))
                                   ('T (LETT |lp2| (CDR |lp2|))))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (CONS |a| |r|))))))))) 

(SDEFUN |PSETCAT-;makeIrreducible!|
        ((|frac| (|Record| (|:| |num| P) (|:| |den| R)))
         ($ (|Record| (|:| |num| P) (|:| |den| R))))
        (SPROG ((|g| (R)))
               (SEQ
                (LETT |g|
                      (SPADCALL (QCDR |frac|) (QCAR |frac|) (QREFELT $ 76)))
                (EXIT
                 (COND
                  ((SPADCALL |g| (|spadConstant| $ 64) (QREFELT $ 78)) |frac|)
                  ('T
                   (SEQ
                    (PROGN
                     (RPLACA |frac|
                             (SPADCALL (QCAR |frac|) |g| (QREFELT $ 79)))
                     (QCAR |frac|))
                    (PROGN
                     (RPLACD |frac| (|PSETCAT-;exactQuo| (QCDR |frac|) |g| $))
                     (QCDR |frac|))
                    (EXIT |frac|)))))))) 

(SDEFUN |PSETCAT-;remainder;PSR;26|
        ((|a| (P)) (|ps| (S))
         ($ (|Record| (|:| |rnum| R) (|:| |polnum| P) (|:| |den| R))))
        (SPROG
         ((|c| (R)) (|b| (P)) (|g| (R)) (|lca| (R)) (|r| (R))
          (|hRa| (|Record| (|:| |num| P) (|:| |den| R))))
         (SEQ
          (LETT |hRa|
                (|PSETCAT-;makeIrreducible!| (SPADCALL |a| |ps| (QREFELT $ 80))
                 $))
          (LETT |a| (QCAR |hRa|)) (LETT |r| (QCDR |hRa|))
          (EXIT
           (COND
            ((SPADCALL |a| (QREFELT $ 43))
             (VECTOR (|spadConstant| $ 64) |a| |r|))
            ('T
             (SEQ
              (LETT |b|
                    (SPADCALL (|spadConstant| $ 64)
                              (SPADCALL |a| (QREFELT $ 41)) (QREFELT $ 70)))
              (LETT |c| (SPADCALL |a| (QREFELT $ 67)))
              (SEQ G190
                   (COND
                    ((NULL
                      (NULL
                       (SPADCALL (LETT |a| (SPADCALL |a| (QREFELT $ 65)))
                                 (QREFELT $ 43))))
                     (GO G191)))
                   (SEQ
                    (LETT |hRa|
                          (|PSETCAT-;makeIrreducible!|
                           (SPADCALL |a| |ps| (QREFELT $ 80)) $))
                    (LETT |a| (QCAR |hRa|))
                    (LETT |r| (SPADCALL |r| (QCDR |hRa|) (QREFELT $ 73)))
                    (LETT |g|
                          (SPADCALL |c|
                                    (LETT |lca| (SPADCALL |a| (QREFELT $ 67)))
                                    (QREFELT $ 68)))
                    (LETT |b|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (QCDR |hRa|)
                                      (|PSETCAT-;exactQuo| |c| |g| $)
                                      (QREFELT $ 73))
                            |b| (QREFELT $ 69))
                           (SPADCALL (|PSETCAT-;exactQuo| |lca| |g| $)
                                     (SPADCALL |a| (QREFELT $ 41))
                                     (QREFELT $ 70))
                           (QREFELT $ 81)))
                    (EXIT (LETT |c| |g|)))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |c| |b| |r|))))))))) 

(SDEFUN |PSETCAT-;rewriteIdealWithHeadRemainder;LSL;27|
        ((|ps| (|List| P)) (|cs| (S)) ($ (|List| P)))
        (SPROG ((|rs| (|List| P)) (|p| (P)))
               (SEQ
                (COND ((SPADCALL |cs| (QREFELT $ 84)) |ps|)
                      ((SPADCALL |cs| (QREFELT $ 85))
                       (LIST (|spadConstant| $ 86)))
                      (#1='T
                       (SEQ
                        (LETT |ps| (SPADCALL (ELT $ 43) |ps| (QREFELT $ 26)))
                        (EXIT
                         (COND ((NULL |ps|) |ps|)
                               ((SPADCALL (ELT $ 24) |ps| (QREFELT $ 44))
                                (LIST (|spadConstant| $ 77)))
                               (#1#
                                (SEQ (LETT |rs| NIL)
                                     (SEQ G190
                                          (COND
                                           ((NULL (NULL (NULL |ps|)))
                                            (GO G191)))
                                          (SEQ (LETT |p| (|SPADfirst| |ps|))
                                               (LETT |ps| (CDR |ps|))
                                               (LETT |p|
                                                     (QCAR
                                                      (SPADCALL |p| |cs|
                                                                (QREFELT $
                                                                         80))))
                                               (EXIT
                                                (COND
                                                 ((NULL
                                                   (SPADCALL |p|
                                                             (QREFELT $ 43)))
                                                  (COND
                                                   ((SPADCALL |p|
                                                              (QREFELT $ 24))
                                                    (SEQ (LETT |ps| NIL)
                                                         (EXIT
                                                          (LETT |rs|
                                                                (LIST
                                                                 (|spadConstant|
                                                                  $ 77))))))
                                                   ('T
                                                    (SEQ
                                                     (SPADCALL |p|
                                                               (QREFELT $ 87))
                                                     (EXIT
                                                      (LETT |rs|
                                                            (CONS |p|
                                                                  |rs|))))))))))
                                          NIL (GO G190) G191 (EXIT NIL))
                                     (EXIT
                                      (SPADCALL |rs| (QREFELT $ 88))))))))))))) 

(SDEFUN |PSETCAT-;rewriteIdealWithRemainder;LSL;28|
        ((|ps| (|List| P)) (|cs| (S)) ($ (|List| P)))
        (SPROG ((|rs| (|List| P)) (|p| (P)))
               (SEQ
                (COND ((SPADCALL |cs| (QREFELT $ 84)) |ps|)
                      ((SPADCALL |cs| (QREFELT $ 85))
                       (LIST (|spadConstant| $ 86)))
                      (#1='T
                       (SEQ
                        (LETT |ps| (SPADCALL (ELT $ 43) |ps| (QREFELT $ 26)))
                        (EXIT
                         (COND ((NULL |ps|) |ps|)
                               ((SPADCALL (ELT $ 24) |ps| (QREFELT $ 44))
                                (LIST (|spadConstant| $ 77)))
                               (#1#
                                (SEQ (LETT |rs| NIL)
                                     (SEQ G190
                                          (COND
                                           ((NULL (NULL (NULL |ps|)))
                                            (GO G191)))
                                          (SEQ (LETT |p| (|SPADfirst| |ps|))
                                               (LETT |ps| (CDR |ps|))
                                               (LETT |p|
                                                     (QVELT
                                                      (SPADCALL |p| |cs|
                                                                (QREFELT $ 90))
                                                      1))
                                               (EXIT
                                                (COND
                                                 ((NULL
                                                   (SPADCALL |p|
                                                             (QREFELT $ 43)))
                                                  (COND
                                                   ((SPADCALL |p|
                                                              (QREFELT $ 24))
                                                    (SEQ (LETT |ps| NIL)
                                                         (EXIT
                                                          (LETT |rs|
                                                                (LIST
                                                                 (|spadConstant|
                                                                  $ 77))))))
                                                   ('T
                                                    (LETT |rs|
                                                          (CONS
                                                           (SPADCALL |p|
                                                                     (QREFELT $
                                                                              91))
                                                           |rs|))))))))
                                          NIL (GO G190) G191 (EXIT NIL))
                                     (EXIT
                                      (SPADCALL |rs| (QREFELT $ 88))))))))))))) 

(DECLAIM (NOTINLINE |PolynomialSetCategory&;|)) 

(DEFUN |PolynomialSetCategory&| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|PolynomialSetCategory&| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 93))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|IntegralDomain|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 49
                 (CONS (|dispatchFunction| |PSETCAT-;roughUnitIdeal?;SB;16|)
                       $))
       (QSETREFV $ 53
                 (CONS (|dispatchFunction| |PSETCAT-;roughBase?;SB;18|) $))
       (QSETREFV $ 55
                 (CONS (|dispatchFunction| |PSETCAT-;roughSubIdeal?;2SB;19|)
                       $))
       (QSETREFV $ 58
                 (CONS (|dispatchFunction| |PSETCAT-;roughEqualIdeals?;2SB;20|)
                       $)))))
    (COND
     ((|HasCategory| |#2| '(|GcdDomain|))
      (COND
       ((|HasCategory| |#4| '(|ConvertibleTo| (|Symbol|)))
        (PROGN
         (COND
          ((|HasCategory| |#2| '(|EuclideanDomain|))
           (QSETREFV $ 60
                     (CONS (|dispatchFunction| |PSETCAT-;iexactQuo;3R;21|) $)))
          ('T
           (QSETREFV $ 60
                     (CONS (|dispatchFunction| |PSETCAT-;iexactQuo;3R;22|)
                           $))))
         (QSETREFV $ 75
                   (CONS (|dispatchFunction| |PSETCAT-;headRemainder;PSR;24|)
                         $))
         (QSETREFV $ 83
                   (CONS (|dispatchFunction| |PSETCAT-;remainder;PSR;26|) $))
         (QSETREFV $ 89
                   (CONS
                    (|dispatchFunction|
                     |PSETCAT-;rewriteIdealWithHeadRemainder;LSL;27|)
                    $))
         (QSETREFV $ 92
                   (CONS
                    (|dispatchFunction|
                     |PSETCAT-;rewriteIdealWithRemainder;LSL;28|)
                    $)))))))
    $))) 

(MAKEPROP '|PolynomialSetCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|List| 10)
              (0 . |members|) (|List| 9) (5 . |variables|) (|Boolean|) (10 . >)
              (|List| $) (16 . |concat|) (21 . |removeDuplicates|)
              (|Mapping| 15 9 9) (26 . |sort|) (32 . |mvar|)
              |PSETCAT-;variables;SL;4| (37 . |ground?|) (|Mapping| 15 10)
              (42 . |remove|) |PSETCAT-;mainVariables;SL;5| (48 . =)
              |PSETCAT-;mainVariable?;VarSetSB;6| (54 . <) (60 . |construct|)
              |PSETCAT-;collectUnder;SVarSetS;7|
              |PSETCAT-;collectUpper;SVarSetS;8| |PSETCAT-;collect;SVarSetS;9|
              (|Record| (|:| |under| $) (|:| |floor| $) (|:| |upper| $))
              |PSETCAT-;sort;SVarSetR;10| (|Set| 10) (65 . |set|) (70 . =)
              |PSETCAT-;=;2SB;11| (76 . |degree|) (81 . <) (87 . |zero?|)
              (92 . |any?|) (|Mapping| 15 10 10) (98 . |sort|)
              |PSETCAT-;triangular?;SB;14| |PSETCAT-;trivialIdeal?;SB;15|
              (104 . |roughUnitIdeal?|) (109 . |sup|) (115 . +) (121 . =)
              (127 . |roughBase?|) (132 . |rewriteIdealWithRemainder|)
              (138 . |roughSubIdeal?|) (144 . =) (150 . |roughSubIdeal?|)
              (156 . |roughEqualIdeals?|) (162 . |quo|) (168 . |iexactQuo|)
              (|Union| $ '"failed") (174 . |exquo|) (180 . |iexactQuo|)
              (186 . |One|) (190 . |reductum|) (195 . |subtractIfCan|)
              (201 . |leadingCoefficient|) (206 . |gcd|) (212 . *)
              (218 . |monomial|) (224 . *) (230 . -) (236 . *)
              (|Record| (|:| |num| 10) (|:| |den| 7)) (242 . |headRemainder|)
              (248 . |gcd|) (254 . |One|) (258 . =) (264 . |exactQuotient!|)
              (270 . |headRemainder|) (276 . +)
              (|Record| (|:| |rnum| 7) (|:| |polnum| 10) (|:| |den| 7))
              (282 . |remainder|) (288 . |trivialIdeal?|)
              (293 . |roughUnitIdeal?|) (298 . |Zero|) (302 . |primitivePart!|)
              (307 . |removeDuplicates|)
              (312 . |rewriteIdealWithHeadRemainder|) (318 . |remainder|)
              (324 . |unitCanonical|) (329 . |rewriteIdealWithRemainder|))
           '#(|variables| 335 |trivialIdeal?| 340 |triangular?| 345 |sort| 350
              |roughUnitIdeal?| 356 |roughSubIdeal?| 361 |roughEqualIdeals?|
              367 |roughBase?| 373 |rewriteIdealWithRemainder| 378
              |rewriteIdealWithHeadRemainder| 384 |remainder| 390
              |mainVariables| 396 |mainVariable?| 401 |iexactQuo| 407
              |headRemainder| 413 |collectUpper| 419 |collectUnder| 425
              |collect| 431 = 437)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|iexactQuo| (|#2| |#2| |#2|)) T)
                                   '((|triangular?| ((|Boolean|) |#1|)) T)
                                   '((|rewriteIdealWithRemainder|
                                      ((|List| |#5|) (|List| |#5|) |#1|))
                                     T)
                                   '((|rewriteIdealWithHeadRemainder|
                                      ((|List| |#5|) (|List| |#5|) |#1|))
                                     T)
                                   '((|remainder|
                                      ((|Record| (|:| |rnum| |#2|)
                                                 (|:| |polnum| |#5|)
                                                 (|:| |den| |#2|))
                                       |#5| |#1|))
                                     T)
                                   '((|headRemainder|
                                      ((|Record| (|:| |num| |#5|)
                                                 (|:| |den| |#2|))
                                       |#5| |#1|))
                                     T)
                                   '((|roughUnitIdeal?| ((|Boolean|) |#1|)) T)
                                   '((|roughEqualIdeals?|
                                      ((|Boolean|) |#1| |#1|))
                                     T)
                                   '((|roughSubIdeal?| ((|Boolean|) |#1| |#1|))
                                     T)
                                   '((|roughBase?| ((|Boolean|) |#1|)) T)
                                   '((|trivialIdeal?| ((|Boolean|) |#1|)) T)
                                   '((|sort|
                                      ((|Record| (|:| |under| |#1|)
                                                 (|:| |floor| |#1|)
                                                 (|:| |upper| |#1|))
                                       |#1| |#4|))
                                     T)
                                   '((|collectUpper| (|#1| |#1| |#4|)) T)
                                   '((|collect| (|#1| |#1| |#4|)) T)
                                   '((|collectUnder| (|#1| |#1| |#4|)) T)
                                   '((|mainVariable?| ((|Boolean|) |#4| |#1|))
                                     T)
                                   '((|mainVariables| ((|List| |#4|) |#1|)) T)
                                   '((|variables| ((|List| |#4|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 92
                                            '(1 6 11 0 12 1 10 13 0 14 2 9 15 0
                                              0 16 1 13 0 17 18 1 13 0 0 19 2
                                              13 0 20 0 21 1 10 9 0 22 1 10 15
                                              0 24 2 11 0 25 0 26 2 9 15 0 0 28
                                              2 9 15 0 0 30 1 6 0 11 31 1 37 0
                                              11 38 2 37 15 0 0 39 1 10 8 0 41
                                              2 8 15 0 0 42 1 10 15 0 43 2 11
                                              15 25 0 44 2 11 0 45 0 46 1 0 15
                                              0 49 2 8 0 0 0 50 2 8 0 0 0 51 2
                                              8 15 0 0 52 1 0 15 0 53 2 6 11 11
                                              0 54 2 0 15 0 0 55 2 6 15 0 0 56
                                              2 6 15 0 0 57 2 0 15 0 0 58 2 7 0
                                              0 0 59 2 0 7 7 7 60 2 7 61 0 0 62
                                              2 6 7 7 7 63 0 7 0 64 1 10 0 0 65
                                              2 8 61 0 0 66 1 10 7 0 67 2 7 0 0
                                              0 68 2 10 0 7 0 69 2 10 0 7 8 70
                                              2 10 0 0 0 71 2 10 0 0 0 72 2 7 0
                                              0 0 73 2 0 74 10 0 75 2 10 7 7 0
                                              76 0 10 0 77 2 7 15 0 0 78 2 10 0
                                              0 7 79 2 6 74 10 0 80 2 10 0 0 0
                                              81 2 0 82 10 0 83 1 6 15 0 84 1 6
                                              15 0 85 0 10 0 86 1 10 0 0 87 1
                                              11 0 0 88 2 0 11 11 0 89 2 6 82
                                              10 0 90 1 10 0 0 91 2 0 11 11 0
                                              92 1 0 13 0 23 1 0 15 0 48 1 0 15
                                              0 47 2 0 35 0 9 36 1 0 15 0 49 2
                                              0 15 0 0 55 2 0 15 0 0 58 1 0 15
                                              0 53 2 0 11 11 0 92 2 0 11 11 0
                                              89 2 0 82 10 0 83 1 0 13 0 27 2 0
                                              15 9 0 29 2 0 7 7 7 60 2 0 74 10
                                              0 75 2 0 0 0 9 33 2 0 0 0 9 32 2
                                              0 0 0 9 34 2 0 15 0 0 40)))))
           '|lookupComplete|)) 
