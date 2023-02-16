
(SDEFUN |GALFACT;useEisensteinCriterion?;B;1| (($ (|Boolean|))) (QREFELT $ 11)) 

(SDEFUN |GALFACT;useEisensteinCriterion;2B;2|
        ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|#G5| (|Boolean|)) (|#G4| (|Boolean|)))
               (SEQ
                (PROGN
                 (LETT |#G4| |b|)
                 (LETT |#G5| (QREFELT $ 11))
                 (SETELT $ 11 |#G4|)
                 (LETT |b| |#G5|))
                (EXIT |b|)))) 

(SDEFUN |GALFACT;tryFunctionalDecomposition?;B;3| (($ (|Boolean|)))
        (QREFELT $ 10)) 

(SDEFUN |GALFACT;tryFunctionalDecomposition;2B;4|
        ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|#G8| (|Boolean|)) (|#G7| (|Boolean|)))
               (SEQ
                (PROGN
                 (LETT |#G7| |b|)
                 (LETT |#G8| (QREFELT $ 10))
                 (SETELT $ 10 |#G7|)
                 (LETT |b| |#G8|))
                (EXIT |b|)))) 

(SDEFUN |GALFACT;useSingleFactorBound?;B;5| (($ (|Boolean|))) (QREFELT $ 9)) 

(SDEFUN |GALFACT;useSingleFactorBound;2B;6| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|#G11| (|Boolean|)) (|#G10| (|Boolean|)))
               (SEQ
                (PROGN
                 (LETT |#G10| |b|)
                 (LETT |#G11| (QREFELT $ 9))
                 (SETELT $ 9 |#G10|)
                 (LETT |b| |#G11|))
                (EXIT |b|)))) 

(SDEFUN |GALFACT;stopMusserTrials;Pi;7| (($ (|PositiveInteger|))) (QREFELT $ 8)) 

(SDEFUN |GALFACT;stopMusserTrials;2Pi;8|
        ((|n| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((|#G14| (|PositiveInteger|)) (|#G13| (|PositiveInteger|)))
               (SEQ
                (PROGN
                 (LETT |#G13| |n|)
                 (LETT |#G14| (QREFELT $ 8))
                 (SETELT $ 8 |#G13|)
                 (LETT |n| |#G14|))
                (EXIT |n|)))) 

(SDEFUN |GALFACT;musserTrials;Pi;9| (($ (|PositiveInteger|))) (QREFELT $ 7)) 

(SDEFUN |GALFACT;musserTrials;2Pi;10|
        ((|n| (|PositiveInteger|)) ($ (|PositiveInteger|)))
        (SPROG ((|#G17| (|PositiveInteger|)) (|#G16| (|PositiveInteger|)))
               (SEQ
                (PROGN
                 (LETT |#G16| |n|)
                 (LETT |#G17| (QREFELT $ 7))
                 (SETELT $ 7 |#G16|)
                 (LETT |n| |#G17|))
                (EXIT |n|)))) 

(SDEFUN |GALFACT;eisensteinIrreducible?;UPB;11| ((|f| (UP)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G786 NIL) (#2=#:G787 NIL) (|p| NIL) (|rf| (UP))
          (|tc| #3=(|Integer|)) (|lc| #3#) (|c| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |rf| (SPADCALL |f| (QREFELT $ 24)))
                (LETT |c| (SPADCALL |rf| (QREFELT $ 26)))
                (EXIT
                 (COND ((OR (ZEROP |c|) (SPADCALL |c| (QREFELT $ 27))) NIL)
                       ('T
                        (SEQ (LETT |lc| (SPADCALL |f| (QREFELT $ 28)))
                             (LETT |tc| |lc|)
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (NULL (SPADCALL |rf| (QREFELT $ 29))))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |tc| (SPADCALL |rf| (QREFELT $ 28)))
                                   (EXIT
                                    (LETT |rf|
                                          (SPADCALL |rf| (QREFELT $ 24)))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (SEQ (LETT |p| NIL)
                                  (LETT #2#
                                        (SPADCALL (SPADCALL |c| (QREFELT $ 31))
                                                  (QREFELT $ 36)))
                                  G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |p| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((EQL (QVELT |p| 2) 1)
                                      (COND
                                       ((NULL (ZEROP (REM |lc| (QVELT |p| 1))))
                                        (COND
                                         ((NULL
                                           (ZEROP
                                            (REM |tc| (EXPT (QVELT |p| 1) 2))))
                                          (PROGN
                                           (LETT #1# 'T)
                                           (GO #4=#:G785))))))))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT NIL)))))))
          #4# (EXIT #1#)))) 

(SDEFUN |GALFACT;numberOfFactors;LNni;12|
        ((|ddlist|
          (|List| (|Record| (|:| |factor| UP) (|:| |degree| (|Integer|)))))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (#1=#:G790 NIL) (|d| (|Integer|))
          (#2=#:G797 NIL) (|dd| NIL))
         (SEQ (LETT |n| 0) (LETT |d| 0)
              (SEQ (LETT |dd| NIL) (LETT #2# |ddlist|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |dd| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |n|
                           (+ |n|
                              (COND
                               ((ZEROP
                                 (LETT |d|
                                       (SPADCALL (QCAR |dd|) (QREFELT $ 39))))
                                1)
                               ('T
                                (PROG1 (LETT #1# (QUOTIENT2 |d| (QCDR |dd|)))
                                  (|check_subtype2| (>= #1# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #1#))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |n|)))) 

(SDEFUN |GALFACT;shiftSet|
        ((|s| (|Set| (|NonNegativeInteger|))) (|shift| (|NonNegativeInteger|))
         ($ (|Set| (|NonNegativeInteger|))))
        (SPROG NIL
               (SPADCALL (CONS #'|GALFACT;shiftSet!0| (VECTOR $ |shift|)) |s|
                         (QREFELT $ 46)))) 

(SDEFUN |GALFACT;shiftSet!0| ((|e| NIL) ($$ NIL))
        (PROG (|shift| $)
          (LETT |shift| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |shift| (QREFELT $ 43)))))) 

(SDEFUN |GALFACT;reductum| ((|n| (|Integer|)) ($ (|Integer|)))
        (- |n| (ASH 1 (- (INTEGER-LENGTH |n|) 1)))) 

(SDEFUN |GALFACT;seed| ((|level| (|Integer|)) ($ (|Integer|)))
        (- (ASH 1 |level|) 1)) 

(SDEFUN |GALFACT;nextRecNum|
        ((|levels| (|NonNegativeInteger|)) (|level| (|Integer|))
         (|n| (|Integer|)) ($ (|Union| (|Integer|) "End of level")))
        (SPROG
         ((|b| (|Integer|)) (|lr| #1=(|Integer|)) (#2=#:G811 NIL) (|l| #1#))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |l| (INTEGER-LENGTH |n|))
                 (EXIT
                  (COND
                   ((< |l| |levels|)
                    (PROGN
                     (LETT #2# (CONS 0 (+ |n| (ASH 1 (- |l| 1)))))
                     (GO #3=#:G810))))))
            (EXIT
             (COND
              ((EQL |n| (ASH (|GALFACT;seed| |level| $) (- |levels| |level|)))
               (CONS 1 "End of level"))
              ('T
               (SEQ (LETT |b| 1)
                    (SEQ G190
                         (COND
                          ((NULL
                            (EQL (- |l| |b|)
                                 (LETT |lr|
                                       (INTEGER-LENGTH
                                        (LETT |n|
                                              (|GALFACT;reductum| |n| $))))))
                           (GO G191)))
                         (SEQ (EXIT (LETT |b| (+ |b| 1)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (EXIT
                     (CONS 0
                           (+ (|GALFACT;reductum| |n| $)
                              (ASH (|GALFACT;seed| (+ |b| 1) $) |lr|))))))))))
          #3# (EXIT #2#)))) 

(SDEFUN |GALFACT;fullSet|
        ((|n| (|NonNegativeInteger|)) ($ (|Set| (|NonNegativeInteger|))))
        (SPROG ((#1=#:G818 NIL) (|i| NIL) (#2=#:G817 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| 0) (LETT #1# |n|) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 49))))) 

(SDEFUN |GALFACT;is_mod_coprime?|
        ((|pol1| (UP)) (|pol2| (UP)) (|p| (|Integer|)) (|small| (|Boolean|))
         ($ (|Boolean|)))
        (SPROG ((|vg| (|U32Vector|)) (|v2| #1=(|U32Vector|)) (|v1| #1#))
               (SEQ
                (COND
                 (|small|
                  (SEQ
                   (LETT |v1|
                         (SPADCALL (SPADCALL |pol1| (QREFELT $ 51)) |p|
                                   (QREFELT $ 54)))
                   (LETT |v2|
                         (SPADCALL (SPADCALL |pol2| (QREFELT $ 51)) |p|
                                   (QREFELT $ 54)))
                   (LETT |vg| (SPADCALL |v1| |v2| |p| (QREFELT $ 55)))
                   (EXIT (<= (SPADCALL |vg| (QREFELT $ 56)) 0))))
                 ('T
                  (ZEROP
                   (SPADCALL (SPADCALL |pol1| |pol2| |p| (QREFELT $ 58))
                             (QREFELT $ 39)))))))) 

(SDEFUN |GALFACT;add_degs|
        ((|deg1| (|NonNegativeInteger|)) (|deg2| (|NonNegativeInteger|))
         (|res| (|List| (|NonNegativeInteger|)))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG ((#1=#:G826 NIL) (|i| NIL))
               (SEQ
                (COND ((EQL |deg2| 0) |res|)
                      ('T
                       (SEQ
                        (SEQ (LETT |i| 1) (LETT #1# (QUOTIENT2 |deg1| |deg2|))
                             G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ (EXIT (LETT |res| (CONS |deg2| |res|))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT |res|))))))) 

(SDEFUN |GALFACT;do_separate|
        ((|sfl| (|List| (|Mapping| #1=(|List| (|U32Vector|)))))
         (|c| (|Integer|)) ($ (|List| UP)))
        (SPROG
         ((|res| (|List| UP)) (#2=#:G835 NIL) (|v| NIL) (|vl| #1#)
          (#3=#:G834 NIL) (|sf| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |sf| NIL) (LETT #3# |sfl|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |sf| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |vl| (SPADCALL |sf|))
                        (EXIT
                         (SEQ (LETT |v| NIL) (LETT #2# |vl|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |v| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT |res|
                                      (CONS
                                       (SPADCALL (SPADCALL |v| (QREFELT $ 60))
                                                 (QREFELT $ 61))
                                       |res|))))
                              (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (SPADCALL |c| (QREFELT $ 62)) |res|))))) 

(SDEFUN |GALFACT;do_ddfact|
        ((|pol| (UP)) (|p| (|Integer|)) (|small| (|Boolean|))
         ($
          (|Record| (|:| |dd_list| (|List| (|NonNegativeInteger|)))
                    (|:| |separate_factors| (|Mapping| (|List| UP))))))
        (SPROG
         ((|degs| (|List| (|NonNegativeInteger|))) (#1=#:G848 NIL)
          (#2=#:G855 NIL) (|rl| NIL)
          (|res1|
           (|List| (|Record| (|:| |factor| UP) (|:| |degree| (|Integer|)))))
          (|sfl| (|List| (|Mapping| (|List| (|U32Vector|))))) (#3=#:G841 NIL)
          (#4=#:G854 NIL) (|fr| NIL)
          (|ul1|
           (|List|
            (|Record| (|:| |poly| (|U32Vector|))
                      (|:| |degree| (|NonNegativeInteger|))
                      (|:| |separate_factors|
                           (|Mapping| (|List| (|U32Vector|)))))))
          (|ci| (|Integer|)) (|c| (|Integer|)) (|dpol| (|Integer|))
          (|v| (|U32Vector|)))
         (SEQ (LETT |degs| NIL)
              (EXIT
               (COND
                (|small|
                 (SEQ
                  (LETT |v|
                        (SPADCALL (SPADCALL |pol| (QREFELT $ 51)) |p|
                                  (QREFELT $ 54)))
                  (LETT |dpol| (SPADCALL |v| (QREFELT $ 56)))
                  (LETT |c| (ELT_U32 |v| |dpol|))
                  (COND
                   ((SPADCALL |c| 1 (QREFELT $ 63))
                    (SEQ (LETT |ci| (SPADCALL |c| |p| (QREFELT $ 64)))
                         (EXIT
                          (SPADCALL |v| |dpol| |ci| |p| (QREFELT $ 66))))))
                  (LETT |ul1| (SPADCALL |v| |p| (QREFELT $ 71)))
                  (LETT |sfl| NIL)
                  (SEQ (LETT |fr| NIL) (LETT #4# |ul1|) G190
                       (COND
                        ((OR (ATOM #4#) (PROGN (LETT |fr| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |degs|
                              (|GALFACT;add_degs|
                               (PROG1
                                   (LETT #3#
                                         (SPADCALL (QVELT |fr| 0)
                                                   (QREFELT $ 56)))
                                 (|check_subtype2| (>= #3# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #3#))
                               (QVELT |fr| 1) |degs| $))
                        (EXIT (LETT |sfl| (CONS (QVELT |fr| 2) |sfl|))))
                       (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (CONS |degs|
                         (CONS #'|GALFACT;do_ddfact!0|
                               (VECTOR $ |c| |sfl|))))))
                ('T
                 (SEQ (LETT |res1| (SPADCALL |pol| |p| (QREFELT $ 72)))
                      (SEQ (LETT |rl| NIL) (LETT #2# |res1|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |rl| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |degs|
                                   (|GALFACT;add_degs|
                                    (SPADCALL (QCAR |rl|) (QREFELT $ 39))
                                    (PROG1 (LETT #1# (QCDR |rl|))
                                      (|check_subtype2| (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#))
                                    |degs| $))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (CONS |degs|
                             (CONS #'|GALFACT;do_ddfact!1|
                                   (VECTOR $ |p| |res1|))))))))))) 

(SDEFUN |GALFACT;do_ddfact!1| (($$ NIL))
        (PROG (|res1| |p| $)
          (LETT |res1| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |res1| |p| (QREFELT $ 74)))))) 

(SDEFUN |GALFACT;do_ddfact!0| (($$ NIL))
        (PROG (|sfl| |c| $)
          (LETT |sfl| (QREFELT $$ 2))
          (LETT |c| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GALFACT;do_separate| |sfl| |c| $))))) 

(SDEFUN |GALFACT;modularFactor;UPSR;22|
        ((|p| (UP)) (|d| (|Set| (|NonNegativeInteger|)))
         ($ (|Record| (|:| |prime| (|Integer|)) (|:| |factors| (|List| UP)))))
        (SPROG
         ((|fl| (|List| UP)) (|cprime| (|Integer|)) (|res_prime| (|Integer|))
          (|dd_res|
           #1=(|Record| (|:| |dd_list| (|List| (|NonNegativeInteger|)))
                        (|:| |separate_factors| (|Mapping| (|List| UP)))))
          (|nf| (|NonNegativeInteger|)) (|nf1| (|NonNegativeInteger|))
          (#2=#:G877 NIL) (|s| (|Set| (|NonNegativeInteger|))) (#3=#:G879 NIL)
          (|ddlist| (|List| (|NonNegativeInteger|))) (|dd_res1| #1#)
          (|small| (|Boolean|)) (#4=#:G878 NIL) (|i| NIL) (|diffp| (UP))
          (|degp| #5=(|NonNegativeInteger|)) (|degfact| (|NonNegativeInteger|))
          (|dirred| (|Set| (|NonNegativeInteger|))) (|n| #5#))
         (SEQ
          (EXIT
           (COND
            ((NULL (EQL (ABS (SPADCALL |p| (QREFELT $ 26))) 1))
             (|error| "modularFactor: the polynomial is not primitive."))
            ('T
             (COND
              ((ZEROP (LETT |n| (SPADCALL |p| (QREFELT $ 39))))
               (CONS 0 (LIST |p|)))
              ('T
               (SEQ (LETT |cprime| 2)
                    (LETT |dirred| (SPADCALL (LIST 0 |n|) (QREFELT $ 49)))
                    (LETT |s| (SPADCALL (QREFELT $ 75))) (LETT |ddlist| NIL)
                    (LETT |degfact| 0)
                    (LETT |degp| (SPADCALL |p| (QREFELT $ 39)))
                    (LETT |nf| (+ (+ |degp| (QREFELT $ 8)) 1))
                    (LETT |diffp| (SPADCALL |p| (QREFELT $ 76)))
                    (LETT |small| 'T)
                    (SEQ (LETT |i| 1) (LETT #4# (QREFELT $ 7)) G190
                         (COND ((|greater_SI| |i| #4#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((> |nf| (QREFELT $ 8))
                             (SEQ
                              (COND
                               (|small|
                                (COND
                                 ((NULL
                                   (< (* (* |degp| |cprime|) |cprime|)
                                      18446744073709551616))
                                  (LETT |small| NIL)))))
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (COND
                                       ((ZEROP
                                         (REM (SPADCALL |p| (QREFELT $ 28))
                                              |cprime|))
                                        'T)
                                       ('T
                                        (NULL
                                         (|GALFACT;is_mod_coprime?| |p| |diffp|
                                          |cprime| |small| $)))))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |cprime|
                                           (SPADCALL |cprime|
                                                     (QREFELT $ 78)))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (LETT |dd_res1|
                                    (|GALFACT;do_ddfact| |p| |cprime| |small|
                                     $))
                              (LETT |ddlist| (QCAR |dd_res1|))
                              (LETT |s| (SPADCALL (LIST 0) (QREFELT $ 49)))
                              (SEQ (LETT #3# |ddlist|) G190
                                   (COND
                                    ((OR (ATOM #3#)
                                         (PROGN
                                          (LETT |degfact| (CAR #3#))
                                          NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |s|
                                           (SPADCALL |s|
                                                     (|GALFACT;shiftSet| |s|
                                                      |degfact| $)
                                                     (QREFELT $ 79)))))
                                   (LETT #3# (CDR #3#)) (GO G190) G191
                                   (EXIT NIL))
                              (LETT |d| (SPADCALL |d| |s| (QREFELT $ 80)))
                              (EXIT
                               (COND
                                ((SPADCALL |d| |dirred| (QREFELT $ 81))
                                 (PROGN
                                  (LETT #2# (CONS 0 (LIST |p|)))
                                  (GO #6=#:G876)))
                                ('T
                                 (SEQ
                                  (LETT |nf1|
                                        (SPADCALL |ddlist| (QREFELT $ 82)))
                                  (COND
                                   ((< |nf1| |nf|)
                                    (SEQ (LETT |nf| |nf1|)
                                         (LETT |dd_res| |dd_res1|)
                                         (EXIT (LETT |res_prime| |cprime|))))
                                   ((EQL |nf1| |nf|)
                                    (COND
                                     ((> |cprime| |res_prime|)
                                      (SEQ (LETT |nf| |nf1|)
                                           (LETT |dd_res| |dd_res1|)
                                           (EXIT
                                            (LETT |res_prime| |cprime|)))))))
                                  (EXIT
                                   (LETT |cprime|
                                         (SPADCALL |cprime|
                                                   (QREFELT $ 78)))))))))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (LETT |fl| (SPADCALL (QCDR |dd_res|)))
                    (EXIT (CONS |res_prime| |fl|))))))))
          #6# (EXIT #2#)))) 

(SDEFUN |GALFACT;degreePartition;LM;23|
        ((|ddlist|
          (|List| (|Record| (|:| |factor| UP) (|:| |degree| (|Integer|)))))
         ($ (|Multiset| (|NonNegativeInteger|))))
        (SPROG
         ((|dp| (|Multiset| (|NonNegativeInteger|)))
          (|dd| #1=(|NonNegativeInteger|)) (#2=#:G882 NIL) (|d| #1#)
          (#3=#:G888 NIL) (|f| NIL))
         (SEQ (LETT |dp| (SPADCALL (QREFELT $ 86))) (LETT |d| 0) (LETT |dd| 0)
              (SEQ (LETT |f| NIL) (LETT #3# |ddlist|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((ZEROP (LETT |d| (SPADCALL (QCAR |f|) (QREFELT $ 39))))
                       (LETT |dp| (SPADCALL 0 |dp| (QREFELT $ 87))))
                      ('T
                       (SEQ
                        (LETT |dd|
                              (PROG1 (LETT #2# (QCDR |f|))
                                (|check_subtype2| (>= #2# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #2#)))
                        (EXIT
                         (LETT |dp|
                               (SPADCALL |dd| |dp| (QUOTIENT2 |d| |dd|)
                                         (QREFELT $ 88)))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT |dp|)))) 

(SDEFUN |GALFACT;sel_set|
        ((|d| (|Set| (|NonNegativeInteger|))) (|n| (|NonNegativeInteger|))
         (|m| (|NonNegativeInteger|)) ($ (|Set| (|NonNegativeInteger|))))
        (SPROG ((|nm| (|NonNegativeInteger|)))
               (SEQ
                (COND ((EQL |n| 0) (SPADCALL (LIST 0) (QREFELT $ 49)))
                      ('T
                       (SEQ (LETT |nm| (* |n| |m|))
                            (EXIT
                             (SPADCALL
                              (CONS #'|GALFACT;sel_set!0| (VECTOR |n| $ |nm|))
                              |d| (QREFELT $ 95))))))))) 

(SDEFUN |GALFACT;sel_set!0| ((|x| NIL) ($$ NIL))
        (PROG (|nm| $ |n|)
          (LETT |nm| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL |x| |nm| (QREFELT $ 90))
              (SPADCALL (SPADCALL |x| |n| (QREFELT $ 91)) (|spadConstant| $ 92)
                        (QREFELT $ 93)))
             ('T NIL)))))) 

(SDEFUN |GALFACT;henselfact|
        ((|f| (UP)) (|pdecomp| (|Boolean|))
         (|d| (|Set| (|NonNegativeInteger|))) ($ #1=(|List| UP)))
        (SPROG
         ((#2=#:G908 NIL) (#3=#:G907 #1#) (#4=#:G909 #1#) (#5=#:G914 NIL)
          (|g| NIL) (|d1| (|Set| (|NonNegativeInteger|)))
          (|dh| (|NonNegativeInteger|))
          (|lrf| (|Record| (|:| |left| UP) (|:| |right| UP)))
          (|b| (|PositiveInteger|)) (#6=#:G904 NIL) (|cprime| #7=(|Integer|))
          (|m| (|Record| (|:| |prime| #7#) (|:| |factors| (|List| UP))))
          (|cf| (|Union| (|Record| (|:| |left| UP) (|:| |right| UP)) "failed"))
          (#8=#:G913 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |f| (QREFELT $ 97))
              (PROGN (LETT #8# (LIST |f|)) (GO #9=#:G912)))
             ((QREFELT $ 11)
              (COND
               ((SPADCALL |f| (QREFELT $ 37))
                (PROGN (LETT #8# (LIST |f|)) (GO #9#))))))
            (COND
             (|pdecomp|
              (COND ((QREFELT $ 10) (LETT |cf| (SPADCALL |f| (QREFELT $ 101))))
                    (#10='T (LETT |cf| (CONS 1 #11="failed")))))
             (#10# (LETT |cf| (CONS 1 #11#))))
            (EXIT
             (COND
              ((QEQCAR |cf| 1)
               (SEQ (LETT |m| (SPADCALL |f| |d| (QREFELT $ 84)))
                    (EXIT
                     (COND ((ZEROP (LETT |cprime| (QCAR |m|))) (QCDR |m|))
                           (#10#
                            (SEQ
                             (LETT |b|
                                   (PROG1
                                       (LETT #6#
                                             (*
                                              (* 2
                                                 (SPADCALL |f| (QREFELT $ 28)))
                                              (SPADCALL |f| (QREFELT $ 103))))
                                     (|check_subtype2| (> #6# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #6#)))
                             (EXIT
                              (SPADCALL |f| (QCDR |m|) |cprime| |b|
                                        (QREFELT $ 105)))))))))
              (#10#
               (SEQ (LETT |lrf| (QCDR |cf|))
                    (LETT |dh| (SPADCALL (QCDR |lrf|) (QREFELT $ 39)))
                    (LETT |d1| (|GALFACT;divideSet| |d| |dh| $))
                    (EXIT
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |g| NIL)
                           (LETT #5#
                                 (|GALFACT;henselfact| (QCAR |lrf|) 'T |d1| $))
                           G190
                           (COND
                            ((OR (ATOM #5#) (PROGN (LETT |g| (CAR #5#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #4#
                                    (|GALFACT;henselfact|
                                     (SPADCALL |g| (QCDR |lrf|)
                                               (QREFELT $ 106))
                                     NIL
                                     (|GALFACT;sel_set| |d|
                                      (SPADCALL |g| (QREFELT $ 39)) |dh| $)
                                     $))
                              (COND
                               (#2#
                                (LETT #3# (SPADCALL #3# #4# (QREFELT $ 107))))
                               ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                           (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                      (COND (#2# #3#) (#10# NIL))))))))))
          #9# (EXIT #8#)))) 

(SDEFUN |GALFACT;henselfact1|
        ((|f| (UP)) (|pdecomp| (|Boolean|)) ($ (|List| UP)))
        (|GALFACT;henselfact| |f| |pdecomp|
         (|GALFACT;fullSet| (SPADCALL |f| (QREFELT $ 39)) $) $)) 

(SDEFUN |GALFACT;completeFactor|
        ((|f| (UP)) (|lf| (|List| UP)) (|cprime| (|Integer|))
         (|pk| (|PositiveInteger|)) (|r| (|NonNegativeInteger|))
         (|d| (|Set| (|NonNegativeInteger|))) ($ (|List| UP)))
        (SPROG
         ((|level| (|Integer|)) (|found?| (|Boolean|))
          (|levels| (|NonNegativeInteger|))
          (|ic| (|Union| (|Integer|) "End of level")) (#1=#:G993 NIL)
          (#2=#:G979 NIL)
          (|llg|
           (|Record| (|:| |plist| (|List| UP)) (|:| |modulo| (|Integer|))))
          (|b| (|PositiveInteger|)) (#3=#:G978 NIL) (|ltrue| #4=(|List| UP))
          (|degf| #5=(|NonNegativeInteger|)) (#6=#:G975 NIL) (|lg| #4#)
          (|gpk| (|PositiveInteger|)) (#7=#:G962 NIL) (#8=#:G959 NIL)
          (#9=#:G958 NIL) (|rg| #5#) (#10=#:G957 NIL)
          (|dg| (|Set| (|NonNegativeInteger|))) (|f0| (|Integer|))
          (|lc| (|Integer|)) (#11=#:G947 NIL) (#12=#:G945 NIL)
          (|nb| (|Integer|)) (#13=#:G996 NIL) (|j| NIL)
          (|f1| (|Union| UP "failed")) (|g| (UP)) (#14=#:G995 NIL)
          (|g0| (|Integer|)) (|degg| #5#) (#15=#:G994 NIL) (|i| (|Integer|))
          (#16=#:G803 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |lc| (SPADCALL |f| (QREFELT $ 28)))
                (LETT |f0| (SPADCALL |f| 0 (QREFELT $ 108))) (LETT |ltrue| NIL)
                (LETT |found?| 'T) (LETT |degf| 0) (LETT |degg| 0)
                (LETT |g0| 0) (LETT |g| (|spadConstant| $ 59)) (LETT |rg| 0)
                (LETT |nb| 0) (LETT |lg| NIL) (LETT |b| 1)
                (LETT |dg| (SPADCALL (QREFELT $ 75))) (LETT |llg| (CONS NIL 0))
                (LETT |levels| (LENGTH |lf|)) (LETT |level| 1)
                (LETT |ic| (CONS 0 0)) (LETT |i| 0)
                (SEQ G190 (COND ((NULL (< |level| |levels|)) (GO G191)))
                     (SEQ (LETT |ic| (CONS 0 (|GALFACT;seed| |level| $)))
                          (SEQ G190
                               (COND
                                ((NULL
                                  (COND (|found?| NIL) ('T (QEQCAR |ic| 0))))
                                 (GO G191)))
                               (SEQ
                                (LETT |i|
                                      (PROG2 (LETT #16# |ic|)
                                          (QCDR #16#)
                                        (|check_union2| (QEQCAR #16# 0)
                                                        (|Integer|)
                                                        (|Union| (|Integer|)
                                                                 "End of level")
                                                        #16#)))
                                (LETT |degg| 0) (LETT |g0| 1)
                                (SEQ (LETT |j| 1) (LETT #15# |levels|) G190
                                     (COND ((|greater_SI| |j| #15#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((SPADCALL |i| (- |j| 1)
                                                   (QREFELT $ 109))
                                         (SEQ
                                          (LETT |degg|
                                                (+ |degg|
                                                   (SPADCALL
                                                    (SPADCALL |lf| |j|
                                                              (QREFELT $ 110))
                                                    (QREFELT $ 39))))
                                          (EXIT
                                           (LETT |g0|
                                                 (* |g0|
                                                    (SPADCALL
                                                     (SPADCALL |lf| |j|
                                                               (QREFELT $ 110))
                                                     0 (QREFELT $ 108))))))))))
                                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |g0|
                                      (SPADCALL (* |lc| |g0|) |pk|
                                                (QREFELT $ 111)))
                                (COND
                                 ((SPADCALL |degg| |d| (QREFELT $ 112))
                                  (COND
                                   ((QEQCAR
                                     (SPADCALL (* |lc| |f0|) |g0|
                                               (QREFELT $ 114))
                                     0)
                                    (SEQ
                                     (LETT |g| (SPADCALL |lc| (QREFELT $ 62)))
                                     (SEQ (LETT |j| 1) (LETT #14# |levels|)
                                          G190
                                          (COND
                                           ((|greater_SI| |j| #14#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (COND
                                             ((SPADCALL |i| (- |j| 1)
                                                        (QREFELT $ 109))
                                              (LETT |g|
                                                    (SPADCALL |g|
                                                              (SPADCALL |lf|
                                                                        |j|
                                                                        (QREFELT
                                                                         $
                                                                         110))
                                                              (QREFELT $
                                                                       115)))))))
                                          (LETT |j| (|inc_SI| |j|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (LETT |g|
                                           (SPADCALL
                                            (SPADCALL |g| |pk| (QREFELT $ 116))
                                            (QREFELT $ 117)))
                                     (LETT |f1|
                                           (SPADCALL |f| |g| (QREFELT $ 118)))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |f1| 0)
                                        (SEQ (LETT |found?| 'T) (LETT |nb| 1)
                                             (SEQ (LETT |j| 1)
                                                  (LETT #13# |levels|) G190
                                                  (COND
                                                   ((|greater_SI| |j| #13#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (COND
                                                     ((SPADCALL |i| (- |j| 1)
                                                                (QREFELT $
                                                                         109))
                                                      (SEQ
                                                       (SPADCALL |lf| |j| |nb|
                                                                 (QREFELT $
                                                                          119))
                                                       (EXIT
                                                        (LETT |nb|
                                                              (+ |nb| 1))))))))
                                                  (LETT |j| (|inc_SI| |j|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (LETT |lg| |lf|)
                                             (LETT |lf|
                                                   (SPADCALL |lf|
                                                             (PROG1
                                                                 (LETT #12#
                                                                       |level|)
                                                               (|check_subtype2|
                                                                (>= #12# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #12#))
                                                             (QREFELT $ 120)))
                                             (SPADCALL
                                              (SPADCALL |lg|
                                                        (PROG1
                                                            (LETT #11#
                                                                  (- |level|
                                                                     1))
                                                          (|check_subtype2|
                                                           (>= #11# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #11#))
                                                        (QREFELT $ 120))
                                              NIL (QREFELT $ 121))
                                             (LETT |f| (QCDR |f1|))
                                             (LETT |lc|
                                                   (SPADCALL |f|
                                                             (QREFELT $ 28)))
                                             (LETT |f0|
                                                   (SPADCALL |f| 0
                                                             (QREFELT $ 108)))
                                             (LETT |dg|
                                                   (SPADCALL
                                                    (CONS
                                                     #'|GALFACT;completeFactor!0|
                                                     (VECTOR $ |degg|))
                                                    |d| (QREFELT $ 95)))
                                             (COND
                                              ((SPADCALL |dg|
                                                         (SPADCALL
                                                          (LIST 0 |degg|)
                                                          (QREFELT $ 49))
                                                         (QREFELT $ 81))
                                               (LETT |lg| (LIST |g|)))
                                              ('T
                                               (SEQ
                                                (LETT |rg|
                                                      (PROG1
                                                          (LETT #10#
                                                                (MAX 2
                                                                     (-
                                                                      (+ |r|
                                                                         |level|)
                                                                      |levels|)))
                                                        (|check_subtype2|
                                                         (>= #10# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #10#)))
                                                (LETT |b|
                                                      (PROG1
                                                          (LETT #9#
                                                                (*
                                                                 (* 2
                                                                    (SPADCALL
                                                                     |g|
                                                                     (QREFELT $
                                                                              28)))
                                                                 (SPADCALL |g|
                                                                           |rg|
                                                                           (QREFELT
                                                                            $
                                                                            122))))
                                                        (|check_subtype2|
                                                         (> #9# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #9#)))
                                                (EXIT
                                                 (COND
                                                  ((> |b| |pk|)
                                                   (COND
                                                    ((SPADCALL |g|
                                                               (QREFELT $ 97))
                                                     (LETT |lg| (LIST |g|)))
                                                    ((QREFELT $ 11)
                                                     (COND
                                                      ((SPADCALL |g|
                                                                 (QREFELT $
                                                                          37))
                                                       (LETT |lg| (LIST |g|)))
                                                      ('T
                                                       (SEQ
                                                        (LETT |llg|
                                                              (SPADCALL |g|
                                                                        |lg|
                                                                        |cprime|
                                                                        |b|
                                                                        (QREFELT
                                                                         $
                                                                         124)))
                                                        (LETT |gpk|
                                                              (PROG1
                                                                  (LETT #8#
                                                                        (QCDR
                                                                         |llg|))
                                                                (|check_subtype2|
                                                                 (> #8# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|Integer|)
                                                                 #8#)))
                                                        (EXIT
                                                         (COND
                                                          ((< |gpk| |b|)
                                                           (LETT |lg|
                                                                 (QCAR |llg|)))
                                                          ('T
                                                           (LETT |lg|
                                                                 (|GALFACT;completeFactor|
                                                                  |g|
                                                                  (QCAR |llg|)
                                                                  |cprime|
                                                                  |gpk| |rg|
                                                                  |dg|
                                                                  $)))))))))
                                                    ('T
                                                     (SEQ
                                                      (LETT |llg|
                                                            (SPADCALL |g| |lg|
                                                                      |cprime|
                                                                      |b|
                                                                      (QREFELT
                                                                       $ 124)))
                                                      (LETT |gpk|
                                                            (PROG1
                                                                (LETT #7#
                                                                      (QCDR
                                                                       |llg|))
                                                              (|check_subtype2|
                                                               (> #7# 0)
                                                               '(|PositiveInteger|)
                                                               '(|Integer|)
                                                               #7#)))
                                                      (EXIT
                                                       (COND
                                                        ((< |gpk| |b|)
                                                         (LETT |lg|
                                                               (QCAR |llg|)))
                                                        ('T
                                                         (LETT |lg|
                                                               (|GALFACT;completeFactor|
                                                                |g|
                                                                (QCAR |llg|)
                                                                |cprime| |gpk|
                                                                |rg| |dg|
                                                                $)))))))))
                                                  ('T
                                                   (LETT |lg| (LIST |g|))))))))
                                             (LETT |ltrue|
                                                   (SPADCALL |ltrue| |lg|
                                                             (QREFELT $ 107)))
                                             (LETT |r|
                                                   (PROG1
                                                       (LETT #6#
                                                             (MAX 2
                                                                  (- |r|
                                                                     (LENGTH
                                                                      |lg|))))
                                                     (|check_subtype2|
                                                      (>= #6# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #6#)))
                                             (LETT |degf|
                                                   (SPADCALL |f|
                                                             (QREFELT $ 39)))
                                             (LETT |d|
                                                   (SPADCALL
                                                    (CONS
                                                     #'|GALFACT;completeFactor!1|
                                                     (VECTOR $ |degf|))
                                                    |d| (QREFELT $ 95)))
                                             (EXIT
                                              (COND
                                               ((<= |degf| 1)
                                                (SEQ
                                                 (COND
                                                  ((EQL |degf| 1)
                                                   (LETT |ltrue|
                                                         (CONS |f| |ltrue|))))
                                                 (EXIT
                                                  (PROGN
                                                   (LETT #1# |ltrue|)
                                                   (GO #17=#:G992)))))
                                               ('T
                                                (SEQ
                                                 (LETT |b|
                                                       (PROG1
                                                           (LETT #3#
                                                                 (* (* 2 |lc|)
                                                                    (SPADCALL
                                                                     |f| |r|
                                                                     (QREFELT $
                                                                              122))))
                                                         (|check_subtype2|
                                                          (> #3# 0)
                                                          '(|PositiveInteger|)
                                                          '(|Integer|) #3#)))
                                                 (EXIT
                                                  (COND
                                                   ((> |b| |pk|)
                                                    (SEQ
                                                     (LETT |llg|
                                                           (SPADCALL |f| |lf|
                                                                     |cprime|
                                                                     |b|
                                                                     (QREFELT $
                                                                              124)))
                                                     (LETT |lf| (QCAR |llg|))
                                                     (LETT |pk|
                                                           (PROG1
                                                               (LETT #2#
                                                                     (QCDR
                                                                      |llg|))
                                                             (|check_subtype2|
                                                              (> #2# 0)
                                                              '(|PositiveInteger|)
                                                              '(|Integer|)
                                                              #2#)))
                                                     (COND
                                                      ((< |pk| |b|)
                                                       (PROGN
                                                        (LETT #1#
                                                              (SPADCALL |lf|
                                                                        |ltrue|
                                                                        (QREFELT
                                                                         $
                                                                         107)))
                                                        (GO #17#))))
                                                     (EXIT
                                                      (LETT |level|
                                                            1)))))))))))))))))))
                                (EXIT
                                 (LETT |ic|
                                       (|GALFACT;nextRecNum| |levels| |level|
                                        |i| $))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (COND
                           (|found?|
                            (SEQ (LETT |levels| (LENGTH |lf|))
                                 (EXIT (LETT |found?| NIL)))))
                          (EXIT
                           (COND
                            ((NULL (QEQCAR |ic| 0))
                             (LETT |level| (+ |level| 1))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS |f| |ltrue|))))
          #17# (EXIT #1#)))) 

(SDEFUN |GALFACT;completeFactor!1| ((|x| NIL) ($$ NIL))
        (PROG (|degf| $)
          (LETT |degf| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |degf| (QREFELT $ 90)))))) 

(SDEFUN |GALFACT;completeFactor!0| ((|x| NIL) ($$ NIL))
        (PROG (|degg| $)
          (LETT |degg| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |degg| (QREFELT $ 90)))))) 

(SDEFUN |GALFACT;divideSet|
        ((|s| (|Set| (|NonNegativeInteger|))) (|n| (|NonNegativeInteger|))
         ($ (|Set| (|NonNegativeInteger|))))
        (SPROG
         ((|l| (|List| (|NonNegativeInteger|)))
          (|ee| (|Union| (|NonNegativeInteger|) "failed")) (#1=#:G1005 NIL)
          (|e| NIL))
         (SEQ (LETT |l| (LIST 0))
              (SEQ (LETT |e| NIL) (LETT #1# (SPADCALL |s| (QREFELT $ 125)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ee| (SPADCALL |e| |n| (QREFELT $ 126)))
                        (EXIT
                         (COND
                          ((QEQCAR |ee| 0)
                           (LETT |l| (CONS (QCDR |ee|) |l|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |l| (QREFELT $ 49)))))) 

(SDEFUN |GALFACT;btwFactor|
        ((|f| (UP)) (|d| (|Set| (|NonNegativeInteger|)))
         (|r| (|NonNegativeInteger|)) (|pdecomp| (|Boolean|))
         ($ #1=(|List| UP)))
        (SPROG
         ((#2=#:G1062 NIL) (|i| NIL) (|lf| #3=(|List| UP)) (#4=#:G1061 NIL)
          (|fact| NIL) (#5=#:G1060 NIL) (#6=#:G1046 NIL) (|lfg| #1#)
          (#7=#:G1037 NIL) (|df| #8=(|NonNegativeInteger|)) (#9=#:G1027 NIL)
          (|dgh| (|NonNegativeInteger|)) (|dg| #8#) (|g| (UP))
          (#10=#:G1059 NIL) (|lg| #1#) (|dh| #8#)
          (|lrf| (|Record| (|:| |left| UP) (|:| |right| UP)))
          (|pk| (|PositiveInteger|)) (#11=#:G1021 NIL)
          (|lm| (|Record| (|:| |plist| #3#) (|:| |modulo| (|Integer|))))
          (|b| (|PositiveInteger|)) (#12=#:G1019 NIL) (|lc| (|Integer|))
          (#13=#:G1058 NIL) (|cprime| #14=(|Integer|))
          (|m| (|Record| (|:| |prime| #14#) (|:| |factors| (|List| UP))))
          (|cf| (|Union| (|Record| (|:| |left| UP) (|:| |right| UP)) "failed"))
          (|negativelc?| #15=(|Boolean|)) (|reverse?| #15#))
         (SEQ
          (EXIT
           (SEQ (LETT |df| (SPADCALL |f| (QREFELT $ 39)))
                (COND
                 ((NULL (EQL (SPADCALL |d| (QREFELT $ 127)) |df|))
                  (EXIT (|error| "btwFact: Bad arguments"))))
                (LETT |reverse?| NIL) (LETT |negativelc?| NIL)
                (EXIT
                 (COND
                  ((SPADCALL |d| (SPADCALL (LIST 0 |df|) (QREFELT $ 49))
                             (QREFELT $ 81))
                   (LIST |f|))
                  (#16='T
                   (SEQ
                    (COND
                     ((< (ABS (SPADCALL |f| 0 (QREFELT $ 108)))
                         (ABS (SPADCALL |f| (QREFELT $ 28))))
                      (SEQ (LETT |f| (SPADCALL |f| (QREFELT $ 129)))
                           (EXIT (LETT |reverse?| 'T)))))
                    (COND
                     ((SPADCALL |f| (QREFELT $ 97))
                      (EXIT
                       (COND (|reverse?| (LIST (SPADCALL |f| (QREFELT $ 129))))
                             (#16# (LIST |f|)))))
                     ((QREFELT $ 11)
                      (COND
                       ((SPADCALL |f| (QREFELT $ 37))
                        (EXIT
                         (COND
                          (|reverse?| (LIST (SPADCALL |f| (QREFELT $ 129))))
                          (#16# (LIST |f|))))))))
                    (COND
                     ((< (SPADCALL |f| (QREFELT $ 28)) 0)
                      (SEQ (LETT |f| (SPADCALL |f| (QREFELT $ 130)))
                           (EXIT (LETT |negativelc?| 'T)))))
                    (COND
                     (|pdecomp|
                      (COND
                       ((QREFELT $ 10)
                        (LETT |cf| (SPADCALL |f| (QREFELT $ 101))))
                       (#16# (LETT |cf| (CONS 1 #17="failed")))))
                     (#16# (LETT |cf| (CONS 1 #17#))))
                    (COND
                     ((QEQCAR |cf| 1)
                      (SEQ (LETT |m| (SPADCALL |f| |d| (QREFELT $ 84)))
                           (EXIT
                            (COND
                             ((ZEROP (LETT |cprime| (QCAR |m|)))
                              (COND
                               (|reverse?|
                                (COND
                                 (|negativelc?|
                                  (PROGN
                                   (LETT #13#
                                         (LIST
                                          (SPADCALL
                                           (SPADCALL |f| (QREFELT $ 129))
                                           (QREFELT $ 130))))
                                   (GO #18=#:G1057)))
                                 (#16#
                                  (PROGN
                                   (LETT #13#
                                         (LIST (SPADCALL |f| (QREFELT $ 129))))
                                   (GO #18#)))))
                               (|negativelc?|
                                (PROGN
                                 (LETT #13#
                                       (LIST (SPADCALL |f| (QREFELT $ 130))))
                                 (GO #18#)))
                               (#16#
                                (PROGN (LETT #13# (LIST |f|)) (GO #18#)))))
                             (#16#
                              (SEQ
                               (COND
                                ((SPADCALL |f| (QREFELT $ 131))
                                 (LETT |d| (SPADCALL 1 |d| (QREFELT $ 132)))))
                               (LETT |lc| (SPADCALL |f| (QREFELT $ 28)))
                               (LETT |b|
                                     (PROG1
                                         (LETT #12#
                                               (* (* 2 |lc|)
                                                  (SPADCALL |f| |r|
                                                            (QREFELT $ 122))))
                                       (|check_subtype2| (> #12# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #12#)))
                               (LETT |lm|
                                     (SPADCALL |f| (QCDR |m|) |cprime| |b|
                                               (QREFELT $ 124)))
                               (LETT |lf| (QCAR |lm|))
                               (LETT |pk|
                                     (PROG1 (LETT #11# (QCDR |lm|))
                                       (|check_subtype2| (> #11# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #11#)))
                               (COND
                                ((SPADCALL (|SPADfirst| |lf|) (QREFELT $ 133))
                                 (LETT |lf| (CDR |lf|))))
                               (EXIT
                                (COND
                                 ((NULL (< |pk| |b|))
                                  (LETT |lf|
                                        (|GALFACT;completeFactor| |f| |lf|
                                         |cprime| |pk| |r| |d| $)))))))))))
                     (#16#
                      (SEQ (LETT |lrf| (QCDR |cf|))
                           (LETT |dh| (SPADCALL (QCDR |lrf|) (QREFELT $ 39)))
                           (LETT |lg|
                                 (|GALFACT;btwFactor| (QCAR |lrf|)
                                  (|GALFACT;divideSet| |d| |dh| $) 2 'T $))
                           (LETT |lf| NIL)
                           (EXIT
                            (SEQ (LETT |i| 1) (LETT #10# (LENGTH |lg|)) G190
                                 (COND ((|greater_SI| |i| #10#) (GO G191)))
                                 (SEQ
                                  (LETT |g|
                                        (SPADCALL |lg| |i| (QREFELT $ 110)))
                                  (LETT |dg| (SPADCALL |g| (QREFELT $ 39)))
                                  (LETT |dgh| (* |dg| |dh|))
                                  (LETT |df|
                                        (PROG2
                                            (LETT #9#
                                                  (SPADCALL |df| |dgh|
                                                            (QREFELT $ 134)))
                                            (QCDR #9#)
                                          (|check_union2| (QEQCAR #9# 0)
                                                          (|NonNegativeInteger|)
                                                          (|Union|
                                                           (|NonNegativeInteger|)
                                                           "failed")
                                                          #9#)))
                                  (LETT |lfg|
                                        (|GALFACT;btwFactor|
                                         (SPADCALL |g| (QCDR |lrf|)
                                                   (QREFELT $ 106))
                                         (|GALFACT;sel_set| |d| |dg| |dh| $)
                                         (PROG1 (LETT #7# (MAX 2 (- |r| |df|)))
                                           (|check_subtype2| (>= #7# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #7#))
                                         NIL $))
                                  (LETT |lf|
                                        (SPADCALL |lf| |lfg| (QREFELT $ 107)))
                                  (EXIT
                                   (LETT |r|
                                         (PROG1
                                             (LETT #6#
                                                   (MAX 2
                                                        (- |r|
                                                           (LENGTH |lfg|))))
                                           (|check_subtype2| (>= #6# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|)
                                                             #6#)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))))))
                    (COND
                     (|reverse?|
                      (LETT |lf|
                            (PROGN
                             (LETT #5# NIL)
                             (SEQ (LETT |fact| NIL) (LETT #4# |lf|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |fact| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #5#
                                          (CONS
                                           (SPADCALL |fact| (QREFELT $ 129))
                                           #5#))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT (NREVERSE #5#)))))))
                    (SEQ (LETT |i| 1) (LETT #2# (LENGTH |lf|)) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((<
                              (SPADCALL (SPADCALL |lf| |i| (QREFELT $ 110))
                                        (QREFELT $ 28))
                              0)
                             (SPADCALL |lf| |i|
                                       (SPADCALL
                                        (SPADCALL |lf| |i| (QREFELT $ 110))
                                        (QREFELT $ 130))
                                       (QREFELT $ 135))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |lf|)))))))
          #18# (EXIT #13#)))) 

(SDEFUN |GALFACT;makeFR;RF;30|
        ((|flist|
          (|Record| (|:| |contp| (|Integer|))
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| UP)
                                    (|:| |pow| (|NonNegativeInteger|)))))))
         ($ (|Factored| UP)))
        (SPROG
         ((|fflist|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| UP)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G1081 NIL) (|fc| NIL) (#2=#:G1080 NIL) (|ff| NIL)
          (|ctp| (|Factored| (|Integer|))))
         (SEQ (LETT |ctp| (SPADCALL (QCAR |flist|) (QREFELT $ 31)))
              (LETT |fflist| NIL)
              (SEQ (LETT |ff| NIL) (LETT #2# (QCDR |flist|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |ff| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |fflist|
                           (CONS
                            (VECTOR (CONS 3 "prime") (QCAR |ff|) (QCDR |ff|))
                            |fflist|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |fc| NIL) (LETT #1# (SPADCALL |ctp| (QREFELT $ 36)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |fc| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |fflist|
                           (CONS
                            (VECTOR (QVELT |fc| 0)
                                    (SPADCALL (QVELT |fc| 1) (QREFELT $ 62))
                                    (QVELT |fc| 2))
                            |fflist|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |ctp| (QREFELT $ 136)) (QREFELT $ 62))
                |fflist| (QREFELT $ 140)))))) 

(SDEFUN |GALFACT;quadratic| ((|p| (UP)) ($ (|List| UP)))
        (SPROG
         ((#1=#:G1087 NIL) (|f| (UP)) (|b| (|Integer|)) (|a| (|Integer|))
          (|d| (|Integer|)) (|r| (|Union| (|Integer|) "failed")))
         (SEQ (LETT |a| (SPADCALL |p| (QREFELT $ 28)))
              (LETT |b| (SPADCALL |p| 1 (QREFELT $ 108)))
              (LETT |d|
                    (- (EXPT |b| 2)
                       (* (* 4 |a|) (SPADCALL |p| 0 (QREFELT $ 108)))))
              (LETT |r| (SPADCALL |d| (QREFELT $ 146)))
              (EXIT
               (COND ((QEQCAR |r| 1) (LIST |p|))
                     ('T
                      (SEQ (LETT |b| (+ |b| (QCDR |r|))) (LETT |a| (* 2 |a|))
                           (LETT |d| (GCD |a| |b|))
                           (COND
                            ((NULL (EQL |d| 1))
                             (SEQ (LETT |a| (QUOTIENT2 |a| |d|))
                                  (EXIT (LETT |b| (QUOTIENT2 |b| |d|))))))
                           (LETT |f|
                                 (SPADCALL (SPADCALL |a| 1 (QREFELT $ 147))
                                           (SPADCALL |b| 0 (QREFELT $ 147))
                                           (QREFELT $ 148)))
                           (EXIT
                            (CONS |f|
                                  (LIST
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL |p| |f|
                                                       (QREFELT $ 118)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (QREFELT $ 6)
                                                     (|Union| (QREFELT $ 6)
                                                              "failed")
                                                     #1#)))))))))))) 

(SDEFUN |GALFACT;isPowerOf2| ((|n| (|Integer|)) ($ (|Boolean|)))
        (SPROG
         ((|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|)))))
         (SEQ
          (COND ((EQL |n| 1) 'T)
                (#1='T
                 (SEQ (LETT |qr| (DIVIDE2 |n| 2))
                      (EXIT
                       (COND ((EQL (QCDR |qr|) 1) NIL)
                             (#1# (|GALFACT;isPowerOf2| (QCAR |qr|) $)))))))))) 

(SDEFUN |GALFACT;subMinusX|
        ((|supPol| (|SparseUnivariatePolynomial| (|Integer|))) ($ (UP)))
        (SPROG ((|minusX| (|SparseUnivariatePolynomial| (|Integer|))))
               (SEQ (LETT |minusX| (SPADCALL -1 1 (QREFELT $ 149)))
                    (EXIT
                     (SPADCALL (SPADCALL |supPol| |minusX| (QREFELT $ 150))
                               (QREFELT $ 61)))))) 

(SDEFUN |GALFACT;gen_fact1|
        ((|f| (UP))
         ($
          (|Union|
           (|Record| (|:| |f| UP) (|:| |contp| (|Integer|))
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| UP)
                                     (|:| |pow| (|NonNegativeInteger|))))))
           (|Record| (|:| |contp| (|Integer|))
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| UP)
                                     (|:| |pow| (|NonNegativeInteger|)))))))))
        (SPROG
         ((|factorlist|
           (|List|
            (|Record| (|:| |irr| UP) (|:| |pow| (|NonNegativeInteger|)))))
          (#1=#:G1122 NIL) (|fac| NIL)
          (|cfl| (|List| (|SparseUnivariatePolynomial| (|Integer|))))
          (#2=#:G1121 NIL) (|lcPol| (UP)) (|d| (|NonNegativeInteger|))
          (|c| (|Integer|)) (#3=#:G1104 NIL))
         (SEQ (LETT |factorlist| NIL) (LETT |c| (SPADCALL |f| (QREFELT $ 26)))
              (LETT |f|
                    (PROG2 (LETT #3# (SPADCALL |f| |c| (QREFELT $ 151)))
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 0) (QREFELT $ 6)
                                      (|Union| (QREFELT $ 6) "failed") #3#)))
              (COND
               ((< (SPADCALL |f| (QREFELT $ 28)) 0)
                (SEQ (LETT |c| (- |c|))
                     (EXIT (LETT |f| (SPADCALL |f| (QREFELT $ 130)))))))
              (SEQ (LETT |d| (SPADCALL |f| (QREFELT $ 152)))
                   (EXIT
                    (COND
                     ((> |d| 0)
                      (SEQ
                       (LETT |f|
                             (QCAR
                              (SPADCALL |f| (SPADCALL 1 |d| (QREFELT $ 147))
                                        (QREFELT $ 154))))
                       (EXIT
                        (LETT |factorlist|
                              (LIST
                               (CONS (SPADCALL 1 1 (QREFELT $ 147))
                                     |d|)))))))))
              (LETT |d| (SPADCALL |f| (QREFELT $ 39)))
              (EXIT
               (COND ((ZEROP |d|) (CONS 1 (CONS |c| |factorlist|)))
                     ((EQL |d| 1)
                      (CONS 1 (CONS |c| (CONS (CONS |f| 1) |factorlist|))))
                     (#4='T
                      (SEQ
                       (LETT |lcPol|
                             (SPADCALL (SPADCALL |f| (QREFELT $ 28))
                                       (QREFELT $ 62)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |lcPol| (QREFELT $ 130))
                                    (SPADCALL |f| (QREFELT $ 24))
                                    (QREFELT $ 155))
                          (SEQ (LETT |cfl| (SPADCALL |d| (QREFELT $ 158)))
                               (SEQ (LETT |fac| NIL)
                                    (LETT #2#
                                          (SPADCALL (ELT $ 61) |cfl|
                                                    (QREFELT $ 161)))
                                    G190
                                    (COND
                                     ((OR (ATOM #2#)
                                          (PROGN (LETT |fac| (CAR #2#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |factorlist|
                                            (CONS (CONS |fac| 1)
                                                  |factorlist|))))
                                    (LETT #2# (CDR #2#)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT (CONS 1 (CONS |c| |factorlist|)))))
                         ((SPADCALL |lcPol| (SPADCALL |f| (QREFELT $ 24))
                                    (QREFELT $ 155))
                          (SEQ (LETT |cfl| (SPADCALL |d| (QREFELT $ 162)))
                               (SEQ (LETT |fac| NIL)
                                    (LETT #1#
                                          (SPADCALL (ELT $ 61) |cfl|
                                                    (QREFELT $ 161)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |fac| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |factorlist|
                                            (CONS (CONS |fac| 1)
                                                  |factorlist|))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT (CONS 1 (CONS |c| |factorlist|)))))
                         (#4# (CONS 0 (VECTOR |f| |c| |factorlist|)))))))))))) 

(SDEFUN |GALFACT;henselFact;UPBR;35|
        ((|f| (UP)) (|sqf| (|Boolean|))
         ($
          (|Record| (|:| |contp| (|Integer|))
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| UP)
                                    (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((|factorlist|
           (|List|
            (|Record| (|:| |irr| UP) (|:| |pow| (|NonNegativeInteger|)))))
          (|fla|
           (|List|
            #1=(|Record| (|:| |irr| UP) (|:| |pow| (|NonNegativeInteger|)))))
          (#2=#:G1143 NIL) (|pf| NIL) (#3=#:G1142 NIL) (|fl1| (|List| UP))
          (|d| (|NonNegativeInteger|)) (|sqff| (UP))
          (|mult| #4=(|NonNegativeInteger|)) (#5=#:G1141 NIL) (|sqfr| NIL)
          (|sqfflist|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| UP) (|:| |exponent| #4#))))
          (#6=#:G1140 NIL) (#7=#:G1139 NIL) (|c| (|Integer|))
          (|#G125|
           (|Record| (|:| |f| UP) (|:| |contp| (|Integer|))
                     (|:| |factors| (|List| #1#))))
          (|ru|
           (|Union|
            (|Record| (|:| |f| UP) (|:| |contp| (|Integer|))
                      (|:| |factors|
                           (|List|
                            (|Record| (|:| |irr| UP)
                                      (|:| |pow| (|NonNegativeInteger|))))))
            (|Record| (|:| |contp| (|Integer|))
                      (|:| |factors|
                           (|List|
                            (|Record| (|:| |irr| UP)
                                      (|:| |pow| (|NonNegativeInteger|)))))))))
         (SEQ (LETT |ru| (|GALFACT;gen_fact1| |f| $))
              (EXIT
               (COND ((QEQCAR |ru| 1) (QCDR |ru|))
                     (#8='T
                      (SEQ
                       (PROGN
                        (LETT |#G125| (QCDR |ru|))
                        (LETT |f| (QVELT |#G125| 0))
                        (LETT |c| (QVELT |#G125| 1))
                        (LETT |factorlist| (QVELT |#G125| 2))
                        |#G125|)
                       (EXIT
                        (COND
                         (|sqf|
                          (SEQ
                           (LETT |fla|
                                 (PROGN
                                  (LETT #7# NIL)
                                  (SEQ (LETT |pf| NIL)
                                       (LETT #6#
                                             (|GALFACT;henselfact1| |f| 'T $))
                                       G190
                                       (COND
                                        ((OR (ATOM #6#)
                                             (PROGN (LETT |pf| (CAR #6#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #7# (CONS (CONS |pf| 1) #7#))))
                                       (LETT #6# (CDR #6#)) (GO G190) G191
                                       (EXIT (NREVERSE #7#)))))
                           (EXIT
                            (CONS |c|
                                  (SPADCALL |fla| |factorlist|
                                            (QREFELT $ 164))))))
                         (#8#
                          (SEQ
                           (LETT |sqfflist|
                                 (SPADCALL (SPADCALL |f| (QREFELT $ 165))
                                           (QREFELT $ 166)))
                           (SEQ (LETT |sqfr| NIL) (LETT #5# |sqfflist|) G190
                                (COND
                                 ((OR (ATOM #5#)
                                      (PROGN (LETT |sqfr| (CAR #5#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |mult| (QVELT |sqfr| 2))
                                     (LETT |sqff| (QVELT |sqfr| 1))
                                     (LETT |d|
                                           (SPADCALL |sqff| (QREFELT $ 39)))
                                     (EXIT
                                      (COND
                                       ((EQL |d| 1)
                                        (LETT |factorlist|
                                              (CONS (CONS |sqff| |mult|)
                                                    |factorlist|)))
                                       ('T
                                        (SEQ
                                         (LETT |fl1|
                                               (COND
                                                ((EQL |d| 2)
                                                 (|GALFACT;quadratic| |sqff|
                                                  $))
                                                ('T
                                                 (|GALFACT;henselfact1| |sqff|
                                                  'T $))))
                                         (LETT |fla|
                                               (PROGN
                                                (LETT #3# NIL)
                                                (SEQ (LETT |pf| NIL)
                                                     (LETT #2# |fl1|) G190
                                                     (COND
                                                      ((OR (ATOM #2#)
                                                           (PROGN
                                                            (LETT |pf|
                                                                  (CAR #2#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #3#
                                                             (CONS
                                                              (CONS |pf|
                                                                    |mult|)
                                                              #3#))))
                                                     (LETT #2# (CDR #2#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #3#)))))
                                         (EXIT
                                          (LETT |factorlist|
                                                (SPADCALL |fla| |factorlist|
                                                          (QREFELT $
                                                                   164)))))))))
                                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                           (EXIT (CONS |c| |factorlist|))))))))))))) 

(SDEFUN |GALFACT;btwFact;UPBSNniR;36|
        ((|f| (UP)) (|sqf| (|Boolean|)) (|fd| (|Set| (|NonNegativeInteger|)))
         (|r| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |contp| (|Integer|))
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| UP)
                                    (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((|maxd| (|NonNegativeInteger|)) (#1=#:G1171 NIL)
          (|factorlist|
           (|List|
            (|Record| (|:| |irr| UP) (|:| |pow| (|NonNegativeInteger|)))))
          (|fla|
           (|List|
            #2=(|Record| (|:| |irr| UP) (|:| |pow| (|NonNegativeInteger|)))))
          (#3=#:G1184 NIL) (|pf| NIL) (#4=#:G1183 NIL) (|fl1| (|List| UP))
          (#5=#:G1165 NIL) (|d| #6=(|NonNegativeInteger|)) (|sqff| (UP))
          (|mult| #7=(|NonNegativeInteger|)) (#8=#:G1182 NIL) (|sqfr| NIL)
          (|sqfflist|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| UP) (|:| |exponent| #7#))))
          (#9=#:G1181 NIL) (#10=#:G1180 NIL) (#11=#:G1154 NIL)
          (|del_d| (|Integer|)) (|d1| #6#) (|c| (|Integer|))
          (|#G135|
           (|Record| (|:| |f| UP) (|:| |contp| (|Integer|))
                     (|:| |factors| (|List| #2#))))
          (|ru|
           (|Union|
            (|Record| (|:| |f| UP) (|:| |contp| (|Integer|))
                      (|:| |factors|
                           (|List|
                            (|Record| (|:| |irr| UP)
                                      (|:| |pow| (|NonNegativeInteger|))))))
            (|Record| (|:| |contp| (|Integer|))
                      (|:| |factors|
                           (|List|
                            (|Record| (|:| |irr| UP)
                                      (|:| |pow| (|NonNegativeInteger|)))))))))
         (SEQ (LETT |d| (SPADCALL |f| (QREFELT $ 39)))
              (COND
               ((NULL (EQL (SPADCALL |fd| (QREFELT $ 127)) |d|))
                (EXIT (|error| "btwFact: Bad arguments"))))
              (LETT |ru| (|GALFACT;gen_fact1| |f| $))
              (EXIT
               (COND ((QEQCAR |ru| 1) (QCDR |ru|))
                     (#12='T
                      (SEQ
                       (PROGN
                        (LETT |#G135| (QCDR |ru|))
                        (LETT |f| (QVELT |#G135| 0))
                        (LETT |c| (QVELT |#G135| 1))
                        (LETT |factorlist| (QVELT |#G135| 2))
                        |#G135|)
                       (SEQ (LETT |d1| (SPADCALL |f| (QREFELT $ 39)))
                            (EXIT
                             (COND
                              ((< |d1| |d|)
                               (SEQ (LETT |del_d| (- |d| |d1|))
                                    (LETT |r|
                                          (PROG1
                                              (LETT #11#
                                                    (MAX 2 (- |r| |del_d|)))
                                            (|check_subtype2| (>= #11# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #11#)))
                                    (LETT |d| |d1|)
                                    (EXIT
                                     (LETT |fd|
                                           (SPADCALL
                                            (CONS
                                             #'|GALFACT;btwFact;UPBSNniR;36!0|
                                             (VECTOR $ |d|))
                                            |fd| (QREFELT $ 95)))))))))
                       (EXIT
                        (COND
                         (|sqf|
                          (SEQ
                           (LETT |fla|
                                 (PROGN
                                  (LETT #10# NIL)
                                  (SEQ (LETT |pf| NIL)
                                       (LETT #9#
                                             (|GALFACT;btwFactor| |f| |fd| |r|
                                              'T $))
                                       G190
                                       (COND
                                        ((OR (ATOM #9#)
                                             (PROGN (LETT |pf| (CAR #9#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #10#
                                               (CONS (CONS |pf| 1) #10#))))
                                       (LETT #9# (CDR #9#)) (GO G190) G191
                                       (EXIT (NREVERSE #10#)))))
                           (EXIT
                            (CONS |c|
                                  (SPADCALL |fla| |factorlist|
                                            (QREFELT $ 164))))))
                         (#12#
                          (SEQ
                           (LETT |sqfflist|
                                 (SPADCALL (SPADCALL |f| (QREFELT $ 165))
                                           (QREFELT $ 166)))
                           (COND
                            ((EQL (LENGTH |sqfflist|) 1)
                             (LETT |r|
                                   (MAX
                                    (QUOTIENT2 |r|
                                               (QVELT (|SPADfirst| |sqfflist|)
                                                      2))
                                    2)))
                            (#12# (LETT |r| 2)))
                           (SEQ (LETT |sqfr| NIL) (LETT #8# |sqfflist|) G190
                                (COND
                                 ((OR (ATOM #8#)
                                      (PROGN (LETT |sqfr| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |mult| (QVELT |sqfr| 2))
                                     (LETT |sqff| (QVELT |sqfr| 1))
                                     (LETT |d|
                                           (SPADCALL |sqff| (QREFELT $ 39)))
                                     (EXIT
                                      (COND
                                       ((EQL |d| 1)
                                        (SEQ
                                         (LETT |factorlist|
                                               (CONS (CONS |sqff| |mult|)
                                                     |factorlist|))
                                         (LETT |maxd|
                                               (PROG1
                                                   (LETT #5#
                                                         (-
                                                          (SPADCALL |fd|
                                                                    (QREFELT $
                                                                             127))
                                                          |mult|))
                                                 (|check_subtype2| (>= #5# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #5#)))
                                         (EXIT
                                          (LETT |fd|
                                                (SPADCALL
                                                 (CONS
                                                  #'|GALFACT;btwFact;UPBSNniR;36!1|
                                                  (VECTOR $ |maxd|))
                                                 |fd| (QREFELT $ 95))))))
                                       ('T
                                        (SEQ
                                         (LETT |fl1|
                                               (COND
                                                ((EQL |d| 2)
                                                 (|GALFACT;quadratic| |sqff|
                                                  $))
                                                ('T
                                                 (|GALFACT;btwFactor| |sqff|
                                                  (SPADCALL
                                                   (CONS
                                                    #'|GALFACT;btwFact;UPBSNniR;36!2|
                                                    (VECTOR $ |d|))
                                                   |fd| (QREFELT $ 95))
                                                  |r| 'T $))))
                                         (LETT |fla|
                                               (PROGN
                                                (LETT #4# NIL)
                                                (SEQ (LETT |pf| NIL)
                                                     (LETT #3# |fl1|) G190
                                                     (COND
                                                      ((OR (ATOM #3#)
                                                           (PROGN
                                                            (LETT |pf|
                                                                  (CAR #3#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #4#
                                                             (CONS
                                                              (CONS |pf|
                                                                    |mult|)
                                                              #4#))))
                                                     (LETT #3# (CDR #3#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #4#)))))
                                         (LETT |factorlist|
                                               (SPADCALL |fla| |factorlist|
                                                         (QREFELT $ 164)))
                                         (LETT |maxd|
                                               (PROG1
                                                   (LETT #1#
                                                         (-
                                                          (SPADCALL |fd|
                                                                    (QREFELT $
                                                                             127))
                                                          (* |d| |mult|)))
                                                 (|check_subtype2| (>= #1# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #1#)))
                                         (EXIT
                                          (LETT |fd|
                                                (SPADCALL
                                                 (CONS
                                                  #'|GALFACT;btwFact;UPBSNniR;36!3|
                                                  (VECTOR $ |maxd|))
                                                 |fd| (QREFELT $ 95)))))))))
                                (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                           (EXIT (CONS |c| |factorlist|))))))))))))) 

(SDEFUN |GALFACT;btwFact;UPBSNniR;36!3| ((|x| NIL) ($$ NIL))
        (PROG (|maxd| $)
          (LETT |maxd| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |maxd| (QREFELT $ 90)))))) 

(SDEFUN |GALFACT;btwFact;UPBSNniR;36!2| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |d| (QREFELT $ 90)))))) 

(SDEFUN |GALFACT;btwFact;UPBSNniR;36!1| ((|x| NIL) ($$ NIL))
        (PROG (|maxd| $)
          (LETT |maxd| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |maxd| (QREFELT $ 90)))))) 

(SDEFUN |GALFACT;btwFact;UPBSNniR;36!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |d| (QREFELT $ 90)))))) 

(SDEFUN |GALFACT;factor;UPF;37| ((|f| (UP)) ($ (|Factored| UP)))
        (SPADCALL
         (COND
          ((QREFELT $ 9)
           (SPADCALL |f| NIL
                     (|GALFACT;fullSet| (SPADCALL |f| (QREFELT $ 39)) $) 2
                     (QREFELT $ 168)))
          ('T (SPADCALL |f| NIL (QREFELT $ 167))))
         (QREFELT $ 143))) 

(SDEFUN |GALFACT;errorsum?|
        ((|d| (|NonNegativeInteger|)) (|ld| (|List| #1=(|NonNegativeInteger|)))
         ($ (|Boolean|)))
        (SPROG
         ((#2=#:G1187 NIL) (#3=#:G1186 #1#) (#4=#:G1188 #1#) (#5=#:G1191 NIL)
          (#6=#:G689 NIL))
         (SEQ
          (NULL
           (EQL |d|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT #6# NIL) (LETT #5# |ld|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4# #6#)
                         (COND (#2# (LETT #3# (+ #3# #4#)))
                               ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (COND (#2# #3#) ('T 0)))))))) 

(SDEFUN |GALFACT;makeSet|
        ((|ld| (|List| (|NonNegativeInteger|)))
         ($ (|Set| (|NonNegativeInteger|))))
        (SPROG
         ((|s| (|Set| (|NonNegativeInteger|))) (#1=#:G1196 NIL) (|d| NIL))
         (SEQ (LETT |s| (SPADCALL (LIST 0) (QREFELT $ 49)))
              (SEQ (LETT |d| NIL) (LETT #1# |ld|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |d| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |s|
                           (SPADCALL |s| (|GALFACT;shiftSet| |s| |d| $)
                                     (QREFELT $ 79)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |s|)))) 

(SDEFUN |GALFACT;factor;UPLNniF;40|
        ((|f| (UP)) (|ld| (|List| (|NonNegativeInteger|)))
         (|r| (|NonNegativeInteger|)) ($ (|Factored| UP)))
        (COND
         ((|GALFACT;errorsum?| (SPADCALL |f| (QREFELT $ 39)) |ld| $)
          (|error| "factor: Bad arguments"))
         ('T
          (SPADCALL
           (SPADCALL |f| NIL (|GALFACT;makeSet| |ld| $) |r| (QREFELT $ 168))
           (QREFELT $ 143))))) 

(SDEFUN |GALFACT;factor;UPNniF;41|
        ((|f| (UP)) (|r| (|NonNegativeInteger|)) ($ (|Factored| UP)))
        (SPADCALL
         (SPADCALL |f| NIL (|GALFACT;fullSet| (SPADCALL |f| (QREFELT $ 39)) $)
                   |r| (QREFELT $ 168))
         (QREFELT $ 143))) 

(SDEFUN |GALFACT;factor;UPLF;42|
        ((|f| (UP)) (|ld| (|List| (|NonNegativeInteger|))) ($ (|Factored| UP)))
        (SPADCALL |f| |ld| 2 (QREFELT $ 170))) 

(SDEFUN |GALFACT;factor;UP2NniF;43|
        ((|f| (UP)) (|d| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|))
         ($ (|Factored| UP)))
        (SPROG ((|n| (|Union| (|NonNegativeInteger|) "failed")))
               (SEQ
                (LETT |n|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 39)) |d|
                                (QREFELT $ 126)))
                (EXIT
                 (COND ((QEQCAR |n| 1) (|error| "factor: Bad arguments"))
                       ('T
                        (SPADCALL |f| (SPADCALL (QCDR |n|) |d| (QREFELT $ 173))
                                  |r| (QREFELT $ 170)))))))) 

(SDEFUN |GALFACT;factorSquareFree;UPF;44| ((|f| (UP)) ($ (|Factored| UP)))
        (SPADCALL
         (COND
          ((QREFELT $ 9)
           (SPADCALL |f| 'T (|GALFACT;fullSet| (SPADCALL |f| (QREFELT $ 39)) $)
                     2 (QREFELT $ 168)))
          ('T (SPADCALL |f| 'T (QREFELT $ 167))))
         (QREFELT $ 143))) 

(SDEFUN |GALFACT;factorSquareFree;UPLNniF;45|
        ((|f| (UP)) (|ld| (|List| (|NonNegativeInteger|)))
         (|r| (|NonNegativeInteger|)) ($ (|Factored| UP)))
        (COND
         ((|GALFACT;errorsum?| (SPADCALL |f| (QREFELT $ 39)) |ld| $)
          (|error| "factorSquareFree: Bad arguments"))
         ('T
          (SPADCALL
           (SPADCALL |f| 'T (|GALFACT;makeSet| |ld| $) |r| (QREFELT $ 168))
           (QREFELT $ 143))))) 

(SDEFUN |GALFACT;factorSquareFree;UPNniF;46|
        ((|f| (UP)) (|r| (|NonNegativeInteger|)) ($ (|Factored| UP)))
        (SPADCALL
         (SPADCALL |f| 'T (|GALFACT;fullSet| (SPADCALL |f| (QREFELT $ 39)) $)
                   |r| (QREFELT $ 168))
         (QREFELT $ 143))) 

(SDEFUN |GALFACT;factorSquareFree;UPLF;47|
        ((|f| (UP)) (|ld| (|List| (|NonNegativeInteger|))) ($ (|Factored| UP)))
        (SPADCALL |f| |ld| 2 (QREFELT $ 176))) 

(SDEFUN |GALFACT;factorSquareFree;UP2NniF;48|
        ((|f| (UP)) (|d| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|))
         ($ (|Factored| UP)))
        (SPROG ((|n| (|Union| (|NonNegativeInteger|) "failed")))
               (SEQ
                (LETT |n|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 39)) |d|
                                (QREFELT $ 126)))
                (EXIT
                 (COND
                  ((QEQCAR |n| 1) (|error| "factorSquareFree: Bad arguments"))
                  ('T
                   (SPADCALL |f| (SPADCALL (QCDR |n|) |d| (QREFELT $ 173)) |r|
                             (QREFELT $ 176)))))))) 

(SDEFUN |GALFACT;factorOfDegree;PiUPLNniBU;49|
        ((|d| (|PositiveInteger|)) (|p| (UP))
         (|ld| (|List| (|NonNegativeInteger|))) (|r| (|NonNegativeInteger|))
         (|sqf| (|Boolean|)) ($ (|Union| UP "failed")))
        (SPROG
         ((#1=#:G1230 NIL) (#2=#:G1231 NIL) (#3=#:G1232 NIL) (|f| NIL)
          (|lf|
           (|List|
            (|Record| (|:| |irr| UP) (|:| |pow| (|NonNegativeInteger|)))))
          (|dp| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |dp| (SPADCALL |p| (QREFELT $ 39)))
                (EXIT
                 (COND
                  ((|GALFACT;errorsum?| |dp| |ld| $)
                   (|error| "factorOfDegree: Bad arguments"))
                  ('T
                   (SEQ
                    (COND
                     ((EQL |d| 1)
                      (COND
                       ((SPADCALL |p| (QREFELT $ 131))
                        (EXIT (CONS 1 "failed"))))))
                    (LETT |lf|
                          (QCDR
                           (SPADCALL |p| |sqf| (|GALFACT;makeSet| |ld| $) |r|
                                     (QREFELT $ 168))))
                    (SEQ
                     (EXIT
                      (SEQ (LETT |f| NIL) (LETT #3# |lf|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((EQL (SPADCALL (QCAR |f|) (QREFELT $ 39)) |d|)
                               (PROGN
                                (LETT #1#
                                      (PROGN
                                       (LETT #2# (CONS 0 (QCAR |f|)))
                                       (GO #4=#:G1229)))
                                (GO #5=#:G1223))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                     #5# (EXIT #1#))
                    (EXIT (CONS 1 "failed"))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |GALFACT;factorOfDegree;PiUPLNniU;50|
        ((|d| (|PositiveInteger|)) (|p| (UP))
         (|ld| (|List| (|NonNegativeInteger|))) (|r| (|NonNegativeInteger|))
         ($ (|Union| UP "failed")))
        (SPADCALL |d| |p| |ld| |r| NIL (QREFELT $ 181))) 

(SDEFUN |GALFACT;factorOfDegree;PiUPNniU;51|
        ((|d| (|PositiveInteger|)) (|p| (UP)) (|r| (|NonNegativeInteger|))
         ($ (|Union| UP "failed")))
        (SPADCALL |d| |p|
                  (SPADCALL (SPADCALL |p| (QREFELT $ 39)) 1 (QREFELT $ 173))
                  |r| NIL (QREFELT $ 181))) 

(SDEFUN |GALFACT;factorOfDegree;PiUPLU;52|
        ((|d| (|PositiveInteger|)) (|p| (UP))
         (|ld| (|List| (|NonNegativeInteger|))) ($ (|Union| UP "failed")))
        (SPADCALL |d| |p| |ld| 2 NIL (QREFELT $ 181))) 

(SDEFUN |GALFACT;factorOfDegree;PiUPU;53|
        ((|d| (|PositiveInteger|)) (|p| (UP)) ($ (|Union| UP "failed")))
        (SPADCALL |d| |p|
                  (SPADCALL (SPADCALL |p| (QREFELT $ 39)) 1 (QREFELT $ 173)) 2
                  NIL (QREFELT $ 181))) 

(DECLAIM (NOTINLINE |GaloisGroupFactorizer;|)) 

(DEFUN |GaloisGroupFactorizer| (#1=#:G1249)
  (SPROG NIL
         (PROG (#2=#:G1250)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GaloisGroupFactorizer|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|GaloisGroupFactorizer;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GaloisGroupFactorizer|)))))))))) 

(DEFUN |GaloisGroupFactorizer;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GaloisGroupFactorizer| DV$1))
          (LETT $ (GETREFV 186))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GaloisGroupFactorizer| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 5)
          (QSETREFV $ 8 8)
          (QSETREFV $ 9 'T)
          (QSETREFV $ 10 'T)
          (QSETREFV $ 11 'T)
          $))) 

(MAKEPROP '|GaloisGroupFactorizer| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|mussertrials|
              '|stopmussertrials| '|usesinglefactorbound|
              '|tryfunctionaldecomposition| '|useeisensteincriterion|
              (|Boolean|) |GALFACT;useEisensteinCriterion?;B;1|
              |GALFACT;useEisensteinCriterion;2B;2|
              |GALFACT;tryFunctionalDecomposition?;B;3|
              |GALFACT;tryFunctionalDecomposition;2B;4|
              |GALFACT;useSingleFactorBound?;B;5|
              |GALFACT;useSingleFactorBound;2B;6| (|PositiveInteger|)
              |GALFACT;stopMusserTrials;Pi;7| |GALFACT;stopMusserTrials;2Pi;8|
              |GALFACT;musserTrials;Pi;9| |GALFACT;musserTrials;2Pi;10|
              (0 . |reductum|) (|Integer|) (5 . |content|) (10 . |unit?|)
              (15 . |leadingCoefficient|) (20 . |zero?|) (|Factored| $)
              (25 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 32) (|:| |factor| 25) (|:| |exponent| 38))
              (|List| 33) (|Factored| 25) (30 . |factorList|)
              |GALFACT;eisensteinIrreducible?;UPB;11| (|NonNegativeInteger|)
              (35 . |degree|) (|Record| (|:| |factor| 6) (|:| |degree| 25))
              (|List| 40) |GALFACT;numberOfFactors;LNni;12| (40 . +)
              (|Mapping| 38 38) (|Set| 38) (46 . |map|) (52 . |One|)
              (|List| 38) (56 . |set|) (|SparseUnivariatePolynomial| 25)
              (61 . |makeSUP|) (|U32Vector|) (|U32VectorPolynomialOperations|)
              (66 . |to_mod_pa|) (72 . |gcd|) (79 . |degree|)
              (|ModularDistinctDegreeFactorizer| 6) (84 . |gcd|) (91 . |Zero|)
              (95 . |pa_to_sup|) (100 . |unmakeSUP|) (105 . |coerce|)
              (110 . ~=) (116 . |invmod|) (|Void|) (122 . |mul_by_scalar|)
              (|Mapping| (|List| 52))
              (|Record| (|:| |poly| 52) (|:| |degree| 38)
                        (|:| |separate_factors| 67))
              (|List| 68) (|ModularFactorization|) (130 . |ddfact|)
              (136 . |ddFact|) (|List| 6) (142 . |separateFactors|)
              (148 . |empty|) (152 . |differentiate|)
              (|IntegerPrimesPackage| 25) (157 . |nextPrime|) (162 . |union|)
              (168 . |intersect|) (174 . =) (180 . |#|)
              (|Record| (|:| |prime| 25) (|:| |factors| 73))
              |GALFACT;modularFactor;UPSR;22| (|Multiset| 38) (185 . |empty|)
              (189 . |insert!|) (195 . |insert!|)
              |GALFACT;degreePartition;LM;23| (202 . <=) (208 . |rem|)
              (214 . |Zero|) (218 . =) (|Mapping| 12 38) (224 . |select|)
              (|BrillhartTests| 6) (230 . |brillhartIrreducible?|)
              (|Record| (|:| |left| 6) (|:| |right| 6)) (|Union| 98 '"failed")
              (|UnivariatePolynomialDecompositionPackage| 25 6)
              (235 . |monicDecomposeIfCan|)
              (|GaloisGroupFactorizationUtilities| 25 6 (|Float|))
              (240 . |beauzamyBound|) (|GeneralHenselPackage| 25 6)
              (245 . |completeHensel|) (253 . |elt|) (259 . |append|)
              (265 . |coefficient|) (271 . |bit?|) (277 . |elt|)
              (283 . |symmetricRemainder|) (289 . |member?|)
              (|Union| $ '"failed") (295 . |exquo|) (301 . *)
              (307 . |reduction|) (313 . |primitivePart|) (318 . |exquo|)
              (324 . |swap!|) (331 . |rest|) (337 . |setrest!|)
              (343 . |singleFactorBound|)
              (|Record| (|:| |plist| 73) (|:| |modulo| 25))
              (349 . |HenselLift|) (357 . |parts|) (362 . |exquo|)
              (368 . |max|) (|GaloisGroupPolynomialUtilities| 25 6)
              (373 . |reverse|) (378 . -) (383 . |noLinearFactor?|)
              (388 . |remove|) (394 . |ground?|) (399 . |subtractIfCan|)
              (405 . |setelt!|) (412 . |unit|)
              (|Record| (|:| |flag| 32) (|:| |factor| 6) (|:| |exponent| 38))
              (|List| 137) (|Factored| 6) (417 . |makeFR|)
              (|Record| (|:| |irr| 6) (|:| |pow| 38))
              (|Record| (|:| |contp| 25) (|:| |factors| 163))
              |GALFACT;makeFR;RF;30| (|Union| 25 '"failed") (|IntegerRoots| 25)
              (423 . |perfectSqrt|) (428 . |monomial|) (434 . +)
              (440 . |monomial|) (446 . |elt|) (452 . |exquo|)
              (458 . |minimumDegree|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (463 . |monicDivide|) (469 . =) (|List| 50)
              (|CyclotomicUtilities|) (475 . |cyclotomic_decomposition|)
              (|Mapping| 6 50) (|ListFunctions2| 50 6) (480 . |map|)
              (486 . |cocyclotomic_decomposition|) (|List| 141)
              (491 . |append|) (497 . |squareFree|) (502 . |factorList|)
              |GALFACT;henselFact;UPBR;35| |GALFACT;btwFact;UPBSNniR;36|
              |GALFACT;factor;UPF;37| |GALFACT;factor;UPLNniF;40|
              |GALFACT;factor;UPNniF;41| |GALFACT;factor;UPLF;42| (507 . |new|)
              |GALFACT;factor;UP2NniF;43| |GALFACT;factorSquareFree;UPF;44|
              |GALFACT;factorSquareFree;UPLNniF;45|
              |GALFACT;factorSquareFree;UPNniF;46|
              |GALFACT;factorSquareFree;UPLF;47|
              |GALFACT;factorSquareFree;UP2NniF;48| (|Union| 6 '"failed")
              |GALFACT;factorOfDegree;PiUPLNniBU;49|
              |GALFACT;factorOfDegree;PiUPLNniU;50|
              |GALFACT;factorOfDegree;PiUPNniU;51|
              |GALFACT;factorOfDegree;PiUPLU;52|
              |GALFACT;factorOfDegree;PiUPU;53|)
           '#(|useSingleFactorBound?| 513 |useSingleFactorBound| 517
              |useEisensteinCriterion?| 522 |useEisensteinCriterion| 526
              |tryFunctionalDecomposition?| 531 |tryFunctionalDecomposition|
              535 |stopMusserTrials| 540 |numberOfFactors| 549 |musserTrials|
              554 |modularFactor| 563 |makeFR| 569 |henselFact| 574
              |factorSquareFree| 580 |factorOfDegree| 611 |factor| 648
              |eisensteinIrreducible?| 679 |degreePartition| 684 |btwFact| 689)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|makeFR|
                                 ((|Factored| |#1|)
                                  (|Record| (|:| |contp| (|Integer|))
                                            (|:| |factors|
                                                 (|List|
                                                  (|Record| (|:| |irr| |#1|)
                                                            (|:| |pow|
                                                                 (|NonNegativeInteger|))))))))
                                T)
                              '((|degreePartition|
                                 ((|Multiset| (|NonNegativeInteger|))
                                  (|List|
                                   (|Record| (|:| |factor| |#1|)
                                             (|:| |degree| (|Integer|))))))
                                T)
                              '((|musserTrials| ((|PositiveInteger|))) T)
                              '((|musserTrials|
                                 ((|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|stopMusserTrials| ((|PositiveInteger|))) T)
                              '((|stopMusserTrials|
                                 ((|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|numberOfFactors|
                                 ((|NonNegativeInteger|)
                                  (|List|
                                   (|Record| (|:| |factor| |#1|)
                                             (|:| |degree| (|Integer|))))))
                                T)
                              '((|modularFactor|
                                 ((|Record| (|:| |prime| (|Integer|))
                                            (|:| |factors| (|List| |#1|)))
                                  |#1| (|Set| (|NonNegativeInteger|))))
                                T)
                              '((|useSingleFactorBound?| ((|Boolean|))) T)
                              '((|useSingleFactorBound|
                                 ((|Boolean|) (|Boolean|)))
                                T)
                              '((|useEisensteinCriterion?| ((|Boolean|))) T)
                              '((|useEisensteinCriterion|
                                 ((|Boolean|) (|Boolean|)))
                                T)
                              '((|eisensteinIrreducible?| ((|Boolean|) |#1|))
                                T)
                              '((|tryFunctionalDecomposition?| ((|Boolean|)))
                                T)
                              '((|tryFunctionalDecomposition|
                                 ((|Boolean|) (|Boolean|)))
                                T)
                              '((|factor| ((|Factored| |#1|) |#1|)) T)
                              '((|factor|
                                 ((|Factored| |#1|) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factor|
                                 ((|Factored| |#1|) |#1|
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|factor|
                                 ((|Factored| |#1|) |#1|
                                  (|List| (|NonNegativeInteger|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factor|
                                 ((|Factored| |#1|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factorSquareFree| ((|Factored| |#1|) |#1|))
                                T)
                              '((|factorSquareFree|
                                 ((|Factored| |#1|) |#1|
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factorSquareFree|
                                 ((|Factored| |#1|) |#1|
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|factorSquareFree|
                                 ((|Factored| |#1|) |#1|
                                  (|List| (|NonNegativeInteger|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factorSquareFree|
                                 ((|Factored| |#1|) |#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factorOfDegree|
                                 ((|Union| |#1| "failed") (|PositiveInteger|)
                                  |#1|))
                                T)
                              '((|factorOfDegree|
                                 ((|Union| |#1| "failed") (|PositiveInteger|)
                                  |#1| (|NonNegativeInteger|)))
                                T)
                              '((|factorOfDegree|
                                 ((|Union| |#1| "failed") (|PositiveInteger|)
                                  |#1| (|List| (|NonNegativeInteger|))))
                                T)
                              '((|factorOfDegree|
                                 ((|Union| |#1| "failed") (|PositiveInteger|)
                                  |#1| (|List| (|NonNegativeInteger|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|factorOfDegree|
                                 ((|Union| |#1| "failed") (|PositiveInteger|)
                                  |#1| (|List| (|NonNegativeInteger|))
                                  (|NonNegativeInteger|) (|Boolean|)))
                                T)
                              '((|henselFact|
                                 ((|Record| (|:| |contp| (|Integer|))
                                            (|:| |factors|
                                                 (|List|
                                                  (|Record| (|:| |irr| |#1|)
                                                            (|:| |pow|
                                                                 (|NonNegativeInteger|))))))
                                  |#1| (|Boolean|)))
                                T)
                              '((|btwFact|
                                 ((|Record| (|:| |contp| (|Integer|))
                                            (|:| |factors|
                                                 (|List|
                                                  (|Record| (|:| |irr| |#1|)
                                                            (|:| |pow|
                                                                 (|NonNegativeInteger|))))))
                                  |#1| (|Boolean|)
                                  (|Set| (|NonNegativeInteger|))
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 185
                                            '(1 6 0 0 24 1 6 25 0 26 1 25 12 0
                                              27 1 6 25 0 28 1 6 12 0 29 1 25
                                              30 0 31 1 35 34 0 36 1 6 38 0 39
                                              2 38 0 0 0 43 2 45 0 44 0 46 0 6
                                              0 47 1 45 0 48 49 1 6 50 0 51 2
                                              53 52 50 25 54 3 53 52 52 52 25
                                              55 1 53 25 52 56 3 57 6 6 6 25 58
                                              0 6 0 59 1 53 50 52 60 1 6 0 50
                                              61 1 6 0 25 62 2 25 12 0 0 63 2
                                              25 0 0 0 64 4 53 65 52 25 25 25
                                              66 2 70 69 52 25 71 2 57 41 6 25
                                              72 2 57 73 41 25 74 0 45 0 75 1 6
                                              0 0 76 1 77 25 25 78 2 45 0 0 0
                                              79 2 45 0 0 0 80 2 45 12 0 0 81 1
                                              48 38 0 82 0 85 0 86 2 85 0 38 0
                                              87 3 85 0 38 0 38 88 2 38 12 0 0
                                              90 2 38 0 0 0 91 0 38 0 92 2 38
                                              12 0 0 93 2 45 0 94 0 95 1 96 12
                                              6 97 1 100 99 6 101 1 102 25 6
                                              103 4 104 73 6 73 25 19 105 2 6 0
                                              0 0 106 2 73 0 0 0 107 2 6 25 0
                                              38 108 2 25 12 0 0 109 2 73 6 0
                                              25 110 2 25 0 0 0 111 2 45 12 38
                                              0 112 2 25 113 0 0 114 2 6 0 0 0
                                              115 2 104 6 6 25 116 1 6 0 0 117
                                              2 6 113 0 0 118 3 73 65 0 25 25
                                              119 2 73 0 0 38 120 2 73 0 0 0
                                              121 2 102 25 6 38 122 4 104 123 6
                                              73 25 19 124 1 45 48 0 125 2 38
                                              113 0 0 126 1 45 38 0 127 1 128 6
                                              6 129 1 6 0 0 130 1 96 12 6 131 2
                                              45 0 38 0 132 1 6 12 0 133 2 38
                                              113 0 0 134 3 73 6 0 25 6 135 1
                                              35 25 0 136 2 139 0 6 138 140 1
                                              145 144 25 146 2 6 0 25 38 147 2
                                              6 0 0 0 148 2 50 0 25 38 149 2 50
                                              0 0 0 150 2 6 113 0 25 151 1 6 38
                                              0 152 2 6 153 0 0 154 2 6 12 0 0
                                              155 1 157 156 25 158 2 160 73 159
                                              156 161 1 157 156 25 162 2 163 0
                                              0 0 164 1 6 30 0 165 1 139 138 0
                                              166 2 48 0 38 38 173 0 0 12 17 1
                                              0 12 12 18 0 0 12 13 1 0 12 12 14
                                              0 0 12 15 1 0 12 12 16 1 0 19 19
                                              21 0 0 19 20 1 0 38 41 42 1 0 19
                                              19 23 0 0 19 22 2 0 83 6 45 84 1
                                              0 139 142 143 2 0 142 6 12 167 2
                                              0 139 6 38 177 1 0 139 6 175 3 0
                                              139 6 48 38 176 2 0 139 6 48 178
                                              3 0 139 6 38 38 179 2 0 180 19 6
                                              185 3 0 180 19 6 48 184 3 0 180
                                              19 6 38 183 5 0 180 19 6 48 38 12
                                              181 4 0 180 19 6 48 38 182 1 0
                                              139 6 169 2 0 139 6 48 172 2 0
                                              139 6 38 171 3 0 139 6 38 38 174
                                              3 0 139 6 48 38 170 1 0 12 6 37 1
                                              0 85 41 89 4 0 142 6 12 45 38
                                              168)))))
           '|lookupComplete|)) 
