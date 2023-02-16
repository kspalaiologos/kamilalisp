
(PUT '|REGSET;rep| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |REGSET;rep| ((|s| ($)) ($ (|List| P))) |s|) 

(PUT '|REGSET;per| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |REGSET;per| ((|l| (|List| P)) ($ ($))) |l|) 

(SDEFUN |REGSET;copy;2$;3| ((|ts| ($)) ($ ($)))
        (|REGSET;per| (SPADCALL (|REGSET;rep| |ts| $) (QREFELT $ 11)) $)) 

(SDEFUN |REGSET;empty;$;4| (($ ($))) (|REGSET;per| NIL $)) 

(SDEFUN |REGSET;empty?;$B;5| ((|ts| ($)) ($ (|Boolean|)))
        (NULL (|REGSET;rep| |ts| $))) 

(SDEFUN |REGSET;parts;$L;6| ((|ts| ($)) ($ (|List| P))) (|REGSET;rep| |ts| $)) 

(SDEFUN |REGSET;members;$L;7| ((|ts| ($)) ($ (|List| P))) (|REGSET;rep| |ts| $)) 

(SDEFUN |REGSET;map;M2$;8| ((|f| (|Mapping| P P)) (|ts| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (|REGSET;rep| |ts| $) (QREFELT $ 19))
                  (QREFELT $ 20))) 

(SDEFUN |REGSET;map!;M2$;9| ((|f| (|Mapping| P P)) (|ts| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (|REGSET;rep| |ts| $) (QREFELT $ 22))
                  (QREFELT $ 20))) 

(SDEFUN |REGSET;member?;P$B;10| ((|p| (P)) (|ts| ($)) ($ (|Boolean|)))
        (SPADCALL |p| (|REGSET;rep| |ts| $) (QREFELT $ 24))) 

(PUT '|REGSET;roughUnitIdeal?;$B;11| '|SPADreplace| '(XLAM (|ts|) NIL)) 

(SDEFUN |REGSET;roughUnitIdeal?;$B;11| ((|ts| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |REGSET;coerce;$Of;12| ((|ts| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G757 NIL) (|p| NIL) (#2=#:G756 NIL) (|lp| (|List| P)))
               (SEQ (LETT |lp| (REVERSE (|REGSET;rep| |ts| $)))
                    (EXIT
                     (SPADCALL
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (SPADCALL |p| (QREFELT $ 28)) #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (QREFELT $ 30)))))) 

(SDEFUN |REGSET;mvar;$V;13| ((|ts| ($)) ($ (V)))
        (COND
         ((SPADCALL |ts| (QREFELT $ 15)) (|error| "mvar$REGSET: #1 is empty"))
         ('T (SPADCALL (|SPADfirst| (|REGSET;rep| |ts| $)) (QREFELT $ 32))))) 

(SDEFUN |REGSET;first;$U;14| ((|ts| ($)) ($ (|Union| P "failed")))
        (COND ((SPADCALL |ts| (QREFELT $ 15)) (CONS 1 "failed"))
              ('T (CONS 0 (|SPADfirst| (|REGSET;rep| |ts| $)))))) 

(SDEFUN |REGSET;last;$U;15| ((|ts| ($)) ($ (|Union| P "failed")))
        (COND ((SPADCALL |ts| (QREFELT $ 15)) (CONS 1 "failed"))
              ('T (CONS 0 (SPADCALL (|REGSET;rep| |ts| $) (QREFELT $ 36)))))) 

(SDEFUN |REGSET;rest;$U;16| ((|ts| ($)) ($ (|Union| $ "failed")))
        (COND ((SPADCALL |ts| (QREFELT $ 15)) (CONS 1 "failed"))
              ('T (CONS 0 (|REGSET;per| (CDR (|REGSET;rep| |ts| $)) $))))) 

(SDEFUN |REGSET;coerce;$L;17| ((|ts| ($)) ($ (|List| P))) (|REGSET;rep| |ts| $)) 

(SDEFUN |REGSET;collectUpper;$V$;18| ((|ts| ($)) (|v| (V)) ($ ($)))
        (SPROG ((|lp| (|List| P)) (|newlp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 15)) |ts|)
                      ('T
                       (SEQ (LETT |lp| (|REGSET;rep| |ts| $))
                            (LETT |newlp| NIL)
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lp|) NIL)
                                          ('T
                                           (SPADCALL
                                            (SPADCALL (|SPADfirst| |lp|)
                                                      (QREFELT $ 32))
                                            |v| (QREFELT $ 41)))))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |newlp|
                                        (CONS (|SPADfirst| |lp|) |newlp|))
                                  (EXIT (LETT |lp| (CDR |lp|))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (|REGSET;per| (REVERSE |newlp|) $)))))))) 

(SDEFUN |REGSET;collectUnder;$V$;19| ((|ts| ($)) (|v| (V)) ($ ($)))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 15)) |ts|)
                      ('T
                       (SEQ (LETT |lp| (|REGSET;rep| |ts| $))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lp|) NIL)
                                          ('T
                                           (SPADCALL
                                            (SPADCALL (|SPADfirst| |lp|)
                                                      (QREFELT $ 32))
                                            |v| (QREFELT $ 43)))))
                                   (GO G191)))
                                 (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL
                                 (GO G190) G191 (EXIT NIL))
                            (EXIT (|REGSET;per| |lp| $)))))))) 

(SDEFUN |REGSET;construct;L$;20| ((|lp| (|List| P)) ($ ($)))
        (SPROG ((|ts| ($)) (|eif| (|Union| $ "failed")))
               (SEQ (LETT |ts| (|REGSET;per| NIL $))
                    (EXIT
                     (COND ((NULL |lp|) |ts|)
                           ('T
                            (SEQ
                             (LETT |lp|
                                   (SPADCALL (ELT $ 45) |lp| (QREFELT $ 47)))
                             (SEQ G190
                                  (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                                  (SEQ
                                   (LETT |eif|
                                         (SPADCALL |ts| (|SPADfirst| |lp|)
                                                   (QREFELT $ 48)))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |eif| 0)
                                      (SEQ (LETT |ts| (QCDR |eif|))
                                           (EXIT (LETT |lp| (CDR |lp|)))))
                                     ('T
                                      (|error|
                                       "in construct : List P -> %  from REGSET : bad #1")))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT |ts|)))))))) 

(SDEFUN |REGSET;extendIfCan;$PU;21|
        ((|ts| ($)) (|p| (P)) ($ (|Union| $ "failed")))
        (SEQ
         (COND ((SPADCALL |p| (QREFELT $ 49)) (CONS 1 "failed"))
               ((SPADCALL |ts| (QREFELT $ 15))
                (SEQ (LETT |p| (SPADCALL |p| (QREFELT $ 50)))
                     (EXIT (CONS 0 (|REGSET;per| (LIST |p|) $)))))
               ((NULL
                 (SPADCALL (SPADCALL |ts| (QREFELT $ 33))
                           (SPADCALL |p| (QREFELT $ 32)) (QREFELT $ 51)))
                (CONS 1 "failed"))
               ('T
                (COND
                 ((SPADCALL (SPADCALL |p| (QREFELT $ 52)) |ts| (QREFELT $ 53))
                  (CONS 0 (|REGSET;per| (CONS |p| (|REGSET;rep| |ts| $)) $)))
                 ('T (CONS 1 "failed"))))))) 

(SDEFUN |REGSET;removeZero;P$P;22| ((|p| (P)) (|ts| ($)) ($ (P)))
        (SPROG
         ((|q| (P)) (#1=#:G835 NIL) (#2=#:G822 NIL) (|ts_v-| ($)) (|v| (V)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL |p| (QREFELT $ 49)) (SPADCALL |ts| (QREFELT $ 15)))
             |p|)
            ('T
             (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 32)))
                  (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 44)))
                  (COND
                   ((SPADCALL |v| |ts| (QREFELT $ 54))
                    (SEQ
                     (LETT |q|
                           (SPADCALL |p|
                                     (PROG2
                                         (LETT #2#
                                               (SPADCALL |ts| |v|
                                                         (QREFELT $ 55)))
                                         (QCDR #2#)
                                       (|check_union2| (QEQCAR #2# 0)
                                                       (QREFELT $ 9)
                                                       (|Union| (QREFELT $ 9)
                                                                "failed")
                                                       #2#))
                                     (QREFELT $ 56)))
                     (EXIT
                      (COND
                       ((SPADCALL |q| (QREFELT $ 57))
                        (PROGN (LETT #1# |q|) (GO #3=#:G834)))
                       ((SPADCALL (SPADCALL |q| |ts_v-| (QREFELT $ 58))
                                  (QREFELT $ 57))
                        (PROGN (LETT #1# (|spadConstant| $ 59)) (GO #3#))))))))
                  (EXIT
                   (COND ((SPADCALL |ts_v-| (QREFELT $ 15)) |p|)
                         ('T
                          (SEQ (LETT |q| (|spadConstant| $ 59))
                               (SEQ G190
                                    (COND
                                     ((NULL
                                       (PLUSP
                                        (SPADCALL |p| |v| (QREFELT $ 61))))
                                      (GO G191)))
                                    (SEQ
                                     (LETT |q|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |p| (QREFELT $ 52))
                                              |ts_v-| (QREFELT $ 58))
                                             (SPADCALL |p| (QREFELT $ 62))
                                             (QREFELT $ 63))
                                            |q| (QREFELT $ 64)))
                                     (EXIT
                                      (LETT |p|
                                            (SPADCALL |p| (QREFELT $ 65)))))
                                    NIL (GO G190) G191 (EXIT NIL))
                               (EXIT
                                (SPADCALL |q|
                                          (SPADCALL |p| |ts_v-| (QREFELT $ 58))
                                          (QREFELT $ 64)))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |REGSET;internalAugment;P2$;23| ((|p| (P)) (|ts| ($)) ($ ($)))
        (COND
         ((SPADCALL |p| (QREFELT $ 49))
          (|error| "in internalAugment$REGSET: ground? #1"))
         ('T
          (SPADCALL (SPADCALL |p| |ts| NIL NIL NIL NIL NIL (QREFELT $ 66))
                    (QREFELT $ 68))))) 

(SDEFUN |REGSET;internalAugment;L2$;24| ((|lp| (|List| P)) (|ts| ($)) ($ ($)))
        (COND ((NULL |lp|) |ts|)
              ('T
               (SPADCALL (CDR |lp|)
                         (SPADCALL (|SPADfirst| |lp|) |ts| (QREFELT $ 69))
                         (QREFELT $ 70))))) 

(SDEFUN |REGSET;internalAugment;P$5BL;25|
        ((|p| (P)) (|ts| ($)) (|rem?| (|Boolean|)) (|red?| (|Boolean|))
         (|prim?| (|Boolean|)) (|sqfr?| (|Boolean|)) (|extend?| (|Boolean|))
         ($ (|List| $)))
        (SPROG
         ((#1=#:G859 NIL) (|us| NIL) (#2=#:G858 NIL) (|lts| (|List| $))
          (#3=#:G857 NIL) (|f| NIL) (#4=#:G856 NIL) (|lsfp| (|List| P))
          (|ts_v+| ($)) (|ts_v-| ($)) (|v| (V)))
         (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 32)))
              (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 44)))
              (LETT |ts_v+| (SPADCALL |ts| |v| (QREFELT $ 42)))
              (COND
               (|rem?|
                (LETT |p| (QVELT (SPADCALL |p| |ts_v-| (QREFELT $ 72)) 1))))
              (COND (|red?| (LETT |p| (SPADCALL |p| |ts_v-| (QREFELT $ 58)))))
              (COND (|prim?| (LETT |p| (SPADCALL |p| (QREFELT $ 73)))))
              (COND
               (|sqfr?|
                (SEQ (LETT |lsfp| (SPADCALL |p| (QREFELT $ 75)))
                     (EXIT
                      (LETT |lts|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT |f| NIL) (LETT #3# |lsfp|) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |f| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #4#
                                          (CONS
                                           (|REGSET;per|
                                            (CONS |f| (|REGSET;rep| |ts_v-| $))
                                            $)
                                           #4#))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT (NREVERSE #4#))))))))
               (#5='T
                (LETT |lts|
                      (LIST
                       (|REGSET;per| (CONS |p| (|REGSET;rep| |ts_v-| $)) $)))))
              (EXIT
               (COND
                (|extend?|
                 (SPADCALL (SPADCALL |ts_v+| (QREFELT $ 17)) |lts|
                           (QREFELT $ 76)))
                (#5#
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |us| NIL) (LETT #1# |lts|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |us| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (|REGSET;per|
                                 (SPADCALL (|REGSET;rep| |ts_v+| $)
                                           (|REGSET;rep| |us| $)
                                           (QREFELT $ 77))
                                 $)
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |REGSET;augment;P$L;26| ((|p| (P)) (|ts| ($)) ($ (|List| $)))
        (COND
         ((SPADCALL |p| (QREFELT $ 49))
          (|error| "in augment$REGSET: ground? #1"))
         ((SPADCALL (SPADCALL |p| (QREFELT $ 32)) |ts| (QREFELT $ 54))
          (|error| "in augment$REGSET: bad #1"))
         ('T (SPADCALL |p| |ts| 'T 'T 'T 'T 'T (QREFELT $ 66))))) 

(SDEFUN |REGSET;extend;P$L;27| ((|p| (P)) (|ts| ($)) ($ (|List| $)))
        (SPROG
         ((|lts| (|List| $)) (#1=#:G869 NIL) (|us| NIL) (|split| (|List| $)))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 49))
            (|error| "in extend$REGSET: ground? #1"))
           ((NULL
             (SPADCALL (SPADCALL |ts| (QREFELT $ 33))
                       (SPADCALL |p| (QREFELT $ 32)) (QREFELT $ 51)))
            (|error| "in extend$REGSET: bad #1"))
           ('T
            (SEQ (LETT |lts| NIL)
                 (LETT |split|
                       (SPADCALL (SPADCALL |p| (QREFELT $ 52)) |ts|
                                 (QREFELT $ 79)))
                 (SEQ (LETT |us| NIL) (LETT #1# |split|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |us| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |lts|
                              (SPADCALL (SPADCALL |p| |us| (QREFELT $ 78))
                                        |lts| (QREFELT $ 80)))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (EXIT |lts|))))))) 

(SDEFUN |REGSET;invertible?;P$B;28| ((|p| (P)) (|ts| ($)) ($ (|Boolean|)))
        (SPADCALL |p| |ts| (QREFELT $ 83))) 

(SDEFUN |REGSET;invertible?;P$L;29|
        ((|p| (P)) (|ts| ($))
         ($ (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| $)))))
        (SPADCALL |p| |ts| (QREFELT $ 86))) 

(SDEFUN |REGSET;invertibleSet;P$L;30| ((|p| (P)) (|ts| ($)) ($ (|List| $)))
        (SPADCALL |p| |ts| (QREFELT $ 90))) 

(SDEFUN |REGSET;lastSubResultant;2P$L;31|
        ((|p1| (P)) (|p2| (P)) (|ts| ($))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| $)))))
        (SPADCALL |p1| |p2| |ts| (QREFELT $ 93))) 

(SDEFUN |REGSET;squareFreePart;P$L;32|
        ((|p| (P)) (|ts| ($))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| $)))))
        (SPADCALL |p| |ts| (QREFELT $ 97))) 

(SDEFUN |REGSET;intersect;P$L;33| ((|p| (P)) (|ts| ($)) ($ (|List| $)))
        (SPADCALL (LIST |p|) (LIST |ts|) NIL NIL (QREFELT $ 100))) 

(SDEFUN |REGSET;intersect;L2L;34|
        ((|lp| (|List| P)) (|lts| (|List| $)) ($ (|List| $)))
        (SPADCALL |lp| |lts| NIL NIL (QREFELT $ 100))) 

(SDEFUN |REGSET;zeroSetSplit;LL;35| ((|lp| (|List| P)) ($ (|List| $)))
        (SPADCALL |lp| 'T NIL (QREFELT $ 103))) 

(SDEFUN |REGSET;zeroSetSplit;LBL;36|
        ((|lp| (|List| P)) (|clos?| (|Boolean|)) ($ (|List| $)))
        (SPADCALL |lp| |clos?| NIL (QREFELT $ 103))) 

(SDEFUN |REGSET;zeroSetSplit;L2BL;37|
        ((|lp| (|List| P)) (|clos?| (|Boolean|)) (|info?| (|Boolean|))
         ($ (|List| $)))
        (SPADCALL |lp| 'T |clos?| |info?| 'T (QREFELT $ 106))) 

(SDEFUN |REGSET;zeroSetSplit;L4BL;38|
        ((|lp| (|List| P)) (|hash?| (|Boolean|)) (|clos?| (|Boolean|))
         (|info?| (|Boolean|)) (|prep?| (|Boolean|)) ($ (|List| $)))
        (SPROG
         ((|lts| (|List| $)) (|dom3| #1=(|String|)) (|dom2| #1#) (|dom1| #1#)
          (|#G94| #2=(|String|)) (|#G93| #2#) (|#G92| #2#)
          (|#G91| (#3="REGSETGCD: Inv Set")) (|#G90| (#4="REGSETGCD: Gcd"))
          (|#G89| (#5="QCMPACK")) (|s3| #1#) (|s2| #1#) (|s1| #1#) (|#G85| #2#)
          (|#G84| #2#) (|#G83| #2#) (|#G82| (#6="i")) (|#G81| (#7="g"))
          (|#G80| (#8="w")) (|e| #2#))
         (SEQ
          (COND
           (|hash?|
            (SEQ (LETT |e| (|make_full_CVEC| 0))
                 (COND
                  (|info?|
                   (PROGN
                    (LETT |#G80| #8#)
                    (LETT |#G81| #7#)
                    (LETT |#G82| #6#)
                    (LETT |s1| |#G80|)
                    (LETT |s2| |#G81|)
                    (LETT |s3| |#G82|)))
                  (#9='T
                   (PROGN
                    (LETT |#G83| |e|)
                    (LETT |#G84| |e|)
                    (LETT |#G85| |e|)
                    (LETT |s1| |#G83|)
                    (LETT |s2| |#G84|)
                    (LETT |s3| |#G85|))))
                 (COND
                  (|info?|
                   (PROGN
                    (LETT |#G89| #5#)
                    (LETT |#G90| #4#)
                    (LETT |#G91| #3#)
                    (LETT |dom1| |#G89|)
                    (LETT |dom2| |#G90|)
                    (LETT |dom3| |#G91|)))
                  (#9#
                   (PROGN
                    (LETT |#G92| |e|)
                    (LETT |#G93| |e|)
                    (LETT |#G94| |e|)
                    (LETT |dom1| |#G92|)
                    (LETT |dom2| |#G93|)
                    (LETT |dom3| |#G94|))))
                 (SPADCALL |s1| "W" |dom1| (QREFELT $ 110))
                 (SPADCALL |s2| "G" |dom2| (QREFELT $ 111))
                 (EXIT (SPADCALL |s3| "I" |dom3| (QREFELT $ 112))))))
          (LETT |lts| (SPADCALL |lp| |clos?| |info?| |prep?| (QREFELT $ 113)))
          (COND
           (|hash?|
            (SEQ (SPADCALL (QREFELT $ 114)) (SPADCALL (QREFELT $ 115))
                 (EXIT (SPADCALL (QREFELT $ 116))))))
          (EXIT |lts|)))) 

(SDEFUN |REGSET;internalZeroSetSplit;L3BL;39|
        ((|lp| (|List| P)) (|clos?| (|Boolean|)) (|info?| (|Boolean|))
         (|prep?| (|Boolean|)) ($ (|List| $)))
        (SPROG
         ((|lts| #1=(|List| $)) (#2=#:G910 NIL) (|p| NIL) (|ts| ($))
          (|pp| (|Record| (|:| |val| (|List| P)) (|:| |towers| #1#))))
         (SEQ
          (COND
           (|prep?|
            (SEQ (LETT |pp| (SPADCALL |lp| |clos?| |info?| (QREFELT $ 118)))
                 (LETT |lp| (QCAR |pp|)) (EXIT (LETT |lts| (QCDR |pp|)))))
           (#3='T
            (SEQ (LETT |ts| (SPADCALL NIL (QREFELT $ 20)))
                 (EXIT (LETT |lts| (LIST |ts|))))))
          (LETT |lp| (SPADCALL (ELT $ 57) |lp| (QREFELT $ 120)))
          (EXIT
           (COND ((SPADCALL (ELT $ 49) |lp| (QREFELT $ 121)) NIL)
                 ((OR (NULL |lp|) (SPADCALL |lts| (QREFELT $ 122))) |lts|)
                 ('T
                  (SEQ (LETT |lp| (SPADCALL (ELT $ 45) |lp| (QREFELT $ 47)))
                       (EXIT
                        (COND
                         (|clos?|
                          (SPADCALL |lp| |lts| |clos?| |info?|
                                    (QREFELT $ 100)))
                         (#3#
                          (SEQ
                           (SEQ (LETT |p| NIL) (LETT #2# |lp|) G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |p| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |lts|
                                        (SPADCALL (LIST |p|) |lts| |clos?|
                                                  |info?| (QREFELT $ 100)))))
                                (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |lts|)))))))))))) 

(SDEFUN |REGSET;largeSystem?| ((|lp| (|List| P)) ($ (|Boolean|)))
        (SPROG ((|lts| (|List| $)))
               (SEQ
                (COND ((> (LENGTH |lp|) 16) 'T) ((< (LENGTH |lp|) 13) NIL)
                      ('T
                       (SEQ (LETT |lts| NIL)
                            (EXIT
                             (>
                              (- (LENGTH |lp|)
                                 (SPADCALL |lp| |lts| (QREFELT $ 123)))
                              3)))))))) 

(SDEFUN |REGSET;smallSystem?| ((|lp| (|List| P)) ($ (|Boolean|)))
        (< (LENGTH |lp|) 5)) 

(SDEFUN |REGSET;mediumSystem?| ((|lp| (|List| P)) ($ (|Boolean|)))
        (SPROG ((|lts| (|List| $)))
               (SEQ (LETT |lts| NIL)
                    (EXIT
                     (< (- (SPADCALL |lp| |lts| (QREFELT $ 123)) (LENGTH |lp|))
                        2))))) 

(SDEFUN |REGSET;lin?| ((|p| (P)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |p| (QREFELT $ 52)) (QREFELT $ 49))
          (EQL (SPADCALL |p| (QREFELT $ 124)) 1))
         ('T NIL))) 

(SDEFUN |REGSET;pre_process;L2BR;44|
        ((|lp| (|List| P)) (|clos?| (|Boolean|)) (|info?| (|Boolean|))
         ($ (|Record| (|:| |val| (|List| P)) (|:| |towers| (|List| $)))))
        (SPROG
         ((#1=#:G972 NIL) (|lp2| (|List| P)) (|lts| (|List| $)) (#2=#:G985 NIL)
          (|p| NIL) (|lp3| (|List| P)) (#3=#:G984 NIL) (|lp4| (|List| P))
          (#4=#:G983 NIL) (#5=#:G982 NIL) (#6=#:G981 NIL) (#7=#:G980 NIL)
          (#8=#:G979 NIL) (#9=#:G978 NIL) (#10=#:G977 NIL) (#11=#:G976 NIL)
          (#12=#:G975 NIL) (#13=#:G974 NIL) (|lp1| (|List| P)) (#14=#:G973 NIL)
          (|ts| ($)))
         (SEQ
          (EXIT
           (SEQ (LETT |ts| (SPADCALL NIL (QREFELT $ 20)))
                (LETT |lts| (LIST |ts|))
                (EXIT
                 (COND ((NULL |lp|) (CONS |lp| |lts|))
                       (#15='T
                        (SEQ (LETT |lp1| NIL) (LETT |lp2| NIL)
                             (SEQ (LETT |p| NIL) (LETT #14# |lp|) G190
                                  (COND
                                   ((OR (ATOM #14#)
                                        (PROGN (LETT |p| (CAR #14#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL (SPADCALL |p| (QREFELT $ 65))
                                                (QREFELT $ 49))
                                      (LETT |lp1| (CONS |p| |lp1|)))
                                     ('T (LETT |lp2| (CONS |p| |lp2|))))))
                                  (LETT #14# (CDR #14#)) (GO G190) G191
                                  (EXIT NIL))
                             (LETT |lts|
                                   (SPADCALL |lp1| (LIST |ts|) |clos?| |info?|
                                             (QREFELT $ 100)))
                             (EXIT
                              (COND
                               ((SPADCALL |lp| (QREFELT $ 126))
                                (COND
                                 ((|REGSET;largeSystem?| |lp| $)
                                  (PROGN
                                   (LETT #1# (CONS |lp2| |lts|))
                                   (GO #16=#:G971)))
                                 (#15#
                                  (SEQ
                                   (COND
                                    ((> (LENGTH |lp|) 7)
                                     (SEQ
                                      (LETT |lp2|
                                            (SPADCALL |lp2| (QREFELT $ 127)))
                                      (LETT |lp2|
                                            (SPADCALL (ELT $ 57) |lp2|
                                                      (QREFELT $ 120)))
                                      (EXIT
                                       (COND
                                        ((SPADCALL (ELT $ 49) |lp2|
                                                   (QREFELT $ 121))
                                         (PROGN
                                          (LETT #1# (CONS |lp2| |lts|))
                                          (GO #16#)))
                                        (#15#
                                         (SEQ
                                          (LETT |lp3|
                                                (PROGN
                                                 (LETT #13# NIL)
                                                 (SEQ (LETT |p| NIL)
                                                      (LETT #12# |lp2|) G190
                                                      (COND
                                                       ((OR (ATOM #12#)
                                                            (PROGN
                                                             (LETT |p|
                                                                   (CAR #12#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (COND
                                                         ((|REGSET;lin?| |p| $)
                                                          (LETT #13#
                                                                (CONS |p|
                                                                      #13#))))))
                                                      (LETT #12# (CDR #12#))
                                                      (GO G190) G191
                                                      (EXIT (NREVERSE #13#)))))
                                          (LETT |lp4|
                                                (PROGN
                                                 (LETT #11# NIL)
                                                 (SEQ (LETT |p| NIL)
                                                      (LETT #10# |lp2|) G190
                                                      (COND
                                                       ((OR (ATOM #10#)
                                                            (PROGN
                                                             (LETT |p|
                                                                   (CAR #10#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (COND
                                                         ((NULL
                                                           (|REGSET;lin?| |p|
                                                            $))
                                                          (LETT #11#
                                                                (CONS |p|
                                                                      #11#))))))
                                                      (LETT #10# (CDR #10#))
                                                      (GO G190) G191
                                                      (EXIT (NREVERSE #11#)))))
                                          (COND
                                           (|clos?|
                                            (LETT |lts|
                                                  (SPADCALL |lp4| |lts| |clos?|
                                                            |info?|
                                                            (QREFELT $ 100))))
                                           (#15#
                                            (SEQ
                                             (LETT |lp4|
                                                   (SPADCALL (ELT $ 45) |lp4|
                                                             (QREFELT $ 47)))
                                             (EXIT
                                              (SEQ (LETT |p| NIL)
                                                   (LETT #9# |lp4|) G190
                                                   (COND
                                                    ((OR (ATOM #9#)
                                                         (PROGN
                                                          (LETT |p| (CAR #9#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT |lts|
                                                           (SPADCALL (LIST |p|)
                                                                     |lts|
                                                                     |clos?|
                                                                     |info?|
                                                                     (QREFELT $
                                                                              100)))))
                                                   (LETT #9# (CDR #9#))
                                                   (GO G190) G191
                                                   (EXIT NIL))))))
                                          (EXIT (LETT |lp2| |lp3|))))))))
                                    (#15#
                                     (SEQ
                                      (LETT |lp2|
                                            (SPADCALL |lp2| (QREFELT $ 127)))
                                      (LETT |lp2|
                                            (SPADCALL (ELT $ 57) |lp2|
                                                      (QREFELT $ 120)))
                                      (EXIT
                                       (COND
                                        ((SPADCALL (ELT $ 49) |lp2|
                                                   (QREFELT $ 121))
                                         (PROGN
                                          (LETT #1# (CONS |lp2| |lts|))
                                          (GO #16#))))))))
                                   (COND
                                    (|clos?|
                                     (LETT |lts|
                                           (SPADCALL |lp2| |lts| |clos?|
                                                     |info?| (QREFELT $ 100))))
                                    (#15#
                                     (SEQ
                                      (LETT |lp2|
                                            (SPADCALL (ELT $ 45) |lp2|
                                                      (QREFELT $ 47)))
                                      (EXIT
                                       (SEQ (LETT |p| NIL) (LETT #8# |lp2|)
                                            G190
                                            (COND
                                             ((OR (ATOM #8#)
                                                  (PROGN
                                                   (LETT |p| (CAR #8#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT |lts|
                                                    (SPADCALL (LIST |p|) |lts|
                                                              |clos?| |info?|
                                                              (QREFELT $
                                                                       100)))))
                                            (LETT #8# (CDR #8#)) (GO G190) G191
                                            (EXIT NIL))))))
                                   (LETT |lp2| NIL)
                                   (EXIT
                                    (PROGN
                                     (LETT #1# (CONS |lp2| |lts|))
                                     (GO #16#)))))))
                               ((|REGSET;smallSystem?| |lp| $)
                                (CONS |lp2| |lts|))
                               ((|REGSET;mediumSystem?| |lp| $)
                                (CONS (SPADCALL |lp2| (QREFELT $ 127)) |lts|))
                               (#15#
                                (SEQ
                                 (LETT |lp3|
                                       (PROGN
                                        (LETT #7# NIL)
                                        (SEQ (LETT |p| NIL) (LETT #6# |lp2|)
                                             G190
                                             (COND
                                              ((OR (ATOM #6#)
                                                   (PROGN
                                                    (LETT |p| (CAR #6#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((|REGSET;lin?| |p| $)
                                                 (LETT #7# (CONS |p| #7#))))))
                                             (LETT #6# (CDR #6#)) (GO G190)
                                             G191 (EXIT (NREVERSE #7#)))))
                                 (LETT |lp4|
                                       (PROGN
                                        (LETT #5# NIL)
                                        (SEQ (LETT |p| NIL) (LETT #4# |lp2|)
                                             G190
                                             (COND
                                              ((OR (ATOM #4#)
                                                   (PROGN
                                                    (LETT |p| (CAR #4#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((NULL (|REGSET;lin?| |p| $))
                                                 (LETT #5# (CONS |p| #5#))))))
                                             (LETT #4# (CDR #4#)) (GO G190)
                                             G191 (EXIT (NREVERSE #5#)))))
                                 (COND
                                  (|clos?|
                                   (LETT |lts|
                                         (SPADCALL |lp4| |lts| |clos?| |info?|
                                                   (QREFELT $ 100))))
                                  (#15#
                                   (SEQ
                                    (LETT |lp4|
                                          (SPADCALL (ELT $ 45) |lp4|
                                                    (QREFELT $ 47)))
                                    (EXIT
                                     (SEQ (LETT |p| NIL) (LETT #3# |lp4|) G190
                                          (COND
                                           ((OR (ATOM #3#)
                                                (PROGN
                                                 (LETT |p| (CAR #3#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT |lts|
                                                  (SPADCALL (LIST |p|) |lts|
                                                            |clos?| |info?|
                                                            (QREFELT $ 100)))))
                                          (LETT #3# (CDR #3#)) (GO G190) G191
                                          (EXIT NIL))))))
                                 (COND
                                  (|clos?|
                                   (LETT |lts|
                                         (SPADCALL |lp3| |lts| |clos?| |info?|
                                                   (QREFELT $ 100))))
                                  (#15#
                                   (SEQ
                                    (LETT |lp3|
                                          (SPADCALL (ELT $ 45) |lp3|
                                                    (QREFELT $ 47)))
                                    (EXIT
                                     (SEQ (LETT |p| NIL) (LETT #2# |lp3|) G190
                                          (COND
                                           ((OR (ATOM #2#)
                                                (PROGN
                                                 (LETT |p| (CAR #2#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT |lts|
                                                  (SPADCALL (LIST |p|) |lts|
                                                            |clos?| |info?|
                                                            (QREFELT $ 100)))))
                                          (LETT #2# (CDR #2#)) (GO G190) G191
                                          (EXIT NIL))))))
                                 (LETT |lp2| NIL)
                                 (EXIT
                                  (PROGN
                                   (LETT #1# (CONS |lp2| |lts|))
                                   (GO #16#)))))))))))))
          #16# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |RegularTriangularSet;|)) 

(DEFUN |RegularTriangularSet| (&REST #1=#:G1004)
  (SPROG NIL
         (PROG (#2=#:G1005)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RegularTriangularSet|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RegularTriangularSet;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RegularTriangularSet|)))))))))) 

(DEFUN |RegularTriangularSet;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((#1=#:G1003 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|RegularTriangularSet| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 145))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#4|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#4|)))
                                         (|HasCategory| |#4| '(|SetCategory|)))
                                        (|HasCategory| |#4|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#4| '(|BasicType|))
                                        (|HasCategory| |#4| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#3| '(|Finite|))))))
    (|haddProp| |$ConstructorCache| '|RegularTriangularSet|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 64))
    (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 128))
    (AND (|HasCategory| |#4| '(|BasicType|)) #1# (|augmentPredVector| $ 256))
    (AND (|HasCategory| |#4| '(|OrderedSet|)) #1# (|augmentPredVector| $ 512))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|RegularTriangularSet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 9) (0 . |copy|)
              |REGSET;copy;2$;3| |REGSET;empty;$;4| (|Boolean|)
              |REGSET;empty?;$B;5| |REGSET;parts;$L;6| |REGSET;members;$L;7|
              (|Mapping| 9 9) (5 . |map|) |REGSET;construct;L$;20|
              |REGSET;map;M2$;8| (11 . |map!|) |REGSET;map!;M2$;9|
              (17 . |member?|) |REGSET;member?;P$B;10|
              |REGSET;roughUnitIdeal?;$B;11| (|OutputForm|) (23 . |coerce|)
              (|List| $) (28 . |brace|) |REGSET;coerce;$Of;12| (33 . |mvar|)
              |REGSET;mvar;$V;13| (|Union| 9 '#1="failed") |REGSET;first;$U;14|
              (38 . |last|) |REGSET;last;$U;15| (|Union| $ '#1#)
              |REGSET;rest;$U;16| |REGSET;coerce;$L;17| (43 . >)
              |REGSET;collectUpper;$V$;18| (49 . >=)
              |REGSET;collectUnder;$V$;19| (55 . |infRittWu?|)
              (|Mapping| 14 9 9) (61 . |sort|) |REGSET;extendIfCan;$PU;21|
              (67 . |ground?|) (72 . |primitivePart|) (77 . <) (83 . |init|)
              |REGSET;invertible?;P$B;28| (88 . |algebraic?|) (94 . |select|)
              (100 . |lazyPrem|) (106 . |zero?|) |REGSET;removeZero;P$P;22|
              (111 . |Zero|) (|NonNegativeInteger|) (115 . |degree|)
              (121 . |mainMonomial|) (126 . *) (132 . +) (138 . |tail|)
              |REGSET;internalAugment;P$5BL;25| (|List| $$) (143 . |first|)
              |REGSET;internalAugment;P2$;23| |REGSET;internalAugment;L2$;24|
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (148 . |remainder|) (154 . |mainPrimitivePart|)
              (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (159 . |squareFreeFactors|) (164 . |extend|) (170 . |concat|)
              |REGSET;augment;P$L;26| |REGSET;invertibleSet;P$L;30|
              (176 . |concat|) |REGSET;extend;P$L;27|
              (|RegularTriangularSetGcdPackage| 6 7 8 9 $$)
              (182 . |toseInvertible?|)
              (|Record| (|:| |val| 14) (|:| |tower| $$)) (|List| 84)
              (188 . |toseInvertible?|)
              (|Record| (|:| |val| 14) (|:| |tower| $)) (|List| 87)
              |REGSET;invertible?;P$L;29| (194 . |toseInvertibleSet|)
              (|Record| (|:| |val| 9) (|:| |tower| $$)) (|List| 91)
              (200 . |toseLastSubResultant|)
              (|Record| (|:| |val| 9) (|:| |tower| $)) (|List| 94)
              |REGSET;lastSubResultant;2P$L;31| (207 . |toseSquareFreePart|)
              |REGSET;squareFreePart;P$L;32|
              (|RegularSetDecompositionPackage| 6 7 8 9 $$) (213 . |decompose|)
              |REGSET;intersect;P$L;33| |REGSET;intersect;L2L;34|
              |REGSET;zeroSetSplit;L2BL;37| |REGSET;zeroSetSplit;LL;35|
              |REGSET;zeroSetSplit;LBL;36| |REGSET;zeroSetSplit;L4BL;38|
              (|Void|) (|String|) (|QuasiComponentPackage| 6 7 8 9 $$)
              (221 . |startTable!|) (228 . |startTableGcd!|)
              (235 . |startTableInvSet!|) |REGSET;internalZeroSetSplit;L3BL;39|
              (242 . |stopTable!|) (246 . |stopTableGcd!|)
              (250 . |stopTableInvSet!|)
              (|Record| (|:| |val| 10) (|:| |towers| 29))
              |REGSET;pre_process;L2BR;44| (|Mapping| 14 9) (254 . |remove|)
              (260 . |any?|) (266 . |empty?|) (271 . |numberOfVariables|)
              (277 . |mdeg|) (282 . |One|) (286 . |probablyZeroDim?|)
              (291 . |crushedSet|) (|Mapping| 9 9 9) (|List| 130)
              (|Equation| 9) (|InputForm|)
              (|Record| (|:| |num| 9) (|:| |den| 6)) (|Union| 9 29)
              (|Union| 14 29) (|List| 8)
              (|Record| (|:| |close| $) (|:| |open| 10)) (|List| 136)
              (|Mapping| 14 9 10) (|Record| (|:| |close| 10) (|:| |open| 10))
              (|Record| (|:| |bas| $) (|:| |top| 10)) (|Union| 140 '#1#)
              (|Record| (|:| |under| $) (|:| |floor| $) (|:| |upper| $))
              (|SingleInteger|) (|HashState|))
           '#(~= 296 |zeroSetSplitIntoTriangularSystems| 302 |zeroSetSplit| 307
              |variables| 334 |trivialIdeal?| 339 |triangular?| 344
              |stronglyReduced?| 349 |stronglyReduce| 360 |squareFreePart| 366
              |sort| 372 |size?| 378 |select| 384 |sample| 396
              |roughUnitIdeal?| 400 |roughSubIdeal?| 405 |roughEqualIdeals?|
              411 |roughBase?| 417 |rewriteSetWithReduction| 422
              |rewriteIdealWithRemainder| 430 |rewriteIdealWithHeadRemainder|
              436 |retractIfCan| 442 |retract| 447 |rest| 452 |removeZero| 457
              |removeDuplicates| 463 |remove| 468 |remainder| 480 |reduced?|
              486 |reduceByQuasiMonic| 493 |reduce| 499 |quasiComponent| 528
              |purelyTranscendental?| 533 |purelyAlgebraicLeadingMonomial?| 539
              |purelyAlgebraic?| 545 |pre_process| 556 |parts| 563
              |normalized?| 568 |mvar| 579 |more?| 584 |min| 590 |members| 595
              |member?| 600 |max| 606 |map!| 617 |map| 623 |mainVariables| 629
              |mainVariable?| 634 |less?| 640 |latex| 646
              |lastSubResultantElseSplit| 651 |lastSubResultant| 658 |last| 665
              |invertibleSet| 670 |invertibleElseSplit?| 676 |invertible?| 682
              |intersect| 694 |internalZeroSetSplit| 718 |internalAugment| 726
              |initials| 749 |initiallyReduced?| 754 |initiallyReduce| 765
              |infRittWu?| 771 |iexactQuo| 777 |headRemainder| 783
              |headReduced?| 789 |headReduce| 800 |hashUpdate!| 806 |hash| 812
              |first| 817 |find| 822 |extendIfCan| 828 |extend| 834 |every?|
              864 |eval| 870 |eq?| 896 |empty?| 902 |empty| 907 |degree| 911
              |count| 916 |copy| 928 |convert| 933 |construct| 938
              |collectUpper| 943 |collectUnder| 949 |collectQuasiMonic| 955
              |collect| 960 |coerce| 966 |coHeight| 976 |basicSet| 981
              |autoReduced?| 994 |augment| 1000 |any?| 1024
              |algebraicVariables| 1030 |algebraicCoefficients?| 1035
              |algebraic?| 1041 = 1047 |#| 1053)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 2))
                 (CONS
                  '#(|RegularTriangularSetCategory&| |TriangularSetCategory&|
                     |PolynomialSetCategory&| |Collection&|
                     |HomogeneousAggregate&| |SetCategory&| |RetractableFrom&|
                     |Aggregate&| |Evalable&| |BasicType&| NIL NIL NIL NIL NIL
                     |InnerEvalable&| NIL)
                  (CONS
                   '#((|RegularTriangularSetCategory| 6 7 8 9)
                      (|TriangularSetCategory| 6 7 8 9)
                      (|PolynomialSetCategory| 6 7 8 9) (|Collection| 9)
                      (|HomogeneousAggregate| 9) (|SetCategory|)
                      (|RetractableFrom| (|List| 9)) (|Aggregate|)
                      (|Evalable| 9) (|BasicType|) (|shallowlyMutable|)
                      (|finiteAggregate|) (|CoercibleTo| (|List| 9)) (|Type|)
                      (|CoercibleTo| 27) (|InnerEvalable| 9 9)
                      (|ConvertibleTo| 131))
                   (|makeByteWordVec2| 144
                                       '(1 10 0 0 11 2 10 0 18 0 19 2 10 0 18 0
                                         22 2 10 14 9 0 24 1 9 27 0 28 1 27 0
                                         29 30 1 9 8 0 32 1 10 9 0 36 2 8 14 0
                                         0 41 2 8 14 0 0 43 2 9 14 0 0 45 2 10
                                         0 46 0 47 1 9 14 0 49 1 9 0 0 50 2 8
                                         14 0 0 51 1 9 0 0 52 2 0 14 8 0 54 2 0
                                         34 0 8 55 2 9 0 0 0 56 1 9 14 0 57 0 9
                                         0 59 2 9 60 0 8 61 1 9 0 0 62 2 9 0 0
                                         0 63 2 9 0 0 0 64 1 9 0 0 65 1 67 2 0
                                         68 2 0 71 9 0 72 1 9 0 0 73 1 74 10 9
                                         75 2 0 29 10 29 76 2 10 0 0 0 77 2 67
                                         0 0 0 80 2 82 14 9 2 83 2 82 85 9 2 86
                                         2 82 67 9 2 90 3 82 92 9 9 2 93 2 82
                                         92 9 2 97 4 99 67 10 67 14 14 100 3
                                         109 107 108 108 108 110 3 82 107 108
                                         108 108 111 3 82 107 108 108 108 112 0
                                         109 107 114 0 82 107 115 0 82 107 116
                                         2 10 0 119 0 120 2 10 14 119 0 121 1
                                         67 14 0 122 2 99 60 10 67 123 1 9 60 0
                                         124 0 6 0 125 1 74 14 10 126 1 74 10
                                         10 127 2 0 14 0 0 1 1 0 137 10 1 3 0
                                         29 10 14 14 103 5 0 29 10 14 14 14 14
                                         106 2 0 29 10 14 105 1 0 29 10 104 1 0
                                         135 0 1 1 0 14 0 1 1 5 14 0 1 1 0 14 0
                                         1 2 0 14 9 0 1 2 0 9 9 0 1 2 0 95 9 0
                                         98 2 0 142 0 8 1 2 0 14 0 60 1 2 8 0
                                         119 0 1 2 0 34 0 8 55 0 0 0 1 1 5 14 0
                                         26 2 5 14 0 0 1 2 5 14 0 0 1 1 5 14 0
                                         1 4 0 10 10 0 128 46 1 2 5 10 10 0 1 2
                                         5 10 10 0 1 1 0 38 10 1 1 0 0 10 1 1 0
                                         38 0 39 2 0 9 9 0 58 1 9 0 0 1 2 9 0 9
                                         0 1 2 8 0 119 0 1 2 5 71 9 0 72 3 0 14
                                         9 0 46 1 2 0 9 9 0 1 4 9 9 128 0 9 9 1
                                         2 8 9 128 0 1 3 8 9 128 0 9 1 4 0 9 9
                                         0 128 46 1 1 0 139 0 1 2 0 14 9 0 1 2
                                         0 14 9 0 1 1 0 14 0 1 2 0 14 9 0 1 3 0
                                         117 10 14 14 118 1 8 10 0 16 1 0 14 0
                                         1 2 0 14 9 0 1 1 0 8 0 33 2 0 14 0 60
                                         1 1 10 9 0 1 1 8 10 0 17 2 9 14 9 0 25
                                         1 10 9 0 1 2 8 9 46 0 1 2 7 0 18 0 23
                                         2 0 0 18 0 21 1 0 135 0 1 2 0 14 8 0 1
                                         2 0 14 0 60 1 1 0 108 0 1 3 0 133 9 9
                                         0 1 3 0 95 9 9 0 96 1 0 34 0 37 2 0 29
                                         9 0 79 2 0 134 9 0 1 2 0 88 9 0 89 2 0
                                         14 9 0 53 2 0 29 10 29 102 2 0 29 9 29
                                         1 2 0 29 9 0 101 2 0 29 10 0 1 4 0 29
                                         10 14 14 14 113 7 0 29 9 0 14 14 14 14
                                         14 66 2 0 0 9 0 69 2 0 0 10 0 70 1 0
                                         10 0 1 1 0 14 0 1 2 0 14 9 0 1 2 0 9 9
                                         0 1 2 0 14 0 0 1 2 5 6 6 6 1 2 5 132 9
                                         0 1 1 0 14 0 1 2 0 14 9 0 1 2 0 9 9 0
                                         1 2 0 144 144 0 1 1 0 143 0 1 1 0 34 0
                                         35 2 0 34 119 0 1 2 0 38 0 9 48 2 0 29
                                         10 0 1 2 0 29 10 29 76 2 0 29 9 0 81 2
                                         0 29 9 29 1 2 0 0 0 9 1 2 8 14 119 0 1
                                         2 1 0 0 129 1 3 1 0 0 9 9 1 2 1 0 0
                                         130 1 3 1 0 0 10 10 1 2 0 14 0 0 1 1 0
                                         14 0 15 0 0 0 13 1 0 60 0 1 2 9 60 9 0
                                         1 2 8 60 119 0 1 1 0 0 0 12 1 2 131 0
                                         1 1 0 0 10 20 2 0 0 0 8 42 2 0 0 0 8
                                         44 1 0 0 0 1 2 0 0 0 8 1 1 0 10 0 40 1
                                         0 27 0 31 1 6 60 0 1 3 0 141 10 119 46
                                         1 2 0 141 10 46 1 2 0 14 0 138 1 2 0
                                         29 10 0 1 2 0 29 10 29 1 2 0 29 9 0 78
                                         2 0 29 9 29 1 2 8 14 119 0 1 1 0 135 0
                                         1 2 0 14 9 0 1 2 0 14 8 0 54 2 0 14 0
                                         0 1 1 8 60 0 1)))))
           '|lookupComplete|)) 
