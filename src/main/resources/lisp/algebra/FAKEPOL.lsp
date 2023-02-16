
(SDEFUN |FAKEPOL;frac_out|
        ((|fr|
          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                    (|:| |denom| (|Polynomial| (|Integer|)))))
         ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (QCAR |fr|) (QREFELT $ 9))
                  (SPADCALL (QCDR |fr|) (QREFELT $ 9)) (QREFELT $ 10))) 

(SDEFUN |FAKEPOL;mon_out|
        ((|mon|
          (|Record| (|:| |deg| #1=(|NonNegativeInteger|))
                    (|:| |coef|
                         (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                   (|:| |denom| (|Polynomial| (|Integer|)))))))
         (|v| (|Symbol|)) ($ (|OutputForm|)))
        (SPROG ((|pw| (|OutputForm|)) (|vo| (|OutputForm|)) (|d| #1#))
               (SEQ (LETT |d| (QCAR |mon|))
                    (EXIT
                     (COND ((EQL |d| 0) (|FAKEPOL;frac_out| (QCDR |mon|) $))
                           (#2='T
                            (SEQ (LETT |vo| (SPADCALL |v| (QREFELT $ 12)))
                                 (LETT |pw|
                                       (COND ((EQL |d| 1) |vo|)
                                             (#2#
                                              (SPADCALL |vo|
                                                        (SPADCALL |d|
                                                                  (QREFELT $
                                                                           14))
                                                        (QREFELT $ 15)))))
                                 (EXIT
                                  (SPADCALL (|FAKEPOL;frac_out| (QCDR |mon|) $)
                                            |pw| (QREFELT $ 16)))))))))) 

(SDEFUN |FAKEPOL;coerce;$Of;3| ((|p| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|ol| (|List| (|OutputForm|))) (#1=#:G736 NIL) (|mon| NIL)
          (#2=#:G735 NIL)
          (|cl|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|))
                      (|:| |coef|
                           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                     (|:| |denom|
                                          (|Polynomial| (|Integer|))))))))
          (|pr1| (|Rep|)))
         (SEQ (LETT |pr1| |p|) (LETT |cl| (QCDR |pr1|))
              (EXIT
               (COND ((NULL |cl|) (SPADCALL 0 (QREFELT $ 18)))
                     ('T
                      (SEQ
                       (LETT |ol|
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |mon| NIL) (LETT #1# (QCDR |pr1|))
                                   G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |mon| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (|FAKEPOL;mon_out| |mon|
                                             (QCAR |pr1|) $)
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                       (EXIT (SPADCALL (ELT $ 19) |ol| (QREFELT $ 22)))))))))) 

(SDEFUN |FAKEPOL;ground;$R;4|
        ((|p| ($))
         ($
          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                    (|:| |denom| (|Polynomial| (|Integer|))))))
        (SPROG
         ((|r1|
           (|Record| (|:| |deg| (|NonNegativeInteger|))
                     (|:| |coef|
                          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                    (|:| |denom|
                                         (|Polynomial| (|Integer|)))))))
          (|pr|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|))
                      (|:| |coef|
                           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                     (|:| |denom|
                                          (|Polynomial| (|Integer|))))))))
          (|pr1| (|Rep|)))
         (SEQ (LETT |pr1| |p|) (LETT |pr| (QCDR |pr1|))
              (EXIT
               (COND
                ((NULL |pr|)
                 (CONS (|spadConstant| $ 24) (|spadConstant| $ 25)))
                ('T
                 (SEQ (LETT |r1| (|SPADfirst| |pr|))
                      (COND
                       ((NULL (EQL (QCAR |r1|) 0))
                        (EXIT (|error| "ground: not(r1.deg = 0)"))))
                      (EXIT (QCDR |r1|))))))))) 

