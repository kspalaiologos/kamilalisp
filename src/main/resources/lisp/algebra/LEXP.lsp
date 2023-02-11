
(SDEFUN |LEXP;ident|
        ((|l1|
          (|List| (|Record| (|:| |k| #1=(|LyndonWord| |VarSet|)) (|:| |c| R))))
         (|l2|
          (|List| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R))))
         ($ (|List| (|Equation| R))))
        (SPROG
         ((|r| (R)) (|c2| (R)) (|u2| #1#) (|c1| (R)) (|u1| #1#) (#2=#:G724 NIL)
          (|t| NIL) (#3=#:G723 NIL) (#4=#:G722 NIL) (#5=#:G721 NIL))
         (SEQ
          (COND
           ((NULL |l1|)
            (PROGN
             (LETT #5# NIL)
             (SEQ (LETT |t| NIL) (LETT #4# |l2|) G190
                  (COND
                   ((OR (ATOM #4#) (PROGN (LETT |t| (CAR #4#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #5#
                          (CONS
                           (SPADCALL (|spadConstant| $ 10) (QCDR |t|)
                                     (QREFELT $ 12))
                           #5#))))
                  (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT (NREVERSE #5#)))))
           ((NULL |l2|)
            (PROGN
             (LETT #3# NIL)
             (SEQ (LETT |t| NIL) (LETT #2# |l1|) G190
                  (COND
                   ((OR (ATOM #2#) (PROGN (LETT |t| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #3#
                          (CONS
                           (SPADCALL (QCDR |t|) (|spadConstant| $ 10)
                                     (QREFELT $ 12))
                           #3#))))
                  (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#)))))
           (#6='T
            (SEQ (LETT |u1| (QCAR (|SPADfirst| |l1|)))
                 (LETT |c1| (QCDR (|SPADfirst| |l1|)))
                 (LETT |u2| (QCAR (|SPADfirst| |l2|)))
                 (LETT |c2| (QCDR (|SPADfirst| |l2|)))
                 (EXIT
                  (COND
                   ((SPADCALL |u1| |u2| (QREFELT $ 15))
                    (SEQ (LETT |r| (SPADCALL |c1| |c2| (QREFELT $ 16)))
                         (EXIT
                          (COND
                           ((SPADCALL |r| (|spadConstant| $ 10) (QREFELT $ 17))
                            (|LEXP;ident| (CDR |l1|) (CDR |l2|) $))
                           (#6#
                            (CONS (SPADCALL |c1| |c2| (QREFELT $ 12))
                                  (|LEXP;ident| (CDR |l1|) (CDR |l2|) $)))))))
                   ((SPADCALL |u1| |u2| (QREFELT $ 18))
                    (CONS (SPADCALL (|spadConstant| $ 10) |c2| (QREFELT $ 12))
                          (|LEXP;ident| |l1| (CDR |l2|) $)))
                   (#6#
                    (CONS (SPADCALL |c1| (|spadConstant| $ 10) (QREFELT $ 12))
                          (|LEXP;ident| (CDR |l1|) |l2| $))))))))))) 

(SDEFUN |LEXP;compareTerm1s|
        ((|u| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R)))
         (|v| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R)))
         ($ (|Boolean|)))
        (SPADCALL (QCAR |v|) (QCAR |u|) (QREFELT $ 18))) 

(SDEFUN |LEXP;out|
        ((|t| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R)))
         ($ (|OutputForm|)))
        (COND
         ((SPADCALL (QCDR |t|) (|spadConstant| $ 19) (QREFELT $ 17))
          (SPADCALL (SPADCALL (|STR_to_CHAR| "e") (QREFELT $ 22))
                    (SPADCALL (QCAR |t|) (QREFELT $ 23)) (QREFELT $ 24)))
         ('T
          (SPADCALL (SPADCALL (|STR_to_CHAR| "e") (QREFELT $ 22))
                    (SPADCALL (SPADCALL (QCDR |t|) (QREFELT $ 25))
                              (SPADCALL (QCAR |t|) (QREFELT $ 23))
                              (QREFELT $ 26))
                    (QREFELT $ 24))))) 

(SDEFUN |LEXP;identification;2$L;4|
        ((|x| ($)) (|y| ($)) ($ (|List| (|Equation| R))))
        (SPROG
         ((|l2|
           #1=(|List|
               (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R))))
          (|l1| #1#))
         (SEQ (LETT |l1| (SPADCALL |x| (QREFELT $ 29)))
              (LETT |l2| (SPADCALL |y| (QREFELT $ 29)))
              (EXIT (|LEXP;ident| |l1| |l2| $))))) 

(SDEFUN |LEXP;LyndonCoordinates;$L;5|
        ((|x| ($))
         ($ (|List| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R)))))
        (SPROG
         ((|lt|
           (|List| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R))))
          (#1=#:G739 NIL) (|l| (|Union| (|LyndonWord| |VarSet|) #2="failed"))
          (#3=#:G748 NIL) (|t| NIL) (#4=#:G747 NIL))
         (SEQ
          (LETT |lt|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |t| NIL) (LETT #3# (SPADCALL |x| (QREFELT $ 34)))
                      G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |t| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((QEQCAR
                           (LETT |l| (SPADCALL (QCAR |t|) (QREFELT $ 37))) 0)
                          (LETT #4#
                                (CONS
                                 (CONS
                                  (PROG2 (LETT #1# |l|)
                                      (QCDR #1#)
                                    (|check_union2| (QEQCAR #1# 0)
                                                    (|LyndonWord|
                                                     (QREFELT $ 6))
                                                    (|Union|
                                                     (|LyndonWord|
                                                      (QREFELT $ 6))
                                                     #2#)
                                                    #1#))
                                  (QCDR |t|))
                                 #4#))))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (EXIT
           (LETT |lt|
                 (SPADCALL (CONS (|function| |LEXP;compareTerm1s|) $) |lt|
                           (QREFELT $ 39))))))) 

(SDEFUN |LEXP;*;3$;6| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((#1=#:G750 NIL))
               (SPADCALL |x| |y|
                         (PROG1 (LETT #1# (QREFELT $ 8))
                           (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #1#))
                         (QREFELT $ 41)))) 

(SDEFUN |LEXP;exp;Lp$;7| ((|p| (|LiePolynomial| |VarSet| R)) ($ ($)))
        (SPROG ((#1=#:G753 NIL))
               (SPADCALL (SPADCALL |p| (QREFELT $ 44))
                         (PROG1 (LETT #1# (QREFELT $ 8))
                           (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #1#))
                         (QREFELT $ 45)))) 

(SDEFUN |LEXP;log;$Lp;8| ((|p| ($)) ($ (|LiePolynomial| |VarSet| R)))
        (SPROG ((#1=#:G760 NIL) (#2=#:G758 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL
                          (SPADCALL |p|
                                    (PROG1 (LETT #2# (QREFELT $ 8))
                                      (|check_subtype2| (>= #2# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #2#))
                                    (QREFELT $ 47))
                          (QREFELT $ 49)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|LiePolynomial| (QREFELT $ 6) (QREFELT $ 7))
                                 (|Union|
                                  (|LiePolynomial| (QREFELT $ 6) (QREFELT $ 7))
                                  "failed")
                                 #1#)))) 

(SDEFUN |LEXP;coerce;$Of;9| ((|p| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G772 NIL) (|t| NIL) (#2=#:G771 NIL)
          (|lt|
           (|List| (|Record| (|:| |k| (|LyndonWord| |VarSet|)) (|:| |c| R)))))
         (SEQ
          (COND
           ((SPADCALL |p| (|spadConstant| $ 51) (QREFELT $ 52))
            (SPADCALL (|spadConstant| $ 19) (QREFELT $ 25)))
           ('T
            (SEQ (LETT |lt| (SPADCALL |p| (QREFELT $ 29)))
                 (EXIT
                  (SPADCALL (ELT $ 26)
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |t| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2# (CONS (|LEXP;out| |t| $) #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 55))))))))) 

(SDEFUN |LEXP;LyndonBasis;LL;10|
        ((|lv| (|List| |VarSet|)) ($ (|List| (|LiePolynomial| |VarSet| R))))
        (SPROG ((#1=#:G777 NIL) (|l| NIL) (#2=#:G776 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |l| NIL)
                      (LETT #1# (SPADCALL |lv| (QREFELT $ 8) (QREFELT $ 60)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |l| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |l| (QREFELT $ 61)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(PUT '|LEXP;coerce;$Xpbwp;11| '|SPADreplace| '(XLAM (|p|) |p|)) 

(SDEFUN |LEXP;coerce;$Xpbwp;11| ((|p| ($)) ($ (|XPBWPolynomial| |VarSet| R)))
        |p|) 

(SDEFUN |LEXP;inv;2$;12| ((|x| ($)) ($ ($)))
        (SPROG
         ((|lt|
           (|List|
            (|Record| (|:| |k| (|PoincareBirkhoffWittLyndonBasis| |VarSet|))
                      (|:| |c| R))))
          (#1=#:G786 NIL) (|t| NIL) (#2=#:G785 NIL))
         (SEQ
          (COND
           ((SPADCALL |x| (|spadConstant| $ 51) (QREFELT $ 52))
            (|spadConstant| $ 51))
           ('T
            (SEQ
             (LETT |lt|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 65)) (QREFELT $ 34)))
             (LETT |lt|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2#
                                 (CONS
                                  (CONS (QCAR |t|)
                                        (COND
                                         ((ODDP
                                           (SPADCALL (QCAR |t|)
                                                     (QREFELT $ 66)))
                                          (SPADCALL (QCDR |t|) (QREFELT $ 67)))
                                         ('T (QCDR |t|))))
                                  #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#)))))
             (EXIT |lt|))))))) 

(DECLAIM (NOTINLINE |LieExponentials;|)) 

(DEFUN |LieExponentials| (&REST #1=#:G792)
  (SPROG NIL
         (PROG (#2=#:G793)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|LieExponentials|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LieExponentials;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LieExponentials|)))))))))) 

(DEFUN |LieExponentials;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 |#3|)
          (LETT |dv$| (LIST '|LieExponentials| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 75))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LieExponentials|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (|XPBWPolynomial| |#1| |#2|))
          $))) 

(MAKEPROP '|LieExponentials| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|XPBWPolynomial| 6 7) (|local| |#1|)
              (|local| |#2|) (|local| |#3|) '|Rep| (0 . |Zero|) (|Equation| 7)
              (4 . |equation|) (|Boolean|) (|LyndonWord| 6) (10 . =) (16 . -)
              (22 . =) (28 . |lexico|) (34 . |One|) (|OutputForm|)
              (|Character|) (38 . |coerce|) (43 . |coerce|) (48 . ^)
              (54 . |coerce|) (59 . *) (|Record| (|:| |k| 14) (|:| |c| 7))
              (|List| 27) |LEXP;LyndonCoordinates;$L;5| (|List| 11)
              |LEXP;identification;2$L;4| (|Record| (|:| |k| 36) (|:| |c| 7))
              (|List| 32) (65 . |listOfTerms|) (|Union| 14 '"failed")
              (|PoincareBirkhoffWittLyndonBasis| 6) (70 . |retractIfCan|)
              (|Mapping| 13 27 27) (75 . |sort|) (|NonNegativeInteger|)
              (81 . |product|) |LEXP;*;3$;6| (|LiePolynomial| 6 7)
              (88 . |coerce|) (93 . |exp|) |LEXP;exp;Lp$;7| (99 . |log|)
              (|Union| 43 '"failed") (105 . |LiePolyIfCan|) |LEXP;log;$Lp;8|
              (110 . |One|) (114 . =) (|Mapping| 20 20 20) (|List| 20)
              (120 . |reduce|) |LEXP;coerce;$Of;9| (|List| $) (|List| 6)
              (|PositiveInteger|) (126 . |LyndonWordsList|) (132 . |LiePoly|)
              (|List| 43) |LEXP;LyndonBasis;LL;10| |LEXP;coerce;$Xpbwp;11|
              (137 . |mirror|) (142 . |length|) (147 . -) |LEXP;inv;2$;12|
              (|XDistributedPolynomial| 6 7) (|Integer|) (|Union| $ '"failed")
              (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 152 |varList| 158 |sample| 163 |rightRecip| 167 |rightPower|
              172 |recip| 184 |one?| 189 |mirror| 194 |log| 199 |listOfTerms|
              204 |leftRecip| 209 |leftPower| 214 |latex| 226 |inv| 231
              |identification| 236 |hashUpdate!| 242 |hash| 248 |exp| 253
              |conjugate| 258 |commutator| 264 |coerce| 270 ^ 285 |One| 303
              |LyndonCoordinates| 307 |LyndonBasis| 312 = 317 / 323 * 329)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Group&| NIL NIL |MagmaWithUnit&| |Magma&| |SetCategory&|
                     NIL NIL |BasicType&| NIL)
                  (CONS
                   '#((|Group|) (|Monoid|) (|SemiGroup|) (|MagmaWithUnit|)
                      (|Magma|) (|SetCategory|) (|unitsKnown|)
                      (|TwoSidedRecip|) (|BasicType|) (|CoercibleTo| 20))
                   (|makeByteWordVec2| 74
                                       '(0 7 0 10 2 11 0 7 7 12 2 14 13 0 0 15
                                         2 7 0 0 0 16 2 7 13 0 0 17 2 14 13 0 0
                                         18 0 7 0 19 1 21 20 0 22 1 14 20 0 23
                                         2 20 0 0 0 24 1 7 20 0 25 2 20 0 0 0
                                         26 1 0 33 0 34 1 36 35 0 37 2 28 0 38
                                         0 39 3 9 0 0 0 40 41 1 9 0 43 44 2 9 0
                                         0 40 45 2 9 0 0 40 47 1 9 48 0 49 0 0
                                         0 51 2 0 13 0 0 52 2 54 20 53 0 55 2
                                         14 57 58 59 60 1 43 0 14 61 1 0 0 0 65
                                         1 36 40 0 66 1 7 0 0 67 2 0 13 0 0 1 1
                                         0 58 0 1 0 0 0 1 1 0 71 0 1 2 0 0 0 40
                                         1 2 0 0 0 59 1 1 0 71 0 1 1 0 13 0 1 1
                                         0 0 0 65 1 0 43 0 50 1 0 33 0 34 1 0
                                         71 0 1 2 0 0 0 40 1 2 0 0 0 59 1 1 0
                                         72 0 1 1 0 0 0 68 2 0 30 0 0 31 2 0 74
                                         74 0 1 1 0 73 0 1 1 0 0 43 46 2 0 0 0
                                         0 1 2 0 0 0 0 1 1 0 5 0 64 1 0 69 0 1
                                         1 0 20 0 56 2 0 0 0 70 1 2 0 0 0 40 1
                                         2 0 0 0 59 1 0 0 0 51 1 0 28 0 29 1 0
                                         62 58 63 2 0 13 0 0 52 2 0 0 0 0 1 2 0
                                         0 0 0 42)))))
           '|lookupComplete|)) 
