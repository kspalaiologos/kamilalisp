
(SDEFUN |GBINTERN;virtualDegree;DpolNni;1|
        ((|p| (|Dpol|)) ($ (|NonNegativeInteger|)))
        (SPADCALL |p| (QREFELT $ 10))) 

(PUT '|GBINTERN;virtualDegree;DpolNni;2| '|SPADreplace| '(XLAM (|p|) 0)) 

(SDEFUN |GBINTERN;virtualDegree;DpolNni;2|
        ((|p| (|Dpol|)) ($ (|NonNegativeInteger|))) 0) 

(SDEFUN |GBINTERN;critpOrder;2RB;3|
        ((|cp1|
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|)))
         (|cp2|
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|)))
         ($ (|Boolean|)))
        (COND ((< (QVELT |cp1| 1) (QVELT |cp2| 1)) 'T)
              ((< (QVELT |cp2| 1) (QVELT |cp1| 1)) NIL)
              ('T (SPADCALL (QVELT |cp1| 0) (QVELT |cp2| 0) (QREFELT $ 13))))) 

(SDEFUN |GBINTERN;makeCrit;RDpolNniR;4|
        ((|sp1|
          (|Record| (|:| |totdeg| (|NonNegativeInteger|)) (|:| |pol| |Dpol|)))
         (|p2| (|Dpol|)) (|totdeg2| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|))))
        (SPROG
         ((|tdeg| (|NonNegativeInteger|)) (|e2| (|Expon|)) (#1=#:G724 NIL)
          (|e1| (|Expon|)) (|deg| (|Expon|)) (|p1| (|Dpol|)))
         (SEQ (LETT |p1| (QCDR |sp1|))
              (LETT |deg|
                    (SPADCALL (SPADCALL |p1| (QREFELT $ 16))
                              (SPADCALL |p2| (QREFELT $ 16)) (QREFELT $ 17)))
              (LETT |e1|
                    (PROG2
                        (LETT #1#
                              (SPADCALL |deg| (SPADCALL |p1| (QREFELT $ 16))
                                        (QREFELT $ 19)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                      (|Union| (QREFELT $ 7) #2="failed")
                                      #1#)))
              (LETT |e2|
                    (PROG2
                        (LETT #1#
                              (SPADCALL |deg| (SPADCALL |p2| (QREFELT $ 16))
                                        (QREFELT $ 19)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                      (|Union| (QREFELT $ 7) #2#) #1#)))
              (LETT |tdeg|
                    (MAX
                     (+ (QCAR |sp1|)
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 20) |e1| (QREFELT $ 22))
                         (QREFELT $ 11)))
                     (+ |totdeg2|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 20) |e2| (QREFELT $ 22))
                         (QREFELT $ 11)))))
              (EXIT (VECTOR |deg| |tdeg| |p1| |p2|))))) 

(SDEFUN |GBINTERN;gbasis;L2IL;5|
        ((|Pol| (|List| |Dpol|)) (|xx1| (|Integer|)) (|xx2| (|Integer|))
         ($ (|List| |Dpol|)))
        (SPADCALL |Pol| NIL |xx1| |xx2| (QREFELT $ 27))) 

(SDEFUN |GBINTERN;gbasisExtend;2L2IL;6|
        ((|Pol| (|List| |Dpol|)) (|gb| (|List| |Dpol|)) (|xx1| (|Integer|))
         (|xx2| (|Integer|)) ($ (|List| |Dpol|)))
        (SPROG
         ((#1=#:G800 NIL) (|x| NIL) (#2=#:G799 NIL) (|xx| (|Integer|))
          (|redPols| (|List| |Dpol|))
          (|basPols|
           (|List|
            (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                      (|:| |pol| |Dpol|))))
          (D
           (|List|
            #3=(|Record| (|:| |lcmfij| |Expon|)
                         (|:| |totdeg| (|NonNegativeInteger|))
                         (|:| |poli| |Dpol|) (|:| |polj| |Dpol|))))
          (D1 (|List| #3#)) (#4=#:G798 NIL) (#5=#:G797 NIL) (#6=#:G790 NIL)
          (|h| (|Dpol|)) (|s| (|Dpol|))
          (D0
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))
          (#7=#:G796 NIL) (#8=#:G795 NIL) (#9=#:G794 NIL) (#10=#:G793 NIL)
          (|toth| (|NonNegativeInteger|)) (|Pol1| (|List| |Dpol|))
          (|sgb|
           (|List|
            (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                      (|:| |pol| |Dpol|))))
          (#11=#:G792 NIL) (#12=#:G791 NIL))
         (SEQ
          (LETT |sgb|
                (PROGN
                 (LETT #12# NIL)
                 (SEQ (LETT |x| NIL) (LETT #11# |gb|) G190
                      (COND
                       ((OR (ATOM #11#) (PROGN (LETT |x| (CAR #11#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #12#
                              (CONS
                               (CONS (SPADCALL |x| (QREFELT $ 11))
                                     (SPADCALL |x| (QREFELT $ 29)))
                               #12#))))
                      (LETT #11# (CDR #11#)) (GO G190) G191
                      (EXIT (NREVERSE #12#)))))
          (LETT |Pol1|
                (SPADCALL (CONS #'|GBINTERN;gbasisExtend;2L2IL;6!0| $) |Pol|
                          (QREFELT $ 32)))
          (LETT |basPols|
                (SPADCALL (SPADCALL (|SPADfirst| |Pol1|) (QREFELT $ 29))
                          (SPADCALL (|SPADfirst| |Pol1|) (QREFELT $ 11)) |sgb|
                          (QREFELT $ 34)))
          (LETT |Pol1| (CDR |Pol1|)) (LETT D NIL)
          (SEQ G190 (COND ((NULL (NULL (NULL |Pol1|))) (GO G191)))
               (SEQ (LETT |h| (SPADCALL (|SPADfirst| |Pol1|) (QREFELT $ 29)))
                    (LETT |Pol1| (CDR |Pol1|))
                    (LETT |toth| (SPADCALL |h| (QREFELT $ 11)))
                    (LETT D1
                          (PROGN
                           (LETT #10# NIL)
                           (SEQ (LETT |x| NIL) (LETT #9# |basPols|) G190
                                (COND
                                 ((OR (ATOM #9#)
                                      (PROGN (LETT |x| (CAR #9#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #10#
                                        (CONS
                                         (SPADCALL |x| |h| |toth|
                                                   (QREFELT $ 24))
                                         #10#))))
                                (LETT #9# (CDR #9#)) (GO G190) G191
                                (EXIT (NREVERSE #10#)))))
                    (LETT D
                          (SPADCALL
                           (SPADCALL (SPADCALL (ELT $ 15) D1 (QREFELT $ 37))
                                     (QREFELT $ 38))
                           (SPADCALL |h| D (QREFELT $ 39)) (QREFELT $ 40)))
                    (EXIT
                     (LETT |basPols|
                           (SPADCALL |h| |toth| |basPols| (QREFELT $ 34)))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT D (SPADCALL (ELT $ 15) D (QREFELT $ 37))) (LETT |xx| |xx2|)
          (LETT |redPols|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |x| NIL) (LETT #7# |basPols|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |x| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #8# (CONS (QCDR |x|) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (SEQ
           (EXIT
            (SEQ G190 (COND ((NULL (NULL (NULL D))) (GO G191)))
                 (SEQ (LETT D0 (|SPADfirst| D))
                      (LETT |s|
                            (SPADCALL (SPADCALL D0 (QREFELT $ 41))
                                      (QREFELT $ 29)))
                      (LETT D (CDR D))
                      (LETT |h|
                            (SPADCALL (SPADCALL |s| |redPols| (QREFELT $ 42))
                                      (QREFELT $ 29)))
                      (COND ((EQL |xx1| 1) (SPADCALL |h| (QREFELT $ 44))))
                      (EXIT
                       (COND
                        ((SPADCALL |h| (|spadConstant| $ 47) (QREFELT $ 48))
                         (SEQ
                          (COND
                           ((EQL |xx2| 1)
                            (SEQ
                             (SPADCALL D0 |s| |h| (LENGTH |basPols|) (LENGTH D)
                                       |xx| (QREFELT $ 49))
                             (EXIT (LETT |xx| 2)))))
                          (EXIT " go to top of while ")))
                        ((SPADCALL (SPADCALL |h| (QREFELT $ 16))
                                   (|spadConstant| $ 46) (QREFELT $ 50))
                         (SEQ (LETT D NIL)
                              (COND
                               ((EQL |xx2| 1)
                                (SEQ
                                 (SPADCALL D0 |s| |h| (LENGTH |basPols|)
                                           (LENGTH D) |xx| (QREFELT $ 49))
                                 (EXIT (LETT |xx| 2)))))
                              (LETT |basPols|
                                    (SPADCALL |h| 0 NIL (QREFELT $ 34)))
                              (EXIT (PROGN (LETT #6# 1) (GO #13=#:G783)))))
                        ('T
                         (SEQ
                          (LETT D1
                                (PROGN
                                 (LETT #5# NIL)
                                 (SEQ (LETT |x| NIL) (LETT #4# |basPols|) G190
                                      (COND
                                       ((OR (ATOM #4#)
                                            (PROGN (LETT |x| (CAR #4#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #5#
                                              (CONS
                                               (SPADCALL |x| |h| (QVELT D0 1)
                                                         (QREFELT $ 24))
                                               #5#))))
                                      (LETT #4# (CDR #4#)) (GO G190) G191
                                      (EXIT (NREVERSE #5#)))))
                          (LETT D
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (ELT $ 15) D1 (QREFELT $ 37))
                                  (QREFELT $ 38))
                                 (SPADCALL |h| D (QREFELT $ 39))
                                 (QREFELT $ 40)))
                          (LETT |basPols|
                                (SPADCALL |h| (QVELT D0 1) |basPols|
                                          (QREFELT $ 34)))
                          (LETT |redPols|
                                (SPADCALL |redPols| |h| (QREFELT $ 51)))
                          (EXIT
                           (COND
                            ((EQL |xx2| 1)
                             (SEQ
                              (SPADCALL D0 |s| |h| (LENGTH |basPols|)
                                        (LENGTH D) |xx| (QREFELT $ 49))
                              (EXIT (LETT |xx| 2)))))))))))
                 NIL (GO G190) G191 (EXIT NIL)))
           #13# (EXIT #6#))
          (LETT |Pol|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |basPols|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCDR |x|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (COND
           ((EQL |xx2| 1)
            (SEQ (SPADCALL |Pol| (QREFELT $ 52))
                 (EXIT
                  (SPADCALL "    THE GROEBNER BASIS POLYNOMIALS"
                            (QREFELT $ 55))))))
          (COND
           ((EQL |xx1| 1)
            (COND
             ((SPADCALL |xx2| 1 (QREFELT $ 56))
              (SPADCALL "    THE GROEBNER BASIS POLYNOMIALS"
                        (QREFELT $ 55))))))
          (EXIT |Pol|)))) 

(SDEFUN |GBINTERN;gbasisExtend;2L2IL;6!0| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 16)) (SPADCALL |z2| (QREFELT $ 16))
                  (QREFELT $ 30))) 

(SDEFUN |GBINTERN;critMonD1;Expon2L;7|
        ((|e| (|Expon|))
         (D2
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))))
        (SPROG ((#1=#:G807 NIL) (|x| NIL) (#2=#:G806 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# D2) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL (SPADCALL |e| (QVELT |x| 0) (QREFELT $ 57)))
                          (LETT #2# (CONS |x| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |GBINTERN;critMTonD1;2L;8|
        ((D1
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))))
        (SPROG
         ((|r1|
           (|List|
            (|Record| (|:| |lcmfij| |Expon|)
                      (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                      (|:| |polj| |Dpol|))))
          (|e1| (|Expon|)) (|cT1| (|Boolean|)) (|s1| (|NonNegativeInteger|))
          (|f1|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         (SEQ
          (COND ((NULL D1) NIL)
                (#1='T
                 (SEQ (LETT |f1| (|SPADfirst| D1)) (LETT |s1| (LENGTH D1))
                      (LETT |cT1| (SPADCALL |f1| (QREFELT $ 59)))
                      (COND ((EQL |s1| 1) (COND (|cT1| (EXIT NIL)))))
                      (EXIT
                       (COND ((EQL |s1| 1) D1)
                             (#1#
                              (SEQ (LETT |e1| (QVELT |f1| 0))
                                   (LETT |r1| (CDR D1))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |e1|
                                                (QVELT (|SPADfirst| |r1|) 0)
                                                (QREFELT $ 50))
                                      (COND
                                       (|cT1|
                                        (SPADCALL (CONS |f1| (CDR |r1|))
                                                  (QREFELT $ 38)))
                                       (#1# (SPADCALL |r1| (QREFELT $ 38)))))
                                     (#1#
                                      (SEQ
                                       (LETT D1
                                             (SPADCALL |e1| |r1|
                                                       (QREFELT $ 58)))
                                       (EXIT
                                        (COND
                                         (|cT1| (SPADCALL D1 (QREFELT $ 38)))
                                         (#1#
                                          (CONS |f1|
                                                (SPADCALL D1
                                                          (QREFELT $
                                                                   38)))))))))))))))))))) 

(SDEFUN |GBINTERN;critBonD;Dpol2L;9|
        ((|h| (|Dpol|))
         (D
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))))
        (SPROG ((#1=#:G822 NIL) (|x| NIL) (#2=#:G821 NIL) (|d| (|Expon|)))
               (SEQ (LETT |d| (SPADCALL |h| (QREFELT $ 16)))
                    (EXIT
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |x| NIL) (LETT #1# D) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL
                                (SPADCALL |d| (QVELT |x| 0)
                                          (SPADCALL (QVELT |x| 2)
                                                    (QREFELT $ 16))
                                          (SPADCALL (QVELT |x| 3)
                                                    (QREFELT $ 16))
                                          (QREFELT $ 60)))
                               (LETT #2# (CONS |x| #2#))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |GBINTERN;updatF;DpolNni2L;10|
        ((|h| (|Dpol|)) (|deg| (|NonNegativeInteger|))
         (F
          (|List|
           (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                     (|:| |pol| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                     (|:| |pol| |Dpol|)))))
        (SPROG ((#1=#:G830 NIL) (|f| NIL) (#2=#:G829 NIL) (|d| (|Expon|)))
               (SEQ (LETT |d| (SPADCALL |h| (QREFELT $ 16)))
                    (EXIT
                     (SPADCALL
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |f| NIL) (LETT #1# F) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((NULL
                                 (SPADCALL |d|
                                           (SPADCALL (QCDR |f|) (QREFELT $ 16))
                                           (QREFELT $ 57)))
                                (LETT #2# (CONS |f| #2#))))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (CONS |deg| |h|) (QREFELT $ 61)))))) 

(SDEFUN |GBINTERN;updatD;3L;11|
        ((D1
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         (D2
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |lcmfij| |Expon|)
                      (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                      (|:| |polj| |Dpol|))))
          (#1=#:G850 NIL) (|e| NIL) (#2=#:G849 NIL)
          (|dl2|
           #3=(|Record| (|:| |lcmfij| |Expon|)
                        (|:| |totdeg| (|NonNegativeInteger|))
                        (|:| |poli| |Dpol|) (|:| |polj| |Dpol|)))
          (|dl1| #3#))
         (SEQ
          (COND ((NULL D1) D2) ((NULL D2) D1)
                ('T
                 (SEQ (LETT |res| NIL)
                      (SEQ G190
                           (COND
                            ((NULL
                              (COND ((NULL D1) NIL) ('T (NULL (NULL D2)))))
                             (GO G191)))
                           (SEQ (LETT |dl1| (|SPADfirst| D1))
                                (LETT |dl2| (|SPADfirst| D2))
                                (EXIT
                                 (COND
                                  ((SPADCALL |dl1| |dl2| (QREFELT $ 15))
                                   (SEQ (LETT |res| (CONS |dl1| |res|))
                                        (EXIT (LETT D1 (CDR D1)))))
                                  ('T
                                   (SEQ (LETT |res| (CONS |dl2| |res|))
                                        (EXIT (LETT D2 (CDR D2))))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (SEQ (LETT |e| NIL) (LETT #2# D1) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ (EXIT (LETT |res| (CONS |e| |res|))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (SEQ (LETT |e| NIL) (LETT #1# D2) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (EXIT (LETT |res| (CONS |e| |res|))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (NREVERSE |res|)))))))) 

(SDEFUN |GBINTERN;gcdCo|
        ((|c1| (|Dom|)) (|c2| (|Dom|))
         ($ (|Record| (|:| |co1| |Dom|) (|:| |co2| |Dom|))))
        (SPROG ((#1=#:G853 NIL) (|d| (|Dom|)))
               (SEQ (LETT |d| (SPADCALL |c1| |c2| (QREFELT $ 62)))
                    (EXIT
                     (CONS
                      (PROG2 (LETT #1# (SPADCALL |c1| |d| (QREFELT $ 63)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                        (|Union| (QREFELT $ 6) #2="failed")
                                        #1#))
                      (PROG2 (LETT #1# (SPADCALL |c2| |d| (QREFELT $ 63)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                        (|Union| (QREFELT $ 6) #2#) #1#))))))) 

(SDEFUN |GBINTERN;sPol;RDpol;13|
        ((|p|
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|)))
         ($ (|Dpol|)))
        (SPROG
         ((#1=#:G860 NIL) (|cc| (|Record| (|:| |co1| |Dom|) (|:| |co2| |Dom|)))
          (|fj| (|Dpol|)) (|fi| (|Dpol|)) (|Tij| (|Expon|)))
         (SEQ (LETT |Tij| (QVELT |p| 0)) (LETT |fi| (QVELT |p| 2))
              (LETT |fj| (QVELT |p| 3))
              (LETT |cc|
                    (|GBINTERN;gcdCo| (SPADCALL |fi| (QREFELT $ 64))
                     (SPADCALL |fj| (QREFELT $ 64)) $))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |fi| (QREFELT $ 65))
                          (SPADCALL (QCDR |cc|)
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL |Tij|
                                                        (SPADCALL |fi|
                                                                  (QREFELT $
                                                                           16))
                                                        (QREFELT $ 19)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (QREFELT $ 7)
                                                      (|Union| (QREFELT $ 7)
                                                               #2="failed")
                                                      #1#))
                                    (QREFELT $ 22))
                          (QREFELT $ 66))
                (SPADCALL (SPADCALL |fj| (QREFELT $ 65))
                          (SPADCALL (QCAR |cc|)
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL |Tij|
                                                        (SPADCALL |fj|
                                                                  (QREFELT $
                                                                           16))
                                                        (QREFELT $ 19)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (QREFELT $ 7)
                                                      (|Union| (QREFELT $ 7)
                                                               #2#)
                                                      #1#))
                                    (QREFELT $ 22))
                          (QREFELT $ 66))
                (QREFELT $ 67)))))) 

(SDEFUN |GBINTERN;redPo;DpolLR;14|
        ((|s| (|Dpol|)) (F (|List| |Dpol|))
         ($ (|Record| (|:| |poly| |Dpol|) (|:| |mult| |Dom|))))
        (SPROG
         ((|m| (|Dom|)) (|cc| (|Record| (|:| |co1| |Dom|) (|:| |co2| |Dom|)))
          (|e| (|Union| |Expon| "failed")) (|s1| (|Expon|)) (|f1| (|Dpol|))
          (|Fh| (|List| |Dpol|)))
         (SEQ (LETT |m| (|spadConstant| $ 20)) (LETT |Fh| F)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND
                       ((SPADCALL |s| (|spadConstant| $ 47) (QREFELT $ 48))
                        NIL)
                       ('T (NULL (NULL F)))))
                     (GO G191)))
                   (SEQ (LETT |f1| (|SPADfirst| F))
                        (LETT |s1| (SPADCALL |s| (QREFELT $ 16)))
                        (LETT |e|
                              (SPADCALL |s1| (SPADCALL |f1| (QREFELT $ 16))
                                        (QREFELT $ 19)))
                        (EXIT
                         (COND
                          ((QEQCAR |e| 0)
                           (SEQ
                            (LETT |cc|
                                  (|GBINTERN;gcdCo|
                                   (SPADCALL |f1| (QREFELT $ 64))
                                   (SPADCALL |s| (QREFELT $ 64)) $))
                            (LETT |s|
                                  (SPADCALL
                                   (SPADCALL (QCAR |cc|)
                                             (SPADCALL |s| (QREFELT $ 65))
                                             (QREFELT $ 68))
                                   (SPADCALL
                                    (SPADCALL (QCDR |cc|) (QCDR |e|)
                                              (QREFELT $ 22))
                                    (SPADCALL |f1| (QREFELT $ 65))
                                    (QREFELT $ 66))
                                   (QREFELT $ 67)))
                            (LETT |m|
                                  (SPADCALL |m| (QCAR |cc|) (QREFELT $ 69)))
                            (EXIT (LETT F |Fh|))))
                          ('T (LETT F (CDR F))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |s| |m|))))) 

(SDEFUN |GBINTERN;redPol;DpolLDpol;15|
        ((|s| (|Dpol|)) (F (|List| |Dpol|)) ($ (|Dpol|)))
        (SPADCALL (QCAR (SPADCALL |s| F (QREFELT $ 71))) F (QREFELT $ 72))) 

(SDEFUN |GBINTERN;critT;RB;16|
        ((|p|
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|)))
         ($ (|Boolean|)))
        (SPADCALL (QVELT |p| 0)
                  (SPADCALL (SPADCALL (QVELT |p| 2) (QREFELT $ 16))
                            (SPADCALL (QVELT |p| 3) (QREFELT $ 16))
                            (QREFELT $ 73))
                  (QREFELT $ 50))) 

(SDEFUN |GBINTERN;critM;2ExponB;17|
        ((|e1| (|Expon|)) (|e2| (|Expon|)) ($ (|Boolean|)))
        (SPROG ((|en| (|Union| |Expon| "failed")))
               (QEQCAR (LETT |en| (SPADCALL |e2| |e1| (QREFELT $ 19))) 0))) 

(SDEFUN |GBINTERN;critB;4ExponB;18|
        ((|eh| (|Expon|)) (|eik| (|Expon|)) (|ei| (|Expon|)) (|ek| (|Expon|))
         ($ (|Boolean|)))
        (COND
         ((SPADCALL |eh| |eik| (QREFELT $ 57))
          (COND
           ((SPADCALL |eik| (SPADCALL |eh| |ei| (QREFELT $ 17)) (QREFELT $ 74))
            (SPADCALL |eik| (SPADCALL |eh| |ek| (QREFELT $ 17))
                      (QREFELT $ 74)))
           (#1='T NIL)))
         (#1# NIL))) 

(SDEFUN |GBINTERN;hMonic;2Dpol;19| ((|p| (|Dpol|)) ($ (|Dpol|)))
        (COND ((SPADCALL |p| (|spadConstant| $ 47) (QREFELT $ 48)) |p|)
              ('T (SPADCALL |p| (QREFELT $ 75))))) 

(SDEFUN |GBINTERN;credPol;DpolLDpol;20|
        ((|h| (|Dpol|)) (F (|List| |Dpol|)) ($ (|Dpol|)))
        (SPROG
         ((|h0| (|Dpol|))
          (|hred| (|Record| (|:| |poly| |Dpol|) (|:| |mult| |Dom|))))
         (SEQ
          (COND ((NULL F) |h|)
                ('T
                 (SEQ
                  (LETT |h0|
                        (SPADCALL (SPADCALL |h| (QREFELT $ 64))
                                  (SPADCALL |h| (QREFELT $ 16))
                                  (QREFELT $ 22)))
                  (SEQ G190
                       (COND
                        ((NULL
                          (SPADCALL (LETT |h| (SPADCALL |h| (QREFELT $ 65)))
                                    (|spadConstant| $ 47) (QREFELT $ 76)))
                         (GO G191)))
                       (SEQ (LETT |hred| (SPADCALL |h| F (QREFELT $ 71)))
                            (LETT |h| (QCAR |hred|))
                            (EXIT
                             (LETT |h0|
                                   (SPADCALL
                                    (SPADCALL (QCDR |hred|) |h0|
                                              (QREFELT $ 68))
                                    (SPADCALL (SPADCALL |h| (QREFELT $ 64))
                                              (SPADCALL |h| (QREFELT $ 16))
                                              (QREFELT $ 22))
                                    (QREFELT $ 77)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT |h0|))))))) 

(SDEFUN |GBINTERN;minGbasis;2L;21| ((F (|List| |Dpol|)) ($ (|List| |Dpol|)))
        (SPROG ((|newbas| (|List| |Dpol|)))
               (SEQ
                (COND ((NULL F) NIL)
                      ('T
                       (SEQ (LETT |newbas| (SPADCALL (CDR F) (QREFELT $ 78)))
                            (EXIT
                             (CONS
                              (SPADCALL
                               (SPADCALL (|SPADfirst| F) |newbas|
                                         (QREFELT $ 72))
                               (QREFELT $ 29))
                              |newbas|)))))))) 

(SDEFUN |GBINTERN;lepol;DpolI;22| ((|p1| (|Dpol|)) ($ (|Integer|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| 0)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p1| (|spadConstant| $ 47)
                                      (QREFELT $ 76)))
                           (GO G191)))
                         (SEQ (LETT |n| (+ |n| 1))
                              (EXIT
                               (LETT |p1| (SPADCALL |p1| (QREFELT $ 65)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |n|)))) 

(SDEFUN |GBINTERN;prinb;IV;23| ((|n| (|Integer|)) ($ (|Void|)))
        (SPROG ((#1=#:G909 NIL) (|x| NIL))
               (SEQ (LETT |x| 1) (LETT #1# |n|) G190
                    (COND ((|greater_SI| |x| #1#) (GO G191)))
                    (SEQ (EXIT (SPADCALL "    " (QREFELT $ 55))))
                    (LETT |x| (|inc_SI| |x|)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |GBINTERN;prinshINFO;DpolV;24| ((|h| (|Dpol|)) ($ (|Void|)))
        (SEQ (SPADCALL 2 (QREFELT $ 80))
             (SPADCALL " reduced Critpair - Polynom :" (QREFELT $ 55))
             (SPADCALL 2 (QREFELT $ 80))
             (SPADCALL (SPADCALL |h| (QREFELT $ 81)) (QREFELT $ 82))
             (EXIT (SPADCALL 2 (QREFELT $ 80))))) 

(SDEFUN |GBINTERN;prindINFO;R2Dpol4I;25|
        ((|cp|
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|)))
         (|ps| (|Dpol|)) (|ph| (|Dpol|)) (|i1| (|Integer|)) (|i2| (|Integer|))
         (|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|ll|
           (|List|
            (|Record| (|:| |ci| |Dpol|) (|:| |tci| (|Integer|))
                      (|:| |cj| |Dpol|) (|:| |tcj| (|Integer|))
                      (|:| |c| |Dpol|) (|:| |tc| (|Integer|)) (|:| |rc| |Dpol|)
                      (|:| |trc| (|Integer|)) (|:| |tF| (|Integer|))
                      (|:| |tD| (|Integer|)))))
          (|a| (|Dom|)) (|cpj| (|Dpol|)) (|cpi| (|Dpol|)))
         (SEQ (LETT |cpi| (QVELT |cp| 2)) (LETT |cpj| (QVELT |cp| 3))
              (COND
               ((EQL |n| 1)
                (SEQ (SPADCALL 1 (QREFELT $ 80))
                     (SPADCALL "you choose option  -info-  " (QREFELT $ 55))
                     (SPADCALL
                      "abbrev. for the following information strings are"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  ci  =>  Leading monomial  for critpair calculation"
                      (QREFELT $ 55))
                     (SPADCALL "  tci =>  Number of terms of polynomial i"
                               (QREFELT $ 55))
                     (SPADCALL
                      "  cj  =>  Leading monomial  for critpair calculation"
                      (QREFELT $ 55))
                     (SPADCALL "  tcj =>  Number of terms of polynomial j"
                               (QREFELT $ 55))
                     (SPADCALL
                      "  c   =>  Leading monomial of critpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  tc  =>  Number of terms of critpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  rc  =>  Leading monomial of redcritpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  trc =>  Number of terms of redcritpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  tF  =>  Number of polynomials in reduction list F"
                      (QREFELT $ 55))
                     (SPADCALL "  tD  =>  Number of critpairs still to do"
                               (QREFELT $ 55))
                     (SPADCALL 4 (QREFELT $ 80)) (EXIT (LETT |n| 2)))))
              (SPADCALL 1 (QREFELT $ 80)) (LETT |a| (|spadConstant| $ 20))
              (EXIT
               (COND
                ((SPADCALL |ph| (|spadConstant| $ 47) (QREFELT $ 48))
                 (COND
                  ((SPADCALL |ps| (|spadConstant| $ 47) (QREFELT $ 48))
                   (SEQ
                    (LETT |ll|
                          (LIST
                           (VECTOR
                            (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpi| (QREFELT $ 79))
                            (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpj| (QREFELT $ 79)) |ps| 0 |ph| 0 |i1|
                            |i2|)))
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 85)) (QREFELT $ 82))
                    (SPADCALL 1 (QREFELT $ 80)) (EXIT |n|)))
                  (#1='T
                   (SEQ
                    (LETT |ll|
                          (LIST
                           (VECTOR
                            (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpi| (QREFELT $ 79))
                            (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpj| (QREFELT $ 79))
                            (SPADCALL |a| (SPADCALL |ps| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |ps| (QREFELT $ 79)) |ph| 0 |i1| |i2|)))
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 85)) (QREFELT $ 82))
                    (SPADCALL 1 (QREFELT $ 80)) (EXIT |n|)))))
                (#1#
                 (SEQ
                  (LETT |ll|
                        (LIST
                         (VECTOR
                          (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |cpi| (QREFELT $ 79))
                          (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |cpj| (QREFELT $ 79))
                          (SPADCALL |a| (SPADCALL |ps| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |ps| (QREFELT $ 79))
                          (SPADCALL |a| (SPADCALL |ph| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |ph| (QREFELT $ 79)) |i1| |i2|)))
                  (SPADCALL (SPADCALL |ll| (QREFELT $ 85)) (QREFELT $ 82))
                  (SPADCALL 1 (QREFELT $ 80)) (EXIT |n|)))))))) 

(SDEFUN |GBINTERN;prinpolINFO;LV;26| ((|pl| (|List| |Dpol|)) ($ (|Void|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (LENGTH |pl|)) (SPADCALL 1 (QREFELT $ 80))
                    (EXIT
                     (COND
                      ((EQL |n| 1)
                       (SEQ
                        (SPADCALL "  There is 1  Groebner Basis Polynomial "
                                  (QREFELT $ 55))
                        (EXIT (SPADCALL 2 (QREFELT $ 80)))))
                      ('T
                       (SEQ (SPADCALL "  There are " (QREFELT $ 55))
                            (SPADCALL 1 (QREFELT $ 80))
                            (SPADCALL (SPADCALL |n| (QREFELT $ 86))
                                      (QREFELT $ 82))
                            (SPADCALL 1 (QREFELT $ 80))
                            (SPADCALL "  Groebner Basis Polynomials. "
                                      (QREFELT $ 55))
                            (EXIT (SPADCALL 2 (QREFELT $ 80)))))))))) 

(SDEFUN |GBINTERN;fprindINFO;R2Dpol5I;27|
        ((|cp|
          (|Record| (|:| |lcmfij| |Expon|)
                    (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                    (|:| |polj| |Dpol|)))
         (|ps| (|Dpol|)) (|ph| (|Dpol|)) (|i1| (|Integer|)) (|i2| (|Integer|))
         (|i3| (|Integer|)) (|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|ll|
           (|List|
            (|Record| (|:| |ci| |Dpol|) (|:| |tci| (|Integer|))
                      (|:| |cj| |Dpol|) (|:| |tcj| (|Integer|))
                      (|:| |c| |Dpol|) (|:| |tc| (|Integer|)) (|:| |rc| |Dpol|)
                      (|:| |trc| (|Integer|)) (|:| |tF| (|Integer|))
                      (|:| |tDD| (|Integer|)) (|:| |tDF| (|Integer|)))))
          (|a| (|Dom|)) (|cpj| (|Dpol|)) (|cpi| (|Dpol|)))
         (SEQ (LETT |cpi| (QVELT |cp| 2)) (LETT |cpj| (QVELT |cp| 3))
              (COND
               ((EQL |n| 1)
                (SEQ (SPADCALL 1 (QREFELT $ 80))
                     (SPADCALL "you choose option  -info-  " (QREFELT $ 55))
                     (SPADCALL
                      "abbrev. for the following information strings are"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  ci  =>  Leading monomial  for critpair calculation"
                      (QREFELT $ 55))
                     (SPADCALL "  tci =>  Number of terms of polynomial i"
                               (QREFELT $ 55))
                     (SPADCALL
                      "  cj  =>  Leading monomial  for critpair calculation"
                      (QREFELT $ 55))
                     (SPADCALL "  tcj =>  Number of terms of polynomial j"
                               (QREFELT $ 55))
                     (SPADCALL
                      "  c   =>  Leading monomial of critpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  tc  =>  Number of terms of critpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  rc  =>  Leading monomial of redcritpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  trc =>  Number of terms of redcritpair polynomial"
                      (QREFELT $ 55))
                     (SPADCALL
                      "  tF  =>  Number of polynomials in reduction list F"
                      (QREFELT $ 55))
                     (SPADCALL "  tD  =>  Number of critpairs still to do"
                               (QREFELT $ 55))
                     (SPADCALL "  tDF =>  Number of subproblems still to do"
                               (QREFELT $ 55))
                     (SPADCALL 4 (QREFELT $ 80)) (EXIT (LETT |n| 2)))))
              (SPADCALL 1 (QREFELT $ 80)) (LETT |a| (|spadConstant| $ 20))
              (EXIT
               (COND
                ((SPADCALL |ph| (|spadConstant| $ 47) (QREFELT $ 48))
                 (COND
                  ((SPADCALL |ps| (|spadConstant| $ 47) (QREFELT $ 48))
                   (SEQ
                    (LETT |ll|
                          (LIST
                           (VECTOR
                            (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpi| (QREFELT $ 79))
                            (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpj| (QREFELT $ 79)) |ps| 0 |ph| 0 |i1|
                            |i2| |i3|)))
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 89)) (QREFELT $ 82))
                    (SPADCALL 1 (QREFELT $ 80)) (EXIT |n|)))
                  (#1='T
                   (SEQ
                    (LETT |ll|
                          (LIST
                           (VECTOR
                            (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpi| (QREFELT $ 79))
                            (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |cpj| (QREFELT $ 79))
                            (SPADCALL |a| (SPADCALL |ps| (QREFELT $ 16))
                                      (QREFELT $ 22))
                            (SPADCALL |ps| (QREFELT $ 79)) |ph| 0 |i1| |i2|
                            |i3|)))
                    (SPADCALL (SPADCALL |ll| (QREFELT $ 89)) (QREFELT $ 82))
                    (SPADCALL 1 (QREFELT $ 80)) (EXIT |n|)))))
                (#1#
                 (SEQ
                  (LETT |ll|
                        (LIST
                         (VECTOR
                          (SPADCALL |a| (SPADCALL |cpi| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |cpi| (QREFELT $ 79))
                          (SPADCALL |a| (SPADCALL |cpj| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |cpj| (QREFELT $ 79))
                          (SPADCALL |a| (SPADCALL |ps| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |ps| (QREFELT $ 79))
                          (SPADCALL |a| (SPADCALL |ph| (QREFELT $ 16))
                                    (QREFELT $ 22))
                          (SPADCALL |ph| (QREFELT $ 79)) |i1| |i2| |i3|)))
                  (SPADCALL (SPADCALL |ll| (QREFELT $ 89)) (QREFELT $ 82))
                  (SPADCALL 1 (QREFELT $ 80)) (EXIT |n|)))))))) 

(DECLAIM (NOTINLINE |GroebnerInternalPackage;|)) 

(DEFUN |GroebnerInternalPackage| (&REST #1=#:G936)
  (SPROG NIL
         (PROG (#2=#:G937)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GroebnerInternalPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GroebnerInternalPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GroebnerInternalPackage|)))))))))) 

(DEFUN |GroebnerInternalPackage;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|GroebnerInternalPackage| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 91))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GroebnerInternalPackage|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasSignature| |#3|
                            (LIST '|totalDegree|
                                  (LIST '(|NonNegativeInteger|)
                                        (|devaluate| |#3|))))
            (QSETREFV $ 11
                      (CONS
                       (|dispatchFunction| |GBINTERN;virtualDegree;DpolNni;1|)
                       $)))
           ('T
            (QSETREFV $ 11
                      (CONS
                       (|dispatchFunction| |GBINTERN;virtualDegree;DpolNni;2|)
                       $))))
          $))) 

(MAKEPROP '|GroebnerInternalPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|NonNegativeInteger|) (0 . |totalDegree|)
              (5 . |virtualDegree|) (|Boolean|) (10 . <)
              (|Record| (|:| |lcmfij| 7) (|:| |totdeg| 9) (|:| |poli| 8)
                        (|:| |polj| 8))
              |GBINTERN;critpOrder;2RB;3| (16 . |degree|) (21 . |sup|)
              (|Union| $ '"failed") (27 . |subtractIfCan|) (33 . |One|)
              (37 . |One|) (41 . |monomial|)
              (|Record| (|:| |totdeg| 9) (|:| |pol| 8))
              |GBINTERN;makeCrit;RDpolNniR;4| (|List| 8) (|Integer|)
              |GBINTERN;gbasisExtend;2L2IL;6| |GBINTERN;gbasis;L2IL;5|
              |GBINTERN;hMonic;2Dpol;19| (47 . >) (|Mapping| 12 8 8)
              (53 . |sort|) (|List| 23) |GBINTERN;updatF;DpolNni2L;10|
              (|Mapping| 12 14 14) (|List| 14) (59 . |sort|)
              |GBINTERN;critMTonD1;2L;8| |GBINTERN;critBonD;Dpol2L;9|
              |GBINTERN;updatD;3L;11| |GBINTERN;sPol;RDpol;13|
              |GBINTERN;redPol;DpolLDpol;15| (|Void|)
              |GBINTERN;prinshINFO;DpolV;24| (65 . |Zero|) (69 . |Zero|)
              (73 . |Zero|) (77 . =) |GBINTERN;prindINFO;R2Dpol4I;25| (83 . =)
              (89 . |concat|) |GBINTERN;prinpolINFO;LV;26| (|String|)
              (|OutputForm|) (95 . |messagePrint|) (100 . ~=)
              |GBINTERN;critM;2ExponB;17| |GBINTERN;critMonD1;Expon2L;7|
              |GBINTERN;critT;RB;16| |GBINTERN;critB;4ExponB;18|
              (106 . |concat!|) (112 . |gcd|) (118 . |exquo|)
              (124 . |leadingCoefficient|) (129 . |reductum|) (134 . *)
              (140 . -) (146 . *) (152 . *)
              (|Record| (|:| |poly| 8) (|:| |mult| 6))
              |GBINTERN;redPo;DpolLR;14| |GBINTERN;credPol;DpolLDpol;20|
              (158 . +) (164 . ~=) (170 . |primitivePart|) (175 . ~=) (181 . +)
              |GBINTERN;minGbasis;2L;21| |GBINTERN;lepol;DpolI;22|
              |GBINTERN;prinb;IV;23| (187 . |coerce|) (192 . |print|)
              (|Record| (|:| |ci| 8) (|:| |tci| 26) (|:| |cj| 8) (|:| |tcj| 26)
                        (|:| |c| 8) (|:| |tc| 26) (|:| |rc| 8) (|:| |trc| 26)
                        (|:| |tF| 26) (|:| |tD| 26))
              (|List| 83) (197 . |coerce|) (202 . |coerce|)
              (|Record| (|:| |ci| 8) (|:| |tci| 26) (|:| |cj| 8) (|:| |tcj| 26)
                        (|:| |c| 8) (|:| |tc| 26) (|:| |rc| 8) (|:| |trc| 26)
                        (|:| |tF| 26) (|:| |tDD| 26) (|:| |tDF| 26))
              (|List| 87) (207 . |coerce|) |GBINTERN;fprindINFO;R2Dpol5I;27|)
           '#(|virtualDegree| 212 |updatF| 217 |updatD| 224 |sPol| 230 |redPol|
              235 |redPo| 241 |prinshINFO| 247 |prinpolINFO| 252 |prindINFO|
              257 |prinb| 267 |minGbasis| 272 |makeCrit| 277 |lepol| 284
              |hMonic| 289 |gbasisExtend| 294 |gbasis| 302 |fprindINFO| 309
              |critpOrder| 320 |critT| 326 |critMonD1| 331 |critMTonD1| 337
              |critM| 342 |critBonD| 348 |critB| 354 |credPol| 362)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|credPol| (|#3| |#3| (|List| |#3|))) T)
                                   '((|redPol| (|#3| |#3| (|List| |#3|))) T)
                                   '((|gbasis|
                                      ((|List| |#3|) (|List| |#3|) (|Integer|)
                                       (|Integer|)))
                                     T)
                                   '((|gbasisExtend|
                                      ((|List| |#3|) (|List| |#3|)
                                       (|List| |#3|) (|Integer|) (|Integer|)))
                                     T)
                                   '((|critT|
                                      ((|Boolean|)
                                       (|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))))
                                     T)
                                   '((|critM| ((|Boolean|) |#2| |#2|)) T)
                                   '((|critB|
                                      ((|Boolean|) |#2| |#2| |#2| |#2|))
                                     T)
                                   '((|critBonD|
                                      ((|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))
                                       |#3|
                                       (|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))))
                                     T)
                                   '((|critMTonD1|
                                      ((|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))
                                       (|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))))
                                     T)
                                   '((|critMonD1|
                                      ((|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))
                                       |#2|
                                       (|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))))
                                     T)
                                   '((|redPo|
                                      ((|Record| (|:| |poly| |#3|)
                                                 (|:| |mult| |#1|))
                                       |#3| (|List| |#3|)))
                                     T)
                                   '((|hMonic| (|#3| |#3|)) T)
                                   '((|updatF|
                                      ((|List|
                                        (|Record|
                                         (|:| |totdeg| (|NonNegativeInteger|))
                                         (|:| |pol| |#3|)))
                                       |#3| (|NonNegativeInteger|)
                                       (|List|
                                        (|Record|
                                         (|:| |totdeg| (|NonNegativeInteger|))
                                         (|:| |pol| |#3|)))))
                                     T)
                                   '((|sPol|
                                      (|#3|
                                       (|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))))
                                     T)
                                   '((|updatD|
                                      ((|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))
                                       (|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))
                                       (|List|
                                        (|Record| (|:| |lcmfij| |#2|)
                                                  (|:| |totdeg|
                                                       (|NonNegativeInteger|))
                                                  (|:| |poli| |#3|)
                                                  (|:| |polj| |#3|)))))
                                     T)
                                   '((|minGbasis|
                                      ((|List| |#3|) (|List| |#3|)))
                                     T)
                                   '((|lepol| ((|Integer|) |#3|)) T)
                                   '((|prinshINFO| ((|Void|) |#3|)) T)
                                   '((|prindINFO|
                                      ((|Integer|)
                                       (|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))
                                       |#3| |#3| (|Integer|) (|Integer|)
                                       (|Integer|)))
                                     T)
                                   '((|fprindINFO|
                                      ((|Integer|)
                                       (|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))
                                       |#3| |#3| (|Integer|) (|Integer|)
                                       (|Integer|) (|Integer|)))
                                     T)
                                   '((|prinpolINFO| ((|Void|) (|List| |#3|)))
                                     T)
                                   '((|prinb| ((|Void|) (|Integer|))) T)
                                   '((|critpOrder|
                                      ((|Boolean|)
                                       (|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))
                                       (|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))))
                                     T)
                                   '((|makeCrit|
                                      ((|Record| (|:| |lcmfij| |#2|)
                                                 (|:| |totdeg|
                                                      (|NonNegativeInteger|))
                                                 (|:| |poli| |#3|)
                                                 (|:| |polj| |#3|))
                                       (|Record|
                                        (|:| |totdeg| (|NonNegativeInteger|))
                                        (|:| |pol| |#3|))
                                       |#3| (|NonNegativeInteger|)))
                                     T)
                                   '((|virtualDegree|
                                      ((|NonNegativeInteger|) |#3|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 90
                                            '(1 8 9 0 10 1 0 9 8 11 2 7 12 0 0
                                              13 1 8 7 0 16 2 7 0 0 0 17 2 7 18
                                              0 0 19 0 6 0 20 0 8 0 21 2 8 0 6
                                              7 22 2 7 12 0 0 30 2 25 0 31 0 32
                                              2 36 0 35 0 37 0 6 0 45 0 7 0 46
                                              0 8 0 47 2 8 12 0 0 48 2 7 12 0 0
                                              50 2 25 0 0 8 51 1 54 43 53 55 2
                                              26 12 0 0 56 2 33 0 0 23 61 2 6 0
                                              0 0 62 2 6 18 0 0 63 1 8 6 0 64 1
                                              8 0 0 65 2 8 0 0 0 66 2 8 0 0 0
                                              67 2 8 0 6 0 68 2 6 0 0 0 69 2 7
                                              0 0 0 73 2 7 12 0 0 74 1 8 0 0 75
                                              2 8 12 0 0 76 2 8 0 0 0 77 1 8 54
                                              0 81 1 54 43 0 82 1 84 54 0 85 1
                                              26 54 0 86 1 88 54 0 89 1 0 9 8
                                              11 3 0 33 8 9 33 34 2 0 36 36 36
                                              40 1 0 8 14 41 2 0 8 8 25 42 2 0
                                              70 8 25 71 1 0 43 8 44 1 0 43 25
                                              52 6 0 26 14 8 8 26 26 26 49 1 0
                                              43 26 80 1 0 25 25 78 3 0 14 23 8
                                              9 24 1 0 26 8 79 1 0 8 8 29 4 0
                                              25 25 25 26 26 27 3 0 25 25 26 26
                                              28 7 0 26 14 8 8 26 26 26 26 90 2
                                              0 12 14 14 15 1 0 12 14 59 2 0 36
                                              7 36 58 1 0 36 36 38 2 0 12 7 7
                                              57 2 0 36 8 36 39 4 0 12 7 7 7 7
                                              60 2 0 8 8 25 72)))))
           '|lookupComplete|)) 
