
(SDEFUN |DDFACT;ranpol| ((|d| (|NonNegativeInteger|)) ($ (FP)))
        (SPROG
         ((|u| (FP)) (#1=#:G726 NIL) (|j| NIL) (#2=#:G725 NIL)
          (|k1| (|NonNegativeInteger|)))
         (SEQ (LETT |k1| 0)
              (SEQ G190 (COND ((NULL (EQL |k1| 0)) (GO G191)))
                   (SEQ (EXIT (LETT |k1| (RANDOM |d|)))) NIL (GO G190) G191
                   (EXIT NIL))
              (EXIT
               (COND
                ((QREFELT $ 11)
                 (SEQ (LETT |u| (|spadConstant| $ 13))
                      (SEQ (LETT |j| 1) (LETT #2# |k1|) G190
                           (COND ((|greater_SI| |j| #2#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |u|
                                   (SPADCALL |u|
                                             (SPADCALL
                                              (SPADCALL (QREFELT $ 14)) |j|
                                              (QREFELT $ 15))
                                             (QREFELT $ 16)))))
                           (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |u|)))
                ('T
                 (SEQ
                  (LETT |u|
                        (SPADCALL (|spadConstant| $ 17) |k1| (QREFELT $ 15)))
                  (SEQ (LETT |j| 0) (LETT #1# (- |k1| 1)) G190
                       (COND ((|greater_SI| |j| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |u|
                               (SPADCALL |u|
                                         (SPADCALL (SPADCALL (QREFELT $ 14))
                                                   |j| (QREFELT $ 15))
                                         (QREFELT $ 16)))))
                       (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |u|)))))))) 

(SDEFUN |DDFACT;notSqFr|
        ((|m| (FP)) (|appl| (|Mapping| (|List| FP) FP))
         ($
          (|List|
           (|Record| (|:| |irr| FP) (|:| |pow| (|NonNegativeInteger|))))))
        (SPROG
         ((|factlist|
           (|List|
            (|Record| (|:| |irr| FP) (|:| |pow| (|NonNegativeInteger|)))))
          (#1=#:G755 NIL) (|pf| NIL) (#2=#:G754 NIL) (|fln| (|List| FP))
          (|pol| (FP)) (|lcp| (F)) (|d1| #3=(|NonNegativeInteger|))
          (#4=#:G753 NIL) (|lf| NIL)
          (|llf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| FP) (|:| |exponent| #3#))))
          (|lcm| (F)))
         (SEQ (LETT |factlist| NIL) (LETT |fln| NIL)
              (COND
               ((SPADCALL (LETT |lcm| (SPADCALL |m| (QREFELT $ 19)))
                          (|spadConstant| $ 17) (QREFELT $ 21))
                (LETT |m|
                      (SPADCALL (SPADCALL |lcm| (QREFELT $ 22)) |m|
                                (QREFELT $ 23)))))
              (LETT |llf|
                    (SPADCALL (SPADCALL |m| (QREFELT $ 25)) (QREFELT $ 30)))
              (SEQ (LETT |lf| NIL) (LETT #4# |llf|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |lf| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |d1| (QVELT |lf| 2)) (LETT |pol| (QVELT |lf| 1))
                        (COND
                         ((SPADCALL
                           (LETT |lcp| (SPADCALL |pol| (QREFELT $ 19)))
                           (|spadConstant| $ 17) (QREFELT $ 21))
                          (LETT |pol|
                                (SPADCALL (SPADCALL |lcp| (QREFELT $ 22)) |pol|
                                          (QREFELT $ 23)))))
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |pol| (QREFELT $ 31)) 1)
                           (LETT |factlist|
                                 (CONS (CONS |pol| |d1|) |factlist|)))
                          ('T
                           (SEQ (LETT |fln| (SPADCALL |pol| |appl|))
                                (EXIT
                                 (LETT |factlist|
                                       (SPADCALL
                                        (PROGN
                                         (LETT #2# NIL)
                                         (SEQ (LETT |pf| NIL) (LETT #1# |fln|)
                                              G190
                                              (COND
                                               ((OR (ATOM #1#)
                                                    (PROGN
                                                     (LETT |pf| (CAR #1#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #2#
                                                      (CONS (CONS |pf| |d1|)
                                                            #2#))))
                                              (LETT #1# (CDR #1#)) (GO G190)
                                              G191 (EXIT (NREVERSE #2#))))
                                        |factlist| (QREFELT $ 34)))))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT |factlist|)))) 

(SDEFUN |DDFACT;exptMod;FPNni2FP;3|
        ((|u| (FP)) (|k| (|NonNegativeInteger|)) (|v| (FP)) ($ (FP)))
        (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 35)) |k| (QREFELT $ 36))
                  |v| (QREFELT $ 37))) 

(SDEFUN |DDFACT;trace2PowMod;FPNni2FP;4|
        ((|u| (FP)) (|k| (|NonNegativeInteger|)) (|v| (FP)) ($ (FP)))
        (SPROG ((|uu| (FP)) (#1=#:G761 NIL) (|i| NIL))
               (SEQ (LETT |uu| |u|)
                    (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |uu|
                                 (SPADCALL
                                  (SPADCALL |u|
                                            (SPADCALL |uu| |uu| (QREFELT $ 39))
                                            (QREFELT $ 16))
                                  |v| (QREFELT $ 37)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |uu|)))) 

(SDEFUN |DDFACT;tracePowMod;FPNni2FP;5|
        ((|u| (FP)) (|k| (|NonNegativeInteger|)) (|v| (FP)) ($ (FP)))
        (SPROG ((|uu| (D)) (#1=#:G766 NIL) (|i| NIL) (|u1| (D)))
               (SEQ (LETT |u1| (SPADCALL |u| (QREFELT $ 35))) (LETT |uu| |u1|)
                    (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |uu|
                                 (SPADCALL |u1| (SPADCALL |uu| (QREFELT $ 41))
                                           (QREFELT $ 42)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (SPADCALL |uu| (QREFELT $ 43)) |v|
                               (QREFELT $ 37)))))) 

(SDEFUN |DDFACT;normPowMod|
        ((|u| (FP)) (|k| (|NonNegativeInteger|)) (|v| (FP)) ($ (FP)))
        (SPROG ((|uu| (D)) (#1=#:G775 NIL) (|i| NIL) (|u1| (D)))
               (SEQ (LETT |u1| (SPADCALL |u| (QREFELT $ 35))) (LETT |uu| |u1|)
                    (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |uu|
                                 (SPADCALL |u1| (SPADCALL |uu| (QREFELT $ 41))
                                           (QREFELT $ 45)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (SPADCALL |uu| (QREFELT $ 43)) |v|
                               (QREFELT $ 37)))))) 

(SDEFUN |DDFACT;ddffact1|
        ((|m| (FP)) (|testirr| (|Boolean|))
         ($
          (|List|
           (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP)))))
        (SPROG
         ((#1=#:G785 NIL) (|du| (|NonNegativeInteger|)) (|u| (FP))
          (|ddfact|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP))))
          (|g| (FP)) (|dg| (|NonNegativeInteger|)) (|v| (FP)) (|k1| NIL)
          (|mon| (FP)))
         (SEQ
          (EXIT
           (SEQ (LETT |dg| 0) (LETT |ddfact| NIL) (LETT |u| |m|)
                (LETT |du| (SPADCALL |u| (QREFELT $ 31)))
                (SPADCALL |u| (QREFELT $ 46))
                (LETT |mon| (SPADCALL (|spadConstant| $ 17) 1 (QREFELT $ 15)))
                (LETT |v| |mon|)
                (SEQ (LETT |k1| 1) G190
                     (COND ((NULL (<= |k1| (QUOTIENT2 |du| 2))) (GO G191)))
                     (SEQ
                      (LETT |v|
                            (SPADCALL
                             (SPADCALL (SPADCALL |v| (QREFELT $ 35))
                                       (QREFELT $ 41))
                             (QREFELT $ 43)))
                      (LETT |g|
                            (SPADCALL (SPADCALL |v| |mon| (QREFELT $ 47)) |u|
                                      (QREFELT $ 48)))
                      (LETT |dg| (SPADCALL |g| (QREFELT $ 31)))
                      (EXIT
                       (COND ((EQL |dg| 0) "next k1")
                             ('T
                              (SEQ
                               (COND
                                ((SPADCALL (SPADCALL |g| (QREFELT $ 19))
                                           (|spadConstant| $ 17)
                                           (QREFELT $ 21))
                                 (LETT |g|
                                       (SPADCALL
                                        (SPADCALL (SPADCALL |g| (QREFELT $ 19))
                                                  (QREFELT $ 22))
                                        |g| (QREFELT $ 23)))))
                               (LETT |ddfact| (CONS (CONS |k1| |g|) |ddfact|))
                               (EXIT
                                (COND
                                 (|testirr|
                                  (PROGN (LETT #1# |ddfact|) (GO #2=#:G784)))
                                 ('T
                                  (SEQ
                                   (LETT |u| (SPADCALL |u| |g| (QREFELT $ 49)))
                                   (LETT |du| (SPADCALL |u| (QREFELT $ 31)))
                                   (EXIT
                                    (COND
                                     ((EQL |du| 0)
                                      (PROGN (LETT #1# |ddfact|) (GO #2#)))
                                     ('T
                                      (SPADCALL |u| (QREFELT $ 46))))))))))))))
                     (LETT |k1| (|inc_SI| |k1|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS (CONS |du| |u|) |ddfact|))))
          #2# (EXIT #1#)))) 

(SDEFUN |DDFACT;irreducible?;FPB;8| ((|m| (FP)) ($ (|Boolean|)))
        (SPROG
         ((|mf| (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP))))
         (SEQ (LETT |mf| (|SPADfirst| (|DDFACT;ddffact1| |m| 'T $)))
              (EXIT (EQL (SPADCALL |m| (QREFELT $ 31)) (QCAR |mf|)))))) 

(SDEFUN |DDFACT;separateDegrees;FPL;9|
        ((|m| (FP))
         ($
          (|List|
           (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP)))))
        (|DDFACT;ddffact1| |m| NIL $)) 

(SDEFUN |DDFACT;separateFactors;LL;10|
        ((|distf|
          (|List|
           (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP))))
         ($ (|List| FP)))
        (SPROG
         ((|aux| (|List| FP)) (|newaux| #1=(|List| FP)) (|ris| #1#) (|v| (FP))
          (|dg| (|NonNegativeInteger|)) (|g| (FP)) (#2=#:G808 NIL) (|u| NIL)
          (|t| (FP)) (#3=#:G795 NIL) (#4=#:G794 NIL)
          (|d| (|NonNegativeInteger|)) (|fprod| (FP)) (#5=#:G807 NIL)
          (|ffprod| NIL) (|n1| (|Integer|)) (|p1| (|NonNegativeInteger|))
          (|ddfact|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP)))))
         (SEQ (LETT |ddfact| |distf|) (LETT |p1| (SPADCALL (QREFELT $ 54)))
              (COND ((QREFELT $ 11) (LETT |n1| (- (INTEGER-LENGTH |p1|) 1))))
              (LETT |ris| NIL)
              (SEQ (LETT |ffprod| NIL) (LETT #5# |ddfact|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |ffprod| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |fprod| (QCDR |ffprod|))
                        (LETT |d| (QCAR |ffprod|))
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |fprod| (QREFELT $ 31)) |d|)
                           (LETT |ris| (CONS |fprod| |ris|)))
                          ('T
                           (SEQ (LETT |aux| (LIST |fprod|))
                                (SPADCALL |fprod| (QREFELT $ 46))
                                (EXIT
                                 (SEQ G190
                                      (COND
                                       ((NULL (NULL (NULL |aux|))) (GO G191)))
                                      (SEQ
                                       (LETT |t| (|DDFACT;ranpol| (* 2 |d|) $))
                                       (COND
                                        ((QREFELT $ 11)
                                         (LETT |t|
                                               (SPADCALL |t|
                                                         (PROG1
                                                             (LETT #4#
                                                                   (-
                                                                    (* |n1|
                                                                       |d|)
                                                                    1))
                                                           (|check_subtype2|
                                                            (>= #4# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #4#))
                                                         |fprod|
                                                         (QREFELT $ 40))))
                                        ('T
                                         (LETT |t|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |t|
                                                           (PROG1
                                                               (LETT #3#
                                                                     (- |d| 1))
                                                             (|check_subtype2|
                                                              (>= #3# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #3#))
                                                           |fprod|
                                                           (QREFELT $ 44))
                                                 (QUOTIENT2 |p1| 2) |fprod|
                                                 (QREFELT $ 38))
                                                (|spadConstant| $ 18)
                                                (QREFELT $ 47)))))
                                       (LETT |newaux| NIL)
                                       (SEQ (LETT |u| NIL) (LETT #2# |aux|)
                                            G190
                                            (COND
                                             ((OR (ATOM #2#)
                                                  (PROGN
                                                   (LETT |u| (CAR #2#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (LETT |g|
                                                   (SPADCALL |u| |t|
                                                             (QREFELT $ 48)))
                                             (LETT |dg|
                                                   (SPADCALL |g|
                                                             (QREFELT $ 31)))
                                             (COND
                                              ((OR (EQL |dg| 0)
                                                   (EQL |dg|
                                                        (SPADCALL |u|
                                                                  (QREFELT $
                                                                           31))))
                                               (EXIT
                                                (LETT |newaux|
                                                      (CONS |u| |newaux|)))))
                                             (LETT |v|
                                                   (SPADCALL |u| |g|
                                                             (QREFELT $ 49)))
                                             (COND
                                              ((EQL |dg| |d|)
                                               (LETT |ris|
                                                     (CONS
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |g|
                                                                  (QREFELT $
                                                                           19))
                                                        (QREFELT $ 22))
                                                       |g| (QREFELT $ 23))
                                                      |ris|)))
                                              ('T
                                               (LETT |newaux|
                                                     (CONS |g| |newaux|))))
                                             (EXIT
                                              (COND
                                               ((EQL
                                                 (SPADCALL |v| (QREFELT $ 31))
                                                 |d|)
                                                (LETT |ris|
                                                      (CONS
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL |v|
                                                                   (QREFELT $
                                                                            19))
                                                         (QREFELT $ 22))
                                                        |v| (QREFELT $ 23))
                                                       |ris|)))
                                               ('T
                                                (LETT |newaux|
                                                      (CONS |v| |newaux|))))))
                                            (LETT #2# (CDR #2#)) (GO G190) G191
                                            (EXIT NIL))
                                       (EXIT (LETT |aux| |newaux|)))
                                      NIL (GO G190) G191 (EXIT NIL))))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ris|)))) 

(SDEFUN |DDFACT;ddffact| ((|m| (FP)) ($ (|List| FP)))
        (SPROG
         ((|ddfact|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |prod| FP)))))
         (SEQ (LETT |ddfact| (|DDFACT;ddffact1| |m| NIL $))
              (EXIT
               (COND ((NULL |ddfact|) (LIST |m|))
                     ('T (SPADCALL |ddfact| (QREFELT $ 56)))))))) 

(SDEFUN |DDFACT;distdfact;FPBR;12|
        ((|m| (FP)) (|test| (|Boolean|))
         ($
          (|Record| (|:| |cont| F)
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| FP)
                                    (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((|factlist|
           (|List|
            (|Record| (|:| |irr| FP) (|:| |pow| (|NonNegativeInteger|)))))
          (#1=#:G825 NIL) (|pol| NIL) (#2=#:G824 NIL) (|fln| (|List| FP))
          (|d| (|NonNegativeInteger|)) (|lcm| (F)))
         (SEQ (LETT |factlist| NIL) (LETT |fln| NIL)
              (COND
               ((SPADCALL (LETT |lcm| (SPADCALL |m| (QREFELT $ 19)))
                          (|spadConstant| $ 17) (QREFELT $ 21))
                (LETT |m|
                      (SPADCALL (SPADCALL |lcm| (QREFELT $ 22)) |m|
                                (QREFELT $ 23)))))
              (SEQ (LETT |d| (SPADCALL |m| (QREFELT $ 57)))
                   (EXIT
                    (COND
                     ((> |d| 0)
                      (SEQ
                       (LETT |m|
                             (QCAR
                              (SPADCALL |m|
                                        (SPADCALL (|spadConstant| $ 17) |d|
                                                  (QREFELT $ 15))
                                        (QREFELT $ 59))))
                       (EXIT
                        (LETT |factlist|
                              (LIST
                               (CONS
                                (SPADCALL (|spadConstant| $ 17) 1
                                          (QREFELT $ 15))
                                |d|)))))))))
              (LETT |d| (SPADCALL |m| (QREFELT $ 31)))
              (EXIT
               (COND ((EQL |d| 0) (CONS |lcm| |factlist|))
                     ((EQL |d| 1)
                      (CONS |lcm| (CONS (CONS |m| |d|) |factlist|)))
                     (|test|
                      (SEQ (LETT |fln| (|DDFACT;ddffact| |m| $))
                           (LETT |factlist|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |pol| NIL) (LETT #1# |fln|) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN
                                               (LETT |pol| (CAR #1#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS (CONS |pol| 1) #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#))))
                                  |factlist| (QREFELT $ 34)))
                           (EXIT (CONS |lcm| |factlist|))))
                     ('T
                      (SEQ
                       (LETT |factlist|
                             (SPADCALL
                              (|DDFACT;notSqFr| |m|
                               (CONS (|function| |DDFACT;ddffact|) $) $)
                              |factlist| (QREFELT $ 34)))
                       (EXIT (CONS |lcm| |factlist|))))))))) 

(SDEFUN |DDFACT;factor;FPF;13| ((|m| (FP)) ($ (|Factored| FP)))
        (SPROG
         ((#1=#:G838 NIL) (|u| NIL) (#2=#:G837 NIL)
          (|flist|
           (|Record| (|:| |cont| F)
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| FP)
                                     (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 13) (QREFELT $ 62))
            (|spadConstant| $ 63))
           ('T
            (SEQ (LETT |flist| (SPADCALL |m| NIL (QREFELT $ 61)))
                 (EXIT
                  (SPADCALL (SPADCALL (QCAR |flist|) (QREFELT $ 64))
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |u| NIL) (LETT #1# (QCDR |flist|)) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |u| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (VECTOR (CONS 3 "prime") (QCAR |u|)
                                                   (QCDR |u|))
                                           #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 67))))))))) 

(SDEFUN |DDFACT;factorSquareFree;FPF;14| ((|m| (FP)) ($ (|Factored| FP)))
        (SPROG
         ((#1=#:G851 NIL) (|u| NIL) (#2=#:G850 NIL)
          (|flist|
           (|Record| (|:| |cont| F)
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| FP)
                                     (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 13) (QREFELT $ 62))
            (|spadConstant| $ 63))
           ('T
            (SEQ (LETT |flist| (SPADCALL |m| 'T (QREFELT $ 61)))
                 (EXIT
                  (SPADCALL (SPADCALL (QCAR |flist|) (QREFELT $ 64))
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |u| NIL) (LETT #1# (QCDR |flist|)) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |u| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (VECTOR (CONS 3 "prime") (QCAR |u|)
                                                   (QCDR |u|))
                                           #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 67))))))))) 

(DECLAIM (NOTINLINE |DistinctDegreeFactorize;|)) 

(DEFUN |DistinctDegreeFactorize| (&REST #1=#:G852)
  (SPROG NIL
         (PROG (#2=#:G853)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DistinctDegreeFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DistinctDegreeFactorize;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DistinctDegreeFactorize|)))))))))) 

(DEFUN |DistinctDegreeFactorize;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|DistinctDegreeFactorize| DV$1 DV$2))
          (LETT $ (GETREFV 70))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DistinctDegreeFactorize|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|ModMonic| |#1| |#2|))
          (QSETREFV $ 11 (EQL (SPADCALL (QREFELT $ 10)) 2))
          $))) 

(MAKEPROP '|DistinctDegreeFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'D
              (|NonNegativeInteger|) (0 . |characteristic|) '|charF|
              (4 . |Zero|) (8 . |Zero|) (12 . |random|) (16 . |monomial|)
              (22 . +) (28 . |One|) (32 . |One|) (36 . |leadingCoefficient|)
              (|Boolean|) (41 . ~=) (47 . |inv|) (52 . *) (|Factored| $)
              (58 . |squareFree|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 26) (|:| |factor| 7) (|:| |exponent| 9))
              (|List| 27) (|Factored| 7) (63 . |factorList|) (68 . |degree|)
              (|Record| (|:| |irr| 7) (|:| |pow| 9)) (|List| 32)
              (73 . |append|) (79 . |reduce|) (84 . ^) (90 . |rem|)
              |DDFACT;exptMod;FPNni2FP;3| (96 . *)
              |DDFACT;trace2PowMod;FPNni2FP;4| (102 . |frobenius|) (107 . +)
              (113 . |lift|) |DDFACT;tracePowMod;FPNni2FP;5| (118 . *)
              (124 . |setPoly|) (129 . -) (135 . |gcd|) (141 . |quo|)
              |DDFACT;irreducible?;FPB;8|
              (|Record| (|:| |deg| 9) (|:| |prod| 7)) (|List| 51)
              |DDFACT;separateDegrees;FPL;9| (147 . |size|) (|List| 7)
              |DDFACT;separateFactors;LL;10| (151 . |minimumDegree|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (156 . |monicDivide|)
              (|Record| (|:| |cont| 6) (|:| |factors| 33))
              |DDFACT;distdfact;FPBR;12| (162 . =) (168 . |Zero|)
              (172 . |coerce|) (|PrimitiveArray| $) (177 . |pow|)
              (181 . |makeFR|) |DDFACT;factor;FPF;13|
              |DDFACT;factorSquareFree;FPF;14|)
           '#(|tracePowMod| 187 |trace2PowMod| 194 |separateFactors| 201
              |separateDegrees| 206 |irreducible?| 211 |factorSquareFree| 216
              |factor| 221 |exptMod| 226 |distdfact| 233)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#2|) |#2|)) T)
                                   '((|factorSquareFree|
                                      ((|Factored| |#2|) |#2|))
                                     T)
                                   '((|distdfact|
                                      ((|Record| (|:| |cont| |#1|)
                                                 (|:| |factors|
                                                      (|List|
                                                       (|Record|
                                                        (|:| |irr| |#2|)
                                                        (|:| |pow|
                                                             (|NonNegativeInteger|))))))
                                       |#2| (|Boolean|)))
                                     T)
                                   '((|separateDegrees|
                                      ((|List|
                                        (|Record|
                                         (|:| |deg| (|NonNegativeInteger|))
                                         (|:| |prod| |#2|)))
                                       |#2|))
                                     T)
                                   '((|separateFactors|
                                      ((|List| |#2|)
                                       (|List|
                                        (|Record|
                                         (|:| |deg| (|NonNegativeInteger|))
                                         (|:| |prod| |#2|)))))
                                     T)
                                   '((|exptMod|
                                      (|#2| |#2| (|NonNegativeInteger|) |#2|))
                                     T)
                                   '((|trace2PowMod|
                                      (|#2| |#2| (|NonNegativeInteger|) |#2|))
                                     T)
                                   '((|tracePowMod|
                                      (|#2| |#2| (|NonNegativeInteger|) |#2|))
                                     T)
                                   '((|irreducible?| ((|Boolean|) |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 69
                                            '(0 6 9 10 0 6 0 12 0 7 0 13 0 6 0
                                              14 2 7 0 6 9 15 2 7 0 0 0 16 0 6
                                              0 17 0 7 0 18 1 7 6 0 19 2 6 20 0
                                              0 21 1 6 0 0 22 2 7 0 6 0 23 1 7
                                              24 0 25 1 29 28 0 30 1 7 9 0 31 2
                                              33 0 0 0 34 1 8 0 7 35 2 8 0 0 9
                                              36 2 7 0 0 0 37 2 7 0 0 0 39 1 8
                                              0 0 41 2 8 0 0 0 42 1 8 7 0 43 2
                                              8 0 0 0 45 1 8 7 7 46 2 7 0 0 0
                                              47 2 7 0 0 0 48 2 7 0 0 0 49 0 6
                                              9 54 1 7 9 0 57 2 7 58 0 0 59 2 7
                                              20 0 0 62 0 29 0 63 1 7 0 6 64 0
                                              8 65 66 2 29 0 7 28 67 3 0 7 7 9
                                              7 44 3 0 7 7 9 7 40 1 0 55 52 56
                                              1 0 52 7 53 1 0 20 7 50 1 0 29 7
                                              69 1 0 29 7 68 3 0 7 7 9 7 38 2 0
                                              60 7 20 61)))))
           '|lookupComplete|)) 
