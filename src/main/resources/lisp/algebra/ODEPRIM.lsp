
(SDEFUN |ODEPRIM;UP2UP2| ((|p| (UP)) ($ (|SparseUnivariatePolynomial| UP)))
        (SPADCALL (ELT $ 12) |p| (QREFELT $ 16))) 

(SDEFUN |ODEPRIM;indicialEquations;LL;2|
        ((|op| (L))
         ($ (|List| (|Record| (|:| |center| UP) (|:| |equation| UP)))))
        (SPADCALL |op| (SPADCALL |op| (QREFELT $ 17)) (QREFELT $ 20))) 

(SDEFUN |ODEPRIM;indicialEquation;LFUP;3| ((|op| (L)) (|a| (F)) ($ (UP)))
        (|ODEPRIM;indeq|
         (SPADCALL (SPADCALL (|spadConstant| $ 22) 1 (QREFELT $ 25))
                   (SPADCALL |a| (QREFELT $ 12)) (QREFELT $ 26))
         |op| $)) 

(SDEFUN |ODEPRIM;splitDenominator;LQLR;4|
        ((|op| (LQ)) (|lg| (|List| (|Fraction| UP)))
         ($ (|Record| (|:| |eq| L) (|:| |rh| (|List| (|Fraction| UP))))))
        (SPROG
         ((#1=#:G723 NIL) (|g| NIL) (#2=#:G722 NIL) (|l| (L))
          (|f| (|Fraction| UP))
          (|cd| (|Record| (|:| |num| (|List| UP)) (|:| |den| UP))))
         (SEQ
          (LETT |cd| (SPADCALL (SPADCALL |op| (QREFELT $ 29)) (QREFELT $ 32)))
          (LETT |f|
                (SPADCALL (QCDR |cd|) (SPADCALL (QCAR |cd|) (QREFELT $ 34))
                          (QREFELT $ 36)))
          (LETT |l| (|spadConstant| $ 37))
          (SEQ G190
               (COND
                ((NULL (SPADCALL |op| (|spadConstant| $ 40) (QREFELT $ 42)))
                 (GO G191)))
               (SEQ
                (LETT |l|
                      (SPADCALL |l|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL |f| (SPADCALL |op| (QREFELT $ 43))
                                            (QREFELT $ 44))
                                  (QREFELT $ 45))
                                 (SPADCALL |op| (QREFELT $ 46)) (QREFELT $ 47))
                                (QREFELT $ 48)))
                (EXIT (LETT |op| (SPADCALL |op| (QREFELT $ 49)))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT
           (CONS |l|
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |g| NIL) (LETT #1# |lg|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS (SPADCALL |f| |g| (QREFELT $ 44)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |ODEPRIM;tau|
        ((|p| (UP)) (|pp| (UP)) (|q| (UP)) (|n| (|NonNegativeInteger|))
         ($ (UP)))
        (SPROG ((#1=#:G725 NIL))
               (SPADCALL
                (SPADCALL (SPADCALL |pp| |n| (QREFELT $ 52))
                          (PROG2
                              (LETT #1#
                                    (SPADCALL |q|
                                              (SPADCALL |p|
                                                        (SPADCALL |q| |p|
                                                                  (QREFELT $
                                                                           53))
                                                        (QREFELT $ 52))
                                              (QREFELT $ 55)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                            (|Union| (QREFELT $ 7) "failed")
                                            #1#))
                          (QREFELT $ 56))
                |p| (QREFELT $ 57)))) 

(SDEFUN |ODEPRIM;indicialEquations;LQL;6|
        ((|op| (LQ))
         ($ (|List| (|Record| (|:| |center| UP) (|:| |equation| UP)))))
        (SPADCALL (QCAR (SPADCALL |op| NIL (QREFELT $ 51))) (QREFELT $ 21))) 

(SDEFUN |ODEPRIM;indicialEquations;LQUPL;7|
        ((|op| (LQ)) (|p| (UP))
         ($ (|List| (|Record| (|:| |center| UP) (|:| |equation| UP)))))
        (SPADCALL (QCAR (SPADCALL |op| NIL (QREFELT $ 51))) |p| (QREFELT $ 20))) 

(SDEFUN |ODEPRIM;indicialEquation;LQFUP;8| ((|op| (LQ)) (|a| (F)) ($ (UP)))
        (|ODEPRIM;indeq|
         (SPADCALL (SPADCALL (|spadConstant| $ 22) 1 (QREFELT $ 25))
                   (SPADCALL |a| (QREFELT $ 12)) (QREFELT $ 26))
         (QCAR (SPADCALL |op| NIL (QREFELT $ 51))) $)) 

(SDEFUN |ODEPRIM;UPfact| ((|n| (|NonNegativeInteger|)) ($ (UP)))
        (SPROG
         ((#1=#:G741 NIL) (#2=#:G740 (UP)) (#3=#:G742 (UP)) (#4=#:G746 NIL)
          (#5=#:G739 NIL) (|i| NIL) (|z| (UP)))
         (SEQ
          (COND ((ZEROP |n|) (|spadConstant| $ 23))
                (#6='T
                 (SEQ
                  (LETT |z| (SPADCALL (|spadConstant| $ 22) 1 (QREFELT $ 25)))
                  (EXIT
                   (PROGN
                    (LETT #1# NIL)
                    (SEQ (LETT |i| 0)
                         (LETT #4#
                               (PROG1 (LETT #5# (- |n| 1))
                                 (|check_subtype2| (>= #5# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #5#)))
                         G190 (COND ((|greater_SI| |i| #4#) (GO G191)))
                         (SEQ
                          (EXIT
                           (PROGN
                            (LETT #3#
                                  (SPADCALL |z|
                                            (SPADCALL
                                             (SPADCALL |i| (QREFELT $ 62))
                                             (QREFELT $ 12))
                                            (QREFELT $ 26)))
                            (COND
                             (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 56))))
                             ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (COND (#1# #2#) (#6# (|spadConstant| $ 23))))))))))) 

(SDEFUN |ODEPRIM;indicialEq|
        ((|c| (UP)) (|lamb| (|List| (|NonNegativeInteger|))) (|lf| (|List| UP))
         ($ (UP)))
        (SPROG
         ((|s| (|SparseUnivariatePolynomial| UP)) (#1=#:G751 NIL) (|i| NIL)
          (#2=#:G752 NIL) (|f| NIL) (|cc| (|SparseUnivariatePolynomial| UP))
          (|cp| (UP)))
         (SEQ (LETT |cp| (SPADCALL (QREFELT $ 11) |c| (QREFELT $ 63)))
              (LETT |cc| (|ODEPRIM;UP2UP2| |c| $))
              (LETT |s| (|spadConstant| $ 64))
              (SEQ (LETT |f| NIL) (LETT #2# |lf|) (LETT |i| NIL)
                   (LETT #1# |lamb|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |f| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |s|
                           (SPADCALL |s|
                                     (SPADCALL (|ODEPRIM;UPfact| |i| $)
                                               (|ODEPRIM;UP2UP2|
                                                (|ODEPRIM;tau| |c| |cp| |f| |i|
                                                 $)
                                                $)
                                               (QREFELT $ 65))
                                     (QREFELT $ 66)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |cc| |s| (QREFELT $ 67)) (QREFELT $ 68)))))) 

(SDEFUN |ODEPRIM;NPmulambda|
        ((|c| (UP)) (|l| (L))
         ($
          (|Record| (|:| |mu| (|Integer|))
                    (|:| |lambda| (|List| (|NonNegativeInteger|)))
                    (|:| |func| (|List| UP)))))
        (SPROG
         ((|lf| (|List| UP)) (|lamb| (|List| #1=(|NonNegativeInteger|)))
          (|mup| #2=(|Integer|)) (|m| #2#) (|d| #1#) (|a| (UP)))
         (SEQ (LETT |lamb| (LIST (LETT |d| (SPADCALL |l| (QREFELT $ 69)))))
              (LETT |lf| (LIST (LETT |a| (SPADCALL |l| (QREFELT $ 17)))))
              (LETT |mup| (- |d| (SPADCALL |a| |c| (QREFELT $ 53))))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (LETT |l| (SPADCALL |l| (QREFELT $ 70)))
                                (|spadConstant| $ 37) (QREFELT $ 71)))
                     (GO G191)))
                   (SEQ (LETT |a| (SPADCALL |l| (QREFELT $ 17)))
                        (LETT |m|
                              (- (LETT |d| (SPADCALL |l| (QREFELT $ 69)))
                                 (SPADCALL |a| |c| (QREFELT $ 53))))
                        (EXIT
                         (COND
                          ((> |m| |mup|)
                           (SEQ (LETT |mup| |m|) (LETT |lamb| (LIST |d|))
                                (EXIT (LETT |lf| (LIST |a|)))))
                          ((EQL |m| |mup|)
                           (SEQ (LETT |lamb| (CONS |d| |lamb|))
                                (EXIT (LETT |lf| (CONS |a| |lf|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |mup| |lamb| |lf|))))) 

(SDEFUN |ODEPRIM;NPbound|
        ((|c| (UP)) (|l| (L)) (|e| (UP)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G767 NIL) (#2=#:G762 NIL) (|n| (|Integer|))
          (|rec|
           (|Record| (|:| |mu| (|Integer|))
                     (|:| |lambda| (|List| (|NonNegativeInteger|)))
                     (|:| |func| (|List| UP)))))
         (SEQ (LETT |rec| (|ODEPRIM;NPmulambda| |c| |l| $))
              (LETT |n|
                    (MAX 0
                         (-
                          (SPADCALL
                           (|ODEPRIM;indicialEq| |c| (QVELT |rec| 1)
                            (QVELT |rec| 2) $)
                           (QREFELT $ 73)))))
              (EXIT
               (COND
                ((SPADCALL |e| (QREFELT $ 74))
                 (PROG1 (LETT #2# |n|)
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#)))
                ('T
                 (PROG1
                     (LETT #1#
                           (MAX |n|
                                (- (SPADCALL |e| |c| (QREFELT $ 53))
                                   (QVELT |rec| 0))))
                   (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #1#)))))))) 

(SDEFUN |ODEPRIM;hdenom| ((|l| (L)) (|d| (UP)) (|e| (UP)) ($ (UP)))
        (SPROG
         ((#1=#:G781 NIL) (#2=#:G780 (UP)) (#3=#:G782 (UP)) (#4=#:G784 NIL)
          (|dd| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |dd| NIL)
                (LETT #4#
                      (SPADCALL
                       (SPADCALL |d| (SPADCALL |l| (QREFELT $ 76))
                                 (QREFELT $ 79))
                       (QREFELT $ 83)))
                G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |dd| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (QVELT |dd| 1)
                                   (|ODEPRIM;NPbound| (QVELT |dd| 1) |l| |e| $)
                                   (QREFELT $ 52)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 56))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 23))))))) 

(SDEFUN |ODEPRIM;denom0|
        ((|n| (|Integer|)) (|l| (L)) (|d| (UP)) (|e| (UP)) (|h| (UP)) ($ (UP)))
        (SPROG
         ((#1=#:G787 NIL) (#2=#:G786 (UP)) (#3=#:G788 (UP)) (#4=#:G790 NIL)
          (#5=#:G792 NIL) (|hh| NIL))
         (SEQ
          (SPADCALL (|ODEPRIM;hdenom| |l| |d| |e| $)
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |hh| NIL)
                          (LETT #5#
                                (SPADCALL (SPADCALL |h| |e| (QREFELT $ 84))
                                          (QREFELT $ 83)))
                          G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |hh| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #3#
                                   (SPADCALL (QVELT |hh| 1)
                                             (PROG1
                                                 (LETT #4#
                                                       (MAX 0
                                                            (-
                                                             (SPADCALL |e|
                                                                       (QVELT
                                                                        |hh| 1)
                                                                       (QREFELT
                                                                        $ 53))
                                                             |n|)))
                                               (|check_subtype2| (>= #4# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #4#))
                                             (QREFELT $ 52)))
                             (COND
                              (#1#
                               (LETT #2# (SPADCALL #2# #3# (QREFELT $ 56))))
                              ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T (|spadConstant| $ 23))))
                    (QREFELT $ 56))))) 

(SDEFUN |ODEPRIM;separateZeros| ((|d| (UP)) (|e| (UP)) ($ (UP)))
        (SPROG ((#1=#:G794 NIL) (|g| (UP)))
               (PROG2
                   (LETT #1#
                         (SPADCALL (LETT |g| (SPADCALL |e| (QREFELT $ 85)))
                                   (SPADCALL |g| (SPADCALL |d| (QREFELT $ 85))
                                             (QREFELT $ 86))
                                   (QREFELT $ 55)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                 (|Union| (QREFELT $ 7) "failed") #1#)))) 

(SDEFUN |ODEPRIM;indeq| ((|c| (UP)) (|l| (L)) ($ (UP)))
        (SPROG
         ((|rec|
           (|Record| (|:| |mu| (|Integer|))
                     (|:| |lambda| (|List| (|NonNegativeInteger|)))
                     (|:| |func| (|List| UP)))))
         (SEQ (LETT |rec| (|ODEPRIM;NPmulambda| |c| |l| $))
              (EXIT
               (|ODEPRIM;indicialEq| |c| (QVELT |rec| 1) (QVELT |rec| 2) $))))) 

(SDEFUN |ODEPRIM;indicialEquations;LUPL;17|
        ((|op| (L)) (|p| (UP))
         ($ (|List| (|Record| (|:| |center| UP) (|:| |equation| UP)))))
        (SPROG ((#1=#:G806 NIL) (|dd| NIL) (#2=#:G805 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |dd| NIL)
                      (LETT #1#
                            (SPADCALL
                             (SPADCALL |p| (SPADCALL |op| (QREFELT $ 76))
                                       (QREFELT $ 79))
                             (QREFELT $ 83)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |dd| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (CONS (QVELT |dd| 1)
                                     (|ODEPRIM;indeq| (QVELT |dd| 1) |op| $))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |ODEPRIM;denomLODE;LFU;18|
        ((|l| (L)) (|g| (|Fraction| UP)) ($ (|Union| UP "failed")))
        (SPROG ((|n| (|NonNegativeInteger|)) (|h| (UP)) (|e| (UP)) (|d| (UP)))
               (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 17)))
                    (EXIT
                     (COND
                      ((SPADCALL |g| (QREFELT $ 87))
                       (CONS 0
                             (|ODEPRIM;hdenom| |l| |d| (|spadConstant| $ 39)
                              $)))
                      (#1='T
                       (SEQ
                        (LETT |h|
                              (|ODEPRIM;separateZeros| |d|
                               (LETT |e| (SPADCALL |g| (QREFELT $ 88))) $))
                        (LETT |n| (SPADCALL |l| (QREFELT $ 69)))
                        (EXIT
                         (COND
                          ((QEQCAR
                            (SPADCALL |e|
                                      (SPADCALL |h| (+ |n| 1) (QREFELT $ 52))
                                      (QREFELT $ 55))
                            1)
                           (CONS 1 "failed"))
                          (#1#
                           (CONS 0
                                 (|ODEPRIM;denom0| |n| |l| |d| |e| |h|
                                  $)))))))))))) 

(SDEFUN |ODEPRIM;denomLODE;LLUP;19|
        ((|l| (L)) (|lg| (|List| (|Fraction| UP))) ($ (UP)))
        (SPROG
         ((|h| (UP)) (|e| (UP)) (#1=#:G820 NIL) (#2=#:G819 (UP))
          (#3=#:G821 (UP)) (#4=#:G825 NIL) (|g| NIL) (|d| (UP))
          (#5=#:G817 NIL))
         (SEQ
          (COND
           ((NULL |lg|)
            (PROG2
                (LETT #5# (SPADCALL |l| (|spadConstant| $ 91) (QREFELT $ 90)))
                (QCDR #5#)
              (|check_union2| (QEQCAR #5# 0) (QREFELT $ 7)
                              (|Union| (QREFELT $ 7) "failed") #5#)))
           (#6='T
            (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 17)))
                 (LETT |h|
                       (|ODEPRIM;separateZeros| |d|
                        (LETT |e|
                              (PROGN
                               (LETT #1# NIL)
                               (SEQ (LETT |g| NIL) (LETT #4# |lg|) G190
                                    (COND
                                     ((OR (ATOM #4#)
                                          (PROGN (LETT |g| (CAR #4#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #3# (SPADCALL |g| (QREFELT $ 88)))
                                       (COND
                                        (#1#
                                         (LETT #2#
                                               (SPADCALL #2# #3#
                                                         (QREFELT $ 92))))
                                        ('T
                                         (PROGN
                                          (LETT #2# #3#)
                                          (LETT #1# 'T)))))))
                                    (LETT #4# (CDR #4#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#1# #2#) (#6# (|spadConstant| $ 23)))))
                        $))
                 (EXIT
                  (|ODEPRIM;denom0| (SPADCALL |l| (QREFELT $ 69)) |l| |d| |e|
                   |h| $)))))))) 

(DECLAIM (NOTINLINE |PrimitiveRatDE;|)) 

(DEFUN |PrimitiveRatDE| (&REST #1=#:G826)
  (SPROG NIL
         (PROG (#2=#:G827)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PrimitiveRatDE|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PrimitiveRatDE;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PrimitiveRatDE|)))))))))) 

(DEFUN |PrimitiveRatDE;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|PrimitiveRatDE| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 94))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PrimitiveRatDE|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
    $))) 

(MAKEPROP '|PrimitiveRatDE| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . D) '|diff| (4 . |coerce|)
              (|SparseUnivariatePolynomial| 7) (|Mapping| 7 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 7 13) (9 . |map|)
              (15 . |leadingCoefficient|)
              (|Record| (|:| |center| 7) (|:| |equation| 7)) (|List| 18)
              |ODEPRIM;indicialEquations;LUPL;17|
              |ODEPRIM;indicialEquations;LL;2| (20 . |One|) (24 . |One|)
              (|NonNegativeInteger|) (28 . |monomial|) (34 . -)
              |ODEPRIM;indicialEquation;LFUP;3| (|List| 35)
              (40 . |coefficients|) (|Record| (|:| |num| 75) (|:| |den| 7))
              (|InnerCommonDenominator| 7 35 75 28) (45 . |splitDenominator|)
              (|List| $) (50 . |gcd|) (|Fraction| 7) (55 . /) (61 . |Zero|)
              (65 . |Zero|) (69 . |Zero|) (73 . |Zero|) (|Boolean|) (77 . ~=)
              (83 . |leadingCoefficient|) (88 . *) (94 . |retract|)
              (99 . |degree|) (104 . |monomial|) (110 . +) (116 . |reductum|)
              (|Record| (|:| |eq| 8) (|:| |rh| 28))
              |ODEPRIM;splitDenominator;LQLR;4| (121 . ^) (127 . |order|)
              (|Union| $ '"failed") (133 . |exquo|) (139 . *) (145 . |rem|)
              |ODEPRIM;indicialEquations;LQL;6|
              |ODEPRIM;indicialEquations;LQUPL;7|
              |ODEPRIM;indicialEquation;LQFUP;8| (|Integer|) (151 . |coerce|)
              (156 . |elt|) (162 . |Zero|) (166 . *) (172 . +)
              (178 . |resultant|) (184 . |primitivePart|) (189 . |degree|)
              (194 . |reductum|) (199 . ~=) (|BoundIntegerRoots| 6 7)
              (205 . |integerBound|) (210 . |zero?|) (|List| 7)
              (215 . |coefficients|) (|Factored| 7)
              (|BalancedFactorisation| 6 7) (220 . |balancedFactorisation|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 80) (|:| |factor| 7) (|:| |exponent| 24))
              (|List| 81) (226 . |factorList|) (231 . |balancedFactorisation|)
              (237 . |squareFreePart|) (242 . |gcd|) (248 . |zero?|)
              (253 . |denom|) (|Union| 7 '#1="failed")
              |ODEPRIM;denomLODE;LFU;18| (258 . |Zero|) (262 . |lcm|)
              |ODEPRIM;denomLODE;LLUP;19|)
           '#(|splitDenominator| 268 |indicialEquations| 274 |indicialEquation|
              296 |denomLODE| 308)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|denomLODE|
                                 ((|Union| |#2| #1#) |#3| (|Fraction| |#2|)))
                                T)
                              '((|denomLODE|
                                 (|#2| |#3| (|List| (|Fraction| |#2|))))
                                T)
                              '((|indicialEquations|
                                 ((|List|
                                   (|Record| (|:| |center| |#2|)
                                             (|:| |equation| |#2|)))
                                  |#3|))
                                T)
                              '((|indicialEquations|
                                 ((|List|
                                   (|Record| (|:| |center| |#2|)
                                             (|:| |equation| |#2|)))
                                  |#3| |#2|))
                                T)
                              '((|indicialEquation| (|#2| |#3| |#1|)) T)
                              '((|indicialEquations|
                                 ((|List|
                                   (|Record| (|:| |center| |#2|)
                                             (|:| |equation| |#2|)))
                                  |#4|))
                                T)
                              '((|indicialEquations|
                                 ((|List|
                                   (|Record| (|:| |center| |#2|)
                                             (|:| |equation| |#2|)))
                                  |#4| |#2|))
                                T)
                              '((|indicialEquation| (|#2| |#4| |#1|)) T)
                              '((|splitDenominator|
                                 ((|Record| (|:| |eq| |#3|)
                                            (|:| |rh|
                                                 (|List| (|Fraction| |#2|))))
                                  |#4| (|List| (|Fraction| |#2|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 93
                                            '(0 8 0 10 1 7 0 6 12 2 15 13 14 7
                                              16 1 8 7 0 17 0 6 0 22 0 7 0 23 2
                                              7 0 6 24 25 2 7 0 0 0 26 1 9 28 0
                                              29 1 31 30 28 32 1 7 0 33 34 2 35
                                              0 7 7 36 0 8 0 37 0 6 0 38 0 7 0
                                              39 0 9 0 40 2 9 41 0 0 42 1 9 35
                                              0 43 2 35 0 0 0 44 1 35 7 0 45 1
                                              9 24 0 46 2 8 0 7 24 47 2 8 0 0 0
                                              48 1 9 0 0 49 2 7 0 0 24 52 2 7
                                              24 0 0 53 2 7 54 0 0 55 2 7 0 0 0
                                              56 2 7 0 0 0 57 1 6 0 61 62 2 8 7
                                              0 7 63 0 13 0 64 2 13 0 7 0 65 2
                                              13 0 0 0 66 2 13 7 0 0 67 1 7 0 0
                                              68 1 8 24 0 69 1 8 0 0 70 2 8 41
                                              0 0 71 1 72 61 7 73 1 7 41 0 74 1
                                              8 75 0 76 2 78 77 7 75 79 1 77 82
                                              0 83 2 78 77 7 7 84 1 7 0 0 85 2
                                              7 0 0 0 86 1 35 41 0 87 1 35 7 0
                                              88 0 35 0 91 2 7 0 0 0 92 2 0 50
                                              9 28 51 2 0 19 8 7 20 1 0 19 8 21
                                              1 0 19 9 58 2 0 19 9 7 59 2 0 7 8
                                              6 27 2 0 7 9 6 60 2 0 7 8 28 93 2
                                              0 89 8 35 90)))))
           '|lookupComplete|)) 