(SDEFUN |FAKEPOL;map;M$U;5|
        ((|f|
          (|Mapping| (|Polynomial| (|Integer|)) (|Polynomial| (|Integer|))))
         (|p| ($)) ($ (|Union| $ "failed")))
        (SPROG
         ((|res1|
           #1=(|List|
               #2=(|Record| (|:| |deg| (|NonNegativeInteger|))
                            (|:| |coef|
                                 #3=(|Record|
                                     (|:| |numer| (|Polynomial| (|Integer|)))
                                     (|:| |denom|
                                          (|Polynomial| (|Integer|))))))))
          (#4=#:G761 NIL) (|d1| #5=(|Polynomial| (|Integer|))) (|n1| #5#)
          (|c1| #3#) (|pr| (|List| #2#))
          (|r1|
           (|Record| (|:| |deg| (|NonNegativeInteger|))
                     (|:| |coef|
                          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                    (|:| |denom|
                                         (|Polynomial| (|Integer|)))))))
          (|res0| #1#) (|pr1| (|Rep|)))
         (SEQ
          (EXIT
           (SEQ (LETT |pr1| |p|) (LETT |pr| (QCDR |pr1|))
                (LETT |res0|
                      (LIST
                       (CONS 0
                             (CONS (|spadConstant| $ 24)
                                   (|spadConstant| $ 24)))))
                (LETT |res1| |res0|)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL |pr|)
                          (PROGN
                           (LETT #4# (CONS 0 (CONS (QCAR |pr1|) (CDR |res0|))))
                           (GO #6=#:G760)))
                         ('T
                          (SEQ (LETT |r1| (|SPADfirst| |pr|))
                               (LETT |pr| (CDR |pr|)) (LETT |c1| (QCDR |r1|))
                               (LETT |n1| (SPADCALL (QCAR |c1|) |f|))
                               (LETT |d1| (SPADCALL (QCDR |c1|) |f|))
                               (EXIT
                                (COND
                                 ((SPADCALL |d1| (|spadConstant| $ 24)
                                            (QREFELT $ 29))
                                  (PROGN
                                   (LETT #4# (CONS 1 "failed"))
                                   (GO #6#)))
                                 ((SPADCALL |n1| (|spadConstant| $ 24)
                                            (QREFELT $ 29))
                                  "iterate")
                                 ('T
                                  (LETT |res1|
                                        (|qset_rest| |res1|
                                                     (LIST
                                                      (CONS (QCAR |r1|)
                                                            (CONS |n1|
                                                                  |d1|)))))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #6# (EXIT #4#)))) 

(SDEFUN |FAKEPOL;map;MR$;6|
        ((|f|
          (|Mapping| (|Polynomial| (|Integer|)) (|Polynomial| (|Integer|))))
         (|p|
          (|Record| (|:| |var| (|Symbol|))
                    (|:| |coef|
                         (|SparseUnivariatePolynomial|
                          (|Fraction| (|Polynomial| (|Integer|)))))))
         ($ ($)))
        (SPROG
         ((|res1|
           #1=(|List|
               (|Record| (|:| |deg| (|NonNegativeInteger|))
                         (|:| |coef|
                              (|Record|
                               (|:| |numer| (|Polynomial| (|Integer|)))
                               (|:| |denom| (|Polynomial| (|Integer|))))))))
          (|d1| #2=(|Polynomial| (|Integer|))) (|n1| #2#)
          (|pr|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (|c1| (|Fraction| (|Polynomial| (|Integer|))))
          (|d| (|NonNegativeInteger|)) (#3=#:G777 NIL) (|res0| #1#))
         (SEQ
          (EXIT
           (SEQ (LETT |pr| (QCDR |p|))
                (LETT |res0|
                      (LIST
                       (CONS 0
                             (CONS (|spadConstant| $ 24)
                                   (|spadConstant| $ 24)))))
                (LETT |res1| |res0|)
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |pr| (|spadConstant| $ 34) (QREFELT $ 35))
                          (PROGN
                           (LETT #3# (CONS (QCAR |p|) (CDR |res0|)))
                           (GO #4=#:G776)))
                         ('T
                          (SEQ (LETT |d| (SPADCALL |pr| (QREFELT $ 36)))
                               (LETT |c1| (SPADCALL |pr| (QREFELT $ 38)))
                               (LETT |pr| (SPADCALL |pr| (QREFELT $ 39)))
                               (LETT |n1|
                                     (SPADCALL (SPADCALL |c1| (QREFELT $ 40))
                                               |f|))
                               (LETT |d1|
                                     (SPADCALL (SPADCALL |c1| (QREFELT $ 41))
                                               |f|))
                               (EXIT
                                (COND
                                 ((SPADCALL |d1| (|spadConstant| $ 24)
                                            (QREFELT $ 29))
                                  (|error| "FAKEPOL map PT: division by 0"))
                                 ((SPADCALL |n1| (|spadConstant| $ 24)
                                            (QREFELT $ 29))
                                  "iterate")
                                 ('T
                                  (LETT |res1|
                                        (|qset_rest| |res1|
                                                     (LIST
                                                      (CONS |d|
                                                            (CONS |n1|
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |c1|
                                                                    (QREFELT $
                                                                             41))
                                                                   |f|))))))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #4# (EXIT #3#)))) 

(SDEFUN |FAKEPOL;map;M$U;7|
        ((|f|
          (|Mapping| (|Union| (|Polynomial| (|Integer|)) "failed")
                     (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                               (|:| |denom| (|Polynomial| (|Integer|))))))
         (|p| ($))
         ($
          (|Union| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))
                   "failed")))
        (SPROG
         ((|res0| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (#1=#:G799 NIL) (|c1u| (|Union| (|Polynomial| (|Integer|)) "failed"))
          (|pr|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|))
                      (|:| |coef|
                           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                     (|:| |denom|
                                          (|Polynomial| (|Integer|))))))))
          (|r1|
           (|Record| (|:| |deg| (|NonNegativeInteger|))
                     (|:| |coef|
                          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                    (|:| |denom|
                                         (|Polynomial| (|Integer|)))))))
          (|pr1| (|Rep|)))
         (SEQ
          (EXIT
           (SEQ (LETT |pr1| |p|) (LETT |pr| (QCDR |pr1|))
                (LETT |res0| (|spadConstant| $ 45))
                (SEQ G190 (COND ((NULL (NULL (NULL |pr|))) (GO G191)))
                     (SEQ (LETT |r1| (|SPADfirst| |pr|)) (LETT |pr| (CDR |pr|))
                          (LETT |c1u| (SPADCALL (QCDR |r1|) |f|))
                          (EXIT
                           (COND
                            ((QEQCAR |c1u| 1)
                             (PROGN
                              (LETT #1# (CONS 1 "failed"))
                              (GO #2=#:G798)))
                            ('T
                             (LETT |res0|
                                   (SPADCALL |res0|
                                             (SPADCALL (QCDR |c1u|) (QCAR |r1|)
                                                       (QREFELT $ 46))
                                             (QREFELT $ 47)))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |res0|))))
          #2# (EXIT #1#)))) 

(SDEFUN |FAKEPOL;degree;$SNni;8|
        ((|p| ($)) (|s| (|Symbol|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|NonNegativeInteger|))
          (|c1|
           #1=(|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                        (|:| |denom| (|Polynomial| (|Integer|)))))
          (#2=#:G810 NIL) (|r1| NIL)
          (|pr|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |coef| #1#))))
          (|pr1| (|Rep|)))
         (SEQ (LETT |pr1| |p|) (LETT |pr| (QCDR |pr1|))
              (EXIT
               (COND ((NULL |pr|) 0)
                     ((EQUAL (QCAR |pr1|) |s|) (QCAR (|SPADfirst| |pr|)))
                     ('T
                      (SEQ (LETT |res| 0)
                           (SEQ (LETT |r1| NIL) (LETT #2# |pr|) G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |r1| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |c1| (QCDR |r1|))
                                     (EXIT
                                      (COND
                                       ((>
                                         (SPADCALL (QCDR |c1|) |s|
                                                   (QREFELT $ 52))
                                         0)
                                        (|error|
                                         "degree: not a polynomial in given variable"))
                                       ('T
                                        (LETT |res|
                                              (MAX |res|
                                                   (SPADCALL (QCAR |c1|) |s|
                                                             (QREFELT $
                                                                      52))))))))
                                (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |res|)))))))) 

(SDEFUN |FAKEPOL;to_UP;$Sup;9|
        ((|p| ($))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|Polynomial| (|Integer|))))))
        (SPROG
         ((|res0|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (|cr| (|Fraction| (|Polynomial| (|Integer|))))
          (|n1| #1=(|Polynomial| (|Integer|)))
          (|c1|
           #2=(|Record| (|:| |numer| #1#)
                        (|:| |denom| (|Polynomial| (|Integer|)))))
          (|pr|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |coef| #2#))))
          (|r1|
           (|Record| (|:| |deg| (|NonNegativeInteger|))
                     (|:| |coef|
                          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                                    (|:| |denom|
                                         (|Polynomial| (|Integer|)))))))
          (|pr1| (|Rep|)))
         (SEQ (LETT |pr1| |p|) (LETT |pr| (QCDR |pr1|))
              (LETT |res0| (|spadConstant| $ 34))
              (SEQ G190 (COND ((NULL (NULL (NULL |pr|))) (GO G191)))
                   (SEQ (LETT |r1| (|SPADfirst| |pr|)) (LETT |pr| (CDR |pr|))
                        (LETT |c1| (QCDR |r1|)) (LETT |n1| (QCAR |c1|))
                        (EXIT
                         (COND
                          ((SPADCALL |n1| (|spadConstant| $ 24) (QREFELT $ 29))
                           "iterate")
                          ('T
                           (SEQ
                            (LETT |cr|
                                  (SPADCALL |n1| (QCDR |c1|) (QREFELT $ 54)))
                            (EXIT
                             (LETT |res0|
                                   (SPADCALL |res0|
                                             (SPADCALL |cr| (QCAR |r1|)
                                                       (QREFELT $ 55))
                                             (QREFELT $ 56)))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res0|)))) 

(SDEFUN |FAKEPOL;subst_var;$2L$;10|
        ((|p| ($)) (|ls1| (|List| (|Symbol|))) (|ls2| (|List| (|Symbol|)))
         ($ ($)))
        (SPROG
         ((#1=#:G825 NIL) (#2=#:G826 NIL) (|s1| NIL) (#3=#:G827 NIL) (|s2| NIL)
          (|v1| (|Symbol|)) (|pr1| (|Rep|)))
         (SEQ
          (EXIT
           (SEQ (LETT |pr1| |p|) (LETT |v1| (QCAR |pr1|))
                (SEQ (LETT |s2| NIL) (LETT #3# |ls2|) (LETT |s1| NIL)
                     (LETT #2# |ls1|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |s1| (CAR #2#)) NIL)
                           (ATOM #3#) (PROGN (LETT |s2| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQUAL |v1| |s1|)
                         (PROGN
                          (LETT #1# (CONS |s2| (QCDR |pr1|)))
                          (GO #4=#:G824))))))
                     (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |p|)))
          #4# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |FakePolynomial;|)) 

(DEFUN |FakePolynomial| ()
  (SPROG NIL
         (PROG (#1=#:G829)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FakePolynomial|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FakePolynomial|
                             (LIST (CONS NIL (CONS 1 (|FakePolynomial;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|FakePolynomial|)))))))))) 

(DEFUN |FakePolynomial;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FakePolynomial|))
          (LETT $ (GETREFV 60))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FakePolynomial| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |var| (|Symbol|))
                              (|:| |coef|
                                   (|List|
                                    (|Record|
                                     (|:| |deg| (|NonNegativeInteger|))
                                     (|:| |coef|
                                          (|Record|
                                           (|:| |numer|
                                                (|Polynomial| (|Integer|)))
                                           (|:| |denom|
                                                (|Polynomial|
                                                 (|Integer|))))))))))
          $))) 

(MAKEPROP '|FakePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|OutputForm|) (|Polynomial| 17)
              (0 . |coerce|) (5 . /) (|Symbol|) (11 . |coerce|)
              (|NonNegativeInteger|) (16 . |coerce|) (21 . ^) (27 . *)
              (|Integer|) (33 . |coerce|) (38 . +) (|Mapping| 7 7 7) (|List| 7)
              (44 . |reduce|) |FAKEPOL;coerce;$Of;3| (50 . |Zero|) (54 . |One|)
              (|Record| (|:| |numer| 8) (|:| |denom| 8)) |FAKEPOL;ground;$R;4|
              (|Boolean|) (58 . =) (|Union| $ '"failed") (|Mapping| 8 8)
              |FAKEPOL;map;M$U;5| (|SparseUnivariatePolynomial| 37)
              (64 . |Zero|) (68 . =) (74 . |degree|) (|Fraction| 8)
              (79 . |leadingCoefficient|) (84 . |reductum|) (89 . |numer|)
              (94 . |denom|) (|Record| (|:| |var| 11) (|:| |coef| 33))
              |FAKEPOL;map;MR$;6| (|SparseUnivariatePolynomial| 8)
              (99 . |Zero|) (103 . |monomial|) (109 . +) (|Union| 44 '"failed")
              (|Union| 8 '"failed") (|Mapping| 49 26) |FAKEPOL;map;M$U;7|
              (115 . |degree|) |FAKEPOL;degree;$SNni;8| (121 . /)
              (127 . |monomial|) (133 . +) |FAKEPOL;to_UP;$Sup;9| (|List| 11)
              |FAKEPOL;subst_var;$2L$;10|)
           '#(|to_UP| 139 |subst_var| 144 |map| 151 |ground| 169 |degree| 174
              |coerce| 180)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 7))
                             (|makeByteWordVec2| 59
                                                 '(1 8 7 0 9 2 7 0 0 0 10 1 11
                                                   7 0 12 1 13 7 0 14 2 7 0 0 0
                                                   15 2 7 0 0 0 16 1 17 7 0 18
                                                   2 7 0 0 0 19 2 21 7 20 0 22
                                                   0 8 0 24 0 8 0 25 2 8 28 0 0
                                                   29 0 33 0 34 2 33 28 0 0 35
                                                   1 33 13 0 36 1 33 37 0 38 1
                                                   33 0 0 39 1 37 8 0 40 1 37 8
                                                   0 41 0 44 0 45 2 44 0 8 13
                                                   46 2 44 0 0 0 47 2 8 13 0 11
                                                   52 2 37 0 8 8 54 2 33 0 37
                                                   13 55 2 33 0 0 0 56 1 0 33 0
                                                   57 3 0 0 0 58 58 59 2 0 0 31
                                                   42 43 2 0 48 50 0 51 2 0 30
                                                   31 0 32 1 0 26 0 27 2 0 13 0
                                                   11 53 1 0 7 0 23)))))
           '|lookupComplete|)) 

(MAKEPROP '|FakePolynomial| 'NILADIC T) 
