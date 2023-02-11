
(SDEFUN |GBEUCLID;euclideanGroebner;2L;1|
        ((|Pol| (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 0 0 $) $)) 

(SDEFUN |GBEUCLID;euclideanGroebner;LSL;2|
        ((|Pol| (|List| |Dpol|)) (|xx1| (|String|)) ($ (|List| |Dpol|)))
        (SEQ
         (COND
          ((EQUAL |xx1| "redcrit")
           (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 1 0 $) $))
          ((EQUAL |xx1| "info")
           (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 2 1 $) $))
          ('T
           (SEQ (SPADCALL (SPADCALL "   " (QREFELT $ 14)) (QREFELT $ 16))
                (SPADCALL
                 (SPADCALL "WARNING: options are - redcrit and/or info - "
                           (QREFELT $ 14))
                 (QREFELT $ 16))
                (SPADCALL
                 (SPADCALL "         you didn't type them correct"
                           (QREFELT $ 14))
                 (QREFELT $ 16))
                (SPADCALL (SPADCALL "         please try again" (QREFELT $ 14))
                          (QREFELT $ 16))
                (SPADCALL (SPADCALL "   " (QREFELT $ 14)) (QREFELT $ 16))
                (EXIT NIL)))))) 

(SDEFUN |GBEUCLID;euclideanGroebner;L2SL;3|
        ((|Pol| (|List| |Dpol|)) (|xx1| (|String|)) (|xx2| (|String|))
         ($ (|List| |Dpol|)))
        (SEQ
         (COND
          ((EQUAL |xx1| "redcrit")
           (COND
            ((EQUAL |xx2| "info")
             (EXIT
              (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 1 1 $) $)))
            ((EQUAL |xx1| #1="info")
             (COND
              ((EQUAL |xx2| #2="redcrit")
               (EXIT
                (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 1 1 $)
                 $)))))))
          ((EQUAL |xx1| #1#)
           (COND
            ((EQUAL |xx2| #2#)
             (EXIT
              (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 1 1 $)
               $))))))
         (COND
          ((EQUAL |xx1| "redcrit")
           (COND
            ((EQUAL |xx2| "redcrit")
             (EXIT
              (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 1 0 $)
               $))))))
         (COND
          ((EQUAL |xx1| "info")
           (COND
            ((EQUAL |xx2| "info")
             (EXIT
              (|GBEUCLID;eminGbasis| (|GBEUCLID;strongGbasis| |Pol| 2 1 $)
               $))))))
         (SPADCALL (SPADCALL "   " (QREFELT $ 14)) (QREFELT $ 16))
         (SPADCALL
          (SPADCALL "WARNING:  options are - redcrit and/or info - "
                    (QREFELT $ 14))
          (QREFELT $ 16))
         (SPADCALL
          (SPADCALL "          you didn't type them correct" (QREFELT $ 14))
          (QREFELT $ 16))
         (SPADCALL (SPADCALL "          please try again " (QREFELT $ 14))
                   (QREFELT $ 16))
         (SPADCALL (SPADCALL "   " (QREFELT $ 14)) (QREFELT $ 16)) (EXIT NIL))) 

(SDEFUN |GBEUCLID;strongGbasis|
        ((|Pol| (|List| |Dpol|)) (|xx1| (|Integer|)) (|xx2| #1=(|Integer|))
         ($ (|List| |Dpol|)))
        (SPROG
         ((|xx| #1#) (H (|List| |Dpol|))
          (D
           (|List|
            #2=(|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                         (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
          (|dd1| (|List| #2#)) (#3=#:G814 NIL) (|x| NIL) (#4=#:G813 NIL)
          (|leh| (|Dom|)) (|e| (|Expon|)) (|eh| (|Dpol|)) (|ep| (|Dpol|))
          (D0
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
          (#5=#:G812 NIL) (#6=#:G811 NIL) (|lch| (|Dom|)) (|en| (|Expon|))
          (|Pol1| (|List| |Dpol|)) (|h| (|Dpol|)))
         (SEQ
          (LETT |Pol1|
                (SPADCALL (CONS #'|GBEUCLID;strongGbasis!0| $) |Pol|
                          (QREFELT $ 26)))
          (LETT |Pol| (LIST (|SPADfirst| |Pol1|))) (LETT H |Pol|)
          (LETT |Pol1| (CDR |Pol1|)) (LETT D NIL)
          (SEQ G190 (COND ((NULL (NULL (NULL |Pol1|))) (GO G191)))
               (SEQ (LETT |h| (|SPADfirst| |Pol1|)) (LETT |Pol1| (CDR |Pol1|))
                    (LETT |en| (SPADCALL |h| (QREFELT $ 19)))
                    (LETT |lch| (SPADCALL |h| (QREFELT $ 23)))
                    (LETT |dd1|
                          (PROGN
                           (LETT #6# NIL)
                           (SEQ (LETT |x| NIL) (LETT #5# |Pol|) G190
                                (COND
                                 ((OR (ATOM #5#)
                                      (PROGN (LETT |x| (CAR #5#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #6#
                                        (CONS
                                         (VECTOR
                                          (SPADCALL
                                           (SPADCALL |x| (QREFELT $ 19)) |en|
                                           (QREFELT $ 27))
                                          (SPADCALL
                                           (SPADCALL |x| (QREFELT $ 23)) |lch|
                                           (QREFELT $ 28))
                                          |x| |h|)
                                         #6#))))
                                (LETT #5# (CDR #5#)) (GO G190) G191
                                (EXIT (NREVERSE #6#)))))
                    (LETT D
                          (|GBEUCLID;updatD|
                           (|GBEUCLID;ecritMTondd1|
                            (SPADCALL (CONS #'|GBEUCLID;strongGbasis!1| $)
                                      |dd1| (QREFELT $ 33))
                            $)
                           (|GBEUCLID;ecritBonD| |h| D $) $))
                    (LETT |Pol| (CONS |h| (|GBEUCLID;eupdatF| |h| |Pol| $)))
                    (COND
                     ((SPADCALL |en| (SPADCALL (|SPADfirst| H) (QREFELT $ 19))
                                (QREFELT $ 22))
                      (COND
                       ((SPADCALL (SPADCALL |h| (QREFELT $ 23))
                                  (SPADCALL (|SPADfirst| H) (QREFELT $ 23))
                                  (QREFELT $ 34))
                        (EXIT " go to top of while ")))))
                    (LETT H
                          (|GBEUCLID;updatH| |h| H
                           (|GBEUCLID;crithdelH| |h| H $) (LIST |h|) $))
                    (EXIT
                     (LETT H
                           (SPADCALL (CONS #'|GBEUCLID;strongGbasis!2| $) H
                                     (QREFELT $ 26)))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT D
                (SPADCALL (CONS #'|GBEUCLID;strongGbasis!3| $) D
                          (QREFELT $ 33)))
          (LETT |xx| |xx2|)
          (SEQ G190 (COND ((NULL (NULL (NULL D))) (GO G191)))
               (SEQ (LETT D0 (|SPADfirst| D))
                    (LETT |ep| (|GBEUCLID;esPol| D0 $)) (LETT D (CDR D))
                    (LETT |eh|
                          (|GBEUCLID;ecredPol| (|GBEUCLID;eRed| |ep| H H $) H
                           $))
                    (COND ((EQL |xx1| 1) (|GBEUCLID;prinshINFO| |eh| $)))
                    (EXIT
                     (COND
                      ((SPADCALL |eh| (|spadConstant| $ 39) (QREFELT $ 40))
                       (SEQ
                        (COND
                         ((EQL |xx2| 1)
                          (SEQ
                           (|GBEUCLID;prindINFO| D0 |ep| |eh| (LENGTH H)
                            (LENGTH D) |xx| $)
                           (EXIT (LETT |xx| 2)))))
                        (EXIT " go to top of while ")))
                      ('T
                       (SEQ (LETT |eh| (SPADCALL |eh| (QREFELT $ 41)))
                            (LETT |e| (SPADCALL |eh| (QREFELT $ 19)))
                            (LETT |leh| (SPADCALL |eh| (QREFELT $ 23)))
                            (LETT |dd1|
                                  (PROGN
                                   (LETT #4# NIL)
                                   (SEQ (LETT |x| NIL) (LETT #3# |Pol|) G190
                                        (COND
                                         ((OR (ATOM #3#)
                                              (PROGN (LETT |x| (CAR #3#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #4#
                                                (CONS
                                                 (VECTOR
                                                  (SPADCALL
                                                   (SPADCALL |x|
                                                             (QREFELT $ 19))
                                                   |e| (QREFELT $ 27))
                                                  (SPADCALL
                                                   (SPADCALL |x|
                                                             (QREFELT $ 23))
                                                   |leh| (QREFELT $ 28))
                                                  |x| |eh|)
                                                 #4#))))
                                        (LETT #3# (CDR #3#)) (GO G190) G191
                                        (EXIT (NREVERSE #4#)))))
                            (LETT D
                                  (|GBEUCLID;updatD|
                                   (|GBEUCLID;ecritMTondd1|
                                    (SPADCALL
                                     (CONS #'|GBEUCLID;strongGbasis!4| $) |dd1|
                                     (QREFELT $ 33))
                                    $)
                                   (|GBEUCLID;ecritBonD| |eh| D $) $))
                            (LETT |Pol|
                                  (CONS |eh|
                                        (|GBEUCLID;eupdatF| |eh| |Pol| $)))
                            (COND
                             ((|GBEUCLID;ecrithinH| |eh| H $)
                              (COND
                               ((SPADCALL |e|
                                          (SPADCALL (|SPADfirst| H)
                                                    (QREFELT $ 19))
                                          (QREFELT $ 22))
                                (COND
                                 ((SPADCALL (SPADCALL |eh| (QREFELT $ 23))
                                            (SPADCALL (|SPADfirst| H)
                                                      (QREFELT $ 23))
                                            (QREFELT $ 34))
                                  (EXIT
                                   (SEQ
                                    (COND
                                     ((EQL |xx2| 1)
                                      (SEQ
                                       (|GBEUCLID;prindINFO| D0 |ep| |eh|
                                        (LENGTH H) (LENGTH D) |xx| $)
                                       (EXIT (LETT |xx| 2)))))
                                    (EXIT #7=" go to top of while "))))))))
                             ('T
                              (EXIT
                               (SEQ
                                (COND
                                 ((EQL |xx2| 1)
                                  (SEQ
                                   (|GBEUCLID;prindINFO| D0 |ep| |eh|
                                    (LENGTH H) (LENGTH D) |xx| $)
                                   (EXIT (LETT |xx| 2)))))
                                (EXIT #7#)))))
                            (LETT H
                                  (|GBEUCLID;updatH| |eh| H
                                   (|GBEUCLID;crithdelH| |eh| H $) (LIST |eh|)
                                   $))
                            (LETT H
                                  (SPADCALL
                                   (CONS #'|GBEUCLID;strongGbasis!5| $) H
                                   (QREFELT $ 26)))
                            (EXIT
                             (COND
                              ((EQL |xx2| 1)
                               (SEQ
                                (|GBEUCLID;prindINFO| D0 |ep| |eh| (LENGTH H)
                                 (LENGTH D) |xx| $)
                                (LETT |xx| 2)
                                (EXIT " go to top of while "))))))))))
               NIL (GO G190) G191 (EXIT NIL))
          (COND
           ((EQL |xx2| 1)
            (SEQ (|GBEUCLID;prinpolINFO| |Pol| $)
                 (EXIT
                  (SPADCALL
                   (SPADCALL "    THE GROEBNER BASIS over EUCLIDEAN DOMAIN"
                             (QREFELT $ 42))
                   (QREFELT $ 16))))))
          (COND
           ((EQL |xx1| 1)
            (COND
             ((SPADCALL |xx2| 1 (QREFELT $ 44))
              (SPADCALL
               (SPADCALL "    THE GROEBNER BASIS over EUCLIDEAN DOMAIN"
                         (QREFELT $ 42))
               (QREFELT $ 16))))))
          (EXIT H)))) 

(SDEFUN |GBEUCLID;strongGbasis!5| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (COND
         ((SPADCALL (SPADCALL |z1| (QREFELT $ 19))
                    (SPADCALL |z2| (QREFELT $ 19)) (QREFELT $ 21))
          'T)
         ((SPADCALL (SPADCALL |z1| (QREFELT $ 19))
                    (SPADCALL |z2| (QREFELT $ 19)) (QREFELT $ 22))
          (SPADCALL (SPADCALL |z2| (QREFELT $ 23))
                    (SPADCALL |z1| (QREFELT $ 23)) (QREFELT $ 24)))
         ('T NIL))) 

(SDEFUN |GBEUCLID;strongGbasis!4| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (COND ((SPADCALL (QVELT |z1| 0) (QVELT |z2| 0) (QREFELT $ 29)) 'T)
              ((SPADCALL (QVELT |z1| 0) (QVELT |z2| 0) (QREFELT $ 22))
               (SPADCALL (QVELT |z1| 1) (QVELT |z2| 1) (QREFELT $ 24)))
              ('T NIL))) 

(SDEFUN |GBEUCLID;strongGbasis!3| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (COND ((SPADCALL (QVELT |z1| 0) (QVELT |z2| 0) (QREFELT $ 29)) 'T)
              ((SPADCALL (QVELT |z1| 0) (QVELT |z2| 0) (QREFELT $ 22))
               (SPADCALL (QVELT |z1| 1) (QVELT |z2| 1) (QREFELT $ 24)))
              ('T NIL))) 

(SDEFUN |GBEUCLID;strongGbasis!2| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (COND
         ((SPADCALL (SPADCALL |z1| (QREFELT $ 19))
                    (SPADCALL |z2| (QREFELT $ 19)) (QREFELT $ 21))
          'T)
         ((SPADCALL (SPADCALL |z1| (QREFELT $ 19))
                    (SPADCALL |z2| (QREFELT $ 19)) (QREFELT $ 22))
          (SPADCALL (SPADCALL |z2| (QREFELT $ 23))
                    (SPADCALL |z1| (QREFELT $ 23)) (QREFELT $ 24)))
         ('T NIL))) 

(SDEFUN |GBEUCLID;strongGbasis!1| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (COND ((SPADCALL (QVELT |z1| 0) (QVELT |z2| 0) (QREFELT $ 29)) 'T)
              ((SPADCALL (QVELT |z1| 0) (QVELT |z2| 0) (QREFELT $ 22))
               (SPADCALL (QVELT |z1| 1) (QVELT |z2| 1) (QREFELT $ 24)))
              ('T NIL))) 

(SDEFUN |GBEUCLID;strongGbasis!0| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (COND
         ((SPADCALL (SPADCALL |z1| (QREFELT $ 19))
                    (SPADCALL |z2| (QREFELT $ 19)) (QREFELT $ 21))
          'T)
         ((SPADCALL (SPADCALL |z1| (QREFELT $ 19))
                    (SPADCALL |z2| (QREFELT $ 19)) (QREFELT $ 22))
          (SPADCALL (SPADCALL |z2| (QREFELT $ 23))
                    (SPADCALL |z1| (QREFELT $ 23)) (QREFELT $ 24)))
         ('T NIL))) 

(SDEFUN |GBEUCLID;ecritMondd1|
        ((|e| (|Expon|)) (|c| (|Dom|))
         (D2
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))))
        (SPROG
         ((|x|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         (SEQ
          (COND ((NULL D2) NIL)
                (#1='T
                 (SEQ (LETT |x| (|SPADfirst| D2))
                      (EXIT
                       (COND
                        ((|GBEUCLID;ecritM| |e| |c| (QVELT |x| 0)
                          (SPADCALL (SPADCALL (QVELT |x| 2) (QREFELT $ 23))
                                    (SPADCALL (QVELT |x| 3) (QREFELT $ 23))
                                    (QREFELT $ 28))
                          $)
                         (|GBEUCLID;ecritMondd1| |e| |c| (CDR D2) $))
                        (#1#
                         (CONS |x|
                               (|GBEUCLID;ecritMondd1| |e| |c| (CDR D2)
                                $))))))))))) 

(SDEFUN |GBEUCLID;ecredPol| ((|h| (|Dpol|)) (F (|List| |Dpol|)) ($ (|Dpol|)))
        (SPROG ((|h0| (|Dpol|)))
               (SEQ (LETT |h0| (|spadConstant| $ 39))
                    (EXIT
                     (COND ((NULL F) |h|)
                           ('T
                            (SEQ
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (SPADCALL |h| (|spadConstant| $ 39)
                                               (QREFELT $ 45)))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |h0|
                                         (SPADCALL |h0|
                                                   (SPADCALL
                                                    (SPADCALL |h|
                                                              (QREFELT $ 23))
                                                    (SPADCALL |h|
                                                              (QREFELT $ 19))
                                                    (QREFELT $ 46))
                                                   (QREFELT $ 47)))
                                   (EXIT
                                    (LETT |h|
                                          (|GBEUCLID;eRed|
                                           (SPADCALL |h| (QREFELT $ 48)) F F
                                           $))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT |h0|)))))))) 

(SDEFUN |GBEUCLID;ecritMTondd1|
        ((|dd1|
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))))
        (SPROG
         ((|f2|
           #1=(|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                        (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
          (|r1|
           (|List|
            (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                      (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
          (|e1| (|Expon|)) (|cT1| (|Boolean|)) (|s1| (|NonNegativeInteger|))
          (|f1| #1#))
         (SEQ
          (COND ((NULL |dd1|) NIL)
                (#2='T
                 (SEQ (LETT |f1| (|SPADfirst| |dd1|))
                      (LETT |s1| (LENGTH |dd1|))
                      (LETT |cT1| (|GBEUCLID;ecritT| |f1| $))
                      (COND ((EQL |s1| 1) (COND (|cT1| (EXIT NIL)))))
                      (EXIT
                       (COND ((EQL |s1| 1) |dd1|)
                             (#2#
                              (SEQ (LETT |e1| (QVELT |f1| 0))
                                   (LETT |r1| (CDR |dd1|))
                                   (LETT |f2| (|SPADfirst| |r1|))
                                   (COND
                                    ((SPADCALL |e1| (QVELT |f2| 0)
                                               (QREFELT $ 22))
                                     (COND
                                      ((SPADCALL (QVELT |f1| 1) (QVELT |f2| 1)
                                                 (QREFELT $ 34))
                                       (EXIT
                                        (COND
                                         (|cT1|
                                          (|GBEUCLID;ecritMTondd1|
                                           (CONS |f1| (CDR |r1|)) $))
                                         (#2#
                                          (|GBEUCLID;ecritMTondd1| |r1|
                                           $))))))))
                                   (LETT |dd1|
                                         (|GBEUCLID;ecritMondd1| |e1|
                                          (QVELT |f1| 1) |r1| $))
                                   (EXIT
                                    (COND
                                     (|cT1| (|GBEUCLID;ecritMTondd1| |dd1| $))
                                     (#2#
                                      (CONS |f1|
                                            (|GBEUCLID;ecritMTondd1| |dd1|
                                             $))))))))))))))) 

(SDEFUN |GBEUCLID;ecritBonD|
        ((|h| (|Dpol|))
         (D
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))))
        (SPROG
         ((|x2| (|Dpol|)) (|x1| (|Dpol|))
          (|x|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         (SEQ
          (COND ((NULL D) NIL)
                (#1='T
                 (SEQ (LETT |x| (|SPADfirst| D)) (LETT |x1| (QVELT |x| 2))
                      (LETT |x2| (QVELT |x| 3))
                      (EXIT
                       (COND
                        ((|GBEUCLID;ecritB| (SPADCALL |h| (QREFELT $ 19))
                          (SPADCALL |h| (QREFELT $ 23))
                          (SPADCALL |x1| (QREFELT $ 19))
                          (SPADCALL |x1| (QREFELT $ 23))
                          (SPADCALL |x2| (QREFELT $ 19))
                          (SPADCALL |x2| (QREFELT $ 23)) $)
                         (|GBEUCLID;ecritBonD| |h| (CDR D) $))
                        (#1#
                         (CONS |x|
                               (|GBEUCLID;ecritBonD| |h| (CDR D) $))))))))))) 

(SDEFUN |GBEUCLID;eupdatF|
        ((|h| (|Dpol|)) (F (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (SPROG ((|f1| (|Dpol|)))
               (SEQ
                (COND ((NULL F) NIL)
                      (#1='T
                       (SEQ (LETT |f1| (|SPADfirst| F))
                            (EXIT
                             (COND
                              ((|GBEUCLID;ecritM| (SPADCALL |h| (QREFELT $ 19))
                                (SPADCALL |h| (QREFELT $ 23))
                                (SPADCALL |f1| (QREFELT $ 19))
                                (SPADCALL |f1| (QREFELT $ 23)) $)
                               (|GBEUCLID;eupdatF| |h| (CDR F) $))
                              (#1#
                               (CONS |f1|
                                     (|GBEUCLID;eupdatF| |h| (CDR F)
                                      $))))))))))) 

(SDEFUN |GBEUCLID;updatH|
        ((|h| (|Dpol|)) (H (|List| |Dpol|)) (|Hh| (|List| |Dpol|))
         (|Hhh| (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (SPROG
         ((|hp| (|Dpol|)) (|hpp| (|List| |Dpol|)) (#1=#:G842 NIL)
          (|plc|
           (|Record| (|:| |coef1| |Dom|) (|:| |coef2| |Dom|)
                     (|:| |generator| |Dom|)))
          (|hlcm| (|Expon|)) (|h1| (|Dpol|)))
         (SEQ
          (COND ((NULL H) (SPADCALL |Hh| |Hhh| (QREFELT $ 49)))
                ('T
                 (SEQ (LETT |h1| (|SPADfirst| H))
                      (LETT |hlcm|
                            (SPADCALL (SPADCALL |h1| (QREFELT $ 19))
                                      (SPADCALL |h| (QREFELT $ 19))
                                      (QREFELT $ 27)))
                      (LETT |plc|
                            (SPADCALL (SPADCALL |h| (QREFELT $ 23))
                                      (SPADCALL |h1| (QREFELT $ 23))
                                      (QREFELT $ 51)))
                      (LETT |hp|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (QVELT |plc| 0)
                                        (PROG2
                                            (LETT #1#
                                                  (SPADCALL |hlcm|
                                                            (SPADCALL |h|
                                                                      (QREFELT
                                                                       $ 19))
                                                            (QREFELT $ 53)))
                                            (QCDR #1#)
                                          (|check_union2| (QEQCAR #1# 0)
                                                          (QREFELT $ 7)
                                                          (|Union|
                                                           (QREFELT $ 7)
                                                           #2="failed")
                                                          #1#))
                                        (QREFELT $ 46))
                              |h| (QREFELT $ 54))
                             (SPADCALL
                              (SPADCALL (QVELT |plc| 1)
                                        (PROG2
                                            (LETT #1#
                                                  (SPADCALL |hlcm|
                                                            (SPADCALL |h1|
                                                                      (QREFELT
                                                                       $ 19))
                                                            (QREFELT $ 53)))
                                            (QCDR #1#)
                                          (|check_union2| (QEQCAR #1# 0)
                                                          (QREFELT $ 7)
                                                          (|Union|
                                                           (QREFELT $ 7) #2#)
                                                          #1#))
                                        (QREFELT $ 46))
                              |h1| (QREFELT $ 54))
                             (QREFELT $ 47)))
                      (COND
                       ((|GBEUCLID;ecrithinH| |hp| |Hh| $)
                        (COND
                         ((|GBEUCLID;ecrithinH| |hp| |Hhh| $)
                          (EXIT
                           (SEQ
                            (LETT |hpp| (SPADCALL (CDR H) |Hh| (QREFELT $ 49)))
                            (LETT |hp|
                                  (|GBEUCLID;ecredPol|
                                   (|GBEUCLID;eRed| |hp| |hpp| |hpp| $) |hpp|
                                   $))
                            (EXIT
                             (|GBEUCLID;updatH| |h| (CDR H)
                              (|GBEUCLID;crithdelH| |hp| |Hh| $)
                              (CONS |hp| (|GBEUCLID;crithdelH| |hp| |Hhh| $))
                              $))))))))
                      (EXIT (|GBEUCLID;updatH| |h| (CDR H) |Hh| |Hhh| $)))))))) 

(SDEFUN |GBEUCLID;crithdelH|
        ((|h| (|Dpol|)) (H (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (SPROG
         ((#1=#:G852 NIL)
          (|plc|
           (|Record| (|:| |coef1| |Dom|) (|:| |coef2| |Dom|)
                     (|:| |generator| |Dom|)))
          (|dh| (|Expon|)) (|dh1| (|Expon|)) (|h1| (|Dpol|)))
         (SEQ
          (COND ((NULL H) NIL)
                (#2='T
                 (SEQ (LETT |h1| (|SPADfirst| H))
                      (LETT |dh1| (SPADCALL |h1| (QREFELT $ 19)))
                      (LETT |dh| (SPADCALL |h| (QREFELT $ 19)))
                      (EXIT
                       (COND
                        ((|GBEUCLID;ecritM| |dh| (SPADCALL |h| (QREFELT $ 23))
                          |dh1| (SPADCALL |h1| (QREFELT $ 23)) $)
                         (|GBEUCLID;crithdelH| |h| (CDR H) $))
                        ((SPADCALL |dh1| (SPADCALL |dh| |dh1| (QREFELT $ 27))
                                   (QREFELT $ 22))
                         (SEQ
                          (LETT |plc|
                                (SPADCALL (SPADCALL |h1| (QREFELT $ 23))
                                          (SPADCALL |h| (QREFELT $ 23))
                                          (QREFELT $ 51)))
                          (EXIT
                           (CONS
                            (SPADCALL
                             (SPADCALL (QVELT |plc| 0) |h1| (QREFELT $ 55))
                             (SPADCALL
                              (SPADCALL (QVELT |plc| 1)
                                        (PROG2
                                            (LETT #1#
                                                  (SPADCALL |dh1| |dh|
                                                            (QREFELT $ 53)))
                                            (QCDR #1#)
                                          (|check_union2| (QEQCAR #1# 0)
                                                          (QREFELT $ 7)
                                                          (|Union|
                                                           (QREFELT $ 7)
                                                           "failed")
                                                          #1#))
                                        (QREFELT $ 46))
                              |h| (QREFELT $ 54))
                             (QREFELT $ 47))
                            (|GBEUCLID;crithdelH| |h| (CDR H) $)))))
                        (#2#
                         (CONS |h1|
                               (|GBEUCLID;crithdelH| |h| (CDR H) $))))))))))) 

(SDEFUN |GBEUCLID;eminGbasis| ((F (|List| |Dpol|)) ($ #1=(|List| |Dpol|)))
        (SPROG ((|newbas| #1#))
               (SEQ
                (COND ((NULL F) NIL)
                      ('T
                       (SEQ (LETT |newbas| (|GBEUCLID;eminGbasis| (CDR F) $))
                            (EXIT
                             (CONS
                              (|GBEUCLID;ecredPol| (|SPADfirst| F) |newbas| $)
                              |newbas|)))))))) 

(SDEFUN |GBEUCLID;ecrithinH|
        ((|h| (|Dpol|)) (H (|List| |Dpol|)) ($ (|Boolean|)))
        (SPROG ((|h1| (|Dpol|)))
               (SEQ
                (COND ((NULL H) 'T)
                      (#1='T
                       (SEQ (LETT |h1| (|SPADfirst| H))
                            (EXIT
                             (COND
                              ((|GBEUCLID;ecritM|
                                (SPADCALL |h1| (QREFELT $ 19))
                                (SPADCALL |h1| (QREFELT $ 23))
                                (SPADCALL |h| (QREFELT $ 19))
                                (SPADCALL |h| (QREFELT $ 23)) $)
                               NIL)
                              (#1# (|GBEUCLID;ecrithinH| |h| (CDR H) $)))))))))) 

(SDEFUN |GBEUCLID;esPol|
        ((|p|
          (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                    (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
         ($ (|Dpol|)))
        (SPROG
         ((#1=#:G869 NIL) (#2=#:G866 NIL) (|lij| (|Dom|)) (|fj| (|Dpol|))
          (|fi| (|Dpol|)) (|Tij| (|Expon|)))
         (SEQ (LETT |Tij| (QVELT |p| 0)) (LETT |fi| (QVELT |p| 2))
              (LETT |fj| (QVELT |p| 3))
              (LETT |lij|
                    (SPADCALL (SPADCALL |fi| (QREFELT $ 23))
                              (SPADCALL |fj| (QREFELT $ 23)) (QREFELT $ 28)))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |fi| (QREFELT $ 48))
                          (SPADCALL
                           (PROG2
                               (LETT #2#
                                     (SPADCALL |lij|
                                               (SPADCALL |fi| (QREFELT $ 23))
                                               (QREFELT $ 56)))
                               (QCDR #2#)
                             (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                             (|Union| (QREFELT $ 6)
                                                      #3="failed")
                                             #2#))
                           (PROG2
                               (LETT #1#
                                     (SPADCALL |Tij|
                                               (SPADCALL |fi| (QREFELT $ 19))
                                               (QREFELT $ 53)))
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                             (|Union| (QREFELT $ 7)
                                                      #4="failed")
                                             #1#))
                           (QREFELT $ 46))
                          (QREFELT $ 54))
                (SPADCALL (SPADCALL |fj| (QREFELT $ 48))
                          (SPADCALL
                           (PROG2
                               (LETT #2#
                                     (SPADCALL |lij|
                                               (SPADCALL |fj| (QREFELT $ 23))
                                               (QREFELT $ 56)))
                               (QCDR #2#)
                             (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                             (|Union| (QREFELT $ 6) #3#) #2#))
                           (PROG2
                               (LETT #1#
                                     (SPADCALL |Tij|
                                               (SPADCALL |fj| (QREFELT $ 19))
                                               (QREFELT $ 53)))
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                             (|Union| (QREFELT $ 7) #4#) #1#))
                           (QREFELT $ 46))
                          (QREFELT $ 54))
                (QREFELT $ 57)))))) 

(SDEFUN |GBEUCLID;eRed|
        ((|s| (|Dpol|)) (H (|List| |Dpol|)) (|Hh| (|List| |Dpol|))
         ($ (|Dpol|)))
        (SPROG
         ((|q1| (|Dom|))
          (|sdf1| (|Record| (|:| |quotient| |Dom|) (|:| |remainder| |Dom|)))
          (#1=#:G882 NIL) (|e| (|Union| |Expon| "failed")) (|ls| (|Dom|))
          (|lf1| (|Dom|)) (|ds| (|Expon|)) (|f1| (|Dpol|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL |s| (|spadConstant| $ 39) (QREFELT $ 40)) (NULL H))
             |s|)
            ('T
             (SEQ (LETT |f1| (|SPADfirst| H))
                  (LETT |ds| (SPADCALL |s| (QREFELT $ 19)))
                  (LETT |lf1| (SPADCALL |f1| (QREFELT $ 23)))
                  (LETT |ls| (SPADCALL |s| (QREFELT $ 23)))
                  (SEQ
                   (LETT |e|
                         (SPADCALL |ds| (SPADCALL |f1| (QREFELT $ 19))
                                   (QREFELT $ 53)))
                   (EXIT
                    (COND
                     ((OR (QEQCAR |e| 1) (SPADCALL |ls| |lf1| (QREFELT $ 24)))
                      (PROGN
                       (LETT #1# (|GBEUCLID;eRed| |s| (CDR H) |Hh| $))
                       (GO #2=#:G880))))))
                  (LETT |sdf1| (SPADCALL |ls| |lf1| (QREFELT $ 59)))
                  (LETT |q1| (QCAR |sdf1|))
                  (EXIT
                   (COND
                    ((SPADCALL (QCDR |sdf1|) (|spadConstant| $ 37)
                               (QREFELT $ 34))
                     (|GBEUCLID;eRed|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 48))
                                (SPADCALL
                                 (SPADCALL |q1| (QCDR |e|) (QREFELT $ 46))
                                 (SPADCALL |f1| (QREFELT $ 48)) (QREFELT $ 54))
                                (QREFELT $ 57))
                      |Hh| |Hh| $))
                    ('T
                     (|GBEUCLID;eRed|
                      (SPADCALL |s|
                                (SPADCALL
                                 (SPADCALL |q1| (QCDR |e|) (QREFELT $ 46)) |f1|
                                 (QREFELT $ 54))
                                (QREFELT $ 57))
                      (CDR H) |Hh| $))))))))
          #2# (EXIT #1#)))) 

(SDEFUN |GBEUCLID;ecritT|
        ((|p|
          (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                    (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
         ($ (|Boolean|)))
        (SPROG ((|cj| (|Dom|)) (|ci| (|Dom|)) (|pj| (|Dpol|)) (|pi| (|Dpol|)))
               (SEQ (LETT |pi| (QVELT |p| 2)) (LETT |pj| (QVELT |p| 3))
                    (LETT |ci| (SPADCALL |pi| (QREFELT $ 23)))
                    (LETT |cj| (SPADCALL |pj| (QREFELT $ 23)))
                    (EXIT
                     (COND
                      ((SPADCALL (QVELT |p| 0)
                                 (SPADCALL (SPADCALL |pi| (QREFELT $ 19))
                                           (SPADCALL |pj| (QREFELT $ 19))
                                           (QREFELT $ 60))
                                 (QREFELT $ 22))
                       (SPADCALL (QVELT |p| 1)
                                 (SPADCALL |ci| |cj| (QREFELT $ 61))
                                 (QREFELT $ 34)))
                      ('T NIL)))))) 

(SDEFUN |GBEUCLID;ecritM|
        ((|e1| (|Expon|)) (|c1| (|Dom|)) (|e2| (|Expon|)) (|c2| (|Dom|))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G895 NIL) (|en| (|Union| |Expon| "failed")))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |en| (SPADCALL |e2| |e1| (QREFELT $ 53)))
                       (EXIT
                        (COND
                         ((OR (QEQCAR |en| 1)
                              (QEQCAR (SPADCALL |c2| |c1| (QREFELT $ 56)) 1))
                          (PROGN (LETT #1# NIL) (GO #2=#:G893))))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |GBEUCLID;ecritB|
        ((|eh| (|Expon|)) (|ch| (|Dom|)) (|ei| (|Expon|)) (|ci| (|Dom|))
         (|ek| (|Expon|)) (|ck| (|Dom|)) ($ (|Boolean|)))
        (SPROG ((|cik| (|Dom|)) (|eik| (|Expon|)))
               (SEQ (LETT |eik| (SPADCALL |ei| |ek| (QREFELT $ 27)))
                    (LETT |cik| (SPADCALL |ci| |ck| (QREFELT $ 28)))
                    (EXIT
                     (COND
                      ((|GBEUCLID;ecritM| |eh| |ch| |eik| |cik| $)
                       (COND
                        ((|GBEUCLID;ecritM| |eik| |cik|
                          (SPADCALL |ei| |eh| (QREFELT $ 27))
                          (SPADCALL |ci| |ch| (QREFELT $ 28)) $)
                         NIL)
                        (#1='T
                         (NULL
                          (|GBEUCLID;ecritM| |eik| |cik|
                           (SPADCALL |ek| |eh| (QREFELT $ 27))
                           (SPADCALL |ck| |ch| (QREFELT $ 28)) $)))))
                      (#1# NIL)))))) 

(SDEFUN |GBEUCLID;euclideanNormalForm;DpolLDpol;19|
        ((|p1| (|Dpol|)) (|lp| (|List| |Dpol|)) ($ (|Dpol|)))
        (|GBEUCLID;eRed| |p1| |lp| |lp| $)) 

(SDEFUN |GBEUCLID;sortin|
        ((|p1| (|Dpol|)) (|lp| (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (SPROG ((|ep1| (|Expon|)) (|elf1| (|Expon|)) (|f1| (|Dpol|)))
               (SEQ
                (COND ((NULL |lp|) (LIST |p1|))
                      ('T
                       (SEQ (LETT |f1| (|SPADfirst| |lp|))
                            (LETT |elf1| (SPADCALL |f1| (QREFELT $ 19)))
                            (LETT |ep1| (SPADCALL |p1| (QREFELT $ 19)))
                            (COND
                             ((SPADCALL |elf1| |ep1| (QREFELT $ 29))
                              (EXIT
                               (CONS |f1|
                                     (|GBEUCLID;sortin| |p1| (CDR |lp|) $))))
                             ((SPADCALL |elf1| |ep1| (QREFELT $ 22))
                              (COND
                               ((SPADCALL (SPADCALL |f1| (QREFELT $ 23))
                                          (SPADCALL |p1| (QREFELT $ 23))
                                          (QREFELT $ 24))
                                (EXIT
                                 (CONS |f1|
                                       (|GBEUCLID;sortin| |p1| (CDR |lp|)
                                        $)))))))
                            (EXIT (CONS |p1| |lp|)))))))) 

(SDEFUN |GBEUCLID;updatD|
        ((D1
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         (D2
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                     (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))))
        (SPROG
         ((|dl2|
           #1=(|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                        (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
          (|dl1| #1#))
         (SEQ
          (COND ((NULL D1) D2) ((NULL D2) D1)
                (#2='T
                 (SEQ (LETT |dl1| (|SPADfirst| D1))
                      (LETT |dl2| (|SPADfirst| D2))
                      (EXIT
                       (COND
                        ((SPADCALL (QVELT |dl1| 0) (QVELT |dl2| 0)
                                   (QREFELT $ 29))
                         (CONS |dl1| (|GBEUCLID;updatD| (CDR D1) D2 $)))
                        (#2#
                         (CONS |dl2| (|GBEUCLID;updatD| D1 (CDR D2) $))))))))))) 

(SDEFUN |GBEUCLID;lepol| ((|p1| (|Dpol|)) ($ (|Integer|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| 0)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p1| (|spadConstant| $ 39)
                                      (QREFELT $ 45)))
                           (GO G191)))
                         (SEQ (LETT |n| (+ |n| 1))
                              (EXIT
                               (LETT |p1| (SPADCALL |p1| (QREFELT $ 48)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |n|)))) 

(SDEFUN |GBEUCLID;prinb| ((|n| (|Integer|)) ($ (|Void|)))
        (SPROG ((#1=#:G917 NIL) (|i| NIL))
               (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                    (SEQ (EXIT (SPADCALL "    " (QREFELT $ 63))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |GBEUCLID;prinshINFO| ((|h| (|Dpol|)) ($ (|Void|)))
        (SEQ (|GBEUCLID;prinb| 2 $)
             (SPADCALL " reduced Critpair - Polynom :" (QREFELT $ 63))
             (|GBEUCLID;prinb| 2 $)
             (SPADCALL (SPADCALL |h| (QREFELT $ 64)) (QREFELT $ 16))
             (EXIT (|GBEUCLID;prinb| 2 $)))) 

(SDEFUN |GBEUCLID;prindINFO|
        ((|cp|
          (|Record| (|:| |lcmfij| |Expon|) (|:| |lcmcij| |Dom|)
                    (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
         (|ps| (|Dpol|)) (|ph| (|Dpol|)) (|i1| (|Integer|)) (|i2| (|Integer|))
         (|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|ll|
           (|List|
            (|Record| (|:| |ci| |Dpol|) (|:| |tci| (|Integer|))
                      (|:| |cj| |Dpol|) (|:| |tcj| (|Integer|))
                      (|:| |c| |Dpol|) (|:| |tc| (|Integer|)) (|:| |rc| |Dpol|)
                      (|:| |trc| (|Integer|)) (|:| |tH| (|Integer|))
                      (|:| |tD| (|Integer|)))))
          (|a| (|Dom|)) (|cpj| (|Dpol|)) (|cpi| (|Dpol|)))
         (SEQ (LETT |cpi| (QVELT |cp| 2)) (LETT |cpj| (QVELT |cp| 3))
              (COND
               ((EQL |n| 1)
                (SEQ (|GBEUCLID;prinb| 1 $)
                     (SPADCALL "you choose option  -info-  " (QREFELT $ 63))
                     (SPADCALL
                      "abbrev. for the following information strings are"
                      (QREFELT $ 63))
                     (SPADCALL
                      "  ci  =>  Leading monomial  for critpair calculation"
                      (QREFELT $ 63))
                     (SPADCALL "  tci =>  Number of terms of polynomial i"
                               (QREFELT $ 63))
                     (SPADCALL
                      "  cj  =>  Leading monomial  for critpair calculation"
                      (QREFELT $ 63))
                     (SPADCALL "  tcj =>  Number of terms of polynomial j"
                               (QREFELT $ 63))
                     (SPADCALL
                      "  c   =>  Leading monomial of critpair polynomial"
                      (QREFELT $ 63))
                     (SPADCALL
                      "  tc  =>  Number of terms of critpair polynomial"
                      (QREFELT $ 63))
                     (SPADCALL
                      "  rc  =>  Leading monomial of redcritpair polynomial"
                      (QREFELT $ 63))
                     (SPADCALL
                      "  trc =>  Number of terms of redcritpair polynomial"
                      (QREFELT $ 63))
                     (SPADCALL
                      "  tF  =>  Number of polynomials in reduction list F"
                      (QREFELT $ 63))
                     (SPADCALL "  tD  =>  Number of critpairs still to do"
                               (QREFELT $ 63))
                     (|GBEUCLID;prinb| 4 $) (EXIT (LETT |n| 2)))))
              (|GBEUCLID;prinb| 1 $) (LETT |a| (|spadConstant| $ 35))
              (EXIT
               (COND
                ((SPADCALL |ph| (|spadConstant| $ 39) (QREFELT $ 40))
                 (COND
                  ((SPADCALL |ps| (|spadConstant| $ 39) (QREFELT $ 40))
                   (SEQ
                    (LETT |ll|
                          (LIST
                           (VECTOR
                            (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 19))
                                      (QREFELT $ 46))
                            (|GBEUCLID;lepol| |cpi| $)
                            (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 19))
                                      (QREFELT $ 46))
                            (|GBEUCLID;lepol| |cpj| $) |ps| 0 |ph| 0 |i1|
                            |i2|)))
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 67)) (QREFELT $ 16))
                    (|GBEUCLID;prinb| 1 $) (EXIT |n|)))
                  (#1='T
                   (SEQ
                    (LETT |ll|
                          (LIST
                           (VECTOR
                            (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 19))
                                      (QREFELT $ 46))
                            (|GBEUCLID;lepol| |cpi| $)
                            (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 19))
                                      (QREFELT $ 46))
                            (|GBEUCLID;lepol| |cpj| $)
                            (SPADCALL |a| (SPADCALL |ps| (QREFELT $ 19))
                                      (QREFELT $ 46))
                            (|GBEUCLID;lepol| |ps| $) |ph| 0 |i1| |i2|)))
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 67)) (QREFELT $ 16))
                    (|GBEUCLID;prinb| 1 $) (EXIT |n|)))))
                (#1#
                 (SEQ
                  (LETT |ll|
                        (LIST
                         (VECTOR
                          (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 19))
                                    (QREFELT $ 46))
                          (|GBEUCLID;lepol| |cpi| $)
                          (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 19))
                                    (QREFELT $ 46))
                          (|GBEUCLID;lepol| |cpj| $)
                          (SPADCALL |a| (SPADCALL |ps| (QREFELT $ 19))
                                    (QREFELT $ 46))
                          (|GBEUCLID;lepol| |ps| $)
                          (SPADCALL |a| (SPADCALL |ph| (QREFELT $ 19))
                                    (QREFELT $ 46))
                          (|GBEUCLID;lepol| |ph| $) |i1| |i2|)))
                  (SPADCALL (SPADCALL |ll| (QREFELT $ 67)) (QREFELT $ 16))
                  (|GBEUCLID;prinb| 1 $) (EXIT |n|)))))))) 

(SDEFUN |GBEUCLID;prinpolINFO| ((|pl| (|List| |Dpol|)) ($ (|Void|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (LENGTH |pl|)) (|GBEUCLID;prinb| 1 $)
                    (EXIT
                     (COND
                      ((EQL |n| 1)
                       (SEQ
                        (SPADCALL
                         (SPADCALL "  There is 1  Groebner Basis Polynomial "
                                   (QREFELT $ 42))
                         (QREFELT $ 16))
                        (EXIT (|GBEUCLID;prinb| 2 $))))
                      ('T
                       (SEQ
                        (SPADCALL (SPADCALL "  There are " (QREFELT $ 42))
                                  (QREFELT $ 16))
                        (|GBEUCLID;prinb| 1 $)
                        (SPADCALL (SPADCALL |n| (QREFELT $ 68)) (QREFELT $ 16))
                        (|GBEUCLID;prinb| 1 $)
                        (SPADCALL
                         (SPADCALL "  Groebner Basis Polynomials. "
                                   (QREFELT $ 42))
                         (QREFELT $ 16))
                        (EXIT (|GBEUCLID;prinb| 2 $))))))))) 

(DECLAIM (NOTINLINE |EuclideanGroebnerBasisPackage;|)) 

(DEFUN |EuclideanGroebnerBasisPackage| (&REST #1=#:G933)
  (SPROG NIL
         (PROG (#2=#:G934)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|EuclideanGroebnerBasisPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |EuclideanGroebnerBasisPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|EuclideanGroebnerBasisPackage|)))))))))) 

(DEFUN |EuclideanGroebnerBasisPackage;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|EuclideanGroebnerBasisPackage| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 69))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|EuclideanGroebnerBasisPackage|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|EuclideanGroebnerBasisPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 9)
              |GBEUCLID;euclideanGroebner;2L;1| (|OutputForm|) (|String|)
              (0 . |coerce|) (|Void|) (5 . |print|)
              |GBEUCLID;euclideanGroebner;LSL;2|
              |GBEUCLID;euclideanGroebner;L2SL;3| (10 . |degree|) (|Boolean|)
              (15 . >) (21 . =) (27 . |leadingCoefficient|) (32 . |sizeLess?|)
              (|Mapping| 20 9 9) (38 . |sort|) (44 . |sup|) (50 . |lcm|)
              (56 . <)
              (|Record| (|:| |lcmfij| 7) (|:| |lcmcij| 6) (|:| |poli| 9)
                        (|:| |polj| 9))
              (|Mapping| 20 30 30) (|List| 30) (62 . |sort|) (68 . =)
              (74 . |One|) (78 . |One|) (82 . |Zero|) (86 . |Zero|)
              (90 . |Zero|) (94 . =) (100 . |unitCanonical|) (105 . |message|)
              (|Integer|) (110 . ~=) (116 . ~=) (122 . |monomial|) (128 . +)
              (134 . |reductum|) (139 . |append|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (145 . |extendedEuclidean|) (|Union| $ '"failed")
              (151 . |subtractIfCan|) (157 . *) (163 . *) (169 . |exquo|)
              (175 . -) (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (181 . |divide|) (187 . +) (193 . *)
              |GBEUCLID;euclideanNormalForm;DpolLDpol;19|
              (199 . |messagePrint|) (204 . |coerce|)
              (|Record| (|:| |ci| 9) (|:| |tci| 43) (|:| |cj| 9) (|:| |tcj| 43)
                        (|:| |c| 9) (|:| |tc| 43) (|:| |rc| 9) (|:| |trc| 43)
                        (|:| |tH| 43) (|:| |tD| 43))
              (|List| 65) (209 . |coerce|) (214 . |coerce|))
           '#(|euclideanNormalForm| 219 |euclideanGroebner| 225) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|euclideanNormalForm|
                                 (|#4| |#4| (|List| |#4|)))
                                T)
                              '((|euclideanGroebner|
                                 ((|List| |#4|) (|List| |#4|)))
                                T)
                              '((|euclideanGroebner|
                                 ((|List| |#4|) (|List| |#4|) (|String|)))
                                T)
                              '((|euclideanGroebner|
                                 ((|List| |#4|) (|List| |#4|) (|String|)
                                  (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 68
                                            '(1 13 12 0 14 1 12 15 0 16 1 9 7 0
                                              19 2 7 20 0 0 21 2 7 20 0 0 22 1
                                              9 6 0 23 2 6 20 0 0 24 2 10 0 25
                                              0 26 2 7 0 0 0 27 2 6 0 0 0 28 2
                                              7 20 0 0 29 2 32 0 31 0 33 2 6 20
                                              0 0 34 0 6 0 35 0 9 0 36 0 6 0 37
                                              0 7 0 38 0 9 0 39 2 9 20 0 0 40 1
                                              9 0 0 41 1 12 0 13 42 2 43 20 0 0
                                              44 2 9 20 0 0 45 2 9 0 6 7 46 2 9
                                              0 0 0 47 1 9 0 0 48 2 10 0 0 0 49
                                              2 6 50 0 0 51 2 7 52 0 0 53 2 9 0
                                              0 0 54 2 9 0 6 0 55 2 6 52 0 0 56
                                              2 9 0 0 0 57 2 6 58 0 0 59 2 7 0
                                              0 0 60 2 6 0 0 0 61 1 12 15 13 63
                                              1 9 12 0 64 1 66 12 0 67 1 43 12
                                              0 68 2 0 9 9 10 62 1 0 10 10 11 3
                                              0 10 10 13 13 18 2 0 10 10 13
                                              17)))))
           '|lookupComplete|)) 
